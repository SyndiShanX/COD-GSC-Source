/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_hideout\mp_hideout_fx.gsc
********************************************************/

function main() {
  level._effect["vfx_hide_shower_screenfx"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_shower_screenfx.vfx");
  level._effect["vfx_hide_birds_in_field"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_birds_in_field.vfx");
  level._effect["vfx_hide_ground_steam"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_ground_steam.vfx");
  level._effect["vfx_trash_flies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
  level._effect["vfx_hide_dust_move_slow"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_dust_move_slow.vfx");
  level._effect["vfx_hide_sunflare"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_sunflare.vfx");
  level._effect["vfx_hide_bulb_light_flare"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_bulb_light_flare.vfx");
  level._effect["vfx_hide_leaves_falling"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_leaves_falling.vfx");
  level._effect["vfx_birds_sparrow_burst_01"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrow_burst_01.vfx");
  level._effect["vfx_hide_shower_stream"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_shower_stream.vfx");
  level._effect["vfx_hide_shower_splash"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_shower_splash.vfx");
  level._effect["vfx_hide_tandori"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_tandori.vfx");
  level._effect["vfx_water_drips_line_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_water_drips_line_1.vfx");
  level._effect["vfx_hide_fluorescent_lf"] = loadfx("vfx/iw8_mp/level/hideout/vfx_hide_fluorescent_lf.vfx");
  level._effect["vfx_ani_constant_motes"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_constant_motes.vfx");
  level._effect["vfx_swirling_dust"] = loadfx("vfx/iw8_mp/level/faridah/vfx_swirling_dust.vfx");
  level._effect["vfx_ani_town_fog"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_town_fog.vfx");
  level._effect["vfx_ani_sparks_1"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_sparks_1.vfx");
  level._effect["vfx_birds_sparrows_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrows_circling.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_car_fire_linger_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_car_fire_linger_2.vfx");
  level._effect["vfx_ani_dust_move_slow"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_dust_move_slow.vfx");
  level._effect["vfx_dust_motes_med"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dust_motes_med.vfx");
  level._effect["vfx_birds_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_circling.vfx");
  level._effect["vfx_butterflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_ani_mist_ground_01"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_mist_ground_01.vfx");
  level._effect["vfx_ani_billow_mist_1"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_billow_mist_1.vfx");
  level._effect["vfx_ani_sand_flat"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_sand_flat.vfx");
  level._effect["vfx_ani_falling_dust_ceiling"] = loadfx("vfx/iw8_mp/level/aniyah/vfx_ani_falling_dust_ceiling.vfx");
  level._effect["vfx_dragonflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dragonflies.vfx");
  level._effect["vfx_trash_drift_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_drift_1.vfx");
  level._effect["vfx_trash_circle_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_circle_1.vfx");
  level._effect["vfx_mosquitos_over_water_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_mosquitos_over_water_1.vfx");
  level._effect["vfx_moths_2"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_2.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_fire_tiny"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_tiny.vfx");
  level._effect["vfx_fire_sml"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_sml.vfx");
  thread combo_reset();
}

function combo_reset() {
  var0 = getEnt("birds_in_square", "targetname");

  for(;;) {
    var0 waittill("trigger", var1);

    if(isPlayer(var1)) {
      scripts\engine\utility::exploder("birds_fly");
      playsoundatpos((896, 192, 224), "emt_mp_hideout_birds_flyaway");
      var0 delete();
      return;
    }
  }
}