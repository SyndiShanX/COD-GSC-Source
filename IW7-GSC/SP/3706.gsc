/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3706.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_idle;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_l00;
  var_0._id_EBEA[45] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_r30;
  var_0._id_EBEA[75] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_r60;
  var_0._id_EBEA[105] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_r90;
  var_0._id_EBEA[135] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_r120;
  var_0._id_EBEA[165] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_r150;
  var_0._id_EBEA[195] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_l180;
  var_0._id_EBEA[225] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_l150;
  var_0._id_EBEA[255] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_l120;
  var_0._id_EBEA[285] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_l90;
  var_0._id_EBEA[315] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_l60;
  var_0._id_EBEA[345] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_l30;
  var_0._id_EBEA["lastanim"] = % sh4_2_2b_sh_ttn_br_brief_rs_xo_l00;
  var_0._id_EBEA["trigger_radius"] = 0;
  var_0._id_22F2 = [];
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_92FA = "exposed_idle_casual";
  var_0._id_22E1 = "noclip";
  scripts\sp\interaction::register_interaction("sh4_2_2b_sh_ttn_br_brief_rs_xo", var_0);
}