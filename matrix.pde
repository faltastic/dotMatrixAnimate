int N = 8;
int ledSize = 50;

int[][] leds = new int[N][N];
int[][] newleds = new int[N][N];
PImage img;
String pat = "byte pat[][8] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}";
void setup() {
  
  frameRate(24);
  int w = N*ledSize;
  size(w,w);
  clearLeds();
rectMode(CORNER);

img = loadImage("1-7.png");
//  setPattern(pattern);
}

void draw() {
    display();
    println(leds[3][3]);
   
   //pattern = ++pattern % numPatterns;
    //slidePattern(pattern, 60);
}

void keyPressed(){
 if(key=='s') slidePattern();
 if(key=='i') imgtoMatrix(img);
 
}

void slidePattern() {
  
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
     //newleds[i][j] = 0;
     newleds[i][j]=leds[i][(j+1)%8];
    }
  }
  //print(newleds);
  leds = newleds;
  //print(leds);
  
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
     //newleds[i][j] = 0;
     leds[i][j]=newleds[i][j];
    }
  }
  
  /*
  for (int l = 0; l < 8; l++) {
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 8; j++) {
        leds[j][i] = leds[j][i+1];
      }
    }
    for (int j = 0; j < 8; j++) {
      leds[j][7] = leds[j][0 + l];
    }
    //delay(del);
  }*/
  
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
  leds[ix][jy] = 1;
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
//  println(pat);
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
