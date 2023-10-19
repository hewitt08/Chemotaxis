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
boolean game = true;
int lastWave = 10;
int laserEndX = mouseX;
int laserEndY = mouseY;
int dots = 0;
int score = 0;
missile bullet;

class missile{
  int misX, misY, misXInc, misYInc, yforxInc;
  boolean fired;
  
  missile(){
    misX = shipX;
    misY = shipY;
    fired = false;
  }//constructor end
  
  void move(){
    if(fired == true){
      misX += misXInc;
      misY += misYInc;
      fill(0,255,0);
      ellipse(misX, misY, 5, 5);
    }//if end
  }//move end

}//missile class end

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

    if(velocityX>50){
      velocityX=50;
    }
    if(velocityX<-50){
      velocityX=-50;
    }//velocityX cap

   if(velocityY>50){
      velocityY=50;
    }
    if(velocityY<-50){
      velocityY=-50;
    }//velocityY cap
    
    shipY = shipY + (int)velocityY;
    shipX = shipX + (int)velocityX;
    
    velocityX *= 0.9;
    velocityY *= 0.9;
    
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
    if(((abs(bullet.misX-dotX))<15)&&((abs(bullet.misY-dotY))<15)){
      if((life == true) && (bullet.fired == true)){
        wave = wave -1;
        life = false;
        bullet.fired = false;
        score++;
      }
    }
  }//void attacked end

}//dot class end

void setup(){
  size(500,500);
  
  mouseShip = new ship(50, 250);
  
  bullet = new missile();
  
  newWave(10);
  
}//setup end

void draw(){
  background(0,0,100);
  
  if(game == true){

  mouseShip.show();
  mouseShip.move();
  bullet.move();

  for(int i = 0; i < circles.length; i++){
    circles[i].walk();
    circles[i].collide();
    circles[i].attacked();
    if(circles[i].life == true){
      circles[i].show();
    }
  }//circles end
  
  if(wave == 0){
    newWave(lastWave * 2);
  }//if wave is out end
  
  healthBar();
  score();
  
  }//if game is on end
  
  gameOver();
  
}//draw end

void keyPressed(){
  if(key == 'w'){
    velocityY = velocityY - 10;
  }
  if(key == 's'){
    velocityY = velocityY + 10;
  }
  if(key == 'd'){
    velocityX = velocityX + 10;
  }
  if(key == 'a'){
    velocityX = velocityX - 10;
  }
  if(key == ' '){
    laserEndX = mouseX;
    laserEndY = mouseY;
    bullet.misX = shipX;
    bullet.misY = shipY;
    
    bullet.yforxInc = (int)abs((laserEndX - bullet.misX)/10);
    if(bullet.yforxInc == 0){
      bullet.yforxInc = 1;
    }
    bullet.misXInc = (laserEndX - bullet.misX)/bullet.yforxInc;
    bullet.misYInc = (laserEndY - bullet.misY)/bullet.yforxInc;
    
    bullet.fired = true;
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
  if((health == 0)||(dots>5000)){
    fill(200,200,200);
    textSize(50);
    text("GAME OVER", 20,50);
    text("PLAY AGAIN? . . . ", 20, 150);
    text("FINAL SCORE: " + score,20,100);
    game = false;
  }
}

void newWave(int w){
  wave = w;
  dots = dots + wave;
  lastWave = wave;
  circles = new dot[wave];
  for(int i = 0; i < circles.length; i++){
    if(w<50){
      circles[i] = new dot(((int)(Math.random()*400)+100),(250-(w*5)+(i*10)));
    }else{
      circles[i] = new dot(((int)(Math.random()*400)+100),(int)(Math.random()*500));
    }
  }//circles end
}
  
void score(){
  fill(255);
  textSize(20);
  text("SCORE: " + score,20,75);
}
