/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_21c19cfc7139d773.gsc
***********************************************/

init() {
  if(getdvarint("dvar_AC8DFA3636C6E111", 1) == 0) {
    return;
  }
  level._id_B19067B41FD5CFE8 = 1;
  level._id_BF269015710DE2DD = getdvarint("dvar_A6B52F16F3853A9A", 0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "ftue_triggerTip", ::_id_1976438A8865AC27);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "ftue_trigger_landed_hint", ::_id_C97B14F407803E21);
  _id_C7C9735D7C22924D();
}

_id_C7C9735D7C22924D() {
  level._id_7A5545C9A0D5BD22 = [];
  _id_5A738B2F3B7D88D9("br_ftue_supply_box", ::_id_0598FB861F3171C2);
  _id_5A738B2F3B7D88D9("br_ftue_sliding", ::_id_46C63A68A41E27A1);
  level thread _id_1126427A8A7A78CD();
}

_id_0AE4B4DE059D48ED(ref) {
  if(!isDefined(self._id_BAB92B2713023287))
    self._id_BAB92B2713023287 = [];

  if(isDefined(self._id_BAB92B2713023287[ref]))
    self._id_BAB92B2713023287[ref]++;
  else
    self._id_BAB92B2713023287[ref] = 1;
}

_id_86471673929333B2() {
  if(!isDefined(self._id_BAB92B2713023287)) {
    return;
  }
  foreach(ref, _id_747268C0C64D85DC in self._id_BAB92B2713023287)
  self dlog_recordplayerevent("dlog_event_ftue_popup_aggregate", ["is_ftue_playlist", istrue(level._id_BF269015710DE2DD), "ftue_popup_ref", ref, "ftue_popup_aggregate", _id_747268C0C64D85DC]);
}

_id_1126427A8A7A78CD() {
  level endon("game_ended");
  level waittill("prematch_done");

  if(getdvarint("dvar_24C29DE93E1AD520", 0) == 1) {
    foreach(player in level.players) {
      if(isDefined(player) && !isbot(player))
        player _id_BFD3AE5074922CA4();
    }
  }

  _id_C502004B162C0807 = 0;
  _id_1B35D2D08CE39687 = getdvarint("dvar_2E1526107156458A", 5);

  if(_id_1B35D2D08CE39687 <= 0) {
    return;
  }
  wait 10;

  for(;;) {
    foreach(player in level.players) {
      if(isDefined(player) && isalive(player)) {
        foreach(ref, func in level._id_7A5545C9A0D5BD22) {
          if(isDefined(func) && isfunction(func))
            player[[func]]();
        }

        _id_C502004B162C0807++;
      }

      if(_id_C502004B162C0807 >= _id_1B35D2D08CE39687) {
        _id_C502004B162C0807 = 0;
        wait(getdvarint("dvar_CAE27C6584A113B1", 5000) / 1000);
      }
    }

    _id_C502004B162C0807 = 0;
    wait(getdvarint("dvar_CAE27C6584A113B1", 5000) / 1000);
  }
}

_id_5A738B2F3B7D88D9(ref, _id_22224B63F727B191) {
  level._id_7A5545C9A0D5BD22[ref] = _id_22224B63F727B191;
}

_id_DF45AD64B9DC074B(ref) {
  id = _id_3FA1BF21E3FC7B80::_id_BEC00F5EABDB65EA(ref);
  return tablelookupbyrow(_id_3FA1BF21E3FC7B80::_id_92B0A87F4E1A1D72(), id, 4);
}

_id_470BB108E6B631CF(ref) {
  id = _id_3FA1BF21E3FC7B80::_id_BEC00F5EABDB65EA(ref);
  index = tablelookupbyrow(_id_3FA1BF21E3FC7B80::_id_92B0A87F4E1A1D72(), id, 5);
  mask = 1 << index;
  return mask;
}

_id_2F0BA374D69E645C(ref) {
  _id_0AD3658A1088AF24 = _id_F7754D7AD59B2F8B();
  mask = _id_470BB108E6B631CF(ref);
  return istrue(_id_0AD3658A1088AF24 &mask);
}

_id_2DA74CF301F9FAA5(ref) {
  if(!isPlayer(self) || isbot(self))
    return 0;

  if(!scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  if(!isalive(self))
    return 0;

  if(!scripts\mp\flags::gameflag("br_ready_to_jump") && ref != "br_ftue_suggested_landing")
    return 0;

  if(scripts\mp\utility\player::isinlaststand(self))
    return 0;

  if(_id_2CEDCC356F1B9FC8::isplayeringulag())
    return 0;

  if(scripts\mp\outofbounds::isoob(self))
    return 0;

  if(isDefined(self.br_kiosk))
    return 0;

  if(_id_EFF88219461E17E6(ref))
    return 0;

  if(_id_2F0BA374D69E645C(ref)) {
    _id_0AE4B4DE059D48ED(ref);
    return 0;
  }

  _id_C03C24B6E883A1E1 = getdvarint("dvar_185628CD0876E868", 12000);
  _id_170B1EF196126EC4 = getdvarint("dvar_C2618EBB2CA593D3", 3000);

  if(isDefined(self._id_453B42F68499E7FC) && gettime() - self._id_453B42F68499E7FC <= _id_C03C24B6E883A1E1 + _id_170B1EF196126EC4)
    return 0;

  if(ref != "br_ftue_gas" && _id_2695A20D4011076D::_id_024C5A8D31AE262F(self.origin) && ref != "br_ftue_suggested_landing")
    return 0;

  if(!_id_8F15851557170215(ref)) {
    _id_874AC286D355A3B2 = getdvarint("dvar_1E4D5603F4B10D4D", 3000);
    _id_196D2B0AAA33DB5D = getdvarint("dvar_3EBB28CA5B9B3010", 500);
    _id_F2E473B17CA70265 = self getclosestenemy(_id_874AC286D355A3B2, _id_196D2B0AAA33DB5D, 1);

    if(isDefined(_id_F2E473B17CA70265) && !isagent(_id_F2E473B17CA70265))
      return 0;

    if(_id_88C626BAFD6057BF(self))
      return 0;
  }

  return 1;
}

_id_8FDD864A86AFE560(_id_82076CFFF3BD567A) {
  if(!isPlayer(self) || isbot(self)) {
    return;
  }
  if(getdvarint("dvar_7F7FF49D4459FEDD", 0) == 1) {
    return;
  }
  if(!isDefined(_id_82076CFFF3BD567A)) {
    return;
  }
  _id_394466C2DDB208CB = undefined;

  if(isvector(_id_82076CFFF3BD567A))
    _id_394466C2DDB208CB = self calloutmarkerping_create(16, _id_82076CFFF3BD567A + (0, 0, 82));
  else if(isent(_id_82076CFFF3BD567A) && isPlayer(_id_82076CFFF3BD567A) && isDefined(_id_82076CFFF3BD567A.team) && isalive(_id_82076CFFF3BD567A)) {
    if(self.team != _id_82076CFFF3BD567A.team)
      _id_394466C2DDB208CB = self calloutmarkerping_create(6, _id_82076CFFF3BD567A.origin + (0, 0, 82), 0);
    else
      _id_394466C2DDB208CB = self calloutmarkerping_create(16, _id_82076CFFF3BD567A.origin + (0, 0, 82), _id_82076CFFF3BD567A getentitynumber());
  } else if(_id_82076CFFF3BD567A getscriptableisloot())
    _id_394466C2DDB208CB = self calloutmarkerping_create(18, _id_82076CFFF3BD567A.origin, _id_82076CFFF3BD567A.index);
  else
    return;

  if(isDefined(_id_394466C2DDB208CB))
    thread scripts\cp_mp\calloutmarkerping::_calloutmarkerping_predicted_timeout(_id_394466C2DDB208CB);
}

_id_1976438A8865AC27(ref, _id_82076CFFF3BD567A) {
  if(!isPlayer(self) || isbot(self)) {
    return;
  }
  if(istrue(level._id_B19067B41FD5CFE8) && _id_2DA74CF301F9FAA5(ref)) {
    _id_3FA1BF21E3FC7B80::_id_65336CC44771776E(ref);
    thread _id_8FDD864A86AFE560(_id_82076CFFF3BD567A);
    thread _id_D42AFC6EF83AAFCA(ref);
    self playlocalsound("uin_iw9_ftue_tip_generic");
  }
}

_id_78172A2DF0F18BE4(ref) {
  if(!isalive(self))
    return 0;

  if(_id_2CEDCC356F1B9FC8::isplayeringulag())
    return 0;

  if(isDefined(self.br_kiosk))
    return 0;

  if(_id_88C626BAFD6057BF(self))
    return 0;

  return 1;
}

_id_D42AFC6EF83AAFCA(ref, mask, _id_428B69AA429BFF26) {
  self endon("remove_ftue_popup");

  if(!istrue(_id_428B69AA429BFF26)) {
    _id_193BA10DFA6671B4 = getdvarint("dvar_185628CD0876E868", 12000) / 1000;
    wait(_id_193BA10DFA6671B4);
  }

  if(!_id_78172A2DF0F18BE4(ref)) {
    _id_240D450C0EC5F614(ref);
    return;
  }

  if(ref == "br_ftue_suggested_landing") {
    return;
  }
  if(istrue(level._id_B19067B41FD5CFE8)) {
    _id_0AD3658A1088AF24 = _id_F7754D7AD59B2F8B();
    mask = _id_470BB108E6B631CF(ref);
    _id_0AD3658A1088AF24 = _id_0AD3658A1088AF24 | mask;
    _id_9406F25CA59385D7(_id_0AD3658A1088AF24);
    _id_C3CABD0FA5E17F4B = istrue(level._id_BF269015710DE2DD);
    self dlog_recordplayerevent("dlog_event_ftue_popup_initial", ["ftue_popup_ref", ref, "is_ftue_playlist", _id_C3CABD0FA5E17F4B]);
  }
}

_id_D0CCB374806FE494() {
  if(isDefined(self._id_942B501D544B0E0A) && !_id_2F0BA374D69E645C(self._id_942B501D544B0E0A)) {
    self notify("remove_ftue_popup");
    _id_240D450C0EC5F614(self._id_942B501D544B0E0A);
    _id_3FA1BF21E3FC7B80::_id_233461F36BB50EF9();
    return 0;
  }
}

_id_240D450C0EC5F614(ref) {
  if(isDefined(ref) && isDefined(self) && !_func_96D228FA8E72A818(self)) {
    if(!isDefined(self._id_AA60AAEC7E1F2460))
      self._id_AA60AAEC7E1F2460 = [];

    self._id_AA60AAEC7E1F2460[self._id_AA60AAEC7E1F2460.size] = ref;
  }
}

_id_EFF88219461E17E6(ref) {
  if(isDefined(self._id_AA60AAEC7E1F2460)) {
    foreach(_id_F107D5603DFE9551 in self._id_AA60AAEC7E1F2460) {
      if(ref == _id_F107D5603DFE9551)
        return 1;
    }
  }

  return 0;
}

_id_F7754D7AD59B2F8B() {
  _id_0AD3658A1088AF24 = self getplayerdata("mp", "ftueData", "popup_messages_01");
  return _id_0AD3658A1088AF24;
}

_id_9406F25CA59385D7(data) {
  self setplayerdata("mp", "ftueData", "popup_messages_01", data);
}

_id_BFD3AE5074922CA4(ref) {
  if(isDefined(ref)) {
    _id_0AD3658A1088AF24 = _id_F7754D7AD59B2F8B();
    mask = _id_470BB108E6B631CF(ref);
    _id_0AD3658A1088AF24 = _id_0AD3658A1088AF24 &!mask;
    _id_9406F25CA59385D7(_id_0AD3658A1088AF24);
  } else
    self setplayerdata("mp", "ftueData", "popup_messages_01", 0);
}

_id_DB5FF9A11953598A() {
  _id_2CEF9B44F8516A81 = self getplayerdata("mp", "ftueData", "ftue_match_count");
  return _id_2CEF9B44F8516A81;
}

_id_BA46B8BE5A676356(data) {
  self setplayerdata("mp", "ftueData", "ftue_match_count", data);
}

_id_5B732DD6AB2EE2D6() {
  if(isDefined(self) && isPlayer(self)) {
    _id_86471673929333B2();
    _id_2CEF9B44F8516A81 = self getplayerdata("mp", "ftueData", "ftue_match_count");

    if(_id_2CEF9B44F8516A81 < 10) {
      _id_2CEF9B44F8516A81 = _id_2CEF9B44F8516A81 + 1;
      self setplayerdata("mp", "ftueData", "ftue_match_count", _id_2CEF9B44F8516A81);
    }
  }
}

_id_E1EFE40B5C5AE801() {
  self setplayerdata("mp", "ftueData", "ftue_match_count", 0);
}

_id_DA05E0125FA8BBF4() {
  wait 1;
  startpt = level.infilstruct.c130pathstruct.startpt;
  endpt = level.infilstruct.c130pathstruct.endpt;
  maxdist = 2000;
  _id_7E8ACBB6E945F44A = maxdist * maxdist;
  _id_0BE9720EAAAA043E = 1;

  foreach(player in level.players) {
    if(player _id_2CEDCC356F1B9FC8::isplayerbrsquadleader()) {
      for(_id_AC0E594AC96AA3A8 = _id_0BE9720EAAAA043E; _id_AC0E594AC96AA3A8 <= tablelookupgetnumrows("mp/brLandingLocations.csv"); _id_AC0E594AC96AA3A8++) {
        _id_1A91606A95A6F428 = int(tablelookupbyrow("mp/brLandingLocations.csv", _id_AC0E594AC96AA3A8, 1));
        _id_0D82580E4EF677E9 = int(tablelookupbyrow("mp/brLandingLocations.csv", _id_AC0E594AC96AA3A8, 2));
        _id_2468F359E6DB6D5E = int(tablelookupbyrow("mp/brLandingLocations.csv", _id_AC0E594AC96AA3A8, 3));
        _id_6B2E847A999C810E = (_id_1A91606A95A6F428, _id_0D82580E4EF677E9, _id_2468F359E6DB6D5E);
        _id_0BB19C5D035C6218 = distance2dsquared(pointonsegmentnearesttopoint(startpt, endpt, _id_6B2E847A999C810E), _id_6B2E847A999C810E);

        if(_id_0BB19C5D035C6218 <= _id_7E8ACBB6E945F44A) {
          _id_0BE9720EAAAA043E = _id_AC0E594AC96AA3A8 + 1;
          player _id_1976438A8865AC27("br_ftue_suggested_landing", _id_6B2E847A999C810E);
        }
      }
    }
  }
}

_id_0598FB861F3171C2() {
  if(_id_2DA74CF301F9FAA5("br_ftue_supply_box")) {
    _id_AD5C6EA429F3DFA4 = getentitylessscriptablearray(undefined, undefined, self.origin, 800, "body");

    if(_id_AD5C6EA429F3DFA4.size > 0) {
      _id_066DF16D5EB83948 = undefined;
      _id_275345D8F36271A8 = 640000;
      _id_DEE6508B0BA437C5 = self getplayerangles();
      _id_70222FBC47330166 = anglesToForward(_id_DEE6508B0BA437C5);
      _id_2D9D490A0CC189E2 = 0.8;

      foreach(_id_36B81911E31BB387 in _id_AD5C6EA429F3DFA4) {
        _id_68D9E792FE9DEF4D = _id_36B81911E31BB387 getscriptablepartstate("body", 1);

        if(!isDefined(_id_68D9E792FE9DEF4D)) {
          continue;
        }
        if(isDefined(_id_68D9E792FE9DEF4D) && _id_68D9E792FE9DEF4D == "closed_usable" || _id_68D9E792FE9DEF4D == "closed_usable_no_collision") {
          distsq = distancesquared(self.origin, _id_36B81911E31BB387.origin);
          angles = vectortoangles(_id_36B81911E31BB387.origin - self.origin);
          forward = anglesToForward(angles);
          _id_E53980533AAA2FEE = vectordot(forward, _id_70222FBC47330166);

          if(_id_E53980533AAA2FEE > _id_2D9D490A0CC189E2) {
            if(distsq < _id_275345D8F36271A8 && abs(self.origin[2] - _id_36B81911E31BB387.origin[2]) < 80) {
              _id_066DF16D5EB83948 = _id_36B81911E31BB387;
              _id_275345D8F36271A8 = distsq;
            }
          }
        }
      }

      if(isDefined(_id_066DF16D5EB83948))
        _id_1976438A8865AC27("br_ftue_supply_box", _id_066DF16D5EB83948.origin);
    }
  }
}

_id_7287ACEC1D584B46() {
  level endon("game_ended");
  self endon("disconnect");

  if(self usinggamepad())
    _id_219C17C104495E0E = scripts\engine\utility::requestgamerprofile("slideDiveInvertHoldGamepad");
  else
    _id_219C17C104495E0E = scripts\engine\utility::requestgamerprofile("slideDiveInvertHoldKBM");

  if(_id_219C17C104495E0E)
    _id_1976438A8865AC27("br_ftue_sliding_invert");
  else
    _id_1976438A8865AC27("br_ftue_sliding");
}

_id_46C63A68A41E27A1() {
  if(_id_2DA74CF301F9FAA5("br_ftue_sliding") || _id_2DA74CF301F9FAA5("br_ftue_sliding_invert")) {
    if(self issprinting())
      thread _id_7287ACEC1D584B46();
  }
}

_id_5A4B82CE1C8D94D6(victim) {
  if(_id_2DA74CF301F9FAA5("br_ftue_enemy_down")) {
    wait 5;

    if(scripts\mp\utility\player::isinlaststand(victim))
      _id_1976438A8865AC27("br_ftue_enemy_down", victim);
  } else if(_id_2DA74CF301F9FAA5("br_ftue_interrogation") && _id_2F0BA374D69E645C("br_ftue_enemy_down")) {
    wait 3;

    if(scripts\mp\utility\player::isinlaststand(victim) && isalive(victim))
      _id_1976438A8865AC27("br_ftue_interrogation", victim);
  }
}

_id_4E19E6BF429DDA56(_id_F0EA4030349A33D5) {
  if(_id_2DA74CF301F9FAA5("br_ftue_revive")) {
    distsq = distancesquared(self.origin, _id_F0EA4030349A33D5.origin);

    if(distsq < 1000000)
      _id_1976438A8865AC27("br_ftue_revive", _id_F0EA4030349A33D5);
  }
}

_id_8F15851557170215(ref) {
  return ref == "br_ftue_interrogation" || ref == "br_ftue_enemy_down" || ref == "br_ftue_gas" || ref == "br_ftue_parachute" || ref == "br_ftue_suggested_landing";
}

_id_88C626BAFD6057BF(player) {
  currenttime = gettime();
  _id_527AAC742EF4EC8B = getdvarint("dvar_2D46F9A1548DFB28", 12000);

  if(isDefined(player) && (isDefined(player.pers["lastDamageTime"]) && player.pers["lastDamageTime"] + _id_527AAC742EF4EC8B > currenttime) || isDefined(player.lasttimedamaged) && player.lasttimedamaged + _id_527AAC742EF4EC8B > currenttime || isDefined(player.lastdamagedtime) && player.lastdamagedtime + _id_527AAC742EF4EC8B > currenttime)
    return 1;

  player scripts\mp\battlechatter_mp::validaterecentattackers();

  if(isDefined(player.recentattackers) && player.recentattackers.size > 0)
    return 1;

  if(isDefined(player.vehicle)) {
    if(istrue(player.vehicle.burningdown))
      return 1;

    if(istrue(scripts\cp_mp\utility\weapon_utility::islockedonto(player.vehicle)))
      return 1;
  }

  if(isDefined(player) && player scripts\mp\outofbounds::istouchingoobtrigger())
    return 1;

  return 0;
}

_id_C97B14F407803E21() {
  if(_id_2DA74CF301F9FAA5("br_ftue_controls")) {
    _id_1976438A8865AC27("br_ftue_controls");
    return;
  }

  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

  if(_id_A6AB8D0FDA441DC2.size > 0 && _id_2F0BA374D69E645C("br_ftue_controls") && _id_2DA74CF301F9FAA5("br_ftue_ping"))
    _id_1976438A8865AC27("br_ftue_ping");
}

_id_A381589F3FB2B34F(scriptablename, pickup) {
  if(_id_2DA74CF301F9FAA5("br_ftue_stronghold")) {
    if(!istrue(_id_7E52B56769FA7774::_id_CBBF9BF3544DC456(pickup))) {
      return;
    }
    _id_9220EE8D6BF347EE = isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "key" && issubstr(scriptablename, "loot_key_fortress");

    if(_id_9220EE8D6BF347EE)
      _id_1976438A8865AC27("br_ftue_stronghold");
  }
}