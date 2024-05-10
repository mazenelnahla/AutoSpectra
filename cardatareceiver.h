#ifndef CARDATARECEIVER_H
#define CARDATARECEIVER_H

#include <QObject>
#include <QUdpSocket>

struct CarData {
    int sleepDetection;
};

class CarDataReceiver : public QObject {
    Q_OBJECT
public:
    explicit CarDataReceiver(QObject *parent = nullptr);

signals:
    void carDataReceived(const CarData &data);
    void sleepStatusChanged(double sleepStatus);

private slots:
    void processPendingDatagrams();

private:
    QUdpSocket udpSocket;
};

#endif // CARDATARECEIVER_H
