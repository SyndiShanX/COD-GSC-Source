/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2613.gsc
**************************************/

_id_960D(var_0) {
  precachemodel("refmat_plastic_black_matte");
  precachemodel("refmat_plastic_black_semiglossy");
  precachemodel("refmat_metal_steel_stainless");
  precachemodel("refmat_metal_steel_stainless_thinfilm");
  precachemodel("test_debug_greycard");
  precachemodel("misc_color_checker_01");
  level._id_4EE6 = 0;
  level._id_4EE8 = "test_debug_greycard";
}

_id_10AA0() {}

onplayerconnect() {}

_id_4EE5() {
  _id_4EE4(1);
}

_id_4EE4(var_0) {}

_id_F336(var_0) {}

_id_E032() {}

_id_48F6() {}

_id_1071E() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel(level._id_4EE8);
  return var_0;
}

_id_4EE7(var_0) {}

_id_48BE(var_0) {
  var_1 = _id_1071E();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;

  if(!isDefined(level._id_4EE9)) {
    level._id_4EE9 = [var_1];
  } else if(level._id_4EE9.size > 50) {
    var_2 = [];
    level._id_4EE9[0] delete();

    for(var_3 = 1; var_3 < level._id_4EE9.size; var_3++) {
      var_2[var_2.size] = level._id_4EE9[var_3];
    }

    var_2[var_2.size] = var_1;
    level._id_4EE9 = var_2;
  } else
    level._id_4EE9[level._id_4EE9.size] = var_1;
}