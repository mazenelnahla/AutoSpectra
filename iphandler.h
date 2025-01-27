#ifndef IPHANDLER_H
#define IPHANDLER_H

#include <QObject>
#include <QNetworkInterface>

class IpHandler : public QObject
{
    Q_OBJECT
public:
    explicit IpHandler(QObject *parent = nullptr);

    Q_INVOKABLE QString getWifiIPAddress();
};

#endif // IPHANDLER_H
