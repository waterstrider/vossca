#include "logwatcher.h"

LogWatcher::LogWatcher(QQuickItem *parent):
    QQuickItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()

    // setFlag(ItemHasContents, true);
//    m_source = QString::fromStdString("\\\\ccssrvnom1/ccs_results/2015_06_15T01_56_10_mcd_ccsmminom_REALTIME/TSEQ/ccsmminom/CcsClient/2015_06_15T01_56_36_301_syslog_002.txt");
//    ifs = new std::ifstream(m_source.toStdString().c_str());
//    if (ifs->is_open())
//    {
//        std::string line;
//        while (std::getline(*ifs, line)){
//           emit Logged(QString::fromStdString(line.substr(0,6)),QString::fromStdString(line.substr(6,9)),QString::fromStdString(line.substr(15,24)),QString::fromStdString(line.substr(39,24)),QString::fromStdString(line.substr(63)));
//        }
//    }
//    timer = new QTimer(this);
//    connect(timer, SIGNAL(timeout()), this, SLOT(checkLog()));
//    timer->start(1000);
}

void LogWatcher::checkLog()
{
    if (ifs->eof())// Ensure end of read was EOF.
                ifs->clear();
    std::string line;
    while (std::getline(*ifs, line)){
       emit Logged(QString::fromStdString(line.substr(0,6)),QString::fromStdString(line.substr(6,9)),QString::fromStdString(line.substr(15,24)),QString::fromStdString(line.substr(39,24)),QString::fromStdString(line.substr(63)));
    }
}

QString LogWatcher::source()const{
    return m_source;
}

void LogWatcher::setSource(const QString &source){
    m_source = source;
    ifs = new std::ifstream(m_source.toStdString().c_str());
    if (ifs->is_open())
    {
        std::string line;
        while (std::getline(*ifs, line)){
           emit Logged(QString::fromStdString(line.substr(0,6)),QString::fromStdString(line.substr(6,9)),QString::fromStdString(line.substr(15,24)),QString::fromStdString(line.substr(39,24)),QString::fromStdString(line.substr(63)));
        }
    }
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(checkLog()));
    timer->start(1000);
    emit sourceChanged();
}

LogWatcher::~LogWatcher()
{
}

