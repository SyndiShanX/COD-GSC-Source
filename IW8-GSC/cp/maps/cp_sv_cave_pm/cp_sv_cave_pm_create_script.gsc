/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_cave_pm\cp_sv_cave_pm_create_script.gsc
*****************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_87881C405B8987AB1713C744EDEF937361F240C8E21BD3C68F3B5633D06B")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_87881C405B8987AB1713C744EDEF937361F240C8E21BD3C68F3B5633D06B");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_87881C405B8987AB1713C744EDEF937361F240C8E21BD3C68F3B5633D06B");

  if(!scripts\cp\so_trigger::cs_is_starttime())
    scripts\cp\so_trigger::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "_encstr_87881C405B8987AB1713C744EDEF937361F240C8E21BD3C68F3B5633D06B");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_87881C405B8987AB1713C744EDEF937361F240C8E21BD3C68F3B5633D06B");
  else
    scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_87881C405B8987AB1713C744EDEF937361F240C8E21BD3C68F3B5633D06B");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-17958.6, -3963.1, 2593.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-139.33, -1860.2, 2056), (0, 314, 0), "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1970.65, -138.71, 2056), (0, 314, 0), "_encstr_A78C062CD58E7B0D", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3152.47, 250, 2056), (0, 314, 0), "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3655.5, 2790, 2056), (0, 314, 0), "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1957.36, -2976.24, -491.63), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2585.71, -646.98, 713.4), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1392.63, 1233.58, 823.58), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (828.59, 1943.62, 1148.71), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1888.26, 1329.27, 932.51), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6511.24, 1150.27, 384.31), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2398.65, -2458.08, -468.83), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3881.81, -1602.27, -215.62), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-215.4, -4236.39, -423), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2452.79, 3361.89, 1327.88), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2619.43, -1408.38, 1064.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "_encstr_8607036732", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-1758.98, -1382.84, 98), (2.56, 3.46, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AF10159EBD0ACBFF9EBF62AA97F089B322D0669720FE03", "_encstr_A707037D2E", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7775.16, 206.6, 1511.08), (0, 184, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A707037D2E", "_encstr_A30703C216", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3156.33, -1416.68, 1238.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "_encstr_AF0703537A", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6921.66, -474.27, 1516.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "_encstr_A10703AF6B", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4122.97, -1438.75, 1418.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "_encstr_8D070366C0", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4631.97, -1357.65, 1478.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "_encstr_AF07037378", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5587.74, -1200.24, 1490.42), (0, 273.66, 0), undefined, undefined, undefined, undefined, "_encstr_9A07038CC1", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-159.07, -581.1, 960.18), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "_encstr_AA07038618", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-382.98, -1316.84, 44), (359.3, 255.43, 2.54), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_ABCD15CC330833530499B14099DC80990E046672804306", "_encstr_A907032B71", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (936.64, 6297.35, 3142.81), (3.28, 15.88, -1.9), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A907032B71", "_encstr_A5070399CC", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (59.82, 71.65, 1104.05), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "_encstr_B40703F2DB", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1581.49, 5173.7, 3147.79), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "_encstr_BA0703422B", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (638.02, 1374.48, 1785.84), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "_encstr_9507036670", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1062.97, 2478.69, 2470.79), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "_encstr_8C07034B17", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1542.11, 3795.87, 3088.17), (1.91, 105.65, 3.27), undefined, undefined, undefined, undefined, "_encstr_9A0703CCB1", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1318.43, -89.12, 1040.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "_encstr_BE0703F3E3", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (969.02, -860.84, 170), (2.56, 245.46, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_862D1553C721275B69D2AA022A3380EFD5D7DB2BE7619F", "_encstr_AD07031F3A", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1324.87, 6666.92, 3093.08), (0, 66, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_AD07031F3A", "_encstr_9707038698", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1499.16, 260.83, 1214.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "_encstr_8107037F7F", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2498.99, 3526.98, 3092.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "_encstr_850703EA5F", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1805.49, 868.69, 1714.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "_encstr_88070375E3", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2148.06, 1664.03, 2382.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "_encstr_960703127A", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2511.76, 2850.02, 3034.42), (0, 155.66, 0), undefined, undefined, undefined, undefined, "_encstr_87070324D5", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4858.11, 2692.63, 1106.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_9107039BC6", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (3371.02, 2555.16, 132), (2.56, 180.45, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8D9C1BD04E02D4C4409A2340D46601D4A1409AA6406A6C104DCD405370", "_encstr_82070322E1", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (8755.89, 8028.01, 2543.08), (0, 0.99, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_82070322E1", "_encstr_9207032493", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5315.65, 2852.73, 1296.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_AC0703DB66", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7994.33, 6094.9, 2542.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_9207032597", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6052.01, 3287.99, 1708.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_B80703C3D4", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6741.61, 3873.64, 2088.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_8E0703AD0B", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7450.19, 4901.23, 2484.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_BE0703B3E6", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4578.11, 2612.63, 1002.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_8F070362BF", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4346.11, 2556.63, 866.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_A30703DE22", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3118.08, -1457.97, 1330.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "_encstr_B20703B664", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-1596.98, 95.16, 364), (2.56, 57.46, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_BDB71B82BF265D13BA765E5F6EAE69158B96121AC65B85F9CA1F2F4C48", "_encstr_B107031B8F", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7695.09, 442.23, 1777.08), (0, 238, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_B107031B8F", "_encstr_9307031341", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3850.95, -1799.21, 1504.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "_encstr_B40703B3C3", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7466.58, -315.49, 1782.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "_encstr_BA070303AB", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4905.27, -1686.21, 1684.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "_encstr_B60703CFCF", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6004.06, -1384.33, 1744.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "_encstr_A20703AC8B", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6771.2, -921.04, 1756.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "_encstr_950703C664", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2790.08, -1335.97, 1272.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "_encstr_A607030F8B", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2424.08, -939.97, 1194.42), (0, 327.66, 0), undefined, undefined, undefined, undefined, "_encstr_8607036D38", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3585.86, 158.44, -241.71), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-16678.6, -1659.1, 3361.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4499.34, 3391.8, 294.83), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (19873.4, 9344.9, 4009.71), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5321.03, 410.66, -69.67), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23839.9, 2099.41, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23129.4, 6124.9, 4009.71), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}