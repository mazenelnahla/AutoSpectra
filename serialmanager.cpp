#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>
#include "serialmanager.h"
#include "cardatareceiver.h"
int temperature;

int sendPort=13345;

using namespace std;
int carlaGear;
SerialManager::SerialManager(QObject *parent)
    : QObject(parent)
{
    udpSocket.bind(QHostAddress::Any, sendPort); // Use appropriate port number
    bool m_serial_is_available = false;
    QString m_serial_uno_port_name;
    //  For each available serial port
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
        //  check if the serialport has both a product identifier and a vendor identifier
        if(serialPortInfo.hasProductIdentifier() && serialPortInfo.hasVendorIdentifier()){
            //  check if the product ID and the vendor ID match those of the m_serial uno
            if((serialPortInfo.productIdentifier() == m_serial_uno_product_id)
                && (serialPortInfo.vendorIdentifier() == m_serial_uno_vendor_id)){
                m_serial_is_available = true; //    m_serial uno is available on this port
                m_serial_uno_port_name = serialPortInfo.portName();
            }
        }else{
            m_serial_is_available = true;
            m_serial_uno_port_name="/dev/ttyAMA0";
        }
    }

    if(m_serial_is_available){
        qDebug() << "Found the m_serial port...\n";
        qDebug() << m_serial_uno_port_name;
        m_serial.setPortName(m_serial_uno_port_name);
        m_serial.open(QSerialPort::ReadWrite);
        m_serial.setBaudRate(QSerialPort::Baud9600);
        m_serial.setDataBits(QSerialPort::Data8);
        m_serial.setFlowControl(QSerialPort::NoFlowControl);
        m_serial.setParity(QSerialPort::NoParity);
        m_serial.setStopBits(QSerialPort::OneStop);
        connect(&m_serial, SIGNAL(readyRead()), this, SLOT(readSerial()));
    }else{
        qDebug() << "Couldn't find the correct port for the m_serial.\n";
    }

}


SerialManager::~SerialManager()
{
    // If serial port is open close it
    if( m_serial.isOpen() )
    {
        m_serial.close();
    }
    udpSocket.close();
}

void SerialManager::readSerial()
{
    static QByteArray receivedData;

    while (m_serial.canReadLine())
    {
        if (autoPilotFlag==(1)) {
            m_serial.write("A"); // Example command for enabling autopilot
            m_serial.flush();
            sendGearCommand(AGear);
        }else{
            m_serial.write("M"); // Example command for disabling autopilot
            m_serial.flush();
        }
        QByteArray data = m_serial.readLine();
        receivedData.append(data);
        if (data.endsWith('\n'))
        {
            // Parse the received JSON object
            QJsonParseError jsonError;
            QJsonDocument jsonDoc = QJsonDocument::fromJson(receivedData, &jsonError);
            if (jsonError.error != QJsonParseError::NoError)
            {
                qDebug() << "Failed to parse JSON data:" << jsonError.errorString();
            }
            else if (jsonDoc.isObject())
            {

                QJsonObject jsonObj = jsonDoc.object();
                temperature = jsonObj["temperature"].toInt();
                int humidity = jsonObj["humidity"].toInt();
                int door = jsonObj["door"].toInt();
                QString gear = jsonObj["gear"].toString();
                sendGearOverUDP(gear);
                emit jsonDataParsed(temperature, humidity, door, gear);
                //                qDebug() << "Temperature:" << temperature;
                //                qDebug() << "Humidity:" << humidity;
                //                qDebug() << "Door:" << door;
                // qDebug() << "Gear:" << gear;

            }

            // Reset receivedData for the next JSON object
            receivedData.clear();
        }

    }

}

// void SerialManager::sendGearOverUDP(const QString &gear)
// {
//     // Create a JSON object to hold the gear information
//     QJsonObject json;

//     if (gear == "P") {
//         carlaGear = -2;
//     } else if (gear == "N") {
//         carlaGear = 0;
//     } else if (gear == "D") {
//         carlaGear = 1;
//     } else if (gear == "R") {
//         carlaGear = -1;
//     }
//     json["gear"] = carlaGear;
//     json["temp"] = temperature;
//     // Create a JSON document from the JSON object
//     QJsonDocument jsonDoc(json);

//     // Convert the JSON document to bytes
//     QByteArray jsonData = jsonDoc.toJson();
//     // Send the JSON data over UDP
//     udpSocket.writeDatagram(jsonData, QHostAddress("192.168.1.15"), 12346); // Replace with the IP and port of the Python PC
// }

void SerialManager::sendGearOverUDP(const QString &gear)
{
    // Static variables to store the previous values
    static int previousCarlaGear = -99; // Initial value different from any possible gear
    static int previousTemperature = -99; // Initial value different from any possible temperature

    // Map gear to corresponding values
    int carlaGear = 0;
    if (gear == "P") {
        carlaGear = -2;
    } else if (gear == "N") {
        carlaGear = 0;
    } else if (gear == "D") {
        carlaGear = 1;
    } else if (gear == "R") {
        carlaGear = -1;
    }

    // Only send data if gear or temperature has changed
    if (carlaGear != previousCarlaGear || temperature != previousTemperature) {
        // Update the previous values
        previousCarlaGear = carlaGear;
        previousTemperature = temperature;

        // Create a JSON object to hold the gear information
        QJsonObject json;
        json["gear"] = carlaGear;
        json["temp"] = temperature;

        // Create a JSON document from the JSON object
        QJsonDocument jsonDoc(json);

        // Convert the JSON document to bytes
        QByteArray jsonData = jsonDoc.toJson();

        // Send the JSON data over UDP
        udpSocket.writeDatagram(jsonData, QHostAddress("192.168.1.15"), 12346); // Replace with the IP and port of the Python PC
    }
}


void SerialManager::sendAutopilotCommand(bool enable)
{
    // Send appropriate command based on autopilotFlag
    if (enable) {
        m_serial.flush();
        m_serial.write("A"); // Example command for enabling autopilot
        m_serial.flush();
        sendGearCommand(AGear);
    } else {
        m_serial.flush();
        m_serial.write("M"); // Example command for disabling autopilot
        m_serial.flush();
    }
}


void SerialManager::sendGearCommand(const QString &gear)
{
    m_serial.write(gear.toLocal8Bit());
    m_serial.flush();
}
