/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\obj_zonecapture.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\cranked;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\hq;
#using scripts\mp\gametypes\koth;
#using scripts\mp\hostmigration;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\teams;
#namespace obj_zonecapture;

function setupobjective(trigger, visuals, var_5ddbc1faed2c56e6, skipobjid) {
  zone = trigger;

  if(!isDefined(visuals)) {
    visuals = [];
    visuals[0] = zone;
  }

  if(istrue(var_5ddbc1faed2c56e6)) {
    reservedobjid = 0;
  } else {
    reservedobjid = undefined;
  }

  zone = scripts\mp\gameobjects::createuseobject("neutral", zone, visuals, (0, 0, 0), reservedobjid, skipobjid);
  zone scripts\mp\gameobjects::disableobject();
  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

  if(var_c8f4c582625f492d == #"gwai" || var_c8f4c582625f492d == #"wm" || var_c8f4c582625f492d == #"escort") {} else if(var_c8f4c582625f492d == #"koth" || var_c8f4c582625f492d == #"landgrab") {
    for(index = 0; index < zone.visuals.size; index++) {
      zone.visuals[index] hide();
    }
  } else {
    zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");
  }

  zone scripts\mp\gameobjects::cancontestclaim(1);
  zone.claimgracetime = level.zonecapturetime * 1000;
  zone scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(isDefined(trigger.objectivekey)) {
    zone.objectivekey = trigger.objectivekey;
  } else {
    zone.objectivekey = zone scripts\mp\gameobjects::getlabel();
  }

  if(var_c8f4c582625f492d == #"hq" || var_c8f4c582625f492d == #"gwai" || var_c8f4c582625f492d == #"landgrab") {
    zone scripts\mp\gameobjects::mustmaintainclaim(0);
  } else {
    zone scripts\mp\gameobjects::mustmaintainclaim(1);
  }

  zone.id = "hardpoint";

  if(isDefined(zone.trigger.target) && (var_c8f4c582625f492d == #"koth" || var_c8f4c582625f492d == #"wm" || var_c8f4c582625f492d == #"landgrab" || var_c8f4c582625f492d == #"hq")) {
    zone thread assignchevrons(zone.trigger.target, zone.trigger.script_label);
  }

  return zone;
}

function function_e4c3058ef8c3819e(zone) {
  if(isDefined(level.var_e4c3058ef8c3819e)) {
    zone[[level.var_e4c3058ef8c3819e]]();
  }
}

function assignchevrons(target, label) {
  zone = self;
  wait 1;
  othervisuals = getentitylessscriptablearray(target, "targetname");
  othervisuals = removechevronsfromarray(othervisuals, label);
  othervisuals = postshipmodifychevrons(othervisuals, label);
  chevrons = [];

  foreach(visual in othervisuals) {
    index = chevrons.size;
    chevrons[index] = visual;
    chevrons[index].numchevrons = 1;

    if(isDefined(visual.script_noteworthy)) {
      if(visual.script_noteworthy == "2") {
        chevrons[index].numchevrons = 2;
        continue;
      }

      if(visual.script_noteworthy == "3") {
        chevrons[index].numchevrons = 3;
        continue;
      }

      if(visual.script_noteworthy == "4") {
        chevrons[index].numchevrons = 4;
      }
    }
  }

  zone.chevrons = chevrons;
}

function updatechevrons(state) {
  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

  if(!(var_c8f4c582625f492d == #"koth" || var_c8f4c582625f492d == #"landgrab" || var_c8f4c582625f492d == #"wm" || var_c8f4c582625f492d == #"escort" || var_c8f4c582625f492d == #"hq")) {
    return;
  }

  zone = self;
  zone notify("updateChevrons");
  zone endon("updateChevrons");

  while(!isDefined(zone.chevrons)) {
    waitframe();
  }

  foreach(chevron in zone.chevrons) {
    for(i = 0; i < chevron.numchevrons; i++) {
      chevron setscriptablepartstate("chevron_" + i, state);
    }
  }

  function_e4c3058ef8c3819e(zone);
}

function function_684d05448781a1f4() {
  zone = self;

  if(!istrue(zone.active)) {
    zone thread updatechevrons("off");
    return;
  }

  if(zone.stalemate) {
    zone thread updatechevrons("contested");
    return;
  }

  if(zone.ownerteam != "neutral") {
    var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());
    relativeteam = ter_op(var_c8f4c582625f492d == #"escort", game["attackers"], zone.ownerteam);
    zone thread updatechevrons(relativeteam);
    return;
  }

  if(zone.isunoccupied || istrue(level.zoneislocked)) {
    zone thread updatechevrons("idle");
    return;
  }

  zone thread updatechevrons(zone.mostnumtouchingteam);
}

function activatezone(objid, skipobjid) {
  zone = self;
  zone.onuse = &zone_onuse;
  zone.onbeginuse = &zone_onusebegin;
  zone.onuseupdate = &zone_onuseupdate;
  zone.onenduse = &zone_onuseend;
  zone.onunoccupied = &zone_onunoccupied;
  zone.oncontested = &zone_oncontested;
  zone.onuncontested = &zone_onuncontested;
  zone.stompprogressreward = &zone_stompprogressreward;
  zone.onpinnedstate = &zone_onpinnedstate;
  zone.onunpinnedstate = &zone_onunpinnedstate;
  zone.didstatusnotify = 0;

  if(!istrue(skipobjid)) {
    if(isDefined(objid)) {
      zone scripts\mp\gameobjects::requestid(1, 1, objid, 1, 0);
    } else {
      zone scripts\mp\gameobjects::requestid(1, 1, 0, 1, 0);
    }
  }

  var_40db97c5db5e1e3e = zone.curorigin;

  if(isDefined(level.gethillspawnshutofforigin)) {
    var_40db97c5db5e1e3e = [[level.gethillspawnshutofforigin]]();
  }

  dangerzoneradius = 1024;

  if(isDefined(level.gethillspawnshutoffradius)) {
    dangerzoneradius = [[level.gethillspawnshutoffradius]]();
  }

  dangerzoneids = [];
  dangerzoneids[dangerzoneids.size] = scripts\mp\spawnlogic::addspawndangerzone(var_40db97c5db5e1e3e - (0, 0, 2048), dangerzoneradius, 4096, "allies", undefined, undefined, undefined, undefined, undefined, 1);
  dangerzoneids[dangerzoneids.size] = scripts\mp\spawnlogic::addspawndangerzone(var_40db97c5db5e1e3e - (0, 0, 2048), dangerzoneradius, 4096, "axis", undefined, undefined, undefined, undefined, undefined, 1);
  zone.dangerzoneids = dangerzoneids;
  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

  if(var_c8f4c582625f492d == #"koth" || var_c8f4c582625f492d == #"grnd") {
    zone.ignorestomp = 1;
    zone.alwaysstalemate = 1;

    if(istrue(level.zonemajoritycapture)) {
      zone.alwaysstalemate = 0;
      zone.var_88806e65c3197677 = 1;
    }
  } else {
    zone.stompeenemyprogressupdate = &zone_stompeenemyprogressupdate;
    scripts\mp\objidpoolmanager::update_objective_position(zone.objidnum, zone.visuals[0].origin + (0, 0, 70));
  }

  if(var_c8f4c582625f492d == #"wm") {
    zone.alwaysstalemate = 1;
  }
}

function deactivatezone() {
  zone = self;
  zone.onuse = undefined;
  zone.onbeginuse = undefined;
  zone.onuseupdate = undefined;
  zone.onunoccupied = undefined;
  zone.oncontested = undefined;
  zone.onuncontested = undefined;
  zone.stalemate = 0;
  zone.wasstalemate = 0;
  zone.didstatusnotify = 0;
  zone thread updatechevrons("off");

  foreach(dangerid in zone.dangerzoneids) {
    scripts\mp\spawnlogic::removespawndangerzone(dangerid);
  }

  zone.dangerzoneids = undefined;

  foreach(player in level.players) {
    scripts\mp\objidpoolmanager::objective_unpin_player(zone.objidnum, player);
  }

  zone.trigger scripts\engine\utility::trigger_off();
  zone thread waitthensetvisibleteam();
  zone scripts\mp\gameobjects::releaseid(1, 0);
  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

  if(var_c8f4c582625f492d == #"hq") {
    zone.visuals[0] playSound("mp_hq_deactivate_sfx");
    thread scripts\mp\music_and_dialog::headquarters_deactivate_music(zone.lastclaimteam);
    zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_close");
    zone.visuals[0] stoploopsound();
  }

  level.scoreleadchanged = 0;
}

function zonetimerwait() {
  level endon("game_ended");
  level endon("dev_force_zone");
  var_ff049ff4093f7a4e = int(level.zonemovetime * 1000 + gettime());

  if(!isDefined(level.zoneselectiondelay) || level.zoneselectiondelay < 10) {
    thread hp_move_soon(level.zonemovetime);
  }

  level thread handlehostmigration(var_ff049ff4093f7a4e);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.zonemovetime);
}

function hp_move_soon(timer) {
  level endon("game_ended");

  level endon("<dev string:x1c>");

  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

  if(var_c8f4c582625f492d == #"hq") {
    level endon("zone_destroyed");
  }

  if(isDefined(level.nextzonerevealtime)) {
    timer = max(timer - level.nextzonerevealtime, 0);
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(timer);

  if(isDefined(level.futurezone)) {
    objid = scripts\mp\objidpoolmanager::function_92a696fa5918eca5(1);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);
    scripts\mp\objidpoolmanager::update_objective_state(objid, "current");
    scripts\mp\objidpoolmanager::update_objective_position(objid, level.futurezone.visuals[0].origin + level.futurezone.offset3d);
    level.futurezone scripts\mp\gameobjects::setvisibleteam("any", objid);
    level.futurezone scripts\mp\gameobjects::setobjectivestatusicons(level.iconnext, level.iconnext, objid);
  } else if(isDefined(level.futurezoneindex) && isDefined(level.var_7f2484c1d7066d39)) {
    level thread[[level.var_7f2484c1d7066d39]]();
  }

  if(timer < 3) {
    wait 3;
  }

  foreach(entry in level.teamnamelist) {
    level statusdialog("hp_move_soon", entry);
  }
}

function handlehostmigration(var_ff049ff4093f7a4e) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("disconnect");
  level endon("zone_captured");
  level waittill("host_migration_begin");
  setomnvar("ui_objective_timer_stopped", 1);
  timepassed = scripts\mp\hostmigration::waittillhostmigrationdone();
  setomnvar("ui_objective_timer_stopped", 0);

  if(timepassed > 0) {
    setomnvar("ui_hardpoint_timer", level.zoneendtime + timepassed);
    return;
  }

  setomnvar("ui_hardpoint_timer", level.zoneendtime);
}

function hardpoint_setneutral() {
  zone = self;
  zone notify("flag_neutral");
  zone scripts\mp\gameobjects::setownerteam("neutral");
  playhardpointneutralfx();
  zone thread updatechevrons("idle");
}

function trackgametypevips() {
  thread cleanupgametypevips();
  level endon("game_ended");
  level endon("zone_moved");
  zone = self;

  while(true) {
    foreach(player in level.players) {
      if(player istouching(zone.trigger)) {
        player setgametypevip(1);
        continue;
      }

      player setgametypevip(0);
    }

    wait 0.5;
  }
}

function cleanupgametypevips() {
  level waittill_any_2("game_ended", "zone_moved");

  foreach(player in level.players) {
    player setgametypevip(0);
  }
}

function zone_onuse(credit_player) {
  if(!isDefined(credit_player) || !isDefined(credit_player.team)) {
    return;
  }

  zone = self;
  scripts\mp\objidpoolmanager::objective_set_progress(zone.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(zone.objidnum, 0);
  capture_team = credit_player.team;
  capturetime = gettime();
  touchlist = [];
  touchkeys = getarraykeys(zone.touchlist[capture_team]);

  for(i = 0; i < touchkeys.size; i++) {
    touchlist[touchkeys[i]] = zone.touchlist[capture_team][touchkeys[i]];
  }

  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

  if(var_c8f4c582625f492d == #"koth") {
    level notify("Objective_SetShowProgress", zone.objidnum);
  }

  if(var_c8f4c582625f492d == #"hq" && zone.ownerteam != "neutral") {
    setomnvar("ui_hq_ownerteam", 0);
    level notify("zone_destroyed");

    foreach(player in level.players) {
      scripts\mp\objidpoolmanager::objective_unpin_player(zone.objidnum, player);
    }

    zone thread waitthensetvisibleteam();
    level scripts\mp\gametypes\koth::updateservericons("zone_shift", 0);

    if(isDefined(touchlist)) {
      players_touching = getarraykeys(touchlist);

      foreach(playerid in players_touching) {
        player = zone.assisttouchlist[capture_team][playerid].player;
      }
    }

    level thread scripts\mp\gametypes\hq::give_capture_credit(touchlist, capturetime, capture_team, undefined, credit_player, zone);
    level statusdialog("hp_timeout", credit_player.team);
    level statusdialog("hp_owned_lost", zone.ownerteam);
    return;
  }

  if(var_c8f4c582625f492d == #"hq") {
    capture_players = scripts\mp\utility\teams::getteamdata(capture_team, "players");

    foreach(player in capture_players) {
      player.skipspawncamera = 1;
    }
  }

  otherteam = getotherteam(capture_team)[0];
  zone scripts\mp\gameobjects::setownerteam(capture_team);

  if(var_c8f4c582625f492d == #"hq") {
    setomnvar("ui_hq_ownerteam", scripts\mp\gametypes\hq::gethqownerteamvalue(zone.ownerteam));
    setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::getteamdata(zone.ownerteam, "aliveCount"));
    level thread scripts\mp\gametypes\hq::awardcapturepoints();
    ownerteamscore = scripts\mp\gamescore::_getteamscore(capture_team);
    otherteamscore = scripts\mp\gamescore::_getteamscore(otherteam);

    if(ownerteamscore > otherteamscore) {
      level.scoreleadchanged = 1;
    }

    adjustmatchtimerpausedstatefromscore(capture_team);
  } else if(isDefined(level.var_a9bdef06142064a3)) {
    level thread[[level.var_a9bdef06142064a3]](zone, credit_player);
  } else {
    level thread scripts\mp\gametypes\koth::awardcapturepoints();

    if(level.pausemodetimer) {
      level scripts\mp\gamelogic::pausetimer();
    }
  }

  level.usestartspawns = 0;
  teamswitched = 0;
  zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
  level scripts\mp\gametypes\koth::updateservericons(capture_team, 0);

  if(var_c8f4c582625f492d == #"hq") {
    thread printandsoundoneveryone(capture_team, otherteam, undefined, undefined, "mp_dom_flag_captured", undefined, credit_player);
    thread scripts\mp\music_and_dialog::headquarters_captured_music();
  }

  if(!isDefined(level.lastcaptureteam) || level.lastcaptureteam != capture_team) {
    if(var_c8f4c582625f492d == #"hq") {
      if(isDefined(level.kothhillrotation && level.kothhillrotation == 0)) {
        level.delayleadtakendialog = 4;
      } else {
        level.delayleadtakendialog = undefined;
      }

      level thread delaydialogstatustoavoidcaptureoverlap(capture_team, otherteam);
    }

    assert(capture_team != "<dev string:x34>");

    if(var_c8f4c582625f492d == #"landgrab") {} else if(var_c8f4c582625f492d == #"koth" || var_c8f4c582625f492d == #"grnd") {
      level thread scripts\mp\gametypes\koth::give_capture_credit(touchlist, capturetime, capture_team, level.lastcaptureteam, credit_player, zone);
    } else {
      level thread scripts\mp\gametypes\hq::give_capture_credit(touchlist, capturetime, capture_team, level.lastcaptureteam, credit_player, zone);
    }
  }

  foreach(var_80ce5b9516cca684 in level.players) {
    zone showcapturedhardpointeffecttoplayer(capture_team, var_80ce5b9516cca684);
  }

  zone thread updatechevrons(capture_team);

  if(var_c8f4c582625f492d == #"hq") {
    zone.visuals[0] stoploopsound();
    zone.visuals[0] scriptmodelplayanim("iw8_mp_military_hq_crate_open_idle");
    players = scripts\mp\utility\teams::getteamdata(capture_team, "players");

    foreach(player in players) {
      player thread scripts\mp\gametypes\hq::showrespawnwarningmessage();
    }
  }

  level.hpcapteam = capture_team;
  zone.capturecount++;
  level.lastcaptureteam = capture_team;
  level notify("zone_captured");
  level notify("zone_captured" + capture_team);
}

function waitthensetvisibleteam() {
  zone = self;
  waitframe();
  zone scripts\mp\gameobjects::setvisibleteam("none");
}

function zone_onusebegin(player) {
  player.isonobjective = 1;
  zone = self;
  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());
  ownerteam = zone scripts\mp\gameobjects::getownerteam();

  if(var_c8f4c582625f492d == #"hq") {
    if(ownerteam != "neutral" && zone.claimteam != ownerteam) {
      adjustmatchtimerpausedstatefromscore(ownerteam, 1);
    }

    if(!istrue(zone.stalemate) && isPlayer(player)) {
      if(ownerteam == "neutral") {
        player setclientomnvar("ui_objective_pinned_text_param", 1);
      } else {
        player setclientomnvar("ui_objective_pinned_text_param", 2);
      }
    }

    zone function_684d05448781a1f4();
  } else if(var_c8f4c582625f492d == #"landgrab" && ownerteam == "neutral") {
    zone function_684d05448781a1f4();
  }

  if(!isDefined(zone.statusnotifytime)) {
    zone.statusnotifytime = gettime();
  }

  if(zone.statusnotifytime > zone.statusnotifytime + 10000) {
    zone.didstatusnotify = 0;
    zone.statusnotifytime = gettime();
  }

  zone scripts\mp\gameobjects::setusetime(level.zonecapturetime);

  if(level.zonecapturetime > 0) {
    zone.prevownerteam = getotherteam(player.team)[0];
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
  }
}

function zone_onuseupdate(team, progress, change, capplayer) {
  zone = self;
  zone scripts\mp\objidpoolmanager::function_9b1a086f348520b0(zone.objidnum, team);
  ownerteam = zone scripts\mp\gameobjects::getownerteam();
  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

  if(var_c8f4c582625f492d == #"hq" || var_c8f4c582625f492d == #"wm" || var_c8f4c582625f492d == #"escort") {
    if(!istrue(level.mapname == "mp_jup_skydiving" && (zone.objectivekey == "_e" || zone.objectivekey == "_f"))) {
      if(progress < 1 && !level.gameended) {
        playcapturesound(progress, team);
      }
    }
  }

  if(var_c8f4c582625f492d == #"hq") {
    if(ownerteam == "neutral" && zone.claimteam != ownerteam) {
      adjustmatchtimerpausedstatefromscore(zone.claimteam);
    } else if(ownerteam != "neutral" && zone.claimteam != ownerteam) {
      adjustmatchtimerpausedstatefromscore(ownerteam, 1);
    } else if(level.pausemodetimer) {
      level scripts\mp\gamelogic::pausetimer();
    }
  } else if(level.pausemodetimer) {
    level scripts\mp\gamelogic::pausetimer();
  }

  ownerteam = zone scripts\mp\gameobjects::getownerteam();
  otherteam = getotherteam(team)[0];

  if(progress > 0.05 && change && !zone.didstatusnotify) {
    if(ownerteam == "neutral") {
      statusdialog("hp_capturing_friendly", team);
      statusdialog("hp_capturing_enemy", otherteam);
    } else if(var_c8f4c582625f492d == #"hq") {
      statusdialog("hp_disabling_friendly", ownerteam);
      statusdialog("hp_disabling_enemy", team);
    } else {
      statusdialog("hp_capturing_enemy", ownerteam);
      statusdialog("hp_capturing_friendly", team);
    }

    zone.didstatusnotify = 1;
  }
}

function delaydialogstatustoavoidcaptureoverlap(capture_team, otherteam) {
  wait 0.5;
  level statusdialog("hp_secured_friendly", capture_team);
  level statusdialog("hp_captured_enemy", otherteam);
}

function playcapturesound(progress, team) {
  zone = self;

  if(!isDefined(zone.lastsfxplayedtime)) {
    zone.lastsfxplayedtime = gettime();
  }

  if(zone.lastsfxplayedtime + 995 < gettime()) {
    zone.lastsfxplayedtime = gettime();
    var_c3ddfb0eaa8f761c = "";
    progress = int(floor(progress * 10));
    var_c3ddfb0eaa8f761c = "mp_dom_capturing_tick_0" + progress;
    zone.visuals[0] playsoundtoteam(var_c3ddfb0eaa8f761c, team);
  }
}

function zone_onuseend(team, player, success) {
  if(isDefined(player)) {
    player.isonobjective = 0;
  }

  zone = self;
  ownerteam = zone scripts\mp\gameobjects::getownerteam();
  level notify("stop_contested_stats_thread");

  if(!success) {
    var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

    if(var_c8f4c582625f492d == #"hq") {
      if(ownerteam != "neutral") {
        adjustmatchtimerpausedstatefromscore(ownerteam);
      }
    } else if(level.pausemodetimer) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  if(isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", 0);
  }

  if(ownerteam == "neutral") {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

    if(istrue(level.usehpzonebrushes)) {
      foreach(player in level.players) {
        zone showzoneneutralbrush(player);
      }
    }

    return;
  }

  zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  foreach(player in level.players) {
    zone showcapturedhardpointeffecttoplayer(ownerteam, player);
  }
}

function zone_onunoccupied() {
  zone = self;
  var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

  if(var_c8f4c582625f492d == #"hq" && zone.ownerteam != "neutral") {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    adjustmatchtimerpausedstatefromscore(zone.ownerteam);
    zone function_684d05448781a1f4();
  } else if(var_c8f4c582625f492d == #"landgrab" && zone.ownerteam != "neutral") {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    zone function_684d05448781a1f4();
  } else if((var_c8f4c582625f492d == #"wm" || var_c8f4c582625f492d == #"escort") && zone.ownerteam != "neutral") {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    zone function_684d05448781a1f4();
  } else {
    level notify("zone_destroyed");
    level.hpcapteam = "neutral";

    if(level.pausemodetimer) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level scripts\mp\gametypes\koth::updateservericons("neutral", 0);
    zone.wasleftunoccupied = 1;
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    zone playhardpointneutralfx();
    zone thread updatechevrons("idle");
  }

  zone scripts\mp\objidpoolmanager::function_9b1a086f348520b0(zone.objidnum, "neutral");
  zone notify("zone_unoccupied");
}

function zone_oncontested() {
  zone = self;
  zone thread scripts\mp\gametypes\koth::function_69c581621849df52();

  if(level.pausemodetimer) {
    level scripts\mp\gamelogic::resumetimer();
  }

  zone.contestedtime = gettime();
  ownerteam = zone scripts\mp\gameobjects::getownerteam();
  zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  level scripts\mp\gametypes\koth::updateservericons(ownerteam, 1);
  zone thread updatechevrons("contested");

  foreach(team in level.teamnamelist) {
    if(zone.touchlist[team].size) {
      touchlist = zone.touchlist[team];
      players_touching = getarraykeys(touchlist);

      for(index = 0; index < players_touching.size; index++) {
        player = touchlist[players_touching[index]].player;

        if(isPlayer(player)) {
          player setclientomnvar("ui_objective_pinned_text_param", 3);
        }
      }
    }
  }

  foreach(player in level.players) {
    zone showcapturedhardpointeffecttoplayer(ownerteam, player);
  }

  if(ownerteam == "neutral") {
    notifyteam = zone.claimteam;
  } else {
    notifyteam = ownerteam;
  }

  var_c8f4c582625f492d = function_1823ff50bb28148d(getgametype());

  if(var_c8f4c582625f492d != #"landgrab") {
    foreach(entry in level.teamnamelist) {
      statusdialog("hp_contested", entry);
    }
  } else {
    zone function_684d05448781a1f4();
  }

  var_7e2c53b0bcf117d9 = spawnStruct();
  var_7e2c53b0bcf117d9.player = zone;
  var_7e2c53b0bcf117d9.eventname = "hill_contested";
  var_7e2c53b0bcf117d9.position = zone.trigger.origin;
  zone thread function_da1f3979f22bb288(zone.trigger.origin, "jup_shared_zone_contested", 3);
  zone.didstatusnotify = 1;
  zone scripts\mp\objidpoolmanager::function_9b1a086f348520b0(zone.objidnum, "neutral");
}

function zone_onuncontested(lastclaimteam) {
  zone = self;
  level notify("stop_contested_stats_thread");
  zone thread function_82b6a3e1bcda539b(zone.trigger.origin, "jup_shared_zone_uncontested", 3);

  if(level.pausemodetimer) {
    level scripts\mp\gamelogic::pausetimer();
  }

  ownerteam = zone scripts\mp\gameobjects::getownerteam();

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    zone scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);

    if(istrue(level.usehpzonebrushes)) {
      foreach(player in level.players) {
        zone showzoneneutralbrush(player);
      }
    }

    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = zone;
    var_7e2c53b0bcf117d9.eventname = "hill_empty";
    var_7e2c53b0bcf117d9.position = zone.trigger.origin;

    if(ownerteam == "neutral") {
      playsoundatpos(zone.trigger.origin, "jup_shared_zone_neutral_ping");
    }
  } else {
    var_c8f4c582625f492d = function_1823ff50bb28148d(getbasegametype());

    if(var_c8f4c582625f492d == #"koth") {
      scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_positive", ownerteam);
      scripts\mp\utility\sound::playsoundonplayers("mp_hardpoint_captured_negative", getotherteam(ownerteam)[0]);
    } else if(var_c8f4c582625f492d == #"grnd") {
      scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_positive", ownerteam);
      scripts\mp\utility\sound::playsoundonplayers("mp_dropzone_captured_negative", getotherteam(ownerteam)[0]);
    }

    zone function_dcbc745e92f98a9f(level.icondefend, level.iconcapture);

    foreach(player in level.players) {
      zone showcapturedhardpointeffecttoplayer(ownerteam, player);
    }

    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = zone;
    var_7e2c53b0bcf117d9.eventname = "hill_uncontested";
    var_7e2c53b0bcf117d9.position = zone.trigger.origin;
  }

  contestedtime = (gettime() - zone.contestedtime) * 0.001;
  logannouncement(undefined, undefined, "Zone Contested", zone.trigger.origin, contestedtime + " seconds");
  zone.contestedtime = undefined;
  zone function_684d05448781a1f4();
  level scripts\mp\gametypes\koth::updateservericons(ownerteam, 0);
  zone.didstatusnotify = 0;
  zone scripts\mp\objidpoolmanager::function_9b1a086f348520b0(zone.objidnum, "neutral");
}

function zone_stompeenemyprogressupdate(team) {
  adjustmatchtimerpausedstatefromscore(team);
}

function zone_stompprogressreward(player) {
  zone = self;
  player thread scripts\mp\rank::scoreeventpopup(#"defend");
  player thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
  zone scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

function function_dcbc745e92f98a9f(friendlyicon, enemyicon) {
  if(function_1823ff50bb28148d(getgametype()) == #"wm" && !self.stalemate) {
    if(self.numtouching[self.ownerteam]) {
      friendlyicon = level.icondefending;
    }

    if(self.numtouching[getotherteam(self.ownerteam)[0]]) {
      enemyicon = level.icontaking;
      friendlyicon = level.iconlosing;
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons(friendlyicon, enemyicon);
}

function zone_onpinnedstate(player) {
  zone = self;

  if(!zone.stalemate) {
    if(zone.ownerteam != "neutral" && zone.numtouching[zone.ownerteam] || function_1823ff50bb28148d(getgametype()) == #"wm" && isDefined(player.team) && zone.numtouching[player.team]) {
      zone function_dcbc745e92f98a9f(level.icondefending, level.iconcapture);
    }
  }

  function_e4c3058ef8c3819e(zone);
}

function zone_onunpinnedstate(player) {
  zone = self;

  if(!zone.stalemate) {
    if(zone.ownerteam != "neutral" && !zone.numtouching[zone.ownerteam] || isDefined(player.team) && !zone.numtouching[player.team]) {
      zone function_dcbc745e92f98a9f(level.icondefend, level.iconcapture);
    }
  }

  function_e4c3058ef8c3819e(zone);
}

function adjustmatchtimerpausedstatefromscore(team, var_ac8cfc833c6f6e23) {
  if(!level.pausemodetimer) {
    return;
  }

  ownerteamscore = scripts\mp\gamescore::_getteamscore(team);
  otherteamscore = scripts\mp\gamescore::_getteamscore(getotherteam(team)[0]);

  if(istrue(var_ac8cfc833c6f6e23)) {
    if(otherteamscore > ownerteamscore) {
      level scripts\mp\gamelogic::resumetimer();
    } else {
      level scripts\mp\gamelogic::pausetimer();
    }

    return;
  }

  if(ownerteamscore > otherteamscore) {
    level scripts\mp\gamelogic::resumetimer();
    return;
  }

  level scripts\mp\gamelogic::pausetimer();
}

function setcrankedtimerzonecap(player) {
  if((function_f698bfd3efa33302() || function_e9f3a160bbefe208(player)) && isDefined(player.cranked) && player.cranked) {
    player scripts\mp\cranked::setcrankedplayerbombtimer("assist");
  }
}

function playhardpointneutralfx() {
  if(istrue(level.usehpzonebrushes)) {
    foreach(player in level.players) {
      showzoneneutralbrush(player);
    }
  }
}

function showcapturedhardpointeffecttoplayer(capture_team, player) {
  zone = self;
  var_8e879faf3052e0d2 = player.team;
  iscodcaster = player iscodcaster();

  if(iscodcaster) {
    if(player ismlgfreecamenabled() || player ismlgaerialcamenabled()) {
      var_8e879faf3052e0d2 = "allies";
    } else {
      var_8e879faf3052e0d2 = player function_638eebeff841e16a();
    }
  }

  if(istrue(level.usehpzonebrushes)) {
    if(zone.stalemate) {
      showzonecontestedbrush(player);
      return;
    }

    if(var_8e879faf3052e0d2 == capture_team) {
      showzonefriendlybrush(player);
      return;
    }

    showzoneenemybrush(player);
  }
}

function showzoneneutralbrush(player) {
  zone = self;
  zone.friendlybrush hidefromplayer(player);
  zone.enemybrush hidefromplayer(player);
  zone.contestedbrush hidefromplayer(player);
  zone.neutralbrush showtoplayer(player);
}

function showzonefriendlybrush(player) {
  zone = self;
  zone.friendlybrush showtoplayer(player);
  zone.enemybrush hidefromplayer(player);
  zone.contestedbrush hidefromplayer(player);
  zone.neutralbrush hidefromplayer(player);
}

function showzoneenemybrush(player) {
  zone = self;
  zone.friendlybrush hidefromplayer(player);
  zone.enemybrush showtoplayer(player);
  zone.contestedbrush hidefromplayer(player);
  zone.neutralbrush hidefromplayer(player);
}

function showzonecontestedbrush(player) {
  zone = self;
  zone.friendlybrush hidefromplayer(player);
  zone.enemybrush hidefromplayer(player);
  zone.contestedbrush showtoplayer(player);
  zone.neutralbrush hidefromplayer(player);
}

function hideplayerspecificbrushes(player) {
  zone = self;
  zone.friendlybrush hidefromplayer(player);
  zone.enemybrush hidefromplayer(player);
  zone.neutralbrush hidefromplayer(player);
  zone.contestedbrush hidefromplayer(player);
}

function onplayerjoinedteam(player) {
  zone = self;

  if(player.team != "spectator" && zone.ownerteam != "neutral") {
    zone showcapturedhardpointeffecttoplayer(zone.ownerteam, player);
  }
}

function removechevronsfromarray(othervisuals, label) {
  modifiedvisuals = [];
  var_d23f6234846f86a6 = [];

  switch (level.mapname) {
    case #"hash_9de262a7132ec180":
      var_d23f6234846f86a6["1"] = [(-564, 1848, 24)];
      var_d23f6234846f86a6["2"] = [(-1314, 440, 24), (-1362, 816, 24)];
      break;
    case #"hash_66ce5cdcd3b547f3":
    case #"hash_ff009e5fab42b778":
      var_d23f6234846f86a6["3"] = [(-692, 1828, 42), (-300, 1548, 76)];
      break;
    case #"hash_f09747c9feb47eb1":
      var_d23f6234846f86a6["8"] = [(688, 256, 280)];
      var_d23f6234846f86a6["20"] = [(212, 1436, 338)];
      break;
    case #"hash_81b84d832a53ee33":
      var_d23f6234846f86a6["5"] = [(778, -1458, 136), (860, -1226, 158)];
      break;
    case #"hash_dfa04d97b4cc9b44":
      var_d23f6234846f86a6["5"] = [(-6792, 42420, 221), (-6680, 42778, 213)];
      break;
    default:
      break;
  }

  if(isDefined(var_d23f6234846f86a6[label])) {
    foreach(visual in othervisuals) {
      foreach(entry in var_d23f6234846f86a6[label]) {
        if(distance(visual.origin, entry) < 10) {
          modifiedvisuals[modifiedvisuals.size] = visual;
          break;
        }
      }
    }
  }

  othervisuals = array_remove_array(othervisuals, modifiedvisuals);
  return othervisuals;
}

function postshipmodifychevrons(othervisuals, label) {
  var_34dce00df63cff91 = [];
  modifiedvisuals = [];

  if(isDefined(var_34dce00df63cff91[label])) {
    foreach(entry in var_34dce00df63cff91[label]) {
      origin = entry[0];
      angles = entry[1];
      scriptable = spawnscriptable("hardpoint_chevron", origin, angles);
      modifiedvisuals[modifiedvisuals.size] = scriptable;
    }
  }

  othervisuals = array_combine(othervisuals, modifiedvisuals);
  return othervisuals;
}

function createvisualsinfo(scriptable, origin, angles) {
  scriptable.origin = origin;
  scriptable.angles = angles;
  return scriptable;
}

function function_da1f3979f22bb288(posorigin, alias, timer) {
  if(!isDefined(self.var_4efd1a215d3e63d6)) {
    playsoundatpos(posorigin, alias);
    self.var_4efd1a215d3e63d6 = 1;
    wait timer;
    self.var_4efd1a215d3e63d6 = undefined;
    return;
  }

  return;
}

function function_82b6a3e1bcda539b(posorigin, alias, timer) {
  if(!isDefined(self.var_e264252f7f1f6def)) {
    playsoundatpos(posorigin, alias);
    self.var_e264252f7f1f6def = 1;
    wait timer;
    self.var_e264252f7f1f6def = undefined;
    return;
  }

  return;
}

function calculatespawndisttozones(spawnpoint, maxdistance) {
  if(!isDefined(maxdistance)) {
    maxdistance = 5000;
  }

  spawnpoint.scriptdata.var_c7e3d9e2f0dd4e7 = [];

  foreach(zone in level.objectives) {
    dist = getpathdist(spawnpoint.origin, zone.origin, maxdistance);

    if(dist < 0) {
      dist = utility::distance_2d_squared(spawnpoint.origin, zone.origin);
    } else {
      dist *= dist;
    }

    spawnpoint.scriptdata.var_c7e3d9e2f0dd4e7[zone getentitynumber()] = dist;

    if(dist > zone.furthestspawndistsq) {
      zone.furthestspawndistsq = dist;
    }
  }
}

function function_492958e372181db0(spawnpoint, zones, maxdistance) {
  if(!isDefined(maxdistance)) {
    maxdistance = 5000;
  }

  spawnpoint.scriptdata.var_c7e3d9e2f0dd4e7 = [];

  foreach(zone in zones) {
    dist = getpathdist(spawnpoint.origin, zone.trigger.origin, maxdistance);

    if(dist < 0) {
      dist = utility::distance_2d_squared(spawnpoint.origin, zone.trigger.origin);
    } else {
      dist *= dist;
    }

    spawnpoint.scriptdata.var_c7e3d9e2f0dd4e7[zone.trigger getentitynumber()] = dist;

    if(dist > zone.furthestspawndistsq) {
      zone.furthestspawndistsq = dist;
    }
  }
}

function function_abdea33c2ac7149b(spawntype, spawnset) {
  var_6e51138d961d7ddd = scripts\cp_mp\utility\game_utility::function_a0148d3a4a97bbb1();

  foreach(spawnpoint in level.spawnglobals.spawnsetlists[spawnset]) {
    var_7ba87fdf5e9815e0 = [];

    if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "") {
      zoneindicies = [];

      if(var_6e51138d961d7ddd) {
        zoneindicies = strtok(spawnpoint.target, " ");
      } else {
        zoneindicies = strtok(spawnpoint.script_noteworthy, " ");
      }

      foreach(zoneindex in zoneindicies) {
        zone = level.objectives[zoneindex];
        assertex(isDefined(zone), "<dev string:x3f>" + zoneindex + "<dev string:x4f>");

        if(isDefined(zone)) {
          var_7ba87fdf5e9815e0[var_7ba87fdf5e9815e0.size] = zone;
        }
      }
    }

    if(var_7ba87fdf5e9815e0.size == 0) {
      var_7ba87fdf5e9815e0 = level.objectives;
    }

    foreach(zone in var_7ba87fdf5e9815e0) {
      zone.spawnpoints[spawntype][zone.spawnpoints[spawntype].size] = spawnpoint;
    }

    function_492958e372181db0(spawnpoint, var_7ba87fdf5e9815e0);
  }
}

function function_4265173fd3869f34(spawntype, spawnset, spawnkey) {
  if(!spawnlogic::function_b17bf43316b9fb08()) {
    return function_abdea33c2ac7149b(spawntype, spawnset);
  }

  var_5bb7552749b30524 = ["zone1", "zone2", "zone3", "zone4", "zone5", "zone6", "zone7", "zone8", "zone9", "zone10"];
  assertex(var_5bb7552749b30524.size >= level.objectives, "<dev string:x9f>" + var_5bb7552749b30524.size + "<dev string:xd2>");

  foreach(spawnpoint in level.spawnglobals.spawnsetlists[spawnset]) {
    var_7ba87fdf5e9815e0 = [];

    foreach(zone in level.objectives) {
      zoneindex = int(zone.objectivekey) - 1;
      assert(zoneindex >= 0 && zoneindex < var_5bb7552749b30524.size);
      spawnvalue = var_5bb7552749b30524[int(zone.objectivekey) - 1];
      assertex(isDefined(spawnvalue), "<dev string:xdd>" + zone.objectivekey);

      if(function_7dd257e3ae572dc0(spawnpoint.index, spawnkey, spawnvalue)) {
        var_7ba87fdf5e9815e0[var_7ba87fdf5e9815e0.size] = zone;
      }
    }

    if(var_7ba87fdf5e9815e0.size == 0) {
      var_7ba87fdf5e9815e0 = level.objectives;
    }

    foreach(zone in var_7ba87fdf5e9815e0) {
      zone.spawnpoints[spawntype][zone.spawnpoints[spawntype].size] = spawnpoint;
    }

    function_492958e372181db0(spawnpoint, var_7ba87fdf5e9815e0);
  }
}