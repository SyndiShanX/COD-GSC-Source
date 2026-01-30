/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42885.gsc
**************************************/

init() {
  if(!level.teambased) {
    return;
  }
  precacheshader("headicon_dead");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.selfdeathicons = [];
  }
}

updatedeathiconsenabled() {}

adddeathicon(var_0, var_1, var_2, var_3, var_4) {
  if(!level.teambased) {
    return;
  }
  if(isDefined(var_4) && isplayer(var_4) && var_4 maps\mp\_utility::_hasperk("specialty_silentkill")) {
    return;
  }
  var_5 = var_0.origin;
  var_1 endon("spawned_player");
  var_1 endon("disconnect");
  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();

  if(getdvar("ui_hud_showdeathicons") == "0") {
    return;
  }
  if(level.hardcoremode) {
    return;
  }
  if(isDefined(self.lastdeathicon)) {
    self.lastdeathicon destroy();
  }

  var_6 = newteamhudelem(var_2);
  var_6.x = var_5[0];
  var_6.y = var_5[1];
  var_6.z = var_5[2] + 54;
  var_6.alpha = 0.61;
  var_6.archived = 1;

  if(level.splitscreen) {
    var_6 setshader("headicon_dead", 14, 14);
  } else {
    var_6 setshader("headicon_dead", 7, 7);
  }

  var_6 setwaypoint(0);
  self.lastdeathicon = var_6;
  var_6 thread destroyslowly(var_3);
}

destroyslowly(var_0) {
  self endon("death");
  wait(var_0);
  self fadeovertime(1.0);
  self.alpha = 0;
  wait 1.0;
  self destroy();
}