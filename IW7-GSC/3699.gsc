/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3699.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % rogue_outpost_mco_civ_depot_reaction;
  var_0._id_EBEA["angles"] = [0, 30, 60, 90, 120, 150];
  var_0._id_EBEA[0] = % rogue_outpost_mco_civ_depot_rs_l00;
  var_0._id_EBEA[30] = % rogue_outpost_mco_civ_depot_rs_r30;
  var_0._id_EBEA[60] = % rogue_outpost_mco_civ_depot_rs_r60;
  var_0._id_EBEA[90] = % rogue_outpost_mco_civ_depot_rs_r90;
  var_0._id_EBEA[120] = % rogue_outpost_mco_civ_depot_rs_r120;
  var_0._id_EBEA[150] = % rogue_outpost_mco_civ_depot_rs_r150;
  var_0._id_EBEA["lastanim"] = % rogue_outpost_mco_civ_depot_rs_r180;
  var_0._id_EBEA["trigger_radius"] = 0;
  scripts\sp\interaction::register_interaction("rogue_civoutpost_omar_reaction", var_0);
}