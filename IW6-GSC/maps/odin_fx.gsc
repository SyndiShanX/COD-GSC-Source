/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_fx.gsc
*****************************************************/

main() {
  level._effect["vfx_scrnfx_space_glass_fog"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_space_glass_fog");
  level._effect["vfx_scrnfx_space_glass"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_space_glass");
  level._effect["vfx_shuttle_manuvr_thrust"] = loadfx("vfx/moments/odin/vfx_shuttle_manuvr_thrust");
  level._effect["glow_red_light_400_strobe"] = loadfx("vfx/ambient/lights/vfx_glow_red_light_400_strobe");
  level._effect["light_blue_steady_FX"] = loadfx("fx/misc/tower_light_blue_steady");
  level._effect["amber_light_45_beacon_nolight_glow"] = loadfx("vfx/ambient/lights/amber_light_45_beacon_nolight_glow");
  level._effect["strobe_flash_distant"] = loadfx("vfx/moments/odin/strobe_flash_distant");
  level._effect["odin_fire_close"] = loadfx("vfx/moments/odin/odin_fire_close");
  level._effect["space_microtar_shot"] = loadfx("vfx/gameplay/muzzle_flashes/smg/vfx_muz_smg_v");
  level._effect["space_clip_reload"] = loadfx("vfx/gameplay/space/space_clip_reload");
  level._effect["space_clip_reload_odin_ext"] = loadfx("vfx/gameplay/space/space_clip_reload_odin_ext");
  level._effect["electrical_transformer_explosion"] = loadfx("fx/explosions/electrical_transformer_explosion");
  level._effect["electrical_transformer_spark_runner_tight"] = loadfx("fx/explosions/electrical_transformer_spark_runner_tight");
  level._effect["electrical_transformer_sparks_a_cone"] = loadfx("fx/explosions/electrical_transformer_sparks_a_cone");
  level._effect["steam_jet_large"] = loadfx("fx/smoke/steam_jet_large");
  level._effect["flashlight"] = loadfx("vfx/moments/odin/flashlight_spotlight_odin_bright");
  level._effect["vfx_kyra_impact_head_space"] = loadfx("vfx/moments/odin/vfx_kyra_impact_head_space");
  level._effect["vfx_kyra_impact_head_space_blood"] = loadfx("vfx/moments/odin/vfx_kyra_impact_head_space_blood");
  level._effect["sun_lens_flare"] = loadfx("vfx/moments/odin/odin_sun_flare");
  level._effect["amber_light_45_flare_nolight"] = loadfx("vfx/ambient/lights/amber_light_45_flare_nolight");
  level._effect["blood_impact_space"] = loadfx("vfx/moments/odin/vfx_blood_impact_space");
  level._effect["blue_light_100_nolight"] = loadfx("vfx/ambient/lights/blue_light_100_nolight");
  level._effect["ext_dust_motes"] = loadfx("vfx/moments/odin/vfx_ext_dust_motes");
  level._effect["fuel_explosion_zerog"] = loadfx("vfx/moments/loki/fuel_explosion_zerog");
  level._effect["fuel_fire_zerog_small"] = loadfx("vfx/moments/loki/vfx_fuel_fire_zerog_small");
  level._effect["fuel_leak_zerog_small"] = loadfx("vfx/moments/loki/vfx_fuel_leak_zerog_small");
  level._effect["int_space_smoke"] = loadfx("vfx/moments/odin/vfx_int_space_smoke");
  level._effect["odin_airlock_dust"] = loadfx("vfx/moments/odin/odin_airlock_dust");
  level._effect["odin_airlock_dust_excited"] = loadfx("vfx/moments/odin/odin_airlock_dust_excited");
  level._effect["odin_airlock_steam"] = loadfx("vfx/moments/odin/odin_airlock_steam");
  level._effect["odin_blood_splat_48"] = loadfx("vfx/moments/odin/odin_blood_splat_48");
  level._effect["odin_burnup_kyra_trail_runner"] = loadfx("vfx/moments/odin/odin_burnup_kyra_trail_runner");
  level._effect["odin_burnup_player_trail_runner"] = loadfx("vfx/moments/odin/odin_burnup_player_trail_runner");
  level._effect["odin_burnup_sat_door_trail_runner"] = loadfx("vfx/moments/odin/odin_burnup_sat_door_trail_runner");
  level._effect["odin_burnup_sat_trail_runner"] = loadfx("vfx/moments/odin/odin_burnup_sat_trail_runner");
  level._effect["odin_burnup_scrnfx"] = loadfx("vfx/moments/odin/odin_burnup_scrnfx");
  level._effect["odin_debris_field_high_runner"] = loadfx("vfx/moments/odin/odin_debris_field_high_runner");
  level._effect["odin_debris_field_low_runner"] = loadfx("vfx/moments/odin/odin_debris_field_low_runner");
  level._effect["odin_debris_field_max_runner"] = loadfx("vfx/moments/odin/odin_debris_field_max_runner");
  level._effect["odin_debris_field_med_runner"] = loadfx("vfx/moments/odin/odin_debris_field_med_runner");
  level._effect["odin_escape_godray"] = loadfx("vfx/moments/odin/odin_escape_godray");
  level._effect["odin_fire_flare_runner"] = loadfx("vfx/moments/odin/odin_fire_flare_runner");
  level._effect["odin_helmet_glass_shatter"] = loadfx("vfx/moments/odin/odin_helmet_glass_shatter");
  level._effect["odin_int_dust"] = loadfx("vfx/moments/odin/odin_int_dust");
  level._effect["odin_int_white_light_rect"] = loadfx("vfx/moments/odin/odin_int_white_light_rect");
  level._effect["odin_int_white_light_rect_glow"] = loadfx("vfx/moments/odin/odin_int_white_light_rect_glow");
  level._effect["odin_rog_barrel_flash"] = loadfx("vfx/moments/odin/odin_rog_barrel_flash");
  level._effect["odin_rog_flash"] = loadfx("vfx/moments/odin/odin_rog_flash");
  level._effect["odin_rog_impact"] = loadfx("vfx/moments/odin/odin_rog_impact");
  level._effect["odin_rog_plume_01"] = loadfx("vfx/moments/odin/odin_rog_plume_01");
  level._effect["odin_rog_plume_02"] = loadfx("vfx/moments/odin/odin_rog_plume_02");
  level._effect["odin_rog_plume_03"] = loadfx("vfx/moments/odin/odin_rog_plume_03");
  level._effect["odin_rog_trail_flare"] = loadfx("vfx/moments/odin/odin_rog_trail_flare");
  level._effect["odin_rog_trail_geotrail_runner"] = loadfx("vfx/moments/odin/odin_rog_trail_geotrail_runner");
  level._effect["odin_sat_exp_rcs_fire_runner"] = loadfx("vfx/moments/odin/odin_sat_exp_rcs_fire_runner");
  level._effect["odin_sat_rcs_fire_puff"] = loadfx("vfx/moments/odin/odin_sat_rcs_fire_puff");
  level._effect["odin_sat_rcs_fuel_fire"] = loadfx("vfx/moments/odin/odin_sat_rcs_fuel_fire");
  level._effect["odin_sat_red_light"] = loadfx("vfx/moments/odin/odin_sat_red_light");
  level._effect["odin_sat_red_light_blinker_runner"] = loadfx("vfx/moments/odin/odin_sat_red_light_blinker_runner");
  level._effect["odin_sat_thrusters_ignite_sporadic"] = loadfx("vfx/moments/odin/odin_sat_thrusters_ignite_sporadic");
  level._effect["odin_sat_thrusters_runner"] = loadfx("vfx/moments/odin/odin_sat_thrusters_runner");
  level._effect["odin_shuttle_dock_steam"] = loadfx("vfx/moments/odin/odin_shuttle_dock_steam");
  level._effect["odin_spin_decompression"] = loadfx("vfx/moments/odin/odin_spin_decompression");
  level._effect["odin_spin_implosion"] = loadfx("vfx/moments/odin/odin_spin_implosion");
  level._effect["odin_spin_piece_debris"] = loadfx("vfx/moments/odin/odin_spin_piece_debris");
  level._effect["odin_spin_piece_debris_runner"] = loadfx("vfx/moments/odin/odin_spin_piece_debris_runner");
  level._effect["odin_spin_solar_flash"] = loadfx("vfx/moments/odin/odin_spin_solar_flash");
  level._effect["odin_spin_solar_player_debris"] = loadfx("vfx/moments/odin/odin_spin_solar_player_debris");
  level._effect["odin_spin_solar_runner"] = loadfx("vfx/moments/odin/odin_spin_solar_runner");
  level._effect["red_light_45_flare_nolight"] = loadfx("vfx/ambient/lights/red_light_45_flare_nolight");
  level._effect["red_light_45_rect_nolight"] = loadfx("vfx/ambient/lights/red_light_45_rect_nolight");
  level._effect["space_jet_small"] = loadfx("vfx/gameplay/space/space_jet_small");
  level._effect["spc_battle_smoke_200"] = loadfx("vfx/ambient/space/spc_battle_smoke_200");
  level._effect["spc_battle_smoke_200_thick"] = loadfx("vfx/ambient/space/spc_battle_smoke_200_thick");
  level._effect["spc_explosion_1200"] = loadfx("vfx/gameplay/space/spc_explosion_1200");
  level._effect["spc_explosion_240"] = loadfx("vfx/gameplay/space/spc_explosion_240");
  level._effect["spc_fire_big_light"] = loadfx("vfx/ambient/space/spc_fire_big_light");
  level._effect["spc_fire_oriented"] = loadfx("vfx/ambient/space/spc_fire_oriented");
  level._effect["spc_fire_oriented_big"] = loadfx("vfx/ambient/space/spc_fire_oriented_big");
  level._effect["spc_fire_puff_bigger_light"] = loadfx("vfx/ambient/space/spc_fire_puff_bigger_light");
  level._effect["spc_shell_casings"] = loadfx("vfx/ambient/space/spc_shell_casings");
  level._effect["spc_sparks_jet_single_runner"] = loadfx("vfx/ambient/space/spc_sparks_jet_single_runner");
  level._effect["station_piece_collision"] = loadfx("vfx/moments/odin/station_piece_collision");
  level._effect["warm_light_30_rect_nolight"] = loadfx("vfx/ambient/lights/warm_light_30_rect_nolight");
  level._effect["white_light_40_nolight"] = loadfx("vfx/ambient/lights/white_light_40_nolight");
  level._effect["zg_electrical_sparks_big"] = loadfx("vfx/ambient/space/zg_electrical_sparks_big");
  level._effect["zg_electrical_sparks_big_single_runner"] = loadfx("vfx/ambient/space/zg_electrical_sparks_big_single_runner");
  level._effect["zg_electrical_sparks_runner"] = loadfx("vfx/ambient/space/zg_electrical_sparks_runner");
  level._effect["zg_electrical_sparks_runner_40"] = loadfx("vfx/ambient/space/zg_electrical_sparks_runner_40");
  level._effect["zg_fire_jet"] = loadfx("vfx/ambient/space/zg_fire_jet");
  level._effect["zg_fire_puff"] = loadfx("vfx/ambient/space/zg_fire_puff");
  level._effect["zg_fire_puff_single"] = loadfx("vfx/ambient/space/zg_fire_puff_single");
  maps\_utility::setsaveddvar_cg_ng("fx_alphathreshold", 9, 2);

  if(!getdvarint("r_reflectionProbeGenerate")) {
    if(isDefined(level.prologue) && level.prologue == 1) {
      level.createfx_offset = (0, 50000, 50000);
      maps\createfx\odin_fx::main();
      level.createfx_offset = undefined;
    } else
      maps\createfx\odin_fx::main();

    maps\createfx\odin_sound::main();
  }
}

fx_init() {
  common_scripts\utility::flag_init("fx_start_burnup");
  common_scripts\utility::flag_init("clear_for_sat_clean");
  level thread fx_ambient_setup();
  level.crack_effects = [];
  level.crack_effects[0] = level._effect["vfx_scrnfx_odin_helmet_cracks_0"];
  level.crack_effects[1] = level._effect["vfx_scrnfx_odin_helmet_cracks_1"];
  level.crack_effects[2] = level._effect["vfx_scrnfx_odin_helmet_cracks_2"];
  level.crack_effects[3] = level._effect["vfx_scrnfx_odin_helmet_cracks_3"];
  level.crack_effects[4] = level._effect["vfx_scrnfx_odin_helmet_cracks_4"];
  level.crack_effects[5] = level._effect["vfx_scrnfx_odin_helmet_cracks_5"];
}

odin_lgt_pulsing(var_0) {
  level endon("start_transition_to_youngblood");
  self endon("stopLightPulsing");
  var_1 = self getlightintensity();
  var_2 = 0.05;
  var_3 = var_1;
  var_4 = 0.3 / var_0;
  var_5 = 0.6 / var_0;
  var_6 = (var_1 - var_2) / (var_4 / 0.05);
  var_7 = (var_1 - var_2) / (var_5 / 0.05);
  wait(randomfloatrange(0.01, 0.3));

  for(;;) {
    var_8 = 0;

    while(var_8 < var_5) {
      var_3 = var_3 - var_7;
      var_3 = clamp(var_3, 0, 100);
      self setlightintensity(var_3);
      var_8 = var_8 + 0.05;
      wait 0.05;
    }

    wait 1;
    var_8 = 0;

    while(var_8 < var_4) {
      var_3 = var_3 + var_6;
      var_3 = clamp(var_3, 0, 100);
      self setlightintensity(var_3);
      var_8 = var_8 + 0.05;
      wait 0.05;
    }

    wait 0.5;
  }
}

odin_lgt_flicker(var_0, var_1, var_2, var_3) {
  self endon("stopLightFlicker");
  var_4 = var_0;
  var_5 = 0.0;
  maps\_utility::ent_flag_init("stop_flicker");
  var_6 = self getlightintensity();
  var_7 = 0;
  var_8 = var_6;
  var_9 = 0;

  for(;;) {
    if(maps\_utility::ent_flag("stop_flicker")) {
      wait 0.05;
      continue;
    }

    var_10 = var_4;
    var_4 = var_0 + (var_1 - var_0) * randomfloat(1.0);
    var_9 = randomintrange(1, 10);

    if(var_2 != var_3) {
      var_5 = var_5 + randomfloatrange(var_2, var_3);
    }
    else {
      var_5 = var_5 + var_2;
    }

    if(var_5 == 0) {
      var_5 = var_5 + 0.0000001;
    }

    for(var_11 = (var_10 - var_4) * (1 / var_5); var_5 > 0 && !maps\_utility::ent_flag("stop_flicker"); var_5 = var_5 - 0.05) {
      self setlightcolor(var_4 + var_11 * var_5);
      wait 0.05;
    }

    while(var_9) {
      wait(randomfloatrange(0.05, 0.1));

      if(var_8 > 0.2) {
        var_8 = randomfloatrange(0, 0.3);
      }
      else {
        var_8 = var_6;
      }

      self setlightintensity(var_8);
      var_9--;
    }

    self setlightintensity(var_6);
    wait(randomfloatrange(var_2, var_3));
  }
}

changelightintensityovertime(var_0, var_1) {
  var_2 = self getlightintensity();
  var_3 = int(var_1 / 0.05);
  var_4 = (var_0 - var_2) / var_3;
  var_5 = var_2;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_5 = var_5 + var_4;
    self setlightintensity(var_5);
    wait 0.05;
  }

  self setlightintensity(var_0);
}

place_sun_with_moving_source(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }

  var_4 = 0;
  var_5 = 0;
  var_6 = maps\_utility::create_sunflare_setting("odin_spin");

  for(;;) {
    if(isDefined(var_1)) {
      var_7 = var_0 gettagorigin("tag_flash");
    }
    else {
      var_7 = var_0.origin;
    }

    var_4 = atan((level.player.origin[2] - var_7[2]) / sqrt(squared(level.player.origin[0] - var_7[0]) + squared(level.player.origin[1] - var_7[1])));

    if(level.player.origin[0] < var_7[0]) {
      var_5 = atan((level.player.origin[1] - var_7[1]) / (level.player.origin[0] - var_7[0]));
    }
    else {
      var_5 = 180 + atan((level.player.origin[1] - var_7[1]) / (level.player.origin[0] - var_7[0]));
    }

    var_6.position = (var_4, var_5, 0);
    maps\_art::sunflare_changes("odin_spin", 0);
    wait 0.05;

    if(isDefined(var_3)) {
      if(common_scripts\utility::flag(var_3)) {
        break;
      }
    }
  }
}

lgt_init() {
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 1.5, 9.01);
  setsaveddvar("actor_spaceLightingOffset", 20);
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  common_scripts\utility::flag_init("lgt_flag_end_sun_move");
  level.spinsuntranstime = 0.25;
  var_0 = getEntArray("lgt_odin_pulsing", "script_noteworthy");

  foreach(var_2 in var_0) {
  var_2 thread odin_lgt_pulsing(1);
  }

  thread lgt_intro_sequence();
  thread lgt_ally_sequence();
  thread lgt_escape_sequence();
  thread lgt_spin_sequence();
  thread lgt_sat_sequence();
  resetsunlight();
  resetsundirection();
  var_4 = getent("intro_airlock_door", "targetname");
  var_5 = spawn("script_model", (0, 0, 0));
  var_5 setModel("tag_origin");
  var_5.origin = var_4.origin - (168, 0, 0);
  var_4 retargetscriptmodellighting(var_5);
}

lgt_intro_sequence() {
  common_scripts\utility::flag_wait("do_transition_to_odin");
  maps\_art::sunflare_changes("odin_default", 0);
  var_0 = vectornormalize((-1232, -2641, -155));

  if(!isDefined(level.sunflare)) {
    level.sunflare = spawn("script_model", (0, 0, 0));
    level.sunflare setModel("tag_origin");
    playFXOnTag(level._effect["sun_lens_flare"], level.sunflare, "tag_origin");
  }

  while(!common_scripts\utility::flag("ally_clear")) {
    level.sunflare.origin = level.player.origin + var_0 * 100000;
    common_scripts\utility::waitframe();
  }
}

lgt_ally_sequence() {
  common_scripts\utility::flag_wait_any("unlock_post_infil_auto_door", "lgt_trg_allySunSample", "player_approaching_infiltration");
  setsaveddvar("actor_spaceLightingOffset", -10);
  setsaveddvar("sm_sunSampleSizeNear", 0.2);
  common_scripts\utility::flag_wait("invader_scene_begin");
  setsaveddvar("actor_spaceLightingOffset", 20);
}

lgt_escape_sequence() {
  common_scripts\utility::flag_wait("ally_clear");
  setsaveddvar("sm_sunSampleSizeNear", 0.1);
  maps\_art::sunflare_changes("odin_escape", 0);
  thread lgt_odin_firing();
  var_0 = vectornormalize((296, -835, -20));

  if(!isDefined(level.sunflare)) {
    level.sunflare = spawn("script_model", (0, 0, 0));
    level.sunflare setModel("tag_origin");
    playFXOnTag(level._effect["sun_lens_flare"], level.sunflare, "tag_origin");
  }

  while(!common_scripts\utility::flag("lgt_trg_odin_destruction")) {
    level.sunflare.origin = level.player.origin + var_0 * 100000;
    common_scripts\utility::waitframe();
  }
}

lgt_spin_sequence() {
  level endon("start_transition_to_youngblood");
  common_scripts\utility::flag_wait("lgt_spin_setup");
  level.spinsuntranstime = 10;
  common_scripts\utility::flag_set("lgt_trg_odin_destruction");
  setsaveddvar("sm_sunSampleSizeNear", 0.1);

  if(!isDefined(level.sunflare)) {
    level.sunflare = spawn("script_model", (0, 0, 0));
    level.sunflare setModel("tag_origin");
    playFXOnTag(level._effect["sun_lens_flare"], level.sunflare, "tag_origin");
  }

  var_0 = maps\odin_util::earth_get_script_mover();
  var_1 = (48583, 18170, -45500);
  level.sunflare.origin = var_0.origin - var_1;
  level.sunflare linkto(var_0);
  wait 2;
  thread place_sun_with_moving_source(level.sunflare, undefined, undefined, "lgt_flag_end_sun_move");
  common_scripts\utility::flag_wait_any("lgt_flag_spin_over", "trigger_spacejump");
  level.sunflare unlink(var_0);
  common_scripts\utility::flag_set("lgt_flag_end_sun_move");
}

lgt_sat_sequence() {
  level endon("start_transition_to_youngblood");
  common_scripts\utility::flag_wait("trigger_spacejump");
  wait 0.25;
  var_0 = vectornormalize((-3, -5, 6));
  var_1 = level.player.origin + var_0 * 100000;

  if(!isDefined(level.sunflare)) {
    level.sunflare = spawn("script_model", (-55629, -13122.8, 46438.3));
    level.sunflare setModel("tag_origin");
    playFXOnTag(level._effect["sun_lens_flare"], level.sunflare, "tag_origin");
  }

  thread maps\_art::sunflare_changes("odin_satellite", level.spinsuntranstime);
  level.sunflare moveto(var_1, level.spinsuntranstime);
  common_scripts\utility::flag_set("lgt_trg_odin_destruction");
  enableforcedsunshadows();
  thread maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear", 0.6, 1.5);
  common_scripts\utility::flag_wait("fx_start_burnup");
  killfxontag(level._effect["sun_lens_flare"], level.sunflare, "tag_origin");
  disableforcedsunshadows();
}

lgt_odin_firing() {
  var_0 = getEntArray("lgt_odin_destruction", "script_noteworthy");

  foreach(var_2 in var_0) {
  var_2 thread odin_lgt_pulsing(1);
  }

  thread rotatelights("lgt_odin_spin_ref", "lgt_odin_spinning", "pitch");
  thread rotatelights("lgt_odin_spin_ref_1", "lgt_odin_spinning_1", "yaw");
  thread rotatelights("lgt_odin_spin_ref_2", "lgt_odin_spinning_2", "roll");
  thread fx_rotate_lights_setup();
  common_scripts\utility::flag_wait("lgt_trg_odin_destruction");
  wait 3;

  foreach(var_2 in var_0) {
    var_2 notify("stopLightPulsing");
    var_2 setlightintensity(0.1);
    var_2 maps\_lights::changelightcolorto((0.993235, 0.24, 0.145098), 0.4, 0.1, 0.05);
  }

  wait 3.5;

  foreach(var_2 in var_0) {
    var_2 changelightintensityovertime(randomfloatrange(1.3, 1.7), 0.1);
    common_scripts\utility::waitframe();
    var_2 thread odin_lgt_pulsing(4);
  }
}

rotatelights(var_0, var_1, var_2) {
  var_3 = getEntArray(var_1, "script_noteworthy");
  var_4 = getent(var_0, "script_noteworthy");

  if(!isDefined(var_3) || !isDefined(var_4) || !isDefined(var_2)) {
    return;
  }
  var_4 thread rotateme(-360, var_2, 1.0);

  foreach(var_6 in var_3) {
  var_6 thread maps\_utility::manual_linkto(var_4, var_6.origin - var_4.origin);
  }
}

rotateme(var_0, var_1, var_2) {
  level endon("start_transition_to_youngblood");
  self endon("stopLightSpinning");

  for(;;) {
    switch (var_1) {
      case "yaw":
        self rotateyaw(var_0, var_2);
        wait(var_2);
        break;
      case "pitch":
        self rotatepitch(var_0, var_2);
        wait(var_2);
        break;
      case "roll":
        self rotateroll(var_0, var_2);
        wait(var_2);
        break;
      default:
        wait 1;
        break;
    }
  }
}

fx_ambient_setup() {
  level thread fx_intro_ambient();
  level thread fx_airlock_ambient();
  level thread fx_escape_ambient();
  level thread fx_spin_ambient();
  level thread fx_jump_ambient();
  level thread fx_sat_ambient();
}

fx_intro_ambient() {
  level endon("start_transition_to_youngblood");

  for(;;) {
    common_scripts\utility::flag_wait("fx_intro_ambient");
    common_scripts\utility::exploder("intro_ambient");
    common_scripts\utility::exploder("intro_ambient_airlock_dust");
    common_scripts\utility::flag_waitopen("fx_intro_ambient");
    maps\_utility::stop_exploder("intro_ambient");
    maps\_utility::stop_exploder("intro_ambient_airlock_dust");
    maps\_utility::stop_exploder("intro_airlock_complete");
  }
}

fx_airlock_ambient() {
  level endon("start_transition_to_youngblood");

  for(;;) {
    common_scripts\utility::flag_wait("fx_airlock_ambient");
    common_scripts\utility::exploder("airlock_ambient");
    common_scripts\utility::flag_waitopen("fx_airlock_ambient");
    maps\_utility::stop_exploder("airlock_ambient");
  }
}

fx_escape_ambient() {
  level endon("start_transition_to_youngblood");

  for(;;) {
    common_scripts\utility::flag_wait("fx_escape_ambient");
    common_scripts\utility::exploder("escape_ambient");
    common_scripts\utility::flag_waitopen("fx_escape_ambient");
    maps\_utility::stop_exploder("escape_ambient");
  }
}

fx_spin_ambient() {
  level endon("start_transition_to_youngblood");

  for(;;) {
    common_scripts\utility::flag_wait("fx_spin_ambient");
    common_scripts\utility::exploder("spin_ambient");
    common_scripts\utility::flag_waitopen("fx_spin_ambient");
    maps\_utility::stop_exploder("spin_ambient");
  }
}

fx_jump_ambient() {
  level endon("start_transition_to_youngblood");

  for(;;) {
    common_scripts\utility::flag_wait("fx_jump_ambient");
    common_scripts\utility::exploder("jump_ambient");
    common_scripts\utility::exploder("jump_ambient_fire_1");
    common_scripts\utility::exploder("jump_ambient_fire_2");
    common_scripts\utility::exploder("jump_ambient_fire_3");
    common_scripts\utility::exploder("jump_ambient_fire_4");
    common_scripts\utility::exploder("jump_ambient_fire_5");
    level thread fx_jump_ambient_fire_killer();
    common_scripts\utility::flag_waitopen("fx_jump_ambient");
    maps\_utility::stop_exploder("jump_ambient");
    maps\_utility::stop_exploder("jump_ambient_fire_1");
    maps\_utility::stop_exploder("jump_ambient_fire_2");
    maps\_utility::stop_exploder("jump_ambient_fire_3");
    maps\_utility::stop_exploder("jump_ambient_fire_4");
    maps\_utility::stop_exploder("jump_ambient_fire_5");
  }
}

fx_jump_ambient_fire_killer() {
  level endon("start_transition_to_youngblood");
  wait 4.5;
  maps\_utility::stop_exploder("jump_ambient_fire_1");
  level waittill("decomp_player_anim_done");
  wait 9;
  maps\_utility::stop_exploder("jump_ambient_fire_2");
  wait 3;
  maps\_utility::stop_exploder("jump_ambient_fire_3");
  wait 3;
  maps\_utility::stop_exploder("jump_ambient_fire_4");
  wait 3;
  maps\_utility::stop_exploder("jump_ambient_fire_5");
}

fx_sat_ambient() {
  level endon("start_transition_to_youngblood");

  for(;;) {
    common_scripts\utility::flag_wait("fx_sat_ambient");
    common_scripts\utility::exploder("sat_ambient");
    common_scripts\utility::flag_waitopen("fx_sat_ambient");
    maps\_utility::stop_exploder("sat_ambient");
  }
}

fx_infil_red_shirt_die(var_0) {
  playFXOnTag(level._effect["blood_impact_space"], var_0, "j_head");
}

fx_escape_fire_rods() {
  level endon("player_exited_escape_hallway");
  var_0 = getent("sat_barrel_top", "script_noteworthy");
  var_1 = getent("sat_barrel_target", "script_noteworthy");
  var_2 = getent("sat_barrel_bottom", "script_noteworthy");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.angles = var_0.angles;
  var_4 = getent("fake_earth", "targetname");
  var_5 = 1;
  var_6 = maps\odin_util::satellite_get_script_mover();

  while(!common_scripts\utility::flag("absolute_fire_decompression")) {
    common_scripts\utility::flag_wait("fire_rog");
    common_scripts\utility::flag_clear("fire_rog");
    common_scripts\utility::flag_set("ready_to_fire_next_salvo");
    var_7 = "tag_fx_impact_" + var_5;
    var_8 = var_4 gettagorigin(var_7);
    var_9 = var_1.origin - var_0.origin;
    var_10 = var_8 - var_0.origin;
    var_11 = common_scripts\utility::spawn_tag_origin();
    var_11.origin = var_6.origin;
    var_11.angles = vectortoangles(var_9);
    var_6 linkto(var_11);

    if(var_7 == "tag_fx_impact_1") {
      var_12 = vectortoangles(var_10) + (0, 0, -40);
    }
    else {
      var_12 = vectortoangles(var_10) + (0, 0, randomfloatrange(-4, 4));
    }

    var_11 rotateto(var_12, 4, 2, 2);
    thread fire_sat_rcs_thrusters(var_11.angles, vectortoangles(var_10), 4);
    wait 4;
    var_6 unlink();
    var_11 delete();
    var_3.origin = var_0.origin;
    wait 1.2;
    thread rog_firing_fx_at_player(var_2.origin);
    thread maps\odin_audio::sfx_dist_odin_fire();
    wait 2;
    playFXOnTag(level._effect["odin_rog_flash"], var_3, "tag_origin");
    thread bright_light_flash_into_console();
    thread sfx_and_visual_shake();
    thread odin_missile_rod(var_2, var_1, 0.1);
    var_4 thread fx_escape_play_rog_impact(var_7, 8);
    var_3 thread fx_rog_trail(0.1, 6.7);
    var_3 thread rog_fire_at_off_axis_target(8, var_7, var_4, "player_exited_escape_hallway", "odin_interior_rog", "odin_interior");
    var_5 = var_5 + 1;

    if(var_5 > 7) {
      var_5 = 2;
    }
  }

  var_3 delete();
}

fx_spin_fire_rods() {
  level endon("start_transition_to_youngblood");
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_1 = getent("sat_barrel_top", "script_noteworthy");
  var_2 = getent("sat_barrel_target", "script_noteworthy");
  var_3 = getent("sat_barrel_bottom", "script_noteworthy");
  var_0.angles = var_1.angles;
  var_4 = maps\odin_util::earth_get_script_mover().earth_model;
  var_5 = 4;
  var_6 = maps\odin_util::satellite_get_script_mover();
  var_7 = getent("final_sat_orientation", "targetname");

  while(!common_scripts\utility::flag("satellite_end_anim_started")) {
    var_8 = "tag_fx_impact_" + var_5;
    var_9 = var_4 gettagorigin(var_8);
    var_10 = var_2.origin - var_1.origin;
    var_11 = vectortoangles(var_9 - var_1.origin);
    var_12 = var_7.angles - var_11;
    var_13 = distance(level.ally.origin, var_6.origin);
    var_14 = distance(level.player.origin, var_6.origin);
    var_15 = 1;
    level.satellite_small_thrusts = 0;

    if(!common_scripts\utility::flag("triggered_finale")) {
      if(var_13 > 6250 || var_14 > 6250) {
        var_16 = var_13 / 1000;
        var_15 = 3;
        var_17 = var_7.angles + (randomfloatrange(0 - var_16, var_16), randomfloatrange(0 - var_16, var_16), randomfloatrange(0 - var_16, var_16));
      } else {
        var_17 = var_7.angles;
        level.satellite_small_thrusts = 1;
      }
    } else {
      var_17 = var_7.angles;
      level.satellite_small_thrusts = 1;
    }

    if(!common_scripts\utility::flag("first_finale_stage_done")) {
      thread fire_sat_rcs_thrusters((var_6.angles - var_12) * var_15, (var_17 - var_12) * var_15, 6);
    }

    if(common_scripts\utility::flag("lgt_flag_spin_over")) {
      var_6 rotateto(var_17, 6, 3, 3);
      wait 6;
    } else
      wait 6;

    var_0.origin = var_1.origin;
    wait 0.5;
    thread rog_firing_fx_at_player(var_3.origin);
    thread maps\odin_audio::sfx_dist_odin_fire();
    wait 2;
    playFXOnTag(level._effect["odin_rog_flash"], var_0, "tag_origin");
    thread sfx_and_visual_shake();

    if(!common_scripts\utility::flag("landed_on_satellite")) {
      thread odin_missile_rod(var_3, var_2, 0.1);
      var_4 thread fx_spin_play_rog_impact(var_8, 8);
      var_0 thread fx_rog_trail(1.4, 6.7);
      var_0 thread rog_fire_at_off_axis_target(8, var_8, var_4, "triggered_finale", "odin_spin_rog", "odin_spin");
    }

    var_5 = var_5 + 1;

    if(var_5 > 11) {
      var_5 = 4;
    }

    wait 1;
  }

  var_0 delete();
}

sat_pretend_to_keep_moving_and_firing() {}

rog_fire_at_off_axis_target(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = getent("sat_barrel_bottom", "script_noteworthy");
  var_8 = getent("sat_barrel_target", "script_noteworthy");
  var_9 = common_scripts\utility::spawn_tag_origin();
  var_9.origin = var_8.origin;
  var_10 = var_7.origin - var_6.origin;
  var_6.angles = vectortoangles(var_10);

  if(!common_scripts\utility::flag(var_3)) {
    var_6 thread god_rays_from_rog(8, var_4, var_5);
  }

  var_6 moveto(var_7.origin, var_0 * 0.1, var_0 * 0.1, 0);
  var_6 waittill("movedone");
  var_11 = 0;

  while(var_11 < 110) {
    if(common_scripts\utility::flag("landed_on_satellite")) {
      break;
    }

    var_12 = var_2 gettagorigin(var_1);
    var_10 = var_6.origin - var_9.origin;
    var_6.angles = vectortoangles(var_10);
    var_9 moveto(var_12, 1.5);
    var_6 moveto(var_9.origin, var_0);
    var_11 = var_11 + 1;
    wait 0.05;
  }
}

god_rays_from_rog(var_0, var_1, var_2) {
  if(maps\_utility::is_gen4()) {
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;

    if(isDefined(var_1)) {
      maps\_utility::vision_set_fog_changes(var_1, 0.5);
      wait 0.5;
    }

    var_6 = maps\_utility::create_sunflare_setting("odin_rog_fire");

    if(isDefined(var_2)) {
      maps\_utility::delaythread(3, maps\_utility::vision_set_fog_changes, var_2, 3);
      maps\_utility::delaythread(6, maps\_utility::vision_set_fog_changes, "", 0);
    }

    for(;;) {
      var_7 = self.origin;
      var_3 = atan((level.player.origin[2] - var_7[2]) / sqrt(squared(level.player.origin[0] - var_7[0]) + squared(level.player.origin[1] - var_7[1])));

      if(level.player.origin[0] < var_7[0]) {
        var_4 = atan((level.player.origin[1] - var_7[1]) / (level.player.origin[0] - var_7[0]));
      }
      else {
        var_4 = 180 + atan((level.player.origin[1] - var_7[1]) / (level.player.origin[0] - var_7[0]));
      }

      var_6.position = (var_3, var_4, 0);
      wait 0.05;
      var_5 = var_5 + 0.05;

      if(var_5 > var_0) {
        break;
      }
    }
  }
}

god_rays_airlock() {
  if(maps\_utility::is_gen4()) {
    wait 4;
    var_0 = maps\_utility::create_sunflare_setting("odin_airlock");
    var_0.position = (90, -90, 0);
    maps\_art::sunflare_changes("odin_airlock", 0);
    maps\_utility::vision_set_fog_changes("odin_interior_rog", 3);
    wait 4;
    maps\_utility::vision_set_fog_changes("", 4);
  }
}

fire_sat_rcs_thrusters(var_0, var_1, var_2) {
  level endon("triggered_finale");
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;

  if(level.satellite_small_thrusts == 1) {
    var_3 = 4;
    var_4 = 4;
    var_5 = 3;
    var_6 = 3;
  }

  if(var_0[1] < var_1[1]) {
    var_3 = 5;
  }
  else {
    var_6 = 5;
  }

  if(var_0[0] < var_1[0]) {
    var_5 = 3;
  }
  else {
    var_4 = 3;
  }

  thread maps\odin_audio::sfx_satellite_lat_thruster_loop(level.thruster_01_lat_fx);
  thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_03_lat_fx);
  thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_01_lat_fx);

  for(var_7 = 0; var_7 < var_2 * 2; var_7++) {
    if(var_3 > randomfloatrange(1, 6)) {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_lat_fx, "tag_origin");
    }
    else {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_lat_fx, "tag_origin");
    }

    if(var_6 > randomfloatrange(1, 6)) {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_lat_fx, "tag_origin");
    }
    else {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_lat_fx, "tag_origin");
    }

    if(var_5 > randomfloatrange(1, 5)) {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_lat_fx, "tag_origin");
    }
    else {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_lat_fx, "tag_origin");
    }

    if(var_4 > randomfloatrange(1, 5)) {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_lat_fx, "tag_origin");
    }
    else {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_lat_fx, "tag_origin");
    }

    wait 0.15;
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_lat_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_lat_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_lat_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_lat_fx, "tag_origin");
    wait 0.05;
  }

  common_scripts\utility::flag_set("stop_sat_lat_thrust_loop");
  wait(var_2 * 0.1);
  thread maps\odin_audio::sfx_satellite_lat_thruster_loop(level.thruster_01_lat_fx);
  thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_03_lat_fx);
  thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_01_lat_fx);

  for(var_7 = 0; var_7 < var_2 * 2; var_7++) {
    if(var_6 > randomfloatrange(1, 6)) {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_lat_fx, "tag_origin");
    }
    else {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_lat_fx, "tag_origin");
    }

    if(var_3 > randomfloatrange(1, 6)) {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_lat_fx, "tag_origin");
    }
    else {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_lat_fx, "tag_origin");
    }

    if(var_4 > randomfloatrange(1, 5)) {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_lat_fx, "tag_origin");
    }
    else {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_lat_fx, "tag_origin");
    }

    if(var_5 > randomfloatrange(1, 5)) {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_lat_fx, "tag_origin");
    }
    else {
      playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_lat_fx, "tag_origin");
    }

    wait 0.15;
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_lat_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_lat_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_lat_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_lat_fx, "tag_origin");
    wait 0.05;
  }

  common_scripts\utility::flag_set("stop_sat_lat_thrust_loop");
}

rog_firing_fx_at_player(var_0) {
  if(distance2d(var_0, level.player.origin) < 15000) {
    earthquake(0.1, 3, var_0, 14000);

    if(!common_scripts\utility::flag("hold_satellite_back_thrusters")) {
      thread rog_firing_back_thrusters();
    }

    wait 1.0;
    playFX(level._effect["odin_fire_close"], var_0);
    wait 1;
    earthquake(0.3, 2, var_0, 14000);
    wait 1;
    earthquake(0.1, 6, var_0, 14000);
  }
}

rog_firing_back_thrusters() {
  level endon("first_finale_stage_done");
  wait 0.5;

  if(!common_scripts\utility::flag("first_finale_stage_done")) {
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_fx, "tag_origin");
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_fx, "tag_origin");
    thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_01_fx);
    thread maps\odin_audio::sfx_satellite_thruster_loop(level.thruster_01_fx);
    thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_02_fx);
    common_scripts\utility::waitframe();
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
    thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_03_fx);
    thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_04_fx);
    wait 0.6;
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
    wait(randomfloatrange(0.05, 0.15));
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_fx, "tag_origin");
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_fx, "tag_origin");
    common_scripts\utility::waitframe();
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
    wait 0.8;
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
    wait(randomfloatrange(0.1, 0.8));
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_fx, "tag_origin");
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_fx, "tag_origin");
    common_scripts\utility::waitframe();
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
    playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
    wait 1.2;
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
    stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
    common_scripts\utility::flag_set("stop_sat_thrust_loop");
  }
}

fx_escape_play_rog_impact(var_0, var_1) {
  var_2 = gettime();
  var_3 = gettime() - var_1 * 1000;

  for(;;) {
    var_3 = gettime() - var_1 * 1000;

    if(common_scripts\utility::flag("absolute_fire_decompression")) {
      break;
    } else if(var_3 >= var_2) {
      playFXOnTag(level._effect["odin_rog_impact"], self, var_0);
      thread maps\odin_audio::sfx_rog_impact();
      break;
    }

    wait 0.05;
  }

  common_scripts\utility::flag_wait("absolute_fire_decompression");
  wait 0.5;
  killfxontag(level._effect["odin_rog_impact"], self, var_0);
}

fx_spin_play_rog_impact(var_0, var_1) {
  wait(var_1);
  playFXOnTag(level._effect["odin_rog_impact"], self, var_0);
}

odin_missile_rod(var_0, var_1, var_2) {
  wait(var_2);
}

fx_rog_trail(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(level._effect["odin_rog_trail_flare"], self, "tag_origin");
  playFXOnTag(level._effect["odin_rog_trail_geotrail_runner"], self, "tag_origin");
  wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  else {
    killfxontag(level._effect["odin_rog_trail_flare"], self, "tag_origin");
  }
}

sfx_and_visual_shake() {
  if(level.play_shake_sound == 0) {
    wait 0.7;
    thread maps\odin_audio::sfx_shaky_camera_moment();
    wait 0.4;
    earthquake(randomfloatrange(0.05, 0.12), 3.0, level.player.origin, 500);
  } else if(level.play_shake_sound == 3)
    earthquake(randomfloatrange(0.05, 0.12), 3.0, level.player.origin, 500);
}

bright_light_flash_into_console() {
  var_0 = getent("bright_light_flash_into_console", "script_noteworthy");

  for(var_1 = 0; var_1 <= 1.8; var_1 = var_1 + 0.05) {
    var_0 setlightintensity(var_1);
    wait 0.06;
  }

  while(var_1 > 0) {
    var_0 setlightintensity(var_1);
    wait 0.1;
    var_1 = var_1 - 0.05;
  }
}

satellite_rcs_thrusters() {
  level.satellite_small_thrusts = 0;
  level.thruster_01 = getent("sat_thruster_01", "script_noteworthy");
  level.thruster_02 = getent("sat_thruster_02", "script_noteworthy");
  level.thruster_03 = getent("sat_thruster_03", "script_noteworthy");
  level.thruster_04 = getent("sat_thruster_04", "script_noteworthy");
  level.thruster_01_lat = getent("sat_thruster_01_lat", "script_noteworthy");
  level.thruster_02_lat = getent("sat_thruster_02_lat", "script_noteworthy");
  level.thruster_03_lat = getent("sat_thruster_03_lat", "script_noteworthy");
  level.thruster_04_lat = getent("sat_thruster_04_lat", "script_noteworthy");
  level.thruster_01_fx = common_scripts\utility::spawn_tag_origin();
  level.thruster_01_fx.origin = level.thruster_01.origin;
  level.thruster_01_fx.angles = level.thruster_01.angles;
  level.thruster_01_fx linkto(level.thruster_01);
  level.thruster_02_fx = common_scripts\utility::spawn_tag_origin();
  level.thruster_02_fx.origin = level.thruster_02.origin;
  level.thruster_02_fx.angles = level.thruster_02.angles;
  level.thruster_02_fx linkto(level.thruster_02);
  level.thruster_03_fx = common_scripts\utility::spawn_tag_origin();
  level.thruster_03_fx.origin = level.thruster_03.origin;
  level.thruster_03_fx.angles = level.thruster_03.angles;
  level.thruster_03_fx linkto(level.thruster_03);
  level.thruster_04_fx = common_scripts\utility::spawn_tag_origin();
  level.thruster_04_fx.origin = level.thruster_04.origin;
  level.thruster_04_fx.angles = level.thruster_04.angles;
  level.thruster_04_fx linkto(level.thruster_04);
  level.thruster_01_lat_fx = common_scripts\utility::spawn_tag_origin();
  level.thruster_01_lat_fx.origin = level.thruster_01_lat.origin;
  level.thruster_01_lat_fx.angles = level.thruster_01_lat.angles;
  level.thruster_01_lat_fx linkto(level.thruster_01_lat);
  level.thruster_02_lat_fx = common_scripts\utility::spawn_tag_origin();
  level.thruster_02_lat_fx.origin = level.thruster_02_lat.origin;
  level.thruster_02_lat_fx.angles = level.thruster_02_lat.angles;
  level.thruster_02_lat_fx linkto(level.thruster_02_lat);
  level.thruster_03_lat_fx = common_scripts\utility::spawn_tag_origin();
  level.thruster_03_lat_fx.origin = level.thruster_03_lat.origin;
  level.thruster_03_lat_fx.angles = level.thruster_03_lat.angles;
  level.thruster_03_lat_fx linkto(level.thruster_03_lat);
  level.thruster_04_lat_fx = common_scripts\utility::spawn_tag_origin();
  level.thruster_04_lat_fx.origin = level.thruster_04_lat.origin;
  level.thruster_04_lat_fx.angles = level.thruster_04_lat.angles;
  level.thruster_04_lat_fx linkto(level.thruster_04_lat);
  common_scripts\utility::flag_wait("satellite_end_anim_started");
  level.thruster_01 delete();
  level.thruster_02 delete();
  level.thruster_03 delete();
  level.thruster_04 delete();
  level.thruster_01_lat_fx delete();
  level.thruster_02_lat_fx delete();
  level.thruster_03_lat_fx delete();
  level.thruster_04_lat_fx delete();
}

fx_burnup() {
  wait 10;
  level thread fx_burnup_sat();
  wait 5;
  common_scripts\utility::flag_set("fx_start_burnup");
  maps\_utility::vision_set_fog_changes("odin_burnup", 8);
  level.ally thread fx_burnup_kyra();
  level.player thread fx_burnup_player();
}

fx_burnup_kyra() {
  self endon("death");
  playFXOnTag(level._effect["odin_burnup_kyra_trail_runner"], self, "j_spinelower");
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["odin_burnup_player_trail_runner"], self, "j_wrist_le");
  playFXOnTag(level._effect["odin_burnup_player_trail_runner"], self, "j_wrist_ri");
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["odin_burnup_player_trail_runner"], self, "j_ankle_le");
  playFXOnTag(level._effect["odin_burnup_player_trail_runner"], self, "j_ankle_ri");
  common_scripts\utility::flag_wait("start_transition_to_youngblood");
  self endon("death");
  wait 2;

  if(!isDefined(self)) {
    return;
  }
  killfxontag(level._effect["odin_burnup_kyra_trail_runner"], self, "j_spinelower");
  killfxontag(level._effect["odin_burnup_player_trail_runner"], self, "j_wrist_le");
  killfxontag(level._effect["odin_burnup_player_trail_runner"], self, "j_wrist_ri");
  common_scripts\utility::waitframe();

  if(!isDefined(self)) {
    return;
  }
  killfxontag(level._effect["odin_burnup_player_trail_runner"], self, "j_ankle_le");
  killfxontag(level._effect["odin_burnup_player_trail_runner"], self, "j_ankle_ri");
}

fx_burnup_player() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linktoplayerview(self, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  playFXOnTag(level._effect["odin_burnup_scrnfx"], var_0, "tag_origin");
  common_scripts\utility::flag_wait("start_transition_to_youngblood");
  wait 1.9;
  killfxontag(level._effect["odin_burnup_scrnfx"], var_0, "tag_origin");
  common_scripts\utility::waitframe();
  var_0 delete();
}

fx_burnup_sat() {
  var_0 = [];
  var_0[var_0.size] = getent("odin_sat_section_04_pod_doorL_01", "script_noteworthy");
  var_0[var_0.size] = getent("odin_sat_section_04_pod_doorL_02", "script_noteworthy");
  var_0[var_0.size] = getent("odin_sat_section_04_pod_doorL_03", "script_noteworthy");
  var_0[var_0.size] = getent("odin_sat_section_04_pod_doorL_04", "script_noteworthy");
  var_0[var_0.size] = getent("odin_sat_section_04_pod_doorR_01", "script_noteworthy");
  var_0[var_0.size] = getent("odin_sat_section_04_pod_doorR_02", "script_noteworthy");
  var_0[var_0.size] = getent("odin_sat_section_04_pod_doorR_03", "script_noteworthy");
  var_0[var_0.size] = getent("odin_sat_section_04_pod_doorR_04", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(maps\_utility::hastag(var_2.model, "tag_fx_tip")) {
      playFXOnTag(level._effect["odin_burnup_sat_door_trail_runner"], var_2, "tag_fx_tip");
    }

    wait(randomfloatrange(0.1, 0.5));
  }

  var_4 = getEntArray("fx_sat_burnup_trail", "script_noteworthy");
  var_5 = [];

  foreach(var_2 in var_4) {
    var_7 = var_2 common_scripts\utility::spawn_tag_origin();
    var_7 linkto(var_2);
    playFXOnTag(level._effect["odin_burnup_sat_trail_runner"], var_7, "tag_origin");
    var_5[var_5.size] = var_7;
    wait(randomfloatrange(0.1, 0.5));
  }

  common_scripts\utility::flag_wait("start_transition_to_youngblood");
  wait 1.9;

  foreach(var_2 in var_0) {
    if(maps\_utility::hastag(var_2.model, "tag_fx_tip")) {
      killfxontag(level._effect["odin_burnup_sat_door_trail_runner"], var_2, "tag_fx_tip");
    }
  }

  foreach(var_2 in var_5) {
  var_2 delete();
  }

  common_scripts\utility::flag_set("clear_for_sat_clean");
}

fx_sat_thrusters_damage() {
  if(!isDefined(level.thruster_01_fx)) {
    level.thruster_01 = getent("sat_thruster_01", "script_noteworthy");
    level.thruster_02 = getent("sat_thruster_02", "script_noteworthy");
    level.thruster_03 = getent("sat_thruster_03", "script_noteworthy");
    level.thruster_04 = getent("sat_thruster_04", "script_noteworthy");
    level.thruster_01_fx = common_scripts\utility::spawn_tag_origin();
    level.thruster_01_fx.origin = level.thruster_01.origin;
    level.thruster_01_fx.angles = level.thruster_01.angles;
    level.thruster_01_fx linkto(level.thruster_01);
    level.thruster_02_fx = common_scripts\utility::spawn_tag_origin();
    level.thruster_02_fx.origin = level.thruster_02.origin;
    level.thruster_02_fx.angles = level.thruster_02.angles;
    level.thruster_02_fx linkto(level.thruster_02);
    level.thruster_03_fx = common_scripts\utility::spawn_tag_origin();
    level.thruster_03_fx.origin = level.thruster_03.origin;
    level.thruster_03_fx.angles = level.thruster_03.angles;
    level.thruster_03_fx linkto(level.thruster_03);
    level.thruster_04_fx = common_scripts\utility::spawn_tag_origin();
    level.thruster_04_fx.origin = level.thruster_04.origin;
    level.thruster_04_fx.angles = level.thruster_04.angles;
    level.thruster_04_fx linkto(level.thruster_04);
  }

  common_scripts\utility::flag_wait("first_finale_stage_done");
  stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_01_fx, "tag_origin");
  stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_02_fx, "tag_origin");
  stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
  stopFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["odin_sat_thrusters_ignite_sporadic"], level.thruster_01_fx, "tag_origin");
  thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_01_fx);
  thread maps\odin_audio::sfx_satellite_thruster_loop(level.thruster_01_fx);
  playFXOnTag(level._effect["odin_sat_thrusters_ignite_sporadic"], level.thruster_02_fx, "tag_origin");
  thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_02_fx);
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
  thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_03_fx);
  playFXOnTag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
  thread maps\odin_audio::sfx_satellite_thruster_initial_burst(level.thruster_04_fx);
  common_scripts\utility::flag_wait("satellite_end_anim_started");
  killfxontag(level._effect["odin_sat_thrusters_ignite_sporadic"], level.thruster_01_fx, "tag_origin");
  killfxontag(level._effect["odin_sat_thrusters_ignite_sporadic"], level.thruster_02_fx, "tag_origin");
  killfxontag(level._effect["odin_sat_thrusters_runner"], level.thruster_03_fx, "tag_origin");
  killfxontag(level._effect["odin_sat_thrusters_runner"], level.thruster_04_fx, "tag_origin");
  common_scripts\utility::flag_set("stop_sat_thrust_loop");
}

fx_spin_player_debris() {
  wait 2.1;
  level.playerview = spawn("script_model", (0, 0, 0));
  level.playerview setModel("tag_origin");
  level.playerview linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  playFXOnTag(level._effect["odin_debris_field_max_runner"], level.playerview, "tag_origin");
  wait 10.3;
  stopFXOnTag(level._effect["odin_debris_field_max_runner"], level.playerview, "tag_origin");
  playFXOnTag(level._effect["odin_debris_field_high_runner"], level.playerview, "tag_origin");
  wait 15;
  stopFXOnTag(level._effect["odin_debris_field_high_runner"], level.playerview, "tag_origin");
  playFXOnTag(level._effect["odin_debris_field_med_runner"], level.playerview, "tag_origin");
  wait 8;
  stopFXOnTag(level._effect["odin_debris_field_med_runner"], level.playerview, "tag_origin");
  playFXOnTag(level._effect["odin_debris_field_low_runner"], level.playerview, "tag_origin");
  level waittill("objective_destroy_sat");
  wait 5;
  stopFXOnTag(level._effect["odin_debris_field_max_runner"], level.playerview, "tag_origin");
  stopFXOnTag(level._effect["odin_debris_field_high_runner"], level.playerview, "tag_origin");
  stopFXOnTag(level._effect["odin_debris_field_med_runner"], level.playerview, "tag_origin");
  stopFXOnTag(level._effect["odin_debris_field_low_runner"], level.playerview, "tag_origin");
  level.playerview delete();
}

fx_sat_rcs_damage(var_0) {
  switch (var_0) {
    case 1:
      var_1 = getent("fx_sat_rcs_damage_1", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_leak_zerog_small"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 1, 0);
      thread maps\odin_audio::sfx_set_ending_flag();
      break;
    case 2:
      var_1 = getent("fx_sat_rcs_damage_2", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 2, 0);
      break;
    case 3:
      fx_sat_rcs_damage_kill();
      var_1 = getent("fx_sat_rcs_damage_1", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 3, 0);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 5, 5);
      var_1 = getent("fx_sat_rcs_damage_2", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      var_1 = getent("fx_sat_rcs_damage_3", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 4, 0.1);
      var_1 = getent("ally_shooting_target", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["zg_electrical_sparks_runner_40"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      break;
    case 4:
      var_1 = getent("fx_sat_rcs_damage_4", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      var_1 = getent("fx_sat_rcs_damage_5", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["fuel_fire_zerog_small"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 4, 0.1);
      var_1 = getent("ally_shooting_target", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["odin_fire_flare_runner"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      break;
    case 5:
      var_1 = getent("fx_sat_rcs_damage_6", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["odin_sat_rcs_fire_puff"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 5, 0);
      var_1 = getent("fx_sat_rcs_damage_7", "script_noteworthy");
      var_2 = var_1.origin;
      var_3 = anglesToForward(var_1.angles);
      var_4 = anglestoup(var_1.angles);
      level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size] = spawnfx(level._effect["odin_sat_rcs_fire_puff"], var_2, var_3, var_4);
      triggerfx(level.fx_sat_rcs_damage[level.fx_sat_rcs_damage.size - 1]);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 4, 0.5);
      thread maps\odin_audio::sfx_rcs_destr(var_1, 5, 2.1);
      wait 3;
      level notify("thrusters_fully_damaged");
      break;
    default:
  }
}

fx_sat_rcs_damage_kill() {
  foreach(var_1 in level.fx_sat_rcs_damage) {
  var_1 delete();
  }

  level.fx_sat_rcs_damage = [];
}

fx_spin_solar_panel_collision_01(var_0) {
  playFXOnTag(level._effect["odin_spin_solar_flash"], var_0, "panel_04");
  playFXOnTag(level._effect["odin_spin_solar_flash"], var_0, "panel_06");

  if(maps\_utility::is_gen4()) {
    common_scripts\utility::waitframe();
    playFXOnTag(level._effect["odin_spin_solar_runner"], var_0, "panel_04");
    playFXOnTag(level._effect["odin_spin_solar_runner"], var_0, "panel_06");
    playFXOnTag(level._effect["odin_spin_solar_runner"], var_0, "panel_07");
  }
}

fx_spin_solar_panel_collision_02(var_0) {
  playFXOnTag(level._effect["odin_spin_solar_flash"], var_0, "panel_03");
  playFXOnTag(level._effect["odin_spin_solar_player_debris"], level.playerview, "tag_origin");
}

fx_solar_panel_collision_kyra(var_0) {}

fx_solar_panel_collision_player(var_0) {}

fx_shuttle_dock() {
  common_scripts\utility::exploder("shuttle_dock");
}

fx_sat_explosion(var_0) {
  var_1 = getent("fx_sat_rcs_explosion", "script_noteworthy");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_2 linkto(var_0);
  playFXOnTag(level._effect["odin_sat_exp_rcs_fire_runner"], var_2, "tag_origin");
  common_scripts\utility::flag_wait("start_transition_to_youngblood");
  wait 1.9;
  killfxontag(level._effect["odin_sat_exp_rcs_fire_runner"], var_2, "tag_origin");
  var_2 delete();
}

fx_rotate_lights_setup() {
  common_scripts\utility::array_thread(getEntArray("fx_amber_light_pitch", "script_noteworthy"), ::fx_rotate_lights, "amber", "pitch");
  common_scripts\utility::array_thread(getEntArray("fx_amber_light_yaw", "script_noteworthy"), ::fx_rotate_lights, "amber", "yaw");
  common_scripts\utility::array_thread(getEntArray("fx_red_light_pitch", "script_noteworthy"), ::fx_rotate_lights, "red", "pitch");
  common_scripts\utility::array_thread(getEntArray("fx_red_light_pitch_2", "script_noteworthy"), ::fx_rotate_lights, "red", "pitch_2");
  common_scripts\utility::array_thread(getEntArray("fx_red_light_yaw", "script_noteworthy"), ::fx_rotate_lights, "red", "yaw");
}

fx_rotate_lights(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self.origin + 2.5 * anglestoup(self.angles);
  var_2.angles = self.angles;
  var_2 linkto(self);

  switch (var_0) {
    case "amber":
      playFXOnTag(level._effect["amber_light_45_flare_nolight"], var_2, "tag_origin");
      break;
    case "red":
      playFXOnTag(level._effect["red_light_45_flare_nolight"], var_2, "tag_origin");
      break;
  }

  switch (var_1) {
    case "pitch":
      thread rotateme(-360, "pitch", 1);
      break;
    case "pitch_2":
      thread rotateme(360, "pitch", 1);
      break;
    case "yaw":
      thread rotateme(-360, "yaw", 1);
      break;
  }

  self waittill("start_transition_to_youngblood");
  var_2 delete();
}

fx_space_glass() {
  level.space_screen = spawn("script_model", (0, 0, 0));
  level.space_screen setModel("tag_origin");
  level.space_screen linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  playFXOnTag(common_scripts\utility::getfx("vfx_scrnfx_space_glass"), level.space_screen, "tag_origin");
  common_scripts\utility::flag_wait("invasion_clear");
  killfxontag(common_scripts\utility::getfx("vfx_scrnfx_space_glass"), level.space_screen, "tag_origin");
  level.space_screen delete();
}

fx_setup_sat_lights() {
  var_0 = getEntArray("fx_sat_antenna_light", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = var_2 common_scripts\utility::spawn_tag_origin();
    var_3 linkto(var_2);
    playFXOnTag(level._effect["odin_sat_red_light"], var_3, "tag_origin");
  }
}

fx_sat_doors_open(var_0) {
  foreach(var_2 in var_0) {
  playFXOnTag(level._effect["odin_sat_red_light_blinker_runner"], var_2, "tag_fx_base_light");
  }

  wait 18;

  foreach(var_2 in var_0) {
  stopFXOnTag(level._effect["odin_sat_red_light_blinker_runner"], var_2, "tag_fx_base_light");
  }
}

fx_sat_doors_close(var_0) {
  foreach(var_2 in var_0) {
  playFXOnTag(level._effect["odin_sat_red_light_blinker_runner"], var_2, "tag_fx_base_light");
  }

  wait 20;

  foreach(var_2 in var_0) {
  stopFXOnTag(level._effect["odin_sat_red_light_blinker_runner"], var_2, "tag_fx_base_light");
  }
}

airlock_glass_fog() {
  wait 2.0;
  level.fog_screen = spawn("script_model", (0, 0, 0));
  level.fog_screen setModel("tag_origin");
  level.fog_screen linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  playFXOnTag(common_scripts\utility::getfx("vfx_scrnfx_space_glass_fog"), level.fog_screen, "tag_origin");
}

fx_spin_create_rog_plumes() {
  var_0 = maps\odin_util::earth_get_script_mover().earth_model;

  for(var_1 = 1; var_1 < 4; var_1++) {
    var_2 = "tag_fx_impact_" + var_1;
    playFXOnTag(level._effect["odin_rog_plume_0" + var_1], var_0, var_2);
  }

  common_scripts\utility::flag_wait("start_transition_to_youngblood");

  for(var_1 = 1; var_1 < 4; var_1++) {
    var_2 = "tag_fx_impact_" + var_1;
    killfxontag(level._effect["odin_rog_plume_0" + var_1], var_0, var_2);
  }
}