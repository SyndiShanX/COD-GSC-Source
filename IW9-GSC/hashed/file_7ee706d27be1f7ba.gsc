/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7ee706d27be1f7ba.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_sealion_locked_spaces_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_sealion_locked_spaces_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_sealion_locked_spaces_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_sealion_locked_spaces_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_sealion_locked_spaces_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6231, -2536, 596.25), (0, 90, 0), "cspf_0_auto3", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5117.25, -107.69, 997.75), (0, 100.9, 0), "cspf_0_auto15676", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5390, -443.55, 994), (0, 190.3, 0), "cspf_0_auto15676", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6305, -2724, 656), (0, 0, 0), "cspf_0_auto3", undefined, "window_cover_set_metal_mesh_bars_96_khaki");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6231, -2938, 596.25), (0, 270, 0), "cspf_0_auto3", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6268, -2801, 596.5), (0, 8, 0), "cspf_0_auto3", undefined, "notebook");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6271, -2783, 598), (0, 0, 0), "cspf_0_auto3", undefined, "key");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6208, -2784, 1153.25), undefined, "sealion_water_treatment_control_center", "cspf_0_auto3", "lockedSpace");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5490.5, -219.96, 1004), (270, 0, 0), "cspf_0_auto15676", undefined, "note");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5222.12, -149.01, 1004.23), (0, 260.72, 0), "cspf_0_auto15676", undefined, "key");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5136, -224, 1545.25), (0, 150, 0), "sealion_hotel_room_403", "cspf_0_auto15676", "lockedSpace");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5438, -451.55, 994), (0, 190.3, 0), "cspf_0_auto15676", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (3939, 70, 257), (0, 98.4, 0), "lockedCache", undefined, "sealion_couple_fight_bag");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2954, 4926, 644), (0, 252.6, 0), "lockedCache", undefined, "sealion_farmers_toolbox");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2279, -4753, 1316), (0, 265.8, 0), "lockedCache", undefined, "sealion_shadow_company_toolbox");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-224, -7152, 1090), (5.69, 3, 12.67), "lockedCache", undefined, "sealion_misplaced_crate");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13083, 1488, 448.25), (0, 210, 0), "cspf_0_auto15693", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-12891, 1830, 448.25), (0, 30, 0), "cspf_0_auto15693", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13099, 1588, 434.5), (270, 0, -36.7), "cspf_0_auto15693", undefined, "note");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-12978.5, 1830, 445.75), (0, 0, 0), "cspf_0_auto15693", undefined, "key");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13016, 1432, 1049.25), (0, 270, 0), "sealion_beach_club_bathroom", "cspf_0_auto15693", "lockedSpace");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1657, -4960, 1335), (0, 46, 0), "lockedCache", undefined, "sealion_castle_armory");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1693, -4922, 1335), (0, 46, 0), "lockedCache", undefined, "sealion_castle_armory");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1729, -4888, 1335), (0, 44, 0), "lockedCache", undefined, "sealion_castle_armory");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4989, -196, 567), (0, 100, 0), "lockedCache", undefined, "sealion_hotel_workers_office_fridge");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2023, -15878, 232), (346, 298, 2), "lockedCache", undefined, "sealion_shipwreck_cargo_crate");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (13453, 6217, -242.35), (349.19, 86.02, -11.28), "lockedCache", undefined, "sealion_lost_travelers_bag");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (62.5, -3698, 175.06), (5.07, 1.23, -6.13), "lockedCache", undefined, "sealion_knocked_over_workers_toolbox");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16588, -2866.5, 52.72), (349.39, 12.12, 3.96), "lockedCache", undefined, "sealion_observatory_thrown_fridge");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3250, 448.5, 147.59), (0, 248.94, 0), "lockedCache", undefined, "sealion_town_canal_crate");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8092.5, -7293.5, 656.75), (359.08, 29.83, 0.32), "cspf_0_auto15700", undefined, "hardware_plywood_bare_01");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8035, -7062, 672.25), (0, 30, 0), "cspf_0_auto15700", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8154, -7043.75, 688.75), (359.8, 300.13, 2.26), "cspf_0_auto15700", undefined, "note");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8157.5, -7061, 670), (0, 345, 0), "cspf_0_auto15700", undefined, "key");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8132.5, -7155, 1049.25), (0, 270, 0), "sealion_port_managers_office", "cspf_0_auto15700", "lockedSpace");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7914.75, -10291.5, 800.25), (0, 30.2, 0), "cspf_0_auto15717", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-723.5, 7179, 417), (0, 60.36, 0), "cspf_0_auto15707", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-805, 7044.5, 376), (270, 0, 0), "cspf_0_auto15707", undefined, "note");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-776.25, 7163.5, 411.25), (0, 62.59, 90), "cspf_0_auto15707", undefined, "key");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-887.5, 7151.25, 1049.25), (0, 270, 0), "sealion_ferry_tourist_information_booth", "cspf_0_auto15707", "lockedSpace");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-883.49, 7163.44, 402.5), (0, 240.24, 0), "cspf_0_auto15707", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-906.25, 7123.5, 402.5), (0, 240.24, 0), "cspf_0_auto15707", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7831.25, -10549.2, 788.25), (0, 30.07, 0), "cspf_0_auto15717", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7862.25, -10512.2, 913.25), (0, 30.07, -72.6), "cspf_0_auto15717", undefined, "hardware_plywood_bare_01");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7886.25, -10406.8, 800.5), (0, 43.9, 0), "cspf_0_auto15717", undefined, "notebook");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8082.25, -10507.2, 799.25), (0, 0, 0), "cspf_0_auto15717", undefined, "key");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7952, -10400, 1353.25), (0, 180, 0), "sealion_port_harbor_control", "cspf_0_auto15717", "lockedSpace");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7952.5, -10619.5, 788.25), (0, 30.07, 0), "cspf_0_auto15717", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8143.25, -10289, 788.25), (0, 210.07, 0), "cspf_0_auto15717", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8022, -10218.8, 788.25), (0, 210.07, 0), "cspf_0_auto15717", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1374.5, 411, 712.25), (0, 140, 0), "cspf_0_auto15727", undefined, "lockMe");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1500, 199.75, 698), (0, 320, 0), "cspf_0_auto15727", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1449.75, 264.75, 709.75), (273.93, 284.69, 34.38), "cspf_0_auto15727", undefined, "note");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1464.75, 170.25, 698), (0, 320, 0), "cspf_0_auto15727", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1414.75, 300, 707.75), (0, 0, 0), "cspf_0_auto15727", undefined, "key");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1400, 224, 1241.25), undefined, "sealion_lab_office", "cspf_0_auto15727", "lockedSpace");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1427, 137.75, 698), (0, 320, 0), "cspf_0_auto15727", undefined, "ee_window_bars_02_black");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1391.75, 108.25, 698), (0, 320, 0), "cspf_0_auto15727", undefined, "ee_window_bars_02_black");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}