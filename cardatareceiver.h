#ifndef CARDATARECEIVER_H
#define CARDATARECEIVER_H

#include <QObject>
#include <QUdpSocket>
extern QString AGear;
extern int autoPilotFlag;
class CarDataReceiver : public QObject {
    Q_OBJECT
public:
    explicit CarDataReceiver(QObject *parent = nullptr);

signals:
    void carlaJsonDataParsed(int speed,QString alart,int autoPilotFlag, QString AGear,int leftSignal,int rightSignal,bool warning,int handBrake, QString trafficSign,int highBeam, int adaptiveLight, bool drowsinessDetection);

private slots:
    void processPendingDatagrams();

private:
    QUdpSocket udpSocket;
};

#endif // CARDATARECEIVER_H
