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
        if (dataList.size() == 2) {
            CarData carData;
            carData.sleepDetection = dataList[0].toFloat();
            qDebug() << "sleep Detection" << carData.sleepDetection;
            emit sleepStatusChanged(carData.sleepDetection);
        }
    }
}
