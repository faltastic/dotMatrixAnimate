int N = 8;
int ledSize = 20;

int n=1;

int[][] leds = new int[N][N];
int[][] newleds = new int[N][N];



PImage img;
String pat = "byte pat[][8] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}";

String animate = "";

void setup() {
  
  frameRate(6);
  int w = int( N*ledSize);
  size(20*8,20*8);
  clearLeds();
rectMode(CORNER);

img = loadImage("http://s13.postimg.org/9z74r9707/1_7.png");
//img = loadImage("1-7.png");

//  setPattern(pattern);
}

void draw() {
  
// interesting patterns when holding w 
// after going into tetris mode by pressing t 
 
 if(key=='i') imgtoMatrix(img);
 
 if(key =='a' && frameCount%2==0 ){
   // randomly switch between transition functions
   float r =int(random(5));
   if(r==4) slideUp();
   if(r==3) switchRows(n%8,(n+3)%8);
   if(r==2) slideLeft();
   if(r==1) switchColumns(n%8,(n+3)%8);
 }
 
  if(key =='w' && frameCount%4==0 ){
   // randomly switch between transition functions 
   float r =int(random(3));
   if(r==2) slideLeft();
   if(r==1) switchColumns(n%8,(n+3)%8);
 }
   
 if(key=='l') slideLeft();
 if(key=='o') slideUp();
 
 if(key=='r') switchRows(n%8,(n+3)%8);
 if(key=='c') switchColumns(n%8,(n+3)%8);
 
 if(key=='t') animate = "tetris"; 
 
  //here 
 if (animate.equals("tetris")){
    
     if(frameCount%10==0) switchRows(n%8,(n+3)%8);
     if(frameCount%3==0) slideUp();
     if(key ==' ') animate="";
 }


   
  
 display();
 n++;   
    
   // println(leds[3][3]);
   
   //pattern = ++pattern % numPatterns;
    //slidePattern(pattern, 60);
}

void keyPressed(){
  if(key =='k' ) 
  // this only works on arduino
  // chladni pattern = {0x18, 0x24, 0x42, 0x81, 0x81, 0x42, 0x20, 0x18};
    
  if( key=='p') makeRandomPattern();
}

void switchRows(int n, int m){
  for (int j = 0; j < 8; j++) {
    int k = leds[j][m];
    newleds[j][m]=leds[j][n];
    newleds[j][n] = k;
  }
  leds = newleds;
}
 

void switchColumns(int n, int m){
  for (int j = 0; j < 8; j++) {
    int k = leds[m][j];
    newleds[m][j]=leds[n][j];
    newleds[n][j] = k;
  }
  leds = newleds;
}
   

void slideUp() {
  
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
     newleds[i][j]=leds[i][(j+1)%8];
    }
  }
  leds = newleds;
}

void slideLeft() {
  
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
     newleds[j][i]=leds[(j+1)%8][i];
    }
  }
  leds = newleds;
}

void makeRandomPattern(){
    for (int i = 0; i < N; i=i+int(random(1,3))) {
    for (int j = 0; j < N; j=j+int(random(1,3))) {
      leds[i][j] = int(random(0,2));
    }
  }
}
void clearLeds() {
  // Clear display array
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      leds[i][j] = 0;
    }
  }
}

void imgtoMatrix(PImage img){
  
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
      color c = img.get(int((i+0.5)*(img.width/(N))),int((j+0.5)*(img.height/(N))));
      leds[i][j] = 0;
      int thresh = int(map(mouseX, 0, width, 100, 150));
      if( brightness(c) > thresh) leds[i][j] = 1;
    }
  }
}


void mousePressed(){
  int ix = int(map(mouseX, 0,width, 0,N));
  int jy = int(map(mouseY, 0,height, 0,N));
  
  //switch led:  0 <-> 1
  leds[ix][jy] = (leds[ix][jy]+1)%2;
  ledstoString();
}

void ledstoString(){
  pat = "byte pat[][8] = {";
  for (int j = 0; j < 8; j++) {
    
    /* no idea why this doesnt turn half into hexa
    for (int i = 0; i < 8; i++) {
    half1 += str(leds[i][j]);
    if(i==4){pat = pat+"0x" + toHex(half1); half1="";}
    if(i==7){pat = pat+ toHex(half1)+", "; half1="";}
      }
    }*/
  
    String half1 = "", half2="";
    for (int i = 0; i < 4; i++) {half1 += str(leds[i][j]);}
    pat += "0x" + toHex(half1); 
    
    for (int i = 4; i < 8; i++) {half2 += str(leds[i][j]);}
    pat += toHex(half2); 
    
    if(j <7)  pat += ", ";
  }
  
  pat += "};";
  println(pat);
}  


String toHex(String s){
  
  String[] HexMap ={"0000","0001","0010","0011",
                    "0100","0101","0110","0111",
                    "1000","1001","1010", "1011",
                    "1100","1101","1110","1111"};
                    
   String[] toHexMap ={"0","1","2","3",
                       "4","5","6","7",
                       "8","9","A", "B",
                       "C","D","E","F"};                   
for(int i=0; i<16; i++){
  if(s.equals(HexMap[i])) s = toHexMap[i];  
 }
 return s;
}
/* 

void setPattern(int pattern) {
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      leds[i][j] = patterns[pattern][i][j];
    }
  }
}


void slidePattern(int pattern, int del) {
  for (int l = 0; l < 8; l++) {
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 8; j++) {
        leds[j][i] = leds[j][i+1];
      }
    }
    for (int j = 0; j < 8; j++) {
      leds[j][7] = patterns[pattern][j][0 + l];
    }
    delay(del);
  }
}
*/
// Interrupt routine
void display() {
  stroke(150);
   for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      if(leds[i][j] == 0) {fill(0);} 
      else{ fill(255);}
      rect(i*ledSize, j*ledSize, ledSize,ledSize);
    }
   }
}

