/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_windmill_lighting.gsc
***************************************************/

func_00F9() {
  func_84F8();
  level thread maps\mp\_utility::func_6F74(::func_6B82);
  var_00 = function_021F("auto62", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("lightpart", "off");
  }

  if(level.var_1D4 && getDvar("2695") != "true") {
    xbox_optimizations();
  }
}

func_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 1);
  setDvar("r_sunShadowScale", 1);
  setDvar("5153", 1);
}

func_6B82() {
  var_00 = self;
  var_00 endon("disconnect");
  wait(1.5);
  var_00 vignettesetparams(0.85, 0.25, 1, 1, 0);
}

xbox_optimizations() {
  setDvar("r_sunShadowScale", 0.7);
  setDvar("r_sunSampleSizeNear", 0.25);
  setDvar("5153", 0);
}