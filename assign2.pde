final int GAME_START=1;
final int GAME_RUN=2;
final int GAME_OVER=3;
int gameState=1;

float knightX=-80;
float knightY=int(random(2,6))*80; 

float cabbageX=floor(random(0,8))*80;
float cabbageY=floor(random(2,6))*80;

float heartX=-35;
float heartY=35;
float heartSpeed=70;

float hogX, hogY;
float hogWidth=40;
float hogHeight=40;
float speed=80;

PImage sky, cabbage, title, gameOver, heart, soil, knight;
PImage startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;

void setup() {
	size(640, 480, P2D);
	// Enter Your Setup Code Here
  title=loadImage("img/title.jpg");
  sky=loadImage("img/bg.jpg");
  soil=loadImage("img/soil.png");
  heart=loadImage("img/life.png");
  knight=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  gameOver=loadImage("img/gameover.jpg");
  
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  
  background(sky);
  imageMode(CENTER);
  image(knight,knightX,knightY);
  image(cabbage,cabbageX,cabbageY);
  hogX=320;
  hogY=120-hogWidth;

  
}

void draw() {
	switch(gameState){
    case GAME_START:
    imageMode(CORNER);
    image(title,0,0);
      image(startNormal,248,360);
      if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
        if(mousePressed){
          gameState=GAME_RUN;
        }else{
          //hover
          image(startHovered,248,360);
        }
      }
      break;
      
    
    case GAME_RUN:
      background(sky);
      
      //draw sun 
      colorMode(RGB);
      strokeWeight(5);
      stroke(255,255,0);  
      fill(253,184,19);
      ellipse(590,50,120,120);
     
      //draw grass
      noStroke();
      fill(124,204,25);
      rect(0,145,640,15);
        
      //play heart
      imageMode(CENTER);
      for(int i =0; i<heartSpeed*3; i+=heartSpeed){
      image(heart,heartX+i,heartY);
      }
      
      //play soil
      imageMode(CORNERS);
      image(soil,0,160);
      
      //knight animation
        
        image(knight,knightX,knightY);
        //or knightY=knightDistance*80;
        knightX+=5;
        if(knightX>width){
          knightX=-80;
        }
      //play hog
      image(groundhogIdle,hogX,hogY);
      
      //play cabbage
      image(cabbage,cabbageX,cabbageY);
      
      //hog hit knight
      if(hogX<knightX+80 && hogX+80>knightX && hogY>knightY-80 && hogY<knightY+80){
        hogX=320;
        hogY=120-hogWidth;
        image(groundhogIdle,hogX,hogY);
        //delete heart
        heartX-=heartSpeed;
      }
      
      //hog eat cabbage
      if ((hogY+80>cabbageY && hogY<cabbageY+80)&&(hogX+80>cabbageX && hogX<cabbageX+80)){
        cabbageY=7*80;
        heartX+=heartSpeed;
        }
      
      
      //to gameOver
      if(heartX==-175){
        //no more heart
        gameState=GAME_OVER;
      }
      break;
      
  		case GAME_OVER:
        image(gameOver,0,0);
        image(restartNormal,248,360);
        if(mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420){
            if(mousePressed){
              gameState=GAME_RUN;
              hogX=320;
              hogY=80;
              heartX=-35;
              heartY=35;
            }else{
              //hover
              image(restartHovered,248,360);
            }
          }
          break;
        }
      }

void keyPressed(){
  if (key==CODED){
      switch(keyCode){
        case DOWN:
        hogY+=speed;
        break;      
        case RIGHT:
        hogX+=speed;
        break;      
        case LEFT:
        hogX-=speed;
        break;
    }
  }
}
