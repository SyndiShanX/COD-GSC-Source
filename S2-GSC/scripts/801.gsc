/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\801.gsc
**************************************/

_id_84DF(var_0, var_1) {
  var_2 = undefined;
  var_0 = _tolower(var_0);
  var_3["friendly"] = 3;
  var_3["enemy"] = 4;
  var_3["objective"] = 5;
  var_3["neutral"] = 0;
  var_2 = var_3[var_0];
  self hudoutlineenable(var_2, var_1);
}

_id_554E() {
  if(_issplitscreen() || getDvar("4693") == "1")
    return 1;

  return 0;
}

_id_554F() {
  if(_issplitscreen())
    return 0;

  if(!_id_554E())
    return 0;

  return 1;
}

_id_55DE(var_0) {
  if(var_0 common_scripts\utility::_id_3798("laststand_downed"))
    return var_0 common_scripts\utility::_id_3794("laststand_downed");

  if(isDefined(var_0._id_00E8))
    return var_0._id_00E8;

  return !isalive(var_0);
}

_id_55DF(var_0) {
  if(!isDefined(var_0._id_32CC))
    return 0;

  return var_0._id_32CC;
}

_id_5A49(var_0) {
  if(_id_5BE4()) {
    if(isDefined(level._id_5BE5))
      return var_0[[level._id_5BE5]]();
  }

  return 0;
}

_id_5621() {
  return _id_5612() && getdvarint("719") > 0;
}

_id_5BE4() {
  return isDefined(level._id_5BE7) && level._id_5BE7 > 0;
}

_id_5612() {
  return getdvarint("1996") >= 1;
}

_id_2614(var_0, var_1) {
  var_2 = "";

  if(var_0 < 0)
    var_2 = var_2 + "-";

  var_0 = _id_7F05(var_0, 1, 0);
  var_3 = var_0 * 100;
  var_3 = int(var_3);
  var_3 = _abs(var_3);
  var_4 = var_3 / 6000;
  var_4 = int(var_4);
  var_2 = var_2 + var_4;
  var_5 = var_3 / 100;
  var_5 = int(var_5);
  var_5 = var_5 - var_4 * 60;

  if(var_5 < 10)
    var_2 = var_2 + (":0" + var_5);
  else
    var_2 = var_2 + (":" + var_5);

  if(isDefined(var_1) && var_1) {
    var_6 = var_3;
    var_6 = var_6 - var_4 * 6000;
    var_6 = var_6 - var_5 * 100;
    var_6 = int(var_6 / 10);
    var_2 = var_2 + ("." + var_6);
  }

  return var_2;
}

_id_7F05(var_0, var_1, var_2) {
  var_1 = int(var_1);

  if(var_1 < 0 || var_1 > 4)
    return var_0;

  var_3 = 1;

  for(var_4 = 1; var_4 <= var_1; var_4++)
    var_3 = var_3 * 10;

  var_5 = var_0 * var_3;

  if(!isDefined(var_2) || var_2)
    var_5 = _floor(var_5);
  else
    var_5 = _ceil(var_5);

  var_0 = var_5 / var_3;
  return var_0;
}

_id_7F0A(var_0, var_1, var_2) {
  var_3 = var_0 / 1000;
  var_3 = _id_7F05(var_3, var_1, var_2);
  var_0 = var_3 * 1000;
  return int(var_0);
}

_id_85EE(var_0, var_1) {
  if(_id_0322::_id_5283(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  _visionsetnaked(var_0, var_1);
  setDvar("vision_set_current", var_0);
}

_id_85EF(var_0, var_1) {
  if(_id_0322::_id_5283(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 1;

  self visionsetnakedforplayer(var_0, var_1);
}

_id_94E3(var_0, var_1, var_2) {
  var_2 = int(var_2 * 20);
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++)
    var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;

  var_5 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    waitframe();

    for(var_6 = 0; var_6 < 3; var_6++)
      var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;

    _setsunlight(var_5[0], var_5[1], var_5[2]);
  }

  _setsunlight(var_1[0], var_1[1], var_1[2]);
}

_id_4109(var_0, var_1, var_2, var_3) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = level.player;

  if(!isDefined(var_3))
    var_3 = -1;

  var_4 = var_1.origin;

  if(isDefined(var_2) && var_2)
    var_4 = var_1 getEye();

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

_id_4101(var_0, var_1, var_2) {
  if(!var_0.size) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = level.player;

  var_3 = var_1.origin;

  if(isDefined(var_2) && var_2)
    var_3 = var_1 getEye();

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

_id_3C96(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isDefined(var_2))
    var_2 = 0;

  var_1 thread _id_0322::_id_0629(var_0, var_2);
  return var_1;
}

_id_3C97(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_0);

  if(!isDefined(var_2))
    var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_1[var_3] thread _id_0322::_id_0629(var_0, 0);

  return var_1;
}

_id_3C91(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::flag_set(var_0);
}

_id_3C7C(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::_id_3C7B(var_0);
}

_id_5CB1(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(_id_0F44() && !var_0)
    return 0;

  if(level._id_6256 && !var_0)
    return 0;

  if(common_scripts\utility::_id_3C77("game_saving"))
    return 0;

  if(!var_0) {
    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      var_3 = level.players[var_2];

      if(!isalive(var_3))
        return 0;
    }
  }

  common_scripts\utility::flag_set("game_saving");
  var_4 = "levelshots / autosave / autosave_" + level._id_015D + "end";
  var_5 = var_1;
  _savegame("levelend", &"AUTOSAVE_AUTOSAVE", var_4, 1, 1, var_5);
  common_scripts\utility::_id_3C7B("game_saving");
  return 1;
}

_id_0928(var_0, var_1, var_2) {
  level._id_0625[var_0] = [];
  level._id_0625[var_0]["func"] = var_1;
  level._id_0625[var_0]["msg"] = var_2;
}

_id_7C87(var_0) {
  level._id_0625[var_0] = undefined;
}

_id_139B() {
  thread _id_138F("autosave_stealth", 8, 1);
}

_id_139C() {
  thread _id_138F("autosave_stealth", 8, 1, 1);
}

_id_139D() {
  _id_0322::_id_13A2();
  thread _id_0322::_id_13A1();
}

_id_138D(var_0) {
  thread _id_138F(var_0);
}

_id_138E(var_0) {
  thread _id_138F(var_0, undefined, undefined, 1);
}

_id_138F(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_28CE))
    level._id_28CE = 1;

  var_4 = "levelshots/autosave/autosave_" + level._id_015D + level._id_28CE;
  var_5 = level _id_0299::_id_13A3(level._id_28CE, var_4, var_1, undefined, var_2, var_3);

  if(isDefined(var_5) && var_5) {
    if(!isDefined(var_3) || var_3 == 0)
      _id_031D::_id_7430("CHECKPOINT_REACHED");

    level._id_28CE++;
  }
}

_id_1397(var_0, var_1) {
  thread _id_138F(var_0, var_1);
}

_id_2AF1(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 5;

  if(isDefined(var_3)) {
    var_3 endon("death");
    var_1 = var_3.origin;
  }

  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    if(!isDefined(var_3)) {} else {}

    waitframe();
  }
}

_id_2AF2(var_0, var_1) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 5;

  for(var_2 = 0; var_2 < var_1 * 20; var_2++)
    waitframe();
}

_id_2AF3(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level notify(var_0 + var_3);
    level endon(var_0 + var_3);
  } else {
    level notify(var_0);
    level endon(var_0);
  }

  if(!isDefined(var_2))
    var_2 = 5;

  for(var_4 = 0; var_4 < var_2 * 20; var_4++)
    waitframe();
}

precache(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1.origin = level.player getorigin();
  var_1 setModel(var_0);
  var_1 delete();
}

_id_244A(var_0, var_1) {
  return var_0 >= var_1;
}

_id_3A52(var_0, var_1) {
  return var_0 <= var_1;
}

_id_4465(var_0, var_1, var_2) {
  return _id_0322::_id_255C(var_0, var_1, var_2, ::_id_244A);
}

_id_4105(var_0, var_1, var_2) {
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

  if(!isDefined(var_2) || var_4 <= var_2)
    return var_3;

  return undefined;
}

_id_4189(var_0, var_1) {
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

_id_43E3(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

_id_4276(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) > var_2)
      var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

_id_4102(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 9999999;

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

_id_41C3(var_0, var_1, var_2) {
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

_id_40FF(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 9999999;

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

_id_40FB(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    return undefined;

  var_3 = 0;

  if(isDefined(var_2) && var_2.size) {
    var_4 = [];

    for(var_5 = 0; var_5 < var_1.size; var_5++)
      var_4[var_5] = 0;

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_1[var_5] == var_2[var_6])
          var_4[var_5] = 1;
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

    if(!var_7)
      return undefined;
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
          if(var_1[var_5] == var_2[var_6])
            var_4 = 1;
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

  if(isDefined(var_8))
    return var_1[var_8];
  else
    return undefined;
}

_id_4103(var_0) {
  if(level.players.size == 1)
    return level.player;

  var_1 = common_scripts\utility::_id_4461(var_0, level.players);
  return var_1;
}

_id_4104(var_0) {
  if(level.players.size == 1)
    return level.player;

  var_1 = _id_42B7();
  var_2 = common_scripts\utility::_id_4461(var_0, var_1);
  return var_2;
}

_id_42B7() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(_id_55DE(var_2)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_40F5(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_3 = _getaiarray(var_1);
  else
    var_3 = _getaiarray();

  if(var_3.size == 0)
    return undefined;

  if(isDefined(var_2))
    var_3 = common_scripts\utility::_id_0F94(var_3, var_2);

  return common_scripts\utility::_id_4461(var_0, var_3);
}

_id_40F6(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_3 = _getaiarray(var_1);
  else
    var_3 = _getaiarray();

  if(var_3.size == 0)
    return undefined;

  return _id_40FB(var_0, var_3, var_2);
}

_id_42CF(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = distance(var_0, var_1);

  var_3 = max(0.01, var_3);
  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = var_2 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_3;
  var_6 = clamp(var_6, 0, 1);
  return var_6;
}

_id_1F23(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!_id_753A(var_0))
    return 0;

  if(!_sighttracepassed(self getEye(), var_0, var_1, self))
    return 0;

  return 1;
}

_id_5577(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 180;

  var_2 = anglesToForward(self.angles);
  var_2 = vectorNormalize((var_2[0], var_2[1], 0));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_3 = vectorNormalize((var_3[0], var_3[1], 0));
  var_4 = vectordot(var_2, var_3);
  var_5 = _cos(var_1 / 2.0);
  return var_4 > var_5;
}

_id_753A(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = vectorNormalize(var_0 - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > 0.766;
}

_id_93D8() {
  self notify("stop_magic_bullet_shield");

  if(_isai(self))
    self._id_0022 = 1;

  self._id_5F6E = undefined;
  self._id_0068 = 0;
  self notify("internal_stop_magic_bullet_shield");
}

_id_5F6D() {}

_id_5F6E(var_0) {
  if(_isai(self)) {} else
    self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if(_isai(self))
    self._id_0022 = 0.1;

  self notify("magic_bullet_shield");
  self._id_5F6E = 1;
  self._id_0068 = 1;
}

_id_2F4B() {
  self._id_0794._id_2F8D = 1;
}

_id_3631() {
  self._id_0794._id_2F8D = 0;
}

_id_360A() {
  self._id_8C84 = undefined;
}

_id_2F1F() {
  self._id_8C84 = 1;
}

_id_2CF0() {
  _id_5F6E(1);
}

_id_41D8() {
  return self._id_00CE;
}

_id_84E3(var_0) {
  self._id_00CE = var_0;
}

_id_84E2(var_0) {
  self._id_00CA = var_0;

  if(var_0)
    self clearenemy();
}

_id_41D7(var_0) {
  return self._id_00CA;
}

_id_8563(var_0) {
  self._id_0147 = var_0;
}

_id_42D2(var_0) {
  return self._id_0147;
}

_id_84E4(var_0) {
  self._id_50A1 = var_0;
}

_id_848A(var_0) {
  self._id_0094 = var_0;
}

_id_427D() {
  return self._id_0118;
}

agentsetfavoriteenemy(var_0) {
  self._id_0118 = var_0;
}

_id_508D(var_0) {
  self notify("new_ignore_me_timer");
  self endon("new_ignore_me_timer");
  self endon("death");

  if(!isDefined(self._id_508E))
    self._id_508E = self._id_00CE;

  var_1 = _getaiarray("bad_guys");

  foreach(var_3 in var_1) {
    if(!isalive(var_3._id_0088)) {
      continue;
    }
    if(var_3._id_0088 != self) {
      continue;
    }
    var_3 clearenemy();
  }

  self._id_00CE = 1;
  wait(var_0);
  self._id_00CE = self._id_508E;
  self._id_508E = undefined;
}

_id_2D0C(var_0) {
  common_scripts\_exploder::_id_2D0D(var_0);
}

_id_4CE2(var_0) {
  common_scripts\_exploder::_id_4CE3(var_0);
}

_id_8BC9(var_0) {
  common_scripts\_exploder::_id_8BCA(var_0);
}

_id_93C7(var_0) {
  common_scripts\_exploder::_id_93C8(var_0);
}

_id_417E(var_0) {
  return common_scripts\_exploder::_id_417F(var_0);
}

_id_3D80(var_0) {
  _id_02FC::_id_3D83(var_0);
}

_id_840C(var_0, var_1) {
  _id_0362::_id_14AF(var_0, var_1);
}

_id_3DE8(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 4;

  thread _id_3DE9(var_0, var_1, var_2, var_3);
}

_id_6CBA() {}

_id_3DE9(var_0, var_1, var_2, var_3) {
  self._id_3E21 = 1;
  self._id_0794._id_3DF5 = var_1;
  self._id_6737 = 1;
  self._id_671E = var_3;
  self._id_0794._id_2963 = var_2;
  self._id_2774 = ::_id_6CBA;
  self.maxhealth = 100000;
  self.health = 100000;
  _id_3631();

  if(!isDefined(var_3) || var_3 == 0)
    self._id_0794._id_3DE7 = var_0 + 181.02;
  else {
    self._id_0794._id_3DE7 = var_0;
    thread animscripts\notetracks::_id_67C9();
  }
}

_id_6681() {
  self endon("death");

  for(;;) {
    var_0 = self ishighjumping();

    if(var_0) {
      var_1 = common_scripts\utility::waittill_any_return("exo_dodge", "player_boost_land", "disable_high_jump");

      if(!isDefined(var_1) || (var_1 == "player_boost_land" || var_1 == "disable_high_jump")) {
        continue;
      }
      if(!isDefined(self._id_6681))
        self._id_6681 = 1;

      common_scripts\utility::_id_A70A("player_boost_land", "disable_high_jump");
      waitframe();
      self._id_6681 = undefined;
    }

    waitframe();
  }
}

_id_8B0C() {
  _precacheshellshock("default");
  self waittill("death");

  if(isDefined(self._id_90D0)) {
    return;
  }
  if(getDvar("r_texturebits") == "16") {
    return;
  }
  self shellshock("default", 3);
}

_id_748C() {
  self endon("death");
  self endon("stop_unresolved_collision_script");
  _id_7D48();
  childthread _id_748D();

  for(;;) {
    if(self._id_A042) {
      self._id_A042 = 0;

      if(self._id_A043 >= 20) {
        if(isDefined(self._id_4A93))
          self[[self._id_4A93]]();
        else
          _id_2BBE();
      }
    } else
      _id_7D48();

    waitframe();
  }
}

_id_748D() {
  for(;;) {
    self waittill("unresolved_collision");
    self._id_A042 = 1;
    self._id_A043++;
  }
}

_id_7D48() {
  self._id_A042 = 0;
  self._id_A043 = 0;
}

_id_2BBE() {
  var_0 = _getnodesinradiussorted(self.origin, 300, 0, 200, "Path");

  if(var_0.size) {
    self cancelmantle();
    self dontinterpolate();
    self setOrigin(var_0[0].origin);
    _id_7D48();
  } else
    self kill();
}

_id_93E3() {
  self notify("stop_unresolved_collision_script");
  _id_7D48();
}

_id_2D1A(var_0, var_1) {
  var_0 endon("death");
  common_scripts\utility::_id_A70A("death", "sound_death");

  if(isDefined(var_0)) {
    if(var_0 iswaitingonsound())
      var_0 waittill(var_1);

    var_0 delete();
  }
}

_id_555F() {
  return _issentient(self) && !isalive(self);
}

_id_0692(var_0, var_1) {
  var_1 endon("sound_death");
  var_0 waittill("death");
  return 1;
}

play_sound_on_tag(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::_id_562E(var_2) && _id_555F()) {
    return;
  }
  if(!_soundexists(var_0)) {
    return;
  }
  if(isDefined(var_1)) {
    var_1 = _tolower(var_1);

    if(self gettagindex(var_1) == -1)
      var_1 = undefined;
  }

  if(!isDefined(var_2) || !var_2)
    var_5 = _id_0380::_id_6848(var_0, undefined, self, var_1);
  else
    var_5 = _id_0380::_id_684A(var_0, undefined, self, var_1);

  if(isDefined(var_5)) {
    var_6 = _id_0692(var_5, self);

    if(!isDefined(var_6) && isDefined(var_5)) {
      _id_0380::_id_6850(var_5, 0.1);
      wait 0.1;
    }
  } else
    wait 0.1;

  if(isDefined(var_3) && isDefined(self))
    self notify(var_3);
}

_id_71AD(var_0, var_1) {
  play_sound_on_tag(var_0, var_1, 1);
}

_id_71AB(var_0, var_1) {
  play_sound_on_tag(var_0, undefined, undefined, var_1);
}

_id_7154(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", (0, 0, 0));
  var_4 endon("death");

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2)
    thread common_scripts\utility::_id_2D18(var_4);

  if(!isDefined(var_3))
    var_3 = 0;

  if(var_3)
    thread _id_2D22(var_4);

  if(isDefined(var_1))
    var_4 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  else {
    var_4.origin = self.origin;
    var_4.angles = self.angles;
    var_4 linkto(self);
  }

  var_4 playloopsound(var_0);
  self waittill("stop sound" + var_0);
  var_4 stoploopsound(var_0);
  var_4 delete();
}

_id_2D22(var_0) {
  var_0 endon("death");

  while(isDefined(self))
    waitframe();

  if(isDefined(var_0))
    var_0 delete();
}

unlink() {
  var_0 = _getaiarray("allies");
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2].getaimangle)) {
      continue;
    }
    game["character" + var_1] = var_0[var_2] codescripts\character::save();
    var_1++;
  }

  game["total characters"] = var_1;
}

_id_8FA3(var_0) {
  if(!isalive(var_0))
    return 1;

  if(!isDefined(var_0._id_3BAA))
    var_0 common_scripts\utility::_id_A732("finished spawning", "death");

  if(isalive(var_0))
    return 0;

  return 1;
}

_id_8FF2(var_0) {
  codescripts\character::precache(var_0);
  self waittill("spawned", var_1);

  if(_id_8FA3(var_1)) {
    return;
  }
  var_1 codescripts\character::new();
  var_1 codescripts\character::load(var_0);
}

_id_59E4(var_0, var_1) {
  _iprintlnbold(var_0, var_1["key1"]);
}

_id_A4AD(var_0) {
  self endon("death");

  for(;;) {
    _id_02A9::_id_33E0(var_0);
    waitframe();
  }
}

_id_10CA(var_0) {
  if(isDefined(var_0))
    self._id_0EC4 = var_0;

  self useanimtree(level.setclock[self._id_0EC4]);
}

_id_10D3() {
  if(_isarray(level.setcursorhint[self._id_0EC4])) {
    var_0 = randomint(level.setcursorhint[self._id_0EC4].size);
    self setModel(level.setcursorhint[self._id_0EC4][var_0]);
  } else
    self setModel(level.setcursorhint[self._id_0EC4]);
}

_id_8F82(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = spawn("script_model", var_1);
  var_3._id_0EC4 = var_0;
  var_3 _id_10CA();
  var_3 _id_10D3();

  if(isDefined(var_2))
    var_3.angles = var_2;

  return var_3;
}

_id_9DB8(var_0, var_1) {
  var_2 = _getent(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2 waittill("trigger", var_3);
  level notify(var_0, var_3);
  return var_3;
}

_id_9DB9(var_0) {
  return _id_9DB8(var_0, "targetname");
}

_id_8492(var_0, var_1) {
  thread agentclearscriptvars(var_0, var_1, ::_id_A728, "set_flag_on_dead");
}

vehicle_jetbikesetthrustscale(var_0, var_1) {
  thread agentclearscriptvars(var_0, var_1, ::_id_A729, "set_flag_on_dead_or_dying");
}

drawfacingentity(var_0, var_1) {
  thread agentclearscriptvars(var_0, var_1, ::_id_35F9, "set_flag_on_spawned");
}

_id_35F9(var_0) {
  return;
}

allowdodge(var_0, var_1) {
  self waittill("spawned", var_2);

  if(_id_8FA3(var_2)) {
    return;
  }
  var_0._id_9044[var_0._id_9044.size] = var_2;
  common_scripts\utility::_id_379A(var_1);
}

setcanspawnvehicleson(var_0, var_1) {
  self waittill("spawned", var_2);
  var_0._id_9044[var_0._id_9044.size] = var_2;
  common_scripts\utility::_id_379A(var_1);
}

agentclearscriptvars(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_9044 = [];

  if(var_0.size == 0) {
    return;
  }
  var_5 = 0;
  var_6 = 0;

  foreach(var_9, var_8 in var_0) {
    if(_isspawner(var_8)) {
      var_5++;
      continue;
    }

    var_6++;
  }

  if(var_6 != var_0.size && var_5 != var_0.size) {}

  if(_isspawner(var_0[0])) {
    var_10 = var_0;

    foreach(var_9, var_12 in var_10)
    var_12 common_scripts\utility::_id_3799(var_3);

    if(var_10[0]._id_003B == "script_vehicle")
      common_scripts\utility::_id_0FB2(var_10, ::setcanspawnvehicleson, var_4, var_3);
    else
      common_scripts\utility::_id_0FB2(var_10, ::allowdodge, var_4, var_3);

    foreach(var_9, var_12 in var_10)
    var_12 common_scripts\utility::_id_379C(var_3);
  } else
    var_4._id_9044 = var_0;

  [[var_2]](var_4._id_9044);
  common_scripts\utility::flag_set(var_1);
}

setclutforplayer(var_0, var_1) {
  if(!common_scripts\utility::_id_3C77(var_1)) {
    var_0 waittill("trigger", var_2);
    common_scripts\utility::flag_set(var_1);
    return var_2;
  }
}

vehicle_setminimapvisible(var_0) {
  if(common_scripts\utility::_id_3C77(var_0)) {
    return;
  }
  var_1 = _getent(var_0, "targetname");
  var_1 waittill("trigger");
  common_scripts\utility::flag_set(var_0);
}

_id_559A(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1)
      return 1;
  }

  return 0;
}

_id_A728(var_0, var_1, var_2) {
  var_10 = spawnStruct();

  if(isDefined(var_2)) {
    var_10 endon("thread_timed_out");
    var_10 thread _id_A72E(var_2);
  }

  var_10._id_005C = var_0.size;

  if(isDefined(var_1) && var_1 < var_10._id_005C)
    var_10._id_005C = var_1;

  common_scripts\utility::_id_0FB2(var_0, ::_id_A72D, var_10);

  while(var_10._id_005C > 0)
    var_10 waittill("waittill_dead guy died");
}

_id_A729(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    if(isalive(var_5) && !var_5._id_00CD)
      var_3[var_3.size] = var_5;
  }

  var_0 = var_3;
  var_7 = spawnStruct();

  if(isDefined(var_2)) {
    var_7 endon("thread_timed_out");
    var_7 thread _id_A72E(var_2);
  }

  var_7._id_005C = var_0.size;

  if(isDefined(var_1) && var_1 < var_7._id_005C)
    var_7._id_005C = var_1;

  common_scripts\utility::_id_0FB2(var_0, ::_id_A72C, var_7);

  while(var_7._id_005C > 0)
    var_7 waittill("waittill_dead_guy_dead_or_dying");
}

_id_A72D(var_0) {
  self waittill("death");
  var_0._id_005C--;
  var_0 notify("waittill_dead guy died");
}

_id_A72C(var_0) {
  common_scripts\utility::_id_A732("death", "pain_death");
  var_0._id_005C--;
  var_0 notify("waittill_dead_guy_dead_or_dying");
}

_id_A72E(var_0) {
  wait(var_0);
  self notify("thread_timed_out");
}

_id_A706(var_0) {
  while(level._id_0596[var_0]._id_905E.size >= 1 || level._id_0596[var_0]._id_0A62.size >= 1)
    wait 0.25;
}

_id_A707(var_0, var_1) {
  for(;;) {
    var_2 = _id_406F(var_0);
    var_2 = var_2 + _id_406D(var_0);

    if(var_2 <= var_1) {
      break;
    }

    wait 0.25;
  }
}

_id_A708(var_0, var_1) {
  for(;;) {
    var_2 = _id_406D(var_0);

    if(var_2 <= var_1) {
      break;
    }

    wait 0.25;
  }
}

_id_A709(var_0, var_1, var_2) {
  level endon(var_2);
  _id_A708(var_0, var_1);
}

_id_406C(var_0) {
  return _id_406F(var_0) + _id_406D(var_0);
}

_id_406F(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_0596[var_0]._id_905E)
  var_1 = var_1 + var_3._id_005C;

  return var_1;
}

_id_406D(var_0) {
  return level._id_0596[var_0]._id_0A62.size;
}

_id_406B(var_0) {
  return level._id_0596[var_0]._id_0A62;
}

_id_4070(var_0) {
  return level._id_0596[var_0]._id_905E;
}

_id_A74A(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

_id_41F7(var_0, var_1) {
  var_2 = _id_41F8(var_0, var_1);

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

_id_41F8(var_0, var_1) {
  var_2 = _getaispeciesarray("all", "all");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isalive(var_5)) {
      continue;
    }
    switch (var_1) {
      case "targetname":
        if(isDefined(var_5.targetname) && var_5.targetname == var_0)
          var_3[var_3.size] = var_5;

        break;
      case "script_noteworthy":
        if(isDefined(var_5._id_0165) && var_5._id_0165 == var_0)
          var_3[var_3.size] = var_5;

        break;
    }
  }

  return var_3;
}

_id_43B9(var_0, var_1) {
  var_2 = _id_43BC(var_0, var_1);

  if(!var_2.size)
    return undefined;

  return var_2[0];
}

_id_43BC(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in var_2) {
    if(var_6._id_003B != "script_vehicle") {
      continue;
    }
    var_4[0] = var_6;

    if(_isspawner(var_6)) {
      if(isDefined(var_6._id_5B4F)) {
        var_4[0] = var_6._id_5B4F;
        var_3 = common_scripts\utility::_id_0F8C(var_3, var_4);
      }

      continue;
    }

    var_3 = common_scripts\utility::_id_0F8C(var_3, var_4);
  }

  return var_3;
}

_id_41F9(var_0, var_1, var_2) {
  var_3 = _id_41FA(var_0, var_1, var_2);

  if(var_3.size > 1)
    return undefined;

  return var_3[0];
}

_id_41FA(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = "all";

  var_3 = _getaispeciesarray("allies", var_2);
  var_3 = common_scripts\utility::_id_0F73(var_3, _getaispeciesarray("axis", var_2));
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    switch (var_1) {
      case "targetname":
        if(isDefined(var_3[var_5].targetname) && var_3[var_5].targetname == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
      case "script_noteworthy":
        if(isDefined(var_3[var_5]._id_0165) && var_3[var_5]._id_0165 == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
    }
  }

  return var_4;
}

_id_4003(var_0, var_1) {
  if(isDefined(level._id_4002[var_0])) {
    if(level._id_4002[var_0]) {
      waitframe();

      if(isalive(self))
        self notify("gather_delay_finished" + var_0 + var_1);

      return;
    }

    level waittill(var_0);

    if(isalive(self))
      self notify("gather_delay_finished" + var_0 + var_1);

    return;
  }

  level._id_4002[var_0] = 0;
  wait(var_1);
  level._id_4002[var_0] = 1;
  level notify(var_0);

  if(isalive(self))
    self notify("gather_delay_finished" + var_0 + var_1);
}

_id_4002(var_0, var_1) {
  thread _id_4003(var_0, var_1);
  self waittill("gather_delay_finished" + var_0 + var_1);
}

_id_2A9A(var_0) {
  self waittill("death");
  level notify(var_0);
}

_id_4453(var_0) {
  if(var_0 == 0)
    return "0";

  if(var_0 == 1)
    return "1";

  if(var_0 == 2)
    return "2";

  if(var_0 == 3)
    return "3";

  if(var_0 == 4)
    return "4";

  if(var_0 == 5)
    return "5";

  if(var_0 == 6)
    return "6";

  if(var_0 == 7)
    return "7";

  if(var_0 == 8)
    return "8";

  if(var_0 == 9)
    return "9";
}

_id_455C(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_5 = var_4._id_0164;

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

_id_0F8D(var_0, var_1) {
  if(!var_0.size)
    return var_1;

  if(!var_1.size)
    return var_0;

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];
    var_2[var_4._id_0164] = 1;
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    if(isDefined(var_2[var_4._id_0164])) {
      continue;
    }
    var_2[var_4._id_0164] = 1;
    var_0[var_0.size] = var_4;
  }

  return var_0;
}

_id_455B() {
  var_0 = [];

  if(isDefined(self.script_exploder)) {
    var_1 = common_scripts\utility::_id_41F3();

    foreach(var_3 in var_1) {
      var_4 = _getvehiclenodearray(var_3, "script_linkname");
      var_0 = common_scripts\utility::_id_0F73(var_0, var_4);
    }
  }

  return var_0;
}

_id_33B9(var_0, var_1, var_2, var_3, var_4) {
  for(;;)
    waitframe();
}

_id_33BF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    waitframe();

    if(!isDefined(var_1) || !isDefined(var_1.origin))
      return;
  }
}

_id_33BB(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_33BF(var_1, var_0, var_2, var_3, var_4, var_5);
}

_id_33BC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5)
    waitframe();
}

_id_33BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 endon(var_6);

  for(;;)
    waitframe();
}

_id_33C0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 endon(var_6);
  var_7 = 1;

  for(;;) {
    common_scripts\utility::_id_33BA(var_0, var_1, var_2, var_3, var_4, var_7);
    wait(var_7);
  }
}

_id_33BE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 = gettime() + var_6 * 1000;
  var_1 = var_1 * var_2;

  while(gettime() < var_6) {
    waitframe();

    if(!isDefined(var_0) || !isDefined(var_0.origin))
      return;
  }
}

_id_33A8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_7))
    var_8 = var_7;
  else
    var_8 = 16;

  var_9 = 360 / var_8;
  var_10 = [];

  for(var_11 = 0; var_11 < var_8; var_11++) {
    var_12 = var_9 * var_11;
    var_13 = _cos(var_12) * var_1;
    var_14 = _sin(var_12) * var_1;
    var_15 = var_0[0] + var_13;
    var_16 = var_0[1] + var_14;
    var_17 = var_0[2];
    var_10[var_10.size] = (var_15, var_16, var_17);
  }

  thread _id_33A7(var_10, var_2, var_3, var_4, var_5, var_6);
}

_id_33A7(var_0, var_1, var_2, var_3, var_4, var_5) {
  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    var_7 = var_0[var_6];

    if(var_6 + 1 >= var_0.size)
      var_8 = var_0[0];
    else
      var_8 = var_0[var_6 + 1];

    thread _id_33C0(var_7, var_8, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_23B5() {
  self notify("enemy");
  self clearenemy();
}

_id_163D(var_0) {
  _id_02A8::_id_2A44(var_0);
}

_id_163E(var_0) {
  _id_02A8::_id_2A46(var_0);
}

physicsgetangspeed(var_0) {
  _id_2A49(!var_0);
}

_id_3D60(var_0) {
  thread setpainvisioneq(1, var_0);
}

_id_3D5F(var_0) {
  thread setpainvisioneq(0, var_0);
}

setpainvisioneq(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "allies";

  if(!anim._id_2128) {
    return;
  }
  wait 1.5;
  level._id_3D5E[var_1] = var_0;
  var_2 = [];
  var_2 = _getaiarray(var_1);
  common_scripts\utility::_id_0FB2(var_2, ::setclutoverridedisableforplayer, var_0);
}

setclutoverridedisableforplayer(var_0) {
  self._id_3D5E = var_0;
}

_id_3ECB() {
  var_0 = _getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 _id_84AB(0);
  }

  level._id_3EC9 = 0;
}

_id_3ECC() {
  var_0 = _getaiarray("allies");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 _id_84AB(1);
  }

  level._id_3EC9 = 1;
}

_id_84AB(var_0) {
  if(var_0)
    self._id_3ECA = undefined;
  else
    self._id_3ECA = 1;
}

_id_2A62(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  switch (var_0) {
    case "reznov":
    case "hudson":
    case "mason":
      level._id_2A3D._id_723F = getsubstr(var_0, 0, 3);
      break;
    default:
      level._id_2A3D._id_723F = "mas";
      break;
  }

  self._id_2A3F = level._id_2A3D._id_723F;
}

_id_2A49(var_0) {
  if(_isai(self) && isalive(self)) {
    if(var_0)
      self._id_2A44 = 1;
    else
      self._id_2A44 = 0;
  } else {}
}

_id_4258(var_0) {
  var_1 = getEntArray("objective", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2]._id_0165 == var_0)
      return var_1[var_2].origin;
  }
}

_id_4257(var_0) {
  var_1 = getEntArray("objective_event", "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2]._id_0165 == var_0)
      return var_1[var_2];
  }
}

_id_A74E() {
  _id_0322::_id_A750(1);
}

_id_A74F() {
  _id_0322::_id_A750(0);
}

_id_2B5A() {
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
    waitframe();
  }
}

_id_41E3(var_0) {
  var_1 = self;

  while(isDefined(var_1.target)) {
    waitframe();

    if(isDefined(var_1.target)) {
      switch (var_0) {
        case "vehiclenode":
          var_1 = _getvehiclenode(var_1.target, "targetname");
          break;
        case "pathnode":
          var_1 = _getnode(var_1.target, "targetname");
          break;
        case "ent":
          var_1 = _getent(var_1.target, "targetname");
          break;
        case "struct":
          var_1 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
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

botclearbutton(var_0) {
  self endon("death");
  var_1 = _getaiarray("allies");
  var_1[var_1.size] = level.player;
  var_1 = _sortbydistance(var_1, self.origin, 3000);
  var_1 = common_scripts\utility::_id_0FA0(var_1);
  var_2 = var_1[_randomintrange(0, int(var_1.size / 2))];
  self setentitytarget(var_2, 1);

  if(isDefined(var_0))
    thread _id_9A01(var_0);

  self._id_00AE = 64;
  self setgoalentity(var_2);

  if(!isDefined(self._id_6A58))
    self._id_6A58 = self._id_00AE;

  common_scripts\utility::_id_A70A("goal", "timeout");

  if(isDefined(self._id_6A58)) {
    self._id_00AE = self._id_6A58;
    self._id_6A58 = undefined;
  }
}

_id_731C(var_0) {
  if(isDefined(var_0))
    thread _id_9A01(var_0);

  self._id_00AE = 128;
  self setgoalentity(level.player);

  if(!isDefined(self._id_6A58))
    self._id_6A58 = self._id_00AE;

  common_scripts\utility::_id_A70A("goal", "timeout");

  if(isDefined(self._id_6A58)) {
    self._id_00AE = self._id_6A58;
    self._id_6A58 = undefined;
  }
}

_id_9A01(var_0) {
  self endon("death");
  wait(var_0);
  self notify("timeout");
}

notifyonplayercommandremove() {
  if(isDefined(self._id_84A6)) {
    return;
  }
  self._id_6A57 = self._id_011D;
  self._id_6A5F = self._id_011E;
  self._id_6A60 = self._id_0100;
  self._id_011D = 8;
  self._id_011E = 8;
  self._id_0100 = 1;
  self._id_84A6 = 1;
}

_id_A04D() {
  if(!isDefined(self._id_84A6)) {
    return;
  }
  self._id_011D = self._id_6A57;
  self._id_011E = self._id_6A5F;
  self._id_0100 = self._id_6A60;
  self._id_84A6 = undefined;
}

_id_0F9D(var_0) {
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

_id_0F9C(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_0F9E(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    if(_isai(var_3) && var_3 _id_3201()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_947A() {
  var_0 = spawnStruct();
  var_0._id_0F6D = [];
  var_0._id_5BAD = 0;
  return var_0;
}

_id_947D(var_0, var_1) {
  var_0._id_0F6D[var_0._id_5BAD] = var_1;
  var_1._id_9479 = var_0._id_5BAD;
  var_0._id_5BAD++;
}

_id_947E(var_0, var_1) {
  _id_9483(var_0, var_1);
  var_0._id_0F6D[var_0._id_5BAD - 1] = undefined;
  var_0._id_5BAD--;
}

_id_947F(var_0, var_1) {
  if(isDefined(var_0._id_0F6D[var_0._id_5BAD - 1])) {
    var_0._id_0F6D[var_1] = var_0._id_0F6D[var_0._id_5BAD - 1];
    var_0._id_0F6D[var_1]._id_9479 = var_1;
    var_0._id_0F6D[var_0._id_5BAD - 1] = undefined;
    var_0._id_5BAD = var_0._id_0F6D.size;
  } else {
    var_0._id_0F6D[var_1] = undefined;
    _id_9480(var_0);
  }
}

_id_9480(var_0) {
  var_1 = [];

  foreach(var_3 in var_0._id_0F6D) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_0._id_0F6D = var_1;

  foreach(var_6, var_3 in var_0._id_0F6D)
  var_3._id_9479 = var_6;

  var_0._id_5BAD = var_0._id_0F6D.size;
}

_id_9483(var_0, var_1) {
  var_0 _id_0322::_id_9482(var_0._id_0F6D[var_0._id_5BAD - 1], var_1);
}

_id_9481(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1; var_2++)
    var_0 _id_0322::_id_9482(var_0._id_0F6D[var_2], var_0._id_0F6D[randomint(var_0._id_5BAD)]);
}

_id_43B5() {
  if(level._id_258F)
    return " + usereload";
  else
    return " + activate";
}

_id_4350(var_0, var_1) {
  var_2 = newhudelem();

  if(level._id_258F) {
    var_2.x = 68;
    var_2.y = 35;
  } else {
    var_2.x = 58;
    var_2.y = 95;
  }

  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2._id_00C6 = "left";
  var_2._id_01CA = "middle";

  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = level._id_3965;

  var_2 setclock(var_3, var_0, "hudStopwatch", 64, 64);
  return var_2;
}

_id_6916(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_08C4.size; var_2++) {
    if(level._id_08C4[var_2] != var_0) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

_id_6917(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_50D8.size; var_2++) {
    if(level._id_50D8[var_2] != var_0) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

scragentsetlateralcodemove(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_08C4.size; var_2++) {
    if(level._id_08C4[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level._id_08C4[var_2];
  }

  level._id_08C4 = var_1;
  var_3 = 0;

  for(var_2 = 0; var_2 < level._id_50D8.size; var_2++) {
    if(level._id_50D8[var_2] != var_0) {
      continue;
    }
    var_3 = 1;
  }

  if(!var_3)
    level._id_50D8[level._id_50D8.size] = var_0;
}

scragentsetobstacleavoid(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_50D8.size; var_2++) {
    if(level._id_50D8[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level._id_50D8[var_2];
  }

  level._id_50D8 = var_1;
  var_3 = 0;

  for(var_2 = 0; var_2 < level._id_08C4.size; var_2++) {
    if(level._id_08C4[var_2] != var_0) {
      continue;
    }
    var_3 = 1;
  }

  if(!var_3)
    level._id_08C4[level._id_08C4.size] = var_0;
}

_id_6257() {
  if(level._id_6256) {
    return;
  }
  if(isDefined(level._id_66C7)) {
    return;
  }
  if(getDvar("failure_disabled") == "1") {
    return;
  }
  level.player _id_02FA::_id_4CFE();
  level._id_6256 = 1;
  common_scripts\utility::flag_set("missionfailed");

  if(_id_0F44()) {
    return;
  }
  if(isDefined(level._id_6251)) {
    thread[[level._id_6251]]();
    return;
  }

  _id_0322::_id_6252(0);
  _func_056();
}

_id_8526(var_0) {
  level._id_6251 = var_0;
}

_id_4905(var_0) {
  thread _id_0324::_id_4904(var_0);
}

_id_4923(var_0, var_1, var_2, var_3, var_4) {
  _id_0324::_id_4922(var_0, var_1, var_2, var_3, var_4);
}

_id_4916(var_0) {
  var_1 = self._id_7E7F;

  if(!isDefined(var_1))
    return 0;

  if(isDefined(var_0) && !var_0) {
    foreach(var_3 in var_1._id_A037) {
      if(isDefined(var_3) && var_3 == self)
        return 0;
    }
  }

  if(isDefined(self._id_A390))
    return 1;

  return 0;
}

_id_419E(var_0, var_1) {
  var_2 = _getaiarray(var_0);
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(!isDefined(var_5.getentityvelocity)) {
      continue;
    }
    if(var_5.getentityvelocity != var_1) {
      continue;
    }
    var_3[var_3.size] = var_5;
  }

  return var_3;
}

_id_4085() {
  var_0 = _getaiarray("allies");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.getentityvelocity)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_408B(var_0) {
  if(!isDefined(var_0))
    var_0 = self.target;

  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  var_2 = _getnodearray(var_0, "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  var_2 = common_scripts\utility::_id_46B7(var_0, "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  var_2 = _getvehiclenodearray(var_0, "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  return var_1;
}

_id_3601() {
  if(isDefined(self.getentityvelocity)) {
    return;
  }
  if(!isDefined(self._id_6A31)) {
    return;
  }
  getlightshadowstate(self._id_6A31);
  self._id_6A31 = undefined;
}

_id_3602() {
  self._id_3241 = 1;
  _id_3601();
}

_id_2F19() {
  if(isDefined(self._id_668B)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }

  if(isDefined(self.freeentitysentient))
    _id_2F26(0);

  self clearfixednodesafevolume();

  if(!isDefined(self.getentityvelocity)) {
    return;
  }
  self._id_6A31 = self.getentityvelocity;
  _id_02A0::_id_7C6E();
}

_id_23B9() {
  _id_2F19();
}

_id_2169(var_0) {
  var_1 = level._id_24F8[_tolower(var_0)];

  if(isDefined(self.getentityvelocity) && var_1 == self.getentityvelocity)
    return 1;
  else
    return 0;
}

_id_419D() {
  var_0 = self.getentityvelocity;
  return var_0;
}

getlightshadowstate(var_0) {
  var_1 = _id_02A0::_id_08F9(var_0);
}

_id_57EC(var_0, var_1) {
  _id_02A0::_id_57ED(var_0, var_1);
}

_id_23AC(var_0, var_1) {
  _id_02A0::_id_23AD(var_0, var_1);
}

_id_239D(var_0) {
  foreach(var_2 in level._id_24FD)
  _id_02A0::_id_23AD(var_2, var_0);
}

_id_7D12() {
  thread _id_02A0::_id_2500();
}

_id_2F57() {
  self._id_7D12 = undefined;
  self notify("_disable_reinforcement");
}

_id_93E5() {
  self notify("_disable_reinforcement");
}

_id_93B4(var_0, var_1) {
  thread _id_02A0::_id_2506(var_0, var_1);
}

_id_8FED(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = "allies";

  thread _id_02A0::_id_2505(var_3, var_0, var_1, var_2);
}

_id_23C8(var_0) {
  _id_02A0::_id_24FE(var_0);
}

_id_8562(var_0, var_1, var_2) {
  _id_02A0::_id_2502(var_0, var_1, var_2);
}

_id_847F(var_0, var_1) {
  _id_02A0::_id_2501(var_0, var_1);
}

_id_4B29() {
  if(_id_02A0::_id_437D() == "axis")
    return isDefined(self.stopanimscripted) || isDefined(self.getentityvelocity);

  return isDefined(self.animrelative) || isDefined(self.getentityvelocity);
}

_id_4114() {
  return _id_02A0::_id_4115();
}

_id_4110() {
  return _id_02A0::_id_4111();
}

_id_3D58(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    waitframe();
  }
}

_id_3D55(var_0) {
  self endon("death");
  self endon("flashed");
  wait 0.2;
  self enablehealthshield(0);
  wait(var_0 + 2);
  self enablehealthshield(1);
}

_id_66DA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [0.8, 0.7, 0.7, 0.6];
  var_6 = [1.0, 0.8, 0.6, 0.6];

  foreach(var_12, var_8 in var_6) {
    var_9 = (var_1 - 0.85) / 0.15;

    if(var_9 > var_2)
      var_2 = var_9;

    if(var_2 < 0.25)
      var_2 = 0.25;

    var_10 = 0.3;

    if(var_1 > 1 - var_10)
      var_1 = 1.0;
    else
      var_1 = var_1 / (1 - var_10);

    if(var_4 != self.team)
      var_11 = var_1 * var_2 * 6.0;
    else
      var_11 = var_1 * var_2 * 3.0;

    if(var_11 < 0.25) {
      continue;
    }
    var_11 = var_8 * var_11;

    if(isDefined(self._id_6084) && var_11 > self._id_6084)
      var_11 = self._id_6084;

    self._id_3D4A = var_4;
    self notify("flashed");
    self._id_3D48 = gettime() + var_11 * 1000;
    self shellshock("flashbang", var_11);
    common_scripts\utility::flag_set("player_flashed");

    if(var_1 * var_2 > 0.5)
      thread _id_3D55(var_11);

    wait(var_5[var_12]);
  }

  thread _id_0322::_id_A01C(0.05);
}

_id_3D54() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4);

    if("1" == getDvar("noflash")) {
      continue;
    }
    if(_id_55DE(self)) {
      continue;
    }
    if(isDefined(self._id_999C)) {
      var_5 = 0.8;
      var_6 = 1.0 - var_5;
      self._id_999C = undefined;

      if(var_1 < var_6) {
        continue;
      }
      var_1 = (var_1 - var_6) / var_5;
    }

    var_7 = (var_1 - 0.85) / 0.15;

    if(var_7 > var_2)
      var_2 = var_7;

    if(var_2 < 0.25)
      var_2 = 0.25;

    var_8 = 0.3;

    if(var_1 > 1 - var_8)
      var_1 = 1.0;
    else
      var_1 = var_1 / (1 - var_8);

    if(var_4 != self.team)
      var_9 = var_1 * var_2 * 6.0;
    else
      var_9 = var_1 * var_2 * 3.0;

    if(var_9 < 0.25) {
      continue;
    }
    if(isDefined(self._id_6084) && var_9 > self._id_6084)
      var_9 = self._id_6084;

    self._id_3D4A = var_4;
    self notify("flashed");
    self._id_3D48 = gettime() + var_9 * 1000;
    self shellshock("flashbang", var_9);
    self lightsetoverrideenableforplayer("flashed", 0.1);
    common_scripts\utility::flag_set("player_flashed");
    thread _id_0322::_id_A01C(var_9);
    wait 0.1;
    self lightsetoverridedisableforplayer(var_9 - 0.1);

    if(var_1 * var_2 > 0.5)
      thread _id_3D55(var_9);

    if(var_9 > 2)
      thread _id_3D58(0.75);
    else
      thread _id_3D58(0.25);

    if(var_4 != "allies")
      thread _id_3D56(var_9, var_4);
  }
}

_id_3D56(var_0, var_1) {
  waitframe();
  var_2 = _getaiarray("allies");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distancesquared(var_2[var_3].origin, self.origin) < 122500) {
      var_4 = var_0 + _randomfloatrange(-1000, 1500);

      if(var_4 > 4.5)
        var_4 = 4.5;
      else if(var_4 < 0.25) {
        continue;
      }
      var_5 = gettime() + var_4 * 1000;

      if(!isDefined(var_2[var_3]._id_3D48) || var_2[var_3]._id_3D48 < var_5) {
        var_2[var_3]._id_3D4A = var_1;
        var_2[var_3] _id_3D44(var_4);
      }
    }
  }
}

_id_7DD3() {
  common_scripts\_createfx::restart_fx_looper();
}

_id_6F22(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level._id_2807)) {
    var_1 = level._id_2807[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1)
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

_id_7DD4(var_0) {
  var_0 = var_0 + "";

  if(isDefined(level._id_2807)) {
    var_1 = level._id_2807[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1)
      var_3 _id_7DD3();

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
      var_6 _id_7DD3();
    }
  }
}

_id_44F6(var_0) {
  var_1 = [];

  if(isDefined(level.createfxbyfxid)) {
    var_2 = level.createfxbyfxid[var_0];

    if(isDefined(var_2))
      var_1 = var_2;
  } else {
    for(var_3 = 0; var_3 < level.createfxent.size; var_3++) {
      if(level.createfxent[var_3].v["fxid"] == var_0)
        var_1[var_1.size] = level.createfxent[var_3];
    }
  }

  return var_1;
}

_id_5095(var_0) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");

  if(var_0) {
    self._id_6A4E = self getthreatbiasgroup();
    var_1 = undefined;
    _createthreatbiasgroup("ignore_everybody");
    self setthreatbiasgroup("ignore_everybody");
    var_2 = [];
    var_2["axis"] = "allies";
    var_2["allies"] = "axis";
    var_3 = _getaiarray(var_2[self.team]);
    var_4 = [];

    for(var_5 = 0; var_5 < var_3.size; var_5++)
      var_4[var_3[var_5] getthreatbiasgroup()] = 1;

    var_6 = getarraykeys(var_4);

    for(var_5 = 0; var_5 < var_6.size; var_5++)
      _setthreatbias(var_6[var_5], "ignore_everybody", 0);
  } else {
    var_1 = undefined;

    if(self._id_6A4E != "")
      self setthreatbiasgroup(self._id_6A4E);

    self._id_6A4E = undefined;
  }
}

_id_A302() {
  _id_032A::_id_A380();
}

_id_A39A() {
  thread _id_032A::_id_A39B();
}

_id_A358(var_0) {
  _id_032A::_id_A35A(var_0);
}

_id_A360(var_0) {
  _id_032A::_id_A361(var_0);
}

_id_A313(var_0, var_1) {
  _id_0323::_id_A381(var_0, var_1);
}

_id_4883(var_0) {
  return bulletTrace(var_0, var_0 + (0, 0, -100000), 0, self)["position"];
}

_id_20B9(var_0) {
  self._id_729D = self._id_729D + var_0;
  self notify("update_health_packets");

  if(self._id_729D >= 3)
    self._id_729D = 3;
}

_id_4714(var_0) {
  var_1 = _id_4715(var_0);
  return var_1[0];
}

_id_4715(var_0) {
  return _id_032A::_id_063F(var_0);
}

_id_2D90(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0967();

  if(!isDefined(level._id_91E2))
    level._id_91E2 = [];

  level._id_91E2[var_0] = _id_0968(var_0, var_1, var_2, var_3, [var_4], var_5);
}

_id_0966(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0967();
  var_0 = _tolower(var_0);

  if(isDefined(var_4)) {
    if(var_4.size > 2) {
      var_6 = [];
      var_6[0] = var_4[0];
      var_6[1] = var_4[1];
      var_4 = var_6;
    }

    if(!isDefined(level._id_929E))
      level._id_929E = [];

    foreach(var_8 in var_4) {
      if(!common_scripts\utility::_id_0F79(level._id_929E, var_8))
        level._id_929E[level._id_929E.size] = var_8;
    }
  }

  if(isDefined(level._id_91E2) && isDefined(level._id_91E2[var_0]))
    var_11 = level._id_91E2[var_0];
  else
    var_11 = _id_0968(var_0, var_1, var_2, var_3, var_4, var_5);

  if(!isDefined(var_1)) {
    if(!isDefined(level._id_91E2)) {} else if(!issubstr(var_0, "no_game")) {
      if(!isDefined(level._id_91E2[var_0]))
        return;
    }
  }

  level._id_9210[level._id_9210.size] = var_11;
  level._id_918B[var_0] = var_11;
}

_id_096A(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    level._id_918B[var_0]["visionset"] = var_1;

  if(isDefined(var_2))
    level._id_918B[var_0]["lightset"] = var_2;

  if(isDefined(var_3))
    level._id_918B[var_0]["clut"] = var_3;
}

_id_8594(var_0, var_1) {
  if(!isDefined(level._id_918B)) {
    return;
  }
  if(!isDefined(level._id_918B[var_0])) {
    return;
  }
  var_0 = _tolower(var_0);

  if(var_1.size > 2) {
    var_2 = [];
    var_2[0] = var_1[0];
    var_2[1] = var_1[1];
    var_1 = var_2;
  }

  if(!isDefined(level._id_929E))
    level._id_929E = [];

  foreach(var_4 in var_1) {
    if(!common_scripts\utility::_id_0F79(level._id_929E, var_4))
      level._id_929E[level._id_929E.size] = var_4;
  }

  level._id_918B[var_0]["transients_to_load"] = var_1;
}

_id_55C4() {
  return issubstr(level._id_9267, "no_game");
}

_id_0968(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_6["name"] = var_0;
  var_6["start_func"] = var_1;
  var_6["start_loc_string"] = var_2;
  var_6["logic_func"] = var_3;
  var_6["transients_to_load"] = var_4;
  var_6["catchup_function"] = var_5;
  return var_6;
}

_id_0967() {
  if(!isDefined(level._id_9210))
    level._id_9210 = [];
}

_id_5CB3() {
  return level._id_9210.size > 1;
}

_id_845D(var_0) {
  level._id_2BB9 = var_0;
}

_id_2BB8(var_0) {
  level._id_2BB8 = var_0;
}

_id_5D9B(var_0, var_1, var_2, var_3) {
  thread _id_0322::_id_5D9C(var_0, var_1, var_2, var_3);
}

_id_AA4B(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_5 = anglesToForward((0, var_1[1], 0));
  return vectordot(var_5, var_4) >= var_3;
}

_id_415F(var_0, var_1, var_2) {
  var_3 = vectorNormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

_id_AA4D(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3] getEye();
    var_2 = common_scripts\utility::within_fov(var_4, level.players[var_3] getplayerangles(), var_0, var_1);

    if(!var_2)
      return 0;
  }

  return 1;
}

_id_A643(var_0, var_1) {
  var_2 = var_1 * 1000 - (gettime() - var_0);
  var_2 = var_2 * 0.001;

  if(var_2 > 0)
    wait(var_2);
}

_id_1673() {
  anim.hasweapon = gettime();
}

_id_2EC5(var_0) {
  if(!isDefined(level._id_6F46))
    level._id_6F46 = 0;

  level._id_6F46++;

  if(self == level)
    var_1 = level.player;
  else
    var_1 = self;

  if(isDefined(var_1._id_2A3F) && _id_02A8::_id_95FE(var_1))
    level notify("dialogue started");

  var_2 = _getsndaliasvalue(var_0, "squelchname");

  if(self == level || isDefined(var_2) && var_2 != "" || isDefined(level.player) && self == level.player) {
    if(isDefined(_id_037B::_id_77D8()))
      _id_037B::_id_8DB8(1);

    _id_78B4(var_0, undefined, var_2);

    if(isDefined(_id_037B::_id_77D8()))
      _id_037B::_id_8DB8(0);

    level._id_6F46--;
    return;
  }

  _id_1673();

  if(var_1 != level.player && (!isDefined(self._id_0EC4) || !isDefined(level.scr_sound[self._id_0EC4]) || !isDefined(level.scr_sound[self._id_0EC4][var_0]))) {
    animscripts\face::_id_7497("auto", var_0, 1, var_0);
    var_3 = 0;
  } else
    _id_0293::_id_0E76(self, var_0);

  level._id_6F46--;
}

_id_2EC7(var_0, var_1) {
  var_2 = _getsndaliasvalue(var_0, "squelchname");

  if(self == level || isDefined(var_2) && var_2 != "" || isDefined(level.player) && self == level.player) {
    if(isDefined(_id_037B::_id_77D8()))
      _id_037B::_id_8DB8(1);

    _id_78B4(var_0, undefined, var_2);

    if(isDefined(_id_037B::_id_77D8()))
      _id_037B::_id_8DB8(0);

    return;
  }

  thread _id_0290::_id_0AD1(var_1, 1);
  _id_1673();
  _id_0293::_id_0E76(self, var_0);
  thread _id_0290::_id_0AD1(var_1, 0);
}

_id_4020(var_0, var_1) {
  _id_1673();
  _id_0293::_id_0E0E(self, var_0, undefined, undefined, var_1);
}

_id_78B4(var_0, var_1, var_2) {
  if(!isDefined(level._id_7306)) {
    var_3 = spawn("script_origin", (0, 0, 0));
    var_3 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level._id_7306 = var_3;
  }

  _id_1673();

  if(!isDefined(var_1))
    return level._id_7306 _id_3F12(::_id_78B9, var_0, var_2);
  else
    return level._id_7306 _id_3F18(var_1, ::_id_78B9, var_0, var_2);
}

_id_78B9(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "none";

  level._id_7308 = 0;

  if(var_1 != "none" && isDefined(level.forceusehintoff["squelches"][var_1]))
    play_sound_on_tag(level.forceusehintoff["squelches"][var_1]["on"], undefined, 1);

  var_2 = 0;
  level.player notify(var_0);

  if(isDefined(level.forceusehintoff[var_0]))
    var_2 = play_sound_on_tag(level.forceusehintoff[var_0], undefined, 1);
  else
    var_2 = play_sound_on_tag(var_0, undefined, 1);

  if(var_1 != "none" && isDefined(level.forceusehintoff["squelches"][var_1]))
    thread _id_78C1(var_1);

  return var_2;
}

_id_78B7(var_0) {
  if(!isDefined(level._id_7307))
    level._id_7307 = [];

  var_1 = spawn("script_origin", (0, 0, 0));
  level._id_7307[level._id_7307.size] = var_1;
  var_1 endon("death");
  thread _id_2D1A(var_1, "sounddone");
  var_1.origin = level._id_7306.origin;
  var_1.angles = level._id_7306.angles;
  var_1 linkto(level._id_7306);
  var_1 playSound(level.forceusehintoff[var_0], "sounddone");

  if(!isDefined(_id_0322::_id_A65C(var_1)))
    var_1 stopsounds();

  waitframe();
  level._id_7307 = common_scripts\utility::_id_0F93(level._id_7307, var_1);
  var_1 delete();
}

_id_78BE() {
  if(!isDefined(level._id_7306)) {
    return;
  }
  level._id_7306 delete();
}

_id_78B8() {
  if(!isDefined(level._id_7307)) {
    return;
  }
  foreach(var_1 in level._id_7307) {
    if(isDefined(var_1)) {
      var_1 stopsounds();
      waitframe();
      var_1 delete();
    }
  }

  level._id_7307 = undefined;
}

_id_78B5() {
  if(!isDefined(level._id_7306)) {
    return;
  }
  level._id_7306 _id_3F14();
}

_id_78BC(var_0) {
  if(!isDefined(level._id_7306)) {
    return;
  }
  if(!isDefined(level._id_7306._id_3F12)) {
    return;
  }
  var_1 = [];
  var_2 = 0;
  var_3 = level._id_7306._id_3F12.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(var_4 == 0 && isDefined(level._id_7306._id_3F12[0]._id_3F15) && isDefined(level._id_7306._id_3F12[0]._id_3F15)) {
      var_1[var_1.size] = level._id_7306._id_3F12[var_4];
      continue;
    }

    if(isDefined(level._id_7306._id_3F12[var_4]._id_6E55) && level._id_7306._id_3F12[var_4]._id_6E55 == var_0) {
      level._id_7306._id_3F12[var_4] notify("death");
      level._id_7306._id_3F12[var_4] = undefined;
      var_2 = 1;
      continue;
    }

    var_1[var_1.size] = level._id_7306._id_3F12[var_4];
  }

  if(var_2)
    level._id_7306._id_3F12 = var_1;
}

_id_78B6(var_0) {
  if(!isDefined(level._id_7306)) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
    level._id_7306 = var_1;
  }

  level._id_7306 play_sound_on_tag(level.forceusehintoff[var_0], undefined, 1);
}

_id_78BD(var_0) {
  return _id_78B4(var_0, 0.05);
}

_id_8CD3(var_0, var_1) {
  var_2 = _getsndaliasvalue(var_0, "squelchname");
  _id_0322::_id_097A(var_0);
  _id_78B4(var_0, var_1, var_2);
}

_id_8CD4(var_0) {
  _id_0322::_id_097A(var_0);
  _id_78BE();
  _id_78B6(var_0);
}

_id_8CD5(var_0) {
  _id_0322::_id_097A(var_0);
  _id_78B7(var_0);
}

_id_8CD0(var_0) {
  _id_0322::_id_0977(var_0);
  _id_2EC5(var_0);
}

_id_8CD1(var_0) {
  _id_0322::_id_0978(var_0);
  _id_4020(var_0);
}

_id_78C1(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 0.1;

  level._id_7308 = 1;
  wait(var_1);

  if(isDefined(level._id_7306) && level._id_7308 == 1)
    level._id_7306 _id_3F12(::play_sound_on_tag, level.forceusehintoff["squelches"][var_0]["off"], undefined, 1);
}

_id_78BA(var_0, var_1) {
  _id_78B4(var_0, undefined, var_1);
}

_id_4D8D(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(isDefined(var_1) && var_1 == 1)
    var_3._id_1739 = newhudelem();

  var_3._id_35D5 = newhudelem();
  var_3 _id_4DA1(var_2);
  var_3._id_35D5 settext(var_0);
  return var_3;
}

_id_4D92() {
  self notify("death");

  if(isDefined(self._id_35D5))
    self._id_35D5 destroy();

  if(isDefined(self._id_1739))
    self._id_1739 destroy();
}

_id_4DA1(var_0) {
  if(level._id_258F)
    self._id_35D5.fontscale = 2;
  else
    self._id_35D5.fontscale = 1.6;

  self._id_35D5.x = 0;
  self._id_35D5.y = -40;
  self._id_35D5.alignx = "center";
  self._id_35D5.aligny = "bottom";
  self._id_35D5._id_00C6 = "center";
  self._id_35D5._id_01CA = "middle";
  self._id_35D5.sort = 1;
  self._id_35D5.alpha = 0.8;

  if(!isDefined(self._id_1739)) {
    return;
  }
  self._id_1739.x = 0;
  self._id_1739.y = -40;
  self._id_1739.alignx = "center";
  self._id_1739.aligny = "middle";
  self._id_1739._id_00C6 = "center";
  self._id_1739._id_01CA = "middle";
  self._id_1739.sort = -1;

  if(level._id_258F)
    self._id_1739 setshader("popmenu_bg", 650, 52);
  else
    self._id_1739 setshader("popmenu_bg", 650, 42);

  if(!isDefined(var_0))
    var_0 = 0.5;

  self._id_1739.alpha = var_0;
}

_id_945F(var_0) {
  return "" + var_0;
}

_id_561B(var_0) {
  var_1 = _float(var_0);

  if(_func_2C6(var_0, " ")) {
    while(_func_2C6(var_0, " "))
      var_0 = getsubstr(var_0, 1, 9999);
  }

  if(_func_2C6(var_0, "-.") || _func_2C6(var_0, "."))
    var_0 = "0" + _id_945F(var_0);

  if(issubstr(var_0, ".")) {
    while(_isendstr(var_0, "0"))
      var_0 = _func_2FF(var_0, "0");
  } else
    var_0 = _id_945F(var_0);

  return _id_945F(var_1) == var_0;
}

_id_5099(var_0, var_1) {
  _setignoremegroup(var_0, var_1);
  _setignoremegroup(var_1, var_0);
}

_id_092D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["function"] = var_1;
  var_5["param1"] = var_2;
  var_5["param2"] = var_3;
  var_5["param3"] = var_4;
  level._id_8FB8[var_0][level._id_8FB8[var_0].size] = var_5;
}

_id_7C91(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_8FB8[var_0].size; var_3++) {
    if(level._id_8FB8[var_0][var_3]["function"] != var_1)
      var_2[var_2.size] = level._id_8FB8[var_0][var_3];
  }

  level._id_8FB8[var_0] = var_2;
}

_id_38E2(var_0, var_1) {
  if(!isDefined(level._id_8FB8))
    return 0;

  for(var_2 = 0; var_2 < level._id_8FB8[var_0].size; var_2++) {
    if(level._id_8FB8[var_0][var_2]["function"] == var_1)
      return 1;
  }

  return 0;
}

_id_7CB5(var_0) {
  var_1 = [];

  foreach(var_3 in self._id_8FB9) {
    if(var_3["function"] == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self._id_8FB9 = var_1;
}

_id_0961(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in self._id_8FB9) {
    if(var_7["function"] == var_0)
      return;
  }

  var_9 = [];
  var_9["function"] = var_0;
  var_9["param1"] = var_1;
  var_9["param2"] = var_2;
  var_9["param3"] = var_3;
  var_9["param4"] = var_4;
  var_9["param5"] = var_5;
  self._id_8FB9[self._id_8FB9.size] = var_9;
}

_id_091B(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in self._id_2A87) {
    if(var_7["function"] == var_0)
      return;
  }

  var_9 = [];
  var_9["function"] = var_0;
  var_9["param1"] = var_1;
  var_9["param2"] = var_2;
  var_9["param3"] = var_3;
  var_9["param4"] = var_4;
  var_9["param5"] = var_5;
  self._id_2A87[self._id_2A87.size] = var_9;
}

_id_0F7B(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] delete();
}

_id_0F87(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] kill();
}

_id_5093(var_0) {
  self endon("death");
  self._id_00D3 = 1;

  if(isDefined(var_0))
    wait(var_0);
  else
    wait 0.5;

  self._id_00D3 = 0;
}

_id_08A3(var_0) {
  var_1 = _getent(var_0, "targetname");

  if(isDefined(var_1))
    var_1 _id_089F();
}

_id_08A2(var_0) {
  var_1 = _getent(var_0, "script_noteworthy");

  if(isDefined(var_1))
    var_1 _id_089F();
}

_id_2F68(var_0) {
  var_1 = _getent(var_0, "targetname");
  var_1 common_scripts\utility::_id_9D9F();
}

_id_2F67(var_0) {
  var_1 = _getent(var_0, "script_noteworthy");
  var_1 common_scripts\utility::_id_9D9F();
}

_id_364F(var_0) {
  var_1 = _getent(var_0, "targetname");
  var_1 common_scripts\utility::_id_9DA3();
}

_id_364E(var_0) {
  var_1 = _getent(var_0, "script_noteworthy");
  var_1 common_scripts\utility::_id_9DA3();
}

_id_5590() {
  return isDefined(level._id_4CB5[_id_4067()]);
}

_id_4067() {
  if(!isDefined(self._id_A01E))
    screenshakeonentity();

  return self._id_A01E;
}

screenshakeonentity() {
  self._id_A01E = "ai" + level._id_0AB5;
  level._id_0AB5++;
}

_id_5FAA() {
  level._id_4CB5[self._id_A01E] = 1;
}

_id_A03B() {
  level._id_4CB5[self._id_A01E] = undefined;
}

_id_41C2() {
  var_0 = [];
  var_1 = _getaiarray("allies");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] _id_5590())
      var_0[var_0.size] = var_1[var_2];
  }

  return var_0;
}

_id_85A2(var_0, var_1) {
  var_2 = _getaiarray(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_2[var_3]._id_0118 = var_1;
}

_id_7C7F(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_7C92(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] _id_5590()) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

_id_7C7B(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4.getentityvelocity)) {
      continue;
    }
    if(var_4.getentityvelocity == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_7CA8(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(!isDefined(var_4._id_0165)) {
      continue;
    }
    if(var_4._id_0165 == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_40F8(var_0, var_1) {
  var_2 = _id_419E("allies", var_0);
  var_2 = _id_7C92(var_2);

  if(!isDefined(var_1))
    var_3 = level.player.origin;
  else
    var_3 = var_1;

  return common_scripts\utility::_id_4461(var_3, var_2);
}

_id_7CC6(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].classname, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

_id_7CC7(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!issubstr(var_0[var_3].model, var_1)) {
      continue;
    }
    var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

_id_40F9(var_0, var_1, var_2) {
  var_3 = _id_419E("allies", var_0);
  var_3 = _id_7C92(var_3);

  if(!isDefined(var_2))
    var_4 = level.player.origin;
  else
    var_4 = var_2;

  var_3 = _id_7CC6(var_3, var_1);
  return common_scripts\utility::_id_4461(var_4, var_3);
}

_id_7774(var_0, var_1) {
  for(;;) {
    var_2 = _id_40F8(var_0);

    if(!isalive(var_2)) {
      wait 1;
      continue;
    }

    var_2 getlightshadowstate(var_1);
    return;
  }
}

_id_53E4(var_0, var_1) {
  for(;;) {
    var_2 = _id_40F8(var_0);

    if(!isalive(var_2)) {
      return;
    }
    var_2 getlightshadowstate(var_1);
    return;
  }
}

_id_53E5(var_0, var_1, var_2) {
  for(;;) {
    var_3 = _id_40F9(var_0, var_2);

    if(!isalive(var_3)) {
      return;
    }
    var_3 getlightshadowstate(var_1);
    return;
  }
}

_id_7775(var_0, var_1, var_2) {
  for(;;) {
    var_3 = _id_40F9(var_0, var_2);

    if(!isalive(var_3)) {
      wait 1;
      continue;
    }

    var_3 getlightshadowstate(var_1);
    return;
  }
}

_id_7E97(var_0) {
  self orientmode("face angle", var_0);
  self._id_00EE = 1;
}

_id_7E98() {
  self._id_00EE = 0;
}

_id_53E7(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [];

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_3 || !issubstr(var_6.classname, var_2)) {
      var_4[var_4.size] = var_6;
      continue;
    }

    var_3 = 1;
    var_6 getlightshadowstate(var_1);
  }

  return var_4;
}

_id_53E6(var_0, var_1) {
  var_2 = 0;
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_2) {
      var_3[var_3.size] = var_5;
      continue;
    }

    var_2 = 1;
    var_5 getlightshadowstate(var_1);
  }

  return var_3;
}

_id_A65B(var_0) {
  _id_0322::_id_A660(var_0, "script_noteworthy");
}

_id_A65E(var_0) {
  _id_0322::_id_A660(var_0, "targetname");
}

_id_A64C(var_0, var_1) {
  if(common_scripts\utility::_id_3C77(var_0)) {
    return;
  }
  level endon(var_0);
  wait(var_1);
}

_id_A652(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_A661(var_0) {
  self endon("trigger");
  wait(var_0);
}

_id_A648(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = [];
  var_3 = common_scripts\utility::_id_0F73(var_3, getEntArray(var_0, "targetname"));
  var_3 = common_scripts\utility::_id_0F73(var_3, getEntArray(var_1, "targetname"));

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_2 thread _id_0322::_id_37B0(var_3[var_4]);

  var_2 waittill("done");
}

_id_3441(var_0) {
  var_1 = _id_02FC::_id_904F(var_0);
  return var_1;
}

_id_3440(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_1 = _id_02FC::_id_904F(var_0);
  var_1[[level._id_3431]]();
  var_1._id_8FB8 = var_0._id_8FB9;
  var_1 thread _id_02FC::_id_7F71();
  var_1._id_0186 = var_0;
  return var_1;
}

_id_9531(var_0) {
  return _id_02FC::_id_9056(var_0);
}

_id_9532(var_0) {
  return _id_02FC::_id_9058(var_0);
}

_id_845C() {
  if(_id_0290::_id_0AAE() && self.type != "dog" && self.type != "civilian") {
    self._id_011E = animscripts\shg_asm\soldier\common\shared::_id_428A();
    self._id_011D = animscripts\shg_asm\soldier\common\shared::_id_4289();
  } else {
    self._id_011E = 192;
    self._id_011D = 192;
  }
}

_id_2714(var_0) {
  if(var_0 == "on")
    _id_3612();
  else
    _id_2F2B();
}

_id_3612() {
  if(self.type == "dog" || self.type == "civilian") {
    return;
  }
  _id_0290::_id_0AD4("walk");
}

_id_2F2B() {
  _id_0290::_id_0AD4("none");
}

_id_3641() {
  _id_3612();
  var_0 = "sneak";

  if(animscripts\shg_asm\soldier\common\shared::_id_560C())
    var_0 = "smg_sneak";

  _id_0290::_id_0AD3(var_0);
}

_id_2F5A() {
  _id_2F2B();
  _id_0290::_id_0AC3();
}

_id_3624() {
  if(self.type == "dog" || self.type == "civilian") {
    return;
  }
  _id_0290::_id_0ACF(1);
}

_id_2F3B() {
  if(self.type == "dog" || self.type == "civilian") {
    return;
  }
  _id_0290::_id_0ACF(0);
}

_id_3640() {
  if(self.type == "dog") {
    return;
  }
  _id_0290::_id_0A9E(1);
}

_id_2F59() {
  if(self.type == "dog") {
    return;
  }
  _id_0290::_id_0A9E(0);
}

_id_363C() {
  self._id_1DC6 = 1;
}

_id_2F56() {
  self._id_1DC6 = undefined;
}

_id_270E(var_0) {
  if(!isDefined(var_0))
    self._id_2712 = undefined;
  else {
    self._id_2712 = var_0;

    if(!isDefined(var_0.origin))
      return;
  }
}

forceviewmodelanimationclear(var_0) {
  if(isDefined(var_0) && var_0)
    self._id_3E2E = 1;
  else
    self._id_3E2E = undefined;
}

_id_30BD(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    [[var_0]](var_1);
  else
    [[var_0]]();

  if(isDefined(var_3))
    [[var_2]](var_3);
  else
    [[var_2]]();
}

setanimstate(var_0, var_1) {
  if(isDefined(var_1))
    self notify(var_0, var_1);
  else
    self notify(var_0);
}

_id_A743(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3 endon("complete");
  var_3 _id_2CED(var_2, ::setanimstate, "complete");
  self waittillmatch(var_0, var_1);
  return var_0;
}

_id_2D36(var_0) {
  var_0 notify("deleted");
  var_0 delete();
}

_id_3C59(var_0) {
  if(!isDefined(self._id_9ABD))
    self._id_9ABD = [];

  if(isDefined(self._id_9ABD[var_0._id_A01E]))
    return 0;

  self._id_9ABD[var_0._id_A01E] = 1;
  return 1;
}

_id_4417(var_0) {
  return level.settenthstimer[self._id_0EC4][var_0];
}

_id_4B52(var_0) {
  return isDefined(level.settenthstimer[self._id_0EC4][var_0]);
}

_id_4418(var_0, var_1) {
  return level.settenthstimer[var_1][var_0];
}

_id_4419(var_0) {
  return level.settenthstimer["generic"][var_0];
}

_id_0930(var_0, var_1, var_2) {
  if(!isDefined(level._id_9D88)) {
    level._id_9D88 = [];
    level._id_9D87 = [];
  }

  level._id_9D88[var_0] = var_1;
  precachestring(var_1);

  if(isDefined(var_2))
    level._id_9D87[var_0] = var_2;
}

_id_8BCF(var_0) {
  thread _id_0322::_id_8C00(var_0);
}

_id_4CE6(var_0) {
  var_0._id_9A01 = 1;
}

_id_3BCB(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_0, 0, var_1, 48);

  for(;;) {
    var_2 waittill("trigger", var_3);
    level.player dodamage(5, var_0);
  }
}

_id_2412(var_0, var_1) {
  _setthreatbias(var_0, var_1, 0);
  _setthreatbias(var_1, var_0, 0);
}

_id_99AA() {}

_id_0F74(var_0, var_1) {
  if(!var_0.size)
    return var_1;

  var_2 = getarraykeys(var_1);

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_0[var_2[var_3]] = var_1[var_2[var_3]];

  return var_0;
}

_id_84E5(var_0) {
  self._id_00D2 = var_0;
}

setadditiveviewmodelanim(var_0) {
  self._id_00AE = var_0;
}

_id_9E0A() {
  var_0 = self._id_3975;

  for(;;) {
    var_1 = self dospawn();

    if(_id_8FA3(var_1)) {
      wait 1;
      continue;
    }

    return var_1;
  }
}

_id_840B(var_0) {
  self._id_0013 = var_0;
}

_id_8576(var_0, var_1, var_2) {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0AD5(var_0, var_1, var_2);
    return;
  }

  if(isDefined(var_1))
    self._id_0CB6 = var_1;
  else
    self._id_0CB6 = 1;

  _id_2F69();
  self._id_7F6A = level.settenthstimer[self._id_0EC4][var_0];
  self._id_A7B7 = self._id_7F6A;
}

_id_8474() {
  self._id_0794._id_64B0 = "walk";
  _id_0290::_id_0ACD("arrivals", 0);
  _id_0290::_id_0ACD("exits", 0);
  self.sayteam = 1;
}

_id_8439(var_0, var_1, var_2, var_3) {}

_id_852F(var_0, var_1, var_2) {}

_id_84B0(var_0) {
  var_1 = level.settenthstimer["generic"][var_0];

  if(_isarray(var_1))
    self._id_90D1 = var_1;
  else
    self._id_90D1[0] = var_1;
}

_id_84E1(var_0) {
  var_1 = level.settenthstimer[self._id_0EC4][var_0];

  if(_isarray(var_1))
    self._id_90D1 = var_1;
  else
    self._id_90D1[0] = var_1;
}

_id_23BB() {
  self._id_90D1 = undefined;
  self notify("stop_specialidle");
}

_id_84B1(var_0, var_1) {
  _id_84B2(var_0, undefined, var_1);
}

_id_23BC() {
  self notify("movemode");
  _id_3650();
  self._id_7F6A = undefined;
  self._id_A7B7 = undefined;
}

_id_84B2(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2)
    self._id_0CB6 = 1;
  else
    self._id_0CB6 = undefined;

  _id_2F69();
  self._id_7F6A = level.settenthstimer["generic"][var_0];
  self._id_A7B7 = self._id_7F6A;

  if(isDefined(var_1)) {
    self._id_7F69 = level.settenthstimer["generic"][var_1];
    self._id_A7B6 = self._id_7F69;
  } else {
    self._id_7F69 = undefined;
    self._id_A7B6 = undefined;
  }
}

_id_8577(var_0, var_1, var_2) {
  self notify("movemode");

  if(!isDefined(var_2) || var_2)
    self._id_0CB6 = 1;
  else
    self._id_0CB6 = undefined;

  _id_2F69();
  self._id_7F6A = level.settenthstimer[self._id_0EC4][var_0];
  self._id_A7B7 = self._id_7F6A;

  if(isDefined(var_1)) {
    self._id_7F69 = level.settenthstimer[self._id_0EC4][var_1];
    self._id_A7B6 = self._id_7F69;
  } else {
    self._id_7F69 = undefined;
    self._id_A7B6 = undefined;
  }
}

_id_23C9(var_0) {
  if(_id_0290::_id_0AAE())
    _id_0290::_id_0A79(var_0);
  else {
    self notify("clear_run_anim");
    self notify("movemode");

    if(self.type == "dog") {
      self._id_0794._id_64B0 = "run";
      _id_0290::_id_0ACD("arrivals", 1);
      _id_0290::_id_0ACD("exits", 1);
      self.sayteam = undefined;
      return;
    }

    if(!isDefined(self._id_202F))
      _id_3650();

    self._id_0CB6 = undefined;
    self._id_7F6A = undefined;
    self._id_A7B7 = undefined;
    self._id_7F69 = undefined;
    self._id_A7B6 = undefined;
  }
}

_id_2B64(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
  return getdvarfloat(var_0);
}

_id_6FA8(var_0, var_1, var_2) {
  self endon("parked");
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

    if(self._id_003B == "script_vehicle") {
      var_6 = self vehicle_getspeed();

      if(var_6 < var_4) {
        var_7 = var_6 / var_4;
        var_2 = var_5 * var_7;
      }
    }

    var_8 = distancesquared(self.origin, level.player.origin);
    var_7 = var_3 / var_8;

    if(var_7 > 1)
      var_7 = 1;

    var_2 = var_2 * var_7;
    var_9 = var_2[0] + var_2[1] + var_2[2];

    if(var_9 > 0.025)
      _physicsjitter(self.origin, var_0, var_1, var_2[2], var_2[2] * 2.0);
  }
}

getbottomarc(var_0) {
  self setgoalentity(var_0);
}

_id_089F(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    _id_08A1(var_2);
  else
    common_scripts\utility::_id_0FB2(getEntArray(var_0, var_1), ::_id_08A1, var_2);
}

_id_08A1(var_0) {
  self notify("trigger", var_0);
}

getmodelfromentity() {
  self delete();
}

_id_7CA5(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(var_3 _id_4B29())
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_23AE() {
  _id_23D0("axis");
  _id_23D0("allies");
}

_id_23D0(var_0) {
  level._id_292C[var_0]["r"] = undefined;
  level._id_292C[var_0]["b"] = undefined;
  level._id_292C[var_0]["c"] = undefined;
  level._id_292C[var_0]["y"] = undefined;
  level._id_292C[var_0]["p"] = undefined;
  level._id_292C[var_0]["o"] = undefined;
  level._id_292C[var_0]["g"] = undefined;
}

_id_4314() {
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

_id_67F1(var_0, var_1) {
  self endon("death");

  if(var_1 > 0)
    wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
}

_id_48D9() {
  if(!isDefined(self._id_01D0) || self._id_01D0 == "none") {
    return;
  }
  if(_isai(self))
    animscripts\shared::_id_7008(self._id_01D0, "none");
  else if(!isDefined(self._id_48DA) && self._id_01D0 != "none") {
    self._id_48DA = 1;
    _id_2E38(self._id_01D0);
    self detach(_getweaponmodel(self._id_01D0), "tag_weapon_right");
  }
}

_id_48D8() {
  if(_isai(self)) {
    if(isDefined(self._id_5C10) && self._id_01D0 != self._id_5C10)
      self._id_01D0 = self._id_5C10;

    animscripts\shared::_id_7008(self._id_01D0, "right");
  } else if(isDefined(self._id_48DA)) {
    self._id_48DA = undefined;
    self attach(_getweaponmodel(self._id_01D0), "tag_weapon_right");
    _id_A0D9(self._id_01D0);
  }
}

_id_A0D9(var_0) {
  if(isDefined(var_0) && var_0 != "none") {
    var_1 = _getweaponandattachmentmodels(var_0);
    var_2 = common_scripts\utility::_id_0F9A(var_1, 0);

    foreach(var_4 in var_2)
    self attach(var_4["worldModel"], var_4["worldAttachTag"]);

    self hideweapontags(var_0);
  }
}

_id_2E38(var_0) {
  if(isDefined(var_0) && var_0 != "none") {
    var_1 = _getweaponandattachmentmodels(var_0);
    var_2 = common_scripts\utility::_id_0F9A(var_1, 0);

    foreach(var_4 in var_2)
    self detach(var_4["worldModel"], var_4["worldAttachTag"], 0);
  }
}

_id_1136(var_0) {
  var_1 = level.player getcurrentweapon();
  var_2 = _getweaponandattachmentmodels(var_1);
  var_3 = var_2[0]["weapon"];
  var_4 = common_scripts\utility::_id_0F9A(var_2, 0);
  var_0 attach(var_3, "TAG_WEAPON_RIGHT", 1);

  foreach(var_6 in var_4)
  var_0 attach(var_6["attachment"], var_6["attachTag"]);

  var_0 hideweapontags(var_1);
}

_id_7004(var_0, var_1) {
  if(!animscripts\shared::_id_0B59(var_0))
    animscripts\init::_id_5368(var_0);

  animscripts\shared::_id_7008(var_0, var_1);
}

_id_3E2F(var_0, var_1, var_2) {
  if(!animscripts\init::_id_5853(var_0))
    animscripts\init::_id_5368(var_0);

  var_3 = self._id_01D0 != "none";
  var_4 = 0;
  var_5 = var_1 == "sidearm";
  var_6 = var_1 == "secondary";

  if(var_3 && var_4 != var_5) {
    if(var_4)
      var_7 = "none";
    else if(var_6)
      var_7 = "back";
    else
      var_7 = "chest";

    animscripts\shared::_id_7008(self._id_01D0, var_7);
    self._id_5C10 = self._id_01D0;
  } else
    self._id_5C10 = var_0;

  animscripts\shared::_id_7008(var_0, "right");

  if(var_5)
    self._id_8C3C = var_0;
  else if(var_6)
    self.botclearscriptenemy = var_0;
  else
    self.primaryweapon = var_0;

  self._id_01D0 = var_0;
  self._id_1D83 = _weaponclipsize(self._id_01D0);
  animscripts\shg_asm\asm_init::_id_1074(var_2);
  self notify("weapon_switch_done");
}

_id_5C8D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_0322::_id_5C8F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

_id_5C8E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_0322::_id_5C8F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

_id_5C8B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_9 = _id_429A();
  var_10 = spawn("script_origin", (0, 0, 0));
  var_10.origin = var_9.origin;
  var_10.angles = var_9 getplayerangles();

  if(isDefined(var_8) && var_8)
    var_9 playerlinkto(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_4))
    var_9 playerlinkto(var_10, "", var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_3))
    var_9 playerlinkto(var_10, "", var_3);
  else
    var_9 playerlinkto(var_10);

  var_10 moveto(var_0, var_2, var_2 * 0.25);
  var_10 rotateto(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

_id_5C90(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_0322::_id_5C91(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

_id_5C8C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _id_429A();
  var_10 = spawn("script_origin", (0, 0, 0));
  var_10.origin = var_9 _id_4298();
  var_10.angles = var_9 getplayerangles();

  if(isDefined(var_8))
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isDefined(var_4))
    var_9 playerlinktodelta(var_10, "", var_3, var_4, var_5, var_6, var_7);
  else if(isDefined(var_3))
    var_9 playerlinktodelta(var_10, "", var_3);
  else
    var_9 playerlinktodelta(var_10);

  var_10 moveto(var_0, var_2, var_2 * 0.25);
  var_10 rotateto(var_1, var_2, var_2 * 0.25);
  wait(var_2);
  var_10 delete();
}

_id_8FCD(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_8FFC();
  var_3.origin = self.origin;
  var_3.angles = self.angles;
  var_4 = self._id_01C9;

  if(isPlayer(self)) {
    var_3.angles = self getplayerangles();
    var_4 = self getvelocity();
  }

  var_3 thread _id_5C93(var_0, var_3.origin, var_4, var_1, var_2);
  return var_3;
}

_id_5C93(var_0, var_1, var_2, var_3, var_4) {
  var_3 endon("death");
  self endon("death");
  var_5 = 0.05;
  var_6 = gettime();
  var_7 = var_6 + var_0 * 1000.0;
  var_8 = var_3.angles;
  var_9 = var_3.origin;

  if(isDefined(var_4))
    var_9 = var_3 gettagorigin(var_4);

  var_10 = var_1;

  while(isDefined(self) && isDefined(var_3) && gettime() < var_7) {
    var_11 = _float(gettime() - var_6) / _float(var_7 - var_6);
    var_11 = 0.5 - _cos(var_11 * 180) * 0.5;
    var_12 = var_3.origin;

    if(isDefined(var_4))
      var_12 = var_3 gettagorigin(var_4);

    var_13 = (var_12 - var_9) / var_5;
    var_14 = _vectorlerp(var_2, var_13, var_11);
    var_10 = var_10 + var_14 * var_5;
    self.origin = _vectorlerp(var_10, var_12, var_11);

    if(isDefined(var_4))
      self.angles = _func_10B(var_8, var_3 gettagangles(var_4), var_11);

    var_9 = var_12;
    wait(var_5);
  }

  if(isDefined(var_4))
    self linkto(var_3, var_4, (0, 0, 0), (0, 0, 0));
  else
    self.origin = var_3.origin;
}

_id_72EC(var_0) {
  var_1 = level.player.origin;

  for(;;) {
    if(distance(var_1, level.player.origin) > var_0) {
      break;
    }

    waitframe();
  }
}

_id_A733(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread _id_0322::_id_A734(var_4, var_0, var_1);
  thread _id_0322::_id_A734(var_4, var_2, var_3);
  var_4 waittill("done");
}

_id_A745(var_0) {
  self waittill(var_0);
}

_id_2FF7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_429A();

  if(isDefined(level._id_9D87[var_0])) {
    if(var_5[[level._id_9D87[var_0]]]()) {
      return;
    }
    var_5 thread _id_0322::_id_4DC2(level._id_9D88[var_0], var_0, level._id_9D87[var_0], var_1, var_2, var_3, undefined, undefined, var_4);
  } else
    var_5 thread _id_0322::_id_4DC2(level._id_9D88[var_0], var_0, undefined, undefined, undefined, undefined, undefined, undefined, var_4);
}

_id_4DBC(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0322::_id_4DBD(var_0);

  if(!isDefined(var_1))
    _id_2FF7(var_0, var_2, var_3, var_4, var_5);
  else
    _id_2FFB(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_4DBF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_429A();

  if(var_6[[level._id_9D87[var_0]]]()) {
    return;
  }
  _id_0322::_id_4DBD(var_0);
  var_6 thread _id_0322::_id_4DC2(level._id_9D88[var_0], var_0, level._id_9D87[var_0], var_3, var_4, var_5, var_1, var_2);
}

_id_0911(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_9D88)) {
    level._id_9D88 = [];
    level._id_9D87 = [];
  }

  level._id_9D88[var_0] = var_1;
  level._id_4D9B[var_0]["gamepad"] = var_1;
  level._id_4D9B[var_0]["pc"] = var_3;
  level._id_4D9B[var_0]["southpaw"] = var_4;
  level._id_4D9B[var_0]["pcBindings"] = var_5;
  precachestring(var_1);

  if(isDefined(var_3))
    precachestring(var_3);

  if(isDefined(var_4))
    precachestring(var_4);

  if(isDefined(var_5)) {
    foreach(var_7 in var_5)
    precachestring(var_7);
  }

  if(isDefined(var_2))
    level._id_9D87[var_0] = var_2;
}

_id_4B01() {
  if(!isDefined(level._id_4DB7))
    level._id_4DB7 = [];

  for(;;) {
    level._id_4DB7 = common_scripts\utility::_id_0FA0(level._id_4DB7);

    if(isDefined(level._id_4DB7) && isDefined(level.player)) {
      foreach(var_1 in level._id_4DB7) {
        if(level.player common_scripts\utility::_id_55E0()) {
          var_1 sethintstring(var_1._id_4822);
          continue;
        }

        var_1 sethintstring(var_1._id_6F2C);
      }
    }

    wait 0.1;
  }
}

_id_09B2(var_0, var_1) {
  if(!isDefined(level._id_4DB7)) {
    thread _id_4B01();
    level._id_4DB7 = [];
  }

  var_2 = 0;

  foreach(var_4 in level._id_4DB7) {
    if(self == var_4) {
      var_4._id_4822 = var_0;
      var_4._id_6F2C = var_1;
      var_2 = 1;
      break;
    }
  }

  if(!var_2) {
    self._id_4822 = var_0;
    self._id_6F2C = var_1;
    level._id_4DB7 = common_scripts\utility::_id_0F6F(level._id_4DB7, self);
  }
}

_id_2FFB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_429A();
  var_6 thread _id_0322::_id_4DC2(level._id_9D88[var_0], var_0, level._id_9D87[var_0], var_2, var_3, var_4, var_1, undefined, var_5);
}

_id_2FFC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_429A();

  if(var_6[[level._id_9D87[var_0]]]()) {
    return;
  }
  var_6 thread _id_0322::_id_4DC2(level._id_9D88[var_0], var_0, level._id_9D87[var_0], var_3, var_4, var_5, var_1, var_2);
}

_id_2FF8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_6))
    var_6 = 0;

  var_10 = _id_0322::_id_4DAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  thread _id_2FF7(var_10, var_7, var_8, var_9);
  thread _id_0322::_id_4DAB(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_2FF9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_7))
    var_7 = 0;

  var_11 = _id_0322::_id_4DAA(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  thread _id_2FFB(var_11, var_1, var_8, var_9, var_10);
  thread _id_0322::_id_4DAB(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_2FFA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_8))
    var_8 = 0;

  var_12 = _id_0322::_id_4DAA(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
  thread _id_2FFC(var_12, var_1, var_2, var_9, var_10, var_11);
  thread _id_0322::_id_4DAB(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_216F(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    return [[level._id_9D87[var_0]]](var_1, var_2, var_3);

  if(isDefined(var_2))
    return [[level._id_9D87[var_0]]](var_1, var_2);

  if(isDefined(var_1))
    return [[level._id_9D87[var_0]]](var_1);

  return [[level._id_9D87[var_0]]]();
}

_id_44FE(var_0) {
  return level.settenthstimer["generic"][var_0];
}

_id_360E() {
  self.freeentitysentient = 1;
}

_id_2F26(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.freeentitysentient = 0;
  self notify("stop_being_careful", var_0);
}

_id_3643(var_0) {
  if(_id_0290::_id_0AAE())
    _id_0290::_id_0A8D(1, var_0);
  else
    self._id_9130 = 1;
}

_id_2F5B() {
  if(_id_0290::_id_0AAE())
    _id_0290::_id_0A8D(0);
  else
    self._id_9130 = undefined;
}

_id_2F24() {
  self._id_2F73 = 1;
}

_id_360D() {
  self._id_2F73 = undefined;
}

_id_8C45(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = -1;
  var_5 = [];

  foreach(var_7 in level._id_08C7) {
    if(isDefined(var_7) && isDefined(var_7._id_378F)) {
      var_8 = var_7._id_378F;
      var_9 = animscripts\shg_asm\soldier\common\shared::_id_4339();
      var_10 = undefined;

      if(isDefined(var_2))
        var_10 = var_2;

      var_11 = undefined;

      if(_isvector(var_0))
        var_11 = var_0;
      else if(_isai(var_0))
        var_11 = var_0 animscripts\shg_asm\soldier\common\aim_and_fire::_id_4327();
      else
        var_11 = var_0.origin;

      var_12 = undefined;

      if(_isvector(var_1))
        var_12 = var_1;
      else if(_isai(var_1))
        var_12 = var_1 getshootatpos();
      else
        var_12 = var_1.origin;

      if(isDefined(var_10) && distancesquared(var_11, var_12) > var_10)
        return [0, undefined];

      [var_14, var_15, var_16] = _id_02FA::_id_4107(var_8.origin, var_11, var_12);

      if(var_15 > var_9) {
        continue;
      }
      var_17 = undefined;

      if(_isvector(var_0) && _isvector(var_1))
        var_17 = _sighttracepassed(var_11, var_12, 0, undefined);
      else if(_isvector(var_0) && !_isvector(var_1))
        var_17 = _sighttracepassed(var_11, var_12, 0, undefined);
      else if(!_isvector(var_0) && _isvector(var_1)) {
        if(_isai(var_0))
          var_17 = var_0 _id_1F23(var_12);
        else
          var_17 = _sighttracepassed(var_11, var_12, 0, undefined);
      } else if(_isai(var_0))
        var_17 = var_0 cansee(var_1);
      else
        var_17 = _sighttracepassed(var_11, var_12, 0, undefined);

      if(!var_17)
        return [0, undefined];

      var_18 = vectorNormalize(var_8.origin - var_12);
      var_19 = vectorNormalize(var_8.origin - var_11);

      if(vectordot(var_18, var_19) < 0 || distancesquared(var_12, var_8.origin) < animscripts\shg_asm\soldier\common\shared::_id_4338())
        var_5[var_5.size] = var_7;
    }
  }

  if(var_5.size == 0)
    return [1, undefined];
  else {
    foreach(var_22 in var_5) {
      if(var_22._id_23D1 - gettime() > var_4) {
        var_4 = var_22._id_23D1 - gettime();
        var_3 = var_22;
      }
    }

    return [0, var_3];
  }
}

_id_23B4(var_0) {
  setDvar(var_0, "");
}

despawnagent() {
  self._id_0098 = 1;
}

_id_8490() {
  self._id_0098 = 0;
}

_id_8F71(var_0, var_1) {
  self endon("death");
  common_scripts\utility::script_delay();

  if(!isDefined(self))
    return undefined;

  if(!issubstr(self.classname, "actor"))
    return undefined;

  var_2 = isDefined(self._id_82A2) && common_scripts\utility::_id_3C77("stealth_enabled");
  var_3 = undefined;

  if(isDefined(self.setthreatbiasgroup))
    var_3 = _id_3440(self);
  else if(isDefined(self.stoplookat) || isDefined(var_0))
    var_3 = self stalingradspawn(var_2);
  else
    var_3 = self dospawn(var_2);

  if(isDefined(var_1) && var_1 && isalive(var_3))
    var_3 _id_5F6E();

  if(!isDefined(self.setthreatbiasgroup))
    _id_8FA3(var_3);

  return var_3;
}

_id_3F12(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread _id_0322::_id_3F16(self, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  return _id_0322::_id_3F1A(var_7);
}

_id_3F18(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread _id_0322::_id_3F16(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_7._id_3F15) || var_7 common_scripts\utility::_id_A71A(var_0, "function_stack_func_begun") != "timeout")
    return _id_0322::_id_3F1A(var_7);
  else {
    var_7 notify("death");
    return 0;
  }
}

_id_3F14() {
  var_0 = [];

  if(isDefined(self._id_3F12[0]) && isDefined(self._id_3F12[0]._id_3F15))
    var_0[0] = self._id_3F12[0];

  self._id_3F12 = undefined;
  self notify("clear_function_stack");
  waittillframeend;

  if(!var_0.size) {
    return;
  }
  if(!var_0[0]._id_3F15) {
    return;
  }
  self._id_3F12 = var_0;
}

_id_4034() {
  if(isDefined(self._id_4034)) {
    return;
  }
  self._id_7AC4 = self getorigin();
  self moveto(self._id_7AC4 + (0, 0, -10000), 0.2);
  self._id_4034 = 1;
}

_id_4035() {
  if(!isDefined(self._id_4034)) {
    return;
  }
  self moveto(self._id_7AC4, 0.2);
  self waittill("movedone");
  self._id_4034 = undefined;
}

_id_2F36() {
  if(_isai(self))
    _id_0290::_id_0ACD("exits", 0);
}

_id_361D() {
  if(_isai(self))
    _id_0290::_id_0ACD("exits", 1);
}

_id_2F69() {
  self._id_6818 = 1;
}

_id_3650() {
  self._id_6818 = undefined;
}

_id_2F1D() {
  if(_isai(self))
    _id_0290::_id_0ACD("arrivals", 0);
}

_id_3607() {
  self endon("death");
  waittillframeend;

  if(_isai(self))
    _id_0290::_id_0ACD("arrivals", 1);
}

hudoutlinedisableforclients(var_0, var_1) {
  _setblur(var_0, var_1);
}

setviewmodelanimtime(var_0) {
  self._id_00AE = var_0;
}

setdemigod(var_0) {
  self._id_5B49 = var_0;
  self._id_5B4A = undefined;
  self._id_5B48 = undefined;

  if(isDefined(var_0.type) && var_0.type == "Turret" && !isDefined(_func_306(var_0))) {
    return;
  }
  self setgoalnode(var_0);
}

_id_84C1(var_0) {
  var_1 = _getnode(var_0, "targetname");
  setdemigod(var_1);
}

setviewmodelanim(var_0) {
  self._id_5B49 = undefined;
  self._id_5B4A = var_0;
  self._id_5B48 = undefined;
  self setgoalpos(var_0);
}

_id_84BA(var_0) {
  setviewmodelanim(var_0.origin);
  self._id_5B48 = var_0;
}

_id_41B0() {
  if(isDefined(self._id_5B4A))
    return self._id_5B4A;

  if(isDefined(self._id_5B49))
    return self._id_5B49.origin;

  if(isDefined(self._id_5B48))
    return self._id_5B48.origin;

  if(isDefined(self._id_011F))
    return self._id_011F;

  if(isDefined(self._id_00AD))
    return self._id_00AD;

  return self.origin;
}

_id_41AD() {
  if(isDefined(self._id_5B49))
    return self._id_5B49.angles;

  if(isDefined(self._id_5B48))
    return self._id_5B48.angles;

  return self.angles;
}

_id_41AF() {
  var_0 = self._id_010D;

  if(!isDefined(var_0)) {
    if(isDefined(self._id_0139) && distancesquared(self._id_0139.origin, self._id_00AD) < 4)
      return self._id_0139;

    if(isDefined(self._id_5B48))
      return self._id_5B48;

    if(isDefined(self._id_5B49))
      return self._id_5B49;

    var_1 = _id_41B0();

    if(isDefined(var_1)) {
      var_2 = _id_41AD();
      var_0 = spawnStruct();
      var_0.origin = var_1;
      var_0.angles = var_2;
    }
  }

  return var_0;
}

_id_690B(var_0) {
  _id_0322::_id_691F(var_0);
  _objective_state(var_0, "done");
  level notify("objective_complete" + var_0);
}

_id_4B0C(var_0, var_1, var_2, var_3) {}

_id_0FA6(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = spawnStruct();
  var_4._id_4AB6 = 0;
  var_4._id_4AB5 = [];
  var_5 = [];

  foreach(var_8, var_7 in var_0) {
    var_7._id_005C = 1;

    if(var_3) {
      thread _id_0FAD(var_4, var_8, var_7, var_1, var_2);
      continue;
    }

    var_5[var_5.size] = _id_0FAD(var_4, var_8, var_7, var_1, var_2);
  }

  if(var_3) {
    for(;;) {
      waittillframeend;
      waittillframeend;
      waittillframeend;
      waittillframeend;

      if(var_4._id_4AB6 == var_0.size) {
        break;
      } else
        waitframe();
    }

    var_5 = common_scripts\utility::_id_0FA0(var_4._id_4AB5);
  }

  if(!var_2) {}

  return var_5;
}

_id_0FAD(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(getsubstr(var_2.classname, 7, 10) == "veh") {
    var_5 = var_2 _id_9016();

    if(isDefined(var_5.target) && !isDefined(var_5._id_8208))
      var_5 thread _id_0323::_id_4816();
  } else {
    var_5 = var_2 _id_8F71(var_3);

    if(!var_4) {}
  }

  var_0._id_4AB6++;
  var_0._id_4AB5[var_1] = var_5;
  return var_5;
}

_id_0FA9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = [];

  foreach(var_6 in var_0) {
    var_6._id_005C = 1;

    if(getsubstr(var_6.classname, 7, 10) == "veh") {
      var_7 = var_6 _id_9016();

      if(isDefined(var_7.target) && !isDefined(var_7._id_8208))
        var_7 thread _id_0323::_id_4816();

      var_4[var_4.size] = var_7;
      continue;
    }

    var_7 = var_6 _id_8F71(1);
    var_4 = common_scripts\utility::_id_0F6F(var_4, var_7);

    if(isDefined(var_3)) {
      wait(var_3);
      continue;
    }

    waitframe();
  }

  if(!var_2) {}

  return var_4;
}

_id_0FAF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "targetname");
  return _id_0FA6(var_5, var_1, var_2, var_4);
}

_id_0FB0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "targetname");
  return _id_0FA9(var_5, var_1, var_3, var_2);
}

_id_0FAE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "script_noteworthy");
  return _id_0FA6(var_5, var_1, var_2, var_4);
}

_id_8FF0(var_0, var_1) {
  var_2 = _getent(var_0, "script_noteworthy");
  var_3 = var_2 _id_8F71(var_1);
  return var_3;
}

_id_9001(var_0, var_1) {
  var_2 = _getent(var_0, "targetname");
  var_3 = var_2 _id_8F71(var_1);
  return var_3;
}

_id_0920(var_0, var_1, var_2) {
  if(getdvarint("2853", 0)) {
    return;
  }
  if(!isDefined(level._id_2EC4))
    level._id_2EC4 = [];

  var_3 = 0;

  for(;;) {
    if(!isDefined(level._id_2EC4[var_3])) {
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
      case "y":
      case "yellow":
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
      case "w":
      case "white":
        var_4 = "^7";
        break;
      case "bl":
      case "black":
        var_4 = "^8";
        break;
    }
  }

  level._id_2EC4[var_3] = 1;
  var_5 = _id_02C6::createfontstring("default", 1.5);
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
    waitframe();
  }

  wait 4;
  var_5 destroy();
  level._id_2EC4[var_3] = undefined;
}

_id_2DF2() {
  _id_0286::_id_2F37();
}

_id_2DF8() {
  _id_0286::_id_3DED();
}

_id_84C7(var_0) {
  self._id_00B2 = var_0;
}

_id_4298() {
  var_0 = self.origin;
  var_1 = anglestoup(self getplayerangles());
  var_2 = self getplayerviewheight();
  var_3 = var_0 + (0, 0, var_2);
  var_4 = var_0 + var_1 * var_2;
  var_5 = var_3 - var_4;
  var_6 = var_0 + var_5;
  return var_6;
}

physicsgetlinspeed(var_0) {
  _id_0290::_id_0ACC(var_0);
}

_id_843E() {
  if(!isDefined(level._id_258F))
    level._id_258F = getDvar("5554") == "true";
  else {}

  if(!isDefined(level._id_01D4))
    level._id_01D4 = getDvar("3475") == "true";
  else {}

  if(!isDefined(level._id_01D5))
    level._id_01D5 = getDvar("2695") == "true";
  else {}

  if(!isDefined(level._id_0148))
    level._id_0148 = getDvar("3864") == "true";
  else {}

  if(!isDefined(level._id_0149))
    level._id_0149 = getDvar("3957") == "true";
  else {}

  if(!isDefined(level._id_0122))
    level._id_0122 = !level._id_258F;
  else {}

  if(!isDefined(level._id_010B))
    level._id_010B = level._id_0122 || level._id_0148 || level._id_01D4;
  else {}
}

_id_5583() {
  return level._id_010B;
}

_id_1395(var_0) {
  var_1 = _id_0299::_id_13A3(undefined, undefined, undefined, 1, undefined, var_0);

  if(isDefined(var_1) && var_1) {
    if(!isDefined(var_0) || var_0 == 0)
      _id_031D::_id_7430("CHECKPOINT_REACHED");
  }

  return var_1;
}

_id_1396() {
  return _id_0299::_id_13A3(undefined, undefined, undefined, 1, undefined, 1);
}

batteryfullrecharge(var_0) {
  self._id_2A9B = _id_44FE(var_0);
}

_id_8459(var_0) {
  self._id_2A9B = _id_4417(var_0);
}

_id_23B1() {
  self._id_2A9B = undefined;
}

_id_4FA3(var_0) {
  wait 1.75;

  if(isDefined(var_0))
    self playSound(var_0);
  else
    self playSound("door_wood_slow_open");

  self rotateto(self.angles + (0, 70, 0), 2, 0.5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

_id_6E17(var_0) {
  wait 1.35;

  if(isDefined(var_0))
    self playSound(var_0);
  else
    self playSound("door_wood_slow_open");

  self rotateto(self.angles + (0, 70, 0), 2, 0.5, 0);
  self connectpaths();
  self waittill("rotatedone");
  self rotateto(self.angles + (0, 40, 0), 2, 0, 2);
}

_id_5C83(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 lerpfov(var_1, var_0);

  wait(var_0);
}

_id_5C84(var_0, var_1) {
  var_2 = getdvarfloat("3078");
  var_3 = int(var_0 / 0.05);
  var_4 = (var_1 - var_2) / var_3;
  var_5 = var_2;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_5 = var_5 + var_4;
    _setsaveddvar("3078", var_5);
    waitframe();
  }

  _setsaveddvar("3078", var_1);
}

_id_77C5() {
  animscripts\shared::_id_7008(self._id_01D0, "none");
  self._id_01D0 = "none";
}

_id_0F28() {
  _id_0298::setdamagecallbackon(0);
}

_id_0F27() {
  _id_0298::setdamagecallbackon(1);
}

_id_0E86() {
  self stopanimscripted();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
}

_id_2F51() {
  self._id_0794._id_2F95 = 1;
  self._id_0016 = 0;
}

_id_3636() {
  self._id_0794._id_2F95 = 0;
  self._id_0016 = 1;
}

_id_05FB() {
  self delete();
}

_id_0669() {
  self kill();
}

_id_5A26() {
  if(isPlayer(self)) {
    if(common_scripts\utility::_id_3C83("special_op_terminated") && common_scripts\utility::_id_3C77("special_op_terminated"))
      return 0;

    if(_id_55DE(self))
      self disableinvulnerability();
  }

  self enabledeathshield(0);
  self kill();
  return 1;
}

_id_06D1(var_0) {
  self setentitytarget(var_0);
}

_id_05E2() {
  self clearentitytarget();
}

_id_0733() {
  self unlink();
}

_id_2F50(var_0) {
  var_1 = getarraykeys(level._id_0643[var_0]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    level._id_0643[var_0][var_1[var_2]].looper delete();
    level._id_0643[var_0][var_1[var_2]] = undefined;
  }
}

_id_06D3(var_0) {
  self setlightintensity(var_0);
}

_id_0673(var_0, var_1, var_2, var_3) {
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

_id_0FBA(var_0, var_1, var_2) {
  var_3 = getarraykeys(var_0);
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++)
    var_6 = var_3[var_5];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];
    var_4[var_6] = spawnStruct();
    var_4[var_6]._id_05A3 = 1;
    var_4[var_6] thread _id_0322::_id_0FBB(var_0[var_6], var_1, var_2);
  }

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(isDefined(var_0[var_6]) && var_4[var_6]._id_05A3)
      var_4[var_6] waittill("_array_wait");
  }
}

_id_2EED() {
  self kill((0, 0, 0));
}

_id_458F(var_0) {
  return level.setcursorhint[var_0];
}

_id_5663() {
  return self playerads() > 0.5;
}

_id_A756(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = level.player;

  var_6 = spawnStruct();

  if(isDefined(var_3))
    var_6 thread _id_67F1("timeout", var_3);

  var_6 endon("timeout");

  if(!isDefined(var_0))
    var_0 = 0.92;

  if(!isDefined(var_1))
    var_1 = 0;

  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = _isai(self);
  var_10 = undefined;

  for(;;) {
    if(var_9)
      var_10 = self getEye();
    else
      var_10 = self.origin;

    if(var_5 _id_72E5(var_10, var_0, var_2, var_4)) {
      var_8--;

      if(var_8 <= 0)
        return 1;
    } else
      var_8 = var_7;

    waitframe();
  }
}

_id_A757(var_0, var_1, var_2, var_3) {
  _id_A756(var_1, var_0, var_2, undefined, var_3);
}

_id_72E5(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0.8;

  var_4 = _id_429A();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1)
    return 0;

  if(isDefined(var_2))
    return 1;

  var_11 = bulletTrace(var_0, var_5, 0, var_3);
  return var_11["fraction"] == 1;
}

_id_35AA(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(level.players[var_4] _id_72E5(var_0, var_1, var_2, var_3))
      return 1;
  }

  return 0;
}

_id_723A(var_0, var_1, var_2) {
  var_3 = gettime();

  if(!isDefined(var_1))
    var_1 = 0;

  var_4 = 0.766;

  if(isDefined(var_2))
    var_4 = _cos(var_2);

  if(isDefined(var_0._id_7453) && var_0._id_7453 + var_1 >= var_3)
    return var_0._id_7452;

  var_0._id_7453 = var_3;

  if(!common_scripts\utility::within_fov(level.player.origin, level.player _meth_8566(), var_0.origin, var_4)) {
    var_0._id_7452 = 0;
    return 0;
  }

  var_5 = level.player getEye();
  var_6 = var_0.origin;

  if(_sighttracepassed(var_5, var_6, 1, level.player, var_0)) {
    var_0._id_7452 = 1;
    return 1;
  }

  var_7 = var_6 + (0, 0, 120);

  if(_sighttracepassed(var_5, var_7, 1, level.player, var_0)) {
    var_0._id_7452 = 1;
    return 1;
  }

  var_8 = (var_7 + var_6) * 0.5;

  if(_sighttracepassed(var_5, var_8, 1, level.player, var_0)) {
    var_0._id_7452 = 1;
    return 1;
  }

  var_0._id_7452 = 0;
  return 0;
}

_id_744D(var_0, var_1) {
  var_2 = var_0 * var_0;

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(var_1, level.players[var_3].origin) < var_2)
      return 1;
  }

  return 0;
}

_id_0A7F(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = 0.75;

  if(_issplitscreen())
    var_2 = 0.65;

  while(var_0.size > 0) {
    wait 1;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!isDefined(var_0[var_3]) || !isalive(var_0[var_3])) {
        var_0 = common_scripts\utility::_id_0F93(var_0, var_0[var_3]);
        continue;
      }

      if(_id_744D(var_1, var_0[var_3].origin)) {
        continue;
      }
      if(_id_35AA(var_0[var_3].origin + (0, 0, 48), var_2, 1)) {
        continue;
      }
      if(isDefined(var_0[var_3]._id_5F6E))
        var_0[var_3] _id_93D8();

      var_0[var_3] delete();
      var_0 = common_scripts\utility::_id_0F93(var_0, var_0[var_3]);
    }
  }
}

_id_098B(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_1E82 = self;
  var_4._id_3F02 = var_0;
  var_4._id_6E87 = [];

  if(isDefined(var_1))
    var_4._id_6E87[var_4._id_6E87.size] = var_1;

  if(isDefined(var_2))
    var_4._id_6E87[var_4._id_6E87.size] = var_2;

  if(isDefined(var_3))
    var_4._id_6E87[var_4._id_6E87.size] = var_3;

  level._id_A63D[level._id_A63D.size] = var_4;
}

_id_08F5(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_1E82 = self;
  var_4._id_3F02 = var_0;
  var_4._id_6E87 = [];

  if(isDefined(var_1))
    var_4._id_6E87[var_4._id_6E87.size] = var_1;

  if(isDefined(var_2))
    var_4._id_6E87[var_4._id_6E87.size] = var_2;

  if(isDefined(var_3))
    var_4._id_6E87[var_4._id_6E87.size] = var_3;

  level._id_0846[level._id_0846.size] = var_4;
}

_id_092A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6._id_1E82 = self;
  var_6._id_3F02 = var_0;
  var_6._id_6E87 = [];

  if(isDefined(var_1))
    var_6._id_6E87[var_6._id_6E87.size] = var_1;

  if(isDefined(var_2))
    var_6._id_6E87[var_6._id_6E87.size] = var_2;

  if(isDefined(var_3))
    var_6._id_6E87[var_6._id_6E87.size] = var_3;

  if(isDefined(var_4))
    var_6._id_6E87[var_6._id_6E87.size] = var_4;

  if(isDefined(var_5))
    var_6._id_6E87[var_6._id_6E87.size] = var_5;

  level._id_7F62[level._id_7F62.size] = var_6;
}

_id_0907(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6._id_1E82 = self;
  var_6._id_3F02 = var_0;
  var_6._id_6E87 = [];

  if(isDefined(var_1))
    var_6._id_6E87[var_6._id_6E87.size] = var_1;

  if(isDefined(var_2))
    var_6._id_6E87[var_6._id_6E87.size] = var_2;

  if(isDefined(var_3))
    var_6._id_6E87[var_6._id_6E87.size] = var_3;

  if(isDefined(var_4))
    var_6._id_6E87[var_6._id_6E87.size] = var_4;

  if(isDefined(var_5))
    var_6._id_6E87[var_6._id_6E87.size] = var_5;

  level._id_7F5A[level._id_7F5A.size] = var_6;
}

_id_094A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6._id_3F02 = var_0;
  var_6._id_6E87 = [];

  if(isDefined(var_1))
    var_6._id_6E87[var_6._id_6E87.size] = var_1;

  if(isDefined(var_2))
    var_6._id_6E87[var_6._id_6E87.size] = var_2;

  if(isDefined(var_3))
    var_6._id_6E87[var_6._id_6E87.size] = var_3;

  if(isDefined(var_4))
    var_6._id_6E87[var_6._id_6E87.size] = var_4;

  if(isDefined(var_5))
    var_6._id_6E87[var_6._id_6E87.size] = var_5;

  level._id_7F67[level._id_7F67.size] = var_6;
}

_id_0924(var_0) {
  var_1 = spawnStruct();
  var_1._id_1E82 = self;
  var_1._id_36B6 = var_0;
  level._id_30FF[level._id_30FF.size] = var_1;
}

_id_30FE() {
  _id_30FD(level._id_A63D.size - 1);
}

_id_30FD(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = spawnStruct();
  var_2 = level._id_A63D;
  var_3 = level._id_30FF;
  var_4 = level._id_7F62;
  var_5 = level._id_7F5A;
  var_6 = level._id_7F67;
  var_7 = level._id_0846;
  level._id_A63D = [];
  level._id_7F62 = [];
  level._id_30FF = [];
  level._id_0846 = [];
  level._id_7F5A = [];
  level._id_7F67 = [];
  var_1._id_005C = var_2.size;
  var_1 common_scripts\utility::_id_0F8A(var_2, _id_0322::_id_A73F, var_3);
  var_1 thread _id_0322::_id_3093(var_7);
  var_1 endon("any_funcs_aborted");

  for(;;) {
    if(var_1._id_005C <= var_0) {
      break;
    }

    var_1 waittill("func_ended");
  }

  var_1 notify("all_funcs_ended");
  common_scripts\utility::_id_0F8A(var_4, _id_0322::_id_38D6, []);
  common_scripts\utility::_id_0F8A(var_5, _id_0322::_id_38D4);
  common_scripts\utility::_id_0F8A(var_6, _id_0322::_id_38D5);
}

_id_30B8() {
  var_0 = spawnStruct();
  var_1 = level._id_7F62;
  level._id_7F62 = [];

  foreach(var_3 in var_1)
  level _id_0322::_id_38D6(var_3, []);

  var_0 notify("all_funcs_ended");
}

_id_5564() {
  if(isDefined(level._id_3E13) && level._id_3E13 == 1)
    return 0;

  if(isDefined(level._id_2BB9) && level._id_2BB9 == level._id_9267)
    return 1;

  if(isDefined(level._id_2BB8))
    return level._id_9267 == "default";

  if(_id_5CB3())
    return level._id_9267 == level._id_9210[0]["name"];

  return level._id_9267 == "default";
}

_id_3E00() {
  level._id_3E13 = 1;
}

_id_557E() {
  if(!_id_5CB3())
    return 1;

  return level._id_9267 == level._id_9210[0]["name"];
}

_id_552D(var_0) {
  var_1 = 0;

  if(level._id_9267 == var_0)
    return 0;

  for(var_2 = 0; var_2 < level._id_9210.size; var_2++) {
    if(level._id_9210[var_2]["name"] == var_0) {
      var_1 = 1;
      continue;
    }

    if(level._id_9210[var_2]["name"] == level._id_9267)
      return var_1;
  }
}

_id_0610(var_0, var_1, var_2, var_3) {
  _earthquake(var_0, var_1, var_2, var_3);
}

_id_A967(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isDefined(var_1))
    var_2 = 1;

  if(isDefined(var_0)) {
    common_scripts\utility::_id_3C78(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(_randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = bulletTrace(var_3, var_4, 0, undefined);

    if(!issubstr(var_5["surfacetype"], "water")) {
      continue;
    }
    var_6 = "water_movement";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5)
        var_6 = "water_stop";
    } else if(isDefined(level._effect["water_" + self._id_0794._id_64B0]))
      var_6 = "water_" + self._id_0794._id_64B0;

    var_7 = common_scripts\utility::_id_44F5(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = anglestoup(var_8);
    playFX(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2)
      thread common_scripts\utility::_id_71A9(var_1, var_3);
  }
}

_id_7461(var_0) {
  if(isDefined(var_0)) {
    common_scripts\utility::_id_3C78(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(_randomfloatrange(0.25, 0.5));
    var_1 = self.origin + (0, 0, 0);
    var_2 = self.origin - (0, 0, 5);
    var_3 = bulletTrace(var_1, var_2, 0, undefined);
    var_4 = anglesToForward(self.angles);
    var_5 = distance(self getvelocity(), (0, 0, 0));

    if(isDefined(self._id_A2C8)) {
      continue;
    }
    if(var_3["surfacetype"] != "snow") {
      continue;
    }
    if(var_5 <= 10) {
      continue;
    }
    var_6 = "snow_movement";

    if(distance(self getvelocity(), (0, 0, 0)) <= 154)
      playFX(common_scripts\utility::_id_44F5("footstep_snow_small"), var_3["position"], var_3["normal"], var_4);

    if(distance(self getvelocity(), (0, 0, 0)) > 154)
      playFX(common_scripts\utility::_id_44F5("footstep_snow"), var_3["position"], var_3["normal"], var_4);
  }
}

_id_6265(var_0) {
  var_1 = 60;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", (var_1 - var_2) / var_1);
    waitframe();
  }
}

_id_625F(var_0) {
  var_1 = 60;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self setsoundblend(var_0, var_0 + "_off", var_2 / var_1);
    waitframe();
  }
}

_id_5FD4(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  for(;;) {
    self.origin = var_0.origin + var_1;
    self.angles = var_0.angles;
    waitframe();
  }
}

_id_66C7() {
  _id_0322::_id_6252();
  _id_02B3::_id_0682();
}

_id_47F7(var_0, var_1) {
  _id_02B3::_id_0644(var_0, var_1);
}

_id_5FA1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[var_5.size] = var_0;

  if(isDefined(var_1))
    var_5[var_5.size] = var_1;

  if(isDefined(var_2))
    var_5[var_5.size] = var_2;

  if(isDefined(var_3))
    var_5[var_5.size] = var_3;

  if(isDefined(var_4))
    var_5[var_5.size] = var_4;

  return var_5;
}

_id_39D6() {
  level._id_39E8 = 1;
}

_id_6743() {
  level._id_39E8 = 0;
}

_id_4619() {
  var_0 = self getweaponlistall();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_1[var_3] = self getweaponammoclip(var_3);
  }

  var_4 = 0;

  if(isDefined(var_1["claymore"]) && var_1["claymore"] > 0)
    var_4 = var_1["claymore"];

  return var_4;
}

_id_076D(var_0) {
  wait(var_0);
}

_id_0770(var_0, var_1) {
  self waittillmatch(var_0, var_1);
}

_id_06D9(var_0, var_1) {
  _setsaveddvar(var_0, var_1);
}

_id_5C94(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  for(var_7 = var_4 / var_6; var_6; var_6--) {
    var_3 = var_3 + var_7;
    _setsaveddvar(var_0, var_3);
    wait(var_5);
  }

  _setsaveddvar(var_0, var_1);
}

_id_5C95(var_0, var_1, var_2, var_3) {
  if(_id_5583())
    _id_5C94(var_0, var_2, var_3);
  else
    _id_5C94(var_0, var_1, var_3);
}

_id_476F(var_0) {
  if(_id_5567() || getdvarint("3224")) {
    return;
  }
  foreach(var_2 in level.players)
  var_2 giveachievement(var_0);
}

_id_728C(var_0) {
  if(_id_5567()) {
    return;
  }
  self giveachievement(var_0);
}

_id_0937(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 _meth_80B1();
  var_1 setModel("weapon_javelin_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  _id_098B(::_id_2D1F);

  if(isDefined(var_0)) {
    common_scripts\utility::_id_3C78(var_0);
    _id_098B(common_scripts\utility::_id_3C9F, var_0);
  }

  _id_30FE();
  var_1 delete();
}

_id_0906(var_0) {
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 _meth_80B1();
  var_1 setModel("weapon_c4_obj");
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  _id_098B(::_id_2D1F);

  if(isDefined(var_0)) {
    common_scripts\utility::_id_3C78(var_0);
    _id_098B(common_scripts\utility::_id_3C9F, var_0);
  }

  _id_30FE();
  var_1 delete();
}

_id_2D1F() {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    waitframe();
  }
}

_id_8CB5() {}

_id_8CAC() {}

_id_8CB4(var_0) {
  level._id_8CAB._id_90EF = var_0;
}

_id_8CB3(var_0) {
  level._id_8CAB._id_90EB = var_0;
}

_id_8CB1(var_0) {
  level._id_8CAB._id_5C9C = var_0;
}

_id_8CB2(var_0) {
  level._id_8CAB._id_5C9D = var_0;
}

_id_8CAD() {
  if(isDefined(level._id_66FC) && level._id_66FC) {
    return;
  }
  _setslowmotion(level._id_8CAB._id_90EB, level._id_8CAB._id_90EF, level._id_8CAB._id_5C9C);
}

_id_8CAE() {
  if(isDefined(level._id_66FC) && level._id_66FC) {
    return;
  }
  _setslowmotion(level._id_8CAB._id_90EF, level._id_8CAB._id_90EB, level._id_8CAB._id_5C9D);
}

_id_0923(var_0, var_1, var_2, var_3) {
  level._id_353D[var_0]["magnitude"] = var_1;
  level._id_353D[var_0]["duration"] = var_2;
  level._id_353D[var_0]["radius"] = var_3;
}

_id_0F44() {
  return getDvar("2559") == "1";
}

_id_0F46() {
  if(!isDefined(level._id_0F45)) {
    return;
  }
  level notify("arcadeMode_remove_timer");
  level._id_0F47 = gettime();
  level._id_0F45 destroy();
  level._id_0F45 = undefined;
}

_id_65BE(var_0, var_1) {
  level._id_05A5._id_5B4D = var_0;

  if(!isDefined(var_1))
    var_1 = 1;

  _musicstop(0);
  _musicplay(var_0, 0, 1.0, 1);
}

_id_65B3(var_0, var_1, var_2, var_3) {
  thread _id_0322::_id_65B4(var_0, var_1, var_2, var_3);
}

_id_65B6(var_0, var_1, var_2, var_3) {
  thread _id_0322::_id_65B4(var_0, var_1, var_2, var_3);
}

_id_65B8(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 > 0) {
    thread _id_0322::_id_65B9(var_0, var_1, var_2);
    return;
  }

  _id_65BB();
  _id_65BE(var_0, var_2);
}

_id_65B1(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(isDefined(level._id_05A5._id_5B4D))
    _musicstop(var_1, level._id_05A5._id_5B4D);
  else
    _iprintln("^3WARNING!script music_crossfade(): No previous song was played - no previous song to crossfade from - not fading out anything");

  level._id_05A5._id_5B4D = var_0;
  _musicplay(var_0, var_1, var_2, 0);
  level endon("stop_music");
  wait(var_1);
  level notify("done_crossfading");
}

_id_65BB(var_0) {
  if(!isDefined(var_0) || var_0 <= 0)
    _musicstop();
  else
    _musicstop(var_0);

  level notify("stop_music");
}

_id_72C5() {
  var_0 = getEntArray("grenade", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.model == "weapon_claymore") {
      continue;
    }
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(distancesquared(var_2.origin, var_4.origin) < 75625)
        return 1;
    }
  }

  return 0;
}

_id_7259() {
  return getdvarint("player_died_recently", "0") > 0;
}

_id_0BD2(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 istouching(var_0))
      return 0;
  }

  return 1;
}

_id_0F0C(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0))
      return 1;
  }

  return 0;
}

_id_448F() {
  if(level._id_3FD4 < 1)
    return "easy";

  if(level._id_3FD4 < 2)
    return "medium";

  if(level._id_3FD4 < 3)
    return "hard";

  return "fu";
}

_id_442F() {
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

_id_40B9(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3.origin;

  return var_1 * (1.0 / var_0.size);
}

_id_401F() {
  self._id_299C = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    foreach(var_8 in self._id_299C)
    thread[[var_8]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }
}

_id_0913(var_0) {
  self._id_299C[self._id_299C.size] = var_0;
}

_id_7C7C(var_0) {
  var_1 = [];

  foreach(var_3 in self._id_299C) {
    if(var_3 == var_0) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  self._id_299C = var_1;
}

_id_74BF(var_0) {
  self playlocalsound(var_0);
}

_id_365F(var_0) {
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

_id_98A6(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isDefined(var_5._id_0165) && var_5._id_0165 == "player1") {
      var_1 = var_5;
      continue;
    }

    if(isDefined(var_5._id_0165) && var_5._id_0165 == "player2") {
      var_2 = var_5;
      continue;
    }

    if(!isDefined(var_1))
      var_1 = var_5;

    if(!isDefined(var_2))
      var_2 = var_5;
  }

  foreach(var_8 in level.players) {
    if(var_8 == level.player)
      var_3 = var_1;
    else if(var_8 == level._id_73AB)
      var_3 = var_2;

    var_8 setOrigin(var_3.origin);
    var_8 setplayerangles(var_3.angles);
  }
}

_id_98A3(var_0) {
  level.player setOrigin(var_0.origin);

  if(isDefined(var_0.angles))
    level.player setplayerangles(var_0.angles);
}

_id_9C88() {
  var_0 = [];

  if(isDefined(self._id_37C3))
    var_0 = self._id_37C3;

  if(isDefined(self.entity))
    var_0[var_0.size] = self.entity;

  common_scripts\utility::_id_0F8A(var_0, _id_0322::_id_9C89);
}

_id_6BF7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_opening_fov");
  wait(var_0);
  level.player playerlinktodelta(var_1, var_2, 1, var_3, var_4, var_5, var_6, 1);
}

_id_4069(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = "all";

  if(!isDefined(var_1))
    var_1 = "all";

  var_3 = _getaispeciesarray(var_0, var_1);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(var_6 istouching(self))
      var_4[var_4.size] = var_6;
  }

  return var_4;
}

_id_4164(var_0) {
  if(!isDefined(var_0))
    var_0 = "all";

  var_1 = [];

  if(var_0 == "all") {
    var_1 = common_scripts\utility::_id_0F8C(level._id_343C["allies"]._id_0F6D, level._id_343C["axis"]._id_0F6D);
    var_1 = common_scripts\utility::_id_0F8C(var_1, level._id_343C["neutral"]._id_0F6D);
  } else
    var_1 = level._id_343C[var_0]._id_0F6D;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 istouching(self))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_4165(var_0) {
  var_1 = common_scripts\utility::_id_0F8C(level._id_343C["allies"]._id_0F6D, level._id_343C["axis"]._id_0F6D);
  var_1 = common_scripts\utility::_id_0F8C(var_1, level._id_343C["neutral"]._id_0F6D);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.targetname) && var_4.targetname == var_0)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_426B(var_0) {
  foreach(var_2 in level.players) {
    if(var_0 == var_2) {
      continue;
    }
    return var_2;
  }
}

gettagindex(var_0) {
  self._id_005C = var_0;

  if(self._id_005C == 0)
    self notify("spawner_emptied");
}

_id_3DC4(var_0) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_1 = undefined;

  if(!isDefined(var_0.classname)) {
    if(!isDefined(var_0.type))
      var_1 = "struct";
    else
      var_1 = "node";
  } else
    var_1 = "entity";

  var_2 = self.enableaimassist;
  self.enableaimassist = 1;
  _id_02FC::_id_47F8(var_0, var_1);
  self.enableaimassist = var_2;
}

_id_361B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0))
    var_0 = 250;

  if(!isDefined(var_1))
    var_1 = 100;

  if(!isDefined(var_2))
    var_2 = var_0 * 2;

  if(!isDefined(var_3))
    var_3 = var_0 * 1.25;

  if(!isDefined(var_5))
    var_5 = 0;

  self._id_323F = var_5;
  thread _id_0322::_id_3527(var_0, var_1, var_2, var_3, var_4);
}

_id_2F34() {
  self notify("stop_dynamic_run_speed");
}

_id_731E() {
  self endon("death");
  self endon("stop_player_seek");
  var_0 = 1200;

  if(_id_4B41())
    var_0 = 250;

  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait 2;
    self._id_00AE = var_1;
    var_2 = _id_4103(self.origin);
    self setgoalentity(var_2);
    var_1 = var_1 - 175;

    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

_id_731D() {
  self notify("stop_player_seek");
}

_id_A739(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_2))
    var_2 = 5;

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

_id_A738(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) <= var_1) {
      break;
    }

    wait 0.1;
  }
}

_id_A73A(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while(isDefined(var_0)) {
    if(distance(var_0.origin, self.origin) > var_1) {
      break;
    }

    wait 0.1;
  }
}

_id_4B41() {
  self endon("death");

  if(!isDefined(self._id_01D0))
    return 0;

  if(weaponclass(self._id_01D0) == "spread")
    return 1;

  return 0;
}

_id_5795(var_0) {
  if(var_0 == "none")
    return 0;

  if(weaponinventorytype(var_0) != "primary")
    return 0;

  switch (weaponclass(var_0)) {
    case "mg":
    case "pistol":
    case "smg":
    case "rocketlauncher":
    case "rifle":
    case "sniper":
    case "spread":
      return 1;
    default:
      return 0;
  }
}

_id_729B() {
  var_0 = self getweaponlistall();

  if(!isDefined(var_0))
    return 0;

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "thermal"))
      return 1;
  }

  return 0;
}

_id_A769(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = self._id_00AE;

  for(;;) {
    self waittill("goal");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

_id_7334(var_0, var_1) {
  var_2 = int(getDvar("5502"));

  if(!isDefined(level.player._id_3F88))
    level.player._id_3F88 = var_2;

  var_3 = int(level.player._id_3F88 * var_0 * 0.01);
  level.player _id_7336(var_3, var_1);
}

_id_1793(var_0, var_1) {
  var_2 = self;

  if(!isPlayer(var_2))
    var_2 = level.player;

  if(!isDefined(var_2._id_64CC))
    var_2._id_64CC = 1.0;

  var_3 = var_0 * 0.01;
  var_2 _id_1791(var_3, var_1);
}

_id_7336(var_0, var_1) {
  var_2 = int(getDvar("5502"));

  if(!isDefined(level.player._id_3F88))
    level.player._id_3F88 = var_2;

  var_3 = _id_0322::_id_3F89;
  var_4 = _id_0322::_id_3F8A;
  level.player thread _id_7335(var_0, var_1, var_3, var_4, "player_speed_set");
}

_id_7234(var_0, var_1) {
  var_2 = _id_0322::_id_3F86;
  var_3 = _id_0322::_id_3F87;
  level.player thread _id_7335(var_0, var_1, var_2, var_3, "player_bob_scale_set");
}

_id_1791(var_0, var_1) {
  var_2 = self;

  if(!isPlayer(var_2))
    var_2 = level.player;

  if(!isDefined(var_2._id_64CC))
    var_2._id_64CC = 1.0;

  var_3 = _id_0322::_id_64C9;
  var_4 = _id_0322::_id_64CB;
  var_2 thread _id_7335(var_0, var_1, var_3, var_4, "blend_movespeedscale");
}

_id_7335(var_0, var_1, var_2, var_3, var_4) {
  self notify(var_4);
  self endon(var_4);
  var_5 = [[var_2]]();
  var_6 = var_0;

  if(isDefined(var_1)) {
    var_7 = var_6 - var_5;
    var_8 = 0.05;
    var_9 = var_1 / var_8;
    var_10 = var_7 / var_9;

    while(_abs(var_6 - var_5) > _abs(var_10 * 1.1)) {
      var_5 = var_5 + var_10;
      [[var_3]](var_5);
      wait(var_8);
    }
  }

  [[var_3]](var_6);
}

_id_7333(var_0) {
  if(!isDefined(level.player._id_3F88)) {
    return;
  }
  level.player _id_7336(level.player._id_3F88, var_0);
  waittillframeend;
  level.player._id_3F88 = undefined;
}

_id_1792(var_0) {
  var_1 = self;

  if(!isPlayer(var_1))
    var_1 = level.player;

  if(!isDefined(var_1._id_64CC)) {
    return;
  }
  var_1 _id_1791(1.0, var_0);
  waittillframeend;
  var_1._id_64CC = undefined;
}

_id_987D(var_0) {
  if(isPlayer(self)) {
    self setOrigin(var_0.origin);
    self setplayerangles(var_0.angles);
  } else
    self forceteleport(var_0.origin, var_0.angles);
}

_id_98B5(var_0, var_1) {
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  self dontinterpolate();

  if(isPlayer(self)) {
    self setOrigin(var_2);
    self setplayerangles(var_3);
  } else if(_isai(self))
    self forceteleport(var_2, var_3);
  else {
    self.origin = var_2;
    self.angles = var_3;
  }
}

_id_9874(var_0) {
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalpos(var_0.origin);
  self setgoalnode(var_0);
}

_id_6470(var_0) {
  foreach(var_2 in level.createfxent)
  var_2.v["origin"] = var_2.v["origin"] + var_0;
}

_id_57D3() {
  return isDefined(self._id_8CA0);
}

_id_171A(var_0, var_1, var_2) {
  var_3 = self;
  var_3 thread _id_71AB("foot_slide_plr_start");

  if(_soundexists("foot_slide_plr_loop"))
    var_3 thread _id_7154("foot_slide_plr_loop");

  var_4 = isDefined(level._id_296E);

  if(!isDefined(var_0))
    var_0 = var_3 getvelocity() + (0, 0, -10);

  if(!isDefined(var_1))
    var_1 = 10;

  if(!isDefined(var_2)) {
    if(isDefined(level._id_8C9E))
      var_2 = level._id_8C9E;
    else
      var_2 = 0.035;
  }

  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3._id_8CA0 = var_5;
  var_5 moveslide((0, 0, 15), 15, var_0);

  if(var_4)
    var_3 playerlinktoblend(var_5, undefined, 1);
  else
    var_3 playerlinkto(var_5);

  var_3 disableweapons();
  var_3 allowprone(0);
  var_3 allowcrouch(1);
  var_3 allowstand(0);
  var_3 thread _id_0322::_id_32AA(var_5, var_1, var_2);
}

_id_36EA() {
  var_0 = self;
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread _id_71AB("foot_slide_plr_end");
  var_0 unlink();
  var_0 setvelocity(var_0._id_8CA0._id_0182);
  var_0._id_8CA0 delete();
  var_0 enableweapons();
  var_0 allowprone(1);
  var_0 allowcrouch(1);
  var_0 allowstand(1);
  var_0 notify("stop_sliding");
}

_id_9016() {
  return _id_0323::_id_A3B8(self);
}

_id_44CC(var_0) {
  var_1 = _id_0319::_id_41FC();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = common_scripts\utility::_id_0F73(var_2, var_5);
  }

  var_7 = undefined;

  foreach(var_9 in var_2) {
    if(var_9.getnegotiationnextnode == var_0)
      return var_9;
  }
}

_id_44C4(var_0) {
  var_1 = _id_0319::_id_41FC();
  var_2 = [];

  foreach(var_6, var_4 in var_1) {
    if(!issubstr(var_6, "flag")) {
      continue;
    }
    var_5 = getEntArray(var_6, "classname");
    var_2 = common_scripts\utility::_id_0F73(var_2, var_5);
  }

  var_7 = [];

  foreach(var_9 in var_2) {
    if(var_9.getnegotiationnextnode == var_0)
      var_7[var_7.size] = var_9;
  }

  return var_7;
}

_id_85FA(var_0, var_1) {
  return (var_0[0], var_0[1], var_1);
}

_id_098D(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

_id_85F9(var_0, var_1) {
  return (var_0[0], var_1, var_0[2]);
}

_id_85F8(var_0, var_1) {
  return (var_1, var_0[1], var_0[2]);
}

_id_7396() {
  var_0 = self getcurrentweapon();

  if(!isDefined(var_0))
    return 0;

  if(issubstr(_tolower(var_0), "rpg"))
    return 1;

  if(issubstr(_tolower(var_0), "stinger"))
    return 1;

  if(issubstr(_tolower(var_0), "javelin"))
    return 1;

  return 0;
}

_id_3201() {
  return isDefined(self._id_0794._id_3201);
}

_id_430A(var_0, var_1) {
  if(_id_554E()) {}

  var_2 = _id_429A();

  if(!isDefined(var_0))
    var_0 = "steady_rumble";

  var_3 = spawn("script_origin", var_2 getEye());

  if(!isDefined(var_1) || !_isnumber(var_1))
    var_3.intensity = 1;
  else
    var_3.intensity = var_1;

  var_3 thread _id_0322::_id_A0C9(var_2, var_0);
  return var_3;
}

_id_8575(var_0) {
  self.intensity = var_0;
}

_id_7F51(var_0) {
  thread _id_7F52(1, var_0);
}

_id_7F50(var_0) {
  thread _id_7F52(0, var_0);
}

_id_7F52(var_0, var_1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_2 = var_1 * 20;
  var_3 = var_0 - self.intensity;
  var_4 = var_3 / var_2;

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self.intensity = self.intensity + var_4;
    waitframe();
  }

  self.intensity = var_0;
}

_id_429A() {
  if(isDefined(self)) {
    if(!_id_559A(level.players, self))
      return level.player;
    else
      return self;
  } else
    return level.player;
}

_id_429B() {
  return int(self getplayersetting("gameskill"));
}

_id_47E7(var_0) {
  if(isDefined(self._id_6725)) {
    return;
  }
  self._id_6725 = self.model;

  if(!isDefined(var_0))
    var_0 = self.model + "_obj";

  self setModel(var_0);
}

_id_9407(var_0) {
  if(!isDefined(self._id_6725)) {
    return;
  }
  self setModel(self._id_6725);
  self._id_6725 = undefined;
}

_id_0F7C(var_0, var_1, var_2) {
  var_3 = [];
  var_1 = var_2 - var_1;

  foreach(var_5 in var_0) {
    var_3[var_3.size] = var_5;

    if(var_3.size == var_2) {
      var_3 = common_scripts\utility::array_randomize(var_3);

      for(var_6 = var_1; var_6 < var_3.size; var_6++)
        var_3[var_6] delete();

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

_id_A741(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0.5;

  self endon("death");

  while(isDefined(self)) {
    if(distance(var_0, self.origin) <= var_1) {
      break;
    }

    wait(var_2);
  }
}

_id_561A(var_0, var_1) {
  var_2 = _func_2E1(var_1, self);

  if(distancesquared(var_1, var_2) > 576)
    return 0;

  var_3 = _func_2E1(var_0, self);

  if(!_func_2DE(var_3, var_2, self) && _func_2DC(var_3, var_2, self))
    return 0;

  return 1;
}

_id_097C(var_0) {
  var_1 = spawnStruct();
  var_1 thread _id_0322::_id_097D(var_0);
  return var_1;
}

_id_9B87(var_0, var_1, var_2) {
  var_3 = self gettagorigin(var_1);
  var_4 = self gettagangles(var_1);
  _id_9B86(var_0, var_3, var_4, var_2);
}

_id_9B86(var_0, var_1, var_2, var_3) {
  var_4 = anglesToForward(var_2);
  var_5 = bulletTrace(var_1, var_1 + var_4 * var_3, 0, undefined);

  if(var_5["fraction"] >= 1) {
    return;
  }
  var_6 = var_5["surfacetype"];

  if(!isDefined(level._id_9B80[var_0][var_6]))
    var_6 = "default";

  var_7 = level._id_9B80[var_0][var_6];

  if(isDefined(var_7["fx"]))
    playFX(var_7["fx"], var_5["position"], var_5["normal"]);

  if(isDefined(var_7["fx_array"])) {
    foreach(var_9 in var_7["fx_array"])
    playFX(var_9, var_5["position"], var_5["normal"]);
  }

  if(isDefined(var_7["sound"]))
    level thread common_scripts\utility::_id_71A9(var_7["sound"], var_5["position"]);

  if(isDefined(var_7["rumble"])) {
    var_11 = _id_429A();
    var_11 playrumbleonentity(var_7["rumble"]);
  }
}

_id_2F5E() {
  self._id_6694 = 0;
}

_id_3646() {
  self._id_6694 = _squared(512);
}

_id_2F4F() {
  if(!isPlayer(self)) {
    return;
  }
  _id_02DC::_id_9A77(0);
}

_id_3635() {
  if(!isPlayer(self)) {
    return;
  }
  _id_02DC::_id_9A77(1);
}

_id_362A(var_0) {}

_id_2F41() {}

_id_4711() {
  return _vehicle_getarray();
}

_id_4D7C(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = 0.5;
  level endon("clearing_hints");

  if(isDefined(level._id_4DC0))
    level._id_4DC0 _id_02C6::destroyelem();

  level._id_4DC0 = _id_02C6::createfontstring("default", 1.5);
  level._id_4DC0 _id_02C6::setpoint("MIDDLE", undefined, 0, 30 + var_2);
  level._id_4DC0.color = (1, 1, 1);
  level._id_4DC0 settext(var_0);
  level._id_4DC0.alpha = 0;
  level._id_4DC0 fadeovertime(0.5);
  level._id_4DC0.alpha = 1;
  wait 0.5;
  level._id_4DC0 endon("death");

  if(isDefined(var_1))
    wait(var_1);
  else
    return;

  level._id_4DC0 fadeovertime(var_3);
  level._id_4DC0.alpha = 0;
  wait(var_3);
  level._id_4DC0 _id_02C6::destroyelem();
}

_id_4D93() {
  var_0 = 1;

  if(isDefined(level._id_4DC0)) {
    level notify("clearing_hints");
    level._id_4DC0 fadeovertime(var_0);
    level._id_4DC0.alpha = 0;
    wait(var_0);
  }
}

_id_59FF(var_0, var_1, var_2) {
  if(!isDefined(level._id_3C77[var_0])) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_4 in level._id_2AA2[var_0]) {
    foreach(var_6 in var_4) {
      if(isalive(var_6)) {
        var_6 thread _id_0322::_id_5A00(var_1, var_2);
        continue;
      }

      var_6 delete();
    }
  }
}

_id_42AE(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = "player_view_controller";

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_4 = var_0 gettagorigin(var_1);
  var_5 = _spawnturret("misc_turret", var_4, var_3);
  var_5.angles = var_0 gettagangles(var_1);
  var_5 setModel("tag_turret");
  var_5 linkto(var_0, var_1, var_2, (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 setmode("manual");
  return var_5;
}

_id_2784(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 childthread _id_0322::_id_7744(var_0, self, var_1, var_2, var_3);
  return var_4;
}

_id_85BD(var_0, var_1) {
  if(!isDefined(self._id_A08B))
    self._id_A08B = [];

  if(!isDefined(var_1) || var_1)
    self._id_A08B[var_0] = 1;
  else
    self._id_A08B[var_0] = undefined;
}

_id_5639(var_0) {
  if(!isDefined(self._id_A08B))
    return 0;

  return isDefined(self._id_A08B[var_0]);
}

_id_941E(var_0) {
  if(!isDefined(self._id_9429))
    self._id_9429 = [];

  if(!isDefined(self._id_A08B))
    self._id_A08B = [];

  var_1 = [];
  var_2 = self getweaponlistall();
  var_3 = self getcurrentweapon();
  var_4 = self getlethalweapon();
  var_5 = self getoffhandsecondaryclass();

  foreach(var_7 in var_2) {
    if(isDefined(self._id_A08B[var_7])) {
      continue;
    }
    var_1[var_7] = [];
    var_1[var_7]["clip_left"] = self getweaponammoclip(var_7, "left");
    var_1[var_7]["clip_right"] = self getweaponammoclip(var_7, "right");
    var_1[var_7]["stock"] = self getweaponammostock(var_7);
  }

  if(!isDefined(var_0))
    var_0 = "default";

  self._id_9429[var_0] = [];

  if(isDefined(self._id_A08B[var_3])) {
    var_9 = self getweaponlistprimaries();

    foreach(var_7 in var_9) {
      if(!isDefined(self._id_A08B[var_7])) {
        var_3 = var_7;
        break;
      }
    }
  }

  self._id_9429[var_0]["current_weapon"] = var_3;
  self._id_9429[var_0]["inventory"] = var_1;
  self._id_9429[var_0]["lethal_offhand"] = var_4;
  self._id_9429[var_0]["tactical_offhand"] = var_5;
}

_id_7DEA(var_0) {
  if(!isDefined(var_0))
    var_0 = "default";

  if(!isDefined(self._id_9429) || !isDefined(self._id_9429[var_0])) {
    return;
  }
  self takeallweapons();

  foreach(var_3, var_2 in self._id_9429[var_0]["inventory"]) {
    if(weaponinventorytype(var_3) != "altmode")
      self giveweapon(var_3);

    self setweaponammoclip(var_3, var_2["clip_left"], "left");
    self setweaponammoclip(var_3, var_2["clip_right"], "right");
    self setweaponammostock(var_3, var_2["stock"]);
  }

  var_4 = self._id_9429[var_0]["current_weapon"];

  if(var_4 != "none")
    self switchtoweapon(var_4);

  self setlethalweapon(self._id_9429[var_0]["lethal_offhand"]);
  self setoffhandsecondaryclass(self._id_9429[var_0]["tactical_offhand"]);
}

_id_4353() {
  var_0 = self getweaponlistall();

  if(isDefined(self._id_A08B)) {
    foreach(var_2 in var_0) {
      if(isDefined(self._id_A08B[var_2]))
        var_0 = common_scripts\utility::_id_0F93(var_0, var_2);
    }
  }

  return var_0;
}

_id_4354() {
  var_0 = self getweaponlistprimaries();

  if(isDefined(self._id_A08B)) {
    foreach(var_2 in var_0) {
      if(isDefined(self._id_A08B[var_2]))
        var_0 = common_scripts\utility::_id_0F93(var_0, var_2);
    }
  }

  return var_0;
}

_id_4352() {
  var_0 = self getcurrentprimaryweapon();

  if(isDefined(self._id_A08B) && isDefined(self._id_A08B[var_0]))
    var_0 = _id_4190();

  return var_0;
}

_id_4351() {
  var_0 = self getcurrentweapon();

  if(isDefined(self._id_A08B) && isDefined(self._id_A08B[var_0]))
    var_0 = _id_4190();

  return var_0;
}

_id_4190() {
  var_0 = _id_4354();

  if(var_0.size > 0)
    var_1 = var_0[0];
  else
    var_1 = "none";

  return var_1;
}

_id_4CE0() {
  switch (self._id_003B) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self hide();
      break;
    case "script_brushmodel":
      self hide();
      self notsolid();

      if(self.spawnflags & 1)
        self connectpaths();

      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_use_touch":
    case "trigger_radius":
      common_scripts\utility::_id_9D9F();
      break;
    default:
  }
}

_id_8BC7() {
  switch (self._id_003B) {
    case "light_spot":
    case "script_vehicle":
    case "script_model":
      self show();
      break;
    case "script_brushmodel":
      self show();
      self solid();

      if(self.spawnflags & 1)
        self disconnectpaths();

      break;
    case "trigger_multiple_flag_looking":
    case "trigger_multiple_flag_lookat":
    case "trigger_multiple_breachIcon":
    case "trigger_multiple_flag_set":
    case "trigger_use":
    case "trigger_multiple":
    case "trigger_use_touch":
    case "trigger_radius":
      common_scripts\utility::_id_9DA3();
      break;
    default:
  }
}

_id_06B0(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    self rotateyaw(var_0, var_1, var_2, var_3);
  else if(isDefined(var_2))
    self rotateyaw(var_0, var_1, var_2);
  else
    self rotateyaw(var_0, var_1);
}

worldweaponsloaded(var_0, var_1, var_2) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(var_2) && var_2)
    thread _id_8531(var_0, var_1);

  if(!isDefined(self._id_64BB))
    self._id_64BB = self._id_64BA;

  if(isDefined(var_1)) {
    var_3 = var_0 - self._id_64BA;
    var_4 = 0.05;
    var_5 = var_1 / var_4;
    var_6 = var_3 / var_5;

    while(_abs(var_0 - self._id_64BA) > _abs(var_6 * 1.1)) {
      self._id_64BA = self._id_64BA + var_6;
      wait(var_4);
    }
  }

  self._id_64BA = var_0;
}

_id_7DE4(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(isDefined(var_1) && var_1)
    thread _id_7DE5(var_0);

  worldweaponsloaded(self._id_64BB, var_0, 0);
  self._id_64BB = undefined;
}

_id_8531(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if(!isDefined(self._id_64E0))
    self._id_64E0 = self._id_64DF;

  if(isDefined(var_1)) {
    var_2 = var_0 - self._id_64DF;
    var_3 = 0.05;
    var_4 = var_1 / var_3;
    var_5 = var_2 / var_4;

    while(_abs(var_0 - self._id_64DF) > _abs(var_5 * 1.1)) {
      self._id_64DF = self._id_64DF + var_5;
      wait(var_3);
    }
  }

  self._id_64DF = var_0;
}

_id_7DE5(var_0) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");
  _id_8531(self._id_64E0, var_0);
  self._id_64E0 = undefined;
}

_id_0FAA(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in var_0)
  var_7 thread _id_0961(var_1, var_2, var_3, var_4, var_5);
}

_id_0FAC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray(var_0, "targetname");
  _id_0FAA(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_0FAB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray(var_0, "script_noteworthy");
  _id_0FAA(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_3619() {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0A83(1);
    return;
  }

  self._id_3247 = 1;
}

_id_2F32() {
  if(_id_0290::_id_0AAE()) {
    _id_0290::_id_0A83(0);
    return;
  }

  self._id_3247 = undefined;
}

_id_27BF(var_0) {
  if(!isDefined(level._id_94E8))
    level._id_94E8 = [];

  var_1 = spawnStruct();
  var_1.name = var_0;
  level._id_94E8[var_0] = var_1;
  return var_1;
}

_id_27C6(var_0) {
  if(!isDefined(level._id_A565))
    level._id_A565 = [];

  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1._id_1105 = 0.0;
  var_1._id_110E = 0.0;
  var_1._id_110F = 0.0;
  var_1._id_1104 = 1.0;
  var_1._id_10FF = 0;
  var_1._id_1100 = 1.0;
  var_1._id_1101 = 0.0;
  var_1._id_111F = 0;
  var_1._id_1115 = 0.0;
  var_1._id_1116 = 0.0;
  var_1._id_1117 = 0.0;
  var_1._id_1120 = 0.0;
  var_1._id_111C = 0.0;
  var_1._id_111D = 0.0;
  var_1._id_111E = 0.0;
  var_1._id_1122 = 0.0;
  var_1._id_1125 = 0;
  var_1._id_1123 = (0, 0, 0);
  var_1._id_111B = 0;
  var_1._id_1124 = 0.0;
  var_1._id_1118 = 0.0;
  var_1._id_1119 = 0.0;
  var_1._id_111A = 0.0;
  var_1._id_1121 = 0.0;
  level._id_A565[_tolower(var_0)] = var_1;
  return var_1;
}

_id_43CB(var_0) {
  if(!isDefined(level._id_A565))
    level._id_A565 = [];

  var_1 = level._id_A565[_tolower(var_0)];

  if(_id_A251() && isDefined(var_1) && isDefined(var_1._id_4BD4))
    var_1 = level._id_A565[_tolower(var_1._id_4BD4)];

  return var_1;
}

_id_279B(var_0) {
  if(!isDefined(level._id_3DA7))
    level._id_3DA7 = [];

  var_1 = spawnStruct();
  var_1.name = var_0;
  level._id_3DA7[_tolower(var_0)] = var_1;
  return var_1;
}

_id_419B(var_0) {
  if(!isDefined(level._id_3DA7))
    level._id_3DA7 = [];

  var_1 = level._id_3DA7[_tolower(var_0)];
  return var_1;
}

_id_525B() {
  if(!isDefined(self._id_3DA9)) {
    self._id_3DA9 = spawnStruct();
    self._id_3DA9._id_3DAC = "";
    self._id_3DA9.time = 0;
  }
}

_id_A251() {
  if(!isDefined(level._id_258F))
    _id_843E();

  return _id_5583();
}

_id_3DA8(var_0, var_1) {
  if(!isPlayer(self))
    _id_0298::_id_51D3();
  else
    _id_525B();

  if(!isDefined(level._id_3DA7))
    level._id_3DA7 = [];

  var_2 = level._id_3DA7[_tolower(var_0)];

  if(!isDefined(var_2))
    var_2 = level._id_A565[_tolower(var_0)];

  if(isDefined(var_2) && isDefined(var_2._id_4BD4) && _id_A251()) {
    if(isDefined(level._id_3DA7[_tolower(var_2._id_4BD4)]))
      var_2 = level._id_3DA7[_tolower(var_2._id_4BD4)];
    else if(isDefined(level._id_A565))
      var_2 = level._id_A565[_tolower(var_2._id_4BD4)];
  }

  if(!isDefined(var_1))
    var_1 = var_2._id_9C83;

  if(!isPlayer(self)) {
    common_scripts\utility::finishentitydamage(var_2, var_1);
    level._id_3DA9._id_3DAC = var_0;
    level._id_3DA9.time = var_1;
  } else {
    if(var_0 != "" && self._id_3DA9._id_3DAC == var_0 && self._id_3DA9.time == var_1) {
      return;
    }
    common_scripts\utility::finishentitydamage(var_2, var_1);
    self._id_3DA9._id_3DAC = var_0;
    self._id_3DA9.time = var_1;
  }
}

_id_A566(var_0, var_1) {
  var_2 = _id_A564(var_0, var_1);

  if(var_2) {
    if(isDefined(_id_43CB(var_0)))
      _id_3DA8(var_0, var_1);
    else
      _clearfog(var_1);
  }
}

_id_525C() {
  if(!isDefined(self._id_A569)) {
    self._id_A569 = spawnStruct();
    self._id_A569._id_A563 = "";
    self._id_A569.time = 0;
  }
}

_id_A564(var_0, var_1) {
  if(!isPlayer(self)) {
    var_2 = 1;

    if(!isDefined(level._id_A569)) {
      level._id_A569 = spawnStruct();
      level._id_A569._id_A563 = "";
      level._id_A569.time = 0;
      var_2 = 0;
    }

    if(var_0 != "" && level._id_A569._id_A563 == var_0 && level._id_A569.time == var_1)
      return 0;

    level._id_A569._id_A563 = var_0;
    level._id_A569.time = var_1;

    if(var_2 && getdvarint("scr_art_tweak") != 0) {} else
      _visionsetnaked(var_0, var_1);

    level._id_5F53 = var_0;
    setDvar("vision_set_current", var_0);
  } else {
    _id_525C();

    if(var_0 != "" && self._id_A569._id_A563 == var_0 && self._id_A569.time == var_1)
      return 0;

    self._id_A569._id_A563 = var_0;
    self._id_A569.time = var_1;
    self visionsetnakedforplayer(var_0, var_1);
  }

  return 1;
}

_id_3647() {
  thread _id_3648();
}

_id_3648() {
  self endon("death");

  for(;;) {
    self._id_9855 = 1;
    waitframe();
  }
}

_id_2F60() {
  self._id_9855 = undefined;
}

_id_06A4(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    radiusdamage(var_0, var_1, var_2, var_3);
  else
    radiusdamage(var_0, var_1, var_2, var_3, var_4);
}

_id_6016(var_0) {
  var_1 = getEntArray("destructible_toy", "targetname");
  var_2 = getEntArray("destructible_vehicle", "targetname");
  var_3 = common_scripts\utility::_id_0F73(var_1, var_2);

  foreach(var_5 in var_0)
  var_5._id_2E27 = [];

  foreach(var_8 in var_3) {
    foreach(var_5 in var_0) {
      if(!var_5 istouching(var_8)) {
        continue;
      }
      var_5 _id_0322::_id_77C4(var_8);
      break;
    }
  }
}

_id_540C() {
  var_0 = [];
  var_0[0] = ["interactive_birds", "targetname"];
  var_0[1] = ["interactive_vulture", "targetname"];
  var_0[2] = ["interactive_fish", "script_noteworthy"];
  return var_0;
}

_id_6018(var_0) {
  var_1 = _id_540C();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = getEntArray(var_4[0], var_4[1]);
    var_2 = common_scripts\utility::_id_0F73(var_2, var_5);
  }

  foreach(var_8 in var_2) {
    if(!isDefined(level._id_065F[var_8._id_540A].setmode)) {
      continue;
    }
    foreach(var_11 in var_0) {
      if(!var_11 istouching(var_8)) {
        continue;
      }
      if(!isDefined(var_11._id_540D))
        var_11._id_540D = [];

      var_11._id_540D[var_11._id_540D.size] = var_8[[level._id_065F[var_8._id_540A].setmode]]();
    }
  }
}

_id_0896() {
  if(!isDefined(self._id_540D)) {
    return;
  }
  foreach(var_1 in self._id_540D)
  var_1[[level._id_065F[var_1._id_540A]._id_5DEB]]();

  self._id_540D = undefined;
}

_id_2D13(var_0) {
  _id_6018(var_0);

  foreach(var_2 in var_0)
  var_2._id_540D = undefined;
}

_id_6017(var_0) {
  if(getDvar("1459") != "") {
    return;
  }
  var_1 = getEntArray("script_brushmodel", "classname");
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++)
    var_1[var_1.size] = var_2[var_3];

  foreach(var_5 in var_0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7.physicslaunchserver))
        var_7.setdepthoffield = var_7.physicslaunchserver;

      if(!isDefined(var_7.setdepthoffield)) {
        continue;
      }
      if(!isDefined(var_7.model)) {
        continue;
      }
      if(var_7._id_003B != "script_model") {
        continue;
      }
      if(!var_7 istouching(var_5)) {
        continue;
      }
      var_7._id_6019 = 1;
    }
  }
}

_id_0892() {
  foreach(var_1 in level.createfxent) {
    if(!isDefined(var_1.v["masked_exploder"])) {
      continue;
    }
    if(!self _meth_858B(var_1.v["origin"])) {
      continue;
    }
    var_2 = var_1.v["masked_exploder"];
    var_3 = var_1.v["masked_exploder_spawnflags"];
    var_4 = var_1.v["masked_exploder_script_disconnectpaths"];
    var_5 = spawn("script_model", (0, 0, 0), var_3);
    var_5 setModel(var_2);
    var_5.origin = var_1.v["origin"];
    var_5.angles = var_1.v["angles"];
    var_1.v["masked_exploder"] = undefined;
    var_1.v["masked_exploder_spawnflags"] = undefined;
    var_1.v["masked_exploder_script_disconnectpaths"] = undefined;
    var_5._id_2FBF = var_4;
    var_5.setdepthoffield = var_1.v["exploder"];
    common_scripts\_exploder::_id_885C(var_5);
    var_1.model = var_5;
  }
}

_id_7642(var_0) {
  var_1 = _id_0286::_id_2E02(var_0);

  if(var_1 != -1) {
    return;
  }
  if(!isDefined(level._id_2DFA))
    level._id_2DFA = [];

  var_2 = spawnStruct();
  var_2._id_2E25 = _id_0286::_id_2E03(var_0);
  var_2 thread _id_0286::_id_7643();
  var_2 thread _id_0286::_id_091C();
}

_id_2D07(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3._id_2E27 = [];

  var_5 = ["destructible_toy", "destructible_vehicle"];
  var_6 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_8 in var_5) {
    var_9 = getEntArray(var_8, "targetname");

    foreach(var_11 in var_9) {
      foreach(var_3 in var_0) {
        if(var_1) {
          var_6++;
          var_6 = var_6 % 5;

          if(var_6 == 1)
            waitframe();
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

_id_2D0E(var_0, var_1) {
  var_2 = getEntArray("script_brushmodel", "classname");
  var_3 = getEntArray("script_model", "classname");

  for(var_4 = 0; var_4 < var_3.size; var_4++)
    var_2[var_2.size] = var_3[var_4];

  var_5 = [];
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  foreach(var_9 in var_0) {
    foreach(var_11 in var_2) {
      if(!isDefined(var_11.setdepthoffield)) {
        continue;
      }
      var_6.origin = var_11 getorigin();

      if(!var_9 istouching(var_6)) {
        continue;
      }
      var_5[var_5.size] = var_11;
    }
  }

  _id_0F7B(var_5);
  var_6 delete();
}

_id_0890() {
  if(!isDefined(self._id_2E27)) {
    return;
  }
  foreach(var_1 in self._id_2E27) {
    var_2 = spawn("script_model", (0, 0, 0));
    var_2 setModel(var_1._id_9B7A);
    var_2.origin = var_1.origin;
    var_2.angles = var_1.angles;
    var_2._id_0165 = var_1._id_0165;
    var_2.targetname = var_1.targetname;
    var_2.target = var_1.target;
    var_2.script_exploder = var_1.script_exploder;
    var_2._id_0075 = var_1._id_0075;
    var_2.setjitterparams = var_1.setjitterparams;
    var_2 _id_0286::_id_87D2(1);
  }

  self._id_2E27 = [];
}

_id_8684(var_0) {
  self._id_3D41 = var_0;
}

_id_3D40() {
  var_0 = self._id_3D48 - gettime();

  if(var_0 < 0)
    return 0;

  return var_0 * 0.001;
}

_id_3D42() {
  return _id_3D40() > 0;
}

_id_3D44(var_0) {
  if(isDefined(self._id_3D41) && self._id_3D41) {
    return;
  }
  var_1 = gettime() + var_0 * 1000.0;

  if(isDefined(self._id_3D48))
    self._id_3D48 = max(self._id_3D48, var_1);
  else
    self._id_3D48 = var_1;

  self notify("flashed");
  self setflashbanged(1);
}

_id_A76C() {
  for(;;) {
    var_0 = _getaispeciesarray("axis", "all");
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
      var_5 = _id_4069("axis");

      if(!var_5.size) {
        break;
      }
    }

    waitframe();
  }
}

_id_A76D() {
  var_0 = 0;

  for(;;) {
    var_1 = _getaispeciesarray("axis", "all");
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!isalive(var_4)) {
        continue;
      }
      if(var_4 istouching(self)) {
        if(var_4 _id_3201()) {
          continue;
        }
        var_2 = 1;
        var_0 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!var_2) {
      var_6 = _id_4069("axis");

      if(!var_6.size) {
        break;
      } else
        var_0 = 1;
    }

    waitframe();
  }

  return var_0;
}

_id_A76E(var_0) {
  _id_A76C();
  common_scripts\utility::flag_set(var_0);
}

_id_A762(var_0, var_1) {
  var_2 = _getent(var_0, "targetname");
  var_2 _id_A76E(var_1);
}

_id_7236() {
  level.player common_scripts\utility::_id_3796("player_zero_attacker_accuracy");
  level.player._id_00D1 = 0;
  level.player _id_02BA::_id_A0C1();
}

_id_723D() {
  level.player common_scripts\utility::_id_379A("player_zero_attacker_accuracy");
  level.player._id_0022 = 0;
  level.player._id_00D1 = 1;
}

isnoclip(var_0) {
  var_1 = _id_429A();
  var_1._id_489A._id_722F = var_0;
  var_1 _id_02BA::_id_A0C1();
}

_id_0F84(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_3.setlookatent] = var_3;

  return var_1;
}

_id_0F83(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_3.classname] = var_3;

  return var_1;
}

_id_0F85(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3.setmovespeedscale;

    if(isDefined(var_4))
      var_1[var_4] = var_3;
  }

  return var_1;
}

_id_096D(var_0) {
  if(isDefined(var_0))
    self._id_7001 = var_0;
  else
    self._id_7001 = _getent(self.target, "targetname");

  self linkto(self._id_7001);
}

_id_3D45() {
  self._id_3D48 = undefined;
  self setflashbanged(0);
}

_id_485C() {
  thread _id_36DC();
  self endon("end_explode");
  self waittill("explode", var_0);
  _id_2F11(var_0);
}

_id_36DC() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

_id_2F11(var_0) {
  _playrumbleonposition("grenade_rumble", var_0);
  _earthquake(0.3, 0.5, var_0, 400);

  foreach(var_2 in level.players) {
    if(distance(var_0, var_2.origin) > 600) {
      continue;
    }
    if(var_2 damageconetrace(var_0))
      var_2 thread _id_2F13(var_0);
  }
}

_id_7315(var_0, var_1, var_2, var_3) {
  return _id_7313("shotgun", level.player, var_0, var_1, var_2, var_3);
}

_id_7313(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1))
    var_1 = level.player;

  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 disableweapons();
  var_6 = common_scripts\utility::_id_8FFC();
  var_6 linkto(self, "tag_passenger", _id_7314(var_0), (0, 0, 0));
  var_6._id_725D = common_scripts\utility::_id_8FFC();
  var_6._id_725D linkto(self, "tag_body", _id_7312(var_0), (0, 0, 0));

  if(!isDefined(var_2))
    var_2 = 90;

  if(!isDefined(var_3))
    var_3 = 90;

  if(!isDefined(var_4))
    var_4 = 40;

  if(!isDefined(var_5))
    var_5 = 40;

  var_1 disableweapons();
  var_1 playerlinkto(var_6, "tag_origin", 0.8, var_2, var_3, var_4, var_5);
  var_1._id_4FA0 = var_6;
  return var_6;
}

_id_7314(var_0) {
  switch (var_0) {
    case "shotgun":
      return (-5, 10, -34);
    case "backleft":
      return (-45, 45, -34);
    case "backright":
      return (-45, 5, -34);
  }
}

_id_7312(var_0) {
  switch (var_0) {
    case "shotgun":
      return (-8, -90, -12.6);
    case "backleft":
      return (-58, 85, -12.6);
    case "backright":
      return (-58, -95, -12.6);
  }
}

_id_72DF(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = self;
  var_2 = level.player;

  if(isPlayer(self)) {
    var_2 = self;
    var_1 = var_2._id_4FA0;
  }

  var_1 unlink();

  if(!var_0) {
    var_3 = 0.6;
    var_1 moveto(var_1._id_725D.origin, var_3, var_3 * 0.5, var_3 * 0.5);
    wait(var_3);
  }

  var_2 unlink();
  var_2 enableweapons();
  var_2 allowcrouch(1);
  var_2 allowprone(1);
  var_2._id_4FA0 = undefined;
  var_1._id_725D delete();
  var_1 delete();
}

_id_2F13(var_0, var_1) {
  var_2 = enablebreaching(var_0);

  foreach(var_5, var_4 in var_2)
  thread _id_02BA::_id_485A(var_5);
}

_id_1800(var_0) {
  if(!isDefined(self._id_0063)) {
    return;
  }
  var_1 = enablebreaching(self._id_0063.origin);

  foreach(var_4, var_3 in var_1)
  thread _id_02BA::_id_17FB(var_4);
}

enablebreaching(var_0) {
  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];
  var_7 = self getcurrentweapon();

  if(var_4 > 0 && var_4 > 0.5 && _weapontype(var_7) != "riotshield")
    var_6["bottom"] = 1;

  if(_abs(var_4) < 0.866) {
    if(var_5 > 0)
      var_6["right"] = 1;
    else
      var_6["left"] = 1;
  }

  return var_6;
}

_id_6EF0(var_0) {
  if(!isDefined(self._id_6A44))
    self._id_6A44 = self._id_0121;

  self._id_0121 = var_0;
}

_id_6EF1() {
  if(isDefined(self._id_6A44)) {
    return;
  }
  self._id_6A44 = self._id_0121;
  self._id_0121 = 0;
}

_id_6EEF() {
  self._id_0121 = self._id_6A44;
  self._id_6A44 = undefined;
}

_id_A7BB() {
  if(isDefined(self._id_6A51)) {
    return;
  }
  self._id_6A50 = self._id_01CE;
  self._id_6A51 = self._id_01CF;
  self._id_01CE = 0;
  self._id_01CF = 0;
}

_id_A7B9() {
  if(!isDefined(self._id_6A51)) {
    self._id_6A50 = self._id_01CE;
    self._id_6A51 = self._id_01CF;
  }

  self._id_01CE = 999999999;
  self._id_01CF = 999999999;
}

_id_5656() {
  return isDefined(self._id_6A51) || isDefined(self._id_6A50);
}

_id_A7BA() {
  self._id_01CE = self._id_6A50;
  self._id_01CF = self._id_6A51;
  self._id_6A50 = undefined;
  self._id_6A51 = undefined;
}

_id_362F() {
  thread _id_509F();
}

_id_509F() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self._id_00D1 = 1;
  self._id_3A09 = self.health;
  self.health = 1000000;

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(!isPlayer(var_1) && _issentient(var_1)) {
      if(isDefined(var_1._id_0088) && var_1._id_0088 != self)
        continue;
    }

    self._id_3A09 = self._id_3A09 - var_0;

    if(self._id_3A09 <= 0) {
      break;
    }
  }

  self kill();
}

turretsetbarrelspinenabled(var_0) {
  self._id_01C0 = var_0;
}

_id_2F47() {
  if(!isalive(self)) {
    return;
  }
  if(!isDefined(self._id_00D1)) {
    return;
  }
  self notify("disable_ignorerandombulletdamage_drone");
  self._id_00D1 = undefined;
  self.health = self._id_3A09;
}

_id_9A03(var_0) {
  var_1 = spawnStruct();
  var_1 _id_2CED(var_0, ::setanimstate, "timeout");
  return var_1;
}

_id_2CED(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread _id_0322::_id_2CEF(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_2CC1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  childthread _id_0322::_id_2CC2(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_3CC9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");

  if(!_isarray(var_0))
    var_0 = [var_0, 0];

  thread _id_0322::_id_3CCA(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_A793(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");

  if(!_isarray(var_0))
    var_0 = [var_0, 0];

  thread _id_0322::_id_A794(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_3617(var_0) {
  var_0 = var_0 * 1000;
  self._id_007C = 1;
  self._id_006E = var_0;
  self._id_6684 = undefined;
}

_id_2F2F() {
  self._id_007C = 0;
  self._id_6684 = 1;
}

_id_84C8(var_0, var_1) {
  level._id_0A19 = var_0;
  level._id_0A18 = var_1;
}

_id_7D37(var_0) {
  level._id_5B6D[var_0] = gettime();
}

_id_844C(var_0) {
  level._id_296A = var_0;
  thread _id_02BA::_id_7D6E();
}

_id_23AF() {
  level._id_296A = undefined;
  thread _id_02BA::_id_7D6E();
}

_id_85F7(var_0, var_1, var_2) {
  _id_0295::_id_5287();

  if(isDefined(var_2))
    level._id_AA25._id_A2AD = var_2;

  level._id_AA25.rate = var_1;
  level._id_AA25._id_A9FE = var_0;
  level notify("windchange", "strong");
}

_id_9463(var_0) {
  if(var_0.size > 1)
    return 0;

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

  if(isDefined(var_1[var_0]))
    return 1;

  return 0;
}

disablemissileboosting(var_0, var_1) {
  level._id_1639[var_0] = var_1;
  _id_0322::_id_A096();
}

_id_690A(var_0) {
  for(var_1 = 0; var_1 < 8; var_1++)
    _objective_additionalposition(var_0, var_1, (0, 0, 0));
}

_id_6909(var_0, var_1) {
  _objective_additionalposition(var_0, var_1, (0, 0, 0));
}

_id_4219(var_0) {
  var_1 = [];
  var_1["minutes"] = 0;

  for(var_1["seconds"] = int(var_0 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60)
    var_1["minutes"]++;

  if(var_1["seconds"] < 10)
    var_1["seconds"] = "0" + var_1["seconds"];

  return var_1;
}

_id_729C(var_0) {
  var_1 = level.player getweaponlistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == var_0)
      return 1;
  }

  return 0;
}

_id_68A4(var_0) {
  if(var_0 == "main")
    return 31;

  if(!isDefined(level._id_68A7))
    level._id_68A7 = [];

  if(!isDefined(level._id_68A7[var_0]))
    level._id_68A7[var_0] = level._id_68A7.size + 1;

  return level._id_68A7[var_0];
}

_id_68C8(var_0) {
  return isDefined(level._id_68A7) && isDefined(level._id_68A7[var_0]);
}

_id_72EB(var_0) {
  self mountvehicle(var_0);
  self._id_3401 = var_0;
}

_id_725E() {
  self dismountvehicle();
  self._id_3401 = undefined;
}

_id_4842(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - var_2;
  var_6 = var_3 - var_1;
  var_7 = var_5 / var_6;
  var_0 = var_0 - var_3;
  var_0 = var_7 * var_0;
  var_0 = var_0 + var_4;
  return var_0;
}

_id_35FF() {
  self._id_7A70 = 1;
}

_id_2F17() {
  self._id_7A70 = undefined;
}

_id_3600(var_0) {
  var_0 _id_35FF();
}

_id_2F18(var_0) {
  var_0 _id_2F17();
}

_id_65BD(var_0) {
  var_1 = tablelookup("sound/soundlength.csv", 0, var_0, 1);

  if(!isDefined(var_1) || var_1 == "")
    return -1;

  var_1 = int(var_1);
  var_1 = var_1 * 0.001;
  return var_1;
}

_id_554A(var_0) {
  var_1 = _getkeybinding(var_0);
  return var_1["count"];
}

_id_2C8E(var_0) {
  level._id_5DEE = var_0;
}

_id_98DB(var_0) {
  _id_2C8E(var_0);
  level._id_98DC = var_0;
}

_id_98DD(var_0) {
  level._id_1364 = var_0;
}

_id_3F57(var_0, var_1) {
  thread _id_3F58(var_0, var_1);
}

_id_3F58(var_0, var_1) {
  var_2 = _getent(var_0, "script_noteworthy");
  var_2 notify("new_volume_command");
  var_2 endon("new_volume_command");
  waitframe();
  _id_3F56(var_2, var_1);
}

_id_3F56(var_0, var_1) {
  var_0._id_3F4A = 1;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1)
    _id_0FB3(var_0.fx, common_scripts\utility::pauseeffect);
  else
    common_scripts\utility::_id_0FB2(var_0.fx, common_scripts\utility::pauseeffect);
}

_id_0FB3(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(var_2))
    var_2 = 5;

  var_4 = [];

  foreach(var_6 in var_0) {
    var_4[var_4.size] = var_6;
    var_3++;
    var_3 = var_3 % var_2;

    if(var_2 == 0) {
      common_scripts\utility::_id_0FB2(var_4, var_1);
      waitframe();
      var_4 = [];
    }
  }
}

_id_3F5A(var_0) {
  thread _id_3F5B(var_0);
}

_id_3F5B(var_0) {
  var_1 = _getent(var_0, "script_noteworthy");
  var_1 notify("new_volume_command");
  var_1 endon("new_volume_command");
  waitframe();

  if(!isDefined(var_1._id_3F4A)) {
    return;
  }
  var_1._id_3F4A = undefined;
  _id_3F59(var_1);
}

_id_3F59(var_0) {
  common_scripts\utility::_id_0FB2(var_0.fx, ::_id_7DD3);
}

_id_3C7F(var_0) {
  if(!isDefined(level._id_3C7D))
    level._id_3C7D = [];

  if(!isDefined(level._id_3C7D[var_0]))
    level._id_3C7D[var_0] = 1;
  else
    level._id_3C7D[var_0]++;
}

_id_3C7E(var_0) {
  level._id_3C7D[var_0]--;
  level._id_3C7D[var_0] = int(max(0, level._id_3C7D[var_0]));

  if(level._id_3C7D[var_0]) {
    return;
  }
  common_scripts\utility::flag_set(var_0);
}

_id_3C80(var_0, var_1) {
  level._id_3C7D[var_0] = var_1;
}

_id_090C(var_0, var_1) {
  if(!isDefined(level._id_2359))
    level._id_2359 = [];

  if(!isDefined(level._id_2359[var_1]))
    level._id_2359[var_1] = [];

  level._id_2359[var_1][level._id_2359[var_1].size] = var_0;
}

_id_2359(var_0) {
  var_1 = level._id_2359[var_0];
  var_1 = common_scripts\utility::_id_0FA0(var_1);
  _id_0F7B(var_1);
  level._id_2359[var_0] = undefined;
}

_id_235B(var_0) {
  if(!isDefined(level._id_2359)) {
    return;
  }
  if(!isDefined(level._id_2359[var_0])) {
    return;
  }
  var_1 = level._id_2359[var_0];
  var_1 = common_scripts\utility::_id_0FA0(var_1);

  foreach(var_3 in var_1) {
    if(!_isai(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    if(!isDefined(var_3._id_5F6E)) {
      continue;
    }
    if(!var_3._id_5F6E) {
      continue;
    }
    var_3 _id_93D8();
  }

  _id_0F7B(var_1);
  level._id_2359[var_0] = undefined;
}

_id_0980(var_0) {
  if(!isDefined(self._id_9D83))
    thread _id_0322::_id_097F();

  self._id_9D83[self._id_9D83.size] = var_0;
}

_id_4410() {
  var_0 = [];
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.classname)) {
      continue;
    }
    if(issubstr(var_3.classname, "weapon_"))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_78B3(var_0) {
  level.forceusehintoff[var_0] = var_0;
}

_id_649A(var_0, var_1, var_2) {
  self notify("newmove");
  self endon("newmove");

  if(!isDefined(var_2))
    var_2 = 200;

  var_3 = distance(self.origin, var_0);
  var_4 = var_3 / var_2;
  var_5 = vectorNormalize(var_0 - self.origin);
  self moveto(var_0, var_4, 0, 0);
  self rotateto(var_1, var_4, 0, 0);
  wait(var_4);

  if(!isDefined(self)) {
    return;
  }
  self._id_01C9 = var_5 * (var_3 / var_4);
}

_id_3C8D(var_0) {
  level endon(var_0);
  self waittill("death");
  common_scripts\utility::flag_set(var_0);
}

_id_3615() {
  level._id_29C4 = 1;
}

_id_2F2D() {
  level._id_29C4 = 0;
}

_id_555C() {
  return isDefined(level._id_29C4) && level._id_29C4 && _id_448F() != "fu";
}

_id_3616() {
  level._id_29C5 = 1;
}

_id_2F2E() {
  level._id_29C5 = 0;
}

_id_555D() {
  return isDefined(level._id_29C5) && level._id_29C5 && _id_448F() != "fu";
}

_id_0915() {
  _id_02A7::_id_6377();
}

_id_7C7D() {
  _id_02A7::_id_940D();
}

_id_5567() {
  if(getDvar("2803") == "1")
    return 1;

  return 0;
}

_id_2D50(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B7(var_0, var_1);
  _id_2D51(var_3, var_2);
}

_id_2D4F(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0._id_0164;

  if(isDefined(var_1) && isDefined(level._id_947C["script_linkname"]) && isDefined(level._id_947C["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level._id_947C["script_linkname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level._id_947C["script_linkname"][var_1][var_4] = undefined;
    }

    if(level._id_947C["script_linkname"][var_1].size == 0)
      level._id_947C["script_linkname"][var_1] = undefined;
  }

  var_1 = var_0._id_0165;

  if(isDefined(var_1) && isDefined(level._id_947C["script_noteworthy"]) && isDefined(level._id_947C["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level._id_947C["script_noteworthy"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level._id_947C["script_noteworthy"][var_1][var_4] = undefined;
    }

    if(level._id_947C["script_noteworthy"][var_1].size == 0)
      level._id_947C["script_noteworthy"][var_1] = undefined;
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level._id_947C["target"]) && isDefined(level._id_947C["target"][var_1])) {
    foreach(var_4, var_3 in level._id_947C["target"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level._id_947C["target"][var_1][var_4] = undefined;
    }

    if(level._id_947C["target"][var_1].size == 0)
      level._id_947C["target"][var_1] = undefined;
  }

  var_1 = var_0.targetname;

  if(isDefined(var_1) && isDefined(level._id_947C["targetname"]) && isDefined(level._id_947C["targetname"][var_1])) {
    foreach(var_4, var_3 in level._id_947C["targetname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3)
        level._id_947C["targetname"][var_1][var_4] = undefined;
    }

    if(level._id_947C["targetname"][var_1].size == 0)
      level._id_947C["targetname"][var_1] = undefined;
  }

  if(isDefined(level.struct)) {
    foreach(var_4, var_3 in level.struct) {
      if(var_0 == var_3)
        level.struct[var_4] = undefined;
    }
  }
}

_id_2D51(var_0, var_1) {
  if(!isDefined(var_0) || !_isarray(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = common_scripts\utility::_id_98E7(isDefined(var_1), var_1, 0);
  var_1 = common_scripts\utility::_id_98E7(var_1 > 0, var_1, 0);

  if(var_1 > 0) {
    foreach(var_3 in var_0) {
      _id_2D4F(var_3);
      wait(var_1);
    }
  } else {
    foreach(var_3 in var_0)
    _id_2D4F(var_3);
  }
}

_id_46B6(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B5(var_0, var_1);
  _id_2D4F(var_2);
  return var_2;
}

_id_46B8(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B7(var_0, var_1);
  _id_2D51(var_3, var_2);
  return var_3;
}

_id_8677(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3))
    self._id_37D4 = var_3;
  else
    self._id_37D4 = (0, 0, 0);

  if(isDefined(var_4))
    self._id_37D5 = var_4;

  self notify("new_head_icon");
  var_5 = newhudelem();
  var_5.archived = 1;
  var_5.alpha = 0.8;
  var_5 setshader(var_0, var_1, var_2);
  var_5 setwaypoint(0, 0, 0, 1);
  self._id_37D3 = var_5;
  _id_A110();
  thread _id_A10F();
  thread _id_2DCD();
}

_id_7CDA() {
  if(!isDefined(self._id_37D3)) {
    return;
  }
  self._id_37D3 destroy();
}

_id_A10F() {
  self endon("new_head_icon");
  self endon("death");
  var_0 = self.origin;

  for(;;) {
    if(var_0 != self.origin) {
      _id_A110();
      var_0 = self.origin;
    }

    waitframe();
  }
}

_id_A110() {
  if(isDefined(self._id_37D5)) {
    var_0 = self[[self._id_37D5]]();

    if(isDefined(var_0)) {
      self._id_37D3.x = self._id_37D4[0] + var_0[0];
      self._id_37D3.y = self._id_37D4[1] + var_0[1];
      self._id_37D3._id_01D9 = self._id_37D4[2] + var_0[2];
      return;
    }
  }

  self._id_37D3.x = self.origin[0] + self._id_37D4[0];
  self._id_37D3.y = self.origin[1] + self._id_37D4[1];
  self._id_37D3._id_01D9 = self.origin[2] + self._id_37D4[2];
}

_id_2DCD() {
  self endon("new_head_icon");
  self waittill("death");

  if(!isDefined(self._id_37D3)) {
    return;
  }
  self._id_37D3 destroy();
}

_id_AA8C(var_0) {
  var_1 = var_0 - self.origin;
  return (vectordot(var_1, anglesToForward(self.angles)), -1.0 * vectordot(var_1, anglestoright(self.angles)), vectordot(var_1, anglestoup(self.angles)));
}

_id_5495(var_0, var_1, var_2, var_3, var_4) {
  level._id_54C9 = spawnStruct();
  level._id_54C9._id_2567 = 3;
  level._id_54C9._id_39BC = 1.5;
  level._id_54C9._id_39B7 = undefined;

  if(isDefined(var_3))
    level._id_54C9._id_5D99 = [var_0, var_1, var_2, var_3];
  else
    level._id_54C9._id_5D99 = [var_0, var_1, var_2];

  common_scripts\utility::_id_6753(level._id_54C9._id_5D99, ::precachestring);
}

_id_5496(var_0) {
  level._id_54C9._id_297B = var_0;
}

_id_5497(var_0, var_1, var_2) {
  level._id_54C9._id_2567 = var_0;
  level._id_54C9._id_39BC = var_1;
  level._id_54C9._id_39B7 = var_2;
}

finishagentdamage_impactfx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1))
    self._id_7F6A = var_1;

  if(isDefined(var_2))
    self._id_A7B7 = var_2;

  if(isDefined(var_3))
    self._id_90D1 = var_3;

  self._id_0E94 = var_0;
  var_10 = [];

  if(isDefined(var_4) && isDefined(var_5)) {
    var_11 = [];

    foreach(var_13 in var_6)
    var_11[var_13] = var_4;

    var_10["cover_trans"] = var_11;
    var_15 = [];

    foreach(var_13 in var_6)
    var_15[var_13] = var_5;

    var_10["cover_exit"] = var_15;
  } else if(isDefined(var_4) || isDefined(var_5)) {}

  if(isDefined(var_7)) {
    if(isDefined(var_8)) {}

    var_10["run_turn"] = var_7;
    var_10["walk_turn"] = var_8;
    self._id_6818 = undefined;
  } else if(isDefined(var_8)) {} else
    self._id_6818 = 1;

  if(isDefined(var_9)) {
    var_18 = [];
    var_18["stairs_up"] = var_9["stairs_up"];
    var_18["stairs_down"] = var_9["stairs_down"];
    var_18["stairs_up_in"] = var_9["stairs_up_in"];
    var_18["stairs_down_in"] = var_9["stairs_down_in"];
    var_18["stairs_up_out"] = var_9["stairs_up_out"];
    var_18["stairs_down_out"] = var_9["stairs_down_out"];
    var_10["walk"] = var_18;
    var_10["run"] = var_18;
    self._id_7F6B = 1;
  } else
    self._id_7F6B = undefined;

  anim._id_0F4A[var_0] = var_10;
}

_id_23C5(var_0) {
  self._id_0E94 = undefined;
  anim._id_0F4A[var_0] = undefined;
  self._id_7F6A = undefined;
  self._id_7F6B = undefined;
  self._id_A7B7 = undefined;
  self._id_90D1 = undefined;
}

_id_7B9B(var_0, var_1, var_2) {}

_id_0F49(var_0) {}

_id_8417(var_0) {}

_id_23A4() {
  if(isDefined(self._id_0E94) && self._id_0E94 == "creepwalk")
    self._id_017C = 30;

  self._id_0E94 = undefined;
  self notify("move_loop_restart");
}

_id_8B2F(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 _id_8B30(var_0, var_1))
      return 1;
  }

  return 0;
}

_id_8B30(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 60;

  var_3 = self getpointinbounds(0, 0, 0);
  var_4 = var_3 - var_0;
  var_5 = length(var_4);
  var_6 = _asin(clamp(var_2 / var_5, 0, 1));

  if(vectordot(vectorNormalize(var_4), vectorNormalize(var_1 - var_0)) > _cos(var_6))
    return 1;

  return 0;
}

_id_9C60(var_0) {
  _loadtransient(var_0);

  while(!_istransientloaded(var_0))
    wait 0.1;

  common_scripts\utility::flag_set(var_0 + "_loaded");
}

_id_9C62(var_0) {
  _unloadtransient(var_0);

  while(_istransientloaded(var_0))
    wait 0.1;

  common_scripts\utility::_id_3C7B(var_0 + "_loaded");
}

_id_9C5F(var_0) {
  common_scripts\utility::flag_init(var_0 + "_loaded");
}

_id_9C61(var_0, var_1) {
  if(common_scripts\utility::_id_3C77(var_0 + "_loaded"))
    _id_9C62(var_0);

  if(!common_scripts\utility::_id_3C77(var_1 + "_loaded"))
    _id_9C60(var_1);
}

_id_9C63(var_0) {
  _unloadalltransients();
  _id_9C60(var_0);
}

_id_2B7A(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4)) {
        if(_isarray(var_4)) {
          _id_2B7A(var_4, var_1);
          continue;
        }

        var_4 call[[var_1]]();
      }
    }
  } else {
    switch (var_2.size) {
      case 0:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7A(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]]();
          }
        }

        break;
      case 1:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7A(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0]);
          }
        }

        break;
      case 2:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7A(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1]);
          }
        }

        break;
      case 3:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7A(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2]);
          }
        }

        break;
      case 4:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7A(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
          }
        }

        break;
      case 5:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7A(var_4, var_1, var_2);
              continue;
            }

            var_4 call[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
          }
        }

        break;
    }
  }
}

_id_2B7B(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4)) {
        if(_isarray(var_4)) {
          _id_2B7B(var_4, var_1, var_2);
          continue;
        }

        var_4 thread[[var_1]]();
      }
    }
  } else {
    switch (var_2.size) {
      case 0:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7B(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]]();
          }
        }

        break;
      case 1:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7B(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0]);
          }
        }

        break;
      case 2:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7B(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1]);
          }
        }

        break;
      case 3:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7B(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2]);
          }
        }

        break;
      case 4:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7B(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
          }
        }

        break;
      case 5:
        foreach(var_4 in var_0) {
          if(isDefined(var_4)) {
            if(_isarray(var_4)) {
              _id_2B7B(var_4, var_1, var_2);
              continue;
            }

            var_4 thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
          }
        }

        break;
    }
  }
}

_id_8670(var_0, var_1, var_2) {
  if(!isDefined(level._id_258F))
    _id_843E();

  if(_id_5583())
    setDvar(var_0, var_2);
  else
    setDvar(var_0, var_1);
}

_id_871B(var_0, var_1, var_2) {
  if(!isDefined(level._id_258F))
    _id_843E();

  if(_id_5583())
    _setsaveddvar(var_0, var_2);
  else
    _setsaveddvar(var_0, var_1);
}

_id_3DC5(var_0, var_1) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait 0.1;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;

  if(!isDefined(var_1))
    var_1 = 300;

  self._id_28F9 = var_2;
  var_2 common_scripts\utility::script_delay();

  while(isDefined(var_2)) {
    self._id_28F9 = var_2;

    if(isDefined(var_2._id_00F0)) {
      break;
    }

    if(isDefined(level._id_947C["targetname"][var_2.targetname]))
      var_4 = ::_id_3DC8;
    else if(isDefined(var_2.classname))
      var_4 = ::_id_3DC6;
    else
      var_4 = ::_id_3DC7;

    if(isDefined(var_2.radius) && var_2.radius != 0)
      self._id_00AE = var_2.radius;

    if(self._id_00AE < 16)
      self._id_00AE = 16;

    if(isDefined(var_2._id_00BD) && var_2._id_00BD != 0)
      self._id_00AC = var_2._id_00BD;

    var_5 = self._id_00AE;
    self childthread[[var_4]](var_2);

    if(isDefined(var_2.animation))
      var_2 waittill(var_2.animation);
    else {
      for(;;) {
        self waittill("goal");

        if(distance(var_2.origin, self.origin) < var_5 + 10 || self.team != "allies") {
          break;
        }
      }
    }

    var_2 notify("trigger", self);

    if(isDefined(var_2._id_81A0))
      common_scripts\utility::flag_set(var_2._id_81A0);

    if(isDefined(var_2.setlookatent)) {
      var_6 = strtok(var_2.setlookatent, " ");

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        if(isDefined(level._id_2967))
          self[[level._id_2967]](var_6[var_7], var_2);

        if(self.type == "dog") {
          continue;
        }
        switch (var_6[var_7]) {
          case "enable_cqb":
            _id_3612();
            break;
          case "disable_cqb":
            _id_2F2B();
            break;
          case "deleteme":
            self delete();
            return;
        }
      }
    }

    if(!isDefined(var_2.vehicle_teleport) && var_1 > 0 && self.team == "allies") {
      while(isalive(level.player)) {
        if(_id_3DC9(var_2, var_1)) {
          break;
        }

        if(isDefined(var_2.animation)) {
          self._id_00AE = var_5;
          self setgoalpos(self.origin);
        }

        waitframe();
      }
    }

    if(!isDefined(var_2.target)) {
      break;
    }

    if(isDefined(var_2.setgoalentity))
      common_scripts\utility::_id_3C9F(var_2.setgoalentity);

    var_2 common_scripts\utility::script_delay();
    var_2 = var_2 common_scripts\utility::_id_4375();
  }

  self notify("path_end_reached");
}

_id_3DC9(var_0, var_1) {
  if(distance(level.player.origin, var_0.origin) < distance(self.origin, var_0.origin))
    return 1;

  var_2 = undefined;
  var_2 = anglesToForward(self.angles);
  var_3 = vectorNormalize(level.player.origin - self.origin);

  if(isDefined(var_0.target)) {
    var_4 = common_scripts\utility::_id_4375(var_0.target);
    var_2 = vectorNormalize(var_4.origin - var_0.origin);
  } else if(isDefined(var_0.angles))
    var_2 = anglesToForward(var_0.angles);
  else
    var_2 = anglesToForward(self.angles);

  if(vectordot(var_2, var_3) > 0)
    return 1;

  if(distance(level.player.origin, self.origin) < var_1)
    return 1;

  return 0;
}

_id_3DC7(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 _id_0293::_id_0E0F(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.setlookatent) && issubstr(var_0.setlookatent, "gravity"))
      var_0 _id_0293::_id_0E0B(self, var_0.animation);
    else
      var_0 _id_0293::_id_0E11(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    setdemigod(var_0);
}

_id_3DC6(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 _id_0293::_id_0E0F(self, var_0.animation);
    self notify("starting_anim", var_0.animation);

    if(isDefined(var_0.setlookatent) && issubstr(var_0.setlookatent, "gravity"))
      var_0 _id_0293::_id_0E0B(self, var_0.animation);
    else
      var_0 _id_0293::_id_0E11(self, var_0.animation);

    self setgoalpos(self.origin);
  } else
    _id_84BA(var_0);
}

_id_3DC8(var_0) {
  self notify("follow_path_new_goal");

  if(isDefined(var_0.animation)) {
    var_0 _id_0293::_id_0E0F(self, var_0.animation);
    self notify("starting_anim", var_0.animation);
    _id_2F36();

    if(isDefined(var_0.setlookatent) && issubstr(var_0.setlookatent, "gravity"))
      var_0 _id_0293::_id_0E0B(self, var_0.animation);
    else
      var_0 _id_0293::_id_0E11(self, var_0.animation);

    _id_2CED(0.05, ::_id_361D);
    self setgoalpos(self.origin);
  } else
    setviewmodelanim(var_0.origin);
}

_id_75CE(var_0) {
  if(!isDefined(level._id_75CD))
    level._id_75CD = [];

  level._id_75CD = common_scripts\utility::_id_0F6F(level._id_75CD, var_0);
}

_id_5CA2(var_0, var_1) {
  thread _id_5CA3(var_0, var_1);
}

_id_5CA3(var_0, var_1) {
  self notify("new_lerp_Fov_Saved");
  self endon("new_lerp_Fov_Saved");
  self lerpfov(var_0, var_1);
  wait(var_1);
  _setsaveddvar("cg_fov", var_0);
}

_id_44A9(var_0, var_1) {
  var_2 = getDvar(var_0);

  if(var_2 != "")
    return _float(var_2);

  return var_1;
}

_id_44AA(var_0, var_1) {
  var_2 = getDvar(var_0);

  if(var_2 != "")
    return int(var_2);

  return var_1;
}

_id_9FED(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "on");
}

_id_9FEC(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "turn_off");
}

_id_9FEE(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setDvar(var_1, "onetime");
}

_id_94C1(var_0, var_1, var_2, var_3) {
  if(!_isarray(var_0))
    var_0 = [var_0];

  var_4 = 320;
  var_5 = 200;
  var_6 = [];

  foreach(var_10, var_8 in var_0) {
    var_9 = _id_02CB::_id_94C3(var_8, var_1, var_4, var_5 + var_10 * 20, "center", var_2, var_3);
    var_6 = common_scripts\utility::_id_0F73(var_9, var_6);
  }

  wait(var_1);
  _id_02CB::_id_94C2(var_6, var_4, var_5, var_0.size);
}

_id_2076(var_0) {
  thread _id_02CB::_id_206F(var_0);
}

_id_363E(var_0) {
  if(!clientclaimtrigger()) {
    return;
  }
  if(isDefined(self._id_60B9) && self._id_60B9) {
    return;
  }
  if(!level._id_010B) {
    return;
  }
  if(isDefined(var_0) && var_0) {
    if(!isDefined(self._id_0E94) || self._id_0E94 == "soldier")
      self._id_0E94 = "s1_soldier";
  } else if(!isDefined(self._id_0E94) || self._id_0E94 == "s1_soldier")
    self._id_0E94 = "soldier";
}

clientclaimtrigger() {
  return 0;
}

_id_0AAA() {
  if(isDefined(self.setthreatbiasgroup)) {
    return;
  }
  if(isDefined(self._id_0651))
    _id_0B20();

  self._id_0651 = [];
  self._id_0078 = _id_0322::_id_0AC9(self._id_0078, "disableplayeradsloscheck", 1);
  self._id_00CA = _id_0322::_id_0AC9(self._id_00CA, "ignoreall", 1);
  self._id_00CE = _id_0322::_id_0AC9(self._id_00CE, "ignoreme", 1);
  self._id_00B3 = _id_0322::_id_0AC9(self._id_00B3, "grenadeawareness", 0);
  self._id_0028 = _id_0322::_id_0AC9(self._id_0028, "badplaceawareness", 0);
  self._id_00CC = _id_0322::_id_0AC9(self._id_00CC, "ignoreexplosionevents", 1);
  self._id_00D1 = _id_0322::_id_0AC9(self._id_00D1, "ignorerandombulletdamage", 1);
  self._id_00D2 = _id_0322::_id_0AC9(self._id_00D2, "ignoresuppression", 1);
  self._id_007F = _id_0322::_id_0AC9(self._id_007F, "dontavoidplayer", 1);
  self._id_6694 = _id_0322::_id_0AC9(self._id_6694, "newEnemyReactionDistSq", 0);
  self._id_2F73 = _id_0322::_id_0AC9(self._id_2F73, "disableBulletWhizbyReaction", 1);
  self._id_2F86 = _id_0322::_id_0AC9(self._id_2F86, "disableFriendlyFireReaction", 1);
  self._id_324A = _id_0322::_id_0AC9(self._id_324A, "dontMelee", 1);
  self._id_3D41 = _id_0322::_id_0AC9(self._id_3D41, "flashBangImmunity", 1);
  self._id_007C = _id_0322::_id_0AC9(self._id_007C, "doDangerReact", 0);
  self._id_6684 = _id_0322::_id_0AC9(self._id_6684, "neverSprintForVariation", 1);
  self._id_0794._id_2F95 = _id_0322::_id_0AC9(self._id_0794._id_2F95, "a.disablePain", 1);
  self._id_0016 = _id_0322::_id_0AC9(self._id_0016, "allowPain", 0);
  self._id_0098 = _id_0322::_id_0AC9(self._id_0098, "fixedNode", 1);
  self.enableaimassist = _id_0322::_id_0AC9(self.enableaimassist, "script_forcegoal", 1);
  self._id_00AE = _id_0322::_id_0AC9(self._id_00AE, "goalradius", 5);
  _id_2F19();
}

_id_0B20(var_0) {
  if(isDefined(self.setthreatbiasgroup)) {
    return;
  }
  if(isDefined(var_0) && var_0) {
    if(isDefined(self._id_0651))
      self._id_0651 = undefined;
  }

  self._id_0078 = _id_0322::_id_0AC7("disableplayeradsloscheck", 0);
  self._id_00CA = _id_0322::_id_0AC7("ignoreall", 0);
  self._id_00CE = _id_0322::_id_0AC7("ignoreme", 0);
  self._id_00B3 = _id_0322::_id_0AC7("grenadeawareness", 1);
  self._id_0028 = _id_0322::_id_0AC7("badplaceawareness", 1);
  self._id_00CC = _id_0322::_id_0AC7("ignoreexplosionevents", 0);
  self._id_00D1 = _id_0322::_id_0AC7("ignorerandombulletdamage", 0);
  self._id_00D2 = _id_0322::_id_0AC7("ignoresuppression", 0);
  self._id_007F = _id_0322::_id_0AC7("dontavoidplayer", 0);
  self._id_6694 = _id_0322::_id_0AC7("newEnemyReactionDistSq", 262144);
  self._id_2F73 = _id_0322::_id_0AC7("disableBulletWhizbyReaction", undefined);
  self._id_2F86 = _id_0322::_id_0AC7("disableFriendlyFireReaction", undefined);
  self._id_324A = _id_0322::_id_0AC7("dontMelee", undefined);
  self._id_3D41 = _id_0322::_id_0AC7("flashBangImmunity", undefined);
  self._id_007C = _id_0322::_id_0AC7("doDangerReact", 1);
  self._id_6684 = _id_0322::_id_0AC7("neverSprintForVariation", undefined);
  self._id_0794._id_2F95 = _id_0322::_id_0AC7("a.disablePain", 0);
  self._id_0016 = _id_0322::_id_0AC7("allowPain", 1);
  self._id_0098 = _id_0322::_id_0AC7("fixedNode", 0);
  self.enableaimassist = _id_0322::_id_0AC7("script_forcegoal", 0);
  self._id_00AE = _id_0322::_id_0AC7("goalradius", 100);
  _id_3601();
  self._id_0651 = undefined;
}

_id_1135(var_0) {
  var_1 = level.player getcurrentweapon();
  var_2 = _getweaponandattachmentmodels(var_1);
  var_3 = var_2[0]["weapon"];
  var_4 = common_scripts\utility::_id_0F9A(var_2, 0);
  self attach(var_3, var_0, 1);

  foreach(var_6 in var_4)
  self attach(var_6["attachment"], var_6["attachTag"]);

  self hideweapontags(var_1);
}

_id_113B(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = _getweaponandattachmentmodels(var_0);

  if(!isDefined(var_2) || var_2 == 0)
    var_5 = var_4[0]["weapon"];
  else
    var_5 = var_4[0]["worldModel"];

  var_6 = common_scripts\utility::_id_0F9A(var_4, 0);
  var_3 attach(var_5, var_1, 1);

  foreach(var_9, var_8 in var_6) {
    if(!isDefined(var_2) || var_2 == 0) {
      var_3 attach(var_8["attachment"], var_8["attachTag"]);
      continue;
    }

    var_3 attach(var_8["worldModel"], var_8["attachTag"]);
  }
}

_id_73B2(var_0, var_1) {
  _id_0693("weaponPickup", var_0, var_1, ::_id_0599, 0);
}

_id_0599(var_0) {
  if(var_0)
    self enableweaponpickup();
  else
    self disableweaponpickup();
}

_id_0693(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._id_73D4))
    self._id_73D4 = [];

  if(!isDefined(self._id_73D4[var_0]))
    self._id_73D4[var_0] = [];

  if(!isDefined(var_2))
    var_2 = "default";

  if(var_1) {
    self._id_73D4[var_0] = common_scripts\utility::_id_0F93(self._id_73D4[var_0], var_2);

    if(!self._id_73D4[var_0].size) {
      if(!isDefined(var_4) || var_4)
        self call[[var_3]](1);
      else
        self[[var_3]](1);
    }
  } else {
    if(!isDefined(common_scripts\utility::_id_0F7E(self._id_73D4[var_0], var_2)))
      self._id_73D4[var_0] = common_scripts\utility::_id_0F6F(self._id_73D4[var_0], var_2);

    if(!isDefined(var_4) || var_4)
      self call[[var_3]](0);
    else
      self[[var_3]](0);
  }
}

_id_76B5() {
  if(!isalive(self)) {
    return;
  }
  self._id_76B6 = 1;
  self _meth_84EF("disable");
  self disableaimassist();
  self._id_00CE = 1;
  self._id_50A1 = 1;
}

_id_9932() {
  _precacheshader("loading_animation");
  common_scripts\utility::flag_init("tff_sync_complete");
  _id_0322::_id_072D();
}

_id_9930(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  if(_aretransientsbusy()) {
    common_scripts\utility::_id_3C7B("tff_sync_complete");
    _synctransients();

    while(_aretransientsbusy())
      waitframe();

    common_scripts\utility::flag_set("tff_sync_complete");
  }
}

_id_9931(var_0, var_1) {
  _id_9930(var_1);
}

_id_5E8C() {
  level.player endon("death");

  for(;;) {
    var_0 = _getspcheckpointdata();
    var_1 = var_0[4];
    var_2 = gettime();
    _recordbreadcrumbdataforplayersp(level.player, var_1, var_2);
    wait 2;
  }
}

_id_44C6(var_0) {
  if(!isDefined(var_0))
    return undefined;

  return _getent(var_0, "targetname");
}

_id_45B3(var_0) {
  if(!isDefined(var_0))
    return undefined;

  return _getnode(var_0, "targetname");
}

_id_45B2(var_0) {
  if(!isDefined(var_0))
    return undefined;

  return _getnode(var_0, "script_noteworthy");
}

_id_44C3(var_0) {
  if(!isDefined(var_0))
    return undefined;

  return getEntArray(var_0, "targetname");
}

_id_44C5(var_0) {
  if(!isDefined(var_0))
    return undefined;

  return _getent(var_0, "script_noteworthy");
}

_id_44C2(var_0) {
  if(!isDefined(var_0))
    return undefined;

  return getEntArray(var_0, "script_noteworthy");
}

_id_4677(var_0) {
  if(!isDefined(var_0))
    return undefined;

  var_1 = _getscriptablearray(var_0, "targetname");
  return var_1[0];
}

_id_4676(var_0) {
  if(!isDefined(var_0))
    return undefined;

  var_1 = _getscriptablearray(var_0, "script_noteworthy");
  return var_1[0];
}

_id_9437(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("end_story_mode");
  var_8 = 0;

  if(!isDefined(var_1))
    var_1 = 150;

  if(var_1 == 0)
    var_8 = 1;

  if(!isDefined(var_6))
    var_6 = 0;

  if(!isDefined(var_7))
    var_7 = 0;

  if(!var_8) {
    while(distance(level.player.origin, var_0) > var_1)
      waitframe();
  }

  if(!isDefined(var_3))
    var_3 = 0.3;

  if(!isDefined(var_2))
    var_2 = 0.01;

  if(!isDefined(var_4))
    var_4 = 0.3;

  if(!isDefined(var_5))
    var_5 = 0.3;

  level.player enableslowaim(var_4, var_5);
  level.player _id_1791(var_3, 0.5);
  _id_727E(1);
  level.player allowsprint(var_6);
  level.player allowdodge(var_6);
  level.player allowjump(var_6);
  level.player allowprone(var_6);
  level.player allowmelee(var_7);
  level.player allowfire(var_7);
  level.player allowads(var_7);

  if(isDefined(var_7) || var_7 != 1)
    level.player disableoffhandweapons();

  wait 0.5;

  if(!var_8) {
    var_9 = distance(level.player.origin, var_0) - var_1;
    var_10 = 0;
    var_11 = 1;
    var_12 = 0;

    for(;;) {
      if(distance(level.player.origin, var_0) > var_1) {
        var_13 = distance(level.player.origin, var_0);
        var_13 = var_13 - var_1;

        if(var_13 < var_9) {
          var_10 = 0;
          level.player _id_1791(var_3, 0.5);
        } else if(!var_10) {
          var_10 = 1;
          _id_1791(var_2, 0.5);
        }

        var_9 = var_13;
      } else {
        level.player setmovespeedscale(var_3);
        var_9 = distance(level.player.origin, var_0) - var_1;
      }

      waitframe();
    }
  }
}

_id_9436(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 0;

  level notify("end_story_mode");
  level.player enableslowaim(var_1, var_2);
  level.player _id_1791(var_0, 2);
  _id_727E(var_3);
  level.player allowsprint(1);
  level.player allowdodge(1);
  level.player allowjump(1);
  level.player allowprone(1);
  level.player allowmelee(1);
  level.player allowfire(1);
  level.player allowads(1);
  level.player enableoffhandweapons();
}

_id_727E(var_0) {
  if(!isDefined(var_0) || !var_0)
    _setsaveddvar("414", -1);
  else
    _setsaveddvar("414", 0);
}

_id_9438(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("end_speed_control");
  level thread _id_4981(var_2);
  level thread _id_9437(level.player.origin, 0, 0.23, 0.24, 0.7, 0.7, var_4, var_5);
  var_0 thread _id_90E5();
  wait 0.1;
  var_6 = 0.01;

  if(!isDefined(var_3))
    var_3 = 0.8;

  var_7 = 0;
  var_8 = 220;
  var_9 = 130;
  var_10 = 20;
  var_11 = 200;
  level.player setmovespeedscale(0.3);

  if(!isDefined(var_4))
    var_4 = 0;

  level.player allowsprint(var_4);
  level._id_3DD2 = getEntArray(var_1, "script_noteworthy");

  for(;;) {
    if(var_4) {
      if(distancesquared(level.player.origin, var_0.origin) > var_9 * var_9)
        level.player allowsprint(1);
      else
        level.player allowsprint(0);
    }

    if(level._id_3DD0 || level._id_3DD1 || level._id_3DCF) {
      var_12 = vectorNormalize(anglesToForward(_sortbydistance(level._id_3DD2, var_0._id_00AD)[0].angles) + vectorNormalize(var_0.origin - level.player.origin));
      var_13 = 0 - _id_8C51(var_0.origin, var_12, level.player.origin);
      wait 0.1;
    } else {
      var_12 = vectorNormalize(anglesToForward(var_0.angles) + vectorNormalize(var_0.origin - level.player.origin));
      var_13 = 0 - _id_8C51(var_0.origin, var_12, level.player.origin);
    }

    var_14 = common_scripts\utility::_id_5D93(var_13, var_7, var_8, var_6, var_3);
    waittillframeend;
    level.player setmovespeedscale(var_14);
    waitframe();
  }

  level.player setmovespeedscale(1);
}

_id_4981(var_0) {
  common_scripts\utility::_id_3C9F(var_0);
  _id_9436();
  level notify("end_speed_control");
}

_id_90E5() {
  var_0 = 20;
  var_1 = var_0 * var_0;
  level endon("end_speed_control");
  level._id_3DD0 = 0;
  childthread _id_90E7();
  childthread _id_90E6();
  wait 0.2;

  for(;;) {
    self waittill("goal");
    level._id_3DD0 = 1;
    self waittill("goal_changed");
    level._id_3DD0 = 0;
    wait 3;
  }
}

_id_90E6() {
  level endon("end_speed_control");
  level._id_3DD1 = 0;

  for(;;) {
    common_scripts\utility::_id_A732("goal_changed", "goal");
    level._id_3DD1 = 1;
    wait 3;
    level._id_3DD1 = 0;
  }
}

_id_90E7() {
  level endon("end_speed_control");
  var_0 = 0;
  var_1 = 150;
  var_2 = var_1 * var_1;
  level._id_3DCF = 0;

  for(;;) {
    self waittill("goal_changed");
    level._id_3DCF = 0;
    var_0 = 1;

    while(var_0) {
      if(distancesquared(self.origin, self._id_00AD) < var_2)
        var_0 = 0;

      waitframe();
    }

    level._id_3DCF = 1;
  }
}

_id_8C51(var_0, var_1, var_2) {
  return vectordot(var_2 - var_0, var_1);
}

_id_2312(var_0, var_1) {
  var_2 = 15;

  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = 70;

  if(self getstance() == "crouch")
    var_3 = 50;
  else if(self getstance() == "prone")
    var_3 = 30;

  var_4 = var_3 * 0.5;
  return _id_2311(var_0, self.origin + (0, 0, var_4), var_2 - var_1, var_4);
}

_id_2311(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - var_1;

  if(_abs(var_4[2]) <= var_3 - var_2) {
    var_5 = (var_4[0], var_4[1], 0);

    if(_lengthsquared(var_5) > var_2 * var_2) {
      var_0 = var_1 + vectorNormalize(var_5) * var_2;
      var_0 = (var_0[0], var_0[1], var_1[2] + var_4[2]);
    }
  } else if(var_4[2] > 0) {
    var_6 = var_1 + (0, 0, var_3 - var_2);
    var_4 = var_0 - var_6;

    if(_lengthsquared(var_4) > var_2 * var_2)
      var_0 = var_6 + vectorNormalize(var_4) * var_2;
  } else {
    var_6 = var_1 - (0, 0, var_3 - var_2);
    var_4 = var_0 - var_6;

    if(_lengthsquared(var_4) > var_2 * var_2)
      var_0 = var_6 + vectorNormalize(var_4) * var_2;
  }

  return var_0;
}

_id_1E36(var_0, var_1, var_2, var_3) {
  var_4 = var_3 - var_1;
  var_5 = var_4[2];
  var_4 = (var_4[0], var_4[1], 0);
  var_6 = _lengthsquared(var_4);

  if(var_6 <= 0) {
    if(var_5 < 0.1)
      return (0, 0, 0);

    return undefined;
  }

  var_7 = _sqrt(var_6);

  if(var_0 > 0)
    var_0 = var_0 * -1.0;

  var_8 = _squared(_cos(var_2 * -1.0));
  var_9 = _tan(var_2 * -1.0);
  var_10 = _sqrt(var_0 * var_6 / (2 * var_8 * (var_5 - var_7 * var_9)));

  if(common_scripts\utility::_id_55BF(var_10))
    return undefined;

  var_11 = _rotatevector((1, 0, 0), (var_2, _vectortoyaw(var_4), 0));
  var_11 = var_11 * var_10;
  return var_11;
}

_id_9A7D(var_0) {
  _id_031E::_id_9A74(var_0);
}

_id_5670(var_0) {
  if(var_0 == "none")
    return 0;

  return weaponinventorytype(var_0) == "altmode";
}

_id_1801(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_2))
    var_2 = 1;

  if(!_issentient(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self._id_1801) && self._id_1801) {
    return;
  }
  self._id_1801 = 1;

  if(isDefined(var_0))
    wait(_randomfloat(var_0));

  var_3 = [];
  var_3[0] = "j_hip_le";
  var_3[1] = "j_hip_ri";
  var_3[2] = "j_head";
  var_3[3] = "j_spine4";
  var_3[4] = "j_elbow_le";
  var_3[5] = "j_elbow_ri";
  var_3[6] = "j_clavicle_le";
  var_3[7] = "j_clavicle_ri";
  var_4 = getdvarint("cg_fov");
  thread _id_1802(common_scripts\utility::random(var_3), undefined);

  if(isDefined(var_1) && _isai(var_1) && isalive(var_1)) {
    if(!level.player worldpointinreticle_circle(var_1.origin, var_4, 500))
      var_1 shootblank();
  } else if(var_2) {
    var_5 = "allies";

    if(isDefined(self.team)) {
      if(self.team == "allies" || self.team == "neutral")
        var_5 = "axis";
    }

    var_6 = _getaiarray(var_5);
    var_6 = _sortbydistance(var_6, level.player.origin, 2000);
    var_6 = common_scripts\utility::array_randomize(var_6);

    foreach(var_8 in var_6) {
      if(!level.player worldpointinreticle_circle(var_8.origin + (0, 0, 50), var_4, 500)) {
        if(isDefined(var_8._id_01D0) && _weapontype(var_8._id_01D0) == "bullet") {
          var_8 shootblank();
          break;
        }
      }
    }
  }

  self dodamage(self.health + 50, self.origin);
}

_id_1802(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level._effect["bloody_death_impact"];

  _playfxontag(var_1, self, var_0);
}

_id_A24C() {
  return getDvar("sm_sunShadowBitDepth") == 16;
}

_id_A24B() {
  return getDvar("sm_spotShadowBitDepth") == 16;
}

sethealth_notmaxhealth(var_0) {
  var_1 = self.maxhealth;
  self.health = var_0;
  self.maxhealth = var_1;
}