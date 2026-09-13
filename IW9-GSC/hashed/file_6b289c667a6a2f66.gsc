/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6b289c667a6a2f66.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_biobunker_dark_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_biobunker_dark_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_biobunker_dark_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_biobunker_dark_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_biobunker_dark_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "lv2RightWay";
  s.script_stealthgroup = "stealthVolume_Dark_main";
  s._id_13DF181474836A29 = "Guard_Dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8963.2, 7579.67, 1571), (0, 270, 0), "cspf_0_auto51", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "lv2RightWay";
  s.script_stealthgroup = "stealthVolume_Dark_main";
  s._id_13DF181474836A29 = "Guard_Dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9235.2, 7091.67, 1571), (0, 270, 0), "cspf_0_auto57", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "lv2RightWay";
  s.script_stealthgroup = "stealthVolume_Dark_main";
  s._id_13DF181474836A29 = "Guard_Dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9227.2, 7587.67, 1571), (0, 270, 0), "cspf_0_auto57", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s._id_13DF181474836A29 = "Dark_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9227, 7554, 1723), (0, 270, 0), undefined, "cspf_0_auto57", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "elite";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "lv2RightWay";
  s.script_stealthgroup = "stealthVolume_Dark_main";
  s._id_13DF181474836A29 = "Guard_Dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9795.2, 7587.67, 1571), (0, 270, 0), "cspf_0_auto57", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "dark";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9591, 7810, 1558), (0, 0, 0), "cspf_0_auto58");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "dark";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9781, 8813, 1558), (0, 0, 0), "cspf_0_auto58");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "dark";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8538, 6572, 1557), (0, 0, 0), "cspf_0_auto58");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "dark";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8193, 8584, 1558), (0, 0, 0), "cspf_0_auto58");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "dark";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8448, 7808, 1558), (0, 0, 0), "cspf_0_auto58");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9701.5, 8093.25, 1558.75), (270, 90, 335), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8896, 8416, 1952), undefined, undefined, "cspf_0_auto58", "weapon_pieces_dark");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9804.5, 8222.75, 1632.25), (0, 90, 145), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10132.2, 8061.5, 1558.75), (270, 90, 0), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10103.5, 7518, 1624.5), (0, 90, 325), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10461.5, 6977.75, 1603), (0, 0, 115), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "lv2RightWay";
  s.script_stealthgroup = "stealthVolume_Dark_main";
  s._id_13DF181474836A29 = "Guard_Dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8635.2, 7339.67, 1571), (0, 270, 0), "cspf_0_auto51", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s._id_13DF181474836A29 = "Dark_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8971, 7618, 1723), (0, 270, 0), undefined, "cspf_0_auto51", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_26242E8921AE5B22 = "guard_spawnset_patrol_primary";
  s._id_B205D90302DA2F07 = "biobunker_dark";
  s.script_label = "lv2RightWay";
  s.script_stealthgroup = "stealthVolume_Dark_main";
  s._id_13DF181474836A29 = "Guard_Dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8667.2, 8091.67, 1571), (0, 270, 0), "cspf_0_auto51", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10436.8, 6169.5, 1590), (0, 0, 135), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10368.5, 5018.25, 1586), (0, 90, 125), "with_radiation", undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8384.75, 7453.25, 1621), (180, 90, 325), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8451.25, 7574, 1558.25), (270, 0, 235), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7422.25, 7605.25, 1576.75), (0, 180, 315), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7406.25, 6974, 1581), (0, 180, 315), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7469, 6080.5, 1558.25), (270, 360, 135), undefined, undefined, "thermal_arrow");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_dark";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7497, 5018.25, 1583.25), (360, 90, -37.99), "with_radiation", undefined, "thermal_arrow");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}