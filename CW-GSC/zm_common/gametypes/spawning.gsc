/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\spawning.gsc
***********************************************/

#using script_44b0b8420eabacad;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\util;
#namespace spawning;

function private preinit() {
  level init_spawn_system();
  level.recently_deceased = [];

  foreach(team, _ in level.teams) {
    level.recently_deceased[team] = util::spawn_array_struct();
  }

  callback::on_connecting(&on_player_connecting);
  level.spawnprotectiontime = getgametypesetting(#"spawnprotectiontime");
  level.spawnprotectiontimems = int((isDefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);

  setDvar(#"scr_debug_spawn_player", "<dev string:x38>");
  setDvar(#"scr_debug_render_spawn_data", 1);
  setDvar(#"scr_debug_render_snapshotmode", 0);
  setDvar(#"scr_spawn_point_test_mode", 0);
  level.test_spawn_point_index = 0;
  setDvar(#"scr_debug_render_spawn_text", 1);
}

function init_spawn_system() {
  level.spawnsystem = spawnStruct();
  spawnsystem = level.spawnsystem;

  if(!isDefined(spawnsystem.unifiedsideswitching)) {
    spawnsystem.unifiedsideswitching = 1;
  }

  spawnsystem.objective_facing_bonus = 0;
  spawnsystem.ispawn_teammask = [];
  spawnsystem.ispawn_teammask_free = 1;
  spawnsystem.ispawn_teammask[#"none"] = spawnsystem.ispawn_teammask_free;
  all = spawnsystem.ispawn_teammask_free;
  count = 1;

  foreach(team, _ in level.teams) {
    spawnsystem.ispawn_teammask[team] = 1 << count;
    all |= spawnsystem.ispawn_teammask[team];
    count++;
  }

  spawnsystem.ispawn_teammask[#"all"] = all;
}

function on_player_connecting() {
  level endon(#"game_ended");
  self setentertime(gettime());
  callback::on_spawned(&on_player_spawned);
  callback::on_joined_team(&on_joined_team);
  self thread ongrenadethrow();
}

function on_player_spawned() {
  self endon(#"disconnect");
  level endon(#"game_ended");

  for(;;) {
    self waittill(#"spawned_player");
    self enable_player_influencers(1);
    self thread ondeath();
  }
}

function ondeath() {
  self endon(#"disconnect");
  level endon(#"game_ended");
  self waittill(#"death");
  self enable_player_influencers(0);
  level create_friendly_influencer("friend_dead", self.origin, self.team);
}

function on_joined_team(params) {
  self endon(#"disconnect");
  level endon(#"game_ended");
  self player_influencers_set_team();
}

function ongrenadethrow() {
  self endon(#"disconnect");
  level endon(#"game_ended");

  while(true) {
    waitresult = self waittill(#"grenade_fire");
    grenade = waitresult.projectile;
    weapon = waitresult.weapon;
    level thread create_grenade_influencers(self.pers[#"team"], weapon, grenade);
    waitframe(1);
  }
}

function get_friendly_team_mask(team) {
  if(level.teambased) {
    team_mask = util::getteammask(team);
  } else {
    team_mask = level.spawnsystem.ispawn_teammask_free;
  }

  return team_mask;
}

function get_enemy_team_mask(team) {
  if(level.teambased) {
    team_mask = util::getotherteamsmask(team);
  } else {
    team_mask = level.spawnsystem.ispawn_teammask_free;
  }

  return team_mask;
}

function create_influencer(name, origin, team_mask) {
  self.influencers[name] = addinfluencer(name, origin, team_mask);
  self thread watch_remove_influencer();
  return self.influencers[name];
}

function create_friendly_influencer(name, origin, team) {
  team_mask = self get_friendly_team_mask(team);
  self.influencersfriendly[name] = create_influencer(name, origin, team_mask);
  return self.influencersfriendly[name];
}

function create_enemy_influencer(name, origin, team) {
  team_mask = self get_enemy_team_mask(team);
  self.influencersenemy[name] = create_influencer(name, origin, team_mask);
  return self.influencersenemy[name];
}

function create_entity_influencer(name, team_mask) {
  self.influencers[name] = addentityinfluencer(name, self, team_mask);
  return self.influencers[name];
}

function create_entity_friendly_influencer(name) {
  team_mask = self get_friendly_team_mask();
  return self create_entity_masked_friendly_influencer(name, team_mask);
}

function create_entity_enemy_influencer(name) {
  team_mask = self get_enemy_team_mask();
  return self create_entity_masked_enemy_influencer(name, team_mask);
}

function create_entity_masked_friendly_influencer(name, team_mask) {
  self.influencersfriendly[name] = self create_entity_influencer(name, team_mask);
  return self.influencersfriendly[name];
}

function create_entity_masked_enemy_influencer(name, team_mask) {
  self.influencersenemy[name] = self create_entity_influencer(name, team_mask);
  return self.influencersenemy[name];
}

function create_player_influencers() {
  assert(!isDefined(self.influencers));
  assert(!isDefined(self.influencers));

  if(!level.teambased) {
    team_mask = level.spawnsystem.ispawn_teammask_free;
    other_team_mask = level.spawnsystem.ispawn_teammask_free;
    weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
  } else if(isDefined(self.pers[#"team"])) {
    team = self.pers[#"team"];
    team_mask = util::getteammask(team);
    enemy_teams_mask = util::getotherteamsmask(team);
  } else {
    team_mask = 0;
    enemy_teams_mask = 0;
  }

  angles = self.angles;
  origin = self.origin;
  up = (0, 0, 1);
  forward = (1, 0, 0);
  self.influencers = [];
  self.friendlyinfluencers = [];
  self.enemyinfluencers = [];
  self create_entity_masked_enemy_influencer(#"enemy", enemy_teams_mask);

  if(level.teambased) {
    self create_entity_masked_friendly_influencer("friend", team_mask);
  }

  if(!isDefined(self.pers[#"team"]) || self.pers[#"team"] == "spectator") {
    self enable_influencers(0);
  }
}

function remove_influencers() {
  foreach(influencer in self.influencers) {
    removeinfluencer(influencer);
  }

  self.influencers = [];

  if(isDefined(self.influencersfriendly)) {
    self.influencersfriendly = [];
  }

  if(isDefined(self.influencersenemy)) {
    self.influencersenemy = [];
  }
}

function watch_remove_influencer() {
  self endon(#"death");
  self notify(#"watch_remove_influencer");
  self endon(#"watch_remove_influencer");
  waitresult = self waittill(#"influencer_removed");
  arrayremovevalue(self.influencers, waitresult.index);
  arrayremovevalue(self.influencersfriendly, waitresult.index);
  arrayremovevalue(self.influencersenemy, waitresult.index);
  self thread watch_remove_influencer();
}

function enable_influencers(enabled) {
  foreach(influencer in self.influencers) {
    enableinfluencer(influencer, enabled);
  }
}

function enable_player_influencers(enabled) {
  if(!isDefined(self.influencers)) {
    self create_player_influencers();
  }

  self enable_influencers(enabled);
}

function player_influencers_set_team() {
  if(!level.teambased) {
    team_mask = level.spawnsystem.ispawn_teammask_free;
    enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
  } else {
    team = self.pers[#"team"];
    team_mask = util::getteammask(team);
    enemy_teams_mask = util::getotherteamsmask(team);
  }

  if(isDefined(self.influencersfriendly)) {
    foreach(influencer in self.influencersfriendly) {
      setinfluencerteammask(influencer, team_mask);
    }
  }

  if(isDefined(self.influencersenemy)) {
    foreach(influencer in self.influencersenemy) {
      setinfluencerteammask(influencer, enemy_teams_mask);
    }
  }
}

function create_grenade_influencers(parent_team, weapon, grenade) {
  pixbeginevent(#"");
  spawn_influencer = weapon.spawninfluencer;

  if(isDefined(grenade.origin) && spawn_influencer != "") {
    if(!level.teambased) {
      weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
    } else {
      weapon_team_mask = util::getotherteamsmask(parent_team);

      if(level.friendlyfire) {
        weapon_team_mask |= util::getteammask(parent_team);
      }
    }

    grenade create_entity_masked_enemy_influencer(spawn_influencer, weapon_team_mask);
  }

  pixendevent();
}

function create_map_placed_influencers() {
  staticinfluencerents = getEntArray("mp_uspawn_influencer", "classname");

  for(i = 0; i < staticinfluencerents.size; i++) {
    staticinfluencerent = staticinfluencerents[i];
    create_map_placed_influencer(staticinfluencerent);
  }
}

function create_map_placed_influencer(influencer_entity) {
  influencer_id = -1;

  if(isDefined(influencer_entity.script_noteworty)) {
    team_mask = util::getteammask(influencer_entity.script_team);
    level create_enemy_influencer(influencer_entity.script_noteworty, influencer_entity.origin, team_mask);
  } else {
    assertmsg("<dev string:x3c>");
  }

  return influencer_id;
}

function updateallspawnpoints() {
  foreach(team, _ in level.teams) {
    gatherspawnpoints(team);
  }

  spawnlogic::clearspawnpoints();

  if(level.teambased) {
    foreach(team, _ in level.teams) {
      spawnlogic::addspawnpoints(team, level.unified_spawn_points[team].a);
    }
  } else {
    foreach(team, _ in level.teams) {
      spawnlogic::addspawnpoints(#"none", level.unified_spawn_points[team].a);
    }
  }

  remove_unused_spawn_entities();
}

function onspawnplayer_unified(predictedspawn = 0) {
  if(getdvarint(#"scr_spawn_point_test_mode", 0) != 0) {
    spawn_point = get_debug_spawnpoint(self);
    self spawn(spawn_point.origin, spawn_point.angles);
    return;
  }

  use_new_spawn_system = 0;
  initial_spawn = 1;

  if(isDefined(self.uspawn_already_spawned)) {
    initial_spawn = !self.uspawn_already_spawned;
  }

  if(usestartspawns()) {
    use_new_spawn_system = 0;
  }

  if(level.gametype == "sd") {
    use_new_spawn_system = 0;
  }

  function_5ac4dc99("scr_spawn_force_unified", "0");
  [[level.onspawnplayer]](predictedspawn);

  if(!predictedspawn) {
    self.uspawn_already_spawned = 1;
  }
}

function getspawnpoint(player_entity, predictedspawn = 0) {
  if(level.teambased) {
    point_team = player_entity.pers[#"team"];
    influencer_team = player_entity.pers[#"team"];
  } else {
    point_team = # "none";
    influencer_team = # "none";
  }

  if(level.teambased && isDefined(game.switchedsides) && game.switchedsides && level.spawnsystem.unifiedsideswitching) {
    point_team = util::getotherteam(point_team);
  }

  best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn);

  if(!predictedspawn) {
    player_entity.last_spawn_origin = best_spawn[#"origin"];
  }

  return best_spawn;
}

function get_debug_spawnpoint(player) {
  if(level.teambased) {
    team = player.pers[#"team"];
  } else {
    team = # "none";
  }

  index = level.test_spawn_point_index;
  level.test_spawn_point_index++;

  if(team == # "none") {
    spawn_counts = 0;

    foreach(team, _ in level.teams) {
      spawn_counts += level.unified_spawn_points[team].a.size;
    }

    if(level.test_spawn_point_index >= spawn_counts) {
      level.test_spawn_point_index = 0;
    }

    count = 0;

    foreach(team, _ in level.teams) {
      size = level.unified_spawn_points[team].a.size;

      if(level.test_spawn_point_index < count + size) {
        return level.unified_spawn_points[team].a[level.test_spawn_point_index - count];
      }

      count += size;
    }

    return;
  }

  if(level.test_spawn_point_index >= level.unified_spawn_points[team].a.size) {
    level.test_spawn_point_index = 0;
  }

  return level.unified_spawn_points[team].a[level.test_spawn_point_index];
}

function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn) {
  if(level.teambased) {
    vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
  } else {
    vis_team_mask = level.spawnsystem.ispawn_teammask_free;
  }

  spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn);

  if(!predictedspawn) {
    var_48eba3a3 = {
      #reason: "point used", #var_c734ddf2: getplayerspawnid(player), #x: spawn_point[#"origin"][0], #y: spawn_point[#"origin"][1], #z: spawn_point[#"origin"][2]
    };
    function_92d1707f(#"hash_263d9506f7e11fdd", var_48eba3a3);
  }

  return spawn_point;
}

function gatherspawnpoints(player_team) {
  if(!isDefined(level.unified_spawn_points)) {
    level.unified_spawn_points = [];
  } else if(isDefined(level.unified_spawn_points[player_team])) {
    return level.unified_spawn_points[player_team];
  }

  spawn_entities_s = util::spawn_array_struct();
  spawn_entities_s.a = spawnlogic::getteamspawnpoints(player_team);

  if(!isDefined(spawn_entities_s.a)) {
    spawn_entities_s.a = [];
  }

  level.unified_spawn_points[player_team] = spawn_entities_s;
  return spawn_entities_s;
}

function is_hardcore() {
  return isDefined(level.hardcoremode) && level.hardcoremode;
}

function teams_have_enmity(team1, team2) {
  if(!isDefined(team1) || !isDefined(team2) || level.gametype == "dm") {
    return true;
  }

  return team1 != # "neutral" && team2 != # "neutral" && team1 != team2;
}

function remove_unused_spawn_entities() {
  spawn_entity_types = [];
  spawn_entity_types[spawn_entity_types.size] = "mp_dm_spawn";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn";
  spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies";
  spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn";
  spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies";
  spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis";
  spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_attacker";
  spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_defender";
  spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_twar_spawn";

  for(i = 0; i < spawn_entity_types.size; i++) {
    if(spawn_point_class_name_being_used(spawn_entity_types[i])) {
      continue;
    }

    spawnpoints = spawnlogic::getspawnpointarray(spawn_entity_types[i]);
    delete_all_spawns(spawnpoints);
  }
}

function delete_all_spawns(spawnpoints) {
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoints[i] delete();
  }
}

function spawn_point_class_name_being_used(name) {
  if(!isDefined(level.spawn_point_class_names)) {
    return false;
  }

  for(i = 0; i < level.spawn_point_class_names.size; i++) {
    if(level.spawn_point_class_names[i] == name) {
      return true;
    }
  }

  return false;
}

function initialspawnprotection(specialtyname, spawnmonitorspeed) {
  self endon(#"death", #"disconnect");

  if(!isDefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0) {
    return;
  }

  if(spawnmonitorspeed == "specialty_nottargetedbyairsupport") {
    self.specialty_nottargetedbyairsupport = 1;
    wait level.spawnprotectiontime;
    self.specialty_nottargetedbyairsupport = undefined;
    return;
  }

  if(!self hasperk(spawnmonitorspeed)) {
    self setperk(spawnmonitorspeed);
    wait level.spawnprotectiontime;
    self unsetperk(spawnmonitorspeed);
  }
}