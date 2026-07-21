/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_village2\cp_sv_village2_create_script.gsc
*******************************************************************/

main(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("_encstr_A2141DC2FB583763F9E57974F920EFD756B65A5B212F639F21176B52EBD073")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_A2141DC2FB583763F9E57974F920EFD756B65A5B212F639F21176B52EBD073");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_1, var_2, "_encstr_A2141DC2FB583763F9E57974F920EFD756B65A5B212F639F21176B52EBD073");

  if(!scripts\cp\so_trigger::cs_is_starttime())
    scripts\cp\so_trigger::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp\so_trigger::wait_for_cs_flag(var_2);

  if(!isDefined(var_0))
    var_0 = "_encstr_B81904B98E5B";

  var_1 scripts\cp\so_trigger::initbunkerdoor(var_0, "_encstr_A2141DC2FB583763F9E57974F920EFD756B65A5B212F639F21176B52EBD073");
  scripts\cp\so_trigger::initbunkerbackwallkeypads(var_1);
  level thread createstructs(var_1, var_0, var_2);
  level thread scripts\cp\so_trigger::wait_for_flags(var_1, "_encstr_A2141DC2FB583763F9E57974F920EFD756B65A5B212F639F21176B52EBD073");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2858.04, -5807.33, 1088.85), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1245.33, -2424.2, 2472), (0, 314, 0), "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-994.65, 2325.29, 2472), (0, 314, 0), "_encstr_A78C062CD58E7B0D", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1698.47, -2975.99, 2472), (0, 314, 0), "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (913.5, 3020, 2472), (0, 314, 0), "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1548, -27432, 3168), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-23676, -4520, 1466), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1096.54, -2601.7, 2398.42), undefined, undefined, undefined, undefined, undefined, "_encstr_864C02F9", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_88520840BAB5F918BF78";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-824.02, -1832.16, 555.5), (2.56, 11.79, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_8FC30EF98952C602C77BE68FF1648A18", "_encstr_A74C0222", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3614.66, -6719.82, 1521.08), (1, 0, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A74C0222", "_encstr_A34C02BB", undefined, undefined, 512, 55);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1096.54, -3089.7, 2398.42), undefined, undefined, undefined, undefined, undefined, "_encstr_914C02DC", undefined, undefined, 512, 30);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2693.04, -5868.2, 2398.42), undefined, undefined, undefined, undefined, undefined, "_encstr_A14C023B", undefined, undefined, 512, 55);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1182.04, -3573.2, 2398.42), undefined, undefined, undefined, undefined, undefined, "_encstr_8F4C026A", undefined, undefined, 512, 30);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1331.04, -4051.7, 2398.42), undefined, undefined, undefined, undefined, undefined, "_encstr_B84C027E", undefined, undefined, 512, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1724.04, -4699.7, 2398.42), undefined, undefined, undefined, undefined, undefined, "_encstr_AC4C024A", undefined, undefined, 512, 45);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2131.98, 4430.75, 246.84), (0, 125, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1874.57, 4718.47, 668.55), (0, 170, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3377.78, -2841.32, 678.66), (0, 310, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-27.53, 4373.41, 533.37), (0, 235, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3568.94, 1333.97, 272.14), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3331.59, 636.76, 648.82), (0, 90, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2707.05, -1199.64, 970.71), (0, 280, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1760.25, -3101.71, 1748.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_8607036732", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (798.37, -2689.27, 600), (2.56, 139.46, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AF10159EBD0ACBFF9EBF62AA97F089B322D0669720FE03", "_encstr_A707037D2E", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3118.75, -8076.12, 1621.08), (0, 316, 0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A707037D2E", "_encstr_A30703C216", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2140.97, -3473.29, 1922.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_AF0703537A", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3821.75, -6975.52, 2200.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_A10703AF6B", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2800.33, -4169.59, 2102.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_8D070366C0", undefined, undefined, 512, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3084.66, -4606.57, 2162.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_AF07037378", undefined, undefined, 512, 45);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3553.55, -5419.36, 2174.42), (0, 45.67, 0), undefined, undefined, undefined, undefined, "_encstr_9A07038CC1", undefined, undefined, 512, 50);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2508.49, 392.35, 1681.82), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_A30703DE22", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (1217.66, 565.48, 636), (2.61, 214.77, -0.34), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AC7615EF2FB0A3BB608BB2390DDB58EB724A9596292542", "_encstr_BE0703B3E6", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7607.29, 5366.11, 1448), undefined, "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_BE0703B3E6", "_encstr_9207032597", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3009.77, 505.83, 1872.28), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_8F070362BF", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (24544, 6788, 1618), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1790, 34712, 3548), undefined, "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7358.17, 4089.49, 2438.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_8E0703AD0B", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4250.41, 888.2, 2102.75), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_9107039BC6", undefined, undefined, 512, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5871.93, 1698.42, 2437.49), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_AC0703DB66", undefined, undefined, 512, 45);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6921.06, 2665.81, 2437.71), (359.04, 67.02, -0.05), undefined, undefined, undefined, undefined, "_encstr_B80703C3D4", undefined, undefined, 512, 50);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-318.79, 2541.65, 1786.42), (0, 210, 0), undefined, undefined, undefined, undefined, "_encstr_B20703B664", undefined, undefined, 512, 30);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_type = "_encstr_88520840BAB5F918BF78";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (135.72, 1877.07, 544), (2.56, 349.79, 0.62), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_844B154D72106389041B23106C9908C6D004B1A9408D63", "_encstr_B107031B8F", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-5597.25, 2981.9, 1750.08), (1, 210, -0), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_B107031B8F", "_encstr_9307031341", undefined, undefined, 512, 60);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-553.36, 2950.01, 1968.42), (0, 210, 0), undefined, undefined, undefined, undefined, "_encstr_B40703B3C3", undefined, undefined, 512, 30);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-4028.7, 3934.72, 2372.42), (0, 210, 0), undefined, undefined, undefined, undefined, "_encstr_BA070303AB", undefined, undefined, 512, 55);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-929.54, 3363.92, 2108.42), (0, 210, 0), undefined, undefined, undefined, undefined, "_encstr_B60703CFCF", undefined, undefined, 512, 35);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1415.09, 3776.48, 2228.42), (0, 210, 0), undefined, undefined, undefined, undefined, "_encstr_A20703AC8B", undefined, undefined, 512, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2496.96, 4085.22, 2372.42), (0, 210, 0), undefined, undefined, undefined, undefined, "_encstr_950703C664", undefined, undefined, 512, 45);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_AF75130BBE1E378A8B0A3FE55B7199FA8DC6FC055D");
}