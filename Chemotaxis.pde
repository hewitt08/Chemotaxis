int dotSize = 10;
int squareSize = 10;
int stepSize = 7;
int stepStart = -3;
dot [] circles;
square [] squares;

class square{
  int squareX, squareY, squareR, squareG, squareB;
  
  square(int x,int y){
    squareX = x;
    squareY = y;
    squareR = 50;
    squareG = 250;
    squareB = 20;
  }//constructor end
  
  void walk(){
    if(squareX>485){//too far to the right
      squareX = squareX - (int)(Math.random()*stepSize);
    }//right stop end
    else if(squareX<15){//too far to the left
      squareX = squareX + (int)(Math.random()*stepSize);
    }//left stop end
    else{//normal movement
      squareX = squareX + (int)(Math.random()*stepSize)+stepStart;
    }//normal movement end
    
    if(squareY>485){//too far up
      squareY = squareY - (int)(Math.random()*stepSize);
    }//up stop end
    else if(squareY<15){//too far down
      squareY = squareY + (int)(Math.random()*stepSize);
    }//down stop end
    else{//normal moevement
      squareY = squareY + (int)(Math.random()*stepSize)+stepStart;
    }//normal movement end
  }//void walk end
  
  void show(){
    fill(squareR,squareG,squareB);
    rect(squareX-(squareSize/2), squareY-(squareSize/2), squareSize, squareSize);
  }//void show end
}//square class end

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
    if(dotX>485){//too far to the right
      dotX = dotX - (int)(Math.random()*stepSize);
    }//right stop end
    else if(dotX<15){//too far to the left
      dotX = dotX + (int)(Math.random()*stepSize);
    }//left stop end
    else{//normal movement
      dotX = dotX + (int)(Math.random()*stepSize)+stepStart;
    }//normal movement end
    
    if(dotY>485){//too far up
      dotY = dotY - (int)(Math.random()*stepSize);
    }//up stop end
    else if(dotY<15){//too far down
      dotY = dotY + (int)(Math.random()*stepSize);
    }//down stop end
    else{//normal moevement
      dotY = dotY + (int)(Math.random()*stepSize)+stepStart;
    }//normal movement end
  }//void walk end
  
  void show(){
    fill(dotR,dotG,dotB);
    ellipse(dotX, dotY, dotSize, dotSize);
  }//void show end
}//square class end

void setup(){
  size(500,500);
  
  circles = new dot[100];
  for(int i = 0; i < circles.length; i++){
    circles[i] = new dot(250,250);
  }//circles end
  
  squares = new square[100];
  for(int i = 0; i < squares.length; i++){
    squares[i] = new square(250,250);
  }//squares end
  
}//setup end

void draw(){
  background(0);
  
  for(int i = 0; i < circles.length; i++){
    circles[i].walk();
    circles[i].show();
  }//circles end
  
  for(int i = 0; i < squares.length; i++){
    squares[i].walk();
    squares[i].show();
  }//circles end
  
}//draw end
