/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\spawner.gsc
***********************************************/

function main() {
  level.spawn_funcs = [];
  level.spawn_funcs["allies"] = [];
  level.spawn_funcs["axis"] = [];
  level.spawn_funcs["team3"] = [];
  level.spawn_funcs["neutral"] = [];
  thread goalvolumes();
  var0 = getEntArray("flood_and_secure", "targetname");
  scripts\engine\utility::array_thread(var0, &flood_and_secure);

  if(!isDefined(level.ai_number)) {
    level.ai_number = 0;
  }

  if(getDvar("fallback") == "") {
    setDvar("fallback", "0");
  }

  if(getDvar("noai") == "") {
    setDvar("noai", "off");
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

  foreach(var2 in level.players) {
    var2 setthreatbiasgroup("allies");
  }

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
  var4 = getaispeciesarray();
  scripts\engine\utility::array_thread(var4, &living_ai_prethink);
  level.ai_classname_in_level = [];
  level.drone_paths = [];
  var5 = getspawnerarray();

  for(var6 = 0; var6 < var5.size; var6++) {
    thread spawn_prethink();
  }

  level.drone_paths = undefined;
  scripts\engine\sp\utility::hudoutline_add_child_channel("tracker", 1, "default");
  thread process_deathflags();
  scripts\engine\utility::array_thread(var4, &spawn_think);
  var7 = getarraykeys(level.ai_classname_in_level);

  for(var6 = 0; var6 < var7.size; var6++) {
    var8 = tolower(var7[var6]);
    var9 = "iw8_la_rpapa7";
    precacheitem(var9);
    break;
  }

  var7 = undefined;
}

function aitype_check() {}

function process_deathflags() {
  foreach(var1 in level.deathflags) {
    if(!isDefined(level.flag[var2])) {
      scripts\engine\utility::flag_init(var2);
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

function ai_deathflag() {
  level.deathflags[self.script_deathflag]["ai"][self.unique_id] = self;
  var0 = self.unique_id;
  var1 = self.script_deathflag;

  if(isDefined(self.script_deathflag_longdeath)) {
    waittilldeathorpaindeath();
  } else {
    self waittill("death");
  }

  level.deathflags[var1]["ai"][var0] = undefined;
  update_deathflag(var1);
}

function vehicle_deathflag() {
  var0 = self.unique_id;
  var1 = self.script_deathflag;

  if(!isDefined(level.deathflags) || !isDefined(level.deathflags[self.script_deathflag])) {
    waittillframeend();

    if(!isDefined(self)) {
      return;
    }
  }

  level.deathflags[var1]["vehicles"][var0] = self;
  self waittill("death");
  level.deathflags[var1]["vehicles"][var0] = undefined;
  update_deathflag(var1);
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
  var0 = self.script_deathflag;
  var1 = self.spawner_number;
  spawn_guys_until_death_or_no_count();
  level.deathflags[var0]["spawners"][var1] = undefined;
  update_deathflag(var0);
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
  var0 = self.script_deathflag;
  var1 = self.spawner_number;
  spawn_guys_until_death_or_no_count();
  level.deathflags[var0]["vehicle_spawners"][var1] = undefined;
  update_deathflag(var0);
}

function update_deathflag(var0) {
  level notify("updating_deathflag_" + var0);
  level endon("updating_deathflag_" + var0);
  waittillframeend();

  foreach(var2 in level.deathflags[var0]) {
    if(getarraykeys(var2).size > 0) {
      return;
    }
  }

  scripts\engine\utility::flag_set(var0);
}

function outdoor_think(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger", var1);

    if(!isai(var1)) {
      continue;
    }

    var1 thread scripts\engine\sp\utility::ignore_triggers(0.15);
    var1 scripts\common\utility::disable_cqbwalk();
  }
}

function indoor_think(var0) {
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger", var1);

    if(!isai(var1)) {
      continue;
    }

    var1 thread scripts\engine\sp\utility::ignore_triggers(0.15);
    var1 scripts\common\utility::enable_cqbwalk();
  }
}

function trigger_spawner(var0) {
  var0 waittill("trigger");
  var1 = var0.target;
  var0 scripts\engine\utility::script_delay();
  var2 = scripts\engine\utility::array_combine(getspawnerarray(var1), vehicle_getspawnerarray(var1));

  foreach(var4 in var2) {
    if(!isnonentspawner(var4) && var4.code_classname == "script_vehicle") {
      if(isDefined(var4.script_moveoverride) && var4.script_moveoverride == 1 || !isDefined(var4.target)) {
        thread scripts\common\vehicle::vehicle_spawn(var4);
      } else {
        var4 thread scripts\common\vehicle::spawn_vehicle_and_gopath();
      }

      continue;
    }

    var4 thread scripts\engine\sp\utility::spawn_ai();
  }
}

function trigger_spawner_reinforcement(var0) {
  var1 = var0.target;
  var2 = 0;
  var3 = getspawnerarray(var1);

  foreach(var5 in var3) {
    if(!isDefined(var5.target)) {
      continue;
    }

    var6 = getspawner(var5.target, "targetname");

    if(!isDefined(var6)) {
      if(!isDefined(var5.script_linkto)) {
        continue;
      }

      var6 = getspawner(var5.script_linkto, "script_linkname");

      if(!isDefined(var6)) {
        var6 = var5 scripts\engine\utility::get_linked_ent();
      }

      if(!isDefined(var6)) {
        continue;
      }

      if(!isspawner(var6)) {
        continue;
      }
    }

    var2 = 1;
    break;
  }

  var0 waittill("trigger");
  var0 scripts\engine\utility::script_delay();
  var3 = getspawnerarray(var1);

  foreach(var5 in var3) {
    thread trigger_reinforcement_spawn_guys();
  }
}

function trigger_reinforcement_spawn_guys() {
  var0 = trigger_reinforcement_get_reinforcement_spawner();
  var1 = scripts\engine\sp\utility::spawn_ai();

  if(!isDefined(var1)) {
    self delete();

    if(isDefined(var0)) {
      var1 = var0 scripts\engine\sp\utility::spawn_ai();
      var0 delete();

      if(!isDefined(var1)) {
        return;
      }
    } else {
      return;
    }
  }

  if(!isDefined(var0)) {
    return;
  }

  var1 waittill("death");

  if(!isDefined(var0)) {
    return;
  }

  jumpiftrue(isDefined(var0.count)) LOC_0000005d;
  var0.count = 1;

  for(;;) {
    if(!isDefined(var0)) {
      break;
    }

    var2 = var0 scripts\engine\sp\utility::spawn_ai();

    if(!isDefined(var2)) {
      var0 delete();
      break;
    }

    thread reincrement_count_if_deleted(var2);
    var2 waittill("death", var3);

    if(!player_saw_kill(var2, var3)) {
      var0.count++;
    }

    if(!isDefined(var2)) {
      continue;
    }

    if(!isDefined(var0)) {
      break;
    }

    if(!isDefined(var0.count)) {
      break;
    }

    if(var0.count <= 0) {
      break;
    }

    if(!scripts\engine\utility::script_wait()) {
      wait randomfloatrange(1, 3);
    }
  }

  LOC_000000f8:
    if(isDefined(var0)) {
      var0 delete();
      return;
    }
}

function trigger_reinforcement_get_reinforcement_spawner() {
  if(isDefined(self.target)) {
    var0 = getspawner(self.target, "targetname");

    if(isDefined(var0) && isspawner(var0)) {
      return var0;
    }
  }

  if(isDefined(self.script_linkto)) {
    var0 = getspawner(self.script_linkto, "script_linkname");

    if(!isDefined(var0)) {
      var0 = scripts\engine\utility::get_linked_ent();
    }

    if(isDefined(var0) && isspawner(var0)) {
      return var0;
    }
  }

  return undefined;
}

function flood_spawner_scripted(var0) {
  scripts\engine\utility::array_thread(var0, &flood_spawner_init);
  scripts\engine\utility::array_thread(var0, &flood_spawner_think);
}

function reincrement_count_if_deleted(var0) {
  var0 endon("death");

  if(isDefined(self.script_force_count)) {
    if(self.script_force_count) {
      return;
    }
  }

  self waittill("death");

  if(!isDefined(self)) {
    var0.count++;
    return;
  }
}

function kill_spawner(var0) {
  var1 = var0.script_killspawner;
  var0 waittill("trigger");
  waittillframeend();
  waittillframeend();
  killspawner(var1);
  kill_trigger(var0);
}

function killspawner(var0) {
  var1 = getspawnerarray();
  var2 = vehicle_getspawnerarray();
  var3 = scripts\engine\utility::array_combine(var1, var2);

  for(var4 = 0; var4 < var3.size; var4++) {
    if(isDefined(var3[var4].script_killspawner) && var0 == var3[var4].script_killspawner) {
      if(isnonentspawner(var3[var4])) {
        var3[var4] notify("death");
      }

      var3[var4] delete();
    }
  }
}

function kill_trigger(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.targetname) && var0.targetname != "flood_spawner") {
    return;
  }

  var0 delete();
}

function random_killspawner(var0) {
  var0 endon("death");
  var1 = var0.script_random_killspawner;
  waittillframeend();

  if(!isDefined(level.killspawn_groups)) {
    level.killspawn_groups = [];
  }

  if(!isDefined(level.killspawn_groups[var1])) {
    return;
  }

  var0 waittill("trigger");
  cull_spawners_from_killspawner(var1);
}

function cull_spawners_from_killspawner(var0) {
  if(!isDefined(level.killspawn_groups)) {
    level.killspawn_groups = [];
  }

  if(!isDefined(level.killspawn_groups[var0])) {
    return;
  }

  var1 = level.killspawn_groups[var0];
  var2 = getarraykeys(var1);

  if(var2.size <= 1) {
    return;
  }

  var3 = scripts\engine\utility::random(var2);
  var1[var3] = undefined;

  foreach(var5 in var1) {
    foreach(var7 in var5) {
      if(isDefined(var7)) {
        var7 delete();
      }
    }

    level.killspawn_groups[var0][var9] = undefined;
  }
}

function empty_spawner(var0) {
  var1 = var0.script_emptyspawner;
  var0 waittill("trigger");
  var2 = getspawnerarray();

  for(var3 = 0; var3 < var2.size; var3++) {
    if(!isDefined(var2[var3].script_emptyspawner)) {
      continue;
    }

    if(var1 != var2[var3].script_emptyspawner) {
      continue;
    }

    var2[var3] scripts\engine\sp\utility::set_count(0);
    var2[var3] notify("emptied spawner");
  }

  var0 notify("deleted spawners");
}

function kill_spawnernum(var0) {
  var1 = getspawnerarray();

  foreach(var3 in var1) {
    if(!isDefined(var3.script_killspawner)) {
      continue;
    }

    if(var0 != var3.script_killspawner) {
      continue;
    }

    var3 delete();
  }
}

function spawn_grenade(var0, var1) {
  var2 = spawn("weapon_frag", var0);
  thread add_to_grenade_cache(var2);
  return var2;
}

function add_to_grenade_cache(var0) {
  if(!isDefined(level.grenade_cache) || !isDefined(level.grenade_cache[var0])) {
    level.grenade_cache_index[var0] = 0;
    level.grenade_cache[var0] = [];
  }

  var1 = level.grenade_cache_index[var0];
  var2 = level.grenade_cache[var0][var1];

  if(isDefined(var2)) {
    var2 delete();
  }

  level.grenade_cache[var0][var1] = self;
  level.grenade_cache_index[var0] = (var1 + 1) % 16;
}

function waittilldeathorpaindeath() {
  self endon("death");
  self waittill("long_death");
}

function dronespawner_init() {
  scripts\sp\drone_base::drone_init_path();
}

function fakeactorspawner_init() {
  scripts\sp\fakeactor::fakeactor_spawner_init();
}

function spawn_prethink() {
  level.ai_classname_in_level[self.classname] = 1;

  if(isDefined(self.script_difficulty)) {
    switch (self.script_difficulty) {
      case "easy":
        if(level.gameskill > 1) {
          scripts\engine\sp\utility::set_count(0);
        }

        break;
      case "hard":
        if(level.gameskill < 2) {
          scripts\engine\sp\utility::set_count(0);
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
    var0 = self.script_aigroup;

    if(!isDefined(level._ai_group[var0])) {
      aigroup_create(var0);
    }

    thread aigroup_spawnerthink(level._ai_group[var0]);
  }

  if(isDefined(self.script_delete)) {
    var1 = 0;

    if(isDefined(level._ai_delete)) {
      if(isDefined(level._ai_delete[self.script_delete])) {
        var1 = level._ai_delete[self.script_delete].size;
      }
    }

    level._ai_delete[self.script_delete][var1] = self;
  }

  if(isDefined(self.script_health)) {
    if(self.script_health > level._max_script_health) {
      level._max_script_health = self.script_health;
    }

    var1 = 0;

    if(isDefined(level._ai_health)) {
      if(isDefined(level._ai_health[self.script_health])) {
        var1 = level._ai_health[self.script_health].size;
      }
    }

    level._ai_health[self.script_health][var1] = self;
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

  jumpiftrue(isDefined(self.spawn_functions)) LOC_0000019f;
  self.spawn_functions = [];

  for(;;) {
    self waittill("spawned", var2);

    if(!isalive(var2)) {
      continue;
    }

    if(isDefined(level.spawnercallbackthread)) {
      self thread[[level.spawnercallbackthread]](var2);
    }

    if(isDefined(self.script_delete)) {
      for(var3 = 0; var3 < level._ai_delete[self.script_delete].size; var3++) {
        if(level._ai_delete[self.script_delete][var3] != self) {
          level._ai_delete[self.script_delete][var3] delete();
        }
      }
    }

    var2.spawn_funcs = self.spawn_functions;
    var2.spawn_functions = undefined;
    var2.spawner = self;

    if(isDefined(self.targetname)) {
      thread spawn_think(var2);
      continue;
    }

    thread spawn_think();
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

function spawn_think(var0) {
  level.ai_classname_in_level[self.classname] = 1;

  if(isDefined(self.asmname) && self.asmname == "seeker") {
    return;
  }

  spawn_think_action(var0);
  self endon("death");

  if(shouldnt_spawn_because_of_script_difficulty()) {
    self delete();
  }

  thread run_spawn_functions();
  self.finished_spawning = 1;
  self notify("finished spawning");
}

function shouldnt_spawn_because_of_script_difficulty() {
  if(!isDefined(self.script_difficulty)) {
    return 0;
  }

  var0 = 0;

  switch (self.script_difficulty) {
    case "easy":
      if(level.gameskill > 1) {
        var0 = 1;
      }

      break;
    case "hard":
      if(level.gameskill < 2) {
        var0 = 1;
      }

      break;
  }

  return var0;
}

function run_spawn_functions() {
  if(!isDefined(self.spawn_funcs)) {
    if(!isDefined(self.script_suspend)) {
      self.spawner = undefined;
    }

    return;
  }

  var0 = 0;

  if(var0 < self.spawn_funcs.size) {
    var1 = self.spawn_funcs[var0];

    if(isDefined(var1["param5"])) {
      GscBinSkip1(0x74, var1["function"], var1["param1"], var1["param2"], var1["param3"], var1["param4"], var1["param5"]);
    }

    if(isDefined(var1["param4"])) {
      GscBinSkip1(0x74, var1["function"], var1["param1"], var1["param2"], var1["param3"], var1["param4"]);
    }

    if(isDefined(var1["param3"])) {
      GscBinSkip1(0x74, var1["function"], var1["param1"], var1["param2"], var1["param3"]);
    }

    if(isDefined(var1["param2"])) {
      GscBinSkip1(0x74, var1["function"], var1["param1"], var1["param2"]);
    }

    if(isDefined(var1["param1"])) {
      GscBinSkip1(0x74, var1["function"], var1["param1"]);
    }

    GscBinSkip1(0x74, var1["function"]);
  }

  var2 = scripts\engine\utility::ter_op(isDefined(level.vehicle.spawn_functions_enable) && level.vehicle.spawn_functions_enable && self.code_classname == "script_vehicle", self.script_team, self.team);

  if(isDefined(var2)) {
    var0 = 0;

    if(var0 < level.spawn_funcs[var2].size) {
      var1 = level.spawn_funcs[var2][var0];

      if(isDefined(var1["param5"])) {
        GscBinSkip1(0x74, var1["function"], var1["param1"], var1["param2"], var1["param3"], var1["param4"], var1["param5"]);
      }

      if(isDefined(var1["param4"])) {
        GscBinSkip1(0x74, var1["function"], var1["param1"], var1["param2"], var1["param3"], var1["param4"]);
      }

      if(isDefined(var1["param3"])) {
        GscBinSkip1(0x74, var1["function"], var1["param1"], var1["param2"], var1["param3"]);
      }

      if(isDefined(var1["param2"])) {
        GscBinSkip1(0x74, var1["function"], var1["param1"], var1["param2"]);
      }

      if(isDefined(var1["param1"])) {
        GscBinSkip1(0x74, var1["function"], var1["param1"]);
      }

      GscBinSkip1(0x74, var1["function"]);
    }
  }

  self.spawn_funcs = undefined;

  if(!isDefined(self.script_suspend)) {
    self.spawner = undefined;
    return;
  }
}

function deathfunctions() {
  self waittill("death", var0, var1, var2);
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = createheadicon(var2);
  }

  level notify("ai_killed", self, var0, var1, var3);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var0)) {
    if(self.team == "axis" || self.team == "team3") {
      var4 = undefined;

      if(isDefined(var0.attacker)) {
        if(isDefined(var0.issentrygun) && var0.issentrygun) {
          var4 = "sentry";
        }

        if(isDefined(var0.destructible_type)) {
          var4 = "destructible";
        }

        var0 = var0.attacker;
      } else if(isDefined(var0.owner)) {
        if(isai(var0) && isPlayer(var0.owner)) {
          var4 = "friendly";
        }

        var0 = var0.owner;
      } else if(isDefined(var0.damageowner)) {
        if(isDefined(var0.destructible_type)) {
          var4 = "destructible";
        }

        var0 = var0.damageowner;
      }

      var5 = 0;

      if(isPlayer(var0)) {
        var5 = 1;
      }

      if(var5) {
        var0.lastenemykilltime = gettime();
        var0 scripts\sp\player_stats::register_kill(self, var1, var3, var4);
        return;
      }

      return;
    }

    return;
  }
}

function ai_damage_think() {
  self.damage_functions = [];

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    self.paindamage = var0;

    if(isDefined(var1) && isPlayer(var1)) {
      var10 = var1.currentweapon;

      if(isDefined(var10) && scripts\sp\utility::isprimaryweapon(var10) && isDefined(var4) && (var4 == "MOD_PISTOL_BULLET" || var4 == "MOD_RIFLE_BULLET")) {
        var1 thread scripts\sp\player_stats::register_shot_hit();

        if(self isbadguy()) {
          var1.lastenemydmgtime = gettime();
        }
      }
    }

    var11 = self.damage_functions;
    var13 = getfirstarraykey(var11);

    if(isDefined(var13)) {
      var12 = var11[var13];
      GscBinSkip1(0x74, var12, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    }

    var11 = undefined;
    var13 = undefined;

    if(!isalive(self) || self.delayeddeath) {
      break;
    }
  }
}

function living_ai_prethink() {
  init_stealth();

  if(isDefined(self.target)) {
    crawl_targets_init_flags(self.target);
    return;
  }
}

function crawl_targets_init_flags(var0) {
  var1 = get_target_goals(var0);

  if(var1.size == 0) {
    return;
  }

  var2 = -1;

  for(;;) {
    var2++;

    if(var2 >= var1.size) {
      break;
    }

    var3 = var1[var2];

    if(isDefined(var3.crawled)) {
      continue;
    }

    var3.crawled = 1;
    thread remove_crawled(level);

    if(isDefined(var3.script_flag_set)) {
      if(!isDefined(level.flag[var3.script_flag_set])) {
        scripts\engine\utility::flag_init(var3.script_flag_set);
      }
    }

    if(isDefined(var3.script_flag_wait)) {
      if(!isDefined(level.flag[var3.script_flag_wait])) {
        scripts\engine\utility::flag_init(var3.script_flag_wait);
      }
    }

    if(isDefined(var3.script_flag_clear)) {
      if(!isDefined(level.flag[var3.script_flag_clear])) {
        scripts\engine\utility::flag_init(var3.script_flag_clear);
      }
    }

    if(isDefined(var3.script_idle)) {
      if(!isDefined(level.idle_funcs)) {
        scripts\sp\stealth\idle_sitting::main();
      }
    }

    if(isDefined(var3.target)) {
      var4 = get_target_goals(var3.target);

      foreach(var6 in var4) {
        if(!isDefined(var6.crawled)) {
          var1 = var6;
        }
      }
    }
  }
}

function remove_crawled(var0) {
  waittillframeend();

  if(isDefined(var0)) {
    var0.crawled = undefined;
    return;
  }
}

function spawn_team_allies() {
  self.usechokepoints = 0;
  checkboosttraversal();
}

function spawn_team_axis() {
  checkboosttraversal();

  if(isDefined(self.script_combatmode)) {
    self.combatmode = self.script_combatmode;
    return;
  }
}

function checkboosttraversal() {
  GscBinSkip1(0x45, "crew", 1);
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

function ai_lasers() {
  if(!isalive(self)) {
    return;
  }

  if(self.health <= 1) {
    return;
  }

  self laserforceon();
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self laserforceoff();
}

function spawn_think_script_inits() {
  if(isDefined(self.script_dontshootwhilemoving)) {
    self.dontshootwhilemoving = 1;
    self.script_dontshootwhilemoving = undefined;
  }

  if(isDefined(self.script_deathflag)) {
    thread ai_deathflag();
  }

  if(isDefined(self.script_attackeraccuracy)) {
    self.attackeraccuracy = self.script_attackeraccuracy;
    self.script_attackeraccuracy = undefined;
  }

  if(isDefined(self.script_startrunning)) {
    thread start_off_running();
    self.script_startrunning = undefined;
  }

  if(isDefined(self.script_deathtime)) {
    thread deathtime();
  }

  if(isDefined(self.script_nosurprise)) {
    scripts\engine\sp\utility::disable_surprise();
    self.script_nosurprise = undefined;
  }

  if(isDefined(self.script_nobloodpool)) {
    self.skipbloodpool = 1;
    self.script_nobloodpool = undefined;
  }

  if(isDefined(self.script_animname)) {
    self.animname = self.script_animname;
    self.script_animname = undefined;
  }

  if(isDefined(self.script_laser)) {
    thread ai_lasers();
  }

  if(isDefined(self.script_danger_react)) {
    var0 = self.script_danger_react;

    if(var0 == 1) {
      var0 = 8;
    }

    scripts\engine\sp\utility::enable_danger_react(var0);
  }

  if(isDefined(self.script_faceenemydist)) {
    self.maxfaceenemydist = self.script_faceenemydist;
  } else if(!self.space) {
    self.maxfaceenemydist = 512;
  }

  if(isDefined(self.script_forcecolor)) {
    scripts\engine\sp\utility::set_force_color(self.script_forcecolor);
  }

  if(isDefined(self.dontdropweapon)) {
    self.dropweapon = 0;
  }

  if(isDefined(self.script_team)) {
    self.team = self.script_team;
  }

  if(isDefined(self.script_fixednode)) {
    self.fixednode = self.script_fixednode == 1;
    self.script_fixednode = undefined;
  } else {
    self.fixednode = self.team == "allies";
  }

  if(isDefined(self.script_no_reorient) && self.script_no_reorient == 1) {
    self.no_reorient = 1;
    self.script_no_reorient = undefined;
  }

  self.providecoveringfire = self.team == "allies" && self.fixednode;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mgpair") {
    thread scripts\sp\mg_penetration::create_mg_team();
  }

  if(isDefined(self.script_goalvolume) && !(isDefined(self.script_moveoverride) && self.script_moveoverride == 1 || isDefined(self.script_stealthgroup))) {
    thread set_goal_volume();
  }

  if(isDefined(self.script_threatbiasgroup)) {
    self setthreatbiasgroup(self.script_threatbiasgroup);
  } else if(self.team == "neutral") {
    self setthreatbiasgroup("civilian");
  } else {
    self setthreatbiasgroup(self.team);
  }

  if(isDefined(self.script_bcdialog)) {
    scripts\engine\sp\utility::set_battlechatter(self.script_bcdialog);
  }

  if(isDefined(self.script_accuracy)) {
    self.baseaccuracy = self.script_accuracy;
    self.script_accuracy = undefined;
  }

  if(isDefined(self.script_ignoreme)) {
    self.ignoreme = 1;
    self.script_ignoreme = undefined;
  }

  if(isDefined(self.script_ignore_suppression)) {
    self.ignoresuppression = 1;
    self.script_ignore_suppression = undefined;
  }

  if(isDefined(self.script_ignoreall)) {
    self.ignoreall = 1;
    self clearenemy();
  }

  if(isDefined(self.script_no_seeker)) {
    self.no_seeker = 1;
    self.script_no_seeker = undefined;
  }

  if(isDefined(self.script_offhands)) {
    scripts\engine\sp\utility::set_grenadeweapon(self.script_offhands);
    self.script_offhands = undefined;
  }

  if(isDefined(self.script_favoriteenemy)) {
    if(self.script_favoriteenemy == "player") {
      self.favoriteenemy = level.player;
      level.player.targetname = "player";
    }
  }

  if(isDefined(self.script_sightrange)) {
    self.maxsightdistsqrd = self.script_sightrange;
    self.script_sightrange = undefined;
  }

  if(isDefined(self.script_fightdist)) {
    self.pathenemyfightdist = self.script_fightdist;
    self.script_fightdist = undefined;
  }

  if(isDefined(self.script_maxdist)) {
    self.pathenemylookahead = self.script_maxdist;
    self.script_maxdist = undefined;
  }

  if(isDefined(self.script_longdeath)) {
    if(self.script_longdeath == 0) {
      scripts\engine\sp\utility::disable_long_death();
    } else if(self.script_longdeath == 1) {
      scripts\engine\sp\utility::enable_long_death();
    } else {
      scripts\engine\sp\utility::enable_long_death();
      self.forcelongdeath = self.script_longdeath;
    }
  }

  if(isDefined(self.script_forcebalconydeath)) {
    self.forcebalconydeath = 1;
    self.script_forcebalconydeath = undefined;
  }

  if(isDefined(self.script_diequietly)) {
    self.diequietly = 1;
    self.script_diequietly = undefined;
  }

  if(isDefined(self.script_noragdoll)) {
    self.noragdoll = 1;
    self.script_noragdoll = undefined;
  }

  if(isDefined(self.script_pacifist)) {
    self.pacifist = 1;
    self.script_pacifist = undefined;
  }

  if(isDefined(self.script_bulletshield)) {
    scripts\common\ai::magic_bullet_shield();
    self.script_bulletshield = undefined;
  }

  if(isDefined(self.script_startinghealth)) {
    self.health = self.script_startinghealth;
    self.script_startinghealth = undefined;
  }

  if(isDefined(self.script_nodrop)) {
    self.nodrop = self.script_nodrop;
    self.script_nodrop = undefined;
  }

  if(isDefined(self.script_noloot)) {
    self.noloot = self.script_noloot;
    self.script_noloot = undefined;
  }

  if(isDefined(self.script_noarmor)) {
    self.noarmor = self.script_noarmor;
    self.script_noarmor = undefined;
  }

  if(isDefined(self.script_demeanor)) {
    scripts\common\utility::demeanor_override(self.script_demeanor);
    self.script_demeanor = undefined;
  }

  if(isDefined(self.script_noflashlight)) {
    self.noflashlight = self.script_noflashlight;
    self.script_noflashlight = undefined;
  }

  if(isDefined(self.script_bombplayer)) {
    self.bombertarget = level.player;
    self getenemyinfo(level.player);
    self.script_bombplayer = undefined;
  }

  thread scripts\sp\loot::corpselootthink();
}

function spawn_c6_script_inits() {
  if(isDefined(self.script_selfdestruct_delay)) {
    self.bt.forceselfdestructtimer = gettime() + self.script_selfdestruct_delay * 1000;
    self.script_selfdestruct_delay = undefined;
  } else if(isDefined(self.script_selfdestruct)) {
    self.bt.forceselfdestructtimer = 1;
    self.script_selfdestruct = undefined;
  }

  if(getdvarint("phstreets_iw8_test")) {
    self.dropweapon = 0;
    return;
  }
}

function spawn_think_action(var0) {
  thread ai_damage_think();
  thread tanksquish();

  if(!isDefined(level.ai_dont_glow_in_thermal)) {
    self thermaldrawenable();
  }

  self.spawner_number = undefined;

  if(!isDefined(self.unique_id)) {
    scripts\engine\utility::set_ai_number();
  }

  thread deathfunctions();
  level thread scripts\sp\friendlyfire::friendly_fire_think(self);
  self.walkdist = 16;
  init_reset_ai();
  spawn_think_game_skill_related();
  spawn_think_script_inits();

  switch (self.unittype) {
    case "c6":
      spawn_c6_script_inits();
      break;
  }

  [[level.team_specific_spawn_functions[self.team]]]();

  if(isDefined(level.unittype_spawn_functions[self.unittype])) {
    self thread[[level.unittype_spawn_functions[self.unittype]]]();
  }

  if(isDefined(level.subclass_spawn_functions[self.subclass])) {
    self thread[[level.subclass_spawn_functions[self.subclass]]]();
  }

  if(self.team == "axis") {
    thread scripts\engine\sp\utility::add_damage_function(&scripts\sp\damagefeedback::damagefeedback_took_damage);
  }

  set_goal_height_from_settings();

  if(isDefined(self.script_combatbehavior)) {
    if(self.script_combatbehavior == "heat") {
      scripts\sp\utility::enable_heat_behavior();
    }

    if(self.script_combatbehavior == "cqb") {
      scripts\common\utility::enable_cqbwalk();
    }
  }

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

    scripts\stealth\callbacks::stealth_call_thread("do_stealth");
    return;
  }

  if(isDefined(self.script_readystand) && self.script_readystand == 1) {
    scripts\engine\sp\utility::enable_readystand();
  }

  if(isDefined(self.script_delayed_playerseek)) {
    if(!isDefined(self.script_radius)) {
      self.goalradius = 800;
    }

    self setgoalentity(level.player);
    thread delayed_player_seek_think(level);
    return;
  }

  if(isDefined(self.script_moveoverride) && self.script_moveoverride == 1) {
    set_goal_from_settings();
    self setgoalpos(self.origin);
    return;
  }

  if(isDefined(self.script_stealthgroup)) {}

  set_goal_from_settings();

  if(isDefined(self.target)) {
    thread go_to_node();
    return;
  }
}

function init_reset_ai() {
  scripts\engine\sp\utility::set_default_pathenemy_settings();

  if(isDefined(self.script_grenades)) {
    self.grenadeammo = self.script_grenades;
  }

  if(isDefined(self.primaryweapon)) {
    self.noattackeraccuracymod = scripts\anim\utility_common::isasniper();
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
  scripts\engine\sp\utility::clear_force_color();
  self.interval = 96;
  self.disablearrivals = undefined;
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
    scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\engine\sp\utility::disable_replace_on_death();
  self.maxsightdistsqrd = 67108864;
  self.script_forcegrenade = 0;
  self.walkdist = 16;
  self.pushable = 1;
  self.script_pushable = 1;
  scripts\anim\init::set_anim_playback_rate();
  self.fixednode = self.team == "allies";
}

function delayed_player_seek_think(var0) {
  var0 endon("death");

  while(isalive(var0)) {
    if(var0.goalradius > 200) {
      var0.goalradius -= 200;
    }

    wait 6;
  }
}

function set_goal_volume() {
  self endon("death");
  waittillframeend();

  if(isDefined(self.team) && self.team == "allies") {
    self.fixednode = 0;
  }

  var0 = level.goalvolumes[self.script_goalvolume];

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var0.target)) {
    var1 = getnode(var0.target, "targetname");
    var2 = getEnt(var0.target, "targetname");
    var3 = scripts\engine\utility::getStruct(var0.target, "targetname");
    var4 = undefined;

    if(isDefined(var1)) {
      var4 = var1;
      self setgoalnode(var4);
    } else if(isDefined(var2)) {
      var4 = var2;
      self setgoalpos(var4.origin);
    } else if(isDefined(var3)) {
      var4 = var3;
      self setgoalpos(var4.origin);
    }

    if(isDefined(var4.radius) && var4.radius != 0) {
      self.goalradius = var4.radius;
    }

    if(isDefined(var4.goalheight) && var4.goalheight != 0) {
      self.goalheight = var4.goalheight;
    }
  }

  if(isDefined(self.target)) {
    self setgoalvolume(var0);
    return;
  }

  self setgoalvolumeauto(var0, var0 scripts\engine\sp\utility::get_cover_volume_forward());
}

function get_target_goals(var0) {
  var1 = getnodearray(var0, "targetname");
  var2 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var4 in var2) {
    var1 = var4;
  }

  var2 = getEntArray(var0, "targetname");

  foreach(var4 in var2) {
    if(!is_target_goal_valid(var4)) {
      continue;
    }

    var1 = var4;
  }

  return var1;
}

function is_target_goal_valid(var0) {
  if(isspawner(var0)) {
    return false;
  }

  switch (var0.code_classname) {
    case "trigger_once":
    case "trigger_multiple":
    case "trigger_radius":
    case "misc_turret":
      return false;
  }

  return true;
}

function node_has_radius(var0) {
  return isDefined(var0.radius) && var0.radius != 0;
}

function go_to_node(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = get_target_goals(self.target);

    if(var0.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(!isarray(var0)) {
    var0 = [var0];
  }

  go_to_node_internal(var0, var1, var2);
}

function get_least_used_from_array(var0) {
  if(var0.size == 1) {
    return var0[0];
  }

  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = var0[0];

  if(!isDefined(var1.used_time)) {
    var1.used_time = 0;
  }

  foreach(var3 in var0) {
    if(!isDefined(var3.used_time)) {
      var3.used_time = 0;
    }

    if(var3.used_time < var1.used_time) {
      var1 = var3;
    }
  }

  var1.used_time = gettime();
  return var1;
}

function go_to_node_internal(var0, var1, var2) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");

  if(!isarray(var0)) {
    var0 = [var0];
  }

  var3 = var0[0];
  thread go_to_node_end();
  var4 = 0;
  var5 = undefined;

  for(;;) {
    if(!var4) {
      var0 = get_least_used_from_array(var0);
      var5 = get_path_array(var0, var3);
      self.patharray = var5;
      self.patharrayindex = -1;

      if(var5.size > 1) {
        var4 = 1;
      }
    }

    self.currentnode = var0;

    if(var4) {
      var0 = var5[var5.size - 1];
      go_through_patharray(var5, var1, var2);
      var5 = undefined;
      var4 = 0;
    } else {
      node_fields_pre_goal(var0);

      if(isDefined(self.stealth)) {
        scripts\stealth\callbacks::stealth_call("go_to_node_wait", &go_to_node_set_goal, var0);
      } else {
        go_to_node_set_goal(var0);
        self waittill("goal");
      }
    }

    var0 notify("trigger", self);
    node_fields_after_goal(var0, var1);
    var0 scripts\engine\utility::script_delay();

    if(isDefined(var0.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var0.script_flag_wait);
    }

    if(isDefined(var0.script_ent_flag_wait)) {
      scripts\engine\utility::ent_flag_wait(var0.script_ent_flag_wait);
    }

    var0 scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(var0, var2);

    if(!isDefined(var0.target)) {
      break;
    }

    var6 = get_target_goals(var0.target);

    if(!var6.size) {
      break;
    }

    var0 = var6;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }

  var7 = self getgoalvolume();

  if(isDefined(var7)) {
    self setgoalvolumeauto(var7, var7 scripts\engine\sp\utility::get_cover_volume_forward());
    return;
  }

  self.goalradius = level.default_goalradius;
}

function go_through_patharray(var0, var1, var2) {
  self setgoalpath(var0);

  foreach(var4 in var0) {
    node_fields_pre_goal(var4);
    var5 = waittill_subgoal();
    self.patharrayindex = var5;

    if(isDefined(self.patharray) && !isDefined(self.patharrayindex)) {
      self.patharrayindex = self.patharray.size - 1;
    }

    if(var6 == var0.size - 1) {
      self waittill("goal");
      break;
    }

    var4 notify("trigger", self);
    node_fields_after_goal(var4, var1);
    node_fields_after_goal_and_wait(var4, var2);
  }
}

function waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", var0);
  return var0;
}

function get_path_array(var0, var1) {
  var2 = [];
  var3 = 0;

  for(;;) {
    var2 = var0;
    var3++;

    if(var3 == 16) {
      break;
    }

    if(scripts\engine\utility::is_equal(var0.code_classname, "info_volume")) {
      break;
    }

    if(go_to_node_should_stop(var0)) {
      break;
    }

    if(!isDefined(var0.target)) {
      break;
    }

    var4 = get_target_goals(var0.target);

    if(!var4.size) {
      break;
    }

    var0 = get_least_used_from_array(var4);

    if(var0 == var1) {
      break;
    }
  }

  return var2;
}

function node_fields_pre_goal(var0) {
  if(isDefined(var0.radius)) {
    self.goalradius = var0.radius;
  }

  if(isDefined(var0.height)) {
    self.goalheight = var0.height;
  }

  if(isDefined(var0.script_demeanor)) {
    scripts\common\utility::demeanor_override(var0.script_demeanor);
  }

  if(isDefined(var0.script_civilian_state)) {
    scripts\asm\asm_bb::bb_setcivilianstate(var0.script_civilian_state);
  }

  if(isDefined(var0.script_pacifist)) {
    self.pacifist = var0.script_pacifist;
  }

  if(isDefined(var0.script_ignoreall)) {
    self.ignoreall = var0.script_ignoreall;
  }

  if(isDefined(var0.script_ignoreme)) {
    self.ignoreme = var0.script_ignoreme;
  }

  if(isDefined(var0.script_moveplaybackrate)) {
    scripts\engine\sp\utility::set_moveplaybackrate(var0.script_moveplaybackrate, 0.25);
  }

  if(isDefined(var0.script_speed)) {
    scripts\engine\utility::set_movement_speed(var0.script_speed);
  }

  if(isDefined(var0.script_gunpose)) {
    scripts\common\ai::set_gunpose(var0.script_gunpose);
  }

  if(isDefined(var0.script_disable_arrivals)) {
    if(var0.script_disable_arrivals) {
      scripts\common\ai::disable_arrivals();
    } else {
      self.disablearrivals = undefined;
    }
  }

  if(isDefined(var0.script_disable_exits)) {
    if(var0.script_disable_exits) {
      scripts\common\ai::disable_exits();
      return;
    }

    scripts\common\ai::enable_exits();
    return;
  }
}

function node_fields_after_goal(var0, var1) {
  if(isDefined(self.stealth)) {
    scripts\stealth\callbacks::stealth_call("go_to_node_arrive", &go_to_node_set_goal, var0);
  }

  if(isDefined(var1)) {
    [[var1]](var0);
  }

  if(isDefined(var0.script_flag_set)) {
    scripts\engine\utility::flag_set(var0.script_flag_set);
  }

  if(isDefined(var0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var0.script_ent_flag_set);
  }

  if(isDefined(var0.script_ent_flag_clear)) {
    scripts\engine\utility::ent_flag_clear(var0.script_ent_flag_clear);
  }

  if(isDefined(var0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var0.script_flag_clear);
  }

  if(targets_and_uses_turret(var0)) {
    return 1;
  }
}

function node_fields_after_goal_and_wait(var0, var1) {
  if(isDefined(var0.script_soundalias)) {
    self playSound(var0.script_soundalias);
  }

  if(isDefined(var0.script_gesture)) {
    thread scripts\engine\sp\utility::gesture_simple(var0.script_gesture);
  }

  if(isDefined(self.stealth)) {
    scripts\stealth\callbacks::stealth_call("go_to_node_post_wait", &go_to_node_set_goal, var0);
  }

  if(isDefined(self.post_wait_func)) {
    [[self.post_wait_func]]();
  }

  if(isDefined(var0.script_delay_post)) {
    wait var0.script_delay_post;
  }

  while(isDefined(var0.script_requires_player)) {
    if(go_to_node_wait_for_player(var0, &get_target_goals)) {
      var0 notify("script_requires_player");
      break;
    }

    wait 0.1;
  }

  if(isDefined(var0.script_demeanor_post)) {
    scripts\common\utility::demeanor_override(var0.script_demeanor_post);
  }

  if(isDefined(var1)) {
    [[var1]](var0);
  }

  if(istrue(var0.script_death)) {
    scripts\engine\sp\utility::die();
  }

  if(istrue(var0.script_delete)) {
    if(istrue(var0.script_nosight)) {
      level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 350);
      return;
    }

    if(isDefined(self.magic_bullet_shield)) {
      scripts\common\ai::stop_magic_bullet_shield();
    }

    self delete();
    return;
  }
}

function go_to_node_end() {
  self endon("death");
  self.using_goto_node = 1;
  scripts\engine\utility::waittill_any("reached_path_end", "stop_going_to_node");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

function go_to_node_wait_for_player(var0, var1) {
  if(distancesquared(level.player.origin, var0.origin) < distancesquared(self.origin, var0.origin)) {
    return true;
  }

  if(!isDefined(var0.script_dist_only)) {
    var2 = anglesToForward(self.angles);

    if(isDefined(var0.target)) {
      var3 = [[var1]](var0.target);

      if(var3.size == 1) {
        var2 = vectorNormalize(var3[0].origin - var0.origin);
      } else if(isDefined(var0.angles)) {
        var2 = anglesToForward(var0.angles);
      }
    } else if(isDefined(var0.angles)) {
      var2 = anglesToForward(var0.angles);
    }

    var4 = [];
    GscBinSkip0(0x2e, var4.size, vectorNormalize(level.player.origin - self.origin));
  }

  var8 = 32;

  if(var2.script_requires_player > var8) {
    var8 = var2.script_requires_player;
  }

  if(distancesquared(level.player.origin, self.origin) < squared(var8)) {
    return true;
  }

  return false;
}

function go_to_node_should_stop(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!isDefined(var0.target)) {
    return true;
  }

  if(isDefined(var0.script_delay)) {
    return true;
  }

  if(isDefined(var0.script_delay_min)) {
    return true;
  }

  if(isDefined(var0.script_delay_max)) {
    return true;
  }

  if(isDefined(var0.script_wait)) {
    return true;
  }

  if(isDefined(var0.script_wait_add)) {
    return true;
  }

  if(isDefined(var0.script_wait_min)) {
    return true;
  }

  if(isDefined(var0.script_wait_max)) {
    return true;
  }

  if(isDefined(var0.script_flag_wait)) {
    return true;
  }

  if(isDefined(var0.script_ent_flag_wait)) {
    return true;
  }

  if(isDefined(var0.script_delay_post)) {
    return true;
  }

  if(isDefined(var0.script_requires_player)) {
    return true;
  }

  if(isDefined(var0.script_idle)) {
    return true;
  }

  if(isDefined(var0.script_stopnode)) {
    return true;
  }

  return false;
}

function go_to_node_set_goal(var0) {
  if(isnode(var0)) {
    go_to_node_set_goal_node(var0);
  } else if(isstruct(var0)) {
    go_to_node_set_goal_pos(var0);
  } else if(isent(var0)) {
    go_to_node_set_goal_ent(var0);
  }

  if(isstruct(var0) || isnode(var0)) {
    var0.patrol_stop = go_to_node_should_stop(var0);
    return;
  }
}

function go_to_node_set_goal_ent(var0) {
  if(var0.code_classname == "info_volume") {
    self setgoalvolumeauto(var0, var0 scripts\engine\sp\utility::get_cover_volume_forward());
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(var0);
}

function go_to_node_set_goal_pos(var0) {
  scripts\engine\sp\utility::set_goal_ent(var0);
  self notify("go_to_node_new_goal");
}

function go_to_node_set_goal_node(var0) {
  scripts\engine\sp\utility::set_goal_node(var0);
  self notify("go_to_node_new_goal");
}

function targets_and_uses_turret(var0) {
  if(!isDefined(var0.target)) {
    return false;
  }

  var1 = getEntArray(var0.target, "targetname");

  if(!var1.size) {
    return false;
  }

  var2 = var1[0];

  if(!issubstr(var2.classname, "misc_turret")) {
    return false;
  }

  thread use_a_turret(var2);
  return true;
}

function set_goal_height_from_settings() {
  if(isDefined(self.script_goalheight)) {
    self.goalheight = self.script_goalheight;
    return;
  }

  self.goalheight = level.default_goalheight;
}

function set_goal_from_settings(var0) {
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(isDefined(self.script_forcegoal)) {
    if(isDefined(var0) && isDefined(var0.radius)) {
      self.goalradius = var0.radius;
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
    return;
  }
}

function autotarget(var0) {
  for(;;) {
    var1 = self getturretowner();

    if(!isalive(var1)) {
      wait 1.5;
      continue;
    }

    if(!isDefined(var1.enemy)) {
      self settargetentity(scripts\engine\utility::random(var0));
      self notify("startfiring");
      self startfiring();
    }

    wait 2 + randomfloat(1);
  }
}

function manualtarget(var0) {
  for(;;) {
    self settargetentity(scripts\engine\utility::random(var0));
    self notify("startfiring");
    self startfiring();
    wait 2 + randomfloat(1);
  }
}

function use_a_turret(var0) {
  self endon("stop_using_turret");
  self endon("death");

  if(self isbadguy() && self.health == 150) {
    self.health = 100;
    self.a.disablelongdeath = 1;
  }

  scripts\asm\asm_bb::bb_requestturret(var0);

  while(!isDefined(self getturret()) || self getturret() != var0) {
    wait 0.05;
  }

  if(isDefined(var0.target) && var0.target != var0.targetname) {
    var1 = getEntArray(var0.target, "targetname");
    var2 = [];

    for(var3 = 0; var3 < var1.size; var3++) {
      if(var1[var3].classname == "script_origin") {
        var2 = var1[var3];
      }
    }

    if(isDefined(var0.script_autotarget)) {
      thread autotarget(var0);
    } else if(isDefined(var0.script_manualtarget)) {
      var0 setmode("manual_ai");
      thread manualtarget(var0);
    } else if(var2.size > 0) {
      if(var2.size == 1) {
        var0.manual_target = var2[0];
        var0 settargetentity(var2[0]);
        thread scripts\sp\mgturret::manual_think(var0);
      } else {
        var0 thread scripts\sp\mgturret::mg42_suppressionfire(var2);
      }
    }
  }

  thread player_use_turret_watcher(var0);
  thread scripts\sp\mgturret::mg42_firing(var0);
  var0 notify("startfiring");
}

function player_use_turret_watcher(var0) {
  self endon("death");

  if(self.team != "allies") {
    return;
  }

  var1 = spawn("trigger_radius", var0.origin, 0, 56, 56);
  thread scripts\engine\utility::delete_on_death(var1);
  var2 = 0;

  while(!var2) {
    var1 waittill("trigger");

    while(level.player istouching(var1)) {
      if(level.player useButtonPressed()) {
        var2 = 1;
        break;
      }

      wait 0.05;
    }
  }

  var1 delete();
  stop_using_turret();
}

function stop_using_turret() {
  self notify("stop_using_turret");
  self notify("stop_using_built_in_burst_fire");
  var0 = self getturret();

  if(!isDefined(var0)) {
    return;
  }

  self stopuseturret();
  scripts\asm\asm_bb::bb_requestturret(undefined);
  self stopanimScripted();
  var0 stopfiring();
}

function friendly_mgturret(var0) {
  var1 = getnode(var0.target, "targetname");
  var2 = getEnt(var1.target, "targetname");
  var2 setmode("auto_ai");
  var2 cleartargetentity();
  var3 = 0;

  for(;;) {
    var0 waittill("trigger", var4);

    if(!isai(var4)) {
      continue;
    }

    if(!isDefined(var4.team)) {
      continue;
    }

    if(var4.team != "allies") {
      continue;
    }

    if(isDefined(var4.script_usemg42) && var4.script_usemg42 == 0) {
      continue;
    }

    if(thread friendly_mg42_useable(var4, var2)) {
      thread friendly_mg42_think(var4, var2);
      var2 waittill("friendly_finished_using_mg42");

      if(isalive(var4)) {
        var4.turret_use_time = gettime() + 10000;
      }
    }

    wait 1;
  }
}

function friendly_mg42_death_notify(var0, var1) {
  var1 endon("friendly_finished_using_mg42");
  var0 waittill("death");
  var1 notify("friendly_finished_using_mg42");
}

function friendly_mg42_wait_for_use(var0) {
  var0 endon("friendly_finished_using_mg42");
  self.useable = 1;
  self setCursorHint("HINT_NOICON");
  self setHintString(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  self.useable = 0;
  self setHintString("");
  self stopuseturret();
  self notify("stopped_use_turret");
  var0 notify("friendly_finished_using_mg42");
}

function friendly_mg42_useable(var0, var1) {
  if(self.useable) {
    return false;
  }

  if(isDefined(self.turret_use_time) && gettime() < self.turret_use_time) {
    return false;
  }

  if(distance(level.player.origin, var1.origin) < 100) {
    return false;
  }

  return true;
}

function friendly_mg42_endtrigger(var0, var1) {
  var0 endon("friendly_finished_using_mg42");
  self waittill("trigger");
  var0 notify("friendly_finished_using_mg42");
}

function nofour() {
  self endon("death");
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32) {
    self.goalradius = 400;
    return;
  }
}

function friendly_mg42_think(var0, var1) {
  self endon("death");
  var0 endon("friendly_finished_using_mg42");
  thread friendly_mg42_death_notify(level, self);
  self.oldradius = self.goalradius;
  self.goalradius = 28;
  thread nofour();
  self setgoalnode(var1);
  self.ignoresuppression = 1;
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32) {
    self.goalradius = 400;
  }

  self.ignoresuppression = 0;
  self.goalradius = self.oldradius;

  if(distance(level.player.origin, var1.origin) < 32) {
    var0 notify("friendly_finished_using_mg42");
    return;
  }

  self.friendly_mg42 = var0;
  thread friendly_mg42_wait_for_use(var0);
  thread friendly_mg42_cleanup(var0);
  self useturret(var0);

  if(isDefined(var0.target)) {
    var2 = getEnt(var0.target, "targetname");

    if(isDefined(var2)) {
      thread friendly_mg42_endtrigger(var2, var0);
    }
  }

  for(;;) {
    if(distance(self.origin, var1.origin) < 32) {
      self useturret(var0);
    } else {
      break;
    }

    wait 1;
  }

  var0 notify("friendly_finished_using_mg42");
}

function friendly_mg42_cleanup(var0) {
  self endon("death");
  var0 waittill("friendly_finished_using_mg42");
  friendly_mg42_doneusingturret();
}

function friendly_mg42_doneusingturret() {
  self endon("death");
  var0 = self.friendly_mg42;
  self.friendly_mg42 = undefined;
  self stopuseturret();
  self notify("stopped_use_turret");
  self.useable = 0;
  self.goalradius = self.oldradius;

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.target)) {
    return;
  }

  var1 = getnode(var0.target, "targetname");
  var2 = self.goalradius;
  self.goalradius = 8;
  self setgoalnode(var1);
  wait 2;
  self.goalradius = 384;
}

function tanksquish() {
  if(isDefined(level.notanksquish)) {
    return;
  }

  if(isDefined(level.vehicle.has_vehicles) && !level.vehicle.has_vehicles) {
    return;
  }

  scripts\engine\sp\utility::add_damage_function(&tanksquish_damage_check);
}

function tanksquish_damage_check(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(self)) {
    return;
  }

  if(isalive(self)) {
    return;
  }

  if(!isalive(var1)) {
    return;
  }

  if(!isDefined(var1.vehicletype)) {
    return;
  }

  if(var1 scripts\common\vehicle::ishelicopter()) {
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

  scripts\engine\sp\utility::remove_damage_function(&tanksquish_damage_check);
}

function flood_and_secure(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn") {
    var0 = 1;
  }

  level.spawnerwave = [];
  var1 = getspawnerarray(self.target);
  scripts\engine\utility::array_thread(var1, &flood_and_secure_spawner, var0);
  var2 = 0;
  var3 = 0;

  for(;;) {
    self waittill("trigger", var4);

    if(!var3) {
      var3 = 1;
      scripts\engine\utility::script_delay();
    }

    if(self istouching(level.player)) {
      var2 = 1;
    } else {
      if(!isalive(var4)) {
        continue;
      }

      if(isPlayer(var4)) {
        var2 = 1;
      } else if(!isDefined(var4.issquad) || !var4.issquad) {
        continue;
      }
    }

    var1 = getspawnerarray(self.target);

    if(isDefined(var1[0])) {
      if(isDefined(var1[0].script_randomspawn)) {
        cull_spawners_from_killspawner(var1[0].script_randomspawn);
      }
    }

    var1 = getspawnerarray(self.target);

    for(var5 = 0; var5 < var1.size; var5++) {
      var1[var5].playertriggered = var2;
      var1[var5] notify("flood_begin");
    }

    if(var2) {
      wait 5;
      continue;
    }

    wait 0.1;
  }
}

function flood_and_secure_spawner(var0) {
  if(isDefined(self.securestarted)) {
    return;
  }

  self.securestarted = 1;
  self.triggerunlocked = 1;
  var1 = self.target;
  var2 = self.targetname;

  if(!isDefined(var1) && !isDefined(self.script_moveoverride)) {
    waittillframeend();
  }

  var3 = [];

  if(isDefined(var1)) {
    var4 = getspawnerarray(var1);

    for(var5 = 0; var5 < var4.size; var5++) {
      if(!issubstr(var4[var5].classname, "actor")) {
        continue;
      }

      var3 = var4[var5];
    }
  }

  var6 = spawnStruct();
  var7 = self.origin;
  flood_and_secure_spawner_think(var6, var3.size > 0, var0);

  if(isalive(var6.ai)) {
    var6.ai waittill("death");
  }

  if(!isDefined(var1)) {
    return;
  }

  var4 = getspawnerarray(var1);

  if(!var4.size) {
    return;
  }

  for(var5 = 0; var5 < var4.size; var5++) {
    if(!issubstr(var4[var5].classname, "actor")) {
      continue;
    }

    var4[var5].targetname = var2;
    var8 = var1;

    if(isDefined(var4[var5].target)) {
      var9 = getspawner(var4[var5].target, "targetname");

      if(!isDefined(var9) || !issubstr(var9.classname, "actor")) {
        var8 = var4[var5].target;
      }
    }

    var4[var5].target = var8;
    thread flood_and_secure_spawner(var4[var5]);
    var4[var5].playertriggered = 1;
    var4[var5] notify("flood_begin");
  }
}

function flood_and_secure_spawner_think(var0, var1, var2) {
  self endon("death");
  var3 = self.count;

  if(!var1) {
    var1 = isDefined(self.script_noteworthy) && self.script_noteworthy == "delete";
  }

  scripts\engine\sp\utility::set_count(2);

  if(isDefined(self.script_delay)) {
    var4 = self.script_delay;
  } else {
    var4 = 0;
  }

  for(;;) {
    self waittill("flood_begin");

    if(self.playertriggered) {
      break;
    }

    if(var4) {
      continue;
    }

    break;
  }

  var5 = distance(level.player.origin, self.origin);

  while(var4) {
    self.truecount = var4;
    scripts\engine\sp\utility::set_count(2);
    wait var4;
    var6 = scripts\engine\sp\utility::spawn_ai();

    if(scripts\common\ai::spawn_failed(var6)) {
      var7 = 0;

      if(var4 < 2) {
        wait 2;
      }

      continue;
    } else {
      thread addtowavespawner(var6);
      thread flood_and_secure_spawn(var6);

      if(isDefined(self.script_accuracy)) {
        var6.baseaccuracy = self.script_accuracy;
      }

      var1.ai = var6;
      var1 notify("got_ai");
      self waittill("spawn_died", var8, var7);

      if(var4 > 2) {
        var4 = randomint(4) + 2;
      } else {
        var4 = 0.5 + randomfloat(0.5);
      }
    }

    if(var8) {
      waittillrestartordistance(var5);
      continue;
    }

    if(playerwasnearby(var7 || var2, var1.ai)) {
      var4--;
    }

    if(!var3) {
      waituntilwaverelease();
    }
  }

  self delete();
}

function waittilldeletedordeath(var0) {
  self endon("death");
  var0 waittill("death");
}

function addtowavespawner(var0) {
  var1 = self.targetname;

  if(!isDefined(level.spawnerwave[var1])) {
    level.spawnerwave[var1] = spawnStruct();
    level.spawnerwave[var1] scripts\engine\sp\utility::set_count(0);
    level.spawnerwave[var1].total = 0;
  }

  if(!isDefined(self.addedtowave)) {
    self.addedtowave = 1;
    level.spawnerwave[var1].total++;
  }

  level.spawnerwave[var1].count++;
  waittilldeletedordeath(var0);
  level.spawnerwave[var1].count--;

  if(!isDefined(self)) {
    level.spawnerwave[var1].total--;
  }

  if(level.spawnerwave[var1].total) {
    if(level.spawnerwave[var1].count / level.spawnerwave[var1].total < 0.32) {
      level.spawnerwave[var1] notify("waveReady");
      return;
    }

    return;
  }
}

function waituntilwaverelease() {
  var0 = self.targetname;

  if(level.spawnerwave[var0].count) {
    level.spawnerwave[var0] waittill("waveReady");
    return;
  }
}

function playerwasnearby(var0, var1) {
  if(var0) {
    return 1;
  }

  if(isDefined(var1) && isDefined(var1.origin)) {
    var2 = var1.origin;
  } else {
    var2 = self.origin;
  }

  if(distance(level.player.origin, var2) < 700) {
    return 1;
  }

  return scripts\engine\trace::_bullet_trace_passed(level.player getEye(), var2 getEye(), 0, undefined);
}

function waittillrestartordistance(var0) {
  self endon("flood_begin");
  var0 *= 0.75;

  while(distance(level.player.origin, self.origin) > var0) {
    wait 1;
  }
}

function flood_and_secure_spawn(var0) {
  thread flood_and_secure_spawn_goal();
  self waittill("death", var1);
  var2 = isalive(var1) && isPlayer(var1);

  if(!var2 && isDefined(var1) && var1.classname == "worldspawn") {
    var2 = 1;
  }

  var3 = !isDefined(self);
  var0 notify("spawn_died", var3, var2);
}

function flood_and_secure_spawn_goal() {
  if(isDefined(self.script_moveoverride)) {
    return;
  }

  self endon("death");
  var0 = getnode(self.target, "targetname");

  if(isDefined(var0)) {
    self setgoalnode(var0);
  } else {
    var0 = getEnt(self.target, "targetname");

    if(isDefined(var0)) {
      self setgoalpos(var0.origin);
    }
  }

  if(isDefined(level.fightdist)) {
    self.pathenemyfightdist = level.fightdist;
    self.pathenemylookahead = level.maxdist;
  }

  if(isDefined(var0.radius) && var0.radius >= 0) {
    self.goalradius = var0.radius;
  } else {
    self.goalradius = 256;
  }

  self waittill("goal");

  while(isDefined(var0.target)) {
    var1 = getnode(var0.target, "targetname");

    if(isDefined(var1)) {
      var0 = var1;
    } else {
      break;
    }

    self setgoalnode(var0);

    if(node_has_radius(var0)) {
      self.goalradius = var0.radius;
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

  if(isDefined(var0.target)) {
    var2 = getEnt(var0.target, "targetname");

    if(isDefined(var2) && var2.code_classname == "misc_turret") {
      self setgoalnode(var0);
      self.goalradius = 4;
      self waittill("goal");

      if(!isDefined(self.script_forcegoal)) {
        self.goalradius = level.default_goalradius;
      }

      use_a_turret(var2);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "hide") {
      thread scripts\engine\sp\utility::set_battlechatter(0);
      return;
    }
  }

  if(!isDefined(self.script_forcegoal) && !isDefined(self getgoalvolume())) {
    self.goalradius = level.default_goalradius;
    return;
  }
}

function goalvolumes() {
  var0 = getEntArray("info_volume", "classname");
  level.deathchain_goalvolume = [];
  level.goalvolumes = [];

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(isDefined(var2.script_deathchain)) {
      level.deathchain_goalvolume[var2.script_deathchain] = var2;
    }

    if(isDefined(var2.script_goalvolume)) {
      level.goalvolumes[var2.script_goalvolume] = var2;
    }
  }
}

function aigroup_create(var0) {
  level._ai_group[var0] = spawnStruct();
  level._ai_group[var0].aicount = 0;
  level._ai_group[var0].aideaths = 0;
  level._ai_group[var0].spawnercount = 0;
  level._ai_group[var0].ai = [];
  level._ai_group[var0].spawners = [];
}

function aigroup_spawnerthink(var0) {
  self endon("death");
  self endon("stop_aigroup_spawnerthink");
  self.decremented = 0;
  var0.spawnercount++;
  var0.spawners = scripts\engine\utility::array_add(var0.spawners, self);
  thread aigroup_spawnerdeath(var0);
  thread aigroup_spawnerempty(var0);
  self waittill("spawned", var1);

  if(!scripts\common\ai::spawn_failed(var1)) {
    thread aigroup_soldierthink(var1);
  }

  aigroup_decrement(var0);
}

function aigroup_decrement(var0) {
  if(self.decremented) {
    return;
  }

  self.decremented = 1;
  var0.spawnercount--;
  self notify("stop_aigroup_spawnerthink");
}

function aigroup_spawnerdeath(var0) {
  self waittill("death");

  if(isDefined(self)) {
    aigroup_decrement(var0);
    return;
  }
}

function aigroup_spawnerempty(var0) {
  self endon("death");
  self waittill("emptied spawner");
  aigroup_decrement(var0);
}

function aigroup_soldierthink(var0) {
  var0.aicount++;
  var0.ai[var0.ai.size] = self;

  if(isDefined(self.script_deathflag_longdeath)) {
    waittilldeathorpaindeath();
  } else {
    self waittill("death");
  }

  var0.aicount--;
  var0.aideaths++;
}

function camper_trigger_think(var0) {
  var1 = strtok(var0.script_linkto, " ");
  var2 = [];
  var3 = [];

  for(var4 = 0; var4 < var1.size; var4++) {
    var5 = var1[var4];
    var6 = getspawner(var5, "script_linkname");

    if(isDefined(var6)) {
      var2 = scripts\engine\utility::array_add_safe(var2, var6);
      continue;
    }

    var7 = getnode(var5, "script_linkname");

    if(!isDefined(var7)) {
      continue;
    }

    var3 = scripts\engine\utility::array_add_safe(var3, var7);
  }

  var0 waittill("trigger");
  var3 = scripts\engine\utility::array_randomize(var3);

  for(var4 = 0; var4 < var3.size; var4++) {
    var3[var4].claimed = 0;
  }

  var8 = 0;

  for(var4 = 0; var4 < var2.size; var4++) {
    var9 = var2[var4];

    if(!isDefined(var9)) {
      continue;
    }

    if(isDefined(var9.script_spawn_here)) {
      continue;
    }

    while(isDefined(var3[var8].script_noteworthy) && var3[var8].script_noteworthy == "dont_spawn") {
      var8++;
    }

    var9.origin = var3[var8].origin;
    var9.angles = var3[var8].angles;
    var9 scripts\engine\sp\utility::add_spawn_function(&claim_a_node, var3[var8]);
    var8++;
  }

  scripts\engine\utility::array_thread(var2, &scripts\engine\sp\utility::add_spawn_function, &camper_guy);
  scripts\engine\utility::array_thread(var2, &scripts\engine\sp\utility::add_spawn_function, &move_when_enemy_hides, var3);
  scripts\engine\utility::array_thread(var2, &scripts\engine\sp\utility::spawn_ai);
}

function camper_guy() {
  self.goalradius = 8;
  self.fixednode = 1;
}

function move_when_enemy_hides(var0) {
  self endon("death");
  var1 = 0;

  for(;;) {
    if(!isalive(self.enemy)) {
      self waittill("enemy");
      var1 = 0;
      continue;
    }

    if(isPlayer(self.enemy)) {
      if(self.enemy scripts\sp\player::belowcriticalhealththreshold() || self.enemy scripts\engine\utility::isflashed()) {
        self.fixednode = 0;

        for(;;) {
          self.goalradius = 180;
          self setgoalpos(level.player.origin);
          wait 1;
        }

        return;
      }
    }

    if(var1) {
      if(self cansee(self.enemy)) {
        wait 0.05;
        continue;
      }

      var1 = 0;
    } else {
      if(self cansee(self.enemy)) {
        var1 = 1;
      }

      wait 0.05;
      continue;
    }

    if(randomint(3) > 0) {
      var2 = find_unclaimed_node(var0);

      if(isDefined(var2)) {
        claim_a_node(var2, self.claimed_node);
        self waittill("goal");
      }
    }
  }
}

function claim_a_node(var0, var1) {
  self setgoalnode(var0);
  self.claimed_node = var0;
  var0.claimed = 1;

  if(isDefined(var1)) {
    var1.claimed = 0;
    return;
  }
}

function find_unclaimed_node(var0) {
  for(var1 = 0; var1 < var0.size; var1++) {
    if(var0[var1].claimed) {
      continue;
    }

    return var0[var1];
  }

  return undefined;
}

function flood_trigger_think(var0) {
  var1 = getspawnerarray(var0.target);
  scripts\engine\utility::array_thread(var1, &flood_spawner_init);
  var0 waittill("trigger");
  var1 = getspawnerarray(var0.target);
  scripts\engine\utility::array_thread(var1, &flood_spawner_think, var0);
}

function flood_spawner_init() {}

function trigger_requires_player(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  return isDefined(var0.script_requires_player);
}

function flood_spawner_think(var0) {
  if(isspawner(self)) {
    self endon("death");
  }

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");

  if(is_pyramid_spawner()) {
    pyramid_spawn(var0);
    return;
  }

  var1 = trigger_requires_player(var0);
  scripts\engine\utility::script_delay();

  while(self.count > 0) {
    while(var1 && !level.player istouching(var0)) {
      wait 0.5;
    }

    var2 = scripts\engine\sp\utility::spawn_ai();

    if(scripts\common\ai::spawn_failed(var2)) {
      wait 2;
      continue;
    }

    thread reincrement_count_if_deleted(var2);
    var2 waittill("death", var3);

    if(!player_saw_kill(var2, var3)) {
      self.count++;
    }

    if(!scripts\engine\utility::script_wait()) {
      wait randomfloatrange(5, 9);
      LOC_000000b7:
    }
    LOC_000000b7:
  }
}

function player_saw_kill(var0, var1) {
  if(isDefined(self.script_force_count)) {
    if(self.script_force_count) {
      return 1;
    }
  }

  if(!isDefined(var0)) {
    return 0;
  }

  if(isalive(var1)) {
    if(isPlayer(var1)) {
      return 1;
    }

    if(distance(var1.origin, level.player.origin) < 200) {
      return 1;
    }
  } else if(isDefined(var1)) {
    if(var1.classname == "worldspawn") {
      return 0;
    }

    if(distance(var1.origin, level.player.origin) < 200) {
      return 1;
    }
  }

  if(distance(var0.origin, level.player.origin) < 200) {
    return 1;
  }

  return scripts\engine\trace::_bullet_trace_passed(level.player getEye(), var0 getEye(), 0, undefined);
}

function is_pyramid_spawner() {
  if(!isDefined(self.target)) {
    return 0;
  }

  var0 = getspawnerarray(self.target);

  if(!var0.size) {
    return 0;
  }

  return issubstr(var0[0].classname, "actor");
}

function pyramid_death_report(var0) {
  var0.spawn waittill("death");
  self notify("death_report");
}

function pyramid_spawn(var0) {
  self endon("death");
  var1 = trigger_requires_player(var0);
  scripts\engine\utility::script_delay();

  if(var1) {
    while(!level.player istouching(var0)) {
      wait 0.5;
    }
  }

  var2 = getspawnerarray(self.target);
  self.spawners = 0;
  scripts\engine\utility::array_thread(var2, &pyramid_spawner_reports_death, self);
  var4 = randomint(var2.size);

  for(var3 = 0; var3 < var2.size; var3++) {
    if(self.count <= 0) {
      return;
    }

    var4++;

    if(var4 >= var2.size) {
      var4 = 0;
    }

    var5 = var2[var4];
    var5 scripts\engine\sp\utility::set_count(1);
    var6 = var5 scripts\engine\sp\utility::spawn_ai();

    if(scripts\common\ai::spawn_failed(var6)) {
      wait 2;
      continue;
    }

    self.count--;
    var5.spawn = var6;
    thread reincrement_count_if_deleted(var6);
    thread expand_goalRadius(var6);
    thread pyramid_death_report(var5);
  }

  var7 = 0.01;

  while(self.count > 0) {
    self waittill("death_report");
    var8 = 0;

    foreach(var5 in var2) {
      var5.postspawnresetorigin = 1;

      if(isDefined(var5.suspended_ai)) {
        var8 = 1;
      }
    }

    if(var8) {
      var0 waittill("trigger");
    }

    scripts\engine\utility::script_wait();
    var4 = randomint(var2.size);

    for(var3 = 0; var3 < var2.size; var3++) {
      var2 = scripts\engine\utility::array_removeundefined(var2);

      if(!var2.size) {
        if(isDefined(self)) {
          self delete();
        }

        return;
      }

      var4++;

      if(var4 >= var2.size) {
        var4 = 0;
      }

      var5 = var2[var4];

      if(isDefined(var5.target)) {
        self.target = var5.target;
      } else {
        self.target = undefined;
      }

      var6 = scripts\engine\sp\utility::spawn_ai();

      if(scripts\common\ai::spawn_failed(var6)) {
        wait 2;
        continue;
      }

      thread reincrement_count_if_deleted(var6);
      thread expand_goalRadius(var6);
      var5.spawn = var6;
      thread pyramid_death_report(var5);

      if(self.count <= 0) {
        return;
      }
      LOC_000001f6:
    }
  }
}

function pyramid_spawner_reports_death(var0) {
  var0 endon("death");
  var0.spawners++;
  self waittill("death");
  var0.spawners--;

  if(!var0.spawners) {
    var0 delete();
    return;
  }
}

function expand_goalRadius(var0) {
  if(isDefined(self.script_forcegoal)) {
    return;
  }

  var1 = level.default_goalradius;

  if(isDefined(var0)) {
    if(isDefined(var0.script_radius)) {
      if(var0.script_radius == -1) {
        return;
      }

      var1 = var0.script_radius;
    }
  }

  if(isDefined(self.script_forcegoal)) {
    return;
  }

  self endon("death");
  self waittill("goal");
  self.goalradius = var1;
}

function show_bad_path() {}

function random_spawn(var0) {
  var0 waittill("trigger");
  var1 = getspawnerarray(var0.target);

  if(!var1.size) {
    return;
  }

  var2 = scripts\engine\utility::random(var1);
  var1 = [];
  var1 = var2;

  if(isDefined(var2.script_linkto)) {
    var3 = strtok(var2.script_linkto, " ");

    for(var4 = 0; var4 < var3.size; var4++) {
      var1 = getspawner(var3[var4], "script_linkname");
    }
  }

  waittillframeend();
  scripts\engine\utility::array_thread(var1, &scripts\engine\sp\utility::add_spawn_function, &blowout_goalradius_on_pathend);
  scripts\engine\utility::array_thread(var1, &scripts\engine\sp\utility::spawn_ai);
}

function blowout_goalradius_on_pathend() {
  if(isDefined(self.script_forcegoal)) {
    return;
  }

  self endon("death");
  self waittill("reached_path_end");

  if(!isDefined(self getgoalvolume())) {
    self.goalradius = level.default_goalradius;
    return;
  }
}

function spawner_dronespawn(var0) {
  var1 = var0 spawndrone();

  if(!getqueuedspleveltransients(var1.weapon)) {
    var2 = scripts\sp\utility::getweapondefaults(var1.weapon.basename);

    if(var2.size == 0) {
      var3 = getweaponmodel(var1.weapon);
      var1 attach(var3, "tag_weapon_right");
      var4 = getweaponhidetags(var1.weapon);

      for(var5 = 0; var5 < var4.size; var5++) {
        var6 = var4[var5];

        if(scripts\engine\utility::hastag(var3, var6)) {
          var1 hidepart(var6, var3);
        }
      }
    } else {
      if(!istrue(var1.usescriptedweapon)) {
        var7 = scripts\sp\utility::removeconflictingattachments(var1.weapon.attachments, var2);
        var1.weapon = var1.weapon withoutattachments();
        var1.weapon = var1.weapon withattachments(scripts\engine\utility::array_combine(var7, var1.weapon.attachments));
      }

      var1 scripts\common\ai::gun_create_fake(getweaponattachmentworldmodels(var1.weapon));

      if(!istrue(self.nodrop)) {
        var1.weapon_object = var1.weapon;
      }

      var1.weapon = isundefinedweapon();
    }
  }

  var1 scripts\sp\utility::enable_procedural_bones();
  var1.spawner = var0;
  var1.drone_delete_on_unload = isDefined(var0.script_noteworthy) && var0.script_noteworthy == "drone_delete_on_unload";
  var1.finished_spawning = 1;
  var1 notify("finished spawning");
  var0 notify("drone_spawned", var1);
  return var1;
}

function spawner_makerealai(var0, var1) {
  if(isDefined(var0.spawner)) {}

  var2 = var0.spawner.origin;
  var3 = var0.spawner.angles;
  var4 = var0.spawner.target;
  var0.spawner.origin = var0.origin;
  var0.spawner.angles = var0.angles;

  if(isDefined(var1)) {
    var0.spawner.target = var1;
  }

  var0.spawner.count += 1;
  var5 = var0.spawner stalingradspawn();
  var6 = scripts\common\ai::spawn_failed(var5);

  if(var6) {}

  var5.vehicle_idling = var0.vehicle_idling;
  var5.vehicle_position = var0.vehicle_position;
  var5.standing = var0.standing;
  var5.forcecolor = var0.forcecolor;
  var0.spawner.origin = var2;
  var0.spawner.angles = var3;
  var0.spawner.target = var4;
  var0 delete();
  return var5;
}

function spawner_makefakeactor(var0, var1) {
  if(isDefined(var0.spawner)) {}

  var2 = var0.spawner.origin;
  var3 = var0.spawner.angles;
  var4 = var0.spawner.target;
  var0.spawner.origin = var0.origin;
  var0.spawner.angles = var0.angles;

  if(isDefined(var1)) {
    var0.spawner.target = var1;
  }

  var0.spawner.count += 1;
  var5 = scripts\engine\sp\utility::fakeactorspawn(var0.spawner);
  var6 = scripts\common\ai::spawn_failed(var5);

  if(var6) {}

  var5.vehicle_idling = var0.vehicle_idling;
  var5.vehicle_position = var0.vehicle_position;
  var5.standing = var0.standing;
  var5.forcecolor = var0.forcecolor;
  var0.spawner.origin = var2;
  var0.spawner.angles = var3;
  var0.spawner.target = var4;
  var0 delete();
  return var5;
}

function add_random_killspawner_to_spawngroup() {
  var0 = self.script_random_killspawner;
  var1 = self.script_randomspawn;

  if(!isDefined(level.killspawn_groups)) {
    level.killspawn_groups = [];
  }

  if(!isDefined(level.killspawn_groups[var0])) {
    level.killspawn_groups[var0] = [];
  }

  if(!isDefined(level.killspawn_groups[var0][var1])) {
    level.killspawn_groups[var0][var1] = [];
  }

  level.killspawn_groups[var0][var1][self.export] = self;
}

function add_to_spawngroup() {
  var0 = self.script_spawngroup;
  var1 = self.script_spawnsubgroup;

  if(!isDefined(level.spawn_groups[var0])) {
    level.spawn_groups[var0] = [];
  }

  if(!isDefined(level.spawn_groups[var0][var1])) {
    level.spawn_groups[var0][var1] = [];
  }

  level.spawn_groups[var0][var1][self.export] = self;
}

function start_off_running() {
  self endon("death");
  self.disableexits = 1;
  wait 3;
  self.disableexits = 0;
}

function deathtime() {
  self endon("death");
  wait self.script_deathtime;
  wait randomfloat(10);
  self kill();
}

function tracker_bullet_hit(var0) {
  self notify("tracker_bullet_hit");
  self endon("tracker_bullet_hit");

  if(self.team != "axis") {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  scripts\engine\sp\utility::hudoutline_enable_new("outlinefill_nodepth_red", "tracker");
  scripts\engine\utility::waittill_notify_or_timeout("death", 5);
  scripts\engine\sp\utility::hudoutline_disable("tracker");

  if(isalive(self)) {
    for(var1 = 0; var1 < 3; var1++) {
      wait 0.2;
      scripts\engine\sp\utility::hudoutline_enable_new("outlinefill_nodepth_red", "tracker");
      wait 0.15;
      scripts\engine\sp\utility::hudoutline_disable("tracker");
    }

    return;
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
  var0 = self.spawner.suspended_ai;

  if(isDefined(self.spawner.postspawnresetorigin)) {
    self.spawner.origin = self.og_spawner_origin;
    self.spawner.angles = self.og_spawner_angles;
  }

  thread postspawn_suspend_ai_framedelay(var0);

  if(!isDefined(var0.suspendvars)) {
    return;
  }

  self.suspendvars = var0.suspendvars;
  self.spawner.suspended_ai = undefined;
}

function postspawn_suspend_ai_framedelay(var0) {
  waittillframeend();
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var0.stealth)) {
    var1 = var0.stealth.bsmstate;

    if(var1 > 1) {
      var1 = var0.stealth.bsmstate - int((gettime() - var0.suspendtime) / 10000);
      var1 = int(max(2, var1));
    } else if(var1 > 0) {
      var1 = var0.stealth.bsmstate - int((gettime() - var0.suspendtime) / 5000);
      var1 = int(max(0, var1));
    }

    var2 = int_to_stealth_state(var1);
    scripts\stealth\enemy::bt_set_stealth_state(var2, var0.stealth.investigateevent);
    return;
  }
}

function int_to_stealth_state(var0) {
  switch (var0) {
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

function trigger_zone_spawn(var0) {
  var0 endon("death");
  var1 = undefined;

  if(isDefined(var0.script_suspend)) {
    var1 = var0.script_suspend;
  }

  var2 = undefined;

  if(isDefined(var0.script_suspend_group)) {
    var2 = var0.script_suspend_group;
  }

  var3 = getspawnerarray(var0.target);

  foreach(var5 in var3) {
    if(!isDefined(var5.script_suspend)) {
      var5.script_suspend = var1;
    }

    if(!isDefined(var5.script_suspend_group)) {
      var5.script_suspend_group = var2;
    }
  }

  for(;;) {
    var0 waittill("trigger", var7);
    var0 scripts\engine\utility::script_delay();
    var3 = getspawnerarray(var0.target);

    foreach(var5 in var3) {
      var5 thread scripts\engine\sp\utility::spawn_ai();
    }

    while(isalive(var7) && var7 istouching(var0)) {
      wait 0.1;
    }
  }
}

function spawn_subclass_juggernaut() {
  if(!isDefined(level.juggernaut_initialized)) {
    level.juggernaut_initialized = 1;
    level.juggernaut_next_alert_time = 0;
  }

  scripts\common\ai::disable_turnanims();
  scripts\engine\sp\utility::disable_surprise();
  thread juggernaut_sound_when_close();
}

function juggernaut_sound_when_close() {
  self endon("death");

  for(;;) {
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

  level.player scripts\engine\sp\utility::playlocalsoundwrapper("mx_juggernaut_intro");
}