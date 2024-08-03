#Importaciones
import sys                                                      #Importacion necesaria para iniciar o finalizar la ventana
from PySide6.QtGui import QGuiApplication                       #Importacion que permite la visualizacion grafica
from PySide6.QtQml import QQmlApplicationEngine                 #Importacion que permite trabajar con QML


#Declaracion de variables
app = QGuiApplication(sys.argv)                               
engine = QQmlApplicationEngine()                

#Carga              
engine.load('E_qml.qml')                                      #Carga el archivo QML (es importante registrar la ruta relativa del QML)

#Cierre
sys.exit(app.exec())                               

