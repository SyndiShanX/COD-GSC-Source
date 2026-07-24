/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3666.gsc
**************************************/

#using_animtree("generic_human");

main() {
  var_0 = spawnStruct();
  var_0._id_EBEA = [];
  var_0._id_EBEA["angles"] = [45, 75, 105, 135, 165, 195, 225, 255, 285, 315];
  var_0._id_EBEA[45] = % titan_bunker_mco_answer_pcap_r30;
  var_0._id_EBEA[75] = % titan_bunker_mco_answer_pcap_r60;
  var_0._id_EBEA[105] = % titan_bunker_mco_answer_pcap_r90;
  var_0._id_EBEA[135] = % titan_bunker_mco_answer_pcap_r120;
  var_0._id_EBEA[165] = % titan_bunker_mco_answer_pcap_r150;
  var_0._id_EBEA[195] = % titan_bunker_mco_answer_pcap_r180;
  var_0._id_EBEA[225] = % titan_bunker_mco_answer_pcap_l150;
  var_0._id_EBEA[255] = % titan_bunker_mco_answer_pcap_l120;
  var_0._id_EBEA[285] = % titan_bunker_mco_answer_pcap_l90;
  var_0._id_EBEA[315] = % titan_bunker_mco_answer_pcap_l60;
  var_0._id_EBEA["lastanim"] = % titan_bunker_mco_answer_pcap_l00;
  var_0._id_EBEA["trigger_radius"] = 2000;
  scripts\sp\interaction::register_interaction("bunker_omar_react", var_0);
}