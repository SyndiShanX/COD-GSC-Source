/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spawning.gsc
*****************************************************/

#include maps\mp\_utility;
#include maps\mp\_geometry;

init() {
  level init_spawn_system();
  level.teams = [];
  level.teams[0] = "allies";
  level.teams[1] = "axis";
  level.recently_deceased = [];
  for(iTeam = 0; iTeam < level.teams.size; iTeam++) {
    level.recently_deceased[level.teams[iTeam]] = spawn_array_struct();
  }
  level thread onPlayerConnect();
  if(getdvar("scr_spawn_visibility_check_max") == "") {
    SetDvar("scr_spawn_visibility_check_max", 35);
  }
  if(getdvar("scr_ignore_spawn_visibility_check_max") == "") {
    SetDvar("scr_ignore_spawn_visibility_check_max", 0);
  }
  level.spawn_visibility_check_max = getdvarint("scr_spawn_visibility_check_max");
  level.ignore_spawn_visibility_check_max = getdvarint("scr_ignore_spawn_visibility_check_max");
  SetDvar("scr_debug_spawn_player", "");
  SetDvar("scr_debug_render_spawn_data", "1");
  SetDvar("scr_debug_render_snapshotmode", "0");
  SetDvar("scr_spawn_point_test_mode", "0");
  level.test_spawn_point_index = 0;
  SetDvar("scr_debug_render_spawn_text", "1");
  return;
}

init_spawn_system() {
  level.spawnsystem = spawnStruct();
  spawnsystem = level.spawnsystem;
  level thread initialize_player_spawning_dvars();
  spawnsystem.eINFLUENCER_SHAPE_SPHERE = 0;
  spawnsystem.eINFLUENCER_SHAPE_CYLINDER = 1;
  spawnsystem.eINFLUENCER_TYPE_NORMAL = 0;
  spawnsystem.eINFLUENCER_TYPE_PLAYER = 1;
  spawnsystem.eINFLUENCER_TYPE_WEAPON = 2;
  spawnsystem.eINFLUENCER_TYPE_DOG = 3;
  spawnsystem.eINFLUENCER_TYPE_VEHICLE = 4;
  spawnsystem.eINFLUENCER_TYPE_SQUAD = 5;
  spawnsystem.eINFLUENCER_TYPE_GAME_MODE = 6;
  spawnsystem.eINFLUENCER_CURVE_CONSTANT = 0;
  spawnsystem.eINFLUENCER_CURVE_LINEAR = 1;
  spawnsystem.eINFLUENCER_CURVE_INVERSE_LINEAR = 2;
  spawnsystem.eINFLUENCER_CURVE_NEGATIVE_TO_POSITIVE = 3;
  spawnsystem.iSPAWN_TEAMMASK_FREE = 1;
  spawnsystem.iSPAWN_TEAMMASK_AXIS = 2;
  spawnsystem.iSPAWN_TEAMMASK_ALLIES = 4;
}

onPlayerConnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connecting", player);
    player thread onPlayerSpawned();
    player thread onDisconnect();
    player thread onTeamChange();
    player thread onGrenadeThrow();
    player thread onSquadLeaderChange();
  }
}

onPlayerSpawned() {
  self endon("disconnect");
  level endon("game_ended");
  created_influencers = false;
  for(;;) {
    self waittill("spawned_player");
    if(!created_influencers) {
      self create_player_influencers();
      created_influencers = true;
    }
    self enable_player_influencers(true);
    self thread onDeath();
  }
}

onDeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  self enable_player_influencers(false);
  self create_body_influencers();
}

onTeamChange() {
  self endon("disconnect");
  level endon("game_ended");
  while(1) {
    self waittill("joined_team");
    self player_influencers_set_team();
    wait(0.05);
  }
}

onSquadLeaderChange() {
  self endon("disconnect");
  level endon("game_ended");
  while(1) {
    self waittill("squadleader_changed", squad_id, is_leader);
    if(isDefined(self.spawn_influencers_created)) {
      if(is_leader) {
        self create_squad_influencers();
      } else {
        self remove_squad_influencers();
      }
    }
    wait(0.05);
  }
}

onGrenadeThrow() {
  self endon("disconnect");
  level endon("game_ended");
  while(1) {
    self waittill("grenade_fire", grenade, weaponName);
    grenade create_grenade_influencers(self.pers["team"], weaponName);
    wait(0.05);
  }
}

onDisconnect() {
  level endon("game_ended");
  self waittill("disconnect");
}

get_team_mask(team) {
  if(!level.teambased || !isDefined(team))
    return level.spawnsystem.iSPAWN_TEAMMASK_FREE;
  switch (team) {
    case "axis":
      return level.spawnsystem.iSPAWN_TEAMMASK_AXIS;
    case "allies":
      return level.spawnsystem.iSPAWN_TEAMMASK_ALLIES;
    case "all":
      return (level.spawnsystem.iSPAWN_TEAMMASK_FREE | level.spawnsystem.iSPAWN_TEAMMASK_AXIS | level.spawnsystem.iSPAWN_TEAMMASK_ALLIES);
    case "free":
    default:
      return level.spawnsystem.iSPAWN_TEAMMASK_FREE;
  }
}

get_score_curve_index(curve) {
  switch (curve) {
    case "linear":
      return level.spawnsystem.eINFLUENCER_CURVE_LINEAR;
    case "inverse_linear":
      return level.spawnsystem.eINFLUENCER_CURVE_LINEAR;
    case "negative_to_positive":
      return level.spawnsystem.eINFLUENCER_CURVE_NEGATIVE_TO_POSITIVE;
    case "constant":
    default:
      return level.spawnsystem.eINFLUENCER_CURVE_CONSTANT;
  }
}

get_influencer_type_index(curve) {}

create_player_influencers() {
  assert(!isDefined(self.influencer_enemy_sphere));
  assert(!isDefined(self.influencer_weapon_cylinder));
  assert(!level.teambased || !isDefined(self.influencer_friendly_sphere));
  assert(!level.teambased || !isDefined(self.influencer_friendly_cylinder));
  if(!level.teambased) {
    team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
    other_team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
    weapon_team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
  } else if(isDefined(self.pers["team"])) {
    team_mask = get_team_mask(self.pers["team"]);
    other_team_mask = get_team_mask(getotherteam(self.pers["team"]));
    weapon_team_mask = get_team_mask(getotherteam(self.pers["team"]));
  } else {
    team_mask = 0;
    other_team_mask = 0;
    weapon_team_mask = 0;
  }
  if(level.friendlyfire) {
    weapon_team_mask |= team_mask;
  }
  angles = self.angles;
  origin = self.origin;
  up = (0, 0, 1);
  forward = (1, 0, 0);
  cylinder_forward = up;
  cylinder_up = forward;
  self.influencer_enemy_sphere = addsphereinfluencer(level.spawnsystem.eINFLUENCER_TYPE_PLAYER, origin, level.spawnsystem.enemy_influencer_radius, level.spawnsystem.enemy_influencer_score, other_team_mask, get_score_curve_index(level.spawnsystem.enemy_influencer_score_curve), 0, self);
  self.influencer_weapon_cylinder = addcylinderinfluencer(level.spawnsystem.eINFLUENCER_TYPE_WEAPON, origin, cylinder_forward, cylinder_up, level.spawnsystem.weapon_influencer_radius, level.spawnsystem.weapon_influencer_length, level.spawnsystem.weapon_influencer_score, weapon_team_mask, get_score_curve_index(level.spawnsystem.weapon_influencer_score_curve), 0, self);
  if(level.teambased) {
    cylinder_up = -1.0 * forward;
    self.influencer_friendly_sphere = addsphereinfluencer(level.spawnsystem.eINFLUENCER_TYPE_PLAYER, origin, level.spawnsystem.friend_weak_influencer_radius, level.spawnsystem.friend_weak_influencer_score, team_mask, get_score_curve_index(level.spawnsystem.friend_weak_influencer_score_curve), 0, self);
    self.influencer_friendly_cylinder = addcylinderinfluencer(level.spawnsystem.eINFLUENCER_TYPE_PLAYER, origin, cylinder_forward, cylinder_up, level.spawnsystem.friend_strong_influencer_radius, level.spawnsystem.friend_strong_influencer_length, level.spawnsystem.friend_strong_influencer_score, team_mask, get_score_curve_index(level.spawnsystem.friend_strong_influencer_score_curve), 0, self);
    if(IsSquadLeader(self)) {
      create_squad_influencers();
    }
  }
  self.spawn_influencers_created = true;
  if(!isDefined(self.pers["team"]) || self.pers["team"] == "spectator") {
    self enable_player_influencers(false);
  }
}

remove_player_influencers() {
  if(level.teambased && isDefined(self.influencer_friendly_sphere)) {
    removeinfluencer(self.influencer_friendly_sphere);
    self.influencer_friendly_sphere = undefined;
  }
  if(level.teambased && isDefined(self.influencer_friendly_cylinder)) {
    removeinfluencer(self.influencer_friendly_cylinder);
    self.influencer_friendly_cylinder = undefined;
  }
  if(isDefined(self.influencer_enemy_sphere)) {
    removeinfluencer(self.influencer_enemy_sphere);
    self.influencer_enemy_sphere = undefined;
  }
  if(isDefined(self.influencer_weapon_cylinder)) {
    removeinfluencer(self.influencer_weapon_cylinder);
    self.influencer_weapon_cylinder = undefined;
  }
  self remove_squad_influencers();
}

enable_player_influencers(enabled) {
  if(isDefined(self.influencer_friendly_sphere))
    enableinfluencer(self.influencer_friendly_sphere, enabled);
  if(isDefined(self.influencer_friendly_cylinder))
    enableinfluencer(self.influencer_friendly_cylinder, enabled);
  if(isDefined(self.influencer_enemy_sphere))
    enableinfluencer(self.influencer_enemy_sphere, enabled);
  if(isDefined(self.influencer_weapon_cylinder))
    enableinfluencer(self.influencer_weapon_cylinder, enabled);
  if(isDefined(self.influencer_squad))
    enableinfluencer(self.influencer_squad, enabled);
}

player_influencers_set_team() {
  if(!level.teambased) {
    team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
    other_team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
    weapon_team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
  } else {
    team = self.pers["team"];
    team_mask = get_team_mask(team);
    other_team_mask = get_team_mask(getotherteam(team));
    weapon_team_mask = get_team_mask(getotherteam(team));
  }
  if(level.friendlyfire != 0 && level.teamBased) {
    weapon_team_mask |= team_mask;
  }
  if(isDefined(self.influencer_friendly_sphere))
    setinfluencerteammask(self.influencer_friendly_sphere, team_mask);
  if(isDefined(self.influencer_friendly_cylinder))
    setinfluencerteammask(self.influencer_friendly_cylinder, team_mask);
  if(isDefined(self.influencer_enemy_sphere))
    setinfluencerteammask(self.influencer_enemy_sphere, other_team_mask);
  if(isDefined(self.influencer_weapon_cylinder))
    setinfluencerteammask(self.influencer_weapon_cylinder, weapon_team_mask);
  if(isDefined(self.influencer_squad))
    setinfluencerteammask(self.influencer_squad, team_mask);
}

create_squad_influencers() {
  if(level.teambased && !isDefined(self.influencer_squad)) {
    team_mask = get_team_mask(self.pers["team"]);
    self.influencer_squad = addsphereinfluencer(level.spawnsystem.eINFLUENCER_TYPE_SQUAD, self.origin, level.spawnsystem.squad_leader_influencer_radius, level.spawnsystem.squad_leader_influencer_score, team_mask, get_score_curve_index(level.spawnsystem.squad_leader_influencer_score_curve), 0, self);
  }
}

remove_squad_influencers() {
  if(isDefined(self.influencer_squad)) {
    removeinfluencer(self.influencer_squad);
    self.influencer_squad = undefined;
  }
}

create_body_influencers() {
  if(level.teambased) {
    team_mask = get_team_mask(self.pers["team"]);
  } else {
    team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
  }
  addsphereinfluencer(level.spawnsystem.eINFLUENCER_TYPE_NORMAL, self.origin, level.spawnsystem.dead_friend_influencer_radius, level.spawnsystem.dead_friend_influencer_score, team_mask, get_score_curve_index(level.spawnsystem.dead_friend_influencer_score_curve), level.spawnsystem.dead_friend_influencer_timeout_seconds);
}

create_grenade_influencers(parent_team, weaponName) {
  if(!level.teambased) {
    weapon_team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
  } else {
    weapon_team_mask = get_team_mask(getotherteam(parent_team));
    if(level.friendlyfire) {
      weapon_team_mask |= get_team_mask(parent_team);
    }
  }
  if(issubstr(weaponName, "napalmblob") || issubstr(weaponName, "gl_")) {
    return;
  }
  timeout = 0;
  if(weaponName == "tabun_gas_mp" || weaponName == "molotov_mp") {
    timeout = 7.0;
  }
  addsphereinfluencer(level.spawnsystem.eINFLUENCER_TYPE_NORMAL, self.origin, level.spawnsystem.grenade_influencer_radius, level.spawnsystem.grenade_influencer_score, weapon_team_mask, get_score_curve_index(level.spawnsystem.grenade_influencer_score_curve), timeout, self);
}

create_dog_influencers() {
  if(!level.teambased) {
    dog_enemy_team_mask = level.spawnsystem.iSPAWN_TEAMMASK_FREE;
  } else {
    dog_enemy_team_mask = get_team_mask(getotherteam(self.aiteam));
  }
  addsphereinfluencer(level.spawnsystem.eINFLUENCER_TYPE_DOG, self.origin, level.spawnsystem.dog_influencer_radius, level.spawnsystem.dog_influencer_score, dog_enemy_team_mask, get_score_curve_index(level.spawnsystem.dog_influencer_score_curve), 0, self);
}

create_artillery_influencers(point, radius) {
  weapon_team_mask = 0;
  return addsphereinfluencer(level.spawnsystem.eINFLUENCER_TYPE_NORMAL, point, radius, level.spawnsystem.artillery_influencer_score, weapon_team_mask, get_score_curve_index(level.spawnsystem.artillery_influencer_score_curve));
}

create_vehicle_influencers() {
  weapon_team_mask = 0;
  vehicleRadius = 144;
  cylinderLength = level.spawnsystem.vehicle_influencer_lead_seconds;
  up = (0, 0, 1);
  forward = (1, 0, 0);
  cylinder_forward = up;
  cylinder_up = forward;
  return addcylinderinfluencer(level.spawnsystem.eINFLUENCER_TYPE_VEHICLE, self.origin, cylinder_forward, cylinder_up, vehicleRadius, cylinderLength, level.spawnsystem.vehicle_influencer_score, weapon_team_mask, get_score_curve_index(level.spawnsystem.vehicle_influencer_score_curve), 0, self);
}

create_map_placed_influencers() {
  staticInfluencerEnts = getEntArray("mp_uspawn_influencer", "classname");
  for(i = 0; i < staticInfluencerEnts.size; i++) {
    staticInfluencerEnt = staticInfluencerEnts[i];
    if(isDefined(staticInfluencerEnt.script_gameobjectname) && staticInfluencerEnt.script_gameobjectname == "twar") {
      continue;
    }
    create_map_placed_influencer(staticInfluencerEnt);
  }
}

create_map_placed_influencer(influencer_entity, optional_score_override) {
  influencer_id = -1;
  if(isDefined(influencer_entity.script_shape) && isDefined(influencer_entity.script_score) && isDefined(influencer_entity.script_score_curve)) {
    switch (influencer_entity.script_shape) {
      case "sphere": {
        if(isDefined(influencer_entity.radius)) {
          if(isDefined(optional_score_override)) {
            score = optional_score_override;
          } else {
            score = influencer_entity.script_score;
          }
          influencer_id = addsphereinfluencer(level.spawnsystem.eINFLUENCER_TYPE_GAME_MODE, influencer_entity.origin, influencer_entity.radius, score, get_team_mask(influencer_entity.script_team), get_score_curve_index(influencer_entity.script_score_curve));
        } else {
          assertmsg("Radiant-placed sphere spawn influencers require 'radius' parameter");
        }
        break;
      }
      case "cylinder": {
        if(isDefined(influencer_entity.radius) && isDefined(influencer_entity.height)) {
          if(isDefined(optional_score_override)) {
            score = optional_score_override;
          } else {
            score = influencer_entity.script_score;
          }
          influencer_id = addcylinderinfluencer(level.spawnsystem.eINFLUENCER_TYPE_GAME_MODE, influencer_entity.origin, anglesToForward(influencer_entity.angles), AnglesToUp(influencer_entity.angles), influencer_entity.radius, influencer_entity.height, score, get_team_mask(influencer_entity.script_team), get_score_curve_index(influencer_entity.script_score_curve));
        } else {
          assertmsg("Radiant-placed cylinder spawn influencers require 'radius' and 'height' parameters");
        }
        break;
      }
      default: {
        assertmsg("Unsupported script_shape value (\"" + influencer_entity.script_shape + "\") for unified spawning system static influencer.Supported shapes are \"cylinder\" and \"sphere\".");
        break;
      }
    }
  } else {
    assertmsg("Radiant-placed spawn influencers require 'script_shape', 'script_score' and 'script_score_curve' parameters");
  }
  return influencer_id;
}

updateAllSpawnPoints() {
  gatherSpawnEntities("allies");
  gatherSpawnEntities("axis");
  clearspawnpoints();
  if(level.teambased) {
    addspawnpoints("allies", level.unified_spawn_points["allies"].a);
    addspawnpoints("axis", level.unified_spawn_points["axis"].a);
  } else {
    addspawnpoints("free", level.unified_spawn_points["allies"].a);
    addspawnpoints("free", level.unified_spawn_points["axis"].a);
  }
  remove_unused_spawn_entities();
}

set_dvar_if_unset(dvar, value) {
  if(GetDvar(dvar) == "") {
    SetDvar(dvar, value);
    return value;
  }
  return GetDvar(dvar);
}

set_dvar_float_if_unset(dvar, value) {
  if(GetDvar(dvar) == "") {
    SetDvar(dvar, value);
  }
  return GetDvarFloat(dvar);
}

set_dvar_int_if_unset(dvar, value) {
  if(GetDvar(dvar) == "") {
    SetDvar(dvar, value);
    return int(value);
  }
  return GetDvarInt(dvar);
}

initialize_player_spawning_dvars() {
  while(1) {
    get_player_spawning_dvars();
    wait(2);
  }
}

get_player_spawning_dvars() {
  k_player_height = get_player_height();
  player_height_times_10 = "" + 10.0 * k_player_height;
  ss = level.spawnsystem;
  player_influencer_radius = 15.0 * k_player_height;
  player_influencer_score = 150.0;
  dog_influencer_radius = 15.0 * k_player_height;
  dog_influencer_score = 150.0;
  ss.script_based_influencer_system = set_dvar_int_if_unset("scr_script_based_influencer_system", "0");
  ss.randomness_range = set_dvar_float_if_unset("scr_spawn_randomness_range", "50");
  ss.objective_facing_bonus = set_dvar_float_if_unset("scr_spawn_objective_facing_bonus", "50");
  ss.friend_strong_influencer_score = set_dvar_float_if_unset("scr_spawn_friend_strong_influencer_score", "175");
  ss.friend_strong_influencer_score_curve = set_dvar_if_unset("scr_spawn_friend_strong_influencer_score_curve", "linear");
  ss.friend_strong_influencer_radius = set_dvar_float_if_unset("scr_spawn_friend_strong_influencer_radius", player_height_times_10);
  ss.friend_strong_influencer_length = set_dvar_float_if_unset("scr_spawn_friend_strong_influencer_length", "" + 15 * k_player_height);
  ss.friend_weak_influencer_score = set_dvar_float_if_unset("scr_spawn_friend_weak_influencer_score", "75");
  ss.friend_weak_influencer_score_curve = set_dvar_if_unset("scr_spawn_friend_weak_influencer_score_curve", "linear");
  ss.friend_weak_influencer_radius = set_dvar_float_if_unset("scr_spawn_friend_weak_influencer_radius", player_height_times_10);
  ss.squad_leader_influencer_score = set_dvar_float_if_unset("scr_spawn_squad_leader_influencer_score", "150");
  ss.squad_leader_influencer_score_curve = set_dvar_if_unset("scr_spawn_squad_leader_influencer_score_curve", "linear");
  ss.squad_leader_influencer_radius = set_dvar_float_if_unset("scr_spawn_squad_leader_influencer_radius", player_height_times_10);
  ss.enemy_influencer_score = set_dvar_float_if_unset("scr_spawn_enemy_influencer_score", "-150");
  ss.enemy_influencer_score_curve = set_dvar_if_unset("scr_spawn_enemy_influencer_score_curve", "linear");
  ss.enemy_influencer_radius = set_dvar_float_if_unset("scr_spawn_enemy_influencer_radius", "" + player_influencer_radius);
  ss.weapon_influencer_score = set_dvar_float_if_unset("scr_spawn_weapon_influencer_score", "-400");
  ss.weapon_influencer_score_curve = set_dvar_if_unset("scr_spawn_weapon_influencer_score_curve", "linear");
  ss.weapon_influencer_radius = set_dvar_float_if_unset("scr_spawn_weapon_influencer_radius", "" + 5.0 * k_player_height);
  ss.weapon_influencer_length = set_dvar_float_if_unset("scr_spawn_weapon_influencer_length", "" + 25.0 * k_player_height);
  ss.dead_friend_influencer_timeout_seconds = set_dvar_float_if_unset("scr_spawn_dead_friend_influencer_timeout_seconds", "20");
  ss.dead_friend_influencer_count = set_dvar_float_if_unset("scr_spawn_dead_friend_influencer_count", "7");
  ss.dead_friend_influencer_score = set_dvar_float_if_unset("scr_spawn_dead_friend_influencer_score", "-100");
  ss.dead_friend_influencer_score_curve = set_dvar_if_unset("scr_spawn_dead_friend_influencer_score_curve", "linear");
  ss.dead_friend_influencer_radius = set_dvar_float_if_unset("scr_spawn_dead_friend_influencer_radius", player_height_times_10);
  ss.vehicle_influencer_score = set_dvar_float_if_unset("scr_spawn_vehicle_influencer_score", "-50");
  ss.vehicle_influencer_score_curve = set_dvar_if_unset("scr_spawn_vehicle_influencer_score_curve", "linear");
  ss.vehicle_influencer_lead_seconds = set_dvar_float_if_unset("scr_spawn_vehicle_influencer_lead_seconds", "3");
  ss.dog_influencer_score = set_dvar_float_if_unset("scr_spawn_dog_influencer_score", "-300");
  ss.dog_influencer_score_curve = set_dvar_if_unset("scr_spawn_dog_influencer_score_curve", "linear");
  ss.dog_influencer_radius = set_dvar_float_if_unset("scr_spawn_dog_influencer_radius", "" + dog_influencer_radius);
  ss.artillery_influencer_score = set_dvar_float_if_unset("scr_spawn_artillery_influencer_score", "-800");
  ss.artillery_influencer_score_curve = set_dvar_if_unset("scr_spawn_artillery_influencer_score_curve", "linear");
  ss.grenade_influencer_score = set_dvar_float_if_unset("scr_spawn_grenade_influencer_score", "-500");
  ss.grenade_influencer_score_curve = set_dvar_if_unset("scr_spawn_grenade_influencer_score_curve", "linear");
  ss.grenade_influencer_radius = set_dvar_float_if_unset("scr_spawn_grenade_influencer_radius", "" + 8.0 * k_player_height);
  ss.twar_linked_flag_influencer_score = set_dvar_float_if_unset("scr_spawn_twar_linked_flag_influencer_score", "200");
  ss.twar_linked_flag_near_objective_bonus = set_dvar_float_if_unset("scr_spawn_twar_linked_flag_near_objective_bonus", "50");
  ss.twar_linked_flag_influencer_score_falloff_percentage = set_dvar_float_if_unset("scr_spawn_twar_linked_flag_influencer_score_falloff_percentage", "0.2");
  ss.twar_contested_flag_influencer_score = set_dvar_float_if_unset("scr_spawn_twar_contested_flag_influencer_score", "-500.0");
  ss.twar_contested_flag_influencer_score_curve = set_dvar_if_unset("scr_spawn_twar_contested_flag_influencer_score_curve", "constant");
  ss.twar_contested_flag_influencer_radius = set_dvar_float_if_unset("scr_spawn_twar_contested_flag_influencer_radius", "" + 15.0 * k_player_height);
  ss.dom_owned_outer_flag_influencer_score = set_dvar_float_if_unset("scr_spawn_dom_owned_outer_flag_influencer_score", "100");
  ss.dom_owned_outer_flag_influencer_score_curve = set_dvar_if_unset("scr_spawn_dom_owned_outer_flag_influencer_score_curve", "constant");
  ss.dom_owned_outer_flag_influencer_radius = set_dvar_float_if_unset("scr_spawn_dom_owned_outer_flag_influencer_radius", "" + 15.0 * k_player_height);
  ss.dom_owned_inner_flag_influencer_score = set_dvar_float_if_unset("scr_spawn_dom_owned_inner_flag_influencer_score", "150");
  ss.dom_owned_inner_flag_influencer_score_curve = set_dvar_if_unset("scr_spawn_dom_owned_inner_flag_influencer_score_curve", "constant");
  ss.dom_owned_inner_flag_influencer_radius = set_dvar_float_if_unset("scr_spawn_dom_owned_inner_flag_influencer_radius", "" + 15.0 * k_player_height);
  ss.dom_enemy_flag_influencer_score = set_dvar_float_if_unset("scr_spawn_dom_enemy_flag_influencer_score", "-500");
  ss.dom_enemy_flag_influencer_score_curve = set_dvar_if_unset("scr_spawn_dom_enemy_flag_influencer_score_curve", "constant");
  ss.dom_enemy_flag_influencer_radius = set_dvar_float_if_unset("scr_spawn_dom_enemy_flag_influencer_radius", "" + 15.0 * k_player_height);
  ss.dom_unowned_inner_flag_influencer_score = set_dvar_float_if_unset("scr_spawn_dom_unowned_inner_flag_influencer_score", "-500");
  ss.dom_unowned_inner_flag_influencer_score_curve = set_dvar_if_unset("scr_spawn_dom_unowned_inner_flag_influencer_score_curve", "constant");
  ss.dom_unowned_inner_flag_influencer_radius = set_dvar_float_if_unset("scr_spawn_dom_unowned_inner_flag_influencer_radius", "" + 15.0 * k_player_height);
  ss.koth_objective_influencer_score = set_dvar_float_if_unset("scr_spawn_koth_objective_influencer_score", "150");
  ss.koth_objective_influencer_score_curve = set_dvar_if_unset("scr_spawn_koth_objective_influencer_score_curve", "negative_to_positive");
  ss.koth_objective_influencer_radius = set_dvar_float_if_unset("scr_spawn_koth_objective_influencer_radius", "" + 35.0 * k_player_height);
  ss.sab_friendly_base_influencer_score = set_dvar_float_if_unset("scr_spawn_sab_friendly_base_influencer_score", "100");
  ss.sab_friendly_base_influencer_score_curve = set_dvar_if_unset("scr_spawn_sab_friendly_base_influencer_score_curve", "constant");
  ss.sab_friendly_base_influencer_radius = set_dvar_float_if_unset("scr_spawn_sab_friendly_base_influencer_radius", "" + 15.0 * k_player_height);
  ss.sab_enemy_base_influencer_score = set_dvar_float_if_unset("scr_spawn_sab_enemy_base_influencer_score", "-500");
  ss.sab_enemy_base_influencer_score_curve = set_dvar_if_unset("scr_spawn_sab_enemy_base_influencer_score_curve", "constant");
  ss.sab_enemy_base_influencer_radius = set_dvar_float_if_unset("scr_spawn_sab_enemy_base_influencer_radius", "" + 15.0 * k_player_height);
  ss.sab_carrier_influencer_score = set_dvar_float_if_unset("scr_spawn_sab_carrier_influencer_score", "-175");
  ss.sab_carrier_influencer_score_curve = set_dvar_if_unset("scr_spawn_sab_carrier_influencer_score_curve", "linear");
  ss.sab_carrier_influencer_radius = set_dvar_float_if_unset("scr_spawn_sab_carrier_influencer_radius", "" + 15.0 * k_player_height);
  ss.ctf_friendly_base_influencer_score = set_dvar_float_if_unset("scr_spawn_ctf_friendly_base_influencer_score", "0");
  ss.ctf_friendly_base_influencer_score_curve = set_dvar_if_unset("scr_spawn_ctf_friendly_base_influencer_score_curve", "constant");
  ss.ctf_friendly_base_influencer_radius = set_dvar_float_if_unset("scr_spawn_ctf_friendly_base_influencer_radius", "" + 15.0 * k_player_height);
  ss.ctf_enemy_base_influencer_score = set_dvar_float_if_unset("scr_spawn_ctf_enemy_base_influencer_score", "-500");
  ss.ctf_enemy_base_influencer_score_curve = set_dvar_if_unset("scr_spawn_ctf_enemy_base_influencer_score_curve", "constant");
  ss.ctf_enemy_base_influencer_radius = set_dvar_float_if_unset("scr_spawn_ctf_enemy_base_influencer_radius", "" + 15.0 * k_player_height);
  ss.ctf_carrier_influencer_score = set_dvar_float_if_unset("scr_spawn_ctf_carrier_influencer_score", "-200");
  ss.ctf_carrier_influencer_score_curve = set_dvar_if_unset("scr_spawn_ctf_carrier_influencer_score_curve", "constant");
  ss.ctf_carrier_influencer_radius = set_dvar_float_if_unset("scr_spawn_ctf_carrier_influencer_radius", "" + 15 * k_player_height);
  setspawnpointrandomvariation(ss.randomness_range);
}

level_use_unified_spawning(use) {}

onSpawnPlayer_Unified() {
  prof_begin("onSpawnPlayer_Unified");
  if(GetDvarInt("scr_spawn_point_test_mode") != 0) {
    spawn_point = get_debug_spawnpoint(self);
    self spawn(spawn_point.origin, spawn_point.angles);
    return;
  }
  use_new_spawn_system = true;
  initial_spawn = true;
  if(isDefined(self.uspawn_already_spawned)) {
    initial_spawn = !self.uspawn_already_spawned;
  }
  if(level.useStartSpawns) {
    use_new_spawn_system = false;
  }
  if(level.gametype == "sd") {
    use_new_spawn_system = false;
  }
  if(use_new_spawn_system) {
    spawn_point = getSpawnPoint(self);
    if(isDefined(spawn_point)) {
      self.lastspawntime = gettime();
      self spawn(spawn_point.origin, spawn_point.angles);
      self enable_player_influencers(true);
    } else {
      println("ERROR: unable to locate a usable spawn point for player");
      maps\mp\gametypes\_callbacksetup::AbortLevel();
    }
  } else {
    [[level.onSpawnPlayer]]();
  }
  self.uspawn_already_spawned = true;
  prof_end("onSpawnPlayer_Unified");
  return;
}

getSpawnPoint(player_entity) {
  if(level.teambased) {
    point_team = player_entity.pers["team"];
    influencer_team = player_entity.pers["team"];
  } else {
    point_team = "free";
    influencer_team = "free";
  }
  if(level.teambased && isDefined(game["switchedsides"]) && game["switchedsides"]) {
    point_team = GetOtherTeam(point_team);
  } {
    best_spawn_entity = get_best_spawnpoint(point_team, influencer_team, player_entity);
  }
  return best_spawn_entity;
}

get_debug_spawnpoint(player) {
  if(level.teambased) {
    team = player.pers["team"];
  } else {
    team = "free";
  }
  index = level.test_spawn_point_index;
  level.test_spawn_point_index++;
  if(team == "free") {
    spawn_counts = level.unified_spawn_points["allies"].a.size;
    spawn_counts += level.unified_spawn_points["axis"].a.size;
    if(level.test_spawn_point_index >= spawn_counts) {
      level.test_spawn_point_index = 0;
    }
    if(level.test_spawn_point_index >= level.unified_spawn_points["allies"].a.size) {
      return level.unified_spawn_points["axis"].a[level.test_spawn_point_index - level.unified_spawn_points["allies"].a.size];
    } else {
      return level.unified_spawn_points["allies"].a[level.test_spawn_point_index];
    }
  } else {
    if(level.test_spawn_point_index >= level.unified_spawn_points[team].a.size) {
      level.test_spawn_point_index = 0;
    }
    return level.unified_spawn_points[team].a[level.test_spawn_point_index];
  }
}

get_best_spawnpoint(point_team, influencer_team, player) {
  scored_spawn_points = getsortedspawnpoints(point_team, influencer_team, player);
  assert(scored_spawn_points.size > 0);
  if(level.teambased) {
    other_team = GetOtherTeam(point_team);
  } else {
    other_team = "free";
  }
  best_spawn_no_sight = undefined;
  prof_begin("get_best_spawnpoint__");
  for(i = 0; i < scored_spawn_points.size; i++) {
    scored_spawn = scored_spawn_points[i];
    if(PositionWouldTelefrag(scored_spawn_points[i].origin)) {
      continue;
    }
    if(!isDefined(best_spawn_no_sight)) {
      best_spawn_no_sight = scored_spawn_points[i];
    }
    if(level.spawn_visibility_check_max <= i && !level.ignore_spawn_visibility_check_max) {
      return best_spawn_no_sight;
    }
    if(isspawnpointvisible(scored_spawn_points[i].origin, scored_spawn_points[i].angles, other_team, player)) {
      continue;
    }
    prof_end("get_best_spawnpoint__");
    return scored_spawn_points[i];
  }
  prof_end("get_best_spawnpoint__");
  if(isDefined(best_spawn_no_sight)) {
    return best_spawn_no_sight;
  } else {
    return scored_spawn_points[0];
  }
}

gatherSpawnEntities(player_team) {
  if(!isDefined(level.unified_spawn_points)) {
    level.unified_spawn_points = [];
  } else {
    if(isDefined(level.unified_spawn_points[player_team])) {
      return level.unified_spawn_points[player_team];
    }
  }
  spawn_entities_s = spawn_array_struct();
  spawn_entities_s.a = getEntArray("mp_uspawn_point", "classname");
  if(!isDefined(spawn_entities_s.a)) {
    spawn_entities_s.a = [];
  }
  legacy_spawn_points = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints(player_team);
  for(legacy_spawn_index = 0; legacy_spawn_index < legacy_spawn_points.size; legacy_spawn_index++) {
    spawn_entities_s.a[spawn_entities_s.a.size] = legacy_spawn_points[legacy_spawn_index];
  }
  level.unified_spawn_points[player_team] = spawn_entities_s;
  return spawn_entities_s;
}

is_hardcore() {
  return isDefined(level.hardcoreMode) && level.hardcoreMode;
}

teams_have_enmity(team1, team2) {
  if(!isDefined(team1) || !isDefined(team2) || (level.gameType == "dm"))
    return true;
  return team1 != "neutral" && team2 != "neutral" && team1 != team2;
}

remove_unused_spawn_entities() {
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
    spawnpoints = maps\mp\gametypes\_spawnlogic::getSpawnpointArray(spawn_entity_types[i]);
    delete_all_spawns(spawnpoints);
  }
}

delete_all_spawns(spawnpoints) {
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoints[i] delete();
  }
}

spawn_point_class_name_being_used(name) {
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

_create_influencer(type, shape, forward, up, origin, score, score_curve
) {
  influencer = [];
  influencer["type"] = type;
  influencer["shape"] = shape;
  influencer["forward"] = forward;
  influencer["up"] = up;
  influencer["origin"] = origin;
  influencer["score"] = score;
  influencer["score_curve"] = score_curve;
  return influencer;
}

_create_radiusaxis_influencer(type, shape, forward, up, origin, score, score_curve, radius, axis_length
) {
  radiusaxis_influencer = _create_influencer(type, shape, forward, up, origin, score, score_curve);
  radiusaxis_influencer["radius"] = radius;
  radiusaxis_influencer["axis_length"] = axis_length;
  return radiusaxis_influencer;
}

create_sphere_influencer(type, forward, up, origin, score, score_curve, radius
) {
  sphere = _create_influencer(type, "sphere", forward, up, origin, score, score_curve);
  sphere["radius"] = radius;
  return sphere;
}

create_cylinder_influencer(type, forward, up, origin, score, score_curve, radius, axis_length
) {
  return _create_radiusaxis_influencer(type, "cylinder", forward, up, origin, score, score_curve, radius, axis_length);
}