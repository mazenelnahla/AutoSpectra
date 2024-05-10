#include "cardatareceiver.h"
#include <QDebug>

CarDataReceiver::CarDataReceiver(QObject *parent) : QObject(parent) {
    udpSocket.bind(QHostAddress::Any, 12345);

    connect(&udpSocket, &QUdpSocket::readyRead, this, &CarDataReceiver::processPendingDatagrams);
}

void CarDataReceiver::processPendingDatagrams() {
    while (udpSocket.hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(udpSocket.pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        udpSocket.readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);

        QStringList dataList = QString(datagram).split('|');
        if (dataList.size() == 3) {
            CarData carData;
            carData.speed = dataList[0].toFloat();
            carData.gear = dataList[1].toInt();
            carData.steeringAngle = dataList[2].toFloat();
            qDebug() << "speed" << carData.speed;
            emit carDataReceived(carData);
        }
    }
}
