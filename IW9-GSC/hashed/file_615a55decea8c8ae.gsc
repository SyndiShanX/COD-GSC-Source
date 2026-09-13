/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_615a55decea8c8ae.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_lone_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_lone_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_lone_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_lone_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_lone_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-48319, -11885.8, 260), (0, 171.37, 0), "animnode_van_infil");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47439, -15353.5, 260), (360, 90, 0), "default_player_start");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47365.6, -15346.3, 260), (360, 90, 0), "default_player_start");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-48053.8, -12008, 264), undefined, "van_infil_plr_ending_seat_1");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-48021.8, -11856, 264), undefined, "van_infil_plr_ending_seat_0");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-39680, -15968, 2880), (0, 180, 0), "script_apache_spawn_point");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47403, -15351.5, 260), (360, 89, 0), "default_player_start");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47491, -15353.5, 260), (360, 90, 0), "default_player_start");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-42416, -23216, 2880), (0, 90, 0), "script_apache_spawn_point");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-53808, -14208, 2880), (0, 270, 0), "script_apache_spawn_point");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-48109.8, -11920, 264), undefined, "van_infil_plr_ending_seat_5");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-48373.8, -11968, 264), (0, 345, 0), "van_infil_driver_exit");
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44618.1, -17405.2, 441.02), (0, 270, 0), "cp_intel", undefined, "ld_09", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44897.1, -16312.4, 294.52), (0, 51.69, 0), "cp_intel", undefined, "ld_10", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-46386.1, -16870.4, 277.52), (0, 51.69, 0), "cp_intel", undefined, "ld_10", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "offhand1h_wm_smartphone_v0";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47203, -17126, 297), (0, 282.82, 180), "geiger_counter", undefined, undefined, undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "crate";
  s.scriptablename = "cp_intel_burried";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-45361.9, -17608.9, 602.52), (0, 18.58, 0), "cp_intel", undefined, "ld_02", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44412.9, -17221.3, 442.52), (359.63, 18.89, 68.91), "cp_intel", undefined, "ld_09", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-49917.9, -14597.4, 330.52), (0, 51.42, 0), "cp_intel", undefined, "ld_05", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "geiger";
  s.scriptablename = "cp_intel_burried";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-49851.4, -25921.4, 246.27), (359.18, 283.24, 10.52), "cp_intel", undefined, "ld_01", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "geiger";
  s.scriptablename = "cp_intel_burried";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-45133.1, -8932.3, 256.77), (1.38, 97.84, -14.2), "cp_intel", undefined, "ld_01", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "offhand1h_wm_smartphone_v0";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47193, -17141.5, 297), (0, 75, 180), "geiger_counter", undefined, undefined, undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "geiger";
  s.scriptablename = "cp_intel_burried";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-52198.9, -14786.4, 334.27), (355.48, 219.05, -7.19), "cp_intel", undefined, "ld_01", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-46028.2, -12698.6, 296.02), undefined, "cp_intel", undefined, "ld_03", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-41525.9, -20969.7, 308.77), (0, 270, 0), "cp_intel", undefined, "ld_04", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-49638.9, -14577.6, 336.52), (0, 210.89, 0), "cp_intel", undefined, "ld_05", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47065.1, -16879.3, 306.02), (0, 270, 0), "cp_intel", undefined, "ld_06", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44891.8, -17493.1, 429.02), undefined, "cp_intel", undefined, "ld_09", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-46383.1, -16074.4, 695.02), (0, 276.26, 0), "cp_intel", undefined, "ld_08", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "documents";
  s.scriptablename = "cp_intel_documents";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44913.6, -16107.6, 300.02), (0, 270, 0), "cp_intel", undefined, "ld_10", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s._id_D056801AAF3E50C3 = "harddrive";
  s.scriptablename = "cp_intel_harddrive";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44302.1, -17275.1, 432.52), (0, 90, 0), "cp_intel", undefined, "ld_07", undefined, undefined, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "military_carepackage_01_loadout";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-46986.5, -17322.5, 256.5), (0, 328.94, 0), "loadout_drop");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}