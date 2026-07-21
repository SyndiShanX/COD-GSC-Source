/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\potg.gsc
***********************************************/

init() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" || istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    level.potgenabled = 0;
    return;
  }

  if(!isDefined(level.potgenabled) || level.potgenabled)
    level.potgenabled = level.finalkillcamtype == 1;

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
  setdvarifuninitialized("_encstr_871C19837BD176AF2C1B8E5AF673AFC85DE40B1D967B37D7DA58F0", 8000);
  setdvarifuninitialized("_encstr_AB1C19983748378F4791439AF828572FE8B5010453E83DC779C81A", 3000);
  setdvarifuninitialized("_encstr_91401520F8C3D7918590524A08FDD9935BDEB9BC03482B", 1000);
  setdvarifuninitialized("_encstr_8BEB13436AA30909A8A7EE43070720D53050FB2887", 1000);
  setdvarifuninitialized("_encstr_957E15C1BDE8ECBEB5B4DCBE37C695DC2BF5CDC6DEC9AC", 420);
  thread onplayerconnect();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onplayerdisconnect);
  scripts\mp\potg_events::init();
}

getminimumscorerequired() {
  return getdvarint("_encstr_957E15C1BDE8ECBEB5B4DCBE37C695DC2BF5CDC6DEC9AC");
}

getactionscenedurationmax() {
  return getdvarint("_encstr_871C19837BD176AF2C1B8E5AF673AFC85DE40B1D967B37D7DA58F0");
}

getactionscenedurationmin() {
  return getdvarint("_encstr_AB1C19983748378F4791439AF828572FE8B5010453E83DC779C81A");
}

getscenebufferduration() {
  return getdvarint("_encstr_91401520F8C3D7918590524A08FDD9935BDEB9BC03482B");
}

getwholescenedurationmin() {
  return getactionscenedurationmin() + getscenebufferduration() * 2;
}

getwholescenedurationmax() {
  return getactionscenedurationmax() + getscenebufferduration() * 2;
}

getminimumscorerequirednvidiahighlights() {
  return getdvarint("_encstr_AAE3214B9D3C70E082FFBDD7CB1933B0C9F656C084974021BADF8999475106C0978A99");
}

loadeventtable() {
  var_0 = level.potgglobals;
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("_encstr_876118B60EF283DE3A3BFA95D959B9E8D73A854CC6AC178DE6D9", var_1, 0);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    var_0.eventtable[var_2] = [];
    var_3 = tablelookupbyrow("_encstr_876118B60EF283DE3A3BFA95D959B9E8D73A854CC6AC178DE6D9", var_1, 1);
    var_0.eventtable[var_2]["_encstr_82FB06EB26785BD7"] = float(var_3);
    var_4 = tablelookupbyrow("_encstr_876118B60EF283DE3A3BFA95D959B9E8D73A854CC6AC178DE6D9", var_1, 2);
    var_0.eventtable[var_2]["_encstr_8BFD0672E95557F5"] = var_4 != "_encstr_B40101";
    var_1++;
  }
}

onplayerconnect() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    registerpotgentity(var_0);
    var_0 thread updateplayerrecording();
  }
}

updateplayerrecording() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    startrecording();
    self waittill("_encstr_AD75063D571AE108");

    if(!istrue(self.fauxdead))
      self waittill("_encstr_8D831549924785F861D46379F9D07944CFBA6053AA8F35");

    stoprecording();
  }
}

onplayerdisconnect(var_0) {
  deregisterpotgentity(var_0);
}

onroundended(var_0) {
  if(!istrue(level.potgenabled)) {
    return;
  }
  scripts\mp\potg_events::onroundended(var_0);
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
  var_0 = getcurpotgscene();

  if(isDefined(var_0) && isDefined(var_0.primaryentity))
    return var_0.score < getminimumscorerequired();
  else
    return 1;
}

finalizepotgsystem() {
  level notify("_encstr_A3CD0EFB40B327B185FBCD0651A3DBED");
  finalizeallrecordings();
  waittillframeend;
  level.potgglobals.systemfinalized = 1;

  if(shouldskippotg()) {
    return;
  }
  if(level.potgglobals.pendingarchiverequest)
    archivecurrentgamestate();

  var_0 = getcurpotgscene();

  if(isDefined(var_0))
    finalizescene(var_0);
}

issystemfinalized() {
  return level.potgglobals.systemfinalized;
}

registerpotgentity(var_0) {
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

deregisterpotgentity(var_0) {
  if(!level.potgenabled) {
    return;
  }
  var_1 = level.potgglobals;
  var_2 = getentityid(var_0);
  var_1.entities[var_2] = undefined;
  var_0 notify("_encstr_A9E21492C06BC6233BB7D7F0C0E3FF8183486B8AA80B");
}

getentitypotgdata(var_0) {
  var_1 = getentityid(var_0);
  return level.potgglobals.entities[var_1];
}

getentityid(var_0) {
  if(isDefined(var_0.potgid))
    return var_0.potgid;

  var_0.potgid = var_0 getentitynumber();
  return var_0.potgid;
}

startrecording() {
  if(!level.potgenabled) {
    return;
  }
  if(issystemfinalized()) {
    return;
  }
  var_0 = getentitypotgdata(self);

  if(var_0.recordingenabledcount == 0)
    onrecordingstarted(var_0);

  var_0.recordingenabledcount++;
}

onrecordingstarted(var_0) {
  var_0.lastrecordingstarttime = gettime();
}

stoprecording() {
  if(!level.potgenabled) {
    return;
  }
  if(issystemfinalized()) {
    return;
  }
  var_0 = getentitypotgdata(self);
  var_0.recordingenabledcount--;

  if(var_0.recordingenabledcount == 0)
    onrecordingstopped(var_0);
}

forcestoprecording(var_0) {
  var_0.recordingenabledcount = 0;
  var_0.entity onrecordingstopped(var_0);
}

onrecordingstopped(var_0) {
  var_1 = level.potgglobals;
  scripts\mp\potg_events::onpotgrecordingstopped();
  var_0.entity notify("_encstr_86E31407B7D1B3BE6EA3EDE0FA93ACC67B9332B4E676");
  removeallevents(var_0);
}

isrecordingenabled(var_0) {
  if(!level.potgenabled)
    return 0;

  if(issystemfinalized())
    return 0;

  if(!isDefined(var_0))
    var_0 = getentitypotgdata(self);

  return var_0.recordingenabledcount > 0;
}

finalizeallrecordings() {
  var_0 = level.potgglobals;

  foreach(var_2 in var_0.entities)
  forcestoprecording(var_2);
}

processevent(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!level.potgenabled) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = gettime();

  if(!isDefined(var_2))
    var_2 = var_1;

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

  if(isDefined(var_4))
    var_10 = var_4;
  else
    var_10 = eventtable_getscore(var_0);

  if(isDefined(var_5))
    var_10 = var_10 * var_5;

  var_9.eventref = var_0;
  var_9.starttime = var_1;
  var_9.endtime = var_2;
  var_9.score = var_10;
  var_9.psoffsettime = var_3;
  var_11 = var_7.nexteventid;
  var_7.nexteventid++;
  var_7.events[var_11] = var_9;
  datalog_newevent(var_9, var_11, self);

  if(!eventtable_isaddonevent(var_0))
    thread waitandnominatepotg(var_7);
}

waitandnominatepotg(var_0) {
  var_1 = var_0.entity;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_A9E21492C06BC6233BB7D7F0C0E3FF8183486B8AA80B");
  var_1 notify("_encstr_8AD816BB85B48E82374693EDB62DB9C2A3560AA7A8A341A4");
  var_1 endon("_encstr_8AD816BB85B48E82374693EDB62DB9C2A3560AA7A8A341A4");
  waittillframeend;

  if(!isrecordingenabled(var_0)) {
    return;
  }
  var_2 = calculatepotgscore(var_0.events);

  if(var_2 > getminimumscorerequirednvidiahighlights() && var_1 ispcplayer()) {}

  if(var_2 > getminimumscorerequired() && var_2 > getbestpotgscore()) {
    var_3 = createscenefromnewevent(var_0, var_2);
    var_1 thread waitformorerecordingtimeforscene(var_3);
  } else {}
}

removeoldevents(var_0) {
  var_1 = getcurwindowstarttime();

  foreach(var_4, var_3 in var_0.events) {
    if(var_3.starttime < var_1)
      var_0.events[var_4] = undefined;
  }
}

removeallevents(var_0) {
  var_0.events = [];
}

createscenefromnewevent(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.primaryentity = var_0.entity;
  var_2.events = var_0.events;
  var_2.score = var_1;
  var_2.sceneid = level.potgglobals.nextsceneid;
  level.potgglobals.nextsceneid++;
  var_2.actionstarttime = undefined;
  var_2.actionendtime = undefined;

  foreach(var_4 in var_0.events) {
    if(!isDefined(var_2.actionstarttime) || var_4.starttime < var_2.actionstarttime)
      var_2.actionstarttime = var_4.starttime;

    if(!isDefined(var_2.actionendtime) || var_4.endtime > var_2.actionendtime)
      var_2.actionendtime = var_4.endtime;
  }

  var_2.recordingstarttime = var_0.lastrecordingstarttime;
  var_2.endtime = undefined;
  var_2.playbackstarttime = undefined;
  var_2.playbackendtime = undefined;
  return var_2;
}

doesscenehaveenoughtotalrecordingtime(var_0) {
  return getmaxsceneduration(var_0) >= getwholescenedurationmin();
}

doesscenehaveenoughbufferrecordingtime(var_0) {
  return var_0.endtime - var_0.actionendtime >= getscenebufferduration();
}

getmaxsceneduration(var_0) {
  var_1 = var_0.recordingstarttime;
  return var_0.endtime - var_0.recordingstarttime;
}

waitformorerecordingtimeforscene(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A9E21492C06BC6233BB7D7F0C0E3FF8183486B8AA80B");
  var_1 = var_0.recordingstarttime + getwholescenedurationmin();
  var_2 = var_0.actionendtime + getscenebufferduration();
  var_3 = var_0.actionstarttime + getwholescenedurationmax();
  var_4 = int(clamp(var_2, var_1, var_3));
  var_5 = "_encstr_A73108E038170FF9B93B";

  if(var_4 > gettime()) {
    thread watchpendingscenetimeout(var_4);
    var_5 = scripts\engine\utility::_id_143B4("_encstr_AB7D1B5890ABBFC9F938EA42B02D3FA7A30ED5CE3D96BB0C9B2BE2AB40", "_encstr_86E31407B7D1B3BE6EA3EDE0FA93ACC67B9332B4E676");
    self notify("_encstr_AC741CBBCAE4E9363341F7F025411E60134BD3EBA374DFEA43A58742E6AF");
  }

  if(gettime() > var_4)
    var_0.endtime = var_4;
  else
    var_0.endtime = gettime();

  if(doesscenehaveenoughtotalrecordingtime(var_0)) {
    if(doesscenehaveenoughbufferrecordingtime(var_0)) {
      if(var_0.score > getminimumscorerequired() && var_0.score >= getbestpotgscore())
        setcurpotgscene(var_0);
      else {}
    } else {}
  } else {}
}

watchpendingscenetimeout(var_0) {
  self endon("_encstr_AC741CBBCAE4E9363341F7F025411E60134BD3EBA374DFEA43A58742E6AF");

  while(gettime() < var_0)
    waitframe();

  self notify("_encstr_AB7D1B5890ABBFC9F938EA42B02D3FA7A30ED5CE3D96BB0C9B2BE2AB40");
}

calculatepotgscore(var_0) {
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_2 = var_2 + var_4.score;

    if(var_4.eventref == "_encstr_ABD70578F3D02C")
      var_1++;
  }

  if(var_1 > 2) {
    var_6 = eventtable_getscore("_encstr_92850CCBC33B538DB01FC3D961A0");
    var_2 = var_2 + var_6;
  }

  return var_2;
}

setcurpotgscene(var_0) {
  calcsceneplaybacktimes(var_0);
  requestarchive(var_0.playbackstarttime, var_0.playbackendtime);
  screenprint_newpotgchosen(var_0, level.potgglobals.curpotgscene);
  level.potgglobals.curpotgscene = var_0;
}

getcurpotgscene() {
  if(!level.potgenabled)
    return undefined;

  return level.potgglobals.curpotgscene;
}

getbestpotgscore() {
  if(!level.potgenabled)
    return -1;

  var_0 = level.potgglobals;

  if(!isDefined(var_0.curpotgscene))
    return -1;

  return var_0.curpotgscene.score;
}

getcurwindowstarttime() {
  return gettime() - getwholescenedurationmax();
}

eventtable_getscore(var_0) {
  return level.potgglobals.eventtable[var_0]["_encstr_82FB06EB26785BD7"];
}

eventtable_isaddonevent(var_0) {
  return level.potgglobals.eventtable[var_0]["_encstr_8BFD0672E95557F5"];
}

eventtable_isevent(var_0) {
  return isDefined(level.potgglobals.eventtable[var_0]);
}

finalizescene(var_0) {
  var_0.finalized = 1;
  calcscenepsoffset(var_0);
  _id_12C7C();
  datalog_scenefinalized(var_0);
}

_id_12C7C() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("_encstr_8CD01CAEB4BE38DB1DECD7371B7B93CAD759D959B947EBD8F69BD1937BB1", -1);
    var_1 setclientomnvar("_encstr_8C4B168BF0702F3E90159D5FC3A047930DAE92F21BBDE7A2", -1);
    var_1 setclientomnvar("_encstr_9A4B16358BD6F7EEEFB872E938E5A74B6B78A4D11E1BFF22", -1);
    var_1 setclientomnvar("_encstr_AF4B16AB4BD7E6D8F6C9ACFA953B5973D1BEC62DDCA37D8C", -1);
    var_1 setclientomnvar("_encstr_8D4B16D5A5D73736F693B2BE599DB2CD3AEBB15A6E3ABE99", -1);
    var_1 setclientomnvar("_encstr_A24B16839BAF07212F93B97EA7902718EBB603D068AB19F3", -1);
  }
}

calcsceneplaybacktimes(var_0) {
  var_1 = gettime() - 13000;
  var_2 = var_0.endtime - getwholescenedurationmax();
  var_3 = int(max(var_2, max(var_0.recordingstarttime, var_1)));
  var_4 = var_0.actionstarttime - getscenebufferduration();
  var_5 = int(min(var_0.actionstarttime, var_0.endtime - getwholescenedurationmin()));
  var_0.playbackstarttime = int(clamp(var_4, var_3, var_5));
  var_0.playbackendtime = var_0.endtime;
  var_6 = var_0.playbackendtime - var_0.playbackstarttime;
}

calcscenepsoffset(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.events) {
    if(isDefined(var_3.psoffsettime) && !isDefined(var_1[var_3.endtime]))
      var_1[var_3.endtime] = var_3.psoffsettime;
  }

  if(var_1.size <= 0) {
    var_0.psoffsettime = 0;
    return;
  }

  var_5 = 0.0;

  foreach(var_7 in var_1)
  var_5 = var_5 + var_7;

  var_9 = var_5 / var_1.size;
  var_0.psoffsettime = int(var_9);
}

getfinalpotginfo() {
  var_0 = getcurpotgscene();

  if(!isDefined(var_0))
    return undefined;

  var_1 = spawnStruct();
  var_1.starttime = var_0.playbackstarttime;
  var_1.endtime = var_0.playbackendtime;
  var_1.spectateentity = var_0.primaryentity;
  var_1.psoffsettime = var_0.psoffsettime;
  return var_1;
}

requestarchive(var_0, var_1) {
  level thread archiverequesthelper(var_0, var_1);
}

archiverequesthelper(var_0, var_1) {
  level endon("_encstr_A3CD0EFB40B327B185FBCD0651A3DBED");
  level notify("_encstr_AA1D1C07F68E3BEBC227361A5AB3CA92ACB85DCA9B4790CA36C1ACE44192");
  level endon("_encstr_AA1D1C07F68E3BEBC227361A5AB3CA92ACB85DCA9B4790CA36C1ACE44192");
  level.potgglobals.pendingarchiverequest = 1;
  var_2 = var_0 + 13000 - 100;
  var_3 = var_2 - gettime();
  scripts\engine\utility::wait_time_in_ms(var_3);
  level.potgglobals.pendingarchiverequest = 0;
  archivecurrentgamestate();
}

archivecurrentgamestate() {
  thread debug_watcharchivesize(getpotgduration(), getcurpotgscene());
  getpotgstarttime();
  var_0 = level.potgglobals.lastarchivetime;
  level.potgglobals.lastarchivetime = gettime();
  var_1 = -1;

  if(var_0 > 0)
    var_1 = level.potgglobals.lastarchivetime - var_0;
}

getrapidarchivewarningrate() {
  return 13000 - getwholescenedurationmax() - 250;
}

doesscenefitincurrentarchive(var_0) {
  var_1 = level.potgglobals.lastarchivetime;

  if(var_1 < 0)
    return 0;

  var_2 = var_1 - 13000;
  return var_0.playbackstarttime >= var_2 && var_0.playbackendtime <= var_1;
}

screenprint_newpotgchosen(var_0, var_1) {
  if(getdvarint("_encstr_8ECA13C1BDA3B37DCD8D4E56ACE6EB83E4B4B9D1E6") == 0) {
    return;
  }
  if(var_0.score <= 250) {
    return;
  }
  var_2 = undefined;

  if(isPlayer(var_0.primaryentity))
    var_2 = var_0.primaryentity.name;
  else
    var_2 = "_encstr_ADAE0D80E9A6D093AF411801D2E349";

  if(isPlayer(var_0.primaryentity))
    var_0.primaryentity iprintlnbold("_encstr_9315109F60C32C8A15EFA3A3060778D7BAAE" + var_0.score + "_encstr_824C0266");

  if(isDefined(var_1) && isPlayer(var_1.primaryentity) && var_1.primaryentity != var_0.primaryentity)
    var_1.primaryentity iprintlnbold("_encstr_A7F41A87675DB55A7A1FC3D7965761634AB0E7AFF37BBA12427906B2" + var_2 + "_encstr_9517047F2EDC" + var_0.score + "_encstr_824C0266");

  level.potgglobals.lastchosenscreenprinttime = gettime();
}

screenprint_dosceneprintplayback() {
  if(getdvarint("_encstr_8ECA13C1BDA3B37DCD8D4E56ACE6EB83E4B4B9D1E6") == 0) {
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
        var_3[var_6] = 1;
        break;
      }
    }

    wait(var_2);
    var_1 = var_1 + int(var_2 * 1000);
  }
}

datalog_getlogversion() {
  if(getdvarint("_encstr_915E1088228AA7139349930D2587DBDF326A", 0) != 0)
    return -1;

  if(getdvarint("_encstr_A90F0DE66C39AF1CC6B0E5A395CDE8", 0) != 0)
    return 9;

  return -1;
}

datalog_isloggingenabled() {
  return getdvarint("_encstr_846B0D42D74BF7D1556365DBEA888F") != 0;
}

datalog_scenefinalized(var_0) {
  if(!datalog_isloggingenabled()) {
    return;
  }
  var_1 = datalog_getlogversion();
  getentitylessscriptablearray("_encstr_AA5B0EFDB7E3071A53F83399E08753DF", ["_encstr_82FB06EB26785BD7", var_0.score, "_encstr_A7AC09C857E458475AED37", var_0.playbackendtime - var_0.playbackstarttime, "_encstr_A6950B669467AB0139B3B0685A", var_0.playbackstarttime, "_encstr_8B641485363A4BDEDCD7CD3A16E4D1AFF6CC99CD568E", var_0.actionstarttime - var_0.playbackstarttime, "_encstr_BEC312E82B73ECEF9B21CA5EF097DFD557AB275B", var_0.actionendtime - var_0.playbackstarttime, "_encstr_A9660A5937472D3AE5EB2D8C", getentityid(var_0.primaryentity), "_encstr_92E30F521AF3E850D51F6BCF02DA1AAF38", var_1]);

  foreach(var_3 in var_0.events)
  getentitylessscriptablearray("_encstr_AB4A1B0730DBDB9B13FFD301E737B367E6288F8340D02FD2751D5DC34E", ["_encstr_BDFF0A8DA36AE5BB6FE30828", var_3.eventref, "_encstr_82FB06EB26785BD7", var_3.score, "_encstr_A6950B669467AB0139B3B0685A", var_3.playbackstarttime, "_encstr_8A4A09597346D78EA5D6CA", var_3.playbackendtime, "_encstr_92E30F521AF3E850D51F6BCF02DA1AAF38", var_1]);
}

datalog_newevent(var_0, var_1, var_2) {
  if(!datalog_isloggingenabled()) {
    return;
  }
  getentitylessscriptablearray("_encstr_8A041532EB5E6772B8197457F1603BAF90E13B3AB0B56F", ["_encstr_BDFF0A8DA36AE5BB6FE30828", var_0.eventref, "_encstr_82FB06EB26785BD7", var_0.score, "_encstr_A6950B669467AB0139B3B0685A", var_0.starttime, "_encstr_8A4A09597346D78EA5D6CA", var_0.endtime, "_encstr_8BCC09D09BA7DD8B777925", var_1, "_encstr_A9660A5937472D3AE5EB2D8C", getentityid(var_2), "_encstr_92E30F521AF3E850D51F6BCF02DA1AAF38", datalog_getlogversion()]);
}

datalog_archivesaved(var_0, var_1, var_2, var_3, var_4) {
  if(getdvarint("_encstr_8BEB13436AA30909A8A7EE43070720D53050FB2887", 0) == 0) {
    return;
  }
  var_5 = datalog_getlogversion();
  getentitylessscriptablearray("_encstr_BDF116AA73C60F1AC071ECFF49C8A35778C9D3321893E317", ["_encstr_A5810CEAC59B2BE5EB28C33FC801", var_0, "_encstr_9AED11199D606427BC21A1DB89966BD3983B95", var_1, "_encstr_9B9A10A125D8DC6FF47998B3A347D35460F5", var_2, "_encstr_857A16F3480B014BBB45AA5E3D45F2E333C0133B59204D62", var_3, "_encstr_A6B5142398DBD19B0BF51A0E6D35A245C0387B9F20F1", var_4, "_encstr_9B0C0CE01BC2E559C9A1F6BAB9A3", level.players.size, "_encstr_9A79098ED21BDA25C2D12B", int(1.0 / level.framedurationseconds), "_encstr_B26705A7E551F3", scripts\engine\utility::ter_op(isdedicatedserver(), 1, 0), "_encstr_A32C08DBCBC6CB918820", 0]);
}

debug_watcharchivesize(var_0, var_1) {
  var_2 = gettime();
  thread debug_watcharchivefinished(var_2, var_0, var_1);
  thread debug_watcharchiveinterrupted(var_2, var_1);
}

debug_watcharchivefinished(var_0, var_1, var_2) {
  level notify("_encstr_B62C1ED74FFBB9289B2647AFA3EDF0E761DFF2220301F347F750BD6358302B71");
  level endon("_encstr_B62C1ED74FFBB9289B2647AFA3EDF0E761DFF2220301F347F750BD6358302B71");

  if(getdvarint("_encstr_8BEB13436AA30909A8A7EE43070720D53050FB2887") == 0) {
    return;
  }
  for(;;) {
    var_3 = getpotgduration();

    if(var_3 != var_1) {
      level notify("_encstr_ABB71ED7E71B0C4E6705A7384FC3BF896BC7DB1B676E9BE1FF5A3742EAFB4A28");
      debug_logarchiveresult(1, var_2, var_0, var_3, completescenetransition());
      break;
    }

    waitframe();
  }
}

debug_watcharchiveinterrupted(var_0, var_1) {
  level endon("_encstr_ABB71ED7E71B0C4E6705A7384FC3BF896BC7DB1B676E9BE1FF5A3742EAFB4A28");
  level waittill("_encstr_B62C1ED74FFBB9289B2647AFA3EDF0E761DFF2220301F347F750BD6358302B71");
  debug_logarchiveresult(0, var_1, var_0);
}

debug_logarchiveresult(var_0, var_1, var_2, var_3, var_4) {
  if(var_0)
    thread datalog_archivesaved(var_2, var_3, var_4, var_1.playbackstarttime, var_1.playbackendtime);

  if(var_0)
    return;
}