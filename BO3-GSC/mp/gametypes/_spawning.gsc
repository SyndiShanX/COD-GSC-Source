/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_spawning.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\gametypes\_dogtags;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\killstreaks\_airsupport;
#using scripts\shared\abilities\gadgets\_gadget_resurrect;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_tacticalinsertion;
#namespace spawning;

function autoexec __init__sytem__() {
  system::register("spawning", &__init__, undefined, undefined);
}

function __init__() {
  level init_spawn_system();
  level.influencers = [];
  level.recently_deceased = [];
  foreach(team in level.teams) {
    level.recently_deceased[team] = util::spawn_array_struct();
  }
  callback::on_connecting(&onplayerconnect);
  level.spawnprotectiontime = getgametypesetting("spawnprotectiontime");
  level.spawnprotectiontimems = int((isDefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
  level.spawntraptriggertime = getgametypesetting("spawntraptriggertime");
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  setDvar("", "");
  level.test_spawn_point_index = 0;
  setDvar("", "");
}

function init_spawn_system() {
  level.spawnsystem = spawnStruct();
  spawnsystem = level.spawnsystem;
  if(!isDefined(spawnsystem.sideswitching)) {
    spawnsystem.sideswitching = 1;
  }
  spawnsystem.objective_facing_bonus = 0;
  spawnsystem.ispawn_teammask = [];
  spawnsystem.ispawn_teammask_free = 1;
  spawnsystem.ispawn_teammask["free"] = spawnsystem.ispawn_teammask_free;
  all = spawnsystem.ispawn_teammask_free;
  count = 1;
  foreach(team in level.teams) {
    spawnsystem.ispawn_teammask[team] = 1 << count;
    all = all | spawnsystem.ispawn_teammask[team];
    count++;
  }
  spawnsystem.ispawn_teammask["all"] = all;
}

function onplayerconnect() {
  level endon("game_ended");
  self thread onplayerspawned();
  self thread onteamchange();
  self thread ongrenadethrow();
}

function onplayerspawned() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("spawned_player");
    self airsupport::clearmonitoredspeed();
    self thread initialspawnprotection();
    if(isDefined(self.pers["hasRadar"]) && self.pers["hasRadar"]) {
      self.hasspyplane = 1;
    }
    self enable_player_influencers(1);
    self thread ondeath();
  }
}

function ondeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self enable_player_influencers(0);
  level create_friendly_influencer("friend_dead", self.origin, self.team);
}

function onteamchange() {
  self endon("disconnect");
  level endon("game_ended");
  while(true) {
    self waittill("joined_team");
    self.lastspawnpoint = undefined;
    self player_influencers_set_team();
    wait(0.05);
  }
}

function ongrenadethrow() {
  self endon("disconnect");
  level endon("game_ended");
  while(true) {
    self waittill("grenade_fire", grenade, weapon);
    level thread create_grenade_influencers(self.pers["team"], weapon, grenade);
    wait(0.05);
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
  self thread watch_remove_influencer();
  return self.influencers[name];
}

function create_entity_friendly_influencer(name, team) {
  team_mask = self get_friendly_team_mask(team);
  return self create_entity_masked_friendly_influencer(name, team_mask);
}

function create_entity_enemy_influencer(name, team) {
  team_mask = self get_enemy_team_mask(team);
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
    enemy_teams_mask = level.spawnsystem.ispawn_teammask_free;
  } else {
    if(isDefined(self.pers["team"])) {
      team = self.pers["team"];
      team_mask = util::getteammask(team);
      enemy_teams_mask = util::getotherteamsmask(team);
    } else {
      team_mask = 0;
      enemy_teams_mask = 0;
    }
  }
  angles = self.angles;
  origin = self.origin;
  up = (0, 0, 1);
  forward = (1, 0, 0);
  self.influencers = [];
  self.friendlyinfluencers = [];
  self.enemyinfluencers = [];
  self create_entity_masked_enemy_influencer("enemy", enemy_teams_mask);
  if(level.teambased) {
    self create_entity_masked_friendly_influencer("friend", team_mask);
  }
  if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator") {
    self enable_influencers(0);
  }
}

function create_player_spawn_influencers(spawn_origin) {
  level create_enemy_influencer("enemy_spawn", spawn_origin, self.pers["team"]);
  level create_friendly_influencer("friendly_spawn", spawn_origin, self.pers["team"]);
}

function remove_influencer(to_be_removed) {
  foreach(influencer in self.influencers) {
    if(influencer == to_be_removed) {
      removeinfluencer(influencer);
      arrayremovevalue(self.influencers, influencer);
      if(isDefined(self.influencersfriendly)) {
        arrayremovevalue(self.influencersfriendly, influencer);
      }
      if(isDefined(self.influencersenemy)) {
        arrayremovevalue(self.influencersenemy, influencer);
      }
      return;
    }
  }
}

function remove_influencers() {
  if(isDefined(self.influencers)) {
    foreach(influencer in self.influencers) {
      removeinfluencer(influencer);
    }
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
  self endon("death");
  self notify("watch_remove_influencer");
  self endon("watch_remove_influencer");
  self waittill("influencer_removed", index);
  arrayremovevalue(self.influencers, index);
  if(isDefined(self.influencersfriendly)) {
    arrayremovevalue(self.influencersfriendly, index);
  }
  if(isDefined(self.influencersenemy)) {
    arrayremovevalue(self.influencersenemy, index);
  }
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
    team = self.pers["team"];
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
  pixbeginevent("create_grenade_influencers");
  spawn_influencer = weapon.spawninfluencer;
  if(isDefined(grenade.origin) && spawn_influencer != "") {
    if(!level.teambased) {
      weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
    } else {
      weapon_team_mask = util::getotherteamsmask(parent_team);
      if(level.friendlyfire) {
        weapon_team_mask = weapon_team_mask | util::getteammask(parent_team);
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
    assertmsg("");
  }
  return influencer_id;
}

function updateallspawnpoints() {
  foreach(team in level.teams) {
    gatherspawnpoints(team);
  }
  clearspawnpoints(0);
  if(level.teambased) {
    foreach(team in level.teams) {
      addspawnpoints(team, level.player_spawn_points[team], 0);
      enablespawnpointlist(0, util::getteammask(team));
    }
  } else {
    foreach(team in level.teams) {
      addspawnpoints("free", level.player_spawn_points[team], 0);
      enablespawnpointlist(0, util::getteammask(team));
    }
  }
  level.spawnallmins = level.spawnmins;
  level.spawnallmaxs = level.spawnmaxs;
  remove_unused_spawn_entities();
}

function update_fallback_spawnpoints() {
  clearspawnpoints(1);
  if(!isDefined(level.player_fallback_points)) {
    return;
  }
  if(level.teambased) {
    foreach(team in level.teams) {
      addspawnpoints(team, level.player_fallback_points[team], 1);
    }
  } else {
    foreach(team in level.teams) {
      addspawnpoints("free", level.player_fallback_points[team], 1);
    }
  }
}

function add_fallback_spawnpoints(team, point_class) {
  if(!isDefined(level.player_fallback_points)) {
    level.player_fallback_points = [];
    foreach(level_team in level.teams) {
      level.player_fallback_points[level_team] = [];
    }
  }
  spawnlogic::add_spawn_point_classname(point_class);
  spawnpoints = spawnlogic::get_spawnpoint_array(point_class);
  if(isDefined(level.allowedgameobjects) && level.convert_spawns_to_structs) {
    for(i = spawnpoints.size - 1; i >= 0; i--) {
      if(!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects)) {
        spawnpoints[i] = undefined;
      }
    }
    arrayremovevalue(spawnpoints, undefined);
  }
  level.player_fallback_points[team] = spawnpoints;
  disablespawnpointlist(1, util::getteammask(team));
}

function is_spawn_trapped(team) {
  level.spawntraptriggertime = getgametypesetting("");
  if(!level.rankedmatch) {
    return false;
  }
  if(isDefined(level.alivetimesaverage[team]) && level.alivetimesaverage[team] != 0 && level.alivetimesaverage[team] < (level.spawntraptriggertime * 1000)) {
    return true;
  }
  return false;
}

function use_start_spawns(predictedspawn) {
  if(level.alwaysusestartspawns) {
    return true;
  }
  if(!level.usestartspawns) {
    return false;
  }
  if(level.teambased) {
    spawnteam = self.pers["team"];
    if((level.aliveplayers[spawnteam].size + level.spawningplayers[self.team].size) >= level.spawn_start[spawnteam].size) {
      if(!predictedspawn) {
        level.usestartspawns = 0;
      }
      return false;
    }
  } else if((level.aliveplayers["free"].size + level.spawningplayers["free"].size) >= level.spawn_start.size) {
    if(!predictedspawn) {
      level.usestartspawns = 0;
    }
    return false;
  }
  return true;
}

function onspawnplayer(predictedspawn = 0) {
  if(getdvarint("") != 0) {
    spawn_point = get_debug_spawnpoint(self);
    self spawn(spawn_point.origin, spawn_point.angles);
    return;
  }
  spawnoverride = self tacticalinsertion::overridespawn(predictedspawn);
  spawnresurrect = self resurrect::overridespawn(predictedspawn);
  if(isDefined(self.devguilockspawn) && self.devguilockspawn) {
    spawnresurrect = 1;
  }
  spawn_origin = undefined;
  spawn_angles = undefined;
  if(spawnresurrect) {
    spawn_origin = self.resurrect_origin;
    spawn_angles = self.resurrect_angles;
  } else {
    if(spawnoverride) {
      if(predictedspawn && isDefined(self.tacticalinsertion)) {
        self predictspawnpoint(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
      }
      return;
    }
    if(self use_start_spawns(predictedspawn)) {
      if(!predictedspawn) {
        if(level.teambased) {
          level.spawningplayers[self.team][level.spawningplayers[self.team].size] = self;
        } else {
          level.spawningplayers["free"][level.spawningplayers["free"].size] = self;
        }
      }
      if(level.teambased) {
        spawnteam = self.pers["team"];
        if(game["switchedsides"]) {
          spawnteam = util::getotherteam(spawnteam);
        }
        spawnpoint = spawnlogic::get_spawnpoint_random(level.spawn_start[spawnteam], predictedspawn);
      } else {
        spawnpoint = spawnlogic::get_spawnpoint_random(level.spawn_start, predictedspawn);
      }
      if(isDefined(spawnpoint)) {
        spawn_origin = spawnpoint.origin;
        spawn_angles = spawnpoint.angles;
      }
      if(isDefined(level.var_e0d16266)) {
        [[level.var_e0d16266]](spawnpoint, predictedspawn);
      }
    } else {
      spawn_point = getspawnpoint(self, predictedspawn);
      if(isDefined(spawn_point)) {
        spawn_origin = spawn_point["origin"];
        spawn_angles = spawn_point["angles"];
      }
    }
  }
  if(!isDefined(spawn_origin)) {
    println("");
    callback::abort_level();
  }
  if(predictedspawn) {
    self predictspawnpoint(spawn_origin, spawn_angles);
  } else {
    self spawn(spawn_origin, spawn_angles);
    self.lastspawntime = gettime();
    self enable_player_influencers(1);
    if(!spawnresurrect && !spawnoverride) {
      self create_player_spawn_influencers(spawn_origin);
    }
  }
  if(isDefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
    dogtags::on_spawn_player();
  }
}

function getspawnpoint(player_entity, predictedspawn = 0) {
  if(level.teambased) {
    point_team = player_entity.pers["team"];
    influencer_team = player_entity.pers["team"];
  } else {
    point_team = "free";
    influencer_team = "free";
  }
  spawn_trapped = is_spawn_trapped(point_team);
  if(level.teambased && isDefined(game["switchedsides"]) && game["switchedsides"] && level.spawnsystem.sideswitching) {
    point_team = util::getotherteam(point_team);
  }
  if(spawn_trapped) {
    enablespawnpointlist(1, util::getteammask(point_team));
  } else {
    disablespawnpointlist(1, util::getteammask(point_team));
  }
  best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn);
  if(!predictedspawn) {
    player_entity.last_spawn_origin = best_spawn["origin"];
  }
  return best_spawn;
}

function get_debug_spawnpoint(player) {
  if(level.teambased) {
    team = player.pers["team"];
  } else {
    team = "free";
  }
  index = level.test_spawn_point_index;
  level.test_spawn_point_index++;
  if(team == "free") {
    spawn_counts = 0;
    foreach(team in level.teams) {
      spawn_counts = spawn_counts + level.player_spawn_points[team].size;
    }
    if(level.test_spawn_point_index >= spawn_counts) {
      level.test_spawn_point_index = 0;
    }
    count = 0;
    foreach(team in level.teams) {
      size = level.player_spawn_points[team].size;
      if(level.test_spawn_point_index < (count + size)) {
        return level.player_spawn_points[team][level.test_spawn_point_index - count];
      }
      count = count + size;
    }
  } else {
    if(level.test_spawn_point_index >= level.player_spawn_points[team].size) {
      level.test_spawn_point_index = 0;
    }
    return level.player_spawn_points[team][level.test_spawn_point_index];
  }
}

function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn) {
  if(level.teambased) {
    vis_team_mask = util::getotherteamsmask(player.pers["team"]);
  } else {
    vis_team_mask = level.spawnsystem.ispawn_teammask["all"];
  }
  spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn);
  if(!predictedspawn) {
    bbprint("mpspawnpointsused", "reason %s x %d y %d z %d", "point used", spawn_point["origin"]);
  }
  return spawn_point;
}

function gatherspawnpoints(player_team) {
  if(!isDefined(level.player_spawn_points)) {
    level.player_spawn_points = [];
  } else if(isDefined(level.player_spawn_points[player_team])) {
    return;
  }
  spawn_entities = spawnlogic::get_team_spawnpoints(player_team);
  if(!isDefined(spawn_entities)) {
    spawn_entities = [];
  }
  level.player_spawn_points[player_team] = spawn_entities;
}

function is_hardcore() {
  return isDefined(level.hardcoremode) && level.hardcoremode;
}

function teams_have_enmity(team1, team2) {
  if(!isDefined(team1) || !isDefined(team2) || level.gametype == "dm") {
    return 1;
  }
  return team1 != "neutral" && team2 != "neutral" && team1 != team2;
}

function remove_unused_spawn_entities() {
  if(level.convert_spawns_to_structs) {
    return;
  }
  spawn_entity_types = [];
  spawn_entity_types[spawn_entity_types.size] = "mp_dm_spawn";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team1_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team2_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team3_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team4_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team5_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn_team6_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_tdm_spawn";
  spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_allies";
  spawn_entity_types[spawn_entity_types.size] = "mp_ctf_spawn_axis";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_flag_a";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_flag_b";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn_flag_c";
  spawn_entity_types[spawn_entity_types.size] = "mp_dom_spawn";
  spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_allies";
  spawn_entity_types[spawn_entity_types.size] = "mp_sab_spawn_axis";
  spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_attacker";
  spawn_entity_types[spawn_entity_types.size] = "mp_sd_spawn_defender";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attacker_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defender_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attackerOT_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defenderOT_start";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attacker";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defender";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defender_a";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_defender_b";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attacker_remove_a";
  spawn_entity_types[spawn_entity_types.size] = "mp_dem_spawn_attacker_remove_b";
  for(i = 0; i < spawn_entity_types.size; i++) {
    if(spawn_point_class_name_being_used(spawn_entity_types[i])) {
      continue;
    }
    spawnpoints = spawnlogic::get_spawnpoint_array(spawn_entity_types[i]);
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

function codecallback_updatespawnpoints() {
  foreach(team in level.teams) {
    spawnlogic::rebuild_spawn_points(team);
  }
  level.player_spawn_points = undefined;
  updateallspawnpoints();
}

function initialspawnprotection() {
  self endon("death");
  self endon("disconnect");
  self thread airsupport::monitorspeed(level.spawnprotectiontime);
  if(!isDefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0) {
    return;
  }
  self.specialty_nottargetedbyairsupport = 1;
  self clientfield::set("killstreak_spawn_protection", 1);
  self.ignoreme = 1;
  wait(level.spawnprotectiontime);
  self clientfield::set("killstreak_spawn_protection", 0);
  self.specialty_nottargetedbyairsupport = undefined;
  self.ignoreme = 0;
}

function getteamstartspawnname(team, spawnpointnamebase) {
  spawn_point_team_name = team;
  if(!level.multiteam && game["switchedsides"]) {
    spawn_point_team_name = util::getotherteam(team);
  }
  if(level.multiteam) {
    if(team == "axis") {
      spawn_point_team_name = "team1";
    } else if(team == "allies") {
      spawn_point_team_name = "team2";
    }
    if(!util::isoneround()) {
      number = int(getsubstr(spawn_point_team_name, 4, 5)) - 1;
      number = ((number + game["roundsplayed"]) % level.teams.size) + 1;
      spawn_point_team_name = "team" + number;
    }
  }
  return ((spawnpointnamebase + "_") + spawn_point_team_name) + "_start";
}

function gettdmstartspawnname(team) {
  return getteamstartspawnname(team, "mp_tdm_spawn");
}