import { AfterViewInit, Component, ElementRef, ViewChild } from "@angular/core";
import { WebSocketService } from "../websocket.service";
import * as ace from "ace-builds";
import { FormsModule } from "@angular/forms";
import { Router } from "@angular/router";


@Component({
  selector: 'app-xml',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './xml.component.html',
  styleUrl: './xml.component.css'
})
export class XMLComponent implements AfterViewInit{
  
  //websocket data
  aceCode: string = '';
  aceXml: string = '';
  

  ignoreChanges: boolean = false; // flag for timing updates
  debounceTimer: any; // timer for timing updates
  currentXml: string = ''; // to see if changes where made
  currentCpp: string = ''; // to see if changes where made

  constructor(
    private webSocketService: WebSocketService,

    private route: Router 

    ) {

  }
  
  
  // Websocket
   sendMessage(id:string,msg:string) {
    this.webSocketService.sendMessage(id,msg);
  }


  reloadSim(){
    this.save()
    if (this.currentXml !== this.aceXml || this.currentCpp !== this.aceCode) {
    }
      console.log("reloading simulation");
      this.webSocketService.reloadSim();

    // waiting to reload sim
    setTimeout(() => {
      console.log('waiting for reload');
      this.route.navigate(['Sim']);
    }, 1000);
  }

  save(){
    if(this.aceXml.length !== 0){
      this.currentXml = this.aceXml;
      this.webSocketService.saveXml(this.aceXml);
    }
    if(this.aceCode.length !== 0){
      this.currentCpp = this.aceCode;
      this.webSocketService.saveCpp(this.aceCode);
      }
  }
  
  // ACE Editor
  @ViewChild("editorXML") public editorXML!: ElementRef<HTMLElement>;  
  @ViewChild("editorCPP") public editorCPP!: ElementRef<HTMLElement>;  
  
  
  ngAfterViewInit(): void {
    
    this.webSocketService.getTextUpdates((msg: string) => {
      console.log(msg);

      if (msg[0]=='aceX' ){
        if (this.aceXml !== msg[1]) {
          this.ignoreChanges = true;
          aceEditorXML.session.setValue(msg[1]);
          this.aceXml = msg[1]
        }
      }
      else if (msg[0]=='aceC' ){
        if (this.aceCode !== msg[1]) {
          this.ignoreChanges = true;
          aceEditorCPP.session.setValue(msg[1]);
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
      
      clearTimeout(this.debounceTimer); // reset timer
      this.debounceTimer = setTimeout(() => {
        if (this.aceXml!==aceEditorXML.session.getValue() && !this.ignoreChanges) {
          this.aceXml = aceEditorXML.getValue();
          this.sendMessage('aceX', this.aceXml); 
        }
        else {
          this.ignoreChanges = false;
        }
      }, 100);
    });

    var aceEditorCPP = ace.edit(this.editorCPP.nativeElement);
    aceEditorCPP.session.setValue(this.aceCode);
    aceEditorCPP.setTheme("ace/theme/monokai");
    aceEditorCPP.session.setMode("ace/mode/c_cpp");
    aceEditorCPP.on("change", () => {
      clearTimeout(this.debounceTimer); // reset timer
      this.debounceTimer = setTimeout(() => {
        if (this.aceCode!==aceEditorCPP.session.getValue() && !this.ignoreChanges) {
          this.aceCode = aceEditorCPP.getValue();
          this.sendMessage('aceC', this.aceCode); 
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
