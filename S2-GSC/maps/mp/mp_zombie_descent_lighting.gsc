/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_descent_lighting.gsc
**************************************************/

func_00F9() {
  func_84F8();
}

xbox_optimizations() {
  setDvar("1578", 0);
  setDvar("5156", 0);
  setDvar("3158", 0.7);
  setDvar("2225", 4);
  setDvar("sm_spotDynamics", 4);
}

lightningrodlights() {
  var_00 = function_021F("lightningrodlights", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "on");
  }
}

bossintrolightson() {
  var_00 = function_021F("boss_intro_lgt", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "on");
  }
}

bossintrolightsoff() {
  var_00 = function_021F("boss_intro_lgt", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "off");
  }
}

bossarenalightsoff() {
  var_00 = function_021F("boss_arena_lgt", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "off");
  }
}

bossarenalightson() {
  var_00 = function_021F("boss_arena_lgt", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "on");
  }
}

func_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 1);
}

func_6B82() {
  var_00 = self;
  var_00 endon("disconnect");
  wait(15);
  var_00 method_8483("mp_zombie_descent_moonravengreen");
  wait(5);
  var_00 method_8483("");
}