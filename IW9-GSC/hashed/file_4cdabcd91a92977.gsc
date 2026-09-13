/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4cdabcd91a92977.gsc
***********************************************/

main() {
  if(!getdvarint("dvar_022EDDF44003BAF9", 0)) {
    return;
  }
  level._id_156E078B5445FFAA = _func_4F9373A1227DB35C();
  level._id_73E946A3EADC84BE = _func_08345F2AC499E5AB();
  level._id_0F60AB21FBEB423C = undefined;
  level._id_37767375D12E7150 = [];
  level._id_3DA7CF812433FD50 = getdvarint("dvar_35FE3B926D86A034", 1);
  level._id_E20AF527A1D336F6 = getdvarint("dvar_D5FF0D8A153049ED", 1);
  level._id_93535D58322394F6 = getdvarint("dvar_52278A2E894C7B5B", 5);
  level._id_41A1383064B06B78 = getdvarint("dvar_730841E9076CB2D7", 1) == 1;
  level._id_A92EFEEF2C4F6E45 = getdvarint("dvar_5D13C057B0E9CC7B", 0) == 1;
  level._id_8C4A1A7B619D8E7C = getdvarint("dvar_AE52A11CD305AB26", 1) == 1;
  level._id_BCD757FB7C2137B1 = getdvarfloat("dvar_522795FEB86C7C2A", 1.0);
  level._id_83B8CF86AE62E3DA = undefined;

  if(!isDefined(game["rejoinedPlayers"]))
    game["rejoinedPlayers"] = [];

  level thread _id_860ADE42D09BCC50();
  level thread _id_990E6E94FEF53E1A();
}

_id_E3BD94413509BC25() {
  return getdvarint("dvar_925F7DCEB8E6205E", 0) && getdvarint("dvar_022EDDF44003BAF9", 0);
}

_id_8CE5B106FBBA9E9F(_id_ABE916E564C32276) {
  level._id_0F60AB21FBEB423C = _id_ABE916E564C32276;
}

_id_8FE6D6539ED31A88(_id_ABE916E564C32276) {
  if(!getdvarint("dvar_022EDDF44003BAF9", 0)) {
    return;
  }
  if(!isDefined(level._id_37767375D12E7150))
    level._id_37767375D12E7150 = [];

  level._id_37767375D12E7150[level._id_37767375D12E7150.size] = _id_ABE916E564C32276;
}

_id_0EAD10448A780A58(_id_ABE916E564C32276) {
  if(!getdvarint("dvar_022EDDF44003BAF9", 0)) {
    return;
  }
  level._id_83B8CF86AE62E3DA = _id_ABE916E564C32276;
}

_id_884994E73914EE32() {
  if(isDefined(level._id_0F60AB21FBEB423C))
    return [[level._id_0F60AB21FBEB423C]](self);

  return [];
}

_id_19F146E8FFA78FF9(_id_934DC135AAF6F953) {
  if(isDefined(level._id_83B8CF86AE62E3DA))
    return [[level._id_83B8CF86AE62E3DA]](self, _id_934DC135AAF6F953);

  return 1;
}

_id_71FBBBF19EDCEF28() {
  if(istrue(level._id_E20AF527A1D336F6)) {
    _id_6D5ED003AF1F9612 = level.teamdata[self.team]["alivePlayers"];
    _id_FFC368C1D2A95B7B = 0;

    foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
      if(self == _id_F0EA4030349A33D5) {
        continue;
      }
      _id_FFC368C1D2A95B7B++;
    }

    if(_id_FFC368C1D2A95B7B > 0)
      return 1;
    else
      return 0;
  }

  return 1;
}

_id_C9B26CFB4D93AE50() {
  if(isDefined(level._id_93535D58322394F6) && level._id_93535D58322394F6 >= 1) {
    _id_75A8EB8AF196B837 = 0;

    foreach(_id_F90358454413407F in level.teamnamelist) {
      _id_BCE4EFC75EB01319 = level.teamdata[_id_F90358454413407F]["aliveCount"];

      if(_id_BCE4EFC75EB01319 > 0)
        _id_75A8EB8AF196B837++;

      if(_id_75A8EB8AF196B837 >= level._id_93535D58322394F6)
        return 1;
    }

    return 0;
  }

  return 1;
}

_id_87FC9992C0B60276(_id_C4F3E9732AA81389) {
  _id_9642449AFA2EBF37 = 0;

  switch (_id_C4F3E9732AA81389) {
    case 0:
      _id_9642449AFA2EBF37 = 0;
      break;
    case 2:
    case 1:
      _id_9642449AFA2EBF37 = getdvarint("dvar_1839B10B70A97D91", 0);
      break;
    case 3:
      _id_9642449AFA2EBF37 = getdvarint("dvar_F690F29F47F7A379", 0);
      break;
    case 6:
      _id_9642449AFA2EBF37 = getdvarint("dvar_B37DBAA903C45CCD", 1);
      break;
    case 7:
      _id_9642449AFA2EBF37 = getdvarint("dvar_BEA9CF0DCCF411EC", 0);
      break;
    case 14:
      _id_9642449AFA2EBF37 = getdvarint("dvar_8F3ADC0694DED53C", 0);
      break;
    default:
      _id_9642449AFA2EBF37 = 1;
      break;
  }

  if(!_id_9642449AFA2EBF37)
    return 0;

  _id_9642449AFA2EBF37 = _id_19F146E8FFA78FF9(_id_C4F3E9732AA81389);

  if(!_id_9642449AFA2EBF37)
    return 0;

  _id_9642449AFA2EBF37 = _id_C9B26CFB4D93AE50();

  if(!_id_9642449AFA2EBF37)
    return 0;

  _id_9642449AFA2EBF37 = _id_71FBBBF19EDCEF28();

  if(!_id_9642449AFA2EBF37)
    return 0;

  return 1;
}

_id_69359E69555329AC(_id_934DC135AAF6F953) {
  player = self;
  level endon("game_ended");
  player notify("rejoin_analytics_start");
  player endon("rejoin_analytics_start");
  isplayeronground = player isonground();
  _id_DD693A5D8A7F7511 = player scripts\cp_mp\utility\player_utility::isinvehicle();
  _id_56FBBE6C2C822322 = player _meth_E40102956C887F7C();
  _id_15AD7F4A17476A54 = player ispcplayer();
  _id_7D723D78C14B4A78 = player usinggamepad();
  playerorigin = player.origin;
  _id_79544F8FC581743A = gettime();
  playerteam = player.team;
  _id_3EE23976DEB888B9 = player scripts\engine\utility::waittill_any_return_2("successfully_disconnect_rejoin", "rejected_disconnect_rejoin");

  if(!isDefined(player)) {
    return;
  }
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "is_rejoin_successful";
  _id_65FE6E16A63F6FE2 = 0;

  if(isDefined(_id_3EE23976DEB888B9))
    _id_65FE6E16A63F6FE2 = scripts\engine\utility::ter_op(_id_3EE23976DEB888B9 == "successfully_disconnect_rejoin", 1, 0);

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_65FE6E16A63F6FE2;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "rejoin_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_934DC135AAF6F953;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "rejoin_duration";
  _id_02A52633A34D255C = -1;

  if(isDefined(_id_79544F8FC581743A))
    _id_02A52633A34D255C = (gettime() - _id_79544F8FC581743A) / 1000;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_02A52633A34D255C;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_x";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = playerorigin[0];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_y";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = playerorigin[1];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_z";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = playerorigin[2];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "squad_size";
  _id_52C67013BD17E0E0 = -1;

  if(isDefined(level.teamdata))
    _id_52C67013BD17E0E0 = int(level.teamdata[playerteam]["players"].size);

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_52C67013BD17E0E0;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_platform";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_15AD7F4A17476A54;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_input";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7D723D78C14B4A78;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "match_alive_players_left";
  _id_1F7BCAA53CA6D399 = -1;

  if(isDefined(level.teamnamelist) && isDefined(level.teamdata)) {
    foreach(_id_F90358454413407F in level.teamnamelist)
    _id_1F7BCAA53CA6D399 = _id_1F7BCAA53CA6D399 + level.teamdata[_id_F90358454413407F]["aliveCount"];

    _id_1F7BCAA53CA6D399++;
  }

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_1F7BCAA53CA6D399;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "is_player_swimming";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_56FBBE6C2C822322;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "is_player_in_vehicle";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_DD693A5D8A7F7511;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "is_player_on_ground";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = isplayeronground;
  player dlog_recordplayerevent("dlog_event_br_disconnect_rejoin", _id_EC6A81EAC0E4DC61);
}

_id_2E8537357F01A56B(_id_1E904D14A41D4385, key) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1E904D14A41D4385.size - 1; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
    if(_id_1E904D14A41D4385[_id_AC0E594AC96AA3A8] == key)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_2FCDC8C12F068ABB(_id_4F6FF34F222B0271, _id_4F6FF04F222AFBD8, _id_E1E0E4A54C3D275C) {
  _id_820A92B1182AE83E = [];

  if(!isarray(_id_4F6FF34F222B0271) || _id_4F6FF34F222B0271.size % 2 != 0 || !isarray(_id_4F6FF04F222AFBD8) || _id_4F6FF04F222AFBD8.size % 2 != 0) {
    scripts\engine\utility::error("called rejoin_utility::combineKVPArrays with invalid array");
    return _id_820A92B1182AE83E;
  }

  keys = [];
  values = [];
  _id_AC0E594AC96AA3A8 = 0;

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E594AC96AA3A8 < _id_4F6FF34F222B0271.size - 1 || _id_AC0E5C4AC96AAA41 < _id_4F6FF04F222AFBD8.size - 1; _id_AC0E5C4AC96AAA41 = _id_AC0E5C4AC96AAA41 + 2) {
    if(_id_AC0E594AC96AA3A8 < _id_4F6FF34F222B0271.size - 1 && !scripts\engine\utility::array_contains(keys, _id_4F6FF34F222B0271[_id_AC0E594AC96AA3A8])) {
      keys[keys.size] = _id_4F6FF34F222B0271[_id_AC0E594AC96AA3A8];
      values[values.size] = _id_4F6FF34F222B0271[_id_AC0E594AC96AA3A8 + 1];
    }

    if(_id_AC0E5C4AC96AAA41 < _id_4F6FF04F222AFBD8.size - 1 && !scripts\engine\utility::array_contains(keys, _id_4F6FF04F222AFBD8[_id_AC0E5C4AC96AAA41])) {
      keys[keys.size] = _id_4F6FF04F222AFBD8[_id_AC0E5C4AC96AAA41];
      values[values.size] = _id_4F6FF04F222AFBD8[_id_AC0E5C4AC96AAA41 + 1];
    }

    _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2;
  }

  _id_71EB150F91B3456B = scripts\engine\utility::ter_op(istrue(_id_E1E0E4A54C3D275C), _id_4F6FF04F222AFBD8, _id_4F6FF34F222B0271);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_71EB150F91B3456B.size - 1; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2) {
    key = _id_71EB150F91B3456B[_id_AC0E594AC96AA3A8];
    _id_2172DB62590952AE = scripts\engine\utility::array_find(keys, key);

    if(isDefined(_id_2172DB62590952AE))
      values[_id_2172DB62590952AE] = _id_71EB150F91B3456B[_id_AC0E594AC96AA3A8 + 1];
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    _id_820A92B1182AE83E[_id_820A92B1182AE83E.size] = keys[_id_AC0E594AC96AA3A8];
    _id_820A92B1182AE83E[_id_820A92B1182AE83E.size] = values[_id_AC0E594AC96AA3A8];
  }

  return _id_820A92B1182AE83E;
}

_id_DC60E20E9216B5B2() {
  if(!level.onlinegame) {
    return;
  }
  if(!getdvarint("dvar_022EDDF44003BAF9", 0)) {
    return;
  }
  _id_BA664F53DEA8A25C = getdvarint("dvar_925F7DCEB8E6205E", 0);
  _id_C5728699E6B79552(_id_BA664F53DEA8A25C);
}

_id_4064A2271DE12B97() {
  if(!getdvarint("dvar_022EDDF44003BAF9", 0)) {
    return;
  }
  _id_C5728699E6B79552(0);
  setDvar("dvar_925F7DCEB8E6205E", 0);
}

_id_342AF7EA8A120B16() {
  if(!level.onlinegame) {
    return;
  }
  if(!getdvarint("dvar_022EDDF44003BAF9", 0)) {
    return;
  }
  _id_BA664F53DEA8A25C = getdvarint("dvar_925F7DCEB8E6205E", 0);

  if(_id_BA664F53DEA8A25C)
    _id_74B707898164ED78(0, []);
  else
    _id_E90D7800FB5EEC03(0, []);
}

_id_59121677F31F75A5() {
  self endon("disconnect");
  level endon("game_ended");

  if(!getdvarint("dvar_022EDDF44003BAF9", 0)) {
    return;
  }
  xuid = self getxuid();

  if(getdvarint("dvar_7D06167BC4176E5E", 0)) {
    if(isDefined(level._id_67A646DC2B984DAC))
      self thread[[level._id_67A646DC2B984DAC]]();

    if(isDefined(level._id_62A7B43F2B60646D))
      self[[level._id_62A7B43F2B60646D]]();
  }

  if(!scripts\engine\utility::array_contains(game["rejoinedPlayers"], xuid))
    game["rejoinedPlayers"] = scripts\engine\utility::array_add_safe(game["rejoinedPlayers"], xuid);
  else {}

  self._id_632BAD3EDB4E449E = 0;
  self notify("successfully_disconnect_rejoin");
  self notify("afk_tracking_resume");
  self._id_0CBECE90C5BEEA82 = 0;

  if(isDefined(level._id_2F60D02380CD603D))
    self[[level._id_2F60D02380CD603D]]();

  if(isDefined(level._id_37767375D12E7150)) {
    foreach(callback in level._id_37767375D12E7150)[[callback]](self);
  }
}

_id_8CF8FF669AC52156(_id_934DC135AAF6F953, _id_CF51D5A9282DF88B) {
  _id_400CD07EC60D425C = _id_884994E73914EE32();
  _id_BA664F53DEA8A25C = getdvarint("dvar_925F7DCEB8E6205E", 0);

  if(getdvarint("dvar_022EDDF44003BAF9", 0) != 0 && _id_BA664F53DEA8A25C) {
    _id_C4F3E9732AA81389 = _id_4F6DF967144E2CB4(_id_934DC135AAF6F953);

    if(isDefined(_id_CF51D5A9282DF88B) && _id_CF51D5A9282DF88B)
      self._id_632BAD3EDB4E449E = 1;

    _id_38968EF355B4D2EC = 0;

    if(_id_C4F3E9732AA81389 != 0) {
      _id_38968EF355B4D2EC = _id_87FC9992C0B60276(_id_C4F3E9732AA81389);

      if(_id_38968EF355B4D2EC) {
        xuid = self getxuid();

        if(scripts\engine\utility::array_contains(game["rejoinedPlayers"], xuid)) {
          _id_C4F3E9732AA81389 = 5;
          _id_38968EF355B4D2EC = getdvarint("dvar_42D413A1A32E906F", 0);
        }
      }
    }

    if(!istrue(_id_CF51D5A9282DF88B))
      _id_38968EF355B4D2EC = 0;

    if(_id_38968EF355B4D2EC) {
      _id_74B707898164ED78(_id_C4F3E9732AA81389, _id_400CD07EC60D425C);
      thread _id_69359E69555329AC(_id_C4F3E9732AA81389);
      self._id_0CBECE90C5BEEA82 = 1;

      if(istrue(level._id_41A1383064B06B78)) {
        wait(level._id_BCD757FB7C2137B1);
        vehicle = self.vehicle;

        if(isDefined(vehicle)) {
          driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);

          if(isDefined(driver) && driver == self)
            thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(vehicle, undefined, self, undefined, 1);
        }
      }

      if(istrue(level._id_A92EFEEF2C4F6E45)) {
        wait(level._id_BCD757FB7C2137B1);
        self suicide();
        return;
      }

      return;
    }

    _id_E90D7800FB5EEC03(_id_C4F3E9732AA81389, _id_400CD07EC60D425C);
    self notify("rejected_disconnect_rejoin");
    return;
  } else
    _id_13399AA20634EDCE(_id_400CD07EC60D425C);
}

_id_860ADE42D09BCC50() {
  level endon("game_ended");

  for(;;) {
    _id_C248456FE9648490 = getdvarint("dvar_CB027608B7396745", 30);
    wait(_id_C248456FE9648490);
    _id_A1E7045E3E4CA353 = [];

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(player._id_632BAD3EDB4E449E) && player._id_632BAD3EDB4E449E == 1) {
        if(isDefined(player._id_02FF6825157B156E) && player._id_02FF6825157B156E == 1)
          _id_A1E7045E3E4CA353[_id_A1E7045E3E4CA353.size] = player;
      }
    }

    _id_F0FA8D0645074B69 = getdvarint("dvar_3C26C38AF324C343", 7446);
    _func_10A17A516D1E84ED(_id_A1E7045E3E4CA353, _id_F0FA8D0645074B69);
  }
}

_id_990E6E94FEF53E1A() {
  level endon("game_ended");

  for(;;) {
    _id_C248456FE9648490 = getdvarint("dvar_0E1B1C0BFB40859F", 1);
    wait(_id_C248456FE9648490);

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(player._id_97CA959A561F976E) && player._id_97CA959A561F976E == 1) {
        kick(player getentitynumber(), "EXE/PLAYERKICKED_REJOIN");
        continue;
      }

      if(isDefined(player._id_632BAD3EDB4E449E) && player._id_632BAD3EDB4E449E == 1) {
        if(isDefined(player._id_02FF6825157B156E) && player._id_02FF6825157B156E == 0) {
          logstring("rejoin_utility::kickDisconnectedPlayers: kicking disconnected player xuid: " + player getxuid() + "due to being marked not rejoinable.");
          kick(player getentitynumber(), "EXE/PLAYERKICKED_REJOIN");
        }
      }
    }
  }
}

_id_A1B2DC3090437789(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A) {
  _id_F0FA8D0645074B69 = getdvarint("dvar_3C26C38AF324C343", 7446);

  if(_id_4B86A4E17C656399 == _id_F0FA8D0645074B69) {
    if(_id_0ABC57BB73D4BF1A == 10) {
      logstring("rejoin_utility::onRejoinAchievementState: kicking player xuid: " + self getxuid() + "due to rejoin being rejected");
      self._id_97CA959A561F976E = 1;
    } else if(_id_0ABC57BB73D4BF1A == 11) {
      logstring("rejoin_utility::onRejoinAchievementState: kicking player xuid: " + self getxuid() + "due to playlist mismatch reject");
      self._id_97CA959A561F976E = 1;
      self._id_5BF9E082AD798489 = 1;
    }
  }
}

_id_C5728699E6B79552(_id_38968EF355B4D2EC) {
  _id_BA664F53DEA8A25C = getdvarint("dvar_925F7DCEB8E6205E", 0);

  foreach(player in level.players) {
    if(_id_BA664F53DEA8A25C && _id_38968EF355B4D2EC) {
      player _id_74B707898164ED78(0, []);
      continue;
    }

    player _id_E90D7800FB5EEC03(0, []);
  }
}

_id_FB67B62BBD718B34() {
  _id_64F88D0441939203 = getsystemtime() * 1000;
  _id_84C6DC2345234A61 = getdvarint("dvar_F4417CC21744FB67", 0) * 1000;
  _id_1517A9CFB1F4DE62 = scripts\engine\utility::ter_op(_id_84C6DC2345234A61 == 0, 0, _id_64F88D0441939203 + _id_84C6DC2345234A61);
  return _id_1517A9CFB1F4DE62;
}

_id_74B707898164ED78(_id_401C3A2E68AAB0FD, _id_400CD07EC60D425C) {
  if(!level.onlinegame) {
    return;
  }
  if(!getdvarint("dvar_925F7DCEB8E6205E", 0)) {
    return;
  }
  if(!isDefined(_id_401C3A2E68AAB0FD)) {
    return;
  }
  if(!isint(_id_401C3A2E68AAB0FD)) {
    return;
  }
  self._id_02FF6825157B156E = 1;
  _id_1517A9CFB1F4DE62 = _id_FB67B62BBD718B34();
  _id_BD15D7D46DE8F2DE = [0, 1, 13, _id_401C3A2E68AAB0FD, 9, level._id_73E946A3EADC84BE, 2, level._id_156E078B5445FFAA, 4, _id_1517A9CFB1F4DE62, 143, getplaylistversion()];

  if(isDefined(_id_400CD07EC60D425C) && _id_400CD07EC60D425C.size > 0)
    _id_BD15D7D46DE8F2DE = _id_2FCDC8C12F068ABB(_id_BD15D7D46DE8F2DE, _id_400CD07EC60D425C, 1);

  _id_13399AA20634EDCE(_id_BD15D7D46DE8F2DE);
  self _meth_10F8291E7FFED82C(1);
}

_id_E90D7800FB5EEC03(_id_401C3A2E68AAB0FD, _id_400CD07EC60D425C) {
  if(!level.onlinegame) {
    return;
  }
  if(!isDefined(_id_401C3A2E68AAB0FD)) {
    return;
  }
  if(!isint(_id_401C3A2E68AAB0FD)) {
    return;
  }
  self._id_02FF6825157B156E = 0;
  _id_BD15D7D46DE8F2DE = [0, 0, 13, _id_401C3A2E68AAB0FD, 9, level._id_73E946A3EADC84BE, 2, level._id_156E078B5445FFAA, 143, getplaylistversion()];

  if(isDefined(_id_400CD07EC60D425C) && _id_400CD07EC60D425C.size > 0)
    _id_BD15D7D46DE8F2DE = _id_2FCDC8C12F068ABB(_id_BD15D7D46DE8F2DE, _id_400CD07EC60D425C, 1);

  _id_13399AA20634EDCE(_id_BD15D7D46DE8F2DE);
  self _meth_10F8291E7FFED82C(0);
}

_id_13399AA20634EDCE(_id_1E904D14A41D4385) {
  if(!isDefined(_id_1E904D14A41D4385) || !isDefined(_id_1E904D14A41D4385.size) || _id_1E904D14A41D4385.size < 2) {
    return;
  }
  self _meth_DB073176839D77FB("50", _id_1E904D14A41D4385);
}

_id_4F6DF967144E2CB4(_id_934DC135AAF6F953) {
  if(_id_934DC135AAF6F953 == "enum_3926064B6DC60064")
    return 3;
  else if(_id_934DC135AAF6F953 == "enum_05A08CB6DBD090C0")
    return 14;
  else if(_id_934DC135AAF6F953 == "enum_7CA98F63B2722011")
    return 2;
  else if(_id_934DC135AAF6F953 == "enum_07194FFE36169CA7")
    return 2;
  else if(_id_934DC135AAF6F953 == "enum_5B309DC0BFF1F44D")
    return 2;
  else if(_id_934DC135AAF6F953 == "enum_539E18C78905606E")
    return 6;
  else if(_id_934DC135AAF6F953 == "enum_11F20E9E67C5528B")
    return 7;

  return 0;
}