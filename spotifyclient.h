#ifndef SPOTIFYCLIENT_H
#define SPOTIFYCLIENT_H

#include <QObject>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QTimer>
#include <QTcpServer>

class QTcpSocket; // Forward declaration

class OAuthServer : public QTcpServer {
    Q_OBJECT
public:
    explicit OAuthServer(QObject *parent = nullptr);

signals:
    void authorizationReceived(const QString &code);

protected:
    void incomingConnection(qintptr socketDescriptor) override;
};

class SpotifyClient : public QObject {
    Q_OBJECT
public:
    explicit SpotifyClient(QObject *parent = nullptr);
    ~SpotifyClient();

    Q_INVOKABLE void updateCurrentTrack();
    Q_INVOKABLE void stopUpdate();
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void nextTrack();
    Q_INVOKABLE void previousTrack();

signals:
    void spotifyReceivedData(
        const QString &trackName,
        const QString &artistName,
        const QString &albumName,
        const QString &albumImgUrl,
        bool isPlaying,
        double currentTime,
        double duration,
        const QString &currentTimeFormatted,
        const QString &durationFormatted
        );
    void isConnectedChanged(bool isConnected);

private slots:
    void onNetworkAccessibleChanged(QNetworkAccessManager::NetworkAccessibility accessible);
    void handleAuthorizationReceived(const QString &code); // Slot to handle received code

private:
    bool isConnected;
    QTimer *updateTimer;
    QString token;
    QString refreshToken;

    QString getAuthorizationCode();
    QJsonObject getAccessToken(const QString &authCode);
    QString readAccessToken();
    QString refreshAccessToken(const QString &refreshTokenParam); // Renamed parameter
    QJsonObject getCurrentTrack(const QString &token);
    void saveTokens(const QString &accessToken, const QString &refreshToken);

    QNetworkAccessManager *networkManager;
    OAuthServer *oauthServer; // Pointer to OAuthServer instance
};

#endif // SPOTIFYCLIENT_H
