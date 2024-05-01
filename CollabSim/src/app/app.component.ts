import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive, RouterOutlet } from '@angular/router';
import { XMLComponent } from './xml/xml.component';
import { CPPComponent } from './cpp/cpp.component';
import { SimulationComponent } from './simulation/simulation.component';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [FormsModule, RouterLink,RouterLinkActive,RouterOutlet ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'CollabSim';
}
