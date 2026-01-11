/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2613.gsc
***************************************/

func_960D(var_00) {
  precachemodel("refmat_plastic_black_matte");
  precachemodel("refmat_plastic_black_semiglossy");
  precachemodel("refmat_metal_steel_stainless");
  precachemodel("refmat_metal_steel_stainless_thinfilm");
  precachemodel("test_debug_greycard");
  precachemodel("misc_color_checker_01");
  level.func_4EE6 = 0;
  level.func_4EE8 = "test_debug_greycard";
}

func_10AA0() {}

onplayerconnect() {}

func_4EE5() {
  func_4EE4(1);
}

func_4EE4(var_00) {}

func_F336(var_00) {}

func_E032() {}

func_48F6() {}

func_1071E() {
  var_00 = spawn("script_model", self.origin);
  var_00 setModel(level.func_4EE8);
  return var_00;
}

func_4EE7(var_00) {}

func_48BE(var_00) {
  var_01 = func_1071E();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;

  if(!isDefined(level.func_4EE9)) {
    level.func_4EE9 = [var_01];
  }
  else if(level.func_4EE9.size > 50) {
    var_02 = [];
    level.func_4EE9[0] delete();

    for(var_03 = 1; var_03 < level.func_4EE9.size; var_3++) {
      var_2[var_2.size] = level.func_4EE9[var_03];
    }

    var_2[var_2.size] = var_01;
    level.func_4EE9 = var_02;
  } else
    level.func_4EE9[level.func_4EE9.size] = var_01;
}