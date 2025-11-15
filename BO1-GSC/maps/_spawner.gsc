/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_spawner.gsc
**************************************/

#include maps\_utility;
#include maps\_anim;
#include maps\_serverfaceanim;
#include common_scripts\utility;

main() {
  CreateThreatBiasGroup("allies");
  CreateThreatBiasGroup("axis");
  if(level.script != "frontend" && !isDefined(level.zombietron_mode))
    precachemodel("grenade_bag");
  level._nextcoverprint = 0;
  level._ai_group = [];
  level.killedaxis = 0;
  level.ffpoints = 0;
  level.missionfailed = false;
  level.gather_delay = [];
  level.smoke_thrown = [];
  level.deathflags = [];
  level.spawner_number = 0;
  level.go_to_node_arrays = [];
  level.next_health_drop_time = 0;
  level.guys_to_die_before_next_health_drop = RandomIntRange(1, 4);
  level.default_goalradius = 2048;
  level.default_goalheight = 80;
  level.portable_mg_gun_tag = "J_Shoulder_RI";
  level.mg42_hide_distance = 1024;
  if(!isDefined(level.maxFriendlies)) {
    level.maxFriendlies = 11;
  }
  ai = GetAISpeciesArray("all");
  array_thread(ai, ::living_ai_prethink);
  level.ai_classname_in_level = [];
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    spawners[i].is_spawner = true;
    spawners[i] thread spawn_prethink();
  }
  thread process_deathflags();
  array_thread(ai, ::spawn_think);
  precache_player_weapon_drops(array("rpg", "panzerschreck"));
  if(isDefined(level.hiding_door_spawner)) {
    run_thread_on_noteworthy("hiding_door_spawner", level.hiding_door_spawner);
  }
  level thread trigger_spawner_monitor();
}

precache_player_weapon_drops(weapon_names) {
  level.ai_classname_in_level_keys = getarraykeys(level.ai_classname_in_level);
  for(i = 0; i < level.ai_classname_in_level_keys.size; i++) {
    if(weapon_names.size <= 0) {
      break;
    }
    for(j = 0; j < weapon_names.size; j++) {
      weaponName = weapon_names[j];
      if(!issubstr(tolower(level.ai_classname_in_level_keys[i]), weaponName)) {
        continue;
      }
      precacheItem(weaponName + "_player_sp");
      weapon_names = array_remove(weapon_names, weaponName);
      break;
    }
  }
  level.ai_classname_in_level_keys = undefined;
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
  assert(trigger has_spawnflag(level.SPAWNFLAG_TRIGGER_AI_AXIS) ||
    trigger has_spawnflag(level.SPAWNFLAG_TRIGGER_AI_ALLIES) ||
    trigger has_spawnflag(level.SPAWNFLAG_TRIGGER_AI_NEUTRAL),
    "trigger_outdoor at " + trigger.origin + " is not set up to trigger AI! Check one of the AI checkboxes on the trigger.");
  trigger endon("death");
  for(;;) {
    trigger waittill("trigger", guy);
    if(!IsAI(guy)) {
      continue;
    }
    guy thread ignore_triggers(0.15);
    guy disable_cqbwalk();
    guy.wantShotgun = false;
  }
}

indoor_think(trigger) {
  assert(trigger has_spawnflag(level.SPAWNFLAG_TRIGGER_AI_AXIS) ||
    trigger has_spawnflag(level.SPAWNFLAG_TRIGGER_AI_ALLIES) ||
    trigger has_spawnflag(level.SPAWNFLAG_TRIGGER_AI_NEUTRAL),
    "trigger_indoor at " + trigger.origin + " is not set up to trigger AI! Check one of the AI checkboxes on the trigger.");
  trigger endon("death");
  for(;;) {
    trigger waittill("trigger", guy);
    if(!IsAI(guy)) {
      continue;
    }
    guy thread ignore_triggers(0.15);
    guy enable_cqbwalk();
    guy.wantShotgun = true;
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
    } else if(trigger has_spawnflag(level.SPAWNFLAG_TRIGGER_SPAWN)) {
      if(isDefined(trigger.script_choke) && trigger.script_choke) {
        choked = true;
      }
    }
  }
  if(isDefined(self.targetname) && (self.targetname == "drone_axis" || self.targetname == "drone_allies")) {
    choked = true;
  }
  if(isDefined(level._forcechoke) && level._numTriggerSpawned > 2) {
    return false;
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
  }
  array_thread(spawners, ::trigger_spawner_spawns_guys);
}

trigger_spawner_spawns_guys() {
  self endon("death");
  if(IsSubStr(self.classname, "actor")) {
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
    }
    self spawn_ai();
    level._numTriggerSpawned++;
  }
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

kill_trigger(trigger) {
  if(!isDefined(trigger)) {
    return;
  }
  if((isDefined(trigger.targetname)) && (trigger.targetname != "flood_spawner")) {
    return;
  }
  trigger Delete();
}

kill_spawner_trigger(trigger) {
  trigger waittill("trigger");
  kill_spawnernum(trigger.script_killspawner);
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
  level.nextGrenadeDrop = 2 + randomInt(2);
  max = 25;
  min = 12;
  spawn_grenade_bag(self.origin + (randomInt(max) - min, randomInt(max) - min, 2) + (0, 0, 42), (0, randomInt(360), 0), self.team);
}

random_tire(start, end) {
  model = spawn("script_model", (0, 0, 0));
  model.angles = (0, randomInt(360), 0);
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
  count = self.grenadeammo;
  grenade = spawn("weapon_" + self.grenadeWeapon, origin);
  level.grenade_cache[team][index] = grenade;
  level.grenade_cache_index[team] = (index + 1) % 16;
  grenade.angles = angles;
  grenade.count = count;
  grenade setModel("grenade_bag");
}

dronespawn_setstruct(spawner) {
  if(dronespawn_check()) {
    return;
  }
  guy = spawner stalingradspawn();
  if(isDefined(guy)) {
    spawner.count++;
    dronespawn_setstruct_from_guy(guy);
    guy delete();
  }
}

dronespawn_check() {
  if(isDefined(level.dronestruct[self.classname])) {
    return true;
  }
  return false;
}

dronespawn_setstruct_from_guy(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(dronespawn_check()) {
    return;
  }
  struct = spawnStruct();
  size = guy getattachsize();
  struct.attachedmodels = [];
  for(i = 0; i < size; i++) {
    struct.attachedmodels[i] = guy GetAttachModelName(i);
    struct.attachedtags[i] = guy GetAttachTagName(i);
  }
  struct.model = guy.model;
  struct.weapon = guy.weapon;
  level.dronestruct[guy.classname] = struct;
}

empty() {}
spawn_prethink() {
  assert(self != level);
  level.ai_classname_in_level[self.classname] = true;
  prof_begin("spawn_prethink");
  if(isDefined(self.script_drone)) {
    self thread dronespawn_setstruct(self);
  }
  if(isDefined(self.script_aigroup)) {
    aigroup = self.script_aigroup;
    aigroup_init(aigroup, self);
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
  deathflag_func = ::empty;
  if(isDefined(self.script_deathflag)) {
    deathflag_func = ::deathflag_check_count;
    thread spawner_deathflag();
  }
  if(isDefined(self.target)) {
    crawl_through_targets_to_init_flags();
  }
  for(;;) {
    prof_begin("spawn_prethink");
    self waittill("spawned", spawn);
    [[deathflag_func]]();
    if(!IsAlive(spawn)) {
      continue;
    }
    if(isDefined(self.script_delete)) {
      for(i = 0; i < level._ai_delete[self.script_delete].size; i++) {
        if(level._ai_delete[self.script_delete][i] != self) {
          level._ai_delete[self.script_delete][i] Delete();
        }
      }
    }
    spawn.spawn_funcs = self.spawn_funcs;
    spawn thread spawn_think(self);
  }
}

spawn_think(spawner) {
  assert(self != level);
  level.ai_classname_in_level[self.classname] = true;
  if(isDefined(spawner)) {
    spawn_think_action(spawner.targetname);
  } else {
    spawn_think_action();
  }
  assert(IsAlive(self));
  self endon("death");
  if(getDvar(#"zombiemode") != "1" && !isDefined(self.name) && (self.type != "dog")) {
    self waittill("set name and rank");
  }
  self.finished_spawning = true;
  self notify("finished spawning");
  self thread run_spawn_functions(spawner);
  assert(isDefined(self.team));
}

run_spawn_functions(spawner) {
  self endon("death");
  waittillframeend;
  if(isDefined(spawner) && isDefined(level.spawnerCallbackThread)) {
    spawner thread[[level.spawnerCallbackThread]](self);
  }
  for(i = 0; i < level.spawn_funcs[self.team].size; i++) {
    func = level.spawn_funcs[self.team][i];
    single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"]);
  }
  self thread maps\_audio::missile_audio_watcher();
  if(!isDefined(self.spawn_funcs)) {
    return;
  }
  for(i = 0; i < self.spawn_funcs.size; i++) {
    func = self.spawn_funcs[i];
    single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"]);
  }
  self.spawn_funcs = undefined;
  self.spawn_funcs = undefined;
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

spawn_think_action(spawner_targetname) {
  if(getDvar(#"zombiemode") == "0") {
    self thread maps\_serverfaceanim::init_serverfaceanim();
  }
  if(isDefined(spawner_targetname) && !isDefined(self.targetname)) {
    self.targetname = spawner_targetname + "_ai";
  }
  self thread maps\_utility::ent_flag_init_ai_standards();
  self thread tanksquish();
  self.spawner_number = undefined;
  if(!isDefined(self.ai_number)) {
    set_ai_number();
  }
  if(isDefined(self.script_dontshootwhilemoving)) {
    self.dontshootwhilemoving = true;
  }
  if(isDefined(self.script_deathflag)) {
    thread ai_deathflag();
  }
  if(isDefined(self.script_animname)) {
    self.animname = self.script_animname;
  }
  if(isDefined(self.script_forceColor)) {
    set_force_color(self.script_forceColor);
    if((!isDefined(self.script_no_respawn) || self.script_no_respawn < 1) && !isDefined(level.no_color_respawners_sm)) {
      self thread replace_on_death();
    }
  }
  if(isDefined(self.script_fixednode)) {
    self.fixednode = (self.script_fixednode == 1);
  } else {
    self.fixednode = self.team == "allies";
  }
  set_default_covering_fire();
  if((isDefined(self.script_moveoverride)) && (self.script_moveoverride == 1)) {
    override = true;
  } else {
    override = false;
  }
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mgpair") {
    thread maps\_mg_penetration::create_mg_team();
  }
  if(getDvar(#"zombiemode") == "0") {
    level thread maps\_friendlyfire::friendly_fire_think(self);
  }
  if(isDefined(self.script_threatbiasgroup)) {
    self SetThreatBiasGroup(self.script_threatbiasgroup);
  } else if(self.team == "allies") {
    self SetThreatBiasGroup("allies");
  } else {
    self SetThreatBiasGroup("axis");
  }
  set_default_pathenemy_settings();
  self.heavy_machine_gunner = IsSubStr(self.classname, "mgportable");
  maps\_gameskill::grenadeAwareness();
  self.walkdist = 16;
  if(isDefined(self.script_ignoreme)) {
    assertEx(self.script_ignoreme == true, "Tried to set self.script_ignoreme to false, not allowed. Just set it to undefined.");
    self.ignoreme = true;
  }
  if(isDefined(self.script_ignore_suppression)) {
    assertEx(self.script_ignore_suppression == true, "Tried to set self.script_ignore_suppresion to false, not allowed. Just set it to undefined.");
    self.ignoreSuppression = true;
  }
  if(isDefined(self.script_hero)) {
    AssertEx(self.team == "allies", "Only use script_hero kvp on friendly AI, else use magic_bullet_shield directly.");
    AssertEx(self.script_hero == 1, "Tried to set script_hero to something other than 1");
    self make_hero();
  }
  if(isDefined(self.script_ignoreall)) {
    assertEx(self.script_ignoreall == true, "Tried to set self.script_ignoreme to false, not allowed. Just set it to undefined.");
    self.ignoreall = true;
    self clearenemy();
  }
  if(getDvar(#"zombiemode") != "1" && isDefined(self.script_disable_bleeder)) {
    assertEx(self.script_disable_bleeder == true, "self.script_disable_bleeder can only be set to true. To set to true, leave it undefined.");
    self disable_ai_bleeder();
  }
  if(getDvar(#"zombiemode") != "1" && isDefined(self.script_disable_reviver)) {
    assertEx(self.script_disable_reviver == true, "self.script_disable_reviver can only be set to true. To set to true, leave it undefined.");
    self disable_ai_reviver();
  }
  if(isDefined(self.script_disablereact)) {
    self disable_react();
  }
  if(isDefined(self.script_disablepain)) {
    self disable_pain();
  }
  if(isDefined(self.script_disableturns)) {
    self.disableTurns = true;
  }
  if(isDefined(self.script_sightrange)) {
    self.maxSightDistSqrd = self.script_sightrange;
  } else if(WeaponClass(self.weapon) == "gas") {
    self.maxSightDistSqrd = 1024 * 1024;
  }
  if(self.team != "axis") {
    if(isDefined(self.script_followmin)) {
      self.followmin = self.script_followmin;
    }
    if(isDefined(self.script_followmax)) {
      self.followmax = self.script_followmax;
    }
  }
  if(self.team == "axis") {
    if(self.type == "human") {
      self thread drop_gear();
    }
    self thread maps\_gameskill::auto_adjust_enemy_death_detection();
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
  if(isDefined(self.script_forcegib)) {
    self.force_gib = 1;
    if(call_overloaded_func("animscripts\death", "isValidGibRef", self.script_forcegib)) {
      self.custom_gib_refs[0] = self.script_forcegib;
    }
  }
  if(isDefined(self.script_stealth)) {
    self thread call_overloaded_func("maps\_stealth_logic", "stealth_ai");
  }
  if(isDefined(self.script_patroller)) {
    self thread maps\_patrol::patrol();
    return;
  } else if(isDefined(self.script_contextual_melee)) {
    self contextual_melee(self.script_contextual_melee);
  }
  if(isDefined(self.script_spiderhole)) {
    self thread maps\_spiderhole::spiderhole();
    return;
  }
  if(is_true(self.script_rusher)) {
    self call_overloaded_func("maps\_rusher", "rush");
    return;
  }
  if(isDefined(self.script_enable_cqbwalk)) {
    self maps\_utility::enable_cqbwalk();
  }
  if(isDefined(self.script_enable_heat)) {
    self maps\_utility::enable_heat();
  }
  if(isDefined(self.script_disable_idle_strafe) && self.script_disable_idle_strafe) {
    self.disableIdleStrafing = true;
  }
  if(isDefined(self.script_playerseek)) {
    if(self.script_playerseek == 1) {
      self thread player_seek();
      return;
    } else {
      self thread player_seek(self.script_playerseek);
    }
  }
  if(isDefined(self.script_banzai)) {
    self thread maps\_banzai::spawned_banzai_dynamic();
  } else if(isDefined(self.script_banzai_spawn)) {
    self thread maps\_banzai::spawned_banzai_immediate();
  }
  if(self.heavy_machine_gunner) {
    thread maps\_mgturret::portable_mg_behavior();
  }
  if(isDefined(self.used_an_mg42)) {
    return;
  }
  assertEx((self.goalradius == 8 || self.goalradius == 4), "Changed the goalradius on guy without waiting for spawn_failed. Note that this change will NOT show up by putting a breakpoint on the actors goalradius field because breakpoints don't properly handle the first frame an actor exists.");
  if(override) {
    self thread set_goalradius_based_on_settings();
    self SetGoalPos(self.origin);
    return;
  }
  if(isDefined(self.target)) {
    self thread go_to_node();
  } else {
    self thread set_goalradius_based_on_settings();
    if(isDefined(self.script_spawner_targets)) {
      self thread go_to_spawner_target(StrTok(self.script_spawner_targets, " "));
    }
  }
  if(isDefined(self.script_goalvolume)) {
    thread set_goal_volume();
  }
  if(isDefined(self.script_turnrate)) {
    self.turnrate = self.script_turnrate;
  }
  self maps\_dds::dds_ai_init();
}

set_default_covering_fire() {
  self.provideCoveringFire = self.team == "allies" && self.fixedNode;
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
  self endon("death");
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

spawner_targets_init() {
  allnodes = GetAllNodes();
  level.script_spawner_targets_nodes = [];
  for(i = 0; i < allnodes.size; i++) {
    if(isDefined(allnodes[i].script_spawner_targets)) {
      level.script_spawner_targets_nodes[level.script_spawner_targets_nodes.size] = allnodes[i];
    }
  }
}

go_to_spawner_target(target_names) {
  self endon("death");
  self notify("go_to_spawner_target");
  self endon("go_to_spawner_target");
  nodes = [];
  occupied_nodes = [];
  nodesPresent = false;
  for(i = 0; i < target_names.size; i++) {
    target_nodes = get_spawner_target_nodes(target_names[i]);
    if(target_nodes.size > 0) {
      nodesPresent = true;
    }
    for(i = 0; i < target_nodes.size; i++) {
      if(IsNodeOccupied(target_nodes[i]) || is_true(target_nodes[i].node_claimed)) {
        occupied_nodes = array_add(occupied_nodes, target_nodes[i]);
      } else {
        nodes = array_add(nodes, target_nodes[i]);
      }
    }
  }
  if(nodes.size == 0) {
    while(nodes.size == 0) {
      for(i = 0; i < occupied_nodes.size; i++) {
        if(!IsNodeOccupied(occupied_nodes[i]) && !is_true(occupied_nodes[i].node_claimed)) {
          nodes = array_add(nodes, occupied_nodes[i]);
          break;
        }
      }
      wait(0.1);
    }
  }
  AssertEx(nodesPresent, "No spawner target nodes for AI.");
  goal = undefined;
  if(nodes.size > 0) {
    goal = random(nodes);
  }
  if(isDefined(goal)) {
    if(isDefined(self.script_radius)) {
      self.goalradius = self.script_radius;
    } else {
      self.goalradius = 400;
    }
    goal.node_claimed = true;
    self SetGoalNode(goal);
    self thread release_spawner_target_node(goal);
    self waittill("goal");
  }
  self set_goalradius_based_on_settings(goal);
}

release_spawner_target_node(node) {
  self waittill_any("death", "goal_changed");
  node.node_claimed = undefined;
}

get_spawner_target_nodes(group) {
  if(group == "") {
    return [];
  }
  nodes = [];
  for(i = 0; i < level.script_spawner_targets_nodes.size; i++) {
    groups = strtok(level.script_spawner_targets_nodes[i].script_spawner_targets, " ");
    for(j = 0; j < groups.size; j++) {
      if(groups[j] == group) {
        nodes[nodes.size] = level.script_spawner_targets_nodes[i];
      }
    }
  }
  return nodes;
}

empty_arrived_func(node) {}
get_least_used_from_array(array) {
  assertex(array.size > 0, "Somehow array had zero entrees");
  if(array.size == 1) {
    return array[0];
  }
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

go_to_node_using_funcs(node, get_target_func, set_goal_func_quits, optional_arrived_at_node_func, require_player_dist) {
  self endon("stop_going_to_node");
  self endon("death");
  for(;;) {
    node = get_least_used_from_array(node);
    player_wait_dist = require_player_dist;
    if(isDefined(node.script_requires_player)) {
      if(node.script_requires_player > 1)
        player_wait_dist = node.script_requires_player;
      else
        player_wait_dist = 256;
      node.script_requires_player = false;
    }
    self set_goalradius_based_on_settings(node);
    if(isDefined(node.height)) {
      self.goalheight = node.height;
    } else {
      self.goalheight = level.default_goalheight;
    }
    [[set_goal_func_quits]](node);
    self waittill("goal");
    [[optional_arrived_at_node_func]](node);
    if(isDefined(node.script_flag_set)) {
      flag_set(node.script_flag_set);
    }
    if(isDefined(node.script_flag_clear)) {
      flag_set(node.script_flag_clear);
    }
    if(isDefined(node.script_ent_flag_set)) {
      if(!self flag_exists(node.script_ent_flag_set))
        AssertEx("Tried to set a ent flag" + node.script_ent_flag_set + "on a node, but it doesnt exist.");
      self ent_flag_set(node.script_ent_flag_set);
    }
    if(isDefined(node.script_ent_flag_clear)) {
      if(!self flag_exists(node.script_ent_flag_clear))
        AssertEx("Tried to clear a ent flag" + node.script_ent_flag_clear + "on a node, but it doesnt exist.");
      self ent_flag_clear(node.script_ent_flag_clear);
    }
    if(targets_and_uses_turret(node)) {
      return true;
    }
    if(isDefined(node.script_enable_cqbwalk)) {
      self enable_cqbwalk();
    }
    if(isDefined(node.script_disable_cqbwalk)) {
      self disable_cqbwalk();
    }
    if(isDefined(node.script_enable_heat)) {
      self enable_heat();
    }
    if(isDefined(node.script_disable_heat)) {
      self disable_heat();
    }
    if(isDefined(node.script_sprint)) {
      if(node.script_sprint) {
        self.sprint = true;
      } else {
        self.sprint = false;
      }
    }
    if(isDefined(node.script_walk)) {
      if(node.script_walk) {
        self.walk = true;
      } else {
        self.walk = false;
      }
    }
    if(isDefined(node.script_flag_wait)) {
      flag_wait(node.script_flag_wait);
    }
    while(isDefined(node.script_requires_player)) {
      node.script_requires_player = false;
      if(self go_to_node_wait_for_player(node, get_target_func, player_wait_dist)) {
        node.script_requires_player = true;
        node notify("script_requires_player");
        break;
      }
      wait 0.1;
    }
    if(isDefined(node.script_aigroup)) {
      waittill_ai_group_cleared(node.script_aigroup);
    }
    node script_delay();
    if(!isDefined(node.target)) {
      break;
    }
    nextNode_array = [[get_target_func]](node.target);
    if(!nextNode_array.size) {
      break;
    }
    node = nextNode_array;
  }
  if(isDefined(self.arrived_at_end_node_func))
    [[self.arrived_at_end_node_func]](node);
  self notify("reached_path_end");
  if(isDefined(self.delete_on_path_end))
    self Delete();
  self set_goalradius_based_on_settings(node);
}

go_to_node_wait_for_player(node, get_target_func, dist) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(distancesquared(player.origin, node.origin) < distancesquared(self.origin, node.origin))
      return true;
  }
  vec = anglesToForward(self.angles);
  if(isDefined(node.target)) {
    temp = [[get_target_func]](node.target);
    if(temp.size == 1)
      vec = vectornormalize(temp[0].origin - node.origin);
    else if(isDefined(node.angles))
      vec = anglesToForward(node.angles);
  } else if(isDefined(node.angles))
    vec = anglesToForward(node.angles);
  vec2 = [];
  for(i = 0; i < players.size; i++) {
    player = players[i];
    vec2[vec2.size] = vectornormalize((player.origin - self.origin));
  }
  for(i = 0; i < vec2.size; i++) {
    value = vec2[i];
    if(vectordot(vec, value) > 0)
      return true;
  }
  dist2rd = dist * dist;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(distancesquared(player.origin, self.origin) < dist2rd)
      return true;
  }
  return false;
}

go_to_node_set_goal_pos(ent) {
  self set_goal_pos(ent.origin);
}

go_to_node_set_goal_node(node) {
  self set_goal_node(node);
}

targets_and_uses_turret(node) {
  if(!isDefined(node.target)) {
    return false;
  }
  turrets = getEntArray(node.target, "targetname");
  if(!turrets.size) {
    return false;
  }
  turret = turrets[0];
  if(turret.classname != "misc_turret") {
    return false;
  }
  thread use_a_turret(turret);
  return true;
}

remove_crawled(ent) {
  waittillframeend;
  if(isDefined(ent)) {
    ent.crawled = undefined;
  }
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
  if(!isDefined(goal_type)) {
    goal_type = "node";
  }
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
  self endon("death");
  waittillframeend;
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
  } else if(isDefined(self.script_banzai_spawn)) {
    self.goalradius = 64;
  } else if(isDefined(node) && node_has_radius(node)) {
    self.goalradius = node.radius;
  } else {
    self.goalradius = level.default_goalradius;
  }
  if(is_true(self.script_forcegoal)) {
    self thread force_goal();
  }
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
      if(getDvar(#"fallback") == "1") {
        println("^a First spawned: ", num);
      }
      level notify(("fallback_firstspawn" + num));
      firstspawn = false;
    }
    maps\_spawner::waitframe();
    if(spawn_failed(spawn)) {
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
    node = node_array[randomInt(node_array.size)];
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
  if(getDvar(#"fallback") == "1") {
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
      fallback_nodes = add_to_array(fallback_nodes, nodes[i]);
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
  if(getDvar(#"fallback") == "1") {
    println("^a fallback trigger hit: ", num);
  }
  level.fallback_initiated[num] = true;
  fallback_ai = undefined;
  ai = GetAiArray();
  for(i = 0; i < ai.size; i++) {
    if(((isDefined(ai[i].script_fallback)) && (ai[i].script_fallback == num)) || ((isDefined(ai[i].script_fallback_group)) && (isDefined(group)) && (ai[i].script_fallback_group == group))) {
      fallback_ai = add_to_array(fallback_ai, ai[i]);
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
    level._nextcoverprint = GetTime() + 2500 + randomInt(2000);
    return;
  }
}

fallback_wait(num, group, ignoreWhileFallingBack, percent) {
  level endon(("fallbacker_trigger" + num));
  if(getDvar(#"fallback") == "1") {
    println("^a Fallback wait: ", num);
  }
  for(i = 0; i < level.spawner_fallbackers[num]; i++) {
    if(getDvar(#"fallback") == "1") {
      println("^a Waiting for spawners to be hit: ", num, " i: ", i);
    }
    level waittill(("fallback_firstspawn" + num));
  }
  if(getDvar(#"fallback") == "1") {
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
    if(getDvar(#"fallback") == "1") {
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

delete_me() {
  maps\_spawner::waitframe();
  self Delete();
}

waitframe() {
  wait(0.05);
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
    stoptrigger = getEnt(mg42.target, "targetname");
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
    if(!isDefined(mod)) {
      continue;
    }
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
    force = vector_scale(force, 50000);
    force = (force[0], force[1], abs(force[2]));
    if(isDefined(level._effect) && isDefined(level._effect["tanksquish"])) {
      playFX(level._effect["tanksquish"], self.origin + (0, 0, 30));
    }
    self startRagdoll();
    self playSound("chr_crunch");
    return;
  }
}

spawnWaypointFriendlies() {
  self.count = 1;
  spawn = self spawn_ai();
  if(spawn_failed(spawn)) {
    return;
  }
  spawn.friendlyWaypoint = true;
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

aigroup_init(aigroup, spawner) {
  if(!isDefined(level._ai_group[aigroup])) {
    level._ai_group[aigroup] = spawnStruct();
    level._ai_group[aigroup].aigroup = aigroup;
    level._ai_group[aigroup].aicount = 0;
    level._ai_group[aigroup].spawnercount = 0;
    level._ai_group[aigroup].killed_count = 0;
    level._ai_group[aigroup].ai = [];
    level._ai_group[aigroup].spawners = [];
    level._ai_group[aigroup].cleared_count = 0;
    if(!isDefined(level.flag[aigroup + "_cleared"])) {
      flag_init(aigroup + "_cleared");
    }
    level thread set_ai_group_cleared_flag(level._ai_group[aigroup]);
  }
  if(isDefined(spawner)) {
    spawner thread aigroup_spawnerthink(level._ai_group[aigroup]);
  }
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
    soldier.aigroup = tracker.aigroup;
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
  tracker.killed_count++;
}

set_ai_group_cleared_flag(tracker) {
  waittillframeend;
  while(true) {
    if((tracker.aicount + tracker.spawnercount) <= tracker.cleared_count) {
      flag_set(tracker.aigroup + "_cleared");
      break;
    }
    wait .05;
  }
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
  assertex(self has_spawnflag(level.SPAWNFLAG_ACTOR_SPAWNER), "Spawner at origin" + self.origin + "/" + (self GetOrigin()) + " is not a spawner!");
}

trigger_requires_player(trigger) {
  if(!isDefined(trigger)) {
    return false;
  }
  return isDefined(trigger.script_requires_player);
}

flood_spawner_think(trigger) {
  self endon("death");
  self notify("stop current floodspawner");
  self endon("stop current floodspawner");
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
    soldier = self spawn_ai();
    if(spawn_failed(soldier)) {
      wait(2);
      continue;
    }
    level._numTriggerSpawned++;
    soldier thread reincrement_count_if_deleted(self);
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
  if(isDefined(self.script_force_count)) {
    if(self.script_force_count) {
      return true;
    }
  }
  if(!isDefined(guy)) {
    return false;
  }
  if(IsAlive(attacker)) {
    if(IsPlayer(attacker)) {
      return true;
    }
    players = get_players();
    for(q = 0; q < players.size; q++) {
      if(distanceSquared(attacker.origin, players[q].origin) < 200 * 200) {
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

show_bad_path() {}
objective_event_init(trigger) {
  flag = trigger get_trigger_flag();
  assertex(isDefined(flag), "Objective event at origin " + trigger.origin + " does not have a script_flag. ");
  flag_init(flag);
  assertex(isDefined(level.deathSpawner[trigger.script_deathChain]), "The objective event trigger for deathchain " + trigger.script_deathchain + " is not associated with any AI.");
  while(level.deathSpawner[trigger.script_deathChain] > 0) {
    level waittill("spawner_expired" + trigger.script_deathChain);
  }
  flag_set(flag);
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
  for(i = 0; i < attachedmodels.size; i++) {
    drone attach(attachedmodels[i], attachedtags[i], true);
  }
  if(isDefined(struct.weapon)) {
    drone.weapon = struct.weapon;
    self call_overloaded_func("animscripts\init", "initWeapon", drone.weapon);
    drone useweaponhidetags(drone.weapon);
  }
  if(isDefined(spawner.script_startingposition)) {
    drone.script_startingposition = spawner.script_startingposition;
  }
  if(isDefined(spawner.script_noteworthy)) {
    drone.script_noteworthy = spawner.script_noteworthy;
  }
  if(isDefined(spawner.script_deleteai)) {
    drone.script_deleteai = spawner.script_deleteai;
  }
  if(isDefined(spawner.script_linkto)) {
    drone.script_linkto = spawner.script_linkto;
  }
  if(isDefined(spawner.script_moveoverride)) {
    drone.script_moveoverride = spawner.script_moveoverride;
  }
  if(issubstr(spawner.classname, "ally")) {
    drone.team = "allies";
  } else if(issubstr(spawner.classname, "enemy")) {
    drone.team = "axis";
  } else {
    drone.team = "neutral";
  }
  if(isDefined(spawner.target)) {
    drone.target = spawner.target;
  }
  drone.spawner = spawner;
  assert(isDefined(drone));
  if(isDefined(spawner.script_noteworthy) && spawner.script_noteworthy == "drone_delete_on_unload") {
    drone.drone_delete_on_unload = true;
  } else {
    drone.drone_delete_on_unload = false;
  }
  spawner notify("drone_spawned", drone);
  return drone;
}

spawner_make_real_ai(drone) {
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