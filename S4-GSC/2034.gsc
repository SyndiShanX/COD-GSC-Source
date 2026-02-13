/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2034.gsc
*************************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";

    if(level._id_A2FC) {
      game["menu_team"] = "team_mt_options";
    }

    game["menu_class"] = "class";
    game["menu_class_allies"] = "class_marines";
    game["menu_class_axis"] = "class_opfor";
    game["menu_changeclass_allies"] = "changeclass_marines";
    game["menu_changeclass_axis"] = "changeclass_opfor";

    if(level._id_A2FC) {
      for(var_0 = 0; var_0 < level._id_EF89.size; var_0++) {
        var_1 = "menu_class_" + level._id_EF89[var_0];
        var_2 = "menu_changeclass_" + level._id_EF89[var_0];
        game[var_1] = game["menu_class_allies"];
        game[var_2] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";
    game["menu_controls"] = "ingame_controls";

    if(level.splitscreen) {
      if(level._id_A2FC) {
        for(var_0 = 0; var_0 < level._id_EF89.size; var_0++) {
          var_1 = "menu_class_" + level._id_EF89[var_0];
          var_2 = "menu_changeclass_" + level._id_EF89[var_0];
          game[var_1] = game[var_1] + "_splitscreen";
          game[var_2] = game[var_2] + "_splitscreen";
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

    _func_01B4(&"MP/HOST_ENDED_GAME");
    _func_01B4(&"MP/HOST_ENDGAME_RESPONSE");
  }

  level _id_0A9A::_id_C287(::_id_AB21);
  level _id_0A9A::_id_C287(::_id_ABB8);
  level _id_000F::_id_990C("class_edit", ::_id_AA87);
  level _id_000F::_id_990C("class_select", ::_id_AA86);
  level thread _id_D5BD();
}

_id_ABB8(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    if(var_0 != "team_select") {
      return;
    }
    if(scripts\mp\utility\game::matchmakinggame()) {
      return;
    }
    _id_749D(var_0, var_1);
  }
}

_id_D5BD() {
  _func_0342(1);
  level waittill("prematch_over");
  _func_0342(0);
}

_id_8910(var_0) {
  return var_0 >= 100;
}

_id_6960(var_0) {
  var_0++;
  var_1 = undefined;

  if(var_0 > 100) {
    var_2 = var_0 - 100;
    var_1 = "default" + var_2;
  } else
    var_1 = "custom" + var_0;

  return var_1;
}

_id_FCAD(var_0) {
  var_1 = isai(self) || _func_03DA(self);

  if(!var_1) {
    return;
  }
}

_id_56E9(var_0, var_1) {
  if(isbot(self) || _func_03DA(self)) {
    self.pers["class"] = var_0;
    self.class = var_0;
  } else {
    var_2 = _id_6960(var_0);

    if(!isDefined(self.pers["class"]) || var_2 != self.pers["class"] || var_1) {
      self.pers["class"] = var_2;
      self.class = var_2;
      scripts\mp\class::_id_BB98(var_2);
    }

    if(scripts\mp\class::_id_DAFA() && scripts\mp\utility\game::getgametype() != "br") {
      thread scripts\mp\class::_id_EC08();
    } else {
      if(isalive(self)) {
        self iprintlnbold(game["strings"]["change_class"]);
      }

      if(var_0 < 100) {
        self setclientomnvar("ui_loadout_changed", scripts\mp\class::_id_6962(self.pers["class"]));
      }
    }
  }
}

_id_D60E(var_0) {
  var_1 = var_0;

  if(!isbot(self)) {
    if(isalive(self)) {
      self iprintlnbold(game["strings"]["revive_class"]);
    }

    var_1 = _id_6960(var_0);
  }

  self.pers["next_round_class"] = var_1;
}

_id_AB21(var_0, var_1) {
  if(var_0 != "end_game") {
    return;
  }
  if(scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  if(isdedicatedserver()) {
    return;
  }
  level thread scripts\mp\gamelogic::forceend(var_1);
}

_id_AA87(var_0) {
  self endon("disconnect");
  waittillframeend;
  _id_7428(var_0);
}

_id_AA86(var_0, var_1) {
  self notify("loadout_class_selected", var_0);

  if(level.systemlink && getdvarint("#x3fca802e5beab0d71") && self _meth_81D3()) {
    self setclientomnvar("ui_options_menu", 0);
  } else {
    _id_FCAD(var_0);

    if(istrue(self._id_10848)) {
      if(isDefined(self._id_C7BC)) {
        _id_D60E(var_0);
      }

      self setclientomnvar("ui_options_menu", 0);
      return;
    }

    if(!scripts\mp\utility\game::_id_159D() || scripts\mp\utility\game::_id_DCA8()) {
      return;
    }
    if(isDefined(self._id_C7BC) && isDefined(self._id_8305) && !scripts\mp\class::_id_DAFA()) {
      _id_D60E(var_0);
      return;
    }

    if("" + var_0 != "callback") {
      _id_56E9(var_0, istrue(var_1));
      return;
    }

    _id_9DD0("callback");
  }
}

_id_749D(var_0, var_1) {
  var_2 = 0;

  if(var_1 >= 3) {
    var_2 = 1;
  }

  if(var_2) {
    self setclientomnvar("ui_spectator_selected", 1);
    self._id_E3E6 = 1;
  } else {
    self setclientomnvar("ui_spectator_selected", -1);
    self._id_E3E6 = 0;
  }

  var_3 = self _meth_81D3();
  var_4 = !var_3 && isDefined(self.team) && (self.team == "spectator" || self.team == "follower");
  var_5 = var_3 && var_1 == 3 || var_4 && (var_1 == 4 || var_1 == 5);

  if(var_1 == 4 || var_1 == 5) {
    var_1 = 3;
    self _meth_834F(1);
  } else
    self _meth_834F(0);

  if(var_1 == 0) {
    var_1 = "axis";
  } else if(var_1 == 1) {
    var_1 = "allies";
  } else if(var_1 == 2) {
    var_1 = "random";
  } else {
    var_1 = "spectator";
  }

  if(!var_5 && isDefined(self.pers["team"]) && var_1 == self.pers["team"]) {
    return;
  }
  if(isDefined(self._id_AC3D)) {
    self._id_AC3D._id_C0E0 = 1;
  }

  thread _id_97B5(var_1);

  if(var_1 != "spectator") {
    self.pers["playerChoseSpectatorTeam"] = undefined;
  } else {
    self.pers["playerChoseSpectatorTeam"] = 1;
  }

  if(var_1 == "axis") {
    thread _id_D70D("axis");
  } else if(var_1 == "allies") {
    thread _id_D70D("allies");
  } else if(var_1 == "random") {
    thread _id_1F1D();
  } else if(var_1 == "spectator") {
    thread _id_D6E4(var_5);
  }
}

_id_7428(var_0) {
  var_1 = _id_6960(var_0);
  var_2 = scripts\mp\class::_id_9623(var_1);
  var_3 = scripts\mp\class::_id_9624();
  var_4 = var_2 || var_3;

  if(isDefined(self.pers["class"]) && var_1 == self.pers["class"] && var_4) {
    _id_AA86(var_0, 1);
  }
}

_id_1F1D() {
  if(scripts\mp\utility\game::getgametype() == "infect") {
    thread _id_D70D("allies");
  } else if(getdvarint("#x33b36102d7de7a194", 0) != 0) {
    thread _id_D70D("allies");
  } else if(isbot(self) && isDefined(self._id_28F7) && self._id_28F7 != "autoassign") {
    thread _id_D70D(self._id_28F7);
  } else {
    if(self _meth_81D3()) {
      thread _id_D6E4();
      return;
    }

    if(istrue(level._id_EF88)) {
      foreach(var_1 in level._id_EF89) {
        var_2 = scripts\mp\utility\teams::_id_6DCA(var_1, "teamCount");

        if(level.maxteamsize == 0 || var_2 < level.maxteamsize) {
          thread _id_D70D(var_1);
          break;
        }
      }

      return;
    }

    var_4 = 0;
    var_5 = [];

    foreach(var_1 in level._id_EF89) {
      if(getdvarint("#x3965a86c0b17996d3") == 1 && var_1 == "team_nine") {
        continue;
      }
      var_2 = scripts\mp\utility\teams::_id_6DCA(var_1, "teamCount");

      if(isDefined(self.team) && self.team == var_1) {
        var_2--;
      }

      if(!var_5.size || var_2 < var_4) {
        var_4 = var_2;
        var_5 = [];
        var_5[var_5.size] = var_1;
        continue;
      }

      if(var_2 == var_4) {
        var_5[var_5.size] = var_1;
      }
    }

    if(var_5.size == 1) {
      if(!isDefined(self.team) || self.team != var_5[0]) {
        thread _id_D70D(var_5[0]);
        return;
      }

      return;
    }

    if(level.teambased) {
      var_8 = scripts\mp\gamescore::_id_6AA0();

      if(scripts\engine\utility::array_contains(var_5, var_8)) {
        var_5 = scripts\engine\utility::array_remove(var_5, var_8);
      }
    }

    if(isDefined(self.team) && scripts\engine\utility::array_contains(var_5, self.team)) {
      var_5 = scripts\engine\utility::array_remove(var_5, self.team);
    }

    if(var_5.size > 0) {
      var_9 = randomint(var_5.size);
      thread _id_D70D(var_5[var_9]);
    }
  }
}

_id_D70D(var_0) {
  self endon("disconnect");

  if(!isai(self) && level.teambased && !scripts\mp\teams::_id_6AD1(var_0) && !scripts\mp\utility\game::_id_96B9()) {
    return;
  }
  if(level._id_7EB0 && !self._id_7555) {
    self._id_75B4 = 0;
    self.pers["lives"] = ::scripts\mp\utility\game::_id_6A65();
  }

  if(self.sessionstate == "playing") {
    self._id_EC33 = 1;
    self._id_8BDA = var_0;
    self._id_916E = self.pers["team"];

    if(scripts\mp\utility\game::_id_875E()) {
      self._id_EC34 = 1;
    }
  }

  if(istrue(game["isLaunchChunk"]) && isbot(self) == 0) {
    var_0 = "allies";
  }

  _id_1176(var_0);

  if(_id_DB87()) {
    thread _id_D6E7(var_0);
  }

  if(scripts\mp\utility\player::_id_89D5()) {
    self _meth_85B7(1);
  }

  if(self.sessionstate == "playing") {
    self suicide();
    scripts\mp\utility\player::_id_FD26("spectator");
    self._id_EAF6 = 1;
  }

  if(scripts\mp\utility\game::_id_159D() || scripts\mp\utility\game::_id_DCA8() && !isai(self)) {
    self setclientomnvar("ui_options_menu", 2);
  }

  if(isDefined(level._id_AB60)) {
    self thread[[level._id_AB60]]();
  }

  _id_107FC();
  _id_5342();

  if((self.sessionstate == "spectator" || _id_B6E9()) && !istrue(self._id_EAF6)) {
    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !scripts\mp\utility\player::_id_88C7()) {
      if(isDefined(self._id_1084A) && self._id_1084A) {
        return;
      }
      thread scripts\mp\playerlogic::_id_E285();
    }

    thread _id_081A::_id_D6E2();
  }

  self._id_EAF6 = undefined;
  self notify("okToSpawn");
}

_id_B6E9() {
  return isDefined(level._id_B6E9) && self[[level._id_B6E9]]();
}

_id_DB87() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "defcon":
    case "pill":
    case "base":
    case "arm":
      return 1;
    default:
      return 0;
  }
}

_id_D6E7(var_0) {
  if(!level.teambased) {
    return;
  }
  if(!isDefined(level._id_E48E)) {
    level _id_8298();
  }

  if(istrue(level.onlinegame)) {
    var_1 = self _meth_8714();

    if(isDefined(var_1) && var_1 >= 0) {
      _id_8BDC(var_0, var_1);
    } else {}

    return;
  }

  var_2 = _func_03DA(self) || self _meth_878F();

  if(!isai(self) && !var_2) {
    var_3 = self _meth_81DD();

    if(var_3 != -1) {
      self._id_E488 = 1;
      _id_8BDC(var_0, var_3);
      return;
    }
  }

  if(istrue(level.onlinegame)) {
    var_4 = self _meth_8133();

    if(isDefined(var_4) && var_4.size > 0) {
      var_1 = undefined;

      foreach(var_6 in var_4) {
        if(isDefined(var_6) && isDefined(var_6._id_E496)) {
          var_1 = var_6._id_E496;
          break;
        }
      }

      if(isDefined(var_1)) {
        _id_8BDC(var_0, var_1);
        return;
      } else {
        _id_C57C(var_0, 1);
        return;
      }
    }
  }

  findorrequestsquad(var_0);
}

findorrequestsquad(var_0) {
  foreach(var_2 in level._id_E48E[var_0]) {
    var_2._id_8874 = var_2.players.size == level._id_9CA6;

    if(var_2._id_84EF && !var_2._id_885A && !var_2._id_8874) {
      _id_8BDC(var_0, var_2.index);
      return;
    }
  }

  _id_C57C(var_0, 0);
}

_id_8298() {
  if(!isDefined(level._id_9CA6)) {
    level._id_9CA6 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_squadsize"), 4);
  }

  level._id_9CA7 = getdvarint("#x3e3568fc244ac0ac", 15);
  level._id_E48E = [];

  foreach(var_1 in level._id_EF89) {
    level._id_E48E[var_1] = [];
  }

  level thread _id_A144();

  if(getdvarint("#x37ae7e4ab61773efe", 0) == 1) {
    level thread _id_44F1();
  }
}

_id_4055(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level._id_E48E[var_0].size;
  }

  var_2 = spawnStruct();
  var_2.index = var_1;
  var_2._id_5F01 = gettime();
  var_2._id_885A = 0;
  var_2._id_8A62 = 0;
  var_2._id_8874 = 0;
  var_2._id_84EF = 1;
  var_2.players = [];
  var_2._id_E342 = undefined;
  level._id_E48E[var_0][var_1] = var_2;
  return var_1;
}

_id_355E() {
  foreach(var_1 in level._id_EF89) {
    foreach(var_3 in level._id_E48E[var_1]) {
      if(!var_3._id_84EF) {
        continue;
      }
      if(!var_3._id_8A62 && gettime() > var_3._id_5F01 + level._id_9CA7 * 1000) {
        var_3._id_8A62 = 1;
      }

      var_3._id_8874 = var_3.players.size == level._id_9CA6;
      var_4 = 0;

      foreach(var_6 in var_3.players) {
        if(isDefined(var_6)) {
          var_4 = 1;
        }
      }

      if(!var_4) {
        _id_5F55(var_1, var_3.index);
      }
    }
  }
}

_id_A144() {
  for(;;) {
    _id_355E();
    waitframe();
  }
}

_id_C57C(var_0, var_1) {
  var_2 = _id_68EC(var_0);
  var_3 = level._id_E48E[var_0][var_2];
  var_3.index = var_2;
  var_3._id_5F01 = gettime();
  var_3._id_885A = var_1;
  var_3._id_8A62 = 0;
  var_3._id_8874 = 0;
  var_3._id_84EF = 1;
  var_3.players = [];
  var_3._id_E4B0 = undefined;
  var_3._id_7E24 = undefined;
  _id_8BDC(var_0, var_2);
}

_id_8BDC(var_0, var_1) {
  if(!isDefined(level._id_E48E[var_0][var_1])) {
    _id_4055(var_0, var_1);
  } else if(level._id_E48E[var_0][var_1]._id_8874) {
    findorrequestsquad(var_0);
    return;
  }

  if(isDefined(self._id_E496)) {
    var_2 = 0;

    foreach(var_8, var_4 in level._id_E48E) {
      foreach(var_7, var_6 in var_4) {
        if(scripts\engine\utility::array_contains(var_6.players, self)) {
          level._id_E48E[var_8][var_7].players = scripts\engine\utility::array_remove(var_6.players, self);
          level._id_E48E[var_8][var_7]._id_8874 = level._id_E48E[var_8][var_7].players.size == level._id_9CA6;
          var_2 = 1;
          break;
        }
      }

      if(var_2) {
        break;
      }
    }
  }

  var_6 = level._id_E48E[var_0][var_1];
  self._id_E496 = var_1;
  self._id_E4A0 = var_6.players.size;
  var_9 = self._id_01F1;
  var_9 = var_9 | self._id_E4A0 + 1;
  self._id_01F1 = var_9;

  if(!istrue(level.onlinegame)) {
    self _meth_81DC(var_1);
  }

  var_6.players[self._id_E4A0] = self;
  _id_0A96::_id_AB6A(self);
  self notify("joined_squad");
  self.squadcolorindex = getfirstavailablesquadcolorindex(var_0, var_1);
  var_6._id_8874 = var_6.players.size == level._id_9CA6;

  if(level.gametype == "base") {
    var_10 = int(self._id_32FE);
    scripts\mp\gametypes\base::playersetsquadcashomnvar(var_10);
  }

  if(istrue(level._id_FED0)) {
    _id_362F(var_0, var_1);
  }

  _id_FD3F(var_0, var_1);
}

_id_916A(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    thread _id_0819::_id_C1AD(var_0, var_1);
  }

  if(isDefined(level.onleavesquad)) {
    self[[level.onleavesquad]]();
  }

  var_2 = 0;
  var_3 = _id_6D76(var_0, var_1);

  if(istrue(level._id_FED0) && isDefined(var_3) && var_3 == self) {
    level._id_E48E[var_0][var_1]._id_E49C = undefined;
    var_2 = 1;
  }

  level._id_E48E[var_0][var_1].players = scripts\engine\utility::array_remove(level._id_E48E[var_0][var_1].players, self);

  for(var_4 = 0; var_4 < level._id_E48E[var_0][var_1].players.size; var_4++) {
    level._id_E48E[var_0][var_1].players[var_4]._id_E4A0 = var_4;

    if(level.gametype == "base") {
      var_5 = level._id_E48E[var_0][var_1].players[var_4];
      var_6 = int(var_5._id_32FE);
      var_5 scripts\mp\gametypes\base::playersetsquadcashomnvar(var_6);
    }
  }

  if(istrue(var_2)) {
    var_7 = scripts\engine\utility::array_randomize(level._id_E48E[var_0][var_1].players);

    foreach(var_5 in var_7) {
      if(isDefined(var_5)) {
        var_5 _id_362F(var_0, var_1);
        break;
      }
    }
  }

  level._id_E48E[var_0][var_1]._id_8874 = level._id_E48E[var_0][var_1].players.size == level._id_9CA6;
  _id_FD3F(var_0, var_1);
}

getfirstavailablesquadcolorindex(var_0, var_1) {
  for(var_2 = 0; var_2 < level._id_9CA6; var_2++) {
    var_3 = 0;

    for(var_4 = 0; var_4 < level._id_E48E[var_0][var_1].players.size; var_4++) {
      var_5 = level._id_E48E[var_0][var_1].players[var_4];

      if(isDefined(var_5) && isDefined(var_5.squadcolorindex)) {
        if(var_2 == var_5.squadcolorindex) {
          var_3 = 1;
          break;
        }
      }
    }

    if(!var_3) {
      return var_2;
    }
  }

  return -1;
}

_id_FD3F(var_0, var_1) {
  var_2 = _id_6D76(var_0, var_1);

  foreach(var_4 in level._id_E48E[var_0][var_1].players) {
    var_5 = var_1;
    var_5 = var_5 + (level._id_E48E[var_0][var_1].players.size << 5);

    if(isDefined(var_2) && var_2 == var_4) {
      var_5 = var_5 + 256;
    }

    var_4 setclientomnvar("ui_squad_data", var_5);

    if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "base") {
      var_6 = var_4 getentitynumber();

      if(isDefined(var_2) && var_2 == var_4) {
        var_6 = var_6 + 2048;
      }

      if(isalive(var_4)) {
        var_6 = var_6 + 4096;
      }

      if(isDefined(var_4.squadcolorindex)) {
        for(var_7 = 0; var_7 < level._id_9CA6; var_7++) {
          if(var_7 == var_4.squadcolorindex) {
            var_6 = var_6 | 1 << 13 + var_7;
            continue;
          }

          var_6 = var_6 &~(1 << 13 + var_7);
        }
      }

      var_4 setclientomnvar("ui_arm_squadmember_" + var_4._id_E4A0, var_6);
      var_8 = scripts\engine\utility::array_remove(level._id_E48E[var_0][var_1].players, var_4);

      for(var_9 = 0; var_9 < 3; var_9++) {
        var_10 = var_8[var_9];

        if(isDefined(var_10)) {
          var_6 = var_10 getentitynumber();

          if(isDefined(var_2) && var_2 == var_10) {
            var_6 = var_6 + 2048;
          }

          if(isalive(var_10)) {
            var_6 = var_6 + 4096;
          }

          if(isDefined(var_10.squadcolorindex)) {
            for(var_7 = 0; var_7 < level._id_9CA6; var_7++) {
              if(var_7 == var_10.squadcolorindex) {
                var_6 = var_6 | 1 << 13 + var_7;
                continue;
              }

              var_6 = var_6 &~(1 << 13 + var_7);
            }
          }
        } else
          var_6 = -1;

        var_11 = var_9 + 1;

        if(isDefined(var_10) && isDefined(var_10._id_E4A0)) {
          var_11 = var_10._id_E4A0;
        }

        var_4 setclientomnvar("ui_arm_squadmember_" + var_11, var_6);
      }
    }
  }
}

_id_68EC(var_0) {
  foreach(var_2 in level._id_E48E[var_0]) {
    if(!var_2._id_84EF) {
      return var_2.index;
    }
  }

  return _id_4055(var_0);
}

_id_5F55(var_0, var_1) {
  level._id_E48E[var_0][var_1]._id_5F01 = undefined;
  level._id_E48E[var_0][var_1]._id_885A = 0;
  level._id_E48E[var_0][var_1]._id_8A62 = 0;
  level._id_E48E[var_0][var_1]._id_8874 = 0;
  level._id_E48E[var_0][var_1]._id_84EF = 0;
  level._id_E48E[var_0][var_1].players = [];
  level._id_E48E[var_0][var_1]._id_E4B0 = undefined;
  level._id_E48E[var_0][var_1]._id_7E24 = undefined;
}

_id_362F(var_0, var_1) {
  if(isDefined(_id_6D76(var_0, var_1))) {
    return;
  }
  if(istrue(level.onlinegame)) {
    var_2 = self _meth_8133();

    if(isDefined(var_2) && var_2.size > 0) {
      if(self _meth_81BF()) {
        foreach(var_5, var_4 in level._id_E48E[self.team][self._id_E496].players) {
          if(var_4 == self) {
            level._id_E48E[var_0][var_1]._id_E49C = var_5;
          }
        }
      } else
        return;
    }
  }

  foreach(var_5, var_4 in level._id_E48E[self.team][self._id_E496].players) {
    if(var_4 == self) {
      level._id_E48E[var_0][var_1]._id_E49C = var_5;
    }
  }
}

_id_6D76(var_0, var_1) {
  var_2 = level._id_E48E[var_0][var_1]._id_E49C;

  if(!isDefined(var_2)) {
    return undefined;
  }

  return level._id_E48E[var_0][var_1].players[var_2];
}

_id_D6E4(var_0) {
  if((!isDefined(var_0) || !var_0) && isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self._id_EC33 = 1;
    self._id_8BDA = "spectator";
    self._id_916E = self.pers["team"];

    if(self.sessionstate == "playing") {
      self suicide();
    }
  }

  self notify("becameSpectator");
  _id_1176("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::_id_E37D();
}

_id_D565(var_0) {
  if((!isDefined(var_0) || !var_0) && isDefined(self.pers["team"]) && self.pers["team"] == "follower") {
    return;
  }
  if(isalive(self)) {
    self._id_EC33 = 1;
    self._id_8BDA = "follower";
    self._id_916E = self.pers["team"];
    self suicide();
  }

  self notify("becameSpectator");
  _id_1176("follower");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::_id_E37D();
}

_id_107FC() {
  self endon("disconnect");
  level endon("game_ended");
  self._id_10848 = 1;

  if(_id_07D1::_id_60BE("prematch_done") && istrue(level._id_FECE) && !istrue(self._id_75B4)) {
    self setclientomnvar("ui_world_fade", 1.0);
    self setclientomnvar("ui_hide_objectives", 1);
    self setclientomnvar("ui_in_spawn_camera", 1);
  }

  for(;;) {
    var_0 = scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::_id_159D() && !_id_07D1::_id_60BE("prematch_done");
    var_1 = scripts\mp\utility\game::_id_EF76(self.team) && !_id_07D1::_id_60BE("infil_started") && !isDefined(level._id_2DF4);
    var_2 = istrue(level.infil_s4_will_run) && !_id_07D1::_id_60BE("s4_infil_started");

    if(var_0 || var_1 || var_2) {
      var_3 = "class_select";

      if(!isai(self)) {
        var_4 = self getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");

        if(!isDefined(var_4)) {
          var_4 = 100;
        }
      } else
        var_4 = "callback";
    } else if(scripts\mp\utility\game::_id_159D() || scripts\mp\utility\game::_id_DCA8() && !isai(self)) {
      if(!self _meth_81D3() && getdvarint("#x39293fbc549331d5c", 0) == 0 && self.team != "spectator" && scripts\mp\utility\game::getgametype() != "arm") {
        _id_0A99::_id_D5EA(15);
      }

      self waittill("loadout_class_selected", var_4);
    } else {
      _id_2DF3();
      break;
    }

    if(self.team == "spectator") {
      continue;
    }
    if("" + var_4 != "callback") {
      if(isbot(self) || _func_03DA(self)) {
        self.pers["class"] = var_4;
        self.class = var_4;
      } else {
        var_4 = var_4;
        self.pers["class"] = _id_6960(var_4);
        self.class = _id_6960(var_4);
      }

      _id_0A99::_id_D5EA(0);
      self._id_10848 = 0;
    } else {
      self._id_10848 = 0;
      _id_9DD0("callback");
    }

    break;
  }
}

_id_24A6(var_0) {
  var_1 = self.pers["team"];

  if(scripts\mp\utility\game::_id_159D() || scripts\mp\utility\game::_id_DCA8() && !isai(self)) {
    self setclientomnvar("ui_options_menu", 2);

    if(!self _meth_81D3()) {
      _id_107FC();
    }

    _id_5342();

    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }
      if(game["state"] == "playing" && !scripts\mp\utility\player::_id_88C7()) {
        if(isDefined(self._id_1084A) && self._id_1084A) {
          return;
        }
        thread scripts\mp\playerlogic::_id_E285();
      }

      thread _id_081A::_id_D6E2();
    }

    self._id_3B86 = gettime();
    self notify("okToSpawn");
  } else
    thread _id_2DF3();
}

_id_2DF3() {
  self._id_D05C = 1;
  self._id_10848 = 0;

  if(scripts\mp\utility\game::getgametype() == "infect" && level.enforceantiboosting && !isbot(self)) {
    _id_0A99::_id_D5EA(1);
    self notifyonplayercommand("pressToSpawn", "+usereload");
    self notifyonplayercommand("pressToSpawn", "+activate");
    thread _id_1086D();
    self waittill("pressToSpawn");
  }

  if(isDefined(level._id_2DF4)) {
    var_0 = self[[level._id_2DF4]]();
    self.class = var_0;
  } else
    self.class = "class0";
}

_id_1086D() {
  self endon("pressToSpawn");
  wait 1;

  if(isDefined(self)) {
    _id_0A99::_id_D5EA(1);
  }
}

_id_24B7() {
  self setclientomnvar("ui_options_menu", 1);
}

_id_9DD7() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }
  if(isalive(self)) {
    self._id_EC33 = 1;
    self._id_8BDA = "spectator";
    self._id_916E = self.pers["team"];
    self suicide();
  }

  _id_1176("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::_id_E37D();
}

_id_9DD0(var_0) {
  var_1 = self.pers["team"];
  var_2 = scripts\mp\class::_id_6960(var_0);
  var_3 = scripts\mp\class::_id_6E6C(var_0);

  if(var_2 == "restricted") {
    _id_24A6();
    return;
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] == var_2 && (isDefined(self.pers["primary"]) && self.pers["primary"] == var_3)) {
    return;
  }
  if(self.sessionstate == "playing") {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self._id_8FAF = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    self.pers["primary"] = var_3;

    if(game["state"] == "postgame") {
      return;
    }
    if(level.mapname == "mp_s4_practice" || level._id_7EB0 && !self._id_7555) {
      scripts\mp\class::_id_D4D3(self.pers["class"]);
      self._id_046D = undefined;
      self._id_ED41 = undefined;
      scripts\mp\class::_id_6FB1(self.pers["team"], self.pers["class"]);
    } else
      self iprintlnbold(game["strings"]["change_class"]);
  } else {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self._id_8FAF = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    self.pers["primary"] = var_3;

    if(game["state"] == "postgame") {
      return;
    }
    if(game["state"] == "playing" && !scripts\mp\utility\player::_id_88C7()) {
      thread scripts\mp\playerlogic::_id_E285();
    }
  }

  thread _id_081A::_id_D6E2();
}

_id_1176(var_0, var_1, var_2) {
  if(isDefined(self.team)) {
    scripts\mp\playerlogic::_id_C4BD();

    if(isDefined(var_2) && var_2) {
      scripts\mp\playerlogic::_id_4554(self.team);
    }

    if(_id_DB87() && isDefined(self._id_E496) && self.team != "spectator") {
      _id_916A(self.team, self._id_E496);
    }
  }

  if(isDefined(self.pers["team"]) && self.pers["team"] != "" && self.pers["team"] != "spectator") {
    self.pers["last_team"] = self.pers["team"];
  }

  self._id_33DB = isDefined(self.pers["last_team"]) && self.pers["last_team"] != var_0;
  self.pers["team"] = var_0;
  self.team = var_0;
  var_3 = isbot(self) || _func_03DA(self);

  if(var_3) {
    _id_D6C4(var_0);
  } else if(!scripts\mp\utility\game::_id_47C7()) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      if(!scripts\mp\utility\game::_id_15DB()) {
        if(_id_15D3()) {
          _id_D6C4(var_0);
        } else {
          _id_D53B(var_0);
        }
      }
    } else if(!_func_0474())
      _id_D6C4(var_0);
  }

  if(game["state"] != "postgame") {
    scripts\mp\playerlogic::_id_1177(istrue(var_2));
  }

  scripts\mp\utility\game::_id_FCD2();

  if(isDefined(var_1) && var_1) {
    waittillframeend;
  }

  if(var_0 == "spectator" || var_0 == "follower") {
    self notify("joined_spectators");
    scripts\mp\teams::_id_AB04(self);
    _id_081A::_id_AB04(self);
    _id_07B4::_id_AB68(self);
    _id_0798::_id_AB06();
  } else
    self notify("joined_team");

  _id_0A97::_id_AB6B(self);
  _id_0A21::_id_AB05(self);
  level notify("add_to_team", self);
}

_id_15D3() {
  if(scripts\mp\utility\game::getgametype() == "infect") {
    return 1;
  }

  return 0;
}

_id_D6C4(var_0) {
  if(level.teambased) {
    self.sessionteam = var_0;
  } else {
    _id_D53B(var_0);
  }
}

_id_D53B(var_0) {
  if(var_0 == "spectator") {
    self.sessionteam = "spectator";
  } else if(var_0 == "follower") {
    self.sessionteam = "follower";
  } else {
    self.sessionteam = "none";
  }
}

_id_5342() {
  self._id_10849 = 0;

  if(istrue(self.waitingforrespawnbutton)) {
    self._id_82F0 = 0;
    self.waitingforrespawnbutton = 0;
  }

  self notify("end_respawn");
}

_id_97B5(var_0) {
  if(getdvarint("#x3decf448ab3afab5f", 0) == 0) {
    return;
  }
  if(var_0 != "random") {
    iprintlnbold("" + self.name + " did not select auto-assign");
  }
}

_id_44F1() {
  var_0 = 25;

  for(;;) {
    if(isDefined(level._id_E48E)) {
      var_1 = 800;
      var_2 = 25;
      var_3 = 1;

      foreach(var_13, var_5 in level._id_E48E) {
        var_3 = 1;
        var_3++;

        foreach(var_7 in var_5) {
          var_8 = (1, 1, 1);

          if(isDefined(var_7._id_0F4E)) {
            var_8 = (1, 1, 0);
          }

          var_3++;

          foreach(var_10 in var_7.players) {
            var_8 = (1, 1, 1);

            if(istrue(var_10._id_E488)) {
              var_8 = (0, 1, 0);
            }

            var_3++;
          }
        }

        var_1 = var_1 + 200;
      }
    }

    waitframe();
  }
}