/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\sentientpoolmanager.gsc
***********************************************/

init() {
  createthreatbiasgroup("Tactical_Static");
  createthreatbiasgroup("Tactical_Moving");
  createthreatbiasgroup("Lethal_Static");
  createthreatbiasgroup("Lethal_Moving");
  createthreatbiasgroup("Level_Vehicle");
  createthreatbiasgroup("Killstreak_Static");
  createthreatbiasgroup("Killstreak_Air");
  createthreatbiasgroup("Killstreak_Ground");
  createthreatbiasgroup("Drone");
  setignoremegroup("Killstreak_Ground", "Killstreak_Ground");
  setignoremegroup("Killstreak_Air", "Killstreak_Ground");
  setignoremegroup("Killstreak_Air", "Killstreak_Air");
  setignoremegroup("Killstreak_Ground", "Killstreak_Air");
  level.sentientpools = [];
  level.sentientpools[level.sentientpools.size] = "Tactical_Static";
  level.sentientpools[level.sentientpools.size] = "Tactical_Moving";
  level.sentientpools[level.sentientpools.size] = "Lethal_Static";
  level.sentientpools[level.sentientpools.size] = "Lethal_Moving";
  level.sentientpools[level.sentientpools.size] = "Level_Vehicle";
  level.sentientpools[level.sentientpools.size] = "Killstreak_Static";
  level.sentientpools[level.sentientpools.size] = "Killstreak_Air";
  level.sentientpools[level.sentientpools.size] = "Killstreak_Ground";
  level.sentientpools[level.sentientpools.size] = "Drone";
  level.activesentients = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.sentientpools.size; _id_AC0E594AC96AA3A8++)
    level.activesentients[level.sentientpools[_id_AC0E594AC96AA3A8]] = [];
}

registersentient(threatbiasgroup, _id_5C00772332CE642C, _id_4918B66CEBC7FBE7, _id_5F6534AD3A0A1FA2, _id_719C179EABB70B31, _id_8928FDF873929E88) {
  _id_EE6F4AF9861DF2AB = -1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.sentientpools.size; _id_AC0E594AC96AA3A8++) {
    if(level.sentientpools[_id_AC0E594AC96AA3A8] == threatbiasgroup) {
      _id_EE6F4AF9861DF2AB = _id_AC0E594AC96AA3A8;
      break;
    }
  }

  if(_id_EE6F4AF9861DF2AB == -1) {
    return;
  }
  if(isDefined(self.sentientpool)) {
    return;
  }
  _id_1B4129AC518DEA9B = getsentientcounts();
  _id_761770FEDE046A2F = getsentientlimits();

  if(_id_1B4129AC518DEA9B["other"] + _id_1B4129AC518DEA9B["expendable"] >= _id_761770FEDE046A2F["other"]) {
    _id_64518D95210A12E7 = level removebestsentient(_id_EE6F4AF9861DF2AB);

    if(!_id_64518D95210A12E7)
      return;
  }

  self.sentientpool = threatbiasgroup;
  self.sentientaddedtime = gettime();
  self.sentientpoolindex = self getentitynumber();
  team = undefined;

  if(isstring(_id_5C00772332CE642C))
    team = _id_5C00772332CE642C;
  else if(isPlayer(_id_5C00772332CE642C))
    team = _id_5C00772332CE642C.team;

  _id_F4B4C81B7E99C586 = undefined;

  if(isDefined(team) && !isagent(self))
    _id_F4B4C81B7E99C586 = self makeentitysentient(team, undefined, _id_719C179EABB70B31, _id_8928FDF873929E88);

  if(istrue(_id_F4B4C81B7E99C586)) {
    self setthreatbiasgroup(threatbiasgroup);

    if(istrue(_id_4918B66CEBC7FBE7))
      self makeentitynomeleetarget();

    level.activesentients[threatbiasgroup][self.sentientpoolindex] = self;
    thread monitorsentient(_id_5F6534AD3A0A1FA2);
  }
}

monitorsentient(_id_5F6534AD3A0A1FA2) {
  level endon("game_ended");
  poolid = self.sentientpool;
  _id_35FA1149AE3912E5 = self.sentientpoolindex;

  if(isDefined(_id_5F6534AD3A0A1FA2))
    scripts\engine\utility::waittill_any_3("death", "remove_sentient", _id_5F6534AD3A0A1FA2);
  else
    scripts\engine\utility::waittill_either("death", "remove_sentient");

  unregistersentient(poolid, _id_35FA1149AE3912E5);
}

removebestsentient(_id_6F03D6EBFF31DE00) {
  _id_77CB0F7EC307BE39 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= _id_6F03D6EBFF31DE00; _id_AC0E594AC96AA3A8++) {
    _id_77CB0F7EC307BE39 = getbestsentientfrompool(level.sentientpools[_id_AC0E594AC96AA3A8]);

    if(isDefined(_id_77CB0F7EC307BE39)) {
      break;
    }
  }

  if(!isDefined(_id_77CB0F7EC307BE39))
    return 0;

  _id_77CB0F7EC307BE39 unregistersentient(_id_77CB0F7EC307BE39.sentientpool, _id_77CB0F7EC307BE39.sentientpoolindex);
  return 1;
}

getbestsentientfrompool(_id_DAF372B2E19FB88F) {
  _id_77CB0F7EC307BE39 = undefined;
  _id_3071102F98CBED33 = undefined;

  foreach(_id_CC1496DD4AB3851B in level.activesentients[_id_DAF372B2E19FB88F]) {
    if(!isDefined(_id_3071102F98CBED33) || _id_CC1496DD4AB3851B.sentientaddedtime < _id_3071102F98CBED33) {
      _id_3071102F98CBED33 = _id_CC1496DD4AB3851B.sentientaddedtime;
      _id_77CB0F7EC307BE39 = _id_CC1496DD4AB3851B;
    }
  }

  return _id_77CB0F7EC307BE39;
}

unregistersentient(poolid, _id_35FA1149AE3912E5) {
  if(!isDefined(poolid) || !isDefined(_id_35FA1149AE3912E5)) {
    return;
  }
  level.activesentients[poolid][_id_35FA1149AE3912E5] = undefined;

  if(isDefined(self)) {
    self.sentientpool = undefined;
    self.sentientpoolindex = undefined;

    if(!isagent(self))
      self freeentitysentient();
  }
}