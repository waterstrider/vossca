#ifndef LOGWATCHER_H
#define LOGWATCHER_H

#include <QQuickItem>
#include <QObject>
#include <fstream>
#include <QTimer>
class LogWatcher : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(LogWatcher)
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

signals:
    void Logged(const QString& sv,const QString& source,const QString& logTime,const QString& obt,const QString& message);
    void sourceChanged();

public:
    QString source()const;
    void setSource(const QString&);
    void checkLog();
    LogWatcher(QQuickItem *parent = 0);
    ~LogWatcher();
    QString m_source;
    std::ifstream *ifs;
    QTimer *timer;
};

#endif // LOGWATCHER_H

