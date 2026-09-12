/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\potg.gsc
***********************************************/

function init() {
  if(scripts\mp\utility\game::getgametype() == "br" || istrue(game["isLaunchChunk"])) {
    level.potgenabled = 0;
    return;
  }

  if(!isDefined(level.potgenabled) || level.potgenabled) {
    level.potgenabled = level.finalkillcamtype == 1;
  }

  if(!level.potgenabled) {
    return;
  }

  var_0 = spawnStruct();
  level.potgglobals = var_0;
  var_0.curpotgscene = undefined;
  var_0.systemfinalized = 0;
  var_0.entities = [];
  var_0.settings = [];
  var_0.settingtypes = [];
  var_0.nextsceneid = 0;
  var_0.lastarchivetime = -1;
  var_0.pendingarchiverequest = 0;
  loadeventtable();
  setdvarifuninitialized("potg_action_duration_max", 8000);
  setdvarifuninitialized("potg_action_duration_min", 3000);
  setdvarifuninitialized("potg_buffer_duration", 1000);
  setdvarifuninitialized("potg_debug_archive", 1000);
  setdvarifuninitialized("potg_min_scene_score", 420);
  thread onplayerconnect();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  scripts\mp\potg_events::init();
}

function getminimumscorerequired() {
  return getdvarint("potg_min_scene_score");
}

function getactionscenedurationmax() {
  return getdvarint("potg_action_duration_max");
}

function getactionscenedurationmin() {
  return getdvarint("potg_action_duration_min");
}

function getscenebufferduration() {
  return getdvarint("potg_buffer_duration");
}

function getwholescenedurationmin() {
  return getactionscenedurationmin() + getscenebufferduration() * 2;
}

function getwholescenedurationmax() {
  return getactionscenedurationmax() + getscenebufferduration() * 2;
}

function getminimumscorerequirednvidiahighlights() {
  return getdvarint("potg_min_nVidia_highlights_score");
}

function loadeventtable() {
  var_0 = level.potgglobals;

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow("mp/potg_event_table.csv", var_1, 0);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_0.eventtable[var_2] = [];
    var_3 = tablelookupbyrow("mp/potg_event_table.csv", var_1, 1);
    var_0.eventtable[var_2]["score"] = float(var_3);
    var_4 = tablelookupbyrow("mp/potg_event_table.csv", var_1, 2);
    var_0.eventtable[var_2]["addOn"] = var_4 != "";
  }
}

function onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    registerpotgentity(var_0);
    thread updateplayerrecording();
  }
}

function updateplayerrecording() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    startrecording();
    self waittill("death");

    if(!istrue(self.fauxdead)) {
      self waittill("death_delay_finished");
    }

    stoprecording();
  }
}

function onplayerdisconnect(var_0) {
  deregisterpotgentity(var_0);
}

function onroundended(var_0) {
  if(!istrue(level.potgenabled)) {
    return;
  }

  scripts\mp\potg_events::onroundended(var_0);
  waitframe();
  thread waitforrecordingandfinalize();
}

function waitforrecordingandfinalize() {
  wait getscenebufferduration() / 1000;
  waitframe();

  if(!shouldskippotg()) {
    finalizepotgsystem();
    return;
  }
}

function shouldskippotg() {
  var_0 = getcurpotgscene();

  if(isDefined(var_0) && isDefined(var_0.primaryentity)) {
    return (var_0.score < getminimumscorerequired());
  }

  return 1;
}

function finalizepotgsystem() {
  level notify("potg_finalize");
  finalizeallrecordings();
  waittillframeend();
  level.potgglobals.systemfinalized = 1;

  if(shouldskippotg()) {
    return;
  }

  if(level.potgglobals.pendingarchiverequest) {
    archivecurrentgamestate();
  }

  var_0 = getcurpotgscene();

  if(isDefined(var_0)) {
    finalizescene(var_0);
    return;
  }
}

function issystemfinalized() {
  return level.potgglobals.systemfinalized;
}

function registerpotgentity(var_0) {
  if(!level.potgenabled) {
    return;
  }

  var_1 = level.potgglobals;
  var_2 = getentityid(var_0);
  var_3 = spawnStruct();
  var_3.entity = var_0;
  var_3.events = [];
  var_3.recordingenabledcount = 0;
  var_3.lastrecordingstarttime = -1;
  var_3.nexteventid = 0;
  var_1.entities[var_2] = var_3;
}

function deregisterpotgentity(var_0) {
  if(!level.potgenabled) {
    return;
  }

  var_1 = level.potgglobals;
  var_2 = getentityid(var_0);
  var_1.entities[var_2] = undefined;
  var_0 notify("cleanup_potg_entity");
}

function getentitypotgdata(var_0) {
  var_1 = getentityid(var_0);
  return level.potgglobals.entities[var_1];
}

function getentityid(var_0) {
  if(isDefined(var_0.potgid)) {
    return var_0.potgid;
  }

  var_0.potgid = var_0 getentitynumber();
  return var_0.potgid;
}

function startrecording() {
  if(!level.potgenabled) {
    return;
  }

  if(issystemfinalized()) {
    return;
  }

  var_0 = getentitypotgdata(self);

  if(var_0.recordingenabledcount == 0) {
    onrecordingstarted(var_0);
  }

  var_0.recordingenabledcount++;
}

function onrecordingstarted(var_0) {
  var_0.lastrecordingstarttime = gettime();
}

function stoprecording() {
  if(!level.potgenabled) {
    return;
  }

  if(issystemfinalized()) {
    return;
  }

  var_0 = getentitypotgdata(self);
  var_0.recordingenabledcount--;

  if(var_0.recordingenabledcount == 0) {
    onrecordingstopped(var_0);
    return;
  }
}

function forcestoprecording(var_0) {
  var_0.recordingenabledcount = 0;
  onrecordingstopped(var_0.entity, var_0);
}

function onrecordingstopped(var_0) {
  var_1 = level.potgglobals;
  scripts\mp\potg_events::onpotgrecordingstopped();
  var_0.entity notify("potg_stop_recording");
  removeallevents(var_0);
}

function isrecordingenabled(var_0) {
  if(!level.potgenabled) {
    return false;
  }

  if(issystemfinalized()) {
    return false;
  }

  if(!isDefined(var_0)) {
    var_0 = getentitypotgdata(self);
  }

  return var_0.recordingenabledcount > 0;
}

function finalizeallrecordings() {
  var_0 = level.potgglobals;

  foreach(var_2 in var_0.entities) {
    forcestoprecording(var_2);
  }
}

function processevent(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!level.potgenabled) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = gettime();
  }

  if(!isDefined(var_2)) {
    var_2 = var_1;
  }

  var_6 = level.potgglobals;
  var_7 = getentitypotgdata(self);
  removeoldevents(var_7);

  if(!isrecordingenabled(var_7)) {
    return;
  }

  var_8 = int(max(getcurwindowstarttime(), var_7.lastrecordingstarttime));

  if(var_1 <= var_8 || var_2 <= var_8) {
    return;
  }

  var_9 = spawnStruct();
  var_10 = undefined;

  if(isDefined(var_4)) {
    var_10 = var_4;
  } else {
    var_10 = eventtable_getscore(var_0);
  }

  if(isDefined(var_5)) {
    var_10 *= var_5;
  }

  var_9.eventref = var_0;
  var_9.starttime = var_1;
  var_9.endtime = var_2;
  var_9.score = var_10;
  var_9.psoffsettime = var_3;
  var_11 = var_7.nexteventid;
  var_7.nexteventid++;
  var_7.events[var_11] = var_9;
  datalog_newevent(var_9, var_11, self);

  if(!eventtable_isaddonevent(var_0)) {
    thread waitandnominatepotg(var_7);
  }
}

function waitandnominatepotg(var_0) {
  var_1 = var_0.entity;
  var_1 endon("disconnect");
  var_1 endon("cleanup_potg_entity");
  var_1 notify("waitAndNominatePOTG()");
  var_1 endon("waitAndNominatePOTG()");
  waittillframeend();

  if(!isrecordingenabled(var_0)) {
    return;
  }

  var_2 = calculatepotgscore(var_0.events);

  if(var_2 > getminimumscorerequirednvidiahighlights() && var_1 ispcplayer()) {}

  if(var_2 > getminimumscorerequired() && var_2 > getbestpotgscore()) {
    var_3 = createscenefromnewevent(var_0, var_2);
    thread waitformorerecordingtimeforscene(var_1);
  }
}

function removeoldevents(var_0) {
  var_1 = getcurwindowstarttime();

  foreach(var_3 in var_0.events) {
    if(var_3.starttime < var_1) {
      var_0.events[var_4] = undefined;
    }
  }
}

function removeallevents(var_0) {
  var_0.events = [];
}

function createscenefromnewevent(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.primaryentity = var_0.entity;
  var_2.events = var_0.events;
  var_2.score = var_1;
  var_2.sceneid = level.potgglobals.nextsceneid;
  level.potgglobals.nextsceneid++;
  var_2.actionstarttime = undefined;
  var_2.actionendtime = undefined;

  foreach(var_4 in var_0.events) {
    if(!isDefined(var_2.actionstarttime) || var_4.starttime < var_2.actionstarttime) {
      var_2.actionstarttime = var_4.starttime;
    }

    if(!isDefined(var_2.actionendtime) || var_4.endtime > var_2.actionendtime) {
      var_2.actionendtime = var_4.endtime;
    }
  }

  var_2.recordingstarttime = var_0.lastrecordingstarttime;
  var_2.endtime = undefined;
  var_2.playbackstarttime = undefined;
  var_2.playbackendtime = undefined;
  return var_2;
}

function doesscenehaveenoughtotalrecordingtime(var_0) {
  return getmaxsceneduration(var_0) >= getwholescenedurationmin();
}

function doesscenehaveenoughbufferrecordingtime(var_0) {
  return var_0.endtime - var_0.actionendtime >= getscenebufferduration();
}

function getmaxsceneduration(var_0) {
  var_1 = var_0.recordingstarttime;
  return var_0.endtime - var_0.recordingstarttime;
}

function waitformorerecordingtimeforscene(var_0) {
  self endon("disconnect");
  self endon("cleanup_potg_entity");
  var_1 = var_0.recordingstarttime + getwholescenedurationmin();
  var_2 = var_0.actionendtime + getscenebufferduration();
  var_3 = var_0.actionstarttime + getwholescenedurationmax();
  var_4 = int(clamp(var_2, var_1, var_3));
  var_5 = "no_wait";

  if(var_4 > gettime()) {
    thread watchpendingscenetimeout(var_4);
    var_5 = scripts\engine\utility::ref_143B4("potg_pending_scene_timeout", "potg_stop_recording");
    self notify("potg_scene_finished_pending");
  }

  if(gettime() > var_4) {
    var_0.endtime = var_4;
  } else {
    var_0.endtime = gettime();
  }

  if(doesscenehaveenoughtotalrecordingtime(var_0)) {
    if(doesscenehaveenoughbufferrecordingtime(var_0)) {
      if(var_0.score > getminimumscorerequired() && var_0.score >= getbestpotgscore()) {
        setcurpotgscene(var_0);
        return;
      }

      return;
    }

    return;
  }
}

function watchpendingscenetimeout(var_0) {
  self endon("potg_scene_finished_pending");

  while(gettime() < var_0) {
    waitframe();
  }

  self notify("potg_pending_scene_timeout");
}

function calculatepotgscore(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_2 += var_4.score;

    if(var_4.eventref == "kill") {
      var_1++;
    }
  }

  if(var_1 > 2) {
    var_6 = eventtable_getscore("triple_kill");
    var_2 += var_6;
  }

  return var_2;
}

function setcurpotgscene(var_0) {
  calcsceneplaybacktimes(var_0);
  requestarchive(var_0.playbackstarttime, var_0.playbackendtime);
  screenprint_newpotgchosen(var_0, level.potgglobals.curpotgscene);
  level.potgglobals.curpotgscene = var_0;
}

function getcurpotgscene() {
  if(!level.potgenabled) {
    return undefined;
  }

  return level.potgglobals.curpotgscene;
}

function getbestpotgscore() {
  if(!level.potgenabled) {
    return -1;
  }

  var_0 = level.potgglobals;

  if(!isDefined(var_0.curpotgscene)) {
    return -1;
  }

  return var_0.curpotgscene.score;
}

function getcurwindowstarttime() {
  return gettime() - getwholescenedurationmax();
}

function eventtable_getscore(var_0) {
  return level.potgglobals.eventtable[var_0]["score"];
}

function eventtable_isaddonevent(var_0) {
  return level.potgglobals.eventtable[var_0]["addOn"];
}

function eventtable_isevent(var_0) {
  return isDefined(level.potgglobals.eventtable[var_0]);
}

function finalizescene(var_0) {
  var_0.finalized = 1;
  calcscenepsoffset(var_0);
  ref_12C7C();
  datalog_scenefinalized(var_0);
}

function ref_12C7C() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_potg_score_event_control", -1);
    var_1 setclientomnvar("ui_score_event_list_0", -1);
    var_1 setclientomnvar("ui_score_event_list_1", -1);
    var_1 setclientomnvar("ui_score_event_list_2", -1);
    var_1 setclientomnvar("ui_score_event_list_3", -1);
    var_1 setclientomnvar("ui_score_event_list_4", -1);
  }
}

function calcsceneplaybacktimes(var_0) {
  var_1 = gettime() - 13000;
  var_2 = var_0.endtime - getwholescenedurationmax();
  var_3 = int(max(var_2, max(var_0.recordingstarttime, var_1)));
  var_4 = var_0.actionstarttime - getscenebufferduration();
  var_5 = int(min(var_0.actionstarttime, var_0.endtime - getwholescenedurationmin()));
  var_0.playbackstarttime = int(clamp(var_4, var_3, var_5));
  var_0.playbackendtime = var_0.endtime;
  var_6 = var_0.playbackendtime - var_0.playbackstarttime;
}

function calcscenepsoffset(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.events) {
    if(isDefined(var_3.psoffsettime) && !isDefined(var_1[var_3.endtime])) {
      var_1 = var_3.psoffsettime;
    }
  }

  if(var_1.size <= 0) {
    var_0.psoffsettime = 0;
    return;
  }

  var_5 = 0;

  foreach(var_7 in var_1) {
    var_5 += var_7;
  }

  var_9 = var_5 / var_1.size;
  var_0.psoffsettime = int(var_9);
}

function getfinalpotginfo() {
  var_0 = getcurpotgscene();

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = spawnStruct();
  var_1.starttime = var_0.playbackstarttime;
  var_1.endtime = var_0.playbackendtime;
  var_1.spectateentity = var_0.primaryentity;
  var_1.psoffsettime = var_0.psoffsettime;
  return var_1;
}

function requestarchive(var_0, var_1) {
  thread archiverequesthelper(level, var_0);
}

function archiverequesthelper(var_0, var_1) {
  level endon("potg_finalize");
  level notify("potg_archiveRequestHelper()");
  level endon("potg_archiveRequestHelper()");
  level.potgglobals.pendingarchiverequest = 1;
  var_2 = var_0 + 13000 - 100;
  var_3 = var_2 - gettime();
  scripts\engine\utility::wait_time_in_ms(var_3);
  level.potgglobals.pendingarchiverequest = 0;
  archivecurrentgamestate();
}

function archivecurrentgamestate() {
  thread debug_watcharchivesize(getpotgduration(), getcurpotgscene());
  getpotgstarttime();
  var_0 = level.potgglobals.lastarchivetime;
  level.potgglobals.lastarchivetime = gettime();
  var_1 = -1;

  if(var_0 > 0) {
    var_1 = level.potgglobals.lastarchivetime - var_0;
    return;
  }
}

function getrapidarchivewarningrate() {
  return 13000 - getwholescenedurationmax() - 250;
}

function doesscenefitincurrentarchive(var_0) {
  var_1 = level.potgglobals.lastarchivetime;

  if(var_1 < 0) {
    return false;
  }

  var_2 = var_1 - 13000;
  return var_0.playbackstarttime >= var_2 && var_0.playbackendtime <= var_1;
}

function screenprint_newpotgchosen(var_0, var_1) {
  if(getdvarint("potg_screen_prints") == 0) {
    return;
  }

  if(var_0.score <= 250) {
    return;
  }

  var_2 = undefined;

  if(isPlayer(var_0.primaryentity)) {
    var_2 = var_0.primaryentity.name;
  } else {
    var_2 = "(GameObject)";
  }

  if(isPlayer(var_0.primaryentity)) {
    var_0.primaryentity iprintlnbold("POTG Nominee! (" + var_0.score + ")");
  }

  if(isDefined(var_1) && isPlayer(var_1.primaryentity) && var_1.primaryentity != var_0.primaryentity) {
    var_1.primaryentity iprintlnbold("Your POTG was bested by +" + var_2 + "! (" + var_0.score + ")");
  }

  level.potgglobals.lastchosenscreenprinttime = gettime();
}

function screenprint_dosceneprintplayback() {
  if(getdvarint("potg_screen_prints") == 0) {
    return;
  }

  var_0 = getcurpotgscene();
  var_1 = gettime() - int(self.archivetime * 1000);
  var_2 = 0.15;
  var_3 = [];

  for(;;) {
    foreach(var_6, var_5 in var_0.events) {
      if(var_5.starttime <= var_1 && !isDefined(var_3[var_6])) {
        iprintlnbold(var_5.eventref);
        iprintln(var_5.eventref);
        var_3 = 1;
        break;
      }
    }

    wait var_2;
    var_1 += int(var_2 * 1000);
  }
}

function datalog_getlogversion() {
  if(getdvarint("scr_playtest_qa", 0) != 0) {
    return -1;
  }

  if(getdvarint("scr_playtest", 0) != 0) {
    return 9;
  }

  return -1;
}

function datalog_isloggingenabled() {
  return getdvarint("potg_datalog") != 0;
}

function datalog_scenefinalized(var_0) {
  if(!datalog_isloggingenabled()) {
    return;
  }

  var_1 = datalog_getlogversion();
  getentitylessscriptablearray("mpscript_potg", ["score", var_0.score, "duration", var_0.playbackendtime - var_0.playbackstarttime, "start_time", var_0.playbackstarttime, "action_start_offset", var_0.actionstarttime - var_0.playbackstarttime, "action_end_offset", var_0.actionendtime - var_0.playbackstarttime, "entity_id", getentityid(var_0.primaryentity), "script_version", var_1]);

  foreach(var_3 in var_0.events) {
    getentitylessscriptablearray("mpscript_potg_final_events", ["event_ref", var_3.eventref, "score", var_3.score, "start_time", var_3.playbackstarttime, "end_time", var_3.playbackendtime, "script_version", var_1]);
  }
}

function datalog_newevent(var_0, var_1, var_2) {
  if(!datalog_isloggingenabled()) {
    return;
  }

  getentitylessscriptablearray("mpscript_potg_events", ["event_ref", var_0.eventref, "score", var_0.score, "start_time", var_0.starttime, "end_time", var_0.endtime, "event_id", var_1, "entity_id", getentityid(var_2), "script_version", datalog_getlogversion()]);
}

function datalog_archivesaved(var_0, var_1, var_2, var_3, var_4) {
  if(getdvarint("potg_debug_archive", 0) == 0) {
    return;
  }

  var_5 = datalog_getlogversion();
  getentitylessscriptablearray("mpscript_potg_archive", ["requestTime", var_0, "archiveStartTime", var_1, "archiveDuration", var_2, "desiredSceneStartTime", var_3, "desiredSceneEndTime", var_4, "playerCount", level.players.size, "tickRate", int(1 / level.framedurationseconds), "dedi", scripts\engine\utility::ter_op(isdedicatedserver(), 1, 0), "version", 0]);
}

function debug_watcharchivesize(var_0, var_1) {
  var_2 = gettime();
  thread debug_watcharchivefinished(var_2, var_0, var_1);
  thread debug_watcharchiveinterrupted(var_2, var_1);
}

function debug_watcharchivefinished(var_0, var_1, var_2) {
  level notify("watching_potg_archive_request");
  level endon("watching_potg_archive_request");
  jumpiffalse(getdvarint("potg_debug_archive") == 0) LOC_00000022;
  return;
}

function debug_watcharchiveinterrupted(var_0, var_1) {
  level endon("potg_archive_request_finished");
  level waittill("watching_potg_archive_request");
  debug_logarchiveresult(0, var_1, var_0);
}

function debug_logarchiveresult(var_0, var_1, var_2, var_3, var_4) {
  if(var_0) {
    thread datalog_archivesaved(var_2, var_3, var_4, var_1.playbackstarttime, var_1.playbackendtime);
  }

  if(var_0) {
    return;
  }
}