/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3755.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % shipcrib_titan_armory_mco_pre_reaction_idle;
  var_0._id_EBEA["end_idle"] = % hm_grnd_yel_casual_idle_ar;
  var_0._id_EBEA["angles"] = [165, 195, 225];
  var_0._id_EBEA[165] = [%shipcrib_titan_armory_mco_reaction_r150, 0.0, "sc_titan_plr_whattimeisitsarge"];
  var_0._id_EBEA[195] = [%shipcrib_titan_armory_mco_reaction_l180, 0.0, "sc_titan_plr_whattimeisitsarge"];
  var_0._id_EBEA[225] = [%shipcrib_titan_armory_mco_reaction_l150, 0.0, "sc_titan_plr_whattimeisitsarge"];
  var_0._id_EBEA["lastanim"] = [%shipcrib_titan_armory_mco_reaction_l150, 0.0, "sc_titan_plr_whattimeisitsarge"];
  var_0._id_EBEA["trigger_radius"] = 128;
  scripts\sp\interaction::register_interaction("shipcrib_titan_mco_armory_exit", var_0);
}