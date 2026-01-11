/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_end_swim.gsc
*****************************************************/

section_flag_inits() {
  common_scripts\utility::flag_init("flag_end_swim_start");
  common_scripts\utility::flag_init("flag_end_swim_rescue");
  common_scripts\utility::flag_init("flag_end_swim_end");
  common_scripts\utility::flag_init("flag_end_swim_choke_1");
  common_scripts\utility::flag_init("flag_end_swim_choke_2");
  common_scripts\utility::flag_init("flag_end_swim_choke_3");
  common_scripts\utility::flag_init("flag_player_drowned");
}

section_precache() {
  precacheitem("underwater_hesh");
  maps\interactive_models\fish_bannerfish::main();
  maps\interactive_models\fish_school_sardines::main();
}

section_post_inits() {
  level._end_swim = spawnStruct();
  level._end_swim.ally_start = getent("ally1_start_end_swim", "targetname");
  level._end_swim.player_start = getent("player_start_end_swim", "targetname");
  level.swim_rumble_mag = 0.16;
  level.swim_blur_mag = 0.6;
  level.swim_blur_fade = 0.4;
  level.swim_quake_mag = 0.001;
  level.swim_quake_fade = 0.001;
}

start() {
  iprintln("end swim");
  maps\skyway_util::skyway_hide_hud();
  maps\skyway_util::player_start(level._end_swim.player_start);
  maps\_art::sunflare_changes("swim", 0.1);

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbEnable", "2");
    thread maps\skyway_util::set_motionblur_values(0.06, 0.15, 0.3, 0.59, 0.1);
  }

  retarget_engines();
  level._allies[0] forceteleport(level._end_swim.ally_start.origin, level._end_swim.ally_start.angles);
  level._allies[0] maps\_utility::set_force_color("r");
  maps\_utility::delaythread(0.05, maps\_utility::remove_extra_autosave_check, "fallen_cant_get_up");
}

main() {
  maps\skyway_util::spawn_allies("spawner_allies_swim");
  maps\skyway_util::spawn_boss("actor_boss_injured");
  level.player setclienttriggeraudiozone("skyway_underwater", 2);
  end_swim_init_vars();
  maps\_utility::vision_set_fog_changes("", 0);
  retarget_engines();
  maps\_art::sunflare_changes("swim", 0.1);
  thread maps\skyway_fx::fx_swim_bubbles();
  thread maps\skyway_fx::fx_swim_door_light();
  thread maps\skyway_fx::fx_player_submerge_01_endwreck();
  thread maps\skyway_fx::fx_endswim_blood_cloud();
  thread maps\skyway_audio::skyway_swim_music();
  thread choking_logic();
  thread end_swim_logic();
  common_scripts\utility::flag_wait("flag_end_swim_end");
  thread maps\skyway_audio::sfx_stop_all_swim_sounds();
  thread player_blend_swim_speed(0, 0.5);
  level.player disableweapons();
  level.player allowfire(1);

  if(common_scripts\utility::flag("flag_player_drowned")) {
    wait 100;
  }

  wait 1.0;
  maps\_art::dof_disable_script(2);
}

end_swim_init_vars() {
  level.end_swim_anim_node = common_scripts\utility::getstruct("vignette_swimout", "targetname");
  level.player allowfire(0);
}

choking_logic() {
  wait 1.5;
  level.drown_death_timer = 0.0;
  thread drown_die();
  level.player_fx_org = maps\_utility::spawn_anim_model("sw_swim_view_fx");
  level.player_fx_org linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 0);
  level.player_fx_org setanim(level.scr_anim["sw_swim_view_fx"]["swim_fx_base"]);
  level.player_fx_org setanim(level.scr_anim["sw_swim_view_fx"]["swim_fx_add"]);
  level.player_fx_org setanimlimited(level.scr_anim["sw_swim_view_fx"]["swim_drown_overlay"], 0.0, 0.0);
  var_0 = common_scripts\utility::getstruct("swim_final_dist_check", "targetname");
  var_1 = 2000;
  var_2 = 400;
  var_3 = 0.5;
  thread drown_choke();
  thread maps\skyway_audio::sfx_swim_hrtbeat();

  while(!common_scripts\utility::flag("flag_endbeach_start")) {
    var_4 = distance(var_0.origin, level.player.origin);
    var_5 = 1 - maps\skyway_util::normalize_value(var_2, var_1, var_4);
    thread drown_heartbeat(level.drown_death_timer);
    level.player_fx_org setanimlimited(level.scr_anim["sw_swim_view_fx"]["swim_drown_overlay"], var_5, var_3);

    if(var_5 > level.drown_death_timer) {
      level.drown_death_timer = var_5;
    }

    if(var_5 == 1) {
      thread maps\skyway_audio::sfx_swim_logic(5);
    }

    wait(var_3);
  }

  killfxontag(common_scripts\utility::getfx("swim_drowning_tunnel"), level.player_fx_org, "tag_helo");
  level.player_fx_org delete();
}

drown_heartbeat(var_0) {
  level endon("flag_endbeach_start");
  level endon("flag_player_drowned");

  if(var_0 > 0.75) {
    if(level.exfil_swim_intensity < 5) {
      thread maps\skyway_audio::sfx_swim_logic(4);
    }

    if(!common_scripts\utility::flag("flag_end_swim_choke_3")) {
      thread drown_choke(1);
      common_scripts\utility::flag_set("flag_end_swim_choke_3");
    }
  } else if(var_0 > 0.5) {
    if(level.exfil_swim_intensity < 5) {
      thread maps\skyway_audio::sfx_swim_logic(3);
    }
  } else if(var_0 > 0.25) {
    if(level.exfil_swim_intensity < 5) {
      thread maps\skyway_audio::sfx_swim_logic(2);
    }

    if(!common_scripts\utility::flag("flag_end_swim_choke_1")) {
      thread drown_choke();
      common_scripts\utility::flag_set("flag_end_swim_choke_1");
    }
  } else if(level.exfil_swim_intensity < 5)
    thread maps\skyway_audio::sfx_swim_logic(1);

  if(var_0 > 0.77) {
    level.hrtbeat = 5;
  } else if(var_0 > 0.6) {
    level.hrtbeat = 4;
  } else if(var_0 > 0.4) {
    level.hrtbeat = 3;
  } else if(var_0 > 0.24) {
    level.hrtbeat = 2;
  } else {
    level.hrtbeat = 1;
  }

  level.swim_rumble_mag = maps\skyway_util::factor_value_min_max(0.16, 0.9, var_0);
  level.swim_blur_mag = maps\skyway_util::factor_value_min_max(0.6, 4.7, var_0);
  level.swim_blur_fade = maps\skyway_util::factor_value_min_max(0.4, 0.7, var_0);
  level.swim_quake_mag = maps\skyway_util::factor_value_min_max(0.001, 0.22, var_0);
  level.swim_quake_fade = maps\skyway_util::factor_value_min_max(0.001, 0.8, var_0);
}

heartfx(var_0) {
  level endon("flag_endbeach_start");
  level endon("flag_player_drowned");
  thread heartfx_solo();
  wait(var_0);
  thread heartfx_solo();
}

heartfx_solo() {
  level endon("flag_endbeach_start");
  level endon("flag_player_drowned");
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_rog_ent, level.swim_rumble_mag, 0.0, 0.05, 0.1, 0.3);
  thread drown_blur(level.swim_blur_mag, 0.2, 0.5);

  if(isDefined(level.player_fx_org)) {
    playFXOnTag(common_scripts\utility::getfx("swim_drowning_tunnel"), level.player_fx_org, "tag_helo");
  }

  earthquake(level.swim_quake_mag, level.swim_quake_fade, level.player.origin, 3000);
}

drown_blur(var_0, var_1, var_2) {
  level endon("flag_player_drowned");
  setblur(var_0, var_1);
  wait(var_1);
  setblur(0, var_2);
}

drown_choke(var_0) {
  level endon("flag_endbeach_start");
  level endon("flag_player_drowned");
  playFXOnTag(common_scripts\utility::getfx("player_view_bubbles_choke"), level.view_particle_source_locked, "tag_origin");
  level.player thread maps\_utility::play_sound_on_entity("sw_underwater_grunt");
  level.player thread maps\_utility::play_sound_on_entity("sw_underwater_bubbles_long");

  if(isDefined(var_0)) {
    level.player thread maps\_utility::play_sound_on_entity("sw_underwater_choke");
  }
}

drown_die() {
  var_0 = 0.00105;
  level endon("flag_end_swim_end");

  while(level.drown_death_timer < 1.0) {
    wait(level.timestep);
    level.drown_death_timer = level.drown_death_timer + var_0;
  }

  wait 3.3;
  common_scripts\utility::flag_set("flag_player_drowned");
  thread maps\_hud_util::fade_out(3.2);
  playFXOnTag(common_scripts\utility::getfx("player_view_bubbles_choke"), level.view_particle_source_locked, "tag_origin");
  level.player thread maps\_utility::play_sound_on_entity("sw_underwater_grunt");
  level.player thread maps\_utility::play_sound_on_entity("sw_underwater_bubbles_long");
  level.player thread maps\_utility::play_sound_on_entity("sw_underwater_choke");
  setdvar("ui_deadquote", &"SKYWAY_DROWN");
  maps\_utility::missionfailedwrapper();
}

end_swim_logic() {
  ally_setup();
  enemy_setup();
  thread enemy_logic();
  level.end_swim_anim_node thread maps\_anim::anim_single_solo(level._allies[0], "swimout");
  level.end_swim_anim_node thread maps\_anim::anim_single_solo(level._boss, "swimout");
  maps\skyway_util::setup_player_for_animated_sequence(1, 0);
  level.player allowswim(1);
  level.player enableslowaim(0.23, 0.23);
  level.player.swim_speed = getdvarfloat("player_swimSpeed");
  setsaveddvar("player_swimSpeed", 67.0);
  setsaveddvar("player_swimForwardSettleTime", 300);
  common_scripts\utility::flag_set("flag_end_swim_start");
  thread maps\skyway_audio::sfx_swim_exfil_begin();
  maps\_art::dof_enable_script(0, 40, 6, 1500, 3000, 1.5, 1);
  level.dopickyautosavechecks = 0;
  maps\_utility::autosave_by_name_silent("swim_start");
  level.end_swim_anim_node thread maps\_anim::anim_single_solo(level.player_rig, "swimout");
  var_0 = getanimlength(level.scr_anim["player_rig"]["swimout"]);
  var_1 = getnotetracktimes(level.scr_anim["player_rig"]["swimout"], "weapon_raise");
  var_2 = var_1[0] - 0.06;
  wait(var_0 * var_2);
  thread maps\skyway_audio::sfx_exfil_swim_plr();
  level.player takeallweapons();
  level.player giveweapon("underwater_hesh+swim");
  level.player enableweapons();
  level.player enableweaponswitch();
  level.player switchtoweaponimmediate("underwater_hesh+swim");
  common_scripts\utility::flag_set("flag_end_swim_rescue");
  wait(var_0 - var_0 * var_2);
  level._allies[0] forceteleport(level._end_swim.ally_start.origin, level._end_swim.ally_start.angles);
  level._boss hide();
  level._allies[0] hide();
  wait 1.5;
  level.player unlink();
  level.player_mover delete();
  level.player_rig delete();
  level.player thread player_lerp_swim_vars();
}

player_blend_swim_speed(var_0, var_1) {
  var_2 = 0.0;

  for(var_3 = getdvarfloat("player_swimSpeed"); var_2 < var_1; var_2 = var_2 + level.timestep) {
    var_4 = var_2 / var_1;
    var_5 = var_0 * var_4 + var_3 * (1 - var_4);
    setsaveddvar("player_swimSpeed", var_5);
    wait(level.timestep);
  }

  setsaveddvar("player_swimSpeed", var_0);
}

player_lerp_swim_vars() {
  level endon("flag_end_swim_end");
  var_0 = 0.03;
  var_1 = 18.0;
}

ally_setup() {}

enemy_setup() {
  var_0 = getEntArray("loco_breach_enemy", "targetname");

  if(!isDefined(level.end_enemies)) {
    level.end_enemies = [];
  } else {
    foreach(var_2 in level.end_enemies) {
      if(isalive(var_2)) {
        var_2 delete();
      }
    }

    level.end_enemies = maps\_utility::remove_dead_from_array(level.end_enemies);
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(var_4 != 2 && var_4 != 3) {
      continue;
    }
    if(!isDefined(level.end_enemies[var_4]) || !isalive(level.end_enemies[var_4])) {
      var_0[var_4].count = 2;
      var_2 = var_0[var_4] maps\_utility::spawn_ai(1);
      var_2 prepare_enemy_for_swimout();
      var_2.animname = "opfor" + (var_4 + 1);
      level.end_enemies = common_scripts\utility::array_add(level.end_enemies, var_2);
    }
  }
}

prepare_enemy_for_swimout() {
  maps\_utility::set_battlechatter(0);
  self.combatmode = "no_cover";
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.newenemyreactiondistsq_old = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
  self.grenadeammo = 0;
}

enemy_logic() {
  foreach(var_1 in level.end_enemies) {
    if(isalive(var_1)) {
      var_1 show();
    }
  }

  level.end_swim_anim_node maps\_anim::anim_single(level.end_enemies, "swimout");
  level.end_swim_anim_node maps\_anim::anim_loop(level.end_enemies, "swimout_loop");
}

retarget_engines() {
  var_0 = getent("lighttarget_engines", "targetname");
  var_1 = getEntArray("loco_engines", "script_noteworthy");

  foreach(var_3 in var_1) {
    var_3 retargetscriptmodellighting(var_0);
  }
}