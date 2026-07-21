/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_smuggler\cp_smuggler_safehouse_createscript.gsc
**********************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_854823D883EBCD5B573BEC362BC9AF9B85CC59A1DE57DC95FAD8E4AC588E95E6369C960E1D");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22523.5, 29032, 1217.38), (0, 90, 0), "_encstr_8F83222EDA9B01B75C9993AFA3F74B7DB827535351175A2F8328F792D7B36163F868737E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22472, 29032, 1217.38), (0, 90, 0), "_encstr_8F83222EDA9B01B75C9993AFA3F74B7DB827535351175A2F8328F792D7B36163F868737E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22482, 29096, 1217.38), (0, 90, 0), "_encstr_8F83222EDA9B01B75C9993AFA3F74B7DB827535351175A2F8328F792D7B36163F868737E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22526, 29096, 1217.38), (0, 90, 0), "_encstr_8F83222EDA9B01B75C9993AFA3F74B7DB827535351175A2F8328F792D7B36163F868737E", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22463, 29257, 1264.25), (0, 270, 0), "_encstr_A2B9216EADAB9DD9C62BC9FAB9C233B2A1DBABE6B2F564D79359D993BDAB1CFA0EB7E6", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (22466, 29131, 1134.38), (0, 270, 0), "_encstr_825922CD6BD59D3B1B9593AF9B2C662B437BAB37B2BEC8EB56232D1DD736DBB091BD57A3", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 90, 0);
  var_3.origin = (22432.8, 29376.2, 1217.38);
  var_3.targetname = "_encstr_992D1A97C723C440ECDFC37E42C9800D4A67031F9FE936B934B56813";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 345, 0);
  var_3.origin = (22408.8, 29397.5, 1217.38);
  var_3.targetname = "_encstr_992D1A97C723C440ECDFC37E42C9800D4A67031F9FE936B934B56813";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 90, 0);
  var_3.origin = (22443.3, 29346.3, 1217.38);
  var_3.targetname = "_encstr_992D1A97C723C440ECDFC37E42C9800D4A67031F9FE936B934B56813";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 135, 0);
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_3.origin = (22427, 29313, 1217.38);
  var_3.targetname = "_encstr_992D1A97C723C440ECDFC37E42C9800D4A67031F9FE936B934B56813";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}