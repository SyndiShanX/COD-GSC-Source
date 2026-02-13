/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2740.gsc
*************************************************/

_id_93FD() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "activate", ::_id_93ED);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "startCapture", ::_id_940F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "endCapture", ::_id_93F9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "filterDropSpawns", ::_id_93FA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "getDropSpawnIgnoreList", ::_id_93FB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "spawnCallback", ::_id_940E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "initLate", ::_id_9400);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C2("light_tank", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C4("light_tank", 3);
  _id_0A97::_id_C28A(_id_09D6::_id_9430);
  _id_9401();
  _id_9402();
  _id_93FE();
  _id_0AC1::_id_1022A("light_tank", _id_09D6::_id_93C6);
}

_id_9400() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("bradley", _id_09D6::_id_9425);
}

_id_9401() {
  var_0 = _id_09E2::_id_10144("light_tank", 1);
  var_0._id_5FDC = 115;
  var_0._id_2093 = 110;
  var_0._id_919A = 60;
  var_0._id_C862 = 60;
  var_0._id_2954 = 20;
  var_0._id_4B96 = 35;
}

_id_9402() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("light_tank", 1);
  var_0._id_0E01 = _id_09D6::_id_9423;

  if(scripts\mp\utility\game::getgametype() == "arm") {
    var_0._id_0E02 = 105;
    var_0._id_C69E = level._id_EE45;
  } else
    var_0._id_0E02 = 40;
}

_id_93FE() {
  scripts\mp\playeractions::_id_C23B("vehicleCapture", ["offhand_weapons", "weapon", "killstreaks", "supers"]);
}

_id_93ED(var_0) {
  var_0 thread _id_2462();
  _id_0AC1::_id_10229(var_0);
}

_id_940F(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    _id_93F3(var_0, var_1);
  }

  if(level.teambased) {
    _id_93F2(var_0);
  }
}

_id_93F9(var_0) {
  var_0 _id_93F7();
}

_id_93F3(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_bradley_mp");
  var_3 = spawn("script_model", var_2 gettagorigin("TAG_PLAYER"));
  var_3 linkto(var_2);
  var_3 _id_940C(0.5);
  var_3.vehicle = var_0;
  var_0._id_AD9E = var_3;
  var_3 thread _id_9407(var_1, var_0);
  var_3 thread _id_9408(var_1);
  return var_3;
}

_id_93F2(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_bradley_mp");
  var_2 = spawn("script_model", var_1 gettagorigin("TAG_PLAYER"));
  var_2 linkto(var_1);
  var_2 _id_940C(3);
  var_2.vehicle = var_0;
  var_0._id_AC9B = var_2;
  var_2 thread _id_9405(var_0);
  var_2 thread _id_9406();
  return var_2;
}

_id_940C(var_0) {
  self setcursorhint("HINT_BUTTON");

  if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
    self sethintstring(&"KILLSTREAKS_HINTS/BRADLEY_CAPTURE");
  }

  self _meth_84D7("none");
  self _meth_84D4(200);
  self sethintdisplayfov(360);
  self setuserange(200);
  self setusefov(360);
  self _meth_84D9("show");
  self setuseholdduration("duration_none");
  self _meth_84D1(1);
  self makeuseable();
  self._id_FEB1 = 1;
  self._id_4143 = 0;
  self._id_FEE7 = var_0;
  self._id_84EF = 0;
  self._id_B80E = undefined;
  self._id_7C8C = "care_package";
}

_id_93F6() {
  if(isDefined(self._id_B80E)) {
    _id_940B(self._id_B80E);
  }

  self delete();
}

_id_93F7() {
  if(isDefined(self._id_AD9E)) {
    self._id_AD9E _id_93F6();
  }

  if(isDefined(self._id_AC9B)) {
    self._id_AC9B _id_93F6();
  }
}

_id_9407(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  self.vehicle = var_1;

  for(;;) {
    self waittillmatch("trigger", var_0);

    if(_id_93EF(var_0)) {
      self._id_B80E = var_0;
      self._id_84EF = 1;
      _id_940A(var_0);
      var_2 = _id_9403();
      self._id_B80E = undefined;
      self._id_4143 = 0;
      self._id_84EF = 0;
      _id_940B(var_0);

      if(istrue(var_2)) {
        thread _id_09D6::_id_93A1(var_1, var_0);
      }

      waitframe();
    }
  }
}

_id_9405(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(_id_93EF(var_1)) {
      self._id_B80E = var_1;
      self._id_84EF = 1;
      _id_940A(var_1);
      var_2 = _id_9403();
      self._id_B80E = undefined;
      self._id_4143 = 0;
      self._id_84EF = 0;

      if(isDefined(var_1)) {
        _id_940B(var_1);
      }

      if(istrue(var_2)) {
        thread _id_09D6::_id_93A1(var_0, var_1);
      }

      waitframe();
    }
  }
}

_id_9403() {
  self._id_B80E endon("death_or_disconnect");

  while(_id_93EE()) {
    self._id_4143 = self._id_4143 + level._id_5F3A * self._id_FEB1;

    if(self._id_4143 >= self._id_FEE7) {
      return 1;
    }

    self._id_B80E _id_07D6::_id_FD75(self, 1);
    waitframe();
  }
}

_id_9408(var_0) {
  self endon("death");

  while(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      self disableplayeruse(var_2);

      if(var_2 == var_0) {
        if(isDefined(self._id_B80E)) {
          if(_id_93EE()) {
            self _meth_80E0(var_0);
          }

          continue;
        }

        if(_id_93EF(var_0)) {
          self _meth_80E0(var_0);
        }
      }
    }

    wait 0.1;
  }

  thread _id_93F6();
}

_id_9406() {
  self endon("death");

  for(;;) {
    if(isDefined(self._id_B80E)) {
      foreach(var_1 in level.players) {
        self disableplayeruse(var_1);

        if(var_1 == self._id_B80E) {
          if(_id_93EE()) {
            self _meth_80E0(var_1);
          }
        }
      }
    } else {
      foreach(var_1 in level.players) {
        self disableplayeruse(var_1);

        if(_id_93EF(var_1)) {
          self _meth_80E0(var_1);
        }
      }
    }

    wait 0.1;
  }
}

_id_93EF(var_0) {
  if(istrue(self.vehicle._id_87FB)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(var_0.team == "spectator") {
    return 0;
  }

  if(!var_0 scripts\common\utility::_id_8710()) {
    return 0;
  }

  if(!istrue(_id_09E1::_id_10100(var_0, self.vehicle))) {
    return 0;
  }

  return 1;
}

_id_93EE() {
  if(istrue(self.vehicle._id_87FB)) {
    return 0;
  }

  if(!self._id_B80E scripts\common\utility::_id_8710()) {
    return 0;
  }

  if(!istrue(_id_09E1::_id_10100(self._id_B80E, self.vehicle))) {
    return 0;
  }

  if(!self._id_B80E usebuttonpressed()) {
    return 0;
  }

  if(self._id_B80E isonladder()) {
    return 0;
  }

  if(self._id_B80E meleebuttonpressed()) {
    return 0;
  }

  if(distancesquared(self._id_B80E.origin, self.origin) > 90000) {
    return 0;
  }

  return 1;
}

_id_940A(var_0) {
  var_0 scripts\mp\playeractions::_id_1596("vehicleCapture", 0);
  var_0 _id_07D6::_id_FD75(self, 0);
}

_id_940B(var_0) {
  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 scripts\mp\playeractions::_id_1596("vehicleCapture", 1);
  }

  var_0 _id_07D6::_id_FD75(self, 0);
}

_id_940D(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(level.teambased && var_1.team == var_0.team) {
    return 0;
  }

  if(isDefined(var_0.owner) && var_1 == var_0.owner) {
    return 0;
  }

  return 1;
}

_id_2462() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(scripts\mp\utility\teams::_id_8878(self.team)) {
      var_0 = scripts\common\utility::_id_B7BF(self.origin, 3000);

      foreach(var_2 in var_0) {
        var_3 = isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive() && scripts\mp\utility\player::isenemy(var_2);

        if(!var_3) {
          continue;
        }
        var_4 = anglesToForward(var_2 getplayerangles());
        var_5 = scripts\engine\math::_id_178B(var_4, self.origin - var_2.origin);

        if(isDefined(var_5) && var_5 <= 60) {
          if(self _meth_83CD(var_2 getEye(), self) > 0.1) {}

          waitframe();
        }
      }
    }

    wait 0.1;
  }
}

_id_940E(var_0, var_1) {
  _id_09D6::_id_93D9(var_0);

  if(!isDefined(var_0._id_E325)) {
    var_0._id_E325 = "place_at_position_unsafe";
  }

  if(!isDefined(var_0._id_DCB0)) {
    var_0._id_DCB0 = 0;
  }

  var_0._id_31F7 = 0;
  var_2 = _id_09D6::_id_941A(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::_id_10272()) {
    var_2._id_AAA9 = ::_id_9409;
  }

  return var_2;
}

_id_9409() {
  thread _id_9410();
}

_id_9410() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3D67(var_0, var_1);
  _id_09D6::_id_93A5(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_10290("light_tank", var_1, var_2);

  if(isDefined(var_3)) {
    if(scripts\mp\utility\game::getgametype() == "arm") {
      if(_id_07D1::_id_60BE("prematch_done")) {
        scripts\mp\gametypes\arm::_id_506C(var_1);
      }

      if(istrue(level._id_DCF1)) {
        scripts\mp\gametypes\arm::_id_1002A(var_3, var_3.team);
      }

      foreach(var_5 in level.players) {
        if(var_5.team == var_3.team) {
          var_5 _id_0A99::_id_D5EA(62, undefined, 5);
        }
      }
    }
  }
}

_id_93FA(var_0) {
  var_1 = var_0;

  if(isDefined(level._id_10398)) {
    var_1 = [];

    foreach(var_3 in var_0) {
      if(_func_011A(var_3.origin, level._id_10398)) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_93FB(var_0) {
  var_1 = [];
  var_1[var_1.size] = var_0;

  if(isDefined(level._id_77D9)) {
    var_1[var_1.size] = level._id_77D9;
  }

  if(isDefined(level._id_9593)) {
    var_1[var_1.size] = level._id_9593;
  }

  if(isDefined(level._id_EB9A)) {
    var_1[var_1.size] = level._id_EB9A;
  }

  var_1[var_1.size] = ::scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("emp_drone");
  var_1[var_1.size] = ::scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("cruise_predator");
  return scripts\engine\utility::_id_1B9B(var_1);
}