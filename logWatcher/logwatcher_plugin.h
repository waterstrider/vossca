#ifndef LOGWATCHER_PLUGIN_H
#define LOGWATCHER_PLUGIN_H

#include <QQmlExtensionPlugin>

class LogWatcherPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // LOGWATCHER_PLUGIN_H

