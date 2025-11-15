/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2740.gsc
***************************************/

global_fx(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\engine\utility::getstructarray(var_00, "targetname");

  if(var_5.size <= 0) {
    return;
  }
  if(!isDefined(var_02))
    var_02 = randomfloatrange(-20, -15);

  if(!isDefined(var_03))
    var_03 = var_01;

  foreach(var_07 in var_05) {
    if(!isDefined(level._effect))
      level._effect = [];

    if(!isDefined(level._effect[var_03]))
      level._effect[var_03] = loadfx(var_01);

    if(!isDefined(var_7.angles))
      var_7.angles = (0, 0, 0);

    var_08 = scripts\engine\utility::createoneshoteffect(var_03);
    var_8.v["origin"] = var_7.origin;
    var_8.v["angles"] = var_7.angles;
    var_8.v["fxid"] = var_03;
    var_8.v["delay"] = var_02;

    if(isDefined(var_04))
      var_8.v["soundalias"] = var_04;
  }
}