/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2345.gsc
*************************************************/

_id_7E25(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(getdvarint("#x3825ceef1dcf1a340", 0) == 1) {
    if(scripts\engine\utility::_id_5C0C("infil_complete")) {
      scripts\engine\utility::_id_5C1B("infil_complete");
    }

    return;
  }

  level._id_BBAD = 10;

  while(!isDefined(level._id_EF89)) {
    waitframe();
  }

  level._id_C586["allies"] = 0;
  level._id_C586["axis"] = 0;

  if(!isDefined(game["infil"])) {
    foreach(var_9 in level._id_EF89) {
      game["infil"][var_9] = [];
    }

    game["infil"]["types"] = [];
  }

  if(isDefined(game["infil"]["types"][var_0]) && isDefined(game["infil"]["types"][var_0][var_1])) {
    if(isDefined(game["infil"]["types"][var_0][var_1]["persistentVehicle"])) {
      self[[game["infil"]["types"][var_0][var_1]["persistentVehicle"]]](var_0, var_1);
    }

    if(scripts\engine\utility::_id_5C0C("infil_complete")) {
      scripts\engine\utility::_id_5C1B("infil_complete");
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
  level thread _id_7E43(var_0, var_1);
}

_id_7E43(var_0, var_1) {
  waittillframeend;

  if(!isDefined(level._id_BBAD) || level._id_BBAD == 0) {
    return;
  }
  scripts\cp\utility::_id_60C0("infil_started", 0);

  if(!isDefined(level._id_7E6F)) {
    level._id_7E6F = 1;
    level thread onplayerspawned();
    level thread _id_AB05();
  }

  level._id_BB9F = ::_id_7E4F;
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in _id_6331()) {
    if(!var_5 _id_7E45()) {
      continue;
    }
    if(var_5 _id_7E31()) {
      _id_7E44();
    }

    var_6 = var_5._id_CE7D;

    if(var_5 _id_0736::_id_7E48(var_0) && var_5 _id_0736::_id_7E47(var_1) && _id_88C2(var_5._id_CE7D)) {
      var_7 = game["infil"]["types"][var_0][var_1];
      var_8 = var_5[[var_7["spawn_func"]]](var_5._id_CE7D, var_5.target, var_5.name);
      var_8.players = [];
      var_8.type = var_5._id_039B;
      var_8._id_EAC7 = var_5.name;
      var_6 = var_5._id_CE7D;
      game["infil"][var_6]["lanes"][var_0][var_1] = var_8;
      _id_C1ED(var_6, var_8, var_7["seats"], var_7["required_seats"], var_7["fill_order"], var_7["player_func"]);
      var_9 = var_8[[var_7["get_length_func"]]](var_1);

      if(!isDefined(var_2)) {
        var_9 = var_9 + 1.0;
        var_2 = var_9;
      } else
        var_9 = var_9 + 1.0;
    }
  }

  if(_id_60C3() && isDefined(var_2)) {
    level._id_BBAD = 10;
    level._id_BBAE = var_2 + 1.0;
    level thread _id_7E59();
    level thread _id_7E60();
  }
}

onplayerspawned() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("trying_to_join_infil", var_0);

    if(_id_B6DD(var_0)) {
      continue;
    }
    var_1 = scripts\cp\utility::_id_6BE2(var_0.team);

    if(_func_0107(var_1)) {
      var_2 = var_1[0];
    } else {
      var_2 = var_1;
    }

    var_3 = _id_677D(var_0, var_2);

    if(isDefined(var_3)) {
      _id_B47F(var_0, scripts\cp\utility::_id_6BE2(var_2));
    }

    if(!scripts\cp\utility::_id_60BE("infil_started")) {
      var_0 _id_B52A();
    }
  }
}

_id_B6DD(var_0) {
  return istrue(var_0._id_7E2B);
}

_id_4ADC(var_0) {
  var_0._id_7E2B = 1;
}

_id_AB05() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("joined_team", var_0);

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
  thread _id_0736::_id_7E58(0.0, 0.55, "fade_up");
  level waittill("start_scene");
  self notify("fade_up");
}

_id_AB65() {
  self endon("prematch_over");
  var_0 = self.team;
  self waittill("disconnect");
  _id_B47F(self, var_0);
}

_id_6331(var_0) {
  if(isDefined(var_0)) {
    return scripts\engine\utility::getstructarray("infil_type", "script_noteworthy");
  } else {
    return scripts\engine\utility::getstructarray("cp_infil", "targetname");
  }
}

_id_7E45() {
  self._id_03EA = int(self._id_03EA);

  if(!isDefined(self._id_03EA) || self._id_03EA == 0) {
    return 0;
  }

  if(!level.teambased) {
    return 0;
  }

  if(self._id_03EA & 1) {
    return 1;
  }

  if(self._id_03EA & 2) {
    switch (level.gametype) {
      case "conf":
      case "grind":
      case "tjugg":
      case "pill":
      case "war":
      case "arm":
        return 1;
    }
  }

  if(self._id_03EA & 4) {
    switch (level.gametype) {
      case "sd":
      case "dd":
      case "sr":
        return 1;
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
        return 1;
    }
  }

  return 0;
}

_id_7E31() {
  return isDefined(self._id_CD99) && level.gametype == "tac_ops";
}

_id_7E44() {}

_id_7E4F(var_0, var_1) {
  if(self ishost() && getdvarint("#x367977773f2b2af4f") == 1) {
    scripts\common\utility::_id_158D(var_0);
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
  scripts\common\utility::_id_157A(var_0);
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

  if(var_3 > level._id_C586[var_0]) {
    level._id_C586[var_0] = var_3;
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

_id_66E3(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in game["infil"][var_0]["spots"]) {
    if(!_id_86CE(var_0, var_4)) {
      var_1[var_1.size] = var_4;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_3 = scripts\engine\utility::random(var_1);
  return var_3;
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

_id_B52A() {
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
    var_2 = _id_0736::_id_66E4(self.team, self._id_ED18._id_50B4);
  } else if(var_0) {
    var_2 = _id_677F(self.team);
  } else if(var_1) {
    var_2 = _id_677C(self.team);
  } else {
    var_2 = _id_66E3(self.team);
  }

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = _id_B56A(self, var_2);
  var_3["infil"] thread _id_0736::_id_7E50(self);
  self notify("player_added_to_infil");
  self thread[[var_3["callback"]]](var_3["infil"], var_3["seat"]);
  thread _id_25A5();
  thread _id_AB65();
  _id_B3A6();
}

_id_25A5() {
  self endon("disconnect");
  self._id_46E2 = 1;
  level waittill("prematch_over");
  self._id_46E2 = 0;
}

_id_B3A6() {}

_id_7E59() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_hide_hud", 1);
  }

  level._id_2DF4 = _id_0736::_id_1659;
  level._id_7E42 = 1;
  level waittill("infil_started");

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_hide_hud", 1);
  }

  var_5 = _func_00BE("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);
  level._id_2DF4 = undefined;
  level._id_7E41 = 1;
  var_6 = getdvarint("#x374e27e8df3d55867");
  var_7 = getdvarint("#x396e27990abf87bd5");
  var_8 = getdvarint("#x379a74717c4043423");
  setDvar("#x374e27e8df3d55867", 0);
  setDvar("#x396e27990abf87bd5", 1);
  setDvar("#x379a74717c4043423", 1);
  level waittill("prematch_over");

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_hide_hud", 0);
    var_1 setclientomnvar("ui_hide_minimap", 1);
  }

  setomnvar("ui_always_show_nameplates", var_5);
  setDvar("#x374e27e8df3d55867", var_6);
  setDvar("#x396e27990abf87bd5", var_7);
  setDvar("#x379a74717c4043423", var_8);
  level._id_7E41 = undefined;
  wait 2;
  level._id_7E42 = undefined;

  if(scripts\engine\utility::_id_5C0C("infil_complete")) {
    scripts\engine\utility::_id_5C1B("infil_complete");
  }
}

_id_7E5A() {
  wait(level._id_BBAE - 5);
  setomnvar("ui_in_infil", 2);
}

_id_7E60() {
  level waittill("trying_to_join_infil", var_0);
  level._id_A758 = 1;
  _id_106F0();
  scripts\cp\utility::_id_60C1("infil_started");

  if(getdvarint("#x3a63430dc36be4eea", 0) == 1) {
    foreach(var_0 in level.players) {
      iprintlnbold("!-!-!-!-!-INFIL BEGIN-!-!-!-!-!");
    }
  }
}

_id_106F0() {
  level thread _id_B60F();
  level thread _id_9C41();
  level waittill("ready_to_start_infil");
}

_id_B60F() {
  level endon("ready_to_start_infil");

  for(;;) {
    level waittill("trying_to_join_infil", var_0);
    level._id_A758++;

    if(level._id_A758 == 4) {
      level notify("ready_to_start_infil");
    }
  }
}

_id_9C41() {
  level endon("ready_to_start_infil");
  var_0 = 5;
  wait(var_0);
  level notify("ready_to_start_infil");
}

_id_60C3() {
  if(!isDefined(game["infil"])) {
    return 0;
  }

  return 1;
}

_id_88C2(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level._id_EF89, var_0);
}