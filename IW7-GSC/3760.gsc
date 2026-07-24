/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3760.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_sit_idle_01, %shipcrib_sit_console_idle_02, %shipcrib_sit_console_idle_03, %shipcrib_sit_console_idle_04, %shipcrib_sit_console_idle_05, %shipcrib_sit_console_idle_06, %shipcrib_sit_console_idle_07, %shipcrib_sit_console_idle_08, %shipcrib_sit_console_idle_09, %shipcrib_sit_console_idle_10, %shipcrib_sit_console_idle_11, %shipcrib_sit_console_idle_12];
  var_0._id_EBEA["follow"] = % shipcrib_sit_a_follow_01;
  var_0._id_EBEA["ring"] = % follow_ring;
  var_0._id_EBEA["diff"] = % shipcrib_sit_diff_02;
  var_0._id_EBEA["additive"] = % follow_additive;
  var_0._id_EBEA["axis"] = % generic_talker_axis;
  var_0._id_EBEA["talking"] = % scripted_talking;
  var_0._id_EBEA["angles"] = [125, 145, 165, 235, 265];
  var_0._id_EBEA[125] = % shipcrib_sit_a_reaction_r00_01;
  var_0._id_EBEA[145] = % shipcrib_sit_a_reaction_r30_01;
  var_0._id_EBEA[165] = % shipcrib_sit_a_reaction_r60_01;
  var_0._id_EBEA[235] = % shipcrib_sit_a_reaction_l60_01;
  var_0._id_EBEA[265] = % shipcrib_sit_a_reaction_l30_01;
  var_0._id_EBEA["lastanim"] = % shipcrib_sit_a_reaction_l00_01;
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22F2 = [];
  var_0._id_22F2["combat"] = "custom_casual_bridge_sit_console_arrival";
  var_0._id_22F2["casual"] = "custom_casual_bridge_sit_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["combat"] = "custom_casual_bridge_sit_console_exit";
  var_0._id_6980["casual"] = "custom_casual_bridge_sit_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  scripts\sp\interaction::register_interaction("sit_a", var_0);
}