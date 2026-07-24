/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3705.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % sh4_2_2a_sh_ttn_br_brief_xo_screen_idle;
  var_0._id_EBEA["trigger_radius"] = 0;
  var_0._id_22F2 = [];
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("sh4_2_2a_sh_ttn_br_brief_xo_screen", var_0);
}