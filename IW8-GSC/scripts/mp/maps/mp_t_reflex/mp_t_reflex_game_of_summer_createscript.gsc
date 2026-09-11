/***********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_t_reflex\mp_t_reflex_game_of_summer_createscript.gsc
***********************************************************************************/

function main(var_0, var_1) {
  if(scripts\engine\utility::flag_exist("mp_t_reflex_game_of_summer_createscript")) {
    return;
  }

  scripts\engine\utility::flag_init("mp_t_reflex_game_of_summer_createscript");
  var_2 = spawnStruct();
  thread cs_return_and_wait_for_flag(level, var_1, var_2);

  if(!scripts\cp\so_trigger::cs_is_starttime()) {
    scripts\cp\so_trigger::endcreatescript(var_2);
    return;
  }
}

function cs_return_and_wait_for_flag(var_0, var_1, var_2) {
  level endon("game_ended");
  scripts\cp\so_trigger::wait_for_cs_flag(var_2);

  if(!isDefined(var_0)) {
    var_0 = "stk";
  }

  var_1 scripts\cp\so_trigger::initbunkerdoor(var_0, "mp_t_reflex_game_of_summer_createscript");
  scripts\cp\so_trigger::initbunkerbackwallkeypads(var_1);
  thread createstructs(level, var_1, var_0);
  level thread scripts\cp\so_trigger::wait_for_flags(var_1, "mp_t_reflex_game_of_summer_createscript");
}

function createstructs(var_0, var_1, var_2) {
  var_3 = &scripts\cp\so_trigger::strike_additem;
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "un_signage_flag_wall_mount_01_legal";
  var_4.modelscale = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (404, 1728.5, 230), (0, 300, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "uk_decor_piccadilly_flag_pole_01";
  var_4.modelscale = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (410, 803.5, 230), (0, 150, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "un_signage_flag_wall_mount_01_kastovia";
  var_4.modelscale = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-364, 803.5, 230), (0, 240, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "un_signage_flag_wall_mount_01_usa";
  var_4.modelscale = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (1172, 803.5, 230), (0, 240, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "un_signage_flag_wall_mount_01_ukraine";
  var_4.modelscale = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (-364, 1728.5, 230), (0, 300, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "un_signage_flag_wall_mount_01_aq";
  var_4.modelscale = "1";
  var_4.receivevolumedecals = "1";
  var_0[[var_3]](var_4, var_1, var_2, (1172, 1728.5, 230), (0, 300, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "uk_decor_pub_banner_flags_02";
  var_0[[var_3]](var_4, var_1, var_2, (794, 1380, 425), (0, 90, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "uk_decor_pub_banner_flags_02";
  var_0[[var_3]](var_4, var_1, var_2, (-358.5, 1280, 425), (0, 270, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "uk_decor_pub_banner_flags_02";
  var_0[[var_3]](var_4, var_1, var_2, (-744.5, 1252, 425), (0, 90, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "uk_decor_pub_banner_flags_02";
  var_0[[var_3]](var_4, var_1, var_2, (1175, 1272, 425), (0, 270, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-527.93, 1250.23, 18), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.4");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "storage_shipping_container_20ft_closed_red";
  var_0[[var_3]](var_4, var_1, var_2, (-591, 1451, 9), (0, 330, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (1090.5, 1266.5, 428), (0, 0, 180), "trial_end_flares", undefined, "0.75");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-1005.5, 1266.5, 428), (0, 0, 180), "trial_end_flares");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-541.5, 1266.5, 428), (0, 0, 180), "trial_end_flares", undefined, "0.25");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (178.5, 1266.5, 428), (0, 0, 180), "trial_end_flares", undefined, "0.5");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-453.5, 1272.5, 50), (0, 0, 0), "trial_flames");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-745.5, 1542.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "3");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-743.5, 974.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "3");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (24.5, 1542.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "2");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (26.5, 934.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "2");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (792.5, 1542.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "1");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (794.5, 950.5, 426), (0, 0, 180), "trial_celebration_flares", undefined, "1");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "storage_shipping_container_20ft_closed_lm_yellow";
  var_0[[var_3]](var_4, var_1, var_2, (-632.5, 1268.16, 112), (0, 0, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "storage_shipping_container_20ft_closed_lm_blue";
  var_0[[var_3]](var_4, var_1, var_2, (-584, 1095, 9), (0, 30, 0));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "ee_buildings_industrial_radiotower_01_satellite_dish_big";
  var_0[[var_3]](var_4, var_1, var_2, (-432, 1268, 10), (45, 360, -90));
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-531.93, 1274.23, 28), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.5");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-529.51, 1224.83, 8), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.25");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-531.93, 1298.23, 18), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.4");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_4.model = "misc_wm_flarestick";
  var_0[[var_3]](var_4, var_1, var_2, (-537.51, 1322.83, 8), (0, 8, 0), "trial_end_flares", "big_red_vfx", "0.25");
  var_4 = scripts\cp\so_trigger::s();
  var_4.is_cs_model = 1;
  var_0[[var_3]](var_4, var_1, var_2, (0, 0, 0));
  var_0 scripts\engine\utility::ent_flag_set("cs_objects_created");
}