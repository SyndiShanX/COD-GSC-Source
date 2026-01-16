/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_dogs.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  level.friendlyDogModel = "german_shepherd";
  level.enemyDogModel = "german_shepherd_black";
  precacheModel(level.friendlyDogModel);
  precacheModel(level.enemyDogModel);
  precacheItem("dog_bite_mp");
  precacheShellshock("dog_bite");
  level.maxDogsAttackingPerPlayer = 2;
  level.spawnTimeWaitMin = 2;
  level.spawnTimeWaitMax = 5;
  level.no_dogs = false;
  init_node_arrays();
  if(level.no_pathnodes)
    level.no_dogs = true;
  regenTime = 5;
  level.dogHealth_RegularRegenDelay = regenTime * 1000;
  level.dogHealthRegenDisabled = (level.dogHealth_RegularRegenDelay <= 0);
  dog_dvar_update();
  thread dog_dvar_updater();
  thread dog_usage_init();
  thread init_all_preexisting_dogs();
}
initKillstreak() {
  if(maps\mp\gametypes\_tweakables::getTweakableValue("killstreak", "allowdogs")) {
    maps\mp\gametypes\_hardpoints::registerKillstreak("dogs_mp", "dogs_mp", "killstreak_dogs", "dogs_used", ::useKillstreakDogs, true);
    maps\mp\gametypes\_hardpoints::registerKillstreakStrings("dogs_mp", & "KILLSTREAK_EARNED_DOGS", & "KILLSTREAK_DOGS_NOT_AVAILABLE", & "KILLSTREAK_DOGS_INBOUND");
    maps\mp\gametypes\_hardpoints::registerKillstreakDialog("dogs_mp", "mpl_killstreak_dogs", "kls_dogs_used", "", "kls_dogs_enemy", "", "kls_dogs_ready");
    maps\mp\gametypes\_hardpoints::registerKillstreakDevDvar("dogs_mp", "scr_givedogs");
    maps\mp\gametypes\_hardpoints::registerKillstreakAltWeapon("dogs_mp", "dog_bite_mp");
  }
}
useKillstreakDogs(hardpointType) {
  if(self maps\mp\_killstreakrules::isKillstreakAllowed(hardpointType, self.team) == false)
    return false;
  self notify("called_in_the_dogs");
  level notify("called_in_the_dogs");
  team = self.team;
  otherTeam = level.otherTeam[team];
  if(level.teambased) {
    thread maps\mp\gametypes\_battlechatter_mp::onKillstreakUsed("dogs", otherTeam);
  }
  self maps\mp\gametypes\_hardpoints::playKillstreakStartDialog("dogs_mp", team, true);
  self maps\mp\gametypes\_persistence::statAdd("DOGS_USED", 1, false);
  level.globalKillstreaksCalled++;
  self maps\mp\gametypes\_globallogic_score::incItemStatByReference("killstreak_dogs", 1, "used");
  if(maps\mp\gametypes\_tweakables::getTweakableValue("team", "allowHardpointStreakAfterDeath")) {
    ownerDeathCount = self.deathCount;
  } else {
    ownerDeathCount = self.pers["hardPointItemDeathCount" + hardpointType];
  }
  if(self maps\mp\_killstreakrules::killstreakStart("dogs_mp", self.team) == false)
    return false;
  self thread maps\mp\_dogs::dog_manager_spawn_dogs(team, otherTeam, ownerDeathCount);
  self thread playerDisconnectWatcher();
  return true;
}
playerDisconnectWatcher() {
  level endon("dogs done");
  level endon("dogs leaving");
  self waittill("disconnect");
  level notify("dogs leaving");
}
pick_random_nodes(from, count) {
  to = [];
  if(from.size < count) {
    to = from;
  } else {
    for (i = 0; i < count; i++) {
      to[i] = from[randomInt(from.size)];
    }
  }
  return to;
}
init_node_arrays() {
  nodes = getallnodes();
  pathnodes = [];
  for (i = 0; i < nodes.size; i++) {
    if(isDefined(nodes[i].script_noteworthy))
      continue;
    if(isDefined(nodes[i].targetname) && nodes[i].targetname == "traverse")
      continue;
    pathnodes[pathnodes.size] = nodes[i];
  }
  if(pathnodes.size == 0) {
    level.no_pathnodes = true;
  } else {
    level.no_pathnodes = false;
  }
  level.patrolnodes = [];
  level.patrolnodes = pick_random_nodes(pathnodes, 200);
  level.dogspawnnodes = [];
  level.dogspawnnodes = getnodearray("spawn", "script_noteworthy");
  if(level.dogspawnnodes.size == 0) {
    level.dogspawnnodes = pick_random_nodes(pathnodes, 20);
  }
  level.dogexitnodes = [];
  level.dogexitnodes = getnodearray("exit", "script_noteworthy");
  if(level.dogexitnodes.size == 0) {
    level.dogexitnodes = pick_random_nodes(pathnodes, 20);
  }
}
dog_dvar_update() {
  level.dog_time = dog_get_dvar_int("scr_dog_time", "60");
  level.dog_health = dog_get_dvar_int("scr_dog_health", "100");
  level.dog_count = dog_get_dvar_int("scr_dog_count", "8");
  level.dog_count_max_at_once = dog_get_dvar_int("scr_dog_max_at_once", "4");
  if(level.dog_count < level.dog_count_max_at_once) {
    level.dog_count_max_at_once = level.dog_count;
  }
  level.dog_debug = dog_get_dvar_int("debug_dogs", "0");
  level.dog_debug_sound = dog_get_dvar_int("debug_dog_sound", "0");
  level.dog_debug_anims = dog_get_dvar_int("debug_dog_anims", "0");
  level.dog_debug_anims_ent = dog_get_dvar_int("debug_dog_anims_ent", "0");
  level.dog_debug_turns = dog_get_dvar_int("debug_dog_turns", "0");
  level.dog_debug_orient = dog_get_dvar_int("debug_dog_orient", "0");
  level.dog_debug_usage = dog_get_dvar_int("debug_dog_usage", "1");
}
dog_dvar_updater() {
  dogs_in_the_bsp = count_preexisting_dogs();
  while (1) {
    dog_dvar_update();
    if(level.dog_count + dogs_in_the_bsp > 16) {
      level.dog_count = 16 - dogs_in_the_bsp;
    }
    wait(1);
  }
}
count_preexisting_dogs() {
  dogs = getentarray("actor_enemy_dog_mp", "classname");
  alive_count = 0;
  for (i = 0; i < dogs.size; i++) {
    if(!isDefined(dogs[i]))
      continue;
    if(!isai(dogs[i]))
      continue;
    alive_count++;
  }
  return alive_count;
}
init_all_preexisting_dogs() {
  array_thread(getentarray("actor_enemy_dog_mp", "classname"), ::preexisting_init_dog);
}
preexisting_init_dog() {
  self init_dog();
}
dog_set_model() {
  self setModel(level.friendlyDogModel);
  self setEnemyModel(level.enemyDogModel);
}
init_dog() {
  if(!isai(self))
    return;
  self.aiteam = "axis";
  self.animTree = "dog.atr";
  self.type = "dog";
  self.accuracy = 0.2;
  self.health = level.dog_health;
  self.maxhealth = level.dog_health;
  self.aiweapon = "dog_bite_mp";
  self.secondaryweapon = "";
  self.sidearm = "";
  self.grenadeAmmo = 0;
  self.goalradius = 128;
  self.noDodgeMove = true;
  self.ignoreSuppression = true;
  self.suppressionThreshold = 1;
  self.disableArrivals = false;
  self.pathEnemyFightDist = 512;
  self.halt_patrol = false;
  self.meleeAttackDist = 102;
  self dog_set_model();
  self thread dogHealthRegen();
  self thread selfDefenseChallenge();
}
get_spawn_node(team) {
  if(!level.teambased) {
    node = dog_pick_node_away_from_enemy(level.dogspawnnodes, team);
  } else {
    node = dog_pick_node_near_team(level.dogspawnnodes, team);
  }
  bbPrint("mpdogspawnused: x %f y %f z %f weight %f num_players %i num_dogs %i dist_all %f dist_allies %f dist_axis %f dist_dogs %f", node.origin, node.weight, node.numPlayersAtLastUpdate, node.numDogsAtLastUpdate, node.distSum["all"], node.distSum["allies"], node.distSum["axis"], node.distSum["dogs"]);
  return node;
}
dog_watch_for_owner_team_change(owner) {
  self endon("death");
  owner endon("disconnect");
  while (1) {
    owner waittill("joined_team");
    if(owner.team != self.aiteam) {
      self clearentityowner();
      self notify("clear_owner");
      return;
    }
  }
}
dog_set_owner(owner, team, requiredDeathCount) {
  if(!isDefined(owner))
    return;
  if(level.teambased && isplayer(owner) && owner.team != team)
    return;
  self setentityowner(owner);
  self.requiredDeathCount = requiredDeathCount;
  self thread dog_watch_for_owner_team_change(owner);
  self endon("death");
  owner waittill("disconnect");
  self clearentityowner();
}
dog_create_spawn_influencer() {
  self maps\mp\gametypes\_spawning::create_dog_influencers();
}
dog_manager_spawn_dog(owner, team, spawn_node, index, requiredDeathCount) {
  dog = level.dog_spawner spawnactor();
  dog forceteleport(spawn_node.origin, spawn_node.angles);
  dog setgoalnode(spawn_node);
  dog.spawnnode = spawn_node;
  dog show();
  dog init_dog();
  dog dog_set_team(team);
  dog dog_set_model();
  dog dog_create_spawn_influencer();
  dog thread dog_set_owner(owner, team, requiredDeathCount);
  dog thread dog_usage(index);
  dog thread dog_owner_kills();
  dog thread dog_clean_up();
  dog thread dog_notify_level_on_death();
  dog dog_thread_behavior_function();
  dog thread maps\mp\gametypes\_weapons::monitor_dog_special_grenades();
  return dog;
}
get_debug_team(team) {
  if(!level.teambased)
    return "free";
  return team;
}
dog_manager_spawn_dogs(team, enemyTeam, deathCount) {
  level endon("dogs done");
  level endon("dogs leaving");
  self endon("disconnect");
  if(level.no_dogs)
    return;
  team = get_debug_team(team);
  requiredDeathCount = deathCount;
  level.dog_spawner = getent("dog_spawner", "targetname");
  if(!isDefined(level.dog_spawner))
    return;
  level.dogs = [];
  level thread dog_manager_game_ended();
  level thread dog_manager_dog_alive_tracker(team);
  level thread dog_manager_dog_time_limit();
  level thread dog_usage_monitor();
  for (i = 0; i < level.dog_count_max_at_once; i++) {
    node = self get_spawn_node(team);
    level.dogs[i] = dog_manager_spawn_dog(self, team, node, i, requiredDeathCount);
    wait(randomfloat(level.spawnTimeWaitMin, level.spawnTimeWaitMax));
  }
  level thread dog_manager_spawn_more_dogs_on_death(self, level.dog_count - level.dog_count_max_at_once, team);
}
dog_manager_spawn_more_dogs_on_death(owner, count, team) {
  level endon("dogs done");
  level endon("dogs leaving");
  while (count > 0) {
    level waittill("dog died");
    wait(randomfloat(level.spawnTimeWaitMin, level.spawnTimeWaitMax));
    node = get_spawn_node(team);
    level.dogs[level.dogs.size] = dog_manager_spawn_dog(owner, team, node, level.dogs.size);
    count -= 1;
  }
  level notify("all dogs spawned");
}
dog_manager_dog_time_limit() {
  level endon("dogs done");
  level endon("dogs leaving");
  wait(level.dog_time);
  level notify("dogs leaving");
}
dog_cleanup_wait(wait_for, notify_name) {
  self endon(notify_name);
  self waittill(wait_for);
  self notify(notify_name, wait_for);
}
dog_cleanup_waiter() {
  self thread dog_cleanup_wait("all dogs spawned", "start_tracker");
  self thread dog_cleanup_wait("dogs leaving", "start_tracker");
  self waittill("start_tracker", wait_for);
}
dog_manager_dog_alive_tracker(team) {
  level dog_cleanup_waiter();
  while (1) {
    alive_count = 0;
    for (i = 0; i < level.dogs.size; i++) {
      if(!isDefined(level.dogs[i]))
        continue;
      if(!isalive(level.dogs[i]))
        continue;
      alive_count++;
    }
    if(alive_count == 0) {
      wait(1);
      dog_manager_delete_dogs();
      level notify("dogs done");
      maps\mp\_killstreakrules::killstreakStop("dogs_mp", team);
      return;
    }
    wait(1);
  }
}
dog_manager_delete_dogs() {
  for (i = 0; i < level.dogs.size; i++) {
    if(!isDefined(level.dogs[i]))
      continue;
    level.dogs[i] delete();
  }
  level.dogs = undefined;
}
dog_manager_game_ended() {
  level waittill("game_ended");
  make_all_dogs_leave();
}
make_all_dogs_leave() {
  level notify("dogs leaving");
}
dog_set_team(team) {
  self.aiteam = team;
}
dog_clean_up() {
  self endon("death");
  self endon("leaving");
  level waittill("dogs leaving");
  thread dog_leave();
}
dog_notify_level_on_death() {
  self endon("leaving");
  self waittill("death");
  level notify("dog died");
}
dog_thread_behavior_function() {
  self thread dog_patrol_when_no_enemy();
}
dog_leave() {
  self notify("leaving");
  self thread dog_leave_failsafe();
  self clearentitytarget();
  self.ignoreall = true;
  self.goalradius = 30;
  self setgoalnode(self dog_get_exit_node());
  self waittill("goal");
  self delete();
}
dog_leave_failsafe() {
  self endon("death");
  start_origin = self.origin;
  wait(2);
  if(distance(start_origin, self.origin) < 10) {
    self delete();
    return;
  }
  wait(20);
  self delete();
}
dog_patrol_when_no_enemy() {
  self endon("death");
  self endon("leaving");
  while (1) {
    if(!isDefined(self.enemy)) {
      self dog_debug_print("no enemy starting patrol");
      self thread dog_patrol();
    }
    self waittill("enemy");
  }
}
dog_patrol_wait(wait_for, notify_name) {
  self endon("attacking");
  dog_wait(wait_for, notify_name);
}
dog_wait(wait_for, notify_name) {
  self endon("death");
  self endon("leaving");
  self endon(notify_name);
  self waittill(wait_for);
  self notify(notify_name, wait_for);
}
dog_patrol_path_waiter() {
  self thread dog_patrol_wait("bad_path", "next_patrol_point");
  self thread dog_patrol_wait("goal", "next_patrol_point");
  self waittill("next_patrol_point", wait_for);
}
dog_patrol() {
  self endon("death");
  self endon("enemy");
  self endon("leaving");
  self endon("attacking");
  self notify("on patrol");
  self dog_patrol_debug();
  node = level.patrolnodes[randomInt(level.patrolnodes.size)];
  while (1) {
    if(self.halt_patrol) {
      self setgoalpos(self.origin);
      wait(1);
      continue;
    }
    for (count = 0; count < 25; count++) {
      newnode = level.patrolnodes[randomInt(level.patrolnodes.size)];
      if(DistanceSquared(node.origin, newnode.origin) > (1024 * 1024)) {
        node = newnode;
        break;
      }
      node = newnode;
    }
    if(!isDefined(node.script_noteworthy)) {
      self setgoalnode(node);
      self dog_patrol_path_waiter();
    }
  }
}
dog_wait_print(wait_for) {}
dog_patrol_debug() {
  self thread dog_wait_print("death");
  self thread dog_wait_print("enemy");
  self thread dog_wait_print("leaving");
  self thread dog_wait_print("attacking");
}
dog_get_dvar_int(dvar, def) {
  return int(dog_get_dvar(dvar, def));
}
dog_get_dvar(dvar, def) {
  if(getdvar(dvar) != "")
    return getdvarfloat(dvar);
  else {
    setdvar(dvar, def);
    return def;
  }
}
dog_usage_init() {
  level.dog_usage = [];
  for (index = 0; index < level.dog_count; index++) {
    level.dog_usage[index] = spawnStruct();
    level.dog_usage[index].spawn_time = 0;
    level.dog_usage[index].death_time = 0;
    level.dog_usage[index].kills = 0;
    level.dog_usage[index].died = false;
  }
}
dog_usage_monitor() {
  start_time = GetTime();
  level waittill("dogs done");
  index = 0;
  total_kills = 0;
  last_alive = 0;
  all_dead = true;
  alive_count = 0;
  never_spawned_count = 0;
  total_count = 0;
  for (index = 0; index < level.dog_count; index++) {
    total_count++;
    if(level.dog_usage[index].spawn_time == 0) {
      never_spawned_count++;
      continue;
    } else if(!level.dog_usage[index].died) {
      alive_count++;
      all_dead = false;
    }
    seconds = (level.dog_usage[index].death_time - level.dog_usage[index].spawn_time) / 1000;
    if(seconds > last_alive) {
      last_alive = seconds;
    }
    total_kills += level.dog_usage[index].kills;
  }
}
dog_usage(index) {
  level.dog_usage[index].spawn_time = GetTime();
  level.dog_usage[index].death_time = 0;
  level.dog_usage[index].kills = 0;
  level.dog_usage[index].died = false;
  self thread dog_usage_kills(index);
  self thread dog_usage_time_alive(index);
}
dog_usage_kills(index) {
  self endon("death");
  while (1) {
    self waittill("killed", player);
    level.dog_usage[index].kills++;
  }
}
dog_owner_kills(index) {
  if(!isDefined(self.script_owner))
    return;
  self endon("clear_owner");
  self endon("death");
  self.script_owner endon("disconnect");
  while (1) {
    self waittill("killed", player);
    if(isDefined(self.script_owner)) {
      self.script_owner notify("dog_handler");
    }
  }
}
dog_usage_time_alive(index) {
  self endon("leaving");
  self waittill("death");
  level.dog_usage[index].death_time = GetTime();
  level.dog_usage[index].died = true;
  seconds = (level.dog_usage[index].death_time - level.dog_usage[index].spawn_time) / 1000;
}
dogHealthRegen() {
  self endon("death");
  self endon("end_healthregen");
  if(self.health <= 0) {
    assert(!isalive(self));
    return;
  }
  maxhealth = self.health;
  oldhealth = maxhealth;
  dog = self;
  health_add = 0;
  regenRate = 0.1;
  veryHurt = false;
  lastSoundTime_Recover = 0;
  hurtTime = 0;
  newHealth = 0;
  for (;;) {
    wait(0.05);
    if(dog.health == maxhealth) {
      veryHurt = false;
      continue;
    }
    if(dog.health <= 0)
      return;
    wasVeryHurt = veryHurt;
    ratio = dog.health / maxHealth;
    if(ratio <= 0.55) {
      veryHurt = true;
      if(!wasVeryHurt) {
        hurtTime = gettime();
      }
    }
    if(dog.health >= oldhealth) {
      if(gettime() - hurttime < level.dogHealth_RegularRegenDelay)
        continue;
      if(level.dogHealthRegenDisabled)
        continue;
      if(veryHurt) {
        newHealth = ratio;
        if(gettime() > hurtTime + 3000)
          newHealth += regenRate;
      } else
        newHealth = 1;
      if(newHealth >= 1.0) {
        newHealth = 1.0;
      }
      if(newHealth <= 0) {
        return;
      }
      dog setnormalhealth(newHealth);
      oldhealth = dog.health;
      continue;
    }
    oldhealth = dog.health;
    health_add = 0;
    hurtTime = gettime();
  }
}
selfDefenseChallenge() {
  self waittill("death", attacker);
  if(isDefined(attacker) && isPlayer(attacker)) {
    if(isDefined(self.script_owner) && self.script_owner == attacker)
      return;
    if(level.teambased && isDefined(self.script_owner) && self.script_owner.team == attacker.team)
      return;
    attacker notify("selfdefense_dog");
  }
}
dog_get_exit_node() {
  return getclosest(self.origin, level.dogexitnodes);
}
dog_debug_print(message) {}
getAllOtherPlayers() {
  aliveplayers = [];
  for (i = 0; i < level.players.size; i++) {
    if(!isDefined(level.players[i]))
      continue;
    player = level.players[i];
    if(player.sessionstate != "playing" || player == self)
      continue;
    aliveplayers[aliveplayers.size] = player;
  }
  return aliveplayers;
}
dog_pick_node_near_team(nodes, team) {
  if(!isDefined(nodes))
    return undefined;
  if(!level.teambased)
    return dog_pick_node_away_from_enemy(level.dogspawnnodes, team);
  initWeights(nodes);
  update_all_nodes(nodes, team);
  obj = spawnstruct();
  getAllAlliedAndEnemyPlayers(obj, team);
  numplayers = obj.allies.size + obj.enemies.size;
  alliedDistanceWeight = 2;
  dogDistanceWeight = 3;
  myTeam = team;
  enemyTeam = getOtherTeam(myTeam);
  for (i = 0; i < nodes.size; i++) {
    node = nodes[i];
    node.weight = 0;
    if(node.numPlayersAtLastUpdate > 0) {
      allyDistSum = node.distSum[myTeam];
      enemyDistSum = node.distSum[enemyTeam];
      node.weight = (enemyDistSum - alliedDistanceWeight * allyDistSum) / node.numPlayersAtLastUpdate;
    }
    if(node.numDogsAtLastUpdate > 0) {
      dogDistSum = node.distSum["dogs"];
      node.weight -= (dogDistSum * dogDistSum) / node.numDogsAtLastUpdate;
    }
  }
  avoidSpawnReuse(nodes);
  avoidEnemies(nodes, team, true);
  result = dog_pick_node_final(nodes, team, obj.enemies);
  return result;
}
dog_pick_node_away_from_enemy(nodes, team) {
  if(!isDefined(nodes))
    return undefined;
  initWeights(nodes);
  update_all_nodes(nodes, team);
  aliveplayers = getAllOtherPlayers();
  idealDist = 1600;
  badDist = 1200;
  if(aliveplayers.size > 0) {
    for (i = 0; i < nodes.size; i++) {
      totalDistFromIdeal = 0;
      nearbyBadAmount = 0;
      for (j = 0; j < aliveplayers.size; j++) {
        dist = distance(nodes[i].origin, aliveplayers[j].origin);
        if(dist < badDist)
          nearbyBadAmount += (badDist - dist) / badDist;
        distfromideal = abs(dist - idealDist);
        totalDistFromIdeal += distfromideal;
      }
      avgDistFromIdeal = totalDistFromIdeal / aliveplayers.size;
      wellDistancedAmount = (idealDist - avgDistFromIdeal) / idealDist;
      nodes[i].weight = wellDistancedAmount - nearbyBadAmount * 2 + randomfloat(.2);
    }
  }
  avoidSpawnReuse(nodes);
  avoidEnemies(nodes, team, true);
  return dog_pick_node_final(nodes, team, aliveplayers);
}
dog_pick_node_random(nodes, team) {
  if(!isDefined(nodes))
    return undefined;
  for (i = 0; i < nodes.size; i++) {
    j = randomInt(nodes.size);
    node = nodes[i];
    nodes[i] = nodes[j];
    nodes[j] = node;
  }
  return dog_pick_node_final(nodes, team, undefined, false);
}
dog_pick_node_final(nodes, team, enemies, useweights) {
  bestnode = undefined;
  if(!isDefined(nodes) || nodes.size == 0)
    return undefined;
  if(!isDefined(useweights))
    useweights = true;
  if(useweights) {
    bestnode = getBestWeightedNode(nodes, team, enemies);
  } else {
    for (i = 0; i < nodes.size; i++) {
      if(positionWouldTelefrag(nodes[i].origin))
        continue;
      bestnode = nodes[i];
      break;
    }
  }
  if(!isDefined(bestnode)) {
    if(useweights) {
      bestnode = nodes[randomint(nodes.size)];
    } else {
      bestnode = nodes[0];
    }
  }
  self finalizeNodeChoice(bestnode);
  return bestnode;
}
getBestWeightedNode(nodes, team, enemies) {
  maxSightTracedNodes = 3;
  for (
    try = 0;
    try <= maxSightTracedNodes;
    try ++) {
    bestnodes = [];
    bestweight = undefined;
    bestnode = undefined;
    for (i = 0; i < nodes.size; i++) {
      if(!isDefined(bestweight) || nodes[i].weight > bestweight) {
        if(positionWouldTelefrag(nodes[i].origin))
          continue;
        bestnodes = [];
        bestnodes[0] = nodes[i];
        bestweight = nodes[i].weight;
      } else if(nodes[i].weight == bestweight) {
        if(positionWouldTelefrag(nodes[i].origin))
          continue;
        bestnodes[bestnodes.size] = nodes[i];
      }
    }
    if(bestnodes.size == 0)
      return undefined;
    bestnode = bestnodes[randomint(bestnodes.size)];
    if(
      try == maxSightTracedNodes)
      return bestnode;
    if(isDefined(bestnode.lastSightTraceTime) && bestnode.lastSightTraceTime == gettime())
      return bestnode;
    if(!lastMinuteSightTraces(bestnode, team, enemies))
      return bestnode;
    penalty = getLosPenalty();
    bestnode.weight -= penalty;
    bestnode.lastSightTraceTime = gettime();
  }
}
finalizeNodeChoice(node) {
  time = getTime();
  self.lastnode = node;
  self.lastspawntime = time;
  node.lastspawneddog = self;
  node.lastspawntime = time;
}
getLosPenalty() {
  return 100000;
}
lastMinuteSightTraces(node, dog_team, enemies) {
  team = "all";
  if(level.teambased)
    team = getOtherTeam(dog_team);
  if(!isDefined(enemies))
    return false;
  closest = undefined;
  closestDistsq = undefined;
  secondClosest = undefined;
  secondClosestDistsq = undefined;
  for (i = 0; i < enemies.size; i++) {
    player = node.nearbyPlayers[team][i];
    if(!isDefined(player))
      continue;
    if(player.sessionstate != "playing")
      continue;
    if(player == self)
      continue;
    distsq = distanceSquared(node.origin, player.origin);
    if(!isDefined(closest) || distsq < closestDistsq) {
      secondClosest = closest;
      secondClosestDistsq = closestDistsq;
      closest = player;
      closestDistSq = distsq;
    } else if(!isDefined(secondClosest) || distsq < secondClosestDistSq) {
      secondClosest = player;
      secondClosestDistSq = distsq;
    }
  }
  if(isDefined(closest)) {
    if(bullettracepassed(closest.origin + (0, 0, 50), node.origin + (0, 0, 50), false, undefined))
      return true;
  }
  if(isDefined(secondClosest)) {
    if(bullettracepassed(secondClosest.origin + (0, 0, 50), node.origin + (0, 0, 50), false, undefined))
      return true;
  }
  return false;
}
update_all_nodes(nodes, team) {
  for (i = 0; i < nodes.size; i++) {
    nodeUpdate(nodes[i], team);
  }
}
avoidEnemies(nodes, team, teambased) {
  lospenalty = getLosPenalty();
  otherteam = "axis";
  if(team == "axis")
    otherteam = "allies";
  minDistTeam = otherteam;
  if(!teambased) {
    minDistTeam = "all";
  }
  avoidWeight = GetDvarFloat(#"scr_spawn_enemyavoidweight");
  if(avoidWeight != 0) {
    nearbyEnemyOuterRange = GetDvarFloat(#"scr_spawn_enemyavoiddist");
    nearbyEnemyOuterRangeSq = nearbyEnemyOuterRange * nearbyEnemyOuterRange;
    nearbyEnemyPenalty = 1500 * avoidWeight;
    nearbyEnemyMinorPenalty = 800 * avoidWeight;
    lastAttackerOrigin = (-99999, -99999, -99999);
    lastDeathPos = (-99999, -99999, -99999);
    for (i = 0; i < nodes.size; i++) {
      mindist = nodes[i].minDist[minDistTeam];
      if(mindist < nearbyEnemyOuterRange * 2) {
        penalty = nearbyEnemyMinorPenalty * (1 - mindist / (nearbyEnemyOuterRange * 2));
        if(mindist < nearbyEnemyOuterRange)
          penalty += nearbyEnemyPenalty * (1 - mindist / nearbyEnemyOuterRange);
        if(penalty > 0) {
          nodes[i].weight -= penalty;
        }
      }
    }
  }
}
nodeUpdate(node, team) {
  if(level.teambased) {
    node.sights["axis"] = 0;
    node.sights["allies"] = 0;
    node.nearbyPlayers["axis"] = [];
    node.nearbyPlayers["allies"] = [];
  } else {
    node.sights = 0;
    node.nearbyPlayers["all"] = [];
  }
  node.nearbyDogs = [];
  nodedir = node.forward;
  debug = false;
  node.distSum["all"] = 0;
  node.distSum["allies"] = 0;
  node.distSum["axis"] = 0;
  node.distSum["dogs"] = 0;
  node.minDist["all"] = 9999999;
  node.minDist["allies"] = 9999999;
  node.minDist["axis"] = 9999999;
  node.minDist["dogs"] = 9999999;
  node.numPlayersAtLastUpdate = 0;
  node.numDogsAtLastUpdate = 0;
  for (i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(player.sessionstate != "playing")
      continue;
    diff = player.origin - node.origin;
    diff = (diff[0], diff[1], 0);
    dist = length(diff);
    player_team = "all";
    if(level.teambased)
      player_team = player.team;
    if(dist < 1024) {
      node.nearbyPlayers[player_team][node.nearbyPlayers[player_team].size] = player;
    }
    if(dist < node.minDist[player_team])
      node.minDist[player_team] = dist;
    node.distSum[player_team] += dist;
    node.numPlayersAtLastUpdate++;
  }
  for (i = 0; i < level.dogs.size; i++) {
    dog = level.dogs[i];
    if(!isDefined(dog) || !isalive(dog))
      continue;
    diff = dog.origin - node.origin;
    diff = (diff[0], diff[1], 0);
    dist = length(diff);
    if(dist < 1024) {
      node.nearbyDogs[node.nearbyDogs.size] = dog;
    }
    if(dist < node.minDist["dogs"])
      node.minDist["dogs"] = dist;
    node.distSum["dogs"] += dist;
    node.numDogsAtLastUpdate++;
  }
}
initWeights(nodes) {
  for (i = 0; i < nodes.size; i++)
    nodes[i].weight = 0;
}
getAllAlliedAndEnemyPlayers(obj, team) {
  if(level.teambased) {
    if(team == "allies") {
      obj.allies = level.alivePlayers["allies"];
      obj.enemies = level.alivePlayers["axis"];
    } else {
      assert(team == "axis");
      obj.allies = level.alivePlayers["axis"];
      obj.enemies = level.alivePlayers["allies"];
    }
  } else {
    obj.allies = [];
    obj.enemies = level.activePlayers;
  }
}
avoidSpawnReuse(nodes) {
  time = getTime();
  maxtime = 3 * 1000;
  maxdistSq = 1024 * 1024;
  for (i = 0; i < nodes.size; i++) {
    node = nodes[i];
    if(!isDefined(node.lastspawntime))
      continue;
    timepassed = time - node.lastspawntime;
    if(timepassed < maxtime) {
      worsen = 1000 * (1 - timepassed / maxtime);
      node.weight -= worsen;
    }
  }
}
flash_dogs(area) {
  self endon("disconnect");
  if(isDefined(level.dogs)) {
    for (i = 0; i < level.dogs.size; i++) {
      dog = level.dogs[i];
      if(!isalive(dog))
        continue;
      if(dog istouching(area)) {
        do_flash = true;
        if(isPlayer(self)) {
          if(level.teamBased && (dog.aiteam == self.team)) {
            do_flash = false;
          } else if(!level.teambased && isDefined(dog.script_owner) && self == dog.script_owner) {
            do_flash = false;
          }
        }
        if(isDefined(dog.lastFlashed) && dog.lastFlashed + 1500 > gettime()) {
          do_flash = false;
        }
        if(do_flash) {
          dog setFlashBanged(true, 500);
          dog.lastFlashed = gettime();
        }
      }
    }
  }
}