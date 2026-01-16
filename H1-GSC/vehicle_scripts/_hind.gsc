/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_hind.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2, var_3) {
  maps\_vehicle::build_template("hind", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_mi24p_hind_desert");
  maps\_vehicle::build_deathmodel("vehicle_mi24p_hind_woodland");
  maps\_vehicle::build_deathmodel("vehicle_mi24p_hind_woodland_opened_door");
  var_4 = [];
  var_4["vehicle_mi24p_hind_desert"] = "fx\explosions\helicopter_explosion_hind_desert";
  var_4["vehicle_mi24p_hind_woodland"] = "fx\explosions\helicopter_explosion_hind_woodland";
  var_4["vehicle_mi24p_hind_woodland_opened_door"] = "fx\explosions\helicopter_explosion_hind_woodland";
  var_4["vehicle_mi24p_hind_chernobyl"] = "fx\explosions\helicopter_explosion_hind_woodland";
  maps\_vehicle::build_drive( % bh_rotors, undefined, 0);
  maps\_vehicle::build_deathfx("fx\explosions\grenadeexp_default", "tag_engine_left", "hind_helicopter_hit", undefined, undefined, undefined, 0.2, 1, undefined);
  maps\_vehicle::build_deathfx("fx\explosions\grenadeexp_default", "tail_rotor_jnt", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 0.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx\fire\fire_smoke_trail_L", "tail_rotor_jnt", "hind_helicopter_dying_loop", 1, 0.05, 1, 0.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx\explosions\aerial_explosion", "tag_engine_right", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 2.5, 1, undefined);
  maps\_vehicle::build_deathfx("fx\explosions\aerial_explosion", "tag_deathfx", "hind_helicopter_secondary_exp", undefined, undefined, undefined, 4.0, undefined, undefined);
  maps\_vehicle::build_deathfx(var_4[var_0], undefined, "hind_helicopter_crash", undefined, undefined, undefined, -1, undefined, "stop_crash_loop_sound");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_attach_models(::set_attached_models);
  maps\_vehicle::build_unload_groups(::unload_groups);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cargo01", "tag_light_cargo01", "fx\misc\aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "fx\misc\aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx\misc\aircraft_light_white_blink", "running", 0.0);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx\misc\aircraft_light_red_blink", "running", 0.3);
  maps\_vehicle::build_light(var_2, "wingtip_green", "tag_light_L_wing", "fx\misc\aircraft_light_wingtip_green", "running", 0.0);
  maps\_vehicle::build_light(var_2, "wingtip_red", "tag_light_R_wing", "fx\misc\aircraft_light_wingtip_red", "running", 0.0);
  maps\_vehicle::build_is_helicopter();
}

init_local() {
  self.originheightoffset = 144;
  self.fastropeoffset = 792;
  self.script_badplace = 0;
  maps\_vehicle::vehicle_lights_on("running");
  handle_audio();
}

handle_audio() {
  self endon("death");
  var_0 = 0;
  var_1 = 144000000;
  vehicle_scripts\_hind_aud::snd_init_hind();
  thread monitor_death_stop_sounds();

  for (;;) {
    if(!isdefined(self.script_disablevehicleaudio) || !self.script_disablevehicleaudio) {
      var_2 = distancesquared(self.origin, level.player.origin);

      if(var_0 && var_2 > var_1) {
        vehicle_scripts\_hind_aud::snd_stop_hind(1.0);
        var_0 = 0;
        wait 0.1;
      } else if(!var_0 && var_2 <= var_1) {
        vehicle_scripts\_hind_aud::snd_start_hind();
        var_0 = 1;
      }
    } else if(var_0) {
      vehicle_scripts\_hind_aud::snd_stop_hind(1.0);
      var_0 = 0;
    }

    wait 0.1;
  }
}

monitor_death_stop_sounds() {
  self waittill("death");
  vehicle_scripts\_hind_aud::snd_stop_hind(1.0);
}

set_vehicle_anims(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1].vehicle_getoutanim = % bh_idle;

  return var_0;
}

#using_animtree("fastrope");

setplayer_anims(var_0) {
  var_0[3].player_idle = % bh_player_idle;
  var_0[3].player_getout_sound = "fastrope_start_plr";
  var_0[3].player_getout_sound_loop = "fastrope_loop_plr";
  var_0[3].player_getout_sound_end = "fastrope_end_plr";
  var_0[3].player_getout = % bh_player_drop;
  var_0[3].player_animtree = #animtree;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 9; var_1++)
    var_0[var_1] = spawnstruct();

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
  var_0[2].sittag = "tag_detach";
  var_0[3].sittag = "tag_detach";
  var_0[4].sittag = "tag_detach";
  var_0[5].sittag = "tag_detach";
  var_0[6].sittag = "tag_detach";
  var_0[7].sittag = "tag_detach";
  var_0[8].sittag = "tag_detach";
  var_0[2].getout = % bh_1_drop;
  var_0[3].getout = % bh_2_drop;
  var_0[4].getout = % bh_4_drop;
  var_0[5].getout = % bh_5_drop;
  var_0[6].getout = % bh_8_drop;
  var_0[7].getout = % bh_6_drop;
  var_0[8].getout = % bh_7_drop;
  var_0[2].getoutstance = "crouch";
  var_0[3].getoutstance = "crouch";
  var_0[4].getoutstance = "crouch";
  var_0[5].getoutstance = "crouch";
  var_0[6].getoutstance = "crouch";
  var_0[7].getoutstance = "crouch";
  var_0[8].getoutstance = "crouch";
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
  var_0[2].getoutloopsnd = "fastrope_loop_npc";
  var_0[3].getoutloopsnd = "fastrope_loop_npc";
  var_0[4].getoutloopsnd = "fastrope_loop_npc";
  var_0[5].getoutloopsnd = "fastrope_loop_npc";
  var_0[6].getoutloopsnd = "fastrope_loop_npc";
  var_0[7].getoutloopsnd = "fastrope_loop_npc";
  var_0[8].getoutloopsnd = "fastrope_loop_npc";
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
  var_0["TAG_FastRope_LE"] = spawnstruct();
  var_0["TAG_FastRope_LE"].model = "rope_test";
  var_0["TAG_FastRope_LE"].tag = "TAG_FastRope_LE";
  var_0["TAG_FastRope_LE"].idleanim = % bh_rope_idle_le;
  var_0["TAG_FastRope_LE"].dropanim = % bh_rope_drop_le;
  var_0["TAG_FastRope_RI"] = spawnstruct();
  var_0["TAG_FastRope_RI"].model = "rope_test_ri";
  var_0["TAG_FastRope_RI"].tag = "TAG_FastRope_RI";
  var_0["TAG_FastRope_RI"].idleanim = % bh_rope_idle_ri;
  var_0["TAG_FastRope_RI"].dropanim = % bh_rope_drop_ri;
  var_1 = getarraykeys(var_0);

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    precachemodel(var_0[var_1[var_2]].model);

  return var_0;
}