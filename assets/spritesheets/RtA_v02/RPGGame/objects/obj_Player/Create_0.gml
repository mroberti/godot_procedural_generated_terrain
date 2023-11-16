
framespeed = 0.2;
depth = 100;
image_speed = 0.2;

/*
inmovement = false;
moveleft = false;
moveright = false;
moveup = false;
movedown = false;
*/
global.playerisBlocked = false;
nexttile = -1;
groundtile = -1;
currentclimate = "unknown";
xScale = 1;
yScale = 1;
spritewidth = 15;
spriteheight = 18;
offsetY = 0;
submerged = false;
submergedTimerStarted = false;


blockertilesStart = 272; //Start of water tiles
blockertilesStop = 447; //End of mountain/rocks tiles

//states, idle=0, moving = 1
global.playerState = 0;
movingLeft = false;
movingUp = false;
movingRight = false;
movingDown = false;

//stats
lookahead = 1; //How many pixels further out to check for collisions
stepsizeX = 1.33; //Amount of pixels to move per step, horizontally - set to 16 to move full tiles etc
stepsizeY = 1;
//movespeed = 1;

//vision = 48; //3 tiles out from player center, all directions

animationInit();
playerButtons();


