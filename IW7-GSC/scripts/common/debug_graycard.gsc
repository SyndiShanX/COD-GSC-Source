/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\common\debug_graycard.gsc
*********************************************/

func_960D(param_00) {
  precachemodel("refmat_plastic_black_matte");
  precachemodel("refmat_plastic_black_semiglossy");
  precachemodel("refmat_metal_steel_stainless");
  precachemodel("refmat_metal_steel_stainless_thinfilm");
  precachemodel("test_debug_greycard");
  precachemodel("misc_color_checker_01");
  level.var_4EE6 = 0;
  level.var_4EE8 = "test_debug_greycard";
}

func_10AA0() {}

onplayerconnect() {}

func_4EE5() {
  func_4EE4(1);
}

func_4EE4(param_00) {}

func_F336(param_00) {}

func_E032() {}

func_48F6() {}

func_1071E() {
  var_00 = spawn("script_model", self.origin);
  var_00 setModel(level.var_4EE8);
  return var_00;
}

func_4EE7(param_00) {}

func_48BE(param_00) {
  var_01 = func_1071E();
  var_01.origin = param_00.origin;
  var_01.angles = param_00.angles;
  if(!isDefined(level.var_4EE9)) {
    level.var_4EE9 = [var_01];
    return;
  }

  if(level.var_4EE9.size > 50) {
    var_02 = [];
    level.var_4EE9[0] delete();
    for(var_03 = 1; var_03 < level.var_4EE9.size; var_03++) {
      var_02[var_02.size] = level.var_4EE9[var_03];
    }

    var_02[var_02.size] = var_01;
    level.var_4EE9 = var_02;
    return;
  }

  level.var_4EE9[level.var_4EE9.size] = var_01;
}