/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_teleport.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

main() {
  thread main_thread();
}
main_thread() {
  flag_init("teleport_setup_complete");
  level.teleport_minimaps = [];
  level.teleport_allowed = true;
  level.teleport_to_offset = true;
  level.teleport_to_nodes = true;
  level.teleport_include_killsteaks = true;
  level.teleport_gameMode_func = undefined;
  level.teleport_pre_funcs = [];
  level.teleport_post_funcs = [];
  level.teleport_a10_inBoundList = [];
  level.teleport_a10_outBoundList = [];
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
    if(!isDefined(zone.script_noteworthy))
      zone.script_noteworthy = "zone_" + level.teleport_zones.size;

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

  level.dynamicSpawns = ::teleport_filter_spawn_point;

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
    case "siege":
      post_onStartGameType_func = ::teleport_onStartGameSIEGE;
      break;
    case "conf":
      post_onStartGameType_func = ::teleport_onStartGameCONF;
      break;
    case "sd":
      pre_onStartGameType_func = ::teleport_pre_onStartGameSD;
      break;
    case "sr":
      pre_onStartGameType_func = ::teleport_pre_onStartGameSR;
      break;
    case "blitz":
      pre_onStartGameType_func = ::teleport_pre_onStartGameBlitz;
      break;
    case "sotf":
    case "sotf_ffa":
      post_onStartGameType_func = ::teleport_onStartGameSOTF;
      break;
    case "grind":
      post_onStartGameType_func = ::teleport_onStartGameGRIND;
      break;
    case "horde":
      pre_onStartGameType_func = ::teleport_onStartGameHORDE;
      break;

    case "war":
    case "dm":
    case "infect":
      break;
    default:

      break;
  }

  if(isDefined(pre_onStartGameType_func))
    level[[pre_onStartGameType_func]]();

  level[[level.teleport_onStartGameType]]();

  if(isDefined(post_onStartGameType_func))
    level[[post_onStartGameType_func]]();

  flag_set("teleport_setup_complete");
}

teleport_pre_onStartGameBlitz() {
  foreach(zone in level.teleport_zones) {
    zone.blitz_all_triggers = [];
  }

  axisPortalTriggers = getEntArray("axis_portal", "targetname");
  foreach(portal_trig in axisPortalTriggers) {
    closest_zone = teleport_closest_zone(portal_trig.origin);
    if(isDefined(closest_zone)) {
      closest_zone.blitz_axis_trigger_origin = portal_trig.origin;
      closest_zone.blitz_all_triggers[closest_zone.blitz_all_triggers.size] = portal_trig;
      teleport_change_targetname(portal_trig);
    }
  }

  alliesPortalTriggers = getEntArray("allies_portal", "targetname");
  foreach(portal_trig in alliesPortalTriggers) {
    closest_zone = teleport_closest_zone(portal_trig.origin);
    if(isDefined(closest_zone)) {
      closest_zone.blitz_allies_trigger_origin = portal_trig.origin;
      closest_zone.blitz_all_triggers[closest_zone.blitz_all_triggers.size] = portal_trig;
      teleport_change_targetname(portal_trig);
    }
  }

  current_zone = level.teleport_zones[level.teleport_zone_current];
  teleport_restore_targetname(current_zone.blitz_all_triggers);

  level.teleport_gameMode_func = ::teleport_onTeleportBlitz;
}

teleport_onTeleportBlitz(next_zone_name) {
  next_zone = level.teleport_zones[next_zone_name];
  current_zone = level.teleport_zones[level.teleport_zone_current];

  axis_team = "axis";
  allies_team = "allies";
  if(game["switchedsides"]) {
    axis_team = "allies";
    allies_team = "axis";
  }

  axis_offset = next_zone.blitz_axis_trigger_origin - current_zone.blitz_axis_trigger_origin;
  level.portalList[axis_team].origin += axis_offset;
  level.portalList[axis_team].trigger.origin += axis_offset;
  Objective_Position(level.portalList[axis_team].ownerTeamID, next_zone.blitz_axis_trigger_origin + (0, 0, 72));
  Objective_Position(level.portalList[axis_team].enemyTeamID, next_zone.blitz_axis_trigger_origin + (0, 0, 72));

  allies_offset = next_zone.blitz_allies_trigger_origin - current_zone.blitz_allies_trigger_origin;
  level.portalList[allies_team].origin += allies_offset;
  level.portalList[allies_team].trigger.origin += allies_offset;
  Objective_Position(level.portalList[allies_team].ownerTeamID, next_zone.blitz_allies_trigger_origin + (0, 0, 72));
  Objective_Position(level.portalList[allies_team].enemyTeamID, next_zone.blitz_allies_trigger_origin + (0, 0, 72));

  maps\mp\gametypes\blitz::assignTeamSpawns();
  foreach(player in level.players) {
    player maps\mp\gametypes\blitz::showTeamPortalFX();
  }
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
  if(isAnyMLGMatch()) {
    valid_zones[0] = "start";
  } else {
    foreach(zone in level.teleport_zones) {
      if(zone.sd_triggers.size && zone.sd_triggers.size && zone.sd_triggers.size) {
        valid_zones[valid_zones.size] = zone.name;
      }
    }
  }

  teleport_gamemode_disable_teleport(valid_zones);

  current_zone = level.teleport_zones[level.teleport_zone_current];
  teleport_restore_targetname(current_zone.sd_triggers);
  teleport_restore_targetname(current_zone.sd_bombs);
  teleport_restore_targetname(current_zone.sd_bombZones);
}

teleport_onStartGameSOTF() {
  foreach(zone in level.teleport_zones) {
    zone.sotf_chest_spawnpoints = [];
  }

  sotf_chest_spawnpoints = getstructarray("sotf_chest_spawnpoint", "targetname");
  foreach(point in sotf_chest_spawnpoints) {
    closest_zone = teleport_closest_zone(point.origin);
    if(isDefined(closest_zone)) {
      closest_zone.sotf_chest_spawnpoints[closest_zone.sotf_chest_spawnpoints.size] = point;
    }
  }

  valid_zones = [];
  foreach(zone in level.teleport_zones) {
    if(zone.sotf_chest_spawnpoints.size) {
      valid_zones[valid_zones.size] = zone.name;
    }
  }

  level.teleport_gameMode_func = ::teleport_onTeleportSOTF;

  teleport_gamemode_disable_teleport(valid_zones);
}

teleport_onTeleportSOTF(next_zone_name) {
  next_zone = level.teleport_zones[next_zone_name];

  level.struct_class_names["targetname"]["sotf_chest_spawnpoint"] = next_zone.sotf_chest_spawnpoints;
}

teleport_onStartGameGRIND() {
  foreach(zone in level.teleport_zones) {
    zone.grindZones = [];
  }

  foreach(grindZone in level.zoneList) {
    closest_zone = teleport_closest_zone(grindZone.origin);
    if(isDefined(closest_zone)) {
      grindZone.teleport_zone = closest_zone.name;
      closest_zone.grindZones[closest_zone.grindZones.size] = grindZone;
    }
  }
  level.teleport_gameMode_func = ::teleport_onTeleportGRIND;

  teleport_onTeleportGRIND(level.teleport_zone_current);
}

teleport_onTeleportGRIND(next_zone_name) {
  next_zone = level.teleport_zones[next_zone_name];

  foreach(grindZone in next_zone.grindZones) {
    if(next_zone_name != level.teleport_zone_current) {
      Objective_State(grindZone.objId_axis, "active");
      Objective_State(grindZone.objId_allies, "active");

      if(isDefined(grindZone.grind_headIcon_allies) && isDefined(grindZone.grind_headIcon_allies.old_alpha)) {
        grindZone.grind_headIcon_allies.alpha = grindZone.grind_headIcon_allies.old_alpha;
      }

      if(isDefined(grindZone.grind_headIcon_axis) && isDefined(grindZone.grind_headIcon_axis.old_alpha)) {
        grindZone.grind_headIcon_axis.alpha = grindZone.grind_headIcon_axis.old_alpha;
      }
    }
  }

  foreach(zone_name, zone in level.teleport_zones) {
    foreach(grindZone in zone.grindZones) {
      if(zone_name != next_zone_name) {
        thread teleport_HideGrindZone(grindZone);
      }
    }
  }

  foreach(tag in level.dogtags) {
    tag.visual hide();
    tag.trigger hide();

    tag maps\mp\gametypes\_gameobjects::allowUse("none");

    tag notify("reset");
    tag.lastUsedTime = 0;
  }
}

teleport_HideGrindZone(grindZone) {
  Objective_State(grindZone.objId_axis, "invisible");
  Objective_State(grindZone.objId_allies, "invisible");

  while(!isDefined(grindZone.grind_headIcon_allies) || !isDefined(grindZone.grind_headIcon_axis))
    waitframe();

  grindZone.grind_headIcon_allies.old_alpha = grindZone.grind_headIcon_allies.alpha;
  grindZone.grind_headIcon_allies.alpha = 0;

  grindZone.grind_headIcon_axis.old_alpha = grindZone.grind_headIcon_axis.alpha;
  grindZone.grind_headIcon_axis.alpha = 0;
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
  if(!IsArray(ents))
    ents = [ents];

  if(!isDefined(append))
    append = "hide_from_getEnt";

  foreach(ent in ents) {
    ent.saved_targetname = ent.targetname;
    ent.targetname = ent.targetname + "_" + append;
  }
}

teleport_gamemode_disable_teleport(valid_zones) {
  if(!isDefined(valid_zones))
    valid_zones = GetArrayKeys(level.teleport_zones);

  game_zone = game["teleport_zone_dom"];
  if(!isDefined(game_zone)) {
    game_zone = random(valid_zones);
    game["teleport_zone_dom"] = game_zone;
  }

  teleport_to_zone(game_zone, false);

  level.teleport_allowed = false;
}

teleport_restore_targetname(ents) {
  if(!IsArray(ents))
    ents = [ents];

  foreach(ent in ents) {
    if(isDefined(ent.saved_targetname))
      ent.targetname = ent.saved_targetname;
  }
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
  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

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

teleport_onStartGameSIEGE() {
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

      level.dom_flag_data[zone.name][domFlag.useObj.label] = data;
    }
  }

  startingZone = "start";

  AssertEx(isDefined(level.teleport_zones[startingZone]), "Start teleport zone does not exist");

  level.flags = level.teleport_zones[startingZone].flags;
  level.domFlags = level.teleport_zones[startingZone].domFlags;

  foreach(zone in level.teleport_zones) {
    foreach(flag in zone.flags) {
      if(zone.name == startingZone) {
        continue;
      }
      flag.useobj.visuals[0] Delete();
      flag.useObj maps\mp\gametypes\_gameobjects::deleteUseObject();
    }
  }

  game["teleport_zone_dom"] = startingZone;
  teleport_gamemode_disable_teleport();
  teleport_onTeleportSIEGE(startingZone);
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
  foreach(domFlag in level.flags) {
    data = level.dom_flag_data[next_zone_name][domFlag.useObj.label];
    domFlag.origin = data.trigger_origin;
    domFlag.useobj.visuals[0].origin = data.visual_origin;
    domFlag.useobj.baseeffectpos = data.baseeffectpos;
    domFlag.useobj.baseeffectforward = data.baseeffectforward;
    domFlag.useObj maps\mp\gametypes\dom::resetFlagBaseEffect();
    domFlag.teleport_zone = next_zone_name;
    domflag.nodes = data.nodes;
    foreach(teamname, objId in domFlag.useObj.teamObjIds) {
      Objective_Position(objId, data.obj_origin);
    }

    foreach(team in level.teamnamelist) {
      opName = "objpoint_" + team + "_" + domFlag.useObj.entNum;
      objPoint = maps\mp\gametypes\_objpoints::getObjPointByName(opName);
      objPoint.x = data.obj3d_origins[team][0];
      objPoint.y = data.obj3d_origins[team][1];
      objPoint.z = data.obj3d_origins[team][2];
    }
  }
}

teleport_onTeleportSIEGE(zone_name) {
  foreach(domFlag in level.flags) {
    data = level.dom_flag_data[zone_name][domFlag.useObj.label];
    domFlag.origin = data.trigger_origin;
    domFlag.useobj.visuals[0].origin = data.visual_origin;
    domFlag.useobj.baseeffectpos = data.baseeffectpos;
    domFlag.useobj.baseeffectforward = data.baseeffectforward;
    domFlag.useObj maps\mp\gametypes\dom::resetFlagBaseEffect();
    domFlag.teleport_zone = zone_name;
    domflag.nodes = data.nodes;
    foreach(teamname, objId in domFlag.useObj.teamObjIds) {
      Objective_Position(objId, data.obj_origin);
    }

    foreach(team in level.teamnamelist) {
      opName = "objpoint_" + team + "_" + domFlag.useObj.entNum;
      objPoint = maps\mp\gametypes\_objpoints::getObjPointByName(opName);
      objPoint.x = data.obj3d_origins[team][0];
      objPoint.y = data.obj3d_origins[team][1];
      objPoint.z = data.obj3d_origins[team][2];
    }
  }
}

teleport_get_matching_dom_flag(flag, from_zone) {
  foreach(dom_flag in level.teleport_zones[from_zone].flags) {
    if(flag.useobj.label == dom_flag.useobj.label)
      return dom_flag;
  }
  return undefined;
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

teleport_set_a10_splines_for_zone(zone_name, inBoundList, outBoundList) {
  level.teleport_a10_inBoundList[zone_name] = inBoundList;
  level.teleport_a10_outBoundList[zone_name] = outBoundList;
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
    if(!isDefined(struct.script_noteworthy))
      struct.script_noteworthy = "teleport_origin";

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
        if(!isDefined(struct.script_parameters))
          struct.script_parameters = "none,axis,allies";

        toks = strTok(struct.script_parameters, ", ");
        foreach(tok in toks) {
          if(!isDefined(zone.teleport_origins[tok])) {
            println("^3_teleport.gsc: Unknown Team " + tok + " on teleport origin at " + struct.origin);
            continue;
          }

          if(!isDefined(struct.angles))
            struct.angles = (0, 0, 0);

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
  if(!isDefined(dvar_default))
    dvar_default = "";

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
  if(!isDefined(filter_zone))
    filter_zone = level.teleport_zone_current;

  valid_spawns = [];
  foreach(spawnPoint in spawnPoints) {
    if(!isDefined(spawnPoint.index))
      spawnPoint.index = "ent_" + spawnPoint GetEntityNumber();
    if(!isDefined(level.teleport_spawn_info[spawnPoint.index]))
      teleport_init_spawn_info(spawnPoint);

    if(level.teleport_spawn_info[spawnPoint.index].zone == filter_zone)
      valid_spawns[valid_spawns.size] = spawnPoint;
  }

  return valid_spawns;
}

teleport_init_spawn_info(spawner) {
  if(isDefined(level.teleport_spawn_info[spawner.index])) {
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

  level.teleport_spawn_info[spawner.index] = s;
}

teleport_is_valid_zone(zone_name) {
  foreach(name, zones in level.teleport_zones) {
    if(name == zone_name)
      return true;
  }

  return false;
}

teleport_to_zone(zone_name, run_event_funcs) {
  if(!level.teleport_allowed) {
    return;
  }
  if(!isDefined(run_event_funcs))
    run_event_funcs = true;

  pre_func = level.teleport_pre_funcs[zone_name];
  if(isDefined(pre_func) && run_event_funcs)
    [[pre_func]]();

  current = level.teleport_zones[level.teleport_zone_current];
  next = level.teleport_zones[zone_name];

  if(!isDefined(current) || !isDefined(next)) {
    return;
  }
  teleport_to_zone_players(zone_name);
  teleport_to_zone_agents(zone_name);
  if(level.teleport_include_killsteaks)
    teleport_to_zone_killstreaks(zone_name);

  if(isDefined(level.teleport_gameMode_func))
    [[level.teleport_gameMode_func]](zone_name);

  teleport_set_current_zone(zone_name);

  level notify("teleport_to_zone", zone_name);

  post_func = level.teleport_post_funcs[zone_name];
  if(isDefined(post_func) && run_event_funcs)
    [[post_func]]();

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["post_teleport"]))
    [[level.bot_funcs["post_teleport"]]]();
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
  if(isPlayer(character))
    teleport_angles = character GetPlayerAngles();

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
  level waittill("teleport_to_zone");
  if(isDefined(player)) {
    player_zone = teleport_closest_zone(player.origin);
    if(player_zone.name != level.teleport_zone_current)
      player _suicide();
  }
}

get_teleport_delta(zone_name) {
  next_zone = level.teleport_zones[zone_name];
  current_zone = level.teleport_zones[level.teleport_zone_current];
  delta = next_zone.origin - current_zone.origin;
  return delta;
}

teleport_to_zone_killstreaks(zone_name) {
  delta = get_teleport_delta(zone_name);

  teleport_add_delta(level.ac130, delta);

  array_levelthread_safe(level.heli_start_nodes, ::teleport_add_delta_targets, delta);
  array_levelthread_safe(level.heli_loop_nodes, ::teleport_add_delta_targets, delta);
  array_levelthread_safe(level.heli_loop_nodes2, ::teleport_add_delta_targets, delta);
  array_levelthread_safe(level.strafe_nodes, ::teleport_add_delta_targets, delta);
  array_levelthread_safe(level.heli_leave_nodes, ::teleport_add_delta_targets, delta);
  array_levelthread_safe(level.heli_crash_nodes, ::teleport_add_delta_targets, delta);

  if(isDefined(level.chopper)) {
    level.chopper.largeProjectileDamage = true;
    level.chopper notify("death");
  }

  teleport_add_delta(level.UAVRig, delta);
  teleport_add_delta(level.remote_mortar, delta);

  teleport_add_delta(level.heli_pilot_mesh, delta);

  array_thread_safe(level.air_start_nodes, ::teleport_self_add_delta, delta);
  foreach(loc in level.air_start_nodes)
  array_thread_safe(loc.neighbors, ::teleport_self_add_delta, delta);

  array_thread_safe(level.air_node_mesh, ::teleport_self_add_delta, delta);
  foreach(loc in level.air_node_mesh)
  array_thread_safe(loc.neighbors, ::teleport_self_add_delta, delta);

  array_thread_safe(level.littleBirds, ::teleport_notify_death);

  teleport_add_delta(level.lbSniper, delta);

  airstrikeheight = GetEnt("airstrikeheight", "targetname");
  teleport_add_delta(airstrikeheight, delta);

  points = getEntArray("mp_airsupport", "classname");
  array_thread_safe(points, ::teleport_self_add_delta, delta);

  heli_attack_area = getEntArray("heli_attack_area", "targetname");
  array_thread_safe(heli_attack_area, ::teleport_self_add_delta, delta);

  array_thread_safe(level.lasedStrikeEnts, ::teleport_self_add_delta, delta);

  remote_uav_range = GetEnt("remote_uav_range", "targetname");
  teleport_add_delta(remote_uav_range, delta);

  foreach(participant in level.participants) {
    if(isDefined(participant.ballDrone)) {
      participant.ballDrone teleport_notify_death();
    }
  }

  if(isDefined(level.uplinks)) {
    foreach(uplink in level.uplinks)
    uplink notify("death");
  }

  remoteMissileSpawnArray = getEntArray("remoteMissileSpawn", "targetname");
  array_thread_safe(remoteMissileSpawnArray, ::teleport_self_add_delta, delta);
  foreach(spawn in remoteMissileSpawnArray) {
    if(isDefined(spawn.target))
      spawn.targetEnt = getEnt(spawn.target, "targetname");
    if(isDefined(spawn.targetEnt))
      teleport_add_delta(spawn.targetEnt, delta);
  }

  foreach(ims in level.ims) {
    ims notify("death");
    teleport_add_delta(ims, delta);
    if(!teleport_place_on_ground(ims))
      ims Delete();
  }

  foreach(turret in level.turrets) {
    turret notify("death");
    teleport_add_delta(turret, delta);
    if(!teleport_place_on_ground(turret))
      turret Delete();
  }

  packages = teleport_get_care_packages();
  foreach(package in packages) {
    package maps\mp\killstreaks\_airdrop::deleteCrate();
  }

  boxes = teleport_get_deployable_boxes();
  foreach(box in boxes) {
    box teleport_notify_death();
  }

  foreach(uav in level.remote_uav) {
    uav teleport_notify_death();
  }

  vehicles = Vehicle_GetArray();
  foreach(vehicle in vehicles) {
    if(isDefined(vehicle.model) && vehicle.model == "vehicle_odin_mp") {
      vehicle teleport_notify_death();
    }
  }

  if(isDefined(level.teleport_a10_inBoundList[zone_name])) {
    level.a10SplinesIn = level.teleport_a10_inBoundList[zone_name];
  }
  if(isDefined(level.teleport_a10_outBoundList[zone_name])) {
    level.a10SplinesOut = level.teleport_a10_outBoundList[zone_name];
  }

  if(isDefined(level.intelEnt)) {
    level.intelEnt["dropped_time"] = -60000;
  }

}

teleport_notify_death() {
  if(isDefined(self))
    self notify("death");
}

array_thread_safe(entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(entities))
    return;
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
  if(!isDefined(max_trace))
    max_trace = 300;

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