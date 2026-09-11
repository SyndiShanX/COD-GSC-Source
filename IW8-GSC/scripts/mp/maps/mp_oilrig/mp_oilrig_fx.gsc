/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_oilrig\mp_oilrig_fx.gsc
******************************************************/

function main() {
  level._effect["vfx_oil_fluorescent_lf_sm"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_fluorescent_lf_sm.vfx");
  level._effect["vfx_oil_dist_rig_light"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_dist_rig_light.vfx");
  level._effect["vfx_oil_cargo_ship"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_cargo_ship.vfx");
  level._effect["vfx_oil_oil_drips_line"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_oil_drips_line.vfx");
  level._effect["vfx_oil_drill_area_mist"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_drill_area_mist.vfx");
  level._effect["vfx_oil_cargo_ship_wake"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_cargo_ship_wake.vfx");
  level._effect["vfx_oil_nav_glow_green"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_nav_glow_green.vfx");
  level._effect["vfx_oil_nav_glow_red"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_nav_glow_red.vfx");
  level._effect["vfx_oil_nav_glow_white"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_nav_glow_white.vfx");
  level._effect["vfx_oil_bulb_lensflare_white"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_bulb_lensflare_white.vfx");
  level._effect["vfx_oil_bulb_lensflare_red"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_bulb_lensflare_red.vfx");
  level._effect["vfx_oil_bulb_lensflare_green"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_bulb_lensflare_green.vfx");
  level._effect["vfx_oil_fluorescent_lf"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_fluorescent_lf.vfx");
  level._effect["vfx_oil_distant_fog"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_distant_fog.vfx");
  level._effect["vfx_oil_blinking_green_light"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_blinking_green_light.vfx");
  level._effect["vfx_oil_box_light_flare_orange"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_box_light_flare_orange.vfx");
  level._effect["vfx_oil_smoke_stack"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_smoke_stack.vfx");
  level._effect["vfx_oil_sunflare"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_sunflare.vfx");
  level._effect["vfx_oil_vent_steam_windy"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_vent_steam_windy.vfx");
  level._effect["vfx_oil_rotating_orange_light"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_rotating_orange_light.vfx");
  level._effect["vfx_oil_blinking_red_light"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_blinking_red_light.vfx");
  level._effect["vfx_birds_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_circling.vfx");
  level._effect["vfx_oil_burnoff"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_burnoff.vfx");
  level._effect["vfx_oil_distant_lightning"] = loadfx("vfx/iw8_mp/level/oil/vfx_oil_distant_lightning.vfx");
  level._effect["cold_breath_run"] = loadfx("vfx/iw8_mp/level/overwinter/vfx_overwinter_cold_breath.vfx");
}