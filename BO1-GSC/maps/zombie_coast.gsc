/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_coast.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_zone_manager;

main() {
  level thread maps\zombie_coast_ffotd::main_start();
  level.riser_type = "snow";
  level.use_new_riser_water = 1;
  level.riser_fx_on_client = 1;
  level.use_clientside_rock_tearin_fx = 1;
  level.use_clientside_board_fx = 1;
  maps\zombie_coast_fx::main();
  init_fx_anims();
  level.poi_positioning_func = ::zombie_coast_poi_positioning_func;
  PreCacheModel("viewmodel_zom_gellar_arms");
  PreCacheModel("viewmodel_zom_englund_arms");
  PreCacheModel("viewmodel_zom_rooker_arms");
  PreCacheModel("viewmodel_zom_trejo_arms");
  level._zombie_custom_add_weapons = ::custom_add_weapons;
  level._CF_PLAYER_ZIPLINE_RUMBLE_QUAKE = 0;
  level._CF_PLAYER_ZIPLINE_FAKE_PLAYER_SETUP = 1;
  level._COAST_FOG_BLIZZARD = 2;
  level._CF_PLAYER_FLINGER_FAKE_PLAYER_SETUP_PRONE = 3;
  level._CF_PLAYER_FLINGER_FAKE_PLAYER_SETUP_STAND = 4;
  level._CF_PLAYER_WATER_FROST = 5;
  level._CF_PLAYER_WATER_FREEZE = 6;
  level._CF_PLAYER_WATER_FROST_REMOVE = 7;
  level._CF_PLAYER_ELECTRIFIED = 8;
  level._ZOMBIE_ACTOR_FLAG_ELECTRIFIED = 2;
  level._ZOMBIE_ACTOR_FLAG_DIRECTOR_LIGHT = 3;
  level._ZOMBIE_ACTOR_FLAG_DIRECTORS_STEPS = 4;
  level._ZOMBIE_ACTOR_FLAG_DIRECTOR_DEATH = 5;
  level._ZOMBIE_ACTOR_FLAG_LAUNCH_RAGDOLL = 0;
  if(GetDvarInt(#"artist") > 0) {
    return;
  }
  level.player_out_of_playable_area_monitor = true;
  level.player_out_of_playable_area_monitor_callback = ::zombie_coast_player_out_of_playable_area_monitor_callback;
  level.zombie_anim_override = maps\zombie_coast::anim_override_func;
  level.player_intersection_tracker_override = ::zombie_coast_player_intersection_tracker_override;
  maps\_zombiemode::register_player_damage_callback(::zombie_coast_player_damage_level_override);
  level._func_humangun_check = ::func_humangun_check;
  level.check_for_alternate_poi = ::check_for_alternate_poi;
  level.pay_turret_cost = 850;
  level.plankB_cost = 1000;
  level.random_pandora_box_start = true;
  level.zombie_coast_visionset = "zombie_coast";
  level thread maps\zombie_coast_cave_slide::cave_slide_anim_init();
  level thread maps\_callbacksetup::SetupCallbacks();
  level.dog_spawn_func = maps\_zombiemode_ai_dogs::dog_spawn_factory_logic;
  maps\zombie_coast_flinger::main();
  level.dogs_enabled = false;
  level.custom_ai_type = [];
  level.custom_ai_type = array_add(level.custom_ai_type, maps\_zombiemode_ai_director::init);
  level.custom_ai_type = array_add(level.custom_ai_type, maps\_zombiemode_ai_faller::faller_init);
  maps\zombie_coast_ai_director::init();
  maps\zombie_coast_lighthouse::init();
  maps\zombie_coast_water::init();
  maps\zombie_coast_eggs::init();
  level.door_dialog_function = maps\_zombiemode::play_door_dialog;
  include_weapons();
  include_powerups();
  level.use_zombie_heroes = true;
  level.zombiemode_using_marathon_perk = true;
  level.zombiemode_using_divetonuke_perk = true;
  level.zombiemode_using_deadshot_perk = true;
  level.use_freezegun_features = true;
  level.uses_tesla_powerup = true;
  level.zombiemode_precache_player_model_override = ::coast_precache_custom_models;
  level.zombiemode_give_player_model_override = ::coast_custom_third_person_override;
  level.zombiemode_player_set_viewmodel_override = ::coast_custom_viewmodel_override;
  level.register_offhand_weapons_for_level_defaults_override = ::coast_offhand_weapon_overrride;
  level.zombiemode_offhand_weapon_give_override = ::coast_offhand_weapon_give_override;
  level.max_perks = 5;
  level.max_solo_lives = 3;
  level.revive_solo_fx_func = ::coast_revive_solo_fx;
  maps\_zombiemode::main();
  maps\_sticky_grenade::init();
  maps\_zombiemode_weap_sickle::init();
  maps\_zombiemode_weap_humangun::init();
  maps\_zombiemode_weap_sniper_explosive::init();
  maps\_zombiemode_weap_nesting_dolls::init();
  level thread maps\_zombiemode::register_sidequest("ZOMBIE_COAST_EGG_SOLO", 43, "ZOMBIE_COAST_EGG_COOP", 44);
  level.director_should_drop_special_powerup = ::coast_director_should_drop_special_powerup;
  battlechatter_off("allies");
  battlechatter_off("axis");
  level.zone_manager_init_func = ::coast_zone_init;
  init_zones[0] = "beach_zone";
  level thread maps\_zombiemode_zone_manager::manage_zones(init_zones);
  level thread stairs_blocker_buyable();
  level thread electric_switch();
  level thread electric_door_function();
  level thread maps\_zombiemode_auto_turret::init();
  level thread maps\zombie_coast_achievement::init();
  level thread maps\zombie_coast_ai_director::coast_director_start();
  level thread coast_fade_in_notify();
  level thread maps\zombie_coast_cave_slide::zombie_cave_slide_init();
  maps\_zombiemode_player_zipline::main();
  level thread setup_water_physics();
  level thread setup_zcoast_water();
  level thread maps\zombie_coast_distance_tracking::zombie_tracking_init();
  SetSavedDvar("zombiemode_path_minz_bias", 17);
  maps\zombie_coast_flinger::init_flinger();
  init_sounds();
  level thread maps\zombie_coast_amb::main();
  level thread coast_power_on_lighthouse_react();
  level thread coast_spawn_init_delay();
  level thread maps\zombie_coast_fx::manage_blizzard();
  if(GetDvarInt(#"zombie_unlock_all") > 0) {
    level thread zombie_unlock_all();
  }
  level thread maps\zombie_coast_ffotd::main_end();
  level thread check_to_set_play_outro_movie();
}

check_to_set_play_outro_movie() {
  flag_wait("all_players_connected");
  if(!level.onlineGame && !level.systemlink) {
    SetDvar("ui_playCoastOutroMovie", 1);
  }
}

zombie_coast_player_out_of_playable_area_monitor_callback() {
  if(is_true(self._being_flung) || is_true(self.is_ziplining)) {
    return false;
  }
  return true;
}

zombie_unlock_all() {
  flag_wait("begin_spawning");
  players = GetPlayers();
  flag_set("power_on");
  zombie_doors = getEntArray("zombie_door", "targetname");
  for(i = 0; i < zombie_doors.size; i++) {
    zombie_doors[i] notify("trigger", players[0]);
  }
  zombie_debris = getEntArray("zombie_debris", "targetname");
  for(i = 0; i < zombie_debris.size; i++) {
    zombie_debris[i] notify("trigger", players[0]);
  }
}

custom_add_weapons() {
  maps\_zombiemode_weapons::add_zombie_weapon("humangun_zm", "humangun_upgraded_zm", &"ZOMBIE_WEAPON_HUMANGUN", 10, "human", "", undefined);
  maps\_zombiemode_weapons::add_zombie_weapon("sniper_explosive_zm", "sniper_explosive_upgraded_zm", &"ZOMBIE_WEAPON_SNIPER_EXPLOSIVE", 2500, "ubersniper", "", undefined);
}

coast_spawn_init_delay(director) {
  flag_wait("begin_spawning");
  flag_clear("spawn_zombies");
  director_zomb = undefined;
  while(!isDefined(director_zomb)) {
    zombs = GetAIArray("axis");
    for(i = 0; i < zombs.size; i++) {
      if(isDefined(zombs[i].animname) && zombs[i].animname == "director_zombie") {
        director_zomb = zombs[i];
      }
    }
    wait_network_frame();
  }
  director_zomb waittill_notify_or_timeout("director_spawn_zombies", 30);
  flag_set("spawn_zombies");
}

#using_animtree("generic_human");
anim_override_func() {
  level.scr_anim["zombie"]["walk3"] = % ai_zombie_walk_v2;
  level.scr_anim["zombie"]["run6"] = % ai_zombie_run_v2;
}

coast_zone_init() {
  flag_init("always_on");
  flag_set("always_on");
  add_adjacent_zone("start_zone", "lighthouse1_zone", "lighthouse_enter");
  add_zone_flags("lighthouse_enter", "start_beach_group");
  add_adjacent_zone("start_cave_zone", "lighthouse1_zone", "lighthouse_lagoon_enter");
  add_adjacent_zone("start_cave_zone", "rear_lagoon_zone", "lighthouse_lagoon_enter");
  add_zone_flags("lighthouse_lagoon_enter", "start_beach_group");
  add_adjacent_zone("start_zone", "start_beach_zone", "start_beach_group");
  add_adjacent_zone("start_beach_zone", "start_cave_zone", "start_beach_group", true);
  add_adjacent_zone("start_zone", "shipfront_bottom_zone", "enter_shipfront_bottom");
  add_zone_flags("enter_shipfront_bottom", "start_beach_group");
  add_adjacent_zone("shipfront_bottom_zone", "shipfront_near_zone", "enter_shipfront_bottom");
  add_adjacent_zone("shipfront_bottom_zone", "shipfront_near_zone", "plankA_enter");
  add_adjacent_zone("shipfront_near_zone", "shipfront_far_zone", "shipfront_far_enter");
  add_adjacent_zone("shipfront_near_zone", "shipfront_2_beach_zone", "enter_shipfront_bottom");
  add_adjacent_zone("shipfront_near_zone", "shipfront_2_beach_zone", "plankA_enter");
  add_adjacent_zone("beach_zone", "shipfront_2_beach_zone", "", true);
  add_adjacent_zone("shipfront_storage_zone", "shipfront_far_zone", "shipfront_deck_storage");
  add_adjacent_zone("shipfront_bottom_zone", "shipfront_storage_zone", "shipfront_bottom_storage");
  add_adjacent_zone("shipfront_near_zone", "shipback_near_zone", "plankA_enter");
  add_adjacent_zone("shipback_near_zone", "shipback_far_zone", "shipback_far_enter");
  add_adjacent_zone("shipback_near_zone", "shipback_near2_zone", "shipback_level2_enter");
  add_adjacent_zone("shipback_near2_zone", "shipback_level3_zone", "ship_house3");
  add_adjacent_zone("residence1_zone", "residence_roof_zone", "residence_beach_group");
  add_adjacent_zone("residence_roof_zone", "beach_zone2", "residence_beach_group");
  add_adjacent_zone("beach_zone2", "beach_zone", "side_beach_debris");
  add_zone_flags("side_beach_debris", "residence_beach_group");
  add_adjacent_zone("shipback_near_zone", "beach_zone", "plankB_enter");
  add_adjacent_zone("residence_roof_zone", "lighthouse2_zone", "balcony_enter");
  add_zone_flags("balcony_enter", "residence_beach_group");
  add_adjacent_zone("residence1_zone", "lighthouse1_zone", "res_2_lighthouse1");
  add_zone_flags("res_2_lighthouse1", "residence_beach_group");
  add_adjacent_zone("start_zone", "residence1_zone", "lighthouse_residence_front");
  add_zone_flags("lighthouse_residence_front", "residence_beach_group");
  add_zone_flags("lighthouse_residence_front", "start_beach_group");
  add_adjacent_zone("lighthouse1_zone", "lighthouse2_zone", "lighthouse2_enter");
  add_adjacent_zone("catwalk_zone", "lighthouse2_zone", "catwalk_enter");
}

include_weapons() {
  include_weapon("frag_grenade_zm", false);
  include_weapon("sticky_grenade_zm", false, true);
  include_weapon("claymore_zm", false, true);
  include_weapon("m1911_zm", false);
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("python_zm");
  include_weapon("python_upgraded_zm", false);
  include_weapon("cz75_zm");
  include_weapon("cz75_upgraded_zm", false);
  include_weapon("m14_zm", false, true);
  include_weapon("m14_upgraded_zm", false);
  include_weapon("m16_zm", false, true);
  include_weapon("m16_gl_upgraded_zm", false);
  include_weapon("g11_lps_zm");
  include_weapon("g11_lps_upgraded_zm", false);
  include_weapon("famas_zm");
  include_weapon("famas_upgraded_zm", false);
  include_weapon("ak74u_zm", false, true);
  include_weapon("ak74u_upgraded_zm", false);
  include_weapon("mp5k_zm", false, true);
  include_weapon("mp5k_upgraded_zm", false);
  include_weapon("mpl_zm", false, true);
  include_weapon("mpl_upgraded_zm", false);
  include_weapon("pm63_zm", false, true);
  include_weapon("pm63_upgraded_zm", false);
  include_weapon("spectre_zm");
  include_weapon("spectre_upgraded_zm", false);
  include_weapon("mp40_zm", false);
  include_weapon("mp40_upgraded_zm", false);
  include_weapon("cz75dw_zm");
  include_weapon("cz75dw_upgraded_zm", false);
  include_weapon("ithaca_zm", false, true);
  include_weapon("ithaca_upgraded_zm", false);
  include_weapon("rottweil72_zm", false, true);
  include_weapon("rottweil72_upgraded_zm", false);
  include_weapon("spas_zm");
  include_weapon("spas_upgraded_zm", false);
  include_weapon("hs10_zm");
  include_weapon("hs10_upgraded_zm", false);
  include_weapon("aug_acog_zm");
  include_weapon("aug_acog_mk_upgraded_zm", false);
  include_weapon("galil_zm");
  include_weapon("galil_upgraded_zm", false);
  include_weapon("commando_zm");
  include_weapon("commando_upgraded_zm", false);
  include_weapon("fnfal_zm");
  include_weapon("fnfal_upgraded_zm", false);
  include_weapon("dragunov_zm");
  include_weapon("dragunov_upgraded_zm", false);
  include_weapon("l96a1_zm");
  include_weapon("l96a1_upgraded_zm", false);
  include_weapon("rpk_zm");
  include_weapon("rpk_upgraded_zm", false);
  include_weapon("hk21_zm");
  include_weapon("hk21_upgraded_zm", false);
  include_weapon("m72_law_zm");
  include_weapon("m72_law_upgraded_zm", false);
  include_weapon("china_lake_zm");
  include_weapon("china_lake_upgraded_zm", false);
  include_weapon("ray_gun_zm");
  include_weapon("ray_gun_upgraded_zm", false);
  include_weapon("crossbow_explosive_zm");
  include_weapon("crossbow_explosive_upgraded_zm", false);
  include_weapon("humangun_zm", true, false);
  include_weapon("humangun_upgraded_zm", false);
  include_weapon("sniper_explosive_zm", true);
  include_weapon("sniper_explosive_upgraded_zm", false);
  include_weapon("zombie_nesting_dolls", true, false);
  include_weapon("knife_ballistic_zm", true);
  include_weapon("knife_ballistic_upgraded_zm", false);
  include_weapon("knife_ballistic_sickle_zm", false);
  include_weapon("knife_ballistic_sickle_upgraded_zm", false);
  level._uses_retrievable_ballisitic_knives = true;
  maps\_zombiemode_weapons::add_limited_weapon("m1911_zm", 0);
  maps\_zombiemode_weapons::add_limited_weapon("humangun_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("sniper_explosive_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("crossbow_explosive_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("knife_ballistic_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("zombie_nesting_dolls", 1);
  precacheItem("explosive_bolt_zm");
  precacheItem("explosive_bolt_upgraded_zm");
  precacheItem("sniper_explosive_bolt_zm");
  precacheItem("sniper_explosive_bolt_upgraded_zm");
  level.collector_achievement_weapons = array_add(level.collector_achievement_weapons, "sickle_knife_zm");
}

coast_director_should_drop_special_powerup() {
  return maps\_zombiemode::is_sidequest_previously_completed();
}

coast_offhand_weapon_overrride() {
  register_lethal_grenade_for_level("frag_grenade_zm");
  register_lethal_grenade_for_level("sticky_grenade_zm");
  level.zombie_lethal_grenade_player_init = "frag_grenade_zm";
  register_tactical_grenade_for_level("zombie_nesting_dolls");
  level.zombie_tactical_grenade_player_init = undefined;
  register_placeable_mine_for_level("claymore_zm");
  level.zombie_placeable_mine_player_init = undefined;
  register_melee_weapon_for_level("knife_zm");
  register_melee_weapon_for_level("sickle_knife_zm");
  level.zombie_melee_weapon_player_init = "knife_zm";
}

coast_offhand_weapon_give_override(str_weapon) {
  self endon("death");
  if(is_tactical_grenade(str_weapon) && isDefined(self get_player_tactical_grenade()) && !self is_player_tactical_grenade(str_weapon)) {
    self SetWeaponAmmoClip(self get_player_tactical_grenade(), 0);
    self TakeWeapon(self get_player_tactical_grenade());
  }
  if(str_weapon == "zombie_nesting_dolls") {
    self maps\_zombiemode_weap_nesting_dolls::player_give_nesting_dolls();
    return true;
  }
  return false;
}

zombie_coast_player_intersection_tracker_override(other_player) {
  if(is_true(self._being_flung) || is_true(self.is_ziplining)) {
    return true;
  }
  if(is_true(other_player._being_flung) || is_true(other_player.is_ziplining)) {
    return true;
  }
  return false;
}

zombie_coast_player_damage_level_override(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  if(is_true(self._being_flung) || is_true(self.is_ziplining)) {
    return 0;
  }
  return -1;
}

include_powerups() {
  include_powerup("nuke");
  include_powerup("insta_kill");
  include_powerup("double_points");
  include_powerup("full_ammo");
  include_powerup("carpenter");
  include_powerup("fire_sale");
  PreCacheItem("minigun_zm");
  include_powerup("minigun");
  PreCacheItem("tesla_gun_zm");
  include_powerup("tesla");
  include_powerup("free_perk");
}

init_sounds() {
  maps\_zombiemode_utility::add_sound("break_stone", "break_stone");
  maps\_zombiemode_utility::add_sound("lighthouse_double_door", "zmb_lighthouse_double_door");
  maps\_zombiemode_utility::add_sound("ship_door", "zmb_ship_door");
  maps\_zombiemode_utility::add_sound("ship_container_door", "zmb_ship_container_door");
}

electric_switch() {
  trig = getEnt("use_elec_switch", "targetname");
  trig sethintstring(&"ZOMBIE_ELECTRIC_SWITCH");
  trig setcursorhint("HINT_NOICON");
  level thread wait_for_power();
  trig waittill("trigger", user);
  trig delete();
  flag_set("power_on");
  Objective_State(8, "done");
}

wait_for_power() {
  master_switch = getEnt("elec_switch", "targetname");
  master_switch notsolid();
  flag_wait("power_on");
  master_switch rotateroll(-90, .3);
  master_switch playSound("zmb_switch_flip");
  level notify("revive_on");
  wait_network_frame();
  level notify("juggernog_on");
  wait_network_frame();
  level notify("sleight_on");
  wait_network_frame();
  level notify("doubletap_on");
  wait_network_frame();
  level notify("divetonuke_on");
  wait_network_frame();
  level notify("marathon_on");
  wait_network_frame();
  level notify("deadshot_on");
  wait_network_frame();
  level notify("Pack_A_Punch_on");
  wait_network_frame();
  level notify("electric_door");
  clientnotify("ZPO");
  master_switch waittill("rotatedone");
  playFX(level._effect["switch_sparks"], getstruct("elec_switch_fx", "targetname").origin);
  master_switch playSound("zmb_turn_on");
}

electric_door_function() {
  door_trigs = getEntArray("electric_door", "script_noteworthy");
  array_thread(door_trigs, ::set_door_unusable);
  array_thread(door_trigs, ::play_door_dialog);
  level waittill("electric_door");
  array_thread(door_trigs, ::trigger_off);
  thread open_electric_doors(door_trigs);
}

set_door_unusable() {
  self sethintstring(&"ZOMBIE_NEED_POWER");
  self UseTriggerRequireLookAt();
}

open_electric_doors(door_trigs) {
  time = 1;
  for(i = 0; i < door_trigs.size; i++) {
    doors = getEntArray(door_trigs[i].target, "targetname");
    for(j = 0; j < doors.size; j++) {
      doors[j] NotSolid();
      time = 1;
      if(isDefined(doors[j].script_transition_time)) {
        time = doors[j].script_transition_time;
      }
      doors[j] connectpaths();
      if(door_trigs[i].type == "rotate") {
        doors[j] NotSolid();
        time = 1;
        if(isDefined(doors[j].script_transition_time)) {
          time = doors[j].script_transition_time;
        }
        play_sound_at_pos("door_rotate_open", doors[j].origin);
        doors[j] RotateTo(doors[j].script_angles, time, 0, 0);
        doors[j] thread maps\_zombiemode_blockers::door_solid_thread();
        doors[j] playSound("door_slide_open");
      } else if(door_trigs[i].type == "move" || door_trigs[i].type == "slide_apart") {
        doors[j] NotSolid();
        time = 1;
        if(isDefined(doors[j].script_transition_time)) {
          time = doors[j].script_transition_time;
        }
        play_sound_at_pos("door_slide_open", doors[j].origin);
        doors[j] moveTo(doors[j].origin + doors[j].script_vector, time, time * 0.25, time * 0.25);
        doors[j] thread maps\_zombiemode_blockers::door_solid_thread();
        doors[j] playSound("door_slide_open");
      }
      wait(randomfloat(.15));
    }
  }
}

play_door_dialog() {
  self endon("warning_dialog");
  timer = 0;
  while(1) {
    wait(0.05);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      dist = distancesquared(players[i].origin, self.origin);
      if(dist > 70 * 70) {
        timer = 0;
        continue;
      }
      while(dist < 70 * 70 && timer < 3) {
        wait(0.5);
        timer++;
      }
      if(dist > 70 * 70 && timer >= 3) {
        self playSound("door_deny");
        players[i] thread do_player_vo("vox_start", 5);
        wait(3);
        self notify("warning_dialog");
      }
    }
  }
}

check_plankB(from, forward) {
  trigger = getEnt(from, "targetname");
  trigger sethintstring(&"ZOMBIE_BUILD_BRIDGE");
  trigger setcursorhint("HINT_NOICON");
  trigger endon("plankB_done");
  user = undefined;
  done = false;
  while(!done) {
    trigger waittill("trigger", user);
    if(is_player_valid(user) && user.score >= level.plankB_cost) {
      user maps\_zombiemode_score::minus_to_player_score(level.plankB_cost);
      other = getEnt(trigger.target, "targetname");
      other notify("plankB_done");
      other delete();
      trigger delete();
      clip = getEnt("plankB_clip", "targetname");
      clip connectpaths();
      clip delete();
      if(forward == true) {
        for(i = 1; i <= 4; i++) {
          bridge = getEnt("residence2ship_walk" + i, "targetname");
          bridge show();
          wait(0.5);
        }
      } else {
        for(i = 4; i >= 1; i--) {
          bridge = getEnt("residence2ship_walk" + i, "targetname");
          bridge show();
          wait(0.5);
        }
      }
      done = true;
      flag_set("plankB_enter");
    }
    wait(.05);
  }
}

wait_for_respawn() {
  zone_name = self.script_noteworthy;
  if(isDefined(level.zones[zone_name])) {
    while(!level.zones[zone_name].is_enabled) {
      wait(0.5);
    }
    self.locked = false;
  }
}

stairs_blocker_buyable() {
  trigger = getEntArray("buyable_stairs", "targetname");
  for(i = 0; i < trigger.size; i++) {
    trigger[i] thread stairs_init();
  }
}

stairs_init() {
  cost = 1000;
  if(isDefined(self.zombie_cost)) {
    cost = self.zombie_cost;
  }
  self set_hint_string(self, "default_buy_debris_" + cost);
  self SetCursorHint("HINT_NOICON");
  if(isDefined(self.script_flag) && !isDefined(level.flag[self.script_flag])) {
    flag_init(self.script_flag);
  }
  self UseTriggerRequireLookAt();
  clip = undefined;
  debris = undefined;
  planks = getEntArray(self.target, "targetname");
  for(i = 0; i < planks.size; i++) {
    if(isDefined(planks[i].script_noteworthy)) {
      if(planks[i].script_noteworthy == "clip") {
        clip = planks[i];
        planks = array_remove(planks, clip);
        i--;
        continue;
      } else if(planks[i].script_noteworthy == "debris_blocker") {
        debris = planks[i];
        planks = array_remove(planks, debris);
        i--;
        continue;
      } else {}
    }
  }
  wait_network_frame();
  self thread stairs_think(planks, debris, clip);
}

stairs_think(planks, debris, clip) {
  while(1) {
    self waittill("trigger", who);
    if(!who UseButtonPressed()) {
      continue;
    }
    if(who in_revive_trigger()) {
      continue;
    }
    if(is_player_valid(who)) {
      if(who.score >= self.zombie_cost) {
        who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
        bbPrint("zombie_uses: playername %s playerscore %d round %d cost %d name %s x %f y %f z %f type debris", who.playername, who.score, level.round_number, self.zombie_cost, self.target, self.origin);
        if(isDefined(self.script_flag)) {
          flag_set(self.script_flag);
        }
        play_sound_at_pos("purchase", self.origin);
        level notify("junk purchased");
        level.stairs_pieces = 0;
        self set_hint_string(self, "");
        if(isDefined(debris.script_linkTo)) {
          debris_struct = getstruct(debris.script_linkTo, "script_linkname");
          if(isDefined(debris_struct)) {
            debris thread special_debris_move(debris_struct);
          }
        }
        if(isDefined(clip)) {
          clip moveTo(clip.origin + (0, 0, -1000), 0.1);
          wait(0.1);
          clip connectpaths();
          clip delete();
        }
        self delete();
      } else {
        play_sound_at_pos("no_purchase", self.origin);
      }
    }
  }
}

stairs_move(struct, planks, trigger) {
  self script_delay();
  self notsolid();
  selfpos = self.origin;
  selfang = self.angles;
  self moveTo(struct.origin, 0.1);
  wait(randomfloatrange(1.0, 10.0));
  self show();
  self play_sound_on_ent("debris_move");
  playsoundatposition("lightning_l", self.origin);
  if(isDefined(self.script_firefx)) {
    playFX(level._effect[self.script_firefx], self.origin);
  }
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "jiggle") {
      num = RandomIntRange(3, 5);
      og_angles = self.angles;
      for(i = 0; i < num; i++) {
        angles = og_angles + (-5 + RandomFloat(10), -5 + RandomFloat(10), -5 + RandomFloat(10));
        time = RandomFloatRange(0.1, 0.4);
        self Rotateto(angles, time);
        wait(time - 0.05);
      }
    }
  }
  time = 0.5;
  if(isDefined(self.script_transition_time)) {
    time = self.script_transition_time;
  }
  self moveTo(selfpos, time, time * 0.5);
  self RotateTo(selfang, time * 0.75);
  self waittill("movedone");
  level.stairs_pieces++;
  if(level.stairs_pieces >= planks.size) {
    trigger notify("stairs_complete");
  }
  if(isDefined(self.script_fxid)) {
    playFX(level._effect[self.script_fxid], self.origin);
    playsoundatposition("zombie_spawn", self.origin);
  }
}

special_debris_move(struct) {
  self script_delay();
  self notsolid();
  self play_sound_on_ent("debris_move");
  playsoundatposition("lightning_l", self.origin);
  if(isDefined(self.script_firefx)) {
    playFX(level._effect[self.script_firefx], self.origin);
  }
  num = RandomIntRange(3, 5);
  og_angles = self.angles;
  for(i = 0; i < num; i++) {
    angles = og_angles + (-5 + RandomFloat(10), -5 + RandomFloat(10), -5 + RandomFloat(10));
    time = RandomFloatRange(0.1, 0.4);
    self Rotateto(angles, time);
    wait(time - 0.05);
  }
  time = 0.5;
  self moveTo(struct.origin, time, time * 0.5);
  self RotateTo(struct.angles, time * 0.75);
  self waittill("movedone");
  if(isDefined(self.script_fxid)) {
    playFX(level._effect[self.script_fxid], self.origin);
    playsoundatposition("zombie_spawn", self.origin);
  }
  self Delete();
}

coast_precache_custom_models() {
  mptype\player_t5_zm_coast::precache();
}

coast_custom_third_person_override(entity_num) {
  if(isDefined(self.zm_random_char)) {
    entity_num = self.zm_random_char;
  }
  switch (entity_num) {
    case 0:
      character\c_zom_sarah_michelle_gellar_player::main();
      break;
    case 1:
      character\c_zom_robert_englund_player::main();
      break;
    case 2:
      character\c_zom_danny_trejo_player::main();
      break;
    case 3:
      character\c_zom_michael_rooker_player::main();
      break;
  }
}

coast_custom_viewmodel_override(entity_num) {
  switch (self.entity_num) {
    case 0:
      self SetViewModel("viewmodel_zom_gellar_arms");
      break;
    case 1:
      self SetViewModel("viewmodel_zom_englund_arms");
      break;
    case 2:
      self SetViewModel("viewmodel_zom_trejo_arms");
      break;
    case 3:
      self SetViewModel("viewmodel_zom_rooker_arms");
      break;
  }
}

setup_water_physics() {
  flag_wait("all_players_connected");
  players = GetPlayers();
  for(i = 0; i < players.size; i++) {
    players[i] SetClientDvars("phys_buoyancy", 1);
  }
}

setup_zcoast_water() {
  SetDvar("r_waterWaveAngle", "0 45 90 180");
  SetDvar("r_waterWaveWavelength", "350 150 450 650");
  SetDvar("r_waterWaveAmplitude", "6 4 8 2");
  SetDvar("r_waterWavePhase", "0 0 0 0");
  SetDvar("r_waterWaveSteepness", "0.25 0.25 0.25 0.25");
  SetDvar("r_waterWaveSpeed", "1 0.5 1 0.5");
}

coast_fade_in_notify() {
  level waittill("fade_in_complete");
  wait_network_frame();
  level ClientNotify("ZID");
}

coast_power_on_lighthouse_react() {
  flag_wait("power_on");
  exploder(301);
}

rock_wall_barricade() {
  rock_wall = getstruct("special_rock_wall", "script_noteworthy");
  boards = getEntArray(rock_wall.target, "targetname");
  rock = undefined;
  for(i = 0; i < boards.size; i++) {
    if(isDefined(boards[i].target)) {
      rock = getEnt(boards[i].target, "targetname");
      if(isDefined(rock)) {
        rock LinkTo(boards[i]);
      }
    }
  }
}

coast_revive_solo_fx() {
  vending_triggers = getEntArray("zombie_vending", "targetname");
  for(i = 0; i < vending_triggers.size; i++) {
    if(vending_triggers[i].script_noteworthy == "specialty_quickrevive") {
      vending_triggers[i] delete();
      break;
    }
  }
}

func_humangun_check() {
  self notify("stop_melee_watch");
  if(is_true(self.electrified)) {
    maps\_zombiemode_ai_director::zombie_clear_electric_buff();
  }
}

check_for_alternate_poi() {
  if(!is_true(self.following_human_zombie) && !is_true(self.following_player_zipline)) {
    return false;
  }
  return true;
}

#using_animtree("fxanim_props_dlc3");
init_fx_anims() {
  level.fxanims = [];
  level.fxanims["hook_anim"] = % fxanim_zom_ship_crane01_hook_anim;
  level.fxanims["boat_anim"] = % fxanim_zom_ship_lifeboat_anim;
}

zombie_coast_poi_positioning_func(origin, forward) {
  return maps\_zombiemode_server_throttle::server_safe_ground_trace_ignore_water("poi_trace", 10, self.origin + forward + (0, 0, 10));
}