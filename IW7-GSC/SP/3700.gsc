/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3700.gsc
**************************************/

#using_animtree("generic_human");

_id_EA4F() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % rogue_dorm_mr1_idle;
  var_0._id_EBEA["angles"] = [45, 75, 105, 135, 165];
  var_0._id_EBEA[45] = % rogue_ctrl_room_xo_react_r30;
  var_0._id_EBEA[75] = % rogue_ctrl_room_xo_react_r60;
  var_0._id_EBEA[105] = % rogue_ctrl_room_xo_react_l00;
  var_0._id_EBEA[135] = % rogue_ctrl_room_xo_react_l30;
  var_0._id_EBEA[165] = % rogue_ctrl_room_xo_react_l60;
  var_0._id_EBEA["lastanim"] = % rogue_ctrl_room_xo_react_l90;
  var_0._id_EBEA["trigger_radius"] = 99999;
  scripts\sp\interaction::register_interaction("salter_ctrl", var_0);
}