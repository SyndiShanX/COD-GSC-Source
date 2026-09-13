/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_64a639faefa63bc3.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_wartorn_gw_battlemap_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_wartorn_gw_battlemap_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_wartorn_gw_battlemap_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_wartorn_gw_battlemap_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_wartorn_gw_battlemap_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7211.64, 31393.9, 281.81), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7154.47, 31494.1, 265.89), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7090.66, 31498.6, 260.69), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7026.82, 31503, 255.71), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6963, 31507.5, 251.32), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7128.86, 31781.2, 255.05), (0, 110, 0), "battlemap_sd", undefined, "sd_bomb_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7115.21, 31713.8, 257.72), (0, 110, 0), "battlemap_hr", undefined, "hr_extraction_zone");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6899.15, 31511.9, 247.66), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7147.81, 31398.3, 278.18), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7083.99, 31402.8, 272.01), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7020.15, 31407.2, 266.31), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7218.39, 31489.6, 270.67), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6956.25, 31411.8, 261.78), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7211.64, 31393.9, 281.81), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7292.93, 37110.3, 494.96), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7356.93, 37110.3, 479.7), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6931.14, 37071, 491.8), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6995.14, 37071, 507.35), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7059.13, 37071, 522.92), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7292.93, 37206.3, 492.39), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7356.94, 37206.3, 477.5), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6931.13, 37167, 480.72), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7228.93, 37110.3, 510.32), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6995.14, 37167, 495.23), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7059.14, 37167, 510.61), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 10000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-11346, 38564, 254), (0, 0, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7154.47, 31494.1, 265.89), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7090.66, 31498.6, 260.69), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7026.82, 31503, 255.71), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6963, 31507.5, 251.32), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6899.15, 31511.9, 247.66), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7147.81, 31398.3, 278.18), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7083.99, 31402.8, 272.01), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7020.15, 31407.2, 266.31), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7218.39, 31489.6, 270.67), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6956.25, 31411.8, 261.78), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6892.41, 31416.2, 258.34), (0, 94, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6892.41, 31416.2, 258.34), (0, 94, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7228.94, 37206.3, 508.16), (0, 270, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7292.93, 37110.3, 494.96), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7356.93, 37110.3, 479.7), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6931.14, 37071, 491.8), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6995.14, 37071, 507.35), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7059.13, 37071, 522.92), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7292.93, 37206.3, 492.39), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7356.94, 37206.3, 477.5), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6931.13, 37167, 480.72), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7228.93, 37110.3, 510.32), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6995.14, 37167, 495.23), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7059.14, 37167, 510.61), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7228.94, 37206.3, 508.16), (0, 270, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5990.82, 35474.1, 400.09), (0, 100, 0), "battlemap_hr", undefined, "hostage_a");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5990.82, 35474.1, 400.09), (0, 100, 0), "battlemap_sd", undefined, "sd_bombzone_a");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7366.64, 34693.7, 270.15), (0, 90, 0), "battlemap_sd", undefined, "sd_bombzone_b");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7366.64, 34693.7, 270.15), (0, 90, 0), "battlemap_hr", undefined, "hostage_b");
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 9000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-12098, 38502, 254), (360, 90, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 10000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3708, 38518, 254), (360, 0, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 10000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2956, 29590, 254), (360, 270, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  s.is_cs_script_origin = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13312, 28672, 250), undefined, "minimap_corner", undefined, "locale_127", undefined, undefined, undefined, undefined, 1000);
  s = scripts\common\create_script_utility::s();
  s.is_cs_script_origin = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2048, 39936, 250), undefined, "minimap_corner", undefined, "locale_127", undefined, undefined, undefined, undefined, 1000);
  s = scripts\common\create_script_utility::s();
  s.is_cs_script_origin = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7592, 33896, 3792), (0, 0, 0), "airstrikeheight", undefined, "locale_127", undefined, undefined, undefined, undefined, 1000);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15456, 23200, 2888), (0, 45, 0), "ks_heli_entrance", undefined, "locale_127", "cspf_0_6", undefined, undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  s.script_linkto = "9";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9000, 31376, 2632), undefined, "ks_heli_goal", undefined, "locale_127", undefined, "cspf_0_6", undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  s.script_linkto = "6";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10040, 35744, 2632), undefined, "ks_heli_goal", undefined, "locale_127", undefined, "cspf_0_13", undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  s.script_linkto = "13";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5832, 36544, 2632), undefined, "ks_heli_goal", undefined, "locale_127", undefined, "cspf_0_11", undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  s.script_linkto = "11";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5192, 32304, 2632), undefined, "ks_heli_goal", undefined, "locale_127", undefined, "cspf_0_9", undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16992, 40712, 2888), (0, 346, 0), "ks_heli_entrance", undefined, "locale_127", "cspf_0_13", undefined, undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1248, 41496, 2888), (0, 188, 0), "ks_heli_entrance", undefined, "locale_127", "cspf_0_11", undefined, undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2000, 27056, 2888), (0, 168, 0), "ks_heli_entrance", undefined, "locale_127", "cspf_0_9", undefined, undefined, undefined, 256);
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}