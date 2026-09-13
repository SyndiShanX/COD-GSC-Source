/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3099e12a7555bf85.gsc
***********************************************/

init(_id_17E4F9DE4E9C7906) {
  if(!isDefined(_id_17E4F9DE4E9C7906) || _id_17E4F9DE4E9C7906 == "") {
    return;
  }
  _id_25EA48876F86D21E = getscriptbundle(_func_2EF675C13CA1C4AF("enum_2BBCECC836419D0B", _id_17E4F9DE4E9C7906));

  if(!isDefined(_id_25EA48876F86D21E)) {
    return;
  }
  _id_17E4F9DE4E9C7906 = _id_25EA48876F86D21E._id_EF1866C5D314A352;

  if(!isDefined(_id_17E4F9DE4E9C7906) || _id_17E4F9DE4E9C7906.size == 0) {
    return;
  }
  _id_D4B9E030F49735D5 = 0;
  _id_7A9DD2FFE1AEDE2A = strtok(getDvar("dvar_8422039C51781BF1", ""), " ");

  for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < _id_17E4F9DE4E9C7906.size; _id_AC0E5B4AC96AA80E++) {
    if(_id_7A9DD2FFE1AEDE2A.size > 0 && isDefined(_id_7A9DD2FFE1AEDE2A[_id_AC0E5B4AC96AA80E]))
      _id_17E4F9DE4E9C7906[_id_AC0E5B4AC96AA80E].weight = float(_id_7A9DD2FFE1AEDE2A[_id_AC0E5B4AC96AA80E]);

    if(!isDefined(_id_17E4F9DE4E9C7906[_id_AC0E5B4AC96AA80E].weight))
      _id_17E4F9DE4E9C7906[_id_AC0E5B4AC96AA80E].weight = 0;

    _id_D4B9E030F49735D5 = _id_D4B9E030F49735D5 + _id_17E4F9DE4E9C7906[_id_AC0E5B4AC96AA80E].weight;
  }

  _id_55BEDC0453A6C09B = randomfloat(_id_D4B9E030F49735D5);
  _id_C2A009E075D70716 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_17E4F9DE4E9C7906.size; _id_AC0E594AC96AA3A8++) {
    _id_B953C4B1E9ED888C = _id_C2A009E075D70716 + _id_17E4F9DE4E9C7906[_id_AC0E594AC96AA3A8].weight;

    if(_id_B953C4B1E9ED888C > _id_55BEDC0453A6C09B) {
      _id_41368388D296A0D0 = _id_17E4F9DE4E9C7906[_id_AC0E594AC96AA3A8];
      _id_AFD4C1E75AEE7F02(_id_41368388D296A0D0._id_5F23C51AA82AF90A);
      return;
    }

    _id_C2A009E075D70716 = _id_B953C4B1E9ED888C;
  }
}

_id_AFD4C1E75AEE7F02(_id_5F23C51AA82AF90A) {
  if(!isDefined(_id_5F23C51AA82AF90A) || _id_5F23C51AA82AF90A == "") {
    return;
  }
  _id_25EA48876F86D21E = getscriptbundle(_func_2EF675C13CA1C4AF("enum_7D9482F6248686C3", _id_5F23C51AA82AF90A));

  if(!isDefined(_id_25EA48876F86D21E)) {
    return;
  }
  if(!isDefined(_id_25EA48876F86D21E._id_BE7C088A50041A3B) || _id_25EA48876F86D21E._id_BE7C088A50041A3B.size == 0) {
    return;
  }
  level._id_E198C297CEB14C19 = getdvarint("dvar_37763C7311E5B8DA", 256);
  level._id_FBCA612D854A3975 = getdvarfloat("dvar_D1676BE1E671F038", 0.306);
  level._id_AE361B9FC9ED6213 = getdvarfloat("dvar_8EEBBBE30D21A94A", 1);
  level._id_8EE11212CEB130EF = getdvarfloat("dvar_64E3E719E88B3FFA", 0.922347);
  level._id_F8397FF86C4282E8 = getdvarfloat("dvar_2B9D51C935985EFF", 0.870588);
  level._id_98C604069085FC53 = [];
  level._id_BE7C088A50041A3B = _id_25EA48876F86D21E._id_BE7C088A50041A3B;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_BE7C088A50041A3B.size; _id_AC0E594AC96AA3A8++)
    level._id_BE7C088A50041A3B[_id_AC0E594AC96AA3A8].state = getscriptbundle(_func_2EF675C13CA1C4AF("enum_06B3D349B362EC62", level._id_BE7C088A50041A3B[_id_AC0E594AC96AA3A8].state));

  _id_EB5F92DD86009248 = _id_BA1AC5101C4B8B85();

  if(isDefined(_id_EB5F92DD86009248) && isDefined(_id_EB5F92DD86009248.state))
    level thread _id_5D6D8EC8B7599CFD(_id_EB5F92DD86009248);

  thread _id_464132FACDF4A21F();

  if(getdvarint("dvar_826BE4F15AC0748E", 1) == 1) {
    level thread _id_E79D5AA841ABECC9();
    level thread _id_76A30C6E8BC2A46D();
  }

  scripts\mp\flags::gameflaginit("mood_manager", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("mood", "onSetupMoodSet"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("mood", "onSetupMoodSet")]](level._id_BE7C088A50041A3B);

  if(scripts\mp\utility\game::getsubgametype() != "dmz")
    level thread _id_6954EDB9716497E3();
}

_id_47C350F5D0FB2EF0(_id_1E6AB50ECBD9CFAA) {
  if(!isDefined(_id_1E6AB50ECBD9CFAA)) {
    return;
  }
  if(isDefined(level._id_1BB44C81EDF3F3A9)) {
    if(level._id_1BB44C81EDF3F3A9._id_CB8AC82927B49276 == "circles" && _id_1E6AB50ECBD9CFAA._id_CB8AC82927B49276 == "circles") {
      _id_D3B9D5681DEFBB4E = scripts\engine\utility::_id_53C4C53197386572(_id_1E6AB50ECBD9CFAA.circleindex, 0);
      _id_D3B9D4681DEFB91B = scripts\engine\utility::_id_53C4C53197386572(level._id_1BB44C81EDF3F3A9.circleindex, 0);

      if(_id_D3B9D5681DEFBB4E == _id_D3B9D4681DEFB91B)
        return;
    }
  }

  if(!isDefined(_id_1E6AB50ECBD9CFAA.state)) {
    return;
  }
  _id_4D896F562D6E92BD = level._id_1BB44C81EDF3F3A9;
  level._id_1BB44C81EDF3F3A9 = _id_1E6AB50ECBD9CFAA;

  if(getdvarint("dvar_9E046B4CBE0B3242", -1) > -1)
    level._id_1BB44C81EDF3F3A9._id_B18D3429CF88F29F = getdvarint("dvar_9E046B4CBE0B3242");

  thread _id_95FA48154C5F317C();
  _id_519C36CFE2838F8A();
  _id_5DD4A6BDC5A18A0F();
  _id_24427ED3F5C1CCC3();
  thread _id_D579BAB00A3EF871();
  thread _id_2EF05A1DF426A720();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("mood", "onSetMood"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("mood", "onSetMood")]](_id_1E6AB50ECBD9CFAA, _id_4D896F562D6E92BD);
}

_id_95FA48154C5F317C() {
  _id_0E4731409BD255E0 = level._id_1BB44C81EDF3F3A9.state._id_5FA416AA85E45ADE;

  if(!isDefined(_id_0E4731409BD255E0))
    _id_0E4731409BD255E0 = "";

  duration = 0;

  if(isDefined(level._id_1BB44C81EDF3F3A9._id_B18D3429CF88F29F) && level._id_1BB44C81EDF3F3A9._id_B18D3429CF88F29F >= 0)
    duration = level._id_1BB44C81EDF3F3A9._id_B18D3429CF88F29F;

  _func_F92878651D302FE9(duration, _id_0E4731409BD255E0);
}

_id_5D6D8EC8B7599CFD(_id_1E6AB50ECBD9CFAA) {
  level endon("game_ended");

  if(!isDefined(_id_1E6AB50ECBD9CFAA.state)) {
    return;
  }
  level._id_1BB44C81EDF3F3A9 = _id_1E6AB50ECBD9CFAA;
  thread _id_D579BAB00A3EF871();
  thread _id_2EF05A1DF426A720(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("mood", "onSetMood"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("mood", "onSetMood")]](_id_1E6AB50ECBD9CFAA, undefined);

  for(;;) {
    level waittill("connected", player);
    _id_67B078E888405EBF(player);
  }
}

_id_A56C4E72231CE9A2(_id_453AACDEFD19ACB4) {
  if(!isDefined(level._id_1BB44C81EDF3F3A9.state._id_5FA416AA85E45ADE)) {
    return;
  }
  if(!istrue(_id_453AACDEFD19ACB4))
    self waittill("spawned_player");

  duration = 0;
  _id_0E4731409BD255E0 = level._id_1BB44C81EDF3F3A9.state._id_5FA416AA85E45ADE;
  self _meth_EB0326E0C8803F41(duration, _id_0E4731409BD255E0);
}

_id_464132FACDF4A21F() {
  level scripts\engine\utility::flag_wait("StartGameTypeCallbackFinished");
  _id_04CDABCD91A92977::_id_8FE6D6539ED31A88(::_id_5C79B3DF3D147F51);
}

_id_5C79B3DF3D147F51(player) {
  _id_67B078E888405EBF(player, 1);
}

_id_67B078E888405EBF(player, _id_453AACDEFD19ACB4) {
  player thread _id_A56C4E72231CE9A2(_id_453AACDEFD19ACB4);
  thread _id_519C36CFE2838F8A(player, _id_453AACDEFD19ACB4);
  thread _id_24427ED3F5C1CCC3(player, _id_453AACDEFD19ACB4);
}

_id_E79D5AA841ABECC9() {
  level endon("game_ended");

  for(;;) {
    level waittill("br_circle_set");
    _id_8CDB14D4A73A90A6 = _id_8725CC1E47D95528(level.br_circle.circleindex);

    if(isDefined(_id_8CDB14D4A73A90A6)) {
      _id_47C350F5D0FB2EF0(_id_8CDB14D4A73A90A6);
      continue;
    }

    continue;
  }
}

_id_76A30C6E8BC2A46D() {
  level endon("game_ended");
  level waittill("prematch_fade_done");

  if(!isDefined(level.starttime))
    level.starttime = gettime();

  waittime = 60;
  _id_8CDB14D4A73A90A6 = undefined;
  _id_35963274858B5330 = 1;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_35963274858B5330 = 0;

  for(;;) {
    if(isDefined(_id_8CDB14D4A73A90A6)) {
      _id_47C350F5D0FB2EF0(_id_8CDB14D4A73A90A6);
      _id_8CDB14D4A73A90A6 = undefined;
      waittime = 60;
      continue;
    } else {
      _id_8CDB14D4A73A90A6 = _id_12F05FEF0DF24CD7(waittime, _id_35963274858B5330);
      _id_35963274858B5330 = 0;
    }

    if(isDefined(_id_8CDB14D4A73A90A6)) {
      waittime = _id_8CDB14D4A73A90A6.starttime * 60 - (gettime() - level.starttime) / 1000;
      waittime = max(waittime, 0);
    }

    wait(waittime);
  }
}

_id_8725CC1E47D95528(index) {
  foreach(_id_1E6AB50ECBD9CFAA in level._id_BE7C088A50041A3B) {
    if(_id_1E6AB50ECBD9CFAA._id_CB8AC82927B49276 != "circles") {
      continue;
    }
    if(!isDefined(_id_1E6AB50ECBD9CFAA.circleindex)) {
      if(index == 0) {
        _id_1E6AB50ECBD9CFAA.circleindex = index;
        return _id_1E6AB50ECBD9CFAA;
      }
    } else if(_id_1E6AB50ECBD9CFAA.circleindex == index)
      return _id_1E6AB50ECBD9CFAA;
  }

  return undefined;
}

_id_12F05FEF0DF24CD7(_id_373BDFA57FC2EBEE, _id_35963274858B5330) {
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    if(!isDefined(level.starttime))
      level.starttime = gettime();
  }

  currenttime = gettime() - level.starttime;
  currenttime = currenttime * 0.001;

  foreach(_id_1E6AB50ECBD9CFAA in level._id_BE7C088A50041A3B) {
    if(_id_1E6AB50ECBD9CFAA._id_CB8AC82927B49276 != "time") {
      continue;
    }
    if(!isDefined(_id_1E6AB50ECBD9CFAA.starttime))
      _id_1E6AB50ECBD9CFAA.starttime = 0;

    if(istrue(_id_35963274858B5330) && _id_1E6AB50ECBD9CFAA.starttime == 0)
      return _id_1E6AB50ECBD9CFAA;

    _id_9275F91463AD3FCB = _id_1E6AB50ECBD9CFAA.starttime * 60;

    if(_id_9275F91463AD3FCB > currenttime && _id_9275F91463AD3FCB - currenttime <= _id_373BDFA57FC2EBEE)
      return _id_1E6AB50ECBD9CFAA;
  }

  return undefined;
}

_id_519C36CFE2838F8A(player, _id_453AACDEFD19ACB4) {
  exploders = level._id_1BB44C81EDF3F3A9.state.exploders;

  if(!isDefined(exploders) || exploders.size == 0) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < exploders.size; _id_AC0E594AC96AA3A8++)
    exploders[_id_AC0E594AC96AA3A8] thread _id_A3875F674F301BE6(_id_AC0E594AC96AA3A8, player, _id_453AACDEFD19ACB4);
}

_id_A3875F674F301BE6(index, player, _id_453AACDEFD19ACB4) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }
  _id_F0485185D96372FC = level._id_1BB44C81EDF3F3A9._id_F0485185D96372FC;

  if(isDefined(_id_F0485185D96372FC) && _id_F0485185D96372FC.size > 0 && isDefined(_id_F0485185D96372FC[index]) && isDefined(_id_F0485185D96372FC[index].delay)) {
    delay = _id_F0485185D96372FC[index].delay;
    wait(delay);
  }

  if(istrue(self.active)) {
    if(isDefined(level._id_98C604069085FC53) && istrue(level._id_98C604069085FC53[self.name])) {
      return;
    }
    if(isDefined(player) && isPlayer(player)) {
      if(!istrue(_id_453AACDEFD19ACB4))
        player waittill("spawned_player");

      activateclientexploder(self.name, player, gettime(), level._id_E198C297CEB14C19);
    } else
      activateclientexploder(self.name, level.players, gettime(), level._id_E198C297CEB14C19);
  } else
    stopclientexploder(self.name);
}

_id_5DD4A6BDC5A18A0F() {
  exploders = level._id_1BB44C81EDF3F3A9.state.exploders;

  if(!isDefined(exploders) || exploders.size == 0) {
    return;
  }
  if(!isDefined(level._id_98C604069085FC53))
    level._id_98C604069085FC53 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < exploders.size; _id_AC0E594AC96AA3A8++) {
    if(istrue(exploders[_id_AC0E594AC96AA3A8].active)) {
      level._id_98C604069085FC53[exploders[_id_AC0E594AC96AA3A8].name] = 1;
      continue;
    }

    level._id_98C604069085FC53[exploders[_id_AC0E594AC96AA3A8].name] = undefined;
  }
}

_id_24427ED3F5C1CCC3(player, _id_453AACDEFD19ACB4) {
  _id_E4DD95BA8D116CBE = level._id_1BB44C81EDF3F3A9.state._id_E4DD95BA8D116CBE;

  if(!isDefined(_id_E4DD95BA8D116CBE) || _id_E4DD95BA8D116CBE.size == 0) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E4DD95BA8D116CBE.size; _id_AC0E594AC96AA3A8++)
    _id_E4DD95BA8D116CBE[_id_AC0E594AC96AA3A8] thread _id_6FAD46877DE34A3B(_id_AC0E594AC96AA3A8, player, _id_453AACDEFD19ACB4);
}

_id_6FAD46877DE34A3B(index, player, _id_453AACDEFD19ACB4) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }
  id = scripts\engine\utility::_id_53C4C53197386572(self.id, "");
  state = scripts\engine\utility::_id_53C4C53197386572(self.state, "");
  _id_F69BA8D7B96E8326 = 10;
  _id_C6D7A76CCE0AD3EF = level._id_1BB44C81EDF3F3A9._id_C55CE35ED96A2D2C;

  if(isDefined(_id_C6D7A76CCE0AD3EF) && isDefined(_id_C6D7A76CCE0AD3EF[index]))
    _id_F69BA8D7B96E8326 = scripts\engine\utility::_id_53C4C53197386572(_id_C6D7A76CCE0AD3EF[index]._id_F69BA8D7B96E8326, _id_F69BA8D7B96E8326);

  if(isDefined(player) && isPlayer(player)) {
    if(!istrue(_id_453AACDEFD19ACB4))
      player waittill("spawned_player");

    setaudiotriggerstate(id, state, _id_F69BA8D7B96E8326, player);
  } else
    setaudiotriggerstate(id, state, _id_F69BA8D7B96E8326);
}

_id_D579BAB00A3EF871() {
  level endon("game_ended");

  if(level._id_1BB44C81EDF3F3A9._id_CB8AC82927B49276 == "circles" && isDefined(level._id_1BB44C81EDF3F3A9.circleindex) && level._id_1BB44C81EDF3F3A9.circleindex == -1 && !istrue(level._id_05FEB27AF9025D27))
    level waittill("prematch_fade_done");

  if(!isDefined(level._id_1BB44C81EDF3F3A9.state.sunlight)) {
    return;
  }
  sunlight = [];

  if(isDefined(level._id_1BB44C81EDF3F3A9.state.sunlight.color) && level._id_1BB44C81EDF3F3A9.state.sunlight.color != "") {
    _id_67F14F8315CB0F2F = strtok(level._id_1BB44C81EDF3F3A9.state.sunlight.color, " ");
    _id_CBA41E031462F3D0 = float(_id_67F14F8315CB0F2F[0]);
    _id_CAAE05637AC7AE10 = float(_id_67F14F8315CB0F2F[1]);
    _id_D6348C41222908A1 = float(_id_67F14F8315CB0F2F[2]);
    sunlight[sunlight.size] = scripts\engine\utility::ter_op(_id_CBA41E031462F3D0 != 0.0, _id_CBA41E031462F3D0, undefined);
    sunlight[sunlight.size] = scripts\engine\utility::ter_op(_id_CAAE05637AC7AE10 != 0.0, _id_CAAE05637AC7AE10, undefined);
    sunlight[sunlight.size] = scripts\engine\utility::ter_op(_id_D6348C41222908A1 != 0.0, _id_D6348C41222908A1, undefined);
  }

  sunlight[sunlight.size] = level._id_1BB44C81EDF3F3A9.state.sunlight.intensity;
  thread _id_E926344AF0B8A54E(sunlight, level._id_1BB44C81EDF3F3A9._id_B18D3429CF88F29F);
}

_id_E926344AF0B8A54E(_id_3C6834588DE16243, time) {
  level endon("game_ended");

  if(!isDefined(_id_3C6834588DE16243)) {
    return;
  }
  _id_7A8D2CB8D7089E94 = isDefined(_id_3C6834588DE16243[0]) && isDefined(_id_3C6834588DE16243[1]) && isDefined(_id_3C6834588DE16243[2]);
  _id_E951E895FB5D8C46 = isDefined(_id_3C6834588DE16243[3]) || isDefined(_id_3C6834588DE16243[0]) && !_id_7A8D2CB8D7089E94;

  if(!istrue(_id_7A8D2CB8D7089E94) && !istrue(_id_E951E895FB5D8C46)) {
    return;
  }
  if(!isDefined(level._id_8C4540AB5278F235))
    level._id_8C4540AB5278F235 = [];

  _id_9702326CF645545F = [];

  if(_id_7A8D2CB8D7089E94) {
    _id_9702326CF645545F[0] = scripts\engine\utility::_id_53C4C53197386572(level._id_8C4540AB5278F235[0], level._id_AE361B9FC9ED6213);
    _id_9702326CF645545F[1] = scripts\engine\utility::_id_53C4C53197386572(level._id_8C4540AB5278F235[1], level._id_8EE11212CEB130EF);
    _id_9702326CF645545F[2] = scripts\engine\utility::_id_53C4C53197386572(level._id_8C4540AB5278F235[2], level._id_F8397FF86C4282E8);
  }

  if(_id_E951E895FB5D8C46) {
    if(_id_7A8D2CB8D7089E94)
      index = 3;
    else
      index = 0;

    _id_9702326CF645545F[index] = scripts\engine\utility::_id_53C4C53197386572(level._id_8C4540AB5278F235[3], level._id_FBCA612D854A3975);
  }

  if(isDefined(time) && time > 0) {
    range = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3C6834588DE16243.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(_id_3C6834588DE16243[_id_AC0E594AC96AA3A8]))
        range[_id_AC0E594AC96AA3A8] = _id_3C6834588DE16243[_id_AC0E594AC96AA3A8] - _id_9702326CF645545F[_id_AC0E594AC96AA3A8];
    }

    next = _id_9702326CF645545F;
    interval = 0.25;
    count = int(time / interval);

    if(count > 0) {
      _id_3777ECE6A73EADA5 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < range.size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(range[_id_AC0E594AC96AA3A8]))
          _id_3777ECE6A73EADA5[_id_AC0E594AC96AA3A8] = range[_id_AC0E594AC96AA3A8] / count;
      }

      while(count) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3777ECE6A73EADA5.size; _id_AC0E594AC96AA3A8++) {
          if(isDefined(_id_3777ECE6A73EADA5[_id_AC0E594AC96AA3A8]))
            next[_id_AC0E594AC96AA3A8] = next[_id_AC0E594AC96AA3A8] + _id_3777ECE6A73EADA5[_id_AC0E594AC96AA3A8];
        }

        if(_id_7A8D2CB8D7089E94 && _id_E951E895FB5D8C46)
          setsuncolorandintensity(next[0], next[1], next[2], next[3]);
        else if(_id_7A8D2CB8D7089E94)
          setsuncolorandintensity(next[0], next[1], next[2]);
        else
          setsuncolorandintensity(next[0]);

        wait(interval);
        count--;
      }
    }
  }

  if(_id_7A8D2CB8D7089E94 && _id_E951E895FB5D8C46) {
    setsuncolorandintensity(_id_3C6834588DE16243[0], _id_3C6834588DE16243[1], _id_3C6834588DE16243[2], _id_3C6834588DE16243[3]);
    level._id_8C4540AB5278F235[0] = _id_3C6834588DE16243[0];
    level._id_8C4540AB5278F235[1] = _id_3C6834588DE16243[1];
    level._id_8C4540AB5278F235[2] = _id_3C6834588DE16243[2];
    level._id_8C4540AB5278F235[3] = _id_3C6834588DE16243[3];
  } else if(_id_7A8D2CB8D7089E94) {
    setsuncolorandintensity(_id_3C6834588DE16243[0], _id_3C6834588DE16243[1], _id_3C6834588DE16243[2]);
    level._id_8C4540AB5278F235[0] = _id_3C6834588DE16243[0];
    level._id_8C4540AB5278F235[1] = _id_3C6834588DE16243[1];
    level._id_8C4540AB5278F235[2] = _id_3C6834588DE16243[2];
  } else {
    setsuncolorandintensity(_id_3C6834588DE16243[0]);
    level._id_8C4540AB5278F235[3] = _id_3C6834588DE16243[0];
  }
}

_id_2EF05A1DF426A720(_id_5CFF4E1849051FA3) {
  level endon("game_ended");

  if(!isDefined(level._id_1BB44C81EDF3F3A9.state._id_DC80FD8052E1C26D)) {
    return;
  }
  if(isDefined(level._id_B50A28B117AA65CD))
    _func_90FB4916AA7FD9F3(level._id_B50A28B117AA65CD);

  if(isDefined(level._id_1BB44C81EDF3F3A9._id_E3CF72E793015995)) {
    delay = level._id_1BB44C81EDF3F3A9._id_E3CF72E793015995;
    wait(delay);
  }

  if(istrue(_id_5CFF4E1849051FA3))
    _func_EE7C0CCDE65DE2EC(level._id_1BB44C81EDF3F3A9.state._id_DC80FD8052E1C26D);
  else
    _func_7C2E0421AA80F818(level._id_1BB44C81EDF3F3A9.state._id_DC80FD8052E1C26D, 15000, "MIDDLE");

  level._id_B50A28B117AA65CD = level._id_1BB44C81EDF3F3A9.state._id_DC80FD8052E1C26D;
}

_id_BA1AC5101C4B8B85() {
  _id_EB5F92DD86009248 = undefined;

  if(scripts\mp\utility\game::getsubgametype() == "dmz")
    _id_EB5F92DD86009248 = _id_12F05FEF0DF24CD7(0, 1);
  else
    _id_EB5F92DD86009248 = _id_8725CC1E47D95528(-1);

  return _id_EB5F92DD86009248;
}

_id_6954EDB9716497E3() {
  level endon("game_ended");
  level waittill("prematch_fade_done");
  _id_5DD4A6BDC5A18A0F();
}