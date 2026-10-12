/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rally_point.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnselection;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#namespace rally_point;

function init() {}

function makerallypoint(object) {
  if(istrue(object.israllypoint)) {
    return;
  }

  object.israllypoint = 1;
  object.registeredrallypointplayers = [];
  object.autorespawntime = getdvarint(@ "hash_546d8a10bb4e83de");

  if(!isDefined(level.rallypoints)) {
    level.rallypoints = [];
  }

  level.rallypoints[level.rallypoints.size] = object;
  thread watchforplayerdeath(object);
  thread watchforrallypointdeath(object);
}

function registerplayerwithrallypoint(player, rallypoint) {
  if(!istrue(rallypoint.israllypoint)) {
    debugprint("Trying to register a player with an object that is not a rally point.");
    return;
  }

  debugprint(player.name + " has been registered wtih rally point: " + rallypoint.targetname);
  player.rallypoint = rallypoint;
  player.beingrallyrespawned = 0;
  rallypoint.registeredrallypointplayers[rallypoint.registeredrallypointplayers.size] = player;
}

function watchforplayerdeath(rallypoint) {
  while(isDefined(rallypoint)) {
    foreach(player in rallypoint.registeredrallypointplayers) {
      if(!isDefined(player)) {
        rallypoint.registeredrallypointplayers = array_remove(rallypoint.registeredrallypointplayers, player);
        continue;
      }

      if(!isreallyalive(player) && isDefined(player.rallypoint) && !player.beingrallyrespawned) {
        prepareplayerforrespawn(player, rallypoint);
      }
    }

    wait 0.1;
  }
}

function prepareplayerforrespawn(player, rallypoint) {
  level endon("game_ended");
  player endon("team_eliminated");
  messagearray = ["rally_point_respawn", "rally_point_destroyed"];
  msg = player waittill_any_in_array_or_timeout(messagearray, rallypoint.autorespawntime);

  if(msg == "rally_point_destroyed") {
    if(isDefined(player) || !isreallyalive(player)) {
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
  player _freezecontrols(0);
  player thread scripts\mp\teamrevive::respawn();
  player setclientomnvar("ui_securing", 0);
  player setclientomnvar("ui_securing_progress", 0.01);
  player.ui_securing = undefined;

  while(!isreallyalive(player)) {
    wait 0.1;
  }

  player.beingrallyrespawned = 0;
}

function watchforrallypointdeath(rallypoint) {
  rallypoint waittill("death");

  foreach(owner in rallypoint.registeredrallypointplayers) {
    owner notify("rally_point_destroyed");
    owner iprintlnbold("Your Rally Point has been destroyed");
  }
}

function debugprint(text) {
  if(true) {
    println(text);
  }
}

function rallypointvehicle_activate(vehicle) {
  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(vehicle);
  team = vehicle.team;
  ref = spawndata.ref;
  vehicle.israllypointvehicle = 1;
  thread scripts\mp\spawnselection::vehicleindangertracking(vehicle);
  scripts\mp\spawnselection::adddynamicspawnarea(team, vehicle, ref, (0, 0, 128));

  if(istrue(level.var_b307135dbcef5a38)) {
    level.var_694388259afb589b[team][level.var_694388259afb589b[team].size] = ref;
    scripts\mp\spawnselection::setspawnlocations(level.var_694388259afb589b[team], team);
  } else {
    level.spawnareas[team][level.spawnareas[team].size] = ref;
    scripts\mp\spawnselection::setspawnlocations(level.spawnareas[team], team);
  }

  vehicle.ref = ref;
  rallypoint_activatevehiclemarker(vehicle);
  thread rallypoint_watchforvehicledeath(vehicle);
  thread rallypoint_wathcforenemydiscovery(vehicle);
}

function rallypointvehicle_deactivate(vehicle) {}

function rallypoint_showafterprematch(vehicle) {
  vehicle endon("death");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(player in level.players) {
    if(player.team == vehicle.team) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
      var_328c7313a47e3c6b = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd()).var_328c7313a47e3c6b;
      assert(isDefined(var_328c7313a47e3c6b) && var_328c7313a47e3c6b != "<dev string:x1c>", "<dev string:x20>");
      player scripts\mp\utility\lower_message::setlowermessageomnvar(var_328c7313a47e3c6b, undefined, 5);
    }
  }
}

function rallypoint_watchforvehicledeath(vehicle) {
  vehicle waittill("death");

  if(istrue(level.var_b307135dbcef5a38)) {
    level.var_694388259afb589b[vehicle.team] = array_remove(level.var_694388259afb589b[vehicle.team], vehicle.ref);
  } else {
    level.spawnareas[vehicle.team] = array_remove(level.spawnareas[vehicle.team], vehicle.ref);
  }

  rallypoint_deacivatevehiclemarker(vehicle);
  scripts\mp\spawnselection::removedynamicspawnarea(vehicle.team, vehicle.ref);
  scripts\mp\spawnselection::removespawnlocation(vehicle.ref, vehicle.team);
}

function rallypoint_activatevehiclemarker(vehicle) {
  visibility = "friendly";
  origin = vehicle.origin + (0, 0, 128);
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, visibility, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, vehicle.team);
  vehicle.marker = marker;

  if(scripts\mp\flags::gameflag("prematch_done")) {
    foreach(player in level.players) {
      if(player.team == vehicle.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
        var_328c7313a47e3c6b = vehicle_spawn_getleveldataforvehicle(vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd()).var_328c7313a47e3c6b;
        assert(isDefined(var_328c7313a47e3c6b) && var_328c7313a47e3c6b != "<dev string:x1c>", "<dev string:x20>");
        player scripts\mp\utility\lower_message::setlowermessageomnvar(var_328c7313a47e3c6b, undefined, 5);
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
    case #"hash_41afa3eacdeba917":
      icon = "hud_icon_minimap_vehicle_apc";
      break;
    case #"hash_66c8846b85d8c948":
    case #"hash_9d4e22a00fc630b5":
      icon = "hud_icon_minimap_vehicle_palfa";
      break;
    case #"hash_a2c475614741731":
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

function rallypoint_deacivatevehiclemarker(vehicle) {
  vehicle.marker scripts\mp\gameobjects::setvisibleteam("none");
  vehicle.marker scripts\mp\gameobjects::releaseid();
  vehicle.marker.visibleteam = "none";
}

function rallypoint_wathcforenemydiscovery(vehicle) {
  vehicle endon("death");

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  var_a25ca362bcc21c2d = spawn("trigger_radius", vehicle.origin - (0, 0, 512), 0, 1024, 1536);
  var_a25ca362bcc21c2d thread watchrallytriggeruse(vehicle);
  var_a25ca362bcc21c2d waittill("rallyPoint_revealed");
  var_a25ca362bcc21c2d delete();
}

function watchrallytriggeruse(vehicle) {
  self endon("rallyPoint_revealed");
  vehicle endon("death");

  while(true) {
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

    foreach(plr in level.players) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, plr);
    }

    self notify("rallyPoint_revealed");
  }
}

function rallypoint_showtoplayer(player) {
  player endon("death_or_disconnect");

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  while(!isDefined(player.team) || player.team == "spectator") {
    waitframe();
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(vehicle in level.rallypointvehicles) {
      if(!isDefined(vehicle)) {
        continue;
      }

      if(player.team == vehicle.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(vehicle.marker.objidnum, player);
      }
    }
  }
}