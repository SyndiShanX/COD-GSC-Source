/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_648a0e5f36c1fea4.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_biobunker_controlroom_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_biobunker_controlroom_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_biobunker_controlroom_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_biobunker_controlroom_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_biobunker_controlroom_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_tuning";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14307.7, 6328.3, 1533), (0, 180, 0), "cspf_0_auto16", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s._id_13DF181474836A29 = "Controlroom_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14197.8, 6500.15, 1645), (0, 180, 0), undefined, "cspf_0_auto16", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_tuning";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14155.7, 6256.3, 1533), (0, 180, 0), "cspf_0_auto16", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_tuning";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14083.7, 6632.3, 1533), (0, 180, 0), "cspf_0_auto16", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_hotpot_part2";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13547.7, 6864.3, 1533), (0, 180, 0), "cspf_0_auto20", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s._id_13DF181474836A29 = "Controlroom_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13581.8, 6420.15, 1605), (0, 180, 0), undefined, "cspf_0_auto20", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_hotpot_part2";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13419.7, 6488.3, 1533), (0, 180, 0), "cspf_0_auto20", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_hotpot_part2";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13315.7, 6120.3, 1533), (0, 180, 0), "cspf_0_auto20", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_hotpot_part1";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-12715.7, 6712.3, 1533), (0, 180, 0), "cspf_0_auto26", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s._id_13DF181474836A29 = "Controlroom_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-12957.8, 6668.15, 1565), (0, 180, 0), undefined, "cspf_0_auto26", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_hotpot_part1";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13235.7, 7032.3, 1533), (0, 180, 0), "cspf_0_auto26", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_hotpot_part1";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-12731.7, 6296.3, 1533), (0, 180, 0), "cspf_0_auto26", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_workshop";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16083.7, 5992.3, 1621), (0, 180, 0), "cspf_0_auto32", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s._id_13DF181474836A29 = "Controlroom_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15845.8, 5988.15, 1733), (0, 180, 0), undefined, "cspf_0_auto32", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_workshop";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16067.7, 5704.3, 1621), (0, 180, 0), "cspf_0_auto32", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_room1";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16014.6, 7167.03, 1621), (0, 0, 0), "cspf_0_auto32", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Middleway";
  s.script_stealthgroup = "stealthVolume_Controlroom_movie";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14675.7, 6472.3, 1565), (0, 180, 0), "cspf_0_auto3", "cspf_0_auto5", "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s._id_13DF181474836A29 = "Controlroom_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14669.8, 6444.15, 1677), (0, 180, 0), undefined, "cspf_0_auto3", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2Leftway";
  s.script_stealthgroup = "stealthVolume_Controlroom_movie";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14628.7, 6025.3, 1547), (0, 180, 0), "cspf_0_auto3", "cspf_0_auto6", "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  s.script_label = "lv2RightWay";
  s.script_stealthgroup = "stealthVolume_Controlroom_movie";
  s._id_13DF181474836A29 = "Guard_Controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14680.7, 6893.3, 1565), (0, 180, 0), "cspf_0_auto3", "cspf_0_auto4", "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15100.8, 6485.15, 1574), (0, 180, 0), "cspf_0_auto5", undefined, "patrolStart");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15065.8, 6936.15, 1574), (0, 180, 0), "cspf_0_auto4", undefined, "patrolStart");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_controlroom";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15100.8, 6017.15, 1574), (0, 180, 0), "cspf_0_auto6", undefined, "patrolStart");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}