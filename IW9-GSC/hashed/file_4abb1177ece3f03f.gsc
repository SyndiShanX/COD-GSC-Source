/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4abb1177ece3f03f.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_biobunker_flooded_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_biobunker_flooded_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_biobunker_flooded_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_biobunker_flooded_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_biobunker_flooded_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_room1";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5682.7, 8723.1, 1574), (0, 86.6, 0), "cspf_0_auto19", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_13DF181474836A29 = "Flooded_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5285.2, 8569, 1654), (0, 86.6, 0), undefined, "cspf_0_auto19", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_room1";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5688.7, 8507.1, 1574), (0, 86.6, 0), "cspf_0_auto19", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_room1";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5232.7, 8389.1, 1574), (0, 86.6, 0), "cspf_0_auto19", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_room2";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7204.7, 8935.1, 1566), (0, 86.6, 0), "cspf_0_auto24", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_13DF181474836A29 = "Flooded_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7061.2, 8865, 1646), (0, 86.6, 0), undefined, "cspf_0_auto24", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_room2";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7012.7, 9101.1, 1574), (0, 86.6, 0), "cspf_0_auto24", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_middle";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3986.7, 10965.1, 1484), (0, 86.6, 0), "cspf_0_auto30", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_13DF181474836A29 = "Flooded_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3799.2, 10893, 1506), (0, 86.6, 0), undefined, "cspf_0_auto30", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_middle";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4302.7, 10739.1, 1478), (0, 86.6, 0), "cspf_0_auto30", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_middle";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3746.7, 10713.1, 1478), (0, 86.6, 0), "cspf_0_auto30", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3903.34, 10950.1, 1520.75), (0, 119.5, 0), "turret_laser_17", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4453.11, 10742.3, 1520.75), (0, 63.7, 0), "turret_laser_19", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3998.18, 11155.3, 1520.75), (0, 75, 0), "turret_laser_16", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4280.18, 11416.3, 1520.75), (0, 75, 0), "turret_laser_18", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4512.81, 10789.2, 1500.75), (0, 41.5, 0), "turret_laser_19", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3951.81, 11070.8, 1501.75), (0, 320.7, 0), "turret_laser_17", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3921.21, 11282.9, 1500.75), (0, 214, 0), "turret_laser_16", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4396.82, 11163.2, 1500.75), (0, 45, 0), "turret_laser_4", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.lodcullscale = "1.0";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s._id_63205D4DDB640D1A = "1";
  s.script_groupname = "nomove";
  s._id_4FE5CDFF2560E8C6 = "laser_trap_bunker";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4068.9, 11517.8, 1500.75), (0, 293, 0), "turret_laser_18", undefined, "bs_laser");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_8E5A9B658FA525ED = "ru";
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_stealthgroup = "stealthVolume_Flooded_room1";
  s._id_13DF181474836A29 = "Guard_Flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-5597.2, 8479.1, 1574), (0, 86.6, 0), "cspf_0_auto19", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_index = "2";
  s._id_13DF181474836A29 = "Laser_Trap";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4360, 11265, 1488), (0, 90, 0), undefined, "turret_laser_4", "laser_sentry_defuse");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_index = "2";
  s._id_13DF181474836A29 = "Laser_Trap";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4108, 11190, 1496), (0, 0, 0), undefined, "turret_laser_16", "laser_sentry_defuse");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_index = "2";
  s.script_label = "random_5";
  s._id_13DF181474836A29 = "Laser_Trap";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4087, 10920, 1515), (0, 219.1, 0), undefined, "turret_laser_17", "laser_sentry_defuse");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_index = "2";
  s._id_13DF181474836A29 = "Laser_Trap";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4326, 11408, 1519), (0, 0, 0), undefined, "turret_laser_18", "laser_sentry_defuse");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_index = "2";
  s.script_label = "random_5";
  s._id_13DF181474836A29 = "Laser_Trap";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4411, 10970, 1485), (0, 90, -0), undefined, "turret_laser_19", "laser_sentry_defuse");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_label = "flooded";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4436, 13305, 1235), (0, 39.5, 0), "cspf_0_auto31");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_label = "flooded";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3662.5, 12830, 1281), (0, 349.4, 0), "cspf_0_auto31");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4064, 13056, 1568), undefined, undefined, "cspf_0_auto31", "weapon_pieces_flooded");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_flooded";
  s.script_label = "flooded";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-4519, 12108, 1281), (0, 90, 0), "cspf_0_auto31");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}