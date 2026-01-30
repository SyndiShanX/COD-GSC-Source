/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_teleport.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

main() {
  thread main_thread();
}
main_thread() {
  zones = getStructarray("teleport_world_origin", "targetname");
  gametype = level.gametype;
  if(!zones.size || !(gameType == "dom" || gametype == "ctf" || gametype == "hp" || gametype == "ball")) {
    return;
  }

  flag_init("teleport_setup_complete");
  level.teleport_minimaps = [];
  level.teleport_allowed = true;
  level.teleport_to_offset = false;
  level.teleport_to_nodes = false;
  level.teleport_include_killsteaks = false;
  level.teleport_include_players = false;
  level.teleport_gameMode_func = undefined;
  level.teleport_pre_funcs = [];
  level.teleport_post_funcs = [];
  level.teleport_nodes_in_zone = [];
  level.teleport_pathnode_zones = [];

  level.teleport_onStartGameType = level.onStartGameType;
  level.onStartGameType = ::teleport_onStartGameType;
  level.teleportGetActiveNodesFunc = ::teleport_get_active_nodes;
  level.teleportGetActivePathnodeZonesFunc = ::teleport_get_active_pathnode_zones;
}

teleport_init() {
  level.teleport_spawn_info = [];

  zones = getStructarray("teleport_world_origin", "targetname");
  if(!zones.size) {
    return;
  }

  level.teleport_zones = [];
  foreach(zone in zones) {
    if(!isDefined(zone.script_noteworthy)) {
      zone.script_noteworthy = "zone_" + level.teleport_zones.size;
    }

    zone.name = zone.script_noteworthy;
    teleport_parse_zone_targets(zone);

    level.teleport_nodes_in_zone[zone.name] = [];
    level.teleport_pathnode_zones[zone.name] = [];

    level.teleport_zones[zone.script_noteworthy] = zone;
  }

  all_nodes = GetAllNodes();
  foreach(node in all_nodes) {
    zone = teleport_closest_zone(node.origin);
    level.teleport_nodes_in_zone[zone.name][level.teleport_nodes_in_zone[zone.name].size] = node;
  }

  for(z = 0; z < GetZoneCount(); z++) {
    zone = teleport_closest_zone(GetZoneOrigin(z));
    level.teleport_pathnode_zones[zone.name][level.teleport_pathnode_zones[zone.name].size] = z;
  }

  if(!isDefined(level.teleport_zone_current)) {
    if(isDefined(level.teleport_zones["start"])) {
      teleport_set_current_zone("start");
    } else {
      foreach(key, value in level.teleport_zones) {
        teleport_set_current_zone(key);
        break;
      }
    }
  }

  level thread teleport_debug_set_zone();
}

teleport_onStartGameType() {
  teleport_init();

  pre_onStartGameType_func = undefined;
  post_onStartGameType_func = undefined;

  switch (level.gametype) {
    case "dom":
      post_onStartGameType_func = ::teleport_onStartGameDOM;
      break;
    case "ctf":
      post_onStartGameType_func = ::teleport_onStartGameCTF;
      break;
    case "hp":
      post_onStartGameType_func = ::teleport_onStartGameHP;
      break;
    case "ball":
      post_onStartGameType_func = ::teleport_onStartGameBALL;
      break;

    default:
      break;
  }

  if(isDefined(pre_onStartGameType_func)) {
    level[[pre_onStartGameType_func]]();
  }

  level[[level.teleport_onStartGameType]]();

  if(isDefined(post_onStartGameType_func)) {
    level[[post_onStartGameType_func]]();
  }

  flag_set("teleport_setup_complete");
}

teleport_pre_onStartGameSR() {
  teleport_pre_onStartGameSD_and_SR();
}

teleport_pre_onStartGameSD() {
  teleport_pre_onStartGameSD_and_SR();
}

teleport_pre_onStartGameSD_and_SR() {
  foreach(zone in level.teleport_zones) {
    zone.sd_triggers = [];
    zone.sd_bombs = [];
    zone.sd_bombZones = [];
  }

  triggers = getEntArray("sd_bomb_pickup_trig", "targetname");
  foreach(trigger in triggers) {
    closest_zone = teleport_closest_zone(trigger.origin);
    if(isDefined(closest_zone)) {
      closest_zone.sd_triggers[closest_zone.sd_triggers.size] = trigger;
      teleport_change_targetname(trigger, closest_zone.name);
    }
  }

  bombs = getEntArray("sd_bomb", "targetname");
  foreach(bomb in bombs) {
    closest_zone = teleport_closest_zone(bomb.origin);
    if(isDefined(closest_zone)) {
      closest_zone.sd_bombs[closest_zone.sd_bombs.size] = bomb;
      teleport_change_targetname(bomb, closest_zone.name);
    }
  }

  bombZones = getEntArray("bombzone", "targetname");
  foreach(bombZone in bombZones) {
    closest_zone = teleport_closest_zone(bombZone.origin);
    if(isDefined(closest_zone)) {
      closest_zone.sd_bombZones[closest_zone.sd_bombZones.size] = bombZone;

      teleport_change_targetname(bombZone, closest_zone.name);
    }
  }

  valid_zones = [];
  foreach(zone in level.teleport_zones) {
    if(zone.sd_triggers.size && zone.sd_triggers.size && zone.sd_triggers.size) {
      valid_zones[valid_zones.size] = zone.name;
    }
  }

  teleport_gamemode_disable_teleport(valid_zones);

  current_zone = level.teleport_zones[level.teleport_zone_current];
  teleport_restore_targetname(current_zone.sd_triggers);
  teleport_restore_targetname(current_zone.sd_bombs);
  teleport_restore_targetname(current_zone.sd_bombZones);
}

teleport_onStartGameHORDE() {
  foreach(zone in level.teleport_zones) {
    zone.horde_drops = [];
  }

  hordeDropLocations = getstructarray("horde_drop", "targetname");
  foreach(loc in hordeDropLocations) {
    closest_zone = teleport_closest_zone(loc.origin);
    if(isDefined(closest_zone)) {
      closest_zone.horde_drops[closest_zone.horde_drops.size] = loc;
    }
  }

  valid_zones = [];
  foreach(zone in level.teleport_zones) {
    if(zone.horde_drops.size) {
      valid_zones[valid_zones.size] = zone.name;
    }
  }

  teleport_gamemode_disable_teleport(valid_zones);

  current_zone = level.teleport_zones[level.teleport_zone_current];

  level.struct_class_names["targetname"]["horde_drop"] = current_zone.horde_drops;
}

teleport_change_targetname(ents, append) {
  if(!IsArray(ents)) {
    ents = [ents];
  }

  if(!isDefined(append)) {
    append = "hide_from_getEnt";
  }

  foreach(ent in ents) {
    ent.saved_targetname = ent.targetname;
    ent.targetname = ent.targetname + "_" + append;
  }
}

teleport_gamemode_disable_teleport(valid_zones) {
  if(!isDefined(valid_zones)) {
    valid_zones = GetArrayKeys(level.teleport_zones);
  }

  game_zone = game["teleport_zone_dom"];
  if(!isDefined(game_zone)) {
    game_zone = random(valid_zones);
    game["teleport_zone_dom"] = game_zone;
  }

  teleport_to_zone(game_zone, false);

  level.teleport_allowed = false;
}

teleport_restore_targetname(ents) {
  if(!IsArray(ents)) {
    ents = [ents];
  }

  foreach(ent in ents) {
    if(isDefined(ent.saved_targetname)) {
      ent.targetname = ent.saved_targetname;
    }
  }
}

teleport_onStartGameCTF() {
  level.teleport_gameMode_func = ::teleport_onTeleportCTF;
}

teleport_onStartGameHP() {
  if(!isDefined(level.number_of_hp_zones_pre_teleport)) {
    level.number_of_hp_zones_pre_teleport = 5;
  }

  level.pre_event_hp_zones = [];
  level.post_event_hp_zones = [];
  level.all_hp_zones = level.zones;

  foreach(zone in level.zones) {
    if(zone.script_index > level.number_of_hp_zones_pre_teleport) {
      level.post_event_hp_zones[level.post_event_hp_zones.size] = zone;
    } else {
      level.pre_event_hp_zones[level.pre_event_hp_zones.size] = zone;
    }
  }

  level.zones = level.pre_event_hp_zones;

  level.teleport_gameMode_func = ::teleport_onTeleportHP;
}

teleport_onStartGameBALL() {
  level.teleport_gameMode_func = ::teleport_onTeleportBALL;
}

teleport_onStartGameDOM() {
  foreach(zone in level.teleport_zones) {
    zone.flags = [];
    zone.domFlags = [];
  }

  level.all_dom_flags = level.flags;
  foreach(flag in level.flags) {
    closest_zone = teleport_closest_zone(flag.origin);
    if(isDefined(closest_zone)) {
      flag.teleport_zone = closest_zone.name;
      closest_zone.flags[closest_zone.flags.size] = flag;
      closest_zone.domFlags[closest_zone.domFlags.size] = flag.useObj;
    }
  }

  level.dom_flag_data = [];
  foreach(zone in level.teleport_zones) {
    foreach(domFlag in zone.flags) {
      data = spawnStruct();
      data.trigger_origin = domFlag.origin;
      data.visual_origin = domFlag.useobj.visuals[0].origin;
      data.baseeffectpos = domFlag.useobj.baseeffectpos;
      data.baseeffectforward = domFlag.useobj.baseeffectforward;
      data.baseeffectright = domFlag.useobj.baseeffectright;
      data.obj_origin = domFlag.useObj.curOrigin;

      data.obj3d_origins = [];
      foreach(team in level.teamNameList) {
        opName = "objpoint_" + team + "_" + domFlag.useObj.entNum;
        objPoint = maps\mp\gametypes\_objpoints::getObjPointByName(opName);
        if(isDefined(objPoint)) {
          data.obj3d_origins[team] = (objPoint.x, objPoint.y, objPoint.z);
        }
      }

      opName = "objpoint_mlg_" + domFlag.useObj.entNum;
      objPoint = maps\mp\gametypes\_objpoints::getObjPointByName(opName);
      if(isDefined(objPoint)) {
        data.obj3d_origins["mlg"] = (objPoint.x, objPoint.y, objPoint.z);
      }

      level.dom_flag_data[zone.name][domFlag.useObj.label] = data;
    }
  }

  level.flags = level.teleport_zones[level.teleport_zone_current].flags;
  level.domFlags = level.teleport_zones[level.teleport_zone_current].domFlags;

  foreach(zone in level.teleport_zones) {
    foreach(flag in zone.flags) {
      if(zone.name == level.teleport_zone_current) {
        continue;
      }

      flag.useobj.visuals[0] Delete();
      flag.useObj maps\mp\gametypes\_gameobjects::deleteUseObject();
    }
  }

  level.teleport_gameMode_func = ::teleport_onTeleportDOM;

  teleport_onTeleportDOM(level.teleport_zone_current);

  level.teleport_dom_finished_initializing = true;

  level thread teleport_dom_post_bot_cleanup();
}

teleport_dom_post_bot_cleanup() {
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  foreach(zone in level.teleport_zones) {
    foreach(flag in zone.flags) {
      data = level.dom_flag_data[zone.name][flag.useObj.label];
      data.nodes = flag.nodes;

      if(zone.name != level.teleport_zone_current) {
        flag Delete();
      }
    }
  }
}

teleport_onStartGameCONF() {
  level.teleport_gameMode_func = ::teleport_onTeleportCONF;
}

teleport_onTeleportDOM(next_zone_name) {
  current_zone = level.teleport_zones[level.teleport_zone_current];
  next_zone = level.teleport_zones[next_zone_name];

  if(next_zone_name == level.teleport_zone_current) {
    return;
  }

  foreach(domFlag in level.domFlags) {
    domFlag maps\mp\gametypes\_gameobjects::setOwnerTeam("neutral");
    domFlag maps\mp\gametypes\_gameobjects::set2DIcon("enemy", "waypoint_captureneutral" + domFlag.label);
    domFlag maps\mp\gametypes\_gameobjects::set3DIcon("enemy", "waypoint_captureneutral" + domFlag.label);
    domFlag maps\mp\gametypes\_gameobjects::set2DIcon("friendly", "waypoint_captureneutral" + domFlag.label);
    domFlag maps\mp\gametypes\_gameobjects::set3DIcon("friendly", "waypoint_captureneutral" + domFlag.label);
    domFlag maps\mp\gametypes\_gameobjects::set2DIcon("mlg", "waypoint_esports_dom_white" + domFlag.label);
    domFlag maps\mp\gametypes\_gameobjects::set3DIcon("mlg", "waypoint_esports_dom_white" + domFlag.label);
    domFlag.firstCapture = true;
  }

  foreach(domFlag in level.flags) {
    data = level.dom_flag_data[next_zone_name][domFlag.useObj.label];
    domFlag.origin = data.trigger_origin;
    domFlag.useobj.visuals[0].origin = data.visual_origin;
    domFlag.useobj.baseeffectpos = data.baseeffectpos;
    domFlag.useobj.baseeffectforward = data.baseeffectforward;
    domFlag.useObj maps\mp\gametypes\dom::updateVisuals();
    domFlag.teleport_zone = next_zone_name;
    domflag.nodes = data.nodes;

    if(isDefined(domflag.useobj.objIDAllies)) {
      Objective_Position(domflag.useobj.objIDAllies, data.obj_origin);
    }
    if(isDefined(domflag.useobj.objIDAxis)) {
      Objective_Position(domflag.useobj.objIDAxis, data.obj_origin);
    }
    if(isDefined(domflag.useobj.objIDMLGSpectator)) {
      Objective_Position(domflag.useobj.objIDMLGSpectator, data.obj_origin);
    }

    foreach(team in level.teamnamelist) {
      opName = "objpoint_" + team + "_" + domFlag.useObj.entNum;
      objPoint = maps\mp\gametypes\_objpoints::getObjPointByName(opName);
      objPoint.x = data.obj3d_origins[team][0];
      objPoint.y = data.obj3d_origins[team][1];
      objPoint.z = data.obj3d_origins[team][2];
    }

    opName = "objpoint_mlg_" + domFlag.useObj.entNum;
    objPoint = maps\mp\gametypes\_objpoints::getObjPointByName(opName);
    objPoint.x = data.obj3d_origins["mlg"][0];
    objPoint.y = data.obj3d_origins["mlg"][1];
    objPoint.z = data.obj3d_origins["mlg"][2];
  }

  maps\mp\gametypes\dom::flagSetup();

  foreach(flag in level.domFlags) {
    label = flag.label;
    foreach(zone_domflag in level.teleport_zones["start"].domFlags) {
      if(zone_domflag.label == label) {
        flag.levelflag = zone_domflag.levelflag;
      }
    }
  }

  foreach(flag in level.flags) {
    label = flag.label;
    foreach(zone_flag in level.teleport_zones["start"].flags) {
      if(zone_flag.label == label) {
        flag.levelflag = zone_flag.levelflag;
      }
    }
  }
}

teleport_get_matching_dom_flag(flag, from_zone) {
  foreach(dom_flag in level.teleport_zones[from_zone].flags) {
    if(flag.useobj.label == dom_flag.useobj.label) {
      return dom_flag;
    }
  }
  return undefined;
}

teleport_onTeleportCTF(next_zone_name) {
  if(game["switchedsides"]) {
    level.ctf_second_zones["axis"] = getent("post_event_capzone_allies", "targetname");
    level.ctf_second_zones["allies"] = getent("post_event_capzone_axis", "targetname");
  } else {
    level.ctf_second_zones["allies"] = getent("post_event_capzone_allies", "targetname");
    level.ctf_second_zones["axis"] = getent("post_event_capzone_axis", "targetname");
  }

  zones = [];
  zones["allies"] = level.capZones["allies"];
  zones["axis"] = level.capZones["axis"];
  flags["allies"] = level.teamFlags["allies"];
  flags["axis"] = level.teamFlags["axis"];
  zone_dest["allies"] = level.ctf_second_zones["allies"].origin;
  zone_dest["axis"] = level.ctf_second_zones["axis"].origin;

  foreach(zone in zones) {
    zone maps\mp\gametypes\_gameobjects::move_use_object(zone_dest[zone.ownerTeam], (0, 0, 85));
    zone.trigger trigger_off();
  }

  foreach(flag in level.teamFlags) {
    flag maps\mp\gametypes\_gameobjects::move_use_object(zone_dest[flag.ownerTeam], (0, 0, 85));

    if(isDefined(flag.carrier)) {
      flag maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
      flag maps\mp\gametypes\_gameobjects::set2DIcon("friendly", level.iconKill2D);
      flag maps\mp\gametypes\_gameobjects::set3DIcon("friendly", level.iconKill3D);
      flag maps\mp\gametypes\_gameobjects::set2DIcon("enemy", level.iconEscort2D);
      flag maps\mp\gametypes\_gameobjects::set3DIcon("enemy", level.iconEscort3D);

      level.capZones[flag.ownerteam] maps\mp\gametypes\_gameobjects::allowUse("none");
      level.capZones[flag.ownerteam] maps\mp\gametypes\_gameobjects::setVisibleTeam("friendly");
      level.capZones[flag.ownerteam] maps\mp\gametypes\_gameobjects::set2DIcon("friendly", level.iconWaitForFlag2D);
      level.capZones[flag.ownerteam] maps\mp\gametypes\_gameobjects::set3DIcon("friendly", level.iconWaitForFlag3D);

      if(flag.ownerteam == "allies") {
        level.capZones[flag.ownerteam] maps\mp\gametypes\_gameobjects::set2DIcon("mlg", level.iconMissingBlue);
        level.capZones[flag.ownerteam] maps\mp\gametypes\_gameobjects::set3DIcon("mlg", level.iconMissingBlue);
      } else {
        level.capZones[flag.ownerteam] maps\mp\gametypes\_gameobjects::set2DIcon("mlg", level.iconMissingRed);
        level.capZones[flag.ownerteam] maps\mp\gametypes\_gameobjects::set3DIcon("mlg", level.iconMissingRed);
      }
    }
  }

  maps\mp\gametypes\ctf::captureZone_reset_base_effects();

  maps\mp\gametypes\ctf::reassign_ctf_team_spawns();

  foreach(zone in zones) {
    zone.trigger trigger_on();
  }
}

teleport_onTeleportHP(next_zone_name) {
  level.zones = level.post_event_hp_zones;

  if(level.randomZoneSpawn == false) {
    level.prevZoneIndex = level.zones.size - 1;
  } else {
    level.zoneSpawnQueue = [];
    maps\mp\gametypes\hp::ShuffleZones();
  }

  SetOmnvar("ui_hardpoint_timer", 0);
  level notify("zone_moved");
}

teleport_onTeleportBALL(next_zone_name) {
  level.ball_starts_post_event = getstructarray("ball_start_post_event", "targetname");
  if(game["switchedsides"]) {
    level.ball_goals_post_event["allies"] = getstruct("ball_goal_axis_post_event", "targetname");
    level.ball_goals_post_event["axis"] = getstruct("ball_goal_allies_post_event", "targetname");
  } else {
    level.ball_goals_post_event["axis"] = getstruct("ball_goal_axis_post_event", "targetname");
    level.ball_goals_post_event["allies"] = getstruct("ball_goal_allies_post_event", "targetname");
  }

  goals = [];
  goals["allies"] = level.ball_goals["allies"];
  goals["axis"] = level.ball_goals["axis"];
  goal_dest = [];
  goal_dest["allies"] = level.ball_goals_post_event["allies"].origin;
  goal_dest["axis"] = level.ball_goals_post_event["axis"].origin;

  foreach(goal in goals) {
    offset = (0, 0, ((goal.radius / 2) * 1.1));
    goal.useobject maps\mp\gametypes\_gameobjects::move_use_object(goal_dest[goal.Team], offset);
    goal maps\mp\gametypes\ball::ball_find_ground();

    foreach(player in level.players) {
      maps\mp\gametypes\ball::ball_goal_fx_for_player(player);
    }
  }

  bot_setup_ball_jump_nodes();

  zone = GetZoneNearest(level.ball_goals["allies"].origin);
  if(isDefined(zone)) {
    BotZoneSetTeam(zone, "allies");
  }

  zone = GetZoneNearest(level.ball_goals["axis"].origin);
  if(isDefined(zone)) {
    BotZoneSetTeam(zone, "axis");
  }

  level.ball_starts = [];
  foreach(ball_start in level.ball_starts_post_event) {
    maps\mp\gametypes\ball::ball_add_start(ball_start.origin);
  }

  foreach(ball in level.balls) {
    ball_carried = false;
    foreach(player in level.players) {
      if(isDefined(player.ball_carried) && player.ball_carried == ball) {
        ball_carried = true;
        break;
      }
    }

    if(ball_carried != true) {
      ball maps\mp\gametypes\ball::ball_return_home();
    }
  }
}

bot_setup_ball_jump_nodes() {
  ball_node_max_dist = 400;

  wait(1.0);

  num_traces = 0;
  increment = 10;

  foreach(goal in level.ball_goals) {
    goal.ball_jump_nodes = [];

    nodes = GetNodesInRadius(goal.origin, ball_node_max_dist, 0);
    foreach(node in nodes) {
      if(node.type == "End") {
        continue;
      }

      num_traces++;
      if(bot_ball_origin_can_see_goal(node.origin, goal, true)) {
        goal.ball_jump_nodes[goal.ball_jump_nodes.size] = node;
      }

      if((num_traces % increment) == 0) {
        wait(0.05);
      }
    }

    nearest_node_2d_dist_sq = 999999999;
    foreach(node in goal.ball_jump_nodes) {
      dist_2d_sq_to_node = Distance2DSquared(node.origin, goal.origin);
      if(dist_2d_sq_to_node < nearest_node_2d_dist_sq) {
        goal.nearest_node = node;
        nearest_node_2d_dist_sq = dist_2d_sq_to_node;
      }
    }

    AssertEx(goal.ball_jump_nodes.size > 0, "Uplink goal at " + goal.origin + " needs pathnodes within a " + ball_node_max_dist + " unit radius with sight to the goal");
    wait(0.05);
  }
}

bot_ball_origin_can_see_goal(origin, goal, thorough) {
  trace_succeeded = self bot_ball_trace_to_origin(origin, goal.origin);
  if(isDefined(thorough) && thorough) {
    if(!trace_succeeded) {
      goal_origin = goal.origin - (0, 0, goal.radius * 0.5);
      trace_succeeded = self bot_ball_trace_to_origin(origin, goal_origin);
    }

    if(!trace_succeeded) {
      goal_origin = goal.origin + (0, 0, goal.radius * 0.5);
      trace_succeeded = self bot_ball_trace_to_origin(origin, goal_origin);
    }
  }

  return trace_succeeded;
}

bot_ball_trace_to_origin(start_origin, end_origin) {
  if(isDefined(self) && (IsPlayer(self) || IsAgent(self))) {
    hitPos = PlayerPhysicsTrace(start_origin, end_origin, self);
  } else {
    hitPos = PlayerPhysicsTrace(start_origin, end_origin);
  }
  return (DistanceSquared(hitPos, end_origin) < 1);
}

teleport_onTeleportCONF(next_zone_name) {
  teleport_delta = get_teleport_delta(next_zone_name);

  foreach(dogTag in level.dogtags) {
    goal_origin = dogTag.curOrigin + teleport_delta;
    goal_node = teleport_get_safe_node_near(goal_origin);

    if(isDefined(goal_node)) {
      goal_node.last_teleport_time = GetTime();
      delta = goal_node.origin - dogTag.curOrigin;

      dogTag.curOrigin += delta;
      dogTag.trigger.origin += delta;
      dogTag.visuals[0].origin += delta;
      dogTag.visuals[1].origin += delta;
    } else {
      dogTag maps\mp\gametypes\conf::resetTags();
    }
  }
}

teleport_get_safe_node_near(near_to) {
  current_time = GetTime();

  nodes = GetNodesInRadiusSorted(near_to, 300, 0, 200, "Path");
  for(i = 0; i < nodes.size; i++) {
    check_node = nodes[i];

    if(isDefined(check_node.last_teleport_time) && check_node.last_teleport_time == current_time) {
      continue;
    }

    return check_node;
  }

  return undefined;
}

teleport_closest_zone(test_origin) {
  min_dist = undefined;
  closest_zone = undefined;
  foreach(zone in level.teleport_zones) {
    dist = DistanceSquared(zone.origin, test_origin);
    if(!isDefined(min_dist) || dist < min_dist) {
      min_dist = dist;
      closest_zone = zone;
    }
  }

  return closest_zone;
}

teleport_origin_use_nodes(allow) {
  level.teleport_to_nodes = allow;
}

teleport_origin_use_offset(allow) {
  level.teleport_to_offset = allow;
}

teleport_include_killstreaks(include) {
  level.teleport_include_killsteaks = include;
}

teleport_set_minimap_for_zone(zone, map) {
  level.teleport_minimaps[zone] = map;
}

teleport_set_pre_func(func, zone_name) {
  level.teleport_pre_funcs[zone_name] = func;
}

teleport_set_post_func(func, zone_name) {
  level.teleport_post_funcs[zone_name] = func;
}

teleport_parse_zone_targets(zone) {
  if(isDefined(zone.origins_pasrsed) && zone.origins_pasrsed) {
    return;
  }

  zone.teleport_origins = [];
  zone.teleport_origins["none"] = [];
  zone.teleport_origins["allies"] = [];
  zone.teleport_origins["axis"] = [];

  structs = getstructarray("teleport_zone_" + zone.name, "targetname");

  if(isDefined(zone.target)) {
    zone_targets = getstructarray(zone.target, "targetname");
    structs = array_combine(zone_targets, structs);
  }

  foreach(struct in structs) {
    if(!isDefined(struct.script_noteworthy)) {
      struct.script_noteworthy = "teleport_origin";
    }

    switch (struct.script_noteworthy) {
      case "teleport_origin":
        start = struct.origin + (0, 0, 1);
        end = struct.origin - (0, 0, 250);
        trace = bulletTrace(start, end, false);

        if(trace["fraction"] == 1.0) {
          println("^3_teleport.gsc: Teleport Origin " + struct.origin + " did not find ground.");
          break;
        }

        struct.origin = trace["position"];

      case "telport_origin_nodrop":
        if(!isDefined(struct.script_parameters)) {
          struct.script_parameters = "none,axis,allies";
        }

        toks = strTok(struct.script_parameters, ", ");
        foreach(tok in toks) {
          if(!isDefined(zone.teleport_origins[tok])) {
            println("^3_teleport.gsc: Unknown Team " + tok + " on teleport origin at " + struct.origin);
            continue;
          }

          if(!isDefined(struct.angles)) {
            struct.angles = (0, 0, 0);
          }

          size = zone.teleport_origins[tok].size;
          zone.teleport_origins[tok][size] = struct;
        }
        break;
      default:
        break;
    }
  }

  zone.origins_pasrsed = true;
}

teleport_debug_set_zone() {
  thread teleport_watch_debug_dvar("teleport_debug_zone");
  thread teleport_watch_debug_dvar("teleport_debug_zone_simple");

  while(1) {
    level waittill("teleport_dvar_changed", dvar_name, debug_zone);

    run_event_funcs = dvar_name != "teleport_debug_zone_simple";
    if(teleport_is_valid_zone(debug_zone)) {
      teleport_to_zone(debug_zone, run_event_funcs);
    } else {
      i = 0;
      PrintLn("'" + debug_zone + "' is not a valid zone. Valid Zones:");
      foreach(name, zones in level.teleport_zones) {
        i++;
        PrintLn("" + i + ") " + name);
      }
    }
  }
}

teleport_watch_debug_dvar(dvar_name, dvar_default) {
  if(!isDefined(dvar_default)) {
    dvar_default = "";
  }

  SetDvarIfUninitialized(dvar_name, dvar_default);

  while(1) {
    current_value = GetDvar(dvar_name, dvar_default);

    if(current_value != dvar_default) {
      level notify("teleport_dvar_changed", dvar_name, current_value);
      SetDvar(dvar_name, dvar_default);
    }

    wait .25;
  }
}

teleport_set_current_zone(zone) {
  level.teleport_zone_current = zone;

  if(isDefined(level.teleport_minimaps[zone])) {
    maps\mp\_compass::setupMiniMap(level.teleport_minimaps[zone]);
  }
}

teleport_filter_spawn_point(spawnPoints, filter_zone) {
  if(!isDefined(filter_zone)) {
    filter_zone = level.teleport_zone_current;
  }

  valid_spawns = [];
  foreach(spawnPoint in spawnPoints) {
    if(!isDefined(spawnPoint.teleport_label)) {
      spawnPoint.teleport_label = "ent_" + spawnPoint GetEntityNumber();
    }
    if(!isDefined(level.teleport_spawn_info[spawnPoint.teleport_label])) {
      teleport_init_spawn_info(spawnPoint);
    }

    if(level.teleport_spawn_info[spawnPoint.teleport_label].zone == filter_zone) {
      valid_spawns[valid_spawns.size] = spawnPoint;
    }
  }

  return valid_spawns;
}

teleport_init_spawn_info(spawner) {
  if(!isDefined(spawner.teleport_label)) {
    spawner.teleport_label = "ent_" + spawner GetEntityNumber();
  }
  if(isDefined(level.teleport_spawn_info[spawner.teleport_label])) {
    return;
  }

  s = spawnStruct();
  s.spawner = spawner;

  min_dist = undefined;
  foreach(zone in level.teleport_zones) {
    dist = Distance(zone.origin, spawner.origin);
    if(!isDefined(min_dist) || dist < min_dist) {
      min_dist = dist;
      s.zone = zone.name;
    }
  }

  level.teleport_spawn_info[spawner.teleport_label] = s;
}

teleport_is_valid_zone(zone_name) {
  foreach(name, zones in level.teleport_zones) {
    if(name == zone_name) {
      return true;
    }
  }

  return false;
}

teleport_to_zone(zone_name, run_event_funcs) {
  if(!level.teleport_allowed) {
    return;
  }

  if(!isDefined(run_event_funcs)) {
    run_event_funcs = true;
  }

  pre_func = level.teleport_pre_funcs[zone_name];
  if(isDefined(pre_func) && run_event_funcs) {
    [[pre_func]]();
  }

  current = level.teleport_zones[level.teleport_zone_current];
  next = level.teleport_zones[zone_name];

  if(!isDefined(current) || !isDefined(next)) {
    return;
  }

  if(level.teleport_include_players) {
    teleport_to_zone_players(zone_name);
    teleport_to_zone_agents(zone_name);
  }

  if(level.teleport_include_killsteaks) {
    teleport_to_zone_killstreaks(zone_name);
  }

  if(isDefined(level.teleport_gameMode_func)) {
    [[level.teleport_gameMode_func]](zone_name);
  }

  teleport_set_current_zone(zone_name);

  level notify("teleport_to_zone", zone_name);

  post_func = level.teleport_post_funcs[zone_name];
  if(isDefined(post_func) && run_event_funcs) {
    [[post_func]]();
  }

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["post_teleport"])) {
    [[level.bot_funcs["post_teleport"]]]();
  }
}

teleport_to_zone_agents(zone_name) {
  agents = maps\mp\agents\_agent_utility::getActiveAgentsOfType("all");
  foreach(agent in agents) {
    teleport_to_zone_character(zone_name, agent);
  }
}

teleport_to_zone_players(zone_name) {
  foreach(player in level.players) {
    teleport_to_zone_character(zone_name, player);
  }
}

teleport_to_zone_character(zone_name, character) {
  current_zone = level.teleport_zones[level.teleport_zone_current];
  next_zone = level.teleport_zones[zone_name];

  current_time = GetTime();

  if(isPlayer(character) && (character.sessionstate == "intermission" || character.sessionstate == "spectator")) {
    spawnPoints = getEntArray("mp_global_intermission", "classname");
    spawnPoints = teleport_filter_spawn_point(spawnPoints, zone_name);

    spawnPoint = spawnPoints[0];
    character DontInterpolate();
    character SetOrigin(spawnPoint.origin);
    character SetPlayerAngles(spawnPoint.angles);
    return;
  }

  teleport_origin = undefined;
  teleport_angles = character.angles;
  if(isPlayer(character)) {
    teleport_angles = character GetPlayerAngles();
  }

  foreach(set_name, origin_set in next_zone.teleport_origins) {
    next_zone.teleport_origins[set_name] = array_randomize(origin_set);
    foreach(org in origin_set) {
      org.claimed = false;
    }
  }

  zone_origins = [];
  if(level.teambased) {
    if(isDefined(character.team) && isDefined(next_zone.teleport_origins[character.team])) {
      zone_origins = next_zone.teleport_origins[character.team];
    }
  } else {
    zone_origins = next_zone.teleport_origins["none"];
  }

  foreach(org in zone_origins) {
    if(!org.claimed) {
      teleport_origin = org.origin;
      teleport_angles = org.angles;
      org.claimed = true;
      break;
    }
  }

  delta = next_zone.origin - current_zone.origin;
  desiredOrigin = character.origin + delta;
  if(!isDefined(teleport_origin) && level.teleport_to_offset) {
    if(Canspawn(desiredOrigin) && !PositionWouldTelefrag(desiredOrigin)) {
      teleport_origin = desiredOrigin;
    }
  }

  if(!isDefined(teleport_origin) && level.teleport_to_nodes) {
    nodes = GetNodesInRadiusSorted(desiredOrigin, 300, 0, 200, "Path");
    for(i = 0; i < nodes.size; i++) {
      check_node = nodes[i];
      if(isDefined(check_node.last_teleport_time) && check_node.last_teleport_time == current_time) {
        continue;
      }

      org = check_node.origin;
      if(Canspawn(org) && !PositionWouldTelefrag(org)) {
        check_node.last_teleport_time = current_time;
        teleport_origin = org;
        break;
      }
    }
  }

  if(!isDefined(teleport_origin)) {
    character _suicide();
  } else {
    character CancelMantle();
    character DontInterpolate();
    character SetOrigin(teleport_origin);
    character SetPlayerAngles(teleport_angles);

    thread teleport_validate_success(character);
  }
}

teleport_validate_success(player) {
  waitframe();
  if(isDefined(player)) {
    player_zone = teleport_closest_zone(player.origin);
    if(player_zone.name != level.teleport_zone_current) {
      player _suicide();
    }
  }
}

get_teleport_delta(zone_name) {
  next_zone = level.teleport_zones[zone_name];
  current_zone = level.teleport_zones[level.teleport_zone_current];
  delta = next_zone.origin - current_zone.origin;
  return delta;
}

teleport_to_zone_killstreaks(zone_name) {
}

teleport_notify_death() {
  if(isDefined(self)) {
    self notify("death");
  }
}

array_thread_safe(entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(entities)) {
    return;
  }
  array_thread(entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

array_levelthread_safe(array, process, var1, var2, var3) {
  if(!isDefined(array)) {
    return;
  }

  array_levelthread(array, process, var1, var2, var3);
}

teleport_get_care_packages() {
  return getEntArray("care_package", "targetname");
}

teleport_get_deployable_boxes() {
  boxes = [];
  script_models = getEntArray("script_model", "classname");
  foreach(mod in script_models) {
    if(isDefined(mod.boxtype)) {
      boxes[boxes.size] = mod;
    }
  }
  return boxes;
}

teleport_place_on_ground(ent, max_trace) {
  if(!isDefined(ent)) {
    return;
  }

  if(!isDefined(max_trace)) {
    max_trace = 300;
  }

  start = ent.origin;
  end = ent.origin - (0, 0, max_trace);
  trace = bulletTrace(start, end, false, ent);

  if(trace["fraction"] < 1) {
    ent.origin = trace["position"];
    return true;
  } else {
    return false;
  }
}

teleport_add_delta_targets(ent, delta) {
  if(teleport_delta_this_frame(ent)) {
    return;
  }

  teleport_add_delta(ent, delta);
  if(isDefined(ent.target)) {
    ents = getEntArray(ent.target, "targetname");
    structs = getstructarray(ent.target, "targetname");
    targets = array_combine(ents, structs);
    array_levelthread(targets, ::teleport_add_delta_targets, delta);
  }
}

teleport_self_add_delta_targets(delta) {
  teleport_add_delta_targets(self, delta);
}

teleport_self_add_delta(delta) {
  teleport_add_delta(self, delta);
}

teleport_add_delta(ent, delta) {
  if(isDefined(ent)) {
    if(!teleport_delta_this_frame(ent)) {
      ent.origin += delta;
      ent.last_teleport_time = GetTime();
    }
  }
}

teleport_delta_this_frame(ent) {
  return isDefined(ent.last_teleport_time) && ent.last_teleport_time == GetTime();
}

teleport_get_active_nodes() {
  return level.teleport_nodes_in_zone[level.teleport_zone_current];
}

teleport_get_active_pathnode_zones() {
  return level.teleport_pathnode_zones[level.teleport_zone_current];
}