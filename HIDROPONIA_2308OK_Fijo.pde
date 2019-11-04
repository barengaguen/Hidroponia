/***********************************
 ULTIMA VERSION AL 04/11
 4 BOTONES
***********************************/
import javax.swing.JOptionPane;
import meter.*;
import processing.serial.*;
import controlP5.*;
ControlP5 cp5;
PFont font;


Serial port;
//String[] list;
  int r = 0;
Meter m, m2,m3,m4;

void setup() {
smooth();
size(1300, 700);
 //fullScreen();
  background(0);
  

  cp5=new ControlP5(this);
 
font =createFont("calibri light bold",15);
 

cp5.addButton("PRENDER")
.setPosition(600,500)

.setColorForeground(color(255,0,0)) 
.setSize(100,70)
.setFont(font)
;
  cp5.addButton("APAGAR")
.setPosition(800,500)
.setColorForeground(color(0,255,0))
.setSize(100,70)
.setFont(font)
;
 cp5.addButton("CAUDALup")
.setPosition(600,400)
.setSize(80,70)
.setFont(font)
;
 cp5.addButton("CAUDALdn")
.setPosition(800,400)
.setSize(80,70)
.setFont(font)
;
  
 
 // port = new Serial(this, "COM9", 57600);

  fill(120, 50, 0);
  m = new Meter(this, 25, 100);
  // Adjust font color of meter value  
  m.setMeterWidth(300);
  m.setTitleFontSize(20);
  m.setTitleFontName("Arial bold");
  m.setTitle("Temperatura (C)");
   
 // m.setLowSensorWarningActive(true);
  m.setLowSensorWarningValue((float)15.0);
  m.setHighSensorWarningActive(true);
  m.setHighSensorWarningValue((float)40.0);
  m.setDisplayDigitalMeterValue(true);
  
  // Meter Scale
  String[] scaleLabelsT = {"0", "10", "20", "30", "40", "50", "60", "70", "80"};
  m.setScaleLabels(scaleLabelsT);
  m.setScaleFontSize(18);
  m.setScaleFontName("Times New Roman bold");
  m.setScaleFontColor(color(255, 0, 0));
  
  m.setArcColor(color(255, 0, 0));
  m.setArcThickness(30);
  m.setMaxScaleValue(80);

  m.setNeedleThickness(3);
  
  m.setMinInputSignal(0);
  m.setMaxInputSignal(80);

  // A second meter for reference
  int mx = m.getMeterX();
  int my = m.getMeterY();
  int mw = m.getMeterWidth();
  
  m2 = new Meter(this, mx + mw + 20, my);
  m2.setMeterWidth(300);
  m2.setTitleFontSize(20);
  m2.setTitleFontName("Arial bold");
  m2.setTitle("Humedad (%)");
  m2.setDisplayDigitalMeterValue(true);
  
  String[] scaleLabels2 = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
  m2.setScaleLabels(scaleLabels2);
  m2.setScaleFontSize(18);
  m2.setScaleFontName("Arial bold");
  m2.setScaleFontColor(color(255, 0, 0));
  
  m2.setArcColor(color(0, 0, 255));
  m2.setArcThickness(10);
  m2.setMaxScaleValue(100);

  m2.setNeedleThickness(3);
  
  m2.setMinInputSignal(0);
  m2.setMaxInputSignal(100);
  
  
   m3 = new Meter(this, mx + mw + 340, my);
  // Adjust font color of meter value  
  m3.setMeterWidth(300);
  m3.setTitleFontSize(20);
  m3.setTitleFontName("Arial bold");
  m3.setTitle("pH");
  m3.setDisplayDigitalMeterValue(true);
  
  // Meter Scale
  String[] scaleLabelsTt = {"0", "1", "2", "3", "4", "5", "6", "7", "8","9","10","11","12","13","14"};
 
  m3.setScaleLabels(scaleLabelsTt);
   color(50, 55, 0);
  m3.setScaleFontSize(20);
  m3.setScaleFontName("Arial bold");
  m3.setScaleFontColor(color(0, 0, 0));
  
  //m3.setArcColor(color(50, 55, 0));
  m3.setArcThickness(30);
  m3.setMaxScaleValue(14);
  m3.setHighSensorWarningActive(true);
  m3.setHighSensorWarningValue((float)6.50);
  m3.setNeedleThickness(5);
  
  m3.setMinInputSignal(0);
  m3.setMaxInputSignal(14);
  //m3.setLowSensorWarningActive(true);
  m3.setLowSensorWarningValue((float)5.0);
  m3.setHighSensorWarningActive(true);
  m3.setHighSensorWarningValue((float)7.0);
  m3.setDisplayDigitalMeterValue(true);
  
   fill(120, 50, 0);
  m4 = new Meter(this, mx + mw + 660, my);
  // Adjust font color of meter value  
  m4.setMeterWidth(300);
  m4.setTitleFontSize(20);
  m4.setTitleFontName("Arial bold");
  m4.setTitle("Temperatura (C)");
   
 // m.setLowSensorWarningActive(true);
  m4.setLowSensorWarningValue((float)15.0);
  m4.setHighSensorWarningActive(true);
  m4.setHighSensorWarningValue((float)40.0);
  m4.setDisplayDigitalMeterValue(true);
  
  // Meter Scale
  String[] scaleLabelsTc = {"0", "10", "20", "30", "40", "50", "60", "70", "80"};
  m4.setScaleLabels(scaleLabelsTc);
  m4.setScaleFontSize(18);
  m4.setScaleFontName("Times New Roman bold");
  m4.setScaleFontColor(color(255, 0, 0));
  
  m4.setArcColor(color(255, 0, 0));
  m4.setArcThickness(30);
  m4.setMaxScaleValue(80);

  m4.setNeedleThickness(3);
  
  m4.setMinInputSignal(0);
  m4.setMaxInputSignal(80);

 
  
}

public void draw() {

 // void controlEvent(CallbackEvent theEvent);
  /*
  if (port.available() > 0) {
    String val = port.readString();
  String[]  list = split (val, ',');
    float temp = float(list[0]);
     float hum = float(list[1]);
    float lvl = float(list[3]);
    lvl = (lvl-20)/100;
    float ph = float(list[2]);
    ph=(ph+400)/100;
    */
      float temp =(int)random(15, 40);// float(list[0]);
     float hum = (int)random(40, 80);//float(list[1]);
    float lvl =(int)random(400, 1023);// float(list[3]);
    lvl= (lvl-20)/100;
    float ph =(int)random(100, 255);// float(list[2]);
    ph=(ph+400)/100;
    /*
   delay (300);
   
    m.updateMeter(int(temp));
      delay (100);
    m2.updateMeter(int(hum));
      delay (100);
   m3.updateMeter(int(lvl));
     delay (100);
     m4.updateMeter(int(temp));
     delay (100);
     
     */
   if (lvl <= 5){
     
     alarma();
     }
     
     
   //println("Temperatura: " + temp + " C  " + "Humedad: " + hum + " %" +"  ph= "+ph +"  nivel=" +  lvl);  
 

 // if (val !=null){
   
background(0);
   textSize(50);
  fill(0, 255, 0);
  text("Vivero Hidroponico  "+ hour()+":"+ minute()+"   "+day()+"/"+month()+"/"+year(), 170, 50);
    fill(0,0,200);
    textSize(30);
    text("Nivel de Nutrientes", 100, 740,100);
    
     textSize(50);
    text(int(lvl*10)+"%",300,940);
   text(int(lvl)+"%",300,1000);
  
 //delay(100);

//PImage img = loadImage("tanque.jpg");
//image(img ,300,340);
 
    m.updateMeter(int(temp));
    m2.updateMeter(int(hum));
   m3.updateMeter(int(ph));
     m4.updateMeter(int(temp));
    delay(300); 
 
    if (lvl<=5 ) {
   fill(255,0,0);
   alarma();
  } else {
    fill(0,0,255);
  };
    rectMode(CENTER);
    rect(width/16,height-(lvl),100,lvl*50);
    // keyPressed();
     fill(0, 0, 150);
  text(int(r)+"   caudal",700,940);
  textSize(50);
  fill(0, 0, 150);
  
  } 
 // }
//}
public void alarma(){
   //ellipse(560, 460, 55, 55);
   //JOptionPane.showMessageDialog(null, "Operación realizada correctamente");
    
}
 void CAUDALup(){
    //port.write('A'); 
    r+=5;
     r = constrain(r,0,100);
}
 void CAUDALdn(){
    //port.write('D'); 
       r-=5;
        r = constrain(r,0,100);
}
/*
void keyPressed() {
  
  if (keyPressed&&(key==CODED)) {
    if (keyCode == LEFT) {
  int (r-=5);
    } else if (keyCode == RIGHT) {
int (r+=5);
    }
delay(100);
    r = constrain(r,0,100);
    textSize(50);
    fill(255,0,0);
    
  } 
}
*/

 void PRENDER(){
   
    port.write('P');
    
    }
  
    void APAGAR(){
    port.write('A');
    }

  
  
