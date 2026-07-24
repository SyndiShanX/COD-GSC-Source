/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3744.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_point_reaction_idle_01;
  var_0._id_EBEA["angles"] = [105, 135, 160, 180, 200, 220, 240];
  var_0._id_EBEA[105] = % shipcrib_point_reaction_r90_01;
  var_0._id_EBEA[135] = % shipcrib_point_reaction_r120_01;
  var_0._id_EBEA[160] = % shipcrib_point_reaction_r150_01;
  var_0._id_EBEA[180] = % shipcrib_point_reaction_r180_01;
  var_0._id_EBEA[200] = % shipcrib_point_reaction_l180_01;
  var_0._id_EBEA[220] = % shipcrib_point_reaction_l150_01;
  var_0._id_EBEA[240] = % shipcrib_point_reaction_l120_01;
  var_0._id_EBEA["lastanim"] = % shipcrib_point_reaction_l90_01;
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("shipcrib_stand_point_left_01", var_0);
}