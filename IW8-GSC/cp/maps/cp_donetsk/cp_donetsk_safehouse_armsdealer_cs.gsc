/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_safehouse_armsdealer_cs.gsc
*********************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_B6EB2392AB083B75C073B4BB07213A77CCA19ADA93F6F7A18045D5A32128468BE53B6182BB");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18360.7, 1475.66, -137.77), (0, 180, 0), "_encstr_851D1BA1BDB94F08B5EA488A537F30FF483D80584BE74088E78547BA84", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18410, 1542.62, -138.89), (0, 180, 0), "_encstr_851D1BA1BDB94F08B5EA488A537F30FF483D80584BE74088E78547BA84", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18325.6, 1527.95, -139.84), (0, 180, 0), "_encstr_851D1BA1BDB94F08B5EA488A537F30FF483D80584BE74088E78547BA84", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-19013.2, 2356.2, -299), undefined, undefined, undefined, "_encstr_A616153B8AAD68DD7FF25079EBBF0E28C6E75DCF015388", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18821.9, 2332.02, -319), undefined, undefined, undefined, "_encstr_A616153B8AAD68DD7FF25079EBBF0E28C6E75DCF015388", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18135.5, 1263.09, -104.43), (0, 124.73, 0), "_encstr_887F1D1693B5CD192B16C6569C7D372C669534BD57CDCA7DB1B7C246F6BAA3", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18888.7, 8375.32, -256), (0, 180, 0), "_encstr_B23B22722BD1A77758BBECED75617A378C615A1A53B6B7E1D8AB0CE54DB009372D197333", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18888.6, 8312.23, -256), (0, 180, 0), "_encstr_B23B22722BD1A77758BBECED75617A378C615A1A53B6B7E1D8AB0CE54DB009372D197333", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18823.6, 8375.35, -256), (0, 180, 0), "_encstr_B23B22722BD1A77758BBECED75617A378C615A1A53B6B7E1D8AB0CE54DB009372D197333", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18906.5, 8405.77, -223.51), (0, 270, 0), "_encstr_B6EC24B2EB1167B7987BACAD35213A77CCA19ADA93F6F7A1186BCCA50D70C98BE059D2427BCD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18824.5, 8311.87, -256), (0, 180, 0), "_encstr_B23B22722BD1A77758BBECED75617A378C615A1A53B6B7E1D8AB0CE54DB009372D197333", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-19045.6, 8319.36, -222.48), (0, 330, 0), "_encstr_AD66275827B69BC82B1663AC9CF5E456D1AEC9CDEBDCD21B59E6D856C9AFD2E63A959316D81DA5B7B9", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18355, 1611.21, -139.26), (0, 180, 0), "_encstr_851D1BA1BDB94F08B5EA488A537F30FF483D80584BE74088E78547BA84", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.angles = (0, 0, 0);
  var_3.model = "_encstr_A6481141B554C90F2A8383B52752DB70D79A83";
  var_3.origin = (-18455.8, 1483.51, -116.91);
  var_3.targetname = "_encstr_A7531AADF4C328034A7B77374F225DE07CC1097B1D2B48CD821B0B3D";
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 0, 0);
  var_3.model = "_encstr_BAD323B12A6F78A857AE137FD57188383FC28E191297AC2021900B51FDE2997497CA61618B";
  var_3.origin = (-18455.6, 1486.89, -117.53);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 0, 0);
  var_3.model = "_encstr_A6481141B554C90F2A8383B52752DB70D79A83";
  var_3.origin = (-18935.8, 8224.71, -222.08);
  var_3.targetname = "_encstr_A234216B17830EF0AF5D26BB8784D84E4B67EBDDFF6B5DA8F9B5699321622B7D334B7D";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 0, 0);
  var_3.model = "_encstr_BAD323B12A6F78A857AE137FD57188383FC28E191297AC2021900B51FDE2997497CA61618B";
  var_3.origin = (-18935.6, 8228.1, -222.71);
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}