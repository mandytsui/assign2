PImage bg1, bg2, enemy, fighter, hp, treasure, start1, start2, end1, end2;

void setup () {
  size(640,480) ;
  bg1 = loadImage ("img/bg1.png");
  bg2 = loadImage ("img/bg2.png");
  enemy = loadImage ("img/enemy.png");
  fighter = loadImage ("img/fighter.png");
  hp = loadImage ("img/hp.png");
  treasure = loadImage ("img/treasure.png");
  end1 = loadImage ("img/end1.png");
  end2 = loadImage ("img/end2.png");
  start1 = loadImage ("img/start1.png");
  start2 = loadImage ("img/start2.png");
}

boolean gameState = false;
boolean endState = false;
boolean startFlash = true;
boolean endFlash = true;
int bg1Pos = 640;
int bg2Pos = 0;
int score = -1;
int startBuffer = 0;
int endBuffer = 0;
float heroPosX = 550;
float heroPosY = 240;
float enemyPosX = 0;
float enemyPosY;
float hpAmount = 200;
float hpPercentage = 0.2;
float treasurePosX = random(40,560);
float treasurePosY = random(60,420);

void draw() {
  if(gameState==false){
    if(endState==true){
      if(endFlash==true){
        image(end1, 0, 0);
      }else{
        image(end2, 0, 0);
      }
      endBuffer+=1;
      if(endBuffer==30){
        endFlash = !endFlash;
        endBuffer = 0;
      }
    }else{
      if(startFlash==true){
        image(start1, 0, 0);
      }else{
        image(start2, 0, 0);
      }
      startBuffer+=1;
      if(startBuffer==30){
        startFlash = !startFlash;
        startBuffer = 0;
      }
    }
  }else{
    image(bg1,-640+bg1Pos,0);
    image(bg2,-640+bg2Pos,0);
    bg1Pos += 5;
    bg1Pos = bg1Pos % 1280;
    bg2Pos += 5;
    bg2Pos = bg2Pos % 1280; //background scrolling
    image(fighter, heroPosX, heroPosY); // fighter position
    fill(255,0,0);
    noStroke();
    rect(45,34,hpAmount*hpPercentage,15); //hp amount
    image(hp, 40, 30); //hp outline
    image(treasure, treasurePosX, treasurePosY); //treasure
    if(heroPosX + 51 >= treasurePosX && heroPosX <= treasurePosX + 41 && heroPosY + 51 >= treasurePosY && heroPosY <= treasurePosY + 41){
      if(hpPercentage < 1.0){
        hpPercentage += 0.1;
        treasurePosX = random(40,560);
        treasurePosY = random(60,420);
      }
    }
    if(heroPosX + 51 >= enemyPosX - 50 && heroPosX <= enemyPosX + 11 && heroPosY + 51 >= enemyPosY && heroPosY <= enemyPosY + 61){
      if(hpPercentage > 0.21){
        hpPercentage -= 0.2;
        enemyPosX = 0;
        score -= 1;
      }else{
        gameState=false;
        endState=true;
      }
    }
    if(enemyPosX <= 6){
      enemyPosY = random(100,420);
      score += 1;
    }
    image(enemy, -50+enemyPosX, enemyPosY); 
    enemyPosY = enemyPosY*0.98+heroPosY*0.02;
    enemyPosX += 4 + abs(enemyPosX - heroPosX)/150;
    enemyPosX = enemyPosX % 680; //enemy movement
  }
}

void keyPressed(){
  if(keyCode==ENTER){
    if(gameState==false && endState == true){
      endState = false;
      hpPercentage = 0.2;
      enemyPosX = 0;
      heroPosX = 550;
      heroPosY = 240;
      treasurePosX = random(40,560);
      treasurePosY = random(60,420);
      score = -1;
    }else{
      gameState = true;
    }
  }
  if(key==CODED){
    if(keyCode==UP && heroPosY>0){
      heroPosY-=20;
    }else if(keyCode==DOWN && heroPosY<429){
      heroPosY+=20;
    }else if(keyCode==LEFT && heroPosX>0){
      heroPosX-=20;
    }else if(keyCode==RIGHT && heroPosX<589){
      heroPosX+=20;
    }
  }
}
