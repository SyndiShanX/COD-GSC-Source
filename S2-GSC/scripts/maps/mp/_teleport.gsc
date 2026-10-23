/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_teleport.gsc
*****************************************/

main() {
  thread main_thread();
}

main_thread() {
  var_0 = common_scripts\utility::getstructarray("teleport_world_origin", "targetname");
  var_1 = level.gametype;

  if(!var_0.size || !(var_1 == "dom" || var_1 == "ctf" || var_1 == "hp" || var_1 == "undead" || var_1 == "ball")) {
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
    if(!isDefined(var_2._id_0165)) {
      var_2._id_0165 = "zone_" + level.teleport_zones.size;
    }

    var_2.name = var_2._id_0165;
    teleport_parse_zone_targets(var_2);
    level.teleport_nodes_in_zone[var_2.name] = [];
    level.teleport_pathnode_zones[var_2.name] = [];
    level.teleport_zones[var_2._id_0165] = var_2;
  }

  var_4 = _getallnodes();

  foreach(var_6 in var_4) {
    var_2 = teleport_closest_zone(var_6.origin);
    level.teleport_nodes_in_zone[var_2.name][level.teleport_nodes_in_zone[var_2.name].size] = var_6;
  }

  for(var_8 = 0; var_8 < _getzonecount(); var_8++) {
    var_2 = teleport_closest_zone(_getzoneorigin(var_8));
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
    case "undead":
    case "hp":
      var_1 = ::_id_9897;
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

_id_98AB() {
  teleport_pre_onstartgamesd_and_sr();
}

_id_98A9() {
  teleport_pre_onstartgamesd_and_sr();
}

teleport_pre_onstartgamesd_and_sr() {
  foreach(var_1 in level.teleport_zones) {
    var_1.closemenu = [];
    var_1.sd_bombs = [];
    var_1.sd_bombzones = [];
  }

  var_3 = getEntArray("sd_bomb_pickup_trig", "targetname");

  foreach(var_5 in var_3) {
    var_6 = teleport_closest_zone(var_5.origin);

    if(isDefined(var_6)) {
      var_6.closemenu[var_6.closemenu.size] = var_5;
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
    if(var_1.closemenu.size && var_1.closemenu.size && var_1.closemenu.size) {
      var_16[var_16.size] = var_1.name;
    }
  }

  teleport_gamemode_disable_teleport(var_16);
  var_19 = level.teleport_zones[level.teleport_zone_current];
  teleport_restore_targetname(var_19.closemenu);
  teleport_restore_targetname(var_19.sd_bombs);
  teleport_restore_targetname(var_19.sd_bombzones);
}

teleport_change_targetname(var_0, var_1) {
  if(!_isarray(var_0)) {
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
  if(!_isarray(var_0)) {
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

_id_9897() {
  if(!isDefined(level.number_of_hp_zones_pre_teleport)) {
    level.number_of_hp_zones_pre_teleport = 5;
  }

  level.pre_event_hp_zones = [];
  level.post_event_hp_zones = [];
  level._id_0BCF = level.zones;

  foreach(var_1 in level.zones) {
    if(var_1.setmovespeedscale > level.number_of_hp_zones_pre_teleport) {
      level.post_event_hp_zones[level.post_event_hp_zones.size] = var_1;
      continue;
    }

    level.pre_event_hp_zones[level.pre_event_hp_zones.size] = var_1;
  }

  level.zones = level.pre_event_hp_zones;
  level.teleport_gamemode_func = ::teleport_onteleporthp;
}

teleport_onstartgamedom() {
  foreach(var_1 in level.teleport_zones) {
    var_1.flags = [];
    var_1._id_3211 = [];
  }

  level._id_0BCA = level.flags;

  foreach(var_4 in level.flags) {
    var_5 = teleport_closest_zone(var_4.origin);

    if(isDefined(var_5)) {
      var_4.teleport_zone = var_5.name;
      var_5.flags[var_5.flags.size] = var_4;
      var_5._id_3211[var_5._id_3211.size] = var_4.useobj;
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
        var_14 = _id_04EC::getobjpointbyname(var_13);

        if(isDefined(var_14)) {
          var_10.obj3d_origins[var_12] = (var_14.x, var_14.y, var_14._id_01D9);
        }
      }

      var_13 = "objpoint_broadcaster_" + var_9.useobj.entnum;
      var_14 = _id_04EC::getobjpointbyname(var_13);

      if(isDefined(var_14)) {
        var_10.obj3d_origins["broadcaster"] = (var_14.x, var_14.y, var_14._id_01D9);
      }

      level.dom_flag_data[var_1.name][var_9.useobj.label] = var_10;
    }
  }

  level.flags = level.teleport_zones[level.teleport_zone_current].flags;
  level._id_3211 = level.teleport_zones[level.teleport_zone_current]._id_3211;

  foreach(var_1 in level.teleport_zones) {
    foreach(var_4 in var_1.flags) {
      if(var_1.name == level.teleport_zone_current) {
        continue;
      }
      var_4.useobj.visuals[0] delete();
      var_4.useobj _id_04D1::deleteuseobject();
    }
  }

  level.teleport_gamemode_func = ::teleport_onteleportdom;
  teleport_onteleportdom(level.teleport_zone_current);
  level.teleport_dom_finished_initializing = 1;
  level thread teleport_dom_post_bot_cleanup();
}

teleport_dom_post_bot_cleanup() {
  while(!isDefined(level.bot_gametype_precaching_done)) {
    waitframe();
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

_id_9894() {
  level.teleport_gamemode_func = ::teleport_onteleportconf;
}

teleport_onteleportdom(var_0) {
  var_1 = level.teleport_zones[level.teleport_zone_current];
  var_2 = level.teleport_zones[var_0];

  if(var_0 == level.teleport_zone_current) {
    return;
  }
  foreach(var_4 in level._id_3211) {
    var_4 _id_04D1::setownerteam("neutral");
    var_4 _id_04D1::set2dicon("enemy", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::playsoundtoteam("enemy", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::set2dicon("friendly", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::playsoundtoteam("friendly", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::set2dicon("broadcaster", "waypoint_captureneutral" + var_4.label);
    var_4 _id_04D1::playsoundtoteam("broadcaster", "waypoint_captureneutral" + var_4.label, 3);
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
      _objective_position(var_4.useobj.objidallies, var_7.obj_origin);
    }

    if(isDefined(var_4.useobj.objidaxis)) {
      _objective_position(var_4.useobj.objidaxis, var_7.obj_origin);
    }

    if(isDefined(var_4.useobj.objidmlgspectator)) {
      _objective_position(var_4.useobj.objidmlgspectator, var_7.obj_origin);
    }

    foreach(var_9 in level.teamnamelist) {
      var_10 = "objpoint_" + var_9 + "_" + var_4.useobj.entnum;
      var_11 = _id_04EC::getobjpointbyname(var_10);
      var_11.x = var_7.obj3d_origins[var_9][0];
      var_11.y = var_7.obj3d_origins[var_9][1];
      var_11._id_01D9 = var_7.obj3d_origins[var_9][2];
    }

    var_10 = "objpoint_broadcaster_" + var_4.useobj.entnum;
    var_11 = _id_04EC::getobjpointbyname(var_10);
    var_11.x = var_7.obj3d_origins["broadcaster"][0];
    var_11.y = var_7.obj3d_origins["broadcaster"][1];
    var_11._id_01D9 = var_7.obj3d_origins["broadcaster"][2];
  }

  maps\mp\gametypes\dom::flagsetuplegacy();

  foreach(var_15 in level._id_3211) {
    var_16 = var_15.label;

    foreach(var_18 in level.teleport_zones["start"]._id_3211) {
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
    level.ctf_second_zones["axis"] = _getEnt("post_event_capzone_allies", "targetname");
    level.ctf_second_zones["allies"] = _getEnt("post_event_capzone_axis", "targetname");
  } else {
    level.ctf_second_zones["allies"] = _getEnt("post_event_capzone_allies", "targetname");
    level.ctf_second_zones["axis"] = _getEnt("post_event_capzone_axis", "targetname");
  }

  var_1 = [];
  var_1["allies"] = level.capzones["allies"];
  var_1["axis"] = level.capzones["axis"];
  var_2["allies"] = level.teamflags["allies"];
  var_2["axis"] = level.teamflags["axis"];
  var_3["allies"] = level.ctf_second_zones["allies"].origin;
  var_3["axis"] = level.ctf_second_zones["axis"].origin;

  foreach(var_5 in var_1) {
    var_5 _id_04D1::move_use_object(var_3[var_5.ownerteam], (0, 0, 85));
    var_5.trigger common_scripts\utility::trigger_off();
  }

  foreach(var_8 in level.teamflags) {
    var_8 _id_04D1::move_use_object(var_3[var_8.ownerteam], (0, 0, 85));

    if(isDefined(var_8.carrier)) {
      var_8 _id_04D1::setvisibleteam("any");
      var_8 _id_04D1::set2dicon("friendly", level.iconkill2d);
      var_8 _id_04D1::playsoundtoteam("friendly", level.iconkill3d);
      var_8 _id_04D1::set2dicon("enemy", level.iconescort2d);
      var_8 _id_04D1::playsoundtoteam("enemy", level.iconescort3d);
      level.capzones[var_8.ownerteam] _id_04D1::_id_0C30("none");
      level.capzones[var_8.ownerteam] _id_04D1::setvisibleteam("friendly");
      level.capzones[var_8.ownerteam] _id_04D1::set2dicon("friendly", level.iconwaitforflag2d);
      level.capzones[var_8.ownerteam] _id_04D1::playsoundtoteam("friendly", level.iconwaitforflag3d);

      if(var_8.ownerteam == "allies") {
        level.capzones[var_8.ownerteam] _id_04D1::set2dicon("broadcaster", level._id_5018);
        level.capzones[var_8.ownerteam] _id_04D1::playsoundtoteam("broadcaster", level._id_5018, 1);
        continue;
      }

      level.capzones[var_8.ownerteam] _id_04D1::set2dicon("broadcaster", level._id_5018);
      level.capzones[var_8.ownerteam] _id_04D1::playsoundtoteam("broadcaster", level._id_5018, 2);
    }
  }

  maps\mp\gametypes\ctf::capturezone_reset_base_effects();

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

  _setomnvar("ui_hardpoint_timer", 0);
  level notify("zone_moved");
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
  var_2 = _getnodesinradiussorted(var_0, 300, 0, 200, "Path");

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

_id_989D(var_0) {
  level.teleport_to_nodes = var_0;
}

_id_989E(var_0) {
  level.teleport_to_offset = var_0;
}

_id_9889(var_0) {
  level.teleport_include_killsteaks = var_0;
}

_id_98B0(var_0, var_1) {
  level.teleport_minimaps[var_0] = var_1;
}

_id_98B2(var_0, var_1) {
  level.teleport_pre_funcs[var_1] = var_0;
}

_id_98B1(var_0, var_1) {
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
    var_1 = common_scripts\utility::_id_0F73(var_2, var_1);
  }

  foreach(var_4 in var_1) {
    if(!isDefined(var_4._id_0165)) {
      var_4._id_0165 = "teleport_origin";
    }

    switch (var_4._id_0165) {
      case "teleport_origin":
        var_5 = var_4.origin + (0, 0, 1);
        var_6 = var_4.origin - (0, 0, 250);
        var_7 = bulletTrace(var_5, var_6, 0);

        if(var_7["fraction"] == 1.0) {
          break;
        }

        var_4.origin = var_7["position"];
      case "telport_origin_nodrop":
        if(!isDefined(var_4.setlookatent)) {
          var_4.setlookatent = "none,axis,allies";
        }

        var_8 = strtok(var_4.setlookatent, ", ");

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
    _id_0472::setupminimap(level.teleport_minimaps[var_0]);
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
  var_1._id_0186 = var_0;
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

  if(isPlayer(var_1) && (var_1.sessionstate == "intermission" || var_1.sessionstate == "spectator")) {
    var_5 = getEntArray("mp_global_intermission", "classname");
    var_5 = teleport_filter_spawn_point(var_5, var_0);
    var_6 = var_5[0];
    var_1 dontinterpolate();
    var_1 setOrigin(var_6.origin);
    var_1 setplayerangles(var_6.angles);
  } else {
    var_7 = undefined;
    var_8 = var_1.angles;

    if(isPlayer(var_1)) {
      var_8 = var_1 getplayerangles();
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
    } else
      var_15 = var_3.teleport_origins["none"];

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
      if(_canspawn(var_19) && !_positionwouldtelefrag(var_19)) {
        var_7 = var_19;
      }
    }

    if(!isDefined(var_7) && level.teleport_to_nodes) {
      var_20 = _getnodesinradiussorted(var_19, 300, 0, 200, "Path");

      for(var_21 = 0; var_21 < var_20.size; var_21++) {
        var_22 = var_20[var_21];

        if(isDefined(var_22.last_teleport_time) && var_22.last_teleport_time == var_4) {
          continue;
        }
        var_12 = var_22.origin;

        if(_canspawn(var_12) && !_positionwouldtelefrag(var_12)) {
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
    var_1 setOrigin(var_7);
    var_1 setplayerangles(var_8);
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

_id_9893() {
  if(isDefined(self)) {
    self notify("death");
  }
}

_id_0FB4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0)) {
    return;
  }
  common_scripts\utility::_id_0FB2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_0F8B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  common_scripts\utility::_id_0F8A(var_0, var_1, var_2, var_3, var_4);
}

_id_9883() {
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
  } else
    return 0;
}

teleport_add_delta_targets(var_0, var_1) {
  if(teleport_delta_this_frame(var_0)) {
    return;
  }
  teleport_add_delta(var_0, var_1);

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");
    var_3 = common_scripts\utility::getstructarray(var_0.target, "targetname");
    var_4 = common_scripts\utility::_id_0F73(var_2, var_3);
    common_scripts\utility::_id_0F8A(var_4, ::teleport_add_delta_targets, var_1);
  }
}

_id_98AE(var_0) {
  teleport_add_delta_targets(self, var_0);
}

_id_98AD(var_0) {
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