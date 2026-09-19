/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_descent_lighting.gsc
**********************************************************/

main() {
  _id_84F8();
}

xbox_optimizations() {
  setDvar("1578", 0);
  setDvar("5156", 0);
  setDvar("3158", 0.7);
  setDvar("2225", 4);
  setDvar("sm_spotDynamics", 4);
}

lightningrodlights() {
  var_0 = _getscriptablearray("lightningrodlights", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "on");
}

bossintrolightson() {
  var_0 = _getscriptablearray("boss_intro_lgt", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "on");
}

bossintrolightsoff() {
  var_0 = _getscriptablearray("boss_intro_lgt", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "off");
}

bossarenalightsoff() {
  var_0 = _getscriptablearray("boss_arena_lgt", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "off");
}

bossarenalightson() {
  var_0 = _getscriptablearray("boss_arena_lgt", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("lightpart", "on");
}

_id_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 1);
}

onplayerspawned() {
  var_0 = self;
  var_0 endon("disconnect");
  wait 15;
  var_0 setclienttriggervisionset("mp_zombie_descent_moonravengreen");
  wait 5;
  var_0 setclienttriggervisionset("");
}