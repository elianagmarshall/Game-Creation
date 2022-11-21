int x1=300; //x-coordinate of the player
int y1=300; //y-coordinate of the player
int r1=10; //radius of the circles and player
int speed=3; //speed of the player
int startTime; //start time of the game
int score,bestScore; //score of the player, best score overall
int begin,current,max; //beginning time, current time, and max time for boost
int boosts=0; //number of boosts
color yellow=(#F7FF8B); //yellow colour for player boost
color blue=(#67C3FF); //blue colour for player
boolean firstMove; //boolean for the first move
boolean boostStart; //boolean for start of boost
boolean boost=false; //boolean for boosting
boolean finish; //boolean for finishing the game
boolean scoreChange; //boolean for changing the best score

int[] x = new int[10]; //array with length of 10 for x-coordinates
int[] y = new int[10]; //array with length of 10 for y-coordinates
boolean[] collision = new boolean[10]; //array with length of 10 for collision detection

void setup() {
  size(600,600); //size of the run window
  max=3000; //max of 3 seconds for boost
 for(int index=0;index<x.length;index++) { //index variable has an initial value of 0, must be less than the length of x array, and increases by increments of 1
   x[index]=int(random(width)); //randomizer for x-coordinates of circles
   y[index]=int(random(height)); //randomizer for y-coordinates of circles
 }
}

void draw() {
  background(0); //black background
  collisionDetection(); //enables collision detection
  player(); //draws the player
  circles(); //draws the circles
  gameTimer(); //enables the game timer
  boosting(); //enables the boost times
  gameOver(); //enables ending screen
}
  
void player() {
  if(boost==true&&boosts<6) {fill(yellow);} //if boost is true and boosts is less than 6, the player is yellow
  else {fill(blue);} //otherwise, the player is blue
  ellipse(x1,y1,r1*2,r1*2); //circle to represent the player
}

void circles() {
  for(int index=0;index<collision.length;index++) { //index variable has an initial value of 0, must be less than the length of collision array, and increases by increments of 1
    if(collision[index]==false) { //if the index for collision is false
      fill(255); //white colour for circles
      ellipse(x[index],y[index],r1*2,r1*2); //circles to be eaten by the player
    }
  }
}

void collisionDetection() {
    for(int index=0;index<collision.length;index++) { //index variable has an initial value of 0, must be less than the length of collision array, and increases by increments of 1
    if(dist(x1,y1,x[index],y[index])<r1+r1) { //if the distance between the player and a circle is less than the radiuses of the two ellipses combined
      collision[index]=true; //the index for collision is true
    }
  }
}

void gameTimer() {
  if(finish==false){ //if the game has not finished
  if(firstMove==false) { //if the player has not moved
    startTime=millis(); //returns the number of milliseconds that have passed between opening the game and the first move
  }
  current=millis()-startTime; //returns the number of milliseconds that have passed since opening the game minus the number of milliseconds that have passed between opening the game and the first move
  textSize(24); //text size of 24
  fill(255); //white fill colour for text
  text("Time Elapsed:",50,50); //text that says "Time Elapsed:"
  text(current/1000,225,50); //text that displays the number of seconds that has passed since the first move located
  }
}

void boosting() {
  if(boostStart==false) { //if boost start is false
    boostStart=true; //boost start is true
    begin=millis(); //begins the boost timer
  }
  if(finish==false){ //if the game has not finished
    current=millis(); //returns the number of milliseconds that have passed while boosting
  }
  if(current-begin>max) { //if the number of milliseconds that have passed while boosting minus the starting time of the boost is greater than 3 seconds
    boost=false; //boost ends
    boostStart=false; //boost start is false
  }
  if(boost==true&&boosts<6) {speed=6;} //if boost is true and boosts is less than 6, speed is 6
  else {speed=3;} //otherwise, speed is 3
  textSize(24); //text size of 24
  fill(255); //white fill colour for text
  text("Boosts:",450,50); //text that says "Boosts:"
  if(5-boosts<0) { //if there are 0 boosts left
    text("0",550,50); //text that says "0"
  }
  else {
    text(5-boosts,550,50); //text that displays the number of boosts left
    }
  }

void scoring() {
  score=current-startTime; //score is equal to the time spent playing the game
  if(scoreChange==false) { //if the score does not change
    scoreChange=true; //the score changes
    bestScore=score; //the score becomes the best score
  }
  if(score<bestScore) { //if the score is less than the best score
    bestScore=score; //the score becomes the best score
  }
  textSize(24); //tezt size of 24
  fill(255); //white colour for text
  text("Your Score:",50,550); //text that says "Your Score:"
  text(score,200,550); //text that displays the score
  text("Best Score:",350,550); //text that says "Best Score:"
  text(bestScore,500,550); //text that displays the best score
}

void gameOver() {
  if(collision[0] == true && collision[1] == true && collision[2] == true && collision[3] == true && collision[4] ==true && collision[5] == true && collision[6]== true && collision[7] == true && collision[8] == true && collision[9] == true) { //if all values in collision array are true
    finish=true; //the game ends
    fill(0); //black fill colour for rectangle
    rect(0,0,600,600); //draws a rectangle for the game over screen
    textSize(100); //text size of 100
    fill(255); //white fill colour for text
    text("YOU WIN",100,height/2); //text that says "YOU WIN"
    textSize(24); //text size of 24
    text("press 'r' to restart",200,400); //text that says "press 'r' to restart"
    scoring(); //enables scoring system
      }
    }

  void keyPressed() {
  if(key==CODED) { //detects special keys
  firstMove=true; //the player has moved
  if(keyCode==UP) { //if pressing the up arrow key
    y1-=speed; //the player moves up at a rate of 3 pixels
}
  if(keyCode==DOWN) { //if pressing the down arrow key
    y1+=speed; //the player moves down at a rate of 3 pixels
}
  if(keyCode==LEFT) { //if pressing the left arrow key
    x1-=speed; //the player moves left at a rate of 3 pixels
}
  if(keyCode==RIGHT) { //if pressing the right arrow key
    x1+=speed; //the player moves right at a rate of 3 pixels
}
  }
  if(keyPressed) { //if a key is pressed
    if(key=='r') { //if 'r' is pressed
      for(int index=0;index<collision.length;index++) { //index variable has an initial value of 0, must be less than the length of collision array, and increases by increments of 1
        collision[index]=false; //circles reappear
        x1=300; //player =x-coordinate resets to its original value
        y1=300; //player y-coordinate resets to its orginal value
        boosts=0; //number of boosts resets to its original value
        startTime=millis(); //the number of milliseconds that have passed between opening the game and the first move resets
        current=0; //the number of milliseconds that have passed since opening the game resets
        finish=false; //the game is not finished
      }
    }
    if(key==' ') { //if the spacebar is pressed
      if(boostStart==true) { //if boost start is true
      boost=true; //the player boosts
      boosts=boosts+1; //the number of boosts is equal to boosts plus 1
      begin=millis(); //boost timer restarts
      }
      else {
        boost=false; //the player does not boost
      }
    }
  }
}
