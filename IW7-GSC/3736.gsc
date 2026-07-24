/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3736.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % sh3_11_eur_sh_br_ops_eng_waiting_idle;
  var_0._id_EBEA["trigger_radius"] = 0;
  var_0._id_22F2 = [];
  var_0._id_22F2["casual"] = "custom_casual_bridge_stand_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["casual"] = "custom_casual_bridge_stand_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("shipcrib_opsmap_mac_01", var_0);
}