/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\xmike109.gsc
***********************************************/

init() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  initawards();
  level thread onplayerconnect();
  level thread saveaarawardsonroundswitch();
  level.givemidmatchawardfunc = ::givemidmatchaward;
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread initaarawardlist();
    var_0.awardqueue = [];
  }
}

onplayerspawned() {
  self.awardsthislife = [];
}

initawards() {
  scripts\engine\utility::flag_init("_encstr_B6AA1FD80EAFDE83563985D1DB93D75D73D87BB1DAD7D219E6FAB4E6A53A1D2B46");
  initmidmatchawards();
  toggle_apc_objective();
  scripts\engine\utility::flag_set("_encstr_B6AA1FD80EAFDE83563985D1DB93D75D73D87BB1DAD7D219E6FAB4E6A53A1D2B46");
}

toggle_apc_objective() {
  level._id_12132 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_972C12B107AFC92BEEC29332D72D236EB8B1CDCE", var_0, 2);

    if(isDefined(var_1) && var_1 != "_encstr_B40101") {
      var_2 = spawnStruct();
      var_3 = tablelookup("_encstr_972C12B107AFC92BEEC29332D72D236EB8B1CDCE", 2, var_1, 1);
      var_4 = tablelookup("_encstr_972C12B107AFC92BEEC29332D72D236EB8B1CDCE", 2, var_1, 0);
      var_2._id_12131 = int(var_3);
      var_2.id = int(var_4);
      level._id_12132[var_1] = var_2;
      var_0++;
    } else
      break;

    waitframe();
  }

  level.vehicle_occupancy_cleanfriendlystatus = 0;
}

initbaseaward(var_0, var_1) {
  level.awards[var_0] = spawnStruct();
  level.awards[var_0].type = var_1;
  var_2 = tablelookup("_encstr_99DC126DE17A5ED7BF5B5A630106F3172AAF0BFE", 1, var_0, 10);

  if(isDefined(var_2) && var_2 != "_encstr_B40101")
    level.awards[var_0].xpscoreevent = var_2;

  var_3 = tablelookup("_encstr_99DC126DE17A5ED7BF5B5A630106F3172AAF0BFE", 1, var_0, 11);

  if(isDefined(var_3) && var_3 != "_encstr_B40101")
    level.awards[var_0].gamescoreevent = var_3;

  var_4 = tablelookup("_encstr_99DC126DE17A5ED7BF5B5A630106F3172AAF0BFE", 1, var_0, 3);

  if(isDefined(var_4) && var_4 != "_encstr_B40101")
    level.awards[var_0].category = var_4;

  var_5 = tablelookup("_encstr_99DC126DE17A5ED7BF5B5A630106F3172AAF0BFE", 1, var_0, 7);

  if(isDefined(var_5) && var_5 != "_encstr_B40101") {
    var_6 = randomfloat(1.0);
    level.awards[var_0].aarpriority = float(var_5) + var_6;
  }
}

initbasemidmatchaward(var_0, var_1) {
  initbaseaward(var_0, var_1);
}

initmidmatchaward(var_0) {
  initbasemidmatchaward(var_0, "_encstr_87DF09D69691B558E8D80D");
}

initmidmatchawards() {
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_99DC126DE17A5ED7BF5B5A630106F3172AAF0BFE", var_0, 1);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tablelookupbyrow("_encstr_99DC126DE17A5ED7BF5B5A630106F3172AAF0BFE", var_0, 9);

    if(isDefined(var_2) && var_2 != "_encstr_B40101")
      initmidmatchaward(var_1);

    level.awards[var_1].id = var_0;
    var_0++;
  }
}

incplayerrecord(var_0) {
  var_1 = self getplayerdata("_encstr_927C07D787E1823F38", "_encstr_8BAA076114BE63A1F3", var_0);
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8BAA076114BE63A1F3", var_0, var_1 + 1);
}

giveaward(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isagent(self) || isscriptedagent(self)) {
    return;
  }
  var_8 = undefined;

  if(isDefined(var_6) && isDefined(var_6.streakinfo))
    var_8 = var_6.streakinfo;

  if(!istrue(var_3)) {
    self endon("_encstr_8D820B49520F0EC02DDE6367EC");
    waitframe();
  }

  if(!isDefined(level.awards[var_0])) {
    return;
  }
  if(!isenumvaluevalid("_encstr_8C07031599", "_encstr_8BAA074114BE63A1F3", var_0)) {
    return;
  }
  addawardtoaarlist(var_0);
  var_9 = level.awards[var_0].xpscoreevent;

  if(isDefined(var_9)) {
    if(isDefined(var_2))
      var_10 = var_2;
    else
      var_10 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_9);

    scripts\cp\drone\emp_drone::giverankxp(var_9, var_10, var_7);
  }

  var_11 = level.awards[var_0].gamescoreevent;

  if(isDefined(var_11))
    scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints(var_11, undefined, var_1, 1, var_4, var_5);

  self notify("_encstr_A147160DE69B6519D4D7A82017FAF1CF420B74047F33CB61", var_0);

  if(isDefined(self.awardsthislife)) {
    if(isDefined(self.awardsthislife[var_0]))
      self.awardsthislife[var_0]++;
    else
      self.awardsthislife[var_0] = 1;

    scripts\cp\agents\agents::logaward(var_0);
  }
}

queuemidmatchaward(var_0) {
  self.awardqueue[self.awardqueue.size] = var_0;
  thread flushmidmatchawardqueuewhenable();
}

flushmidmatchawardqueue() {
  foreach(var_1 in self.awardqueue)
  givemidmatchaward(var_1);

  self.awardqueue = [];
}

flushmidmatchawardqueuewhenable() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_9948224A48C3FA83B4A374454F7B67C45378A283B02333CFEB9D4F6855CDB70EA170BE8E");
  self endon("_encstr_9948224A48C3FA83B4A374454F7B67C45378A283B02333CFEB9D4F6855CDB70EA170BE8E");

  for(;;) {
    if(!shouldqueuemidmatchaward()) {
      break;
    }

    waitframe();
  }

  thread flushmidmatchawardqueue();
}

shouldqueuemidmatchaward(var_0) {
  if(level.gameended)
    return 0;

  if(!scripts\cp\utility\player::isreallyalive(self)) {
    if(!istrue(var_0) || scripts\cp\utility\player::isinkillcam()) {
      if(!scripts\cp\utility\player::isusingremote())
        return 1;
    }
  }

  return 0;
}

givemidmatchaward(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isPlayer(self)) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(self ispcplayer())
    createnvidiavideo(var_0);

  if(shouldqueuemidmatchaward(var_3)) {
    queuemidmatchaward(var_0);
    return;
  }

  thread giveaward(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
}

createnvidiavideo(var_0) {
  switch (var_0) {
    case "_encstr_B17805B857A37A":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 1);
      break;
    case "_encstr_9730063321C665C6":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 2);
      break;
    case "_encstr_A19506DD035913B3":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 3);
      break;
    case "_encstr_B8B30A42AD82CD0638DFA107":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 4);
      break;
    case "_encstr_93B30A307BDA09632A41969F":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 5);
      break;
    case "_encstr_8EB30A9B084DFF27F038A3B8":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 6);
      break;
    case "_encstr_B63E13D8F53AD70B08E7F0B1934FC09FA25CC1D10A":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 7);
      break;
    case "_encstr_A1870C3ABB306819D982C9FFDE48":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 8);
      break;
  }
}

addawardtoaarlist(var_0) {
  if(!isDefined(self.aarawards)) {
    self.aarawards = [];
    self.aarawardcount = 0;

    for(var_1 = 0; var_1 < 10; var_1++) {
      var_2 = spawnStruct();
      self.aarawards[var_1] = var_2;
      var_2.ref = "_encstr_8BBA05185F8B99";
      var_2.count = 0;
    }
  }

  foreach(var_1, var_4 in self.aarawards) {
    if(var_4.ref == var_0) {
      var_4.count++;
      self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8BAA076114BE63A1F3", var_1, "_encstr_BA94069D16D8ABAC", var_4.count);
      return;
    }
  }

  var_5 = level.awards[var_0].aarpriority;

  for(var_6 = 0; var_6 < self.aarawards.size; var_6++) {
    var_4 = self.aarawards[var_6];

    if(var_4.ref == "_encstr_8BBA05185F8B99") {
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

    if(var_4.ref != "_encstr_8BBA05185F8B99") {
      self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8BAA076114BE63A1F3", var_9, "_encstr_999D06112722EA95", var_4.ref);
      self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8BAA076114BE63A1F3", var_9, "_encstr_BA94069D16D8ABAC", var_4.count);
    }
  }

  var_4 = spawnStruct();
  self.aarawards[var_6] = var_4;
  var_4.ref = var_0;
  var_4.count = 1;
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8BAA076114BE63A1F3", var_6, "_encstr_999D06112722EA95", var_4.ref);
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8BAA076114BE63A1F3", var_6, "_encstr_BA94069D16D8ABAC", var_4.count);

  if(self.aarawardcount < 10) {
    self.aarawardcount++;
    self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_A5760B71EBE3C2455F5555A559", self.aarawardcount);
  }

  if(istrue(self.savedaarawards))
    saveaarawards();
}

initaarawardlist() {
  self.aarawards = self.pers["_encstr_B1CB0A5F913BDD17A6232888"];
  self.aarawardcount = self.pers["_encstr_A32A0E87C3C6E88FF8A3FF0E3860AEF3"];

  if(isDefined(self.aarawards)) {
    return;
  }
  self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_A5760B71EBE3C2455F5555A559", 0);

  for(var_0 = 0; var_0 < 10; var_0++) {
    self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8BAA076114BE63A1F3", var_0, "_encstr_999D06112722EA95", "_encstr_8BBA05185F8B99");
    self setplayerdata("_encstr_927C07D787E1823F38", "_encstr_8C4606C9DBD5CD46", "_encstr_8BAA076114BE63A1F3", var_0, "_encstr_BA94069D16D8ABAC", 0);
  }
}

saveaarawardsonroundswitch() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && !isbot(var_1))
      var_1 saveaarawards();
  }
}

saveaarawards() {
  self.pers["_encstr_B1CB0A5F913BDD17A6232888"] = self.aarawards;
  self.pers["_encstr_A32A0E87C3C6E88FF8A3FF0E3860AEF3"] = self.aarawardcount;
  self.savedaarawards = 1;
}

screenent_d(var_0) {
  scripts\engine\utility::flag_wait("_encstr_B6AA1FD80EAFDE83563985D1DB93D75D73D87BB1DAD7D219E6FAB4E6A53A1D2B46");

  if(!isDefined(var_0) || !isstring(var_0)) {
    return;
  }
  var_1 = int(proxtrigger(var_0));

  switch (var_0) {
    case "_encstr_975E0CEACB4707635398E990F1D8":
    case "_encstr_B8E508DA7711DAB4F8A8":
    case "_encstr_811D0B60AF6F53294F409B09B3":
    case "_encstr_8171081A85DC7B09740F":
    case "_encstr_91490A8D397B9B9BDDA537C8":
    case "_encstr_8A8E0FA3D3A2C810702F33A993F1D8988B":
      self reportchallengeuserevent("_encstr_971A0C6EBF31D2D850BB22F03973", var_1);
      break;
    default:
      break;
  }
}

scriptable_callback(var_0) {
  scripts\engine\utility::flag_wait("_encstr_B6AA1FD80EAFDE83563985D1DB93D75D73D87BB1DAD7D219E6FAB4E6A53A1D2B46");

  if(!isDefined(var_0) || !isstring(var_0)) {
    return;
  }
  var_1 = int(proxtrigger(var_0));

  switch (var_0) {
    case "_encstr_8B5E131A59B0230DEA73E8959CBEADED91BE3BB21D":
    case "_encstr_A5320F42E803A71B1B98DCC5AE6637ADA1":
    case "_encstr_B63F125B364BAD480EC778D83F55C0E9E19B45DD":
    case "_encstr_A3C90EDA7166EB3C18BF1DF237F8453B":
    case "_encstr_AFF3105B0EDAE6F4AA18096F484D0ECC89E1":
    case "_encstr_974E0C0EB01B0B32D2B97DADF632":
    case "_encstr_A6C4121BF3CBCDAB973648E0416910C4E034177B":
    case "_encstr_ABE60EA030024AD5672288F8419307EA":
    case "_encstr_AD7113355D37A327CAEE853923BE5BB7467D6795D1":
    case "_encstr_9A680F44F50B719381EBEFD579E75032A3":
    case "_encstr_8316107BF034FF21198E1E9AA755078668FB":
    case "_encstr_A1F50CDAABD916B1462CD7B6B791":
    case "_encstr_8A6112263996ADB93A7BE695D7D6F619D7B32B47":
    case "_encstr_99580E92FB030F626017BEBD5F802D93":
    case "_encstr_B8D01211A54FAF66AB7AC36121078839D91B3FCB":
    case "_encstr_81520E737DB776976FC7A86C683FCFB8":
    case "_encstr_AAD00AD085E4135A73D9AC9C":
    case "_encstr_BD50097A1143DAD738900B":
    case "_encstr_88F20B46BDBBDCE8BDBBB9F50D":
    case "_encstr_BDF20B3A90C43B9BF07FF6FFCF":
    case "_encstr_87F20B38EAC3FDAB974737907A":
    case "_encstr_92F20B91BDEECDD17BBBB9AF89":
      self reportchallengeuserevent("_encstr_971A0C6EBF31D2D850BB22F03973", var_1);
      break;
    default:
      break;
  }
}

proxtrigger(var_0) {
  var_1 = level._id_12132[var_0].id;
  return var_1;
}

getaverageangularvelocity() {
  if(istrue(level.vehicle_occupancy_cp_updateriotshield)) {
    return;
  }
  foreach(var_1 in level.players)
  var_1 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_BABA10D6A51B63EBA6ABD99DB293DCC2EAA3");

  level.vehicle_occupancy_cleanfriendlystatus++;

  if(level.vehicle_occupancy_cleanfriendlystatus >= 5) {
    foreach(var_1 in level.players)
    var_1 thread screenent_d("_encstr_975E0CEACB4707635398E990F1D8");

    level.vehicle_occupancy_cp_updateriotshield = 1;
  }
}