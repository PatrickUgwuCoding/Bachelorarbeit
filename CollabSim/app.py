from flask import Flask, jsonify
from flask_socketio import SocketIO, emit
import websocket
import threading
try:
    import threading
except ImportError:
    import _thread as thread
import requests
import time
import json



# Flask-App erstellen
app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins='*')  

#CORS(app)

# variables
clientCount = 0
var1 = 'vari'
msg = 'mssi'
aceT = "inital"
aceC = ''

with open(r'C:\Users\patri\Desktop\sharedArgosFolder\customExperiments\custom_experiment.argos', 'r') as file:    
    aceX = file.read()

ws = None

# WebSocket-Verbindung zu ARGoS Webviz
def websocket_thread():
    global ws
    ws = websocket.WebSocketApp("ws://192.168.178.32:3000?broadcasts",
                                on_open=on_open,
                                on_message=on_message,
                                on_error=on_error,
                                on_close=on_close)
    ws.run_forever()


def on_message(ws, message):
    print(message)
    print(json.loads(message)['state'])


def on_error(ws, error):
    print(error)


def on_close(ws):
    ws.close()
    print("### closed ###")


def on_open(ws):

    def run(*args):
        time.sleep(1)
        # Start playing experiment, and wait for 1 second
        ws.send("{\"command\":\"play\"}")
        time.sleep(1)

        # # pause the experiment, and wait for 1 second
        # ws.send("{\"command\":\"pause\"}")
        # time.sleep(1)

        # # reset the experiment, and wait for 1 second
        # ws.send("{\"command\":\"reset\"}")
        # time.sleep(1)

        # # exit the client safely
        # ws.close()
        # print("thread terminating...")

        print("end")

    threading.Thread(target=run).start()
    #thread.start_new_thread(run, ())

# WebSocket-Verbindung starten
#threading.Thread(target=websocket_thread).start()




# Send Flag to reload the simulation
@socketio.on('restart_script')
def restart_script_on_vm():
    print("im  server angekommen")
    vm_api_url = 'http://192.168.178.32:7979/restart'  # URL zur Flask-Anwendung auf der VM
    try:
        response = requests.get(vm_api_url)
        if response.status_code == 200:
            emit('script_status', {'status': 'success', 'message': 'Script restarted successfully'})
        else:
            emit('script_status', {'status': 'error', 'message': 'Failed to restart script'})
    except requests.RequestException as e:
        emit('script_status', {'status': 'error', 'message': str(e)})



@socketio.on('message')
def handle_message(message):
    # Handle incoming message from the client
    global var1
    global msg
    global aceT
    global aceC
    global aceX
    global ws

    emit('msg', message, broadcast=True)
    #socketio.emit('msg', message)
    if (message[0]=='var1'):
        var1=message[1]
    elif (message[0]=='msg'):
        msg = message[1]
    elif (message[0]=='aceT' ):
        aceT = message[1]
    elif (message[0]=='aceC' ):
        aceC = message[1]
    elif (message[0]=='aceX'):
        aceX = message[1]
    

@socketio.on('cmd')
def handle_command(cmd):
    # Handle incoming message from the client
    global ws
    if (cmd == 'close'):
        ws.close()
        print("thread terminating...")
    elif (cmd=='play'):
        ws.send("{\"command\":\"play\"}")
        time.sleep(1)
    elif (cmd=='pause'):
        ws.send("{\"command\":\"pause\"}")
        time.sleep(1)


@socketio.on('init')
def init():
    # connected clients gets current session
    
    socketio.emit('msg', ['var1',var1])
    socketio.emit('msg', ['msg',msg])
    socketio.emit('msg', ['aceT',aceT])
    socketio.emit('msg', ['aceC',aceC])
    socketio.emit('msg', ['aceX',aceX])



@socketio.on('saveXml') 
def saveXml(xml):
    global aceX
    with open("C:/Users/patri/Desktop/sharedArgosFolder/customExperiments/custom_experiment.argos","w") as file:
        file.write(xml)
        aceX = xml

@socketio.on('saveCpp') 
def saveCpp(cpp):
    global aceC
    with open("C:/Users/patri/Desktop/sharedArgosFolder/customExperiments/footbot_diffusion.cpp","w") as file:
        file.write(cpp)
        aceC = cpp


@socketio.on('connect')
def handle_connect():
    # Handle client connection
    global clientCount
    clientCount += 1
    print('Client connected')
    socketio.emit('clientCount', clientCount)


@socketio.on('disconnect')
def handle_disconnect():
    # Handle client connection
    global clientCount
    global var1
    global msg
    global aceT
    global aceC
    global aceX
    
    clientCount -= 1
    print('Client disconnected')
    socketio.emit('clientCount', clientCount)
    
    # clear variables if all clients left (and not saved?)
    if (clientCount == 0):
        print("keine Clients anwesend")
        var1 = []
        msg = []
        aceT = []
        aceC = []
        with open(r'C:\Users\patri\Desktop\sharedArgosFolder\customExperiments\custom_experiment.argos', 'r') as file:    
            aceX = file.read()




# Startseite definieren
@app.route('/')
def start():
    return "Hallo vom Backend"


@app.route('/klasse')
def getData():
    data = {'message':'Hallo, kannst du mich hören'}
    return jsonify(data)




if __name__ == '__main__':
    print("starting webservice")
    socketio.run(app)  
    
   
