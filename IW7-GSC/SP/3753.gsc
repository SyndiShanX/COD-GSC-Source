/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3753.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_1 = [%shipcrib_titan_br_salter_l00_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_2 = [%shipcrib_titan_br_salter_l00_02, 0.75, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_3 = [%shipcrib_titan_br_salter_r30_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_4 = [%shipcrib_titan_br_salter_l00_02, 1.25, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_5 = [%shipcrib_titan_br_salter_r60_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_6 = [%shipcrib_titan_br_salter_r90_02, 0.55, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_7 = [%shipcrib_titan_br_salter_r90_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_8 = [%shipcrib_titan_br_salter_r90_02, 0.45, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_9 = [%shipcrib_titan_br_salter_r120_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_10 = [%shipcrib_titan_br_salter_r90_02, 0.25, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_11 = [%shipcrib_titan_br_salter_r150_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_12 = [%shipcrib_titan_br_salter_l180_02, 0.25, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_13 = [%shipcrib_titan_br_salter_l180_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_14 = [%shipcrib_titan_br_salter_l180_02, 0.25, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_15 = [%shipcrib_titan_br_salter_l150_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_16 = [%shipcrib_titan_br_salter_l180_02, 0.25, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_17 = [%shipcrib_titan_br_salter_l120_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_18 = [%shipcrib_titan_br_salter_l90_02, 0.25, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_19 = [%shipcrib_titan_br_salter_l90_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_20 = [%shipcrib_titan_br_salter_l90_02, 0.85, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_21 = [%shipcrib_titan_br_salter_l60_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_22 = [%shipcrib_titan_br_salter_l90_02, 1.0, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_23 = [%shipcrib_titan_br_salter_l30_01, 0.75, "titan_sc_slt_Gotkindahairydown", 0.5, "titan_sc_plr_Wetookoutsome"];
  var_24 = [%shipcrib_titan_br_salter_l00_02, 1.25, "titan_sc_slt_YeahAlliedhardware", 0.25, "titan_sc_plr_Letshopeitwas"];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % sh4_2_1_sh_ttn_br_pre_xo_ops_idle;
  var_0._id_EBEA["angles"] = [15, 45, 75, 105, 135, 165, 195, 225, 255, 285, 315, 345];
  var_0._id_EBEA[15] = [[var_1, var_2]];
  var_0._id_EBEA[45] = [[var_3, var_4]];
  var_0._id_EBEA[75] = [[var_5, var_6]];
  var_0._id_EBEA[105] = [[var_7, var_8]];
  var_0._id_EBEA[135] = [[var_9, var_10]];
  var_0._id_EBEA[165] = [[var_11, var_12]];
  var_0._id_EBEA[195] = [[var_13, var_14]];
  var_0._id_EBEA[225] = [[var_15, var_16]];
  var_0._id_EBEA[255] = [[var_17, var_18]];
  var_0._id_EBEA[285] = [[var_19, var_20]];
  var_0._id_EBEA[315] = [[var_21, var_22]];
  var_0._id_EBEA[345] = [[var_23, var_24]];
  var_0._id_EBEA["lastanim"] = [[var_1, var_2]];
  var_0._id_EBEA["trigger_radius"] = 60;
  var_0._id_22F2 = [];
  var_0._id_22F2["casual"] = "custom_casual_bridge_stand_console_arrival";
  var_0._id_22F6 = 0;
  var_0._id_6980 = [];
  var_0._id_6980["casual"] = "custom_casual_bridge_stand_console_exit";
  var_0._id_92FA = "exposed_idle_casual";
  scripts\sp\interaction::register_interaction("shipcrib_titan_br_salt_1", var_0);
}