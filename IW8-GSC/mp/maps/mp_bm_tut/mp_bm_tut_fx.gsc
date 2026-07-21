main() {
  level._effect["vfx_mp_br_tut_sunflare"] = LoadFX("vfx/iw8_br/mp_br_tut/vfx_mp_br_tut_sunflare.vfx");
  level._effect["vfx_billow_mist_1"] = LoadFX("vfx/iw8_mp/gen_amb/vfx_billow_mist_1.vfx");
  level._effect["vfx_mist_ground_01"] = LoadFX("vfx/iw8_mp/gen_amb/vfx_mist_ground_01.vfx");
  level._effect["vfx_gnat_swarm_1"] = LoadFX("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_br_dust_motes_constant_indoor"] = LoadFX("vfx/iw8_br/gen_amb/vfx_br_dust_motes_constant_indoor.vfx");
  level._effect["vfx_birds_sparrows_circling"] = LoadFX("vfx/iw8_mp/gen_amb/vfx_birds_sparrows_circling.vfx");
  level._effect["vfx_dust_motes_lrg"] = LoadFX("vfx/iw8_mp/gen_amb/vfx_dust_motes_lrg.vfx");
  level._effect["vfx_trash_flies"] = LoadFX("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
  level._effect["vfx_butterflies"] = LoadFX("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_mp_br_tut_sunflare"] = LoadFX("vfx/iw8_br/mp_br_tut/vfx_mp_br_tut_sunflare.vfx");

  if(getDvar("OKOLRTLORL") != "1") {
    scripts\mp\maps\mp_bm_tut\gen\mp_bm_tut_fx::main();
    scripts\mp\maps\mp_bm_tut\gen\mp_bm_tut_sound::main();
  }
}