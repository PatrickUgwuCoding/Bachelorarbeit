import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CPPComponent } from './cpp.component';

describe('CPPComponent', () => {
  let component: CPPComponent;
  let fixture: ComponentFixture<CPPComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CPPComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(CPPComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
