/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\pet_watch.gsc
***********************************************/

init() {
  if(!isDefined(level.petconsts) && !scripts\common\utility::iscp())
    level thread autofeeder();

  level.petconsts = [];
  _id_AC0E594AC96AA3A8 = 0;

  for(;;) {
    _id_401CB2FE1AACAC95 = tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 1);

    if(!isDefined(_id_401CB2FE1AACAC95) || _id_401CB2FE1AACAC95 == "") {
      break;
    }

    _id_401CB2FE1AACAC95 = int(_id_401CB2FE1AACAC95);
    _id_B36D39FE14BD8279 = spawnStruct();
    _id_B36D39FE14BD8279.phasetime = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 2));
    _id_B36D39FE14BD8279.bonustimemax = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 3));
    _id_B36D39FE14BD8279.boredomrate = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 4));
    _id_B36D39FE14BD8279.dirtyrate = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 5));
    _id_B36D39FE14BD8279.unrulyrate = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 6));
    _id_B36D39FE14BD8279.hungryrate = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 7));
    _id_B36D39FE14BD8279.bonustype = tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 8);
    _id_B36D39FE14BD8279.boredstart = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 9));
    _id_B36D39FE14BD8279.dirtystart = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 10));
    _id_B36D39FE14BD8279.unrulystart = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 11));
    _id_B36D39FE14BD8279.hungrystart = int(tablelookupbyrow("mp/petWatchTable.csv", _id_AC0E594AC96AA3A8, 12));
    level.petconsts[_id_401CB2FE1AACAC95] = _id_B36D39FE14BD8279;
    _id_AC0E594AC96AA3A8++;
  }

  level.petobjectivefilter = [];
  level.petobjectivefilter["stat_8FCF8BBD78A0502E"] = 1;
  level.petobjectivefilter["stat_9501A62017D709D3"] = 1;
  level.petobjectivefilter["stat_A4EE120BD3F61B35"] = 1;
  level.petobjectivefilter["stat_FC56E889052D3823"] = 1;
  level.petobjectivefilter["stat_F751297C1A2FA2A9"] = 1;
  level.petobjectivefilter["stat_58B9CD84A305DD09"] = 1;
  level.petobjectivefilter["stat_DAB63315ABCDB6B4"] = 1;
  level.petobjectivefilter["stat_7670901F9461C455"] = 1;
  level.petobjectivefilter["stat_891A26E1130EB05B"] = 1;
  level.petobjectivefilter["stat_61CC49DF58D8244E"] = 1;
  level.petobjectivefilter["stat_224B63CC1F966A36"] = 1;
  level.petobjectivefilter["stat_DABB834E68CCA5AF"] = 1;
  level.petobjectivefilter["stat_B25FDA74D611DDF2"] = 1;
  level.petobjectivefilter["stat_020FBB2528F21BD3"] = 1;
  level.petobjectivefilter["stat_5F9FC734692AF8D7"] = 1;
  level.petobjectivefilter["stat_978B9BAB778F200B"] = 1;
}

autofeeder() {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player.petwatch))
        player feedaction();
    }

    wait 1;
  }
}

setstate(state, _id_4DD38AE0E0773275) {
  self setclientomnvar("ui_pet_watch_action", state * -1);
  self.petwatch.phase = state;
  updateuistate();
}

doaction(action) {
  switch (action) {
    case 1:
      growpet();
      break;
    case 2:
      feedaction();
      break;
    case 3:
      thread updatepetstatesincelastupdate();
      break;
    case 4:
      initpet(1);
      break;
    case 6:
      initpet(1, "pet_black");
      break;
    case 5:
      initpet(1, "pet_turbo");
      break;
    case 7:
      initpet(1, "pet_turbo", 1);
      break;
  }
}

growpet() {
  _id_24F8BE8B27233505 = level.petconsts[self.petwatch.phase].phasetime;
  self.petwatch.growthtime = _id_24F8BE8B27233505;
  debugsetlasttime(_id_24F8BE8B27233505);
}

onjoinspectators() {
  self.petwatch = undefined;
}

turbopetchallengewatcher() {
  self endon("disconnect");
  self notify("turboPetChallengeWatcher()");
  self endon("turboPetChallengeWatcher()");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, val);

    if(_id_7148C1A6F25491F8 == "petwatch_turbo_grow") {
      switch (val) {
        case 1:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_egg");
          break;
        case 2:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_baby");
          break;
        case 3:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_child");
          break;
        case 4:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_teen_a");
          break;
        case 5:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_teen_b");
          break;
        case 6:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_skunk");
          break;
        case 7:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_bear");
          break;
        case 8:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_mantis");
          break;
        case 9:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_trex");
          break;
        case 10:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_octopus");
          break;
        case 11:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_fox");
          break;
        case 12:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_secret1");
          break;
        case 13:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_secret2");
          break;
        case 14:
          self reportchallengeuserevent("collect_item", "petwatch_turbo_secret3");
          break;
        default:
          break;
      }

      continue;
    }

    if(_id_7148C1A6F25491F8 == "petwatch_turbo_state")
      self setclientomnvar("ui_pet_watch_state", val);
  }
}

initpet(_id_C3D1929B58499072, _id_F14D8F0FA461EA50, _id_12DDBF4558CC0E91) {
  if(!isDefined(self.petwatch)) {
    self setclientomnvar("ui_pet_watch_state", 0);
    self.petwatch = spawnStruct();
    self.petwatch.petwatchtype = _id_F14D8F0FA461EA50;

    if(_id_F14D8F0FA461EA50 == "pet_black")
      self.petwatch.playerdatafield = "petWatchDataBlack";
    else if(_id_F14D8F0FA461EA50 == "pet_turbo") {
      self.petwatch.playerdatafield = "petWatchDataTurbo";
      thread turbopetchallengewatcher();
    } else
      self.petwatch.playerdatafield = "petWatchData";

    if(_id_C3D1929B58499072 && !istrue(_id_12DDBF4558CC0E91)) {
      self setclientomnvar("ui_pet_watch_action", -1);
      setphase(0);
    } else
      setphase(self getplayerdata("common", self.petwatch.playerdatafield, "phase"));
  } else {
    if(_id_C3D1929B58499072) {
      self setclientomnvar("ui_pet_watch_action", -1);
      setphase(0);
    }

    if(self.petwatch.phase == 0)
      resetpet(1);

    if(!istrue(_id_C3D1929B58499072))
      return;
  }

  self.petwatch.debugtimedelta = 0;

  if(self.petwatch.phase == 0)
    resetpet(1);
  else {
    self.petwatch.bonustime = 0;
    self.petwatch.bonustimeapplied = 0;
    self.petwatch.lastupdatetime = self getplayerdata("common", self.petwatch.playerdatafield, "lastUpdateTime");
    self.petwatch.bored = self getplayerdata("common", self.petwatch.playerdatafield, "boredDmg");
    self.petwatch.dirty = self getplayerdata("common", self.petwatch.playerdatafield, "dirtyDmg");
    self.petwatch.unruly = self getplayerdata("common", self.petwatch.playerdatafield, "unrulyDmg");
    self.petwatch.hungry = self getplayerdata("common", self.petwatch.playerdatafield, "hungryDmg");
    self.petwatch.bonustimeapplied = self getplayerdata("common", self.petwatch.playerdatafield, "bonusTime");
    self.petwatch.charged = self getplayerdata("common", self.petwatch.playerdatafield, "charged");
    self.petwatch.growthtime = self getplayerdata("common", self.petwatch.playerdatafield, "growthTime");
    self.petwatch.reproductionstreak = self getplayerdata("common", self.petwatch.playerdatafield, "reproductionStreak");
    self.petwatch.damage = self getplayerdata("common", self.petwatch.playerdatafield, "damage");
    self.petwatch.lastbored = self.petwatch.bored;
    self.petwatch.lastdirty = self.petwatch.dirty;
    self.petwatch.lastunruly = self.petwatch.unruly;
    self.petwatch.lasthungry = self.petwatch.hungry;
    _id_3F302E5360A8FCEC = self.petwatch.reproductionstreak % 10;
    _id_89C912C00B9CBCC8 = _id_3F302E5360A8FCEC / 10;
    self.petwatch.growthtime = self.petwatch.growthtime + _id_89C912C00B9CBCC8;
    self.petwatch.bonustimeapplied = self.petwatch.bonustimeapplied + _id_89C912C00B9CBCC8;
    self.petwatch.reproductionstreak = int(self.petwatch.reproductionstreak / 10);
    self.petwatch.unicornpoints = self getplayerdata("common", self.petwatch.playerdatafield, "orcaPoints");
    self.petwatch.vampirepoints = self getplayerdata("common", self.petwatch.playerdatafield, "apachePoints");
    self.petwatch.dragonpoints = self getplayerdata("common", self.petwatch.playerdatafield, "dragonPoints");
    self.petwatch.bonuskillstreakcharge = self getplayerdata("common", self.petwatch.playerdatafield, "killstreakCharge");
    self.petwatch.bonuswingamescharge = self getplayerdata("common", self.petwatch.playerdatafield, "winGamesCharge");
    self.petwatch.bonusobjectivescorecharge = self getplayerdata("common", self.petwatch.playerdatafield, "objectiveScoreCharge");
    self.petwatch.bonuskillscharge = self getplayerdata("common", self.petwatch.playerdatafield, "killsCharge");
    self.petwatch.topkillstreakcharge = self getplayerdata("common", self.petwatch.playerdatafield, "topKillstreakCharge");
    self.petwatch.nukecharge = self getplayerdata("common", self.petwatch.playerdatafield, "nukeCharge");
    self.petwatch.wingamestop3 = self getplayerdata("common", self.petwatch.playerdatafield, "winGamesTop3");
    self.petwatch.plantscharge = self getplayerdata("common", self.petwatch.playerdatafield, "plantsCharge");
    self.petwatch.executionscharge = self getplayerdata("common", self.petwatch.playerdatafield, "executionsCharge");
    self.petwatch.objectivescorecharge = 0;
    self.petwatch.killstreakcharge = 0;
    self.petwatch.wingamescharge = 0;
    self.petwatch.killscharge = 0;
    self.petwatch.lasthungryscore = 0;
    self.petwatch.lastboredscore = 0;
    self.petwatch.lastunrulyscore = 0;
    self.petwatch.lastdirtyscore = 0;
  }

  updateuistate();
}

gethours(time) {
  _id_030FECBC8F289EAB = 3600;
  return int(time / _id_030FECBC8F289EAB);
}

gethourtime(_id_C7C12DF76958C19B) {
  _id_030FECBC8F289EAB = 3600;
  _id_663ED12A0431A739 = 24 * _id_030FECBC8F289EAB;
  _id_E63DD21BF38DC550 = _id_663ED12A0431A739 * 365.25;
  _id_84A44D77D58A4989 = _id_C7C12DF76958C19B / int(_id_E63DD21BF38DC550);
  _id_B88CDD72B1D7D08E = int(_id_C7C12DF76958C19B % _id_E63DD21BF38DC550) / int(_id_663ED12A0431A739);
  hours = int(_id_C7C12DF76958C19B % _id_663ED12A0431A739) / int(_id_030FECBC8F289EAB);
  return int(hours);
}

testtiming() {
  _id_64F88D0441939203 = getsystemtime();
  _id_BF86F2C24693E09B = _id_64F88D0441939203 - 300;
  _id_BF81CFC2468D6ACB = _id_64F88D0441939203 - 7200;
  _id_C855B34135C24F2B = _id_64F88D0441939203 - 3480;
  _id_F3362E4154F3DEC0 = _id_64F88D0441939203 - 3720;
  _id_8EBE16410BB40212 = _id_64F88D0441939203 - 43200;
  _id_88911763074C226B = _id_64F88D0441939203 - 86400;
  _id_58C1838DB2A6595A = _id_88911763074C226B - 43200;
  _id_0F36BD4BF83FF5BD = _id_64F88D0441939203 - 604800;
  _id_85E9A613D1C4C14F = hoursawakesincelastupdate(_id_64F88D0441939203, _id_BF86F2C24693E09B).hours;
  _id_AD83E480F7B61231 = hoursawakesincelastupdate(_id_64F88D0441939203, _id_C855B34135C24F2B).hours;
  _id_24EDF68034EDB3A8 = hoursawakesincelastupdate(_id_64F88D0441939203, _id_F3362E4154F3DEC0).hours;
  _id_9C51C091DB48AB9F = hoursawakesincelastupdate(_id_64F88D0441939203, _id_BF81CFC2468D6ACB).hours;
  _id_9E33FD315E72164A = hoursawakesincelastupdate(_id_64F88D0441939203, _id_8EBE16410BB40212).hours;
  _id_F60FC0867426749E = hoursawakesincelastupdate(_id_64F88D0441939203, _id_88911763074C226B).hours;
  _id_39B990D611D4821F = hoursawakesincelastupdate(_id_64F88D0441939203, _id_58C1838DB2A6595A).hours;
  _id_47CCD2EC26D9D794 = hoursawakesincelastupdate(_id_64F88D0441939203, _id_0F36BD4BF83FF5BD).hours;
  _id_311AEE2291A94E17 = 1;
}

printplayerdatastats() {
  phase = self getplayerdata("common", self.petwatch.playerdatafield, "phase");
  lastupdatetime = self getplayerdata("common", self.petwatch.playerdatafield, "lastUpdateTime");
  bored = self getplayerdata("common", self.petwatch.playerdatafield, "boredDmg");
  dirty = self getplayerdata("common", self.petwatch.playerdatafield, "dirtyDmg");
  unruly = self getplayerdata("common", self.petwatch.playerdatafield, "unrulyDmg");
  hungry = self getplayerdata("common", self.petwatch.playerdatafield, "hungryDmg");
  bonustimeapplied = self getplayerdata("common", self.petwatch.playerdatafield, "bonusTime");
  charged = self getplayerdata("common", self.petwatch.playerdatafield, "charged");
  growthtime = self getplayerdata("common", self.petwatch.playerdatafield, "growthTime");
  reproductionstreak = self getplayerdata("common", self.petwatch.playerdatafield, "reproductionStreak");
  damage = self getplayerdata("common", self.petwatch.playerdatafield, "damage");
  unicornpoints = self getplayerdata("common", self.petwatch.playerdatafield, "orcaPoints");
  vampirepoints = self getplayerdata("common", self.petwatch.playerdatafield, "apachePoints");
  dragonpoints = self getplayerdata("common", self.petwatch.playerdatafield, "dragonPoints");
  killstreakcharge = self getplayerdata("common", self.petwatch.playerdatafield, "killstreakCharge");
  wingamescharge = self getplayerdata("common", self.petwatch.playerdatafield, "winGamesCharge");
  objectivescorecharge = self getplayerdata("common", self.petwatch.playerdatafield, "objectiveScoreCharge");
  killscharge = self getplayerdata("common", self.petwatch.playerdatafield, "killsCharge");
  topkillstreakcharge = self getplayerdata("common", self.petwatch.playerdatafield, "topKillstreakCharge");
  nukecharge = self getplayerdata("common", self.petwatch.playerdatafield, "nukeCharge");
  wingamestop3 = self getplayerdata("common", self.petwatch.playerdatafield, "winGamesTop3");
  plantscharge = self getplayerdata("common", self.petwatch.playerdatafield, "plantsCharge");
  executionscharge = self getplayerdata("common", self.petwatch.playerdatafield, "executionsCharge");
}

testpetdebug(_id_F01F2B519B66F760) {
  if(_id_F01F2B519B66F760 > 16 && !isDefined(self.petwatch))
    initpet(1, "pet_turbo");

  if(!isDefined(self.petwatch)) {
    return;
  }
  switch (_id_F01F2B519B66F760) {
    case 1:
      testtiming();
      break;
    case 2:
      printplayerdatastats();
      break;
    case 3:
      addkillcharge();
      break;
    case 4:
      addtenkillcharge();
      break;
    case 5:
      addobjectivescorecharge("debug", 1);
      break;
    case 6:
      addobjectivescorecharge("debug", 10);
      break;
    case 7:
      addwatchchargewin();
      break;
    case 8:
      addplantingcharge();
      break;
    case 9:
      addexecutioncharge();
      break;
    case 10:
      addwatchchargewintop3();
      break;
    case 11:
      addtopkillstreakcharge();
      break;
    case 12:
      addnukecharge();
      break;
    case 13:
      self.petwatch.damage = 0;
      updateuistate();
      break;
    case 14:
      self.petwatch.damage = 900;
      updateuistate();
      break;
    case 15:
      self.petwatch.damage = 500;
      updateuistate();
      break;
    case 16:
      addkillstreakcharge();
      break;
    case 17:
      self setclientomnvar("ui_smart_watch_interact", 2);
      break;
    case 18:
      self setclientomnvar("ui_smart_watch_interact", 3);
      break;
    case 19:
      self setclientomnvar("ui_smart_watch_interact", 4);
      break;
    case 20:
      self notify("luinotifyserver", "petwatch_turbo_grow", 1);
      break;
    case 21:
      self notify("luinotifyserver", "petwatch_turbo_grow", 2);
      break;
    case 22:
      self notify("luinotifyserver", "petwatch_turbo_grow", 3);
      break;
  }
}

hoursawakesincelastupdate(currenttime, lastupdatetime, _id_6BA7D3F06E41BE2B) {
  _id_E01AAC667D095892 = gethourtime(currenttime);
  _id_50C8ACB81BAF34AF = gethours(currenttime - lastupdatetime);
  _id_8A2748D84FA9AE30 = max(0, _id_50C8ACB81BAF34AF);
  _id_AC7AB45FB1212BA1 = spawnStruct();
  _id_AC7AB45FB1212BA1.hours = _id_8A2748D84FA9AE30;
  return _id_AC7AB45FB1212BA1;
}

updatepetstatesincelastupdate(_id_6BA7D3F06E41BE2B) {
  self endon("disconnect");
  return;
}

addthrowingknifecharge() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    self.petwatch.wingamescharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 80000 + self.petwatch.wingamescharge);
  }
}

addkillstreakcharge() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    self.petwatch.bonuskillstreakcharge++;
    self.petwatch.killstreakcharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 30000 + self.petwatch.killstreakcharge);
  }
}

addallkillstreaksunlockedinonelife() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo")
    self setclientomnvar("ui_pet_watch_bonus_earned_2", 20000);
}

addteabagcharge() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    self.petwatch.plantscharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 40000 + self.petwatch.plantscharge);
  }
}

addplundercarrycredit() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo")
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 40000);
}

addjuggernautcharge() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    self.petwatch.nukecharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_4", 10000 + self.petwatch.nukecharge);
  }
}

addvehicularmanslaughtercharge() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    self.petwatch.wingamestop3++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 90000 + self.petwatch.wingamestop3);
  }
}

getsubgametype() {
  gametype = level.gametype;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    _id_FAF0D2FAC3F47583 = getDvar("dvar_7611A2790A0BF7FE", "");

    if(_id_FAF0D2FAC3F47583 != "")
      return _id_FAF0D2FAC3F47583;
  }

  return gametype;
}

addtop3brcharge() {
  subtype = getsubgametype();

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (subtype == "br" || subtype == "aladdin" || subtype == "jugg" || subtype == "mini" || subtype == "mini_mgl")) {
    if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo")
      self setclientomnvar("ui_pet_watch_bonus_earned_1", 90000);
  }
}

addwatch2v2topscore() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo")
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 80000);
}

update2v2progress() {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
    return;
  }
  _id_B7AEC1031764930F = game["roundsPlayed"];

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_41095FCE198F513B = game["roundsWon"][_id_F90358454413407F];
    _id_6C8D21B2E54B2478 = _id_41095FCE198F513B / level.winlimit;
    players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](_id_F90358454413407F, "players");

    foreach(player in players) {
      if(isDefined(player.petwatch) && player.petwatch.petwatchtype == "pet_turbo")
        player tryupdategenericprogress(_id_6C8D21B2E54B2478, 2);
    }
  }
}

tryupdategenericprogress(progress, code) {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    progress = min(1.0, progress);
    self setclientomnvar("ui_pet_watch_bonus_earned_4", 50000 + int(progress * 10) + code * 100);
  }
}

trackcarpunches(car) {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    if(!isDefined(car.carpunchers)) {
      car.carpunchers = [];
      car.carpunchcount = [];
    }

    _id_4C98940B9E06B7F8 = -1;

    foreach(_id_AC0E594AC96AA3A8, _id_1138C1029FECAE7C in car.carpunchers) {
      if(_id_1138C1029FECAE7C == self) {
        _id_4C98940B9E06B7F8 = _id_AC0E594AC96AA3A8;
        break;
      }
    }

    if(_id_4C98940B9E06B7F8 == -1) {
      _id_4C98940B9E06B7F8 = car.carpunchers.size;
      car.carpunchers[_id_4C98940B9E06B7F8] = self;
      car.carpunchcount[_id_4C98940B9E06B7F8] = 1;
    } else
      car.carpunchcount[_id_4C98940B9E06B7F8]++;

    tryupdategenericprogress(car.carpunchcount[_id_4C98940B9E06B7F8] / 10, 3);
  }
}

checkcarpuncherprogressgeneric() {
  if(isDefined(self.carpunchers)) {
    _id_BB67F9136F0DD9FE = 0;

    foreach(_id_AC0E594AC96AA3A8, _id_1138C1029FECAE7C in self.carpunchers) {
      _id_1E47E3DB30463930 = isDefined(_id_1138C1029FECAE7C.petwatch) && _id_1138C1029FECAE7C.petwatch.petwatchtype == "pet_turbo";

      if(!_id_1E47E3DB30463930) {
        continue;
      }
      _id_BB67F9136F0DD9FE = self.carpunchcount[_id_AC0E594AC96AA3A8];

      if(_id_BB67F9136F0DD9FE >= 10)
        _id_1138C1029FECAE7C setclientomnvar("ui_pet_watch_bonus_earned_1", 10000);
    }
  }
}

checkcarpuncherprogress(car) {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    if(isDefined(car.carpunchers)) {
      _id_BB67F9136F0DD9FE = 0;

      foreach(_id_AC0E594AC96AA3A8, _id_1138C1029FECAE7C in car.carpunchers) {
        if(_id_1138C1029FECAE7C == self) {
          _id_BB67F9136F0DD9FE = car.carpunchcount[_id_AC0E594AC96AA3A8];
          break;
        }
      }

      if(_id_BB67F9136F0DD9FE >= 10)
        self setclientomnvar("ui_pet_watch_bonus_earned_1", 10000);
    }
  }
}

addnukecharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.nukecharge++;
    code = 10000 + self.petwatch.nukecharge;

    if(self.petwatch.petwatchtype == "pet_turbo")
      code = code + 100;

    self setclientomnvar("ui_pet_watch_bonus_earned_4", code);
  }
}

addtopkillstreakcharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.topkillstreakcharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_2", 20000 + self.petwatch.topkillstreakcharge);
  }
}

addallkillstreaksunlocked() {
  if(isDefined(self.petwatch))
    self setclientomnvar("ui_pet_watch_bonus_earned_2", 20001);
}

addplantingcharge() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype != "pet_turbo") {
    self.petwatch.plantscharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 40000 + self.petwatch.plantscharge);
  }
}

addobjectivescorecharge(event, _id_353F1E80E9476419, _id_7EC7671A1E0C788F) {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype != "pet_turbo") {
    if(istrue(level.petobjectivefilter[event])) {
      return;
    }
    if(event == "stat_EF9582D72160F199") {
      return;
    }
    if(isDefined(_id_7EC7671A1E0C788F)) {
      if(istrue(_id_7EC7671A1E0C788F._id_E62CEEEE8B598809)) {
        return;
      }
      if(istrue(_id_7EC7671A1E0C788F._id_E0BADEC2B1517CA3))
        return;
    }

    self.petwatch.bonusobjectivescorecharge = self.petwatch.bonusobjectivescorecharge + _id_353F1E80E9476419;
    self.petwatch.objectivescorecharge = self.petwatch.objectivescorecharge + _id_353F1E80E9476419;
    self setclientomnvar("ui_pet_watch_bonus_earned_3", 50000 + self.petwatch.objectivescorecharge);
  }
}

addtenkillcharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.killscharge = self.petwatch.killscharge + 10;
    self.petwatch.bonuskillscharge = self.petwatch.bonuskillscharge + 10;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 60000 + self.petwatch.killscharge);
  }
}

addkillcharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.killscharge++;
    self.petwatch.bonuskillscharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 60000 + self.petwatch.killscharge);
  }
}

addexecutioncharge() {
  if(isDefined(self.petwatch)) {
    self.petwatch.executionscharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 70000 + self.petwatch.executionscharge);
  }
}

addwatchchargewin() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype != "pet_turbo") {
    self.petwatch.bonuswingamescharge++;
    self.petwatch.wingamescharge++;
    self setclientomnvar("ui_pet_watch_bonus_earned_0", 80000 + self.petwatch.wingamescharge);
    feedaction();
  }
}

addwatchchargewintop3() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype != "pet_turbo") {
    self.petwatch.wingamestop3++;
    self setclientomnvar("ui_pet_watch_bonus_earned_1", 90000 + self.petwatch.wingamestop3);
  }
}

petplundertimer() {
  self endon("disconnect");
  self endon("cancel_pet_plunder_timer");
  self.petwatch.plundertimer = 1;
  totaltime = 180.0;
  _id_AB255606FAB17DBC = totaltime / 5;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 5; _id_AC0E594AC96AA3A8++) {
    wait(_id_AB255606FAB17DBC);
    tryupdategenericprogress(_id_AC0E594AC96AA3A8 / 5, 4);
  }

  addplundercarrycredit();
}

updatenukeprogress(progress) {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo")
    tryupdategenericprogress(progress, 1);
}

onplayergetsplunder() {
  if(isDefined(self.petwatch) && self.petwatch.petwatchtype == "pet_turbo") {
    if(self.plundercount > 5000) {
      if(!isDefined(self.petwatch.plundertimer))
        thread petplundertimer();
    } else if(isDefined(self.petwatch.plundertimer)) {
      self notify("cancel_pet_plunder_timer");
      self.petwatch.plundertimer = undefined;
      tryupdategenericprogress(0, 0);
    }
  }
}

setphase(phase) {
  self.petwatch.phase = phase;
  self.pers["petWatchData_phase"] = phase;
}

updateuistate() {
  _id_3A7747BC9807F3C0 = 0;

  if(self.petwatch.bored < 0)
    _id_3A7747BC9807F3C0 = _id_3A7747BC9807F3C0 + 20;

  if(self.petwatch.dirty < 0)
    _id_3A7747BC9807F3C0 = _id_3A7747BC9807F3C0 + 100;

  if(self.petwatch.unruly < 0)
    _id_3A7747BC9807F3C0 = _id_3A7747BC9807F3C0 + 1000;

  if(self.petwatch.hungry < 0)
    _id_3A7747BC9807F3C0 = _id_3A7747BC9807F3C0 + 10000;

  _id_D6B7105506475DB1 = int(self.petwatch.damage / 100) - 1;
  _id_D6B7105506475DB1 = int(max(0, min(_id_D6B7105506475DB1, 9)));
  _id_3A7747BC9807F3C0 = _id_3A7747BC9807F3C0 + 100000 * _id_D6B7105506475DB1;
  state = _id_3A7747BC9807F3C0 + self.petwatch.phase;
  self setclientomnvar("ui_pet_watch_state", state);
}

resetpetstats() {
  self.petwatch.bored = level.petconsts[self.petwatch.phase].boredstart;
  self.petwatch.dirty = level.petconsts[self.petwatch.phase].dirtystart;
  self.petwatch.unruly = level.petconsts[self.petwatch.phase].unrulystart;
  self.petwatch.hungry = level.petconsts[self.petwatch.phase].hungrystart;
  self.petwatch.lasthungryscore = 0;
  self.petwatch.lastboredscore = 0;
  self.petwatch.lastunrulyscore = 0;
  self.petwatch.lastdirtyscore = 0;
  self.petwatch.charged = 0;
  self.petwatch.growthtime = 0;
  self.petwatch.bonustimeapplied = 0;
  self.petwatch.bonustime = 0;
  self.petwatch.damage = 0;
  self.petwatch.unicornpoints = 0;
  self.petwatch.vampirepoints = 0;
  self.petwatch.dragonpoints = 0;
  self.petwatch.bonuskillstreakcharge = 0;
  self.petwatch.killstreakcharge = 0;
  self.petwatch.bonuswingamescharge = 0;
  self.petwatch.wingamescharge = 0;
  self.petwatch.bonusobjectivescorecharge = 0;
  self.petwatch.objectivescorecharge = 0;
  self.petwatch.bonuskillscharge = 0;
  self.petwatch.killscharge = 0;
  self.petwatch.topkillstreakcharge = 0;
  self.petwatch.nukecharge = 0;
  self.petwatch.wingamestop3 = 0;
  self.petwatch.plantscharge = 0;
  self.petwatch.executionscharge = 0;
}

resetpet(_id_801259433DADB5E0, _id_D4C366276174EF4C) {
  if(isDefined(_id_D4C366276174EF4C))
    setphase(_id_D4C366276174EF4C);
  else
    setphase(1);

  self.petwatch.lastupdatetime = getsystemtime();
  resetpetstats();
}

debugsetlasttime(hours) {
  self setclientomnvar("ui_pet_watch_action", hours);
}

feedaction() {
  if(!isDefined(self.petwatch)) {
    return;
  }
  if(self.petwatch.petwatchtype == "pet_turbo") {
    return;
  }
  if(self.petwatch.phase == 15) {
    return;
  }
  _id_68F4532AE38C7889 = self.petwatch.killstreakcharge * 20;
  _id_B3047D81080C48B3 = self.petwatch.wingamescharge * 20;
  _id_10DA2B565B61AB1E = self.petwatch.objectivescorecharge * 0.5;
  _id_CC874F65D38801B2 = self.petwatch.killscharge * 1;
  _id_E4DE697FECF32054 = self.petwatch.lasthungryscore < _id_CC874F65D38801B2;
  _id_8DBC9F460C6FC36D = self.petwatch.lastdirtyscore < _id_B3047D81080C48B3;
  _id_9635660A6EB2D37F = self.petwatch.lastboredscore < _id_68F4532AE38C7889;
  _id_B2F5DEBAC3F6EE00 = self.petwatch.lastunrulyscore < _id_10DA2B565B61AB1E;

  if(!_id_E4DE697FECF32054 && !_id_8DBC9F460C6FC36D && !_id_9635660A6EB2D37F && !_id_B2F5DEBAC3F6EE00) {
    return;
  }
  _id_68F4532AE38C7889 = max(-240, min(_id_68F4532AE38C7889, 240));
  _id_B3047D81080C48B3 = max(-240, min(_id_B3047D81080C48B3, 240));
  _id_10DA2B565B61AB1E = max(-240, min(_id_10DA2B565B61AB1E, 240));
  _id_CC874F65D38801B2 = max(-240, min(_id_CC874F65D38801B2, 240));

  if(_id_8DBC9F460C6FC36D) {
    _id_B3047D81080C48B3 = int(_id_B3047D81080C48B3);

    if(_id_B3047D81080C48B3 == 0)
      _id_B3047D81080C48B3 = 1;

    self setclientomnvar("ui_pet_watch_health_dirty", _id_B3047D81080C48B3);
  }

  if(_id_B2F5DEBAC3F6EE00) {
    _id_10DA2B565B61AB1E = int(_id_10DA2B565B61AB1E);

    if(_id_10DA2B565B61AB1E == 0)
      _id_10DA2B565B61AB1E = 1;

    self setclientomnvar("ui_pet_watch_health_unruly", int(_id_10DA2B565B61AB1E));
  }

  if(_id_E4DE697FECF32054) {
    _id_CC874F65D38801B2 = int(_id_CC874F65D38801B2);

    if(_id_CC874F65D38801B2 == 0)
      _id_CC874F65D38801B2 = 1;

    self setclientomnvar("ui_pet_watch_health_hungry", int(_id_CC874F65D38801B2));
  }

  if(_id_9635660A6EB2D37F) {
    _id_68F4532AE38C7889 = int(_id_68F4532AE38C7889);

    if(_id_68F4532AE38C7889 == 0)
      _id_68F4532AE38C7889 = 1;

    self setclientomnvar("ui_pet_watch_health_bored", int(_id_68F4532AE38C7889));
  }

  self.petwatch.lasthungryscore = _id_CC874F65D38801B2;
  self.petwatch.lastdirtyscore = _id_B3047D81080C48B3;
  self.petwatch.lastboredscore = _id_68F4532AE38C7889;
  self.petwatch.lastunrulyscore = _id_10DA2B565B61AB1E;
  self.petwatch.topkillstreakcharge = 0;
  self.petwatch.nukecharge = 0;
  self.petwatch.wingamestop3 = 0;
  self.petwatch.plantscharge = 0;
  self.petwatch.executionscharge = 0;
  self.petwatch.bored = _id_68F4532AE38C7889;
  self.petwatch.dirty = _id_B3047D81080C48B3;
  self.petwatch.unruly = _id_10DA2B565B61AB1E;
  self.petwatch.hungry = _id_CC874F65D38801B2;
}