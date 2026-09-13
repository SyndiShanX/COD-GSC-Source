/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7896859eb0e311ed.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_biobunker_radiation_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_biobunker_radiation_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_biobunker_radiation_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_biobunker_radiation_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_biobunker_radiation_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  s._id_13DF181474836A29 = "Guard_Radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17482.7, 11405.1, 1574), (0, 86.6, 0), "cspf_0_auto19", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s._id_13DF181474836A29 = "Radiation_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17305.2, 10759, 1654), (0, 86.6, 0), undefined, "cspf_0_auto19", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15540, 12176, 2307), (0, 0, 0), undefined, "cspf_0_auto11", "radiation_firebug_spawn_set_1");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  s._id_13DF181474836A29 = "Guard_Radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17048.7, 11277.1, 1574), (0, 86.6, 0), "cspf_0_auto19", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15675, 12175, 1565), (0, 0, 0), "cspf_0_auto11", undefined, "radiation_firebug_spawn_point_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15437, 12169, 1565), (0, 0, 0), "cspf_0_auto11", undefined, "radiation_firebug_spawn_point_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14580, 9842, 1561), (356.2, 171.3, 0), undefined, undefined, "aiSentryTurret");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17185.4, 11020.2, 2307), (0, 93.4, 0), undefined, "cspf_0_auto3986", "radiation_firebug_spawn_set_2");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_label = "radiation";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-11381, 10763, 1560), (0, 0, 0), "cspf_0_auto4019");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17184.6, 11123.4, 1565), (0, 93.4, 0), "cspf_0_auto3986", undefined, "radiation_firebug_spawn_point_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16662.4, 11181.2, 2307), (0, 93.4, 0), undefined, "cspf_0_auto4003", "radiation_firebug_spawn_set_for_puzzle_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16653.4, 11046.5, 1565), (0, 93.4, 0), "cspf_0_auto4003", undefined, "radiation_firebug_spawn_point_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s._id_13DF181474836A29 = "Radiation_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14413.2, 10057, 1654), (0, 86.6, 0), undefined, "cspf_0_auto37", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_label = "radiation";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14184, 11184, 1560), (0, 0, 0), "cspf_0_auto4019");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas3";
  s._id_13DF181474836A29 = "Guard_Radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14672.7, 10125.1, 1574), (0, 86.6, 0), "cspf_0_auto37", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16661.6, 11284.4, 1565), (0, 93.4, 0), "cspf_0_auto4003", undefined, "radiation_firebug_spawn_point_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16689.4, 10710.2, 2307), (0, 93.4, 0), undefined, "cspf_0_auto4008", "radiation_firebug_spawn_set_for_puzzle_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16680.4, 10575.5, 1565), (0, 93.4, 0), "cspf_0_auto4008", undefined, "radiation_firebug_spawn_point_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16688.6, 10813.4, 1565), (0, 93.4, 0), "cspf_0_auto4008", undefined, "radiation_firebug_spawn_point_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17798.4, 10763.2, 2307), (0, 93.4, 0), undefined, "cspf_0_auto4013", "radiation_firebug_spawn_set_for_puzzle_3");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17789.4, 10628.5, 1565), (0, 93.4, 0), "cspf_0_auto4013", undefined, "radiation_firebug_spawn_point_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17797.6, 10866.4, 1565), (0, 93.4, 0), "cspf_0_auto4013", undefined, "radiation_firebug_spawn_point_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17776.4, 11286.2, 2307), (0, 93.4, 0), undefined, "cspf_0_auto4018", "radiation_firebug_spawn_set_for_puzzle_2");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17767.4, 11151.5, 1565), (0, 93.4, 0), "cspf_0_auto4018", undefined, "radiation_firebug_spawn_point_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17775.6, 11389.4, 1565), (0, 93.4, 0), "cspf_0_auto4018", undefined, "radiation_firebug_spawn_point_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16453, 11149, 1571), (0, 0, 0), "cspf_0_auto22", undefined, "radiation_bomber_spawn_point_phase_2_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16501, 10865, 1571), (0, 0, 0), "cspf_0_auto22", undefined, "radiation_bomber_spawn_point_phase_2_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17980, 11326, 1578), (0, 0, 0), "cspf_0_auto22", undefined, "radiation_bomber_spawn_point_phase_2_2");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s._id_13DF181474836A29 = "Radiation_Package";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15285.2, 9873, 1654), (0, 86.6, 0), undefined, "cspf_0_auto67", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas2";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-18105, 10551, 1578), (0, 0, 0), undefined, undefined, "radiation_bomber_spawn_point_phase_2_3");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_control3";
  s._id_13DF181474836A29 = "Guard_Radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15344.7, 10133.1, 1574), (0, 86.6, 0), "cspf_0_auto67", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas3";
  s._id_13DF181474836A29 = "Guard_Radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14138.7, 10097.6, 1574), (0, 86.6, 0), "cspf_0_auto37", undefined, "guard_spawnset_biolab");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_label = "radiation";
  s._id_13DF181474836A29 = "WeaponPieces";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15415, 9354, 1564), (0, 270, 0), "cspf_0_auto4019");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14468.6, 9932.12, 2307), (0, 177.7, 0), undefined, "cspf_0_auto3991", "radiation_firebug_spawn_set_3");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13952, 8889.5, 1572), (0, 180, 0), undefined, undefined, "patch_radiation_b");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13728, 10848, 1984), undefined, undefined, "cspf_0_auto4019", "weapon_pieces_radiation");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas3";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14333.7, 9927.72, 1565), (0, 177.7, 0), "cspf_0_auto3991", undefined, "radiation_firebug_spawn_point_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas3";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14565.3, 9994.28, 1565), (0, 177.7, 0), "cspf_0_auto3991", undefined, "radiation_firebug_spawn_point_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas3";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14734.2, 10876.7, 1571), (0, 80.7, 0), "cspf_0_auto3998", undefined, "radiation_bomber_spawn_point_phase_3_0");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14376, 8889.5, 1572), undefined, undefined, undefined, "patch_radiation_a");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas3";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14226.7, 10722.4, 1571), (0, 80.7, 0), "cspf_0_auto3998", undefined, "radiation_bomber_spawn_point_phase_3_1");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-13952, 8827.25, 1572), (0, 180, 0), undefined, undefined, "patch_radiation_c");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas3";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14981.7, 9372.34, 1578), (0, 80.7, 0), "cspf_0_auto3998", undefined, "radiation_bomber_spawn_point_phase_3_2");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14376, 8827.25, 1572), (0, 180, 0), undefined, undefined, "patch_radiation_d");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  s.script_stealthgroup = "stealthVolume_Radiation_gas3";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14222.1, 9104.73, 1578), (0, 80.7, 0), undefined, undefined, "radiation_bomber_spawn_point_phase_3_3");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16475.3, 12230.2, 1571.75), (0, 180, 0), undefined, undefined, "uniquedoor_force_open");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17283.4, 12429.1, 1558.5), (0, 270, 0), undefined, undefined, "uniquedoor_force_open");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16315.6, 9897.45, 1570), (0, 0, 0), undefined, undefined, "uniquedoor_force_open");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16315.6, 9949.45, 1570), (0, 0, 0), undefined, undefined, "uniquedoor_force_open");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-17229.4, 12429.1, 1558.5), (0, 270, 0), undefined, undefined, "uniquedoor_force_open");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-16474.8, 12177.7, 1571.75), (0, 180, 0), undefined, undefined, "uniquedoor_force_open");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_radiation";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-15428, 9444, 1563.5), undefined, "brloot_valuable_bunkergas", "brloot_valuable_bunkergas", "brloot_valuable_bunkergas");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}