import QtQuick 2.3

Rectangle {
    id: container
    property var window
    property var model
    property bool replayMode: false
    property real scaleFactor: Math.min(container.width/page.width,container.height/page.height)

    width: 1920; height: 1080
    color: "black"

    Component.onDestruction: {
        console.log("Satellite status screen to be destructed");
    }

    Rectangle {
        anchors.fill: parent
        scale: scaleFactor
        color: "black"
        Item  {
            id: page
            anchors.centerIn: parent
            width: 1920; height: 1080
            Image {
                id: imgBackground
                x: 0; y: 0
                source:"images/bgScreenTMSat2D.png"

// ***** Top Row *****
                WidgetLabel {
                    x: 499; y: 18
                    width: 921
                    color: "#FFFFFF"
                    text: "SATELLITE  :  THEOS"
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 24
                    font.bold: true
                }
                WidgetLabel {
                    x: 515; y: 45
                    width: 210
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                    color: "#C6C6C6"
                    text: "ARO"
                }
                WidgetParamStatus {
                    x: 515; y: 69
                    width: 210; height: 22
                    textSize: 16
                    param: model.param("R1_KARO")
                    statusColors: {"": "gray",
                                   "ACTIVE": "red",
                                   "INACTIVE": "green"
                    }
                }
                WidgetLabel {
                    x: 740; y: 45
                    width: 210
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                    color: "#C6C6C6"
                    text: "SYSTEM MANAGER"
                }
                WidgetParamStatus {
                    x: 740; y: 69
                    width: 210; height: 22
                    textSize: 16
                    param: model.param("SYST_MGR_OBJECT_STATE")
                    statusColors: {"": "gray",
                                   "IDLE": "yellow",
                                   "INIT": "yellow",
                                   "GROUND": "yellow",
                                   "LAUNCH": "yellow",
                                   "SAFE": "red",
                                   "OPERATIONAL": "green",
                                   "FORCE DORMANT": "blue"
                    }
                }
                WidgetLabel {
                    x: 960; y:45
                    width: 210
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                    color: "#C6C6C6"
                    text: "PAYLOAD MANAGER"
                }
                WidgetParamStatus {
                    x: 960; y:69
                    width: 210; height: 22
                    textSize: 16
                    param: model.param("PDM_MGR_OBJECT_STATE")
                    statusColors: {"": "gray",
                                   "SAFE": "red",
                                   "NOMINAL": "green"
                    }
                }
                WidgetLabel {
                    x: 1185; y: 45
                    width: 210
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                    color: "#C6C6C6"
                    text: "RTC MODE"
                }
                WidgetParamStatus {
                    x: 1185; y: 69
                    width: 210; height: 22
                    textSize: 16
                    param: model.param("RTC_MODE")
                    statusColors: {"": "gray",
                                   "NO_MODE": "red",
                                   "AUTONOMOUS": "blue",
                                   "DESYNCHRONIZED": "yellow",
                                   "PHASING": "yellow",
                                   "LOCKING": "yellow",
                                   "SYNCHRONIZED": "green"
                    }
                }

// ***** Left Top *****
                WidgetLabel {
                    x: 40; y: 45
                    color: "#C6C6C6"
                    text: "DHS"
                    font.pixelSize: 20
                }
// 8.1
                WidgetParamStatus {
                    x: 145; y:70
                    width: 108; height: 15
                    label: "VPM"
                    param: model.param("SBCR_VPM_IDENTIFIER")
                    statusColors: {"": "gray",
                            "VPM A": "blue",
                            "VPM B": "yellow"
                        }
                }
// 8.2
                WidgetParamStatus {
                    x: 338; y:70
                    width: 108; height: 15
                    label: "TIF"
                    param: model.param("IO_BOARD_STATE_1")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "NON_AVAILABLE": "yellow",
                            "AVAILABLE": "blue"
                        }
                }
// 8.3
                WidgetParamStatus {
                    x: 145; y: 95
                    width: 108; height: 15
                    label: "IOS A"
                    param: model.param("IO_BOARD_STATE_2")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "NON_AVAILABLE": "yellow",
                            "AVAILABLE": "blue"
                        }
                }
// 8.4
                WidgetParamStatus {
                    x: 338; y: 95
                    width: 108; height: 15
                    label: "IOC A"
                    param: model.param("IO_BOARD_STATE_4")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "NON_AVAILABLE": "yellow",
                            "AVAILABLE": "blue"
                        }
                }
// 8.5
                WidgetParamStatus {
                    x: 145; y: 120
                    width: 108; height: 15
                    label: "IOS B"
                    param: model.param("IO_BOARD_STATE_3")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "NON_AVAILABLE": "yellow",
                            "AVAILABLE": "blue"
                        }
                }
// 8.6
                WidgetParamStatus {
                    x: 338; y: 120
                    width: 108; height: 15
                    label: "IOC B"
                    param: model.param("IO_BOARD_STATE_5")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "NON_AVAILABLE": "yellow",
                            "AVAILABLE": "blue"
                        }
                }
// 8.7
                WidgetParamStatus {
                    x: 145; y: 145
                    width: 108; height: 15
                    label: "RE FUNCTION"
                    param: model.param("R0_KMODE")
                    statusColors: {"": "gray",
                            "MONITORING": "blue",
                            "PROGRAMMATION": "yellow"
                        }
                }
// 8.8
                WidgetParamStatus {
                    x: 338; y: 145
                    width: 108; height: 15
                    label: "SURVOBS"
                    param: model.param("IO_BOARD_STATE_6")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "NON_AVAILABLE": "yellow",
                            "AVAILABLE": "blue"
                        }
                }
// 8.9
                WidgetParamStatus {
                    x: 165; y: 170
                    width: 108; height: 15
                    label: "RESET VPMA"
                    param: model.param("R1_KRTSVPMA")
                    statusColors: {"": "gray",
                            "ACTIVE": "orange",
                            "INACTIVE": "blue"
                        }
                }
// 8.10
                WidgetParamStatus {
                    x: 165; y: 195
                    width: 108; height: 15
                    label: "WATCHDOG ERR"
                    param: model.param("R1_KWDERROR")
                    statusColors: {"": "gray",
                            "ACTIVE": "orange",
                            "INACTIVE": "blue"
                        }
                }
// 8.11
                WidgetParamStatus {
                    x: 165; y: 220
                    width: 108; height: 15
                    label: "SW ALARM"
                    param: model.param("R1_KSWALARM")
                    statusColors: {"": "gray",
                            "ACTIVE": "orange",
                            "INACTIVE": "blue"
                        }
                }
// 8.12
                WidgetParamStatus {
                    x: 165; y: 245
                    width: 108; height: 15
                    label: "PPS STATE"
                    param: model.param("PPS_STATE")
                    statusColors: {"": "gray",
                            "DISABLE": "yellow",
                            "ENABLE": "blue"
                        }
                }
// 8.13
                WidgetParamStatus {
                    x: 165; y: 270
                    width: 108; height: 15
                    label: "PPS SOURCE"
                    param: model.param("PPS_SOURCE")
                    statusColors: {"": "gray",
                            "GPSA": "blue",
                            "GPSB": "yellow"
                        }
                }
// 8.14
                WidgetParamStatus {
                    x: 165; y: 295
                    width: 108; height: 15
                    label: "SCRUBBING"
                    param: model.param("SCRUBBING_STATE")
                    statusColors: {"": "gray",
                            "ACTIVE": "blue",
                            "INACTIVE": "orange"
                        }
                }
// 8.15
                WidgetParamStatus {
                    x: 165; y: 320
                    width: 108; height: 15
                    label: "SPY"
                    param: model.param("SPY_STATE")
                    statusColors: {"": "gray",
                            "STOPPED": "blue",
                            "SAMPLING": "green",
                            "DOWNLOADING": "yellow"
                        }
                }
// 8.16
                WidgetParamStatus {
                    x: 165; y: 345
                    width: 108; height: 15
                    label: "DWELL"
                    param: model.param("DWELL_STATE")
                    statusColors: {"": "gray",
                            "STOPPED": "blue",
                            "SAMPLING": "green"
                        }
                }
// 8.17
                WidgetLabel {
                    x: 293; y: 180
                    text: "PATCH"
                    width: 80
                    horizontalAlignment: Text.AlignHCenter
                }
                WidgetLabel {
                    x: 293; y: 195
                    text: "COUNTER"
                    width: 80
                    horizontalAlignment: Text.AlignHCenter
                }
                WidgetParamCircle {
                    x: 295; y: 188
                    param: model.param("PATCH_COUNTER")
                    min: 0; max: 65535
                    minNorm: 0; maxNorm: 1
                }


// ***** Left Middle *****
                WidgetLabel {
                    x: 40; y: 401
                    color: "#c6c5c5"
                    text: "AOCS"
                    font.pixelSize: 20
                }
// 9.1
                WidgetParamStatus {
                    x: 165; y: 435
                    width: 108; height: 15
                    label: "MANAGER"
                    param: model.param("AOCS_MGR_STATE")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "ASH": "orange",
                            "NM": "blue",
                            "OCM": "orange"
                        }
                }
// 9.2
                WidgetParamStatus {
                    x: 165; y: 460
                    width: 108; height: 15
                    label: "NM MODE"
                    param: model.param("NM_MGR_STATE")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "GAP": "yellow",
                            "SUP": "blue",
                            "MAN": "yellow",
                            "FIP": "yellow"
                        }
                }
// 9.3
                WidgetParamStatus {
                    x: 165; y: 485
                    width: 108; height: 15
                    label: "ASH MODE"
                    param: model.param("ASH_MODE_MGR_STATE")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "IDLE": "orange",
                            "STABILIZE": "orange",
                            "SLO": "orange",
                            "STRA": "orange"
                        }

                }
// 9.4
                WidgetParamStatus {
                    x: 165; y: 510
                    width: 108; height: 15
                    label: "NAV STATE"
                    param: model.param("NAV_STATE")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "WAIT_FOR_GPS": "orange",
                            "GROUND_AIDED_NA": "orange",
                            "GPS_NAV": "blue"
                        }
                }
// 9.5
                WidgetParamStatus {
                    x: 165; y: 535
                    width: 108; height: 15
                    label: "OCM STATE"
                    param: model.param("OCM_MGR_STATE")
                    statusColors: {"": "gray",
                            "OCM": "blue",
                            "OFF": "silver"
                        }
                }
// 9.6
                WidgetParamStatus {
                    x: 165; y: 560
                    width: 108; height: 15
                    label: "IAE STATE"
                    param: model.param("AOCS_IAE_STATE")
                    statusColors: {"": "gray",
                            "OFF": "yellow",
                            "WAIT": "yellow",
                            "DRIFT": "blue",
                            "NO_DRIFT": "blue"
                        }
                }
// 9.7
                WidgetParamStatus {
                    x: 165; y: 585
                    width: 108; height: 15
                    label: "NAV FAILED"
                    param: model.param("NAV_FAILED_FLAG")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "orange"
                        }
                }
// 9.8
                WidgetParamStatus {
                    x: 165; y: 610
                    width: 108; height: 15
                    label: "IAE SUB ST"
                    param: model.param("AOCS_IAE_SUBSTATE")
                    statusColors: {"": "gray",
                            "IRU_ONLY": "blue",
                            "IRU_AND_STR": "blue"
                        }

                }
// 9.9
                WidgetParamStatus {
                    x: 165; y: 635
                    width: 108; height: 15
                    label: "IAE FAILED"
                    param: model.param("AOCS_IAE_FAILED_FLAG")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "orange"
                        }
                }
// 9.10
                WidgetParamStatus {
                    x: 165; y: 660
                    width: 108; height: 15
                    label: "3 AXIS STATE"
                    param: model.param("OPER_CTRL_OBJECT_STATE")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "WHEEL_ONLY": "blue",
                            "WHEEL_AND_THR": "yellow"
                        }
                }


// ***** Left Bottom *****
                WidgetLabel {
                    x: 40; y: 729
                    color: "#c5c4c4"
                    text: "EPS & TCS"
                    font.pixelSize: 20
                }
// 10.3
                WidgetParamStatus {
                    x: 165; y: 760
                    width: 108; height: 15
                    label: "CTRL OBJ STATE"
                    param: model.param("POW_CTRL_OBJECT_STATE")
                    statusColors: {"": "gray",
                            "IDLE": "yellow",
                            "ROUTINE": "blue"
                        }
                }
// 10.4
                WidgetParamStatusNumeric {
                    x: 165; y: 785
                    width: 108; height: 15
                    label: "POWER SA"
                    param: model.param("POWERSG")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: 0; maxNorm: 1005.0

                }
// 10.5
                WidgetParamStatusNumeric {
                    x: 165; y: 885
                    width: 108; height: 15
                    label: "BATT CURRENT"
                    param: model.param("BATTERY_CURRENT")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: -25.0; maxNorm: 25.0
                }
// 10.6
                WidgetParamStatusNumeric {
                    x: 165; y: 810
                    width: 108; height: 15
                    label: "POWER BATT"
                    param: model.param("POWERBAT")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: 0; maxNorm: 837.5
                }
// 10.7
                WidgetParamStatusNumeric {
                    x: 165; y: 910
                    width: 108; height: 15
                    label: "BATT FEM"
                    param: model.param("FEM")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: 28.0; maxNorm: 33.5
                }
// 10.8
                WidgetParamStatusNumeric {
                    x: 165; y: 835
                    width: 108; height: 15
                    label: "POWER SC"
                    param: model.param("POWERSAT")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: 0; maxNorm: 837.5
                }
// 10.9
                WidgetParamStatusNumeric {
                    x: 165; y: 935
                    width: 108; height: 15
                    label: "BATT DOD"
                    param: model.param("DEPTH_OF_DISCHARGE")
                    precision: 2
                    min: 0; max: 100
                    minNorm: 0; maxNorm: 30
                }
// 10.10
                WidgetParamStatusNumeric {
                    x: 165; y: 860
                    width: 108; height: 15
                    label: "BUS VOLTAGE"
                    param: model.param("BUS_VOLTAGE")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: 28.0; maxNorm: 33.5
                }
// 10.11
                WidgetParamStatusNumeric {
                    x: 165; y: 960
                    width: 108; height: 15
                    label: "BATT CAPACITY"
                    param: model.param("CAPACITY")
                    precision: 2
                    min: 0; max: 80
                    minNorm: 0; maxNorm: 75
                }
// 10.12
                WidgetLabel {
                    x: 287; y: 995
                    width: 120; height: 15
                    text: "REFERENCE WEIGHT"
                }
                WidgetParamStatusNumeric {
                    x: 287; y: 1010
                    width: 108; height: 15
                    param: model.param("REFERENCE_WEIGHT")
                    precision: 2
                    min: 0; max: 70
                    minNorm: 0; maxNorm: 70
                }
// 10.13
                WidgetParamStatusNumeric {
                    x: 165; y: 985
                    width: 108; height: 15
                    label: "SA CURRENT A"
                    param: model.param("ISGA")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: -1.0; maxNorm: 30.0
                }
// 10.14
                WidgetParamStatusNumeric {
                    x: 165; y: 1010
                    width: 108; height: 15
                    label: "SA CURRENT B"
                    param: model.param("ISGB")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: -1.0; maxNorm: 30.0
                }
// 14.3
                WidgetLabel {
                    x: 287; y: 870
                    width: 113; height: 15
                    horizontalAlignment: Text.AlignHCenter
                    text: "THERMAL FAILED"
                }
                WidgetParamStatus {
                    x: 287; y: 885
                    width: 118; height: 15
                    param: model.param("THERMAL_FAILED_FLAG")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "orange"
                        }
                }
// 14.4
                WidgetLabel {
                    x: 287; y: 907
                    width: 113; height: 15
                    horizontalAlignment: Text.AlignHCenter
                    text: "ACQUISITION"
                }
                WidgetLabel {
                    x: 287; y: 920
                    width: 113; height: 15
                    horizontalAlignment: Text.AlignHCenter
                    text: "CONSISTENCY"
                }
                WidgetParamStatus {
                    x: 287; y: 935
                    width: 118; height: 15
                    param: model.param("CONSISTENCY_FAILURE")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "orange"
                        }
                }
// 14.5
                WidgetLabel {
                    x: 287; y: 960
                    width: 113; height: 15
                    horizontalAlignment: Text.AlignHCenter
                    text: "POWER HEATBUS"
                }
                WidgetParamStatusNumeric {
                    x: 287; y: 975
                    width: 118; height: 15
                    param: model.param("POWHEATBUS")
                    precision: 2
                    min: -1000000.0; max: 1000000.0
                    minNorm: -1000000.0; maxNorm: 1000000.0

                }

// ***** Right Top *****
                WidgetLabel {
                    x: 1450; y: 45
                    color: "#c6c5c5"
                    text: "IPU"
                    font.pixelSize: 20
                }
// 11.1
                WidgetLabel {
                    x: 1435; y: 70
                    width: 120; height: 15
                    horizontalAlignment: Text.AlignHCenter
                    text: "EQPT STATE"
                }
                WidgetParamToggle {
                    x: 1587; y: 65
                    param: model.param("IPU_F_EXTERNAL_STATE")
                }
// 11.2
                WidgetParamStatus {
                    x: 1565; y: 100
                    width: 108; height: 15
                    label: "SELECTED EQPT"
                    param: model.param("IPU_F_SELECTED_EQPT")
                    statusColors: {"": "gray",
                            "A": "blue",
                            "B": "yellow"
                        }
                }

// 11.3
                WidgetParamStatus {
                    x: 1780; y: 70
                    width: 108; height: 15
                    label: "IPU FAILED"
                    param: model.param("IPU_F_FAILED_FLAG")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "orange"
                        }
                }
// 11.4
                WidgetParamStatus {
                    x: 1780; y: 100
                    width: 108; height: 15
                    label: "IPU EQPT ST"
                    param: model.param("IPU_EQPT_STATE_A")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "STAND BY": "yellow",
                            "OPERATION": "blue",
                            "IMAGING": "green"
                        }
                    Component.onCompleted: {
                        updateParam();
                        model.param("IPU_F_SELECTED_EQPT").engValueChanged.connect(updateParam);
                    }
                    function updateParam() {
                        if(model.param("IPU_F_SELECTED_EQPT").engValue == "B")
                            param = model.param("IPU_EQPT_STATE_B")
                        else
                            param = model.param("IPU_EQPT_STATE_A")
                    }
                }
// 11.5
                WidgetLabel {
                    x: 1603; y: 150
                    text: "PA FPA SSPC"
                }
                WidgetParamToggle {
                    x: 1700; y: 140
                    label: "IPU A"
                    param: model.param("SIPUPAFPAA")
                }
                WidgetParamToggle {
                    x: 1777; y: 140
                    label: "IPU B"
                    param: model.param("SIPUPAFPAB")
                }
// 11.6
                WidgetLabel {
                    x: 1603; y: 185
                    text: "MS FPA SSPC"
                }
                WidgetParamToggle {
                    x: 1700; y: 180
                    param: model.param("SIPUMSFPAA")
                }
                WidgetParamToggle {
                    x: 1777; y: 180
                    param: model.param("SIPUMSFPAB")
                }
// 11.7
                WidgetParamStatus {
                    x: 1735; y: 220
                    width: 108; height: 15
                    label: "IPU OUT CHANNEL"
                    param: model.param("PO_A")
                    statusColors: {"": "gray",
                            "A": "blue",
                            "B": "yellow"
                        }
                }
// 11.8
                WidgetLabel {
                    x: 1610; y: 250
                    text: "IPU VOLT COMP"
                    horizontalAlignment: Text.AlignRight
                }
                WidgetParamStatusNumeric {
                    x: 1736; y: 250
                    width: 67; height: 15
                    param: model.param("V5COMPIPUA")
                    precision: 2
                    min: -61440.0; max: 65535.0
                    minNorm: -0.5; maxNorm: 0.5
                }
                WidgetParamStatusNumeric {
                    x: 1812; y: 250
                    width: 67; height: 15
                    param: model.param("V5COMPIPUB")
                    precision: 2
                    min: -61440.0; max: 65535.0
                    minNorm: -0.5; maxNorm: 0.5
                }
// 11.9
                WidgetLabel {
                    x: 1635; y: 280
                    text: "IPU DIGITAL"
                    horizontalAlignment: Text.AlignRight
                }
                WidgetParamStatusNumeric {
                    x: 1736; y: 280
                    width: 67; height: 15
                    param: model.param("V5DIGIPUA")
                    precision: 2
                    min: -61440.0; max: 65535.0
                    minNorm: -0.5; maxNorm: 0.5
                }
                WidgetParamStatusNumeric {
                    x: 1812; y: 280
                    width: 67; height: 15
                    param: model.param("V5DIGIPUB")
                    precision: 2
                    min: -61440.0; max: 65535.0
                    minNorm: -0.5; maxNorm: 0.5
                }

// ***** Right Middle *****
                WidgetLabel {
                    x: 1640; y: 335
                    color: "#c6c5c5"
                    text: "SSR"
                    font.pixelSize: 20
                }
// 12.1
                WidgetLabel {
                    x: 1632; y: 360
                    width: 120; height: 15
                    horizontalAlignment: Text.AlignRight
                    text: "EQPT STATE"
                }
                WidgetParamToggle {
                    x: 1780; y: 355
                    param: model.param("SSR_EQPT_EXTERNAL_STATE")
                }
// 12.2
                WidgetParamStatus {
                    x: 1762; y: 412
                    width: 108; height: 15
                    label: "SELECTED EQPT"
                    param: model.param("SEL_CONTROLLER")
                    statusColors: {"": "gray",
                            "A": "blue",
                            "B": "green"
                        }
                }
// 12.3
                WidgetParamStatus {
                    x: 1762; y: 387
                    width: 108; height: 15
                    label: "SSR FAILED"
                    param: model.param("SSR_EQPT_FAILED_FLAG")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "orange"
                        }
                }
// 12.4
                WidgetParamStatus {
                    x: 1762; y: 437
                    width: 108; height: 15
                    label: "OBJECT STATE"
                    param: model.param("SSR_EQPT_OBJECT_STATE")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "STAND-BY": "yellow",
                            "OPERATING": "blue"
                        }
                }
// 12.5
                WidgetParamSwitch {
                    x: 1663; y: 477
                    label: "MBA0"
                    param: model.param("MEM_BOARD_STATE_AE")
                }
                WidgetParamSwitch {
                    x: 1728; y: 477
                    label: "MBA1"
                    param: model.param("MEM_BOARD_STATE_BF")
                }
                WidgetParamSwitch {
                    x: 1794; y: 477
                    label: "MBB0"
                    param: model.param("MEM_BOARD_STATE_CG")
                }
// 12.6
                WidgetLabel {
                    x: 1620; y: 515
                    text: "STATE"
                    width: 40
                    horizontalAlignment: Text.AlignRight
                }
                WidgetParamStatus {
                    x: 1669; y: 515
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("MEM_BANK_STATES_A0")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "ON": "yellow",
                            "USED": "blue",
                            "SELFTEST": "green"
                        }
                }
                WidgetParamStatus {
                    x: 1745; y: 515
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("MEM_BANK_STATES_A1")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "ON": "yellow",
                            "USED": "blue",
                            "SELFTEST": "green"
                        }
                }
                WidgetParamStatus {
                    x: 1821; y: 515
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("MEM_BANK_STATES_B0")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "ON": "yellow",
                            "USED": "blue",
                            "SELFTEST": "green"
                        }
                }
// 12.7
                WidgetLabel {
                    x: 1625; y: 540
                    text: "CORREC A"
                    width: 55
                    horizontalAlignment: Text.AlignRight
                }
                WidgetLabel {
                    x: 1625; y: 565
                    text: "CORREC B"
                    width: 55
                    horizontalAlignment: Text.AlignRight
                }
                WidgetParamStatusNumeric {
                    x: 1685; y: 540
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("SMA0ESCECA")
                    min: 0; max: 500
                    minNorm: 0; maxNorm: 300
                }
                WidgetParamStatusNumeric {
                    x: 1685; y: 565
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("SMA0ESCECB")
                    min: 0; max: 500
                    minNorm: 0; maxNorm: 300
                }
// 12.8
                WidgetParamStatusNumeric {
                    x: 1754; y: 540
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("SMA1ESCECA")
                    min: 0; max: 500
                    minNorm: 0; maxNorm: 300
                }
                WidgetParamStatusNumeric {
                    x: 1754; y: 565
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("SMA1ESCECB")
                    min: 0; max: 500
                    minNorm: 0; maxNorm: 300
                }
// 12.9
                WidgetParamStatusNumeric {
                    x: 1823; y: 540
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("SMB0ESCECA")
                    min: 0; max: 500
                    minNorm: 0; maxNorm: 300
                }
                WidgetParamStatusNumeric {
                    x: 1823; y: 565
                    width: 67; height: 15
                    scale: 0.9
                    param: model.param("SMB0ESCECB")
                    min: 0; max: 500
                    minNorm: 0; maxNorm: 300
                }
// 12.10
                WidgetLabel {
                    x: 1720; y: 588
                    text: "VIDEO INPUT"
                }
                WidgetLabel {
                    x: 1612; y: 610
                    width: 40
                    text: "IN"
                    horizontalAlignment: Text.AlignRight
                }
                WidgetParamStatus {
                    x: 1665; y: 610
                    width: 108; height: 15
                    param: model.param("CHANNEL_CONF_PAN_IN")
                    statusColors: {"": "gray",
                            "NOMINAL": "blue",
                            "REDUNDANT": "orange"
                        }
                }
                WidgetParamStatus {
                    x: 1783; y: 610
                    width: 108; height: 15
                    param: model.param("CHANNEL_CONF_MS_IN")
                    statusColors: {"": "gray",
                            "NOMINAL": "blue",
                            "REDUNDANT": "orange"
                        }
                }
// 12.11
                WidgetLabel {
                    x: 1612; y: 630
                    width: 40
                    text: "STATE"
                    horizontalAlignment: Text.AlignRight
                }
                WidgetParamStatus {
                    x: 1665; y: 630
                    width: 108; height: 15
                    param: model.param("SSR_PAN_A")
                    statusColors: {"": "gray",
                            "STOP": "silver",
                            "WRITE": "blue",
                            "DDT": "green"
                        }
                }
                WidgetParamStatus {
                    x: 1783; y: 630
                    width: 108; height: 15
                    param: model.param("SSR_MS_A")
                    statusColors: {"": "gray",
                            "STOP": "silver",
                            "WRITE": "blue",
                            "DDT": "green"
                        }
                }
// 12.12
                WidgetLabel {
                    x: 1612; y: 650
                    width: 40
                    text: "DDT"
                    horizontalAlignment: Text.AlignRight
                }
                WidgetParamStatus {
                    x: 1665; y: 650
                    width: 108; height: 15
                    param: model.param("SSSRPADDTA")
                    statusColors: {"": "gray",
                            "DESELECTED": "silver",
                            "SELECTED": "blue"
                        }
                }
                WidgetParamStatus {
                    x: 1783; y: 650
                    width: 108; height: 15
                    param: model.param("SSSRMSDDTA")
                    statusColors: {"": "gray",
                            "DESELECTED": "silver",
                            "SELECTED": "blue"
                        }
                }
// 12.13
                WidgetLabel {
                    x: 1715; y: 673
                    text: "VIDEO OUTPUT"
                }
                WidgetParamStatus {
                    x: 1730; y: 695
                    width: 108; height: 15
                    label: "OUT"
                    param: model.param("CHANNEL_CONF_VIDEO_OUT")
                    statusColors: {"": "gray",
                            "NOMINAL": "blue",
                            "REDUNDANT": "orange"
                        }
                }
// 12.14
                WidgetParamStatus {
                    x: 1730; y: 715
                    width: 108; height: 15
                    label: "VC1"
                    param: model.param("SSR_VC1_A")
                    statusColors: {"": "gray",
                            "STOP": "silver",
                            "READ": "blue",
                            "DDT": "green"
                        }
                }
// 12.15
                WidgetParamStatus {
                    x: 1730; y: 735
                    width: 108; height: 15
                    label: "VC2"
                    param: model.param("SSR_VC2_A")
                    statusColors: {"": "gray",
                            "STOP": "silver",
                            "READ": "blue",
                            "DDT": "green"
                        }
                }

// ***** Right Bottom *****
                WidgetLabel {
                    x: 1640; y: 787
                    color: "#c6c5c5"
                    text: "TMI"
                    font.pixelSize: 20
                }
// 13.1
                WidgetLabel {
                    x: 1592; y: 812
                    text: "EQPT STATE"
                    horizontalAlignment: Text.AlignRight
                    width: 120
                }
                WidgetParamToggle {
                    x: 1745; y: 807
                    param: model.param("TMI_FUNC_EXTERNAL_STATE")
                }
// 13.2
                WidgetParamStatus {
                    x: 1724; y: 842
                    width: 108; height: 15
                    label: "SELECTED IOC"
                    param: model.param("TMI_FUNC_SELECTED_IOC")
                    statusColors: {"": "gray",
                            "A": "blue",
                            "B": "yellow"
                        }
                }
// 13.3
                WidgetParamStatus {
                    x: 1724; y: 867
                    width: 108; height: 15
                    label: "SELECTED EQPT"
                    param: model.param("TMI_FUNC_SELECTED_EQPT")
                    statusColors: {"": "gray",
                            "A": "blue",
                            "B": "yellow"
                        }
                }
// 13.4
                WidgetParamStatus {
                    x: 1724; y: 892
                    width: 108; height: 15
                    label: "TMI FAILED"
                    param: model.param("TMI_FUNC_FAILED_FLAG")
                    statusColors: {"": "gray",
                            "FALSE": "blue",
                            "TRUE": "orange"
                        }
                }
// 13.5
                WidgetLabel {
                    x: 1657; y: 918
                    text: "EQPT  A"
                }
                WidgetLabel {
                    x: 1780; y: 918
                    text: "EQPT B"
                }
                WidgetLabel {
                    x: 1511; y: 940
                    text: "OBJECT STATE"
                }
                WidgetParamStatus {
                    x: 1622; y: 940
                    width: 108; height: 15
                    param: model.param("TMI_EQPT_OBJECT_STATE_A")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "STAND BY": "yellow",
                            "OPERATION": "blue"
                        }
                }
                WidgetParamStatus {
                    x: 1745; y: 940
                    width: 108; height: 15
                    param: model.param("TMI_EQPT_OBJECT_STATE_B")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "STAND BY": "yellow",
                            "OPERATION": "blue"
                        }
                }
// 13.6
                WidgetLabel {
                    x: 1511; y: 980
                    text: "QPSK SSPC"
                }
                WidgetParamToggle {
                    x: 1649; y: 973
                    param: model.param("SQPSKA")
                }
                WidgetParamToggle {
                    x: 1772; y: 973
                    param: model.param("SQPSKB")
                }
// 13.7
                WidgetLabel {
                    x: 1510; y: 1018
                    text: "TWTA XMIT"
                }
                WidgetParamToggle {
                    x: 1649; y: 1011
                    param: model.param("SREMTWTAA")
                }
                WidgetParamToggle {
                    x: 1772; y: 1011
                    param: model.param("SREMTWTAB")
                }


// ***** Center *****
// Star Tracker
// 9.21, 9.22
                WidgetParamSelection {
                    x: 534; y:170
                    label: "SELECTION"
                    param: model.param("STR_F_STATE")
                    leftValues: ["DEFAULT_SELECT"]
                    rightValues: ["SECOND_SELECT"]
                }
                WidgetParamToggle {
                    x: 610; y:172
                    label: "A"
                    param: model.param("SSSTA")
                }
                WidgetParamToggle {
                    x: 678; y:172
                    label: "B"
                    param: model.param("SSSTB")
                }
// Inertial Reference Unit
// 9.19, 9.20
                WidgetParamSelection {
                    x: 435; y:270
                    label: "SELECTION"
                    param: model.param("IRU_F_STATE")
                    leftValues: ["DEFAULT_SELECT"]
                    rightValues: ["SECOND_SELECT"]
                }
                WidgetParamToggle {
                    x: 511; y:272
                    label: "A"
                    param: model.param("SIRUA")
                }
                WidgetParamToggle {
                    x: 579; y:272
                    label: "B"
                    param: model.param("SIRUB")
                }
// Solid State Recorder
// 12.1 & 12.2
                WidgetParamSelection {
                    x: 383; y: 374
                    label: "SELECTION"
                    param: model.param("SSR_EQPT_EXTERNAL_STATE")
                    leftValues: ["ON"]
                    rightValues: ["OFF"]
                }
                WidgetParamToggle {
                    x: 459; y: 376
                    label: "A"
                    onValues: ["A"]
                    param: model.param("SEL_CONTROLLER")
                }
                WidgetParamToggle {
                    x: 527; y: 376
                    label: "B"
                    onValues: ["B"]
                    param: model.param("SEL_CONTROLLER")
                }
// IPU Unit
// 11.1 & 11.2
                WidgetParamSelection {
                    x: 383; y: 479
                    label: "SELECTION"
                    param: model.param("IPU_F_EXTERNAL_STATE")
                    leftValues: ["ON"]
                    rightValues: ["OFF"]
                }
                WidgetParamToggle {
                    x: 459; y: 481
                    label: "A"
                    onValues: ["A"]
                    param: model.param("IPU_F_SELECTED_EQPT")
                }
                WidgetParamToggle {
                    x: 527; y: 481
                    label: "B"
                    onValues: ["B"]
                    param: model.param("IPU_F_SELECTED_EQPT")
                }
// Magnetometer
// 9.23, 9.24
                WidgetParamSelection {
                    x: 383; y: 576
                    label: "SELECTION"
                    param: model.param("MAG_F_STATE")
                    leftValues: ["DEFAULT_SELECT"]
                    rightValues: ["SECOND_SELECT"]
                }
                WidgetParamToggle {
                    x: 459; y: 578
                    label: "A"
                    param: model.param("MAG_EQPT_EXTERNAL_STATE_A")
                }
                WidgetParamToggle {
                    x: 527; y: 578
                    label: "B"
                    param: model.param("MAG_EQPT_EXTERNAL_STATE_B")
                }
// Thermal Control
// 14.1, 14.2
                WidgetParamSelection {
                    x: 383; y: 684
                    label: "SELECTION"
                    param: model.param("THERMAL_OBJECT_STATE")
                    leftValues: ["DEFAULT_SELECT"]
                    rightValues: ["SECOND_SELECT"]
                }
                WidgetParamToggle {
                    x: 459; y: 686
                    label: "A"
                    onValues: ["A"]
                    param: model.param("THERMAL_SELECTED_EQPT")
                }
                WidgetParamToggle {
                    x: 527; y: 686
                    label: "B"
                    onValues: ["B"]
                    param: model.param("THERMAL_SELECTED_EQPT")
                }
// X-Band Antenna
// 13.3, 13.5
                WidgetParamStatus {
                    x: 500; y: 790
                    width: 108; height: 15
                    label: "STATE"
                    param: model.param("TMI_EQPT_OBJECT_STATE_A")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "STAND BY": "yellow",
                            "OPERATION": "blue"
                        }
                    Component.onCompleted: {
                        updateParam();
                        model.param("TMI_FUNC_SELECTED_EQPT").engValueChanged.connect(updateParam);
                    }
                    function updateParam() {
                        if(model.param("TMI_FUNC_SELECTED_EQPT").engValue == "B")
                            param = model.param("TMI_EQPT_OBJECT_STATE_B")
                        else
                            param = model.param("TMI_EQPT_OBJECT_STATE_A")
                    }
                }
                WidgetParamToggle {
                    x: 458; y: 826
                    label: "A"
                    onValues: ["A"]
                    param: model.param("TMI_FUNC_SELECTED_EQPT")
                }
                WidgetParamToggle {
                    x: 536; y: 826
                    label: "B"
                    onValues: ["B"]
                    param: model.param("TMI_FUNC_SELECTED_EQPT")
                }
// S-Band Antenna
// 4.2, 6.5, 6.7
                WidgetParamStatus {
                    x: 677; y: 894
                    width: 108; height: 15
                    label: "STATE"
                    param: model.param("MCSLINKST")
                    statusColors: {"": "gray",
                            "OPEN": "blue",
                            "CLOSE": "yellow"
                        }
                }
                WidgetParamToggle {
                    x: 634; y: 931
                    label: "TRSX1"
                    onValues: ["LOCK"]
                    param: model.param("SCARR1LOCK")
                }
                WidgetParamToggle {
                    x: 712; y: 931
                    label: "TRSX2"
                    onValues: ["LOCK"]
                    param: model.param("SCARR2LOCK")
                }
// Battery
// 10.1 & 10.2
                WidgetParamSelection {
                    x: 912; y: 978
                    label: "SELECTION"
                    param: model.param("POW_FUNC_OBJECT_STATE")
                    leftValues: ["DEFAULT_SELECT"]
                    rightValues: ["SECOND_SELECT"]
                }
                WidgetParamToggle {
                    x: 988; y: 980
                    label: "A"
                    onValues: ["A"]
                    param: model.param("POW_FUNC_SELECTED_EQPT")
                }
                WidgetParamToggle {
                    x: 1056; y: 980
                    label: "B"
                    onValues: ["B"]
                    param: model.param("POW_FUNC_SELECTED_EQPT")
                }
// Reaction Wheels
// 9.11, 9.12
                WidgetParamStatus {
                    x: 1280; y: 917
                    width: 108; height: 15
                    label: "SELECTION"
                    param: model.param("RW_F_STATE")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "WHEEL_1_OFF": "orange",
                            "WHEEL_2_OFF": "orange",
                            "WHEEL_3_OFF": "orange",
                            "WHEEL_4_OFF": "orange",
                            "FOUR_WHEELS": "blue"
                        }
                }
                WidgetParamToggle {
                    x: 1215; y: 951
                    label: "1"
                    param: model.param("RW_EQPT_EXTERNAL_STATE_RW1")
                }
                WidgetParamToggle {
                    x: 1300; y: 951
                    label: "2"
                    param: model.param("RW_EQPT_EXTERNAL_STATE_RW2")
                }
                WidgetParamToggle {
                    x: 1215; y: 996
                    label: "3"
                    param: model.param("RW_EQPT_EXTERNAL_STATE_RW3")
                }
                WidgetParamToggle {
                    x: 1300; y: 996
                    label: "4"
                    param: model.param("RW_EQPT_EXTERNAL_STATE_RW4")
                }
// Thruster
// 9.25, 9.26
                WidgetParamStatus {
                    x: 1372; y: 788
                    width: 108; height: 15
                    label: "SELECTION"
                    param: model.param("THR_FUNC_OBJECT_STATE")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "THR_1234": "blue",
                            "THR_13": "blue",
                            "THR_24": "blue"
                        }
                }
                WidgetParamToggle {
                    x: 1310; y: 823
                    label: "A"
                    param: model.param("THR_EQPT_OBJECT_STATE_A")
                }
                WidgetParamToggle {
                    x: 1388; y: 823
                    label: "B"
                    param: model.param("THR_EQPT_OBJECT_STATE_B")
                }
// Cross Sun Sensor
// 9.13, 9.14
                WidgetParamSelection {
                    x: 1336; y:702
                    label: "SELECTION"
                    param: model.param("CSS_F_STATE")
                    leftValues: ["DEFAULT_SELECT"]
                    rightValues: ["SECOND_SELECT"]
                }
                WidgetParamToggle {
                    x: 1412; y:704
                    label: "A"
                    param: model.param("CSS_EQPT_EXTERNAL_STATE_A")
                }
                WidgetParamToggle {
                    x: 1480; y:704
                    label: "B"
                    param: model.param("CSS_EQPT_EXTERNAL_STATE_B")
                }
// Magnetotorquer
// 9.15, 9.16
                WidgetParamSelection {
                    x: 1336; y: 604
                    label: "SELECTION"
                    param: model.param("MTQ_F_STATE")
                    leftValues: ["DEFAULT_SELECT"]
                    rightValues: ["SECOND_SELECT"]
                }
                WidgetParamToggle {
                    x: 1412; y: 606
                    label: "A"
                    param: model.param("MTQ_EQPT_EXTERNAL_STATE_A")
                }
                WidgetParamToggle {
                    x: 1480; y: 606
                    label: "B"
                    param: model.param("MTQ_EQPT_EXTERNAL_STATE_B")
                }
// GPS
// 9.17, 9.18
                WidgetParamSelection {
                    x: 1336; y:502
                    label: "SELECTION"
                    param: model.param("GPS_F_STATE")
                    leftValues: ["DEFAULT_SELECT"]
                    rightValues: ["SECOND_SELECT"]
                }
                WidgetParamToggle {
                    x: 1412; y:504
                    label: "A"
                    param: model.param("SGPSA")
                }
                WidgetParamToggle {
                    x: 1480; y:504
                    label: "B"
                    param: model.param("SGPSB")
                }
// Solar Array
// 10.12
                WidgetParamHScale {
                    x: 1340; y: 411
                    min: 0.0
                    max: 100.0
                    label: "REFERENCE WEIGHT"
                    param: model.param("REFERENCE_WEIGHT")
                }
                WidgetParamDigital {
                    x: 1475; y: 407
                    min: 0.0; max: 100.0
                    minNorm: 0.0; maxNorm: 100.0
                    param: model.param("REFERENCE_WEIGHT")
                }
// Top Multi-Spectral
// 11.4, 11.6
                WidgetParamStatus {
                    x: 1395; y: 276
                    width: 108; height: 15
                    label: "STATE"
                    param: model.param("IPU_EQPT_STATE_A")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "STAND BY": "yellow",
                            "OPERATION": "blue",
                            "IMAGING": "green"
                        }
                    Component.onCompleted: {
                        updateParam();
                        model.param("IPU_F_SELECTED_EQPT").engValueChanged.connect(updateParam);
                    }
                    function updateParam() {
                        if(model.param("IPU_F_SELECTED_EQPT").engValue == "B")
                            param = model.param("IPU_EQPT_STATE_B")
                        else
                            param = model.param("IPU_EQPT_STATE_A")
                    }
                }
                WidgetParamToggle {
                    x: 1353; y: 312
                    label: "A"
                    onValues: ["ON"]
                    param: model.param("SIPUMSFPAA")
                }
                WidgetParamToggle {
                    x: 1431; y: 312
                    label: "B"
                    onValues: ["ON"]
                    param: model.param("SIPUMSFPAB")
                }
// Top Pan Chromatic
// 11.4, 11.5
                WidgetParamStatus {
                    x: 1240; y: 158
                    width: 108; height: 15
                    label: "STATE"
                    param: model.param("IPU_EQPT_STATE_A")
                    statusColors: {"": "gray",
                            "OFF": "silver",
                            "STAND BY": "yellow",
                            "OPERATION": "blue",
                            "IMAGING": "green"
                        }
                    Component.onCompleted: {
                        updateParam();
                        model.param("IPU_F_SELECTED_EQPT").engValueChanged.connect(updateParam);
                    }
                    function updateParam() {
                        if(model.param("IPU_F_SELECTED_EQPT").engValue == "B")
                            param = model.param("IPU_EQPT_STATE_B")
                        else
                            param = model.param("IPU_EQPT_STATE_A")
                    }
                }
                WidgetParamToggle {
                    x: 1198; y: 194
                    label: "A"
                    onValues: ["ON"]
                    param: model.param("SIPUPAFPAA")
                }
                WidgetParamToggle {
                    x: 1276; y: 194
                    label: "B"
                    onValues: ["ON"]
                    param: model.param("SIPUPAFPAB")
                }


            }
        }
    }
}

