/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3707.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = undefined;
  var_0._id_EBEA["idle"] = [%sh_pri_7_17_rs_pu1_vig01_mr1_idle02, %sh_pri_7_17_rs_pu1_vig02_mr1_idle01, %sh_pri_7_17_rs_pu1_vig02_mr1_idle02, %sh_pri_7_17_rs_pu1_vig02_mr1_idle03];
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = [%sh_pri_7_17_rs_pu1_mr1_reaction_l00];
  var_0._id_EBEA[45] = [%sh_pri_7_17_rs_pu1_mr1_reaction_r30];
  var_0._id_EBEA[75] = [%sh_pri_7_17_rs_pu1_mr1_reaction_r60];
  var_0._id_EBEA[105] = [%sh_pri_7_17_rs_pu1_mr1_reaction_r90];
  var_0._id_EBEA[135] = [%sh_pri_7_17_rs_pu1_mr1_reaction_r120];
  var_0._id_EBEA[165] = [%sh_pri_7_17_rs_pu1_mr1_reaction_r150];
  var_0._id_EBEA[195] = [%sh_pri_7_17_rs_pu1_mr1_reaction_r180];
  var_0._id_EBEA[225] = [%sh_pri_7_17_rs_pu1_mr1_reaction_l150];
  var_0._id_EBEA[255] = [%sh_pri_7_17_rs_pu1_mr1_reaction_l120];
  var_0._id_EBEA[285] = [%sh_pri_7_17_rs_pu1_mr1_reaction_l90];
  var_0._id_EBEA[315] = [%sh_pri_7_17_rs_pu1_mr1_reaction_l60];
  var_0._id_EBEA[345] = [%sh_pri_7_17_rs_pu1_mr1_reaction_l30];
  var_0._id_EBEA["lastanim"] = [%sh_pri_7_17_rs_pu1_mr1_reaction_l00];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("sh_pri_brooks_reaction", var_0);
}