/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_zonecapture.gsc
****************************************************/

function setupobjective(var0, var1, var2, var3) {
  var4 = var0;

  if(!isDefined(var1)) {
    var1 = [];
    var1 = var4;
  }

  var4 = postshipmodifiedkothzones(var4);

  if(istrue(var2)) {
    var5 = 0;
  } else {
    var5 = undefined;
  }

  var5 = scripts\mp\gameobjects::createuseobject("neutral", var5, var2, (0, 0, 0), var5, var4);
  var5 scripts\mp\gameobjects::disableobject();

  if(scripts\mp\utility\game::getgametype() == "koth") {
    for(var6 = 0; var6 < var5.visuals.size; var6++) {
      var5.visuals[var6] hide();
    }
  } else {
    var5.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");
  }

  var5 scripts\mp\gameobjects::cancontestclaim(1);
  var5.claimgracetime = level.zonecapturetime * 1000;
  var5 scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(isDefined(var1.objectivekey)) {
    var5.objectivekey = var1.objectivekey;
  } else {
    var5.objectivekey = var5 scripts\mp\gameobjects::getlabel();
  }

  if(level.usehqrules && !level.usehprules) {
    var5 scripts\mp\gameobjects::mustmaintainclaim(0);
  } else {
    var5 scripts\mp\gameobjects::mustmaintainclaim(1);
  }

  var5.id = "hardpoint";

  if(isDefined(var5.trigger.target) && scripts\mp\utility\game::getgametype() == "koth") {
    thread assignchevrons(var5, var5.trigger.target);
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    if(scripts\mp\utility\game::getgametype() == "hq") {
      thread ref_14396(var5);
    } else if(scripts\mp\utility\game::getgametype() == "grnd") {
      thread ref_14395(var5);
    }
  }

  return var5;
}

function ref_14396(var0) {
  scripts\mp\flags::gameflagwait("prematch_done");
  var1 = anglesToForward(var0.visuals[0].angles);
  var2 = var1 * 5;
  var3 = var0.visuals[0] gettagorigin("j_laptop_tray");
  playFX(level.spawnoffsettacinsertmax["ghostcat_hw"], var3 + var2);
}

function ref_14395(var0) {
  scripts\mp\flags::gameflagwait("prematch_done");
  playFX(level.spawnoffsettacinsertmax["blood_floor_hw"], getgroundposition(var0.trigger.origin, 4) + (0, 0, 2));
}

function postshipmodifiedkothzones(var0) {
  if(level.mapname == "mp_malyshev") {
    if(var0.script_label == "1") {
      var0.origin -= (0, 0, 5);
    }
  } else if(level.mapname == "mp_herat") {
    if(var0.script_label == "1") {
      var0.origin += (0, 3, 0);
    }
  }

  return var0;
}

function assignchevrons(var0, var1) {
  wait 1;
  var2 = getentitylessscriptablearrayinradius(var0, "targetname");
  var2 = ref_12bff(var2, var1);
  var2 = ref_12806(var2, var1);
  var3 = [];

  foreach(var5 in var2) {
    var6 = var3.size;
    var3 = var5;
    var3[var6].numchevrons = 1;

    if(isDefined(var5.script_noteworthy)) {
      if(var5.script_noteworthy == "2") {
        var3[var6].numchevrons = 2;
        continue;
      }

      if(var5.script_noteworthy == "3") {
        var3[var6].numchevrons = 3;
        continue;
      }

      if(var5.script_noteworthy == "4") {
        var3[var6].numchevrons = 4;
      }
    }
  }

  self.chevrons = var3;
}

function updatechevrons(var0) {
  if(scripts\mp\utility\game::getgametype() != "koth") {
    return;
  }

  self notify("updateChevrons");
  self endon("updateChevrons");

  while(!isDefined(self.chevrons)) {
    waitframe();
  }

  foreach(var2 in self.chevrons) {
    for(var3 = 0; var3 < var2.numchevrons; var3++) {
      var2 setscriptablepartstate("chevron_" + var3, var0);
    }
  }
}

function activatezone() {
  self.onuse = &zone_onuse;
  self.onbeginuse = &zone_onusebegin;
  self.onuseupdate = &zone_onuseupdate;
  self.onenduse = &zone_onuseend;
  self.onunoccupied = &zone_onunoccupied;
  self.oncontested = &zone_oncontested;
  self.onuncontested = &zone_onuncontested;
  self.stompprogressreward = &zone_stompprogressreward;
  self.onpinnedstate = &zone_onpinnedstate;
  self.onunpinnedstate = &zone_onunpinnedstate;
  self.didstatusnotify = 0;
  scripts\mp\gameobjects::requestid(1, 1, 0, 1, 0);
  var0 = self.curorigin;

  if(isDefined(level.remove_last_used_node)) {
    var0 = [[level.remove_last_used_node]]();
  }

  var1 = 1024;

  if(isDefined(level.remove_launcher_xmags)) {
    var1 = [[level.remove_launcher_xmags]]();
  }

  var2 = [];
  GscBinSkip0(0x2e, var2.size, scripts\mp\spawnlogic::addspawndangerzone(var0 - (0, 0, 2048), var1, 4096, "allies", undefined, undefined, undefined, undefined, undefined, 1));
}

function deactivatezone() {
  self.onuse = undefined;
  self.onbeginuse = undefined;
  self.onuseupdate = undefined;
  self.onunoccupied = undefined;
  self.oncontested = undefined;
  self.onuncontested = undefined;
  self.stalemate = 0;
  self.wasstalemate = 0;
  self.didstatusnotify = 0;
  thread updatechevrons("off");

  foreach(var1 in self.isburstweapon) {
    scripts\mp\spawnlogic::removespawndangerzone(var1);
  }

  self.isburstweapon = undefined;

  foreach(var4 in level.players) {
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var4);
  }

  self.trigger scripts\engine\utility::trigger_off();
  thread ref_1439d();
  scripts\mp\gameobjects::releaseid(1, 0);

  if(scripts\mp\utility\game::getgametype() == "hq") {
    self.visuals[0] playSound("mp_hq_deactivate_sfx");
    thread scripts\mp\music_and_dialog::headquarters_deactivate_music(self.lastclaimteam);
    self.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");
    level.zone.visuals[0] stoploopsound();
  }

  level.ref_12f0e = 0;
}

function zonetimerwait() {
  level endon("game_ended");
  level endon("dev_force_zone");
  var0 = int(level.zonemovetime * 1000 + gettime());

  if(!isDefined(level.zoneselectiondelay) || level.zoneselectiondelay < 10) {
    thread hp_move_soon(level.zonemovetime);
  }

  thread handlehostmigration(level);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.zonemovetime);
}

function hp_move_soon(var0) {
  level endon("game_ended");

  if(scripts\mp\utility\game::getgametype() == "hq") {
    level endon("zone_destroyed");
  }

  if(int(var0) > 12) {
    var1 = var0 - 12;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var1);

    foreach(var3 in level.teamnamelist) {
      level scripts\mp\utility\dialog::statusdialog("hp_move_soon", var3);
    }

    return;
  }
}

function handlehostmigration(var0) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("disconnect");
  level endon("zone_captured");
  level waittill("host_migration_begin");
  setomnvar("ui_objective_timer_stopped", 1);
  var1 = scripts\mp\hostmigration::waittillhostmigrationdone();
  setomnvar("ui_objective_timer_stopped", 0);

  if(var1 > 0) {
    setomnvar("ui_hardpoint_timer", level.zoneendtime + var1);
    return;
  }

  setomnvar("ui_hardpoint_timer", level.zoneendtime);
}

function ref_1199e(var0, var1) {
  level endon("game_ended");
  var2 = level.framedurationseconds;
  var3 = var2 * 1000;
  var4 = var0 * 1000;
  var5 = var4 - var3;
  self.radialtimeobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.radialtimeobjid != -1) {
    var6 = "invisible";
    scripts\mp\objidpoolmanager::objective_add_objective(self.radialtimeobjid, var6, var1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.radialtimeobjid);
    self.showworldicon = 1;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(level.icontarget, level.icontarget, self.radialtimeobjid);
  var7 = gettime() + var4;

  while(gettime() < var7) {
    var8 = var5 / var4;
    scripts\mp\objidpoolmanager::objective_show_progress(self.radialtimeobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.radialtimeobjid, var8);
    var5 = max(var5 - var3, 1);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.radialtimeobjid);
  self.radialtimeobjid = -1;
}

function hardpoint_setneutral() {
  self notify("flag_neutral");
  scripts\mp\gameobjects::setownerteam("neutral");
  playhardpointneutralfx();
  thread updatechevrons("idle");
}

function trackgametypevips() {
  thread cleanupgametypevips();
  level endon("game_ended");
  level endon("zone_moved");

  for(;;) {
    foreach(var1 in level.players) {
      if(var1 istouching(level.zone.trigger)) {
        var1 setgametypevip(1);
        continue;
      }

      var1 setgametypevip(0);
    }

    wait 0.5;
  }
}

function cleanupgametypevips() {
  level scripts\engine\utility::ref_143a5("game_ended", "zone_moved");

  foreach(var1 in level.players) {
    var1 setgametypevip(0);
  }
}

function zone_onuse(var0) {
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  var1 = var0.team;
  var2 = gettime();
  var3 = [];
  var4 = getarraykeys(self.touchlist[var1]);

  for(var5 = 0; var5 < var4.size; var5++) {
    var3 = self.touchlist[var1][var4[var5]];
  }

  if(level.usehqrules && !level.usehprules && self.ownerteam != "neutral") {
    setomnvar("ui_hq_ownerteam", 0);
    level notify("zone_destroyed");

    foreach(var7 in level.players) {
      scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, var7);
    }

    thread ref_1439d();
    level scripts\mp\gametypes\koth::updateservericons("zone_shift", 0);

    if(isDefined(var3)) {
      var9 = getarraykeys(var3);

      foreach(var11 in var9) {
        var7 = self.assisttouchlist[var1][var11].player;

        if(isDefined(var7.owner)) {
          var7 = var7.owner;
        }

        var7 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
        LOC_0000012c:
      }
    }

    level thread scripts\mp\gametypes\hq::give_capture_credit(var3, var2, var1, undefined, var0, self);

    if(scripts\mp\utility\game::getgametype() == "hq") {
      level scripts\mp\utility\dialog::statusdialog("hp_captured_friendly", var0.team);
      level scripts\mp\utility\dialog::statusdialog("hp_owned_lost", self.ownerteam);
    } else {
      level scripts\mp\utility\dialog::statusdialog("hp_captured_friendly", var0.team);
      level scripts\mp\utility\dialog::statusdialog("hp_captured_enemy", self.ownerteam);
    }
  } else {
    if(scripts\mp\utility\game::getgametype() == "hq") {
      var13 = scripts\mp\utility\teams::getteamdata(var1, "players");

      foreach(var7 in var13) {
        var7 scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
        var7.skipspawncamera = 1;
      }
    }

    var16 = scripts\mp\gameobjects::getownerteam();
    var17 = scripts\mp\utility\game::getotherteam(var1)[0];
    scripts\mp\gameobjects::setownerteam(var1);

    if(level.usehqrules && !level.usehprules) {
      setomnvar("ui_hq_ownerteam", scripts\mp\gametypes\hq::gethqownerteamvalue(self.ownerteam));
      setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(self.ownerteam, "aliveCount"));
    }

    if(scripts\mp\utility\game::getgametype() == "hq" && !level.usehprules) {
      level thread scripts\mp\gametypes\hq::awardcapturepoints();
      var18 = scripts\mp\gamescore::_getteamscore(var1);
      var19 = scripts\mp\gamescore::_getteamscore(var17);

      if(var18 > var19) {
        level.ref_12f0e = 1;
      }

      binoculars_clearexpirationtimer(var1);
    } else if(level.ref_1221a) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level.usestartspawns = 0;
    var20 = 0;
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    level scripts\mp\gametypes\koth::updateservericons(var1, 0);

    if(scripts\mp\utility\game::getgametype() == "hq" && !level.usehprules) {
      thread scripts\mp\utility\print::printandsoundoneveryone(var1, var17, undefined, undefined, "mp_dom_flag_captured", undefined, var0);
      thread scripts\mp\music_and_dialog::headquarters_captured_music();
    }

    if(!isDefined(level.lastcaptureteam) || level.lastcaptureteam != var1) {
      if(scripts\mp\utility\game::getgametype() == "hq" && !level.usehprules) {
        if(isDefined(level.kothhillrotation && level.kothhillrotation == 0)) {
          level.delayleadtakendialog = 4;
        } else {
          level.delayleadtakendialog = undefined;
        }

        thread delaydialogstatustoavoidcaptureoverlap(level, var1);
      } else {
        level scripts\mp\utility\dialog::statusdialog("hp_captured_friendly", var1);
        level scripts\mp\utility\dialog::statusdialog("hp_captured_enemy", var17);
      }

      if(scripts\mp\utility\game::getgametype() == "koth") {
        level thread scripts\mp\gametypes\koth::give_capture_credit(var3, var2, var1, level.lastcaptureteam, var0, self);
      } else if(scripts\mp\utility\game::getgametype() == "grnd") {
        level thread scripts\mp\gametypes\grnd::give_capture_credit(var3, var2, var1, level.lastcaptureteam, var0, self);
      } else {
        level thread scripts\mp\gametypes\hq::give_capture_credit(var3, var2, var1, level.lastcaptureteam, var0, self);
      }
    }

    foreach(var22 in level.players) {
      showcapturedhardpointeffecttoplayer(var1, var22);
    }

    thread updatechevrons(level.zone);

    if(scripts\mp\utility\game::getgametype() == "hq") {
      level.zone.visuals[0] stoploopsound();
      level.zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_open_idle");

      if(!level.usehprules) {
        var24 = scripts\mp\utility\teams::getteamdata(var1, "players");

        foreach(var7 in var24) {
          var7 thread scripts\mp\gametypes\hq::showrespawnwarningmessage();
        }
      }
    }

    level.hpcapteam = var1;
    self.capturecount++;
    level.lastcaptureteam = var1;
    level notify("zone_captured");
    level notify("zone_captured" + var1);
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], level.zone.trigger.origin + (0, 0, 40));
    return;
  }
}

function ref_1439d() {
  waitframe();
  scripts\mp\gameobjects::setvisibleteam("none");
}

function zone_onusebegin(var0) {
  if(scripts\mp\utility\game::getgametype() == "hq" && !level.usehprules) {
    var1 = scripts\mp\gameobjects::getownerteam();

    if(var1 != "neutral" && self.claimteam != var1) {
      binoculars_clearexpirationtimer(var1, 1);
    }

    if(!istrue(var0.ui_dom_securing) || !istrue(self.stalemate)) {
      if(var1 == "neutral") {
        var0 setclientomnvar("ui_objective_state", 1);
      } else {
        var0 setclientomnvar("ui_objective_state", 2);
      }

      var0.ui_dom_securing = 1;
    }
  }

  if(!isDefined(self.statusnotifytime)) {
    self.statusnotifytime = gettime();
  }

  if(self.statusnotifytime > self.statusnotifytime + 10000) {
    self.didstatusnotify = 0;
    self.statusnotifytime = gettime();
  }

  scripts\mp\gameobjects::setusetime(level.zonecapturetime);

  if(level.zonecapturetime > 0) {
    self.prevownerteam = scripts\mp\utility\game::getotherteam(var0.team)[0];
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
    return;
  }
}

function zone_onuseupdate(var0, var1, var2, var3) {
  var4 = scripts\mp\gameobjects::getownerteam();

  if(var4 == "neutral" && self.claimteam != var4) {
    binoculars_clearexpirationtimer(self.claimteam);
  } else if(var4 != "neutral" && self.claimteam != var4) {
    binoculars_clearexpirationtimer(var4, 1);
  } else if(level.ref_1221a) {
    level scripts\mp\gamelogic::pausetimer();
  }

  if((scripts\mp\utility\game::getgametype() == "hq" || scripts\mp\utility\game::getgametype() == "arm") && var1 < 1 && !level.usehprules && !level.gameended) {
    playcapturesound(var1, var0);
  }

  var4 = scripts\mp\gameobjects::getownerteam();
  var5 = scripts\mp\utility\game::getotherteam(var0)[0];

  if(var1 > 0.05 && var2 && !self.didstatusnotify) {
    if(var4 == "neutral") {
      scripts\mp\utility\dialog::statusdialog("hp_capturing_friendly", var0);
      scripts\mp\utility\dialog::statusdialog("hp_capturing_enemy", var5);
    } else if(scripts\mp\utility\game::getgametype() == "hq") {
      scripts\mp\utility\dialog::statusdialog("hp_disabling_friendly", var4);
      scripts\mp\utility\dialog::statusdialog("hp_disabling_enemy", var0);
    } else {
      scripts\mp\utility\dialog::statusdialog("hp_capturing_enemy", var4);
      scripts\mp\utility\dialog::statusdialog("hp_capturing_friendly", var0);
    }

    self.didstatusnotify = 1;
    return;
  }
}

function delaydialogstatustoavoidcaptureoverlap(var0, var1) {
  wait 0.5;
  level scripts\mp\utility\dialog::statusdialog("hp_secured_friendly", var0);
  level scripts\mp\utility\dialog::statusdialog("hp_captured_enemy", var1);
}

function playcapturesound(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var2 = "";
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function zone_onuseend(var0, var1, var2) {
  var3 = level.zone scripts\mp\gameobjects::getownerteam();

  if(!var2) {
    if(scripts\mp\utility\game::getgametype() == "hq") {
      if(level.usehprules) {
        if(level.ref_1221a) {
          level scripts\mp\gamelogic::resumetimer();
        }
      } else if(var3 != "neutral") {
        binoculars_clearexpirationtimer(var3);
      }
    } else if(level.ref_1221a) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_dom_securing = undefined;
  }

  if(var3 == "neutral") {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

    if(istrue(level.usehpzonebrushes)) {
      foreach(var1 in level.players) {
        showzoneneutralbrush(level.zone, var1);
      }

      return;
    }

    return;
  }

  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  foreach(var3 in level.players) {
    showcapturedhardpointeffecttoplayer(level.zone, var5, var3);
  }
}

function zone_onunoccupied() {
  if(level.usehqrules && !level.usehprules && self.ownerteam != "neutral") {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    binoculars_clearexpirationtimer(self.ownerteam);
    return;
  }

  level notify("zone_destroyed");
  level.hpcapteam = "neutral";

  if(level.ref_1221a) {
    level scripts\mp\gamelogic::resumetimer();
  }

  var0 = 1;

  foreach(var2 in level.teamnamelist) {
    if(self.numtouching[var2] > 0) {
      var0 = 0;
      break;
    }
  }

  if(var0) {
    level.zone.wasleftunoccupied = 1;
    level scripts\mp\gametypes\koth::updateservericons("neutral", 0);
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    playhardpointneutralfx(level.zone);
    thread updatechevrons(level.zone);
    return;
  }
}

function zone_oncontested() {
  if(level.ref_1221a) {
    level scripts\mp\gamelogic::resumetimer();
  }

  self.hostvictimoverride = gettime();
  var0 = level.zone scripts\mp\gameobjects::getownerteam();
  level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  level scripts\mp\gametypes\koth::updateservericons(var0, 1);
  thread updatechevrons(level.zone);

  foreach(var2 in level.teamnamelist) {
    if(self.touchlist[var2].size) {
      var3 = self.touchlist[var2];
      var4 = getarraykeys(var3);

      for(var5 = 0; var5 < var4.size; var5++) {
        var6 = var3[var4[var5]].player;
        var6 setclientomnvar("ui_objective_state", 3);
      }
    }
  }

  foreach(var6 in level.players) {
    showcapturedhardpointeffecttoplayer(level.zone, var0, var6);
  }

  if(var0 == "neutral") {
    var10 = self.claimteam;
  } else {
    var10 = var1;
  }

  foreach(var12 in level.teamnamelist) {
    scripts\mp\utility\dialog::statusdialog("hp_contested", var12);
  }

  level.zone thread scripts\common\utility::ref_13e0a(level.ref_11b29, "hill_contested", level.zone.trigger.origin);
  self.didstatusnotify = 1;
}

function zone_onuncontested(var0) {
  if(level.ref_1221a) {
    level scripts\mp\gamelogic::pausetimer();
  }

  var1 = level.zone scripts\mp\gameobjects::getownerteam();

  if(var0 == "none" || var1 == "neutral") {
    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

    if(istrue(level.usehpzonebrushes)) {
      foreach(var3 in level.players) {
        showzoneneutralbrush(level.zone, var3);
      }
    }

    level.zone thread scripts\common\utility::ref_13e0a(level.ref_11b29, "hill_empty", level.zone.trigger.origin);
  } else {
    if(scripts\mp\utility\game::getgametype() == "koth") {
      scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_positive", var1);
      scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_negative", scripts\mp\utility\game::getotherteam(var1)[0]);
    } else if(scripts\mp\utility\game::getgametype() == "grnd") {
      scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_positive", var1);
      scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_negative", scripts\mp\utility\game::getotherteam(var1)[0]);
    }

    level.zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

    foreach(var3 in level.players) {
      showcapturedhardpointeffecttoplayer(level.zone, var1, var3);
    }

    level.zone thread scripts\common\utility::ref_13e0a(level.ref_11b29, "hill_uncontested", level.zone.trigger.origin);
  }

  var7 = (gettime() - self.hostvictimoverride) * 0.001;
  scripts\mp\utility\game::ref_119ac(undefined, undefined, "Zone Contested", level.zone.trigger.origin, var7 + " seconds");
  self.hostvictimoverride = undefined;
  var8 = scripts\engine\utility::ter_op(var1 == "neutral", "idle", var1);
  thread updatechevrons(level.zone);
  level scripts\mp\gametypes\koth::updateservericons(var1, 0);
  self.didstatusnotify = 0;
}

function ref_1471e(var0) {
  binoculars_clearexpirationtimer(var0);
}

function zone_stompprogressreward(var0) {
  var0 thread scripts\mp\rank::scoreeventpopup("defend");
  var0 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

function zone_onpinnedstate(var0) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
    return;
  }
}

function zone_onunpinnedstate(var0) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate) {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    return;
  }
}

function binoculars_clearexpirationtimer(var0, var1) {
  if(!level.ref_1221a) {
    return;
  }

  var2 = scripts\mp\gamescore::_getteamscore(var0);
  var3 = scripts\mp\gamescore::_getteamscore(scripts\mp\utility\game::getotherteam(var0)[0]);

  if(istrue(var1)) {
    if(var3 > var2) {
      level scripts\mp\gamelogic::resumetimer();
      return;
    }

    level scripts\mp\gamelogic::pausetimer();
    return;
  }

  if(var2 > var3) {
    level scripts\mp\gamelogic::resumetimer();
    return;
  }

  level scripts\mp\gamelogic::pausetimer();
}

function setcrankedtimerzonecap(var0) {
  if(isDefined(level.supportcranked) && level.supportcranked && isDefined(var0.cranked) && var0.cranked) {
    var0 scripts\mp\cranked::setcrankedplayerbombtimer("assist");
    return;
  }
}

function playhardpointneutralfx() {
  if(istrue(level.usehpzonebrushes)) {
    foreach(var1 in level.players) {
      showzoneneutralbrush(var1);
    }

    return;
  }
}

function showcapturedhardpointeffecttoplayer(var0, var1) {
  var2 = var1.team;
  var3 = var1 ismlgspectator();

  if(var3) {
    if(var1 enablereloading() || var1 useinvisibleplayerduringspawnselection()) {
      var2 = "allies";
    } else {
      var2 = var1 getmlgspectatorteam();
    }
  }

  if(istrue(level.usehpzonebrushes)) {
    if(level.zone.stalemate) {
      showzonecontestedbrush(var1);
      return;
    }

    if(var2 == var0) {
      showzonefriendlybrush(var1);
      return;
    }

    showzoneenemybrush(var1);
    return;
  }
}

function showzoneneutralbrush(var0) {
  level.zone.friendlybrush hidefromplayer(var0);
  level.zone.enemybrush hidefromplayer(var0);
  level.zone.contestedbrush hidefromplayer(var0);
  level.zone.neutralbrush showtoplayer(var0);
}

function showzonefriendlybrush(var0) {
  level.zone.friendlybrush showtoplayer(var0);
  level.zone.enemybrush hidefromplayer(var0);
  level.zone.contestedbrush hidefromplayer(var0);
  level.zone.neutralbrush hidefromplayer(var0);
}

function showzoneenemybrush(var0) {
  level.zone.friendlybrush hidefromplayer(var0);
  level.zone.enemybrush showtoplayer(var0);
  level.zone.contestedbrush hidefromplayer(var0);
  level.zone.neutralbrush hidefromplayer(var0);
}

function showzonecontestedbrush(var0) {
  level.zone.friendlybrush hidefromplayer(var0);
  level.zone.enemybrush hidefromplayer(var0);
  level.zone.contestedbrush showtoplayer(var0);
  level.zone.neutralbrush hidefromplayer(var0);
}

function hideplayerspecificbrushes(var0) {
  self.friendlybrush hidefromplayer(var0);
  self.enemybrush hidefromplayer(var0);
  self.neutralbrush hidefromplayer(var0);
  self.contestedbrush hidefromplayer(var0);
}

function onplayerjoinedteam(var0) {
  if(var0.team != "spectator" && level.zone.ownerteam != "neutral") {
    showcapturedhardpointeffecttoplayer(level.zone, level.zone.ownerteam, var0);
    return;
  }
}

function ref_12bff(var0, var1) {
  var2 = [];
  var3 = [];

  switch (level.mapname) {
    case "mp_m_speed":
      GscBinSkip0(0x2e, "1", [(-564, 1848, 24)]);

    case "mp_cave":
    case "mp_cave_am":
      GscBinSkip0(0x2e, "3", [(-692, 1828, 42), (-300, 1548, 76)]);

    case "mp_raid":
      GscBinSkip0(0x2e, "8", [(688, 256, 280)]);

    case "mp_herat":
      GscBinSkip0(0x2e, "7", [(-1230.29, -25.4772, 240.125)]);

    default:
      break;
  }

  if(isDefined(var3[var1])) {
    foreach(var5 in var0) {
      foreach(var7 in var3[var1]) {
        if(distance(var5.origin, var7) < 10) {
          var2 = var5;
          break;
        }
      }
    }
  }

  var0 = scripts\engine\utility::array_remove_array(var0, var2);
  return var0;
}

function ref_12806(var0, var1) {
  var2 = [];
  var3 = [];

  switch (level.mapname) {
    case "mp_m_speed":
      var2 = [];
      var2[0] = [(-564, 1880, 24), (0, 180, 0)];
      var2[1] = [(-564, 1976, 24), (0, 180, 0)];
      var2[2] = [(-564, 2072, 24), (0, 180, 0)];
      var2 = [];
      var2[0] = [(-1314, 472, 24), (0, 180, 0)];
      var2[1] = [(-1314, 568, 24), (0, 180, 0)];
      var2[2] = [(-1474, 816, 24), (0, 270, 0)];
      var2[3] = [(-1378, 816, 24), (0, 270, 0)];
      var2 = [];
      var2[0] = [(-1298, 1992, 24), (0, 180, 0)];
      var2[1] = [(-1400, 2262, 24), (0, 270, 0)];
      var2[2] = [(-1690, 2264, 24), (0, 270, 0)];
      break;
    case "mp_deadzone":
      var2 = [];
      var2[0] = [(436, 3435, 207.694), (0, 360, 0)];
      var2[1] = [(436, 3188, 247.694), (0, 360, 0)];
      var2[2] = [(436, 3098, 258.694), (0, 360, 0)];
      var2[3] = [(1051, 2796, 304), (0, 117.509, 0)];
      var2[4] = [(931, 2680, 304), (0, 147.509, 0)];
      var2[5] = [(515, 3522, 215), (0, 276, 0)];
      var2 = [];
      var2[0] = [(-400, 651, 436), (0, 180, 0)];
      var2[1] = [(-400, 557, 439), (0, 180, 0)];
      var2[2] = [(-400, 461, 446), (0, 180, 0)];
      var2[3] = [(-410, -65, 446), (0, 180, 0)];
      var2[4] = [(-408, 31, 448), (0, 180, 0)];
      break;
    case "mp_raid":
      var2 = [];
      var2[0] = [(-3118.59, 230.46, 292), (0, 0, 0)];
      var2 = [];
      var2[0] = [(688, 256, 295), (0, 270, 0)];
      var2[1] = [(749, 248, 295), (0, 270, 0)];
      var2 = [];
      var2[0] = [(-1490.62, -972.979, 422), (0, 90, 0)];
      var2 = [];
      var2[0] = [(-1695.67, 3211.7, 310), (0, 270, 0)];
      var2[1] = [(-1804.59, 3219.27, 284), (0, 270, 0)];
      var2 = [];
      var2[0] = [(260, 1416, 338), (0, 90, 0)];
      break;
    case "mp_cave":
    case "mp_cave_am":
      var2 = [];
      var2[0] = [(-514, 1328, 32), (0, 100, 0)];
      var2[1] = [(-692, 1828, 42), (0, 260, 0)];
      var2[2] = [(-564, 1804, 44), (0, 260, 0)];
      var2[3] = [(-500, 1788, 54), (0, 260, 0)];
      var2[4] = [(-312, 1528, 78), (0, 145, 0)];
      break;
    case "mp_hackney_yard":
    case "mp_hackney_am":
      var2 = [];
      var2[0] = [(994.552, 1760.12, 44), (0, 270, 0)];
      var2 = [];
      var2[0] = [(1322, -407.18, 29.184), (0, 90, 0)];
      break;
    case "mp_aniyah":
      var2 = [];
      var2[0] = [(1995.79, 394.828, 424), (0, 270, 0)];
      break;
    case "mp_herat":
      var2 = [];
      var2[0] = [(-1231.9, -132.317, 183.246), (0, 90, 0)];
      break;
    default:
      break;
  }

  if(isDefined(var2[var1])) {
    foreach(var5 in var2[var1]) {
      var6 = var5[0];
      var7 = var5[1];
      var8 = easepower("hardpoint_chevron", var6, var7);
      var3 = var8;
    }
  }

  var0 = scripts\engine\utility::array_combine(var0, var3);
  return var0;
}

function init_vo_arrays(var0, var1, var2) {
  var0.origin = var1;
  var0.angles = var2;
  return var0;
}

function ref_144da() {
  level endon("game_ended");
  level endon("stop_watching_trigger");
  var0 = self.entnum;
  self.trigger scripts\engine\utility::trigger_on();

  foreach(var2 in level.teamnamelist) {
    self.playerzombiedelayturnonfx[var2] = 0;
    self.playerzombiedestroyhud[var2] = [];
  }

  self.playerzombiedelayturnonfx["neutral"] = 0;
  self.playerzombiedestroyhud["neutral"] = [];
  self.playerzombiedestroyhud["none"] = [];
  self.getinventoryslotvo = 1;

  for(;;) {
    self.trigger waittill("trigger", var4);

    if(!scripts\mp\utility\player::isreallyalive(var4)) {
      continue;
    }

    if(isagent(var4)) {
      continue;
    }

    if(!scripts\mp\utility\entity::isgameparticipant(var4)) {
      continue;
    }

    if(istrue(var4.inlaststand)) {
      continue;
    }

    if(isDefined(var4.classname) && var4.classname == "script_vehicle") {
      continue;
    }

    if(!isDefined(var4.initialized_gameobject_vars)) {
      continue;
    }

    var5 = scripts\mp\gameobjects::getrelativeteam(var4.pers["team"]);

    if(isDefined(self.teamusetimes[var5]) && self.teamusetimes[var5] < 0) {
      continue;
    }

    if(scripts\mp\utility\player::isreallyalive(var4) && !isDefined(var4.touchtriggers[var0])) {
      var2 = var4.pers["team"];
      self.playerzombiedelayturnonfx[var2]++;
      var6 = var4.guid;
      var7 = spawnStruct();
      var7.player = var4;
      var7.starttime = gettime();
      self.playerzombiedestroyhud[var2][var6] = var7;
      var4.spawn_sentry_at_pos = 0;
    }

    if(scripts\mp\utility\player::isreallyalive(var4) && !isDefined(var4.touchtriggers[var0])) {
      thread playerzombiedovehicledamageimmunity(var4);
    }
  }
}

function playerzombiedovehicledamageimmunity(var0) {
  level endon("stop_watching_trigger");
  var1 = self.pers["team"];

  while(scripts\mp\utility\player::isreallyalive(self) && isDefined(var0.trigger) && self istouching(var0.trigger) && !level.gameended) {
    if(isDefined(var0.checkinteractteam) && var0.team != var1) {
      break;
    }

    if(istrue(self.inlaststand)) {
      break;
    }

    if(isDefined(var0.interactsquads) && !isDefined(var0.interactsquads[self.team]) || isDefined(var0.interactsquads) && !scripts\engine\utility::array_contains(var0.interactsquads[self.team], self.squadindex)) {
      break;
    }

    waitframe();
  }

  if(level.gameended) {
    return;
  }

  if(isDefined(self)) {
    var0.playerzombiedestroyhud[var1][self.guid] = undefined;
    self.spawn_sentry_at_pos = 0;
  } else {
    var2 = [];

    foreach(var5, var4 in var0.playerzombiedestroyhud[var1]) {
      if(!isDefined(var4.player)) {
        var2 = var5;
      }
    }

    foreach(var5 in var2) {
      var0.playerzombiedestroyhud[var1][var5] = undefined;
    }
  }

  var0.playerzombiedelayturnonfx[var1]--;
}