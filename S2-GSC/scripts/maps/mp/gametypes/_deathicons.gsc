/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_deathicons.gsc
*****************************************************/

init() {
  if(!level.teambased) {
    return;
  }
  _func_13F("friendly_death_hud");
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_83C1 = [];
  }
}

_id_A107() {}

_id_09AA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!level.teambased) {
    return;
  }
  if(isDefined(var_4)) {
    if(isPlayer(var_4) && var_4 maps\mp\_utility::_hasperk("specialty_silentkill")) {
      return;
    }
    if(isDefined(var_5) && maps\mp\_utility::_id_5755(var_5) && isDefined(var_6) && _func_1A9(var_6) == "melee")
      return;
  }

  var_7 = var_0.origin;
  var_1 endon("spawned_player");
  var_1 endon("disconnect");
  waitframe();
  maps\mp\_utility::waittillslowprocessallowed();

  if(getDvar("ui_hud_showdeathicons") == "0") {
    return;
  }
  if(level.hardcoremode) {
    return;
  }
  if(isDefined(self._id_5B8E))
    self._id_5B8E destroy();

  var_8 = _func_19C(var_2);
  var_8.x = var_7[0];
  var_8.y = var_7[1];
  var_8._id_01D9 = var_7[2] + 54;
  var_8.alpha = 0.61;
  var_8.color = (0.905882, 0.878431, 0.768627);
  var_8.archived = 1;

  if(level.splitscreen)
    var_8 setshader("friendly_death_hud", 14, 14);
  else
    var_8 setshader("friendly_death_hud", 7, 7);

  var_8 _meth_80CB(0);
  self._id_5B8E = var_8;
  var_8 thread _id_2DDC(var_3);
}

_id_2DDC(var_0) {
  self endon("death");
  wait(var_0);
  self fadeovertime(1.0);
  self.alpha = 0;
  wait 1.0;
  self destroy();
}