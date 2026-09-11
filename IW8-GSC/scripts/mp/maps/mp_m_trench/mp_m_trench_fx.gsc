/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_trench\mp_m_trench_fx.gsc
**********************************************************/

function main() {
  level._effect["vfx_trench_teddy_explode"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_teddy_explode.vfx");
  level._effect["vfx_trench_teddy_alarm"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_teddy_alarm.vfx");
  level._effect["vfx_trench_teddy_door_open"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_teddy_door_open.vfx");
  level._effect["vfx_trench_minigun_muz"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_minigun_muz.vfx");
  level._effect["vfx_br_bunker_vent_vapor"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_vent_vapor.vfx");
  level._effect["vfx_br_ambient_smk_lg"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_ambient_smk_lg.vfx");
  level._effect["vfx_moths_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_moths_1.vfx");
  level._effect["vfx_trench_tank_fire_2"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_tank_fire_2.vfx");
  level._effect["vfx_trench_tank_smoke"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_tank_smoke.vfx");
  level._effect["vfx_trench_tank_fire"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_tank_fire.vfx");
  level._effect["vfx_trench_fire_tiny"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_fire_tiny.vfx");
  level._effect["vfx_trench_fire_wall_wide"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_fire_wall_wide.vfx");
  level._effect["vfx_trench_billow_mist"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_billow_mist.vfx");
  level._effect["vfx_trench_crater_smoke_lrg_3"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_crater_smoke_lrg_3.vfx");
  level._effect["vfx_trench_smoke_building_roof"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_smoke_building_roof.vfx");
  level._effect["vfx_trench_interior_dust_motes_med"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_interior_dust_motes_med.vfx");
  level._effect["vfx_trench_cigarette_lit"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_cigarette_lit.vfx");
  level._effect["vfx_trench_fire_ceiling_01"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_fire_ceiling_01.vfx");
  level._effect["vfx_trench_bunker_box_light_flare"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_bunker_box_light_flare.vfx");
  level._effect["vfx_trench_moving_fog"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_moving_fog.vfx");
  level._effect["vfx_trench_crater_smoke_lrg_2"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_crater_smoke_lrg_2.vfx");
  level._effect["vfx_trench_chopper"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_chopper.vfx");
  level._effect["vfx_trench_water_drips"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_water_drips.vfx");
  level._effect["vfx_trench_fire_big_no_smoke"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_fire_big_no_smoke.vfx");
  level._effect["vfx_trench_sunflare"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_sunflare.vfx");
  level._effect["vfx_trench_light_flare"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_light_flare.vfx");
  level._effect["vfx_trench_fire_big"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_fire_big.vfx");
  level._effect["vfx_birds_sparrows_circling"] = loadfx("vfx/iw8_mp/gen_amb/vfx_birds_sparrows_circling.vfx");
  level._effect["vfx_trench_crater_smoke_lrg"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_crater_smoke_lrg.vfx");
  level._effect["vfx_trench_bulb_lensflare_red"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_bulb_lensflare_red.vfx");
  level._effect["vfx_trench_vent_steam"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_vent_steam.vfx");
  level._effect["vfx_trench_vindia_fire"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_vindia_fire.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_fire_tiny"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_tiny.vfx");
  level._effect["TrenchRingFX"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_gas_wall.vfx");
  level._effect["TrenchExplosionFX"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_explosion.vfx");
  level._effect["vfx_trench_explosion_2"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_explosion_2.vfx");
  level._effect["vfx_trench_crater_smoke_linger"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_crater_smoke_linger.vfx");
  level._effect["vfx_trench_vent_steam"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_vent_steam.vfx");
  level._effect["vfx_trench_vindia_fire"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_vindia_fire.vfx");
  level._effect["vfx_gnat_swarm_1"] = loadfx("vfx/iw8_mp/gen_amb/vfx_gnat_swarm_1.vfx");
  level._effect["vfx_fire_tiny"] = loadfx("vfx/iw8_mp/gen_amb/vfx_fire_tiny.vfx");
  level._effect["TrenchEnterCode"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_keypad_readout_fail.vfx");
  level._effect["TrenchCorrectCode"] = loadfx("vfx/iw8_mp/level/trench/vfx_trench_keypad_readout_success.vfx");
}