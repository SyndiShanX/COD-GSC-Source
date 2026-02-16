/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\65.gsc
**************************************/

_id_12C1() {
  if(issplitscreen() || getDvar("coop") == "1") {
    return 1;
  }
  return 0;
}

_id_18AB() {
  if(issplitscreen()) {
    return 0;
  }
  if(!_id_12C1()) {
    return 0;
  }
  return 1;
}

_id_1A43(var_0) {
  if(var_0 _id_133C("laststand_downed")) {
    return var_0 _id_1008("laststand_downed");
  }
  if(isDefined(var_0.laststand)) {
    return var_0.laststand;
  }
  return !isalive(var_0);
}

_id_1A75(var_0) {
  if(!isDefined(var_0._id_1A99)) {
    return 0;
  }
  return var_0._id_1A99;
}

_id_25DA(var_0) {
  if(_id_1A5C()) {
    return var_0 maps\_laststand::_id_1ABC() == 0;
  }
  return 0;
}

_id_1E71() {
  for(var_0 = 1; var_0 <= 2; var_0++) {
    for(var_1 = 1; var_1 <= 4; var_1++) {
      for(var_2 = 1; var_2 <= 9; var_2++) {
        setDvar("ui_eog_r" + var_2 + "c" + var_1 + "_player" + var_0, "");
        setDvar("ui_eog_r" + var_2 + "c" + var_1 + "_player" + var_0, "");
      }
    }

    setDvar("ui_eog_success_heading_player" + var_0, "");
  }
}

_id_25DB(var_0, var_1, var_2) {
  var_3 = int(var_0);
  var_4 = int(var_1);
  var_5 = "";

  if(level.players.size > 1) {
    if(self == level.player) {
      var_5 = "ui_eog_r" + var_3 + "c" + var_4 + "_player1";
    } else if(self == level._id_1337) {
      var_5 = "ui_eog_r" + var_3 + "c" + var_4 + "_player2";
    } else {}
  } else {
    var_5 = "ui_eog_r" + var_3 + "c" + var_4 + "_player1";
  }
  setDvar(var_5, var_2);
}

_id_16C7(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._id_1992)) {
    self._id_1992 = 0;
  }
  var_5 = undefined;

  if(isDefined(var_4)) {
    var_5 = var_4;

    if(var_4 > self._id_1992) {
      self._id_1992 = var_4;
    }
  } else {
    self._id_1992++;
    var_5 = self._id_1992;
  }

  _id_25DB(var_5, 1, var_0);
  var_6 = [];

  if(isDefined(var_3)) {
    var_6[var_6.size] = var_3;
  }
  if(isDefined(var_2)) {
    var_6[var_6.size] = var_2;
  }
  if(isDefined(var_1)) {
    var_6[var_6.size] = var_1;
  }
  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    _id_25DB(var_5, 4 - var_7, var_6[var_7]);
  }
}

_id_16C8() {
  if(!isDefined(self._id_1992)) {
    self._id_1992 = 0;
  }
  self._id_1992++;
}

_id_25DC(var_0) {
  var_1 = "";

  if(level.players.size > 1) {
    if(self == level.player) {
      var_1 = "ui_eog_success_heading_player1";
    } else if(self == level._id_1337) {
      var_1 = "ui_eog_success_heading_player2";
    } else {}
  } else {
    var_1 = "ui_eog_success_heading_player1";
  }
  setDvar(var_1, var_0);
}

_id_12DC() {
  return _id_0A36() && getdvarint("so_survival") > 0;
}

_id_1A5C() {
  return isDefined(level._id_1ABA) && level._id_1ABA > 0;
}

_id_0A36() {
  return getdvarint("specialops") >= 1;
}

_id_16D0(var_0, var_1) {
  var_2 = "";

  if(var_0 < 0) {
    var_2 = var_2 + "-";
  }
  var_0 = _id_25DD(var_0, 1, 0);
  var_3 = var_0 * 100;
  var_3 = int(var_3);
  var_3 = abs(var_3);
  var_4 = var_3 / 6000;
  var_4 = int(var_4);
  var_2 = var_2 + var_4;
  var_5 = var_3 / 100;
  var_5 = int(var_5);
  var_5 = var_5 - var_4 * 60;

  if(var_5 < 10) {
    var_2 = var_2 + (":0" + var_5);
  } else {
    var_2 = var_2 + (":" + var_5);
  }
  if(isDefined(var_1) && var_1) {
    var_6 = var_3;
    var_6 = var_6 - var_4 * 6000;
    var_6 = var_6 - var_5 * 100;
    var_6 = int(var_6 / 10);
    var_2 = var_2 + ("." + var_6);
  }

  return var_2;
}

_id_25DD(var_0, var_1, var_2) {
  var_1 = int(var_1);

  if(var_1 < 0 || var_1 > 4) {
    return var_0;
  }
  var_3 = 1;

  for(var_4 = 1; var_4 <= var_1; var_4++) {
    var_3 = var_3 * 10;
  }
  var_5 = var_0 * var_3;

  if(!isDefined(var_2) || var_2) {
    var_5 = floor(var_5);
  } else {
    var_5 = ceil(var_5);
  }
  var_0 = var_5 / var_3;
  return var_0;
}

_id_17FC(var_0, var_1, var_2) {
  var_3 = var_0 / 1000;
  var_3 = _id_25DD(var_3, var_1, var_2);
  var_0 = var_3 * 1000;
  return int(var_0);
}

_id_25DE(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_1)) {
    return 1;
  }
  if(!isDefined(var_2)) {
    var_2 = "==";
  }
  switch (var_2) {
    case "==":
      return var_0 == var_1;
    case "<":
      return var_0 < var_1;
    case ">":
      return var_0 > var_1;
    case "<=":
      return var_0 <= var_1;
    case ">=":
      return var_0 >= var_1;
  }

  return 1;
}

set_vision_set(var_0, var_1) {
  if(maps\_utility_code::_id_13ED(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  visionsetnaked(var_0, var_1);
  setDvar("vision_set_current", var_0);
}

_id_25DF(var_0, var_1) {
  if(maps\_utility_code::_id_13ED(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  self visionsetnakedforplayer(var_0, var_1);
}

_id_25E0(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  visionsetnight(var_0, var_1);
}

_id_25E1(var_0, var_1, var_2) {
  var_2 = int(var_2 * 20);
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;
  }
  var_5 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    wait 0.05;

    for(var_6 = 0; var_6 < 3; var_6++) {
      var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;
    }
    setsunlight(var_5[0], var_5[1], var_5[2]);
  }

  setsunlight(var_1[0], var_1[1], var_1[2]);
}

_id_1654(var_0) {
  while(isDefined(self) && !self._id_1008[var_0]) {
    self waittill(var_0);
  }
}

_id_25E2(var_0) {
  while(isDefined(self) && !self._id_1008[var_0]) {
    self waittill(var_0);
  }
}

_id_25E3(var_0, var_1) {
  while(isDefined(self)) {
    if(_id_1008(var_0)) {
      return;
    }
    if(_id_1008(var_1)) {
      return;
    }
    common_scripts\utility::waittill_either(var_0, var_1);
  }
}

_id_25E4(var_0, var_1) {
  var_2 = gettime();

  while(isDefined(self)) {
    if(self._id_1008[var_0]) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    maps\_utility_code::_id_13D3(var_0, var_1);
  }
}

_id_13DB(var_0) {
  while(isDefined(self) && self._id_1008[var_0]) {
    self waittill(var_0);
  }
}

_id_25E5(var_0) {}

_id_25E6(var_0, var_1) {
  while(isDefined(self)) {
    if(!_id_1008(var_0)) {
      return;
    }
    if(!_id_1008(var_1)) {
      return;
    }
    common_scripts\utility::waittill_either(var_0, var_1);
  }
}

_id_1402(var_0) {
  if(!isDefined(self._id_1008)) {
    self._id_1008 = [];
    self._id_25E7 = [];
  }

  self._id_1008[var_0] = 0;
}

_id_133C(var_0) {
  if(isDefined(self._id_1008) && isDefined(self._id_1008[var_0])) {
    return 1;
  }
  return 0;
}

_id_25E8(var_0, var_1) {
  self endon("death");
  wait(var_1);
  _id_13DC(var_0);
}

_id_13DC(var_0) {
  self._id_1008[var_0] = 1;
  self notify(var_0);
}

_id_13DE(var_0) {
  if(self._id_1008[var_0]) {
    self._id_1008[var_0] = 0;
    self notify(var_0);
  }
}

_id_25E9(var_0, var_1) {
  wait(var_1);
  _id_13DE(var_0);
}

_id_1008(var_0) {
  return self._id_1008[var_0];
}

_id_25EA(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }
  if(!isDefined(var_3)) {
    var_3 = -1;
  }
  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2) {
    var_4 = var_1 getEye();
  }
  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglesToForward(var_6);
  var_8 = -1;

  foreach(var_10 in var_0) {
    var_11 = vectortoangles(var_10.origin - var_4);
    var_12 = anglesToForward(var_11);
    var_13 = vectordot(var_7, var_12);

    if(var_13 < var_8) {
      continue;
    }
    if(var_13 < var_3) {
      continue;
    }
    var_8 = var_13;
    var_5 = var_10;
  }

  return var_5;
}

_id_25EB(var_0, var_1, var_2) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }
  var_3 = var_1.origin;

  if(isDefined(var_2) && var_2) {
    var_3 = var_1 getEye();
  }
  var_4 = undefined;
  var_5 = var_1 getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = -1;

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_9 = vectortoangles(var_0[var_8].origin - var_3);
    var_10 = anglesToForward(var_9);
    var_11 = vectordot(var_6, var_10);

    if(var_11 < var_7) {
      continue;
    }
    var_7 = var_11;
    var_4 = var_8;
  }

  return var_4;
}

_id_25EC(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  var_1 thread _id_25F0(var_0, var_2);
  return var_1;
}

_id_25ED(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3] thread _id_25F0(var_0, 0);
  }
  return var_1;
}

_id_25EE(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::flag_set(var_0);
}

_id_25EF(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::flag_clear(var_0);
}

_id_25F0(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);
    common_scripts\utility::flag_set(var_0);

    if(!var_1) {
      return;
    }
    while(var_2 istouching(self)) {
      wait 0.05;
    }
    common_scripts\utility::flag_clear(var_0);
  }
}

_id_195C() {
  if(_id_09D4()) {
    return;
  }
  if(level._id_16C9) {
    return;
  }
  if(common_scripts\utility::flag("game_saving")) {
    return;
  }
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!isalive(var_1)) {
      return;
    }
  }

  common_scripts\utility::flag_set("game_saving");
  var_2 = "levelshots / autosave / autosave_" + level.script + "end";
  savegame("levelend", &"AUTOSAVE_AUTOSAVE", var_2, 1);
  common_scripts\utility::flag_clear("game_saving");
}

_id_25F1(var_0, var_1, var_2) {
  level._id_1C2C[var_0] = [];
  level._id_1C2C[var_0]["func"] = var_1;
  level._id_1C2C[var_0]["msg"] = var_2;
}

_id_25F2(var_0) {
  level._id_1C2C[var_0] = undefined;
}

_id_1C32() {
  thread _id_25F4("autosave_stealth", 8, 1);
}

_id_1C34() {
  maps\_utility_code::_id_141F();
  thread maps\_utility_code::_id_1423();
}

_id_1425(var_0) {
  thread _id_25F4(var_0);
}

_id_25F3(var_0) {
  thread _id_25F4(var_0, undefined, undefined, 1);
}

_id_25F4(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_25F5)) {
    level._id_25F5 = 1;
  }
  var_4 = "levelshots/autosave/autosave_" + level.script + level._id_25F5;
  var_5 = level maps\_autosave::_id_1C45(level._id_25F5, "autosave", var_4, var_1, var_2, var_3);

  if(isDefined(var_5) && var_5) {
    level._id_25F5++;
  }
}

_id_25F6(var_0, var_1) {
  thread _id_25F4(var_0, var_1);
}

_id_1B94(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 5;
  }
  if(isDefined(var_3)) {
    var_3 endon("death");
    var_1 = var_3.origin;
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    if(!isDefined(var_3)) {} else {}

    wait 0.05;
  }
}

_id_25F7(var_0, var_1) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 5;
  }
  for(var_2 = 0; var_2 < var_1 * 20; var_2++) {
    wait 0.05;
  }
}

_id_25F8(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level notify(var_0 + var_3);
    level endon(var_0 + var_3);
  } else {
    level notify(var_0);
    level endon(var_0);
  }

  if(!isDefined(var_2)) {
    var_2 = 5;
  }
  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    wait 0.05;
  }
}

_id_25F9(var_0) {
  var_1 = getEntArray("trigger_friendlychain", "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2]._id_25FA) && var_1[var_2]._id_25FA == var_0) {
      if(isDefined(var_1[var_2]._id_25FB)) {
        var_1[var_2].origin = var_1[var_2]._id_25FB;
      } else {
        var_1[var_2]._id_25FB = var_1[var_2].origin;
      }
      var_1[var_2].origin = var_1[var_2].origin + (0, 0, -5000);
    }
  }
}

_id_25FC(var_0) {
  var_1 = getEntArray("trigger_friendlychain", "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2]._id_25FA) && var_1[var_2]._id_25FA == var_0) {
      if(isDefined(var_1[var_2]._id_25FB)) {
        var_1[var_2].origin = var_1[var_2]._id_25FB;
      }
    }
  }
}

precache(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1.origin = level.player getorigin();
  var_1 setModel(var_0);
  var_1 delete();
}

_id_25FD(var_0, var_1) {
  return var_0 >= var_1;
}

_id_25FE(var_0, var_1) {
  return var_0 <= var_1;
}

_id_0AE9(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 500000;
  }
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_5;
  }

  return var_3;
}

_id_25FF(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 500000;
  }
  var_3 = 0;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = distance(var_6.origin, var_0);

    if(var_7 <= var_3 || var_7 >= var_2) {
      continue;
    }
    var_3 = var_7;
    var_4 = var_6;
  }

  return var_4;
}

_id_2600(var_0, var_1, var_2) {
  return maps\_utility_code::_id_144B(var_0, var_1, var_2, ::_id_25FD);
}

_id_2601(var_0, var_1, var_2) {
  var_3 = var_1[0];
  var_4 = distance(var_0, var_3);

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = distance(var_0, var_1[var_5]);

    if(var_6 >= var_4) {
      continue;
    }
    var_4 = var_6;
    var_3 = var_1[var_5];
  }

  if(!isDefined(var_2) || var_4 <= var_2) {
    return var_3;
  }
  return undefined;
}

_id_2602(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = distance(var_1[0] getorigin(), var_0);
  var_3 = var_1[0];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 < var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

_id_2603(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2) {
      var_3[var_3.size] = var_1[var_4];
    }
  }

  return var_3;
}

_id_2604(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) > var_2) {
      var_3[var_3.size] = var_1[var_4];
    }
  }

  return var_3;
}

_id_2605(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 9999999;
  }
  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!isalive(var_1[var_4])) {
      continue;
    }
    var_5 = distance(var_1[var_4].origin, var_0);

    if(var_5 >= var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

_id_2606(var_0, var_1, var_2) {
  if(!var_2.size) {
    return;
  }
  var_3 = undefined;
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = anglesToForward(var_4);
  var_6 = -1;

  foreach(var_8 in var_2) {
    var_4 = vectortoangles(var_8.origin - var_0);
    var_9 = anglesToForward(var_4);
    var_10 = vectordot(var_5, var_9);

    if(var_10 < var_6) {
      continue;
    }
    var_6 = var_10;
    var_3 = var_8;
  }

  return var_3;
}

_id_2607(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 9999999;
  }
  if(var_1.size < 1) {
    return;
  }
  var_3 = undefined;

  foreach(var_7, var_5 in var_1) {
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_7;
  }

  return var_3;
}

_id_18B6(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return undefined;
  }
  var_3 = 0;

  if(isDefined(var_2) && var_2.size) {
    var_4 = [];

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_4[var_5] = 0;
    }
    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_1[var_5] == var_2[var_6]) {
          var_4[var_5] = 1;
        }
      }
    }

    var_7 = 0;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(!var_4[var_5] && isDefined(var_1[var_5])) {
        var_7 = 1;
        var_3 = distance(var_0, var_1[var_5].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }

    if(!var_7) {
      return undefined;
    }
  } else {
    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      if(isDefined(var_1[var_5])) {
        var_3 = distance(var_0, var_1[0].origin);
        var_8 = var_5;
        var_5 = var_1.size + 1;
      }
    }
  }

  var_8 = undefined;

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    if(isDefined(var_1[var_5])) {
      var_4 = 0;

      if(isDefined(var_2)) {
        for(var_6 = 0; var_6 < var_2.size; var_6++) {
          if(var_1[var_5] == var_2[var_6]) {
            var_4 = 1;
          }
        }
      }

      if(!var_4) {
        var_9 = distance(var_0, var_1[var_5].origin);

        if(var_9 <= var_3) {
          var_3 = var_9;
          var_8 = var_5;
        }
      }
    }
  }

  if(isDefined(var_8)) {
    return var_1[var_8];
  } else {
    return undefined;
  }
}

_id_2608(var_0) {
  if(level.players.size == 1) {
    return level.player;
  }
  var_1 = _id_0AE9(var_0, level.players);
  return var_1;
}

_id_2609(var_0) {
  if(level.players.size == 1) {
    return level.player;
  }
  var_1 = _id_1A6A();
  var_2 = _id_0AE9(var_0, var_1);
  return var_2;
}

_id_1A6A() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(_id_1A43(var_2)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_1EE9(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = getaiarray(var_1);
  } else {
    var_3 = getaiarray();
  }
  if(var_3.size == 0) {
    return undefined;
  }
  if(isDefined(var_2)) {
    var_3 = common_scripts\utility::array_remove_array(var_3, var_2);
  }
  return _id_0AE9(var_0, var_3);
}

_id_0C26(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_0AEC(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = _id_2616(var_6);
  return var_6;
}

_id_0AEC(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_3 = var_1.size;
  }
  if(!isDefined(var_2)) {
    var_2 = [];
  }
  var_6 = undefined;

  if(isDefined(var_4)) {
    var_6 = var_4 * var_4;
  }
  var_7 = 0;

  if(isDefined(var_5)) {
    var_7 = var_5 * var_5;
  }
  if(var_2.size == 0 && var_3 >= var_1.size && var_7 == 0 && !isDefined(var_6)) {
    return sortbydistance(var_1, var_0);
  }
  var_8 = [];

  foreach(var_10 in var_1) {
    var_11 = 0;

    foreach(var_13 in var_2) {
      if(var_10 == var_13) {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }
    var_15 = distancesquared(var_0, var_10.origin);

    if(isDefined(var_6) && var_15 > var_6) {
      continue;
    }
    if(var_15 < var_7) {
      continue;
    }
    var_8[var_8.size] = var_10;
  }

  var_8 = sortbydistance(var_8, var_0);

  if(var_3 >= var_8.size) {
    return var_8;
  }
  var_17 = [];

  for(var_18 = 0; var_18 < var_3; var_18++) {
    var_17[var_18] = var_8[var_18];
  }
  return var_17;
}

_id_2288(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_3 = getaiarray(var_1);
  } else {
    var_3 = getaiarray();
  }
  if(var_3.size == 0) {
    return undefined;
  }
  return _id_18B6(var_0, var_3, var_2);
}

_id_1951(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(!isDefined(var_4)) {
    var_4 = distance(var_0, var_1);
  }
  var_4 = max(0.01, var_4);
  var_5 = vectornormalize(var_1 - var_0);
  var_6 = var_2 - var_0;
  var_7 = vectordot(var_6, var_5);
  var_7 = var_7 / var_4;
  var_7 = clamp(var_7, 0, 1);
  return var_7;
}

_id_260A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  if(!_id_260B(var_0)) {
    return 0;
  }
  if(!sighttracepassed(self getEye(), var_0, var_1, self)) {
    return 0;
  }
  return 1;
}

_id_260B(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = vectornormalize(var_0 - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > 0.766;
}

_id_1902() {
  self notify("stop_magic_bullet_shield");

  if(isai(self)) {
    self.attackeraccuracy = 1;
  }
  self._id_0D04 = undefined;
  self.damageshield = 0;
  self notify("internal_stop_magic_bullet_shield");
}

_id_260C() {}

_id_0D04(var_0) {
  if(isai(self)) {} else {
    self.health = 100000;
  }
  self endon("internal_stop_magic_bullet_shield");

  if(isai(self)) {
    self.attackeraccuracy = 0.1;
  }
  self._id_0D04 = 1;
  self.damageshield = 1;
}

_id_260D() {
  self.a._id_0D31 = 1;
}

_id_260E() {
  self.a._id_0D31 = 0;
}

_id_260F() {
  self._id_0ECB = undefined;
}

_id_2610() {
  self._id_0ECB = 1;
}

_id_2611() {
  _id_0D04(1);
}

_id_1F55() {
  return self.ignoreme;
}

_id_0A23(var_0) {
  self.ignoreme = var_0;
}

_id_2612(var_0) {
  self.ignoreall = var_0;
}

_id_2613(var_0) {
  self.favoriteenemy = var_0;
}

_id_1F57() {
  return self.pacifist;
}

_id_1F58(var_0) {
  self.pacifist = var_0;
}

_id_2614(var_0) {
  self notify("new_ignore_me_timer");
  self endon("new_ignore_me_timer");
  self endon("death");

  if(!isDefined(self._id_2615)) {
    self._id_2615 = self.ignoreme;
  }
  var_1 = getaiarray("bad_guys");

  foreach(var_3 in var_1) {
    if(!isalive(var_3.enemy)) {
      continue;
    }
    if(var_3.enemy != self) {
      continue;
    }
    var_3 clearenemy();
  }

  self.ignoreme = 1;
  wait(var_0);
  self.ignoreme = self._id_2615;
  self._id_2615 = undefined;
}

_id_0B53(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = randomint(var_0.size);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return var_0;
}

_id_2616(var_0) {
  var_1 = [];

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    var_1[var_1.size] = var_0[var_2];
  }
  return var_1;
}

_id_2617(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.model)) {
          var_3.model delete();
        }
      }
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model)) {
        var_3.model delete();
      }
    }
  }

  level notify("killexplodertridgers" + var_0);
}

_id_2618(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.model)) {
          var_3.model hide();
        }
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model)) {
        var_3.model hide();
      }
    }
  }
}

_id_2619(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!_id_1EDA(var_3.model) && !_id_1EDB(var_3.model) && !_id_1EDD(var_3.model)) {
          var_3.model show();
        }
        if(isDefined(var_3.brush_shown)) {
          var_3.model show();
        }
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(isDefined(var_3.model)) {
        if(!_id_1EDA(var_3.model) && !_id_1EDB(var_3.model) && !_id_1EDD(var_3.model)) {
          var_3.model show();
        }
        if(isDefined(var_3.brush_shown)) {
          var_3.model show();
        }
      }
    }
  }
}

_id_1EDB(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "exploder";
}

_id_1EDA(var_0) {
  return var_0.model == "fx" && (!isDefined(var_0.targetname) || var_0.targetname != "exploderchunk");
}

_id_1EDD(var_0) {
  return isDefined(var_0.targetname) && var_0.targetname == "exploderchunk";
}

_id_261A(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!isDefined(var_3.looper)) {
          continue;
        }
        var_3.looper delete();
      }

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      if(!isDefined(var_3.looper)) {
        continue;
      }
      var_3.looper delete();
    }
  }
}

_id_261B(var_0) {
  var_0 = var_0 + "";
  var_1 = [];

  if(isDefined(level.createfxexploders)) {
    var_2 = level.createfxexploders[var_0];

    if(isDefined(var_2)) {
      var_1 = var_2;
    }
  } else {
    foreach(var_4 in level.createfxent) {
      if(var_4.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_4.v["exploder"])) {
        continue;
      }
      if(var_4.v["exploder"] + "" != var_0) {
        continue;
      }
      var_1[var_1.size] = var_4;
    }
  }

  return var_1;
}

_id_261C(var_0) {
  maps\_spawner::_id_2135(var_0);
}

_id_194E(var_0, var_1) {
  maps\_audio_zone_manager::_id_156C(var_0, var_1);
}

_id_261D(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 4;
  }
  thread _id_2622(var_0, var_1, var_2, var_3);
}

#using_animtree("generic_human");

_id_261E() {
  if(isDefined(self.a._id_261F)) {
    self.a._id_0C6D["crawl"] = self.a._id_261F["crawl"];
    self.a._id_0C6D["death"] = self.a._id_261F["death"];
    self.a._id_0D58 = self.a._id_261F["blood_fx_rate"];

    if(isDefined(self.a._id_261F["blood_fx"])) {
      self.a._id_0D59 = self.a._id_261F["blood_fx"];
    }
  }

  self.a._id_0C6D["stand_2_crawl"] = [];
  self.a._id_0C6D["stand_2_crawl"][0] = % dying_stand_2_crawl_v3;

  if(isDefined(self._id_2620)) {
    self.a._id_0D26 = "prone";
  }
  self orientmode("face angle", self.a._id_2621);
  self.a._id_2621 = undefined;
}

_id_2622(var_0, var_1, var_2, var_3) {
  self._id_0D41 = 1;
  self.a._id_0D47 = var_1;
  self._id_0EC6 = 1;
  self._id_2620 = var_3;
  self.a._id_261F = var_2;
  self._id_0D49 = ::_id_261E;
  self.maxhealth = 100000;
  self.health = 100000;
  _id_260E();

  if(!isDefined(var_3) || var_3 == 0) {
    self.a._id_2621 = var_0 + 181.02;
  } else {
    self.a._id_2621 = var_0;
    thread animscripts\notetracks::_id_23EC();
  }
}

_id_2623(var_0) {
  var_1 = undefined;
  var_2 = getEntArray("trigger_friendlychain", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3]._id_25FA) && var_2[var_3]._id_25FA == var_0) {
      var_1 = var_2[var_3];
      break;
    }
  }

  if(!isDefined(var_1)) {
    return undefined;
  }
  var_4 = getnode(var_1.target, "targetname");
  return var_4;
}

_id_1E8D() {
  precacheshellshock("default");
  self waittill("death");

  if(isDefined(self._id_0ECC)) {
    return;
  }
  if(getDvar("r_texturebits") == "16") {
    return;
  }
  self shellshock("default", 3);
}

_id_2624(var_0, var_1) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0)) {
    if(var_0 iswaitingonsound()) {
      var_0 waittill(var_1);
    }
    var_0 delete();
  }
}

_id_2625() {
  return issentient(self) && !isalive(self);
}

play_sound_on_tag(var_0, var_1, var_2, var_3, var_4) {
  if(_id_2625()) {
    return;
  }
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");
  thread _id_2624(var_5, "sounddone");

  if(isDefined(var_1)) {
    var_5 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  } else {
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_5 linkto(self);
  }

  var_5 playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    if(!isDefined(maps\_utility_code::_id_13EC(var_5))) {
      var_5 stopsounds();
    }
    wait 0.05;
  } else {
    var_5 waittill("sounddone");
  }
  if(isDefined(var_3)) {
    self notify(var_3);
  }
  var_5 delete();
}

_id_23D9(var_0, var_1) {
  play_sound_on_tag(var_0, var_1, 1);
}

play_sound_on_entity(var_0, var_1) {
  play_sound_on_tag(var_0, undefined, undefined, var_1);
}

_id_258E(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3 endon("death");

  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  if(var_2) {
    thread common_scripts\utility::delete_on_death(var_3);
  }
  if(isDefined(var_1)) {
    var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  } else {
    var_3.origin = self.origin;
    var_3.angles = self.angles;
    var_3 linkto(self);
  }

  var_3 playLoopSound(var_0);
  self waittill("stop sound" + var_0);
  var_3 stoploopsound(var_0);
  var_3 delete();
}

_id_2626() {
  var_0 = getaiarray("allies");
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2]._id_0AB5)) {
      continue;
    }
    game["character" + var_1] = var_0[var_2] codescripts\character::save();
    var_1++;
  }

  game["total characters"] = var_1;
}

_id_13AF(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }
  if(!isDefined(var_0.finished_spawning)) {
    var_0 common_scripts\utility::waittill_either("finished spawning", "death");
  }
  if(isalive(var_0)) {
    return 0;
  }
  return 1;
}

_id_1F8D(var_0) {
  codescripts\character::precache(var_0);
  self waittill("spawned", var_1);

  if(_id_13AF(var_1)) {
    return;
  }
  var_1 codescripts\character::new();
  var_1 codescripts\character::load(var_0);
}

_id_2627(var_0, var_1) {
  iprintlnbold(var_0, var_1["key1"]);
}

_id_2628(var_0) {
  self endon("death");

  for(;;) {
    maps\_debug::_id_19A2(var_0);
    wait 0.05;
  }
}

_id_2629(var_0) {
  if(isDefined(var_0)) {
    self._id_1032 = var_0;
  }
  self useanimtree(level._id_1245[self._id_1032]);
}

_id_262A() {
  if(isarray(level._id_1F90[self._id_1032])) {
    var_0 = randomint(level._id_1F90[self._id_1032].size);
    self setModel(level._id_1F90[self._id_1032][var_0]);
  } else {
    self setModel(level._id_1F90[self._id_1032]);
  }
}

_id_1287(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }
  var_2 = spawn("script_model", var_1);
  var_2._id_1032 = var_0;
  var_2 _id_2629();
  var_2 _id_262A();
  return var_2;
}

_id_262B(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2 waittill("trigger", var_3);
  level notify(var_0, var_3);
  return var_3;
}

_id_262C(var_0) {
  var_1 = getent(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 waittill("trigger", var_2);
  level notify(var_0, var_2);
  return var_2;
}

_id_262D(var_0, var_1) {
  thread _id_2632(var_0, var_1, ::_id_2635, "set_flag_on_dead");
}

_id_262E(var_0, var_1) {
  thread _id_2632(var_0, var_1, ::_id_2636, "set_flag_on_dead_or_dying");
}

_id_262F(var_0, var_1) {
  thread _id_2632(var_0, var_1, ::_id_2630, "set_flag_on_spawned");
}

_id_2630(var_0) {
  return;
}

_id_2631(var_0, var_1) {
  self waittill("spawned", var_2);

  if(_id_13AF(var_2)) {
    return;
  }
  var_0._id_21FF[var_0._id_21FF.size] = var_2;
  _id_13DC(var_1);
}

_id_2632(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_21FF = [];

  foreach(var_7, var_6 in var_0) {}
  var_6 _id_1402(var_3);

  common_scripts\utility::array_thread(var_0, ::_id_2631, var_4, var_3);

  foreach(var_7, var_6 in var_0) {}
  var_6 _id_1654(var_3);

  [[var_2]](var_4._id_21FF);
  common_scripts\utility::flag_set(var_1);
}

_id_2633(var_0, var_1) {
  if(!common_scripts\utility::flag(var_1)) {
    var_0 waittill("trigger", var_2);
    common_scripts\utility::flag_set(var_1);
    return var_2;
  }
}

_id_2634(var_0) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");
  common_scripts\utility::flag_set(var_0);
}

is_in_array(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_2635(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread _id_2639(var_2);
  }

  var_10.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_10.count) {
    var_10.count = var_1;
  }
  common_scripts\utility::array_thread(var_0, ::_id_2637, var_10);

  while(var_10.count > 0) {
    var_10 waittill("waittill_dead guy died");
  }
}

_id_2636(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5.ignoreforfixednodesafecheck) {
      var_3[var_3.size] = var_5;
    }
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("thread_timed_out");
    var_7 thread _id_2639(var_2);
  }

  var_7.count = var_0.size;

  if(isDefined(var_1) && var_1 < var_7.count) {
    var_7.count = var_1;
  }
  common_scripts\utility::array_thread(var_0, ::_id_2638, var_7);

  while(var_7.count > 0) {
    var_7 waittill("waittill_dead_guy_dead_or_dying");
  }
}

_id_2637(var_0) {
  self waittill("death");
  var_0.count--;
  var_0 notify("waittill_dead guy died");
}

_id_2638(var_0) {
  common_scripts\utility::waittill_either("death", "pain_death");
  var_0.count--;
  var_0 notify("waittill_dead_guy_dead_or_dying");
}

_id_2639(var_0) {
  wait(var_0);
  self notify("thread_timed_out");
}

_id_263A(var_0) {
  while(level._id_20FE[var_0]._id_222C || level._id_20FE[var_0]._id_222B) {
    wait 0.25;
  }
}

_id_263B(var_0, var_1) {
  while(level._id_20FE[var_0]._id_222C + level._id_20FE[var_0]._id_222B > var_1) {
    wait 0.25;
  }
}

_id_263C(var_0) {
  return level._id_20FE[var_0]._id_222C + level._id_20FE[var_0]._id_222B;
}

_id_263D(var_0) {
  return level._id_20FE[var_0]._id_222B;
}

_id_263E(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_20FE[var_0]._id_21FF.size; var_2++) {
    if(!isalive(level._id_20FE[var_0]._id_21FF[var_2])) {
      continue;
    }
    var_1[var_1.size] = level._id_20FE[var_0]._id_21FF[var_2];
  }

  return var_1;
}

_id_263F(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

_id_2640(var_0, var_1) {
  var_2 = _id_2641(var_0, var_1);

  if(var_2.size > 1) {
    return undefined;
  }
  return var_2[0];
}

_id_2641(var_0, var_1) {
  var_2 = getaispeciesarray("all", "all");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }
    switch (var_1) {
      case "targetname":
        if(isDefined(var_5.targetname) && var_5.targetname == var_0) {
          var_3[var_3.size] = var_5;
        }
        break;
      case "script_noteworthy":
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0) {
          var_3[var_3.size] = var_5;
        }
        break;
    }
  }

  return var_3;
}

_id_2642(var_0, var_1) {
  var_2 = _id_2643(var_0, var_1);

  if(!var_2.size) {
    return undefined;
  }
  return var_2[0];
}

_id_2643(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_2) {
    if(var_6.code_classname != "script_vehicle") {
      continue;
    }
    var_4[0] = var_6;

    if(isspawner(var_6)) {
      if(isDefined(var_6._id_2644)) {
        var_4[0] = var_6._id_2644;
        var_3 = _id_1843(var_3, var_4);
      }

      continue;
    }

    var_3 = _id_1843(var_3, var_4);
  }

  return var_3;
}

_id_2645(var_0, var_1, var_2) {
  var_3 = _id_2641(var_0, var_1, var_2);

  if(var_3.size > 1) {
    return undefined;
  }
  return var_3[0];
}

_id_2646(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "all";
  }
  var_3 = getaispeciesarray("allies", var_2);
  var_3 = common_scripts\utility::array_combine(var_3, getaispeciesarray("axis", var_2));
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    switch (var_1) {
      case "targetname":
        if(isDefined(var_3[var_5].targetname) && var_3[var_5].targetname == var_0) {
          var_4[var_4.size] = var_3[var_5];
        }
        break;
      case "script_noteworthy":
        if(isDefined(var_3[var_5].script_noteworthy) && var_3[var_5].script_noteworthy == var_0) {
          var_4[var_4.size] = var_3[var_5];
        }
        break;
    }
  }

  return var_4;
}

_id_2647(var_0, var_1) {
  if(isDefined(level._id_2101[var_0])) {
    if(level._id_2101[var_0]) {
      wait 0.05;

      if(isalive(self)) {
        self notify("gather_delay_finished" + var_0 + var_1);
      }
      return;
    }

    level waittill(var_0);

    if(isalive(self)) {
      self notify("gather_delay_finished" + var_0 + var_1);
    }
    return;
  }

  level._id_2101[var_0] = 0;
  wait(var_1);
  level._id_2101[var_0] = 1;
  level notify(var_0);

  if(isalive(self)) {
    self notify("gather_delay_finished" + var_0 + var_1);
  }
}

_id_2101(var_0, var_1) {
  thread _id_2647(var_0, var_1);
  self waittill("gather_delay_finished" + var_0 + var_1);
}

_id_2648(var_0) {
  animscripts\utility::_id_20CC(var_0);
}

_id_2649(var_0) {
  self waittill("death");
  level notify(var_0);
}

_id_264A(var_0) {
  if(var_0 == 0) {
    return "0";
  }
  if(var_0 == 1) {
    return "1";
  }
  if(var_0 == 2) {
    return "2";
  }
  if(var_0 == 3) {
    return "3";
  }
  if(var_0 == 4) {
    return "4";
  }
  if(var_0 == 5) {
    return "5";
  }
  if(var_0 == 6) {
    return "6";
  }
  if(var_0 == 7) {
    return "7";
  }
  if(var_0 == 8) {
    return "8";
  }
  if(var_0 == 9) {
    return "9";
  }
}

_id_264B(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = var_4.script_linkname;

    if(!isDefined(var_5)) {
      continue;
    }
    if(!isDefined(var_1[var_5])) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_264C(var_0, var_1) {
  if(!var_0.size) {
    return var_1;
  }
  if(!var_1.size) {
    return var_0;
  }
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_2[var_4.script_linkname] = 1;
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    if(isDefined(var_2[var_4.script_linkname])) {
      continue;
    }
    var_2[var_4.script_linkname] = 1;
    var_0[var_0.size] = var_4;
  }

  return var_0;
}

_id_1843(var_0, var_1) {
  if(var_0.size == 0) {
    return var_1;
  }
  if(var_1.size == 0) {
    return var_0;
  }
  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      continue;
    } else {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_264D(var_0, var_1) {
  var_2 = var_0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(is_in_array(var_0, var_1[var_3])) {
      var_2 = common_scripts\utility::array_remove(var_2, var_1[var_3]);
    }
  }

  return var_2;
}

_id_264E(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return 0;
  }
  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5])) {
      return 0;
    }
    var_4 = var_1[var_5];

    if(var_4 != var_3) {
      return 0;
    }
  }

  return 1;
}

_id_0AD1(var_0, var_1) {
  if(var_0.size <= 0) {
    return 0;
  }
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_264F() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = common_scripts\utility::get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");
      var_0 = common_scripts\utility::array_combine(var_0, var_4);
    }
  }

  return var_0;
}

draw_line(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    wait 0.05;
  }
}

_id_2651(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    wait 0.05;

    if(!isDefined(var_1) || !isDefined(var_1.origin)) {
      return;
    }
  }
}

_id_2652(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_2651(var_1, var_0, var_2, var_3, var_4, var_5);
}

_id_2653(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    wait 0.05;
  }
}

_id_2654(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 endon(var_6);

  for(;;) {
    wait 0.05;
  }
}

_id_2655(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 endon(var_6);

  for(;;) {
    common_scripts\utility::draw_line_for_time(var_0, var_1, var_2, var_3, var_4, 0.05);
  }
}

_id_2656(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 = gettime() + var_6 * 1000;
  var_1 = var_1 * var_2;

  while(gettime() < var_6) {
    wait 0.05;

    if(!isDefined(var_0) || !isDefined(var_0.origin)) {
      return;
    }
  }
}

_id_2657(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 16;
  var_8 = 360 / var_7;
  var_9 = [];

  for(var_10 = 0; var_10 < var_7; var_10++) {
    var_11 = var_8 * var_10;
    var_12 = cos(var_11) * var_1;
    var_13 = sin(var_11) * var_1;
    var_14 = var_0[0] + var_12;
    var_15 = var_0[1] + var_13;
    var_16 = var_0[2];
    var_9[var_9.size] = (var_14, var_15, var_16);
  }

  thread _id_2658(var_9, var_2, var_3, var_4, var_5, var_6);
}

_id_2658(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6];

    if(var_6 + 1 >= var_0.size) {
      var_8 = var_0[0];
    } else {
      var_8 = var_0[var_6 + 1];
    }
    thread _id_2655(var_7, var_8, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_2659() {
  self notify("enemy");
  self clearenemy();
}

_id_265A(var_0) {
  level notify("battlechatter_off_thread");
  animscripts\battlechatter::_id_0B8D();

  if(isDefined(var_0)) {
    _id_0B8E(var_0, 0);
    var_1 = getaiarray(var_0);
  } else {
    foreach(var_0 in anim._id_0B7F) {}
    _id_0B8E(var_0, 0);

    var_1 = getaiarray();
  }

  if(!isDefined(anim._id_0AAB) || !anim._id_0AAB) {
    return;
  }
  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_1[var_4]._id_0AAF = 0;
  }
  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = var_1[var_4];

    if(!isalive(var_5)) {
      continue;
    }
    if(!var_5._id_0AAB) {
      continue;
    }
    if(!var_5._id_0AC9) {
      continue;
    }
    var_5 maps\_utility_code::_id_13C2();
  }

  var_6 = gettime() - anim._id_0B83["allies"];

  if(var_6 < 1500) {
    wait(var_6 / 1000);
  }
  if(isDefined(var_0)) {
    level notify(var_0 + " done speaking");
  } else {
    level notify("done speaking");
  }
}

_id_265B(var_0) {
  thread _id_265C(var_0);
}

_id_265C(var_0) {
  level endon("battlechatter_off_thread");
  animscripts\battlechatter::_id_0B8D();

  while(!isDefined(anim._id_0AAB)) {
    wait 0.05;
  }
  common_scripts\utility::flag_set("battlechatter_on_thread_waiting");
  wait 1.5;
  common_scripts\utility::flag_clear("battlechatter_on_thread_waiting");

  if(isDefined(var_0)) {
    _id_0B8E(var_0, 1);
    var_1 = getaiarray(var_0);
  } else {
    foreach(var_0 in anim._id_0B7F) {}
    _id_0B8E(var_0, 1);

    var_1 = getaiarray();
  }

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_1[var_4] _id_0D72(1);
  }
}

_id_0D72(var_0) {
  if(!anim._id_0AAB) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(var_0) {
    if(isDefined(self._id_217D) && !self._id_217D) {
      self._id_0AAF = 0;
    } else {
      self._id_0AAF = 1;
    }
  } else {
    self._id_0AAF = 0;

    if(isDefined(self._id_0AC9) && self._id_0AC9) {
      self waittill("done speaking");
    }
  }
}

_id_265D(var_0, var_1) {
  if(!anim._id_0AAB) {
    return;
  }
  var_2 = getarraykeys(anim._id_0AB3);
  var_3 = _id_0AD1(var_2, var_1);

  if(!var_3) {
    return;
  }
  var_4 = getaiarray(var_0);

  foreach(var_6 in var_4) {}
  var_6 _id_265E(var_1);
}

_id_265E(var_0) {
  if(!anim._id_0AAB) {
    return;
  }
  var_1 = getarraykeys(anim._id_0AB3);
  var_2 = _id_0AD1(var_1, var_0);

  if(!var_2) {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(isDefined(self._id_0AC9) && self._id_0AC9) {
    self waittill("done speaking");
    wait 0.1;
  }

  animscripts\battlechatter_ai::_id_0AC5();
  wait 0.1;
  self.voice = var_0;
  animscripts\battlechatter_ai::_id_0AA9();
}

_id_265F(var_0) {
  thread _id_2660(1, var_0);
}

_id_16A4(var_0) {
  thread _id_2660(0, var_0);
}

_id_2660(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "allies";
  }
  if(!anim._id_0AAB) {
    return;
  }
  wait 1.5;
  level._id_0AB0[var_1] = var_0;
  var_2 = [];
  var_2 = getaiarray(var_1);
  common_scripts\utility::array_thread(var_2, ::_id_2661, var_0);
}

_id_2661(var_0) {
  self._id_0AB0 = var_0;
}

_id_2662() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 _id_0AD4(0);
    }
  }

  level._id_0AD3 = 0;
}

_id_2663() {
  var_0 = getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 _id_0AD4(1);
    }
  }

  level._id_0AD3 = 1;
}

_id_0AD4(var_0) {
  if(var_0) {
    self._id_0C39 = undefined;
  } else {
    self._id_0C39 = 1;
  }
}

_id_221D(var_0) {
  level.player setfriendlychain(var_0);
  level notify("newFriendlyChain", var_0.script_noteworthy);
}

_id_2664(var_0) {
  var_1 = getEntArray("objective", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].script_noteworthy == var_0) {
      return var_1[var_2].origin;
    }
  }
}

_id_2665(var_0) {
  var_1 = getEntArray("objective_event", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].script_noteworthy == var_0) {
      return var_1[var_2];
    }
  }
}

_id_2666() {
  maps\_utility_code::_id_13BE(1);
}

_id_2667() {
  maps\_utility_code::_id_13BE(0);
}

_id_2668() {
  var_0 = getnode(self.target, "targetname");
  var_1 = getEntArray(self.target, "targetname");
  _id_266A(var_1);
  level notify("new_friendly_trigger");
  level.player _id_221D(var_0);
}

_id_2669() {
  self notify("flood_begin");
}

_id_266A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(!isDefined(level._id_21F8)) {
    level._id_21F8 = [];
  }
  common_scripts\utility::array_thread(var_0, maps\_spawner::_id_21FD, var_1);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2]._id_21FB = 1;
    var_0[var_2] notify("flood_begin");
  }
}

_id_19B3() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");

  for(;;) {
    var_0 = anglesToForward(self.angles);
    var_1 = var_0 * 30;
    var_2 = var_0 * 20;
    var_3 = anglestoright(self.angles);
    var_4 = var_3 * -10;
    var_3 = var_3 * 10;
    wait 0.05;
  }
}

_id_2051() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = common_scripts\utility::get_links();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = common_scripts\utility::getstruct(var_1[var_2], "script_linkname");

      if(isDefined(var_3)) {
        var_0[var_0.size] = var_3;
      }
    }
  }

  return var_0;
}

_id_266B(var_0) {
  var_1 = self;

  while(isDefined(var_1.target)) {
    wait 0.05;

    if(isDefined(var_1.target)) {
      switch (var_0) {
        case "vehiclenode":
          var_1 = getvehiclenode(var_1.target, "targetname");
          break;
        case "pathnode":
          var_1 = getnode(var_1.target, "targetname");
          break;
        case "ent":
          var_1 = getent(var_1.target, "targetname");
          break;
        case "struct":
          var_1 = common_scripts\utility::getstruct(var_1.target, "targetname");
          break;
        default:
      }

      continue;
    }

    break;
  }

  var_2 = var_1;
  return var_2;
}

_id_266C(var_0) {
  var_1 = spawn("script_origin", level.player.origin);
  var_1 linkto(level.player);

  if(isDefined(var_0)) {
    thread timeout(var_0);
  }
  self setgoalentity(var_1);

  if(!isDefined(self._id_122C)) {
    self._id_122C = self.goalradius;
  }
  self.goalradius = 300;
  common_scripts\utility::waittill_any("goal", "timeout");

  if(isDefined(self._id_122C)) {
    self.goalradius = self._id_122C;
    self._id_122C = undefined;
  }

  var_1 delete();
}

timeout(var_0) {
  self endon("death");
  wait(var_0);
  self notify("timeout");
}

_id_251E() {
  if(isDefined(self._id_266D)) {
    return;
  }
  self._id_266E = self.pathenemyfightdist;
  self._id_266F = self.pathenemylookahead;
  self._id_2670 = self.maxsightdistsqrd;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 1;
  self._id_266D = 1;
}

_id_2521() {
  if(!isDefined(self._id_266D)) {
    return;
  }
  self.pathenemyfightdist = self._id_266E;
  self.pathenemylookahead = self._id_266F;
  self.maxsightdistsqrd = self._id_2670;
  self._id_266D = undefined;
}

_id_0BC3(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

_id_2671(var_0) {
  var_1 = [];
  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_0[var_4])) {
      continue;
    }
    var_1[var_4] = var_0[var_4];
  }

  return var_1;
}

_id_1361(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_2672(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3 _id_0D69()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_2673(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}

array_remove_nokeys(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_1) {
      var_2[var_2.size] = var_0[var_3];
    }
  }

  return var_2;
}

array_remove_index(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    if(var_2 == var_1) {
      var_0[var_2] = var_0[var_2 + 1];
      var_1++;
    }
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

_id_1F09(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0) {}
  var_4 notify(var_1, var_2);
}

_id_1FFC() {
  var_0 = spawnStruct();
  var_0._id_0C6D = [];
  var_0._id_22A9 = 0;
  return var_0;
}

_id_2008(var_0, var_1) {
  var_0._id_0C6D[var_0._id_22A9] = var_1;
  var_1._id_13B8 = var_0._id_22A9;
  var_0._id_22A9++;
}

_id_2675(var_0, var_1) {
  _id_2676(var_0, var_1);
  var_0._id_0C6D[var_0._id_22A9 - 1] = undefined;
  var_0._id_22A9--;
}

_id_2009(var_0, var_1) {
  if(isDefined(var_0._id_0C6D[var_0._id_22A9 - 1])) {
    var_0._id_0C6D[var_1] = var_0._id_0C6D[var_0._id_22A9 - 1];
    var_0._id_0C6D[var_1]._id_13B8 = var_1;
    var_0._id_0C6D[var_0._id_22A9 - 1] = undefined;
    var_0._id_22A9 = var_0._id_0C6D.size;
  } else {
    var_0._id_0C6D[var_1] = undefined;
    _id_200A(var_0);
  }
}

_id_200A(var_0) {
  var_1 = [];

  foreach(var_3 in var_0._id_0C6D) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_0._id_0C6D = var_1;

  foreach(var_6, var_3 in var_0._id_0C6D) {}
  var_3._id_13B8 = var_6;

  var_0._id_22A9 = var_0._id_0C6D.size;
}

_id_2676(var_0, var_1) {
  var_0 maps\_utility_code::_id_13B7(var_0._id_0C6D[var_0._id_22A9 - 1], var_1);
}

_id_22AC(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0 maps\_utility_code::_id_13B7(var_0._id_0C6D[var_2], var_0._id_0C6D[randomint(var_0._id_22A9)]);
  }
}

_id_2677(var_0, var_1) {
  var_2 = var_0;
  maps\_audio_zone_manager::_id_1571(var_2, var_1);
}

_id_2678() {
  if(level.console) {
    return " + usereload";
  } else {
    return " + activate";
  }
}

_id_2679() {
  self teleport((0, 0, -15000));
  self kill((0, 0, 0));
}

_id_1EFE(var_0) {
  return animscripts\battlechatter_ai::_id_0B40(var_0);
}

_id_267A(var_0, var_1) {
  var_2 = newhudelem();

  if(level.console) {
    var_2.x = 68;
    var_2.y = 35;
  } else {
    var_2.x = 58;
    var_2.y = 95;
  }

  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "left";
  var_2.vertalign = "middle";

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = level._id_22EC;
  }
  var_2 setclock(var_3, var_0, "hudStopwatch", 64, 64);
  return var_2;
}

_id_267B(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_2214.size; var_2++) {
    if(level._id_2214[var_2] != var_0) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

_id_267C(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_2216.size; var_2++) {
    if(level._id_2216[var_2] != var_0) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

_id_267D(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_2214.size; var_2++) {
    if(level._id_2214[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level._id_2214[var_2];
  }

  level._id_2214 = var_1;
  var_3 = 0;

  for(var_2 = 0; var_2 < level._id_2216.size; var_2++) {
    if(level._id_2216[var_2] != var_0) {
      continue;
    }
    var_3 = 1;
  }

  if(!var_3) {
    level._id_2216[level._id_2216.size] = var_0;
  }
}

_id_267E(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_2216.size; var_2++) {
    if(level._id_2216[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level._id_2216[var_2];
  }

  level._id_2216 = var_1;
  var_3 = 0;

  for(var_2 = 0; var_2 < level._id_2214.size; var_2++) {
    if(level._id_2214[var_2] != var_0) {
      continue;
    }
    var_3 = 1;
  }

  if(!var_3) {
    level._id_2214[level._id_2214.size] = var_0;
  }
}

_id_267F() {
  level thread maps\_friendlyfire::_id_1FF6(self);
}

_id_1826() {
  if(level._id_16C9) {
    return;
  }
  if(isDefined(level._id_195A)) {
    return;
  }
  level._id_16C9 = 1;
  common_scripts\utility::flag_set("missionfailed");

  if(_id_09D4()) {
    return;
  }
  if(getDvar("failure_disabled") == "1") {
    return;
  }
  if(_id_0A36()) {
    level._id_16CE = gettime();
    thread maps\_specialops_code::_id_18D0();
    return;
  }

  maps\_utility_code::_id_1453(0);
  missionfailed();
}

script_delay() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
    return 1;
  } else if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
    wait(randomfloatrange(self.script_delay_min, self.script_delay_max));
    return 1;
  }

  return 0;
}

_id_2133() {
  var_0 = gettime();

  if(isDefined(self._id_2133)) {
    wait(self._id_2133);

    if(isDefined(self._id_2680)) {
      self._id_2133 = self._id_2133 + self._id_2680;
    }
  } else if(isDefined(self._id_2681) && isDefined(self._id_2682)) {
    wait(randomfloatrange(self._id_2681, self._id_2682));

    if(isDefined(self._id_2680)) {
      self._id_2681 = self._id_2681 + self._id_2680;
      self._id_2682 = self._id_2682 + self._id_2680;
    }
  }

  return gettime() - var_0;
}

_id_2683(var_0) {
  maps\_vehicle_aianim::_id_24E5(var_0);
}

_id_2684(var_0, var_1) {
  maps\_vehicle_aianim::_id_2517(var_0, var_1);
}

_id_1377(var_0, var_1) {
  var_2 = getaiarray(var_0);
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isDefined(var_5._id_134B)) {
      continue;
    }
    if(var_5._id_134B != var_1) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  return var_3;
}

_id_2685() {
  var_0 = getaiarray("allies");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3._id_134B)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_1F4F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  var_2 = getnodearray(var_0, "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  var_2 = common_scripts\utility::getStructArray(var_0, "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  var_2 = getvehiclenodearray(var_0, "targetname");
  var_1 = common_scripts\utility::array_combine(var_1, var_2);
  return var_1;
}

_id_2686() {
  if(isDefined(self._id_134B)) {
    return;
  }
  if(!isDefined(self._id_2687)) {
    return;
  }
  _id_13A4(self._id_2687);
  self._id_2687 = undefined;
}

_id_2688() {
  self._id_13CF = 1;
  _id_2686();
}

_id_123B() {
  if(isDefined(self._id_13CE)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  self clearfixednodesafevolume();

  if(!isDefined(self._id_134B)) {
    return;
  }
  self._id_2687 = self._id_134B;
  level._id_1348[maps\_colors::_id_13B5()][self._id_134B] = common_scripts\utility::array_remove(level._id_1348[maps\_colors::_id_13B5()][self._id_134B], self);
  maps\_colors::_id_1396();
  self._id_134B = undefined;
  self._id_134D = undefined;
}

_id_219B() {
  _id_123B();
}

_id_2689(var_0) {
  var_1 = level._id_1345[tolower(var_0)];

  if(isDefined(self._id_134B) && var_1 == self._id_134B) {
    return 1;
  } else {
    return 0;
  }
}

_id_268A() {
  var_0 = self._id_134B;
  return var_0;
}

_id_268B(var_0) {
  return level._id_1345[tolower(var_0)];
}

_id_13A4(var_0) {
  var_1 = _id_268B(var_0);

  if(!isai(self)) {
    _id_268C(var_1);
    return;
  }

  if(self.team == "allies") {
    self.fixednode = 1;
    self.fixednodesaferadius = 64;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 0;
  }

  self._id_1342 = undefined;
  self._id_1341 = undefined;
  self._id_2687 = undefined;
  var_2 = maps\_colors::_id_13B5();

  if(isDefined(self._id_134B)) {
    level._id_1348[var_2][self._id_134B] = common_scripts\utility::array_remove(level._id_1348[var_2][self._id_134B], self);
  }
  self._id_134B = var_1;
  level._id_1348[var_2][var_1] = _id_1361(level._id_1348[var_2][var_1]);
  level._id_1348[var_2][self._id_134B] = _id_0BC3(level._id_1348[var_2][self._id_134B], self);
  thread maps\_utility_code::_id_13CD(var_1);
}

_id_268C(var_0) {
  self._id_134B = var_0;
  self._id_2687 = undefined;
}

_id_268D(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_3 = [];
  var_4 = [];

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_6 = undefined;

    if(issubstr(var_2[var_5], "r")) {
      var_6 = "r";
    } else if(issubstr(var_2[var_5], "b")) {
      var_6 = "b";
    } else if(issubstr(var_2[var_5], "y")) {
      var_6 = "y";
    } else if(issubstr(var_2[var_5], "c")) {
      var_6 = "c";
    } else if(issubstr(var_2[var_5], "g")) {
      var_6 = "g";
    } else if(issubstr(var_2[var_5], "p")) {
      var_6 = "p";
    } else if(issubstr(var_2[var_5], "o")) {
      var_6 = "o";
    } else {}

    var_4[var_6] = var_2[var_5];
    var_3[var_3.size] = var_6;
  }

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    level._id_1360[var_1][var_2[var_5]] = common_scripts\utility::array_removeundefined(level._id_1360[var_1][var_2[var_5]]);

    for(var_7 = 0; var_7 < level._id_1360[var_1][var_2[var_5]].size; var_7++) {
      level._id_1360[var_1][var_2[var_5]][var_7]._id_134D = var_2[var_5];
    }
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    level._id_1348[var_1][var_3[var_5]] = _id_1361(level._id_1348[var_1][var_3[var_5]]);
    level._id_1346[var_1][var_3[var_5]] = var_4[var_3[var_5]];
  }

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    thread maps\_colors::_id_1371(var_2[var_5], var_3[var_5], var_1);
  }
}

flashrumbleloop(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

_id_268F(var_0) {
  self endon("death");
  self endon("flashed");
  wait 0.2;
  self enablehealthshield(0);
  wait(var_0 + 2);
  self enablehealthshield(1);
}

_id_2690(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [0.8, 0.7, 0.7, 0.6];
  var_6 = [1.0, 0.8, 0.6, 0.6];

  foreach(var_12, var_8 in var_6) {
    var_9 = (var_1 - 0.85) / 0.15;

    if(var_9 > var_2) {
      var_2 = var_9;
    }
    if(var_2 < 0.25) {
      var_2 = 0.25;
    }
    var_10 = 0.3;

    if(var_1 > 1 - var_10) {
      var_1 = 1.0;
    } else {
      var_1 = var_1 / (1 - var_10);
    }
    if(var_4 != self.team) {
      var_11 = var_1 * var_2 * 6.0;
    } else {
      var_11 = var_1 * var_2 * 3.0;
    }
    if(var_11 < 0.25) {
      continue;
    }
    var_11 = var_8 * var_11;

    if(isDefined(self._id_2691) && var_11 > self._id_2691) {
      var_11 = self._id_2691;
    }
    self._id_23BA = var_4;
    self notify("flashed");
    self.flashendtime = gettime() + var_11 * 1000;
    self shellshock("flashbang", var_11);
    common_scripts\utility::flag_set("player_flashed");

    if(var_1 * var_2 > 0.5) {
      thread _id_268F(var_11);
    }
    wait(var_5[var_12]);
  }

  thread maps\_utility_code::_id_13EB(0.05);
}

_id_1E8C() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4);

    if("1" == getDvar("noflash")) {
      continue;
    }
    if(_id_1A43(self)) {
      continue;
    }
    if(isDefined(self._id_1C0B)) {
      var_5 = 0.8;
      var_6 = 1.0 - var_5;
      self._id_1C0B = undefined;

      if(var_1 < var_6) {
        continue;
      }
      var_1 = (var_1 - var_6) / var_5;
    }

    var_7 = (var_1 - 0.85) / 0.15;

    if(var_7 > var_2) {
      var_2 = var_7;
    }
    if(var_2 < 0.25) {
      var_2 = 0.25;
    }
    var_8 = 0.3;

    if(var_1 > 1 - var_8) {
      var_1 = 1.0;
    } else {
      var_1 = var_1 / (1 - var_8);
    }
    if(var_4 != self.team) {
      var_9 = var_1 * var_2 * 6.0;
    } else {
      var_9 = var_1 * var_2 * 3.0;
    }
    if(var_9 < 0.25) {
      continue;
    }
    if(isDefined(self._id_2691) && var_9 > self._id_2691) {
      var_9 = self._id_2691;
    }
    self._id_23BA = var_4;
    self notify("flashed");
    self.flashendtime = gettime() + var_9 * 1000;
    self shellshock("flashbang", var_9);
    common_scripts\utility::flag_set("player_flashed");
    thread maps\_utility_code::_id_13EB(var_9);

    if(var_1 * var_2 > 0.5) {
      thread _id_268F(var_9);
    }
    if(var_9 > 2) {
      thread flashrumbleloop(0.75);
    } else {
      thread flashrumbleloop(0.25);
    }
    if(var_4 != "allies") {
      thread _id_2692(var_9, var_4);
    }
  }
}

_id_2692(var_0, var_1) {
  wait 0.05;
  var_2 = getaiarray("allies");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distancesquared(var_2[var_3].origin, self.origin) < 122500) {
      var_4 = var_0 + randomfloatrange(-1000, 1500);

      if(var_4 > 4.5) {
        var_4 = 4.5;
      } else if(var_4 < 0.25) {
        continue;
      }
      var_5 = gettime() + var_4 * 1000;

      if(!isDefined(var_2[var_3].flashendtime) || var_2[var_3].flashendtime < var_5) {
        var_2[var_3]._id_23BA = var_1;
        var_2[var_3] _id_23BB(var_4);
      }
    }
  }
}

_id_1655() {
  common_scripts\_createfx::restart_fx_looper();
}

_id_2693(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {}
      var_3 common_scripts\utility::pauseeffect();

      return;
    }
  } else {
    foreach(var_6 in level.createfxent) {
      if(!isDefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] != var_0) {
        continue;
      }
      var_6 common_scripts\utility::pauseeffect();
    }
  }
}

_id_2694(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {}
      var_3 _id_1655();

      return;
    }
  } else {
    foreach(var_6 in level.createfxent) {
      if(!isDefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] != var_0) {
        continue;
      }
      var_6 _id_1655();
    }
  }
}

_id_2695(var_0) {
  var_1 = [];

  if(isDefined(level.createfxbyfxid)) {
    var_2 = level.createfxbyfxid[var_0];

    if(isDefined(var_2)) {
      var_1 = var_2;
    }
  } else {
    for(var_3 = 0; var_3 < level.createfxent.size; var_3++) {
      if(level.createfxent[var_3].v["fxid"] == var_0) {
        var_1[var_1.size] = level.createfxent[var_3];
      }
    }
  }

  return var_1;
}

_id_2696(var_0) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");

  if(var_0) {
    self._id_2697 = self getthreatbiasgroup();
    var_1 = undefined;
    createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var_2 = [];
    var_2["axis"] = "allies";
    var_2["allies"] = "axis";
    var_3 = getaiarray(var_2[self.team]);
    var_4 = [];

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_4[var_3[var_5] getthreatbiasgroup()] = 1;
    }
    var_6 = getarraykeys(var_4);

    for(var_5 = 0; var_5 < var_6.size; var_5++) {
      setthreatbias(var_6[var_5], "ignore_everybody", 0);
    }
  } else {
    var_1 = undefined;

    if(self._id_2697 != "") {
      self setthreatbiasgroup(self._id_2697);
    }
    self._id_2697 = undefined;
  }
}

_id_2698() {
  maps\_vehicle::_id_2699();
}

_id_269A() {
  thread maps\_vehicle::_id_269B();
}

_id_269C(var_0) {
  maps\_vehicle::_id_269D(var_0);
}

_id_269E(var_0) {
  maps\_vehicle::_id_269F(var_0);
}

_id_26A0(var_0, var_1) {
  maps\_vehicle::_id_26A1(var_0, var_1);
}

_id_1277(var_0) {
  return bulletTrace(var_0, var_0 + (0, 0, -100000), 0, self)["position"];
}

_id_2248(var_0) {
  self._id_232C = self._id_232C + var_0;
  self notify("update_health_packets");

  if(self._id_232C >= 3) {
    self._id_232C = 3;
  }
}

_id_26A2(var_0) {
  var_1 = _id_26A3(var_0);
  return var_1[0];
}

_id_26A3(var_0) {
  return maps\_vehicle::_id_26A4(var_0);
}

_id_26A5(var_0, var_1, var_2, var_3) {
  _id_26A8();

  if(!isDefined(level._id_26A6)) {
    level._id_26A6 = [];
  }
  level._id_26A6[var_0] = _id_26A7(var_0, var_1, var_2, var_3);
}

_id_1E74(var_0, var_1, var_2, var_3) {
  _id_26A8();
  var_0 = tolower(var_0);

  if(isDefined(level._id_26A6) && isDefined(level._id_26A6[var_0])) {
    var_5 = level._id_26A6[var_0];
  } else {
    var_5 = _id_26A7(var_0, var_1, var_2, var_3);
  }
  if(!isDefined(var_1)) {
    if(!isDefined(level._id_26A6)) {} else if(!issubstr(var_0, "no_game")) {
      if(!isDefined(level._id_26A6[var_0])) {
        return;
      }
    }
  }

  level._id_1F18[level._id_1F18.size] = var_5;
  level._id_1F1D[var_0] = var_5;
}

_id_1C39() {
  return issubstr(level._id_1F19, "no_game");
}

_id_26A7(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["name"] = var_0;
  var_4["start_func"] = var_1;
  var_4["start_loc_string"] = var_2;
  var_4["logic_func"] = var_3;
  return var_4;
}

_id_26A8() {
  if(!isDefined(level._id_1F18)) {
    level._id_1F18 = [];
  }
}

_id_1F1C() {
  return level._id_1F18.size > 1;
}

_id_26A9(var_0) {
  level._id_1F1A = var_0;
}

_id_1F1B(var_0) {
  level._id_1F1B = var_0;
}

_id_26AA(var_0, var_1, var_2, var_3) {
  thread maps\_utility_code::_id_13B6(var_0, var_1, var_2, var_3);
}

within_fov(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

_id_26AB(var_0, var_1, var_2, var_3) {
  var_0 = _id_27A7(var_0, 0);
  var_2 = _id_27A7(var_2, 0);
  var_1 = (0, var_1[1], 0);
  var_4 = vectornormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

_id_26AC(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

_id_26AD(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3] getEye();
    var_2 = within_fov(var_4, level.players[var_3] getplayerangles(), var_0, var_1);

    if(!var_2) {
      return 0;
    }
  }

  return 1;
}

_id_26AE(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0;
    var_0 = 0;
  }

  wait(randomfloatrange(var_0, var_1));

  if(1) {
    return;
  }
  var_2 = undefined;

  if(!isDefined(level._id_13BC)) {
    level._id_13BC = 1;
    level._id_13BA = 0;
    var_2 = level._id_13BA;
    level._id_13BA++;
    thread maps\_utility_code::_id_13B9(var_0, var_1);
  } else {
    var_2 = level._id_13BA;
    level._id_13BA++;
    waittillframeend;
  }

  waittillframeend;
  wait(level._id_13BB[var_2]);
}

_id_1254(var_0, var_1) {
  var_2 = var_1 * 1000 - (gettime() - var_0);
  var_2 = var_2 * 0.001;

  if(var_2 > 0) {
    wait(var_2);
  }
}

_id_16EA() {
  anim._id_0BA4 = gettime();
}

_id_168C(var_0) {
  _id_16EA();
  maps\_anim::_id_1252(self, var_0);
}

_id_26AF(var_0, var_1) {
  _id_16EA();
  maps\_anim::_id_1256(self, var_0, undefined, undefined, var_1);
}

_id_11F4(var_0, var_1) {
  if(!isDefined(level._id_26B0)) {
    var_2 = spawn("script_origin", (0, 0, 0));
    var_2 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level._id_26B0 = var_2;
  }

  _id_16EA();
  var_3 = 0;

  if(!isDefined(var_1)) {
    var_3 = level._id_26B0 _id_1255(::play_sound_on_tag, level._id_11BB[var_0], undefined, 1);
  } else {
    var_3 = level._id_26B0 _id_1257(var_1, ::play_sound_on_tag, level._id_11BB[var_0], undefined, 1);
  }
  return var_3;
}

_id_26B1(var_0) {
  level._id_26B0 play_sound_on_tag(level._id_11BB[var_0], undefined, 1);
}

_id_1926() {
  if(!isDefined(level._id_26B0)) {
    return;
  }
  level._id_26B0 delete();
}

_id_26B2() {
  if(!isDefined(level._id_26B0)) {
    return;
  }
  level._id_26B0 _id_271C();
}

_id_26B3(var_0) {
  if(!isDefined(level._id_26B0)) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level._id_26B0 = var_1;
  }

  level._id_26B0 play_sound_on_tag(level._id_11BB[var_0], undefined, 1);
}

_id_26B4(var_0) {
  return _id_11F4(var_0, 0.05);
}

_id_1419(var_0) {
  _id_11F4(var_0);
}

_id_26B5(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_1) && var_1 == 1) {
    var_3._id_26B6 = newhudelem();
  }
  var_3._id_26B7 = newhudelem();
  var_3 _id_26B9(var_2);
  var_3._id_26B7 settext(var_0);
  return var_3;
}

_id_26B8() {
  self notify("death");

  if(isDefined(self._id_26B7)) {
    self._id_26B7 destroy();
  }
  if(isDefined(self._id_26B6)) {
    self._id_26B6 destroy();
  }
}

_id_26B9(var_0) {
  if(level.console) {
    self._id_26B7.fontscale = 2;
  } else {
    self._id_26B7.fontscale = 1.6;
  }
  self._id_26B7.x = 0;
  self._id_26B7.y = -40;
  self._id_26B7.alignx = "center";
  self._id_26B7.aligny = "bottom";
  self._id_26B7.horzalign = "center";
  self._id_26B7.vertalign = "middle";
  self._id_26B7.sort = 1;
  self._id_26B7.alpha = 0.8;

  if(!isDefined(self._id_26B6)) {
    return;
  }
  self._id_26B6.x = 0;
  self._id_26B6.y = -40;
  self._id_26B6.alignx = "center";
  self._id_26B6.aligny = "middle";
  self._id_26B6.horzalign = "center";
  self._id_26B6.vertalign = "middle";
  self._id_26B6.sort = -1;

  if(level.console) {
    self._id_26B6 setshader("popmenu_bg", 650, 52);
  } else {
    self._id_26B6 setshader("popmenu_bg", 650, 42);
  }
  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }
  self._id_26B6.alpha = var_0;
}

string(var_0) {
  return "" + var_0;
}

_id_26BA(var_0, var_1) {
  setignoremegroup(var_0, var_1);
  setignoremegroup(var_1, var_0);
}

_id_1A5A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["function"] = var_1;
  var_5["param1"] = var_2;
  var_5["param2"] = var_3;
  var_5["param3"] = var_4;
  level._id_1E97[var_0][level._id_1E97[var_0].size] = var_5;
}

_id_26BB(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_1E97[var_0].size; var_3++) {
    if(level._id_1E97[var_0][var_3]["function"] != var_1) {
      var_2[var_2.size] = level._id_1E97[var_0][var_3];
    }
  }

  level._id_1E97[var_0] = var_2;
}

_id_26BC(var_0, var_1) {
  if(!isDefined(level._id_1E97)) {
    return 0;
  }
  for(var_2 = 0; var_2 < level._id_1E97[var_0].size; var_2++) {
    if(level._id_1E97[var_0][var_2]["function"] == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_26BD(var_0) {
  var_1 = [];

  foreach(var_3 in self._id_214D) {
    if(var_3["function"] == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self._id_214D = var_1;
}

add_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in self._id_214D) {
    if(var_7["function"] == var_0) {
      return;
    }
  }

  var_9 = [];
  var_9["function"] = var_0;
  var_9["param1"] = var_1;
  var_9["param2"] = var_2;
  var_9["param3"] = var_3;
  var_9["param4"] = var_4;
  var_9["param5"] = var_5;
  self._id_214D[self._id_214D.size] = var_9;
}

_id_135B(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] delete();
  }
}

_id_26BE(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] kill();
  }
}

_id_211C(var_0) {
  self endon("death");
  self.ignoretriggers = 1;

  if(isDefined(var_0)) {
    wait(var_0);
  } else {
    wait 0.5;
  }
  self.ignoretriggers = 0;
}

_id_26BF(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 _id_2703();
}

_id_26C0(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 _id_2703();
}

_id_26C1(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 common_scripts\utility::trigger_off();
}

_id_26C2(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 common_scripts\utility::trigger_off();
}

_id_26C3(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 common_scripts\utility::trigger_on();
}

_id_26C4(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 common_scripts\utility::trigger_on();
}

_id_26C5() {
  return isDefined(level._id_1E8B[_id_26C6()]);
}

_id_26C6() {
  if(!isDefined(self.unique_id)) {
    _id_218C();
  }
  return self.unique_id;
}

_id_218C() {
  self.unique_id = "ai" + level._id_1E7C;
  level._id_1E7C++;
}

_id_26C7() {
  level._id_1E8B[self.unique_id] = 1;
}

_id_219D() {
  level._id_1E8B[self.unique_id] = undefined;
}

_id_26C8() {
  var_0 = [];
  var_1 = getaiarray("allies");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] _id_26C5()) {
      var_0[var_0.size] = var_1[var_2];
    }
  }

  return var_0;
}

_id_26C9(var_0, var_1) {
  var_2 = getaiarray(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3].pacifist = var_1;
  }
}

_id_139E() {
  maps\_colors::_id_139D();
}

_id_26CA(var_0, var_1) {
  maps\_colors::_id_139B(var_0, var_1);
}

_id_26CB() {
  level._id_139F = [];
}

_id_26CC(var_0, var_1) {
  if(!isDefined(level._id_139F)) {
    level._id_139F = [];
  }
  var_0 = _id_268B(var_0);
  var_1 = _id_268B(var_1);
  level._id_139F[var_0] = var_1;

  if(!isDefined(level._id_139F[var_1])) {
    _id_26CD(var_1);
  }
}

_id_26CD(var_0) {
  if(!isDefined(level._id_139F)) {
    level._id_139F = [];
  }
  level._id_139F[var_0] = "none";
}

_id_1228(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_13A1(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] _id_26C5()) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

_id_26CE(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2]._id_1032)) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

_id_26CF(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4._id_134B)) {
      continue;
    }
    if(var_4._id_134B == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_26D0(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4.script_noteworthy)) {
      continue;
    }
    if(var_4.script_noteworthy == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_26D1(var_0, var_1) {
  var_2 = _id_1377("allies", var_0);
  var_2 = _id_13A1(var_2);

  if(!isDefined(var_1)) {
    var_3 = level.player.origin;
  } else {
    var_3 = var_1;
  }
  return _id_0AE9(var_3, var_2);
}

_id_13A3(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].classname, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

_id_26D2(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].model, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

_id_26D3(var_0, var_1, var_2) {
  var_3 = _id_1377("allies", var_0);
  var_3 = _id_13A1(var_3);

  if(!isDefined(var_2)) {
    var_4 = level.player.origin;
  } else {
    var_4 = var_2;
  }
  var_3 = _id_13A3(var_3, var_1);
  return _id_0AE9(var_4, var_3);
}

_id_26D4(var_0, var_1) {
  for(;;) {
    var_2 = _id_26D1(var_0);

    if(!isalive(var_2)) {
      wait 1;
      continue;
    }

    var_2 _id_13A4(var_1);
    return;
  }
}

_id_26D5(var_0, var_1) {
  for(;;) {
    var_2 = _id_26D1(var_0);

    if(!isalive(var_2)) {
      return;
    }
    var_2 _id_13A4(var_1);
    return;
  }
}

_id_26D6(var_0, var_1, var_2) {
  for(;;) {
    var_3 = _id_26D3(var_0, var_2);

    if(!isalive(var_3)) {
      return;
    }
    var_3 _id_13A4(var_1);
    return;
  }
}

_id_26D7(var_0, var_1, var_2) {
  for(;;) {
    var_3 = _id_26D3(var_0, var_2);

    if(!isalive(var_3)) {
      wait 1;
      continue;
    }

    var_3 _id_13A4(var_1);
    return;
  }
}

_id_26D8(var_0) {
  self orientmode("face angle", var_0);
  self.lockorientation = 1;
}

_id_26D9() {
  self.lockorientation = 0;
}

_id_26DA(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [];

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_3 || !issubstr(var_6.classname, var_2)) {
      var_4[var_4.size] = var_6;
      continue;
    }

    var_3 = 1;
    var_6 _id_13A4(var_1);
  }

  return var_4;
}

_id_26DB(var_0, var_1) {
  var_2 = 0;
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_2) {
      var_3[var_3.size] = var_5;
      continue;
    }

    var_2 = 1;
    var_5 _id_13A4(var_1);
  }

  return var_3;
}

_id_26DC(var_0) {
  maps\_utility_code::_id_13C4(var_0, "script_noteworthy");
}

_id_26DD(var_0) {
  maps\_utility_code::_id_13C4(var_0, "targetname");
}

_id_26DE(var_0, var_1) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  var_2 = spawnStruct();
  var_2 thread maps\_utility_code::_id_13C5(var_0);
  var_2 thread maps\_utility_code::_id_13C8(var_1);
  var_2 waittill("done");
}

_id_26DF(var_0, var_1) {
  var_2 = spawnStruct();
  var_2 thread maps\_utility_code::_id_13C6(self, var_0);
  var_2 thread maps\_utility_code::_id_13C8(var_1);
  var_2 waittill("done");
}

_id_26E0(var_0) {
  var_1 = spawnStruct();
  var_1 thread maps\_utility_code::_id_13C7(self);
  var_1 thread maps\_utility_code::_id_13C8(var_0);
  var_1 waittill("done");
}

_id_26E1(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = [];
  var_3 = common_scripts\utility::array_combine(var_3, getEntArray(var_0, "targetname"));
  var_3 = common_scripts\utility::array_combine(var_3, getEntArray(var_1, "targetname"));

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_2 thread maps\_utility_code::_id_13C7(var_3[var_4]);
  }
  var_2 waittill("done");
}

_id_26E2(var_0) {
  var_1 = maps\_spawner::_id_1B49(var_0);
  return var_1;
}

_id_212D(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }
  var_1 = maps\_spawner::_id_1B49(var_0);
  var_1[[level._id_1FFD]]();
  var_1._id_1E97 = var_0._id_214D;
  var_1 thread maps\_spawner::_id_2152();
  return var_1;
}

_id_2531(var_0) {
  return maps\_spawner::_id_2250(var_0);
}

_id_13C1() {
  if(isDefined(self._id_1692)) {
    return self._id_1692;
  }
  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }
}

_id_2198() {
  self.pathenemylookahead = 192;
  self.pathenemyfightdist = 192;
}

_id_26E3(var_0) {
  if(var_0 == "on") {
    _id_109B();
  } else {
    _id_109E();
  }
}

_id_109B(var_0) {
  if(!isDefined(var_0)) {
    self._id_109D = 1;
  }
  self._id_109A = 1;
  self.turnrate = 0.2;
  level thread animscripts\cqb::_id_107C();
}

_id_109E() {
  self._id_109A = undefined;
  self._id_109D = undefined;
  self.turnrate = 0.3;
  self._id_0CB9 = undefined;
}

_id_2194() {
  self._id_10FD = 1;
}

_id_26E4() {
  self._id_10FD = undefined;
}

_id_26E5(var_0) {
  if(!isDefined(var_0)) {
    self._id_0CB7 = undefined;
  } else {
    self._id_0CB7 = var_0;

    if(!isDefined(var_0.origin)) {
      return;
    }
  }
}

_id_26E6(var_0) {
  if(isDefined(var_0) && var_0) {
    self._id_24A4 = 1;
  } else {
    self._id_24A4 = undefined;
  }
}

_id_26E7(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    [[var_0]](var_1);
  } else {
    [[var_0]]();
  }
  if(isDefined(var_3)) {
    [[var_2]](var_3);
  } else {
    [[var_2]]();
  }
}

_id_26E8() {
  maps\_spawner::_id_219A();
}

_id_1DAA(var_0, var_1) {
  if(isDefined(var_1)) {
    self notify(var_0, var_1);
  } else {
    self notify(var_0);
  }
}

_id_11E4(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  var_3 delaythread(var_2, ::_id_1DAA, "complete");
  self waittillmatch(var_0, var_1);
}

_id_1E93(var_0) {
  var_0 notify("deleted");
  var_0 delete();
}

_id_26E9(var_0) {
  if(!isDefined(self._id_26EA)) {
    self._id_26EA = [];
  }
  if(isDefined(self._id_26EA[var_0.unique_id])) {
    return 0;
  }
  self._id_26EA[var_0.unique_id] = 1;
  return 1;
}

_id_1281(var_0) {
  return level._id_0C59[self._id_1032][var_0];
}

_id_26EB(var_0) {
  return isDefined(level._id_0C59[self._id_1032][var_0]);
}

_id_127E(var_0, var_1) {
  return level._id_0C59[var_1][var_0];
}

_id_26EC(var_0) {
  return level._id_0C59["generic"][var_0];
}

add_hint_string(var_0, var_1, var_2) {
  if(!isDefined(level._id_1E9D)) {
    level._id_1E9D = [];
    level._id_1E9E = [];
  }

  level._id_1E9D[var_0] = var_1;
  precachestring(var_1);

  if(isDefined(var_2)) {
    level._id_1E9E[var_0] = var_2;
  }
}

_id_26ED(var_0) {
  thread maps\_utility_code::_id_13E0(var_0);
}

_id_26EE(var_0) {
  var_0.timeout = 1;
}

_id_26EF(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_0, 0, var_1, 48);

  for(;;) {
    var_2 waittill("trigger", var_3);
    level.player dodamage(5, var_0);
  }
}

_id_26F0(var_0, var_1) {
  setthreatbias(var_0, var_1, 0);
  setthreatbias(var_1, var_0, 0);
}

_id_26F1(var_0) {}

_id_0F38() {
  animscripts\combat_utility::_id_238E();
}

_id_26F2(var_0, var_1) {
  if(!var_0.size) {
    return var_1;
  }
  var_2 = getarraykeys(var_1);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_0[var_2[var_3]] = var_1[var_2[var_3]];
  }
  return var_0;
}

_id_26F3(var_0) {
  self.ignoresuppression = var_0;
}

_id_26F4(var_0) {
  self.goalradius = var_0;
}

_id_26F5() {
  var_0 = self.export;

  for(;;) {
    var_1 = self dospawn();

    if(_id_13AF(var_1)) {
      wait 1;
      continue;
    }

    return var_1;
  }
}

_id_26F6(var_0) {
  self.allowdeath = var_0;
}

_id_26F7(var_0, var_1) {
  if(isDefined(var_1)) {
    self._id_241B = var_1;
  } else {
    self._id_241B = 1;
  }
  _id_2721();
  self._id_0FBC = level._id_0C59[self._id_1032][var_0];
  self._id_1081 = self._id_0FBC;
}

_id_2080() {
  self.a._id_0D2B = "walk";
  self._id_117F = 1;
  self._id_1199 = 1;
  self._id_206F = 1;
}

_id_26F8(var_0, var_1, var_2, var_3) {
  animscripts\animset::_id_0C83(var_0, var_1, var_2, var_3);
}

_id_26F9(var_0, var_1, var_2) {
  var_3 = anim._id_0C65._id_0C66[var_0];

  if(isarray(var_1)) {
    var_3["straight"] = var_1[0];
    var_3["move_f"] = var_1[0];
    var_3["move_l"] = var_1[1];
    var_3["move_r"] = var_1[2];
    var_3["move_b"] = var_1[3];
  } else {
    var_3["straight"] = var_1;
    var_3["move_f"] = var_1;
  }

  if(isDefined(var_2)) {
    var_3["sprint"] = var_2;
  }
  self._id_0C88[var_0] = var_3;
}

_id_26FA(var_0) {
  var_1 = level._id_0C59["generic"][var_0];

  if(isarray(var_1)) {
    self._id_10F6 = var_1;
  } else {
    self._id_10F6[0] = var_1;
  }
}

_id_26FB(var_0) {
  var_1 = level._id_0C59[self._id_1032][var_0];

  if(isarray(var_1)) {
    self._id_10F6 = var_1;
  } else {
    self._id_10F6[0] = var_1;
  }
}

_id_26FC() {
  self._id_10F6 = undefined;
  self notify("stop_specialidle");
}

_id_140B(var_0, var_1) {
  _id_140A(var_0, undefined, var_1);
}

_id_26FD() {
  self notify("movemode");
  _id_2722();
  self._id_0FBC = undefined;
  self._id_1081 = undefined;
}

_id_140A(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2) {
    self._id_241B = 1;
  } else {
    self._id_241B = undefined;
  }
  _id_2721();
  self._id_0FBC = level._id_0C59["generic"][var_0];
  self._id_1081 = self._id_0FBC;

  if(isDefined(var_1)) {
    self._id_0FBD = level._id_0C59["generic"][var_1];
    self._id_1082 = self._id_0FBD;
  } else {
    self._id_0FBD = undefined;
    self._id_1082 = undefined;
  }
}

_id_26FE(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2) {
    self._id_241B = 1;
  } else {
    self._id_241B = undefined;
  }
  _id_2721();
  self._id_0FBC = level._id_0C59[self._id_1032][var_0];
  self._id_1081 = self._id_0FBC;

  if(isDefined(var_1)) {
    self._id_0FBD = level._id_0C59[self._id_1032][var_1];
    self._id_1082 = self._id_0FBD;
  } else {
    self._id_0FBD = undefined;
    self._id_1082 = undefined;
  }
}

_id_140C() {
  self notify("clear_run_anim");
  self notify("movemode");

  if(self.type == "dog") {
    self.a._id_0D2B = "run";
    self._id_117F = 0;
    self._id_1199 = 0;
    self._id_206F = undefined;
    return;
  }

  if(!isDefined(self._id_26FF)) {
    _id_2722();
  }
  self._id_241B = undefined;
  self._id_0FBC = undefined;
  self._id_1081 = undefined;
  self._id_0FBD = undefined;
  self._id_1082 = undefined;
}

_id_2700(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
  return getdvarfloat(var_0);
}

_id_2701(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_physicsjolt");

  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(var_2)) {
    var_0 = 400;
    var_1 = 256;
    var_2 = (0, 0, 0.075);
  }

  var_3 = var_0 * var_0;
  var_4 = 3;
  var_5 = var_2;

  for(;;) {
    wait 0.1;
    var_2 = var_5;

    if(self.code_classname == "script_vehicle") {
      var_6 = self vehicle_getspeed();

      if(var_6 < var_4) {
        var_7 = var_6 / var_4;
        var_2 = var_5 * var_7;
      }
    }

    var_8 = distancesquared(self.origin, level.player.origin);
    var_7 = var_3 / var_8;

    if(var_7 > 1) {
      var_7 = 1;
    }
    var_2 = var_2 * var_7;
    var_9 = var_2[0] + var_2[1] + var_2[2];

    if(var_9 > 0.025) {
      physicsjitter(self.origin, var_0, var_1, var_2[2], var_2[2] * 2.0);
    }
  }
}

_id_2702(var_0) {
  self setgoalentity(var_0);
}

_id_2703(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    _id_2704(var_2);
  } else {
    common_scripts\utility::array_thread(getEntArray(var_0, var_1), ::_id_2704, var_2);
  }
}

_id_2704(var_0) {
  if(isDefined(self._id_1341)) {
    self._id_1358 = 1;
    maps\_colors::_id_135C("allies");
  }

  if(isDefined(self._id_1342)) {
    self._id_1358 = 1;
    maps\_colors::_id_135C("axis");
  }

  self notify("trigger", var_0);
}

_id_2705() {
  self delete();
}

_id_2706(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 _id_134F()) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_134F() {
  if(maps\_colors::_id_13B5() == "axis") {
    return isDefined(self._id_1342) || isDefined(self._id_134B);
  }
  return isDefined(self._id_1341) || isDefined(self._id_134B);
}

_id_2707() {
  _id_2708("axis");
  _id_2708("allies");
}

_id_2708(var_0) {
  level._id_1346[var_0]["r"] = undefined;
  level._id_1346[var_0]["b"] = undefined;
  level._id_1346[var_0]["c"] = undefined;
  level._id_1346[var_0]["y"] = undefined;
  level._id_1346[var_0]["p"] = undefined;
  level._id_1346[var_0]["o"] = undefined;
  level._id_1346[var_0]["g"] = undefined;
}

_id_19F4() {
  var_0 = [];
  var_0["r"] = (1, 0, 0);
  var_0["o"] = (1, 0.5, 0);
  var_0["y"] = (1, 1, 0);
  var_0["g"] = (0, 1, 0);
  var_0["c"] = (0, 1, 1);
  var_0["b"] = (0, 0, 1);
  var_0["p"] = (1, 0, 1);
  return var_0;
}

_id_1424(var_0, var_1) {
  self endon("death");

  if(var_1 > 0) {
    wait(var_1);
  }
  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
}

_id_24F5() {
  if(isai(self)) {
    animscripts\shared::_id_0C9B(self.weapon, "none");
  } else {
    self detach(getweaponmodel(self.weapon), "tag_weapon_right");
  }
}

_id_257D() {
  if(isai(self)) {
    animscripts\shared::_id_0C9B(self.weapon, "right");
  } else {
    self attach(getweaponmodel(self.weapon), "tag_weapon_right");
  }
}

_id_2709(var_0, var_1) {
  if(!animscripts\utility::_id_24C8(var_0)) {
    animscripts\init::_id_2098(var_0);
  }
  animscripts\shared::_id_0C9B(var_0, var_1);
}

_id_104A(var_0, var_1) {
  if(!animscripts\init::_id_209C(var_0)) {
    animscripts\init::_id_2098(var_0);
  }
  var_2 = self.weapon != "none";
  var_3 = animscripts\utility::_id_0C95();
  var_4 = var_1 == "sidearm";
  var_5 = var_1 == "secondary";

  if(var_2 && var_3 != var_4) {
    if(var_3) {
      var_6 = "none";
    } else if(var_5) {
      var_6 = "back";
    } else {
      var_6 = "chest";
    }
    animscripts\shared::_id_0C9B(self.weapon, var_6);
    self._id_1005 = self.weapon;
  } else {
    self._id_1005 = var_0;
  }
  animscripts\shared::_id_0C9B(var_0, "right");

  if(var_4) {
    self.sidearm = var_0;
  } else if(var_5) {
    self.secondaryweapon = var_0;
  } else {
    self.primaryweapon = var_0;
  }
  self.weapon = var_0;
  self._id_0CD1 = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

_id_270A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  maps\_utility_code::_id_13E1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

_id_270B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  maps\_utility_code::_id_13E1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

_id_13E2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_9 = _id_09A9();
  var_10 = spawn("script_origin", (0, 0, 0));
  var_10.origin = var_9.origin;
  var_10.angles = var_9 getplayerangles();

  if(isDefined(var_8) && var_8) {
    var_9 playerlinkto(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_4)) {
    var_9 playerlinkto(var_10, "", var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_3)) {
    var_9 playerlinkto(var_10, "", var_3);
  } else {
    var_9 playerlinkto(var_10);
  }
  var_10 moveto(var_0, var_2, var_2 * 0.25);
  var_10 rotateto(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

_id_270C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  maps\_utility_code::_id_13E3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

_id_13E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _id_09A9();
  var_10 = spawn("script_origin", (0, 0, 0));
  var_10.origin = var_9 _id_2735();
  var_10.angles = var_9 getplayerangles();

  if(isDefined(var_8)) {
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_4)) {
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_3)) {
    var_9 playerlinktodelta(var_10, "", var_3);
  } else {
    var_9 playerlinktodelta(var_10);
  }
  var_10 moveto(var_0, var_2, var_2 * 0.25);
  var_10 rotateto(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

_id_270D(var_0) {
  var_1 = level.player.origin;

  for(;;) {
    if(distance(var_1, level.player.origin) > var_0) {
      break;
    }

    wait 0.05;
  }
}

_id_270E(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread maps\_utility_code::_id_13D4(var_4, var_0, var_1);
  thread maps\_utility_code::_id_13D4(var_4, var_2, var_3);
  var_4 waittill("done");
}

_id_09CA(var_0) {
  self waittill(var_0);
}

_id_1F61(var_0, var_1, var_2, var_3) {
  var_4 = _id_09A9();

  if(isDefined(level._id_1E9E[var_0])) {
    if(var_4[[level._id_1E9E[var_0]]]()) {
      return;
    }
    var_4 thread maps\_utility_code::_id_13D8(level._id_1E9D[var_0], level._id_1E9E[var_0], var_1, var_2, var_3, 30);
  } else {
    var_4 thread maps\_utility_code::_id_13D8(level._id_1E9D[var_0], undefined, undefined, undefined, undefined, 30);
  }
}

_id_1823(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_09A9();

  if(var_5[[level._id_1E9E[var_0]]]()) {
    return;
  }
  var_5 thread maps\_utility_code::_id_13D8(level._id_1E9D[var_0], level._id_1E9E[var_0], var_2, var_3, var_4, var_1);
}

_id_270F(var_0) {
  return level._id_0C59["generic"][var_0];
}

_id_2710() {
  self._id_137B = 1;
}

_id_2711() {
  self._id_137B = 0;
  self notify("stop_being_careful");
}

_id_2712() {
  self._id_0FD7 = 1;
}

_id_2713() {
  self._id_0FD7 = undefined;
}

_id_2714() {
  self._id_0EEE = 1;
}

_id_2715() {
  self._id_0EEE = undefined;
}

_id_2716(var_0) {
  setDvar(var_0, "");
}

_id_2717(var_0) {
  return level.script == var_0;
}

_id_2718() {
  self.fixednode = 1;
}

_id_2719() {
  self.fixednode = 0;
}

_id_166F(var_0, var_1) {
  if(isDefined(self._id_271A)) {
    self endon("death");
    wait(self._id_271A);
  }

  var_2 = undefined;
  var_3 = isDefined(self._id_212E) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

  if(isDefined(self._id_212F) || isDefined(var_0)) {
    if(!isDefined(self._id_212C)) {
      var_2 = self stalingradspawn(var_3);
    } else {
      var_2 = _id_212D(self);
    }
  } else if(!isDefined(self._id_212C)) {
    var_2 = self dospawn(var_3);
  } else {
    var_2 = _id_212D(self);
  }
  if(isDefined(var_1) && var_1 && isalive(var_2)) {
    var_2 _id_0D04();
  }
  if(!isDefined(self._id_212C)) {
    _id_13AF(var_2);
  }
  if(isDefined(self._id_271B)) {
    self delete();
  }
  return var_2;
}

_id_1255(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6 thread maps\_utility_code::_id_13E7(self, var_0, var_1, var_2, var_3, var_4, var_5);
  return maps\_utility_code::_id_13E6(var_6);
}

_id_1257(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread maps\_utility_code::_id_13E7(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_7._id_13E8) || var_7 common_scripts\utility::waittill_any_timeout(var_0, "function_stack_func_begun") != "timeout") {
    return maps\_utility_code::_id_13E6(var_7);
  } else {
    var_7 notify("death");
    return 0;
  }
}

_id_271C() {
  var_0 = [];

  if(isDefined(self._id_1255[0]) && isDefined(self._id_1255[0]._id_13E8)) {
    var_0[0] = self._id_1255[0];
  }
  self._id_1255 = undefined;
  self notify("clear_function_stack");
  waittillframeend;

  if(!var_0.size) {
    return;
  }
  if(!var_0[0]._id_13E8) {
    return;
  }
  self._id_1255 = var_0;
}

_id_271D() {
  if(isDefined(self._id_271D)) {
    return;
  }
  self.realorigin = self getorigin();
  self moveto(self.realorigin + (0, 0, -10000), 0.2);
  self._id_271D = 1;
}

_id_271E() {
  if(!isDefined(self._id_271D)) {
    return;
  }
  self moveto(self.realorigin, 0.2);
  self waittill("movedone");
  self._id_271D = undefined;
}

_id_271F() {
  self._id_1199 = 1;
}

_id_2720() {
  self._id_1199 = undefined;
}

_id_2721() {
  self._id_10BF = 1;
}

_id_2722() {
  self._id_10BF = undefined;
}

_id_251F() {
  self._id_117F = 1;
}

_id_2520() {
  self endon("death");
  waittillframeend;
  self._id_117F = undefined;
}

_id_2723(var_0, var_1) {
  setblur(var_0, var_1);
}

_id_2724(var_0) {
  self.goalradius = var_0;
}

_id_2053(var_0) {
  self._id_1407 = var_0;
  self._id_2725 = undefined;
  self._id_1405 = undefined;
  self setgoalnode(var_0);
}

_id_2726(var_0) {
  var_1 = getnode(var_0, "targetname");
  _id_2053(var_1);
}

_id_1237(var_0) {
  self._id_1407 = undefined;
  self._id_2725 = var_0;
  self._id_1405 = undefined;
  self setgoalpos(var_0);
}

_id_2052(var_0) {
  _id_1237(var_0.origin);
  self._id_1405 = var_0;
}

_id_2727(var_0) {
  maps\_utility_code::_id_1450(var_0);
  objective_state(var_0, "done");
  level notify("objective_complete" + var_0);
}

_id_1417(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_1)) {
    var_4 = !var_1;
  }
  if(isDefined(var_2)) {
    level endon(var_2);
  }
  if(isDefined(var_3)) {
    level waittill(var_3);
  }
  var_5 = "signal_" + var_0;

  if(self.a._id_0D26 == "crouch") {
    var_5 = var_5 + "_crouch";
  } else if(self.script == "cover_right") {
    var_5 = var_5 + "_coverR";
  } else if(animscripts\utility::_id_0C98()) {
    var_5 = var_5 + "_cqb";
  }
  if(var_4) {
    self setanimrestart(_id_270F(var_5), 1, 0, 1.1);
  } else {
    maps\_anim::_id_11C1(self, var_5);
  }
}

_id_2728(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = _id_272B(var_1);
  return var_2[0];
}

_id_2729(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_2 = _id_272B(var_1);
  return var_2[0];
}

_id_272A(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  return _id_272B(var_1);
}

_id_272B(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  var_3 = [];

  foreach(var_5 in var_0) {
    var_5.count = 1;

    if(getsubstr(var_5.classname, 7, 10) == "veh") {
      var_6 = var_5 _id_1FA3();

      if(isDefined(var_6.target) && !isDefined(var_6._id_2005)) {
        var_6 thread maps\_vehicle::_id_1FA6();
      }
      var_3[var_3.size] = var_6;
      continue;
    }

    var_6 = var_5 _id_166F(var_1);

    if(!var_2) {}

    var_3[var_3.size] = var_6;
  }

  if(!var_2) {}

  return var_3;
}

_id_272C(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_0, "targetname");

  if(isDefined(level._id_2120)) {
    var_5 = common_scripts\utility::getStructArray(var_0, "targetname");

    if(isDefined(var_3) && var_3) {
      _id_2122(var_5);
    }
    var_6 = maps\_spawner::_id_2123(var_5);
    var_4 = common_scripts\utility::array_combine(var_4, var_6);
  }

  return _id_272B(var_4, var_1, var_2);
}

_id_272D(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_0, "script_noteworthy");

  if(isDefined(level._id_2120)) {
    var_5 = common_scripts\utility::getStructArray(var_0, "script_noteworthy");

    if(isDefined(var_3) && var_3) {
      _id_2122(var_5);
    }
    var_6 = maps\_spawner::_id_2123(var_5);
    var_4 = common_scripts\utility::array_combine(var_4, var_6);
  }

  return _id_272B(var_4, var_1, var_2);
}

_id_272E(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_3 = var_2 _id_166F(var_1);
  return var_3;
}

_id_272F(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = var_2 _id_166F(var_1);
  return var_3;
}

_id_2730(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_2731)) {
    level._id_2731 = [];
  }
  var_3 = 0;

  for(;;) {
    if(!isDefined(level._id_2731[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(isDefined(var_2)) {
    switch (var_2) {
      case "red":
      case "r":
        var_4 = "^1";
        break;
      case "green":
      case "g":
        var_4 = "^2";
        break;
      case "yellow":
      case "y":
        var_4 = "^3";
        break;
      case "blue":
      case "b":
        var_4 = "^4";
        break;
      case "cyan":
      case "c":
        var_4 = "^5";
        break;
      case "purple":
      case "p":
        var_4 = "^6";
        break;
      case "white":
      case "w":
        var_4 = "^7";
        break;
      case "black":
      case "bl":
        var_4 = "^8";
        break;
    }
  }

  level._id_2731[var_3] = 1;
  var_5 = maps\_hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait 2;
  var_6 = 40;
  var_5 fadeovertime(6);
  var_5.alpha = 0;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 4;
  var_5 destroy();
  level._id_2731[var_3] = undefined;
}

_id_2732() {
  common_scripts\_destructible::disable_explosion();
}

_id_2733() {
  common_scripts\_destructible::force_explosion();
}

_id_2734(var_0) {
  self.grenadeammo = var_0;
}

_id_2735() {
  var_0 = self.origin;
  var_1 = anglestoup(self getplayerangles());
  var_2 = self getplayerviewheight();
  var_3 = var_0 + (0, 0, var_2);
  var_4 = var_0 + var_1 * var_2;
  var_5 = var_3 - var_4;
  var_6 = var_0 + var_5;
  return var_6;
}

_id_2736(var_0) {
  self._id_20AF = var_0;
}

_id_1DE7() {
  if(!isDefined(level.console)) {
    level.console = getDvar("consoleGame") == "true";
  } else {}

  if(!isDefined(level.xenon)) {
    level.xenon = getDvar("xenonGame") == "true";
  } else {}

  if(!isDefined(level.ps3)) {
    level.ps3 = getDvar("ps3Game") == "true";
  } else {}
}

_id_1C43(var_0) {
  return maps\_autosave::_id_1C41(var_0);
}

_id_2738() {
  return maps\_autosave::_id_1C41(1);
}

_id_2739(var_0) {
  self._id_0D50 = _id_270F(var_0);
}

_id_128B(var_0) {
  self._id_0D50 = _id_1281(var_0);
}

_id_128C() {
  self._id_0D50 = undefined;
}

_id_273A(var_0) {
  wait 1.75;

  if(isDefined(var_0)) {
    self playSound(var_0);
  } else {
    self playSound("door_wood_slow_open");
  }
  self rotateto(self.angles + (0, 70, 0), 2, 0.5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

_id_273B(var_0) {
  wait 1.35;

  if(isDefined(var_0)) {
    self playSound(var_0);
  } else {
    self playSound("door_wood_slow_open");
  }
  self rotateto(self.angles + (0, 70, 0), 2, 0.5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

_id_273C(var_0, var_1) {
  foreach(var_3 in level.players) {}
  var_3 lerpfov(var_1, var_0);

  wait(var_0);
}

_id_273D(var_0, var_1) {
  var_2 = getdvarfloat("cg_fovscale");
  var_3 = int(var_0 / 0.05);
  var_4 = (var_1 - var_2) / var_3;
  var_5 = var_2;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_5 = var_5 + var_4;
    setsaveddvar("cg_fovscale", var_5);
    wait 0.05;
  }

  setsaveddvar("cg_fovscale", var_1);
}

_id_273E() {
  animscripts\shared::_id_0C9B(self.weapon, "none");
  self.weapon = "none";
}

_id_273F() {
  maps\_load::_id_1F86(0);
}

_id_2740() {
  maps\_load::_id_1F86(1);
}

_id_1414() {
  self stopanimscripted();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
}

_id_1057() {
  self.a._id_0D11 = 1;
  self.allowpain = 0;
}

_id_1071() {
  self.a._id_0D11 = 0;
  self.allowpain = 1;
}

_id_2741() {
  self delete();
}

_id_2742() {
  self kill();
}

_id_1887() {
  if(isPlayer(self)) {
    if(common_scripts\utility::flag_exist("special_op_terminated") && common_scripts\utility::flag("special_op_terminated")) {
      return 0;
    }
    if(_id_1A43(self)) {
      self disableinvulnerability();
    }
  }

  self enabledeathshield(0);
  self kill();
  return 1;
}

_id_2743(var_0) {
  self setentitytarget(var_0);
}

_id_2744() {
  self clearentitytarget();
}

_id_2745() {
  self unlink();
}

_id_2746(var_0) {
  var_1 = getarraykeys(level._id_1BF8[var_0]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level._id_1BF8[var_0][var_1[var_2]].looper delete();
    level._id_1BF8[var_0][var_1[var_2]] = undefined;
  }
}

_id_2747(var_0) {
  self setlightintensity(var_0);
}

_id_2533(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self linkto(var_0, var_1, var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    self linkto(var_0, var_1, var_2);
    return;
  }

  if(isDefined(var_1)) {
    self linkto(var_0, var_1);
    return;
  }

  self linkto(var_0);
}

_id_2748(var_0, var_1, var_2) {
  var_3 = getarraykeys(var_0);
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
  }
  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_4[var_6] = spawnStruct();
    var_4[var_6]._id_13F1 = 1;
    var_4[var_6] thread maps\_utility_code::_id_13F0(var_0[var_6], var_1, var_2);
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(isDefined(var_0[var_6]) && var_4[var_6]._id_13F1) {
      var_4[var_6] waittill("_array_wait");
    }
  }
}

_id_2749() {
  self kill((0, 0, 0));
}

_id_274A(var_0) {
  return level._id_1F90[var_0];
}

_id_167C() {
  return self playerads() > 0.5;
}

_id_274B() {
  level._id_274C = 1;

  if(level.gameskill >= 2) {
    level.player.threatbias = int(maps\_gameskill::_id_230B("threatbias", 1));
    return;
  }

  level._id_274D = getdvarint("autodifficulty_frac");
  var_0 = level._id_274D * 0.01;
  level.player.threatbias = int(maps\_gameskill::_id_2308("threatbias", var_0));
}

_id_274E() {
  level._id_274C = 0;
}

_id_219C() {
  self._id_139E = undefined;
  self notify("_disable_reinforcement");
}

_id_274F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = level.player;
  }
  var_6 = spawnStruct();

  if(isDefined(var_3)) {
    var_6 thread _id_1424("timeout", var_3);
  }
  var_6 endon("timeout");

  if(!isDefined(var_0)) {
    var_0 = 0.92;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = isai(self);
  var_10 = undefined;

  for(;;) {
    if(var_9) {
      var_10 = self getEye();
    } else {
      var_10 = self.origin;
    }
    if(var_5 _id_1FBD(var_10, var_0, var_2, var_4)) {
      var_8--;

      if(var_8 <= 0) {
        return 1;
      }
    } else {
      var_8 = var_7;
    }
    wait 0.05;
  }
}

_id_2750(var_0, var_1, var_2, var_3) {
  _id_274F(var_1, var_0, var_2, undefined, var_3);
}

_id_1FBD(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0.8;
  }
  var_4 = _id_09A9();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1) {
    return 0;
  }
  if(isDefined(var_2)) {
    return 1;
  }
  var_11 = bulletTrace(var_0, var_5, 0, var_3);
  return var_11["fraction"] == 1;
}

_id_2751(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(!level.players[var_4] _id_1FBD(var_0, var_1, var_2, var_3)) {
      return 0;
    }
  }

  return 1;
}

_id_2752(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(level.players[var_4] _id_1FBD(var_0, var_1, var_2, var_3)) {
      return 1;
    }
  }

  return 0;
}

_id_0B20(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(isDefined(var_0._id_2753) && var_0._id_2753 + var_1 >= var_2) {
    return var_0._id_2754;
  }
  var_0._id_2753 = var_2;

  if(!within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0._id_2754 = 0;
    return 0;
  }

  var_3 = level.player getEye();
  var_4 = var_0.origin;

  if(sighttracepassed(var_3, var_4, 1, level.player, var_0)) {
    var_0._id_2754 = 1;
    return 1;
  }

  var_5 = var_0 getEye();

  if(sighttracepassed(var_3, var_5, 1, level.player, var_0)) {
    var_0._id_2754 = 1;
    return 1;
  }

  var_6 = (var_5 + var_4) * 0.5;

  if(sighttracepassed(var_3, var_6, 1, level.player, var_0)) {
    var_0._id_2754 = 1;
    return 1;
  }

  var_0._id_2754 = 0;
  return 0;
}

_id_2755(var_0, var_1) {
  var_2 = var_0 * var_0;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(var_1, level.players[var_3].origin) < var_2) {
      return 1;
    }
  }

  return 0;
}

_id_2756(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = 0.75;

  if(issplitscreen()) {
    var_2 = 0.65;
  }
  while(var_0.size > 0) {
    wait 1;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_3]) || !isalive(var_0[var_3])) {
        var_0 = common_scripts\utility::array_remove(var_0, var_0[var_3]);
        continue;
      }

      if(_id_2755(var_1, var_0[var_3].origin)) {
        continue;
      }
      if(_id_2752(var_0[var_3].origin + (0, 0, 48), var_2, 1)) {
        continue;
      }
      if(isDefined(var_0[var_3]._id_0D04)) {
        var_0[var_3] _id_1902();
      }
      var_0[var_3] delete();
      var_0 = common_scripts\utility::array_remove(var_0, var_0[var_3]);
    }
  }
}

_id_09C9(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_13F5 = self;
  var_4.func = var_0;
  var_4._id_13F4 = [];

  if(isDefined(var_1)) {
    var_4._id_13F4[var_4._id_13F4.size] = var_1;
  }
  if(isDefined(var_2)) {
    var_4._id_13F4[var_4._id_13F4.size] = var_2;
  }
  if(isDefined(var_3)) {
    var_4._id_13F4[var_4._id_13F4.size] = var_3;
  }
  level._id_1E75[level._id_1E75.size] = var_4;
}

_id_2757(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_13F5 = self;
  var_4.func = var_0;
  var_4._id_13F4 = [];

  if(isDefined(var_1)) {
    var_4._id_13F4[var_4._id_13F4.size] = var_1;
  }
  if(isDefined(var_2)) {
    var_4._id_13F4[var_4._id_13F4.size] = var_2;
  }
  if(isDefined(var_3)) {
    var_4._id_13F4[var_4._id_13F4.size] = var_3;
  }
  level._id_1E7A[level._id_1E7A.size] = var_4;
}

_id_1DB1(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6._id_13F5 = self;
  var_6.func = var_0;
  var_6._id_13F4 = [];

  if(isDefined(var_1)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_1;
  }
  if(isDefined(var_2)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_2;
  }
  if(isDefined(var_3)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_3;
  }
  if(isDefined(var_4)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_4;
  }
  if(isDefined(var_5)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_5;
  }
  level._id_1E76[level._id_1E76.size] = var_6;
}

_id_2758(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6._id_13F5 = self;
  var_6.func = var_0;
  var_6._id_13F4 = [];

  if(isDefined(var_1)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_1;
  }
  if(isDefined(var_2)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_2;
  }
  if(isDefined(var_3)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_3;
  }
  if(isDefined(var_4)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_4;
  }
  if(isDefined(var_5)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_5;
  }
  level._id_1E77[level._id_1E77.size] = var_6;
}

_id_2759(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.func = var_0;
  var_6._id_13F4 = [];

  if(isDefined(var_1)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_1;
  }
  if(isDefined(var_2)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_2;
  }
  if(isDefined(var_3)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_3;
  }
  if(isDefined(var_4)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_4;
  }
  if(isDefined(var_5)) {
    var_6._id_13F4[var_6._id_13F4.size] = var_5;
  }
  level._id_1E78[level._id_1E78.size] = var_6;
}

_id_275A(var_0) {
  var_1 = spawnStruct();
  var_1._id_13F5 = self;
  var_1._id_13F8 = var_0;
  level._id_1E79[level._id_1E79.size] = var_1;
}

_id_09CB() {
  _id_275B(level._id_1E75.size - 1);
}

_id_275B(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = spawnStruct();
  var_2 = level._id_1E75;
  var_3 = level._id_1E79;
  var_4 = level._id_1E76;
  var_5 = level._id_1E77;
  var_6 = level._id_1E78;
  var_7 = level._id_1E7A;
  level._id_1E75 = [];
  level._id_1E76 = [];
  level._id_1E79 = [];
  level._id_1E7A = [];
  level._id_1E77 = [];
  level._id_1E78 = [];
  var_1.count = var_2.size;
  var_1 common_scripts\utility::array_levelthread(var_2, maps\_utility_code::_id_13F9, var_3);
  var_1 thread maps\_utility_code::_id_13FC(var_7);
  var_1 endon("any_funcs_aborted");

  for(;;) {
    if(var_1.count <= var_0) {
      break;
    }

    var_1 waittill("func_ended");
  }

  var_1 notify("all_funcs_ended");
  common_scripts\utility::array_levelthread(var_4, maps\_utility_code::_id_13F7, []);
  common_scripts\utility::array_levelthread(var_5, maps\_utility_code::_id_13F3);
  common_scripts\utility::array_levelthread(var_6, maps\_utility_code::_id_13F6);
}

_id_1DB2() {
  var_0 = spawnStruct();
  var_1 = level._id_1E76;
  level._id_1E76 = [];

  foreach(var_3 in var_1) {}
  level maps\_utility_code::_id_13F7(var_3, []);

  var_0 notify("all_funcs_ended");
}

_id_1451() {
  if(isDefined(level._id_275C) && level._id_275C == 1) {
    return 0;
  }
  if(isDefined(level._id_1F1A) && level._id_1F1A == level._id_1F19) {
    return 1;
  }
  if(isDefined(level._id_1F1B)) {
    return level._id_1F19 == "default";
  }
  if(_id_1F1C()) {
    return level._id_1F19 == level._id_1F18[0]["name"];
  }
  return level._id_1F19 == "default";
}

_id_275D() {
  level._id_275C = 1;
}

_id_275E() {
  if(!_id_1F1C()) {
    return 1;
  }
  return level._id_1F19 == level._id_1F18[0]["name"];
}

_id_275F(var_0) {
  var_1 = 0;

  if(level._id_1F19 == var_0) {
    return 0;
  }
  for(var_2 = 0; var_2 < level._id_1F18.size; var_2++) {
    if(level._id_1F18[var_2]["name"] == var_0) {
      var_1 = 1;
      continue;
    }

    if(level._id_1F18[var_2]["name"] == level._id_1F19) {
      return var_1;
    }
  }
}

_id_2760(var_0, var_1, var_2, var_3) {
  earthquake(var_0, var_1, var_2, var_3);
}

_id_2761(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = 1;
  }
  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = bulletTrace(var_3, var_4, 0, undefined);

    if(var_5["surfacetype"] != "water") {
      continue;
    }
    var_6 = "water_movement";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        var_6 = "water_stop";
      }
    } else if(isDefined(level._effect["water_" + self.a._id_0D2B])) {
      var_6 = "water_" + self.a._id_0D2B;
    }
    var_7 = common_scripts\utility::getfx(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = anglestoup(var_8);
    playFX(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2) {
      thread common_scripts\utility::play_sound_in_space(var_1, var_3);
    }
  }
}

_id_2762(var_0) {
  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(randomfloatrange(0.25, 0.5));
    var_1 = self.origin + (0, 0, 0);
    var_2 = self.origin - (0, 0, 5);
    var_3 = bulletTrace(var_1, var_2, 0, undefined);
    var_4 = anglesToForward(self.angles);
    var_5 = distance(self getvelocity(), (0, 0, 0));

    if(isDefined(self.vehicle)) {
      continue;
    }
    if(var_3["surfacetype"] != "snow") {
      continue;
    }
    if(var_5 <= 10) {
      continue;
    }
    var_6 = "snow_movement";

    if(distance(self getvelocity(), (0, 0, 0)) <= 154) {
      playFX(common_scripts\utility::getfx("footstep_snow_small"), var_3["position"], var_3["normal"], var_4);
    }
    if(distance(self getvelocity(), (0, 0, 0)) > 154) {
      playFX(common_scripts\utility::getfx("footstep_snow"), var_3["position"], var_3["normal"], var_4);
    }
  }
}

_id_2763(var_0) {
  var_1 = 60;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", (var_1 - var_2) / var_1);
    wait 0.05;
  }
}

_id_2764(var_0) {
  var_1 = 60;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", var_2 / var_1);
    wait 0.05;
  }
}

_id_2765(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }
  for(;;) {
    self.origin = var_0.origin + var_1;
    self.angles = var_0.angles;
    wait 0.05;
  }
}

_id_195A() {
  maps\_utility_code::_id_1453();
  maps\_endmission::_id_1956();
}

_id_2766(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[var_5.size] = var_0;

  if(isDefined(var_1)) {
    var_5[var_5.size] = var_1;
  }
  if(isDefined(var_2)) {
    var_5[var_5.size] = var_2;
  }
  if(isDefined(var_3)) {
    var_5[var_5.size] = var_3;
  }
  if(isDefined(var_4)) {
    var_5[var_5.size] = var_4;
  }
  return var_5;
}

_id_2767() {
  level._id_1FE9 = 1;
}

_id_2768() {
  level._id_1FE9 = 0;
}

_id_2769() {
  var_0 = self getweaponslistall();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1[var_3] = self getweaponammoclip(var_3);
  }

  var_4 = 0;

  if(isDefined(var_1["claymore"]) && var_1["claymore"] > 0) {
    var_4 = var_1["claymore"];
  }
  return var_4;
}

_id_276A() {
  var_0 = self getweaponslistall();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1[var_3] = self getweaponammoclip(var_3);
  }

  var_4 = 0;

  if(isDefined(var_1["c4"]) && var_1["c4"] > 0) {
    var_4 = var_1["c4"];
  }
  return var_4;
}

_id_09E7(var_0) {
  wait(var_0);
}

_id_276B(var_0, var_1) {
  self waittillmatch(var_0, var_1);
}

_id_276C(var_0, var_1) {
  setsaveddvar(var_0, var_1);
}

_id_276D(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  for(var_7 = var_4 / var_6; var_6; var_6--) {
    var_3 = var_3 + var_7;
    setsaveddvar(var_0, var_3);
    wait(var_5);
  }

  setsaveddvar(var_0, var_1);
}

_id_195D(var_0) {
  if(_id_1957()) {
    return;
  }
  if(level.script == "ending" && isDefined(level._id_1959) && level._id_1959 == "free") {
    return;
  }
  foreach(var_2 in level.players) {}
  var_2 giveachievement(var_0);
}

_id_1E39(var_0) {
  if(_id_1957()) {
    return;
  }
  if(level.script == "ending" && isDefined(level._id_1959) && level._id_1959 == "free") {
    return;
  }
  self giveachievement(var_0);
}

_id_276E(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setcontents(0);
  var_1 setModel("weapon_javelin_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  _id_09C9(::_id_2770);

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    _id_09C9(common_scripts\utility::flag_wait, var_0);
  }

  _id_09CB();
  var_1 delete();
}

_id_276F(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setcontents(0);
  var_1 setModel("weapon_c4_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  _id_09C9(::_id_2770);

  if(isDefined(var_0)) {
    common_scripts\utility::flag_assert(var_0);
    _id_09C9(common_scripts\utility::flag_wait, var_0);
  }

  _id_09CB();
  var_1 delete();
}

_id_2770() {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    wait 0.05;
  }
}

_id_2771() {}

_id_0A18() {}

_id_2772(var_0) {
  level._id_1A2F._id_1A30 = var_0;
}

_id_2773(var_0) {
  level._id_1A2F._id_1FD9 = var_0;
}

_id_2774(var_0) {
  level._id_1A2F._id_1FD7 = var_0;
}

_id_0A16(var_0) {
  level._id_1A2F._id_1FD8 = var_0;
}

_id_2775() {
  if(isDefined(level._id_019F) && level._id_019F) {
    return;
  }
  setslowmotion(level._id_1A2F._id_1FD9, level._id_1A2F._id_1A30, level._id_1A2F._id_1FD7);
}

_id_0A17() {
  if(isDefined(level._id_019F) && level._id_019F) {
    return;
  }
  setslowmotion(level._id_1A2F._id_1A30, level._id_1A2F._id_1FD9, level._id_1A2F._id_1FD8);
}

_id_2776(var_0, var_1, var_2, var_3) {
  level.earthquake[var_0]["magnitude"] = var_1;
  level.earthquake[var_0]["duration"] = var_2;
  level.earthquake[var_0]["radius"] = var_3;
}

_id_1E05(var_0, var_1, var_2) {
  if(getDvar("arcademode") != "1") {
    return;
  }
  thread maps\_arcademode::_id_09FE(var_0, 1, var_1, var_2);
}

_id_2777(var_0, var_1, var_2) {
  if(getDvar("arcademode") != "1") {
    return;
  }
  thread maps\_arcademode::_id_09FE(var_0, 0, var_1, var_2);
}

_id_2778(var_0, var_1) {
  if(1) {
    return;
  }
  if(getDvar("arcademode") != "1") {
    return;
  }
  var_2 = maps\_arcademode::_id_0A26(var_1);

  if(!isDefined(var_2)) {
    var_2 = level._id_09AD.size;
    level._id_09AD[level._id_09AD.size] = var_1;
  }

  if(getDvar("arcademode_checkpoint_" + var_2) == "1") {
    return;
  }
  setDvar("arcademode_checkpoint_" + var_2, "1");

  if(getDvar("arcademode_full") == "1") {
    if(level.gameskill == 2) {
      var_0 = var_0 * 2.0;
    }
    if(level.gameskill == 3) {
      var_0 = var_0 * 2.5;
    }
  }

  var_3 = getdvarint("arcademode_time");
  var_4 = getdvarint("arcademode_stored_time");
  var_4 = var_4 + var_3;
  setDvar("arcademode_stored_time", var_4);
  setDvar("arcademode_time", var_0 * 60);
  var_5 = 800;
  var_6 = 0.8;
  level.player thread common_scripts\utility::play_sound_in_space("arcademode_checkpoint", level.player getEye());
  thread maps\_arcademode::_id_0A25(var_5, var_6, 1);
  thread maps\_arcademode::_id_0A25(var_5, var_6, -1);
}

_id_09D4() {
  return getDvar("arcademode") == "1";
}

_id_2779() {
  if(!isDefined(level._id_09CF)) {
    return;
  }
  level notify("arcadeMode_remove_timer");
  level._id_0A19 = gettime();
  level._id_09CF destroy();
  level._id_09CF = undefined;
}

_id_142B(var_0, var_1, var_2) {
  level._id_09E8 = var_0;

  if(!_id_09D4() || !common_scripts\utility::flag("arcadeMode_multiplier_maxed")) {
    if(!isDefined(var_1)) {
      var_1 = 1;
    }
    if(!isDefined(var_2)) {
      var_2 = 0;
    }
    musicstop(0);
    musicplay(var_0, 0, 1.0, 1, var_2);
  }
}

_id_142D(var_0, var_1, var_2, var_3, var_4) {
  thread maps\_utility_code::_id_142A(var_0, var_1, var_2, var_3, var_4);
}

_id_277A(var_0, var_1, var_2, var_3, var_4) {
  thread maps\_utility_code::_id_142A(var_0, var_1, var_2, var_3, var_4, 1);
}

_id_1428(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 > 0) {
    thread maps\_utility_code::_id_1426(var_0, var_1, var_2, var_3);
    return;
  }

  _id_1427();
  _id_142B(var_0, var_2, var_3);
}

_id_1427(var_0) {
  if(!isDefined(var_0) || var_0 <= 0) {
    musicstop();
  } else {
    musicstop(var_0);
  }
  level notify("stop_music");
}

_id_1C57() {
  var_0 = getEntArray("grenade", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.model == "weapon_claymore") {
      continue;
    }
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(distancesquared(var_2.origin, var_4.origin) < 75625) {
        return 1;
      }
    }
  }

  return 0;
}

_id_2398() {
  return getdvarint("player_died_recently", "0") > 0;
}

_id_277B(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 istouching(var_0)) {
      return 0;
    }
  }

  return 1;
}

_id_277C(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_277D(var_0, var_1) {
  if(var_1.size == 1) {
    return var_1[0];
  }
  var_2 = undefined;
  var_3 = undefined;
  var_4 = getEntArray("trigger_multiple", "classname");

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(isDefined(var_4[var_5]._id_1692) && var_4[var_5]._id_1692 == var_0) {
      var_2 = var_4[var_5];
      break;
    }
  }

  var_3 = _id_0AE9(var_2.origin, var_1);
  return var_3;
}

_id_229D() {
  if(level.gameskill < 1) {
    return "easy";
  }
  if(level.gameskill < 2) {
    return "medium";
  }
  if(level.gameskill < 3) {
    return "hard";
  }
  return "fu";
}

_id_277E(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(var_0 == 1) {
      level.players[var_1] hide();
      continue;
    }

    level.players[var_1] show();
  }
}

_id_1C67(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  thread maps\_loadout::_id_1C9A(var_0);
}

_id_277F() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_0 = var_0 + var_4.origin[0];
    var_1 = var_1 + var_4.origin[1];
    var_2 = var_2 + var_4.origin[2];
  }

  var_0 = var_0 / level.players.size;
  var_1 = var_1 / level.players.size;
  var_2 = var_2 / level.players.size;
  return (var_0, var_1, var_2);
}

_id_2780(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0) {}
  var_1 = var_1 + var_3.origin;

  return var_1 * (1.0 / var_0.size);
}

_id_2781() {
  self._id_215B = [];

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    foreach(var_8 in self._id_215B) {}
    thread[[var_8]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

_id_12E2(var_0) {
  self._id_215B[self._id_215B.size] = var_0;
}

_id_1A2A(var_0) {
  var_1 = [];

  foreach(var_3 in self._id_215B) {
    if(var_3 == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self._id_215B = var_1;
}

_id_12BE(var_0, var_1) {
  maps\_rank::_id_12E4(var_0, var_1);
}

_id_2782(var_0) {
  self playlocalsound(var_0);
}

_id_2783(var_0) {
  if(level.players.size < 1) {
    return;
  }
  foreach(var_2 in level.players) {
    if(var_0 == 1) {
      var_2 enableweapons();
      continue;
    }

    var_2 disableweapons();
  }
}

_id_2784(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "player1") {
      var_1 = var_5;
      continue;
    }

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "player2") {
      var_2 = var_5;
      continue;
    }

    if(!isDefined(var_1)) {
      var_1 = var_5;
    }
    if(!isDefined(var_2)) {
      var_2 = var_5;
    }
  }

  foreach(var_8 in level.players) {
    if(var_8 == level.player) {
      var_3 = var_1;
    } else if(var_8 == level._id_1337) {
      var_3 = var_2;
    }
    var_8 setorigin(var_3.origin);
    var_8 setplayerangles(var_3.angles);
  }
}

_id_1FDF(var_0) {
  level.player setorigin(var_0.origin);

  if(isDefined(var_0.angles)) {
    level.player setplayerangles(var_0.angles);
  }
}

_id_2785() {
  if(!_id_12C1()) {
    return;
  }
  self._id_1B7C = 1;
  thread maps\_loadout::_id_1C9A(undefined);
}

_id_2786() {
  if(!_id_12C1()) {
    return;
  }
  self._id_1B7C = 0;
  thread maps\_loadout::_id_1C9A(self._id_1C9B);
}

_id_18B9() {
  var_0 = [];

  if(isDefined(self._id_2787)) {
    var_0 = self._id_2787;
  }
  if(isDefined(self.entity)) {
    var_0[var_0.size] = self.entity;
  }
  common_scripts\utility::array_levelthread(var_0, maps\_utility_code::_id_13FD);
}

_id_2788(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_opening_fov");
  wait(var_0);
  level.player playerlinktodelta(var_1, var_2, 1, var_3, var_4, var_5, var_6, 1);
}

_id_2789(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }
  if(!isDefined(var_1)) {
    var_1 = "all";
  }
  var_3 = getaispeciesarray(var_0, var_1);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6 istouching(self)) {
      var_4[var_4.size] = var_6;
    }
  }

  return var_4;
}

_id_278A(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "all";
  }
  var_1 = [];

  if(var_0 == "all") {
    var_1 = _id_1843(level._id_1FFB["allies"]._id_0C6D, level._id_1FFB["axis"]._id_0C6D);
    var_1 = _id_1843(var_1, level._id_1FFB["neutral"]._id_0C6D);
  } else {
    var_1 = level._id_1FFB[var_0]._id_0C6D;
  }
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 istouching(self)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_278B(var_0) {
  var_1 = _id_1843(level._id_1FFB["allies"]._id_0C6D, level._id_1FFB["axis"]._id_0C6D);
  var_1 = _id_1843(var_1, level._id_1FFB["neutral"]._id_0C6D);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.targetname) && var_4.targetname == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_133A(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2) {
      continue;
    }
    return var_2;
  }
}

_id_278C(var_0) {
  var_1 = _id_133A(var_0);
  return _id_1A43(var_1);
}

_id_213D(var_0) {
  self.count = var_0;
}

_id_278D(var_0, var_1, var_2) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_3 = undefined;

  if(!isDefined(var_0.classname)) {
    if(!isDefined(var_0.type)) {
      var_3 = "struct";
    } else {
      var_3 = "node";
    }
  } else {
    var_3 = "entity";
  }
  if(!isDefined(var_1)) {
    var_1 = 300;
  }
  var_4 = self._id_1382;
  self._id_1382 = 1;
  maps\_spawner::_id_21A4(var_0, var_3, var_2, var_1);
  self._id_1382 = var_4;
}

_id_278E(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_0 = 250;
  }
  if(!isDefined(var_1)) {
    var_1 = 100;
  }
  if(!isDefined(var_2)) {
    var_2 = var_0 * 2;
  }
  if(!isDefined(var_3)) {
    var_3 = var_0 * 1.25;
  }
  if(!isDefined(var_5)) {
    var_5 = 0;
  }
  self._id_1408 = var_5;
  thread maps\_utility_code::_id_1401(var_0, var_1, var_2, var_3, var_4);
}

_id_278F() {
  self notify("stop_dynamic_run_speed");
}

_id_2790() {
  self endon("death");
  self endon("stop_player_seek");
  var_0 = 1200;

  if(_id_2169()) {
    var_0 = 250;
  }
  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait 2;
    self.goalradius = var_1;
    var_2 = _id_2608(self.origin);
    self setgoalentity(var_2);
    var_1 = var_1 - 175;

    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

_id_2791() {
  self notify("stop_player_seek");
}

_id_2792(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_2)) {
    var_2 = 5;
  }
  var_3 = gettime() + var_2 * 1000;

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) <= var_1) {
      break;
    }

    if(gettime() > var_3) {
      break;
    }

    wait 0.1;
  }
}

_id_2793(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) <= var_1) {
      break;
    }

    wait 0.1;
  }
}

_id_2794(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) > var_1) {
      break;
    }

    wait 0.1;
  }
}

_id_2169() {
  self endon("death");

  if(!isDefined(self.weapon)) {
    return 0;
  }
  if(self.weapon == "winchester1200" || self.weapon == "m1014" || self.weapon == "striker" || self.weapon == "ranger" || self.weapon == "aa12") {
    return 1;
  } else {
    return 0;
  }
}

isprimaryweapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }
  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }
  switch (weaponclass(var_0)) {
    case "rifle":
    case "sniper":
    case "smg":
    case "spread":
    case "rocketlauncher":
    case "pistol":
    case "mg":
      return 1;
    default:
      return 0;
  }
}

_id_2795() {
  var_0 = self getweaponslistall();

  if(!isDefined(var_0)) {
    return 0;
  }
  foreach(var_2 in var_0) {
    if(issubstr(var_2, "thermal")) {
      return 1;
    }
  }

  return 0;
}

_id_2796(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = self.goalradius;
  }
  for(;;) {
    self waittill("goal");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

_id_2797(var_0, var_1) {
  var_2 = int(getDvar("g_speed"));

  if(!isDefined(level.player._id_2798)) {
    level.player._id_2798 = var_2;
  }
  var_3 = int(level.player._id_2798 * var_0 * 0.01);
  level.player _id_279A(var_3, var_1);
}

_id_2799(var_0, var_1) {
  var_2 = self;

  if(!isPlayer(var_2)) {
    var_2 = level.player;
  }
  if(!isDefined(var_2._id_141D)) {
    var_2._id_141D = 1.0;
  }
  var_3 = var_0 * 0.01;
  var_2 _id_279B(var_3, var_1);
}

_id_279A(var_0, var_1) {
  var_2 = int(getDvar("g_speed"));

  if(!isDefined(level.player._id_2798)) {
    level.player._id_2798 = var_2;
  }
  var_3 = maps\_utility_code::_id_141A;
  var_4 = maps\_utility_code::_id_141B;
  level.player thread _id_279C(var_0, var_1, var_3, var_4, "player_speed_set");
}

_id_279B(var_0, var_1) {
  var_2 = self;

  if(!isPlayer(var_2)) {
    var_2 = level.player;
  }
  if(!isDefined(var_2._id_141D)) {
    var_2._id_141D = 1.0;
  }
  var_3 = maps\_utility_code::_id_141C;
  var_4 = maps\_utility_code::_id_141E;
  var_2 thread _id_279C(var_0, var_1, var_3, var_4, "blend_movespeedscale");
}

_id_279C(var_0, var_1, var_2, var_3, var_4) {
  self notify(var_4);
  self endon(var_4);
  var_5 = [[var_2]]();
  var_6 = var_0;

  if(isDefined(var_1)) {
    var_7 = var_6 - var_5;
    var_8 = 0.05;
    var_9 = var_1 / var_8;
    var_10 = var_7 / var_9;

    while(abs(var_6 - var_5) > abs(var_10 * 1.1)) {
      var_5 = var_5 + var_10;
      [[var_3]](var_5);
      wait(var_8);
    }
  }

  [[var_3]](var_6);
}

_id_279D(var_0) {
  if(!isDefined(level.player._id_2798)) {
    return;
  }
  level.player _id_279A(level.player._id_2798, var_0);
  waittillframeend;
  level.player._id_2798 = undefined;
}

_id_279E(var_0) {
  var_1 = self;

  if(!isPlayer(var_1)) {
    var_1 = level.player;
  }
  if(!isDefined(var_1._id_141D)) {
    return;
  }
  var_1 _id_279B(1.0, var_0);
  waittillframeend;
  var_1._id_141D = undefined;
}

_id_2281(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1500;
  }
  if(!isDefined(var_2)) {
    var_2 = -12000;
  }
  return physicstrace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2));
}

_id_279F(var_0) {
  if(isPlayer(self)) {
    self setorigin(var_0.origin);
    self setplayerangles(var_0.angles);
  } else {
    self forceteleport(var_0.origin, var_0.angles);
  }
}

_id_27A0(var_0, var_1) {
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  self dontinterpolate();

  if(isPlayer(self)) {
    self setorigin(var_2);
    self setplayerangles(var_3);
  } else if(isai(self)) {
    self forceteleport(var_2, var_3);
  } else {
    self.origin = var_2;
    self.angles = var_3;
  }
}

_id_27A1(var_0) {
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalpos(self.origin);
  self setgoalnode(var_0);
}

_id_27A2(var_0) {
  foreach(var_2 in level.createfxent) {}
  var_2.v["origin"] = var_2.v["origin"] + var_0;
}

_id_1EC2() {
  return isDefined(self._id_27A3);
}

_id_1EC5(var_0, var_1, var_2) {
  var_3 = self;
  var_3 thread play_sound_on_entity("foot_slide_plr_start");
  var_3 thread _id_258E("foot_slide_plr_loop");
  var_4 = isDefined(level._id_27A4);

  if(!isDefined(var_0)) {
    var_0 = var_3 getvelocity() + (0, 0, -10);
  }
  if(!isDefined(var_1)) {
    var_1 = 10;
  }
  if(!isDefined(var_2)) {
    var_2 = 0.035;
  }
  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3._id_27A3 = var_5;
  var_5 moveslide((0, 0, 15), 15, var_0);

  if(var_4) {
    var_3 playerlinktoblend(var_5, undefined, 1);
  } else {
    var_3 playerlinkto(var_5);
  }
  var_3 disableweapons();
  var_3 allowprone(0);
  var_3 allowcrouch(1);
  var_3 allowstand(0);
  var_3 thread maps\_utility_code::_id_142F(var_5, var_1, var_2);
}

_id_1EC7() {
  var_0 = self;
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread play_sound_on_entity("foot_slide_plr_end");
  var_0 unlink();
  var_0 setvelocity(var_0._id_27A3.slidevelocity);
  var_0._id_27A3 delete();
  var_0 enableweapons();
  var_0 allowprone(1);
  var_0 allowcrouch(1);
  var_0 allowstand(1);
  var_0 notify("stop_sliding");
}

_id_1FA3() {
  return maps\_vehicle::_id_211F(self);
}

_id_27A5(var_0) {
  var_1 = maps\_load::_id_1EA1();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_7 = maps\_load::_id_1EA4();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_9, "targetname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_10 = undefined;

  foreach(var_12 in var_2) {
    if(var_12._id_1692 == var_0) {
      return var_12;
    }
  }
}

_id_27A6(var_0) {
  var_1 = maps\_load::_id_1EA1();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_7 = maps\_load::_id_1EA4();

  foreach(var_9, var_4 in var_7) {
    if(!issubstr(var_9, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_9, "targetname");
    var_2 = common_scripts\utility::array_combine(var_2, var_5);
  }

  var_10 = [];

  foreach(var_12 in var_2) {
    if(var_12._id_1692 == var_0) {
      var_10[var_10.size] = var_12;
    }
  }

  return var_10;
}

_id_27A7(var_0, var_1) {
  return (var_0[0], var_0[1], var_1);
}

_id_27A8(var_0, var_1) {
  return (var_0[0], var_1, var_0[2]);
}

_id_27A9(var_0, var_1) {
  return (var_1, var_0[1], var_0[2]);
}

_id_27AA() {
  var_0 = self getcurrentweapon();

  if(!isDefined(var_0)) {
    return 0;
  }
  if(issubstr(tolower(var_0), "rpg")) {
    return 1;
  }
  if(issubstr(tolower(var_0), "stinger")) {
    return 1;
  }
  if(issubstr(tolower(var_0), "at4")) {
    return 1;
  }
  if(issubstr(tolower(var_0), "javelin")) {
    return 1;
  }
  return 0;
}

_id_0D69() {
  return isDefined(self.a._id_0D69);
}

_id_27AB(var_0) {
  if(_id_12C1()) {}

  var_1 = _id_09A9();

  if(!isDefined(var_0)) {
    var_0 = "steady_rumble";
  }
  var_2 = spawn("script_origin", var_1 getEye());
  var_2.intensity = 1;
  var_2 thread maps\_utility_code::_id_1431(var_1, var_0);
  return var_2;
}

_id_27AC(var_0) {
  self.intensity = var_0;
}

_id_27AD(var_0) {
  thread _id_27AF(1, var_0);
}

_id_27AE(var_0) {
  thread _id_27AF(0, var_0);
}

_id_27AF(var_0, var_1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_2 = var_1 * 20;
  var_3 = var_0 - self.intensity;
  var_4 = var_3 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.intensity = self.intensity + var_4;
    wait 0.05;
  }

  self.intensity = var_0;
}

_id_09A9() {
  if(isDefined(self)) {
    if(!is_in_array(level.players, self)) {
      return level.player;
    } else {
      return self;
    }
  } else {
    return level.player;
  }
}

_id_198F() {
  return int(self getplayersetting("gameskill"));
}

_id_27B0(var_0) {
  if(isDefined(self._id_27B1)) {
    return;
  }
  self._id_27B1 = self.model;

  if(!isDefined(var_0)) {
    var_0 = self.model + "_obj";
  }
  self setModel(var_0);
}

_id_27B2(var_0) {
  if(!isDefined(self._id_27B1)) {
    return;
  }
  self setModel(self._id_27B1);
  self._id_27B1 = undefined;
}

_id_27B3(var_0, var_1, var_2) {
  var_3 = [];
  var_1 = var_2 - var_1;

  foreach(var_5 in var_0) {
    var_3[var_3.size] = var_5;

    if(var_3.size == var_2) {
      var_3 = _id_0B53(var_3);

      for(var_6 = var_1; var_6 < var_3.size; var_6++) {
        var_3[var_6] delete();
      }
      var_3 = [];
    }
  }

  var_8 = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_8[var_8.size] = var_5;
  }

  return var_8;
}

_id_27B4(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }
  self endon("death");

  while(isDefined(self)) {
    if(distance(var_0, self.origin) <= var_1) {
      break;
    }

    wait(var_2);
  }
}

_id_27B5(var_0) {
  var_1 = spawnStruct();
  var_1 thread maps\_utility_code::_id_143C(var_0);
  return var_1;
}

_id_27B6(var_0, var_1, var_2) {
  var_3 = self gettagorigin(var_1);
  var_4 = self gettagangles(var_1);
  _id_27B7(var_0, var_3, var_4, var_2);
}

_id_27B7(var_0, var_1, var_2, var_3) {
  var_4 = anglesToForward(var_2);
  var_5 = bulletTrace(var_1, var_1 + var_4 * var_3, 0, undefined);

  if(var_5["fraction"] >= 1) {
    return;
  }
  var_6 = var_5["surfacetype"];

  if(!isDefined(level._id_143D[var_0][var_6])) {
    var_6 = "default";
  }
  var_7 = level._id_143D[var_0][var_6];

  if(isDefined(var_7["fx"])) {
    playFX(var_7["fx"], var_5["position"], var_5["normal"]);
  }
  if(isDefined(var_7["fx_array"])) {
    foreach(var_9 in var_7["fx_array"]) {}
    playFX(var_9, var_5["position"], var_5["normal"]);
  }

  if(isDefined(var_7["sound"])) {
    level thread common_scripts\utility::play_sound_in_space(var_7["sound"], var_5["position"]);
  }
  if(isDefined(var_7["rumble"])) {
    var_11 = _id_09A9();
    var_11 playrumbleonentity(var_7["rumble"]);
  }
}

_id_0EEC() {
  self.newenemyreactiondistsq = 0;
}

_id_27B8() {
  self.newenemyreactiondistsq = squared(512);
}

_id_2131(var_0) {
  self._id_0C96 = 1;
  self._id_1151 = 1;
  self.usecombatscriptatcover = 1;

  if(!isDefined(var_0) || !var_0) {
    self._id_0FF1 = 1;
    self.maxfaceenemydist = 64;
    self.pathenemylookahead = 2048;
    _id_0EEC();
  }

  self._id_1146 = animscripts\animset::_id_0CA7;
  self._id_0C88["run"] = anim._id_0C65._id_0C66["heat_run"];
}

_id_27B9() {
  self._id_0C96 = undefined;
  self._id_1151 = undefined;
  self._id_0FF1 = undefined;
  self.usecombatscriptatcover = 0;
  self.maxfaceenemydist = 512;
  self._id_1146 = undefined;
  self._id_0C88 = undefined;
}

_id_27BA() {
  return vehicle_getarray();
}

_id_27BB(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  var_3 = 0.5;
  level endon("clearing_hints");

  if(isDefined(level._id_27BC)) {
    level._id_27BC maps\_hud_util::destroyelem();
  }
  level._id_27BC = maps\_hud_util::createfontstring("default", 1.5);
  level._id_27BC maps\_hud_util::setpoint("MIDDLE", undefined, 0, 30 + var_2);
  level._id_27BC.color = (1, 1, 1);
  level._id_27BC settext(var_0);
  level._id_27BC.alpha = 0;
  level._id_27BC fadeovertime(0.5);
  level._id_27BC.alpha = 1;
  wait 0.5;
  level._id_27BC endon("death");

  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    return;
  }
  level._id_27BC fadeovertime(var_3);
  level._id_27BC.alpha = 0;
  wait(var_3);
  level._id_27BC maps\_hud_util::destroyelem();
}

_id_27BD() {
  var_0 = 1;

  if(isDefined(level._id_27BC)) {
    level notify("clearing_hints");
    level._id_27BC fadeovertime(var_0);
    level._id_27BC.alpha = 0;
    wait(var_0);
  }
}

_id_27BE(var_0, var_1) {
  if(!isDefined(level.flag[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  foreach(var_3 in level._id_2103[var_0]) {
    foreach(var_5 in var_3) {
      if(isalive(var_5)) {
        var_5 thread maps\_utility_code::_id_1430(var_1);
        continue;
      }

      var_5 delete();
    }
  }
}

_id_27BF(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = "player_view_controller";
  }
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }
  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawnturret("misc_turret", var_4, var_3);
  var_5.angles = var_0 gettagangles(var_1);
  var_5 setModel("tag_turret");
  var_5 linkto(var_0, var_1, var_2, (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 setmode("manual");
  return var_5;
}

_id_27C0(var_0, var_1, var_2) {
  var_3 = level _id_27C1(maps\_utility_code::_id_1435, var_0, var_1);
  var_3.time = var_2;
}

_id_27C1(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 childthread maps\_utility_code::_id_1437(var_0, self, var_1, var_2, var_3);
  return var_4;
}

_id_27C2(var_0) {
  if(!isDefined(self._id_27C3)) {
    self._id_27C3 = [];
  }
  var_1 = [];
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    var_1[var_4] = [];
    var_1[var_4]["clip_left"] = self getweaponammoclip(var_4, "left");
    var_1[var_4]["clip_right"] = self getweaponammoclip(var_4, "right");
    var_1[var_4]["stock"] = self getweaponammostock(var_4);
  }

  if(!isDefined(var_0)) {
    var_0 = "default";
  }
  self._id_27C3[var_0] = [];
  self._id_27C3[var_0]["current_weapon"] = self getcurrentweapon();
  self._id_27C3[var_0]["inventory"] = var_1;
}

_id_27C4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }
  if(!isDefined(self._id_27C3) || !isDefined(self._id_27C3[var_0])) {
    return;
  }
  self takeallweapons();

  foreach(var_3, var_2 in self._id_27C3[var_0]["inventory"]) {
    if(weaponinventorytype(var_3) != "altmode") {
      self giveweapon(var_3);
    }
    self setweaponammoclip(var_3, var_2["clip_left"], "left");
    self setweaponammoclip(var_3, var_2["clip_right"], "right");
    self setweaponammostock(var_3, var_2["stock"]);
  }

  var_4 = self._id_27C3[var_0]["current_weapon"];

  if(var_4 != "none") {
    self switchtoweapon(var_4);
  }
}

_id_27C5() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self hide();
      break;
    case "script_brushmodel":
      self hide();
      self notsolid();

      if(self.spawnflags & 1) {
        self connectpaths();
      }
      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use_touch":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_radius":
      common_scripts\utility::trigger_off();
      break;
    default:
  }
}

_id_27C6() {
  switch (self.code_classname) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self show();
      break;
    case "script_brushmodel":
      self show();
      self solid();

      if(self.spawnflags & 1) {
        self disconnectpaths();
      }
      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use_touch":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_radius":
      common_scripts\utility::trigger_on();
      break;
    default:
  }
}

_id_27C7(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self rotateyaw(var_0, var_1, var_2, var_3);
  } else if(isDefined(var_2)) {
    self rotateyaw(var_0, var_1, var_2);
  } else {
    self rotateyaw(var_0, var_1);
  }
}

_id_27C8(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(var_1)) {
    var_2 = var_0 - self._id_0FC6;
    var_3 = 0.05;
    var_4 = var_1 / var_3;
    var_5 = var_2 / var_4;

    while(abs(var_0 - self._id_0FC6) > abs(var_5 * 1.1)) {
      self._id_0FC6 = self._id_0FC6 + var_5;
      wait(var_3);
    }
  }

  self._id_0FC6 = var_0;
}

_id_27C9(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0) {}
  var_7 thread add_spawn_function(var_1, var_2, var_3, var_4, var_5);
}

_id_27CA(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray(var_0, "targetname");
  _id_27C9(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_27CB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray(var_0, "script_noteworthy");
  _id_27C9(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_27CC() {
  self._id_0F9F = 1;
}

_id_27CD() {
  self._id_0F9F = undefined;
}

create_vision_set_fog(var_0) {
  if(!isDefined(level._id_1AE4)) {
    level._id_1AE4 = [];
  }
  var_1 = spawnStruct();
  var_1.name = var_0;
  level._id_1AE4[var_0] = var_1;
  return var_1;
}

_id_1FC2(var_0) {
  if(!isDefined(level._id_1AE4)) {
    level._id_1AE4 = [];
  }
  var_1 = level._id_1AE4[var_0];
  return var_1;
}

_id_27CE(var_0) {
  if(!isDefined(level._id_27CF)) {
    level._id_27CF = [];
  }
  var_1 = spawnStruct();
  var_1.name = var_0;
  level._id_27CF[var_0] = var_1;
  return var_1;
}

_id_1F73(var_0) {
  if(!isDefined(level._id_27CF)) {
    level._id_27CF = [];
  }
  var_1 = level._id_27CF[var_0];
  return var_1;
}

_id_27D0() {
  if(!isDefined(self._id_1B3F)) {
    self._id_1B3F = spawnStruct();
    self._id_1B3F._id_1B40 = "";
    self._id_1B3F.time = 0;
  }
}

_id_27D1(var_0, var_1) {
  if(!isPlayer(self)) {
    maps\_art::_id_1B3E();
  } else {
    _id_27D0();
  }
  if(!isDefined(level._id_27CF)) {
    level._id_27CF = [];
  }
  var_2 = level._id_27CF[var_0];

  if(!isDefined(var_2)) {
    var_2 = level._id_1AE4[var_0];
  }
  if(!isDefined(var_1)) {
    var_1 = var_2.transitiontime;
  }
  if(getdvarint("scr_art_tweak") != 0) {
    _id_27D2(var_2);
    var_1 = 0;
  }

  if(!isPlayer(self)) {
    if(level._id_1B3F._id_1B40 == var_0 && level._id_1B3F.time == var_1) {
      return;
    }
    _id_1AF7(var_2, var_1);
    level._id_1B3F._id_1B40 = var_0;
    level._id_1B3F.time = var_1;
  } else {
    if(self._id_1B3F._id_1B40 == var_0 && self._id_1B3F.time == var_1) {
      return;
    }
    _id_1AF7(var_2, var_1);
    self._id_1B3F._id_1B40 = var_0;
    self._id_1B3F.time = var_1;
  }
}

_id_27D2(var_0) {}

_id_1AF7(var_0, var_1) {
  if(isDefined(var_0.sunfogenabled) && var_0.sunfogenabled) {
    if(!isPlayer(self)) {
      setexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.maxopacity, var_1, var_0._id_1AF0, var_0._id_1AF1, var_0._id_1AF2, var_0._id_1AF3, var_0._id_1AF4, var_0._id_1AF5, var_0._id_1AF6);
    } else {
      self playersetexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.maxopacity, var_1, var_0._id_1AF0, var_0._id_1AF1, var_0._id_1AF2, var_0._id_1AF3, var_0._id_1AF4, var_0._id_1AF5, var_0._id_1AF6);
    }
  } else if(!isPlayer(self)) {
    setexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.maxopacity, var_1);
  } else {
    self playersetexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.maxopacity, var_1);
  }
}

vision_set_fog_changes(var_0, var_1) {
  var_2 = _id_27D3(var_0, var_1);

  if(var_2 && isDefined(_id_1FC2(var_0))) {
    _id_27D1(var_0, var_1);
  }
}

_id_1FCC() {
  if(!isDefined(self._id_1AE2)) {
    self._id_1AE2 = spawnStruct();
    self._id_1AE2._id_1AE3 = "";
    self._id_1AE2.time = 0;
  }
}

_id_27D3(var_0, var_1) {
  if(!isPlayer(self)) {
    var_2 = 1;

    if(!isDefined(level._id_1AE2)) {
      level._id_1AE2 = spawnStruct();
      level._id_1AE2._id_1AE3 = "";
      level._id_1AE2.time = 0;
      var_2 = 0;
    }

    if(level._id_1AE2._id_1AE3 == var_0 && level._id_1AE2.time == var_1) {
      return 0;
    }
    level._id_1AE2._id_1AE3 = var_0;
    level._id_1AE2.time = var_1;

    if(var_2 && getdvarint("scr_art_tweak") != 0) {} else {
      visionsetnaked(var_0, var_1);
    }
    level._id_13EE = var_0;
    setDvar("vision_set_current", var_0);
  } else {
    _id_1FCC();

    if(self._id_1AE2._id_1AE3 == var_0 && self._id_1AE2.time == var_1) {
      return 0;
    }
    self._id_1AE2._id_1AE3 = var_0;
    self._id_1AE2.time = var_1;
    self visionsetnakedforplayer(var_0, var_1);
  }

  return 1;
}

_id_27D4() {}

_id_27D5() {
  thread _id_27D6();
}

_id_27D6() {
  self endon("death");

  for(;;) {
    self._id_108B = 1;
    wait 0.05;
  }
}

_id_27D7() {
  self._id_108B = undefined;
}

_id_27D8(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    radiusdamage(var_0, var_1, var_2, var_3);
  } else {
    radiusdamage(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_27D9(var_0) {
  var_1 = getEntArray("interactive_tv", "targetname");

  foreach(var_3 in var_0) {}
  var_3._id_1444 = [];

  foreach(var_6 in var_1) {
    foreach(var_3 in var_0) {
      if(!var_3 istouching(var_6)) {
        continue;
      }
      var_3 maps\_utility_code::_id_1442(var_6);
      break;
    }
  }
}

_id_27DA() {
  if(!isDefined(self._id_1444)) {
    return;
  }
  foreach(var_1 in self._id_1444) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel(var_1._id_1443);
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2.script_noteworthy = var_1.script_noteworthy;
    var_2.target = var_1.target;
    var_2.targetname = var_1.targetname;
    var_2 thread maps\_interactive_objects::_id_1DEC();
  }

  self._id_1444 = [];
}

_id_27DB(var_0) {
  var_1 = getEntArray("destructible_toy", "targetname");
  var_2 = getEntArray("destructible_vehicle", "targetname");
  var_3 = common_scripts\utility::array_combine(var_1, var_2);

  foreach(var_5 in var_0) {}
  var_5.destructibles = [];

  foreach(var_8 in var_3) {
    foreach(var_5 in var_0) {
      if(!var_5 istouching(var_8)) {
        continue;
      }
      var_5 maps\_utility_code::_id_1445(var_8);
      break;
    }
  }
}

_id_27DC(var_0) {
  if(getDvar("createfx") != "") {
    return;
  }
  var_1 = getEntArray("script_brushmodel", "classname");
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_1[var_1.size] = var_2[var_3];
  }
  foreach(var_5 in var_0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.script_prefab_exploder)) {
        var_7.script_exploder = var_7.script_prefab_exploder;
      }
      if(!isDefined(var_7.script_exploder)) {
        continue;
      }
      if(!isDefined(var_7.model)) {
        continue;
      }
      if(var_7.code_classname != "script_model") {
        continue;
      }
      if(!var_7 istouching(var_5)) {
        continue;
      }
      var_7._id_1EDF = 1;
    }
  }
}

_id_27DD() {
  var_0 = spawn("script_origin", (0, 0, 0));

  foreach(var_2 in level.createfxent) {
    if(!isDefined(var_2.v["masked_exploder"])) {
      continue;
    }
    var_0.origin = var_2.v["origin"];
    var_0.angles = var_2.v["angles"];

    if(!var_0 istouching(self)) {
      continue;
    }
    var_3 = var_2.v["masked_exploder"];
    var_4 = var_2.v["masked_exploder_spawnflags"];
    var_5 = var_2.v["masked_exploder_script_disconnectpaths"];
    var_6 = spawn("script_model", (0, 0, 0), var_4);
    var_6 setModel(var_3);
    var_6.origin = var_2.v["origin"];
    var_6.angles = var_2.v["angles"];
    var_2.v["masked_exploder"] = undefined;
    var_2.v["masked_exploder_spawnflags"] = undefined;
    var_2.v["masked_exploder_script_disconnectpaths"] = undefined;
    var_6.disconnect_paths = var_5;
    var_6.script_exploder = var_2.v["exploder"];
    maps\_load::_id_1ED8(var_6);
    var_2.model = var_6;
  }

  var_0 delete();
}

_id_1446(var_0) {
  var_1 = common_scripts\_destructible_types::getinfoindex(var_0);

  if(var_1 != -1) {
    return;
  }
  var_2 = spawnStruct();
  var_2.destructibleinfo = common_scripts\_destructible_types::maketype(var_0);
  var_2 thread common_scripts\_destructible::precache_destructibles();
  var_2 thread common_scripts\_destructible::add_destructible_fx();
}

_id_27DE(var_0, var_1) {
  foreach(var_3 in var_0) {}
  var_3.destructibles = [];

  var_5 = ["destructible_toy", "destructible_vehicle"];
  var_6 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  foreach(var_8 in var_5) {
    var_9 = getEntArray(var_8, "targetname");

    foreach(var_11 in var_9) {
      foreach(var_3 in var_0) {
        if(var_1) {
          var_6++;
          var_6 = var_6 % 5;

          if(var_6 == 1) {
            wait 0.05;
          }
        }

        if(!var_3 istouching(var_11)) {
          continue;
        }
        var_11 delete();
        break;
      }
    }
  }
}

_id_27DF(var_0, var_1) {
  var_2 = getEntArray("interactive_tv", "targetname");

  foreach(var_4 in var_0) {}
  var_4._id_1444 = [];

  var_6 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  foreach(var_8 in var_2) {
    foreach(var_4 in var_0) {
      if(var_1) {
        var_6++;
        var_6 = var_6 % 5;

        if(var_6 == 1) {
          wait 0.05;
        }
      }

      if(!var_4 istouching(var_8)) {
        continue;
      }
      var_8 delete();
      break;
    }
  }
}

_id_27E0(var_0, var_1) {
  var_2 = getEntArray("script_brushmodel", "classname");
  var_3 = getEntArray("script_model", "classname");

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_2[var_2.size] = var_3[var_4];
  }
  var_5 = [];
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  foreach(var_9 in var_0) {
    foreach(var_11 in var_2) {
      if(!isDefined(var_11.script_exploder)) {
        continue;
      }
      var_6.origin = var_11 getorigin();

      if(!var_9 istouching(var_6)) {
        continue;
      }
      var_5[var_5.size] = var_11;
    }
  }

  _id_135B(var_5);
  var_6 delete();
}

_id_27E1() {
  if(!isDefined(self.destructibles)) {
    return;
  }
  foreach(var_1 in self.destructibles) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel(var_1._id_1443);
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2.script_noteworthy = var_1.script_noteworthy;
    var_2.targetname = var_1.targetname;
    var_2.target = var_1.target;
    var_2.script_linkto = var_1.script_linkto;
    var_2.destructible_type = var_1.destructible_type;
    var_2.script_noflip = var_1.script_noflip;
    var_2 common_scripts\_destructible::setup_destructibles(1);
  }

  self.destructibles = [];
}

_id_1058(var_0) {
  self._id_0D68 = var_0;
}

_id_2094() {
  var_0 = self.flashendtime - gettime();

  if(var_0 < 0) {
    return 0;
  }
  return var_0 * 0.001;
}

_id_27E2() {
  return _id_2094() > 0;
}

_id_23BB(var_0) {
  if(isDefined(self._id_0D68) && self._id_0D68) {
    return;
  }
  var_1 = gettime() + var_0 * 1000.0;

  if(isDefined(self.flashendtime)) {
    self.flashendtime = max(self.flashendtime, var_1);
  } else {
    self.flashendtime = var_1;
  }
  self notify("flashed");
  self setflashbanged(1);
}

_id_27E3() {
  for(;;) {
    var_0 = getaispeciesarray("axis", "all");
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(!isalive(var_3)) {
        continue;
      }
      if(var_3 istouching(self)) {
        var_1 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_1) {
      var_5 = _id_2789("axis");

      if(!var_5.size) {
        break;
      }
    }

    wait 0.05;
  }
}

_id_27E4() {
  var_0 = 0;

  for(;;) {
    var_1 = getaispeciesarray("axis", "all");
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isalive(var_4)) {
        continue;
      }
      if(var_4 istouching(self)) {
        if(var_4 _id_0D69()) {
          continue;
        }
        var_2 = 1;
        var_0 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_2) {
      var_6 = _id_2789("axis");

      if(!var_6.size) {
        break;
      } else {
        var_0 = 1;
      }
    }

    wait 0.05;
  }

  return var_0;
}

_id_27E5(var_0) {
  _id_27E3();
  common_scripts\utility::flag_set(var_0);
}

_id_27E6(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2 _id_27E5(var_1);
}

_id_27E7() {
  level.player _id_13DE("player_zero_attacker_accuracy");
  level.player.ignorerandombulletdamage = 0;
  level.player maps\_gameskill::_id_22FF();
}

_id_27E8() {
  level.player _id_13DC("player_zero_attacker_accuracy");
  level.player.attackeraccuracy = 0;
  level.player.ignorerandombulletdamage = 1;
}

_id_27E9(var_0) {
  var_1 = _id_09A9();
  var_1._id_20F2._id_22FC = var_0;
  var_1 maps\_gameskill::_id_22FF();
}

_id_27EA(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {}
  var_1[var_3._id_164F] = var_3;

  return var_1;
}

_id_27EB(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {}
  var_1[var_3.classname] = var_3;

  return var_1;
}

_id_27EC(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3._id_16A5;

    if(isDefined(var_4)) {
      var_1[var_4] = var_3;
    }
  }

  return var_1;
}

_id_27ED(var_0) {
  if(isDefined(var_0)) {
    self._id_1DC9 = var_0;
  } else {
    self._id_1DC9 = getent(self.target, "targetname");
  }
  self linkto(self._id_1DC9);
}

_id_27EE() {
  var_0 = maps\_utility_code::_id_1447();
  var_1 = var_0["team"];

  foreach(var_3 in var_0["codes"]) {
    var_4 = level._id_133F[var_1][var_3];

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return undefined;
}

_id_27EF() {
  var_0 = maps\_utility_code::_id_1447();
  var_1 = var_0["team"];

  foreach(var_3 in var_0["codes"]) {
    var_4 = level._id_133E[var_1][var_3];

    if(isDefined(var_4)) {
      return var_4;
    }
  }

  return undefined;
}

_id_27F0() {
  self.flashendtime = undefined;
  self setflashbanged(0);
}

_id_27F1(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2;
  }
  return common_scripts\utility::getstruct(var_0, var_1);
}

grenade_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  _id_2326(var_0);
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

_id_2326(var_0) {
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.3, 0.5, var_0, 400);

  foreach(var_2 in level.players) {
    if(distance(var_0, var_2.origin) > 600) {
      continue;
    }
    if(var_2 damageconetrace(var_0)) {
      var_2 thread dirteffect(var_0);
    }
  }
}

_id_27F3(var_0, var_1, var_2, var_3) {
  return _id_27F4("shotgun", level.player, var_0, var_1, var_2, var_3);
}

_id_27F4(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1)) {
    var_1 = level.player;
  }
  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 disableweapons();
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6 linkto(self, "tag_passenger", _id_27F7(var_0), (0, 0, 0));
  var_6._id_27F5 = common_scripts\utility::spawn_tag_origin();
  var_6._id_27F5 linkto(self, "tag_body", _id_27F8(var_0), (0, 0, 0));

  if(!isDefined(var_2)) {
    var_2 = 90;
  }
  if(!isDefined(var_3)) {
    var_3 = 90;
  }
  if(!isDefined(var_4)) {
    var_4 = 40;
  }
  if(!isDefined(var_5)) {
    var_5 = 40;
  }
  var_1 disableweapons();
  var_1 playerlinkto(var_6, "tag_origin", 0.8, var_2, var_3, var_4, var_5);
  var_1._id_27F6 = var_6;
  return var_6;
}

_id_27F7(var_0) {
  switch (var_0) {
    case "shotgun":
      return (-5, 10, -34);
    case "backleft":
      return (-45, 45, -34);
    case "backright":
      return (-45, 5, -34);
  }
}

_id_27F8(var_0) {
  switch (var_0) {
    case "shotgun":
      return (-8, -90, -12.6);
    case "backleft":
      return (-58, 85, -12.6);
    case "backright":
      return (-58, -95, -12.6);
  }
}

_id_27F9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  var_1 = self;
  var_2 = level.player;

  if(isPlayer(self)) {
    var_2 = self;
    var_1 = var_2._id_27F6;
  }

  var_1 unlink();

  if(!var_0) {
    var_3 = 0.6;
    var_1 moveto(var_1._id_27F5.origin, var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }

  var_2 unlink();
  var_2 enableweapons();
  var_2 allowcrouch(1);
  var_2 allowprone(1);
  var_2._id_27F6 = undefined;
  var_1._id_27F5 delete();
  var_1 delete();
}

dirteffect(var_0, var_1) {
  var_2 = _id_27FB(var_0);

  foreach(var_5, var_4 in var_2) {}
  thread maps\_gameskill::_id_2322(var_5);
}

_id_2327(var_0) {
  if(!isDefined(self._id_232A)) {
    return;
  }
  var_1 = _id_27FB(self._id_232A.origin);

  foreach(var_4, var_3 in var_1) {}
  thread maps\_gameskill::_id_2323(var_4);
}

_id_27FB(var_0) {
  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];
  var_7 = self getcurrentweapon();

  if(var_4 > 0 && var_4 > 0.5 && weapontype(var_7) != "riotshield") {
    var_6["bottom"] = 1;
  }
  if(abs(var_4) < 0.866) {
    if(var_5 > 0) {
      var_6["right"] = 1;
    } else {
      var_6["left"] = 1;
    }
  }

  return var_6;
}

_id_27FC(var_0) {
  if(!isDefined(self._id_27FD)) {
    self._id_27FD = self.pathrandompercent;
  }
  self.pathrandompercent = var_0;
}

_id_27FE() {
  if(isDefined(self._id_27FD)) {
    return;
  }
  self._id_27FD = self.pathrandompercent;
  self.pathrandompercent = 0;
}

_id_27FF() {
  self.pathrandompercent = self._id_27FD;
  self._id_27FD = undefined;
}

_id_2800() {
  if(isDefined(self._id_2801)) {
    return;
  }
  self._id_2802 = self.walkdist;
  self._id_2801 = self.walkdistfacingmotion;
  self.walkdist = 0;
  self.walkdistfacingmotion = 0;
}

_id_2803() {
  self.walkdist = self._id_2802;
  self.walkdistfacingmotion = self._id_2801;
  self._id_2802 = undefined;
  self._id_2801 = undefined;
}

_id_2804() {
  thread _id_2805();
}

_id_2805() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self.ignorerandombulletdamage = 1;
  self._id_2806 = self.health;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isPlayer(var_1) && issentient(var_1)) {
      if(isDefined(var_1.enemy) && var_1.enemy != self) {
        continue;
      }
    }

    self._id_2806 = self._id_2806 - var_0;

    if(self._id_2806 <= 0) {
      break;
    }
  }

  self kill();
}

_id_2807() {
  if(!isDefined(self._id_2808)) {
    self._id_2808 = self setcontents(0);
  }
  self hide();
}

_id_2809() {
  if(!isai(self)) {
    self solid();
  }
  if(isDefined(self._id_2808)) {
    self setcontents(self._id_2808);
  }
  self show();
}

_id_280A(var_0) {
  self.veh_brake = var_0;
}

_id_280B() {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self.ignorerandombulletdamage)) {
    return;
  }
  self notify("disable_ignorerandombulletdamage_drone");
  self.ignorerandombulletdamage = undefined;
  self.health = self._id_2806;
}

_id_280C(var_0) {
  var_1 = spawnStruct();
  var_1 delaythread(var_0, ::_id_1DAA, "timeout");
  return var_1;
}

delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread maps\_utility_code::delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_2178(var_0) {
  var_0 = var_0 * 1000;
  self.dodangerreact = 1;
  self.dangerreactduration = var_0;
  self._id_0FD9 = undefined;
}

_id_280D() {
  self.dodangerreact = 0;
  self._id_0FD9 = 1;
}

_id_280E(var_0, var_1) {
  level._id_20EE = var_0;
  level._id_20EF = var_1;
}

_id_280F(var_0) {
  level._id_20E9[var_0] = gettime();
}

_id_17DC(var_0) {
  level._id_22E5 = var_0;
  thread maps\_gameskill::_id_1A66();
}

_id_2810() {
  level._id_22E5 = undefined;
  thread maps\_gameskill::_id_1A66();
}

_id_2811(var_0, var_1, var_2) {
  maps\_animatedmodels::_id_1E41();

  if(isDefined(var_2)) {
    level._id_1E42._id_1E45 = var_2;
  }
  level._id_1E42._id_1E43 = var_1;
  level._id_1E42.weight = var_0;
  level notify("windchange", "strong");
}

_id_2812(var_0) {
  if(var_0.size > 1) {
    return 0;
  }
  var_1 = [];
  var_1["0"] = 1;
  var_1["1"] = 1;
  var_1["2"] = 1;
  var_1["3"] = 1;
  var_1["4"] = 1;
  var_1["5"] = 1;
  var_1["6"] = 1;
  var_1["7"] = 1;
  var_1["8"] = 1;
  var_1["9"] = 1;

  if(isDefined(var_1[var_0])) {
    return 1;
  }
  return 0;
}

_id_0B8E(var_0, var_1) {
  level._id_0AAF[var_0] = var_1;
  maps\_utility_code::_id_144A();
}

_id_2813(var_0) {
  for(var_1 = 0; var_1 < 8; var_1++) {
    objective_additionalposition(var_0, var_1, (0, 0, 0));
  }
}

_id_2814(var_0) {
  var_1 = [];
  var_1["minutes"] = 0;

  for(var_1["seconds"] = int(var_0 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60) {
    var_1["minutes"]++;
  }
  if(var_1["seconds"] < 10) {
    var_1["seconds"] = "0" + var_1["seconds"];
  }
  return var_1;
}

_id_2815(var_0) {
  var_1 = level.player getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_2816(var_0) {
  if(!isDefined(level._id_2817)) {
    level._id_2817 = [];
  }
  if(!isDefined(level._id_2817[var_0])) {
    level._id_2817[var_0] = level._id_2817.size + 1;
  }
  return level._id_2817[var_0];
}

_id_2818(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  var_2 = _id_142C(var_0);
  level notify("stop_music");
  level endon("stop_music");

  for(;;) {
    _id_142B(var_0);
    wait(var_2);
    wait(var_1);
  }
}

_id_2819(var_0) {
  self mountvehicle(var_0);
  self._id_0EEA = var_0;
}

_id_281A() {
  self dismountvehicle();
  self._id_0EEA = undefined;
}

_id_281B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - var_2;
  var_6 = var_3 - var_1;
  var_7 = var_5 / var_6;
  var_0 = var_0 - var_3;
  var_0 = var_7 * var_0;
  var_0 = var_0 + var_4;
  return var_0;
}

_id_2591() {
  self._id_225F = 1;
}

_id_2599() {
  self._id_225F = undefined;
}

_id_20FB(var_0) {
  var_0 _id_2591();
}

_id_20FC(var_0) {
  var_0 _id_2599();
}

_id_142C(var_0) {
  var_1 = tablelookup("sound/soundlength.csv", 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "") {
    return -1;
  }
  var_1 = int(var_1);
  var_1 = var_1 * 0.001;
  return var_1;
}

_id_281C(var_0) {
  var_1 = getkeybinding(var_0);
  return var_1["count"];
}

_id_281D(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

_id_1E25() {
  switch (level.script) {
    case "bog_b":
    case "invasion":
    case "contingency":
    case "so_civilrescue":
    case "so_killspree_trainer":
    case "so_takeover_oilrig":
    case "so_assault_oilrig":
    case "so_defense_invasion":
    case "so_killspree_invasion":
    case "so_chopper_invasion":
    case "so_ac130_co_hunted":
    case "co_hunted":
    case "so_showers_gulag":
    case "so_hidden_so_ghillies":
    case "so_ghillies":
    case "so_killspree_favela":
    case "so_juggernauts_favela":
    case "so_takeover_estate":
    case "so_defuse_favela_escape":
    case "so_forest_contingency":
    case "so_rooftop_contingency":
    case "so_snowrace2_cliffhanger":
    case "so_snowrace1_cliffhanger":
    case "so_sabotage_cliffhanger":
    case "so_demo_so_bridge":
    case "so_crossing_so_bridge":
    case "so_bridge":
    case "so_intel_boneyard":
    case "so_download_arcadia":
    case "so_escape_airport":
    case "iw4_credits":
    case "dc_whitehouse":
    case "dcemp":
    case "af_caves":
    case "arcadia":
    case "roadkill":
    case "af_chase":
    case "favela_escape":
    case "trainer":
    case "gulag":
    case "favela":
    case "airport":
    case "estate":
    case "dcburning":
    case "cliffhanger":
    case "boneyard":
    case "oilrig":
    case "ending":
      return 1;
    default:
      return 0;
  }
}

define_loadout(var_0) {
  level._id_1C64 = var_0;
}

template_level(var_0) {
  define_loadout(var_0);
  _id_2821(var_0);
  level.template_script = var_0;
}

_id_2820(var_0) {
  level._id_1E91 = var_0;
}

_id_2821(var_0) {
  level._id_1DB9 = var_0;
}

_id_2822(var_0, var_1) {
  thread _id_2823(var_0, var_1);
}

_id_2823(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_2 notify("new_volume_command");
  var_2 endon("new_volume_command");
  wait 0.05;
  _id_2824(var_2, var_1);
}

_id_2824(var_0, var_1) {
  var_0._id_2825 = 1;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(var_1) {
    _id_0401(var_0.fx, common_scripts\utility::pauseeffect);
  } else {
    common_scripts\utility::array_thread(var_0.fx, common_scripts\utility::pauseeffect);
  }
}

_id_0401(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(var_2)) {
    var_2 = 5;
  }
  var_4 = [];

  foreach(var_6 in var_0) {
    var_4[var_4.size] = var_6;
    var_3++;
    var_3 = var_3 % var_2;

    if(var_2 == 0) {
      common_scripts\utility::array_thread(var_4, var_1);
      wait 0.05;
      var_4 = [];
    }
  }
}

_id_2826(var_0) {
  thread _id_2827(var_0);
}

_id_2827(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 notify("new_volume_command");
  var_1 endon("new_volume_command");
  wait 0.05;

  if(!isDefined(var_1._id_2825)) {
    return;
  }
  var_1._id_2825 = undefined;
  _id_2828(var_1);
}

_id_2828(var_0) {
  common_scripts\utility::array_thread(var_0.fx, ::_id_1655);
}

_id_2829(var_0) {
  if(!isDefined(level._id_282A)) {
    level._id_282A = [];
  }
  if(!isDefined(level._id_282A[var_0])) {
    level._id_282A[var_0] = 1;
  } else {
    level._id_282A[var_0]++;
  }
}

_id_282B(var_0) {
  level._id_282A[var_0]--;
  level._id_282A[var_0] = int(max(0, level._id_282A[var_0]));

  if(level._id_282A[var_0]) {
    return;
  }
  common_scripts\utility::flag_set(var_0);
}

_id_282C(var_0, var_1) {
  level._id_282A[var_0] = var_1;
}

_id_282D(var_0, var_1) {
  if(!isDefined(level._id_282E)) {
    level._id_282E = [];
  }
  if(!isDefined(level._id_282E[var_1])) {
    level._id_282E[var_1] = [];
  }
  level._id_282E[var_1][level._id_282E[var_1].size] = var_0;
}

_id_282E(var_0) {
  var_1 = level._id_282E[var_0];
  var_1 = common_scripts\utility::array_removeundefined(var_1);
  _id_135B(var_1);
  level._id_282E[var_0] = undefined;
}

_id_282F(var_0) {
  if(!isDefined(level._id_282E)) {
    return;
  }
  if(!isDefined(level._id_282E[var_0])) {
    return;
  }
  var_1 = level._id_282E[var_0];
  var_1 = common_scripts\utility::array_removeundefined(var_1);

  foreach(var_3 in var_1) {
    if(!isai(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    if(!isDefined(var_3._id_0D04)) {
      continue;
    }
    if(!var_3._id_0D04) {
      continue;
    }
    var_3 _id_1902();
  }

  _id_135B(var_1);
  level._id_282E[var_0] = undefined;
}

_id_2830(var_0) {
  if(!isDefined(self._id_144F)) {
    thread maps\_utility_code::_id_144E();
  }
  self._id_144F[self._id_144F.size] = var_0;
}

_id_2831() {
  var_0 = [];
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.classname)) {
      continue;
    }
    if(issubstr(var_3.classname, "weapon_")) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

_id_2832(var_0) {
  level._id_11BB[var_0] = var_0;
}

_id_2833(var_0, var_1, var_2) {
  self notify("newmove");
  self endon("newmove");

  if(!isDefined(var_2)) {
    var_2 = 200;
  }
  var_3 = distance(self.origin, var_0);
  var_4 = var_3 / var_2;
  var_5 = vectornormalize(var_0 - self.origin);
  self moveto(var_0, var_4, 0, 0);
  self rotateto(var_1, var_4, 0, 0);
  wait(var_4);

  if(!isDefined(self)) {
    return;
  }
  self.velocity = var_5 * (var_3 / var_4);
}

_id_2834(var_0) {
  level endon(var_0);
  self waittill("death");
  common_scripts\utility::flag_set(var_0);
}

_id_17E5() {
  level._id_2835 = 1;
}

_id_2836() {
  level._id_2835 = 0;
}

_id_1A2C() {
  return isDefined(level._id_2835) && level._id_2835;
}

_id_2837() {
  maps\_damagefeedback::_id_1A28();
}

_id_2838() {
  maps\_damagefeedback::_id_1A29();
}

_id_1957() {
  if(getDvar("e3demo") == "1") {
    return 1;
  }
  return 0;
}

_id_2839(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getStructArray(var_0, var_1);
  _id_2122(var_3, var_2);
}

_id_283A(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.script_linkname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_linkname"]) && isDefined(level.struct_class_names["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_linkname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["script_linkname"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["script_linkname"][var_1].size == 0) {
      level.struct_class_names["script_linkname"][var_1] = undefined;
    }
  }

  var_1 = var_0.script_noteworthy;

  if(isDefined(var_1) && isDefined(level.struct_class_names["script_noteworthy"]) && isDefined(level.struct_class_names["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["script_noteworthy"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["script_noteworthy"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["script_noteworthy"][var_1].size == 0) {
      level.struct_class_names["script_noteworthy"][var_1] = undefined;
    }
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level.struct_class_names["target"]) && isDefined(level.struct_class_names["target"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["target"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["target"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["target"][var_1].size == 0) {
      level.struct_class_names["target"][var_1] = undefined;
    }
  }

  var_1 = var_0.targetname;

  if(isDefined(var_1) && isDefined(level.struct_class_names["targetname"]) && isDefined(level.struct_class_names["targetname"][var_1])) {
    foreach(var_4, var_3 in level.struct_class_names["targetname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level.struct_class_names["targetname"][var_1][var_4] = undefined;
      }
    }

    if(level.struct_class_names["targetname"][var_1].size == 0) {
      level.struct_class_names["targetname"][var_1] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    foreach(var_4, var_3 in level.struct) {
      if(var_0 == var_3) {
        level.struct[var_4] = undefined;
      }
    }
  }
}

_id_2122(var_0, var_1) {
  if(!isDefined(var_0) || !isarray(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 0);
  var_1 = common_scripts\utility::ter_op(var_1 > 0, var_1, 0);

  if(var_1 > 0) {
    foreach(var_3 in var_0) {
      _id_283A(var_3);
      wait(var_1);
    }
  } else {
    foreach(var_3 in var_0) {}
    _id_283A(var_3);
  }
}

_id_283B(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, var_1);
  _id_283A(var_2);
  return var_2;
}

_id_1BF9(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getStructArray(var_0, var_1);
  _id_2122(var_3, var_2);
  return var_3;
}

_id_283C(var_0, var_1) {
  var_2 = _id_27F1(var_0, var_1);

  if(!isDefined(var_2)) {
    var_2 = getnode(var_0, var_1);
  }
  if(!isDefined(var_2)) {
    var_2 = getvehiclenode(var_0, var_1);
  }
  return var_2;
}

_id_283D(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {
    self.entityheadiconoffset = var_3;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }
  if(isDefined(var_4)) {
    self._id_283F = var_4;
  }
  self notify("new_head_icon");
  var_5 = newhudelem();
  var_5.archived = 1;
  var_5.alpha = 0.8;
  var_5 setshader(var_0, var_1, var_2);
  var_5 setwaypoint(0, 0, 0, 1);
  self.entityheadicon = var_5;
  _id_2843();
  thread _id_2842();
  thread _id_2844();
}

_id_2841() {
  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}

_id_2842() {
  self endon("new_head_icon");
  self endon("death");
  var_0 = self.origin;

  for(;;) {
    if(var_0 != self.origin) {
      _id_2843();
      var_0 = self.origin;
    }

    wait 0.05;
  }
}

_id_2843() {
  if(isDefined(self._id_283F)) {
    var_0 = self[[self._id_283F]]();

    if(isDefined(var_0)) {
      self.entityheadicon.x = self.entityheadiconoffset[0] + var_0[0];
      self.entityheadicon.y = self.entityheadiconoffset[1] + var_0[1];
      self.entityheadicon.z = self.entityheadiconoffset[2] + var_0[2];
      return;
    }
  }

  self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
  self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
  self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

_id_2844() {
  self endon("new_head_icon");
  self waittill("death");

  if(!isDefined(self.entityheadicon)) {
    return;
  }
  self.entityheadicon destroy();
}