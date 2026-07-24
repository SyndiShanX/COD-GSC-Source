/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4261.gsc
**************************************/

_id_5E9B() {
  precachemodel("p7_desk_metal_military_03_tablet");
}

_id_5E99(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_DEB9();
  _id_DEBA();

  if(isDefined(var_1))
    level thread _id_FD7B(var_0, var_1);

  if(isDefined(var_2))
    level thread _id_FD7C(var_0, var_2);

  if(isDefined(var_3))
    level thread _id_FD7D(var_0, var_3);

  if(isDefined(var_4) || isDefined(var_5))
    level thread _id_FD7E(var_0, var_4, var_5);

  if(isDefined(var_6) || isDefined(var_7))
    level thread _id_FD7F(var_0, var_6, var_7);
}

_id_5E9A(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1F1C))
      var_2._id_1F1C notify("ambient_idle_scene_end");

    if(isDefined(var_2._id_1DF7))
      var_2._id_1DF7 delete();

    var_2 notify("cleaned");

    if(isDefined(var_2._id_B14F))
      var_2 scripts\sp\utility::_id_1101B();

    if(isai(var_2))
      var_2 _meth_81D0();

    var_2 delete();
  }
}

#using_animtree("generic_human");

_id_DEB9() {
  var_0 = [%shipcrib_dropship_serv_grnd_a_01_a, %shipcrib_dropship_serv_grnd_a_01_idle, %shipcrib_dropship_serv_grnd_a_01_b];
  var_1 = [%shipcrib_dropship_serv_grnd_a_03_a, %shipcrib_dropship_serv_grnd_a_03_idle, %shipcrib_dropship_serv_grnd_a_03_b];
  var_2 = [%shipcrib_dropship_serv_grnd_a_04_a, %shipcrib_dropship_serv_grnd_a_04_idle, %shipcrib_dropship_serv_grnd_a_04_b];
  var_3 = [%shipcrib_dropship_serv_grnd_a_06_a, %shipcrib_dropship_serv_grnd_a_06_idle, %shipcrib_dropship_serv_grnd_a_06_b];
  level._id_EC87["shipcrib_dropship_serv_grnd_A"] = #animtree;
  level._id_EC85["shipcrib_dropship_serv_grnd_A"]["idle_base"] = % shipcrib_dropship_serv_grnd_a_00_idle;
  level._id_EC85["shipcrib_dropship_serv_grnd_A"]["idle_anims"] = [var_0, var_1, var_2, var_3];
  var_0 = [%shipcrib_dropship_serv_grnd_b_01_a, %shipcrib_dropship_serv_grnd_b_01_idle, %shipcrib_dropship_serv_grnd_b_01_b];
  var_1 = [%shipcrib_dropship_serv_grnd_b_02_a, %shipcrib_dropship_serv_grnd_b_02_idle, %shipcrib_dropship_serv_grnd_b_02_b];
  var_2 = [%shipcrib_dropship_serv_grnd_b_03_a, %shipcrib_dropship_serv_grnd_b_03_idle, %shipcrib_dropship_serv_grnd_b_03_b];
  var_3 = [%shipcrib_dropship_serv_grnd_b_04_a, %shipcrib_dropship_serv_grnd_b_04_idle, %shipcrib_dropship_serv_grnd_b_04_b];
  level._id_EC87["shipcrib_dropship_serv_grnd_B"] = #animtree;
  level._id_EC85["shipcrib_dropship_serv_grnd_B"]["idle_base"] = % shipcrib_dropship_serv_grnd_b_00_idle;
  level._id_EC85["shipcrib_dropship_serv_grnd_B"]["idle_anims"] = [var_0, var_1, var_2, var_3];
  var_0 = [%shipcrib_dropship_serv_grnd_c_02_a, %shipcrib_dropship_serv_grnd_c_02_idle, %shipcrib_dropship_serv_grnd_c_02_b];
  var_1 = [%shipcrib_dropship_serv_grnd_c_03_a, %shipcrib_dropship_serv_grnd_c_03_idle, %shipcrib_dropship_serv_grnd_c_03_b];
  var_2 = [%shipcrib_dropship_serv_grnd_c_04_a, %shipcrib_dropship_serv_grnd_c_04_idle, %shipcrib_dropship_serv_grnd_c_04_b];
  level._id_EC87["shipcrib_dropship_serv_grnd_C"] = #animtree;
  level._id_EC85["shipcrib_dropship_serv_grnd_C"]["idle_base"] = % shipcrib_dropship_serv_grnd_c_00_idle;
  level._id_EC85["shipcrib_dropship_serv_grnd_C"]["idle_anims"] = [var_0, var_1, var_2];
  level._id_EC87["shipcrib_dropship_serv_top_A"] = #animtree;
  level._id_EC85["shipcrib_dropship_serv_top_A"]["idle_base"] = % shipcrib_dropship_serv_top_a_idle;
  level._id_EC85["shipcrib_dropship_serv_top_A"]["idle_anims"] = [%shipcrib_dropship_serv_top_a_01, %shipcrib_dropship_serv_top_a_02, %shipcrib_dropship_serv_top_a_03];
  level._id_EC87["shipcrib_dropship_serv_top_B"] = #animtree;
  level._id_EC85["shipcrib_dropship_serv_top_B"]["idle_base"] = % shipcrib_dropship_serv_top_b_idle;
  level._id_EC85["shipcrib_dropship_serv_top_B"]["idle_anims"] = [%shipcrib_dropship_serv_top_b_01, %shipcrib_dropship_serv_top_b_02, %shipcrib_dropship_serv_top_b_03];
  level._id_EC87["shipcrib_dropship_serv_wing_L"] = #animtree;
  level._id_EC85["shipcrib_dropship_serv_wing_L"]["idle_base"] = % shipcrib_dropship_serv_wing_l_idle;
  level._id_EC85["shipcrib_dropship_serv_wing_L"]["idle_anims"] = [%shipcrib_dropship_serv_wing_l_01, %shipcrib_dropship_serv_wing_l_02];
  level._id_EC87["shipcrib_dropship_serv_wing_R"] = #animtree;
  level._id_EC85["shipcrib_dropship_serv_wing_R"]["idle_base"] = % shipcrib_dropship_serv_wing_r_idle;
  level._id_EC85["shipcrib_dropship_serv_wing_R"]["idle_anims"] = [%shipcrib_dropship_serv_wing_r_01, %shipcrib_dropship_serv_wing_r_01];
}

#using_animtree("script_model");

_id_DEBA() {
  var_0 = [%shipcrib_dropship_serv_grnd_a_01_a_prop, %shipcrib_dropship_serv_grnd_a_01_idle_prop, %shipcrib_dropship_serv_grnd_a_01_b_prop];
  var_1 = [%shipcrib_dropship_serv_grnd_a_03_a_prop, %shipcrib_dropship_serv_grnd_a_03_idle_prop, %shipcrib_dropship_serv_grnd_a_03_b_prop];
  var_2 = [%shipcrib_dropship_serv_grnd_a_04_a_prop, %shipcrib_dropship_serv_grnd_a_04_idle_prop, %shipcrib_dropship_serv_grnd_a_04_b_prop];
  var_3 = [%shipcrib_dropship_serv_grnd_a_06_a_prop, %shipcrib_dropship_serv_grnd_a_06_idle_prop, %shipcrib_dropship_serv_grnd_a_06_b_prop];
  level._id_EC87["shipcrib_dropship_serv_grnd_A_prop"] = #animtree;
  level._id_EC8C["shipcrib_dropship_serv_grnd_A_prop"] = "p7_desk_metal_military_03_tablet";
  level._id_EC85["shipcrib_dropship_serv_grnd_A_prop"]["idle_base"] = % shipcrib_dropship_serv_grnd_a_00_idle_prop;
  level._id_EC85["shipcrib_dropship_serv_grnd_A_prop"]["idle_anims"] = [var_0, var_1, var_2, var_3];
  var_0 = [%shipcrib_dropship_serv_grnd_b_01_a_prop, %shipcrib_dropship_serv_grnd_b_01_idle_prop, %shipcrib_dropship_serv_grnd_b_01_b_prop];
  var_1 = [%shipcrib_dropship_serv_grnd_b_02_a_prop, %shipcrib_dropship_serv_grnd_b_02_idle_prop, %shipcrib_dropship_serv_grnd_b_02_b_prop];
  var_2 = [%shipcrib_dropship_serv_grnd_b_03_a_prop, %shipcrib_dropship_serv_grnd_b_03_idle_prop, %shipcrib_dropship_serv_grnd_b_03_b_prop];
  var_3 = [%shipcrib_dropship_serv_grnd_b_04_a_prop, %shipcrib_dropship_serv_grnd_b_04_idle_prop, %shipcrib_dropship_serv_grnd_b_04_b_prop];
  level._id_EC87["shipcrib_dropship_serv_grnd_B_prop"] = #animtree;
  level._id_EC8C["shipcrib_dropship_serv_grnd_B_prop"] = "p7_desk_metal_military_03_tablet";
  level._id_EC85["shipcrib_dropship_serv_grnd_B_prop"]["idle_base"] = % shipcrib_dropship_serv_grnd_b_00_idle_prop;
  level._id_EC85["shipcrib_dropship_serv_grnd_B_prop"]["idle_anims"] = [var_0, var_1, var_2, var_3];
  var_0 = [%shipcrib_dropship_serv_grnd_c_02_a_prop, %shipcrib_dropship_serv_grnd_c_02_idle_prop, %shipcrib_dropship_serv_grnd_c_02_b_prop];
  var_1 = [%shipcrib_dropship_serv_grnd_c_03_a_prop, %shipcrib_dropship_serv_grnd_c_03_idle_prop, %shipcrib_dropship_serv_grnd_c_03_b_prop];
  var_2 = [%shipcrib_dropship_serv_grnd_c_04_a_prop, %shipcrib_dropship_serv_grnd_c_04_idle_prop, %shipcrib_dropship_serv_grnd_c_04_b_prop];
  level._id_EC87["shipcrib_dropship_serv_grnd_C_prop"] = #animtree;
  level._id_EC8C["shipcrib_dropship_serv_grnd_C_prop"] = "p7_desk_metal_military_03_tablet";
  level._id_EC85["shipcrib_dropship_serv_grnd_C_prop"]["idle_base"] = % shipcrib_dropship_serv_grnd_c_00_idle_prop;
  level._id_EC85["shipcrib_dropship_serv_grnd_C_prop"]["idle_anims"] = [var_0, var_1, var_2];
}

_id_FD7B(var_0, var_1) {
  var_1._id_1FBB = "shipcrib_dropship_serv_grnd_A";
  var_2 = scripts\sp\utility::_id_10639("shipcrib_dropship_serv_grnd_A_prop", var_0.origin);
  var_1._id_1F1C = var_0;
  var_1._id_1DF7 = var_2;
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2], 1, 0);
}

_id_FD7C(var_0, var_1) {
  var_1._id_1FBB = "shipcrib_dropship_serv_grnd_B";
  var_2 = scripts\sp\utility::_id_10639("shipcrib_dropship_serv_grnd_B_prop", var_0.origin);
  var_1._id_1F1C = var_0;
  var_1._id_1DF7 = var_2;
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2], 1, 0);
}

_id_FD7D(var_0, var_1) {
  var_1._id_1FBB = "shipcrib_dropship_serv_grnd_C";
  var_2 = scripts\sp\utility::_id_10639("shipcrib_dropship_serv_grnd_C_prop", var_0.origin);
  var_1._id_1F1C = var_0;
  var_1._id_1DF7 = var_2;
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2], 1, 0);
}

_id_FD7E(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(var_1)) {
    var_1._id_1FBB = "shipcrib_dropship_serv_top_A";
    var_1._id_1F1C = var_0;
    var_3[var_3.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_2._id_1FBB = "shipcrib_dropship_serv_top_B";
    var_2._id_1F1C = var_0;
    var_3[var_3.size] = var_2;
  }

  if(var_3.size > 0)
    var_0 thread scripts\sp\idles::_id_CC80(var_3);
}

_id_FD7F(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1._id_1FBB = "shipcrib_dropship_serv_wing_L";
    var_1._id_1F1C = var_0;
    var_0 thread scripts\sp\idles::_id_CC7F(var_1, 1);
  }

  if(isDefined(var_2)) {
    var_2._id_1FBB = "shipcrib_dropship_serv_wing_R";
    var_2._id_1F1C = var_0;
    var_0 thread scripts\sp\idles::_id_CC7F(var_2, 1);
  }
}