/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_global_fx_code.gsc
*****************************************************/

global_fx(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._effect))
    level._effect = [];

  level.global_fx[var_0] = var_3;
  var_5 = maps\_utility::getstructarray_delete(var_0, "targetname");

  if(!isDefined(var_5)) {
    return;
  }
  if(!var_5.size) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = var_1;

  if(!isDefined(var_2))
    var_2 = randomfloatrange(-20, -15);

  foreach(var_7 in var_5) {
    if(!isDefined(level._effect[var_3]))
      level._effect[var_3] = loadfx(var_1);

    if(!isDefined(var_7.angles))
      var_7.angles = (0, 0, 0);

    var_8 = common_scripts\utility::createoneshoteffect(var_3);
    var_8.v["origin"] = var_7.origin;
    var_8.v["angles"] = var_7.angles;
    var_8.v["fxid"] = var_3;
    var_8.v["delay"] = var_2;

    if(isDefined(var_4))
      var_8.v["soundalias"] = var_4;

    if(!isDefined(var_7.script_noteworthy)) {
      continue;
    }
    var_9 = var_7.script_noteworthy;

    if(!isDefined(level._global_fx_ents[var_9]))
      level._global_fx_ents[var_9] = [];

    level._global_fx_ents[var_9][level._global_fx_ents[var_9].size] = var_8;
  }
}

init() {
  if(!isDefined(level.global_fx))
    level.global_fx = [];

  level._global_fx_ents = [];
}