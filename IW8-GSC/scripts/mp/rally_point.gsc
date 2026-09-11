/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rally_point.gsc
***********************************************/

function init() {
  level.iconrallypoint = "icon_waypoint_vehicle_apc";
  level.iconrallypointheli = "icon_waypoint_vehicle_little_bird";
}

function makerallypoint(var0) {
  if(istrue(var0.israllypoint)) {
    return;
  }

  var0.israllypoint = 1;
  var0.registeredrallypointplayers = [];
  var0.autorespawntime = getdvarint("scr_player_laststandtimer");

  if(!isDefined(level.rallypoints)) {
    level.rallypoints = [];
  }

  level.rallypoints[level.rallypoints.size] = var0;
  thread watchforplayerdeath(var0);
  thread watchforrallypointdeath(var0);
}

function registerplayerwithrallypoint(var0, var1) {
  if(!istrue(var1.israllypoint)) {
    debugprint("Trying to register a player with an object that is not a rally point.");
    return;
  }

  debugprint(var0.name + " has been registered wtih rally point: " + var1.targetname);
  var0.rallypoint = var1;
  var0.beingrallyrespawned = 0;
  var1.registeredrallypointplayers[var1.registeredrallypointplayers.size] = var0;
}

function watchforplayerdeath(var0) {
  while(isDefined(var0)) {
    foreach(var2 in var0.registeredrallypointplayers) {
      if(!isDefined(var2)) {
        var0.registeredrallypointplayers = scripts\engine\utility::array_remove(var0.registeredrallypointplayers, var2);
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var2) && isDefined(var2.rallypoint) && !var2.beingrallyrespawned) {
        prepareplayerforrespawn(var2, var0);
      }
    }

    wait 0.1;
  }
}

function prepareplayerforrespawn(var0, var1) {
  level endon("game_ended");
  var0 endon("team_eliminated");
  var2 = ["rally_point_respawn", "rally_point_destroyed"];
  var3 = var0 scripts\engine\utility::waittill_any_in_array_or_timeout(var2, var1.autorespawntime);

  if(var3 == "rally_point_destroyed") {
    if(isDefined(var0) || !scripts\mp\utility\player::isreallyalive(var0)) {
      return;
    }

    var4 = var0 scripts\mp\utility\lower_message::getlowermessage();
    var5 = var4.time;
    var0 scripts\mp\utility\lower_message::setlowermessageomnvar(28, int(gettime() + self.timeuntilbleedout * 1000));
    waitframe();
    var0.lowertimer settimer(var0.timelefttospawnaction);
    return;
  }

  var2.beingrallyrespawned = 1;
  var6 = vectorNormalize(anglesToForward(var3.angles));
  var6 = var6 * -175 + var3.origin;
  var2.forcespawnorigin = getclosestpointonnavmesh(var6);
  waitframe();
  debugprint("Player respawning at rally point location:" + var2.forcespawnorigin);
  var2.forcespawnangles = (0, 90, 0);
  var2 notify("last_stand_revived");
  var2 scripts\mp\utility\player::_freezecontrols(0);
  var2 thread scripts\mp\teamrevive::respawn();
  var2 setclientomnvar("ui_securing", 0);
  var2 setclientomnvar("ui_securing_progress", 0.01);
  var2.ui_securing = undefined;

  while(!scripts\mp\utility\player::isreallyalive(var2)) {
    wait 0.1;
  }

  var2.beingrallyrespawned = 0;
}

function watchforrallypointdeath(var0) {
  var0 waittill("death");

  foreach(var2 in var0.registeredrallypointplayers) {
    var2 notify("rally_point_destroyed");
    var2 iprintlnbold("Your Rally Point has been destroyed");
  }
}

function debugprint(var0) {
  if(true) {
    return;
  }
}

function rallypointvehicle_activate(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(var0);
  var2 = var0.team;
  var3 = var1.ref;
  var0.israllypointvehicle = 1;
  thread scripts\mp\spawnselection::ref_1424c(var0);

  if(var2 == "axis") {
    scripts\mp\spawnselection::adddynamicspawnarea(var2, var0, var3, (0, 0, 128));

    if(!isDefined(level.axisspawnareas)) {
      level.axisspawnareas = [];
    }

    level.axisspawnareas[level.axisspawnareas.size] = var3;
    scripts\mp\spawnselection::setspawnlocations(level.axisspawnareas, var2);
  } else {
    scripts\mp\spawnselection::adddynamicspawnarea(var2, var0, var3, (0, 0, 128));

    if(!isDefined(level.alliesspawnareas)) {
      level.alliesspawnareas = [];
    }

    level.alliesspawnareas[level.alliesspawnareas.size] = var3;
    scripts\mp\spawnselection::setspawnlocations(level.alliesspawnareas, var2);
  }

  var0.ref = var3;
  rallypoint_activatevehiclemarker(var0);
  thread rallypoint_watchforvehicledeath(var0);
  thread rallypoint_wathcforenemydiscovery(var0);
}

function rallypointvehicle_deactivate(var0) {}

function ref_129f2(var0) {
  var0 endon("death");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var2 in level.players) {
    if(var2.team == var0.team) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var2);
      var2 scripts\mp\utility\lower_message::setlowermessageomnvar(63, undefined, 5);
    }
  }
}

function rallypoint_watchforvehicledeath(var0) {
  var0 waittill("death");

  if(var0.team == "axis") {
    level.axisspawnareas = scripts\engine\utility::array_remove(level.axisspawnareas, var0.ref);
  } else {
    level.alliesspawnareas = scripts\engine\utility::array_remove(level.alliesspawnareas, var0.ref);
  }

  rallypoint_deacivatevehiclemarker(var0);
  scripts\mp\spawnselection::removedynamicspawnarea(var0.team, var0.ref);
  scripts\mp\spawnselection::removespawnlocation(var0.ref, var0.team);
}

function rallypoint_activatevehiclemarker(var0) {
  var1 = "friendly";
  var2 = var0.origin + (0, 0, 128);
  var3 = scripts\mp\gameobjects::createobjidobject(var2, "neutral", (0, 0, 0), undefined, var1, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var3.objidnum, var0.team);
  var0.marker = var3;

  if(scripts\mp\flags::gameflag("prematch_done")) {
    foreach(var5 in level.players) {
      if(var5.team == var0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var5);
        var5 scripts\mp\utility\lower_message::setlowermessageomnvar(63, undefined, 5);
      }
    }
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var3.objidnum);
    thread ref_129f2(var0);
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(var3.objidnum, 0);
  var3.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var3.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var3.objidnum, scripts\engine\utility::ter_op(var0.vehiclename == "little_bird" || var0.vehiclename == "little_bird_mg", level.iconrallypointheli, level.iconrallypoint));
  scripts\mp\objidpoolmanager::update_objective_setbackground(var3.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var3.objidnum, var0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var0.marker.objidnum, 128);
  var3.lockupdatingicons = 1;
  var0.marker = var3;
}

function rallypoint_deacivatevehiclemarker(var0) {
  var0.marker scripts\mp\gameobjects::setvisibleteam("none");
  var0.marker scripts\mp\gameobjects::releaseid();
  var0.marker.visibleteam = "none";
}

function rallypoint_wathcforenemydiscovery(var0) {
  var0 endon("death");

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  var1 = spawn("trigger_radius", var0.origin - (0, 0, 512), 0, 1024, 1536);
  thread watchrallytriggeruse(var1);
  var1 waittill("rallyPoint_revealed");
  var1 delete();
}

function watchrallytriggeruse(var0) {
  self endon("rallyPoint_revealed");
  var0 endon("death");

  for(;;) {
    self waittill("trigger", var1);
    waitframe();

    if(!isPlayer(var1)) {
      continue;
    }

    if(!isalive(var1)) {
      continue;
    }

    if(var1.team == var0.team) {
      continue;
    }

    var0.revealed = 1;

    foreach(var3 in level.players) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var3);
    }

    self notify("rallyPoint_revealed");
  }
}

function rallypoint_showtoplayer(var0) {
  var0 endon("death_or_disconnect");

  while(!scripts\mp\flags::gameflag("prematch_done")) {
    waitframe();
  }

  while(!isDefined(var0.team) || var0.team == "spectator") {
    waitframe();
  }

  if(isDefined(level.rallypointvehicles)) {
    foreach(var2 in level.rallypointvehicles) {
      if(!isDefined(var2)) {
        continue;
      }

      if(var0.team == var2.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var2.marker.objidnum, var0);
      }
    }

    return;
  }
}