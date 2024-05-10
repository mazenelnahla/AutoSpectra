// pythonrunner.cpp
#include "pythonrunner.h"
#include <QProcess>
#include <QFileInfo>
#include <QDebug>

PythonRunner::PythonRunner(QObject *parent) : QObject(parent) {}

void PythonRunner::runPythonScript()
{
    QProcess process;
    QString scriptPath = "D:/Desktop/GProject/Dashboard/0.QT/AV-Cluster/mscript.py";
    // Set working directory to the script's directory
    process.setWorkingDirectory(QFileInfo(scriptPath).absolutePath());

    process.start("python", QStringList() << scriptPath);
    if (!process.waitForStarted()) {
        qDebug() << "Failed to start the script process:" << process.errorString();
        return;
    }

    if (!process.waitForFinished(-1)) {
        qDebug() << "Error occurred during script execution:" << process.errorString();
        return;
    }

    if (process.exitCode() != 0) {
        qDebug() << "Script exited with an error:" << process.exitCode();
    }

    QString output = process.readAllStandardOutput().simplified();
    QString errorOutput = process.readAllStandardError().simplified();

    if (!errorOutput.isEmpty()) {
        qDebug() << "Script produced an error:" << errorOutput;
    }

    qDebug() << "Script output:" << output;

    emit pythonScriptOutput(output);
    emit pythonScriptError(errorOutput);
}
