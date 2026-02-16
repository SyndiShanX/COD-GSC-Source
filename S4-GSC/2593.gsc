/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2593.gsc
*************************************************/

_id_7E25(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "get_all_infils")) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("infil", "get_all_infils", ::_id_6331);
  }

  while(!isDefined(level._id_EF89)) {
    waitframe();
  }

  if(!isDefined(game["infil"])) {
    foreach(var_9 in level._id_EF89) {
      game["infil"][var_9] = [];
    }

    game["infil"]["types"] = [];
  }

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    var_11 = _id_6331(var_0);

    foreach(var_13 in var_11) {
      if(var_13.name == var_1) {
        if(isDefined(var_13._id_CD99) && var_13._id_CD99 == level._id_96CC) {
          break;
        }
      }
    }
  }

  if(isDefined(game["infil"]["types"][var_0]) && isDefined(game["infil"]["types"][var_0][var_1])) {
    if(isDefined(game["infil"]["types"][var_0][var_1]["persistentVehicle"])) {
      self[[game["infil"]["types"][var_0][var_1]["persistentVehicle"]]](var_0, var_1);
    }

    return;
  }

  game["infil"]["types"][var_0][var_1] = [];
  game["infil"]["types"][var_0][var_1]["spawn_func"] = var_5;
  game["infil"]["types"][var_0][var_1]["player_func"] = var_7;
  game["infil"]["types"][var_0][var_1]["get_length_func"] = var_6;
  game["infil"]["types"][var_0][var_1]["seats"] = var_2;
  game["infil"]["types"][var_0][var_1]["required_seats"] = var_3;
  game["infil"]["types"][var_0][var_1]["fill_order"] = var_4;
}

_id_7E46() {
  if(!isDefined(level._id_83A9)) {
    level._id_83A9 = getdvarint("#x394963c8bb5f85616", 0) == 1;
  }

  return level._id_83A9;
}

_id_7E43() {
  var_0 = 0;

  if(var_0 || level.rankedmatch && !isdedicatedserver()) {
    game["infil"] = undefined;
    _id_07D1::_id_60C1("infil_setup_complete");
    return;
  }

  if(game["roundsPlayed"] > 0 || getdvarint("#x3825ceef1dcf1a340", 0) == 1 || getdvarint("#x3e12f5848d48904c5", 1) == 1 || !_id_60F8()) {
    game["infil"] = undefined;
    _id_07D1::_id_60C1("infil_setup_complete");
    return;
  }

  if(!isDefined(level._id_BBAE) || level._id_BBAE == 0) {
    game["infil"] = undefined;
    _id_07D1::_id_60C1("infil_setup_complete");
    return;
  }

  while(!isDefined(level._id_EF89)) {
    waitframe();
  }

  waitframe();
  _id_0A8E::_id_C285(::_id_AB63);
  level._id_BB9F = ::_id_7E4E;
  var_1 = undefined;
  level._id_7E75 = 0;

  foreach(var_3 in _id_6331()) {
    var_4 = var_3._id_039B;
    var_5 = var_3.name;

    if(!var_3 _id_7E45()) {
      continue;
    }
    if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
      if(var_3.name == var_5) {
        if(!isDefined(var_3._id_CD99) || var_3._id_CD99 != level._id_96CC) {
          continue;
        }
      }
    }

    if(var_3 _id_7E31()) {
      _id_7E44();
    }

    var_6 = var_3._id_CE7D;

    if(var_3 _id_7E48(var_4) && var_3 _id_7E47(var_5) && scripts\mp\utility\teams::_id_8878(var_3._id_CE7D)) {
      level._id_7E75++;
      var_7 = game["infil"]["types"][var_4][var_5];
      var_8 = var_5;
      var_9 = var_5;

      if(issubstr(var_9, "alpha")) {
        var_9 = "alpha";
      }

      if(issubstr(var_9, "bravo")) {
        var_9 = "bravo";
      }

      if(!isDefined(var_7)) {
        var_7 = game["infil"]["types"][var_4][var_9];
      }

      var_10 = var_3[[var_7["spawn_func"]]](var_3._id_CE7D, var_3.target, var_9, var_8);
      var_10.players = [];
      var_10.type = var_4;
      var_10._id_AC92 = var_8;
      var_10._id_EAC7 = var_9;
      var_10._id_7E71 = var_10[[var_7["get_length_func"]]](var_9);

      if(!isDefined(var_1) || var_1 < var_10._id_7E71) {
        var_1 = var_10._id_7E71 + 1.0;
      }

      var_6 = var_3._id_CE7D;
      game["infil"][var_6]["lanes"][var_4][var_5] = var_10;
      _id_C1ED(var_6, var_10, var_7["seats"], var_7["required_seats"], var_7["fill_order"], var_7["player_func"]);

      if(var_3 _id_7E31()) {
        _id_081C::_id_10A5("to_infil", var_10, var_6, var_3._id_CD99);
      }
    }
  }

  if(scripts\mp\utility\game::_id_60C3() && isDefined(var_1)) {
    level thread onplayerspawned();
    level._id_BBAD = getdvarint("#x3eca1f58470677919", 15);
    level._id_9BAA = var_1 + 2.0;
    level._id_BBAE = var_1 + 2.0;
    thread scripts\mp\gamelogic::_id_9BF2("match_starting_in", level._id_BBAD + level._id_BBAE);
    level thread _id_7E59();
    level thread _id_7E61();
    level thread _id_107DF();
    _id_07D1::_id_60C1("infil_will_run");
  }

  _id_07D1::_id_60C1("infil_setup_complete");
}

_id_60F8() {
  if(scripts\mp\utility\game::getgametype() == "br") {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "war" && level.script == "mp_donetsk") {
    return 0;
  }

  if(scripts\mp\utility\game::getgametype() == "sd") {
    return 0;
  }

  return 1;
}

onplayerspawned() {
  level endon("infil_started");

  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 thread _id_1082E();
  }
}

_id_1082E() {
  level endon("infil_started");
  self endon("death_or_disconnect");

  if(isDefined(self.team)) {
    _id_07D1::_id_60C2("infil_setup_complete");

    if(_id_07D1::_id_60BE("infil_will_run") && !_id_07D1::_id_60BE("prematch_done")) {
      var_0 = (0, 0, 0);
      var_1 = 0;

      if(isDefined(game["infil"]) && isDefined(game["infil"][self.team]) && isDefined(game["infil"][self.team]["lanes"])) {
        foreach(var_7, var_3 in game["infil"][self.team]["lanes"]) {
          foreach(var_5 in var_3) {
            var_0 = var_0 + var_5.origin;
            var_1++;
          }
        }
      }

      if(var_1 > 0) {
        var_0 = var_0 / var_1;
      }

      self _meth_8282(var_0);
    }
  }

  while(!istrue(self.pers["streamSyncComplete"])) {
    waitframe();
  }

  var_8 = _id_677D(self, scripts\mp\utility\game::_id_6BE2(self.team)[0]);

  if(isDefined(var_8)) {
    _id_B47F(self, scripts\mp\utility\game::_id_6BE2(self.team)[0]);
  }

  _id_B529();
}

_id_AB05(var_0) {
  if(_id_07D1::_id_60BE("infil_will_run") && !_id_07D1::_id_60BE("infil_started")) {
    if(isDefined(var_0.team) && var_0.team == "spectator") {
      var_0 thread _id_7E78();
    }
  }
}

_id_7E78() {
  self endon("joined_team");
  self endon("disconnect");
  self notify("infilSpectatorView");
  self endon("infilSpectatorView");
  thread _id_7E58(0.0, 0.55);
}

_id_AB63(var_0) {
  if(!isDefined(var_0._id_7E24)) {
    return;
  }
  if(_id_07D1::_id_60BE("prematch_done")) {
    return;
  }
  _id_B47F(var_0, var_0.team);
}

_id_AB58() {
  level endon("prematch_over");
  self endon("player_free_spot");
  var_0 = self.team;
  scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  _id_B47F(self, var_0);
}

_id_6331(var_0) {
  if(isDefined(var_0)) {
    return scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  } else {
    var_1 = scripts\engine\utility::getStructArray("mp_infil", "targetname");
  }

  return scripts\engine\utility::getStructArray("mp_infil", "targetname");
}

_id_7E48(var_0) {
  return self._id_039B == var_0;
}

_id_7E47(var_0) {
  return self.name == var_0;
}

_id_7E45() {
  if(!isDefined(self._id_03EA) || self._id_03EA == 0) {
    return 0;
  }

  if(!level.teambased) {
    return 0;
  }

  if(self._id_03EA & 1) {
    if(level.gametype == "sd" && level.mapname == "mp_petrograd" || level.gametype == "sd" && level.mapname == "mp_piccadilly") {
      return 0;
    } else {
      return 1;
    }
  }

  if(self._id_03EA & 2) {
    switch (level.gametype) {
      case "grind":
      case "war":
      case "tjugg":
      case "pill":
      case "conf":
        return 1;
    }
  }

  if(self._id_03EA & 4) {
    switch (level.gametype) {
      case "dd":
      case "sr":
      case "sd":
        if(level.mapname == "mp_petrograd" || level.mapname == "mp_piccadilly") {
          return 0;
        } else {
          return 1;
        }
    }
  }

  if(self._id_03EA & 8) {
    switch (level.gametype) {
      case "siege":
      case "dom":
        return 1;
    }
  }

  if(self._id_03EA & 16) {
    switch (level.gametype) {
      case "grnd":
      case "hq":
      case "koth":
        return 1;
    }
  }

  if(self._id_03EA & 32) {
    switch (level.gametype) {
      case "ctf":
        return 1;
    }
  }

  if(self._id_03EA & 64) {
    switch (level.gametype) {
      case "cyber":
        return 1;
    }
  }

  if(self._id_03EA & 128) {
    switch (level.gametype) {
      case "cmd":
      case "base":
      case "arm":
        return 1;
    }
  }

  return 0;
}

_id_7E31() {
  return isDefined(self._id_CD99) && level.gametype == "tac_ops";
}

_id_7E44() {
  if(level.gametype == "tac_ops" && !isDefined(game["infil"]["map_config"])) {
    _id_081C::init();
    _id_081C::_id_D45F("to_infil", "allies");
    _id_081C::_id_D45F("to_infil", "axis");
    game["infil"]["map_config"] = 1;
  }
}

_id_7E4E(var_0, var_1) {
  if(self ishost() && getdvarint("#x367977773f2b2af4f") == 1) {
    scripts\common\utility::_id_158D(var_0);
    return;
  }

  if(!scripts\mp\utility\game::_id_EF76(self.team) && !istrue(var_1)) {
    scripts\mp\playerlogic::_id_B75B(var_0);
    return;
  }

  self allowmovement(var_0);
  scripts\common\utility::_id_1570(var_0);
  scripts\common\utility::_id_1530(var_0);
  scripts\common\utility::_id_154E(var_0);
  scripts\common\utility::_id_153E(var_0);
  scripts\common\utility::_id_151F(var_0);
  scripts\common\utility::_id_1581(var_0);
  scripts\common\utility::_id_1554(var_0);
  scripts\common\utility::_id_1575(var_0);
  scripts\common\utility::_id_1551(var_0);
  scripts\common\utility::_id_157F(var_0);
  scripts\common\utility::_id_1562(var_0);
  scripts\common\utility::_id_1593(var_0);
  scripts\common\utility::_id_158A(var_0);
}

_id_C1ED(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(game["infil"][var_0]["spots"])) {
    game["infil"][var_0]["spots"] = [];
  }

  var_6 = game["infil"][var_0]["spots"].size;

  for(var_7 = 0; var_7 < var_2; var_7++) {
    var_8 = game["infil"][var_0]["spots"].size;

    if(isDefined(var_4)) {
      var_9 = 0;

      foreach(var_15, var_11 in var_4) {
        foreach(var_13 in var_11) {
          if(var_13 == var_8 - var_6) {
            game["infil"][var_0]["spots"][var_8]["priority"] = var_15;
            var_9 = 1;
            break;
          }
        }

        if(var_9) {
          break;
        }
      }
    } else
      game["infil"][var_0]["spots"][var_8]["priority"] = -1;

    game["infil"][var_0]["spots"][var_8]["seat"] = var_7;
    game["infil"][var_0]["spots"][var_8]["infil"] = var_1;
    game["infil"][var_0]["spots"][var_8]["callback"] = var_5;
  }

  if(!istrue(level._id_C587)) {
    level._id_C586[var_0] = level._id_C586[var_0] + var_3;
  }
}

_id_B56A(var_0, var_1) {
  if(!isDefined(game["infil"][var_0.team]["spots"])) {}

  if(!isDefined(game["infil"][var_0.team]["spots"][var_1])) {}

  if(isDefined(game["infil"][var_0.team]["spots"][var_1]["player"])) {}

  game["infil"][var_0.team]["spots"][var_1]["player"] = var_0;
  return game["infil"][var_0.team]["spots"][var_1];
}

_id_B47F(var_0, var_1) {
  var_0 setclientomnvar("ui_player_in_infil", 0);

  if(!isDefined(var_1)) {
    var_1 = var_0.team;
  }

  if(!isDefined(game["infil"][var_1]["spots"])) {}

  foreach(var_4, var_3 in game["infil"][var_1]["spots"]) {
    if(_id_86CE(var_1, var_4) && var_3["player"] == var_0) {
      game["infil"][var_1]["spots"][var_4]["player"] = undefined;
      var_0 notify("player_free_spot");
      return;
    }
  }
}

_id_6664(var_0, var_1) {
  return game["infil"][var_0]["spots"][var_1]["player"];
}

_id_677D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.team;
  }

  if(!isDefined(game["infil"][var_1]["spots"])) {
    return undefined;
  }

  foreach(var_4, var_3 in game["infil"][var_1]["spots"]) {
    if(isDefined(var_3["player"]) && var_3["player"] == var_0) {
      return var_4;
    }
  }

  return undefined;
}

_id_86CE(var_0, var_1) {
  if(!isDefined(game["infil"][var_0]["spots"])) {}

  if(!isDefined(game["infil"][var_0]["spots"][var_1])) {}

  return isDefined(game["infil"][var_0]["spots"][var_1]["player"]);
}

_id_677F(var_0) {
  if(!isDefined(game["infil"][var_0]["spots"])) {}

  var_1 = 0;

  foreach(var_4, var_3 in game["infil"][var_0]["spots"]) {
    if(_id_86CE(var_0, var_4)) {
      var_1++;
    }
  }

  return var_1;
}

_id_677C(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in game["infil"][var_0]["spots"]) {
    if(!_id_86CE(var_0, var_4)) {
      var_1[var_1.size] = var_4;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = getdvarint("#x3e4a368269dd5f893", -1);

  if(scripts\engine\utility::array_contains(var_1, var_5)) {
    return var_5;
  }

  var_6 = [];
  var_7 = -1;

  foreach(var_3 in var_1) {
    var_9 = game["infil"][var_0]["spots"][var_3]["priority"];

    if(var_6.size == 0 || var_9 < var_7) {
      var_6 = [];
      var_6[var_6.size] = var_3;
      var_7 = var_9;
      continue;
    }

    if(var_9 == var_7) {
      var_6[var_6.size] = var_3;
    }
  }

  return var_6[randomint(var_6.size)];
}

_id_677E(var_0) {
  while(!isDefined(self._id_5E8B)) {
    waitframe();
  }

  var_1 = scripts\engine\utility::ter_op(var_0 == "allies", "a", "b") + _func_00D6(self._id_5E8B, 5, 6);
  var_2 = [];

  foreach(var_5, var_4 in game["infil"][var_0]["spots"]) {
    if(issubstr(var_4["infil"]._id_8EA8, var_1) && !_id_86CE(var_0, var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  if(var_2.size == 0) {
    return undefined;
  }

  var_6 = [];
  var_7 = -1;

  foreach(var_4 in var_2) {
    var_9 = game["infil"][var_0]["spots"][var_4]["priority"];

    if(var_6.size == 0 || var_9 < var_7) {
      var_6 = [];
      var_6[var_6.size] = var_4;
      var_7 = var_9;
      continue;
    }

    if(var_9 == var_7) {
      var_6[var_6.size] = var_4;
    }
  }

  return var_6[randomint(var_6.size)];
}

_id_66E3(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in game["infil"][var_0]["spots"]) {
    if(!_id_86CE(var_0, var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  if(var_2.size == 0) {
    return undefined;
  }

  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::array_remove(var_2, var_1);
  }

  var_4 = scripts\engine\utility::random(var_2);
  return var_4;
}

_id_67A7(var_0) {
  if(!isDefined(game["infil"][var_0]["spots"])) {
    return 0;
  }

  var_1 = 0;

  foreach(var_4, var_3 in game["infil"][var_0]["spots"]) {
    if(_id_86CE(var_0, var_4)) {
      var_1++;
    }
  }

  return var_1;
}

_id_67A8(var_0) {
  if(!isDefined(game["infil"][var_0]["spots"])) {
    return 0;
  }

  var_1 = 0;
  var_2 = 0;

  foreach(var_5, var_4 in game["infil"][var_0]["spots"]) {
    var_1++;

    if(_id_86CE(var_0, var_5)) {
      var_2++;
    }
  }

  return var_2 / var_1;
}

_id_66E4(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in game["infil"][var_0]["spots"]) {
    if(var_5["infil"] != var_1) {
      continue;
    }
    if(!_id_86CE(var_0, var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  if(var_2.size == 0) {
    return undefined;
  }

  var_4 = scripts\engine\utility::random(var_2);
  return var_4;
}

_id_7E50(var_0) {
  self endon("death");
  self.players = scripts\engine\utility::array_add(self.players, var_0);
  var_0 waittill("death_or_disconnect");
  self.players = scripts\engine\utility::array_remove(self.players, var_0);
}

_id_B529() {
  if(_id_07D1::_id_60BE("infil_started")) {
    return;
  }
  if(game["infil"][self.team].size == 0) {
    return;
  }
  if(self ishost() && getdvarint("#x367977773f2b2af4f") == 1) {
    _id_B3A6();
    return;
  }

  var_0 = 0;
  var_1 = game["infil"][self.team]["spots"][0]["priority"] != -1;

  if(level.gametype == "tac_ops" && isDefined(self._id_ED18._id_50B4)) {
    var_2 = _id_66E4(self.team, self._id_ED18._id_50B4);
  } else if(var_0) {
    var_2 = _id_677F(self.team);
  } else if(var_1) {
    var_2 = _id_677C(self.team);
  } else {
    var_2 = _id_66E3(self.team);
  }

  var_3 = getdvarint("#x320470a8f895163be", -1);

  if(var_3 != -1) {
    if(scripts\engine\utility::is_equal(self, level.player)) {
      var_2 = var_3;
    } else {
      var_2 = _id_66E3(self.team, var_3);
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  var_4 = _id_B56A(self, var_2);
  var_4["infil"] thread _id_7E50(self);
  self notify("player_added_to_infil");
  self._id_7E24 = var_4["infil"];
  self thread[[var_4["callback"]]](var_4["infil"], var_4["seat"]);
  self setclientomnvar("ui_player_in_infil", 1);
  thread _id_AB58();
  thread _id_3946();
  _id_B3A6();
}

_id_3946() {
  self endon("disconnect");
  level waittill("prematch_done");
  self _meth_8638("iw8_playermotion_mp");
  self _meth_84AC("normal");
}

_id_25A5() {
  self endon("disconnect");
  self._id_46E2 = 1;
  level waittill("prematch_over");
  self._id_46E2 = 0;
}

_id_B3A6() {}

_id_7E59() {
  setomnvar("ui_in_infil", 3);
  level waittill("infil_started");
  var_0 = _func_00BE("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);

  if(!isDefined(level._id_2DF4)) {
    _func_01EA("ui_skip_loadout", 0);
    level._id_2DF4 = undefined;
  }

  level thread _id_7E5A();
  var_1 = getdvarint("#x374e27e8df3d55867");
  var_2 = getdvarint("#x396e27990abf87bd5");
  var_3 = getdvarint("#x379a74717c4043423");
  setDvar("#x374e27e8df3d55867", 0);
  setDvar("#x396e27990abf87bd5", 1);
  setDvar("#x379a74717c4043423", 1);
  level waittill("prematch_done");
  var_4 = scripts\mp\utility\player::_id_165C();

  foreach(var_6 in level.players) {
    if(var_4) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
        var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
      var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
    }
  }

  setomnvar("ui_in_infil", -1);
  setomnvar("ui_always_show_nameplates", var_0);
  setDvar("#x374e27e8df3d55867", var_1);
  setDvar("#x396e27990abf87bd5", var_2);
  setDvar("#x379a74717c4043423", var_3);
}

_id_7E5A() {
  wait(level._id_BBAE - 5);
  setomnvar("ui_in_infil", 2);
}

_id_1659() {
  var_0 = self _meth_8587();

  if(var_0 == "AR") {
    var_1 = "default1";
  } else if(var_0 == "SMG") {
    var_1 = "default2";
  } else if(var_0 == "LMG") {
    var_1 = "default3";
  } else {
    var_2 = [];
    var_2[0] = "default1";
    var_2[1] = "default2";
    var_2[2] = "default3";
    var_1 = scripts\engine\utility::random(var_2);
  }

  self.pers["class"] = var_1;
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self._id_8FAF = self.pers["lastClass"];
  return var_1;
}

#using_animtree("script_model");

_id_7E51(var_0, var_1, var_2) {
  self._id_18AF = var_0;
  var_3 = spawn("script_model", (0, 0, 0));
  var_3.player = self;
  self._id_B5A4 = var_3;
  self._id_B5A4 setModel(var_1);
  self._id_B5A4 hide();
  self._id_B5A4._id_18AF = var_0;
  self._id_B5A4 useanimtree(#animtree);
  self._id_B5A4._id_10D19 = _id_0A94::_id_74B4;
  self._id_B5A4._id_3717 = _id_0A94::_id_7427;
  self._id_B5A4._id_4C9C = _id_0A94::_id_7436;
  self playerlinktodelta(self._id_B5A4, "tag_player", 1.0, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2) {
    self _meth_8272(self._id_B5A4);
  }

  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(isDefined(self)) {
    if(isDefined(var_2) && var_2) {
      self _meth_8272(undefined);
    }

    self unlink();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_7E4D(var_0, var_1, var_2) {
  foreach(var_4 in self.players) {
    var_4 playsoundtoplayer(var_0, var_4);
  }
}

_id_7E61() {
  level endon("game_ended");
  level endon("force_end");
  level waittill("match_start_real_countdown");
  setomnvar("ui_in_infil", 1);
  wait 2.0;
  _id_07D1::_id_60C1("infil_started");

  if(getdvarint("#x3568123bced36665e", 0) == 1) {
    level thread _id_9A1F();
  }

  if(getdvarint("#x3a63430dc36be4eea", 0) == 1) {
    foreach(var_1 in level.players) {
      iprintlnbold("!-!-!-!-!-INFIL BEGIN-!-!-!-!-!");
    }
  }
}

_id_7E58(var_0, var_1) {
  if(_id_07D1::_id_60BE("infil_started")) {
    return;
  }
  self notify("infil_scene_fade_in");
  self endon("infil_scene_fade_in");
  self setclientomnvar("ui_world_fade", 1.0);
  self endon("disconnect");
  _id_07D1::_id_60C2("infil_started");

  if(isDefined(var_0) && var_0 > 0.0) {
    wait(var_0);
  }

  var_2 = 1.0;

  while(var_2 > 0.0) {
    var_2 = var_2 - level._id_5F3A;
    var_2 = max(var_2, 0.0);
    self setclientomnvar("ui_world_fade", var_2);
    waitframe();
  }
}

_id_76FC(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("death");

  if(isDefined(var_0._id_75B8)) {
    return;
  } else {
    var_0._id_75B8 = 1;
  }

  var_0 scripts\engine\utility::_id_0393();
  var_0 notify("start_vehiclepath");
  var_0 notify("start_dynamicpath");
}

_id_1022D(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self._id_1D83 = var_0;
  }

  var_3 = self._id_1D83;
  self._id_41D8 = self._id_1D83;

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_3;

  if(var_1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = (self.origin[0], self.origin[1], self.origin[2] + var_2);
    _id_775D(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = _id_6645(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7._id_CE18)) {
      _id_C0A5(var_7);
    }

    if(isDefined(var_7._id_0399)) {
      _id_D280(var_7);
    }

    _id_775D(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }
    self._id_41D8 = var_7;
    var_7 notify("trigger", self);

    if(isDefined(var_7._id_CD81)) {
      self _meth_83BC(var_7._id_CD81);

      if(var_7._id_CD81 == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_7._id_CE7D)) {
      self._id_CE7D = var_7._id_CE7D;
    }

    if(isDefined(var_7._id_CEA5)) {
      self notify("unload");
      scripts\engine\utility::_id_108F5("unloaded", self._id_F977);
    }

    if(self _meth_8434()) {
      if(isDefined(var_7._id_CE19)) {
        self._id_04D6 = var_7._id_CE19;
      }
    }

    if(isDefined(var_7._id_CD4B)) {
      scripts\engine\utility::_id_5C24(var_7._id_CD4B);

      if(isDefined(var_7._id_CCFF)) {
        wait(var_7._id_CCFF);
      }

      self notify("delay_passed");
    }

    if(isDefined(self._id_D281)) {
      self._id_D281 = undefined;
      self _meth_807E();
    }

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_CEAE)) {
    self delete();
  }
}

_id_775D(var_0, var_1, var_2) {
  self endon("newpath");

  if(isDefined(var_0._id_CEA5) || isDefined(var_0._id_CD9A)) {
    var_3 = 0;

    if(isDefined(var_0._id_CD9A)) {
      scripts\engine\utility::_id_5474("landed");

      if(isDefined(self._id_F970)) {
        var_3 = self._id_F970;
      }
    } else if(isDefined(var_0._id_CEA5) && isDefined(self._id_F96E))
      var_3 = self._id_F96E;
    else if(isDefined(var_0._id_CEA5) && isDefined(self._id_F96F)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self._id_F96F) {
        var_3 = self._id_F96F;
      } else if(isDefined(self._id_F96D) && var_3 < self._id_F96D) {
        var_3 = self._id_F96D;
      }
    }

    var_0._id_0359 = 2;

    if(isDefined(var_0._id_71A9)) {
      var_0.origin = var_0._id_71A9 + (0, 0, var_3);
    } else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000) {
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1._id_CC8F;
    var_7 = var_1.speed;
    var_8 = var_1._id_CC89;
    var_9 = var_1._id_CCF6;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_0._id_CE6F) && var_0._id_CE6F;
  var_11 = isDefined(var_0._id_CEA5);
  var_12 = isDefined(var_0._id_CD4B) && !scripts\engine\utility::_id_5C00(var_0._id_CD4B);
  var_13 = !isDefined(var_0.target);
  var_14 = isDefined(var_0._id_0393);

  if(isDefined(var_0.angles)) {
    var_15 = var_0.angles[1];
  } else {
    var_15 = 0;
  }

  if(self.health <= 0) {
    return;
  }
  var_16 = var_0.origin;

  if(isDefined(var_2)) {
    var_16 = (var_16[0], var_16[1], var_16[2] + var_2);
  }

  if(isDefined(self._id_77BE)) {
    var_16 = (var_16[0], var_16[1], self._id_77BE);
  }

  self _meth_8433(var_16, var_7, var_8, var_9, var_0._id_CD77, var_0._id_CC9C, var_15, var_6, var_14, var_10, var_11, var_12, var_13);

  if(isDefined(var_0._id_0359)) {
    self setneargoalnotifydist(var_0._id_0359);
    scripts\engine\utility::waittill_any_2("near_goal", "goal");
  } else
    self waittill("goal");

  if(isDefined(var_0._id_CD42)) {
    if(!isDefined(level._id_7785)) {}

    thread[[level._id_7785]](var_0);
  }

  var_0 scripts\engine\utility::_id_0393();

  if(isDefined(self._id_AEC9)) {
    scripts\engine\utility::_id_4794(var_0);
  }

  self notify("continuepath");
}

_id_6645(var_0) {
  var_1 = ::_id_64B8;

  if(isDefined(var_0.target)) {
    if(isDefined(_id_64B6(var_0.target))) {
      var_1 = ::_id_64B6;
    }

    if(isDefined(_id_64B7(var_0.target))) {
      var_1 = ::_id_64B7;
    }
  }

  return var_1;
}

_id_64B8(var_0) {
  return _func_00E5(var_0, "targetname");
}

_id_64B7(var_0) {
  return scripts\engine\utility::getstruct(var_0, "targetname");
}

_id_64B6(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];
  }

  return undefined;
}

_id_D280(var_0) {
  var_1 = getent(var_0._id_0399, "script_linkname");

  if(!isDefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self._id_D281 = 1;
}

_id_AE70() {
  if(!isDefined(self._id_AEC7)) {
    return 0.0;
  }

  if(isDefined(self._id_AEDA)) {
    return self._id_AEDA;
  }

  self._id_AEDA = 0.0;
  var_0 = self._id_AEC7;
  var_1 = var_0.speed;

  for(;;) {
    if(isDefined(var_0._id_CEA5)) {
      break;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");

    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distance(var_0.origin, var_2.origin);

    if(isDefined(var_0.speed)) {
      var_1 = var_0.speed;
    }

    var_4 = 17.6;
    var_5 = 1.1;
    self._id_AEDA = self._id_AEDA + var_3 * var_5 / (var_1 * var_4);
    var_0 = var_2;
  }

  return self._id_AEDA;
}

_id_C0A5(var_0) {
  var_1 = strtok(var_0._id_CE18, ",");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, ":");

    if(!isDefined(var_4)) {
      return;
    }
    if(var_4.size != 2) {
      return;
    }
    thread _id_BD82(var_4[0], float(var_4[1]));
  }
}

_id_BD82(var_0, var_1) {
  if(!isDefined(self._id_F21C)) {
    self._id_F21C = [];
  }

  if(var_1 > 0) {
    wait(var_1);
  }

  switch (var_0) {
    case "shake_low":
      self._id_F21C["shake"] = "low";

      foreach(var_3 in self._id_7E24.players) {
        _id_0A94::_id_2FEC(var_3);
      }

      break;
    case "shake_off":
      self._id_F21C["shake"] = "off";

      foreach(var_3 in self._id_7E24.players) {
        _id_0A94::_id_2FED(var_3);
      }

      break;
    case "event_intro":
      self._id_7E24 notify("event_intro");
      break;
    case "event_shootingWindow_open":
      self._id_7E24 notify("event_shootingWindow_open");
      break;
    case "event_shootingWindow_closed":
      self._id_7E24 notify("event_shootingWindow_closed");
      break;
  }
}

_id_9A1F() {
  if(!isDefined(level._id_83AA) || !isDefined(level._id_83AC)) {
    return;
  }
  wait(level._id_83AA);
  _func_01F0(1, 0.5, 1);
  wait(level._id_83AC);
  _func_01F0(0.5, 1, 0.5);
}

_id_107DF() {
  _id_07D1::_id_60C2("prematch_done");

  while(level._id_7E75 != 0) {
    waitframe();
  }

  _func_03A0();
}

_id_7E53(var_0, var_1) {
  if(!isDefined(level._id_5DFB)) {
    level._id_5DFB = [];
    setDvar("#x35b2a10fb6777f9a9", 11);
  }

  level._id_5DFB[var_0] = var_1;
  _id_0AA3::_id_C28D(::_id_5DFA);
}

_id_5DFA() {
  var_0 = self;

  if(isDefined(var_0._id_7E74)) {
    return;
  }
  if(isDefined(var_0._id_7E24)) {
    var_1 = var_0._id_7E24.type;
  } else {
    var_1 = "infil_stairs";
  }

  if(getDvar("#x390a96e45c03e69c3", "") != "") {
    var_2 = getDvar("#x390a96e45c03e69c3", "");

    if(scripts\engine\utility::is_equal(var_2, "axis")) {
      var_1 = "infil_para";
    } else {
      var_1 = "infil_stairs";
    }
  }

  var_3 = spawn("script_model", level._id_5DFB[var_1]);
  var_3 setModel("tag_origin");
  var_0 cameralinkto(var_3, "tag_origin", 1, 1);
  var_0._id_7E74 = var_3;
  var_0 thread _id_C9CA(var_3, var_1);
}

_id_C9CA(var_0, var_1) {
  if(!isDefined(var_0._id_AC89)) {
    var_0._id_AC89 = var_0.origin;
  }

  for(;;) {
    var_2 = [];
    wait 0.25;

    foreach(var_4 in level.players) {
      if(!isDefined(self._id_7E24)) {
        continue;
      }
      if(!isDefined(var_4._id_7E24)) {
        continue;
      }
      if(scripts\engine\utility::is_equal(var_4._id_7E24.type, var_1)) {
        var_2[var_2.size] = var_4.origin;
      }
    }

    if(var_2.size == 0) {
      continue;
    }
    var_6 = _func_0016(var_2);
    var_7 = vectortoangles(var_6 - var_0.origin);
    var_0 rotateto(var_7, 0.5, 0.1, 0.1);
  }
}