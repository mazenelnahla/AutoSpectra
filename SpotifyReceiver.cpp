#include "SpotifyReceiver.h"

SpotifyReceiver::SpotifyReceiver(QObject *parent) : QObject(parent)
{
    udpSocket.bind(QHostAddress::Any, 12345); // Adjust the port as needed

    connect(&udpSocket, &QUdpSocket::readyRead, this, &SpotifyReceiver::processPendingDatagrams);
}

void SpotifyReceiver::processPendingDatagrams()
{
    while (udpSocket.hasPendingDatagrams())
    {
        QByteArray datagram;
        datagram.resize(udpSocket.pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        udpSocket.readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);

        QStringList dataList = QString(datagram).split('|');
        if (dataList.size() == 4) {
            emit trackNameReceived(dataList[0]);
            emit artistNameReceived(dataList[1]);
            emit albumNameReceived(dataList[2]);
            emit albumImageUrlReceived(dataList[3]);
        }
    }
}
