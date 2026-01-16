/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\spawning_shared.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\tacticalinsertion;

#namespace spawning;

autoexec __init__system__() {
  system::register(#"spawning_shared", &__init__, undefined, undefined);
}

__init__() {
  level init_spawn_system();
  level.spawnprotectiontime = getgametypesetting(#"spawnprotectiontime");
  level.spawnprotectiontimems = int(int((isDefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000));
  level.spawntraptriggertime = getgametypesetting(#"spawntraptriggertime");
  level.deathcirclerespawn = getgametypesetting(#"deathcirclerespawn");
  level.var_c2cc011f = getgametypesetting(#"hash_4bdd1bd86b610871");
  level.players = [];
  level.numplayerswaitingtoenterkillcam = 0;

  if(!isDefined(level.requirespawnpointstoexistinlevel)) {
    level.requirespawnpointstoexistinlevel = 1;
  }

  level.convert_spawns_to_structs = getdvarint(#"spawnsystem_convert_spawns_to_structs", 0);
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.spawnminsmaxsprimed = 0;

  if(!isDefined(level.default_spawn_lists)) {
    level.default_spawn_lists = [];
  }

  if(!isDefined(level.default_spawn_lists)) {
    level.default_spawn_lists = [];
  } else if(!isarray(level.default_spawn_lists)) {
    level.default_spawn_lists = array(level.default_spawn_lists);
  }

  level.default_spawn_lists[level.default_spawn_lists.size] = "normal";

  foreach(team, _ in level.teams) {
    level.teamspawnpoints[team] = [];
    level.spawn_point_team_class_names[team] = [];
  }

  callback::on_spawned(&on_player_spawned);
  callback::on_laststand(&on_player_laststand);
  callback::on_revived(&on_player_revived);
  callback::on_player_killed(&on_player_killed);
  level thread update_spawn_points();
  level thread update_explored_spawn_points();

  level.spawnpoint_triggers = [];
  level thread spawnpoint_debug();
}

add_default_spawnlist(spawnlist) {
  if(!isDefined(level.default_spawn_lists)) {
    level.default_spawn_lists = [];
  } else if(!isarray(level.default_spawn_lists)) {
    level.default_spawn_lists = array(level.default_spawn_lists);
  }

  level.default_spawn_lists[level.default_spawn_lists.size] = spawnlist;
}

on_player_spawned() {
  if(!self flag::exists("spawn_exploration_active")) {
    self flag::init("spawn_exploration_active", 1);
  }

  self flag::set("spawn_exploration_active");
}

on_player_laststand() {
  if(self flag::exists("spawn_exploration_active")) {
    self flag::clear("spawn_exploration_active");
  }
}

on_player_revived(params) {
  if(self flag::exists("spawn_exploration_active")) {
    self flag::set("spawn_exploration_active");
  }
}

on_player_killed() {
  if(self flag::exists("spawn_exploration_active")) {
    self flag::clear("spawn_exploration_active");
  }
}

private init_spawn_system() {
  level.spawnsystem = spawnStruct();
  spawnsystem = level.spawnsystem;

  if(!isDefined(spawnsystem.var_3709dc53)) {
    spawnsystem.var_3709dc53 = 1;
  }

  spawnsystem.objective_facing_bonus = 0;
  spawnsystem.ispawn_teammask = [];
  spawnsystem.ispawn_teammask_free = 1;
  spawnsystem.ispawn_teammask_free = 1;
  spawnsystem.ispawn_teammask[#"free"] = spawnsystem.ispawn_teammask_free;
  spawnsystem.ispawn_teammask[#"neutral"] = spawnsystem.var_146943ea;
  init_teams();
  callback::add_callback(#"init_teams", &init_teams);
}

init_teams() {
  spawnsystem = level.spawnsystem;
  all = spawnsystem.ispawn_teammask_free;
  count = 1;

  if(!isDefined(level.teams)) {
    level.teams = [];
  }

  foreach(team, _ in level.teams) {
    spawnsystem.ispawn_teammask[team] = 1 << count;
    all |= spawnsystem.ispawn_teammask[team];
    count++;
  }

  spawnsystem.ispawn_teammask[#"all"] = all;
}

updateallspawnpoints() {
  clearspawnpoints("normal");

  if(level.teambased) {
    foreach(team, _ in level.teams) {
      addspawnpoints(team, level.teamspawnpoints[team], "normal");
      enablespawnpointlist("normal", util::getteammask(team));
    }

    return;
  }

  foreach(team, _ in level.teams) {
    addspawnpoints("free", level.teamspawnpoints[team], "normal");
    enablespawnpointlist("normal", util::getteammask(team));
  }
}

update_fallback_spawnpoints() {
  clearspawnpoints("fallback");

  if(!isDefined(level.player_fallback_points)) {
    return;
  }

  if(level.teambased) {
    foreach(team, _ in level.teams) {
      addspawnpoints(team, level.player_fallback_points[team], "fallback");
    }

    return;
  }

  foreach(team, _ in level.teams) {
    addspawnpoints("free", level.player_fallback_points[team], "fallback");
  }
}

add_fallback_spawnpoints(team, point_class) {
  if(!isDefined(level.player_fallback_points)) {
    level.player_fallback_points = [];

    foreach(level_team, _ in level.teams) {
      level.player_fallback_points[level_team] = [];
    }
  }

  add_spawn_point_classname(point_class);
  spawnpoints = get_spawnpoint_array(point_class);

  for(i = spawnpoints.size - 1; i >= 0; i--) {
    if(!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects)) {
      spawnpoints[i] = undefined;
    }
  }

  arrayremovevalue(spawnpoints, undefined);
  str_team = util::get_team_mapping(team);
  level.player_fallback_points[str_team] = spawnpoints;
  enablespawnpointlist("fallback", util::getteammask(str_team));
}

function_1bc642b7() {
  if(game.switchedsides == 0) {
    return false;
  }

  if(level.spawnsystem.var_3709dc53 == 0) {
    return true;
  }

  return false;
}

add_start_spawn_points(str_team, classname) {
  str_team = util::get_team_mapping(str_team);

  if(!isDefined(level.spawn_start)) {
    level.spawn_start = [];
  }

  if(!isDefined(level.spawn_start[str_team])) {
    level.spawn_start[str_team] = [];
  }

  spawnpoints = get_spawnpoint_array(classname);
  teamforspawns = function_1bc642b7() ? util::getotherteam(str_team) : str_team;
  level.spawn_start[str_team] = arraycombine(level.spawn_start[str_team], spawnpoints, 0, 0);
}

private is_spawn_trapped(team) {
  level.spawntraptriggertime = getgametypesetting(#"spawntraptriggertime");

  if(!level.rankedmatch) {
    return false;
  }

  if(isDefined(level.alivetimesaverage) && isDefined(level.alivetimesaverage[team]) && level.alivetimesaverage[team] != 0 && level.alivetimesaverage[team] < int(level.spawntraptriggertime * 1000)) {
    return true;
  }

  return false;
}

private function_e1a7c3d9(spawn_origin, spawn_angles) {
  self predictspawnpoint(spawn_origin, spawn_angles);
  self.predicted_spawn_point = {
    #origin: spawn_origin, 
    #angles: spawn_angles
  };
}

private use_start_spawns(predictedspawn) {
  if(isDefined(level.alwaysusestartspawns) && level.alwaysusestartspawns) {
    return true;
  }

  if(!(isDefined(level.usestartspawns) && level.usestartspawns)) {
    return false;
  }

  if(level.teambased) {
    spawnteam = self.pers[#"team"];

    if(level.aliveplayers[spawnteam].size + level.spawningplayers[self.team].size >= level.spawn_start[spawnteam].size) {
      if(!predictedspawn) {
        level.usestartspawns = 0;
      }

      return false;
    }
  } else if(isDefined(level.spawn_start[#"free"]) && level.aliveplayers[#"free"].size + level.spawningplayers[#"free"].size >= level.spawn_start[#"free"].size) {
    if(!predictedspawn) {
      level.usestartspawns = 0;
    }

    return false;
  }

  return true;
}

onspawnplayer(predictedspawn = 0) {
  spawnoverride = self tacticalinsertion::overridespawn(predictedspawn);
  spawnresurrect = 0;

  if(isDefined(level.resurrect_override_spawn)) {
    spawnresurrect = self[[level.resurrect_override_spawn]](predictedspawn);
  }

  if(isDefined(self.devguilockspawn) && self.devguilockspawn) {
    spawnresurrect = 1;
  }

  spawn_origin = undefined;
  spawn_angles = undefined;

  if(spawnresurrect) {
    spawn_origin = self.resurrect_origin;
    spawn_angles = self.resurrect_angles;
  } else if(spawnoverride) {
    if(predictedspawn && isDefined(self.tacticalinsertion)) {
      self function_e1a7c3d9(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
    }

    return;
  } else if(self use_start_spawns(predictedspawn)) {
    spawnpoint = undefined;

    if(!predictedspawn) {
      if(level.teambased) {
        array::add(level.spawningplayers[self.team], self);
      } else {
        array::add(level.spawningplayers[#"free"], self);
      }
    }

    if(level.teambased) {
      spawnteam = self.pers[#"team"];

      if(game.switchedsides && level.spawnsystem.var_3709dc53) {
        spawnteam = util::getotherteam(spawnteam);
      }

      var_c162f039 = undefined;

      if(isDefined(level.var_b8622956)) {
        var_c162f039 = self[[level.var_b8622956]](level.spawn_start[spawnteam]);
      }

      if(!isDefined(var_c162f039) || !var_c162f039.size) {
        var_c162f039 = level.spawn_start[spawnteam];
      }

      spawnpoint = get_spawnpoint_random(var_c162f039, predictedspawn);
    } else {
      spawnpoint = get_spawnpoint_random(level.spawn_start[#"free"], predictedspawn);
    }

    if(isDefined(spawnpoint)) {
      spawn_origin = spawnpoint.origin;
      spawn_angles = spawnpoint.angles;
    }
  } else {
    spawn_point = getspawnpoint(self, predictedspawn);

    if(isDefined(spawn_point)) {
      spawn_origin = spawn_point[#"origin"];
      spawn_angles = spawn_point[#"angles"];
    }
  }

  if(!isDefined(spawn_origin)) {
    println("<dev string:x38>");
    callback::abort_level();
  }

  if(predictedspawn) {
    self function_e1a7c3d9(spawn_origin, spawn_angles);
    return;
  }

  self spawn(spawn_origin, spawn_angles);
  self.lastspawntime = gettime();

  if(!flag::exists("spawn_exploration_active")) {
    self flag::init("spawn_exploration_active", 1);
  }

  if(!spawnresurrect && !spawnoverride) {
    influencers::create_player_spawn_influencers(spawn_origin);
  }
}

private getspawnpoint(player_entity, predictedspawn = 0) {
  if(sessionmodeiswarzonegame()) {
    point_team = "free";
    influencer_team = player_entity.pers[#"team"];
  } else if(level.teambased) {
    point_team = player_entity.pers[#"team"];
    influencer_team = player_entity.pers[#"team"];
  } else {
    point_team = "free";
    influencer_team = "free";
  }

  if(level.teambased && isDefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_3709dc53) {
    point_team = util::getotherteam(point_team);
  }

  use_fallback_points = 0;
  spawn_trapped = is_spawn_trapped(point_team);

  if(spawn_trapped) {
    use_fallback_points = 1;
  }

  best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn, use_fallback_points);

  if(!predictedspawn) {
    player_entity.last_spawn_origin = best_spawn[#"origin"];
  }

  return best_spawn;
}

get_best_spawnpoint(point_team, influencer_team, player, predictedspawn, use_fallback_points) {
  if(level.teambased) {
    vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
  } else {
    vis_team_mask = level.spawnsystem.ispawn_teammask[#"all"];
  }

  lists = [];

  if(isDefined(level.var_811300ad) && level.var_811300ad.size) {
    lists = function_a782529(player);
  }

  if(!lists.size) {
    foreach(spawnlist in level.default_spawn_lists) {
      if(!isDefined(lists)) {
        lists = [];
      } else if(!isarray(lists)) {
        lists = array(lists);
      }

      lists[lists.size] = spawnlist;
    }

    if(use_fallback_points) {
      if(!isDefined(lists)) {
        lists = [];
      } else if(!isarray(lists)) {
        lists = array(lists);
      }

      lists[lists.size] = "fallback";
    }
  }

  spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn, lists);
  assert(isDefined(spawn_point), "<dev string:x72>");

  if(!isDefined(spawn_point)) {
    spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn, level.default_spawn_lists);
    assert(isDefined(spawn_point), "<dev string:xd9>");

    if(!isDefined(spawn_point)) {
      spawn_point = [];
      spawn_point[#"origin"] = (0, 0, 0);
      spawn_point[#"angles"] = (0, 0, 0);
    }
  }

  if(!predictedspawn) {
    var_c1c41f09 = 0;

    if(isDefined(level.playerspawnedfromspawnbeacon)) {
      var_c1c41f09 = [
        [level.playerspawnedfromspawnbeacon]
      ](player);
    }

    if(sessionmodeismultiplayergame()) {
      mpspawnpointsused = {
        #reason: "point used", 
        #var_c734ddf2: getplayerspawnid(player), 
        #x: spawn_point[#"origin"][0], 
        #y: spawn_point[#"origin"][1], 
        #z: spawn_point[#"origin"][2], 
        #var_50641dd5: var_c1c41f09
      };
      function_92d1707f(#"hash_608dde355fff78f5", mpspawnpointsused);
    }
  }

  return spawn_point;
}

private spawn_point_class_name_being_used(name) {
  if(!isDefined(level.spawn_point_class_names)) {
    return false;
  }

  if(isinarray(level.spawn_point_class_names, name)) {
    return true;
  }

  return false;
}

event_handler[spawnpoints_update] codecallback_updatespawnpoints(eventstruct) {
  foreach(team, _ in level.teams) {
    rebuild_spawn_points(team);
  }

  updateallspawnpoints();
}

private add_spawn_points_internal(team, spawnpoints, list = 0) {
  oldspawnpoints = [];

  if(level.teamspawnpoints[team].size) {
    oldspawnpoints = level.teamspawnpoints[team];
  }

  for(i = spawnpoints.size - 1; i >= 0; i--) {
    if(!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects)) {
      spawnpoints[i] = undefined;
    }
  }

  arrayremovevalue(spawnpoints, undefined);
  level.teamspawnpoints[team] = spawnpoints;

  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }

  for(index = 0; index < level.teamspawnpoints[team].size; index++) {
    spawnpoint = level.teamspawnpoints[team][index];

    if(!isDefined(spawnpoint.inited)) {
      spawnpoint spawnpoint_init();
    }

    array::add(level.spawnpoints, spawnpoint, 0);
  }

  for(index = 0; index < oldspawnpoints.size; index++) {
    origin = oldspawnpoints[index].origin;
    level.spawnmins = math::expand_mins(level.spawnmins, origin);
    level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
    array::add(level.teamspawnpoints[team], oldspawnpoints[index]);
  }
}

clear_and_add_spawn_points(str_team, classnames, ...) {
  str_team = util::get_team_mapping(str_team);
  assert(vararg.size % 2 == 0, "<dev string:x144>");
  clear_spawn_points();
  team_array = array(str_team);
  classnames_array = array(classnames);

  for(index = 0; index < vararg.size; index++) {
    if(index % 2 == 0) {
      if(!isDefined(team_array)) {
        team_array = [];
      } else if(!isarray(team_array)) {
        team_array = array(team_array);
      }

      team_array[team_array.size] = util::get_team_mapping(vararg[index]);
      continue;
    }

    if(!isDefined(classnames_array)) {
      classnames_array = [];
    } else if(!isarray(classnames_array)) {
      classnames_array = array(classnames_array);
    }

    classnames_array[classnames_array.size] = vararg[index];
  }

  for(team_index = 0; team_index < team_array.size; team_index++) {
    for(classname_index = 0; classname_index < classnames_array[team_index].size; classname_index++) {
      add_spawn_points(team_array[team_index], classnames_array[team_index][classname_index]);
    }
  }
}

clear_spawn_points() {
  foreach(team, _ in level.teams) {
    level.teamspawnpoints[team] = [];
    level.spawn_start[team] = [];
    level.spawn_point_team_class_names[team] = [];
  }

  level.spawnpoints = [];
}

private update_spawn_points() {
  while(true) {
    level flagsys::wait_till("spawnpoints_dirty");

    foreach(team, _ in level.teams) {
      rebuild_spawn_points(team);
    }

    updateallspawnpoints();
    level flagsys::clear(#"spawnpoints_dirty");
    waitframe(1);
  }
}

private update_explored_spawn_points() {
  level flagsys::wait_till("spawn_point_exploration_enabled");
  explored_radius = getdvarfloat(#"spawnsystem_player_explored_radius", 0);
  explored_radius_sq = explored_radius * explored_radius;

  foreach(team, _ in level.teams) {
    level thread update_explored_start_spawn_points_for_team(team);
    level thread update_explored_spawn_points_for_team(team, explored_radius_sq);
  }
}

private update_explored_start_spawn_points_for_team(team) {
  level notify("update_explored_start_spawn_points_for_team" + string(team));
  level endon("update_explored_start_spawn_points_for_team" + string(team));

  while(true) {
    if(!isDefined(level.spawn_start[team])) {
      wait 0.5;
      continue;
    }

    players = getplayers();
    allplayersspawned = 0;

    if(players.size >= getdvarint(#"com_maxclients", 0)) {
      allplayersspawned = 1;
    }

    foreach(spawnpoint in level.spawn_start[team]) {
      if(!isDefined(spawnpoint.explored)) {
        spawnpoint.explored = 0;
      }

      foreach(player in players) {
        if(!isDefined(player)) {
          continue;
        }

        if(player.team === team) {
          set_player_explored_spawn_point(spawnpoint, player);
          continue;
        }

        clear_spawn_point_explored_for_player(spawnpoint, player);
      }

      spawn_exploration_wait_for_one_frame();
    }

    if(allplayersspawned) {
      break;
    }

    wait 0.5;
  }
}

private update_explored_spawn_points_for_team(team, explored_radius_sq) {
  level notify("update_explored_spawn_points_for_team" + string(team));
  level endon("update_explored_spawn_points_for_team" + string(team));

  while(true) {
    if(!isDefined(level.teamspawnpoints[team])) {
      wait 1;
      continue;
    }

    players = getplayers();

    foreach(spawnpoint in level.teamspawnpoints[team]) {
      if(!isDefined(spawnpoint.explored)) {
        spawnpoint.explored = 0;
      }

      foreach(player in players) {
        if(!isDefined(player)) {
          continue;
        }

        if(!should_update_exploration_for_player(spawnpoint, player)) {
          continue;
        }

        if(abs(player.origin[2] - spawnpoint.origin[2]) < 100 && distancesquared(spawnpoint.origin, player.origin) <= explored_radius_sq) {
          set_player_explored_spawn_point(spawnpoint, player);
        }
      }

      spawn_exploration_wait_for_one_frame();
    }

    wait 1;
  }
}

private should_update_exploration_for_player(spawnpoint, player) {
  if(!player flag::exists("spawn_exploration_active")) {
    return false;
  }

  if(!player flag::get("spawn_exploration_active") || player isplayinganimscripted() || player.sessionstate != "playing") {
    return false;
  }

  if(has_player_explored_spawn_point(spawnpoint, player)) {
    return false;
  }

  return true;
}

spawn_exploration_wait_for_one_frame() {
  waitframe(1);
}

private has_player_explored_spawn_point(spawnpoint, player) {
  return spawnpoint.explored&1 << player getentitynumber();
}

private set_player_explored_spawn_point(spawnpoint, player) {
  spawnpoint.explored |= 1 << player getentitynumber();

  if(isDefined(player.companion)) {
    spawnpoint.explored |= 1 << player.companion getentitynumber();
  }
}

clear_all_spawn_point_explored() {
  foreach(team, _ in level.teams) {
    foreach(spawnpoint in level.teamspawnpoints[team]) {
      spawnpoint.explored = 0;
    }
  }
}

clear_spawn_point_explored_for_player(spawnpoint, player) {
  if(isDefined(spawnpoint.explored)) {
    spawnpoint.explored &= ~(1 << player getentitynumber());
  }

  if(isDefined(player.companion)) {
    spawnpoint.explored &= ~(1 << player.companion getentitynumber());
  }
}

enable_spawn_point_exploration() {
  level flagsys::set(#"spawn_point_exploration_enabled");
}

disable_spawn_point_exploration(clear = 1) {
  level flagsys::clear(#"spawn_point_exploration_enabled");

  if(isDefined(clear) && clear) {
    clear_all_spawn_point_explored();
  }
}

set_spawn_point_exploration_radius(radius) {
  setdvar(#"spawnsystem_player_explored_radius", radius);
}

add_spawn_points(team, spawnpointname) {
  team = util::get_team_mapping(team);
  add_spawn_point_classname(spawnpointname);
  add_spawn_point_team_classname(team, spawnpointname);
  enabled_spawn_points = setup_trigger_enabled_spawn_points(get_spawnpoint_array(spawnpointname, 1));
  enabled_spawn_points = remove_disabled_on_start_spawn_points(enabled_spawn_points);
  add_spawn_points_internal(team, enabled_spawn_points);
  level flagsys::set(#"spawnpoints_dirty");
}

private remove_disabled_on_start_spawn_points(spawn_points) {
  disable_spawn_points = [];

  foreach(spawn_point in spawn_points) {
    if(isDefined(spawn_point.script_start_disabled) && spawn_point.script_start_disabled) {
      if(getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
        spawn_point.disabled = 1;

        if(!isDefined(disable_spawn_points)) {
          disable_spawn_points = [];
        } else if(!isarray(disable_spawn_points)) {
          disable_spawn_points = array(disable_spawn_points);
        }

        disable_spawn_points[disable_spawn_points.size] = spawn_point;
      }

      spawn_point.trigger_enabled = 0;
      spawn_point function_8807475c();
    }
  }

  enabled_spawn_points = array::exclude(spawn_points, disable_spawn_points);
  return enabled_spawn_points;
}

private setup_trigger_enabled_spawn_points(spawn_points) {
  enabled_spawn_points = [];

  foreach(spawn_point in spawn_points) {
    if(isDefined(spawn_point.script_spawn_disable)) {
      triggers = getEntArray(spawn_point.script_spawn_disable, "script_spawn_disable", 1);

      foreach(trig in triggers) {
        if(!isDefined(trig.spawn_points_to_disable)) {
          trig.spawnpoints_enabled = 1;
          trig.spawn_points_to_disable = [];
          trig thread _disable_spawn_points();
        }

        array::add(trig.spawn_points_to_disable, spawn_point, 0);
        spawn_point.disabled = undefined;

        array::add(level.spawnpoint_triggers, trig, 0);

      }
    }

    if(isDefined(spawn_point.script_spawn_enable)) {
      triggers = getEntArray(spawn_point.script_spawn_enable, "script_spawn_enable", 1);

      foreach(trig in triggers) {
        if(!isDefined(trig.spawn_points_to_enable)) {
          trig.spawnpoints_enabled = undefined;
          trig.spawn_points_to_enable = [];
          trig thread _enable_spawn_points();
        }

        array::add(trig.spawn_points_to_enable, spawn_point, 0);

        array::add(level.spawnpoint_triggers, trig, 0);

      }
    }

    if(!(isDefined(spawn_point.disabled) && spawn_point.disabled)) {
      if(!isDefined(enabled_spawn_points)) {
        enabled_spawn_points = [];
      } else if(!isarray(enabled_spawn_points)) {
        enabled_spawn_points = array(enabled_spawn_points);
      }

      enabled_spawn_points[enabled_spawn_points.size] = spawn_point;
    }
  }

  return enabled_spawn_points;
}

private _disable_spawn_points() {
  self endon(#"death");
  self notify(#"end_disable_spawn_points");
  self endon(#"end_disable_spawn_points");

  while(true) {
    waitresult = self waittill(#"trigger");
    self.spawnpoints_enabled = undefined;

    foreach(spawn_point in self.spawn_points_to_disable) {
      if(spawn_point.disabled !== 1 && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
        level flagsys::set(#"spawnpoints_dirty");
      }

      spawn_point.disabled = 1;
      spawn_point.trigger_enabled = 0;
      spawn_point function_8807475c();
    }
  }
}

private _enable_spawn_points() {
  self endon(#"death");
  self notify(#"end_enable_spawn_points");
  self endon(#"end_enable_spawn_points");

  while(true) {
    waitresult = self waittill(#"trigger");
    self.spawnpoints_enabled = 1;

    foreach(spawn_point in self.spawn_points_to_enable) {
      if(isDefined(spawn_point.disabled) && spawn_point.disabled && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
        level flagsys::set(#"spawnpoints_dirty");
      }

      spawn_point.disabled = undefined;
      spawn_point.trigger_enabled = 1;
      spawn_point function_8807475c();
    }
  }
}

private function_8807475c() {
  self.enabled = 1;
  self.enabled = self.enabled && (!isDefined(self.trigger_enabled) || self.trigger_enabled);
  self.enabled = self.enabled && (!isDefined(self.filter_enabled) || self.filter_enabled);
}

private rebuild_spawn_points(team) {
  level.teamspawnpoints[team] = [];

  for(index = 0; index < level.spawn_point_team_class_names[team].size; index++) {
    add_spawn_points_internal(team, get_spawnpoint_array(level.spawn_point_team_class_names[team][index]));
  }
}

place_spawn_points(spawnpointname) {
  add_spawn_point_classname(spawnpointname);
  spawnpoints = get_spawnpoint_array(spawnpointname);

  if(!spawnpoints.size && level.requirespawnpointstoexistinlevel) {
    println("<dev string:x18e>" + spawnpointname + "<dev string:x196>");
    assert(spawnpoints.size, "<dev string:x18e>" + spawnpointname + "<dev string:x196>");
    callback::abort_level();
    wait 1;
    return;
  }

  for(index = 0; index < spawnpoints.size; index++) {
    spawnpoints[index] spawnpoint_init();
  }
}

drop_spawn_points(spawnpointname) {
  spawnpoints = get_spawnpoint_array(spawnpointname);

  if(!spawnpoints.size) {
    println("<dev string:x18e>" + spawnpointname + "<dev string:x196>");
    return;
  }

  for(index = 0; index < spawnpoints.size; index++) {
    placespawnpoint(spawnpoints[index]);
  }
}

private add_spawn_point_classname(spawnpointclassname) {
  if(!isDefined(level.spawn_point_class_names)) {
    level.spawn_point_class_names = [];
  }

  array::add(level.spawn_point_class_names, spawnpointclassname, 0);
}

private add_spawn_point_team_classname(team, spawnpointclassname) {
  array::add(level.spawn_point_team_class_names[team], spawnpointclassname, 0);
}

get_spawnpoint_array(classname, include_disabled = 0) {
  spawn_points = struct::get_array(classname, "targetname");

  if(!include_disabled && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0) {
    enabled_spawn_points = [];

    foreach(spawn_point in spawn_points) {
      if(!(isDefined(spawn_point.disabled) && spawn_point.disabled)) {
        if(!isDefined(enabled_spawn_points)) {
          enabled_spawn_points = [];
        } else if(!isarray(enabled_spawn_points)) {
          enabled_spawn_points = array(enabled_spawn_points);
        }

        enabled_spawn_points[enabled_spawn_points.size] = spawn_point;
      }
    }

    spawn_points = enabled_spawn_points;
  }

  return spawn_points;
}

private spawnpoint_init() {
  spawnpoint = self;
  origin = spawnpoint.origin;

  if(!level.spawnminsmaxsprimed) {
    level.spawnmins = origin;
    level.spawnmaxs = origin;
    level.spawnminsmaxsprimed = 1;
  } else {
    level.spawnmins = math::expand_mins(level.spawnmins, origin);
    level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
  }

  placespawnpoint(spawnpoint);
  spawnpoint.forward = anglesToForward(spawnpoint.angles);
  spawnpoint.sighttracepoint = spawnpoint.origin + (0, 0, 50);

  if(!isDefined(spawnpoint.enabled)) {
    spawnpoint.enabled = 1;
  }

  spawnpoint.inited = 1;
}

get_spawnpoint_final(spawnpoints, predictedspawn, isintermmissionspawn = 0) {
  var_e627dced = &positionwouldtelefrag;

  if(isDefined(level.var_79f19f00)) {
    var_e627dced = level.var_79f19f00;
  }

  bestspawnpoint = undefined;

  if(!isDefined(spawnpoints) || spawnpoints.size == 0) {
    return undefined;
  }

  if(!isDefined(predictedspawn)) {
    predictedspawn = 0;
  }

  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint.lastspawnpredicted && !predictedspawn && !isintermmissionspawn && (!isDefined(self.var_7007b746) || !self.var_7007b746)) {
    if(![
        [var_e627dced]
      ](self.lastspawnpoint.origin)) {
      bestspawnpoint = self.lastspawnpoint;
    }
  }

  if(!isDefined(bestspawnpoint)) {
    for(i = 0; i < spawnpoints.size; i++) {
      if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i] && !self.lastspawnpoint.lastspawnpredicted) {
        continue;
      }

      if([
          [var_e627dced]
        ](spawnpoints[i].origin)) {
        continue;
      }

      bestspawnpoint = spawnpoints[i];
      break;
    }
  }

  if(!isDefined(bestspawnpoint)) {
    if(isDefined(self.lastspawnpoint) && ![
        [var_e627dced]
      ](self.lastspawnpoint.origin)) {
      for(i = 0; i < spawnpoints.size; i++) {
        if(spawnpoints[i] == self.lastspawnpoint) {
          bestspawnpoint = spawnpoints[i];
          break;
        }
      }
    }
  }

  if(!isDefined(bestspawnpoint)) {
    bestspawnpoint = spawnpoints[0];
  }

  self finalize_spawnpoint_choice(bestspawnpoint, predictedspawn);
  return bestspawnpoint;
}

finalize_spawnpoint_choice(spawnpoint, predictedspawn) {
  time = gettime();
  self.lastspawnpoint = spawnpoint;
  self.lastspawntime = time;
  self.var_7007b746 = 0;
  spawnpoint.lastspawnedplayer = self;
  spawnpoint.lastspawntime = time;
  spawnpoint.lastspawnpredicted = predictedspawn;
}

get_spawnpoint_random(spawnpoints, predictedspawn, isintermissionspawn = 0) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }

  for(i = 0; i < spawnpoints.size; i++) {
    j = randomint(spawnpoints.size);
    spawnpoint = spawnpoints[i];
    spawnpoints[i] = spawnpoints[j];
    spawnpoints[j] = spawnpoint;
  }

  return get_spawnpoint_final(spawnpoints, predictedspawn, isintermissionspawn);
}

get_random_intermission_point() {
  spawnpoints = get_spawnpoint_array("mp_global_intermission");

  if(!spawnpoints.size) {
    spawnpoints = get_spawnpoint_array("cp_global_intermission");
  }

  if(!spawnpoints.size) {
    spawnpoints = get_spawnpoint_array("info_player_start");
  }

  assert(spawnpoints.size);
  spawnpoint = get_spawnpoint_random(spawnpoints, undefined, 1);
  return spawnpoint;
}

move_spawn_point(var_75347e0b, start_point, new_point, new_angles) {
  targetnamearray = [];

  if(isarray(var_75347e0b)) {
    targetnamearray = var_75347e0b;
  } else {
    if(!isDefined(targetnamearray)) {
      targetnamearray = [];
    } else if(!isarray(targetnamearray)) {
      targetnamearray = array(targetnamearray);
    }

    targetnamearray[targetnamearray.size] = var_75347e0b;
  }

  foreach(targetname in targetnamearray) {
    spawn_points = get_spawnpoint_array(targetname);

    for(i = 0; i < spawn_points.size; i++) {
      if(distancesquared(spawn_points[i].origin, start_point) < 1) {
        spawn_points[i].origin = new_point;

        if(isDefined(new_angles)) {
          spawn_points[i].angles = new_angles;
        }
      }
    }
  }
}

function_754c78a6(func_callback) {
  if(!isDefined(level.var_811300ad)) {
    level.var_811300ad = [];
  }

  array::add(level.var_811300ad, func_callback);
}

function_4c00b132(func_callback) {
  assert(isDefined(level.var_811300ad) && level.var_811300ad.size, "<dev string:x1b5>");

  foreach(index, func in level.var_811300ad) {
    if(func == func_callback) {
      arrayremoveindex(level.var_811300ad, index, 0);
      return;
    }
  }
}

function_a782529(e_player) {
  var_8bfdbbee = [];

  foreach(func in level.var_811300ad) {
    var_ee69d92d = [[func]](e_player);

    if(isDefined(var_ee69d92d)) {
      array::add(var_8bfdbbee, var_ee69d92d);
    }
  }

  return var_8bfdbbee;
}

spawnpoint_debug() {
  a_spawnlists = getspawnlists();
  index = 0;

  foreach(s_list in a_spawnlists) {
    adddebugcommand("<dev string:x1e8>" + s_list + "<dev string:x216>" + index + "<dev string:x237>");
    index++;
  }

  adddebugcommand("<dev string:x1e8>" + "<dev string:x23b>" + "<dev string:x241>");
  adddebugcommand("<dev string:x266>");
  adddebugcommand("<dev string:x2c7>");

  while(true) {
    spawnsystem_debug_command = getdvarstring(#"spawnsystem_debug_command");

    switch (spawnsystem_debug_command) {
      case #"next_best":
        selectedplayerindex = getdvarint(#"spawnsystem_debug_current_player", 0);

        foreach(player in level.players) {
          if(player getentitynumber() == selectedplayerindex) {
            selectedplayer = player;
            break;
          }
        }

        if(!isDefined(selectedplayer)) {
          continue;
        }

        if(level.teambased) {
          point_team = selectedplayer.pers[#"team"];
          influencer_team = selectedplayer.pers[#"team"];
          vis_team_mask = util::getotherteamsmask(selectedplayer.pers[#"team"]);
        } else {
          point_team = "<dev string:x31f>";
          influencer_team = "<dev string:x31f>";
          vis_team_mask = level.spawnsystem.ispawn_teammask[#"all"];
        }

        nextbestspawnpoint = getbestspawnpoint(point_team, influencer_team, vis_team_mask, selectedplayer, 0);
        selectedplayer setorigin(nextbestspawnpoint[#"origin"]);
        selectedplayer setplayerangles(nextbestspawnpoint[#"angles"]);
        break;
      case #"refresh":
        level flagsys::set(#"spawnpoints_dirty");
        break;
    }

    setdvar(#"spawnsystem_debug_command", "<dev string:x326>");

    if(isDefined(getdvarint(#"spawnsystem_debug_triggers", 0)) && getdvarint(#"spawnsystem_debug_triggers", 0)) {
      foreach(trig in level.spawnpoint_triggers) {
        render_spawnpoints_triggers(trig);
      }
    }

    wait 0.5;
  }
}

render_spawnpoints_triggers(trig) {
  box(trig.origin, trig getmins(), trig getmaxs(), 0, (0, 0, 1), 1, 0, 10);

  if(isDefined(trig.spawn_points_to_enable)) {
    foreach(spawn_point in trig.spawn_points_to_enable) {
      box(spawn_point.origin, (-4, -4, 0), (4, 4, 8), 0, isDefined(spawn_point.disabled) && spawn_point.disabled ? (1, 0, 0) : (0, 1, 0), 1, 0, 10);
      line(trig.origin, spawn_point.origin, (0, 1, 0), 1, 0, 10);
    }
  }

  if(isDefined(trig.spawn_points_to_disable)) {
    foreach(spawn_point in trig.spawn_points_to_disable) {
      box(spawn_point.origin, (-4, -4, 0), (4, 4, 8), 0, isDefined(spawn_point.disabled) && spawn_point.disabled ? (1, 0, 0) : (0, 1, 0), 1, 0, 10);
      line(trig.origin, spawn_point.origin, (1, 0, 0), 1, 0, 10);
    }
  }
}

