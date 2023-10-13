int dotSize = 10;
int stepSize = 5;
dot [] circles;
ship mouseShip;
int shipX;
int shipY;

class ship{
  
  ship(int x,int y){
    shipX = x;
    shipY = y;
  }//constructor end
  
  void show(){
    shipX = mouseX;
    shipY = mouseY;
    ellipse(shipX, shipY, 30, 30);
  }
}//ship class end

class dot{
  int dotX, dotY, dotR, dotG, dotB;
  
  dot(int x,int y){
    dotX = x;
    dotY = y;
    dotR = 250;
    dotG = 50;
    dotB = 20;
  }//constructor end
  
  void walk(){
    if(shipX>dotX){
      dotX = dotX + (int)(Math.random()*stepSize-1);
    }else{
      dotX = dotX + (int)(Math.random()*stepSize-3);
    }//x movement end
    
    if(shipY>dotY){
      dotY = dotY + (int)(Math.random()*stepSize-1);
    }else{
      dotY = dotY + (int)(Math.random()*stepSize-3);
    }//y movement end
  }//void walk end
  
  void show(){
    fill(dotR,dotG,dotB);
    ellipse(dotX, dotY, dotSize, dotSize);
  }//void show end
}//square class end

void setup(){
  size(500,500);
  
  mouseShip = new ship(50, 250);
  
  circles = new dot[10];
  for(int i = 0; i < circles.length; i++){
    circles[i] = new dot(450,250);
  }//circles end
  
}//setup end

void draw(){
  background(0);
  
  mouseShip.show();
  
  for(int i = 0; i < circles.length; i++){
    circles[i].walk();
    circles[i].show();
  }//circles end
  
}//draw end
