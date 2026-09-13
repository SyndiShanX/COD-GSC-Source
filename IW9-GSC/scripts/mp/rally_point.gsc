/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rally_point.gsc
***********************************************/

init() {}

makerallypoint(object) {
  if(istrue(object.israllypoint)) {
    return;
  }
  object.israllypoint = 1;
  object.registeredrallypointplayers = [];
  object.autorespawntime = getdvarint("scr_player_lastStandTimer");

  if(!isDefined(level.rallypoints))
    level.rallypoints = [];

  level.rallypoints[level.rallypoints.size] = object;
  thread watchforplayerdeath(object);
  thread watchforrallypointdeath(object);
}

registerplayerwithrallypoint(player, rallypoint) {
  if(!istrue(rallypoint.israllypoint)) {
    debugprint("Trying to register a player with an object that is not a rally point.");
    return;
  }

  debugprint(player.name + " has been registered wtih rally point: " + rallypoint.targetname);
  player.rallypoint = rallypoint;
  player.beingrallyrespawned = 0;
  rallypoint.registeredrallypointplayers[rallypoint.registeredrallypointplayers.size] = player;
}

watchforplayerdeath(rallypoint) {
  while(isDefined(rallypoint)) {
    foreach(player in rallypoint.registeredrallypointplayers) {
      if(!isDefined(player)) {
        rallypoint.registeredrallypointplayers = scripts\engine\utility::array_remove(rallypoint.registeredrallypointplayers, player);
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(player) && isDefined(player.rallypoint) && !player.beingrallyrespawned)
        prepareplayerforrespawn(player, rallypoint);
    }

    wait 0.1;
  }
}

prepareplayerforrespawn(player, rallypoint) {
  level endon("game_ended");
  player endon("team_eliminated");
  _id_EEA4FD6EEE3BEB45 = ["rally_point_respawn", "rally_point_destroyed"];
  msg = player scripts\engine\utility::waittill_any_in_array_or_timeout(_id_EEA4FD6EEE3BEB45, rallypoint.autorespawntime);

  if(msg == "rally_point_destroyed") {
    if(isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
      return;
    }
    message = player scripts\mp\utility\lower_message::getlowermessage();
    timeremaining = message.time;
    player scripts\mp\utility\lower_message::setlowermessageomnvar("rally_wait_revive", int(gettime() + self.timeuntilbleedout * 1000));
    waitframe();
    player.lowertimer settimer(player.timelefttospawnaction);
    return;
  }

  player.beingrallyrespawned = 1;
  spawnposition = vectorNormalize(anglesToForward(rallypoint.angles));
  spawnposition = spawnposition * -175 + rallypoint.origin;
  player.forcespawnorigin = getclosestpointonnavmesh(spawnposition);
  waitframe();
  debugprint("Player respawning at rally point location:" + player.forcespawnorigin);
  player.forcespawnangles = (0, 90, 0);
  player notify("last_stand_revived");
  player scripts\mp\utility\player::_freezecontrols(0);
  player thread scripts\mp\teamrevive::respawn();
  player setclientomnvar("ui_securing", 0);
  player setclientomnvar("ui_securing_progress", 0.01);
  player.ui_securing = undefined;

  while(!scripts\mp\utility\player::isreallyalive(player))
    wait 0.1;

  player.beingrallyrespawned = 0;
}

watchforrallypointdeath(rallypoint) {
  rallypoint waittill("death");

  foreach(owner in rallypoint.registeredrallypointplayers) {
    owner notify("rally_point_destroyed");
    owner iprintlnbold("Your Rally Point has been destroyed");
  }
}

debugprint(text) {
  if(1)
    return;
}

rallypointvehicle_activate(vehicle) {
  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(vehicle);
  team = vehicle.team;
  ref = spawndata.ref;
  vehicle.israllypointvehicle = 1;
  thread scripts\mp\spawnselection::vehicleindangertracking(vehicle);
  scripts\mp\spawnselection::adddynamicspawnarea(team, vehicle, ref, (0, 0, 128));

  if(istrue(level._id_B307135DBCEF5A38)) {
    level._id_694388259AFB589B[team][level._id_694388259AFB589B[team].size] = ref;
    scripts\mp\spawnselection::setspawnlocations(level._id_694388259AFB589B[team], team);
  } else {
    level.spawnareas[team][level.spawnareas[team].size] = ref;
    scripts\mp\spawnselection::setspawnlocations(level.spawnareas[team], team);
  }

  vehicle.ref = ref;
  rallypoint_activatevehiclemarker(vehicle);
  thread rallypoint_watchforvehicledeath(vehicle);
  thread rallypoint_wathcforenemydiscovery(vehicle);
}

rallypointvehicle_deactivate(vehicle) {}

rallypoint_showafterprematch(vehicle) {
  vehicle endon("death");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(player in level.players) {
    if(player.team == vehicle.team) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
      _id_328C7313A47E3C6B = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_328C7313A47E3C6B;
      player scripts\mp\utility\lower_message::setlowermessageomnvar(_id_328C7313A47E3C6B, undefined, 5);
    }
  }
}

rallypoint_watchforvehicledeath(vehicle) {
  vehicle waittill("death");

  if(istrue(level._id_B307135DBCEF5A38))
    level._id_694388259AFB589B[vehicle.team] = scripts\engine\utility::array_remove(level._id_694388259AFB589B[vehicle.team], vehicle.ref);
  else
    level.spawnareas[vehicle.team] = scripts\engine\utility::array_remove(level.spawnareas[vehicle.team], vehicle.ref);

  rallypoint_deacivatevehiclemarker(vehicle);
  scripts\mp\spawnselection::removedynamicspawnarea(vehicle.team, vehicle.ref);
  scripts\mp\spawnselection::removespawnlocation(vehicle.ref, vehicle.team);
}

rallypoint_activatevehiclemarker(vehicle) {
  _id_7D3CF95BDBCA0939 = "friendly";
  origin = vehicle.origin + (0, 0, 128);
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, vehicle.team);
  vehicle.marker = marker;

  if(scripts\mp\flags::gameflag("prematch_done")) {
    foreach(player in level.players) {
      if(player.team == vehicle.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
        _id_328C7313A47E3C6B = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD())._id_328C7313A47E3C6B;
        player scripts\mp\utility\lower_message::setlowermessageomnvar(_id_328C7313A47E3C6B, undefined, 5);
      }
    }
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(marker.objidnum);
    thread rallypoint_showafterprematch(vehicle);
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  icon = "hud_icon_minimap_vehicle_apc";

  switch (vehicle.vehiclename) {
    case "apc_russian":
      icon = "hud_icon_minimap_vehicle_apc";
      break;
    case "veh9_palfa":
    case "little_bird":
      icon = "hud_icon_minimap_vehicle_palfa";
      break;
    case "veh9_patrol_boat":
      icon = "hud_icon_minimap_vehicle_armored_patrol";
      break;
    default:
      icon = "hud_icon_minimap_vehicle_apc";
      break;
  }

  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, icon);
  scripts\mp\objidpoolmanager::update_objective_setbackground(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_onentity(marker.objidnum, vehicle);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(vehicle.marker.objidnum, 128);
  scripts\mp\objidpoolmanager::update_objective_state(vehicle.marker.objidnum, "invisible");
  marker.lockupdatingicons = 1;
  vehicle.marker = marker;
}

rallypoint_deacivatevehiclemarker(vehicle) {
  vehicle.marker scripts\mp\gameobjects::setvisibleteam("none");
  vehicle.marker scripts\mp\gameobjects::releaseid();
  vehicle.marker.visibleteam = "none";
}

rallypoint_wathcforenemydiscovery(vehicle) {
  vehicle endon("death");

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  _id_A25CA362BCC21C2D = spawn("trigger_radius", vehicle.origin - (0, 0, 512), 0, 1024, 1536);
  _id_A25CA362BCC21C2D thread watchrallytriggeruse(vehicle);
  _id_A25CA362BCC21C2D waittill("rallyPoint_revealed");
  _id_A25CA362BCC21C2D delete();
}

watchrallytriggeruse(vehicle) {
  self endon("rallyPoint_revealed");
  vehicle endon("death");

  for(;;) {
    self waittill("trigger", player);
    waitframe();

    if(!isPlayer(player)) {
      continue;
    }
    if(!isalive(player)) {
      continue;
    }
    if(player.team == vehicle.team) {
      continue;
    }
    vehicle.revealed = 1;

    foreach(_id_B212D40302E8388D in level.players)
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, _id_B212D40302E8388D);

    self notify("rallyPoint_revealed");
  }
}

rallypoint_showtoplayer(player) {
  player endon("death_or_disconnect");

  while(!scripts\mp\flags::gameflag("prematch_done"))
    waitframe();

  while(!isDefined(player.team) || player.team == "spectator")
    waitframe();

  if(isDefined(level.rallypointvehicles)) {
    foreach(vehicle in level.rallypointvehicles) {
      if(!isDefined(vehicle)) {
        continue;
      }
      if(player.team == vehicle.team)
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
    }
  }
}