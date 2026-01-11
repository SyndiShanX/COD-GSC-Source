/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_audio.gsc
*****************************************************/

main() {
  play_rail_sfx();
  play_wind_sfx();
  soundsettimescalefactor("announcer", 0.1);
  soundsettimescalefactor("effects2d1", 0);
  soundsettimescalefactor("norestrict2d", 0);
  soundsettimescalefactor("effects2", 0);
  soundsettimescalefactor("effects1", 0);
  soundsettimescalefactor("mission", 0.1);
  soundsettimescalefactor("effects2d2", 0);
  soundsettimescalefactor("shellshock", 0);
  soundsettimescalefactor("local", 0.6);
  soundsettimescalefactor("local2", 0.3);
  soundsettimescalefactor("auto2d", 0.3);
  soundsettimescalefactor("local3", 0.6);
  soundsettimescalefactor("ambient", 0.2);
  level.exfil_swim_intensity = 0;
  level.hrtbeat = 0;
  level.skyway_end_sequence = 0;
  common_scripts\utility::flag_init("sfx_helo_flyin");
  thread skyway_tunnel_ambience();
  thread sfx_setup_land_triggers();
}

skyway_tunnel_ambience() {
  common_scripts\utility::flag_wait("flag_helo_tunnel");
  level.player setclienttriggeraudiozone("skyway_tunnel_int", 8);
}

skyway_train_ambience() {
  level.ambient_int = "skyway_train_int";
  level.ambient_ext = "skyway_train_ext";
  var_0 = [];
  var_0[0] = "skyway_amb_01";
  var_0[1] = "skyway_amb_02";
  var_0[2] = "skyway_amb_05";
  var_0[3] = "skyway_amb_06";
  var_0[4] = "skyway_amb_07";
  var_0[5] = "skyway_amb_08";

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
    maps\_utility::delaythread(0.1, maps\skyway_util::trig_watcher, var_2, ::play_ambient_sfx_int, ::play_ambient_sfx_ext);
    }
  }
}

level_start_amb() {
  level.player setclienttriggeraudiozone("skyway_intro");
  wait 5;
  thread skyway_train_ambience();
}

sfx_setup_land_triggers() {
  level.sfx_land_sweetener_array = [];
  sfx_skyway_land_sweetener_init("audio_train_roof_1", "audio_train_roof_1_reset");
  sfx_skyway_land_sweetener_init("audio_train_roof_2", "audio_train_roof_2_reset");
  sfx_skyway_land_sweetener_init("audio_train_roof_3", "audio_train_roof_3_reset");
  sfx_skyway_land_sweetener_init("audio_train_sat_1_pt1", "audio_train_sat_1_reset");
  sfx_skyway_land_sweetener_init("audio_train_sat_1_pt2", "audio_train_sat_1_reset");
  sfx_skyway_land_sweetener_init("audio_train_sat_1_pt3", "audio_train_sat_1_reset");
  sfx_skyway_land_sweetener_init("audio_train_sat_1_pt4", "audio_train_sat_1_reset");
  sfx_skyway_land_sweetener_init("audio_train_sat_2_pt1", "audio_train_sat_2_reset");
  sfx_skyway_land_sweetener_init("audio_train_sat_2_pt2", "audio_train_sat_2_reset");
  sfx_skyway_land_sweetener_init("audio_train_loco", "audio_train_loco_reset");

  for(var_0 = 0; var_0 < level.sfx_land_sweetener_array.size; var_0++) {
    thread sfx_land_triggers_spawn(level.sfx_land_sweetener_array[var_0].trigger_land, level.sfx_land_sweetener_array[var_0].trigger_reset);
  }
}

sfx_skyway_land_sweetener_init(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.trigger_land = var_0;
  var_2.trigger_reset = var_1;
  level.sfx_land_sweetener_array[level.sfx_land_sweetener_array.size] = var_2;
}

sfx_land_triggers_spawn(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = getent(var_1, "targetname");
  thread sfx_land_triggers_watcher(var_2, var_3);
}

sfx_land_triggers_watcher(var_0, var_1) {
  level endon("notify_loco_standoff");

  for(;;) {
    var_0 waittill("trigger");
    level.player playSound("scn_skyway_train_vault_land");
    var_1 waittill("trigger");
  }
}

play_rail_sfx() {
  level.train_rail_sfx_ents = [];
  var_0 = getEntArray("train_rail_sfx", "targetname");

  foreach(var_2 in var_0) {
  var_2 playLoopSound("emt_skyway_train_rail");
  }
}

play_wind_sfx() {
  level.train_wind01_sfx_ents = [];
  var_0 = getEntArray("sfx_wind_01", "targetname");

  foreach(var_2 in var_0) {
  var_2 playLoopSound("emt_skyway_wind_01");
  }

  level.train_wind02_sfx_ents = [];
  var_4 = getEntArray("sfx_wind_02", "targetname");

  foreach(var_6 in var_4) {
  var_6 playLoopSound("emt_skyway_wind_02");
  }
}

play_ambient_sfx_int() {
  if(level.skyway_end_sequence == 0) {
    level.player setclienttriggeraudiozone(level.ambient_int, 2);
  }
}

play_ambient_sfx_ext() {
  if(level.skyway_end_sequence == 0) {
    level.player setclienttriggeraudiozone(level.ambient_ext, 0.5);
  }
}

sfx_impact_train(var_0, var_1, var_2, var_3) {
  level notify("notify_sfx_impact_train");
  level endon("notify_sfx_impact_train");
  wait(var_0);

  if(isDefined(var_3)) {
    if(level.player.car == "train_sat_1" || level.player.car == "train_sat_2") {
      level.player playSound("scn_skyway_train_shake_lg");
    }
    else if(level.player.car == "train_hangar") {
      level.player playSound("scn_skyway_train_shake_hanger_lg");
    }
    else {
      level.player playSound("scn_skyway_train_shake_roof_lg");
    }
  } else if(var_1 > 0.66) {
    if(level.player.car == "train_sat_1" || level.player.car == "train_sat_2") {
      level.player playSound("scn_skyway_train_shake_lg");
    }
    else if(level.player.car == "train_hangar") {
      level.player playSound("scn_skyway_train_shake_hanger_lg");
    }
    else {
      level.player playSound("scn_skyway_train_shake_roof_lg");
    }
  } else if(var_1 > 0.13) {
    if(level.player.car == "train_sat_1" || level.player.car == "train_sat_2") {
      level.player playSound("scn_skyway_train_shake_med");
    }
    else if(level.player.car == "train_hangar") {
      level.player playSound("scn_skyway_train_shake_hanger_med");
    }
    else {
      level.player playSound("scn_skyway_train_shake_roof_med");
    }
  } else {}
}

sfx_rog_sat_impact(var_0) {
  wait 2.05;
  thread maps\_utility::play_sound_on_tag("scn_skyway_rog_explo_hard", var_0);
  wait 0.5;
  level.player playSound("scn_skyway_rog_explo_local");
  wait 1.4;
  thread maps\_utility::play_sound_on_tag("sw_canyon_rog_dist_rolling", var_0);
  thread maps\_utility::play_sound_on_tag("sw_canyon_rog_dist_big", var_0);
  thread maps\_utility::play_sound_on_tag("sw_canyon_rog_dist_boom", var_0);
  level.player thread maps\_utility::play_sound_on_entity("sw_canyon_rog_quake");
}

sfx_rog_canyon_impact(var_0) {
  wait 1.6;
  thread maps\_utility::play_sound_on_tag("sw_canyon_rog_dist_init", var_0);
  wait 0.2;
  thread maps\_utility::play_sound_on_tag("sw_canyon_rog_dist_incoming", var_0);
  wait 2.7;
  thread maps\_utility::play_sound_on_tag("sw_canyon_rog_dist_rolling", var_0);
  thread maps\_utility::play_sound_on_tag("sw_canyon_rog_dist_big", var_0);
  thread maps\_utility::play_sound_on_tag("sw_canyon_rog_dist_boom", var_0);
  level.player thread maps\_utility::play_sound_on_entity("sw_canyon_rog_quake");
  wait 0.1;
  level.player thread loop_sound_on_ent(4, 0.8, "sw_train_shake");
  wait 0.1;
  var_1 = 5;

  while(var_1 > 0) {
    level._train.cars[level.player.car].body thread maps\_utility::play_sound_on_tag("sw_canyon_rocks", "tag_rocks_r");
    level._train.cars[level.player.car].body thread maps\_utility::play_sound_on_tag("sw_canyon_rocks", "tag_rocks_l");
    var_1 = var_1 - 1;
    wait 0.7;
  }
}

loop_sound_on_ent(var_0, var_1, var_2) {
  while(var_0 > 0) {
    thread maps\_utility::play_sound_on_entity("sw_train_shake");
    var_0 = var_0 - 1;
    wait(var_1);
  }
}

skyway_death_fall_sfx() {
  level.player setclienttriggeraudiozone("skyway_train_death_fall", 1.0);
  self playSound("scn_skyway_fall_death");
}

spawn_tag_play_sound(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self gettagorigin(var_1);
  var_2 maps\_utility::play_sound_on_entity(var_0);
  var_2 maps\skyway_util::teleport_ent_generic();
  var_2 delete();
}

sfx_rog_sat_impact_beach(var_0) {
  wait 1.6;
  thread maps\_utility::play_sound_on_tag("scn_skyway_rog_explo_soft", var_0);
}

skyway_intro_sfx() {
  level.player playSound("scn_skyway_intro_lr");
  wait 1.1;
  level.player setclienttriggeraudiozone("skyway_train_intro", 0.5);
  wait 0.75;
  maps\_utility::music_play("mus_skyway_intro");
  wait 15;
  level.player setclienttriggeraudiozone("skyway_train_ext", 2);
}

sfx_noticket(var_0) {
  wait 0.5;
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_1 playSound("generic_pain_bodyslam_1");
  wait 0.2;
  var_0 playSound("scn_skyway_noticket");
  wait 1.3;
  var_1 playSound("generic_death_falling_scream");
}

sfx_bridge_down_npc() {
  wait 0.711;
  level._allies[0] playSound("scn_skyway_bridge_down_npc");
}

sfx_bridge_down_plr() {
  wait 0.711;
  self playSound("scn_skyway_bridge_down_plr");
}

sfx_water_amb() {
  level.player setclienttriggeraudiozone("skyway_flooding_cart", 1);
}

sfx_player_surface() {
  wait 0.3;
  level.player thread maps\_utility::play_sound_on_entity("sw_surfacing_splash_2");
  wait 0.4;
  level.player thread maps\_utility::play_sound_on_entity("sw_surfacing_gasp");
  wait 0.4;
  level.player thread maps\_utility::play_sound_on_entity("sw_surfacing_splash_1");
}

sfx_heli_crash(var_0) {
  wait 1;
  var_0 playSound("scn_skyway_heli_crash");
  level.player setclienttriggeraudiozone("skyway_train_helo_crash2", 2);
  maps\_utility::music_play("mus_skyway_train_battle");
}

sfx_heli_crash_impact(var_0) {
  var_0 playSound("scn_skyway_heli_crash_impact");
  var_1 = getent("train_derail_sfx", "targetname");
  level.player clearclienttriggeraudiozone(2);
  wait 1;
  var_1 playLoopSound("emt_skyway_derailed_train");
}

sfx_heli_crash_explo(var_0) {
  var_0 playSound("scn_skyway_heli_crash_impact_explo");
}

sfx_train_derail() {
  wait 0.3;
  level.player playSound("scn_skyway_train_derail_lr");
}

skyway_checkmate_music() {
  wait 1.3;
  maps\_utility::music_play("mus_skyway_meet_rorke");
}

sfx_loco_breach() {
  wait 7.68;
  level.breach_sfx = spawn("script_origin", (0, 0, 0));
  level.breach_sfx playSound("scn_skyway_loco_breach_lr");
  wait 2;
  level.player setclienttriggeraudiozone("skyway_loco_breach", 2);
}

sfx_loco_breach_out() {
  level.player playSound("scn_skyway_loco_breach_out_lr");
  level.player setclienttriggeraudiozone("skyway_train_int_end", 2);
  wait 0.5;

  if(isDefined(level.breach_sfx)) {
    level.breach_sfx stopsounds();
    wait 0.1;
    level.breach_sfx delete();
  }
}

sfx_loco_breach_02() {
  level waittill("notify_rpg_impact_engine");
  level.player playSound("scn_sw_loco_standoff");
  wait 5.6;
  level.player setclienttriggeraudiozone("skyway_loco_breach_slomo2", 0.1);
  wait 6.4;
  level.player setclienttriggeraudiozone("skyway_train_int_end", 1.0);
}

sfx_loco_exp_rambo() {
  level.end_breach_rpg_guy playSound("scn_skyway_loco_breach_explosion");
}

sfx_rambo_rpg_kill() {
  level.end_breach_rpg_guy playSound("scn_skyway_loco_breach_rico");
}

loco_standoff_slowmo_sfx() {
  level endon("notify_loco_standoff");
  level.player waittill("weapon_fired");
  level.player playSound("scn_skyway_slowmo_shot1");
  level.player waittill("weapon_fired");
  level.player playSound("scn_skyway_slowmo_shot2");
  level.player waittill("weapon_fired");
  level.player playSound("scn_skyway_slowmo_shot3");
  level.player waittill("weapon_fired");
  level.player playSound("scn_skyway_slowmo_shot4");
  level.player waittill("weapon_fired");
  level.player playSound("scn_skyway_slowmo_shot1");
  level.player waittill("weapon_fired");
  level.player playSound("scn_skyway_slowmo_shot2");
  level.player waittill("weapon_fired");
  level.player playSound("scn_skyway_slowmo_shot3");
  level.player waittill("weapon_fired");
  level.player playSound("scn_skyway_slowmo_shot4");
}

skyway_endshot_sfx() {
  level.player playSound("scn_skyway_end_shot");
  level.player setclienttriggeraudiozone("skyway_flooding_cart2", 0.1);
}

sfx_skyway_helo(var_0) {
  common_scripts\utility::flag_wait("sfx_helo_flyin");

  if(var_0 == 0) {
    wait 2;
    self playSound("scn_skyway_heli_intro_02");
    wait 6;
    self playLoopSound("scn_skyway_heli_loop");
  } else if(var_0 == 1) {
    wait 1.3;
    self playSound("scn_skyway_heli_intro_01");
    wait 1.5;
    self playLoopSound("scn_skyway_heli_loop");
  }
}

skyway_swim_music() {
  wait 1.0;
  maps\_utility::music_play("mus_skyway_uw_swim");
}

skyway_beach_music() {
  maps\_utility::music_crossfade("mus_skyway_beach_surface", 0.01);
}

skyway_beach_music_transition() {
  level.player setclienttriggeraudiozone("skyway_beach_victory", 2.0);
  maps\_utility::delaythread(0.06, maps\_utility::music_crossfade, "mus_skyway_beach_end", 4);
}

skyway_beach_elias_dialog_lower_amb() {
  level.player setclienttriggeraudiozone("skyway_beach_victory_mx_dx", 10.0);
}

skyway_beach_fade_to_dev_logo_credits(var_0) {
  level.player setclienttriggeraudiozone("skyway_credits_dev_logos", var_0);
}

skyway_beach_pre_rorke() {
  level.player setclienttriggeraudiozone("skyway_beach_pre_rorke", 8.0);
}

skyway_beach_rorke_again() {
  level.player setclienttriggeraudiozone("skyway_beach_rorke_again", 4.0);
}

skyway_beach_fade_to_final_credits() {
  wait 0.1;
  level.player setclienttriggeraudiozone("skyway_credits", 0.05);
}

sfx_train_derail_logic(var_0) {
  level.skyway_end_sequence = 1;
  wait 2.8;
  var_0 playSound("scn_skyway_end_derail_rog");
}

sfx_train_derail_sound() {
  level.player playSound("scn_skyway_end_derail_lr");
  level.player setclienttriggeraudiozone("skyway_train_int_derail", 2);
  wait 20;
  level.player setclienttriggeraudiozone("skyway_flooding_cart", 2);
}

sfx_wreck_01() {
  wait 7;
  level.wrecksfx01 = spawn("script_origin", (0, 0, 0));
  wait 0.01;
  level.wrecksfx01 playSound("scn_sw_uw_fight01");
  thread sw_wreck_dialogue01();
  wait 21.4;
  maps\_utility::music_play("mus_skyway_uw_combat");
}

sw_wreck_dialogue01() {
  var_0 = level._ally;
  var_1 = level._boss;
  wait 9.5;
  var_1 playSound("skyway_rke_strugglesoundeffort");
  wait 4;
  var_0 playSound("skyway_hsh_effortgruntswingingfire");
  wait 1;
  var_1 stopsounds();
  wait 0.85;
  var_1 playSound("skyway_rke_painstruckinhead");
  wait 2.29;
  var_1 playSound("skyway_rke_strugglesoundbeingheld");
  wait 1.46;
  var_1 playSound("skyway_rke_strugglesoundbeingheld_2");
  wait 2.09;
  var_1 playSound("skyway_rke_strugglesoundbeingheld_3");
  wait 1.8;
  var_0 playSound("skyway_hsh_strugglesoundholdingback_2");
}

sfx_wreck_02() {
  wait 0.01;
  level.player setclienttriggeraudiozone("skyway_flooding_cart1", 0.5);
  thread sw_wreck_dialogue02();
  wait 0.9;

  if(isDefined(level.wrecksfx01)) {
    level.wrecksfx01 stopsounds();
    wait 0.01;
    level.wrecksfx01 delete();
  }

  wait 1.7;
}

sw_wreck_dialogue02() {
  var_0 = level._ally;
  var_1 = level._boss;
  wait 1.29;
  var_0 stopsounds();
  var_1 playSound("skyway_rke_painstruckinhead");
  level waittill("notify_end_slomo");
  wait 0.85;
  var_1 playSound("skyway_rke_strugglesoundbeingheld");
  wait 1.57;
  var_1 playSound("skyway_rke_painstruckinhead");
}

sfx_wreck_03() {
  maps\_utility::music_play("mus_skyway_kill_rorke");

  if(isDefined(level.wrecksfx02)) {
    level.wrecksfx02 stopsounds();
    wait 0.01;
    level.wrecksfx02 delete();
  }

  level.wrecksfx03 = spawn("script_origin", (0, 0, 0));
  wait 0.1;
  level.wrecksfx03 playSound("scn_sw_uw_shot_to_burst");
}

sfx_beach_drags() {
  level waittill("sfx_drag");
  level.player playSound("scn_sw_beach_foley_02");
  wait 1;
  level waittill("sfx_drag");
  level.player playSound("scn_sw_beach_foley_03");
  wait 0.8;
  level._ally playSound("skyway_hsh_beach_drag");
  wait 0.2;
  level waittill("sfx_drag");
  level.player playSound("scn_sw_beach_foley_04");
  wait 1;
  level waittill("sfx_drag");
  level.player playSound("scn_sw_beach_foley_05");
  wait 0.7;
  level._ally playSound("skyway_hsh_beach_drag");
  wait 0.3;
  level waittill("sfx_drag");
  level.player playSound("scn_sw_beach_foley_06");
}

sfx_swim_exfil_begin() {
  wait 4;
  level.swim_creaks = spawn("script_origin", (0, 0, 0));
  level.player playSound("scn_skyway_exfil_swim_intro_lr");
  level.swim_creaks playLoopSound("scn_skyway_exfil_swim_creaks_lr");
  level.player playSound("scn_skyway_exfil_swim_drop_lr");
}

sfx_swim_logic(var_0) {
  if(isDefined(var_0)) {
    if(level.exfil_swim_intensity != var_0) {
      level.exfil_swim_intensity = var_0;

      switch (level.exfil_swim_intensity) {
        case 1:
          level.player setclienttriggeraudiozone("skyway_underwater");
          break;
        case 2:
          level.player setclienttriggeraudiozone("skyway_underwater2", 1);
          thread start_noise();
          break;
        case 3:
          level.player setclienttriggeraudiozone("skyway_underwater3", 4);
          thread sfx_fish();
          thread stop_creaks();
          break;
        case 4:
          level.player setclienttriggeraudiozone("skyway_underwater4", 4);
          thread stop_swimming();
          thread sfx_accents();
          break;
        case 5:
          level.player setclienttriggeraudiozone("skyway_underwater5", 4);
          break;
        default:
          break;
      }
    }
  }
}

sfx_accents() {
  level.player playSound("scn_skyway_exfil_swim_accent01");
}

sfx_swim_hrtbeat() {
  self endon("death");
  level.plr_heart = spawn("script_origin", (0, 0, 0));
  level.hrtbeat = 1;

  while(!common_scripts\utility::flag("flag_end_swim_end")) {
    switch (level.hrtbeat) {
      case 1:
        level.plr_heart playSound("scn_skyway_exfil_swim_hrtbeat00", "heartbeat_done");
        thread maps\skyway_end_swim::heartfx(1.452);
        break;
      case 2:
        level.plr_heart playSound("scn_skyway_exfil_swim_hrtbeat01", "heartbeat_done");
        thread maps\skyway_end_swim::heartfx(1.178);
        break;
      case 3:
        level.plr_heart playSound("scn_skyway_exfil_swim_hrtbeat02", "heartbeat_done");
        thread maps\skyway_end_swim::heartfx(1);
        break;
      case 4:
        level.plr_heart playSound("scn_skyway_exfil_swim_hrtbeat03", "heartbeat_done");
        thread maps\skyway_end_swim::heartfx(0.86);
        break;
      case 5:
        level.plr_heart playSound("scn_skyway_exfil_swim_hrtbeat04", "heartbeat_done");
        thread maps\skyway_end_swim::heartfx(0.682);
        break;
      default:
        break;
    }

    level.plr_heart waittill("heartbeat_done");
  }
}

sfx_exfil_swim_plr() {
  level.plr_swimming = spawn("script_origin", (0, 0, 0));
  level.plr_swimming playLoopSound("scn_skyway_exfil_swim_plr_lp");
}

sfx_fish() {
  wait 2;
  level.player playSound("scn_skyway_exfil_swim_fish");
}

stop_creaks() {
  wait 5;
  level.swim_creaks stoploopsound();
}

stop_swimming() {
  level.plr_swimming stoploopsound();
}

start_noise() {
  wait 1;
  level.noise = spawn("script_origin", (0, 0, 0));
  level.noise playLoopSound("scn_skyway_exfil_swim_noise_lp");
}

sfx_stop_all_swim_sounds() {
  level.player playSound("scn_skyway_exfil_swim_noise_end");
  level.player setclienttriggeraudiozone("skyway_underwater6", 5);
  wait 2;
  level.player playSound("scn_skyway_exfil_swim_end");
  wait 0.5;
  level.noise stoploopsound();
  level.plr_heart stopsounds();
  wait 0.05;
  level.plr_heart delete();
}

sfx_beach_transition() {
  level.player setclienttriggeraudiozone("skyway_beach1", 0.5);
  wait 1;
  level.player setclienttriggeraudiozone("skyway_beach", 3);
}

sfx_beach_rorke_approach(var_0) {
  level endon("notify_rorke_attack");
  wait 5;
  level.rorke_approach_sfx = spawn("script_origin", (16926, -33864, 74520));
  level.rorke_approach_sfx playSound("scn_skyway_beach_rorke_approach");
  thread sfx_beach_rorke_approach_end();
}

sfx_beach_rorke_approach_end() {
  level waittill("notify_rorke_attack");
  level.rorke_approach_sfx stopsounds();
  wait 1;
  level.rorke_approach_sfx delete();
}

perif_fleet_sfx() {
  level.perif_fleet_sfx = spawn("script_origin", (12734, -6001, 74636));
  level.perif_fleet_sfx playLoopSound("sw_end_dist_battle");
}

sw_beach_breathing_vo() {
  wait 1;
  level._allies[0] playSound("skyway_hsh_foleysoundsforbeach");
}

rorke_end_grunt_sfx() {
  wait 6.5;
  level._boss playSound("skyway_rke_outro_end_efforts");
}