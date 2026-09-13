/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7fa81dbfeab6a166.gsc
***********************************************/

main(_id_97282C14346A7FCF, _id_CDDA4278F5259F6D) {
  if(scripts\engine\utility::flag_exist("cp_raid1_boss1_main_cs")) {
    return;
  }
  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = scripts\common\create_script_utility::_id_B055D49370405173();

  scripts\engine\utility::flag_init("cp_raid1_boss1_main_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, "cp_raid1_boss1_main_cs");

  if(!scripts\common\create_script_utility::cs_is_starttime())
    scripts\common\create_script_utility::endcreatescript(s);
}

cs_return_and_wait_for_flag(_id_CDDA4278F5259F6D, s, _id_CE173D78F5680530) {
  level endon("game_ended");
  scripts\common\create_script_utility::wait_for_cs_flag(_id_CE173D78F5680530);

  if(!isDefined(_id_CDDA4278F5259F6D))
    _id_CDDA4278F5259F6D = "pfx";

  s scripts\common\create_script_utility::cs_setup_arrays(_id_CDDA4278F5259F6D, "cp_raid1_boss1_main_cs");
  scripts\common\create_script_utility::cs_flags_init(s);
  level thread createstructs(s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530);
  level thread scripts\common\create_script_utility::wait_for_flags(s, "cp_raid1_boss1_main_cs");
}

createstructs(_id_CE2D3C78F5803630, _id_CDDA4278F5259F6D, _id_CE173D78F5680530) {
  f = scripts\common\create_script_utility::strike_additem;
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (6336, 12776, 408), undefined, "raid_load_struct_fil", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (12611.3, 8759.52, 11.75), undefined, "raid_load_struct_subarea", undefined, undefined, undefined, undefined, undefined, undefined, 350);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5482, 10991, 6312), (0, 90, 0), "b1_silo_checkpoint_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5478, 10927, 6312), (0, 90, 0), "b1_silo_checkpoint_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5556, 10995, 6312), (0, 90, 0), "b1_silo_checkpoint_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5558, 10927, 6312), (0, 90, 0), "b1_silo_checkpoint_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7328.1, 13842.6, 282), (0, 90, 0), "fil_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7329.5, 13897.8, 282), (0, 90, 0), "fil_playerstart", undefined, undefined, undefined, undefined, undefined, undefined, 253.44);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7364.1, 13844.6, 282), (0, 89, 0), "fil_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7372.1, 13898.6, 282), (0, 90, 0), "fil_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11616, 9272, 312), (0, 90, 0), "b1_fil_power_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11576, 9272, 312), (0, 90, 0), "b1_fil_power_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11664, 9272, 312), (0, 90, 0), "b1_fil_power_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11640, 9312, 312), (0, 90, 0), "b1_fil_power_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11592, 9312, 312), (0, 90, 0), "b1_fil_power_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14216.9, 8793.62, -7), (0, 360, 0), "b1_p0_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14224.1, 8720.23, -7), (0, 360, 0), "b1_p0_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14218.9, 8757.62, -7), (0, 359, 0), "b1_p0_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14216.9, 8845.62, -7), (0, 360, 0), "b1_p0_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15027.5, 8914, 561), (0, 90, 0), "p3_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14973.5, 8910.5, 561), (0, 90, 0), "p3_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15029.5, 8957.5, 561), (0, 90, 0), "p3_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14975.5, 8954, 561), (0, 90, 0), "p3_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15155.5, 7978, 433), (0, 90, 0), "b1_p2_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15101.5, 7974.5, 433), (0, 90, 0), "b1_p2_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15157.5, 8021.5, 433), (0, 90, 0), "b1_p2_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15103.5, 8018, 433), (0, 90, 0), "b1_p2_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (7344, 13864, 408), undefined, "raid_load_struct_fil", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11608, 9312, 408), undefined, "raid_load_struct_fil", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14224, 8768, 40), undefined, "raid_load_struct_subarea", undefined, undefined, undefined, undefined, undefined, undefined, 384.283);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15128, 8008, 448), undefined, "raid_load_struct_subarea", undefined, undefined, undefined, undefined, undefined, undefined, 384.283);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (15000, 8936, 584), undefined, "raid_load_struct_subarea", undefined, undefined, undefined, undefined, undefined, undefined, 384.283);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1383, 8694, 6312), (0, 360, 0), "b1_preintro_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1379, 8630, 6312), (0, 360, 0), "b1_preintro_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1457, 8698, 6312), (0, 360, 0), "b1_preintro_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1459, 8630, 6312), (0, 360, 0), "b1_preintro_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (1417, 8650, 6448), (0, 360, 0), "raid_load_struct_silo", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5516, 10947, 6448), (0, 90, 0), "raid_load_struct_silo", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14457.9, 9201.87, 161), (0, 360, 0), "b1_p1_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14465.1, 9128.48, 161), (0, 360, 0), "b1_p1_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14459.9, 9165.87, 161), (0, 359, 0), "b1_p1_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14457.9, 9253.87, 161), (0, 360, 0), "b1_p1_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (14461, 9179, 189), undefined, "raid_load_struct_subarea", undefined, undefined, undefined, undefined, undefined, undefined, 384.283);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5504, 11469, 3048), (0, 180, 0), "b1_silo_2nd_stop_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5603, 11478, 3048), (0, 180, 0), "b1_silo_2nd_stop_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5504, 11605, 3048), (0, 180, 0), "b1_silo_2nd_stop_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5612, 11605, 3048), (0, 180, 0), "b1_silo_2nd_stop_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5588, 11286, 3184), (0, 180, 0), "raid_load_struct_silo", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11666.6, 6345.9, 344), (0, 0, 0), "b1_fil_vent_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11722.8, 6345.5, 341), (0, 0, 0), "b1_fil_vent_players", undefined, undefined, undefined, undefined, undefined, undefined, 253.44);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11666.6, 6302.9, 344), (0, 359, 0), "b1_fil_vent_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5591.48, 10501, 319.5), (0, 0, 0), "b1_silo_end_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5590.2, 10586.6, 319.5), (0, 0, 0), "b1_silo_end_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5515.62, 10587.4, 319.5), (0, 0, 0), "b1_silo_end_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5516.5, 10506.5, 319.5), (0, 0, 0), "b1_silo_end_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4747, 11092.5, 3009.5), (0, 90, 0), "cspf_0_auto1");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (5532, 10460, 436), (0, 180, 0), "raid_load_struct_silo", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11722.6, 6301.9, 344), (0, 0, 0), "b1_fil_vent_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11698, 6321, 470), undefined, "raid_load_struct_fil", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10618.9, 9411.4, 302), (0, 270, 0), "b1_fil_end_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10618.5, 9355.2, 299), (0, 270, 0), "b1_fil_end_players", undefined, undefined, undefined, undefined, undefined, undefined, 253.44);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10575.9, 9411.4, 302), (0, 269, 0), "b1_fil_end_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10574.9, 9355.4, 302), (0, 270, 0), "b1_fil_end_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (10594, 9380, 428), (0, 270, 0), "raid_load_struct_fil", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4385, 12800, 2908), (0, 270, 0), "b1_silo_2nd_power_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4481, 12800, 2908), (0, 270, 0), "b1_silo_2nd_power_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4382.5, 12882, 2908), (0, 270, 0), "b1_silo_2nd_power_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4478.5, 12882, 2908), (0, 270, 0), "b1_silo_2nd_power_playerstart");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (4439.5, 12854, 3044), (0, 180, 0), "raid_load_struct_silo", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11635.1, 7445.9, 533), (0, 0, 0), "b1_fil_tripwire_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11686.8, 7445.5, 533), (0, 0, 0), "b1_fil_tripwire_players", undefined, undefined, undefined, undefined, undefined, undefined, 253.44);
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11631.6, 7411.4, 480), (0, 359, 0), "b1_fil_tripwire_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11683.1, 7410.4, 480), (0, 0, 0), "b1_fil_tripwire_players");
  s = scripts\common\create_script_utility::s();
  _id_CE2D3C78F5803630[[f]](s, _id_CDDA4278F5259F6D, _id_CE173D78F5680530, (11674.5, 7429.5, 646), undefined, "raid_load_struct_fil", undefined, undefined, undefined, undefined, undefined, undefined, 408.168);
  _id_CE2D3C78F5803630 scripts\engine\utility::ent_flag_set("cs_objects_created");
  _id_7AF6D59EEF91A7DD();
}

_id_7AF6D59EEF91A7DD() {}