/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_52eed65f3af6af91.gsc
***********************************************/

_id_A6CA80CF4F22E262() {
  if(getdvarint("mgl", 0)) {
    setDvar("dvar_05AD0894B28995C4", 1);
    _id_1C32A202E5E6E499 = getscriptbundle("ftuetiplist:ftuetips_list_mgl");
    _id_495A84D8124FF118(_id_1C32A202E5E6E499);
  }
}

_id_5135B05917B91C1B() {
  self._id_45E9D104C0A834C7 = spawnStruct();
  _id_60994558E6D2F494(0);
}

_id_495A84D8124FF118(_id_3C9993AED2DA47E6) {
  level._id_CF6B53E10210D950 = [];
  index = 1;

  foreach(_id_D442547D75DFFD09 in _id_3C9993AED2DA47E6._id_0A43C3448B149524) {
    _id_2FB2AED4C21BA3B0 = _id_D442547D75DFFD09.ref;

    if(isDefined(_id_2FB2AED4C21BA3B0)) {
      _id_E98D60032AA37EF6 = spawnStruct();
      _id_E98D60032AA37EF6.id = index;
      _id_E98D60032AA37EF6._id_D442547D75DFFD09 = _id_D442547D75DFFD09._id_D442547D75DFFD09;
      level._id_CF6B53E10210D950[_id_2FB2AED4C21BA3B0] = _id_E98D60032AA37EF6;
    }

    index++;
  }
}

_id_E4D0F9EFE9C2BCA1() {
  return self._id_FA35B4A136B27ACD;
}

_id_1339FDDEE137DCAE() {
  level endon("game_ended");

  if(!isDefined(level.onluieventcallbacks))
    level waittill("lui_game_event_aggregator_initialized");

  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_7C2033D8C280D0E6);
}

_id_7C2033D8C280D0E6(event, value) {
  if(isDefined(event) && event == "ftue_tips_disabled" && isDefined(value))
    self._id_FA35B4A136B27ACD = !value;
}

_id_9E0151BAA208FE9E(ref, params) {
  _id_143BBA0D625B5C0C("CONTEXTUAL TIP Show text: " + ref, 0);

  if(!isDefined(params))
    params = spawnStruct();

  if(getdvarint("dvar_05AD0894B28995C4", 0) == 0 || !isDefined(level._id_CF6B53E10210D950)) {
    return;
  }
  if(isDefined(params.sound) && params.sound)
    self playlocalsound("uin_tip_appearance");

  if(isDefined(params._id_C0C66E575A4E28D5))
    self._id_C0C66E575A4E28D5 = params._id_C0C66E575A4E28D5;

  _id_34D38A99558EB2A2(ref, params.callback, params.duration);
}

_id_34D38A99558EB2A2(ref, callback, duration) {
  if(!isPlayer(self)) {
    return;
  }
  _id_4202E8261E8725F2 = _id_AB89B3DEB8815D2C(ref);

  if(!isDefined(_id_4202E8261E8725F2)) {
    return;
  }
  _id_60994558E6D2F494(_id_4202E8261E8725F2);
  self _meth_45AF0F78C1D76035(_id_4202E8261E8725F2);
  thread _id_3A1F121991C200E3(ref, 0);
  self notify("newtip");
  self._id_45E9D104C0A834C7._id_C90213A6575F2880 = ref;
  _id_3FE75272B89FEF65(duration);
}

_id_F339C5C73D11EA20(ref, _id_C1B8AE0865B5F1F7, params) {
  text = "CONTEXTUAL TIP complete text: " + ref + " succeed: " + _id_C1B8AE0865B5F1F7;
  _id_143BBA0D625B5C0C(text, 0);

  if(!isDefined(ref)) {
    return;
  }
  if(!_id_4352A63D3925798B()) {
    _id_9E0151BAA208FE9E(ref);
    _id_D9F9951C566C97E1(1, params.duration);
  }

  if(!isDefined(params))
    params = spawnStruct();

  if(isDefined(params.sound) && params.sound) {
    sound = "uin_tip_complete";

    if(!_id_C1B8AE0865B5F1F7)
      sound = "uin_tip_failed";

    self playlocalsound(sound);
  }

  _id_508D3DE0EE3046DD(ref, _id_C1B8AE0865B5F1F7);
  result = "SUCCESS";

  if(!_id_C1B8AE0865B5F1F7)
    result = "FAILED";

  thread _id_3A1F121991C200E3(ref, 1, result);
  self._id_45E9D104C0A834C7._id_C90213A6575F2880 = "";
  _id_D9F9951C566C97E1(0.7, params.duration);

  if(!isDefined(params._id_EE011D69B16FF21D))
    _id_7FD621B8BA80E652();
  else
    _id_7FD621B8BA80E652(params._id_EE011D69B16FF21D);
}

_id_508D3DE0EE3046DD(ref, _id_C1B8AE0865B5F1F7) {
  if(getdvarint("dvar_05AD0894B28995C4", 0) == 0 || !isDefined(level._id_CF6B53E10210D950)) {
    return;
  }
  _id_FF85BC42D440477B(ref, _id_063E0C93EB50543F(_id_C1B8AE0865B5F1F7));
}

_id_FF85BC42D440477B(ref, _id_9B1941CB7354665E) {
  if(!isPlayer(self)) {
    return;
  }
  self _meth_1807967EA2130C2D(_id_9B1941CB7354665E);
}

_id_063E0C93EB50543F(_id_C1B8AE0865B5F1F7) {
  _id_9B1941CB7354665E = 0;

  if(isDefined(_id_C1B8AE0865B5F1F7)) {
    if(_id_C1B8AE0865B5F1F7)
      _id_9B1941CB7354665E = 1;
    else
      _id_9B1941CB7354665E = 2;
  }

  return _id_9B1941CB7354665E;
}

_id_7FD621B8BA80E652(_id_97072EEAE32EBD38) {
  _id_60994558E6D2F494(0);
  self _meth_4EB77980AFFDBEFB();
  _id_EE011D69B16FF21D = 0.5;

  if(isDefined(_id_97072EEAE32EBD38))
    _id_EE011D69B16FF21D = _id_97072EEAE32EBD38;

  _id_D9F9951C566C97E1(_id_EE011D69B16FF21D);
}

_id_D9F9951C566C97E1(_id_77BD26029C485466, _id_4048E94312776EED) {
  waittime = _id_77BD26029C485466;

  if(isDefined(_id_4048E94312776EED))
    waittime = _id_4048E94312776EED;

  wait(waittime);
}

_id_3FE75272B89FEF65(duration) {
  if(isDefined(duration)) {
    wait(duration);
    _id_7FD621B8BA80E652();
  }
}

_id_36939D27AE6DF257(callback) {
  if(isDefined(callback))
    thread _id_FF3F2188762B9896(callback);
}

_id_FF3F2188762B9896(callback) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self._id_45E9D104C0A834C7)) {
    return;
  }
  if(!isDefined(callback)) {
    return;
  }
  for(;;) {
    self waittill("luinotifyserver", event, value);

    if(isDefined(event) && event == "ftuetip_completed") {
      if(isDefined(value) && value == _id_91E510BCC622BFD0()) {
        _id_4B2538E850DF3357 = _id_BF44B38DB65D0BF9(value);

        if(isDefined(_id_4B2538E850DF3357)) {
          self[[callback]](_id_4B2538E850DF3357);
          return;
        }
      }
    }
  }
}

_id_BF44B38DB65D0BF9(index) {
  foreach(ref, _id_E98D60032AA37EF6 in level._id_CF6B53E10210D950) {
    if(_id_E98D60032AA37EF6.id == index)
      return ref;
  }

  return undefined;
}

_id_AB89B3DEB8815D2C(_id_F325D04EBCBA01D4) {
  id = level._id_CF6B53E10210D950[_id_F325D04EBCBA01D4].id;
  return id;
}

_id_C50EA39387684E41(_id_F325D04EBCBA01D4) {
  id = level._id_CF6B53E10210D950[_id_F325D04EBCBA01D4]._id_D442547D75DFFD09;
  return id;
}

_id_DD89477F4A365B0F() {
  return self._id_45E9D104C0A834C7._id_C90213A6575F2880;
}

_id_4352A63D3925798B() {
  return self._id_45E9D104C0A834C7._id_1624B445A428C297 != 0;
}

_id_91E510BCC622BFD0() {
  return self._id_45E9D104C0A834C7._id_1624B445A428C297;
}

_id_60994558E6D2F494(_id_BF334F5702551108) {
  self._id_45E9D104C0A834C7._id_1624B445A428C297 = _id_BF334F5702551108;
}

_id_3A1F121991C200E3(ref, _id_0F5E6316C2383F5F, result) {
  _id_34E326B47A846F0B = _id_C50EA39387684E41(ref);
  _id_1656B06379E3E9D8 = ["stat_3C8456C54E76812C", "stat_FDB2304A21C8DACE", "stat_473B9DCBA8D00879", "stat_0A8BE9518A2A9868", "stat_080F6033E24A2BF4"];
  _id_5814D27874B48E54 = _func_50F8A8F765BAD85E(_func_2EF675C13CA1C4AF("enum_6B016976AFF9AE9F", _id_34E326B47A846F0B), _id_1656B06379E3E9D8);

  if(!_id_ACBAC8F30B95D690(_id_5814D27874B48E54)) {
    return;
  }
  _id_5814D27874B48E54.player = self;
  callback = "mobile_ftue_step_start";

  if(istrue(_id_5814D27874B48E54._id_BBF88C7737619325)) {
    _id_5814D27874B48E54.result = "SUCCESS";
    callback = "mobile_ftue_step_single";
  } else if(_id_0F5E6316C2383F5F) {
    _id_5814D27874B48E54.result = result;
    callback = "mobile_ftue_step_finished";
  }

  _id_4A6760982B403BAD::_id_80820D6D364C1836(callback, _id_5814D27874B48E54);
}

_id_ACBAC8F30B95D690(_id_5814D27874B48E54) {
  return isDefined(_id_5814D27874B48E54._id_42BB97B677759800) && _id_5814D27874B48E54._id_42BB97B677759800 != "";
}

_id_143BBA0D625B5C0C(string, _id_E71970912DEC8924) {}

_id_A0B330EF676908FF(string, playerent) {}

_id_6F4C6BD7C830E161(string, playerent) {}