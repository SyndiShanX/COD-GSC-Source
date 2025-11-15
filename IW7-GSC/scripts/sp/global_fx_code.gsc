/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\global_fx_code.gsc
*****************************************/

global_fx(param_00, param_01, param_02, param_03, param_04) {
  init();
  level.global_fx[param_00] = param_03;
  var_05 = scripts\sp\utility::_meth_8181(param_00, "targetname");
  if(!isDefined(var_05)) {
    return;
  }

  if(!var_05.size) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = param_01;
  }

  if(!isDefined(param_02)) {
    param_02 = randomfloatrange(-20, -15);
  }

  foreach(var_07 in var_05) {
    if(!isDefined(level._effect[param_03])) {
      level._effect[param_03] = loadfx(param_01);
    }

    if(!isDefined(var_07.angles)) {
      var_07.angles = (0, 0, 0);
    }

    var_08 = scripts\engine\utility::createoneshoteffect(param_03);
    var_08.v["origin"] = var_07.origin;
    var_08.v["angles"] = var_07.angles;
    var_08.v["fxid"] = param_03;
    var_08.v["delay"] = param_02;
    if(isDefined(param_04)) {
      var_08.v["soundalias"] = param_04;
    }

    if(!isDefined(var_07.script_noteworthy)) {
      continue;
    }

    var_09 = var_07.script_noteworthy;
    if(!isDefined(level.var_12C7[var_09])) {
      level.var_12C7[var_09] = [];
    }

    level.var_12C7[var_09][level.var_12C7[var_09].size] = var_08;
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