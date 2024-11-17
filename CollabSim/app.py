from flask import Flask, jsonify
from flask_socketio import SocketIO, emit
import requests


# Constants
XML_FILE_PATH = r"C:\Users\patri\Desktop\studiumkram\Robotik\BA\sharedArgosFolder\customExperiments\custom_experiment.argos"
CPP_FILE_PATH = r"C:\Users\patri\Desktop\studiumkram\Robotik\BA\sharedArgosFolder\customExperiments\footbot_diffusion.cpp"

# Flask-App erstellen
app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins='*')  


# Variables
clientCount = 0

with open(XML_FILE_PATH, 'r') as file:    
    aceX = file.read()

with open(CPP_FILE_PATH, 'r') as file:    
    aceC = file.read()



# Send Flag to reload the simulation
@socketio.on('restart_script')
def restart_script_on_vm():
    print("sending request to restart the simulation in VM")
    vm_api_url = 'http://192.168.178.32:7979/restart'  # URL of VM webserver
    try:
        response = requests.get(vm_api_url)
        if response.status_code == 200:
            emit('script_status', {'status': 'success', 'message': 'Script restarted successfully'})
        else:
            emit('script_status', {'status': 'error', 'message': 'Failed to restart script'})
    except requests.RequestException as e:
        emit('script_status', {'status': 'error', 'message': str(e)})


# Handle incoming message from the client
@socketio.on('message')
def handle_message(message):
    global aceC
    global aceX

    emit('msg', message, broadcast=True)
    if (message[0]=='aceC' ):
        aceC = message[1]
    elif (message[0]=='aceX'):
        aceX = message[1]
    

# connected clients receiving the current session
@socketio.on('init')
def init():
    socketio.emit('msg', ['aceC',aceC])
    socketio.emit('msg', ['aceX',aceX])


# saving the changed XML file
@socketio.on('saveXml') 
def saveXml(xml):
    global aceX
    with open(XML_FILE_PATH,"w") as file:
        file.write(xml)
        print()
        aceX = xml

# saving the changed C++ file
@socketio.on('saveCpp') 
def saveCpp(cpp):
    global aceC
    with open(CPP_FILE_PATH,"w") as file:
        file.write(cpp)
        aceC = cpp


# Handle clients connecting
@socketio.on('connect')
def handle_connect():
    global clientCount

    clientCount += 1
    print('Client connected')
    socketio.emit('clientCount', clientCount)


# Handle clients disconnecting
@socketio.on('disconnect')
def handle_disconnect():
    global clientCount
    global aceC
    global aceX
    
    clientCount -= 1
    print('Client disconnected')
    socketio.emit('clientCount', clientCount)
    
    # clear variables if all clients left 
    if (clientCount == 0):
        print("keine Clients anwesend")
        with open(CPP_FILE_PATH, 'r') as file1:    
            aceC = file1.read()
        with open(XML_FILE_PATH, 'r') as file2:    
            aceX = file2.read()


# define homescreen
@app.route('/')
def start():
    return "Hallo vom Backend"



if __name__ == '__main__':
    print("starting webservice")
    socketio.run(app, host='0.0.0.0', port=5000)  