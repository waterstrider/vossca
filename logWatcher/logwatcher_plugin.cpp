#include "logwatcher_plugin.h"
#include "logwatcher.h"

#include <qqml.h>

void LogWatcherPlugin::registerTypes(const char *uri)
{
    // @uri LogWatcher
    qmlRegisterType<LogWatcher>(uri, 1, 0, "LogWatcher");
}


