/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\nh90.gsc
*****************************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("nh90", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_drive(%bh_rotors, undefined, 0);
  var_3 = [];
  var_3["vehicle_nh90"] = "vfx/gameplay/explosions/vfx_exp_silenthawk_end";
  var_3["vehicle_nh90_no_lod"] = "vfx/gameplay/explosions/vfx_exp_silenthawk_end";
  var_3["vehicle_nh90_cheap"] = "vfx/gameplay/explosions/vfx_exp_silenthawk_end";
  var_3["vehicle_nh90_interior"] = "vfx/gameplay/explosions/vfx_exp_silenthawk_end";
  var_3["vehicle_nh90_cheap_full_interior"] = "vfx/gameplay/explosions/vfx_exp_silenthawk_end";
  var_4 = var_3[var_0];

  if(var_2 != "script_vehicle_nh90_cheaper") {
    maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_nh90_deathspin", "tag_rotor_fx", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 0.1, undefined, undefined);
    maps\_vehicle::build_deathfx("vfx/gameplay/explosions/vfx_exp_silenthawk_init", "tag_rotor_fx", "blackhawk_helicopter_secondary_exp", undefined, undefined, undefined, 0.1, undefined, undefined);
    maps\_vehicle::build_deathfx(var_4, undefined, "blackhawk_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
    maps\_vehicle::build_rocket_deathfx("vfx/gameplay/explosions/vfx_exp_nh90_deathspin", "tag_deathfx", undefined, undefined, undefined, undefined, undefined, 1, undefined, 0);
    maps\_vehicle::build_rocket_deathfx("vfx/gameplay/explosions/vfx_exp_silenthawk_init", "tag_deathfx", undefined, undefined, undefined, undefined, undefined, 1, undefined, 0);
    maps\_vehicle::build_mainturret();
  }

  maps\_vehicle::build_treadfx(var_2, "default", "vfx/gameplay/tread_fx/vfx_heli_dust", 0);
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");

  if(var_2 != "script_vehicle_nh90_cheaper") {
    maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
    maps\_vehicle::build_attach_models(::set_attached_models);
    maps\_vehicle::build_unload_groups(::unload_groups);
  }

  var_5 = "minigun_littlebird_spinnup";
  var_6 = randomfloatrange(0, 1);

  if(var_2 != "script_vehicle_nh90_cheaper") {
    maps\_vehicle::build_light(var_2, "cockpit_blue_cargo01", "tag_light_cargo01", "fx/misc/aircraft_light_cockpit_red", "interior", 0.0);
    maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "fx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
    maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_white_blink", "running", var_6);
    maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx/misc/aircraft_light_red_blink", "running", var_6);
    maps\_vehicle::build_light(var_2, "wingtip_green", "tag_light_L_wing", "fx/misc/aircraft_light_wingtip_green", "running", var_6);
    maps\_vehicle::build_light(var_2, "wingtip_red", "tag_light_R_wing", "fx/misc/aircraft_light_wingtip_red", "running", var_6);
    maps\_vehicle::build_light(var_2, "spot", "tag_passenger", "fx/misc/aircraft_light_hindspot", "spot", 0.0);
  }

  maps\_vehicle::build_is_helicopter();
}

init_local() {
  if(self.classname != "script_vehicle_nh90_cheaper")
    self.fastropeoffset = 744 + distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));

  self.script_badplace = 0;
  maps\_vehicle::vehicle_lights_on("running");
}

set_vehicle_anims(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].vehicle_getoutanim = % bh_idle;

  return var_0;
}

#using_animtree("fastrope");

setplayer_anims(var_0) {
  var_0[3].player_idle = % bh_player_idle;
  var_0[3].player_getout = % bh_player_drop;
  var_0[3].player_animtree = #animtree;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 9; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].idle[0] = % helicopter_pilot1_idle;
  var_0[0].idle[1] = % helicopter_pilot1_twitch_clickpannel;
  var_0[0].idle[2] = % helicopter_pilot1_twitch_lookback;
  var_0[0].idle[3] = % helicopter_pilot1_twitch_lookoutside;
  var_0[0].idleoccurrence[0] = 500;
  var_0[0].idleoccurrence[1] = 100;
  var_0[0].idleoccurrence[2] = 100;
  var_0[0].idleoccurrence[3] = 100;
  var_0[1].idle[0] = % helicopter_pilot2_idle;
  var_0[1].idle[1] = % helicopter_pilot2_twitch_clickpannel;
  var_0[1].idle[2] = % helicopter_pilot2_twitch_lookoutside;
  var_0[1].idle[3] = % helicopter_pilot2_twitch_radio;
  var_0[1].idleoccurrence[0] = 450;
  var_0[1].idleoccurrence[1] = 100;
  var_0[1].idleoccurrence[2] = 100;
  var_0[1].idleoccurrence[3] = 100;
  var_0[0].bhasgunwhileriding = 0;
  var_0[1].bhasgunwhileriding = 0;
  var_0[2].idle = % bh_1_idle;
  var_0[3].idle = % bh_2_idle;
  var_0[4].idle = % bh_4_idle;
  var_0[5].idle = % bh_5_idle;
  var_0[6].idle = % bh_8_idle;
  var_0[7].idle = % bh_6_idle;
  var_0[8].idle = % bh_7_idle;
  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[2].sittag = "tag_detach_r";
  var_0[3].sittag = "tag_detach_r";
  var_0[4].sittag = "tag_detach_l";
  var_0[5].sittag = "tag_detach_l";
  var_0[6].sittag = "tag_detach_l";
  var_0[7].sittag = "tag_detach_l";
  var_0[8].sittag = "tag_detach_r";
  var_0[2].getout = % bh_1_drop;
  var_0[3].getout = % bh_2_drop;
  var_0[4].getout = % bh_4_drop;
  var_0[5].getout = % bh_5_drop;
  var_0[6].getout = % bh_8_drop;
  var_0[7].getout = % bh_6_drop;
  var_0[8].getout = % bh_7_drop;
  var_0[2].getoutstance = "stand";
  var_0[3].getoutstance = "stand";
  var_0[4].getoutstance = "stand";
  var_0[5].getoutstance = "stand";
  var_0[6].getoutstance = "stand";
  var_0[7].getoutstance = "stand";
  var_0[8].getoutstance = "stand";
  var_0[2].ragdoll_getout_death = 1;
  var_0[3].ragdoll_getout_death = 1;
  var_0[4].ragdoll_getout_death = 1;
  var_0[5].ragdoll_getout_death = 1;
  var_0[6].ragdoll_getout_death = 1;
  var_0[7].ragdoll_getout_death = 1;
  var_0[8].ragdoll_getout_death = 1;
  var_0[2].ragdoll_fall_anim = % fastrope_fall;
  var_0[3].ragdoll_fall_anim = % fastrope_fall;
  var_0[4].ragdoll_fall_anim = % fastrope_fall;
  var_0[5].ragdoll_fall_anim = % fastrope_fall;
  var_0[6].ragdoll_fall_anim = % fastrope_fall;
  var_0[7].ragdoll_fall_anim = % fastrope_fall;
  var_0[8].ragdoll_fall_anim = % fastrope_fall;
  var_0[1].rappel_kill_achievement = 1;
  var_0[2].rappel_kill_achievement = 1;
  var_0[3].rappel_kill_achievement = 1;
  var_0[4].rappel_kill_achievement = 1;
  var_0[5].rappel_kill_achievement = 1;
  var_0[6].rappel_kill_achievement = 1;
  var_0[7].rappel_kill_achievement = 1;
  var_0[8].rappel_kill_achievement = 1;
  var_0[2].fastroperig = "TAG_FastRope_RI";
  var_0[3].fastroperig = "TAG_FastRope_RI";
  var_0[4].fastroperig = "TAG_FastRope_LE";
  var_0[5].fastroperig = "TAG_FastRope_LE";
  var_0[6].fastroperig = "TAG_FastRope_RI";
  var_0[7].fastroperig = "TAG_FastRope_LE";
  var_0[8].fastroperig = "TAG_FastRope_RI";
  return setplayer_anims(var_0);
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

set_attached_models() {
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

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    precachemodel(var_0[var_1[var_2]].model);

  return var_0;
}