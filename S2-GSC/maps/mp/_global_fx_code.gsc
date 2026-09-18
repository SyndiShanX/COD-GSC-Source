/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_global_fx_code.gsc
*********************************************/

func_47DC(param_00, param_01, param_02, param_03, param_04) {
  var_05 = common_scripts\utility::func_46B7(param_00, "targetname");
  if(var_05.size <= 0) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = randomfloatrange(-20, -15);
  }

  if(!isDefined(param_03)) {
    param_03 = param_01;
  }

  foreach(var_07 in var_05) {
    if(!isDefined(level._effect)) {
      level._effect = [];
    }

    if(!isDefined(level._effect[param_03])) {
      level._effect[param_03] = loadfx(param_01);
    }

    if(!isDefined(var_07.angles)) {
      var_07.angles = (0, 0, 0);
    }

    var_08 = common_scripts\utility::func_281B(param_03);
    var_08.v["origin"] = var_07.origin;
    var_08.v["angles"] = var_07.angles;
    var_08.v["fxid"] = param_03;
    var_08.v["delay"] = param_02;
    if(isDefined(param_04)) {
      var_08.v["soundalias"] = param_04;
    }
  }
}