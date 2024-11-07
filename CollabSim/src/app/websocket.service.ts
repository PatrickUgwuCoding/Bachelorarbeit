import { Injectable } from '@angular/core';
import {io, Socket} from 'socket.io-client';

@Injectable({
  providedIn: 'root'
})
export class WebSocketService {

  private socket: Socket;
  
  constructor() {
    this.socket = io('http://localhost:5000'); 
    console.log('Connected to Flask WebSocket Server');
    
    
    this.socket.on('clientCount', (count: any) => {
      console.log('Clients: ' + count);

    });
   }

  
   sendMessage(id:string, message: string) {
    this.socket.emit('message', [id,message]);
  }

  getTextUpdates(callback:(msg: any) => void) {
    this.socket.on('msg', callback);
  }

  sendCommand(id:string) {
    this.socket.emit('cmd', id);
  }

  reloadSim() {
    this.socket.emit('restart_script');
  }

  init(){
    this.socket.emit('init');
  }

  saveXml(xml: any) {
    this.socket.emit('saveXml', xml);
  }

  saveCpp(cpp: any) {
    this.socket.emit('saveCpp', cpp)
  }

  save(xml:any,cpp: any) {
    this.socket.emit('save', [xml,cpp])
  }

   
}
