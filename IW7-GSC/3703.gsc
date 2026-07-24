/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3703.gsc
**************************************/

#using_animtree("generic_human");

_id_DB53() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % rogue_dorm_mr1_idle;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315];
  var_0._id_EBEA[15] = % rogue_hub_crew_qtrs_l00;
  var_0._id_EBEA[45] = % rogue_hub_crew_qtrs_r30;
  var_0._id_EBEA[75] = % rogue_hub_crew_qtrs_r60;
  var_0._id_EBEA[105] = % rogue_hub_crew_qtrs_r90;
  var_0._id_EBEA[135] = % rogue_hub_crew_qtrs_r120;
  var_0._id_EBEA[165] = % rogue_hub_crew_qtrs_r150;
  var_0._id_EBEA[195] = % rogue_hub_crew_qtrs_l180;
  var_0._id_EBEA[225] = % rogue_hub_crew_qtrs_l150;
  var_0._id_EBEA[255] = % rogue_hub_crew_qtrs_l120;
  var_0._id_EBEA[285] = % rogue_hub_crew_qtrs_l90;
  var_0._id_EBEA[315] = % rogue_hub_crew_qtrs_l60;
  var_0._id_EBEA["lastanim"] = % rogue_hub_crew_qtrs_l30;
  var_0._id_EBEA["trigger_radius"] = 200;
  var_0._id_EBEA["initial_reaction_blendtime"] = 0.4;
  var_0._id_EBEA["lookat_follow_blendtime"] = 0.4;
  var_0._id_EBEA["lookat_end_blendtime"] = 0.4;
  scripts\sp\interaction::register_interaction("rogue_quarters_react_01", var_0);
}

_id_DB54() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["idle"] = % rogue_dorm_mr1_idle;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315];
  var_0._id_EBEA[15] = % rogue_hub_creep_out_l00;
  var_0._id_EBEA[45] = % rogue_hub_creep_out_r30;
  var_0._id_EBEA[75] = % rogue_hub_creep_out_r60;
  var_0._id_EBEA[105] = % rogue_hub_creep_out_r90;
  var_0._id_EBEA[135] = % rogue_hub_creep_out_r120;
  var_0._id_EBEA[165] = % rogue_hub_creep_out_r150;
  var_0._id_EBEA[195] = % rogue_hub_creep_out_l180;
  var_0._id_EBEA[225] = % rogue_hub_creep_out_l150;
  var_0._id_EBEA[255] = % rogue_hub_creep_out_l120;
  var_0._id_EBEA[285] = % rogue_hub_creep_out_l90;
  var_0._id_EBEA[315] = % rogue_hub_creep_out_l60;
  var_0._id_EBEA["lastanim"] = % rogue_hub_creep_out_l30;
  var_0._id_EBEA["trigger_radius"] = 200;
  var_0._id_EBEA["initial_reaction_blendtime"] = 0.4;
  var_0._id_EBEA["lookat_follow_blendtime"] = 0.4;
  var_0._id_EBEA["lookat_end_blendtime"] = 0.4;
  scripts\sp\interaction::register_interaction("rogue_quarters_react_02", var_0);
}