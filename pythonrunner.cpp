// pythonrunner.cpp
#include "pythonrunner.h"
#include <QFileInfo>
#include <QDebug>

PythonRunner::PythonRunner(QObject *parent) : QObject(parent) {
    connect(&process, &QIODevice::readyRead, this, &PythonRunner::readStandardOutput);
    connect(&process, &QIODevice::readyRead, this, &PythonRunner::readStandardError);
    connect(&process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished), this, &PythonRunner::processFinished);
}

void PythonRunner::runPythonScript() {
    QString scriptPath = "D:/GProject/Dashboard/Drowsiness_Detection-master/Drowsiness_Detection.py";
    // Set working directory to the script's directory
    process.setWorkingDirectory(QFileInfo(scriptPath).absolutePath());

    process.start("python", QStringList() << scriptPath);
    if (!process.waitForStarted()) {
        qDebug() << "Failed to start the script process:" << process.errorString();
        return;
    }
}

void PythonRunner::readStandardOutput() {
    QString output = process.readAllStandardOutput().simplified();
    qDebug() << "Script output:" << output;
    emit pythonScriptOutput(output);
}

void PythonRunner::readStandardError() {
    QString errorOutput = process.readAllStandardError().simplified();
    qDebug() << "Script produced an error:" << errorOutput;
    emit pythonScriptError(errorOutput);
}

void PythonRunner::processFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    if (exitCode != 0) {
        qDebug() << "Script exited with an error:" << exitCode;
    }

    qDebug() << "Script execution finished with exit code:" << exitCode;
}
