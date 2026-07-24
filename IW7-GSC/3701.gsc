/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3701.gsc
**************************************/

#using_animtree("generic_human");

_id_DD27() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % rogue_dorm_mr1_idle;
  var_0._id_EBEA["angles"] = [105, 135, 165, 195, 225, 255];
  var_0._id_EBEA[105] = % rogue_dorm_mr1_react_01_r90;
  var_0._id_EBEA[135] = % rogue_dorm_mr1_react_01_r120;
  var_0._id_EBEA[165] = % rogue_dorm_mr1_react_01_r150;
  var_0._id_EBEA[195] = % rogue_dorm_mr1_react_01_l180;
  var_0._id_EBEA[225] = % rogue_dorm_mr1_react_01_l150;
  var_0._id_EBEA[255] = % rogue_dorm_mr1_react_01_l120;
  var_0._id_EBEA["lastanim"] = % rogue_dorm_mr1_react_01_l90;
  var_0._id_EBEA["trigger_radius"] = 200;
  var_0._id_EBEA["initial_reaction_blendtime"] = 0.4;
  var_0._id_EBEA["lookat_follow_blendtime"] = 0.4;
  var_0._id_EBEA["lookat_end_blendtime"] = 0.4;
  scripts\sp\interaction::register_interaction("rogue_ipd_01_react", var_0);
}

_id_DD28() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % rogue_dorm_mr1_idle;
  var_0._id_EBEA["angles"] = [105, 135, 165, 195, 225, 255];
  var_0._id_EBEA[105] = % rogue_dorm_mr1_react_02_r90;
  var_0._id_EBEA[135] = % rogue_dorm_mr1_react_02_r120;
  var_0._id_EBEA[165] = % rogue_dorm_mr1_react_02_r150;
  var_0._id_EBEA[195] = % rogue_dorm_mr1_react_02_l180;
  var_0._id_EBEA[225] = % rogue_dorm_mr1_react_02_l150;
  var_0._id_EBEA[255] = % rogue_dorm_mr1_react_02_l120;
  var_0._id_EBEA["lastanim"] = % rogue_dorm_mr1_react_02_l90;
  var_0._id_EBEA["trigger_radius"] = 200;
  var_0._id_EBEA["initial_reaction_blendtime"] = 0.4;
  var_0._id_EBEA["lookat_follow_blendtime"] = 0.4;
  var_0._id_EBEA["lookat_end_blendtime"] = 0.4;
  scripts\sp\interaction::register_interaction("rogue_ipd_02_react", var_0);
}