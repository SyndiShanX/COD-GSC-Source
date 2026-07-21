/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\map_downtown_patrol_path.gsc
***********************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = spawnStruct();
  scripts\engine\utility::flag_init("_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1");
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_86F1195BC207F519F6DDDCE8EDEEDCBE382C3AE4F61B7D070B3AA1");
}

createstructs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (17424, -21871.8, -164), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_8F180499B7C3", "_encstr_A74C0222");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (19880, -19231.8, -112.01), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_96180416064F", "_encstr_A14C023B");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22528, -22103.9, -113.33), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_A91804A7E0F2", "_encstr_AC4C024A");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (17600, -16903.8, -176), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_A3CF05EE3A1B72", "_encstr_8F4C026A");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (17544.1, -12319.8, -265.9), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_A118046C019B", "_encstr_B84C027E");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (20135.9, -24695.8, -235.86), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_96180416064F", "_encstr_A34C02BB");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (20688.1, -9383.86, -354.17), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_AF1804F66103", "_encstr_914C02DC");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (21032.1, -12647.8, -208), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_9B18049711A2", "_encstr_864C02F9");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22768.1, -12727.9, -208), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_AF3D050B78A9B2", "_encstr_8B4C0227");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22776, -16359.9, -208), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_8535059AD2616B", "_encstr_AF0703133A");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (21344, -17711.9, -169.91), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_8E7606FA777E1B3B", "_encstr_9A07034C89");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (19952, -19119.8, -112.03), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_92F005C4C440C6", "_encstr_8C0703491D");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (26320, -16575.9, -210), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_825506C4A180C4A9", "_encstr_A90703297F");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (26272, -18559.9, -223.02), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_AB8F065723578EC3", "_encstr_8607036335");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22808, -22007.9, -114.8), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_825E0633479297B2", "_encstr_A5070398D8");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (20040, -19207.8, -112), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_87650698C6028968", "_encstr_8D070326DC");
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (22856, -16375.9, -208), (0, 270, 0), "_encstr_A23C1745AB92CFE31FDBA1D0CF347BF7DAD946D5429B7F2BE3", undefined, undefined, "_encstr_998F067AC7FE9B1B", "_encstr_8B070326D0");
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}