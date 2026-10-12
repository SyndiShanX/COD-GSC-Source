/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_challenges.gsc
**************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\vehicle_code;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace br_challenges;

function init() {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  registerchallenge("br_mastery_fiveContracts", &fivecontracts);
  registerchallenge("br_mastery_pointBlank_airstrike", &pointblank_airstrike);
  registerchallenge("br_mastery_pointBlank_tomahawk", &pointblank_tomahawk);
  registerchallenge("br_mastery_c4VehicleMultKill", &c4vehiclemultkill);
  registerchallenge("br_mastery_ghostRideWhip", &ghostridewhip);
  registerchallenge("br_mastery_roundKillExecute", &roundkillexecute);
}

function registerchallenge(challengeref, challengefunc) {
  if(!isDefined(level.br_challenges)) {
    level.br_challenges = [];
  }

  assertex(!isDefined(level.br_challenges[challengeref]), "<dev string:x1c>" + challengeref + "<dev string:x2e>");
  level.br_challenges[challengeref] = challengefunc;
}

function challengeevaluator(challengeref, paramstruct) {
  assert(isDefined(challengeref));

  if(!isDefined(level.br_challenges)) {
    return;
  }

  challengefunc = level.br_challenges[challengeref];

  if(isDefined(challengefunc)) {
    self thread[[challengefunc]](challengeref, paramstruct);
  }
}

function awardmasterychallenge(challengeref) {
  if(getdvarint(@ "hash_ad789c41a11e3f59", 0)) {
    iprintlnbold("Mastery Challenge: " + challengeref + " completed!");
  }

  scripts\cp_mp\challenges::oncollectitem(challengeref);
}

function fivecontracts(challengeref, paramstruct) {
  if(!isDefined(self.team)) {
    return;
  }

  if(get_int_or_0(self.brmissionscompleted) < 5) {
    return;
  }

  var_a11643fdeedee81b = isDefined(level.gulag) && !istrue(level.gulag.shutdown);

  foreach(player in level.teamdata[self.team]["players"]) {
    if(!isreallyalive(player)) {
      return;
    }

    if(var_a11643fdeedee81b && player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
      return;
    }
  }

  awardmasterychallenge(challengeref);
}

function pointblank_airstrike(challengeref, paramstruct) {
  plane = paramstruct.plane;
  targetsite = paramstruct.targetsite;

  if(!isDefined(plane) || !isDefined(plane.airstrikeid) || !isDefined(plane.streakinfo) || !isDefined(targetsite)) {
    return;
  }

  streakinfo = plane.streakinfo;

  if(distancesquared(self.origin, targetsite) > squared(432)) {
    return;
  }

  self endon("death_or_disconnect");
  self notify("pointBlank_airstrike_killtracker");
  self endon("pointBlank_airstrike_killtracker");
  waittill_any_timeout_1(10, "airstrike_finished_" + plane.airstrikeid);

  if(!isreallyalive(self)) {
    return;
  }

  if(getdvarint(@ "hash_ad789c41a11e3f59", 0)) {
    iprintlnbold("<dev string:x44>" + challengeref + "<dev string:x5b>" + streakinfo.kills);
  }

  if(streakinfo.kills >= 3) {
    awardmasterychallenge("br_mastery_pointBlankStreakKill");
  }
}

function pointblank_tomahawk(challengeref, paramstruct) {
  instreak = paramstruct.streakinfo;
  targetsite = paramstruct.targetsite;

  if(!isDefined(instreak)) {
    return;
  }

  if(!isDefined(targetsite)) {
    return;
  }

  if(distancesquared(self.origin, targetsite) > squared(432)) {
    return;
  }

  self endon("death_or_disconnect");
  self notify("pointBlank_tomahawk_killtracker");
  self endon("pointBlank_tomahawk_killtracker");
  scripts\engine\utility::waittill_any_timeout_2(20, "cluster_strike_finished");

  if(!isreallyalive(self)) {
    return;
  }

  if(getdvarint(@ "hash_ad789c41a11e3f59", 0)) {
    iprintlnbold("<dev string:x44>" + challengeref + "<dev string:x5b>" + instreak.kills);
  }

  if(instreak.kills >= 3) {
    awardmasterychallenge("br_mastery_pointBlankStreakKill");
  }
}

function c4vehiclemultkill(challengeref, paramstruct) {
  meansofdeath = paramstruct.meansofdeath;
  inflictor = paramstruct.inflictor;

  if(!isDefined(meansofdeath) || meansofdeath != "MOD_EXPLOSIVE") {
    return;
  }

  if(!isvalidinflictorc4vehicle(inflictor)) {
    return;
  }

  self endon("disconnect");
  level endon("game_ended");
  self notify("updateC4VehicleMultKill");
  self endon("updateC4VehicleMultKill");

  if(!isDefined(self.recentc4vehiclekillcount)) {
    self.recentc4vehiclekillcount = 0;
  }

  self.recentc4vehiclekillcount++;
  wait 4;

  if(getdvarint(@ "hash_ad789c41a11e3f59", 0) && isDefined(self.recentc4vehiclekillcount)) {
    iprintlnbold("<dev string:x44>" + challengeref + "<dev string:x5b>" + self.recentc4vehiclekillcount);
  }

  if(isDefined(self.recentc4vehiclekillcount) && self.recentc4vehiclekillcount >= 3) {
    awardmasterychallenge(challengeref);
    cooperator = c4vehiclecooperator(inflictor);
    issameteam = isDefined(cooperator) && isDefined(cooperator.team) && isDefined(self.team) && cooperator.team == self.team;

    if(issameteam) {
      cooperator awardmasterychallenge(challengeref);
    }
  }

  self.recentc4vehiclekillcount = undefined;
}

function isvalidinflictorc4vehicle(inflictor) {
  if(!isDefined(inflictor)) {
    return false;
  }

  if(isDefined(inflictor.vehiclename) && !inflictor vehicle_is_stopped()) {
    children = inflictor getlinkedchildren();

    foreach(child in children) {
      if(isDefined(child.weapon_name) && child.weapon_name == "c4_mp") {
        return true;
      }
    }
  } else if(isDefined(inflictor.weapon_name) && inflictor.weapon_name == "c4_mp") {
    parent = inflictor getlinkedparent();

    if(isDefined(parent) && isDefined(parent.vehiclename) && !parent vehicle_is_stopped()) {
      return true;
    }
  }

  return false;
}

function c4vehiclecooperator(inflictor) {
  if(isDefined(inflictor) && isDefined(inflictor.weapon_name) && inflictor.weapon_name == "c4_mp") {
    parent = inflictor getlinkedparent();

    if(isDefined(parent)) {
      return parent.owner;
    }
  }

  return undefined;
}

function roundkillexecute(challengeref, paramstruct) {
  awardmasterychallenge("br_mastery_roundKillExecute");
}

function ghostridewhip(challengeref, paramstruct) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }

  exitdriver = paramstruct.exitdriver;
  maderecentkill = paramstruct.maderecentkill;

  if(istrue(exitdriver)) {
    if(istrue(self.hasexiteddriver) && self.recentghostridekillcount != 0) {
      return;
    }

    self.hasexiteddriver = 1;
  }

  if(!istrue(self.hasexiteddriver)) {
    return;
  }

  self notify("ghostRideWhip");
  self endon("ghostRideWhip");

  if(!isDefined(self.recentghostridekillcount)) {
    self.recentghostridekillcount = 0;
  }

  if(istrue(maderecentkill)) {
    self.recentghostridekillcount++;
  }

  wait 4;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.recentghostridekillcount) && self.recentghostridekillcount >= 3) {
    awardmasterychallenge(challengeref);
  }

  self.recentghostridekillcount = undefined;
  self.hasexiteddriver = undefined;
}