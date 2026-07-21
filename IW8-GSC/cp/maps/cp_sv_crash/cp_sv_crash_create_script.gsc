/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_crash\cp_sv_crash_create_script.gsc
*************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_B1CA1A5E808F9B15293298182B3C8F51833DD74DEDE7C3074A7A80B8")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_B1CA1A5E808F9B15293298182B3C8F51833DD74DEDE7C3074A7A80B8");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_B1CA1A5E808F9B15293298182B3C8F51833DD74DEDE7C3074A7A80B8");

  if(!scripts\cp\so_trigger::cs_is_starttime())
    scripts\cp\so_trigger::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "_encstr_B1CA1A5E808F9B15293298182B3C8F51833DD74DEDE7C3074A7A80B8");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_B1CA1A5E808F9B15293298182B3C8F51833DD74DEDE7C3074A7A80B8");
  else
    scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_B1CA1A5E808F9B15293298182B3C8F51833DD74DEDE7C3074A7A80B8");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1626.96, -1741.78, 265), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-459.33, -1548.2, 2056), (0, 314, 0), "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1024.65, 2469.29, 2056), (0, 314, 0), "_encstr_A78C062CD58E7B0D", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1924.47, -1537.99, 2056), (0, 314, 0), "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1725.5, 1694, 2056), (0, 314, 0), "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1966.11, 2699.37, 1330.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_9107039BC6", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-511.02, 2504.84, 356), (2.56, 0.45, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8D9C1BD04E02D4C4409A2340D46601D4A1409AA6406A6C104DCD405370", "_encstr_82070322E1", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6356.33, 9558.99, 432.5), (0, 180.99, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_82070322E1", "_encstr_9207032493", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2277.65, 2923.27, 1520.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_AC0703DB66", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5112.33, 6893.1, 2766.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_9207032597", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2638.01, 3210.01, 1932.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_B80703C3D4", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3203.61, 3778.36, 2312.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_8E0703AD0B", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3920.19, 4858.77, 2708.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_BE0703B3E6", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1718.11, 2589.37, 1226.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_8F070362BF", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1486.11, 2503.37, 1090.42), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_A30703DE22", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (23875.9, 2063.41, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22327.9, 7597.41, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (17789.9, 13167.4, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (11295.9, 16007.4, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4913.9, 16853.4, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3684.1, 17073.4, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-11036.1, 15083.4, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-16214.1, 10351.4, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-18596.1, 3637.4, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-17756.1, -4172.6, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-15908.1, -8528.6, 3497.71), (0, 180, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-13654.1, -12016.6, 3497.71), (0, 160, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8983.24, -14621.2, 3497.71), (0, 160, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2782.96, -16801.3, 3497.71), (0, 160, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4785.04, -17957.3, 3497.71), (0, 160, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (12123, -16021.3, 3497.71), (0, 160, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (18123, -12701.3, 3497.71), (0, 160, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (22047, -8275.3, 3497.71), (0, 160, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (24817, -3757.3, 3497.71), (0, 160, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2526.11, 1276.63, 1226.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_B20703B664", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (1039.02, 1139.16, 252), (2.56, 180.45, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_BDB71B82BF265D13BA765E5F6EAE69158B96121AC65B85F9CA1F2F4C48", "_encstr_B107031B8F", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7000.58, 7549.47, 500.5), (0, 0.99, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_B107031B8F", "_encstr_9307031341", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2983.65, 1436.72, 1416.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_B40703B3C3", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5662.34, 4678.89, 2662.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_BA070303AB", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3720.01, 1871.98, 1828.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_B60703CFCF", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4409.61, 2457.63, 2208.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_A20703AC8B", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5118.2, 3485.22, 2604.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_950703C664", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2246.11, 1196.63, 1122.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_A607030F8B", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2014.11, 1140.63, 986.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_8607036D38", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3108.11, 690.63, 1668.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_B107035B8C", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_88520840BAB5F918BF78";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (1621.02, 553.16, 694), (2.56, 180.45, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8E891B8F7AB93B36E97CD2F854A33A63C992F727623FB3AAF364C8E7AB", "_encstr_8B0703C6E4", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7221.23, 5839.67, 574.84), (0, 0.99, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_8B0703C6E4", "_encstr_B20703B767", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3600.57, 890.53, 1858.42), (0, 0.66, 0), undefined, undefined, undefined, undefined, "_encstr_B40703F3C3", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6244.37, 4092.88, 3104.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_840703E71E", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4302.01, 1285.97, 2270.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_950703E668", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4991.61, 1871.62, 2650.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_A607031F0B", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5700.21, 2899.21, 3046.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_B60703DFAF", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2828.11, 610.63, 1564.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_A207032C8F", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2596.11, 554.63, 1428.42), (0, 90.66, 0), undefined, undefined, undefined, undefined, "_encstr_880703F460", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-502.79, -1119.91, 1392.05), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_A20703AB8E", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_88520840BAB5F918BF78";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (984.3, -982.44, 417.62), (2.56, 0.45, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8DCA1BEFB976BAEFF2EF2359D7862FF22B387993C8D872BF7AF76952BF", "_encstr_840703171A", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4240.58, -6016.62, 796.02), (0, 180.99, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_840703171A", "_encstr_9607030A1A", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-960.33, -1279.99, 1582.05), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_950703076A", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3639.04, -4522.16, 2828.04), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_B20703B8E7", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1696.69, -1715.25, 1994.04), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_B4070330C1", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2386.29, -2300.9, 2374.04), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_B607032FBF", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3094.89, -3328.49, 2770.04), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_A60703EF2B", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-222.79, -1039.91, 1288.05), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_B10703980C", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (9.21, -983.91, 1152.05), (0, 270.66, 0), undefined, undefined, undefined, undefined, "_encstr_9607037212", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-642.84, -114.78, 1154.05), (0, 194.65, 0), undefined, undefined, undefined, undefined, "_encstr_970703271B", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-149.7, -1524.44, 179.62), (2.56, 284.45, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_B6E91B301A3A01273F5BEA9A639EFEC942D188FBA15AB66ECB2FAAF689", "_encstr_810703AF78", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7118.01, 2933.47, 378.5), (0, 104.99, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_810703AF78", "_encstr_8807037320", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-908.85, 290.45, 1344.05), (0, 194.65, 0), undefined, undefined, undefined, undefined, "_encstr_AD0703CF02", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4702.75, 2105.26, 2590.04), (0, 194.65, 0), undefined, undefined, undefined, undefined, "_encstr_880703F322", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1509.32, 899.64, 1756.04), (0, 194.65, 0), undefined, undefined, undefined, undefined, "_encstr_850703DE51", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2244.4, 1427.08, 2136.04), (0, 194.65, 0), undefined, undefined, undefined, undefined, "_encstr_8707032956", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3412.89, 1866.04, 2532.04), (0, 194.65, 0), undefined, undefined, undefined, undefined, "_encstr_9607037A42", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-497.48, -367.11, 1050.05), (0, 194.65, 0), undefined, undefined, undefined, undefined, "_encstr_AA0703279B", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-387.02, -578.67, 914.05), (0, 194.65, 0), undefined, undefined, undefined, undefined, "_encstr_8E0703AB38", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (595.19, -4442.48, 265), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2929.49, -2683.49, 263), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2942.58, -339.54, 332.85), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1914.12, 522.58, 674.85), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-51.97, 3974.44, 744.83), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2460.07, 2085.2, 358.22), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (610.81, 34, 854), (0, 272, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}