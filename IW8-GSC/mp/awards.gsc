/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\awards.gsc
***********************************************/

init() {
  initawards();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
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
  initmidmatchawards();
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
  var_8 = undefined;

  if(isDefined(var_6) && isDefined(var_6.streakinfo))
    var_8 = var_6.streakinfo;

  if(!istrue(var_3)) {
    self endon("_encstr_8D820B49520F0EC02DDE6367EC");
    waitframe();
    scripts\mp\utility\script::waittillslowprocessallowed();
  }

  if(!isDefined(level.awards[var_0])) {
    return;
  }
  if(isenumvaluevalid("_encstr_8C07031599", "_encstr_8BAA074114BE63A1F3", var_0))
    addawardtoaarlist(var_0);

  var_9 = level.awards[var_0].xpscoreevent;

  if(isDefined(var_9)) {
    if(isDefined(var_2))
      var_10 = var_2;
    else
      var_10 = scripts\mp\rank::getscoreinfovalue(var_9);

    scripts\mp\rank::giverankxp(var_9, var_10, var_7);
  }

  var_11 = level.awards[var_0].gamescoreevent;

  if(isDefined(var_11))
    scripts\mp\utility\points::giveunifiedpoints(var_11, undefined, var_1, 1, var_4, var_5, var_8);

  scripts\mp\utility\script::bufferednotify("_encstr_A147160DE69B6519D4D7A82017FAF1CF420B74047F33CB61", var_0);

  if(isDefined(self.awardsthislife[var_0]))
    self.awardsthislife[var_0]++;
  else
    self.awardsthislife[var_0] = 1;

  scripts\common\utility::_id_13E0A(level._id_11B27, var_0);
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

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    if(!istrue(var_0) || scripts\mp\utility\player::isinkillcam()) {
      if(!scripts\mp\utility\player::isusingremote())
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
  if(self ispcplayer() && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    createnvidiavideo(var_0);

  if(shouldqueuemidmatchaward(var_3)) {
    queuemidmatchaward(var_0);
    return;
  }

  scripts\mp\analyticslog::logevent_awardgained(var_0);
  thread giveaward(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
}

createnvidiavideo(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_927905C387ED73":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 9);
      var_1 = 1;
      break;
    case "_encstr_B63E13D8F53AD70B08E7F0B1934FC09FA25CC1D10A":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 7);
      var_1 = 1;
      break;
    case "_encstr_97AB0FAF3285E5C3ACE7D91AE2B73D9A72":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 12);
      var_1 = 1;
      break;
    case "_encstr_84DC1022837BCAFAEE40435B5F308BA86178":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 13);
      var_1 = 1;
      break;
    case "_encstr_A1870C3ABB306819D982C9FFDE48":
      self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 8);
      var_1 = 1;
      break;
  }

  if(var_1 == 0) {
    if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
      switch (var_0) {
        case "_encstr_8E9C0791DB5D26632B":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 17);
          break;
        case "_encstr_8DA3073A27B483C6CA":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 18);
          break;
        case "_encstr_B82009D8DBE6D9CDD0B7E8":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 19);
          break;
        case "_encstr_811F08C0C726E1953267":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 20);
          break;
        case "_encstr_A13C0913C2C6B5CD470B31":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 21);
          break;
        case "_encstr_838113CBD840BFBB731D271F752BF2ED816D0455B0":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 22);
          break;
      }
    } else {
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
        case "_encstr_9A19049B2D3C":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 10);
          break;
        case "_encstr_AF4006A12DF490AB":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 11);
          break;
        case "_encstr_92D21943F78FB82017D3B09EBAF76160676F43F7743958F137AA29":
          self setclientomnvar("_encstr_A621183B31A8EC1A53B3C47F9B6152B7D048377730E325B281C6", 14);
          break;
      }
    }
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