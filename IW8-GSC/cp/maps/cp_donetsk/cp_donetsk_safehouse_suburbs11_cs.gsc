/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_safehouse_suburbs11_cs.gsc
********************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_ABD222387F4924AFA80B43FA048F430FE530209A3B075FB6780340079EEEC6A14BA161B2")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_ABD222387F4924AFA80B43FA048F430FE530209A3B075FB6780340079EEEC6A14BA161B2");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_ABD222387F4924AFA80B43FA048F430FE530209A3B075FB6780340079EEEC6A14BA161B2");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_ABD222387F4924AFA80B43FA048F430FE530209A3B075FB6780340079EEEC6A14BA161B2");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_ABD222387F4924AFA80B43FA048F430FE530209A3B075FB6780340079EEEC6A14BA161B2");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_ABD222387F4924AFA80B43FA048F430FE530209A3B075FB6780340079EEEC6A14BA161B2");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3863.61, 33462.9, 222.5), (0, 330, 0), "_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3814.44, 33436.3, 222.5), (0, 330, 0), "_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3834.17, 33513.1, 222.46), (0, 330, 0), "_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3783.77, 33488.3, 222), (0, 330, 0), "_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3685.42, 33355.2, 222), (0, 150, 0), "_encstr_A2FC1ADBC1DC67EC80EB7B75A7B862FEE85BA262AA256362702B726C", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1357.5, 28893, -168.67), (0, 163.79, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1888.5, 27905, 21.49), (0, 325.93, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8805.25, 33836, 21.35), (0, 114.89, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4960.5, 28613, 204.11), (0, 130.93, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5578.25, 31154.3, 412.11), (0, 333.76, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (8296.5, 31169, 1536.22), (0, 85.92, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6988.5, 26789, 521.25), (0, 25.92, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5011, 25976.5, 4.69), (0, 319.28, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6143.75, 24405.5, -9.5), (0, 319.28, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3664, 33426, 251), (0, 60, 0), "_encstr_8EDE1CB9DAAEECECB1AC39FA9B1699B20DEDAE372BC4D736B72CC8B7EAE8", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2352.5, 31737, 238.01), (0, 341.92, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4927.5, 30899.3, 392.2), (0, 291.79, 0), "_encstr_A5BB1812093FE74FD2CDDA1E39734E4A402B071881DF78FFDCB5", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2509.5, 29937, -97.78), (0, 343.79, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3544.5, 34025, 206.71), (0, 219.79, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3484.5, 33989, 206.71), (0, 223.79, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3436.5, 33929, 206.71), (0, 229.79, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3364.5, 33869, 206.71), (0, 249.79, 0), "_encstr_856813EBB0330F4F4075B2E71F2B435967F0722330", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}