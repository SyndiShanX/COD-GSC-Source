/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3750.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["no_gun"] = 1;
  var_0._id_EBEA["idle"] = % shipcrib_standing_console_idleb_01;
  var_0._id_EBEA["angles"] = [105, 135, 165, 195, 225, 255];
  var_0._id_EBEA[105] = [%shipcrib_titan_br_ab_r90_01, 0.75, "titan_sc_un4_Payloadshouldinthe"];
  var_0._id_EBEA[135] = [%shipcrib_titan_br_ab_r120_01, 0.75, "titan_sc_un4_Payloadshouldinthe"];
  var_0._id_EBEA[165] = [%shipcrib_titan_br_ab_r150_01, 0.75, "titan_sc_un4_Payloadshouldinthe"];
  var_0._id_EBEA[195] = [%shipcrib_titan_br_ab_l180_01, 0.75, "titan_sc_un4_Payloadshouldinthe"];
  var_0._id_EBEA[225] = [%shipcrib_titan_br_ab_l150_01, 0.75, "titan_sc_un4_Payloadshouldinthe"];
  var_0._id_EBEA[255] = [%shipcrib_titan_br_ab_l120_01, 0.75, "titan_sc_un4_Payloadshouldinthe"];
  var_0._id_EBEA["lastanim"] = [%shipcrib_titan_br_ab_l90_01, 0.75, "titan_sc_un4_Payloadshouldinthe"];
  var_0._id_EBEA["trigger_radius"] = 164;
  scripts\sp\interaction::register_interaction("shipcrib_titan_br_ab_1", var_0);
}