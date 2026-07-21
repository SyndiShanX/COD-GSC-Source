/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_create_script.gsc
***********************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_8AD9191BC1AF8CDE37561D6EB5EB8DE42B168EB2BEB91BC9A51CE8")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_8AD9191BC1AF8CDE37561D6EB5EB8DE42B168EB2BEB91BC9A51CE8");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_8AD9191BC1AF8CDE37561D6EB5EB8DE42B168EB2BEB91BC9A51CE8");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_8AD9191BC1AF8CDE37561D6EB5EB8DE42B168EB2BEB91BC9A51CE8");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_8AD9191BC1AF8CDE37561D6EB5EB8DE42B168EB2BEB91BC9A51CE8");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_8AD9191BC1AF8CDE37561D6EB5EB8DE42B168EB2BEB91BC9A51CE8");
}

createstructs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-25093.2, 20680, 549.27), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A14C023B", "_encstr_A34C02BB", undefined, undefined, 512, 2000, undefined);
  var_3 = spawnStruct();
  var_3.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_3.script_function = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_3.script_team = "_encstr_8E8405EA382B2A";
  var_3.script_unload = "_encstr_A34C02BB";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-23808.2, 14665.6, 56), undefined, "_encstr_954D0FC6B02FD71A59365A7DE6C10B77DC", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_9118040156F7", "_encstr_A14C023B", undefined, undefined, 512, 2000, 40);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-23838, 14664, 952), undefined, undefined, undefined, undefined, undefined, "_encstr_A74C0222", undefined, undefined, undefined, undefined, undefined);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-24325.2, 20512, 549.27), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_AC4C024A", "_encstr_8F4C026A", undefined, undefined, 512, 2000, undefined);
  var_3 = spawnStruct();
  var_3.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_3.script_function = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_3.script_team = "_encstr_8E8405EA382B2A";
  var_3.script_unload = "_encstr_A34C02BB";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-24334.4, 16008.2, 56), (0, 270, 0), "_encstr_954D0FC6B02FD71A59365A7DE6C10B77DC", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AB1804DEA942", "_encstr_AC4C024A", undefined, undefined, 512, 2000, 40);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-24334, 16040, 952), undefined, undefined, undefined, undefined, undefined, "_encstr_B84C027E", undefined, undefined, undefined, undefined, undefined);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-20101.2, 20440, 549.27), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_8B4C0227", "_encstr_914C02DC", undefined, undefined, 512, 2000, undefined);
  var_3 = spawnStruct();
  var_3.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_3.script_function = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_3.script_team = "_encstr_8E8405EA382B2A";
  var_3.script_unload = "_encstr_A34C02BB";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-20454.4, 15856.2, 56), (0, 270, 0), "_encstr_954D0FC6B02FD71A59365A7DE6C10B77DC", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_991804EFC7D2", "_encstr_8B4C0227", undefined, undefined, 512, 2000, 40);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (-20454, 15888, 952), undefined, undefined, undefined, undefined, undefined, "_encstr_864C02F9", undefined, undefined, undefined, undefined, undefined);
  var_3 = spawnStruct();
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2, (0, 0, 0), undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}