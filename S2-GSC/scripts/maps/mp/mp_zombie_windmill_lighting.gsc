/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_windmill_lighting.gsc
***********************************************************/

main() {
  _id_84F8();
  level thread maps\mp\_utility::_id_6F74(::onplayerspawned);
  var_0 = _func_21F("auto62", "targetname");

  foreach(var_2 in var_0)
  var_2 _meth_83FA("lightpart", "off");

  if(level._id_01D4 && getDvar("2695") != "true")
    xbox_optimizations();
}

_id_84F8() {
  setDvar("2973", 0);
  setDvar("2664", 1);
  setDvar("r_sunShadowScale", 1);
  setDvar("5153", 1);
}

onplayerspawned() {
  var_0 = self;
  var_0 endon("disconnect");
  wait 1.5;
  var_0 _meth_806B(0.85, 0.25, 1, 1, 0);
}

xbox_optimizations() {
  setDvar("r_sunShadowScale", 0.7);
  setDvar("r_sunSampleSizeNear", 0.25);
  setDvar("5153", 0);
}