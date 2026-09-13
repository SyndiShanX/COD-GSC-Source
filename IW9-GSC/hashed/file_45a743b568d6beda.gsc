/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_45a743b568d6beda.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_raid1_nums_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_raid1_nums_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_raid1_nums_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_raid1_nums_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_raid1_nums_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-80.57, 590.38, 80.2), (270, 360, -0), undefined, undefined, "nums_test_start");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-178, 746.75, 57.5), (0, 90, 0), undefined, "auto13751", "ar_mike_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-103.5, 746.25, 57.5), (0, 90, 0), undefined, "auto13752", "ar_mike14_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-242, 747.25, 57.5), (0, 90, 0), undefined, "auto13750", "ar_charlie1_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-208, 406.75, 57.5), (0, 90, 0), undefined, "auto13742", "sm_papa_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-122, 406.25, 57.5), (0, 90, 0), undefined, "auto13741", "sn_alpha_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-375.25, 408.25, 54.54), (0, 0, 0), undefined, "auto13744", "sh_mike_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-298.5, 406.25, 57.5), (0, 0, 0), undefined, "auto13743", "sm_beta_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-433, 405.25, 57.5), (0, 0, 0), undefined, "auto13745", "sm_augolf_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-375, 748.25, 57.5), (0, 0, 0), undefined, "auto13748", "ar_kilo_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-435.5, 749.75, 57.5), (0, 0, 0), undefined, "auto13747", "ar_charlie2_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-304, 748.75, 57.5), (0, 0, 0), undefined, "auto13749", "ar_sierra_model");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "usmc_military_backpack_01";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-619.52, 566.95, 50.5), (331.19, 357.56, 6.32), "auto13721", undefined, "offhand_backpacks");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "usmc_military_backpack_01";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-621.26, 585.97, 50.5), (331.19, 357.56, 6.32), "auto13722", undefined, "offhand_backpacks");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "usmc_military_backpack_01";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-613.93, 607.61, 50.5), (331.19, 357.56, 6.32), "auto13723", undefined, "offhand_backpacks");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "usmc_military_backpack_01";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-612.72, 546.07, 50.5), (331.19, 357.56, 6.32), "auto13724", undefined, "offhand_backpacks");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-500.5, 413.25, 57), (0, 0, 0), undefined, "auto13746", "sn_mike_model");
  s = scripts\common\create_script_utility::s();
  s.script_parameters = "decoy_grenade";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-612.08, 612.67, 57.5), (0, 1.85, 0), "start_offhand_struct", "auto13723");
  s = scripts\common\create_script_utility::s();
  s.script_parameters = "snapshot";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-620.15, 591.7, 56.5), (0, 1.85, 0), "start_offhand_struct", "auto13722");
  s = scripts\common\create_script_utility::s();
  s.script_parameters = "flash";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-610.95, 552.54, 57.5), (0, 1.85, 0), "start_offhand_struct", "auto13724");
  s = scripts\common\create_script_utility::s();
  s.script_parameters = "stim";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-617, 572.75, 56.5), (0, 1.85, 0), "start_offhand_struct", "auto13721");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "usmc_military_backpack_01";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-623.02, 687.45, 50.5), (331.19, 357.56, 6.32), "auto13737", undefined, "offhand_backpacks");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "usmc_military_backpack_01";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-624.76, 706.47, 50.5), (331.19, 357.56, 6.32), "auto13738", undefined, "offhand_backpacks");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "usmc_military_backpack_01";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-617.43, 728.11, 50.5), (331.19, 357.56, 6.32), "auto13739", undefined, "offhand_backpacks");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "usmc_military_backpack_01";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-616.22, 666.57, 50.5), (331.19, 357.56, 6.32), "auto13740", undefined, "offhand_backpacks");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-129, 436.25, 57), (0, 0, -90), "auto13741", undefined, "sn_alpha_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-503, 436.75, 53), (0, 0, -90), "auto13746", undefined, "sn_mike_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-369, 438.25, 51.5), (0, 0, -90), "auto13744", undefined, "sh_mike_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-213.5, 434.75, 54), (0, 0, -90), "auto13742", undefined, "sm_papa_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-300.5, 435.25, 51.5), (0, 0, -90), "auto13743", undefined, "sm_beta_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-439, 435.75, 50.5), (0, 0, -90), "auto13745", undefined, "sm_augolf_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-172.5, 722.25, 56), (0, 180, -90), "auto13751", undefined, "ar_mike_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-238.5, 721.75, 55.5), (0, 180, -90), "auto13750", undefined, "ar_charlie1_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-435.5, 725.25, 56), (0, 180, -90), "auto13747", undefined, "ar_charlie2_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-363, 721.75, 58.5), (0, 180, -90), "auto13748", undefined, "ar_kilo_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-298, 721.75, 55.5), (0, 180, -90), "auto13749", undefined, "ar_sierra_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-106.5, 722.25, 57.5), (0, 180, -90), "auto13752", undefined, "ar_mike14_give_button");
  s = scripts\common\create_script_utility::s();
  s.script_parameters = "molotov";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-615.58, 733.17, 57.5), (0, 1.85, 0), "start_offhand_struct", "auto13739");
  s = scripts\common\create_script_utility::s();
  s.script_parameters = "c4";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-623.65, 712.2, 56.5), (0, 1.85, 0), "start_offhand_struct", "auto13738");
  s = scripts\common\create_script_utility::s();
  s.script_parameters = "claymore";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-614.45, 673.04, 57.5), (0, 1.85, 0), "start_offhand_struct", "auto13740");
  s = scripts\common\create_script_utility::s();
  s.script_parameters = "semtex";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-620.5, 693.25, 56.5), (0, 1.85, 0), "start_offhand_struct", "auto13737");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-266.95, 628.2, 28), (0, 180, 0), "numbersweps_debug_start_loc");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-411.63, 593.46, 28), (0, 180, 0), "numbersweps_debug_start_loc");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-342.69, 627.73, 28), (0, 180, 0), "numbersweps_debug_start_loc");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-268.08, 565.68, 28), (0, 180, 0), "numbersweps_debug_start_loc");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-345.31, 564.1, 28), (0, 180, 0), "numbersweps_debug_start_loc");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-544, 748, 16), undefined, "intro_ks_sentry");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-620, 492, 32), undefined, "intro_ammo_crate");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-204, 604, 32), undefined, undefined, undefined, "starting_room_marker");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (45.5, -4518.75, 1587.5), (0, 0, 0), undefined, "auto13756", "sm_beta_model_puzzle");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (44.5, -4510.25, 1582.5), (0, 81.1, 0), "auto13756", undefined, "sm_beta_give_button_puzzle");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (73.54, -4542.61, 1587.5), (0, 299.5, 0), undefined, "auto13760", "ar_charlie1_model_puzzle");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (80.44, -4537.56, 1582.5), (0, 20.6, 0), "auto13760", undefined, "ar_charlie1_give_button_puzzle");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (960, -2329.25, 1593.5), (0, 124, 0), undefined, "auto13764", "sm_papa_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (954.5, -2333.25, 1590), (0, 272, -0), "auto13764", undefined, "sm_papa_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-556.5, 413.25, 57), (0, 0, 0), undefined, "auto13776", "me_riotshield_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-559, 436.75, 53), (0, 0, -90), "auto13776", undefined, "me_riotshield_give_button");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1325.5, -2682.75, 1601), (0, 118, 0), undefined, "auto13772", "ar_charlie1_model");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1325, -2681.25, 1597), (0, 145, 0), "auto13772", undefined, "ar_charlie1_give_button");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}