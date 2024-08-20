#ifndef FOTA_H
#define FOTA_H

#include <QObject>
#include <QUdpSocket>

class Fota: public QObject
{
    Q_OBJECT
public:
    explicit Fota(QObject *parent = nullptr);

signals:
    void fotaInfo(QString currentVersion ,QString newVersion ,QString description ,int updateFlag ,int totalFileSize , int sentSize, int indexUpdate);

public slots:
    void processPendingDatagrams();

private:
    QUdpSocket udpSocket;
};

#endif // FOTA_H
