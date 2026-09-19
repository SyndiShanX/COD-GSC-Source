/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dig_02_srv_fx.gsc
***********************************************/

main() {
  level._effect["test_effect"] = loadfx("vfx/test/test_fx");
  level._effect["dlc_zmb_dig02_sword_looping"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_looping");
  level._effect["dlc_zmb_dig_02_spike_trap_on_rnr"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_spike_trap_on_rnr");
  level._effect["dlc_zmb_dig_02_uber_explode"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_uber_explode");
  level._effect["dlc_zmb_dig_02_ambuber_leaking"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_ambuber_leaking");
  level._effect["zmb_1911_pap_explosive_impact"] = loadfx("vfx/weaponimpact/zmb_1911_pap_explosive_impact");
  level._effect["dlc_zmb_dig02_sword_assmble_flash"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_assmble_flash");
  level._effect["dlc_zmb_dig02_fire_bowl_sm_nolight"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fire_bowl_sm_nolight");
  level._effect["dlc_zmb_dig02_roof_lensflare1"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_roof_lensflare1");
  level._effect["dlc_zmb_dig02_blood_statue_grit"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_statue_grit");
  level._effect["dlc_zmb_dig02_dust_falling_line_rnr"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_dust_falling_line_rnr");
  level._effect["dlc_zmb_dig02_dust_falling_line"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_dust_falling_line");
  level._effect["dlc_zmb_dig02_geiskraft_light_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_light_sm");
  level._effect["dlc_zmb_dig02_sword_piece_glow_amb"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_piece_glow_amb");
  level._effect["dlc_zmb_dig02_rune_reveal"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_rune_reveal");
  level._effect["dlc_zmb_dig02_geiskraft_amb_edge"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_amb_edge");
  level._effect["dlc_zmb_dig02_sword_sphere"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_sphere");
  level._effect["dlc_zmb_dig02_geiskraft_wall_curve"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_wall_curve");
  level._effect["dlc_zmb_dig02_geiskraft_wall"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_wall");
  level._effect["dlc_zmb_dig02_geiskraft_ambient"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_geiskraft_ambient");
  level._effect["dlc_zmb_dig02_sword_combine"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_combine");
  level._effect["dlc_zmb_dig02_gk_smoke_geotrail"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_gk_smoke_geotrail");
  level._effect["zmb_receiver_full"] = loadfx("vfx/map/mp_zombie_nest/zmb_receiver_full");
  level._effect["zmb_zmb_key_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zmb_key_light");
  level._effect["vehicle_warbird_explosion_midair"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
  level._effect["zmb_death_hand_to_hand_melee_hit"] = loadfx("vfx/zombie/abilities_perks/zmb_death_hand_to_hand_melee_hit");
  level._effect["dlc_zmb_dig02_blood_plates_sparse"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_plates_sparse");
  level._effect["dlc_zmb_dig02_generator_malfunc_ger"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_generator_malfunc_ger");
  level._effect["dlc_zmb_dig02_eq_dust_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_dust_lrg");
  level._effect["dlc_zmb_dig02_generator_malfunc"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_generator_malfunc");
  level._effect["dlc_zmb_dig02_fire_bowl_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fire_bowl_sm");
  level._effect["dlc_zmb_dig02_eq_brick_med"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_brick_med");
  level._effect["dlc_zmb_dig02_eq_basalt_med"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_basalt_med");
  level._effect["dlc_zmb_dig02_eq_snow_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_snow_lrg");
  level._effect["dlc_zmb_dig02_eq_basalt_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_basalt_lrg");
  level._effect["dlc_zmb_dig02_eq_brick_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_eq_brick_lrg");
  level._effect["dlc_zmb_dig02_snow_vapor"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_vapor");
  level._effect["dlc_zmb_dig02_snow_fall_smallhole"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_fall_smallhole");
  level._effect["dlc_zmb_dig02_snow_fall_sacrifice"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_fall_sacrifice");
  level._effect["dlc_zmb_dig02_snow_ground_skitter"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_ground_skitter");
  level._effect["dlc_zmb_dig02_snow_ground_wind"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_ground_wind");
  level._effect["dlc_zmb_dig02_fire_bowl"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fire_bowl");
  level._effect["dlc_zmb_dig02_snow_falling_edge"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_falling_edge");
  level._effect["dlc_zmb_dig02_snow_swirl"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_swirl");
  level._effect["dlc_zmb_dig02_snow_falling_high"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_falling_high");
  level._effect["dlc_zmb_dig02_snow_fall"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_snow_fall");
  level._effect["dlc_zmb_dig02_room_torch"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_room_torch");
  level._effect["zmb_statue_room_torch"] = loadfx("vfx/map/mp_zombie_berlin/zmb_statue_room_torch");
  level._effect["tra_roach_run_lrg"] = loadfx("vfx/map/train/tra_roach_run_lrg");
  level._effect["dlc_zmb_dig02_dust_interior"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_dust_interior");
  level._effect["dlc_zmb_dig02_blood_decal_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_decal_sm");
  level._effect["dlc_zmb_dig02_godray_01"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_godray_01");
  level._effect["zmb_isl_rocks_falling_water_rnr"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_rocks_falling_water_rnr");
  level._effect["dlc_zmb_dig02_water_trickle"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_water_trickle");
  level._effect["dlc_zmb_dig02_blood_decal"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_decal");
  level._effect["zmb_isl_blood_drip_hc_head"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_blood_drip_hc_head");
  level._effect["dlc_zmb_dig02_waterdrops_lrg"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_waterdrops_lrg");
  level._effect["dlc_zmb_dig02_blood_waterdrips"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_waterdrips");
  level._effect["dlc_zmb_dig02_water_drip_fast"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_water_drip_fast");
  level._effect["dlc_zmb_dig02_steam_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_steam_sm");
  level._effect["dlc_zmb_dig02_fog_ambient_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fog_ambient_sm");
  level._effect["dlc_zmb_dig02_fog_ambient"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fog_ambient");
  level._effect["dlc_zmb_dig02_blood_waterfall_splsh"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_waterfall_splsh");
  level._effect["dlc_zmb_dig02_blood_waterfall_dcl"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_waterfall_dcl");
  level._effect["dlc_zmb_dig02_blood_waterfall"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_waterfall");

  level._effect["zmb_dig_snow_fall_fast"] = loadfx("vfx/map/mp_zombie_dig/zmb_dig_snow_fall_fast");
  level._effect["zmb_dig_snow_fall"] = loadfx("vfx/map/mp_zombie_dig/zmb_dig_snow_fall");

  level._effect["zmb_receiver_full"] = loadfx("vfx/map/mp_zombie_nest/zmb_receiver_full");
  level._effect["zmb_receiver_charge_pnt"] = loadfx("vfx/map/mp_zombie_nest/zmb_receiver_charge_pnt");
  level._effect["ground_impact"] = loadfx("vfx/zombie/zmb_ground_impact");
  level._effect["zmb_eye_glow"] = loadfx("vfx/zombie/prototype_fx/zombie_eye_glow");
  level._effect["zmb_jolts_out"] = loadfx("vfx/zombie/zmb_jolts_out");
  level._effect["zmb_zmb_key_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zmb_key_light");
  level._effect["zmb_nest_generator_light_red"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_light_red");
  level._effect["zmb_nest_generator_light_green"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_light_green");
  level._effect["zmb_nest_generator_bulb_red"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_bulb_red");
  level._effect["zmb_nest_generator_bulb_green"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_bulb_green");

  level._effect["zmb_dnk_uber_explode"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_uber_explode");
  level._effect["zmb_dnk_uber_leak"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_uber_leak");

  level._effect["dlc_zmb_dig02_sword_piece_glow"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_sword_piece_glow");
  level._effect["zmb_ber_szlr_geistkraftexplode_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_geistkraftexplode_1");

  level._effect["zmb_gk_claw_battery_charge_1"] = loadfx("vfx/map/mp_zombie_nest/zmb_gk_claw_battery_charge_1");
  level._effect["zmb_gk_claw_battery_charge_2"] = loadfx("vfx/map/mp_zombie_nest/zmb_gk_claw_battery_charge_2");
  level._effect["zmb_gk_claw_battery_charge_3"] = loadfx("vfx/map/mp_zombie_nest/zmb_gk_claw_battery_charge_3");
  level._effect["zmb_blood_plate_fill"] = loadfx("vfx/zombie/prototype_fx/zmb_blood_plate_fill");
  level._effect["dlc_zmb_dig02_blood_plates_emis"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_plates_emis");
  level._effect["dlc_zmb_dig02_blood_plates_emis_lp"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_blood_plates_emis_lp");

  level._effect["zmb_med_trap_gib"] = loadfx("vfx/zombie/zmb_med_trap_gib");
  level._effect["dlc_zmb_dig_02_spike_trap_on"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_spike_trap_on");

  if(getDvar("3508") != "1")
    maps\createfx\mp_zombie_dig_02_srv_fx::main();
}