/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nazi_zombie_sumpf_magic_box.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\nazi_zombie_sumpf_trap_pendulum;
#include maps\nazi_zombie_sumpf_blockers;
#include maps\nazi_zombie_sumpf_zone_management;

magic_box_init() {
  maps\nazi_zombie_sumpf::activate_door_flags("magic_blocker", "script_noteworthy");
  level.open_chest_location = [];
  level.open_chest_location[0] = undefined;
  level.open_chest_location[1] = undefined;
  level.open_chest_location[2] = undefined;
  level.open_chest_location[3] = undefined;
  level.open_chest_location[4] = "start_chest";
  level.open_chest_location[5] = "attic_chest";
  players = get_players();
  if(players.size < 2) {
    level.first_time_opening_perk_hut = true;
  }
  level thread waitfor_flag_open_chest_location("nw_magic_box");
  level thread waitfor_flag_open_chest_location("ne_magic_box");
  level thread waitfor_flag_open_chest_location("se_magic_box");
  level thread waitfor_flag_open_chest_location("sw_magic_box");
}

waitfor_flag_open_chest_location(which) {
  wait(3);
  switch (which) {
    case "nw_magic_box":
      flag_wait("nw_magic_box");
      level.open_chest_location[0] = "nw_chest";
      thread maps\nazi_zombie_sumpf_zone_management::activate_outdoor_zones("northwest", "targetname");
      if(get_enemy_count() != 0 && !flag("dog_round")) {
        thread maps\nazi_zombie_sumpf::spawn_initial_outside_zombies("northwest_initial_zombies");
      }
      maps\nazi_zombie_sumpf_trap_pendulum::initPendulumTrap();
      penBuyTrigger = getEntArray("pendulum_buy_trigger", "targetname");
      array_thread(penBuyTrigger, maps\nazi_zombie_sumpf_trap_pendulum::penThink);
      maps\nazi_zombie_sumpf_zone_management::add_area_dog_spawners("nw_magic_box_dog_spawners");
      break;
    case "ne_magic_box":
      flag_wait("ne_magic_box");
      level.open_chest_location[1] = "ne_chest";
      thread maps\nazi_zombie_sumpf_zone_management::activate_outdoor_zones("northeast", "targetname");
      if(get_enemy_count() != 0 && !flag("dog_round")) {
        thread maps\nazi_zombie_sumpf::spawn_initial_outside_zombies("northeast_initial_zombies");
      }
      level thread maps\nazi_zombie_sumpf_zipline::initZipline();
      maps\nazi_zombie_sumpf_zone_management::add_area_dog_spawners("ne_magic_box_dog_spawners");
      break;
    case "se_magic_box":
      flag_wait("se_magic_box");
      level.open_chest_location[2] = "se_chest";
      thread maps\nazi_zombie_sumpf_zone_management::activate_outdoor_zones("southeast", "targetname");
      if(get_enemy_count() != 0 && !flag("dog_round")) {
        thread maps\nazi_zombie_sumpf::spawn_initial_outside_zombies("southeast_initial_zombies");
      }
      maps\nazi_zombie_sumpf_zone_management::add_area_dog_spawners("se_magic_box_dog_spawners");
      break;
    case "sw_magic_box":
      flag_wait("sw_magic_box");
      level.open_chest_location[3] = "sw_chest";
      thread maps\nazi_zombie_sumpf_zone_management::activate_outdoor_zones("southwest", "targetname");
      if(get_enemy_count() != 0 && !flag("dog_round")) {
        thread maps\nazi_zombie_sumpf::spawn_initial_outside_zombies("southwest_initial_zombies");
      }
      maps\nazi_zombie_sumpf_zone_management::add_area_dog_spawners("sw_magic_box_dog_spawners");
      break;
    default:
      return;
  }
  if(isDefined(level.randomize_perks) && level.randomize_perks == false) {
    maps\nazi_zombie_sumpf_perks::randomize_vending_machines();
    level.vending_model_info = [];
    level.vending_model_info[level.vending_model_info.size] = "zombie_vending_jugg_on_price";
    level.vending_model_info[level.vending_model_info.size] = "zombie_vending_doubletap_price";
    level.vending_model_info[level.vending_model_info.size] = "zombie_vending_revive_on_price";
    level.vending_model_info[level.vending_model_info.size] = "zombie_vending_sleight_on_price";
    level.randomize_perks = true;
  }
  switch (which) {
    case "nw_magic_box":
      flag_wait("northwest_building_unlocked");
      maps\nazi_zombie_sumpf_zone_management::add_area_dog_spawners("nw_perk_hut_dog_spawners");
      maps\nazi_zombie_sumpf_perks::vending_randomization_effect(0);
      break;
    case "ne_magic_box":
      flag_wait("northeast_building_unlocked");
      maps\nazi_zombie_sumpf_zone_management::add_area_dog_spawners("ne_perk_hut_dog_spawners");
      maps\nazi_zombie_sumpf_perks::vending_randomization_effect(1);
      break;
    case "se_magic_box":
      flag_wait("southeast_building_unlocked");
      maps\nazi_zombie_sumpf_zone_management::add_area_dog_spawners("se_perk_hut_dog_spawners");
      maps\nazi_zombie_sumpf_perks::vending_randomization_effect(2);
      break;
    case "sw_magic_box":
      flag_wait("southwest_building_unlocked");
      maps\nazi_zombie_sumpf_zone_management::add_area_dog_spawners("sw_perk_hut_dog_spawners");
      maps\nazi_zombie_sumpf_perks::vending_randomization_effect(3);
      break;
  }
}

magic_box_tracker() {
  level waittill("weapon_fly_away_start");
  level.open_chest_location[0] = "nw_chest";
  level.open_chest_location[1] = "ne_chest";
  level.open_chest_location[2] = "se_chest";
  level.open_chest_location[3] = "sw_chest";
  level.open_chest_location[4] = undefined;
  level.open_chest_location[5] = undefined;
  level.magic_box_first_move = true;
  level waittill("magic_box_light_switch");
  level.open_chest_location[0] = "nw_chest";
  level.open_chest_location[1] = "ne_chest";
  level.open_chest_location[2] = "se_chest";
  level.open_chest_location[3] = "sw_chest";
  level.open_chest_location[4] = "start_chest";
  level.open_chest_location[5] = "attic_chest";
}