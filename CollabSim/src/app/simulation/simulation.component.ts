import { Component, ViewChild } from '@angular/core';
import { XMLComponent } from '../xml/xml.component';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-simulation',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './simulation.component.html',
  styleUrl: './simulation.component.css'
})
export class SimulationComponent {
  @ViewChild(XMLComponent) xmlComp!: XMLComponent;

  reloadSim(){
    this.xmlComp.reloadSim();
  }


}
