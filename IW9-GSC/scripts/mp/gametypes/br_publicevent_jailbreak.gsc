/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_jailbreak.gsc
*************************************************************/

init() {
  _id_7EC7671A1E0C788F = spawnStruct();
  _id_7EC7671A1E0C788F.weight = getdvarfloat("dvar_61CEC75D556C8A54", 1.0);
  _id_7EC7671A1E0C788F.validatefunc = ::validatefunc;
  _id_7EC7671A1E0C788F.activatefunc = ::activatefunc;
  _id_7EC7671A1E0C788F.waitfunc = ::waitfunc;
  _id_7EC7671A1E0C788F._id_C9E871D29702E8CF = ::_id_C9E871D29702E8CF;
  _id_7EC7671A1E0C788F._id_D72A1842C5B57D1D = getdvarint("dvar_7CE40A5064ED5AAF", 2);
  _id_7EC7671A1E0C788F._id_F0F6529C88A18128 = _id_337BD370F7C5E6F9::_id_4634160166FB7F8B("jailbreak", "00 5 10 10101010");
  _id_7EC7671A1E0C788F._id_B9B56551E1ACFEE2 = _id_294DDA4A4B00FFE3::_id_8BE9BAE8228A91F7("jailbreak");
  _id_337BD370F7C5E6F9::registerpublicevent(3, _id_7EC7671A1E0C788F);
}

_id_C9E871D29702E8CF() {
  game["dialog"]["public_events_jailbreak_incoming_active"] = "pbvn_wzan_jbwr";
  game["dialog"]["public_events_jailbreak_incoming_active_alt"] = "pbvn_wzan_jbwr";
  game["dialog"]["public_events_jailbreak_now_active"] = "pbvn_wzan_jbct";
  game["dialog"]["public_events_jailbreak_now_active_alt"] = "pbvn_wzan_jbct";
  game["dialog"]["public_events_jailbreak_now_gulag"] = "pbvn_wzan_jbge";
  game["dialog"]["public_events_jailbreak_now_spectate"] = "pbvn_wzan_jbse";
}

validatefunc() {
  _id_21EB9CE44FFF7E79 = !_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife");
  _id_B5C6B5AD4D7C67DD = istrue(level.usegulag);
  return _id_21EB9CE44FFF7E79 || _id_B5C6B5AD4D7C67DD;
}

waitfunc() {
  level endon("game_ended");
  level endon("cancel_public_event");
  _id_98489428013A0100 = calculateeventstarttime();
  wait(_id_98489428013A0100);
}

activatefunc() {
  level endon("game_ended");
  pauseallgulagfights(1);
  waitforgulagfightstocomplete();
  _id_337BD370F7C5E6F9::showsplashtoall("br_pe_jailbreak_incoming");
  playjailbreakvo("incoming");
  eventduration = getdvarfloat("scr_br_pe_jailbreak_duration", 30.0);
  _id_91A988004AA42D31 = gettime() + eventduration * 1000;
  setomnvar("ui_publicevent_timer_type", 2);
  setomnvar("ui_publicevent_timer", _id_91A988004AA42D31);
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();

  if(eventduration > 5.0) {
    wait(eventduration - 5.0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
      _id_FC7BD6576D8C85BE playSound("ui_mp_fire_sale_timer");
      wait 1.0;
    }
  }

  _id_337BD370F7C5E6F9::showsplashtoall("br_pe_jailbreak_active");
  playjailbreakvo("now");
  setomnvar("ui_publicevent_timer_type", 0);
  _id_FC7BD6576D8C85BE delete();
  wait 1.0;
  _id_827C53020F6F228F = getdvarint("dvar_C622900A5FA1E2C6", 1);
  playerlist = buildrespawnlist(_id_827C53020F6F228F);
  respawnplayers(playerlist);
  logstring("entering waitForGulagEvacuation");
  _id_E118855051028B96(playerlist);
  logstring("exit waitForGulagEvacuation");
  pauseallgulagfights(0);
}

calculateeventstarttime() {
  _id_87940078241E4580 = getdvarfloat("scr_br_pe_jailbreak_starttime_min", 795.0);
  _id_07AF9598177DC2DE = getdvarfloat("scr_br_pe_jailbreak_starttime_max", 1110.0);

  if(_id_07AF9598177DC2DE > _id_87940078241E4580)
    return randomfloatrange(_id_87940078241E4580, _id_07AF9598177DC2DE);
  else
    return _id_87940078241E4580;
}

pauseallgulagfights(_id_1FD0410E54D2FFD8) {
  _id_67708F418B1FAC79::pausegulag(_id_1FD0410E54D2FFD8);
}

waitforgulagfightstocomplete() {
  level endon("game_ended");
  wait 1.0;

  for(;;) {
    if(!_id_67708F418B1FAC79::areanygulagfightsactive()) {
      break;
    }

    waitframe();
  }
}

_id_E118855051028B96(playerlist) {
  level endon("game_ended");

  if(_id_362C58E8BB39BCDA::isfeaturedisabled("gulag")) {
    return;
  }
  _id_86AED7A38259CFF7 = playerlist.size == 0;

  while(!_id_86AED7A38259CFF7) {
    waitframe();

    foreach(index, arena in level.gulag.arenas) {
      _id_86AED7A38259CFF7 = scripts\engine\utility::array_intersection(arena.jailedplayers, playerlist).size == 0;

      if(!_id_86AED7A38259CFF7) {
        break;
      }
    }
  }
}

buildrespawnlist(_id_827C53020F6F228F) {
  respawnplayers = [];
  _id_A11643FDEEDEE81B = isDefined(level.gulag) && (!istrue(level.gulag.shutdown) || scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73());

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(_id_F90358454413407F == "spectator" || _id_F90358454413407F == "codcaster") {
      continue;
    }
    _id_6BA9B6124F692DFA = level.teamdata[_id_F90358454413407F]["aliveCount"] > 0;

    if(_id_827C53020F6F228F)
      _id_6BA9B6124F692DFA = level.teamdata[_id_F90358454413407F]["teamCount"] > 0;

    if(_id_6BA9B6124F692DFA) {
      foreach(player in level.teamdata[_id_F90358454413407F]["players"]) {
        _id_87FE48F5F9047E82 = _id_A11643FDEEDEE81B && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag();

        if(!isalive(player) && !_id_87FE48F5F9047E82) {
          respawnplayers[respawnplayers.size] = player;
          continue;
        }

        if(isalive(player) && _id_87FE48F5F9047E82) {
          respawnplayers[respawnplayers.size] = player;
          continue;
        }

        if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B() && !isalive(player) && _id_87FE48F5F9047E82)
          respawnplayers[respawnplayers.size] = player;
      }
    }
  }

  return respawnplayers;
}

respawnplayer() {
  _id_1B7F5108008D55B6 = isalive(self) && isDefined(level.gulag) && !istrue(level.gulag.shutdown) && _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag();

  if(_id_1B7F5108008D55B6)
    thread _id_67708F418B1FAC79::jailbreakeventplayer();
  else if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("jailbreakRevivePlayer"))
    thread _id_362C58E8BB39BCDA::runbrgametypefunc("jailbreakRevivePlayer");
  else
    thread _id_67708F418B1FAC79::playergulagautowin("jailbreak", undefined, undefined, 1, 1);

  self notify("jailbreak_respawn");

  if(_id_5BC60484D17FA95C::_id_1980065CE4DC067B()) {
    arena = _id_3583FF375AB3A91E::_id_2F4344ABDC200E43(self);

    if(!isDefined(arena))
      arena = _id_3583FF375AB3A91E::_id_DE20B194B1A37513(self);

    if(isDefined(arena)) {
      if(scripts\engine\utility::array_contains(arena.arenaplayers, self))
        arena.arenaplayers = scripts\engine\utility::array_remove(arena.arenaplayers, self);
      else if(scripts\engine\utility::array_contains(arena.jailedplayers, self))
        arena.jailedplayers = scripts\engine\utility::array_remove(arena.jailedplayers, self);

      if(isDefined(arena._id_654C981854394718)) {
        if(scripts\engine\utility::array_contains(arena._id_654C981854394718, self))
          arena._id_654C981854394718 = scripts\engine\utility::array_remove(arena._id_654C981854394718, self);
      }

      _id_67708F418B1FAC79::playerdestroyhud(arena);
      _id_67708F418B1FAC79::updatematchqueuepositions(arena);

      if(_id_03AA8E63A56E3416::_id_6E3541FD8FAB45BC())
        _id_03AA8E63A56E3416::_id_CC5468BB6E866411(arena);
    }
  }

  if(!isbot(self) && scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    self _meth_DB073176839D77FB("373", [32, 1, 106, _id_1B7F5108008D55B6]);
}

respawnplayers(playerlist) {
  level endon("game_ended");

  foreach(player in playerlist) {
    if(!isDefined(player)) {
      continue;
    }
    player thread respawnplayer();
    waitframe();
  }
}

playjailbreakvo(aliasname) {
  activeplayers = [];
  _id_F7A309109C19A8EB = [];
  _id_5624BF9A85CE0294 = [];
  _id_A11643FDEEDEE81B = isDefined(level.gulag) && !istrue(level.gulag.shutdown);
  _id_827C53020F6F228F = getdvarint("dvar_C622900A5FA1E2C6", 1);

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_6BA9B6124F692DFA = level.teamdata[_id_F90358454413407F]["aliveCount"] > 0;

    if(_id_827C53020F6F228F)
      _id_6BA9B6124F692DFA = level.teamdata[_id_F90358454413407F]["teamCount"] > 0;

    if(_id_6BA9B6124F692DFA) {
      foreach(player in level.teamdata[_id_F90358454413407F]["players"]) {
        _id_87FE48F5F9047E82 = _id_A11643FDEEDEE81B && player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag();

        if(!isalive(player) && !_id_87FE48F5F9047E82) {
          _id_5624BF9A85CE0294[_id_5624BF9A85CE0294.size] = player;
          continue;
        }

        if(isalive(player) && _id_87FE48F5F9047E82) {
          _id_F7A309109C19A8EB[_id_F7A309109C19A8EB.size] = player;
          continue;
        }

        if(isalive(player))
          activeplayers[activeplayers.size] = player;
      }
    }
  }

  if(activeplayers.size > 0) {
    _id_45E1DF88D472EFF6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "_active", "_active_alt");
    _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_jailbreak_" + aliasname + _id_45E1DF88D472EFF6, 0, activeplayers, 1);
  }

  if(_id_F7A309109C19A8EB.size > 0) {
    _id_35C7A746AA1C8E9E = "_gulag";
    _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_jailbreak_" + aliasname + _id_35C7A746AA1C8E9E, 0, _id_F7A309109C19A8EB, 1);
  }

  if(_id_5624BF9A85CE0294.size > 0) {
    _id_D3DC73C3AAFD6303 = "_spectate";
    _id_2CEDCC356F1B9FC8::brleaderdialog("public_events_jailbreak_" + aliasname + _id_D3DC73C3AAFD6303, 0, _id_5624BF9A85CE0294, 1);
  }
}