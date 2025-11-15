/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2716.gsc
***************************************/

init() {
  if(!level.teambased) {
    return;
  }
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_0.func_F1E9 = [];
  }
}

func_12E86() {}

func_17C1(var_00, var_01, var_02, var_03) {
  if(!level.teambased) {
    return;
  }
  var_04 = var_0.origin;
  var_01 endon("spawned_player");
  var_01 endon("disconnect");
  wait 0.05;
  scripts\mp\utility\game::func_13842();

  if(getdvar("ui_hud_showdeathicons") == "0") {
    return;
  }
  if(level.hardcoremode) {
    return;
  }
  if(isDefined(self.lastdeathicon))
    self.lastdeathicon destroy();

  var_05 = newteamhudelem(var_02);
  var_5.x = var_4[0];
  var_5.y = var_4[1];
  var_5.z = var_4[2] + 54;
  var_5.alpha = 0.61;
  var_5.archived = 0;
  var_5.showinkillcam = 0;

  if(level.splitscreen)
    var_05 setshader("hud_icon_death", 14, 14);
  else
    var_05 setshader("hud_icon_death", 7, 7);

  var_05 setwaypoint(0);
  self.lastdeathicon = var_05;
  var_05 thread func_5323(var_03);
}

func_5323(var_00) {
  self endon("death");
  wait(var_00);
  self fadeovertime(1.0);
  self.alpha = 0;
  wait 1.0;
  self destroy();
}