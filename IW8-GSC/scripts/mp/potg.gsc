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

  var0 = spawnStruct();
  level.potgglobals = var0;
  var0.curpotgscene = undefined;
  var0.systemfinalized = 0;
  var0.entities = [];
  var0.settings = [];
  var0.settingtypes = [];
  var0.nextsceneid = 0;
  var0.lastarchivetime = -1;
  var0.pendingarchiverequest = 0;
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
  var0 = level.potgglobals;

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow("mp/potg_event_table.csv", var1, 0);

    if(!isDefined(var2) || var2 == "") {
      break;
    }

    var0.eventtable[var2] = [];
    var3 = tablelookupbyrow("mp/potg_event_table.csv", var1, 1);
    var0.eventtable[var2]["score"] = float(var3);
    var4 = tablelookupbyrow("mp/potg_event_table.csv", var1, 2);
    var0.eventtable[var2]["addOn"] = var4 != "";
  }
}

function onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var0);
    registerpotgentity(var0);
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

function onplayerdisconnect(var0) {
  deregisterpotgentity(var0);
}

function onroundended(var0) {
  if(!istrue(level.potgenabled)) {
    return;
  }

  scripts\mp\potg_events::onroundended(var0);
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
  var0 = getcurpotgscene();

  if(isDefined(var0) && isDefined(var0.primaryentity)) {
    return (var0.score < getminimumscorerequired());
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

  var0 = getcurpotgscene();

  if(isDefined(var0)) {
    finalizescene(var0);
    return;
  }
}

function issystemfinalized() {
  return level.potgglobals.systemfinalized;
}

function registerpotgentity(var0) {
  if(!level.potgenabled) {
    return;
  }

  var1 = level.potgglobals;
  var2 = getentityid(var0);
  var3 = spawnStruct();
  var3.entity = var0;
  var3.events = [];
  var3.recordingenabledcount = 0;
  var3.lastrecordingstarttime = -1;
  var3.nexteventid = 0;
  var1.entities[var2] = var3;
}

function deregisterpotgentity(var0) {
  if(!level.potgenabled) {
    return;
  }

  var1 = level.potgglobals;
  var2 = getentityid(var0);
  var1.entities[var2] = undefined;
  var0 notify("cleanup_potg_entity");
}

function getentitypotgdata(var0) {
  var1 = getentityid(var0);
  return level.potgglobals.entities[var1];
}

function getentityid(var0) {
  if(isDefined(var0.potgid)) {
    return var0.potgid;
  }

  var0.potgid = var0 getentitynumber();
  return var0.potgid;
}

function startrecording() {
  if(!level.potgenabled) {
    return;
  }

  if(issystemfinalized()) {
    return;
  }

  var0 = getentitypotgdata(self);

  if(var0.recordingenabledcount == 0) {
    onrecordingstarted(var0);
  }

  var0.recordingenabledcount++;
}

function onrecordingstarted(var0) {
  var0.lastrecordingstarttime = gettime();
}

function stoprecording() {
  if(!level.potgenabled) {
    return;
  }

  if(issystemfinalized()) {
    return;
  }

  var0 = getentitypotgdata(self);
  var0.recordingenabledcount--;

  if(var0.recordingenabledcount == 0) {
    onrecordingstopped(var0);
    return;
  }
}

function forcestoprecording(var0) {
  var0.recordingenabledcount = 0;
  onrecordingstopped(var0.entity, var0);
}

function onrecordingstopped(var0) {
  var1 = level.potgglobals;
  scripts\mp\potg_events::onpotgrecordingstopped();
  var0.entity notify("potg_stop_recording");
  removeallevents(var0);
}

function isrecordingenabled(var0) {
  if(!level.potgenabled) {
    return false;
  }

  if(issystemfinalized()) {
    return false;
  }

  if(!isDefined(var0)) {
    var0 = getentitypotgdata(self);
  }

  return var0.recordingenabledcount > 0;
}

function finalizeallrecordings() {
  var0 = level.potgglobals;

  foreach(var2 in var0.entities) {
    forcestoprecording(var2);
  }
}

function processevent(var0, var1, var2, var3, var4, var5) {
  if(!level.potgenabled) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = gettime();
  }

  if(!isDefined(var2)) {
    var2 = var1;
  }

  var6 = level.potgglobals;
  var7 = getentitypotgdata(self);
  removeoldevents(var7);

  if(!isrecordingenabled(var7)) {
    return;
  }

  var8 = int(max(getcurwindowstarttime(), var7.lastrecordingstarttime));

  if(var1 <= var8 || var2 <= var8) {
    return;
  }

  var9 = spawnStruct();
  var10 = undefined;

  if(isDefined(var4)) {
    var10 = var4;
  } else {
    var10 = eventtable_getscore(var0);
  }

  if(isDefined(var5)) {
    var10 *= var5;
  }

  var9.eventref = var0;
  var9.starttime = var1;
  var9.endtime = var2;
  var9.score = var10;
  var9.psoffsettime = var3;
  var11 = var7.nexteventid;
  var7.nexteventid++;
  var7.events[var11] = var9;
  datalog_newevent(var9, var11, self);

  if(!eventtable_isaddonevent(var0)) {
    thread waitandnominatepotg(var7);
  }
}

function waitandnominatepotg(var0) {
  var1 = var0.entity;
  var1 endon("disconnect");
  var1 endon("cleanup_potg_entity");
  var1 notify("waitAndNominatePOTG()");
  var1 endon("waitAndNominatePOTG()");
  waittillframeend();

  if(!isrecordingenabled(var0)) {
    return;
  }

  var2 = calculatepotgscore(var0.events);

  if(var2 > getminimumscorerequirednvidiahighlights() && var1 ispcplayer()) {}

  if(var2 > getminimumscorerequired() && var2 > getbestpotgscore()) {
    var3 = createscenefromnewevent(var0, var2);
    thread waitformorerecordingtimeforscene(var1);
  }
}

function removeoldevents(var0) {
  var1 = getcurwindowstarttime();

  foreach(var3 in var0.events) {
    if(var3.starttime < var1) {
      var0.events[var4] = undefined;
    }
  }
}

function removeallevents(var0) {
  var0.events = [];
}

function createscenefromnewevent(var0, var1) {
  var2 = spawnStruct();
  var2.primaryentity = var0.entity;
  var2.events = var0.events;
  var2.score = var1;
  var2.sceneid = level.potgglobals.nextsceneid;
  level.potgglobals.nextsceneid++;
  var2.actionstarttime = undefined;
  var2.actionendtime = undefined;

  foreach(var4 in var0.events) {
    if(!isDefined(var2.actionstarttime) || var4.starttime < var2.actionstarttime) {
      var2.actionstarttime = var4.starttime;
    }

    if(!isDefined(var2.actionendtime) || var4.endtime > var2.actionendtime) {
      var2.actionendtime = var4.endtime;
    }
  }

  var2.recordingstarttime = var0.lastrecordingstarttime;
  var2.endtime = undefined;
  var2.playbackstarttime = undefined;
  var2.playbackendtime = undefined;
  return var2;
}

function doesscenehaveenoughtotalrecordingtime(var0) {
  return getmaxsceneduration(var0) >= getwholescenedurationmin();
}

function doesscenehaveenoughbufferrecordingtime(var0) {
  return var0.endtime - var0.actionendtime >= getscenebufferduration();
}

function getmaxsceneduration(var0) {
  var1 = var0.recordingstarttime;
  return var0.endtime - var0.recordingstarttime;
}

function waitformorerecordingtimeforscene(var0) {
  self endon("disconnect");
  self endon("cleanup_potg_entity");
  var1 = var0.recordingstarttime + getwholescenedurationmin();
  var2 = var0.actionendtime + getscenebufferduration();
  var3 = var0.actionstarttime + getwholescenedurationmax();
  var4 = int(clamp(var2, var1, var3));
  var5 = "no_wait";

  if(var4 > gettime()) {
    thread watchpendingscenetimeout(var4);
    var5 = scripts\engine\utility::ref_143b4("potg_pending_scene_timeout", "potg_stop_recording");
    self notify("potg_scene_finished_pending");
  }

  if(gettime() > var4) {
    var0.endtime = var4;
  } else {
    var0.endtime = gettime();
  }

  if(doesscenehaveenoughtotalrecordingtime(var0)) {
    if(doesscenehaveenoughbufferrecordingtime(var0)) {
      if(var0.score > getminimumscorerequired() && var0.score >= getbestpotgscore()) {
        setcurpotgscene(var0);
        return;
      }

      return;
    }

    return;
  }
}

function watchpendingscenetimeout(var0) {
  self endon("potg_scene_finished_pending");

  while(gettime() < var0) {
    waitframe();
  }

  self notify("potg_pending_scene_timeout");
}

function calculatepotgscore(var0) {
  var1 = 0;
  var2 = 0;

  foreach(var4 in var0) {
    var2 += var4.score;

    if(var4.eventref == "kill") {
      var1++;
    }
  }

  if(var1 > 2) {
    var6 = eventtable_getscore("triple_kill");
    var2 += var6;
  }

  return var2;
}

function setcurpotgscene(var0) {
  calcsceneplaybacktimes(var0);
  requestarchive(var0.playbackstarttime, var0.playbackendtime);
  screenprint_newpotgchosen(var0, level.potgglobals.curpotgscene);
  level.potgglobals.curpotgscene = var0;
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

  var0 = level.potgglobals;

  if(!isDefined(var0.curpotgscene)) {
    return -1;
  }

  return var0.curpotgscene.score;
}

function getcurwindowstarttime() {
  return gettime() - getwholescenedurationmax();
}

function eventtable_getscore(var0) {
  return level.potgglobals.eventtable[var0]["score"];
}

function eventtable_isaddonevent(var0) {
  return level.potgglobals.eventtable[var0]["addOn"];
}

function eventtable_isevent(var0) {
  return isDefined(level.potgglobals.eventtable[var0]);
}

function finalizescene(var0) {
  var0.finalized = 1;
  calcscenepsoffset(var0);
  ref_12c7c();
  datalog_scenefinalized(var0);
}

function ref_12c7c() {
  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_potg_score_event_control", -1);
    var1 setclientomnvar("ui_score_event_list_0", -1);
    var1 setclientomnvar("ui_score_event_list_1", -1);
    var1 setclientomnvar("ui_score_event_list_2", -1);
    var1 setclientomnvar("ui_score_event_list_3", -1);
    var1 setclientomnvar("ui_score_event_list_4", -1);
  }
}

function calcsceneplaybacktimes(var0) {
  var1 = gettime() - 13000;
  var2 = var0.endtime - getwholescenedurationmax();
  var3 = int(max(var2, max(var0.recordingstarttime, var1)));
  var4 = var0.actionstarttime - getscenebufferduration();
  var5 = int(min(var0.actionstarttime, var0.endtime - getwholescenedurationmin()));
  var0.playbackstarttime = int(clamp(var4, var3, var5));
  var0.playbackendtime = var0.endtime;
  var6 = var0.playbackendtime - var0.playbackstarttime;
}

function calcscenepsoffset(var0) {
  var1 = [];

  foreach(var3 in var0.events) {
    if(isDefined(var3.psoffsettime) && !isDefined(var1[var3.endtime])) {
      var1 = var3.psoffsettime;
    }
  }

  if(var1.size <= 0) {
    var0.psoffsettime = 0;
    return;
  }

  var5 = 0;

  foreach(var7 in var1) {
    var5 += var7;
  }

  var9 = var5 / var1.size;
  var0.psoffsettime = int(var9);
}

function getfinalpotginfo() {
  var0 = getcurpotgscene();

  if(!isDefined(var0)) {
    return undefined;
  }

  var1 = spawnStruct();
  var1.starttime = var0.playbackstarttime;
  var1.endtime = var0.playbackendtime;
  var1.spectateentity = var0.primaryentity;
  var1.psoffsettime = var0.psoffsettime;
  return var1;
}

function requestarchive(var0, var1) {
  thread archiverequesthelper(level, var0);
}

function archiverequesthelper(var0, var1) {
  level endon("potg_finalize");
  level notify("potg_archiveRequestHelper()");
  level endon("potg_archiveRequestHelper()");
  level.potgglobals.pendingarchiverequest = 1;
  var2 = var0 + 13000 - 100;
  var3 = var2 - gettime();
  scripts\engine\utility::wait_time_in_ms(var3);
  level.potgglobals.pendingarchiverequest = 0;
  archivecurrentgamestate();
}

function archivecurrentgamestate() {
  thread debug_watcharchivesize(getpotgduration(), getcurpotgscene());
  getpotgstarttime();
  var0 = level.potgglobals.lastarchivetime;
  level.potgglobals.lastarchivetime = gettime();
  var1 = -1;

  if(var0 > 0) {
    var1 = level.potgglobals.lastarchivetime - var0;
    return;
  }
}

function getrapidarchivewarningrate() {
  return 13000 - getwholescenedurationmax() - 250;
}

function doesscenefitincurrentarchive(var0) {
  var1 = level.potgglobals.lastarchivetime;

  if(var1 < 0) {
    return false;
  }

  var2 = var1 - 13000;
  return var0.playbackstarttime >= var2 && var0.playbackendtime <= var1;
}

function screenprint_newpotgchosen(var0, var1) {
  if(getdvarint("potg_screen_prints") == 0) {
    return;
  }

  if(var0.score <= 250) {
    return;
  }

  var2 = undefined;

  if(isPlayer(var0.primaryentity)) {
    var2 = var0.primaryentity.name;
  } else {
    var2 = "(GameObject)";
  }

  if(isPlayer(var0.primaryentity)) {
    var0.primaryentity iprintlnbold("POTG Nominee! (" + var0.score + ")");
  }

  if(isDefined(var1) && isPlayer(var1.primaryentity) && var1.primaryentity != var0.primaryentity) {
    var1.primaryentity iprintlnbold("Your POTG was bested by +" + var2 + "! (" + var0.score + ")");
  }

  level.potgglobals.lastchosenscreenprinttime = gettime();
}

function screenprint_dosceneprintplayback() {
  if(getdvarint("potg_screen_prints") == 0) {
    return;
  }

  var0 = getcurpotgscene();
  var1 = gettime() - int(self.archivetime * 1000);
  var2 = 0.15;
  var3 = [];

  for(;;) {
    foreach(var6, var5 in var0.events) {
      if(var5.starttime <= var1 && !isDefined(var3[var6])) {
        iprintlnbold(var5.eventref);
        iprintln(var5.eventref);
        var3 = 1;
        break;
      }
    }

    wait var2;
    var1 += int(var2 * 1000);
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

function datalog_scenefinalized(var0) {
  if(!datalog_isloggingenabled()) {
    return;
  }

  var1 = datalog_getlogversion();
  getentitylessscriptablearray("mpscript_potg", ["score", var0.score, "duration", var0.playbackendtime - var0.playbackstarttime, "start_time", var0.playbackstarttime, "action_start_offset", var0.actionstarttime - var0.playbackstarttime, "action_end_offset", var0.actionendtime - var0.playbackstarttime, "entity_id", getentityid(var0.primaryentity), "script_version", var1]);

  foreach(var3 in var0.events) {
    getentitylessscriptablearray("mpscript_potg_final_events", ["event_ref", var3.eventref, "score", var3.score, "start_time", var3.playbackstarttime, "end_time", var3.playbackendtime, "script_version", var1]);
  }
}

function datalog_newevent(var0, var1, var2) {
  if(!datalog_isloggingenabled()) {
    return;
  }

  getentitylessscriptablearray("mpscript_potg_events", ["event_ref", var0.eventref, "score", var0.score, "start_time", var0.starttime, "end_time", var0.endtime, "event_id", var1, "entity_id", getentityid(var2), "script_version", datalog_getlogversion()]);
}

function datalog_archivesaved(var0, var1, var2, var3, var4) {
  if(getdvarint("potg_debug_archive", 0) == 0) {
    return;
  }

  var5 = datalog_getlogversion();
  getentitylessscriptablearray("mpscript_potg_archive", ["requestTime", var0, "archiveStartTime", var1, "archiveDuration", var2, "desiredSceneStartTime", var3, "desiredSceneEndTime", var4, "playerCount", level.players.size, "tickRate", int(1 / level.framedurationseconds), "dedi", scripts\engine\utility::ter_op(isdedicatedserver(), 1, 0), "version", 0]);
}

function debug_watcharchivesize(var0, var1) {
  var2 = gettime();
  thread debug_watcharchivefinished(var2, var0, var1);
  thread debug_watcharchiveinterrupted(var2, var1);
}

function debug_watcharchivefinished(var0, var1, var2) {
  level notify("watching_potg_archive_request");
  level endon("watching_potg_archive_request");
  jumpiffalse(getdvarint("potg_debug_archive") == 0) LOC_00000022;
  return;
}

function debug_watcharchiveinterrupted(var0, var1) {
  level endon("potg_archive_request_finished");
  level waittill("watching_potg_archive_request");
  debug_logarchiveresult(0, var1, var0);
}

function debug_logarchiveresult(var0, var1, var2, var3, var4) {
  if(var0) {
    thread datalog_archivesaved(var2, var3, var4, var1.playbackstarttime, var1.playbackendtime);
  }

  if(var0) {
    return;
  }
}