/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_sv_bigstore\cp_sv_bigstore_create_script.gsc
*******************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::flag_exist("_encstr_8B921D5EBF37BBE67E8807372833A7F32B402692ADF3033D8618177B80EB74")) {
    return;
  }
  scripts\engine\utility::flag_init("_encstr_8B921D5EBF37BBE67E8807372833A7F32B402692ADF3033D8618177B80EB74");
  var_2 = spawnStruct();
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_8B921D5EBF37BBE67E8807372833A7F32B402692ADF3033D8618177B80EB74");

  if(!scripts\cp\so_trigger::cs_is_starttime())
    scripts\cp\so_trigger::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\so_trigger::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  var_2 scripts\cp\so_trigger::strike_setup_arrays(var_1, "_encstr_8B921D5EBF37BBE67E8807372833A7F32B402692ADF3033D8618177B80EB74");
  scripts\cp\so_trigger::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_8B921D5EBF37BBE67E8807372833A7F32B402692ADF3033D8618177B80EB74");
  else
    scripts\cp\so_trigger::wait_for_flags(var_2, "_encstr_8B921D5EBF37BBE67E8807372833A7F32B402692ADF3033D8618177B80EB74");
}

createstructs(var_0, var_1, var_2) {
  var_3 = scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1198.67, -3144.2, 3076), (0, 314, 0), "_encstr_8B8C06E68B0B6751", "_encstr_998C06F8A3EB27BB", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (193.39, -12980, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1176.65, -3442.71, 3076), (0, 314, 0), "_encstr_A78C062CD58E7B0D", "_encstr_8B8C06E68B0B6751", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1650.47, 1752, 3076), (0, 314, 0), "_encstr_998C06F8A3EB27BB", "_encstr_9B8C06A74B53CF6B", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-632.5, 2004, 3076), (0, 314, 0), "_encstr_9B8C06A74B53CF6B", "_encstr_A78C062CD58E7B0D", "_encstr_A37A0C630B892AE72801FE02F9C8", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (865.69, 3142.73, 1707.1), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_A60703EF2B", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-530.16, 2897.52, 694), (2.29, 180.47, 1.3), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_A7C924936AE15C1A39A2E3516CD286670EC2BFC06A17C0D10ABA6A222BFE29BAF6D7B60960A9", "_encstr_A607031F0B", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (5614.33, 8320.51, 644.9), (0.28, 0.97, -0.68), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_A607031F0B", "_encstr_B60703DFAF", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1324.34, 3337.42, 1932.7), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B20703B8E7", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2806.03, 4609.97, 2492.7), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_A207032C8F", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1741.66, 3582.87, 2123.9), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_840703171A", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2144.24, 3882.71, 2314.4), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_9607030A1A", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2501.78, 4240.41, 2496.5), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_880703F460", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (424.96, 2997.08, 1558.9), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B607032FBF", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-31.69, 2907.61, 1426.1), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B4070330C1", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-266.66, 4551.8, 853.8), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3458.42, -6076.06, 791.9), (0, 165, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-951.82, -4655.04, 1707.1), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_8B0703C6E4", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_4.script_demeanor = "_encstr_8B1608EC43B8D647A113";
  var_4.script_function = "_encstr_AF4616B92E4BAF6BDFA349676568FA83B9EF67E0E15FB728";
  var_4.script_goalyaw = "_encstr_A34C02BB";
  var_4.script_team = "_encstr_8E8405EA382B2A";
  var_4.script_unload = "_encstr_8B1608EC43B8D647A113";
  var_0[[var_3]](var_4, var_1, var_2, (-1148.16, -3251.48, 694), (2.29, 88.46, 1.3), "_encstr_842112BBB0CE59BED9561AF56E1C58BBE65627CD", undefined, "_encstr_8B1608EC43B8D647A113", "_encstr_AF3E248D61B88287C8C592120D1E12CEEB464A52724A5C5E776B7ADB506A6431E88B63116291", "_encstr_B107031B8F", undefined, undefined, 450, undefined, 40);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4057.1, -9581.48, 644.9), (0.28, 268.97, -0.68), "_encstr_A5390DA3CBC96AA768E3BE0318E0B2", undefined, undefined, "_encstr_B107031B8F", "_encstr_9307031341", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-773.24, -5120.2, 1932.7), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_8607036D38", undefined, undefined, 512, 35, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (446.83, -6645.4, 2492.7), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B60703CFCF", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-542.5, -5545.84, 2123.9), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_A607030F8B", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-256.9, -5958.64, 2314.4), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B20703B664", undefined, undefined, 512, 40, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (88.11, -6328.44, 2496.5), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B40703B3C3", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3115.68, -610.9, 973), undefined, "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-2979.11, -1039.3, 865.8), (0, 75, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (154.28, -843.01, 1349), (0, 75, 0), "_encstr_A9B61A3495C6A536DBE0D12BE4EBC63916E60DEB63DBD8163A2DF6CD", undefined, undefined, undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (7249.39, -12156, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (13361.4, -5780, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (14865.4, 3036, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (12601.4, 9908, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (6721.4, 12844, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1065.4, 12892, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-6086.6, 12052, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-11462.6, 7324, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-13118.6, 876, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-12998.6, -3740, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-11046.6, -8468, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-7486.6, -13692, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-3478.6, -14252, 1229), (0, 198, 0), "_encstr_8CC80AA0A5312A895DF871B4", undefined, "_encstr_970D094917423528F5CD31", undefined, undefined, undefined, undefined, 1024, undefined, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1081.99, -4209.49, 1558.9), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B20703B767", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (-1155.47, -3750, 1426.1), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_840703E71E", undefined, undefined, 512, 30, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1036.37, -7178.47, 2483.1), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_A20703AC8B", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (1940.06, -7882.67, 2468.9), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_950703C664", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (2971.67, -8591.39, 2453.2), (0.68, 358.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_BA070303AB", undefined, undefined, 512, 50, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3318.2, 5217.76, 2483.1), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B107035B8C", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (3990.44, 6145.48, 2468.9), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_B40703F3C3", undefined, undefined, 512, 45, undefined);
  var_4 = scripts\cp\so_trigger::s();
  var_0[[var_3]](var_4, var_1, var_2, (4662.72, 7201.19, 2453.2), (0.68, 90.64, 0.27), undefined, undefined, undefined, undefined, "_encstr_950703E668", undefined, undefined, 512, 50, undefined);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}