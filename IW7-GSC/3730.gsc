/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3730.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = [%shipcrib_armory_idlea_l00_01];
  var_1 = [%shipcrib_armory_idlea_l00_01];
  var_2 = [%shipcrib_armory_idlea_l00_01];
  var_3 = [%shipcrib_armory_idlea_l00_01];
  var_4 = [%shipcrib_armory_idlea_l00_01];
  var_5 = [%shipcrib_armory_idlea_r30_01];
  var_6 = [%shipcrib_armory_idlea_r30_01];
  var_7 = [%shipcrib_armory_idlea_r30_01];
  var_8 = [%shipcrib_armory_idlea_r30_01];
  var_9 = [%shipcrib_armory_idlea_r30_01];
  var_10 = [%shipcrib_armory_idlea_r60_01];
  var_11 = [%shipcrib_armory_idlea_r60_01];
  var_12 = [%shipcrib_armory_idlea_r60_01];
  var_13 = [%shipcrib_armory_idlea_r60_01];
  var_14 = [%shipcrib_armory_idlea_r60_01];
  var_15 = [%shipcrib_armory_idlea_l60_01];
  var_16 = [%shipcrib_armory_idlea_l60_01];
  var_17 = [%shipcrib_armory_idlea_l60_01];
  var_18 = [%shipcrib_armory_idlea_l60_01];
  var_19 = [%shipcrib_armory_idlea_l60_01];
  var_20 = [%shipcrib_armory_idlea_l30_01];
  var_21 = [%shipcrib_armory_idlea_l30_01];
  var_22 = [%shipcrib_armory_idlea_l30_01];
  var_23 = [%shipcrib_armory_idlea_l30_01];
  var_24 = [%shipcrib_armory_idlea_l30_01];
  var_25 = spawnStruct();
  var_25._id_EBEA = [];
  var_25._id_EBEA["follow"] = % shipcrib_stand_stationary_talk_follow_01;
  var_25._id_EBEA["ring"] = % follow_ring;
  var_25._id_EBEA["backseam"] = 1;
  var_25._id_EBEA["diff"] = [%shipcrib_stand_salute_diff_01];
  var_25._id_EBEA["additive"] = % follow_additive;
  var_25._id_EBEA["idle"] = [%shipcrib_armory_idlea_01, %shipcrib_armory_idlea_vig_01, %shipcrib_armory_idlea_vig_02, %shipcrib_armory_idlea_vig_03, %shipcrib_armory_idlea_vig_04, %shipcrib_armory_idlea_vig_05, %shipcrib_armory_idlea_vig_06, %shipcrib_armory_idlea_vig_07, %shipcrib_armory_idlea_vig_08];
  var_25._id_EBEA["angles"] = [15, 45, 75, 315, 345];
  var_25._id_EBEA[15] = [[var_0, var_1, var_2, var_3, var_4]];
  var_25._id_EBEA[45] = [[var_5, var_6, var_7, var_8, var_9]];
  var_25._id_EBEA[75] = [[var_10, var_11, var_12, var_13, var_14]];
  var_25._id_EBEA[315] = [[var_15, var_16, var_17, var_18, var_19]];
  var_25._id_EBEA[345] = [[var_20, var_21, var_22, var_23, var_24]];
  var_25._id_EBEA["lastanim"] = [[var_0, var_1, var_2, var_3, var_4]];
  var_25._id_EBEA["exitangles"] = [15, 45, 75, 315, 345];
  var_25._id_EBEA["exitangles_anims"][15] = % shipcrib_armory_idlea_l00_exit_01;
  var_25._id_EBEA["exitangles_anims"][45] = % shipcrib_armory_idlea_r30_exit_01;
  var_25._id_EBEA["exitangles_anims"][75] = % shipcrib_armory_idlea_r60_exit_01;
  var_25._id_EBEA["exitangles_anims"][315] = % shipcrib_armory_idlea_l60_exit_01;
  var_25._id_EBEA["exitangles_anims"][345] = % shipcrib_armory_idlea_l30_exit_01;
  var_25._id_EBEA["exitangles_anims"]["lastexitanim"] = % shipcrib_armory_idlea_l00_exit_01;
  var_25._id_EBEA["trigger_radius"] = 120;
  scripts\sp\interaction::register_interaction("shipcrib_moon_armory_officer_react", var_25);
}