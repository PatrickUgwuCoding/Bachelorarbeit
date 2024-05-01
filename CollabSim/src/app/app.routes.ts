import { Routes } from '@angular/router';
import { SimulationComponent } from './simulation/simulation.component';
import { XMLComponent } from './xml/xml.component';
import { CPPComponent } from './cpp/cpp.component';

export const routes: Routes = [
    {path:'Sim',component: SimulationComponent},
    {path:'Xml',component: XMLComponent},
    {path:'Cpp',component: CPPComponent},
    {path:'', redirectTo: 'Xml', pathMatch: 'full'}
];
