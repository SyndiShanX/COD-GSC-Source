/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_global_fx_code.gsc
***************************************/

global_fx(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::getstructarray(var_0, "targetname");

  if(var_5.size <= 0) {
    return;
  }
  if(!isdefined(var_2))
    var_2 = randomfloatrange(-20, -15);

  if(!isdefined(var_3))
    var_3 = var_1;

  foreach(var_7 in var_5) {
    if(!isdefined(level._effect))
      level._effect = [];

    if(!isdefined(level._effect[var_3]))
      level._effect[var_3] = loadfx(var_1);

    if(!isdefined(var_7.angles))
      var_7.angles = (0, 0, 0);

    var_8 = common_scripts\utility::createoneshoteffect(var_3);
    var_8.v["origin"] = var_7.origin;
    var_8.v["angles"] = var_7.angles;
    var_8.v["fxid"] = var_3;
    var_8.v["delay"] = var_2;

    if(isdefined(var_4))
      var_8.v["soundalias"] = var_4;
  }
}