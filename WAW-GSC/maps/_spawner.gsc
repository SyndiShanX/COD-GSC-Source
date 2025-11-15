/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_spawner.gsc
*****************************************************/

#include maps\_utility;
#include maps\_anim;
#include common_scripts\utility;

main() {
  if(getdebugdvar("replay_debug") == "1")
    println("File: _spawner.gsc. Function: main()\n");
  precachemodel("grenade_bag");
  / /
  level.ai_classname_in_level = [];
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    spawners[i] thread spawn_prethink();
  }
  thread process_deathflags();
  array_thread(ai, ::spawn_think);
  level.ai_classname_in_level_keys = getarraykeys(level.ai_classname_in_level);
  for(i = 0; i < level.ai_classname_in_level_keys.size; i++) {
    if(!issubstr(tolower(level.ai_classname_in_level_keys[i]), "rpg"))
      continue;
    precacheItem("rpg_player");
    break;
  }
  level.ai_classname_in_level_keys = undefined;
  run_thread_on_noteworthy("hiding_door_spawner", ::hiding_door_spawner);
  if(getdebugdvar("replay_debug") == "1")
    println("File: _spawner.gsc. Function: main() - COMPLETE\n");
  level thread trigger_spawner_monitor();
}

check_script_char_group_ratio(spawners) {
  if(spawners.size <= 16) {
    return;
  }
  total = 0;
  grouped = 0;
  for(i = 0; i < spawners.size; i++) {
    if(!spawners[i].team != "axis") {
      continue;
    }
    total++;
    if(!spawners[i] has_char_group()) {
      continue;
    }
    grouped++;
  }
  assertex(grouped / total >= 0.65, "Please group your enemies with script_char_group so that each group gets a unique character mix. This minimizes duplicate characters in close proximity. Or you can specify precise character choice with script_group_index.");
}

has_char_group() {
  if(isDefined(self.script_char_group))
    return true;
  return isDefined(self.script_char_index);
}

process_deathflags() {
  keys = getarraykeys(level.deathflags);
  level.deathflags = [];
  for(i = 0; i < keys.size; i++) {
    deathflag = keys[i];
    level.deathflags[deathflag] = [];
    level.deathflags[deathflag]["spawners"] = [];
    level.deathflags[deathflag]["ai"] = [];
    if(!isDefined(level.flag[deathflag])) {
      flag_init(deathflag);
    }
  }
}

spawn_guys_until_death_or_no_count() {
  self endon("death");
  self waittill("count_gone");
}

deathflag_check_count() {
  self endon("death");
  waittillframeend;
  if(self.count > 0) {
    return;
  }
  self notify("count_gone");
}

ai_deathflag() {
  level.deathflags[self.script_deathflag]["ai"][self.ai_number] = self;
  ai_number = self.ai_number;
  deathflag = self.script_deathflag;
  if(isDefined(self.script_deathflag_longdeath)) {
    self waittillDeathOrPainDeath();
  } else {
    self waittill("death");
  }
  level.deathflags[deathflag]["ai"][ai_number] = undefined;
  update_deathflag(deathflag);
}

spawner_deathflag() {
  level.deathflags[self.script_deathflag] = true;
  waittillframeend;
  if(!isDefined(self) || self.count == 0) {
    return;
  }
  self.spawner_number = level.spawner_number;
  level.spawner_number++;
  level.deathflags[self.script_deathflag]["spawners"][self.spawner_number] = self;
  deathflag = self.script_deathflag;
  id = self.spawner_number;
  spawn_guys_until_death_or_no_count();
  level.deathflags[deathflag]["spawners"][id] = undefined;
  update_deathflag(deathflag);
}

update_deathflag(deathflag) {
  level notify("updating_deathflag_" + deathflag);
  level endon("updating_deathflag_" + deathflag);
  waittillframeend;
  spawnerKeys = getarraykeys(level.deathflags[deathflag]["spawners"]);
  if(spawnerKeys.size > 0) {
    return;
  }
  aiKeys = getarraykeys(level.deathflags[deathflag]["ai"]);
  if(aiKeys.size > 0) {
    return;
  }
  flag_set(deathflag);
}

outdoor_think(trigger) {
  assert((trigger.spawnflags & 1) || (trigger.spawnflags & 2) || (trigger.spawnflags & 4), "trigger_outdoor at " + trigger.origin + " is not set up to trigger AI! Check one of the AI checkboxes on the trigger.");
  trigger endon("death");
  for(;;) {
    trigger waittill("trigger", guy);
    if(!isAI(guy)) {
      continue;
    }
    guy thread ignore_triggers(0.15);
    guy disable_cqbwalk();
    guy.wantShotgun = false;
  }
}

indoor_think(trigger) {
  assert((trigger.spawnflags & 1) || (trigger.spawnflags & 2) || (trigger.spawnflags & 4), "trigger_indoor at " + trigger.origin + " is not set up to trigger AI! Check one of the AI checkboxes on the trigger.");
  trigger endon("death");
  for(;;) {
    trigger waittill("trigger", guy);
    if(!isAI(guy)) {
      continue;
    }
    guy thread ignore_triggers(0.15);
    guy enable_cqbwalk();
    guy.wantShotgun = true;
  }
}

doAutospawn(spawner) {
  spawner endon("death");
  self endon("death");
  for(;;) {
    self waittill("trigger");
    if(!spawner.count) {
      return;
    }
    if(self.target != spawner.targetname) {
      return;
    }
    if(isDefined(spawner.triggerUnlocked)) {
      return;
    }
    while(!(self ok_to_trigger_spawn())) {
      wait_network_frame();
    }
    guy = spawner spawn_ai();
    if(spawn_failed(guy)) {
      spawner notify("spawn_failed");
    }
    level._numTriggerSpawned++;
    if(isDefined(self.Wait) && (self.Wait > 0)) {
      wait(self.Wait);
    }
  }
}

trigger_spawner_monitor() {
  println("Trigger spawner monitor running...");
  level._numTriggerSpawned = 0;
  while(1) {
    wait_network_frame();
    wait_network_frame();
    level._numTriggerSpawned = 0;
  }
}

ok_to_trigger_spawn(forceChoke) {
  if(isDefined(forceChoke)) {
    choked = forceChoke;
  } else {
    choked = false;
  }
  if(isDefined(self.script_trigger) && NumRemoteClients()) {
    trigger = self.script_trigger;
    if(isDefined(trigger.targetname) && (trigger.targetname == "flood_spawner")) {
      choked = true;
      if(isDefined(trigger.script_choke) && !trigger.script_choke) {
        choked = false;
      }
    } else if(isDefined(trigger.spawnflags) && (trigger.spawnflags & 32)) {
      if(isDefined(trigger.script_choke) && trigger.script_choke) {
        choked = true;
      }
    }
  }
  if(isDefined(self.targetname) && (self.targetname == "drone_axis" || self.targetname == "drone_allies")) {
    choked = true;
  }
  if(choked && NumRemoteClients()) {
    if(level._numTriggerSpawned > 2) {
      println("Triggerspawn choke.");
      return false;
    }
  }
  return true;
}

trigger_spawner(trigger) {
  assertEx(isDefined(trigger.target), "Triggers with flag TRIGGER_SPAWN at " + trigger.origin + " must target at least one spawner.");
  trigger endon("death");
  trigger waittill("trigger");
  spawners = getEntArray(trigger.target, "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].script_trigger = trigger;
  } {
    array_thread(spawners, ::trigger_spawner_spawns_guys);
  }
}

trigger_spawner_spawns_guys() {
  self endon("death");
  self script_delay();
  while(!self ok_to_trigger_spawn()) {
    wait_network_frame();
  }
  if(isDefined(self.script_drone)) {
    spawned = dronespawn(self);
    level._numTriggerSpawned++;
    assertEx(isDefined(level.drone_spawn_func), "You need to put maps\_drone::init(); in your level script!");
    spawned thread[[level.drone_spawn_func]]();
    return;
  } else
  if(!issubstr(self.classname, "actor")) {
    return;
  }
  if(isDefined(self.script_noenemyinfo) && isDefined(self.script_forcespawn))
    spawned = self stalingradspawn(true);
  else if(isDefined(self.script_noenemyinfo))
    spawned = self dospawn(true);
  else if(isDefined(self.script_forcespawn))
    spawned = self stalingradspawn();
  else
    spawned = self dospawn();
  level._numTriggerSpawned++;
}

flood_spawner_scripted(spawners) {
  assertex(isDefined(spawners) && spawners.size, "Script tried to flood spawn without any spawners");
  array_thread(spawners, ::flood_spawner_init);
  {
    array_thread(spawners, ::flood_spawner_think);
  }
}

reincrement_count_if_deleted(spawner) {
  spawner endon("death");
  self waittill("death");
  if(!isDefined(self)) {
    spawner.count++;
  }
}

delete_start(startnum) {
  for(p = 0; p < 2; p++) {
    switch (p) {
      case 0:
        aitype = "axis";
        break;
      default:
        assert(p == 1);
        aitype = "allies";
        break;
    }
    ai = getEntArray(aitype, "team");
    for(i = 0; i < ai.size; i++) {
      if(isDefined(ai[i].script_start)) {
        if(ai[i].script_start == startnum) {
          ai[i] thread delete_me();
        }
      }
    }
  }
}

kill_trigger(trigger) {
  if(!isDefined(trigger)) {
    return;
  }
  if((isDefined(trigger.targetname)) && (trigger.targetname != "flood_spawner")) {
    return;
  }
  trigger Delete();
}

random_killspawner(trigger) {
  random_killspawner = trigger.script_random_killspawner;
  trigger waittill("trigger");
  triggered_spawners = [];
  spawners = getspawnerarray();
  for(i = 0; i < spawners.size; i++) {
    if((isDefined(spawners[i].script_random_killspawner)) && (random_killspawner == spawners[i].script_random_killspawner)) {
      triggered_spawners = add_to_array(triggered_spawners, spawners[i]);
    }
  }
  select_random_spawn(triggered_spawners);
}

kill_spawner(trigger) {
  killspawner = trigger.script_killspawner;
  trigger waittill("trigger");
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if((isDefined(spawners[i].script_killspawner)) && (killspawner == spawners[i].script_killspawner)) {
      spawners[i] Delete();
    }
  }
  kill_trigger(trigger);
}

empty_spawner(trigger) {
  emptyspawner = trigger.script_emptyspawner;
  trigger waittill("trigger");
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if(!isDefined(spawners[i].script_emptyspawner)) {
      continue;
    }
    if(emptyspawner != spawners[i].script_emptyspawner) {
      continue;
    }
    if(isDefined(spawners[i].script_flanker)) {
      level notify("stop_flanker_behavior" + spawners[i].script_flanker);
    }
    spawners[i].count = 0;
    spawners[i] notify("emptied spawner");
  }
  trigger notify("deleted spawners");
}

kill_spawnerNum(number) {
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if(!isDefined(spawners[i].script_killspawner)) {
      continue;
    }
    if(number != spawners[i].script_killspawner) {
      continue;
    }
    spawners[i] Delete();
  }
}

trigger_spawn(trigger) {}
waittillDeathOrPainDeath() {
  self endon("death");
  self waittill("pain_death");
}

drop_gear() {
  team = self.team;
  waittillDeathOrPainDeath();
  if(!isDefined(self)) {
    return;
  }
  if(maps\_collectibles::has_collectible("collectible_dead_hands")) {
    return;
  }
  self.ignoreForFixedNodeSafeCheck = true;
  if(self.grenadeAmmo <= 0) {
    return;
  }
  if(isDefined(self.dropweapon) && !self.dropweapon) {
    return;
  }
  level.nextGrenadeDrop--;
  if(level.nextGrenadeDrop > 0) {
    return;
  }
  level.nextGrenadeDrop = 2 + RandomInt(2);
  max = 25;
  min = 12;
  spawn_grenade_bag(self.origin + (RandomInt(max) - min, RandomInt(max) - min, 2) + (0, 0, 42), (0, RandomInt(360), 0), self.team);
}

random_tire(start, end) {
  model = spawn("script_model", (0, 0, 0));
  model.angles = (0, randomint(360), 0);
  dif = randomfloat(1);
  model.origin = start * dif + end * (1 - dif);
  model setModel("com_junktire");
  vel = randomvector(15000);
  vel = (vel[0], vel[1], abs(vel[2]));
  model physicslaunch(model.origin, vel);
  wait(randomintrange(8, 12));
  model delete();
}

spawn_grenade_bag(origin, angles, team) {
  if(!isDefined(level.grenade_cache) || !isDefined(level.grenade_cache[team])) {
    level.grenade_cache_index[team] = 0;
    level.grenade_cache[team] = [];
  }
  index = level.grenade_cache_index[team];
  grenade = level.grenade_cache[team][index];
  if(isDefined(grenade)) {
    grenade Delete();
  }
  grenade = spawn("weapon_" + self.grenadeWeapon, origin);
  level.grenade_cache[team][index] = grenade;
  level.grenade_cache_index[team] = (index + 1) % 16;
  grenade.angles = angles;
  grenade.count = self.grenadeammo;
  grenade setModel("grenade_bag");
}

dronespawn_setstruct(spawner) {
  if(dronespawn_check()) {
    return;
  }
  guy = spawner stalingradspawn();
  spawner.count++;
  dronespawn_setstruct_from_guy(guy);
  guy delete();
}

dronespawn_check() {
  if(isDefined(level.dronestruct[self.classname]))
    return true;
  return false;
}

dronespawn_setstruct_from_guy(guy) {
  if(dronespawn_check())
    return;
  struct = spawnStruct();
  size = guy getattachsize();
  struct.attachedmodels = [];
  for(i = 0; i < size; i++) {
    struct.attachedmodels[i] = guy GetAttachModelName(i);
    struct.attachedtags[i] = guy GetAttachTagName(i);
  }
  struct.model = guy.model;
  level.dronestruct[guy.classname] = struct;
}

empty() {}
spawn_prethink() {
  assert(self != level);
  level.ai_classname_in_level[self.classname] = true;
  if(getdvar("noai") != "off") {
    self.count = 0;
    return;
  }
  prof_begin("spawn_prethink");
  if(isDefined(self.script_drone)) {
    self thread dronespawn_setstruct(self);
  }
  if(isDefined(self.script_aigroup)) {
    aigroup = self.script_aigroup;
    if(!isDefined(level._ai_group[aigroup])) {
      aigroup_create(aigroup);
    }
    self thread aigroup_spawnerthink(level._ai_group[aigroup]);
  }
  if(isDefined(self.script_delete)) {
    array_size = 0;
    if(isDefined(level._ai_delete)) {
      if(isDefined(level._ai_delete[self.script_delete])) {
        array_size = level._ai_delete[self.script_delete].size;
      }
    }
    level._ai_delete[self.script_delete][array_size] = self;
  }
  if(isDefined(self.script_health)) {
    if(self.script_health > level._max_script_health) {
      level._max_script_health = self.script_health;
    }
    array_size = 0;
    if(isDefined(level._ai_health)) {
      if(isDefined(level._ai_health[self.script_health])) {
        array_size = level._ai_health[self.script_health].size;
      }
    }
    level._ai_health[self.script_health][array_size] = self;
  }
  deathflag_func = ::empty;
  if(isDefined(self.script_deathflag)) {
    deathflag_func = ::deathflag_check_count;
    thread spawner_deathflag();
  }
  if(isDefined(self.target)) {
    crawl_through_targets_to_init_flags();
  }
  if(!isDefined(self.spawn_functions)) {
    self.spawn_functions = [];
  }
  for(;;) {
    prof_begin("spawn_prethink");
    self waittill("spawned", spawn);
    [[deathflag_func]]();
    if(!IsAlive(spawn)) {
      continue;
    }
    if(isDefined(level.spawnerCallbackThread)) {
      self thread[[level.spawnerCallbackThread]](spawn);
    }
    if(isDefined(self.script_delete)) {
      for(i = 0; i < level._ai_delete[self.script_delete].size; i++) {
        if(level._ai_delete[self.script_delete][i] != self) {
          level._ai_delete[self.script_delete][i] Delete();
        }
      }
    }
    spawn.spawn_funcs = self.spawn_functions;
    if(isDefined(self.targetname)) {
      spawn thread spawn_think(self.targetname);
    } else {
      spawn thread spawn_think();
    }
  }
}

spawn_think(targetname) {
  assert(self != level);
  level.ai_classname_in_level[self.classname] = true;
  spawn_think_action(targetname);
  assert(IsAlive(self));
  self endon("death");
  thread run_spawn_functions();
  self.finished_spawning = true;
  self notify("finished spawning");
  assert(isDefined(self.team));
  if(self.team == "allies" && !isDefined(self.script_nofriendlywave))
    self thread friendlydeath_thread();
}

run_spawn_functions() {
  self endon("death");
  if(!isDefined(self.spawn_funcs)) {
    return;
  }
  for(i = 0; i < self.spawn_funcs.size; i++) {
    func = self.spawn_funcs[i];
    if(isDefined(func["param4"]))
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"]);
    else
    if(isDefined(func["param3"]))
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"]);
    else
    if(isDefined(func["param2"]))
      thread[[func["function"]]](func["param1"], func["param2"]);
    else
    if(isDefined(func["param1"]))
      thread[[func["function"]]](func["param1"]);
    else
      thread[[func["function"]]]();
  }
  for(i = 0; i < level.spawn_funcs[self.team].size; i++) {
    func = level.spawn_funcs[self.team][i];
    if(isDefined(func["param4"]))
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"]);
    else
    if(isDefined(func["param3"]))
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"]);
    else
    if(isDefined(func["param2"]))
      thread[[func["function"]]](func["param1"], func["param2"]);
    else
    if(isDefined(func["param1"]))
      thread[[func["function"]]](func["param1"]);
    else
      thread[[func["function"]]]();
  }
  self.saved_spawn_functions = self.spawn_funcs;
  self.spawn_funcs = undefined;
  self.spawn_funcs = self.saved_spawn_functions;
  self.saved_spawn_functions = undefined;
  self.spawn_funcs = undefined;
}

deathFunctions() {
  self waittill("death", other);
  for(i = 0; i < self.deathFuncs.size; i++) {
    array = self.deathFuncs[i];
    switch (array["params"]) {
      case 0:
        [
          [array["func"]]
        ](other);
        break;
      case 1:
        [
          [array["func"]]
        ](other, array["param1"]);
        break;
      case 2:
        [
          [array["func"]]
        ](other, array["param1"], array["param2"]);
        break;
      case 3:
        [
          [array["func"]]
        ](other, array["param1"], array["param2"], array["param3"]);
        break;
    }
  }
}

living_ai_prethink() {
  if(isDefined(self.script_deathflag)) {
    level.deathflags[self.script_deathflag] = true;
  }
  if(isDefined(self.target)) {
    crawl_through_targets_to_init_flags();
  }
}

crawl_through_targets_to_init_flags() {
  array = get_node_funcs_based_on_target();
  if(isDefined(array)) {
    targets = array["node"];
    get_func = array["get_target_func"];
    for(i = 0; i < targets.size; i++) {
      crawl_target_and_init_flags(targets[i], get_func);
    }
  }
}

spawn_think_action(targetname) {
  self thread maps\_utility::ent_flag_init_ai_standards();
  self thread tanksquish();
  if(maps\_collectibles::has_collectible("collectible_berserker")) {
    self thread maps\_collectibles_game::berserker_death();
  }
  self.spawner_number = undefined;
  thread show_bad_path();
  if(!isDefined(self.ai_number)) {
    set_ai_number();
  }
  if(isDefined(self.script_dontshootwhilemoving)) {
    self.dontshootwhilemoving = true;
  }
  if(!isDefined(self.deathFuncs)) {
    self.deathFuncs = [];
  }
  thread deathFunctions();
  if(isDefined(self.script_deathflag)) {
    thread ai_deathflag();
  }
  if(isDefined(self.script_animname)) {
    self.animname = self.script_animname;
  }
  if(isDefined(self.script_forceColor)) {
    set_force_color(self.script_forceColor);
    if(!isDefined(self.script_no_respawn) || self.script_no_respawn < 1) {
      self thread replace_on_death();
    }
  }
  if(isDefined(self.script_fixednode)) {
    self.fixednode = (self.script_fixednode == 1);
  } else {
    self.fixednode = self.team == "allies";
  }
  set_default_covering_fire();
  self EqOff();
  if((isDefined(self.script_moveoverride)) && (self.script_moveoverride == 1)) {
    override = true;
  } else {
    override = false;
  }
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mgpair") {
    thread maps\_mg_penetration::create_mg_team();
  }
  level thread maps\_friendlyfire::friendly_fire_think(self);
  if(isDefined(self.script_goalvolume)) {
    thread set_goal_volume();
  }
  if(isDefined(self.script_threatbiasgroup)) {
    self SetThreatBiasGroup(self.script_threatbiasgroup);
  } else if(self.team == "allies") {
    self SetThreatBiasGroup("allies");
  } else {
    self SetThreatBiasGroup("axis");
  }
  if(self.type == "human")
    assertEx(self.pathEnemyLookAhead == 0 && self.pathEnemyFightDist == 0, "Tried to change pathenemyFightDist or pathenemyLookAhead on an AI before running spawn_failed on guy with export " + self.export);
  set_default_pathenemy_settings();
  self.heavy_machine_gunner = IsSubStr(self.classname, "mgportable") ||
    IsSubStr(self.classname, "30cal") ||
    IsSubStr(self.classname, "mg42") ||
    IsSubStr(self.classname, "dp28");
  maps\_gameskill::grenadeAwareness();
  if(isDefined(self.script_bcdialog)) {
    self set_battlechatter(self.script_bcdialog);
  }
  if(isDefined(self.script_accuracy)) {
    self.baseAccuracy = self.script_accuracy;
  }
  self.walkdist = 16;
  if(isDefined(self.script_ignoreme)) {
    assertEx(self.script_ignoreme == true, "Tried to set self.script_ignoreme to false, not allowed. Just set it to undefined.");
    self.ignoreme = true;
  }
  if(isDefined(self.script_ignore_suppression)) {
    assertEx(self.script_ignore_suppression == true, "Tried to set self.script_ignore_suppresion to false, not allowed. Just set it to undefined.");
    self.ignoreSuppression = true;
  }
  if(isDefined(self.script_ignoreall)) {
    assertEx(self.script_ignoreall == true, "Tried to set self.script_ignoreme to false, not allowed. Just set it to undefined.");
    self.ignoreall = true;
    self clearenemy();
  }
  if(isDefined(self.script_sightrange)) {
    self.maxSightDistSqrd = self.script_sightrange;
  } else if(WeaponClass(self.weapon) == "gas") {
    self.maxSightDistSqrd = 1024 * 1024;
  }
  if(self.team != "axis") {
    self thread use_for_ammo();
    if(isDefined(self.script_followmin)) {
      self.followmin = self.script_followmin;
    }
    if(isDefined(self.script_followmax)) {
      self.followmax = self.script_followmax;
    }
    level thread friendly_waittill_death(self);
  }
  if(self.team == "axis") {
    if(self.type == "human") {
      self thread drop_gear();
    }
    self thread maps\_damagefeedback::monitorDamage();
    self thread maps\_gameskill::auto_adjust_enemy_death_detection();
    if(maps\_collectibles::has_collectible("collectible_zombie")) {
      self.gib_override = true;
      self thread maps\_collectibles_game::zombie_health_regen();
    }
  }
  if(isDefined(self.script_fightdist)) {
    self.pathenemyfightdist = self.script_fightdist;
  }
  if(isDefined(self.script_maxdist)) {
    self.pathenemylookahead = self.script_maxdist;
  }
  if(isDefined(self.script_longdeath)) {
    assertex(!self.script_longdeath, "Long death is enabled by default so don't set script_longdeath to true, check ai with export " + self.export);
    self.a.disableLongDeath = true;
    assertEX(self.team != "allies", "Allies can't do long death, so why disable it on guy with export " + self.export);
  } else {
    if(self.team == "axis") {
      self.health = 150;
    }
  }
  if(isDefined(self.script_grenades)) {
    self.grenadeAmmo = self.script_grenades;
  }
  if(isDefined(self.script_pacifist)) {
    self.pacifist = true;
  }
  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
  }
  if(isDefined(self.script_allowdeath)) {
    self.allowdeath = self.script_allowdeath;
  }
  if(isDefined(self.script_nodropweapon)) {
    self.dropweapon = 0;
  }
  if(isDefined(self.script_playerseek)) {
    if(isDefined(self.script_radius)) {
      self.goalradius = self.script_radius;
    }
    self SetGoalEntity(get_closest_player(self.origin));
    if(isDefined(self.script_sound)) {
      self animscripts\face::SaySpecificDialogue(undefined, self.script_sound, 1.0);
    }
    return;
  }
  if(isDefined(self.script_patroller)) {
    self thread maps\_patrol::patrol();
    return;
  }
  if(isDefined(self.script_spiderhole)) {
    self thread maps\_spiderhole::spiderhole();
    return;
  }
  if(isDefined(self.script_banzai)) {
    self thread maps\_banzai::spawned_banzai_dynamic();
  } else if(isDefined(self.script_banzai_spawn)) {
    self thread maps\_banzai::spawned_banzai_immediate();
  }
  if(isDefined(self.script_delayed_playerseek)) {
    if(!isDefined(self.script_radius)) {
      self.goalradius = 800;
    }
    self SetGoalEntity(get_closest_player(self.origin));
    if(isDefined(self.script_sound)) {
      self animscripts\face::SaySpecificDialogue(undefined, self.script_sound, 1.0);
    }
    level thread delayed_player_seek_think(self);
    return;
  }
  if(self.heavy_machine_gunner) {
    thread maps\_mgturret::portable_mg_behavior();
  }
  if(isDefined(self.used_an_mg42)) {
    return;
  }
  if(override) {
    set_goalradius_based_on_settings();
    self SetGoalPos(self.origin);
    return;
  }
  assertEx((self.goalradius == 8 || self.goalradius == 4), "Changed the goalradius on guy with export " + self.export+" without waiting for spawn_failed. Note that this change will NOT show up by putting a breakpoint on the actors goalradius field because breakpoints don't properly handle the first frame an actor exists.");
  set_goalradius_based_on_settings();
  if(isDefined(self.target)) {
    self thread go_to_node();
  }
}

set_default_covering_fire() {
  self.provideCoveringFire = self.team == "allies" && self.fixedNode;
}

scrub_guy() {
  self EqOff();
  self SetThreatBiasGroup(self.team);
  self.baseAccuracy = 1;
  set_default_pathenemy_settings();
  maps\_gameskill::grenadeAwareness();
  self clear_force_color();
  set_default_covering_fire();
  self.interval = 96;
  self.disableArrivals = undefined;
  self.ignoreme = false;
  self.threatbias = 0;
  self.pacifist = false;
  self.pacifistWait = 20;
  self.IgnoreRandomBulletDamage = false;
  self.playerPushable = true;
  self.precombatrunEnabled = true;
  self.accuracystationarymod = 1;
  self.allowdeath = false;
  self.anglelerprate = 540;
  self.badplaceawareness = 0.75;
  self.chainfallback = 0;
  self.dontavoidplayer = 0;
  self.drawoncompass = 1;
  self.activatecrosshair = true;
  self.dropweapon = 1;
  self.goalradius = level.default_goalradius;
  self.goalheight = level.default_goalheight;
  self.ignoresuppression = 0;
  self pushplayer(false);
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    stop_magic_bullet_shield();
  }
  self disable_replace_on_death();
  self.maxsightdistsqrd = 8192 * 8192;
  if(WeaponClass(self.weapon) == "gas") {
    self.maxSightDistSqrd = 1024 * 1024;
  }
  self.script_forceGrenade = 0;
  self.walkdist = 16;
  self unmake_hero();
  self.pushable = true;
  animscripts\init::set_anim_playback_rate();
  self.fixednode = self.team == "allies";
  if(isDefined(self.script_grenades)) {
    self.grenadeAmmo = self.script_grenades;
  } else {
    self.grenadeAmmo = 3;
  }
}

delayed_player_seek_think(spawned) {
  spawned endon("death");
  while(IsAlive(spawned)) {
    if(spawned.goalradius > 200) {
      spawned.goalradius -= 200;
    }
    wait(6);
  }
}

flag_turret_for_use(ai) {
  self endon("death");
  if(!self.flagged_for_use) {
    ai.used_an_mg42 = true;
    self.flagged_for_use = true;
    ai waittill("death");
    self.flagged_for_use = false;
    self notify("get new user");
    return;
  }
  println("Turret was already flagged for use");
}

set_goal_volume() {
  self endon("death");
  waittillframeend;
  self SetGoalVolume(level.goalVolumes[self.script_goalvolume]);
}

get_target_ents(target) {
  return getEntArray(target, "targetname");
}

get_target_nodes(target) {
  return getnodearray(target, "targetname");
}

get_target_structs(target) {
  return getstructarray(target, "targetname");
}

node_has_radius(node) {
  return isDefined(node.radius) && node.radius != 0;
}

go_to_origin(node, optional_arrived_at_node_func) {
  self go_to_node(node, "origin", optional_arrived_at_node_func);
}

go_to_struct(node, optional_arrived_at_node_func) {
  self go_to_node(node, "struct", optional_arrived_at_node_func);
}

go_to_node(node, goal_type, optional_arrived_at_node_func) {
  if(isDefined(self.used_an_mg42)) {
    return;
  }
  array = get_node_funcs_based_on_target(node, goal_type);
  if(!isDefined(array)) {
    self notify("reached_path_end");
    return;
  }
  if(!isDefined(optional_arrived_at_node_func)) {
    optional_arrived_at_node_func = ::empty_arrived_func;
  }
  go_to_node_using_funcs(array["node"], array["get_target_func"], array["set_goal_func_quits"], optional_arrived_at_node_func);
}

empty_arrived_func(node) {}
get_least_used_from_array(array) {
  assertex(array.size > 0, "Somehow array had zero entrees");
  if(array.size == 1)
    return array[0];
  targetname = array[0].targetname;
  if(!isDefined(level.go_to_node_arrays[targetname])) {
    level.go_to_node_arrays[targetname] = array;
  }
  array = level.go_to_node_arrays[targetname];
  first = array[0];
  newarray = [];
  for(i = 0; i < array.size - 1; i++) {
    newarray[i] = array[i + 1];
  }
  newarray[array.size - 1] = array[0];
  level.go_to_node_arrays[targetname] = newarray;
  return first;
}

go_to_node_using_funcs(node, get_target_func, set_goal_func_quits, optional_arrived_at_node_func) {
  self endon("stop_going_to_node");
  self endon("death");
  for(;;) {
    node = get_least_used_from_array(node);
    if(node_has_radius(node))
      self.goalradius = node.radius;
    else
      self.goalradius = level.default_goalradius;
    if(isDefined(node.height))
      self.goalheight = node.height;
    else
      self.goalheight = level.default_goalheight;
    [[set_goal_func_quits]](node);
    self waittill("goal");
    [[optional_arrived_at_node_func]](node);
    if(isDefined(node.script_flag_set)) {
      flag_set(node.script_flag_set);
    }
    if(targets_and_uses_turret(node))
      return true;
    node script_delay();
    if(isDefined(node.script_flag_wait)) {
      flag_wait(node.script_flag_wait);
    }
    if(!isDefined(node.target)) {
      break;
    }
    nextNode_array = [[get_target_func]](node.target);
    if(!nextNode_array.size) {
      break;
    }
    node = nextNode_array;
  }
  self notify("reached_path_end");
  self set_goalradius_based_on_settings(node);
}

go_to_node_set_goal_pos(ent) {
  self set_goal_pos(ent.origin);
}

go_to_node_set_goal_node(node) {
  self set_goal_node(node);
}

targets_and_uses_turret(node) {
  if(!isDefined(node.target))
    return false;
  turrets = getEntArray(node.target, "targetname");
  if(!turrets.size)
    return false;
  turret = turrets[0];
  if(turret.classname != "misc_turret")
    return false;
  thread use_a_turret(turret);
  return true;
}

remove_crawled(ent) {
  waittillframeend;
  if(isDefined(ent))
    ent.crawled = undefined;
}

crawl_target_and_init_flags(ent, get_func) {
  oldsize = 0;
  targets = [];
  index = 0;
  for(;;) {
    if(!isDefined(ent.crawled)) {
      ent.crawled = true;
      level thread remove_crawled(ent);
      if(isDefined(ent.script_flag_set)) {
        if(!isDefined(level.flag[ent.script_flag_set])) {
          flag_init(ent.script_flag_set);
        }
      }
      if(isDefined(ent.script_flag_wait)) {
        if(!isDefined(level.flag[ent.script_flag_wait])) {
          flag_init(ent.script_flag_wait);
        }
      }
      if(isDefined(ent.target)) {
        new_targets = [
          [get_func]
        ](ent.target);
        targets = add_to_array(targets, new_targets);
      }
    }
    index++;
    if(index >= targets.size) {
      break;
    }
    ent = targets[index];
  }
}

get_node_funcs_based_on_target(node, goal_type) {
  get_target_func["origin"] = ::get_target_ents;
  get_target_func["node"] = ::get_target_nodes;
  get_target_func["struct"] = ::get_target_structs;
  set_goal_func_quits["origin"] = ::go_to_node_set_goal_pos;
  set_goal_func_quits["struct"] = ::go_to_node_set_goal_pos;
  set_goal_func_quits["node"] = ::go_to_node_set_goal_node;
  if(!isDefined(goal_type))
    goal_type = "node";
  array = [];
  if(isDefined(node)) {
    array["node"][0] = node;
  } else {
    node = getEntArray(self.target, "targetname");
    if(node.size > 0) {
      goal_type = "origin";
    }
    if(goal_type == "node") {
      node = getnodearray(self.target, "targetname");
      if(!node.size) {
        node = getstructarray(self.target, "targetname");
        if(!node.size) {
          return;
        }
        goal_type = "struct";
      }
    }
    array["node"] = node;
  }
  array["get_target_func"] = get_target_func[goal_type];
  array["set_goal_func_quits"] = set_goal_func_quits[goal_type];
  return array;
}

set_goalradius_based_on_settings(node) {
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }
  if(isDefined(self.script_banzai_spawn)) {
    self.goalradius = 64;
    return;
  }
  if(isDefined(self.script_forcegoal)) {
    if(isDefined(node) && isDefined(node.radius)) {
      self.goalradius = node.radius;
      return;
    }
  }
  self.goalradius = level.default_goalradius;
}

reachPathEnd() {
  self waittill("goal");
  self notify("reached_path_end");
}

autoTarget(targets) {
  for(;;) {
    user = self GetTurretOwner();
    if(!IsAlive(user)) {
      wait(1.5);
      continue;
    }
    if(!isDefined(user.enemy)) {
      self SetTargetEntity(random(targets));
      self notify("startfiring");
      self StartFiring();
    }
    wait(2 + RandomFloat(1));
  }
}

manualTarget(targets) {
  for(;;) {
    self SetTargetEntity(random(targets));
    self notify("startfiring");
    self StartFiring();
    wait(2 + RandomFloat(1));
  }
}

use_a_turret(turret) {
  if(self.team == "axis" && self.health == 150) {
    self.health = 100;
    self.a.disableLongDeath = true;
  }
  unmanned = false;
  self Useturret(turret);
  if((isDefined(turret.target)) && (turret.target != turret.targetname)) {
    ents = getEntArray(turret.target, "targetname");
    targets = [];
    for(i = 0; i < ents.size; i++) {
      if(ents[i].classname == "script_origin") {
        targets[targets.size] = ents[i];
      }
    }
    if(targets.size > 0) {
      turret.manual_targets = targets;
      turret SetMode("auto_nonai");
      turret thread maps\_mgturret::burst_fire_unmanned();
      unmanned = true;
    }
  }
  if(!unmanned) {
    self thread maps\_mgturret::mg42_firing(turret);
  }
  turret notify("startfiring");
}

fallback_spawner_think(num, node_array, ignoreWhileFallingBack) {
  self endon("death");
  level.max_fallbackers[num] += self.count;
  firstspawn = true;
  while(self.count > 0) {
    self waittill("spawned", spawn);
    if(firstspawn) {
      if(GetDvar("fallback") == "1") {
        println("^a First spawned: ", num);
      }
      level notify(("fallback_firstspawn" + num));
      firstspawn = false;
    }
    maps\_spawner::waitframe();
    if(maps\_utility::spawn_failed(spawn)) {
      level notify(("fallbacker_died" + num));
      level.max_fallbackers[num]--;
      continue;
    }
    spawn thread fallback_ai_think(num, node_array, "is spawner", ignoreWhileFallingBack);
  }
}

fallback_ai_think_death(ai, num) {
  ai waittill("death");
  level.current_fallbackers[num]--;
  level notify(("fallbacker_died" + num));
}

fallback_ai_think(num, node_array, spawner, ignoreWhileFallingBack) {
  if((!isDefined(self.fallback)) || (!isDefined(self.fallback[num]))) {
    self.fallback[num] = true;
  } else {
    return;
  }
  self.script_fallback = num;
  if(!isDefined(spawner)) {
    level.current_fallbackers[num]++;
  }
  if((isDefined(node_array)) && (level.fallback_initiated[num])) {
    self thread fallback_ai(num, node_array, ignoreWhileFallingBack);
  }
  level thread fallback_ai_think_death(self, num);
}

fallback_death(ai, num) {
  ai waittill("death");
  if(isDefined(ai.fallback_node)) {
    ai.fallback_node.fallback_occupied = false;
  }
  level notify(("fallback_reached_goal" + num));
}

fallback_goal(ignoreWhileFallingBack) {
  self waittill("goal");
  self.ignoresuppression = false;
  if(isDefined(ignoreWhileFallingBack) && ignoreWhileFallingBack) {
    self.ignoreall = false;
  }
  self notify("fallback_notify");
  self notify("stop_coverprint");
}

fallback_interrupt() {
  self notify("stop_fallback_interrupt");
  self endon("stop_fallback_interrupt");
  self endon("stop_going_to_node");
  self endon("goto next fallback");
  self endon("fallback_notify");
  self endon("death");
  while(1) {
    origin = self.origin;
    wait 2;
    if(self.origin == origin) {
      self.ignoreall = false;
      return;
    }
  }
}

fallback_ai(num, node_array, ignoreWhileFallingBack) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("goto next fallback");
  self endon("death");
  node = undefined;
  while(1) {
    ASSERTEX((node_array.size >= level.current_fallbackers[num]), "Number of fallbackers exceeds number of fallback nodes for fallback # " + num + ". Add more fallback nodes or reduce possible fallbackers.");
    node = node_array[RandomInt(node_array.size)];
    if(!isDefined(node.fallback_occupied) || !node.fallback_occupied) {
      node.fallback_occupied = true;
      self.fallback_node = node;
      break;
    }
    wait(0.1);
  }
  self StopUseTurret();
  self.ignoresuppression = true;
  if(self.ignoreall == false && isDefined(ignoreWhileFallingBack) && ignoreWhileFallingBack) {
    self.ignoreall = true;
    self thread fallback_interrupt();
  }
  self SetGoalNode(node);
  if(node.radius != 0) {
    self.goalradius = node.radius;
  }
  self endon("death");
  level thread fallback_death(self, num);
  self thread fallback_goal(ignoreWhileFallingBack);
  if(GetDvar("fallback") == "1") {
    self thread coverprint(node.origin);
  }
  self waittill("fallback_notify");
  level notify(("fallback_reached_goal" + num));
}

coverprint(org) {
  self endon("fallback_notify");
  self endon("stop_coverprint");
  self endon("death");
  while(1) {
    line(self.origin + (0, 0, 35), org, (0.2, 0.5, 0.8), 0.5);
    print3d((self.origin + (0, 0, 70)), "Falling Back", (0.98, 0.4, 0.26), 0.85);
    maps\_spawner::waitframe();
  }
}

fallback_overmind(num, group, ignoreWhileFallingBack, percent) {
  fallback_nodes = undefined;
  nodes = GetAllNodes();
  for(i = 0; i < nodes.size; i++) {
    if((isDefined(nodes[i].script_fallback)) && (nodes[i].script_fallback == num)) {
      fallback_nodes = maps\_utility::add_to_array(fallback_nodes, nodes[i]);
    }
  }
  if(isDefined(fallback_nodes)) {
    level thread fallback_overmind_internal(num, group, fallback_nodes, ignoreWhileFallingBack, percent);
  }
}

fallback_overmind_internal(num, group, fallback_nodes, ignoreWhileFallingBack, percent) {
  level.current_fallbackers[num] = 0;
  level.max_fallbackers[num] = 0;
  level.spawner_fallbackers[num] = 0;
  level.fallback_initiated[num] = false;
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if((isDefined(spawners[i].script_fallback)) && (spawners[i].script_fallback == num)) {
      if(spawners[i].count > 0) {
        spawners[i] thread fallback_spawner_think(num, fallback_nodes, ignoreWhileFallingBack);
        level.spawner_fallbackers[num]++;
      }
    }
  }
  assertex(level.spawner_fallbackers[num] <= fallback_nodes.size, "There are more fallback spawners than fallback nodes. Add more node or remove spawners from script_fallback: " + num);
  ai = GetAiArray();
  for(i = 0; i < ai.size; i++) {
    if((isDefined(ai[i].script_fallback)) && (ai[i].script_fallback == num)) {
      ai[i] thread fallback_ai_think(num, undefined, undefined, ignoreWhileFallingBack);
    }
  }
  if((!level.current_fallbackers[num]) && (!level.spawner_fallbackers[num])) {
    return;
  }
  spawners = undefined;
  ai = undefined;
  thread fallback_wait(num, group, ignoreWhileFallingBack, percent);
  level waittill(("fallbacker_trigger" + num));
  fallback_add_previous_group(num, fallback_nodes);
  if(GetDvar("fallback") == "1") {
    println("^a fallback trigger hit: ", num);
  }
  level.fallback_initiated[num] = true;
  fallback_ai = undefined;
  ai = GetAiArray();
  for(i = 0; i < ai.size; i++) {
    if(((isDefined(ai[i].script_fallback)) && (ai[i].script_fallback == num)) || ((isDefined(ai[i].script_fallback_group)) && (isDefined(group)) && (ai[i].script_fallback_group == group))) {
      fallback_ai = maps\_utility::add_to_array(fallback_ai, ai[i]);
    }
  }
  ai = undefined;
  if(!isDefined(fallback_ai)) {
    return;
  }
  if(!isDefined(percent)) {
    percent = 0.4;
  }
  first_half = fallback_ai.size * percent;
  first_half = Int(first_half);
  level notify("fallback initiated " + num);
  fallback_text(fallback_ai, 0, first_half);
  first_half_ai = [];
  for(i = 0; i < first_half; i++) {
    fallback_ai[i] thread fallback_ai(num, fallback_nodes, ignoreWhileFallingBack);
    first_half_ai[i] = fallback_ai[i];
  }
  for(i = 0; i < first_half; i++) {
    level waittill(("fallback_reached_goal" + num));
  }
  fallback_text(fallback_ai, first_half, fallback_ai.size);
  for(i = 0; i < fallback_ai.size; i++) {
    if(IsAlive(fallback_ai[i])) {
      set_fallback = true;
      for(p = 0; p < first_half_ai.size; p++) {
        if(isalive(first_half_ai[p])) {
          if(fallback_ai[i] == first_half_ai[p]) {
            set_fallback = false;
          }
        }
      }
      if(set_fallback) {
        fallback_ai[i] thread fallback_ai(num, fallback_nodes, ignoreWhileFallingBack);
      }
    }
  }
}

fallback_text(fallbackers, start, end) {
  if(GetTime() <= level._nextcoverprint) {
    return;
  }
  for(i = start; i < end; i++) {
    if(!IsAlive(fallbackers[i])) {
      continue;
    }
    level._nextcoverprint = GetTime() + 2500 + RandomInt(2000);
    return;
  }
}

fallback_wait(num, group, ignoreWhileFallingBack, percent) {
  level endon(("fallbacker_trigger" + num));
  if(GetDvar("fallback") == "1") {
    println("^a Fallback wait: ", num);
  }
  for(i = 0; i < level.spawner_fallbackers[num]; i++) {
    if(GetDvar("fallback") == "1") {
      println("^a Waiting for spawners to be hit: ", num, " i: ", i);
    }
    level waittill(("fallback_firstspawn" + num));
  }
  if(GetDvar("fallback") == "1") {
    println("^a Waiting for AI to die, fall backers for group ", num, " is ", level.current_fallbackers[num]);
  }
  ai = GetAiArray();
  for(i = 0; i < ai.size; i++) {
    if(((isDefined(ai[i].script_fallback)) && (ai[i].script_fallback == num)) || ((isDefined(ai[i].script_fallback_group)) && (isDefined(group)) && (ai[i].script_fallback_group == group))) {
      ai[i] thread fallback_ai_think(num, undefined, undefined, ignoreWhileFallingBack);
    }
  }
  ai = undefined;
  deadfallbackers = 0;
  while(deadfallbackers < level.max_fallbackers[num] * percent) {
    if(GetDvar("fallback") == "1") {
      println("^cwaiting for " + deadfallbackers + " to be more than " + (level.max_fallbackers[num] * 0.5));
    }
    level waittill(("fallbacker_died" + num));
    deadfallbackers++;
  }
  println(deadfallbackers, " fallbackers have died, time to retreat");
  level notify(("fallbacker_trigger" + num));
}

fallback_think(trigger) {
  ignoreWhileFallingBack = false;
  if(isDefined(trigger.script_ignoreall) && trigger.script_ignoreall) {
    ignoreWhileFallingBack = true;
  }
  if((!isDefined(level.fallback)) || (!isDefined(level.fallback[trigger.script_fallback]))) {
    percent = 0.5;
    if(isDefined(trigger.script_percent)) {
      percent = trigger.script_percent / 100;
    }
    level thread fallback_overmind(trigger.script_fallback, trigger.script_fallback_group, ignoreWhileFallingBack, percent);
  }
  trigger waittill("trigger");
  level notify(("fallbacker_trigger" + trigger.script_fallback));
  kill_trigger(trigger);
}

fallback_add_previous_group(num, node_array) {
  if(!isDefined(level.current_fallbackers[num - 1])) {
    return;
  }
  for(i = 0; i < level.current_fallbackers[num - 1]; i++) {
    level.max_fallbackers[num]++;
  }
  for(i = 0; i < level.current_fallbackers[num - 1]; i++) {
    level.current_fallbackers[num]++;
  }
  ai = GetAiArray();
  for(i = 0; i < ai.size; i++) {
    if(((isDefined(ai[i].script_fallback)) && (ai[i].script_fallback == (num - 1)))) {
      ai[i].script_fallback++;
      if(isDefined(ai[i].fallback_node)) {
        ai[i].fallback_node.fallback_occupied = false;
        ai[i].fallback_node = undefined;
      }
    }
  }
}

arrive(node) {
  self waittill("goal");
  if(node.radius != 0) {
    self.goalradius = node.radius;
  } else {
    self.goalradius = level.default_goalradius;
  }
}

fallback_coverprint() {
  self endon("fallback");
  self endon("fallback_clear_goal");
  self endon("fallback_clear_death");
  while(1) {
    if(isDefined(self.coverpoint)) {
      line(self.origin + (0, 0, 35), self.coverpoint.origin, (0.2, 0.5, 0.8), 0.5);
    }
    print3d((self.origin + (0, 0, 70)), "Covering", (0.98, 0.4, 0.26), 0.85);
    maps\_spawner::waitframe();
  }
}

fallback_print() {
  self endon("fallback_clear_goal");
  self endon("fallback_clear_death");
  while(1) {
    if(isDefined(self.coverpoint)) {
      line(self.origin + (0, 0, 35), self.coverpoint.origin, (0.2, 0.5, 0.8), 0.5);
    }
    print3d((self.origin + (0, 0, 70)), "Falling Back", (0.98, 0.4, 0.26), 0.85);
    maps\_spawner::waitframe();
  }
}

use_for_ammo() {}

friendly_waittill_death(spawned) {}

delete_me() {
  maps\_spawner::waitframe();
  self Delete();
}

vLength(vec1, vec2) {
  v0 = vec1[0] - vec2[0];
  v1 = vec1[1] - vec2[1];
  v2 = vec1[2] - vec2[2];
  v0 = v0 * v0;
  v1 = v1 * v1;
  v2 = v2 * v2;
  veclength = v0 + v1 + v2;
  return veclength;
}

waitframe() {
  wait(0.05);
}

specialCheck(name) {
  for(;;) {
    assertex(getEntArray(name, "targetname").size, "Friendly wave trigger that targets " + name + " doesnt target any spawners");
    wait(0.05);
  }
}

friendly_wave(trigger) {
  if(!isDefined(level.friendly_wave_active)) {
    thread friendly_wave_masterthread();
  }
  if(trigger.targetname == "friendly_wave") {
    assert = false;
    targs = getEntArray(trigger.target, "targetname");
    for(i = 0; i < targs.size; i++) {
      if(isDefined(targs[i].classname[7])) {
        if(targs[i].classname[7] != "l" && targs[i].classname[8] != "l" && targs[i].classname != "info_player_respawn") {
          println("Friendyl_wave spawner at ", targs[i].origin, " is not an ally");
          assert = true;
        }
      }
    }
    if(assert) {
      maps\_utility::error("Look above");
    }
  }
  while(1) {
    trigger waittill("trigger");
    level notify("friendly_died");
    if(trigger.targetname == "friendly_wave") {
      level.friendly_wave_trigger = trigger;
    } else {
      level.friendly_wave_trigger = undefined;
      println("friendly wave OFF");
    }
    wait(1);
  }
}

set_spawncount(count) {
  if(!isDefined(self.target)) {
    return;
  }
  spawners = getEntArray(self.target, "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].count = 0;
  }
}

friendlydeath_thread() {
  if(!isDefined(level.totalfriends))
    level.totalfriends = 0;
  level.totalfriends++;
  self waittill("death");
  level notify("friendly_died");
  level.totalfriends--;
}

friendly_wave_masterthread() {
  level.friendly_wave_active = true;
  triggers = getEntArray("friendly_wave", "targetname");
  array_thread(triggers, ::set_spawncount, 0);
  if(!isDefined(level.maxfriendlies)) {
    level.maxfriendlies = 7;
  }
  names = 1;
  while(1) {
    if((isDefined(level.friendly_wave_trigger)) && (isDefined(level.friendly_wave_trigger.target))) {
      old_friendly_wave_trigger = level.friendly_wave_trigger;
      spawn = getEntArray(level.friendly_wave_trigger.target, "targetname");
      spawn = filter_player_respawns(spawn);
      if(!spawn.size) {
        level waittill("friendly_died");
        continue;
      }
      num = 0;
      script_delay = isDefined(level.friendly_wave_trigger.script_delay);
      while((isDefined(level.friendly_wave_trigger)) && (level.totalfriends < level.maxfriendlies)) {
        if(old_friendly_wave_trigger != level.friendly_wave_trigger) {
          script_delay = isDefined(level.friendly_wave_trigger.script_delay);
          old_friendly_wave_trigger = level.friendly_wave_trigger;
          assertex(isDefined(level.friendly_wave_trigger.target), "Wave trigger must target spawner");
          spawn = getEntArray(level.friendly_wave_trigger.target, "targetname");
          spawn = filter_player_respawns(spawn);
        } else if(!script_delay) {
          num = RandomInt(spawn.size);
        } else if(num == spawn.size) {
          num = 0;
        }
        spawn[num].count = 1;
        if(isDefined(spawn[num].script_noenemyinfo) && isDefined(spawn[num].script_forcespawn))
          spawned = spawn[num] stalingradspawn(true);
        else if(isDefined(spawn[num].script_noenemyinfo))
          spawned = spawn[num] dospawn(true);
        else if(isDefined(spawn[num].script_forcespawn)) {
          spawned = spawn[num] Stalingradspawn();
        } else {
          spawned = spawn[num] Dospawn();
        }
        spawn[num].count = 0;
        if(spawn_failed(spawned)) {
          wait(0.2);
          continue;
        }
        if(isDefined(level.friendlywave_thread)) {
          level thread[[level.friendlywave_thread]](spawned);
        } else {
          players = get_players();
          if(isDefined(players) && players.size > 0) {
            spawned SetGoalEntity(players[0]);
          }
        }
        if(script_delay) {
          if(level.friendly_wave_trigger.script_delay == 0) {
            waittillframeend;
          } else {
            wait(level.friendly_wave_trigger.script_delay);
          }
          num++;
        } else {
          wait(RandomFloat(5));
        }
      }
    }
    level waittill("friendly_died");
  }
}

filter_player_respawns(array) {
  newarray = [];
  clear_player_spawnpoints();
  for(i = 0; i < array.size; i++) {
    if(isDefined(array[i].classname) && array[i].classname == "info_player_respawn") {
      add_player_spawnpoInt(array[i]);
      continue;
    }
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

friendly_mgTurret(trigger) {
  if(!isDefined(trigger.target)) {
    maps\_utility::error("No target for friendly_mg42 trigger, origin:" + trigger GetOrigin());
  }
  node = GetNode(trigger.target, "targetname");
  if(!isDefined(node.target)) {
    maps\_utility::error("No mg42 for friendly_mg42 trigger's node, origin: " + node.origin);
  }
  mg42 = GetEnt(node.target, "targetname");
  mg42 SetMode("auto_ai");
  mg42 ClearTargetEntity();
  in_use = false;
  while(1) {
    trigger waittill("trigger", other);
    if(IsSentient(other)) {
      if(IsPlayer(other)) {
        continue;
      }
    }
    if(!isDefined(other.team)) {
      continue;
    }
    if(other.team != "allies") {
      continue;
    }
    if((isDefined(other.script_usemg42)) && (other.script_usemg42 == false)) {
      continue;
    }
    if(other thread friendly_mg42_useable(mg42, node)) {
      other thread friendly_mg42_think(mg42, node);
      mg42 waittill("friendly_finished_using_mg42");
      if(IsAlive(other)) {
        other.turret_use_time = GetTime() + 10000;
      }
    }
    wait(1);
  }
}

friendly_mg42_death_notify(guy, mg42) {
  mg42 endon("friendly_finished_using_mg42");
  guy waittill("death");
  mg42 notify("friendly_finished_using_mg42");
  println("^a guy using gun died");
}

friendly_mg42_wait_for_use(mg42) {
  mg42 endon("friendly_finished_using_mg42");
  self.useable = true;
  self setcursorhint("HINT_NOICON");
  self setHintString(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  println("^a was used by player, stop using turret");
  self.useable = false;
  self SetHintString("");
  self StopUSeturret();
  self notify("stopped_use_turret");
  mg42 notify("friendly_finished_using_mg42");
}

friendly_mg42_useable(mg42, node) {
  if(self.useable) {
    return false;
  }
  if((isDefined(self.turret_use_time)) && (GetTime() < self.turret_use_time)) {
    return false;
  }
  players = get_players();
  for(q = 0; q < players.size; q++) {
    if(Distancesquared(players[q].origin, node.origin) < 100 * 100) {
      return false;
    }
  }
  if(isDefined(self.chainnode)) {
    player_count = 0;
    for(q = 0; q < players.size; q++) {
      if(Distancesquared(players[q].origin, self.chainnode.origin) > 1100 * 1100) {
        player_count++;
      }
    }
    if(player_count == players.size) {
      return false;
    }
  }
  return true;
}

friendly_mg42_endtrigger(mg42, guy) {
  mg42 endon("friendly_finished_using_mg42");
  self waittill("trigger");
  println("^a Told friendly to leave the MG42 now");
  mg42 notify("friendly_finished_using_mg42");
}

friendly_mg42_stop_use() {
  if(!isDefined(self.friendly_mg42)) {
    return;
  }
  self.friendly_mg42 notify("friendly_finished_using_mg42");
}

noFour() {
  self endon("death");
  self waittill("goal");
  self.goalradius = self.oldradius;
  if(self.goalradius < 32) {
    self.goalradius = 400;
  }
}

friendly_mg42_think(mg42, node) {
  self endon("death");
  mg42 endon("friendly_finished_using_mg42");
  level thread friendly_mg42_death_notify(self, mg42);
  self.oldradius = self.goalradius;
  self.goalradius = 28;
  self thread noFour();
  self SetGoalNode(node);
  self.ignoresuppression = true;
  self waittill("goal");
  self.goalradius = self.oldradius;
  if(self.goalradius < 32) {
    self.goalradius = 400;
  }
  self.ignoresuppression = false;
  self.goalradius = self.oldradius;
  players = get_players();
  for(q = 0; q < players.size; q++) {
    if(Distancesquared(players[q].origin, node.origin) < 32 * 32) {
      mg42 notify("friendly_finished_using_mg42");
      return;
    }
  }
  self.friendly_mg42 = mg42;
  self thread friendly_mg42_wait_for_use(mg42);
  self thread friendly_mg42_cleanup(mg42);
  self USeturret(mg42);
  if(isDefined(mg42.target)) {
    stoptrigger = GetEnt(mg42.target, "targetname");
    if(isDefined(stoptrigger)) {
      stoptrigger thread friendly_mg42_endtrigger(mg42, self);
    }
  }
  while(1) {
    if(Distance(self.origin, node.origin) < 32) {
      self USeturret(mg42);
    } else {
      break;
    }
    if(isDefined(self.chainnode)) {
      if(Distance(self.origin, self.chainnode.origin) > 1100) {
        break;
      }
    }
    wait(1);
  }
  mg42 notify("friendly_finished_using_mg42");
}

friendly_mg42_cleanup(mg42) {
  self endon("death");
  mg42 waittill("friendly_finished_using_mg42");
  self friendly_mg42_doneUsingTurret();
}

friendly_mg42_doneUsingTurret() {
  self endon("death");
  turret = self.friendly_mg42;
  self.friendly_mg42 = undefined;
  self StopUSeturret();
  self notify("stopped_use_turret");
  self.useable = false;
  self.goalradius = self.oldradius;
  if(!isDefined(turret)) {
    return;
  }
  if(!isDefined(turret.target)) {
    return;
  }
  node = GetNode(turret.target, "targetname");
  oldradius = self.goalradius;
  self.goalradius = 8;
  self SetGoalNode(node);
  wait(2);
  self.goalradius = 384;
  return;
  self waittill("goal");
  if(isDefined(self.target)) {
    node = GetNode(self.target, "targetname");
    if(isDefined(node.target)) {
      node = GetNode(node.target, "targetname");
    }
    if(isDefined(node)) {
      self SetGoalNode(node);
    }
  }
  self.goalradius = oldradius;
}

tanksquish() {
  if(isDefined(level.noTankSquish)) {
    assertex(level.noTankSquish, "level.noTankSquish must be true or undefined");
    return;
  }
  if(isDefined(level.levelHasVehicles) && !level.levelHasVehicles) {
    return;
  }
  while(1) {
    self waittill("damage", amt, who, force, b, mod, d, e);
    if(mod != "MOD_CRUSH") {
      continue;
    }
    if(!isDefined(self)) {
      return;
    }
    if(isalive(self)) {
      continue;
    }
    if(!isalive(who)) {
      return;
    }
    force = vectorscale(force, 50000);
    force = (force[0], force[1], abs(force[2]));
    if(isDefined(level._effect) && isDefined(level._effect["tanksquish"])) {
      playFX(level._effect["tanksquish"], self.origin + (0, 0, 30));
    }
    self startRagdoll();
    self playSound("human_crunch");
    return;
  }
}

panzer_target(ai, node, pos, targetEnt, targetEnt_offsetVec) {
  ai endon("death");
  ai.panzer_node = node;
  if(isDefined(node.script_delay)) {
    ai.panzer_delay = node.script_delay;
  }
  if((isDefined(targetEnt)) && (isDefined(targetEnt_offsetVec))) {
    ai.panzer_ent = targetEnt;
    ai.panzer_ent_offset = targetEnt_offsetVec;
  } else {
    ai.panzer_pos = pos;
  }
  ai SetGoalPos(ai.origin);
  ai SetGoalNode(node);
  ai.goalradius = 12;
  ai waittill("goal");
  ai.goalradius = 28;
  ai waittill("shot_at_target");
  ai.panzer_ent = undefined;
  ai.panzer_pos = undefined;
  ai.panzer_delay = undefined;
}

#using_animtree("generic_human");

showStart(origin, angles, anime) {
  org = GetStartOrigin(origin, angles, anime);
  for(;;) {
    print3d(org, "x", (0.0, 0.7, 1.0), 1, 0.25);
    wait(0.05);
  }
}

spawnWaypointFriendlies() {
  self.count = 1;
  if(isDefined(self.script_noenemyinfo) && isDefined(self.script_forcespawn))
    spawn = self stalingradspawn(true);
  else if(isDefined(self.script_noenemyinfo))
    spawn = self dospawn(true);
  else if(isDefined(self.script_forcespawn))
    spawn = self stalingradspawn();
  else
    spawn = self dospawn();
  if(spawn_failed(spawn))
    return;
  spawn.friendlyWaypoint = true;
}

waittillDeathOrLeaveSquad() {
  self endon("death");
  self waittill("leaveSquad");
}

friendlySpawnWave() {
  triggers = getEntArray(self.target, "targetname");
  for(i = 0; i < triggers.size; i++) {
    if(triggers[i] GetEntNum() == 526) {
      println("Target: " + triggers[i].target);
    }
  }
  array_thread(getEntArray(self.target, "targetname"), ::friendlySpawnWave_triggerThink, self);
  for(;;) {
    self waittill("trigger", other);
    if(activeFriendlyspawn() && getFriendlySpawnTrigger() == self) {
      unsetFriendlyspawn();
    }
    self waittill("friendly_wave_start", startPoint);
    setFriendlyspawn(startPoint, self);
    if(!isDefined(startPoint.target)) {
      continue;
    }
    trigger = GetEnt(startPoint.target, "targetname");
    trigger thread spawnWaveStopTrigger(self);
  }
}

flood_and_secure(instantRespawn) {
  if(!isDefined(instantRespawn)) {
    instantRespawn = false;
  }
  if((isDefined(self.script_noteworthy)) && (self.script_noteworthy == "instant_respawn")) {
    instantRespawn = true;
  }
  level.spawnerWave = [];
  spawners = getEntArray(self.target, "targetname");
  array_thread(spawners, ::flood_and_secure_spawner, instantRespawn);
  playerTriggered = false;
  for(;;) {
    self waittill("trigger", other);
    if(!objectiveIsAllowed()) {
      continue;
    }
    if(any_player_IsTouching(self)) {
      playerTriggered = true;
    } else {
      if(!IsAlive(other)) {
        continue;
      }
      if(IsPlayer(other)) {
        playerTriggered = true;
      } else if(!isDefined(other.isSquad) || !other.isSquad) {
        continue;
      }
    }
    spawners = getEntArray(self.target, "targetname");
    if(isDefined(spawners[0])) {
      if(isDefined(spawners[0].script_randomspawn)) {
        select_random_spawn(spawners);
      }
    }
    spawners = getEntArray(self.target, "targetname");
    for(i = 0; i < spawners.size; i++) {
      spawners[i].playerTriggered = playerTriggered;
      spawners[i] notify("flood_begin");
    }
    if(playerTriggered) {
      wait(5);
    } else {
      wait(0.1);
    }
  }
}

select_random_spawn(spawners) {
  groups = [];
  for(i = 0; i < spawners.size; i++) {
    groups[spawners[i].script_randomspawn] = true;
  }
  keys = getarraykeys(groups);
  num_that_lives = random(keys);
  for(i = 0; i < spawners.size; i++) {
    if(spawners[i].script_randomspawn != num_that_lives)
      spawners[i] delete();
  }
}

flood_and_secure_spawner(instantRespawn) {
  if(isDefined(self.secureStarted)) {
    return;
  }
  self.secureStarted = true;
  self.triggerUnlocked = true;
  target = self.target;
  targetname = self.targetname;
  if((!isDefined(target)) && (!isDefined(self.script_moveoverride))) {
    println("Entity " + self.classname + " at origin " + self.origin + " has no target");
    waittillframeend;
    assert(isDefined(target));
  }
  spawners = [];
  if(isDefined(target)) {
    possibleSpawners = getEntArray(target, "targetname");
    for(i = 0; i < possibleSpawners.size; i++) {
      if(!issubstr(possibleSpawners[i].classname, "actor"))
        continue;
      spawners[spawners.size] = possibleSpawners[i];
    }
  }
  ent = spawnStruct();
  org = self.origin;
  flood_and_secure_spawner_think(ent, spawners.size > 0, instantRespawn);
  if(isalive(ent.ai))
    ent.ai waittill("death");
  if(!isDefined(target)) {
    return;
  }
  possibleSpawners = getEntArray(target, "targetname");
  if(!possibleSpawners.size) {
    return;
  }
  for(i = 0; i < possibleSpawners.size; i++) {
    if(!issubstr(possibleSpawners[i].classname, "actor")) {
      continue;
    }
    possibleSpawners[i].targetname = targetname;
    newTarget = target;
    if(isDefined(possibleSpawners[i].target)) {
      targetEnt = getent(possibleSpawners[i].target, "targetname");
      if(!isDefined(targetEnt) || !issubstr(targetEnt.classname, "actor"))
        newTarget = possibleSpawners[i].target;
    }
    possibleSpawners[i].target = newTarget;
    possibleSpawners[i] thread flood_and_secure_spawner(instantRespawn);
    possibleSpawners[i].playerTriggered = true;
    possibleSpawners[i] notify("flood_begin");
  }
}

flood_and_secure_spawner_think(ent, oneShot, instantRespawn) {
  assert(isDefined(instantRespawn));
  self endon("death");
  count = self.count;
  if(!oneShot)
    oneshot = (isDefined(self.script_noteworthy) && self.script_noteworthy == "delete");
  self.count = 2;
  if(isDefined(self.script_delay))
    delay = self.script_delay;
  else
    delay = 0;
  for(;;) {
    self waittill("flood_begin");
    if(self.playerTriggered) {
      break;
    }
    if(delay)
      continue;
    break;
  }
  closest_player = get_closest_player(self.origin);
  dist = Distancesquared(closest_player.origin, self.origin);
  prof_begin("flood_and_secure_spawner_think");
  while(count) {
    self.trueCount = count;
    self.count = 2;
    wait(delay);
    if(isDefined(self.script_noenemyinfo) && isDefined(self.script_forcespawn))
      spawn = self stalingradspawn(true);
    else if(isDefined(self.script_noenemyinfo))
      spawn = self dospawn(true);
    else if(isDefined(self.script_forcespawn))
      spawn = self stalingradspawn();
    else
      spawn = self dospawn();
    if(spawn_failed(spawn)) {
      playerKill = false;
      if(delay < 2)
        wait(2);
      continue;
    } else {
      thread addToWaveSpawner(spawn);
      spawn thread flood_and_secure_spawn(self);
      if(isDefined(self.script_accuracy))
        spawn.baseAccuracy = self.script_accuracy;
      ent.ai = spawn;
      ent notify("got_ai");
      self waittill("spawn_died", deleted, playerKill);
      if(delay > 2)
        delay = randomint(4) + 2;
      else
        delay = 0.5 + randomfloat(0.5);
    }
    if(deleted) {
      waittillRestartOrDistance(dist);
    } else {
      if(playerWasNearby(playerKill || oneShot, ent.ai))
        count--;
      if(!instantRespawn)
        waitUntilWaveRelease();
    }
  }
  prof_end("flood_and_secure_spawner_think");
  self delete();
}

waittillDeletedOrDeath(spawn) {
  self endon("death");
  spawn waittill("death");
}

addToWaveSpawner(spawn) {
  name = self.targetname;
  if(!isDefined(level.spawnerWave[name])) {
    level.spawnerWave[name] = spawnStruct();
    level.spawnerWave[name].count = 0;
    level.spawnerWave[name].total = 0;
  }
  if(!isDefined(self.addedToWave)) {
    self.addedToWave = true;
    level.spawnerWave[name].total++;
  }
  level.spawnerWave[name].count++;
  waittillDeletedOrDeath(spawn);
  level.spawnerWave[name].count--;
  if(!isDefined(self)) {
    level.spawnerWave[name].total--;
  }
  if(level.spawnerWave[name].total) {
    if(level.spawnerWave[name].count / level.spawnerWave[name].total < 0.32) {
      level.spawnerWave[name] notify("waveReady");
    }
  }
}

debugWaveCount(ent) {
  self endon("debug_stop");
  self endon("death");
  for(;;) {
    print3d(self.origin, ent.count + "/" + ent.total, (0, 0.8, 1), 0.5);
    wait(0.05);
  }
}

waitUntilWaveRelease() {
  name = self.targetName;
  if(level.spawnerWave[name].count) {
    level.spawnerWave[name] waittill("waveReady");
  }
}

playerWasNearby(playerKill, ai) {
  if(playerKill) {
    return true;
  }
  if(isDefined(ai) && isDefined(ai.origin)) {
    org = ai.origin;
  } else {
    org = self.origin;
  }
  closest_player = get_closest_player(org);
  if(Distancesquared(closest_player.origin, org) < 700 * 700) {
    return true;
  }
  return BulletTracePassed(closest_player getEye(), ai getEye(), false, undefined);
}

waittillRestartOrDistance(dist) {
  self endon("flood_begin");
  dist = dist * (0.75 * 0.75);
  closest_player = get_closest_player(self.origin);
  while(Distancesquared(closest_player.origin, self.origin) > dist) {
    wait(1);
    closest_player = get_closest_player(self.origin);
  }
}

flood_and_secure_spawn(spawner) {
  self thread flood_and_secure_spawn_goal();
  self waittill("death", other);
  playerKill = isalive(other) && IsPlayer(other);
  if(!playerkill && isDefined(other) && other.classname == "worldspawn") {
    playerKill = true;
  }
  deleted = !isDefined(self);
  spawner notify("spawn_died", deleted, playerKill);
}

flood_and_secure_spawn_goal() {
  if(isDefined(self.script_moveoverride)) {
    return;
  }
  self endon("death");
  node = GetNode(self.target, "targetname");
  self SetGoalNode(node);
  if(isDefined(level.fightdist)) {
    self.pathenemyfightdist = level.fightdist;
    self.pathenemylookahead = level.maxdist;
  }
  if(node.radius) {
    self.goalradius = node.radius;
  } else {
    self.goalradius = 64;
  }
  self waittill("goal");
  while(isDefined(node.target)) {
    newNode = GetNode(node.target, "targetname");
    if(isDefined(newNode)) {
      node = newNode;
    } else {
      break;
    }
    self SetGoalNode(node);
    if(node.radius) {
      self.goalradius = node.radius;
    } else {
      self.goalradius = 64;
    }
    self waittill("goal");
  }
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self DoDamage((self.health * 0.5), (0, 0, 0));
      return;
    }
  }
  if(isDefined(node.target)) {
    turret = GetEnt(node.target, "targetname");
    if(isDefined(turret) && (turret.classname == "misc_mgturret" || turret.classname == "misc_turret")) {
      self SetGoalNode(node);
      self.goalradius = 4;
      self waittill("goal");
      if(!isDefined(self.script_forcegoal)) {
        self.goalradius = level.default_goalradius;
      }
      self maps\_spawner::use_a_turret(turret);
    }
  }
  if(isDefined(self.script_noteworthy)) {
    if(isDefined(self.script_noteworthy2)) {
      if(self.script_noteworthy2 == "furniture_push") {
        thread furniturePushSound();
      }
    }
    if(self.script_noteworthy == "hide") {
      self thread set_battlechatter(false);
      return;
    }
  }
  if(!isDefined(self.script_forcegoal)) {
    self.goalradius = level.default_goalradius;
  }
}

furniturePushSound() {
  org = GetEnt(self.target, "targetname").origin;
  play_sound_in_space("furniture_slide", org);
  wait(0.9);
  if(isDefined(level.whisper)) {
    play_sound_in_space(random(level.whisper), org);
  }
}

friendlychain() {
  waittillframeend;
  triggers = getEntArray(self.target, "targetname");
  if(!triggers.size) {
    node = GetNode(self.target, "targetname");
    assert(isDefined(node));
    assert(isDefined(node.script_noteworthy));
    for(;;) {
      self waittill("trigger");
      if(isDefined(level.lastFriendlyTrigger) && level.lastFriendlyTrigger == self) {
        wait(0.5);
        continue;
      }
      if(!objectiveIsAllowed()) {
        wait(0.5);
        continue;
      }
      level notify("new_friendly_trigger");
      level.lastFriendlyTrigger = self;
      rejoin = !isDefined(self.script_baseOfFire) || self.script_baseOfFire == 0;
      setNewPlayerChain(node, rejoin);
    }
  }
  for(i = 0; i < triggers.size; i++) {
    node = GetNode(triggers[i].target, "targetname");
    assert(isDefined(node));
    assert(isDefined(node.script_noteworthy));
  }
  for(;;) {
    self waittill("trigger");
    while(any_player_IsTouching(self)) {
      wait(0.05);
    }
    if(!objectiveIsAllowed()) {
      wait(0.05);
      continue;
    }
    if(isDefined(level.lastFriendlyTrigger) && level.lastFriendlyTrigger == self) {
      continue;
    }
    level notify("new_friendly_trigger");
    level.lastFriendlyTrigger = self;
    array_thread(triggers, ::friendlyTrigger);
    wait(0.5);
  }
}

objectiveIsAllowed() {
  active = true;
  if(isDefined(self.script_objective_active)) {
    active = false;
    for(i = 0; i < level.active_objective.size; i++) {
      if(!IsSubStr(self.script_objective_active, level.active_objective[i])) {
        continue;
      }
      active = true;
      break;
    }
    if(!active) {
      return false;
    }
  }
  if(!isDefined(self.script_objective_inactive)) {
    return (active);
  }
  inactive = 0;
  for(i = 0; i < level.inactive_objective.size; i++) {
    if(!IsSubStr(self.script_objective_inactive, level.inactive_objective[i])) {
      continue;
    }
    inactive++;
  }
  tokens = Strtok(self.script_objective_inactive, " ");
  return (inactive == tokens.size);
}

friendlyTrigger(node) {
  level endon("new_friendly_trigger");
  self waittill("trigger");
  node = GetNode(self.target, "targetname");
  rejoin = !isDefined(self.script_baseOfFire) || self.script_baseOfFire == 0;
  setNewPlayerChain(node, rejoin);
}

waittillDeathOrEmpty() {
  self endon("death");
  num = self.script_deathChain;
  while(self.count) {
    self waittill("spawned", spawn);
    spawn thread deathChainAINotify(num);
  }
}

deathChainAINotify(num) {
  level.deathSpawner[num]++;
  self waittill("death");
  level.deathSpawner[num]--;
  level notify("spawner_expired" + num);
}

deathChainSpawnerLogic() {
  num = self.script_deathChain;
  level.deathSpawner[num]++;
  level.deathSpawnerEnts[num][level.deathSpawnerEnts[num].size] = self;
  org = self.origin;
  self waittillDeathOrEmpty();
  newDeathSpawners = [];
  if(isDefined(self)) {
    for(i = 0; i < level.deathSpawnerEnts[num].size; i++) {
      if(!isDefined(level.deathSpawnerEnts[num][i])) {
        continue;
      }
      if(self == level.deathSpawnerEnts[num][i]) {
        continue;
      }
      newDeathSpawners[newDeathSpawners.size] = level.deathSpawnerEnts[num][i];
    }
  } else {
    for(i = 0; i < level.deathSpawnerEnts[num].size; i++) {
      if(!isDefined(level.deathSpawnerEnts[num][i])) {
        continue;
      }
      newDeathSpawners[newDeathSpawners.size] = level.deathSpawnerEnts[num][i];
    }
  }
  level.deathSpawnerEnts[num] = newDeathSpawners;
  level notify("spawner dot" + org);
  level.deathSpawner[num]--;
  level notify("spawner_expired" + num);
}

friendlychain_onDeath() {
  triggers = getEntArray("friendly_chain_on_death", "targetname");
  spawners = GetSpawnerArray();
  level.deathSpawner = [];
  level.deathSpawnerEnts = [];
  for(i = 0; i < spawners.size; i++) {
    if(!isDefined(spawners[i].script_deathchain)) {
      continue;
    }
    num = spawners[i].script_deathchain;
    if(!isDefined(level.deathSpawner[num])) {
      level.deathSpawner[num] = 0;
      level.deathSpawnerEnts[num] = [];
    }
    spawners[i] thread deathChainSpawnerLogic();
  }
  for(i = 0; i < triggers.size; i++) {
    if(!isDefined(triggers[i].script_deathchain)) {
      println("trigger at origin " + triggers[i] GetOrigin() + " has no script_deathchain");
      return;
    }
    triggers[i] thread friendlyChain_onDeathThink();
  }
}

friendlyChain_onDeathThink() {
  while(level.deathSpawner[self.script_deathChain] > 0) {
    level waittill("spawner_expired" + self.script_deathChain);
  }
  level endon("start_chain");
  node = GetNode(self.target, "targetname");
  for(;;) {
    self waittill("trigger");
    setNewPlayerChain(node, true);
    iprintlnbold("Area secured, move up!");
    wait(5);
  }
}

setNewPlayerChain(node, rejoin) {
  players = get_players();
  players[0] set_friendly_chain_wrapper(node);
  level notify("new_escort_trigger");
  level notify("new_escort_debug");
  level notify("start_chain", rejoin);
}

friendlyChains() {
  level.friendlySpawnOrg = [];
  level.friendlySpawnTrigger = [];
  array_thread(getEntArray("friendlychain", "targetname"), ::friendlychain);
}

unsetFriendlyspawn() {
  newOrg = [];
  newTrig = [];
  for(i = 0; i < level.friendlySpawnOrg.size; i++) {
    newOrg[newOrg.size] = level.friendlySpawnOrg[i];
    newTrig[newTrig.size] = level.friendlySpawnTrigger[i];
  }
  level.friendlySpawnOrg = newOrg;
  level.friendlySpawnTrigger = newTrig;
  if(activeFriendlyspawn()) {
    return;
  }
  flag_Clear("spawning_friendlies");
}

getFriendlySpawnStart() {
  assert(level.friendlySpawnOrg.size > 0);
  return (level.friendlySpawnOrg[level.friendlySpawnOrg.size - 1]);
}

activeFriendlyspawn() {
  return level.friendlySpawnOrg.size > 0;
}

getFriendlySpawnTrigger() {
  assert(level.friendlySpawnTrigger.size > 0);
  return (level.friendlySpawnTrigger[level.friendlySpawnTrigger.size - 1]);
}

setFriendlyspawn(org, trigger) {
  level.friendlySpawnOrg[level.friendlySpawnOrg.size] = org.origin;
  level.friendlySpawnTrigger[level.friendlySpawnTrigger.size] = trigger;
  flag_set("spawning_friendlies");
}

spawnWaveStopTrigger(startTrigger) {
  self notify("stopTrigger");
  self endon("stopTrigger");
  self waittill("trigger");
  if(getFriendlySpawnTrigger() != startTrigger) {
    return;
  }
  unsetFriendlyspawn();
}

friendlySpawnWave_triggerThink(startTrigger) {
  org = GetEnt(self.target, "targetname");
  for(;;) {
    self waittill("trigger");
    startTrigger notify("friendly_wave_start", org);
    if(!isDefined(org.target)) {
      continue;
    }
  }
}

goalVolumes() {
  volumes = getEntArray("info_volume", "classname");
  level.deathchain_goalVolume = [];
  level.goalVolumes = [];
  for(i = 0; i < volumes.size; i++) {
    volume = volumes[i];
    if(isDefined(volume.script_deathChain)) {
      level.deathchain_goalVolume[volume.script_deathChain] = volume;
    }
    if(isDefined(volume.script_goalvolume)) {
      level.goalVolumes[volume.script_goalVolume] = volume;
    }
  }
}

debugprInt(msg, endonmsg, color) {
  if(1) {
    return;
  }
  org = self GetOrigin();
  height = 40 * Sin(org[0] + org[1]) - 40;
  org = (org[0], org[1], org[2] + height);
  level endon(endonmsg);
  self endon("new_color");
  if(!isDefined(color)) {
    color = (0, 0.8, 0.6);
  }
  num = 0;
  for(;;) {
    num += 12;
    scale = Sin(num) * 0.4;
    if(scale < 0) {
      scale *= -1;
    }
    scale += 1;
    print3d(org, msg, color, 1, scale);
    wait(0.05);
  }
}

aigroup_create(aigroup) {
  level._ai_group[aigroup] = spawnStruct();
  level._ai_group[aigroup].aicount = 0;
  level._ai_group[aigroup].spawnercount = 0;
  level._ai_group[aigroup].ai = [];
  level._ai_group[aigroup].spawners = [];
}

aigroup_spawnerthink(tracker) {
  self endon("death");
  self.decremented = false;
  tracker.spawnercount++;
  self thread aigroup_spawnerdeath(tracker);
  self thread aigroup_spawnerempty(tracker);
  while(self.count) {
    self waittill("spawned", soldier);
    if(spawn_failed(soldier)) {
      continue;
    }
    soldier thread aigroup_soldierthink(tracker);
  }
  waittillframeend;
  if(self.decremented) {
    return;
  }
  self.decremented = true;
  tracker.spawnercount--;
}

aigroup_spawnerdeath(tracker) {
  self waittill("death");
  if(self.decremented) {
    return;
  }
  tracker.spawnercount--;
}

aigroup_spawnerempty(tracker) {
  self endon("death");
  self waittill("emptied spawner");
  waittillframeend;
  if(self.decremented) {
    return;
  }
  self.decremented = true;
  tracker.spawnercount--;
}

aigroup_soldierthink(tracker) {
  tracker.aicount++;
  tracker.ai[tracker.ai.size] = self;
  if(isDefined(self.script_deathflag_longdeath)) {
    self waittillDeathOrPainDeath();
  } else {
    self waittill("death");
  }
  tracker.aicount--;
}

camper_trigger_think(trigger) {
  tokens = strtok(trigger.script_linkto, " ");
  spawners = [];
  nodes = [];
  for(i = 0; i < tokens.size; i++) {
    token = tokens[i];
    ai = getent(token, "script_linkname");
    if(isDefined(ai)) {
      spawners = add_to_array(spawners, ai);
      continue;
    }
    node = getnode(token, "script_linkname");
    if(!isDefined(node)) {
      println("Warning: Trigger token number " + token + " did not exist.");
      continue;
    }
    nodes = add_to_array(nodes, node);
  }
  assertEX(spawners.size, "camper_spawner without any spawners associated");
  assertEX(nodes.size, "camper_spawner without any nodes associated");
  assertEX(nodes.size >= spawners.size, "camper_spawner with less nodes than spawners");
  trigger waittill("trigger");
  nodes = array_randomize(nodes);
  for(i = 0; i < nodes.size; i++)
    nodes[i].claimed = false;
  j = 0;
  for(i = 0; i < spawners.size; i++) {
    spawner = spawners[i];
    if(!isDefined(spawner)) {
      continue;
    }
    if(isDefined(spawner.script_spawn_here)) {
      continue;
    }
    while(isDefined(nodes[j].script_noteworthy) && nodes[j].script_noteworthy == "dont_spawn")
      j++;
    spawner.origin = nodes[j].origin;
    spawner.angles = nodes[j].angles;
    spawner add_spawn_function(::claim_a_node, nodes[j]);
    j++;
  }
  array_thread(spawners, ::add_spawn_function, ::camper_guy);
  array_thread(spawners, ::add_spawn_function, ::move_when_enemy_hides, nodes);
  array_thread(spawners, ::spawn_ai);
}

camper_guy() {
  self.goalradius = 8;
  self.fixednode = true;
}

move_when_enemy_hides(nodes) {
  self endon("death");
  waitingForEnemyToDisappear = false;
  while(1) {
    if(!isalive(self.enemy)) {
      self waittill("enemy");
      waitingForEnemyToDisappear = false;
      continue;
    }
    if(IsPlayer(self.enemy)) {
      if(flag("player_has_red_flashing_overlay") || flag("player_flashed")) {
        self.fixednode = 0;
        for(;;) {
          self.goalradius = 180;
          self setgoalpos(self.enemy.origin);
          wait(1);
        }
        return;
      }
    }
    if(waitingForEnemyToDisappear) {
      if(self cansee(self.enemy)) {
        wait .05;
        continue;
      }
      waitingForEnemyToDisappear = false;
    } else {
      if(self cansee(self.enemy)) {
        waitingForEnemyToDisappear = true;
      }
      wait .05;
      continue;
    }
    if(randomint(3) > 0) {
      node = find_unclaimed_node(nodes);
      if(isDefined(node)) {
        self claim_a_node(node, self.claimed_node);
        self setgoalnode(node);
        self waittill("goal");
      }
    }
  }
}

claim_a_node(claimed_node, old_claimed_node) {
  self setgoalnode(claimed_node);
  self.claimed_node = claimed_node;
  claimed_node.claimed = true;
  if(isDefined(old_claimed_node))
    old_claimed_node.claimed = false;
}

find_unclaimed_node(nodes) {
  for(i = 0; i < nodes.size; i++) {
    if(nodes[i].claimed)
      continue;
    else
      return nodes[i];
  }
  return undefined;
}

flood_trigger_think(trigger) {
  assertEX(isDefined(trigger.target), "flood_spawner at " + trigger.origin + " without target");
  floodSpawners = getEntArray(trigger.target, "targetname");
  assertex(floodSpawners.size, "flood_spawner at with target " + trigger.target + " without any targets");
  for(i = 0; i < floodSpawners.size; i++) {
    floodSpawners[i].script_trigger = trigger;
  }
  array_thread(floodSpawners, ::flood_spawner_init);
  trigger waittill("trigger");
  floodSpawners = getEntArray(trigger.target, "targetname");
  {
    array_thread(floodSpawners, ::flood_spawner_think, trigger);
  }
}

flood_spawner_init(spawner) {
  assertex((isDefined(self.spawnflags) && self.spawnflags & 1), "Spawner at origin" + self.origin + "/" + (self GetOrigin()) + " is not a spawner!");
}

trigger_requires_player(trigger) {
  if(!isDefined(trigger)) {
    return false;
  }
  return isDefined(trigger.script_requires_player);
}

two_stage_spawner_think(trigger) {
  trigger_target = getent(trigger.target, "targetname");
  assertEx(isDefined(trigger_target), "Trigger with targetname two_stage_spawner that doesnt target anything.");
  assertEx(issubstr(trigger_target.classname, "trigger"), "Triggers with targetname two_stage_spawner must target a trigger");
  assertEx(isDefined(trigger_target.target), "The second trigger of a two_stage_spawner must target at least one spawner");
  waittillframeend;
  spawners = getEntArray(trigger_target.target, "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].script_moveoverride = true;
    spawners[i] add_spawn_function(::wait_to_go, trigger_target);
  }
  trigger waittill("trigger");
  spawners = getEntArray(trigger_target.target, "targetname");
  array_thread(spawners, ::spawn_ai);
}

wait_to_go(trigger_target) {
  trigger_target endon("death");
  self endon("death");
  self.goalradius = 8;
  trigger_target waittill("trigger");
  self thread go_to_node();
}

flood_spawner_think(trigger) {
  self endon("death");
  self notify("stop current floodspawner");
  self endon("stop current floodspawner");
  if(is_pyramid_spawner()) {
    pyramid_spawn(trigger);
    return;
  }
  requires_player = trigger_requires_player(trigger);
  script_delay();
  while(self.count > 0) {
    if(requires_player) {
      while(!any_player_IsTouching(trigger)) {
        wait(0.5);
      }
    }
    while(!(self ok_to_trigger_spawn())) {
      wait_network_frame();
    }
    if(isDefined(self.script_noenemyinfo) && isDefined(self.script_forcespawn))
      soldier = self stalingradspawn(true);
    else if(isDefined(self.script_noenemyinfo))
      soldier = self dospawn(true);
    else if(isDefined(self.script_forcespawn))
      soldier = self stalingradspawn();
    else
      soldier = self dospawn();
    if(spawn_failed(soldier)) {
      wait(2);
      continue;
    }
    level._numTriggerSpawned++;
    soldier thread reincrement_count_if_deleted(self);
    soldier thread expand_goalradius(trigger);
    soldier waittill("death", attacker);
    if(!player_saw_kill(soldier, attacker)) {
      self.count++;
    }
    if(!isDefined(soldier)) {
      continue;
    }
    if(!script_wait(true)) {
      players = get_players();
      if(players.size == 1) {
        wait(RandomFloatrange(5, 9));
      } else if(players.size == 2) {
        wait(RandomFloatrange(3, 6));
      } else if(players.size == 3) {
        wait(RandomFloatrange(1, 4));
      } else if(players.size == 4) {
        wait(RandomFloatrange(0.5, 1.5));
      }
    }
  }
}

player_saw_kill(guy, attacker) {
  if(isDefined(self.script_force_count))
    if(self.script_force_count)
      return true;
  if(!isDefined(guy)) {
    return false;
  }
  if(IsAlive(attacker)) {
    if(IsPlayer(attacker)) {
      return true;
    }
    players = get_players();
    for(q = 0; q < players.size; q++) {
      if(DistanceSquared(attacker.origin, players[q].origin) < 200 * 200) {
        return true;
      }
    }
  } else {
    if(isDefined(attacker)) {
      if(attacker.classname == "worldspawn") {
        return false;
      }
      player = get_closest_player(attacker.origin);
      if(isDefined(player) && distance(attacker.origin, player.origin) < 200) {
        return true;
      }
    }
  }
  closest_player = get_closest_player(guy.origin);
  if(isDefined(closest_player) && distance(guy.origin, closest_player.origin) < 200) {
    return true;
  }
  return bulletTracePassed(closest_player getEye(), guy getEye(), false, undefined);
}

is_pyramid_spawner() {
  if(!isDefined(self.target)) {
    return false;
  }
  ent = getEntArray(self.target, "targetname");
  if(!ent.size) {
    return false;
  }
  return IsSubStr(ent[0].classname, "actor");
}

pyramid_death_report(spawner) {
  spawner.spawn waittill("death");
  self notify("death_report");
}

pyramid_spawn(trigger) {
  self endon("death");
  requires_player = trigger_requires_player(trigger);
  script_delay();
  if(requires_player) {
    while(!any_player_IsTouching(trigger)) {
      wait(0.5);
    }
  }
  spawners = getEntArray(self.target, "targetname");
  for(i = 0; i < spawners.size; i++) {
    assertex(IsSubStr(spawners[i].classname, "actor"), "Pyramid spawner targets non AI!");
  }
  self.spawners = 0;
  array_thread(spawners, ::pyramid_spawner_reports_death, self);
  offset = RandomInt(spawners.size);
  for(i = 0; i < spawners.size; i++) {
    if(self.count <= 0) {
      return;
    }
    offset++;
    if(offset >= spawners.size) {
      offset = 0;
    }
    spawner = spawners[offset];
    spawner.count = 1;
    while(!(self ok_to_trigger_spawn())) {
      wait_network_frame();
    }
    soldier = spawner spawn_ai();
    level._numTriggerSpawned++;
    if(spawn_failed(soldier)) {
      wait(2);
      continue;
    }
    self.count--;
    spawner.spawn = soldier;
    soldier thread reincrement_count_if_deleted(self);
    soldier thread expand_goalradius(trigger);
    thread pyramid_death_report(spawner);
  }
  culmulative_wait = 0.01;
  while(self.count > 0) {
    self waittill("death_report");
    script_wait(true);
    wait(culmulative_wait);
    culmulative_wait += 2.5;
    offset = RandomInt(spawners.size);
    for(i = 0; i < spawners.size; i++) {
      spawners = array_removeUndefined(spawners);
      if(!spawners.size) {
        if(isDefined(self)) {
          self Delete();
        }
        return;
      }
      offset++;
      if(offset >= spawners.size) {
        offset = 0;
      }
      spawner = spawners[offset];
      if(IsAlive(spawner.spawn)) {
        continue;
      }
      if(isDefined(spawner.target)) {
        self.target = spawner.target;
      } else {
        self.target = undefined;
      }
      while(!(self ok_to_trigger_spawn())) {
        wait_network_frame();
      }
      soldier = self spawn_ai();
      if(spawn_failed(soldier)) {
        wait(2);
        continue;
      }
      level._numTriggerSpawned++;
      assertex(isDefined(spawner), "Theoretically impossible.");
      soldier thread reincrement_count_if_deleted(self);
      soldier thread expand_goalradius(trigger);
      spawner.spawn = soldier;
      thread pyramid_death_report(spawner);
      if(self.count <= 0) {
        return;
      }
    }
  }
}

pyramid_spawner_reports_death(parent) {
  parent endon("death");
  parent.spawners++;
  self waittill("death");
  parent.spawners--;
  if(!parent.spawners) {
    parent Delete();
  }
}

expand_goalradius(trigger) {
  if(isDefined(self.script_forcegoal)) {
    return;
  }
  radius = level.default_goalradius;
  if(isDefined(trigger)) {
    if(isDefined(trigger.script_radius)) {
      if(trigger.script_radius == -1) {
        return;
      }
      radius = trigger.script_radius;
    }
  }
  if(isDefined(self.script_forcegoal)) {
    return;
  }
  self endon("death");
  self waittill("goal");
  self.goalradius = radius;
}

drop_health_timeout_thread() {
  self endon("death");
  wait(95);
  self notify("timeout");
}

drop_health_trigger_think() {
  self endon("timeout");
  thread drop_health_timeout_thread();
  self waittill("trigger");
  change_player_health_packets(1);
}

traceShow(org) {
  for(;;) {
    line(org + (0, 0, 100), org, (0.2, 0.5, 0.8), 0.5);
    wait(0.05);
  }
}

show_bad_path() {
  if(getdebugdvar("debug_badpath") == "")
    setdvar("debug_badpath", "");
  self endon("death");
  last_bad_path_time = -5000;
  bad_path_count = 0;
  for(;;) {
    self waittill("bad_path", badPathPos);
    if(!isDefined(level.debug_badpath) || !level.debug_badpath) {
      continue;
    }
    if(gettime() - last_bad_path_time > 5000) {
      bad_path_count = 0;
    } else {
      bad_path_count++;
    }
    last_bad_path_time = gettime();
    if(bad_path_count < 10) {
      continue;
    }
    for(p = 0; p < 10 * 20; p++) {
      line(self.origin, badPathPos, (1, 0.4, 0.1), 0, 10 * 20);
      wait(0.05);
    }
  }
}

random_spawn(trigger) {
  trigger waittill("trigger");
  spawners = getEntArray(trigger.target, "targetname");
  if(!spawners.size) {
    return;
  }
  spawner = random(spawners);
  spawners = [];
  spawners[spawners.size] = spawner;
  if(isDefined(spawner.script_linkto)) {
    links = Strtok(spawner.script_linkto, " ");
    for(i = 0; i < links.size; i++) {
      spawners[spawners.size] = GetEnt(links[i], "script_linkname");
    }
  }
  waittillframeend;
  array_thread(spawners, ::add_spawn_function, ::blowout_goalradius_on_pathend);
  array_thread(spawners, ::spawn_ai);
}

blowout_goalradius_on_pathend() {
  if(isDefined(self.script_forcegoal)) {
    return;
  }
  self endon("death");
  self waittill("reached_path_end");
  self.goalradius = level.default_goalradius;
}

objective_event_init(trigger) {
  flag = trigger get_trigger_flag();
  assertex(isDefined(flag), "Objective event at origin " + trigger.origin + " does not have a script_flag. ");
  flag_init(flag);
  assertex(isDefined(level.deathSpawner[trigger.script_deathChain]), "The objective event trigger for deathchain " + trigger.script_deathchain + " is not associated with any AI.");
  if(!isDefined(level.deathSpawner[trigger.script_deathChain])) {
    return;
  }
  while(level.deathSpawner[trigger.script_deathChain] > 0) {
    level waittill("spawner_expired" + trigger.script_deathChain);
  }
  flag_set(flag);
}

setup_ai_eq_triggers() {
  self endon("death");
  waittillframeend;
  self.is_the_player = IsPlayer(self);
  self.eq_table = [];
  self.eq_touching = [];
  for(i = 0; i < level.eq_trigger_num; i++) {
    self.eq_table[i] = false;
  }
}

ai_array() {
  level.ai_array[level.ai_number] = self;
  self waittill("death");
  waittillframeend;
  level.ai_array[level.ai_number] = undefined;
}

player_score_think() {
  if(self.team == "allies") {
    return;
  }
  self waittill("death", attacker);
  if(isDefined(attacker) && IsPlayer(attacker)) {
    attacker thread updatePlayerScore(1 + RandomInt(3));
  }
}

updatePlayerScore(amount) {
  if(amount == 0) {
    return;
  }
  self notify("update_xp");
  self endon("update_xp");
  self.rankUpdateTotal += amount;
  self.hud_rankscroreupdate.label = & "SCRIPT_PLUS";
  self.hud_rankscroreupdate Setvalue(self.rankUpdateTotal);
  self.hud_rankscroreupdate.alpha = 1;
  self.hud_rankscroreupdate thread fontPulse(self);
  wait(1);
  self.hud_rankscroreupdate FadeOverTime(0.75);
  self.hud_rankscroreupdate.alpha = 0;
  self.rankUpdateTotal = 0;
}

xp_init() {
  self.rankUpdateTotal = 0;
  self.hud_rankscroreupdate = NewHudElem(self);
  self.hud_rankscroreupdate.horzAlign = "center";
  self.hud_rankscroreupdate.vertAlign = "middle";
  self.hud_rankscroreupdate.alignX = "center";
  self.hud_rankscroreupdate.alignY = "middle";
  self.hud_rankscroreupdate.x = 0;
  self.hud_rankscroreupdate.y = -60;
  self.hud_rankscroreupdate.font = "default";
  self.hud_rankscroreupdate.fontscale = 2;
  self.hud_rankscroreupdate.archived = false;
  self.hud_rankscroreupdate.color = (1, 1, 1);
  self.hud_rankscroreupdate fontPulseInit();
}

fontPulseInit() {
  self.baseFontScale = self.fontScale;
  self.maxFontScale = self.fontScale * 2;
  self.inFrames = 3;
  self.outFrames = 5;
}

fontPulse(player) {
  self notify("fontPulse");
  self endon("fontPulse");
  scaleRange = self.maxFontScale - self.baseFontScale;
  while(self.fontScale < self.maxFontScale) {
    self.fontScale = min(self.maxFontScale, self.fontScale + (scaleRange / self.inFrames));
    wait(0.05);
  }
  while(self.fontScale > self.baseFontScale) {
    self.fontScale = max(self.baseFontScale, self.fontScale - (scaleRange / self.outFrames));
    wait(0.05);
  }
}

#using_animtree("generic_human");

spawner_dronespawn(spawner) {
  assert(isDefined(level.dronestruct[spawner.classname]));
  struct = level.dronestruct[spawner.classname];
  drone = spawn("script_model", spawner.origin);
  drone.angles = spawner.angles;
  drone setModel(struct.model);
  drone UseAnimTree(#animtree);
  drone makefakeai();
  attachedmodels = struct.attachedmodels;
  attachedtags = struct.attachedtags;
  for(i = 0; i < attachedmodels.size; i++)
    drone attach(attachedmodels[i], attachedtags[i]);
  if(isDefined(spawner.script_startingposition))
    drone.script_startingposition = spawner.script_startingposition;
  if(isDefined(spawner.script_noteworthy))
    drone.script_noteworthy = spawner.script_noteworthy;
  if(isDefined(spawner.script_deleteai))
    drone.script_deleteai = spawner.script_deleteai;
  if(isDefined(spawner.script_linkto))
    drone.script_linkto = spawner.script_linkto;
  if(isDefined(spawner.script_moveoverride))
    drone.script_moveoverride = spawner.script_moveoverride;
  if(issubstr(spawner.classname, "ally"))
    drone.team = "allies";
  else if(issubstr(spawner.classname, "enemy"))
    drone.team = "axis";
  else
    drone.team = "neutral";
  if(isDefined(spawner.target))
    drone.target = spawner.target;
  drone.spawner = spawner;
  assert(isDefined(drone));
  if(isDefined(spawner.script_noteworthy) && spawner.script_noteworthy == "drone_delete_on_unload")
    drone.drone_delete_on_unload = true;
  else
    drone.drone_delete_on_unload = false;
  spawner notify("drone_spawned", drone);
  return drone;
}

spawner_makerealai(drone) {
  if(!isDefined(drone.spawner)) {
    println("----failed dronespawned guy info----");
    println("drone.classname: " + drone.classname);
    println("drone.origin : " + drone.origin);
    assertmsg("makerealai called on drone does with no .spawner");
  }
  orgorg = drone.spawner.origin;
  organg = drone.spawner.angles;
  drone.spawner.origin = drone.origin;
  drone.spawner.angles = drone.angles;
  guy = drone.spawner stalingradspawn();
  failed = spawn_failed(guy);
  if(failed) {
    println("----failed dronespawned guy info----");
    println("failed guys spawn position : " + drone.origin);
    println("failed guys spawner export key: " + drone.spawner.export);
    println("getaiarray size is: " + getaiarray().size);
    println("------------------------------------");
    assertMSG("failed to make real ai out of drone (see console for more info)");
  }
  drone.spawner.origin = orgorg;
  drone.spawner.angles = organg;
  drone Delete();
  return guy;
}

hiding_door_spawner() {
  door_orgs = getEntArray("hiding_door_guy_org", "targetname");
  assertex(door_orgs.size, "Hiding door guy with export " + self.export+" couldn't find a hiding_door_org!");
  door_org = getclosest(self.origin, door_orgs);
  assertex(distance(door_org.origin, self.origin) < 256, "Hiding door guy with export " + self.export+" was not placed within 256 units of a hiding_door_org");
  door_org.targetname = undefined;
  door_model = getent(door_org.target, "targetname");
  door_clip = getent(door_model.target, "targetname");
  assert(isDefined(door_model.target));
  pushPlayerClip = undefined;
  if(isDefined(door_clip.target))
    pushPlayerClip = getent(door_clip.target, "targetname");
  if(isDefined(pushPlayerClip))
    door_org thread hiding_door_guy_pushplayer(pushPlayerClip);
  door_model delete();
  door = spawn_anim_model("hiding_door");
  door_org thread anim_first_frame_solo(door, "fire_3");
  if(isDefined(door_clip)) {
    door_clip linkto(door, "door_hinge_jnt");
    door_clip disconnectPaths();
  }
  trigger = undefined;
  if(isDefined(self.target)) {
    trigger = getent(self.target, "targetname");
    if(!issubstr(trigger.classname, "trigger"))
      trigger = undefined;
  }
  if(!isDefined(self.script_flag_wait) && !isDefined(trigger)) {
    radius = 200;
    if(isDefined(self.radius))
      radius = self.radius;
    trigger = spawn("trigger_radius", door_org.origin, 0, radius, 48);
  }
  self add_spawn_function(::hiding_door_guy, door_org, trigger, door, door_clip);
  self waittill("spawned");
}

hiding_door_guy(door_org, trigger, door, door_clip) {
  starts_open = hiding_door_starts_open(door_org);
  self.animname = "hiding_door_guy";
  self endon("death");
  self.grenadeammo = 2;
  self set_deathanim("death_2");
  self.allowdeath = true;
  self.health = 50000;
  guy_and_door = [];
  guy_and_door[guy_and_door.size] = door;
  guy_and_door[guy_and_door.size] = self;
  thread hiding_door_guy_cleanup(door_org, self, door, door_clip);
  thread hiding_door_death(door, door_org, self, door_clip);
  if(starts_open) {
    door_org thread anim_loop(guy_and_door, "idle");
  } else {
    door_org thread anim_first_frame(guy_and_door, "fire_3");
  }
  if(isDefined(trigger)) {
    trigger waittill("trigger");
  } else {
    flag_wait(self.script_flag_wait);
  }
  if(starts_open) {
    door_org notify("stop_loop");
    door_org anim_single(guy_and_door, "close");
  }
  for(;;) {
    scene = "fire_3";
    if(randomint(100) < 25 * self.grenadeammo) {
      self.grenadeammo--;
      scene = "grenade";
    }
    door_org thread anim_single(guy_and_door, scene);
    delaythread(0.05, ::anim_set_time, guy_and_door, scene, 0.4);
    door_org waittill(scene);
    door_org thread anim_loop(guy_and_door, "idle");
    wait(randomfloat(0.25, 1.5));
    door_org notify("stop_loop");
  }
}

hiding_door_guy_cleanup(door_org, guy, door, door_clip) {
  guy waittill("death");
  door_org notify("stop_loop");
  thread hiding_door_death_door_connections(door_clip);
  door_org notify("push_player");
  door_org thread anim_single_solo(door, "death_2");
}

hiding_door_guy_pushplayer(pushPlayerClip) {
  self waittill("push_player");
  pushPlayerClip moveto(self.origin, 1.5);
  wait 3.0;
  pushPlayerClip delete();
}

hiding_door_guy_grenade_throw(guy) {
  startOrigin = guy getTagOrigin("J_Wrist_RI");
  player = get_closest_player(guy.origin);
  strength = (distance(player.origin, guy.origin) * 2.0);
  if(strength < 300)
    strength = 300;
  if(strength > 1000)
    strength = 1000;
  vector = vectorNormalize(player.origin - guy.origin);
  velocity = vectorScale(vector, strength);
  guy magicGrenadeManual(startOrigin, velocity, randomfloatrange(3.0, 5.0));
}

hiding_door_death(door, door_org, guy, door_clip) {
  guy waittill("damage");
  if(!isalive(guy))
    return;
  guys = [];
  guys[guys.size] = door;
  guys[guys.size] = guy;
  thread hiding_door_death_door_connections(door_clip);
  door_org notify("push_player");
  door_org thread anim_single(guys, "death_2");
  wait(0.5);
  if(isalive(guy)) {
    guy dodamage(guy.health + 150, (0, 0, 0));
  }
}

hiding_door_death_door_connections(door_clip) {
  if(!isDefined(door_clip)) {
    return;
  }
  door_clip connectpaths();
  wait 2;
  door_clip disconnectpaths();
}

hiding_door_starts_open(door_org) {
  return isDefined(door_org.script_noteworthy);
}