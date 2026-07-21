/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_petrograd\cp_sv_petrograd_create_script.gsc
*********************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_959E1EFF91C05B1E99530F530B405703A7C187673D75A2D4A09E829E6358889B")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_959E1EFF91C05B1E99530F530B405703A7C187673D75A2D4A09E829E6358889B");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_959E1EFF91C05B1E99530F530B405703A7C187673D75A2D4A09E829E6358889B");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1, "_encstr_959E1EFF91C05B1E99530F530B405703A7C187673D75A2D4A09E829E6358889B");
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_959E1EFF91C05B1E99530F530B405703A7C187673D75A2D4A09E829E6358889B");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_959E1EFF91C05B1E99530F530B405703A7C187673D75A2D4A09E829E6358889B");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_create_script_utility::strike_additem;
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (306.46, -3370.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_864C02F9", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4396.63, -5985.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_88520840BAB5F918BF78";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (284.98, -2034.66, 259.5), (2.56, 89.79, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8FC30EF98952C602C77BE68FF1648A18", "_encstr_A74C0222", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2211.66, -7488.32, 1105.08), (1, 0, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A74C0222", "_encstr_A34C02BB", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (306.46, -3858.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_914C02DC", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1290.04, -6636.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_A14C023B", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (220.96, -4341.7, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_8F4C026A", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5367.63, -12782.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2493.5, -2766, 2056), undefined, "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-600.5, -2438, 2056), undefined, "_encstr_A78C062CD58E7B0D", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2381.5, 2580, 2056), undefined, "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (21.5, 2664, 2056), undefined, "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-695.43, -1499.57, 851), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (71.96, -4820.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_B84C027E", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-321.04, -5468.2, 1982.42), undefined, undefined, undefined, undefined, undefined, "_encstr_AC4C024A", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1664.92, 2403.97, 1191.76), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "_encstr_A5070398D8", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_93230F29863BDBDB7F7718F03B9AF01BE3";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (1900.98, 1153.34, 256), (359.16, 289.76, 2.5), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_A1E6141B27FBFA20923A69C68BE172ACEACF7FE6A61B", "_encstr_AF0703133A", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1011.93, 6180.2, 940), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_AF0703133A", "_encstr_8B4C0227", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1276.31, 2832.14, 1351.18), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "_encstr_8607036335", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-388.99, 5202.11, 1673.28), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "_encstr_9A07034C89", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (871.72, 3297.22, 1470.06), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "_encstr_8B070326D0", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (549.26, 3697.39, 1661.01), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "_encstr_A90703297F", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (242.58, 4156.32, 1755.3), (1.69, 210, 3.83), undefined, undefined, undefined, undefined, "_encstr_8C0703491D", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2652.66, -1603.08, 1228.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "_encstr_8607036732", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (1795.02, -1618.84, 258), (2.56, 179.46, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AF10159EBD0ACBFF9EBF62AA97F089B322D0669720FE03", "_encstr_A707037D2E", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7085.41, -4237.67, 1101.08), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A707037D2E", "_encstr_A30703C216", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3184.65, -1605.9, 1402.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "_encstr_AF0703537A", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6826.56, -2957.62, 1680.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "_encstr_A10703AF6B", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4142.65, -1648.75, 1582.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "_encstr_8D070366C0", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4650.73, -1765.57, 1642.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "_encstr_AF07037378", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5552.63, -2024.52, 1654.42), (0, 89.67, 0), undefined, undefined, undefined, undefined, "_encstr_9A07038CC1", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2274.2, 296.46, 1214.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_AA07038618", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (1699.16, 646.48, 256), (2.56, 179.79, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8B6A1B8DAA9F2BF20E8F0567E346E89904B0AD9E21237B6FC7DBF887A2", "_encstr_AD07031F3A", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (10843.3, 884.84, 1402.08), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_AD07031F3A", "_encstr_9707038698", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4234.2, -307.54, 1294.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_8107037F7F", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (10298.2, -137.54, 1454.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_850703EA5F", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5856.2, -747.54, 1470.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_88070375E3", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7900.2, -1077.54, 1470.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_960703127A", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (9254.2, -735.54, 1470.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_87070324D5", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3866.2, 68.46, 1294.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_BE0703F3E3", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3434.2, 316.46, 1294.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_9207032493", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2986.2, 508.46, 1294.42), (0, 90, 0), undefined, undefined, undefined, undefined, "_encstr_82070322E1", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5068.63, -4057.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5572.63, -2193.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5828.63, 390.9, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5660.63, 2622.9, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4948.63, 4502.9, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3524.63, 6230.9, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1396.63, 7110.9, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (715.37, 7230.9, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2987.37, 7110.9, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-425.66, -2723.68, 1041), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4451.37, 6950.9, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-498.75, 2519.17, 1091.52), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2516.63, -7049.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-580.63, -7425.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1715.37, -7233.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3483.37, -6513.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5307.37, -5393.1, 2081.71), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-580.87, 701.94, 945.96), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1292.49, 1423.17, 1024.84), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1022.63, 114.63, 867.76), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1342.46, -1980, 1045.76), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (3669.02, 876.89, 279.76), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2413.49, 2495.85, 1193.82), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_A30703DE22", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (1048.66, 2742.98, 432), (2.61, 156.77, -0.34), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AC7615EF2FB0A3BB608BB2390DDB58EB724A9596292542", "_encstr_BE0703B3E6", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7512.29, 7469.61, 960), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_BE0703B3E6", "_encstr_9207032597", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (2914.77, 2609.33, 1384.28), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_8F070362BF", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (7263.17, 6192.99, 1950.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_8E0703AD0B", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (4155.41, 2991.7, 1614.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_9107039BC6", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (5776.93, 3801.92, 1949.49), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_AC0703DB66", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (6826.06, 4769.31, 1949.71), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_B80703C3D4", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (996.24, 3915.13, 1396.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_B20703B664", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_88520840BAB5F918BF78";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (465.02, 2666.66, 260), (2.56, 245.79, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_844B154D72106389041B23106C9908C6D004B1A9408D63", "_encstr_B107031B8F", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1750.2, 8444.26, 1360.08), (1, 156, -0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_B107031B8F", "_encstr_9307031341", undefined, undefined, 512, 60, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1188.73, 4344.93, 1578.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_B40703B3C3", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (-57.38, 7735.33, 1982.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_BA070303AB", undefined, undefined, 512, 55, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1302.47, 4892.56, 1718.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_B60703CFCF", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (1350.84, 5527.87, 1838.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_A20703AC8B", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\cp_create_script_utility::s();
  var_0[[var_3]](var_4, var_1, var_2, (964.71, 6584.6, 1982.42), (0, 156, 0), undefined, undefined, undefined, undefined, "_encstr_950703C664", undefined, undefined, 512, 45, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}