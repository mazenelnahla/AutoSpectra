#include "spotifyclient.h"
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonArray>
#include <QUrl>
#include <QDateTime>
#include <QDebug>
#include <QTextStream>
#include <QProcess>
#include <QThread>
#include <QTimer>
#include <QFile>
#include <QStandardPaths>
#include <QDir>
#include <QUrlQuery>
#include <QTcpSocket>

// Spotify Credentials
static const QString clientId = "3fb73f276ec048b78eff8151cee5563c";
static const QString clientSecret = "e8d229b5cc704e4d9c29bbd62957f93d";
static const QString redirectUri = "http://autospectra/spotify_auth.php"; // Replace with Pi's actual IP
static const QString scope = "user-read-currently-playing user-modify-playback-state user-read-playback-state";
static const QString tokenFilePath = QDir::current().filePath("spotify_tokens.json");

// ===== OAuthServer Implementation =====

OAuthServer::OAuthServer(QObject *parent) : QTcpServer(parent)
{
    // No additional initialization required
}

void OAuthServer::incomingConnection(qintptr socketDescriptor) {
    QTcpSocket *socket = new QTcpSocket(this);

    if (!socket->setSocketDescriptor(socketDescriptor)) {
        qWarning() << "Failed to set socket descriptor:" << socket->errorString();
        socket->deleteLater();
        return;
    }

    connect(socket, &QTcpSocket::readyRead, this, [this, socket]() {
        QByteArray data = socket->readAll();
        QString authCode = QString::fromUtf8(data).trimmed();  // Convert to QString and trim any whitespace
        qDebug() << "Authorization Code received:" << authCode;

        // Emit the signal with the authorization code
        emit this->authorizationReceived(authCode);

        // Close the socket
        socket->disconnectFromHost();
        socket->deleteLater();

        // Close the server after receiving the code
        this->close();
    });
}


// ===== SpotifyClient Implementation =====

SpotifyClient::SpotifyClient(QObject *parent) : QObject(parent)
{
    updateTimer = new QTimer(this);

    // Initialize QNetworkAccessManager
    networkManager = new QNetworkAccessManager(this);

    // Connect the networkAccessibleChanged signal to your slot
    connect(networkManager, &QNetworkAccessManager::networkAccessibleChanged,
            this, &SpotifyClient::onNetworkAccessibleChanged);

    // Perform an initial network accessibility check
    QNetworkAccessManager::NetworkAccessibility accessible = networkManager->networkAccessible();
    isConnected = (accessible == QNetworkAccessManager::Accessible);

    if (isConnected) {
        // Start updating current track
        updateCurrentTrack();
    }
}

SpotifyClient::~SpotifyClient()
{
    if (oauthServer && oauthServer->isListening()) {
        oauthServer->close();
    }
}

void SpotifyClient::onNetworkAccessibleChanged(QNetworkAccessManager::NetworkAccessibility accessible)
{
    bool wasConnected = isConnected;
    isConnected = (accessible == QNetworkAccessManager::Accessible);

    emit isConnectedChanged(isConnected);

    if (isConnected && !wasConnected)
    {
        // Network just became accessible
        if (!updateTimer->isActive())
        {
            updateCurrentTrack();
        }
    }
    else if (!isConnected && wasConnected)
    {
        // Network just became inaccessible
        stopUpdate();
    }
}

QString SpotifyClient::getAuthorizationCode() {
    QString authUrl = QString("https://accounts.spotify.com/authorize?response_type=code&client_id=%1&scope=%2&redirect_uri=%3")
                          .arg(clientId, scope, redirectUri);

    // Start the OAuth server to listen for the redirect
    oauthServer = new OAuthServer(this);
    connect(oauthServer, &OAuthServer::authorizationReceived, this, &SpotifyClient::handleAuthorizationReceived);

    if (!oauthServer->listen(QHostAddress::Any, 8888)) {
        qCritical() << "Failed to start OAuth server:" << oauthServer->errorString();
        return QString();
    }

    qDebug() << "Listening for authorization code on port 8888...";

    return QString(); // Authorization code will be handled asynchronously
}

void SpotifyClient::handleAuthorizationReceived(const QString &code) {
    qDebug() << "Authorization code received:" << code;
    QJsonObject tokenInfo = getAccessToken(code);
    // Proceed with updating the current track is handled in getAccessToken's finished slot
}

QJsonObject SpotifyClient::getAccessToken(const QString &authCodeParam) { // Renamed parameter
    QNetworkRequest request(QUrl("https://accounts.spotify.com/api/token"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QByteArray data;
    data.append("grant_type=authorization_code&");
    data.append("code=" + QUrl::toPercentEncoding(authCodeParam) + "&"); // Use authCodeParam
    data.append("redirect_uri=" + QUrl::toPercentEncoding(redirectUri) + "&");
    data.append("client_id=" + QUrl::toPercentEncoding(clientId) + "&");
    data.append("client_secret=" + QUrl::toPercentEncoding(clientSecret));

    QNetworkReply *reply = networkManager->post(request, data);
    connect(reply, &QNetworkReply::finished, this, [this, reply, authCodeParam]() { // Capture authCodeParam
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray response = reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
            QJsonObject tokenInfo = jsonResponse.object();
            tokenInfo["expires_at"] = QDateTime::currentSecsSinceEpoch() + tokenInfo["expires_in"].toInt();
            token = tokenInfo["access_token"].toString();
            qDebug() << "Access Token:" << tokenInfo["access_token"].toString();
            qDebug() << "Refresh Token:" << tokenInfo["refresh_token"].toString();
            saveTokens(tokenInfo["access_token"].toString(), tokenInfo["refresh_token"].toString());
            reply->deleteLater();
            // Start updating the current track
            updateCurrentTrack();
        } else {
            qWarning() << "Error in getting access token:" << reply->errorString();
            reply->deleteLater();
        }
    });

    return QJsonObject();
}

void SpotifyClient::saveTokens(const QString &accessToken, const QString &refreshTokenParam) { // Renamed parameter
    QFile file(tokenFilePath);

    if (!file.open(QIODevice::WriteOnly)) {
        qWarning() << "Could not open token file for writing.";
        return;
    }

    QJsonObject jsonObj;
    jsonObj["access_token"] = accessToken;
    jsonObj["refresh_token"] = refreshTokenParam; // Use refreshTokenParam
    jsonObj["expires_at"] = QDateTime::currentSecsSinceEpoch() + 3600; // Example: Token expires in 1 hour

    QJsonDocument jsonDoc(jsonObj);
    file.write(jsonDoc.toJson());
    file.close();
}

QString SpotifyClient::readAccessToken() {
    QFile file(tokenFilePath);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Could not open token file for reading.";
        emit authenticationStatusChanged(false);
        file.close();
        return QString();
    }
    QByteArray data = file.readAll();
    file.close();

    QJsonDocument jsonDoc = QJsonDocument::fromJson(data);
    if (jsonDoc.isNull() || !jsonDoc.isObject()) {
        emit authenticationStatusChanged(false);
        qWarning() << "Invalid token file format.";
        return QString();
    }
    QJsonObject jsonObj = jsonDoc.object();
    token = jsonObj["access_token"].toString();
    refreshToken = jsonObj["refresh_token"].toString();
    qint64 expiresAt = jsonObj["expires_at"].toVariant().toLongLong();

    if (QDateTime::currentSecsSinceEpoch() > expiresAt) {
        token = refreshAccessToken(refreshToken); // Use member variable
    }
    emit authenticationStatusChanged(true);
    return token;
}

QString SpotifyClient::refreshAccessToken(const QString &refreshTokenParam) { // Renamed parameter
    QNetworkRequest request(QUrl("https://accounts.spotify.com/api/token"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QByteArray data;
    data.append("grant_type=refresh_token&");
    data.append("refresh_token=" + QUrl::toPercentEncoding(refreshTokenParam) + "&"); // Use refreshTokenParam
    data.append("client_id=" + QUrl::toPercentEncoding(clientId) + "&");
    data.append("client_secret=" + QUrl::toPercentEncoding(clientSecret));

    QNetworkReply *reply = networkManager->post(request, data);
    connect(reply, &QNetworkReply::finished, this, [this, reply, refreshTokenParam]() { // Capture refreshTokenParam
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray response = reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
            QJsonObject tokenInfo = jsonResponse.object();
            tokenInfo["expires_at"] = QDateTime::currentSecsSinceEpoch() + tokenInfo["expires_in"].toInt();
            token = tokenInfo["access_token"].toString();
            qDebug() << "Access Token Refreshed:" << token;
            saveTokens(token, refreshTokenParam); // Use refreshTokenParam
            reply->deleteLater();
            emit authenticationStatusChanged(true);
            // Continue with application logic if needed
        } else {
            emit authenticationStatusChanged(false);
            qWarning() << "Error refreshing access token:" << reply->errorString();
            reply->deleteLater();
        }
    });

    return QString();
}

QJsonObject SpotifyClient::getCurrentTrack(const QString &token) {
    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/currently-playing"));
    request.setRawHeader("Authorization", QString("Bearer %1").arg(token).toUtf8());

    QNetworkReply *reply = networkManager->get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        QByteArray response = reply->readAll();

        if (reply->error() != QNetworkReply::NoError) {
            qWarning() << "Error in getting current track:" << reply->errorString();
            qWarning() << "API Response:" << response;
            isConnected = false;
            emit isConnectedChanged(isConnected);
            stopUpdate();
            reply->deleteLater();
            return;
        }

        // If we reach here, the network is connected
        if (!isConnected) {
            isConnected = true;
            emit isConnectedChanged(isConnected);
        }

        QJsonDocument jsonResponse = QJsonDocument::fromJson(response);
        QJsonObject currentTrack = jsonResponse.object();
        reply->deleteLater();

        QJsonObject jsonData;
        if (!currentTrack.isEmpty() && currentTrack.contains("item")) {
            QJsonObject trackInfo = currentTrack["item"].toObject();
            int durationMs = trackInfo["duration_ms"].toInt();
            int progressMs = currentTrack["progress_ms"].toInt();
            // Format time
            int minutes_currentTime = static_cast<int>(progressMs / 1000) / 60;
            int seconds_currentTime = static_cast<int>(progressMs / 1000) % 60;
            QString currentTimeformatted = QString("%1:%2").arg(minutes_currentTime, 2, 10, QChar('0')).arg(seconds_currentTime, 2, 10, QChar('0'));
            int minutes_duration = static_cast<int>(durationMs / 1000) / 60;
            int seconds_duration = static_cast<int>(durationMs / 1000) % 60;
            QString durationformatted = QString("%1:%2").arg(minutes_duration, 2, 10, QChar('0')).arg(seconds_duration, 2, 10, QChar('0'));
            jsonData = {
                {"trackName", trackInfo["name"].toString()},
                {"artistName", trackInfo["artists"].toArray().first().toObject()["name"].toString()},
                {"albumName", trackInfo["album"].toObject()["name"].toString()},
                {"albumURL", trackInfo["album"].toObject()["images"].toArray().first().toObject()["url"].toString()},
                {"isPlaying", currentTrack["is_playing"].toBool()},
                {"currentTime", progressMs},
                {"duration", durationMs}
            };

            // Emit the signal with the data
            emit spotifyReceivedData(
                trackInfo["name"].toString(),
                trackInfo["artists"].toArray().first().toObject()["name"].toString(),
                trackInfo["album"].toObject()["name"].toString(),
                trackInfo["album"].toObject()["images"].toArray().first().toObject()["url"].toString(),
                currentTrack["is_playing"].toBool(),
                progressMs,
                durationMs,
                currentTimeformatted,
                durationformatted
                );
        } else {
            jsonData = {
                {"trackName", ""},
                {"artistName", ""},
                {"albumName", ""},
                {"albumURL", ""},
                {"isPlaying", false},
                {"currentTime", 0},
                {"duration", 0}
            };

            // Emit the signal with no song information
            emit spotifyReceivedData("", "", "", "", false, 0, 0, "00:00", "00:00");
        }
    });

    return QJsonObject();
}

void SpotifyClient::updateCurrentTrack() {
    qDebug() << "Token File Path:" << tokenFilePath;
    connect(updateTimer, &QTimer::timeout, this, [=]() {
        QString token = readAccessToken();
        if (token.isEmpty()) {
            qDebug() << "No access token available. Initiating authorization...";
            getAuthorizationCode();
            return;
        }
        getCurrentTrack(token);
    });
    updateTimer->start(1000); // Update every 10 seconds, adjust as needed
}

void SpotifyClient::stopUpdate()
{
    if (updateTimer->isActive()) {
        updateTimer->stop();
    }
}

void SpotifyClient::pause() {
    QString token = readAccessToken();
    if (token.isEmpty()) return;

    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/pause"));
    request.setRawHeader("Authorization", QString("Bearer %1").arg(token).toUtf8());

    QNetworkReply *reply = networkManager->put(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() != QNetworkReply::NoError) {
            qWarning() << "Error in pausing playback:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void SpotifyClient::play() {
    QString token = readAccessToken();
    if (token.isEmpty()) return;

    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/play"));
    request.setRawHeader("Authorization", QString("Bearer %1").arg(token).toUtf8());

    QNetworkReply *reply = networkManager->put(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() != QNetworkReply::NoError) {
            qWarning() << "Error in resuming playback:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void SpotifyClient::nextTrack() {
    QString token = readAccessToken();
    if (token.isEmpty()) return;

    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/next"));
    request.setRawHeader("Authorization", QString("Bearer %1").arg(token).toUtf8());

    QNetworkReply *reply = networkManager->post(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() != QNetworkReply::NoError) {
            qWarning() << "Error in skipping to next track:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

void SpotifyClient::previousTrack() {
    QString token = readAccessToken();
    if (token.isEmpty()) return;

    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/previous"));
    request.setRawHeader("Authorization", QString("Bearer %1").arg(token).toUtf8());

    QNetworkReply *reply = networkManager->post(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() != QNetworkReply::NoError) {
            qWarning() << "Error in skipping to previous track:" << reply->errorString();
        }
        reply->deleteLater();
    });
}
