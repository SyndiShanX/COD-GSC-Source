/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3799.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_stand_salute_idle_02;
  var_0._id_EBEA["follow"] = % shipcrib_stand_salute_follow_01;
  var_0._id_EBEA["ring"] = % follow_ring;
  var_0._id_EBEA["backseam"] = 1;
  var_0._id_EBEA["diff"] = % shipcrib_stand_salute_diff_01;
  var_0._id_EBEA["additive"] = % follow_additive;
  var_0._id_EBEA["axis"] = % generic_talker_axis;
  var_0._id_EBEA["talking"] = % scripted_talking;
  var_0._id_EBEA["exitangles"] = [45, 75, 105, 255, 285, 315];
  var_0._id_EBEA["exitangles_anims"][45] = % shipcrib_stand_salute_exit_r30_02;
  var_0._id_EBEA["exitangles_anims"][75] = % shipcrib_stand_salute_exit_r60_02;
  var_0._id_EBEA["exitangles_anims"][105] = % shipcrib_stand_salute_exit_r90_02;
  var_0._id_EBEA["exitangles_anims"][255] = % shipcrib_stand_salute_exit_l90_02;
  var_0._id_EBEA["exitangles_anims"][285] = % shipcrib_stand_salute_exit_l60_02;
  var_0._id_EBEA["exitangles_anims"][315] = % shipcrib_stand_salute_exit_l30_02;
  var_0._id_EBEA["exitangles_anims"]["lastexitanim"] = % shipcrib_stand_salute_exit_l00_02;
  var_0._id_EBEA["angles"] = [45, 75, 105, 255, 285, 315];
  var_0._id_EBEA[45] = % shipcrib_stand_salute_r30_02;
  var_0._id_EBEA[75] = % shipcrib_stand_salute_r60_02;
  var_0._id_EBEA[105] = % shipcrib_stand_salute_r90_02;
  var_0._id_EBEA[255] = % shipcrib_stand_salute_l90_02;
  var_0._id_EBEA[285] = % shipcrib_stand_salute_l60_02;
  var_0._id_EBEA[315] = % shipcrib_stand_salute_l30_02;
  var_0._id_EBEA["lastanim"] = % shipcrib_stand_salute_l00_02;
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("stand_salute_2", var_0);
}