/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\spawner.gsc
***********************************************/



#using script_78ee1f1787a2e6a4;
#using scripts\anim\init;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\sp\utility;
#using scripts\common\ai;
#using scripts\common\debug;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\ai_armor;
#using scripts\sp\analytics;
#using scripts\sp\anim;
#using scripts\sp\damagefeedback;
#using scripts\sp\debug;
#using scripts\sp\drone_base;
#using scripts\sp\fakeactor;
#using scripts\sp\flags;
#using scripts\sp\friendlyfire;
#using scripts\sp\gameskill;
#using scripts\sp\loot;
#using scripts\sp\mgturret;
#using scripts\sp\player;
#using scripts\sp\player_stats;
#using scripts\sp\spawner;
#using scripts\sp\stealth\idle_sitting;
#using scripts\sp\stealth\manager;
#using scripts\sp\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\enemy;
#namespace spawner;

function main() {
  level.spawn_funcs = [];
  level.spawn_funcs["allies"] = [];
  level.spawn_funcs["axis"] = [];
  level.spawn_funcs["team3"] = [];
  level.spawn_funcs["neutral"] = [];
  thread scripts\sp\spawner::goalvolumes();
  var_520231d77c80a465 = getEntArray("flood_and_secure", "targetname");
  array_thread(var_520231d77c80a465, &flood_and_secure);

  if(!isDefined(level.ai_number)) {
    level.ai_number = 0;
  }

  if(getDvar(@ "fallback") == "") {
    setDvar(@ "fallback", "0");
  }

  if(getDvar(@ "noai") == "") {
    setDvar(@ "noai", "off");
  }

  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("team3");
  createthreatbiasgroup("civilian");
  createthreatbiasgroup("equipment");
  setthreatbias("axis", "equipment", 250);
  setthreatbias("allies", "equipment", 250);
  setthreatbias("team3", "equipment", -1000);
  scripts\sp\flags::init_sp_flags();
  scripts\sp\player::init();
  scripts\sp\gameskill::init_gameskill();

  foreach(player in level.players) {
    player setthreatbiasgroup("allies");
  }

  setdvarifuninitialized(@ "hash_c3ae5b7542b15a78", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_38a088b03f78dca1", "<dev string:x1c>");

  level._ai_group = [];
  level.gather_delay = [];

  if(!isDefined(level.deathflags)) {
    level.deathflags = [];
  }

  level.spawner_number = 0;

  if(!isDefined(level.unittype_spawn_functions)) {
    level.unittype_spawn_functions = [];
  }

  level.unittype_spawn_functions["soldier"] = &spawn_unittype_soldier;

  if(!isDefined(level.subclass_spawn_functions)) {
    level.subclass_spawn_functions = [];
  }

  level.subclass_spawn_functions["juggernaut"] = &spawn_subclass_juggernaut;
  level.subclass_spawn_functions["tier2"] = &scripts\sp\ai_armor::function_1ddcdf764c5bdd84;
  level.subclass_spawn_functions["tier3"] = &scripts\sp\ai_armor::function_1ddcdf764c5bdd84;
  level.team_specific_spawn_functions = [];
  level.team_specific_spawn_functions["axis"] = &spawn_team_axis;
  level.team_specific_spawn_functions["allies"] = &spawn_team_allies;
  level.team_specific_spawn_functions["team3"] = &spawn_team_team3;
  level.team_specific_spawn_functions["neutral"] = &spawn_team_neutral;

  if(!isDefined(level.default_goalradius)) {
    level.default_goalradius = 2048;
  }

  if(!isDefined(level.default_goalheight)) {
    level.default_goalheight = 512;
  }

  level.portable_mg_gun_tag = "J_Shoulder_RI";
  level._max_script_health = 0;
  ai = getaispeciesarray();
  array_thread(ai, &living_ai_prethink);
  level.ai_classname_in_level = [];
  level.drone_paths = [];
  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    spawners[i] thread spawn_prethink();
  }

  level.drone_paths = undefined;
  hudoutline_add_child_channel("tracker", 1, "default");
  thread process_deathflags();
  array_thread(ai, &spawn_think);
  ai_classname_in_level_keys = getarraykeys(level.ai_classname_in_level);
  precache_rpg = 0;
  precache_armor = 0;

  for(i = 0; i < ai_classname_in_level_keys.size; i++) {
    classname = tolower(ai_classname_in_level_keys[i]);

    if(!precache_rpg && issubstr(classname, "rpg")) {
      precache_rpg = 1;
      rocketlauncher = "iw8_la_rpapa7";
      precacheitem(rocketlauncher);
      continue;
    }

    if(!precache_armor && issubstr(classname, "tier")) {
      precache_armor = 1;
      scripts\sp\ai_armor::precache();
    }

    if(precache_rpg && precache_armor) {
      break;
    }
  }

  aitype_check();
}

function aitype_check() {
  ents = getaispeciesarray();
  ents = array_combine(getspawnerarray(), ents);

  foreach(ent in ents) {
    if(issubstr(ent.classname, "<dev string:x1e>")) {
      assertmsg("<dev string:x2e>" + ent.classname + "<dev string:x50>" + ent.origin + "<dev string:x56>");
    }
  }
}

function process_deathflags() {
  foreach(deathflag, array in level.deathflags) {
    if(!isDefined(level.flag[deathflag])) {
      flag_init(deathflag);
    }
  }
}

function spawn_guys_until_death_or_no_count() {
  self endon("death");

  for(;;) {
    if(self.count > 0) {
      self waittill("spawned");
    }

    waittillframeend();

    if(!self.count) {
      return;
    }
  }
}

function vehicle_deathflag() {
  ai_number = self.unique_id;
  deathflag = self.script_deathflag;

  if(!isDefined(level.deathflags) || !isDefined(level.deathflags[self.script_deathflag])) {
    waittillframeend();

    if(!isDefined(self)) {
      return;
    }
  }

  level.deathflags[deathflag]["vehicles"][ai_number] = self;
  self waittill("death");
  level.deathflags[deathflag]["vehicles"][ai_number] = undefined;
  update_deathflag(deathflag);
}

function spawner_deathflag() {
  level.deathflags[self.script_deathflag] = [];
  waittillframeend();

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

function vehicle_spawner_deathflag() {
  level.deathflags[self.script_deathflag] = [];
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  self.spawner_number = level.spawner_number;
  level.spawner_number++;
  level.deathflags[self.script_deathflag]["vehicle_spawners"][self.spawner_number] = self;
  deathflag = self.script_deathflag;
  id = self.spawner_number;
  spawn_guys_until_death_or_no_count();
  level.deathflags[deathflag]["vehicle_spawners"][id] = undefined;
  update_deathflag(deathflag);
}

function update_deathflag(deathflag) {
  level notify("updating_deathflag_" + deathflag);
  level endon("updating_deathflag_" + deathflag);
  waittillframeend();

  foreach(array in level.deathflags[deathflag]) {
    if(getarraykeys(array).size > 0) {
      return;
    }
  }

  flag_set(deathflag);
}

function outdoor_think(trigger) {
  assert(trigger.spawnflags & 1 || trigger.spawnflags & 2 || trigger.spawnflags & 4, "trigger_outdoor at " + trigger.origin + " is not set up to trigger AI! Check one of the AI checkboxes on the trigger.");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", guy);

    if(!isai(guy)) {
      continue;
    }

    guy thread ignore_triggers(0.15);
    guy utility::disable_cqbwalk();
  }
}

function indoor_think(trigger) {
  assert(trigger.spawnflags & 1 || trigger.spawnflags & 2 || trigger.spawnflags & 4, "trigger_indoor at " + trigger.origin + " is not set up to trigger AI! Check one of the AI checkboxes on the trigger.");
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", guy);

    if(!isai(guy)) {
      continue;
    }

    guy thread ignore_triggers(0.15);
    guy utility::enable_cqbwalk();
  }
}

function trigger_spawner(trigger) {
  assertex(isDefined(trigger.target), "Triggers with flag TRIGGER_SPAWN at " + trigger.origin + " must target at least one spawner.");
  trigger waittill("trigger");
  target = trigger.target;
  trigger script_delay();
  spawners = array_combine(getspawnerarray(target), vehicle_getspawnerarray(target));

  foreach(spawner in spawners) {
    if(!isnonentspawner(spawner) && spawner.code_classname == "script_vehicle") {
      if(isDefined(spawner.script_moveoverride) && spawner.script_moveoverride == 1 || !isDefined(spawner.target)) {
        thread scripts\common\vehicle::vehicle_spawn(spawner);
      } else {
        spawner thread scripts\common\vehicle::spawn_vehicle_and_gopath();
      }

      continue;
    }

    spawner thread spawn_ai();
  }
}

function trigger_spawner_reinforcement(trigger) {
  assertex(isDefined(trigger.target), "Triggers with flag TRIGGER_SPAWN at " + trigger.origin + " must target or link to at least one spawner.");
  target = trigger.target;
  targetsreinforcement = 0;
  spawners = getspawnerarray(target);

  foreach(spawner in spawners) {
    if(!isDefined(spawner.target)) {
      continue;
    }

    reinforcement_spawner = getspawner(spawner.target, "targetname");

    if(!isDefined(reinforcement_spawner)) {
      if(!isDefined(spawner.script_linkto)) {
        continue;
      }

      reinforcement_spawner = getspawner(spawner.script_linkto, "script_linkname");

      if(!isDefined(reinforcement_spawner)) {
        reinforcement_spawner = spawner get_linked_ent();
      }

      if(!isDefined(reinforcement_spawner)) {
        continue;
      }

      if(!isspawner(reinforcement_spawner)) {
        continue;
      }
    }

    targetsreinforcement = 1;
    break;
  }

  assertex(targetsreinforcement == 1, "trigger_multiple_spawn_reinforcement trigger needs at least one AI to target a reinforcement spawner. You should just be using trigger_multiple_spawn in this case.");
  trigger waittill("trigger");
  trigger script_delay();
  spawners = getspawnerarray(target);

  foreach(spawner in spawners) {
    spawner thread trigger_reinforcement_spawn_guys();
  }
}

function trigger_reinforcement_spawn_guys() {
  reinforcement = trigger_reinforcement_get_reinforcement_spawner();
  guy = spawn_ai();

  if(!isDefined(guy)) {
    self delete();

    if(isDefined(reinforcement)) {
      guy = reinforcement spawn_ai();
      reinforcement delete();

      if(!isDefined(guy)) {
        return;
      }
    } else {
      return;
    }
  }

  if(!isDefined(reinforcement)) {
    return;
  }

  guy waittill("death");

  if(!isDefined(reinforcement)) {
    return;
  }

  if(!isDefined(reinforcement.count)) {
    reinforcement.count = 1;
  }

  for(;;) {
    if(!isDefined(reinforcement)) {
      break;
    }

    spawned = reinforcement spawn_ai();

    if(!isDefined(spawned)) {
      reinforcement delete();
      break;
    }

    spawned thread reincrement_count_if_deleted(reinforcement);
    spawned waittill("death", attacker);

    if(!player_saw_kill(spawned, attacker)) {
      println("<dev string:x84>");

      if(!isDefined(reinforcement)) {
        break;
      }

      reinforcement.count++;
    }

    if(!isDefined(spawned)) {
      continue;
    }

    if(!isDefined(reinforcement)) {
      break;
    }

    if(!isDefined(reinforcement.count)) {
      break;
    }

    if(reinforcement.count <= 0) {
      break;
    }

    if(!script_wait()) {
      wait randomfloatrange(1, 3);
    }
  }

  if(isDefined(reinforcement)) {
    reinforcement delete();
  }
}

function trigger_reinforcement_get_reinforcement_spawner() {
  if(isDefined(self.target)) {
    reinforcement = getspawner(self.target, "targetname");

    if(isDefined(reinforcement) && isspawner(reinforcement)) {
      return reinforcement;
    }
  }

  if(isDefined(self.script_linkto)) {
    reinforcement = getspawner(self.script_linkto, "script_linkname");

    if(!isDefined(reinforcement)) {
      reinforcement = get_linked_ent();
    }

    if(isDefined(reinforcement) && isspawner(reinforcement)) {
      return reinforcement;
    }
  }

  return undefined;
}

function flood_spawner_scripted(spawners) {
  assertex(isDefined(spawners) && spawners.size, "Script tried to flood spawn without any spawners");
  array_thread(spawners, &flood_spawner_init);
  array_thread(spawners, &flood_spawner_think);
}

function reincrement_count_if_deleted(spawner) {
  spawner endon("death");

  if(isDefined(self.script_force_count)) {
    if(self.script_force_count) {
      return;
    }
  }

  self waittill("death");

  if(!isDefined(self)) {
    spawner.count++;
  }
}

function kill_spawner(trigger) {
  killspawnernum = trigger.script_killspawner;
  trigger waittill("trigger");
  waittillframeend();
  waittillframeend();
  killspawner(killspawnernum);
  kill_trigger(trigger);
}

function killspawner(killspawnernum) {
  println("<dev string:xbb>" + killspawnernum);
  actor_spawners = getspawnerarray();
  vehicle_spawners = vehicle_getspawnerarray();
  spawners = array_combine(actor_spawners, vehicle_spawners);

  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].script_killspawner) && killspawnernum == spawners[i].script_killspawner) {
      if(isnonentspawner(spawners[i])) {
        spawners[i] notify("death");
      }

      spawners[i] delete();
    }
  }
}

function kill_trigger(trigger) {
  if(!isDefined(trigger)) {
    return;
  }

  if(isDefined(trigger.targetname) && trigger.targetname != "flood_spawner") {
    return;
  }

  trigger delete();
}

function random_killspawner(trigger) {
  trigger endon("death");
  random_killspawner = trigger.script_random_killspawner;
  waittillframeend();

  if(!isDefined(level.killspawn_groups)) {
    level.killspawn_groups = [];
  }

  if(!isDefined(level.killspawn_groups[random_killspawner])) {
    return;
  }

  trigger waittill("trigger");
  cull_spawners_from_killspawner(random_killspawner);
}

function cull_spawners_from_killspawner(random_killspawner) {
  if(!isDefined(level.killspawn_groups)) {
    level.killspawn_groups = [];
  }

  if(!isDefined(level.killspawn_groups[random_killspawner])) {
    return;
  }

  spawn_groups = level.killspawn_groups[random_killspawner];
  keys = getarraykeys(spawn_groups);

  if(keys.size <= 1) {
    return;
  }

  save_key = random(keys);
  spawn_groups[save_key] = undefined;

  foreach(spawners in spawn_groups) {
    foreach(spawner in spawners) {
      if(isDefined(spawner)) {
        spawner delete();
      }
    }

    level.killspawn_groups[random_killspawner][key] = undefined;
  }
}

function empty_spawner(trigger) {
  emptyspawner = trigger.script_emptyspawner;
  trigger waittill("trigger");
  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    if(!isDefined(spawners[i].script_emptyspawner)) {
      continue;
    }

    if(emptyspawner != spawners[i].script_emptyspawner) {
      continue;
    }

    spawners[i] set_count(0);
    spawners[i] notify("emptied spawner");
  }

  trigger notify("deleted spawners");
}

function kill_spawnernum(number) {
  spawners = getspawnerarray();

  foreach(spawner in spawners) {
    if(!isDefined(spawner.script_killspawner)) {
      continue;
    }

    if(number != spawner.script_killspawner) {
      continue;
    }

    spawner delete();
  }
}

function spawn_grenade(origin, team) {
  grenade = spawn("weapon_frag", origin);
  grenade thread add_to_grenade_cache(team);
  return grenade;
}

function add_to_grenade_cache(team) {
  if(!isDefined(level.grenade_cache) || !isDefined(level.grenade_cache[team])) {
    level.grenade_cache_index[team] = 0;
    level.grenade_cache[team] = [];
  }

  index = level.grenade_cache_index[team];
  item = level.grenade_cache[team][index];

  if(isDefined(item)) {
    item delete();
  }

  level.grenade_cache[team][index] = self;
  level.grenade_cache_index[team] = (index + 1) % 16;
}

function dronespawner_init() {
  scripts\sp\drone_base::drone_init_path();
}

function fakeactorspawner_init() {
  scripts\sp\fakeactor::fakeactor_spawner_init();
}

function spawn_prethink() {
  assert(self != level);
  level.ai_classname_in_level[self.classname] = 1;

  if(getDvar(@ "noai", "<dev string:xd1>") != "<dev string:xd1>") {
    set_count(0);
    return;
  }

  if(isDefined(self.script_difficulty)) {
    switch (self.script_difficulty) {
      case #"hash_22ce4003c1e5227b":
        if(level.gameskill > 1) {
          set_count(0);
        }

        break;
      case #"hash_cc9157548a55043c":
        if(level.gameskill < 2) {
          set_count(0);
        }

        break;
    }
  }

  init_stealth();

  if(isDefined(self.script_drone)) {
    thread dronespawner_init();
  }

  if(isDefined(self.script_fakeactor)) {
    thread fakeactorspawner_init();
  }

  if(isDefined(self.script_aigroup)) {
    aigroup = self.script_aigroup;

    if(!isDefined(level._ai_group[aigroup])) {
      aigroup_create(aigroup);
    }

    thread aigroup_spawnerthink(level._ai_group[aigroup]);
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

  if(isDefined(self.script_deathflag)) {
    thread spawner_deathflag();
  }

  if(isDefined(self.target)) {
    crawl_targets_init_flags(self.target);
  }

  if(isDefined(self.script_spawngroup)) {
    add_to_spawngroup();
  }

  if(isDefined(self.script_random_killspawner)) {
    add_random_killspawner_to_spawngroup();
  }

  if(!isDefined(self.spawn_functions)) {
    self.spawn_functions = [];
  }

  for(;;) {
    self waittill("spawned", spawned);

    if(!isalive(spawned)) {
      continue;
    }

    if(isDefined(level.spawnercallbackthread)) {
      self thread[[level.spawnercallbackthread]](spawned);
    }

    if(isDefined(self.script_delete)) {
      for(i = 0; i < level._ai_delete[self.script_delete].size; i++) {
        if(level._ai_delete[self.script_delete][i] != self) {
          level._ai_delete[self.script_delete][i] delete();
        }
      }
    }

    spawned.spawn_funcs = self.spawn_functions;
    spawned.spawn_functions = undefined;
    spawned.spawner = self;

    if(isDefined(self.targetname)) {
      spawned thread spawn_think(self.targetname);
      continue;
    }

    spawned thread spawn_think();
  }
}

function init_stealth() {
  if(!isDefined(self.script_stealth) && !isDefined(self.script_stealthgroup)) {
    return;
  }

  if(isDefined(self.script_stealth) && !isDefined(self.script_stealthgroup)) {
    self.script_stealthgroup = self.script_stealth;
  }

  self.script_stealth = undefined;
}

function spawn_think(targetname) {
  assert(self != level);
  level.ai_classname_in_level[self.classname] = 1;

  if(isDefined(self.asmname) && self.asmname == "seeker") {
    return;
  }

  spawn_think_action(targetname);
  assert(isalive(self));
  self endon("death");

  if(shouldnt_spawn_because_of_script_difficulty()) {
    self delete();
    assertex(0, "Should never get here");
  }

  thread run_spawn_functions();
  self.finished_spawning = 1;
  self notify("finished spawning");
}

function shouldnt_spawn_because_of_script_difficulty() {
  if(!isDefined(self.script_difficulty)) {
    return 0;
  }

  should_delete = 0;

  switch (self.script_difficulty) {
    case #"hash_22ce4003c1e5227b":
      if(level.gameskill > 1) {
        should_delete = 1;
      }

      break;
    case #"hash_cc9157548a55043c":
      if(level.gameskill < 2) {
        should_delete = 1;
      }

      break;
  }

  return should_delete;
}

function run_spawn_functions() {
  team = ter_op(isDefined(level.vehicle.spawn_functions_enable) && level.vehicle.spawn_functions_enable && self.code_classname == "script_vehicle", self.script_team, self.team);

  if(isDefined(team)) {
    for(i = 0; i < level.spawn_funcs[team].size; i++) {
      func = level.spawn_funcs[team][i];

      if(isDefined(func["param5"])) {
        thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
        continue;
      }

      if(isDefined(func["param4"])) {
        thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"]);
        continue;
      }

      if(isDefined(func["param3"])) {
        thread[[func["function"]]](func["param1"], func["param2"], func["param3"]);
        continue;
      }

      if(isDefined(func["param2"])) {
        thread[[func["function"]]](func["param1"], func["param2"]);
        continue;
      }

      if(isDefined(func["param1"])) {
        thread[[func["function"]]](func["param1"]);
        continue;
      }

      thread[[func["function"]]]();
    }
  }

  if(!isDefined(self.spawn_funcs)) {
    if(!isDefined(self.script_suspend)) {
      self.spawner = undefined;
    }

    return;
  }

  for(i = 0; i < self.spawn_funcs.size; i++) {
    func = self.spawn_funcs[i];

    if(isDefined(func["param5"])) {
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
      continue;
    }

    if(isDefined(func["param4"])) {
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"]);
      continue;
    }

    if(isDefined(func["param3"])) {
      thread[[func["function"]]](func["param1"], func["param2"], func["param3"]);
      continue;
    }

    if(isDefined(func["param2"])) {
      thread[[func["function"]]](func["param1"], func["param2"]);
      continue;
    }

    if(isDefined(func["param1"])) {
      thread[[func["function"]]](func["param1"]);
      continue;
    }

    thread[[func["function"]]]();
  }

  self.saved_spawn_functions = self.spawn_funcs;

  self.spawn_funcs = undefined;

  self.spawn_funcs = self.saved_spawn_functions;
  self.saved_spawn_functions = undefined;

  if(!isDefined(self.script_suspend)) {
    self.spawner = undefined;
  }
}

function deathfunctions() {
  self waittill("death", attacker, cause, objweapon);
  weapon = undefined;

  if(isDefined(objweapon)) {
    weapon = getcompleteweaponname(objweapon);
  }

  level notify("ai_killed", self, attacker, cause, weapon);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(attacker)) {
    if(self.team == "axis" || self.team == "team3") {
      killtype = undefined;

      if(isDefined(attacker.attacker)) {
        if(isDefined(attacker.issentrygun) && attacker.issentrygun) {
          killtype = "sentry";
        }

        if(isDefined(attacker.destructible_type)) {
          killtype = "destructible";
        }

        attacker = attacker.attacker;
      } else if(isDefined(attacker.owner)) {
        if(isai(attacker) && isPlayer(attacker.owner)) {
          killtype = "friendly";
        }

        attacker = attacker.owner;
      } else if(isDefined(attacker.damageowner)) {
        if(isDefined(attacker.destructible_type)) {
          killtype = "destructible";
        }

        attacker = attacker.damageowner;
      }

      validattacker = 0;

      if(isPlayer(attacker)) {
        validattacker = 1;
      }

      if(validattacker) {
        attacker.lastenemykilltime = gettime();
        attacker scripts\sp\player_stats::register_kill(self, cause, weapon, killtype);
      }

      scripts\sp\analytics::function_7212c89168020e04(self, attacker, objweapon);
    }
  }
}

function ai_damage_think() {
  self endon("entitydeleted");

  if(!isDefined(self.damage_functions)) {
    self.damage_functions = [];
  }

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
    self.paindamage = damage;

    if(isDefined(attacker) && isPlayer(attacker)) {
      objcurrentweapon = attacker.currentweapon;

      if(isDefined(objcurrentweapon) && isprimaryweapon(objcurrentweapon) && isDefined(type) && (type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET")) {
        attacker thread scripts\sp\player_stats::register_shot_hit();

        if(self isbadguy()) {
          attacker.lastenemydmgtime = gettime();
        }

        if(isalive(self)) {
          addbattlechatternotify(self, undefined, "wounded");
        }
      }
    }

    if(getdvarint(@ "hash_81d89e4abec64203", 0) != 0) {
      dmg_data = [];
      dmg_data["<dev string:xd5>"] = attacker;
      dmg_data["<dev string:xdf>"] = damage;
      dmg_data["<dev string:xe7>"] = type;
      dmg_data["<dev string:xf5>"] = point;
      dmg_data["<dev string:xfc>"] = direction_vec;
      dmg_data["<dev string:x101>"] = objweapon;
      dmg_data["<dev string:x10b>"] = partname;
      scripts\common\debug::function_8245dce28f1f395c(dmg_data);
    }

    foreach(func in self.damage_functions) {
      thread[[func]](damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
    }

    if(!isalive(self) || self.delayeddeath) {
      break;
    }
  }
}

function living_ai_prethink() {
  init_stealth();

  if(isDefined(self.target)) {
    crawl_targets_init_flags(self.target);
  }
}

function crawl_targets_init_flags(target) {
  goals = get_target_goals(target);

  if(goals.size == 0) {
    return;
  }

  index = -1;

  for(;;) {
    index++;

    if(index >= goals.size) {
      break;
    }

    goal = goals[index];

    if(isDefined(goal.crawled)) {
      continue;
    }

    goal.crawled = 1;
    level thread remove_crawled(goal);

    if(isDefined(goal.script_flag_set)) {
      if(!isDefined(level.flag[goal.script_flag_set])) {
        flag_init(goal.script_flag_set);
      }
    }

    if(isDefined(goal.script_flag_wait)) {
      if(!isDefined(level.flag[goal.script_flag_wait])) {
        flag_init(goal.script_flag_wait);
      }
    }

    if(isDefined(goal.script_flag_clear)) {
      if(!isDefined(level.flag[goal.script_flag_clear])) {
        flag_init(goal.script_flag_clear);
      }
    }

    if(isDefined(goal.script_flag_waitopen)) {
      if(!isDefined(level.flag[goal.script_flag_waitopen])) {
        flag_init(goal.script_flag_waitopen);
      }
    }

    if(isDefined(goal.script_idle)) {
      if(!isDefined(level.idle_funcs)) {
        scripts\sp\stealth\idle_sitting::main();
      }
    }

    if(isDefined(goal.target)) {
      new_goals = get_target_goals(goal.target);

      foreach(new in new_goals) {
        if(!isDefined(new.crawled)) {
          goals[goals.size] = new;
        }
      }
    }
  }
}

function remove_crawled(ent) {
  waittillframeend();

  if(isDefined(ent)) {
    ent.crawled = undefined;
  }
}

function spawn_team_allies() {
  self.usechokepoints = 0;
  checkboosttraversal();
  self function_523285babab34e5b("all", 1);
}

function spawn_team_axis() {
  checkboosttraversal();

  if(isDefined(self.script_combatmode)) {
    self.combatmode = self.script_combatmode;
  }

  if(getDvar(@ "hash_c3ae5b7542b15a78") == "<dev string:x114>") {
    self.combatmode = "<dev string:x114>";
    return;
  }

  if(getDvar(@ "hash_c3ae5b7542b15a78") == "<dev string:x11b>") {
    self.combatmode = "<dev string:x11b>";
  }
}

function checkboosttraversal() {
  var_5181f3dc1052495f["crew"] = 1;
  var_5181f3dc1052495f["no_boost"] = 1;
  var_5181f3dc1052495f["noboost"] = 1;

  if(isDefined(self.subclass) && isDefined(var_5181f3dc1052495f[self.subclass])) {
    self enabletraversals(0, "soldier_boost");
  }
}

function spawn_team_team3() {
  spawn_team_axis();
  checkboosttraversal();
}

function spawn_team_neutral() {
  checkboosttraversal();
}

function spawn_unittype_soldier() {}

function spawn_think_game_skill_related() {
  scripts\common\gameskill::default_door_node_flashbang_frequency();
  scripts\common\gameskill::grenadeawareness();
}

function function_14174a31d7324291() {
  if(getDvar(@ "debug_misstime") == "<dev string:x12d>") {
    thread scripts\sp\debug::debugmisstime();
  }

  thread show_bad_path();

  if(self.type == "<dev string:x133>") {
    assertex(self.pathenemylookahead == 0 && self.pathenemyfightdist == 0, "<dev string:x139>" + self.export);
  }
}

function spawn_think_action(targetname) {
  thread ai_damage_think();
  thread tanksquish();

  if(!isDefined(level.ai_dont_glow_in_thermal)) {
    self thermaldrawenable();
  }

  self.spawner_number = undefined;

  if(!isDefined(self.unique_id)) {
    set_ai_number();
    function_82581894f5a1c71c();
  }

  thread deathfunctions();
  level thread scripts\sp\friendlyfire::friendly_fire_think(self);
  self.walkdist = 16;

  function_14174a31d7324291();

  init_reset_ai();
  spawn_think_game_skill_related();
  ai::spawner_fields(self);
  thread scripts\sp\loot::corpselootthink();

  if(getdvarint(@ "scr_heat") == 1) {
    enable_heat_behavior();
  }

  [[level.team_specific_spawn_functions[self.team]]]();

  if(isDefined(level.unittype_spawn_functions[self.unittype])) {
    self thread[[level.unittype_spawn_functions[self.unittype]]]();
  }

  if(isDefined(self.subclass) && isDefined(level.subclass_spawn_functions[self.subclass])) {
    self thread[[level.subclass_spawn_functions[self.subclass]]]();
  }

  if(self.team == "axis") {
    thread add_damage_function(&scripts\sp\damagefeedback::damagefeedback_took_damage);
  }

  set_goal_height_from_settings();

  if(isDefined(self.suspended_ai)) {
    postspawn_suspended_ai();
  }

  if(isDefined(self.script_playerseek)) {
    self setgoalentity(level.player);
    return;
  }

  if(isDefined(self.script_stealthgroup)) {
    if(!isDefined(level.stealth)) {
      scripts\sp\stealth\manager::main();
    }

    stealth_call_thread("do_stealth");
    return;
  }

  if(isDefined(self.script_readystand) && self.script_readystand == 1) {
    enable_readystand();
  }

  if(isDefined(self.script_delayed_playerseek)) {
    if(!isDefined(self.script_radius)) {
      self.goalradius = 800;
    }

    self setgoalentity(level.player);
    level thread delayed_player_seek_think(self);
    return;
  }

  if(isDefined(self.script_moveoverride) && self.script_moveoverride == 1) {
    set_goal_from_settings();
    self setgoalpos(self.origin);
    return;
  }

  var_12c0b5e114d7ddb = 1;

  if(isDefined(self.script_stealthgroup)) {
    var_12c0b5e114d7ddb = 0;
  }

  if(var_12c0b5e114d7ddb) {
    defaultgoalradius = 4;

    if(isDefined(self.aisettings) && istrue(self.aisettings.var_90936cd2d6771517)) {
      defaultgoalradius = self.aisettings.goalradius;
    }

    assertex(self.goalradius == defaultgoalradius, "Changed the goalradius on guy with export " + self.export+" without waiting for spawn_failed. Note that this change will NOT show up by putting a breakpoint on the actors goalradius field because breakpoints don't properly handle the first frame an actor exists.");
  }

  set_goal_from_settings();

  if(isDefined(self.target)) {
    thread go_to_node();
  }
}

function init_reset_ai() {
  if(!isDefined(self.var_6c18812ecbd3b6ae) || self.var_6c18812ecbd3b6ae) {
    set_default_pathenemy_settings();
  }

  if(isDefined(self.script_grenades)) {
    self.grenadeammo = self.script_grenades;
  }

  if(isDefined(self.primaryweapon)) {
    self.noattackeraccuracymod = self aiissniper();
  }

  self.neversprintforvariation = 1;
}

function scrub_guy() {
  if(self.team == "neutral") {
    self setthreatbiasgroup("civilian");
  } else {
    self setthreatbiasgroup(self.team);
  }

  init_reset_ai();
  self.baseaccuracy = 1;
  scripts\common\gameskill::grenadeawareness();
  clear_force_color();
  self.interval = 96;
  self.disablearrivals = 0;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.threatbias = 0;
  self.pacifist = 0;
  self.pacifistwait = 20;
  self.ignorerandombulletdamage = 0;
  self.pushable = 1;
  self.script_pushable = 1;
  self.allowdeath = 0;
  self.anglelerprate = 540;
  self.badplaceawareness = 0.75;
  self.dontavoidplayer = 0;
  self.drawoncompass = 1;
  self.dropweapon = 1;
  self.goalradius = level.default_goalradius;
  self.goalheight = level.default_goalheight;
  self.ignoresuppression = 0;
  self pushplayer(0);
  self.grenadeammo = 3;

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    stop_magic_bullet_shield();
  }

  disable_replace_on_death();
  self.maxsightdistsqrd = 67108864;
  self.script_forcegrenade = 0;
  self.walkdist = 16;
  self.pushable = 1;
  self.script_pushable = 1;
  scripts\anim\init::set_anim_playback_rate();
  self.fixednode = self.team == "allies";
}

function delayed_player_seek_think(spawned) {
  spawned endon("death");

  while(isalive(spawned)) {
    if(spawned.goalradius > 200) {
      spawned.goalradius -= 200;
    }

    wait 6;
  }
}

function get_target_goals(target) {
  goals = getnodearray(target, "targetname");
  new_goals = getStructArray(target, "targetname");

  foreach(new in new_goals) {
    goals[goals.size] = new;
  }

  new_goals = getEntArray(target, "targetname");

  foreach(new in new_goals) {
    if(!is_target_goal_valid(new)) {
      continue;
    }

    goals[goals.size] = new;
  }

  return goals;
}

function is_target_goal_valid(object) {
  if(isspawner(object)) {
    return false;
  }

  switch (object.code_classname) {
    case #"hash_1b79c5d9e0f9886a":
    case #"hash_5e0756fcd4e0adcd":
    case #"hash_8040aa10d9cac1e8":
    case #"hash_81903cb95a447b8c":
      return false;
  }

  return true;
}

function node_has_radius(node) {
  return isDefined(node.radius) && node.radius != 0;
}

function go_to_node(nodes, optional_arrived_at_node_func, var_5e38f20c9628ae25, var_686ec37f85316247) {
  if(!isDefined(nodes)) {
    nodes = [];

    if(isDefined(self.target)) {
      nodes = get_target_goals(self.target);
    }

    if(nodes.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(!isarray(nodes)) {
    nodes = [nodes];
  }

  go_to_node_internal(nodes, optional_arrived_at_node_func, var_5e38f20c9628ae25, var_686ec37f85316247);
}

function get_least_used_from_array(array) {
  if(array.size == 1) {
    return array[0];
  }

  array = array_randomize(array);
  least_used = array[0];

  if(!isDefined(least_used.used_time)) {
    least_used.used_time = 0;
  }

  foreach(node in array) {
    if(!isDefined(node.used_time)) {
      node.used_time = 0;
    }

    if(node.used_time < least_used.used_time) {
      least_used = node;
    }
  }

  least_used.used_time = gettime();
  return least_used;
}

function go_to_node_internal(node, optional_arrived_at_node_func, var_5e38f20c9628ae25, var_686ec37f85316247) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");

  if(!isarray(node)) {
    node = [node];
  }

  if(isDefined(var_686ec37f85316247)) {
    startnode = var_686ec37f85316247;
  } else {
    startnode = node[0];
  }

  thread go_to_node_end();
  usingpatharray = 0;
  patharray = undefined;
  self.interactionplayed = undefined;

  for(;;) {
    if(!usingpatharray) {
      if(isDefined(level.var_375b317cc772ef57)) {
        node = [[level.var_375b317cc772ef57]](node);
      } else {
        node = get_least_used_from_array(node);
      }

      self.patharraystartnode = startnode;
      patharray = get_path_array(node, startnode);
      self.patharray = patharray;
      self.patharrayindex = -1;

      if(patharray.size > 1) {
        usingpatharray = 1;
      }
    }

    self.currentnode = node;

    if(usingpatharray) {
      node = patharray[patharray.size - 1];
      go_through_patharray(patharray, optional_arrived_at_node_func, var_5e38f20c9628ae25);
      patharray = undefined;
      usingpatharray = 0;
    } else {
      node_fields_pre_goal(node);

      if(isDefined(self.stealth)) {
        stealth_call("go_to_node_wait", &go_to_node_set_goal, node);
      } else {
        go_to_node_set_goal(node);
        self waittill("goal");
      }
    }

    node notify("trigger", self);
    node_fields_after_goal(node, optional_arrived_at_node_func);
    interactionid = self getinteractionid();

    if(isDefined(interactionid)) {
      self waittill("bseq_user_deleted");
    } else {
      node script_delay();
    }

    if(isDefined(node.script_flag_wait)) {
      flag_wait(node.script_flag_wait);
    }

    if(isDefined(node.script_flag_waitopen)) {
      flag_waitopen(node.script_flag_waitopen);
    }

    if(isDefined(node.script_ent_flag_wait)) {
      ent_flag_wait(node.script_ent_flag_wait);
    }

    if(isDefined(node.var_43add43a57978cd)) {
      ent_flag_waitopen(node.var_43add43a57978cd);
    }

    node script_wait();
    node_fields_after_goal_and_wait(node, var_5e38f20c9628ae25);

    if(!isDefined(node.target)) {
      break;
    }

    nextnode_array = get_target_goals(node.target);

    if(!nextnode_array.size) {
      break;
    }

    node = nextnode_array;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }

  volume = self getgoalvolume();

  if(isDefined(volume)) {
    self setgoalvolumeauto(volume, volume get_cover_volume_forward());
    return;
  }

  self.goalradius = level.default_goalradius;
}

function go_through_patharray(patharray, optional_arrived_at_node_func, var_5e38f20c9628ae25) {
  self setgoalpath(patharray);

  foreach(index, tempnode in patharray) {
    node_fields_pre_goal(tempnode);

    if(index == 0) {
      while(istrue(self.arriving)) {
        waitframe();
      }
    }

    patharrayindex = waittill_subgoal();
    self.patharrayindex = patharrayindex;

    if(isDefined(self.patharray) && !isDefined(self.patharrayindex)) {
      self.patharrayindex = self.patharray.size - 1;
    }

    if(index == patharray.size - 1) {
      self waittill("goal");
      break;
    }

    tempnode notify("trigger", self);
    function_b8caa11a38862f1c(tempnode, optional_arrived_at_node_func);
    node_fields_after_goal_and_wait(tempnode, var_5e38f20c9628ae25);
  }
}

function waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", index);
  return index;
}

function get_path_array(node, startnode) {
  array = [];
  count = 0;

  while(true) {
    if(is_equal(node.code_classname, "info_volume")) {
      break;
    }

    array[array.size] = node;
    count++;

    if(count == 16) {
      break;
    }

    if(go_to_node_should_stop(node)) {
      break;
    }

    if(!istrue(node.var_97c8a15d77788e5a)) {
      if(isDefined(node.target)) {
        node.interactionid = getinteractionidfortargetname(node.target);
      }

      node.var_97c8a15d77788e5a = 1;
    }

    if(isDefined(node.interactionid)) {
      break;
    }

    if(node == startnode) {
      if(array.size > 1) {
        break;
      }
    }

    if(!isDefined(node.target)) {
      break;
    }

    nextnode_array = get_target_goals(node.target);

    if(!nextnode_array.size) {
      break;
    }

    if(isDefined(level.var_375b317cc772ef57)) {
      node = [[level.var_375b317cc772ef57]](nextnode_array);
      continue;
    }

    node = get_least_used_from_array(nextnode_array);
  }

  return array;
}

function node_fields_pre_goal(node) {
  if(isDefined(node.radius)) {
    self.goalradius = node.radius;
  }

  if(isDefined(node.height)) {
    self.goalheight = node.height;
  }

  if(isDefined(node.script_demeanor)) {
    if(node.script_demeanor == "cqb") {
      utility::enable_cqbwalk();
    } else {
      utility::demeanor_override(node.script_demeanor);
    }
  }

  if(isDefined(node.script_civilian_state)) {
    scripts\asm\asm_bb::bb_setcivilianstate(node.script_civilian_state);
  }

  if(isDefined(node.script_pacifist)) {
    self.pacifist = node.script_pacifist;
  }

  if(isDefined(node.script_ignoreall)) {
    set_ignoreall(node.script_ignoreall);
  }

  if(isDefined(node.script_ignoreme)) {
    set_ignoreme(node.script_ignoreme);
  }

  if(isDefined(node.script_moveplaybackrate)) {
    set_moveplaybackrate(node.script_moveplaybackrate, 0.25);
  }

  if(isDefined(node.script_speed)) {
    set_movement_speed(node.script_speed);
  }

  if(isDefined(node.script_gunpose)) {
    set_gunpose(node.script_gunpose);
  }

  if(isDefined(node.script_disable_arrivals)) {
    if(node.script_disable_arrivals) {
      disable_arrivals();
    } else {
      self.disablearrivals = 0;
    }
  }

  if(isDefined(node.script_disable_exits)) {
    if(node.script_disable_exits) {
      disable_exits();
    } else {
      enable_exits();
    }
  }

  if(isDefined(node.script_combatmode)) {
    self.combatmode = node.script_combatmode;
  }

  if(isDefined(node.script_forcegoal)) {
    assert(isDefined(node.targetname));
    self.target = node.targetname;
  }

  if(isDefined(self.var_8068d435ada84157)) {
    thread[[self.var_8068d435ada84157]]();
  }
}

function node_fields_after_goal(node, optional_arrived_at_node_func, var_8c99244d1e6128b0) {
  if(isDefined(self.stealth)) {
    stealth_call("go_to_node_arrive", &go_to_node_set_goal, node);
  }

  if(!istrue(var_8c99244d1e6128b0)) {
    if(isDefined(node.target) && (isDefined(node.interactionid) || isDefined(node.interaction))) {
      scripts\common\ai::function_8cb35add373dee8a(&go_to_node_set_goal, node);
    } else {
      go_to_node_set_goal();
      self waittill("goal");
    }
  }

  if(isDefined(optional_arrived_at_node_func)) {
    [[optional_arrived_at_node_func]](node);
  }

  if(isDefined(node.script_flag_set)) {
    flag_set(node.script_flag_set);
  }

  if(isDefined(node.script_ent_flag_set)) {
    ent_flag_set(node.script_ent_flag_set);
  }

  if(isDefined(node.script_ent_flag_clear)) {
    ent_flag_clear(node.script_ent_flag_clear);
  }

  if(isDefined(node.script_flag_clear)) {
    flag_clear(node.script_flag_clear);
  }

  if(targets_and_uses_turret(node)) {
    return 1;
  }
}

function function_b8caa11a38862f1c(node, optional_arrived_at_node_func) {
  node_fields_after_goal(node, optional_arrived_at_node_func, 1);
}

function node_fields_after_goal_and_wait(node, var_5e38f20c9628ae25) {
  if(isDefined(node.script_soundalias)) {
    self playSound(node.script_soundalias);
  }

  if(isDefined(node.script_gesture)) {
    thread gesture_simple(node.script_gesture);
  }

  if(isDefined(self.stealth)) {
    stealth_call("go_to_node_post_wait", &go_to_node_set_goal, node);
  }

  if(isDefined(self.post_wait_func)) {
    [[self.post_wait_func]](node);
  }

  if(isDefined(node.script_delay_post)) {
    wait node.script_delay_post;
  }

  while(isDefined(node.script_requires_player)) {
    if(go_to_node_wait_for_player(node, &get_target_goals)) {
      node notify("script_requires_player");
      break;
    }

    wait 0.1;
  }

  if(isDefined(node.script_demeanor_post)) {
    if(node.script_demeanor_post == "cqb") {
      utility::enable_cqbwalk();
    } else {
      utility::demeanor_override(node.script_demeanor_post);
    }
  }

  if(isDefined(var_5e38f20c9628ae25)) {
    [[var_5e38f20c9628ae25]](node);
  }

  if(istrue(node.script_death)) {
    die();
  }

  if(istrue(node.script_delete)) {
    if(istrue(node.script_nosight)) {
      level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 350);
      return;
    }

    if(isDefined(self.magic_bullet_shield)) {
      stop_magic_bullet_shield();
    }

    self delete();
  }
}

function go_to_node_end() {
  self endon("death");
  waittillframeend();
  self.using_goto_node = 1;
  waittill_any_2("reached_path_end", "stop_going_to_node");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
  thread function_480f99299b4cbc38();
}

function function_480f99299b4cbc38() {
  self endon("death");

  if(isDefined(self.currentnode) && isDefined(self.currentnode.interactionid) && isDefined(self.currentnode.interaction)) {
    if(isDefined(self getinteractionid())) {
      self waittill("bseq_user_deleted");
    }

    despawninteraction(self.currentnode.interactionid);
    self.currentnode.interactionid = undefined;
  }

  self.currentnode = undefined;
}

function go_to_node_wait_for_player(node, get_target_func) {
  if(distancesquared(level.player.origin, node.origin) < distancesquared(self.origin, node.origin)) {
    return true;
  }

  if(!isDefined(node.script_dist_only)) {
    vec = anglesToForward(self.angles);

    if(isDefined(node.target)) {
      temp = [[get_target_func]](node.target);

      if(temp.size == 1) {
        vec = vectorNormalize(temp[0].origin - node.origin);
      } else if(isDefined(node.angles)) {
        vec = anglesToForward(node.angles);
      }
    } else if(isDefined(node.angles)) {
      vec = anglesToForward(node.angles);
    }

    vec2 = [];
    vec2[vec2.size] = vectorNormalize(level.player.origin - self.origin);

    foreach(value in vec2) {
      if(vectordot(vec, value) > 0) {
        return true;
      }
    }
  }

  dist = 32;

  if(node.script_requires_player > dist) {
    dist = node.script_requires_player;
  }

  if(distancesquared(level.player.origin, self.origin) < squared(dist)) {
    return true;
  }

  return false;
}

function go_to_node_should_stop(arrivaltarget) {
  if(!isDefined(arrivaltarget)) {
    return true;
  }

  if(!isDefined(arrivaltarget.target)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_delay)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_delay_min)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_delay_max)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_wait)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_wait_add)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_wait_min)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_wait_max)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_flag_wait)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_flag_waitopen)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_ent_flag_wait)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_delay_post)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_requires_player)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_idle)) {
    return true;
  }

  if(isDefined(arrivaltarget.script_stopnode)) {
    return true;
  }

  if(isDefined(arrivaltarget.interaction) || isDefined(arrivaltarget.interactionid)) {
    return true;
  }

  return false;
}

function go_to_node_set_goal(ent) {
  if(isnode(ent)) {
    go_to_node_set_goal_node(ent);
  } else if(isstruct(ent)) {
    go_to_node_set_goal_pos(ent);
  } else if(isent(ent)) {
    go_to_node_set_goal_ent(ent);
  }

  if(isstruct(ent) || isnode(ent)) {
    ent.patrol_stop = go_to_node_should_stop(ent);
  }
}

function go_to_node_set_goal_ent(ent) {
  if(ent.code_classname == "info_volume") {
    self setgoalvolumeauto(ent, ent get_cover_volume_forward());
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(ent);
}

function go_to_node_set_goal_pos(ent) {
  set_goal_ent(ent);
  self notify("go_to_node_new_goal");
}

function go_to_node_set_goal_node(node) {
  set_goal_node(node);
  self notify("go_to_node_new_goal");
}

function targets_and_uses_turret(node) {
  if(!isDefined(node.target)) {
    return false;
  }

  turrets = getEntArray(node.target, "targetname");

  if(!turrets.size) {
    return false;
  }

  turret = turrets[0];

  if(!issubstr(turret.classname, "misc_turret")) {
    return false;
  }

  thread use_a_turret(turret);
  return true;
}

function set_goal_height_from_settings() {
  if(isDefined(self.script_goalheight)) {
    self.goalheight = self.script_goalheight;
    return;
  }

  self.goalheight = level.default_goalheight;
}

function set_goal_from_settings(node) {
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(isDefined(self.script_forcegoal)) {
    if(isDefined(node) && isDefined(node.radius)) {
      self.goalradius = node.radius;
      return;
    }
  }

  if(!isDefined(self getgoalvolume())) {
    if(self.unittype == "juggernaut") {
      return;
    }

    if(self.type == "civilian") {
      self.goalradius = 128;
      return;
    }

    self.goalradius = level.default_goalradius;
  }
}

function autotarget(targets) {
  for(;;) {
    user = self getturretowner();

    if(!isalive(user)) {
      wait 1.5;
      continue;
    }

    if(!isDefined(user.enemy)) {
      self settargetentity(random(targets));
      self notify("startfiring");
      self startfiring();
    }

    wait 2 + randomfloat(1);
  }
}

function manualtarget(targets) {
  for(;;) {
    self settargetentity(random(targets));
    self notify("startfiring");
    self startfiring();
    wait 2 + randomfloat(1);
  }
}

function use_a_turret(turret) {
  self endon("stop_using_turret");
  self endon("death");

  if(self isbadguy() && self.health == 150) {
    self.health = 100;
    self.allowlongdeath = 0;
  }

  scripts\asm\asm_bb::bb_requestturret(turret);

  while(!isDefined(self getturret()) || self getturret() != turret) {
    wait 0.05;
  }

  if(isDefined(turret.target) && turret.target != turret.targetname) {
    ents = getEntArray(turret.target, "targetname");
    targets = [];

    for(i = 0; i < ents.size; i++) {
      if(ents[i].classname == "script_origin") {
        targets[targets.size] = ents[i];
      }
    }

    if(isDefined(turret.script_autotarget)) {
      turret thread autotarget(targets);
    } else if(isDefined(turret.script_manualtarget)) {
      turret setmode("manual_ai");
      turret thread manualtarget(targets);
    } else if(targets.size > 0) {
      if(targets.size == 1) {
        turret.manual_target = targets[0];
        turret settargetentity(targets[0]);
        thread scripts\sp\mgturret::manual_think(turret);
      } else {
        turret thread scripts\sp\mgturret::mg42_suppressionfire(targets);
      }
    }
  }

  thread player_use_turret_watcher(turret);
  thread scripts\sp\mgturret::mg42_firing(turret);
  turret notify("startfiring");
}

function player_use_turret_watcher(turret) {
  self endon("death");

  if(self.team != "allies") {
    return;
  }

  trigger = spawn("trigger_radius", turret.origin, 0, 56, 56);
  thread delete_on_death(trigger);
  shouldbreak = 0;

  while(!shouldbreak) {
    trigger waittill("trigger");

    while(level.player istouching(trigger)) {
      if(level.player useButtonPressed()) {
        shouldbreak = 1;
        break;
      }

      wait 0.05;
    }
  }

  trigger delete();
  stop_using_turret();
}

function stop_using_turret() {
  self notify("stop_using_turret");
  self notify("stop_using_built_in_burst_fire");
  turret = self getturret();

  if(!isDefined(turret)) {
    return;
  }

  self stopuseturret();
  scripts\asm\asm_bb::bb_requestturret(undefined);
  self stopanimScripted();
  turret stopfiring();
}

function friendly_mgturret(trigger) {
  if(!isDefined(trigger.target)) {
    error("<dev string:x1ab>" + trigger getorigin());
  }

  node = getnode(trigger.target, "targetname");

  if(!isDefined(node.target)) {
    error("<dev string:x1d8>" + node.origin);
  }

  mg42 = getEnt(node.target, "targetname");
  mg42 setmode("auto_ai");
  mg42 cleartargetentity();
  in_use = 0;

  while(true) {
    trigger waittill("trigger", other);

    if(!isai(other)) {
      continue;
    }

    if(!isDefined(other.team)) {
      continue;
    }

    if(other.team != "allies") {
      continue;
    }

    if(isDefined(other.script_usemg42) && other.script_usemg42 == 0) {
      continue;
    }

    if(other thread friendly_mg42_useable(mg42, node)) {
      other thread friendly_mg42_think(mg42, node);
      mg42 waittill("friendly_finished_using_mg42");

      if(isalive(other)) {
        other.turret_use_time = gettime() + 10000;
      }
    }

    wait 1;
  }
}

function friendly_mg42_death_notify(guy, mg42) {
  mg42 endon("friendly_finished_using_mg42");
  guy waittill("death");
  mg42 notify("friendly_finished_using_mg42");
}

function friendly_mg42_wait_for_use(mg42) {
  mg42 endon("friendly_finished_using_mg42");
  self.useable = 1;
  self setCursorHint("HINT_NOICON");
  self setHintString(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  self.useable = 0;
  self setHintString("");
  self stopuseturret();
  self notify("stopped_use_turret");
  mg42 notify("friendly_finished_using_mg42");
}

function friendly_mg42_useable(mg42, node) {
  if(self.useable) {
    return false;
  }

  if(isDefined(self.turret_use_time) && gettime() < self.turret_use_time) {
    return false;
  }

  if(distance(level.player.origin, node.origin) < 100) {
    return false;
  }

  return true;
}

function friendly_mg42_endtrigger(mg42, guy) {
  mg42 endon("friendly_finished_using_mg42");
  self waittill("trigger");
  mg42 notify("friendly_finished_using_mg42");
}

function nofour() {
  self endon("death");
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32) {
    self.goalradius = 400;
  }
}

function friendly_mg42_think(mg42, node) {
  self endon("death");
  mg42 endon("friendly_finished_using_mg42");
  level thread friendly_mg42_death_notify(self, mg42);
  self.oldradius = self.goalradius;
  self.goalradius = 28;
  thread nofour();
  self setgoalnode(node);
  self.ignoresuppression = 1;
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32) {
    self.goalradius = 400;
  }

  self.ignoresuppression = 0;
  self.goalradius = self.oldradius;

  if(distance(level.player.origin, node.origin) < 32) {
    mg42 notify("friendly_finished_using_mg42");
    return;
  }

  self.friendly_mg42 = mg42;
  thread friendly_mg42_wait_for_use(mg42);
  thread friendly_mg42_cleanup(mg42);
  self useturret(mg42);

  if(isDefined(mg42.target)) {
    stoptrigger = getEnt(mg42.target, "targetname");

    if(isDefined(stoptrigger)) {
      stoptrigger thread friendly_mg42_endtrigger(mg42, self);
    }
  }

  while(true) {
    if(distance(self.origin, node.origin) < 32) {
      self useturret(mg42);
    } else {
      break;
    }

    wait 1;
  }

  mg42 notify("friendly_finished_using_mg42");
}

function friendly_mg42_cleanup(mg42) {
  self endon("death");
  mg42 waittill("friendly_finished_using_mg42");
  friendly_mg42_doneusingturret();
}

function friendly_mg42_doneusingturret() {
  self endon("death");
  turret = self.friendly_mg42;
  self.friendly_mg42 = undefined;
  self stopuseturret();
  self notify("stopped_use_turret");
  self.useable = 0;
  self.goalradius = self.oldradius;

  if(!isDefined(turret)) {
    return;
  }

  if(!isDefined(turret.target)) {
    return;
  }

  node = getnode(turret.target, "targetname");
  oldradius = self.goalradius;
  self.goalradius = 8;
  self setgoalnode(node);
  wait 2;
  self.goalradius = 384;
}

function tanksquish() {
  if(isDefined(level.notanksquish)) {
    assertex(level.notanksquish, "level.noTankSquish must be true or undefined");
    return;
  }

  if(isDefined(level.vehicle.has_vehicles) && !level.vehicle.has_vehicles) {
    return;
  }

  add_damage_function(&tanksquish_damage_check);
}

function tanksquish_damage_check(amt, who, force, point, type, modelname, tagname, partname, idflags, weapon) {
  if(!isDefined(self)) {
    return;
  }

  if(isalive(self)) {
    return;
  }

  if(!isalive(who)) {
    return;
  }

  if(!isDefined(who.vehicletype)) {
    return;
  }

  if(who scripts\common\vehicle::ishelicopter()) {
    return;
  }

  if(!isDefined(self.noragdoll)) {
    if(isDefined(self.fnpreragdoll)) {
      self[[self.fnpreragdoll]]();
    }

    self startragdoll();
  }

  if(!isDefined(self)) {
    return;
  }

  remove_damage_function(&tanksquish_damage_check);
}

function flood_and_secure(instantrespawn) {
  if(!isDefined(instantrespawn)) {
    instantrespawn = 0;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn") {
    instantrespawn = 1;
  }

  level.spawnerwave = [];
  spawners = getspawnerarray(self.target);
  array_thread(spawners, &flood_and_secure_spawner, instantrespawn);
  playertriggered = 0;
  diddelay = 0;

  for(;;) {
    self waittill("trigger", other);

    if(!diddelay) {
      diddelay = 1;
      script_delay();
    }

    if(self istouching(level.player)) {
      playertriggered = 1;
    } else {
      if(!isalive(other)) {
        continue;
      }

      if(isPlayer(other)) {
        playertriggered = 1;
      } else if(!isDefined(other.issquad) || !other.issquad) {
        continue;
      }
    }

    spawners = getspawnerarray(self.target);

    if(isDefined(spawners[0])) {
      if(isDefined(spawners[0].script_randomspawn)) {
        cull_spawners_from_killspawner(spawners[0].script_randomspawn);
      }
    }

    spawners = getspawnerarray(self.target);

    for(i = 0; i < spawners.size; i++) {
      spawners[i].playertriggered = playertriggered;
      spawners[i] notify("flood_begin");
    }

    if(playertriggered) {
      wait 5;
      continue;
    }

    wait 0.1;
  }
}

function flood_and_secure_spawner(instantrespawn) {
  if(isDefined(self.securestarted)) {
    return;
  }

  self.securestarted = 1;
  self.triggerunlocked = 1;
  target = self.target;
  targetname = self.targetname;

  if(!isDefined(target) && !isDefined(self.script_moveoverride)) {
    println("<dev string:x20b>" + self.classname + "<dev string:x213>" + self.origin + "<dev string:x21f>");
    waittillframeend();
    assert(isDefined(target));
  }

  spawners = [];

  if(isDefined(target)) {
    possiblespawners = getspawnerarray(target);

    for(i = 0; i < possiblespawners.size; i++) {
      if(!issubstr(possiblespawners[i].classname, "actor")) {
        continue;
      }

      spawners[spawners.size] = possiblespawners[i];
    }
  }

  ent = spawnStruct();
  org = self.origin;
  flood_and_secure_spawner_think(ent, spawners.size > 0, instantrespawn);

  if(isalive(ent.ai)) {
    ent.ai waittill("death");
  }

  if(!isDefined(target)) {
    return;
  }

  possiblespawners = getspawnerarray(target);

  if(!possiblespawners.size) {
    return;
  }

  for(i = 0; i < possiblespawners.size; i++) {
    if(!issubstr(possiblespawners[i].classname, "actor")) {
      continue;
    }

    possiblespawners[i].targetname = targetname;
    newtarget = target;

    if(isDefined(possiblespawners[i].target)) {
      targetent = getspawner(possiblespawners[i].target, "targetname");

      if(!isDefined(targetent) || !issubstr(targetent.classname, "actor")) {
        newtarget = possiblespawners[i].target;
      }
    }

    possiblespawners[i].target = newtarget;
    possiblespawners[i] thread flood_and_secure_spawner(instantrespawn);
    possiblespawners[i].playertriggered = 1;
    possiblespawners[i] notify("flood_begin");
  }
}

function flood_and_secure_spawner_think(ent, oneshot, instantrespawn) {
  assert(isDefined(instantrespawn));
  self endon("death");
  count = self.count;

  if(!oneshot) {
    oneshot = isDefined(self.script_noteworthy) && self.script_noteworthy == "delete";
  }

  set_count(2);
  assertex(!isDefined(self.script_suspend), "Flood and secure spawner does not support script_suspend");

  if(isDefined(self.script_delay)) {
    delay = self.script_delay;
  } else {
    delay = 0;
  }

  for(;;) {
    self waittill("flood_begin");

    if(self.playertriggered) {
      break;
    }

    if(delay) {
      continue;
    }

    break;
  }

  dist = distance(level.player.origin, self.origin);

  while(count) {
    self.truecount = count;
    set_count(2);
    wait delay;
    spawn = spawn_ai();

    if(spawn_failed(spawn)) {
      playerkill = 0;

      if(delay < 2) {
        wait 2;
      }

      continue;
    } else {
      thread addtowavespawner(spawn);
      spawn thread flood_and_secure_spawn(self);

      if(isDefined(self.script_accuracy)) {
        spawn.baseaccuracy = self.script_accuracy;
      }

      ent.ai = spawn;
      ent notify("got_ai");
      self waittill("spawn_died", deleted, playerkill);

      if(delay > 2) {
        delay = randomint(4) + 2;
      } else {
        delay = 0.5 + randomfloat(0.5);
      }
    }

    if(deleted) {
      waittillrestartordistance(dist);
      continue;
    }

    if(playerwasnearby(playerkill || oneshot, ent.ai)) {
      count--;
    }

    if(!instantrespawn) {
      waituntilwaverelease();
    }
  }

  self delete();
}

function waittilldeletedordeath(spawn) {
  self endon("death");
  spawn waittill("death");
}

function addtowavespawner(spawn) {
  name = self.targetname;

  if(!isDefined(level.spawnerwave[name])) {
    level.spawnerwave[name] = spawnStruct();
    level.spawnerwave[name] set_count(0);
    level.spawnerwave[name].total = 0;
  }

  if(!isDefined(self.addedtowave)) {
    self.addedtowave = 1;
    level.spawnerwave[name].total++;
  }

  level.spawnerwave[name].count++;
  waittilldeletedordeath(spawn);
  level.spawnerwave[name].count--;

  if(!isDefined(self)) {
    level.spawnerwave[name].total--;
  }

  if(level.spawnerwave[name].total) {
    if(level.spawnerwave[name].count / level.spawnerwave[name].total < 0.32) {
      level.spawnerwave[name] notify("waveReady");
    }
  }
}

function waituntilwaverelease() {
  name = self.targetname;

  if(level.spawnerwave[name].count) {
    level.spawnerwave[name] waittill("waveReady");
  }
}

function playerwasnearby(playerkill, ai) {
  if(playerkill) {
    return 1;
  }

  if(isDefined(ai) && isDefined(ai.origin)) {
    org = ai.origin;
  } else {
    org = self.origin;
  }

  if(distance(level.player.origin, org) < 700) {
    return 1;
  }

  return scripts\engine\trace::_bullet_trace_passed(level.player getEye(), ai getEye(), 0, undefined);
}

function waittillrestartordistance(dist) {
  self endon("flood_begin");
  dist *= 0.75;

  while(distance(level.player.origin, self.origin) > dist) {
    wait 1;
  }
}

function flood_and_secure_spawn(spawner) {
  thread flood_and_secure_spawn_goal();
  self waittill("death", other);
  playerkill = isalive(other) && isPlayer(other);

  if(!playerkill && isDefined(other) && other.classname == "worldspawn") {
    playerkill = 1;
  }

  deleted = !isDefined(self);
  spawner notify("spawn_died", deleted, playerkill);
}

function flood_and_secure_spawn_goal() {
  if(isDefined(self.script_moveoverride)) {
    return;
  }

  self endon("death");
  node = getnode(self.target, "targetname");

  if(isDefined(node)) {
    self setgoalnode(node);
  } else {
    node = getEnt(self.target, "targetname");

    if(isDefined(node)) {
      self setgoalpos(node.origin);
    }
  }

  assertex(isDefined(node), "flood_and_secure_spawn_goal behavior requires a valid node or origin to be specified as the target.");

  if(isDefined(level.fightdist)) {
    self.pathenemyfightdist = level.fightdist;
    self.pathenemylookahead = level.maxdist;
  }

  if(isDefined(node.radius) && node.radius >= 0) {
    self.goalradius = node.radius;
  } else {
    self.goalradius = 256;
  }

  self waittill("goal");

  while(isDefined(node.target)) {
    newnode = getnode(node.target, "targetname");

    if(isDefined(newnode)) {
      node = newnode;
    } else {
      break;
    }

    self setgoalnode(node);

    if(node_has_radius(node)) {
      self.goalradius = node.radius;
    } else {
      self.goalradius = 256;
    }

    self waittill("goal");
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self kill();
      return;
    }
  }

  if(isDefined(node.target)) {
    turret = getEnt(node.target, "targetname");

    if(isDefined(turret) && turret.code_classname == "misc_turret") {
      self setgoalnode(node);
      self.goalradius = 4;
      self waittill("goal");

      if(!isDefined(self.script_forcegoal)) {
        self.goalradius = level.default_goalradius;
      }

      use_a_turret(turret);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "hide") {
      thread utility::set_battlechatter(0);
      return;
    }
  }

  if(!isDefined(self.script_forcegoal) && !isDefined(self getgoalvolume())) {
    self.goalradius = level.default_goalradius;
  }
}

function goalvolumes() {
  volumes = getEntArray("info_volume", "classname");
  volumes = array_combine(volumes, getEntArray("info_volume_color", "classname"));
  level.deathchain_goalvolume = [];
  level.goalvolumes = [];

  for(i = 0; i < volumes.size; i++) {
    volume = volumes[i];

    if(isDefined(volume.script_deathchain)) {
      level.deathchain_goalvolume[volume.script_deathchain] = volume;
    }

    if(isDefined(volume.script_goalvolume)) {
      assertex(!isDefined(level.goalvolumes[volume.script_goalvolume]), "Tried to overwrite goalvolume with script_goalvolume " + volume.script_goalvolume + ". Maybe you are using the same script_goalvolume value in a prefab? Script_goalvolume is not autocast in prefabs.");
      level.goalvolumes[volume.script_goalvolume] = volume;
    }
  }
}

function aigroup_create(aigroup) {
  level._ai_group[aigroup] = spawnStruct();
  level._ai_group[aigroup].aicount = 0;
  level._ai_group[aigroup].aideaths = 0;
  level._ai_group[aigroup].spawnercount = 0;
  level._ai_group[aigroup].ai = [];
  level._ai_group[aigroup].spawners = [];
}

function aigroup_spawnerthink(tracker) {
  self endon("death");
  self endon("stop_aigroup_spawnerthink");
  self.decremented = 0;
  tracker.spawnercount++;
  tracker.spawners = array_add(tracker.spawners, self);
  thread aigroup_spawnerdeath(tracker);
  thread aigroup_spawnerempty(tracker);
  self waittill("spawned", soldier);

  if(!spawn_failed(soldier)) {
    soldier thread aigroup_soldierthink(tracker);
  }

  aigroup_decrement(tracker);
}

function aigroup_decrement(tracker) {
  if(self.decremented) {
    return;
  }

  self.decremented = 1;
  tracker.spawnercount--;
  self notify("stop_aigroup_spawnerthink");
}

function aigroup_spawnerdeath(tracker) {
  self waittill("death");

  if(isDefined(self)) {
    aigroup_decrement(tracker);
  }
}

function aigroup_spawnerempty(tracker) {
  self endon("death");
  self waittill("emptied spawner");
  aigroup_decrement(tracker);
}

function aigroup_soldierthink(tracker) {
  tracker.aicount++;
  tracker.ai[tracker.ai.size] = self;

  if(isDefined(self.script_deathflag_longdeath)) {
    ai::function_d3262c3e00795e21();
  } else {
    self waittill("death");
  }

  tracker.aicount--;
  tracker.aideaths++;
}

function camper_trigger_think(trigger) {
  tokens = strtok(trigger.script_linkto, " ");
  spawners = [];
  nodes = [];

  for(i = 0; i < tokens.size; i++) {
    token = tokens[i];
    ai = getspawner(token, "script_linkname");

    if(isDefined(ai)) {
      spawners = array_add_safe(spawners, ai);
      continue;
    }

    node = getnode(token, "script_linkname");

    if(!isDefined(node)) {
      println("<dev string:x22e>" + token + "<dev string:x24d>");
      continue;
    }

    nodes = array_add_safe(nodes, node);
  }

  assertex(spawners.size, "camper_spawner without any spawners associated");
  assertex(nodes.size, "camper_spawner without any nodes associated");
  assertex(nodes.size >= spawners.size, "camper_spawner with less nodes than spawners");
  trigger waittill("trigger");
  nodes = array_randomize(nodes);

  for(i = 0; i < nodes.size; i++) {
    nodes[i].claimed = 0;
  }

  j = 0;

  for(i = 0; i < spawners.size; i++) {
    spawner = spawners[i];

    if(!isDefined(spawner)) {
      continue;
    }

    if(isDefined(spawner.script_spawn_here)) {
      continue;
    }

    while(isDefined(nodes[j].script_noteworthy) && nodes[j].script_noteworthy == "dont_spawn") {
      j++;
    }

    spawner.origin = nodes[j].origin;
    spawner.angles = nodes[j].angles;
    spawner add_spawn_function(&claim_a_node, nodes[j]);
    j++;
  }

  array_thread(spawners, &add_spawn_function, &camper_guy);
  array_thread(spawners, &add_spawn_function, &move_when_enemy_hides, nodes);
  array_thread(spawners, &spawn_ai);
}

function camper_guy() {
  self.goalradius = 8;
  self.fixednode = 1;
}

function move_when_enemy_hides(nodes) {
  self endon("death");
  waitingforenemytodisappear = 0;

  while(true) {
    if(!isalive(self.enemy)) {
      self waittill("enemy");
      waitingforenemytodisappear = 0;
      continue;
    }

    if(isPlayer(self.enemy)) {
      if(self.enemy scripts\sp\player::belowcriticalhealththreshold() || self.enemy isflashed()) {
        self.fixednode = 0;

        for(;;) {
          self.goalradius = 180;
          self setgoalpos(level.player.origin);
          wait 1;
        }

        return;
      }
    }

    if(waitingforenemytodisappear) {
      if(self cansee(self.enemy)) {
        wait 0.05;
        continue;
      }

      waitingforenemytodisappear = 0;
    } else {
      if(self cansee(self.enemy)) {
        waitingforenemytodisappear = 1;
      }

      wait 0.05;
      continue;
    }

    if(randomint(3) > 0) {
      node = find_unclaimed_node(nodes);

      if(isDefined(node)) {
        claim_a_node(node, self.claimed_node);
        self waittill("goal");
      }
    }
  }
}

function claim_a_node(claimed_node, old_claimed_node) {
  self setgoalnode(claimed_node);
  self.claimed_node = claimed_node;
  claimed_node.claimed = 1;

  if(isDefined(old_claimed_node)) {
    old_claimed_node.claimed = 0;
  }
}

function find_unclaimed_node(nodes) {
  for(i = 0; i < nodes.size; i++) {
    if(nodes[i].claimed) {
      continue;
    }

    return nodes[i];
  }

  return undefined;
}

function flood_trigger_think(trigger) {
  assertex(isDefined(trigger.target), "flood_spawner at " + trigger.origin + " without target");
  floodspawners = getspawnerarray(trigger.target);
  assertex(floodspawners.size, "flood_spawner at with target " + trigger.target + " without any targets");
  array_thread(floodspawners, &flood_spawner_init);
  trigger waittill("trigger");
  floodspawners = getspawnerarray(trigger.target);
  array_thread(floodspawners, &flood_spawner_think, trigger);
}

function flood_spawner_init() {
  assertex(isspawner(self), "Spawner at origin " + self.origin + " is not a spawner!");
}

function trigger_requires_player(trigger) {
  if(!isDefined(trigger)) {
    return false;
  }

  return isDefined(trigger.script_requires_player);
}

function flood_spawner_think(trigger) {
  if(isspawner(self)) {
    self endon("death");
  }

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");

  if(is_pyramid_spawner()) {
    pyramid_spawn(trigger);
    return;
  }

  requires_player = trigger_requires_player(trigger);
  script_delay();

  while(self.count > 0) {
    while(requires_player && !level.player istouching(trigger)) {
      wait 0.5;
    }

    soldier = spawn_ai();

    if(spawn_failed(soldier)) {
      wait 2;
      continue;
    }

    soldier thread reincrement_count_if_deleted(self);
    soldier waittill("death", attacker);

    if(!player_saw_kill(soldier, attacker)) {
      self.count++;
    }

    if(!isDefined(soldier)) {
      continue;
    }

    if(!script_wait()) {
      wait randomfloatrange(5, 9);
    }
  }
}

function player_saw_kill(guy, attacker) {
  if(isDefined(self.script_force_count)) {
    if(self.script_force_count) {
      return 1;
    }
  }

  if(!isDefined(guy)) {
    return 0;
  }

  if(isalive(attacker)) {
    if(isPlayer(attacker)) {
      return 1;
    }

    if(distance(attacker.origin, level.player.origin) < 200) {
      return 1;
    }
  } else if(isDefined(attacker)) {
    if(attacker.classname == "worldspawn") {
      return 0;
    }

    if(distance(attacker.origin, level.player.origin) < 200) {
      return 1;
    }
  }

  if(distance(guy.origin, level.player.origin) < 200) {
    return 1;
  }

  return scripts\engine\trace::_bullet_trace_passed(level.player getEye(), guy getEye(), 0, undefined);
}

function is_pyramid_spawner() {
  if(!isDefined(self.target)) {
    return 0;
  }

  ent = getspawnerarray(self.target);

  if(!ent.size) {
    return 0;
  }

  return issubstr(ent[0].classname, "actor");
}

function pyramid_death_report(spawner) {
  spawner.spawn waittill("death");
  self notify("death_report");
}

function pyramid_spawn(trigger) {
  self endon("death");
  requires_player = trigger_requires_player(trigger);
  script_delay();

  if(requires_player) {
    while(!level.player istouching(trigger)) {
      wait 0.5;
    }
  }

  spawners = getspawnerarray(self.target);

  for(i = 0; i < spawners.size; i++) {
    assertex(issubstr(spawners[i].classname, "<dev string:x25d>"), "<dev string:x263>");
  }

  self.spawners = 0;
  array_thread(spawners, &pyramid_spawner_reports_death, self);
  offset = randomint(spawners.size);

  for(i = 0; i < spawners.size; i++) {
    if(self.count <= 0) {
      return;
    }

    offset++;

    if(offset >= spawners.size) {
      offset = 0;
    }

    spawner = spawners[offset];
    spawner set_count(1);
    soldier = spawner spawn_ai();

    if(spawn_failed(soldier)) {
      wait 2;
      continue;
    }

    self.count--;
    spawner.spawn = soldier;
    soldier thread reincrement_count_if_deleted(self);
    soldier thread expand_goalRadius(trigger);
    thread pyramid_death_report(spawner);
  }

  culmulative_wait = 0.01;

  while(self.count > 0) {
    self waittill("death_report");
    issuspended = 0;

    foreach(spawner in spawners) {
      spawner.postspawnresetorigin = 1;

      if(isDefined(spawner.suspended_ai)) {
        issuspended = 1;
      }
    }

    if(issuspended) {
      trigger waittill("trigger");
    }

    script_wait();
    offset = randomint(spawners.size);

    for(i = 0; i < spawners.size; i++) {
      spawners = array_removeundefined(spawners);

      if(!spawners.size) {
        if(isDefined(self)) {
          self delete();
        }

        return;
      }

      offset++;

      if(offset >= spawners.size) {
        offset = 0;
      }

      spawner = spawners[offset];

      if(isalive(spawner.spawn)) {
        continue;
      }

      if(isDefined(spawner.target)) {
        self.target = spawner.target;
      } else {
        self.target = undefined;
      }

      soldier = spawn_ai();

      if(spawn_failed(soldier)) {
        wait 2;
        continue;
      }

      assertex(isDefined(spawner), "Theoretically impossible.");
      soldier thread reincrement_count_if_deleted(self);
      soldier thread expand_goalRadius(trigger);
      spawner.spawn = soldier;
      thread pyramid_death_report(spawner);

      if(self.count <= 0) {
        return;
      }
    }
  }
}

function pyramid_spawner_reports_death(parent) {
  parent endon("death");
  parent.spawners++;
  self waittill("death");
  parent.spawners--;

  if(!parent.spawners) {
    parent delete();
  }
}

function expand_goalRadius(trigger) {
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

function show_bad_path() {
  if(!isDefined(level.debug_badpath) || !level.debug_badpath) {
    return;
  }

  setdvarifuninitialized(@ "hash_5ae66c3bb0c9dbba", "<dev string:x283>");
  self endon("<dev string:x286>");
  last_bad_path_time = -5000;
  serverduration = 200;
  bad_path_count = 0;

  for(;;) {
    self waittill("<dev string:x28c>", badpathpos);

    if(gettime() - last_bad_path_time > 5000) {
      bad_path_count = 0;
    } else {
      bad_path_count++;
    }

    last_bad_path_time = gettime();

    if(bad_path_count < getdvarint(@ "hash_5ae66c3bb0c9dbba")) {
      continue;
    }

    for(i = 0; i < serverduration; i++) {
      line(self.origin, badpathpos, (1, 0.4, 0.1));
      waitframe();
    }
  }
}

function random_spawn(trigger) {
  trigger waittill("trigger");
  spawners = getspawnerarray(trigger.target);

  if(!spawners.size) {
    return;
  }

  spawner = random(spawners);
  spawners = [];
  spawners[spawners.size] = spawner;

  if(isDefined(spawner.script_linkto)) {
    links = strtok(spawner.script_linkto, " ");

    for(i = 0; i < links.size; i++) {
      spawners[spawners.size] = getspawner(links[i], "script_linkname");
    }
  }

  waittillframeend();
  array_thread(spawners, &add_spawn_function, &blowout_goalradius_on_pathend);
  array_thread(spawners, &spawn_ai);
}

function blowout_goalradius_on_pathend() {
  if(isDefined(self.script_forcegoal)) {
    return;
  }

  self endon("death");
  self waittill("reached_path_end");

  if(!isDefined(self getgoalvolume())) {
    self.goalradius = level.default_goalradius;
  }
}

function function_7a2464dfda234e36() {
  drone = self;

  if(!isundefinedweapon(drone.weapon)) {
    defaults = getweapondefaultattachments(drone.weapon.basename);
    weaponattached = 0;

    if(defaults.size == 0) {
      weapon_model = getweaponmodel(drone.weapon);

      if(modelhastag(weapon_model, "tag_flash")) {
        drone attach(weapon_model, "tag_weapon_right");
        hidetaglist = getweaponhidetags(drone.weapon);

        for(i = 0; i < hidetaglist.size; i++) {
          tag = hidetaglist[i];

          if(hastag(weapon_model, tag)) {
            drone hidepart(tag, weapon_model);
          }
        }

        weaponattached = 1;
      }
    }

    if(!weaponattached) {
      if(!istrue(drone.usescriptedweapon)) {
        defaults_pruned = utility::removeconflictingattachments(drone.weapon.attachments, defaults, drone.weapon.basename);
        drone.weapon = drone.weapon withoutattachments();
        drone.weapon = drone.weapon withattachments(array_combine(defaults_pruned, drone.weapon.attachments));
      }

      drone gun_create_fake(getweaponattachmentworldmodels(drone.weapon));

      if(!istrue(self.nodrop)) {
        drone.weapon_object = drone.weapon;
      }

      drone.weapon = nullweapon();
    }
  }

  drone enable_procedural_bones();
}

function spawner_dronespawn(spawner) {
  drone = spawner scripts\sp\fakeactor::spawndrone();
  drone function_7a2464dfda234e36();
  drone.spawner = spawner;
  drone.drone_delete_on_unload = isDefined(spawner.script_noteworthy) && spawner.script_noteworthy == "drone_delete_on_unload";
  drone.finished_spawning = 1;
  drone notify("finished spawning");
  spawner notify("drone_spawned", drone);
  return drone;
}

function spawner_makerealai(drone, target_override) {
  if(!isDefined(drone.spawner)) {
    println("<dev string:x295>");
    println("<dev string:x2c0>" + drone.classname);
    println("<dev string:x2d2>" + drone.origin);

    assertmsg("makerealai called on drone does with no .spawner");
  }

  orgorg = drone.spawner.origin;
  organg = drone.spawner.angles;
  orgtarg = drone.spawner.target;
  drone.spawner.origin = drone.origin;
  drone.spawner.angles = drone.angles;

  if(isDefined(target_override)) {
    drone.spawner.target = target_override;
  }

  drone.spawner.count += 1;
  guy = drone.spawner stalingradspawn();
  failed = spawn_failed(guy);

  if(failed) {
    println("<dev string:x295>");
    println("<dev string:x2e4>" + drone.origin);
    println("<dev string:x302>" + drone.spawner.export);
    println("<dev string:x323>" + getaiarray().size);
    println("<dev string:x338>");

    assertmsg("failed to make real ai out of drone( see console for more info )");
  }

  guy.vehicle_idling = drone.vehicle_idling;
  guy.vehicle_position = drone.vehicle_position;
  guy.standing = drone.standing;
  guy.forcecolor = drone.forcecolor;
  drone.spawner.origin = orgorg;
  drone.spawner.angles = organg;
  drone.spawner.target = orgtarg;
  drone delete();
  return guy;
}

function spawner_makefakeactor(ai, target_override) {
  if(!isDefined(ai.spawner)) {
    println("<dev string:x295>");
    println("<dev string:x370>" + ai.classname);
    println("<dev string:x37f>" + ai.origin);

    assertmsg("makerealai called on drone does with no .spawner");
  }

  orgorg = ai.spawner.origin;
  organg = ai.spawner.angles;
  orgtarg = ai.spawner.target;
  ai.spawner.origin = ai.origin;
  ai.spawner.angles = ai.angles;

  if(isDefined(target_override)) {
    ai.spawner.target = target_override;
  }

  ai.spawner.count += 1;
  guy = fakeactorspawn(ai.spawner);
  failed = spawn_failed(guy);

  if(failed) {
    println("<dev string:x38e>");
    println("<dev string:x2e4>" + ai.origin);
    println("<dev string:x302>" + ai.spawner.export);
    println("<dev string:x338>");

    assertmsg("failed to make fakeactor out of ai( see console for more info )");
  }

  guy.vehicle_idling = ai.vehicle_idling;
  guy.vehicle_position = ai.vehicle_position;
  guy.standing = ai.standing;
  guy.forcecolor = ai.forcecolor;
  ai.spawner.origin = orgorg;
  ai.spawner.angles = organg;
  ai.spawner.target = orgtarg;
  ai delete();
  return guy;
}

function add_random_killspawner_to_spawngroup() {
  assertex(isDefined(self.script_randomspawn), "Spawner at origin " + self.origin + " has no script_randomspawn!");
  spawngroup = self.script_random_killspawner;
  subgroup = self.script_randomspawn;

  if(!isDefined(level.killspawn_groups)) {
    level.killspawn_groups = [];
  }

  if(!isDefined(level.killspawn_groups[spawngroup])) {
    level.killspawn_groups[spawngroup] = [];
  }

  if(!isDefined(level.killspawn_groups[spawngroup][subgroup])) {
    level.killspawn_groups[spawngroup][subgroup] = [];
  }

  level.killspawn_groups[spawngroup][subgroup][self.export] = self;
}

function add_to_spawngroup() {
  assertex(isDefined(self.script_spawnsubgroup), "Spawner at origin " + self.origin + " has no script_spawnsubgroup!");
  spawngroup = self.script_spawngroup;
  subgroup = self.script_spawnsubgroup;

  if(!isDefined(level.spawn_groups[spawngroup])) {
    level.spawn_groups[spawngroup] = [];
  }

  if(!isDefined(level.spawn_groups[spawngroup][subgroup])) {
    level.spawn_groups[spawngroup][subgroup] = [];
  }

  level.spawn_groups[spawngroup][subgroup][self.export] = self;
}

function tracker_bullet_hit(point) {
  self notify("tracker_bullet_hit");
  self endon("tracker_bullet_hit");

  if(self.team != "axis") {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  hudoutline_enable_new("outlinefill_nodepth_red", "tracker");
  waittill_notify_or_timeout("death", 5);
  hudoutline_disable("tracker");

  if(isalive(self)) {
    for(i = 0; i < 3; i++) {
      wait 0.2;
      hudoutline_enable_new("outlinefill_nodepth_red", "tracker");
      wait 0.15;
      hudoutline_disable("tracker");
    }
  }
}

function prespawn_suspended_ai() {
  if(!isDefined(self.script_suspend)) {
    return undefined;
  }

  if(!isDefined(self.suspended_ai)) {
    return 0;
  }

  self.count++;

  if(!isDefined(self.og_spawner_origin)) {
    self.og_spawner_origin = self.origin;
  }

  if(!isDefined(self.og_spawner_angles)) {
    self.og_spawner_angles = self.angles;
  }

  if(isDefined(self.try_og_origin)) {
    self.origin = self.og_spawner_origin;
    self.angles = self.og_spawner_angles;
  } else {
    self.origin = self.suspended_ai.origin;
    self.angles = self.suspended_ai.angles;
  }

  if(isDefined(self.suspended_ai.suspendvars)) {
    self.suspendvars = self.suspended_ai.suspendvars;
  }

  return 1;
}

function postspawn_suspended_ai() {
  suspendstruct = self.spawner.suspended_ai;

  if(isDefined(self.spawner.postspawnresetorigin)) {
    self.spawner.origin = self.og_spawner_origin;
    self.spawner.angles = self.og_spawner_angles;
  }

  thread postspawn_suspend_ai_framedelay(suspendstruct);

  if(!isDefined(suspendstruct.suspendvars)) {
    return;
  }

  self.suspendvars = suspendstruct.suspendvars;
  self.spawner.suspended_ai = undefined;
}

function postspawn_suspend_ai_framedelay(suspendstruct) {
  waittillframeend();
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(suspendstruct.stealth)) {
    assertex(self.team == "axis", "postspawn_suspended_ai() currently does not support non AXIS AI");
    bsmstate = suspendstruct.stealthbsmstate;

    if(bsmstate > 1) {
      bsmstate = suspendstruct.stealthbsmstate - int((gettime() - suspendstruct.suspendtime) / 10000);
      bsmstate = int(max(2, bsmstate));
    } else if(bsmstate > 0) {
      bsmstate = suspendstruct.stealthbsmstate - int((gettime() - suspendstruct.suspendtime) / 5000);
      bsmstate = int(max(0, bsmstate));
    }

    state = int_to_stealth_state(bsmstate);
    scripts\stealth\enemy::bt_set_stealth_state(state, suspendstruct.stealth.investigateevent);
  }
}

function int_to_stealth_state(num) {
  switch (num) {
    case 0:
      return "idle";
    case 1:
      return "investigate";
    case 2:
      return "hunt";
    case 3:
      return "combat";
  }
}

function trigger_zone_spawn(trigger) {
  trigger endon("death");
  assertex(!(trigger.spawnflags & 32), "Trigger at " + trigger.origin + " cannot use spawnflags TRIGGER_SPAWN.");
  assertex(isDefined(trigger.target), "Trigger at " + trigger.origin + " must target at least one spawner.");
  script_suspend = undefined;

  if(isDefined(trigger.script_suspend)) {
    script_suspend = trigger.script_suspend;
  }

  script_suspend_group = undefined;

  if(isDefined(trigger.script_suspend_group)) {
    script_suspend_group = trigger.script_suspend_group;
  }

  spawners = getspawnerarray(trigger.target);

  foreach(spawner in spawners) {
    if(!isDefined(spawner.script_suspend)) {
      spawner.script_suspend = script_suspend;
    }

    if(!isDefined(spawner.script_suspend_group)) {
      spawner.script_suspend_group = script_suspend_group;
    }
  }

  while(true) {
    trigger waittill("trigger", other);
    trigger script_delay();
    spawners = getspawnerarray(trigger.target);

    foreach(spawner in spawners) {
      spawner thread spawn_ai();
    }

    while(isalive(other) && other istouching(trigger)) {
      wait 0.1;
    }
  }
}

function spawn_subclass_juggernaut() {
  if(!isDefined(level.juggernaut_initialized)) {
    level.juggernaut_initialized = 1;
    level.juggernaut_next_alert_time = 0;
  }

  disable_turnanims();
  disable_surprise();

  if(isDefined(level.var_bf8aa3f39f981625)) {
    foreach(func in level.var_bf8aa3f39f981625) {
      self thread[[func]]();
    }
  }

  thread juggernaut_sound_when_close();
}

function juggernaut_sound_when_close() {
  self endon("death");

  while(true) {
    waitframe();

    if(gettime() < level.juggernaut_next_alert_time) {
      continue;
    }

    if(!isalive(level.player)) {
      continue;
    }

    if(distancesquared(level.player.origin, self.origin) > 2250000) {
      continue;
    }

    if(!self cansee(level.player)) {
      continue;
    }

    break;
  }

  level.juggernaut_next_alert_time = gettime() + 15000;
  level notify("juggernaut_attacking");

  if(isDefined(self.skip_intro_sound)) {
    return;
  }
}