/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_tower\mp_jup_tower_fx.gsc
************************************************************/

#namespace mp_jup_tower_fx;

function main() {
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge_left"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge_left.vfx");
  level._effect["vfx_tower_water_stream_platform"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/floating_islands/vfx_tower_water_stream_platform.vfx");
  level._effect["vfx_tower_pipe_smoke_platform"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/floating_islands/vfx_tower_pipe_smoke_platform.vfx");
  level._effect["vfx_ob_rift_ship_water_stream_sides_02"] = loadfx("vfx/jup/ob/vfx_ob_rift_ship_water_stream_sides_02.vfx");
  level._effect["vfx_ob_rift_ship_water_stream_sides_01"] = loadfx("vfx/jup/ob/vfx_ob_rift_ship_water_stream_sides_01.vfx");
  level._effect["vfx_entity_weak_point_hand_stars_red"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_entity_weak_point_hand_stars_red.vfx");
  level._effect["vfx_entity_weak_point_hand_stars"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_entity_weak_point_hand_stars.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_glow_start"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_glow_start.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge_end_right"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge_end_right.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge_start_right"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge_start_right.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge_start_left"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge_start_left.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge_end_left"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge_end_left.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge_right"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge_right.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge_loop"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge_loop.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge_end"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge_end.vfx");
  level._effect["vfx_entity_lightning_ultimate_strike_hand_charge"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_ultimate_strike_hand_charge.vfx");
  level._effect["vfx_bossfight_amb_stage2"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_stage2.vfx");
  level._effect["vfx_bossfight_amb_stage3"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_stage3.vfx");
  level._effect["vfx_bossfight_amb_stage1"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_stage1.vfx");
  level._effect["vfx_bossfight_amb_island_ring_stage3"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_ring_stage3.vfx");
  level._effect["vfx_bossfight_amb_island_stage3_lightning_med"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage3_lightning_med.vfx");
  level._effect["vfx_bossfight_amb_island_stage3_lightning_sml"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage3_lightning_sml.vfx");
  level._effect["vfx_bossfight_amb_island_stage3_lightning_lrg"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage3_lightning_lrg.vfx");
  level._effect["vfx_bossfight_amb_island_stage2_rocks_sml"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage2_rocks_sml.vfx");
  level._effect["vfx_bossfight_amb_island_stage2_rocks_med"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage2_rocks_med.vfx");
  level._effect["vfx_bossfight_amb_island_stage2_rocks_lrg"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage2_rocks_lrg.vfx");
  level._effect["vfx_bossfight_amb_island_stage1_fires_sml"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage1_fires_sml.vfx");
  level._effect["vfx_bossfight_amb_island_stage1_fires_med"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage1_fires_med.vfx");
  level._effect["vfx_bossfight_amb_island_stage1_fires_lrg"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_stage1_fires_lrg.vfx");
  level._effect["vfx_bossfight_amb_island_ring_stage2"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_ring_stage2.vfx");
  level._effect["vfx_bossfight_amb_island_ring_stage1"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_bossfight_amb_island_ring_stage1.vfx");
  level._effect["vfx_tower_pillar_rocks_med"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/floating_islands/vfx_tower_pillar_rocks_med.vfx");
  level._effect["vfx_entity_lightning_strike_hand_charge_loop"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_strike_hand_charge_loop.vfx");
  level._effect["vfx_entity_lightning_strike_hand_charge_end"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_strike_hand_charge_end.vfx");
  level._effect["vfx_tower_dust_blow"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/floating_islands/vfx_tower_dust_blow.vfx");
  level._effect["vfx_entity_lightning_strike_charge_stage1"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_strike_charge_stage1.vfx");
  level._effect["vfx_entity_lightning_strike_charge_buildup"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_strike_charge_buildup.vfx");
  level._effect["vfx_entity_lightning_strike_hand_charge_glow"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_strike_hand_charge_glow.vfx");
  level._effect["vfx_entity_lightning_strike_hand_charge"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_strike_hand_charge.vfx");
  level._effect["vfx_entity_lightning_strike_charge"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_entity_lightning_strike_charge.vfx");
  level._effect["vfx_tower_lightning_platform_xxsml"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/floating_islands/vfx_tower_lightning_platform_xxsml.vfx");
  level._effect["vfx_tower_lightning_platform_xsml"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/floating_islands/vfx_tower_lightning_platform_xsml.vfx");
  level._effect["vfx_tower_lightning_platform_sml"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/floating_islands/vfx_tower_lightning_platform_sml.vfx");
  level._effect["vfx_tower_lightning_platform_lrg"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/floating_islands/vfx_tower_lightning_platform_lrg.vfx");
  level._effect["vfx_entity_phase2_death_explosion"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_entity_phase2_death_explosion.vfx");
  level._effect["vfx_entity_phase2_death_energy_burst"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_entity_phase2_death_energy_burst.vfx");
  level._effect["vfx_entity_phase2_death_implosion"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/entity/vfx_entity_phase2_death_implosion.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}