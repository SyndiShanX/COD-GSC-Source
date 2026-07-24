/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3751.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = [%shipcrib_sit_idle_01, %shipcrib_sit_console_idle_02, %shipcrib_sit_console_idle_03, %shipcrib_sit_console_idle_04, %shipcrib_sit_console_idle_05, %shipcrib_sit_console_idle_06, %shipcrib_sit_console_idle_07, %shipcrib_sit_console_idle_08, %shipcrib_sit_console_idle_09, %shipcrib_sit_console_idle_10, %shipcrib_sit_console_idle_11, %shipcrib_sit_console_idle_12];
  var_0._id_EBEA["angles"] = [105, 135, 165, 195, 225, 255, 285];
  var_0._id_EBEA[105] = [%shipcrib_titan_br_comms_r90_01, 0.75, "titan_sc_un1_Signalacquisitionisnice"];
  var_0._id_EBEA[135] = [%shipcrib_titan_br_comms_r120_01, 0.75, "titan_sc_un1_Signalacquisitionisnice"];
  var_0._id_EBEA[165] = [%shipcrib_titan_br_comms_r150_01, 0.75, "titan_sc_un1_Signalacquisitionisnice"];
  var_0._id_EBEA[195] = [%shipcrib_titan_br_comms_l150_01, 0.75, "titan_sc_un1_Signalacquisitionisnice"];
  var_0._id_EBEA[225] = [%shipcrib_titan_br_comms_l150_01, 0.75, "titan_sc_un1_Signalacquisitionisnice"];
  var_0._id_EBEA[255] = [%shipcrib_titan_br_comms_l120_01, 0.75, "titan_sc_un1_Signalacquisitionisnice"];
  var_0._id_EBEA[285] = [%shipcrib_titan_br_comms_l90_01, 0.75, "titan_sc_un1_Signalacquisitionisnice"];
  var_0._id_EBEA["lastanim"] = [%shipcrib_titan_br_comms_l90_01, 0.75, "titan_sc_un1_Signalacquisitionisnice"];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("shipcrib_titan_br_comms_1", var_0);
}