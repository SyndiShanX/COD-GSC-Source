/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_spawning.gsc
*************************************************/

#using scripts\cp\_callbacks;
#using scripts\cp\_laststand;
#using scripts\cp\_tacticalinsertion;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_spawnlogic;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_tacticalinsertion;
#namespace spawning;

function autoexec __init__sytem__() {
  system::register("spawning", & __init__, undefined, undefined);
}

function __init__() {
  level init_spawn_system();
  level.recently_deceased = [];
  foreach(team in level.teams) {
    level.recently_deceased[team] = util::spawn_array_struct();
  }
  callback::on_connecting( & onplayerconnect);
  level.spawnprotectiontime = getgametypesetting("spawnprotectiontime");
  level.spawnprotectiontimems = int((isDefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  level.test_spawn_point_index = 0;
  setdvar("", "");
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
  self setentertime(gettime());
  self thread onplayerspawned();
  self thread onteamchange();
  self thread ongrenadethrow();
}

function onplayerspawned() {
  self endon("disconnect");
  self endon("killspawnmonitor");
  level endon("game_ended");
  self flag::init("player_has_red_flashing_overlay");
  self flag::init("player_is_invulnerable");
  for(;;) {
    self waittill("spawned_player");
    if(isDefined(self.pers["hasRadar"]) && self.pers["hasRadar"]) {
      self.hasspyplane = 1;
    }
    self enable_player_influencers(1);
    self thread gameskill::playerhealthregen();
    self thread ondeath();
    self laststand::revive_hud_create();
  }
}

function ondeath() {
  self endon("disconnect");
  self endon("killspawnmonitor");
  level endon("game_ended");
  self waittill("death");
  self enable_player_influencers(0);
  level create_friendly_influencer("friend_dead", self.origin, self.team);
}

function onteamchange() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("killteamchangemonitor");
  while(true) {
    self waittill("joined_team");
    self player_influencers_set_team();
    wait(0.05);
  }
}

function ongrenadethrow() {
  self endon("disconnect");
  self endon("killgrenademonitor");
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

function create_entity_friendly_influencer(name) {
  team_mask = self get_friendly_team_mask();
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
    other_team_mask = level.spawnsystem.ispawn_teammask_free;
    weapon_team_mask = level.spawnsystem.ispawn_teammask_free;
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
    function_db51ac16(team);
  }
  foreach(team in level.teams) {
    if(level.unified_spawn_points[team].a.size > 254) {
      level.unified_spawn_points[team].b = array::clamp_size(array::randomize(level.unified_spawn_points[team].a), 254);
      continue;
    }
    level.unified_spawn_points[team].b = level.unified_spawn_points[team].a;
  }
  clearspawnpoints();
  if(level.teambased) {
    foreach(team in level.teams) {
      addspawnpoints(team, level.unified_spawn_points[team].b);
    }
  } else {
    foreach(team in level.teams) {
      addspawnpoints("free", level.unified_spawn_points[team].b);
    }
  }
}

function onspawnplayer_unified(predictedspawn = 0) {
  if(getdvarint("") != 0) {
    spawn_point = get_debug_spawnpoint(self);
    self spawn(spawn_point.origin, spawn_point.angles);
    return;
  }
  use_new_spawn_system = 1;
  initial_spawn = 1;
  if(isDefined(self.uspawn_already_spawned)) {
    initial_spawn = !self.uspawn_already_spawned;
  }
  if(level.usestartspawns) {
    use_new_spawn_system = 0;
  }
  if(level.gametype == "sd") {
    use_new_spawn_system = 0;
  }
  util::set_dvar_if_unset("scr_spawn_force_unified", "0");
  spawnoverride = self tacticalinsertion::overridespawn(predictedspawn);
  if(use_new_spawn_system || getdvarint("scr_spawn_force_unified") != 0) {
    if(!spawnoverride) {
      spawn_point = getspawnpoint(self, predictedspawn);
      if(isDefined(spawn_point)) {
        origin = spawn_point["origin"];
        angles = spawn_point["angles"];
        if(predictedspawn) {
          self predictspawnpoint(origin, angles);
        } else {
          level create_enemy_influencer("enemy_spawn", origin, self.pers["team"]);
          self spawn(origin, angles);
        }
      } else {
        println("");
        callback::abort_level();
      }
    } else if(predictedspawn && isDefined(self.tacticalinsertion)) {
      self predictspawnpoint(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
    }
    if(!predictedspawn) {
      self.lastspawntime = gettime();
      self enable_player_influencers(1);
    }
  } else if(!spawnoverride) {
    [[level.onspawnplayer]](predictedspawn);
  }
  if(!predictedspawn) {
    self.uspawn_already_spawned = 1;
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
  if(level.teambased && isDefined(game["switchedsides"]) && game["switchedsides"] && level.spawnsystem.unifiedsideswitching) {
    point_team = util::getotherteam(point_team);
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
      spawn_counts = spawn_counts + level.unified_spawn_points[team].a.size;
    }
    if(level.test_spawn_point_index >= spawn_counts) {
      level.test_spawn_point_index = 0;
    }
    count = 0;
    foreach(team in level.teams) {
      size = level.unified_spawn_points[team].a.size;
      if(level.test_spawn_point_index < (count + size)) {
        return level.unified_spawn_points[team].a[level.test_spawn_point_index - count];
      }
      count = count + size;
    }
  } else {
    if(level.test_spawn_point_index >= level.unified_spawn_points[team].a.size) {
      level.test_spawn_point_index = 0;
    }
    return level.unified_spawn_points[team].a[level.test_spawn_point_index];
  }
}

function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn) {
  if(level.teambased) {
    vis_team_mask = util::getotherteamsmask(player.pers["team"]);
  } else {
    vis_team_mask = level.spawnsystem.ispawn_teammask_free;
  }
  spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn);
  if(!predictedspawn) {
    bbprint("mpspawnpointsused", "reason %s x %d y %d z %d", "point used", spawn_point["origin"]);
  }
  return spawn_point;
}

function function_db51ac16(player_team) {
  if(!isDefined(level.unified_spawn_points)) {
    level.unified_spawn_points = [];
  } else if(isDefined(level.unified_spawn_points[player_team])) {
    return level.unified_spawn_points[player_team];
  }
  spawn_entities_s = util::spawn_array_struct();
  spawn_entities_s.a = spawnlogic::get_team_spawnpoints(player_team);
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
    return 1;
  }
  return team1 != "neutral" && team2 != "neutral" && team1 != team2;
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
  level.unified_spawn_points = undefined;
  updateallspawnpoints();
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