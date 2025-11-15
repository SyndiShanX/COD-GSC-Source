/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\launchfacility_b_fx.gsc
****************************************/

main() {
  level._effect["player_death_explosion"] = loadfx("fx\explosions\player_death_explosion");
  level._effect["hallway_steam_flood"] = loadfx("fx\smoke\hallway_steam_flood");
  level._effect["hallway_steam_loop"] = loadfx("fx\smoke\hallway_steam_loop");
  level._effect["steam_jet_med"] = loadfx("fx\smoke\h1_steam_jet_med");
  level._effect["steam_jet_med_loop"] = loadfx("fx\smoke\h1_steam_jet_med_loop");
  level._effect["steam_jet_med_loop_rand"] = loadfx("fx\smoke\h1_steam_jet_med_loop_random");
  level._effect["glow_stick_glow_pile"] = loadfx("fx\misc\glow_stick_glow_pile");
  level._effect["launchtube_fire"] = loadfx("fx\fire\launchtube_fire");
  level._effect["launchtube_smokeloop"] = loadfx("fx\smoke\launchtube_smokeloop");
  level._effect["launchtube_fire_light"] = loadfx("fx\misc\launchtube_fire_light");
  level._effect["fog_bog_a"] = loadfx("fx\weather\fog_launch_b");
  level._effect["fog_launchb_red"] = loadfx("fx\weather\fog_launchb_red");
  level._effect["shower_wall_large"] = loadfx("fx\distortion\shower_wall_large");
  level._effect["shower_spray"] = loadfx("fx\misc\shower_spray");
  level._effect["shower_steam"] = loadfx("fx\misc\shower_steam");
  level._effect["rain_noise"] = loadfx("fx\weather\rain_noise");
  level._effect["rain_noise_ud"] = loadfx("fx\weather\rain_noise_ud");
  level._effect["light_glow_emergency_mist"] = loadfx("fx\misc\light_glow_emergency_mist");
  level._effect["fire_alarm_strobe"] = loadfx("vfx\lights\light_fire_alarm_strobe_mwr");
  level._effect["emergency_light_strobe"] = loadfx("vfx\map\fusion\fus_light_red_strobe_mwr");
  level._effect["steam_column_rising_lachfac_b"] = loadfx("vfx\steam\steam_column_rising_lachfac_b");
  level._effect["steam_launch_b"] = loadfx("vfx\steam\steam_col_launch_b");
  level._effect["ambient_particles_bright_vent"] = loadfx("vfx\dust\ambient_particles_bright_vent");
  level._effect["water_drip"] = loadfx("vfx\water\falling_drip_ceil_launch_b");
  level._effect["water_trickle"] = loadfx("vfx\water\falling_pipe_water_trickle_straight_continue");
  level._effect["splash_up"] = loadfx("fx\water\splash_launch_b");
  level._effect["flare_sm"] = loadfx("vfx\lensflare\launch_b_flare_sm");
  level._effect["snow_tube"] = loadfx("fx\snow\snow_launch_b_tube");
  level._effect["mote_cone"] = loadfx("fx\dust\launch_b_mote_cone");
  level._effect["flies"] = loadfx("vfx\map\mp_clowntown\sewage_flies_launch_b");
  level._effect["fire_wreckage_ground"] = loadfx("vfx\fire\kitchen_fire_launch_b");
  level._effect["spark_spit"] = loadfx("vfx\sparks\launch_b_spark_spit");
  level._effect["fog_oriented_edge_fade"] = loadfx("vfx\fog\fog_oriented_edge_fade_launch_b");
  level._effect["light_beams"] = loadfx("fx\smoke\light_beam_launch_b");
  maps\_global_fx::set_custom_global_fx("light_red_pulse_spritelight_origin", "vfx\map\betrayal\btr_emergency_nolight_pulse_spritelight");
  common_scripts\_pipes::override_pipe_fx("steam", "fx\smoke\h1_steam_jet_med");
  common_scripts\_pipes::override_pipe_fx("impact", "vfx\weaponimpact\small_metalhit_1");
  common_scripts\_pipes::override_pipe_fx("water", "fx\water\launch_b_pipe_spray");
  level.c4_explosion_fx_override = loadfx("vfx\explosion\explosion_wall_breach_add");
  maps\createfx\launchfacility_b_fx::main();
  maps\createfx\launchfacility_b_sound::main();
}