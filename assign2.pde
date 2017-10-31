PImage title,startNormal,startHovered,gameover,restartNormal,restartHovered;
PImage groundhogDown,groundhogLeft,groundhogRight;
PImage backGround;
PImage soil;
PImage life;
PImage groundhog;
PImage cabbage;
float groundhogX=320,groundhogY=80;
PImage soldier;
PImage robot;
int soldierX,soldierY;   
int n;       //soldier
final int GAME_START = 0, GAME_RUN = 1, GAME_WIN = 2, GAME_LOSE = 3;
int gameState=0;
int lifeNumber=2;
int a,b,cabbageX,cabbageY; //cabbage
boolean eatCabbage=false;
boolean downPress=false,rightPress=false,leftPress=false;
boolean groundhogOrignal=true;
int frames = 0;


boolean isMoving = false;


void setup() {
  frameRate(60);
	size(640, 480, P2D);
  title=loadImage("img/title.jpg");
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  gameover=loadImage("img/gameover.jpg");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  life=loadImage("img/life.png");
  cabbage=loadImage("img/cabbage.png");
  groundhog=loadImage("img/groundhogIdle.png");
	//soldier
  n=floor(random(4));//soldier moving(Y)
  
  //cabbage
  a=floor(random(8));
  b=floor(random(4));
}

void draw() {
  
  
	switch(gameState){
    case GAME_START:
      image(title,0,0);
      image(startNormal,248,360);
      if(mouseX>248 && mouseX<248+144){
        if(mouseY>360 && mouseY<360+60){
          if(mousePressed){
            gameState=GAME_RUN;
          }else{
            image(startHovered,248,360);
          }
        }
      }
    break;
    
    case GAME_RUN:
    
      //blue background
      backGround=loadImage("img/bg.jpg");
      image(backGround,0,0);   
  
      //soil background
      soil=loadImage("img/soil.png");
      image(soil,0,160);   
  
      //grassland
      noStroke();
      fill(124,204,25);
      rect(0,145,640,15);  

      //sun
      fill(255,255,0);
      ellipse(590,50,130,130);  //sun outside
      fill(253,184,19);
      ellipse(590,50,120,120);  //sun inside
  
      //three lives
      switch(lifeNumber){
        case 3:
        image(life,10,10);
        image(life,80,10);
        image(life,150,10);
        break;
        case 2:
        image(life,10,10);
        image(life,80,10);
        break;
        case 1:
        image(life,10,10);
        break;
        case 0:
        gameState=GAME_LOSE;
        break;
      }
      if(lifeNumber>=4){
        lifeNumber=3;
      }
        
      //cabbage
      if(!eatCabbage){
        cabbageX=80*a;
        cabbageY=160+80*b;
        image(cabbage,cabbageX,cabbageY);
      }
      
      if((cabbageX+60)>groundhogX && (cabbageY+60)>groundhogY){
        if(cabbageX<(groundhogX+60) && cabbageY<(groundhogY+60)){
          lifeNumber=lifeNumber+1;
          eatCabbage=true;
          cabbageX=0;
          cabbageY=0;
          println(lifeNumber);
          
        }
      }
      
      //soldier
      soldier=loadImage("img/soldier.png");    
      soldierY=160+80*n;
      image(soldier,-80+soldierX,soldierY);    
      soldierX +=5;
      soldierX %=720;    //soldier moving(X)  640+80
      
      //groundhog
      
      if(downPress){
        image(groundhogDown,groundhogX,groundhogY);
        groundhogY += (float)80/15.0;
      }else if(rightPress){
        image(groundhogRight,groundhogX,groundhogY);
        groundhogX += (float)80/15.0;
      }else if(leftPress){
        image(groundhogLeft,groundhogX,groundhogY);
        groundhogX -= (float)80/15.0;
      }else{
        image(groundhog,groundhogX,groundhogY);
      }
      if(isMoving){
        frames++;
        if(frames == 15){
          isMoving = false;
          downPress = false;
          rightPress = false;
          leftPress = false;
          frames =0;
        }
      }
      
      //boundary detection
      if(groundhogX>560){
        groundhogX=560;
      }
      if(groundhogX<0){
        groundhogX=0;
      }
      if(groundhogY>400){
        groundhogY=400;
      }
      if(groundhogY<80){
        groundhogY=80;
      }
      
      //groundhog meet soldier
      if((groundhogX+60)>(soldierX-80) && (groundhogY+60)>soldierY){
        if(groundhogX<(soldierX-80+60) && groundhogY<(soldierY+60)){
          lifeNumber=lifeNumber-1;
          groundhogX=320;
          groundhogY=80;
          frames =0;
          isMoving = false;
          downPress = false;
          rightPress = false;
          leftPress = false;
          println(lifeNumber);
          }
        }
        
      
      break;
      
      case GAME_LOSE:
      image(gameover,0,0);
      image(restartNormal,248,360);
      if(mouseX>248 && mouseX<248+144){
        if(mouseY>360 && mouseY<360+60){
          if(mousePressed){
            gameState=GAME_RUN;
            lifeNumber=2;
            n=floor(random(4));  //change soldier position
            a=floor(random(8));  //change cabbage position
            b=floor(random(4));  //change cabbage position
            eatCabbage=false;
            frames =0;
            isMoving = false;
            downPress = false;
            rightPress = false;
            leftPress = false;
          }else{
            image(restartHovered,248,360);
          }
        }
      }
      
      break;
    
  }  //switch
  
  
  
}  //void draw

void keyPressed(){
  if(!isMoving){
    if (key == CODED) {
      switch (keyCode) {
       case DOWN:
         downPress=true;
         isMoving = true;
         break;
       case LEFT:
         leftPress=true;
         isMoving = true;
         break;
       case RIGHT:
         rightPress=true;
         isMoving = true;
         break;
      }
    }
  }
}
  
