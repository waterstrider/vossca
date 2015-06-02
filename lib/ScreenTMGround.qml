import QtQuick 2.0

Rectangle {
    id: container
    property var window
    property var model
    property bool replayMode: false
    property real scaleFactor: Math.min(container.width/page.width,container.height/page.height)

    width: 1920; height: 1080
    color: "black"

    Component.onDestruction: {
        console.log("Ground status screen to be destructed");
    }

    Rectangle {
        anchors.fill: parent
        scale: scaleFactor
        color: "black"
        Item {
            id:page
            width: 1920
            height: 1080
            anchors.centerIn: parent

            Image {
                id: imgBackground
                source:"images/bgScreenTMGround.png"
                width: 1920; height: 1080

// ***** Column 1, Row 1, Link Status
                WidgetParamStatus {
                    x: 120; y: 115
                    width: 120; height: 15
                    label: "TC LINK"
                    param: model.param("FEECON")
                    statusColors: {"":"gray",
                            "TC_SESSION_ON":"blue",
                            "TC_SESSION_OFF":"yellow"
                        }
                }

                WidgetParamStatus {
                    x: 120; y: 135
                    width: 120; height: 15
                    label: "TC ERR"
                    param: model.param("FEEERR")
                    statusColors: {"":"gray",
                            "NONE":"blue",
                            "BROKEN":"yellow",
                            "LINK_TIMEOUT":"yellow",
                            "WRITE_TIMEOUT":"yellow",
                            "BAD_EXCH":"yellow",
                            "SELF_TST_NOK":"yellow",
                            "CONFIG_FILE":"yellow",
                            "SILENT":"yellow",
                            "NAK":"yellow",
                            "UNK_MSG":"yellow",
                            "CHECK_ERR":"yellow",
                            "PROTO_ERR":"yellow",
                            "POST_ERR":"yellow",
                            "READ_TIMEOUT":"yellow",
                            "READ_ERR":"yellow",
                            "UNK_SIZE":"yellow",
                            "PRE_ERR":"yellow",
                            "WRT_ERR":"yellow",
                            "UNK_ACK":"yellow",
                            "UNK_FLOW":"yellow"
                        }
                }

                WidgetParamStatus {
                    x: 120; y: 155
                    width: 120; height: 15
                    label: "TM LINK"
                    param: model.param("TMLINKSTATUS")
                    statusColors: {"":"gray",
                            "CLOSED":"yellow",
                            "OPEN":"blue",
                            "BROKEN":"orange"
                        }
                }

                WidgetParamStatus {
                    x: 120; y: 175
                    width: 120; height: 15
                    label: "TMR LINK"
                    param: model.param("TMRLINKSTATUS")
                    statusColors: {"":"gray",
                            "CLOSED":"yellow",
                            "OPEN":"blue",
                            "BROKEN":"orange"
                        }
                }

                WidgetParamStatus {
                    x: 120; y: 195
                    width: 120; height: 15
                    label: "GAU LINK"
                    param: model.param("GAUCON")
                    statusColors: {"":"gray",
                            "CLOSED":"yellow",
                            "OPEN":"blue",
                            "BROKEN":"orange"
                        }
                }

                WidgetParamStatus {
                    x: 120; y: 215
                    width: 120; height: 15
                    label: "GAU ERR"
                    param: model.param("GAUERR")
                    statusColors: {"":"gray",
                            "NONE":"blue",
                            "WRITE_E":"orange",
                            "READ_E":"orange",
                            "DATA":"orange",
                            "NOTUSED":"orange",
                            "CONFIG":"orange"
                        }
                }

                WidgetParamStatus {
                    x: 340; y: 135
                    width: 120; height: 15
                    label: "TC MODE"
                    param: model.param("SERVMOD")
                    statusColors: {"":"gray",
                                   "EXPE":"yellow",
                                   "CTRL":"blue"
                    }
                }

                WidgetParamStatus {
                    x: 340; y: 155
                    width: 120; height: 15
                    label: "TC AUTH"
                    param: model.param("AUTHMOD")
                    statusColors: {"":"gray",
                                   "CLEAR":"yellow",
                                   "AUTH":"blue"
                    }
                }

                WidgetParamStatus {
                    x: 340; y: 175
                    width: 120; height: 15
                    label: "TC STATUS"
                    param: model.param("TMSTATUS")
                    statusColors: {"":"gray",
                            "DROP":"yellow",
                            "NOK":"yellow",
                            "OK":"blue",
                            "OVERFLOW":"yellow",
                            "CLOSE":"yellow",
                            "BROKEN":"orange"
                        }
                }

                WidgetParamStatus {
                    x: 340; y: 195
                    width: 120; height: 15
                    label: "LAST AUTH"
                    param: model.param("LAST_TC_TSSR_SAUTHACT")
                    statusColors: {"":"gray",
                                   "ACTIVE":"blue",
                                   "INACTIVE":"yellow"
                    }
                }

                WidgetParamStatus {
                    x: 340; y: 215
                    width: 120; height: 15
                    label: "FAR2 AUTH"
                    param: model.param("FAR2_AUANA")
                    statusColors: {"":"gray",
                            "COLD START":"silver",
                            "DATA SEG OK":"green",
                            "AU CMD OK":"yellow",
                            "AU DUMMY OK":"yellow",
                            "ERR SIGNATURE":"orange",
                            "ERR LAC":"orange",
                            "ERR AU FORMAT":"orange",
                            "ERR SEG LENGTH":"orange"
                        }
                }

                WidgetLabel {
                    x: 60; y: 236
                    text: "PRINCIPAL LAC"
                }

                WidgetParamStatusNumeric {
                    x: 120; y: 258
                    width: 75; height: 15
                    label: "SAT"
                    param: model.param("AUS2_PLCNT")
                    precision: 0
                    min: 0; max: 100
                    minNorm: 0; maxNorm: 100
                    statusColors: {"":"gray",
                                   "NORMAL":"blue",
                                   "NOT_NORMAL":"orange",
                                   "OUT_OF_RANGE":"red"
                    }
                }

                WidgetParamStatusNumeric {
                    x: 120; y: 278
                    width: 75; height: 15
                    label: "GROUND"
                    param: model.param("APLAC")
                    precision: 0
                    min: 0; max: 100
                    minNorm: 0; maxNorm: 100
                    statusColors: {"":"gray",
                                   "NORMAL":"blue",
                                   "NOT_NORMAL":"orange",
                                   "OUT_OF_RANGE":"red"
                    }
                }

                WidgetParamCompare {
                    x: 190; y: 240
                    param1: model.param("AUS2_PLCNT")
                    min1: 0; max1: 100
                    param2: model.param("APLAC")
                    min2: 0; max2: 100
                }
				
//// ***** Column 1, Row 2, COP Acknowledge

                WidgetParamStatus {
                    x: 120; y: 355
                    width: 120; height: 15
                    label: "COP"
                    param: model.param("F_STATE")
                    statusColors: {"":"gray",
                            "NONE":"gray",
                            "ACTIVE":"blue",
                            "RETRANS_WAIT":"orange",
                            "RETRANS_NO_WAIT":"orange",
                            "INIT_WITH_CLCW":"yellow",
                            "INIT_WITH_BC":"yellow",
                            "INITIAL":"silver"
                        }
                }

                WidgetParamStatusNumeric {
                    x: 120; y: 380
                    width: 120; height: 15
                    label: "REPORT"
                    param: model.param("FEEREPORT_VALUE")
                    precision: 0
                    min: 0; max: 256
                    minNorm: 0; maxNorm: 256
                    statusColors: {"":"gray",
                                   "NORMAL":"blue",
                                   "NOT_NORMAL":"orange",
                                   "OUT_OF_RANGE":"red"
                    }
                }          
                WidgetParamHLevel {
                    x: 120; y: 405
                    param: model.param("FEEREPORT_VALUE")
                    min: 0; max: 256
                }
                WidgetParamHLevel {
                    x: 120; y: 430
                    param: model.param("FRAMEA")
                    min: 0; max: 256
                }

                WidgetParamStatusNumeric {
                    x: 120; y: 455
                    width: 120; height: 15
                    label: "AD VCID A"
                    param: model.param("FRAMEA")
                    precision: 0
                    min: 0; max: 256
                    minNorm: 0; maxNorm: 256
                    statusColors: {"":"gray",
                                   "NORMAL":"blue",
                                   "NOT_NORMAL":"orange",
                                   "OUT_OF_RANGE":"red"
                    }
                }

                WidgetParamStatus {
                    x: 340; y: 355
                    width: 120; height: 15
                    label: "FARM RE"
                    param: model.param("F_RETRANSMIT")
                    statusColors: {"": "gray",
                            "NO_RETRANSMIT": "blue",
                            "RETRANSMIT": "yellow"
                        }
                }

                WidgetParamStatus {
                    x: 340; y: 375
                    width: 120; height: 15
                    label: "RE FLAG"
                    param: model.param("RETRANSMIT_FLAG")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "yellow"
                        }
                }

                WidgetParamStatus {
                    x: 340; y: 395
                    width: 120; height: 15
                    label: "LOCKOUT"
                    param: model.param("FEE_LOCKOUT")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "yellow"
                        }
                }

                WidgetParamStatus {
                    x: 340; y: 415
                    width: 120; height: 15
                    label: "NO RF AVB"
                    param: model.param("FEE_NO_RF_AVAILABLE")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "yellow"
                        }
                }

                WidgetParamStatus {
                    x: 340; y: 435
                    width: 120; height: 15
                    label: "NO BIT LK"
                    param: model.param("FEE_NO_BIT_LOCK")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "yellow"
                        }
                }

                WidgetParamStatus {
                    x: 340; y: 455
                    width: 120; height: 15
                    label: "WAIT FLAG"
                    param: model.param("WAIT_FLAG")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "yellow"
                        }
                }
				
//// ***** Column 1, Row 3, COP Telecommand
                WidgetTelecommand {
                    x: 32; y:520
                    model: container.model.getTcModel()
                }

//// ***** Column 1, Row 4, Logo image
                Image {
                    id: imgLogo
                    x: 45; y: 840
                    width: 400; height: 110
                    source: "images/logo2.png"
                }

//// ***** Column 2, Row 1, Satellite Events
        // ***** NORMAL EVENT
                WidgetLabel {
                    x: 520; y: 120
                    width: 215
                    horizontalAlignment: Text.AlignHCenter
                    text: "NORMAL EVENT"
                }
                WidgetParamBorder {
                    x: 525; y: 170
                    label: "OCCURRED"
                    param: model.param("NORMAL_EVENT_OCCURED")
                    precision: 0
                }
                WidgetParamRoller {
                    x: 665; y: 145
                    param: model.param("NORMAL_EVENT_RECORDED")
                    precision: 0
                    min: 0; max: 50
                }

        // ***** MESSAGE REPORT
                WidgetLabel {
                    x: 520; y: 250
                    width: 215
                    horizontalAlignment: Text.AlignHCenter
                    text: "MESSAGE REPORT"
                }
                WidgetParamBorder {
                    x: 525; y: 300
                    label: "OCCURRED"
                    param: model.param("MESSAGE_REPORT_OCCURED")
                    precision: 0
                }
                WidgetParamRoller {
                    x: 665; y: 275
                    param: model.param("MESSAGE_REPORT_RECORDED")
                    precision: 0
                    min: 0; max: 50
                }

        // ***** ERROR EVENT
                WidgetLabel {
                    x: 520; y: 380
                    width: 215
                    horizontalAlignment: Text.AlignHCenter
                    text: "ERROR EVENT"
                }
                WidgetParamBorder {
                    x: 525; y: 430
                    label: "OCCURRED"
                    param: model.param("ERROR_EVENT_OCCURED")
                    precision: 0
                }
                WidgetParamRoller {
                    x: 665; y: 405
                    param: model.param("ERROR_EVENT_RECORDED")
                    precision: 0
                    min: 0; max: 50
                }

        // ***** TC COUNTERS
                WidgetParamBorder {
                    x: 525; y: 535
                    label: "REJECT TC"
                    param: model.param("REJECTED_TC_COUNTER")
                    precision: 0
                }
                WidgetParamBorder {
                    x: 650; y: 535
                    label: "RECORD TC"
                    param: model.param("RECEIVED_TC_COUNTER")
                    precision: 0
                }

        // ***** STATUS MP BUFFER
                WidgetLabel {
                    x: 780; y: 113
                    width: 215
                    horizontalAlignment: Text.AlignHCenter
                    text: "STATUS"
                }
                WidgetLabel {
                    x: 780; y: 130
                    width: 215
                    horizontalAlignment: Text.AlignHCenter
                    text: "MP BUFFER"
                }
                WidgetParamStatus {
                    x: 830; y: 155
                    width: 120; height: 20
                    param: model.param("MP_BUFFER_STATE")
                    statusColors: {"": "gray",
                            "EMPTY": "blue",
                            "LOADING": "yellow",
                            "FULL": "orange"
                        }
                }

                WidgetParamVLevel {
                    x: 803; y: 208
                    label: "AOCS MPQ"
                    param: model.param("MPQ_FREE_ENTRIES_1")
                    precision: 0
                    min: 0; max: 300
                }
                WidgetParamVLevel {
                    x: 916; y: 208
                    label: "PL MPQ"
                    param: model.param("MPQ_FREE_ENTRIES_2")
                    precision: 0
                    min: 0; max: 300
                }

                WidgetParamStatus {
                    x: 793; y: 438
                    width: 80
                    param: model.param("MPQ_STATE_1")
                    statusColors: {"": "gray",
                            "ENABLE": "blue",
                            "DISABLE": "yellow"
                        }
                }
                WidgetParamStatus {
                    x: 905; y: 438
                    width: 80
                    param: model.param("MPQ_STATE_2")
                    statusColors: {"": "gray",
                            "ENABLE": "blue",
                            "DISABLE": "yellow"
                        }
                }

        // ***** TT IN QUEUE
                WidgetLabel {
                    x: 780; y: 480
                    width: 215
                    horizontalAlignment: Text.AlignHCenter
                    text: "TT IN QUEUE"
                }
                WidgetParamSLevel {
                    x: 820; y: 530
                    param: model.param("TT_NUMBER")
                    min: 0; max: 150
                    precision: 0
                }


//// ***** Column 2, Middle, 2D Map
                Item {
                    id: sat2D
                    x: 507; y: 590
                    Text {
                        x: 10; y: 0
                        text: "SATELLITE"
                        font.pixelSize: 14
                        color: "#D5D6D7"
                    }

                    Rectangle {
                        x: 0; y: 25
                        width: 493; height: 255
                        radius: 10
                        color: "transparent"
                        border.color: "#BFC1C2"
                        border.width: 1
                        Sat2D {
                            x: 10; y: 0
                            width: 473; height: 250
                            time: container.model.currentTime
                        }
                    }
                }

//// ***** Column 2, Bottom, Countdown
                WidgetCountdown {
                    x: 504; y: 888
                    model: container.model.countdownModel.model
                }


//// ***** Column 3, Row 1, SBS
                WidgetParamStatus {
                    x: 1175; y: 120
                    width: 120; height: 15
                    label: "SGSMCSMODE"
                    param: model.param("SGSMCSMODE")
                    statusColors: {"": "gray",
                            "LOCAL_GMC1": "blue",
                            "REMOTE_GMC1": "yellow",
                            "LOCAL_GMC2": "blue",
                            "REMOTE_GMC2": "yellow"
                        }
                }

                WidgetParamStatus {
                    x: 1175; y: 145
                    width: 120; height: 15
                    label: "LINK"
                    param: model.param("MCSLINKST")
                    statusColors: {"": "gray",
                            "OPEN": "blue",
                            "CLOSE": "yellow"
                        }
                }

                WidgetParamStatusNumeric {
                    x: 1175; y: 170
                    width: 120; height: 15
                    label: "DOPPLER"
                    param: model.param("DOPPLER_MEASURE")
                    precision: 0
                    min: -1000000; max: 1000000
                    minNorm: -1000000; maxNorm: 1000000
                    statusColors: {"":"gray",
                                   "NORMAL":"blue",
                                   "NOT_NORMAL":"orange",
                                   "OUT_OF_RANGE":"red"
                    }
                }

                WidgetParamVCompare {
                    x: 1175; y: 215
                    label: "TM IF LEVEL"
                    param1: model.param("SGSTTCIFR2IF")
                    min1: -100; max1: 0
                    param2: model.param("SGSTTCIFR3IF")
                    min2: -100; max2: 0
                }

                WidgetLabel {
                    x:1070; y:245
                    width: 90
                    horizontalAlignment: Text.AlignHCenter
                    text: "LHP"
                }
                WidgetParamStatusNumeric {
                    x: 1070; y: 265
                    width: 90
                    param: model.param("SGSTTCIFR2IF")
                    precision: 0
                    min: -128; max: 127
                    minNorm: -100; maxNorm: 0
                    statusColors: {"":"gray",
                                   "NORMAL":"blue",
                                   "NOT_NORMAL":"orange",
                                   "OUT_OF_RANGE":"red"
                    }
                }

                WidgetLabel {
                    x:1295; y:245
                    width: 90
                    horizontalAlignment: Text.AlignHCenter
                    text: "RHP"
                }
                WidgetParamStatusNumeric {
                    x: 1295; y: 265
                    width: 90
                    param: model.param("SGSTTCIFR3IF")
                    precision: 0
                    min: -128; max: 127
                    minNorm: -100; maxNorm: 0
                    statusColors: {"":"gray",
                                   "NORMAL":"blue",
                                   "NOT_NORMAL":"orange",
                                   "OUT_OF_RANGE":"red"
                    }
                }

                WidgetLabel {
                    x: 1310; y: 140
                    width: 120
                    horizontalAlignment: Text.AlignRight
                    text: "IF BIT SYNCHRO"
                }
                WidgetParamLock {
                    x: 1440; y: 135
                    param: model.param("SGSTTCIFR2BS")
                }
                WidgetParamLock {
                    x: 1520; y: 135
                    param: model.param("SGSTTCIFR3BS")
                }

                WidgetLabel {
                    x: 1310; y: 185
                    width: 120
                    horizontalAlignment: Text.AlignRight
                    text: "IF BIT PLL"
                }
                WidgetParamLock {
                    x: 1440; y: 180
                    param: model.param("SGSTTCIFR2PL")
                }
                WidgetParamLock {
                    x: 1520; y: 180
                    param: model.param("SGSTTCIFR3PL")
                }

                WidgetParamStatus {
                    x: 1733; y: 120
                    width: 120; height: 15
                    label: "TM B FRAME SYN"
                    param: model.param("SGSTTCTMUBFS")
                    statusColors: {"": "gray",
                            "SEARCH_PHASE": "yellow",
                            "CHECK_PHASE": "yellow",
                            "LOCKED": "blue",
                            "FLYWHEEL": "yellow"
                        }
                }

                WidgetParamStatus {
                    x: 1733; y: 147
                    width: 120; height: 15
                    label: "TC UNIT STATUS"
                    param: model.param("SGSTTCSTATUS")
                    statusColors: {"": "gray",
                            "OK": "blue",
                            "ALARM": "orange"
                        }
                }

                WidgetParamStatus {
                    x: 1733; y: 174
                    width: 120; height: 15
                    label: "MODULATOR CR"
                    param: model.param("SGSTTCIFMCS")
                    statusColors: {"": "gray",
                            "OFF": "yellow",
                            "ON": "blue"
                        }
                }

                WidgetParamStatus {
                    x: 1733; y: 201
                    width: 120; height: 15
                    label: "TC LOCKED OUT"
                    param: model.param("SGSTTCTCULKS")
                    statusColors: {"": "gray",
                            "OFF": "blue",
                            "ON": "yellow"
                        }
                }

                WidgetParamStatus {
                    x: 1700; y: 228
                    width: 153; height: 15
                    label: "TC ENCODER STATUS"
                    param: model.param("SGSTTCTCEST")
                    statusColors: {"": "gray",
                            "NO_MODULATION": "yellow",
                            "PREAMBLE_MODUL": "yellow",
                            "TC_MESS_MODUL": "yellow",
                            "IDLE_MODULATION": "yellow",
                            "EXEC_TONE_TRANS": "blue",
                            "S_TONE_TRANSMIT": "yellow",
                            "S_VAL_TONE_TRAN": "yellow"
                        }
                }
				
//// ***** Column 3, Row 2, SBS
                WidgetLabel {
                    x: 1238; y: 410
                    width: 54
                    horizontalAlignment: Text.AlignHCenter
                    text: "TRSX1"
                }
                WidgetLabel {
                    x: 1328; y: 410
                    horizontalAlignment: Text.AlignHCenter
                    text: "TRSX2"
                }
                WidgetLabel {
                    x: 1060; y: 440
                    width: 150
                    horizontalAlignment: Text.AlignRight
                    text: "CARRIER LOCK"
                }
                WidgetParamLock {
                    x:1238; y: 435
                    param: model.param("SCARR1LOCK")
                }
                WidgetParamLock {
                    x:1328; y: 435
                    param: model.param("SCARR2LOCK")
                }
                WidgetLabel {
                    x: 1060; y: 475
                    width: 150
                    horizontalAlignment: Text.AlignRight
                    text: "SUB CARRIER LOCK"
                }
                WidgetParamLock {
                    x:1238; y: 470
                    param: model.param("SUCARR1LOK")
                }
                WidgetParamLock {
                    x:1328; y: 470
                    param: model.param("SUCARR2LOK")
                }

                WidgetLabel {
                    x: 1080; y: 510
                    width: 90
                    horizontalAlignment: Text.AlignHCenter
                    text: "REAL TIME"
                }
                WidgetParamStatus {
                    x: 1090; y: 530
                    width: 70
                    param: model.param("STATES_1")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "ON": "blue",
                            "HOLD": "yellow"
                        }
                }

                WidgetLabel {
                    x: 1188; y: 510
                    width: 90
                    horizontalAlignment: Text.AlignHCenter
                    text: "PLAYBACK"
                }
                WidgetParamStatus {
                    x: 1198; y: 530
                    width: 70
                    param: model.param("STATES_2")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "ON": "blue",
                            "HOLD": "yellow"
                        }
                }

                WidgetLabel {
                    x: 1292; y: 510
                    width: 90
                    horizontalAlignment: Text.AlignHCenter
                    text: "BACKUP"
                }
                WidgetParamStatus {
                    x: 1302; y: 530
                    width: 70
                    param: model.param("STATES_3")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "ON": "blue",
                            "HOLD": "yellow"
                        }
                }

// ***** Column 3 - 4, Charts
                Text {
                    x: 1069; y: 579
                    width: 100
                    horizontalAlignment: Text.AlignHCenter
                    text: "POWER"
                    color: "#404040"
                    font.pixelSize: 18
                    font.family: "Myriad Pro"
                }
                WidgetParamChartSmall {
                    id: chart1
                    width: 397; height: 255
                    x: 1033; y: 564
                    model: container.model
                    replayMode: container.replayMode
                    seriesList: [{"name":"POWERBAT", "title":"Power", "borderColor":"#FFD52B1E", "color":"#88D52B1E" }]
                }

                Text {
                    x: 1069; y: 825
                    width: 100
                    horizontalAlignment: Text.AlignHCenter
                    text: "DOD"
                    color: "#404040"
                    font.pixelSize: 18
                    font.family: "Myriad Pro"
                }
                WidgetParamChartSmall {
                    id: chart2
                    width: 397; height: 255
                    x: 1033; y: 809
                    model: container.model
                    replayMode: container.replayMode
                    seriesList: [{"name":"DEPTH_OF_DISCHARGE", "title":"Depth of Discharge", "borderColor":"#FF57CD98", "color":"#CC57CD98" }]
                }

                Text {
                    x: 1516; y: 292
                    width: 100
                    horizontalAlignment: Text.AlignHCenter
                    text: "MOMENTUM"
                    color: "#404040"
                    font.pixelSize: 18
                    font.family: "Myriad Pro"
                }
                WidgetParamChartSmall {
                    id: chart3
                    width: 397; height: 255
                    x: 1481; y: 277
                    model: container.model
                    replayMode: container.replayMode
                    seriesList: [{"name":"TOTAL_ANGULAR_MOMENTUM_1", "title":"Momentum 1", "borderColor":"#FFD3AB21", "color":"#44D3AB21"},
                        {"name":"TOTAL_ANGULAR_MOMENTUM_2", "title":"Momentum 2", "borderColor":"#FF21D3AB", "color":"#8821D3AB"},
                        {"name":"TOTAL_ANGULAR_MOMENTUM_3", "title":"Momentum 3", "borderColor":"#FFAB21D3", "color":"#CCAB21D3"}
                    ]
                }


// ***** Column 4, Bottom, 3D Earth and Satellite

                Item {
                    id: earthSat
                    x: 1406; y: 543
                    width: 520*scaleFactor*window.scaleFactor; height: 520*scaleFactor*window.scaleFactor
                    scale: 1.0/(scaleFactor*window.scaleFactor)
                    transformOrigin: Item.TopLeft
                    EarthSat {
                        anchors.fill: parent
                        time: container.model.currentTime
                    }
                }
            }
        }
    }

}




