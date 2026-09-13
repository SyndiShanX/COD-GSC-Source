/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gamestaterestore.gsc
***********************************************/

setupcallbacks() {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  if(isDefined(game["gameStateRestore"]) && istrue(game["gameStateRestore"].enabled)) {
    if(isDefined(level._id_E2E7DBB91B6632CF))
      level._id_E2E7DBB91B6632CF[level._id_E2E7DBB91B6632CF.size] = ::_id_E366F768381EB363;
    else
      level._id_E2E7DBB91B6632CF[0] = ::_id_E366F768381EB363;
  }
}

_id_E366F768381EB363() {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  if(game["gameStateRestore"].enabled)
    thread _id_C197C8F84A75B476(self);
}

_id_C197C8F84A75B476(player) {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  self waittill("giveLoadout");
  _id_9C7DA2D0CB6B8DC4 = game["gameStateRestore"];

  foreach(_id_0AD3658A1088AF24 in _id_9C7DA2D0CB6B8DC4.players) {
    if(_id_0AD3658A1088AF24.identifier != self.name) {
      continue;
    }
    _id_BC22A4311E741BB3(self, _id_0AD3658A1088AF24);
    _id_A5D40EC6023315A0(self.name);
    break;
  }

  return;
}

_id_A5D40EC6023315A0(_id_81A6DCF8641471F7) {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < game["gameStateRestore"].players.size; _id_AC0E594AC96AA3A8++) {
    if(game["gameStateRestore"].players[_id_AC0E594AC96AA3A8].identifier == _id_81A6DCF8641471F7) {
      game["gameStateRestore"].players[_id_AC0E594AC96AA3A8] = undefined;
      break;
    }
  }

  if(game["gameStateRestore"].players.size <= 0)
    game["gameStateRestore"].enabled = 0;
}

_id_3433FF82F51BCE6D() {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  game["gameStateRestore"] = _id_548072087C9FD504::_id_8C8838610394416A();
  game["gameStateRestoreAlreadyUsed"] = 1;
}

_id_9505807477B46FA4(_id_81A6DCF8641471F7) {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0)
    return 0;

  _id_9C7DA2D0CB6B8DC4 = game["gameStateRestore"];

  foreach(_id_0AD3658A1088AF24 in _id_9C7DA2D0CB6B8DC4.players) {
    if(_id_0AD3658A1088AF24.identifier != _id_81A6DCF8641471F7) {
      continue;
    }
    return _id_0AD3658A1088AF24.deaths;
  }

  return 0;
}

_id_BC001C2EBD383FFF() {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  if(!isDefined(game["gameStateRestore"]) || !game["gameStateRestore"].enabled) {
    return;
  }
  _id_A1B29777F1D4D2DC = game["gameStateRestore"];
  _id_CC67F138614157C4(_id_A1B29777F1D4D2DC);
  game["roundsPlayed"] = _id_A1B29777F1D4D2DC._id_462CCACDBC27588F + _id_A1B29777F1D4D2DC._id_E861F99F136BD454;

  if(game["roundsPlayed"] / level.roundswitch % 2 == 1)
    game["switchedsides"] = 1;

  _id_9F5611F9DF9B6BEE(_id_A1B29777F1D4D2DC);
  level thread scripts\mp\gamelogic::_id_0236FB1C819BCD1F();
}

_id_CC67F138614157C4(_id_A1B29777F1D4D2DC) {
  game["roundsWon"]["allies"] = _id_A1B29777F1D4D2DC._id_462CCACDBC27588F;
  game["roundsWon"]["axis"] = _id_A1B29777F1D4D2DC._id_E861F99F136BD454;
  game["teamScores"]["allies"] = _id_A1B29777F1D4D2DC._id_462CCACDBC27588F;
  game["teamScores"]["axis"] = _id_A1B29777F1D4D2DC._id_E861F99F136BD454;
  setteamscore("allies", _id_A1B29777F1D4D2DC._id_462CCACDBC27588F);
  setteamscore("axis", _id_A1B29777F1D4D2DC._id_E861F99F136BD454);
}

_id_9F5611F9DF9B6BEE(_id_A1B29777F1D4D2DC) {
  _id_D6FD8BE398B20F61 = game["attackers"];
  _id_8613C2B22B0116A5 = game["defenders"];

  if(scripts\mp\utility\game::getgametype() == "control") {
    game["segment_captures"][_id_D6FD8BE398B20F61] = _id_A1B29777F1D4D2DC._id_BBB396FC2F580332;
    game["segment_captures"][_id_8613C2B22B0116A5] = _id_A1B29777F1D4D2DC._id_6EB8962F9CA9F5C1;
  }

  game["match_kills"][_id_D6FD8BE398B20F61] = _id_A1B29777F1D4D2DC._id_8211A93C015E7700;
  game["match_kills"][_id_8613C2B22B0116A5] = _id_A1B29777F1D4D2DC._id_C56813D5326A9D1B;
}

_id_BC22A4311E741BB3(player, _id_0AD3658A1088AF24) {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  if(!isDefined(game["gameStateRestore"]) || !game["gameStateRestore"].enabled) {
    return;
  }
  player.kills = _id_0AD3658A1088AF24.kills;
  player scripts\mp\utility\stats::initpersstat("kills");
  player scripts\mp\utility\stats::incpersstat("kills", player.kills);
  player.deaths = _id_0AD3658A1088AF24.deaths;
  player scripts\mp\utility\stats::initpersstat("deaths");
  player scripts\mp\utility\stats::incpersstat("deaths", player.deaths);
  _id_252C1AD767A7A83C(player, _id_0AD3658A1088AF24);
  _id_EB800AB2BE810565(player, _id_0AD3658A1088AF24);
}

_id_252C1AD767A7A83C(player, _id_0AD3658A1088AF24) {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  if(_id_0AD3658A1088AF24._id_56F525DE50B57A43 < 0)
    _id_0AD3658A1088AF24._id_56F525DE50B57A43 = 0;

  _id_04591B3666013F31 = _id_0AD3658A1088AF24._id_56F525DE50B57A43;
  player.pers["cur_kill_streak"] = _id_04591B3666013F31;
  player scripts\mp\utility\stats::initpersstat("streakPoints");
  player scripts\mp\utility\stats::incpersstat("streakPoints", _id_04591B3666013F31);
  player scripts\mp\codcasterclientmatchdata::_id_7EE466E81B1AFC12(6, _id_04591B3666013F31);
  player scripts\mp\codcasterclientmatchdata::_id_7EE466E81B1AFC12(7, _id_04591B3666013F31);
  player.lifeid = player.deaths;
  player.pers["deaths"] = player.lifeid;
  player scripts\mp\killstreaks\killstreaks::givestreakpoints("stat_EF9582D72160F199", _id_04591B3666013F31);

  for(_id_015314DA30B44470 = 1; _id_015314DA30B44470 <= 3; _id_015314DA30B44470++) {
    _id_153FDEE861E0F06F = _id_0AD3658A1088AF24.killstreaks[_id_015314DA30B44470 - 1];
    _id_90A0B6FCE25C0986 = _id_153FDEE861E0F06F.used;
    _id_724676BE205E0DF0 = _id_153FDEE861E0F06F.earned;
    _id_6D029727F4E7F7E8 = player scripts\mp\killstreaks\killstreaks::getkillstreakinslot(_id_015314DA30B44470);

    if(isDefined(_id_6D029727F4E7F7E8) && isDefined(_id_6D029727F4E7F7E8.streakname)) {
      _id_32E049AFBC37BD56 = player scripts\mp\killstreaks\killstreaks::calcstreakcost(_id_6D029727F4E7F7E8.streakname);

      if(_id_90A0B6FCE25C0986)
        _id_6D029727F4E7F7E8.available = -1;
      else if(_id_724676BE205E0DF0 || _id_32E049AFBC37BD56 <= _id_04591B3666013F31)
        _id_6D029727F4E7F7E8.available = 1;

      player scripts\mp\killstreaks\killstreaks::_id_8D43CE79A3F2D876(_id_015314DA30B44470, _id_6D029727F4E7F7E8.available);
    }
  }
}

_id_D0E691079192C053(player, _id_0AD3658A1088AF24) {
  _id_F99AE5D85FB5351B = player.super.staticdata.pointsneeded;
  _id_0507128F021F412A = _id_0AD3658A1088AF24._id_B5F07F928D5E50C1.progress;
  _id_57304761143D03ED = _id_0507128F021F412A * _id_F99AE5D85FB5351B / 100;
  return _id_57304761143D03ED;
}

_id_EB800AB2BE810565(player, _id_0AD3658A1088AF24) {
  if(getdvarint("dvar_7DFC9D99D9C1FF2F", 0) == 0) {
    return;
  }
  if(_id_0AD3658A1088AF24._id_B5F07F928D5E50C1.progress) {
    _id_319B074B9C1A6807 = _id_D0E691079192C053(player, _id_0AD3658A1088AF24);
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "giveSuperPoints")]](_id_319B074B9C1A6807);
  }
}