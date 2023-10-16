int dotSize = 10;
int stepSize = 5;
dot [] circles;
ship mouseShip;
int shipX;
int shipY;
int health = 100;
int wave;
double velocityX = 0;
double velocityY = 0;
boolean space = false;
boolean game = true;
int lastWave = 10;
int laserEndX;
int laserEndY;


class ship{
  
  ship(int x,int y){
    shipX = x;
    shipY = y;
  }//constructor end
  
  void show(){
    fill(100,100,100);
    ellipse(shipX, shipY, 30, 30);
  }
  
  void move(){
    
    shipY = shipY + (int)velocityY;
    shipX = shipX + (int)velocityX;
    
    if(shipX > 485){
      shipX = 485;
      velocityX = 0;
    }
    if(shipX < 15){
      shipX = 15;
      velocityX = 0;
    }//x lock end
    if(shipY > 485){
      shipY = 485;
      velocityY = 0;
    }
    if(shipY < 15){
      shipY = 15;
      velocityY = 0;
    }//y lock end
  }//void move end
  
  void attack(){
    if(space == true){
      fill(0,255,0);
      stroke(10);
      line(shipX, shipY, laserEndX, laserEndY);
    }
  }
  
}//ship class end

class dot{
  int dotX, dotY, dotR, dotG, dotB;
  boolean life;
  
  dot(int x,int y){
    dotX = x;
    dotY = y;
    dotR = 250;
    dotG = 50;
    dotB = 20;
    life = true;
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
  
  void collide(){
    if(((abs(shipX-dotX))<15)&&((abs(shipY-dotY))<15)){
      if(life == true){
        health = health - 1;
        wave = wave -1;
        life = false;
      }
    }
  }//void collide end
  
  void attacked(){
    if(get(dotX, dotY) == color(0,255,0)){
      if(life == true){
        wave = wave -1;
        life = false;
      }
    }
  }//void attacked end

}//dot class end

void setup(){
  size(500,500);
  
  mouseShip = new ship(50, 250);
  
  wave(10);
  
}//setup end

void draw(){
  background(0,0,50);
  if(game == true){
/*
  velocityX*=0.9;
  velocityY*=0.9;
*/    
  mouseShip.attack();
  mouseShip.show();
  mouseShip.move();

  for(int i = 0; i < circles.length; i++){
    circles[i].walk();
    circles[i].collide();
    if(circles[i].life == true){
      circles[i].show();
    }
  }//circles end
  
  if(wave == 0){
    wave(lastWave * 2);
  }
  
  healthBar();
  
  }
  
  gameOver();

  System.out.println("ShipX: " + shipX);
  System.out.println("ShipY: " + shipY);
  System.out.println("Laser End X: " + laserEndX);
  System.out.println("Laser End Y: " + laserEndY);
  
}//draw end

void keyPressed(){
  if(key == 'w'){
    velocityY = velocityY - 2;
  }
  if(key == 's'){
    velocityY = velocityY + 2;
  }
  if(key == 'd'){
    velocityX = velocityX + 2;
  }
  if(key == 'a'){
    velocityX = velocityX - 2;
  }
  if(key == ' '){
    space = !space;
    laserEndX = mouseX;
    laserEndY = mouseY;
  }
}

void healthBar(){
  if(health<0){
    health = 0;
  }
  stroke(5);
  fill(0);
  rect(20,20,100,30);
  noStroke();
  if(health>80){
    fill(0,200,0);
  }else if(health>60){
    fill(200,200,0);
  }else if(health>30){
    fill(250,190,0);
  }else{
    fill(250,0,0);
  }
  rect(20,20,health,30);
}

void gameOver(){
  if(health == 0){
    fill(200,200,200);
    textSize(80);
    text("GAME OVER", 20,250);
    game = false;
  }
}

void wave(int w){
  wave = w;
  lastWave = wave;
  circles = new dot[wave];
  for(int i = 0; i < circles.length; i++){
    if(w<50){
      circles[i] = new dot(450,(250-(w*5)+(i*10)));
    }else{
      circles[i] = new dot(450,(250));
    }
  }//circles end
}
  
