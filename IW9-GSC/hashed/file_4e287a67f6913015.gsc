/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4e287a67f6913015.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_jugg_maze_intel_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_jugg_maze_intel_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_jugg_maze_intel_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_jugg_maze_intel_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_jugg_maze_intel_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "offhand1h_wm_smartphone_v0";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11385.5, 17569.6, -3459), (0.62, 62.08, 178.28), "geiger_counter");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "offhand1h_wm_smartphone_v0";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11300.6, 17658.8, -3459), (0.62, 182.07, 178.28), "geiger_counter");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (8309.45, 18106.4, -3847.5), (0, 339.39, 0), "cp_intel", undefined, "r4_10");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7871.2, 17935.7, -3875.5), (0, 86.97, 0), "cp_intel", undefined, "r4_10");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7883.2, 18206.4, -3875.5), (0, 76.47, 0), "cp_intel", undefined, "r4_10");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.lodcullscale = "1.0";
  s.model = "door_electronic_modern_keypad_locked";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (61.5, 11636.5, -4041.75), (0, 315, 0), undefined, undefined, "final_hallway_keypad");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-304, 13428, -4077), (0, 270, 0), "hadir_elevator_spawner_front", undefined, "hadir_elevator_spawner_front");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-235, 13380, -4077), (0, 270, 0), "hadir_elevator_spawner_front", undefined, "hadir_elevator_spawner_front");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-313, 13348, -4077), (0, 270, 0), "hadir_elevator_spawner_front", undefined, "hadir_elevator_spawner_front");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "geiger";
  s.scriptablename = "cp_intel_burried";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (2094.99, 12973.7, -4029), (0, 224.38, 0), "cp_intel", undefined, "r4_04");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "geiger";
  s.scriptablename = "cp_intel_burried";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-597, 13973.2, -1145.25), undefined, "cp_intel", undefined, "r4_02");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "geiger";
  s.scriptablename = "cp_intel_burried";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2268.8, 10444.8, -4091.59), (1.04, 66.96, 24.19), "cp_intel", undefined, "r4_03");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (589.95, 11514, -4097.07), (0, 44.02, 0), "cp_intel", undefined, "r4_08");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (178.45, 13396, -4046.75), undefined, "cp_intel", undefined, "r4_07", undefined, undefined, undefined, undefined, 207.36);
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11245.9, 17658.1, -3459.5), undefined, "cp_intel", undefined, "r4_09");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7473.45, 18239.4, -3874.75), (0, 88.6, 0), "cp_intel", undefined, "r4_10");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4134.05, 15893, -4009), (53.64, 359.64, -0.65), "cp_intel", undefined, "r4_17");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (9748.76, 16777.5, -3691.5), (0, 44.63, 0), "cp_intel", undefined, "r4_14");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (3427.95, 14250.8, -4241.25), undefined, "cp_intel", undefined, "r4_18");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-331.95, 14438.2, -3851.25), undefined, "cp_intel", undefined, "r4_13");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "geiger";
  s.scriptablename = "cp_intel_burried";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5936.72, 18108.3, -3791.25), (0, 17.5, 0), "cp_intel", undefined, "r4_01");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (12182.7, 17783.9, -3490), (29.31, 144.54, -0.33), "cp_intel", undefined, "r4_06");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (3538.5, 5070, -3798), undefined, "cp_intel", undefined, "r4_05");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (8452.85, 18695.8, -3875.5), undefined, "cp_intel", undefined, "r4_11");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2156.6, 7383.95, -3822), undefined, "cp_intel", undefined, "r4_12");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (3950.85, 15241.8, -4165.25), (68.08, 98.27, -4.72), "cp_intel", undefined, "r4_19");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6357.55, 17542.4, -3839), (0, 16.25, 0), "cp_intel", undefined, "r4_16");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4394.35, 17388.3, -3718), undefined, "cp_intel", undefined, "r4_20");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4000.77, 13645.2, -4281.25), undefined, "cp_intel", undefined, "r4_15");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "offhand1h_wm_smartphone_v0";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11338.5, 17660.2, -3459), (0.62, 62.08, 178.28), "geiger_counter");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}