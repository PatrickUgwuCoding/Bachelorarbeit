import { ComponentFixture, TestBed } from '@angular/core/testing';

import { XMLComponent } from './xml.component';

describe('XMLComponent', () => {
  let component: XMLComponent;
  let fixture: ComponentFixture<XMLComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [XMLComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(XMLComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
