import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window


//Creating the window and properties
ApplicationWindow {
    id: window
    visible: true
    title: "No visible"
    minimumWidth: 240
    minimumHeight: 320
    width: 640
    height: 480
    //Erase the title bar
    flags: Qt.Window | Qt.FramelessWindowHint               
    
    //Function for control size 
    Connections{
        id: control_size_complement
        target: window

        onWindowStateChanged: {
            //if is not maximized changue the icon
            if (properties.detecting_size === "maximized" && (window.height !== Screen.height || window.width !== Screen.width || window.x !== 0 || window.y !== 0)) {
                properties.detecting_size = "normal"
                icon_maximize_title_bar.source = "maximize.png"
                properties.mouse_area_enabled = true
                
            //if the window is down and the status change show the window maximized 
            } else if (properties.detecting_size === "minimized") {
                properties.detecting_size = "maximized"
                window.showMaximized()
            }
        }
    }

    //Properties
    Item{
        id: properties
        property var title_bar_color: "#212121"                  //Hover
        property var focus_title_bar_color: "#345e64"
        property var detecting_size: "wating"                    //Control of size
        property var mouse_area_enabled: true                    //Control for resizing in mouseareas
        }
    
//Global View (the view without tittle bar)
Rectangle {
    id: global_view
    width: window.width
    height: window.height - 30
    y: 30
}

//Resizing the 4 sides------------------------------------------

//Mouseareas for Resizing 
Rectangle{
    id: global_window
    width: window.width
    height: window.height
    color: "transparent"

    //Resize the top side
    MouseArea {
        id: resize_top
        enabled: properties.mouse_area_enabled
        width: global_window.width - 20
        height: 8
        anchors.horizontalCenter: global_window.horizontalCenter 
        anchors.top: global_window.top 
        cursorShape: resize_top.enabled ? Qt.SizeVerCursor : Qt.ArrowCursor

        //Movements control
        onPressed: {window.startSystemResize(Qt.TopEdge)}
        }

    //Resize the down side
    MouseArea {
        id: resize_down
        enabled: properties.mouse_area_enabled
        width: global_window.width - 40
        height: 8
        anchors.horizontalCenter: global_window.horizontalCenter 
        anchors.bottom: global_window.bottom
        cursorShape: resize_down.enabled ? Qt.SizeVerCursor : Qt.ArrowCursor

        //Movements control
        onPressed: {window.startSystemResize(Qt.BottomEdge)}
        }

    //Resize the left side
    MouseArea {
        id: resize_left
        enabled: properties.mouse_area_enabled
        width: 8
        height: global_window.height - 40
        anchors.verticalCenter: global_window.verticalCenter 
        anchors.left: global_window.left 
        cursorShape: resize_left.enabled ? Qt.SizeHorCursor : Qt.ArrowCursor

        //Movements control
        onPressed:{window.startSystemResize(Qt.LeftEdge)}
        }       

    //Resize the right side
    MouseArea {
        id: resize_right
        enabled: properties.mouse_area_enabled
        width: 8
        height: global_window.height - 40
        anchors.verticalCenter: global_window.verticalCenter 
        anchors.right: global_window.right
        cursorShape: resize_right.enabled ? Qt.SizeHorCursor : Qt.ArrowCursor

        //Movements control
        onPressed: {window.startSystemResize(Qt.RightEdge)}
        }

    //Resizing the 4 corners-------------------------------------

    //Resize the left & top
    MouseArea {
        id: resize_left_top
        enabled: properties.mouse_area_enabled
        width: 16
        height: 16
        anchors.top: global_window.top
        anchors.left: global_window.left
        cursorShape: resize_left_top.enabled ? Qt.SizeFDiagCursor : Qt.ArrowCursor

        //Movements control
        onPressed:{window.startSystemResize(Qt.LeftEdge | Qt.TopEdge)}   
        }

    //Resize the right & top
    MouseArea {
        id: resize_right_top
        enabled: properties.mouse_area_enabled
        width: 8
        height: 8
        anchors.top: global_window.top
        anchors.right: global_window.right
        cursorShape: resize_right_top.enabled ? Qt.SizeBDiagCursor : Qt.ArrowCursor

        //Movements control
        onPressed:{window.startSystemResize(Qt.RightEdge | Qt.TopEdge)}
        }

    //Resize the left & bottom
    MouseArea {
        id: resize_left_bottom
        enabled: properties.mouse_area_enabled
        width: 16
        height: 16
        anchors.bottom: global_window.bottom
        anchors.left: global_window.left
        cursorShape: resize_left_bottom.enabled ? Qt.SizeBDiagCursor : Qt.ArrowCursor

        //Movements control
        onPressed:{window.startSystemResize(Qt.LeftEdge | Qt.BottomEdge)}   
        }
    //Resize the right & bottom
    MouseArea {
        id: resize_right_bottom
        enabled: properties.mouse_area_enabled
        width: 16
        height: 16
        anchors.bottom: global_window.bottom
        anchors.right: global_window.right
        cursorShape: resize_right_bottom.enabled ? Qt.SizeFDiagCursor : Qt.ArrowCursor

        //Movements control
        onPressed: {window.startSystemResize(Qt.RightEdge | Qt.BottomEdge)}
        }   
}


//Creating title bar-------------------------------------------

//Size of tittle bar
Rectangle {
    id: top_bar
    height: 30
    width: global_view.width
    color: properties.title_bar_color

    //Movement of window    
    MouseArea {
        id: movement_window
        width: top_bar.width
        height: top_bar.height - 4
        y: 4.5
        onPressed: {
            window.startSystemMove();
        }

        //Changing status of window with doubleclick
        onDoubleClicked: {

            //if is maximized, change to normal
            if (window.height === Screen.height && window.width === Screen.width && window.x === 0 && window.y === 0) {
                window.showNormal()
                icon_maximize_title_bar.source = "maximize.png"
                properties.mouse_area_enabled = true
            }
            //else change to maximized
            else{
                window.showMaximized()
                icon_maximize_title_bar.source = "normal.png"
                properties.detecting_size = "maximized"
                properties.mouse_area_enabled = false
                }
        }
    }

    //Elements for title bar
    RowLayout{
        width: global_view.width
        height: top_bar.height    
        spacing: 0
    
        //Icon for name---------------------------
        Rectangle {
            id: icon_program_title_bar
            width: 15
            height: parent.height
            color: "red"
            Layout.leftMargin: 15
            }

        //Name program-----------------------------
        Rectangle {
            id: name_titte_bar
            height: parent.height 
            color: "transparent"
            Layout.fillWidth: true
            Layout.leftMargin: 12

            //Name program, Text
            Text{
                text: "Title"
                color: "white"
                font.pixelSize: 14
                font.family: "Helvetica"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        //Minimize--------------------------------
        Rectangle {
            id: minimize_title_bar
            width: Screen.width * 0.03
            height: parent.height
            color: hover_minimize.hovered ? properties.focus_title_bar_color : "transparent"

            //Icon
            Image {
                id: icon_minimize_title_bar
                source: "minimize.png" 
                anchors.centerIn: parent
                width: 12
                fillMode: Image.PreserveAspectFit
            }
            //Event for minimize
            MouseArea {
                id: minimize_event
                anchors.fill: parent
                onClicked: {
                    window.showMinimized()
                    if(properties.detecting_size === "maximized")
                    properties.detecting_size = "minimized"
                }    
            }
            //Efect Hover
            HoverHandler {
                id: hover_minimize
            }
        }

        //Maximize-------------------------------
        Rectangle {
            id: maximize_title_bar
            width: Screen.width * 0.03
            height: parent.height 
            color: hover_maximize.hovered ? properties.focus_title_bar_color : "transparent"

            //Icon
            Image {
                id: icon_maximize_title_bar
                source: "maximize.png"
                anchors.centerIn: parent
                width: 12
                fillMode: Image.PreserveAspectFit
            }
            //Event for maximize and normal
            MouseArea {
                id: maximize_event
                anchors.fill: parent

                //If is maximized change to normal 
                onClicked: {
                    if (window.height === Screen.height && window.width === Screen.width && window.x === 0 && window.y === 0) {
                        icon_maximize_title_bar.source = "maximize.png"
                        properties.mouse_area_enabled = true
                        window.showNormal()
                        
                    }

                    //If is normal change to maximized 
                    else{
                        properties.detecting_size = "maximized"
                        icon_maximize_title_bar.source = "normal.png"
                        properties.mouse_area_enabled = false
                        window.showMaximized()
                        }
                    }

            //Efect Hover
            HoverHandler {
                id: hover_maximize
                }
            }
        }
        
        //Close-------------------------------
        Rectangle {
            id: close_title_bar
            width: Screen.width * 0.03
            height: parent.height 
            color: hover_close.hovered ? "red" : "transparent"

            //Icon
            Image {
                id: icon_close_title_bar
                source: "close.png" // Ruta de tu imagen
                anchors.centerIn: parent
                width: 14
                fillMode: Image.PreserveAspectFit
            }

            //Event for close
            MouseArea {
                id: close_event
                anchors.fill: parent
                onClicked: Qt.quit()
            }

            //Hover
            HoverHandler {
                id: hover_close
            }
        } 
    }
}

}
