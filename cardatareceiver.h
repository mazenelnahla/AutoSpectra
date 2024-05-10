#ifndef CARDATARECEIVER_H
#define CARDATARECEIVER_H

#include <QObject>
#include <QUdpSocket>

struct CarData {
    int sleepDetection;
    int carlaSpeed;
};

class CarDataReceiver : public QObject {
    Q_OBJECT
public:
    explicit CarDataReceiver(QObject *parent = nullptr);

signals:
    void carDataReceived(const CarData &data);
    void sleepStatusChanged(double sleepStatus);
    void carSpeed(double sCarla);

private slots:
    void processPendingDatagrams();

private:
    QUdpSocket udpSocket;
};

#endif // CARDATARECEIVER_H
