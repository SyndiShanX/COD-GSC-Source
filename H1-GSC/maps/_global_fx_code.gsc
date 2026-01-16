/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_global_fx_code.gsc
********************************/

global_fx(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(level.global_fx_override[var_0])) {
    var_5 = level.global_fx_override[var_0];
    var_0 = var_5["targetname"];
    var_1 = var_5["fxFile"];
    var_2 = var_5["delay"];
    var_3 = var_5["fxName"];
    var_4 = var_5["soundalias"];
  }

  if(!isdefined(level._effect))
    level._effect = [];

  level.global_fx[var_0] = var_3;
  var_6 = maps\_utility::getstructarray_delete(var_0, "targetname");

  if(!isdefined(var_6)) {
    return;
  }
  if(!var_6.size) {
    return;
  }
  if(!isdefined(var_3))
    var_3 = var_1;

  if(!isdefined(var_2))
    var_2 = randomfloatrange(-20, -15);

  foreach(var_8 in var_6) {
    if(!isdefined(level._effect[var_3]))
      level._effect[var_3] = loadfx(var_1);

    if(!isdefined(var_8.angles))
      var_8.angles = (0, 0, 0);

    var_9 = common_scripts\utility::createoneshoteffect(var_3);
    var_9.v["origin"] = var_8.origin;
    var_9.v["angles"] = var_8.angles;
    var_9.v["fxid"] = var_3;
    var_9.v["delay"] = var_2;

    if(isdefined(var_4))
      var_9.v["soundalias"] = var_4;

    if(!isdefined(var_8.script_noteworthy)) {
      continue;
    }
    var_10 = var_8.script_noteworthy;

    if(!isdefined(level._global_fx_ents[var_10]))
      level._global_fx_ents[var_10] = [];

    level._global_fx_ents[var_10][level._global_fx_ents[var_10].size] = var_9;
  }
}

init() {
  if(!isdefined(level.global_fx))
    level.global_fx = [];

  level._global_fx_ents = [];

  if(!isdefined(level.global_fx_override))
    level.global_fx_override = [];
}