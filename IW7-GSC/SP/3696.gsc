/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3696.gsc
**************************************/

#using_animtree("generic_human");

_id_B246() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_ops_hero_xo_idle_01, %shipcrib_bridge_ops_hero_xo_idle_02, %shipcrib_bridge_ops_hero_xo_idle_03, %shipcrib_bridge_ops_hero_xo_idle_vig_01, %shipcrib_bridge_ops_hero_xo_idle_vig_03];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  _id_B224(var_0);
  scripts\sp\interaction::register_interaction("opsmap_salter_react", var_0);
}

#using_animtree("script_model");

_id_B224(var_0) {
  var_0._id_EBEA["idle_prop"] = [%shipcrib_bridge_ops_hero_xo_console_inactive, %shipcrib_bridge_ops_hero_xo_console_inactive, %shipcrib_bridge_ops_hero_xo_idle_03_console, %shipcrib_bridge_ops_hero_xo_console_inactive, %shipcrib_bridge_ops_hero_xo_console_inactive];
}

#using_animtree("generic_human");

_id_B182() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_ops_hero_xo_idle_alert_01, %shipcrib_bridge_ops_hero_xo_idle_alert_vig_01, %shipcrib_bridge_ops_hero_xo_idle_alert_vig_02];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  _id_B181(var_0);
  scripts\sp\interaction::register_interaction("opsmap_salter_react_alert", var_0);
}

#using_animtree("script_model");

_id_B181(var_0) {
  var_0._id_EBEA["idle_prop"] = [%shipcrib_bridge_ops_hero_xo_idle_alert_01_console, %shipcrib_bridge_ops_hero_xo_idle_alert_vig_01_console, %shipcrib_bridge_ops_hero_xo_console_inactive];
}

#using_animtree("generic_human");

_id_B193() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_standing_console_idle_01_fem, %shipcrib_standing_console_idle_01_fem];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("opsmap_boats_react", var_0);
}

_id_B178() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_console_stand_alert_reaction_idle, %shipcrib_console_stand_alert_reaction_vig_01, %shipcrib_console_stand_alert_reaction_vig_02, %shipcrib_console_stand_alert_reaction_vig_03];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("opsmap_boats_react_alert", var_0);
}

_id_B1B5() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_standing_console_idle_01_fem, %shipcrib_standing_console_idle_01_fem];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22F2 = [];
  var_0._id_22F2["casual"] = "custom_casual_bridge_stand_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["casual"] = "custom_casual_bridge_stand_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("opsmap_comms_react", var_0);
}

_id_B179() {
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
  scripts\sp\interaction::register_interaction("opsmap_comms_react_alert", var_0);
}

_id_B1BB() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_ops_hero_nav_conn_idle_01, %shipcrib_bridge_ops_hero_nav_conn_idle_vig_01];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  _id_B221(var_0);
  scripts\sp\interaction::register_interaction("opsmap_conn_react", var_0);
}

#using_animtree("script_model");

_id_B221(var_0) {
  var_0._id_EBEA["idle_prop"] = [%shipcrib_bridge_ops_hero_nav_conn_idle_01_console, %shipcrib_bridge_ops_hero_nav_console_inactive];
}

#using_animtree("generic_human");

_id_B17A() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_ops_hero_nav_conn_idle_alert_01, %shipcrib_bridge_ops_hero_nav_conn_idle_alert_vig_01, %shipcrib_bridge_ops_hero_nav_conn_idle_alert_vig_02, %shipcrib_bridge_ops_hero_nav_conn_idle_vig_01];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  _id_B17E(var_0);
  scripts\sp\interaction::register_interaction("opsmap_conn_react_alert", var_0);
}

#using_animtree("script_model");

_id_B17E(var_0) {
  var_0._id_EBEA["idle_prop"] = [%shipcrib_bridge_ops_hero_nav_conn_idle_alert_01_console, %shipcrib_bridge_ops_hero_nav_console_inactive, %shipcrib_bridge_ops_hero_nav_console_inactive, %shipcrib_bridge_ops_hero_nav_console_inactive];
}

#using_animtree("generic_human");

_id_B1C4() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_ops_hero_do_idle_01, %shipcrib_bridge_ops_hero_do_idle_vig_01, %shipcrib_bridge_ops_hero_do_idle_vig_02, %shipcrib_bridge_ops_hero_do_idle_vig_03];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  _id_B222(var_0);
  scripts\sp\interaction::register_interaction("opsmap_drops_react", var_0);
}

#using_animtree("script_model");

_id_B222(var_0) {
  var_0._id_EBEA["idle_prop"] = [%shipcrib_bridge_ops_hero_do_idle_01_console, %shipcrib_bridge_ops_hero_do_idle_vig_01_console, %shipcrib_bridge_ops_hero_do_idle_vig_02_console, %shipcrib_bridge_ops_hero_do_idle_vig_03_console];
}

#using_animtree("generic_human");

_id_B17B() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_ops_hero_do_idle_alert_01, %shipcrib_bridge_ops_hero_do_idle_alert_vig_01, %shipcrib_bridge_ops_hero_do_idle_alert_vig_02];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  _id_B17F(var_0);
  scripts\sp\interaction::register_interaction("opsmap_drops_react_alert", var_0);
}

#using_animtree("script_model");

_id_B17F(var_0) {
  var_0._id_EBEA["idle_prop"] = [%shipcrib_bridge_ops_hero_do_idle_alert_01_console, %shipcrib_bridge_ops_hero_do_console_inactive, %shipcrib_bridge_ops_hero_do_console_inactive];
}

#using_animtree("generic_human");

_id_B212() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_ops_hero_nav_idle_01, %shipcrib_bridge_ops_hero_nav_idle_02, %shipcrib_bridge_ops_hero_nav_idle_03, %shipcrib_bridge_ops_hero_nav_idle_vig_01, %shipcrib_bridge_ops_hero_nav_idle_vig_02, %shipcrib_bridge_ops_hero_nav_idle_vig_03];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  _id_B223(var_0);
  scripts\sp\interaction::register_interaction("opsmap_gator_react", var_0);
}

#using_animtree("script_model");

_id_B223(var_0) {
  var_0._id_EBEA["idle_prop"] = [%shipcrib_bridge_ops_hero_nav_idle_01_console, %shipcrib_bridge_ops_hero_nav_idle_02_console, %shipcrib_bridge_ops_hero_nav_idle_03_console, %shipcrib_bridge_ops_hero_nav_idle_vig_01_console, %shipcrib_bridge_ops_hero_nav_idle_vig_02_console, %shipcrib_bridge_ops_hero_nav_idle_vig_03_console];
}

#using_animtree("generic_human");

_id_B17C() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_bridge_ops_hero_nav_idle_alert_01, %shipcrib_bridge_ops_hero_nav_idle_alert_vig_01, %shipcrib_bridge_ops_hero_nav_idle_alert_vig_02];
  var_0._id_EBEA["trigger_radius"] = 100;
  var_0._id_22E1 = "noclip";
  _id_B180(var_0);
  scripts\sp\interaction::register_interaction("opsmap_gator_react_alert", var_0);
}

#using_animtree("script_model");

_id_B180(var_0) {
  var_0._id_EBEA["idle_prop"] = [%shipcrib_bridge_ops_hero_nav_idle_alert_01_console, %shipcrib_bridge_ops_hero_nav_idle_alert_vig_01_console, %shipcrib_bridge_ops_hero_nav_idle_alert_vig_02_console];
}