main() {
  level._effect["vfx_mp_br_tut_sunflare"] = loadfx("vfx/iw8_br/mp_br_tut/vfx_mp_br_tut_sunflare.vfx");
  level._effect["vfx_billow_mist_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_billow_mist_1.vfx");
  level._effect["vfx_mist_ground_01"] = loadfx("vfx/iw8_mp/gen_amb/vfx_mist_ground_01.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_br_dust_motes_constant_indoor"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_dust_motes_constant_indoor.vfx");
  level._effect["vfx_birds_sparrows_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrows_circling.vfx");
  level._effect["vfx_dust_motes_lrg"] = loadfx("vfx/iw8_mp/gen_amb/vfx_dust_motes_lrg.vfx");
  level._effect["vfx_trash_flies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_trash_flies.vfx");
  level._effect["vfx_butterflies"] = loadfx("vfx/iw8_mp/gen_amb/vfx_butterflies.vfx");
  level._effect["vfx_mp_br_tut_sunflare"] = loadfx("vfx/iw8_br/mp_br_tut/vfx_mp_br_tut_sunflare.vfx");
  level._effect["vfx_br_zone_80000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_80000_static_s.vfx");
  level._effect["vfx_br_zone_40000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_40000_static_s.vfx");
  level._effect["vfx_br_zone_20000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_20000_static_s.vfx");
  level._effect["vfx_br_zone_15000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_15000_static_s.vfx");
  level._effect["vfx_br_zone_10500_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_10500_static_s.vfx");
  level._effect["vfx_br_zone_7000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_7000_static_s.vfx");
  level._effect["vfx_br_zone_4500_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_4500_static_s.vfx");
  level._effect["vfx_br_zone_2500_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_2500_static_s.vfx");
  level._effect["vfx_br_zone_1000_static_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_1000_static_s.vfx");

  level._effect["vfx_br_zone_160000_80000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_160000_80000_s.vfx");
  level._effect["vfx_br_zone_80000_40000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_80000_40000_s.vfx");
  level._effect["vfx_br_zone_40000_20000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_40000_20000_s.vfx");
  level._effect["vfx_br_zone_50000_20000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_50000_20000_s.vfx");
  level._effect["vfx_br_zone_20000_15000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_20000_15000_s.vfx");
  level._effect["vfx_br_zone_15000_7000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_15000_7000_s.vfx");
  level._effect["vfx_br_zone_15000_10500_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_15000_10500_s.vfx");
  level._effect["vfx_br_zone_10500_7000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_10500_7000_s.vfx");
  level._effect["vfx_br_zone_7000_4500_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_7000_4500_s.vfx");
  level._effect["vfx_br_zone_4500_2500_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_4500_2500_s.vfx");
  level._effect["vfx_br_zone_2500_1000_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_2500_1000_s.vfx");
  level._effect["vfx_br_zone_1000_0_s"] = LoadFX("vfx/iw8_mp/__tests/vfx_br_zone_1000_0_s.vfx");

  level._effect["vfx_snatch_ac130_clouds"] = LoadFX("vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx");

  if(getDvar("OKOLRTLORL") != "1")
    scripts\mp\maps\mp_br_tut\gen\mp_br_tut_fx::main();
}