/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\spawner.gsc
**************************************/

#using script_78ee1f1787a2e6a4;
#using scripts\anim\init;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\analytics;
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
#using scripts\sp\stealth\idle_sitting;
#using scripts\sp\stealth\manager;
#using scripts\sp\utility;
#using scripts\sp\vehicle;
#using scripts\stealth\callbacks;
#using scripts\stealth\enemy;
#namespace spawner;

function main() {
  if(isDefined(level.spawn_funcs)) {
    return;
  }

  level.spawn_funcs = [];
  level.spawn_funcs["O\x15\x1b\xad\x9ff"] = [];
  level.spawn_funcs["?\xb1\xc0\x9a"] = [];
  level.spawn_funcs["\x8c\x1b\xab)\xd1"] = [];
  level.spawn_funcs["\xba\xa5\x1f\xc9m\x80i"] = [];
  thread goalvolumes();
  var_14a4941be829d51c = getEntArray("\x99\xb1o\xed\x8c\xaf\xc2\xdc#}\xcd\xca\x1b]\xc9e", #targetname);
  utility::array_thread(var_14a4941be829d51c, &flood_and_secure);

  if(!isDefined(level.ai_number)) {
    level.ai_number = 0;
  }

  if(getDvar(@ "fallback") == "") {
    setDvar(@ "fallback", "\xfe");
  }

  if(getDvar(@ "noai") == "") {
    setDvar(@ "noai", "\xf8\x88m");
  }

  createthreatbiasgroup("O\x15\x1b\xad\x9ff");
  createthreatbiasgroup("?\xb1\xc0\x9a");
  createthreatbiasgroup("\x8c\x1b\xab)\xd1");
  createthreatbiasgroup("75\xffQ\x95\xfe`\x9a");
  createthreatbiasgroup("\v`\x90^V\xb2\xac\xd0\x86");
  setthreatbias("?\xb1\xc0\x9a", "\v`\x90^V\xb2\xac\xd0\x86", 250);
  setthreatbias("O\x15\x1b\xad\x9ff", "\v`\x90^V\xb2\xac\xd0\x86", 250);
  setthreatbias("\x8c\x1b\xab)\xd1", "\v`\x90^V\xb2\xac\xd0\x86", -1000);
  flags::init_sp_flags();
  player_sp::init();
  gameskill::init_gameskill();

  foreach(player in level.players) {
    player setthreatbiasgroup("O\x15\x1b\xad\x9ff");
  }

  setdvarifuninitialized(@ "hash_c3ae5b7542b15a78", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_38a088b03f78dca1", "<dev string:x24>");

  level._ai_group = [];
  level.gather_delay = [];

  if(!isDefined(level.deathflags)) {
    level.deathflags = [];
  }

  level.spawner_number = 0;

  if(!isDefined(level.unittype_spawn_functions)) {
    level.unittype_spawn_functions = [];
  }

  level.unittype_spawn_functions["\xb9\xdb6d-\xb2\xc9"] = &spawn_unittype_soldier;

  if(!isDefined(level.subclass_spawn_functions)) {
    level.subclass_spawn_functions = [];
  }

  level.subclass_spawn_functions["\xab\xbf\xbe\xe2\xcdvJ\x14/c"] = &spawn_subclass_juggernaut;
  level.team_specific_spawn_functions = [];
  level.team_specific_spawn_functions["?\xb1\xc0\x9a"] = &spawn_team_axis;
  level.team_specific_spawn_functions["O\x15\x1b\xad\x9ff"] = &spawn_team_allies;
  level.team_specific_spawn_functions["\x8c\x1b\xab)\xd1"] = &spawn_team_team3;
  level.team_specific_spawn_functions["\xba\xa5\x1f\xc9m\x80i"] = &spawn_team_neutral;

  if(!isDefined(level.default_goalradius)) {
    level.default_goalradius = 2048;
  }

  if(!isDefined(level.default_goalheight)) {
    level.default_goalheight = 512;
  }

  level.portable_mg_gun_tag = "\x94\xbd\x13i\xfb|\xe1G\x8f\xafQ\xeeK";
  level._max_script_health = 0;
  ai = getaispeciesarray();
  utility::array_thread(ai, &living_ai_prethink);
  level.ai_classname_in_level = [];
  level.drone_paths = [];
  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    spawners[i] thread spawn_prethink();
  }

  level.drone_paths = undefined;
  utility_sp::hudoutline_add_child_channel("\trg'T\xfd\xab", 1, "\x91\xca\xcc\v\xab\xd8:");
  thread process_deathflags();
  utility::array_thread(ai, &spawn_think);

  aitype_check();
}

function aitype_check() {
  ents = getaispeciesarray();
  ents = utility::array_combine(getspawnerarray(), ents);

  foreach(ent in ents) {
    if(issubstr(ent.classname, "<dev string:x29>")) {
      assertmsg("<dev string:x3c>" + ent.classname + "<dev string:x61>" + ent.origin + "<dev string:x6a>");
    }
  }
}

function process_deathflags() {
  foreach(deathflag, array in level.deathflags) {
    if(!isDefined(level.flag[deathflag])) {
      utility::flag_init(deathflag);
    }
  }
}

function spawn_guys_until_death_or_no_count() {
  self endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    if(self.count > 0) {
      self waittill("\xcb!f\x94\xa0@\xc1");
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

  if(!(isDefined(level.deathflags) && isDefined(level.deathflags[self.script_deathflag]))) {
    waittillframeend();

    if(!isDefined(self)) {
      return;
    }
  }

  level.deathflags[deathflag]["\x1c\x91\b\x15^\x82\x84\xf8"][ai_number] = self;
  self waittill("\x1e\xfd\xd1\xa2\a");
  level.deathflags[deathflag]["\x1c\x91\b\x15^\x82\x84\xf8"][ai_number] = undefined;
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
  level.deathflags[self.script_deathflag]["\x80\xcawu\xdbN\xd6*"][self.spawner_number] = self;
  deathflag = self.script_deathflag;
  id = self.spawner_number;
  spawn_guys_until_death_or_no_count();
  level.deathflags[deathflag]["\x80\xcawu\xdbN\xd6*"][id] = undefined;
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
  level.deathflags[self.script_deathflag]["\xde\x9f\xfa\xf3m\xf2\xd6\xd8lY\xa3\xb0\xb2~\xd1\xc5"][self.spawner_number] = self;
  deathflag = self.script_deathflag;
  id = self.spawner_number;
  spawn_guys_until_death_or_no_count();
  level.deathflags[deathflag]["\xde\x9f\xfa\xf3m\xf2\xd6\xd8lY\xa3\xb0\xb2~\xd1\xc5"][id] = undefined;
  update_deathflag(deathflag);
}

function update_deathflag(deathflag) {
  level notify("WFU\x06Y\xe3\xa1\xc9O\x97\x05(sdUe\x13\xe5\xc4" + deathflag);
  level endon("WFU\x06Y\xe3\xa1\xc9O\x97\x05(sdUe\x13\xe5\xc4" + deathflag);
  waittillframeend();

  foreach(array in level.deathflags[deathflag]) {
    if(getarraykeys(array).size > 0) {
      return;
    }
  }

  utility::flag_set(deathflag);
}

function outdoor_think(trigger) {
  assert(trigger.spawnflags & 1 || trigger.spawnflags & 2 || trigger.spawnflags & 4, "<dev string:x9b>" + trigger.origin + "<dev string:xb2>");
  trigger endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    trigger waittill("\x91`\xb1\xe7T\x97>", guy);

    if(!isai(guy)) {
      continue;
    }

    guy thread utility_sp::ignore_triggers(0.15);
    guy utility::disable_cqbwalk();
  }
}

function indoor_think(trigger) {
  assert(trigger.spawnflags & 1 || trigger.spawnflags & 2 || trigger.spawnflags & 4, "<dev string:x102>" + trigger.origin + "<dev string:xb2>");
  trigger endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    trigger waittill("\x91`\xb1\xe7T\x97>", guy);

    if(!isai(guy)) {
      continue;
    }

    guy thread utility_sp::ignore_triggers(0.15);
    guy utility::enable_cqbwalk();
  }
}

function trigger_spawner(trigger) {
  assert(isDefined(trigger.target), "<dev string:x118>" + trigger.origin + "<dev string:x140>");
  trigger waittill("\x91`\xb1\xe7T\x97>");
  target = trigger.target;
  trigger utility::script_delay();
  spawners = utility::array_combine(getspawnerarray(target), vehicle_getspawnerarray(target), utility::getStructArray(target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc"));

  foreach(spawner in spawners) {
    if(spawner function_f3d9915ba1198db4()) {
      if(spawner function_27255b8fc4456e56()) {
        if(!isDefined(spawner.target)) {
          thread vehicle::vehicle_spawn(spawner);
        } else {
          spawner thread vehicle::spawn_vehicle_and_gopath();
        }

        continue;
      } else if(spawner function_3e69ab591edabde2()) {
        spawner thread vehicle::function_d42e3be1aa0671c2();
        continue;
      }
    }

    spawner thread utility_sp::spawn_ai();
  }
}

function function_f3d9915ba1198db4() {
  if(function_27255b8fc4456e56()) {
    return true;
  }

  if(function_3e69ab591edabde2()) {
    return true;
  }

  return false;
}

function function_27255b8fc4456e56() {
  return !isnonentspawner(self) && self.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e";
}

function function_3e69ab591edabde2() {
  return isstruct(self) && isDefined(self.script_vehicleref);
}

function trigger_spawner_reinforcement(trigger) {
  assert(isDefined(trigger.target), "<dev string:x118>" + trigger.origin + "<dev string:x166>");
  target = trigger.target;
  targetsreinforcement = 0;
  spawners = getspawnerarray(target);

  foreach(spawner in spawners) {
    if(!isDefined(spawner.target)) {
      continue;
    }

    reinforcement_spawner = getspawner(spawner.target, #targetname);

    if(!isDefined(reinforcement_spawner)) {
      if(!isDefined(spawner.script_linkto)) {
        continue;
      }

      reinforcement_spawner = getspawner(spawner.script_linkto, #script_linkname);

      if(!isDefined(reinforcement_spawner)) {
        reinforcement_spawner = spawner utility::get_linked_ent();
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

  assert(targetsreinforcement == 1, "<dev string:x197>");
  trigger waittill("\x91`\xb1\xe7T\x97>");
  trigger utility::script_delay();
  spawners = getspawnerarray(target);

  foreach(spawner in spawners) {
    spawner thread trigger_reinforcement_spawn_guys();
  }
}

function trigger_reinforcement_spawn_guys() {
  reinforcement = trigger_reinforcement_get_reinforcement_spawner();
  guy = utility_sp::spawn_ai();

  if(!isDefined(guy)) {
    self delete();

    if(isDefined(reinforcement)) {
      guy = reinforcement utility_sp::spawn_ai();
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

  guy waittill("\x1e\xfd\xd1\xa2\a");

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

    spawned = reinforcement utility_sp::spawn_ai();

    if(!isDefined(spawned)) {
      reinforcement delete();
      break;
    }

    spawned thread reincrement_count_if_deleted(reinforcement);
    spawned waittill("\x1e\xfd\xd1\xa2\a", attacker);

    if(!player_saw_kill(spawned, attacker)) {
      println("<dev string:x23e>");

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

    if(!utility::script_wait()) {
      wait randomfloatrange(1, 3);
    }
  }

  if(isDefined(reinforcement)) {
    reinforcement delete();
  }
}

function trigger_reinforcement_get_reinforcement_spawner() {
  if(isDefined(self.target)) {
    reinforcement = getspawner(self.target, #targetname);

    if(isDefined(reinforcement) && isspawner(reinforcement)) {
      return reinforcement;
    }
  }

  if(isDefined(self.script_linkto)) {
    reinforcement = getspawner(self.script_linkto, #script_linkname);

    if(!isDefined(reinforcement)) {
      reinforcement = utility::get_linked_ent();
    }

    if(isDefined(reinforcement) && isspawner(reinforcement)) {
      return reinforcement;
    }
  }

  return undefined;
}

function flood_spawner_scripted(spawners) {
  assert(isDefined(spawners) && spawners.size, "<dev string:x278>");
  utility::array_thread(spawners, &flood_spawner_init);
  utility::array_thread(spawners, &flood_spawner_think);
}

function reincrement_count_if_deleted(spawner) {
  spawner endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.script_force_count)) {
    if(self.script_force_count) {
      return;
    }
  }

  self waittill("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self)) {
    spawner.count++;
  }
}

function kill_spawner(trigger) {
  killspawnernum = trigger.script_killspawner;
  trigger waittill("\x91`\xb1\xe7T\x97>");
  waittillframeend();
  waittillframeend();
  killspawner(killspawnernum);
  kill_trigger(trigger);
}

function killspawner(killspawnernum) {
  println("<dev string:x2ac>" + killspawnernum);
  actor_spawners = getspawnerarray();
  vehicle_spawners = vehicle_getspawnerarray();
  spawners = utility::array_combine(actor_spawners, vehicle_spawners);

  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].script_killspawner) && killspawnernum == spawners[i].script_killspawner) {
      if(isnonentspawner(spawners[i])) {
        spawners[i] notify("\x1e\xfd\xd1\xa2\a");
      }

      spawners[i] delete();
    }
  }
}

function kill_trigger(trigger) {
  if(!isDefined(trigger)) {
    return;
  }

  if(isDefined(trigger.targetname) && trigger.targetname != "\xde\xc7#\xba\xf9\xa10Ik\xb0\xbb\xc5Y") {
    return;
  }

  trigger delete();
}

function random_killspawner(trigger) {
  trigger endon("\x1e\xfd\xd1\xa2\a");
  random_killspawner = trigger.script_random_killspawner;
  waittillframeend();

  if(!isDefined(level.killspawn_groups)) {
    level.killspawn_groups = [];
  }

  if(!isDefined(level.killspawn_groups[random_killspawner])) {
    return;
  }

  trigger waittill("\x91`\xb1\xe7T\x97>");
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

  save_key = utility::random(keys);
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
  trigger waittill("\x91`\xb1\xe7T\x97>");
  spawners = getspawnerarray();

  for(i = 0; i < spawners.size; i++) {
    if(!isDefined(spawners[i].script_emptyspawner)) {
      continue;
    }

    if(emptyspawner != spawners[i].script_emptyspawner) {
      continue;
    }

    spawners[i] utility_sp::set_count(0);
    spawners[i] notify("\xce!.\x13*v\x1e\x15\xfa\xc7\xbd\x17\xf4\xc8\x9b");
  }

  trigger notify("by\xb3\xda8\aS\xcet>i\xcd\xb4\xf1~\x96");
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
  grenade = spawn("\xb7l\x1b\xf4]l\x86?>\x0f\xad", origin);
  grenade thread add_to_grenade_cache(team);
  return grenade;
}

function add_to_grenade_cache(team) {
  if(!(isDefined(level.grenade_cache) && isDefined(level.grenade_cache[team]))) {
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
  drone_base::drone_init_path();
}

function fakeactorspawner_init() {
  fakeactor::fakeactor_spawner_init();
}

function spawn_prethink() {
  assert(self != level);
  level.ai_classname_in_level[self.classname] = 1;

  if(getDvar(@ "noai", "<dev string:x2c5>") != "<dev string:x2c5>") {
    utility_sp::set_count(0);
    return;
  }

  if(isDefined(self.script_difficulty)) {
    switch (self.script_difficulty) {
      case #"hash_22ce4003c1e5227b":
        if(level.gameskill > 1) {
          utility_sp::set_count(0);
        }

        break;
      case #"hash_cc9157548a55043c":
        if(level.gameskill < 2) {
          utility_sp::set_count(0);
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
    self waittill("\xcb!f\x94\xa0@\xc1", spawned);

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

  if(isDefined(self.asmname) && self.asmname == "r\x16W\xd7@~") {
    return;
  }

  spawn_think_action(targetname);
  assert(isalive(self));
  self endon("\x1e\xfd\xd1\xa2\a");

  if(shouldnt_spawn_because_of_script_difficulty()) {
    self delete();
    assert(0, "<dev string:x2cc>");
  }

  thread run_spawn_functions();
  self.finished_spawning = 1;
  self notify("\xc2\xe9\xf6>\xe0\xe8\xea\x02\x8c\x8b|\xfa\x04\x99&\xd1;");
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
  team = isDefined(level.vehicle.spawn_functions_enable) && level.vehicle.spawn_functions_enable && self.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e" ? self.script_team : self.team;

  if(isDefined(team)) {
    for(i = 0; i < level.spawn_funcs[team].size; i++) {
      func = level.spawn_funcs[team][i];
      thread[[func["\xbc\xb1\xf1\xdff\xf7,\xd7"]]](flat_args(func["\x1dGU]\xc5\x1a"], func["wZ-\x10\"['OZ-9"]));
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
    thread[[func["\xbc\xb1\xf1\xdff\xf7,\xd7"]]](flat_args(func["\x1dGU]\xc5\x1a"], func["wZ-\x10\"['OZ-9"]));
  }

  self.var_1496d2a7c9b36047 = self.spawn_funcs;

  self.spawn_funcs = undefined;

  self.spawn_funcs = self.var_1496d2a7c9b36047;
  self.var_1496d2a7c9b36047 = undefined;

  if(!isDefined(self.script_suspend)) {
    self.spawner = undefined;
  }
}

function deathfunctions() {
  self waittill("\x1e\xfd\xd1\xa2\a", attacker, cause, objweapon);
  weapon = undefined;

  if(isDefined(objweapon)) {
    weapon = getcompleteweaponname(objweapon);
  }

  level notify("[G=mX\xeb\\\xd7\x05", self, attacker, cause, weapon);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(attacker)) {
    if(self.team == "?\xb1\xc0\x9a" || self.team == "\x8c\x1b\xab)\xd1") {
      killtype = undefined;

      if(isDefined(attacker.attacker)) {
        if(isDefined(attacker.issentrygun) && attacker.issentrygun) {
          killtype = " v\x05\xf1\".";
        }

        if(isDefined(attacker.destructible_type)) {
          killtype = "\\\x0f\xd7\xc6\xab\xb7^\xa2\xf0\xdb\x159";
        }

        attacker = attacker.attacker;
      } else if(isDefined(attacker.owner)) {
        if(isai(attacker) && isPlayer(attacker.owner)) {
          killtype = "\x1df@>\x87t\x93\x05";
        }

        attacker = attacker.owner;
      } else if(isDefined(attacker.damageowner)) {
        if(isDefined(attacker.destructible_type)) {
          killtype = "\\\x0f\xd7\xc6\xab\xb7^\xa2\xf0\xdb\x159";
        }

        attacker = attacker.damageowner;
      }

      validattacker = 0;

      if(isPlayer(attacker)) {
        validattacker = 1;
      }

      if(validattacker) {
        attacker.lastenemykilltime = gettime();
        attacker player_stats::register_kill(self, cause, weapon, killtype);
      }

      analytics::function_396a8a3375c65d3d(self, attacker, objweapon);
    }
  }
}

function ai_damage_think() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(!isDefined(self.damage_functions)) {
    self.damage_functions = [];
  }

  for(;;) {
    self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);
    self.paindamage = damage;

    if(isDefined(attacker)) {
      if(isPlayer(attacker)) {
        objcurrentweapon = attacker.currentweapon;

        if(isDefined(objcurrentweapon) && utility_sp::isprimaryweapon(objcurrentweapon) && isDefined(type) && (type == "\xd5_\xc1\xe1U\xf4\x06m\x0e\t\xc6e\xf4\x91\xdc\xd4\xf7" || type == "\xac6\xc1;\x9c|\xd5]5\x80\xcb~\xb5\xe7\xb4\xa1")) {
          attacker thread player_stats::register_shot_hit();

          if(self isbadguy()) {
            attacker.lastenemydmgtime = gettime();
          }

          if(isDefined(level.battlechatter) && isalive(self)) {
            function_99e8e66d1969d7cb(self, undefined, "\xe2\x97gu=Z3");
          }
        }
      } else if(attacker vehicle::is_vehicle()) {
        attacker notify("\xbeQn\xc1\x02\x98\x18\xe5\x83\xeb", self);
      }
    }

    if(getdvarint(@ "hash_81d89e4abec64203", 0) != 0) {
      dmg_data = [];
      dmg_data["<dev string:x2e5>"] = attacker;
      dmg_data["<dev string:x2f2>"] = damage;
      dmg_data["<dev string:x2fd>"] = type;
      dmg_data["<dev string:x30e>"] = point;
      dmg_data["<dev string:x318>"] = direction_vec;
      dmg_data["<dev string:x320>"] = objweapon;
      dmg_data["<dev string:x32d>"] = partname;
      debug::function_b06f81829199cfbd(dmg_data);
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
        utility::flag_init(goal.script_flag_set);
      }
    }

    if(isDefined(goal.script_flag_wait)) {
      if(!isDefined(level.flag[goal.script_flag_wait])) {
        utility::flag_init(goal.script_flag_wait);
      }
    }

    if(isDefined(goal.script_flag_clear)) {
      if(!isDefined(level.flag[goal.script_flag_clear])) {
        utility::flag_init(goal.script_flag_clear);
      }
    }

    if(isDefined(goal.script_flag_waitopen)) {
      if(!isDefined(level.flag[goal.script_flag_waitopen])) {
        utility::flag_init(goal.script_flag_waitopen);
      }
    }

    if(isDefined(goal.script_idle)) {
      if(!isDefined(level.idle_funcs)) {
        idle_sitting::main();
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
  self function_3f1eaca72db8edae("\xc0\xc6J", 1);
}

function spawn_team_axis() {
  checkboosttraversal();

  if(isDefined(self.script_combatmode)) {
    self.combatmode = self.script_combatmode;
  }

  if(getDvar(@ "hash_c3ae5b7542b15a78") == "<dev string:x339>") {
    self.combatmode = "<dev string:x339>";
    return;
  }

  if(getDvar(@ "hash_c3ae5b7542b15a78") == "<dev string:x343>") {
    self.combatmode = "<dev string:x343>";
  }
}

function checkboosttraversal() {
  var_b2ba92ede1e91d92["6\xbcXr"] = 1;
  var_b2ba92ede1e91d92["\x03\x7f\x1em\x8f\x10\xc2f"] = 1;
  var_b2ba92ede1e91d92["\xcd\xb7\x89{\xbd7t"] = 1;

  if(isDefined(self.subclass) && isDefined(var_b2ba92ede1e91d92[self.subclass])) {
    self enabletraversals(0, "V\x83\"-\xbd\xef\xef\x9e\xf4\x10+\xcf8");
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
  gameskill::default_door_node_flashbang_frequency();
  gameskill::grenadeawareness();
}

function function_c396a89d9f474d58() {
  if(getDvar(@ "debug_misstime") == "<dev string:x358>") {
    thread debug::debugmisstime();
  }

  thread show_bad_path();

  if(self.type == "<dev string:x361>") {
    assert(self.pathenemylookahead == 0 && self.pathenemyfightdist == 0, "<dev string:x36a>" + self.export);
  }
}

function spawn_think_action(targetname) {
  thread ai_damage_think();
  thread tanksquish();
  self function_e7da526eae08c9a8(&codecallback_actorkilled);

  if(!isDefined(level.ai_dont_glow_in_thermal)) {
    self thermaldrawenable();
  }

  self.spawner_number = undefined;

  if(!isDefined(self.unique_id)) {
    utility::set_ai_number();
    utility::function_3c5df5dd5528da95();
  }

  thread deathfunctions();
  level thread friendlyfire::friendly_fire_think(self);
  self.walkdist = 16;

  function_c396a89d9f474d58();

  init_reset_ai();
  spawn_think_game_skill_related();

  if(isDefined(self.spawner_object)) {
    ai::spawner_fields(self.spawner_object);
  } else {
    ai::spawner_fields(self);
  }

  thread loot::corpselootthink();

  if(getdvarint(@ "scr_heat") == 1) {
    utility_sp::enable_heat_behavior();
  }

  [[level.team_specific_spawn_functions[self.team]]]();

  if(isDefined(level.unittype_spawn_functions[self.unittype])) {
    self thread[[level.unittype_spawn_functions[self.unittype]]]();
  }

  if(isDefined(self.subclass) && isDefined(level.subclass_spawn_functions[self.subclass])) {
    self thread[[level.subclass_spawn_functions[self.subclass]]]();
  }

  if(self.team == "?\xb1\xc0\x9a") {
    thread utility_sp::add_damage_function(&damagefeedback::damagefeedback_took_damage);
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
      namespace_44096fb81ec0b367::main();
    }

    callbacks::stealth_call_thread("\x8c\xed\xaf\xe6\x1d\xac\xc2\xc6th");
    return;
  }

  if(isDefined(self.script_readystand) && self.script_readystand == 1) {
    utility_sp::enable_readystand();
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

  var_f3abc63ecba94836 = 1;

  if(isDefined(self.script_stealthgroup)) {
    var_f3abc63ecba94836 = 0;
  }

  if(var_f3abc63ecba94836) {
    defaultgoalradius = 4;

    if(isDefined(self.aisettings) && istrue(self.aisettings.var_cb4d2dae97389ed6)) {
      defaultgoalradius = self.aisettings.goalradius;
    }

    assert(self.goalradius == defaultgoalradius, "<dev string:x3df>" + self.export+"<dev string:x40d>");
  }

  set_goal_from_settings();

  if(isDefined(self.target)) {
    thread go_to_node();
  }
}

function codecallback_actorkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration) {
  if(isDefined(level.weaponmapfunc)) {
    objweapon = [[level.weaponmapfunc]](objweapon, einflictor);
  }

  params = {
    #deathanimduration: deathanimduration, #timeoffset: timeoffset, #shitloc: shitloc, #vdir: vdir, #objweapon: objweapon, #smeansofdeath: smeansofdeath, #idflags: idflags, #idamage: idamage, #eattacker: eattacker, #einflictor: einflictor
  };
  callback::callback(#"on_ai_killed", params);
}

function init_reset_ai() {
  if(!isDefined(self.var_a80c7aea6e094817) || self.var_a80c7aea6e094817) {
    utility_sp::set_default_pathenemy_settings();
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
  if(self.team == "\xba\xa5\x1f\xc9m\x80i") {
    self setthreatbiasgroup("75\xffQ\x95\xfe`\x9a");
  } else {
    self setthreatbiasgroup(self.team);
  }

  init_reset_ai();
  self.baseaccuracy = 1;
  gameskill::grenadeawareness();
  utility_sp::clear_force_color();
  self.interval = 96;
  self.disablearrivals = 0;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.threatbias = 0;
  self.pacifist = 0;
  self.pacifistwait = 20;
  self.ignorerandombulletdamage = 0;
  self.pushable = 1;
  val::nuke("T\xbf\x84KN\xc6\xc9\x97mk\xd33\xa9\xb4\xf5");
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
    ai::stop_magic_bullet_shield();
  }

  utility_sp::disable_replace_on_death();
  self.maxsightdistsqrd = 67108864;
  self.script_forcegrenade = 0;
  self.walkdist = 16;
  init::set_anim_playback_rate();
  self.fixednode = self.team == "O\x15\x1b\xad\x9ff";
}

function delayed_player_seek_think(spawned) {
  spawned endon("\x1e\xfd\xd1\xa2\a");

  while(isalive(spawned)) {
    if(spawned.goalradius > 200) {
      spawned.goalradius -= 200;
    }

    wait 6;
  }
}

function get_target_goals(target) {
  goals = getnodearray(target, #targetname);
  new_goals = utility::getStructArray(target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

  foreach(new in new_goals) {
    goals[goals.size] = new;
  }

  new_goals = getEntArray(target, #targetname);

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

function go_to_node(nodes, optional_arrived_at_node_func, var_c5db161e30500c74, var_8393242ee7c0face) {
  if(!isDefined(nodes)) {
    nodes = [];

    if(isDefined(self.target)) {
      nodes = get_target_goals(self.target);
    }

    if(nodes.size == 0) {
      self notify("\x05[\xf8\x84\x04\x06\x01:p\x01\xde\x10\xcc\xb3\xb0\xf8");
      return;
    }
  } else if(!isarray(nodes)) {
    nodes = [nodes];
  }

  go_to_node_internal(nodes, optional_arrived_at_node_func, var_c5db161e30500c74, var_8393242ee7c0face);
}

function get_least_used_from_array(array) {
  if(array.size == 1) {
    return array[0];
  }

  array = utility::array_randomize(array);
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

function go_to_node_internal(node, optional_arrived_at_node_func, var_c5db161e30500c74, var_8393242ee7c0face) {
  self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  self endon("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isarray(node)) {
    node = [node];
  }

  if(isDefined(var_8393242ee7c0face)) {
    startnode = var_8393242ee7c0face;
  } else {
    startnode = node[0];
  }

  thread go_to_node_end();
  usingpatharray = 0;
  patharray = undefined;
  self.interactionplayed = undefined;

  for(;;) {
    if(!usingpatharray) {
      if(isDefined(level.var_2b12846e16c704a6)) {
        node = [[level.var_2b12846e16c704a6]](node);
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
      go_through_patharray(patharray, optional_arrived_at_node_func, var_c5db161e30500c74);
      patharray = undefined;
      usingpatharray = 0;
    } else {
      node_fields_pre_goal(node);

      if(isDefined(self.stealth)) {
        callbacks::stealth_call("\x90O\x19\xb7+D\x98\nk\x9d\xc6\x0f\x9c\xb8\xc0", &go_to_node_set_goal, node);
      } else {
        go_to_node_set_goal(node);
        self waittill("\x83\xd6\xaf\x11");
      }
    }

    node notify("\x91`\xb1\xe7T\x97>", self);
    node_fields_after_goal(node, optional_arrived_at_node_func);
    interactionid = self getinteractionid();

    if(isDefined(interactionid)) {
      self waittill("\xa4\xc8\xbas\x90\x8b\xbe\xd1\xef<R\xda\xc4\xe3\x9b\x9f\x0f");
    } else if(!isDefined(node.interactionid) && !isDefined(node.interaction)) {
      node utility::script_delay();
    }

    if(isDefined(node.script_flag_wait)) {
      utility::flag_wait(node.script_flag_wait);
    }

    if(isDefined(node.script_flag_waitopen)) {
      utility::flag_waitopen(node.script_flag_waitopen);
    }

    if(isDefined(node.script_ent_flag_wait)) {
      utility::ent_flag_wait(node.script_ent_flag_wait);
    }

    if(isDefined(node.var_77b4c962f32faca4)) {
      utility::function_18e9f1084badc1c7(node.var_77b4c962f32faca4);
    }

    node utility::script_wait();
    node_fields_after_goal_and_wait(node, var_c5db161e30500c74);

    if(!isDefined(node.target)) {
      break;
    }

    nextnode_array = get_target_goals(node.target);

    if(!nextnode_array.size) {
      break;
    }

    node = nextnode_array;
  }

  self notify("\x05[\xf8\x84\x04\x06\x01:p\x01\xde\x10\xcc\xb3\xb0\xf8");

  if(isDefined(self.script_forcegoal)) {
    return;
  }

  volume = self getgoalvolume();

  if(isDefined(volume)) {
    self setgoalvolumeauto(volume, volume ai::get_cover_volume_forward());
    return;
  }

  self.goalradius = level.default_goalradius;
}

function go_through_patharray(patharray, optional_arrived_at_node_func, var_c5db161e30500c74) {
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
      self waittill("\x83\xd6\xaf\x11");
      break;
    }

    tempnode notify("\x91`\xb1\xe7T\x97>", self);
    function_8becbe0929ac9af9(tempnode, optional_arrived_at_node_func);
    node_fields_after_goal_and_wait(tempnode, var_c5db161e30500c74);
  }
}

function waittill_subgoal() {
  self endon("\x83\xd6\xaf\x11");
  self waittill("*\b\x9d\xa7\xb0\")", index);
  return index;
}

function get_path_array(node, startnode) {
  array = [];
  count = 0;

  while(true) {
    if(node.code_classname == "\xfd-\xfa\xf5\xa30}W{}\xe8") {
      break;
    }

    array[array.size] = node;
    count++;

    if(count == 16) {
      break;
    }

    if(!istrue(node.var_8b853f34c6e126ab)) {
      if(isDefined(node.target)) {
        node.interactionid = function_9b8762cacba95878(node.target);
        node.interactionidarray = function_45e11756d25962ef(node.target);
      }

      node.var_8b853f34c6e126ab = 1;
    }

    if(isDefined(node.interactionid)) {
      break;
    }

    if(go_to_node_should_stop(node)) {
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

    if(isDefined(level.var_2b12846e16c704a6)) {
      node = [[level.var_2b12846e16c704a6]](nextnode_array);
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
    if(node.script_demeanor == "\x15'\xa3") {
      utility::enable_cqbwalk();
    } else {
      utility::demeanor_override(node.script_demeanor);
    }
  }

  if(isDefined(node.script_civilian_state)) {
    asm_bb::bb_setcivilianstate(node.script_civilian_state);
  }

  if(isDefined(node.script_pacifist)) {
    self.pacifist = node.script_pacifist;
  }

  if(isDefined(node.script_ignoreall)) {
    ai::set_ignoreall(node.script_ignoreall);
  }

  if(isDefined(node.script_ignoreme)) {
    ai::set_ignoreme(node.script_ignoreme);
  }

  if(isDefined(node.script_moveplaybackrate)) {
    utility_sp::set_moveplaybackrate(node.script_moveplaybackrate, 0.25);
  }

  if(isDefined(node.script_speed)) {
    utility::set_movement_speed(node.script_speed);
  }

  if(isDefined(node.script_gunpose)) {
    ai::set_gunpose(node.script_gunpose);
  }

  if(isDefined(node.script_disable_arrivals)) {
    if(node.script_disable_arrivals) {
      ai::disable_arrivals();
    } else {
      self.disablearrivals = 0;
    }
  }

  if(isDefined(node.script_disable_exits)) {
    if(node.script_disable_exits) {
      ai::disable_exits();
    } else {
      ai::enable_exits();
    }
  }

  if(isDefined(node.script_combatmode)) {
    self.combatmode = node.script_combatmode;
  }

  if(isDefined(node.script_forcegoal)) {
    assert(isDefined(node.targetname));
    self.target = node.targetname;
  }

  if(isDefined(self.var_38657d1d278556be)) {
    thread[[self.var_38657d1d278556be]]();
  }

  if(isDefined(node.script_scenescriptbundle)) {
    if(isDefined(level.scene) && isDefined(level.scene.fnsceneplay)) {
      node[[level.scene.fnsceneplay]]([self]);
    }
  }
}

function node_fields_after_goal(node, optional_arrived_at_node_func, var_eda96cb83dc40c79) {
  if(isDefined(self.stealth)) {
    callbacks::stealth_call("\x03\xbe\xf5\xb6\x1b\xb2\x8f\xce\x18\xb13\t\xf0Zac\x12", &go_to_node_set_goal, node);
  }

  if(!istrue(var_eda96cb83dc40c79)) {
    if(isDefined(node.interactionid) || isDefined(node.interaction)) {
      node utility::script_delay();
      ai::function_a52e9bdfd4dfc597(&go_to_node_set_goal, node);
    } else {
      go_to_node_set_goal();
      self waittill("\x83\xd6\xaf\x11");
    }
  }

  if(isDefined(optional_arrived_at_node_func)) {
    [[optional_arrived_at_node_func]](node);
  }

  if(isDefined(self.var_befb7dfb46c33b30)) {
    [[self.var_befb7dfb46c33b30]](node);
  }

  if(isDefined(node.script_flag_set)) {
    utility::flag_set(node.script_flag_set);
  }

  if(isDefined(node.script_ent_flag_set)) {
    utility::ent_flag_set(node.script_ent_flag_set);
  }

  if(isDefined(node.script_ent_flag_clear)) {
    utility::ent_flag_clear(node.script_ent_flag_clear);
  }

  if(isDefined(node.script_flag_clear)) {
    utility::flag_clear(node.script_flag_clear);
  }

  if(targets_and_uses_turret(node)) {
    return 1;
  }
}

function function_8becbe0929ac9af9(node, optional_arrived_at_node_func) {
  node_fields_after_goal(node, optional_arrived_at_node_func, 1);
}

function node_fields_after_goal_and_wait(node, var_c5db161e30500c74) {
  if(isDefined(node.script_soundalias)) {
    self playSound(node.script_soundalias);
  }

  if(isDefined(node.script_gesture)) {
    thread utility_sp::gesture_simple(node.script_gesture);
  }

  if(isDefined(self.stealth)) {
    callbacks::stealth_call("Yz\xd7\xea\xbf?-\x10\x06\x86\x03\xc0\x04\xbd\xf3\xc1\x83;\xbd5", &go_to_node_set_goal, node);
  }

  if(isDefined(self.post_wait_func)) {
    [[self.post_wait_func]](node);
  }

  if(isDefined(node.script_delay_post)) {
    wait node.script_delay_post;
  }

  while(isDefined(node.script_requires_player)) {
    if(go_to_node_wait_for_player(node, &get_target_goals)) {
      node notify("P\x85\xb3\x04>\x8d\xd8}\x1c2\x90N\xb5\xe2E\x12\xe34\x82\x19\x0f\xee");
      break;
    }

    wait 0.1;
  }

  if(isDefined(node.script_demeanor_post)) {
    if(node.script_demeanor_post == "\x15'\xa3") {
      utility::enable_cqbwalk();
    } else {
      utility::demeanor_override(node.script_demeanor_post);
    }
  }

  if(isDefined(var_c5db161e30500c74)) {
    [[var_c5db161e30500c74]](node);
  }

  if(istrue(node.script_death)) {
    utility_sp::die();
  }

  if(istrue(node.script_delete)) {
    if(istrue(node.script_nosight)) {
      level thread utility_sp::ai_delete_when_out_of_sight([self], 350);
      return;
    }

    if(isDefined(self.magic_bullet_shield)) {
      ai::stop_magic_bullet_shield();
    }

    self delete();
  }
}

function go_to_node_end() {
  self endon("\x1e\xfd\xd1\xa2\a");
  waittillframeend();
  self.using_goto_node = 1;
  utility::waittill_any("\x05[\xf8\x84\x04\x06\x01:p\x01\xde\x10\xcc\xb3\xb0\xf8", "\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
  thread function_d15199611f6c1189();
}

function function_d15199611f6c1189() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.currentnode.interactionid) && isDefined(self.currentnode) && isDefined(self.currentnode.interaction)) {
    if(isDefined(self getinteractionid())) {
      self waittill("\xa4\xc8\xbas\x90\x8b\xbe\xd1\xef<R\xda\xc4\xe3\x9b\x9f\x0f");
    }

    if(isDefined(self.currentnode.interactionid)) {
      despawninteraction(self.currentnode.interactionid);
      self.currentnode.interactionid = undefined;
    }
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

  if(isDefined(arrivaltarget.script_scenescriptbundle)) {
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
  if(ent.code_classname == "\xfd-\xfa\xf5\xa30}W{}\xe8") {
    self setgoalvolumeauto(ent, ent ai::get_cover_volume_forward());
    self notify("\xce\xbd\xf5\xa3o\xfa\x9b\xdb\xc8\xac\xeb\xcde\xbb\xfa\xec\xbda6");
    return;
  }

  go_to_node_set_goal_pos(ent);
}

function go_to_node_set_goal_pos(ent) {
  utility_sp::set_goal_ent(ent);
  self notify("\xce\xbd\xf5\xa3o\xfa\x9b\xdb\xc8\xac\xeb\xcde\xbb\xfa\xec\xbda6");
}

function go_to_node_set_goal_node(node) {
  utility_sp::set_goal_node(node);
  self notify("\xce\xbd\xf5\xa3o\xfa\x9b\xdb\xc8\xac\xeb\xcde\xbb\xfa\xec\xbda6");
}

function targets_and_uses_turret(node) {
  if(!isDefined(node.target)) {
    return false;
  }

  turrets = getEntArray(node.target, #targetname);

  if(!turrets.size) {
    return false;
  }

  turret = turrets[0];

  if(!issubstr(turret.classname, "?\x96%o2\x88V\xd4\x98\a\xdc")) {
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
    if(self.unittype == "\xab\xbf\xbe\xe2\xcdvJ\x14/c") {
      return;
    }

    if(self.type == "75\xffQ\x95\xfe`\x9a") {
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
      self settargetentity(utility::random(targets));
      self notify("gQ\xe9\xa5D\xce\xe0 \xc6\xdd\xb5");
      self startfiring();
    }

    wait 2 + randomfloat(1);
  }
}

function manualtarget(targets) {
  for(;;) {
    self settargetentity(utility::random(targets));
    self notify("gQ\xe9\xa5D\xce\xe0 \xc6\xdd\xb5");
    self startfiring();
    wait 2 + randomfloat(1);
  }
}

function use_a_turret(turret) {
  self endon("-Rg\x8a\x91\x9b^\x9a\xf1\xe9jw\xf3\xed\x83\xe1\xa9");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(self isbadguy() && self.health == 150) {
    self.health = 100;
    self.allowlongdeath = 0;
  }

  asm_bb::bb_requestturret(turret);

  while(!isDefined(self getturret()) || self getturret() != turret) {
    wait 0.05;
  }

  if(isDefined(turret.target) && turret.target != turret.targetname) {
    ents = getEntArray(turret.target, #targetname);
    targets = [];

    for(i = 0; i < ents.size; i++) {
      if(ents[i].classname == "\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc") {
        targets[targets.size] = ents[i];
      }
    }

    if(isDefined(turret.script_autotarget)) {
      turret thread autotarget(targets);
    } else if(isDefined(turret.script_manualtarget)) {
      turret setmode("\xc1w\x05\xf01z'f\xe6");
      turret thread manualtarget(targets);
    } else if(targets.size > 0) {
      if(targets.size == 1) {
        turret.manual_target = targets[0];
        turret settargetentity(targets[0]);
        thread mgturret::manual_think(turret);
      } else {
        turret thread mgturret::mg42_suppressionfire(targets);
      }
    }
  }

  thread player_use_turret_watcher(turret);
  thread mgturret::mg42_firing(turret);
  turret notify("gQ\xe9\xa5D\xce\xe0 \xc6\xdd\xb5");
}

function player_use_turret_watcher(turret) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(self.team != "O\x15\x1b\xad\x9ff") {
    return;
  }

  trigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", turret.origin, 0, 56, 56);
  thread utility::delete_on_death(trigger);
  shouldbreak = 0;

  while(!shouldbreak) {
    trigger waittill("\x91`\xb1\xe7T\x97>");

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
  self notify("-Rg\x8a\x91\x9b^\x9a\xf1\xe9jw\xf3\xed\x83\xe1\xa9");
  self notify("?\x96\xd1\xf5\xe7\a1\x14\x99\xb8P\x9d\xfc@\xfa\xdb\xbe8\xb9\xaa]\x193:\x1b%\x83\x8b\xf5\x81");
  turret = self getturret();

  if(!isDefined(turret)) {
    return;
  }

  self stopuseturret();
  asm_bb::bb_requestturret(undefined);
  self stopanimScripted();
  turret stopfiring();
}

function friendly_mgturret(trigger) {
  if(!isDefined(trigger.target)) {
    utility::error("<dev string:x4dc>" + trigger getorigin());
  }

  node = getnode(trigger.target, #targetname);

  if(!isDefined(node.target)) {
    utility::error("<dev string:x50c>" + node.origin);
  }

  mg42 = getEnt(node.target, #targetname);
  mg42 setmode("m\xbbwc0\xe3\b");
  mg42 cleartargetentity();
  in_use = 0;

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);

    if(!isai(other)) {
      continue;
    }

    if(!isDefined(other.team)) {
      continue;
    }

    if(other.team != "O\x15\x1b\xad\x9ff") {
      continue;
    }

    if(isDefined(other.script_usemg42) && other.script_usemg42 == 0) {
      continue;
    }

    if(other thread friendly_mg42_useable(mg42, node)) {
      other thread friendly_mg42_think(mg42, node);
      mg42 waittill("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");

      if(isalive(other)) {
        other.turret_use_time = gettime() + 10000;
      }
    }

    wait 1;
  }
}

function friendly_mg42_death_notify(guy, mg42) {
  mg42 endon("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
  guy waittill("\x1e\xfd\xd1\xa2\a");
  mg42 notify("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
}

function friendly_mg42_wait_for_use(mg42) {
  mg42 endon("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
  self.useable = 1;
  self setCursorHint("\xda\xc1Tx]8\xc1y1\x1fe");
  self setHintString(&"platform_useaionmg42");
  self waittill("\x91`\xb1\xe7T\x97>");
  self.useable = 0;
  self setHintString("");
  self stopuseturret();
  self notify("v.P\x0f\xbb\x7f\x86d5N\x7f\xcd\r\x13\xe2~\xc6l");
  mg42 notify("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
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
  mg42 endon("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
  self waittill("\x91`\xb1\xe7T\x97>");
  mg42 notify("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
}

function nofour() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x83\xd6\xaf\x11");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32) {
    self.goalradius = 400;
  }
}

function friendly_mg42_think(mg42, node) {
  self endon("\x1e\xfd\xd1\xa2\a");
  mg42 endon("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
  level thread friendly_mg42_death_notify(self, mg42);
  self.oldradius = self.goalradius;
  self.goalradius = 28;
  thread nofour();
  self setgoalnode(node);
  self.ignoresuppression = 1;
  self waittill("\x83\xd6\xaf\x11");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32) {
    self.goalradius = 400;
  }

  self.ignoresuppression = 0;
  self.goalradius = self.oldradius;

  if(distance(level.player.origin, node.origin) < 32) {
    mg42 notify("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
    return;
  }

  self.friendly_mg42 = mg42;
  thread friendly_mg42_wait_for_use(mg42);
  thread friendly_mg42_cleanup(mg42);
  self useturret(mg42);

  if(isDefined(mg42.target)) {
    stoptrigger = getEnt(mg42.target, #targetname);

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

  mg42 notify("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
}

function friendly_mg42_cleanup(mg42) {
  self endon("\x1e\xfd\xd1\xa2\a");
  mg42 waittill("\xc3d\xe8\xbe\a\xe6\xf0\v\x96\x8e\xfa\xe2\xb3\xb5\xb6\xc4a>\x06\xd4b\xdc\x83\xefwp\xdd\x83");
  friendly_mg42_doneusingturret();
}

function friendly_mg42_doneusingturret() {
  self endon("\x1e\xfd\xd1\xa2\a");
  turret = self.friendly_mg42;
  self.friendly_mg42 = undefined;
  self stopuseturret();
  self notify("v.P\x0f\xbb\x7f\x86d5N\x7f\xcd\r\x13\xe2~\xc6l");
  self.useable = 0;
  self.goalradius = self.oldradius;

  if(!isDefined(turret)) {
    return;
  }

  if(!isDefined(turret.target)) {
    return;
  }

  node = getnode(turret.target, #targetname);
  oldradius = self.goalradius;
  self.goalradius = 8;
  self setgoalnode(node);
  wait 2;
  self.goalradius = 384;
}

function tanksquish() {
  if(isDefined(level.notanksquish)) {
    assert(level.notanksquish, "<dev string:x542>");
    return;
  }

  if(isDefined(level.vehicle.has_vehicles) && !level.vehicle.has_vehicles) {
    return;
  }

  utility_sp::add_damage_function(&tanksquish_damage_check);
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

  if(who vehicle::ishelicopter()) {
    return;
  }

  if(!isDefined(self.noragdoll)) {
    if(isDefined(self.fnpreragdoll)) {
      self[[self.fnpreragdoll]]();
    }

    if(soundexists("\xa7y\xe1\r\x91A\x1b\xf2\xcc\x86$\xd6 c\xf58")) {
      self playSound("\xecY\x1a-\x1b\x1b\xac\xfa1\xb7\xc8\xf2\xaf\x86\xb4:}\x9b\xe0");
    }

    self startragdoll();
  }

  if(!isDefined(self)) {
    return;
  }

  utility_sp::remove_damage_function(&tanksquish_damage_check);
}

function flood_and_secure(instantrespawn) {
  if(!isDefined(instantrespawn)) {
    instantrespawn = 0;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "\xebu_\x1aX\x11\xedr\xf4.\x12\\\xaa\xa0\xd7") {
    instantrespawn = 1;
  }

  level.spawnerwave = [];
  spawners = getspawnerarray(self.target);
  utility::array_thread(spawners, &flood_and_secure_spawner, instantrespawn);
  playertriggered = 0;
  diddelay = 0;

  for(;;) {
    self waittill("\x91`\xb1\xe7T\x97>", other);

    if(!diddelay) {
      diddelay = 1;
      utility::script_delay();
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
      spawners[i] notify("\x84\x97\xd0\x92\xfd0<\xc1\xc14N");
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
    println("<dev string:x572>" + self.classname + "<dev string:x57d>" + self.origin + "<dev string:x58c>");
    waittillframeend();
    assert(isDefined(target));
  }

  spawners = [];

  if(isDefined(target)) {
    possiblespawners = getspawnerarray(target);

    for(i = 0; i < possiblespawners.size; i++) {
      if(!issubstr(possiblespawners[i].classname, "\x06`\xb6y[")) {
        continue;
      }

      spawners[spawners.size] = possiblespawners[i];
    }
  }

  ent = spawnStruct();
  org = self.origin;
  flood_and_secure_spawner_think(ent, spawners.size > 0, instantrespawn);

  if(isalive(ent.ai)) {
    ent.ai waittill("\x1e\xfd\xd1\xa2\a");
  }

  if(!isDefined(target)) {
    return;
  }

  possiblespawners = getspawnerarray(target);

  if(!possiblespawners.size) {
    return;
  }

  for(i = 0; i < possiblespawners.size; i++) {
    if(!issubstr(possiblespawners[i].classname, "\x06`\xb6y[")) {
      continue;
    }

    possiblespawners[i].targetname = targetname;
    newtarget = target;

    if(isDefined(possiblespawners[i].target)) {
      targetent = getspawner(possiblespawners[i].target, #targetname);

      if(!isDefined(targetent) || !issubstr(targetent.classname, "\x06`\xb6y[")) {
        newtarget = possiblespawners[i].target;
      }
    }

    possiblespawners[i].target = newtarget;
    possiblespawners[i] thread flood_and_secure_spawner(instantrespawn);
    possiblespawners[i].playertriggered = 1;
    possiblespawners[i] notify("\x84\x97\xd0\x92\xfd0<\xc1\xc14N");
  }
}

function flood_and_secure_spawner_think(ent, oneshot, instantrespawn) {
  assert(isDefined(instantrespawn));
  self endon("\x1e\xfd\xd1\xa2\a");
  count = self.count;

  if(!oneshot) {
    oneshot = isDefined(self.script_noteworthy) && self.script_noteworthy == "e\x16\x156A\xb7";
  }

  utility_sp::set_count(2);
  assert(!isDefined(self.script_suspend), "<dev string:x59e>");

  if(isDefined(self.script_delay)) {
    delay = self.script_delay;
  } else {
    delay = 0;
  }

  for(;;) {
    self waittill("\x84\x97\xd0\x92\xfd0<\xc1\xc14N");

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
    utility_sp::set_count(2);
    wait delay;
    spawn = utility_sp::spawn_ai();

    if(ai::spawn_failed(spawn)) {
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
      ent notify("U\x18#\x9a\xf3\xf7");
      self waittill("\x15x\x14\ah\xe5?\x8cT/", deleted, playerkill);

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
  self endon("\x1e\xfd\xd1\xa2\a");
  spawn waittill("\x1e\xfd\xd1\xa2\a");
}

function addtowavespawner(spawn) {
  name = self.targetname;

  if(!isDefined(level.spawnerwave[name])) {
    level.spawnerwave[name] = spawnStruct();
    level.spawnerwave[name] utility_sp::set_count(0);
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
      level.spawnerwave[name] notify("\xa3jv\xe1\x1a\nB^\x03");
    }
  }
}

function waituntilwaverelease() {
  name = self.targetname;

  if(level.spawnerwave[name].count) {
    level.spawnerwave[name] waittill("\xa3jv\xe1\x1a\nB^\x03");
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

  return trace::_bullet_trace_passed(level.player getEye(), ai getEye(), 0, undefined);
}

function waittillrestartordistance(dist) {
  self endon("\x84\x97\xd0\x92\xfd0<\xc1\xc14N");
  dist *= 0.75;

  while(distance(level.player.origin, self.origin) > dist) {
    wait 1;
  }
}

function flood_and_secure_spawn(spawner) {
  thread flood_and_secure_spawn_goal();
  self waittill("\x1e\xfd\xd1\xa2\a", other);
  playerkill = isalive(other) && isPlayer(other);

  if(!playerkill && isDefined(other) && other.classname == "\x98\xed\xee\xfc\x05\xabV\v\x96x") {
    playerkill = 1;
  }

  deleted = !isDefined(self);
  spawner notify("\x15x\x14\ah\xe5?\x8cT/", deleted, playerkill);
}

function flood_and_secure_spawn_goal() {
  if(isDefined(self.script_moveoverride)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  node = getnode(self.target, #targetname);

  if(isDefined(node)) {
    self setgoalnode(node);
  } else {
    node = getEnt(self.target, #targetname);

    if(isDefined(node)) {
      self setgoalpos(node.origin);
    }
  }

  assert(isDefined(node), "<dev string:x5da>");

  if(isDefined(level.fightdist)) {
    self.pathenemyfightdist = level.fightdist;
    self.pathenemylookahead = level.maxdist;
  }

  if(isDefined(node.radius) && node.radius >= 0) {
    self.goalradius = node.radius;
  } else {
    self.goalradius = 256;
  }

  self waittill("\x83\xd6\xaf\x11");

  while(isDefined(node.target)) {
    newnode = getnode(node.target, #targetname);

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

    self waittill("\x83\xd6\xaf\x11");
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "e\x16\x156A\xb7") {
      self kill();
      return;
    }
  }

  if(isDefined(node.target)) {
    turret = getEnt(node.target, #targetname);

    if(isDefined(turret) && turret.code_classname == "?\x96%o2\x88V\xd4\x98\a\xdc") {
      self setgoalnode(node);
      self.goalradius = 4;
      self waittill("\x83\xd6\xaf\x11");

      if(!isDefined(self.script_forcegoal)) {
        self.goalradius = level.default_goalradius;
      }

      use_a_turret(turret);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "\x19b\xc2y") {
      thread utility::set_battlechatter(0);
      return;
    }
  }

  if(!isDefined(self.script_forcegoal) && !isDefined(self getgoalvolume())) {
    self.goalradius = level.default_goalradius;
  }
}

function goalvolumes() {
  volumes = getEntArray("\xfd-\xfa\xf5\xa30}W{}\xe8", #classname);
  volumes = utility::array_combine(volumes, getEntArray("\x90b\xe9\xd3<e\xca\xd5{vMep\xc3\xed\xb8\x18", #classname));
  level.deathchain_goalvolume = [];
  level.goalvolumes = [];

  for(i = 0; i < volumes.size; i++) {
    volume = volumes[i];

    if(isDefined(volume.script_deathchain)) {
      level.deathchain_goalvolume[volume.script_deathchain] = volume;
    }

    if(isDefined(volume.script_goalvolume)) {
      assert(!isDefined(level.goalvolumes[volume.script_goalvolume]), "<dev string:x641>" + volume.script_goalvolume + "<dev string:x67a>");
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1bx\x16S^\xe7^6\x95\x98e\xf9\x8e\x13Y\xb9\x9b\x9a\xd13\xf8\xd6@\x14\xb7");
  self.decremented = 0;
  tracker.spawnercount++;
  tracker.spawners = utility::array_add(tracker.spawners, self);
  thread aigroup_spawnerdeath(tracker);
  thread aigroup_spawnerempty(tracker);
  self waittill("\xcb!f\x94\xa0@\xc1", soldier);

  if(!ai::spawn_failed(soldier)) {
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
  self notify("\x1bx\x16S^\xe7^6\x95\x98e\xf9\x8e\x13Y\xb9\x9b\x9a\xd13\xf8\xd6@\x14\xb7");
}

function aigroup_spawnerdeath(tracker) {
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self)) {
    aigroup_decrement(tracker);
  }
}

function aigroup_spawnerempty(tracker) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\xce!.\x13*v\x1e\x15\xfa\xc7\xbd\x17\xf4\xc8\x9b");
  aigroup_decrement(tracker);
}

function aigroup_soldierthink(tracker) {
  tracker.aicount++;
  tracker.ai[tracker.ai.size] = self;

  if(isDefined(self.script_deathflag_longdeath)) {
    ai::function_68188e96832ade88();
  } else {
    self waittill("\x1e\xfd\xd1\xa2\a");
  }

  tracker.aicount--;
  tracker.aideaths++;
}

function camper_trigger_think(trigger) {
  tokens = strtok(trigger.script_linkto, "\xda");
  spawners = [];
  nodes = [];

  for(i = 0; i < tokens.size; i++) {
    token = tokens[i];
    ai = getspawner(token, #script_linkname);

    if(isDefined(ai)) {
      spawners = utility::array_add_safe(spawners, ai);
      continue;
    }

    node = getnode(token, #script_linkname);

    if(!isDefined(node)) {
      println("<dev string:x6ef>" + token + "<dev string:x711>");
      continue;
    }

    nodes = utility::array_add_safe(nodes, node);
  }

  assert(spawners.size, "<dev string:x724>");
  assert(nodes.size, "<dev string:x756>");
  assert(nodes.size >= spawners.size, "<dev string:x785>");
  trigger waittill("\x91`\xb1\xe7T\x97>");
  nodes = utility::array_randomize(nodes);

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

    while(isDefined(nodes[j].script_noteworthy) && nodes[j].script_noteworthy == "\xbf\xc2ZvO'\x04\xf1\xf3\x86") {
      j++;
    }

    spawner.origin = nodes[j].origin;
    spawner.angles = nodes[j].angles;
    spawner utility_sp::add_spawn_function(&claim_a_node, nodes[j]);
    j++;
  }

  utility::array_thread(spawners, &utility_sp::add_spawn_function, &camper_guy);
  utility::array_thread(spawners, &utility_sp::add_spawn_function, &move_when_enemy_hides, nodes);
  utility::array_thread(spawners, &utility_sp::spawn_ai);
}

function camper_guy() {
  self.goalradius = 8;
  self.fixednode = 1;
}

function move_when_enemy_hides(nodes) {
  self endon("\x1e\xfd\xd1\xa2\a");
  var_9bfbf511483e3e8c = 0;

  while(true) {
    if(!isalive(self.enemy)) {
      self waittill("\xba8C\xef\xc2");
      var_9bfbf511483e3e8c = 0;
      continue;
    }

    if(isPlayer(self.enemy)) {
      if(self.enemy player_sp::belowcriticalhealththreshold() || self.enemy utility::isflashed()) {
        self.fixednode = 0;

        for(;;) {
          self.goalradius = 180;
          self setgoalpos(level.player.origin);
          wait 1;
        }

        return;
      }
    }

    if(var_9bfbf511483e3e8c) {
      if(self cansee(self.enemy)) {
        wait 0.05;
        continue;
      }

      var_9bfbf511483e3e8c = 0;
    } else {
      if(self cansee(self.enemy)) {
        var_9bfbf511483e3e8c = 1;
      }

      wait 0.05;
      continue;
    }

    if(randomint(3) > 0) {
      node = find_unclaimed_node(nodes);

      if(isDefined(node)) {
        claim_a_node(node, self.claimed_node);
        self waittill("\x83\xd6\xaf\x11");
      }
    }
  }
}

function claim_a_node(claimed_node, var_49df714a0b2a635c) {
  self setgoalnode(claimed_node);
  self.claimed_node = claimed_node;
  claimed_node.claimed = 1;

  if(isDefined(var_49df714a0b2a635c)) {
    var_49df714a0b2a635c.claimed = 0;
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
  assert(isDefined(trigger.target), "<dev string:x7b5>" + trigger.origin + "<dev string:x7ca>");
  floodspawners = getspawnerarray(trigger.target);
  assert(floodspawners.size, "<dev string:x7dd>" + trigger.target + "<dev string:x7fe>");
  utility::array_thread(floodspawners, &flood_spawner_init);
  trigger waittill("\x91`\xb1\xe7T\x97>");
  floodspawners = getspawnerarray(trigger.target);
  utility::array_thread(floodspawners, &flood_spawner_think, trigger);
}

function flood_spawner_init() {
  assert(isspawner(self), "<dev string:x816>" + self.origin + "<dev string:x82c>");
}

function trigger_requires_player(trigger) {
  if(!isDefined(trigger)) {
    return false;
  }

  return isDefined(trigger.script_requires_player);
}

function flood_spawner_think(trigger) {
  if(isspawner(self)) {
    self endon("\x1e\xfd\xd1\xa2\a");
  }

  self notify("W88\x14\x96=\xec@\xfa!v\x89\xe5\xe9x0+em\x06\xbe\xaf\xa5\xd6\x96");
  self endon("W88\x14\x96=\xec@\xfa!v\x89\xe5\xe9x0+em\x06\xbe\xaf\xa5\xd6\x96");

  if(is_pyramid_spawner()) {
    pyramid_spawn(trigger);
    return;
  }

  requires_player = trigger_requires_player(trigger);
  utility::script_delay();

  while(self.count > 0) {
    while(requires_player && !level.player istouching(trigger)) {
      wait 0.5;
    }

    soldier = utility_sp::spawn_ai();

    if(ai::spawn_failed(soldier)) {
      wait 2;
      continue;
    }

    soldier thread reincrement_count_if_deleted(self);
    soldier waittill("\x1e\xfd\xd1\xa2\a", attacker);

    if(!player_saw_kill(soldier, attacker)) {
      self.count++;
    }

    if(!isDefined(soldier)) {
      continue;
    }

    if(!utility::script_wait()) {
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
    if(attacker.classname == "\x98\xed\xee\xfc\x05\xabV\v\x96x") {
      return 0;
    }

    if(distance(attacker.origin, level.player.origin) < 200) {
      return 1;
    }
  }

  if(distance(guy.origin, level.player.origin) < 200) {
    return 1;
  }

  return trace::_bullet_trace_passed(level.player getEye(), guy getEye(), 0, undefined);
}

function is_pyramid_spawner() {
  if(!isDefined(self.target)) {
    return 0;
  }

  ent = getspawnerarray(self.target);

  if(!ent.size) {
    return 0;
  }

  return issubstr(ent[0].classname, "\x06`\xb6y[");
}

function pyramid_death_report(spawner) {
  spawner.spawn waittill("\x1e\xfd\xd1\xa2\a");
  self notify("\xc7\xdd\xdf\xb2\xa1f\x98<I\xa2TD");
}

function pyramid_spawn(trigger) {
  self endon("\x1e\xfd\xd1\xa2\a");
  requires_player = trigger_requires_player(trigger);
  utility::script_delay();

  if(requires_player) {
    while(!level.player istouching(trigger)) {
      wait 0.5;
    }
  }

  spawners = getspawnerarray(self.target);

  for(i = 0; i < spawners.size; i++) {
    assert(issubstr(spawners[i].classname, "<dev string:x842>"), "<dev string:x84b>");
  }

  self.spawners = 0;
  utility::array_thread(spawners, &pyramid_spawner_reports_death, self);
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
    spawner utility_sp::set_count(1);
    soldier = spawner utility_sp::spawn_ai();

    if(ai::spawn_failed(soldier)) {
      wait 2;
      continue;
    }

    self.count--;
    spawner.spawn = soldier;
    soldier thread reincrement_count_if_deleted(self);
    soldier thread expand_goalRadius(trigger);
    thread pyramid_death_report(spawner);
  }

  var_cc156e4e40541da5 = 0.01;

  while(self.count > 0) {
    self waittill("\xc7\xdd\xdf\xb2\xa1f\x98<I\xa2TD");
    issuspended = 0;

    foreach(spawner in spawners) {
      spawner.postspawnresetorigin = 1;

      if(isDefined(spawner.suspended_ai)) {
        issuspended = 1;
      }
    }

    if(issuspended) {
      trigger waittill("\x91`\xb1\xe7T\x97>");
    }

    utility::script_wait();
    offset = randomint(spawners.size);

    for(i = 0; i < spawners.size; i++) {
      spawners = utility::array_removeundefined(spawners);

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

      soldier = utility_sp::spawn_ai();

      if(ai::spawn_failed(soldier)) {
        wait 2;
        continue;
      }

      assert(isDefined(spawner), "<dev string:x86e>");
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
  parent endon("\x1e\xfd\xd1\xa2\a");
  parent.spawners++;
  self waittill("\x1e\xfd\xd1\xa2\a");
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

  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x83\xd6\xaf\x11");
  self.goalradius = radius;
}

function show_bad_path() {
  if(!isDefined(level.debug_badpath) || !level.debug_badpath) {
    return;
  }

  setdvarifuninitialized(@ "hash_5ae66c3bb0c9dbba", "<dev string:x88b>");
  self endon("<dev string:x891>");
  var_d8484715a9dfb8c2 = -5000;
  serverduration = 200;
  var_4b5779144cd6305f = 0;

  for(;;) {
    self waittill("<dev string:x89a>", badpathpos);

    if(gettime() - var_d8484715a9dfb8c2 > 5000) {
      var_4b5779144cd6305f = 0;
    } else {
      var_4b5779144cd6305f++;
    }

    var_d8484715a9dfb8c2 = gettime();

    if(var_4b5779144cd6305f < getdvarint(@ "hash_5ae66c3bb0c9dbba")) {
      continue;
    }

    for(i = 0; i < serverduration; i++) {
      line(self.origin, badpathpos, (1, 0.4, 0.1));
      waitframe();
    }
  }
}

function random_spawn(trigger) {
  trigger waittill("\x91`\xb1\xe7T\x97>");
  spawners = getspawnerarray(trigger.target);

  if(!spawners.size) {
    return;
  }

  spawner = utility::random(spawners);
  spawners = [];
  spawners[spawners.size] = spawner;

  if(isDefined(spawner.script_linkto)) {
    links = strtok(spawner.script_linkto, "\xda");

    for(i = 0; i < links.size; i++) {
      spawners[spawners.size] = getspawner(links[i], #script_linkname);
    }
  }

  waittillframeend();
  utility::array_thread(spawners, &utility_sp::add_spawn_function, &blowout_goalradius_on_pathend);
  utility::array_thread(spawners, &utility_sp::spawn_ai);
}

function blowout_goalradius_on_pathend() {
  if(isDefined(self.script_forcegoal)) {
    return;
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x05[\xf8\x84\x04\x06\x01:p\x01\xde\x10\xcc\xb3\xb0\xf8");

  if(!isDefined(self getgoalvolume())) {
    self.goalradius = level.default_goalradius;
  }
}

function function_7137d77eb18cd383() {
  drone = self;

  if(!isundefinedweapon(drone.weapon)) {
    defaults = getweapondefaultattachments(drone.weapon.basename);
    weaponattached = 0;

    if(defaults.size == 0) {
      weapon_model = getweaponmodel(drone.weapon);

      if(modelhastag(weapon_model, "\xfd\xef\xc3\r\xb4\xad\x84p\x84")) {
        drone attach(weapon_model, "\n\xa2iWa\xf6d\xab$x\xb8\x11b\xd9l\f");
        hidetaglist = getweaponhidetags(drone.weapon);

        for(i = 0; i < hidetaglist.size; i++) {
          tag = hidetaglist[i];

          if(utility::hastag(weapon_model, tag)) {
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
        drone.weapon = drone.weapon withattachments(utility::array_combine(defaults_pruned, drone.weapon.attachments));
      }

      drone ai::gun_create_fake(getweaponattachmentworldmodels(drone.weapon));

      if(!istrue(self.nodrop)) {
        drone.weapon_object = drone.weapon;
      }

      drone.weapon = nullweapon();
    }
  }

  drone utility_sp::enable_procedural_bones();
}

function spawner_dronespawn(spawner) {
  drone = spawner fakeactor::spawndrone();
  drone function_7137d77eb18cd383();
  drone.spawner = spawner;
  drone.drone_delete_on_unload = isDefined(spawner.script_noteworthy) && spawner.script_noteworthy == "\x89y\xea\xb2z$]\x14\x7f\x0e\rrq/\x9f\x11S.\xcf\x7f\xb5\xca";
  drone.finished_spawning = 1;
  drone notify("\xc2\xe9\xf6>\xe0\xe8\xea\x02\x8c\x8b|\xfa\x04\x99&\xd1;");
  spawner notify("\x91\xe4\xdbnY\xeb\xb9\xe0aw\xdc+d", drone);
  return drone;
}

function spawner_makerealai(drone, target_override) {
  if(!isDefined(drone.spawner)) {
    println("<dev string:x8a6>");
    println("<dev string:x8d4>" + drone.classname);
    println("<dev string:x8e9>" + drone.origin);

    assertmsg("<dev string:x8fe>");
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
  failed = ai::spawn_failed(guy);

  if(failed) {
    println("<dev string:x8a6>");
    println("<dev string:x932>" + drone.origin);
    println("<dev string:x953>" + drone.spawner.export);
    println("<dev string:x977>" + getaiarray().size);
    println("<dev string:x98f>");

    assertmsg("<dev string:x9ca>");
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
    println("<dev string:x8a6>");
    println("<dev string:xa0e>" + ai.classname);
    println("<dev string:xa20>" + ai.origin);

    assertmsg("<dev string:x8fe>");
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
  guy = utility_sp::fakeactorspawn(ai.spawner);
  failed = ai::spawn_failed(guy);

  if(failed) {
    println("<dev string:xa32>");
    println("<dev string:x932>" + ai.origin);
    println("<dev string:x953>" + ai.spawner.export);
    println("<dev string:x98f>");

    assertmsg("<dev string:xa62>");
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
  assert(isDefined(self.script_randomspawn), "<dev string:x816>" + self.origin + "<dev string:xaa5>");
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
  assert(isDefined(self.script_spawnsubgroup), "<dev string:x816>" + self.origin + "<dev string:xac4>");
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
  self notify("\xd7l@\xa9m\x01j\xac#\x0e\xde\xf1p\x7fX\x14\x7f\xf1");
  self endon("\xd7l@\xa9m\x01j\xac#\x0e\xde\xf1p\x7fX\x14\x7f\xf1");

  if(self.team != "?\xb1\xc0\x9a") {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  utility_sp::hudoutline_enable_new("\xf3V\x89\x1ag\xee\xaa9\xc0\"\xb60\x16\xb5\x995K0\xf1\xd4\x03\xef\x92", "\trg'T\xfd\xab");
  utility::waittill_notify_or_timeout("\x1e\xfd\xd1\xa2\a", 5);
  utility_sp::hudoutline_disable("\trg'T\xfd\xab");

  if(isalive(self)) {
    for(i = 0; i < 3; i++) {
      wait 0.2;
      utility_sp::hudoutline_enable_new("\xf3V\x89\x1ag\xee\xaa9\xc0\"\xb60\x16\xb5\x995K0\xf1\xd4\x03\xef\x92", "\trg'T\xfd\xab");
      wait 0.15;
      utility_sp::hudoutline_disable("\trg'T\xfd\xab");
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
    assert(self.team == "<dev string:xae5>", "<dev string:xaed>");
    bsmstate = suspendstruct.stealthbsmstate;

    if(bsmstate > 1) {
      bsmstate = suspendstruct.stealthbsmstate - int((gettime() - suspendstruct.suspendtime) / 10000);
      bsmstate = int(max(2, bsmstate));
    } else if(bsmstate > 0) {
      bsmstate = suspendstruct.stealthbsmstate - int((gettime() - suspendstruct.suspendtime) / 5000);
      bsmstate = int(max(0, bsmstate));
    }

    state = int_to_stealth_state(bsmstate);
    enemy::bt_set_stealth_state(state, suspendstruct.stealth.investigateevent);
  }
}

function int_to_stealth_state(num) {
  switch (num) {
    case 0:
      return "\x91\x88\xc2*";
    case 1:
      return "\xc2\x99.K\xdd\x9fBw>]\x8e";
    case 2:
      return "\x11t\x12\x1a";
    case 3:
      return "\xe3\xd0\xc3e\x85h";
  }
}

function trigger_zone_spawn(trigger) {
  trigger endon("\x1e\xfd\xd1\xa2\a");
  assert(!(trigger.spawnflags & 32), "<dev string:xb30>" + trigger.origin + "<dev string:xb3f>");
  assert(isDefined(trigger.target), "<dev string:xb30>" + trigger.origin + "<dev string:x140>");
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
    trigger waittill("\x91`\xb1\xe7T\x97>", other);
    trigger utility::script_delay();
    spawners = getspawnerarray(trigger.target);

    foreach(spawner in spawners) {
      spawner thread utility_sp::spawn_ai();
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

  ai::disable_turnanims();
  ai::disable_surprise();

  if(isDefined(level.var_d2c1158e130f42c)) {
    foreach(func in level.var_d2c1158e130f42c) {
      self thread[[func]]();
    }
  }

  thread juggernaut_sound_when_close();
}

function juggernaut_sound_when_close() {
  self endon("\x1e\xfd\xd1\xa2\a");

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
  level notify("&\r]~v\x17\xce\x81\x85\xc2\xc1lv\xd8\xc7\x82\xc6#\xd5\xff");

  if(isDefined(self.skip_intro_sound)) {
    return;
  }
}