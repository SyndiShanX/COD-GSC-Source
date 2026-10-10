/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7bfb62cd6fe6118e.gsc
*************************************************/

#using script_3a8f9ace195c9da9;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_7f9553b90d7dde8e;

function main() {
  level._effect["vfx_dam_c4_light_blue_on"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_c4_light_blue_on.vfx");
  level._effect["vfx_dam_c4_light_blue_off"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_c4_light_blue_off.vfx");
  level._effect["vfx_dam_c4_glow_green_01"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_c4_glow_green_01.vfx");
  level._effect["vfx_dam_truck_bomb_glow_01"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_truck_bomb_glow_01.vfx");
  level._effect["vfx_dam_bomb_light_blue_on"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_bomb_light_blue_on.vfx");
  level._effect["vfx_dam_bomb_light_blue_off"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_bomb_light_blue_off.vfx");
  level._effect["vfx_dam_bomb_light_red_on"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_bomb_light_red_on.vfx");
  level._effect["vfx_dam_bomb_light_red_off"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_bomb_light_red_off.vfx");
  level._effect["vfx_dam_glow_red_03"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_glow_red_03.vfx");
  level._effect["vfx_slide_dirt"] = loadfx("vfx/iw8/char/slide/vfx_slide_dirt.vfx");
  level._effect["vfx_slide_grass"] = loadfx("vfx/iw8/char/slide/vfx_slide_grass.vfx");
  level._effect["vfx_dam_glow_green_01"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_glow_green_01.vfx");
  level._effect["vfx_dam_glow_red_01"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_glow_red_01.vfx");
  level._effect["vfx_dam_glow_red_02"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_glow_red_02.vfx");
  level._effect["vfx_dam_heli_headlight"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_heli_headlight.vfx");
  level._effect["vfx_dam_heli_cockpit_light"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_heli_cockpit_light.vfx");
  level._effect["vfx_dam_heli_cargo"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_heli_cargo.vfx");
  level._effect["vfx_dam_bomb_disarm_sparks_truck"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_bomb_disarm_sparks_truck.vfx");
  level._effect["vfx_dam_glow_white_01"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_glow_white_01.vfx");
  level._effect["vfx_dam_glow_blue_01"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_glow_blue_01.vfx");
  setDvar(@ "hash_fcad48046518ef67", 0.2);
  setDvar(@ "hash_173fd72936a4128a", 3.42214);
  setDvar(@ "hash_a51fe16d9e863ec3", 0.2);
  setDvar(@ "hash_10c2ad088dc85d91", 1);
  setDvar(@ "hash_646ca256ecff2627", "-26000 41000 -700");
  setDvar(@ "hash_a734a8dc8ef7627e", "9000 9000");
  setDvar(@ "hash_23bb35bbc2d79a8", 1);
  setDvar(@ "hash_27fa9f4c8976e565", 10000);
  setDvar(@ "hash_bf2f16bd0028f6e3", "1.0 1.0 1.0");
  setDvar(@ "hash_33a035c99cb048b1", 0.003);
  setDvar(@ "hash_99863fd36f21e4", 0.16);
  setDvar(@ "hash_43b1bfe24b9db3c5", 0.13);
  setDvar(@ "hash_70640ce906e6d9c2", 0.13);
  setDvar(@ "hash_5bb234e77e6e8500", 1);
  setDvar(@ "hash_248d3e2385cacb9b", 1);
  setDvar(@ "hash_2f948c271d3b0e2e", 1);
  setDvar(@ "hash_7623bd064c30088c", 0);
  setDvar(@ "hash_446ed387d5a2467b", 300);
  setDvar(@ "hash_d5be9cf5305a87c0", 0.95);
  setDvar(@ "hash_383eb0dc42a487be", 0.5);
  setDvar(@ "hash_463c394a8f4350b0", "0 0 0");
  setDvar(@ "hash_6587b19cde46756e", "0.5 -1.0 -0.5");
  setDvar(@ "hash_198bc49639574b81", 680);
  setDvar(@ "hash_b7ba2258818c9f3d", 1);
  setDvar(@ "hash_b7972c5881666d83", 0);
  setDvar(@ "hash_9e9f4b1cab77df95", 0.01);
  setDvar(@ "hash_9ad4ff0067a34902", 0.01);
  setDvar(@ "hash_a4d7a68bf38472d8", 1);
  setDvar(@ "hash_1f828b71214f1028", 25);

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}

  level thread function_193274e8a87a5e3b();
}

function function_193274e8a87a5e3b() {
  namespace_1170726b2799ea65::function_8dccb7c870f39d61();
  flag_wait("player_spawned_with_loadout");
  exploder("dam_sluice_01");
  exploder("dam_sluice_02");
  exploder("dam_sluice_03");
  exploder("dam_sluice_04");
}