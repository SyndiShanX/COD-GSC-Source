/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_killstreaks.gsc
********************************************************/

#include maps\_utility;
#include maps\_hud_util;
#include common_scripts\utility;

KILLSTREAK_STRING_TABLE = "sp/killstreakTable.csv";

init() {
  precacheString(&"MP_KILLSTREAK_N");

  initKillstreakData();

  level.killstreakFuncs = [];
  level.killstreakSetupFuncs = [];

  thread maps\_killstreak_ac130::init();

  thread maps\_killstreak_autosentry::init();
}

initKillstreakData() {
  for(i = 1; true; i++) {
    retVal = tableLookup(KILLSTREAK_STRING_TABLE, 0, i, 1);
    if(!isDefined(retVal) || retVal == "") {
      break;
    }

    streakRef = tableLookup(KILLSTREAK_STRING_TABLE, 0, i, 1);
    assert(streakRef != "");

    streakUseHint = tableLookupIString(KILLSTREAK_STRING_TABLE, 0, i, 6);

    assert(streakUseHint != &"");
    precacheString(streakUseHint);

    streakFailHint = tableLookupIString(KILLSTREAK_STRING_TABLE, 0, i, 11);

    assert(streakFailHint != &"");
    precacheString(streakFailHint);

    streakFriendlyUseDialog = tableLookup(KILLSTREAK_STRING_TABLE, 0, i, 9);
    assert(streakFriendlyUseDialog != "");
    game["dialog"][streakRef + "_inbound"] = streakFriendlyUseDialog;

    streakWeapon = tableLookup(KILLSTREAK_STRING_TABLE, 0, i, 12);
    if(streakWeapon != "")
      precacheItem(streakWeapon);

    streakPoints = int(tableLookup(KILLSTREAK_STRING_TABLE, 0, i, 13));
    assert(streakPoints != 0);
    maps\_rank::registerScoreInfo("killstreak_" + streakRef, streakPoints);
  }
}

onPlayerSpawned() {
  self giveOwnedKillstreakItem();
  self thread killstreakUseWaiter();
}

isRideKillstreak(streakName) {
  switch (streakName) {
    case "helicopter_minigun":
    case "helicopter_mk19":
      return true;

    default:
      return false;
  }
}

killstreakUsePressed() {
  streakName = self.pers["killstreak"];

  assert(isDefined(streakName));
  assert(isDefined(level.killstreakFuncs[streakName]));

  if(isDefined(self.carryObject) && isRideKillstreak(streakName)) {
    iprintlnbold("Killstreak unavailable while holding bomb.");
  } else if(self[[level.killstreakFuncs[streakName]]]()) {
    team = self.team;

    self playLocalSound("weap_c4detpack_trigger_plr");

    self.pers["killstreak"] = undefined;
  } else if(isDefined(level.killstreakFuncs[streakName + "_failed"])) {
    self[[level.killstreakFuncs[streakName + "_failed"]]]();
  } else {
    iprintlnbold(getKillstreakFailHint(streakName));
  }
}

killstreakUseWaiter() {
  self endon("death");

  self notifyOnPlayerCommand("use killstreak", "+actionslot 4");

  for(;;) {
    self waittill("use killstreak");

    if(!isAlive(self)) {
      continue;
    }
    if(isDefined(self.canUseKillstreaks) && !self.canUseKillstreaks) {
      continue;
    }
    if(isDefined(self.placingSentry)) {
      continue;
    }
    if(!isDefined(self.pers["killstreak"])) {
      continue;
    }
    self killstreakUsePressed();
  }
}

checkKillstreakReward(streakCount) {
  streak = streakCount;

  if(streak < 3) {
    return;
  }
  if(!isDefined(self.killStreaks[streak])) {
    if(streak >= 10 && (streak % 5 == 0))
      self streakNotify(streak);
    return;
  }

  self tryGiveKillstreak(self.killStreaks[streak], streak);
}

streakNotify(streakVal) {
  self endon("disconnect");

  wait .05;

  notifyData = spawnStruct();

  notifyData.titleLabel = &"MP_KILLSTREAK_N";
  notifyData.titleText = streakVal;

  self maps\_rank::notifyMessage(notifyData);
}

rewardNotify(streakName, streakVal) {
  self endon("disconnect");

  wait .05;

  notifyData = spawnStruct();

  notifyData.titleLabel = &"MP_KILLSTREAK_N";
  notifyData.titleText = streakVal;
  notifyData.notifyText = getKillstreakHint(streakName);
  notifyData.textIsString = true;

  notifyData.leaderSound = streakName;

  self maps\_rank::notifyMessage(notifyData);
}

tryGiveKillstreak(streakName, streakVal) {
  if(!isDefined(level.killstreakFuncs[streakName]))
    return false;

  if(isDefined(self.selectingLocation))
    return false;

  if(isDefined(self.pers["killstreak"])) {
    if(getStreakCost(streakName) < getStreakCost(self.pers["killstreak"]))
      return false;
  }

  self thread rewardNotify(streakName, streakVal);
  self giveKillstreak(streakName);
  return true;
}

giveKillstreak(streakName) {
  self notify("got_killstreak", streakName);

  weapon = getKillstreakWeapon(streakName);

  if(weapon != "") {
    self giveKillstreakWeapon(weapon);
  } else {
    self setActionSlot(4, "");
  }

  self.pers["killstreak"] = streakName;

  if(isDefined(level.killstreakSetupFuncs[streakName]))
    self[[level.killstreakSetupFuncs[streakName]]]();
}

giveKillstreakWeapon(weapon) {
  self giveWeapon(weapon);
  self setActionSlot(4, "weapon", weapon);
}

getStreakCost(streakName) {
  if(is_coop())
    return int(tableLookup(KILLSTREAK_STRING_TABLE, 1, streakName, 5));
  else
    return int(tableLookup(KILLSTREAK_STRING_TABLE, 1, streakName, 4));
}

getKillstreakHint(streakName) {
  return tableLookupIString(KILLSTREAK_STRING_TABLE, 1, streakName, 6);
}

getKillstreakFailHint(streakName) {
  return tableLookupIString(KILLSTREAK_STRING_TABLE, 1, streakName, 11);
}

getKillstreakSound(streakName) {
  return tableLookup(KILLSTREAK_STRING_TABLE, 1, streakName, 7);
}

getKillstreakDialog(streakName) {
  return tableLookup(KILLSTREAK_STRING_TABLE, 1, streakName, 8);
}

getKillstreakWeapon(streakName) {
  return tableLookup(KILLSTREAK_STRING_TABLE, 1, streakName, 12);
}

giveOwnedKillstreakItem() {
  if(isDefined(self.pers["killstreak"]))
    self giveKillstreak(self.pers["killstreak"]);
}

setKillstreaks(streak1, streak2, streak3) {
  self.killStreaks = [];

  if(streak1 != "none") {
    streakVal = maps\_killstreaks::getStreakCost(streak1);
    assertEx(isDefined(streakVal) && streakVal != 0, "ERROR: invalid killstreak " + streak1);
    self.killStreaks[streakVal] = streak1;
  }

  if(streak2 != "none") {
    streakVal = maps\_killstreaks::getStreakCost(streak2);
    assertEx(isDefined(streakVal) && streakVal != 0, "ERROR: invalid killstreak " + streak2);
    self.killStreaks[streakVal] = streak2;
  }

  if(streak3 != "none") {
    streakVal = maps\_killstreaks::getStreakCost(streak3);
    assertEx(isDefined(streakVal) && streakVal != 0, "ERROR: invalid killstreak " + streak3);
    self.killStreaks[streakVal] = streak3;
  }
}