/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2006.gsc
*************************************************/

main(var_0) {
  var_0[var_0.size] = "airdrop_pallet";
  var_1 = getEntArray();

  foreach(var_3 in var_1) {
    if(scripts\cp_mp\vehicles\vehicle_spawn::_id_1027C()) {
      if(var_3 scripts\cp_mp\vehicles\vehicle_spawn::_id_1027E()) {
        continue;
      }
    }

    if(var_3 postshipfix_keepgameobject()) {
      continue;
    }
    var_4 = var_3._id_CD69;

    if(isDefined(var_4)) {
      var_5 = 0;

      if(_func_00D6(var_4, 0, 1) == "!") {
        var_4 = _func_00D6(var_4, 1);
        var_5 = 1;
      }

      var_6 = 0;
      var_7 = strtok(var_4, " ");

      for(var_8 = 0; var_8 < var_0.size; var_8++) {
        for(var_9 = 0; var_9 < var_7.size; var_9++) {
          if(var_7[var_9] == var_0[var_8]) {
            var_6 = 1;
            break;
          }
        }

        if(var_6) {
          break;
        }
      }

      if(var_5) {
        if(var_6) {
          var_3 delete();
        }
      } else if(!var_6)
        var_3 delete();
    }
  }
}

postshipfix_keepgameobject() {
  if(isDefined(level.script) && level.script == "mp_winter") {
    if(isDefined(level.gametype) && level.gametype == "koth") {
      if(isDefined(self._id_0481) && self._id_0481 == "control_zone" && (isDefined(self._id_CD99) && self._id_CD99 == "_b")) {
        return 1;
      }
    }
  }

  return 0;
}

init() {
  level._id_A786 = 0;
  _id_0AA3::_id_C28D(::onplayerspawned);
  level thread _id_6B06();
}

onplayerspawned() {
  if(isbot(self)) {
    level._id_294F = 1;
  }

  var_0 = !istrue(level._id_4ABE);

  if(scripts\mp\utility\game::getgametype() == "war") {
    var_0 = 0;
  }

  if(getdvarint("#x3e097e84e756091c2", 0) == 1) {
    var_0 = 1;
  }

  if(var_0) {
    if(isDefined(self._id_60D9)) {
      self._id_60D9 = undefined;
    } else {
      _id_805E();
    }
  }
}

_id_805E() {
  thread _id_AAA8();
  self._id_F398 = [];
  self._id_32EC = undefined;
  self._id_31AC = 1;
  self._id_81E0 = 1;
}

_id_AAA8() {
  level endon("game_ended");
  self waittill("death_or_disconnect");
  _id_0C79();
}

_id_0C79() {
  if(isDefined(self._id_32EC)) {
    self._id_32EC thread _id_D537();
  }
}

_id_AB0B() {
  waittillframeend;

  if(isDefined(self._id_32EC)) {
    self._id_32EC thread _id_D537();
    self switchtoweapon("s4_gw_flima35_mp");
  }
}

_id_4069(var_0, var_1) {
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("tag_origin");
  var_3 = spawnStruct();
  var_3.type = "carryObject";
  var_3._id_32D5 = var_0;
  var_3._id_4140 = var_0.origin;
  var_3._id_5513 = var_2 getentitynumber();
  var_3._id_ADAE = var_0.team;
  var_3._id_A97E = var_1;
  var_3._id_F637 = "none";
  var_3._id_3B0A = [];
  var_3._id_A90C = 0;
  var_3._id_A90B = 0;
  var_3._id_32DC = 0;
  var_3._id_1041A = "none";
  var_3 _id_C579(1, 1);
  var_3 thread _id_FC27();
  var_3 thread _id_479A();
  return var_3;
}

_id_479A() {
  self._id_32D5 waittill("disconnect");
  _id_4799();
}

_id_4799() {
  if(self.type != "carryObject") {
    return;
  }
  var_0 = self;
  var_0.type = undefined;
  var_0._id_32D5 = undefined;
  var_0._id_4140 = undefined;
  var_0._id_5513 = undefined;
  var_0._id_ADAE = undefined;
  var_0._id_3B0A = undefined;
  var_0._id_A90C = undefined;
  var_0._id_A90B = undefined;
  var_0._id_32DC = undefined;
  var_0._id_1041A = undefined;
  _id_C300();
  self notify("gameobject_deleted");
}

_id_3FA8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.type = "carryObject";
  var_6._id_4140 = var_1.origin;
  var_6._id_ADAE = var_0;
  var_6._id_FE84 = var_4;
  var_6._id_5513 = var_1 getentitynumber();

  if(issubstr(var_1.classname, "use")) {
    var_6._id_F637 = "use";
  } else {
    var_6._id_F637 = "proximity";
  }

  var_1._id_60D8 = var_6;
  var_1._id_2323 = var_1.origin;
  var_6.trigger = var_1;

  if(!isDefined(var_1._id_9514)) {
    var_1._id_9514 = 1;
    var_1 _meth_80DB();
  }

  var_6.useweapon = undefined;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_6._id_A97E = var_3;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_2[var_7]._id_2323 = var_2[var_7].origin;
    var_2[var_7]._id_22B0 = var_2[var_7].angles;
  }

  var_6._id_10430 = var_2;
  var_6._id_3B0A = [];
  var_6._id_A90C = 0;
  var_6._id_A90B = 0;

  if(!isDefined(var_5)) {
    var_6 _id_C579(1, 1);
  }

  var_6._id_32D5 = undefined;
  var_6._id_89FF = 0;
  var_6._id_83B6 = "none";
  var_6._id_15E2 = 0;
  var_6._id_32DC = 0;
  var_6._id_1041A = "none";
  var_6._id_32E7 = undefined;
  var_6._id_AAB9 = undefined;
  var_6._id_AB4D = undefined;
  var_6._id_AB88 = undefined;
  var_6._id_B0A8 = [];

  if(var_6._id_F637 == "use") {
    var_6 thread _id_32F2();
  } else {
    var_6._id_4143 = 0;
    var_6._id_EF94 = [];
    var_6._id_EF94["none"] = 0;
    var_6._id_FEE7 = 0;
    var_6._id_FEB1 = 0;
    var_6._id_FEB2 = 1.0;
    var_6._id_A362 = 0;
    var_6._id_316A = 0;
    var_6._id_EFB8 = [];
    var_6._id_EFB7 = [];
    var_6._id_A79A["neutral"] = 0;
    var_6._id_F396["neutral"] = [];
    var_6._id_A79A["none"] = 0;
    var_6._id_F396["none"] = [];

    foreach(var_9 in level._id_EF89) {
      var_6._id_EF94[var_9] = 0;
      var_6._id_A79A[var_9] = 0;
      var_6._id_F396[var_9] = [];
    }

    var_6._id_37F6 = "none";
    var_6._id_37F4 = undefined;
    var_6._id_8FAD = "none";
    var_6._id_8FAE = 0;
    var_6 thread _id_32EF();
  }

  var_6 thread _id_FC27();
  return var_6;
}

_id_C245(var_0) {
  self._id_B0A8[self._id_B0A8.size] = var_0;
}

_id_34E7(var_0) {
  var_1 = 1;

  foreach(var_3 in self._id_B0A8) {
    var_1 = var_1 &[[var_3]](var_0);
  }

  return var_1;
}

_id_475E() {
  if(self.type != "carryObject") {
    return;
  }
  var_0 = self;
  var_0.type = undefined;
  var_0._id_4140 = undefined;
  var_0._id_ADAE = undefined;
  var_0._id_5513 = undefined;
  var_0._id_F637 = undefined;
  var_0.trigger unlink();
  var_0.trigger = undefined;
  var_0.useweapon = undefined;
  var_0._id_A97E = undefined;

  foreach(var_2 in var_0._id_10430) {
    var_2 delete();
  }

  var_0._id_10430 = undefined;
  var_0._id_3B0A = undefined;
  var_0._id_A90C = undefined;
  var_0._id_A90B = undefined;
  var_0._id_A912 = undefined;
  _id_C300();
  var_0._id_32D5 = undefined;
  var_0._id_89FF = undefined;
  var_0._id_83B6 = undefined;
  var_0._id_15E2 = undefined;
  var_0._id_8CC8 = undefined;
  var_0._id_32DC = undefined;
  var_0._id_1041A = undefined;
  var_0._id_32E7 = undefined;
  var_0._id_AAB9 = undefined;
  var_0._id_AB4D = undefined;
  var_0._id_AB88 = undefined;
  var_0._id_4143 = undefined;
  var_0._id_FEE7 = undefined;
  var_0._id_FEB1 = undefined;
  var_0._id_FEB2 = 1.0;
  var_0._id_A362 = undefined;
  var_0._id_316A = undefined;
  var_0._id_EFB8 = undefined;
  var_0._id_EFB7 = undefined;
  var_0._id_A79A = undefined;
  var_0._id_F396 = undefined;
  var_0._id_37F6 = undefined;
  var_0._id_37F4 = undefined;
  var_0._id_8FAD = undefined;
  var_0._id_8FAE = undefined;
  var_0 notify("death");
  var_0 notify("deleted");
}

_id_32F2() {
  level endon("game_ended");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0 _meth_81CF()) {
      continue;
    }
    var_1 = var_0 getcurrentweapon();

    if(scripts\mp\utility\killstreak::_id_89FB(var_1.basename)) {
      continue;
    }
    if(var_0 scripts\cp_mp\utility\inventory_utility::_id_8755()) {
      var_2 = var_0 scripts\cp_mp\utility\inventory_utility::_id_69A6();

      if(scripts\mp\utility\killstreak::_id_89FB(var_2.basename)) {
        continue;
      }
    }

    if(istrue(var_0.inlaststand)) {
      continue;
    }
    if(self._id_89FF) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(!_id_318C(var_0.pers["team"], var_0)) {
      continue;
    }
    if(!var_0._id_31AC) {
      continue;
    }
    if(isDefined(var_0._id_A5B8) && var_0._id_A5B8 > gettime()) {
      continue;
    }
    if(!isDefined(var_0._id_81E0)) {
      continue;
    }
    if(var_0 scripts\mp\utility\weapon::_id_7169()) {
      var_3 = var_0 getheldoffhand();

      if(!scripts\mp\utility\weapon::_id_887A(var_3)) {
        continue;
      }
    }

    if(isDefined(self._id_32D5)) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    if(!_id_BDDB(var_0)) {
      continue;
    }
    _id_D650(var_0);
  }
}

_id_32EF() {
  if(scripts\mp\utility\game::getgametype() == "ball" || scripts\mp\utility\game::getgametype() == "tdef" || istrue(self._id_FE84)) {
    thread _id_32F2();
  } else {
    thread _id_32F0();
  }
}

_id_32F0() {
  level endon("game_ended");

  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  thread _id_BDDC();

  for(;;) {
    if(self._id_FEE7 && self._id_EF94[self._id_37F6] >= self._id_FEE7) {
      self._id_4143 = 0.0;
      self._id_EF94[self._id_37F6] = self._id_4143;
      var_0 = _id_69F9();
      _id_D4D1("none");
      self._id_37F4 = undefined;

      if(isDefined(self._id_AAC2)) {
        self[[self._id_AAC2]](_id_6AF6(), var_0, isDefined(var_0));
      }

      if(isDefined(var_0)) {
        _id_D650(var_0);
      }
    }

    if(self._id_37F6 != "none") {
      if(self._id_FEE7) {
        if(!self._id_A79A[self._id_37F6]) {
          _id_D4D1("none");
          self._id_37F4 = undefined;

          if(isDefined(self._id_AAC2)) {
            self[[self._id_AAC2]](_id_6AF6(), self._id_37F4, 0);
          }
        } else {
          self._id_4143 = self._id_4143 + level._id_01E2 * self._id_FEB1;
          self._id_EF94[self._id_37F6] = self._id_4143;
          var_1 = scripts\mp\utility\teams::_id_6A01(self._id_37F6);

          foreach(var_3 in var_1) {
            if(self._id_ADAE != var_3) {
              self._id_EF94[var_3] = 0;
            }
          }

          if(isDefined(self._id_ABD4)) {
            self[[self._id_ABD4]](_id_695F(), self._id_4143 / self._id_FEE7, level._id_01E2 * self._id_FEB1 / self._id_FEE7, self._id_37F4);
          }
        }
      } else {
        if(scripts\mp\utility\player::isreallyalive(self._id_37F4)) {
          _id_D650(self._id_37F4);
        }

        _id_D4D1("none");
        self._id_37F4 = undefined;
      }
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_B0B1(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self._id_31AC = 0;

  if(isDefined(var_0._id_2197)) {
    var_1 = 1024;
  } else {
    var_1 = 4096;
  }

  for(;;) {
    if(distancesquared(self.origin, var_0.trigger.origin) > var_1) {
      break;
    }

    wait 0.2;
  }

  self._id_31AC = 1;
}

_id_D650(var_0, var_1, var_2) {
  if(isai(var_0) && isDefined(var_0.owner)) {
    return;
  }
  if(isDefined(var_0._id_32EC) || isDefined(self.carryweapon) && !var_0 scripts\common\utility::_id_871C() || !_id_34E7(var_0)) {
    if(isDefined(self._id_AB4E)) {
      self[[self._id_AB4E]](var_0);
    }

    return;
  }

  var_0 _id_6FBF(self);
  _id_D4B5(var_0);

  if(isDefined(self.trigger _meth_8151())) {
    for(var_3 = 0; var_3 < self._id_10430.size; var_3++) {
      self._id_10430[var_3] unlink();
    }

    self.trigger unlink();
  }

  for(var_3 = 0; var_3 < self._id_10430.size; var_3++) {
    self._id_10430[var_3] hide();
  }

  self.trigger.origin = self.trigger.origin + (0, 0, 10000);
  self.trigger scripts\mp\movers::_id_E8A3();
  self notify("pickup_object");

  if(isDefined(self._id_AB4D)) {
    self[[self._id_AB4D]](var_0, var_1, var_2);
  }

  var_4 = spawnStruct();
  var_4.credit_player = var_0;
  var_4.objective_entity = self;
  _id_06E2::_id_4C2A("callback_objective_state_changed", var_4);
}

_id_FC43() {
  self endon("gameobject_deleted");
  level endon("game_ended");

  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  if(scripts\mp\utility\game::getgametype() == "front") {
    self._id_32D5 endon("disconnect");
  }

  for(;;) {
    if(isDefined(self._id_32D5)) {
      self._id_4140 = self._id_32D5.origin + (0, 0, 75);
      self._id_4139 = self._id_32D5.origin;
    } else {
      self._id_4140 = self.trigger.origin;
      self._id_4139 = undefined;
    }

    waitframe();
  }
}

_id_FC27() {
  self endon("gameobject_deleted");
  level endon("game_ended");

  if(isDefined(self.trigger)) {
    self.trigger endon("move_gameobject");
  }

  thread _id_FC43();

  if(!isDefined(self._id_A912)) {
    self._id_A912 = 4.0;
  }

  for(;;) {
    if(self._id_A912 == 0) {
      break;
    }

    if(isDefined(self._id_32D5)) {
      foreach(var_1 in level._id_EF89) {
        if((self._id_1041A == "friendly" || self._id_1041A == "any") && !_id_886F(var_1) && self._id_A90C) {
          if(self._id_DCFF) {
            if(isDefined(self._id_B0E1)) {
              _id_07F9::_id_FB97(self._id_B0E1, self._id_4140);

              if(istrue(self._id_B0E2)) {
                _func_0190(self._id_B0E1, 1);
              } else {
                objective_setpingsforteam(self._id_B0E1, var_1);
              }

              _func_018F(self._id_B0E1);
              continue;
            }

            if(istrue(self._id_B0E2)) {
              _func_0190(self._id_A908, 1);
            } else {
              objective_setpingsforteam(self._id_A908, var_1);
            }

            _func_018F(self._id_A908);
          }
        }
      }

      foreach(var_1 in level._id_EF89) {
        if((self._id_1041A == "enemy" || self._id_1041A == "any") && _id_886F(var_1) && self._id_A90B) {
          if(self._id_DCFF) {
            if(isDefined(self._id_B0E1)) {
              _id_07F9::_id_FB97(self._id_B0E1, self._id_4140);

              if(istrue(self._id_B0E2)) {
                _func_0190(self._id_B0E1, 1);
              } else {
                objective_setpingsforteam(self._id_B0E1, var_1);
              }

              _func_018F(self._id_B0E1);
              continue;
            }

            if(istrue(self._id_B0E2)) {
              _func_0190(self._id_A908, 1);
            } else {
              objective_setpingsforteam(self._id_A908, var_1);
            }

            _func_018F(self._id_A908);
          }
        }
      }

      scripts\engine\utility::_id_108AF(self._id_A912, "dropped", "reset");
      continue;
    }

    waitframe();
  }
}

_id_78F0() {
  self endon("death_or_disconnect");
  self endon("drop_object");
  level waittill("game_ended");

  if(isDefined(self._id_32E7)) {
    self._id_32E7.alpha = 0;
  }
}

_id_60DB() {
  var_0 = self getcurrentweapon();
  var_1 = self getcurrentprimaryweapon();
  var_2 = var_1 getaltweapon();

  if(var_2 == var_0) {
    return var_0;
  }

  return var_1;
}

_id_10AAE(var_0) {
  self endon("goal_scored");
  var_1 = gettime();
  var_2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);

  if(isDefined(var_2)) {
    if(var_2 == 0) {
      if(var_1 == gettime()) {
        waittillframeend;
      }

      if(isDefined(self._id_32EC)) {
        self._id_32EC thread _id_D537();
      }
    }
  }
}

_id_6FBF(var_0) {
  self._id_32EC = var_0;
  thread _id_F3F6();

  if(isDefined(var_0.carryweapon)) {
    var_0._id_32DD = _id_60DB();
    var_0._id_32DB = self hasweapon(var_0.carryweapon);

    if(isDefined(var_0._id_32F7)) {
      self thread[[var_0._id_32F7]]();
    }

    self giveweapon(var_0.carryweapon);
    thread _id_10AAE(var_0.carryweapon);
    self disableweaponpickup();
    scripts\common\utility::_id_1593(0);
  } else if(!var_0._id_15E2) {
    scripts\common\utility::_id_158D(0);
    thread _id_9A64();
  }

  if(isDefined(var_0._id_32E7)) {
    if(level.splitscreen) {
      self._id_32E7 = scripts\mp\hud_util::createicon(var_0._id_32E7, 33, 33);
      self._id_32E7 scripts\mp\hud_util::setpoint("BOTTOM LEFT", "BOTTOM LEFT", -50, -78);
    } else {
      self._id_32E7 = scripts\mp\hud_util::createicon(var_0._id_32E7, 50, 50);
      self._id_32E7 scripts\mp\hud_util::setpoint("BOTTOM LEFT", "BOTTOM LEFT", 175, -30);
    }

    self._id_32E7.hidewheninmenu = 1;
    thread _id_78F0();
  }
}

_id_C797() {
  self._id_89FF = 1;
  self notify("reset");

  for(var_0 = 0; var_0 < self._id_10430.size; var_0++) {
    var_1 = self._id_10430[var_0] _meth_8151();

    if(isDefined(var_1)) {
      self._id_10430[var_0] unlink();
    }

    if(_id_8785() && self._id_10430[var_0]._id_0481 == "sd_bomb") {
      self._id_10430[var_0].origin = level._id_2679;
      self._id_10430[var_0].angles = level._id_2678;
    } else {
      self._id_10430[var_0].origin = self._id_10430[var_0]._id_2323;
      self._id_10430[var_0].angles = self._id_10430[var_0]._id_22B0;
    }

    self._id_10430[var_0] show();
  }

  var_1 = self.trigger _meth_8151();

  if(isDefined(var_1)) {
    self.trigger unlink();
  }

  self.trigger.origin = self.trigger._id_2323;
  self._id_4140 = self.trigger.origin;

  if(isDefined(self._id_AB88)) {
    self[[self._id_AB88]]();
  }

  _id_392B();
  _id_FC3B();
  self._id_89FF = 0;
  self notify("reset_done");
}

_id_88A9() {
  if(isDefined(self._id_32D5)) {
    return 0;
  }

  if(self._id_4140 != self.trigger._id_2323) {
    return 0;
  }

  return 1;
}

_id_D684(var_0, var_1) {
  self._id_89FF = 1;

  for(var_2 = 0; var_2 < self._id_10430.size; var_2++) {
    self._id_10430[var_2].origin = var_0;
    self._id_10430[var_2].angles = var_1;
    self._id_10430[var_2] show();
  }

  self.trigger.origin = var_0;

  if(scripts\mp\utility\game::getgametype() == "ball" || scripts\mp\utility\game::getgametype() == "tdef") {
    self.trigger linkto(self._id_10430[0]);
  }

  self._id_4140 = self.trigger.origin;
  _id_392B();
  _id_FC3B();
  self._id_89FF = 0;
}

_id_32ED(var_0) {
  for(var_1 = 0; var_1 < var_0._id_32EC._id_10430.size; var_1++) {
    var_0._id_32EC._id_10430[var_1] unlink();
  }

  var_0._id_32EC.trigger unlink();
  var_0._id_32EC thread _id_D537(1);
}

_id_D537(var_0) {
  if(isDefined(self._id_D537)) {
    if(isDefined(self._id_FE80)) {
      scripts\mp\tac_ops\hostage_utility::_id_5032();
      return;
    }

    if([[self._id_D537]]()) {
      return;
    }
  }

  self._id_89FF = 1;
  self._id_C627 = undefined;
  self notify("dropped");

  foreach(var_2 in self._id_10430) {
    var_2 notsolid();
  }

  if(isDefined(self._id_32D5)) {
    var_4 = self._id_32D5.origin;
  } else {
    var_4 = self._id_4140;
  }

  if(istrue(level._id_294F) || _id_F391(var_4) || level.mapname == "mp_junk" && level.gametype == "ctf" && !self._id_32D5 _id_F38E()) {
    var_4 = _func_02AB(var_4);
  }

  if(isDefined(level._id_2637)) {
    var_4 = level._id_2637;
    level._id_2637 = undefined;
  }

  var_5 = 20;
  var_6 = 4000;
  var_7 = (0, 0, 0);
  var_8 = var_4 + (0, 0, var_5);
  var_9 = var_4 - (0, 0, var_6);
  var_10 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 0, 1, 1);
  var_11 = [];
  var_11[var_11.size] = self._id_10430[0];

  if(isDefined(self._id_32D5)) {
    var_11[var_11.size] = self._id_32D5;
  }

  if(isDefined(self._id_32D5) && self._id_32D5.team != "spectator") {
    var_12 = 8;
    var_13 = 16;

    if(scripts\mp\utility\game::getgametype() == "cyber") {
      var_12 = 4;
      var_13 = 8;
    } else if(scripts\mp\utility\game::getgametype() == "ctf") {
      var_12 = 2;
      var_13 = 4;
    }

    var_14 = scripts\engine\trace::_id_3219(var_8, var_9, var_12, var_13, (0, 0, 0), var_11, var_10, 0);

    if(isDefined(var_14["entity"]) && isDefined(var_14["entity"]._id_00EC) && var_14["entity"]._id_00EC == "script_vehicle") {
      var_11[var_11.size] = var_14["entity"];
      var_14 = scripts\engine\trace::_id_3219(var_8, var_9, var_12, var_13, (0, 0, 0), var_11, var_10, 0);
    }
  } else {
    var_14 = scripts\engine\trace::ray_trace(self._id_CAE7 + (0, 0, 20), self._id_CAE7 - (0, 0, 20), var_11, var_10, 0);

    if(isPlayer(var_14["entity"])) {
      var_14["entity"] = undefined;
    }

    if(isDefined(var_14["entity"]) && isDefined(var_14["entity"]._id_00EC) && var_14["entity"]._id_00EC == "script_vehicle") {
      var_11[var_11.size] = var_14["entity"];
      var_14 = scripts\engine\trace::ray_trace(self._id_CAE7 + (0, 0, 20), self._id_CAE7 - (0, 0, 20), var_11, var_10, 0);
    }
  }

  foreach(var_2 in self._id_10430) {
    var_2 solid();
  }

  var_17 = self._id_32D5;
  var_18 = 0;

  if(isDefined(var_14)) {
    var_19 = randomfloat(360);
    var_20 = var_14["position"];

    if(isDefined(self._id_1042D)) {
      var_20 = var_20 + self._id_1042D;
    }

    var_21 = (cos(var_19), sin(var_19), 0);
    var_21 = vectornormalize(var_21 - var_14["normal"] * vectordot(var_21, var_14["normal"]));
    var_22 = 0;

    if(scripts\mp\utility\game::getgametype() == "ctf" || _id_8785()) {
      var_23 = (0, 0, 0);

      if(scripts\mp\utility\game::getgametype() == "cyber") {
        var_23 = vectortoangles(var_21);
        var_23 = var_23 + (90, 0, 0);
      }
    } else
      var_23 = vectortoangles(var_21);

    for(var_24 = 0; var_24 < self._id_10430.size; var_24++) {
      if(_id_8785() && self._id_10430[var_24]._id_0481 == "sd_bomb" && !_func_02AE(var_20)) {
        var_20 = _func_02AB(var_20);
      }

      self._id_10430[var_24].origin = var_20;
      self._id_10430[var_24].angles = var_23;
      self._id_10430[var_24] show();
    }

    self.trigger.origin = var_20 + (0, 0, var_22);
    self._id_4140 = self.trigger.origin;
    var_25 = undefined;
    var_26 = var_14["entity"];

    if(isDefined(var_26) && !isPlayer(var_26) && !isweapon(var_26) && (!isDefined(var_26.objweapon) || !isweapon(var_26.objweapon)) && !isbot(var_26) && !isagent(var_26) && !scripts\mp\utility\entity::_id_8AB6(var_26) && (!isDefined(var_26.classname) || var_26.classname != "script_vehicle" && var_26.classname != "rocket")) {
      var_25 = var_14["entity"];
    }

    if(isDefined(var_25) && isDefined(var_25.owner)) {
      var_27 = var_25 _meth_8151();

      if(isDefined(var_27)) {
        var_25 = var_27;
      }
    }

    if(isDefined(var_25)) {
      if(isDefined(var_25._id_84F4) && var_25._id_84F4 == 1) {
        self._id_C627 = 1;
      } else {
        for(var_24 = 0; var_24 < self._id_10430.size; var_24++) {
          self._id_10430[var_24] linkto(var_25);
        }

        self.trigger linkto(var_25);
        var_28 = spawnStruct();
        var_28._id_32EC = self;
        var_28._id_43F7 = ::_id_32ED;
        self.trigger thread scripts\mp\movers::_id_7403(var_28);
      }
    }

    if(!isDefined(var_0)) {
      thread _id_B0B4();
    }
  } else {
    for(var_24 = 0; var_24 < self._id_10430.size; var_24++) {
      self._id_10430[var_24].origin = self._id_10430[var_24]._id_2323;
      self._id_10430[var_24].angles = self._id_10430[var_24]._id_22B0;
      self._id_10430[var_24] show();
    }

    self.trigger.origin = self.trigger._id_2323;
    self._id_4140 = self.trigger._id_2323;
  }

  if(isDefined(self._id_AAB9) && !isDefined(var_0)) {
    self[[self._id_AAB9]](var_17);
  }

  var_29 = spawnStruct();
  var_29.credit_player = var_17;
  var_29.objective_entity = self;
  _id_06E2::_id_4C2A("callback_objective_state_changed", var_29);
  _id_392B();
  _id_FC3B();
  self._id_89FF = 0;
}

_id_D4B5(var_0) {
  self._id_32D5 = var_0;
  thread _id_FD7F();
}

_id_392B() {
  if(!isDefined(self._id_32D5)) {
    return;
  }
  self._id_32D5 thread _id_EDCB(self);
  self._id_32D5 = undefined;
  self._id_4139 = undefined;
  self notify("carrier_cleared");
}

_id_B0B4() {
  self endon("pickup_object");
  self endon("reset_done");
  waitframe();

  if(isDefined(self._id_C627)) {
    self._id_C627 = undefined;
    _id_C797();
    return;
  }

  for(var_0 = 0; var_0 < level._id_BF45.size; var_0++) {
    if(!self._id_10430[0] istouching(level._id_BF45[var_0])) {
      continue;
    }
    _id_C797();
    return;
  }

  for(var_0 = 0; var_0 < level._id_9EF8.size; var_0++) {
    if(!self._id_10430[0] istouching(level._id_9EF8[var_0])) {
      continue;
    }
    _id_C797();
    return;
  }

  for(var_0 = 0; var_0 < level._id_7BE5.size; var_0++) {
    if(!self._id_10430[0] istouching(level._id_7BE5[var_0])) {
      continue;
    }
    _id_C797();
    return;
  }

  if(istrue(level._id_2192.size)) {
    self._id_15AE = 0;

    foreach(var_2 in level._id_2192) {
      if(self._id_10430[0] istouching(var_2)) {
        self._id_15AE = 1;
        break;
      }
    }
  }

  if(isDefined(level._id_AD0F)) {
    foreach(var_2 in level._id_AD0F) {
      if(istrue(self._id_15AE)) {
        break;
      }

      if(!self._id_10430[0] istouching(var_2)) {
        continue;
      }
      _id_C797();
      return;
    }
  }

  if(isDefined(level.gameobjectsoutofboundsz)) {
    if(self._id_10430[0].origin[2] < level.gameobjectsoutofboundsz) {
      _id_C797();
      return;
    }
  }

  if(isDefined(self._id_1F4F)) {
    wait(self._id_1F4F);

    if(!isDefined(self._id_32D5)) {
      _id_C797();
    }
  }
}

_id_EDCB(var_0) {
  if(isDefined(self._id_32E7)) {
    self._id_32E7 scripts\mp\hud_util::destroyelem();
  }

  if(isDefined(self)) {
    self._id_32EC = undefined;
  }

  self notify("drop_object");

  if(var_0._id_F637 == "proximity") {
    thread _id_B0B1(var_0);
  }

  if(scripts\mp\utility\player::isreallyalive(self) && !var_0._id_15E2) {
    if(isDefined(var_0.carryweapon)) {
      var_1 = isDefined(var_0._id_8CC4) && var_0._id_8CC4;

      if(!var_0._id_32DB && !var_1) {
        if(isDefined(var_0._id_2197)) {
          wait 0.25;
        }

        self notify("clear_carrier");

        if(scripts\cp_mp\utility\inventory_utility::_id_8A86(var_0.carryweapon)) {
          scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_0.carryweapon);
        } else {
          scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0.carryweapon);
        }

        thread scripts\cp_mp\utility\inventory_utility::_id_5ED6(self._id_8FC2);
      } else {}

      self enableweaponpickup();
      scripts\common\utility::_id_1593(1);
    } else if(!var_0._id_15E2)
      scripts\common\utility::_id_158D(1);
  }
}

_id_F3F6() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  while(isDefined(self._id_32EC) && scripts\mp\utility\player::isreallyalive(self)) {
    if(self isonground()) {
      var_0 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(var_0["fraction"] < 1) {
        self._id_32EC._id_CAE7 = var_0["position"];
      }
    }

    wait 0.05;
  }
}

_id_9A64() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    while(self attackButtonPressed() || self fragButtonPressed() || self secondaryoffhandbuttonPressed() || self meleeButtonPressed()) {
      wait 0.05;
    }

    while(!self attackButtonPressed() && !self fragButtonPressed() && !self secondaryoffhandbuttonPressed() || self meleeButtonPressed()) {
      wait 0.05;
    }

    if(isDefined(self._id_32EC) && !self useButtonPressed()) {
      self._id_32EC thread _id_D537();
    }
  }
}

_id_479D() {
  _id_C300();
  self.trigger delete();
  self.trigger = undefined;
  self notify("deleted");
}

_id_406E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.type = "useObject";
  var_7._id_4140 = var_1.origin;
  var_7._id_ADAE = var_0;
  var_7._id_5513 = var_1 getentitynumber();
  var_7._id_8CD8 = undefined;

  if(issubstr(var_1.classname, "use")) {
    var_7._id_F637 = "use";
  } else {
    var_7._id_F637 = "proximity";
  }

  var_1._id_60D8 = var_7;
  var_7.trigger = var_1;

  for(var_8 = 0; var_8 < var_2.size; var_8++) {
    var_2[var_8]._id_2323 = var_2[var_8].origin;
    var_2[var_8]._id_22B0 = var_2[var_8].angles;
  }

  var_7._id_10430 = var_2;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_7._id_A97E = var_3;
  var_7._id_3B0A = [];

  if(!istrue(var_5)) {
    var_7 _id_C579(1, 1, var_4, var_6);
  } else {
    var_7._id_A908 = -1;
  }

  var_7._id_83B6 = "none";
  var_7._id_1041A = "none";
  var_7._id_ABCB = undefined;
  var_7._id_AA80 = undefined;
  var_7._id_FEE2 = "default";
  var_7._id_FEE7 = 10000;
  var_7._id_4143 = 0;
  var_7._id_9987 = 0;
  var_7._id_10A19 = 0;
  var_7._id_E57B = 0;
  var_7._id_10A20 = 0;
  var_7._id_56E2 = 1;
  var_7._id_EF94 = [];
  var_7._id_EF94["none"] = 0;

  foreach(var_10 in level._id_EF89) {
    var_7._id_EF94[var_10] = 0;
  }

  if(var_7._id_F637 == "proximity") {
    var_7._id_EFB8 = [];
    var_7._id_EFB7 = [];
    var_7._id_A79A["neutral"] = 0;
    var_7._id_F396["neutral"] = [];
    var_7._id_A79A["none"] = 0;
    var_7._id_F396["none"] = [];

    foreach(var_13 in level._id_EF89) {
      var_7._id_A79A[var_13] = 0;
      var_7._id_F396[var_13] = [];
      var_7._id_1D2E[var_13] = [];
    }

    var_7._id_FEB1 = 0;
    var_7._id_FEB2 = 1.0;
    var_7._id_37F6 = "none";
    var_7._id_37F4 = undefined;
    var_7._id_8FAD = "none";
    var_7._id_8FAE = 0;
    var_7._id_A362 = 0;
    var_7._id_316A = 0;
    var_7 thread _id_FE95();
  } else {
    var_7._id_FEB1 = 1;
    var_7._id_FEB2 = 1.0;
    var_7 thread _id_FE97();
  }

  return var_7;
}

_id_3FF1(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "useObject";
  var_4._id_4140 = var_1.origin;
  var_4._id_ADAE = var_0;
  var_4._id_5513 = var_1 getentitynumber();
  var_4._id_8CD8 = undefined;
  var_4._id_F637 = "use";
  var_1._id_60D8 = var_4;
  var_4.trigger = var_1;

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5]._id_2323 = var_2[var_5].origin;
    var_2[var_5]._id_22B0 = var_2[var_5].angles;
  }

  var_4._id_10430 = var_2;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_4._id_A97E = var_3;
  var_4._id_3B0A = [];
  var_4._id_83B6 = "none";
  var_4._id_1041A = "none";
  var_4._id_ABCB = undefined;
  var_4._id_AA80 = undefined;
  var_4._id_FEE2 = "default";
  var_4._id_FEE7 = 10000;
  var_4._id_4143 = 0;
  var_4._id_E57B = 0;
  var_4._id_10A20 = 0;
  var_4._id_56E2 = 1;
  var_4._id_EF94 = [];
  var_4._id_EF94["none"] = 0;

  foreach(var_7 in level._id_EF89) {
    var_4._id_EF94[var_7] = 0;
  }

  var_4._id_FEB1 = 1;
  var_4._id_FEB2 = 1.0;
  var_4 thread _id_FE97();
  return var_4;
}

_id_3FC3(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "useObject";
  var_4._id_4140 = var_1;
  var_4._id_ADAE = var_0;
  var_4._id_8CD8 = undefined;
  var_4._id_F637 = "use";

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_2[var_5]._id_2323 = var_2[var_5].origin;
    var_2[var_5]._id_22B0 = var_2[var_5].angles;
  }

  var_4._id_10430 = var_2;

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_4._id_A97E = var_3;
  var_4._id_3B0A = [];
  var_4._id_83B6 = "none";
  var_4._id_1041A = "none";
  var_4._id_ABCB = undefined;
  var_4._id_AA80 = undefined;
  var_4._id_FEE2 = "default";
  var_4._id_FEE7 = 10000;
  var_4._id_4143 = 0;
  var_4._id_E57B = 0;
  var_4._id_10A20 = 0;
  var_4._id_56E2 = 1;
  var_4._id_EF94 = [];
  var_4._id_EF94["none"] = 0;

  foreach(var_7 in level._id_EF89) {
    var_4._id_EF94[var_7] = 0;
  }

  var_4._id_FEB1 = 1;
  var_4._id_FEB2 = 1.0;
  var_2[0] makeuseable();
  var_2[0] thread _id_FE5E();
  return var_4;
}

_id_D5C5(var_0) {
  self._id_8CD8 = var_0;
}

_id_FE5E() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(!_id_318C(var_0.pers["team"], var_0)) {
      continue;
    }
    if(!var_0 isonground()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    if(scripts\mp\utility\weapon::_id_88F6(var_0 getcurrentweapon())) {
      continue;
    }
    if(isDefined(self._id_FE35)) {
      if(!self[[self._id_FE35]](var_0)) {
        continue;
      }
    }

    if(isDefined(self._id_8CD8) && (!isDefined(var_0._id_32EC) || var_0._id_32EC != self._id_8CD8)) {
      if(isDefined(self._id_AA80)) {
        self[[self._id_AA80]](var_0);
      }

      continue;
    }

    if(isDefined(self.useweapon) && var_0 hasweapon(self.useweapon)) {
      continue;
    }
    if(!var_0 scripts\common\utility::_id_871C()) {
      continue;
    }
    if(!self._id_56E2 && !isDefined(self._id_56E1)) {
      thread _id_FE7C(var_0);
      continue;
    }

    _id_FE7C(var_0);
  }
}

_id_FE97() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(!_id_318C(var_0.pers["team"], var_0)) {
      continue;
    }
    if(!var_0 isonground()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    var_1 = var_0 getcurrentweapon();

    if(scripts\mp\utility\weapon::_id_88F6(var_1) && !istrue(var_0._id_88DF) && var_1.basename != "s4_la_walpha2_mp" && var_1.basename != "s4_mg_streak_mp") {
      continue;
    }
    if(isDefined(self._id_FE35)) {
      if(!self[[self._id_FE35]](var_0)) {
        continue;
      }
    }

    if(isDefined(self._id_8CD8) && (!isDefined(var_0._id_32EC) || var_0._id_32EC != self._id_8CD8)) {
      if(isDefined(self._id_AA80)) {
        self[[self._id_AA80]](var_0);
      }

      continue;
    }

    if(isDefined(self.useweapon) && var_0 hasweapon(self.useweapon)) {
      continue;
    }
    if(!var_0 scripts\common\utility::_id_871C()) {
      continue;
    }
    if(!self._id_56E2 && !isDefined(self._id_56E1)) {
      thread _id_FE7C(var_0);
      continue;
    }

    _id_FE7C(var_0);
  }
}

_id_FE7C(var_0) {
  var_1 = 1;
  var_2 = 0;

  if(self._id_FEE7 > 0) {
    if(isDefined(self._id_AA79)) {
      var_0 _id_FD75(self, 0);
      self[[self._id_AA79]](var_0);
    }

    if(!isDefined(self._id_8CD8)) {
      thread _id_31FF();
    }

    var_3 = var_0.pers["team"];
    var_1 = _id_FE7D(var_0);
    self notify("finished_use");

    if(isDefined(self._id_AAC2)) {
      self[[self._id_AAC2]](var_3, var_0, var_1);
    }
  }

  if(var_1) {
    if(isDefined(self._id_ABCB)) {
      self[[self._id_ABCB]](var_0);
    }

    var_2 = 1;
  }

  if(var_2) {
    var_4 = spawnStruct();
    var_4.credit_player = var_0;
    var_4.objective_entity = self;
    _id_06E2::_id_4C2A("callback_objective_state_changed", var_4);
  }
}

_id_352F(var_0) {
  var_1 = self._id_8CD8;

  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    if(var_3 istouching(self.trigger)) {
      return 1;
    }
  }

  return 0;
}

_id_3538(var_0) {
  var_1 = self._id_8CD8;

  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_1) {
    if(var_3 == var_0._id_32EC) {
      return 1;
    }
  }

  return 0;
}

_id_31FF() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");

  if(!isDefined(self.trigger)) {
    return;
  }
  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(!_id_318C(var_0.pers["team"], var_0)) {
      continue;
    }
    if(isDefined(self._id_AA80)) {
      self[[self._id_AA80]](var_0);
    }
  }
}

_id_69F9() {
  var_0 = undefined;

  if(!self._id_FEE7 && !self._id_E57B && self._id_37F6 == "none") {
    var_0 = self._id_ADAE;
  } else if(self._id_37F6 == "none" && (scripts\mp\utility\game::getgametype() == "control" || scripts\mp\utility\game::getgametype() == "dom" || scripts\mp\utility\game::getgametype() == "base")) {
    var_0 = self._id_ADAE;
  } else {
    var_0 = self._id_37F6;
  }

  var_1 = self._id_37F4;

  if(self._id_F396[var_0].size > 0) {
    var_2 = undefined;
    var_3 = getarraykeys(self._id_F396[var_0]);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = self._id_F396[var_0][var_3[var_4]];

      if(scripts\mp\utility\player::isreallyalive(var_5.player) && (!isDefined(var_2) || var_5._id_E72D < var_2)) {
        var_1 = var_5.player;
        var_2 = var_5._id_E72D;
      }
    }
  }

  return var_1;
}

_id_8A99() {
  var_0 = "none";

  foreach(var_2 in level._id_EF89) {
    if(self._id_A79A[var_2]) {
      var_0 = var_2;
      break;
    }
  }

  return var_0 != "none";
}

_id_FE95() {
  level endon("game_ended");
  self endon("deleted");
  thread _id_BDDC();

  if(!isDefined(self._id_7D35)) {
    self._id_7D35 = 0;
  }

  for(;;) {
    if(self._id_83B6 == "none") {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      continue;
    }

    var_0 = 0;
    var_1 = undefined;
    self._id_10A23 = 0;

    if(self._id_316A) {
      if(self._id_E57B != self._id_10A20) {
        if(self._id_E57B) {
          if(isDefined(self._id_AA8D)) {
            self[[self._id_AA8D]]();
          }

          var_0 = 1;
        } else {
          var_2 = "none";

          foreach(var_4 in level._id_EF89) {
            if(self._id_A79A[var_4]) {
              var_2 = var_4;
              break;
            }
          }

          if(var_2 == "none" && self._id_ADAE != "neutral") {
            var_2 = self._id_ADAE;
          }

          var_1 = _id_69F9();
          _id_D4D1("none");
          self._id_37F4 = undefined;

          foreach(var_2 in level._id_EF89) {
            if(self._id_F396[var_2].size) {
              var_7 = self._id_F396[var_2];
              var_8 = getarraykeys(var_7);

              for(var_9 = 0; var_9 < var_8.size; var_9++) {
                var_10 = var_7[var_8[var_9]].player;
                var_10 setclientomnvar("ui_objective_state", 0);
              }

              break;
            }
          }

          if(isDefined(self._id_ABC7)) {
            self[[self._id_ABC7]](var_2);
          }

          var_0 = 1;
          self._id_10A23 = 1;
        }

        self._id_10A20 = self._id_E57B;
      }

      if(!self._id_E57B && self._id_9987 != self._id_10A19) {
        self._id_10A19 = self._id_9987;
      }
    }

    if(!self._id_E57B && !self._id_9987 && !self._id_10A23) {
      if(self._id_A362 && !istrue(self._id_8ABF)) {
        if(self._id_ADAE != "neutral" && !self._id_A79A[self._id_ADAE]) {
          if(isDefined(self._id_ABC8)) {
            self[[self._id_ABC8]]();
          }

          var_0 = 1;
          self._id_8ABF = 1;
          _id_D4D1("none");
          self._id_37F4 = undefined;
        } else if(self._id_ADAE == "neutral") {
          if(!_id_8A99()) {
            if(isDefined(self._id_ABC8)) {
              self[[self._id_ABC8]]();
            }

            var_0 = 1;
            self._id_8ABF = 1;
            _id_D4D1("none");
            self._id_37F4 = undefined;
          } else if(isDefined(self._id_A79C))
            self[[self._id_A79C]](self._id_37F4.team);
        }
      } else if(!istrue(self._id_8ABF) && isDefined(self._id_ABC8)) {
        var_2 = "none";

        foreach(var_4 in level._id_EF89) {
          if(self._id_A79A[var_4]) {
            var_2 = var_4;
            break;
          }
        }

        if(var_2 == "none") {
          self._id_8ABF = 1;
          self[[self._id_ABC8]]();
        }
      }
    }

    var_14 = 1;

    if(isDefined(self._id_A79B) && self._id_A79B > self._id_A79A[self._id_37F6]) {
      var_14 = 0;
    }

    if(self._id_37F6 != "none" && var_14) {
      if(!self._id_FEE7) {
        if(!self._id_E57B) {
          var_1 = _id_69F9();
          _id_D4D1("none");
          self._id_37F4 = undefined;

          if(isDefined(self._id_ABCB)) {
            self[[self._id_ABCB]](var_1);
          }

          var_0 = 1;
        }
      } else if(self._id_FEE7 && self._id_EF94[self._id_37F6] >= self._id_FEE7) {
        self._id_4143 = 0.0;
        self._id_EF94[self._id_37F6] = self._id_4143;
        var_1 = _id_69F9();
        _id_D4D1("none");
        self._id_37F4 = undefined;

        if(isDefined(self._id_AAC2)) {
          self[[self._id_AAC2]](self._id_37F6, var_1, isDefined(var_1));
        }

        if(isDefined(var_1) && isDefined(self._id_ABCB)) {
          self[[self._id_ABCB]](var_1);
        }

        var_0 = 1;
      } else if(!self._id_E57B && self._id_FEE7 && (self._id_ADAE != self._id_37F6 || istrue(self._id_9987))) {
        if(!self._id_A79A[self._id_37F6]) {
          _id_D4D1("none");
          self._id_37F4 = undefined;

          if(isDefined(self._id_AAC2)) {
            self[[self._id_AAC2]](self._id_37F6, self._id_37F4, 0);
          }

          var_0 = 1;
        } else if(_id_31E7(self._id_37F6) && self._id_ADAE == "neutral") {
          if(self._id_8FAD == self._id_37F6 && istrue(self._id_9987)) {
            if(isDefined(self._id_902E) && self._id_902E != self._id_37F6 && self._id_EF94[self._id_37F6] == 0) {
              _id_E86D(self._id_37F6);
            } else {
              self._id_902E = self._id_37F6;
              _id_19CA();
            }
          }
        } else if(_id_31E6(self._id_37F6) && self._id_ADAE == "neutral" && self._id_8FAD != self._id_37F6) {
          if(self._id_8FAD != self._id_37F6) {
            if(isDefined(self._id_902E) && self._id_902E != self._id_37F6 && self._id_EF94[self._id_37F6] == 0) {
              _id_E86D(self._id_37F6);
            } else if(isDefined(self._id_902E) && self._id_902E != self._id_37F6 && self._id_EF94[self._id_902E] > 0) {
              _id_E86D(self._id_37F6);
            } else {
              self._id_902E = self._id_37F6;
              _id_19CA();
            }
          }
        } else if(_id_31E6(self._id_37F6) && self._id_ADAE == self._id_37F6) {
          if(isDefined(self._id_902E) && self._id_902E == self._id_37F6 && self._id_EF94[self._id_37F6] == 0) {
            _id_E86D(self._id_37F6);
          } else if(isDefined(self._id_902E) && self._id_902E != self._id_37F6 && self._id_EF94[self._id_902E] > 0 && self._id_EF94[self._id_37F6] == 0) {
            _id_E86D(self._id_37F6);
          }
        } else if(self._id_ADAE != self._id_37F6) {
          self._id_D49D = 0;
          self._id_D509 = 0;
          _id_19CA();
        } else if(self._id_ADAE == self._id_37F6 && istrue(self._id_9987)) {
          var_15 = _id_6BB9(self._id_37F6);

          if(var_15 && !istrue(self._id_D49D)) {
            self._id_D49D = 1;
            self._id_D509 = 0;
            _id_07F9::_id_FB9A(self._id_A908, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
            _id_07F9::_id_FB99(self._id_A908, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
          } else if(!var_15 && !istrue(self._id_D509)) {
            self._id_D49D = 0;
            self._id_D509 = 1;
            _id_D61B(level._id_7C50, level._id_7C42);
          }
        }
      }
    } else if(_id_31E6(self._id_ADAE) && self._id_ADAE != "neutral")
      _id_E86D(self._id_ADAE);

    if(var_0) {
      var_16 = spawnStruct();
      var_16.credit_player = var_1;
      var_16.objective_entity = self;
      _id_06E2::_id_4C2A("callback_objective_state_changed", var_16);
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_31E6(var_0) {
  return !istrue(self._id_7D35) && self._id_F396[var_0].size > 0 && !istrue(self._id_E57B) && self._id_4143 > 0;
}

_id_31E7(var_0) {
  return !istrue(self._id_7D35) && self._id_F396[var_0].size > 0 && self._id_9987 && self._id_4143 > 0;
}

_id_19CA() {
  _id_19C9(self._id_37F6, level._id_01E2 * self._id_FEB1);

  if(isDefined(self._id_ABD4)) {
    self[[self._id_ABD4]](self._id_37F6, self._id_EF94[self._id_37F6] / self._id_FEE7, level._id_01E2 * self._id_FEB1 / self._id_FEE7, self._id_37F4);
  }
}

_id_E86D(var_0) {
  if(isDefined(self._id_E86C)) {
    self[[self._id_E86C]](var_0);
  }

  var_1 = level._id_01E2 * self._id_FEB1;
  var_2 = scripts\mp\utility\teams::_id_6A01(var_0);

  foreach(var_4 in var_2) {
    var_5 = self._id_EF94[var_4];

    if(var_5 > 0) {
      if(var_5 < var_1) {
        self._id_EF94[var_4] = 0;
        self._id_4143 = self._id_EF94[var_4];
        _id_07F9::_id_A8C4(self._id_A908, 0);
        _id_07F9::_id_A8B4(self._id_A908, 0);
        var_1 = var_1 - var_5;
        continue;
      }

      self._id_8ABF = 0;
      self._id_EF94[var_4] = self._id_EF94[var_4] - var_1;
      var_6 = 0;

      if(isDefined(self._id_D030)) {
        var_7 = self._id_FEE7 * (self._id_D030 / level._id_3230);

        if(self._id_EF94[var_4] < var_7) {
          self._id_EF94[var_4] = var_7;
          var_6 = 1;
        }
      }

      var_1 = 0;
      self._id_4143 = self._id_EF94[var_4];
      _id_07F9::_id_A8C4(self._id_A908, 1);
      _id_07F9::_id_A8B6(self._id_A908, var_4);
      _id_07F9::_id_A8B4(self._id_A908, self._id_4143 / self._id_FEE7);

      if(!var_6) {
        _id_07F9::_id_FB9A(self._id_A908, "MP_INGAME_ONLY/OBJ_CLEARING_CAPS");
        var_8 = _id_6E57(self._id_3B0A["friendly"]);
        var_8 = scripts\engine\utility::ter_op(isDefined(var_8), var_8, "neutral");
        var_9 = _id_6E57(self._id_3B0A["enemy"]);
        var_9 = scripts\engine\utility::ter_op(isDefined(var_9), var_9, "neutral");
        var_10 = _id_6BC0(var_8, var_9);
        var_11 = getcodcasterwaypointshader(self._id_3B0A["friendly"]);
        var_12 = getcodcasterwaypointstring(self._id_3B0A["enemy"]);
        update_codcaster_objective(self._id_A908, var_10, var_11, "MP_INGAME_ONLY/OBJ_SECURING_CAPS", var_12);

        if(scripts\mp\utility\game::getgametype() == "control") {
          _id_07F9::_id_FB99(self._id_A908, "MP_INGAME_ONLY/OBJ_LOSING_CAPS");
          update_codcaster_objective(self._id_A908, var_10, var_11, "MP_INGAME_ONLY/OBJ_SECURING_CAPS", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS");
        }
      } else {
        var_13 = _id_6E5B(self._id_3B0A["friendly"]);
        var_14 = _id_6E5B(self._id_3B0A["enemy"]);
        _id_07F9::_id_FB9A(self._id_A908, var_13);
        _id_07F9::_id_FB99(self._id_A908, var_14);
      }
    }
  }

  if(self._id_4143 <= 0) {
    foreach(var_17 in self._id_F396[self._id_ADAE]) {
      if(isDefined(self._id_E86E)) {
        [[self._id_E86E]](var_17.player);
      }
    }

    self._id_902E = undefined;
  }
}

_id_FE93(var_0) {
  if(_id_694A() != "normal" && scripts\mp\utility\game::getgametype() != "arm") {
    return;
  }
  level endon("game_ended");
  self endon("deleted");
  self notify("useObjectDecay");
  self endon("useObjectDecay");
  var_1 = 0;

  for(;;) {
    waitframe();
    var_2 = self._id_A908;

    if(self._id_E57B) {
      var_1 = 0;
    }

    if(self._id_37F6 == "none") {
      if(self._id_FEE7) {
        if(!self._id_E57B) {
          if(istrue(self._id_450C) && var_1 < self._id_450C) {
            var_1 = var_1 + level._id_5F3A;
            continue;
          }

          if(isDefined(self._id_B009)) {
            if(!isDefined(self._id_4510)) {
              self._id_4510 = 0.0;
            }

            var_3 = self._id_4143 / self._id_FEE7;

            foreach(var_5 in self._id_B009) {
              if(var_3 >= var_5 && var_5 > self._id_4510) {
                self._id_4510 = var_5;
              }
            }

            if(!isDefined(self._id_450E)) {
              self._id_450E = self._id_FEE7 * 0.025 * level._id_5F3A;
            }

            if(var_3 > self._id_4510) {
              self._id_4143 = self._id_4143 - self._id_450E;
            }
          } else
            self._id_4143 = self._id_4143 - 0.1 * level._id_01E2;
        }

        self._id_EF94[var_0] = self._id_4143;
      }

      if(self._id_EF94[var_0] <= 0) {
        self._id_4143 = 0;
        self._id_EF94[var_0] = self._id_4143;
        _id_07F9::_id_A8C4(var_2, 0);
        break;
      }

      scripts\mp\hostmigration::waittillhostmigrationdone();

      if(isDefined(self._id_A908)) {
        if(isDefined(self._id_AD59)) {
          var_3 = self._id_EF94[self._id_AD59] / self._id_FEE7;
          _id_07F9::_id_A8B4(self._id_A908, var_3);
        } else {
          var_3 = self._id_EF94[self._id_8FAD] / self._id_FEE7;
          _id_07F9::_id_A8B4(self._id_A908, var_3);
        }
      }
    }
  }
}

_id_3167(var_0) {
  if(isDefined(self._id_32D5)) {
    return 0;
  }

  if(self._id_316A) {
    var_1 = _id_6BBA(var_0.pers["team"]);
    var_2 = _id_6BB9(var_0.pers["team"]);

    if(var_1 && !var_2) {
      self._id_9987 = 1;
      self._id_10A19 = 0;
      return 1;
    }

    if(var_1 && var_2 && var_1 != var_2) {
      if(istrue(level.disablemajoritycapprogress)) {
        self._id_E57B = 1;
        self._id_9987 = 0;
        self._id_10A19 = 1;
        return 0;
      }

      self._id_9987 = 1;
      self._id_10A19 = 0;
      return 1;
    }

    if(var_1 && var_2 && var_1 == var_2) {
      self._id_E57B = 1;
      self._id_9987 = 0;
      self._id_10A19 = 1;
      return 0;
    }
  }

  if(!isDefined(self._id_8CD8)) {
    return 1;
  }

  if(isDefined(self._id_A544)) {
    if(_id_352F(var_0)) {
      return 1;
    }
  }

  if(isDefined(var_0._id_32EC)) {
    if(_id_3538(var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_BDDC() {
  level endon("game_ended");
  self endon("deleted");
  var_0 = self._id_5513;

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(istrue(self.trigger._id_F5E0)) {
      continue;
    }
    if(isagent(var_1)) {
      continue;
    }
    if(!scripts\mp\utility\entity::_id_8877(var_1)) {
      continue;
    }
    if(isDefined(self._id_32D5)) {
      continue;
    }
    if(istrue(var_1.inlaststand)) {
      continue;
    }
    if(level.gametype == "base" && istrue(var_1.innocapturearea)) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }
    if(!isDefined(var_1._id_81E0)) {
      continue;
    }
    if(isDefined(self._id_FE35)) {
      if(!self[[self._id_FE35]](var_1)) {
        continue;
      }
    }

    var_2 = _id_6CEA(var_1.pers["team"]);

    if(isDefined(self._id_EFB8[var_2]) && self._id_EFB8[var_2] < 0) {
      continue;
    }
    if(scripts\mp\utility\player::isreallyalive(var_1) && !isDefined(var_1._id_F398[var_0])) {
      var_3 = var_1.pers["team"];
      self._id_A79A[var_3]++;
      var_4 = var_1.guid;
      var_5 = spawnStruct();
      var_5.player = var_1;
      var_5._id_E72D = gettime();
      self._id_F396[var_3][var_4] = var_5;

      if(isDefined(self._id_1D2E)) {
        if(!isDefined(self._id_1D2E[var_3][var_4])) {
          self._id_1D2E[var_3][var_4] = var_5;
        }
      }
    }

    if(self._id_316A) {
      var_6 = _id_6BBA(var_1.pers["team"]);
      var_7 = _id_6BB9(var_1.pers["team"]);

      if(var_6 && !var_7 || var_6 && var_7 && var_6 != var_7) {
        self._id_9987 = 1;
        self._id_8ABF = 0;
      }
    }

    if(self._id_37F6 == "none" || !istrue(self._id_159B) || istrue(self._id_9987)) {
      if(_id_318C(var_1.pers["team"], var_1)) {
        if(_id_3167(var_1)) {
          if(!_id_BDDB(var_1)) {
            continue;
          }
          if(istrue(self._id_9987)) {
            if(isDefined(self._id_A1AE) && isDefined(self._id_A1AF)) {
              _id_D4D1(self._id_A1AF);
              var_8 = _id_69F9();
              self._id_37F4 = var_8;
            }
          } else {
            _id_D4D1(var_1.pers["team"]);
            self._id_37F4 = var_1;
          }

          if(isDefined(self._id_EFB8[var_2])) {
            self._id_FEE7 = self._id_EFB8[var_2];
          }

          self._id_159B = 1;

          if(isDefined(self._id_A79B) && self._id_A79B > self._id_A79A[self._id_37F6]) {
            self._id_159B = 0;
          }

          if(self._id_FEE7 && isDefined(self._id_AA79) && self._id_159B && self._id_ADAE != self._id_37F6) {
            self._id_8ABF = 0;

            if(isDefined(self._id_497A) && !self._id_497A) {
              self[[self._id_AA79]](self._id_37F4);
            } else if(!isDefined(self._id_497A)) {
              self[[self._id_AA79]](self._id_37F4);
            }
          }
        } else if(isDefined(self._id_AA80))
          self[[self._id_AA80]](var_1);
      }
    }

    if(scripts\mp\utility\player::isreallyalive(var_1) && !isDefined(var_1._id_F398[var_0])) {
      var_1 thread _id_F634(self);
    }
  }
}

_id_BDDB(var_0) {
  if(!isDefined(self._id_C589)) {
    return 1;
  }

  var_1 = var_0 getEye();
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 0, 1, 0);
  var_3 = [];

  if(scripts\mp\utility\game::getgametype() == "tdef" || istrue(level._id_48DF)) {
    var_4 = self.trigger.origin + (0, 0, 16);
    var_5 = 0;
    var_3[0] = self._id_10430[0];
  } else if(scripts\mp\utility\game::getgametype() == "ball" || istrue(level._id_44D5)) {
    var_4 = self.trigger.origin + (0, 0, 8);
    var_5 = 0;
    var_3[0] = self._id_10430[0];
  } else {
    var_4 = self.trigger.origin + (0, 0, 32);
    var_5 = 1;
    var_3[0] = self._id_10430;
  }

  var_3[1] = self._id_32D5;
  var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);

  if(var_6["fraction"] != 1 && var_5) {
    var_4 = self.trigger.origin + (0, 0, 16);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  if(var_6["fraction"] != 1) {
    var_4 = self.trigger.origin + (0, 0, 0);
    var_6 = scripts\engine\trace::ray_trace(var_1, var_4, var_3, var_2, 0);
  }

  return var_6["fraction"] == 1;
}

_id_D4D1(var_0) {
  if(_id_694A() == "normal") {
    if(!isDefined(self._id_37F3)) {
      self._id_37F3 = 1000;
    }

    if(!istrue(self._id_7D35) && scripts\mp\utility\teams::_id_8878(var_0)) {
      if(self._id_8FAD != "none") {
        if(!isDefined(self._id_902E)) {
          self._id_902E = self._id_8FAD;
        }
      }
    }
  }

  self._id_8FAD = self._id_37F6;
  self._id_8FAE = gettime();
  self._id_37F6 = var_0;
  _id_07F9::objective_set_claiming_team(self._id_A908, self._id_37F6);
  _id_FD7C();
}

_id_695F() {
  return self._id_37F6;
}

_id_6AF6() {
  return self._id_8FAD;
}

_id_F634(var_0) {
  var_1 = self.pers["team"];

  if(isDefined(var_0._id_B0E6)) {
    _id_07F9::_id_A89B(var_0._id_A908, self);
    self._id_B0E5 = var_0._id_A908;

    if(isDefined(var_0._id_AB54)) {
      var_0[[var_0._id_AB54]](self);
    }
  }

  if(scripts\mp\utility\game::getgametype() == "patrol") {
    _id_07F9::_id_A876(var_0._id_A908, self);
  }

  if(!isDefined(self._id_F392)) {
    self._id_F392 = [];
  }

  var_2 = var_0.trigger getentitynumber();
  self._id_F392[var_2] = var_0;

  if(!isDefined(var_0._id_A6C4)) {
    var_0._id_A6C4 = 0;
  }

  self._id_F398[var_0._id_5513] = var_0.trigger;
  var_0 _id_FD7C();

  while(scripts\mp\utility\player::isreallyalive(self) && isDefined(var_0.trigger) && self istouching(var_0.trigger) && !level.gameended) {
    if(isDefined(var_0._id_3521) && var_0.team != var_1) {
      break;
    }

    if(istrue(self.inlaststand)) {
      break;
    }

    if(level.gametype == "base" && istrue(self.innocapturearea)) {
      break;
    }

    if(level.gametype == "base" && istrue(self._id_B072)) {
      break;
    }

    if(level.gametype == "base" && istrue(self.isredeploying)) {
      break;
    }

    if(isDefined(level.captureexclusiontriggers)) {
      var_3 = 0;

      foreach(var_5 in level.captureexclusiontriggers) {
        if(isDefined(var_5) && self istouching(var_5)) {
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        break;
      }
    }

    if(isDefined(var_0._id_83B1) && !isDefined(var_0._id_83B1[self.team]) || isDefined(var_0._id_83B1) && !scripts\engine\utility::array_contains(var_0._id_83B1[self.team], self._id_E496)) {
      break;
    }

    if(istrue(var_0.trigger._id_F5E0)) {
      break;
    }

    if(istrue(var_0._id_356F) && isDefined(var_0._id_FE35) && !var_0[[var_0._id_FE35]](self)) {
      break;
    }

    if(!scripts\mp\utility\player::_id_8ACE() && istrue(self._id_C36C)) {
      _id_07F9::_id_A89B(var_0._id_A908, self);
      self._id_C36C = undefined;
    }

    if(isPlayer(self) && var_0._id_FEE7 > 50) {
      _id_FD75(var_0, 1);
    }

    waitframe();
  }

  if(isDefined(self)) {
    if(var_0._id_FEE7 > 50) {
      if(isPlayer(self)) {
        _id_FD75(var_0, 0);
      }

      self._id_F398[var_0._id_5513] = undefined;
    } else
      self._id_F398[var_0._id_5513] = undefined;

    self._id_F392[var_2] = undefined;
  }

  if(level.gameended) {
    return;
  }
  var_0._id_AA3C = var_0._id_F396;

  if(isDefined(self)) {
    var_0._id_F396[var_1][self.guid] = undefined;
  } else {
    var_7 = [];

    foreach(var_10, var_9 in var_0._id_F396[var_1]) {
      if(!isDefined(var_9.player)) {
        var_7[var_7.size] = var_10;
      }
    }

    foreach(var_10 in var_7) {
      var_0._id_F396[var_1][var_10] = undefined;
    }
  }

  if(isDefined(self) && isDefined(var_0._id_A908)) {
    _id_07F9::_id_A8CF(var_0._id_A908, self, var_0._id_DCD1);

    if(scripts\mp\utility\game::getgametype() == "patrol") {
      _id_07F9::_id_A8BF(var_0._id_A908, self);
    }

    self._id_B0E5 = undefined;

    if(var_0._id_8FAD == "none") {
      if(isDefined(var_0._id_3225) && var_0._id_3225 == "persistent") {
        _id_07F9::_id_A8C4(var_0._id_A908, 0);
      }
    }
  }

  var_0._id_A79A[var_1]--;
  var_0 _id_FD7C();

  if(isDefined(var_0._id_ABC9)) {
    var_0[[var_0._id_ABC9]]();
  }
}

_id_9E90(var_0) {
  var_0._id_9E90 = 1;
  level waittill("host_migration_begin");

  if(!isDefined(var_0) || !isDefined(self)) {
    return;
  }
  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0);
  self._id_9E90 = undefined;
}

_id_6BBA(var_0) {
  return self._id_A79A[var_0];
}

_id_6BB9(var_0) {
  var_1 = 0;
  var_2 = 0;
  self._id_A1AE = 0;
  self._id_A1AF = "none";

  foreach(var_4 in level._id_EF89) {
    var_2 = var_2 + self._id_A79A[var_4];

    if(var_2 > 0 && var_2 > self._id_A1AE) {
      self._id_A1AE = var_2;
      self._id_A1AF = var_4;
      var_2 = 0;
    }

    if(var_4 != var_0) {
      var_1 = var_1 + self._id_A79A[var_4];
    }
  }

  return var_1;
}

_id_FD75(var_0, var_1) {
  if(!isDefined(level._id_7AAE)) {
    if(isDefined(var_0._id_83B6) && var_0._id_83B6 == "none") {
      self setclientomnvar("ui_objective_state", 0);
    } else {
      var_2 = undefined;

      if(isDefined(var_0._id_A908)) {
        var_2 = var_0._id_A908;
      }

      var_3 = 0;

      if(isDefined(var_0._id_EF94) && isDefined(var_0._id_37F6)) {
        if(var_0._id_EF94[var_0._id_37F6] > var_0._id_FEE7) {
          var_0._id_EF94[var_0._id_37F6] = var_0._id_FEE7;
        }

        var_3 = var_0._id_EF94[var_0._id_37F6] / var_0._id_FEE7;
      } else {
        if(var_0._id_4143 > var_0._id_FEE7) {
          var_0._id_4143 = var_0._id_FEE7;
        }

        var_3 = var_0._id_4143 / var_0._id_FEE7;

        if(var_0._id_FEE7 <= 1000) {
          var_3 = min(var_3 + 0.05, 1);
        } else {
          var_3 = min(var_3 + 0.01, 1);
        }
      }

      if(scripts\mp\utility\game::getgametype() == "ctf" && !isDefined(var_0._id_7C8C) || scripts\mp\utility\game::getgametype() == "blitz" && !isDefined(var_0._id_7C8C)) {
        if(var_1 && istrue(var_0._id_E57B)) {
          if(!isDefined(self._id_F90D)) {
            if(!isDefined(self._id_F90C)) {
              self._id_F90C = 1;
            }

            self setclientomnvar("ui_objective_state", -1);
            self._id_F90D = 1;
          }

          var_3 = 0.01;
        } else if(var_1 && isDefined(self._id_F90C) && isDefined(var_0._id_E57B) && !var_0._id_E57B && var_0._id_ADAE != self.team) {
          self setclientomnvar("ui_objective_state", 1);
          self._id_F90C = 1;
          self._id_F90D = undefined;
        } else if(var_1 && isDefined(self._id_F90C) && isDefined(var_0._id_E57B) && !var_0._id_E57B && var_0._id_ADAE == self.team) {
          self setclientomnvar("ui_objective_state", 2);
          self._id_F90C = 1;
          self._id_F90D = undefined;
        } else {
          if(!var_1 && isDefined(self._id_F90D)) {
            self setclientomnvar("ui_objective_state", 0);
            self._id_F90C = undefined;
          }

          if(var_1 && !isDefined(self._id_F90D) && var_0._id_ADAE == self.team) {
            self setclientomnvar("ui_objective_state", 0);
            self._id_F90C = undefined;
          }

          if(var_1 && !isDefined(self._id_F90C)) {
            if(var_0._id_ADAE != self.team) {
              self setclientomnvar("ui_objective_state", 1);
              self._id_F90C = 1;
            } else if(var_0._id_83B6 == "any") {
              self setclientomnvar("ui_objective_state", 2);
              self._id_F90C = 1;
            }
          }

          self._id_F90D = undefined;
        }

        if(!var_1) {
          var_3 = 0.01;
          self setclientomnvar("ui_objective_state", 0);
          self._id_F90C = undefined;
        }

        if(var_3 != 0) {
          _id_07F9::_id_A8B6(var_2, self.team);
          _id_07F9::_id_A8C4(var_2, 1);
          _id_07F9::_id_A8B4(var_2, var_3);
        }
      }

      if(_id_7554() && isDefined(var_0._id_7C8C) && (var_0._id_7C8C == "domFlag" || var_0._id_7C8C == "hardpoint" || var_0._id_7C8C == "bomb_site")) {
        if(var_1 && isDefined(var_0._id_E57B) && var_0._id_E57B && !istrue(var_0._id_9987)) {
          if(!isDefined(self._id_F90F)) {
            if(!isDefined(self._id_F90E)) {
              self._id_F90E = 1;
            }

            self._id_F90F = 1;
            self setclientomnvar("ui_objective_state", 3);
          }
        } else if(var_1 && isDefined(self._id_F90E) && (isDefined(var_0._id_E57B) && !var_0._id_E57B && !istrue(var_0._id_9987)) && var_0._id_ADAE != self.team) {
          self._id_F90E = 1;
          self._id_F90F = undefined;

          if(scripts\mp\utility\game::getgametype() == "hq") {
            if(var_0._id_ADAE == "neutral") {
              self setclientomnvar("ui_objective_state", 1);
            } else {
              self setclientomnvar("ui_objective_state", 2);
            }
          } else if(istrue(var_0._id_A436) && var_0._id_ADAE != self.team && var_0._id_ADAE != "neutral")
            self setclientomnvar("ui_objective_state", var_0 scripts\mp\gametypes\obj_dom::_id_69ED());
          else {
            self setclientomnvar("ui_objective_state", 1);
          }
        } else {
          if(!var_1 && isDefined(self._id_F90F)) {
            if(isDefined(var_0._id_AD59)) {
              _id_07F9::_id_A8B6(var_2, var_0._id_AD59);
            } else if(isDefined(var_0._id_902E) && var_0._id_902E != var_0._id_37F6) {
              _id_07F9::_id_A8B6(var_2, var_0._id_902E);
            } else if(var_0._id_37F6 != "none") {
              _id_07F9::_id_A8B6(var_2, var_0._id_37F6);
            }

            self._id_F90E = undefined;
            self setclientomnvar("ui_objective_state", 0);
          } else if(var_1 && istrue(var_0._id_9987) && isDefined(var_0._id_902E) && var_0._id_902E == var_0._id_37F6) {
            if(isDefined(var_0._id_AD59)) {
              _id_07F9::_id_A8B6(var_2, var_0._id_AD59);
            } else if(var_0._id_ADAE != "neutral" && var_0._id_37F6 == var_0._id_ADAE) {
              self setclientomnvar("ui_objective_state", 0);
            } else if(var_0._id_37F6 != "none") {
              if(scripts\mp\utility\game::getgametype() == "hq") {
                if(var_0._id_ADAE == "neutral") {
                  self setclientomnvar("ui_objective_state", 1);
                } else {
                  self setclientomnvar("ui_objective_state", 2);
                }
              } else if(istrue(var_0._id_A436) && var_0._id_ADAE != self.team && var_0._id_ADAE != "neutral")
                self setclientomnvar("ui_objective_state", var_0 scripts\mp\gametypes\obj_dom::_id_69ED());
              else {
                self setclientomnvar("ui_objective_state", 1);
              }

              _id_07F9::_id_A8B6(var_2, var_0._id_37F6);
            }
          }

          if(var_1 && !isDefined(self._id_F90F) && var_0._id_ADAE == self.team) {
            self._id_F90E = undefined;
            self setclientomnvar("ui_objective_state", 0);
          }

          if(var_1 && !isDefined(self._id_F90E) && var_0._id_ADAE != self.team) {
            self._id_F90E = 1;
          }

          self._id_F90F = undefined;
        }

        if(scripts\mp\utility\game::getgametype() != "rush") {
          if(!var_1 || !var_0 _id_318C(self.team, self) && (!isDefined(var_0._id_E57B) || isDefined(var_0._id_E57B) && !var_0._id_E57B)) {
            if(var_0._id_4143 == 0) {
              _id_07F9::_id_A8C4(var_2, 0);
            }

            self._id_F90E = undefined;
            self setclientomnvar("ui_objective_state", 0);
          }
        }

        if(var_3 != 0) {
          if(_id_DCE2(var_0)) {
            _id_07F9::_id_A8C5(var_2, var_0._id_37F6);
          } else {
            _id_07F9::_id_A8C4(var_2, 1);
          }

          if(level.teambased && isDefined(var_0._id_EF94) && isDefined(var_0._id_37F6) && var_1) {
            if(!var_0._id_E57B) {
              if(isDefined(var_0._id_AD59)) {
                _id_07F9::_id_A8B6(var_0._id_A908, var_0._id_AD59);
                _id_07F9::_id_A8B4(var_0._id_A908, var_0._id_EF94[var_0._id_AD59] / var_0._id_FEE7);
              } else {
                _id_07F9::_id_A8B6(var_0._id_A908, var_0._id_37F6);
                _id_07F9::_id_A8B4(var_0._id_A908, var_3);
              }

              if(self.team == var_0._id_37F6) {
                if(scripts\mp\utility\game::getgametype() == "hq") {
                  if(var_0._id_ADAE == "neutral") {
                    self setclientomnvar("ui_objective_state", 1);
                  } else {
                    self setclientomnvar("ui_objective_state", 2);
                  }
                } else if(istrue(var_0._id_A436) && var_0._id_ADAE != self.team && var_0._id_ADAE != "neutral")
                  self setclientomnvar("ui_objective_state", var_0 scripts\mp\gametypes\obj_dom::_id_69ED());
                else {
                  self setclientomnvar("ui_objective_state", 1);
                }
              } else
                self setclientomnvar("ui_objective_state", 5);
            } else if(var_0._id_E57B && istrue(var_0._id_9987)) {
              _id_07F9::_id_A8B6(var_0._id_A908, var_0._id_37F6);
              _id_07F9::_id_A8B4(var_0._id_A908, var_3);

              if(self.team == var_0._id_37F6) {
                if(scripts\mp\utility\game::getgametype() == "hq") {
                  if(var_0._id_ADAE == "neutral") {
                    self setclientomnvar("ui_objective_state", 1);
                  } else {
                    self setclientomnvar("ui_objective_state", 2);
                  }
                } else if(istrue(var_0._id_A436) && var_0._id_ADAE != self.team && var_0._id_ADAE != "neutral")
                  self setclientomnvar("ui_objective_state", 6);
                else {
                  self setclientomnvar("ui_objective_state", 1);
                }
              } else
                self setclientomnvar("ui_objective_state", 5);
            } else
              _id_07F9::_id_A8B6(var_2, undefined);
          } else if(!level.teambased)
            _id_07F9::_id_A8B5(var_2, self);
        }
      } else {
        if(_id_8785() && isDefined(var_0._id_7C8C) && (var_0._id_7C8C == "bomb_zone" || var_0._id_7C8C == "defuse_object")) {
          if(isDefined(self)) {
            if(var_1 && isDefined(self)) {
              if(!isDefined(self._id_F90B)) {
                var_4 = 0;

                if(var_0._id_7C8C == "bomb_zone") {
                  var_4 = 1;
                } else if(var_0._id_7C8C == "defuse_object") {
                  var_4 = 2;
                }

                self._id_F90B = 1;
              }
            } else {
              self._id_F90B = undefined;

              if(!isDefined(var_0._id_C63B) || istrue(var_0._id_C63B)) {
                var_3 = 0.01;
              }
            }

            if(var_3 != 0) {
              if(!isDefined(self._id_DCD9)) {
                _id_07F9::_id_A8B6(var_2, self.team);
                _id_07F9::_id_A8C5(var_2, self.team);
                self._id_DCD9 = self.team;
              }

              _id_07F9::_id_A8B4(var_2, var_3);
              setomnvar("ui_bomb_progress", var_3);
              return;
            }

            return;
          }

          return;
        }

        if(isDefined(var_0._id_7C8C)) {
          var_4 = 0;

          switch (var_0._id_7C8C) {
            case "care_package":
            case "bradley":
              var_4 = 1;
              break;
            case "intel":
              var_4 = 2;
              break;
            case "support_box":
              var_4 = 3;
              break;
            case "deployable_weapon_crate":
              var_4 = 4;
              break;
            case "laststand_reviver":
              var_4 = 5;
              break;
            case "laststand_revivee":
              var_4 = 6;
              break;
            case "breach":
              var_4 = 7;
              break;
            case "use":
              var_4 = 8;
              break;
            case "breach_defuse":
              var_4 = 9;
              break;
            case "bounty":
              var_4 = 10;
              break;
            case "hack":
              var_4 = 13;
              break;
            case "hvt_search":
              var_4 = 15;
              break;
            case "baseRepair":
              var_4 = 17;
              break;
          }

          _id_FD77(var_3, var_1, var_4, var_0, var_0._id_FEE7);
        }
      }
    }
  }
}

_id_DCE2(var_0) {
  switch (scripts\mp\utility\game::getgametype()) {
    case "vip":
      if(var_0._id_37F6 == game["attackers"]) {
        return 1;
      }
  }

  return 0;
}

_id_7554() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "cmd":
    case "grnd":
    case "grind":
    case "defcon":
    case "mendota":
    case "rush":
    case "kspoint":
    case "btm":
    case "hq":
    case "pill":
    case "mtmc":
    case "koth":
    case "arena_evo":
    case "arena":
    case "siege":
    case "dom":
    case "control":
    case "base":
    case "br":
    case "arm":
      return 1;
    default:
      return 0;
  }

  return 0;
}

_id_FD77(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(var_1) {
    if(!isDefined(var_3._id_FE45)) {
      var_3._id_FE45 = [];
    }

    if(!isDefined(self._id_9E90)) {
      var_3 thread _id_9E90(self);
    }

    if(!_id_5730(self, var_3._id_FE45)) {
      var_3._id_FE45[var_3._id_FE45.size] = self;
    }

    if(!isDefined(self._id_F913)) {
      self setclientomnvar("ui_securing", var_2);
      self._id_F913 = 1;

      if(isDefined(var_3.trigger) && var_3.trigger _id_8A06()) {
        if(isDefined(var_3.trigger.owner)) {
          var_3.trigger.owner setclientomnvar("ui_reviver_id", self getentitynumber());
          var_3.trigger.owner setclientomnvar("ui_securing", 6);
        }
      }
    }

    if(scripts\mp\utility\game::getgametype() == "br" && var_3._id_7C8C == "laststand_reviver") {
      var_6 = undefined;

      if(isDefined(var_3.trigger) && var_3.trigger _id_8A06()) {
        var_6 = var_3.trigger.owner;
      }

      if(isDefined(var_6) && self == var_6) {
        self setclientomnvar("ui_securing", 16);
      }

      scripts\mp\gametypes\br::_id_FD3E(var_6, self, var_0);
    }
  } else {
    if(isDefined(var_3._id_FE45) && _id_5730(self, var_3._id_FE45)) {
      var_3._id_FE45 = scripts\engine\utility::array_remove(var_3._id_FE45, self);
    }

    self setclientomnvar("ui_securing", 0);
    self._id_F913 = undefined;

    if(isDefined(var_3.trigger) && var_3.trigger _id_8A06()) {
      if(isDefined(var_3.trigger.owner)) {
        var_3.trigger.owner setclientomnvar("ui_reviver_id", -1);
        var_3.trigger.owner setclientomnvar("ui_securing", 0);
      }
    }

    var_0 = 0.01;

    if(isDefined(var_3._id_A908)) {
      var_5 = var_3._id_A908;
    }
  }

  if(var_4 == 500) {
    var_0 = min(var_0 + 0.15, 1);
  }

  if(var_0 != 0) {
    self setclientomnvar("ui_securing_progress", var_0);

    if(isDefined(var_3.trigger) && var_3.trigger _id_8A06()) {
      if(isDefined(var_3.trigger.owner)) {
        var_3.trigger.owner setclientomnvar("ui_securing_progress", var_0);
      }
    }

    if(isDefined(var_3._id_A908)) {
      _id_07F9::_id_A8B4(var_3._id_A908, var_0);
    }
  }
}

_id_5730(var_0, var_1) {
  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_FD7C() {
  if(self._id_37F6 == "none" && self._id_ADAE != "neutral" && self._id_ADAE != "any") {
    var_0 = self._id_ADAE;
  } else {
    var_0 = self._id_37F6;
  }

  var_1 = self._id_A79A[var_0];
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level._id_EF89) {
    if(var_0 != var_5) {
      var_2 = var_2 + self._id_A79A[var_5];
    }
  }

  foreach(var_8 in self._id_F396[var_0]) {
    if(!isDefined(var_8.player)) {
      continue;
    }
    if(var_8.player.pers["team"] != var_0) {
      continue;
    }
    if(var_8.player._id_A8EC == 1) {
      continue;
    }
    var_1 = var_1 * var_8.player._id_A8EC;
    var_3 = var_8.player._id_A8EC;
  }

  self._id_E57B = scripts\engine\utility::ter_op(istrue(self._id_165F), var_1 && var_2, var_1 && var_2 && var_1 == var_2);

  if(!var_1 && !var_2) {
    self._id_9987 = 0;
  }

  self._id_FEB1 = 0;

  if(var_1) {
    if(var_1 > var_2) {
      self._id_FEB1 = min(var_1 - var_2, scripts\engine\utility::ter_op(isDefined(level._id_A8EC), level._id_A8EC, 4));

      if(self._id_FEB1 > 1.0) {
        self._id_FEB1 = self._id_FEB1 * self._id_FEB2;
      }
    }
  }

  if(isDefined(self._id_875C) && self._id_875C && var_3 != 0) {
    self._id_FEB1 = 1 * var_3;
  } else if(isDefined(self._id_875C) && self._id_875C) {
    self._id_FEB1 = 1;
  }
}

_id_FE7D(var_0) {
  var_0 notify("use_hold");

  if(self._id_56E2) {
    var_0 _meth_808A(self.trigger);
  }

  var_0 allowmovement(0);
  var_1 = isDefined(self._id_7C8C) && (self._id_7C8C == "traversalassist" || self._id_7C8C == "breach" || self._id_7C8C == "care_package");

  if(_id_8785()) {
    if(var_1 || level.gametype == "cyber") {} else if(scripts\mp\utility\game::isanymlgmatch() || istrue(level._id_DD44)) {
      var_0 _meth_84A8("silent_plant", "on");

      if(istrue(var_0._id_87F7)) {
        if(scripts\mp\utility\game::isholidayenabled(2)) {
          self.useweapon = makeweapon("s4_remote_bomb_defuse_silent_holiday_mp");
        } else if(scripts\mp\utility\game::isholidayenabled(3)) {
          self.useweapon = makeweapon("s4_remote_bomb_defuse_silent_vday_mp");
        } else {
          self.useweapon = makeweapon("s4_remote_bomb_defuse_silent_mp");
        }
      } else if(scripts\mp\utility\game::isholidayenabled(2))
        self.useweapon = makeweapon("s4_bomb_remote_silent_holiday_mp");
      else if(scripts\mp\utility\game::isholidayenabled(3)) {
        self.useweapon = makeweapon("s4_bomb_remote_silent_vday_mp");
      } else {
        self.useweapon = makeweapon("s4_bomb_remote_silent_mp");
      }
    }
  }

  var_2 = self.useweapon;
  var_3 = var_0 getcurrentweapon();

  if(isDefined(var_2)) {
    var_4 = 0;

    if(var_3.basename == "iw8_cyberemp_mp") {
      var_4 = 1;
    }

    if(var_3 == var_2) {
      var_3 = var_0._id_9020;
    }

    var_0._id_9020 = var_3;
    var_5 = 0;
    var_6 = 0;

    if(scripts\mp\utility\game::getgametype() == "cyber") {
      var_5 = 1;
      var_6 = 0;
    }

    var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2, undefined, undefined, 0);
    var_0 setweaponammostock(var_2, var_5);
    var_0 setweaponammoclip(var_2, var_5);
    var_0 thread _id_EC3E(var_2, var_4);
  } else if(!var_1) {
    if(isDefined(self.trigger) && self.trigger _id_8A06()) {
      if(!var_0 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon")) {
        var_0._id_10DCF = 1;

        if(!level._id_15CE) {
          var_0 scripts\cp_mp\utility\player_utility::_id_5244();
          var_0 scripts\common\utility::_id_153E(0);
          var_0 scripts\common\utility::_id_151F(0);
          var_0 scripts\common\utility::_id_1562(0);
        } else
          var_0 scripts\mp\playeractions::_id_1596("reviveShoot", 0);
      }
    } else
      var_0 scripts\common\utility::_id_158D(0);
  }

  if(!isDefined(var_0._id_FF0C)) {
    var_0._id_FF0C = [];
  }

  var_7 = self.trigger getentitynumber();
  var_0._id_FF0C[var_7] = self;

  if(!isDefined(self._id_C63B) || istrue(self._id_C63B)) {
    self._id_4143 = 0;
  }

  self._id_84EF = 1;
  self._id_FEB1 = 0;
  var_8 = _id_FE7F(var_0, var_3);

  if(isDefined(var_0)) {
    var_0._id_FF0C[var_7] = undefined;
    var_0 _id_4890();
    var_0 notify("done_using");
  }

  if(isDefined(var_2) && isDefined(var_0)) {
    if(scripts\mp\utility\game::getgametype() == "cyber" && !_id_8A06() && !istrue(var_8)) {
      var_0 setweaponammostock(var_2, 0);
      var_0 setweaponammoclip(var_2, 0);
    }

    var_0 scripts\mp\supers::_id_FB29();

    if(var_0 scripts\cp_mp\utility\inventory_utility::_id_8A86(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_2);
      var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_3);
    } else if(scripts\mp\utility\game::getgametype() == "sd") {
      if(!istrue(var_8)) {
        var_0 setweaponammostock(var_2, 1);
        var_0 setweaponammoclip(var_2, 1);
      }

      if(var_0 scripts\mp\utility\killstreak::_id_88DF()) {
        var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
        var_0 _id_0A95::_id_EC3C();
      } else if(var_3.basename == "s4_la_walpha2_mp" && istrue(var_0.pers["wmStreakAmmo"])) {
        var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
        var_9 = var_0 scripts\mp\killstreaks\killstreaks::_id_6A1A("warmachine");
        var_0 scripts\mp\killstreaks\killstreaks::_id_4D05(undefined, var_9);
      } else if(var_3.basename == "s4_mg_streak_mp" && istrue(var_0.pers["mgStreakAmmo"])) {
        var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
        var_9 = var_0 scripts\mp\killstreaks\killstreaks::_id_6A1A("lmg_streak");
        var_0 scripts\mp\killstreaks\killstreaks::_id_4D05(undefined, var_9);
      } else
        var_0 thread scripts\cp_mp\utility\inventory_utility::_id_6CF7(var_2);
    } else if(var_0 scripts\mp\utility\killstreak::_id_88DF()) {
      var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
      var_0 _id_0A95::_id_EC3C();
    } else
      var_0 thread scripts\cp_mp\utility\inventory_utility::_id_6CF7(var_2);
  }

  if(istrue(var_8)) {
    var_0 allowmovement(1);
    return 1;
  } else if(!istrue(var_8)) {
    if(!isDefined(self._id_C63B) || istrue(self._id_C63B)) {
      self._id_4143 = 0;
    } else {
      _id_9A18(var_0);
    }
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_2) && !var_1) {
      if(isDefined(self.trigger) && self.trigger _id_8A06()) {
        if(istrue(var_0._id_10DCF)) {
          var_0._id_10DCF = undefined;

          if(!level._id_15CE) {
            var_0 scripts\cp_mp\utility\player_utility::_id_4A9A();
            var_0 scripts\common\utility::_id_153E(1);
            var_0 scripts\common\utility::_id_151F(1);
            var_0 scripts\common\utility::_id_1562(1);
          } else
            var_0 scripts\mp\playeractions::_id_1596("reviveShoot", 1);
        }
      } else
        var_0 scripts\common\utility::_id_158D(1);
    }

    var_0 allowmovement(1);
  }

  self._id_84EF = 0;

  if(self._id_56E2 && isDefined(self.trigger)) {
    self.trigger _meth_828C();
  }

  return 0;
}

_id_9A18(var_0) {
  if(!isDefined(self._id_BC57)) {
    self._id_BC57 = 0;
  }

  var_1 = self._id_4143 - self._id_BC57;

  if(var_1 <= 1000) {
    self._id_4143 = self._id_BC57;
  }

  var_2 = self._id_FEE7 - self._id_4143;

  if(var_2 < 1000) {
    if(self._id_FEE7 <= 1000) {
      self._id_4143 = self._id_FEE7;
    } else {
      self._id_4143 = self._id_FEE7 - 1000;
    }
  }

  var_1 = 0;

  if(self._id_4143 > 0) {
    if(isDefined(self._id_EF94) && isDefined(self._id_37F6)) {
      if(self._id_EF94[self._id_37F6] > self._id_FEE7) {
        self._id_EF94[self._id_37F6] = self._id_FEE7;
      }

      var_1 = self._id_EF94[self._id_37F6] / self._id_FEE7;
    } else {
      if(self._id_4143 > self._id_FEE7) {
        self._id_4143 = self._id_FEE7;
      }

      var_1 = self._id_4143 / self._id_FEE7;

      if(self._id_FEE7 <= 1000) {
        var_1 = min(var_1 + 0.05, 1);
      } else {
        var_1 = min(var_1 + 0.01, 1);
      }
    }
  }

  _id_07F9::_id_A8B6(self._id_A908, var_0.team);
  _id_07F9::_id_A8B4(self._id_A908, var_1);

  if(self._id_4143 > 0) {
    _id_07F9::_id_A8C5(self._id_A908, var_0.team);
  } else {
    _id_07F9::_id_A8C4(self._id_A908, 0);
  }

  self._id_BC57 = self._id_4143;
}

_id_4890() {
  if(isDefined(self._id_1D84)) {
    self detach(self._id_1D84, "tag_inhand");
    self._id_1D84 = undefined;
  }
}

_id_EC3E(var_0, var_1) {
  scripts\mp\supers::_id_15D9();
  var_2 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, var_1);

  if(!istrue(var_2)) {
    scripts\mp\supers::_id_FB29();

    if(scripts\cp_mp\utility\inventory_utility::_id_8A86(var_0)) {
      scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_0);
    } else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    }
  }
}

_id_FEE0(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return 0;
  }

  if(!var_0 scripts\common\utility::_id_86F9()) {
    return 0;
  }

  if(!isDefined(self._id_DDC9) && (isDefined(self.trigger) && !var_0 istouching(self.trigger))) {
    return 0;
  }

  if(!level._id_15CE && !var_0 useButtonPressed(1)) {
    return 0;
  }

  if(var_0 scripts\mp\utility\weapon::_id_7169()) {
    return 0;
  }

  if(var_0 meleeButtonPressed()) {
    return 0;
  }

  if(var_0 _meth_86C8()) {
    return 0;
  }

  if(var_0 _meth_86C9()) {
    return 0;
  }

  if(self._id_4143 >= self._id_FEE7) {
    return 0;
  }

  if(!self._id_FEB1 && !var_1) {
    return 0;
  }

  if(var_1 && var_2 > var_3) {
    return 0;
  }

  if(istrue(self._id_356F) && isDefined(self._id_FE35) && !self[[self._id_FE35]](var_0)) {
    return 0;
  }

  if(isDefined(self.useweapon)) {
    if(var_0 getcurrentweapon() != self.useweapon && !var_0 scripts\cp_mp\utility\inventory_utility::_id_8A86(self.useweapon)) {
      return 0;
    }
  }

  if(self.trigger _id_8A06()) {
    if(!var_0 isonground()) {
      return 0;
    }
  }

  return 1;
}

_id_FE7F(var_0, var_1) {
  level endon("game_ended");
  self endon("disabled");
  var_2 = self.useweapon;
  var_3 = 1;

  if(isDefined(self._id_10836)) {
    var_3 = self._id_10836;
  }

  if(!var_3) {
    self._id_FEB1 = 1 * var_0._id_A8EC;
  }

  var_4 = 0;
  var_5 = 1.5;
  var_6 = level._id_5F3A;
  var_7 = var_6 * 1000;
  var_8 = undefined;

  while(_id_FEE0(var_0, var_3, var_4, var_5)) {
    if(isDefined(self._id_A908)) {
      _id_07F9::_id_A89B(self._id_A908, var_0);
    }

    var_4 = var_4 + var_6;

    if(!var_3 || !isDefined(var_2) || var_0 getcurrentweapon() == var_2) {
      self._id_4143 = self._id_4143 + var_7 * self._id_FEB1;
      self._id_FEB1 = 1 * var_0._id_A8EC;
      var_3 = 0;
    } else
      self._id_FEB1 = 0;

    var_0 _id_FD75(self, 1);

    if(self._id_4143 >= self._id_FEE7) {
      self._id_84EF = 0;

      if(self._id_56E2) {
        var_0 _meth_808B(self.trigger);
      }

      var_9 = isDefined(self._id_7C8C) && (self._id_7C8C == "traversalassist" || self._id_7C8C == "breach" || self._id_7C8C == "care_package");

      if(!isDefined(var_2) && !var_9) {
        if(self.trigger _id_8A06()) {
          if(istrue(var_0._id_10DCF)) {
            var_0._id_10DCF = undefined;

            if(!level._id_15CE) {
              var_0 scripts\cp_mp\utility\player_utility::_id_4A9A();
              var_0 scripts\common\utility::_id_153E(1);
              var_0 scripts\common\utility::_id_151F(1);
              var_0 scripts\common\utility::_id_1562(1);
            } else
              var_0 scripts\mp\playeractions::_id_1596("reviveShoot", 1);
          }
        } else
          var_0 scripts\common\utility::_id_158D(1);
      }

      var_0 unlink();

      if(isDefined(self._id_A908)) {
        _id_07F9::_id_A8CF(self._id_A908, var_0);
      }

      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    wait(var_6);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }

  if(isDefined(self._id_A908)) {
    _id_07F9::_id_A8CF(self._id_A908, var_0);
  }

  var_0 _id_FD75(self, 0);
  return 0;
}

_id_FD6D() {
  if(self._id_F637 != "use") {
    return;
  }
  if(self._id_83B6 == "none") {
    self.trigger.origin = self.trigger.origin - (0, 0, 10000);

    if(isDefined(self.trigger.classname) && self.trigger.classname != "script_model") {
      self.trigger _meth_838B("none");
    }
  } else if(self._id_83B6 == "any") {
    self.trigger.origin = self._id_4140;
    self.trigger _meth_838B("none");
  } else if(self._id_83B6 == "friendly") {
    self.trigger.origin = self._id_4140;

    if(scripts\engine\utility::array_contains(level._id_EF89, self._id_ADAE)) {
      self.trigger _meth_838B(self._id_ADAE);
    } else {
      self.trigger.origin = self.trigger.origin - (0, 0, 50000);
    }
  } else if(self._id_83B6 == "enemy") {
    self.trigger.origin = self._id_4140;

    if(self._id_ADAE == "allies") {
      self.trigger _meth_838B("axis");
    } else if(self._id_ADAE == "axis") {
      self.trigger _meth_838B("allies");
    } else {
      self.trigger _meth_838B("none");
    }
  }
}

_id_6B63(var_0) {
  if(var_0 == "allies") {
    return game["colors"]["friendly"];
  } else if(var_0 == "axis") {
    return game["colors"]["enemy"];
  }

  return (1, 1, 1);
}

_id_D620(var_0, var_1, var_2) {
  if(var_1 == "mlg_allies") {
    var_0 _meth_85C3(1, 0);
    var_3 = self._id_A905[var_2];

    if(var_3 == "friendly") {
      var_0.color = _id_6B63("allies");
      return;
    }

    if(var_3 == "enemy") {
      var_0.color = _id_6B63("axis");
      return;
    }

    var_0.color = game["colors"][var_3];
    return;
    return;
  } else if(var_1 == "mlg_axis") {
    var_0 _meth_85C3(1, 0);
    var_3 = self._id_A905[var_2];

    if(var_3 == "friendly") {
      var_0.color = _id_6B63("axis");
      return;
    }

    if(var_3 == "enemy") {
      var_0.color = _id_6B63("allies");
      return;
    }

    var_0.color = game["colors"][var_3];
    return;
    return;
  } else {
    var_0.color = game["colors"][self._id_A905[var_2]];
    var_0 _meth_85C3(0, 1);
  }
}

_id_791C() {
  self notify("hideWorldIconOnGameEnd");
  self endon("hideWorldIconOnGameEnd");
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self.alpha = 0;
  }
}

_id_FD63(var_0, var_1) {}

_id_D61B(var_0, var_1, var_2, var_3) {
  if(istrue(self._id_970A)) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  if(!isDefined(self._id_7C73)) {
    self._id_7C73 = "";
  }

  self._id_3B0A["friendly"] = var_0 + self._id_7C73;
  self._id_3B0A["enemy"] = var_1 + self._id_7C73;
  _id_FC3B(var_2, var_3);
}

_id_FC3B(var_0, var_1) {
  var_2 = self._id_1041A;

  if(!isDefined(self._id_1041A)) {
    var_2 = "none";
  }

  _id_FC3A(var_2, var_0, var_1);
}

_id_FC3A(var_0, var_1, var_2) {
  var_3 = _id_6E28(var_0);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_3._id_EFA0.size; var_5++) {
    var_6 = var_3._id_EFA0[var_5];
    var_7 = var_6.team;

    if(!scripts\mp\utility\teams::_id_8878(var_7)) {
      continue;
    }
    var_8 = var_6._id_DCF7;

    if(!var_8 && _id_DBD0(var_7)) {
      var_8 = 1;
    }

    if(!isDefined(var_1)) {
      var_1 = self._id_A908;
    }

    if(var_1 != -1) {
      if(!istrue(self._id_10416)) {
        if(!isDefined(self._id_3B0A["friendly"]) || !var_8) {
          _id_07F9::_id_A8C9(var_1, var_7);
          continue;
        } else
          _id_07F9::_id_A8C8(var_1, var_7);

        if(!isDefined(self._id_3B0A["enemy"]) || !var_8) {
          _id_07F9::_id_A8C9(var_1, var_7);
          continue;
        } else
          _id_07F9::_id_A8C8(var_1, var_7);
      }

      if(!var_4) {
        var_9 = _id_6E5A(self._id_3B0A["friendly"]);
        _id_07F9::_id_FB8F(var_1, var_9);
        var_10 = _id_6E57(self._id_3B0A["friendly"]);
        var_10 = scripts\engine\utility::ter_op(isDefined(var_10), var_10, "neutral");
        var_11 = _id_6E57(self._id_3B0A["enemy"]);
        var_11 = scripts\engine\utility::ter_op(isDefined(var_11), var_11, "neutral");
        var_12 = 0;
        var_13 = _id_6BC0(var_10, var_11);

        if(var_13 == "contest") {
          var_12 = 1;
        }

        if(var_12) {
          _id_07F9::_id_A8B6(var_1, undefined);
          _id_07F9::_id_FB9B(var_1, 1);
        } else
          _id_07F9::_id_FB9B(var_1, 0);

        if(isDefined(var_2)) {
          self._id_ADAE = var_2;
        }

        var_14 = _id_6E5B(self._id_3B0A["friendly"]);
        var_15 = _id_6E5B(self._id_3B0A["enemy"]);

        if(var_13 == "neutral" || !isDefined(self._id_ADAE)) {
          if(isDefined(self._id_37F6) && self._id_37F6 != "none") {
            _id_07F9::_id_FB96(var_1, self._id_37F6);
            _id_07F9::_id_FB9A(var_1, var_14);
            _id_07F9::_id_FB99(var_1, var_15);
          } else {
            _id_07F9::_id_FB96(var_1, undefined);
            _id_07F9::_id_FB9C(var_1, var_14);
          }
        } else if(var_13 == "claimed") {
          if(self._id_ADAE != "neutral") {
            _id_07F9::_id_FB96(var_1, self._id_ADAE);
          } else {
            _id_07F9::_id_FB96(var_1, undefined);
          }

          _id_07F9::_id_FB9A(var_1, var_14);
          _id_07F9::_id_FB99(var_1, var_15);
        } else if(var_13 == "contest") {
          if(self._id_316A && self._id_E57B != self._id_10A20 || self._id_316A && istrue(self._id_9987) && self._id_9987 != self._id_10A19) {
            _func_0167(var_1, var_14);
          } else {
            if(!scripts\mp\utility\teams::_id_8878(self._id_37F6)) {
              continue;
            }
            _id_07F9::_id_FB96(var_1, self._id_37F6);
            _id_07F9::_id_FB9A(var_1, var_14);
            _id_07F9::_id_FB99(var_1, var_15);
          }
        }

        var_16 = _id_6E58(self._id_3B0A["friendly"]);
        _id_07F9::_id_FB98(var_1, var_16);
        var_17 = _id_6E59(self._id_3B0A["friendly"]);
        _id_07F9::_id_A8B7(var_1, var_17);
        var_18 = getwaypointshowfreecamlabel(self._id_3B0A["friendly"]) || getwaypointshowfreecamlabel(self._id_3B0A["enemy"]);
        _id_07F9::_id_A8BA(var_1, var_18);

        if(_id_7554()) {
          if(!istrue(self._id_E57B) && self._id_ADAE != "neutral") {
            if(self._id_A79A["axis"] > 0 && self._id_A79A["allies"] > 0) {
              self._id_3226 = 1;
              _id_07F9::_id_FB9B(var_1, 1);
            } else {
              self._id_3226 = 0;
              _id_07F9::_id_FB9B(var_1, 0);
            }
          }
        }

        if(self.type == "carryObject") {
          if(scripts\mp\utility\player::isreallyalive(self._id_32D5) && !_id_DB98(var_0)) {
            _id_07F9::_id_FB93(var_1, self._id_32D5);
            _id_07F9::_id_FB9D(var_1, self._id_A97E[2]);
          } else if(isDefined(self._id_10430) && isDefined(self._id_10430[0]) && isDefined(self._id_10430[0] _meth_8151()))
            _id_07F9::_id_FB93(var_1, self._id_10430[0]);
          else if(isDefined(self._id_A8E5) && self._id_A8E5) {
            if(!_id_DB98(var_0)) {
              _id_07F9::_id_FB93(var_1, self._id_10430[0]);

              if(isDefined(self._id_A8E6)) {
                _id_07F9::_id_FB9D(var_1, self._id_A8E6[2]);
              }
            } else if(isDefined(self._id_A8E6))
              _id_07F9::_id_FB97(var_1, self._id_4140 + (0, 0, self._id_A8E6[2]));
            else {
              _id_07F9::_id_FB97(var_1, self._id_4140);
            }
          } else {
            _id_07F9::_id_FB97(var_1, self._id_4140);
            _id_07F9::_id_FB9D(var_1, self._id_A97E[2]);
          }
        } else if(isDefined(self._id_A903))
          _id_07F9::_id_FB93(var_1, self._id_A903);

        var_4 = 1;
        update_codcaster_objective_bystate(var_1, var_13);
      }
    }
  }
}

update_codcaster_objective_bystate(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  var_2 = getcodcasterwaypointshader(self._id_3B0A["friendly"]);
  var_3 = getcodcasterwaypointstring(self._id_3B0A["friendly"]);
  var_4 = getcodcasterwaypointstring(self._id_3B0A["enemy"]);
  update_codcaster_objective(var_0, var_1, var_2, var_3, var_4);
}

update_codcaster_objective(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == -1) {
    return;
  }
  if(!isDefined(var_2) && !isDefined(var_3) && !isDefined(var_4)) {
    _func_015F(var_0, 0);
    return;
  }

  var_5 = 0;
  var_6 = "";
  var_7 = "";
  var_8 = "";
  var_9 = "";

  if(!isDefined(var_2)) {
    var_2 = _id_6E5A(self._id_3B0A["friendly"]);
  }

  var_6 = var_2;

  if(!isDefined(var_4)) {
    var_4 = _id_6E5B(self._id_3B0A["enemy"]);
  }

  var_9 = var_4;

  if(!isDefined(var_3)) {
    var_3 = _id_6E5B(self._id_3B0A["friendly"]);
  }

  var_7 = var_3;
  var_8 = var_3;

  if(var_1 == "contest") {
    if(self._id_316A && self._id_E57B != self._id_10A20 || self._id_316A && istrue(self._id_9987) && self._id_9987 != self._id_10A19) {
      var_9 = var_3;
    }
  }

  _id_07F9::update_codcaster_objective(var_0, var_6, var_7, var_9, var_8);
  _func_015F(var_0, 1);
}

_id_DB98(var_0) {
  if(var_0 == "friendly" && self._id_A90B) {
    return 1;
  } else if(var_0 == "enemy" && self._id_A90C) {
    return 1;
  }

  return 0;
}

_id_6E28(var_0) {
  var_1 = spawnStruct();
  var_1._id_EFA0 = [];

  foreach(var_3 in level._id_EF89) {
    var_4 = var_1._id_EFA0.size;
    var_1._id_EFA0[var_4] = spawnStruct();

    if(var_0 == "any") {
      var_1._id_EFA0[var_4].team = var_3;
      var_1._id_EFA0[var_4]._id_DCF7 = 1;
      continue;
    }

    if(var_0 == "friendly") {
      if(_id_886F(var_3)) {
        var_1._id_EFA0[var_4].team = var_3;
        var_1._id_EFA0[var_4]._id_DCF7 = 1;
      } else {
        var_1._id_EFA0[var_4].team = var_3;
        var_1._id_EFA0[var_4]._id_DCF7 = 0;
      }

      continue;
    }

    if(var_0 == "enemy") {
      if(_id_886F(var_3)) {
        var_1._id_EFA0[var_4].team = var_3;
        var_1._id_EFA0[var_4]._id_DCF7 = 0;
      } else {
        var_1._id_EFA0[var_4].team = var_3;
        var_1._id_EFA0[var_4]._id_DCF7 = 1;
      }

      continue;
    }

    if(var_0 == "none") {
      var_1._id_EFA0[var_4].team = var_3;
      var_1._id_EFA0[var_4]._id_DCF7 = 0;
    }
  }

  return var_1;
}

_id_6BC0(var_0, var_1) {
  if(var_0 == "contest" || var_1 == "contest") {
    return "contest";
  } else if(var_0 == "neutral" || var_1 == "neutral") {
    return "neutral";
  } else {
    return "claimed";
  }
}

_id_DBD0(var_0) {
  if(!isDefined(self._id_32D5)) {
    return 0;
  }

  if(self._id_32D5 scripts\mp\utility\perk::_hasperk("specialty_gpsjammer")) {
    return 0;
  }

  return _func_00D9(var_0);
}

_id_FD7F() {
  self endon("death");
  self endon("carrier_cleared");

  for(;;) {
    level waittill("radar_status_change");
    _id_FC3B();
  }
}

_id_D639(var_0) {
  self._id_ADAE = var_0;
  _id_FD6D();
  _id_FC3B();

  if(var_0 != "neutral") {
    self._id_BC52 = var_0;
  }
}

_id_6C02() {
  return self._id_ADAE;
}

_id_D8D2(var_0) {
  self._id_FEE7 = int(var_0 * 1000);
}

_id_B0E7() {
  self._id_B0E6 = 1;
}

_id_D8E3(var_0) {
  self._id_10836 = var_0;
}

_id_D8D1(var_0) {
  self._id_FEE2 = var_0;
}

_id_D71A(var_0, var_1) {
  self._id_EFB8[var_0] = int(var_1 * 1000);
}

_id_D719(var_0, var_1) {
  self._id_EFB7[var_0] = var_1;
}

_id_D8D0(var_0) {
  self.trigger sethintstring(var_0);
}

_id_159C(var_0) {
  self._id_83B6 = var_0;
}

_id_15DF(var_0) {
  self._id_83B6 = var_0;
  _id_FD6D();
}

_id_E487(var_0, var_1) {
  if(!isDefined(self._id_83B1)) {
    self._id_83B1 = [];
  }

  if(!isDefined(self._id_83B1[var_0])) {
    self._id_83B1[var_0] = [];
  }

  if(!scripts\engine\utility::array_contains(self._id_83B1[var_0], var_1)) {
    self._id_83B1[var_0][self._id_83B1[var_0].size] = var_1;
  }
}

_id_E48F(var_0, var_1) {
  if(!isDefined(self._id_83B1)) {
    self._id_83B1 = [];
  }

  if(!isDefined(self._id_83B1[var_0])) {
    self._id_83B1[var_0] = [];
  }

  if(scripts\engine\utility::array_contains(self._id_83B1[var_0], var_1)) {
    self._id_83B1[var_0] = ::scripts\engine\utility::array_remove(self._id_83B1[var_0], var_1);
  }
}

_id_D8E0(var_0, var_1) {
  self._id_1041A = var_0;
  _id_FC3B(var_1);
}

_id_D5FD(var_0) {
  if(var_0) {
    for(var_1 = 0; var_1 < self._id_10430.size; var_1++) {
      self._id_10430[var_1] show();

      if(self._id_10430[var_1].classname == "script_brushmodel" || self._id_10430[var_1].classname == "script_model") {
        foreach(var_3 in level.players) {
          if(var_3 istouching(self._id_10430[var_1])) {
            var_3 _id_0A8B::_id_0D8A();
          }
        }

        self._id_10430[var_1] thread _id_9A0E();
      }
    }
  } else {
    for(var_1 = 0; var_1 < self._id_10430.size; var_1++) {
      self._id_10430[var_1] hide();

      if(self._id_10430[var_1].classname == "script_brushmodel" || self._id_10430[var_1].classname == "script_model") {
        self._id_10430[var_1] notify("changing_solidness");
        self._id_10430[var_1] notsolid();
      }
    }
  }
}

_id_9A0E() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");

  for(;;) {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      if(level.players[var_0] istouching(self)) {
        break;
      }
    }

    if(var_0 == level.players.size) {
      self solid();
      break;
    }

    wait 0.05;
  }
}

_id_D4B7(var_0) {
  self._id_32DC = var_0;
}

_id_D4B1(var_0) {
  self._id_FEDD = var_0;
}

_id_6E5A(var_0) {
  var_1 = level._id_10CD8[var_0];

  if(!isDefined(var_1)) {
    return "icon_waypoint_dom_a";
  }

  return var_1;
}

getcodcasterwaypointshader(var_0) {
  if(!isDefined(level.codcasterwaypointshader)) {
    return;
  }
  var_1 = level.codcasterwaypointshader[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  return var_1;
}

_id_6E58(var_0) {
  var_1 = level._id_10CCC[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

_id_6E57(var_0) {
  var_1 = level._id_10CCD[var_0];

  if(!isDefined(var_1)) {
    return "neutral";
  }

  return var_1;
}

_id_6E5B(var_0) {
  var_1 = level._id_10CD9[var_0];

  if(!isDefined(var_1)) {
    return "MP_INGAME_ONLY/MISSING_STRING";
  }

  return var_1;
}

getcodcasterwaypointstring(var_0) {
  if(!isDefined(level.codcasterwaypointstring)) {
    return;
  }
  var_1 = level.codcasterwaypointstring[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  return var_1;
}

_id_6E59(var_0) {
  var_1 = level._id_10CD1[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

getwaypointshowfreecamlabel(var_0) {
  var_1 = level.waypointshowfreecamlabel[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1;
}

_id_D12C(var_0, var_1) {
  self._id_10F52[var_0] = var_1;
}

_id_D4B8(var_0) {
  self._id_32E7 = var_0;
}

_id_4AD1() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isDefined(self._id_32D5)) {
      self._id_32D5 _id_EDCB(self);
    }

    for(var_0 = 0; var_0 < self._id_10430.size; var_0++) {
      self._id_10430[var_0] hide();
    }
  }

  self.trigger scripts\engine\utility::_id_F5E0();
  _id_D8E0("none");
}

_id_5260() {
  if(self.type == "carryObject") {
    for(var_0 = 0; var_0 < self._id_10430.size; var_0++) {
      self._id_10430[var_0] show();
    }
  }

  self.trigger scripts\engine\utility::_id_F5E2();
  _id_D8E0("any");
}

_id_6CEA(var_0) {
  if(var_0 == self._id_ADAE) {
    return "friendly";
  } else {
    return "enemy";
  }
}

_id_886F(var_0) {
  if(self._id_ADAE == "any") {
    return 1;
  }

  if(self._id_ADAE == var_0) {
    return 1;
  }

  if(self._id_ADAE == "neutral" && isDefined(self._id_BC52) && self._id_BC52 == var_0) {
    return 1;
  }

  return 0;
}

_id_318C(var_0, var_1) {
  if(isDefined(var_1) && isDefined(self._id_83B1)) {
    return isDefined(self._id_83B1[var_1.team]) && scripts\engine\utility::array_contains(self._id_83B1[var_1.team], var_1._id_E496);
  } else {
    switch (self._id_83B6) {
      case "none":
        return 0;
      case "any":
        return 1;
      case "friendly":
        if(var_0 == self._id_ADAE) {
          return 1;
        } else {
          return 0;
        }
      case "enemy":
        if(var_0 != self._id_ADAE) {
          return 1;
        } else {
          return 0;
        }
      default:
        return 0;
    }
  }
}

_id_8A91(var_0) {
  if(var_0 == "neutral") {
    return 1;
  }

  if(var_0 == "any") {
    return 1;
  }

  if(var_0 == "none") {
    return 1;
  }

  foreach(var_2 in level._id_EF89) {
    if(var_0 == var_2) {
      return 1;
    }
  }

  return 0;
}

_id_89F6(var_0) {
  if(var_0 == "friendly") {
    return 1;
  }

  if(var_0 == "enemy") {
    return 1;
  }

  if(var_0 == "any") {
    return 1;
  }

  if(var_0 == "none") {
    return 1;
  }

  return 0;
}

_id_6AF1() {
  if(!isDefined(self.trigger._id_CD99)) {
    return "";
  } else {
    return self.trigger._id_CD99;
  }
}

_id_81EA() {
  self._id_A3F8 = undefined;
  self._id_2EE4 = 0;
  self._id_AA5C = undefined;
}

_id_A362(var_0) {
  self._id_A362 = var_0;
}

_id_316A(var_0) {
  self._id_316A = var_0;
}

_id_6B06() {
  level._id_9EF8 = getEntArray("minefield", "targetname");
  level._id_7BE5 = getEntArray("trigger_hurt", "classname");
  level._id_BF45 = getEntArray("radiation", "targetname");
  level._id_2192 = getEntArray("uplinkAllowedOOB", "targetname");
  level._id_A6CD = getEntArray("uplink_nozone", "targetname");
  level._id_506F = getEntArray("dropToNavMesh", "targetname");
  thread _id_07AD::_id_8138();
}

_id_8785() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "to_dd":
    case "cmd":
    case "btm":
    case "dd":
    case "cyber":
    case "sr":
    case "sd":
      return 1;
    default:
      return 0;
  }
}

_id_F391(var_0) {
  if(level._id_506F.size > 0) {
    if(_id_8785() || scripts\mp\utility\game::getgametype() == "ctf") {
      self._id_10430[0].origin = var_0;
    }

    foreach(var_2 in level._id_506F) {
      foreach(var_4 in self._id_10430) {
        if(var_4 istouching(var_2)) {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_F38E() {
  if(level._id_1A2F.size > 0) {
    foreach(var_1 in level._id_1A2F) {
      if(self istouching(var_1)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_C60A() {
  if(isDefined(self._id_EF94)) {
    foreach(var_2, var_1 in self._id_EF94) {
      self._id_EF94[var_2] = 0;
    }
  }
}

_id_694C() {
  if(isDefined(self._id_EF94) && isDefined(self._id_37F6)) {
    if(self._id_37F6 != "none") {
      return self._id_EF94[self._id_37F6] / self._id_FEE7;
    } else {
      return self._id_EF94[self._id_8FAD] / self._id_FEE7;
    }
  }

  return 0.0;
}

_id_C579(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    self._id_A908 = _id_07F9::_id_C581(var_2);
  } else {
    self._id_A908 = _id_07F9::_id_C57D(99);
  }

  if(self._id_A908 != -1) {
    var_5 = "done";

    if(var_0 && var_1) {
      var_5 = "current";
    } else if(var_0) {
      var_5 = "active";
    } else if(var_1) {
      var_5 = "invisible";
    }

    _id_07F9::_id_A867(self._id_A908, var_5, self._id_4140 + self._id_A97E);

    if(getdvarint("#x39eda14255120302a", 0) == 1) {
      if(isDefined(var_3) && var_3 == 0) {
        _func_0178(self._id_A908, 0);
        self._id_DCD1 = 0;
      } else
        _func_0178(self._id_A908, 1);
    }

    if(isDefined(var_4)) {
      _id_07F9::_id_A8B1(self._id_A908, var_4);
      _id_07F9::_id_A8B2(self._id_A908, var_4);
    }

    self._id_DCFF = 0;
    _id_07F9::_id_A8A2(self._id_A908);

    if(var_1) {
      self._id_DCFF = 1;
    }
  }
}

_id_C300(var_0, var_1) {
  if(istrue(var_0)) {
    _id_07F9::_id_C79D(self._id_A908, var_1);
  } else {
    _id_07F9::_id_C799(self._id_A908);
  }

  self._id_A908 = -1;
}

_id_694A() {
  if(!isDefined(self._id_3225)) {
    _id_D4B2("normal");
  }

  return self._id_3225;
}

_id_D4B2(var_0) {
  self._id_3225 = var_0;
}

_id_19C9(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::_id_6A01(var_0);

  switch (_id_694A()) {
    case "persistent":
      self._id_EF94[var_0] = self._id_EF94[var_0] + var_1;
      self._id_4143 = self._id_EF94[var_0];
      break;
    case "contest_only":
      if(!isDefined(self._id_ADAE) || self._id_ADAE == var_0) {
        return;
      }
      break;
    case "neutralize":
      foreach(var_4 in var_2) {
        var_5 = self._id_EF94[var_4];

        if(var_5 > 0) {
          if(var_5 < var_1) {
            self._id_EF94[var_4] = 0;
            var_1 = var_1 - var_5;
            continue;
          }

          self._id_EF94[var_4] = self._id_EF94[var_4] - var_1;
          var_1 = 0;
          self._id_4143 = self._id_EF94[var_4];
          _id_07F9::_id_A8C4(self._id_A908, 1);
          _id_07F9::_id_A8B4(self._id_A908, self._id_4143 / self._id_FEE7);
        }
      }

      if(var_1 > 0) {
        self._id_EF94[var_0] = self._id_EF94[var_0] + var_1;
        self._id_4143 = self._id_EF94[var_0];
      }

      break;
    case "only_associated_teams":
      if(!isDefined(self._id_1D33) || !scripts\engine\utility::array_contains(self._id_1D33, var_0)) {
        return;
      }
      foreach(var_4 in var_2) {
        var_5 = self._id_EF94[var_4];

        if(var_5 > 0) {
          if(var_5 < var_1) {
            self._id_EF94[var_4] = 0;
            var_1 = var_1 - var_5;
            continue;
          }

          self._id_EF94[var_4] = self._id_EF94[var_4] - var_1;
          var_1 = 0;
          self._id_4143 = self._id_EF94[var_4];
          _id_07F9::_id_A8C4(self._id_A908, 1);
          _id_07F9::_id_A8B4(self._id_A908, self._id_4143 / self._id_FEE7);
        }
      }

      if(var_1 > 0) {
        self._id_EF94[var_0] = self._id_EF94[var_0] + var_1;
        self._id_4143 = self._id_EF94[var_0];
      }

      break;
    case "one_way_contest_only":
      if(var_0 != self.team) {
        return;
      }
      if(var_0 == self.team) {
        foreach(var_10 in var_2) {
          if(self._id_A79A[var_10] > 0) {
            return;
          }
        }
      }

      self._id_EF94[var_0] = self._id_EF94[var_0] + var_1;
      self._id_4143 = self._id_EF94[var_0];
      break;
    default:
      var_12 = self._id_EF94[var_0];
      var_12 = var_12 + var_1;
      var_13 = 0;
      var_14 = _id_6BBA(var_0);
      var_15 = _id_6BB9(var_0);

      if(var_14 && var_15 && var_14 != var_15) {
        var_13 = 1;
      }

      if(istrue(self._id_9987) && var_12 >= self._id_FEE7 * 0.95 && istrue(var_13)) {
        if(self._id_ADAE == "neutral") {
          foreach(var_0 in level._id_EF89) {
            if(self._id_F396[var_0].size) {
              var_17 = self._id_F396[var_0];
              var_18 = getarraykeys(var_17);

              for(var_19 = 0; var_19 < var_18.size; var_19++) {
                var_20 = var_17[var_18[var_19]].player;
                var_20 setclientomnvar("ui_objective_state", 4);
              }

              break;
            }
          }

          _id_07F9::_id_FB9B(self._id_A908, 1);
          _id_07F9::_id_FB9C(self._id_A908, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
        } else {
          foreach(var_0 in level._id_EF89) {
            if(var_0 == self._id_ADAE) {
              if(self._id_F396[var_0].size) {
                var_17 = self._id_F396[var_0];
                var_18 = getarraykeys(var_17);

                for(var_19 = 0; var_19 < var_18.size; var_19++) {
                  var_20 = var_17[var_18[var_19]].player;
                  var_20 setclientomnvar("ui_objective_state", 4);
                }

                break;
              }
            }
          }

          _id_07F9::_id_FB9B(self._id_A908, 1);
          _id_07F9::_id_FB9A(self._id_A908, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
          _id_07F9::_id_FB99(self._id_A908, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
        }
      } else {
        if(self._id_ADAE != "neutral") {
          if(self._id_ADAE != var_0) {
            _id_07F9::_id_FB9A(self._id_A908, "MP_INGAME_ONLY/OBJ_LOSING_CAPS");
          }
        }

        self._id_EF94[var_0] = self._id_EF94[var_0] + var_1;
        self._id_4143 = self._id_EF94[var_0];
      }

      break;
  }
}

_id_3FF0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawn("script_model", var_0);
  var_11 makeuseable();

  if(isDefined(var_1)) {
    var_11 setcursorhint(var_1);
  } else {
    var_11 setcursorhint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    var_11 _meth_84DA(var_2);
  }

  if(isDefined(var_3)) {
    var_11 sethintstring(var_3);
  }

  if(isDefined(var_4)) {
    var_11 _meth_83A1(var_4);
  } else {
    var_11 _meth_83A1(0);
  }

  if(isDefined(var_5)) {
    var_11 setuseholdduration(var_5);
  } else {
    var_11 setuseholdduration("duration_short");
  }

  if(isDefined(var_6)) {
    var_11 _meth_84D9(var_6);
  } else {
    var_11 _meth_84D9("hide");
  }

  if(isDefined(var_7)) {
    var_11 _meth_84D4(var_7);
  } else {
    var_11 _meth_84D4(200);
  }

  if(isDefined(var_8)) {
    var_11 sethintdisplayfov(var_8);
  } else {
    var_11 sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    var_11 setuserange(var_9);
  } else {
    var_11 setuserange(50);
  }

  if(isDefined(var_10)) {
    var_11 setusefov(var_10);
  } else {
    var_11 setusefov(120);
  }

  return var_11;
}

_id_D5A6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_3 = undefined;
  }

  self makeuseable();

  if(isDefined(var_0)) {
    self _meth_84D7(var_0);
  }

  if(isDefined(var_1)) {
    self setcursorhint(var_1);
  } else {
    self setcursorhint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    self _meth_84DA(var_2);
  }

  if(isDefined(var_3)) {
    self sethintstring(var_3);
  }

  if(isDefined(var_4)) {
    self _meth_83A1(var_4);
  } else {
    self _meth_83A1(0);
  }

  if(isDefined(var_5)) {
    self setuseholdduration(var_5);
  } else {
    self setuseholdduration("duration_short");
  }

  if(isDefined(var_6)) {
    self _meth_84D9(var_6);
  } else {
    self _meth_84D9("hide");
  }

  if(isDefined(var_7)) {
    self _meth_84D4(var_7);
  } else {
    self _meth_84D4(200);
  }

  if(isDefined(var_8)) {
    self sethintdisplayfov(var_8);
  } else {
    self sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    self setuserange(var_9);
  } else {
    self setuserange(50);
  }

  if(isDefined(var_10)) {
    self setusefov(var_10);
  } else {
    self setusefov(120);
  }
}

_id_4026(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.type = "useObject";
  var_6._id_4140 = var_0;
  var_6._id_ADAE = var_1;

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_6._id_A97E = var_2;
  var_6 _id_C579(1, 1, var_3, var_5);
  var_6._id_3B0A = [];
  var_6._id_83B6 = "none";

  if(isDefined(var_4)) {
    var_6._id_1041A = var_4;
  } else {
    var_6._id_1041A = "none";
  }

  return var_6;
}

_id_8A06() {
  if(isDefined(self._id_7C8C) && self._id_7C8C == "laststand_reviver") {
    return 1;
  }

  return 0;
}