import { Routes } from '@angular/router';
import { SimulationComponent } from './simulation/simulation.component';
import { XMLComponent } from './xml/xml.component';
import { AppComponent } from './app.component';

export const routes: Routes = [
    {path:'Sim',component: SimulationComponent},
    {path:'Edit',component: XMLComponent},
    {path:'App',component: AppComponent},
    {path:'', redirectTo: 'Edit', pathMatch: 'full'}
];
