/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_743a16b8d6ebc974.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_fishtown_gw_battlemap_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_fishtown_gw_battlemap_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_fishtown_gw_battlemap_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_fishtown_gw_battlemap_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_fishtown_gw_battlemap_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5607.65, -46986.8, 212.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5721.99, -46971.4, 206.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  s.is_cs_script_origin = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-6920, -47872, 4584), (0, 0, 0), "airstrikeheight", undefined, "locale_128", undefined, undefined, undefined, undefined, 1000);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5750.05, -46913.9, 206.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5778.1, -46856.4, 200.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5806.18, -46798.9, 200.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5907.99, -46956.1, 186.06), (0, 208, 0), "battlemap_sd", undefined, "sd_bomb_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4989, -46581.8, 196.97), (0, 198, 0), "battlemap_hr", undefined, "hr_extraction_zone");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5834.22, -46741.3, 200.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5635.71, -46929.3, 212.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5663.77, -46871.7, 212.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5691.83, -46814.3, 206.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5693.94, -47028.9, 218.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5719.88, -46756.8, 200.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5607.65, -46986.8, 212.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9479.7, -49314.9, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9443.91, -49367.9, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9408.12, -49421, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9372.31, -49474.1, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9336.52, -49527.2, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9559.26, -49368.6, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9523.47, -49421.6, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9487.7, -49474.7, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9515.47, -49261.8, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9451.91, -49527.7, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9416.13, -49580.8, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 10000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13499.4, -46155.2, 403.74), (0, 30.6, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5721.99, -46971.4, 206.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5750.05, -46913.9, 206.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5778.1, -46856.4, 200.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5806.18, -46798.9, 200.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5834.22, -46741.3, 200.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5635.71, -46929.3, 212.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5663.77, -46871.7, 212.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5691.83, -46814.3, 206.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5693.94, -47028.9, 218.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5719.88, -46756.8, 200.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5747.93, -46699.2, 194.52), (0, 206, 0), "battlemap_sd", undefined, "sd_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5747.93, -46699.2, 194.52), (0, 206, 0), "battlemap_hr", undefined, "hr_allied_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9595.05, -49315.5, 203.29), (0, 34, 0), "battlemap_hr", undefined, "hr_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9479.7, -49314.9, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9443.91, -49367.9, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9408.12, -49421, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9372.31, -49474.1, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9336.52, -49527.2, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9559.26, -49368.6, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9523.47, -49421.6, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9487.7, -49474.7, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9515.47, -49261.8, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9451.91, -49527.7, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9416.13, -49580.8, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9595.05, -49315.5, 203.29), (0, 34, 0), "battlemap_sd", undefined, "sd_axis_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7476.18, -49995.1, 166.74), (0, 163, 0), "battlemap_hr", undefined, "hostage_a");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7476.18, -49995.1, 166.74), (0, 163, 0), "battlemap_sd", undefined, "sd_bombzone_a");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8239.45, -47488.3, 184), (0, 163, 0), "battlemap_sd", undefined, "sd_bombzone_b");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8239.45, -47488.3, 184), (0, 163, 0), "battlemap_hr", undefined, "hostage_b");
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 12000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-11376.3, -44809.2, 522.74), (360, 88.9, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 10000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5794.32, -41034.1, 254.74), (0, 23, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 8000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2666.8, -49121.4, 6.74), (0, 308.1, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  s.is_cs_trigger = 1;
  s.height = 12000;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14088.3, -50237.2, 78.74), (360, 133.9, 90), "OutOfBounds", undefined, undefined, undefined, undefined, undefined, undefined, 1024);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14600, -58816, 3576), (0, 45, 0), "ks_heli_entrance", undefined, "locale_128", "cspf_0_6", undefined, undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  s.script_linkto = "9";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9856, -50456, 3320), undefined, "ks_heli_goal", undefined, "locale_128", undefined, "cspf_0_6", undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  s.script_linkto = "6";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10048, -46392, 3320), undefined, "ks_heli_goal", undefined, "locale_128", undefined, "cspf_0_13", undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  s.script_linkto = "13";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4904, -46568, 3320), undefined, "ks_heli_goal", undefined, "locale_128", undefined, "cspf_0_11", undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  s.script_linkto = "11";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4784, -50392, 3320), undefined, "ks_heli_goal", undefined, "locale_128", undefined, "cspf_0_9", undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16136, -41304, 3576), (0, 346, 0), "ks_heli_entrance", undefined, "locale_128", "cspf_0_13", undefined, undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-392, -40520, 3576), (0, 188, 0), "ks_heli_entrance", undefined, "locale_128", "cspf_0_11", undefined, undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.ishelistruct = 1;
  s.script_goalyaw = "true";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2856, -54960, 3576), (0, 168, 0), "ks_heli_entrance", undefined, "locale_128", "cspf_0_9", undefined, undefined, undefined, 256);
  s = scripts\common\create_script_utility::s();
  s.is_cs_script_origin = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3072, -53248, 4608), (0, 0, 0), "minimap_corner", undefined, "locale_128", undefined, undefined, undefined, undefined, 1000);
  s = scripts\common\create_script_utility::s();
  s.is_cs_script_origin = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-11264, -45056, 4608), (0, 0, 0), "minimap_corner", undefined, "locale_128", undefined, undefined, undefined, undefined, 1000);
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}