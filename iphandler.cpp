#include "iphandler.h"
#include <QDebug>

IpHandler::IpHandler(QObject *parent) : QObject(parent)
{
}

QString IpHandler::getWifiIPAddress()
{
    QStringList wifiInterfaceNames = { "wlan0", "wlp", "wl", "en0", "WiFi" };  // WiFi names to check

    // qDebug() << "Listing all available network interfaces:";
    // foreach (const QNetworkInterface &interface, QNetworkInterface::allInterfaces()) {
    //     qDebug() << "Interface Name:" << interface.humanReadableName();
    //     foreach (const QNetworkAddressEntry &entry, interface.addressEntries()) {
    //         if (entry.ip().protocol() == QAbstractSocket::IPv4Protocol) {
    //             qDebug() << "  IPv4 Address:" << entry.ip().toString();
    //         }
    //     }
    // }

    // Now try to match the WiFi interface
    foreach (const QNetworkInterface &interface, QNetworkInterface::allInterfaces()) {
        // Check if this interface is up and running, and not a loopback interface
        if (interface.flags().testFlag(QNetworkInterface::IsUp) &&
            interface.flags().testFlag(QNetworkInterface::IsRunning) &&
            !interface.flags().testFlag(QNetworkInterface::IsLoopBack)) {

            // Match the WiFi interface name from the known WiFi interface names
            for (const QString &wifiName : wifiInterfaceNames) {
                if (interface.humanReadableName().startsWith(wifiName)) {
                    foreach (const QNetworkAddressEntry &entry, interface.addressEntries()) {
                        if (entry.ip().protocol() == QAbstractSocket::IPv4Protocol) {
                            QString ip = entry.ip().toString();
                            qDebug() << "WiFi Interface:" << interface.humanReadableName() << "IP Address:" << ip;
                            return ip;
                        }
                    }
                }
            }
        }
    }

    qDebug() << "No WiFi IP found";
    return QString("No WiFi IP found");
}
