/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bounty_system.gsc
***********************************************/

init() {
  if(!_id_217E5C3B8A4CA539()) {
    return;
  }
  level._id_A2A63A71BCA53EA8 = getdvarint("dvar_7074068242015A8A", 2000);
  level._id_D4E0758BCDDAA616 = getdvarint("dvar_42C837F8D33C4CD5", 10);
  level._id_C18A1304B5BAC209 = getdvarint("dvar_B3270A4D9D7C32D1", 0);

  if(_id_3FF084F114B7F6C9::_id_6934349B7823D888())
    _id_3FF084F114B7F6C9::_id_F3D757808130BAC4(::_id_3CD64058B039543D);
}

_id_217E5C3B8A4CA539() {
  if(!isDefined(level._id_7481C0699A7C035C))
    level._id_FE9DBC325D2D5E3F = getdvarint("dvar_702AF82BFBFD306A", 1);

  return level._id_FE9DBC325D2D5E3F;
}

_id_4647CBF23F54D6F6(player, _id_0424DD60EF6B968C) {
  player._id_29C1A6FD6998CB44 = 1;
  _id_CC75E0B74EE84D57 = _id_563873982A6BC459(player, _id_0424DD60EF6B968C);
  _id_20F2949FD51737DD = _id_055731D4969878EF(player);

  if(isDefined(_id_20F2949FD51737DD)) {
    if(_id_20F2949FD51737DD.priority >= _id_CC75E0B74EE84D57.priority) {
      player._id_0E2C78227FB084C4[player._id_0E2C78227FB084C4.size] = _id_CC75E0B74EE84D57;
      player._id_0E2C78227FB084C4 = scripts\engine\utility::array_removeundefined(player._id_0E2C78227FB084C4);

      if(player._id_0E2C78227FB084C4.size > 1)
        player._id_0E2C78227FB084C4 = scripts\engine\utility::array_sort_with_func(player._id_0E2C78227FB084C4, ::_id_CC061DFAB17DD15B);

      level thread _id_38FBD8F15EDE0C59(_id_CC75E0B74EE84D57);
      level thread _id_D718B6FF11577E22(_id_CC75E0B74EE84D57);
      level thread[[_id_CC75E0B74EE84D57._id_7073A47DB2F80848]](_id_CC75E0B74EE84D57);
      return _id_CC75E0B74EE84D57;
    } else {
      _id_20F2949FD51737DD notify("hide_bounty");
      _id_20F2949FD51737DD notify("moniter_bounty_prox");
    }
  }

  if(_id_CC75E0B74EE84D57._id_D66266E27481ACE9 == 2 || _id_CC75E0B74EE84D57._id_40CA706DA5962314 == 2)
    _id_CC75E0B74EE84D57.headicon = addheadicon(player, _id_CC75E0B74EE84D57);

  if(_id_CC75E0B74EE84D57._id_D66266E27481ACE9 == 1 || _id_CC75E0B74EE84D57._id_40CA706DA5962314 == 1)
    _id_CC75E0B74EE84D57._id_43873940161B7F28 = _id_48DA443B1B3FC62F(player, _id_CC75E0B74EE84D57);

  if(!isDefined(_id_CC75E0B74EE84D57._id_43873940161B7F28) && !isDefined(_id_CC75E0B74EE84D57.headicon)) {
    return;
  }
  if(!isDefined(player._id_0E2C78227FB084C4))
    player._id_0E2C78227FB084C4 = [];

  player._id_0E2C78227FB084C4[player._id_0E2C78227FB084C4.size] = _id_CC75E0B74EE84D57;
  player._id_0E2C78227FB084C4 = scripts\engine\utility::array_removeundefined(player._id_0E2C78227FB084C4);

  if(player._id_0E2C78227FB084C4.size > 1)
    player._id_0E2C78227FB084C4 = scripts\engine\utility::array_sort_with_func(player._id_0E2C78227FB084C4, ::_id_CC061DFAB17DD15B);

  level thread _id_38FBD8F15EDE0C59(_id_CC75E0B74EE84D57);
  level thread _id_D718B6FF11577E22(_id_CC75E0B74EE84D57);
  level thread[[_id_CC75E0B74EE84D57._id_7073A47DB2F80848]](_id_CC75E0B74EE84D57);
  level thread[[_id_CC75E0B74EE84D57._id_9148147953F797E2]](_id_CC75E0B74EE84D57);
  return _id_CC75E0B74EE84D57;
}

_id_A10C4276271C4AD7(_id_CC75E0B74EE84D57, success, context) {
  _id_CC75E0B74EE84D57.success = istrue(success);
  _id_CC75E0B74EE84D57.context = context;
  [[_id_CC75E0B74EE84D57._id_88C5361DB8DBCEAC]](_id_CC75E0B74EE84D57);

  if(isDefined(_id_CC75E0B74EE84D57.player)) {
    if(_id_CC75E0B74EE84D57.player._id_5D4EFADA59C61B13.size > 0) {
      foreach(player in _id_CC75E0B74EE84D57.player._id_5D4EFADA59C61B13)
      _id_CC75E0B74EE84D57.player _id_39FC3F494DFD7847(_id_CC75E0B74EE84D57, player);
    }

    _id_B57EFDE15223F363 = undefined;

    foreach(index, _id_DC401F458E995072 in _id_CC75E0B74EE84D57.player._id_0E2C78227FB084C4) {
      _id_B57EFDE15223F363 = index;
      break;
    }

    _id_CC75E0B74EE84D57.player._id_0E2C78227FB084C4[_id_B57EFDE15223F363] = undefined;
    _id_CC75E0B74EE84D57.player._id_0E2C78227FB084C4 = scripts\engine\utility::array_removeundefined(_id_CC75E0B74EE84D57.player._id_0E2C78227FB084C4);
    _id_CC75E0B74EE84D57.player._id_29C1A6FD6998CB44 = _id_CC75E0B74EE84D57.player._id_0E2C78227FB084C4.size > 0;
    _id_C5BD28487BD61E1F(_id_CC75E0B74EE84D57.player);
  }

  _id_CC75E0B74EE84D57 notify("bounty_end");
}

_id_055731D4969878EF(player) {
  if(!_id_BC09557189D65E55(player))
    return undefined;

  if(!isDefined(player._id_0E2C78227FB084C4))
    return undefined;

  _id_42B1385D8FF43C70 = scripts\engine\utility::array_get_first_item(player._id_0E2C78227FB084C4);
  return _id_42B1385D8FF43C70;
}

_id_BC09557189D65E55(player) {
  return istrue(player._id_29C1A6FD6998CB44);
}

_id_0D34EA2B5E8F5D93(team) {
  if(!_id_57736963A928DB85(team))
    return [];

  _id_06F1F92BF14B2443 = [];
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(_id_BC09557189D65E55(player))
      _id_06F1F92BF14B2443[_id_06F1F92BF14B2443.size] = _id_055731D4969878EF(player);
  }

  return _id_06F1F92BF14B2443;
}

_id_57736963A928DB85(team) {
  if(!isDefined(team))
    return 0;

  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(istrue(player._id_29C1A6FD6998CB44))
      return 1;
  }

  return 0;
}

_id_C5BD28487BD61E1F(player) {
  if(!isDefined(player._id_0E2C78227FB084C4)) {
    return;
  }
  if(player._id_0E2C78227FB084C4.size <= 0) {
    return;
  }
  player._id_0E2C78227FB084C4 = scripts\engine\utility::array_removeundefined(player._id_0E2C78227FB084C4);
  player._id_0E2C78227FB084C4 = scripts\engine\utility::array_sort_with_func(player._id_0E2C78227FB084C4, ::_id_CC061DFAB17DD15B);
  _id_CC75E0B74EE84D57 = scripts\engine\utility::array_get_first_item(player._id_0E2C78227FB084C4);

  if(_id_CC75E0B74EE84D57._id_D66266E27481ACE9 == 2 || _id_CC75E0B74EE84D57._id_40CA706DA5962314 == 2)
    _id_CC75E0B74EE84D57.headicon = addheadicon(player, _id_CC75E0B74EE84D57);

  if(_id_CC75E0B74EE84D57._id_D66266E27481ACE9 == 1 || _id_CC75E0B74EE84D57._id_40CA706DA5962314 == 1)
    _id_CC75E0B74EE84D57._id_43873940161B7F28 = _id_48DA443B1B3FC62F(player, _id_CC75E0B74EE84D57);

  level thread _id_38FBD8F15EDE0C59(_id_CC75E0B74EE84D57);
}

_id_CC061DFAB17DD15B(left, right) {
  return left.priority >= right.priority;
}

addheadicon(player, _id_CC75E0B74EE84D57) {
  _id_49766086665362B9 = _id_3AD2024FAFE07C36(player, _id_CC75E0B74EE84D57, 2);
  _id_2A980FF198001875 = _id_CC75E0B74EE84D57._id_A0C9C946B5C00006 > 0;

  if(_id_2A980FF198001875)
    _id_CC75E0B74EE84D57._id_7591ED99E87A77D3 = player.origin;

  headicon = player scripts\cp_mp\entityheadicons::setheadicon_multiimage(_id_49766086665362B9, _id_CC75E0B74EE84D57._id_652D26F30484AFE1, _id_CC75E0B74EE84D57._id_652D26F30484AFE1, _id_CC75E0B74EE84D57._id_55E8F77E34BAA3C2, undefined, 1, _id_CC75E0B74EE84D57._id_C5409CA7522182B3, _id_CC75E0B74EE84D57._id_30516B4AFD1763DE, undefined, 1, _id_CC75E0B74EE84D57._id_B3EA37733A1577E5, _id_CC75E0B74EE84D57._id_7591ED99E87A77D3, _id_CC75E0B74EE84D57.showonminimap);
  setheadiconteam(headicon, player.team);
  _func_CE9D0299637C2C24(headicon, 1);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, player);

  if(_id_2A980FF198001875)
    level thread _id_82C32D2CB649E5E3(_id_CC75E0B74EE84D57, _id_49766086665362B9, headicon);

  return headicon;
}

_id_82C32D2CB649E5E3(_id_CC75E0B74EE84D57, _id_49766086665362B9, headicon) {
  level endon("game_ended");
  _id_CC75E0B74EE84D57 endon("bounty_end");
  player = _id_CC75E0B74EE84D57.player;
  _id_48A78BEE31DAA649 = _id_CC75E0B74EE84D57._id_A0C9C946B5C00006;

  for(;;) {
    wait(_id_48A78BEE31DAA649);
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(headicon);
    _id_A9706ADAF7C52E27 = player.origin;
    headicon = player scripts\cp_mp\entityheadicons::setheadicon_multiimage(_id_49766086665362B9, _id_CC75E0B74EE84D57._id_652D26F30484AFE1, _id_CC75E0B74EE84D57._id_652D26F30484AFE1, _id_CC75E0B74EE84D57._id_55E8F77E34BAA3C2, undefined, 1, _id_CC75E0B74EE84D57._id_C5409CA7522182B3, _id_CC75E0B74EE84D57._id_30516B4AFD1763DE, undefined, 1, _id_CC75E0B74EE84D57._id_B3EA37733A1577E5, _id_A9706ADAF7C52E27, _id_CC75E0B74EE84D57.showonminimap);
    setheadiconteam(headicon, player.team);
    _func_CE9D0299637C2C24(headicon, 1);
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, player);
  }
}

_id_48DA443B1B3FC62F(player, _id_CC75E0B74EE84D57) {
  _id_43873940161B7F28 = _id_ECB8C86061989935(player.origin, _id_CC75E0B74EE84D57);
  _id_43873940161B7F28.player = player;
  _id_43873940161B7F28 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_CC75E0B74EE84D57._id_E6F187BCB4B1648E, _id_1E42C880AD18489E(_id_43873940161B7F28.player.origin, _id_CC75E0B74EE84D57.circleradius), _id_CC75E0B74EE84D57.circleradius, player);
  _id_43873940161B7F28 scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();

  foreach(_id_6EE5484560EC747C in level.players) {
    if(_id_6EE5484560EC747C == player) {
      continue;
    }
    if(_id_6EE5484560EC747C.team == player.team && _id_CC75E0B74EE84D57._id_D66266E27481ACE9 == 1) {
      _id_43873940161B7F28 scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(_id_6EE5484560EC747C);
      continue;
    }

    if(_id_6EE5484560EC747C.team != player.team && _id_CC75E0B74EE84D57._id_40CA706DA5962314 == 1)
      _id_43873940161B7F28 scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(_id_6EE5484560EC747C);
  }

  _id_43873940161B7F28 scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
  _id_43873940161B7F28 notify("stop_tracking");
  level thread _id_DFE0992113030BD0(_id_43873940161B7F28, _id_CC75E0B74EE84D57);
  return _id_43873940161B7F28;
}

_id_563873982A6BC459(player, _id_0424DD60EF6B968C) {
  if(!isDefined(_id_0424DD60EF6B968C))
    _id_0424DD60EF6B968C = spawnStruct();

  _id_CC75E0B74EE84D57 = spawnStruct();
  _id_CC75E0B74EE84D57.player = player;
  _id_CC75E0B74EE84D57.priority = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C.priority, 0);
  _id_CC75E0B74EE84D57._id_D66266E27481ACE9 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_D66266E27481ACE9, 2);
  _id_CC75E0B74EE84D57._id_40CA706DA5962314 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_40CA706DA5962314, 1);
  _id_CC75E0B74EE84D57._id_CFCFFC70799935EE = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_CFCFFC70799935EE, 0);
  _id_CC75E0B74EE84D57._id_E6F187BCB4B1648E = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_E6F187BCB4B1648E, "Hostage_Dmz");
  _id_CC75E0B74EE84D57._id_D77771D6BFB89518 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_D77771D6BFB89518, "icon_skull_large");
  _id_CC75E0B74EE84D57.circleradius = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C.circleradius, level._id_A2A63A71BCA53EA8);
  _id_CC75E0B74EE84D57._id_212406C9408B2D05 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_212406C9408B2D05, level._id_D4E0758BCDDAA616);
  _id_CC75E0B74EE84D57._id_C5409CA7522182B3 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_C5409CA7522182B3, 0);
  _id_CC75E0B74EE84D57._id_30516B4AFD1763DE = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_30516B4AFD1763DE, 500);
  _id_CC75E0B74EE84D57._id_B3EA37733A1577E5 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_B3EA37733A1577E5, 0);
  _id_CC75E0B74EE84D57._id_7591ED99E87A77D3 = _id_0424DD60EF6B968C._id_7591ED99E87A77D3;
  _id_CC75E0B74EE84D57.showonminimap = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C.showonminimap, 1);
  _id_CC75E0B74EE84D57._id_55E8F77E34BAA3C2 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_55E8F77E34BAA3C2, "hud_icon_new_marked");
  _id_CC75E0B74EE84D57._id_652D26F30484AFE1 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_652D26F30484AFE1, "hud_icon_new_marked");
  _id_CC75E0B74EE84D57._id_A0C9C946B5C00006 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_A0C9C946B5C00006, level._id_C18A1304B5BAC209);
  _id_CC75E0B74EE84D57._id_9148147953F797E2 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_9148147953F797E2, ::_id_9A0CB7B36CF2F5A3);
  _id_CC75E0B74EE84D57._id_9FCCD0C71039EFF7 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_9FCCD0C71039EFF7, ::_id_D13D0F1FA5D13556);
  _id_CC75E0B74EE84D57._id_981FDA4F385C05D5 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_981FDA4F385C05D5, ::_id_ACD85BE28950F9F8);
  _id_CC75E0B74EE84D57._id_88C5361DB8DBCEAC = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_88C5361DB8DBCEAC, ::_id_612C88CB58973B43);
  _id_CC75E0B74EE84D57._id_7073A47DB2F80848 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_7073A47DB2F80848, ::_id_6588E43FDFBDD2AD);
  _id_CC75E0B74EE84D57._id_1E7FE7292618D1C5 = scripts\engine\utility::_id_53C4C53197386572(_id_0424DD60EF6B968C._id_1E7FE7292618D1C5, 0);
  return _id_CC75E0B74EE84D57;
}

_id_ECB8C86061989935(origin, _id_CC75E0B74EE84D57) {
  _id_43873940161B7F28 = spawnStruct();
  _id_43873940161B7F28.curorigin = origin;
  _id_43873940161B7F28.offset3d = (0, 0, 100);
  _id_43873940161B7F28 scripts\mp\gameobjects::requestid(1, _id_CC75E0B74EE84D57._id_CFCFFC70799935EE, undefined, 1, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(_id_43873940161B7F28.objidnum, _id_CC75E0B74EE84D57._id_D77771D6BFB89518);
  scripts\mp\objidpoolmanager::update_objective_setbackground(_id_43873940161B7F28.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(_id_43873940161B7F28.objidnum, 100);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(_id_43873940161B7F28.objidnum, _id_CC75E0B74EE84D57.player.team);
  scripts\mp\objidpoolmanager::_id_9CAD42AC02EFF950(_id_43873940161B7F28.objidnum);
  _id_72B01890612DDD21 = _id_3AD2024FAFE07C36(_id_CC75E0B74EE84D57.player, _id_CC75E0B74EE84D57, 1);

  foreach(team in _id_72B01890612DDD21)
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(_id_43873940161B7F28.objidnum, team);

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(_id_43873940161B7F28.objidnum, _id_CC75E0B74EE84D57.player);
  return _id_43873940161B7F28;
}

_id_1E42C880AD18489E(origin, radius) {
  point = scripts\engine\utility::_id_D553466CF817A4DA();
  point = (point[0] * radius, point[1] * radius, 0);
  return point + origin;
}

_id_3AA3F81E3A787E9F(_id_43873940161B7F28, player, _id_CC75E0B74EE84D57) {
  origin = _id_1E42C880AD18489E(player.origin, _id_CC75E0B74EE84D57.circleradius);
  origin = origin + (0, 0, player.origin[2] + 750);
  scripts\mp\objidpoolmanager::update_objective_position(_id_43873940161B7F28.objidnum, origin);
  _id_43873940161B7F28 scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(origin);
}

_id_DFE0992113030BD0(_id_43873940161B7F28, _id_CC75E0B74EE84D57) {
  _id_43873940161B7F28 endon("stop_tracking");
  _id_43873940161B7F28.player endon("death_or_disconnect");
  _id_43873940161B7F28.player endon("enter_live_ragdoll");
  _id_CC75E0B74EE84D57 endon("bounty_end");
  level endon("game_ended");

  for(;;) {
    if(isDefined(_id_43873940161B7F28.player) && isDefined(_id_43873940161B7F28.player.origin))
      _id_3AA3F81E3A787E9F(_id_43873940161B7F28, _id_43873940161B7F28.player, _id_CC75E0B74EE84D57);

    if(_id_CC75E0B74EE84D57._id_212406C9408B2D05 <= 0) {
      waitframe();
      continue;
    }

    wait(_id_CC75E0B74EE84D57._id_212406C9408B2D05);
  }
}

_id_3AD2024FAFE07C36(player, _id_CC75E0B74EE84D57, _id_AE45669996E6FAA2) {
  _id_8BB1CAFDF95E6851 = _id_CC75E0B74EE84D57._id_D66266E27481ACE9 == _id_AE45669996E6FAA2;
  _id_B54422AD7B4E5C2C = _id_CC75E0B74EE84D57._id_40CA706DA5962314 == _id_AE45669996E6FAA2;
  _id_F5183C377B77EB83 = [];

  foreach(team in level.teamnamelist) {
    if(_id_8BB1CAFDF95E6851 && team == player.team)
      _id_F5183C377B77EB83[_id_F5183C377B77EB83.size] = team;

    if(_id_B54422AD7B4E5C2C && team != player.team)
      _id_F5183C377B77EB83[_id_F5183C377B77EB83.size] = team;
  }

  return _id_F5183C377B77EB83;
}

_id_9A0CB7B36CF2F5A3(_id_CC75E0B74EE84D57) {
  level endon("game_ended");
  _id_CC75E0B74EE84D57 endon("bounty_end");
  _id_CC75E0B74EE84D57 endon("moniter_bounty_prox");
  _id_656FB6126134BF11 = _id_CC75E0B74EE84D57.player;
  _id_B758EC776888DA7C = _id_CC75E0B74EE84D57.circleradius;
  _id_656FB6126134BF11._id_5D4EFADA59C61B13 = [];

  for(;;) {
    _id_3B87BF7A27309458 = _id_656FB6126134BF11.origin;

    if(_func_A794FCF9545F2062())
      _id_38F56723A5F07A13 = _func_B1EEF70090B5B7B5(_id_3B87BF7A27309458, _id_B758EC776888DA7C, _func_869CCB4E3451B8C6(["etype_player"]));
    else {
      _id_2B6807C7DF9A2B2D = scripts\engine\utility::_id_21A6A1C613B50A28(level.players, _id_B758EC776888DA7C);
      _id_38F56723A5F07A13 = _id_2B6807C7DF9A2B2D scripts\engine\utility::_id_0DF633F460888A47(_id_3B87BF7A27309458);
    }

    if(_id_38F56723A5F07A13.size > 0) {
      if(_id_656FB6126134BF11._id_5D4EFADA59C61B13.size > 0) {
        foreach(player in _id_656FB6126134BF11._id_5D4EFADA59C61B13) {
          if(!isDefined(player)) {
            continue;
          }
          if(!scripts\engine\utility::array_contains(_id_38F56723A5F07A13, player))
            _id_656FB6126134BF11 _id_39FC3F494DFD7847(_id_CC75E0B74EE84D57, player);
        }
      }

      foreach(player in _id_38F56723A5F07A13) {
        if(!isDefined(player)) {
          continue;
        }
        if(player == _id_656FB6126134BF11) {
          continue;
        }
        _id_656FB6126134BF11 _id_9F2D2403C5359FAF(_id_CC75E0B74EE84D57, player);
      }
    } else if(_id_656FB6126134BF11._id_5D4EFADA59C61B13.size > 0) {
      foreach(player in _id_656FB6126134BF11._id_5D4EFADA59C61B13)
      _id_656FB6126134BF11 _id_39FC3F494DFD7847(_id_CC75E0B74EE84D57, player);
    }

    wait 0.05;
  }
}

_id_9F2D2403C5359FAF(_id_CC75E0B74EE84D57, _id_C17CAED8C315B4A6) {
  if(scripts\engine\utility::array_contains(self._id_5D4EFADA59C61B13, _id_C17CAED8C315B4A6)) {
    return;
  }
  self[[_id_CC75E0B74EE84D57._id_9FCCD0C71039EFF7]](_id_CC75E0B74EE84D57, _id_C17CAED8C315B4A6);
  self._id_5D4EFADA59C61B13[self._id_5D4EFADA59C61B13.size] = _id_C17CAED8C315B4A6;
}

_id_D13D0F1FA5D13556(_id_CC75E0B74EE84D57, _id_C17CAED8C315B4A6) {}

_id_39FC3F494DFD7847(_id_CC75E0B74EE84D57, _id_81C4E06C9530F1CC) {
  self[[_id_CC75E0B74EE84D57._id_981FDA4F385C05D5]](_id_CC75E0B74EE84D57, _id_81C4E06C9530F1CC);
  self._id_5D4EFADA59C61B13 = scripts\engine\utility::array_remove(self._id_5D4EFADA59C61B13, _id_81C4E06C9530F1CC);
}

_id_ACD85BE28950F9F8(_id_CC75E0B74EE84D57, _id_81C4E06C9530F1CC) {}

_id_612C88CB58973B43(_id_CC75E0B74EE84D57) {}

_id_6588E43FDFBDD2AD(_id_CC75E0B74EE84D57) {
  level endon("game_ended");
  _id_CC75E0B74EE84D57 endon("bounty_end");
  _id_CC75E0B74EE84D57.player scripts\engine\utility::waittill_any_5("death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp");
  success = 0;

  if(!_id_CC75E0B74EE84D57.player scripts\cp_mp\utility\player_utility::_isalive()) {
    if(isDefined(_id_CC75E0B74EE84D57.player.lastkilledby) && isDefined(_id_CC75E0B74EE84D57.player.lastkilledby.team)) {
      _id_CC75E0B74EE84D57._id_4EEBF10183CB21F2 = _id_CC75E0B74EE84D57.player.lastkilledby.team;
      _id_CC75E0B74EE84D57._id_54920CBB1F92B9EA = _id_CC75E0B74EE84D57.player.lastkilledby;
      success = 1;
    }
  }

  context = scripts\engine\utility::ter_op(success, 2, 3);
  _id_A10C4276271C4AD7(_id_CC75E0B74EE84D57, success, context);
}

_id_D718B6FF11577E22(_id_CC75E0B74EE84D57) {
  level endon("game_ended");
  _id_CC75E0B74EE84D57 endon("bounty_end");

  if(_id_CC75E0B74EE84D57._id_1E7FE7292618D1C5 <= 0) {
    return;
  }
  wait(_id_CC75E0B74EE84D57._id_1E7FE7292618D1C5);
  _id_A10C4276271C4AD7(_id_CC75E0B74EE84D57, 0, 1);
}

_id_38FBD8F15EDE0C59(_id_CC75E0B74EE84D57) {
  level endon("game_ended");
  _id_CC75E0B74EE84D57 scripts\engine\utility::waittill_any_2("bounty_end", "hide_bounty");

  if(isDefined(_id_CC75E0B74EE84D57.headicon))
    _id_CC75E0B74EE84D57.player scripts\cp_mp\entityheadicons::setheadicon_deleteicon(_id_CC75E0B74EE84D57.headicon);

  if(isDefined(_id_CC75E0B74EE84D57._id_43873940161B7F28)) {
    _id_CC75E0B74EE84D57._id_43873940161B7F28 notify("stop_tracking");
    _id_CC75E0B74EE84D57._id_43873940161B7F28 scripts\mp\gameobjects::releaseid();
    _id_CC75E0B74EE84D57._id_43873940161B7F28 scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  }
}

_id_3CD64058B039543D(player, _id_8A04AA0E0755E7E3, _id_EB06B338608EF354) {
  _id_F24642B09A1FC3DF = _id_0D34EA2B5E8F5D93(_id_EB06B338608EF354);
  _id_AEE6C716B9D9ABE4 = _id_0D34EA2B5E8F5D93(_id_8A04AA0E0755E7E3);

  if(_id_F24642B09A1FC3DF.size == 0 && _id_AEE6C716B9D9ABE4.size == 0) {
    return;
  }
  foreach(_id_DC401F458E995072 in _id_F24642B09A1FC3DF) {
    if(_id_DC401F458E995072.player == player) {
      continue;
    }
    headicon = _id_DC401F458E995072.headicon;

    if(isDefined(headicon)) {
      if(_id_DC401F458E995072._id_D66266E27481ACE9 == 2)
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(headicon, player);
      else if(_id_DC401F458E995072._id_40CA706DA5962314 == 2)
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, player);
    }

    circle = _id_DC401F458E995072._id_43873940161B7F28;

    if(isDefined(circle)) {
      if(_id_DC401F458E995072._id_D66266E27481ACE9 == 1) {
        circle scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
        continue;
      }

      if(_id_DC401F458E995072._id_40CA706DA5962314 == 1)
        circle scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
    }
  }

  foreach(_id_DC401F458E995072 in _id_AEE6C716B9D9ABE4) {
    if(_id_DC401F458E995072.player == player) {
      continue;
    }
    headicon = _id_DC401F458E995072.headicon;

    if(isDefined(headicon)) {
      if(_id_DC401F458E995072._id_40CA706DA5962314 == 2)
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(headicon, player);
      else if(_id_DC401F458E995072._id_D66266E27481ACE9 == 2)
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, player);
    }

    circle = _id_DC401F458E995072._id_43873940161B7F28;

    if(isDefined(circle)) {
      if(_id_DC401F458E995072._id_40CA706DA5962314 == 1) {
        circle scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
        continue;
      }

      if(_id_DC401F458E995072._id_D66266E27481ACE9 == 1)
        circle scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
    }
  }
}