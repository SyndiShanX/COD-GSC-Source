/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_spawner.gsc
********************************/

main() {
  precachemodel("grenade_bag");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("team3");
  createthreatbiasgroup("civilian");
  maps\_anim::addnotetrack_customfunction("generic", "rappel_pushoff_initial_npc", maps\_utility::enable_achievement_harder_they_fall_guy);
  maps\_anim::addnotetrack_customfunction("generic", "ps_rappel_pushoff_initial_npc", maps\_utility::enable_achievement_harder_they_fall_guy);
  maps\_anim::addnotetrack_customfunction("generic", "feet_on_ground", maps\_utility::disable_achievement_harder_they_fall_guy);
  maps\_anim::addnotetrack_customfunction("generic", "ps_rappel_clipout_npc", maps\_utility::disable_achievement_harder_they_fall_guy);

  foreach(var_1 in level.players)
  var_1 setthreatbiasgroup("allies");

  level._nextcoverprint = 0;
  level._ai_group = [];
  level.killedaxis = 0;
  level.ffpoints = 0;
  level.missionfailed = 0;
  level.gather_delay = [];
  level.smoke_thrown = [];

  if(!isdefined(level.deathflags))
    level.deathflags = [];

  level.spawner_number = 0;
  level.go_to_node_arrays = [];

  if(!isdefined(level.subclass_spawn_functions))
    level.subclass_spawn_functions = [];

  level.subclass_spawn_functions["regular"] = ::subclass_regular;
  level.subclass_spawn_functions["elite"] = ::subclass_elite;
  level.team_specific_spawn_functions = [];
  level.team_specific_spawn_functions["axis"] = ::spawn_team_axis;
  level.team_specific_spawn_functions["allies"] = ::spawn_team_allies;
  level.team_specific_spawn_functions["team3"] = ::spawn_team_team3;
  level.team_specific_spawn_functions["neutral"] = ::spawn_team_neutral;
  level.next_health_drop_time = 0;
  level.guys_to_die_before_next_health_drop = randomintrange(1, 4);

  if(!isdefined(level.default_goalradius))
    level.default_goalradius = 2048;

  if(!isdefined(level.default_goalheight))
    level.default_goalheight = 80;

  level.portable_mg_gun_tag = "J_Shoulder_RI";
  level.mg42_hide_distance = 1024;

  if(!isdefined(level.maxfriendlies))
    level.maxfriendlies = 11;

  level._max_script_health = 0;
  var_3 = getaispeciesarray();
  common_scripts\utility::array_thread(var_3, ::living_ai_prethink);
  level.ai_classname_in_level = [];
  level.drone_paths = [];
  var_4 = getspawnerarray();

  for (var_5 = 0; var_5 < var_4.size; var_5++)
    var_4[var_5] thread spawn_prethink();

  level.drone_paths = undefined;
  thread process_deathflags();
  common_scripts\utility::array_thread(var_3, ::spawn_think);
  level.ai_classname_in_level_keys = getarraykeys(level.ai_classname_in_level);

  for (var_5 = 0; var_5 < level.ai_classname_in_level_keys.size; var_5++) {
    if(!issubstr(tolower(level.ai_classname_in_level_keys[var_5]), "rpg")) {
      continue;
    }
    precacheitem("rpg_player");
    break;
  }

  level.ai_classname_in_level_keys = undefined;
}

aitype_check() {}

check_script_char_group_ratio(var_0) {
  if(var_0.size <= 16) {
    return;
  }
  var_1 = 0;
  var_2 = 0;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!var_0[var_3].team != "axis") {
      continue;
    }
    var_1++;

    if(!var_0[var_3] has_char_group()) {
      continue;
    }
    var_2++;
  }
}

has_char_group() {
  if(isdefined(self.script_char_group))
    return 1;

  return isdefined(self.script_char_index);
}

process_deathflags() {
  foreach(var_2, var_1 in level.deathflags) {
    level.deathflags[var_2] = [];
    level.deathflags[var_2]["spawners"] = [];
    level.deathflags[var_2]["ai"] = [];

    if(!isdefined(level.flag[var_2]))
      common_scripts\utility::flag_init(var_2);
  }
}

spawn_guys_until_death_or_no_count() {
  self endon("death");

  for (;;) {
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

  if(isdefined(self.script_deathflag_longdeath))
    waittilldeathorpaindeath();
  else
    self waittill("death");

  level.deathflags[var_1]["ai"][var_0] = undefined;
  update_deathflag(var_1);
}

vehicle_deathflag() {
  var_0 = self.unique_id;
  var_1 = self.script_deathflag;

  if(!isdefined(level.deathflags) || !isdefined(level.deathflags[self.script_deathflag])) {
    waittillframeend;

    if(!isdefined(self))
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

  if(!isdefined(self) || self.count == 0) {
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

  if(!isdefined(self)) {
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

  common_scripts\utility::flag_set(var_0);
}

outdoor_think(var_0) {
  var_0 endon("death");

  for (;;) {
    var_0 waittill("trigger", var_1);

    if(!isai(var_1)) {
      continue;
    }
    var_1 thread maps\_utility::ignore_triggers(0.15);
    var_1 maps\_utility::disable_cqbwalk();
    var_1.wantshotgun = 0;
  }
}

indoor_think(var_0) {
  var_0 endon("death");

  for (;;) {
    var_0 waittill("trigger", var_1);

    if(!isai(var_1)) {
      continue;
    }
    var_1 thread maps\_utility::ignore_triggers(0.15);
    var_1 maps\_utility::enable_cqbwalk();
    var_1.wantshotgun = 1;
  }
}

doautospawn(var_0) {
  var_0 endon("death");
  self endon("death");

  for (;;) {
    self waittill("trigger");

    if(!var_0.count) {
      return;
    }
    if(self.target != var_0.targetname) {
      return;
    }
    if(isdefined(var_0.triggerunlocked)) {
      return;
    }
    var_1 = var_0 maps\_utility::spawn_ai();

    if(maps\_utility::spawn_failed(var_1))
      var_0 notify("spawn_failed");

    if(isdefined(self.wait) && self.wait > 0)
      wait(self.wait);
  }
}

trigger_spawner(var_0) {
  var_1 = var_0.random_killspawner;
  var_2 = var_0.target;
  var_0 waittill("trigger");
  var_0 maps\_utility::script_delay();

  if(isdefined(var_1))
    waittillframeend;

  var_3 = getentarray(var_2, "targetname");

  foreach(var_5 in var_3) {
    if(var_5.code_classname == "script_vehicle") {
      if(isdefined(var_5.script_moveoverride) && var_5.script_moveoverride == 1 || !isdefined(var_5.target))
        thread maps\_vehicle::vehicle_spawn(var_5);
      else
        var_5 thread maps\_vehicle::spawn_vehicle_and_gopath();

      continue;
    }

    var_5 thread trigger_spawner_spawns_guys();

    if(level.currentgen)
      wait 0.1;
  }

  if(isdefined(level.spawn_pool_enabled))
    trigger_pool_spawners(var_2);
}

trigger_pool_spawners(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  if(getentarray(var_0, "target").size <= 1)
    maps\_utility::deletestructarray_ref(var_1);

  var_2 = get_pool_spawners_from_structarray(var_1);
  common_scripts\utility::array_thread(var_2, ::trigger_spawner_spawns_guys);
}

get_pool_spawners_from_structarray(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isdefined(var_4.script_spawn_pool)) {
      continue;
    }
    if(!isdefined(var_2[var_4.script_spawn_pool]))
      var_2[var_4.script_spawn_pool] = [];

    var_2[var_4.script_spawn_pool][var_2[var_4.script_spawn_pool].size] = var_4;
  }

  foreach(var_7 in var_2) {
    foreach(var_4 in var_7) {
      var_9 = get_spawner_from_pool(var_4, var_7.size);
      var_1[var_1.size] = var_9;
    }
  }

  return var_1;
}

get_spawner_from_pool(var_0, var_1) {
  if(!isdefined(level.spawner_pool))
    level.spawner_pool = [];

  if(!isdefined(level.spawner_pool[var_0.script_spawn_pool]))
    level.spawner_pool[var_0.script_spawn_pool] = create_new_spawner_pool(var_0.script_spawn_pool);

  var_2 = level.spawner_pool[var_0.script_spawn_pool];
  var_3 = var_2.pool[var_2.poolindex];
  var_2.poolindex++;
  var_2.poolindex = var_2.poolindex % var_2.pool.size;
  var_3.origin = var_0.origin;

  if(isdefined(var_0.angles))
    var_3.angles = var_0.angles;
  else if(isdefined(var_0.target)) {
    var_4 = getnode(var_0.target, "targetname");

    if(isdefined(var_4))
      var_3.angles = vectortoangles(var_4.origin - var_3.origin);
  }

  if(isdefined(level.spawn_pool_copy_function))
    var_3[[level.spawn_pool_copy_function]](var_0);

  if(isdefined(var_0.target))
    var_3.target = var_0.target;

  var_3.count = 1;
  return var_3;
}

create_new_spawner_pool(var_0) {
  var_1 = getspawnerarray();
  var_2 = spawnstruct();
  var_3 = [];

  foreach(var_5 in var_1) {
    if(!isdefined(var_5.script_spawn_pool)) {
      continue;
    }
    if(var_5.script_spawn_pool != var_0) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  var_2.poolindex = 0;
  var_2.pool = var_3;
  return var_2;
}

trigger_spawner_spawns_guys() {
  self endon("death");
  maps\_utility::script_delay();

  if(!isdefined(self))
    return undefined;

  if(isdefined(self.script_drone)) {
    var_0 = maps\_utility::dronespawn(self, 1);
    return undefined;
  } else if(!issubstr(self.classname, "actor"))
    return undefined;

  var_1 = isdefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

  if(isdefined(self.script_forcespawn))
    var_0 = self stalingradspawn(var_1);
  else
    var_0 = self dospawn(var_1);

  if(!maps\_utility::spawn_failed(var_0)) {
    if(isdefined(self.script_combatbehavior)) {
      if(self.script_combatbehavior == "heat")
        var_0 maps\_utility::enable_heat_behavior();

      if(self.script_combatbehavior == "cqb")
        var_0 maps\_utility::enable_cqbwalk();
    }

    var_0 maps\_colors::setup_nodes_intelligently_from_team();
  }

  return var_0;
}

trigger_spawner_reinforcement(var_0) {
  var_1 = var_0.target;
  var_2 = 0;
  var_3 = getentarray(var_1, "targetname");

  foreach(var_5 in var_3) {
    if(!isdefined(var_5.target)) {
      continue;
    }
    var_6 = getent(var_5.target, "targetname");

    if(!isdefined(var_6)) {
      if(!isdefined(var_5.script_linkto)) {
        continue;
      }
      var_6 = var_5 common_scripts\utility::get_linked_ent();

      if(!isdefined(var_6)) {
        continue;
      }
      if(!isspawner(var_6))
        continue;
    }

    var_2 = 1;
    break;
  }

  var_0 waittill("trigger");
  var_0 maps\_utility::script_delay();
  var_3 = getentarray(var_1, "targetname");

  foreach(var_5 in var_3)
  var_5 thread trigger_reinforcement_spawn_guys();
}

trigger_reinforcement_spawn_guys() {
  var_0 = trigger_reinforcement_get_reinforcement_spawner();
  var_1 = trigger_spawner_spawns_guys();

  if(!isdefined(var_1)) {
    self delete();

    if(isdefined(var_0)) {
      var_1 = var_0 trigger_spawner_spawns_guys();
      var_0 delete();

      if(!isdefined(var_1))
        return;
    } else
      return;
  }

  if(!isdefined(var_0)) {
    return;
  }
  var_1 waittill("death");

  if(!isdefined(var_0)) {
    return;
  }
  if(!isdefined(var_0.count))
    var_0.count = 1;

  for (;;) {
    if(!isdefined(var_0)) {
      break;
    }

    var_2 = var_0 thread trigger_spawner_spawns_guys();

    if(!isdefined(var_2)) {
      var_0 delete();
      break;
    }

    var_2 thread reincrement_count_if_deleted(var_0);
    var_2 waittill("death", var_3);

    if(!player_saw_kill(var_2, var_3)) {
      if(!isdefined(var_0)) {
        break;
      }

      var_0.count++;
    }

    if(!isdefined(var_2)) {
      continue;
    }
    if(!isdefined(var_0)) {
      break;
    }

    if(!isdefined(var_0.count)) {
      break;
    }

    if(var_0.count <= 0) {
      break;
    }

    if(!maps\_utility::script_wait())
      wait(randomfloatrange(1, 3));
  }

  if(isdefined(var_0))
    var_0 delete();
}

trigger_reinforcement_get_reinforcement_spawner() {
  if(isdefined(self.target)) {
    var_0 = getent(self.target, "targetname");

    if(isdefined(var_0) && isspawner(var_0))
      return var_0;
  }

  if(isdefined(self.script_linkto)) {
    var_0 = common_scripts\utility::get_linked_ent();

    if(isdefined(var_0) && isspawner(var_0))
      return var_0;
  }

  return undefined;
}

flood_spawner_scripted(var_0) {
  common_scripts\utility::array_thread(var_0, ::flood_spawner_init);
  common_scripts\utility::array_thread(var_0, ::flood_spawner_think);
}

reincrement_count_if_deleted(var_0) {
  var_0 endon("death");

  if(isdefined(self.script_force_count)) {
    if(self.script_force_count)
      return;
  }

  self waittill("death");

  if(!isdefined(self))
    var_0.count++;
}

delete_start(var_0) {
  for (var_1 = 0; var_1 < 2; var_1++) {
    switch (var_1) {
      case 0:
        var_2 = "axis";
        break;
      default:
        var_2 = "allies";
        break;
    }

    var_3 = getentarray(var_2, "team");

    for (var_4 = 0; var_4 < var_3.size; var_4++) {
      if(isdefined(var_3[var_4].script_start)) {
        if(var_3[var_4].script_start == var_0)
          var_3[var_4] thread delete_me();
      }
    }
  }
}

kill_trigger(var_0) {
  if(!isdefined(var_0)) {
    return;
  }
  if(isdefined(var_0.targetname) && var_0.targetname != "flood_spawner") {
    return;
  }
  var_0 delete();
}

random_killspawner(var_0) {
  var_0 endon("death");
  var_1 = var_0.script_random_killspawner;
  waittillframeend;

  if(!isdefined(level.killspawn_groups[var_1])) {
    return;
  }
  var_0 waittill("trigger");
  cull_spawners_from_killspawner(var_1);
}

cull_spawners_from_killspawner(var_0) {
  if(!isdefined(level.killspawn_groups[var_0])) {
    return;
  }
  var_1 = level.killspawn_groups[var_0];
  var_2 = getarraykeys(var_1);

  if(var_2.size <= 1) {
    return;
  }
  var_3 = common_scripts\utility::random(var_2);
  var_1[var_3] = undefined;

  foreach(var_9, var_5 in var_1) {
    foreach(var_8, var_7 in var_5) {
      if(isdefined(var_7))
        var_7 delete();
    }

    level.killspawn_groups[var_0][var_9] = undefined;
  }
}

killspawner(var_0) {
  var_1 = getspawnerarray();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isdefined(var_1[var_2].script_killspawner) && var_0 == var_1[var_2].script_killspawner)
      var_1[var_2] delete();
  }
}

kill_spawner(var_0) {
  var_1 = var_0.script_killspawner;
  var_0 waittill("trigger");
  waittillframeend;
  waittillframeend;
  killspawner(var_1);
  kill_trigger(var_0);
}

empty_spawner(var_0) {
  var_1 = var_0.script_emptyspawner;
  var_0 waittill("trigger");
  var_2 = getspawnerarray();

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isdefined(var_2[var_3].script_emptyspawner)) {
      continue;
    }
    if(var_1 != var_2[var_3].script_emptyspawner) {
      continue;
    }
    if(isdefined(var_2[var_3].script_flanker))
      level notify("stop_flanker_behavior" + var_2[var_3].script_flanker);

    var_2[var_3] maps\_utility::set_count(0);
    var_2[var_3] notify("emptied spawner");
  }

  var_0 notify("deleted spawners");
}

kill_spawnernum(var_0) {
  var_1 = getspawnerarray();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isdefined(var_1[var_2].script_killspawner)) {
      continue;
    }
    if(var_0 != var_1[var_2].script_killspawner) {
      continue;
    }
    var_1[var_2] delete();
  }
}

trigger_spawn(var_0) {}

spawn_grenade(var_0, var_1) {
  if(!isdefined(level.grenade_cache) || !isdefined(level.grenade_cache[var_1])) {
    level.grenade_cache_index[var_1] = 0;
    level.grenade_cache[var_1] = [];
  }

  var_2 = level.grenade_cache_index[var_1];
  var_3 = level.grenade_cache[var_1][var_2];

  if(isdefined(var_3))
    var_3 delete();

  var_4 = "weapon_fraggrenade";

  if(isdefined(level.player) && isdefined(level.player.variable_grenade)) {
    if(common_scripts\utility::cointoss())
      var_4 = "weapon_frag_grenade_var";
    else
      var_4 = "weapon_flash_grenade_var";
  }

  var_3 = spawn(var_4, var_0);
  level.grenade_cache[var_1][var_2] = var_3;
  level.grenade_cache_index[var_1] = (var_2 + 1) % 16;
  return var_3;
}

waittilldeathorpaindeath() {
  self endon("death");
  self waittill("pain_death");
}

drop_gear() {
  var_0 = self.team;
  waittilldeathorpaindeath();

  if(!isdefined(self)) {
    return;
  }
  if(isdefined(self.nodrop)) {
    return;
  }
  if(level.tire_explosion) {
    var_1 = self.origin;
    var_2 = self geteye();
    waittillframeend;

    for (var_3 = 0; var_3 < 15; var_3++)
      thread random_tire(var_1, var_2);

    if(isdefined(self)) {
      animscripts\shared::dropallaiweapons();
      wait 0.1;

      if(isdefined(self) && !isremovedentity(self))
        self delete();
    }

    return;
  }

  self.ignoreforfixednodesafecheck = 1;

  if(self.grenadeammo <= 0) {
    return;
  }
  level.nextgrenadedrop--;

  if(level.nextgrenadedrop > 0) {
    return;
  }
  level.nextgrenadedrop = 3 + randomint(2);
  var_4 = 25;
  var_5 = 12;
  var_1 = self.origin + (randomint(var_4) - var_5, randomint(var_4) - var_5, 2) + (0, 0, 42);
  var_6 = (0, randomint(360), 90);
  thread spawn_grenade_bag(var_1, var_6, self.team);
}

random_tire(var_0, var_1) {
  if(level.cheattires.size == level.cheattires_max) {
    level.cheattires[0] delete();
    level.cheattires = maps\_utility::array_remove_index(level.cheattires, 0);
  }

  var_2 = spawn("script_model", (0, 0, 0));
  var_2.angles = (0, randomint(360), 0);
  var_3 = randomfloat(1);
  var_2.origin = var_0 * var_3 + var_1 * (1 - var_3);
  var_2 setmodel(level.random_tire_model);
  var_4 = common_scripts\utility::randomvector(15000);
  var_4 = (var_4[0], var_4[1], abs(var_4[2]));
  var_2 physicslaunchclient(var_2.origin, var_4);
  level.cheattires[level.cheattires.size] = var_2;
  var_2 endon("death");
  wait(randomfloatrange(5.0, 10.0));

  if(isdefined(var_2)) {
    level.cheattires = common_scripts\utility::array_remove(level.cheattires, var_2);
    var_2 delete();
  }
}

override_random_tire(var_0) {
  precachemodel(var_0);
  level.random_tire_model = var_0;
}

spawn_grenade_bag(var_0, var_1, var_2) {
  var_3 = spawn_grenade(var_0, var_2);
  var_3 setmodel("grenade_bag");
  var_3.angles = var_1;
  var_3 hide();
  wait 0.7;

  if(!isdefined(var_3)) {
    return;
  }
  var_3 show();
}

dronespawner_init() {
  maps\_drone_base::drone_init_path();
}

empty() {}

spawn_prethink() {
  level.ai_classname_in_level[self.classname] = 1;

  if(isdefined(self.script_difficulty)) {
    switch (self.script_difficulty) {
      case "easy":
        if(level.gameskill > 1)
          maps\_utility::set_count(0);

        break;
      case "hard":
        if(level.gameskill < 2)
          maps\_utility::set_count(0);

        break;
    }
  }

  if(isdefined(self.script_drone))
    thread dronespawner_init();

  if(isdefined(self.script_aigroup)) {
    var_0 = self.script_aigroup;

    if(!isdefined(level._ai_group[var_0]))
      aigroup_create(var_0);

    thread aigroup_spawnerthink(level._ai_group[var_0]);
  }

  if(isdefined(self.script_delete)) {
    var_1 = 0;

    if(isdefined(level._ai_delete)) {
      if(isdefined(level._ai_delete[self.script_delete]))
        var_1 = level._ai_delete[self.script_delete].size;
    }

    level._ai_delete[self.script_delete][var_1] = self;
  }

  if(isdefined(self.script_health)) {
    if(self.script_health > level._max_script_health)
      level._max_script_health = self.script_health;

    var_1 = 0;

    if(isdefined(level._ai_health)) {
      if(isdefined(level._ai_health[self.script_health]))
        var_1 = level._ai_health[self.script_health].size;
    }

    level._ai_health[self.script_health][var_1] = self;
  }

  if(isdefined(self.script_deathflag))
    thread spawner_deathflag();

  if(isdefined(self.target))
    crawl_through_targets_to_init_flags();

  if(isdefined(self.script_spawngroup))
    add_to_spawngroup();

  if(isdefined(self.script_random_killspawner))
    add_random_killspawner_to_spawngroup();

  if(!isdefined(self.spawn_functions))
    self.spawn_functions = [];

  for (;;) {
    var_2 = undefined;
    self waittill("spawned", var_2);

    if(!isalive(var_2)) {
      continue;
    }
    if(isdefined(level.spawnercallbackthread))
      self thread[[level.spawnercallbackthread]](var_2);

    if(isdefined(self.script_delete)) {
      for (var_3 = 0; var_3 < level._ai_delete[self.script_delete].size; var_3++) {
        if(level._ai_delete[self.script_delete][var_3] != self)
          level._ai_delete[self.script_delete][var_3] delete();
      }
    }

    var_2.spawn_funcs = self.spawn_functions;
    var_2.spawner = self;

    if(isdefined(self.targetname)) {
      var_2 thread spawn_think(self.targetname);
      continue;
    }

    var_2 thread spawn_think();
  }
}

spawn_think(var_0) {
  level.ai_classname_in_level[self.classname] = 1;
  spawn_think_action(var_0);
  self endon("death");

  if(shouldnt_spawn_because_of_script_difficulty())
    self delete();

  thread run_spawn_functions();
  self.finished_spawning = 1;
  self notify("finished spawning");

  if(self.team == "allies" && !isdefined(self.script_nofriendlywave))
    thread friendlydeath_thread();
}

shouldnt_spawn_because_of_script_difficulty() {
  if(!isdefined(self.script_difficulty))
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
  self endon("death");

  if(!isdefined(self.spawn_funcs)) {
    self.spawner = undefined;
    return;
  }

  for (var_0 = 0; var_0 < self.spawn_funcs.size; var_0++) {
    var_1 = self.spawn_funcs[var_0];

    if(isdefined(var_1["param5"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"], var_1["param5"]);
      continue;
    }

    if(isdefined(var_1["param4"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"]);
      continue;
    }

    if(isdefined(var_1["param3"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"]);
      continue;
    }

    if(isdefined(var_1["param2"])) {
      thread[[var_1["function"]]](var_1["param1"], var_1["param2"]);
      continue;
    }

    if(isdefined(var_1["param1"])) {
      thread[[var_1["function"]]](var_1["param1"]);
      continue;
    }

    thread[[var_1["function"]]]();
  }

  var_2 = common_scripts\utility::ter_op(isdefined(level.vehicle_spawn_functions_enable) && level.vehicle_spawn_functions_enable && self.code_classname == "script_vehicle", self.script_team, self.team);

  if(isdefined(var_2)) {
    for (var_0 = 0; var_0 < level.spawn_funcs[var_2].size; var_0++) {
      var_1 = level.spawn_funcs[var_2][var_0];

      if(isdefined(var_1["param5"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"], var_1["param5"]);
        continue;
      }

      if(isdefined(var_1["param4"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"], var_1["param4"]);
        continue;
      }

      if(isdefined(var_1["param3"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"], var_1["param3"]);
        continue;
      }

      if(isdefined(var_1["param2"])) {
        thread[[var_1["function"]]](var_1["param1"], var_1["param2"]);
        continue;
      }

      if(isdefined(var_1["param1"])) {
        thread[[var_1["function"]]](var_1["param1"]);
        continue;
      }

      thread[[var_1["function"]]]();
    }
  }

  self.spawn_funcs = undefined;
  self.spawner = undefined;
}

specops_think() {
  if(!maps\_utility::is_specialop()) {
    return;
  }
  maps\_utility::add_damage_function(::specops_dmg);
  thread multikill_monitor();
}

multikill_monitor() {
  self waittill("death", var_0, var_1, var_2);

  if(!isdefined(self)) {
    return;
  }
  if(!self isbadguy()) {
    return;
  }
  if(!isdefined(var_0)) {
    return;
  }
  if(!isplayer(var_0)) {
    return;
  }
  if(!isdefined(var_2)) {
    var_0.multikill_count = undefined;
    return;
  }

  if(!isdefined(var_0.multikill_count))
    var_0.multikill_count = 1;
  else
    var_0.multikill_count++;

  if(maps\_utility::is_survival() && var_0.multikill_count >= 4)
    var_0 notify("sur_ch_quadkill");

  waittillframeend;
  var_0.multikill_count = undefined;
}

specops_dmg(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(self)) {
    return;
  }
  if(isdefined(var_1) && isplayer(var_1)) {
    self.last_dmg_player = var_1;
    self.last_dmg_type = var_4;
  }
}

check_explosion_man_achievement(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isplayer(var_0) && (!isdefined(var_1) || var_1 != "seaknight_mark19")) {
    return;
  }
  if(isdefined(var_1)) {
    switch (var_1) {
      case "c4":
      case "seaknight_mark19":
      case "javelin":
      case "rpg":
      case "claymore":
      case "fraggrenade":
        var_3 = 1;
    }
  }

  if(isdefined(var_2) && (var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_GRENADE_SPLASH"))
    var_3 = 1;

  if(var_3) {
    if(!isdefined(level.h1_achievement_explosionman))
      level.h1_achievement_explosionman = 1;
    else {
      level.h1_achievement_explosionman++;

      if(level.h1_achievement_explosionman == 20)
        maps\_utility::giveachievement_wrapper("EXPLOSION_MAN");
    }
  }
}

deathfunctions() {
  self waittill("death", var_0, var_1, var_2);
  level notify("ai_killed", self);

  if(!isdefined(self)) {
    return;
  }
  if(isdefined(var_0)) {
    if(self.team == "axis" || self.team == "team3") {
      var_3 = undefined;

      if(isdefined(var_0.attacker)) {
        if(isdefined(var_0.issentrygun) && var_0.issentrygun)
          var_3 = "sentry";

        if(isdefined(var_0.destructible_type))
          var_3 = "destructible";

        var_0 = var_0.attacker;
      } else if(isdefined(var_0.owner)) {
        if(isai(var_0) && isplayer(var_0.owner))
          var_3 = "friendly";

        var_0 = var_0.owner;
      } else if(isdefined(var_0.damageowner)) {
        if(isdefined(var_0.destructible_type))
          var_3 = "destructible";

        var_0 = var_0.damageowner;
      }

      check_explosion_man_achievement(var_0, var_2, var_1);
      var_4 = 0;

      if(isplayer(var_0))
        var_4 = 1;

      if(isdefined(level.pmc_match) && level.pmc_match)
        var_4 = 1;

      if(isdefined(var_1) && var_1 == "MOD_CRUSH") {
        if(isdefined(level.hovertank_player) || isdefined(level.player.drivingvehicleandturret))
          level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
      }

      if(var_4)
        var_0 maps\_player_stats::register_kill(self, var_1, var_2, var_3);
    }
  }

  for (var_5 = 0; var_5 < self.deathfuncs.size; var_5++) {
    var_6 = self.deathfuncs[var_5];

    switch (var_6["params"]) {
      case 0:
        [
          [var_6["func"]]
        ](var_0);
        break;
      case 1:
        [
          [var_6["func"]]
        ](var_0, var_6["param1"]);
        break;
      case 2:
        [
          [var_6["func"]]
        ](var_0, var_6["param1"], var_6["param2"]);
        break;
      case 3:
        [
          [var_6["func"]]
        ](var_0, var_6["param1"], var_6["param2"], var_6["param3"]);
        break;
    }
  }
}

ai_damage_think() {
  self.damage_functions = [];

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    if(isdefined(var_1) && isplayer(var_1)) {
      var_7 = var_1 getcurrentweapon();

      if(isdefined(var_7) && maps\_utility::isprimaryweapon(var_7) && isdefined(var_4) && (var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET"))
        var_1 thread maps\_player_stats::register_shot_hit();
    }

    foreach(var_9 in self.damage_functions)
    thread[[var_9]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    if(!isalive(self) || self.delayeddeath) {
      break;
    }
  }
}

living_ai_prethink() {
  if(isdefined(self.script_deathflag))
    level.deathflags[self.script_deathflag] = 1;

  if(isdefined(self.target))
    crawl_through_targets_to_init_flags();
}

crawl_through_targets_to_init_flags() {
  var_0 = get_node_funcs_based_on_target();

  if(isdefined(var_0)) {
    var_1 = var_0["destination"];
    var_2 = var_0["get_target_func"];

    for (var_3 = 0; var_3 < var_1.size; var_3++)
      crawl_target_and_init_flags(var_1[var_3], var_2);
  }
}

spawn_team_allies() {
  self.usechokepoints = 0;
}

spawn_team_axis() {
  if(isdefined(level.xp_enable) && level.xp_enable && isdefined(level.xp_ai_func))
    self thread[[level.xp_ai_func]]();

  if(self.type == "human" && !isdefined(level.disablegeardrop))
    thread drop_gear();

  maps\_utility::add_damage_function(maps\_gameskill::auto_adjust_enemy_death_detection);

  if(isdefined(self.script_combatmode))
    self.combatmode = self.script_combatmode;
}

spawn_team_team3() {
  spawn_team_axis();
}

spawn_team_neutral() {}

subclass_elite() {
  self endon("death");
  self.elite = 1;
  self.doorflashchance = 0.5;

  if(!isdefined(self.script_accuracy))
    self.baseaccuracy = 2;

  self.aggressivemode = 1;
  self.minpaindamage = 100;
  maps\_utility::add_damage_function(animscripts\pain::additive_pain);
  maps\_utility::add_damage_function(::pain_resistance);
  self.custom_laser_function = ::spawner_force_laser_on;

  if(isdefined(self.weapon) && weaponclass(self.weapon) != "rocketlauncher")
    self laseron();
}

spawner_force_laser_on() {
  var_0 = undefined;

  if(isdefined(self.weapon))
    var_0 = self.weapon;
  else
    return;

  if(isdefined(var_0) && weaponclass(var_0) != "rocketlauncher")
    self laseron();
}

subclass_regular() {
  if(!isdefined(self.script_accuracy))
    self.baseaccuracy = 1.05;
}

pain_resistance(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(self.health <= 0) {
    return;
  }
  if(var_0 >= self.minpaindamage) {
    var_7 = self.minpaindamage;
    self.minpaindamage = var_7 * 3;
    wait 5;
    self.minpaindamage = var_7;
  }
}

bullet_resistance(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(self) || self.health <= 0) {
    return;
  }
  if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    return;
  }
  if(!issubstr(var_4, "BULLET")) {
    return;
  }
  var_7 = self.bullet_resistance;

  if(var_0 < self.bullet_resistance)
    var_7 = var_0;

  self.health = self.health + var_7;
}

spawn_think_game_skill_related() {
  maps\_gameskill::grenadeawareness();
}

ai_lasers() {
  if(!isalive(self)) {
    return;
  }
  if(self.health <= 1) {
    return;
  }
  self laseron();
  self waittill("death");

  if(!isdefined(self)) {
    return;
  }
  self laseroff();
}

spawn_think_script_inits() {
  if(isdefined(self.script_dontshootwhilemoving))
    self.dontshootwhilemoving = 1;

  if(isdefined(self.script_deathflag))
    thread ai_deathflag();

  if(isdefined(self.script_attackeraccuracy))
    self.attackeraccuracy = self.script_attackeraccuracy;

  if(isdefined(self.script_startrunning))
    thread start_off_running();

  if(isdefined(self.script_deathtime))
    thread deathtime();

  if(isdefined(self.script_nosurprise))
    maps\_utility::disable_surprise();

  if(isdefined(self.script_nobloodpool))
    self.skipbloodpool = 1;

  if(isdefined(self.script_laser))
    thread ai_lasers();

  if(isdefined(self.script_danger_react)) {
    var_0 = self.script_danger_react;

    if(var_0 == 1)
      var_0 = 8;

    maps\_utility::enable_danger_react(var_0);
  }

  if(isdefined(self.script_faceenemydist))
    self.maxfaceenemydist = self.script_faceenemydist;
  else
    self.maxfaceenemydist = getdefaultmaxfaceenemydistance();

  if(isdefined(self.script_forcecolor))
    maps\_utility::set_force_color(self.script_forcecolor);

  if(isdefined(self.dontdropweapon))
    self.dropweapon = 0;

  if(isdefined(self.script_fixednode))
    self.fixednode = self.script_fixednode == 1;
  else
    self.fixednode = self.team == "allies";

  self.providecoveringfire = self.team == "allies" && self.fixednode;

  if(isdefined(self.script_noteworthy) && self.script_noteworthy == "mgpair")
    thread maps\_mg_penetration::create_mg_team();

  if(isdefined(self.script_goalvolume) && !(isdefined(self.script_moveoverride) && self.script_moveoverride == 1 || isdefined(self.script_stealth)))
    thread set_goal_volume();

  if(isdefined(self.script_threatbiasgroup))
    self setthreatbiasgroup(self.script_threatbiasgroup);
  else if(self.team == "neutral")
    self setthreatbiasgroup("civilian");
  else
    self setthreatbiasgroup(self.team);

  if(isdefined(self.script_bcdialog))
    maps\_utility::set_battlechatter(self.script_bcdialog);

  if(isdefined(self.script_accuracy))
    self.baseaccuracy = self.script_accuracy;

  if(isdefined(self.script_ignoreme))
    self.ignoreme = 1;

  if(isdefined(self.script_ignore_suppression))
    self.ignoresuppression = 1;

  if(isdefined(self.script_ignoreall)) {
    self.ignoreall = 1;
    self clearenemy();
  }

  if(isdefined(self.script_sightrange))
    self.maxsightdistsqrd = self.script_sightrange;

  if(isdefined(self.script_favoriteenemy)) {
    if(self.script_favoriteenemy == "player") {
      self.favoriteenemy = level.player;
      level.player.targetname = "player";
    }
  }

  if(isdefined(self.script_fightdist))
    self.pathenemyfightdist = self.script_fightdist;

  if(isdefined(self.script_maxdist))
    self.pathenemylookahead = self.script_maxdist;

  if(isdefined(self.script_longdeath))
    self.a.disablelongdeath = 1;

  if(isdefined(self.script_diequietly))
    self.diequietly = 1;

  if(isdefined(self.script_flashbangs)) {
    self.grenadeweapon = "flash_grenade";
    self.grenadeammo = self.script_flashbangs;
  }

  if(isdefined(self.script_pacifist))
    self.pacifist = 1;

  if(isdefined(self.script_startinghealth))
    self.health = self.script_startinghealth;

  if(isdefined(self.script_nodrop))
    self.nodrop = self.script_nodrop;
}

spawn_think_action(var_0) {
  thread ai_damage_think();
  thread tanksquish();
  thread death_achievements();
  thread specops_think();

  if(!isdefined(level.ai_dont_glow_in_thermal))
    self thermaldrawenable();

  self.spawner_number = undefined;

  if(!isdefined(self.unique_id))
    maps\_utility::set_ai_number();

  if(!isdefined(self.deathfuncs))
    self.deathfuncs = [];

  thread deathfunctions();
  level thread maps\_friendlyfire::friendly_fire_think(self);
  self.walkdist = 16;
  init_reset_ai();
  spawn_think_game_skill_related();
  spawn_think_script_inits();
  [[level.team_specific_spawn_functions[self.team]]]();
  thread[[level.subclass_spawn_functions[self.subclass]]]();
  thread maps\_damagefeedback::monitordamage();
  set_goal_height_from_settings();

  if(isdefined(self.script_playerseek)) {
    self setgoalentity(level.player);
    return;
  }

  if(isdefined(self.script_stealth)) {
    if(isdefined(self.script_stealth_function)) {
      var_1 = level.stealth_default_func[self.script_stealth_function];
      self thread[[var_1]]();
    } else
      self thread[[level.global_callbacks["_spawner_stealth_default"]]]();
  }

  if(isdefined(self.script_idleanim)) {
    self thread[[level.global_callbacks["_idle_call_idle_func"]]]();
    return;
  }

  if(isdefined(self.script_idlereach) && !isdefined(self.script_moveoverride))
    self thread[[level.global_callbacks["_idle_call_idle_func"]]]();

  if(isdefined(self.script_patroller) && !isdefined(self.script_moveoverride)) {
    thread maps\_patrol::patrol();
    return;
  }

  if(isdefined(self.script_readystand) && self.script_readystand == 1)
    maps\_utility::enable_readystand();

  if(isdefined(self.script_delayed_playerseek)) {
    if(!isdefined(self.script_radius))
      self.goalradius = 800;

    self setgoalentity(level.player);
    level thread delayed_player_seek_think(self);
    return;
  }

  if(isdefined(self.used_an_mg42)) {
    return;
  }
  if(isdefined(self.script_moveoverride) && self.script_moveoverride == 1) {
    set_goal_from_settings();
    self setgoalpos(self.origin);
    return;
  }

  if(!isdefined(self.script_stealth)) {}

  set_goal_from_settings();

  if(isdefined(self.target))
    thread go_to_node();
}

init_reset_ai() {
  maps\_utility::set_default_pathenemy_settings();

  if(isdefined(self.script_grenades))
    self.grenadeammo = self.script_grenades;
  else
    self.grenadeammo = 3;

  if(isdefined(self.primaryweapon))
    self.noattackeraccuracymod = animscripts\combat_utility::issniper();

  if(!maps\_utility::is_specialop())
    self.neversprintforvariation = 1;
}

scrub_guy() {
  if(self.team == "neutral")
    self setthreatbiasgroup("civilian");
  else
    self setthreatbiasgroup(self.team);

  init_reset_ai();
  self.baseaccuracy = 1;
  maps\_gameskill::grenadeawareness();
  maps\_utility::clear_force_color();
  self.interval = 96;
  self.disablearrivals = undefined;
  self.ignoreme = 0;
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

  if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    maps\_utility::stop_magic_bullet_shield();

  maps\_utility::disable_replace_on_death();
  self.maxsightdistsqrd = 67108864;
  self.script_forcegrenade = 0;
  self.walkdist = 16;
  maps\_utility::unmake_hero();
  self.pushable = 1;
  self.script_pushable = 1;
  animscripts\init::set_anim_playback_rate();
  self.fixednode = self.team == "allies";
}

delayed_player_seek_think(var_0) {
  var_0 endon("death");

  while (isalive(var_0)) {
    if(var_0.goalradius > 200)
      var_0.goalradius = var_0.goalradius - 200;

    wait 6;
  }
}

flag_turret_for_use(var_0) {
  self endon("death");

  if(!self.flagged_for_use) {
    var_0.used_an_mg42 = 1;
    self.flagged_for_use = 1;
    var_0 waittill("death");
    self.flagged_for_use = 0;
    self notify("get new user");
  }
}

set_goal_volume() {
  self endon("death");
  waittillframeend;

  if(isdefined(self.team) && self.team == "allies")
    self.fixednode = 0;

  var_0 = level.goalvolumes[self.script_goalvolume];

  if(!isdefined(var_0)) {
    return;
  }
  if(isdefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");
    var_2 = getent(var_0.target, "targetname");
    var_3 = common_scripts\utility::getstruct(var_0.target, "targetname");
    var_4 = undefined;

    if(isdefined(var_1)) {
      var_4 = var_1;
      self setgoalnode(var_4);
    } else if(isdefined(var_2)) {
      var_4 = var_2;
      self setgoalpos(var_4.origin);
    } else if(isdefined(var_3)) {
      var_4 = var_3;
      self setgoalpos(var_4.origin);
    }

    if(isdefined(var_4.radius) && var_4.radius != 0)
      self.goalradius = var_4.radius;

    if(isdefined(var_4.goalheight) && var_4.goalheight != 0)
      self.goalheight = var_4.goalheight;
  }

  if(isdefined(self.target))
    self setgoalvolume(var_0);
  else
    self setgoalvolumeauto(var_0);
}

get_target_ents(var_0) {
  return getentarray(var_0, "targetname");
}

get_target_nodes(var_0) {
  return getnodearray(var_0, "targetname");
}

get_target_vehicle_nodes(var_0) {
  return getvehiclenodearray(var_0, "targetname");
}

get_target_structs(var_0) {
  return common_scripts\utility::getstructarray(var_0, "targetname");
}

node_has_radius(var_0) {
  return isdefined(var_0.radius) && var_0.radius != 0;
}

go_to_origin(var_0, var_1) {
  go_to_node(var_0, "origin", var_1);
}

go_to_struct(var_0, var_1) {
  go_to_node(var_0, "struct", var_1);
}

go_to_node(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(self.used_an_mg42)) {
    return;
  }
  var_5 = get_node_funcs_based_on_target(var_0, var_1);

  if(!isdefined(var_5)) {
    self notify("reached_path_end");
    return;
  }

  go_to_node_using_funcs(var_5["destination"], var_5["get_target_func"], var_5["set_goal_func_quits"], var_2, var_3, var_4);
}

get_least_used_from_array(var_0) {
  if(var_0.size == 1)
    return var_0[0];

  var_1 = var_0[0].targetname;

  if(!isdefined(level.go_to_node_arrays[var_1]))
    level.go_to_node_arrays[var_1] = var_0;

  var_0 = level.go_to_node_arrays[var_1];
  var_2 = var_0[0];
  var_3 = [];

  for (var_4 = 0; var_4 < var_0.size - 1; var_4++)
    var_3[var_4] = var_0[var_4 + 1];

  var_3[var_0.size - 1] = var_0[0];
  level.go_to_node_arrays[var_1] = var_3;
  return var_2;
}

go_to_node_using_funcs(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");

  for (;;) {
    var_0 = get_least_used_from_array(var_0);
    var_6 = var_4;

    if(isdefined(var_0.script_requires_player)) {
      if(var_0.script_requires_player > 1)
        var_6 = var_0.script_requires_player;

      var_0.script_requires_player = 0;
    }

    if(node_has_radius(var_0))
      self.goalradius = var_0.radius;
    else
      self.goalradius = level.default_goalradius;

    if(isdefined(var_0.height))
      self.goalheight = var_0.height;
    else
      self.goalheight = level.default_goalheight;

    [
      [var_2]
    ](var_0);

    if(maps\_utility::ent_flag_exist("_stealth_override_goalpos")) {
      for (;;) {
        self waittill("goal");

        if(!maps\_utility::ent_flag("_stealth_override_goalpos")) {
          break;
        }

        maps\_utility::ent_flag_waitopen("_stealth_override_goalpos");
      }
    } else
      self waittill("goal");

    var_0 notify("trigger", self);

    if(isdefined(var_3))
      [[var_3]](var_0);

    if(isdefined(var_0.script_flag_set))
      common_scripts\utility::flag_set(var_0.script_flag_set);

    if(isdefined(var_0.script_ent_flag_set))
      maps\_utility::ent_flag_set(var_0.script_ent_flag_set);

    if(isdefined(var_0.script_flag_clear))
      common_scripts\utility::flag_clear(var_0.script_flag_clear);

    if(isdefined(var_0.script_noteworthy))
      self notify(var_0.script_noteworthy);

    if(targets_and_uses_turret(var_0))
      return 1;

    var_0 maps\_utility::script_delay();

    if(isdefined(var_0.script_flag_wait))
      common_scripts\utility::flag_wait(var_0.script_flag_wait);

    var_0 maps\_utility::script_wait();

    if(isdefined(var_0.script_delay_post))
      wait(var_0.script_delay_post);

    while (isdefined(var_0.script_requires_player)) {
      var_0.script_requires_player = 0;

      if(go_to_node_wait_for_player(var_0, var_1, var_6)) {
        var_0.script_requires_player = 1;
        var_0 notify("script_requires_player");
        break;
      }

      wait 0.1;
    }

    if(isdefined(var_5))
      [[var_5]](var_0);

    if(!isdefined(var_0.target)) {
      break;
    }

    var_7 = [
      [var_1]
    ](var_0.target);

    if(!var_7.size) {
      break;
    }

    var_0 = var_7;
  }

  self notify("reached_path_end");

  if(isdefined(self.script_forcegoal)) {
    return;
  }
  self.goalradius = level.default_goalradius;
}

go_to_node_wait_for_player(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) < distancesquared(self.origin, var_0.origin))
      return 1;
  }

  var_6 = anglestoforward(self.angles);

  if(isdefined(var_0.target)) {
    var_7 = [
      [var_1]
    ](var_0.target);

    if(var_7.size == 1)
      var_6 = vectornormalize(var_7[0].origin - var_0.origin);
    else if(isdefined(var_0.angles))
      var_6 = anglestoforward(var_0.angles);
  } else if(isdefined(var_0.angles))
    var_6 = anglestoforward(var_0.angles);

  var_8 = [];

  foreach(var_4 in level.players)
  var_8[var_8.size] = vectornormalize(var_4.origin - self.origin);

  foreach(var_12 in var_8) {
    if(vectordot(var_6, var_12) > 0)
      return 1;
  }

  var_14 = var_2 * var_2;

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, self.origin) < var_14)
      return 1;
  }

  return 0;
}

go_to_node_set_goal_ent(var_0) {
  if(var_0.classname == "info_volume") {
    self setgoalvolumeauto(var_0);
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(var_0);
}

go_to_node_set_goal_pos(var_0) {
  maps\_utility::set_goal_ent(var_0);
  self notify("go_to_node_new_goal");
}

go_to_node_set_goal_node(var_0) {
  maps\_utility::set_goal_node(var_0);
  self notify("go_to_node_new_goal");
}

targets_and_uses_turret(var_0) {
  if(!isdefined(var_0.target))
    return 0;

  var_1 = getentarray(var_0.target, "targetname");

  if(!var_1.size)
    return 0;

  var_2 = var_1[0];

  if(var_2.classname != "misc_turret")
    return 0;

  thread use_a_turret(var_2);
  return 1;
}

remove_crawled(var_0) {
  waittillframeend;

  if(isdefined(var_0))
    var_0.crawled = undefined;
}

crawl_target_and_init_flags(var_0, var_1) {
  var_2 = 0;
  var_3 = [];
  var_4 = 0;

  for (;;) {
    if(!isdefined(var_0.crawled)) {
      var_0.crawled = 1;
      level thread remove_crawled(var_0);

      if(isdefined(var_0.script_flag_set)) {
        if(!isdefined(level.flag[var_0.script_flag_set]))
          common_scripts\utility::flag_init(var_0.script_flag_set);
      }

      if(isdefined(var_0.script_flag_wait)) {
        if(!isdefined(level.flag[var_0.script_flag_wait]))
          common_scripts\utility::flag_init(var_0.script_flag_wait);
      }

      if(isdefined(var_0.script_flag_clear)) {
        if(!isdefined(level.flag[var_0.script_flag_clear]))
          common_scripts\utility::flag_init(var_0.script_flag_clear);
      }

      if(isdefined(var_0.target)) {
        var_5 = [
          [var_1]
        ](var_0.target);
        var_3 = common_scripts\utility::add_to_array(var_3, var_5);
      }
    }

    var_4++;

    if(var_4 >= var_3.size) {
      break;
    }

    var_0 = var_3[var_4];
  }
}

get_node_funcs_based_on_target(var_0, var_1) {
  var_2["entity"] = ::get_target_ents;
  var_2["origin"] = ::get_target_ents;
  var_2["node"] = ::get_target_nodes;
  var_2["struct"] = ::get_target_structs;
  var_3["entity"] = ::go_to_node_set_goal_ent;
  var_3["origin"] = ::go_to_node_set_goal_ent;
  var_3["struct"] = ::go_to_node_set_goal_pos;
  var_3["node"] = ::go_to_node_set_goal_node;

  if(!isdefined(var_1))
    var_1 = "node";

  var_4 = [];

  if(isdefined(var_0))
    var_4["destination"][0] = var_0;
  else {
    var_0 = getentarray(self.target, "targetname");

    if(var_0.size > 0)
      var_1 = "entity";

    if(var_1 == "node") {
      var_0 = getnodearray(self.target, "targetname");

      if(!var_0.size) {
        var_0 = common_scripts\utility::getstructarray(self.target, "targetname");

        if(!var_0.size) {
          return;
        }
        var_1 = "struct";
      }
    }

    var_4["destination"] = var_0;
  }

  var_4["get_target_func"] = var_2[var_1];
  var_4["set_goal_func_quits"] = var_3[var_1];
  return var_4;
}

set_goal_height_from_settings() {
  if(isdefined(self.script_goalheight))
    self.goalheight = self.script_goalheight;
  else
    self.goalheight = level.default_goalheight;
}

set_goal_from_settings(var_0) {
  if(isdefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(isdefined(self.script_forcegoal)) {
    if(isdefined(var_0) && isdefined(var_0.radius)) {
      self.goalradius = var_0.radius;
      return;
    }
  }

  if(!isdefined(self getgoalvolume())) {
    if(self.type == "civilian")
      self.goalradius = 128;
    else
      self.goalradius = level.default_goalradius;
  }
}

autotarget(var_0) {
  for (;;) {
    var_1 = self getturretowner();

    if(!isalive(var_1)) {
      wait 1.5;
      continue;
    }

    if(!isdefined(var_1.enemy)) {
      self settargetentity(common_scripts\utility::random(var_0));
      self notify("startfiring");
      self startfiring();
    }

    wait(2 + randomfloat(1));
  }
}

manualtarget(var_0) {
  for (;;) {
    self settargetentity(common_scripts\utility::random(var_0));
    self notify("startfiring");
    self startfiring();
    wait(2 + randomfloat(1));
  }
}

use_a_turret(var_0) {
  if(self isbadguy() && self.health == 150) {
    self.health = 100;
    self.a.disablelongdeath = 1;
  }

  self useturret(var_0);

  if(isdefined(var_0.target) && var_0.target != var_0.targetname) {
    var_1 = getentarray(var_0.target, "targetname");
    var_2 = [];

    for (var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3].classname == "script_origin")
        var_2[var_2.size] = var_1[var_3];
    }

    if(isdefined(var_0.script_autotarget))
      var_0 thread autotarget(var_2);
    else if(isdefined(var_0.script_manualtarget)) {
      var_0 setmode("manual_ai");
      var_0 thread manualtarget(var_2);
    } else if(var_2.size > 0) {
      if(var_2.size == 1) {
        var_0.manual_target = var_2[0];
        var_0 settargetentity(var_2[0]);
        thread maps\_mgturret::manual_think(var_0);
      } else
        var_0 thread maps\_mgturret::mg42_suppressionfire(var_2);
    }
  }

  thread maps\_mgturret::mg42_firing(var_0);
  var_0 notify("startfiring");
}

fallback_spawner_think(var_0, var_1) {
  self endon("death");
  level.current_fallbackers[var_0] = level.current_fallbackers[var_0] + self.count;
  var_2 = 1;

  while (self.count > 0) {
    self waittill("spawned", var_3);

    if(var_2) {
      if(getdvar("fallback", "0") == "1") {

      }

      level notify("fallback_firstspawn" + var_0);
      var_2 = 0;
    }

    wait 0.05;

    if(maps\_utility::spawn_failed(var_3)) {
      level notify("fallbacker_died" + var_0);
      level.current_fallbackers[var_0]--;
      continue;
    }

    var_3 thread fallback_ai_think(var_0, var_1, "is spawner");
  }
}

fallback_ai_think_death(var_0, var_1) {
  var_0 waittill("death");
  level.current_fallbackers[var_1]--;
  level notify("fallbacker_died" + var_1);
}

fallback_ai_think(var_0, var_1, var_2) {
  if(!isdefined(self.fallback) || !isdefined(self.fallback[var_0]))
    self.fallback[var_0] = 1;
  else
    return;

  self.script_fallback = var_0;

  if(!isdefined(var_2))
    level.current_fallbackers[var_0]++;

  if(isdefined(var_1) && level.fallback_initiated[var_0])
    thread fallback_ai(var_0, var_1);

  level thread fallback_ai_think_death(self, var_0);
}

fallback_death(var_0, var_1) {
  var_0 waittill("death");
  level notify("fallback_reached_goal" + var_1);
}

fallback_goal() {
  self waittill("goal");
  self.ignoresuppression = 0;
  self notify("fallback_notify");
  self notify("stop_coverprint");
}

fallback_ai(var_0, var_1) {
  self notify("stop_going_to_node");
  self stopuseturret();
  self.ignoresuppression = 1;
  self setgoalnode(var_1);

  if(node_has_radius(var_1))
    self.goalradius = var_1.radius;

  self endon("death");
  level thread fallback_death(self, var_0);
  thread fallback_goal();

  if(getdvar("fallback", "0") == "1")
    thread coverprint(var_1.origin);

  self waittill("fallback_notify");
  level notify("fallback_reached_goal" + var_0);
}

coverprint(var_0) {
  self endon("fallback_notify");
  self endon("stop_coverprint");

  for (;;)
    wait 0.05;
}

newfallback_overmind(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in getallnodes()) {
    if(isdefined(var_4.script_fallback) && var_4.script_fallback == var_0)
      var_2 = common_scripts\utility::add_to_array(var_2, var_4);
  }

  if(!isdefined(var_2)) {
    return;
  }
  level.current_fallbackers[var_0] = 0;
  level.spawner_fallbackers[var_0] = 0;
  level.fallback_initiated[var_0] = 0;
  var_6 = getspawnerarray();

  for (var_7 = 0; var_7 < var_6.size; var_7++) {
    if(isdefined(var_6[var_7].script_fallback) && var_6[var_7].script_fallback == var_0) {
      if(var_6[var_7].count > 0) {
        var_6[var_7] thread fallback_spawner_think(var_0, var_2[randomint(var_2.size)]);
        level.spawner_fallbackers[var_0]++;
      }
    }
  }

  var_8 = getaiarray();

  for (var_7 = 0; var_7 < var_8.size; var_7++) {
    if(isdefined(var_8[var_7].script_fallback) && var_8[var_7].script_fallback == var_0)
      var_8[var_7] thread fallback_ai_think(var_0);
  }

  if(!level.current_fallbackers[var_0] && !level.spawner_fallbackers[var_0]) {
    return;
  }
  var_6 = undefined;
  var_8 = undefined;
  thread fallback_wait(var_0, var_1);
  level waittill("fallbacker_trigger" + var_0);

  if(getdvar("fallback", "0") == "1") {}

  level.fallback_initiated[var_0] = 1;
  var_9 = undefined;
  var_8 = getaiarray();

  for (var_7 = 0; var_7 < var_8.size; var_7++) {
    if(isdefined(var_8[var_7].script_fallback) && var_8[var_7].script_fallback == var_0 || isdefined(var_8[var_7].script_fallback_group) && isdefined(var_1) && var_8[var_7].script_fallback_group == var_1)
      var_9 = common_scripts\utility::add_to_array(var_9, var_8[var_7]);
  }

  var_8 = undefined;

  if(!isdefined(var_9)) {
    return;
  }
  var_10 = var_9.size * 0.4;
  var_10 = int(var_10);
  level notify("fallback initiated " + var_0);

  for (var_7 = 0; var_7 < var_10; var_7++)
    var_9[var_7] thread fallback_ai(var_0, var_2[randomint(var_2.size)]);

  for (var_7 = 0; var_7 < var_10; var_7++)
    level waittill("fallback_reached_goal" + var_0);

  for (var_7 = var_10; var_7 < var_9.size; var_7++) {
    if(isalive(var_9[var_7]))
      var_9[var_7] thread fallback_ai(var_0, var_2[randomint(var_2.size)]);
  }
}

fallback_wait(var_0, var_1) {
  level endon("fallbacker_trigger" + var_0);

  if(getdvar("fallback", "0") == "1") {}

  for (var_2 = 0; var_2 < level.spawner_fallbackers[var_0]; var_2++) {
    if(getdvar("fallback", "0") == "1") {

    }

    level waittill("fallback_firstspawn" + var_0);
  }

  if(getdvar("fallback", "0") == "1") {}

  var_3 = getaiarray();

  for (var_2 = 0; var_2 < var_3.size; var_2++) {
    if(isdefined(var_3[var_2].script_fallback) && var_3[var_2].script_fallback == var_0 || isdefined(var_3[var_2].script_fallback_group) && isdefined(var_1) && var_3[var_2].script_fallback_group == var_1)
      var_3[var_2] thread fallback_ai_think(var_0);
  }

  var_3 = undefined;
  var_4 = level.current_fallbackers[var_0];

  for (var_5 = 0; level.current_fallbackers[var_0] > var_4 * 0.5; var_5++) {
    if(getdvar("fallback", "0") == "1") {

    }

    level waittill("fallbacker_died" + var_0);
  }

  level notify("fallbacker_trigger" + var_0);
}

fallback_think(var_0) {
  if(!isdefined(level.fallback) || !isdefined(level.fallback[var_0.script_fallback]))
    level thread newfallback_overmind(var_0.script_fallback, var_0.script_fallback_group);

  var_0 waittill("trigger");
  level notify("fallbacker_trigger" + var_0.script_fallback);
  kill_trigger(var_0);
}

arrive(var_0) {
  self waittill("goal");

  if(node_has_radius(var_0))
    self.goalradius = var_0.radius;
  else
    self.goalradius = level.default_goalradius;
}

fallback_coverprint() {
  self endon("fallback");
  self endon("fallback_clear_goal");
  self endon("fallback_clear_death");

  for (;;) {
    if(isdefined(self.coverpoint)) {

    }

    wait 0.05;
  }
}

fallback_print() {
  self endon("fallback_clear_goal");
  self endon("fallback_clear_death");

  for (;;) {
    if(isdefined(self.coverpoint)) {

    }

    wait 0.05;
  }
}

fallback() {
  var_0 = getnode(self.target, "targetname");
  self.coverpoint = var_0;
  self setgoalnode(var_0);

  if(isdefined(self.script_seekgoal))
    thread arrive(var_0);
  else if(node_has_radius(var_0))
    self.goalradius = var_0.radius;
  else
    self.goalradius = level.default_goalradius;

  for (;;) {
    self waittill("fallback");
    self.interval = 20;
    level thread fallback_death(self);

    if(getdvar("fallback", "0") == "1")
      thread fallback_print();

    if(isdefined(var_0.target)) {
      var_0 = getnode(var_0.target, "targetname");
      self.coverpoint = var_0;
      self setgoalnode(var_0);
      thread fallback_goal();

      if(node_has_radius(var_0))
        self.goalradius = var_0.radius;

      continue;
    }

    level notify("fallback_arrived" + self.script_fallback);
    return;
  }
}

delete_me() {
  wait 0.05;
  self delete();
}

vlength(var_0, var_1) {
  var_2 = var_0[0] - var_1[0];
  var_3 = var_0[1] - var_1[1];
  var_4 = var_0[2] - var_1[2];
  var_2 = var_2 * var_2;
  var_3 = var_3 * var_3;
  var_4 = var_4 * var_4;
  var_5 = var_2 + var_3 + var_4;
  return var_5;
}

specialcheck(var_0) {
  for (;;)
    wait 0.05;
}

friendly_wave(var_0) {
  if(!isdefined(level.friendly_wave_active))
    thread friendly_wave_masterthread();

  for (;;) {
    var_0 waittill("trigger");
    level notify("friendly_died");

    if(var_0.targetname == "friendly_wave")
      level.friendly_wave_trigger = var_0;
    else
      level.friendly_wave_trigger = undefined;

    wait 1;
  }
}

set_spawncount(var_0) {
  if(!isdefined(self.target)) {
    return;
  }
  var_1 = getentarray(self.target, "targetname");

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2] maps\_utility::set_count(var_0);
}

friendlydeath_thread() {
  if(!isdefined(level.totalfriends))
    level.totalfriends = 0;

  level.totalfriends++;
  self waittill("death");
  level notify("friendly_died");
  level.totalfriends--;
}

friendly_wave_masterthread() {
  level.friendly_wave_active = 1;
  var_0 = getentarray("friendly_wave", "targetname");
  common_scripts\utility::array_thread(var_0, ::set_spawncount, 0);

  if(!isdefined(level.maxfriendlies))
    level.maxfriendlies = 7;

  var_1 = 1;

  for (;;) {
    if(isdefined(level.friendly_wave_trigger) && isdefined(level.friendly_wave_trigger.target)) {
      var_2 = level.friendly_wave_trigger;
      var_3 = getentarray(level.friendly_wave_trigger.target, "targetname");

      if(!var_3.size) {
        level waittill("friendly_died");
        continue;
      }

      var_4 = 0;
      var_5 = isdefined(level.friendly_wave_trigger.script_delay);

      while (isdefined(level.friendly_wave_trigger) && level.totalfriends < level.maxfriendlies) {
        if(var_2 != level.friendly_wave_trigger) {
          var_5 = isdefined(level.friendly_wave_trigger.script_delay);
          var_2 = level.friendly_wave_trigger;
          var_3 = getentarray(level.friendly_wave_trigger.target, "targetname");
        } else if(!var_5)
          var_4 = randomint(var_3.size);
        else if(var_4 == var_3.size)
          var_4 = 0;

        var_3[var_4] maps\_utility::set_count(1);
        var_6 = isdefined(var_3[var_4].script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

        if(isdefined(var_3[var_4].script_forcespawn))
          var_7 = var_3[var_4] stalingradspawn(var_6);
        else
          var_7 = var_3[var_4] dospawn(var_6);

        var_3[var_4] maps\_utility::set_count(0);

        if(maps\_utility::spawn_failed(var_7)) {
          wait 0.2;
          continue;
        }

        if(isdefined(var_3[var_4].script_combatbehavior)) {
          if(var_3[var_4].combatbehavior == "heat")
            var_7 maps\_utility::enable_heat_behavior();

          if(var_3[var_4].combatbehavior == "cqb")
            var_7 maps\_utility::enable_cqbwalk();
        }

        if(isdefined(level.friendlywave_thread))
          level thread[[level.friendlywave_thread]](var_7);
        else
          var_7 setgoalentity(level.player);

        if(var_5) {
          if(level.friendly_wave_trigger.script_delay == 0)
            waittillframeend;
          else
            wait(level.friendly_wave_trigger.script_delay);

          var_4++;
          continue;
        }

        wait(randomfloat(5));
      }
    }

    level waittill("friendly_died");
  }
}

friendly_mgturret(var_0) {
  var_1 = getnode(var_0.target, "targetname");
  var_2 = getent(var_1.target, "targetname");
  var_2 setmode("auto_ai");
  var_2 cleartargetentity();
  var_3 = 0;

  for (;;) {
    var_0 waittill("trigger", var_4);

    if(!isai(var_4)) {
      continue;
    }
    if(!isdefined(var_4.team)) {
      continue;
    }
    if(var_4.team != "allies") {
      continue;
    }
    if(isdefined(var_4.script_usemg42) && var_4.script_usemg42 == 0) {
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
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"PLATFORM_USEAIONMG42");
  self waittill("trigger");
  self.useable = 0;
  self sethintstring("");
  self stopuseturret();
  self notify("stopped_use_turret");
  var_0 notify("friendly_finished_using_mg42");
}

friendly_mg42_useable(var_0, var_1) {
  if(self.useable)
    return 0;

  if(isdefined(self.turret_use_time) && gettime() < self.turret_use_time)
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

friendly_mg42_stop_use() {
  if(!isdefined(self.friendly_mg42)) {
    return;
  }
  self.friendly_mg42 notify("friendly_finished_using_mg42");
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

  if(isdefined(var_0.target)) {
    var_2 = getent(var_0.target, "targetname");

    if(isdefined(var_2))
      var_2 thread friendly_mg42_endtrigger(var_0, self);
  }

  for (;;) {
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

  if(!isdefined(var_0)) {
    return;
  }
  if(!isdefined(var_0.target)) {
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

  if(isdefined(self.target)) {
    var_1 = getnode(self.target, "targetname");

    if(isdefined(var_1.target))
      var_1 = getnode(var_1.target, "targetname");

    if(isdefined(var_1))
      self setgoalnode(var_1);
  }

  self.goalradius = var_2;
}

tanksquish() {
  if(isdefined(level.notanksquish)) {
    return;
  }
  if(isdefined(level.levelhasvehicles) && !level.levelhasvehicles) {
    return;
  }
  maps\_utility::add_damage_function(::tanksquish_damage_check);
}

tanksquish_damage_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(self)) {
    return;
  }
  if(isalive(self)) {
    return;
  }
  if(!isalive(var_1)) {
    return;
  }
  if(!isdefined(var_1.vehicletype)) {
    return;
  }
  if(var_1 maps\_vehicle::ishelicopter()) {
    return;
  }
  if(!isdefined(self.noragdoll))
    self startragdoll();

  if(!isdefined(self)) {
    return;
  }
  maps\_utility::remove_damage_function(::tanksquish_damage_check);
}

panzer_target(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0.panzer_node = var_1;

  if(isdefined(var_1.script_delay))
    var_0.panzer_delay = var_1.script_delay;

  if(isdefined(var_3) && isdefined(var_4)) {
    var_0.panzer_ent = var_3;
    var_0.panzer_ent_offset = var_4;
  } else
    var_0.panzer_pos = var_2;

  var_0 setgoalpos(var_0.origin);
  var_0 setgoalnode(var_1);
  var_0.goalradius = 12;
  var_0 waittill("goal");
  var_0.goalradius = 28;
  var_0 waittill("shot_at_target");
  var_0.panzer_ent = undefined;
  var_0.panzer_pos = undefined;
  var_0.panzer_delay = undefined;
}

showstart(var_0, var_1, var_2) {
  var_3 = getstartorigin(var_0, var_1, var_2);

  for (;;)
    wait 0.05;
}

spawnwaypointfriendlies() {
  maps\_utility::set_count(1);

  if(isdefined(self.script_forcespawn))
    var_0 = self stalingradspawn();
  else
    var_0 = self dospawn();

  if(maps\_utility::spawn_failed(var_0)) {
    return;
  }
  if(isdefined(self.script_combatbehavior)) {
    if(self.script_combatbehavior == "heat")
      var_0 maps\_utility::enable_heat_behavior();

    if(self.script_combatbehavior == "cqb")
      var_0 maps\_utility::enable_cqbwalk();
  }

  var_0.friendlywaypoint = 1;
}

waittilldeathorleavesquad() {
  self endon("death");
  self waittill("leaveSquad");
}

friendlyspawnwave() {
  common_scripts\utility::array_thread(getentarray(self.target, "targetname"), ::friendlyspawnwave_triggerthink, self);

  for (;;) {
    self waittill("trigger", var_2);

    if(activefriendlyspawn() && getfriendlyspawntrigger() == self)
      unsetfriendlyspawn();

    self waittill("friendly_wave_start", var_3);
    setfriendlyspawn(var_3, self);

    if(!isdefined(var_3.target)) {
      continue;
    }
    var_4 = getent(var_3.target, "targetname");
    var_4 thread spawnwavestoptrigger(self);
  }
}

flood_and_secure(var_0) {
  if(!isdefined(var_0))
    var_0 = 0;

  if(isdefined(self.script_noteworthy) && self.script_noteworthy == "instant_respawn")
    var_0 = 1;

  level.spawnerwave = [];
  var_1 = getentarray(self.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::flood_and_secure_spawner, var_0);
  var_2 = 0;
  var_3 = 0;

  for (;;) {
    self waittill("trigger", var_4);

    if(!objectiveisallowed()) {
      continue;
    }
    if(!var_3) {
      var_3 = 1;
      maps\_utility::script_delay();
    }

    if(self istouching(level.player))
      var_2 = 1;
    else {
      if(!isalive(var_4)) {
        continue;
      }
      if(isplayer(var_4))
        var_2 = 1;
      else if(!isdefined(var_4.issquad) || !var_4.issquad)
        continue;
    }

    var_1 = getentarray(self.target, "targetname");

    if(isdefined(var_1[0])) {
      if(isdefined(var_1[0].script_randomspawn))
        cull_spawners_from_killspawner(var_1[0].script_randomspawn);
    }

    var_1 = getentarray(self.target, "targetname");

    for (var_5 = 0; var_5 < var_1.size; var_5++) {
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

cull_spawners_leaving_one_set(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_0[var_2].script_randomspawn] = 1;

  var_3 = getarraykeys(var_1);
  var_4 = common_scripts\utility::random(var_3);

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2].script_randomspawn != var_4)
      var_0[var_2] delete();
  }
}

flood_and_secure_spawner(var_0) {
  if(isdefined(self.securestarted)) {
    return;
  }
  self.securestarted = 1;
  self.triggerunlocked = 1;
  var_1 = self.target;
  var_2 = self.targetname;

  if(!isdefined(var_1) && !isdefined(self.script_moveoverride))
    waittillframeend;

  var_3 = [];

  if(isdefined(var_1)) {
    var_4 = getentarray(var_1, "targetname");

    for (var_5 = 0; var_5 < var_4.size; var_5++) {
      if(!issubstr(var_4[var_5].classname, "actor")) {
        continue;
      }
      var_3[var_3.size] = var_4[var_5];
    }
  }

  var_6 = spawnstruct();
  var_7 = self.origin;
  flood_and_secure_spawner_think(var_6, var_3.size > 0, var_0);

  if(isalive(var_6.ai))
    var_6.ai waittill("death");

  if(!isdefined(var_1)) {
    return;
  }
  var_4 = getentarray(var_1, "targetname");

  if(!var_4.size) {
    return;
  }
  for (var_5 = 0; var_5 < var_4.size; var_5++) {
    if(!issubstr(var_4[var_5].classname, "actor")) {
      continue;
    }
    var_4[var_5].targetname = var_2;
    var_8 = var_1;

    if(isdefined(var_4[var_5].target)) {
      var_9 = getent(var_4[var_5].target, "targetname");

      if(!isdefined(var_9) || !issubstr(var_9.classname, "actor"))
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
    var_1 = isdefined(self.script_noteworthy) && self.script_noteworthy == "delete";

  maps\_utility::set_count(2);

  if(isdefined(self.script_delay))
    var_4 = self.script_delay;
  else
    var_4 = 0;

  for (;;) {
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

  while (var_3) {
    self.truecount = var_3;
    maps\_utility::set_count(2);
    wait(var_4);
    var_6 = isdefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

    if(isdefined(self.script_forcespawn))
      var_7 = self stalingradspawn(var_6);
    else
      var_7 = self dospawn(var_6);

    if(maps\_utility::spawn_failed(var_7)) {
      var_8 = 0;

      if(var_4 < 2)
        wait 2;

      continue;
    } else {
      if(isdefined(self.script_combatbehavior)) {
        if(self.script_combatbehavior == "heat")
          var_7 maps\_utility::enable_heat_behavior();

        if(self.script_combatbehavior == "cqb")
          var_7 maps\_utility::enable_cqbwalk();
      }

      thread addtowavespawner(var_7);
      var_7 thread flood_and_secure_spawn(self);

      if(isdefined(self.script_accuracy))
        var_7.baseaccuracy = self.script_accuracy;

      var_0.ai = var_7;
      var_0 notify("got_ai");
      self waittill("spawn_died", var_9, var_8);

      if(var_4 > 2)
        var_4 = randomint(4) + 2;
      else
        var_4 = 0.5 + randomfloat(0.5);
    }

    if(var_9) {
      waittillrestartordistance(var_5);
      continue;
    }

    if(playerwasnearby(var_8 || var_1, var_0.ai))
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

  if(!isdefined(level.spawnerwave[var_1])) {
    level.spawnerwave[var_1] = spawnstruct();
    level.spawnerwave[var_1] maps\_utility::set_count(0);
    level.spawnerwave[var_1].total = 0;
  }

  if(!isdefined(self.addedtowave)) {
    self.addedtowave = 1;
    level.spawnerwave[var_1].total++;
  }

  level.spawnerwave[var_1].count++;
  waittilldeletedordeath(var_0);
  level.spawnerwave[var_1].count--;

  if(!isdefined(self))
    level.spawnerwave[var_1].total--;

  if(level.spawnerwave[var_1].total) {
    if(level.spawnerwave[var_1].count / level.spawnerwave[var_1].total < 0.32)
      level.spawnerwave[var_1] notify("waveReady");
  }
}

debugwavecount(var_0) {
  self endon("debug_stop");
  self endon("death");

  for (;;)
    wait 0.05;
}

waituntilwaverelease() {
  var_0 = self.targetname;

  if(level.spawnerwave[var_0].count)
    level.spawnerwave[var_0] waittill("waveReady");
}

playerwasnearby(var_0, var_1) {
  if(var_0)
    return 1;

  if(isdefined(var_1) && isdefined(var_1.origin))
    var_2 = var_1.origin;
  else
    var_2 = self.origin;

  if(distance(level.player.origin, var_2) < 700)
    return 1;

  return bullettracepassed(level.player geteye(), var_1 geteye(), 0, undefined);
}

waittillrestartordistance(var_0) {
  self endon("flood_begin");
  var_0 = var_0 * 0.75;

  while (distance(level.player.origin, self.origin) > var_0)
    wait 1;
}

flood_and_secure_spawn(var_0) {
  thread flood_and_secure_spawn_goal();
  self waittill("death", var_1);
  var_2 = isalive(var_1) && isplayer(var_1);

  if(!var_2 && isdefined(var_1) && var_1.classname == "worldspawn")
    var_2 = 1;

  var_3 = !isdefined(self);
  var_0 notify("spawn_died", var_3, var_2);
}

flood_and_secure_spawn_goal() {
  if(isdefined(self.script_moveoverride)) {
    return;
  }
  self endon("death");
  var_0 = getnode(self.target, "targetname");

  if(isdefined(var_0))
    self setgoalnode(var_0);
  else {
    var_0 = getent(self.target, "targetname");

    if(isdefined(var_0))
      self setgoalpos(var_0.origin);
  }

  if(isdefined(level.fightdist)) {
    self.pathenemyfightdist = level.fightdist;
    self.pathenemylookahead = level.maxdist;
  }

  if(isdefined(var_0.radius) && var_0.radius >= 0)
    self.goalradius = var_0.radius;
  else
    self.goalradius = 256;

  self waittill("goal");

  while (isdefined(var_0.target)) {
    var_1 = getnode(var_0.target, "targetname");

    if(isdefined(var_1))
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

  if(isdefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "delete") {
      self kill();
      return;
    }
  }

  if(isdefined(var_0.target)) {
    var_2 = getent(var_0.target, "targetname");

    if(isdefined(var_2) && (var_2.code_classname == "misc_mgturret" || var_2.code_classname == "misc_turret")) {
      self setgoalnode(var_0);
      self.goalradius = 4;
      self waittill("goal");

      if(!isdefined(self.script_forcegoal))
        self.goalradius = level.default_goalradius;

      use_a_turret(var_2);
    }
  }

  if(isdefined(self.script_noteworthy)) {
    if(isdefined(self.script_noteworthy2)) {
      if(self.script_noteworthy2 == "furniture_push")
        thread furniturepushsound();
    }

    if(self.script_noteworthy == "hide") {
      thread maps\_utility::set_battlechatter(0);
      return;
    }
  }

  if(!isdefined(self.script_forcegoal) && !isdefined(self getgoalvolume()))
    self.goalradius = level.default_goalradius;
}

furniturepushsound() {
  var_0 = getent(self.target, "targetname").origin;
  common_scripts\utility::play_sound_in_space("furniture_slide", var_0);
  wait 0.9;

  if(isdefined(level.whisper))
    common_scripts\utility::play_sound_in_space(common_scripts\utility::random(level.whisper), var_0);
}

friendlychain() {
  waittillframeend;
  var_0 = getentarray(self.target, "targetname");

  if(!var_0.size) {
    var_1 = getnode(self.target, "targetname");

    for (;;) {
      self waittill("trigger");

      if(isdefined(level.lastfriendlytrigger) && level.lastfriendlytrigger == self) {
        wait 0.5;
        continue;
      }

      if(!objectiveisallowed()) {
        wait 0.5;
        continue;
      }

      level notify("new_friendly_trigger");
      level.lastfriendlytrigger = self;
      var_2 = !isdefined(self.script_baseoffire) || self.script_baseoffire == 0;
      setnewplayerchain(var_1, var_2);
    }
  }

  for (;;) {
    self waittill("trigger");

    while (level.player istouching(self))
      wait 0.05;

    if(!objectiveisallowed()) {
      wait 0.05;
      continue;
    }

    if(isdefined(level.lastfriendlytrigger) && level.lastfriendlytrigger == self) {
      continue;
    }
    level notify("new_friendly_trigger");
    level.lastfriendlytrigger = self;
    common_scripts\utility::array_thread(var_0, ::friendlytrigger);
    wait 0.5;
  }
}

objectiveisallowed() {
  var_0 = 1;

  if(isdefined(self.script_objective_active)) {
    var_0 = 0;

    for (var_1 = 0; var_1 < level.active_objective.size; var_1++) {
      if(!issubstr(self.script_objective_active, level.active_objective[var_1])) {
        continue;
      }
      var_0 = 1;
      break;
    }

    if(!var_0)
      return 0;
  }

  if(!isdefined(self.script_objective_inactive))
    return var_0;

  var_2 = 0;

  for (var_1 = 0; var_1 < level.inactive_objective.size; var_1++) {
    if(!issubstr(self.script_objective_inactive, level.inactive_objective[var_1])) {
      continue;
    }
    var_2++;
  }

  var_3 = strtok(self.script_objective_inactive, " ");
  return var_2 == var_3.size;
}

friendlytrigger(var_0) {
  level endon("new_friendly_trigger");
  self waittill("trigger");
  var_0 = getnode(self.target, "targetname");
  var_1 = !isdefined(self.script_baseoffire) || self.script_baseoffire == 0;
  setnewplayerchain(var_0, var_1);
}

waittilldeathorempty() {
  self endon("death");
  var_0 = self.script_deathchain;

  while (self.count) {
    self waittill("spawned", var_1);
    var_1 thread deathchainainotify(var_0);
  }
}

deathchainainotify(var_0) {
  level.deathspawner[var_0]++;
  self waittill("death");
  level.deathspawner[var_0]--;
  level notify("spawner_expired" + var_0);
}

deathchainspawnerlogic() {
  var_0 = self.script_deathchain;
  level.deathspawner[var_0]++;
  var_1 = self.origin;
  waittilldeathorempty();
  level notify("spawner dot" + var_1);
  level.deathspawner[var_0]--;
  level notify("spawner_expired" + var_0);
}

friendlychain_ondeath() {
  var_0 = getentarray("friendly_chain_on_death", "targetname");
  var_1 = getspawnerarray();
  level.deathspawner = [];

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isdefined(var_1[var_2].script_deathchain)) {
      continue;
    }
    var_3 = var_1[var_2].script_deathchain;

    if(!isdefined(level.deathspawner[var_3]))
      level.deathspawner[var_3] = 0;

    var_1[var_2] thread deathchainspawnerlogic();
  }

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isdefined(var_0[var_2].script_deathchain)) {
      return;
    }
    var_0[var_2] thread friendlychain_ondeaththink();
  }
}

friendlychain_ondeaththink() {
  while (level.deathspawner[self.script_deathchain] > 0)
    level waittill("spawner_expired" + self.script_deathchain);

  level endon("start_chain");
  var_0 = getnode(self.target, "targetname");

  for (;;) {
    self waittill("trigger");
    setnewplayerchain(var_0, 1);
    iprintlnbold("Area secured, move up!");
    wait 5;
  }
}

setnewplayerchain(var_0, var_1) {
  level notify("new_escort_trigger");
  level notify("new_escort_debug");
  level notify("start_chain", var_1);
}

friendlychains() {
  level.friendlyspawnorg = [];
  level.friendlyspawntrigger = [];
  common_scripts\utility::array_thread(getentarray("friendlychain", "targetname"), ::friendlychain);
}

unsetfriendlyspawn() {
  var_0 = [];
  var_1 = [];

  for (var_2 = 0; var_2 < level.friendlyspawnorg.size; var_2++) {
    var_0[var_0.size] = level.friendlyspawnorg[var_2];
    var_1[var_1.size] = level.friendlyspawntrigger[var_2];
  }

  level.friendlyspawnorg = var_0;
  level.friendlyspawntrigger = var_1;

  if(activefriendlyspawn()) {
    return;
  }
  common_scripts\utility::flag_clear("spawning_friendlies");
}

getfriendlyspawnstart() {
  return level.friendlyspawnorg[level.friendlyspawnorg.size - 1];
}

activefriendlyspawn() {
  return level.friendlyspawnorg.size > 0;
}

getfriendlyspawntrigger() {
  return level.friendlyspawntrigger[level.friendlyspawntrigger.size - 1];
}

setfriendlyspawn(var_0, var_1) {
  level.friendlyspawnorg[level.friendlyspawnorg.size] = var_0.origin;
  level.friendlyspawntrigger[level.friendlyspawntrigger.size] = var_1;
  common_scripts\utility::flag_set("spawning_friendlies");
}

delayedplayergoal() {
  self endon("death");
  self endon("leaveSquad");
  wait 0.5;
  self setgoalentity(level.player);
}

spawnwavestoptrigger(var_0) {
  self notify("stopTrigger");
  self endon("stopTrigger");
  self waittill("trigger");

  if(getfriendlyspawntrigger() != var_0) {
    return;
  }
  unsetfriendlyspawn();
}

friendlyspawnwave_triggerthink(var_0) {
  var_1 = getent(self.target, "targetname");

  for (;;) {
    self waittill("trigger");
    var_0 notify("friendly_wave_start", var_1);

    if(!isdefined(var_1.target))
      continue;
  }
}

goalvolumes() {
  var_0 = getentarray("info_volume", "classname");
  level.deathchain_goalvolume = [];
  level.goalvolumes = [];

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isdefined(var_2.script_deathchain))
      level.deathchain_goalvolume[var_2.script_deathchain] = var_2;

    if(isdefined(var_2.script_goalvolume))
      level.goalvolumes[var_2.script_goalvolume] = var_2;
  }
}

debugprint(var_0, var_1, var_2) {
  if(1) {
    return;
  }
  var_3 = self getorigin();
  var_4 = 40 * sin(var_3[0] + var_3[1]) - 40;
  var_3 = (var_3[0], var_3[1], var_3[2] + var_4);
  level endon(var_1);
  self endon("new_color");

  if(!isdefined(var_2))
    var_2 = (0, 0.8, 0.6);

  var_5 = 0;

  for (;;) {
    var_5 = var_5 + 12;
    var_6 = sin(var_5) * 0.4;

    if(var_6 < 0)
      var_6 = var_6 * -1;

    var_6 = var_6 + 1;
    wait 0.05;
  }
}

aigroup_create(var_0) {
  level._ai_group[var_0] = spawnstruct();
  level._ai_group[var_0].aicount = 0;
  level._ai_group[var_0].spawnercount = 0;
  level._ai_group[var_0].ai = [];
  level._ai_group[var_0].spawners = [];
}

aigroup_spawnerthink(var_0) {
  self endon("death");
  self.decremented = 0;
  var_0.spawnercount++;
  thread aigroup_spawnerdeath(var_0);
  thread aigroup_spawnerempty(var_0);

  while (self.count) {
    self waittill("spawned", var_1);

    if(maps\_utility::spawn_failed(var_1)) {
      continue;
    }
    var_1 thread aigroup_soldierthink(var_0);
  }

  waittillframeend;

  if(self.decremented) {
    return;
  }
  self.decremented = 1;
  var_0.spawnercount--;
}

aigroup_spawnerdeath(var_0) {
  self waittill("death");

  if(self.decremented) {
    return;
  }
  var_0.spawnercount--;
}

aigroup_spawnerempty(var_0) {
  self endon("death");
  self waittill("emptied spawner");
  waittillframeend;

  if(self.decremented) {
    return;
  }
  self.decremented = 1;
  var_0.spawnercount--;
}

aigroup_soldierthink(var_0) {
  var_0.aicount++;
  var_0.ai[var_0.ai.size] = self;

  if(isdefined(self.script_deathflag_longdeath))
    waittilldeathorpaindeath();
  else
    self waittill("death");

  var_0.aicount--;
}

camper_trigger_think(var_0) {
  var_1 = strtok(var_0.script_linkto, " ");
  var_2 = [];
  var_3 = [];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];
    var_6 = getent(var_5, "script_linkname");

    if(isdefined(var_6)) {
      var_2 = common_scripts\utility::add_to_array(var_2, var_6);
      continue;
    }

    var_7 = getnode(var_5, "script_linkname");

    if(!isdefined(var_7)) {
      continue;
    }
    var_3 = common_scripts\utility::add_to_array(var_3, var_7);
  }

  var_0 waittill("trigger");
  var_3 = common_scripts\utility::array_randomize(var_3);

  for (var_4 = 0; var_4 < var_3.size; var_4++)
    var_3[var_4].claimed = 0;

  var_8 = 0;

  for (var_4 = 0; var_4 < var_2.size; var_4++) {
    var_9 = var_2[var_4];

    if(!isdefined(var_9)) {
      continue;
    }
    if(isdefined(var_9.script_spawn_here)) {
      continue;
    }
    while (isdefined(var_3[var_8].script_noteworthy) && var_3[var_8].script_noteworthy == "dont_spawn")
      var_8++;

    var_9.origin = var_3[var_8].origin;
    var_9.angles = var_3[var_8].angles;
    var_9 maps\_utility::add_spawn_function(::claim_a_node, var_3[var_8]);
    var_8++;
  }

  common_scripts\utility::array_thread(var_2, maps\_utility::add_spawn_function, ::camper_guy);
  common_scripts\utility::array_thread(var_2, maps\_utility::add_spawn_function, ::move_when_enemy_hides, var_3);
  common_scripts\utility::array_thread(var_2, maps\_utility::spawn_ai);
}

camper_guy() {
  self.goalradius = 8;
  self.fixednode = 1;
}

move_when_enemy_hides(var_0) {
  self endon("death");
  var_1 = 0;

  for (;;) {
    if(!isalive(self.enemy)) {
      self waittill("enemy");
      var_1 = 0;
      continue;
    }

    if(isplayer(self.enemy)) {
      if(self.enemy maps\_utility::ent_flag("player_has_red_flashing_overlay") || common_scripts\utility::flag("player_flashed")) {
        self.fixednode = 0;

        for (;;) {
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

      if(isdefined(var_2)) {
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

  if(isdefined(var_1))
    var_1.claimed = 0;
}

find_unclaimed_node(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1].claimed)
      continue;
    else
      return var_0[var_1];
  }

  return undefined;
}

flood_trigger_think(var_0) {
  var_1 = getentarray(var_0.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::flood_spawner_init);
  var_0 waittill("trigger");
  var_1 = getentarray(var_0.target, "targetname");
  common_scripts\utility::array_thread(var_1, ::flood_spawner_think, var_0);
}

flood_spawner_init(var_0) {}

trigger_requires_player(var_0) {
  if(!isdefined(var_0))
    return 0;

  return isdefined(var_0.script_requires_player);
}

two_stage_spawner_think(var_0) {
  var_1 = getent(var_0.target, "targetname");
  waittillframeend;
  var_2 = getentarray(var_1.target, "targetname");

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3].script_moveoverride = 1;
    var_2[var_3] maps\_utility::add_spawn_function(::wait_to_go, var_1);
  }

  var_0 waittill("trigger");
  var_2 = getentarray(var_1.target, "targetname");
  common_scripts\utility::array_thread(var_2, maps\_utility::spawn_ai);
}

wait_to_go(var_0) {
  var_0 endon("death");
  self endon("death");
  self.goalradius = 8;
  var_0 waittill("trigger");
  thread go_to_node();
}

flood_spawner_think(var_0) {
  if(!isdefined(level.spawn_pool_enabled) || isspawner(self))
    self endon("death");

  self notify("stop current floodspawner");
  self endon("stop current floodspawner");

  if(is_pyramid_spawner()) {
    pyramid_spawn(var_0);
    return;
  }

  var_1 = trigger_requires_player(var_0);
  maps\_utility::script_delay();

  if(isdefined(level.spawn_pool_enabled)) {
    if(!isspawner(self))
      self.count = 1;
  }

  while (self.count > 0) {
    while (var_1 && !level.player istouching(var_0))
      wait 0.5;

    var_2 = isdefined(self.script_stealth) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");
    var_3 = self;

    if(isdefined(level.spawn_pool_enabled)) {
      if(!isspawner(self))
        var_3 = get_spawner_from_pool(self, 1);
    }

    if(isdefined(self.script_forcespawn))
      var_4 = var_3 stalingradspawn(var_2);
    else
      var_4 = var_3 dospawn(var_2);

    if(maps\_utility::spawn_failed(var_4)) {
      wait 2;
      continue;
    }

    if(isdefined(self.script_combatbehavior)) {
      if(self.script_combatbehavior == "heat")
        var_4 maps\_utility::enable_heat_behavior();

      if(self.script_combatbehavior == "cqb")
        var_4 maps\_utility::enable_cqbwalk();
    }

    var_4 thread reincrement_count_if_deleted(self);
    var_4 thread expand_goalradius(var_0);

    if(isdefined(var_4) && !isdefined(var_4.targetname)) {
      if(isdefined(self.targetname))
        var_4.targetname = self.targetname + "_AI";
    }

    var_4 waittill("death", var_5);

    if(!player_saw_kill(var_4, var_5))
      self.count++;
    else if(isdefined(level.ac130_flood_respawn)) {
      if(isdefined(level.ac130gunner) && var_5 == level.ac130gunner) {
        if(randomint(2) == 0)
          self.count++;
      }
    }

    if(!isdefined(var_4)) {
      continue;
    }
    if(!maps\_utility::script_wait())
      wait(randomfloatrange(5, 9));
  }
}

flood_spawner_stop() {
  self notify("stop current floodspawner");
}

player_saw_kill(var_0, var_1) {
  if(isdefined(self.script_force_count)) {
    if(self.script_force_count)
      return 1;
  }

  if(!isdefined(var_0))
    return 0;

  if(isalive(var_1)) {
    if(isplayer(var_1))
      return 1;

    if(distance(var_1.origin, level.player.origin) < 200)
      return 1;
  } else if(isdefined(var_1)) {
    if(var_1.classname == "worldspawn")
      return 0;

    if(distance(var_1.origin, level.player.origin) < 200)
      return 1;
  }

  if(distance(var_0.origin, level.player.origin) < 200)
    return 1;

  return bullettracepassed(level.player geteye(), var_0 geteye(), 0, undefined);
}

is_pyramid_spawner() {
  if(!isdefined(self.target))
    return 0;

  var_0 = getentarray(self.target, "targetname");

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
  maps\_utility::script_delay();

  if(var_1) {
    while (!level.player istouching(var_0))
      wait 0.5;
  }

  var_2 = getentarray(self.target, "targetname");
  self.spawners = 0;
  common_scripts\utility::array_thread(var_2, ::pyramid_spawner_reports_death, self);
  var_4 = randomint(var_2.size);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(self.count <= 0) {
      return;
    }
    var_4++;

    if(var_4 >= var_2.size)
      var_4 = 0;

    var_5 = var_2[var_4];
    var_5.count = 1;
    var_6 = var_5 maps\_utility::spawn_ai();

    if(maps\_utility::spawn_failed(var_6)) {
      wait 2;
      continue;
    }

    self.count--;
    var_5.spawn = var_6;
    var_6 thread reincrement_count_if_deleted(self);
    var_6 thread expand_goalradius(var_0);
    thread pyramid_death_report(var_5);
  }

  var_7 = 0.01;

  while (self.count > 0) {
    self waittill("death_report");
    maps\_utility::script_wait();
    wait(var_7);
    var_7 = var_7 + 2.5;
    var_4 = randomint(var_2.size);

    for (var_3 = 0; var_3 < var_2.size; var_3++) {
      var_2 = common_scripts\utility::array_removeundefined(var_2);

      if(!var_2.size) {
        if(isdefined(self))
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
      if(isdefined(var_5.target))
        self.target = var_5.target;
      else
        self.target = undefined;

      var_6 = maps\_utility::spawn_ai();

      if(maps\_utility::spawn_failed(var_6)) {
        wait 2;
        continue;
      }

      var_6 thread reincrement_count_if_deleted(self);
      var_6 thread expand_goalradius(var_0);
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

expand_goalradius(var_0) {
  if(isdefined(self.script_forcegoal)) {
    return;
  }
  var_1 = level.default_goalradius;

  if(isdefined(var_0)) {
    if(isdefined(var_0.script_radius)) {
      if(var_0.script_radius == -1) {
        return;
      }
      var_1 = var_0.script_radius;
    }
  }

  if(isdefined(self.script_forcegoal)) {
    return;
  }
  self endon("death");
  self waittill("goal");
  self.goalradius = var_1;
}

drop_health_timeout_thread() {
  self endon("death");
  wait 95;
  self notify("timeout");
}

drop_health_trigger_think() {
  self endon("timeout");
  thread drop_health_timeout_thread();
  self waittill("trigger");
  maps\_utility::change_player_health_packets(1);
}

traceshow(var_0) {
  for (;;)
    wait 0.05;
}

show_bad_path() {}

random_spawn(var_0) {
  var_0 waittill("trigger");
  var_1 = getentarray(var_0.target, "targetname");

  if(!var_1.size) {
    return;
  }
  var_2 = common_scripts\utility::random(var_1);
  var_1 = [];
  var_1[var_1.size] = var_2;

  if(isdefined(var_2.script_linkto)) {
    var_3 = strtok(var_2.script_linkto, " ");

    for (var_4 = 0; var_4 < var_3.size; var_4++)
      var_1[var_1.size] = getent(var_3[var_4], "script_linkname");
  }

  waittillframeend;
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::blowout_goalradius_on_pathend);
  common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai);
}

blowout_goalradius_on_pathend() {
  if(isdefined(self.script_forcegoal)) {
    return;
  }
  self endon("death");
  self waittill("reached_path_end");

  if(!isdefined(self getgoalvolume()))
    self.goalradius = level.default_goalradius;
}

objective_event_init(var_0) {
  var_1 = var_0 maps\_utility::get_trigger_flag();
  common_scripts\utility::flag_init(var_1);

  while (level.deathspawner[var_0.script_deathchain] > 0)
    level waittill("spawner_expired" + var_0.script_deathchain);

  common_scripts\utility::flag_set(var_1);
}

setup_ai_eq_triggers() {
  self endon("death");
  waittillframeend;
  self.is_the_player = isplayer(self);
  self.eq_table = [];
  self.eq_touching = [];

  for (var_0 = 0; var_0 < level.eq_trigger_num; var_0++)
    self.eq_table[var_0] = 0;
}

ai_array() {
  level.ai_array[level.unique_id] = self;
  self waittill("death");
  waittillframeend;
  level.ai_array[level.unique_id] = undefined;
}

#using_animtree("generic_human");

spawner_dronespawn(var_0) {
  var_1 = var_0 spawndrone();
  var_1 useanimtree(#animtree);

  if(var_1.weapon != "none") {
    var_2 = getweaponmodel(var_1.weapon);
    var_1 attach(var_2, "tag_weapon_right");
    var_1 maps\_utility::update_weapon_tag_visibility(var_1.weapon);
  }

  var_1.spawner = var_0;
  var_1.drone_delete_on_unload = isdefined(var_0.script_noteworthy) && var_0.script_noteworthy == "drone_delete_on_unload";
  var_0 notify("drone_spawned", var_1);
  return var_1;
}

spawner_swap_drone_to_ai(var_0) {
  if(!isdefined(var_0.spawner)) {}

  var_0.spawner.count = var_0.spawner.count + 1;
  var_1 = var_0.spawner;
  var_1.count++;
  var_2 = var_1.origin;
  var_3 = var_1.angles;
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_4 = var_1 stalingradspawn();
  var_5 = maps\_utility::spawn_failed(var_4);

  if(var_5) {
    wait 0.05;
    var_4 = var_1 stalingradspawn();
  }

  var_4.spawner = var_1;
  var_4 setmodel(var_0.model);
  var_4 codescripts\character::setheadmodel(var_0.headmodel);
  var_4.vehicle_idling = var_0.vehicle_idling;
  var_4.vehicle_position = var_0.vehicle_position;
  var_4.standing = var_0.standing;
  var_4.forcecolor = var_0.forcecolor;
  var_4 copyanimtreestate(var_0);
  var_1.origin = var_2;
  var_1.angles = var_3;
  var_0 delete();
  var_6 = var_4.pathgoalpos;
  return var_4;
}

spawner_swap_ai_to_drone(var_0) {
  var_1 = var_0.spawner;
  var_2 = var_1.origin;
  var_3 = var_1.angles;
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_4 = var_1 maps\_utility::dronespawn();

  if(!isdefined(var_4)) {}

  var_4 setmodel(var_0.model);
  var_4 codescripts\character::setheadmodel(var_0.headmodel);
  var_4.vehicle_idling = var_0.vehicle_idling;
  var_4.vehicle_position = var_0.vehicle_position;
  var_4.standing = var_0.standing;
  var_4.forcecolor = var_0.forcecolor;
  var_4 copyanimtreestate(var_0);
  var_1.origin = var_2;
  var_1.angles = var_3;
  var_0 delete();
  var_4 notify("drone_stop");
  return var_4;
}

death_achievements() {
  self waittill("death", var_0, var_1, var_2);

  if(!isdefined(self)) {
    return;
  }
  achieve_enemy_killed_by_flash_banged(var_0);
  thread achieve_carkilled_by_player(var_0);
  thread achieve_three_of_kind(var_0, var_1);
  thread achieve_four_of_kind(var_0, var_1);
}

achieve_three_of_kind(var_0, var_1) {
  if(self.team != "axis") {
    return;
  }
  if(!isdefined(var_0)) {
    return;
  }
  if(var_0 != level.player) {
    return;
  }
  if(var_1 != "MOD_MELEE") {
    return;
  }
  if(!isdefined(level.achieve_three_of_kind))
    level.achieve_three_of_kind = 1;
  else
    level.achieve_three_of_kind++;

  if(level.achieve_three_of_kind == 3)
    maps\_utility::giveachievement_wrapper("THREE_OF_A_KIND");

  level notify("achieve_three_of_kind");
  level endon("achieve_three_of_kind");
  wait 4;
  level.achieve_three_of_kind = undefined;
}

achieve_four_of_kind(var_0, var_1) {
  if(self.team != "axis") {
    return;
  }
  if(!isdefined(var_0)) {
    return;
  }
  if(var_0 != level.player) {
    return;
  }
  if(var_1 == "MOD_MELEE" || !animscripts\utility::damagelocationisany("head", "neck", "helmet")) {
    level.achieve_four_of_kind = undefined;
    return;
  }

  if(!isdefined(level.achieve_four_of_kind))
    level.achieve_four_of_kind = 1;
  else
    level.achieve_four_of_kind++;

  if(level.achieve_four_of_kind == 4)
    maps\_utility::giveachievement_wrapper("FOUR_OF_A_KIND");

  level notify("achieve_four_of_kind");
  level endon("achieve_four_of_kind");
  wait 12;
  level.achieve_four_of_kind = undefined;
}

achieve_enemy_killed_by_flash_banged(var_0) {
  if(self.team != "axis") {
    return;
  }
  if(!isdefined(var_0)) {
    return;
  }
  if(level.flag["player_flashed"] && var_0 == level.player)
    maps\_utility::giveachievement_wrapper("DAREDEVIL");
}

achieve_carkilled_by_player(var_0) {
  if(self.team != "axis") {
    return;
  }
  if(!isdefined(var_0)) {
    return;
  }
  if(!isdefined(var_0.destuctableinfo)) {
    return;
  }
  if(!isdefined(var_0.attacker)) {
    return;
  }
  if(var_0.attacker != level.player) {
    return;
  }
  if(isdefined(level.achieve_car_killed_one)) {
    maps\_utility::giveachievement_wrapper("ROADKILL");
    level.achieve_car_killed_one = undefined;
  } else {
    level.achieve_car_killed_one = 1;
    wait 0.05;
  }
}

death_achievements_rappel(var_0) {}

add_random_killspawner_to_spawngroup() {
  var_0 = self.script_random_killspawner;
  var_1 = self.script_randomspawn;

  if(!isdefined(level.killspawn_groups[var_0]))
    level.killspawn_groups[var_0] = [];

  if(!isdefined(level.killspawn_groups[var_0][var_1]))
    level.killspawn_groups[var_0][var_1] = [];

  level.killspawn_groups[var_0][var_1][self.export] = self;
}

add_to_spawngroup() {
  var_0 = self.script_spawngroup;
  var_1 = self.script_spawnsubgroup;

  if(!isdefined(level.spawn_groups[var_0]))
    level.spawn_groups[var_0] = [];

  if(!isdefined(level.spawn_groups[var_0][var_1]))
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