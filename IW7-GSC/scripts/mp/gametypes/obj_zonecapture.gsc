/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_zonecapture.gsc
****************************************************/

func_8B4A(var_0) {
  var_1 = level.objectives[var_0];
  var_2 = [];
  var_2[0] = var_1;
  var_1 = postshipmodifiedkothzones(var_1);
  var_1.gameobject = scripts\mp\gameobjects::createuseobject("neutral", var_1, var_2, (0, 0, 0));
  var_1.gameobject scripts\mp\gameobjects::disableobject();
  var_1.gameobject scripts\mp\gameobjects::set2dicon("mlg", undefined);
  var_1.gameobject scripts\mp\gameobjects::set3dicon("mlg", undefined);
  var_1.gameobject.claimgracetime = level.zonecapturetime * 1000;
  var_1.gameobject scripts\mp\gameobjects::cancontestclaim(1);
  if(level.usehqrules) {
    var_1.gameobject scripts\mp\gameobjects::mustmaintainclaim(0);
  } else {
    var_1.gameobject scripts\mp\gameobjects::mustmaintainclaim(1);
  }

  var_1.gameobject.id = "hardpoint";
  var_1.useobj = var_1.gameobject;
  if(isDefined(var_1.target)) {
    var_1.useobj thread assignchevrons(var_1.target, var_1.script_label);
  }

  return var_1;
}

postshipmodifiedkothzones(var_0) {
  if(level.mapname == "mp_parkour") {
    if(var_0.script_label == "1") {
      var_0.origin = var_0.origin + (0, 0, 135);
    }
  }

  if(level.mapname == "mp_fallen") {
    if(var_0.script_label == "3") {
      var_0.origin = var_0.origin - (0, 0, 50);
    }
  }

  if(level.mapname == "mp_junk") {
    if(var_0.script_label == "4") {
      var_0.origin = var_0.origin - (0, 7, 0);
    }
  }

  return var_0;
}

assignchevrons(var_0, var_1) {
  wait(1);
  var_2 = 0;
  var_3 = getscriptablearray(var_0, "targetname");
  if(level.mapname == "mp_parkour") {
    if(var_1 == "1") {
      var_2 = 1;
    }
  }

  if(!var_2) {
    var_4 = [];
    foreach(var_6 in var_3) {
      var_7 = var_4.size;
      var_4[var_7] = var_6;
      var_4[var_7].numchevrons = 1;
      if(isDefined(var_6.script_noteworthy)) {
        if(var_6.script_noteworthy == "2") {
          var_4[var_7].numchevrons = 2;
          continue;
        }

        if(var_6.script_noteworthy == "3") {
          var_4[var_7].numchevrons = 3;
          continue;
        }

        if(var_6.script_noteworthy == "4") {
          var_4[var_7].numchevrons = 4;
        }
      }
    }
  } else {
    var_4 = postshipmodifychevrons(var_2);
  }

  self.chevrons = var_4;
}

updatechevrons(var_0) {
  self notify("updateChevrons");
  self endon("updateChevrons");
  while(!isDefined(self.chevrons)) {
    wait(0.05);
  }

  foreach(var_2 in self.chevrons) {
    for(var_3 = 0; var_3 < var_2.numchevrons; var_3++) {
      var_2 setscriptablepartstate("chevron_" + var_3, var_0);
    }
  }
}

activatezone() {
  self.onuse = ::zone_onuse;
  self.onbeginuse = ::zone_onusebegin;
  self.onuseupdate = ::zone_onuseupdate;
  self.onenduse = ::zone_onuseend;
  self.onunoccupied = ::zone_onunoccupied;
  self.oncontested = ::zone_oncontested;
  self.onuncontested = ::zone_onuncontested;
  level thread scripts\mp\gametypes\koth::awardcapturepoints();
}

deactivatezone() {
  self.onuse = undefined;
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
  thread updatechevrons("off");
}

zonetimerwait() {
  level endon("game_ended");
  level endon("dev_force_zone");
  var_0 = int(level.zonemovetime * 1000 + gettime());
  thread hp_move_soon();
  level thread handlehostmigration(var_0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.zonemovetime);
}

hp_move_soon() {
  level endon("game_ended");
  if(int(level.zonemovetime) > 12) {
    var_0 = level.zonemovetime - 12;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
    level scripts\mp\utility::statusdialog("hp_move_soon", "allies");
    level scripts\mp\utility::statusdialog("hp_move_soon", "axis");
  }
}

handlehostmigration(var_0) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_uplink_timer_stopped", 1);
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();
  setomnvar("ui_uplink_timer_stopped", 0);
  if(var_1 > 0) {
    setomnvar("ui_hardpoint_timer", level.zoneendtime + var_1);
    return;
  }

  setomnvar("ui_hardpoint_timer", level.zoneendtime);
}

hardpoint_setneutral() {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setownerteam("neutral");
  playhardpointneutralfx();
  thread updatechevrons("idle");
}

trackgametypevips() {
  thread cleanupgametypevips();
  level endon("game_ended");
  level endon("zone_moved");
  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self.trigger)) {
        var_1 setgametypevip(1);
        continue;
      }

      var_1 setgametypevip(0);
    }

    wait(0.5);
  }
}

cleanupgametypevips() {
  level scripts\engine\utility::waittill_any_3("game_ended", "zone_moved");
  foreach(var_1 in level.players) {
    var_1 setgametypevip(0);
  }
}

zone_onuse(var_0) {
  if(level.usehqrules && self.ownerteam != "neutral") {
    level notify("zone_destroyed");
    level.zone.gameobject scripts\mp\gameobjects::setvisibleteam("none");
    level scripts\mp\gametypes\koth::updateservericons("zone_shift", 0);
    level scripts\mp\utility::statusdialog("obj_destroyed", self.ownerteam, 1);
    level scripts\mp\utility::statusdialog("obj_captured", var_0.team, 1);
    return;
  }

  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility::getotherteam(var_1);
  var_4 = gettime();
  if(!level.timerstoppedforgamemode && level.pausemodetimer) {
    level scripts\mp\gamelogic::pausetimer();
  }

  level.usestartspawns = 0;
  var_5 = 0;
  level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.icondefend, level.iconcapture);
  level scripts\mp\gametypes\koth::updateservericons(var_1, 0);
  if(!isDefined(level.lastcaptureteam) || level.lastcaptureteam != var_1) {
    if(level.gametype == "koth") {
      level scripts\mp\utility::statusdialog("hp_captured_friendly", var_1, 1);
      level scripts\mp\utility::statusdialog("hp_captured_enemy", var_3, 1);
    } else {
      level scripts\mp\utility::statusdialog("friendly_zone_control", var_1, 1);
      level scripts\mp\utility::statusdialog("enemy_zone_control", var_3, 1);
    }

    var_6 = [];
    var_7 = getarraykeys(self.touchlist[var_1]);
    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      var_6[var_7[var_8]] = self.touchlist[var_1][var_7[var_8]];
    }

    level thread scripts\mp\gametypes\koth::give_capture_credit(var_6, var_4, var_1, level.lastcaptureteam);
  }

  thread scripts\mp\utility::printandsoundoneveryone(var_1, var_3, undefined, undefined, "mp_dom_flag_captured", undefined, var_0);
  foreach(var_0A in level.players) {
    showcapturedhardpointeffecttoplayer(var_1, var_0A);
  }

  level.zone.gameobject thread updatechevrons(var_1);
  thread func_8B4C();
  level.var_911E = var_1;
  if(!isDefined(level.lastcaptureteam) || var_1 != level.lastcaptureteam) {
    scripts\mp\utility::setmlgannouncement(6, var_1, var_0 getentitynumber());
  }

  scripts\mp\gameobjects::setownerteam(var_1);
  self.capturecount++;
  level.lastcaptureteam = var_1;
  if(level.usehqrules) {
    level.zone.gameobject scripts\mp\gameobjects::allowuse("enemy");
  } else {
    level.zone.gameobject scripts\mp\gameobjects::allowuse("none");
  }

  level notify("zone_captured");
  level notify("zone_captured" + var_1);
}

zone_onusebegin(var_0) {
  self.didstatusnotify = 0;
  scripts\mp\gameobjects::setusetime(level.zonecapturetime);
  thread scripts\mp\gameobjects::useobjectdecay(var_0.team);
  if(level.zonecapturetime > 0) {
    self.prevownerteam = level.otherteam[var_0.team];
    scripts\mp\gameobjects::setzonestatusicons(level.iconlosing, level.icontaking);
  }
}

zone_onuseupdate(var_0, var_1, var_2, var_3) {
  if(!level.timerstoppedforgamemode && level.pausemodetimer) {
    level scripts\mp\gamelogic::pausetimer();
  }

  var_4 = scripts\mp\gameobjects::getownerteam();
  var_5 = scripts\mp\utility::getotherteam(var_0);
  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "neutral") {
      scripts\mp\utility::statusdialog("hp_capturing_friendly", var_0);
      scripts\mp\utility::statusdialog("hp_capturing_enemy", var_5);
    } else {
      scripts\mp\utility::statusdialog("hp_capturing_enemy", var_4, 1);
      scripts\mp\utility::statusdialog("hp_capturing_friendly", var_0);
    }

    self.didstatusnotify = 1;
  }
}

zone_onuseend(var_0, var_1, var_2) {
  if(!var_2) {
    if(level.timerstoppedforgamemode && level.pausemodetimer) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  if(isplayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
  if(var_3 == "neutral") {
    level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.iconneutral);
    foreach(var_1 in level.players) {
      level.zone.gameobject showzoneneutralbrush(var_1);
    }
  } else {
    level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.icondefend, level.iconcapture);
    foreach(var_1 in level.players) {
      level.zone.gameobject showcapturedhardpointeffecttoplayer(var_3, var_1);
    }
  }

  if(!var_2) {
    if(level.timerstoppedforgamemode && level.pausemodetimer) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }
}

zone_onunoccupied() {
  if(level.usehqrules && self.ownerteam != "neutral") {
    return;
  }

  level notify("zone_destroyed");
  level.var_911E = "neutral";
  if(level.timerstoppedforgamemode && level.pausemodetimer) {
    level scripts\mp\gamelogic::resumetimer();
  }

  if(self.numtouching["axis"] == 0 && self.numtouching["allies"] == 0) {
    level.zone.gameobject.wasleftunoccupied = 1;
    level scripts\mp\gametypes\koth::updateservericons("neutral", 0);
    level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.iconneutral);
    level.zone.gameobject playhardpointneutralfx();
    level.zone.gameobject thread updatechevrons("idle");
  }
}

zone_oncontested() {
  scripts\mp\utility::setmlgannouncement(7, "free");
  if(level.timerstoppedforgamemode && level.pausemodetimer) {
    level scripts\mp\gamelogic::resumetimer();
  }

  var_0 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
  level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.iconcontested);
  level scripts\mp\gametypes\koth::updateservericons(var_0, 1);
  level.zone.gameobject thread updatechevrons("contested");
  foreach(var_2 in level.players) {
    level.zone.gameobject showcapturedhardpointeffecttoplayer(var_0, var_2);
  }

  if(var_0 == "neutral") {
    var_4 = self.claimteam;
  } else {
    var_4 = var_1;
  }

  scripts\mp\utility::statusdialog("hp_contested", var_4, 1);
  level.zone.gameobject thread scripts\mp\matchdata::loggameevent("hill_contested", level.zone.origin);
}

zone_onuncontested(var_0) {
  if(!level.timerstoppedforgamemode && level.pausemodetimer) {
    level scripts\mp\gamelogic::pausetimer();
  }

  var_1 = level.zone.gameobject scripts\mp\gameobjects::getownerteam();
  if(var_0 == "none" || var_1 == "neutral") {
    level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.iconneutral);
    foreach(var_3 in level.players) {
      level.zone.gameobject showzoneneutralbrush(var_3);
    }

    level.zone.gameobject thread scripts\mp\matchdata::loggameevent("hill_empty", level.zone.origin);
  } else {
    level.zone.gameobject scripts\mp\gameobjects::setzonestatusicons(level.icondefend, level.iconcapture);
    foreach(var_3 in level.players) {
      level.zone.gameobject showcapturedhardpointeffecttoplayer(var_1, var_3);
    }

    level.zone.gameobject thread scripts\mp\matchdata::loggameevent("hill_uncontested", level.zone.origin);
  }

  var_7 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  level.zone.gameobject thread updatechevrons(var_7);
  level scripts\mp\gametypes\koth::updateservericons(var_1, 0);
}

setcrankedtimerzonecap(var_0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var_0.cranked) && var_0.cranked) {
    var_0 scripts\mp\utility::setcrankedplayerbombtimer("assist");
  }
}

playhardpointneutralfx() {
  foreach(var_1 in level.players) {
    if(level.usehpzonebrushes) {
      showzoneneutralbrush(var_1);
    }
  }
}

showcapturedhardpointeffecttoplayer(var_0, var_1) {
  var_2 = var_1.team;
  var_3 = var_1 ismlgspectator();
  if(var_3) {
    var_2 = var_1 getmlgspectatorteam();
  }

  if(level.usehpzonebrushes) {
    if(level.zone.gameobject.stalemate) {
      showzonecontestedbrush(var_1);
      return;
    }

    if(var_2 == var_0) {
      showzonefriendlybrush(var_1);
      return;
    }

    showzoneenemybrush(var_1);
    return;
  }
}

showzoneneutralbrush(var_0) {
  level.zone.gameobject.friendlybrush hidefromplayer(var_0);
  level.zone.gameobject.enemybrush hidefromplayer(var_0);
  level.zone.gameobject.contestedbrush hidefromplayer(var_0);
  level.zone.gameobject.neutralbrush showtoplayer(var_0);
}

showzonefriendlybrush(var_0) {
  level.zone.gameobject.friendlybrush showtoplayer(var_0);
  level.zone.gameobject.enemybrush hidefromplayer(var_0);
  level.zone.gameobject.contestedbrush hidefromplayer(var_0);
  level.zone.gameobject.neutralbrush hidefromplayer(var_0);
}

showzoneenemybrush(var_0) {
  level.zone.gameobject.friendlybrush hidefromplayer(var_0);
  level.zone.gameobject.enemybrush showtoplayer(var_0);
  level.zone.gameobject.contestedbrush hidefromplayer(var_0);
  level.zone.gameobject.neutralbrush hidefromplayer(var_0);
}

showzonecontestedbrush(var_0) {
  level.zone.gameobject.friendlybrush hidefromplayer(var_0);
  level.zone.gameobject.enemybrush hidefromplayer(var_0);
  level.zone.gameobject.contestedbrush showtoplayer(var_0);
  level.zone.gameobject.neutralbrush hidefromplayer(var_0);
}

hideplayerspecificbrushes(var_0) {
  self.friendlybrush hidefromplayer(var_0);
  self.enemybrush hidefromplayer(var_0);
  self.neutralbrush hidefromplayer(var_0);
  self.contestedbrush hidefromplayer(var_0);
}

func_8B4C() {
  level endon("game_ended");
  self endon("flag_neutral");
  for(;;) {
    level waittill("joined_team", var_0);
    if(var_0.team != "spectator" && level.zone.gameobject.ownerteam != "neutral") {
      level.zone.gameobject showcapturedhardpointeffecttoplayer(level.zone.gameobject.ownerteam, var_0);
    }
  }
}

postshipmodifychevrons(var_0) {
  if(level.mapname == "mp_parkour") {
    var_1 = [];
    var_2 = [];
    var_3 = spawn("script_model", (176, -240, 308));
    var_3 setModel("hp_chevron_scriptable");
    var_3 = createvisualsinfo(var_3, (176, -240, 308), (0, 90, 0), var_0);
    var_2[var_2.size] = var_3;
    var_4 = spawn("script_model", (112, -240, 308));
    var_4 setModel("hp_chevron_scriptable");
    var_4 = createvisualsinfo(var_4, (112, -240, 308), (0, 90, 0), var_0);
    var_2[var_2.size] = var_4;
    var_5 = spawn("script_model", (48, -240, 308));
    var_5 setModel("hp_chevron_scriptable");
    var_5 = createvisualsinfo(var_5, (48, -240, 308), (0, 90, 0), var_0);
    var_2[var_2.size] = var_5;
    var_6 = spawn("script_model", (-16, -240, 308));
    var_6 setModel("hp_chevron_scriptable");
    var_6 = createvisualsinfo(var_6, (-16, -240, 308), (0, 90, 0), var_0);
    var_2[var_2.size] = var_6;
    var_7 = spawn("script_model", (-80, -240, 308));
    var_7 setModel("hp_chevron_scriptable");
    var_7 = createvisualsinfo(var_7, (-80, -240, 308), (0, 90, 0), var_0);
    var_2[var_2.size] = var_7;
    var_8 = spawn("script_model", (-144, -240, 308));
    var_8 setModel("hp_chevron_scriptable");
    var_8 = createvisualsinfo(var_8, (-144, -240, 308), (0, 90, 0), var_0);
    var_2[var_2.size] = var_8;
    var_9 = spawn("script_model", (-176, -192, 308));
    var_9 setModel("hp_chevron_scriptable");
    var_9 = createvisualsinfo(var_9, (-176, -192, 308), (0, 0, 0), var_0);
    var_2[var_2.size] = var_9;
    var_0A = spawn("script_model", (-176, -128, 308));
    var_0A setModel("hp_chevron_scriptable");
    var_0A = createvisualsinfo(var_0A, (-176, -128, 308), (0, 0, 0), var_0);
    var_2[var_2.size] = var_0A;
    var_0B = spawn("script_model", (-176, -64, 308));
    var_0B setModel("hp_chevron_scriptable");
    var_0B = createvisualsinfo(var_0B, (-176, -64, 308), (0, 0, 0), var_0);
    var_2[var_2.size] = var_0B;
    var_0C = spawn("script_model", (-176, 0, 308));
    var_0C setModel("hp_chevron_scriptable");
    var_0C = createvisualsinfo(var_0C, (-176, 0, 308), (0, 0, 0), var_0);
    var_2[var_2.size] = var_0C;
    var_0D = spawn("script_model", (-176, 64, 308));
    var_0D setModel("hp_chevron_scriptable");
    var_0D = createvisualsinfo(var_0D, (-176, 64, 308), (0, 0, 0), var_0);
    var_2[var_2.size] = var_0D;
    var_0E = spawn("script_model", (-176, 128, 308));
    var_0E setModel("hp_chevron_scriptable");
    var_0E = createvisualsinfo(var_0E, (-176, 128, 308), (0, 0, 0), var_0);
    var_2[var_2.size] = var_0E;
    var_0F = spawn("script_model", (-176, 192, 308));
    var_0F setModel("hp_chevron_scriptable");
    var_0F = createvisualsinfo(var_0F, (-176, 192, 308), (0, 0, 0), var_0);
    var_2[var_2.size] = var_0F;
    var_10 = spawn("script_model", (-144, 240, 308));
    var_10 setModel("hp_chevron_scriptable");
    var_10 = createvisualsinfo(var_10, (-144, 240, 308), (0, 270, 0), var_0);
    var_2[var_2.size] = var_10;
    var_11 = spawn("script_model", (-80, 240, 308));
    var_11 setModel("hp_chevron_scriptable");
    var_11 = createvisualsinfo(var_11, (-80, 240, 308), (0, 270, 0), var_0);
    var_2[var_2.size] = var_11;
    var_12 = spawn("script_model", (-16, 240, 308));
    var_12 setModel("hp_chevron_scriptable");
    var_12 = createvisualsinfo(var_12, (-16, 240, 308), (0, 270, 0), var_0);
    var_2[var_2.size] = var_12;
    var_13 = spawn("script_model", (48, 240, 308));
    var_13 setModel("hp_chevron_scriptable");
    var_13 = createvisualsinfo(var_13, (48, 240, 308), (0, 270, 0), var_0);
    var_2[var_2.size] = var_13;
    var_14 = spawn("script_model", (112, 240, 308));
    var_14 setModel("hp_chevron_scriptable");
    var_14 = createvisualsinfo(var_14, (112, 240, 308), (0, 270, 0), var_0);
    var_2[var_2.size] = var_14;
    var_15 = spawn("script_model", (176, 240, 308));
    var_15 setModel("hp_chevron_scriptable");
    var_15 = createvisualsinfo(var_15, (176, 240, 308), (0, 270, 0), var_0);
    var_2[var_2.size] = var_15;
    foreach(var_17 in var_2) {
      var_18 = var_1.size;
      var_1[var_18] = var_17;
      var_1[var_18].numchevrons = 1;
    }

    return var_1;
  }
}

createvisualsinfo(var_0, var_1, var_2, var_3) {
  var_0.origin = var_1;
  var_0.angles = var_2;
  return var_0;
}