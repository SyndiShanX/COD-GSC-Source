/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\super_emp_pulse.gsc
*************************************************/

_id_DCA5550C46B2A111() {
  level.superglobals.staticsuperdata["super_emp_pulse"]._id_F6604EEBABCAC6C2 = ::_id_F41BAE22BCC2BDE7;
}

_id_F41BAE22BCC2BDE7() {
  return 1;
}

_id_F62E25CB503D7BAB() {
  result = _id_E192D40D87BD55A9();
  return result;
}

_id_D2A07D3ACDD4B448() {
  _id_75BAA17A54260F6F(0);
  scripts\mp\supers::_id_7203E7AA96FF0BA9(0);
  self notify("empPulse_unset");
}

_id_E83E2D8DC74FFDBB() {
  scripts\mp\supers::_id_7203E7AA96FF0BA9(30);
  _id_75BAA17A54260F6F(1);
  thread _id_3F97C8A2961E9D18();
}

_id_3F97C8A2961E9D18() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("super_use_finished");
  self endon("empPulse_unset");

  for(;;) {
    self waittill("super_use_charging");

    if(scripts\mp\supers::issuperready()) {
      continue;
    }
    if(scripts\mp\supers::issuperinuse()) {
      continue;
    }
    _id_D2A07D3ACDD4B448();
    break;
  }
}

_id_C2CA731BDB780549() {
  _id_75BAA17A54260F6F(0);
  scripts\mp\supers::_id_DDEB08081F6FABEA();
}

_id_E192D40D87BD55A9() {
  objweapon = makeweapon("emp_pulse_device_mp");
  _id_D54D53EAF955518D = scripts\cp_mp\utility\weapon_utility::_id_F19F8B4CF085ECBD(objweapon);

  if(istrue(_id_D54D53EAF955518D))
    return _id_4941256EE86725F8();
  else
    return scripts\mp\supers::refundsuper();
}

_id_4941256EE86725F8() {
  time = getdvarfloat("dvar_0E347DAEC58694E5", 0.65);
  self setclientomnvar("ui_super_ddos_screen_on", 1);
  wait(time);
  _id_C2CA731BDB780549();
  thread _id_058634008FF0B995();
  thread _id_A2B3DA8C5C455AA9();
  thread _id_68474541E3F6E6C3();
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_emp_pulse", 0);
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "equipment_deployed");
  return 1;
}

_id_75BAA17A54260F6F(_id_E60552DD6ABCC4AA) {
  if(_id_E60552DD6ABCC4AA) {
    self setclientomnvar("ui_emp_target_detector_on_give_widget", 1);
    thread _id_0A985F47623D10AC();
  } else {
    self notify("empPulse_disableOnGiveWidget");
    self setclientomnvar("ui_emp_target_detector_on_give_widget", 0);
  }
}

_id_0A985F47623D10AC() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("empPulse_disableOnGiveWidget");

  for(;;) {
    _id_397FDD12E82BA4DD = _id_63973975CEEE9DDA(scripts\cp_mp\emp_debuff::get_emp_ents(), self.origin, self.angles).size;
    _id_397FDD12E82BA4DD = int(clamp(_id_397FDD12E82BA4DD, 0, 5));
    _id_00E160DD6D9F67A8 = _id_397FDD12E82BA4DD + 1;
    self setclientomnvar("ui_emp_target_detector_on_give_widget", _id_00E160DD6D9F67A8);
    wait 0.05;
  }
}

_id_68474541E3F6E6C3() {
  level endon("game_ended");
  self endon("disconnect");
  wait 0.88;
  self setclientomnvar("ui_super_ddos_screen_on", 0);
}

_id_058634008FF0B995() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("DDoSPulse", "pulse", 0);
  scripts\engine\utility::waittill_any_2("death", "scramble_clear");
  self setscriptablepartstate("DDoSPulse", "off", 0);
}

_id_F83892872EAF9D79(objweapon) {
  self endon("disconnect");
  level endon("game_ended");
  level endon("round_end");
  _id_170B85C668CF4B59 = self.angles;
  _id_5DA234812450B0D7 = self.origin;
  _id_D0DE0DB1760B9C5B = 100;
  maxdist = 1000;
  waittime = 0.1;
  _id_556B31282ABCB132 = _id_D0DE0DB1760B9C5B;
  _id_AFC2F18CDAA6C9CC = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);
  _id_6F0350C82FC94C38 = scripts\cp_mp\emp_debuff::get_emp_ents();
  _id_DBEE2266E7253DCD = _id_65EB2204DB38221A(_id_AFC2F18CDAA6C9CC, _id_5DA234812450B0D7, _id_170B85C668CF4B59);
  _id_9B64BCBED677462B = _id_63973975CEEE9DDA(_id_6F0350C82FC94C38, _id_5DA234812450B0D7, _id_170B85C668CF4B59, 1);

  while(_id_556B31282ABCB132 <= maxdist) {
    _id_0186931B5967C0E6 = _id_556B31282ABCB132 * _id_556B31282ABCB132;
    _id_BEDB769CC0E5E018 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DBEE2266E7253DCD.size; _id_AC0E594AC96AA3A8++) {
      victim = _id_DBEE2266E7253DCD[_id_AC0E594AC96AA3A8]["player"];

      if(!_id_641436D9BD65F63C(self, victim)) {
        continue;
      }
      if(istrue(_id_DBEE2266E7253DCD[_id_AC0E594AC96AA3A8]["isPulsed"])) {
        continue;
      }
      _id_C2494A3C15915281 = _id_DBEE2266E7253DCD[_id_AC0E594AC96AA3A8]["horizDistSq"];
      _id_58D33C1362D1A08E = _id_DBEE2266E7253DCD[_id_AC0E594AC96AA3A8]["vertDistSq"];

      if(_id_C2494A3C15915281 * _id_58D33C1362D1A08E <= _id_556B31282ABCB132) {
        data = scripts\cp_mp\utility\damage_utility::packdamagedata(self, victim, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);
        thread _id_042A2E5C40023CDB(data, _id_8ABF731D992D2081(victim));
        _id_DBEE2266E7253DCD[_id_AC0E594AC96AA3A8]["isPulsed"] = 1;
        continue;
      }

      _id_BEDB769CC0E5E018[_id_BEDB769CC0E5E018.size] = _id_DBEE2266E7253DCD[_id_AC0E594AC96AA3A8];
    }

    _id_DBEE2266E7253DCD = _id_BEDB769CC0E5E018;
    _id_2980A67D5F78DD86 = [];

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_9B64BCBED677462B.size; _id_AC0E5C4AC96AAA41++) {
      ent = _id_9B64BCBED677462B[_id_AC0E5C4AC96AAA41]["entity"];

      if(!_id_641436D9BD65F63C(self, ent)) {
        continue;
      }
      if(istrue(_id_9B64BCBED677462B[_id_AC0E5C4AC96AAA41]["isPulsed"])) {
        continue;
      }
      if(_id_9B64BCBED677462B[_id_AC0E5C4AC96AAA41]["horizDistSq"] <= _id_0186931B5967C0E6) {
        if(_id_9B64BCBED677462B[_id_AC0E5C4AC96AAA41]["vertDistSq"] <= 4000000) {
          data = scripts\cp_mp\utility\damage_utility::packdamagedata(self, ent, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);
          thread _id_25310643899068A8(data, _id_8ABF731D992D2081(ent));
          _id_9B64BCBED677462B[_id_AC0E5C4AC96AAA41]["isPulsed"] = 1;
        }

        continue;
      }

      _id_2980A67D5F78DD86[_id_2980A67D5F78DD86.size] = _id_9B64BCBED677462B[_id_AC0E5C4AC96AAA41];
    }

    _id_9B64BCBED677462B = _id_2980A67D5F78DD86;
    _id_556B31282ABCB132 = _id_556B31282ABCB132 + _id_D0DE0DB1760B9C5B;
    wait(waittime);
  }
}

_id_641436D9BD65F63C(attacker, victim) {
  if(!isDefined(victim))
    return 0;

  if(isagent(victim))
    return 0;

  if(isPlayer(victim)) {
    if(victim isplayerheadless())
      return 0;

    if(victim == attacker)
      return 0;

    if(!scripts\mp\utility\player::isreallyalive(victim))
      return 0;

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(attacker, victim)) && !istrue(getdvarint("dvar_58254C61DE76BFFE", 0)))
      return 0;

    if(victim scripts\mp\utility\player::isusingremote())
      return 0;

    if(isDefined(victim._id_9D3E90085B3F0DA3))
      return 0;
    else
      return 1;
  } else {
    if(istrue(victim.isdestroyed))
      return 0;

    entowner = victim.owner;

    if(isDefined(entowner)) {
      if(entowner == attacker && !istrue(getdvarint("dvar_58254C61DE76BFFE", 0)))
        return 0;

      if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(attacker, entowner)) && !istrue(getdvarint("dvar_58254C61DE76BFFE", 0)))
        return 0;
    }

    team = victim.team;

    if(isDefined(team)) {
      if(team == attacker.team && !istrue(getdvarint("dvar_58254C61DE76BFFE", 0)))
        return 0;
    }

    if(victim scripts\cp_mp\vehicles\vehicle::isvehicle() && !scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(victim, attacker))
      return 0;

    if(isDefined(victim.vehicle) && victim.vehicle scripts\cp_mp\vehicles\vehicle::isvehicle() && !scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(victim.vehicle, attacker))
      return 0;

    return 1;
  }

  return 0;
}

_id_150EF769C933224A(a, b) {
  if(a["horizDistSq"] < b["horizDistSq"])
    return 1;
  else
    return 0;
}

_id_65EB2204DB38221A(_id_55C733BB252489E1, _id_2C3A1BF3BFD80420, _id_047B3ACF386B6F5A) {
  _id_67E54DC8917A5918 = [];

  foreach(player in _id_55C733BB252489E1) {
    if(!_id_641436D9BD65F63C(self, player)) {
      continue;
    }
    _id_4B83E9936868EA11 = anglesToForward(_id_047B3ACF386B6F5A);
    _id_B99FB2029C228371 = anglestoup(_id_047B3ACF386B6F5A);
    _id_426ACA92D85B305C = scripts\engine\utility::flatten_vector(player.origin - _id_2C3A1BF3BFD80420);
    _id_6E9865AD60031AFA = vectordot(_id_426ACA92D85B305C, _id_B99FB2029C228371);
    _id_67A81E668B8A7DBD = vectordot(_id_426ACA92D85B305C, _id_4B83E9936868EA11);

    if(abs(_id_6E9865AD60031AFA) > 2000) {
      continue;
    }
    if(abs(_id_67A81E668B8A7DBD) > 1000) {
      continue;
    }
    _id_DF44DA7768CC370F = anglesToForward(_id_047B3ACF386B6F5A);
    _id_077B9E4B599269EB = scripts\engine\math::anglebetweenvectorssigned(_id_DF44DA7768CC370F, _id_426ACA92D85B305C, (0, 0, 1));

    if(abs(_id_077B9E4B599269EB) > 110.0) {
      continue;
    }
    index = _id_67E54DC8917A5918.size;
    _id_67E54DC8917A5918[index]["player"] = player;
    _id_67E54DC8917A5918[index]["vertDistSq"] = _id_6E9865AD60031AFA * _id_6E9865AD60031AFA;
    _id_67E54DC8917A5918[index]["horizDistSq"] = _id_67A81E668B8A7DBD * _id_67A81E668B8A7DBD;
    _id_67E54DC8917A5918[index]["isPulsed"] = 0;
  }

  _id_67E54DC8917A5918 = scripts\engine\utility::array_sort_with_func(_id_67E54DC8917A5918, ::_id_150EF769C933224A);
  return _id_67E54DC8917A5918;
}

_id_63973975CEEE9DDA(_id_55C733BB252489E1, _id_2C3A1BF3BFD80420, _id_047B3ACF386B6F5A, sort) {
  _id_B5C65D27DFC53F84 = [];

  foreach(ent in _id_55C733BB252489E1) {
    if(!istrue(_id_641436D9BD65F63C(self, ent))) {
      continue;
    }
    _id_4B83E9936868EA11 = anglesToForward(_id_047B3ACF386B6F5A);
    _id_B99FB2029C228371 = anglestoup(_id_047B3ACF386B6F5A);
    _id_3AE85A013C16DC47 = anglestoright(_id_047B3ACF386B6F5A);
    _id_426ACA92D85B305C = ent.origin - _id_2C3A1BF3BFD80420;
    _id_6E9865AD60031AFA = vectordot(_id_426ACA92D85B305C, _id_B99FB2029C228371);
    _id_C2494A3C15915281 = pow(vectordot(_id_426ACA92D85B305C, _id_4B83E9936868EA11), 2) + pow(abs(vectordot(_id_426ACA92D85B305C, _id_3AE85A013C16DC47)), 2);

    if(abs(_id_6E9865AD60031AFA) > 2000) {
      continue;
    }
    if(abs(_id_C2494A3C15915281) > 1000000) {
      continue;
    }
    _id_DF44DA7768CC370F = anglesToForward(_id_047B3ACF386B6F5A);
    _id_077B9E4B599269EB = scripts\engine\math::anglebetweenvectorssigned(_id_DF44DA7768CC370F, _id_426ACA92D85B305C, (0, 0, 1));

    if(abs(_id_077B9E4B599269EB) > 110.0) {
      continue;
    }
    index = _id_B5C65D27DFC53F84.size;
    _id_B5C65D27DFC53F84[index]["entity"] = ent;
    _id_B5C65D27DFC53F84[index]["horizDistSq"] = _id_C2494A3C15915281;
    _id_B5C65D27DFC53F84[index]["vertDistSq"] = _id_6E9865AD60031AFA * _id_6E9865AD60031AFA;
    _id_B5C65D27DFC53F84[index]["isPulsed"] = 0;
  }

  if(istrue(sort))
    _id_B5C65D27DFC53F84 = scripts\engine\utility::array_sort_with_func(_id_B5C65D27DFC53F84, ::_id_150EF769C933224A);

  return _id_B5C65D27DFC53F84;
}

_id_A2B3DA8C5C455AA9() {
  self endon("disconnect");
  objweapon = makeweapon("emp_pulse_mp");
  thread _id_757161ADB13D0E4C();
  self earthquakeforplayer(0.2, 1, self.origin, 2000);
  thread _id_CF17A9452E2260DF(objweapon);
  _id_F83892872EAF9D79(objweapon);
}

_id_757161ADB13D0E4C() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("DDoSBlast", "initial_blast", 0);
  scripts\engine\utility::waittill_any_timeout_2(1.0, "death", "scramble_clear");
  self setscriptablepartstate("DDoSBlast", "off", 0);
}

_id_CF17A9452E2260DF(objweapon) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("empPulse_scrambling");
  self endon("empPulse_scrambling");
  _id_8EE201A397CD1843 = gettime() + 6000.0;
  waittime = 0.1;

  while(gettime() < _id_8EE201A397CD1843) {
    players = scripts\mp\utility\player::getplayersinradius(self.origin, 500);

    foreach(player in players) {
      if(!_id_641436D9BD65F63C(self, player)) {
        continue;
      }
      if(!isDefined(player._id_9D3E90085B3F0DA3)) {
        data = scripts\cp_mp\utility\damage_utility::packdamagedata(self, player, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);
        player thread _id_042A2E5C40023CDB(data, _id_8ABF731D992D2081(player));
      }
    }

    wait(waittime);
  }

  self notify("scramble_clear");
}

_id_194F1400B244A82B(target) {
  if(!isDefined(self._id_3FF0B2483EA046E3))
    self._id_3FF0B2483EA046E3 = [];

  _id_8B1683C8EAD7B9BE = target getentitynumber();
  _id_59A52BFE186A64C9 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self._id_3FF0B2483EA046E3[_id_8B1683C8EAD7B9BE]) || self._id_3FF0B2483EA046E3[_id_8B1683C8EAD7B9BE] > _id_59A52BFE186A64C9) {
    self._id_3FF0B2483EA046E3[_id_8B1683C8EAD7B9BE] = _id_59A52BFE186A64C9;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("emped_player");

    if(isDefined(self.super)) {
      if(!isDefined(self.super.hitcount))
        self.super.hitcount = 1;

      self.super.hitcount++;
    }
  }
}

_id_25310643899068A8(data, time) {
  _id_D5C235D554645BBC = 0;

  if(getdvarint("dvar_10320E52E3E9AB5C", 0))
    _id_D5C235D554645BBC = 1;

  attacker = self;
  _id_9CC7D33E2E2EBFEF = _id_59DD501E1D9EB7BF(self);
  victim = data.victim;

  if(!isDefined(attacker) || !isDefined(victim)) {
    return;
  }
  if(isDefined(victim._id_0AF81370570C04CA) && victim._id_0AF81370570C04CA > 0)
    _id_FF6C729A35B7AD00 = victim._id_0AF81370570C04CA;

  if(isDefined(_id_9CC7D33E2E2EBFEF))
    thread scripts\mp\utility\outline::_id_6B8603FF55F4ED2C([victim], self, _id_9CC7D33E2E2EBFEF, time, "ddos_target_non_player", "perk_superior");

  thread scripts\cp_mp\emp_debuff::_id_662905D3B9455612(data, time, _id_D5C235D554645BBC);
}

_id_59DD501E1D9EB7BF(attacker) {
  _id_91954EF8D7823CA4 = getdvarint("dvar_8863A21E430252D5", 0) == 1;

  if(!isagent(attacker)) {
    if(!level.teambased || _id_91954EF8D7823CA4)
      return [attacker];
    else if(_id_58BE75C518BF0D40::shouldmodesetsquads())
      return level.squaddata[attacker.team][attacker._id_0FF97225579DE16A].players;
    else
      return scripts\mp\utility\teams::getteamdata(attacker.team, "players");
  }
}

_id_042A2E5C40023CDB(data, _id_97072EEAE32EBD38) {
  data.victim notify("empPulse_apply_player");
  data.victim endon("empPulse_apply_player");
  scripts\cp_mp\emp_debuff::apply_emp_struct(data, 0);
  self _meth_9B28BD480AAAD85F(1);
  data.victim thread _id_64D9A2632F1A99C7(data.attacker);
  data.attacker thread _id_194F1400B244A82B(data.victim);
  scripts\mp\gamescore::trackdebuffassist(data.attacker, data.victim, data.objweapon.basename);
  data.victim _id_954BD233E4E1A4AB(1);
  msg = _id_1A710E4B1D09123B(data, _id_97072EEAE32EBD38);
  data.victim _id_954BD233E4E1A4AB(0);

  if(isDefined(data.victim)) {
    data.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isDefined(data.attacker) && scripts\mp\utility\player::isreallyalive(data.attacker))
      scripts\mp\gamescore::untrackdebuffassist(data.attacker, data.victim, data.objweapon.basename);

    self _meth_9B28BD480AAAD85F(0);
  }
}

_id_954BD233E4E1A4AB(_id_BEFBE3BC1857DA1B) {
  if(!scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4()) {
    return;
  }
  if(_id_BEFBE3BC1857DA1B)
    self _meth_F1CCBDAE77A4DB7F("iw9_mp_nvg_base_color_ddos");
  else
    self _meth_F1CCBDAE77A4DB7F("iw9_mp_nvg_base_color");
}

_id_1A710E4B1D09123B(data, _id_97072EEAE32EBD38) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  time = 6.0;

  if(isDefined(_id_97072EEAE32EBD38))
    time = _id_97072EEAE32EBD38;

  msg = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", time);
  return msg;
}

_id_8ABF731D992D2081(victim) {
  _id_F273AC584195F5A3 = getdvarfloat("dvar_44C4511516EAFBBE", 6.0);

  if(victim scripts\cp_mp\vehicles\vehicle::isvehicle())
    _id_F273AC584195F5A3 = scripts\engine\utility::ter_op(getdvarint("dvar_10320E52E3E9AB5C", 0), _id_F273AC584195F5A3, getdvarfloat("dvar_820929AEC8056E07", 3.5));

  if(!scripts\mp\supers::getcurrentsuper().isinuse)
    return _id_F273AC584195F5A3;
  else
    return clamp(scripts\mp\supers::getcurrentsuper().usepercent * _id_F273AC584195F5A3, 0, _id_F273AC584195F5A3);
}

_id_64D9A2632F1A99C7(_id_479E3F358A1F244E) {
  self endon("disconnect");
  self endon("emp_scramble_off");

  if(isDefined(self._id_9D3E90085B3F0DA3))
    _id_FFA0F84DFA2FAF4D();

  self._id_9D3E90085B3F0DA3 = _id_479E3F358A1F244E;
  thread _id_36BFCA5111B03188(_id_479E3F358A1F244E);
  _id_7BDAE2425BB328D2(_id_479E3F358A1F244E);

  if(isDefined(self._id_9D3E90085B3F0DA3))
    _id_FFA0F84DFA2FAF4D(_id_479E3F358A1F244E);
}

_id_7BDAE2425BB328D2(_id_479E3F358A1F244E) {
  level endon("game_ended");
  _id_479E3F358A1F244E endon("disconnect");
  self endon("disconnect");
  _id_479E3F358A1F244E childthread _id_46E4DB17237E26B9(self);
  childthread _id_243384FBCFC9CC34();
  scripts\engine\utility::waittill_any_timeout_3(6.0, "empPulse_ownerDeath", "empPulse_victimDeath", "ddos_ended_early");
}

_id_FFA0F84DFA2FAF4D(_id_479E3F358A1F244E) {
  self._id_9D3E90085B3F0DA3 = undefined;
  scripts\cp_mp\emp_debuff::_id_F7C6D776D032122F();
}

_id_46E4DB17237E26B9(victim) {
  self waittill("death");
  victim notify("empPulse_ownerDeath");
}

_id_243384FBCFC9CC34() {
  self waittill("death");
  self notify("empPulse_victimDeath");
}

_id_36BFCA5111B03188(_id_479E3F358A1F244E) {
  self endon("death_or_disconnect");
  self endon("emp_scramble_off");
  _id_479E3F358A1F244E endon("death_or_disconnect");
  _id_D0F37CCCE4E88C3D = 0;
  _id_8CE1ABD1A0602291 = 0;

  for(;;) {
    _id_8CE1ABD1A0602291 = _id_74B2449AF1D5F763(_id_479E3F358A1F244E);
    _id_4893B9A18CF47D6C = _id_8CE1ABD1A0602291 != _id_D0F37CCCE4E88C3D;

    if(_id_D0F37CCCE4E88C3D == 0 || _id_4893B9A18CF47D6C) {
      scripts\cp_mp\emp_debuff::stop_emp_scramble(_id_D0F37CCCE4E88C3D);
      scripts\cp_mp\emp_debuff::play_emp_scramble(_id_8CE1ABD1A0602291);
      _id_D0F37CCCE4E88C3D = _id_8CE1ABD1A0602291;
    }

    waitframe();
  }
}

_id_74B2449AF1D5F763(_id_479E3F358A1F244E) {
  _id_105FCA5E47D7EE56 = 500;
  _id_F3B7CC3138382DFB = _id_105FCA5E47D7EE56 * _id_105FCA5E47D7EE56;
  _id_3BF809E113AE4C12 = distance2dsquared(_id_479E3F358A1F244E.origin, self.origin);
  _id_8CE1ABD1A0602291 = 0;

  if(_id_3BF809E113AE4C12 > _id_F3B7CC3138382DFB)
    _id_8CE1ABD1A0602291 = 0;
  else if(_id_3BF809E113AE4C12 >= _id_F3B7CC3138382DFB * 0.8)
    _id_8CE1ABD1A0602291 = 1;
  else if(_id_3BF809E113AE4C12 >= _id_F3B7CC3138382DFB * 0.6)
    _id_8CE1ABD1A0602291 = 2;
  else if(_id_3BF809E113AE4C12 >= _id_F3B7CC3138382DFB * 0.4)
    _id_8CE1ABD1A0602291 = 3;
  else if(_id_3BF809E113AE4C12 >= _id_F3B7CC3138382DFB * 0.2)
    _id_8CE1ABD1A0602291 = 4;
  else
    _id_8CE1ABD1A0602291 = 5;

  return _id_8CE1ABD1A0602291;
}

_id_2F0D9315AB20C4BF() {
  if(isDefined(self.super) && isDefined(self.super.hitcount)) {
    scripts\cp_mp\challenges::_id_D997435895422ECC("super_emp_pulse", 3, self.super.hitcount);
    self.super.hitcount = undefined;
  }

  self._id_3FF0B2483EA046E3 = undefined;
}