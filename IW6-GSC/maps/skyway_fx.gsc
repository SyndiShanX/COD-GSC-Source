/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_fx.gsc
*****************************************************/

main() {
  if(!getdvarint("r_reflectionProbeGenerate")) {
    maps\createfx\skyway_fx::main();
    maps\createfx\skyway_sound::main();
  }

  common_scripts\utility::flag_init("flag_fx_screen_bokehdots_grit01");
  level thread fx_screen_bokehdots_grit01();
  level._effect["flesh_hit"] = loadfx("fx/impacts/flesh_hit");
  level._effect["sniper_glint"] = loadfx("fx/misc/scope_glint");
  level._effect["air_flak"] = loadfx("vfx/moments/skyway/vfx_aa_explosion_super_en");
  level._effect["air_burst_low"] = loadfx("vfx/moments/skyway/explosion_missile_strike");
  level._effect["jet_contrail"] = loadfx("vfx/moments/skyway/vfx_sw_jet_contrail_fast_01");
  level._effect["pip_static"] = loadfx("vfx/moments/skyway/tv_static_scroll_lines");
  level._effect["bloodsplatter_wall"] = loadfx("vfx/moments/skyway/vfx_blood_spray_splatter_drips");
  level._effect["bloodsplatter_hit"] = loadfx("fx/impacts/blood_dashboard_splatter");
  level._effect["vfx_airburst_runner_01"] = loadfx("vfx/moments/skyway/vfx_airburst_runner_01");
  level._effect["vfx_aa_explosion_super_en"] = loadfx("vfx/moments/skyway/vfx_aa_explosion_super_en");
  level._effect["vfx_airburst_runner_01_attach"] = loadfx("vfx/moments/skyway/vfx_airburst_runner_01_attach");
  level._effect["vfx_contrail_skyway_01_emit"] = loadfx("vfx/moments/skyway/vfx_contrail_skyway_01_emit");
  level._effect["vfx_perif_contrail_01"] = loadfx("vfx/moments/skyway/vfx_perif_contrail_01");
  level._effect["antiair_runner_flak_day_mp"] = loadfx("fx/misc/antiair_runner_flak_day_mp");
  level._effect["antiair_single_tracer01_cloudy_loop"] = loadfx("vfx/moments/satfarm/antiair_single_tracer01_cloudy_loop");
  level._effect["perif_smk_war_vista"] = loadfx("vfx/ambient/skybox/vfx_perif_smk_war_vista_b4m_light");
  level._effect["perif_smk_plume_huge_greyblue"] = loadfx("vfx/ambient/skybox/vfx_perif_smk_plume_huge_slow_b4");
  level._effect["vfx_hanging_smoke_huge_01"] = loadfx("vfx/moments/skyway/vfx_hanging_smoke_huge_01");
  level._effect["sathit_sat_explode_L"] = loadfx("vfx/moments/skyway/explosion_missile_strike");
  level._effect["sathit_sat_explode_R"] = loadfx("vfx/moments/skyway/explosion_missile_strike_large");
  level._effect["sathit_missile_trail"] = loadfx("vfx/moments/skyway/vfx_missile_child_smoketrail_skyway_01");
  level._effect["player_flash"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_fiery_bokeh_flash_01");
  level._effect["rog_maintrail_01"] = loadfx("vfx/moments/skyway/vfx_rog_maintrail_skyway_01_runner");
  level._effect["vfx_rog_impact_temp_01"] = loadfx("vfx/moments/skyway/vfx_rog_impact_intro_01");
  level._effect["vfx_rog_impact_canyon_temp_01"] = loadfx("vfx/moments/skyway/vfx_rog_impact_canyon_temp_01");
  level._effect["sat_dish_hit_01"] = loadfx("vfx/moments/skyway/vfx_sat_dish_hit_01");
  level._effect["rooftops_steam"] = loadfx("fx/maps/skyway/outside_steam");
  level._effect["roofhit_helo_explode"] = loadfx("vfx/moments/skyway/explosion_large_moving");
  level._effect["roofhit_helo_smoke"] = loadfx("vfx/moments/skyway/firey_smoke_moving");
  level._effect["roofhit_train_fire"] = loadfx("vfx/moments/skyway/firey_thick_smoke_moving");
  level._effect["roofhit_wheel_sparks"] = loadfx("vfx/moments/skyway/sw_sparks_wheel_emit_big");
  level._effect["roofhit_wheel_break"] = loadfx("vfx/moments/skyway/sw_sparks_wheel_break");
  level._effect["roofhit_wheel_sparks_small"] = loadfx("vfx/moments/skyway/sw_sparks_wheel_emit_small");
  level._effect["rooftops_wall_drag"] = loadfx("vfx/moments/skyway/wall_drag_debris_moving");
  level._effect["rt_helo_engine_damage"] = loadfx("vfx/moments/skyway/sw_helo_engine_damage");
  level._effect["dust_cloud_large_01"] = loadfx("vfx/moments/skyway/vfx_amb_dust_cloud_large_01");
  level._effect["rt_helo_engine_death"] = loadfx("vfx/moments/skyway/sw_helo_engine_death");
  level._effect["rt_helo_tail_damage"] = loadfx("vfx/moments/skyway/sw_helo_tail_damage");
  level._effect["rt_helo_tail_death"] = loadfx("vfx/moments/skyway/sw_helo_tail_death");
  level._effect["rt_helo_belly_damage"] = loadfx("vfx/moments/skyway/sw_helo_belly_damage");
  level._effect["rt_helo_belly_death"] = loadfx("vfx/moments/skyway/sw_helo_belly_death");
  level._effect["rt_helo_belly_death2"] = loadfx("vfx/moments/skyway/sw_helo_belly_death2");
  level._effect["rt_helo_glass_front"] = loadfx("vfx/moments/skyway/sw_helo_glass_front");
  level._effect["rt_helo_glass_front_b"] = loadfx("vfx/moments/skyway/sw_helo_glass_front");
  level._effect["rt_helo_glass_back"] = loadfx("vfx/moments/skyway/sw_helo_glass_front");
  level._effect["rt_helo_glass_mid_1"] = loadfx("vfx/moments/skyway/sw_helo_glass_front");
  level._effect["rt_helo_glass_mid_2"] = loadfx("vfx/moments/skyway/sw_helo_glass_front");
  level._effect["rt_helo_blades_shred"] = loadfx("vfx/moments/skyway/sw_helo_blades_shred");
  level._effect["rt_helo_tail_fire_rotor"] = loadfx("vfx/moments/skyway/sw_helo_tail_fire_rotor");
  level._effect["rt_helo_tail_fire_break"] = loadfx("vfx/moments/skyway/sw_helo_tail_fire_break");
  level._effect["sw_helo_bullet_hit"] = loadfx("vfx/moments/skyway/sw_helo_bullet_hit");
  level._effect["traincar_taillight"] = loadfx("vfx/moments/skyway/vfx_glow_light_red_train_01");
  level._effect["blood_spatter"] = loadfx("vfx/moments/skyway/sw_breach_blood");
  level._effect["loco_breach_smoke_geotrail_rpg"] = loadfx("vfx/moments/skyway/sw_loco_rpg_tail_child");
  level._effect["loco_breach_rpg_wall_impact"] = loadfx("vfx/moments/skyway/sw_loco_rpg");
  level._effect["loco_breach_engine_explode"] = loadfx("vfx/moments/skyway/sw_loco_rpg");
  level._effect["loco_breach_rpg_muzzle"] = loadfx("vfx/moments/skyway/sw_loco_rpg_muzzle");
  level._effect["loco_enginelight"] = loadfx("vfx/moments/skyway/sw_loco_enginelight");
  level._effect["loco_light_controldoor"] = loadfx("vfx/moments/skyway/sw_loco_light_controldoor");
  level._effect["loco_light_exterior_mid"] = loadfx("vfx/moments/skyway/sw_loco_light_exterior_mid");
  level._effect["loco_light_controlroom"] = loadfx("vfx/moments/skyway/sw_loco_light_controlroom");
  level._effect["loco_breach_glass"] = loadfx("vfx/moments/skyway/sw_breach_glass");
  level._effect["loco_falling_glass"] = loadfx("vfx/moments/skyway/sw_falling_glass");
  level._effect["magnum_flash"] = loadfx("vfx/moments/skyway/magnum_flash");
  level._effect["playerview_dust_wind_01"] = loadfx("vfx/moments/skyway/vfx_playerview_dust_wind_01");
  level._effect["bridge_shockwave"] = loadfx("vfx/moments/skyway/sw_rog_bridge_shockwave");
  level._effect["bridge_shockwave_girders"] = loadfx("vfx/moments/skyway/sw_rog_bridge_shockwave_girders");
  level._effect["bridge_shockwave_oriented"] = loadfx("vfx/moments/skyway/sw_rog_bridge_shockwave_oriented_falling");
  level._effect["splash_huge"] = loadfx("vfx/moments/skyway/vfx_spalsh_bridgepiece_huge");
  level._effect["splash_small"] = loadfx("vfx/moments/skyway/vfx_spalsh_bridgepiece_small");
  level._effect["splash_med"] = loadfx("vfx/moments/skyway/vfx_spalsh_bridgepiece_med");
  level._effect["splash_large"] = loadfx("vfx/moments/skyway/vfx_spalsh_bridgepiece_large");
  level._effect["swim_drowning_tunnel"] = loadfx("vfx/moments/skyway/water_drowning_tunnel");
  level._effect["swim_light_door"] = loadfx("vfx/moments/skyway/sw_light_door_swimout");
  level._effect["swim_light_cockpit"] = loadfx("vfx/moments/skyway/sw_light_swim_cockpit");
  level._effect["swim_light_cockpit_spot"] = loadfx("vfx/moments/skyway/sw_light_swim_cockpit_spot");
  level._effect["swim_light_surface"] = loadfx("vfx/moments/skyway/sw_light_surface_swimout");
  level._effect["swim_light_door_godray_sm"] = loadfx("vfx/moments/skyway/sw_light_door_godray_sm");
  level._effect["swim_light_door_godray_md"] = loadfx("vfx/moments/skyway/sw_light_door_godray_md");
  level._effect["muzzle_flash"] = loadfx("fx/muzzleflashes/pistolflash_view");
  level._effect["wreck_spray"] = loadfx("vfx/moments/flood/flood_water_door_spray_small");
  level._effect["glass_crack_sequence_01"] = loadfx("vfx/moments/skyway/glass_crack_sequence_01_runner");
  level._effect["underwater_particulate_cloud_03"] = loadfx("vfx/moments/skyway/underwater_particulate_cloud_03");
  level._effect["underwater_particulate_cloud_02"] = loadfx("vfx/moments/skyway/underwater_particulate_cloud_02");
  level._effect["submerge_playerview_01"] = loadfx("vfx/moments/skyway/submerge_playerview_01");
  level._effect["window_break_watergush"] = loadfx("vfx/moments/skyway/window_break_watergush");
  level._effect["underwater_godray_01"] = loadfx("vfx/moments/skyway/underwater_godray_01");
  level._effect["underwater_particulate cloud_01"] = loadfx("vfx/moments/skyway/underwater_particulate_cloud_01");
  level._effect["bubble streamer_large_01"] = loadfx("vfx/moments/skyway/bubble_streamer_large_01");
  level._effect["player_view_bubbles"] = loadfx("vfx/moments/skyway/player_view_bubbles");
  level._effect["player_view_bubbles_choke"] = loadfx("vfx/moments/skyway/player_view_bubbles_choke");
  level._effect["underwater_loco_headlight"] = loadfx("vfx/moments/skyway/underwater_loco_headlight");
  level._effect["underwater_loco_redlight"] = loadfx("vfx/moments/skyway/underwater_loco_redlight");
  level._effect["underwater_loco_headlight_dust"] = loadfx("vfx/moments/skyway/underwater_loco_headlight_dust");
  level._effect["underwater_particulate_cloud_spot"] = loadfx("vfx/moments/skyway/underwater_particulate_cloud_spot");
  level._effect["blood_rorke"] = loadfx("vfx/moments/skyway/sw_rorke_blood");
  level._effect["bullet_shine"] = loadfx("vfx/moments/skyway/vfx_bullet_shine");
  level._effect["bullet_shine_lesser"] = loadfx("vfx/moments/skyway/vfx_bullet_shine_lesser");
  level._effect["vfx_neck_slash"] = loadfx("vfx/moments/skyway/vfx_neck_slash");
  level._effect["player_view_bubble_swarm_01"] = loadfx("vfx/moments/skyway/player_view_bubble_swarm_01");
  level._effect["underwater_blood_cloud_01"] = loadfx("vfx/moments/skyway/underwater_blood_cloud_01");
  level._effect["vfx_ash_falling_01"] = loadfx("vfx/moments/skyway/vfx_ash_falling_01");
  level._effect["end_beach_sun"] = loadfx("vfx/moments/skyway/vfx_sunflare_skyway_reveal_lens");
  level._effect["end_beach_sun2"] = loadfx("vfx/moments/skyway/vfx_sunflare_skyway_reveal");
  level._effect["end_beach_godray"] = loadfx("vfx/moments/skyway/end_beach_godray");
  level._effect["end_beach_birds"] = loadfx("vfx/moments/skyway/end_beach_birds");
  level._effect["antiair_single_long"] = loadfx("vfx/moments/skyway/antiair_runner_flak_long");
  level._effect["vfx_missle_shiplaunch_vert_01"] = loadfx("vfx/moments/skyway/vfx_missle_shiplaunch_vert_01");
  level._effect["rorke_bleed_out"] = loadfx("vfx/moments/skyway/rorke_chest_blood_drips");
  level._effect["rog_impact_end_01"] = loadfx("vfx/moments/skyway/vfx_rog_impact_end_01");
  level._effect["sea_spray_directional"] = loadfx("vfx/moments/skyway/vfx_sea_spray_directional");
  level._effect["sea_spray"] = loadfx("vfx/moments/skyway/vfx_scrnfx_sea_spray");
  level._effect["ash_storm"] = loadfx("vfx/moments/skyway/ash_storm");
  level._effect["vfx_perif_ship_maingun"] = loadfx("vfx/moments/skyway/vfx_perif_ship_maingun");
  level._effect["end_tunnel_vision"] = loadfx("vfx/moments/skyway/end_tunnel_vision");
  level._effect["pit_moonlight"] = loadfx("vfx/moments/skyway/sw_pit_fake_moonlight_spot");
  level._effect["pit_moon"] = loadfx("vfx/moments/skyway/sw_pit_moon");
  level._effect["pit_view_drops"] = loadfx("vfx/moments/skyway/sw_pit_moon");
  level._effect["pit_rain"] = loadfx("vfx/moments/skyway/sw_pit_rain");
  level._effect["pit_lightning"] = loadfx("vfx/moments/skyway/sw_pit_lightning");
  level._effect["pit_lightning_light"] = loadfx("vfx/moments/skyway/sw_pit_lightning_light");
  level._effect["pit_raindrops"] = loadfx("vfx/moments/skyway/sw_pit_raindrops");
  level._effect["pit_sun"] = loadfx("vfx/moments/skyway/vfx_sunflare_pit");
  level._effect["pit_flies"] = loadfx("vfx/moments/skyway/sw_pit_flies");
  level._effect["bokeh_splats_01"] = loadfx("vfx/gameplay/screen_effects/vfx_screen_bokeh_splats_add_02");
  level._effect["bokeh_fieryflash_01"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_fiery_bokeh_flash_01");
  level._effect["sunflare_01"] = loadfx("vfx/moments/skyway/vfx_sunflare_skyway_01");
  level._effect["flare_light_med_wwhite1"] = loadfx("vfx/moments/skyway/vfx_flare_light_med_wwhite1");
  level._effect["dust_cloud_canyon_huge_lit"] = loadfx("vfx/moments/skyway/vfx_dust_cloud_canyon_huge_lit");
  maps\_utility::setsaveddvar_cg_ng("fx_alphathreshold", 9, 2);
}

fx_init() {
  common_scripts\utility::flag_init("flag_fx_screen_bokehdots_grit01");
  level thread fx_screen_bokehdots_grit01();
}

fx_origin_link_with_train_angles(var_0, var_1, var_2, var_3) {
  var_0 endon("stop_link_train_angles");
  self.origin = var_0 gettagorigin(var_2);
  self linkto(var_0, var_2);
  self endon("death");

  if(isDefined(var_3)) {
    level endon(var_3);
  }

  for(;;) {
    self unlink();
    self.angles = var_1 gettagangles("j_mainroot");
    self linkto(var_0, var_2);
    wait(level.timestep);
  }
}

fx_origin_with_train_angles(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(isDefined(var_3)) {
    level endon(var_3);
  }

  for(;;) {
    self.angles = var_1 gettagangles("j_mainroot");
    self.origin = var_0 gettagorigin(var_2);
    wait(level.timestep);
  }
}

create_view_particle_source_locked() {
  if(!isDefined(level.view_particle_source_locked)) {
    level.view_particle_source_locked = spawn("script_model", (0, 0, 0));
    level.view_particle_source_locked setModel("tag_origin");
    level.view_particle_source_locked.origin = level.player.origin;
    level.view_particle_source_locked linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  }
}

fx_intro_amb() {
  common_scripts\utility::exploder("intro_amb");
  common_scripts\utility::exploder("intro_airbursts");
  wait 50.0;
  maps\_utility::stop_exploder("intro_amb");
  maps\_utility::stop_exploder("intro_airbursts");
  common_scripts\utility::exploder("canyon01_amb");
}

fx_like_dust_in_the_wind_01() {
  self endon("stop_wind");

  for(;;) {
    playFXOnTag(level._effect["playerview_dust_wind_01"], level.view_particle_source, "tag_origin");
    wait 0.5;
  }
}

fx_like_dust_in_the_wind_02() {
  self endon("stop_wind");

  for(;;) {
    playFXOnTag(level._effect["playerview_dust_wind_01"], level.view_particle_source, "tag_origin");
    wait 0.4;
  }
}

fx_like_dust_in_the_wind_03() {
  self endon("stop_wind");

  for(;;) {
    playFXOnTag(level._effect["playerview_dust_wind_01"], level.view_particle_source, "tag_origin");
    wait 0.3;
  }
}

fx_screen_bokehdots_grit01() {
  common_scripts\utility::flag_wait("flag_fx_screen_bokehdots_grit01");
  create_view_particle_source_locked();

  for(;;) {
    if(common_scripts\utility::flag("flag_fx_screen_bokehdots_grit01")) {
      playFXOnTag(common_scripts\utility::getfx("bokeh_splats_01"), level.view_particle_source_locked, "tag_origin");
    } else {
      stopFXOnTag(common_scripts\utility::getfx("bokeh_splats_01"), level.view_particle_source_locked, "tag_origin");
    }

    wait 0.3;
  }
}

fx_playerview_fieryflash_01() {
  create_view_particle_source_locked();
  wait 0.01;
  playFXOnTag(common_scripts\utility::getfx("bokeh_fieryflash_01"), level.view_particle_source_locked, "tag_origin");
}

fx_playerview_pit_raindrops() {
  create_view_particle_source_locked();
  wait 7.0;
  common_scripts\utility::exploder("pit_rain");
  wait 0.2;
  common_scripts\utility::exploder("pit_lightning");
  playFXOnTag(common_scripts\utility::getfx("pit_raindrops"), level.view_particle_source_locked, "tag_origin");
  level.player playrumbleonentity("grenade_rumble");
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_rog_ent, 0.5, 0.0, 0.05, 0.0, 5.0);
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 1.0, 0.0, 0.05, 0.0, 1.0);
  level waittill("notify_clean_pit");
  stopFXOnTag(common_scripts\utility::getfx("pit_raindrops"), level.view_particle_source_locked, "tag_origin");
  maps\_utility::stop_exploder("pit_rain");
}

fx_playerview_raindrops_01() {
  create_view_particle_source_locked();
  wait 0.01;
  playFXOnTag(common_scripts\utility::getfx("bokeh_fieryflash_01"), level.view_particle_source_locked, "tag_origin");
}

fx_create_sunflare_source() {
  common_scripts\utility::flag_wait("flag_hangar_door_open");

  if(!isDefined(level.sunflare)) {
    level.sunflare = spawn("script_model", (0, 0, 0));
    level.sunflare setModel("tag_origin");
    playFXOnTag(common_scripts\utility::getfx("sunflare_01"), level.sunflare, "tag_origin");
    var_0 = vectornormalize((-0.119599, 0.881644, 0.509885));

    while(common_scripts\utility::flag("flag_endbeach_start") == 0) {
      level.sunflare.origin = level.player.origin + var_0 * 100000;
      common_scripts\utility::waitframe();
    }

    stopFXOnTag(common_scripts\utility::getfx("sunflare_01"), level.sunflare, "tag_origin");
  }
}

fx_create_sunflare_beach() {
  common_scripts\utility::flag_wait("flag_endbeach_start");

  if(!isDefined(level.sunflare)) {
    level.sunflare = spawn("script_model", (0, 0, 0));
    level.sunflare setModel("tag_origin");
    playFXOnTag(common_scripts\utility::getfx("sunflare_01"), level.sunflare, "tag_origin");

    if(maps\_utility::is_gen4()) {
      var_0 = vectornormalize((0.0954011, 0.766644, 0.509885));

      for(;;) {
        level.sunflare.origin = level.player.origin + var_0 * 50000;
        common_scripts\utility::waitframe();
      }
    } else {
      var_0 = vectornormalize((0.0954011, 0.731644, 0.509885));

      for(;;) {
        level.sunflare.origin = level.player.origin + var_0 * 30000;
        common_scripts\utility::waitframe();
      }
    }

    stopFXOnTag(common_scripts\utility::getfx("sunflare_01"), level.sunflare, "tag_origin");
  }
}

fx_endbeach_sunflare() {
  wait 9;
  common_scripts\utility::exploder("here_comes_the_sun");
  common_scripts\utility::exploder("here_comes_the_sun2");
  wait 1.5;
  maps\_utility::vision_set_fog_changes("skyway_beach_clear", 16);
}

fx_endbeach_birds() {
  level waittill("notify_start_birds");
  common_scripts\utility::exploder("here_comes_the_birds");
}

fx_turnon_tunnel_lights_01() {
  common_scripts\utility::exploder("tunnel_lights_01");
  common_scripts\utility::exploder("dustysmoke_plume_03");
}

fx_dustysmoke_plume_03() {
  common_scripts\utility::exploder("dustysmoke_plume_03");
}

fx_turnon_rooftop_lights() {
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_rt0"].body, "tag_taillight_l");
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_rt0"].body, "tag_taillight_r");
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_rt1"].body, "tag_taillight_l");
  wait(level.timestep);
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_rt1"].body, "tag_taillight_r");
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_rt2"].body, "tag_taillight_l");
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_rt2"].body, "tag_taillight_r");
  wait(level.timestep);
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_rt3"].body, "tag_taillight_l");
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_rt3"].body, "tag_taillight_r");
}

fx_turnon_loco_exterior_lights() {
  wait 0.1;
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_loco"].body, "tag_loco_light_tail_l");
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_loco"].body, "tag_loco_light_tail_r");
  playFXOnTag(common_scripts\utility::getfx("loco_light_exterior_mid"), level._train.cars["train_loco"].body, "tag_loco_light_mid");
  level waittill("notify_loco_breach_door_explode");
  wait 0.1;
  stopFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_loco"].body, "tag_loco_light_tail_l");
  stopFXOnTag(common_scripts\utility::getfx("traincar_taillight"), level._train.cars["train_loco"].body, "tag_loco_light_tail_r");
  stopFXOnTag(common_scripts\utility::getfx("loco_light_exterior_mid"), level._train.cars["train_loco"].body, "tag_loco_light_mid");
}

fx_turnon_loco_interior_lights() {
  var_0 = getent("loco_breach_engine_1", "targetname");
  var_1 = getent("loco_breach_engine_4", "targetname");
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), var_0, "tag_light_r");
  playFXOnTag(common_scripts\utility::getfx("traincar_taillight"), var_1, "tag_light_l");
  playFXOnTag(common_scripts\utility::getfx("loco_enginelight"), var_1, "tag_light_illuminate");
  playFXOnTag(common_scripts\utility::getfx("loco_light_controldoor"), level._train.cars["train_loco"].body, "tag_light_controlroom");
  level waittill("notify_start_loco_control_lights");
  playFXOnTag(common_scripts\utility::getfx("loco_light_controlroom"), level._train.cars["train_loco"].body, "tag_light_controlroom_rorke");
}

fx_bridgefall(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_7 = common_scripts\utility::spawn_tag_origin();
  var_8 = common_scripts\utility::spawn_tag_origin();
  var_9 = common_scripts\utility::spawn_tag_origin();
  var_2 linkto(var_0, "tag_splash", (0, 0, 0), (0, 0, 0));
  var_3 linkto(var_0, "tag_splash", (0, 0, 0), (0, 0, 0));
  var_4 linkto(var_0, "tag_splash", (0, 0, 0), (0, 0, 0));
  var_5 linkto(var_0, "tag_splash", (0, 0, 0), (0, 0, 0));
  var_6 linkto(var_1, "tag_splash", (0, 0, 0), (0, 0, 0));
  var_7 linkto(var_1, "tag_splash", (0, 0, 0), (0, 0, 0));
  var_8 linkto(var_1, "tag_splash", (0, 0, 0), (0, 0, 0));
  var_9 linkto(var_1, "tag_splash", (0, 0, 0), (0, 0, 0));
  var_10 = [var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9];

  foreach(var_12 in var_10) {
    level waittill("notify_bridgepiece_splash");
    var_12 unlink();
    playFXOnTag(common_scripts\utility::getfx("splash_huge"), var_12, "tag_origin");
    wait(level.timestep);
  }

  level waittill("flag_loco_end");
  wait(level.timestep);

  foreach(var_12 in var_10) {
    var_12 delete();
  }
}

fx_bridgefall_small_splash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("splash_small"), var_0, "tag_origin");
}

fx_bridgefall_med_splash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("splash_med"), var_0, "tag_origin");
}

fx_bridgefall_large_splash(var_0) {
  playFXOnTag(common_scripts\utility::getfx("splash_large"), var_0, "tag_origin");
}

shockwave_dirt_hit(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader("fullscreen_dirt_bottom_b", 640, 480);
  var_3.splatter = 1;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.foreground = 0;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = 0;
  var_4 = 0;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  while(var_4 < var_1) {
    var_3.alpha = var_3.alpha + 0.05;
    var_4 = var_4 + 0.05;
    wait 0.05;
  }

  var_3.alpha = 1;
  wait(var_0);
  var_4 = 0;

  while(var_4 < var_2) {
    var_3.alpha = var_3.alpha - 0.05;
    var_4 = var_4 + 0.05;
    wait 0.05;
  }

  var_3.alpha = 0;
  var_3 destroy();
}

fx_quick_hit_blur() {
  level.player setblurforplayer(16, 0.01);
  wait 0.1;
  level.player setblurforplayer(0, 0.5);
}

fx_swim_bubbles() {
  create_view_particle_source_locked();
  wait 0.01;
  playFXOnTag(common_scripts\utility::getfx("player_view_bubbles"), level.view_particle_source_locked, "tag_origin");
  common_scripts\utility::flag_wait("flag_end_swim_end");
  killfxontag(common_scripts\utility::getfx("player_view_bubbles"), level.view_particle_source_locked, "tag_origin");
}

fx_sea_spray() {
  wait 5;
  common_scripts\utility::exploder("seaspray_02");
  thread fx_sea_spray_player_effect();
  wait 4;
  common_scripts\utility::exploder("seaspray_01");
  thread fx_sea_spray_player_effect();
  wait 7;
  common_scripts\utility::exploder("seaspray_03");
  thread fx_sea_spray_player_effect();
}

fx_sea_spray_player_effect() {
  wait 1.6;
  earthquake(0.28, 0.9, level.player.origin, 2000);
  level.player playrumbleonentity("damage_heavy");
  thread maps\skyway_util::player_rumble_bump(level.player_rumble_ent, 0.3, 0.0, 0.05, 0.0, 2.0);
}

fx_swim_door_light() {
  common_scripts\utility::exploder("swim_light_door");
  common_scripts\utility::exploder("swim_light_surface");
  common_scripts\utility::flag_wait("flag_end_swim_kill_door_fx");
  maps\_utility::stop_exploder("swim_light_door");
  common_scripts\utility::flag_wait("flag_endbeach_start");
  maps\_utility::stop_exploder("swim_light_surface");
}

fx_underwater_amb_01() {
  var_0 = getent("sea_floor_animated", "targetname");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate cloud_01"), var_0, "tag_fx_outside_F");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate cloud_01"), var_0, "tag_fx_outside_FL");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate cloud_01"), var_0, "tag_fx_outside_FR");
  wait(level.timestep);
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate cloud_01"), var_0, "tag_fx_outside_L");
  playFXOnTag(common_scripts\utility::getfx("underwater_particulate cloud_01"), var_0, "tag_fx_outside_R");
  thread fx_underwater_redlights();
  common_scripts\utility::exploder("underwater_loco_headlight");
  common_scripts\utility::exploder("end_underwater_amb_01");
  common_scripts\utility::flag_wait("flag_end_swim_end");
  maps\_utility::stop_exploder("underwater_loco_headlight");
  maps\_utility::stop_exploder("end_underwater_amb_01");
}

fx_underwater_redlights() {
  level endon("flag_end_swim_end");

  for(;;) {
    common_scripts\utility::exploder("underwater_loco_redlight");
    wait 2;
  }
}

fx_cabin_seafloor_impact() {}

fx_glass_cracks_01() {
  common_scripts\utility::exploder("glass_crack_sequence");
  level waittill("start_water_fx");
  maps\_utility::stop_exploder("glass_crack_sequence");
}

fx_player_submerge_01() {
  create_view_particle_source_locked();
  level waittill("start_water_fx");
  common_scripts\utility::exploder("glass_break_flood");
  wait 0.8;
  playFXOnTag(common_scripts\utility::getfx("submerge_playerview_01"), level.view_particle_source_locked, "tag_origin");
  wait 1;
  playFXOnTag(common_scripts\utility::getfx("player_view_bubble_swarm_01"), level.view_particle_source_locked, "tag_origin");
}

fx_player_submerge_01_endwreck() {
  create_view_particle_source_locked();
  playFXOnTag(common_scripts\utility::getfx("player_view_bubble_swarm_01"), level.view_particle_source_locked, "tag_origin");
}

fx_endswim_blood_cloud() {
  common_scripts\utility::exploder("underwater_blood");
}

fx_perif_fleet_mainguns() {
  level endon("notify_end_war");

  for(;;) {
    wait 5;
    common_scripts\utility::exploder("perif_ship_maingun_1");
    wait 3;
    common_scripts\utility::exploder("perif_ship_maingun_2");
    wait 1;
    common_scripts\utility::exploder("perif_ship_maingun_2");
    wait 1;
    common_scripts\utility::exploder("perif_ship_maingun_2");
    wait 2;
    common_scripts\utility::exploder("perif_ship_maingun_4");
    wait 3;
    common_scripts\utility::exploder("perif_ship_maingun_5");
    wait 1;
    common_scripts\utility::exploder("perif_ship_maingun_5");
    wait 1;
    common_scripts\utility::exploder("perif_ship_maingun_5");
    wait 2;
    common_scripts\utility::exploder("perif_ship_maingun_6");
  }
}

fx_hesh_neck_cut() {
  var_0 = level._allies[0];
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(var_0, "j_neck", (0, 0, 0), (0, 0, 0));
  wait 1;
  playFXOnTag(common_scripts\utility::getfx("vfx_neck_slash"), var_1, "tag_origin");
}