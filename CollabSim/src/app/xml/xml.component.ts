import { AfterViewInit, Component, ElementRef, ViewChild } from "@angular/core";
import { HttpClient } from '@angular/common/http';
import { WebSocketService } from "../websocket.service";
import * as ace from "ace-builds";
import { FormsModule } from "@angular/forms";
import { Router, RouterLink,RouterLinkActive,RouterOutlet } from "@angular/router";


@Component({
  selector: 'app-xml',
  standalone: true,
  imports: [FormsModule, RouterLink, RouterOutlet, RouterLinkActive],
  templateUrl: './xml.component.html',
  styleUrl: './xml.component.css'
})
export class XMLComponent implements AfterViewInit{
  //Http data
  dataFromFlaskHttp: any = {};
  
  //websocket data
  message: string = '';
  aceText: string = '';
  aceCode: string = '';
  aceXml: string = '';
  

  ignoreChanges: boolean = false; // flag for timing updates
  debounceTimer: any; // timer for timing updates
  currentXml: string = ''; // to see if changes where made

  constructor(
    private webSocketService: WebSocketService,
    private http: HttpClient,
    private route: Router 
    
    ) {

  }
  
  
  // Websocket
   sendMessage(id:string,msg:string) {
    this.webSocketService.sendMessage(id,msg);
  }

  sendCommand(id:string) {
    this.webSocketService.sendCommand(id);
  }

  reloadSim(){
    if (this.currentXml !== this.aceXml) {
    }
      console.log("reloading..");
      this.webSocketService.reloadSim();

    // waiting to reload sim
    setTimeout(() => {
      console.log('waiting');
      this.route.navigate(['Sim']);
    }, 1000);
  }

  saveXml(){
    this.currentXml = this.aceXml;
    this.webSocketService.saveXml(this.aceXml);
  }



  // HTTP REquest
  test(): void {
    // Sende GET-Anfrage an Flask-Server
    this.http.get<any>('http://192.168.178.32:5000/commands/play').subscribe(data => {
      // Verarbeiten der Antwort
      this.dataFromFlaskHttp = data;
    });
  }

  
  // ACE Editor
  @ViewChild("editorXML") public editorXML!: ElementRef<HTMLElement>;  
  
  ngAfterViewInit(): void {
    

    this.webSocketService.getTextUpdates((msg: string) => {
      console.log(msg);

      if (msg[0]=='aceX' ){
        if (this.aceXml !== msg[1]) {
          console.log("in constructor")
          this.ignoreChanges = true;
          aceEditorXML.session.setValue(msg[1]);
        }
      }
  });
    
    
    // Ace setup
    ace.config.set("fontSize", "14px");
    ace.config.set(
      "basePath",
      "https://unpkg.com/ace-builds@1.4.12/src-noconflict"
    );

    // Xml-Editor setup
    var aceEditorXML = ace.edit(this.editorXML.nativeElement);
    aceEditorXML.session.setValue(this.aceXml);
    aceEditorXML.setTheme("ace/theme/monokai");
    aceEditorXML.session.setMode("ace/mode/xml");
    aceEditorXML.on("change", () => {
      
      /*console.log(aceEditorXML.getSelection().isEmpty());*/

      clearTimeout(this.debounceTimer); // Timer zurücksetzen
      this.debounceTimer = setTimeout(() => {
        if (this.aceXml!==aceEditorXML.session.getValue() && !this.ignoreChanges) {
          console.log("on change");
          this.aceXml = aceEditorXML.getValue();
          this.sendMessage('aceX', this.aceXml); 
        }
        else {
          this.ignoreChanges = false;
        }
      }, 100);
    });
    

    // Load current data
    this.webSocketService.init();


  }

}
