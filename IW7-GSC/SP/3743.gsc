/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3743.gsc
**************************************/

#using_animtree("generic_human");

_id_B19C() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["vo_lines_male"] = ["shipcrib_us1_sir1", "shipcrib_us1_fivebyfive", "shipcrib_us1_fivebyfive", "shipcrib_us1_systemsnominal", "shipcrib_us1_intheclear", "shipcrib_us1_solidonthisend", "shipcrib_us1_captain", "shipcrib_un2_captain", "shipcrib_un2_sir", "shipcrib_un2_goodtoseeyouaga", "shipcrib_un2_allgoodherecapt"];
  var_0._id_EBEA["vo_lines_female"] = ["shipcrib_un1_captain", "shipcrib_un1_sir"];
  var_0._id_EBEA["used_male_vo"] = [];
  var_0._id_EBEA["used_female_vo"] = [];
  var_0._id_EBEA["idle"] = [%shipcrib_sit_idle_01];
  var_0._id_EBEA["random_idles"] = [%shipcrib_sit_console_idle_02, %shipcrib_sit_console_idle_03, %shipcrib_sit_console_idle_04, %shipcrib_sit_console_idle_05, %shipcrib_sit_console_idle_06, %shipcrib_sit_console_idle_07, %shipcrib_sit_console_idle_08, %shipcrib_sit_console_idle_09, %shipcrib_sit_console_idle_10, %shipcrib_sit_console_idle_11, %shipcrib_sit_console_idle_12];
  var_0._id_EBEA["idle_female"] = [%shipcrib_sit_idle_01_fem];
  var_0._id_EBEA["random_idles_female"] = [%shipcrib_sit_idle_01_fem];
  var_0._id_EBEA["spent_random_idles"] = [];
  var_0._id_EBEA["spent_random_idles_female"] = [];
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = [%shipcrib_sit_reaction_salute_l00_01, %shipcrib_sit_reaction_nod_l00_01];
  var_0._id_EBEA[45] = [%shipcrib_sit_reaction_salute_r30_01, %shipcrib_sit_reaction_nod_r30_01];
  var_0._id_EBEA[75] = [%shipcrib_sit_reaction_salute_r60_01, %shipcrib_sit_reaction_nod_r60_01];
  var_0._id_EBEA[105] = [%shipcrib_sit_reaction_salute_r90_01, %shipcrib_sit_reaction_nod_r90_01];
  var_0._id_EBEA[135] = [%shipcrib_sit_reaction_salute_r120_01, %shipcrib_sit_reaction_nod_r120_01];
  var_0._id_EBEA[165] = [%shipcrib_sit_reaction_salute_r150_01, %shipcrib_sit_reaction_nod_r150_01];
  var_0._id_EBEA[195] = [%shipcrib_sit_reaction_salute_l180_01, %shipcrib_sit_reaction_nod_l180_01];
  var_0._id_EBEA[225] = [%shipcrib_sit_reaction_salute_l150_01, %shipcrib_sit_reaction_nod_l150_01];
  var_0._id_EBEA[255] = [%shipcrib_sit_reaction_salute_l120_01, %shipcrib_sit_reaction_nod_l120_01];
  var_0._id_EBEA[285] = [%shipcrib_sit_reaction_salute_l90_01, %shipcrib_sit_reaction_nod_l90_01];
  var_0._id_EBEA[315] = [%shipcrib_sit_reaction_salute_l60_01, %shipcrib_sit_reaction_nod_l60_01];
  var_0._id_EBEA[345] = [%shipcrib_sit_reaction_salute_l30_01, %shipcrib_sit_reaction_nod_l30_01];
  var_0._id_EBEA["lastanim"] = [%shipcrib_sit_reaction_salute_l00_01, %shipcrib_sit_reaction_nod_l00_01];
  var_0._id_EBEA["angle_15_spent"] = [];
  var_0._id_EBEA["angle_45_spent"] = [];
  var_0._id_EBEA["angle_75_spent"] = [];
  var_0._id_EBEA["angle_105_spent"] = [];
  var_0._id_EBEA["angle_135_spent"] = [];
  var_0._id_EBEA["angle_165_spent"] = [];
  var_0._id_EBEA["angle_195_spent"] = [];
  var_0._id_EBEA["angle_225_spent"] = [];
  var_0._id_EBEA["angle_255_spent"] = [];
  var_0._id_EBEA["angle_285_spent"] = [];
  var_0._id_EBEA["angle_315_spent"] = [];
  var_0._id_EBEA["angle_345_spent"] = [];
  var_0._id_EBEA["angle_lastanim_spent"] = [];
  var_0._id_22F2 = [];
  var_0._id_22F2["combat"] = "custom_casual_bridge_sit_console_arrival";
  var_0._id_22F2["casual"] = "custom_casual_bridge_sit_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["combat"] = "custom_casual_bridge_sit_console_exit";
  var_0._id_6980["casual"] = "custom_casual_bridge_sit_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  level._id_9A2E._id_4D94["registered_state_interactions"]["sitting_console_casual"] = [];
  level._id_9A2E._id_4D94["registered_state_interactions"]["sitting_console_casual"]["vo_lines_male"] = var_0._id_EBEA["vo_lines_male"];
  level._id_9A2E._id_4D94["registered_state_interactions"]["sitting_console_casual"]["vo_lines_female"] = var_0._id_EBEA["vo_lines_female"];
  var_0._id_EBEA["trigger_radius"] = 50;
  scripts\sp\interaction::_id_DED9("sitting_console_casual", var_0);
}

_id_B177() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["vo_lines_male"] = ["shipcrib_us1_sir1", "shipcrib_us1_fivebyfive", "shipcrib_us1_fivebyfive", "shipcrib_us1_systemsnominal", "shipcrib_us1_intheclear", "shipcrib_us1_solidonthisend", "shipcrib_us1_captain", "shipcrib_un2_captain", "shipcrib_un2_sir", "shipcrib_un2_goodtoseeyouaga", "shipcrib_un2_allgoodherecapt"];
  var_0._id_EBEA["vo_lines_female"] = ["shipcrib_un1_captain", "shipcrib_un1_sir"];
  var_0._id_EBEA["used_male_vo"] = [];
  var_0._id_EBEA["used_female_vo"] = [];
  var_0._id_EBEA["idle"] = [%shipcrib_sit_idle_01];
  var_0._id_EBEA["random_idles"] = [%shipcrib_sit_console_idle_02, %shipcrib_sit_console_idle_03, %shipcrib_sit_console_idle_04, %shipcrib_sit_console_idle_05, %shipcrib_sit_console_idle_06, %shipcrib_sit_console_idle_07, %shipcrib_sit_console_idle_08, %shipcrib_sit_console_idle_09, %shipcrib_sit_console_idle_10, %shipcrib_sit_console_idle_11, %shipcrib_sit_console_idle_12];
  var_0._id_EBEA["idle_female"] = [%shipcrib_sit_idle_01_fem];
  var_0._id_EBEA["random_idles_female"] = [%shipcrib_sit_idle_01_fem];
  var_0._id_EBEA["spent_random_idles"] = [];
  var_0._id_EBEA["spent_random_idles_female"] = [];
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = [%shipcrib_sit_reaction_salute_l00_01, %shipcrib_sit_reaction_nod_l00_01];
  var_0._id_EBEA[45] = [%shipcrib_sit_reaction_salute_r30_01, %shipcrib_sit_reaction_nod_r30_01];
  var_0._id_EBEA[75] = [%shipcrib_sit_reaction_salute_r60_01, %shipcrib_sit_reaction_nod_r60_01];
  var_0._id_EBEA[105] = [%shipcrib_sit_reaction_salute_r90_01, %shipcrib_sit_reaction_nod_r90_01];
  var_0._id_EBEA[135] = [%shipcrib_sit_reaction_salute_r120_01, %shipcrib_sit_reaction_nod_r120_01];
  var_0._id_EBEA[165] = [%shipcrib_sit_reaction_salute_r150_01, %shipcrib_sit_reaction_nod_r150_01];
  var_0._id_EBEA[195] = [%shipcrib_sit_reaction_salute_l180_01, %shipcrib_sit_reaction_nod_l180_01];
  var_0._id_EBEA[225] = [%shipcrib_sit_reaction_salute_l150_01, %shipcrib_sit_reaction_nod_l150_01];
  var_0._id_EBEA[255] = [%shipcrib_sit_reaction_salute_l120_01, %shipcrib_sit_reaction_nod_l120_01];
  var_0._id_EBEA[285] = [%shipcrib_sit_reaction_salute_l90_01, %shipcrib_sit_reaction_nod_l90_01];
  var_0._id_EBEA[315] = [%shipcrib_sit_reaction_salute_l60_01, %shipcrib_sit_reaction_nod_l60_01];
  var_0._id_EBEA[345] = [%shipcrib_sit_reaction_salute_l30_01, %shipcrib_sit_reaction_nod_l30_01];
  var_0._id_EBEA["lastanim"] = [%shipcrib_sit_reaction_salute_l00_01, %shipcrib_sit_reaction_nod_l00_01];
  var_0._id_EBEA["angle_15_spent"] = [];
  var_0._id_EBEA["angle_45_spent"] = [];
  var_0._id_EBEA["angle_75_spent"] = [];
  var_0._id_EBEA["angle_105_spent"] = [];
  var_0._id_EBEA["angle_135_spent"] = [];
  var_0._id_EBEA["angle_165_spent"] = [];
  var_0._id_EBEA["angle_195_spent"] = [];
  var_0._id_EBEA["angle_225_spent"] = [];
  var_0._id_EBEA["angle_255_spent"] = [];
  var_0._id_EBEA["angle_285_spent"] = [];
  var_0._id_EBEA["angle_315_spent"] = [];
  var_0._id_EBEA["angle_345_spent"] = [];
  var_0._id_EBEA["angle_lastanim_spent"] = [];
  var_0._id_22F2 = [];
  var_0._id_22F2["combat"] = "custom_casual_bridge_sit_console_arrival";
  var_0._id_22F2["casual"] = "custom_casual_bridge_sit_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["combat"] = "custom_casual_bridge_sit_console_exit";
  var_0._id_6980["casual"] = "custom_casual_bridge_sit_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  level._id_9A2E._id_4D94["registered_state_interactions"]["sitting_console_alert"] = [];
  level._id_9A2E._id_4D94["registered_state_interactions"]["sitting_console_alert"]["vo_lines_male"] = var_0._id_EBEA["vo_lines_male"];
  level._id_9A2E._id_4D94["registered_state_interactions"]["sitting_console_alert"]["vo_lines_female"] = var_0._id_EBEA["vo_lines_female"];
  var_0._id_EBEA["trigger_radius"] = 50;
  scripts\sp\interaction::_id_DED9("sitting_console_alert", var_0);
}

_id_9767() {
  _id_B19C();
  _id_B177();
}