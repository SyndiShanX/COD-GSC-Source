/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\global_fx_code.gsc
*****************************************/

global_fx(var_0, var_1, var_2, var_3, var_4) {
  init();
  level.global_fx[var_0] = var_3;
  var_5 = scripts\sp\utility::_meth_8181(var_0, "targetname");
  if(!isDefined(var_5)) {
    return;
  }

  if(!var_5.size) {
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = randomfloatrange(-20, -15);
  }

  foreach(var_7 in var_5) {
    if(!isDefined(level._effect[var_3])) {
      level._effect[var_3] = loadfx(var_1);
    }

    if(!isDefined(var_7.angles)) {
      var_7.angles = (0, 0, 0);
    }

    var_8 = scripts\engine\utility::createoneshoteffect(var_3);
    var_8.v["origin"] = var_7.origin;
    var_8.v["angles"] = var_7.angles;
    var_8.v["fxid"] = var_3;
    var_8.v["delay"] = var_2;
    if(isDefined(var_4)) {
      var_8.v["soundalias"] = var_4;
    }

    if(!isDefined(var_7.script_noteworthy)) {
      continue;
    }

    var_9 = var_7.script_noteworthy;
    if(!isDefined(level.var_12C7[var_9])) {
      level.var_12C7[var_9] = [];
    }

    level.var_12C7[var_9][level.var_12C7[var_9].size] = var_8;
  }
}

init() {
  if(!scripts\engine\utility::add_init_script("global_FX", ::init)) {
    return;
  }

  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  if(!isDefined(level.global_fx)) {
    level.global_fx = [];
  }

  level.var_12C7 = [];
}