/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_safehouse_landlord_cs.gsc
*******************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_A70B21DF68C130B8B352739B5A9F6EC027D5714FF5B270E8830AC8611207A6A0B12BCF");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16358.6, -4457.42, 1616), undefined, "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", undefined, "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16359.8, -4325.35, 1616), (0, 360, 0), "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", undefined, "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16437.3, -4270.75, 1616), (0, 360, 0), "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", undefined, "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16440.3, -4418.11, 1616), undefined, "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", undefined, "_encstr_B615206906BA91D83F8360C1FF49D1DB822D5D6E9F41418D198760A067736B0B8B93", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16455.8, -3052.46, -476), (0, 134.46, 0), undefined, undefined, "_encstr_BA94131B16DC238DB74E19F5B0A33BAFE68385BBDC", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16736, -3317.91, -496), (0, 133.98, 0), undefined, undefined, "_encstr_BA94131B16DC238DB74E19F5B0A33BAFE68385BBDC", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16426.8, -4557.43, -1197.65), undefined, "_encstr_AF5722D96165D8C14FCB6936E34F8C98BCF7639F0D8120989F42ED7BFBDF3628165EDF3B", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19480, 3392, -479.44), (0, 45, 0), "_encstr_97B72813A868CC6A6F8EA711761B8295F070CFE710A6122247A66D93DFBF1B5479B8077B299B6C2A85BD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19448, 3408, -480.9), (0, 45, 0), "_encstr_97B72813A868CC6A6F8EA711761B8295F070CFE710A6122247A66D93DFBF1B5479B8077B299B6C2A85BD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19512, 3352, -480.63), (0, 45, 0), "_encstr_97B72813A868CC6A6F8EA711761B8295F070CFE710A6122247A66D93DFBF1B5479B8077B299B6C2A85BD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19552, 3320, -479.76), (0, 45, 0), "_encstr_97B72813A868CC6A6F8EA711761B8295F070CFE710A6122247A66D93DFBF1B5479B8077B299B6C2A85BD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (15663.7, -460.3, -504), (0, 314.46, 0), undefined, undefined, "_encstr_BA94131B16DC238DB74E19F5B0A33BAFE68385BBDC", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16304, -4232, 1652), undefined, "_encstr_99B41B54FB4827F3F00312A90BDFE3DFD07FC5B31B19EDB7AFB9BA33F3", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (15535.6, -583.28, -504), (0, 314.46, 0), undefined, undefined, "_encstr_BA94131B16DC238DB74E19F5B0A33BAFE68385BBDC", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_82070322E1";
  var_4.script_decel = "_encstr_82070322E1";
  var_0[[var_3]](var_4, var_1, var_2, (47150.4, 23041.7, 845.5), (0, 249, 0), "_encstr_A19118D486FB373377A95A93C84326FB93FF2E53AD81BBBE39F8", "_encstr_BD6709AF55F3C84F62A79A", undefined, undefined, undefined, undefined, undefined, undefined, 90, 1);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_delete = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (28911.4, -18908.9, 1619), (0, 314.99, 0), "_encstr_8E6709EF90FBAFA60FD220", undefined, undefined, undefined, undefined, undefined, undefined, 200, 100, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (41594.2, 11046.8, 943), (0, 238, 0), "_encstr_826709611DDC28EB5233FB", "_encstr_BD6709AF55F3C84F6247A2", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (39941.1, 8584.2, 921), (0, 237, 0), "_encstr_BD6709AF55F3C84F6247A2", "_encstr_BD6709AF55F3C84F62B7AA", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (36867.5, 4526.2, 641), (0, 233, 0), "_encstr_BD6709AF55F3C84F62B7AA", "_encstr_BE670997358458B2ED30EA", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_AA07038618";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (20925, -4841.2, 498), (0, 173.99, 0), "_encstr_876709B0D53ADB9989E0A9", "_encstr_AC6709604B93B7FA45C3C3", undefined, undefined, undefined, undefined, undefined, 400, 50, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (44889.3, 18339.6, 769), (0, 236, 0), "_encstr_BD6709AF55F3C84F62A79A", "_encstr_8E6709EF90FBAFA60FDA2E", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_unload = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (16745.3, -3054.23, -492), (0, 142, 0), "_encstr_876709B0D53ADB9989E4A9", "_encstr_966709F18394987ECF329D", undefined, undefined, undefined, undefined, undefined, 200, 20, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (16451.5, -2748.47, 189.5), (0, 130.99, 0), "_encstr_966709F18394987ECF329D", "_encstr_856709CA70310D1E8BDFF4", undefined, undefined, undefined, undefined, undefined, 200, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (17895.6, -4286.8, 39), (0, 130.99, 0), "_encstr_936709B0BAA3B7994C0EE0", "_encstr_876709B0D53ADB9989E4A9", undefined, undefined, undefined, undefined, undefined, 150, 20, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_0[[var_3]](var_4, var_1, var_2, (15175.3, -2862.26, 895), (0, 179.99, 0), "_encstr_856709CA70310D1E8BDFF4", "_encstr_976709EF15B3880FE277CA", undefined, undefined, undefined, undefined, undefined, 200, 100, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_0[[var_3]](var_4, var_1, var_2, (15893.2, -7581.9, 1739), (0, 304.99, 0), "_encstr_976709EF15B3880FE277CA", "_encstr_8E6709EF90FBAFA60FD220", undefined, undefined, undefined, undefined, undefined, 200, 100, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.modelscale = "_encstr_A7F709811772E406E6274E";
  var_4.name = "_encstr_BDBB0616C6C186C2";
  var_4.script_team = "_encstr_9A8507BA4040188D08";
  var_0[[var_3]](var_4, var_1, var_2, (16690.1, -2996.62, -492), (0, 135, 0), "_encstr_B606099A8BB9EC5A283379", "_encstr_AD670958573A7B669103B9", "_encstr_91540D2DDC33D263FA36132785B3DE", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16747.2, -3054.26, -492), (0, 135, 0), "_encstr_AD670958573A7B669103B9", "_encstr_A19118D486FB373377A95A93C84326FB93FF2E53AD81BBBE39F8", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (34252.6, -70.9, 429), (0, 221.85, 0), "_encstr_BE670997358458B2ED30EA", "_encstr_BD6709AF55F3C84FA227AA", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (24824.9, -3562.8, 541), (0, 163.38, 0), "_encstr_BE670997358458B2ED31EB", "_encstr_876709B0D53ADB9989E0A9", undefined, undefined, undefined, undefined, undefined, 500, 55, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (27547.3, -3400.9, 425), (0, 157.26, 0), "_encstr_BD6709AF55F3C84FA227AA", "_encstr_BE670997358458B2ED31EB", undefined, undefined, undefined, undefined, undefined, 400, 70, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_AA07038618";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (19854.4, -5119.3, 482), (0, 154.99, 0), "_encstr_AC6709604B93B7FA45C3C3", "_encstr_936709B0BAA3B7994C0EE0", undefined, undefined, undefined, undefined, undefined, 150, 40, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.ishelistruct = 1;
  var_4.lookahead = "_encstr_A34C02BB";
  var_4.script_accel = "_encstr_990703B2F9";
  var_4.script_decel = "_encstr_990703B2F9";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (43228.7, 14685, 841), (0, 248, 0), "_encstr_8E6709EF90FBAFA60FDA2E", "_encstr_826709611DDC28EB5233FB", undefined, undefined, undefined, undefined, undefined, 400, 90, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (23495.5, 8243.25, -424.56), (0, 15, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (26900.5, 9325, -415), (0, 2.16, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (23159.5, 8123.25, -424.82), (0, 15, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19461.5, 7521.25, -424.82), (0, 341, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (19171.5, 7633.25, -424.82), (0, 323, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (18372, 6443, -209), (0, 341, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (18314.5, 6313, -204.5), (0, 321.87, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (17786.3, 9212.59, -357.99), (0, 5.5, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (17476, 9194.25, -307.81), (0, 347.5, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (31029.5, 6043.25, -635.85), (0, 137, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (33969.5, 2251.25, -766.89), (0, 133, 0), "_encstr_82171CEDCEAC39DDB01D6C347D161DCED79BC185EEDCB239F5CA58E43697", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16590.5, -4424.04, -1232), undefined, undefined, undefined, "_encstr_A29E13C60BE6191BF62732F5DC58992BA1B7ABDC2B", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 134, 0);
  var_3.origin = (15990.5, -4093.55, 408);
  var_3.targetname = "_encstr_B40818256BE3451487F58CC8C7B1FE8550920B90BD97F96825BB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 90, 0);
  var_3.origin = (15986.5, -4068.3, 408);
  var_3.targetname = "_encstr_B40818256BE3451487F58CC8C7B1FE8550920B90BD97F96825BB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 38, 0);
  var_3.origin = (15992.5, -4121.5, 429.5);
  var_3.targetname = "_encstr_B40818256BE3451487F58CC8C7B1FE8550920B90BD97F96825BB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 86, 0);
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_3.origin = (15988.2, -4149.78, 429.5);
  var_3.targetname = "_encstr_B40818256BE3451487F58CC8C7B1FE8550920B90BD97F96825BB";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 205.14, 0);
  var_3.origin = (16405, -5254.11, 808);
  var_3.targetname = "_encstr_B40818256BE3451487F58CC8C7B1FE8550920B90BD97F96825BB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 106.59, 0);
  var_3.origin = (16320.4, -5253.4, 808);
  var_3.targetname = "_encstr_B40818256BE3451487F58CC8C7B1FE8550920B90BD97F96825BB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.classname = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  var_3.angles = (0, 171.86, 0);
  var_3.origin = (16362.6, -5259.13, 808);
  var_3.targetname = "_encstr_B40818256BE3451487F58CC8C7B1FE8550920B90BD97F96825BB";
  var_3.model = "_encstr_8264201BDB378E165ACDCAE4EBC2D65BB7D798EDC3BEC062EBCDDEC1D0979B5AC6B9";
  var_0 scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}