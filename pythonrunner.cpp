#include "pythonrunner.h"
#include <QFileInfo>
#include <QDebug>
#include <QCoreApplication>
#include <QDir>

PythonRunner::PythonRunner(QObject *parent) : QObject(parent) {
    connect(&spotifyProcess, &QIODevice::readyRead, this, &PythonRunner::readSpotifyOutput);
    connect(&spotifyProcess, &QIODevice::readyRead, this, &PythonRunner::readSpotifyError);
    connect(&spotifyProcess, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished), this, &PythonRunner::processFinished);

    connect(&drowsinessDetectionProcess, &QIODevice::readyRead, this, &PythonRunner::readDrowsinessDetectionOutput);
    connect(&drowsinessDetectionProcess, &QIODevice::readyRead, this, &PythonRunner::readDrowsinessDetectionError);
    connect(&drowsinessDetectionProcess, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished), this, &PythonRunner::processFinished);
}

void PythonRunner::runSpotifyScript() {
    QString appDir = QCoreApplication::applicationDirPath();
    QString scriptRelativePath = QStringLiteral("../../Spotify.py");
    QString scriptPath = QDir(appDir).filePath(scriptRelativePath);

    QFileInfo fileInfo(scriptPath);
    QString absoluteScriptPath = fileInfo.absoluteFilePath();

    spotifyProcess.setWorkingDirectory(fileInfo.absolutePath());
    spotifyProcess.start("python", QStringList() << absoluteScriptPath);

    if (!spotifyProcess.waitForStarted()) {
        qDebug() << "Failed to start the Spotify script process:" << spotifyProcess.errorString();
        return;
    }
}

void PythonRunner::runDrowsinessDetectionScript() {
    QString appDir = QCoreApplication::applicationDirPath();
    QString scriptRelativePath = QStringLiteral("D:/GProject/Dashboard/Drowsiness_Detection-master/Drowsiness_Detection.py");
    QString scriptPath = QDir(appDir).filePath(scriptRelativePath);

    QFileInfo fileInfo(scriptPath);
    QString absoluteScriptPath = fileInfo.absoluteFilePath();
    drowsinessDetectionProcess.setWorkingDirectory(fileInfo.absolutePath());
    drowsinessDetectionProcess.start("python", QStringList() << absoluteScriptPath);

    if (!drowsinessDetectionProcess.waitForStarted()) {
        qDebug() << "Failed to start the Drowsiness Detection script process:" << drowsinessDetectionProcess.errorString();
        return;
    }
}

void PythonRunner::readSpotifyOutput() {
    QString output = spotifyProcess.readAllStandardOutput().simplified();
    emit pythonScriptOutput(output);
}

void PythonRunner::readDrowsinessDetectionOutput() {
    QString output = drowsinessDetectionProcess.readAllStandardOutput().simplified();
    qDebug() << "Drowsiness Detection script output:" << output;
    emit pythonScriptOutput(output);
}

void PythonRunner::readSpotifyError() {
    QString errorOutput = spotifyProcess.readAllStandardError().simplified();
    qDebug() << "Spotify script produced an error:" << errorOutput;
    emit pythonScriptError(errorOutput);
}

void PythonRunner::readDrowsinessDetectionError() {
    QString errorOutput = drowsinessDetectionProcess.readAllStandardError().simplified();
    qDebug() << "Drowsiness Detection script produced an error:" << errorOutput;
    emit pythonScriptError(errorOutput);
}

void PythonRunner::processFinished(int exitCode, QProcess::ExitStatus exitStatus) {
    if (exitCode != 0) {
        qDebug() << "Script exited with an error:" << exitCode;
    }

    qDebug() << "Script execution finished with exit code:" << exitCode;
}
