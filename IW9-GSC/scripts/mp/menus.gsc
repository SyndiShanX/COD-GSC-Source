/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\menus.gsc
***********************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";

    if(level.multiteambased)
      game["menu_team"] = "team_mt_options";

    game["menu_class"] = "class";
    game["menu_class_allies"] = "class_marines";
    game["menu_class_axis"] = "class_opfor";
    game["menu_changeclass_allies"] = "changeclass_marines";
    game["menu_changeclass_axis"] = "changeclass_opfor";

    if(level.multiteambased) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++) {
        _id_62890C80C835C4A5 = "menu_class_" + level.teamnamelist[_id_AC0E594AC96AA3A8];
        _id_90E671D45A71BE99 = "menu_changeclass_" + level.teamnamelist[_id_AC0E594AC96AA3A8];
        game[_id_62890C80C835C4A5] = game["menu_class_allies"];
        game[_id_90E671D45A71BE99] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";
    game["menu_controls"] = "ingame_controls";

    if(level.splitscreen) {
      if(level.multiteambased) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamnamelist.size; _id_AC0E594AC96AA3A8++) {
          _id_62890C80C835C4A5 = "menu_class_" + level.teamnamelist[_id_AC0E594AC96AA3A8];
          _id_90E671D45A71BE99 = "menu_changeclass_" + level.teamnamelist[_id_AC0E594AC96AA3A8];
          game[_id_62890C80C835C4A5] = game[_id_62890C80C835C4A5] + "_splitscreen";
          game[_id_90E671D45A71BE99] = game[_id_90E671D45A71BE99] + "_splitscreen";
        }
      }

      game["menu_team"] = game["menu_team"] + "_splitscreen";
      game["menu_class_allies"] = game["menu_class_allies"] + "_splitscreen";
      game["menu_class_axis"] = game["menu_class_axis"] + "_splitscreen";
      game["menu_changeclass_allies"] = game["menu_changeclass_allies"] + "_splitscreen";
      game["menu_changeclass_axis"] = game["menu_changeclass_axis"] + "_splitscreen";
      game["menu_controls"] = game["menu_controls"] + "_splitscreen";
      game["menu_changeclass_defaults_splitscreen"] = "changeclass_splitscreen_defaults";
      game["menu_changeclass_custom_splitscreen"] = "changeclass_splitscreen_custom";
    }

    precachestring(&"MP/HOST_ENDED_GAME");
    precachestring(&"MP/HOST_ENDGAME_RESPONSE");
  }

  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::onleavegamecallback);
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::onteamchangecallback);
  level scripts\common\ui::lui_registercallback("class_edit", ::onclasseditcallback);
  level scripts\common\ui::lui_registercallback("class_select", ::onclasschoicecallback);
  level._id_CE4945D1893FBACA = getdvarint("dvar_6CB6994F3A89112C", 0);
  level thread setintrocamnetworkmodel();
}

onteamchangecallback(_id_7148C1A6F25491F8, _id_8C10BBAEF71258B9) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(_id_7148C1A6F25491F8 != "team_select") {
      return;
    }
    if(scripts\mp\utility\game::matchmakinggame()) {
      return;
    }
    handleteamchange(_id_7148C1A6F25491F8, _id_8C10BBAEF71258B9);
  }
}

setintrocamnetworkmodel() {
  setintrocameraactive(1);
  level waittill("prematch_over");
  setintrocameraactive(0);
}

isloadoutindexdefault(index) {
  return index >= 100;
}

getclasschoice(_id_3FD595213E78030A) {
  _id_3FD595213E78030A++;
  _id_2D36749FDFFC49B4 = undefined;

  if(_id_3FD595213E78030A > 100) {
    _id_089688461C79EF11 = _id_3FD595213E78030A - 100;
    _id_2D36749FDFFC49B4 = "default" + _id_089688461C79EF11;
  } else
    _id_2D36749FDFFC49B4 = "custom" + _id_3FD595213E78030A;

  return _id_2D36749FDFFC49B4;
}

executeclasschange(_id_0AC2E2DC79F3D177, _id_FDA7F7E8FC307ABA) {
  if(isbot(self) || istestclient(self)) {
    self.pers["class"] = _id_0AC2E2DC79F3D177;
    self.class = _id_0AC2E2DC79F3D177;
  } else {
    _id_2D36749FDFFC49B4 = getclasschoice(_id_0AC2E2DC79F3D177);

    if(!isDefined(self.pers["class"]) || _id_2D36749FDFFC49B4 != self.pers["class"] || _id_FDA7F7E8FC307ABA) {
      self.pers["class"] = _id_2D36749FDFFC49B4;
      self.class = _id_2D36749FDFFC49B4;
      scripts\mp\class::preloadandqueueclass(_id_2D36749FDFFC49B4);
    }

    _id_CD83A28652A3F837 = 1;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\mp\gamelogic::_id_8F54DEEC605690D1(scripts\mp\utility\game::getsubgametype()))
      _id_CD83A28652A3F837 = 0;

    if(scripts\mp\class::shouldallowinstantclassswap() && _id_CD83A28652A3F837)
      thread scripts\mp\class::swaploadout();
    else {
      _id_5E6A291A22A0D249 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && self getclientomnvar("ui_open_loadout_bag");

      if(isalive(self) && !_id_5E6A291A22A0D249)
        self iprintlnbold(game["strings"]["change_class"]);

      if(_id_0AC2E2DC79F3D177 < 100)
        self setclientomnvar("ui_loadout_changed", scripts\mp\class::getclassindex(self.pers["class"]));
    }
  }
}

setnextroundclass(_id_0AC2E2DC79F3D177) {
  _id_2D36749FDFFC49B4 = _id_0AC2E2DC79F3D177;

  if(!isbot(self)) {
    if(isalive(self))
      self iprintlnbold(game["strings"]["revive_class"]);

    _id_2D36749FDFFC49B4 = getclasschoice(_id_0AC2E2DC79F3D177);
  }

  self.pers["next_round_class"] = _id_2D36749FDFFC49B4;
}

onleavegamecallback(_id_7148C1A6F25491F8, val) {
  if(_id_7148C1A6F25491F8 != "end_game") {
    return;
  }
  if(scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(isdedicatedserver() && !_func_D1E52856DC19C5D0(self)) {
    return;
  }
  level thread scripts\mp\gamelogic::forceend(val);
}

onclasseditcallback(_id_0AC2E2DC79F3D177) {
  self endon("disconnect");
  waittillframeend;
  handleclassedit(_id_0AC2E2DC79F3D177);

  if(scripts\mp\utility\game::getgametype() == "br")
    _id_1E4A61DB11011446::_id_4043E420432F59F0(getclasschoice(_id_0AC2E2DC79F3D177));
}

onclasschoicecallback(_id_0AC2E2DC79F3D177, _id_F01F8E178FF54EDA) {
  self notify("loadout_class_selected", _id_0AC2E2DC79F3D177);

  if(level.systemlink && getdvarint("xblive_competitionmatch") && self _meth_8420670EAFC8D391())
    self setclientomnvar("ui_options_menu", 0);
  else {
    if(istrue(self.waitingtoselectclass)) {
      if(isDefined(self.revive_chosenclass))
        setnextroundclass(_id_0AC2E2DC79F3D177);

      if(istrue(level._id_CE4945D1893FBACA)) {
        self.waitingtoselectclass = 0;
        self setclientomnvar("ui_options_menu", 4);
        self._id_48366F4AAEAFCF5D = 1;
      } else
        self setclientomnvar("ui_options_menu", 0);

      return;
    }

    if(!scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout()) {
      return;
    }
    if(isDefined(self.revive_chosenclass) && isDefined(self.instantclassswapallowed) && !scripts\mp\class::shouldallowinstantclassswap()) {
      setnextroundclass(_id_0AC2E2DC79F3D177);
      return;
    }

    if("" + _id_0AC2E2DC79F3D177 != "callback") {
      executeclasschange(_id_0AC2E2DC79F3D177, istrue(_id_F01F8E178FF54EDA));

      if(istrue(self._id_48366F4AAEAFCF5D)) {
        self setclientomnvar("ui_options_menu", 0);
        self._id_48366F4AAEAFCF5D = 0;
        return;
        return;
      }

      return;
    }

    menuclass("callback");
  }
}

handleteamchange(_id_7148C1A6F25491F8, _id_8C10BBAEF71258B9) {
  _id_80B8E166E8E16BA6 = 0;

  if(_id_8C10BBAEF71258B9 >= 3)
    _id_80B8E166E8E16BA6 = 1;

  if(_id_80B8E166E8E16BA6) {
    self setclientomnvar("ui_spectator_selected", 1);
    self.spectating_actively = 1;
  } else {
    self setclientomnvar("ui_spectator_selected", -1);
    self.spectating_actively = 0;
  }

  _id_FFF3522DE2DA93F8 = self _meth_8420670EAFC8D391();
  _id_FBAD2B80953EC2CF = !_id_FFF3522DE2DA93F8 && isDefined(self.team) && (self.team == "spectator" || self.team == "codcaster");
  _id_4DC9D59B17D0DD93 = _id_FFF3522DE2DA93F8 && _id_8C10BBAEF71258B9 == 3 || _id_FBAD2B80953EC2CF && (_id_8C10BBAEF71258B9 == 4 || _id_8C10BBAEF71258B9 == 5);

  if(_id_8C10BBAEF71258B9 == 4 || _id_8C10BBAEF71258B9 == 5) {
    _id_8C10BBAEF71258B9 = 3;
    self _meth_7398D812FCA0292F(1);
  } else
    self _meth_7398D812FCA0292F(0);

  if(_id_8C10BBAEF71258B9 == 0)
    _id_8C10BBAEF71258B9 = "axis";
  else if(_id_8C10BBAEF71258B9 == 1)
    _id_8C10BBAEF71258B9 = "allies";
  else if(_id_8C10BBAEF71258B9 == 2)
    _id_8C10BBAEF71258B9 = "random";
  else if(_id_8C10BBAEF71258B9 == 4)
    _id_8C10BBAEF71258B9 = "codcaster";
  else
    _id_8C10BBAEF71258B9 = "spectator";

  if(!_id_4DC9D59B17D0DD93 && isDefined(self.pers["team"]) && _id_8C10BBAEF71258B9 == self.pers["team"]) {
    return;
  }
  if(isDefined(self.operatorcustomization))
    self.operatorcustomization.rebuild = 1;

  thread logteamselection(_id_8C10BBAEF71258B9);

  if(_id_8C10BBAEF71258B9 != "spectator")
    self.pers["playerChoseSpectatorTeam"] = undefined;
  else
    self.pers["playerChoseSpectatorTeam"] = 1;

  if(_id_8C10BBAEF71258B9 == "axis")
    thread setteam("axis");
  else if(_id_8C10BBAEF71258B9 == "allies")
    thread setteam("allies");
  else if(_id_8C10BBAEF71258B9 == "random")
    thread autoassign();
  else if(_id_8C10BBAEF71258B9 == "codcaster")
    thread _id_9FF5C7531349CDFC(_id_4DC9D59B17D0DD93);
  else if(_id_8C10BBAEF71258B9 == "spectator")
    thread setspectator(_id_4DC9D59B17D0DD93);
}

handleclassedit(_id_0AC2E2DC79F3D177) {
  classname = getclasschoice(_id_0AC2E2DC79F3D177);
  _id_A022FBCAFC053C4A = scripts\mp\class::loadout_editcachedclassstruct(classname);
  _id_5410628DDD8DFD8A = scripts\mp\class::loadout_editglobalclassstruct();
  _id_D20409FAFB8AEA3E = _id_A022FBCAFC053C4A || _id_5410628DDD8DFD8A;

  if(isDefined(self.pers["class"]) && classname == self.pers["class"] && _id_D20409FAFB8AEA3E)
    onclasschoicecallback(_id_0AC2E2DC79F3D177, 1);
}

_id_C69C22EF9E1E92A0(_id_F0C136CA13F8BC76) {
  for(_id_3EDA0EF65C9478AC = level.teamnamelist.size - 1; _id_3EDA0EF65C9478AC >= 0; _id_3EDA0EF65C9478AC--) {
    _id_8F7C03EC5F22FE86 = level.teamnamelist[_id_3EDA0EF65C9478AC];
    _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::getteamdata(_id_8F7C03EC5F22FE86, "players");
    _id_8BAA6CFD8698560C = 0;

    foreach(player in _id_A6AB8D0FDA441DC2) {
      if(!isbot(player)) {
        _id_8BAA6CFD8698560C = 1;
        break;
      }
    }

    count = _id_A6AB8D0FDA441DC2.size;

    if(_id_F0C136CA13F8BC76)
      count = count + scripts\mp\utility\teams::getteamdata(_id_8F7C03EC5F22FE86, "UnlockedUIBotCount");

    if(!_id_8BAA6CFD8698560C && (level.maxteamsize == 0 || count < level.maxteamsize)) {
      thread setteam(_id_8F7C03EC5F22FE86);
      return 1;
    }
  }

  return 0;
}

autoassign() {
  if(scripts\mp\utility\game::getgametype() == "infect")
    thread setteam("allies");
  else {
    _id_155C56B2E3DB23C9 = getDvar("scr_force_team", "");

    if(scripts\mp\utility\teams::isgameplayteam(_id_155C56B2E3DB23C9)) {
      setsessionteam(_id_155C56B2E3DB23C9);
      thread setteam(_id_155C56B2E3DB23C9);
    } else if(getdvarint("dvar_03F36284B49B3D7A", 0) != 0)
      thread setteam("allies");
    else {
      _id_F0C136CA13F8BC76 = level.maxteamsize > 0 && isDefined(level._id_7B37B2193F163B9B);

      if(isbot(self) && isDefined(self.bot_team) && self.bot_team != "autoassign") {
        thread setteam(self.bot_team);

        if(_id_F0C136CA13F8BC76)
          _id_E9A6FDC468A5FA73(self.bot_team);
      } else {
        if(self _meth_8420670EAFC8D391()) {
          thread _id_9FF5C7531349CDFC();
          return;
        }

        if(self.sessionteam == "spectator") {
          thread setspectator();
          return;
        }

        if(istrue(level.teammaxfill)) {
          _id_CF36F495AEF1CF75 = isbot(self) && getdvarint("dvar_D356A7876F773136", 0) != 0;

          if(_id_CF36F495AEF1CF75 && _id_C69C22EF9E1E92A0(_id_F0C136CA13F8BC76)) {
            return;
          }
          for(_id_3EDA0EF65C9478AC = 0; _id_3EDA0EF65C9478AC < level.teamnamelist.size; _id_3EDA0EF65C9478AC++) {
            _id_F90358454413407F = level.teamnamelist[_id_3EDA0EF65C9478AC];

            if(_id_F0C136CA13F8BC76)
              _id_E9A6FDC468A5FA73(_id_F90358454413407F);

            count = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "teamCount");

            if(_id_F0C136CA13F8BC76)
              count = count + scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "UnlockedUIBotCount");

            if(level.maxteamsize == 0 || count < level.maxteamsize) {
              thread setteam(_id_F90358454413407F);
              break;
            }
          }

          return;
        }

        _id_4D6BD6D4C0E080B6 = 0;
        _id_400D10216D79AA87 = [];

        foreach(_id_F90358454413407F in level.teamnamelist) {
          count = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "teamCount");

          if(isDefined(self.team) && self.team == _id_F90358454413407F)
            count--;

          if(!_id_400D10216D79AA87.size || count < _id_4D6BD6D4C0E080B6) {
            _id_4D6BD6D4C0E080B6 = count;
            _id_400D10216D79AA87 = [];
            _id_400D10216D79AA87[_id_400D10216D79AA87.size] = _id_F90358454413407F;
            continue;
          }

          if(count == _id_4D6BD6D4C0E080B6)
            _id_400D10216D79AA87[_id_400D10216D79AA87.size] = _id_F90358454413407F;
        }

        if(_id_400D10216D79AA87.size == 1) {
          if(!isDefined(self.team) || self.team != _id_400D10216D79AA87[0]) {
            thread setteam(_id_400D10216D79AA87[0]);
            return;
          }

          return;
        }

        if(level.teambased) {
          _id_3B8219D206004DFA = scripts\mp\gamescore::gethighestscoringteam();

          if(scripts\engine\utility::array_contains(_id_400D10216D79AA87, _id_3B8219D206004DFA))
            _id_400D10216D79AA87 = scripts\engine\utility::array_remove(_id_400D10216D79AA87, _id_3B8219D206004DFA);
        }

        if(isDefined(self.team) && scripts\engine\utility::array_contains(_id_400D10216D79AA87, self.team))
          _id_400D10216D79AA87 = scripts\engine\utility::array_remove(_id_400D10216D79AA87, self.team);

        if(_id_400D10216D79AA87.size > 0) {
          _id_F49EE9D2911C5AB5 = randomint(_id_400D10216D79AA87.size);

          if(istrue(level.autoassignlowteamconsistent))
            _id_F49EE9D2911C5AB5 = 0;

          thread setteam(_id_400D10216D79AA87[_id_F49EE9D2911C5AB5]);
        }
      }
    }
  }
}

_id_E9A6FDC468A5FA73(team) {
  _id_3232B53EF5690097 = scripts\mp\utility\teams::getteamdata(team, "teamCount");
  _id_2B68F240FB19593D = scripts\mp\utility\teams::getteamdata(team, "UnlockedUIBotCount");

  if(_id_3232B53EF5690097 + _id_2B68F240FB19593D > level.maxteamsize)
    return;
}

setteam(selection, _id_7EC298E587EB6719) {
  self endon("disconnect");

  if(!isai(self) && level.teambased && !scripts\mp\teams::getjointeampermissions(selection) && !scripts\mp\utility\game::lobbyteamselectenabled()) {
    return;
  }
  if(level.ingraceperiod && !istrue(self.hasdonecombat)) {
    self.hasspawned = 0;
    self.pers["lives"] = scripts\mp\utility\game::getgametypenumlives();
  }

  if(self.sessionstate == "playing") {
    self.switching_teams = 1;
    self.joining_team = selection;
    self.leaving_team = self.pers["team"];

    if(scripts\mp\utility\game::getgametype() == "arena")
      self.switching_teams_arena = 1;
  } else if(istrue(_id_7EC298E587EB6719) && isDefined(level._id_D37D95AC1717903C))
    selection = level[[level._id_D37D95AC1717903C]]();

  if(istrue(game["isLaunchChunk"]) && isbot(self) == 0)
    selection = "allies";

  addtoteam(selection);
  thread _id_76CC264B397DB9CB::setsquad(selection);

  if(scripts\mp\utility\player::isragdollzerog())
    self lockdeathcamera(1);

  if(self.sessionstate == "playing") {
    self suicide();
    scripts\mp\utility\player::updatesessionstate("spectator");
    self.suicideswitched = 1;
  }

  if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
    if(getdvarint("dvar_206A763969420CE0", 0) == 1 && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm" && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "sandbox" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
      _id_891D91911E4C1ADE = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::demoforcesre("setTeam() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + _id_891D91911E4C1ADE);
    }

    if(!istrue(self._id_5354295B99468CEF) && !istrue(self._id_10844DDCB34694EE) && getdvarint("dvar_89556297EAAB6B6A", 0) == 0)
      self setclientomnvar("ui_options_menu", 2);
  }

  if(isDefined(level.onplayerconnectstream))
    self thread[[level.onplayerconnectstream]]();

  if(!istrue(self._id_5354295B99468CEF))
    waitforclassselect();

  endrespawnnotify();

  if((self.sessionstate == "spectator" || playerisstreaming()) && !istrue(self.suicideswitched)) {
    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !scripts\mp\utility\player::isinkillcam()) {
      if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
        return;
      }
      thread scripts\mp\playerlogic::spawnclient();
    }

    thread scripts\mp\spectating::setspectatepermissions();
  }

  self.suicideswitched = undefined;
  self notify("okToSpawn");
}

playerisstreaming() {
  return isDefined(level.playerisstreaming) && self[[level.playerisstreaming]]();
}

_id_EB9E2BB02ECFF5B5() {
  return getdvarint("dvar_61BE9F6A05F64523", 0) != 0;
}

_id_02C0EB018B319F66() {
  return getdvarint("dvar_A9194B992D1058D6", 0) != 0;
}

setspectator(_id_4DC9D59B17D0DD93) {
  if((!isDefined(_id_4DC9D59B17D0DD93) || !_id_4DC9D59B17D0DD93) && isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];

    if(self.sessionstate == "playing")
      self suicide();
  }

  self notify("becameSpectator");
  addtoteam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

_id_9FF5C7531349CDFC(_id_4DC9D59B17D0DD93) {
  if((!isDefined(_id_4DC9D59B17D0DD93) || !_id_4DC9D59B17D0DD93) && isDefined(self.pers["team"]) && self.pers["team"] == "codcaster") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "codcaster";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  self notify("becameSpectator");
  addtoteam("codcaster");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

_id_788BCFAB4101649A(player) {
  if(!isDefined(player))
    return 0;

  _id_69314E9E8E9784DB = 0;

  if(_id_69314E9E8E9784DB)
    return 1;

  if(getdvarint("dvar_6FBFDDE9FC5D2964", 0) != 0)
    return 1;

  if(getdvarint("unlockAllItems") != 0)
    return 1;

  if(scripts\mp\utility\game::privatematch())
    return 1;

  if(istrue(level.systemlink))
    return 1;

  if(player scripts\mp\rank::getrank() >= 4)
    return 1;

  return 0;
}

waitforclassselect() {
  self endon("disconnect");
  level endon("game_ended");
  self.waitingtoselectclass = 1;

  if(scripts\mp\flags::gameflag("prematch_done") && istrue(level.usespawnselection) && !istrue(self.hasspawned)) {
    self setclientomnvar("ui_world_fade", 1.0);
    self setclientomnvar("ui_hide_objectives", 1);
    self setclientomnvar("ui_in_spawn_camera", 1);
  }

  for(;;) {
    _id_40645C66E8A85816 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::allowclasschoice() && (!scripts\mp\flags::gameflag("prematch_done") || istrue(level.skipprematch));
    _id_7E61909352DB412D = scripts\mp\utility\game::teamhasinfil(self.team) && !scripts\mp\flags::gameflag("infil_started") && !isDefined(level.bypassclasschoicefunc);
    _id_9CFDA0AFBBF50688 = scripts\mp\utility\game::islifelimited() && !isDefined(level.bypassclasschoicefunc) && scripts\mp\utility\teams::isgameplayteam(self.team);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (scripts\mp\utility\game::getsubgametype() == "dmz" || scripts\mp\utility\game::getsubgametype() == "exgm") && !istrue(level.br_allowloadout))
      _id_0AC2E2DC79F3D177 = 0;
    else if(_id_40645C66E8A85816 || _id_7E61909352DB412D || _id_9CFDA0AFBBF50688) {
      _id_7148C1A6F25491F8 = "class_select";

      if(!isai(self)) {
        _id_788BCFAB4101649A = _id_788BCFAB4101649A(self);

        if(_id_788BCFAB4101649A && !scripts\mp\utility\game::_id_1E098780C33853F2() || getdvarint("dvar_89556297EAAB6B6A", 0))
          _id_0AC2E2DC79F3D177 = self getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
        else
          _id_0AC2E2DC79F3D177 = 100;
      } else
        _id_0AC2E2DC79F3D177 = "callback";
    } else if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
      if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
        if(scripts\mp\flags::gameflag("prematch_done")) {
          bypassclasschoice();
          break;
        }
      }

      if(!self _meth_8420670EAFC8D391() && getdvarint("dvar_E32EBDBB97A1EC4E", 0) == 0 && self.team != "spectator" && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "conflict")
        scripts\mp\utility\lower_message::setlowermessageomnvar("must_select_loadout_to_spawn");

      self waittill("loadout_class_selected", _id_0AC2E2DC79F3D177);
    } else {
      bypassclasschoice();
      break;
    }

    if(self.team == "spectator") {
      waitframe();
      continue;
    }

    if("" + _id_0AC2E2DC79F3D177 != "callback") {
      if(isbot(self) || istestclient(self)) {
        self.pers["class"] = _id_0AC2E2DC79F3D177;
        self.class = _id_0AC2E2DC79F3D177;
      } else {
        _id_0AC2E2DC79F3D177 = _id_0AC2E2DC79F3D177;
        self.pers["class"] = getclasschoice(_id_0AC2E2DC79F3D177);
        self.class = getclasschoice(_id_0AC2E2DC79F3D177);
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      self.waitingtoselectclass = 0;
    } else {
      self.waitingtoselectclass = 0;
      menuclass("callback");
    }

    break;
  }
}

beginclasschoice(_id_BB5F9019E86676CD) {
  team = self.pers["team"];

  if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
    if(getdvarint("dvar_206A763969420CE0", 0) == 1 && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\utility\game::getsubgametype() != "dmz" && scripts\mp\utility\game::getsubgametype() != "exgm" && scripts\mp\utility\game::getsubgametype() != "plunder" && scripts\mp\utility\game::getsubgametype() != "risk" && scripts\mp\utility\game::getsubgametype() != "sandbox" && scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
      _id_891D91911E4C1ADE = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::demoforcesre("beginClassChoice() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + _id_891D91911E4C1ADE);
    }

    if(!istrue(self._id_10844DDCB34694EE))
      self setclientomnvar("ui_options_menu", 2);

    if(!self _meth_8420670EAFC8D391())
      waitforclassselect();

    endrespawnnotify();

    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !scripts\mp\utility\player::isinkillcam()) {
        if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
          return;
        }
        thread scripts\mp\playerlogic::spawnclient();
      }

      thread scripts\mp\spectating::setspectatepermissions();
    }

    self.connecttime = gettime();
    self notify("okToSpawn");
  } else
    thread bypassclasschoice();
}

bypassclasschoice() {
  self.selectedclass = 1;
  self.waitingtoselectclass = 0;

  if(ispresstofirstspawnmode() && level.enforceantiboosting && !isbot(self)) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("press_to_spawn");
    self notifyonplayercommand("pressToSpawn", "+usereload");
    self notifyonplayercommand("pressToSpawn", "+activate");
    thread waitthensetspawnomnvar();
    self waittill("pressToSpawn");
  }

  if(isDefined(level.bypassclasschoicefunc)) {
    _id_EC326F14603F4347 = self[[level.bypassclasschoicefunc]]();
    self.class = _id_EC326F14603F4347;
  } else
    self.class = "class0";
}

ispresstofirstspawnmode() {
  if(getdvarint("dvar_EEAEBEBF98D1E9E7", 0) == 0)
    return 0;

  if(scripts\mp\utility\game::getgametype() == "infect")
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "dm" && istrue(level.aonrules))
    return 1;
  else if(scripts\mp\utility\game::getgametype() == "gun")
    return 1;

  return 0;
}

waitthensetspawnomnvar() {
  self endon("pressToSpawn");
  wait 1;

  if(isDefined(self))
    scripts\mp\utility\lower_message::setlowermessageomnvar("press_to_spawn");
}

beginteamchoice() {
  self setclientomnvar("ui_options_menu", 1);
}

menuspectator() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  addtoteam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

menuclass(_id_7E9CCC2D6DDB44DA) {
  team = self.pers["team"];
  class = scripts\mp\class::getclasschoice(_id_7E9CCC2D6DDB44DA);
  primary = scripts\mp\class::getweaponchoice(_id_7E9CCC2D6DDB44DA);

  if(class == "restricted") {
    beginclasschoice();
    return;
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] == class && (isDefined(self.pers["primary"]) && self.pers["primary"] == primary)) {
    return;
  }
  if(self.sessionstate == "playing") {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;

    if(game["state"] == "postgame") {
      return;
    }
    if(level.ingraceperiod && !self.hasdonecombat) {
      scripts\mp\class::setclass(self.pers["class"]);
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      scripts\mp\class::giveloadout(self.pers["team"], self.pers["class"]);
    } else
      self iprintlnbold(game["strings"]["change_class"]);
  } else {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;

    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !scripts\mp\utility\player::isinkillcam() && !scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      thread scripts\mp\playerlogic::spawnclient();
  }

  thread scripts\mp\spectating::setspectatepermissions();
}

addtoteam(team, _id_7EC298E587EB6719, _id_67D0631AD9027F83, _id_26C802633F90A05C) {
  if(isDefined(self.team)) {
    scripts\mp\playerlogic::removefromteamcount();

    if(isDefined(_id_67D0631AD9027F83) && _id_67D0631AD9027F83)
      scripts\mp\playerlogic::decrementalivecount(self.team, undefined, "addToTeam");

    _id_76CC264B397DB9CB::leavesquad(self.team, self._id_0FF97225579DE16A);
  }

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    if(isDefined(level.maxteamsize) && level.maxteamsize == 1) {
      if(!isbot(self) && isDefined(self.sessionteam))
        self._id_3F78C6A0862F9E25 = 0;
    }
  }

  if(isDefined(self.pers["team"]) && self.pers["team"] != "" && self.pers["team"] != "spectator" && self.pers["team"] != "codcaster")
    self.pers["last_team"] = self.pers["team"];

  self.changedteams = isDefined(self.pers["last_team"]) && self.pers["last_team"] != team;

  if(!level.teambased) {
    if(isbot(self) && (team != "allies" && team != "axis")) {
      self.pers["team"] = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "allies", "axis");
      self.team = "allies";
    } else {
      self.pers["team"] = team;
      self.team = team;
    }
  } else {
    self.pers["team"] = team;
    self.team = team;
  }

  _id_D31D331A4C57867B = isbot(self) || istestclient(self);

  if(_id_D31D331A4C57867B || scripts\mp\utility\game::_id_D7EC918E29C0B2F4())
    setsessionteam(team);
  else if(!scripts\mp\utility\game::denysystemicteamchoice()) {
    if(scripts\mp\utility\game::matchmakinggame() && !istrue(_id_26C802633F90A05C)) {
      if(!scripts\mp\utility\game::allowteamassignment()) {
        if(scripts\mp\utility\game::getgametype() == "infect")
          setsessionteam(team);
      }
    } else if(!_func_1EB7D2791D3C536F())
      setsessionteam(team);
  } else if(getdvarint("scr_skipclasschoice", 0) > 0) {
    if(!level.matchmakingmatch)
      setsessionteam(team);
  }

  if(game["state"] != "postgame")
    scripts\mp\playerlogic::addtoteamcount(istrue(_id_67D0631AD9027F83));

  scripts\mp\utility\game::updateobjectivetext();

  if(isDefined(_id_7EC298E587EB6719) && _id_7EC298E587EB6719)
    waittillframeend;

  if(team == "spectator" || team == "codcaster") {
    self notify("joined_spectators");
    scripts\mp\teams::onjoinedspectators(self);
    scripts\mp\spectating::onjoinedspectators(self);
    scripts\mp\bounty::onplayerjoinedspectators(self);
    scripts\cp_mp\pet_watch::onjoinspectators();
  } else
    self notify("joined_team");

  scripts\mp\utility\join_team_aggregator::onplayerjointeam(self);
  level notify("add_to_team", self);
}

setsessionteam(_id_6C47600D17957620) {
  if(level.teambased)
    self.sessionteam = _id_6C47600D17957620;
  else
    setemptysessionteam(_id_6C47600D17957620);
}

setemptysessionteam(_id_6C47600D17957620) {
  if(_id_6C47600D17957620 == "spectator")
    self.sessionteam = "spectator";
  else if(_id_6C47600D17957620 == "codcaster")
    self.sessionteam = "codcaster";
  else
    self.sessionteam = "none";
}

endrespawnnotify() {
  self.waitingtospawn = 0;
  self notify("end_respawn");
}

logteamselection(_id_6C278AC8DCBEF63E) {
  if(getdvarint("scr_playtest", 0) == 0) {
    return;
  }
  if(_id_6C278AC8DCBEF63E != "random")
    iprintlnbold("" + self.name + " did not select auto-assign");
}

debugprintsquads() {
  _id_63F43F469B885EC6 = 25;

  for(;;) {
    if(isDefined(level.squaddata)) {
      _id_1B11EAA9B42E5081 = 800;
      _id_1B11E9A9B42E4E4E = 25;
      _id_7918C27CB3E1349A = 1;

      foreach(team, _id_70643C8580524236 in level.squaddata) {
        _id_7918C27CB3E1349A = 1;
        _id_7918C27CB3E1349A++;

        foreach(squad in _id_70643C8580524236) {
          color = (1, 1, 1);

          if(isDefined(squad.activemission))
            color = (1, 1, 0);

          _id_7918C27CB3E1349A++;

          foreach(player in squad.players) {
            color = (1, 1, 1);

            if(istrue(player.squadassignedfromlobby))
              color = (0, 1, 0);

            _id_7918C27CB3E1349A++;
          }
        }

        _id_1B11EAA9B42E5081 = _id_1B11EAA9B42E5081 + 200;
      }
    }

    waitframe();
  }
}