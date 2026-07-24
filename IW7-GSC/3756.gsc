/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3756.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = [%titan_dropship_ally03_idle, %titan_dropship_mco_vig_1, %titan_dropship_mco_vig_2];
  var_0._id_EBEA["angles"] = [15, 45, 75];
  var_0._id_EBEA[15] = % titan_dropship_mco_reaction_l00;
  var_0._id_EBEA[45] = % titan_dropship_mco_reaction_r30;
  var_0._id_EBEA[75] = % titan_dropship_mco_reaction_r60;
  var_0._id_EBEA["lastanim"] = % titan_dropship_mco_reaction_l30;
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("shipcrib_titan_mco_dropship_react", var_0);
}