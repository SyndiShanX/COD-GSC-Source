/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\spawner.gsc
***********************************************/

main() {
  level.spawn_funcs = [];
  level.spawn_funcs["allies"] = [];
  level.spawn_funcs["axis"] = [];
  level.spawn_funcs["team3"] = [];
  level.spawn_funcs["neutral"] = [];
  thread goalvolumes();
  var_0 = getEntArray("flood_and_secure", "targetname");
  scripts\engine\utility::array_thread(var_0, ::flood_and_secure);

  if(!isDefined(level.ai_number))
    level.ai_number = 0;

  if(getDvar("fallback") == "")
    setDvar("fallback", "0");

  if(getDvar("noai") == "")
    setDvar("noai", "off");

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

  foreach(var_2 in level.players)
  var_2 setthreatbiasgroup("allies");

  level._ai_group = [];
  level.gather_delay = [];

  if(!isDefined(level.deathflags))
    level.deathflags = [];

  level.spawner_number = 0;

  if(!isDefined(level.unittype_spawn_functions))
    level.unittype_spawn_functions = [];

  level.unittype_spawn_functions["soldier"] = ::spawn_unittype_soldier;

  if(!isDefined(level.subclass_spawn_functions))
    level.subclass_spawn_functions = [];

  level.subclass_spawn_functions["juggernaut"] = ::spawn_subclass_juggernaut;
  level.team_specific_spawn_functions = [];
  level.team_specific_spawn_functions["axis"] = ::spawn_team_axis;
  level.team_specific_spawn_functions["allies"] = ::spawn_team_allies;
  level.team_specific_spawn_functions["team3"] = ::spawn_team_team3;
  level.team_specific_spawn_functions["neutral"] = ::spawn_team_neutral;

  if(!isDefined(level.default_goalradius))
    level.default_goalradius = 2048;

  if(!isDefined(level.default_goalheight))
    level.default_goalheight = 512;

  level.portable_mg_gun_tag = "J_Shoulder_RI";
  level._max_script_health = 0;
  var_4 = getaispeciesarray();
  scripts\engine\utility::array_thread(var_4, ::living_ai_prethink);
  level.ai_classname_in_level = [];
  level.drone_paths = [];
  var_5 = getspawnerarray();

  for(var_6 = 0; var_6 < var_5.size; var_6++)
    var_5[var_6] thread spawn_prethink();

  level.drone_paths = undefined;
  scripts\engine\sp\utility::hudoutline_add_child_channel("tracker", 1, "default");
  thread process_deathflags();
  scripts\engine\utility::array_thread(var_4, ::spawn_think);
  var_7 = getarraykeys(level.ai_classname_in_level);

  for(var_6 = 0; var_6 < var_7.size; var_6++) {
    var_8 = tolower(var_7[var_6]);

    if(!issubstr(var_8, "rpg")) {
      continue;
    }
    var_9 = "iw8_la_rpapa7";
    precacheitem(var_9);
    break;
  }

  var_7 = undefined;
}

aitype_check() {}

process_deathflags() {
  foreach(var_2, var_1 in level.deathflags) {
    if(!isDefined(level.flag[var_2]))
      scripts\engine\utility::flag_init(var_2);
  }
}

spawn_guys_until_death_or_no_count() {
  self endon("death");

  for(;;) {
    if(self.count > 0)
      self waittill("spawned");

    waittillframeend;

    if(!self.count)
      return;
  }
}

ai_deathflag() {
  level.deathflags[self.script_deathflag]["ai"][self.unique_id] = self;
  var_0 = self.unique_id;
  var_1 = self.script_deathflag;

  if(isDefined(self.script_deathflag_longdeath))
    waittilldeathorpaindeath();
  else
    self waittill("death");

  level.deathflags[var_1]["ai"][var_0] = undefined;
  update_deathflag(var_1);
}

vehicle_deathflag() {
  var_0 = self.unique_id;
  var_1 = self.script_deathflag;

  if(!isDefined(level.deathflags) || !isDefined(level.deathflags[self.script_deathflag])) {
    waittillframeend;

    if(!isDefined(self))
      return;
  }

  level.deathflags[var_1]["vehicles"][var_0] = self;
  self waittill("death");
  level.deathflags[var_1]["vehicles"][var_0] = undefined;
  update_deathflag(var_1);
}

spawner_deathflag() {
  level.deathflags[self.script_deathflag] = [];
  waittillframeend;

  if(!isDefined(self) || self.count == 0) {
    return;
  }
  self.spawner_number = level.spawner_number;
  level.spawner_number++;
  level.deathflags[self.script_deathflag]["spawners"][self.spawner_number] = self;
  var_0 = self.script_deathflag;
  var_1 = self.spawner_number;
  spawn_guys_until_death_or_no_count();
  level.deathflags[var_0]["spawners"][var_1] = undefined;
  update_deathflag(var_0);
}

vehicle_spawner_deathflag() {
  level.deathflags[self.script_deathflag] = [];
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  self.spawner_number = level.spawner_number;
  level.spawner_number++;
  level.deathflags[self.script_deathflag]["vehicle_spawners"][self.spawner_number] = self;
  var_0 = self.script_deathflag;
  var_1 = self.spawner_number;
  spawn_guys_until_death_or_no_count();
  level.deathflags[var_0]["vehicle_spawners"][var_1] = undefined;
  update_deathflag(var_0);
}

update_deathflag(var_0) {
  level notify("updating_deathflag_" + var_0);
  level endon("updating_deathflag_" + var_0);
  waittillframeend;

  foreach(var_3, var_2 in level.deathflags[var_0]) {
    if(getarraykeys(var_2).size > 0)
      return;
  }

  scripts\engine\utility::flag_set(var_0);
}

outdoor_think(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isai(var_1)) {
      continue;
    }
    var_1 thread scripts\engine\sp\utility::ignore_triggers(0.15);
    var_1 scripts\common\utility::disable_cqbwalk();
  }
}

indoor_think(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isai(var_1)) {
      continue;
    }
    var_1 thread scripts\engine\sp\utility::ignore_triggers(0.15);
    var_1 scripts\common\utility::enable_cqbwalk();
  }
}

trigger_spawner(var_0) {
  var_0 waittill("trigger");
  var_1 = var_0.target;
  var_0 scripts\engine\utility::script_delay();
  var_2 = scripts\engine\utility::array_combine(getspawnerarray(var_1), vehicle_getspawnerarray(var_1));

  foreach(var_4 in var_2) {
    if(!isnonentspawner(var_4) && var_4.code_classname == "script_vehicle") {
      if(isDefined(var_4.script_moveoverride) && var_4.script_moveoverride == 1 || !isDefined(var_4.target))
        thread scripts\common\vehicle::vehicle_spawn(var_4);
      else
        var_4 thread scripts\common\vehicle::spawn_vehicle_and_gopath();

      continue;
    }

    var_4 thread scripts\engine\sp\utility::spawn_ai();
  }
}

trigger_spawner_reinforcement(var_0) {
  var_1 = var_0.target;
  var_2 = 0;
  var_3 = getspawnerarray(var_1);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.target)) {
      continue;
    }
    var_6 = getspawner(var_5.target, "targetname");

    if(!isDefined(var_6)) {
      if(!isDefined(var_5.script_linkto)) {
        continue;
      }
      var_6 = getspawner(var_5.script_linkto, "script_linkname");

      if(!isDefined(var_6))
        var_6 = var_5 scripts\engine\utility::get_linked_ent();

      if(!isDefined(var_6)) {
        continue;
      }
      if(!isspawner(var_6))
        continue;
    }

    var_2 = 1;
    break;
  }

  var_0 waittill("trigger");
  var_0 scripts\engine\utility::script_delay();
  var_3 = getspawnerarray(var_1);

  foreach(var_5 in var_3)
  var_5 thread trigger_reinforcement_spawn_guys();
}

trigger_reinforcement_spawn_guys() {
  var_0 = trigger_reinforcement_get_reinforcement_spawner();
  var_1 = scripts\engine\sp\utility::spawn_ai();

  if(!isDefined(var_1)) {
    self delete();

    if(isDefined(var_0)) {
      var_1 = var_0 scripts\engine\sp\utility::spawn_ai();
      var_0 delete();

      if(!isDefined(var_1))
        return;
    } else
      return;
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_1 waittill("death");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.count))
    var_0.count = 1;

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    var_2 = var_0 scripts\engine\sp\utility::spawn_ai();

    if(!isDefined(var_2)) {
      var_0 delete();
      break;
    }

    var_2 thread reincrement_count_if_deleted(var_0);
    var_2 waittill("death", var_3);

    if(!player_saw_kill(var_2, var_3)) {
      if(!isDefined(var_0)) {
        break;
      }

      var_0.count++;
    }

    if(!isDefined(var_2)) {
      continue;
    }
    if(!isDefined(var_0)) {
      break;
    }

    if(!isDefined(var_0.count)) {
      break;
    }

    if(var_0.count <= 0) {
      break;
    }

    if(!scripts\engine\utility::script_wait())
      wait(randomfloatrange(1, 3));
  }

  if(isDefined(var_0))
    var_0 delete();
}

trigger_reinforcement_get_reinforcement_spawner() {
  if(isDefined(self.target)) {
    var_0 = getspawner(self.target, "targetname");

    if(isDefined(var_0) && isspawner(var_0))
      return var_0;
  }

  if(isDefined(self.script_linkto)) {
    var_0 = getspawner(self.script_linkto, "script_linkname");

    if(!isDefined(var_0))
      var_0 = scripts\engine\utility::get_linked_ent();

    if(isDefined(var_0) && isspawner(var_0))
      return var_0;
  }

  return undefined;
}

flood_spawner_scripted(var_0) {
  scripts\engine\utility::array_thread(var_0, ::flood_spawner_init);
  scripts\engine\utility::array_thread(var_0, ::flood_spawner_think);
}

reincrement_count_if_deleted(var_0) {
  var_0 endon("death");

  if(isDefined(self.script_force_count)) {
    if(self.script_force_count)
      return;
  }

  self waittill("death");

  if(!isDefined(self))
    var_0.count++;
}

kill_spawner(var_0) {
  var_1 = var_0.script_killspawner;
  var_0 waittill("trigger");
  waittillframeend;
  waittillframeend;
  killspawner(var_1);
  kill_trigger(var_0);
}

killspawner(var_0) {
  var_1 = getspawnerarray();
  var_2 = vehicle_getspawnerarray();
  var_3 = scripts\engine\utility::array_combine(var_1, var_2);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(isDefined(var_3[var_4].script_killspawner) && var_0 == var_3[var_4].script_killspawner) {
      if(isnonentspawner(var_3[var_4]))
        var_3[var_4] notify("death");

      var_3[var_4] delete();
    }
  }
}

kill_trigger(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.targetname) && var_0.targetname != "flood_spawner") {
    return;
  }
  var_0 delete();
}

random_killspawner(var_0) {
  var_0 endon("death");
  var_1 = var_0.script_random_killspawner;
  waittillframeend;

  if(!isDefined(level.killspawn_groups))
    level.killspawn_groups = [];

  if(!isDefined(level.killspawn_groups[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  cull_spawners_from_killspawner(var_1);
}

cull_spawners_from_killspawner(var_0) {
  if(!isDefined(level.killspawn_groups))
    level.killspawn_groups = [];

  if(!isDefined(level.killspawn_groups[var_0])) {
    return;
  }
  var_1 = level.killspawn_groups[var_0];
  var_2 = getarraykeys(var_1);

  if(var_2.size <= 1) {
    return;
  }
  var_3 = scripts\engine\utility::random(var_2);
  var_1[var_3] = undefined;

  foreach(var_9, var_5 in var_1) {
    foreach(var_8, var_7 in var_5) {
      if(isDefined(var_7))
        var_7 delete();
    }

    level.killspawn_groups[var_0][var_9] = undefined;
  }
}

empty_spawner(var_0) {
  var_1 = var_0.script_emptyspawner;
  var_0 waittill("trigger");
  var_2 = getspawnerarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_2[var_3].script_emptyspawner)) {
      continue;
    }
    if(var_1 != var_2[var_3].script_emptyspawner) {
      continue;
    }
    var_2[var_3] scripts\engine\sp\utility::set_count(0);
    var_2[var_3] notify("emptied spawner");
  }

  var_0 notify("deleted spawners");
}

kill_spawnernum(var_0) {
  var_1 = getspawnerarray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_killspawner)) {
      continue;
    }
    if(var_0 != var_3.script_killspawner) {
      continue;
    }
    var_3 delete();
  }
}

spawn_grenade(var_0, var_1) {
  var_2 = spawn("weapon_frag", var_0);
  var_2 thread add_to_grenade_cache(var_1);
  return var_2;
}

add_to_grenade_cache(var_0) {
  if(!isDefined(level.grenade_cache) || !isDefined(level.grenade_cache[var_0])) {
    level.grenade_cache_index[var_0] = 0;
    level.grenade_cache[var_0] = [];
  }

  var_1 = level.grenade_cache_index[var_0];
  var_2 = level.grenade_cache[var_0][var_1];

  if(isDefined(var_2))
    var_2 delete();

  level.grenade_cache[var_0][var_1] = self;
  level.grenade_cache_index[var_0] = (var_1 + 1) % 16;
}

waittilldeathorpaindeath() {
  self endon("death");
  self waittill("long_death");
}

dronespawner_init() {
  scripts\sp\drone_base::drone_init_path();
}

fakeactorspawner_init() {
  scripts\sp\fakeactor::fakeactor_spawner_init();
}

spawn_prethink() {
  level.ai_classname_in_level[self.classname] = 1;

  if(isDefined(self.script_difficulty)) {
    switch (self.script_difficulty) {
      case "easy":
        if(level.gameskill > 1)
          scripts\engine\sp\utility::set_count(0);

        break;
      case "hard":
        if(level.gameskill < 2)
          scripts\engine\sp\utility::set_count(0);

        break;
    }
  }

  init_stealth();

  if(isDefined(self.script_drone))
    thread dronespawner_init();

  if(isDefined(self.script_fakeactor))
    thread fakeactorspawner_init();

  if(isDefined(self.script_aigroup)) {
    var_0 = self.script_aigroup;

    if(!isDefined(level._ai_group[var_0]))
      aigroup_create(var_0);

    thread aigroup_spawnerthink(level._ai_group[var_0]);
  }

  if(isDefined(self.script_delete)) {
    var_1 = 0;

    if(isDefined(level._ai_delete)) {
      if(isDefined(level._ai_delete[self.script_delete]))
        var_1 = level._ai_delete[self.script_delete].size;
    }

    level._ai_delete[self.script_delete][var_1] = self;
  }

  if(isDefined(self.script_health)) {
    if(self.script_health > level._max_script_health)
      level._max_script_health = self.script_health;

    var_1 = 0;

    if(isDefined(level._ai_health)) {
      if(isDefined(level._ai_health[self.script_health]))
        var_1 = level._ai_health[self.script_health].size;
    }

    level._ai_health[self.script_health][var_1] = self;
  }

  if(isDefined(self.script_deathflag))
    thread spawner_deathflag();

  if(isDefined(self.target))
    crawl_targets_init_flags(self.target);

  if(isDefined(self.script_spawngroup))
    add_to_spawngroup();

  if(isDefined(self.script_random_killspawner))
    add_random_killspawner_to_spawngroup();

  if(!isDefined(self.spawn_functions))
    self.spawn_functions = [];

  for(;;) {
    self waittill("spawned", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(level.spawnercallbackthread))
      self thread[[level.spawnercallbackthread]](var_2);

    if(isDefined(self.script_delete)) {
      for(var_3 = 0; var_3 < level._ai_delete[self.script_delete].size; var_3++) {
        if(level._ai_delete[self.script_delete][var_3] != self)
          level._ai_delete[self.script_delete][var_3] delete();
      }
    }

    var_2.spawn_funcs = self.spawn_functions;
    var_2.spawn_functions = undefined;
    var_2.spawner = self;

    if(isDefined(self.targetname)) {
      var_2 thread spawn_think(self.targetname);
      continue;
    }

    var_2 thread spawn_think();
  }
}

init_stealth() {
  if(!isDefined(self.script_stealth) && !isDefined(self.script_stealthgroup)) {
    return;
  }
  if(isDefined(self.script_stealth) && !isDefined(self.script_stealthgroup))
    self.script_stealthgroup = self.script_stealth;

  self.script_stealth = undefined;
}

spawn_think(var_0) {
  level.ai_classname_in_level[self.classname] = 1;

  if(isDefined(self.asmname) && self.asmname == "seeker") {
    return;
  }
  spawn_think_action(var_0);
  self endon("death");

  if(shouldnt_spawn_because_of_script_difficulty())
    self delete();

  thread run_spawn_functions();
  self.finished_spawning = 1;
  self notify("finished spawning");
}

shouldnt_spawn_because_of_script_difficulty() {
  if(!isDefined(self.script_difficulty))
    return 0;

  var_0 = 0;

  switch (self.script_difficulty) {
    case "easy":
      if(level.gameskill > 1)
        var_0 = 1;

      break;
    case "hard":
      if(level.gameskill < 2)
        var_0 = 1;

      break;
  }

  return var_0;
}

run_spawn_functions() {
  if(!isDefined(self.spawn_funcs)) {
    if(!isDefined(self.script_suspend))
      self.spawner = undefined;

    return;
  }

  for(var_0 = 0; var_0 < self.spawn_funcs.size; var_0++) {
    var_1 = self.spawn_funcs[var_0];

    if(isDefined(var_1["param5"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"], var_1["param5"]);
      continue;
    }

    if(isDefined(var_1["param4"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"]);
      continue;
    }

    if(isDefined(var_1["param3"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"]);
      continue;
    }

    if(isDefined(var_1["param2"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"]);
      continue;
    }

    if(isDefined(var_1["param1"])) {
      thread[[var_1["function"]]](var_1["param1"]);
      continue;
    }

    thread[[var_1["function"]]]();
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(level.vehicle.spawn_functions_enable) && level.vehicle.spawn_functions_enable && self.code_classname == "script_vehicle", self.script_team, self.team);

  if(isDefined(var_2)) {
    for(var_0 = 0; var_0 < level.spawn_funcs[var_2].size; var_0++) {
      var_1 = level.spawn_funcs[var_2][var_0];

      if(isDefined(var_1["param5"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"], var_1["param5"]);
        continue;
      }

      if(isDefined(var_1["param4"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"]);
        continue;
      }

      if(isDefined(var_1["param3"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"]);
        continue;
      }

      if(isDefined(var_1["param2"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"]);
        continue;
      }

      if(isDefined(var_1["param1"])) {
        thread[[var_1["function"]]](var_1["param1"]);
        continue;
      }

      thread[[var_1["function"]]]();
    }
  }

  self.spawn_funcs = undefined;

  if(!isDefined(self.script_suspend))
    self.spawner = undefined;
}

deathfunctions() {
  self waittill("death", var_0, var_1, var_2);
  var_3 = undefined;

  if(isDefined(var_2))
    var_3 = createheadicon(var_2);

  level notify("ai_killed", self, var_0, var_1, var_3);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0)) {
    if(self.team == "axis" || self.team == "team3") {
      var_4 = undefined;

      if(isDefined(var_0.attacker)) {
        if(isDefined(var_0.issentrygun) && var_0.issentrygun)
          var_4 = "sentry";

        if(isDefined(var_0.destructible_type))
          var_4 = "destructible";

        var_0 = var_0.attacker;
      } else if(isDefined(var_0.owner)) {
        if(isai(var_0) && isPlayer(var_0.owner))
          var_4 = "friendly";

        var_0 = var_0.owner;
      } else if(isDefined(var_0.damageowner)) {
        if(isDefined(var_0.destructible_type))
          var_4 = "destructible";

        var_0 = var_0.damageowner;
      }

      var_5 = 0;

      if(isPlayer(var_0))
        var_5 = 1;

      if(var_5) {
        var_0.lastenemykilltime = gettime();
        var_0 scripts\sp\player_stats::register_kill(self, var_1, var_3, var_4);
      }
    }
  }
}

ai_damage_think() {
  self.damage_functions = [];

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.paindamage = var_0;

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_10 = var_1.currentweapon;

      if(isDefined(var_10) && scripts\sp\utility::isprimaryweapon(var_10) && isDefined(var_4) && (var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET")) {
        var_1 thread scripts\sp\player_stats::register_shot_hit();

        if(self isbadguy())
          var_1.lastenemydmgtime = gettime();
      }
    }

    foreach(var_12 in self.damage_functions)
    thread[[var_12]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isalive(self) || self.delayeddeath) {
      break;
    }
  }
}

living_ai_prethink() {
  init_stealth();

  if(isDefined(self.target))
    crawl_targets_init_flags(self.target);
}

crawl_targets_init_flags(var_0) {
  var_1 = get_target_goals(var_0);

  if(var_1.size == 0) {
    return;
  }
  var_2 = -1;

  for(;;) {
    var_2++;

    if(var_2 >= var_1.size) {
      break;
    }

    var_3 = var_1[var_2];

    if(isDefined(var_3.crawled)) {
      continue;
    }
    var_3.crawled = 1;
    level thread remove_crawled(var_3);

    if(isDefined(var_3.script_flag_set)) {
      if(!isDefined(level.flag[var_3.script_flag_set]))
        scripts\engine\utility::flag_init(var_3.script_flag_set);
    }

    if(isDefined(var_3.script_flag_wait)) {
      if(!isDefined(level.flag[var_3.script_flag_wait]))
        scripts\engine\utility::flag_init(var_3.script_flag_wait);
    }

    if(isDefined(var_3.script_flag_clear)) {
      if(!isDefined(level.flag[var_3.script_flag_clear]))
        scripts\engine\utility::flag_init(var_3.script_flag_clear);
    }

    if(isDefined(var_3.script_idle)) {
      if(!isDefined(level.idle_funcs))
        scripts\sp\stealth\idle_sitting::main();
    }

    if(isDefined(var_3.target)) {
      var_4 = get_target_goals(var_3.target);

      foreach(var_6 in var_4) {
        if(!isDefined(var_6.crawled))
          var_1[var_1.size] = var_6;
      }
    }
  }
}

remove_crawled(var_0) {
  waittillframeend;

  if(isDefined(var_0))
    var_0.crawled = undefined;
}

spawn_team_allies() {
  self.usechokepoints = 0;
  checkboosttraversal();
}

spawn_team_axis() {
  checkboosttraversal();

  if(isDefined(self.script_combatmode))
    self.combatmode = self.script_combatmode;
}

checkboosttraversal() {
  var_0["crew"] = 1;
  var_0["no_boost"] = 1;
  var_0["noboost"] = 1;

  if(isDefined(self.subclass) && isDefined(var_0[self.subclass]))
    self enabletraversals(0, "soldier_boost");
}

spawn_team_team3() {
  spawn_team_axis();
  checkboosttraversal();
}

spawn_team_neutral() {
  checkboosttraversal();
}

spawn_unittype_soldier() {}

spawn_think_game_skill_related() {
  scripts\common\gameskill::default_door_node_flashbang_frequency();
  scripts\common\gameskill::grenadeawareness();
}

ai_lasers() {
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

spawn_think_script_inits() {
  if(isDefined(self.script_dontshootwhilemoving)) {
    self.dontshootwhilemoving = 1;
    self.script_dontshootwhilemoving = undefined;
  }

  if(isDefined(self.script_deathflag))
    thread ai_deathflag();

  if(isDefined(self.script_attackeraccuracy)) {
    self.attackeraccuracy = self.script_attackeraccuracy;
    self.script_attackeraccuracy = undefined;
  }

  if(isDefined(self.script_startrunning)) {
    thread start_off_running();
    self.script_startrunning = undefined;
  }

  if(isDefined(self.script_deathtime))
    thread deathtime();

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

  if(isDefined(self.script_laser))
    thread ai_lasers();

  if(isDefined(self.script_danger_react)) {
    var_0 = self.script_danger_react;

    if(var_0 == 1)
      var_0 = 8;

    scripts\engine\sp\utility::enable_danger_react(var_0);
  }

  if(isDefined(self.script_faceenemydist))
    self.maxfaceenemydist = self.script_faceenemydist;
  else if(!self.space)
    self.maxfaceenemydist = 512;

  if(isDefined(self.script_forcecolor))
    scripts\engine\sp\utility::set_force_color(self.script_forcecolor);

  if(isDefined(self.dontdropweapon))
    self.dropweapon = 0;

  if(isDefined(self.script_team))
    self.team = self.script_team;

  if(isDefined(self.script_fixednode)) {
    self.fixednode = self.script_fixednode == 1;
    self.script_fixednode = undefined;
  } else
    self.fixednode = self.team == "allies";

  if(isDefined(self.script_no_reorient) && self.script_no_reorient == 1) {
    self.no_reorient = 1;
    self.script_no_reorient = undefined;
  }

  self.providecoveringfire = self.team == "allies" && self.fixednode;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mgpair")
    thread scripts\sp\mg_penetration::create_mg_team();

  if(isDefined(self.script_goalvolume) && !(isDefined(self.script_moveoverride) && self.script_moveoverride == 1 || isDefined(self.script_stealthgroup)))
    thread set_goal_volume();

  if(isDefined(self.script_threatbiasgroup))
    self setthreatbiasgroup(self.script_threatbiasgroup);
  else if(self.team == "neutral")
    self setthreatbiasgroup("civilian");
  else
    self setthreatbiasgroup(self.team);

  if(isDefined(self.script_bcdialog))
    scripts\engine\sp\utility::set_battlechatter(self.script_bcdialog);

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
    if(self.script_longdeath == 0)
      scripts\engine\sp\utility::disable_long_death();
    else if(self.script_longdeath == 1)
      scripts\engine\sp\utility::enable_long_death();
    else {
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

spawn_c6_script_inits() {
  if(isDefined(self.script_selfdestruct_delay)) {
    self.bt.forceselfdestructtimer = gettime() + self.script_selfdestruct_delay * 1000;
    self.script_selfdestruct_delay = undefined;
  } else if(isDefined(self.script_selfdestruct)) {
    self.bt.forceselfdestructtimer = 1;
    self.script_selfdestruct = undefined;
  }

  if(getdvarint("phstreets_iw8_test"))
    self.dropweapon = 0;
}

spawn_think_action(var_0) {
  thread ai_damage_think();
  thread tanksquish();

  if(!isDefined(level.ai_dont_glow_in_thermal))
    self thermaldrawenable();

  self.spawner_number = undefined;

  if(!isDefined(self.unique_id))
    scripts\engine\utility::set_ai_number();

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

  if(isDefined(level.unittype_spawn_functions[self.unittype]))
    self thread[[level.unittype_spawn_functions[self.unittype]]]();

  if(isDefined(level.subclass_spawn_functions[self.subclass]))
    self thread[[level.subclass_spawn_functions[self.subclass]]]();

  if(self.team == "axis")
    thread scripts\engine\sp\utility::add_damage_function(scripts\sp\damagefeedback::damagefeedback_took_damage);

  set_goal_height_from_settings();

  if(isDefined(self.script_combatbehavior)) {
    if(self.script_combatbehavior == "heat")
      scripts\sp\utility::enable_heat_behavior();

    if(self.script_combatbehavior == "cqb")
      scripts\common\utility::enable_cqbwalk();
  }

  if(isDefined(self.suspended_ai))
    postspawn_suspended_ai();

  if(isDefined(self.script_playerseek)) {
    self setgoalentity(level.player);
    return;
  }

  if(isDefined(self.script_stealthgroup)) {
    if(!isDefined(level.stealth))
      scripts\sp\stealth\manager::main();

    scripts\stealth\callbacks::stealth_call_thread("do_stealth");
    return;
  }

  if(isDefined(self.script_readystand) && self.script_readystand == 1)
    scripts\engine\sp\utility::enable_readystand();

  if(isDefined(self.script_delayed_playerseek)) {
    if(!isDefined(self.script_radius))
      self.goalradius = 800;

    self setgoalentity(level.player);
    level thread delayed_player_seek_think(self);
    return;
  }

  if(isDefined(self.script_moveoverride) && self.script_moveoverride == 1) {
    set_goal_from_settings();
    self setgoalpos(self.origin);
    return;
  }

  if(!isDefined(self.script_stealthgroup)) {}

  set_goal_from_settings();

  if(isDefined(self.target))
    thread go_to_node();
}

init_reset_ai() {
  scripts\engine\sp\utility::set_default_pathenemy_settings();

  if(isDefined(self.script_grenades))
    self.grenadeammo = self.script_grenades;

  if(isDefined(self.primaryweapon))
    self.noattackeraccuracymod = scripts\anim\utility_common.gsc::isasniper();

  self.neversprintforvariation = 1;
}

scrub_guy() {
  if(self.team == "neutral")
    self setthreatbiasgroup("civilian");
  else
    self setthreatbiasgroup(self.team);

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

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    scripts\common\ai::stop_magic_bullet_shield();

  scripts\engine\sp\utility::disable_replace_on_death();
  self.maxsightdistsqrd = 67108864;
  self.script_forcegrenade = 0;
  self.walkdist = 16;
  self.pushable = 1;
  self.script_pushable = 1;
  scripts\anim\init.gsc::set_anim_playback_rate();
  self.fixednode = self.team == "allies";
}

delayed_player_seek_think(var_0) {
  var_0 endon("death");

  while(isalive(var_0)) {
    if(var_0.goalradius > 200)
      var_0.goalradius = var_0.goalradius - 200;

    wait 6;
  }
}

set_goal_volume() {
  self endon("death");
  waittillframeend;

  if(isDefined(self.team) && self.team == "allies")
    self.fixednode = 0;

  var_0 = level.goalvolumes[self.script_goalvolume];

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");
    var_2 = getEnt(var_0.target, "targetname");
    var_3 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_4 = undefined;

    if(isDefined(var_1)) {
      var_4 = var_1;
      self setgoalnode(var_4);
    } else if(isDefined(var_2)) {
      var_4 = var_2;
      self setgoalpos(var_4.origin);
    } else if(isDefined(var_3)) {
      var_4 = var_3;
      self setgoalpos(var_4.origin);
    }

    if(isDefined(var_4.radius) && var_4.radius != 0)
      self.goalradius = var_4.radius;

    if(isDefined(var_4.goalheight) && var_4.goalheight != 0)
      self.goalheight = var_4.goalheight;
  }

  if(isDefined(self.target))
    self setgoalvolume(var_0);
  else
    self setgoalvolumeauto(var_0, var_0 scripts\engine\sp\utility::get_cover_volume_forward());
}

get_target_goals(var_0) {
  var_1 = getnodearray(var_0, "targetname");
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_4 in var_2)
  var_1[var_1.size] = var_4;

  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(!is_target_goal_valid(var_4)) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

is_target_goal_valid(var_0) {
  if(isspawner(var_0))
    return 0;

  switch (var_0.code_classname) {
    case "trigger_once":
    case "trigger_multiple":
    case "trigger_radius":
    case "misc_turret":
      return 0;
  }

  return 1;
}

node_has_radius(var_0) {
  return isDefined(var_0.radius) && var_0.radius != 0;
}

go_to_node(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = get_target_goals(self.target);

    if(var_0.size == 0) {
      self notify("reached_path_end");
      return;
    }
  } else if(!isarray(var_0))
    var_0 = [var_0];

  go_to_node_internal(var_0, var_1, var_2);
}

get_least_used_from_array(var_0) {
  if(var_0.size == 1)
    return var_0[0];

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(!isDefined(var_1.used_time))
    var_1.used_time = 0;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.used_time))
      var_3.used_time = 0;

    if(var_3.used_time < var_1.used_time)
      var_1 = var_3;
  }

  var_1.used_time = gettime();
  return var_1;
}

go_to_node_internal(var_0, var_1, var_2) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");

  if(!isarray(var_0))
    var_0 = [var_0];

  var_3 = var_0[0];
  thread go_to_node_end();
  var_4 = 0;
  var_5 = undefined;

  for(;;) {
    if(!var_4) {
      var_0 = get_least_used_from_array(var_0);
      var_5 = get_path_array(var_0, var_3);
      self.patharray = var_5;
      self.patharrayindex = -1;

      if(var_5.size > 1)
        var_4 = 1;
    }

    self.currentnode = var_0;

    if(var_4) {
      var_0 = var_5[var_5.size - 1];
      go_through_patharray(var_5, var_1, var_2);
      var_5 = undefined;
      var_4 = 0;
    } else {
      node_fields_pre_goal(var_0);

      if(isDefined(self.stealth))
        scripts\stealth\callbacks::stealth_call("go_to_node_wait", ::go_to_node_set_goal, var_0);
      else {
        go_to_node_set_goal(var_0);
        self waittill("goal");
      }
    }

    var_0 notify("trigger", self);
    node_fields_after_goal(var_0, var_1);
    var_0 scripts\engine\utility::script_delay();

    if(isDefined(var_0.script_flag_wait))
      scripts\engine\utility::flag_wait(var_0.script_flag_wait);

    if(isDefined(var_0.script_ent_flag_wait))
      scripts\engine\utility::ent_flag_wait(var_0.script_ent_flag_wait);

    var_0 scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(var_0, var_2);

    if(!isDefined(var_0.target)) {
      break;
    }

    var_6 = get_target_goals(var_0.target);

    if(!var_6.size) {
      break;
    }

    var_0 = var_6;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }
  var_7 = self getgoalvolume();

  if(isDefined(var_7))
    self setgoalvolumeauto(var_7, var_7 scripts\engine\sp\utility::get_cover_volume_forward());
  else
    self.goalradius = level.default_goalradius;
}

go_through_patharray(var_0, var_1, var_2) {
  self setgoalpath(var_0);

  foreach(var_6, var_4 in var_0) {
    node_fields_pre_goal(var_4);
    var_5 = waittill_subgoal();
    self.patharrayindex = var_5;

    if(isDefined(self.patharray) && !isDefined(self.patharrayindex))
      self.patharrayindex = self.patharray.size - 1;

    if(var_6 == var_0.size - 1) {
      self waittill("goal");
      break;
    }

    var_4 notify("trigger", self);
    node_fields_after_goal(var_4, var_1);
    node_fields_after_goal_and_wait(var_4, var_2);
  }
}

waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", var_0);
  return var_0;
}

get_path_array(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(;;) {
    var_2[var_2.size] = var_0;
    var_3++;

    if(var_3 == 16) {
      break;
    }

    if(scripts\engine\utility::is_equal(var_0.code_classname, "info_volume")) {
      break;
    }

    if(go_to_node_should_stop(var_0)) {
      break;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_4 = get_target_goals(var_0.target);

    if(!var_4.size) {
      break;
    }

    var_0 = get_least_used_from_array(var_4);

    if(var_0 == var_1) {
      break;
    }
  }

  return var_2;
}

node_fields_pre_goal(var_0) {
  if(isDefined(var_0.radius))
    self.goalradius = var_0.radius;

  if(isDefined(var_0.height))
    self.goalheight = var_0.height;

  if(isDefined(var_0.script_demeanor))
    scripts\common\utility::demeanor_override(var_0.script_demeanor);

  if(isDefined(var_0.script_civilian_state))
    scripts\asm\asm_bb::bb_setcivilianstate(var_0.script_civilian_state);

  if(isDefined(var_0.script_pacifist))
    self.pacifist = var_0.script_pacifist;

  if(isDefined(var_0.script_ignoreall))
    self.ignoreall = var_0.script_ignoreall;

  if(isDefined(var_0.script_ignoreme))
    self.ignoreme = var_0.script_ignoreme;

  if(isDefined(var_0.script_moveplaybackrate))
    scripts\engine\sp\utility::set_moveplaybackrate(var_0.script_moveplaybackrate, 0.25);

  if(isDefined(var_0.script_speed))
    scripts\engine\utility::set_movement_speed(var_0.script_speed);

  if(isDefined(var_0.script_gunpose))
    scripts\common\ai::set_gunpose(var_0.script_gunpose);

  if(isDefined(var_0.script_disable_arrivals)) {
    if(var_0.script_disable_arrivals)
      scripts\common\ai::disable_arrivals();
    else
      self.disablearrivals = undefined;
  }

  if(isDefined(var_0.script_disable_exits)) {
    if(var_0.script_disable_exits)
      scripts\common\ai::disable_exits();
    else
      scripts\common\ai::enable_exits();
  }
}

node_fields_after_goal(var_0, var_1) {
  if(isDefined(self.stealth))
    scripts\stealth\callbacks::stealth_call("go_to_node_arrive", ::go_to_node_set_goal, var_0);

  if(isDefined(var_1))
    [[var_1]](var_0);

  if(isDefined(var_0.script_flag_set))
    scripts\engine\utility::flag_set(var_0.script_flag_set);

  if(isDefined(var_0.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);

  if(isDefined(var_0.script_ent_flag_clear))
    scripts\engine\utility::ent_flag_clear(var_0.script_ent_flag_clear);

  if(isDefined(var_0.script_flag_clear))
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);

  if(targets_and_uses_turret(var_0))
    return 1;
}

node_fields_after_goal_and_wait(var_0, var_1) {
  if(isDefined(var_0.script_soundalias))
    self playSound(var_0.script_soundalias);

  if(isDefined(var_0.script_gesture))
    thread scripts\engine\sp\utility::gesture_simple(var_0.script_gesture);

  if(isDefined(self.stealth))
    scripts\stealth\callbacks::stealth_call("go_to_node_post_wait", ::go_to_node_set_goal, var_0);

  if(isDefined(self.post_wait_func))
    [[self.post_wait_func]]();

  if(isDefined(var_0.script_delay_post))
    wait(var_0.script_delay_post);

  while(isDefined(var_0.script_requires_player)) {
    if(go_to_node_wait_for_player(var_0, ::get_target_goals)) {
      var_0 notify("script_requires_player");
      break;
    }

    wait 0.1;
  }

  if(isDefined(var_0.script_demeanor_post))
    scripts\common\utility::demeanor_override(var_0.script_demeanor_post);

  if(isDefined(var_1))
    [[var_1]](var_0);

  if(istrue(var_0.script_death))
    scripts\engine\sp\utility::die();

  if(istrue(var_0.script_delete)) {
    if(istrue(var_0.script_nosight))
      level thread scripts\engine\sp\utility::ai_delete_when_out_of_sight([self], 350);
    else {
      if(isDefined(self.magic_bullet_shield))
        scripts\common\ai::stop_magic_bullet_shield();

      self delete();
    }
  }
}

go_to_node_end() {
  self endon("death");
  self.using_goto_node = 1;
  scripts\engine\utility::waittill_any("reached_path_end", "stop_going_to_node");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

go_to_node_wait_for_player(var_0, var_1) {
  if(distancesquared(level.player.origin, var_0.origin) < distancesquared(self.origin, var_0.origin))
    return 1;

  if(!isDefined(var_0.script_dist_only)) {
    var_2 = anglesToForward(self.angles);

    if(isDefined(var_0.target)) {
      var_3 = [[var_1]](var_0.target);

      if(var_3.size == 1)
        var_2 = vectorNormalize(var_3[0].origin - var_0.origin);
      else if(isDefined(var_0.angles))
        var_2 = anglesToForward(var_0.angles);
    } else if(isDefined(var_0.angles))
      var_2 = anglesToForward(var_0.angles);

    var_4 = [];
    var_4[var_4.size] = vectorNormalize(level.player.origin - self.origin);

    foreach(var_6 in var_4) {
      if(vectordot(var_2, var_6) > 0)
        return 1;
    }
  }

  var_8 = 32;

  if(var_0.script_requires_player > var_8)
    var_8 = var_0.script_requires_player;

  if(distancesquared(level.player.origin, self.origin) < squared(var_8))
    return 1;

  return 0;
}

go_to_node_should_stop(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_0.target))
    return 1;

  if(isDefined(var_0.script_delay))
    return 1;

  if(isDefined(var_0.script_delay_min))
    return 1;

  if(isDefined(var_0.script_delay_max))
    return 1;

  if(isDefined(var_0.script_wait))
    return 1;

  if(isDefined(var_0.script_wait_add))
    return 1;

  if(isDefined(var_0.script_wait_min))
    return 1;

  if(isDefined(var_0.script_wait_max))
    return 1;

  if(isDefined(var_0.script_flag_wait))
    return 1;

  if(isDefined(var_0.script_ent_flag_wait))
    return 1;

  if(isDefined(var_0.script_delay_post))
    return 1;

  if(isDefined(var_0.script_requires_player))
    return 1;

  if(isDefined(var_0.script_idle))
    return 1;

  if(isDefined(var_0.script_stopnode))
    return 1;

  return 0;
}

go_to_node_set_goal(var_0) {
  if(isnode(var_0))
    go_to_node_set_goal_node(var_0);
  else if(isstruct(var_0))
    go_to_node_set_goal_pos(var_0);
  else if(isent(var_0))
    go_to_node_set_goal_ent(var_0);

  if(isstruct(var_0) || isnode(var_0))
    var_0.patrol_stop = go_to_node_should_stop(var_0);
}

go_to_node_set_goal_ent(var_0) {
  if(var_0.code_classname == "info_volume") {
    self setgoalvolumeauto(var_0, var_0 scripts\engine\sp\utility::get_cover_volume_forward());
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(var_0);
}

go_to_node_set_goal_pos(var_0) {
  scripts\engine\sp\utility::set_goal_ent(var_0);
  self notify("go_to_node_new_goal");
}

go_to_node_set_goal_node(var_0) {
  scripts\engine\sp\utility::set_goal_node(var_0);
  self notify("go_to_node_new_goal");
}

targets_and_uses_turret(var_0) {
  if(!isDefined(var_0.target))
    return 0;

  var_1 = getEntArray(var_0.target, "targetname");

  if(!var_1.size)
    return 0;

  var_2 = var_1[0];

  if(!issubstr(var_2.classname, "misc_turret"))
    return 0;

  thread use_a_turret(var_2);
  return 1;
}

set_goal_height_from_settings() {
  if(isDefined(self.script_goalheight))
    self.goalheight = self.script_goalheight;
  else
    self.goalheight = level.default_goalheight;
}

set_goal_from_settings(var_0) {
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(isDefined(self.script_forcegoal)) {
    if(isDefined(var_0) && isDefined(var_0.radius)) {
      self.goalradius = var_0.radius;
      return;
    }
  }

  if(!isDefined(self getgoalvolume())) {
    if(self.unittype == "juggernaut") {
      return;
    }
    if(self.type == "civilian")
      self.goalradius = 128;
    else
      self.goalradius = level.default_goalradius;
  }
}

autotarget(var_0) {
  for(;;) {
    var_1 = self getturretowner();

    if(!isalive(var_1)) {
      wait 1.5;
      continue;
    }

    if(!isDefined(var_1.enemy)) {
      self settargetentity(scripts\engine\utility::random(var_0));
      self notify("startfiring");
      self startfiring();
    }

    wait(2 + randomfloat(1));
  }
}

manualtarget(var_0) {
  for(;;) {
    self settargetentity(scripts\engine\utility::random(var_0));
    self notify("startfiring");
    self startfiring();
    wait(2 + randomfloat(1));
  }
}

use_a_turret(var_0) {
  self endon("stop_using_turret");
  self endon("death");

  if(self isbadguy() && self.health == 150) {
    self.health = 100;
    self.a.disablelongdeath = 1;
  }

  scripts\asm\asm_bb::bb_requestturret(var_0);

  while(!isDefined(self getturret()) || self getturret() != var_0)
    wait 0.05;

  if(isDefined(var_0.target) && var_0.target != var_0.targetname) {
    var_1 = getEntArray(var_0.target, "targetname");
    var_2 = [];

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3].classname == "script_origin")
        var_2[var_2.size] = var_1[var_3];
    }

    if(isDefined(var_0.script_autotarget))
      var_0 thread autotarget(var_2);
    else if(isDefined(var_0.script_manualtarget)) {
      var_0 setmode("manual_ai");
      var_0 thread manualtarget(var_2);
    } else if(var_2.size > 0) {
      if(var_2.size == 1) {
        var_0.manual_target = var_2[0];
        var_0 settargetentity(var_2[0]);
        thread scripts\sp\mgturret::manual_think(var_0);
      } else
        var_0 thread scripts\sp\mgturret::mg42_suppressionfire(var_2);
    }
  }

  thread player_use_turret_watcher(var_0);
  thread scripts\sp\mgturret::mg42_firing(var_0);
  var_0 notify("startfiring");
}

player_use_turret_watcher(var_0) {
  self endon("death");

  if(self.team != "allies") {
    return;
  }
  var_1 = spawn("trigger_radius", var_0.origin, 0, 56, 56);
  thread scripts\engine\utility::delete_on_death(var_1);
  var_2 = 0;

  while(!var_2) {
    var_1 waittill("trigger");

    while(level.player istouching(var_1)) {
      if(level.player useButtonPressed()) {
        var_2 = 1;
        break;
      }

      wait 0.05;
    }
  }

  var_1 delete();
  stop_using_turret();
}

stop_using_turret() {
  self notify("stop_using_turret");
  self notify("stop_using_built_in_burst_fire");
  var_0 = self getturret();

  if(!isDefined(var_0)) {
    return;
  }
  self stopuseturret();
  scripts\asm\asm_bb::bb_requestturret(undefined);
  self stopanimScripted();
  var_0 stopfiring();
}

friendly_mgturret(var_0) {
  var_1 = getnode(var_0.target, "targetname");
  var_2 = getEnt(var_1.target, "targetname");
  var_2 setmode("auto_ai");
  var_2 cleartargetentity();
  var_3 = 0;

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!isai(var_4)) {
      continue;
    }
    if(!isDefined(var_4.team)) {
      continue;
    }
    if(var_4.team != "allies") {
      continue;
    }
    if(isDefined(var_4.script_usemg42) && var_4.script_usemg42 == 0) {
      continue;
    }
    if(var_4 thread friendly_mg42_useable(var_2, var_1)) {
      var_4 thread friendly_mg42_think(var_2, var_1);
      var_2 waittill("friendly_finished_using_mg42");

      if(isalive(var_4))
        var_4.turret_use_time = gettime() + 10000;
    }

    wait 1;
  }
}

friendly_mg42_death_notify(var_0, var_1) {
  var_1 endon("friendly_finished_using_mg42");
  var_0 waittill("death");
  var_1 notify("friendly_finished_using_mg42");
}

friendly_mg42_wait_for_use(var_0) {
  var_0 endon("friendly_finished_using_mg42");
  self.useable = 1;
  self setCursorHint("HINT_NOICON");
  self setHintString(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  self.useable = 0;
  self setHintString("");
  self stopuseturret();
  self notify("stopped_use_turret");
  var_0 notify("friendly_finished_using_mg42");
}

friendly_mg42_useable(var_0, var_1) {
  if(self.useable)
    return 0;

  if(isDefined(self.turret_use_time) && gettime() < self.turret_use_time)
    return 0;

  if(distance(level.player.origin, var_1.origin) < 100)
    return 0;

  return 1;
}

friendly_mg42_endtrigger(var_0, var_1) {
  var_0 endon("friendly_finished_using_mg42");
  self waittill("trigger");
  var_0 notify("friendly_finished_using_mg42");
}

nofour() {
  self endon("death");
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32)
    self.goalradius = 400;
}

friendly_mg42_think(var_0, var_1) {
  self endon("death");
  var_0 endon("friendly_finished_using_mg42");
  level thread friendly_mg42_death_notify(self, var_0);
  self.oldradius = self.goalradius;
  self.goalradius = 28;
  thread nofour();
  self setgoalnode(var_1);
  self.ignoresuppression = 1;
  self waittill("goal");
  self.goalradius = self.oldradius;

  if(self.goalradius < 32)
    self.goalradius = 400;

  self.ignoresuppression = 0;
  self.goalradius = self.oldradius;

  if(distance(level.player.origin, var_1.origin) < 32) {
    var_0 notify("friendly_finished_using_mg42");
    return;
  }

  self.friendly_mg42 = var_0;
  thread friendly_mg42_wait_for_use(var_0);
  thread friendly_mg42_cleanup(var_0);
  self useturret(var_0);

  if(isDefined(var_0.target)) {
    var_2 = getEnt(var_0.target, "targetname");

    if(isDefined(var_2))
      var_2 thread friendly_mg42_endtrigger(var_0, self);
  }

  for(;;) {
    if(distance(self.origin, var_1.origin) < 32)
      self useturret(var_0);
    else
      break;

    wait 1;
  }

  var_0 notify("friendly_finished_using_mg42");
}

friendly_mg42_cleanup(var_0) {
  self endon("death");
  var_0 waittill("friendly_finished_using_mg42");
  friendly_mg42_doneusingturret();
}

friendly_mg42_doneusingturret() {
  self endon("death");
  var_0 = self.friendly_mg42;
  self.friendly_mg42 = undefined;
  self stopuseturret();
  self notify("stopped_use_turret");
  self.useable = 0;
  self.goalradius = self.oldradius;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.target)) {
    return;
  }
  var_1 = getnode(var_0.target, "targetname");
  var_2 = self.goalradius;
  self.goalradius = 8;
  self setgoalnode(var_1);
  wait 2;
  self.goalradius = 384;
  return;
  self waittill("goal");

  if(isDefined(self.target)) {
    var_1 = getnode(self.target, "targetname");

    if(isDefined(var_1.target))
      var_1 = getnode(var_1.target, "targetname");

    if(isDefined(var_1))
      self setgoalnode(var_1);
  }

  self.goalradius = var_2;
}

tanksquish() {
  if(isDefined(level.notanksquish)) {
    return;
  }
  if(isDefined(level.vehicle.has_vehicles) && !level.vehicle.has_vehicles) {
    return;
  }
  scripts\engine\sp\utility::add_damage_function(::tanksquish_damage_check);
}

tanksquish_damage_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(self)) {
    return;
  }
  if(isalive(self)) {
    return;
  }
  if(!isalive(var_1)) {
    return;
  }
  if(!isDefined(var_1.vehicletype)) {
    return;
  }
  if(var_1 scripts\common\vehicle::ishelicopter()) {
    return;
  }
  if(!isDefined(self.noragdoll)) {
    if(isDefined(self.fnpreragdoll))
      self[[self.fnpreragdoll]]();

    self startragdoll();
  }

  if(!isDefined(self)) {
    return;
  }
  scripts\engine\sp\utility::remove_damage_function(::tanksquish_damage_check);
}

flood_and_secure(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn")
    var_0 = 1;

  level.spawnerwave = [];
  var_1 = getspawnerarray(self.target);
  scripts\engine\utility::array_thread(var_1, ::flood_and_secure_spawner, var_0);
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    self waittill("trigger", var_4);

    if(!var_3) {
      var_3 = 1;
      scripts\engine\utility::script_delay();
    }

    if(self istouching(level.player))
      var_2 = 1;
    else {
      if(!isalive(var_4)) {
        continue;
      }
      if(isPlayer(var_4))
        var_2 = 1;
      else if(!isDefined(var_4.issquad) || !var_4.issquad)
        continue;
    }

    var_1 = getspawnerarray(self.target);

    if(isDefined(var_1[0])) {
      if(isDefined(var_1[0].script_randomspawn))
        cull_spawners_from_killspawner(var_1[0].script_randomspawn);
    }

    var_1 = getspawnerarray(self.target);

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_1[var_5].playertriggered = var_2;
      var_1[var_5] notify("flood_begin");
    }

    if(var_2) {
      wait 5;
      continue;
    }

    wait 0.1;
  }
}

flood_and_secure_spawner(var_0) {
  if(isDefined(self.securestarted)) {
    return;
  }
  self.securestarted = 1;
  self.triggerunlocked = 1;
  var_1 = self.target;
  var_2 = self.targetname;

  if(!isDefined(var_1) && !isDefined(self.script_moveoverride))
    waittillframeend;

  var_3 = [];

  if(isDefined(var_1)) {
    var_4 = getspawnerarray(var_1);

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(!issubstr(var_4[var_5].classname, "actor")) {
        continue;
      }
      var_3[var_3.size] = var_4[var_5];
    }
  }

  var_6 = spawnStruct();
  var_7 = self.origin;
  flood_and_secure_spawner_think(var_6, var_3.size > 0, var_0);

  if(isalive(var_6.ai))
    var_6.ai waittill("death");

  if(!isDefined(var_1)) {
    return;
  }
  var_4 = getspawnerarray(var_1);

  if(!var_4.size) {
    return;
  }
  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(!issubstr(var_4[var_5].classname, "actor")) {
      continue;
    }
    var_4[var_5].targetname = var_2;
    var_8 = var_1;

    if(isDefined(var_4[var_5].target)) {
      var_9 = getspawner(var_4[var_5].target, "targetname");

      if(!isDefined(var_9) || !issubstr(var_9.classname, "actor"))
        var_8 = var_4[var_5].target;
    }

    var_4[var_5].target = var_8;
    var_4[var_5] thread flood_and_secure_spawner(var_0);
    var_4[var_5].playertriggered = 1;
    var_4[var_5] notify("flood_begin");
  }
}

flood_and_secure_spawner_think(var_0, var_1, var_2) {
  self endon("death");
  var_3 = self.count;

  if(!var_1)
    var_1 = isDefined(self.script_noteworthy) && self.script_noteworthy == "delete";

  scripts\engine\sp\utility::set_count(2);

  if(isDefined(self.script_delay))
    var_4 = self.script_delay;
  else
    var_4 = 0;

  for(;;) {
    self waittill("flood_begin");

    if(self.playertriggered) {
      break;
    }

    if(var_4) {
      continue;
    }
    break;
  }

  var_5 = distance(level.player.origin, self.origin);

  while(var_3) {
    self.truecount = var_3;
    scripts\engine\sp\utility::set_count(2);
    wait(var_4);
    var_6 = scripts\engine\sp\utility::spawn_ai();

    if(scripts\common\ai::spawn_failed(var_6)) {
      var_7 = 0;

      if(var_4 < 2)
        wait 2;

      continue;
    } else {
      thread addtowavespawner(var_6);
      var_6 thread flood_and_secure_spawn(self);

      if(isDefined(self.script_accuracy))
        var_6.baseaccuracy = self.script_accuracy;

      var_0.ai = var_6;
      var_0 notify("got_ai");
      self waittill("spawn_died", var_8, var_7);

      if(var_4 > 2)
        var_4 = randomint(4) + 2;
      else
        var_4 = 0.5 + randomfloat(0.5);
    }

    if(var_8) {
      waittillrestartordistance(var_5);
      continue;
    }

    if(playerwasnearby(var_7 || var_1, var_0.ai))
      var_3--;

    if(!var_2)
      waituntilwaverelease();
  }

  self delete();
}

waittilldeletedordeath(var_0) {
  self endon("death");
  var_0 waittill("death");
}

addtowavespawner(var_0) {
  var_1 = self.targetname;

  if(!isDefined(level.spawnerwave[var_1])) {
    level.spawnerwave[var_1] = spawnStruct();
    level.spawnerwave[var_1] scripts\engine\sp\utility::set_count(0);
    level.spawnerwave[var_1].total = 0;
  }

  if(!isDefined(self.addedtowave)) {
    self.addedtowave = 1;
    level.spawnerwave[var_1].total++;
  }

  level.spawnerwave[var_1].count++;
  waittilldeletedordeath(var_0);
  level.spawnerwave[var_1].count--;

  if(!isDefined(self))
    level.spawnerwave[var_1].total--;

  if(level.spawnerwave[var_1].total) {
    if(level.spawnerwave[var_1].count / level.spawnerwave[var_1].total < 0.32)
      level.spawnerwave[var_1] notify("waveReady");
  }
}

waituntilwaverelease() {
  var_0 = self.targetname;

  if(level.spawnerwave[var_0].count)
    level.spawnerwave[var_0] waittill("waveReady");
}

playerwasnearby(var_0, var_1) {
  if(var_0)
    return 1;

  if(isDefined(var_1) && isDefined(var_1.origin))
    var_2 = var_1.origin;
  else
    var_2 = self.origin;

  if(distance(level.player.origin, var_2) < 700)
    return 1;

  return scripts\engine\trace::_bullet_trace_passed(level.player getEye(), var_1 getEye(), 0, undefined);
}

waittillrestartordistance(var_0) {
  self endon("flood_begin");
  var_0 = var_0 * 0.75;

  while(distance(level.player.origin, self.origin) > var_0)
    wait 1;
}

flood_and_secure_spawn(var_0) {
  thread flood_and_secure_spawn_goal();
  self waittill("death", var_1);
  var_2 = isalive(var_1) && isPlayer(var_1);

  if(!var_2 && isDefined(var_1) && var_1.classname == "worldspawn")
    var_2 = 1;

  var_3 = !isDefined(self);
  var_0 notify("spawn_died", var_3, var_2);
}

flood_and_secure_spawn_goal() {
  if(isDefined(self.script_moveoverride)) {
    return;
  }
  self endon("death");
  var_0 = getnode(self.target, "targetname");

  if(isDefined(var_0))
    self setgoalnode(var_0);
  else {
    var_0 = getEnt(self.target, "targetname");

    if(isDefined(var_0))
      self setgoalpos(var_0.origin);
  }

  if(isDefined(level.fightdist)) {
    self.pathenemyfightdist = level.fightdist;
    self.pathenemylookahead = level.maxdist;
  }

  if(isDefined(var_0.radius) && var_0.radius >= 0)
    self.goalradius = var_0.radius;
  else
    self.goalradius = 256;

  self waittill("goal");

  while(isDefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");

    if(isDefined(var_1))
      var_0 = var_1;
    else
      break;

    self setgoalnode(var_0);

    if(node_has_radius(var_0))
      self.goalradius = var_0.radius;
    else
      self.goalradius = 256;

    self waittill("goal");
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self kill();
      return;
    }
  }

  if(isDefined(var_0.target)) {
    var_2 = getEnt(var_0.target, "targetname");

    if(isDefined(var_2) && var_2.code_classname == "misc_turret") {
      self setgoalnode(var_0);
      self.goalradius = 4;
      self waittill("goal");

      if(!isDefined(self.script_forcegoal))
        self.goalradius = level.default_goalradius;

      use_a_turret(var_2);
    }
  }

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "hide") {
      thread scripts\engine\sp\utility::set_battlechatter(0);
      return;
    }
  }

  if(!isDefined(self.script_forcegoal) && !isDefined(self getgoalvolume()))
    self.goalradius = level.default_goalradius;
}

goalvolumes() {
  var_0 = getEntArray("info_volume", "classname");
  level.deathchain_goalvolume = [];
  level.goalvolumes = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isDefined(var_2.script_deathchain))
      level.deathchain_goalvolume[var_2.script_deathchain] = var_2;

    if(isDefined(var_2.script_goalvolume))
      level.goalvolumes[var_2.script_goalvolume] = var_2;
  }
}

aigroup_create(var_0) {
  level._ai_group[var_0] = spawnStruct();
  level._ai_group[var_0].aicount = 0;
  level._ai_group[var_0].aideaths = 0;
  level._ai_group[var_0].spawnercount = 0;
  level._ai_group[var_0].ai = [];
  level._ai_group[var_0].spawners = [];
}

aigroup_spawnerthink(var_0) {
  self endon("death");
  self endon("stop_aigroup_spawnerthink");
  self.decremented = 0;
  var_0.spawnercount++;
  var_0.spawners = scripts\engine\utility::array_add(var_0.spawners, self);
  thread aigroup_spawnerdeath(var_0);
  thread aigroup_spawnerempty(var_0);
  self waittill("spawned", var_1);

  if(!scripts\common\ai::spawn_failed(var_1))
    var_1 thread aigroup_soldierthink(var_0);

  aigroup_decrement(var_0);
}

aigroup_decrement(var_0) {
  if(self.decremented) {
    return;
  }
  self.decremented = 1;
  var_0.spawnercount--;
  self notify("stop_aigroup_spawnerthink");
}

aigroup_spawnerdeath(var_0) {
  self waittill("death");

  if(isDefined(self))
    aigroup_decrement(var_0);
}

aigroup_spawnerempty(var_0) {
  self endon("death");
  self waittill("emptied spawner");
  aigroup_decrement(var_0);
}

aigroup_soldierthink(var_0) {
  var_0.aicount++;
  var_0.ai[var_0.ai.size] = self;

  if(isDefined(self.script_deathflag_longdeath))
    waittilldeathorpaindeath();
  else
    self waittill("death");

  var_0.aicount--;
  var_0.aideaths++;
}

camper_trigger_think(var_0) {
  var_1 = strtok(var_0.script_linkto, " ");
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];
    var_6 = getspawner(var_5, "script_linkname");

    if(isDefined(var_6)) {
      var_2 = scripts\engine\utility::array_add_safe(var_2, var_6);
      continue;
    }

    var_7 = getnode(var_5, "script_linkname");

    if(!isDefined(var_7)) {
      continue;
    }
    var_3 = scripts\engine\utility::array_add_safe(var_3, var_7);
  }

  var_0 waittill("trigger");
  var_3 = scripts\engine\utility::array_randomize(var_3);

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_3[var_4].claimed = 0;

  var_8 = 0;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_9 = var_2[var_4];

    if(!isDefined(var_9)) {
      continue;
    }
    if(isDefined(var_9.script_spawn_here)) {
      continue;
    }
    while(isDefined(var_3[var_8].script_noteworthy) && var_3[var_8].script_noteworthy == "dont_spawn")
      var_8++;

    var_9.origin = var_3[var_8].origin;
    var_9.angles = var_3[var_8].angles;
    var_9 scripts\engine\sp\utility::add_spawn_function(::claim_a_node, var_3[var_8]);
    var_8++;
  }

  scripts\engine\utility::array_thread(var_2, scripts\engine\sp\utility::add_spawn_function, ::camper_guy);
  scripts\engine\utility::array_thread(var_2, scripts\engine\sp\utility::add_spawn_function, ::move_when_enemy_hides, var_3);
  scripts\engine\utility::array_thread(var_2, scripts\engine\sp\utility::spawn_ai);
}

camper_guy() {
  self.goalradius = 8;
  self.fixednode = 1;
}

move_when_enemy_hides(var_0) {
  self endon("death");
  var_1 = 0;

  for(;;) {
    if(!isalive(self.enemy)) {
      self waittill("enemy");
      var_1 = 0;
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

    if(var_1) {
      if(self cansee(self.enemy)) {
        wait 0.05;
        continue;
      }

      var_1 = 0;
    } else {
      if(self cansee(self.enemy))
        var_1 = 1;

      wait 0.05;
      continue;
    }

    if(randomint(3) > 0) {
      var_2 = find_unclaimed_node(var_0);

      if(isDefined(var_2)) {
        claim_a_node(var_2, self.claimed_node);
        self waittill("goal");
      }
    }
  }
}

claim_a_node(var_0, var_1) {
  self setgoalnode(var_0);
  self.claimed_node = var_0;
  var_0.claimed = 1;

  if(isDefined(var_1))
    var_1.claimed = 0;
}

find_unclaimed_node(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1].claimed)
      continue;
    else
      return var_0[var_1];
  }

  return undefined;
}

flood_trigger_think(var_0) {
  var_1 = getspawnerarray(var_0.target);
  scripts\engine\utility::array_thread(var_1, ::flood_spawner_init);
  var_0 waittill("trigger");
  var_1 = getspawnerarray(var_0.target);
  scripts\engine\utility::array_thread(var_1, ::flood_spawner_think, var_0);
}

flood_spawner_init() {}

trigger_requires_player(var_0) {
  if(!isDefined(var_0))
    return 0;

  return isDefined(var_0.script_requires_player);
}

flood_spawner_think(var_0) {
  if(isspawner(self))
    self endon("death");

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");

  if(is_pyramid_spawner()) {
    pyramid_spawn(var_0);
    return;
  }

  var_1 = trigger_requires_player(var_0);
  scripts\engine\utility::script_delay();

  while(self.count > 0) {
    while(var_1 && !level.player istouching(var_0))
      wait 0.5;

    var_2 = scripts\engine\sp\utility::spawn_ai();

    if(scripts\common\ai::spawn_failed(var_2)) {
      wait 2;
      continue;
    }

    var_2 thread reincrement_count_if_deleted(self);
    var_2 waittill("death", var_3);

    if(!player_saw_kill(var_2, var_3))
      self.count++;

    if(!isDefined(var_2)) {
      continue;
    }
    if(!scripts\engine\utility::script_wait())
      wait(randomfloatrange(5, 9));
  }
}

player_saw_kill(var_0, var_1) {
  if(isDefined(self.script_force_count)) {
    if(self.script_force_count)
      return 1;
  }

  if(!isDefined(var_0))
    return 0;

  if(isalive(var_1)) {
    if(isPlayer(var_1))
      return 1;

    if(distance(var_1.origin, level.player.origin) < 200)
      return 1;
  } else if(isDefined(var_1)) {
    if(var_1.classname == "worldspawn")
      return 0;

    if(distance(var_1.origin, level.player.origin) < 200)
      return 1;
  }

  if(distance(var_0.origin, level.player.origin) < 200)
    return 1;

  return scripts\engine\trace::_bullet_trace_passed(level.player getEye(), var_0 getEye(), 0, undefined);
}

is_pyramid_spawner() {
  if(!isDefined(self.target))
    return 0;

  var_0 = getspawnerarray(self.target);

  if(!var_0.size)
    return 0;

  return issubstr(var_0[0].classname, "actor");
}

pyramid_death_report(var_0) {
  var_0.spawn waittill("death");
  self notify("death_report");
}

pyramid_spawn(var_0) {
  self endon("death");
  var_1 = trigger_requires_player(var_0);
  scripts\engine\utility::script_delay();

  if(var_1) {
    while(!level.player istouching(var_0))
      wait 0.5;
  }

  var_2 = getspawnerarray(self.target);
  self.spawners = 0;
  scripts\engine\utility::array_thread(var_2, ::pyramid_spawner_reports_death, self);
  var_4 = randomint(var_2.size);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(self.count <= 0) {
      return;
    }
    var_4++;

    if(var_4 >= var_2.size)
      var_4 = 0;

    var_5 = var_2[var_4];
    var_5 scripts\engine\sp\utility::set_count(1);
    var_6 = var_5 scripts\engine\sp\utility::spawn_ai();

    if(scripts\common\ai::spawn_failed(var_6)) {
      wait 2;
      continue;
    }

    self.count--;
    var_5.spawn = var_6;
    var_6 thread reincrement_count_if_deleted(self);
    var_6 thread expand_goalRadius(var_0);
    thread pyramid_death_report(var_5);
  }

  var_7 = 0.01;

  while(self.count > 0) {
    self waittill("death_report");
    var_8 = 0;

    foreach(var_5 in var_2) {
      var_5.postspawnresetorigin = 1;

      if(isDefined(var_5.suspended_ai))
        var_8 = 1;
    }

    if(var_8)
      var_0 waittill("trigger");

    scripts\engine\utility::script_wait();
    var_4 = randomint(var_2.size);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2 = scripts\engine\utility::array_removeundefined(var_2);

      if(!var_2.size) {
        if(isDefined(self))
          self delete();

        return;
      }

      var_4++;

      if(var_4 >= var_2.size)
        var_4 = 0;

      var_5 = var_2[var_4];

      if(isalive(var_5.spawn)) {
        continue;
      }
      if(isDefined(var_5.target))
        self.target = var_5.target;
      else
        self.target = undefined;

      var_6 = scripts\engine\sp\utility::spawn_ai();

      if(scripts\common\ai::spawn_failed(var_6)) {
        wait 2;
        continue;
      }

      var_6 thread reincrement_count_if_deleted(self);
      var_6 thread expand_goalRadius(var_0);
      var_5.spawn = var_6;
      thread pyramid_death_report(var_5);

      if(self.count <= 0)
        return;
    }
  }
}

pyramid_spawner_reports_death(var_0) {
  var_0 endon("death");
  var_0.spawners++;
  self waittill("death");
  var_0.spawners--;

  if(!var_0.spawners)
    var_0 delete();
}

expand_goalRadius(var_0) {
  if(isDefined(self.script_forcegoal)) {
    return;
  }
  var_1 = level.default_goalradius;

  if(isDefined(var_0)) {
    if(isDefined(var_0.script_radius)) {
      if(var_0.script_radius == -1) {
        return;
      }
      var_1 = var_0.script_radius;
    }
  }

  if(isDefined(self.script_forcegoal)) {
    return;
  }
  self endon("death");
  self waittill("goal");
  self.goalradius = var_1;
}

show_bad_path() {}

random_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getspawnerarray(var_0.target);

  if(!var_1.size) {
    return;
  }
  var_2 = scripts\engine\utility::random(var_1);
  var_1 = [];
  var_1[var_1.size] = var_2;

  if(isDefined(var_2.script_linkto)) {
    var_3 = strtok(var_2.script_linkto, " ");

    for(var_4 = 0; var_4 < var_3.size; var_4++)
      var_1[var_1.size] = getspawner(var_3[var_4], "script_linkname");
  }

  waittillframeend;
  scripts\engine\utility::array_thread(var_1, scripts\engine\sp\utility::add_spawn_function, ::blowout_goalradius_on_pathend);
  scripts\engine\utility::array_thread(var_1, scripts\engine\sp\utility::spawn_ai);
}

blowout_goalradius_on_pathend() {
  if(isDefined(self.script_forcegoal)) {
    return;
  }
  self endon("death");
  self waittill("reached_path_end");

  if(!isDefined(self getgoalvolume()))
    self.goalradius = level.default_goalradius;
}

spawner_dronespawn(var_0) {
  var_1 = var_0 spawndrone();

  if(!getqueuedspleveltransients(var_1.weapon)) {
    var_2 = scripts\sp\utility::getweapondefaults(var_1.weapon.basename);

    if(var_2.size == 0) {
      var_3 = getweaponmodel(var_1.weapon);
      var_1 attach(var_3, "tag_weapon_right");
      var_4 = getweaponhidetags(var_1.weapon);

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_6 = var_4[var_5];

        if(scripts\engine\utility::hastag(var_3, var_6))
          var_1 hidepart(var_6, var_3);
      }
    } else {
      if(!istrue(var_1.usescriptedweapon)) {
        var_7 = scripts\sp\utility::removeconflictingattachments(var_1.weapon.attachments, var_2);
        var_1.weapon = var_1.weapon withoutattachments();
        var_1.weapon = var_1.weapon withattachments(scripts\engine\utility::array_combine(var_7, var_1.weapon.attachments));
      }

      var_1 scripts\common\ai::gun_create_fake(getweaponattachmentworldmodels(var_1.weapon));

      if(!istrue(self.nodrop))
        var_1.weapon_object = var_1.weapon;

      var_1.weapon = isundefinedweapon();
    }
  }

  var_1 scripts\sp\utility::enable_procedural_bones();
  var_1.spawner = var_0;
  var_1.drone_delete_on_unload = isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "drone_delete_on_unload";
  var_1.finished_spawning = 1;
  var_1 notify("finished spawning");
  var_0 notify("drone_spawned", var_1);
  return var_1;
}

spawner_makerealai(var_0, var_1) {
  if(!isDefined(var_0.spawner)) {}

  var_2 = var_0.spawner.origin;
  var_3 = var_0.spawner.angles;
  var_4 = var_0.spawner.target;
  var_0.spawner.origin = var_0.origin;
  var_0.spawner.angles = var_0.angles;

  if(isDefined(var_1))
    var_0.spawner.target = var_1;

  var_0.spawner.count = var_0.spawner.count + 1;
  var_5 = var_0.spawner stalingradspawn();
  var_6 = scripts\common\ai::spawn_failed(var_5);

  if(var_6) {}

  var_5.vehicle_idling = var_0.vehicle_idling;
  var_5.vehicle_position = var_0.vehicle_position;
  var_5.standing = var_0.standing;
  var_5.forcecolor = var_0.forcecolor;
  var_0.spawner.origin = var_2;
  var_0.spawner.angles = var_3;
  var_0.spawner.target = var_4;
  var_0 delete();
  return var_5;
}

spawner_makefakeactor(var_0, var_1) {
  if(!isDefined(var_0.spawner)) {}

  var_2 = var_0.spawner.origin;
  var_3 = var_0.spawner.angles;
  var_4 = var_0.spawner.target;
  var_0.spawner.origin = var_0.origin;
  var_0.spawner.angles = var_0.angles;

  if(isDefined(var_1))
    var_0.spawner.target = var_1;

  var_0.spawner.count = var_0.spawner.count + 1;
  var_5 = scripts\engine\sp\utility::fakeactorspawn(var_0.spawner);
  var_6 = scripts\common\ai::spawn_failed(var_5);

  if(var_6) {}

  var_5.vehicle_idling = var_0.vehicle_idling;
  var_5.vehicle_position = var_0.vehicle_position;
  var_5.standing = var_0.standing;
  var_5.forcecolor = var_0.forcecolor;
  var_0.spawner.origin = var_2;
  var_0.spawner.angles = var_3;
  var_0.spawner.target = var_4;
  var_0 delete();
  return var_5;
}

add_random_killspawner_to_spawngroup() {
  var_0 = self.script_random_killspawner;
  var_1 = self.script_randomspawn;

  if(!isDefined(level.killspawn_groups))
    level.killspawn_groups = [];

  if(!isDefined(level.killspawn_groups[var_0]))
    level.killspawn_groups[var_0] = [];

  if(!isDefined(level.killspawn_groups[var_0][var_1]))
    level.killspawn_groups[var_0][var_1] = [];

  level.killspawn_groups[var_0][var_1][self.export] = self;
}

add_to_spawngroup() {
  var_0 = self.script_spawngroup;
  var_1 = self.script_spawnsubgroup;

  if(!isDefined(level.spawn_groups[var_0]))
    level.spawn_groups[var_0] = [];

  if(!isDefined(level.spawn_groups[var_0][var_1]))
    level.spawn_groups[var_0][var_1] = [];

  level.spawn_groups[var_0][var_1][self.export] = self;
}

start_off_running() {
  self endon("death");
  self.disableexits = 1;
  wait 3;
  self.disableexits = 0;
}

deathtime() {
  self endon("death");
  wait(self.script_deathtime);
  wait(randomfloat(10));
  self kill();
}

tracker_bullet_hit(var_0) {
  self notify("tracker_bullet_hit");
  self endon("tracker_bullet_hit");

  if(self.team != "axis") {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  scripts\engine\sp\utility::hudoutline_enable_new("outlinefill_nodepth_red", "tracker");
  scripts\engine\utility::waittill_notify_or_timeout("death", 5.0);
  scripts\engine\sp\utility::hudoutline_disable("tracker");

  if(isalive(self)) {
    for(var_1 = 0; var_1 < 3; var_1++) {
      wait 0.2;
      scripts\engine\sp\utility::hudoutline_enable_new("outlinefill_nodepth_red", "tracker");
      wait 0.15;
      scripts\engine\sp\utility::hudoutline_disable("tracker");
    }
  }
}

prespawn_suspended_ai() {
  if(!isDefined(self.script_suspend))
    return undefined;

  if(!isDefined(self.suspended_ai))
    return 0;

  self.count++;

  if(!isDefined(self.og_spawner_origin))
    self.og_spawner_origin = self.origin;

  if(!isDefined(self.og_spawner_angles))
    self.og_spawner_angles = self.angles;

  if(isDefined(self.try_og_origin)) {
    self.origin = self.og_spawner_origin;
    self.angles = self.og_spawner_angles;
  } else {
    self.origin = self.suspended_ai.origin;
    self.angles = self.suspended_ai.angles;
  }

  if(isDefined(self.suspended_ai.suspendvars))
    self.suspendvars = self.suspended_ai.suspendvars;

  return 1;
}

postspawn_suspended_ai() {
  var_0 = self.spawner.suspended_ai;

  if(isDefined(self.spawner.postspawnresetorigin)) {
    self.spawner.origin = self.og_spawner_origin;
    self.spawner.angles = self.og_spawner_angles;
  }

  thread postspawn_suspend_ai_framedelay(var_0);

  if(!isDefined(var_0.suspendvars)) {
    return;
  }
  self.suspendvars = var_0.suspendvars;
  self.spawner.suspended_ai = undefined;
}

postspawn_suspend_ai_framedelay(var_0) {
  waittillframeend;
  waittillframeend;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_0.stealth)) {
    var_1 = var_0.stealth.bsmstate;

    if(var_1 > 1) {
      var_1 = var_0.stealth.bsmstate - int((gettime() - var_0.suspendtime) / 10000);
      var_1 = int(max(2, var_1));
    } else if(var_1 > 0) {
      var_1 = var_0.stealth.bsmstate - int((gettime() - var_0.suspendtime) / 5000);
      var_1 = int(max(0, var_1));
    }

    var_2 = int_to_stealth_state(var_1);
    scripts\stealth\enemy::bt_set_stealth_state(var_2, var_0.stealth.investigateevent);
  }
}

int_to_stealth_state(var_0) {
  switch (var_0) {
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

trigger_zone_spawn(var_0) {
  var_0 endon("death");
  var_1 = undefined;

  if(isDefined(var_0.script_suspend))
    var_1 = var_0.script_suspend;

  var_2 = undefined;

  if(isDefined(var_0.script_suspend_group))
    var_2 = var_0.script_suspend_group;

  var_3 = getspawnerarray(var_0.target);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.script_suspend))
      var_5.script_suspend = var_1;

    if(!isDefined(var_5.script_suspend_group))
      var_5.script_suspend_group = var_2;
  }

  for(;;) {
    var_0 waittill("trigger", var_7);
    var_0 scripts\engine\utility::script_delay();
    var_3 = getspawnerarray(var_0.target);

    foreach(var_5 in var_3)
    var_5 thread scripts\engine\sp\utility::spawn_ai();

    while(isalive(var_7) && var_7 istouching(var_0))
      wait 0.1;
  }
}

spawn_subclass_juggernaut() {
  if(!isDefined(level.juggernaut_initialized)) {
    level.juggernaut_initialized = 1;
    level.juggernaut_next_alert_time = 0;
  }

  scripts\common\ai::disable_turnanims();
  scripts\engine\sp\utility::disable_surprise();
  thread juggernaut_sound_when_close();
}

juggernaut_sound_when_close() {
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