/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3801.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_standing_console_idle_01, %shipcrib_standing_console_idle_06, %shipcrib_standing_console_idle_08];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22F2 = [];
  var_0._id_22F2["casual"] = "custom_casual_bridge_stand_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["casual"] = "custom_casual_bridge_stand_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("standing_console_simple", var_0);
}

_id_B177() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_console_stand_alert_reaction_idle, %shipcrib_console_stand_alert_reaction_vig_01, %shipcrib_console_stand_alert_reaction_vig_02, %shipcrib_console_stand_alert_reaction_vig_03];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22F2 = [];
  var_0._id_22F2["casual"] = "custom_casual_bridge_stand_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["casual"] = "custom_casual_bridge_stand_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("standing_console_simple_alert", var_0);
}