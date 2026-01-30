/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42837.gsc
**************************************/

main() {
  thread main_thread();
}

main_thread() {
  var_0 = common_scripts\utility::getstructarray("teleport_world_origin", "targetname");
  var_1 = level.gametype;

  if(!var_0.size || !(var_1 == "dom" || var_1 == "ctf" || var_1 == "hp" || var_1 == "ball")) {
    return;
  }
  common_scripts\utility::flag_init("teleport_setup_complete");
  level.teleport_minimaps = [];
  level.teleport_allowed = 1;
  level.teleport_to_offset = 0;
  level.teleport_to_nodes = 0;
  level.teleport_include_killsteaks = 0;
  level.teleport_include_players = 0;
  level.teleport_gamemode_func = undefined;
  level.teleport_pre_funcs = [];
  level.teleport_post_funcs = [];
  level.teleport_nodes_in_zone = [];
  level.teleport_pathnode_zones = [];
  level.teleport_onstartgametype = level.onstartgametype;
  level.onstartgametype = ::teleport_onstartgametype;
  level.teleportgetactivenodesfunc = ::teleport_get_active_nodes;
  level.teleportgetactivepathnodezonesfunc = ::teleport_get_active_pathnode_zones;
}

teleport_init() {
  level.teleport_spawn_info = [];
  var_0 = common_scripts\utility::getstructarray("teleport_world_origin", "targetname");

  if(!var_0.size) {
    return;
  }
  level.teleport_zones = [];

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      var_2.script_noteworthy = "zone_" + level.teleport_zones.size;
    }

    var_2.name = var_2.script_noteworthy;
    teleport_parse_zone_targets(var_2);
    level.teleport_nodes_in_zone[var_2.name] = [];
    level.teleport_pathnode_zones[var_2.name] = [];
    level.teleport_zones[var_2.script_noteworthy] = var_2;
  }

  var_4 = getallnodes();

  foreach(var_6 in var_4) {
    var_2 = teleport_closest_zone(var_6.origin);
    level.teleport_nodes_in_zone[var_2.name][level.teleport_nodes_in_zone[var_2.name].size] = var_6;
  }

  for(var_8 = 0; var_8 < getzonecount(); var_8++) {
    var_2 = teleport_closest_zone(getzoneorigin(var_8));
    level.teleport_pathnode_zones[var_2.name][level.teleport_pathnode_zones[var_2.name].size] = var_8;
  }

  if(!isDefined(level.teleport_zone_current)) {
    if(isDefined(level.teleport_zones["start"])) {
      teleport_set_current_zone("start");
    } else {
      foreach(var_11, var_10 in level.teleport_zones) {
        teleport_set_current_zone(var_11);
        break;
      }
    }
  }
}

teleport_onstartgametype() {
  teleport_init();
  var_0 = undefined;
  var_1 = undefined;

  switch (level.gametype) {
    case "dom":
      var_1 = ::teleport_onstartgamedom;
      break;
    case "ctf":
      var_1 = ::teleport_onstartgamectf;
      break;
    case "hp":
      var_1 = ::teleport_onstartgamehp;
      break;
    case "ball":
      var_1 = ::teleport_onstartgameball;
      break;
    default:
      break;
  }

  if(isDefined(var_0)) {
    level[[var_0]]();
  }

  level[[level.teleport_onstartgametype]]();

  if(isDefined(var_1)) {
    level[[var_1]]();
  }

  common_scripts\utility::flag_set("teleport_setup_complete");
}

teleport_pre_onstartgamesr() {
  teleport_pre_onstartgamesd_and_sr();
}

teleport_pre_onstartgamesd() {
  teleport_pre_onstartgamesd_and_sr();
}

teleport_pre_onstartgamesd_and_sr() {
  foreach(var_1 in level.teleport_zones) {
    var_1.sd_triggers = [];
    var_1.sd_bombs = [];
    var_1.sd_bombzones = [];
  }

  var_3 = getEntArray("sd_bomb_pickup_trig", "targetname");

  foreach(var_5 in var_3) {
    var_6 = teleport_closest_zone(var_5.origin);

    if(isDefined(var_6)) {
      var_6.sd_triggers[var_6.sd_triggers.size] = var_5;
      teleport_change_targetname(var_5, var_6.name);
    }
  }

  var_8 = getEntArray("sd_bomb", "targetname");

  foreach(var_10 in var_8) {
    var_6 = teleport_closest_zone(var_10.origin);

    if(isDefined(var_6)) {
      var_6.sd_bombs[var_6.sd_bombs.size] = var_10;
      teleport_change_targetname(var_10, var_6.name);
    }
  }

  var_12 = getEntArray("bombzone", "targetname");

  foreach(var_14 in var_12) {
    var_6 = teleport_closest_zone(var_14.origin);

    if(isDefined(var_6)) {
      var_6.sd_bombzones[var_6.sd_bombzones.size] = var_14;
      teleport_change_targetname(var_14, var_6.name);
    }
  }

  var_16 = [];

  foreach(var_1 in level.teleport_zones) {
    if(var_1.sd_triggers.size && var_1.sd_triggers.size && var_1.sd_triggers.size) {
      var_16[var_16.size] = var_1.name;
    }
  }

  teleport_gamemode_disable_teleport(var_16);
  var_19 = level.teleport_zones[level.teleport_zone_current];
  teleport_restore_targetname(var_19.sd_triggers);
  teleport_restore_targetname(var_19.sd_bombs);
  teleport_restore_targetname(var_19.sd_bombzones);
}

teleport_onstartgamehorde() {
  foreach(var_1 in level.teleport_zones) {
    var_1.horde_drops = [];
  }

  var_3 = common_scripts\utility::getstructarray("horde_drop", "targetname");

  foreach(var_5 in var_3) {
    var_6 = teleport_closest_zone(var_5.origin);

    if(isDefined(var_6)) {
      var_6.horde_drops[var_6.horde_drops.size] = var_5;
    }
  }

  var_8 = [];

  foreach(var_1 in level.teleport_zones) {
    if(var_1.horde_drops.size) {
      var_8[var_8.size] = var_1.name;
    }
  }

  teleport_gamemode_disable_teleport(var_8);
  var_11 = level.teleport_zones[level.teleport_zone_current];
  level.struct_class_names["targetname"]["horde_drop"] = var_11.horde_drops;
}

teleport_change_targetname(var_0, var_1) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  if(!isDefined(var_1)) {
    var_1 = "hide_from_getEnt";
  }

  foreach(var_3 in var_0) {
    var_3.saved_targetname = var_3.targetname;
    var_3.targetname = var_3.targetname + "_" + var_1;
  }
}

teleport_gamemode_disable_teleport(var_0) {
  if(!isDefined(var_0)) {
    var_0 = getarraykeys(level.teleport_zones);
  }

  var_1 = game["teleport_zone_dom"];

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::random(var_0);
    game["teleport_zone_dom"] = var_1;
  }

  teleport_to_zone(var_1, 0);
  level.teleport_allowed = 0;
}

teleport_restore_targetname(var_0) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_2 in var_0) {
    if(isDefined(var_2.saved_targetname)) {
      var_2.targetname = var_2.saved_targetname;
    }
  }
}

teleport_onstartgamectf() {
  level.teleport_gamemode_func = ::teleport_onteleportctf;
}

teleport_onstartgamehp() {
  if(!isDefined(level.number_of_hp_zones_pre_teleport)) {
    level.number_of_hp_zones_pre_teleport = 5;
  }

  level.pre_event_hp_zones = [];
  level.post_event_hp_zones = [];
  level.all_hp_zones = level.zones;

  foreach(var_1 in level.zones) {
    if(var_1.script_index > level.number_of_hp_zones_pre_teleport) {
      level.post_event_hp_zones[level.post_event_hp_zones.size] = var_1;
      continue;
    }

    level.pre_event_hp_zones[level.pre_event_hp_zones.size] = var_1;
  }

  level.zones = level.pre_event_hp_zones;
  level.teleport_gamemode_func = ::teleport_onteleporthp;
}

teleport_onstartgameball() {
  level.teleport_gamemode_func = ::teleport_onteleportball;
}

teleport_onstartgamedom() {
  foreach(var_1 in level.teleport_zones) {
    var_1.flags = [];
    var_1.domflags = [];
  }

  level.all_dom_flags = level.flags;

  foreach(var_4 in level.flags) {
    var_5 = teleport_closest_zone(var_4.origin);

    if(isDefined(var_5)) {
      var_4.teleport_zone = var_5.name;
      var_5.flags[var_5.flags.size] = var_4;
      var_5.domflags[var_5.domflags.size] = var_4.useobj;
    }
  }

  level.dom_flag_data = [];

  foreach(var_1 in level.teleport_zones) {
    foreach(var_9 in var_1.flags) {
      var_10 = spawnStruct();
      var_10.trigger_origin = var_9.origin;
      var_10.visual_origin = var_9.useobj.visuals[0].origin;
      var_10.baseeffectpos = var_9.useobj.baseeffectpos;
      var_10.baseeffectforward = var_9.useobj.baseeffectforward;
      var_10.baseeffectright = var_9.useobj.baseeffectright;
      var_10.obj_origin = var_9.useobj.curorigin;
      var_10.obj3d_origins = [];

      foreach(var_12 in level.teamnamelist) {
        var_13 = "objpoint_" + var_12 + "_" + var_9.useobj.entnum;
        var_14 = maps\mp\gametypes\_objpoints::getobjpointbyname(var_13);

        if(isDefined(var_14)) {
          var_10.obj3d_origins[var_12] = (var_14.x, var_14.y, var_14.z);
        }
      }

      var_13 = "objpoint_mlg_" + var_9.useobj.entnum;
      var_14 = maps\mp\gametypes\_objpoints::getobjpointbyname(var_13);

      if(isDefined(var_14)) {
        var_10.obj3d_origins["mlg"] = (var_14.x, var_14.y, var_14.z);
      }

      level.dom_flag_data[var_1.name][var_9.useobj.label] = var_10;
    }
  }

  level.flags = level.teleport_zones[level.teleport_zone_current].flags;
  level.domflags = level.teleport_zones[level.teleport_zone_current].domflags;

  foreach(var_1 in level.teleport_zones) {
    foreach(var_4 in var_1.flags) {
      if(var_1.name == level.teleport_zone_current) {
        continue;
      }
      var_4.useobj.visuals[0] delete();
      var_4.useobj maps\mp\gametypes\_gameobjects::deleteuseobject();
    }
  }

  level.teleport_gamemode_func = ::teleport_onteleportdom;
  teleport_onteleportdom(level.teleport_zone_current);
  level.teleport_dom_finished_initializing = 1;
  level thread teleport_dom_post_bot_cleanup();
}

teleport_dom_post_bot_cleanup() {
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  foreach(var_1 in level.teleport_zones) {
    foreach(var_3 in var_1.flags) {
      var_4 = level.dom_flag_data[var_1.name][var_3.useobj.label];
      var_4.nodes = var_3.nodes;

      if(var_1.name != level.teleport_zone_current) {
        var_3 delete();
      }
    }
  }
}

teleport_onstartgameconf() {
  level.teleport_gamemode_func = ::teleport_onteleportconf;
}

teleport_onteleportdom(var_0) {
  var_1 = level.teleport_zones[level.teleport_zone_current];
  var_2 = level.teleport_zones[var_0];

  if(var_0 == level.teleport_zone_current) {
    return;
  }
  foreach(var_4 in level.domflags) {
    var_4 maps\mp\gametypes\_gameobjects::setownerteam("neutral");
    var_4 maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_captureneutral" + var_4.label);
    var_4 maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_captureneutral" + var_4.label);
    var_4 maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_captureneutral" + var_4.label);
    var_4 maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_captureneutral" + var_4.label);
    var_4 maps\mp\gametypes\_gameobjects::set2dicon("mlg", "waypoint_esports_dom_white" + var_4.label);
    var_4 maps\mp\gametypes\_gameobjects::set3dicon("mlg", "waypoint_esports_dom_white" + var_4.label);
    var_4.firstcapture = 1;
  }

  foreach(var_4 in level.flags) {
    var_7 = level.dom_flag_data[var_0][var_4.useobj.label];
    var_4.origin = var_7.trigger_origin;
    var_4.useobj.visuals[0].origin = var_7.visual_origin;
    var_4.useobj.baseeffectpos = var_7.baseeffectpos;
    var_4.useobj.baseeffectforward = var_7.baseeffectforward;
    var_4.useobj maps\mp\gametypes\dom::updatevisuals();
    var_4.teleport_zone = var_0;
    var_4.nodes = var_7.nodes;

    if(isDefined(var_4.useobj.objidallies)) {
      objective_position(var_4.useobj.objidallies, var_7.obj_origin);
    }

    if(isDefined(var_4.useobj.objidaxis)) {
      objective_position(var_4.useobj.objidaxis, var_7.obj_origin);
    }

    if(isDefined(var_4.useobj.objidmlgspectator)) {
      objective_position(var_4.useobj.objidmlgspectator, var_7.obj_origin);
    }

    foreach(var_9 in level.teamnamelist) {
      var_10 = "objpoint_" + var_9 + "_" + var_4.useobj.entnum;
      var_11 = maps\mp\gametypes\_objpoints::getobjpointbyname(var_10);
      var_11.x = var_7.obj3d_origins[var_9][0];
      var_11.y = var_7.obj3d_origins[var_9][1];
      var_11.z = var_7.obj3d_origins[var_9][2];
    }

    var_10 = "objpoint_mlg_" + var_4.useobj.entnum;
    var_11 = maps\mp\gametypes\_objpoints::getobjpointbyname(var_10);
    var_11.x = var_7.obj3d_origins["mlg"][0];
    var_11.y = var_7.obj3d_origins["mlg"][1];
    var_11.z = var_7.obj3d_origins["mlg"][2];
  }

  maps\mp\gametypes\dom::flagsetup();

  foreach(var_15 in level.domflags) {
    var_16 = var_15.label;

    foreach(var_18 in level.teleport_zones["start"].domflags) {
      if(var_18.label == var_16) {
        var_15.levelflag = var_18.levelflag;
      }
    }
  }

  foreach(var_15 in level.flags) {
    var_16 = var_15.label;

    foreach(var_23 in level.teleport_zones["start"].flags) {
      if(var_23.label == var_16) {
        var_15.levelflag = var_23.levelflag;
      }
    }
  }
}

teleport_get_matching_dom_flag(var_0, var_1) {
  foreach(var_3 in level.teleport_zones[var_1].flags) {
    if(var_0.useobj.label == var_3.useobj.label) {
      return var_3;
    }
  }

  return undefined;
}

teleport_onteleportctf(var_0) {
  if(game["switchedsides"]) {
    level.ctf_second_zones["axis"] = getent("post_event_capzone_allies", "targetname");
    level.ctf_second_zones["allies"] = getent("post_event_capzone_axis", "targetname");
  } else {
    level.ctf_second_zones["allies"] = getent("post_event_capzone_allies", "targetname");
    level.ctf_second_zones["axis"] = getent("post_event_capzone_axis", "targetname");
  }

  var_1 = [];
  var_1["allies"] = level.capzones["allies"];
  var_1["axis"] = level.capzones["axis"];
  var_2["allies"] = level.teamflags["allies"];
  var_2["axis"] = level.teamflags["axis"];
  var_3["allies"] = level.ctf_second_zones["allies"].origin;
  var_3["axis"] = level.ctf_second_zones["axis"].origin;

  foreach(var_5 in var_1) {
    var_5 maps\mp\gametypes\_gameobjects::move_use_object(var_3[var_5.ownerteam], (0, 0, 85));
    var_5.trigger common_scripts\utility::trigger_off();
  }

  foreach(var_8 in level.teamflags) {
    var_8 maps\mp\gametypes\_gameobjects::move_use_object(var_3[var_8.ownerteam], (0, 0, 85));

    if(isDefined(var_8.carrier)) {
      var_8 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
      var_8 maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconkill2d);
      var_8 maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconkill3d);
      var_8 maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconescort2d);
      var_8 maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconescort3d);
      level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::allowuse("none");
      level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
      level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconwaitforflag2d);
      level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconwaitforflag3d);

      if(var_8.ownerteam == "allies") {
        level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconmissingblue);
        level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconmissingblue);
        continue;
      }

      level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set2dicon("mlg", level.iconmissingred);
      level.capzones[var_8.ownerteam] maps\mp\gametypes\_gameobjects::set3dicon("mlg", level.iconmissingred);
    }
  }

  maps\mp\gametypes\ctf::capturezone_reset_base_effects();
  maps\mp\gametypes\ctf::reassign_ctf_team_spawns();

  foreach(var_5 in var_1) {
    var_5.trigger common_scripts\utility::trigger_on();
  }
}

teleport_onteleporthp(var_0) {
  level.zones = level.post_event_hp_zones;

  if(level.randomzonespawn == 0) {
    level.prevzoneindex = level.zones.size - 1;
  } else {
    level.zonespawnqueue = [];
    maps\mp\gametypes\hp::shufflezones();
  }

  setomnvar("ui_hardpoint_timer", 0);
  level notify("zone_moved");
}

teleport_onteleportball(var_0) {
  level.ball_starts_post_event = common_scripts\utility::getstructarray("ball_start_post_event", "targetname");

  if(game["switchedsides"]) {
    level.ball_goals_post_event["allies"] = common_scripts\utility::getstruct("ball_goal_axis_post_event", "targetname");
    level.ball_goals_post_event["axis"] = common_scripts\utility::getstruct("ball_goal_allies_post_event", "targetname");
  } else {
    level.ball_goals_post_event["axis"] = common_scripts\utility::getstruct("ball_goal_axis_post_event", "targetname");
    level.ball_goals_post_event["allies"] = common_scripts\utility::getstruct("ball_goal_allies_post_event", "targetname");
  }

  var_1 = [];
  var_1["allies"] = level.ball_goals["allies"];
  var_1["axis"] = level.ball_goals["axis"];
  var_2 = [];
  var_2["allies"] = level.ball_goals_post_event["allies"].origin;
  var_2["axis"] = level.ball_goals_post_event["axis"].origin;

  foreach(var_4 in var_1) {
    var_5 = (0, 0, var_4.radius / 2 * 1.1);
    var_4.useobject maps\mp\gametypes\_gameobjects::move_use_object(var_2[var_4.team], var_5);
    var_4 maps\mp\gametypes\ball::ball_find_ground();

    foreach(var_7 in level.players) {
      maps\mp\gametypes\ball::ball_goal_fx_for_player(var_7);
    }
  }

  bot_setup_ball_jump_nodes();
  var_10 = getzonenearest(level.ball_goals["allies"].origin);

  if(isDefined(var_10)) {
    botzonesetteam(var_10, "allies");
  }

  var_10 = getzonenearest(level.ball_goals["axis"].origin);

  if(isDefined(var_10)) {
    botzonesetteam(var_10, "axis");
  }

  level.ball_starts = [];

  foreach(var_12 in level.ball_starts_post_event) {
    maps\mp\gametypes\ball::ball_add_start(var_12.origin);
  }

  foreach(var_15 in level.balls) {
    var_16 = 0;

    foreach(var_7 in level.players) {
      if(isDefined(var_7.ball_carried) && var_7.ball_carried == var_15) {
        var_16 = 1;
        break;
      }
    }

    if(var_16 != 1) {
      var_15 maps\mp\gametypes\ball::ball_return_home();
    }
  }
}

bot_setup_ball_jump_nodes() {
  var_0 = 400;
  wait 1.0;
  var_1 = 0;
  var_2 = 10;

  foreach(var_4 in level.ball_goals) {
    var_4.ball_jump_nodes = [];
    var_5 = getnodesinradius(var_4.origin, var_0, 0);

    foreach(var_7 in var_5) {
      if(var_7.type == "End") {
        continue;
      }
      var_1++;

      if(bot_ball_origin_can_see_goal(var_7.origin, var_4, 1)) {
        var_4.ball_jump_nodes[var_4.ball_jump_nodes.size] = var_7;
      }

      if(var_1 % var_2 == 0) {
        wait 0.05;
      }
    }

    var_9 = 999999999;

    foreach(var_7 in var_4.ball_jump_nodes) {
      var_11 = distance2dsquared(var_7.origin, var_4.origin);

      if(var_11 < var_9) {
        var_4.nearest_node = var_7;
        var_9 = var_11;
      }
    }

    wait 0.05;
  }
}

bot_ball_origin_can_see_goal(var_0, var_1, var_2) {
  var_3 = bot_ball_trace_to_origin(var_0, var_1.origin);

  if(isDefined(var_2) && var_2) {
    if(!var_3) {
      var_4 = var_1.origin - (0, 0, var_1.radius * 0.5);
      var_3 = bot_ball_trace_to_origin(var_0, var_4);
    }

    if(!var_3) {
      var_4 = var_1.origin + (0, 0, var_1.radius * 0.5);
      var_3 = bot_ball_trace_to_origin(var_0, var_4);
    }
  }

  return var_3;
}

bot_ball_trace_to_origin(var_0, var_1) {
  if(isDefined(self) && (isplayer(self) || isagent(self))) {
    var_2 = playerphysicstrace(var_0, var_1, self);
  } else {
    var_2 = playerphysicstrace(var_0, var_1);
  }

  return distancesquared(var_2, var_1) < 1;
}

teleport_onteleportconf(var_0) {
  var_1 = get_teleport_delta(var_0);

  foreach(var_3 in level.dogtags) {
    var_4 = var_3.curorigin + var_1;
    var_5 = teleport_get_safe_node_near(var_4);

    if(isDefined(var_5)) {
      var_5.last_teleport_time = gettime();
      var_6 = var_5.origin - var_3.curorigin;
      var_3.curorigin = var_3.curorigin + var_6;
      var_3.trigger.origin = var_3.trigger.origin + var_6;
      var_3.visuals[0].origin = var_3.visuals[0].origin + var_6;
      var_3.visuals[1].origin = var_3.visuals[1].origin + var_6;
      continue;
    }

    var_3 maps\mp\gametypes\conf::resettags();
  }
}

teleport_get_safe_node_near(var_0) {
  var_1 = gettime();
  var_2 = getnodesinradiussorted(var_0, 300, 0, 200, "Path");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(isDefined(var_4.last_teleport_time) && var_4.last_teleport_time == var_1) {
      continue;
    }
    return var_4;
  }

  return undefined;
}

teleport_closest_zone(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.teleport_zones) {
    var_5 = distancesquared(var_4.origin, var_0);

    if(!isDefined(var_1) || var_5 < var_1) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return var_2;
}

teleport_origin_use_nodes(var_0) {
  level.teleport_to_nodes = var_0;
}

teleport_origin_use_offset(var_0) {
  level.teleport_to_offset = var_0;
}

teleport_include_killstreaks(var_0) {
  level.teleport_include_killsteaks = var_0;
}

teleport_set_minimap_for_zone(var_0, var_1) {
  level.teleport_minimaps[var_0] = var_1;
}

teleport_set_pre_func(var_0, var_1) {
  level.teleport_pre_funcs[var_1] = var_0;
}

teleport_set_post_func(var_0, var_1) {
  level.teleport_post_funcs[var_1] = var_0;
}

teleport_parse_zone_targets(var_0) {
  if(isDefined(var_0.origins_pasrsed) && var_0.origins_pasrsed) {
    return;
  }
  var_0.teleport_origins = [];
  var_0.teleport_origins["none"] = [];
  var_0.teleport_origins["allies"] = [];
  var_0.teleport_origins["axis"] = [];
  var_1 = common_scripts\utility::getstructarray("teleport_zone_" + var_0.name, "targetname");

  if(isDefined(var_0.target)) {
    var_2 = common_scripts\utility::getstructarray(var_0.target, "targetname");
    var_1 = common_scripts\utility::array_combine(var_2, var_1);
  }

  foreach(var_4 in var_1) {
    if(!isDefined(var_4.script_noteworthy)) {
      var_4.script_noteworthy = "teleport_origin";
    }

    switch (var_4.script_noteworthy) {
      case "teleport_origin":
        var_5 = var_4.origin + (0, 0, 1);
        var_6 = var_4.origin - (0, 0, 250);
        var_7 = bulletTrace(var_5, var_6, 0);

        if(var_7["fraction"] == 1.0) {
          break;
        }

        var_4.origin = var_7["position"];
      case "telport_origin_nodrop":
        if(!isDefined(var_4.script_parameters)) {
          var_4.script_parameters = "none,axis,allies";
        }

        var_8 = strtok(var_4.script_parameters, ", ");

        foreach(var_10 in var_8) {
          if(!isDefined(var_0.teleport_origins[var_10])) {
            continue;
          }
          if(!isDefined(var_4.angles)) {
            var_4.angles = (0, 0, 0);
          }

          var_11 = var_0.teleport_origins[var_10].size;
          var_0.teleport_origins[var_10][var_11] = var_4;
        }

        break;
      default:
        break;
    }
  }

  var_0.origins_pasrsed = 1;
}

teleport_set_current_zone(var_0) {
  level.teleport_zone_current = var_0;

  if(isDefined(level.teleport_minimaps[var_0])) {
    maps\mp\_compass::setupminimap(level.teleport_minimaps[var_0]);
  }
}

teleport_filter_spawn_point(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.teleport_zone_current;
  }

  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.teleport_label)) {
      var_4.teleport_label = "ent_" + var_4 getentitynumber();
    }

    if(!isDefined(level.teleport_spawn_info[var_4.teleport_label])) {
      teleport_init_spawn_info(var_4);
    }

    if(level.teleport_spawn_info[var_4.teleport_label].zone == var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

teleport_init_spawn_info(var_0) {
  if(!isDefined(var_0.teleport_label)) {
    var_0.teleport_label = "ent_" + var_0 getentitynumber();
  }

  if(isDefined(level.teleport_spawn_info[var_0.teleport_label])) {
    return;
  }
  var_1 = spawnStruct();
  var_1.spawner = var_0;
  var_2 = undefined;

  foreach(var_4 in level.teleport_zones) {
    var_5 = distance(var_4.origin, var_0.origin);

    if(!isDefined(var_2) || var_5 < var_2) {
      var_2 = var_5;
      var_1.zone = var_4.name;
    }
  }

  level.teleport_spawn_info[var_0.teleport_label] = var_1;
}

teleport_is_valid_zone(var_0) {
  foreach(var_3, var_2 in level.teleport_zones) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

teleport_to_zone(var_0, var_1) {
  if(!level.teleport_allowed) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = level.teleport_pre_funcs[var_0];

  if(isDefined(var_2) && var_1) {
    [[var_2]]();
  }

  var_3 = level.teleport_zones[level.teleport_zone_current];
  var_4 = level.teleport_zones[var_0];

  if(!isDefined(var_3) || !isDefined(var_4)) {
    return;
  }
  if(level.teleport_include_players) {
    teleport_to_zone_players(var_0);
    teleport_to_zone_agents(var_0);
  }

  if(level.teleport_include_killsteaks) {
    teleport_to_zone_killstreaks(var_0);
  }

  if(isDefined(level.teleport_gamemode_func)) {
    [[level.teleport_gamemode_func]](var_0);
  }

  teleport_set_current_zone(var_0);
  level notify("teleport_to_zone", var_0);
  var_5 = level.teleport_post_funcs[var_0];

  if(isDefined(var_5) && var_1) {
    [[var_5]]();
  }

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["post_teleport"])) {
    [[level.bot_funcs["post_teleport"]]]();
  }
}

teleport_to_zone_agents(var_0) {
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_3 in var_1) {
    teleport_to_zone_character(var_0, var_3);
  }
}

teleport_to_zone_players(var_0) {
  foreach(var_2 in level.players) {
    teleport_to_zone_character(var_0, var_2);
  }
}

teleport_to_zone_character(var_0, var_1) {
  var_2 = level.teleport_zones[level.teleport_zone_current];
  var_3 = level.teleport_zones[var_0];
  var_4 = gettime();

  if(isplayer(var_1) && (var_1.sessionstate == "intermission" || var_1.sessionstate == "spectator")) {
    var_5 = getEntArray("mp_global_intermission", "classname");
    var_5 = teleport_filter_spawn_point(var_5, var_0);
    var_6 = var_5[0];
    var_1 dontinterpolate();
    var_1 setorigin(var_6.origin);
    var_1 setangles(var_6.angles);
  } else {
    var_7 = undefined;
    var_8 = var_1.angles;

    if(isplayer(var_1)) {
      var_8 = var_1 getangles();
    }

    foreach(var_14, var_10 in var_3.teleport_origins) {
      var_3.teleport_origins[var_14] = common_scripts\utility::array_randomize(var_10);

      foreach(var_12 in var_10) {
        var_12.claimed = 0;
      }
    }

    var_15 = [];

    if(level.teambased) {
      if(isDefined(var_1.team) && isDefined(var_3.teleport_origins[var_1.team])) {
        var_15 = var_3.teleport_origins[var_1.team];
      }
    } else {
      var_15 = var_3.teleport_origins["none"];
    }

    foreach(var_12 in var_15) {
      if(!var_12.claimed) {
        var_7 = var_12.origin;
        var_8 = var_12.angles;
        var_12.claimed = 1;
        break;
      }
    }

    var_18 = var_3.origin - var_2.origin;
    var_19 = var_1.origin + var_18;

    if(!isDefined(var_7) && level.teleport_to_offset) {
      if(canspawn(var_19) && !positionwouldtelefrag(var_19)) {
        var_7 = var_19;
      }
    }

    if(!isDefined(var_7) && level.teleport_to_nodes) {
      var_20 = getnodesinradiussorted(var_19, 300, 0, 200, "Path");

      for(var_21 = 0; var_21 < var_20.size; var_21++) {
        var_22 = var_20[var_21];

        if(isDefined(var_22.last_teleport_time) && var_22.last_teleport_time == var_4) {
          continue;
        }
        var_12 = var_22.origin;

        if(canspawn(var_12) && !positionwouldtelefrag(var_12)) {
          var_22.last_teleport_time = var_4;
          var_7 = var_12;
          break;
        }
      }
    }

    if(!isDefined(var_7)) {
      var_1 maps\mp\_utility::_suicide();
      return;
    }

    var_1 cancelmantle();
    var_1 dontinterpolate();
    var_1 setorigin(var_7);
    var_1 setangles(var_8);
    thread teleport_validate_success(var_1);
  }
}

teleport_validate_success(var_0) {
  waitframe();

  if(isDefined(var_0)) {
    var_1 = teleport_closest_zone(var_0.origin);

    if(var_1.name != level.teleport_zone_current) {
      var_0 maps\mp\_utility::_suicide();
    }
  }
}

get_teleport_delta(var_0) {
  var_1 = level.teleport_zones[var_0];
  var_2 = level.teleport_zones[level.teleport_zone_current];
  var_3 = var_1.origin - var_2.origin;
  return var_3;
}

teleport_to_zone_killstreaks(var_0) {}

teleport_notify_death() {
  if(isDefined(self)) {
    self notify("death");
  }
}

array_thread_safe(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }
  common_scripts\utility::array_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

array_levelthread_safe(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  common_scripts\utility::array_levelthread(var_0, var_1, var_2, var_3, var_4);
}

teleport_get_care_packages() {
  return getEntArray("care_package", "targetname");
}

teleport_get_deployable_boxes() {
  var_0 = [];
  var_1 = getEntArray("script_model", "classname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.boxtype)) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

teleport_place_on_ground(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 300;
  }

  var_2 = var_0.origin;
  var_3 = var_0.origin - (0, 0, var_1);
  var_4 = bulletTrace(var_2, var_3, 0, var_0);

  if(var_4["fraction"] < 1) {
    var_0.origin = var_4["position"];
    return 1;
  } else {
    return 0;
  }
}

teleport_add_delta_targets(var_0, var_1) {
  if(teleport_delta_this_frame(var_0)) {
    return;
  }
  teleport_add_delta(var_0, var_1);

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");
    var_3 = common_scripts\utility::getstructarray(var_0.target, "targetname");
    var_4 = common_scripts\utility::array_combine(var_2, var_3);
    common_scripts\utility::array_levelthread(var_4, ::teleport_add_delta_targets, var_1);
  }
}

teleport_self_add_delta_targets(var_0) {
  teleport_add_delta_targets(self, var_0);
}

teleport_self_add_delta(var_0) {
  teleport_add_delta(self, var_0);
}

teleport_add_delta(var_0, var_1) {
  if(isDefined(var_0)) {
    if(!teleport_delta_this_frame(var_0)) {
      var_0.origin = var_0.origin + var_1;
      var_0.last_teleport_time = gettime();
    }
  }
}

teleport_delta_this_frame(var_0) {
  return isDefined(var_0.last_teleport_time) && var_0.last_teleport_time == gettime();
}

teleport_get_active_nodes() {
  return level.teleport_nodes_in_zone[level.teleport_zone_current];
}

teleport_get_active_pathnode_zones() {
  return level.teleport_pathnode_zones[level.teleport_zone_current];
}