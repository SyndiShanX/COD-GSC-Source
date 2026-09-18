/********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx.gsc
********************************************************************/

init() {
  level._effect["zmb_spawn_water_drip"] = loadfx("vfx/zombie/zmb_spawn_water_drip_body");
  level._effect["zmb_spawn_concrete"] = loadfx("vfx/zombie/zmb_spawn_concrete");
  level._effect["zmb_spawn_water"] = loadfx("vfx/zombie/zmb_spawn_water");
  level._effect["zmb_spawn_sand"] = loadfx("vfx/zombie/zmb_spawn_sand");
  level._effect["zmb_spawn_mud"] = loadfx("vfx/zombie/zmb_spawn_mud");
  level._effect["zmb_spawn_dirt"] = loadfx("vfx/zombie/zmb_spawn_dirt");
  level._effect["zmb_cart_charge_pnt"] = loadfx("vfx/map/mp_zombie_nest/zmb_cart_charge_pnt");
  level._effect["zmb_nest_generator_bulb_red"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_bulb_red");
  level._effect["zmb_nest_generator_bulb_green"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_bulb_green");
  level._effect["zmb_nest_generator_bulb_off"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_bulb_off");
  level._effect["zmb_nest_generator_light_red"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_light_red");
  level._effect["zmb_nest_generator_light_green"] = loadfx("vfx/map/mp_zombie_nest/zmb_nest_generator_light_green");
  level._effect["zmb_geistkraft_radius_400"] = loadfx("vfx/map/mp_zombie_nest/zmb_geistkraft_radius_400");
  level._effect["zmi_max_armor_vfx"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_armor");
  level._effect["zmi_sniper_tower_vfx"] = loadfx("vfx/zombie/prototype_fx/zmi_sniper_tower_vfx");
  level._effect["vfx_marker_dom"] = loadfx("vfx/unique/vfx_marker_dom");
  level._effect["zmb_geistkraft_radius_256"] = loadfx("vfx/map/mp_zombie_nest/zmb_geistkraft_radius_256");
  level._effect["dlc_pickup_zombies_01_blitz_random"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_blitz_random");
  level._effect["zmb_battery_defense_dmg_1"] = loadfx("vfx/zombie/zmb_battery_defense_dmg_1");
  level._effect["zmb_battery_defense_dmg_2"] = loadfx("vfx/zombie/zmb_battery_defense_dmg_2");
  level._effect["zmb_battery_defense_dmg_3"] = loadfx("vfx/zombie/zmb_battery_defense_dmg_3");
  level._effect["zmb_battery_defense_dmg_fail"] = loadfx("vfx/zombie/zmb_battery_defense_exp");
  level._effect["dlc_zmb_dig02_hallucination_01"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_hallucination_01");
  level._effect["dlc_zmb_dig02_hallucination_02"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_hallucination_02");
  level._effect["dlc_zmb_dig02_hallucination_03"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_hallucination_03");
  level._effect["zmb_isl_fog_zmb_emerge_01"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_fog_zmb_emerge_01");
  level._effect["zmb_isl_fog_zmb_assn_01"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_fog_zmb_assn_01");
  level._effect["zmb_shattered_loot_drop"] = loadfx("vfx/zombie/prototype_fx/zmb_shattered_loot_drop");
  level._effect["zmb_ber_bolt_rod_gk_attach"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_rod_gk_attach");
  level._effect["zmb_ber_szlr_buildup_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_buildup_1");
  level._effect["zmb_ber_szlr_init_hit"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_init_hit");
  level._effect["zmb_sizzler_head"] = loadfx("vfx/map/mp_zombie_berlin/zmb_sizzler_head");
  level._effect["zmb_sizzler_flames"] = loadfx("vfx/map/mp_zombie_berlin/zmb_sizzler_flames");
  level._effect["zmb_ber_szlr_burst_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_burst_1");
  level._effect["zmb_ber_szlr_geistkraftexplode_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_geistkraftexplode_1");
  level._effect["zmb_ber_szlr_geistkraftdrain_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_geistkraftdrain_1");
  level._effect["zmb_sizzler_mouth"] = loadfx("vfx/map/mp_zombie_berlin/zmb_sizzler_mouth");
  level._effect["zmb_ber_gun_cone_glow"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_gun_cone_glow");
  level._effect["zmb_ber_gun_cone_glow_pap"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_gun_cone_glow_pap");
  level._effect["dlc_pickup_zombies_01_money_gj_2"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_money_gj_2");
  level._effect["zmb_shattered_insane_mode"] = loadfx("vfx/zombie/prototype_fx/zmb_shattered_insane_mode");
  level._effect["zmb_shattered_insane_mode_pending"] = loadfx("vfx/zombie/prototype_fx/zmb_shattered_insane_mode_pending");
  level._effect["hp_neutral"] = loadfx("vfx/unique/hardpoint_chevron_neutral");
  level._effect["hp_neutral_vertical"] = loadfx("vfx/unique/hardpoint_chevron_neutral_vertical");
  level._effect["hp_friendly"] = loadfx("vfx/unique/hardpoint_chevron_friendly");
  level._effect["hp_friendly_vertical"] = loadfx("vfx/unique/hardpoint_chevron_friendly_vertical");
  level._effect["hp_enemy"] = loadfx("vfx/unique/hardpoint_chevron_enemy");
  level._effect["hp_enemy_vertical"] = loadfx("vfx/unique/hardpoint_chevron_enemy_vertical");
  level._effect["hp_contested"] = loadfx("vfx/unique/hardpoint_chevron_contested");
  level._effect["hp_contested_vertical"] = loadfx("vfx/unique/hardpoint_chevron_contested_vertical");
}