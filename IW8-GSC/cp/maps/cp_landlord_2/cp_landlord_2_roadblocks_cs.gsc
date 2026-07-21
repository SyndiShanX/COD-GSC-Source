/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_landlord_2\cp_landlord_2_roadblocks_cs.gsc
*****************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_8C941C2E826941B9FE1BE07BBB0CB635B1AA90A71FD23920DB0F1089D733")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_8C941C2E826941B9FE1BE07BBB0CB635B1AA90A71FD23920DB0F1089D733");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_8C941C2E826941B9FE1BE07BBB0CB635B1AA90A71FD23920DB0F1089D733");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_8C941C2E826941B9FE1BE07BBB0CB635B1AA90A71FD23920DB0F1089D733");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_8C941C2E826941B9FE1BE07BBB0CB635B1AA90A71FD23920DB0F1089D733");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_8C941C2E826941B9FE1BE07BBB0CB635B1AA90A71FD23920DB0F1089D733");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (355.01, 357.04, 0.17);
  var_3.origin = (-322.15, 59076.8, 553.09);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (360, 17.87, 0);
  var_3.origin = (-1893.68, 55028.3, 934.02);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (359.99, 7.07, 0);
  var_3.origin = (-1900.68, 54907.3, 934.01);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0.5, 40.37, 0.11);
  var_3.origin = (19443.3, 49645.8, 794.16);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0.01, 52.17, 0.14);
  var_3.origin = (19550.3, 49575.8, 793.75);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (10.69, 8.29, 0.89);
  var_3.origin = (-1916.66, 49238.6, 1581.24);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.angles = (0.83, 21.97, 0.07);
  var_3.origin = (-1761.68, 55411.3, 933.26);
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0.83, 17.87, 0.01);
  var_3.origin = (-1711.68, 55359.3, 933.26);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (355.03, 346.15, 1.12);
  var_3.origin = (-371.68, 58966.3, 548.91);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (359.53, 61.74, 0.14);
  var_3.origin = (20738.4, 43013.5, 919.34);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (9.42, 354.09, -2.23);
  var_3.origin = (-1874.66, 49180.6, 1574.63);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (359.33, 82.47, 0.24);
  var_3.origin = (21108.4, 42909.4, 918.39);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (359.38, 78.37, 0.29);
  var_3.origin = (21234.3, 42919.3, 918.42);
  var_3.model = "_encstr_B4792D7EF66D8B975733A1AB7BF178BB03B0CED6E02016A26F4D0FA1A219D8FE4CD6F29B5F4AEF025D43F53B21C217";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}