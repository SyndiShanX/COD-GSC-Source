/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\cp_dwn_twn_script_spawners.gsc
*************************************************************/

main() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(level.scripted_spawners))
    level.scripted_spawners = [];

  initflags();
  level thread createstructs();
  level thread createtriggers();
  level thread createmodels();
  thread waitforflags();
}

initflags() {
  scripts\engine\utility::flag_init("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_init("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");
  scripts\engine\utility::flag_init("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
  scripts\engine\utility::flag_init("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
  scripts\engine\utility::flag_init("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

waitforflags() {
  scripts\engine\utility::flag_wait("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
  scripts\engine\utility::flag_wait("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
  scripts\engine\utility::flag_wait("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
  scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
  scripts\engine\utility::flag_set("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");
}

createstructs() {
  scripts\engine\utility::flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers() {
  scripts\engine\utility::flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels() {
  scripts\engine\utility::flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}