import { Component, ElementRef,ViewChild, AfterViewInit } from '@angular/core';
import { WebSocketService } from '../websocket.service';
import * as ace from "ace-builds";
import { Router, RouterLink,RouterLinkActive,RouterOutlet } from "@angular/router";
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-cpp',
  standalone: true,
  imports: [FormsModule, RouterLink, RouterOutlet, RouterLinkActive],
  templateUrl: './cpp.component.html',
  styleUrl: './cpp.component.css'
})
export class CPPComponent {
  
  aceCode: string = '';

  ignoreChanges: boolean = false; // flag for timing updates
  debounceTimer: any; // timer for timing updates
  currentCpp: string = ''; // to see if changes where made
  
  constructor(
    private webSocketService: WebSocketService,
    private route: Router 
    
    ) {

  }

  sendMessage(id:string,msg:string) {
    this.webSocketService.sendMessage(id,msg);
  }

  saveCpp(){
    this.currentCpp = this.aceCode;
    this.webSocketService.saveCpp(this.aceCode);
  }


  reloadSim(){
    if (this.currentCpp !== this.aceCode) {
    }
      console.log("reloading..");
      this.webSocketService.reloadSim();

    // waiting to reload sim
    setTimeout(() => {
      console.log('waiting');
      this.route.navigate(['Sim']);
    }, 1000);
  }
  
  
  @ViewChild("editorCPP") public editorCPP!: ElementRef<HTMLElement>;
  
  ngAfterViewInit(): void {
    

    this.webSocketService.getTextUpdates((msg: string) => {
      console.log(msg);

      if (msg[0]=='aceC' ){
        if (this.aceCode !== msg[1]) {
          console.log("in constructor")
          this.ignoreChanges = true;
          aceEditorCPP.session.setValue(msg[1]);
        }
      }
      
  });
    
    
    // ace editor setup
    ace.config.set("fontSize", "14px");
    ace.config.set(
      "basePath",
      "https://unpkg.com/ace-builds@1.4.12/src-noconflict"
    );


    
    // cpp-editor setup
    var aceEditorCPP = ace.edit(this.editorCPP.nativeElement);
    aceEditorCPP.session.setValue(this.aceCode);
    aceEditorCPP.setTheme("ace/theme/monokai");
    aceEditorCPP.session.setMode("ace/mode/c_cpp");
    aceEditorCPP.on("change", () => {
      clearTimeout(this.debounceTimer); // Timer zurücksetzen
      this.debounceTimer = setTimeout(() => {
        if (this.aceCode!==aceEditorCPP.session.getValue() && !this.ignoreChanges) {
          console.log("on change");
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
