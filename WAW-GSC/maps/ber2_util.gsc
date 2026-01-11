/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber2_util.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#using_animtree("generic_human");

get_playerone() {
  return get_players()[0];
}

is_player() {
  playerFound = false;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(players[i] == self) {
      playerFound = true;
      break;
    }
  }
  return playerFound;
}

waittill_all_players_touching(trig) {
  if(!isDefined(trig)) {
    ASSERTMSG("waittill_all_players_touching: the trigger is undefined! aborting...");
    return;
  }
  while(1) {
    players = get_players();
    numThere = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i] IsTouching(trig)) {
        numThere++;
      }
    }
    if(numThere >= players.size) {
      break;
    } else {
      wait(0.1);
    }
  }
}

waittill_any_player_touching(trig) {
  if(!isDefined(trig)) {
    ASSERTMSG("waittill_all_players_touching: the trigger is undefined! aborting...");
    return;
  }
  foundOne = false;
  while(!foundOne) {
    players = get_players();
    foundOne = false;
    for(i = 0; i < players.size; i++) {
      if(players[i] IsTouching(trig)) {
        foundOne = true;
      }
    }
    if(!foundOne) {
      wait(0.1);
    }
  }
}

generic_rumble_explosion() {
  self endon("death");
  self endon("disconnect");
  self PlayRumbleOnEntity("explosion_generic_no_broadcast");
}

generic_rumble_loop(duration, intensity) {
  self endon("death");
  self endon("disconnect");
  firstWait = 0.2;
  self PlayRumbleOnEntity("explosion_generic_no_broadcast");
  wait(firstWait);
  loopingRumble = "damage_heavy";
  if(isDefined(intensity) && intensity == "light") {
    loopingRumble = "damage_light";
  }
  self PlayRumbleLoopOnEntity(loopingRumble);
  wait(duration - firstWait);
  self StopRumble(loopingRumble);
}

grab_starting_friends() {
  startguys = getEntArray("starting_allies", "targetname");
  ASSERT(isDefined(startguys) && startguys.size > 0, "grab_starting_guys(): can't find the starting guys!");
  return startguys;
}

set_color_chain(trigTN) {
  color_trigger = GetEnt(trigTN, "targetname");
  ASSERTEX(isDefined(color_trigger), "color_trigger " + trigTN + " is not defined!");
  color_trigger notify("trigger");
}

friend_follow_player(interval, followdist) {
  self endon("death");
  level endon("friend_follow_player_stop");
  if(!isDefined(self.goalradius)) {
    println("friend_follow_player(): a friendly's goalradius wasn't defined! aborting.");
    return;
  }
  if(!isDefined(interval) || interval <= 0) {
    interval = 0.5;
  }
  while(1) {
    if(isDefined(self) && IsAlive(self)) {
      if(DistanceSquared(level.player.origin, self.origin) > (followdist * followdist)) {
        self SetGoalPos(level.player.origin);
      }
    }
    wait(interval);
  }
}

friend_add() {
  flag_wait("friends_setup");
  if(!isDefined(level.friends)) {
    ASSERTMSG("Tried to add a guy to level.friends but level.friends is not defined.");
    return;
  }
  if(!IsAlive(self)) {
    ASSERTMSG("Tried to add a guy to level.friends but the entity is not alive.");
    return;
  }
  level.friends = array_add(level.friends, self);
  self SetThreatBiasGroup("friends");
  self thread friend_remove_on_death();
}

friend_remove_on_death() {
  self waittill("death");
  self friend_remove();
}

friend_remove() {
  flag_wait("friends_setup");
  if(isDefined(level.friends)) {
    level.friends = array_remove(level.friends, self);
  }
}

get_friends(includeSarge) {
  if(!isDefined(includeSarge)) {
    includeSarge = false;
  }
  friends = [];
  for(i = 0; i < level.friends.size; i++) {
    guy = level.friends[i];
    if(is_active_ai(guy)) {
      if(!includeSarge && (guy == level.sarge)) {
        continue;
      } else {
        friends[friends.size] = guy;
      }
    }
  }
  return friends;
}

get_friends_by_color(colorCode) {
  colorguys = [];
  for(i = 0; i < level.friends.size; i++) {
    guy = level.friends[i];
    if(guy check_force_color(colorCode)) {
      colorguys[colorguys.size] = guy;
    }
  }
  return colorguys;
}

ignore_til_path_end() {
  self endon("death");
  self thread disable_arrivalsandexits_til_lastnode();
  self thread ignore_til_path_end_interrupt();
  self.ignoreall = true;
  self waittill("reached_path_end");
  self.ignoreall = false;
}

ignore_til_path_end_or_dmg() {
  self endon("death");
  self thread disable_arrivalsandexits_til_lastnode();
  self thread ignore_til_path_end_interrupt();
  self.ignoreall = true;
  self waittill_either("reached_path_end", "damage");
  self.ignoreall = false;
}

ignore_til_path_end_interrupt() {
  self endon("death");
  self endon("reached_path_end");
  while(1) {
    origin = self.origin;
    wait 2;
    if(self.origin == origin) {
      self.ignoreall = false;
      self.goalradius = 1024;
      return;
    }
  }
}

disable_arrivalsandexits_til_lastnode() {
  self endon("death");
  self endon("arrivalsandexits_enabled");
  self.disableArrivals = true;
  self.disableExits = true;
  self thread disable_arrivalsandexits_dmg_watcher();
  node = GetNode(self.target, "targetname");
  while(isDefined(node.target)) {
    self waittill("goal");
    node = GetNode(node.target, "targetname");
  }
  self.disableArrivals = false;
  self.disableExits = false;
}

disable_arrivalsandexits_dmg_watcher() {
  self endon("death");
  self endon("reached_path_end");
  self waittill("damage");
  self notify("arrivalsandexits_enabled");
  self.disableArrivals = false;
  self.disableExits = false;
}

get_spawners_and_spawn_group(spawnerVal, spawnerKey) {
  spawners = getEntArray(spawnerVal, spawnerKey);
  if(!isDefined(spawners) || spawners.size <= 0) {
    ASSERTMSG("get_spawners_and_spawn_group(): couldn't find spawners with KVP of " + spawnerKey + "/" + spawnerVal);
    return;
  }
  return spawn_group(spawners);
}

spawn_group(spawners) {
  if(!isDefined(spawners) || spawners.size <= 0) {
    ASSERTMSG("spawn_group: spawners array was empty or undefined.");
    return;
  }
  guys = [];
  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i])) {
      guy = spawn_guy(spawners[i]);
      if(isDefined(guy)) {
        guys[guys.size] = guy;
      }
    }
  }
  if(guys.size <= 0) {
    ASSERTMSG("spawn_group: couldn't spawn anybody from the spawners provided.do they need to be forcespawned?");
  }
  return guys;
}

spawn_guy(spawner, spawn_func) {
  if(isDefined(spawn_func)) {
    spawner add_spawn_function(spawn_func);
  }
  if(isDefined(spawner.script_forcespawn) && spawner.script_forcespawn > 0) {
    ai = spawner Stalingradspawn();
  } else {
    ai = spawner Dospawn();
  }
  spawn_failed(ai);
  if(isDefined(ai) && !isDefined(ai.targetname)) {
    ai.targetname = spawner.targetname + "_alive";
  }
  return ai;
}

get_closest_from_group(testOrg, group, excludeMe, backup_spawner) {
  doExclude = isDefined(excludeMe);
  closest = undefined;
  for(i = 0; i < group.size; i++) {
    if(!isDefined(group[i])) {
      continue;
    }
    if(isDefined(closest)) {
      if(Closer(testOrg, group[i].origin, closest.origin)) {
        if(doExclude) {
          if(group[i] != excludeMe) {
            closest = group[i];
          }
        } else {
          closest = group[i];
        }
      }
    } else {
      if(doExclude) {
        if(group[i] != excludeMe) {
          closest = group[i];
        }
      } else {
        closest = group[i];
      }
    }
  }
  if(!isDefined(closest)) {
    if(isDefined(backup_spawner)) {
      spawner = getent(backup_spawner, "targetname");
      spawnedGuy = spawner Stalingradspawn();
      spawn_failed(spawnedGuy);
      return spawnedGuy;
    }
  }
  return closest;
}

get_randomfriend() {
  while(1) {
    guy = level.friends[RandomInt(level.friends.size)];
    if(is_active_ai(guy)) {
      return guy;
    } else {
      wait(0.05);
    }
  }
}

get_randomfriend_excluding(thisGuy) {
  newguy = thisGuy;
  while(newguy == thisGuy) {
    newguy = get_randomfriend();
    if(newguy == thisGuy) {
      wait(0.05);
    }
  }
  return newguy;
}

get_randomfriend_notsarge() {
  return get_randomfriend_excluding(level.sarge);
}

get_randomfriend_notsarge_excluding(thisGuy) {
  newguy = thisGuy;
  while(newguy == thisGuy) {
    newguy = get_randomfriend_excluding(thisGuy);
    if(newguy == level.sarge) {
      newguy = thisGuy;
    }
    if(newguy == thisGuy) {
      wait(0.05);
    }
  }
  return newguy;
}

playsound_generic_facial(sound, lookTarget) {
  self endon("death");
  self endon("disconnect");
  notifyString = "sound_done";
  self thread anim_facialFiller(notifyString, lookTarget);
  self animscripts\face::SaySpecificDialogue(undefined, sound, 1.0, notifyString);
  self waittill(notifyString);
}

sarge_giveorder_soundonly(order, waitForEnd) {
  level.sarge say_dialogue("sarge", order, waitForEnd, undefined, true);
}

sarge_giveorder(order, waitForEnd) {
  level.sarge say_dialogue("sarge", order, waitForEnd);
}

say_dialogue_randomfriend(animname, theLine, waitForEnd) {
  speaker = get_randomfriend();
  speaker say_dialogue(animname, theLine, waitForEnd);
}

say_dialogue_notsarge_soundonly(animname, theLine, waitForEnd) {
  say_dialogue_notsarge(animname, theLine, waitForEnd, true);
}

say_dialogue_notsarge(animname, theLine, waitForEnd, soundOnly) {
  speaker = get_randomfriend_notsarge();
  speaker say_dialogue(animname, theLine, waitForEnd, undefined, soundOnly);
}

say_dialogue(animname, theLine, waitForEnd, giveMagicBulletShield, soundOnly) {
  ASSERTEX(is_active_ai(self), "play_dialogue(): the entity that's supposed to be speaking is not an active AI.");
  if(!isDefined(waitForEnd)) {
    waitForEnd = false;
  }
  if(!isDefined(giveMagicBulletShield)) {
    giveMagicBulletShield = true;
  }
  if(!isDefined(soundOnly)) {
    soundOnly = false;
  }
  if(!soundOnly) {
    self.og_animname = self.animname;
    self.animname = animname;
  }
  if(giveMagicBulletShield) {
    if(!isDefined(self.magic_bullet_shield) || !self.magic_bullet_shield) {
      self thread magic_bullet_shield();
      self.say_dialogue_bullet_shield = true;
    }
  }
  if(is_active_ai(self)) {
    if(!soundOnly) {
      self thread anim_single_solo(self, theLine);
    } else {
      self thread animscripts\face::SaySpecificDialogue(undefined, level.scr_sound[animname][theLine], 1.0, "soundOnly_done");
    }
  }
  if(waitForEnd) {
    if(!soundOnly) {
      self waittill(theLine);
    } else {
      self waittill("soundOnly_done");
    }
  }
  if(!soundOnly) {
    self.animname = self.og_animname;
  }
  if(giveMagicBulletShield) {
    if(isDefined(self.say_dialogue_bullet_shield) && self.say_dialogue_bullet_shield) {
      self notify("stop magic bullet shield");
    }
  }
}

set_animname_custom(newAnimname) {
  self.ogAnimname = self.animname;
  self.animname = newAnimname;
}

reset_animname() {
  if(!isDefined(self.ogAnimname)) {
    return;
  }
  self.animname = self.ogAnimname;
  self.ogAnimname = undefined;
}

magic_bullet_shield_safe() {
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    return;
  }
  self thread magic_bullet_shield();
}

stop_magic_bullet_shield_safe() {
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    self thread stop_magic_bullet_shield();
  }
}

scr_ignoreme(b) {
  if(isDefined(self)) {
    self.ignoreme = b;
  }
}

scr_ignoreall(b) {
  if(isDefined(self)) {
    self.ignoreall = b;
  }
}

scr_notify(n) {
  if(isDefined(self)) {
    self notify(n);
  }
}

remove_gear() {
  if(isDefined(self.gearmodel)) {
    self Detach(self.gearmodel, "");
  }
}

ais_wetness_change(wetness, changeTime, topDown, team) {
  if(!isDefined(level._wetness_monitor)) {
    level thread wetness_monitor();
    level._wetness_monitor = 1;
  }
  if(isDefined(team)) {
    if(team != "axis" && team != "allies") {
      ASSERTMSG("ais_wetness_change(): team name of " + team + " is not recognized.Use 'allies' or 'axis'.");
      return;
    }
  }
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    addSpawnFunc = false;
    if(isDefined(team)) {
      if(team == "allies" && IsSubStr(spawners[i].classname, "ally")) {
        addSpawnFunc = true;
      } else if(team == "axis" && IsSubStr(spawners[i].classname, "axis")) {
        addSpawnFunc = true;
      }
    } else {
      addSpawnFunc = true;
    }
    if(addSpawnFunc) {
      spawners[i] thread ai_wetness_change_spawnfunc(wetness, changeTime, topDown);
    }
  }
  ais = undefined;
  if(isDefined(team)) {
    if(team == "allies" || team == "axis") {
      ais = GetAIArray(team);
    }
  } else {
    ais = GetAIArray();
  }
  for(i = 0; i < ais.size; i++) {
    if(is_active_ai(ais[i])) {
      ais[i] thread friendly_ai_getwet(wetness, changeTime, topDown);
      wait(RandomFloatRange(0.1, 0.35));
    }
  }
}

ai_wetness_change_spawnfunc(wetness, changeTime, topDown) {
  self notify("kill_getwet_spawnfunc");
  self endon("kill_getwet_spawnfunc");
  while(1) {
    self waittill("spawned", spawn);
    if(maps\_utility::spawn_failed(spawn)) {
      continue;
    }
    wait(RandomFloatRange(0.05, 0.15));
    spawn thread friendly_ai_getwet(wetness, changeTime, topDown);
  }
}

friendly_ai_getwet(wetness, changeTime, topDown) {
  self endon("death");
  if(!isDefined(self.wetness)) {
    self.wetness = 0;
  }
  self ai_wetness_change(wetness, changeTime, topDown);
}

ai_wetness_change(wetness, changeTime, topDown) {
  self endon("death");
  targetWetness = wetness;
  if(!isDefined(self.wetness) || changeTime <= 0) {
    waittill_okTospawn();
    self SetWetness(wetness, topDown);
    level._num_wetness++;
    self.wetness = wetness;
  } else {
    frameTime = 0.1;
    frames = changeTime / frameTime;
    if(!frames) {
      return;
    }
    wetDiff = wetness - self.wetness;
    wetPerFrame = wetDiff / frames;
    for(i = 0; i < frames; i++) {
      self.wetness += wetPerFrame;
      waittill_okTospawn();
      self SetWetness(self.wetness, topDown);
      level._num_wetness++;
      wait(frameTime);
    }
  }
  if(self.wetness != targetWetness) {
    self.wetness = targetWetness;
    waittill_okTospawn();
    self SetWetness(self.wetness, topDown);
    level._num_wetness++;
  }
}

wetness_monitor() {
  level._num_wetness = 0;
  while(1) {
    wait_network_frame();
    level._num_wetness = 0;
  }
}

waittill_okTospawn() {
  if(NumRemoteClients()) {
    while(level._num_wetness > 1) {
      wait(RandomFloatRange(0.05, 0.5));
    }
  }
}

schoolcircle(nodename, guys, leader, leaderWait) {
  level endon("abort_schoolcircle");
  nodearray = GetNodeArray(nodename, "targetname");
  totalGuys = guys.size;
  if(isDefined(leader)) {
    ASSERTEX(is_active_ai(leader), "Leader is not an active AI.");
    totalGuys++;
  }
  ASSERTEX(nodearray.size >= totalGuys, "You have more guys than nodes for them to go to.");
  level.schoolcircle_goals = 0;
  if(isDefined(leader)) {
    leaderNode = undefined;
    for(i = 0; i < nodearray.size; i++) {
      if(isDefined(nodearray[i].script_noteworthy) && nodearray[i].script_noteworthy == "leader") {
        leaderNode = nodearray[i];
        break;
      }
    }
    if(!isDefined(leaderNode)) {
      leaderNode = nodearray[0];
    }
    nodearray = array_remove(nodearray, leaderNode);
    leader thread schoolcircle_nav(leaderNode);
    level notify("schoolcircle_leader_moving");
    if(isDefined(leaderWait) && leaderWait >= 0) {
      wait(leaderWait);
    } else {
      wait(2.5);
    }
  }
  for(i = 0; i < guys.size; i++) {
    guys[i] thread schoolcircle_nav(nodearray[i]);
  }
  while(level.schoolcircle_goals < totalGuys) {
    wait(0.1);
  }
  level notify("schoolcircle_assembled");
}

schoolcircle_nav(node) {
  self endon("death");
  level endon("abort_schoolcircle");
  self.og_goalradius = self.goalradius;
  self.goalradius = 16;
  self.dontavoidplayer = true;
  self AllowedStances("stand");
  self SetGoalNode(node);
  if(isDefined(node.script_stance) && node.script_stance == "crouch") {
    self thread schoolcircle_crouch();
  }
  self waittill("goal");
  level.schoolcircle_goals++;
}

schoolcircle_crouch() {
  self endon("death");
  level endon("abort_schoolcircle");
  self waittill("goal");
  self AllowedStances("crouch");
}

schoolcircle_breakup(guys, leader, randomWait) {
  newguys = guys;
  if(isDefined(leader)) {
    newguys[newguys.size] = leader;
  }
  if(!isDefined(randomWait) || randomWait < 0) {
    randomWait = 2;
  }
  array_thread(guys, ::schoolcircle_guy_reset, RandomFloat(randomWait));
}

schoolcircle_guy_reset(waitTime) {
  if(!is_active_ai(self)) {
    return;
  }
  if(isDefined(self.og_goalradius)) {
    self.goalradius = self.og_goalradius;
  }
  self.dontavoidplayer = false;
  if(isDefined(waitTime)) {
    wait(waitTime);
  }
  self AllowedStances("stand", "crouch", "prone");
}

waittill_triggerarea_clear(trig, team, maxWait) {
  startTime = GetTime();
  ais = [];
  loop = true;
  if(!isDefined(trig)) {
    println("waittill_triggerarea_clear(): trig is not defined! aborting.");
    return;
  }
  while(1) {
    foundOne = false;
    ais = GetAiArray(team);
    if(ais.size <= 0) {
      return;
    }
    for(i = 0; i < ais.size; i++) {
      guy = ais[i];
      if(guy IsTouching(trig)) {
        foundOne = true;
        continue;
      }
    }
    if(!foundOne) {
      println("waittill_triggerarea_clear(): didn't find anyone touching the trigger, done waiting.");
      break;
    }
    if(isDefined(maxWait)) {
      if((GetTime() - startTime) > (maxWait * 1000)) {
        println("waittill_triggerarea_clear(): maxWait exceeded, done waiting.");
        break;
      }
    }
    wait(0.25);
  }
}

wait_while_players_can_see(proxDist, checkInterval) {
  self endon("death");
  if(!isDefined(proxDist)) {
    proxDist = 256;
  }
  if(!isDefined(checkInterval)) {
    checkInterval = 5;
  }
  while(is_active_ai(self)) {
    playerCanSee = false;
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(SightTracePassed(players[i] getEye(), self getEye(), false, players[i]) || Distance(players[i].origin, self.origin) < proxDist) {
        playerCanSee = true;
        break;
      }
    }
    if(!playerCanSee) {
      break;
    } else {
      wait(checkInterval);
    }
  }
}

waittill_group_dies(group, maxWait, amount, kill_rest) {
  level.groupIsDead = false;
  level.groupTimerDone = false;
  if(group.size <= 0) {
    return;
  }
  if(isDefined(maxWait)) {
    level thread waittill_group_dies_timeout(maxWait);
    kill_rest = true;
  }
  if(!isDefined(amount)) {
    amount = 0;
  }
  if(!isDefined(kill_rest)) {
    kill_rest = true;
  }
  level.deathWaitTracker = group.size;
  println("^5Waiting for " + level.deathWaitTracker + " AI to die...");
  for(i = 0; i < group.size; i++) {
    if(IsAlive(group[i])) {
      level thread death_wait(group[i], amount, kill_rest, group);
    }
  }
  while(!level.groupIsDead && !level.groupTimerDone) {
    wait(0.25);
  }
  return;
}

waittill_group_dies_timeout(timer) {
  startTime = GetTime();
  while(!level.groupIsDead && ((GetTime() - startTime) < (timer * 1000))) {
    wait(0.25);
  }
  if(!level.groupIsDead) {
    level.groupTimerDone = true;
    println("waittill_group_dies_timeout() timed out after " + timer + " seconds.Killing fools and continuing.");
  } else {
    println("waittill_group_dies_timeout() didn't get a chance to time out.");
  }
}

death_wait(ent, amount, kill_rest, group) {
  while(IsAlive(ent)) {
    if(!level.groupTimerDone) {
      wait(0.25);
    } else {
      break;
    }
  }
  level.deathWaitTracker--;
  if(!isDefined(amount)) {
    amount = 0;
  }
  if(level.deathWaitTracker <= amount) {
    if(kill_rest) {
      for(i = 0; i < group.size; i++) {
        guy = group[i];
        if(is_active_ai(guy)) {
          guy thread bloody_death(true, 3.0);
        }
      }
    }
    if(amount > 0 && level.deathWaitTracker <= 0) {
      level.groupIsDead = true;
    } else {
      level.groupIsDead = true;
    }
  }
}

kill_all_axis(delay) {
  axis = GetAIArray("axis");
  if(axis.size <= 0) {
    return;
  }
  if(!isDefined(delay)) {
    delay = 0;
  }
  for(i = 0; i < axis.size; i++) {
    if(isDefined(axis[i])) {
      axis.health = 1;
      axis[i] thread bloody_death(true, delay);
    }
  }
}

kill_aigroup_at_flag(flagString, aigroup, maxDelay) {
  flag_wait(flagString);
  kill_aigroup(aigroup, maxDelay);
}

kill_aigroup_at_trigger(trigVal, trigKey, aigroup, maxDelay) {
  trigger_wait(trigVal, trigKey);
  kill_aigroup(aigroup, maxDelay);
}

kill_aigroup(aigroup, maxDelay) {
  ais = get_ai_group_ai(aigroup);
  if(!isDefined(ais) || ais.size <= 0) {
    return;
  }
  if(!isDefined(maxDelay) || maxDelay <= 0) {
    maxDelay = 0;
  }
  array_thread(ais, ::kill_aigroup_ai, maxDelay);
}

kill_aigroup_ai(maxDelay) {
  self endon("death");
  self wait_while_players_can_see(400, 2.5);
  self thread bloody_death(true, maxDelay);
}

bloody_death(die, delay) {
  self endon("death");
  if(!IsSentient(self) || !IsAlive(self)) {
    return;
  }
  if(isDefined(self.bloody_death) && self.bloody_death) {
    return;
  }
  self.bloody_death = true;
  if(isDefined(delay)) {
    wait(RandomFloat(delay));
  }
  tags = [];
  tags[0] = "j_hip_le";
  tags[1] = "j_hip_ri";
  tags[2] = "j_head";
  tags[3] = "j_spine4";
  tags[4] = "j_elbow_le";
  tags[5] = "j_elbow_ri";
  tags[6] = "j_clavicle_le";
  tags[7] = "j_clavicle_ri";
  for(i = 0; i < 3 + RandomInt(5); i++) {
    random = RandomIntRange(0, tags.size);
    self thread bloody_death_fx(tags[random], undefined);
    wait(RandomFloat(0.1));
  }
  if(die) {
    self DoDamage(self.health + 50, self.origin);
  }
}

bloody_death_fx(tag, fxName) {
  if(!isDefined(fxName)) {
    fxName = level._effect["flesh_hit"];
  }
  playFXOnTag(fxName, self, tag);
}

is_active_ai(suspect) {
  if(isDefined(suspect) && IsSentient(suspect) && IsAlive(suspect)) {
    return true;
  } else {
    return false;
  }
}

is_group_dead(group) {
  for(i = 0; i < group.size; i++) {
    if(isDefined(group[i])) {
      if(IsAlive(group[i])) {
        return false;
      }
    }
  }
  return true;
}

waittill_all_ais_touching(ais, trig) {
  if(!isDefined(trig)) {
    ASSERTMSG("waittill_all_ais_touching: the trigger is undefined! aborting...");
    return;
  }
  while(1) {
    for(i = 0; i < ais.size; i++) {
      guy = ais[i];
      if(!is_active_ai(guy)) {
        ASSERTMSG("waittill_all_ais_touching(): Found a non-AI in the AI array that was passed in.");
      }
    }
    numThere = 0;
    for(i = 0; i < ais.size; i++) {
      if(ais[i] IsTouching(trig)) {
        numThere++;
      }
    }
    if(numThere >= ais.size) {
      break;
    } else {
      wait(0.1);
    }
  }
}

stop_ignoring_player_when_shot(notifyString1, notifyString2, ignoreEnemy) {
  self.allowdeath = true;
  self.ignoreall = true;
  self.og_health = self.health;
  self.health = 1;
  self thread notify_grenade_danger();
  if(isDefined(ignoreEnemy) && ignoreEnemy) {
    self thread stop_ignoring_player_when_close(true);
    self waittill_any("bulletwhizby", "grenadedanger", "suppression", "death");
  } else {
    self thread stop_ignoring_player_when_close(false);
    self waittill_any("bulletwhizby", "grenadedanger", "suppression", "enemy", "death");
  }
  if(isDefined(self) && IsAlive(self)) {
    self.ignoreall = false;
    self.health = self.og_health;
  }
  if(isDefined(notifyString1)) {
    level notify(notifyString1);
  }
  if(isDefined(notifyString2)) {
    level notify(notifyString2);
  }
}

notify_grenade_danger() {
  self endon("bulletwhizby");
  self endon("suppression");
  self endon("death");
  dangerDist = 256;
  while(1) {
    grenades = getEntArray("grenade", "classname");
    for(i = 0; i < grenades.size; i++) {
      if(Distance(grenades[i].origin, self.origin) < dangerDist) {
        self notify("grenadedanger");
        return;
      }
    }
    wait(0.1);
  }
}

stop_ignoring_player_when_close(ignoreEnemy) {
  self endon("bulletwhizby");
  self endon("grenadedanger");
  self endon("suppression");
  self endon("death");
  disableProxcheck = GetDvarInt("disable_ai_player_proxcheck");
  if(isDefined(disableProxcheck) && disableProxcheck > 0) {
    return;
  }
  if(!isDefined(ignoreEnemy) || !ignoreEnemy) {
    self endon("enemy");
  }
  alertDist = 200;
  if(isDefined(self.proxAlertDist)) {
    alertDist = self.proxAlertDist;
  }
  while(1) {
    players = get_players();
    foundOne = false;
    for(i = 0; i < players.size; i++) {
      if(Distance(players[i].origin, self.origin) < alertDist) {
        foundOne = true;
        break;
      }
    }
    if(foundOne) {
      break;
    }
    wait(0.1);
  }
  self notify("bulletwhizby");
}

spawner_think(ent) {
  self endon("death");
  self waittill("spawned", spawn);
  ent.guys[ent.guys.size] = spawn;
  ent notify("spawned_guy");
}

set_random_gib() {
  refs = [];
  refs[refs.size] = "right_arm";
  refs[refs.size] = "left_arm";
  refs[refs.size] = "right_leg";
  refs[refs.size] = "left_leg";
  refs[refs.size] = "no_legs";
  refs[refs.size] = "guts";
  self.a.gib_ref = get_random(refs);
}

guy_stay_on_turret(guy, turret, ender) {
  if(isDefined(ender)) {
    level endon(ender);
  }
  turret endon("death");
  guy endon("death");
  level thread maps\_mgturret::mg42_setdifficulty(turret, getdifficulty());
  turret setmode("auto_ai");
  turret SetTurretIgnoreGoals(true);
  while(1) {
    if(!isDefined(guy GetTurret())) {
      guy UseTurret(turret);
    }
    wait(0.5);
  }
}

setup_eventname_triggers() {
  trigs = getEntArray("trigger_eventname", "targetname");
  if(isDefined(trigs) && trigs.size > 0) {
    array_thread(trigs, ::trigger_eventname_think);
  }
}

trigger_eventname_think() {
  if(!isDefined(self.script_string)) {
    ASSERTMSG("You need to set self.script_string to your event name on eventname trigger at origin " + self.origin);
    return;
  }
  isFocus = false;
  if(isDefined(self.script_int) && self.script_int > 0) {
    isFocus = true;
  }
  self waittill("trigger");
  level thread maps\_debug::set_event_printname(self.script_string, isFocus);
  wait(1);
  self Delete();
}

tags_debug_print(tags, ender) {
  self endon("death");
  if(isDefined(ender)) {
    level endon(ender);
  }
  while(1) {
    for(i = 0; i < tags.size; i++) {
      tag = tags[i];
      Print3D(self GetTagOrigin(tag), tag, (1, 1, 1), 1, .3);
    }
    wait(0.05);
  }
}

debug_ai() {
  xPos = 50;
  yPos = 260;
  yInc = 18;
  fontScale = 1.5;
  red = (1, 0, 0);
  white = (1, 1, 1);
  level.friends_count = NewHudElem();
  level.friends_count.alignX = "right";
  level.friends_count.fontScale = fontScale;
  level.friends_count.x = xPos;
  level.friends_count.y = yPos;
  yPos += yInc;
  level.allies_count = NewHudElem();
  level.allies_count.alignX = "right";
  level.allies_count.fontScale = fontScale;
  level.allies_count.x = xPos;
  level.allies_count.y = yPos;
  yPos += yInc;
  level.axis_count = NewHudElem();
  level.axis_count.alignX = "right";
  level.axis_count.fontScale = fontScale;
  level.axis_count.x = xPos;
  level.axis_count.y = yPos;
  yPos += yInc;
  level.total_count = NewHudElem();
  level.total_count.alignX = "right";
  level.total_count.fontScale = fontScale;
  level.total_count.x = xPos;
  level.total_count.y = yPos;
  while(1) {
    if(isDefined(level.friends)) {
      level.friends_count SetText("level.friends: " + level.friends.size);
    } else {
      level.friends_count SetText("level.friends: UNDEFINED ");
    }
    allies_ai = GetAiArray("allies");
    level.allies_count SetText("other allies: " + (allies_ai.size - level.friends.size));
    axis_ai = GetAiArray("axis");
    level.axis_count SetText("total axis: " + axis_ai.size);
    total_ai = GetAiArray("axis", "allies");
    level.total_count SetText("total ai: " + total_ai.size);
    if(total_ai.size > 28) {
      if(level.total_count.color != red) {
        level.total_count.color = red;
      }
    } else {
      if(level.total_count.color != white) {
        level.total_count FadeOverTime(1.25);
        level.total_count.color = white;
      }
    }
    wait 1;
  }
}

draw_sphere_at_origin(origin, radius, segments) {
  drawOrg = spawn("script_origin", origin);
  drawOrg thread draw_sphere(radius, segments);
}

draw_sphere(radius, segments) {
  while(1) {
    draw_sphere_axis(radius, segments, "pitch");
    draw_sphere_axis(radius, segments, "roll");
    draw_sphere_axis(radius, segments, "yaw");
    wait(0.05);
  }
}

draw_sphere_axis(radius, segments, axis) {
  self endon("death");
  if(!isDefined(axis)) {
    axis = "yaw";
  }
  points = [];
  add_angles = 360 / segments;
  angles = (0, 0, 0);
  if(axis == "pitch") {
    for(i = 0; i < segments; i++) {
      angles = angles + (add_angles, 0, 0);
      forward = anglesToForward(angles);
      points[i] = self.origin + VectorScale(forward, radius);
    }
  } else if(axis == "roll") {
    angles = angles + (0, 90, 0);
    for(i = 0; i < segments; i++) {
      angles = angles + (add_angles, 0, 0);
      forward = anglesToForward(angles);
      points[i] = self.origin + VectorScale(forward, radius);
    }
  } else {
    for(i = 0; i < segments; i++) {
      angles = angles + (0, add_angles, 0);
      forward = anglesToForward(angles);
      points[i] = self.origin + VectorScale(forward, radius);
    }
  }
  for(i = 0; i < points.size; i++) {
    if(i == (points.size - 1)) {
      Line(points[i], points[0], (1, 0, 0), 1);
    } else {
      Line(points[i], points[i + 1], (1, 0, 0), 1);
    }
  }
}

getent_safe(value, key, debugName) {
  ent = GetEnt(value, key);
  if(isDefined(debugName)) {
    debugString = "Couldn't GetEnt for: " + debugName;
  } else {
    debugString = "Couldn't GetEnt with KVP " + key + " / " + value;
  }
  if(isDefined(ent)) {
    return ent;
  } else {
    ASSERTMSG(debugString);
  }
}

getstruct_safe(value, key, debugName) {
  sstruct = GetStruct(value, key);
  if(isDefined(debugName)) {
    debugString = "Couldn't GetStruct for: " + debugName;
  } else {
    debugString = "Couldn't GetStruct with KVP " + key + " / " + value;
  }
  if(isDefined(sstruct)) {
    return sstruct;
  } else {
    ASSERTMSG(debugString);
  }
}

getnode_safe(value, key, debugName) {
  node = GetNode(value, key);
  if(isDefined(debugName)) {
    debugString = "Couldn't GetNode for: " + debugName;
  } else {
    debugString = "Couldn't GetNode with KVP " + key + " / " + value;
  }
  if(isDefined(node)) {
    return node;
  } else {
    ASSERTMSG(debugString);
  }
}

getvehiclenode_safe(value, key, debugName) {
  node = GetVehicleNode(value, key);
  if(isDefined(debugName)) {
    debugString = "Couldn't GetVehicleNode for: " + debugName;
  } else {
    debugString = "Couldn't GetVehicleNode with KVP " + key + " / " + value;
  }
  if(isDefined(node)) {
    return node;
  } else {
    ASSERTMSG(debugString);
  }
}

array_contains_element(element) {
  for(i = 0; i < self.size; i++) {
    if(self[i] == element) {
      return true;
    }
  }
  return false;
}

get_random(array) {
  return array[RandomInt(array.size)];
}

get_random_excluding(array, excluder, totalTries) {
  if(!isDefined(totalTries) || totalTries > 100 || totalTries < 1) {
    totalTries = 10;
  }
  choice = get_random(array);
  numTries = 0;
  if(isDefined(excluder)) {
    while(choice == excluder && numTries < totalTries) {
      choice = get_random(array);
      numTries++;
    }
  }
  return choice;
}

array_validate(array) {
  if(isDefined(array) && array.size > 0) {
    return true;
  } else {
    return false;
  }
}

scr_earthquake(scale, duration, source, radius) {
  if(isDefined(self)) {
    Earthquake(scale, duration, source, radius);
  }
}

waittill_player_within_range(testOrigin, playerdist, waitTime, drawRangeDebug) {
  if(!isDefined(waitTime) || waitTime <= 0) {
    waitTime = 0.1;
  }
  if(isDefined(drawRangeDebug) && drawRangeDebug) {
    thread draw_sphere_at_origin(testOrigin, playerdist, 32);
  }
  closeEnough = false;
  while(!closeEnough) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(Distance(player.origin, testOrigin) <= playerdist) {
        closeEnough = true;
        break;
      }
    }
    if(closeEnough) {
      break;
    } else {
      wait(waitTime);
    }
  }
}

trigger_setup() {
  trigs = getEntArray("trigger_multiple", "classname");
  trigs = array_combine(trigs, getEntArray("trigger_radius", "classname"));
  for(i = 0; i < trigs.size; i++) {
    if(isDefined(trigs[i])) {
      trigs[i] thread trigger_think();
    }
  }
}

trigger_think() {
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self waittill("trigger");
      wait(0.1);
      self Delete();
    } else {
      otherTrig = GetEnt("self.script_noteworthy", "targetname");
      if(isDefined(otherTrig)) {
        self waittill("trigger");
        otherTrig Delete();
      }
    }
  }
}

light_setintensity(newIntensity, time) {
  if(self GetLightIntensity() == newIntensity) {
    return;
  }
  self notify("intensity_change");
  self endon("intensity_change");
  stepTime = 0.05;
  ogIntensity = self GetLightIntensity();
  intensityChange = newIntensity - ogIntensity;
  stepsPerSecond = 1 / stepTime;
  steps = time * stepsPerSecond;
  changePerStep = intensityChange / steps;
  for(i = 0; i < steps; i++) {
    reduceVal = self GetLightIntensity() + changePerStep;
    if(reduceVal >= 0) {
      self SetLightIntensity(reduceVal);
    }
    wait(stepTime);
  }
  if(self GetLightIntensity() != newIntensity) {
    self SetLightIntensity(newIntensity);
  }
}

timescale_over_time(newTimescale, scaleTime, interval) {
  if(!isDefined(newTimescale)) {
    ASSERTMSG("timescale_over_time(): you must specify a newTimescale.");
    level notify("timescale_over_time_done");
    return;
  } else if(newTimescale < 0) {
    ASSERTMSG("timescale_over_time(): your newTimescale must be greater than zero.");
    level notify("timescale_over_time_done");
    return;
  }
  level notify("end_timescale_over_time");
  level endon("end_timescale_over_time");
  if(!isDefined(interval)) {
    interval = 0.1;
  }
  ogTimescale = GetTimeScale();
  timescaleDiff = newTimescale - ogTimescale;
  numIntervals = scaleTime / interval;
  scalePerIncrement = timescaleDiff / numIntervals;
  timescaleCurrent = ogTimescale;
  for(i = 0; i < numIntervals; i++) {
    timescaleCurrent += scalePerIncrement;
    SetTimeScale(timescaleCurrent);
    wait(interval * timescaleCurrent);
  }
  SetTimeScale(newTimescale);
  level notify("timescale_over_time_done");
}

delete_group(group, waitTime) {
  if(isDefined(group) && group.size > 0) {
    array_thread(group, ::scr_delete, waitTime);
  }
}

scr_delete(waitTime) {
  if(isDefined(waitTime) && waitTime > 0) {
    wait(waitTime);
  }
  if(isDefined(self)) {
    self Delete();
  }
}

set_timer(timerName, timerLimit) {
  if(!isDefined(level.timers)) {
    level.timers = [];
  }
  if(!isDefined(level.timers[timerName])) {
    level.timers[timerName] = [];
  }
  if(!isDefined(level.timers[timerName]["timerLimit"]) || isDefined(timerLimit)) {
    level.timers[timerName]["timerLimit"] = timerLimit;
  }
  level.timers[timerName]["timerStartTime"] = GetTime();
}

timer_expired(timerName) {
  if(!isDefined(level.timers[timerName])) {
    ASSERTMSG("Timer with name " + timerName + " has not been set up.Did you run set_timer() first?");
  }
  timerLimit = level.timers[timerName]["timerLimit"];
  timerStartTime = level.timers[timerName]["timerStartTime"];
  if(GetTime() - timerStartTime > (timerLimit * 1000)) {
    return true;
  } else {
    return false;
  }
}

veh_stop_at_node(node_value, node_key, accel, decel, dont_stop_flag) {
  if(!isDefined(accel)) {
    accel = 15;
  }
  if(!isDefined(decel)) {
    decel = 15;
  }
  vnode = getvehiclenode_safe(node_value, node_key);
  vnode waittill("trigger");
  if(!isDefined(dont_stop_flag) || (isDefined(dont_stop_flag) && !flag(dont_stop_flag))) {
    self setspeed(0, accel, decel);
    self notify("veh_stop_at_node");
  }
  if(self.vehicletype == "wasp") {
    wait(0.5);
  }
}

vehiclenode_wait(nodeVal, nodeKey) {
  node = getvehiclenode_safe(nodeVal, nodeKey);
  node waittill("trigger");
}

tank_get_and_fire_at_struct(struct_name) {
  spot = getstruct_safe(struct_name, "targetname");
  spot tank_fire_at_struct(spot);
}

tank_fire_at_struct(spot, onTargetPauseTime, turretMoveTimeout) {
  self endon("death");
  self endon("end_tank_fire_at");
  if(!isDefined(onTargetPauseTime) || onTargetPauseTime < 0) {
    onTargetPauseTime = 1;
  }
  self SetTurretTargetVec(spot.origin);
  if(isDefined(turretMoveTimeout)) {
    self waittill_notify_or_timeout("turret_on_target", turretMoveTimeout);
  } else {
    self waittill("turret_on_target");
  }
  wait(onTargetPauseTime);
  self ClearTurretTarget();
  self FireWeapon();
  self notify("turret_fired");
}

tank_fire_at_origin(targetOrigin, onTargetPauseTime) {
  self endon("death");
  self endon("end_tank_fire_at");
  if(!isDefined(onTargetPauseTime) || onTargetPauseTime < 0) {
    onTargetPauseTime = 1;
  }
  self SetTurretTargetVec(targetOrigin);
  self waittill("turret_on_target");
  wait(onTargetPauseTime);
  self ClearTurretTarget();
  self FireWeapon();
  self notify("turret_fired");
}

tank_fire_at_ent(ent_name) {
  self endon("death");
  self endon("end_tank_fire_at");
  spot = getent(ent_name, "targetname");
  self SetTurretTargetEnt(spot);
  self waittill("turret_on_target");
  wait(1);
  self ClearTurretTarget();
  self FireWeapon();
}

tank_reset_turret(timeout) {
  self endon("death");
  self endon("end_tank_reset_turret");
  if(!isDefined(timeout)) {
    timeout = 5;
  }
  forward = anglesToForward(self.angles);
  vec = vectorScale(forward, 1000);
  adjustedOrigin = self.origin + (0, 0, 82);
  self SetTurretTargetVec(adjustedOrigin + vec);
  self waittill_notify_or_timeout("turret_on_target", timeout);
  self ClearTurretTarget();
}

kill_drones(val, key, minWait, maxWait) {
  drones = getEntArray(val, key);
  if(drones.size > 0) {
    array_thread(drones, ::kill_drone_random, minWait, maxWait);
  }
}

kill_drone_random(min, max) {
  self endon("death");
  self endon("drone_death");
  wait(RandomFloatRange(min, max));
  if(isDefined(self)) {
    self delete();
  }
}