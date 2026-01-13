/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\common\debug_graycard.gsc
*********************************************/

func_960D(var_0) {
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

func_4EE4(var_0) {}

func_F336(var_0) {}

func_E032() {}

func_48F6() {}

func_1071E() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel(level.var_4EE8);
  return var_0;
}

func_4EE7(var_0) {}

func_48BE(var_0) {
  var_1 = func_1071E();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  if(!isDefined(level.var_4EE9)) {
    level.var_4EE9 = [var_1];
    return;
  }

  if(level.var_4EE9.size > 50) {
    var_2 = [];
    level.var_4EE9[0] delete();
    for(var_3 = 1; var_3 < level.var_4EE9.size; var_3++) {
      var_2[var_2.size] = level.var_4EE9[var_3];
    }

    var_2[var_2.size] = var_1;
    level.var_4EE9 = var_2;
    return;
  }

  level.var_4EE9[level.var_4EE9.size] = var_1;
}