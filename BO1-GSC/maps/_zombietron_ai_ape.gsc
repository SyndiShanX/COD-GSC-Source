/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_ai_ape.gsc
***************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

precache_ape_fx() {
  PrecacheRumble("explosion_generic");
  level._effect["ape_groundhit"] = LoadFx("maps/zombie/fx_zombie_ape_grnd_hit");
  level._effect["ape_spawn"] = LoadFx("maps/zombie/fx_zombie_ape_spawn_dust");
  level._effect["ape_impact"] = LoadFx("maps/zombie/fx_zombie_flesh_hit_ape");
  level._effect["ape_lightning_spawn"] = LoadFx("maps/zombie/fx_zombie_dog_lightning_buildup");
}
init(spawners) {
  array_thread(spawners, ::add_spawn_function, maps\_zombietron_ai_ape::ape_prespawn);
}
#using_animtree("generic_human");

ape_prespawn() {
  self.animname = "ape_zombie";
  self.script_noteworthy = "ape_zombie";
  self ape_zombie_idle_setup();
  self.a.idleAnimOverrideArray = [];
  self.a.idleAnimOverrideArray["stand"] = [];
  self.a.idleAnimOverrideWeights["stand"] = [];
  self.a.idleAnimOverrideArray["stand"][0][0] = % ai_zombie_simianaut_idle;
  self.a.idleAnimOverrideWeights["stand"][0][0] = 10;
  self.a.idleAnimOverrideArray["stand"][0][1] = % ai_zombie_simianaut_idle;
  self.a.idleAnimOverrideWeights["stand"][0][1] = 10;
  rand = randomIntRange(1, 5);
  self.deathanim = level.scr_anim["ape_zombie"]["death" + rand];
  self.no_idle = true;
  self.can_always_see = true;
  self.ignorelocationaldamage = true;
  self.ignoreall = true;
  self.allowdeath = true;
  self.is_zombie = true;
  self.has_legs = true;
  self allowedStances("stand");
  self.gibbed = false;
  self.head_gibbed = false;
  self.boss = true;
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
  self.dropweapon = false;
  self.entered_level = false;
  self.chest_beat = false;
  self.restart = 0;
  self.speed_up = 0;
  self setPhysParams(30, 0, 60);
  self setTeamForEntity("axis");
  self.is_activated = false;
  if(self.targetname != "ape_taunt_ai") {
    self.maxhealth = level.zombie_vars["ape_zombie_health"] * GetPlayers().size;
    self.health = self.maxhealth;
    flag_set("boss_is_spawned");
    flag_clear("boss_is_dead");
    level thread ape_death_event(self);
    level thread ape_damage_event(self);
    self thread ape_think();
  }
  self notify("zombie_init_done");
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
  self.a.array["exposed_idle"] = array(%ai_zombie_simianaut_idle, %ai_zombie_simianaut_idle);
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
ape_damage_event(zombie) {
  while(isAlive(zombie)) {
    zombie waittill("damage", damage, attacker, direction, point, type);
    if(isDefined(zombie.damagedby) && zombie.damagedby == "tesla") {
      zombie maps\_zombietron_weapon::tesla_damage_init(attacker);
    }
  }
}
ape_death_event(zombie) {
  zombie waittill("death");
  if(!isDefined(zombie)) {
    return;
  }
  zombie playSound("zmb_simianaut_death");
  if(isDefined(zombie.attacker) && isPlayer(zombie.attacker)) {
    zombie.attacker maps\_zombietron_score::player_add_points(level.zombie_vars["zombie_points_boss"]);
  }
  level thread maps\_zombietron_pickups::spawn_uber_prizes(RandomFloatRange(0.5, 1) * (9 * level.zombie_vars["max_prize_inc_range"]), zombie.origin, true);
  level.total_boss_killed++;
  flag_set("boss_is_dead");
}
set_ape_run_cycle() {
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
    self.needs_run_update = true;
    wait(0.05);
  }
}
ape_move_to_drop(drop_origin, waitflag) {
  self endon("death");
  self endon("drop_me");
  while(1) {
    self forceteleport(drop_origin);
    wait 0.05;
  }
}
ape_think() {
  self endon("death");
  spawnOrigin = self.origin;
  self thread ape_move_to_drop(self.origin + (0, 0, 1000), "ape_drop_go");
  self.run_index = -1;
  self.ignoreall = true;
  self.pathEnemyFightDist = 64;
  self.meleeAttackDist = 64;
  self.pissedOff = 0;
  self.maxsightdistsqrd = 96 * 96;
  VisionSetNaked("huey_city", 1);
  maps\createart\zombietron_art::do_single_lightning();
  playFX(level._effect["ape_lightning_spawn"], spawnOrigin);
  playsoundatposition("zmb_ape_prespawn", spawnOrigin);
  wait(.5);
  playFX(level._effect["ape_lightning_spawn"], spawnOrigin);
  wait(.5);
  playFX(level._effect["ape_lightning_spawn"], spawnOrigin);
  playsoundatposition("zmb_ape_prespawn", spawnOrigin);
  wait(1.5);
  self notify("drop_me");
  self forceteleport(spawnOrigin);
  playsoundatposition("zmb_ape_bolt", spawnOrigin);
  Earthquake(0.5, 0.75, spawnOrigin, 1000);
  PlayRumbleOnPosition("explosion_generic", spawnOrigin);
  playsoundatposition("zmb_ape_spawn", spawnOrigin);
  time = getAnimLength(%ai_zombie_simianaut_chest_beat);
  self SetFlaggedAnimKnobAllRestart("chestbeat_anim", %ai_zombie_simianaut_chest_beat, %body, 1, .1, 1);
  time = time / 2.0;
  self maps\_zombietron_utility::waittill_notify_timeout("damage", time);
  self.ignoreall = false;
  self thread maps\_zombietron_spawner::find_flesh();
  self thread set_ape_run_cycle();
  self.is_activated = true;
  flag_set("boss_is_spawned");
  playFXOnTag(level._effect["boss"], self, "tag_origin");
  while(true) {
    specialAttackChance = 10;
    if(isDefined(self.favoriteenemy)) {
      if(isDefined(self.favoriteenemy.tank)) {
        specialAttackChance += 15;
      }
      if(RandomInt(100) < specialAttackChance) {
        self notify("stop_find_flesh");
        self notify("killanimscript");
        time = getAnimLength(%ai_zombie_simianaut_taunt);
        self SetFlaggedAnimKnobAllRestart("chestbeat_anim", %ai_zombie_simianaut_taunt, %body, 1, .1, 1);
        wait time;
        self ClearAnim(%ai_zombie_simianaut_taunt, 0.2);
        self playSound("zmb_speed_boost_activate");
        Earthquake(0.5, 0.75, self.origin, 1000);
        PlayRumbleOnPosition("explosion_generic", self.origin);
        curdir = anglesToForward(self.angles);
        trigger = spawn("trigger_radius", self.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 65, 50);
        trigger EnableLinkTo();
        trigger LinkTo(self, "", curdir * 50);
        trigger thread maps\_zombietron_pickups::shield_trigger_think(self);
        self move_to_position_over_time(self.favoriteenemy.origin, 500);
        trigger Delete();
        self notify("killanimscript");
        self thread maps\_zombietron_spawner::find_flesh();
        self thread animscripts\zombie_move::moveAgain();
        continue;
      }
      if(isDefined(self.favoriteenemy.heli)) {
        specialAttackChance += 45;
      }
      if(RandomInt(100) < specialAttackChance) {
        self notify("stop_find_flesh");
        self notify("killanimscript");
        time = getAnimLength(%ai_zombie_simianaut_chest_beat);
        self SetFlaggedAnimKnobAllRestart("chestbeat_anim", %ai_zombie_simianaut_chest_beat, %body, 1, .1, 1);
        time = time / 2.0;
        wait time;
        self ClearAnim(%ai_zombie_simianaut_chest_beat, 0.2);
        Earthquake(0.5, 0.75, self.origin, 1000);
        PlayRumbleOnPosition("explosion_generic", self.origin);
        self playSound("evt_turret_takeoff");
        playFXOnTag(level._effect["boss_takeoff"], self, "tag_origin");
        height = 800;
        timeMS = height / 1000 * 3000;
        trigger = spawn("trigger_radius", self.origin, level.SPAWNFLAG_TRIGGER_AI_AXIS, 65, 50);
        trigger EnableLinkTo();
        trigger LinkTo(self);
        trigger thread maps\_zombietron_pickups::shield_trigger_think(self);
        self move_to_position_over_time(self.favoriteenemy.origin, timeMS, height);
        self playSound("zmb_simianaut_groundpound");
        PlayRumbleOnPosition("explosion_generic", self.origin);
        playFXOnTag(level._effect["boss_groundhit"], self, "tag_origin");
        self notify("killanimscript");
        trigger Delete();
        self thread maps\_zombietron_spawner::find_flesh();
        time = getAnimLength(%ai_zombie_simianaut_chest_beat);
        self SetFlaggedAnimKnobAllRestart("chestbeat_anim", %ai_zombie_simianaut_chest_beat, %body, 1, .1, 1);
        time = time / 2.0;
        wait time;
        self ClearAnim(%ai_zombie_simianaut_chest_beat, 0.2);
        self thread animscripts\zombie_move::moveAgain();
        continue;
      }
    } else {
      players = GetPlayers();
      self.favoriteenemy = players[RandomInt(players.size)];
    }
    wait(1);
  }
}
move_to_position_over_time(destination, timeMS, elevationDelta) {
  self endon("death");
  frames = timeMS / 50;
  delta = (destination - self.origin) / frames;
  stopTime = GetTime() + timeMS;
  if(isDefined(elevationDelta)) {
    deltaZ = elevationDelta / (frames / 2);
    stopTimeUp = GetTime() + (timeMS / 2);
    while(1) {
      time = GetTime();
      if(time > stopTime) {
        break;
      }
      if(time < stopTimeUp) {
        deltaPlus = delta + (0, 0, deltaZ);
      } else {
        deltaPlus = delta - (0, 0, deltaZ);
      }
      newSpot = self.origin + deltaPlus;
      if(newSpot[2] < destination[2]) {
        newSpot = (newSpot[0], newSpot[1], destination[2]);
        if(isAi(self)) {
          self forceTeleport(newSpot);
        } else {
          self.origin = newSpot;
        }
        return;
      }
      if(isAi(self)) {
        self forceTeleport(newSpot);
      } else {
        self.origin = newSpot;
      }
      wait 0.05;
    }
  } else {
    while(GetTime() < stopTime) {
      if(isAi(self)) {
        self forceTeleport(self.origin + delta);
      } else {
        self.origin += delta;
      }
      wait 0.05;
    }
  }
}
#using_animtree("generic_human");

ape_taunt_deleter() {
  level waittill_any("exit_taken_fadeout", "ape_exited");
  self delete();
}
ape_shielder() {
  level endon("exit_taken");
  level endon("ape_exited");
  while(1) {
    playFXOnTag(level._effect["red_shield"], self, "tag_origin");
    wait 3;
  }
}
ape_KillOnProximity() {
  level endon("exit_taken");
  level endon("ape_exited");
  while(1) {
    player = get_closest_valid_player(self.origin);
    if(isDefined(player)) {
      if(distanceSquared(self.origin, player.origin) < 50 * 50) {
        player DoDamage(player.health + 666, player.origin);
      }
    }
    wait 0.05;
  }
}
ape_you_greedy_mf(exit) {
  self notify("ape_stop_being_greedy");
  self endon("ape_stop_being_greedy");
  level endon("exit_taken");
  level endon("ape_exited");
  while(1) {
    pickupsItems = getEntArray("a_pickup_item", "script_noteworthy");
    targetPickup = get_closest_to(self.origin, pickupsItems);
    if(isDefined(targetPickup)) {
      if(distanceSquared(self.origin, targetPickup.origin) < 50 * 50) {
        targetPickup thread moveto_and_delete(exit, 1);
      }
    }
    wait 0.05;
  }
}
ape_taunt_go(destination, player, boss_battle) {
  level endon("exit_taken");
  level endon("round_is_active");
  ape = simple_spawn_single("ape_taunt", ::ape_prespawn);
  wait 0.1;
  ape.favoriteenemy = player;
  ape.takedamage = false;
  ape thread ape_shielder();
  ape thread ape_taunt_deleter();
  current_spawners = maps\_zombietron_main::get_all_the_map_spawners();
  spawn_point = current_spawners[RandomInt(current_spawners.size)];
  exit_points = [];
  for(i = 0; i < current_spawners.size; i++) {
    if(current_spawners[i] != spawn_point) {
      exit_points[exit_points.size] = current_spawners[i];
    }
  }
  exit_spawn_point = exit_points[RandomInt(exit_points.size)];
  ape thread ape_you_greedy_mf(exit_spawn_point.origin);
  ape forceTeleport(spawn_point.origin);
  ape set_run_anim("sprint3");
  ape.run_combatanim = level.scr_anim["ape_zombie"]["sprint3"];
  ape.crouchRunAnim = level.scr_anim["ape_zombie"]["sprint3"];
  ape.crouchrun_combatanim = level.scr_anim["ape_zombie"]["sprint3"];
  ape.goalradius = 32;
  ape SetGoalPos(destination);
  while(1) {
    if(distanceSquared(ape.origin, destination) > 128 * 128) {
      ape OrientMode("face motion");
    } else {
      ape OrientMode("face point", player.origin);
    }
    wait 0.05;
    if(distanceSquared(ape.origin, destination) < 32 * 32) {
      break;
    }
  }
  ape thread maps\_anim::anim_single(ape, "chest_beat");
  wait 2.3;
  ape anim_stopanimscripted(0.15);
  if(isDefined(boss_battle)) {}
  numTargets = RandomIntRange(2, 4);
  ape thread ape_KillOnProximity();
  while(numTargets) {
    pickupsItems = getEntArray("a_pickup_item", "script_noteworthy");
    if(pickupsItems.size == 0) {
      break;
    }
    targetPickup = pickupsItems[RandomInt(pickupsItems.size)];
    if(isDefined(targetPickup)) {
      exit_spawn_point = get_closest_to(targetPickup.origin, exit_points);
      ape thread ape_you_greedy_mf(exit_spawn_point.origin);
      ape SetGoalPos(targetPickup.origin);
      ape waittill_notify_timeout("goal", 3);
    } else {
      break;
    }
    numTargets--;
  }
  ape SetGoalPos(exit_spawn_point.origin);
  ape waittill("goal");
  level notify("ape_exited");
  wait 1;
  assertex(!isDefined(ape), "ape not deleted");
}
ape_taunt_player() {
  level.scr_anim["ape_zombie"]["chest_beat"] = % ai_zombie_simianaut_chest_beat;
  lastRound = 0;
  while(1) {
    level waittill("APE_TAUNT_GO");
    if(level.arenas[level.current_arena] == "prison") {
      continue;
    }
    if(level.arenas[level.current_arena] == "rooftop") {
      continue;
    }
    if(level.arenas[level.current_arena] == "island") {
      continue;
    }
    if(level.epic_boss_battle == true) {
      percentMod = 100;
    } else {
      percentMod = level.zombie_vars["boss_taunt_percent_per_level"] + (level.round_number - lastRound) * level.zombie_vars["boss_taunt_percent_per_level"];
    }
    if(RandomInt(100) < percentMod) {
      lastRound = level.round_number;
      runToTarget = level.arenas[level.current_arena] + "_pickup";
      run_locations = getStructArray(runToTarget, "targetname");
      players = GetPlayers();
      if(players.size > 1) {
        player = players[RandomInt(players.size)];
      } else {
        player = players[0];
      }
      best_Loc = player get_closest_to_me(run_locations);
      if(!isDefined(best_Loc)) {
        continue;
      }
      level thread ape_taunt_go(best_Loc.origin, player, level.epic_boss_battle);
    }
  }
}