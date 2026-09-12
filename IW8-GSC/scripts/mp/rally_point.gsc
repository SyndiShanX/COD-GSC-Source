/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rally_point.gsc
***********************************************/

function init() {
  level.iconrallypoint = "icon_waypoint_vehicle_apc";
  level.iconrallypointheli = "icon_waypoint_vehicle_little_bird";
}

function makerallypoint(var_0) {
  if(istrue(var_0.israllypoint)) {
    return;
  }

  var_0.israllypoint = 1;
  var_0.registeredrallypointplayers = [];
  var_0.autorespawntime = getdvarint("scr_player_laststandtimer");

  if(!isDefined(level.rallypoints)) {
    level.rallypoints = [];
  }

  level.rallypoints[level.rallypoints.size] = var_0;
  thread watchforplayerdeath(var_0);
  thread watchforrallypointdeath(var_0);
}

function registerplayerwithrallypoint(var_0, var_1) {
  if(!istrue(var_1.israllypoint)) {
    debugprint("Trying to register a player with an object that is not a rally point.");
    return;
  }

  debugprint(var_0.name + " has been registered wtih rally point: " + var_1.targetname);
  var_0.rallypoint = var_1;
  var_0.beingrallyrespawned = 0;
  var_1.registeredrallypointplayers[var_1.registeredrallypointplayers.size] = var_0;
}

function watchforplayerdeath(var_0) {
  while(isDefined(var_0)) {
    foreach(var_2 in var_0.registeredrallypointplayers) {
      if(!isDefined(var_2)) {
        var_0.registeredrallypointplayers = scripts\engine\utility::array_remove(var_0.registeredrallypointplayers, var_2);
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_2) && isDefined(var_2.rallypoint) && !var_2.beingrallyrespawned) {
        prepareplayerforrespawn(var_2, var_0);
      }
    }

    wait 0.1;
  }
}

function prepareplayerforrespawn(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("team_eliminated");
  var_2 = ["rally_point_respawn", "rally_point_destroyed"];
  var_3 = var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(var_2, var_1.autorespawntime);

  if(var_3 == "rally_point_destroyed") {
    if(isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      return;
    }

    var_4 = var_0 scripts\mp\utility\lower_message::getlowermessage();
    var_5 = var_4.time;
    var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(28, int(gettime() + self.timeuntilbleedout * 1000));
    waitframe();
    var_0.lowertimer settimer(var_0.timelefttospawnaction);
    return;
  }

  var_2.beingrallyrespawned = 1;
  var_6 = vectorNormalize(anglesToForward(var_3.angles));
  var_6 = var_6 * -175 + var_3.origin;
  var_2.forcespawnorigin = getclosestpointonnavmesh(var_6);
  waitframe();
  debugprint("Player respawning at rally point location:" + var_2.forcespawnorigin);
  var_2.forcespawnangles = (0, 90, 0);
  var_2 notify("last_stand_revived");
  var_2 scripts\mp\utility\player::_freezecontrols(0);
  var_2 thread scripts\mp\teamrevive::respawn();
  var_2 setclientomnvar("ui_securing", 0);
  var_2 setclientomnvar("ui_securing_progress", 0.01);
  var_2.ui_securing = undefined;

  while(!scripts\mp\utility\player::isreallyalive(var_2)) {
    wait 0.1;
  }

  var_2.beingrallyrespawned = 0;
}

function watchforrallypointdeath(var_0) {
  var_0 waittill("death");

  foreach(var_2 in var_0.registeredrallypointplayers) {
    var_2 notify("rally_point_destroyed");
    var_2 iprintlnbold("Your Rally Point has been destroyed");
  }
}

function debugprint(var_0) {
  if(true) {
    return;
  }
}

function rallypointvehicle_activate(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(var_0);
  var_2 = var_0.team;
  var_3 = var_1.ref;
  var_0.israllypointvehicle = 1;
  thread scripts\mp\spawnselection::ref_1424C(var_0);

  if(var_2 == "axis") {
    scripts\mp\spawnselection::adddynamicspawnarea(var_2, var_0, var_3, (0, 0, 128));

    if(!isDefined(level.axisspawnareas)) {
      level.axisspawnareas = [];
    }

    level.axisspawnareas[level.axisspawnareas.size] = var_3;
    scripts\mp\spawnselection::setspawnlocations(level.axisspawnareas, var_2);
  } else {
    scripts\mp\spawnselection::adddynamicspawnarea(var_2, var_0, var_3, (0, 0, 128));

    if(!isDefined(level.alliesspawnareas)) {
      level.alliesspawnareas = [];
    }

    level.alliesspawnareas[level.alliesspawnareas.size] = var_3;
    scripts\mp\spawnselection::setspawnlocations(level.alliesspawnareas, var_2);
  }

  var_0.ref = var_3;
  rallypoint_activatevehiclemarker(var_0);
  thread rallypoint_watchforvehicledeath(var_0);
  thread rallypoint_wathcforenemydiscovery(var_0);
}

function rallypointvehicle_deactivate(var_0) {}

function ref_129F2(var_0) {
  var_0 endon("death");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_2 in level.players) {
    if(var_2.team == var_0.team) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_2);
      var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(63, undefined, 5);
    }
  }
}

function rallypoint_watchforvehicledeath(var_0) {
  var_0 waittill("death");

  if(var_0.team == "axis") {
    level.axisspawnareas = scripts\engine\utility::array_remove(level.axisspawnareas, var_0.ref);
  } else {
    level.alliesspawnareas = scripts\engine\utility::array_remove(level.alliesspawnareas, var_0.ref);
  }

  rallypoint_deacivatevehiclemarker(var_0);
  scripts\mp\spawnselection::removedynamicspawnarea(var_0.team, var_0.ref);
  scripts\mp\spawnselection::removespawnlocation(var_0.ref, var_0.team);
}

function rallypoint_activatevehiclemarker(var_0) {
  var_1 = "friendly";
  var_2 = var_0.origin + (0, 0, 128);
  var_3 = scripts\mp\gameobjects::createobjidobject(var_2, "neutral", (0, 0, 0), undefined, var_1, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_3.objidnum, var_0.team);
  var_0.marker = var_3;

  if(scripts\mp\flags::gameflag("prematch_done")) {
    foreach(var_5 in level.players) {
      if(var_5.team == var_0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_5);
        var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(63, undefined, 5);
      }
    }
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_3.objidnum);
    thread ref_129F2(var_0);
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(var_3.objidnum, 0);
  var_3.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_3.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_3.objidnum, scripts\engine\utility::ter_op(var_0.vehiclename == "little_bird" || var_0.vehiclename == "little_bird_mg", level.iconrallypointheli, level.iconrallypoint));
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_3.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_3.objidnum, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_0.marker.objidnum, 128);
  var_3.lockupdatingicons = 1;
  var_0.marker = var_3;
}

function rallypoint_deacivatevehiclemarker(var_0) {
  var_0.marker scripts\mp\gameobjects::setvisibleteam("none");
  var_0.marker scripts\mp\gameobjects::releaseid();
  var_0.marker.visibleteam = "none";
}

function rallypoint_wathcforenemydiscovery(var_0) {
  var_0 endon("death");

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  var_1 = spawn("trigger_radius", var_0.origin - (0, 0, 512), 0, 1024, 1536);
  thread watchrallytriggeruse(var_1);
  var_1 waittill("rallyPoint_revealed");
  var_1 delete();
}

function watchrallytriggeruse(var_0) {
  self endon("rallyPoint_revealed");
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);
    waitframe();

    if(!isPlayer(var_1)) {
      continue;
    }

    if(!isalive(var_1)) {
      continue;
    }

    if(var_1.team == var_0.team) {
      continue;
    }

    var_0.revealed = 1;

    foreach(var_3 in level.players) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_3);
    }

    self notify("rallyPoint_revealed");
  }
}

function rallypoint_showtoplayer(var_0) {
  var_0 endon("death_or_disconnect");

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  while(!isDefined(var_0.team) || var_0.team == "spectator") {
    waitframe();
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(var_2 in level.rallypointvehicles) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(var_0.team == var_2.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2.marker.objidnum, var_0);
      }
    }

    return;
  }
}