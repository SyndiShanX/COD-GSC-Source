/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_aniyah\cp_sv_aniyah_create_script.gsc
***************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_A64D1B41326FA80CC9C79583BF725B81EB0A0999DBBD114622E393B9A3")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_A64D1B41326FA80CC9C79583BF725B81EB0A0999DBBD114622E393B9A3");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_A64D1B41326FA80CC9C79583BF725B81EB0A0999DBBD114622E393B9A3");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_A64D1B41326FA80CC9C79583BF725B81EB0A0999DBBD114622E393B9A3");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_A64D1B41326FA80CC9C79583BF725B81EB0A0999DBBD114622E393B9A3");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_A64D1B41326FA80CC9C79583BF725B81EB0A0999DBBD114622E393B9A3");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1397.5, -18773.5, 1705), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A1AD05A11588D7", "_encstr_A34C02BB", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7152.5, -8886, 2372), undefined, undefined, undefined, undefined, undefined, "_encstr_A74C0222", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-32893.5, 5969.5, 1705), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_83AD0559EA686F", "_encstr_A90703297F", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7152.5, -8886, 2372), undefined, undefined, undefined, undefined, undefined, "_encstr_A74C0222", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-9028, -2657.5, 1833), undefined, undefined, undefined, undefined, undefined, "_encstr_A14C023B", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7129, 851.5, 1577), undefined, undefined, undefined, undefined, undefined, "_encstr_AC4C024A", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_851917AC9D366B98BF0930CA5352E0FDE89920988DC9209771";
  var_4.script_unload = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-5303.45, 2120.42, 370.04), (0, 191.41, 0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_A9990CFF5BEA4B197E6F2A8A8713", "_encstr_83AD0559EA686F", undefined, undefined, 512, 2000, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-5805.45, -1013.58, 370.04), (0, 260.3, 0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8C8E083EB9EEF6C3EA63", "_encstr_A1AD05A11588D7", undefined, undefined, 512, 2000, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-55842.7, 41483, 3881), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-58433.7, 16432.5, 2905), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (13072, -105.5, 3652), (0, 180.12, 0), undefined, undefined, undefined, "_encstr_86260680A8528A0E", "_encstr_AF0703133A", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2613.5, -19788.5, 1466), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_8BAD056C92EA37", "_encstr_A30703C216", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-55842.7, 41483, 3881), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-58433.7, 16432.5, 2905), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (13072, -105.5, 3652), (0, 180.12, 0), undefined, undefined, undefined, "_encstr_86260680A8528A0E", "_encstr_AF0703133A", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (10883, 3796.94, 3113), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_9A07034C89", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18353, 8395.5, 2601.5), undefined, undefined, undefined, undefined, undefined, "_encstr_8B070326D0", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1137, 3237.5, 2372), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_8F4C026A", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16588.3, 30702.4, 508.5), (0, 180.12, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_99AD05CCA29B52", "_encstr_B84C027E", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1137, 3237.5, 2372), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_8F4C026A", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3040.46, 44.94, 2345), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_914C02DC", undefined, undefined, 253.44, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-780.11, -2897.53, 2089), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_864C02F9", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_851917AC9D366B98BF0930CA5352E0FDE89920988DC9209771";
  var_4.script_unload = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (126.94, 703.77, 370.04), (0, 77.36, 0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_885B086A101B086E400E", "_encstr_99AD05CCA29B52", undefined, undefined, 512, 2000, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (46401.3, 9163.5, 4185), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (46401.3, 9163.5, 4185), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6152.89, 2345.47, 3113), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_8C0703491D", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (13072, -105.5, 1092), (0, 180.12, 0), undefined, undefined, undefined, "_encstr_86260680A8528A0E", "_encstr_AF0703133A", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5702.5, 5327.5, 2601.5), undefined, undefined, undefined, undefined, undefined, "_encstr_8607036335", undefined, undefined, 498.872, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1734.5, 2895.5, 2537.5), undefined, undefined, undefined, undefined, undefined, "_encstr_A5070398D8", undefined, undefined, 730.398, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (29832.5, -245.5, 2000), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_9BAD05B1A7814D", "_encstr_8D070326DC", undefined, undefined, 269.377, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_delay_spawn = "_encstr_B84C027E";
  var_4.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (8338.55, 1044.92, 390.04), (0, 260.3, 0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AC5B0C46EF6F6F40724B285613CA", "_encstr_9BAD05B1A7814D", undefined, undefined, 512, 2000, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16771, 3444.94, 3609), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_AB07034CE0", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (12636.5, 6364.94, 2692), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_990703AAEB", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (8506, 4470.44, 2905), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_990703B2F9", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (14753.3, -11001.1, 737), (0, 180.12, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_ABAD054D6A396F", "_encstr_8B4C0227", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3662.5, -20694.5, 763), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_86AD05B1A718B1", "_encstr_AB07038CC4", undefined, undefined, 269.377, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (392.42, 3600.45, 363.54), (0, 202.53, 0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_88050C822B0A3A27EF9D3E6A85CD", "_encstr_86AD05B1A718B1", undefined, undefined, 512, 2000, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3383.5, 1015.94, 2987), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_83070312DB", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4034, 3417.9, 2987), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_9B0703C899", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2502.5, 4425.4, 2987), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_9307031D4C", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (13072, -105.5, 1092), (0, 180.12, 0), undefined, undefined, undefined, "_encstr_86260680A8528A0E", "_encstr_AF0703133A", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (10883, 3796.94, 4393), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_9A07034C89", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6152.89, 2345.47, 2601), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_8C0703491D", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (6009.35, -924.35, 372.53), (0, 269, 0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_BD220BE404620340894C0826C8", "_encstr_ABAD054D6A396F", undefined, undefined, 512, 2000, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8AEE0B360BE6578563AFCEBACD";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_A6D21863319C85CE7B7D6C0BC99C96564EB0B64BCDD2465A5870";
  var_4.script_unload = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-294.58, -1339.05, 369.54), (0, 259.74, 0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_A7BC0C971AF12272A186AFB09E7A", "_encstr_8BAD056C92EA37", undefined, undefined, 512, 2000, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1362.11, -9334.5, 2511), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_A707037D2E", undefined, undefined, 498.872, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3953.61, -2176.5, 2511), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_A10703AF6B", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-122.11, 937.5, 2120), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_9A07038CC1", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6290.54, -3043.73, 382.36), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1135.61, -9700.5, 2511), (0, 180.12, 0), undefined, undefined, undefined, undefined, "_encstr_A707037D2E", undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7987.44, -2094.29, 380.69), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7353.34, 629.36, 369.63), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8370.84, 3038.3, 348.04), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5883.58, 4742.17, 320.91), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3717.28, 5366.77, 334.08), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-412.26, 6132.96, 307.06), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2330.83, 5413.7, 392.08), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7751.29, 5405.7, 355.98), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (10917.4, 3564.14, 303.38), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (11712.1, 23.08, 171.4), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (10125.8, -2683.48, 457.21), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7487.05, -5017.68, 371.36), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3256.01, -4870.42, 470.12), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (522.97, -7618.66, 340.41), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2543.56, -5238.77, 413.94), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4848.83, -4670.84, 437.11), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4845.61, 5743.8, 379.47), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5136.25, 1131.6, 721.53), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3723.66, 1187.54, 727.93), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1737.52, -1958.12, 671.93), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2499.22, 2293.43, 825), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1700.46, -39.8, 1180.53), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2840.34, -46.29, 1575.7), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3850.32, -48.63, 927.7), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4044.63, 2396.2, 747.7), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2379.36, 3323.32, 673.7), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-785.9, 1651.83, 767.7), (0, 300, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (596.34, -9.23, 879.7), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (8250, -344, 2056), undefined, "_encstr_AB8C0652EB7DF703", "_encstr_938C069E6B60AFDF", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5255.75, 21.16, 733), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7683.6, 821.51, 673), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6210.08, 931.31, 709), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6175.35, 232.36, 632.5), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4294, -600, 2056), undefined, "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7994, 1960, 2056), undefined, "_encstr_A78C062CD58E7B0D", "_encstr_AB8C0652EB7DF703", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4294, 1960, 2056), undefined, "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1850, 2984, 2056), undefined, "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2362, -1368, 2056), undefined, "_encstr_938C069E6B60AFDF", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}