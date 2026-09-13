/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_49f3320afe37e16c.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_lone_defend_intro_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_lone_defend_intro_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_lone_defend_intro_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_lone_defend_intro_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_lone_defend_intro_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47577.9, -12833.2, 260), undefined, "intro_grenade_drop");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (0, 0, 0));
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-47007.7, -14602.6, 260), undefined, "intro_ally_target_00_point", undefined, "point", undefined, undefined, undefined, undefined, 500);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3478.5, -12424.5, 4754), undefined, "cp_observatory_lockdoor_readyroom", undefined, undefined, undefined, undefined, undefined, undefined, 150);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3814.5, -12328.5, 4754), undefined, "cp_observatory_lockdoor_readyroom", undefined, undefined, undefined, undefined, undefined, undefined, 150);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3443.5, -12346, 4736.5), (0, 180, 0), "defender_kiosk_readyroom");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3677.03, -12314.6, 4742.93), (0, 39.43, 0), "defend_player_start_readyroom");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3708.01, -12350.1, 4742.93), (0, 39.43, 0), "defend_player_start_readyroom");
  s = scripts\common\create_script_utility::s();
  s.is_cs_model = 1;
  s.model = "military_carepackage_01_loadout";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3770.4, -12145.2, 4736.96), (0, 222, 0), "loadout_drop");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3742.02, -12311.5, 4742.93), (0, 38.43, 0), "defend_player_start_readyroom");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3710.09, -12274.4, 4742.93), (0, 39.43, 0), "defend_player_start_readyroom");
  s = scripts\common\create_script_utility::s();
  s.weaponinfo = "weapon_wm_lm_kilo121_brprop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3595.86, -12176.8, 4776.75), (359.87, 89.77, 21.88), "weapon_wall");
  s = scripts\common\create_script_utility::s();
  s.weaponinfo = "weapon_wm_pi_mike1911_brprop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3802.2, -12207.8, 4774), (357.34, 269.7, 26.52), "weapon_wall");
  s = scripts\common\create_script_utility::s();
  s.weaponinfo = "weapon_wm_sh_charlie725_brprop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3633.66, -12167.2, 4760), (292.37, 4.6, 82.69), "weapon_wall");
  s = scripts\common\create_script_utility::s();
  s.weaponinfo = "weapon_wm_sm_mpapa7_brprop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3594.22, -12201.5, 4778), (352.6, 86.65, 24.42), "weapon_wall");
  s = scripts\common\create_script_utility::s();
  s.weaponinfo = "weapon_wm_la_rpapa7";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3802.65, -12231, 4777.5), (359.47, 269.72, 27.4), "weapon_wall");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "boss_velikan";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44758.9, -12056.6, 276), (0, 180, 0), "lone_intro_velikan");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3632, -12272, 4736), undefined, "defender_ready_room", undefined, undefined, undefined, undefined, undefined, undefined, 400);
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "smg_t1_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44843.9, -12652.1, 275.02), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "ar_t2_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-45816.1, -13102.4, 275.09), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "smg_t2_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-45765.1, -12969.9, 275.09), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "ar_t2_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-45991.4, -12294.1, 275.02), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "smg_t1_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-46098.1, -12402.4, 275.09), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "lmg_t2_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-45187.6, -12037.3, 275.42), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "ar_t2_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-45093.9, -12745.6, 275.09), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "lmg_t2_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44939.4, -12516.1, 275.09), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "smg_t1_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-46145.4, -13094.1, 275.09), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "ar_t2_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-45673.6, -12209.8, 275.42), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "smg_t1_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-46306.9, -12556.1, 275.02), (0, 45, 0), "lone_intro_smgs");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-44923, -12371, 381.5), undefined, "lone_intro_obj");
  s = scripts\common\create_script_utility::s();
  s._id_649B4B92C0B7E26C = "1";
  s._id_87B421D7E94C6265 = "lmg_t2_cartel";
  s.script_demeanor = "default";
  s.script_forcespawn = "1";
  s.script_goalheight = "256";
  s.script_radius = "1250";
  s.script_team = "axis";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-46266.6, -12411.8, 275.42), (0, 45, 0), "lone_intro_smgs");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}