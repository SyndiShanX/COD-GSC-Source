/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_crib.gsc
**************************************/

init() {
  _precacheshellshock("frag_grenade_mp");
  _id_78AB();
  _id_78AF();
  _id_A4AB();
  _id_72B0();
}

_id_78AB() {
  _id_669D("main", "player_view1_start", "player_view1_end");
  var_0 = _id_669C("main", "Primary Weapon", "radial_weapons_primary", ::_id_0880);
  var_1 = _id_669C("main", "Secondary Weapon", "radial_weapons_secondary", ::_id_0881);
  var_2 = _id_669C("main", "Gears", "radial_gears", ::_id_0876);
  var_3 = _id_669C("main", "Kill Streaks", "radial_killstreaks", ::_id_0877);
  var_4 = _id_669C("main", "Leaderboards", "radial_leaderboards", ::_id_0878);
  _id_669D("gears", "player_view2_start", "player_view2_end");
  _id_669D("weapons_primary", "player_view3_start", "player_view3_end");
  _id_669D("weapons_secondary", "player_view3_start", "player_view3_end");
  _id_669D("killstreak", "player_view4_start", "player_view4_end");
  _id_669D("leaderboards", "player_view5_start", "player_view5_end");
}

_id_78AF() {
  foreach(var_1 in level._id_78AC) {
    _id_8F1B(var_1);

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      if(isDefined(var_1[var_2 + 1])) {
        var_3 = _id_4586(var_1[var_2]._id_7585, var_1[var_2 + 1]._id_7585);
        var_1[var_2]._id_366E = var_3;
        var_1[var_2 + 1]._id_9188 = var_3;
        continue;
      }

      var_3 = _id_4586(var_1[var_2]._id_7585, var_1[0]._id_7585) + 180;

      if(var_3 > 360) {
        var_3 = var_3 - 360;
      }

      var_1[var_2]._id_366E = var_3;
      var_1[0]._id_9188 = var_3;
    }
  }

  thread _id_A162();
  thread _id_A940();
  thread _id_A8EE();
  thread _id_2B49();
}

_id_2B49() {
  level endon("game_ended");
  level._id_2856 = 1;

  for(;;) {
    if(!isDefined(level._id_6999)) {
      waitframe();
      continue;
    }

    var_0 = 1;

    while(!level._id_6999 buttonPressed("BUTTON_Y")) {
      waitframe();
    }

    level._id_6999 playSound("mouse_click");

    if(var_0) {
      level._id_2856 = level._id_2856 * -1;
      var_0 = 0;
    }

    while(level._id_6999 buttonPressed("BUTTON_Y")) {
      waitframe();
    }
  }
}

_id_72B0() {
  level thread onplayerconnect();
  level thread _id_7E29();
}

_id_7E29() {
  level waittill("game_ended");
  setDvar("2562", 1);
}

onplayerconnect() {
  level waittill("connected", var_0);
  var_0 thread _id_7ABE();
  var_0 waittill("spawned_player");
  wait 1;
  var_0 takeallweapons();
  setDvar("2562", 0);

  if(!isDefined(var_0)) {
    return;
  } else {
    level._id_6999 = var_0;
  }

  var_0 thread _id_4304();
  _id_ACC8("main");
}

_id_7ABE() {
  self endon("disconnect");
  var_0 = "autoassign";

  while(!isDefined(self.pers["team"])) {
    waitframe();
  }

  self notify("menuresponse", game["menu_team"], var_0);
  wait 0.5;
  var_1 = getarraykeys(level.classmap);
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!issubstr(var_1[var_3], "custom")) {
      var_2[var_2.size] = var_1[var_3];
    }
  }

  for(;;) {
    var_4 = var_2[0];
    self notify("menuresponse", "changeclass", var_4);
    self waittill("spawned_player");
    wait 0.1;
  }
}

_id_4304() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    var_0 = self getnormalizedmovement();
    var_1 = vectortoangles(var_0);
    level._id_7F3D = int(var_1[1]);
    waitframe();
  }
}

_id_669D(var_0, var_1, var_2) {
  if(isDefined(level._id_78AC) && level._id_78AC.size) {}

  var_3 = _getEnt(var_2, "targetname");
  var_4 = vectorNormalize(anglesToForward(var_3.angles)) * 40;
  level._id_78AC[var_0] = [];
  level._id_78AD[var_0]["view_start"] = var_1;
  level._id_78AD[var_0]["view_pos"] = var_3.origin + var_4;
  level._id_78AD[var_0]["player_view_pos"] = var_3.origin;
  level._id_78AD[var_0]["view_angles"] = var_3.angles;
}

_id_669C(var_0, var_1, var_2, var_3) {
  var_4 = _getEnt(var_2, "targetname");
  var_5 = _id_463D(var_0, var_4);
  var_6 = spawnStruct();
  var_6._id_7584 = var_4.origin;
  var_6.label = var_1;
  var_6._id_3DD7 = 1;
  var_6._id_3DD6 = (0.5, 0.5, 1);
  var_6._id_7585 = var_5;
  var_6._id_0875 = var_3;
  var_6._id_78C9 = 8;
  level._id_78AC[var_0][level._id_78AC[var_0].size] = var_6;
  return var_6;
}

_id_A162() {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(level._id_78AA)) {
      waitframe();
      continue;
    }

    var_0 = level._id_08BF;

    foreach(var_2 in level._id_78AC[level._id_78AA]) {
      if(_id_572C(var_2._id_9188, var_2._id_366E)) {
        level._id_08BF = var_2;
        continue;
      }

      var_2._id_3DD6 = (0.5, 0.5, 1);
    }

    if(isDefined(level._id_08BF)) {
      level._id_08BF._id_3DD6 = (1, 1, 0.5);

      if(isDefined(var_0) && var_0 != level._id_08BF) {
        level._id_6999 playSound("mouse_over");
      }
    }

    waitframe();
  }
}

_id_A940() {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(level._id_6999)) {
      waitframe();
      continue;
    }

    var_0 = 1;

    while(!level._id_6999 buttonPressed("BUTTON_A")) {
      waitframe();
    }

    level._id_6999 playSound("mouse_click");

    if(isDefined(level._id_08BF) && var_0) {
      level._id_08BF notify("select_button_pressed");
      [[level._id_08BF._id_0875]]();
      var_0 = 0;
    }

    while(level._id_6999 buttonPressed("BUTTON_A")) {
      waitframe();
    }
  }
}

_id_A8EE() {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(level._id_6999)) {
      waitframe();
      continue;
    }

    var_0 = 1;

    while(!level._id_6999 buttonPressed("BUTTON_X")) {
      waitframe();
    }

    level._id_6999 playSound("mouse_click");

    if(var_0) {
      _id_0874();
      var_0 = 0;
    }

    while(level._id_6999 buttonPressed("BUTTON_X")) {
      waitframe();
    }
  }
}

_id_8F1B(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    for(var_2 = 0; var_2 < var_0.size - 1 - var_1; var_2++) {
      if(var_0[var_2 + 1]._id_7585 < var_0[var_2]._id_7585) {
        _id_1DD7(var_0[var_2], var_0[var_2 + 1]);
      }
    }
  }
}

_id_1DD7(var_0, var_1) {
  var_2 = var_0._id_7584;
  var_3 = var_0.label;
  var_4 = var_0._id_7585;
  var_5 = var_0._id_0875;
  var_6 = var_0._id_78C9;
  var_0._id_7584 = var_1._id_7584;
  var_0.label = var_1.label;
  var_0._id_7585 = var_1._id_7585;
  var_0._id_0875 = var_1._id_0875;
  var_0._id_78C9 = var_1._id_78C9;
  var_1._id_7584 = var_2;
  var_1.label = var_3;
  var_1._id_7585 = var_4;
  var_1._id_0875 = var_5;
  var_1._id_78C9 = var_6;
}

_id_33C7(var_0) {
  foreach(var_2 in level._id_78AC[var_0]) {
    var_2 thread _id_33C6(var_0);
  }
}

_id_33C6(var_0) {
  level endon("game_ended");
  self endon("remove_button");
  var_1 = level._id_78AD[var_0]["view_pos"];
  var_2 = var_1 + _id_78A9(self._id_7585, 4);

  for(;;) {
    var_3 = (1, 0, 0);

    if(_id_572C(self._id_9188, self._id_366E)) {
      var_3 = (1, 1, 0);
    }

    if(isDefined(level._id_2856) && level._id_2856 > 0) {
      var_4 = var_1 + _id_78A9(level._id_7F3D, 2);
    }

    waitframe();
  }
}

_id_ACC8(var_0, var_1) {
  level._id_08BF = undefined;

  if(isDefined(level._id_78AA) && level._id_78AA != "") {
    level._id_78AE = level._id_78AA;
  } else {
    level._id_78AE = "main";
    level._id_78AA = "main";
  }

  foreach(var_3 in level._id_78AC[level._id_78AE]) {
    var_3 notify("remove_button");
  }

  if(isDefined(var_1) && var_1) {
    level._id_6999 _id_47F3(level._id_78AD[level._id_78AE]["view_start"], var_0);
  } else {
    level._id_6999 _id_47F2(level._id_78AD[var_0]["view_start"]);
  }

  level thread _id_33C7(var_0);
  level._id_78AA = var_0;
}

_id_463D(var_0, var_1) {
  var_2 = level._id_78AD[var_0]["view_angles"];
  var_3 = level._id_78AD[var_0]["view_pos"];
  var_3 = var_3 + vectorNormalize(anglesToForward(var_2)) * 40;
  var_4 = anglesToForward(var_2);
  var_5 = vectorNormalize(anglestoup(var_2));
  var_6 = var_1.angles;
  var_7 = var_1.origin;
  var_8 = vectorNormalize(_vectorfromlinetopoint(var_3, var_3 + var_4, var_7));
  var_9 = _acos(vectordot(var_8, var_5));

  if(vectordot(anglestoright(var_2), var_8) < 0) {
    var_9 = 360 - var_9;
  }

  return var_9;
}

_id_78A9(var_0, var_1) {
  var_2 = (270 - var_0, 0, 0);
  var_3 = anglesToForward(var_2);
  var_4 = vectorNormalize(var_3);
  var_5 = var_4 * var_1;
  return var_5;
}

_id_4586(var_0, var_1) {
  var_2 = (var_0 + var_1 + 720) / 2 - 360;
  return var_2;
}

_id_572C(var_0, var_1) {
  var_2 = level._id_7F3D > var_0 && level._id_7F3D < 360;
  var_3 = level._id_7F3D > 0 && level._id_7F3D < var_1;

  if(var_0 > var_1) {
    var_4 = var_2 || var_3;
  } else {
    var_4 = level._id_7F3D > var_0 && level._id_7F3D < var_1;
  }

  return var_4;
}

_id_0874() {
  if(isDefined(level._id_78AA) && level._id_78AA != "main") {
    _id_ACC8("main", 1);
  } else {
    return;
  }
}

_id_0880() {
  _iprintlnbold("action_weapons_primary");
  _id_ACC8("weapons_primary");
}

_id_0881() {
  _iprintlnbold("action_weapons_secondary");
  _id_ACC8("weapons_secondary");
}

_id_0876() {
  _iprintlnbold("action_gears");
  _id_ACC8("gears");
}

_id_0877() {
  _iprintlnbold("action_killstreak");
  _id_ACC8("killstreak");
}

_id_0878() {
  _iprintlnbold("action_leaderboards");
  _id_ACC8("leaderboards");
}

_id_A4AB() {
  level._id_A4AC = [];
  _id_1D19("player_view1_start");
  _id_1D19("player_view2_start");
  _id_1D19("player_view3_start");
  _id_1D19("player_view4_start");
  _id_1D19("player_view5_start");
}

_id_1D19(var_0) {
  level._id_A4AC[var_0] = [];
  var_1 = _getEnt(var_0, "targetname");

  for(level._id_A4AC[var_0][level._id_A4AC[var_0].size] = var_1; isDefined(var_1) && isDefined(var_1.target); var_1 = var_2) {
    var_2 = _getEnt(var_1.target, "targetname");
    level._id_A4AC[var_0][level._id_A4AC[var_0].size] = var_2;
  }
}

_id_47F2(var_0) {
  if(!isDefined(level._id_34D5)) {
    var_1 = level._id_A4AC[var_0][0];
    level._id_34D5 = spawn("script_model", var_1.origin);
    level._id_34D5.angles = var_1.angles;
    self setOrigin(level._id_34D5.origin - (0, 0, 65));
    self linkTo(level._id_34D5);
    waitframe();
    self setplayerangles(level._id_34D5.angles);
    thread _id_3DF9();
  }

  var_2 = 1;
  var_3 = _abs(distance(level._id_34D5.origin, level._id_A4AC[var_0][level._id_A4AC[var_0].size - 1].origin));
  var_2 = var_2 * (var_3 / 1200);
  var_2 = max(var_2, 0.1);
  var_4 = var_2;

  if(!1) {
    var_4 = var_4 * (var_2 * (level._id_A4AC[var_0].size + 1));
  }

  thread _id_1883(3, var_4);

  foreach(var_7, var_6 in level._id_A4AC[var_0]) {
    if(1) {
      if(var_7 != level._id_A4AC[var_0].size - 1) {
        continue;
      }
    }

    level._id_34D5 moveTo(var_6.origin, var_2, var_2 * 0.5, 0);
    level._id_34D5 rotateTo(var_6.angles, var_2, var_2 * 0.5, 0);
    wait(var_2);
  }
}

_id_47F3(var_0, var_1) {
  var_2 = 1;
  var_3 = _abs(distance(level._id_34D5.origin, level._id_78AD[var_1]["player_view_pos"]));
  var_2 = var_2 * (var_3 / 1200);
  var_2 = max(var_2, 0.1);
  var_4 = var_2;

  if(!1) {
    var_4 = var_4 * (var_2 * (level._id_A4AC[var_0].size + 1));
  }

  thread _id_1883(3, var_4);

  if(!1) {
    for(var_5 = level._id_A4AC[var_0].size - 1; var_5 >= 0; var_5--) {
      var_6 = level._id_A4AC[var_0][var_5];
      level._id_34D5 moveTo(var_6.origin, var_2);
      level._id_34D5 rotateTo(var_6.angles, var_2);
      wait(var_2);
    }
  }

  thread _id_1883(3, var_2);
  var_7 = level._id_78AD[var_1]["player_view_pos"];
  var_8 = level._id_78AD[var_1]["view_angles"];
  level._id_34D5 moveTo(var_7, var_2, var_2 * 0.5, 0);
  level._id_34D5 rotateTo(var_8, var_2, var_2 * 0.5, 0);
  wait(var_2);
}

_id_9D01(var_0) {
  self setblurforplayer(20, (var_0 + 0.2) / 2);
  self setblurforplayer(0, (var_0 + 0.2) / 2);
  self shellshock("frag_grenade_mp", var_0 + 0.2);
}

_id_1883(var_0, var_1) {
  var_2 = int(var_1 / 0.05);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_3 / var_2;
    var_5 = _sin(180 * var_4);
    var_6 = var_0 * var_5;
    setDvar("797", var_6);
    waitframe();
  }

  setDvar("797", 0);
}

_id_3DF9() {
  level endon("game_ended");
  self endon("disconnect");
  level._id_34D5 endon("remove_dummy");

  for(;;) {
    self setplayerangles(level._id_34D5.angles);
    waitframe();
  }
}