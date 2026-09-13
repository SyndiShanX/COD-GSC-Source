/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\leagueplay.gsc
***********************************************/

init() {
  if(!level._id_EC2FB549B15AD827) {
    return;
  }
  _id_04CDABCD91A92977::_id_8CE5B106FBBA9E9F(::ondisconnect);
  _id_04CDABCD91A92977::_id_8FE6D6539ED31A88(::_id_ADCDFD1B1A3EFA51);
  level._id_DBF03354F99EBAB2 = ::_id_ECB13C8E7B38FACD;
  level._id_C8001F5313A05589 = getdvarint("dvar_B5256FB3F4ED76AF", 0);
  level._id_7272C293F31C587C = getdvarint("dvar_0A94C6ED8A414196", 0);
  level._id_8C675B8E9E21EC44 = getdvarint("dvar_95BDE55F2B298C10", 15);
  level._id_B70D036A3245E389 = _func_9BE1E9F1351A5C97();
  level._id_75B72A33AEAB21D4 = _func_CE30512FCD3A11A1();
  level._id_CBBF84A8E78CAEEE = _func_08345F2AC499E5AB();
  level._id_BBCB5F6B1B0A78AE = 0;

  if(!isDefined(level._id_75B72A33AEAB21D4))
    level._id_75B72A33AEAB21D4 = 0;

  level._id_6CD6EA2A7A7DDFFB = "none";
  _id_04AE5C8D79E73D36 = 4;

  if(isusingmatchrulesdata())
    _id_04AE5C8D79E73D36 = getmatchrulesdata("commonOption", "squadSize");

  level.requiredplayercountoveride = 1;
  level.requiredplayercount["allies"] = _id_04AE5C8D79E73D36;
  level.requiredplayercount["axis"] = _id_04AE5C8D79E73D36;
  level._id_DC3C7C5627A11E5E = getdvarint("dvar_0F0AD3B38C4166EE", 150);
  level._id_7D731C7DCBEFBF3D = 1;
  level thread _id_3340318A370A7CB2();
  level thread _id_3F15B5152EF99080();
  _id_5F4A4AACB73B91D7 = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPointsPlacement", 1));
  level._id_F67EE22DA6041B9B = _func_1E73E03E20E15DFF();
  _func_87FAE2B26DBC397D(_id_5F4A4AACB73B91D7);
  _id_5EA9C8005581107F();
}

_id_3340318A370A7CB2() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);

    if(istrue(level._id_15C7D73680EA5496)) {
      return;
    }
    if(!isPlayer(player) || isbot(player)) {
      return;
    }
    xuid = player getxuid();

    if(!_id_4707C41ED8BAE2D2(player) || !_func_AB839AAC87B49838(xuid))
      player _id_6C42F05B6C82B35E();

    _id_DA4DA6075AA47D27 = scripts\engine\utility::ter_op(istrue(player.pers["LPAllowLeave"]), 2, 3);
    player setclientomnvar("ui_leagueplay_allow_quit", _id_DA4DA6075AA47D27);
  }
}

_id_ADCDFD1B1A3EFA51(player) {
  if(istrue(level._id_15C7D73680EA5496)) {
    return;
  }
  if(!isPlayer(player) || isbot(player)) {
    return;
  }
  player.pers["leaguePlayDisconnected"] = 0;
  xuid = player getxuid();

  if(_id_4707C41ED8BAE2D2(player) && _func_AB839AAC87B49838(xuid)) {
    _func_778365A5DD216A2B(xuid);
    _func_C080F7EF04FC3970(xuid, "");
    _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();

    if(_id_BCA6691D9622C899 > -1)
      player _meth_DB073176839D77FB("50", [6, 0, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 12, _id_BCA6691D9622C899, 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
    else
      player _meth_DB073176839D77FB("50", [6, 0, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
  }
}

ondisconnect(player) {
  if(istrue(level._id_F25335848C8EA5A0) || istrue(level._id_15C7D73680EA5496)) {
    return;
  }
  if(!isPlayer(player) || isbot(player)) {
    return;
  }
  if(!isDefined(player) || !isDefined(player.team)) {
    return;
  }
  if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
    return;
  }
  if(!istrue(level._id_149C4CBC0FA7557D) && _id_630EC6E211CD26D1())
    level._id_149C4CBC0FA7557D = 1;

  _id_51F2B611A0573B40 = [];

  if(istrue(level.matchmakingmatch))
    _id_51F2B611A0573B40 = player getfireteammembers();

  foreach(ent in level.players) {
    if(scripts\engine\utility::is_equal(ent.team, player.team) && isPlayer(ent)) {
      if(scripts\engine\utility::array_contains(_id_51F2B611A0573B40, ent))
        ent setclientomnvar("ui_leagueplay_allow_quit", 0);
      else
        ent setclientomnvar("ui_leagueplay_allow_quit", 2);

      ent.pers["LPAllowLeave"] = 1;
    }
  }

  _id_DDA705F2E8FF8269 = 0;
  _id_2214A26986673AD6 = 0;
  _id_6C48B18C400529B9 = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1));
  _id_934DC135AAF6F953 = 0;
  _id_3511C7EE351E5C90 = scripts\mp\teams::countplayers();
  xuid = player getxuid();

  if(isDefined(_id_3511C7EE351E5C90) && isDefined(_id_3511C7EE351E5C90[player.team]) && _id_3511C7EE351E5C90[player.team] == 3) {
    _id_2214A26986673AD6 = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPenaltyFirstLeave", 1));
    _id_934DC135AAF6F953 = 1;
  } else {
    _id_2214A26986673AD6 = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPenaltyAdditionalLeave", 1));
    _id_934DC135AAF6F953 = 2;
  }

  if(isDefined(player._id_3FCC771F2C65C38F) && istrue(player._id_3FCC771F2C65C38F))
    _id_934DC135AAF6F953 = 3;
  else if(isDefined(player._id_72C19B43B99E7097) && istrue(player._id_72C19B43B99E7097))
    _id_934DC135AAF6F953 = 4;
  else if(scripts\mp\gamelogic::_id_1147BBC93EA9B83C())
    _id_934DC135AAF6F953 = 9;

  _func_C080F7EF04FC3970(xuid, _id_934DC135AAF6F953);
  _func_0F65A948BFF3A538(xuid, _id_2214A26986673AD6, 1);

  if(isDefined(player.team))
    _func_B3B3E822F262EBDA(xuid, 0, player.team);

  _func_626B6E017A257E10(xuid);
  player.pers["leaguePlayDisconnected"] = 1;
  _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();

  if(_id_BCA6691D9622C899 > -1)
    return [6, 1, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 13, _id_934DC135AAF6F953, 10, -1 * (_id_6C48B18C400529B9 + _id_2214A26986673AD6), 11, _id_DDA705F2E8FF8269, 12, _id_BCA6691D9622C899, 4, _id_04CDABCD91A92977::_id_FB67B62BBD718B34(), 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()];
  else
    return [6, 1, 7, _func_94C7AE7049488358(), 19, _func_4F9373A1227DB35C(), 13, _id_934DC135AAF6F953, 10, -1 * (_id_6C48B18C400529B9 + _id_2214A26986673AD6), 11, _id_DDA705F2E8FF8269, 4, _id_04CDABCD91A92977::_id_FB67B62BBD718B34(), 9, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()];
}

_id_3F15B5152EF99080() {
  level endon("game_ended");

  if(!scripts\mp\flags::gameflag("prematch_done"))
    scripts\mp\flags::gameflagwait("prematch_done");

  _func_57A19C163B50D584();

  foreach(player in level.players) {
    if(isDefined(player.team))
      _func_11E88C88F89143FE(player getxuid(), player.team);
  }

  if(!scripts\mp\utility\game::isroundbased() || scripts\mp\utility\game::isfirstround())
    level thread _id_BA4DA6A667E97E19();
}

_id_BA4DA6A667E97E19() {
  if(!isDefined(level._id_7272C293F31C587C) || level._id_7272C293F31C587C <= 0) {
    return;
  }
  level endon("game_ended");

  while(_id_630EC6E211CD26D1()) {
    if(istrue(level._id_149C4CBC0FA7557D)) {
      level._id_60F7D8BD0181980F = 1;
      setomnvarforallclients("ui_leagueplay_allow_quit", 1);
      thread scripts\mp\gamelogic::_id_46EB417B582D5179(level._id_8C675B8E9E21EC44 * 1000);
      wait(level._id_8C675B8E9E21EC44);
      _id_DC56B195BBF80D31();
      return;
    }

    wait 1;
  }
}

_id_ECB13C8E7B38FACD() {
  if(istrue(level._id_60F7D8BD0181980F) && !istrue(level._id_15C7D73680EA5496))
    return 1;

  return 0;
}

_id_630EC6E211CD26D1() {
  return (!scripts\mp\utility\game::isroundbased() || scripts\mp\utility\game::isfirstround()) && isDefined(level._id_7272C293F31C587C) && scripts\mp\utility\game::getsecondspassed() < level._id_7272C293F31C587C;
}

_id_5EA9C8005581107F() {
  setnojipscore(1, 1);
  setnojiptime(1, 1);
  level.nojip = 1;
}

_id_4707C41ED8BAE2D2(player) {
  if(isDefined(player.pers["leaguePlayInit"]))
    return player.pers["leaguePlayInit"] == 1;

  return 0;
}

_id_6C42F05B6C82B35E() {
  player = self;

  if(!isPlayer(player) || isbot(player)) {
    return;
  }
  if(isDefined(player.pers["leaguePlayInit"]) && player.pers["leaguePlayInit"] == 1) {
    return;
  }
  xuid = player getxuid();
  _id_7FB9BCAAA8EBB115 = 0;
  _id_59D49AB6B66AAF7C = 0;
  player.pers["leaguePlayOnLadder"] = 0;
  player.pers["leaguePlayDisconnected"] = 0;

  if(_id_78FCC96BE9D69371() > -1) {
    _id_59D49AB6B66AAF7C = player getplayerdata(level._id_5D69837CF4DB0407, "leaguePlayData", level._id_BBCB5F6B1B0A78AE, "season", level._id_F67EE22DA6041B9B, "pmatches") == getdvarint("dvar_FD4D1A68A9DAFF4D", 5) - 1;
    _id_8B918A9E28B6DB8E = player getplayerdata(level._id_5D69837CF4DB0407, "leaguePlayData", level._id_BBCB5F6B1B0A78AE, "season", level._id_F67EE22DA6041B9B, "pmatches") >= getdvarint("dvar_FD4D1A68A9DAFF4D", 5);
    player.pers["leaguePlayOnLadder"] = player getplayerdata(level._id_5D69837CF4DB0407, "leaguePlayData", level._id_BBCB5F6B1B0A78AE, "league_id") == level._id_B70D036A3245E389;

    if(_id_8B918A9E28B6DB8E && !player.pers["leaguePlayOnLadder"])
      _id_7FB9BCAAA8EBB115 = 1;
  }

  _func_E0E1F4CEEEEF5F34(xuid, _id_7FB9BCAAA8EBB115, player.pers["leaguePlayOnLadder"], _id_59D49AB6B66AAF7C);
  player.pers["leaguePlayInit"] = 1;
}

_id_7B16E8257C0259A2(_id_CFFF0D450FBBB7AE) {
  level._id_6CD6EA2A7A7DDFFB = _id_CFFF0D450FBBB7AE;
}

_id_DC56B195BBF80D31() {
  level._id_15C7D73680EA5496 = 1;
  level._id_7EBDE40AF908FCF8 = 0;

  if(getdvarint("online_mp_clientmatchdata_enabled") != 0) {
    foreach(player in level.players) {
      if(!isDefined(player.clientmatchdataid))
        scripts\mp\gamelogic::assignclientmatchdataid(player);

      setclientmatchdata("players", player.clientmatchdataid, "leaguePlayMatchCancelled", level._id_15C7D73680EA5496);
    }
  }

  scripts\mp\gamescore::updateplacement();
  scripts\mp\gamelogic::processlobbydata();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    _id_D1092FECB16D3B3C(undefined);
    wait 1;
    level notify("exitLevel_called");
    exitlevel(0);
  } else
    level thread scripts\mp\gamelogic::forceend();
}

_id_78FCC96BE9D69371() {
  if(isDefined(level._id_F67EE22DA6041B9B) && level._id_F67EE22DA6041B9B >= 0)
    return level._id_F67EE22DA6041B9B;

  return -1;
}

_id_883F3D0FDEF74FBF(winner) {
  player = self;

  if(!isDefined(winner))
    return 2;

  if(level.teambased) {
    if(scripts\mp\utility\teams::isgameplayteam(winner)) {
      if(isDefined(player.team)) {
        if(player.team == winner)
          return 3;
        else
          return 1;
      }
    } else if(isstring(winner) && winner == "tie")
      return 2;
  }

  return undefined;
}

_id_5231A8B9BC35B470(_id_79882B673D84CE0D) {
  player = self;
  _id_A485D3A2171216FE = player getplayerdata(level._id_5D69837CF4DB0407, "leaguePlayData", level._id_BBCB5F6B1B0A78AE, "bonuspool");
  _id_282F09C3AC1A1052 = _id_A485D3A2171216FE - _id_79882B673D84CE0D;

  if(_id_282F09C3AC1A1052 >= 0) {
    player getplayerdata(level._id_5D69837CF4DB0407, "leaguePlayData", level._id_BBCB5F6B1B0A78AE, "bonuspool", _id_282F09C3AC1A1052);
    return _id_79882B673D84CE0D;
  }

  return 0;
}

_id_D1092FECB16D3B3C(winner) {
  level.gameended = 1;
  level._id_F25335848C8EA5A0 = 1;
  _id_9536B5B9BFF06DED = istrue(level._id_15C7D73680EA5496);
  _id_A6CB99A10D8FD510 = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPointsWin", 1));
  _id_6C48B18C400529B9 = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1));
  _id_79882B673D84CE0D = int(tablelookup("mp/leagueplay_config.csv", 0, "ladderPointsBonusPoolStep", 1));
  _id_BCA6691D9622C899 = _id_78FCC96BE9D69371();
  _id_156E078B5445FFAA = _func_4F9373A1227DB35C();
  _id_F7E96D6052425187 = _func_94C7AE7049488358();
  _id_ABBF42875A7797AD = getdvarint("dvar_74B99125B3898193", 86400);

  foreach(player in level.players) {
    if(!isPlayer(player) || isbot(player)) {
      continue;
    }
    if(!isDefined(player.pers["leaguePlayInit"]) || player.pers["leaguePlayInit"] == 0) {
      continue;
    }
    if(!isDefined(player.pers["leaguePlayDisconnected"]) || player.pers["leaguePlayDisconnected"] == 1) {
      continue;
    }
    xuid = player getxuid();
    _id_E8F096C8BFC6C153 = player _id_883F3D0FDEF74FBF(winner);
    _id_E3ED73E668A015F3 = _func_904672268EB8E3FE(xuid);
    _id_49BB51E761C847FF = 0;
    _id_31EC327C47F15B5C = _func_7EE4E0E48FE05C22(xuid);
    _id_5556094781139A10 = isDefined(player.pers["leaguePlayOnLadder"]) && player.pers["leaguePlayOnLadder"];
    _func_C080F7EF04FC3970(xuid, 0);

    if(level._id_75B72A33AEAB21D4 != 1 || _id_5556094781139A10 || _id_31EC327C47F15B5C)
      _id_49BB51E761C847FF = _func_D85A1E614464B733(_id_E3ED73E668A015F3);

    if(_id_9536B5B9BFF06DED)
      _id_E8F096C8BFC6C153 = 0;
    else if(isDefined(_id_E8F096C8BFC6C153) && (_id_5556094781139A10 || _id_31EC327C47F15B5C)) {
      if(_id_E8F096C8BFC6C153 == 3) {
        _id_453735E83C192121 = 0;

        if(_id_5556094781139A10)
          _id_453735E83C192121 = player _id_5231A8B9BC35B470(_id_79882B673D84CE0D);

        _func_0F65A948BFF3A538(xuid, _id_A6CB99A10D8FD510 + _id_453735E83C192121);
      } else if(_id_E8F096C8BFC6C153 == 1)
        _func_0F65A948BFF3A538(xuid, _id_6C48B18C400529B9);
      else {}
    }

    if(isDefined(level._id_B70D036A3245E389) && isDefined(_id_E8F096C8BFC6C153) && _id_BCA6691D9622C899 > -1) {
      if(_id_E3ED73E668A015F3 > 0)
        player _meth_DB073176839D77FB("80", [0, level._id_B70D036A3245E389, 1, _id_E8F096C8BFC6C153, 2, _id_E3ED73E668A015F3, 3, _id_49BB51E761C847FF, 8, _id_31EC327C47F15B5C, 13, _id_5556094781139A10, 12, _id_BCA6691D9622C899, 7, _id_F7E96D6052425187, 19, _id_156E078B5445FFAA, 16, level._id_75B72A33AEAB21D4, 17, _id_ABBF42875A7797AD, 18, 1, 25, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
      else
        player _meth_DB073176839D77FB("80", [0, level._id_B70D036A3245E389, 1, _id_E8F096C8BFC6C153, 3, _id_49BB51E761C847FF, 8, _id_31EC327C47F15B5C, 13, _id_5556094781139A10, 12, _id_BCA6691D9622C899, 7, _id_F7E96D6052425187, 19, _id_156E078B5445FFAA, 16, level._id_75B72A33AEAB21D4, 17, _id_ABBF42875A7797AD, 18, 1, 25, level._id_CBBF84A8E78CAEEE, 32, _id_04CDABCD91A92977::_id_E3BD94413509BC25()]);
    }

    if(isDefined(player.team)) {
      _id_663572CC85C027C6 = 0;

      if(!_id_9536B5B9BFF06DED && isDefined(player.pers["score"]))
        _id_663572CC85C027C6 = player.pers["score"];

      _func_B3B3E822F262EBDA(xuid, _id_663572CC85C027C6, player.team);
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++) {
    _id_929A6DF466DC4F22 = 0;

    if(!_id_9536B5B9BFF06DED)
      _id_929A6DF466DC4F22 = scripts\mp\gamescore::_getteamscore(level.teamnamelist[_id_AC0E594AC96AA3A8]);

    _func_846C101D2C3FE49A(level.teamnamelist[_id_AC0E594AC96AA3A8], _id_929A6DF466DC4F22);
  }

  _id_EC15CE3E7A9D1D86 = winner;

  if(!isDefined(winner) || _id_9536B5B9BFF06DED || isstring(winner) && winner == "tie")
    _id_EC15CE3E7A9D1D86 = "none";

  _func_DACFB39159904E2C(_id_9536B5B9BFF06DED, level._id_6CD6EA2A7A7DDFFB, _id_EC15CE3E7A9D1D86);
}