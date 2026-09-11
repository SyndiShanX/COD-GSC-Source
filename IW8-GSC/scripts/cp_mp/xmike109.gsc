/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\xmike109.gsc
***********************************************/

function init() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  initawards();
  thread onplayerconnect();
  thread saveaarawardsonroundswitch();
  level.givemidmatchawardfunc = &givemidmatchaward;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    thread initaarawardlist();
    var_0.awardqueue = [];
  }
}

function onplayerspawned() {
  self.awardsthislife = [];
}

function initawards() {
  scripts\engine\utility::flag_init("cp_operator_unlock_ids_initted");
  initmidmatchawards();
  toggle_apc_objective();
  scripts\engine\utility::flag_set("cp_operator_unlock_ids_initted");
}

function toggle_apc_objective() {
  level.ref_12132 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("cp_reward_ids.csv", var_0, 2);

    if(isDefined(var_1) && var_1 != "") {
      var_2 = spawnStruct();
      var_3 = tablelookup("cp_reward_ids.csv", 2, var_1, 1);
      var_4 = tablelookup("cp_reward_ids.csv", 2, var_1, 0);
      var_2.ref_12131 = int(var_3);
      var_2.id = int(var_4);
      level.ref_12132[var_1] = var_2;
      var_0++;
    } else {
      break;
    }

    waitframe();
  }

  level.vehicle_occupancy_cleanfriendlystatus = 0;
}

function initbaseaward(var_0, var_1) {
  level.awards[var_0] = spawnStruct();
  level.awards[var_0].type = var_1;
  var_2 = tablelookup("mp/awardtable.csv", 1, var_0, 10);

  if(isDefined(var_2) && var_2 != "") {
    level.awards[var_0].xpscoreevent = var_2;
  }

  var_3 = tablelookup("mp/awardtable.csv", 1, var_0, 11);

  if(isDefined(var_3) && var_3 != "") {
    level.awards[var_0].gamescoreevent = var_3;
  }

  var_4 = tablelookup("mp/awardtable.csv", 1, var_0, 3);

  if(isDefined(var_4) && var_4 != "") {
    level.awards[var_0].category = var_4;
  }

  var_5 = tablelookup("mp/awardtable.csv", 1, var_0, 7);

  if(isDefined(var_5) && var_5 != "") {
    var_6 = randomfloat(1);
    level.awards[var_0].aarpriority = float(var_5) + var_6;
    return;
  }
}

function initbasemidmatchaward(var_0, var_1) {
  initbaseaward(var_0, var_1);
}

function initmidmatchaward(var_0) {
  initbasemidmatchaward(var_0, "midmatch");
}

function initmidmatchawards() {
  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/awardtable.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/awardtable.csv", var_0, 9);

    if(isDefined(var_2) && var_2 != "") {
      initmidmatchaward(var_1);
    }

    level.awards[var_1].id = var_0;
  }
}

function incplayerrecord(var_0) {
  var_1 = self getplayerdata("common", "awards", var_0);
  self setplayerdata("common", "awards", var_0, var_1 + 1);
}

function giveaward(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isagent(self) || isscriptedagent(self)) {
    return;
  }

  var_8 = undefined;

  if(isDefined(var_6) && isDefined(var_6.streakinfo)) {
    var_8 = var_6.streakinfo;
  }

  if(!istrue(var_3)) {
    self endon("disconnect");
    waitframe();
  }

  if(!isDefined(level.awards[var_0])) {
    return;
  }

  if(!isenumvaluevalid("mp", "Awards", var_0)) {
    return;
  }

  addawardtoaarlist(var_0);
  var_9 = level.awards[var_0].xpscoreevent;

  if(isDefined(var_9)) {
    if(isDefined(var_2)) {
      var_10 = var_2;
    } else {
      var_10 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_10);
    }

    scripts\cp\drone\emp_drone::giverankxp(var_10, var_10, var_8);
  }

  var_11 = level.awards[var_1].gamescoreevent;

  if(isDefined(var_11)) {
    scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints(var_11, undefined, var_2, 1, var_5, var_6);
  }

  self notify("earned_award_buffered", var_1);

  if(isDefined(self.awardsthislife)) {
    if(isDefined(self.awardsthislife[var_1])) {
      self.awardsthislife[var_1]++;
    } else {
      self.awardsthislife[var_1] = 1;
    }

    scripts\cp\agents\agents::logaward(var_1);
  }
}

function queuemidmatchaward(var_0) {
  self.awardqueue[self.awardqueue.size] = var_0;
  thread flushmidmatchawardqueuewhenable();
}

function flushmidmatchawardqueue() {
  foreach(var_1 in self.awardqueue) {
    givemidmatchaward(var_1);
  }

  self.awardqueue = [];
}

function flushmidmatchawardqueuewhenable() {
  self endon("disconnect");
  self notify("flushMidMatchAwardQueueWhenAble()");
  self endon("flushMidMatchAwardQueueWhenAble()");

  for(;;) {
    if(!shouldqueuemidmatchaward()) {
      break;
    }

    waitframe();
  }

  thread flushmidmatchawardqueue();
}

function shouldqueuemidmatchaward(var_0) {
  if(level.gameended) {
    return false;
  }

  if(!scripts\cp\utility\player::isreallyalive(self)) {
    if(!istrue(var_0) || scripts\cp\utility\player::isinkillcam()) {
      if(!scripts\cp\utility\player::isusingremote()) {
        return true;
      }
    }
  }

  return false;
}

function givemidmatchaward(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isPlayer(self)) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(self ispcplayer()) {
    createnvidiavideo(var_0);
  }

  if(shouldqueuemidmatchaward(var_3)) {
    queuemidmatchaward(var_0);
    return;
  }

  thread giveaward(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
}

function createnvidiavideo(var_0) {
  switch (var_0) {
    case "five":
      self setclientomnvar("nVidiaHighlights_events", 1);
      break;
    case "seven":
      self setclientomnvar("nVidiaHighlights_events", 2);
      break;
    case "eight":
      self setclientomnvar("nVidiaHighlights_events", 3);
      break;
    case "streak_10":
      self setclientomnvar("nVidiaHighlights_events", 4);
      break;
    case "streak_20":
      self setclientomnvar("nVidiaHighlights_events", 5);
      break;
    case "streak_30":
      self setclientomnvar("nVidiaHighlights_events", 6);
      break;
    case "one_shot_two_kills":
      self setclientomnvar("nVidiaHighlights_events", 7);
      break;
    case "item_impact":
      self setclientomnvar("nVidiaHighlights_events", 8);
      break;
  }
}

function addawardtoaarlist(var_0) {
  if(!isDefined(self.aarawards)) {
    self.aarawards = [];
    self.aarawardcount = 0;

    for(var_1 = 0; var_1 < 10; var_1++) {
      var_2 = spawnStruct();
      self.aarawards[var_1] = var_2;
      var_2.ref = "none";
      var_2.count = 0;
    }
  }

  foreach(var_1, var_4 in self.aarawards) {
    if(var_4.ref == var_0) {
      var_4.count++;
      self setplayerdata("common", "round", "awards", var_1, "value", var_4.count);
      return;
    }
  }

  var_5 = level.awards[var_0].aarpriority;

  for(var_6 = 0; var_6 < self.aarawards.size; var_6++) {
    var_4 = self.aarawards[var_6];

    if(var_4.ref == "none") {
      break;
    }

    var_7 = level.awards[var_4.ref].aarpriority;

    if(var_5 > var_7) {
      break;
    }
  }

  if(var_6 >= self.aarawards.size) {
    return;
  }

  for(var_8 = self.aarawards.size - 2; var_8 >= var_6; var_8--) {
    var_9 = var_8 + 1;
    self.aarawards[var_9] = self.aarawards[var_8];
    var_4 = self.aarawards[var_9];

    if(var_4.ref != "none") {
      self setplayerdata("common", "round", "awards", var_9, "award", var_4.ref);
      self setplayerdata("common", "round", "awards", var_9, "value", var_4.count);
    }
  }

  var_4 = spawnStruct();
  self.aarawards[var_6] = var_4;
  var_4.ref = var_0;
  var_4.count = 1;
  self setplayerdata("common", "round", "awards", var_6, "award", var_4.ref);
  self setplayerdata("common", "round", "awards", var_6, "value", var_4.count);

  if(self.aarawardcount < 10) {
    self.aarawardcount++;
    self setplayerdata("common", "round", "awardCount", self.aarawardcount);
  }

  if(istrue(self.savedaarawards)) {
    saveaarawards();
    return;
  }
}

function initaarawardlist() {
  self.aarawards = self.pers["aarAwards"];
  self.aarawardcount = self.pers["aarAwardCount"];

  if(isDefined(self.aarawards)) {
    return;
  }

  self setplayerdata("common", "round", "awardCount", 0);

  for(var_0 = 0; var_0 < 10; var_0++) {
    self setplayerdata("common", "round", "awards", var_0, "award", "none");
    self setplayerdata("common", "round", "awards", var_0, "value", 0);
  }
}

function saveaarawardsonroundswitch() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && !isbot(var_1)) {
      saveaarawards(var_1);
    }
  }
}

function saveaarawards() {
  self.pers["aarAwards"] = self.aarawards;
  self.pers["aarAwardCount"] = self.aarawardcount;
  self.savedaarawards = 1;
}

function screenent_d(var_0) {
  scripts\engine\utility::flag_wait("cp_operator_unlock_ids_initted");

  if(!isDefined(var_0) || !isstring(var_0)) {
    return;
  }

  var_1 = int(proxtrigger(var_0));

  switch (var_0) {
    case "juggernauts":
    case "paladin":
    case "headhunter":
    case "kuvalda":
    case "crosswind":
    case "all_operations":
      self reportchallengeuserevent("cp_complete", var_1);
      break;
    default:
      break;
  }
}

function scriptable_callback(var_0) {
  scripts\engine\utility::flag_wait("cp_operator_unlock_ids_initted");

  if(!isDefined(var_0) || !isstring(var_0)) {
    return;
  }

  var_1 = int(proxtrigger(var_0));

  switch (var_0) {
    case "headhunter_mod_vet":
    case "headhunter_mod":
    case "harbinger_mod_vet":
    case "harbinger_mod":
    case "paladin_mod_vet":
    case "paladin_mod":
    case "strongbox_mod_vet":
    case "strongbox_mod":
    case "justreward_mod_vet":
    case "justreward_mod":
    case "kuvalda_mod_vet":
    case "kuvalda_mod":
    case "brimstone_mod_vet":
    case "brimstone_mod":
    case "crosswind_mod_vet":
    case "crosswind_mod":
    case "harbinger":
    case "smuggler":
    case "downtown_4":
    case "downtown_3":
    case "downtown_2":
    case "downtown_1":
      self reportchallengeuserevent("cp_complete", var_1);
      break;
    default:
      break;
  }
}

function proxtrigger(var_0) {
  var_1 = level.ref_12132[var_0].id;
  return var_1;
}

function getaverageangularvelocity() {
  if(istrue(level.vehicle_occupancy_cp_updateriotshield)) {
    return;
  }

  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("kill_juggernaut");
  }

  level.vehicle_occupancy_cleanfriendlystatus++;

  if(level.vehicle_occupancy_cleanfriendlystatus >= 5) {
    foreach(var_1 in level.players) {
      thread screenent_d(var_1);
    }

    level.vehicle_occupancy_cp_updateriotshield = 1;
    return;
  }
}