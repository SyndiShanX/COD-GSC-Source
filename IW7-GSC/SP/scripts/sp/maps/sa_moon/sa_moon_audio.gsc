/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_audio.gsc
*****************************************************/

main() {
  _id_953A();
  _id_969E();
  thread _id_11926();
}

_id_953A() {
  scripts\engine\utility::flag_init("audio_maintenance");
  scripts\engine\utility::flag_init("breach_window_inner");
  scripts\engine\utility::flag_init("breach_window_outer");
  scripts\engine\utility::flag_init("jump_down");
}

_id_969E() {
  scripts\sp\anim::_id_17F6("ethan", "ik_out_start_left_hand", ::_id_677B, "hero_kill");
  scripts\sp\anim::_id_17F6("omar", "ik_out_start_left_hand", ::_id_C486, "hero_kill");
  anim.notetracks["enemy1_meleecharge"] = ::_id_63AF;
  anim.notetracks["enemy1_grunt"] = ::_id_63AC;
  anim.notetracks["enemy2_grunt"] = ::_id_63B0;
}

_id_11926() {
  wait 4;
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.2);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.2);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.2);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.2);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.2);
  soundsettimescalefactor("scn_fx_unres_2d", 0);
  soundsettimescalefactor("scn_fx_res_3d", 0.5);
  soundsettimescalefactor("scn_fx_unres_3d", 0.5);
  soundsettimescalefactor("voice_plr_2d", 0);
  soundsettimescalefactor("voice_air_3d", 0);
  soundsettimescalefactor("voice_radio_2d", 0);
  soundsettimescalefactor("voice_plr_breath_2d", 0);
  soundsettimescalefactor("special_lo_unres_1_2d", 0);
  soundsettimescalefactor("weap_npc_main_3d", 0.5);
  soundsettimescalefactor("weap_npc_mech_3d", 0.5);
  soundsettimescalefactor("plr_use_misc_unres_2d", 0);
  soundsettimescalefactor("foley_plr_step_2d", 0.5);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0.5);
  soundsettimescalefactor("bulletimpact_unres_3d_lim", 0.5);
  soundsettimescalefactor("explo_1_3d", 0.5);
  soundsettimescalefactor("explo_2_3d", 0.5);
  soundsettimescalefactor("explo_3_3d", 0.5);
  soundsettimescalefactor("explo_4_3d", 0.5);
  soundsettimescalefactor("explo_5_3d", 0.5);
  soundsettimescalefactor("explo_lfe_3d", 0);
  soundsettimescalefactor("explo_dist_1_3d", 0.5);
  soundsettimescalefactor("explo_dist_2_3d", 0.5);
}

_id_677B(var_0) {
  var_0 playSound("moon_ethan_hallway_kill");
  _id_0F00::_id_CE21("moon_ethan_hallway_kill_glass", (6394, -499, 154));
}

_id_C486(var_0) {
  var_0 playSound("hallway_kill_exertion_omar");
  var_0 playSound("moon_omar_hallway_kill");
}

_id_63AF(var_0, var_1) {
  thread scripts\sp\utility::play_sound_on_tag("hallway_kill_charge", "j_head");
}

_id_63AC(var_0, var_1) {
  thread scripts\sp\utility::play_sound_on_tag("hallway_kill_pain", "j_head");
}

_id_63B0(var_0, var_1) {
  thread scripts\sp\utility::play_sound_on_tag("hallway_kill_death", "j_head");
}

_id_A0BA() {
  _id_9A9E();
}

_id_91B5() {
  setglobalsoundcontext("atmosphere", "space", 2);
  level.player clearsoundsubmix();
}

_id_2F5A() {
  level thread _id_0F00::_id_CD09("snd_battle_background_ambience", "sa_ext_battle_bg_distant", "entering_airlock");
  level thread _id_0F00::_id_CD09("snd_cap_ship_thruster_ambience", "sa_ext_cap_ship_thrusters", "entering_airlock");
  _id_91B4();
}

_id_9A7C() {
  setglobalsoundcontext("atmosphere", "space", 2);
  level.player setsoundsubmix("sa_ship_interior");
  thread _id_2FD2();
  scripts\engine\utility::flag_wait("player_finished_breach_enter");
  level.player setsoundsubmix("sa_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
  _id_0F00::_id_CD7B("amb_ship_hum_01", (4795, -393, 1391));
  _id_0F00::_id_CD7B("amb_ship_hum_04", (4535, -369, 1381));
  _id_0F00::_id_CD7B("amb_ship_hum_07", (4707, 256, 1485));
  wait 0.1;
  _id_0F00::_id_CD7B("amb_ship_vent_09", (5039, 334, 1492));
  _id_0F00::_id_CD7B("amb_ship_hum_11", (5200, -388, 1496));
  _id_0F00::_id_CD7B("emt_computer_hum_01_lp", (4713, -386, 1394));
  wait 0.1;
  _id_0F00::_id_CD7B("amb_bridge_broken_com_console", (4705, 0, 1425));
  thread _id_8895();
}

_id_B259() {}

_id_10ED3() {}

_id_6EF3() {
  thread _id_4D9A();
}

_id_3A83() {}

_id_68FD() {}

_id_691C() {}

_id_9A9E() {
  setglobalsoundcontext("atmosphere", "space", 2);
  level.player thread _id_0F33::_id_260C();
  level.player _meth_82C0("intro_cockpit_filter");
  level.player setsoundsubmix("sa_player_jackal_interior");
  level thread _id_0F00::_id_CD09("snd_battle_background_ambience", "sa_ext_battle_bg_distant", "bridge_breach_started");
  level thread _id_0F00::_id_CD09("snd_cap_ship_thruster_ambience", "sa_ext_cap_ship_thrusters", "bridge_breach_started");
  thread _id_BB22();
}

_id_A0B8() {
  if(!isDefined(level._id_9DD0))
    thread _id_EB17();

  thread _id_9AB7();
  thread _id_9AE0();
  wait 3;
  level.player clearclienttriggeraudiozone(2);
  thread _id_0F00::_id_A1C8();
  thread _id_0F00::_id_A070();
  thread _id_0F00::_id_A06F();
  thread _id_9AAA();
  thread _id_9AA9();
}

_id_EB17() {
  wait 4;
  setmusicstate("mx_106_moonbase_outsidecombat");
}

_id_91B4() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("sa_ext_expl_close", 2, 10, 4, 15, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("sa_ext_expl_med", 2, 5, 3, 7, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
}

_id_2F59() {
  setglobalsoundcontext("atmosphere", "space", 2);
  scripts\engine\utility::flag_wait("breach_end");
  thread _id_2FD2();
  scripts\engine\utility::flag_wait("bridge_gravity_restoring");
  wait 2;
  level.player setsoundsubmix("sa_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
}

_id_9A7B() {}

_id_B258() {
  scripts\engine\utility::flag_set("audio_maintenance");
  level.player setsoundsubmix("sa_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
  thread _id_9A63();
  setglobalsoundcontext("atmosphere", "helmet", 0);
}

_id_10ED2() {
  level.player setsoundsubmix("sa_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
  thread _id_9A63();
  setglobalsoundcontext("atmosphere", "helmet", 0);
}

_id_6EF2() {
  setglobalsoundcontext("atmosphere", "helmet", 0);
  level.player setsoundsubmix("sa_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
  thread _id_9A63();
}

_id_3A82() {
  level.player setsoundsubmix("sa_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
  thread _id_3A81();
  thread _id_5A11();
  wait 1;
  setglobalsoundcontext("atmosphere", "helmet", 0);
}

_id_68FB() {
  level.player setsoundsubmix("sa_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
  thread _id_3A81();
  setglobalsoundcontext("atmosphere", "helmet", 0);
}

_id_691B() {
  level.player setsoundsubmix("sa_ship_interior");
  level thread _id_0F00::_id_CDD7("war");
  thread _id_3A81();
  setglobalsoundcontext("atmosphere", "space", 2);
}

_id_2FD2() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("moon_int_explosion_sm", 0.2, 18, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.2, 0.1);
  thread _id_0F00::_id_FBEF("moon_int_explosion_lg", 0.2, 25, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.7, 0.1);
  thread _id_0F00::_id_FBEF("moon_int_mixed_battle_thumps", 2, 5, 4, 5, 5000, 6000, 10, 30, 50, 6, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_tracer_short", 1, 4, 2, 10, 100, 1000, 300, 45, 90, 1, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_jack_flyby", 3, 10, 1, 10, 100, 1000, 300, 180, 360, 2, 0, 0, 0);
  thread _id_0F00::_id_FBEF("sa_partial_expl_close", 2, 9, 4, 15, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("sa_partial_expl_med", 2, 6, 3, 7, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
}

_id_9A63() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large", 12, 24, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 10, 12, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 15, 17, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short", 9, 16, 3, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_servo_distant", 8, 12, 6, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_long_dist", 20, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_distant", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 22, 34, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium_distant", 10, 20, 9, 14, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_alarm_buzzer", 20, 31, 13, 15, 5000, 5001, 300, 0, 100, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_distant", 3, 10, 3, 10, 100, 1000, 300, 90, 90, 4, 0, 0, 0);
  thread _id_0F00::_id_FBEF("moon_int_explosion_sm", 0.2, 18, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.2, 0.1);
  thread _id_0F00::_id_FBEF("moon_int_explosion_lg", 0.2, 25, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.7, 0.1);
  thread _id_0F00::_id_FBEF("moon_int_mixed_battle_thumps", 4, 5, 4, 5, 5000, 6000, 10, 30, 50, 6, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_tracer_short", 4, 8, 2, 10, 100, 1000, 300, 45, 90, 1, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_jack_flyby", 18, 30, 1, 10, 100, 1000, 300, 180, 360, 2, 0, 0, 0);
}

_id_3A81() {
  level.player notify("started_dynamic_ambience");
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_medium", 8, 20, 0, 4, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_large_deep", 9, 20, 2, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_air_release_distant", 18, 30, 8, 12, 3000, 3001, 300, 270, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_medium_medium", 10, 18, 0, 3, 3000, 3001, 300, 0, 90, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_steam_hiss_short_distant", 14, 25, 8, 10, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_small", 8, 12, 0, 5, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_metal_groan_ominous", 15, 30, 25, 28, 3000, 3001, 300, 180, 270, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_impact_distant_deep", 15, 27, 21, 23, 3000, 3001, 300, 0, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_long_deep", 14, 18, 1, 5, 3000, 3001, 300, 90, 180, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_machine_movement_distant_short_deep", 10, 20, 0, 6, 3000, 3001, 300, 0, 359, 0, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_distant_deep", 5, 12, 0, 4, 100, 1000, 300, 90, 90, 4, 0, 0, 0);
  thread _id_0F00::_id_FBEF("moon_int_explosion_sm", 6, 12, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.2, 0.1);
  thread _id_0F00::_id_FBEF("moon_int_explosion_lg", 12, 25, 3, 8, 100, 1000, 300, 5, 5, 2, 1, 0.7, 0.1);
  thread _id_0F00::_id_FBEF("amb_sa_battle_tracer_short_deep", 6, 10, 6, 10, 100, 1000, 300, 45, 90, 1, 0, 0, 0);
  thread _id_0F00::_id_FBEF("amb_sa_battle_jack_flyby_deep", 25, 40, 10, 20, 100, 1000, 300, 180, 360, 2, 0, 0, 0);
}

_id_BB22() {
  level._id_2571._id_A375 = scripts\engine\utility::spawn_tag_origin();
  level._id_2571._id_A103 = scripts\engine\utility::spawn_tag_origin();
  level._id_2571._id_A379 = scripts\engine\utility::spawn_tag_origin();
  level._id_2571._id_A37A = scripts\engine\utility::spawn_tag_origin();
  level._id_2571._id_A37B = scripts\engine\utility::spawn_tag_origin();
  level._id_2571._id_A379 _meth_8278(0);
  level._id_2571._id_A379 _meth_8277(0);
  level._id_2571._id_A37A _meth_8278(0);
  scripts\engine\utility::waitframe();
  level._id_2571._id_A375 playLoopSound("jackal_full_throttle_moon_intro");
  level._id_2571._id_A103 playLoopSound("moon_intro_cockpit");
  level._id_2571._id_A379 playLoopSound("dogfight_high_thrust_lp");
  level._id_2571._id_A37A playLoopSound("dogfight_high_thrust_shake_lp");
  level._id_2571._id_A379 _meth_8277(1, 18);
  level._id_2571._id_A379 _meth_8278(0.251, 3);
  wait 3;

  while(!scripts\engine\utility::flag("canopy_open")) {
    var_0 = randomfloatrange(0.9, 1.1);
    var_1 = randomfloatrange(10, 45);
    level._id_2571._id_A379 _meth_8277(var_0, var_1);
    var_2 = var_1 / 10;

    for(var_3 = 0; var_3 < var_2; var_3 = var_3 + 0.1) {
      if(scripts\engine\utility::flag("canopy_open")) {
        break;
      }

      wait 0.1;
    }
  }

  thread _id_38E7();
  level._id_2571._id_A379 _meth_8278(0.1, 2.5);
  level._id_2571._id_A37B _meth_8277(1, 10);
  level._id_2571._id_A37B playSound("dogfight_high_thrust_end");
  wait 1;

  if(isDefined(level._id_2571._id_A379))
    level._id_2571._id_A379 scripts\sp\utility::_id_10460(1);

  if(isDefined(level._id_2571._id_A37A))
    level._id_2571._id_A37A scripts\sp\utility::_id_10460(1);

  if(isDefined(level._id_2571._id_A37B))
    level._id_2571._id_A37B scripts\sp\utility::_id_10460(1);

  if(isDefined(level._id_2571._id_A375))
    level._id_2571._id_A375 scripts\sp\utility::_id_10460(1);

  if(isDefined(level._id_2571._id_A103))
    level._id_2571._id_A103 scripts\sp\utility::_id_10460(1);
}

_id_38E7() {
  level.player playSound("plr_helmet_oxygen_lr");
  wait 0.6;
  thread scripts\engine\utility::play_sound_in_space("moon_ejection_ext", (1723, -1283, 1345));
  level.player playSound("scn_moon_suck_decomp");
  wait 0.1;
}

_id_9AB7() {
  thread _id_CE2A("moon_intro_flak");
  thread _id_CE2A("moon_intro_whoosh_01", 5);
  thread _id_CE2A("moon_cannon_projectile_2d_2", 5.3);
  thread _id_CE2A("moon_intro_whoosh_02", 6);
  thread _id_CE2A("moon_intro_whoosh_03", 6.5);
  thread _id_CE2A("moon_intro_flak", 7);
  thread _id_CE2A("tigris_cannon_fire_rattle_lr", 7.2);
  thread _id_CE2A("moon_intro_whoosh_deep_01", 8.2);
  thread _id_CE2A("moon_intro_whoosh_04", 8.5);
  thread _id_CE2A("moon_intro_whoosh_08", 9.5);
  thread _id_CE2A("moon_cockpit_debris_splatter", 10);
  thread _id_CE2A("moon_cockpit_debris_burst_3", 10);
  thread _id_CE2A("moon_intro_whoosh_deep_02", 10.3);
  thread _id_CE2A("moon_cannon_projectile_2d_1", 11.5);
  thread _id_CE2A("moon_cannon_projectile_2d_3", 12.6);
  thread _id_CE2A("moon_intro_whoosh_deep_03", 12.7);
  thread _id_CE2A("moon_intro_whoosh_05", 12.5);
  thread _id_CE2A("moon_cockpit_debris_burst_1", 13.5);
  thread _id_CE2A("moon_intro_whoosh_06", 13.5);
  thread _id_CE2A("moon_cockpit_debris_burst_2", 15.6);
  thread _id_CE2A("moon_intro_flak_close", 15.7);
  thread _id_CE2A("moon_cannon_projectile_2d_4", 17.5);
}

_id_EA9A() {
  self endon("death");
  wait 0.2;
  thread _id_EA9B();
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self);
  _id_0F00::_id_CE24("moon_intro_salter_j_whoosh_1");
  _id_0F00::_id_CE24("moon_intro_salter_j_whoosh_2", 4);
  _id_0F00::_id_CE24("moon_intro_salter_j_whoosh_3", 7);
  _id_0F00::_id_CE24("moon_intro_salter_j_whoosh_4", 11);
  _id_0F00::_id_CE24("moon_intro_salter_j_whoosh_5", 14.5);
  _id_0F00::_id_CE24("moon_intro_salter_j_whoosh_6", 16.5);
  _id_0F00::_id_CE24("moon_intro_salter_j_whoosh_7", 19);
  scripts\engine\utility::flag_wait("jackal_intro_end");
  var_0 scripts\sp\utility::_id_10460(1);
}

_id_DE10() {
  self endon("death");
  wait 0.2;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self);
  _id_0F00::_id_CE24("moon_intro_red_j_whoosh_1");
  _id_0F00::_id_CE24("moon_intro_red_j_whoosh_2", 8.1);
  _id_0F00::_id_CE24("moon_intro_red_j_whoosh_3", 9);
  scripts\engine\utility::flag_wait("jackal_intro_end");
  var_0 scripts\sp\utility::_id_10460(1);
}

_id_9AE0() {
  wait 17.5;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("moon_intro_jack_hit_02", "sounddone");
  var_0 waittill("sounddone");
  var_0 playSound("moon_intro_jack_strafe_01", "sounddone");
  var_0 waittill("sounddone");
  var_0 playSound("moon_intro_jack_hit_01", "sounddone");
  var_0 waittill("sounddone");
  var_0 playSound("moon_intro_jack_strafe_02", "sounddone");
  var_0 waittill("sounddone");
  var_0 playSound("moon_intro_jack_hit_03", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_9AAA() {
  wait 1;

  while(!scripts\engine\utility::flag("canopy_open")) {
    wait(randomfloatrange(0.05, 2.5));
    thread _id_CE2A("moon_cockpit_debris", 0, 1000);
  }
}

_id_9AA9() {
  wait 3;

  while(!scripts\engine\utility::flag("canopy_open")) {
    wait(randomfloatrange(0.05, 4.5));
    thread _id_CE2A("moon_cockpit_debris_lg", 0, 1000);
  }
}

_id_9AE4() {
  wait 1;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("moon_intro_tracer1", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_9AE5() {
  wait 0.5;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("moon_intro_tracer2", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_9AE6() {
  thread _id_EB0B();
  wait 3;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("moon_intro_tracer3", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_EB0B() {
  wait 2;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("moon_intro_sam_explosion_incoming", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_EB0A() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self);
  var_0 playSound("moon_intro_sam_explosion", "snd_moon_intro_sam_explosion_done");
  var_0 waittill("snd_moon_intro_sam_explosion_done");
  self notify("vfx_red_jackal_explosion_done");
}

_id_6006(var_0) {
  wait(var_0);
  scripts\engine\utility::flag_set("canopy_open");
  level.player playSound("plr_foley_exit_jackal_zg_switch3");
  level.player playSound("jack_plr_enter_zg_pressurize");
  wait 0.3;
  level.player playSound("moon_intro_fast_eject");
  scripts\engine\utility::flag_set("stop_jackal_interior_sound");
  level.player clearclienttriggeraudiozone(1);
  level.player clearsoundsubmix();
  wait 0.5;
  level.player playSound("plr_foley_exit_jackal_zg_finish");
  wait 2;
  level.player thread _id_0F33::_id_260B();
}

_id_EA9B() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self);
  scripts\engine\utility::flag_wait("canopy_open");
  wait 0.3;
  var_0 playSound("moon_intro_salter_jackal_away", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_D129() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self);
  scripts\engine\utility::flag_wait("canopy_open");
  wait 4;
  var_0 playSound("moon_intro_player_jackal_away", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_BB36() {
  wait 1;
  _id_0F00::_id_CE21("moon_ejection_thrust_right", (384, -1935, 1103));
  _id_0F00::_id_CE21("moon_ejection_thrust_left", (-608, -1305, 1032));
}

_id_BB1F() {
  _id_0F00::_id_CE21("moon_hull_hatch_lift", (1543, -1350, 1009));
}

_id_BB3F(var_0) {
  wait 1.0;
  var_0 scripts\sp\utility::play_sound_on_tag("silo_hatch");
}

_id_BB1E(var_0, var_1) {
  wait 1.0;
  scripts\sp\utility::play_sound_on_tag("moon_bass_2", var_0 + var_1);
}

_id_BB37(var_0, var_1) {
  scripts\sp\utility::play_sound_on_tag("moon_prelaunch", var_0 + var_1);
}

_id_BB13(var_0) {
  wait 6.0;
  var_0 playSound("dropship_enemy_flyby_med_far_grnd");
}

_id_91B7(var_0) {
  if(isDefined(var_0))
    var_0 playSound("chase_by");
}

_id_2F58() {
  level.player playSound("moon_breach_doors_putaway_gun");
}

_id_2F57() {
  thread _id_2F6F();
  scripts\engine\utility::flag_wait("raising_the_shields");
  thread _id_2F63();
  wait 3;
  _id_0F00::_id_CD7B("amb_ship_hum_01", (4795, -393, 1391));
  _id_0F00::_id_CD7B("amb_ship_hum_04", (4535, -369, 1381));
  _id_0F00::_id_CD7B("amb_ship_hum_07", (4707, 256, 1485));
  wait 0.1;
  _id_0F00::_id_CD7B("amb_ship_vent_09", (5039, 334, 1492));
  _id_0F00::_id_CD7B("amb_ship_hum_11", (5200, -388, 1496));
  _id_0F00::_id_CD7B("emt_computer_hum_01_lp", (4713, -386, 1394));
  wait 0.1;
  _id_0F00::_id_CD7B("amb_bridge_broken_com_console", (4705, 0, 1425));
  thread _id_8895();

  if(!isDefined(level._id_9DD0))
    setmusicstate("");
}

_id_8895() {
  var_0 = scripts\engine\utility::spawn_tag_origin((4931, -168, 1483));
  var_1 = scripts\engine\utility::spawn_tag_origin((4906, 156, 1478));
  var_2 = scripts\engine\utility::spawn_tag_origin((4687, -109, 1471));
  var_3 = scripts\engine\utility::spawn_tag_origin((4684, 94, 1475));
  var_0 playLoopSound("amb_ship_steam_wide_01");
  var_1 playLoopSound("amb_ship_steam_wide_02");
  wait 0.1;
  var_2 playLoopSound("amb_ship_steam_03");
  var_3 playLoopSound("amb_ship_steam_02");
}

_id_2F6F() {
  wait 4.5;
  setmusicstate("");
  var_0 = level._id_2F78 scripts\engine\utility::spawn_tag_origin();
  level.player playSound("moon_breach_handheld_arm");
  wait 1;
  level.player playSound("moon_breach_device_beeps");
  level._id_2F78 waittillmatch("single anim", "device_activate");
  wait 1.75;
  level.player playSound("moon_breach_handheld_explo");
  wait 0.5;
  _id_0F00::_id_CE21("moon_breach_ventout", (4346, -237, 1452));
  thread _id_2F8C();
  var_0 delete();
  thread _id_2F74();
  thread _id_2FCF();
}

_id_2F8C() {
  var_0 = scripts\engine\utility::spawn_tag_origin((4346, -237, 1452));
  var_0 playSound("moon_breach_ventout_screams", "sounddone");
  wait 0.6;
  var_0 moveTo((4041, -296, 1382), 3);
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_2F74() {
  wait 6;
  _id_0F00::_id_CE21("moon_breach_floating_debris", (4705, 50, 1425));
  thread _id_83CC();
}

_id_2FCF() {
  var_0 = scripts\engine\utility::spawn_tag_origin((4705, 50, 1425));
  var_0 _meth_8278(0);
  wait 1;
  var_0 _meth_8278(1, 6);

  while(!scripts\engine\utility::flag("bridge_gravity_restored")) {
    var_0 playSound("bridge_alarm");
    wait 0.5;
  }

  wait 4;
  level.player notify("stop_doppler");
  var_0 delete();
}

_id_2F63() {
  level.player playSound("moon_breach_doors");
  _id_0F00::_id_CE21("moon_breach_doors_hydros_01", (4301, -44, 1447));
  _id_0F00::_id_CE21("moon_breach_doors_hydros_05", (4283, 83, 1426));
  wait 0.5;
  _id_0F00::_id_CE21("moon_breach_doors_hydros_02", (4408, -171, 1443));
  _id_0F00::_id_CE21("moon_breach_doors_hydros_01", (4383, 197, 1453));
  wait 0.2;
  _id_0F00::_id_CE21("moon_breach_doors_hydros_03", (4460, -310, 1444));
  _id_0F00::_id_CE21("moon_breach_doors_hydros_02", (4453, 279, 1441));
  wait 0.3;
  _id_0F00::_id_CE21("moon_breach_doors_hydros_04", (4521, -409, 1448));
  _id_0F00::_id_CE21("moon_breach_doors_hydros_03", (4534, 406, 1449));
  wait 0.3;
  _id_0F00::_id_CE21("moon_breach_doors_hydros_05", (4714, -502, 1459));
  _id_0F00::_id_CE21("moon_breach_doors_hydros_03", (4688, 473, 1464));
  wait 0.3;
  _id_0F00::_id_CE21("moon_breach_doors_hydros_01", (4823, -463, 1436));
  _id_0F00::_id_CE21("moon_breach_doors_hydros_04", (4844, 473, 1442));
  wait 0.3;
  _id_0F00::_id_CE21("moon_breach_doors_hydros_02", (4955, -482, 1422));
  _id_0F00::_id_CE21("moon_breach_doors_hydros_05", (4933, 472, 1430));
}

_id_101A0() {
  wait 2;
  level.player playSound("moon_breach_doors2");
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_01", (4301, -44, 1447));
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_05", (4283, 83, 1426));
  wait 0.4;
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_02", (4955, -482, 1422));
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_05", (4933, 472, 1430));
  wait 0.3;
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_01", (4823, -463, 1436));
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_04", (4844, 473, 1442));
  wait 0.4;
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_05", (4714, -502, 1459));
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_03", (4688, 473, 1464));
  wait 0.3;
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_04", (4521, -409, 1448));
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_03", (4534, 406, 1449));
  wait 0.4;
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_03", (4460, -310, 1444));
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_02", (4453, 279, 1441));
  wait 0.5;
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_02", (4408, -171, 1443));
  _id_0F00::_id_CE21("moon_breach_doors_hydros2_01", (4383, 197, 1453));
  thread _id_9A63();
  wait 1;
  setglobalsoundcontext("atmosphere", "helmet", 2);
}

_id_6776() {
  _id_0F00::_id_CD7B("ethan_hack", (4705, 40, 1402), 0.1, "end_ethan_hack_lp", 0.1);
  scripts\engine\utility::flag_wait("bridge_gravity_restored");
  level notify("end_ethan_hack_lp");
}

_id_E461() {
  thread _id_8518();
  thread _id_8511();
  wait 0.3;
  thread _id_8517();
  thread _id_8515();
}

_id_8511() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8517() {
  wait 0.2;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on_metal_debris", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8515() {
  thread _id_8513();
  thread _id_8516();
  thread _id_8512();
}

_id_8513() {
  wait 0.75;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("bridge_canisters_fall", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8516() {
  wait 1.15;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("bridge_gun_fall", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8512() {
  wait 1.3;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("bridge_body_fall", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_8518() {
  self endon("death");

  while(!level.player isonground())
    wait 0.05;

  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("gravity_on_plr_imp_metal", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_83CC() {
  var_0 = scripts\engine\utility::spawn_tag_origin((4705, 50, 1400));
  var_0 playLoopSound("bridge_glass_pieces");

  while(!level.player isonground())
    wait 0.05;

  var_0 stopsounds();
  scripts\engine\utility::waitframe();
  var_0 delete();
}

_id_3A1D() {
  level.player _id_0F00::_id_CE24("bridge_lift_captain_foley");
  level.player _id_0F00::_id_CE24("bridge_take_card_foley", 2.2);
}

_id_C484(var_0) {
  setmusicstate("mx_052_samoon_midship");
  var_0 _id_0F00::_id_CE24("moon_elev_shaft_door_open", 2);
  level._id_C47F _id_0F00::_id_CE24("bridge_npc_jump_to_cable_1", 5);
  level._id_C47F _id_0F00::_id_CE24("bridge_npc_cable_slide_1", 5.5);
  level._id_C47F _id_0F00::_id_CE24("bridge_npc_cable_land_1", 7.5);
}

_id_D035() {
  level.player _id_0F00::_id_CE24("bridge_cable_plr_jump");
  level.player _id_0F00::_id_CE24("bridge_cable_plr_slide", 0.7);
  level.player _id_0F00::_id_CE24("bridge_cable_plr_land", 3.5);
}

_id_676D() {
  level._id_C47F _id_0F00::_id_CE24("bridge_npc_cable_slide_ethan", 2.5);
  level._id_C47F _id_0F00::_id_CE24("bridge_npc_cable_land_ethan", 4.5);
}

_id_EA58() {
  level._id_C47F _id_0F00::_id_CE24("bridge_npc_cable_slide_2", 6);
  level._id_C47F _id_0F00::_id_CE24("bridge_npc_cable_land_2", 8);
}

_id_B24F(var_0) {
  var_0 playSound("moon_maint_door_open");
}

_id_B250(var_0) {
  var_0 playSound("moon_maint_door_open");
}

_id_B251(var_0) {
  wait 2.3;
  var_0 playSound("moon_data_center_door_open");
  thread _id_4D9A();
}

_id_B253() {
  _id_13648();
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("moon_tunnel_land_omar", (7035, 754, 285));
  _id_B252();
}

_id_B252() {
  _id_13648();
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("moon_tunnel_land_ethan", (7035, 754, 285));
  _id_B254();
}

_id_B254() {
  _id_13648();
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("moon_tunnel_land_salter", (7035, 754, 285));
  _id_4D9C();
}

_id_4D9C() {
  while(!scripts\engine\utility::flag("fleet_data_patched_in")) {
    _id_13648();
    wait 0.3;
    thread scripts\engine\utility::play_sound_in_space("moon_datacenter_land", (6592, 592, 135));
  }
}

_id_13648() {
  scripts\engine\utility::flag_wait("jump_down");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_clear("jump_down");
}

_id_4D9A() {
  var_0 = scripts\engine\utility::spawn_tag_origin((6232, 735, 270));
  var_0 _meth_8278(0);
  scripts\engine\utility::waitframe();
  var_0 playLoopSound("data_center_comp_console");
  var_0 _meth_8278(1, 3);
}

_id_6779() {
  _id_0F00::_id_CD7B("ethan_hack", (6160, 703, 156), 0.1, "end_ethan_hack_lp", 0.1);
  scripts\engine\utility::flag_wait("fleet_data_downloaded");
  level notify("end_ethan_hack_lp");
}

_id_D101() {
  level.player _id_0F00::_id_CE24("data_cent_card_insert", 2);
  thread _id_4D98();
}

_id_4D99() {
  _id_0F00::_id_CCC7("sa_moon_data_center_bink_1", (6233, 717, 158));
}

_id_4D98() {
  wait 5;
  var_0 = scripts\engine\utility::spawn_tag_origin((6571, -437, 229));
  var_0 _meth_8278(0.5);
  scripts\engine\utility::waitframe();
  var_0 playLoopSound("data_cent_alarm");
  scripts\engine\utility::flag_wait("fleet_data_player_unlinked");
  wait 1;
  var_0 _meth_8278(1);
  wait 1;
  thread _id_8878();
}

_id_8878() {
  var_0 = scripts\engine\utility::spawn_tag_origin((5706, -387, 192));
  var_0 thread _id_0F00::_id_FB81("hallway_shake", 4, 12, 500, 3000, 300, 20, 45, 6);
}

_id_5A11() {
  level waittill("door_kick_start");
  wait 0.6;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 playSound("slomo_whoosh_moon");
  level waittill("turkeyshoot_over");
  wait 0.2;
  level.player playSound("slomo_whoosh_moon_end");
  var_0 stopsounds(1.5);
  wait 3;
  var_0 delete();
}

_id_11022() {}

_id_3A8F() {}

_id_3A88() {
  scripts\engine\utility::delaythread(1.15, _id_0F00::_id_CE21, "moon_cb_switch_buttonopen_01", (0, 0, 0));
  scripts\engine\utility::delaythread(1.85, _id_0F00::_id_CE21, "moon_cb_switch_buttonpress_01", (0, 0, 0));
  scripts\engine\utility::delaythread(3.15, _id_0F00::_id_CE21, "moon_cb_switch_leverpull_01", (0, 0, 0));
  scripts\engine\utility::delaythread(3.35, _id_0F00::_id_CE21, "moon_cb_doors_powerup_01", (0, 0, 0));
  wait 6;
  setglobalsoundcontext("atmosphere", "space", 4);
}

_id_6902() {
  wait 4.1;
  level.player playSound("cargo_lever_switch_mech");
  level.player playSound("cargo_bullets");
  wait 1.75;
  level.player playSound("cargo_jeep_whoosh");
  wait 0.9;
  level.player playSound("cargo_growl");
  wait 0.45;
  level.player playSound("cargo_bay_scream");
  wait 0.1;
  level.player playSound("cargo_wind");
  wait 1.6;
  level.player playSound("cargo_creek_debris");
  wait 1.9;
  level.player playSound("cargo_moan_settle");
  thread _id_3A5F();
  wait 2.15;
  level.player playSound("cargo_door_lock");
}

_id_3A5F() {
  level._id_3A5F = scripts\engine\utility::spawn_tag_origin((1827, 34, 211));
  level._id_3A5F _meth_8278(0);
  scripts\engine\utility::waitframe();
  level._id_3A5F playLoopSound("cargo_alarm");
  level._id_3A5F _meth_8278(1, 4);
}

_id_6919() {
  if(getdvarint("e3_no_music") == 0) {
    if(!isDefined(level._id_9DD0)) {}
  }

  level notify("end_pa_group");
  level.player notify("started_dynamic_ambience");
  level.player notify("end_zerog_movement");
  _id_0F00::_id_CE24("exfil_ares_away");
  _id_0F00::_id_CE24("plr_foley_enter_jackal_cockpit_zg_lr", 0.5);
  _id_0F00::_id_CE24("plr_foley_enter_jackal_zg", 1);
  _id_0F00::_id_CE24("jack_plr_enter_zg_switches", 3.1);
  _id_0F00::_id_CE24("jackal_warmup_fast_exfil", 3.5);
  _id_0F00::_id_CE24("exfil_boot", 3.9);
  _id_0F00::_id_CE24("jack_plr_enter_zg_pressurize", 2);
  wait 1;
  level.player _meth_82C0("exfil_cockpit_filter_canopy_open", 3);
  level.player setsoundsubmix("sa_player_jackal_interior");
  wait 2;
  thread _id_6913();
  wait 1;
  level.player _meth_82C0("exfil_cockpit_filter");
  wait 10;
  level.player _meth_82C0("exfil_fade_out", 4);
  thread sa_moon_transition_audio_setup();
  wait 1;
  _id_BB22();
}

sa_moon_transition_audio_setup() {
  wait 6;
  level.player _meth_82C0("jackal_cockpit", 4);
}

_id_6913() {
  _id_0F00::_id_CE24("moon_exfil_expl_start");
  _id_0F00::_id_CE24("moon_exfil_expl_missiles", 2);
  _id_0F00::_id_CE24("moon_exfil_expl_thump5_sm", 2.8);
  _id_0F00::_id_CE24("moon_exfil_expl_swt1", 3);
  _id_0F00::_id_CE24("moon_exfil_expl_thump4_sm", 3.5);
  _id_0F00::_id_CE24("moon_exfil_expl_01", 4);
  _id_0F00::_id_CE24("moon_exfil_expl_thump3_sm", 4.2);
  _id_0F00::_id_CE24("moon_exfil_expl_thump2_sm", 5.1);
  _id_0F00::_id_CE24("moon_exfil_expl_thump1_sm", 6);
  _id_0F00::_id_CE24("moon_exfil_expl_swt2", 6.5);
  _id_0F00::_id_CE24("moon_exfil_expl_swt10", 6.5);
  _id_0F00::_id_CE24("moon_exfil_expl_swt3", 7);
  _id_0F00::_id_CE24("moon_exfil_expl_thump5_lg", 7.2);
  _id_0F00::_id_CE24("moon_exfil_expl_thump4_lg", 7.6);
  _id_0F00::_id_CE24("moon_exfil_expl_02", 8);
  _id_0F00::_id_CE24("moon_exfil_expl_swt4", 8);
  _id_0F00::_id_CE24("moon_exfil_expl_swt11", 8);
  _id_0F00::_id_CE24("moon_exfil_expl_thump1_lg", 8.3);
  _id_0F00::_id_CE24("moon_exfil_expl_thump2_lg", 8.6);
  _id_0F00::_id_CE24("moon_exfil_expl_thump4_lg", 9);
  _id_0F00::_id_CE24("moon_exfil_expl_thump3_lg", 9.3);
  _id_0F00::_id_CE24("moon_exfil_expl_swt5", 9.5);
  _id_0F00::_id_CE24("moon_exfil_expl_swt8", 9.5);
  _id_0F00::_id_CE24("moon_exfil_expl_swt12", 9.5);
  _id_0F00::_id_CE24("moon_exfil_expl_thump5_lg", 9.8);
  _id_0F00::_id_CE24("moon_exfil_expl_flare_by", 10);
  _id_0F00::_id_CE24("moon_cockpit_debris_splatter", 10.5);
  setmusicstate("");
}

_id_CE2A(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 10000;

  if(isDefined(var_1))
    wait(var_1);

  var_3 = level.player.origin + anglesToForward(level.player.angles) * var_2;
  _id_0F00::_id_CE21(var_0, var_3);
}