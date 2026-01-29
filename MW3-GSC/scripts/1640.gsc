/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1640.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2, var_3) {
  maps\_vehicle::_id_2AC2("hind", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("vehicle_mi24p_hind_desert");
  maps\_vehicle::_id_2ABE("vehicle_mi24p_hind_woodland");
  maps\_vehicle::_id_2ABE("vehicle_mi24p_hind_woodland_opened_door");
  var_4 = [];
  var_4["vehicle_mi24p_hind_desert"] = "explosions/helicopter_explosion_hind_desert";
  var_4["vehicle_mi24p_hind_woodland"] = "explosions/helicopter_explosion_hind_woodland";
  var_4["vehicle_mi24p_hind_woodland_opened_door"] = "explosions/helicopter_explosion_hind_woodland";
  var_4["vehicle_mi24p_hind_chernobyl"] = "explosions/helicopter_explosion_hind_chernobyl";
  var_4["vehicle_ny_harbor_hind"] = "explosions/helicopter_explosion_hind_chernobyl";
  var_4["payback_vehicle_hind"] = "explosions/helicopter_explosion_hind_chernobyl";
  var_5 = [];
  var_5["vehicle_mi24p_hind_desert"] = "explosions/aerial_explosion_hind_desert";
  var_5["vehicle_mi24p_hind_woodland"] = "explosions/aerial_explosion_hind_woodland";
  var_5["vehicle_mi24p_hind_woodland_opened_door"] = "explosions/aerial_explosion_hind_woodland";
  var_5["vehicle_mi24p_hind_chernobyl"] = "explosions/aerial_explosion_hind_chernobyl";
  var_5["vehicle_ny_harbor_hind"] = "explosions/aerial_explosion_hind_chernobyl";
  var_5["payback_vehicle_hind"] = "explosions/aerial_explosion_hind_chernobyl";

  if(isDefined(var_3)) {
    maps\_vehicle::_id_2A4A("ny_harbor_hind_sideturret", "tag_doorgun", "weapon_dshk", undefined, "auto_ai", 0.5, 20, -14);

  }
  maps\_vehicle::_id_2AC1( % bh_rotors, undefined, 0);
  maps\_vehicle::_id_2A02("explosions/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::_id_2A02("explosions/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::_id_2A02("fire/fire_smoke_trail_L", "tail_rotor_jnt", "hind_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::_id_2A02("explosions/aerial_explosion", "tag_engine_right", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::_id_2A02("explosions/aerial_explosion", "tag_deathfx", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::_id_2A02(var_4[var_0], undefined, "hind_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::_id_2A04(var_5[var_0], "tag_deathfx", "hind_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("axis");
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
  maps\_vehicle::_id_2ACC(::_id_3E84);
  maps\_vehicle::_id_2ACD(::_id_3E58);
  var_6 = randomfloatrange(0, 1);
  var_7 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_7, "cockpit_blue_cargo01", "tag_light_cargo01", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::_id_2AAD(var_7, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::_id_2AAD(var_7, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_6);
  maps\_vehicle::_id_2AAD(var_7, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_red_blink", "running", var_6);
  maps\_vehicle::_id_2AAD(var_7, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_6);
  maps\_vehicle::_id_2AAD(var_7, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_6);
  maps\_vehicle::_id_2AAD(var_7, "spot", "tag_passenger", "misc/aircraft_light_hindspot", "spot", 0.0);
  maps\_vehicle::_id_2AC8(1);
}

_id_2B1D() {
  if(maps\_utility::_id_1E25()) {
    self._id_295E = 144;
    self._id_295A = 762;
  } else {
    self._id_295A = 906;

  }
  self._id_2941 = 0;
  maps\_vehicle::_id_2AB3("running");
}

_id_3A9C(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1]._id_2523 = % bh_idle;

  }
  return var_0;
}

#using_animtree("fastrope");

_id_3E83(var_0) {
  var_0[3]._id_254F = % bh_player_idle;
  var_0[3]._id_258C = "fastrope_start_plr";
  var_0[3]._id_258F = "fastrope_loop_plr";
  var_0[3]._id_2597 = "fastrope_end_plr";
  var_0[3]._id_258A = % bh_player_drop;
  var_0[3]._id_2AA4 = #animtree;
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 9; var_1++) {
    var_0[var_1] = spawnStruct();

  }
  var_0[0]._id_0F59[0] = % helicopter_pilot1_idle;
  var_0[0]._id_0F59[1] = % helicopter_pilot1_twitch_clickpannel;
  var_0[0]._id_0F59[2] = % helicopter_pilot1_twitch_lookback;
  var_0[0]._id_0F59[3] = % helicopter_pilot1_twitch_lookoutside;
  var_0[0]._id_254D[0] = 500;
  var_0[0]._id_254D[1] = 100;
  var_0[0]._id_254D[2] = 100;
  var_0[0]._id_254D[3] = 100;
  var_0[1]._id_0F59[0] = % helicopter_pilot2_idle;
  var_0[1]._id_0F59[1] = % helicopter_pilot2_twitch_clickpannel;
  var_0[1]._id_0F59[2] = % helicopter_pilot2_twitch_lookoutside;
  var_0[1]._id_0F59[3] = % helicopter_pilot2_twitch_radio;
  var_0[1]._id_254D[0] = 450;
  var_0[1]._id_254D[1] = 100;
  var_0[1]._id_254D[2] = 100;
  var_0[1]._id_254D[3] = 100;
  var_0[0]._id_24F4 = 0;
  var_0[1]._id_24F4 = 0;
  var_0[2]._id_0F59 = % bh_1_idle;
  var_0[3]._id_0F59 = % bh_2_idle;
  var_0[4]._id_0F59 = % bh_4_idle;
  var_0[5]._id_0F59 = % bh_5_idle;
  var_0[6]._id_0F59 = % bh_8_idle;
  var_0[7]._id_0F59 = % bh_6_idle;
  var_0[8]._id_0F59 = % bh_7_idle;
  var_0[0]._id_24F2 = "tag_driver";
  var_0[1]._id_24F2 = "tag_passenger";
  var_0[2]._id_24F2 = "tag_detach";
  var_0[3]._id_24F2 = "tag_detach";
  var_0[4]._id_24F2 = "tag_detach";
  var_0[5]._id_24F2 = "tag_detach";
  var_0[6]._id_24F2 = "tag_detach";
  var_0[7]._id_24F2 = "tag_detach";
  var_0[8]._id_24F2 = "tag_detach";
  var_0[2]._id_257C = % bh_1_drop;
  var_0[3]._id_257C = % bh_2_drop;
  var_0[4]._id_257C = % bh_4_drop;
  var_0[5]._id_257C = % bh_5_drop;
  var_0[6]._id_257C = % bh_8_drop;
  var_0[7]._id_257C = % bh_6_drop;
  var_0[8]._id_257C = % bh_7_drop;
  var_0[2]._id_259A = "crouch";
  var_0[3]._id_259A = "crouch";
  var_0[4]._id_259A = "crouch";
  var_0[5]._id_259A = "crouch";
  var_0[6]._id_259A = "crouch";
  var_0[7]._id_259A = "crouch";
  var_0[8]._id_259A = "crouch";
  var_0[2]._id_2571 = 1;
  var_0[3]._id_2571 = 1;
  var_0[4]._id_2571 = 1;
  var_0[5]._id_2571 = 1;
  var_0[6]._id_2571 = 1;
  var_0[7]._id_2571 = 1;
  var_0[8]._id_2571 = 1;
  var_0[2]._id_2592 = % fastrope_fall;
  var_0[3]._id_2592 = % fastrope_fall;
  var_0[4]._id_2592 = % fastrope_fall;
  var_0[5]._id_2592 = % fastrope_fall;
  var_0[6]._id_2592 = % fastrope_fall;
  var_0[7]._id_2592 = % fastrope_fall;
  var_0[8]._id_2592 = % fastrope_fall;
  var_0[1]._id_2590 = 1;
  var_0[2]._id_2590 = 1;
  var_0[3]._id_2590 = 1;
  var_0[4]._id_2590 = 1;
  var_0[5]._id_2590 = 1;
  var_0[6]._id_2590 = 1;
  var_0[7]._id_2590 = 1;
  var_0[8]._id_2590 = 1;
  var_0[2]._id_258D = "fastrope_loop_npc";
  var_0[3]._id_258D = "fastrope_loop_npc";
  var_0[4]._id_258D = "fastrope_loop_npc";
  var_0[5]._id_258D = "fastrope_loop_npc";
  var_0[6]._id_258D = "fastrope_loop_npc";
  var_0[7]._id_258D = "fastrope_loop_npc";
  var_0[8]._id_258D = "fastrope_loop_npc";
  var_0[2]._id_256A = "TAG_FastRope_RI";
  var_0[3]._id_256A = "TAG_FastRope_RI";
  var_0[4]._id_256A = "TAG_FastRope_LE";
  var_0[5]._id_256A = "TAG_FastRope_LE";
  var_0[6]._id_256A = "TAG_FastRope_RI";
  var_0[7]._id_256A = "TAG_FastRope_LE";
  var_0[8]._id_256A = "TAG_FastRope_RI";
  return _id_3E83(var_0);
}

_id_3E58() {
  var_0 = [];
  var_0["left"] = [];
  var_0["right"] = [];
  var_0["both"] = [];
  var_0["left"][var_0["left"].size] = 4;
  var_0["left"][var_0["left"].size] = 5;
  var_0["left"][var_0["left"].size] = 7;
  var_0["right"][var_0["right"].size] = 2;
  var_0["right"][var_0["right"].size] = 3;
  var_0["right"][var_0["right"].size] = 6;
  var_0["right"][var_0["right"].size] = 8;
  var_0["both"][var_0["both"].size] = 2;
  var_0["both"][var_0["both"].size] = 3;
  var_0["both"][var_0["both"].size] = 4;
  var_0["both"][var_0["both"].size] = 5;
  var_0["both"][var_0["both"].size] = 6;
  var_0["both"][var_0["both"].size] = 7;
  var_0["both"][var_0["both"].size] = 8;
  var_0["default"] = var_0["both"];
  return var_0;
}

_id_3E84() {
  var_0 = [];
  var_0["TAG_FastRope_LE"] = spawnStruct();
  var_0["TAG_FastRope_LE"].model = "rope_test";
  var_0["TAG_FastRope_LE"].tag = "TAG_FastRope_LE";
  var_0["TAG_FastRope_LE"]._id_2018 = % bh_rope_idle_le;
  var_0["TAG_FastRope_LE"]._id_2577 = % bh_rope_drop_le;
  var_0["TAG_FastRope_RI"] = spawnStruct();
  var_0["TAG_FastRope_RI"].model = "rope_test_ri";
  var_0["TAG_FastRope_RI"].tag = "TAG_FastRope_RI";
  var_0["TAG_FastRope_RI"]._id_2018 = % bh_rope_idle_ri;
  var_0["TAG_FastRope_RI"]._id_2577 = % bh_rope_drop_ri;
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    precachemodel(var_0[var_1[var_2]].model);

  }
  return var_0;
}