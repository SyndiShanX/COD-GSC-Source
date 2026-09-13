/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_180407b61054c278.gsc
***********************************************/

_id_BB1348B8361A6742() {
  level._id_64586D042BC83658 = ::_id_DA50E02D9E2C31D2;
  level._id_BC366EF8514F9C7E = ::_id_DE30D8B0A3C06FD8;
  level._id_CB98C0FDA2FD2C79 = spawnStruct();
  level._id_CB98C0FDA2FD2C79._id_0D1E945B3A961AEE = ::_id_AA01FE87EE1CB415;
  level._id_B290423F07C0FA3C = spawnStruct();
  level._id_B290423F07C0FA3C._id_21E140B4AAAF4563 = "dlog_event_esports_player_match_end_koth";
  level._id_B290423F07C0FA3C._id_0D1E945B3A961AEE = ::_id_664E133F4636982C;
  level._id_2B79862D8E89E043 = spawnStruct();
  level._id_2B79862D8E89E043._id_0D1E945B3A961AEE = ::_id_F93988444DECE179;
}

_id_89B5DEBAABF76FF3() {
  level._id_64586D042BC83658 = ::_id_C358696CB940224B;
  level._id_BC366EF8514F9C7E = ::_id_E16B616BE638E777;
  level._id_CB98C0FDA2FD2C79 = spawnStruct();
  level._id_CB98C0FDA2FD2C79._id_0D1E945B3A961AEE = ::_id_9576E752AED74566;
  level._id_2B79862D8E89E043 = spawnStruct();
  level._id_2B79862D8E89E043._id_0D1E945B3A961AEE = ::_id_66D2B5499B862642;
  level._id_B290423F07C0FA3C = spawnStruct();
  level._id_B290423F07C0FA3C._id_21E140B4AAAF4563 = "dlog_event_esports_player_match_end_sd";
  level._id_B290423F07C0FA3C._id_0D1E945B3A961AEE = ::_id_20524D471D23D817;
  level._id_9F33F41B213A1BE7 = spawnStruct();
  level._id_9F33F41B213A1BE7._id_21E140B4AAAF4563 = "dlog_event_esports_player_round_end_sd";
  level._id_9F33F41B213A1BE7._id_0D1E945B3A961AEE = ::_id_1B1EE2699A6A524C;
}

_id_DA27978A46C38E71() {
  level._id_BC366EF8514F9C7E = ::_id_86C1B16817AD3899;
  level._id_CB98C0FDA2FD2C79 = spawnStruct();
  level._id_CB98C0FDA2FD2C79._id_0D1E945B3A961AEE = ::_id_935AD059F8BC1AE8;
  level._id_B290423F07C0FA3C = spawnStruct();
  level._id_B290423F07C0FA3C._id_21E140B4AAAF4563 = "dlog_event_esports_player_match_end_control";
  level._id_B290423F07C0FA3C._id_0D1E945B3A961AEE = ::_id_3A0BBA2841CC215B;
  level._id_9F33F41B213A1BE7 = spawnStruct();
  level._id_9F33F41B213A1BE7._id_21E140B4AAAF4563 = "dlog_event_esports_player_round_end_control";
  level._id_9F33F41B213A1BE7._id_0D1E945B3A961AEE = ::_id_7B9680C1E187BD00;
  level._id_2B79862D8E89E043 = spawnStruct();
  level._id_2B79862D8E89E043._id_0D1E945B3A961AEE = ::_id_6E10CFDFA388094C;
}

_id_A9EF96191F2B64A9() {
  level._id_2B79862D8E89E043 = spawnStruct();
  level._id_2B79862D8E89E043._id_0D1E945B3A961AEE = ::_id_6E10CFDFA388094C;
}

init() {
  if(getdvarint("dvar_830D682C147B23BB", 0) > 0)
    wait(getdvarint("dvar_830D682C147B23BB", 0));

  if(!_func_03B6961B424A382F() && getdvarint("dvar_8D2F43EB37209BAE", 0) == 0) {
    return;
  }
  level._id_CDA83EFB48942D27 = spawnStruct();
  level._id_CDA83EFB48942D27.teams = [];
  level._id_CDA83EFB48942D27.players = [];
  level._id_CDA83EFB48942D27._id_241DB65C803FDCD0 = getdvarint("dvar_839ED56F32C687F1", 5);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_server_start", ::_id_EC68F43C79E586DC);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_match_start", ::_id_393BAF20DB478C0D);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_match_end", ::_id_F5F91665FE4DBA94);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_round_start", ::_id_8EEEA3969DF7E964);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_round_end", ::_id_B610A0D728DFA59E);

  if(getdvarint("dvar_F405928D962AE17E", 0) < 2)
    _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_objective_state_changed", ::_id_0CD0B801A8B092CA);

  if(getdvarint("dvar_F405928D962AE17E", 0) < 1) {
    _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_player_loadout_changed", ::_id_C82D72EBCDB14059);
    _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_disconnect", ::on_player_disconnect);
  }

  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_player_death", ::_id_5F84AFC437FF71F9);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_first_connect", ::_id_A51C2C04A3F452CC);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_connect", ::on_player_connect);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_player_round_end", ::_id_49472736AF222FCC);
  _id_4A6760982B403BAD::_id_AACBBE63C26687AE("callback_on_player_spawned", ::_id_ED4B9C7445B52BE8);

  switch (level.gametype) {
    case "koth":
      _id_BB1348B8361A6742();
      break;
    case "sd":
      _id_89B5DEBAABF76FF3();
      break;
    case "control":
      _id_DA27978A46C38E71();
      break;
    default:
      _id_A9EF96191F2B64A9();
      break;
  }

  level notify("telemetry_init");
}

_id_D3C6179B65106833() {
  if(getdvarint("dvar_F405928D962AE17E", 0) >= 2) {
    return;
  }
  self endon("death");
  level endon("game_ended");
  _id_241DB65C803FDCD0 = level._id_CDA83EFB48942D27._id_241DB65C803FDCD0;

  for(;;) {
    _id_A6C2B5A6203B8813();
    _id_C22652F83B317B82();
    wait(_id_241DB65C803FDCD0);
  }
}

_id_036FA9AA217C6858() {
  _id_4DBA79DFA0880763 = getdvarint("dvar_E38EE0A901267948", 0);

  if(_id_4DBA79DFA0880763 <= 0) {
    return;
  }
  _id_9BD7564C71693E36 = getdvarint("dvar_5425503FA577C921", 10000) / 1000;
  _id_720C6460E66C2E7F = getdvarint("dvar_9B4FBAF632D0F62E", 1);
  _id_D80F4A569A2E75BD = _id_AE0481D6812510B2();

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_720C6460E66C2E7F; _id_AC0E594AC96AA3A8++)
      _id_4EAF70B59B015528(_id_D80F4A569A2E75BD);

    wait(_id_9BD7564C71693E36);
  }
}

_id_AE0481D6812510B2() {
  _id_CAC5351DE1E9BA74 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 7; _id_AC0E594AC96AA3A8++) {
    _id_F37BFD4CF3B7830A = _func_2EF675C13CA1C4AF("dvar_3AB224A3325D7169", _id_AC0E594AC96AA3A8);
    _id_74BF1C0EFF8313D3 = getdvarfloat(_id_F37BFD4CF3B7830A, 0.0);
    _id_CAC5351DE1E9BA74[_id_AC0E594AC96AA3A8] = _id_74BF1C0EFF8313D3;
  }

  return _id_CAC5351DE1E9BA74;
}

_id_4EAF70B59B015528(_id_A45459A59E9A5F87) {
  _id_5A46AFDCD4F81177 = _id_1433FC1CD0F15328(_id_A45459A59E9A5F87);

  switch (_id_5A46AFDCD4F81177) {
    case 0:
      _id_9F5DE9916AD7FB1E("dlog_event_esports_test_0", 20);
      break;
    case 1:
      _id_9F5DE9916AD7FB1E("dlog_event_esports_test_1", 50);
      break;
    case 2:
      _id_9F5DE9916AD7FB1E("dlog_event_esports_test_2", 100);
      break;
    case 3:
      _id_9F5DE9916AD7FB1E("dlog_event_esports_test_3", 150);
      break;
    case 4:
      _id_9F5DE9916AD7FB1E("dlog_event_esports_test_4", 250);
      break;
    case 5:
      _id_9F5DE9916AD7FB1E("dlog_event_esports_test_5", 500);
      break;
    case 6:
      _id_9F5DE9916AD7FB1E("dlog_event_esports_test_6", 1000);
      break;
    case 7:
      _id_BBD656CE5A10696C = _id_550037A80866CB85(1024);
      _id_035554AE84383490 = ["test_column_1", _id_BBD656CE5A10696C, "test_column_2", _id_BBD656CE5A10696C];
      dlog_recordevent("dlog_event_esports_test_7", _id_035554AE84383490);
      break;
  }
}

_id_550037A80866CB85(count) {
  _id_73F4F7F2CCC98C73 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++)
    _id_73F4F7F2CCC98C73[_id_AC0E594AC96AA3A8] = randomint(256);

  return _id_73F4F7F2CCC98C73;
}

_id_9F5DE9916AD7FB1E(_id_9144967162969CD7, _id_FEBD4E2D7597B3F5) {
  _id_035554AE84383490 = ["test_column", _id_550037A80866CB85(_id_FEBD4E2D7597B3F5)];
  dlog_recordevent(_id_9144967162969CD7, _id_035554AE84383490);
}

_id_1433FC1CD0F15328(_id_A45459A59E9A5F87) {
  _id_AB1E1B0C0C442E40 = randomfloat(1);
  _id_BBB45D49F4EAF799 = 0;
  _id_3EE256C689D62FA7 = 0.0;
  _id_6645AFB1FB6E3E31 = _id_A45459A59E9A5F87[_id_BBB45D49F4EAF799];

  while(!_id_877519EA69933232(_id_3EE256C689D62FA7, _id_AB1E1B0C0C442E40, _id_6645AFB1FB6E3E31)) {
    _id_BBB45D49F4EAF799++;
    _id_3EE256C689D62FA7 = _id_6645AFB1FB6E3E31;

    if(_id_BBB45D49F4EAF799 != _id_A45459A59E9A5F87.size - 1) {
      _id_6645AFB1FB6E3E31 = _id_6645AFB1FB6E3E31 + _id_A45459A59E9A5F87[_id_BBB45D49F4EAF799];
      continue;
    }

    _id_6645AFB1FB6E3E31 = 1.0;
  }

  return _id_BBB45D49F4EAF799;
}

_id_877519EA69933232(min, value, max) {
  return value >= min && value <= max;
}

_id_A3D4800B4CB51B38(_id_16290C9DDA466BCE) {
  return [_id_16290C9DDA466BCE[0], _id_16290C9DDA466BCE[1], _id_16290C9DDA466BCE[2]];
}

_id_78707B6B4CB17A1C(_id_49E04C0C429E35C8) {
  if(!isDefined(level._id_CDA83EFB48942D27.teams[_id_49E04C0C429E35C8])) {
    _id_A3BF560B25C4A33E = _func_CA9AF9C7FABD79A0(_id_49E04C0C429E35C8);
    level._id_CDA83EFB48942D27.teams[_id_49E04C0C429E35C8] = scripts\engine\utility::ter_op(isDefined(_id_A3BF560B25C4A33E), _id_A3BF560B25C4A33E, _id_49E04C0C429E35C8);
  }

  return level._id_CDA83EFB48942D27.teams[_id_49E04C0C429E35C8];
}

_id_B4324BFCD55B4E28(_id_0AA81B2C7E0A29A1) {
  if(_id_0AA81B2C7E0A29A1 == "none" || _id_0AA81B2C7E0A29A1 == "tie")
    return "draw";

  return _id_78707B6B4CB17A1C(_id_0AA81B2C7E0A29A1);
}

_id_1DA7BFA6BC897E5E(player) {
  if(!isDefined(player.xuid))
    return player _meth_BB91C271085A7728();

  if(!isDefined(level._id_CDA83EFB48942D27.players[player.xuid]))
    level._id_CDA83EFB48942D27.players[player.xuid] = player _meth_BB91C271085A7728();

  return level._id_CDA83EFB48942D27.players[player.xuid];
}

_id_22DE454B228D857C() {
  return scripts\mp\matchdata::gettimefrommatchstart(gettime());
}

_id_DF75E8BD68B005F0(_id_C7C58523552F1A6F) {
  if(!isDefined(_id_C7C58523552F1A6F))
    return "unknown";

  _id_867DE8B456966B94 = game["end_reason"];
  reasons = getarraykeys(_id_867DE8B456966B94);

  foreach(_id_401C3A2E68AAB0FD in reasons) {
    _id_A3B15DFC45FA034A = _id_867DE8B456966B94[_id_401C3A2E68AAB0FD];

    if(_id_A3B15DFC45FA034A == _id_C7C58523552F1A6F)
      return _id_401C3A2E68AAB0FD;
  }

  return "unknown";
}

_id_BD8CFC6E4A98DEE6(_id_0AA81B2C7E0A29A1) {
  _id_F7FB016578461B57 = spawnStruct();

  if(_id_0AA81B2C7E0A29A1 == game["attackers"]) {
    _id_F7FB016578461B57._id_A66BA9B157533F5A = "attack";
    _id_F7FB016578461B57._id_2886F2D139E0660F = _id_0AA81B2C7E0A29A1;
    _id_F7FB016578461B57._id_CA44196B95E71FB2 = game["defenders"];
  } else if(_id_0AA81B2C7E0A29A1 == game["defenders"]) {
    _id_F7FB016578461B57._id_A66BA9B157533F5A = "defense";
    _id_F7FB016578461B57._id_2886F2D139E0660F = _id_0AA81B2C7E0A29A1;
    _id_F7FB016578461B57._id_CA44196B95E71FB2 = game["attackers"];
  } else {
    _id_F7FB016578461B57._id_A66BA9B157533F5A = "none";
    _id_F7FB016578461B57._id_2886F2D139E0660F = "none";
    _id_F7FB016578461B57._id_CA44196B95E71FB2 = "none";
  }

  return _id_F7FB016578461B57;
}

_id_8B0F3D64EE5D77DA() {
  _id_00F011BE8C331F0F = spawnStruct();

  if(scripts\mp\utility\game::isroundbased()) {
    if(game["attackers"] == "allies") {
      _id_00F011BE8C331F0F._id_CF29D316C16E2753 = "attack";
      _id_00F011BE8C331F0F._id_CF29D416C16E2986 = "defense";
    } else {
      _id_00F011BE8C331F0F._id_CF29D316C16E2753 = "defense";
      _id_00F011BE8C331F0F._id_CF29D416C16E2986 = "attack";
    }
  } else {
    _id_00F011BE8C331F0F._id_CF29D316C16E2753 = "none";
    _id_00F011BE8C331F0F._id_CF29D416C16E2986 = "none";
  }

  return _id_00F011BE8C331F0F;
}

_id_B6C29E08764AE361(_id_6DD5C3ACB6BB048E) {
  _id_C5CF558181E12D1F = 1;

  if(!scripts\mp\utility\game::isroundbased())
    return _id_C5CF558181E12D1F;

  _id_C5CF558181E12D1F = game["roundsPlayed"];

  if(isDefined(_id_6DD5C3ACB6BB048E) && (_id_6DD5C3ACB6BB048E == "MOD_GAME_ENDED" || _id_6DD5C3ACB6BB048E == "MOD_ROUND_ENDED")) {
    _id_C5CF558181E12D1F--;

    if(_id_C5CF558181E12D1F < 1)
      _id_C5CF558181E12D1F = 1;
  }

  return _id_C5CF558181E12D1F;
}

_id_AAE4068942E8BC69() {
  _id_4BABA2549A523C78 = level.zoneendtime;

  if(isDefined(level.defuseendtime))
    _id_4BABA2549A523C78 = level.defuseendtime;

  if(isDefined(_id_4BABA2549A523C78)) {
    currenttime = gettime();
    return scripts\engine\utility::ter_op(currenttime < _id_4BABA2549A523C78, _id_4BABA2549A523C78 - currenttime, 0);
  }

  return 0;
}

_id_F1C3EE0FA29180A6(attacker, victim) {
  _id_988B0676A35EF9D6 = scripts\mp\utility\teams::getfriendlyplayers(victim.team, 0).size;
  return attacker.pers["kills"] - attacker._id_934379620852E329.kills == _id_988B0676A35EF9D6;
}

_id_1E412FB6D8CBC655(_id_642470E1ABC1BBF9) {
  return isDefined(_id_642470E1ABC1BBF9.damageflags) && _id_642470E1ABC1BBF9.damageflags &level.idflags_penetration;
}

_id_D303E25D324B2874() {
  return !level._id_BF918FC5F938CD0C && level.zoneendtime - gettime() <= 15000;
}

_id_BFFB24C16C411C32() {
  _id_86D6CF0C6F566368 = level.zone.objectivekey;
  return "point" + _id_86D6CF0C6F566368;
}

_id_E553B81F7F609A5B() {
  _id_076276113DD5B929 = self.objectivekey;

  if(isDefined(_id_076276113DD5B929) && (_id_076276113DD5B929 == "_a" || _id_076276113DD5B929 == "_b"))
    return "point" + _id_076276113DD5B929;

  return "bomb";
}

_id_50280CF505622041() {
  return "point" + self.objectivekey;
}

_id_3FC5FD079E76A114(objective) {
  _id_35599C2772650DB9 = ["obj_name", "point" + objective.objectivekey, "origin", _id_A3D4800B4CB51B38(objective.curorigin)];
  return _id_35599C2772650DB9;
}

_id_D824247CAFD98AFC() {
  _id_96349E74C9078D79 = istrue(self.isbombcarrier) || istrue(self.isplanting) || istrue(self.isdefusing);
  _id_3FC17555CF838DD1 = isDefined(self.touchtriggers) && self.touchtriggers.size > 0;
  return _id_96349E74C9078D79 || _id_3FC17555CF838DD1;
}

_id_DA50E02D9E2C31D2() {
  if(!isDefined(self.pers["obj1Time"]))
    scripts\mp\utility\stats::initpersstat("obj1Time");

  if(!isDefined(self.pers["obj2Time"]))
    scripts\mp\utility\stats::initpersstat("obj2Time");

  if(!isDefined(self.pers["obj3Time"]))
    scripts\mp\utility\stats::initpersstat("obj3Time");

  if(!isDefined(self.pers["obj4Time"]))
    scripts\mp\utility\stats::initpersstat("obj4Time");

  if(!isDefined(self.pers["obj5Time"]))
    scripts\mp\utility\stats::initpersstat("obj5Time");
}

_id_C358696CB940224B() {
  if(!isDefined(self.pers["sneakDefuses"]))
    scripts\mp\utility\stats::initpersstat("sneakDefuses");
}

_id_2CBDF94F9506AD4F() {
  if(!isDefined(self.pers["total_time_alive"]))
    scripts\mp\utility\stats::initpersstat("total_time_alive");

  if(!isDefined(self.pers["shotsHitHead"]))
    scripts\mp\utility\stats::initpersstat("shotsHitHead");

  if(!isDefined(self.pers["totalMultikills"]))
    scripts\mp\utility\stats::initpersstat("totalMultikills");

  if(!isDefined(self.pers["soloKills"]))
    scripts\mp\utility\stats::initpersstat("soloKills");

  if(!isDefined(self.pers["deadSilenceKills"]))
    scripts\mp\utility\stats::initpersstat("deadSilenceKills");

  if(!isDefined(self.pers["deadSilenceTime"]))
    scripts\mp\utility\stats::initpersstat("deadSilenceTime");

  if(!isDefined(self.pers["damageHealed"]))
    scripts\mp\utility\stats::initpersstat("damageHealed");

  if(!isDefined(self.pers["inapplicableTradedKills"]))
    scripts\mp\utility\stats::initpersstat("inapplicableTradedKills");

  if(!isDefined(self.pers["inapplicableTradedDeaths"]))
    scripts\mp\utility\stats::initpersstat("inapplicableTradedDeaths");

  if(!isDefined(self.pers["friendlyDamageDone"]))
    scripts\mp\utility\stats::initpersstat("friendlyDamageDone");

  if(!isDefined(self.pers["tacticalsUsed"]))
    scripts\mp\utility\stats::initpersstat("tacticalsUsed");

  if(!isDefined(self.pers["lethalsUsed"]))
    scripts\mp\utility\stats::initpersstat("lethalsUsed");

  if(!isDefined(self.pers["damageTaken"]))
    scripts\mp\utility\stats::initpersstat("damageTaken");

  if(!isDefined(self.pers["totalDistTraveled"]))
    scripts\mp\utility\stats::initpersstat("totalDistTraveled");

  if(isDefined(level._id_64586D042BC83658))
    self[[level._id_64586D042BC83658]]();
}

_id_DE30D8B0A3C06FD8(_id_934379620852E329, _id_2DBFE016101D4381) {
  _id_934379620852E329._id_581E9FEF734064D2 = scripts\mp\codcasterclientmatchdata::_id_A08FEA26A49145A8(0);
  _id_934379620852E329._id_E4F4159AF6862680 = scripts\mp\codcasterclientmatchdata::_id_A08FEA26A49145A8(12);
}

_id_E16B616BE638E777(_id_934379620852E329, _id_2DBFE016101D4381) {
  _id_934379620852E329._id_F25A28C3777E1385 = _id_2DBFE016101D4381["plants"];
  _id_934379620852E329._id_F9A1367B78F32A17 = _id_2DBFE016101D4381["defuses"];
  _id_934379620852E329._id_F6A4C20651DA07C3 = _id_2DBFE016101D4381["sneakDefuses"];
}

_id_86C1B16817AD3899(_id_934379620852E329, _id_2DBFE016101D4381) {
  _id_934379620852E329._id_FCB44162C4A9E3C1 = scripts\mp\codcasterclientmatchdata::_id_A08FEA26A49145A8(8);
}

_id_42AFC3BFBB1E92CB() {
  _id_934379620852E329 = spawnStruct();
  _id_2DBFE016101D4381 = self.pers;
  _id_934379620852E329.kills = _id_2DBFE016101D4381["kills"];
  _id_934379620852E329.deaths = _id_2DBFE016101D4381["deaths"];
  _id_934379620852E329.assists = _id_2DBFE016101D4381["assists"];
  _id_934379620852E329.score = _id_2DBFE016101D4381["score"];
  _id_934379620852E329._id_C3F4042EC779FE9E = _id_2DBFE016101D4381["longestStreak"];
  _id_934379620852E329.shots_fired = scripts\mp\codcasterclientmatchdata::_id_E42724FBFACFF469(0);
  _id_934379620852E329.shots_hit = scripts\mp\codcasterclientmatchdata::_id_E42724FBFACFF469(1);
  _id_934379620852E329._id_E61D71A6E5C3E7A1 = _id_2DBFE016101D4381["shotsHitHead"];
  _id_934379620852E329._id_53A5BA21527A8036 = scripts\mp\codcasterclientmatchdata::_id_815FEE43D577E1B6(5);
  _id_934379620852E329._id_2236966986B7BC12 = _id_2DBFE016101D4381["untradedDeaths"];
  _id_934379620852E329._id_9F2DE5B1B23CA7F5 = _id_2DBFE016101D4381["tradedKills"];
  _id_934379620852E329._id_6F9D3EDD52C8141F = _id_2DBFE016101D4381["tradedDeaths"];
  _id_934379620852E329._id_F33C4C6C651980B8 = _id_2DBFE016101D4381["inapplicableTradedKills"];
  _id_934379620852E329._id_7FBC4327B7F5C574 = _id_2DBFE016101D4381["inapplicableTradedDeaths"];
  _id_934379620852E329._id_3FDFC409E09D574D = scripts\mp\codcasterclientmatchdata::_id_815FEE43D577E1B6(1);
  _id_934379620852E329.damage_taken = _id_2DBFE016101D4381["damageTaken"];
  _id_934379620852E329._id_0C0B6808E1B1983E = _id_2DBFE016101D4381["damageHealed"];
  _id_934379620852E329._id_62D91C98F2E6FD01 = _id_2DBFE016101D4381["friendlyDamageDone"];
  _id_934379620852E329._id_07FC806C5CD9720B = _id_2DBFE016101D4381["tacticalsUsed"];
  _id_934379620852E329._id_6C8595EC09D557EC = _id_2DBFE016101D4381["lethalsUsed"];
  _id_934379620852E329._id_9875B868BB8A4936 = _id_2DBFE016101D4381["total_time_alive"];
  _id_934379620852E329._id_3D1EA5C9BF625DE6 = _id_2DBFE016101D4381["totalDistTraveled"];
  _id_934379620852E329._id_69178EE1F1771889 = _id_2DBFE016101D4381["deadSilenceTime"];
  _id_934379620852E329._id_5812427166FC4794 = _id_2DBFE016101D4381["movementUpdateCount"];
  _id_934379620852E329._id_90E34A204F8D5EDB = _id_2DBFE016101D4381["movingTotal"];
  _id_934379620852E329._id_C2ACD5609C794D20 = _id_2DBFE016101D4381["distanceTotal"];

  if(isDefined(level._id_BC366EF8514F9C7E))
    self[[level._id_BC366EF8514F9C7E]](_id_934379620852E329, _id_2DBFE016101D4381);

  self._id_934379620852E329 = _id_934379620852E329;
}

_id_E2EC18C5B7DE4FB6() {
  deathtime = _id_22DE454B228D857C();
  _id_CC785F48D0173169 = deathtime - scripts\mp\matchdata::gettimefrommatchstart(self.spawntime);
  scripts\mp\utility\stats::incpersstat("total_time_alive", _id_CC785F48D0173169);
}

_id_D21DFE417B65B64A() {
  if(isalive(self)) {
    _id_A119B718BF250DDE = _id_22DE454B228D857C();
    _id_CC785F48D0173169 = _id_A119B718BF250DDE - scripts\mp\matchdata::gettimefrommatchstart(self.spawntime);
    scripts\mp\utility\stats::incpersstat("total_time_alive", _id_CC785F48D0173169);
  }
}

_id_C56D015E4CD2E47C(data) {
  _id_51E6CE77B3D9CC11 = spawnStruct();

  if(isDefined(data["movementUpdateCount"]) && data["movementUpdateCount"] > 0) {
    _id_51E6CE77B3D9CC11._id_3ECB392A578C4F31 = int(data["movingTotal"] / (data["movementUpdateCount"] / 5) * 100);
    _id_51E6CE77B3D9CC11._id_A37E2059959D3204 = float(data["distanceTotal"] / data["movementUpdateCount"]);
    return _id_51E6CE77B3D9CC11;
  }

  _id_51E6CE77B3D9CC11._id_3ECB392A578C4F31 = 0;
  _id_51E6CE77B3D9CC11._id_A37E2059959D3204 = 0.0;
  return _id_51E6CE77B3D9CC11;
}

_id_3DDC4F55DFE66EBB() {
  _id_934379620852E329 = self._id_934379620852E329;

  if(!isDefined(_id_934379620852E329._id_5812427166FC4794))
    return _id_C56D015E4CD2E47C(self.pers);

  _id_2DBFE016101D4381 = self.pers;
  _id_104538CF2341CF1E = [];
  _id_104538CF2341CF1E["movingTotal"] = _id_2DBFE016101D4381["movingTotal"] - _id_934379620852E329._id_90E34A204F8D5EDB;
  _id_104538CF2341CF1E["movementUpdateCount"] = _id_2DBFE016101D4381["movementUpdateCount"] - _id_934379620852E329._id_5812427166FC4794;
  _id_104538CF2341CF1E["distanceTotal"] = _id_2DBFE016101D4381["distanceTotal"] - _id_934379620852E329._id_C2ACD5609C794D20;
  return _id_C56D015E4CD2E47C(_id_104538CF2341CF1E);
}

_id_B433743DC5925931(_id_FB5A2DA2D4C3C2E7) {
  player = self;
  _id_E170A74F4CB5D9D5 = _id_FB5A2DA2D4C3C2E7.weapon;
  weapon_name = "none";

  if(isDefined(_id_E170A74F4CB5D9D5))
    weapon_name = _id_E170A74F4CB5D9D5.basename;

  _id_D8F12E845F2A6C40 = [];

  if(!isundefinedweapon(_id_E170A74F4CB5D9D5))
    _id_D8F12E845F2A6C40 = getweaponattachments(_id_E170A74F4CB5D9D5);

  return ["name", _id_1DA7BFA6BC897E5E(player), "team", _id_78707B6B4CB17A1C(player.sessionteam), "origin", _id_A3D4800B4CB51B38(_id_FB5A2DA2D4C3C2E7.origin), "viewangles", _id_A3D4800B4CB51B38(_id_FB5A2DA2D4C3C2E7.angles), "weapon", weapon_name, "weapon_attachments", _id_D8F12E845F2A6C40];
}

_id_770A5E6A8A9E1289() {
  player = self;
  return ["is_ads", player scripts\mp\utility\player::isplayerads(), "is_flashed", istrue(player.flashbanged), "is_interacting_objective", player _id_D824247CAFD98AFC()];
}

_id_393BAF20DB478C0D() {
  _id_8773797D27789D6E();
  _id_62268A7BB3B85F6C();
}

_id_F5F91665FE4DBA94(data) {
  _id_458CE094FBF47BE3(data);

  foreach(player in level.players) {
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = player;
    _id_E60B22A0532246A9(_id_7E2C53B0BCF117D9);
  }
}

_id_8EEEA3969DF7E964() {
  level thread _id_D3C6179B65106833();
  level thread _id_036FA9AA217C6858();
  _id_EBACC818C229D2E3();
}

_id_A51C2C04A3F452CC(player) {
  if(player _meth_8420670EAFC8D391()) {
    return;
  }
  player _id_2CBDF94F9506AD4F();
}

on_player_connect(player) {
  if(player _meth_8420670EAFC8D391()) {
    return;
  }
  if(!isDefined(player._id_F038145F52E97CE3))
    player._id_F038145F52E97CE3 = spawnStruct();

  if(!isDefined(player._id_934379620852E329))
    player _id_42AFC3BFBB1E92CB();
}

_id_5F84AFC437FF71F9(data) {
  if(!isDefined(data.attacker)) {
    return;
  }
  data.victim _id_E2EC18C5B7DE4FB6();
  _id_A9D9E4DD889A4258(data);
}

on_player_disconnect(data) {
  player = data.player;

  if(player _meth_8420670EAFC8D391() || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }
  _id_E44C9440AAAE891B = player._id_F038145F52E97CE3;

  if(!istrue(_id_E44C9440AAAE891B._id_E1ACBA5CA849CFC5))
    _id_49472736AF222FCC(data);

  if(!istrue(_id_E44C9440AAAE891B._id_D1092FECB16D3B3C))
    _id_E60B22A0532246A9(data);

  _id_B30FD7D465D6D57C(data);
}

_id_EC68F43C79E586DC() {
  _func_D47580052756D597();
  _id_035554AE84383490 = ["game_type", level.gametype, "map_name", level.mapname, "team1_name", _id_78707B6B4CB17A1C("allies"), "team2_name", _id_78707B6B4CB17A1C("axis")];
  dlog_recordevent("dlog_event_esports_server_start", _id_035554AE84383490);
}

_id_8773797D27789D6E() {
  _id_035554AE84383490 = ["game_type", level.gametype, "map_name", level.mapname, "team1_name", _id_78707B6B4CB17A1C("allies"), "team2_name", _id_78707B6B4CB17A1C("axis")];
  dlog_recordevent("dlog_event_esports_match_start", _id_035554AE84383490);
}

_id_458CE094FBF47BE3(data) {
  _id_035554AE84383490 = ["match_time", _id_22DE454B228D857C(), "team1_score", getteamscore("allies"), "team2_score", getteamscore("axis"), "win_team", _id_B4324BFCD55B4E28(data.winner)];
  dlog_recordevent("dlog_event_esports_match_end", _id_035554AE84383490);
}

_id_A6C2B5A6203B8813() {
  _id_035554AE84383490 = ["game_timer", int(scripts\mp\gamelogic::gettimeremaining() / 1000), "objective_timer", int(_id_AAE4068942E8BC69() / 1000), "team1_score", getteamscore("allies"), "team2_score", getteamscore("axis")];
  _id_21E140B4AAAF4563 = "dlog_event_esports_match_interval_info";
  dlog_recordevent(_id_21E140B4AAAF4563, _id_035554AE84383490);
}

_id_EBACC818C229D2E3() {
  _id_00F011BE8C331F0F = _id_8B0F3D64EE5D77DA();
  _id_035554AE84383490 = ["team1_side", _id_00F011BE8C331F0F._id_CF29D316C16E2753, "team2_side", _id_00F011BE8C331F0F._id_CF29D416C16E2986];
  dlog_recordevent("dlog_event_esports_round_start", _id_035554AE84383490);
}

_id_B610A0D728DFA59E(data) {
  if(!scripts\mp\utility\game::isroundbased()) {
    return;
  }
  _id_DE108426AAF2883C = _id_BD8CFC6E4A98DEE6(data.winner);
  _id_035554AE84383490 = ["result", _id_DF75E8BD68B005F0(data._id_C7C58523552F1A6F), "win_side", _id_DE108426AAF2883C._id_A66BA9B157533F5A, "match_time", _id_22DE454B228D857C(), "win_team", _id_78707B6B4CB17A1C(_id_DE108426AAF2883C._id_2886F2D139E0660F), "loss_team", _id_78707B6B4CB17A1C(_id_DE108426AAF2883C._id_CA44196B95E71FB2)];
  dlog_recordevent("dlog_event_esports_round_end", _id_035554AE84383490);
}

_id_62268A7BB3B85F6C() {
  _id_035554AE84383490 = [];
  objectives = scripts\engine\utility::ter_op(isDefined(level.objectives), level.objectives, []);
  _id_12632B94C52C98A0 = [];

  foreach(objective in objectives)
  _id_12632B94C52C98A0 = scripts\engine\utility::array_add(_id_12632B94C52C98A0, _id_3FC5FD079E76A114(objective));

  _id_035554AE84383490 = scripts\engine\utility::array_add(_id_035554AE84383490, "objectives_info");
  _id_035554AE84383490 = scripts\engine\utility::array_add(_id_035554AE84383490, _id_12632B94C52C98A0);
  _id_21E140B4AAAF4563 = "dlog_event_esports_objective_info";
  dlog_recordevent(_id_21E140B4AAAF4563, _id_035554AE84383490);
}

_id_AA01FE87EE1CB415(_id_035554AE84383490, _id_418408E3F965A0B1) {
  _id_A732514EB4FCC312 = _id_418408E3F965A0B1._id_A732514EB4FCC312;
  _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["obj_name", _id_BFFB24C16C411C32()]);
  _id_035554AE84383490 = scripts\engine\utility::array_add(_id_035554AE84383490, "objective_state_zone");
  _id_035554AE84383490 = scripts\engine\utility::array_add(_id_035554AE84383490, ["is_captured", _id_A732514EB4FCC312 != "none", "is_contested", self.stalemate, "tiers_captured", 0]);
  return _id_035554AE84383490;
}

_id_9576E752AED74566(_id_035554AE84383490, _id_418408E3F965A0B1) {
  player = _id_418408E3F965A0B1._id_22282E7D48CA3400;
  _id_E51AEADAA76BE945 = 0;

  if(isDefined(player))
    _id_E51AEADAA76BE945 = player.isbombcarrier;

  _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["obj_name", _id_E553B81F7F609A5B()]);
  _id_035554AE84383490 = scripts\engine\utility::array_add(_id_035554AE84383490, "objective_state_bomb");
  _id_035554AE84383490 = scripts\engine\utility::array_add(_id_035554AE84383490, ["is_bomb_picked_up", _id_E51AEADAA76BE945, "is_bomb_planted", level.bombplanted, "is_bomb_defused", level.bombdefused]);
  return _id_035554AE84383490;
}

_id_935AD059F8BC1AE8(_id_035554AE84383490, _id_418408E3F965A0B1) {
  _id_A732514EB4FCC312 = _id_418408E3F965A0B1._id_A732514EB4FCC312;
  _id_FCB44162C4A9E3C1 = 0;

  if(isDefined(self._id_AE9B09D28693B763))
    _id_FCB44162C4A9E3C1 = self._id_AE9B09D28693B763;

  _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["obj_name", _id_50280CF505622041()]);
  _id_035554AE84383490 = scripts\engine\utility::array_add(_id_035554AE84383490, "objective_state_zone");
  _id_035554AE84383490 = scripts\engine\utility::array_add(_id_035554AE84383490, ["is_captured", self.claimteam != "none" && self.claimteam != self.ownerteam, "is_contested", self.stalemate, "tiers_captured", _id_FCB44162C4A9E3C1]);
  return _id_035554AE84383490;
}

_id_0CD0B801A8B092CA(data) {
  if(!isDefined(self.objidnum)) {
    return;
  }
  _id_22282E7D48CA3400 = data._id_22282E7D48CA3400;
  _id_239B4B5FA4BCF6C6 = data._id_239B4B5FA4BCF6C6;
  _id_55BED569A266A992 = "none";
  _id_A732514EB4FCC312 = "none";

  if(isDefined(_id_22282E7D48CA3400)) {
    _id_55BED569A266A992 = _id_1DA7BFA6BC897E5E(_id_22282E7D48CA3400);
    _id_A732514EB4FCC312 = _id_78707B6B4CB17A1C(_id_22282E7D48CA3400.sessionteam);
  }

  _id_035554AE84383490 = ["player_name", _id_55BED569A266A992, "obj_pos", _id_A3D4800B4CB51B38(self.curorigin), "obj_team", _id_A732514EB4FCC312, "match_time", _id_22DE454B228D857C()];
  _id_21E140B4AAAF4563 = "dlog_event_esports_objective_state_changed";

  if(isDefined(level._id_CB98C0FDA2FD2C79)) {
    _id_418408E3F965A0B1 = spawnStruct();
    _id_418408E3F965A0B1._id_22282E7D48CA3400 = _id_22282E7D48CA3400;
    _id_418408E3F965A0B1._id_A732514EB4FCC312 = _id_A732514EB4FCC312;
    _id_035554AE84383490 = self[[level._id_CB98C0FDA2FD2C79._id_0D1E945B3A961AEE]](_id_035554AE84383490, _id_418408E3F965A0B1);
  }

  if(!scripts\engine\utility::array_contains_key(_id_035554AE84383490, "obj_name"))
    _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["obj_name", ""]);

  dlog_recordevent(_id_21E140B4AAAF4563, _id_035554AE84383490);
}

_id_B30FD7D465D6D57C(data) {
  player = data.player;
  _id_035554AE84383490 = ["player_name", _id_1DA7BFA6BC897E5E(player)];
  player dlog_recordplayerevent("dlog_event_esports_player_disconnect", _id_035554AE84383490);
}

_id_ED4B9C7445B52BE8(player) {
  _id_A00884ED3A6D8B4B = player.origin;
  _id_DEE6508B0BA437C5 = player getplayerangles();
  _id_035554AE84383490 = ["player_name", _id_1DA7BFA6BC897E5E(player), "player_team", _id_78707B6B4CB17A1C(player.sessionteam), "match_time", _id_22DE454B228D857C(), "origin", _id_A3D4800B4CB51B38(_id_A00884ED3A6D8B4B)];
  player dlog_recordplayerevent("dlog_event_esports_player_spawned", _id_035554AE84383490);
}

_id_F93988444DECE179(_id_035554AE84383490, data) {
  _id_035554AE84383490[11] = scripts\engine\utility::array_combine(_id_035554AE84383490[11], ["is_planter_kill", 0, "is_defuser_kill", 0, "is_ace_kill", 0, "is_rotation_kill", _id_D303E25D324B2874()]);
  return _id_035554AE84383490;
}

_id_66D2B5499B862642(_id_035554AE84383490, data) {
  attacker = data.attacker;

  if(!isDefined(attacker))
    return _id_6E10CFDFA388094C(_id_035554AE84383490, data);

  victim = data.victim;
  _id_D1D276488B645D67 = scripts\engine\utility::ter_op(isDefined(attacker.modifiers), attacker.modifiers, []);
  _id_035554AE84383490[11] = scripts\engine\utility::array_combine(_id_035554AE84383490[11], ["is_planter_kill", istrue(_id_D1D276488B645D67["killed_planter"]), "is_defuser_kill", istrue(_id_D1D276488B645D67["killed_defuser"]), "is_ace_kill", _id_F1C3EE0FA29180A6(attacker, victim), "is_rotation_kill", 0]);
  return _id_035554AE84383490;
}

_id_6E10CFDFA388094C(_id_035554AE84383490, data) {
  _id_035554AE84383490[11] = scripts\engine\utility::array_combine(_id_035554AE84383490[11], ["is_planter_kill", 0, "is_defuser_kill", 0, "is_ace_kill", 0, "is_rotation_kill", 0]);
  return _id_035554AE84383490;
}

_id_A9D9E4DD889A4258(data) {
  victim = data.victim;
  _id_5B88FD6CC81411A4 = victim.lastdeathpos;
  _id_51E0B68E2CD1EDE6 = victim.lastdeathangles;
  attacker = data.attacker;

  if(isPlayer(attacker)) {
    _id_DFEF631FE41340B9 = attacker.origin;
    _id_522FED3F783C2E47 = attacker getplayerangles();
    _id_2A8DBAD5E36EBD27 = data.objweapon;
    _id_D1D276488B645D67 = scripts\engine\utility::ter_op(isDefined(attacker.modifiers), attacker.modifiers, []);
    _id_07FF0A085AE13029 = spawnStruct();
    _id_07FF0A085AE13029.origin = _id_DFEF631FE41340B9;
    _id_07FF0A085AE13029.angles = _id_522FED3F783C2E47;
    _id_07FF0A085AE13029.weapon = _id_2A8DBAD5E36EBD27;
    _id_3812D02E5F7A0DA3 = attacker _id_B433743DC5925931(_id_07FF0A085AE13029);
    _id_7633E290EC9D496C = attacker _id_770A5E6A8A9E1289();
    _id_0D2774C984EE5725 = scripts\engine\utility::within_fov(_id_5B88FD6CC81411A4, _id_51E0B68E2CD1EDE6, _id_DFEF631FE41340B9, 0.4226);
    _id_A7C2F31A09E71E49 = scripts\engine\utility::within_fov(_id_DFEF631FE41340B9, _id_522FED3F783C2E47, _id_5B88FD6CC81411A4, 0.4226);
    _id_0AC1DDB4721CB285 = 0;
    _id_7639389406E14C2E = attacker scripts\mp\supers::getcurrentsuper();

    if(isDefined(_id_7639389406E14C2E) && attacker scripts\mp\supers::issuperinuse() && _id_7639389406E14C2E.staticdata.ref == "super_deadsilence")
      _id_0AC1DDB4721CB285 = 1;

    _id_9E8E5FCDE2231379 = ["is_longshot_kill", istrue(_id_D1D276488B645D67["longshot"]), "is_pointblank_kill", istrue(_id_D1D276488B645D67["pointblank"]), "is_first_blood", istrue(_id_D1D276488B645D67["firstblood"]), "is_revenge_kill", istrue(_id_D1D276488B645D67["revenge"]), "is_wallbang", _id_1E412FB6D8CBC655(data), "attacker_in_victim_fov", _id_0D2774C984EE5725, "victim_in_attacker_fov", _id_A7C2F31A09E71E49, "is_dead_silence_kill", _id_0AC1DDB4721CB285];
    _id_74AB2CA99FB2F775 = distance(_id_DFEF631FE41340B9, _id_5B88FD6CC81411A4);
  } else {
    _id_3812D02E5F7A0DA3 = [];
    _id_7633E290EC9D496C = [];
    _id_9E8E5FCDE2231379 = [];
    _id_74AB2CA99FB2F775 = 0.0;
  }

  _id_8367DC8C497F4C02 = victim.lastweaponused;
  _id_54AC843C056A6336 = spawnStruct();
  _id_54AC843C056A6336.origin = _id_5B88FD6CC81411A4;
  _id_54AC843C056A6336.angles = _id_51E0B68E2CD1EDE6;
  _id_54AC843C056A6336.weapon = _id_8367DC8C497F4C02;
  _id_B16A17C14DE95BDA = victim _id_B433743DC5925931(_id_54AC843C056A6336);
  _id_43C8B33F18127C89 = victim _id_770A5E6A8A9E1289();
  _id_B0F559936C1B6BAE = ["match_time", _id_22DE454B228D857C(), "means_of_death", data.meansofdeath, "players_distance", _id_74AB2CA99FB2F775];
  _id_035554AE84383490 = ["info", _id_B0F559936C1B6BAE, "attacker", _id_3812D02E5F7A0DA3, "attacker_status", _id_7633E290EC9D496C, "victim", _id_B16A17C14DE95BDA, "victim_status", _id_43C8B33F18127C89, "kill_context", _id_9E8E5FCDE2231379];
  _id_21E140B4AAAF4563 = "dlog_event_esports_player_killed";

  if(isDefined(level._id_2B79862D8E89E043))
    _id_035554AE84383490 = self[[level._id_2B79862D8E89E043._id_0D1E945B3A961AEE]](_id_035554AE84383490, data);

  victim dlog_recordplayerevent(_id_21E140B4AAAF4563, _id_035554AE84383490);
}

_id_664E133F4636982C(_id_035554AE84383490, _id_2DBFE016101D4381, _id_934379620852E329) {
  _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["hill_time", scripts\mp\codcasterclientmatchdata::_id_A08FEA26A49145A8(0), "contested_hill_time", scripts\mp\codcasterclientmatchdata::_id_A08FEA26A49145A8(12)]);
  return _id_035554AE84383490;
}

_id_20524D471D23D817(_id_035554AE84383490, _id_2DBFE016101D4381, _id_934379620852E329) {
  _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["bombs_planted", _id_2DBFE016101D4381["plants"], "bombs_defused", _id_2DBFE016101D4381["defuses"], "sneak_defuses", _id_2DBFE016101D4381["sneakDefuses"]]);
  return _id_035554AE84383490;
}

_id_3A0BBA2841CC215B(_id_035554AE84383490, _id_2DBFE016101D4381, _id_934379620852E329) {
  _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["total_objectives_captured", _id_2DBFE016101D4381["captures"], "objective_tiers_contributed", scripts\mp\codcasterclientmatchdata::_id_A08FEA26A49145A8(8)]);
  return _id_035554AE84383490;
}

_id_E60B22A0532246A9(data) {
  player = data.player;

  if(player _meth_8420670EAFC8D391()) {
    return;
  }
  _id_2DBFE016101D4381 = player.pers;
  _id_934379620852E329 = player._id_934379620852E329;
  _id_51E6CE77B3D9CC11 = _id_C56D015E4CD2E47C(_id_2DBFE016101D4381);
  _id_022677881BD1351D = _id_2DBFE016101D4381["cur_kill_streak"];
  _id_367DD5A8D820C25F = 0.0;

  if(isDefined(_id_2DBFE016101D4381["totalDistTraveled"]))
    _id_367DD5A8D820C25F = float(_id_2DBFE016101D4381["totalDistTraveled"]);

  _id_035554AE84383490 = ["player_name", _id_1DA7BFA6BC897E5E(player), "kills", _id_2DBFE016101D4381["kills"], "deaths", _id_2DBFE016101D4381["deaths"], "assists", _id_2DBFE016101D4381["assists"], "score", _id_2DBFE016101D4381["score"], "highest_streak", _id_2DBFE016101D4381["longestStreak"], "shots_fired", player scripts\mp\codcasterclientmatchdata::_id_E42724FBFACFF469(0), "shots_hit", player scripts\mp\codcasterclientmatchdata::_id_E42724FBFACFF469(1), "shots_head", _id_2DBFE016101D4381["shotsHitHead"], "untraded_kills", player scripts\mp\codcasterclientmatchdata::_id_815FEE43D577E1B6(5), "untraded_deaths", _id_2DBFE016101D4381["untradedDeaths"], "traded_kills", _id_2DBFE016101D4381["tradedKills"], "traded_deaths", _id_2DBFE016101D4381["tradedDeaths"], "inapplicable_traded_kills", _id_2DBFE016101D4381["inapplicableTradedKills"], "inapplicable_traded_deaths", _id_2DBFE016101D4381["inapplicableTradedDeaths"], "damage_dealt", player scripts\mp\codcasterclientmatchdata::_id_815FEE43D577E1B6(1), "damage_taken", scripts\engine\utility::ter_op(isDefined(_id_2DBFE016101D4381["damageTaken"]), _id_2DBFE016101D4381["damageTaken"], 0), "damage_healed", _id_2DBFE016101D4381["damageHealed"], "damage_friend", _id_2DBFE016101D4381["friendlyDamageDone"], "tacticals_used", _id_2DBFE016101D4381["tacticalsUsed"], "lethals_used", _id_2DBFE016101D4381["lethalsUsed"], "time_alive", scripts\engine\utility::ter_op(_id_2DBFE016101D4381["total_time_alive"] == 0, _id_22DE454B228D857C(), _id_2DBFE016101D4381["total_time_alive"]), "distance_traveled", _id_367DD5A8D820C25F, "average_speed", _id_51E6CE77B3D9CC11._id_A37E2059959D3204, "percent_time_moving", _id_51E6CE77B3D9CC11._id_3ECB392A578C4F31, "dead_silence_time", int(_id_2DBFE016101D4381["deadSilenceTime"] / 1000)];
  _id_21E140B4AAAF4563 = "dlog_event_esports_player_match_end";

  if(isDefined(level._id_B290423F07C0FA3C)) {
    _id_21E140B4AAAF4563 = level._id_B290423F07C0FA3C._id_21E140B4AAAF4563;
    _id_035554AE84383490 = player[[level._id_B290423F07C0FA3C._id_0D1E945B3A961AEE]](_id_035554AE84383490, _id_2DBFE016101D4381, player._id_934379620852E329);
  }

  player dlog_recordplayerevent(_id_21E140B4AAAF4563, _id_035554AE84383490);
  player._id_F038145F52E97CE3._id_D1092FECB16D3B3C = 1;
}

_id_C22652F83B317B82() {
  _id_78631BFB7B795754 = [];

  foreach(player in level.players) {
    if(!isDefined(player) || player _meth_8420670EAFC8D391()) {
      continue;
    }
    _id_2DBFE016101D4381 = player.pers;
    _id_035554AE84383490 = ["player_name", _id_1DA7BFA6BC897E5E(player), "origin", _id_A3D4800B4CB51B38(player.origin), "viewangles", _id_A3D4800B4CB51B38(player getplayerangles())];

    if(isDefined(level._id_F8FA0C6BB4B9DE4E))
      _id_035554AE84383490 = player[[level._id_F8FA0C6BB4B9DE4E._id_0D1E945B3A961AEE]](_id_035554AE84383490);

    _id_1F934BFC41F3A853 = spawnStruct();
    _id_1F934BFC41F3A853.player = player;
    _id_1F934BFC41F3A853.event = _id_035554AE84383490;
    _id_78631BFB7B795754 = scripts\engine\utility::array_add(_id_78631BFB7B795754, _id_1F934BFC41F3A853);
  }

  _id_21E140B4AAAF4563 = "dlog_event_esports_player_interval_info";

  if(isDefined(level._id_F8FA0C6BB4B9DE4E))
    _id_21E140B4AAAF4563 = level._id_F8FA0C6BB4B9DE4E._id_21E140B4AAAF4563;

  foreach(_id_1F934BFC41F3A853 in _id_78631BFB7B795754) {
    player = _id_1F934BFC41F3A853.player;

    if(!isDefined(player)) {
      continue;
    }
    player dlog_recordplayerevent(_id_21E140B4AAAF4563, _id_1F934BFC41F3A853.event);
    waitframe();
  }
}

_id_1B1EE2699A6A524C(_id_035554AE84383490, _id_2DBFE016101D4381, _id_934379620852E329) {
  _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["bombs_planted", _id_2DBFE016101D4381["plants"] - _id_934379620852E329._id_F25A28C3777E1385, "bombs_defused", _id_2DBFE016101D4381["defuses"] - _id_934379620852E329._id_F9A1367B78F32A17, "sneak_defuses", _id_2DBFE016101D4381["sneakDefuses"] - _id_934379620852E329._id_F6A4C20651DA07C3]);
  return _id_035554AE84383490;
}

_id_7B9680C1E187BD00(_id_035554AE84383490, _id_2DBFE016101D4381, _id_934379620852E329) {
  _id_035554AE84383490 = scripts\engine\utility::array_combine(_id_035554AE84383490, ["tiers_captured", scripts\mp\codcasterclientmatchdata::_id_A08FEA26A49145A8(8) - _id_934379620852E329._id_FCB44162C4A9E3C1]);
  return _id_035554AE84383490;
}

_id_49472736AF222FCC(data) {
  player = data.player;

  if(player _meth_8420670EAFC8D391() || !scripts\mp\utility\game::isroundbased()) {
    return;
  }
  player _id_D21DFE417B65B64A();
  _id_2DBFE016101D4381 = player.pers;
  _id_934379620852E329 = player._id_934379620852E329;
  _id_022677881BD1351D = _id_2DBFE016101D4381["cur_kill_streak"];
  _id_51E6CE77B3D9CC11 = player _id_3DDC4F55DFE66EBB();
  _id_3D1EA5C9BF625DE6 = 0.0;

  if(isDefined(_id_2DBFE016101D4381["totalDistTraveled"]))
    _id_3D1EA5C9BF625DE6 = float(_id_2DBFE016101D4381["totalDistTraveled"]);

  _id_035554AE84383490 = ["player_name", _id_1DA7BFA6BC897E5E(player), "round_number", _id_B6C29E08764AE361(), "round_won", scripts\engine\utility::ter_op(isDefined(player.team) && data.winner == player.team, 1, 0), "kills", _id_2DBFE016101D4381["kills"] - _id_934379620852E329.kills, "deaths", _id_2DBFE016101D4381["deaths"] - _id_934379620852E329.deaths, "assists", _id_2DBFE016101D4381["assists"] - _id_934379620852E329.assists, "score", _id_2DBFE016101D4381["score"] - _id_934379620852E329.score, "highest_streak", _id_2DBFE016101D4381["longestStreak"], "shots_fired", player scripts\mp\codcasterclientmatchdata::_id_E42724FBFACFF469(0) - _id_934379620852E329.shots_fired, "shots_hit", player scripts\mp\codcasterclientmatchdata::_id_E42724FBFACFF469(1) - _id_934379620852E329.shots_hit, "shots_head", _id_2DBFE016101D4381["shotsHitHead"] - _id_934379620852E329._id_E61D71A6E5C3E7A1, "untraded_kills", player scripts\mp\codcasterclientmatchdata::_id_815FEE43D577E1B6(5) - _id_934379620852E329._id_53A5BA21527A8036, "untraded_deaths", _id_2DBFE016101D4381["untradedDeaths"] - _id_934379620852E329._id_2236966986B7BC12, "traded_kills", _id_2DBFE016101D4381["tradedKills"] - _id_934379620852E329._id_9F2DE5B1B23CA7F5, "traded_deaths", _id_2DBFE016101D4381["tradedDeaths"] - _id_934379620852E329._id_6F9D3EDD52C8141F, "inapplicable_traded_kills", _id_2DBFE016101D4381["inapplicableTradedKills"] - _id_934379620852E329._id_F33C4C6C651980B8, "inapplicable_traded_deaths", _id_2DBFE016101D4381["inapplicableTradedDeaths"] - _id_934379620852E329._id_7FBC4327B7F5C574, "damage_dealt", player scripts\mp\codcasterclientmatchdata::_id_815FEE43D577E1B6(1) - _id_934379620852E329._id_3FDFC409E09D574D, "damage_taken", scripts\engine\utility::ter_op(isDefined(_id_2DBFE016101D4381["damageTaken"]), _id_2DBFE016101D4381["damageTaken"], 0) - _id_934379620852E329.damage_taken, "damage_healed", _id_2DBFE016101D4381["damageHealed"] - _id_934379620852E329._id_0C0B6808E1B1983E, "damage_friend", _id_2DBFE016101D4381["friendlyDamageDone"] - _id_934379620852E329._id_62D91C98F2E6FD01, "tacticals_used", _id_2DBFE016101D4381["tacticalsUsed"] - _id_934379620852E329._id_07FC806C5CD9720B, "lethals_used", _id_2DBFE016101D4381["lethalsUsed"] - _id_934379620852E329._id_6C8595EC09D557EC, "time_alive", scripts\engine\utility::ter_op(_id_2DBFE016101D4381["total_time_alive"] == 0, _id_22DE454B228D857C(), _id_2DBFE016101D4381["total_time_alive"]) - _id_934379620852E329._id_9875B868BB8A4936, "distance_traveled", _id_3D1EA5C9BF625DE6 - _id_934379620852E329._id_3D1EA5C9BF625DE6, "average_speed", _id_51E6CE77B3D9CC11._id_A37E2059959D3204, "percent_time_moving", _id_51E6CE77B3D9CC11._id_3ECB392A578C4F31, "dead_silence_time", int((_id_2DBFE016101D4381["deadSilenceTime"] - _id_934379620852E329._id_69178EE1F1771889) / 1000)];
  _id_21E140B4AAAF4563 = "dlog_event_esports_player_round_end";

  if(isDefined(level._id_9F33F41B213A1BE7)) {
    _id_21E140B4AAAF4563 = level._id_9F33F41B213A1BE7._id_21E140B4AAAF4563;
    _id_035554AE84383490 = player[[level._id_9F33F41B213A1BE7._id_0D1E945B3A961AEE]](_id_035554AE84383490, _id_2DBFE016101D4381, _id_934379620852E329);
  }

  player dlog_recordplayerevent(_id_21E140B4AAAF4563, _id_035554AE84383490);
  player._id_F038145F52E97CE3._id_E1ACBA5CA849CFC5 = 1;
}

_id_C82D72EBCDB14059(data) {
  player = data.player;

  if(player _meth_8420670EAFC8D391()) {
    return;
  }
  struct = data.struct;
  killstreaks = [struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3];
  _id_30BE14BB3AE12709 = [struct.loadoutfieldupgrade1, struct.loadoutfieldupgrade2];
  perks = struct.loadoutperks;

  if(isDefined(struct._id_15F3E6DF722FB1CF) && struct._id_15F3E6DF722FB1CF != "none" && !perkisrestricted(struct._id_15F3E6DF722FB1CF))
    perks = scripts\engine\utility::array_add(perks, struct._id_15F3E6DF722FB1CF);

  if(isDefined(struct._id_15F3E5DF722FAF9C) && struct._id_15F3E5DF722FAF9C != "none" && !perkisrestricted(struct._id_15F3E5DF722FAF9C))
    perks = scripts\engine\utility::array_add(perks, struct._id_15F3E5DF722FAF9C);

  _id_FBE6BD6CAE9A4107 = ["none"];

  if(isDefined(struct.loadoutprimaryattachments) && struct.loadoutprimaryattachments.size > 0)
    _id_FBE6BD6CAE9A4107 = struct.loadoutprimaryattachments;

  _id_ADF81A5E7BEE3347 = ["none"];

  if(isDefined(struct.loadoutsecondaryattachments) && struct.loadoutsecondaryattachments.size > 0)
    _id_ADF81A5E7BEE3347 = struct.loadoutsecondaryattachments;

  _id_035554AE84383490 = ["player_name", _id_1DA7BFA6BC897E5E(player), "primary_weapon", struct.loadoutprimary, "primary_weapon_attachments", _id_FBE6BD6CAE9A4107, "secondary_weapon", struct.loadoutsecondary, "secondary_weapon_attachments", _id_ADF81A5E7BEE3347, "primary_grenade", struct.loadoutequipmentprimary, "secondary_grenade", struct.loadoutequipmentsecondary, "field_upgrades", _id_30BE14BB3AE12709, "streaks", killstreaks, "perks", perks, "match_time", _id_22DE454B228D857C()];
  player dlog_recordplayerevent("dlog_event_esports_player_loadout_changed", _id_035554AE84383490);
}