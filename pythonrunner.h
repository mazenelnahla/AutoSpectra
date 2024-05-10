// pythonrunner.h
#ifndef PYTHONRUNNER_H
#define PYTHONRUNNER_H

#include <QObject>
#include <QString>

class PythonRunner : public QObject
{
    Q_OBJECT

public:
    explicit PythonRunner(QObject *parent = nullptr);

public slots:
    void runPythonScript();

signals:
    void pythonScriptOutput(const QString output) const;  // Added 'const' to the signal declaration
    void pythonScriptError(const QString error) const;    // Added a new signal for error output

};

#endif // PYTHONRUNNER_H
