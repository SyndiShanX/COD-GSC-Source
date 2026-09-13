/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_731f14c50baac052.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_raid1_trap_drones_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_raid1_trap_drones_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_raid1_trap_drones_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_raid1_trap_drones_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_raid1_trap_drones_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4720, 2736, -136), undefined, "cspf_0_auto58", "cspf_0_auto7");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4672, 2624, -568), undefined, "cspf_0_auto1", "cspf_0_auto2", "drone_grenade_line", undefined, undefined, undefined, undefined, 64);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4720, 2512, -136), undefined, "cspf_0_auto59", "cspf_0_auto14");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3760, 2624, -568), (0, 0, 0), "cspf_0_auto2", "cspf_0_auto1", "drone_grenade_line", undefined, undefined, undefined, undefined, 64);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4992, 2736, -32), (0, 180, 0), "drone_grenade_spawn_p1", "cspf_0_auto6", "drone_grenade_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4720, 2696, -344), undefined, "cspf_0_auto7", "cspf_0_auto1");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4720, 2736, -16), undefined, "cspf_0_auto6", "cspf_0_auto58");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4992, 2512, -32), (0, 180, 0), "drone_grenade_spawn_p1", "cspf_0_auto13", "drone_grenade_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4720, 2544, -344), undefined, "cspf_0_auto14", "cspf_0_auto1");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4720, 2512, -16), undefined, "cspf_0_auto13", "cspf_0_auto59");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3480, 2628, 160), undefined, "cspf_0_auto24", "cspf_0_auto26", "drone_grenade_line", undefined, undefined, undefined, undefined, 8);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3416, 2544, 160), (0, 0, 0), "cspf_0_auto26", "cspf_0_auto24", "drone_grenade_line", undefined, undefined, undefined, undefined, 8);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4176, 2656, 480), (0, 180, 0), "drone_grenade_spawn_p2", "cspf_0_auto27", "drone_grenade_spawn");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4104, -3456, -624), undefined, "cspf_0_auto36", "cspf_0_auto35", "drone_grenade_line", undefined, undefined, undefined, undefined, 96);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3464, 2584, 496), undefined, "cspf_0_auto27", "cspf_0_auto24");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2080, -3456, -624), (0, 0, 0), "cspf_0_auto35", "cspf_0_auto36", "drone_grenade_line", undefined, undefined, undefined, undefined, 96);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4136, -3840, -640), (0, 180, 0), "drone_grenade_spawn_p_final", "cspf_0_auto37", "drone_grenade_spawn", undefined, undefined, undefined, undefined, 2000);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4120, -3584, -656), undefined, "cspf_0_auto37", "cspf_0_auto36");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5280, -1392, -336), (0, 270, 0), "cspf_0_auto46", "cspf_0_auto45", "drone_grenade_line", undefined, undefined, undefined, undefined, 32);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5280, -2328, -336), (0, 270, 0), "cspf_0_auto45", "cspf_0_auto46", "drone_grenade_line", undefined, undefined, undefined, undefined, 32);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5544, -1328, -352), (0, 90, 0), "drone_grenade_spawn_p_final2", "cspf_0_auto47", "drone_grenade_spawn", undefined, undefined, undefined, undefined, 1000);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5408, -1296, -368), (0, 270, 0), "cspf_0_auto47", "cspf_0_auto46");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5028.5, -1328, -368), undefined, "drone_grenade_spawn_p_final2", "cspf_0_auto52", "drone_grenade_spawn", undefined, undefined, undefined, undefined, 1000);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5164.5, -1296, -352), undefined, "cspf_0_auto52", "cspf_0_auto46");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4114, -3049, -656), (90, 0, 0), "drone_grenade_spawn_p_final", "cspf_0_auto57", "drone_grenade_spawn", undefined, undefined, undefined, undefined, 2000);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4130, -3305, -640), (270, 0, -180), "cspf_0_auto57", "cspf_0_auto36");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (0, 0, 0));
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}