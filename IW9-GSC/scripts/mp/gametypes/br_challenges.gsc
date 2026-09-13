/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_challenges.gsc
**************************************************/

init() {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    return;
  }
  registerchallenge("br_mastery_fiveContracts", ::fivecontracts);
  registerchallenge("br_mastery_pointBlank_airstrike", ::pointblank_airstrike);
  registerchallenge("br_mastery_pointBlank_tomahawk", ::pointblank_tomahawk);
  registerchallenge("br_mastery_c4VehicleMultKill", ::c4vehiclemultkill);
  registerchallenge("br_mastery_ghostRideWhip", ::ghostridewhip);
  registerchallenge("br_mastery_roundKillExecute", ::roundkillexecute);
}

registerchallenge(_id_A5CB6F1F6ABE070B, _id_242DD1075B2CDD44) {
  if(!isDefined(level.br_challenges))
    level.br_challenges = [];

  level.br_challenges[_id_A5CB6F1F6ABE070B] = _id_242DD1075B2CDD44;
}

challengeevaluator(_id_A5CB6F1F6ABE070B, _id_CD37CE775909957B) {
  if(!isDefined(level.br_challenges)) {
    return;
  }
  _id_242DD1075B2CDD44 = level.br_challenges[_id_A5CB6F1F6ABE070B];

  if(isDefined(_id_242DD1075B2CDD44))
    self thread[[_id_242DD1075B2CDD44]](_id_A5CB6F1F6ABE070B, _id_CD37CE775909957B);
}

awardmasterychallenge(_id_A5CB6F1F6ABE070B) {
  if(getdvarint("dvar_AD789C41A11E3F59", 0))
    iprintlnbold("Mastery Challenge: " + _id_A5CB6F1F6ABE070B + " completed!");

  scripts\cp_mp\challenges::oncollectitem(_id_A5CB6F1F6ABE070B);
}

fivecontracts(_id_A5CB6F1F6ABE070B, _id_CD37CE775909957B) {
  if(!isDefined(self.team)) {
    return;
  }
  if(_id_1E4A61DB11011446::get_int_or_0(self.brmissionscompleted) < 5) {
    return;
  }
  _id_A11643FDEEDEE81B = isDefined(level.gulag) && !istrue(level.gulag.shutdown);

  foreach(player in level.teamdata[self.team]["players"]) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      return;
    }
    if(_id_A11643FDEEDEE81B && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
      return;
  }

  awardmasterychallenge(_id_A5CB6F1F6ABE070B);
}

pointblank_airstrike(_id_A5CB6F1F6ABE070B, _id_CD37CE775909957B) {
  plane = _id_CD37CE775909957B.plane;
  targetsite = _id_CD37CE775909957B.targetsite;

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
  scripts\engine\utility::waittill_any_timeout_1(10.0, "airstrike_finished_" + plane.airstrikeid);

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  if(streakinfo.kills >= 3)
    awardmasterychallenge("br_mastery_pointBlankStreakKill");
}

pointblank_tomahawk(_id_A5CB6F1F6ABE070B, _id_CD37CE775909957B) {
  _id_490FE8AE7B774EB8 = _id_CD37CE775909957B.streakinfo;
  targetsite = _id_CD37CE775909957B.targetsite;

  if(!isDefined(_id_490FE8AE7B774EB8)) {
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

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  if(_id_490FE8AE7B774EB8.kills >= 3)
    awardmasterychallenge("br_mastery_pointBlankStreakKill");

  return;
}

c4vehiclemultkill(_id_A5CB6F1F6ABE070B, _id_CD37CE775909957B) {
  meansofdeath = _id_CD37CE775909957B.meansofdeath;
  inflictor = _id_CD37CE775909957B.inflictor;

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

  if(!isDefined(self.recentc4vehiclekillcount))
    self.recentc4vehiclekillcount = 0;

  self.recentc4vehiclekillcount++;
  wait 4.0;

  if(isDefined(self.recentc4vehiclekillcount) && self.recentc4vehiclekillcount >= 3) {
    awardmasterychallenge(_id_A5CB6F1F6ABE070B);
    _id_A93943361D672DFB = c4vehiclecooperator(inflictor);
    issameteam = isDefined(_id_A93943361D672DFB) && isDefined(_id_A93943361D672DFB.team) && isDefined(self.team) && _id_A93943361D672DFB.team == self.team;

    if(issameteam)
      _id_A93943361D672DFB awardmasterychallenge(_id_A5CB6F1F6ABE070B);
  }

  self.recentc4vehiclekillcount = undefined;
}

isvalidinflictorc4vehicle(inflictor) {
  if(!isDefined(inflictor))
    return 0;

  if(isDefined(inflictor.vehiclename) && !inflictor scripts\common\vehicle_code::vehicle_is_stopped()) {
    children = inflictor getlinkedchildren();

    foreach(child in children) {
      if(isDefined(child.weapon_name) && child.weapon_name == "c4_mp")
        return 1;
    }
  } else if(isDefined(inflictor.weapon_name) && inflictor.weapon_name == "c4_mp") {
    parent = inflictor getlinkedparent();

    if(isDefined(parent) && isDefined(parent.vehiclename) && !parent scripts\common\vehicle_code::vehicle_is_stopped())
      return 1;
  }

  return 0;
}

c4vehiclecooperator(inflictor) {
  if(isDefined(inflictor) && isDefined(inflictor.weapon_name) && inflictor.weapon_name == "c4_mp") {
    parent = inflictor getlinkedparent();

    if(isDefined(parent))
      return parent.owner;
  }

  return undefined;
}

roundkillexecute(_id_A5CB6F1F6ABE070B, _id_CD37CE775909957B) {
  awardmasterychallenge("br_mastery_roundKillExecute");
}

ghostridewhip(_id_A5CB6F1F6ABE070B, _id_CD37CE775909957B) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }
  exitdriver = _id_CD37CE775909957B.exitdriver;
  maderecentkill = _id_CD37CE775909957B.maderecentkill;

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

  if(!isDefined(self.recentghostridekillcount))
    self.recentghostridekillcount = 0;

  if(istrue(maderecentkill))
    self.recentghostridekillcount++;

  wait 4.0;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.recentghostridekillcount) && self.recentghostridekillcount >= 3)
    awardmasterychallenge(_id_A5CB6F1F6ABE070B);

  self.recentghostridekillcount = undefined;
  self.hasexiteddriver = undefined;
}