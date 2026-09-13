/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3767beb9dd6a7b4a.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_t_reflex_game_of_summer_createscript")) {
    return;
  }
  scripts\engine\utility::flag_init("mp_t_reflex_game_of_summer_createscript");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_t_reflex_game_of_summer_createscript");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "stk";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_t_reflex_game_of_summer_createscript");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_t_reflex_game_of_summer_createscript");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "un_signage_flag_wall_mount_01_legal";
  s.modelscale = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (404, 1728.5, 230), (0, 300, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "uk_decor_piccadilly_flag_pole_01";
  s.modelscale = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (410, 803.5, 230), (0, 150, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "un_signage_flag_wall_mount_01_kastovia";
  s.modelscale = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-364, 803.5, 230), (0, 240, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "un_signage_flag_wall_mount_01_usa";
  s.modelscale = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1172, 803.5, 230), (0, 240, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "un_signage_flag_wall_mount_01_ukraine";
  s.modelscale = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-364, 1728.5, 230), (0, 300, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "un_signage_flag_wall_mount_01_aq";
  s.modelscale = "1";
  s.receivevolumedecals = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1172, 1728.5, 230), (0, 300, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "uk_decor_pub_banner_flags_02";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (794, 1380, 425), (0, 90, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "uk_decor_pub_banner_flags_02";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-358.5, 1280, 425), (0, 270, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "uk_decor_pub_banner_flags_02";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-744.5, 1252, 425), (0, 90, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "uk_decor_pub_banner_flags_02";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1175, 1272, 425), (0, 270, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-527.93, 1250.23, 18), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.4");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "storage_shipping_container_20ft_closed_red";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-591, 1451, 9), (0, 330, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1090.5, 1266.5, 428), (0, 0, 180), "trial_end_flares", undefined, "0.75");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1005.5, 1266.5, 428), (0, 0, 180), "trial_end_flares");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-541.5, 1266.5, 428), (0, 0, 180), "trial_end_flares", undefined, "0.25");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (178.5, 1266.5, 428), (0, 0, 180), "trial_end_flares", undefined, "0.5");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-453.5, 1272.5, 50), (0, 0, 0), "trial_flames");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-745.5, 1542.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "3");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-743.5, 974.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "3");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (24.5, 1542.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "2");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (26.5, 934.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "2");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (792.5, 1542.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "1");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (794.5, 950.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "1");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "storage_shipping_container_20ft_closed_lm_yellow";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-632.5, 1268.16, 112), (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "storage_shipping_container_20ft_closed_lm_blue";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-584, 1095, 9), (0, 30, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "ee_buildings_industrial_radiotower_01_satellite_dish_big";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-432, 1268, 10), (45, 360, -90));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-531.93, 1274.23, 28), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.5");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-529.51, 1224.83, 8), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.25");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-531.93, 1298.23, 18), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.4");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "misc_wm_flarestick";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-537.51, 1322.83, 8), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.25");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (0, 0, 0));
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
}