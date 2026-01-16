/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_deathicons.gsc
*********************************************/

init() {
  if(!level.teambased) {
    return;
  }
  precacheshader("headicon_dead");
  level thread onplayerconnect();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0.selfdeathicons = [];
  }
}

updatedeathiconsenabled() {}

adddeathicon(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!level.teambased) {
    return;
  }
  if(isdefined(var_4) && isplayer(var_4) && var_4 maps\mp\_utility::_hasperk("specialty_silentkill")) {
    return;
  }
  var_6 = var_0.origin;
  var_1 endon("spawned_player");
  var_1 endon("disconnect");

  if(!var_5) {
    wait 0.05;
    maps\mp\_utility::waittillslowprocessallowed();
  }

  if(getdvar("ui_hud_showdeathicons") == "0") {
    return;
  }
  if(level.hardcoremode) {
    return;
  }
  if(isdefined(self.lastdeathicon))
    self.lastdeathicon destroy();

  var_7 = newteamhudelem(var_2);
  var_7.x = var_6[0];
  var_7.y = var_6[1];
  var_7.z = var_6[2] + 54;
  var_7.alpha = 0.61;
  var_7.archived = 1;

  if(level.splitscreen)
    var_7 setshader("headicon_dead", 14, 14);
  else
    var_7 setshader("headicon_dead", 7, 7);

  var_7 setwaypoint(0);
  self.lastdeathicon = var_7;
  var_7 thread destroyslowly(var_3);
}

destroyslowly(var_0) {
  self endon("death");
  wait(var_0);
  self fadeovertime(1.0);
  self.alpha = 0;
  wait 1.0;
  self destroy();
}