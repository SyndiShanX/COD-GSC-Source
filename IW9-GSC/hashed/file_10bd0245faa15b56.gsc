/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_10bd0245faa15b56.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("mp_biobunker_shop_create_script")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("mp_biobunker_shop_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "mp_biobunker_shop_create_script");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "mp_biobunker_shop_create_script");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "mp_biobunker_shop_create_script");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_89DADBBF1464C45E = "1";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9085, 11650, 1645), (0, 90.75, 0), "dead_drop");
  s = scripts\common\create_script_utility::s();
  s._id_5EA299587B551F9F = "dmz_biobunker";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_C4231C7DDE966D14 = "dmz_biobunker_contraband";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8918.44, 11688.4, 1618), (0, 132.32, 0), "buy_station");
  s = scripts\common\create_script_utility::s();
  s._id_98A72274E33CA7D5 = "1";
  s._id_5EA299587B551F9F = "dmz_biobunker_high_tier";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_C4231C7DDE966D14 = "dmz_biobunker_contraband_high_tier";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9227.35, 11755.6, 1618), (0, 29.71, 0), "buy_station");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9056, 11638, 1673), (360, 90.21, -5.5), "bb_shoppingListLoc", undefined, "stationary_note");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9210, 11666, 1658.3), (270, 207.23, -143.32), "bb_shoppingListLoc", undefined, "stationary_note");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8886, 11888, 1644.3), (270, 207.23, -143.32), "bb_shoppingListLoc", undefined, "stationary_note");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9003, 11902.7, 1680), (360, 270.21, -6.4), "shoppingListLoc");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9018, 11640.3, 1668), (0, 90.21, 3.4), "bb_shoppingListLoc", undefined, "stationary_note");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_board_common";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8932, 11991, 1628.3), (270, 0, -89.79), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_board_uncommon";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8904, 11990, 1630.3), (270, 0, -89.79), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_board_epic";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8876, 11990, 1629.3), (270, 0, -89.79), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_formaldehyde";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8847, 11991, 1628.3), (270, 0, -89.79), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_chlorine";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8816, 11992, 1628.3), (270, 0, -89.79), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_acetic_acid";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8785, 11988, 1630.3), (270, 0, -89.79), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_sulfuric_acid";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8751, 11986, 1629.3), (270, 0, -89.79), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_liquid_nitrogen";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8712, 11984, 1628.3), (270, 0, -89.79), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_notes_common";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8991.5, 12079.5, 1623.8), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_notes_uncommon";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8967.5, 12080, 1623.3), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_notes_rare";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8943, 12080.5, 1622.8), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_notes_epic";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8913.5, 12081, 1623.8), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_notes_unique";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8886.5, 12081.5, 1623.3), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_server_tape_common";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8857.5, 12082, 1622.8), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_server_tape_uncommon";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8832.5, 12079.5, 1623.8), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_server_tape_rare";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8808, 12078.5, 1623.3), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_2B7395B3855CE24F = "brloot_valuable_bunker_server_tape_epic";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8779, 12079, 1623.3), (270, 101.84, -11.63), "shoppingListDebugItem");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14742.9, 12071.9, 1620.91), (360, 90.21, -5.5), "bb_shoppingListLoc", undefined, "stationary_note");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-14553.9, 6826.09, 1565.01), (359.1, 180.21, -0), "bb_shoppingListLoc", undefined, "stationary_note");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-2494.91, 4893.96, 1446.9), (0, 90, 6.4), "bb_shoppingListLoc", undefined, "stationary_note");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-3924.91, 11133, 1514.9), (0, 0, 8.7), "bb_shoppingListLoc", undefined, "stationary_note");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "elite";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s.script_stealthgroup = "stealthVolume_boss_shop_lv1";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-7758.71, 12726.3, 1629), (0, 0, 0), "cspf_0_auto125", undefined, "guard_spawnset_medium_range");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8020.5, 13110, 1805.5), (0, 0, 0), undefined, "cspf_0_auto125", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s.script_stealthgroup = "stealthVolume_boss_shop_lv1";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10630.2, 13190.3, 1629), (0, 0, 0), "cspf_0_auto131", undefined, "guard_spawnset_medium_range");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10096.5, 13354, 1805.5), (0, 0, 0), undefined, "cspf_0_auto131", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s.script_stealthgroup = "stealthVolume_boss_shop_lv2";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8892.23, 12107.4, 1761), (0, 180, 0), "cspf_0_auto171", undefined, "guard_spawnset_long_range");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9002.5, 12202, 1861.5), (0, 0, 0), undefined, "cspf_0_auto171", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9897.5, 12404, 1861.5), (0, 0, 0), undefined, "cspf_0_auto177", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "elite";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s.script_stealthgroup = "stealthVolume_boss_shop_lv2";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-10434.4, 12749.9, 1763), (0, 0, 0), "cspf_0_auto177", undefined, "guard_spawnset_long_range");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s.script_stealthgroup = "stealthVolume_boss_shop_lv1";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-9194.42, 12022.5, 1626), (0, 0, 0), "cspf_0_auto183", undefined, "guard_spawnset_short_range");
  s = scripts\common\create_script_utility::s();
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8858.49, 12010.7, 1631), (0, 0, 0), undefined, "cspf_0_auto183", "spawnPackage_mainNode");
  s = scripts\common\create_script_utility::s();
  s.agent_type = "topTier";
  s._id_B205D90302DA2F07 = "biobunker_shop";
  s._id_4B62AA3A1860D0AC = "1";
  s.script_label = "lv2Hallway";
  s.script_stealthgroup = "stealthVolume_boss_shop_lv1";
  s._id_13DF181474836A29 = "Guard_2nd_floor";
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (-8733.15, 12010.6, 1627), (0, 90, 0), "cspf_0_auto183", undefined, "guard_spawnset_short_range");
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}