/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\simplecredits_code.gsc
***************************************/

createblackoverlay() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("black", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
}

createskipcredits() {
  level.skipcredits = newhudelem();
  level.skipcredits.sort = 5;
  level.skipcredits.alignx = "right";
  level.skipcredits.aligny = "bottom";
  level.skipcredits.horzalign = "right";
  level.skipcredits.vertalign = "bottom";
  level.skipcredits.fontscale = 1.0;
  level.skipcredits.font = "default";
  level.skipcredits.glowalpha = 0;
  level.skipcredits setpulsefx(30, 900000, 700);
  level.skipcredits.alpha = 0;

  if(level.console == 1) {
    level.skipcredits.x = -5;
    level.skipcredits.y = -17;
  } else {
    level.skipcredits.x = -30;
    level.skipcredits.y = -27;
  }
}