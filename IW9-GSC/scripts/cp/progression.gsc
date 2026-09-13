/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\progression.gsc
***********************************************/

init() {
  level _id_14609B809484646E::_id_8ECE37593311858A(::_id_F7B1518E621A2CA5);
}

_id_F7B1518E621A2CA5() {
  _id_2F934EC3B9BF0670();
  _id_7B360AE0833008D6();
  _id_80A2B94F26708876();
  _id_96AB127821B24D8F();
  self setplayerdata("cp", "CPSession", "weeklyStarsEarnedLastMatch", 0);
  thread _id_46408AC32C846594();
}

_id_80A2B94F26708876() {
  if(!istrue(self.pers["intelTrackingInitialized"])) {
    self setplayerdata("cp", "intelCollectFiveRewardAmount", 0);
    self.pers["intelTrackingInitialized"] = 1;
  }

  if(istrue(self getplayerdata("cp", "receivedIntelStars", "hasReceivedIntelStars"))) {
    return;
  }
  _id_BA11A925EC503D8B = _id_34819F005DAD50A9();
  _id_55ACCF4A36543CC0 = int(floor(_id_BA11A925EC503D8B / 5));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_55ACCF4A36543CC0; _id_AC0E594AC96AA3A8++)
    _id_9B50C58F20B295A0(2);

  self setplayerdata("cp", "receivedIntelStars", "hasReceivedIntelStars", 1);
}

_id_96AB127821B24D8F(_id_537A175320DA820F) {
  if(!isDefined(_id_537A175320DA820F))
    _id_BA11A925EC503D8B = _id_34819F005DAD50A9();
  else
    _id_BA11A925EC503D8B = _id_537A175320DA820F;

  if(_id_BA11A925EC503D8B < 150) {
    return;
  }
  typeid = _func_96B7FC7E35353254("collect_max_intel_reward");
  scripts\cp\challenges_cp::_id_7D7322BF935AB06A(self, typeid);
}

_id_34819F005DAD50A9() {
  return self getplayerdata("cp", "totalIntel");
}

_id_46408AC32C846594() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", message, category);

    if(message != "completed_cp_challenge") {
      continue;
    }
    switch (category) {
      case 3:
      case 2:
        _id_9B50C58F20B295A0(1);
        break;
      default:
        break;
    }
  }
}

_id_BA3B90DB77BD6F5C() {
  self._id_61429815F304F542 = _id_1D4995F917DFF69E();
  _id_72D06B8F947025A3 = getdvarint("dvar_9C953C01FC5249DD", 0);

  if(_id_72D06B8F947025A3 == 0) {
    return;
  }
  if(self._id_61429815F304F542 == 0)
    _id_732F1AE955E959EA(_id_72D06B8F947025A3);
  else if(_id_72D06B8F947025A3 > self._id_61429815F304F542) {
    _id_732F1AE955E959EA(_id_72D06B8F947025A3);
    _id_2F934EC3B9BF0670();
  }
}

_id_1D4995F917DFF69E() {
  return self getplayerdata("cp", "weeklyProgression", "weeklyResetTime");
}

_id_732F1AE955E959EA(_id_C377A7DEC55FCA7A) {
  return self setplayerdata("cp", "weeklyProgression", "weeklyResetTime", _id_C377A7DEC55FCA7A);
}

_id_2F934EC3B9BF0670() {
  _id_6A736B3CCCB5BDFB();
}

_id_CBAA41C477D4C53F() {
  _id_97D7CB191FF67887 = self getplayerdata("cp", "progression", "careerStars");
  return _id_97D7CB191FF67887;
}

_id_79BD9667E0DB0F6B(_id_BD955DE25B902A62) {
  _id_97D7CB191FF67887 = _id_CBAA41C477D4C53F();
  self setplayerdata("cp", "progression", "careerStars", _id_97D7CB191FF67887 + _id_BD955DE25B902A62);
  return _id_97D7CB191FF67887 + _id_BD955DE25B902A62;
}

_id_9B50C58F20B295A0(_id_30C2B3C99058169E) {
  _id_B77376DD31952275 = _id_5801D9069FF58385();
  _id_79BD9667E0DB0F6B(_id_30C2B3C99058169E);
  _id_13189A21870C2539(_id_B77376DD31952275, _id_30C2B3C99058169E, _id_30C2B3C99058169E, 1);
}

_id_9F35EBF8DB17E8D9(_id_B77376DD31952275) {
  switch (_id_B77376DD31952275) {
    case "kitMedic":
      return _id_900CC31798521E59("medicStars");
    case "kitAssault":
      return _id_900CC31798521E59("assaultStars");
    case "kitRecon":
      return _id_900CC31798521E59("reconStars");
  }

  return 0;
}

_id_13189A21870C2539(_id_B77376DD31952275, _id_C8BE13B6BD8F7E05, _id_CFBCB02C4E5EA638, _id_38E0188A424BC7A7) {
  if(!istrue(_id_38E0188A424BC7A7)) {
    if(_id_CFBCB02C4E5EA638 <= _id_E7AF75648059F540())
      return _id_E7AF75648059F540();
  }

  _id_EF0442BCA1AD6307 = _id_9F35EBF8DB17E8D9(_id_B77376DD31952275);
  _id_9126BDAB27208DFF = int(_id_EF0442BCA1AD6307 + clamp(_id_CFBCB02C4E5EA638, 0, _id_C8BE13B6BD8F7E05));

  switch (_id_B77376DD31952275) {
    case "kitMedic":
      _id_14BB942461A90723("medicStars", _id_9126BDAB27208DFF);
      return _id_9126BDAB27208DFF;
    case "kitAssault":
      _id_14BB942461A90723("assaultStars", _id_9126BDAB27208DFF);
      return _id_9126BDAB27208DFF;
    case "kitRecon":
      _id_14BB942461A90723("reconStars", _id_9126BDAB27208DFF);
      return _id_9126BDAB27208DFF;
  }

  return 0;
}

_id_1D9EEDA30F722F43(_id_CFBCB02C4E5EA638, _id_96ED04D8C80C6220) {
  foreach(player in level.players) {
    _id_B77376DD31952275 = player _id_5801D9069FF58385();
    player _id_79BD9667E0DB0F6B(_id_CFBCB02C4E5EA638);
    _id_C8BE13B6BD8F7E05 = player _id_7B3E5617C1A872A4();
    player _id_13189A21870C2539(_id_B77376DD31952275, _id_C8BE13B6BD8F7E05, _id_CFBCB02C4E5EA638);
    player _id_3180567D942C0EAC(_id_CFBCB02C4E5EA638);
    player _id_490EAADDB15805DF(_id_CFBCB02C4E5EA638, _id_96ED04D8C80C6220);
  }
}

_id_490EAADDB15805DF(_id_CFBCB02C4E5EA638, _id_96ED04D8C80C6220) {
  _id_7A34D05C87DE4D53 = _id_3E1F4EC9F2EA7F0A();

  if(!isDefined(_id_7A34D05C87DE4D53) || _id_7A34D05C87DE4D53 == "") {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_97ACF04B1260E998 = level.players[_id_AC0E594AC96AA3A8] getplayerdata("cp", "careerstarsdata", _id_7A34D05C87DE4D53, "careerStarsDataPerMission", "starsRewarded");

    if(!isDefined(_id_97ACF04B1260E998) || _id_CFBCB02C4E5EA638 > _id_97ACF04B1260E998)
      level.players[_id_AC0E594AC96AA3A8] setplayerdata("cp", "careerstarsdata", _id_7A34D05C87DE4D53, "careerStarsDataPerMission", "starsRewarded", _id_CFBCB02C4E5EA638);

    _id_037CE38FC4DD4165 = level.players[_id_AC0E594AC96AA3A8] getplayerdata("cp", "careerstarsdata", _id_7A34D05C87DE4D53, "careerStarsDataPerMission", "personalBestTime");

    if(!isDefined(_id_037CE38FC4DD4165) || _id_037CE38FC4DD4165 <= 0 || _id_96ED04D8C80C6220 < _id_037CE38FC4DD4165) {
      level.players[_id_AC0E594AC96AA3A8] setplayerdata("cp", "careerstarsdata", _id_7A34D05C87DE4D53, "careerStarsDataPerMission", "personalBestTime", _id_96ED04D8C80C6220);
      level.players[_id_AC0E594AC96AA3A8] setclientomnvar("ui_aar_is_personal_best", 1);
      continue;
    }

    level.players[_id_AC0E594AC96AA3A8] setclientomnvar("ui_aar_is_personal_best", 0);
  }
}

_id_7B360AE0833008D6() {
  _id_7A34D05C87DE4D53 = _id_399CCFE790A8B2EB();

  if(!isDefined(_id_7A34D05C87DE4D53) || _id_7A34D05C87DE4D53 == "") {
    return;
  }
  self setplayerdata("cp", "weeklyProgression", "missionName", _id_7A34D05C87DE4D53);
  return _id_7A34D05C87DE4D53;
}

_id_3E1F4EC9F2EA7F0A() {
  return self getplayerdata("cp", "weeklyProgression", "missionName");
}

_id_14BB942461A90723(_id_43175630D0B22405, _id_BD2F9E41E3B6C052) {
  return self setplayerdata("cp", "progression", "playerKit", "kitProgress", _id_43175630D0B22405, _id_BD2F9E41E3B6C052);
}

_id_900CC31798521E59(_id_43175630D0B22405) {
  return self getplayerdata("cp", "progression", "playerKit", "kitProgress", _id_43175630D0B22405);
}

_id_5801D9069FF58385() {
  _id_B77376DD31952275 = self getplayerdata("cp", "progression", "playerKit", "currentKit");
  return _id_B77376DD31952275;
}

_id_3180567D942C0EAC(_id_9126BDAB27208DFF) {
  _id_7A34D05C87DE4D53 = _id_3E1F4EC9F2EA7F0A();

  if(!isDefined(_id_7A34D05C87DE4D53) || _id_7A34D05C87DE4D53 == "") {
    return;
  }
  _id_965D95BDC550C95B = 3;
  _id_86AC4A7077D1D602 = _id_E7AF75648059F540();
  _id_AB92344A22E80D75 = _id_965D95BDC550C95B - _id_86AC4A7077D1D602;
  _id_1AE4B05AA2A8F73D = int(clamp(_id_9126BDAB27208DFF, 0, _id_AB92344A22E80D75));
  _id_522DDEAEC1A60937 = _id_86AC4A7077D1D602 + _id_1AE4B05AA2A8F73D;
  self setplayerdata("cp", "CPSession", "weeklyStarsEarnedLastMatch", _id_1AE4B05AA2A8F73D);

  switch (_id_7A34D05C87DE4D53) {
    case "BadSituation":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyBadSituationStars", _id_522DDEAEC1A60937);
      break;
    case "HeliEscort":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyHeliEscortStars", _id_522DDEAEC1A60937);
      break;
    case "VehicleEscape":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyVehicleEscapeStars", _id_522DDEAEC1A60937);
      break;
    case "Observatory":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyObservatoryStars", _id_522DDEAEC1A60937);
      break;
    case "ObservatoryModified":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyGunGameObservatoryStars", _id_522DDEAEC1A60937);
      break;
    case "BadSituationModified":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyOITCBadSituationStars", _id_522DDEAEC1A60937);
      break;
    case "DefenderLone":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyDefenderLoneStars", _id_522DDEAEC1A60937);
      break;
    case "Raid1Veteran":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1VeteranStars", _id_522DDEAEC1A60937);
      break;
    case "Raid1":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1Stars", _id_522DDEAEC1A60937);
      break;
    case "Raid2Veteran":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2VeteranStars", _id_522DDEAEC1A60937);
      break;
    case "Raid2":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2Stars", _id_522DDEAEC1A60937);
      break;
    case "Raid3Veteran":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3VeteranStars", _id_522DDEAEC1A60937);
      break;
    case "Raid3":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3Stars", _id_522DDEAEC1A60937);
      break;
    case "Raid4Veteran":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4VeteranStars", _id_522DDEAEC1A60937);
      break;
    case "Raid4":
      self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4Stars", _id_522DDEAEC1A60937);
      break;
  }

  return _id_522DDEAEC1A60937;
}

_id_E7AF75648059F540() {
  _id_7A34D05C87DE4D53 = _id_3E1F4EC9F2EA7F0A();

  if(!isDefined(_id_7A34D05C87DE4D53) || _id_7A34D05C87DE4D53 == "") {
    return;
  }
  switch (_id_7A34D05C87DE4D53) {
    case "BadSituation":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyBadSituationStars");
    case "HeliEscort":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyHeliEscortStars");
    case "VehicleEscape":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyVehicleEscapeStars");
    case "Observatory":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyObservatoryStars");
    case "ObservatoryModified":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyGunGameObservatoryStars");
    case "BadSituationModified":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyOITCBadSituationStars");
    case "DefenderLone":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyDefenderLoneStars");
    case "Raid1Veteran":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1VeteranStars");
    case "Raid1":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1Stars");
    case "Raid2Veteran":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2VeteranStars");
    case "Raid2":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2Stars");
    case "Raid3Veteran":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3VeteranStars");
    case "Raid3":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3Stars");
    case "Raid4Veteran":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4VeteranStars");
    case "Raid4":
      return self getplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4Stars");
  }

  return "";
}

_id_399CCFE790A8B2EB() {
  switch (level.script) {
    case "cp_hydro":
      if(istrue(scripts\cp\cp_relics::is_relic_active("relic_oneInTheChamber")))
        return "BadSituationModified";
      else
        return "BadSituation";
    case "cp_mission_esc":
      if(istrue(level._id_05F694EFAFEB95D7))
        return "HeliEscort";
      else
        return "VehicleEscape";
    case "cp_observatory":
      if(istrue(scripts\cp\cp_relics::_id_30D732F612695BA8()))
        return "ObservatoryModified";
      else
        return "Observatory";
    case "cp_lone":
      return "DefenderLone";
    case "cp_raid1":
      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        return "Raid1Veteran";

      return "Raid1";
    case "cp_raid1_trap":
      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        return "Raid2Veteran";

      return "Raid2";
    case "cp_raid1_boss1":
      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        return "Raid3Veteran";

      return "Raid3";
    case "cp_jugg_maze":
      if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8())
        return "Raid4Veteran";

      return "Raid4";
  }

  return "";
}

_id_6A736B3CCCB5BDFB() {
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyBadSituationStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyHeliEscortStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyVehicleEscapeStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyObservatoryStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyGunGameObservatoryStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyOITCBadSituationStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyDefenderLoneStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1Stars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid1VeteranStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2Stars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid2VeteranStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3Stars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid3VeteranStars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4Stars", 0);
  self setplayerdata("cp", "weeklyProgression", "weeklyMissionProgression", "weeklyRaid4VeteranStars", 0);
}

_id_7B3E5617C1A872A4() {
  _id_86AC4A7077D1D602 = _id_E7AF75648059F540();
  return 3 - _id_86AC4A7077D1D602;
}