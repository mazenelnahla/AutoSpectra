#ifndef CARDATARECEIVER_H
#define CARDATARECEIVER_H

#include <QObject>
#include <QUdpSocket>
#include <QTimer>
extern QString AGear;
extern int autoPilotFlag;
class CarDataReceiver : public QObject {
    Q_OBJECT
public:
    explicit CarDataReceiver(QObject *parent = nullptr);

signals:
    void carlaJsonDataParsed(int speed,QString alart,int autoPilotFlag, QString AGear,int leftSignal,int rightSignal,bool warning,bool handBrake, QString trafficSign,bool highBeam, bool adaptiveLight, bool drowsinessDetection);
    void noConnection(int autoPilotFlag,bool warning);
private slots:
    void processPendingDatagrams();
    void checkForDataTimeout();

private:
    QUdpSocket udpSocket;
    QTimer dataTimeoutTimer;
    bool dataReceived = false;

};

#endif // CARDATARECEIVER_H
