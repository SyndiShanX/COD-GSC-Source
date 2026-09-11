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
    level waittill("connected", var0);
    thread initaarawardlist();
    var0.awardqueue = [];
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
  var0 = 0;

  for(;;) {
    var1 = tablelookupbyrow("cp_reward_ids.csv", var0, 2);

    if(isDefined(var1) && var1 != "") {
      var2 = spawnStruct();
      var3 = tablelookup("cp_reward_ids.csv", 2, var1, 1);
      var4 = tablelookup("cp_reward_ids.csv", 2, var1, 0);
      var2.ref_12131 = int(var3);
      var2.id = int(var4);
      level.ref_12132[var1] = var2;
      var0++;
    } else {
      break;
    }

    waitframe();
  }

  level.vehicle_occupancy_cleanfriendlystatus = 0;
}

function initbaseaward(var0, var1) {
  level.awards[var0] = spawnStruct();
  level.awards[var0].type = var1;
  var2 = tablelookup("mp/awardtable.csv", 1, var0, 10);

  if(isDefined(var2) && var2 != "") {
    level.awards[var0].xpscoreevent = var2;
  }

  var3 = tablelookup("mp/awardtable.csv", 1, var0, 11);

  if(isDefined(var3) && var3 != "") {
    level.awards[var0].gamescoreevent = var3;
  }

  var4 = tablelookup("mp/awardtable.csv", 1, var0, 3);

  if(isDefined(var4) && var4 != "") {
    level.awards[var0].category = var4;
  }

  var5 = tablelookup("mp/awardtable.csv", 1, var0, 7);

  if(isDefined(var5) && var5 != "") {
    var6 = randomfloat(1);
    level.awards[var0].aarpriority = float(var5) + var6;
    return;
  }
}

function initbasemidmatchaward(var0, var1) {
  initbaseaward(var0, var1);
}

function initmidmatchaward(var0) {
  initbasemidmatchaward(var0, "midmatch");
}

function initmidmatchawards() {
  for(var0 = 0;; var0++) {
    var1 = tablelookupbyrow("mp/awardtable.csv", var0, 1);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var2 = tablelookupbyrow("mp/awardtable.csv", var0, 9);

    if(isDefined(var2) && var2 != "") {
      initmidmatchaward(var1);
    }

    level.awards[var1].id = var0;
  }
}

function incplayerrecord(var0) {
  var1 = self getplayerdata("common", "awards", var0);
  self setplayerdata("common", "awards", var0, var1 + 1);
}

function giveaward(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isagent(self) || isscriptedagent(self)) {
    return;
  }

  var8 = undefined;

  if(isDefined(var6) && isDefined(var6.streakinfo)) {
    var8 = var6.streakinfo;
  }

  if(!istrue(var3)) {
    self endon("disconnect");
    waitframe();
  }

  if(!isDefined(level.awards[var0])) {
    return;
  }

  if(!isenumvaluevalid("mp", "Awards", var0)) {
    return;
  }

  addawardtoaarlist(var0);
  var9 = level.awards[var0].xpscoreevent;

  if(isDefined(var9)) {
    if(isDefined(var2)) {
      var10 = var2;
    } else {
      var10 = scripts\cp\drone\emp_drone::getscoreinfovalue(var10);
    }

    scripts\cp\drone\emp_drone::giverankxp(var10, var10, var8);
  }

  var11 = level.awards[var1].gamescoreevent;

  if(isDefined(var11)) {
    scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints(var11, undefined, var2, 1, var5, var6);
  }

  self notify("earned_award_buffered", var1);

  if(isDefined(self.awardsthislife)) {
    if(isDefined(self.awardsthislife[var1])) {
      self.awardsthislife[var1]++;
    } else {
      self.awardsthislife[var1] = 1;
    }

    scripts\cp\agents\agents::logaward(var1);
  }
}

function queuemidmatchaward(var0) {
  self.awardqueue[self.awardqueue.size] = var0;
  thread flushmidmatchawardqueuewhenable();
}

function flushmidmatchawardqueue() {
  foreach(var1 in self.awardqueue) {
    givemidmatchaward(var1);
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

function shouldqueuemidmatchaward(var0) {
  if(level.gameended) {
    return false;
  }

  if(!scripts\cp\utility\player::isreallyalive(self)) {
    if(!istrue(var0) || scripts\cp\utility\player::isinkillcam()) {
      if(!scripts\cp\utility\player::isusingremote()) {
        return true;
      }
    }
  }

  return false;
}

function givemidmatchaward(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!isPlayer(self)) {
    return;
  }

  if(isai(self)) {
    return;
  }

  if(self ispcplayer()) {
    createnvidiavideo(var0);
  }

  if(shouldqueuemidmatchaward(var3)) {
    queuemidmatchaward(var0);
    return;
  }

  thread giveaward(var0, var1, var2, var4, var5, var6, var7, var8);
}

function createnvidiavideo(var0) {
  switch (var0) {
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

function addawardtoaarlist(var0) {
  if(!isDefined(self.aarawards)) {
    self.aarawards = [];
    self.aarawardcount = 0;

    for(var1 = 0; var1 < 10; var1++) {
      var2 = spawnStruct();
      self.aarawards[var1] = var2;
      var2.ref = "none";
      var2.count = 0;
    }
  }

  foreach(var1, var4 in self.aarawards) {
    if(var4.ref == var0) {
      var4.count++;
      self setplayerdata("common", "round", "awards", var1, "value", var4.count);
      return;
    }
  }

  var5 = level.awards[var0].aarpriority;

  for(var6 = 0; var6 < self.aarawards.size; var6++) {
    var4 = self.aarawards[var6];

    if(var4.ref == "none") {
      break;
    }

    var7 = level.awards[var4.ref].aarpriority;

    if(var5 > var7) {
      break;
    }
  }

  if(var6 >= self.aarawards.size) {
    return;
  }

  for(var8 = self.aarawards.size - 2; var8 >= var6; var8--) {
    var9 = var8 + 1;
    self.aarawards[var9] = self.aarawards[var8];
    var4 = self.aarawards[var9];

    if(var4.ref != "none") {
      self setplayerdata("common", "round", "awards", var9, "award", var4.ref);
      self setplayerdata("common", "round", "awards", var9, "value", var4.count);
    }
  }

  var4 = spawnStruct();
  self.aarawards[var6] = var4;
  var4.ref = var0;
  var4.count = 1;
  self setplayerdata("common", "round", "awards", var6, "award", var4.ref);
  self setplayerdata("common", "round", "awards", var6, "value", var4.count);

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

  for(var0 = 0; var0 < 10; var0++) {
    self setplayerdata("common", "round", "awards", var0, "award", "none");
    self setplayerdata("common", "round", "awards", var0, "value", 0);
  }
}

function saveaarawardsonroundswitch() {
  level waittill("game_ended");

  foreach(var1 in level.players) {
    if(isDefined(var1) && !isbot(var1)) {
      saveaarawards(var1);
    }
  }
}

function saveaarawards() {
  self.pers["aarAwards"] = self.aarawards;
  self.pers["aarAwardCount"] = self.aarawardcount;
  self.savedaarawards = 1;
}

function screenent_d(var0) {
  scripts\engine\utility::flag_wait("cp_operator_unlock_ids_initted");

  if(!isDefined(var0) || !isstring(var0)) {
    return;
  }

  var1 = int(proxtrigger(var0));

  switch (var0) {
    case "juggernauts":
    case "paladin":
    case "headhunter":
    case "kuvalda":
    case "crosswind":
    case "all_operations":
      self reportchallengeuserevent("cp_complete", var1);
      break;
    default:
      break;
  }
}

function scriptable_callback(var0) {
  scripts\engine\utility::flag_wait("cp_operator_unlock_ids_initted");

  if(!isDefined(var0) || !isstring(var0)) {
    return;
  }

  var1 = int(proxtrigger(var0));

  switch (var0) {
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
      self reportchallengeuserevent("cp_complete", var1);
      break;
    default:
      break;
  }
}

function proxtrigger(var0) {
  var1 = level.ref_12132[var0].id;
  return var1;
}

function getaverageangularvelocity() {
  if(istrue(level.vehicle_occupancy_cp_updateriotshield)) {
    return;
  }

  foreach(var1 in level.players) {
    var1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("kill_juggernaut");
  }

  level.vehicle_occupancy_cleanfriendlystatus++;

  if(level.vehicle_occupancy_cleanfriendlystatus >= 5) {
    foreach(var1 in level.players) {
      thread screenent_d(var1);
    }

    level.vehicle_occupancy_cp_updateriotshield = 1;
    return;
  }
}