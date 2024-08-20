#include "fota.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>

Fota::Fota(QObject *parent) : QObject(parent)
{
    udpSocket.bind(QHostAddress::Any, 12456); // Adjust the port as needed

    connect(&udpSocket, &QUdpSocket::readyRead, this, &Fota::processPendingDatagrams);
}

void Fota::processPendingDatagrams() {
    while (udpSocket.hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(udpSocket.pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        udpSocket.readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);

        // Decode the received data as a JSON object
        QJsonParseError jsonError;
        QJsonDocument jsonDoc = QJsonDocument::fromJson(datagram, &jsonError);
        if (jsonError.error != QJsonParseError::NoError) {
            qDebug() << "Error decoding JSON data:" << jsonError.errorString();
            continue;
        }
        if (jsonDoc.isObject()) {
            QJsonObject jsonObj = jsonDoc.object();
            QString currentVersion=jsonObj["currentVersion"].toString();
            QString newVersion=jsonObj["newVersion"].toString();
            QString description=jsonObj["description"].toString();

            int updateFlag=jsonObj["updateFlag"].toInt();
            int totalFileSize=jsonObj["totalFileSize"].toInt();
            int sentSize=jsonObj["sentSize"].toInt();
            int indexUpdate=jsonObj["indexUpdate"].toInt();
            emit fotaInfo(currentVersion, newVersion, description, updateFlag, totalFileSize , sentSize, indexUpdate);
            qDebug()<<"currentVersion: "<<currentVersion;
            qDebug()<<"newVersion: "<<newVersion;
            qDebug()<<"description: "<<description;
            qDebug()<<"updateFlag: "<<updateFlag;
            qDebug()<<"totalFileSize: "<<totalFileSize;
            qDebug()<<"sentSize: "<<sentSize;
            qDebug()<<"indexUpdate: "<<indexUpdate;
        }
    }
}
