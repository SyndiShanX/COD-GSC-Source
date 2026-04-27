/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_hind.gsc
********************************************************/

#include maps\_vehicle;
#include maps\_vehicle_aianim;
#using_animtree("vehicles");
main(model, type) {
  build_template("hind", model, type);
  build_localinit(::init_local);

  build_deathmodel("vehicle_mi24p_hind_desert");
  build_deathmodel("vehicle_mi24p_hind_woodland");
  build_deathmodel("vehicle_mi24p_hind_woodland_opened_door");

  hind_death_fx = [];
  hind_death_fx["vehicle_mi24p_hind_desert"] = "explosions/helicopter_explosion_hind_desert";
  hind_death_fx["vehicle_mi24p_hind_woodland"] = "explosions/helicopter_explosion_hind_woodland";
  hind_death_fx["vehicle_mi24p_hind_woodland_opened_door"] = "explosions/helicopter_explosion_hind_woodland";
  hind_death_fx["vehicle_mi24p_hind_chernobyl"] = "explosions/helicopter_explosion_hind_chernobyl";

  hind_aerial_death_fx = [];
  hind_aerial_death_fx["vehicle_mi24p_hind_desert"] = "explosions/aerial_explosion_hind_desert";
  hind_aerial_death_fx["vehicle_mi24p_hind_woodland"] = "explosions/aerial_explosion_hind_woodland";
  hind_aerial_death_fx["vehicle_mi24p_hind_woodland_opened_door"] = "explosions/aerial_explosion_hind_woodland";
  hind_aerial_death_fx["vehicle_mi24p_hind_chernobyl"] = "explosions/aerial_explosion_hind_chernobyl";

  build_drive(%bh_rotors, undefined, 0);

  build_deathfx("explosions/grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, true);
  build_deathfx("explosions/grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, true);
  build_deathfx("fire/fire_smoke_trail_L", "tail_rotor_jnt", "hind_helicopter_dying_loop", true, 0.05, true, 0.5, true);
  build_deathfx("explosions/aerial_explosion", "tag_engine_right", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, true);
  build_deathfx("explosions/aerial_explosion", "tag_deathfx", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 4.0);
  build_deathfx(hind_death_fx[model], undefined, "hind_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");

  build_rocket_deathfx(hind_aerial_death_fx[model], "tag_deathfx", "hind_helicopter_crash", undefined, undefined, undefined, undefined, true, undefined, 0);

  build_treadfx();

  build_life(999, 500, 1500);

  build_team("axis");

  build_aianims(::setanims, ::set_vehicle_anims);

  build_attach_models(::set_attached_models);

  build_unload_groups(::Unload_Groups);

  randomStartDelay = randomfloatrange(0, 1);
  build_light(model, "cockpit_blue_cargo01", "tag_light_cargo01", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  build_light(model, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.1);
  build_light(model, "white_blink", "tag_light_belly", "misc/aircraft_light_white_blink", "running", randomStartDelay);
  build_light(model, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_red_blink", "running", randomStartDelay);
  build_light(model, "wingtip_green", "tag_light_L_wing", "misc/aircraft_light_wingtip_green", "running", randomStartDelay);
  build_light(model, "wingtip_red", "tag_light_R_wing", "misc/aircraft_light_wingtip_red", "running", randomStartDelay);
  build_compassicon("helicopter", false);

  build_bulletshield(true);
}

init_local() {
  self.originheightoffset = 144;

  self.fastropeoffset = 792;

  self.script_badplace = false;
  maps\_vehicle::lights_on("running");
}

set_vehicle_anims(positions) {
  for(i = 0; i < positions.size; i++)
    positions[i].vehicle_getoutanim = % bh_idle;

  return positions;
}

#using_animtree("fastrope");

setplayer_anims(positions) {
  positions[3].player_idle = % bh_player_idle;
  positions[3].player_getout_sound = "fastrope_start_plr";
  positions[3].player_getout_sound_loop = "fastrope_loop_plr";
  positions[3].player_getout_sound_end = "fastrope_end_plr";

  positions[3].player_getout = % bh_player_drop;
  positions[3].player_animtree = #animtree;

  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 9; i++)
    positions[i] = spawnStruct();

  positions[0].idle[0] = % helicopter_pilot1_idle;
  positions[0].idle[1] = % helicopter_pilot1_twitch_clickpannel;
  positions[0].idle[2] = % helicopter_pilot1_twitch_lookback;
  positions[0].idle[3] = % helicopter_pilot1_twitch_lookoutside;
  positions[0].idleoccurrence[0] = 500;
  positions[0].idleoccurrence[1] = 100;
  positions[0].idleoccurrence[2] = 100;
  positions[0].idleoccurrence[3] = 100;

  positions[1].idle[0] = % helicopter_pilot2_idle;
  positions[1].idle[1] = % helicopter_pilot2_twitch_clickpannel;
  positions[1].idle[2] = % helicopter_pilot2_twitch_lookoutside;
  positions[1].idle[3] = % helicopter_pilot2_twitch_radio;
  positions[1].idleoccurrence[0] = 450;
  positions[1].idleoccurrence[1] = 100;
  positions[1].idleoccurrence[2] = 100;
  positions[1].idleoccurrence[3] = 100;

  positions[0].bHasGunWhileRiding = false;
  positions[1].bHasGunWhileRiding = false;

  positions[2].idle = % bh_1_idle;
  positions[3].idle = % bh_2_idle;
  positions[4].idle = % bh_4_idle;
  positions[5].idle = % bh_5_idle;
  positions[6].idle = % bh_8_idle;
  positions[7].idle = % bh_6_idle;
  positions[8].idle = % bh_7_idle;

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_detach";
  positions[3].sittag = "tag_detach";
  positions[4].sittag = "tag_detach";
  positions[5].sittag = "tag_detach";
  positions[6].sittag = "tag_detach";
  positions[7].sittag = "tag_detach";
  positions[8].sittag = "tag_detach";

  positions[2].getout = % bh_1_drop;
  positions[3].getout = % bh_2_drop;
  positions[4].getout = % bh_4_drop;
  positions[5].getout = % bh_5_drop;
  positions[6].getout = % bh_8_drop;
  positions[7].getout = % bh_6_drop;
  positions[8].getout = % bh_7_drop;

  positions[2].getoutstance = "crouch";
  positions[3].getoutstance = "crouch";
  positions[4].getoutstance = "crouch";
  positions[5].getoutstance = "crouch";
  positions[6].getoutstance = "crouch";
  positions[7].getoutstance = "crouch";
  positions[8].getoutstance = "crouch";

  positions[2].ragdoll_getout_death = true;
  positions[3].ragdoll_getout_death = true;
  positions[4].ragdoll_getout_death = true;
  positions[5].ragdoll_getout_death = true;
  positions[6].ragdoll_getout_death = true;
  positions[7].ragdoll_getout_death = true;
  positions[8].ragdoll_getout_death = true;

  positions[2].ragdoll_fall_anim = % fastrope_fall;
  positions[3].ragdoll_fall_anim = % fastrope_fall;
  positions[4].ragdoll_fall_anim = % fastrope_fall;
  positions[5].ragdoll_fall_anim = % fastrope_fall;
  positions[6].ragdoll_fall_anim = % fastrope_fall;
  positions[7].ragdoll_fall_anim = % fastrope_fall;
  positions[8].ragdoll_fall_anim = % fastrope_fall;

  positions[1].rappel_kill_achievement = 1;
  positions[2].rappel_kill_achievement = 1;
  positions[3].rappel_kill_achievement = 1;
  positions[4].rappel_kill_achievement = 1;
  positions[5].rappel_kill_achievement = 1;
  positions[6].rappel_kill_achievement = 1;
  positions[7].rappel_kill_achievement = 1;
  positions[8].rappel_kill_achievement = 1;

  positions[2].getoutloopsnd = "fastrope_loop_npc";
  positions[3].getoutloopsnd = "fastrope_loop_npc";
  positions[4].getoutloopsnd = "fastrope_loop_npc";
  positions[5].getoutloopsnd = "fastrope_loop_npc";
  positions[6].getoutloopsnd = "fastrope_loop_npc";
  positions[7].getoutloopsnd = "fastrope_loop_npc";
  positions[8].getoutloopsnd = "fastrope_loop_npc";

  positions[2].fastroperig = "TAG_FastRope_RI";
  positions[3].fastroperig = "TAG_FastRope_RI";
  positions[4].fastroperig = "TAG_FastRope_LE";
  positions[5].fastroperig = "TAG_FastRope_LE";
  positions[6].fastroperig = "TAG_FastRope_RI";
  positions[7].fastroperig = "TAG_FastRope_LE";
  positions[8].fastroperig = "TAG_FastRope_RI";

  return setplayer_anims(positions);
}
unload_groups() {
  unload_groups = [];
  unload_groups["left"] = [];
  unload_groups["right"] = [];
  unload_groups["both"] = [];

  unload_groups["left"][unload_groups["left"].size] = 4;
  unload_groups["left"][unload_groups["left"].size] = 5;
  unload_groups["left"][unload_groups["left"].size] = 7;

  unload_groups["right"][unload_groups["right"].size] = 2;
  unload_groups["right"][unload_groups["right"].size] = 3;
  unload_groups["right"][unload_groups["right"].size] = 6;
  unload_groups["right"][unload_groups["right"].size] = 8;

  unload_groups["both"][unload_groups["both"].size] = 2;
  unload_groups["both"][unload_groups["both"].size] = 3;
  unload_groups["both"][unload_groups["both"].size] = 4;
  unload_groups["both"][unload_groups["both"].size] = 5;
  unload_groups["both"][unload_groups["both"].size] = 6;
  unload_groups["both"][unload_groups["both"].size] = 7;
  unload_groups["both"][unload_groups["both"].size] = 8;

  unload_groups["default"] = unload_groups["both"];

  return unload_groups;
}

set_attached_models() {
  array = [];
  array["TAG_FastRope_LE"] = spawnStruct();
  array["TAG_FastRope_LE"].model = "rope_test";
  array["TAG_FastRope_LE"].tag = "TAG_FastRope_LE";
  array["TAG_FastRope_LE"].idleanim = % bh_rope_idle_le;
  array["TAG_FastRope_LE"].dropanim = % bh_rope_drop_le;

  array["TAG_FastRope_RI"] = spawnStruct();
  array["TAG_FastRope_RI"].model = "rope_test_ri";
  array["TAG_FastRope_RI"].tag = "TAG_FastRope_RI";
  array["TAG_FastRope_RI"].idleanim = % bh_rope_idle_ri;
  array["TAG_FastRope_RI"].dropanim = % bh_rope_drop_ri;

  strings = getarraykeys(array);

  for(i = 0; i < strings.size; i++) {
    precachemodel(array[strings[i]].model);
  }

  return array;
}