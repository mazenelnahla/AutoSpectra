#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "serialmanager.h"
#include "pythonrunner.h"
#include "cardatareceiver.h"
#include <QThread>
#include <QCoreApplication>
#include "spotifyclient.h"
#include "fota.h"
#include "iphandler.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    qmlRegisterType<SerialManager>("com.company.serialmanager", 1, 0, "SerialManager" );
    qmlRegisterType<PythonRunner>("MyPythonScript", 1, 0, "PythonRunner");
    qmlRegisterType<CarDataReceiver>("com.company.cardatareceiver", 1, 0, "CarDataReceiver" );
    qmlRegisterType<SpotifyClient>("spotifyclient", 1, 0, "SpotifyClient");
    qmlRegisterType<Fota>("fota.backend", 1, 0, "FotaBackend" );


    QQmlApplicationEngine engine;

    IpHandler ipHandler;
    engine.rootContext()->setContextProperty("ipHandler", &ipHandler);

    SerialManager serialManager;
    engine.rootContext()->setContextProperty("serialManager", &serialManager);

    Fota fotaBackend;
    engine.rootContext()->setContextProperty("fota_back", &fotaBackend);

    SpotifyClient client;
    engine.rootContext()->setContextProperty("spotify", &client);

    PythonRunner pythonRunner;
    engine.rootContext()->setContextProperty("pythonRunner", &pythonRunner);

    CarDataReceiver carDataReceiver;
    engine.rootContext()->setContextProperty("carDataReceiver", &carDataReceiver);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl){
                QCoreApplication::exit(-1);
            }
        }, Qt::QueuedConnection);

    engine.load(url);


    client.updateCurrentTrack();

    // Connect the aboutToQuit signal to stop the update process
    QObject::connect(&app, &QCoreApplication::aboutToQuit, [&client]() {

        client.stopUpdate();
    });

    // Run the Python script when the QML component is completed
    PythonRunner runner;
    // runner.runSpotifyScript();
    // runner.runDrowsinessDetectionScript();

    return app.exec();
}
