import QtQuick 2.0
import Qt.labs.folderlistmodel 1.0
import QtQuick.XmlListModel 2.0
import QtCommercial.Chart 1.3

import com.terma.MIB 1.0
import com.terma.TM 1.0
import com.terma.TSEQ 1.0
import com.terma.SYN 1.0

Rectangle {
    id: theDisplay
	 
    width: 1100
    height: 680
    color: "black"

 	Rectangle {
		id: searchFilter
		property bool active : false
		z: -1
		color: "gray"
		width: 140
		height: 36
		anchors { right: view.right; rightMargin:70; top: view.top; topMargin: 24 }
		TextInput {
			id: searchFilterText
			font {pixelSize: 30; }
			horizontalAlignment: TextInput.AlignRight
			color: "white"
			focus: searchFilter.active
			text: ""
		}

		states: State {
			name: "back"
			PropertyChanges { target: searchFilter; z: 1 } 
			PropertyChanges { target: searchFilterText; text: "" } 
			when: searchFilter.active
		}
	}
	
	Image {
		id: maxButton
		width: 20
		height: 20
		z: 1
		source: "metroIcons/Resize.png"
		anchors { right: view.right; top: view.top }
		MouseArea {
			anchors.fill: parent
			onClicked:  { 
				rootView.fullScreen = !rootView.fullScreen
			}
		}
	}		
	
	Flipable {
		id: paramDetails
		property bool flipped : false
		property string values: "<large>%1</large> <sup><i>%2</i></sup><br>" +
				"<small>sample</small> %16 <small>state</small><font color=\"%3\"> %4 </font> <small>eng</small> %5 %6<sup><i>(%7)</i></sup>   <small>raw</small> %8 <sup><i>(%9)</i></sup><br>" +
				"<small>pus</small> %10/%11 <small>size</small> %15 <small>rxt</small> %12 <small>obt</small> %13 <small>pkt</small> %14"
		property alias name : dPar.name
		
		TmParam {
			id: dPar
			// references that would use the PCF ref need to be protected in case it is not pointing to anything yet.
			property bool pcfOk: dPar.pcfRef != null
			property string descr: pcfOk ? dPar.pcfRef.pcf_descr : ""
			property int ptc: pcfOk ? dPar.pcfRef.pcf_ptc : 0
			property int pfc: pcfOk ? dPar.pcfRef.pcf_pfc : 0
			property string rv: dPar.rawValidity ? "valid" : "invalid" 
			property string ev: dPar.engValidity ? "valid" : "invalid" 
		}
		
		width: theDisplay.width
		height: 160
		anchors { bottom: theDisplay.bottom }

		XmlListModel {
			id: limitsModel
			xml: dPar.currentLimit
			query: "/limits/TmOcp"
			// avoid showing -1 when the model has no data at all at startup
			property int n : count < 0 ? 0 : count
			XmlRole { name: "ocp_name" ; query: "@ocp_name/string()" }
			XmlRole { name: "ocp_pos" ; query: "@ocp_pos/string()" }
			XmlRole { name: "ocp_type" ; query: "@ocp_type/string()" }
			XmlRole { name: "ocp_hvalu" ; query: "@ocp_hvalu/string()" }
			XmlRole { name: "ocp_lvalu" ; query: "@ocp_lvalu/string()" }
			XmlRole { name: "selected" ; query: "xs:boolean(@selected)" }
		}		

		XmlListModel {
			id: curvesModel
			xml: dPar.currentCalib
			query: "/curves/*"
			// avoid showing -1 when the model has no data at all at startup
			property int n : count < 0 ? 0 : count
			// troublesome fact that there are different table types, so we rely on attribute positions rather than names
			XmlRole { name: "curveName" ; query: "data(@*[1])" }
			XmlRole { name: "curveDesc" ; query: "data(@*[2])" }
			XmlRole { name: "selected" ; query: "xs:boolean(@selected)" }
		}			
			
		back {
			Flickable {
				anchors.fill: parent
				flickableDirection: Flickable.VerticalFlick
				Rectangle {
					id: detailsPlaque
					color: "#f0808080"
					anchors.fill: parent
					clip: true

					Text {
						id: detailsValues
						wrapMode: Text.WrapAnywhere
						anchors { top: parent.top; topMargin: 10; left: parent.left; leftMargin: 10; right: parent.right; rightMargin: 80}
						color: "white"
						font.pixelSize: 18
						textFormat: Text.RichText
						text: dPar.pcfOk ? paramDetails.values.arg(dPar.name).arg(dPar.descr).arg(dPar.monColor).arg(dPar.monState).arg(dPar.engValue).arg(dPar.unit).arg(dPar.ev).arg(dPar.rawValue).arg(dPar.rv).arg(dPar.ptc).arg(dPar.pfc).arg(dPar.receivedTime).arg(dPar.generationTime).arg(dPar.packetRef).arg(dPar.bitSize).arg(dPar.sample +1) : ""
					}				
					
					Row {
						anchors { top: detailsValues.bottom; topMargin: 10; bottom: parent.bottom; left: parent.left; leftMargin: 10; right: parent.right }
						Text {
							width: 100; height: 40
							text: "Limits <sup><i>(%1)</i></sup>".arg(limitsModel.n) ; textFormat: Text.RichText; color: "white"; font.pixelSize: 16
						}
						ListView {
							id: limitsView
							width: 100; height: 60
							model: limitsModel
							delegate: Text { text: "%1 %2 %3".arg(ocp_type).arg(ocp_lvalu).arg(ocp_hvalu); color: selected ? dPar.monColor : "white"; font.pixelSize: 12; font.bold: selected }
						}
						Text {
							width: 100; height: 40
							text: "Curves <sup><i>(%1)</i></sup>".arg(curvesModel.n) ; textFormat: Text.RichText; color: "white"; font.pixelSize: 16
						}
						ListView {
							id: curvesView
							width: 100; height: 60
							model: curvesModel
							delegate: Text { text: "%1 - %2".arg(curveName).arg(curveDesc); color: "white"; font.pixelSize: 12; font.bold: selected ;  }
						}
					}
				}
				Image {
					source: "metroIcons/Cancel.png"
					anchors { top: parent.top; right: parent.right; topMargin: 20; rightMargin: 20 }
					MouseArea {
						anchors.fill: parent
						onClicked: {
							mouse.accepted = true
							paramDetails.flipped = false
						}
					}
				}
			}
		}
		transform: Rotation {
			id: detailsRotation
			origin.x: (paramDetails.width)/2
			origin.y: (paramDetails.height)/2
			axis.x: 1; axis.y: 0 ; axis.z: 0
			angle: 0
		}
		states: State {
			name: "back"
			PropertyChanges { target: paramDetails; z: 1 } 
			PropertyChanges { target: detailsRotation; angle: 180 }
			when: paramDetails.flipped
		} 
		transitions: Transition {
			NumberAnimation { target: detailsRotation; property: "angle"; duration: 500 }
		}
	}	
	
	
	// the overall view header
	Component {
		id: viewHdr
		Rectangle {
			color: "black"
			height: 60
			width: view.width - 20		
			
			Text {
				id: displaysLabel
				text: "displays"
				font {pixelSize: 24; }
				color: view.currentIndex == 0 ? "white" : "gray"
				MouseArea {
					anchors.fill: parent
					onClicked: { view.currentIndex = 0; view.focus = true; searchFilter.active = false; }
				}
			}
			Text {
				id: displaysNumber
				text: "(%1)".arg(dpfModel.count)
				font {pixelSize: 12; italic: true}
				color: "white"
				anchors.left: displaysLabel.right
			}
			Text {
				id: groupsLabel
				text: "groups"
				font {pixelSize: 24; }
				color: view.currentIndex == 1 ? "white" : "gray"
				anchors {left: displaysNumber.right; leftMargin: 20 }
				MouseArea {
					anchors.fill: parent
					onClicked: { view.currentIndex = 1; view.focus = true; searchFilter.active = false; }
				}
			}
			Text {
				id: groupsNumber
				text: "(%1)".arg(grpModel.count)
				font {pixelSize: 12; italic: true}
				color: "white"
				anchors.left: groupsLabel.right
			}
			Text {
				id: graphsLabel
				text: "graphs"
				font {pixelSize: 24; }
				color: view.currentIndex == 2 ? "white" : "gray"
				anchors {left: groupsNumber.right; leftMargin: 20 }
				MouseArea {
					anchors.fill: parent
					onClicked: { view.currentIndex = 2; view.focus = true; searchFilter.active = false; }
				}
			}
			Text {
				id: graphsNumber
				text: "(%1)".arg(gpfModel.count)
				font {pixelSize: 12; italic: true}
				color: "white"
				anchors.left: graphsLabel.right
			}			
			Text {
				id: sequencesLabel
				text: "sequences"
				font {pixelSize: 24; }
				color: view.currentIndex == 3 ? "white" : "gray"
				anchors {left: graphsNumber.right; leftMargin: 20}
				MouseArea {
					anchors.fill: parent
					onClicked:  { view.currentIndex = 3; view.focus = true; searchFilter.active = false;  }
				}
			}
			Text {
				id: sequencesNumber
				text: "(%1)".arg(seqModel.count)
				font {pixelSize: 12; italic: true}
				color: "white"
				anchors.left: sequencesLabel.right
			}
			
			Text {
				id: qmlLabel
				text: "quicks"
				font {pixelSize: 24; }
				color: view.currentIndex == 4 ? "white" : "gray"
				anchors {left: sequencesNumber.right; leftMargin: 20}
				MouseArea {
					anchors.fill: parent
					onClicked:  { view.currentIndex = 4; view.focus = true; searchFilter.active = false;  }
				}
			}
			
			Text {
				id: qmlNumber
				text: "(%1)".arg(qmlModel.count)
				font {pixelSize: 12; italic: true}
				color: "white"
				anchors.left: qmlLabel.right
			}

			Text {
				id: synLabel
				text: "synoptics"
				font {pixelSize: 24; }
				color: view.currentIndex == 5 ? "white" : "gray"
				anchors {left: qmlNumber.right; leftMargin: 20}
				MouseArea {
					anchors.fill: parent
					onClicked:  { view.currentIndex = 5; view.focus = true; searchFilter.active = false;  }
				}
			}

			Text {
				id: synNumber
				text: "(%1)".arg(synModel.count)
				font {pixelSize: 12; italic: true}
				color: "white"
				anchors.left: synLabel.right
			}			

			Image {
				id: addButton
				source: "metroIcons/Add.png"
				anchors { right: findButton.left ; rightMargin: 10}
				visible: view.currentIndex < 3 && !searchFilter.active
				MouseArea {
					anchors.fill: parent
					onClicked:  { 
						switch(view.currentIndex) {
						case 0:
							dpfModel.selectedDisplayName = "USER%1".arg(dpfModel.count)
							dpcModel.filter = RegExp ( dpfModel.selectedDisplayName )
							dpfModel.selectedDisplayDesc = "Edit new display name and description..."
							dpfModel.editable = true
							dpfModel.hdrEditable = true
							andParamGrid.currentIndex = -1
							searchFilter.active = false
							andFlipView.flipped = true
							break
						case 1:
							grpModel.selectedGroupName = "USER%1".arg(grpModel.count)
							grpaModel.filter = RegExp ( grpModel.selectedGroupName )
							grpModel.selectedGroupDesc = "Edit new group name and description..."
							grpModel.editable = true
							grpModel.hdrEditable = true
							grpParamGrid.currentIndex = -1
							searchFilter.active = false
							grpFlipView.flipped = true
							break
						case 2:
							gpfModel.selectedGraphName = "USER%1".arg(gpfModel.count)
							gpcModel.filter = RegExp ( gpfModel.selectedGraphName )
							gpfModel.selectedGraphDesc = "Edit new graph name and description..."
							gpfModel.editable = true
							gpfModel.hdrEditable = true
							gpfModel.scrollable = true
							gpfModel.seconds = 60
							searchFilter.active = false
							gpfFlipView.flipped = true
							break							
						}
					}
				}
			}			
			Image {
				id: findButton
				source: "metroIcons/Find.png"
				anchors { right: parent.right; rightMargin: 10 }
				MouseArea {
					anchors.fill: parent
					onClicked:  { searchFilter.active = !searchFilter.active }
				}
			}
		}
	}
	
	// header for the display (DPC) view list of parameters
	Component {
		id: dpcHdr
		Rectangle {
			height: 60
			color: "black"
			width: view.width - 20
			TextInput {
				id: dpcDisplayName
				text: dpfModel.selectedDisplayName
				font {pixelSize: 30; }
				color: "white"
				readOnly: ! ( dpfModel.editable && dpfModel.hdrEditable )
				// needed because above binding is only one-way!
				Keys.onPressed: {
					if(event.key >= Qt.Key_Space && event.key <= Qt.Key_AsciiTilde) {
						// because this is called before propagating to the text, the key has not yet been added so we have to add it!
						dpfModel.selectedDisplayName = dpcDisplayName.displayText + event.text // known bug! always inserts at end!
						event.accepted = true
					}
				}
			}			
			Text {
				id: dpcDisplayCount
				text: "(%1)".arg(dpcModel.count)
				font {pixelSize: 10; italic: true}
				color: "white"
				anchors { left: dpcDisplayName.right; }
			}
			TextInput {
				id: dpcDisplayDesc
				text: dpfModel.selectedDisplayDesc
				font {pixelSize: 20; italic: true}
				color: "white"
				anchors { left: dpcDisplayCount.right; top: dpcDisplayName.top; leftMargin: 20; right: parent.right; rightMargin: 60 }
				wrapMode: Text.Wrap
				readOnly: ! dpfModel.editable
				// needed because above binding is only one-way! but without this would need
				Keys.onPressed: {
					if(event.key >= Qt.Key_Space && event.key <= Qt.Key_AsciiTilde) {
						// because this is called before propagating to the text, the key has not yet been added added so we have to add it!
						dpfModel.selectedDisplayDesc = dpcDisplayDesc.displayText + event.text // known bug! always inserts at end!
						event.accepted = true
					}
				}
			}
			Image {
				id: saveDpc
				source: "metroIcons/Save.png"
				anchors { right: exitDpc.left; rightMargin: 20 }
				visible: dpfModel.modified
				MouseArea {
					anchors.fill: parent
					onClicked: {
						if(tm.saveMib("mib","userAndPath","DPC") && tm.saveMib("mib","userAndPath","DPF"))
							dpfModel.modified = false
					}
				}
			}	
			Image {
				id: exitDpc
				source: "metroIcons/Up.png"
				anchors { right: parent.right; rightMargin: 20 }
				MouseArea {
					anchors.fill: parent
					onClicked: {
						mouse.accepted = true
						andFlipView.flipped = false
						dpfModel.editable = false
					}
				}
			}			
		}
	}
	
	// shows one display entry from DPF
    Component {
        id: andDelegate

        Item {
			width: 100; height: 100
			Rectangle {
				anchors.fill: parent
				color: "#a000a0b0"
				Text {
					width: 100
					color: "white"
					font {pixelSize: 12; bold: true; }
					anchors { top: parent.top; }
					text: dpf_numbe
					wrapMode: Text.Wrap
				}

				Image {
					id: alert
					source: "metroIcons/Alert.png"
					anchors.centerIn: parent
					visible: monAlert > 0
					Timer {
						interval: 2000; running: true; repeat: true
						onTriggered: alert.visible = monAlert > 0;
					}
				}
		
				Text {
					width: 100
					color: "white"
					font { pixelSize: 12}
					anchors { bottom: parent.bottom }
					text: dpf_head
					wrapMode: Text.Wrap
				}
			}	        
			MouseArea {
				anchors.fill: parent
				onDoubleClicked: {
					dpcModel.filter = RegExp ( dpf_numbe )
					dpfModel.selectedDisplayName = dpf_numbe
					dpfModel.selectedDisplayDesc = dpf_head
					andParamGrid.currentIndex = -1
					searchFilter.active = false
					andFlipView.flipped = true
				}
				onClicked: {
					andGrid.currentIndex = index
					andGrid.focus = true
				}
			}
        }
    }

	// highlights one display
    Component {
        id: andHighlight
        Rectangle { width: 100; height: 100; color: "lightsteelblue" }
    }
	
	// header for the group (GRPA) view list of parameters
	Component {
		id: grpaHdr
		Rectangle {
			height: 60
			color: "black"
			width: view.width - 20
			TextInput {
				id: grpaDisplayName
				text: grpModel.selectedGroupName
				font {pixelSize: 30; }
				color: "white"
				readOnly: ! ( grpModel.editable && grpModel.hdrEditable )
				// needed because above binding is only one-way!
				Keys.onPressed: {
					if(event.key >= Qt.Key_Space && event.key <= Qt.Key_AsciiTilde) {
						// because this is called before propagating to the text, the key has not yet been added so we have to add it!
						grpModel.selectedGroupName = grpaDisplayName.displayText + event.text // known bug! always inserts at end!
						event.accepted = true
					}
				}
			}			
			Text {
				id: grpaDisplayCount
				text: "(%1)".arg(grpaModel.count)
				font {pixelSize: 10; italic: true}
				color: "white"
				anchors { left: grpaDisplayName.right; }
			}
			TextInput {
				id: grpaDisplayDesc
				text: grpModel.selectedGroupDesc
				font {pixelSize: 20; italic: true}
				color: "white"
				anchors { left: grpaDisplayCount.right; top: grpaDisplayName.top; leftMargin: 20; right: parent.right; rightMargin: 60 }
				wrapMode: Text.Wrap
				readOnly: ! grpModel.editable
				// needed because above binding is only one-way! but without this would need
				Keys.onPressed: {
					if(event.key >= Qt.Key_Space && event.key <= Qt.Key_AsciiTilde) {
						// because this is called before propagating to the text, the key has not yet been added added so we have to add it!
						grpModel.selectedGroupDesc = grpaDisplayDesc.displayText + event.text // known bug! always inserts at end!
						event.accepted = true
					}
				}
			}
			Image {
				id: saveGrpa
				source: "metroIcons/Save.png"
				anchors { right: exitGrpa.left; rightMargin: 20 }
				visible: grpModel.modified
				MouseArea {
					anchors.fill: parent
					onClicked: {
						if(tm.saveMib("mib","userAndPath","GRPA") && tm.saveMib("mib","userAndPath","GRP"))
							grpModel.modified = false
					}
				}
			}	
			Image {
				id: exitGrpa
				source: "metroIcons/Up.png"
				anchors { right: parent.right; rightMargin: 20 }
				MouseArea {
					anchors.fill: parent
					onClicked: {
						mouse.accepted = true
						grpFlipView.flipped = false
						grpModel.editable = false
					}
				}
			}			
		}
	}
	
	// shows one group entry from GRP
    Component {
        id: grpDelegate

        Item {
			width: 100; height: 100
			// this MMI cannot handle *packet* groups!
			enabled: grp_gtype != "PK"  
			Rectangle {
				anchors.fill: parent
				color: "#a0b000a0" 
				Text {
					width: 100
					color: enabled ? "white" : "gray"
					font {pixelSize: 12; bold: true; }
					anchors { top: parent.top; }
					text: grp_name
					wrapMode: Text.Wrap
				}
				
				Image {
					id: alert
					source: "metroIcons/Alert.png"
					anchors.centerIn: parent
					visible: monAlert > 0
					Timer {
						interval: 2000; running: true; repeat: true
						onTriggered: alert.visible = monAlert > 0;
					}
				}

				Text {
					width: 100
					color: enabled ? "white" : "gray"
					font { pixelSize: 12}
					anchors { bottom: parent.bottom }
					text: grp_descr
					wrapMode: Text.Wrap
				}
			}	        
			MouseArea {
				anchors.fill: parent
				onDoubleClicked: {
					grpaModel.filter = RegExp ( grp_name )
					grpModel.selectedGroupName = grp_name
					grpModel.selectedGroupDesc = grp_descr
					grpParamGrid.currentIndex = -1
					searchFilter.active = false
					grpFlipView.flipped = true
				}
				onClicked: {
					grpGrid.currentIndex = index
					grpGrid.focus = true
				}
			}
        }
    }

	// highlights one group
    Component {
        id: grpHighlight
        Rectangle { width: 100; height: 100; color: "pink" }
    }	
	
	// shows one group entry from GPF
    Component {
        id: gpfDelegate

        Item {
			width: 100; height: 100
			Rectangle {
				anchors.fill: parent
				color: "#a00000b0"
				Text {
					width: 100
					color: "white"
					font {pixelSize: 12; bold: true; }
					anchors { top: parent.top; }
					text: gpf_numbe
					wrapMode: Text.Wrap
				}
				
				Text {
					width: 100
					color: "white"
					font { pixelSize: 12}
					anchors { bottom: parent.bottom }
					text: gpf_head
					wrapMode: Text.Wrap
				}
			}	        
			MouseArea {
				anchors.fill: parent
				onDoubleClicked: {
					gpcModel.filter = RegExp ( gpf_numbe )
					gpfModel.selectedGraphName = gpf_numbe
					gpfModel.selectedGraphDesc = gpf_head
					gpfModel.scrollable = gpf_scrol
					gpfModel.seconds = (gpf_days * 3600 * 24) + (gpf_hours * 3600) + (gpf_minut * 60)
					if (gpfModel.seconds < 1) 
						gpfModel.seconds = 60
					searchFilter.active = false
					gpfFlipView.flipped = true
					if (gpfModel.graphChanged) {
						// force the graph to work out the max-max and min-min of all the series
						chartAxisY.min = 100000000
						chartAxisY.max = -100000000
						chartAxisX.max = new Date()
						chartAxisX.min = new Date(chartAxisX.max - (gpfModel.seconds * 1000))
						// QML charts does not seem to have a property for the colour of the grid itself
						switch(gpf_axclr) {
						case 1:
							chartAxisX.color = "green"
							chartAxisY.color = "green"
							break
						case 2:
							chartAxisX.color = "blue"
							chartAxisY.color = "blue"
							break
						case 3:
							chartAxisX.color = "cyan"
							chartAxisY.color = "cyan"				
							break
						case 4:
							chartAxisX.color = "red"
							chartAxisY.color = "red"	
							break
						case 5:
							chartAxisX.color = "yellow"
							chartAxisY.color = "yellow"	
							break
						case 6:
							chartAxisX.color = "magenta"
							chartAxisY.color = "magenta"	
							break
						case 7:
							chartAxisX.color = "white"
							chartAxisY.color = "white"	
							break
						}
						// QML charts does not seem to have any distinction between grid and tick
						if(gpf_xtick > 0)
							chartAxisX.tickCount = gpf_xtick
						if(gpf_ytick > 0)
							chartAxisY.tickCount = gpf_ytick
						gpfModel.graphChanged = false
					}
				}
				onClicked: {
					gpfModel.graphChanged = true
					gpfGrid.currentIndex = index
					gpfGrid.focus = true
				}
			}
        }
    }

	// highlights one graph
    Component {
        id: gpfHighlight
        Rectangle { width: 100; height: 100; color: "skyblue" }
    }	
	
	// shows one test sequence entry from TSEQ
    Component {
        id: seqDelegate

        Item {
			width: 100
			height: 100

			TestSequence {
				id : seq
				script : fileBaseName
			}			
			
			Rectangle {
				anchors.fill: parent
				color: "#a0906050"
				clip: true
				Text {
					width: parent.width
					color: "white"
					font {pixelSize: 12; bold: true; }
					anchors { top: parent.top; }
					text: fileBaseName
					wrapMode: Text.Wrap
				}
				Text {
					height: 60
					y: 30
					color: "white"
					width: parent.width
					font {pixelSize: 12; italic: true }
					horizontalAlignment: Text.AlignRight
					verticalAlignment: Text.AlignVCenter
					text: seq.lastStatusMessage
					wrapMode: Text.WrapAnywhere
					elide: Text.ElideRight
				}
				Text {
					width: parent.width
					color: seq.stateColor
					font {pixelSize: 10; bold: true	}
					anchors { bottom: parent.bottom; }
					text: seq.state
				}
			}	        
			MouseArea {
				anchors.fill: parent
				onPressAndHold: {
					seq.terminate();
				}
				onDoubleClicked: {
					switch ( seq.state ) {
					case 'SUSPENDED': 
					case 'ERROR':
						seq.resume();
						break;
					case 'RUNNING' :
						seq.suspend();
						break;
					case 'IDLE':
					case 'TERMINATED':
						seq.start();
						break;
					}
				}
				onClicked: {
					seqGrid.currentIndex = index
					seqGrid.focus = true
				}
			}
        }
    }

	// highlights one test sequence
    Component {
        id: seqHighlight
        Rectangle { width: 100; height: 100; color: "grey" }
    }

	// shows one test sequence entry from SYN
    Component {
        id: synDelegate

        Item {
			width: 100
			height: 100

			Rectangle {
				anchors.fill: parent
				color: "#a0c0c0ff"
				clip: true
				Text {
					width: parent.width
					color: "white"
					font {pixelSize: 12; bold: true; }
					anchors { top: parent.top; }
					text: fileBaseName
					wrapMode: Text.Wrap
				}
			}
			MouseArea {
				anchors.fill: parent
				onClicked: {
					synGrid.currentIndex = index
					synGrid.focus = true
				}
				onDoubleClicked: {
					synHdr.name = fileBaseName
					console.log("AND opening picture file: " + filePath);
					synViewer.open(filePath)
					synFlipView.flipped = true
				}
			}			
        }
    }

	// highlights one synoptic pic
    Component {
        id: synHighlight
        Rectangle { width: 100; height: 100; color: "grey" }
    }	
	
	// shows one quick script entry from QML
    Component {
        id: qmlDelegate

        Item {
			width: 100; height: 100
			Rectangle {
				anchors.fill: parent
				color: "#a080f080"
				Text {
					width: parent.width
					color: "white"
					font {pixelSize: 12; bold: true; }
					anchors { top: parent.top; }
					text: fileBaseName
					wrapMode: Text.Wrap
				}
			}	        
			MouseArea {
				anchors.fill: parent
				onDoubleClicked: {
					qmlHdr.name = fileBaseName
					console.log("AND opening quick file: " + Qt.resolvedUrl("file:///" + testEnv + "QML/" + fileName));
					quickLoader.source = Qt.resolvedUrl("file:///" + testEnv + "QML/" + fileName)
					qmlFlipView.flipped = true
				}
				onClicked: {
					qmlGrid.currentIndex = index
					qmlGrid.focus = true
				}
			}
        }
    }

	// highlights one qml script
    Component {
        id: qmlHighlight
        Rectangle { width: 100; height: 100; color: "#d0d0d0d0" }
    }		
	
	// shows one parameter
	Component {
		id: andParamDelegate
		Item {
			width: 400; height: 18
						
			Rectangle {
				anchors.fill: parent
				color: "#0a0a0a0a"
				Text {
					id: parName
					width: 80
					color: myParam.monColor
					font {pixelSize: 11; bold: true }
					anchors { left: parent.left; top: parent.top ; bottom: parent.bottom}
					text: myParam.name
					wrapMode: Text.ElideLeft
				}
				Text {
					id: parDescr
					width: 120
					x: 80
					color: myParam.monColor
					font {pixelSize: 11; }
					anchors { top: parent.top ; bottom: parent.bottom}
					text: myParam.pcfRef.pcf_descr
					wrapMode: Text.ElideLeft
				}				
				Text {
					id: parEngValue
					visible: myParam.engValidity
					width: 100
					x: 200
					font {pixelSize: 11; }
					horizontalAlignment: Text.AlignRight
					anchors { top: parent.top ; bottom: parent.bottom}
					text: myParam.engValue
					color: myParam.monColor
					elide: Text.ElideRight
				}
				Text {
					id: parRawValue
					width: myParam.engValidity ? 100 : 200
					font {pixelSize: 11; }
					horizontalAlignment: Text.AlignRight
					anchors { right: parent.right ; top: parent.top ; bottom: parent.bottom}
					text: myParam.rawValue
					color: myParam.monColor
					elide: Text.ElideRight
				}
				
				TmParam {
					id: myParam
					name: dpc_name  + (dpc_comm > 1 ? "#%1".arg(dpc_comm) : "")
				}
			}
			MouseArea {
				anchors.fill: parent
				onDoubleClicked: {
					mouse.accepted = true
					paramDetails.flipped = true
				}
				onClicked: {
					andParamGrid.currentIndex = index
					paramDetails.name = myParam.name
				}
			}
		}
	}
	
	Component {
		id: grpParamDelegate
		Item {
			width: 400; height: 18
						
			Rectangle {
				anchors.fill: parent
				color: "#0a0a0a0a"
				Text {
					id: parName
					width: 80
					color: myParam.monColor
					font {pixelSize: 11; bold: true }
					anchors { left: parent.left; top: parent.top ; bottom: parent.bottom}
					text: myParam.name
					wrapMode: Text.ElideLeft
				}
				Text {
					id: parDescr
					width: 120
					x: 80
					color: myParam.monColor
					font {pixelSize: 11; }
					anchors { top: parent.top ; bottom: parent.bottom}
					text: myParam.pcfRef.pcf_descr
					wrapMode: Text.ElideLeft
				}				
				Text {
					id: parEngValue
					visible: myParam.engValidity
					width: 100
					x: 200
					font {pixelSize: 11; }
					horizontalAlignment: Text.AlignRight
					anchors { top: parent.top ; bottom: parent.bottom}
					text: myParam.engValue
					color: myParam.monColor
					elide: Text.ElideRight
				}
				Text {
					id: parRawValue
					width: myParam.engValidity ? 100 : 200
					font {pixelSize: 11; }
					horizontalAlignment: Text.AlignRight
					anchors { right: parent.right ; top: parent.top ; bottom: parent.bottom}
					text: myParam.rawValue
					color: myParam.monColor
					elide: Text.ElideRight
				}
				
				TmParam {
					id: myParam
					name: grpa_paname 
				}
			}
			MouseArea {
				anchors.fill: parent
				onDoubleClicked: {
					mouse.accepted = true
					paramDetails.flipped = true
				}
				onClicked: {
					grpParamGrid.currentIndex = index
					paramDetails.name = myParam.name
				}
			}
		}
	}
	
	// highlights one parameter
	Component {
        id: paramHighlight
        Rectangle { width: 360; height: 18; color: "#a0a0a0a0" }
    }
	
	// allows there to be a number of different views
	VisualItemModel {
		id: itemModel
		
		// the AND view: flips between summary of DPF (list of displays) and contents of DPC (the parameters)
		Flipable {
			id: andFlipView
			property bool flipped : false
			anchors.fill: theDisplay

			TmFilteredListModel {
				id: dpfModel
				property bool editable : false
				property bool hdrEditable : false
				property bool modified : false
				table: "DPF"
				property string selectedDisplayName: ""
				property string selectedDisplayDesc: ""
				filter: RegExp ( searchFilterText.text )
			}
			
			TmFilteredListModel {
				id: dpcModel
				table: "DPC"
				// a pattern that matches nothing
				filter: /^_$/
			}
			
			front {
				GridView {
					id: andGrid
					header: viewHdr
					anchors  {leftMargin: 20; topMargin: 20; fill: parent }
					cellWidth: 120; cellHeight: 120
					model: dpfModel
					focus: !andFlipView.flipped
					enabled: !andFlipView.flipped
					delegate: andDelegate
					highlight: andHighlight
				}
			}
			back {
				GridView {
					id: andParamGrid
					header: dpcHdr
					anchors  {leftMargin: 20; topMargin: 20; fill: parent }
					cellWidth: 420; cellHeight: 18
					model: dpcModel
					focus: andFlipView.flipped
					enabled: andFlipView.flipped
					delegate: andParamDelegate
					highlight: paramHighlight
					DropArea {
						anchors.fill: parent
						onEntered: {
							// debug: console.log("entered " + drag.keys[0]);
							drag.accepted = false
							if (!dpfModel.editable)
								return
							if (drag.keys[0] == "application/x-tm-param")
								drag.accepted = true
							if (drag.keys[0] == "application/x-mib-pcf")
								drag.accepted = true
						}
						onDropped: {
							// debug console.log("dropped %1".arg(drop.keys[0]));
							console.log("Modifying picture %1".arg(dpfModel.selectedDisplayName))
							drop.accepted = false
							if (!dpfModel.editable)
								return
							// only allow D&D of the right formats
							var format = drop.keys[0]
							if (format == "application/x-tm-param")
								drop.accepted = true
							if (format == "application/x-mib-pcf")
								drop.accepted = true
							if(! drop.accepted )
								return
							// should be something like this!
							//var paramList = drop.mimeData(format)
							// filthy workaround is this! see bug8114 (QML limitation in QT5.0).
							var paramList = tm.bug8114
							for(var n=0; n<paramList.length; n++){
							   // debug: console.log("dropped %1".arg(paramList[n]))
							   var dpc = Qt.createQmlObject('import com.terma.MIB 1.0; TmDpc { }',view,'TmDpc')
							   dpc.source = "userAndPath"
							   dpc.dpc_numbe = dpfModel.selectedDisplayName
							   dpc.dpc_name = paramList[n]
							   dpc.dpc_fldn = dpcModel.count + n
							   dpc.dpc_comm = 0
							   dpc.dpc_mode = false
							   dpc.dpc_form = 'N'
							   dpc.dpc_text = ""
							   tm.appendMibRow(dpc)
							}
							dpfModel.modified = true
							dpcModel.filter = RegExp ( dpfModel.selectedDisplayName )
							// only create this entry if we did not already do it!
							if(!dpfModel.hdrEditable) {
								tm.changeMibDone()
								return
							}
							var dpf = Qt.createQmlObject('import com.terma.MIB 1.0; TmDpf { }',view,'TmDpf')
							dpf.source = "userAndPath"
							dpf.dpf_numbe = dpfModel.selectedDisplayName
							dpf.dpf_type = 3
							dpf.dpf_head = dpfModel.selectedDisplayDesc
							tm.appendMibRow(dpf)
							// if supported by the views, this will ensure that other views update to see the changes...
							tm.changeMibDone()
							// if the AND has changed and been created in the MIB, you should not then change its name on the fly!
							dpfModel.hdrEditable = false
						}
					}
				}
			}
			transform: Rotation {
				id: andRotation
				origin.x: (andFlipView.width+20)/2
				origin.y: (andFlipView.height+20)/2
				axis.x: 1; axis.y: 0 ; axis.z: 0
				angle: 0
			}
			
			states: State {
				name: "back"
				PropertyChanges { target: andRotation; angle: 180 }
				PropertyChanges { target: searchFilter; active: false }
				when: andFlipView.flipped
			} 
				
			transitions: Transition {
				NumberAnimation { target: andRotation; property: "angle"; duration: 500 }
			}
		}
		
		Flipable {
			id: grpFlipView
			property bool flipped : false
			anchors.fill: theDisplay

			TmFilteredListModel {
				id: grpModel
				property bool editable : false
				property bool hdrEditable : false
				property bool modified : false
				table: "GRP"
				property string selectedGroupName: ""
				property string selectedGroupDesc: ""
				filter: RegExp ( searchFilterText.text )
			}
			
			TmFilteredListModel {
				id: grpaModel
				table: "GRPA"
				filter: /^_$/
			}
			
			front {
				GridView {
					id: grpGrid
					header: viewHdr
					anchors  {leftMargin: 20; topMargin: 20; fill: parent }
					cellWidth: 120; cellHeight: 120
					model: grpModel
					focus: !grpFlipView.flipped
					enabled: !grpFlipView.flipped
					delegate: grpDelegate
					highlight: grpHighlight
				}
			}
			back {
				GridView {
					id: grpParamGrid
					header: grpaHdr
					anchors  {leftMargin: 20; topMargin: 20; fill: parent }
					cellWidth: 420; cellHeight: 18
					model: grpaModel
					focus: grpFlipView.flipped
					enabled: grpFlipView.flipped
					delegate: grpParamDelegate
					highlight: paramHighlight
					DropArea {
						anchors.fill: parent
						onEntered: {
							// debug: console.log("entered " + drag.keys[0]);
							drag.accepted = false
							if (!grpModel.editable)
								return
							if (drag.keys[0] == "application/x-tm-param")
								drag.accepted = true
							if (drag.keys[0] == "application/x-mib-pcf")
								drag.accepted = true
						}
						onDropped: {
							// debug console.log("dropped %1".arg(drop.keys[0]));
							console.log("Modifying group %1".arg(grpModel.selectedGroupName))
							drop.accepted = false
							if (!grpModel.editable)
								return
							// only allow D&D of the right formats
							var format = drop.keys[0]
							if (format == "application/x-tm-param")
								drop.accepted = true
							if (format == "application/x-mib-pcf")
								drop.accepted = true
							if(! drop.accepted )
								return
							// should be something like this!
							//var paramList = drop.mimeData(format)
							// filthy workaround is this! see bug8114 (QML limitation in QT5.0).
							var paramList = tm.bug8114
							for(var n=0; n<paramList.length; n++){
							   // debug: console.log("dropped %1".arg(paramList[n]))
							   var grpa = Qt.createQmlObject('import com.terma.MIB 1.0; TmGrpa { }',view,'TmGrpa')
							   grpa.source = "userAndPath"
							   grpa.grpa_gname = grpModel.selectedGroupName
							   grpa.grpa_paname = paramList[n]
							   tm.appendMibRow(grpa)
							}
							grpModel.modified = true
							grpaModel.filter = RegExp ( grpModel.selectedGroupName )
							// only create this entry if we did not already do it!
							if(!grpModel.hdrEditable) {
								tm.changeMibDone()
								return
							}
							var grp = Qt.createQmlObject('import com.terma.MIB 1.0; TmGrp { }',view,'TmGrp')
							grp.source = "userAndPath"
							grp.grp_name = grpModel.selectedGroupName
							grp.grp_descr = grpModel.selectedGroupDesc
							grp.grp_gtype = "PA"
							tm.appendMibRow(grp)
							// if supported by the views, this will ensure that other views update to see the changes...
							tm.changeMibDone()
							// if the group has changed and been created in the MIB, you should not then change its name on the fly!
							grpModel.hdrEditable = false
						}
					}
				}
			}
			transform: Rotation {
				id: grpRotation
				origin.x: (grpFlipView.width+20)/2
				origin.y: (grpFlipView.height+20)/2
				axis.x: 1; axis.y: 0 ; axis.z: 0
				angle: 0
			}
			
			states: State {
				name: "back"
				PropertyChanges { target: grpRotation; angle: 180 }
				when: grpFlipView.flipped
			} 
				
			transitions: Transition {
				NumberAnimation { target: grpRotation; property: "angle"; duration: 500 }
			}
		}

		Flipable {
			id: gpfFlipView
			property bool flipped : false
			anchors.fill: theDisplay

			TmFilteredListModel {
				id: gpfModel
				property bool editable : false
				property bool hdrEditable : false
				property bool modified : false
				property bool scrollable : true
				property bool graphChanged : false
				property int seconds : 60
				table: "GPF"
				property string selectedGraphName: ""
				property string selectedGraphDesc: ""
				filter: RegExp ( searchFilterText.text )
			}
			
			TmFilteredListModel {
				id: gpcModel
				table: "GPC"
				filter: /^_$/
			}
			
			front {
				GridView {
					id: gpfGrid
					header: viewHdr
					anchors  {leftMargin: 20; topMargin: 20; fill: parent }
					cellWidth: 120; cellHeight: 120
					model: gpfModel
					focus: !gpfFlipView.flipped
					enabled: !gpfFlipView.flipped
					delegate: gpfDelegate
					highlight: gpfHighlight
				}
			}
			back {
				// display the graph
				Rectangle {
					anchors.fill: parent
					color: "black"
					
					Rectangle {
						// header for the graph GPC
						id: gpcHdr
						height: 60
						color: "black"
						anchors  { top: parent.top; left: parent.left; right: parent.right; leftMargin: 20; }
						TextInput {
							id: gpcDisplayName
							text: gpfModel.selectedGraphName
							font {pixelSize: 30; }
							color: "white"
							readOnly: ! ( gpfModel.editable && gpfModel.hdrEditable )
							// needed because above binding is only one-way!
							Keys.onPressed: {
								if(event.key >= Qt.Key_Space && event.key <= Qt.Key_AsciiTilde) {
									// because this is called before propagating to the text, the key has not yet been added so we have to add it!
									gpfModel.selectedGraphName = gpcDisplayName.displayText + event.text // known bug! always inserts at end!
									event.accepted = true
								}
							}
						}			
						Text {
							id: gpcDisplayCount
							text: "(%1)".arg(gpcModel.count)
							font {pixelSize: 10; italic: true}
							color: "white"
							anchors { left: gpcDisplayName.right; }
						}
						TextInput {
							id: gpcDisplayDesc
							text: gpfModel.selectedGraphDesc
							font {pixelSize: 20; italic: true}
							color: "white"
							anchors { left: gpcDisplayCount.right; top: gpcDisplayName.top; leftMargin: 20; right: parent.right; rightMargin: 60 }
							wrapMode: Text.Wrap
							readOnly: ! gpfModel.editable
							// needed because above binding is only one-way! but without this would need
							Keys.onPressed: {
								if(event.key >= Qt.Key_Space && event.key <= Qt.Key_AsciiTilde) {
									// because this is called before propagating to the text, the key has not yet been added added so we have to add it!
									gpfModel.selectedGraphDesc = gpcDisplayDesc.displayText + event.text // known bug! always inserts at end!
									event.accepted = true
								}
							}
						}
						Image {
							id: saveGpc
							source: "metroIcons/Save.png"
							anchors { right: exitGpc.left; rightMargin: 20 }
							visible: gpfModel.modified
							MouseArea {
								anchors.fill: parent
								onClicked: {
									if(tm.saveMib("mib","userAndPath","GPC") && tm.saveMib("mib","userAndPath","GPF"))
										gpfModel.modified = false
								}
							}
						}	
						Image {
							id: exitGpc
							source: "metroIcons/Up.png"
							anchors { right: parent.right; rightMargin: 20 }
							MouseArea {
								anchors.fill: parent
								onClicked: {
									mouse.accepted = true
									gpfFlipView.flipped = false
									gpfModel.editable = false
								}
							}
						}			
					}
					
					Component {
						id: chartParamLine
						Item {
							TmParam {
								property LineSeries mySeries : null
												
								id: myParam
								prolific: true
								name: gpc_name
								Component.onCompleted:  {
									// console.log("completed: " + name)
									if(mySeries == null) {
										// console.log( "creating series for: " + gpc_name)
										mySeries = chartView.createSeries ( ChartView.SeriesTypeLine, gpc_name, chartAxisX, chartAxisY)
										//console.log ( "gpc_numbe " + gpc_numbe )
										//console.log ( "gpc_pos " + gpc_pos )
										//console.log ( "gpc_where " + gpc_where )
										//console.log ( "gpc_name " + gpc_name )
										//console.log ( "gpc_raw " + gpc_raw )
										//console.log ( "gpc_minim " + gpc_minim )
										//console.log ( "gpc_maxim " + gpc_maxim )
										switch ( gpc_prclr ) {
										case 1:
											mySeries.color = "green"
											break
										case 2:
											mySeries.color = "blue"
											break
										case 3:
											mySeries.color = "cyan"
											break
										case 4:
											mySeries.color = "red"
											break
										case 5:
											mySeries.color = "yellow"
											break
										case 6:
											mySeries.color = "magenta"
											break
										case 7:
											mySeries.color = "white"
											break
										}
										switch ( gpc_line ) {
										case 1:
											mySeries.style = Qt.SolidLine
											break
										case 2:
											mySeries.style = Qt.DashLine
											break
										case 3:
											mySeries.style = Qt.DotLine
											break
										case 4:
											mySeries.style = Qt.DashDotLine
											break
										case 5:
											mySeries.style = Qt.DashDotDotLine
											break												
										}
									}
									if(gpc_maxim > chartAxisY.max)
										chartAxisY.max = gpc_maxim
									if(gpc_minim < chartAxisY.min)
										chartAxisY.min = gpc_minim
									// until the Y val exceeds the axis max min, keep the user's specified max/min
									//chartAxisY.applyNiceNumbers()
								}
								Component.onDestruction:  {
									// console.log("destroyed: " + name)
									chartView.removeSeries ( mySeries )
									mySeries = null
									gpfModel.graphChanged = true
								}								
								onUpdated: {
									if (mySeries == null) {
										console.log ("updated %1 but no series exists!".arg(name))
										return
									}
									var now = generationDateTime
									var val = engValue ;
									if(gpc_raw == "U")
										val = rawValue ;
									if(gpc_raw == 85)
										val = rawValue ;										
									//console.log ( "updated: %1 %2 gpc_raw = %3 rxt=%4".arg(name).arg(val).arg(gpc_raw).arg(now) )
									// without this the chart does not scroll and the new point will not be seen!
									if(gpfModel.scrollable)
										if (now > chartAxisX.max)
											chartAxisX.max = now
									if(val > chartAxisY.max) {
										chartAxisY.max = val
										chartAxisY.applyNiceNumbers()
									} else if(val < chartAxisY.min) {
										chartAxisY.min = val
										chartAxisY.applyNiceNumbers()
									}
									mySeries.append( now, val )
								}
							}							
						}
					}
					ListView {
						id: chartParamList
						visible: false
						model: gpcModel
						delegate: chartParamLine
					}
					ChartView {
						id: chartView
						width: view.width
						anchors { top: gpcHdr.bottom; bottom: parent.bottom; bottomMargin: 20 }
						theme: ChartView.ChartThemeDark
						ValueAxis {
							id: chartAxisY
							min: 100000000
							max: -100000000
							//useNiceNumbers: true
						}

						DateTimeAxis {
							id: chartAxisX
							max: new Date()
							min: new Date(max - (gpfModel.seconds * 1000)) // default is one minute of display
						}
						DropArea {
							anchors.fill: parent
							onEntered: {
								// debug: console.log("entered " + drag.keys[0]);
								drag.accepted = false
								if (!gpfModel.editable)
									return
								if (drag.keys[0] == "application/x-tm-param")
									drag.accepted = true
								if (drag.keys[0] == "application/x-mib-pcf")
									drag.accepted = true
							}
							onDropped: {
								// debug console.log("dropped %1".arg(drop.keys[0]));
								console.log("Modifying graph %1".arg(gpfModel.selectedGraphName))
								drop.accepted = false
								if (!gpfModel.editable)
									return
								// only allow D&D of the right formats
								var format = drop.keys[0]
								if (format == "application/x-tm-param")
									drop.accepted = true
								if (format == "application/x-mib-pcf")
									drop.accepted = true
								if(! drop.accepted )
									return
								// should be something like this!
								//var paramList = drop.mimeData(format)
								// filthy workaround is this! see bug8114 (QML limitation in QT5.0).
								var paramList = tm.bug8114
								for(var n=0; n<paramList.length; n++){
								   // debug: console.log("dropped %1".arg(paramList[n]))
								   var gpc = Qt.createQmlObject('import com.terma.MIB 1.0; TmGpc { }',view,'TmGpc')
								   gpc.source = "userAndPath"
								   gpc.gpc_numbe = gpfModel.selectedGraphName
								   gpc.gpc_pos = n + 1
								   gpc.gpc_where = 1
								   gpc.gpc_name = paramList[n]
								   gpc.gpc_raw = "U"
								   gpc.gpc_minim = 0
								   gpc.gpc_maxim = 255
								   gpc.gpc_prclr = 0
								   gpc.gpc_symbo = 0
								   gpc.gpc_line = 0
								   tm.appendMibRow(gpc)
								}
								gpfModel.modified = true
								gpcModel.filter = RegExp ( gpfModel.selectedGraphName )
								// only create this entry if we did not already do it!
								if(!gpfModel.hdrEditable) {
									tm.changeMibDone()
									return
								}
								var gpf = Qt.createQmlObject('import com.terma.MIB 1.0; TmGpf { }',view,'TmGpf')
								gpf.source = "userAndPath"
								gpf.gpf_numbe = gpfModel.selectedGraphName
								gpf.gpf_type = "F"
								gpf.gpf_head = gpfModel.selectedGraphDesc
								gpf.gpf_scrol = true
								gpf.gpf_hcopy = false
								gpf.gpf_days = 0
								gpf.gpf_hours = 0
								gpf.gpf_minut = 1
								gpf.gpf_axclr = 0 // automatic from graph theme!
								gpf.gpf_xtick = 0
								gpf.gpf_ytick = 0
								gpf.gpf_xgrid = 0
								gpf.gpf_ygrid = 0
								tm.appendMibRow(gpf)
								// if supported by the views, this will ensure that other views update to see the changes...
								tm.changeMibDone()
								// if the group has changed and been created in the MIB, you should not then change its name on the fly!
								gpfModel.hdrEditable = false
							}
						}						
					}

				}
			}
			transform: Rotation {
				id: gpfRotation
				origin.x: (gpfFlipView.width+20)/2
				origin.y: (gpfFlipView.height+20)/2
				axis.x: 1; axis.y: 0 ; axis.z: 0
				angle: 0
			}
			
			states: State {
				name: "back"
				PropertyChanges { target: gpfRotation; angle: 180 }
				when: gpfFlipView.flipped
			} 
				
			transitions: Transition {
				NumberAnimation { target: gpfRotation; property: "angle"; duration: 500 }
			}
		}		
		
		Rectangle {
			anchors.fill: theDisplay
			color: "black"
			
			FolderListModel {
				id: seqModel
				showDirs: false
				folder: "file:" + testEnv + "TSEQ"
				nameFilters: [searchFilterText.text + "*.tcl"]
			}
			
			GridView {
				id: seqGrid
				anchors  {leftMargin: 20; topMargin: 20; fill: parent }
				header: viewHdr
				model: seqModel
				delegate: seqDelegate
				highlight: paramHighlight
				cellWidth: 120; cellHeight: 120
				cacheBuffer: 0
			}
		}
		
		Flipable {
			id: qmlFlipView
			property bool flipped : false
			anchors.fill: theDisplay
			
			FolderListModel {
				id: qmlModel
				showDirs: false
				showOnlyReadable: true
				sortField: FolderListModel.Name
				folder: "file:" + testEnv + "QML"
				// see bug 8145 - not fully understood why this is needed for QML but not for TSEQ
				nameFilters: [ "?*.qml" ]
				Binding on nameFilters {
					when: searchFilter.active
					value: [ searchFilterText.text + "*.qml"]
				}
				Binding on nameFilters {
					when: !searchFilter.active
					value: [ "?*.qml"]
				}
			}
			
			front {
				GridView {
					id: qmlGrid
					anchors  {leftMargin: 20; topMargin: 20; fill: parent }
					focus: !qmlFlipView.flipped
					enabled: !qmlFlipView.flipped
					header: viewHdr
					model: qmlModel
					delegate: qmlDelegate
					highlight: paramHighlight
					cellWidth: 120; cellHeight: 120
					cacheBuffer: 256
				}
			}

			back {
				// header for the current QML (quick) view
				Rectangle {
					anchors.fill: parent
					color: "black"
					
					Rectangle {
						id: qmlHdr
						property string name : "*no name*"
						height: 60
						color: "black"
						anchors  { top: parent.top; left: parent.left; right: parent.right; leftMargin: 20; topMargin: 20; }
						Text {
							id: qmlName
							text: "QML: " + qmlHdr.name
							font {pixelSize: 30; }
							color: "white"
						}			
						Image {
							source: "metroIcons/Up.png"
							anchors { right: parent.right; rightMargin: 20 }
							MouseArea {
								anchors.fill: parent
								onClicked: {
									mouse.accepted = true
									qmlFlipView.flipped = false
								}
							}
						}
					}
					Loader {
						id: quickLoader
						width: view.width
						anchors { top: qmlHdr.bottom; bottom: parent.bottom }
					}							
				}
			
			}
			transform: Rotation {
				id: qmlRotation
				origin.x: (qmlFlipView.width)/2
				origin.y: (qmlFlipView.height)/2
				axis.x: 1; axis.y: 0 ; axis.z: 0
				angle: 0
			}
			
			states: State {
				name: "back"
				PropertyChanges { target: qmlRotation; angle: 180 }
				PropertyChanges { target: searchFilter; active: false }
				when: qmlFlipView.flipped
			} 
				
			transitions: Transition {
				NumberAnimation { target: qmlRotation; property: "angle"; duration: 500 }
			}			
		}
		
		Flipable {
			id: synFlipView
			property bool flipped : false
			anchors.fill: theDisplay
			
			FolderListModel {
				id: synModel
				showDirs: false
				showOnlyReadable: true
				sortField: FolderListModel.Name
				folder: "file:" + testEnv + "SYN"
				nameFilters: [searchFilterText.text + "*.sxl"]
			}
			
			front {
				GridView {
					id: synGrid
					anchors  {leftMargin: 20; topMargin: 20; fill: parent }
					focus: !synFlipView.flipped
					enabled: !synFlipView.flipped
					header: viewHdr
					model: synModel
					delegate: synDelegate
					highlight: paramHighlight
					cellWidth: 120; cellHeight: 120
				}
			}

			back {
				// header for the current SYN (synoptic) view
				Rectangle {
					anchors.fill: parent
					color: "black"
					
					Rectangle {
						id: synHdr
						property string name : "*no name*"
						height: 60
						color: "black"
						anchors  { top: parent.top; left: parent.left; right: parent.right; leftMargin: 20; topMargin: 20; }
						Text {
							id: synName
							text: synViewer.baseName
							font {pixelSize: 30; }
							color: "white"
						}
						Text {
							id: synMnemonic
							text: synViewer.mnemonic
							font {pixelSize: 10; italic: true}
							color: "white"
							anchors { left: synName.right; }
						}
						Text {
							id: synTitle
							text: synViewer.title
							font {pixelSize: 20; italic: true}
							color: "white"
							anchors { left: synMnemonic.right; }
						}		
						Image {
							source: "metroIcons/Up.png"
							anchors { right: parent.right; rightMargin: 20 }
							MouseArea {
								anchors.fill: parent
								onClicked: {
									mouse.accepted = true
									synFlipView.flipped = false
								}
							}
						}
					}
					Rectangle {
						// a default background, in case there is no picture info giving a background brush in the picture
						color: "#FFA0A0A0"
						anchors { top: synHdr.bottom; bottom: parent.bottom }
						width: view.width
						SynViewer {
							id: synViewer
							anchors.fill: parent
						}
						PinchArea {
							anchors { fill: parent }
						}
					}
							
				}
			
			}
			transform: Rotation {
				id: synRotation
				origin.x: (synFlipView.width)/2
				origin.y: (synFlipView.height)/2
				axis.x: 1; axis.y: 0 ; axis.z: 0
				angle: 0
			}
			
			states: State {
				name: "back"
				PropertyChanges { target: synRotation; angle: 180 }
				PropertyChanges { target: searchFilter; active: false }
				when: synFlipView.flipped
			} 
				
			transitions: Transition {
				NumberAnimation { target: synRotation; property: "angle"; duration: 500 }
			}			
		}		
		
	}

	ListView {
        id: view
        anchors { fill: parent }
		focus: false
        model: itemModel
        // see bug#8204, reported to Digia.... StrictlyEnforceRange is better but crashes in QT5.1
		highlightRangeMode: ListView.StrictlyEnforceRange
		//highlightRangeMode: ListView.ApplyRange
		highlightMoveDuration: 800
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem; 
    }
	
	Component.onCompleted:  {
		// if called from the toolbar only the QML file name argument exists
		if (argList.length < 2)
			return
		// otherwise we were called from AND::open, or QML::open
		dpcModel.filter = RegExp ( argList[1] )
		dpfModel.selectedDisplayName = argList[1]
		var hdr = tm.findMibField("DPF", "dpf_numbe", argList[1], "dpf_head")
		// if no DPF matches this name, use the second argument as description
		dpfModel.selectedDisplayDesc = hdr == "" ? argList[2] : hdr
		// it is editable if it does not already exist
		dpfModel.editable = hdr == ""
		dpfModel.hdrEditable = dpfModel.editable
		andParamGrid.currentIndex = -1
		andFlipView.flipped = true
	}
}