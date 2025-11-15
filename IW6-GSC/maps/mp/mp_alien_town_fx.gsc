/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_town_fx.gsc
****************************************/

main() {
  level._effect["pipe_sludge_far_lrg_splashes"] = loadfx("vfx/moments/alien/pipe_sludge_far_lrg_splashes");
  level._effect["pipe_sludge_far_lrg"] = loadfx("vfx/moments/alien/pipe_sludge_far_lrg");
  level._effect["fog_fall_mp_crater"] = loadfx("fx/weather/fog_fall_mp_crater");
  level._effect["vfx_alien_car_fire"] = loadfx("vfx/ambient/fire/vfx_alien_car_fire");
  level._effect["barrel_fire"] = loadfx("fx/fire/firelp_barrel_pm_cheap");
  level._effect["embers_burst_runner_cheap"] = loadfx("vfx/moments/mp_warhawk/embers_burst_runner_cheap");
  level._effect["ground_lodge_mist"] = loadfx("fx/weather/ground_fog_mp_alien");
  level._effect["ground_directional_mist"] = loadfx("fx/weather/ground_fog_mp_alien_directional");
  level._effect["light_insects"] = loadfx("fx/misc/insects_light_complex_sparse");
  level._effect["insects_ground"] = loadfx("fx/misc/insects_firefly_a");
  level._effect["lightning_storm"] = loadfx("fx/weather/lightning_mp_alien");
  level._effect["dust_falling"] = loadfx("fx/misc/falling_dust_small_runner_mp");
  level._effect["drip"] = loadfx("fx/misc/drips_slow_10x10");
  level._effect["leaves_falling_100"] = loadfx("fx/misc/leaves_fall_gentlewind_green_100_mp");
  level._effect["vfx_alien_mist_crater_idle"] = loadfx("vfx/gameplay/alien/vfx_alien_mist_crater_idle");
  level._effect["vfx/moments/alien/nuke_fail_screen_flash"] = loadfx("vfx/moments/alien/nuke_fail_screen_flash");
  thread fx_add_crater_plume();
}

fx_add_crater_plume() {
  wait 1;
  var_0 = (-9910, 6857, -2825);
  level.fx_crater_plume = spawnfx(level._effect["vfx_alien_mist_crater_idle"], var_0, (0, 0, 1), (1, 0, 0));
  triggerfx(level.fx_crater_plume, -15);
}