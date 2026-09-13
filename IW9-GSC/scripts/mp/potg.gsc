/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\potg.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || istrue(game["isLaunchChunk"])) {
    level.potgenabled = 0;
    return;
  }

  if(!isDefined(level.potgenabled) || level.potgenabled)
    level.potgenabled = level.finalkillcamtype == 1;

  if(getdvarint("dvar_6625C2CB0DE90A41", 0) == 0)
    level.potgenabled = 0;

  if(!level.potgenabled) {
    return;
  }
  _id_584994FAB4A8712B = spawnStruct();
  level.potgglobals = _id_584994FAB4A8712B;
  _id_584994FAB4A8712B.curpotgscene = undefined;
  _id_584994FAB4A8712B.systemfinalized = 0;
  _id_584994FAB4A8712B.entities = [];
  _id_584994FAB4A8712B.settings = [];
  _id_584994FAB4A8712B.settingtypes = [];
  _id_584994FAB4A8712B.nextsceneid = 0;
  _id_584994FAB4A8712B.lastarchivetime = -1;
  _id_584994FAB4A8712B.pendingarchiverequest = 0;
  loadeventtable();
  setdvarifuninitialized("potg_action_duration_max", 8000);
  setdvarifuninitialized("potg_action_duration_min", 3000);
  setdvarifuninitialized("potg_buffer_duration", 3500);
  setdvarifuninitialized("potg_debug_archive", 1000);
  setdvarifuninitialized("potg_min_scene_score", 420);
  thread onplayerconnect();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  scripts\mp\potg_events::init();
}

getminimumscorerequired() {
  return getdvarint("potg_min_scene_score");
}

getactionscenedurationmax() {
  return getdvarint("potg_action_duration_max");
}

getactionscenedurationmin() {
  return getdvarint("potg_action_duration_min");
}

getscenebufferduration() {
  return getdvarint("potg_buffer_duration");
}

getwholescenedurationmin() {
  return getactionscenedurationmin() + getscenebufferduration() * 2;
}

getwholescenedurationmax() {
  return getactionscenedurationmax() + getscenebufferduration() * 2;
}

getminimumscorerequirednvidiahighlights() {
  return getdvarint("dvar_750A15DA0BD4DC96");
}

loadeventtable() {
  _id_584994FAB4A8712B = level.potgglobals;
  _id_43F004CCE557F835 = 0;

  for(;;) {
    eventref = tablelookupbyrow("mp/potg_event_table.csv", _id_43F004CCE557F835, 0);

    if(!isDefined(eventref) || eventref == "") {
      break;
    }

    _id_584994FAB4A8712B.eventtable[eventref] = [];
    score = tablelookupbyrow("mp/potg_event_table.csv", _id_43F004CCE557F835, 1);
    _id_584994FAB4A8712B.eventtable[eventref]["score"] = float(score);
    _id_96D0BE80105FCFB1 = tablelookupbyrow("mp/potg_event_table.csv", _id_43F004CCE557F835, 2);
    _id_584994FAB4A8712B.eventtable[eventref]["addOn"] = _id_96D0BE80105FCFB1 != "";
    _id_43F004CCE557F835++;
  }
}

onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    registerpotgentity(player);
    player thread updateplayerrecording();
  }
}

updateplayerrecording() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    startrecording();
    self waittill("death");

    if(!istrue(self.fauxdead))
      self waittill("death_delay_finished");

    stoprecording();
  }
}

onplayerdisconnect(player) {
  deregisterpotgentity(player);
}

onroundended(winner) {
  if(!istrue(level.potgenabled)) {
    return;
  }
  scripts\mp\potg_events::onroundended(winner);
  waitframe();
  thread waitforrecordingandfinalize();
}

waitforrecordingandfinalize() {
  wait(getscenebufferduration() / 1000.0);
  waitframe();

  if(!shouldskippotg())
    finalizepotgsystem();
}

shouldskippotg() {
  _id_C38A3B36BA5342C7 = getcurpotgscene();

  if(isDefined(_id_C38A3B36BA5342C7) && isDefined(_id_C38A3B36BA5342C7.primaryentity))
    return _id_C38A3B36BA5342C7.score < getminimumscorerequired();
  else
    return 1;
}

finalizepotgsystem() {
  level notify("potg_finalize");
  finalizeallrecordings();
  waittillframeend;
  level.potgglobals.systemfinalized = 1;

  if(shouldskippotg()) {
    return;
  }
  if(level.potgglobals.pendingarchiverequest)
    archivecurrentgamestate();

  _id_CC46931E59A508D3 = getcurpotgscene();

  if(isDefined(_id_CC46931E59A508D3))
    finalizescene(_id_CC46931E59A508D3);
}

issystemfinalized() {
  return level.potgglobals.systemfinalized;
}

registerpotgentity(entity) {
  if(!level.potgenabled) {
    return;
  }
  _id_584994FAB4A8712B = level.potgglobals;
  id = getentityid(entity);
  _id_A7B23DAE3BCFE5F8 = spawnStruct();
  _id_A7B23DAE3BCFE5F8.entity = entity;
  _id_A7B23DAE3BCFE5F8.events = [];
  _id_A7B23DAE3BCFE5F8.recordingenabledcount = 0;
  _id_A7B23DAE3BCFE5F8.lastrecordingstarttime = -1;
  _id_A7B23DAE3BCFE5F8.nexteventid = 0;
  _id_584994FAB4A8712B.entities[id] = _id_A7B23DAE3BCFE5F8;
}

deregisterpotgentity(entity) {
  if(!level.potgenabled) {
    return;
  }
  _id_584994FAB4A8712B = level.potgglobals;
  id = getentityid(entity);
  _id_584994FAB4A8712B.entities[id] = undefined;
  entity notify("cleanup_potg_entity");
}

getentitypotgdata(entity) {
  id = getentityid(entity);
  return level.potgglobals.entities[id];
}

getentityid(entity) {
  if(isDefined(entity.potgid))
    return entity.potgid;

  entity.potgid = entity getentitynumber();
  return entity.potgid;
}

startrecording() {
  if(!level.potgenabled) {
    return;
  }
  if(issystemfinalized()) {
    return;
  }
  _id_3FF449A8EEC1B966 = getentitypotgdata(self);

  if(_id_3FF449A8EEC1B966.recordingenabledcount == 0)
    onrecordingstarted(_id_3FF449A8EEC1B966);

  _id_3FF449A8EEC1B966.recordingenabledcount++;
}

onrecordingstarted(_id_3FF449A8EEC1B966) {
  _id_3FF449A8EEC1B966.lastrecordingstarttime = gettime();
}

stoprecording() {
  if(!level.potgenabled) {
    return;
  }
  if(issystemfinalized()) {
    return;
  }
  _id_3FF449A8EEC1B966 = getentitypotgdata(self);
  _id_3FF449A8EEC1B966.recordingenabledcount--;

  if(_id_3FF449A8EEC1B966.recordingenabledcount == 0)
    onrecordingstopped(_id_3FF449A8EEC1B966);
}

forcestoprecording(_id_3FF449A8EEC1B966) {
  _id_3FF449A8EEC1B966.recordingenabledcount = 0;
  _id_3FF449A8EEC1B966.entity onrecordingstopped(_id_3FF449A8EEC1B966);
}

onrecordingstopped(_id_3FF449A8EEC1B966) {
  _id_584994FAB4A8712B = level.potgglobals;
  scripts\mp\potg_events::onpotgrecordingstopped();
  _id_3FF449A8EEC1B966.entity notify("potg_stop_recording");
  removeallevents(_id_3FF449A8EEC1B966);
}

isrecordingenabled(_id_3FF449A8EEC1B966) {
  if(!level.potgenabled)
    return 0;

  if(issystemfinalized())
    return 0;

  if(!isDefined(_id_3FF449A8EEC1B966))
    _id_3FF449A8EEC1B966 = getentitypotgdata(self);

  return _id_3FF449A8EEC1B966.recordingenabledcount > 0;
}

finalizeallrecordings() {
  _id_584994FAB4A8712B = level.potgglobals;

  foreach(_id_3FF449A8EEC1B966 in _id_584994FAB4A8712B.entities)
  forcestoprecording(_id_3FF449A8EEC1B966);
}

processevent(eventref, starttime, endtime, psoffsettime, _id_500370E4F476FAA9, _id_39AE7F14DDEE9A9A) {
  if(!level.potgenabled) {
    return;
  }
  if(!isDefined(starttime))
    starttime = gettime();

  if(!isDefined(endtime))
    endtime = starttime;

  _id_584994FAB4A8712B = level.potgglobals;
  _id_3FF449A8EEC1B966 = getentitypotgdata(self);
  removeoldevents(_id_3FF449A8EEC1B966);

  if(!isrecordingenabled(_id_3FF449A8EEC1B966)) {
    return;
  }
  _id_312642B9C7019AD5 = int(max(getcurwindowstarttime(), _id_3FF449A8EEC1B966.lastrecordingstarttime));

  if(starttime <= _id_312642B9C7019AD5 || endtime <= _id_312642B9C7019AD5) {
    return;
  }
  _id_E6EF9F6D477C0397 = spawnStruct();
  score = undefined;

  if(isDefined(_id_500370E4F476FAA9))
    score = _id_500370E4F476FAA9;
  else
    score = eventtable_getscore(eventref);

  if(isDefined(_id_39AE7F14DDEE9A9A))
    score = score * _id_39AE7F14DDEE9A9A;

  player = self;
  _id_FDE7D503EA7BBA89 = int(player.health / player.maxhealth * 127);
  _id_E6EF9F6D477C0397.eventref = eventref;
  _id_E6EF9F6D477C0397.starttime = starttime;
  _id_E6EF9F6D477C0397.endtime = endtime;
  _id_E6EF9F6D477C0397.score = score;
  _id_E6EF9F6D477C0397.psoffsettime = psoffsettime;
  _id_E6EF9F6D477C0397._id_FDE7D503EA7BBA89 = _id_FDE7D503EA7BBA89;
  eventid = _id_3FF449A8EEC1B966.nexteventid;
  _id_3FF449A8EEC1B966.nexteventid++;
  _id_3FF449A8EEC1B966.events[eventid] = _id_E6EF9F6D477C0397;
  datalog_newevent(_id_E6EF9F6D477C0397, eventid, self);

  if(!eventtable_isaddonevent(eventref))
    thread waitandnominatepotg(_id_3FF449A8EEC1B966);
}

waitandnominatepotg(_id_3FF449A8EEC1B966) {
  entity = _id_3FF449A8EEC1B966.entity;
  entity endon("disconnect");
  entity endon("cleanup_potg_entity");
  entity notify("waitAndNominatePOTG()");
  entity endon("waitAndNominatePOTG()");
  waittillframeend;

  if(!isrecordingenabled(_id_3FF449A8EEC1B966)) {
    return;
  }
  totalscore = calculatepotgscore(_id_3FF449A8EEC1B966.events);

  if(totalscore > getminimumscorerequirednvidiahighlights() && entity ispcplayer()) {}

  if(totalscore > getminimumscorerequired() && totalscore > getbestpotgscore()) {
    _id_58DEBFD84E38F50B = createscenefromnewevent(_id_3FF449A8EEC1B966, totalscore);
    entity thread waitformorerecordingtimeforscene(_id_58DEBFD84E38F50B);
  } else {}
}

removeoldevents(_id_3FF449A8EEC1B966) {
  _id_3071102F98CBED33 = getcurwindowstarttime();

  foreach(_id_ACFFD3A74A7AA812, eventdata in _id_3FF449A8EEC1B966.events) {
    if(eventdata.starttime < _id_3071102F98CBED33)
      _id_3FF449A8EEC1B966.events[_id_ACFFD3A74A7AA812] = undefined;
  }
}

removeallevents(_id_3FF449A8EEC1B966) {
  _id_3FF449A8EEC1B966.events = [];
}

createscenefromnewevent(_id_3FF449A8EEC1B966, totalscore) {
  scene = spawnStruct();
  scene.primaryentity = _id_3FF449A8EEC1B966.entity;
  scene.events = _id_3FF449A8EEC1B966.events;
  scene.score = totalscore;
  scene.sceneid = level.potgglobals.nextsceneid;
  level.potgglobals.nextsceneid++;
  scene.actionstarttime = undefined;
  scene.actionendtime = undefined;
  scene._id_FDE7D503EA7BBA89 = undefined;

  foreach(event in _id_3FF449A8EEC1B966.events) {
    if(!isDefined(scene.actionstarttime) || event.starttime < scene.actionstarttime)
      scene.actionstarttime = event.starttime;

    if(!isDefined(scene.actionendtime) || event.endtime > scene.actionendtime)
      scene.actionendtime = event.endtime;

    if(isDefined(event._id_FDE7D503EA7BBA89)) {
      if(!isDefined(scene._id_FDE7D503EA7BBA89) || scene._id_FDE7D503EA7BBA89 != event._id_FDE7D503EA7BBA89)
        scene._id_FDE7D503EA7BBA89 = event._id_FDE7D503EA7BBA89;

      continue;
    }

    scene._id_FDE7D503EA7BBA89 = 127;
  }

  scene.recordingstarttime = _id_3FF449A8EEC1B966.lastrecordingstarttime;
  scene.endtime = undefined;
  scene.playbackstarttime = undefined;
  scene.playbackendtime = undefined;
  return scene;
}

doesscenehaveenoughtotalrecordingtime(scene) {
  return getmaxsceneduration(scene) >= getwholescenedurationmin();
}

doesscenehaveenoughbufferrecordingtime(scene) {
  return scene.endtime - scene.actionendtime >= getscenebufferduration();
}

getmaxsceneduration(scene) {
  starttime = scene.recordingstarttime;
  return scene.endtime - scene.recordingstarttime;
}

waitformorerecordingtimeforscene(scene) {
  self endon("disconnect");
  self endon("cleanup_potg_entity");
  _id_5741558440486AA4 = scene.recordingstarttime + getwholescenedurationmin();
  _id_D6AAE35763CAD502 = scene.actionendtime + getscenebufferduration();
  latestendtime = scene.actionstarttime + getwholescenedurationmax();
  endtime = int(clamp(_id_D6AAE35763CAD502, _id_5741558440486AA4, latestendtime));
  result = "no_wait";

  if(endtime > gettime()) {
    thread watchpendingscenetimeout(endtime);
    result = scripts\engine\utility::waittill_any_return_no_endon_death_2("potg_pending_scene_timeout", "potg_stop_recording");
    self notify("potg_scene_finished_pending");
  }

  if(gettime() > endtime)
    scene.endtime = endtime;
  else
    scene.endtime = gettime();

  if(doesscenehaveenoughtotalrecordingtime(scene)) {
    if(doesscenehaveenoughbufferrecordingtime(scene)) {
      if(scene.score > getminimumscorerequired() && scene.score >= getbestpotgscore())
        setcurpotgscene(scene);
      else {}
    } else {}
  } else {}
}

watchpendingscenetimeout(endtime) {
  self endon("potg_scene_finished_pending");

  while(gettime() < endtime)
    waitframe();

  self notify("potg_pending_scene_timeout");
}

calculatepotgscore(events) {
  killcount = 0;
  _id_4862098EE5021DB9 = 0;

  foreach(eventdata in events) {
    _id_4862098EE5021DB9 = _id_4862098EE5021DB9 + eventdata.score;

    if(eventdata.eventref == "kill")
      killcount++;
  }

  if(killcount > 2) {
    score = eventtable_getscore("triple_kill");
    _id_4862098EE5021DB9 = _id_4862098EE5021DB9 + score;
  }

  return _id_4862098EE5021DB9;
}

setcurpotgscene(scene) {
  calcsceneplaybacktimes(scene);
  requestarchive(scene.playbackstarttime, scene.playbackendtime);
  screenprint_newpotgchosen(scene, level.potgglobals.curpotgscene);
  level.potgglobals.curpotgscene = scene;
}

getcurpotgscene() {
  if(!level.potgenabled)
    return undefined;

  return level.potgglobals.curpotgscene;
}

getbestpotgscore() {
  if(!level.potgenabled)
    return -1;

  _id_584994FAB4A8712B = level.potgglobals;

  if(!isDefined(_id_584994FAB4A8712B.curpotgscene))
    return -1;

  return _id_584994FAB4A8712B.curpotgscene.score;
}

getcurwindowstarttime() {
  return gettime() - getwholescenedurationmax();
}

eventtable_getscore(eventref) {
  return level.potgglobals.eventtable[eventref]["score"];
}

eventtable_isaddonevent(eventref) {
  return level.potgglobals.eventtable[eventref]["addOn"];
}

eventtable_isevent(eventref) {
  return isDefined(level.potgglobals.eventtable[eventref]);
}

finalizescene(scene) {
  scene.finalized = 1;
  calcscenepsoffset(scene);
  resetscorefeedcontrolomnvar();
  datalog_scenefinalized(scene);
}

resetscorefeedcontrolomnvar() {
  foreach(player in level.players) {
    player setclientomnvar("ui_potg_score_event_control", -1);
    player setclientomnvar("ui_score_event_list_0", -1);
    player setclientomnvar("ui_score_event_list_1", -1);
    player setclientomnvar("ui_score_event_list_2", -1);
    player setclientomnvar("ui_score_event_list_3", -1);
    player setclientomnvar("ui_score_event_list_4", -1);
  }
}

calcsceneplaybacktimes(scene) {
  _id_6294534A03B3D4A7 = gettime() - 13000;
  _id_27DC7D2C5DEDE987 = scene.endtime - getwholescenedurationmax();
  _id_EB9FB8A764AE917D = int(max(_id_27DC7D2C5DEDE987, max(scene.recordingstarttime, _id_6294534A03B3D4A7)));
  _id_C3ECCD2658B3FD57 = scene.actionstarttime - getscenebufferduration();
  _id_10DBAE4AFE99066B = int(min(scene.actionstarttime, scene.endtime - getwholescenedurationmin()));
  scene.playbackstarttime = int(clamp(_id_C3ECCD2658B3FD57, _id_EB9FB8A764AE917D, _id_10DBAE4AFE99066B));
  scene.playbackendtime = scene.endtime;
  _id_884DB59E2243E42C = scene.playbackendtime - scene.playbackstarttime;
}

calcscenepsoffset(scene) {
  _id_6A45D2E4A65780CB = [];

  foreach(event in scene.events) {
    if(isDefined(event.psoffsettime) && !isDefined(_id_6A45D2E4A65780CB[event.endtime]))
      _id_6A45D2E4A65780CB[event.endtime] = event.psoffsettime;
  }

  if(_id_6A45D2E4A65780CB.size <= 0) {
    scene.psoffsettime = 0;
    return;
  }

  _id_9AE310BE2354D6C3 = 0.0;

  foreach(time in _id_6A45D2E4A65780CB)
  _id_9AE310BE2354D6C3 = _id_9AE310BE2354D6C3 + time;

  _id_AD8E46EC031EF58D = _id_9AE310BE2354D6C3 / _id_6A45D2E4A65780CB.size;
  scene.psoffsettime = int(_id_AD8E46EC031EF58D);
}

getfinalpotginfo() {
  _id_CC46931E59A508D3 = getcurpotgscene();

  if(!isDefined(_id_CC46931E59A508D3))
    return undefined;

  info = spawnStruct();
  info.starttime = _id_CC46931E59A508D3.playbackstarttime;
  info.endtime = _id_CC46931E59A508D3.playbackendtime;
  info.spectateentity = _id_CC46931E59A508D3.primaryentity;
  info.psoffsettime = _id_CC46931E59A508D3.psoffsettime;
  return info;
}

requestarchive(starttime, endtime) {
  level thread archiverequesthelper(starttime, endtime);
}

archiverequesthelper(starttime, endtime) {
  level endon("potg_finalize");
  level notify("potg_archiveRequestHelper()");
  level endon("potg_archiveRequestHelper()");
  level.potgglobals.pendingarchiverequest = 1;
  _id_A127B5A0B26A9B01 = starttime + 13000 - 100;
  _id_436681FB9914BB6A = _id_A127B5A0B26A9B01 - gettime();
  scripts\engine\utility::wait_time_in_ms(_id_436681FB9914BB6A);
  level.potgglobals.pendingarchiverequest = 0;
  archivecurrentgamestate();
}

archivecurrentgamestate() {
  thread debug_watcharchivesize(getpotgstarttime(), getcurpotgscene());
  savepotgdata();
  _id_B19688B8C0890315 = level.potgglobals.lastarchivetime;
  level.potgglobals.lastarchivetime = gettime();
  _id_70CC693025693D44 = -1;

  if(_id_B19688B8C0890315 > 0)
    _id_70CC693025693D44 = level.potgglobals.lastarchivetime - _id_B19688B8C0890315;
}

getrapidarchivewarningrate() {
  return 13000 - getwholescenedurationmax() - 250;
}

doesscenefitincurrentarchive(scene) {
  _id_55BA69B15E012577 = level.potgglobals.lastarchivetime;

  if(_id_55BA69B15E012577 < 0)
    return 0;

  _id_D56B3D1F692CFA32 = _id_55BA69B15E012577 - 13000;
  return scene.playbackstarttime >= _id_D56B3D1F692CFA32 && scene.playbackendtime <= _id_55BA69B15E012577;
}

screenprint_newpotgchosen(_id_58DEBFD84E38F50B, _id_BA4B27EDC7C3A602) {
  if(getdvarint("dvar_BA2D7C5976A9EC58") == 0) {
    return;
  }
  if(_id_58DEBFD84E38F50B.score <= 250) {
    return;
  }
  _id_FAB9CA08AD8FE199 = undefined;

  if(isPlayer(_id_58DEBFD84E38F50B.primaryentity))
    _id_FAB9CA08AD8FE199 = _id_58DEBFD84E38F50B.primaryentity.name;
  else
    _id_FAB9CA08AD8FE199 = "(GameObject)";

  if(isPlayer(_id_58DEBFD84E38F50B.primaryentity))
    _id_58DEBFD84E38F50B.primaryentity iprintlnbold("POTG Nominee! (" + _id_58DEBFD84E38F50B.score + ")");

  if(isDefined(_id_BA4B27EDC7C3A602) && isPlayer(_id_BA4B27EDC7C3A602.primaryentity) && _id_BA4B27EDC7C3A602.primaryentity != _id_58DEBFD84E38F50B.primaryentity)
    _id_BA4B27EDC7C3A602.primaryentity iprintlnbold("Your POTG was bested by +" + _id_FAB9CA08AD8FE199 + "! (" + _id_58DEBFD84E38F50B.score + ")");

  level.potgglobals.lastchosenscreenprinttime = gettime();
}

screenprint_dosceneprintplayback() {
  if(getdvarint("dvar_BA2D7C5976A9EC58") == 0) {
    return;
  }
  scene = getcurpotgscene();
  _id_BC01593C93E86B53 = gettime() - int(self.archivetime * 1000);
  _id_038FC7BD1495C4B2 = 0.15;
  _id_E9EB390A12336FC1 = [];

  for(;;) {
    foreach(eventid, event in scene.events) {
      if(event.starttime <= _id_BC01593C93E86B53 && !isDefined(_id_E9EB390A12336FC1[eventid])) {
        iprintlnbold(event.eventref);
        iprintln(event.eventref);
        _id_E9EB390A12336FC1[eventid] = 1;
        break;
      }
    }

    wait(_id_038FC7BD1495C4B2);
    _id_BC01593C93E86B53 = _id_BC01593C93E86B53 + int(_id_038FC7BD1495C4B2 * 1000);
  }
}

datalog_getlogversion() {
  if(getdvarint("dvar_6AF7E4425B1F5D10", 0) != 0)
    return -1;

  if(getdvarint("scr_playtest", 0) != 0)
    return 9;

  return -1;
}

datalog_isloggingenabled() {
  return getdvarint("dvar_1FD181EBEEBE83BF") != 0;
}

datalog_scenefinalized(scene) {
  if(!datalog_isloggingenabled()) {
    return;
  }
  _id_CE11EFACB4914AC2 = datalog_getlogversion();
  dlog_recordevent("mpscript_potg", ["score", scene.score, "duration", scene.playbackendtime - scene.playbackstarttime, "start_time", scene.playbackstarttime, "action_start_offset", scene.actionstarttime - scene.playbackstarttime, "action_end_offset", scene.actionendtime - scene.playbackstarttime, "entity_id", getentityid(scene.primaryentity), "script_version", _id_CE11EFACB4914AC2]);

  foreach(event in scene.events)
  dlog_recordevent("mpscript_potg_final_events", ["event_ref", event.eventref, "score", event.score, "start_time", event.playbackstarttime, "end_time", event.playbackendtime, "script_version", _id_CE11EFACB4914AC2]);
}

datalog_newevent(event, id, entity) {
  if(!datalog_isloggingenabled()) {
    return;
  }
  dlog_recordevent("mpscript_potg_events", ["event_ref", event.eventref, "score", event.score, "start_time", event.starttime, "end_time", event.endtime, "event_id", id, "entity_id", getentityid(entity), "script_version", datalog_getlogversion()]);
}

datalog_archivesaved(requesttime, _id_D56B3D1F692CFA32, _id_81D494531FB297B9, _id_7BEBD353A1E5C76C, _id_527E5CECB087E655) {
  if(getdvarint("potg_debug_archive", 0) == 0) {
    return;
  }
  _id_5159F960A67ED33B = datalog_getlogversion();
  dlog_recordevent("mpscript_potg_archive", ["requestTime", requesttime, "archiveStartTime", _id_D56B3D1F692CFA32, "archiveDuration", _id_81D494531FB297B9, "desiredSceneStartTime", _id_7BEBD353A1E5C76C, "desiredSceneEndTime", _id_527E5CECB087E655, "playerCount", level.players.size, "tickRate", int(1.0 / level.framedurationseconds), "dedi", scripts\engine\utility::ter_op(isdedicatedserver(), 1, 0), "version", 0]);
}

debug_watcharchivesize(_id_1EF6DE18F8155949, scene) {
  requesttime = gettime();
  thread debug_watcharchivefinished(requesttime, _id_1EF6DE18F8155949, scene);
  thread debug_watcharchiveinterrupted(requesttime, scene);
}

debug_watcharchivefinished(requesttime, _id_1EF6DE18F8155949, scene) {
  level notify("watching_potg_archive_request");
  level endon("watching_potg_archive_request");

  if(getdvarint("potg_debug_archive") == 0) {
    return;
  }
  for(;;) {
    _id_D944740CB0DC50DA = getpotgstarttime();

    if(_id_D944740CB0DC50DA != _id_1EF6DE18F8155949) {
      level notify("potg_archive_request_finished");
      debug_logarchiveresult(1, scene, requesttime, _id_D944740CB0DC50DA, getpotgduration());
      break;
    }

    waitframe();
  }
}

debug_watcharchiveinterrupted(requesttime, scene) {
  level endon("potg_archive_request_finished");
  level waittill("watching_potg_archive_request");
  debug_logarchiveresult(0, scene, requesttime);
}

debug_logarchiveresult(result, scene, requesttime, _id_CEAAE222A63F4928, _id_F94BF66AFA95E4B7) {
  if(result)
    thread datalog_archivesaved(requesttime, _id_CEAAE222A63F4928, _id_F94BF66AFA95E4B7, scene.playbackstarttime, scene.playbackendtime);

  if(result)
    return;
}