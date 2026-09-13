/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_38763a923952695b.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_jugg_maze_juggmaze_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_jugg_maze_juggmaze_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_jugg_maze_juggmaze_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_jugg_maze_juggmaze_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_jugg_maze_juggmaze_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-154, 9000.75, -3821.75), (0, 90, 0), "nuke_deposit_crates", undefined, "brloot_elite_arrow_container_beryllium");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-154, 8943.25, -3821.75), (0, 90, 0), "nuke_deposit_crates", undefined, "brloot_elite_arrow_container_tritium");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-418.35, 8582.05, -3821.75), (0, 270.81, 0), "checkpoint_jugg_maze");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-508.18, 8520.99, -3821.75), (0, 7.61, 0), "checkpoint_jugg_maze");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-496.71, 8460.86, -3821.75), (0, 11.64, 0), "checkpoint_jugg_maze");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-481.21, 8575.43, -3821.75), (0, 293.58, 0), "checkpoint_jugg_maze");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-424.83, 8576.65, -3821.75), (0, 272.7, 0), "checkpoint_jugg_maze_postvent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-512.6, 8512.67, -3821.75), (0, 9.5, 0), "checkpoint_jugg_maze_postvent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-499.15, 8452.94, -3821.75), (0, 13.53, 0), "checkpoint_jugg_maze_postvent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-487.43, 8567.97, -3821.75), (0, 295.47, 0), "checkpoint_jugg_maze_postvent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-423.39, 8587.8, -3821.75), (0, 272.7, 0), "checkpoint_jugg_maze_postcore");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-511.16, 8523.81, -3821.75), (0, 9.5, 0), "checkpoint_jugg_maze_postcore");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-497.72, 8464.09, -3821.75), (0, 13.53, 0), "checkpoint_jugg_maze_postcore");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-486, 8579.11, -3821.75), (0, 295.47, 0), "checkpoint_jugg_maze_postcore");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-462, 7673, -3814), undefined, undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-963, 7353, -3814.5), undefined, undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-285, 7192, -3814), (0, 270, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (123, 5678, -3814), (0, 0, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2251.09, 7339.61, -3822), (0, 180, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-154, 9058.25, -3821.75), (0, 90, 0), "nuke_deposit_crates", undefined, "brloot_elite_arrow_container_plutonium");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2252.13, 6999.24, -3822), (0, 180, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2250.13, 6962.24, -3822), (0, 180, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-142.08, 6661.09, -3814), undefined, undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4, 6167, -3814), undefined, undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1142.81, 6184.03, -3814.5), (0, 270, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1023, 6653, -3814), (0, 0, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4263.1, 15408, -4013.5), (0, 240.2, 0), "checkpoint_mine_section");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4154.69, 15401.3, -4013.5), (0, 337, 0), "checkpoint_mine_section");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4284.91, 15360.8, -4013.5), (0, 161.03, 0), "checkpoint_mine_section");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4205.63, 15434.3, -4013.5), (0, 262.97, 0), "checkpoint_mine_section");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1360, 5678, -3814), (0, 0, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (9920.53, 17519.4, -3683.5), (0, 161.2, 0), "checkpoint_stealth_section");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (9865.01, 17580.8, -3683.21), (0, 221.57, 0), "checkpoint_stealth_section");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (9883.08, 17487.6, -3683.5), (0, 174.6, 0), "checkpoint_stealth_section");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (9919.38, 17565.8, -3683.5), (0, 183.97, 0), "checkpoint_stealth_section");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1110.5, 8530.25, -3629), (0, 180, 0), "door_lock_to_hadir");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (106.5, 11686.5, -4034.5), (0, 314.96, 0), "door_lock_post_laser_3");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-163, 8471.5, -3773.5), (0, 270, 0), "checkpoint_keycard_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1413, 5150, -3814), (0, 270, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (200, 3620, -3814), (0, 90, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-135, 3620, -3814), (0, 90, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1152, 3621, -3814), (0, 90, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1393, 3699, -3814), (0, 270, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1851, 3957, -3814), (0, 0, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1733, 4639, -3814), (0, 90, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (61.18, 4643.39, -3815), (0, 90, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (95, 3959, -3814), (0, 0, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-364, 3705, -3814), (0, 270, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-1148, 4673, -3814), (0, 270, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-974, 5323, -3814), (0, 0, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (336, 5150, -3814), (0, 270, 0), undefined, undefined, "dogtag_revive_loc_maze_vent");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-371.5, 3042, -3758), undefined, "core_location_point", undefined, "core_location_room_3");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1398, 3042, -3758), undefined, "core_location_point", undefined, "core_location_room_4");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {
  _id_7BC621799F959E50::main();
  _id_2920664A48EEC499::main();
}