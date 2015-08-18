import QtQuick 2.3
import Database 0.1

Item {
    id: container
    property var dbListByDate: ({

                                })
    property var dbListByName: ({

                                })
    property var cachedCcsTmDatabases: ({

                                        })
    property var cachedCcsTmDatabaseList: []
    property int ccsTmDatabaseCachedSize: 10
    property int snapshotInterval: 10000
    property var paramListString: ["'STATES_3'", "'STATES_2'", "'STATES_1'", "'SUCARR2LOK'", "'SUCARR1LOK'", "'SCARR2LOCK'", "'SCARR1LOCK'", "'SGSTTCTCEST'", "'SGSTTCTCULKS'", "'SGSTTCIFMCS'", "'SGSTTCSTATUS'", "'SGSTTCTMUBFS'", "'SGSTTCIFR3PL'", "'SGSTTCIFR2PL'", "'SGSTTCIFR3BS'", "'SGSTTCIFR2BS'", "'SGSTTCIFR3IF'", "'SGSTTCIFR2IF'", "'DOPPLER_MEASURE'", "'MCSLINKST'", "'SGSMCSMODE'", "'TT_NUMBER'", "'MPQ_STATE_2'", "'MPQ_STATE_1'", "'MPQ_FREE_ENTRIES_2'", "'MPQ_FREE_ENTRIES_1'", "'MP_BUFFER_STATE'", "'RECEIVED_TC_COUNTER'", "'REJECTED_TC_COUNTER'", "'ERROR_EVENT_RECORDED'", "'ERROR_EVENT_OCCURED'", "'MESSAGE_REPORT_RECORDED'", "'MESSAGE_REPORT_OCCURED'", "'NORMAL_EVENT_RECORDED'", "'NORMAL_EVENT_OCCURED'", "'WAIT_FLAG'", "'FEE_NO_BIT_LOCK'", "'FEE_NO_RF_AVAILABLE'", "'FEE_LOCKOUT'", "'RETRANSMIT_FLAG'", "'F_RETRANSMIT'", "'FRAMEA'", "'FEEREPORT_VALUE'", "'F_STATE'", "'AUS2_PLCNT'", "'APLAC'", "'FAR2_AUANA'", "'LAST_TC_TSSR_SAUTHACT'", "'TMSTATUS'", "'AUTHMOD'", "'SERVMOD'", "'GAUERR'", "'GAUCON'", "'TMRLINKSTATUS'", "'TMLINKSTATUS'", "'FEEERR'", "'FEECON'", "'BUS_VOLTAGE'", "'BATTERY_CURRENT'", "'DEPTH_OF_DISCHARGE'", "'TOTAL_ANGULAR_MOMENTUM_1'", "'TOTAL_ANGULAR_MOMENTUM_2'", "'TOTAL_ANGULAR_MOMENTUM_3'", "'SIPUPAFPAB'", "'SIPUPAFPAA'", "'IPU_EQPT_STATE_A'", "'SIPUMSFPAB'", "'SIPUMSFPAA'", "'REFERENCE_WEIGHT'", "'SGPSB'", "'SGPSA'", "'GPS_F_STATE'", "'MTQ_EQPT_EXTERNAL_STATE_B'", "'MTQ_EQPT_EXTERNAL_STATE_A'", "'MTQ_F_STATE'", "'CSS_EQPT_EXTERNAL_STATE_B'", "'CSS_EQPT_EXTERNAL_STATE_A'", "'CSS_F_STATE'", "'THR_EQPT_OBJECT_STATE_B'", "'THR_EQPT_OBJECT_STATE_A'", "'THR_FUNC_OBJECT_STATE'", "'RW_EQPT_EXTERNAL_STATE_RW4'", "'RW_EQPT_EXTERNAL_STATE_RW3'", "'RW_EQPT_EXTERNAL_STATE_RW2'", "'RW_EQPT_EXTERNAL_STATE_RW1'", "'RW_F_STATE'", "'POW_FUNC_SELECTED_EQPT'", "'POW_FUNC_OBJECT_STATE'", "'TMI_FUNC_SELECTED_EQPT'", "'TMI_EQPT_OBJECT_STATE_A'", "'THERMAL_SELECTED_EQPT'", "'THERMAL_OBJECT_STATE'", "'MAG_EQPT_EXTERNAL_STATE_B'", "'MAG_EQPT_EXTERNAL_STATE_A'", "'MAG_F_STATE'", "'IPU_F_SELECTED_EQPT'", "'IPU_F_EXTERNAL_STATE'", "'SEL_CONTROLLER'", "'SSR_EQPT_EXTERNAL_STATE'", "'SIRUB'", "'SIRUA'", "'IRU_F_STATE'", "'SSSTB'", "'SSSTA'", "'STR_F_STATE'", "'SREMTWTAB'", "'SREMTWTAA'", "'SQPSKB'", "'SQPSKA'", "'TMI_EQPT_OBJECT_STATE_B'", "'TMI_FUNC_FAILED_FLAG'", "'TMI_FUNC_SELECTED_IOC'", "'TMI_FUNC_EXTERNAL_STATE'", "'SSR_VC2_A'", "'SSR_VC1_A'", "'CHANNEL_CONF_VIDEO_OUT'", "'SSSRMSDDTA'", "'SSSRPADDTA'", "'SSR_MS_A'", "'SSR_PAN_A'", "'CHANNEL_CONF_MS_IN'", "'CHANNEL_CONF_PAN_IN'", "'SMB0ESCECB'", "'SMB0ESCECA'", "'SMA1ESCECB'", "'SMA1ESCECA'", "'SMA0ESCECB'", "'SMA0ESCECA'", "'MEM_BANK_STATES_B0'", "'MEM_BANK_STATES_A1'", "'MEM_BANK_STATES_A0'", "'MEM_BOARD_STATE_CG'", "'MEM_BOARD_STATE_BF'", "'MEM_BOARD_STATE_AE'", "'SSR_EQPT_OBJECT_STATE'", "'SSR_EQPT_FAILED_FLAG'", "'V5DIGIPUB'", "'V5DIGIPUA'", "'V5COMPIPUB'", "'V5COMPIPUA'", "'PO_A'", "'IPU_F_FAILED_FLAG'", "'POWHEATBUS'", "'CONSISTENCY_FAILURE'", "'THERMAL_FAILED_FLAG'", "'ISGB'", "'ISGA'", "'CAPACITY'", "'POWERSAT'", "'FEM'", "'POWERBAT'", "'POWERSG'", "'POW_CTRL_OBJECT_STATE'", "'OPER_CTRL_OBJECT_STATE'", "'AOCS_IAE_FAILED_FLAG'", "'AOCS_IAE_SUBSTATE'", "'NAV_FAILED_FLAG'", "'AOCS_IAE_STATE'", "'OCM_MGR_STATE'", "'NAV_STATE'", "'ASH_MODE_MGR_STATE'", "'NM_MGR_STATE'", "'AOCS_MGR_STATE'", "'PATCH_COUNTER'", "'DWELL_STATE'", "'SPY_STATE'", "'SCRUBBING_STATE'", "'PPS_SOURCE'", "'PPS_STATE'", "'R1_KSWALARM'", "'R1_KWDERROR'", "'R1_KRTSVPMA'", "'IO_BOARD_STATE_6'", "'R0_KMODE'", "'IO_BOARD_STATE_5'", "'IO_BOARD_STATE_3'", "'IO_BOARD_STATE_4'", "'IO_BOARD_STATE_2'", "'IO_BOARD_STATE_1'", "'SBCR_VPM_IDENTIFIER'", "'RTC_MODE'", "'PDM_MGR_OBJECT_STATE'", "'SYST_MGR_OBJECT_STATE'", "'R1_KARO'"]
    property var paramList: ['STATES_3', 'STATES_2', 'STATES_1', 'SUCARR2LOK', 'SUCARR1LOK', 'SCARR2LOCK', 'SCARR1LOCK', 'SGSTTCTCEST', 'SGSTTCTCULKS', 'SGSTTCIFMCS', 'SGSTTCSTATUS', 'SGSTTCTMUBFS', 'SGSTTCIFR3PL', 'SGSTTCIFR2PL', 'SGSTTCIFR3BS', 'SGSTTCIFR2BS', 'SGSTTCIFR3IF', 'SGSTTCIFR2IF', 'DOPPLER_MEASURE', 'MCSLINKST', 'SGSMCSMODE', 'TT_NUMBER', 'MPQ_STATE_2', 'MPQ_STATE_1', 'MPQ_FREE_ENTRIES_2', 'MPQ_FREE_ENTRIES_1', 'MP_BUFFER_STATE', 'RECEIVED_TC_COUNTER', 'REJECTED_TC_COUNTER', 'ERROR_EVENT_RECORDED', 'ERROR_EVENT_OCCURED', 'MESSAGE_REPORT_RECORDED', 'MESSAGE_REPORT_OCCURED', 'NORMAL_EVENT_RECORDED', 'NORMAL_EVENT_OCCURED', 'WAIT_FLAG', 'FEE_NO_BIT_LOCK', 'FEE_NO_RF_AVAILABLE', 'FEE_LOCKOUT', 'RETRANSMIT_FLAG', 'F_RETRANSMIT', 'FRAMEA', 'FEEREPORT_VALUE', 'F_STATE', 'AUS2_PLCNT', 'APLAC', 'FAR2_AUANA', 'LAST_TC_TSSR_SAUTHACT', 'TMSTATUS', 'AUTHMOD', 'SERVMOD', 'GAUERR', 'GAUCON', 'TMRLINKSTATUS', 'TMLINKSTATUS', 'FEEERR', 'FEECON', 'BUS_VOLTAGE', 'BATTERY_CURRENT', 'DEPTH_OF_DISCHARGE', 'TOTAL_ANGULAR_MOMENTUM_1', 'TOTAL_ANGULAR_MOMENTUM_2', 'TOTAL_ANGULAR_MOMENTUM_3', 'SIPUPAFPAB', 'SIPUPAFPAA', 'IPU_EQPT_STATE_A', 'SIPUMSFPAB', 'SIPUMSFPAA', 'REFERENCE_WEIGHT', 'SGPSB', 'SGPSA', 'GPS_F_STATE', 'MTQ_EQPT_EXTERNAL_STATE_B', 'MTQ_EQPT_EXTERNAL_STATE_A', 'MTQ_F_STATE', 'CSS_EQPT_EXTERNAL_STATE_B', 'CSS_EQPT_EXTERNAL_STATE_A', 'CSS_F_STATE', 'THR_EQPT_OBJECT_STATE_B', 'THR_EQPT_OBJECT_STATE_A', 'THR_FUNC_OBJECT_STATE', 'RW_EQPT_EXTERNAL_STATE_RW4', 'RW_EQPT_EXTERNAL_STATE_RW3', 'RW_EQPT_EXTERNAL_STATE_RW2', 'RW_EQPT_EXTERNAL_STATE_RW1', 'RW_F_STATE', 'POW_FUNC_SELECTED_EQPT', 'POW_FUNC_OBJECT_STATE', 'TMI_FUNC_SELECTED_EQPT', 'TMI_EQPT_OBJECT_STATE_A', 'THERMAL_SELECTED_EQPT', 'THERMAL_OBJECT_STATE', 'MAG_EQPT_EXTERNAL_STATE_B', 'MAG_EQPT_EXTERNAL_STATE_A', 'MAG_F_STATE', 'IPU_F_SELECTED_EQPT', 'IPU_F_EXTERNAL_STATE', 'SEL_CONTROLLER', 'SSR_EQPT_EXTERNAL_STATE', 'SIRUB', 'SIRUA', 'IRU_F_STATE', 'SSSTB', 'SSSTA', 'STR_F_STATE', 'SREMTWTAB', 'SREMTWTAA', 'SQPSKB', 'SQPSKA', 'TMI_EQPT_OBJECT_STATE_B', 'TMI_FUNC_FAILED_FLAG', 'TMI_FUNC_SELECTED_IOC', 'TMI_FUNC_EXTERNAL_STATE', 'SSR_VC2_A', 'SSR_VC1_A', 'CHANNEL_CONF_VIDEO_OUT', 'SSSRMSDDTA', 'SSSRPADDTA', 'SSR_MS_A', 'SSR_PAN_A', 'CHANNEL_CONF_MS_IN', 'CHANNEL_CONF_PAN_IN', 'SMB0ESCECB', 'SMB0ESCECA', 'SMA1ESCECB', 'SMA1ESCECA', 'SMA0ESCECB', 'SMA0ESCECA', 'MEM_BANK_STATES_B0', 'MEM_BANK_STATES_A1', 'MEM_BANK_STATES_A0', 'MEM_BOARD_STATE_CG', 'MEM_BOARD_STATE_BF', 'MEM_BOARD_STATE_AE', 'SSR_EQPT_OBJECT_STATE', 'SSR_EQPT_FAILED_FLAG', 'V5DIGIPUB', 'V5DIGIPUA', 'V5COMPIPUB', 'V5COMPIPUA', 'PO_A', 'IPU_F_FAILED_FLAG', 'POWHEATBUS', 'CONSISTENCY_FAILURE', 'THERMAL_FAILED_FLAG', 'ISGB', 'ISGA', 'CAPACITY', 'POWERSAT', 'FEM', 'POWERBAT', 'POWERSG', 'POW_CTRL_OBJECT_STATE', 'OPER_CTRL_OBJECT_STATE', 'AOCS_IAE_FAILED_FLAG', 'AOCS_IAE_SUBSTATE', 'NAV_FAILED_FLAG', 'AOCS_IAE_STATE', 'OCM_MGR_STATE', 'NAV_STATE', 'ASH_MODE_MGR_STATE', 'NM_MGR_STATE', 'AOCS_MGR_STATE', 'PATCH_COUNTER', 'DWELL_STATE', 'SPY_STATE', 'SCRUBBING_STATE', 'PPS_SOURCE', 'PPS_STATE', 'R1_KSWALARM', 'R1_KWDERROR', 'R1_KRTSVPMA', 'IO_BOARD_STATE_6', 'R0_KMODE', 'IO_BOARD_STATE_5', 'IO_BOARD_STATE_3', 'IO_BOARD_STATE_4', 'IO_BOARD_STATE_2', 'IO_BOARD_STATE_1', 'SBCR_VPM_IDENTIFIER', 'RTC_MODE', 'PDM_MGR_OBJECT_STATE', 'SYST_MGR_OBJECT_STATE', 'R1_KARO']

    //property string hostName: "localhost"
    property string hostName: "192.168.142.172"
    property string userName: "ccsuser"
    property string password: "leiden1"
    property string urlCountdown: "http://192.168.142.226/api/get_passes.xml"

    Database {
        id: ccsDbList
        connectionName: Date.now()
        type: "QMYSQL"
        databaseName: "INFORMATION_SCHEMA"
        hostName: container.hostName
        userName: container.userName
        password: container.password
        SqlModel {
            id: sqlDbList
            query: "SHOW DATABASES LIKE '2%'"
            onCountChanged: {
                fetchDatabaseList()
            }
        }
    }

    function fetchDatabaseList() {
        var num = sqlDbList.count
        var listByDate = {

        }
        var listByName = {

        }
        for (var i = 0; i < num; i++) {
            var dbName = sqlDbList.get(i)["Database (2%)"]
            var a = dbName.replace("t", "_").split("_")
            var yy = Number(a[0])
            var mm = Number(a[1]) - 1
            var dd = Number(a[2])
            var date = new Date(Date.UTC(yy, mm, dd, a[3], a[4], a[5]))
            var dbInfo = {
                name: dbName,
                date: date,
                user: a[6],
                workstation: a[7],
                sessionType: a[8]
            }
            listByName[dbName] = dbInfo
            if ([yy, mm, dd] in listByDate)
                listByDate[[yy, mm, dd]].push(dbInfo)
            else
                listByDate[[yy, mm, dd]] = [dbInfo]
        }
        dbListByName = listByName
        dbListByDate = listByDate
    }

    function getDbList(yy, mm, dd) {
        if ([yy, mm, dd] in dbListByDate)
            return dbListByDate[[yy, mm, dd]]
        else
            return []
    }

    function getDbInfo(sessionName) {
        if (sessionName in dbListByName)
            return dbListByName[sessionName]
        else
            return null
    }

    function getCcsTmDatabase(dbName) {
        if ((dbName in cachedCcsTmDatabases)
                && cachedCcsTmDatabases[dbName] != null)
            return cachedCcsTmDatabases[dbName]
        else {
            if (cachedCcsTmDatabaseList.length > ccsTmDatabaseCachedSize) {
                var removedDbName = cachedCcsTmDatabaseList.shift()
                cachedCcsTmDatabaseList[removedDbName] = null
            }
            cachedCcsTmDatabaseList.push(dbName)

            for (var i = 0; i < cachedCcsTmDatabaseList.length; i++)
                console.log("Cached Database:" + i + " : " + cachedCcsTmDatabaseList[i])

            var comp = Qt.createComponent("CcsTmDatabase.qml")
            cachedCcsTmDatabases[dbName] = comp.createObject(null, {
                                                                 context: container,
                                                                 databaseName: dbName,
                                                                 type: "QMYSQL",
                                                                 hostName: container.hostName,
                                                                 userName: container.userName,
                                                                 password: container.password
                                                             })
            if (!cachedCcsTmDatabases[dbName])
                console.log("Error creating the TM database object for " + dbName)

            return cachedCcsTmDatabases[dbName]
        }
    }

    function getCcsTcDatabase(dbName) {
        if (dbName == undefined || dbName == null) {
            fetchDatabaseList()
            //Find the name of the most recent database
            var dbName = ""
            for (var key in dbListByName) {
                if (key > dbName)
                    dbName = key
            }
            if (dbName == "")
                return null
            console.log("Get TC Database: " + dbName)
            console.log("Get HOST NAME: " + container.hostName)
            console.log("Get TC USER: " + container.userName)
            console.log("Get TC PASSWORD: " + container.password)
        }

        var comp = Qt.createComponent("CcsTcDatabase.qml")
        var ccsTcDatabase = comp.createObject(null, {
                                                  context: container,
                                                  databaseName: dbName,
                                                  type: "QMYSQL",
                                                  hostName: container.hostName,
                                                  userName: container.userName,
                                                  password: container.password
                                              })
        if (!ccsTcDatabase)
            console.log("Error creating the TC database object for " + dbName)

        return ccsTcDatabase
    }
}
