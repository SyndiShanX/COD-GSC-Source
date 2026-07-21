/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_speed\cp_sv_speed_create_script.gsc
*************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_87DF1A36077DCD9DBEDC0E59CA91BE1B39560B4759D76E1BC94BE03A")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_87DF1A36077DCD9DBEDC0E59CA91BE1B39560B4759D76E1BC94BE03A");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_87DF1A36077DCD9DBEDC0E59CA91BE1B39560B4759D76E1BC94BE03A");

  if(!scripts\cp\so_trigger::cs_is_starttime())
    scripts\cp\so_trigger::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "_encstr_87DF1A36077DCD9DBEDC0E59CA91BE1B39560B4759D76E1BC94BE03A");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_87DF1A36077DCD9DBEDC0E59CA91BE1B39560B4759D76E1BC94BE03A");
  else
    scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_87DF1A36077DCD9DBEDC0E59CA91BE1B39560B4759D76E1BC94BE03A");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1215.96, -3045.33, 60.85), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1875.33, 275.8, 2056), (0, 314, 0), "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1250.65, 2893.29, 2056), (0, 314, 0), "_encstr_A78C062CD58E7B0D", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-199.53, 1058.01, 2056), (0, 314, 0), "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (335.5, 3470, 2056), (0, 314, 0), "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2540, -21724, 2592), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-24668, -3696, 3132), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1288.54, -289.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_864C02F9", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_88520840BAB5F918BF78";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-1016.02, 479.84, 139.5), (2.56, 11.79, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8FC30EF98952C602C77BE68FF1648A18", "_encstr_A74C0222", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3806.66, -4407.82, 1105.08), (1, 0, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A74C0222", "_encstr_A34C02BB", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1288.54, -777.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_914C02DC", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2885.04, -3556.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_A14C023B", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1374.04, -1261.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_8F4C026A", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1523.04, -1739.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_B84C027E", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1916.04, -2387.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_AC4C024A", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2577.51, 4632.55, 195.48), (0, 125, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2866.57, 5542.47, 58.55), (0, 170, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4767.78, -747.32, 194.66), (0, 310, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (120.53, 5919.25, 35.5), (0, 235, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2842.82, 1523.91, 185.27), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4641.59, 2122.76, 282.82), (0, 90, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3320.09, -2680.73, 236.25), (0, 280, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (202.25, 98.3, 1228.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_8607036732", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-759.63, 510.73, 80), (2.56, 199.46, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AF10159EBD0ACBFF9EBF62AA97F089B322D0669720FE03", "_encstr_A707037D2E", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1560.75, -4876.12, 1101.08), (0, 316, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A707037D2E", "_encstr_A30703C216", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (582.97, -273.29, 1402.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_AF0703537A", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2263.75, -3775.52, 1680.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_A10703AF6B", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1242.33, -969.59, 1582.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_8D070366C0", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1526.66, -1406.57, 1642.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_AF07037378", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1995.55, -2219.36, 1654.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_9A07038CC1", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1074.49, 2826.35, 1193.82), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_A30703DE22", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-204.34, 3073.48, 148), (2.61, 156.77, -0.34), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AC7615EF2FB0A3BB608BB2390DDB58EB724A9596292542", "_encstr_BE0703B3E6", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6173.29, 7800.11, 960), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_BE0703B3E6", "_encstr_9207032597", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1575.77, 2939.83, 1384.28), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_8F070362BF", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23552, 7332, 2592), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2516, 24744, 3132), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5924.17, 6523.49, 1950.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_8E0703AD0B", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2816.41, 3322.2, 1614.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_9107039BC6", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4437.93, 4132.42, 1949.49), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_AC0703DB66", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5487.06, 5099.81, 1949.71), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_B80703C3D4", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-560.76, 3959.63, 1396.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_B20703B664", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_88520840BAB5F918BF78";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-795.98, 3207.16, 146), (2.56, 353.79, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_844B154D72106389041B23106C9908C6D004B1A9408D63", "_encstr_B107031B8F", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3307.2, 8488.76, 1360.08), (1, 156, -0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_B107031B8F", "_encstr_9307031341", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-368.27, 4389.43, 1578.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_B40703B3C3", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1614.38, 7779.83, 1982.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_BA070303AB", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-254.53, 4937.06, 1718.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_B60703CFCF", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-206.16, 5572.37, 1838.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_A20703AC8B", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-592.29, 6629.1, 1982.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_950703C664", undefined, undefined, 512, 45, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}