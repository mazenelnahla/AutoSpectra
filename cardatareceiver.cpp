#include "cardatareceiver.h"
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include "serialmanager.h"
QString AGear;
int autoPilotFlag;
CarDataReceiver::CarDataReceiver(QObject *parent) : QObject(parent)
{
    udpSocket.bind(QHostAddress::Any, 12344);
    connect(&udpSocket, &QUdpSocket::readyRead, this, &CarDataReceiver::processPendingDatagrams);
}

void CarDataReceiver::processPendingDatagrams()
{
    while(udpSocket.hasPendingDatagrams()){
        QByteArray datagram;
        datagram.resize(udpSocket.pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        udpSocket.readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);

        QJsonParseError jsonError;
        QJsonDocument jsonDoc = QJsonDocument::fromJson(datagram, &jsonError);
        if(jsonError.error != QJsonParseError::NoError){
            qDebug() << "Error decoding JSON data:" << jsonError.errorString();
            continue;
        }
        if(jsonDoc.isObject()){
            QJsonObject jsonObj = jsonDoc.object();

            autoPilotFlag = jsonObj["autoPilot"].toInt();
            double speed = jsonObj["speed"].toDouble();
            QString trafficSign = jsonObj["trafficSign"].toString();
            int autoGear = jsonObj["gear"].toInt();
            if(autoGear == 0){
                AGear = "N";
            } else if(autoGear == 1){
                AGear = "D";
            } else if(autoGear == -1){
                AGear = "R";
            }
            int handBrake = jsonObj["handBrake"].toInt();
            int highBeam = jsonObj["highBeam"].toInt();
            int adaptiveLights = jsonObj["adaptiveLights"].toInt();
            int leftSignal = jsonObj["leftBlink"].toInt();
            int rightSignal = jsonObj["rightBlink"].toInt();
            bool warning = jsonObj["warning"].toBool();
            QString alart = jsonObj["alart"].toString();
            bool drowsinessDetection = jsonObj["sleep"].toBool();

            emit carlaJsonDataParsed(speed, alart, autoPilotFlag, AGear, leftSignal, rightSignal, warning, handBrake, trafficSign, highBeam, adaptiveLights, drowsinessDetection);
        }
    }
}
