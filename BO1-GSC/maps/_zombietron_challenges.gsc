/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_challenges.gsc
*******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;

main() {
  init_sounds();
  if(!isDefined(level.challenge_round_t1)) {
    level.challenge_round_t1 = NewHudElem(self);
    level.challenge_round_t2 = NewHudElem(self);
    level.challenge_round_t1.alignX = "center";
    level.challenge_round_t1.alignY = "middle";
    level.challenge_round_t1.horzAlign = "center";
    level.challenge_round_t1.vertAlign = "middle";
    level.challenge_round_t1.y -= 10;
    level.challenge_round_t1.foreground = true;
    level.challenge_round_t1.fontScale = 3;
    level.challenge_round_t1.color = (1.0, 0.0, 0.0);
    level.challenge_round_t1.hidewheninmenu = true;
    level.challenge_round_t2.alignX = "center";
    level.challenge_round_t2.alignY = "middle";
    level.challenge_round_t2.horzAlign = "center";
    level.challenge_round_t2.vertAlign = "middle";
    level.challenge_round_t2.y += 20;
    level.challenge_round_t2.foreground = true;
    level.challenge_round_t2.fontScale = 2;
    level.challenge_round_t2.color = (1.0, 0.0, 0.0);
    level.challenge_round_t2.hidewheninmenu = true;
  }
  level.RandomMiniBosses = [];
  if(isDefined(level.ChallengeEvents)) {
    for(i = 0; i < level.ChallengeEvents.size; i++) {
      level.ChallengeEvents[i] Delete();
    }
  }
  level.ChallengeEvents = [];
  bigMoss = undefined;
  miniBossSpawners = getEntArray("mini_boss", "script_noteworthy");
  for(i = 0; i < miniBossSpawners.size; i++) {
    struct = spawnstruct();
    struct.spawner = miniBossSpawners[i];
    struct.type = struct.spawner.script_parameters;
    switch (struct.type) {
      case "sergei":
        struct.round = 9;
        struct.hp_mod = 0.4;
        struct.max_ai = 20;
        struct.spawnInitCB = maps\_zombietron_spawner::sergei_spawn_init;
        struct.postspawnCB = maps\_zombietron_spawner::spawn_sergei_postCB;
        struct.text = & "ZOMBIETRON_CHALLENGE_SERGEI";
        break;
      case "quad":
        struct.round = 13;
        struct.hp_mod = 0.7;
        struct.max_ai = 20;
        struct.spawnInitCB = maps\_zombietron_ai_quad::quad_prespawn;
        struct.text = & "ZOMBIETRON_CHALLENGE_QUAD";
        break;
      case "german":
        struct.round = 17;
        struct.hp_mod = 0.5;
        struct.max_ai = 20;
        struct.spawnInitCB = maps\_zombietron_spawner::clark_spawn_init;
        struct.spawnEventInit = maps\_zombietron_ai_buffalo::challenge_init;
        struct.text = & "ZOMBIETRON_CHALLENGE_COW";
        break;
      case "engineer":
        struct.round = 22;
        struct.hp_mod = 1;
        struct.max_ai = 20;
        struct.spawnInitCB = maps\_zombietron_ai_engineer::engineer_prespawn;
        struct.postspawnCB = maps\_zombietron_spawner::spawn_engineer_postCB;
        struct.text = & "ZOMBIETRON_CHALLENGE_ENGINEER";
        break;
      case "moss_big":
        struct.spawnInitCB = maps\_zombietron_spawner::moss_spawn_init_big;
        break;
      case "moss":
        struct.round = 30;
        struct.hp_mod = 0.5;
        struct.max_ai = 28;
        struct.spawnInitCB = maps\_zombietron_spawner::moss_spawn_init;
        struct.text = & "ZOMBIETRON_CHALLENGE_SNOW";
        break;
      case "dog":
        struct.round = 34;
        struct.hp_mod = 0.25;
        struct.max_ai = 10;
        struct.spawnInitCB = maps\_zombietron_ai_dog::dog_prespawn;
        struct.text = & "ZOMBIETRON_CHALLENGE_DOG";
        break;
      default:
        assertex(0, "Unhandled miniboss");
        break;
    }
    level.ChallengeEvents[level.ChallengeEvents.size] = struct;
  }
  struct = spawnstruct();
  struct.round = 25;
  struct.spawner = undefined;
  struct.type = "barrel";
  struct.text = & "ZOMBIETRON_CHALLENGE_PIG";
  level.ChallengeEvents[level.ChallengeEvents.size] = struct;
  moss = get_challenge_by_type("moss");
  if(isDefined(moss)) {
    moss.spawner_secondary_type = "moss_big";
    moss.spawner_secondary_chance = level.zombie_vars["moss_martyrdom_chance"];
  }
}

init_sounds() {}
has_challenge_occured(type) {
  for(i = 0; i < level.ChallengeEvents.size; i++) {
    challenge = level.ChallengeEvents[i];
    if(!isDefined(challenge.round))
      continue;
    if(challenge.type == type && challenge.round < level.round_number) {
      return true;
    }
  }
  return false;
}

is_this_a_challenge_round(roundNum) {
  for(i = 0; i < level.ChallengeEvents.size; i++) {
    challenge = level.ChallengeEvents[i];
    if(!isDefined(challenge.round))
      continue;
    if(challenge.round == roundNum) {
      return true;
    }
  }
  return false;
}

get_challenge_by_type(type) {
  for(i = 0; i < level.ChallengeEvents.size; i++) {
    challenge = level.ChallengeEvents[i];
    if(challenge.type == type) {
      return challenge;
    }
  }
  return undefined;
}

try_to_start_challenge_round(roundNum) {
  if(!is_this_a_challenge_round(roundNum)) {
    return;
  }
  level.challenge = undefined;
  for(i = 0; i < level.ChallengeEvents.size; i++) {
    level.challenge = level.ChallengeEvents[i];
    if(!isDefined(level.challenge.round))
      continue;
    if(level.challenge.round == roundNum) {
      break;
    }
  }
  level.challenge_round_t1.alpha = 0;
  level.challenge_round_t2.alpha = 0;
  level.challenge_round_t1 SetText(&"ZOMBIETRON_CHALLENGE");
  level.challenge_round_t2 SetText(level.challenge.text);
  level.challenge_round_t1 FadeOverTime(1);
  level.challenge_round_t2 FadeOverTime(1);
  level.challenge_round_t1.alpha = 1;
  level.challenge_round_t2.alpha = 1;
  wait 3;
  level.challenge_round_t1 FadeOverTime(1);
  level.challenge_round_t2 FadeOverTime(1);
  level.challenge_round_t1.alpha = 0;
  level.challenge_round_t2.alpha = 0;
  if(isDefined(level.challenge.max_ai)) {
    SetAILimit(level.challenge.max_ai);
  }
  if(isDefined(level.challenge.spawnEventInit)) {
    level thread[[level.challenge.spawnEventInit]]();
  }
  while(flag("round_is_active")) {
    wait 1;
  }
  waittill_all_zombies_dead();
  if(isDefined(level.challenge.spawner)) {
    level.RandomMiniBosses[level.RandomMiniBosses.size] = level.challenge.spawner;
  }
  level.challenge = undefined;
  SetAILimit(level.default_ai_limit);
}

boss_battle_challenge() {
  self endon("death");
  health = self.health;
  type = "sergei";
  burst = 0;
  while(1) {
    curhealth = (self.health / health) * 100;
    burst = 0;
    if(curhealth < 20) {
      type = "dog";
      burst = RandomIntRange(3, 6);
    } else
    if(curhealth < 35) {
      type = "engineer";
      burst = RandomIntRange(10, 20);
    } else
    if(curhealth < 50) {
      type = "moss_big";
      burst = RandomIntRange(3, 10);
    } else
    if(curhealth < 65) {
      type = "german";
      burst = RandomIntRange(10, 15);
    } else
    if(curhealth < 80) {
      type = "quad";
      burst = RandomIntRange(10, 16);
    } else
    if(curhealth < 95) {
      type = "sergei";
      burst = RandomIntRange(10, 15);
    }
    while(burst) {
      spawn_locations = level.current_spawners[level.current_wave.spawn_side];
      spawn_point = spawn_locations[randomInt(spawn_locations.size)];
      maps\_zombietron_spawner::spawn_a_mini_boss(spawn_point, type);
      burst--;
      wait 0.05;
    }
    wait RandomIntRange(5, 12);
  }
}

barrel_blow_think(life) {
  self endon("death");
  curTime = GetTime();
  lifeTime = curTime + life * 1000;
  ignite = curTime + (life * 0.2) * 1000;
  fire = curTime + (life * 0.7) * 1000;
  while(curTime < lifeTime) {
    if(curTime > ignite) {
      PlayFxOnTag(level._effect["barrel_ignite_fire"], self, "tag_origin");
      self playLoopSound("exp_tron_barrel_fire");
    }
    if(curTime > fire) {
      PlayFxOnTag(level._effect["barrel_top_fire"], self, "tag_origin");
    }
    wait 0.2;
    curTime = GetTime();
  }
  self notify("damage");
}

barrel_bomb_think() {
  self thread barrel_blow_think(RandomIntRange(6, 12));
  self setcandamage(true);
  self EnableaimAssist();
  self.team = "axis";
  self.is_zombie = true;
  self waittill("damage");
  PlayFx(level._effect["barrel_explode"], self.origin, (0, 1, 0));
  physicsExplosionSphere(self.origin, 128, 64, 2);
  RadiusDamage(self.origin + (0, 0, 20), 128, 7000, 5000, self, "MOD_PROJECTILE_SPLASH");
  playRumbleOnPosition("grenade_rumble", self.origin);
  playsoundatposition("exp_tron_barrel", self.origin);
  self Delete();
}

barrel_burst(which) {
  self endon("exit_taken");
  if(flag(which))
    return;
  flag_set(which);
  barrelSpawns = [];
  if(which == "barrel_burst1") {
    barrelSpawns = getEntArray("barrel_drop_1", "targetname");
  } else {
    barrelSpawns = getEntArray("barrel_drop_2", "targetname");
  }
  if(maps\_zombietron_challenges::is_this_a_challenge_round(level.round_number)) {
    number = randomInt(barrelSpawns.size);
    waitTime = RandomFloatRange(number, 20);
  } else {
    number = randomInt(2);
    waitTime = RandomFloatRange(30, 60);
  }
  while(number) {
    level ok_to_spawn(0.5);
    spawn_point = barrelSpawns[randomInt(barrelSpawns.size)];
    barrel = spawn("script_model", spawn_point.origin);
    barrel setModel(level.red_barrel_model);
    if(which == "barrel_burst1") {
      barrel.angles = (0, 90, 90);
    } else {
      barrel.angles = (0, 0, 90);
    }
    barrel SetScale(1.0);
    barrel thread barrel_bomb_think();
    barrel PhysicsLaunch(barrel.origin, (0, 0, 1));
    wait RandomFloatRange(1, 3);
    number--;
  }
  wait waitTime;
  flag_clear(which);
}

barrel_dropper() {
  self endon("exit_taken");
  btrig1 = getEnt("barrel_drop_1_trig", "targetname");
  btrig2 = getEnt("barrel_drop_2_trig", "targetname");
  flag_clear("barrel_burst1");
  flag_clear("barrel_burst2");
  while(1) {
    players = GetPlayers();
    for(i = 0; i < players.size; i++) {
      if(players[i] isTouching(btrig1)) {
        level thread barrel_burst("barrel_burst1");
      }
      if(players[i] isTouching(btrig2)) {
        level thread barrel_burst("barrel_burst2");
      }
    }
    wait 0.05;
  }
}

barrel_challenge_monitor() {
  challenge = maps\_zombietron_challenges::get_challenge_by_type("barrel");
  while(1) {
    level waittill("move_to_start");
    if(level.round_number == challenge.round) {
      break;
    }
  }
  while(level.arenas[level.current_arena] == "street") {
    wait 5;
    level thread barrel_dropper();
    level waittill("exit_taken");
  }
}