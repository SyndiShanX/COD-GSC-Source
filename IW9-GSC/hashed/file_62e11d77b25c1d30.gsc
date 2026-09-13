/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_62e11d77b25c1d30.gsc
***********************************************/

_id_A606867D80CFABD5(player, aliases, delay, priority, timeout, _id_F6E387B9F5A2B39C, scope) {
  scope = scripts\engine\utility::_id_53C4C53197386572(scope, "team");

  if(isDefined(player)) {}

  alias = _id_C810DB5F583495B1(player, aliases);

  if(isstruct(alias))
    alias = alias scripts\engine\utility::deck_draw();

  if(!isDefined(alias))
    return 0;

  player._id_568A463DBBA1469C = 1;
  _id_7C50C629B4D4086A(1, "speaking");
  result = player _id_5D265B4FCA61F070::say(alias, priority, timeout, _id_F6E387B9F5A2B39C, delay, scope);
  _id_7C50C629B4D4086A(0, "speaking");
  return result;
}

_id_C810DB5F583495B1(player, aliases) {
  if(!_id_6B80A21EDCF9D296(player) || !isDefined(player._id_938E8B2CA6549759)) {
    return;
  }
  if(isstruct(aliases))
    return aliases;

  if(isstring(aliases))
    return aliases;

  switch (player._id_938E8B2CA6549759) {
    case "farah":
      return aliases[0];
    case "price":
      return aliases[1];
    case "alex":
    case "gaz":
      return aliases[2];
    default:
      return;
  }
}

_id_AA8653DEA5520361(timeout, players) {
  _id_7D2852D02216C876 = _id_29714545859E6445(players)[0];

  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    _id_7D2852D02216C876 = _id_29714545859E6445(players)[0];

    if(isDefined(_id_7D2852D02216C876))
      return _id_7D2852D02216C876;

    waitframe();
  }

  return _id_7D2852D02216C876;
}

_id_88BC9CD1FFAB6FEF(origin, timeout, players, maxdist) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  _id_9667B18C20430352 = scripts\cp\utility::getplayersinradius(origin, maxdist);
  _id_E031661B7146A294 = [];

  foreach(player in players) {
    if(scripts\engine\utility::array_contains(_id_9667B18C20430352, player))
      _id_E031661B7146A294 = scripts\engine\utility::array_add(_id_E031661B7146A294, player);
  }

  _id_E031661B7146A294 = scripts\engine\utility::array_removeundefined(_id_E031661B7146A294);
  return _id_AA8653DEA5520361(timeout, _id_E031661B7146A294);
}

_id_A9D9C0245997A414(timeout, players) {
  _id_7D2852D02216C876 = _id_6B2A1B9750071995(players);

  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    _id_7D2852D02216C876 = _id_6B2A1B9750071995(players);

    if(isDefined(_id_7D2852D02216C876))
      return _id_7D2852D02216C876;

    waitframe();
  }

  return _id_7D2852D02216C876;
}

_id_43D8FA96ACF30CA8(origin, timeout, players, maxdist, _id_636C8575D7A7768B) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  _id_6BCD40D4AAE48211 = scripts\engine\utility::get_array_of_closest(origin, players, undefined, undefined, maxdist, _id_636C8575D7A7768B);
  return _id_AA8653DEA5520361(timeout, _id_6BCD40D4AAE48211);
}

_id_215866EE17ECD840(origin, timeout, range, _id_80BF6212193E8983) {
  _id_CEAD4E87C3F90536 = scripts\cp\utility::getplayersinradius(origin, range, undefined, _id_80BF6212193E8983);
  return _id_A9D9C0245997A414(timeout, _id_CEAD4E87C3F90536);
}

_id_6B80A21EDCF9D296(player) {
  return isDefined(player) && player scripts\cp\utility::is_valid_player(1, 1) && !player _meth_6F55D55CCFF20D14();
}

_id_6B2A1B9750071995(players) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  speakers = _id_29714545859E6445(players);
  return scripts\engine\utility::random(speakers);
}

_id_29714545859E6445(players, _id_94564218DD6125B9) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, level.players);
  speakers = [];

  if(isDefined(_id_94564218DD6125B9) && !isarray(_id_94564218DD6125B9))
    _id_94564218DD6125B9 = [_id_94564218DD6125B9];

  foreach(player in players) {
    if(isDefined(_id_94564218DD6125B9) && isDefined(player) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
      continue;
    }
    if(_id_6B80A21EDCF9D296(player))
      speakers[speakers.size] = player;
  }

  return scripts\engine\utility::array_randomize(speakers);
}

_id_24F716A0A25DAF74(_id_94564218DD6125B9, players) {
  return _id_A16693E3894FAF9F(players, _id_94564218DD6125B9);
}

_id_A16693E3894FAF9F(players, _id_94564218DD6125B9) {
  _id_E50F13A24D028E8B = _id_29714545859E6445(players, _id_94564218DD6125B9);

  if(_id_E50F13A24D028E8B.size == 0) {
    return;
  }
  _id_773E085232EB495C = _id_E50F13A24D028E8B[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_E50F13A24D028E8B.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8]._id_EEF929505A9B77B9))
      _id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8]._id_EEF929505A9B77B9 = 0;

    if(_id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8]._id_EEF929505A9B77B9 < _id_773E085232EB495C._id_EEF929505A9B77B9)
      _id_773E085232EB495C = _id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8];
  }

  return _id_773E085232EB495C;
}

_id_167FAE92423447B9(players, _id_94564218DD6125B9) {
  _id_E50F13A24D028E8B = _id_29714545859E6445(players, _id_94564218DD6125B9);

  if(_id_E50F13A24D028E8B.size == 0) {
    return;
  }
  _id_E50F13A24D028E8B = scripts\engine\utility::array_randomize(_id_E50F13A24D028E8B);
  _id_379AFB3CF9D6AB22 = _id_E50F13A24D028E8B[0];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_E50F13A24D028E8B.size; _id_AC0E594AC96AA3A8++) {
    if(scripts\engine\utility::_id_53C4C53197386572(_id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8].last_weapon_fired_time, 0) > scripts\engine\utility::_id_53C4C53197386572(_id_379AFB3CF9D6AB22.last_weapon_fired_time, 0))
      _id_379AFB3CF9D6AB22 = _id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8];
  }

  return _id_379AFB3CF9D6AB22;
}

_id_FC0D35F400F49506(_id_94564218DD6125B9) {
  return _id_167FAE92423447B9(level.players, _id_94564218DD6125B9);
}

_id_47C84E03DCBC5AA7(origin, players, _id_94564218DD6125B9) {
  _id_E50F13A24D028E8B = _id_29714545859E6445(players, _id_94564218DD6125B9);

  if(_id_E50F13A24D028E8B.size == 0) {
    return;
  }
  _id_E50F13A24D028E8B = scripts\engine\utility::array_randomize(_id_E50F13A24D028E8B);
  closestplayer = _id_E50F13A24D028E8B[0];
  _id_40A6E4F086BAAE9B = distancesquared(closestplayer.origin, origin);

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_E50F13A24D028E8B.size; _id_AC0E594AC96AA3A8++) {
    _id_4EB801042B324702 = distancesquared(_id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8].origin, origin);

    if(_id_4EB801042B324702 < _id_40A6E4F086BAAE9B) {
      closestplayer = _id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8];
      _id_40A6E4F086BAAE9B = _id_4EB801042B324702;
    }
  }

  return closestplayer;
}

_id_6533A630C9443AAC(origin, _id_94564218DD6125B9) {
  return _id_47C84E03DCBC5AA7(origin, level.players, _id_94564218DD6125B9);
}

_id_D63542EBC6F90151(origin, players, _id_94564218DD6125B9) {
  _id_E50F13A24D028E8B = _id_29714545859E6445(players, _id_94564218DD6125B9);

  if(_id_E50F13A24D028E8B.size == 0) {
    return;
  }
  _id_E50F13A24D028E8B = scripts\engine\utility::array_randomize(_id_E50F13A24D028E8B);
  _id_294394177AA80037 = _id_E50F13A24D028E8B[0];
  _id_828AD8E01A395499 = distancesquared(_id_294394177AA80037.origin, origin);

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_E50F13A24D028E8B.size; _id_AC0E594AC96AA3A8++) {
    _id_4EB801042B324702 = distancesquared(_id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8].origin, origin);

    if(_id_4EB801042B324702 > _id_828AD8E01A395499) {
      _id_294394177AA80037 = _id_E50F13A24D028E8B[_id_AC0E594AC96AA3A8];
      _id_828AD8E01A395499 = _id_4EB801042B324702;
    }
  }

  return _id_294394177AA80037;
}

_id_51DEC43386554CAE(origin, _id_94564218DD6125B9) {
  return _id_D63542EBC6F90151(origin, level.players, _id_94564218DD6125B9);
}

_id_C51AB16BE84F5675() {
  scripts\engine\utility::waittill_any_ents_array(getaiarray("axis"), "stealth_combat");
  level notify("stealth_combat");
}

_id_99A887D75310BF40(time, _id_DA131BE836149780) {
  _id_DA131BE836149780 = scripts\engine\utility::_id_53C4C53197386572(_id_DA131BE836149780, 0);

  while(!istrue(_id_3278FE5D41A5D027(time, _id_DA131BE836149780)))
    continue;
}

_id_3278FE5D41A5D027(time, _id_DA131BE836149780) {
  msg = scripts\engine\utility::ter_op(_id_DA131BE836149780, "vo_strict_combat", "vo_combat");
  scripts\engine\utility::flag_waitopen(msg);
  level endon(msg);
  wait(time);
  return 1;
}

_id_73709F2B96C09080(array, _id_01ED762217419B34, _id_7D0D6FC0C0489FBA) {
  array = scripts\engine\utility::_id_53C4C53197386572(array, getaiarray("axis"));
  _id_2C85EC531CCF8E15 = 0;

  foreach(guy in array) {
    if(scripts\engine\utility::is_dead_or_dying(guy) || istrue(guy._id_776F2137854DF85E) || istrue(guy.in_melee_death)) {
      continue;
    }
    if(!isPlayer(guy.enemy)) {
      continue;
    }
    level._id_949A50E725B56274 = guy;

    if(istrue(_id_01ED762217419B34) && (!isDefined(guy._blackboard._id_060DCAA3D3BE97AB) || scripts\engine\utility::time_has_passed(guy._blackboard._id_060DCAA3D3BE97AB, 10))) {
      if(guy._id_FE5EBEFA740C7106 == 3 || guy._id_FE5EBEFA740C7106 == 4) {
        _id_2C85EC531CCF8E15++;

        if(isDefined(_id_7D0D6FC0C0489FBA) && _id_2C85EC531CCF8E15 > _id_7D0D6FC0C0489FBA)
          return 1;
      }
    } else if(guy._id_FE5EBEFA740C7106 == 3 || guy._id_FE5EBEFA740C7106 == 4)
      return 1;
  }

  return 0;
}

_id_E35E13135222B2A8(count) {
  _id_05956C54E54EBF3D = 0;

  foreach(player in level.players) {
    if(player scripts\cp\utility::is_valid_player(1, 1))
      _id_05956C54E54EBF3D++;
  }

  while(_id_05956C54E54EBF3D < count) {
    waitframe();
    _id_05956C54E54EBF3D = 0;

    foreach(player in level.players) {
      if(player scripts\cp\utility::is_valid_player(1, 1))
        _id_05956C54E54EBF3D++;
    }
  }
}

_id_B826409EE2EFF7B6(height, players) {
  return _id_4E943B7BA4CCBBE8(2, height, players);
}

_id_F28ADB32E474B426(height, players) {
  return _id_3B46C8D1F1AE39D3(2, height, players);
}

_id_4E943B7BA4CCBBE8(_id_47CC057E8A7B1FBE, value, players, timeout) {
  if(isDefined(players) && !isarray(players))
    players = [players];

  for(time = 0; !isDefined(timeout) || time < timeout; time = time + 0.05) {
    foreach(player in scripts\engine\utility::_id_53C4C53197386572(players, level.players)) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player.origin[_id_47CC057E8A7B1FBE] > value)
        return player;
    }

    waitframe();
  }
}

_id_816A81935C705C98(player, _id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, _id_59F02C6C6C928ED3) {
  _id_59F02C6C6C928ED3 = scripts\engine\utility::_id_53C4C53197386572(_id_59F02C6C6C928ED3, 1);

  if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1))
    return 0;

  if(_id_59F02C6C6C928ED3 && !player isonground())
    return 0;

  return player isinside(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5);
}

_id_1D8DC0F6BBB423BA(_id_12B397CBEAAB23B6, origin2) {
  return isinside(max(_id_12B397CBEAAB23B6[0], origin2[0]), min(_id_12B397CBEAAB23B6[0], origin2[0]), max(_id_12B397CBEAAB23B6[1], origin2[1]), min(_id_12B397CBEAAB23B6[1], origin2[1]), max(_id_12B397CBEAAB23B6[2], origin2[2]), min(_id_12B397CBEAAB23B6[2], origin2[2]));
}

isinside(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5) {
  if((!isDefined(_id_3D9B4679B8D7E8FA) || self.origin[0] < _id_3D9B4679B8D7E8FA) && (!isDefined(_id_4C69B2E8A053C33F) || self.origin[0] > _id_4C69B2E8A053C33F) && (!isDefined(_id_3D9B4779B8D7EB2D) || self.origin[1] < _id_3D9B4779B8D7EB2D) && (!isDefined(_id_4C69B1E8A053C10C) || self.origin[1] > _id_4C69B1E8A053C10C) && (!isDefined(_id_3D9B4479B8D7E494) || self.origin[2] < _id_3D9B4479B8D7E494) && (!isDefined(_id_4C69B4E8A053C7A5) || self.origin[2] > _id_4C69B4E8A053C7A5))
    return 1;

  return 0;
}

_id_07F379814DFAF520(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, timeout) {
  for(time = 0; !isDefined(timeout) || time < timeout; time = time + 0.05) {
    foreach(ai in getaiarray()) {
      if(ai isinside(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5))
        return;
    }

    waitframe();
  }
}

_id_1D977083C90B0996(_id_12B397CBEAAB23B6, origin2, timeout) {
  return _id_537E4A75785D15F5(max(_id_12B397CBEAAB23B6[0], origin2[0]), min(_id_12B397CBEAAB23B6[0], origin2[0]), max(_id_12B397CBEAAB23B6[1], origin2[1]), min(_id_12B397CBEAAB23B6[1], origin2[1]), max(_id_12B397CBEAAB23B6[2], origin2[2]), min(_id_12B397CBEAAB23B6[2], origin2[2]), timeout);
}

_id_537E4A75785D15F5(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, timeout) {
  for(time = 0; !isDefined(timeout) || time < timeout; time = time + 0.05) {
    _id_4B9184EAC6EA3A6E = 1;

    foreach(ai in getaiarray()) {
      if(ai isinside(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5))
        _id_4B9184EAC6EA3A6E = 0;
    }

    if(_id_4B9184EAC6EA3A6E) {
      return;
    }
    waitframe();
  }
}

_id_37EC59F1CC982A2A(_id_12B397CBEAAB23B6, origin2, _id_59F02C6C6C928ED3, players, timeout) {
  return _id_15FCF4C7B710C321(max(_id_12B397CBEAAB23B6[0], origin2[0]), min(_id_12B397CBEAAB23B6[0], origin2[0]), max(_id_12B397CBEAAB23B6[1], origin2[1]), min(_id_12B397CBEAAB23B6[1], origin2[1]), max(_id_12B397CBEAAB23B6[2], origin2[2]), min(_id_12B397CBEAAB23B6[2], origin2[2]), _id_59F02C6C6C928ED3, players, timeout);
}

_id_15FCF4C7B710C321(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, _id_59F02C6C6C928ED3, players, timeout) {
  _id_4506006A3631A139 = scripts\engine\utility::ter_op(isfunction(players), players, undefined);

  if(isDefined(players) && !isarray(players))
    players = [players];

  for(time = 0; !isDefined(timeout) || time < timeout; time = time + 0.05) {
    if(isDefined(_id_4506006A3631A139))
      players = [[_id_4506006A3631A139]]();

    foreach(player in scripts\engine\utility::_id_53C4C53197386572(players, level.players)) {
      if(_id_816A81935C705C98(player, _id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, _id_59F02C6C6C928ED3))
        return player;
    }

    waitframe();
  }
}

_id_7677B20356982F00(_id_12B397CBEAAB23B6, origin2, _id_59F02C6C6C928ED3, players) {
  if(isDefined(players) && !isarray(players))
    players = [players];

  _id_878914B0358BC7B5 = [];

  foreach(player in scripts\engine\utility::_id_53C4C53197386572(players, level.players)) {
    if(_id_816A81935C705C98(player, max(_id_12B397CBEAAB23B6[0], origin2[0]), min(_id_12B397CBEAAB23B6[0], origin2[0]), max(_id_12B397CBEAAB23B6[1], origin2[1]), min(_id_12B397CBEAAB23B6[1], origin2[1]), max(_id_12B397CBEAAB23B6[2], origin2[2]), min(_id_12B397CBEAAB23B6[2], origin2[2]), _id_59F02C6C6C928ED3))
      _id_878914B0358BC7B5[_id_878914B0358BC7B5.size] = player;
  }

  return _id_878914B0358BC7B5;
}

_id_513E47CE46DBF91F(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, _id_59F02C6C6C928ED3, players) {
  if(isDefined(players) && !isarray(players))
    players = [players];

  foreach(player in scripts\engine\utility::_id_53C4C53197386572(players, level.players)) {
    if(!_id_816A81935C705C98(player, _id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, _id_59F02C6C6C928ED3))
      return player;
  }
}

_id_EF2011A8C2920E8C(_id_12B397CBEAAB23B6, origin2, _id_59F02C6C6C928ED3, players, timeout) {
  return _id_A2E15CA9CC1E141F(max(_id_12B397CBEAAB23B6[0], origin2[0]), min(_id_12B397CBEAAB23B6[0], origin2[0]), max(_id_12B397CBEAAB23B6[1], origin2[1]), min(_id_12B397CBEAAB23B6[1], origin2[1]), max(_id_12B397CBEAAB23B6[2], origin2[2]), min(_id_12B397CBEAAB23B6[2], origin2[2]), _id_59F02C6C6C928ED3, players, timeout);
}

_id_A2E15CA9CC1E141F(_id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, _id_59F02C6C6C928ED3, players, timeout, _id_6396F940DACCA980) {
  if(isDefined(players) && !isarray(players))
    players = [players];

  for(time = 0; !isDefined(timeout) || time < timeout; time = time + 0.05) {
    count = 0;

    foreach(player in scripts\engine\utility::_id_53C4C53197386572(players, level.players)) {
      if(_id_816A81935C705C98(player, _id_3D9B4679B8D7E8FA, _id_4C69B2E8A053C33F, _id_3D9B4779B8D7EB2D, _id_4C69B1E8A053C10C, _id_3D9B4479B8D7E494, _id_4C69B4E8A053C7A5, _id_59F02C6C6C928ED3)) {
        count++;
        continue;
      }

      if(isDefined(_id_6396F940DACCA980) && istrue([[_id_6396F940DACCA980]](player)))
        count++;
    }

    if(count == scripts\engine\utility::_id_53C4C53197386572(players, level.players).size) {
      return;
    }
    waitframe();
  }
}

_id_3B46C8D1F1AE39D3(_id_47CC057E8A7B1FBE, value, players, timeout) {
  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    foreach(player in scripts\engine\utility::_id_53C4C53197386572(players, level.players)) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(player.origin[_id_47CC057E8A7B1FBE] < value)
        return player;
    }

    waitframe();
  }
}

_id_45831CF64D17BBB1(point, angles, players, timeout) {
  if(!isvector(angles))
    angles = (0, angles, 0);

  forward = anglesToForward(angles);

  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    foreach(player in scripts\engine\utility::_id_53C4C53197386572(players, level.players)) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(vectordot(player.origin - point, forward) > 0)
        return player;
    }

    waitframe();
  }
}

_id_7D64050A05D6F77E(point, angles, players, timeout) {
  if(!isvector(angles))
    angles = (0, angles, 0);

  forward = anglesToForward(angles);

  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    count = 0;

    foreach(player in scripts\engine\utility::_id_53C4C53197386572(players, level.players)) {
      if(!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(vectordot(player.origin - point, forward) > 0)
        count++;
    }

    if(count == players.size) {
      return;
    }
    waitframe();
  }
}

_id_A0580E9BD081384B(targets) {
  for(;;) {
    level waittill("player_pinged_enemy", player, target);

    if(!isDefined(targets) || scripts\engine\utility::array_contains(targets, target))
      return [player, target];
  }
}

_id_936A98F2467DD886(delay, msg) {
  for(result = _id_DA4598E93AD716FA(delay, msg); !istrue(result); result = _id_DA4598E93AD716FA(delay, msg)) {}
}

_id_DA4598E93AD716FA(delay, msg) {
  self endon(msg);
  _id_5D265B4FCA61F070::_id_B0FDDB86A2358953(delay);
  return 1;
}

_id_2428384AF851217A(targets) {
  for(;;) {
    level waittill("player_pinged_object", player, target);

    if(scripts\engine\utility::array_contains(targets, target))
      return [player, target];
  }
}

_id_57E617784FB02909(_id_190F3D33FC4339C9, _id_84B53811EF90E138, dot, holdtime, _id_E2073531FA9C0C72, _id_94564218DD6125B9, maxdist, offset, timeout) {
  target = [_id_190F3D33FC4339C9, _id_84B53811EF90E138];
  result = _id_F3C414CE5CCAB845([target], dot, holdtime, _id_E2073531FA9C0C72, _id_94564218DD6125B9, maxdist, offset, timeout);

  if(isDefined(result))
    return result[0];
}

_id_F3C414CE5CCAB845(targets, dot, holdtime, _id_E2073531FA9C0C72, _id_94564218DD6125B9, maxdist, offset, timeout) {
  return _id_5BC7A5C4437D3803(targets, dot, holdtime, _id_E2073531FA9C0C72, _id_94564218DD6125B9, maxdist, offset, timeout, 1);
}

_id_5BC7A5C4437D3803(targets, dot, holdtime, _id_E2073531FA9C0C72, _id_94564218DD6125B9, maxdist, offset, timeout, _id_CBE3524D314A7BD3, _id_12FD56460A1C9F2D) {
  dot = scripts\engine\utility::_id_53C4C53197386572(dot, 0.9995);
  _id_E2073531FA9C0C72 = scripts\engine\utility::_id_53C4C53197386572(_id_E2073531FA9C0C72, 0);
  holdtime = scripts\engine\utility::_id_53C4C53197386572(holdtime, 0.05);

  if(isPlayer(_id_94564218DD6125B9))
    _id_94564218DD6125B9 = [_id_94564218DD6125B9];

  if(isDefined(_id_94564218DD6125B9))
    _id_94564218DD6125B9 = scripts\engine\utility::array_removeundefined(_id_94564218DD6125B9);

  _id_C20F037704A34DEA = [];
  _id_CDC5DD6C28C9709D = undefined;

  if(isDefined(maxdist))
    _id_CDC5DD6C28C9709D = squared(maxdist);

  for(time = 0; !isDefined(timeout) || time < timeout; time = time + 0.05) {
    foreach(_id_EF50426720E1DBB8, player in level.players) {
      if(!isalive(player)) {
        continue;
      }
      if(_id_E2073531FA9C0C72 && player playerads() < 0.5) {
        continue;
      }
      if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
        continue;
      }
      target = player _id_826A16F43A8E949B(targets, dot, offset, _id_CDC5DD6C28C9709D, _id_CBE3524D314A7BD3, _id_12FD56460A1C9F2D);

      if(!isDefined(target)) {
        _id_C20F037704A34DEA[_id_EF50426720E1DBB8] = undefined;
        continue;
      }

      if(!isDefined(_id_C20F037704A34DEA[_id_EF50426720E1DBB8]))
        _id_C20F037704A34DEA[_id_EF50426720E1DBB8] = 0;

      _id_C20F037704A34DEA[_id_EF50426720E1DBB8] = _id_C20F037704A34DEA[_id_EF50426720E1DBB8] + 0.05;

      if(_id_C20F037704A34DEA[_id_EF50426720E1DBB8] > holdtime)
        return [player, target];
    }

    waitframe();
  }
}

_id_826A16F43A8E949B(targets, dot, offset, _id_CDC5DD6C28C9709D, _id_CBE3524D314A7BD3, _id_12FD56460A1C9F2D) {
  if(isfunction(targets) || isbuiltinfunction(targets) || isbuiltinmethod(targets))
    targets = _id_5D265B4FCA61F070::call_with_params(targets);

  if(!isarray(targets))
    targets = [targets];

  _id_5DDB2B9E6961D6C8 = scripts\engine\utility::ter_op(istrue(_id_CBE3524D314A7BD3), ::distance2dsquared, ::distancesquared);

  foreach(target in targets) {
    if(!isDefined(target)) {
      continue;
    }
    if(isai(target)) {
      if(!isalive(target)) {
        continue;
      }
      origin = target.origin + (0, 0, 50);

      if(isDefined(offset))
        origin = _func_4AD9053267734CF2(offset, target.origin, target.angles);
    } else if(isent(target) || isstruct(target)) {
      origin = target.origin;

      if(isDefined(offset))
        origin = _func_4AD9053267734CF2(offset, target.origin, target.angles);
    } else if(isarray(target)) {
      origin = _id_CC896E1DD7777E90(target[0], target[1]);

      if(isDefined(offset))
        origin = origin + offset;
    } else {
      origin = target;

      if(isDefined(offset))
        origin = origin + offset;
    }

    if(isDefined(_id_CDC5DD6C28C9709D) && call[[_id_5DDB2B9E6961D6C8]](self.origin, origin) > _id_CDC5DD6C28C9709D) {
      continue;
    }
    if(_id_616C3C283F990DC4(origin, dot, _id_12FD56460A1C9F2D))
      return target;
  }
}

_id_616C3C283F990DC4(start, dot, _id_95BFA6EAF973D593, _id_75BEA58D65510615) {
  if(!isDefined(dot))
    dot = 0.8;

  player = scripts\cp\utility::get_player_from_self();
  end = player getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  _id_DEE6508B0BA437C5 = player getplayerangles();
  _id_70222FBC47330166 = anglesToForward(_id_DEE6508B0BA437C5);
  _id_334AF980E8C1A3AD = vectordot(forward, _id_70222FBC47330166);

  if(_id_334AF980E8C1A3AD < dot)
    return 0;

  if(istrue(_id_95BFA6EAF973D593))
    return 1;

  return scripts\engine\trace::ray_trace_passed(start, end, _id_75BEA58D65510615, scripts\engine\trace::create_default_contents(1));
}

_id_CC896E1DD7777E90(_id_190F3D33FC4339C9, _id_84B53811EF90E138) {
  p1 = self getEye();
  _id_CDE77078F534191C = _id_190F3D33FC4339C9 - p1;
  _id_CDE77378F5341FB5 = _id_84B53811EF90E138 - p1;
  _id_CDE77278F5341D82 = _id_84B53811EF90E138 - _id_190F3D33FC4339C9;
  _id_2620446B9F4A03F1 = scripts\engine\math::anglebetweenvectors(_id_CDE77078F534191C, _id_CDE77378F5341FB5);
  _id_775361D05A790917 = vectorNormalize(vectorcross(_id_CDE77078F534191C, _id_CDE77378F5341FB5));
  forward = anglesToForward(self getplayerangles(0));
  _id_A6C6221A1040F454 = scripts\engine\math::vector_project_onto_plane(forward, _id_775361D05A790917);
  _id_46C6F0F7ACCF64B0 = scripts\engine\math::anglebetweenvectorssigned(_id_CDE77078F534191C, _id_A6C6221A1040F454, _id_775361D05A790917);
  _id_9CC715FDA568A3F7 = asin(clamp(_id_46C6F0F7ACCF64B0 / _id_2620446B9F4A03F1 * 0.5, 0, 1)) / 30;
  origin = p1 + forward * 100;

  if(_id_9CC715FDA568A3F7 < 0)
    return _id_190F3D33FC4339C9;
  else if(_id_9CC715FDA568A3F7 > 1)
    return _id_84B53811EF90E138;
  else
    return _id_190F3D33FC4339C9 + (_id_84B53811EF90E138 - _id_190F3D33FC4339C9) * _id_9CC715FDA568A3F7;
}

_id_71FC89B3E8140B4B(targets, dist, _id_94564218DD6125B9, _id_CBE3524D314A7BD3) {
  dist = squared(dist);
  _id_5DDB2B9E6961D6C8 = scripts\engine\utility::ter_op(istrue(_id_CBE3524D314A7BD3), ::distance2dsquared, ::distancesquared);

  if(!isarray(targets))
    targets = [targets];

  if(isDefined(_id_94564218DD6125B9) && !isarray(_id_94564218DD6125B9))
    _id_94564218DD6125B9 = [_id_94564218DD6125B9];

  for(;;) {
    foreach(target in targets) {
      if(isent(target)) {
        if(!isalive(target)) {
          continue;
        }
        target = target.origin;
      }

      foreach(player in level.players) {
        if(!isalive(player)) {
          continue;
        }
        if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
          continue;
        }
        if(call[[_id_5DDB2B9E6961D6C8]](player.origin, target) < dist)
          return [player, target];
      }
    }

    waitframe();
  }
}

_id_ADD4AC211AB1D84D(targets, dist, _id_94564218DD6125B9) {
  return _id_71FC89B3E8140B4B(targets, dist, _id_94564218DD6125B9, 1);
}

_id_D38E56EFB3AF96B1(targets, dist, _id_94564218DD6125B9, _id_CBE3524D314A7BD3) {
  dist = squared(dist);
  _id_5DDB2B9E6961D6C8 = scripts\engine\utility::ter_op(istrue(_id_CBE3524D314A7BD3), ::distance2dsquared, ::distancesquared);

  if(!isarray(targets))
    targets = [targets];

  if(!isDefined(_id_94564218DD6125B9))
    _id_223D9A20A9F7B212 = 0;
  else
    _id_223D9A20A9F7B212 = _id_94564218DD6125B9.size;

  for(;;) {
    foreach(target in targets) {
      count = 0;

      if(isent(target)) {
        if(!isalive(target)) {
          continue;
        }
        target = target.origin;
      }

      foreach(player in level.players) {
        if(!isalive(player)) {
          continue;
        }
        if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
          continue;
        }
        if(call[[_id_5DDB2B9E6961D6C8]](player.origin, target) < dist)
          count++;
      }

      if(count >= level.players.size - _id_223D9A20A9F7B212)
        return target;
    }

    waitframe();
  }
}

_id_E3C59645C8720E83(targets, dist, _id_94564218DD6125B9, timeout) {
  dist = squared(dist);
  _id_6B7BEE46F2C6DA28 = gettime();

  while(!scripts\engine\utility::time_has_passed(_id_6B7BEE46F2C6DA28, timeout)) {
    foreach(target in targets) {
      if(isent(target)) {
        if(!isalive(target)) {
          continue;
        }
        target = target.origin;
      }

      foreach(player in level.players) {
        if(!isalive(player)) {
          continue;
        }
        if(isDefined(_id_94564218DD6125B9) && scripts\engine\utility::array_contains(_id_94564218DD6125B9, player)) {
          continue;
        }
        if(distance2dsquared(player.origin, target) < dist)
          return 1;
      }
    }

    waitframe();
  }

  return 0;
}

_id_9A835763C929EB24(player, timeout) {
  for(time = 0; !isDefined(timeout) || time <= timeout; time = time + 0.05) {
    if(!player _meth_6F55D55CCFF20D14())
      return player;

    waitframe();
  }
}

_id_8935EE5F55A88C21(targets) {
  while(!_id_6BE2684644F905AC(targets))
    scripts\engine\utility::waittill_any_ents_array(targets, "death", "long_death");
}

_id_6BE2684644F905AC(targets) {
  foreach(target in targets) {
    if(!scripts\engine\utility::is_dead_or_dying(target))
      return 0;
  }

  return 1;
}

_id_9D4A0C8FC2BAD53C() {}

_id_3A3EB3191AFB7ADE(player) {
  return !getdvarint("dvar_9537FE5BFE3E75A8", 0);
}

_id_B323307D80158D91() {
  _id_B95172907AEA2343 = [];

  foreach(player in level.players) {
    if(istestclient(player))
      _id_B95172907AEA2343[_id_B95172907AEA2343.size] = player;
  }

  return _id_B95172907AEA2343;
}

_id_E4771A9070C06BF1() {
  for(;;) {
    if(!isalive(self) || self isspectatingplayer()) {} else {
      self allowfire(0);
      self allowmovement(0);
    }

    waitframe();
  }
}

_id_35BB5E8D7CE9218E() {
  for(;;) {
    foreach(_id_A6F95CA63982EAC2 in _id_B323307D80158D91()) {
      while(!isalive(level.player) || !level.player buttonPressed("DPAD_RIGHT") && !level.player buttonPressed("4"))
        waitframe();

      start = level.player getEye();
      end = start + anglesToForward(level.player getplayerangles(0)) * 1000;
      results = scripts\engine\trace::ray_trace(start, end, level.player);

      if(!isalive(_id_A6F95CA63982EAC2) || _id_A6F95CA63982EAC2 isspectatingplayer()) {
        continue;
      }
      _id_A6F95CA63982EAC2 setplayerangles(level.player.angles);
      _id_A6F95CA63982EAC2 setOrigin(results["position"]);

      while(!isalive(level.player) || (level.player buttonPressed("DPAD_RIGHT") || level.player buttonPressed("4")))
        waitframe();
    }

    waitframe();
  }
}

_id_ED9BF82AD9A067BE() {
  self allowfire(0);
  self allowmovement(0);

  for(;;) {
    if(!isalive(self) || self isspectatingplayer()) {} else if(distance(self.origin, level.player.origin) < 500) {} else {
      self allowfire(0);
      self allowmovement(0);
      self setplayerangles(level.player.angles);
      self setOrigin(level.player.origin - anglesToForward(level.player getplayerangles(1)) * 225);
    }

    waitframe();
  }
}

_id_7C50C629B4D4086A(_id_41D8BF229CF29051, _id_F629D50C412F2EFA) {
  _id_41D8BF229CF29051 = scripts\engine\utility::_id_53C4C53197386572(_id_41D8BF229CF29051, 1);
  _id_F629D50C412F2EFA = scripts\engine\utility::_id_53C4C53197386572(_id_F629D50C412F2EFA, "default");
  level._id_2EAFAD246F718756 = scripts\engine\utility::_id_53C4C53197386572(level._id_2EAFAD246F718756, []);
  level._id_2EAFAD246F718756[_id_F629D50C412F2EFA] = _id_41D8BF229CF29051;
  _id_41D8BF229CF29051 = 0;

  foreach(_id_92E4DA462F736A2F in level._id_2EAFAD246F718756) {
    if(_id_92E4DA462F736A2F) {
      _id_41D8BF229CF29051 = 1;
      break;
    }
  }

  level._id_5D4C8322D01B9C50 = _id_41D8BF229CF29051;

  if(_id_41D8BF229CF29051 == 1)
    scripts\cp\cp_player_battlechatter::togglecpplayerbc(0);
  else
    scripts\cp\cp_player_battlechatter::togglecpplayerbc(1);
}

_id_B8AE7D3FFA2CE9D8(alias) {
  self._id_EEF929505A9B77B9++;
}

_id_5175593A7A2CCDB5() {
  scripts\engine\utility::flag_init("vo_combat");

  for(;;) {
    scripts\engine\utility::flag_clear("vo_combat");
    _id_7C50C629B4D4086A(1, "combat");

    while(!_id_73709F2B96C09080(undefined, 1))
      waitframe();

    scripts\engine\utility::flag_set("vo_combat");
    _id_7C50C629B4D4086A(0, "combat");

    while(_id_73709F2B96C09080(undefined, 1))
      waitframe();
  }
}

_id_FC711A4308F52F72() {
  scripts\engine\utility::flag_init("vo_strict_combat");

  for(;;) {
    scripts\engine\utility::flag_clear("vo_strict_combat");

    while(!_id_73709F2B96C09080(undefined, 0))
      waitframe();

    scripts\engine\utility::flag_set("vo_strict_combat");

    while(_id_73709F2B96C09080(undefined, 0))
      waitframe();
  }
}