#include "cardatareceiver.h"
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QTimer>
#include "serialmanager.h"
QString AGear;
int autoPilotFlag;
int leftSignal;
int rightSignal;
CarDataReceiver::CarDataReceiver(QObject *parent) : QObject(parent)
{
    udpSocket.bind(QHostAddress::Any, 12344);
    connect(&udpSocket, &QUdpSocket::readyRead, this, &CarDataReceiver::processPendingDatagrams);

    // Setup the data timeout timer
    dataTimeoutTimer.setInterval(1000); // Set to desired timeout, e.g., 1 second
    dataTimeoutTimer.setSingleShot(true); // The timer will fire only once after the interval
    connect(&dataTimeoutTimer, &QTimer::timeout, this, &CarDataReceiver::checkForDataTimeout);
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
            bool handBrake = jsonObj["handBrake"].toBool();
            bool highBeam = jsonObj["highBeam"].toBool();
            bool adaptiveLights = jsonObj["adaptiveLights"].toBool();
            int blinkerSignal=jsonObj["blinkerSignal"].toInt();
            if(blinkerSignal==0){
                leftSignal = 0;
                rightSignal = 0;
            }else if (blinkerSignal==1){
                leftSignal = 0;
                rightSignal = 1;
            }else if (blinkerSignal==2){
                leftSignal = 1;
                rightSignal = 0;
            }
            bool warning = jsonObj["warning"].toBool();
            QString alart = jsonObj["alart"].toString();
            bool drowsinessDetection = jsonObj["sleep"].toBool();
            emit carlaJsonDataParsed(speed, alart, autoPilotFlag, AGear, leftSignal, rightSignal, false, handBrake, trafficSign, highBeam, adaptiveLights, drowsinessDetection);
            dataTimeoutTimer.start();
        }
    }
}
void CarDataReceiver::checkForDataTimeout()
{
    dataReceived = false;  // Reset the flag for the next interval
    if (!dataReceived) {
        autoPilotFlag = 0 ;
        emit noConnection(autoPilotFlag,!dataReceived);
    }
}
