#ifndef CARDATARECEIVER_H
#define CARDATARECEIVER_H

#include <QObject>
#include <QUdpSocket>

struct CarData {
    float speed;
    int gear;
    float steeringAngle;
};

class CarDataReceiver : public QObject {
    Q_OBJECT
public:
    explicit CarDataReceiver(QObject *parent = nullptr);

signals:
    void carDataReceived(const CarData &data);

private slots:
    void processPendingDatagrams();

private:
    QUdpSocket udpSocket;
};

#endif // CARDATARECEIVER_H
