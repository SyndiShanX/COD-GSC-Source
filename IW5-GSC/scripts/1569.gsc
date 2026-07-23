/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1569.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("blackhawk", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_blackhawk");
  maps\_vehicle::build_deathmodel("vehicle_blackhawk_low");
  maps\_vehicle::build_deathmodel("vehicle_blackhawk_low_thermal");
  maps\_vehicle::build_deathmodel("vehicle_blackhawk_hero_sas_night");
  maps\_vehicle::build_drive(%bh_rotors, undefined, 0);
  var_3 = [];
  var_3["vehicle_blackhawk"] = "explosions/helicopter_explosion";
  var_3["vehicle_blackhawk_sas_night"] = "explosions/helicopter_explosion";
  var_3["vehicle_blackhawk_hero_sas_night"] = "explosions/helicopter_explosion";
  var_3["vehicle_blackhawk_hero"] = "explosions/helicopter_explosion";
  var_3["vehicle_blackhawk_low"] = "explosions/large_vehicle_explosion";
  var_3["vehicle_blackhawk_low_thermal"] = "explosions/large_vehicle_explosion";
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "tag_engine_left", "blackhawk_helicopter_hit", undefined, undefined, undefined, 0.2, 1);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "elevator_jnt", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1);
  maps\_vehicle::build_deathfx("fire/fire_smoke_trail_L", "elevator_jnt", "blackhawk_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "tag_engine_right", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1);
  maps\_vehicle::build_deathfx("explosions/helicopter_explosion_secondary_small", "tag_deathfx", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  maps\_vehicle::build_deathfx(var_3[var_0], undefined, "blackhawk_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_rocket_deathfx("explosions/aerial_explosion_heli_large", "tag_deathfx", "blackhawk_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_attach_models(::_id_3E84);
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_bulletshield(1);
  var_4 = randomfloatrange(0, 1);
  var_5 = maps\_vehicle::get_light_model(var_0, var_2);
  maps\_vehicle::build_light(var_5, "cockpit_blue_cargo01", "tag_light_cargo01", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_5, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.0);
  maps\_vehicle::build_light(var_5, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::build_light(var_5, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_white_blink", "running", var_4);
  maps\_vehicle::build_light(var_5, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", var_4);
  maps\_vehicle::build_light(var_5, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", var_4);
}

init_local() {
  if(maps\_utility::is_iw4_map_sp()) {
    self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
    self.fastropeoffset = 762;
  } else {
    self.fastropeoffset = 762 + distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  }
  self.script_badplace = 0;
}

set_vehicle_anims(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].vehicle_getoutanim = % bh_idle;
  }
  return var_0;
}

#using_animtree("fastrope");

_id_3E83(var_0) {
  var_0[3].player_idle = % bh_player_idle;
  var_0[3].player_getout_sound = "fastrope_start_plr";
  var_0[3].player_getout_sound_loop = "fastrope_loop_plr";
  var_0[3].player_getout_sound_end = "fastrope_end_plr";
  var_0[3].player_getout = % bh_player_drop;
  var_0[3].player_animtree = #animtree;
  var_0[2].player_idle = % bh_player_idle;
  var_0[2].player_getout_sound = "fastrope_start_plr";
  var_0[2].player_getout_sound_loop = "fastrope_loop_plr";
  var_0[2].player_getout_sound_end = "fastrope_end_plr";
  var_0[2].player_getout = % bh_player_drop;
  var_0[2].player_animtree = #animtree;
  var_0[6].player_idle = % bh_player_idle;
  var_0[6].player_getout_sound = "fastrope_start_plr";
  var_0[6].player_getout_sound_loop = "fastrope_loop_plr";
  var_0[6].player_getout_sound_end = "fastrope_end_plr";
  var_0[6].player_getout = % bh_player_drop;
  var_0[6].player_animtree = #animtree;
  return var_0;
}

#using_animtree("generic_human");

_id_3E85(var_0) {
  var_0[3].player_getout = % bh_2_drop;
  var_0[3].player_animtree = #animtree;
  var_0[6].player_getout = % bh_8_drop;
  var_0[6].player_animtree = #animtree;
  return var_0;
}

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0].idle = % bh_pilot_idle;
  var_0[1].idle = % bh_copilot_idle;
  var_0[2].idle = % bh_1_idle;
  var_0[3].idle = % bh_2_idle;
  var_0[4].idle = % bh_4_idle;
  var_0[5].idle = % bh_5_idle;
  var_0[6].idle = % bh_8_idle;
  var_0[7].idle = % bh_6_idle;
  var_0[0].sittag = "tag_detach";
  var_0[1].sittag = "tag_detach";
  var_0[2].sittag = "tag_detach";
  var_0[3].sittag = "tag_detach";
  var_0[4].sittag = "tag_detach";
  var_0[5].sittag = "tag_detach";
  var_0[6].sittag = "tag_detach";
  var_0[7].sittag = "tag_detach";
  var_0[2].getout = % bh_1_drop;
  var_0[3].getout = % bh_2_drop;
  var_0[4].getout = % bh_4_drop;
  var_0[5].getout = % bh_5_drop;
  var_0[6].getout = % bh_8_drop;
  var_0[7].getout = % bh_6_drop;
  var_0[2].getoutstance = "crouch";
  var_0[3].getoutstance = "crouch";
  var_0[4].getoutstance = "crouch";
  var_0[5].getoutstance = "crouch";
  var_0[6].getoutstance = "crouch";
  var_0[7].getoutstance = "crouch";
  var_0[2].ragdoll_getout_death = 1;
  var_0[3].ragdoll_getout_death = 1;
  var_0[4].ragdoll_getout_death = 1;
  var_0[5].ragdoll_getout_death = 1;
  var_0[6].ragdoll_getout_death = 1;
  var_0[7].ragdoll_getout_death = 1;
  var_0[2].ragdoll_fall_anim = % fastrope_fall;
  var_0[3].ragdoll_fall_anim = % fastrope_fall;
  var_0[4].ragdoll_fall_anim = % fastrope_fall;
  var_0[5].ragdoll_fall_anim = % fastrope_fall;
  var_0[6].ragdoll_fall_anim = % fastrope_fall;
  var_0[7].ragdoll_fall_anim = % fastrope_fall;
  var_0[1].rappel_kill_achievement = 1;
  var_0[2].rappel_kill_achievement = 1;
  var_0[3].rappel_kill_achievement = 1;
  var_0[4].rappel_kill_achievement = 1;
  var_0[5].rappel_kill_achievement = 1;
  var_0[6].rappel_kill_achievement = 1;
  var_0[7].rappel_kill_achievement = 1;
  var_0[2].getoutloopsnd = "fastrope_loop_npc";
  var_0[3].getoutloopsnd = "fastrope_loop_npc";
  var_0[4].getoutloopsnd = "fastrope_loop_npc";
  var_0[5].getoutloopsnd = "fastrope_loop_npc";
  var_0[6].getoutloopsnd = "fastrope_loop_npc";
  var_0[7].getoutloopsnd = "fastrope_loop_npc";
  var_0[2].fastroperig = "TAG_FastRope_RI";
  var_0[3].fastroperig = "TAG_FastRope_RI";
  var_0[4].fastroperig = "TAG_FastRope_LE";
  var_0[5].fastroperig = "TAG_FastRope_LE";
  var_0[6].fastroperig = "TAG_FastRope_RI";
  var_0[7].fastroperig = "TAG_FastRope_LE";
  return _id_3E83(var_0);
  return _id_3E85(var_0);
}

unload_groups() {
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
  var_0["both"][var_0["both"].size] = 2;
  var_0["both"][var_0["both"].size] = 3;
  var_0["both"][var_0["both"].size] = 4;
  var_0["both"][var_0["both"].size] = 5;
  var_0["both"][var_0["both"].size] = 6;
  var_0["both"][var_0["both"].size] = 7;
  var_0["default"] = var_0["both"];
  return var_0;
}

_id_3E84() {
  var_0 = [];
  var_0["TAG_FastRope_LE"] = spawnStruct();
  var_0["TAG_FastRope_LE"].model = "rope_test";
  var_0["TAG_FastRope_LE"].tag = "TAG_FastRope_LE";
  var_0["TAG_FastRope_LE"].idleanim = % bh_rope_idle_le;
  var_0["TAG_FastRope_LE"].dropanim = % bh_rope_drop_le;
  var_0["TAG_FastRope_RI"] = spawnStruct();
  var_0["TAG_FastRope_RI"].model = "rope_test_ri";
  var_0["TAG_FastRope_RI"].tag = "TAG_FastRope_RI";
  var_0["TAG_FastRope_RI"].idleanim = % bh_rope_idle_ri;
  var_0["TAG_FastRope_RI"].dropanim = % bh_rope_drop_ri;
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    precachemodel(var_0[var_1[var_2]].model);
  }
  return var_0;
}