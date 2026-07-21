/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_piccadilly\cp_piccadilly_create_script.gsc
*****************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_97F21CA8B36159904FAB7FE5895B78F3D92AB8105A43BB6E57D3FE6B88C3")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_97F21CA8B36159904FAB7FE5895B78F3D92AB8105A43BB6E57D3FE6B88C3");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_97F21CA8B36159904FAB7FE5895B78F3D92AB8105A43BB6E57D3FE6B88C3");

  if(!scripts\cp\so_trigger::cs_is_starttime())
    scripts\cp\so_trigger::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "_encstr_97F21CA8B36159904FAB7FE5895B78F3D92AB8105A43BB6E57D3FE6B88C3");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_97F21CA8B36159904FAB7FE5895B78F3D92AB8105A43BB6E57D3FE6B88C3");
  else
    scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_97F21CA8B36159904FAB7FE5895B78F3D92AB8105A43BB6E57D3FE6B88C3");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (685.24, -3298.7, 1533.74), (1, 148, -0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A5070398D8", "_encstr_A90703297F", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5120, 6144, 3072), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (329.3, -2742.35, 1593.83), (1, 88, 0), undefined, undefined, undefined, undefined, "_encstr_8B070326D0", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-19.19, -2197.52, 1564.03), (359.17, 145.69, 0.56), undefined, undefined, undefined, undefined, "_encstr_8607036335", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4352, 4608, 3072), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-2393.78, 525.22, 260), (0.87, 43.2, 0.49), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_85CC0AFE3A7B607709555E13", "_encstr_8F4C026A", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-13568, -256, 3072), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (0, -9984, 3072), (0, 262.2, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6656, -1024, 3072), (0, 262.2, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-12288, -9216, 3072), (0, 262.2, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (8.6, -394.74, 219.41), (0.74, 323.99, -0.67), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_938412C80680912310C86604C80D0446D401C8D8", "_encstr_AB07038CC4", undefined, undefined, 1024, 20, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (2047.4, -1607.6, 212.19), (1, 228, -0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_A3130C9F5742165727D690B10A7F", "_encstr_8C0703491D", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7717.01, 5407, 1254.95), (1, 278, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_8F4C026A", "_encstr_A34C02BB", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (1878.96, 887.45, 258.01), (0.83, 214, 0.56), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_B83E12DA477E9F32F04208A83EAB02931FE60FD6", "_encstr_990703AAEB", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6991.25, 3422.89, 1158.95), (1, 296, -0), undefined, undefined, undefined, undefined, "_encstr_A74C0222", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-1846.67, -1500.02, 192.64), (1, 176, -0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_BDF30F6F1B6F468B8AF3AD80CD0AB602CB", "_encstr_A5070398D8", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3977.2, 829.91, 1145), (1, 344, 0), undefined, undefined, undefined, undefined, "_encstr_A14C023B", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3264.97, 525.45, 1147), (0.95, 350.4, 0.31), undefined, undefined, undefined, undefined, "_encstr_AC4C024A", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-580.48, -5901.85, 1107), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (-2704.47, 471.65, 712), (0.09, 24.7, 0.99), undefined, undefined, undefined, undefined, "_encstr_B84C027E", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3014.48, -6261.85, 1275), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (1896.3, 4081.46, 1658.24), (1, 260, -0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_990703AAEB", "_encstr_8D070326DC", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (2215.38, 3131.89, 1621.18), (1, 214, -0), undefined, undefined, undefined, undefined, "_encstr_AB07034CE0", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-350.48, -2387.85, 1327), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1337.1, -5424.1, 1385.34), (0.64, 50.1, 0.77), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_8C0703491D", "_encstr_914C02DC", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2640.8, -3625.7, 1113.17), (0.01, 93.2, 1), undefined, undefined, undefined, undefined, "_encstr_864C02F9", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2626.4, -2853.3, 829.78), (359.54, 97.19, 0.89), undefined, undefined, undefined, undefined, "_encstr_8B4C0227", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2496, -2085.4, 865.18), (1, 112.4, 0), undefined, undefined, undefined, undefined, "_encstr_AF0703133A", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (1989.1, -1519.8, 780.18), (1, 206.6, 0), undefined, undefined, undefined, undefined, "_encstr_9A07034C89", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3195.52, -3041.85, 1252), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (-2584.9, 4354.4, 1305.54), (1, 258.9, -0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_AB07038CC4", "_encstr_990703B2F9", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2740.6, 1807.23, 1775.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "_encstr_9B0703C899", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4352, -11008, 3072), (0, 262.2, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3010.57, 300.63, 1422), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1461.05, -470.44, 1176), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (287.05, 1231.34, 800), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2977.92, -420.01, 1328), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2658.86, -2987.42, 1280), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2741.83, -4124.87, 1001.48), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3153.76, -1923.16, 1130), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5577.75, 141.96, 1528), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6457.88, -2112.42, 1296), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2647.06, -8039.41, 1387.36), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (42.16, -7745.1, 1232.36), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-620.25, -4189.54, 1048.36), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2081.33, -4385.16, 1112.36), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1741.78, -2903.44, 1316.36), (0, 90, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2888.04, -1229.23, 1215.36), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (177.31, 257.3, 1137.36), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2413.71, 1650.34, 1483.81), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5038.42, 2999.46, 1259.81), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2109.13, 3249.36, 1544), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1693.81, 1403.05, 1104), (0, 285, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3571.79, 2788.07, 1061), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (265.46, 3036.71, 1254.5), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4047.18, 690.27, 1648.5), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4680.55, 1151.56, 1392), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1990, 680, 2056), undefined, "_encstr_A78C062CD58E7B0D", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1850, 936, 2056), undefined, "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (570, -1368, 2056), undefined, "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1734, -2648, 2056), undefined, "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2774.6, 2783.23, 1773.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "_encstr_83070312DB", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-698.6, -56.77, 1367.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "_encstr_A707037D2E", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2414.6, 899.23, 1765.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "_encstr_9307031D4C", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1566.6, 397.23, 1573.66), (1, 282.8, 0), undefined, undefined, undefined, undefined, "_encstr_A30703C216", undefined, undefined, 1024, 27, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-211.19, -1775.52, 1548.03), (359.17, 145.69, 0.56), undefined, undefined, undefined, undefined, "_encstr_A10703AF6B", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-381.19, -1541.52, 1528.03), (359.17, 145.69, 0.56), undefined, undefined, undefined, undefined, "_encstr_9A07038CC1", undefined, undefined, 512, 25, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (2440.92, 1235.36, 1160.38), (1.15, 192, -0.35), undefined, undefined, undefined, undefined, "_encstr_8607036732", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (2345.38, 2665.89, 1553.18), (1, 214, -0), undefined, undefined, undefined, undefined, "_encstr_AF07037378", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (2381.38, 2177.89, 1413.18), (1, 214, -0), undefined, undefined, undefined, undefined, "_encstr_8D070366C0", undefined, undefined, 512, 20, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_goalyaw = "_encstr_AAEF05B83B43EB";
  var_0[[var_3]](var_4, var_1, var_2, (2435.38, 1719.89, 1271.18), (1, 214, -0), undefined, undefined, undefined, undefined, "_encstr_AF0703537A", undefined, undefined, 512, 20, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.is_cs_trigger = 1;
  var_3.height = 210;
  var_3.origin = (524, -1452, -104);
  var_3.radius = 256;
  var_3.targetname = "_encstr_A569148FF57E1B196C3F5039AD8BC080153F53357993";
  var_0 scripts\cp\so_trigger::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.is_cs_trigger = 1;
  var_3.height = 210;
  var_3.origin = (380, -1432, -104);
  var_3.radius = 96;
  var_3.targetname = "_encstr_A569148FF57E1B196C3F5039AD8BC080153F53357993";
  var_0 scripts\cp\so_trigger::strike_additem(var_3, var_1, var_2);
  var_3 = spawnStruct();
  var_3.is_cs_trigger = 1;
  var_3.height = 128;
  var_3.origin = (-1848, -52, -16);
  var_3.radius = 176.418;
  var_3.targetname = "_encstr_A569148FF57E1B196C3F5039AD8BC080153F53357993";
  var_0 scripts\cp\so_trigger::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}