/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3713.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_standing_console_idle_01, %shipcrib_standing_console_idle_02, %shipcrib_standing_console_idle_04, %shipcrib_standing_console_idle_05, %shipcrib_standing_console_idle_06, %shipcrib_standing_console_idle_07, %shipcrib_standing_console_idle_08, %shipcrib_standing_console_idle_09, %shipcrib_standing_console_idle_10, %shipcrib_standing_console_idle_11, %shipcrib_standing_console_idle_12];
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = [%shipcrib_standing_console_l00_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[45] = [%shipcrib_standing_console_r30_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[75] = [%shipcrib_standing_console_r60_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[105] = [%shipcrib_standing_console_r90_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[135] = [%shipcrib_standing_console_r120_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[165] = [%shipcrib_standing_console_r150_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[195] = [%shipcrib_standing_console_l180_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[225] = [%shipcrib_standing_console_l150_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[255] = [%shipcrib_standing_console_l120_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[285] = [%shipcrib_standing_console_l90_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[315] = [%shipcrib_standing_console_l60_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA[345] = [%shipcrib_standing_console_l30_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA["lastanim"] = [%shipcrib_standing_console_l00_01, 0.0, "sc_titan_un4_captainlieutena"];
  var_0._id_EBEA["trigger_radius"] = 256;
  var_0._id_22F2 = [];
  var_0._id_22F2["casual"] = "custom_casual_bridge_stand_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["casual"] = "custom_casual_bridge_stand_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("shipcrib_bridgehall_news", var_0);
}