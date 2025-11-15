/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\deer_hunt_fx.gsc
*****************************************************/

main() {
  level._effect["vfx_sunflare_dart"] = loadfx("vfx/ambient/atmospheric/vfx_sunflare_dart");
  level._effect["vfx_curtain_tear_light_sm"] = loadfx("vfx/moments/deer_hunt/vfx_curtain_tear_light_sm");
  level._effect["vfx_curtain_tear_light"] = loadfx("vfx/moments/deer_hunt/vfx_curtain_tear_light");
  level._effect["vfx_hand_dust"] = loadfx("vfx/moments/deer_hunt/vfx_hand_dust");
  level._effect["vfx_atmos_bokeh_deer"] = loadfx("vfx/moments/deer_hunt/vfx_atmos_bokeh_deer");
  level._effect["vfx_deer_room_dust_fly"] = loadfx("vfx/moments/deer_hunt/vfx_deer_room_dust_fly");
  level._effect["vfx_deer_room_dust_still"] = loadfx("vfx/moments/deer_hunt/vfx_deer_room_dust_still");
  level._effect["vfx_room_dust_shadow"] = loadfx("vfx/moments/deer_hunt/vfx_room_dust_shadow");
  level._effect["vfx_godray_curtain_stab"] = loadfx("vfx/moments/deer_hunt/vfx_godray_curtain_stab");
  level._effect["vfx_godray_curtain_cut"] = loadfx("vfx/moments/deer_hunt/vfx_godray_curtain_cut");
  level._effect["vfx_fire_car_small"] = loadfx("vfx/ambient/fire/fuel/vfx_fire_car_small");
  level._effect["vfx_debris_fire"] = loadfx("vfx/ambient/fire/vfx_debris_fire");
  level._effect["vfx_falling_dust_runner"] = loadfx("vfx/moments/deer_hunt/vfx_falling_dust_runner");
  level._effect["vfx_falling_dust_child"] = loadfx("vfx/moments/deer_hunt/vfx_falling_dust_child");
  level._effect["vfx_cliff_dust_shake"] = loadfx("vfx/moments/deer_hunt/vfx_cliff_dust_shake");
  level._effect["vfx_pipe_water_runoff"] = loadfx("vfx/moments/deer_hunt/vfx_pipe_water_runoff");

  if(!getdvarint("r_reflectionProbeGenerate")) {
    maps\createfx\deer_hunt_fx::main();
    maps\createfx\deer_hunt_sound::main();
  }

  level_fx();
}

level_fx() {
  level._effect["vfx_atmos_bokeh_deer_hunt"] = loadfx("vfx/ambient/atmospheric/vfx_atmos_bokeh_jungle");
  level._effect["siren_red"] = loadfx("fx/lights/siren_light_red_static");
  level._effect["wall_kick_impact_deer_hunt"] = loadfx("vfx/_requests/deer_hunt/wall_kick_impact_deer_hunt");
  level._effect["green_smoke"] = loadfx("fx/smoke/signal_smoke_green");
  level._effect["vfx_ground_mist_dh"] = loadfx("vfx/moments/deer_hunt/vfx_ground_mist_dh");
  level._effect["vfx_hanging_particulates"] = loadfx("vfx/moments/deer_hunt/vfx_hanging_particulates");
  level._effect["vfx_godray_anim"] = loadfx("vfx/moments/nml/vfx_godray_anim");
  level._effect["vfx_mist_slow_main_dh"] = loadfx("vfx/moments/deer_hunt/vfx_mist_slow_main_dh");
  level._effect["godray_forest_thin"] = loadfx("fx/lights/godray_forest_thin");
  level._effect["vfx_godray_deer_hunt_sm"] = loadfx("vfx/ambient/lights/vfx_godray_deer_hunt_sm");
  level._effect["vfx_deerh_leaves_falling"] = loadfx("vfx/ambient/atmospheric/vfx_deerh_leaves_falling");
  level._effect["vfx_deer_hunt_insects"] = loadfx("vfx/ambient/animals/vfx_deer_hunt_insects");
  level._effect["vfx_theater_ground_mist_dh"] = loadfx("vfx/moments/deer_hunt/vfx_theater_ground_mist_dh");
  level._effect["vfx_deerh_leaves_fall_dome"] = loadfx("vfx/ambient/atmospheric/vfx_deerh_leaves_fall_dome");
  level._effect["vfx_lens_flare_dh"] = loadfx("vfx/ambient/lights/vfx_lens_flare_dh");
  level._effect["vfx_water_runoff"] = loadfx("vfx/moments/deer_hunt/vfx_water_runoff");
  level._effect["vfx_water_runoff_splash"] = loadfx("vfx/moments/deer_hunt/vfx_water_runoff_splash");
  level._effect["vfx_cliff_dust_runner"] = loadfx("vfx/moments/deer_hunt/vfx_cliff_dust_runner");
  level._effect["vfx_cliff_dust_runner"] = loadfx("vfx/moments/deer_hunt/vfx_cliff_dust_runner");
  level._effect["vfx_cliff_dust_child"] = loadfx("vfx/moments/deer_hunt/vfx_cliff_dust_child");
  level._effect["vfx_birds_flock_large_takeoff"] = loadfx("vfx/ambient/animals/vfx_birds_flock_large_takeoff_2");
  level._effect["vfx_birds_flock_large_15sec"] = loadfx("vfx/ambient/animals/vfx_birds_flock_large_15sec");
  level._effect["chopper_flare"] = loadfx("fx/_requests/apache/apache_flare_ai");
  level._effect["chopper_flare_explosion"] = loadfx("fx/_requests/apache/apache_trophy_explosion_ai");
  level._effect["chopper_damage_smoke"] = loadfx("fx/fire/fire_smoke_trail_l_emitter");
  level._effect["chopper_damage_smoke2"] = loadfx("fx/smoke/smoke_trail_black_heli");
  level._effect["tank_smoke"] = loadfx("fx/fire/fire_smoke_trail_L_emitter");
  level._effect["tank_smoke2"] = loadfx("fx/fire/fire_smoke_trail_l");
}