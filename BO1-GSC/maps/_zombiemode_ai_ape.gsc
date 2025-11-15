/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_ai_ape.gsc
***************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;

init() {
  PrecacheRumble("explosion_generic");
  init_ape_zombie_anims();
  init_ape_powerup_drops();
  level._effect["ape_groundhit"] = loadfx("maps/zombie/fx_zombie_ape_grnd_hit");
  level._effect["ape_spawn"] = loadfx("maps/zombie/fx_zombie_ape_spawn_dust");
  level._effect["ape_impact"] = loadfx("maps/zombie/fx_zombie_flesh_hit_ape");
  level._effect["ape_trail"] = loadfx("maps/zombie/fx_zombie_ape_spawn_trail");
  if(!isDefined(level.ape_zombie_spawn_heuristic)) {
    level.ape_zombie_spawn_heuristic = maps\_zombiemode_ai_ape::ape_zombie_default_spawn_heuristic;
  }
  if(!isDefined(level.ape_zombie_pathfind_heuristic)) {
    level.ape_zombie_pathfind_heuristic = maps\_zombiemode_ai_ape::ape_zombie_default_pathfind_heuristic;
  }
  if(!isDefined(level.ape_zombie_enter_level)) {
    level.ape_zombie_enter_level = maps\_zombiemode_ai_ape::ape_zombie_default_enter_level;
  }
  if(!isDefined(level.ape_zombie_activation)) {
    level.ape_zombie_activation = ::ape_zombie_check_for_activation;
  }
  precacheshellshock("electrocution");
  level.ape_idle_nodes = GetNodeArray("boss_idle", "script_noteworthy");
  level.num_ape_zombies = 0;
  level.ape_zombie_spawners = getEntArray("boss_zombie_spawner", "targetname");
  array_thread(level.ape_zombie_spawners, ::add_spawn_function, maps\_zombiemode_ai_ape::ape_prespawn);
  if(!isDefined(level.max_ape_zombies)) {
    level.max_ape_zombies = 1;
  }
  if(!isDefined(level.ape_respawn_timer)) {
    level.ape_respawn_timer = 30;
  }
  if(!isDefined(level.ape_zombie_health_mult)) {
    level.ape_zombie_health_mult = 7;
  }
  if(!isDefined(level.ape_zombie_damage_mult)) {
    level.ape_zombie_damage_mult = 2;
  }
  if(!isDefined(level.ape_zombie_min_health)) {
    level.ape_zombie_min_health = 10000;
  }
  if(!isDefined(level.ape_zombie_scream_a_chance)) {
    level.ape_zombie_scream_a_chance = 100;
  }
  if(!isDefined(level.ape_zombie_scream_a_radius)) {
    level.ape_zombie_scream_a_radius_sq = 512 * 512;
  }
  if(!isDefined(level.ape_zombie_scream_b_chance)) {
    level.ape_zombie_scream_b_chance = 0;
  }
  if(!isDefined(level.ape_zombie_scream_b_radius)) {
    level.ape_zombie_scream_b_radius_sq = 512 * 512;
  }
  if(!isDefined(level.ape_zombie_groundhit_damage)) {
    level.ape_zombie_groundhit_damage = 100;
  }
  if(!isDefined(level.ape_zombie_groundhit_trigger_radius)) {
    level.ape_zombie_groundhit_trigger_radius = 96;
  }
  if(!isDefined(level.ape_zombie_groundhit_damage_radius)) {
    level.ape_zombie_groundhit_damage_radius = 280;
  }
  if(!isDefined(level.ape_zombie_proximity_wake)) {
    level.ape_zombie_proximity_wake = 48;
  }
  if(!isDefined(level.ape_thundergun_damage)) {
    level.ape_thundergun_damage = 250;
  }
  if(!isDefined(level.ape_fire_damage)) {
    level.ape_fire_damage = 500;
  }
  if(!isDefined(level.ape_ground_attack_delay)) {
    level.ape_ground_attack_delay = 5000;
  }
  if(!isDefined(level.ape_tesla_damage)) {
    level.ape_tesla_damage = 1000;
  }
  firstSpawners = getEntArray("first_boss_spawner", "script_noteworthy");
  if(isDefined(firstSpawners) && firstSpawners.size > 0) {
    if(firstSpawners.size > level.max_ape_zombies) {
      chosenSpawners = [];
      while(chosenSpawners.size < level.max_ape_zombies) {
        index = randomInt(firstSpawners.size);
        if(firstSpawners[index].script_string == "boss") {
          chosenSpawners = array_add(chosenSpawners, firstSpawners[index]);
        }
        firstSpawners = array_remove(firstSpawners, firstSpawners[index]);
      }
    } else {
      chosenSpawners = firstSpawners;
    }
    for(i = 0; i < chosenSpawners.size; i++) {
      chosenSpawners[i] ape_zombie_spawn();
    }
  }
  level thread ape_zombie_update_proximity_wake();
  level.ammo_spawn = true;
  level.ape_death = 0;
  level.ape_death_ammo = 2;
  level.ape_death_total = 0;
  level.ape_health_reduce = 0.7;
  level.ape_intermission = false;
  flag_init("ape_round");
  flag_clear("ape_round");
  flag_init("tgun_react");
  flag_clear("tgun_react");
  flag_init("last_ape_down");
  flag_clear("last_ape_down");
  level thread ape_adjust_max_ammo();
  level thread ape_round_tracker();
}

#using_animtree("generic_human");
ape_prespawn() {
  self.animname = "ape_zombie";
  self.custom_idle_setup = maps\_zombiemode_ai_ape::ape_zombie_idle_setup;
  self.damage_mult = level.ape_zombie_damage_mult;
  self.a.idleAnimOverrideArray = [];
  self.a.idleAnimOverrideArray["stand"] = [];
  self.a.idleAnimOverrideWeights["stand"] = [];
  self.a.idleAnimOverrideArray["stand"][0][0] = % ai_zombie_simianaut_idle;
  self.a.idleAnimOverrideWeights["stand"][0][0] = 10;
  self.a.idleAnimOverrideArray["stand"][0][1] = % ai_zombie_simianaut_idle;
  self.a.idleAnimOverrideWeights["stand"][0][1] = 10;
  rand = randomIntRange(1, 5);
  self.deathanim = level.scr_anim["ape_zombie"]["death" + rand];
  self.ignorelocationaldamage = true;
  self.ignoreall = true;
  self.allowdeath = true;
  self.is_zombie = true;
  self.has_legs = true;
  self allowedStances("stand");
  self.gibbed = false;
  self.head_gibbed = false;
  self.disableArrivals = true;
  self.disableExits = true;
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoreSuppression = true;
  self.suppressionThreshold = 1;
  self.noDodgeMove = true;
  self.dontShootWhileMoving = true;
  self.pathenemylookahead = 0;
  self.badplaceawareness = 0;
  self.chatInitialized = false;
  self.a.disablePain = true;
  self disable_react();
  if(isDefined(level.user_ryan_ape)) {
    self thread maps\_zombiemode_ai_ape::ape_health_watch();
  }
  self.freezegun_damage = 0;
  self.dropweapon = false;
  self thread maps\_zombiemode_spawner::zombie_damage_failsafe();
  self thread maps\_zombiemode_spawner::delayed_zombie_eye_glow();
  self.flame_damage_time = 0;
  self.meleeDamage = 50;
  self.no_powerups = true;
  self thread maps\_zombiemode_ai_ape::ape_set_airstrike_damage();
  self.thundergun_disintegrate_func = ::ape_thundergun_disintegrate;
  self.thundergun_fling_func = ::ape_thundergun_disintegrate;
  self.fire_damage_func = ::ape_fire_damage;
  self.custom_damage_func = ::ape_custom_damage;
  self.actor_damage_func = ::ape_actor_damage;
  self.nuke_damage_func = ::ape_nuke_damage;
  self.tesla_damage_func = ::ape_tesla_damage;
  self.dog_damage_func = ::ape_dog_damage;
  self.zombie_damage_fx_func = ::ape_zombie_damage_fx;
  self.non_attacker_func = ::ape_non_attacker;
  self.entered_level = false;
  self.chest_beat = false;
  self.restart = 0;
  self.speed_up = 0;
  self setPhysParams(24, 0, 36);
  self setTeamForEntity("axis");
  self notify("zombie_init_done");
}

ape_health_watch() {
  self endon("death");
  while(1) {
    wait(1);
  }
}

ape_set_airstrike_damage() {
  flag_wait("all_players_connected");
  players = GetPlayers();
  if(players.size == 4) {
    self.maxAirstrikeDamage = 125;
  } else {
    self.maxAirstrikeDamage = 100;
  }
}

ape_zombie_idle_setup() {
  self.a.array["turn_left_45"] = % exposed_tracking_turn45L;
  self.a.array["turn_left_90"] = % exposed_tracking_turn90L;
  self.a.array["turn_left_135"] = % exposed_tracking_turn135L;
  self.a.array["turn_left_180"] = % exposed_tracking_turn180L;
  self.a.array["turn_right_45"] = % exposed_tracking_turn45R;
  self.a.array["turn_right_90"] = % exposed_tracking_turn90R;
  self.a.array["turn_right_135"] = % exposed_tracking_turn135R;
  self.a.array["turn_right_180"] = % exposed_tracking_turn180L;
  self.a.array["exposed_idle"] = array( % ai_zombie_simianaut_idle, % ai_zombie_simianaut_idle);
  self.a.array["straight_level"] = % ai_zombie_simianaut_idle;
  self.a.array["stand_2_crouch"] = % ai_zombie_shot_leg_right_2_crawl;
}

init_ape_zombie_anims() {
  level.scr_anim["ape_zombie"]["death1"] = % ai_zombie_boss_death;
  level.scr_anim["ape_zombie"]["death2"] = % ai_zombie_boss_death_a;
  level.scr_anim["ape_zombie"]["death3"] = % ai_zombie_boss_death_explode;
  level.scr_anim["ape_zombie"]["death4"] = % ai_zombie_boss_death_mg;
  level.scr_anim["ape_zombie"]["walk1"] = % ai_zombie_simianaut_walk;
  level.scr_anim["ape_zombie"]["walk2"] = % ai_zombie_simianaut_walk;
  level.scr_anim["ape_zombie"]["walk3"] = % ai_zombie_simianaut_walk;
  level.scr_anim["ape_zombie"]["walk4"] = % ai_zombie_simianaut_walk;
  level.scr_anim["ape_zombie"]["walk5"] = % ai_zombie_simianaut_walk;
  level.scr_anim["ape_zombie"]["walk6"] = % ai_zombie_simianaut_walk;
  level.scr_anim["ape_zombie"]["walk7"] = % ai_zombie_simianaut_walk;
  level.scr_anim["ape_zombie"]["walk8"] = % ai_zombie_simianaut_walk;
  level.scr_anim["ape_zombie"]["run1"] = % ai_zombie_walk_fast_v1;
  level.scr_anim["ape_zombie"]["run2"] = % ai_zombie_walk_fast_v2;
  level.scr_anim["ape_zombie"]["run3"] = % ai_zombie_walk_fast_v3;
  level.scr_anim["ape_zombie"]["run4"] = % ai_zombie_run_v2;
  level.scr_anim["ape_zombie"]["run5"] = % ai_zombie_run_v4;
  level.scr_anim["ape_zombie"]["run6"] = % ai_zombie_run_v3;
  level.scr_anim["ape_zombie"]["sprint1"] = % ai_zombie_simianaut_run_man;
  level.scr_anim["ape_zombie"]["sprint2"] = % ai_zombie_simianaut_run_side;
  level.scr_anim["ape_zombie"]["sprint3"] = % ai_zombie_simianaut_run;
  level.scr_anim["ape_zombie"]["sprint4"] = % ai_zombie_simianaut_run_fast;
  level.scr_anim["ape_zombie"]["wounded1"] = % ai_zombie_simianaut_run_wounded;
  level.scr_anim["ape_zombie"]["crawl1"] = % ai_zombie_crawl;
  level.scr_anim["ape_zombie"]["crawl2"] = % ai_zombie_crawl_v1;
  level.scr_anim["ape_zombie"]["crawl3"] = % ai_zombie_crawl_v2;
  level.scr_anim["ape_zombie"]["crawl4"] = % ai_zombie_crawl_v3;
  level.scr_anim["ape_zombie"]["crawl5"] = % ai_zombie_crawl_v4;
  level.scr_anim["ape_zombie"]["crawl6"] = % ai_zombie_crawl_v5;
  level.scr_anim["ape_zombie"]["crawl_hand_1"] = % ai_zombie_walk_on_hands_a;
  level.scr_anim["ape_zombie"]["crawl_hand_2"] = % ai_zombie_walk_on_hands_b;
  level.scr_anim["ape_zombie"]["crawl_sprint1"] = % ai_zombie_crawl_sprint;
  level.scr_anim["ape_zombie"]["crawl_sprint2"] = % ai_zombie_crawl_sprint_1;
  level.scr_anim["ape_zombie"]["crawl_sprint3"] = % ai_zombie_crawl_sprint_2;
  if(!isDefined(level._zombie_melee)) {
    level._zombie_melee = [];
  }
  if(!isDefined(level._zombie_walk_melee)) {
    level._zombie_walk_melee = [];
  }
  if(!isDefined(level._zombie_run_melee)) {
    level._zombie_run_melee = [];
  }
  level._zombie_melee["ape_zombie"] = [];
  level._zombie_walk_melee["ape_zombie"] = [];
  level._zombie_run_melee["ape_zombie"] = [];
  level._zombie_melee["ape_zombie"][0] = % ai_semianaut_attack_v1;
  level._zombie_melee["ape_zombie"][1] = % ai_semianaut_attack_v1;
  level._zombie_melee["ape_zombie"][2] = % ai_semianaut_attack_v1;
  level._zombie_melee["ape_zombie"][3] = % ai_semianaut_attack_v1;
  level._zombie_melee["ape_zombie"][3] = % ai_semianaut_attack_v1;
  if(isDefined(level.ape_zombie_anim_override)) {
    [[level.ape_zombie_anim_override]]();
  }
  level._zombie_run_melee["ape_zombie"][0] = % ai_semianaut_attack_v1;
  level._zombie_run_melee["ape_zombie"][1] = % ai_semianaut_attack_v1;
  level._zombie_run_melee["ape_zombie"][2] = % ai_semianaut_attack_v1;
  if(!isDefined(level._zombie_melee_crawl)) {
    level._zombie_melee_crawl = [];
  }
  level._zombie_melee_crawl["ape_zombie"] = [];
  level._zombie_melee_crawl["ape_zombie"][0] = % ai_zombie_attack_crawl;
  level._zombie_melee_crawl["ape_zombie"][1] = % ai_zombie_attack_crawl_lunge;
  if(!isDefined(level._zombie_stumpy_melee)) {
    level._zombie_stumpy_melee = [];
  }
  level._zombie_stumpy_melee["ape_zombie"] = [];
  level._ape_zombie_stumpy_melee["ape_zombie"][0] = % ai_zombie_walk_on_hands_shot_a;
  level._ape_zombie_stumpy_melee["ape_zombie"][1] = % ai_zombie_walk_on_hands_shot_b;
  if(!isDefined(level._zombie_tesla_deaths)) {
    level._zombie_tesla_deaths = [];
  }
  level._zombie_tesla_death["ape_zombie"] = [];
  level._zombie_tesla_death["ape_zombie"][0] = % ai_zombie_boss_tesla_death_a;
  level._zombie_tesla_death["ape_zombie"][1] = % ai_zombie_boss_tesla_death_a;
  level._zombie_tesla_death["ape_zombie"][2] = % ai_zombie_boss_tesla_death_a;
  level._zombie_tesla_death["ape_zombie"][3] = % ai_zombie_boss_tesla_death_a;
  level._zombie_tesla_death["ape_zombie"][4] = % ai_zombie_boss_tesla_death_a;
  if(!isDefined(level._zombie_tesla_crawl_death)) {
    level._zombie_tesla_crawl_death = [];
  }
  level._zombie_tesla_crawl_death["ape_zombie"] = [];
  level._zombie_tesla_crawl_death["ape_zombie"][0] = % ai_zombie_tesla_crawl_death_a;
  level._zombie_tesla_crawl_death["ape_zombie"][1] = % ai_zombie_tesla_crawl_death_b;
  if(!isDefined(level._zombie_deaths)) {
    level._zombie_deaths = [];
  }
  level._zombie_deaths["ape_zombie"] = [];
  level._zombie_deaths["ape_zombie"][0] = % ai_zombie_boss_death;
  level._zombie_deaths["ape_zombie"][1] = % ai_zombie_boss_death_a;
  level._zombie_deaths["ape_zombie"][2] = % ai_zombie_boss_death_explode;
  level._zombie_deaths["ape_zombie"][3] = % ai_zombie_boss_death_mg;
  if(!isDefined(level._zombie_rise_anims)) {
    level._zombie_rise_anims = [];
  }
  level._zombie_rise_anims["ape_zombie"] = [];
  level._zombie_rise_anims["ape_zombie"][1]["walk"][0] = % ai_zombie_traverse_ground_v1_walk;
  level._zombie_rise_anims["ape_zombie"][1]["run"][0] = % ai_zombie_traverse_ground_v1_run;
  level._zombie_rise_anims["ape_zombie"][1]["sprint"][0] = % ai_zombie_traverse_ground_climbout_fast;
  level._zombie_rise_anims["ape_zombie"][2]["walk"][0] = % ai_zombie_traverse_ground_v2_walk_altA;
  if(!isDefined(level._zombie_rise_death_anims)) {
    level._zombie_rise_death_anims = [];
  }
  level._zombie_rise_death_anims["ape_zombie"] = [];
  level._zombie_rise_death_anims["ape_zombie"][1]["in"][0] = % ai_zombie_traverse_ground_v1_deathinside;
  level._zombie_rise_death_anims["ape_zombie"][1]["in"][1] = % ai_zombie_traverse_ground_v1_deathinside_alt;
  level._zombie_rise_death_anims["ape_zombie"][1]["out"][0] = % ai_zombie_traverse_ground_v1_deathoutside;
  level._zombie_rise_death_anims["ape_zombie"][1]["out"][1] = % ai_zombie_traverse_ground_v1_deathoutside_alt;
  level._zombie_rise_death_anims["ape_zombie"][2]["in"][0] = % ai_zombie_traverse_ground_v2_death_low;
  level._zombie_rise_death_anims["ape_zombie"][2]["in"][1] = % ai_zombie_traverse_ground_v2_death_low_alt;
  level._zombie_rise_death_anims["ape_zombie"][2]["out"][0] = % ai_zombie_traverse_ground_v2_death_high;
  level._zombie_rise_death_anims["ape_zombie"][2]["out"][1] = % ai_zombie_traverse_ground_v2_death_high_alt;
  if(!isDefined(level._zombie_run_taunt)) {
    level._zombie_run_taunt = [];
  }
  if(!isDefined(level._zombie_board_taunt)) {
    level._zombie_board_taunt = [];
  }
  level._zombie_run_taunt["ape_zombie"] = [];
  level._zombie_board_taunt["ape_zombie"] = [];
  level._zombie_board_taunt["ape_zombie"][0] = % ai_zombie_taunts_4;
  level._zombie_board_taunt["ape_zombie"][1] = % ai_zombie_taunts_7;
  level._zombie_board_taunt["ape_zombie"][2] = % ai_zombie_taunts_9;
  level._zombie_board_taunt["ape_zombie"][3] = % ai_zombie_taunts_5b;
  level._zombie_board_taunt["ape_zombie"][4] = % ai_zombie_taunts_5c;
  level._zombie_board_taunt["ape_zombie"][5] = % ai_zombie_taunts_5d;
  level._zombie_board_taunt["ape_zombie"][6] = % ai_zombie_taunts_5e;
  level._zombie_board_taunt["ape_zombie"][7] = % ai_zombie_taunts_5f;
}

init_ape_powerup_drops() {
  level.ape_powerup_array = [];
  if(!isDefined(level.zombie_powerup_array)) {
    return;
  }
  for(i = 0; i < level.zombie_powerup_array.size; i++) {
    powerup = level.zombie_powerup_array[i];
    if(level.zombie_include_powerups[powerup]) {
      if(powerup != "full_ammo") {
        level.ape_powerup_array[level.ape_powerup_array.size] = powerup;
      }
    }
  }
  level.ape_powerup_array = array_randomize(level.ape_powerup_array);
  level.ape_powerup_index = 0;
}

ape_zombie_spawn() {
  self.script_moveoverride = true;
  if(!isDefined(level.num_ape_zombies)) {
    level.num_ape_zombies = 0;
  }
  level.num_ape_zombies++;
  ape_zombie = self maps\_zombiemode_net::network_safe_stalingrad_spawn("boss_zombie_spawn", 1);
  self.count = 666;
  self.last_spawn_time = GetTime();
  if(!spawn_failed(ape_zombie)) {
    ape_zombie.script_noteworthy = self.script_noteworthy;
    ape_zombie.targetname = self.targetname;
    ape_zombie.target = self.target;
    ape_zombie.deathFunction = maps\_zombiemode_ai_ape::ape_zombie_die;
    ape_zombie.animname = "ape_zombie";
    ape_zombie thread ape_zombie_think();
    if(isDefined(level.ape_zombie_death_pos) && level.ape_zombie_death_pos.size > 0) {
      level.ape_zombie_death_pos = array_remove(level.ape_zombie_death_pos, level.ape_zombie_death_pos[0]);
    }
  } else {
    level.num_ape_zombies--;
  }
}

ape_round_spawning() {
  level endon("intermission");
  level endon("end_of_round");
  level endon("restart_round");
  if(level.intermission) {
    return;
  }
  level.ape_intermission = true;
  level thread ape_round_aftermath();
  max = 1;
  level.zombie_total = max;
  count = 0;
  while(count < max) {
    spawner = ape_zombie_pick_best_spawner();
    if(isDefined(spawner)) {
      spawner ape_zombie_spawn();
      level.zombie_total--;
      count++;
      break;
    }
  }
}

ape_round_wait() {
  wait(1);
  if(flag("ape_round")) {
    wait(7);
    while(level.ape_intermission) {
      wait(0.5);
    }
  }
}

ape_round_aftermath() {
  flag_wait("last_ape_down");
  ape_stop_fog();
  wait(6);
  level.ape_intermission = false;
}

ape_stop_fog() {
  start_dist = 50;
  half_dist = 1209;
  half_height = 442;
  base_height = -925;
  fog_r = 0.88;
  fog_g = 0.92;
  fog_b = 1.1;
  fog_scale = 1;
  sun_col_r = 0;
  sun_col_g = 0;
  sun_col_b = 0;
  sun_dir_x = 0;
  sun_dir_y = 0;
  sun_dir_z = 0;
  sun_start_ang = 0;
  sun_stop_ang = 0;
  time = 3;
  max_fog_opacity = 1;
  clear_fog_threads();
  setVolFog(start_dist, half_dist, half_height, base_height, fog_r, fog_g, fog_b, fog_scale,
    sun_col_r, sun_col_g, sun_col_b, sun_dir_x, sun_dir_y, sun_dir_z, sun_start_ang,
    sun_stop_ang, time, max_fog_opacity);
}

ape_round_tracker() {
  level.ape_save_spawn_func = level.round_spawn_func;
  level.ape_save_wait_func = level.round_wait_func;
  level.next_ape_round = randomintrange(7, 9);
  level.prev_ape_round = level.next_ape_round;
  while(1) {
    level waittill("between_round_over");
    if(level.round_number == level.next_ape_round) {
      level.ape_save_spawn_func = level.round_spawn_func;
      level.ape_save_wait_func = level.round_wait_func;
      ape_round_start();
      level.round_spawn_func = ::ape_round_spawning;
      level.round_wait_func = ::ape_round_wait;
      level.prev_ape_round = level.next_ape_round;
      level.next_ape_round = level.round_number + randomintrange(5, 8);
    } else if(level.prev_ape_round == level.round_number) {
      ape_round_start();
    } else if(flag("ape_round")) {
      ape_round_stop();
    }
  }
}

ape_round_start() {
  flag_set("ape_round");
  if(isDefined(level.ape_round_start)) {
    level thread[[level.ape_round_start]]();
  }
}

ape_round_stop() {
  flag_clear("ape_round");
  flag_clear("last_ape_down");
  if(isDefined(level.ape_round_stop)) {
    level thread[[level.ape_round_stop]]();
  }
}

ape_zombie_manager() {
  start_ape = getEnt("start_boss_spawner", "script_noteworthy");
  if(isDefined(start_ape)) {
    while(true) {
      if(level.num_ape_zombies < level.max_ape_zombies) {
        start_ape ape_zombie_spawn();
        break;
      }
      wait(0.5);
    }
  }
  while(true) {
    AssertEx(isDefined(level.num_ape_zombies) && isDefined(level.max_ape_zombies), "Either max_ape_zombies or num_ape_zombies not defined, this should never be the case!");
    while(level.num_ape_zombies < level.max_ape_zombies) {
      spawner = ape_zombie_pick_best_spawner();
      if(isDefined(spawner)) {
        spawner ape_zombie_spawn();
      }
      wait(10);
    }
    wait(10);
  }
}

ape_zombie_pick_best_spawner() {
  best_spawner = undefined;
  best_score = -1;
  for(i = 0; i < level.ape_zombie_spawners.size; i++) {
    score = [[level.ape_zombie_spawn_heuristic]](level.ape_zombie_spawners[i]);
    if(score > best_score) {
      best_spawner = level.ape_zombie_spawners[i];
      best_score = score;
    }
  }
  return best_spawner;
}

ape_zombie_think() {
  self endon("death");
  self.is_activated = false;
  self.run_index = -1;
  self thread ape_zombie_is_activated();
  self thread ape_zombie_check_player_proximity();
  self thread ape_zombie_choose_run();
  self thread ape_zombie_check_laststand();
  self thread[[level.ape_zombie_activation]]();
  players = getplayers();
  if(players.size > 1) {
    self thread ape_zombie_wait_for_switch();
  }
  self.ignoreall = false;
  self.pathEnemyFightDist = 64;
  self.meleeAttackDist = 64;
  adjusted_health = level.ape_zombie_min_health;
  if(self.maxhealth < adjusted_health) {
    self.maxhealth = level.ape_zombie_min_health;
    self.health = level.ape_zombie_min_health;
  }
  if(isDefined(level.user_ryan_ape_health)) {
    self.maxhealth = 1;
    self.health = 1;
  }
  players = GetPlayers();
  if(players.size == 4) {
    bonus = int(self.health * .5);
    self.maxhealth += bonus;
    self.health += bonus;
  }
  self.maxsightdistsqrd = 96 * 96;
  self.zombie_move_speed = "walk";
  self thread[[level.ape_zombie_enter_level]]();
  if(isDefined(level.ape_zombie_custom_think)) {
    self thread[[level.ape_zombie_custom_think]]();
  }
  while(true) {
    if(!self.entered_level) {
      wait_network_frame();
      continue;
    } else if(isDefined(self.custom_think) && self.custom_think) {
      wait_network_frame();
      continue;
    } else if(isDefined(self.performing_activation) && self.performing_activation) {
      wait_network_frame();
      continue;
    } else if(isDefined(self.ground_hit) && self.ground_hit) {
      wait_network_frame();
      continue;
    } else if(!isDefined(self.following_player) || !self.following_player) {
      self thread maps\_zombiemode_ai_ape::ape_find_flesh();
      self.following_player = true;
    }
    wait(1);
  }
}

ape_zombie_pick_idle_point() {
  best_score = -1;
  best_node = undefined;
  for(i = 0; i < level.ape_idle_nodes.size; i++) {
    score = [[level.ape_zombie_pathfind_heuristic]](level.ape_idle_nodes[i]);
    if(score > best_score) {
      best_score = score;
      best_node = level.ape_idle_nodes[i];
    }
  }
  return best_node;
}

ape_zombie_default_pathfind_heuristic(node) {
  if(!isDefined(node.targetname) || !isDefined(level.zones[node.targetname])) {
    return -1;
  }
  if(isDefined(node.is_claimed) && node.is_claimed && (!isDefined(self.curr_idle_node) || self.curr_idle_node != node)) {
    return -1;
  }
  players = get_players();
  score = 0;
  for(i = 0; i < players.size; i++) {
    dist = distanceSquared(node.origin, players[i].origin);
    if(dist > 10000 * 10000) {
      dist = 10000 * 10000;
    }
    if(dist <= 1) {
      score += 10000 * 10000;
      continue;
    }
    score += int(10000 * 10000 / dist);
  }
  return score;
}

ape_zombie_default_spawn_heuristic(spawner) {
  if(isDefined(spawner.last_spawn_time) && (GetTime() - spawner.last_spawn_time < 30000)) {
    return -1;
  }
  if(!isDefined(spawner.script_noteworthy)) {
    return -1;
  }
  if(spawner.script_noteworthy != "first_boss_spawner" && (!isDefined(level.zones) || !isDefined(level.zones[spawner.script_noteworthy]) || !level.zones[spawner.script_noteworthy].is_enabled)) {
    return -1;
  }
  score = 0;
  if(!isDefined(level.ape_zombie_death_pos) || level.ape_zombie_death_pos.size == 0) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      score = int(distanceSquared(spawner.origin, players[i].origin));
    }
  } else {
    dist = int(distanceSquared(level.ape_zombie_death_pos[0], spawner.origin));
    if(dist > 10000 * 10000) {
      dist = 10000 * 10000;
    }
    if(dist <= 1) {
      dist = 1;
    }
    score = int(10000 * 10000 / dist);
  }
  return score;
}

ape_zombie_choose_run() {
  self endon("death");
  while(true) {
    if(self.is_activated) {
      self.zombie_move_speed = "sprint";
      if(self.speed_up) {
        self set_run_anim("sprint4");
        self.run_combatanim = level.scr_anim["ape_zombie"]["sprint4"];
        self.crouchRunAnim = level.scr_anim["ape_zombie"]["sprint4"];
        self.crouchrun_combatanim = level.scr_anim["ape_zombie"]["sprint4"];
      } else {
        rand = randomIntRange(1, 4);
        if(self.run_index == rand) {
          rand++;
          if(rand >= 4) {
            rand = 1;
          }
        }
        self.run_index = rand;
        self set_run_anim("sprint" + rand);
        self.run_combatanim = level.scr_anim["ape_zombie"]["sprint" + rand];
        self.crouchRunAnim = level.scr_anim["ape_zombie"]["sprint" + rand];
        self.crouchrun_combatanim = level.scr_anim["ape_zombie"]["sprint" + rand];
        rand_f = randomFloatRange(2, 3);
        wait(rand_f);
      }
    } else {
      self.zombie_move_speed = "walk";
      self set_run_anim("walk1");
      self.run_combatanim = level.scr_anim["ape_zombie"]["walk1"];
      self.crouchRunAnim = level.scr_anim["ape_zombie"]["walk1"];
      self.crouchrun_combatanim = level.scr_anim["ape_zombie"]["walk1"];
    }
    wait(0.05);
  }
}

ape_zombie_check_laststand() {
  self endon("death");
  while(!self.entered_level) {
    wait_network_frame();
  }
  while(1) {
    if(isDefined(self.favoriteenemy)) {
      if(self.favoriteenemy maps\_laststand::player_is_in_laststand()) {
        ape_zombie_switch_player(0);
      }
    }
    wait_network_frame();
  }
}

ape_zombie_wait_for_switch() {
  self endon("death");
  self endon("already_switched");
  while(!self.entered_level) {
    wait_network_frame();
  }
  time = RandomFloatRange(15, 30);
  wait(time);
  self.nextGroundHit = GetTime();
  self ape_zombie_switch_player(1);
}

ape_zombie_switch_player(speed_up) {
  players = getplayers();
  if(players.size > 1) {
    self.ignore_player[self.ignore_player.size] = self.favoriteenemy;
    if(self.ignore_player.size >= get_number_of_valid_players()) {
      self.ignore_player = [];
    }
  }
  player = get_closest_valid_player(self.origin, self.ignore_player);
  if(!isDefined(player)) {
    self maps\_zombiemode_spawner::zombie_history("ape find flesh -> can't find player, continue");
    player = players[0];
  }
  self.favoriteenemy = player;
  self.speed_up = speed_up;
  if(speed_up == 0) {
    self notify("already_switched");
  }
}

wait_for_round_over() {
  self endon("stop_managing_health");
  while(true) {
    level waittill("between_round_over");
    self notify("update_health");
    wait(0.05);
  }
}

wait_for_activation() {
  self waittill("ape_activated");
  self notify("update_health");
  self notify("stop_managing_health");
}

ape_zombie_check_player_proximity() {
  self endon("death");
  while(1) {
    if(isDefined(self.performing_activation) && self.performing_activation) {
      break;
    }
    if(isDefined(self.enemy)) {
      dist = distance(self.origin, self.enemy.origin);
      if(dist < level.ape_zombie_proximity_wake) {
        self notify("hit_player");
        break;
      }
    }
    wait_network_frame();
  }
}

ape_zombie_update_proximity_wake() {
  while(!isDefined(level.round_number)) {
    wait(1);
  }
  while(1) {
    if(level.round_number >= 20) {
      level.ape_zombie_proximity_wake = 120;
      break;
    } else if(level.round_number >= 15) {
      level.ape_zombie_proximity_wake = 102;
    } else if(level.round_number >= 10) {
      level.ape_zombie_proximity_wake = 84;
    }
    wait(1);
  }
}

ape_zombie_damage_during_activate() {
  self endon("death");
  self endon("play_activate_done");
  wait(1.6);
  self waittill_either("damage", "hit_player");
  self notify("play_activate_done");
}

ape_zombie_play_activate() {
  self endon("death");
  self endon("play_activate_done");
  self thread ape_zombie_damage_during_activate();
  time = getAnimLength( % ai_zombie_simianaut_chest_beat);
  self SetFlaggedAnimKnobAllRestart("chestbeat_anim", % ai_zombie_simianaut_chest_beat, % body, 1, .1, 1);
  time = time / 1.0;
  wait(time);
  self notify("play_activate_done");
}

ape_zombie_check_for_activation() {
  self endon("death");
  self endon("ape_activated");
  if(self.is_activated == true) {
    if(isDefined(self.curr_idle_node)) {
      self.curr_idle_node.is_claimed = false;
    }
    return;
  }
  while(!self.entered_level) {
    wait_network_frame();
  }
  self waittill_either("damage", "hit_player");
  self notify("stop_find_flesh");
  self.following_player = false;
  self.performing_activation = true;
  self.ground_hit = true;
  self thread scream_a_watcher("groundhit_anim");
  self thread groundhit_watcher("groundhit_anim");
  self playSound("zmb_engineer_vocals_hit");
  self animcustom(::ape_zombie_play_activate);
  self waittill("play_activate_done");
  self.performing_activation = false;
  self.ground_hit = false;
  self.is_activated = true;
  if(isDefined(self.curr_idle_node)) {
    self.curr_idle_node.is_claimed = false;
  }
  self notify("ape_activated");
}

ape_zombie_is_activated() {
  self waittill("ape_activated");
  self thread ape_zombie_ground_hit_think();
  self thread ape_zombie_push_zombies();
}

ape_zombie_ground_hit() {
  self endon("death");
  if(self.ground_hit) {
    return;
  }
  self.ground_hit = true;
  self thread groundhit_watcher("groundhit_anim");
  self animscripted("groundhit_anim", self.origin, self.angles, % ai_zombie_simianaut_ground_pound);
  animscripts\traverse\zombie_shared::wait_anim_length( % ai_zombie_simianaut_ground_pound, .02);
  self.ground_hit = false;
  self.nextGroundHit = GetTime() + level.ape_ground_attack_delay;
  if(self.chest_beat) {
    time = getAnimLength( % ai_zombie_simianaut_taunt);
    self animscripted("taunt_anim", self.origin, self.angles, % ai_zombie_simianaut_taunt);
    wait(time);
    self.chest_beat = false;
  }
  self thread animscripts\zombie_combat::main();
}

ape_zombie_ground_hit_think() {
  self endon("death");
  self.ground_hit = false;
  self.nextGroundHit = GetTime() + level.ape_ground_attack_delay;
  while(1) {
    if(!self.ground_hit && GetTime() >= self.nextGroundHit) {
      players = GetPlayers();
      closeEnough = false;
      origin = self getEye();
      for(i = 0; i < players.size; i++) {
        if(players[i] maps\_laststand::player_is_in_laststand()) {
          continue;
        }
        test_origin = players[i] getEye();
        d = distanceSquared(origin, test_origin);
        if(d > level.ape_zombie_groundhit_trigger_radius * level.ape_zombie_groundhit_trigger_radius) {
          continue;
        }
        if(!BulletTracePassed(origin, test_origin, false, undefined)) {
          continue;
        }
        closeEnough = true;
        break;
      }
      if(closeEnough) {
        self animcustom(::ape_zombie_ground_hit);
      }
    }
    wait_network_frame();
  }
}

scream_a_watcher(animname) {
  self endon("death");
  rand = randomInt(100);
  if(rand > level.ape_zombie_scream_a_chance) {
    return;
  }
  self waittillmatch(animname, "scream_a");
  players = get_players();
  affected_players = [];
  for(i = 0; i < players.size; i++) {
    if(distanceSquared(players[i].origin, self.origin) < level.ape_zombie_scream_a_radius_sq) {
      affected_players = array_add(affected_players, players[i]);
    }
  }
  for(i = 0; i < affected_players.size; i++) {
    affected_players[i] ShellShock("electrocution", 1.5, true);
  }
}

groundhit_watcher(animname) {
  self endon("death");
  self waittillmatch(animname, "fire");
  playFXOnTag(level._effect["ape_groundhit"], self, "tag_origin");
  origin = self.origin + (0, 0, 40);
  zombies_axis = get_array_of_closest(origin, GetAiSpeciesArray("axis", "all"), undefined, undefined, level.ape_zombie_groundhit_damage_radius);
  dogs = get_array_of_closest(origin, GetAiSpeciesArray("allies", "zombie_dog"), undefined, undefined, level.ape_zombie_groundhit_damage_radius);
  zombies = array_combine(zombies_axis, dogs);
  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      if(!isDefined(zombies[i])) {
        continue;
      }
      if(is_magic_bullet_shield_enabled(zombies[i])) {
        continue;
      }
      test_origin = zombies[i] getEye();
      if(!BulletTracePassed(origin, test_origin, false, undefined)) {
        continue;
      }
      if(zombies[i] == self) {
        continue;
      }
      if(zombies[i].animname == "ape_zombie") {
        continue;
      }
      refs = [];
      refs[refs.size] = "guts";
      refs[refs.size] = "right_arm";
      refs[refs.size] = "left_arm";
      refs[refs.size] = "right_leg";
      refs[refs.size] = "left_leg";
      refs[refs.size] = "no_legs";
      refs[refs.size] = "head";
      if(refs.size) {
        zombies[i].a.gib_ref = random(refs);
      }
      zombies[i] DoDamage(zombies[i].health + 666, self.origin, self);
    }
  }
  players = get_players();
  affected_players = [];
  for(i = 0; i < players.size; i++) {
    if(!is_player_valid(players[i])) {
      continue;
    }
    test_origin = players[i] getEye();
    if(distanceSquared(origin, test_origin) > level.ape_zombie_groundhit_damage_radius * level.ape_zombie_groundhit_damage_radius) {
      continue;
    }
    if(!BulletTracePassed(origin, test_origin, false, undefined)) {
      continue;
    }
    affected_players = array_add(affected_players, players[i]);
  }
  self.chest_beat = false;
  for(i = 0; i < affected_players.size; i++) {
    self.chest_beat = true;
    if(players.size > 1) {
      if(i == 0) {
        player = affected_players[i];
        if(player IsOnGround()) {
          player DoDamage(player.health, player.origin, self);
        }
        self.favoriteenemy = player;
        self ape_zombie_switch_player(0);
        self thread ape_zombie_wait_for_switch();
      } else {
        affected_players[i] ShellShock("electrocution", 1.5, true);
      }
    } else {
      if(affected_players[i] IsOnGround()) {
        affected_players[i] ShellShock("electrocution", 1.5, true);
      }
    }
  }
}

scream_b_watcher(animname) {
  self endon("death");
  rand = randomInt(100);
  if(rand > level.ape_zombie_scream_b_chance) {
    return;
  }
  self waittillmatch(animname, "scream_b");
  players = get_players();
  affected_players = [];
  for(i = 0; i < players.size; i++) {
    if(distanceSquared(players[i].origin, self.origin) < level.ape_zombie_scream_b_radius_sq) {
      affected_players = array_add(affected_players, players[i]);
    }
  }
  for(i = 0; i < affected_players.size; i++) {
    affected_players[i] ShellShock("electrocution", 1.5, true);
  }
}

ape_zombie_die() {
  self maps\_zombiemode_spawner::reset_attack_spot();
  self.grenadeAmmo = 0;
  if(isDefined(self.curr_idle_node)) {
    self.curr_idle_node.is_claimed = false;
  }
  self playSound("zmb_engineer_death_bells");
  level maps\_zombiemode_spawner::zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, self);
  if(self.damagemod == "MOD_BURNED") {
    self thread animscripts\zombie_death::flame_death_fx();
  }
  if(!isDefined(level.ape_zombie_death_pos)) {
    level.ape_zombie_death_pos = [];
  }
  level.ape_zombie_death_pos = array_add(level.ape_zombie_death_pos, self.origin);
  if(!self.restart) {
    self ape_zombie_powerup_drop();
    if(level.round_number <= 22) {
      level.ape_zombie_min_health = level.ape_zombie_min_health * 2;
    }
  }
  level.ape_death++;
  level.ape_death_total++;
  if(level.ape_death >= level.ape_death_ammo) {
    level.ammo_spawn = true;
    level.ape_death = 0;
  }
  if(level.ape_death_total == 1) {
    level.ape_zombie_groundhit_damage_radius = 300;
  } else if(level.ape_death_total == 2) {
    level.ape_zombie_groundhit_damage_radius = 320;
  }
  level.round_spawn_func = level.ape_save_spawn_func;
  level.round_wait_func = level.ape_save_wait_func;
  flag_set("last_ape_down");
  return false;
}

ape_zombie_powerup_drop() {
  if(!level.ape_powerup_array.size) {
    return;
  }
  if(level.ammo_spawn) {
    level.zombie_powerup_ape = "full_ammo";
  } else {
    level.zombie_powerup_ape = level.ape_powerup_array[level.ape_powerup_index];
    level.ape_powerup_index++;
    if(level.ape_powerup_index >= level.zombie_powerup_ape.size) {
      level.ape_powerup_index = 0;
      level.ape_powerup_array = array_randomize(level.ape_powerup_array);
    }
  }
  level.zombie_vars["zombie_drop_item"] = 1;
  level.powerup_drop_count--;
  level thread maps\_zombiemode_powerups::powerup_drop(self.origin);
}

ape_adjust_max_ammo() {
  while(1) {
    level waittill("between_round_over");
    wait_network_frame();
  }
}

ape_zombie_wait_for_respawn() {
  level thread wait_for_round();
  level waittill("respawn_now");
  level.num_ape_zombies--;
}

wait_for_round() {
  level endon("respawn_now");
  level waittill("between_round_over");
  wait(1);
  level waittill("between_round_over");
  if(randomInt(100) < 50) {
    wait(1);
    level waittill("between_round_over");
  }
  level notify("respawn_now");
}

ape_thundergun_disintegrate(player) {
  self endon("death");
  self DoDamage(level.ape_thundergun_damage, player.origin, player);
  if(self.health > 0 && !flag("tgun_react")) {
    flag_set("tgun_react");
    time = getAnimLength( % ai_zombie_simianaut_react_tgun);
    self animscripted("tgunreact_anim", self.origin, self.angles, % ai_zombie_simianaut_react_tgun);
    wait(time);
    wait(2.5);
    flag_clear("tgun_react");
  }
}

ape_fire_damage(trap) {
  self endon("death");
  self DoDamage(level.ape_fire_damage, self.origin);
  while(1) {
    wait(0.25);
    if(self IsTouching(trap)) {
      self DoDamage(level.ape_fire_damage, self.origin, trap);
    } else {
      if(self.health > 0) {
        self.marked_for_death = undefined;
      }
      break;
    }
  }
}

ape_trap_reaction(trap) {
  self endon("death");
  trap notify("trap_done");
}

ape_custom_damage(player) {
  self endon("death");
  if(isDefined(self.ground_hit) && self.ground_hit) {
    return level.ape_zombie_groundhit_damage;
  }
  return self.meleeDamage;
}

ape_actor_damage(weapon, damage, attacker) {
  self endon("death");
  switch (weapon) {
    case "spas_zm":
    case "spas_upgraded_zm":
    case "ithaca_zm":
    case "ithaca_upgraded_zm":
    case "minigun_zm":
    case "minigun_upgraded_zm":
      damage *= 0.5;
      break;
    case "python_zm":
    case "python_upgraded_zm":
      damage *= 0.3;
      break;
    case "ray_gun_zm":
    case "ray_gun_upgraded_zm":
      damage *= 0.25;
      break;
    case "bowie_knife_zm":
      damage *= 0.1;
      break;
  }
  if(level.zombie_vars["zombie_insta_kill"]) {
    damage *= 2;
  }
  if((float(self.health - damage) / self.maxhealth) < 0.7) {
    self animscripts\zombie_death::helmetPop();
  }
  return damage;
}

ape_nuke_damage(location) {
  self endon("death");
  if(!self.entered_level) {
    return;
  }
  nuke_dist_sq = 1024 * 1024;
  if(distanceSquared(self.origin, location) < nuke_dist_sq) {
    damage = self.maxhealth * 0.5;
    self DoDamage(damage, self.origin);
    if(self.is_activated && self.health > 0) {
      time = getAnimLength( % ai_zombie_simianaut_react_nuke);
      self animscripted("nukereact_anim", self.origin, self.angles, % ai_zombie_simianaut_react_nuke);
      wait(time);
    }
    self.is_activated = true;
  }
}

ape_tesla_damage(origin, player) {
  self DoDamage(level.ape_tesla_damage, origin, player);
  if(self.health > 0) {
    self.zombie_tesla_hit = false;
  }
}

ape_dog_damage() {
  DOG_MELEE_DAMAGE = 100;
  self DoDamage(DOG_MELEE_DAMAGE, self.origin);
}

ape_zombie_damage_fx(mod, hit_location, hit_origin, player) {
  playFX(level._effect["ape_impact"], hit_origin);
}

ape_non_attacker(damage, weapon) {
  TURRET_DAMAGE = 25;
  if(weapon == "zombie_ability_turret") {
    return TURRET_DAMAGE;
  }
  return 0;
}

ape_zombie_default_enter_level() {
  playFX(level._effect["ape_spawn"], self.origin);
  playsoundatposition("zmb_bolt", self.origin);
  PlayRumbleOnPosition("explosion_generic", self.origin);
  self.entered_level = true;
}

ape_zombie_knockdown() {
  self endon("death");
  time = getAnimLength( % ai_zombie_thundergun_hit_forwardtoface);
  self animscripted("down", self.origin, self.angles, % ai_zombie_thundergun_hit_forwardtoface, "normal", % body, 1);
  wait(time);
  time = getAnimLength( % ai_zombie_thundergun_getup_a);
  self animscripted("up", self.origin, self.angles, % ai_zombie_thundergun_getup_a, "normal", % body, 1);
  wait(time);
}

ape_zombie_push_zombies() {
  self endon("death");
  while(1) {
    pushed = 0;
    origin = self getEye();
    zombies = get_array_of_closest(origin, GetAiSpeciesArray("axis", "all"), undefined, undefined, 60);
    for(i = 0; i < zombies.size; i++) {
      if(zombies[i].animname == "zombie") {
        if(!isDefined(zombies[i].ape_knockdown_time) || zombies[i].ape_knockdown_time < GetTime()) {
          if(pushed <= 3) {
            zombies[i].ape_knockdown_time = GetTime() + 30000;
            zombies[i] thread ape_zombie_knockdown();
            pushed++;
          }
        }
      }
    }
    rand = RandomFloatRange(2, 5);
    wait(rand);
  }
}

ape_pathing() {
  self endon("death");
  while(1) {
    if(isDefined(self.favoriteenemy)) {
      self.ignoreall = false;
      self OrientMode("face default");
      self SetGoalPos(self.favoriteenemy.origin);
    }
    wait_network_frame();
  }
}

ape_find_flesh() {
  self endon("death");
  level endon("intermission");
  self endon("stop_find_flesh");
  if(level.intermission) {
    return;
  }
  self.helitarget = true;
  self maps\_zombiemode_spawner::zombie_history("ape find flesh -> start");
  self.goalradius = 48;
  players = getplayers();
  self.ignore_player = [];
  player = get_closest_valid_player(self.origin, self.ignore_player);
  if(!isDefined(player)) {
    self maps\_zombiemode_spawner::zombie_history("ape find flesh -> can't find player, continue");
  }
  self.favoriteenemy = player;
  while(1) {
    if(isDefined(level.user_ryan_ape_pathing)) {
      self thread maps\_zombiemode_ai_ape::ape_pathing();
    } else {
      self thread maps\_zombiemode_spawner::zombie_pathing();
    }
    self.zombie_path_timer = GetTime() + (RandomFloatRange(1, 3) * 1000);
    while(GetTime() < self.zombie_path_timer) {
      wait(0.1);
    }
    self maps\_zombiemode_spawner::zombie_history("ape find flesh -> bottom of loop");
    debug_print("Zombie is re-acquiring enemy, ending breadcrumb search");
    self notify("zombie_acquire_enemy");
  }
}