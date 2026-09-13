/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_75377e59f5becac8.gsc
***********************************************/

main() {
  _id_7933519955F32C4E::init();

  if(_id_7933519955F32C4E::_id_B4E9D46918F067BB()) {
    return;
  }
  level.infilstruct = spawnStruct();
  level.infilstruct.players = [];

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1) {
    _id_17734C5E8A84C65A(0, "prematch", ::_id_548EAACFE34B28E1);
    _id_17734C5E8A84C65A(1, "fadedown", ::_id_0D2E5A4473E27019);
    _id_17734C5E8A84C65A(2, "streaming", ::_id_6E7A11C7804FE019);
    _id_17734C5E8A84C65A(3, "cinematic", ::_id_C6DC2C9535E1FAC8);

    if(_id_7812117B17C4D21E() == "s5_reveal_event")
      _id_17734C5E8A84C65A(4, "animatic", ::_id_6CC48D378966BC2F);
    else
      _id_17734C5E8A84C65A(4, "animatic", ::_id_C1E0D339C6959B81);

    _id_17734C5E8A84C65A(5, "flyover", ::_id_2923788BC736BB9E);
    _id_17734C5E8A84C65A(6, "done", ::_id_ABB2B783F6044BB3);
  } else {
    _id_17734C5E8A84C65A(0, "prematch", ::_id_548EAACFE34B28E1);
    _id_17734C5E8A84C65A(1, "fadedown", ::_id_0D2E5A4473E27019);
    _id_17734C5E8A84C65A(2, "streaming", ::_id_D23657823446B3A1);
    _id_17734C5E8A84C65A(3, "cinematic", ::_id_C6DC2C9535E1FAC8);
    _id_17734C5E8A84C65A(4, "animatic", ::_id_6CC48D378966BC2F);
    _id_17734C5E8A84C65A(5, "flyover", ::_id_2923788BC736BB9E);
    _id_17734C5E8A84C65A(6, "done", ::_id_ABB2B783F6044BB3);
  }

  _id_0FE85C23FC6FA8C2();
  _id_C03893A40366ED07();
  level thread _id_891DC8F3BB2A44AA();
}

_id_891DC8F3BB2A44AA() {
  level endon("game_ended");
  level endon("kill_state_machine");
  level._id_90481FB292A83C2B = undefined;
  waitframe();
  _id_F4DB5B4567F88914 = 0;

  for(;;) {
    if(!isDefined(level._id_90481FB292A83C2B))
      _id_998696BEBD7661FD(_id_F4DB5B4567F88914);
    else
      _id_998696BEBD7661FD(level._id_90481FB292A83C2B + 1);

    if(level._id_90481FB292A83C2B == 6) {
      break;
    }
  }
}

_id_5AE4A89BD5803649() {
  level notify("kill_state_machine");
}

_id_17734C5E8A84C65A(_id_8F187C4FD84A5AAA, statename, _id_3F1BC3E031A251E4) {
  if(!isDefined(level._id_DA14B46DAE9397EB))
    level._id_DA14B46DAE9397EB = [];

  _id_9B1941CB7354665E = spawnStruct();
  _id_9B1941CB7354665E.name = statename;
  _id_9B1941CB7354665E._id_3F1BC3E031A251E4 = _id_3F1BC3E031A251E4;
  level._id_DA14B46DAE9397EB[_id_8F187C4FD84A5AAA] = _id_9B1941CB7354665E;
}

_id_998696BEBD7661FD(_id_8F187C4FD84A5AAA) {
  level._id_90481FB292A83C2B = _id_8F187C4FD84A5AAA;
  _id_69466217DFAB45FE = level._id_DA14B46DAE9397EB[level._id_90481FB292A83C2B];

  if(isDefined(level.infilstruct._id_E7C7DE60A5EA2F52[_id_69466217DFAB45FE.name]))
    [[level.infilstruct._id_E7C7DE60A5EA2F52[_id_69466217DFAB45FE.name]]]();

  if(isDefined(_id_69466217DFAB45FE._id_3F1BC3E031A251E4))
    [[_id_69466217DFAB45FE._id_3F1BC3E031A251E4]]();
}

_id_548EAACFE34B28E1() {
  c130pathstruct = undefined;

  if(!istrue(level.br_infils_disabled) && !istrue(level._id_59FF09549058DDA2)) {
    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("createC130PathStruct"))
      c130pathstruct = _id_362C58E8BB39BCDA::runbrgametypefunc("createC130PathStruct", level.infilstruct._id_B2D2EEC29DBABA05);
    else
      c130pathstruct = _id_45B2B4A889E633FA::createtestc130path(level._id_B88975A1F2A5E092, undefined, level.infilstruct._id_B2D2EEC29DBABA05);
  }

  level.infilstruct.c130pathstruct = c130pathstruct;

  if(!istrue(level.prematchstarted))
    level waittill("prematch_started");

  if(istrue(level.br_infils_disabled)) {
    level.infilstruct.players = _id_0A34750D17473C49::_id_22A0E95DD4174C81();
    scripts\mp\flags::gameflagset("prematch_fade_done");
    waitframe();
    level.allowprematchdamage = 0;
    forcespawnplayers(level.infilstruct.players);
    _id_EC7FE6E7834D5D70();

    if(!_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
      level.disablespawning = 1;
      setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_numLives"), 1);
    }

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      player.plotarmor = undefined;
    }

    scripts\mp\flags::gameflagset("br_ready_to_jump");
    _id_5AE4A89BD5803649();
  } else if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("infilSequence")) {
    _id_362C58E8BB39BCDA::runbrgametypefunc("infilSequence");
    scripts\mp\flags::gameflagset("br_ready_to_jump");
    _id_5AE4A89BD5803649();
  }
}

_id_0D2E5A4473E27019() {
  if(isDefined(level._id_C5877DBE60FDDBF6)) {
    foreach(_id_D40DF2F2B26ADA41 in level._id_C5877DBE60FDDBF6) {
      _id_D40DF2F2B26ADA41 setclientomnvar("ui_br_infil_started", 1);
      _id_D40DF2F2B26ADA41 setclientomnvar("ui_br_infiled", 0);
    }
  }

  _id_45B2B4A889E633FA::spawnc130(level.infilstruct._id_FD05DC031A2E7283, level.infilstruct._id_30E653E12F358438, level.infilstruct._id_C3A4F4442070A8B5, level.infilstruct.c130pathstruct, level.infilstruct._id_A6547E85663B3BC2, level.infilstruct._id_7A96307B6A7ED797);
  level.infilstruct.c130 = level.br_ac130;
  _id_8252134BB4AAA66B();
  scripts\mp\deathicons::removealldeathicons();
  setomnvar("ui_hide_player_icons", 1);
  level.br_c130spawndone = 0;
  level.infiltransistioning = 1;
  level.infilcinematicactive = 1;
  level.allowprematchdamage = 0;
  level.infilstruct.players = _id_0A34750D17473C49::_id_22A0E95DD4174C81();

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_38F6E236E493C28B();
  }

  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_540BAB0E9A607717);
  level.infilstruct.c130 thread gunship_updateplayercount();
  _id_0930A1E7BD882C1D::waitandpause(1);
  waitframe();
}

_id_38F6E236E493C28B() {
  self setallstreamloaddist(-1.0);
  self _meth_BC667001F9DD3808(level.infilstruct.c130.origin);
  _id_179AD01817AE940B(level.infilstruct.c130);
  _id_1B7E57BFE648F609();
  _id_0930A1E7BD882C1D::_id_10F93BB3F3966751(1, "stateMachine");
  self setclientdvar("dvar_B21F1157C582FF15", 0);
}

_id_540BAB0E9A607717() {
  self endon("disconnect");
  _id_38F6E236E493C28B();
  _id_0930A1E7BD882C1D::waitandpause(1);
  waitframe();
}

_id_179AD01817AE940B(c130) {
  self.c130 = c130;

  if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    scripts\mp\utility\player::hidehudenable();

  scripts\mp\class::blockclasschange();
}

gunship_updateplayercount() {
  level endon("game_ended");
  self notify("ac130_player_count");
  self endon("ac130_player_count");
  level.infilstruct.playersinc130 = 0;

  for(;;) {
    setomnvar("ui_br_players_left_in_plane", level.infilstruct.playersinc130);

    if(!isDefined(self)) {
      break;
    }

    wait 0.5;
  }
}

_id_D23657823446B3A1() {
  _id_46AF76764B1FC7F0::emptyallvehicles();
  setomnvar("ui_in_infil", 1);
  scripts\mp\flags::gameflagset("prematch_fade_done");

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      player setclientomnvar("ui_options_menu", 0);
  }

  forcespawnplayers(level.infilstruct.players, level.infilstruct.c130.origin, level.infilstruct.c130);
  level.snatchspawnalltoc130done = 1;
  _id_EC7FE6E7834D5D70();

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_numLives"), 1);
  }

  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_F6248665C763B00F);
  _id_0930A1E7BD882C1D::waitandpause(1.5);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!istrue(level.infilstruct._id_2A959F4BA13B75DA))
      player clearpredictedstreampos();

    player _id_0930A1E7BD882C1D::endprematchskydiving();
    player.br_isininfil = 1;

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      player setclientomnvar("ui_options_menu", -1);
  }

  _id_0930A1E7BD882C1D::_id_583F118C4064CA21(level.infilstruct.players);
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_C3D1219A613EBCDF);
}

_id_6E7A11C7804FE019() {
  _id_D23657823446B3A1();
  waittime = getdvarfloat("dvar_FF017DF91BBCE1B3", 10);
  _id_71B179643F3088FE = _func_425D34DDD114F3DE();

  while(level.players.size < _id_71B179643F3088FE) {
    waittime = waittime - level.framedurationseconds;

    if(waittime < 0) {
      break;
    }

    waitframe();
  }

  if(getdvarint("dvar_9BE38B3A8782259C", 0) == 1) {
    return;
  }
  wait(getdvarfloat("dvar_FBE5AB97A6675878", 10));
  _func_D5131497D473CB79("");

  foreach(player in level.players)
  player setsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2.0);

  setomnvar("ui_in_infil", 3);
  wait(getdvarfloat("dvar_A707D8E7BCD8E3A7", 118));

  foreach(player in level.players) {
    player clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2.0);
    player clearsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 2.0);
  }
}

_id_F6248665C763B00F() {
  self endon("disconnect");
  forcespawnplayers([self], level.infilstruct.c130.origin, level.infilstruct.c130);
  _id_D392B52249D2A8FE();
}

_id_C3D1219A613EBCDF() {
  self endon("disconnect");
  self clearpredictedstreampos();
  _id_0930A1E7BD882C1D::endprematchskydiving();
  self.br_isininfil = 1;
  _id_0930A1E7BD882C1D::_id_423115ED15F21E05(self.team);
}

_id_2FD95FB465CF24FE() {
  self endon("disconnect");

  if(self.class == "") {
    self.class = "custom1";
    self.pers["class"] = "custom1";
  }

  scripts\mp\playerlogic::spawnplayer(0);
  self.br_infilstarted = 1;
  self notify("brWaitAndSpawnClientComplete");
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

forcespawnplayers(players, spawnorigin, _id_F60347F29FEEC261) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isDefined(player.team) || player.team == "spectator" || player.team == "codcaster") {
      continue;
    }
    _id_182038C1B0416C06 = player.origin;
    player _id_0930A1E7BD882C1D::endprematchskydiving();
    player clearladderstate();

    if(isalive(player))
      player _meth_D87E1768229D0E3E();

    if(!istrue(level.br_infils_disabled)) {
      player _id_1E4A61DB11011446::playerexecutionsdisable();
      player _id_3B64EB40368C1450::set("br_infil", "offhand_throwback", 0);
    }

    player _id_07C40FA80892A721::givestartingarmor();

    if(!isalive(player)) {
      if(istrue(player.waitingtospawnamortize)) {
        player scripts\engine\utility::waittill_either("spawned_player", "disconnect");

        if(isDefined(player) && isDefined(spawnorigin))
          player setOrigin(spawnorigin);
      } else {
        if(isDefined(spawnorigin))
          player.forcespawnorigin = spawnorigin;

        player _id_2FD95FB465CF24FE();
      }
    } else if(isDefined(spawnorigin))
      player setOrigin(spawnorigin);

    if(!isDefined(player)) {
      continue;
    }
    player.br_infilstarted = 1;
    player thread[[level.parachutetakeweaponscb]]();
    player.plotarmor = 1;

    if(isDefined(_id_F60347F29FEEC261)) {
      player playerlinkTo(_id_F60347F29FEEC261);
      player.c130 = _id_F60347F29FEEC261;

      if(_id_60597DA56F99D304(player)) {
        player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
        player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_common::forceSpawnPlayers()");
      }
    }

    if(istrue(player.br_iseliminated))
      _id_0A34750D17473C49::unmarkplayeraseliminated(player, "forceSpawnPlayers");

    if(isDefined(spawnorigin))
      _id_362C58E8BB39BCDA::_id_D72AFACCEDFC946E("onPlayerTeleport", player, _id_182038C1B0416C06, spawnorigin, "c130");

    player notify("beginC130");
  }
}

_id_EC7FE6E7834D5D70() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("squadLeader")) {
    return;
  }
  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(team, "players");
      _id_FC8439660D24B9C4 = _id_0930A1E7BD882C1D::setupbrsquadleader(_id_A6AB8D0FDA441DC2);

      if(isDefined(_id_FC8439660D24B9C4)) {
        _id_0930A1E7BD882C1D::registerbrsquadleaderjumpcommands(_id_FC8439660D24B9C4);
        _id_FC8439660D24B9C4 thread _id_0930A1E7BD882C1D::watchbrsquadleaderdisconnect(team);
      }

      _id_1E4A61DB11011446::updatesquadleaderpassstateforteam(team);
    }
  } else {
    foreach(player in level.infilstruct.players) {
      if(isDefined(player))
        _id_0930A1E7BD882C1D::registerbrsquadleaderjumpcommands(player);
    }
  }
}

_id_D392B52249D2A8FE() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("squadLeader")) {
    return;
  }
  if(level.teambased) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(self.team, "players");
    _id_FC8439660D24B9C4 = _id_0930A1E7BD882C1D::setupbrsquadleader(_id_A6AB8D0FDA441DC2);

    if(isDefined(_id_FC8439660D24B9C4)) {
      _id_0930A1E7BD882C1D::registerbrsquadleaderjumpcommands(_id_FC8439660D24B9C4);
      _id_FC8439660D24B9C4 thread _id_0930A1E7BD882C1D::watchbrsquadleaderdisconnect(self.team);
    }

    _id_1E4A61DB11011446::updatesquadleaderpassstateforteam(self.team);
  } else
    _id_0930A1E7BD882C1D::registerbrsquadleaderjumpcommands(self);
}

_id_C6DC2C9535E1FAC8() {
  _id_EC4400561E6BE23A();
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_9215BF6C0287802C);
  _id_0749C46213CDB834();
}

_id_9215BF6C0287802C() {
  self endon("disconnect");
  _id_12CCCCD25DAFE834();
}

_id_6CC48D378966BC2F() {
  _id_1696E6E3AC4A370A();
  _id_0930A1E7BD882C1D::_id_7F3AD8FE6DF1B8FE(1, level.infilstruct.players, "stateMachine");
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_32583056E04E8645);
  _id_8D001511B174EF1E();
}

_id_C1E0D339C6959B81() {
  _id_1696E6E3AC4A370A();
  _id_0930A1E7BD882C1D::_id_7F3AD8FE6DF1B8FE(1, level.infilstruct.players, "stateMachine");
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_6EE3F813B3C2D7AF);
  level.infilstruct.c130.animstruct _id_27AFD7662BC38A81::_id_5DBA404B985C7D41();
  level.br_ac130 setscriptablepartstate("running_lights", "on");
  level.br_ac130 notify("start_moving");
  level.infilstruct._id_3174C6E96B5630D8 = spawn("script_model", level.infilstruct.c130.origin);
  level.infilstruct._id_3174C6E96B5630D8 setModel("tag_origin");
  level.infilstruct._id_3174C6E96B5630D8.angles = level.infilstruct.c130.angles + (20, 0, 0);

  foreach(_id_07246E37824518C4 in level.infilstruct.players) {
    _id_07246E37824518C4 cameraunlink();
    _id_07246E37824518C4 cameralinkTo(level.infilstruct._id_3174C6E96B5630D8, "tag_origin");
  }

  wait 0.2;
}

_id_6EE3F813B3C2D7AF() {
  _id_0930A1E7BD882C1D::_id_1162DBFDB942D179(1, "stateMachine");
}

_id_32583056E04E8645() {
  self endon("disconnect");
  self notify("beginC130");
  _id_0930A1E7BD882C1D::_id_1162DBFDB942D179(1, "stateMachine");

  if(isDefined(level.infilstruct._id_410EB50B35457227))
    [[level.infilstruct._id_410EB50B35457227]](self);
  else
    _id_0930A1E7BD882C1D::_id_6D8AC534AD288AA5(self);

  scripts\mp\utility\player::_freezelookcontrols(1);
  _id_2739B8C6B038BA5E = undefined;

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.animstruct))
    _id_2739B8C6B038BA5E = level.infilstruct.animstruct._id_2739B8C6B038BA5E;

  if(isDefined(_id_2739B8C6B038BA5E._id_EEDB5FB15EB26BFA))
    level.infilstruct.animstruct[[_id_2739B8C6B038BA5E._id_EEDB5FB15EB26BFA]](self, _id_2739B8C6B038BA5E._id_5AB13B55D7CEFF80);

  if(_id_2739B8C6B038BA5E._id_79D924275E2B5029) {
    scripts\mp\utility\player::_freezelookcontrols(0);
    _id_2739B8C6B038BA5E _id_8839D2F2F530A0B9(self);
    wait 1.0;
    self cameraunlink();
    self _meth_8FF8FD7841F6EBA2();
    thread _id_45B2B4A889E633FA::orbitcam(level.infilstruct.c130);
    _id_0930A1E7BD882C1D::_id_423115ED15F21E05(self.team);
  } else {
    self cameraunlink();
    self _meth_8FF8FD7841F6EBA2();
    _id_2739B8C6B038BA5E _id_BDA88F27A0337EAA(self);
    _id_2739B8C6B038BA5E _id_8839D2F2F530A0B9(self);

    if(_id_60597DA56F99D304(self)) {
      scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
      scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_common::state_animatic_playerLateJoin()");
    }
  }
}

_id_2923788BC736BB9E() {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_25A0C882B7E8BB02();

    if(player isplayerheadless())
      registerheadlessinfil(player);
  }

  if(isDefined(level._id_C5877DBE60FDDBF6)) {
    foreach(_id_D40DF2F2B26ADA41 in level._id_C5877DBE60FDDBF6)
    _id_D40DF2F2B26ADA41 setclientomnvar("ui_br_infiled", 1);
  }

  level.br_ac130 _id_362C58E8BB39BCDA::runbrgametypefunc("addToC130Infil");
  _id_0930A1E7BD882C1D::_id_6199C35F4CF4524C(::_id_D2540EA30A17F53A);
  setomnvar("ui_in_infil", -1);
  level.infiltransistioning = undefined;
  level.infilcinematicactive = 0;
  scripts\mp\flags::gameflagset("infil_animatic_complete");
  level thread _id_C22E838CAF108BB0();

  if(isDefined(level.headlessinfilplayers))
    level thread _id_012D78457EDD58DE();

  _id_9F3146807EA18258();
  level waittill("br_c130_left_bounds");
}

_id_25A0C882B7E8BB02() {
  self setallstreamloaddist(0.0);
  _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();

  if(!istrue(level.infilstruct._id_EB0E85A583F21B9D)) {
    self setclientdvar("cg_fov", 65);
    self setclientdvar("dvar_86BF34D5F48FA435", 65);

    if(!istrue(level.infilstruct._id_012C912EE9672FA1))
      self setclientdvar("dvar_71C6C0B8428E44A7", 0);

    self disablephysicaldepthoffieldscripting();
    scripts\mp\utility\player::setdof_default();
  }

  self.instantclassswapallowed = 1;
  scripts\mp\class::unblockclasschange();

  if(_id_1E4A61DB11011446::get_int_or_0(self.hidehudenabled) > 0)
    scripts\mp\utility\player::hidehuddisable();

  self visionsetfadetoblackforplayer("", 1.0);
  self notify("joining_Infil");
  self.br_infilstarted = 1;

  if(!istrue(level.c130inbounds))
    self setclientomnvar("ui_hide_minimap", 1);

  self.health = self.maxhealth;
  self cameraunlink();
  self _meth_8FF8FD7841F6EBA2();
  _id_45B2B4A889E633FA::spawnplayertoc130();
  playersetupcontrolsforinfil();

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1) {
    setomnvar("ui_reveal_mute_players", 0);
    scripts\engine\utility::delaythread(5.0, _id_0930A1E7BD882C1D::_id_4238C1C62B656B65);
  }

  _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("isInInfilPlane", 1);
  level.infilstruct.playersinc130++;
  _id_2CEDCC356F1B9FC8::_id_64FA4C213439177F();
  thread playercleanupinfilondisconnect();
}

_id_C22E838CAF108BB0() {
  _id_2CEDCC356F1B9FC8::brleaderdialog("match_start", 0, level.infilstruct.players, undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
  level thread _id_45B2B4A889E633FA::waittoplayinfildialog();

  if(istrue(level.brgametype._id_98ADE9E8627AF484) && isDefined(game["dialog"]["offense_obj"])) {
    _id_CB3339ECE72DBDEB = _id_2CEDCC356F1B9FC8::_id_93550B34F0A49DD9("match_start", level.infilstruct.players[0], level.brgametype._id_B09B7AFE082A9239);

    if(isDefined(_id_CB3339ECE72DBDEB)) {
      _id_1499E7C2D69E0074 = lookupsoundlength(_id_CB3339ECE72DBDEB, 1) / 1000.0;
      wait(_id_1499E7C2D69E0074 + 1.0);
    }

    _id_2CEDCC356F1B9FC8::brleaderdialog("offense_obj", 0, level.infilstruct.players, undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
  }
}

_id_D2540EA30A17F53A() {
  self endon("disconnect");
  _id_25A0C882B7E8BB02();
  thread watchinfiljumpanim();
  _id_2CEDCC356F1B9FC8::brleaderdialog("match_start", 0, [self], undefined, undefined, undefined, level.brgametype._id_B09B7AFE082A9239);
  scripts\mp\utility\player::_freezelookcontrols(0);
  self cameraunlink();
  self _meth_8FF8FD7841F6EBA2();
  thread _id_45B2B4A889E633FA::orbitcam(level.infilstruct.c130);
  _id_0930A1E7BD882C1D::_id_423115ED15F21E05(self.team);
}

_id_ABB2B783F6044BB3() {
  if(isDefined(level.infilstruct._id_3174C6E96B5630D8))
    level.infilstruct._id_3174C6E96B5630D8 delete();

  _id_BEE6776DBF711484();
}

registerheadlessinfil(player) {
  if(!isDefined(level.headlessinfilplayers))
    level.headlessinfilplayers = [];

  level.headlessinfilplayers[level.headlessinfilplayers.size] = player;
}

_id_012D78457EDD58DE() {
  level endon("game_ended");
  dist = distance(level.br_ac130.pathstruct.startpt, level.br_ac130.pathstruct.endpt);
  time = dist / _id_45B2B4A889E633FA::getc130speed() / level.headlessinfilplayers.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.headlessinfilplayers.size; _id_AC0E594AC96AA3A8++) {
    wait(time);
    level.headlessinfilplayers[_id_AC0E594AC96AA3A8] notify("halo_jump_c130");
  }

  level.headlessinfilplayers = undefined;
}

playersetupcontrolsforinfil(_id_A19E18E7CC768828) {
  if(!isDefined(_id_A19E18E7CC768828))
    _id_A19E18E7CC768828 = 0;

  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_br_infiled", 0);

  if(!_id_A19E18E7CC768828) {
    self notifyonplayercommand("halo_jump_c130", "+gostand");

    if(!isbot(self))
      self notifyonplayercommand("halo_jump_parachute_c130", "+open_parachute");
  } else {
    self notifyonplayercommand("halo_jump_solo_c130", "+gostand");

    if(!isbot(self))
      self notifyonplayercommand("halo_jump_parachute_solo_c130", "+open_parachute");
  }

  self notifyonplayercommand("br_pass_squad_leader", "+usereload");
  self notifyonplayercommand("br_pass_squad_leader", "+activate");
}

playercleanupinfilondisconnect() {
  level endon("game_ended");
  self endon("death");
  self endon("cancel_c130");
  self endon("br_jump");
  self waittill("disconnect");

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.playersinc130) && level.infilstruct.playersinc130 > 0)
    level.infilstruct.playersinc130--;
}

_id_9F3146807EA18258() {
  level.infiljumpentsspawned = 0;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player thread watchinfiljumpanim();
  }
}

playjumpsoundtosquad() {
  aliasname = "evt_br_infil_squadmate_jump";

  if(_id_2CEDCC356F1B9FC8::isplayerbrsquadleader())
    aliasname = "evt_br_infil_squad_leader_jump";

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1) {
    foreach(player in scripts\mp\utility\teams::_id_3D0F2343793D709B(self.team, self._id_0FF97225579DE16A))
    player playsoundtoplayer(aliasname, self);
  } else
    self playsoundtoteam(aliasname, self.team, self);
}

_id_DD86C05DAA1432C3() {
  self endon("disconnect");
  wait 5;
  self setclientdvar("dvar_B21F1157C582FF15", 1);
}

watchinfiljumpanim() {
  self endon("death_or_disconnect");
  self.hasspawnweapons = 0;
  self waittill("br_jump");

  if(isDefined(level.infilstruct._id_8D5C19A9B693E913))
    self thread[[level.infilstruct._id_8D5C19A9B693E913]]();

  _id_A2117EA816A8B7F1 = getdvarint("dvar_8BE4ACC5EEBB19CA", 1) != 0;

  if(level.infiljumpentsspawned >= 100)
    _id_A2117EA816A8B7F1 = 0;

  _id_77B785278F139079 = undefined;

  if(_id_A2117EA816A8B7F1) {
    _id_77B785278F139079 = 0;
    [_id_8DEC95713EC1F7BA, _id_4D261EF98868B4E6, _id_66809387054FC02A, _id_D337825DF4506344] = [[level.infilstruct._id_AE9E4023110ACC6E]]();
    _id_539C2DCC0A467746 = level.infilstruct.c130;

    if(isDefined(level.infilstruct.animstruct) && istrue(level.infilstruct.animstruct._id_C978F36E30808108))
      _id_539C2DCC0A467746 = level.infilstruct.animstruct.c130;

    _id_9B145EB55513DBB5["parent"] = spawn("script_model", _id_539C2DCC0A467746.origin);
    level.infiljumpentsspawned++;
    _id_9B145EB55513DBB5["parent"] setModel("generic_prop_x10");
    _id_9B145EB55513DBB5["parent"] forcenetfieldhighlod(1);
    _id_9B145EB55513DBB5["parent"] linkTo(_id_539C2DCC0A467746, "tag_body", (0, 0, 0), (0, 0, 0));
    _id_9B145EB55513DBB5[_id_D337825DF4506344] = spawn("script_model", _id_9B145EB55513DBB5["parent"] gettagorigin(_id_D337825DF4506344));
    level.infiljumpentsspawned++;
    _id_9B145EB55513DBB5[_id_D337825DF4506344] setModel("tag_player");
    _id_9B145EB55513DBB5[_id_D337825DF4506344] forcenetfieldhighlod(1);
    _id_9B145EB55513DBB5[_id_D337825DF4506344] linkTo(_id_9B145EB55513DBB5["parent"], _id_D337825DF4506344, (0, 0, 0), (0, 0, 0));
    self playerlinkTo(_id_9B145EB55513DBB5[_id_D337825DF4506344], "tag_player");
    scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);
    self playanimscriptsceneevent("scripted_scene", _id_66809387054FC02A);
    self.infilanimindex = undefined;
    self._id_DB122A8941DFEE14 = undefined;
    self playlocalsound("evt_br_infil_jump_stinger");
    playjumpsoundtosquad();

    if(getdvarint("dvar_2BE93DD484220A45", 0) == 1) {
      self clearsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 2.0);
      self setplayermusicstate("mx_jup_rvl_parachute_jump");
    }

    _id_9B145EB55513DBB5["parent"] scriptmodelplayanim(_id_8DEC95713EC1F7BA, "prop");
    _id_7A79E5C326955318 = getanimlength(_id_4D261EF98868B4E6);
    _id_886F7978500ACB10 = 1.0;
    _id_7A79E5C326955318 = max(_id_7A79E5C326955318, _id_886F7978500ACB10 + 0.1);
    wait(_id_7A79E5C326955318 - _id_886F7978500ACB10);
    self cameradefault();

    if(isDefined(level.infilstruct._id_DC0BC83A31193177))
      self thread[[level.infilstruct._id_DC0BC83A31193177]]();

    thread _id_DD86C05DAA1432C3();
    wait(_id_886F7978500ACB10);

    foreach(ent in _id_9B145EB55513DBB5) {
      ent delete();
      level.infiljumpentsspawned--;
    }
  } else {
    _id_77B785278F139079 = 1;
    waittillframeend;
    thread _id_DD86C05DAA1432C3();
  }

  self.infilanimindex = undefined;
  self._id_DB122A8941DFEE14 = undefined;
  self stopanimscriptsceneevent();
  self notify("infil_jump_done");
  _id_1E4A61DB11011446::playerexecutionsenable();
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("br_infil");

  if(_id_77B785278F139079) {
    waitframe();

    if(isDefined(level.infilstruct.c130)) {
      if(isDefined(level.infilstruct.c130.playeroffsets) && isDefined(level.infilstruct.c130.currentplayeroffset)) {
        offset = level.infilstruct.c130.playeroffsets[level.infilstruct.c130.currentplayeroffset];
        self setOrigin(level.infilstruct.c130.origin + offset, 1, 1);
        level.infilstruct.c130.currentplayeroffset++;

        if(level.infilstruct.c130.currentplayeroffset == level.infilstruct.c130.playeroffsets.size)
          level.infilstruct.c130.currentplayeroffset = 0;

        scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76(1);
        playjumpsoundtosquad();

        if(isDefined(level.infilstruct._id_DC0BC83A31193177))
          self thread[[level.infilstruct._id_DC0BC83A31193177]]();
      }
    }
  }
}

_id_B599EA9CE3625A9D(players) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    _id_E478AC91AF0E92CB = player getlinkedchildren();

    if(isDefined(_id_E478AC91AF0E92CB) && _id_E478AC91AF0E92CB.size) {
      _id_BC960AD5D6FB9318 = _id_E478AC91AF0E92CB.size;

      if(_id_BC960AD5D6FB9318 > 0) {
        message = "Infil Player (" + player.name + ") with (" + _id_BC960AD5D6FB9318 + ") linked ents: ";

        foreach(_id_6C82D947757D13D6 in _id_E478AC91AF0E92CB) {
          _id_8EE353D273E5B1D4 = _id_6C82D947757D13D6 _meth_67EA74BAB288A2B5();

          if(isDefined(_id_8EE353D273E5B1D4) && _id_8EE353D273E5B1D4.size > 0)
            message = message + ("stack:" + _id_8EE353D273E5B1D4 + ",");

          if(isDefined(_id_6C82D947757D13D6.equipmentref)) {
            message = message + ("equip:" + _id_6C82D947757D13D6.equipmentref + ",");
            continue;
          }

          if(isDefined(_id_6C82D947757D13D6.weapon_name)) {
            message = message + ("weapon:" + _id_6C82D947757D13D6.weapon_name + ",");
            continue;
          }

          if(isDefined(_id_6C82D947757D13D6.model)) {
            message = message + ("model:" + _id_6C82D947757D13D6.model + ",");
            continue;
          }

          message = message + "?,";
        }

        scripts\mp\utility\script::demoforcesre(message);
      }
    }
  }
}

_id_1696E6E3AC4A370A() {
  if(isDefined(level._id_9D615A366EC2FB6F))
    level._id_9D615A366EC2FB6F = undefined;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player notify("beginC130");
    _id_E478AC91AF0E92CB = player getlinkedchildren();

    foreach(_id_6C82D947757D13D6 in _id_E478AC91AF0E92CB) {
      if(isDefined(_id_6C82D947757D13D6.equipmentref) && _id_6C82D947757D13D6.equipmentref == "equip_molotov") {
        player scripts\mp\equipment\molotov::molotov_clear_burning(1);
        _id_6C82D947757D13D6 delete();
        continue;
      }

      if(isDefined(_id_6C82D947757D13D6.equipmentref) && _id_6C82D947757D13D6.equipmentref == "equip_thermite") {
        _id_6C82D947757D13D6 thread scripts\mp\equipment\thermite::thermite_destroy(1);
        continue;
      }

      if(isDefined(_id_6C82D947757D13D6.equipmentref) && _id_6C82D947757D13D6.equipmentref == "equip_shockstick")
        _id_6C82D947757D13D6 thread _id_0A35012B9B75A996::_id_0C44B639F5005AFA(1);
    }
  }

  if(isDefined(level.throwingknives)) {
    foreach(throwingknife in level.throwingknives) {
      if(isDefined(throwingknife))
        throwingknife thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_deletepickup();
    }
  }

  _id_B599EA9CE3625A9D(level.infilstruct.players);
}

_id_1B7E57BFE648F609() {
  _id_4F105563CA74CF73 = level.infilstruct._id_477BD548940C3A78;

  if(!isDefined(_id_4F105563CA74CF73)) {
    return;
  }
  self preloadcinematicforplayer(_id_4F105563CA74CF73);
}

_id_EC4400561E6BE23A() {
  _id_4F105563CA74CF73 = level.infilstruct._id_477BD548940C3A78;

  if(!isDefined(_id_4F105563CA74CF73)) {
    return;
  }
  thread scripts\mp\music_and_dialog::stopsuspensemusic();

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player playcinematicforplayer(_id_4F105563CA74CF73);
    player setclientomnvar("ui_br_bink_overlay_state", 3);
  }
}

_id_12CCCCD25DAFE834() {
  _id_4F105563CA74CF73 = level.infilstruct._id_477BD548940C3A78;

  if(!isDefined(_id_4F105563CA74CF73)) {
    return;
  }
  self setplayermusicstate("");
  self playcinematicforplayer(_id_4F105563CA74CF73);
  self setclientomnvar("ui_br_bink_overlay_state", 3);
}

infilvideocompletecallback(_id_7148C1A6F25491F8, val) {
  if(istrue(self._id_20A6DEFC94783931)) {
    return;
  }
  if(_id_7148C1A6F25491F8 == "bink_complete") {
    level notify("play_video_complete");
    self setclientomnvar("ui_br_bink_overlay_state", 0);
    self stopcinematicforplayer();
    self._id_20A6DEFC94783931 = 1;
  }
}

_id_0749C46213CDB834() {
  _id_4F105563CA74CF73 = level.infilstruct._id_477BD548940C3A78;

  if(!isDefined(_id_4F105563CA74CF73)) {
    return;
  }
  scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::infilvideocompletecallback);
  wait(level.infilstruct._id_10D27B439AF13A2A);
}

_id_19EA8F6D547DC8BC(player) {
  cameraent = self._id_2336099A20080602.ent;
  _id_1EDD840D40B43222 = undefined;

  if(isfunction(self._id_2336099A20080602._id_E6783D526B4A7212))
    _id_1EDD840D40B43222 = self[[self._id_2336099A20080602._id_E6783D526B4A7212]](player);
  else if(isarray(self._id_2336099A20080602._id_E6783D526B4A7212))
    _id_1EDD840D40B43222 = self._id_2336099A20080602._id_E6783D526B4A7212[player.infilanimindex - 1];
  else
    _id_1EDD840D40B43222 = self._id_2336099A20080602._id_E6783D526B4A7212;

  return [cameraent, _id_1EDD840D40B43222];
}

_id_FF03E352A5746185() {
  return isDefined(self._id_2336099A20080602._id_437B6BB41D98DF26);
}

_id_BDA88F27A0337EAA(player, _id_E45F1CD8436C9AA9) {
  [cameraent, _id_1EDD840D40B43222] = _id_19EA8F6D547DC8BC(player);

  if(_id_FF03E352A5746185()) {
    if(!istrue(_id_E45F1CD8436C9AA9)) {
      _id_437B6BB41D98DF26 = self._id_2336099A20080602._id_437B6BB41D98DF26;

      if(isDefined(self._id_2336099A20080602._id_75A7646007505356))
        _id_437B6BB41D98DF26 = self[[self._id_2336099A20080602._id_75A7646007505356]](player);

      player cameraunlink();
      _id_F09380914F6E8C79 = scripts\engine\utility::ter_op(istrue(level._id_8CF2B3F6BD2BF0E6), _func_676CFE2AB64EA758() * 0.001, undefined);

      if(level.infilstruct._id_03772737101AA4AF)
        player _meth_0CEBD47970F60E9B(_id_437B6BB41D98DF26, 0, cameraent, _id_1EDD840D40B43222, _id_F09380914F6E8C79, 1, 1, 1);
      else
        player _meth_0CEBD47970F60E9B(_id_437B6BB41D98DF26, 0, cameraent, _id_1EDD840D40B43222, _id_F09380914F6E8C79, 1);
    }
  } else {
    player _meth_8FF8FD7841F6EBA2();
    player cameralinkTo(cameraent, _id_1EDD840D40B43222, 1, 1);
  }
}

_id_78DFE475A5D4F843(player) {
  [cameraent, _id_1EDD840D40B43222] = _id_19EA8F6D547DC8BC(player);
  _id_3DF9D9A1027FB9BC = cameraent gettagorigin(_id_1EDD840D40B43222);
  _id_ABB06648E9DB3FFE = cameraent gettagangles(_id_1EDD840D40B43222);
  return [_id_3DF9D9A1027FB9BC, _id_ABB06648E9DB3FFE];
}

_id_347D56FEB29D7F74() {
  if(_id_FF03E352A5746185())
    return self._id_2336099A20080602._id_8355076D4ED3FC96;
  else
    return self._id_2336099A20080602.animlength;
}

_id_8839D2F2F530A0B9(player) {
  _id_599217E02A6DA3FA = self._id_6F8E05E25EB697A4[player.infilanimindex - 1].ent;
  animname = self._id_6F8E05E25EB697A4[player.infilanimindex - 1].animname;

  if(istrue(level._id_5338013D30A283C8)) {
    if(isDefined(self._id_6F8E05E25EB697A4[player.infilanimindex - 1]._id_1FC8EFB020E9A71D)) {
      if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.gender) && player.operatorcustomization.gender == "female")
        animname = self._id_6F8E05E25EB697A4[player.infilanimindex - 1]._id_1FC8EFB020E9A71D;
    }
  }

  _id_5934AE37F5ED079C = 0;
  _id_569B6C130ACD3DAA = player._id_4B72FAF29B9B511A;

  if(!isDefined(_id_569B6C130ACD3DAA) || _id_569B6C130ACD3DAA != _id_599217E02A6DA3FA)
    _id_5934AE37F5ED079C = 1;

  if(_id_5934AE37F5ED079C) {
    player playerlinkTo(_id_599217E02A6DA3FA, "tag_player");
    player._id_4B72FAF29B9B511A = _id_599217E02A6DA3FA;
  }

  player playanimscriptsceneevent("scripted_scene", animname);
}

unfreezeplayercontrols(_id_74B5B12BB6514385) {
  wait(_id_74B5B12BB6514385);

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    player scripts\mp\utility\player::_freezelookcontrols(0);
  }
}

_id_1C3D2F575360D8FA(_id_DF94E780C2B3C994) {
  self endon("stopScene");
  level.infilstruct.animstruct = self;
  level.infilstruct._id_DF94E780C2B3C994 = _id_DF94E780C2B3C994;
  self._id_2739B8C6B038BA5E = undefined;
  level.infilstruct._id_03772737101AA4AF = scripts\engine\utility::_id_53C4C53197386572(self._id_03772737101AA4AF, 0);
  _id_E49A1C04AC964563 = 0;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(level.infilstruct._id_410EB50B35457227))
      [[level.infilstruct._id_410EB50B35457227]](player);
    else
      _id_0930A1E7BD882C1D::_id_6D8AC534AD288AA5(player);

    player scripts\mp\utility\player::_freezelookcontrols(1);
  }

  if(level.infilstruct._id_03772737101AA4AF)
    self._id_E73CE295AE9D4104 _meth_ 3671 EC427C125CB(1);

  foreach(pack in self.packs) {
    self._id_2739B8C6B038BA5E = pack;

    if(pack._id_79D924275E2B5029)
      _id_0930A1E7BD882C1D::_id_583F118C4064CA21(level.infilstruct.players);

    if(isDefined(pack.fov))
      _id_0930A1E7BD882C1D::allplayers_setfov(pack.fov);
    else
      _id_0930A1E7BD882C1D::_id_CF47AB3F9DEFE35B();

    if(isDefined(pack.fstop) && isDefined(pack._id_ED8206FEF1806FEF))
      _id_0930A1E7BD882C1D::allplayers_setphysicaldof(pack.fstop, pack._id_ED8206FEF1806FEF, pack.focusspeed, pack.aperturespeed, pack._id_C06551440B16249C);

    if(isDefined(pack.startfunc))
      [[pack.startfunc]](pack._id_C65BB75CCE61100F);

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(pack._id_EEDB5FB15EB26BFA))
        [[pack._id_EEDB5FB15EB26BFA]](player, pack._id_5AB13B55D7CEFF80);

      if(!scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() || !pack._id_79D924275E2B5029) {
        player cameraunlink();
        player _meth_8FF8FD7841F6EBA2();
        pack _id_BDA88F27A0337EAA(player);
      }
    }

    if(isDefined(pack.fx))
      playFX(scripts\engine\utility::getfx(pack.fx), pack.fxorigin, anglesToForward(pack.fxangles), anglestoup(pack.fxangles));

    pack.ents = scripts\engine\utility::array_removeundefined(pack.ents);

    foreach(ent in pack.ents) {
      _id_F09380914F6E8C79 = scripts\engine\utility::ter_op(istrue(level._id_8CF2B3F6BD2BF0E6), _func_676CFE2AB64EA758() * 0.001, undefined);

      if(level.infilstruct._id_03772737101AA4AF) {
        ent _meth_ 3671 EC427C125CB(1);
        ent scriptmodelplayanim(level.scr_animname[ent.animname][pack.anime], ent.animname, _id_F09380914F6E8C79, 1, "none");
      } else {
        if(!istrue(ent._id_6A704063A0555C1D))
          ent dontinterpolate();

        ent scriptmodelplayanim(level.scr_animname[ent.animname][pack.anime], ent.animname, _id_F09380914F6E8C79);
      }

      ent thread scripts\common\notetrack::start_notetrack_wait(ent, ent.animname, pack.anime, ent.animname, level.scr_anim[ent.animname][pack.anime]);
    }

    foreach(rig in pack._id_5BA8DB57A9811D96) {
      foreach(probe in rig._id_83D076584339CBE2) {
        origin_offset = probe.origin_offset;
        angles_offset = probe.angles_offset;

        if(!isDefined(angles_offset))
          angles_offset = (0, 0, 0);

        probe show();
        probe linkTo(rig._id_599217E02A6DA3FA, "tag_origin", origin_offset, angles_offset);
      }

      foreach(light in rig.lights) {
        if(isDefined(light.original_intensity))
          light setlightintensity(light.original_intensity);

        origin_offset = light.origin_offset;
        angles_offset = light.angles_offset;

        if(!isDefined(angles_offset))
          angles_offset = (0, 0, 0);

        light linkTo(rig._id_599217E02A6DA3FA, "tag_origin", origin_offset, angles_offset);
      }
    }

    _id_2246D8F267E2C3DE = 0;
    _id_2119F74EA52E3C92 = 4;
    pack._id_3BD5282B118D27F8 = scripts\engine\utility::array_removeundefined(pack._id_3BD5282B118D27F8);

    foreach(_id_10727DCC51C74547 in pack._id_3BD5282B118D27F8) {
      _id_F09380914F6E8C79 = scripts\engine\utility::ter_op(istrue(level._id_8CF2B3F6BD2BF0E6), _func_676CFE2AB64EA758() * 0.001, undefined);

      if(level.infilstruct._id_03772737101AA4AF) {
        _id_10727DCC51C74547 _meth_ 3671 EC427C125CB(1);
        _id_10727DCC51C74547 scriptmodelplayanim(level.scr_animname[_id_10727DCC51C74547.animname][pack.anime], _id_10727DCC51C74547.animname, _id_F09380914F6E8C79, 1, "none");
      } else {
        _id_10727DCC51C74547 dontinterpolate();
        _id_10727DCC51C74547 scriptmodelplayanim(level.scr_animname[_id_10727DCC51C74547.animname][pack.anime], _id_10727DCC51C74547.animname, _id_F09380914F6E8C79);
      }

      if(_id_E49A1C04AC964563) {
        if(!isDefined(pack._id_A39842BCDFC531C2)) {
          if(_id_2246D8F267E2C3DE < _id_2119F74EA52E3C92)
            _id_10727DCC51C74547 show();
          else
            _id_10727DCC51C74547 hide();
        }
      } else
        _id_10727DCC51C74547 hide();

      _id_2246D8F267E2C3DE++;
    }

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }
      if(level.infilstruct._id_03772737101AA4AF)
        player _meth_ 3671 EC427C125CB(1);

      pack _id_8839D2F2F530A0B9(player);

      if(_id_E49A1C04AC964563) {
        if(_id_60597DA56F99D304(player)) {
          player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
          player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_infils_common::playInfilSequence()");
        }
      }
    }

    if(pack._id_79D924275E2B5029) {
      break;
    }

    animlength = pack _id_347D56FEB29D7F74();
    _id_0930A1E7BD882C1D::waitandpause(animlength);
  }

  wait 1.0;

  if(!istrue(level.infilstruct._id_EB0E85A583F21B9D)) {
    _id_0930A1E7BD882C1D::allplayers_clearphysicaldof();
    _id_0930A1E7BD882C1D::_id_CF47AB3F9DEFE35B();
  }

  if(level.infilstruct._id_03772737101AA4AF) {
    foreach(player in level.infilstruct.players) {
      player _meth_ 3671 EC427C125CB(0);

      if(isDefined(player._id_4B72FAF29B9B511A))
        player._id_4B72FAF29B9B511A = undefined;
    }
  }

  level thread unfreezeplayercontrols(1.2);
}

_id_475FE383999C5286() {
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self._id_662EFE6105E9F585)) {
    return;
  }
  if(isDefined(self.innards))
    self.innards delete();

  self delete();
}

cleanupents() {
  foreach(pack in self.packs) {
    pack._id_3BD5282B118D27F8 = scripts\engine\utility::array_removeundefined(pack._id_3BD5282B118D27F8);

    foreach(_id_10727DCC51C74547 in pack._id_3BD5282B118D27F8)
    _id_10727DCC51C74547 _id_475FE383999C5286();

    pack._id_6F8E05E25EB697A4 = scripts\engine\utility::array_removeundefined(pack._id_6F8E05E25EB697A4);

    foreach(_id_460F06FB83940B20 in pack._id_6F8E05E25EB697A4) {
      if(isDefined(_id_460F06FB83940B20.ent))
        _id_460F06FB83940B20.ent _id_475FE383999C5286();
    }

    pack._id_6F8E05E25EB697A4 = [];
    pack.ents = scripts\engine\utility::array_removeundefined(pack.ents);

    foreach(ent in pack.ents) {
      if(isDefined(ent.linkedents))
        scripts\engine\utility::array_delete(ent.linkedents);

      ent _id_475FE383999C5286();
    }

    pack._id_FB299ADFD0F8BFC5 = scripts\engine\utility::array_removeundefined(pack._id_FB299ADFD0F8BFC5);

    foreach(ent in pack._id_FB299ADFD0F8BFC5) {
      if(isDefined(ent.linkedents))
        scripts\engine\utility::array_delete(ent.linkedents);

      ent _id_475FE383999C5286();
    }
  }
}

_id_7812117B17C4D21E() {
  _id_3C0F86A5D66AC462 = "ac130";
  _id_11EE153F88AF2B07 = _id_56D92AB945808B50(_id_3C0F86A5D66AC462);
  return _id_11EE153F88AF2B07;
}

_id_56D92AB945808B50(_id_8508980407DC317B) {
  _id_11EE153F88AF2B07 = getDvar("dvar_2F5821F46995D1E2");

  if(_id_11EE153F88AF2B07 != "")
    return _id_11EE153F88AF2B07;

  return _id_8508980407DC317B;
}

_id_0FE85C23FC6FA8C2() {
  level.infilstruct._id_E7C7DE60A5EA2F52 = [];
  level.infilstruct._id_477BD548940C3A78 = undefined;
  _id_11EE153F88AF2B07 = _id_7812117B17C4D21E();

  switch (_id_11EE153F88AF2B07) {
    case "chopper":
      _id_142B065A6CB7BF82::init();
      break;
    case "ac130_v0":
      _id_7CFB984D8451DC2A::init();
      break;
    case "s5_reveal_event":
      _id_164622EB2B0F5390::_id_0ABB493EA69C8133();
      break;
    case "ac130":
    default:
      _id_27AFD7662BC38A81::init();
      break;
  }
}

_id_8252134BB4AAA66B() {
  animstruct = _id_55F2480B4B819AEA(level.infilstruct.c130);
  level.infilstruct.c130.animstruct = animstruct;
}

_id_8D001511B174EF1E() {
  level.infilstruct.c130.animstruct _id_1C3D2F575360D8FA();
}

_id_55F2480B4B819AEA(movingc130) {
  return [[level.infilstruct._id_B381E33E977DA440]](movingc130);
}

_id_C03893A40366ED07() {
  level._id_16DA1E546DC92A4C = [];
  level.brlatespawnplayer = ::latespawnplayer;
}

_id_BEE6776DBF711484() {
  level._id_16DA1E546DC92A4C = undefined;
}

_id_C69C9CF4AB75A1EF() {
  return isDefined(level._id_16DA1E546DC92A4C) && level._id_16DA1E546DC92A4C.size > 0;
}

missedinfilplayerhandler() {
  self.br_infilstarted = 1;
  _id_7E52B56769FA7774::addrespawntoken(1);
  _id_67708F418B1FAC79::playergulagautowin("missedInfil", undefined, undefined, 1);

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    self notify("br_jump");
}

_id_7E1BBC382AD810F9() {
  self endon("disconnect");
  self.br_isininfil = 0;
  self.br_infilstarted = 1;
  _id_6ECC7CD453466014 = _id_1E4A61DB11011446::_id_7DBB8165D792B06C();

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("squadLeader")) {
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(self.team, "players");

    if(!isDefined(_id_A6AB8D0FDA441DC2) || _id_A6AB8D0FDA441DC2.size == 0)
      _id_A6AB8D0FDA441DC2 = [self];

    _id_0930A1E7BD882C1D::setupbrsquadleader(_id_A6AB8D0FDA441DC2);
  }

  self setallstreamloaddist(0.0);
  self clearpredictedstreampos();

  if(isDefined(self._id_CD09849E16631C71)) {
    foreach(overlay in self._id_CD09849E16631C71) {
      if(isDefined(overlay))
        overlay destroy();
    }

    self._id_CD09849E16631C71 = undefined;
  }

  self setclientdvar("dvar_B21F1157C582FF15", 1);
  scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_infils_common::lateSpawnPlayerAfterInfil()");
  self.plotarmor = 0;
  scripts\mp\utility\player::_freezelookcontrols(0, 1);
  self cameraunlink();
  self _meth_8FF8FD7841F6EBA2();
  self setclientdvar("cg_fov", 65);
  self setclientdvar("dvar_86BF34D5F48FA435", 65);
  self setclientdvar("dvar_71C6C0B8428E44A7", 0);
  self disablephysicaldepthoffieldscripting();
  scripts\mp\utility\player::setdof_default();

  if(isDefined(self.hidehudenabled) && self.hidehudenabled > 0)
    scripts\mp\utility\player::hidehuddisable();

  self visionsetfadetoblackforplayer("", 1.0);
  self visionsetnakedforplayer("", 1.0);
  _id_2CEDCC356F1B9FC8::_id_64FA4C213439177F();

  if(!isalive(self)) {
    if(getdvarint("dvar_25AD2925D6075C8F", 0) == 2 && isbot(self) && !_id_6ECC7CD453466014) {
      self.jumped = 1;
      scripts\mp\playerlogic::addtoalivecount("lateSpawn");
    }

    if(_id_6ECC7CD453466014)
      thread scripts\mp\playerlogic::spawnplayer(undefined, 0);
    else
      thread missedinfilplayerhandler();
  } else {}

  scripts\mp\utility\player::setwind("1");
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

latespawnplayer() {
  if(!_id_C69C9CF4AB75A1EF()) {
    _id_7E1BBC382AD810F9();
    return;
  }

  if(scripts\engine\utility::array_contains(level.infilstruct.players, self)) {
    return;
  }
  _id_F30707D99174CDC6 = 0;

  while(_id_F30707D99174CDC6 < level._id_16DA1E546DC92A4C.size) {
    func = level._id_16DA1E546DC92A4C[_id_F30707D99174CDC6];
    self[[func]]();
    _id_F30707D99174CDC6++;

    if(!_id_C69C9CF4AB75A1EF()) {
      _id_7E1BBC382AD810F9();
      return;
    }
  }

  level.infilstruct.players[level.infilstruct.players.size] = self;
}

_id_60597DA56F99D304(player) {
  if(!isDefined(player))
    return 0;

  if(getdvarint("dvar_AD78F0F19C8707AB", 1) == 1)
    return isDefined(player.c130);
  else
    return 1;
}