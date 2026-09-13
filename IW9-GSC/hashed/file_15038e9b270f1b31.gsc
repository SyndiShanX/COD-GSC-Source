/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_15038e9b270f1b31.gsc
***********************************************/

init() {
  if(getdvarint("dvar_A6B52F16F3853A9A", 0) == 0) {
    return;
  }
  level._id_BF269015710DE2DD = 1;
  level._id_8ED22C88753F7445 = getdvarint("dvar_2401FBC45A4682A5", 100);
  level._id_A4DAB5000ECA4682 = getdvarint("dvar_3FD4F18A01C87CE2", 10);
  level._id_BE6C4A2A3EA18574 = 0;
  level._id_373B806B04381D6F = 0;
  _id_362C58E8BB39BCDA::registerbrgametypefunc("updatePlayerAndTeamCountUI", ::_id_806AD317DE2AF4F3);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::_id_6436C089F777048B);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::_id_F5FD598A80445D04);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerDisconnect", ::_id_98B1FBBDD7377898);
  level thread watchprematchdone();
}

_id_806AD317DE2AF4F3(_id_6B2375BEF731CC3A, _id_A4C3A5AFE5B8DA9B) {
  totalplayers = level.players.size;
  _id_6B2375BEF731CC3A = 0;
  _id_35068B9B9DC4C73F = 0;
  _id_A4C3A5AFE5B8DA9B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < totalplayers; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(player _id_1E4A61DB11011446::_id_7DBB8165D792B06C()) {
      continue;
    }
    if(!istrue(player.br_iseliminated)) {
      if(istrue(player.iszombie))
        _id_35068B9B9DC4C73F++;
      else {
        _id_6B2375BEF731CC3A++;
        _id_A4C3A5AFE5B8DA9B[player.team] = 1;
      }
    }

    if(!isDefined(_id_A4C3A5AFE5B8DA9B[player.team])) {
      result = _id_362C58E8BB39BCDA::runbrgametypefunc("isTeamEliminated", player.team);

      if(isDefined(result)) {
        if(!result)
          _id_A4C3A5AFE5B8DA9B[player.team] = 1;
      }
    }
  }

  foreach(_id_B4ADDE4C68BB0F24 in _id_1E4A61DB11011446::_id_749723C2A45A0233()) {
    _id_6B2375BEF731CC3A++;
    _id_A4C3A5AFE5B8DA9B[_id_B4ADDE4C68BB0F24.team] = 1;
  }

  if(scripts\mp\flags::gameflag("prematch_done")) {
    _id_7AD00A4D4CF05D81 = int(_id_A4C3A5AFE5B8DA9B.size + level._id_8ED22C88753F7445 / getdvarint("dvar_4838B7C39021124C", 3));
    _id_6B2375BEF731CC3A = int(_id_6B2375BEF731CC3A + level._id_8ED22C88753F7445);
  } else {
    _id_7AD00A4D4CF05D81 = int(_id_A4C3A5AFE5B8DA9B.size + level._id_BE6C4A2A3EA18574 / getdvarint("dvar_4838B7C39021124C", 3));
    _id_6B2375BEF731CC3A = int(_id_6B2375BEF731CC3A + level._id_BE6C4A2A3EA18574);
  }

  level._id_373B806B04381D6F = _id_7AD00A4D4CF05D81;
  _id_047BF15E70EE220A = (_id_35068B9B9DC4C73F << 16) + (_id_7AD00A4D4CF05D81 << 8) + _id_6B2375BEF731CC3A;
  setomnvar("ui_br_match_stats", _id_047BF15E70EE220A);
}

_id_6436C089F777048B(_id_642470E1ABC1BBF9) {
  if(scripts\mp\flags::gameflag("prematch_done"))
    level thread _id_479D3F9AAF4E3BF0();
}

_id_F5FD598A80445D04(player) {
  _id_92247B35CD23DBEC = level.players.size - level._id_A4DAB5000ECA4682;

  if(_id_92247B35CD23DBEC > 0)
    _id_E4762082EF346678 = level._id_8ED22C88753F7445 / getdvarint("party_maxplayers", 1);
  else
    _id_E4762082EF346678 = 0;

  if(_id_E4762082EF346678 <= 0) {
    return;
  }
  totalplayers = level.players.size;
  _id_F5439ADC07558E92 = level._id_8ED22C88753F7445 + totalplayers;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E4762082EF346678; _id_AC0E594AC96AA3A8++) {
    level._id_BE6C4A2A3EA18574 = min(_id_F5439ADC07558E92, level._id_BE6C4A2A3EA18574 + 1);
    _id_1E4A61DB11011446::updateplayerandteamcountui();

    if(level._id_8ED22C88753F7445 <= 0)
      return;
  }

  _id_1E4A61DB11011446::updateplayerandteamcountui();
}

_id_98B1FBBDD7377898(player) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    level thread _id_479D3F9AAF4E3BF0();
    return;
  }

  level thread _id_479D3F9AAF4E3BF0(1);
}

_id_397F011C8120EA71() {
  self setclientomnvar("ui_br_player_position", level._id_373B806B04381D6F + 1);
}

watchprematchdone() {
  _id_1E4A61DB11011446::updateplayerandteamcountui();
  level waittill("prematch_over");
  level._id_E4762082EF346678 = undefined;
  level._id_BE6C4A2A3EA18574 = undefined;
  _id_43B93F9CB6D3A779 = level.players.size - level._id_A4DAB5000ECA4682;

  if(_id_43B93F9CB6D3A779 > 0)
    level._id_AEFAC0C879F41D97 = level._id_8ED22C88753F7445 / _id_43B93F9CB6D3A779;
  else
    level._id_8ED22C88753F7445 = 0;

  _id_1E4A61DB11011446::updateplayerandteamcountui();
}

_id_479D3F9AAF4E3BF0(_id_428B69AA429BFF26) {
  if(level._id_8ED22C88753F7445 <= 0) {
    return;
  }
  _id_92E1F1E24BF5FEBD = scripts\engine\utility::ter_op(scripts\mp\flags::gameflag("prematch_done"), level._id_AEFAC0C879F41D97, level._id_E4762082EF346678);

  if(!isDefined(_id_92E1F1E24BF5FEBD)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_92E1F1E24BF5FEBD; _id_AC0E594AC96AA3A8++) {
    if(!istrue(_id_428B69AA429BFF26))
      wait(randomfloat(5));

    level._id_8ED22C88753F7445 = max(0, level._id_8ED22C88753F7445 - 1);
    _id_1E4A61DB11011446::updateplayerandteamcountui();

    if(level._id_8ED22C88753F7445 <= 0)
      return;
  }
}

getalivecount() {
  totalplayers = level.players.size;
  _id_6B2375BEF731CC3A = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < totalplayers; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(player _id_1E4A61DB11011446::_id_7DBB8165D792B06C()) {
      continue;
    }
    if(!istrue(player.br_iseliminated)) {
      if(!istrue(player.iszombie))
        _id_6B2375BEF731CC3A++;
    }
  }

  return _id_6B2375BEF731CC3A;
}