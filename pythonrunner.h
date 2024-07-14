#ifndef PYTHONRUNNER_H
#define PYTHONRUNNER_H

#include <QObject>
#include <QString>
#include <QProcess>

class PythonRunner : public QObject
{
    Q_OBJECT

public:
    explicit PythonRunner(QObject *parent = nullptr);

public slots:
    void runSpotifyScript();
    void runDrowsinessDetectionScript();

signals:
    void pythonScriptOutput(const QString output);
    void pythonScriptError(const QString error);

private slots:
    void readSpotifyOutput();
    void readSpotifyError();
    void readDrowsinessDetectionOutput();
    void readDrowsinessDetectionError();
    void processFinished(int exitCode, QProcess::ExitStatus exitStatus);

private:
    QProcess spotifyProcess;
    QProcess drowsinessDetectionProcess;
};

#endif // PYTHONRUNNER_H
