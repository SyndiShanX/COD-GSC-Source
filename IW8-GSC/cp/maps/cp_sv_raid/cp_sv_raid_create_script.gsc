/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_raid\cp_sv_raid_create_script.gsc
***********************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_A77B19BA08375A5B964E11016DBEC7A2FB2853520907167388B70C")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_A77B19BA08375A5B964E11016DBEC7A2FB2853520907167388B70C");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_A77B19BA08375A5B964E11016DBEC7A2FB2853520907167388B70C");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_A77B19BA08375A5B964E11016DBEC7A2FB2853520907167388B70C");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_A77B19BA08375A5B964E11016DBEC7A2FB2853520907167388B70C");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_A77B19BA08375A5B964E11016DBEC7A2FB2853520907167388B70C");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3513.76, -10018.7, 1027.24), (1, 0, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_B84C027E", "_encstr_8F4C026A", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2400.92, 3112.32, 446.31), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2502.2, -1212.7, 1621.67), undefined, undefined, undefined, undefined, undefined, "_encstr_8B4C0227", undefined, undefined, 1028, 500, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3123.8, -5536.7, 2849.67), undefined, undefined, undefined, undefined, undefined, "_encstr_AF0703133A", undefined, undefined, 1028, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-551.04, -151.24, 377.6), (359.77, 180, 0.17), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8FC92736E9BE33336874A39127894C408DA7AF336643E8D11927268C1036E97DCC991A47A3469CC4CC", "_encstr_85F70751D0B13A6FE2", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_4._id_12F92 = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-2655.53, 1353.98, 377.63), (0, 95, 0), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8EE6062BEE36F72A", "_encstr_B84C027E", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-157.68, 1423.95, 407.64), (1.75, 180, 0.01), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8ABA1A1A4ADFE5EF6AEA6AF2986FF7C284C3E732332E5A97123262B7", "_encstr_A1F7073462DF4BE39A", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-1181.64, 2439.22, 373.24), (359.26, 53.99, 0.45), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_922741C9A2F101575A125A673658F26A25DD0E6A7A82D562FEBE2016A0F938012E739ADFB8C2D488DC1A3C13064783DA476A718F48039098189719AFEA155A2EECB8B0", "_encstr_B6F70762701FD27A13", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (702.98, -428.16, 369.9), (2.56, 143.01, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_831A0C5BBA46EA1D6649B3CAEB33", "_encstr_A74C0222", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3600.84, -9514.82, 298.08), (1, 0, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A74C0222", "_encstr_A34C02BB", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3484.46, -7219.7, 2902.42), (1, 0, 0), undefined, undefined, undefined, undefined, "_encstr_AC4C024A", undefined, undefined, 1028, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3572.46, -9049.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_A14C023B", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8255.01, 2575, 1742.45), (1, 0, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_B6F70762701FD27A13", "_encstr_8A310D7132376B3FDAFFB2E21770E1", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3392.75, 1494.85, 430.38), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6287.25, 2178.89, 2894.45), (1, 0, 0), undefined, undefined, undefined, undefined, "_encstr_84310D89BABFE3A742770A6A8FF86B", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8261.13, -7296.14, 2327.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5600.2, 1775.91, 2895.5), (1, 0, 0), undefined, undefined, undefined, undefined, "_encstr_B2310D9C0509BA26E642AF07DB3BEA", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4660.97, 1652.45, 2895.5), (1, 0, 0), undefined, undefined, undefined, undefined, "_encstr_A6310D884B399313323A1A972EC2CB", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-9669.13, -5152.14, 2345.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-4191.47, 1439.65, 2435.5), (0, 20, 0), undefined, undefined, undefined, undefined, "_encstr_B6310D992A776B5F3E42C242FDF8DB", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-10981.1, -2176.14, 2345.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (12017.8, -174.6, 692.06), (1, 180, -0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A1F7073462DF4BE39A", "_encstr_8C280D9A12F0AA2AC20542B2E902D2", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5706.38, 1782.89, 3094.68), (1, 180, -0), undefined, undefined, undefined, undefined, "_encstr_A9280D016ADEB6439E22FA8A805A7A", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-11013.1, 1631.86, 2385.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2481.16, -1147.49, 382.14), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3408.2, -6608.7, 2951.67), undefined, undefined, undefined, undefined, undefined, "_encstr_914C02DC", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-9637.1, 5311.86, 2367.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7973.1, 8959.86, 2261.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5669.1, 10911.9, 2205.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2341.1, 12607.9, 2077.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (8981.47, 4380.8, 696.06), (1, 0, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_85F70751D0B13A6FE2", "_encstr_B1CE0DB19EAF99CCD0A3D123721326", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7716.4, 3706.23, 2483.16), (1, 0, 0), undefined, undefined, undefined, undefined, "_encstr_8CCE0D8D3DBE99CC0D478E23C98991", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1316.8, 139.73, 2326.09), (1, 0, 0), undefined, undefined, undefined, undefined, "_encstr_A9CE0D36A7EBCC66688E1D91936266", undefined, undefined, 512, 2000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3706.9, 11295.9, 1929.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2719.8, -3362.7, 1941.67), undefined, undefined, undefined, undefined, undefined, "_encstr_9A07034C89", undefined, undefined, 1028, 500, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6397.13, -10572.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (644.52, -3402.94, 411.9), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-1084.74, 4154.4, 383.38), (2.56, 269.02, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_87C30C6223808968014CD401621B", "_encstr_A90703297F", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1929.9, 13952.9, 917.84), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A90703297F", "_encstr_8C0703491D", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1902.2, 12691.3, 2849.67), undefined, undefined, undefined, undefined, undefined, "_encstr_8B070326D0", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1368.2, 8631.3, 2601.67), undefined, undefined, undefined, undefined, undefined, "_encstr_8607036335", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-1250.2, 6693.3, 2025.67), (0, 272, 0), undefined, undefined, undefined, undefined, "_encstr_A5070398D8", undefined, undefined, 1028, 500, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (12906.9, 10009.9, 1929.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (16142.9, 6329.9, 1929.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (17020.9, 115.9, 1929.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (15720.9, -5752.1, 1929.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (12298.9, -9250.1, 1929.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6602.9, -11544.1, 1929.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (64.9, -12214.1, 1929.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-101.26, 4073.6, 395.38), (358.22, 319.03, -1.95), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8D4D0FC4DC081393029118408C4C104619", "_encstr_AB07034CE0", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-8101.81, 10202.1, 976), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_AB07034CE0", "_encstr_8D070326DC", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7446.2, 9305.3, 2849.67), undefined, undefined, undefined, undefined, undefined, "_encstr_990703AAEB", undefined, undefined, 512, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3316.2, 6425.3, 2475.67), undefined, undefined, undefined, undefined, undefined, "_encstr_AB07038CC4", undefined, undefined, 1028, 750, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_0[[var_3]](var_4, var_1, var_2, (-1726.2, 5291.3, 2073.67), (0, 324, 0), undefined, undefined, undefined, undefined, "_encstr_83070312DB", undefined, undefined, 1028, 500, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5156.2, 7827.3, 2849.67), undefined, undefined, undefined, undefined, undefined, "_encstr_990703B2F9", undefined, undefined, 1028, 1000, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3575.12, 349.5, 823.94), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3707.46, 2065.67, 1792), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5970.81, 1875.27, 1992), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3514.47, 5241.45, 431.13), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6349.79, 5426.6, 448), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4575.17, 7040.46, 448), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-719.69, 6569.75, 447.56), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2336.17, 5241.53, 446.61), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (628.69, -862.38, 628.84), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (133.51, 97.09, 774), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1070.88, 956.72, 778.72), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-763.92, 1686.84, 1499.89), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2051.73, 1630.18, 796.17), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1829.78, 2893.07, 890.03), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2662.31, 2893.28, 798.14), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3106.09, 3620.54, 837.77), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (26.78, 3360.79, 784), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (650.5, 4126.6, 1164.75), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-642.69, 503.78, 779.84), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1327.48, -692.14, 802.24), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2408.8, -536.62, 734.14), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3432.71, -996.92, 1196), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6791.17, -1098.27, 433.72), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6600.13, 3693.35, 500.15), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (10360.6, 2134.1, 390.33), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (9876.09, -2375.45, 419.03), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1255.39, -7163.99, 386.56), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4466.32, -5490.93, 415.03), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (826, -600, 2056), undefined, "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2502, -600, 2056), undefined, "_encstr_A78C062CD58E7B0D", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (570, 4008, 2056), undefined, "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1990, 4008, 2056), undefined, "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}