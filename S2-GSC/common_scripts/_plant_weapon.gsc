/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_plant_weapon.gsc
********************************************/

_id_5369(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_941B(var_1, var_2, var_3, var_4);
  var_7 = getdvarint("weapon_plant_enabled", 1);

  if(!var_7) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self.carryweapon)) {
    var_8 = var_0 == self.carryweapon;

    if(var_8)
      return;
    else if(_id_43DD() == "SCRIPTED_SWAP") {
      self waittill("weapon_plant_dismount");
      _id_2399(1);
    }
  }

  self._id_7076 = undefined;
  self._id_76E7 = undefined;
  self._id_76EC = undefined;
  self.carryweapon = var_0;
  self._id_7073 = undefined;
  self._id_A6B4 = 0;
  self._id_A1FC = 0;
  self._id_706A = _id_4295(var_0);

  if(isDefined(var_5) && var_5) {
    self._id_7077 = "STATE_CARRY_TO_PLANT";
    self._id_7073 = var_6;
    self._id_7075 = var_6;
  } else {
    self._id_7077 = "STATE_FIRST_CARRY";

    if(_id_43DD() == "SCRIPTED_ALTSWITCH" || _id_43DD() == "NATIVE_DPAD_LEFT")
      self _meth_8328();
  }

  if(_id_43DD() != "NATIVE_DPAD_LEFT") {
    if(isPlayer(self))
      _id_680D();
  }

  thread _id_9963();
  thread _id_62DA();
  thread _id_A123();
  thread _id_6370();

  if(_id_43DD() == "SCRIPTED_SWAP" || _id_43DD() == "SCRIPTED_ALTSWITCH")
    thread _id_63F7();
}

_id_680D() {
  self notifyonplayercommand("plant_button_down", "+actionslot 3");
  self notifyonplayercommand("plant_button_up", "-actionslot 3");
  self notifyonplayercommand("use_button_down", "+usereload");
  self notifyonplayercommand("use_button_up", "-usereload");
}

_id_680C() {
  self notifyonplayercommandremove("plant_button_down", "+actionslot 3");
  self notifyonplayercommandremove("plant_button_up", "-actionslot 3");
  self notifyonplayercommandremove("use_button_down", "+usereload");
  self notifyonplayercommandremove("use_button_up", "-usereload");
}

getgroundentity(var_0) {
  self._id_7075 = var_0;
}

_id_239A() {
  self notify("cleanupWeaponPlantImmediate");
  return _id_2399(0);
}

_id_2399(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self notify("weapon_plant_cleanup");

  if(self _meth_803D())
    _id_2FED(var_0);
  else if(!var_0)
    _id_2F97();

  self._id_706A = undefined;

  if(_id_43DD() == "SCRIPTED_ALTSWITCH" || _id_43DD() == "NATIVE_DPAD_LEFT")
    self _meth_8329();

  self._id_7076 = undefined;
  self._id_76E7 = undefined;
  self._id_76EC = undefined;
  self.carryweapon = undefined;
  self._id_7077 = undefined;
  self._id_7073 = undefined;
  self._id_7075 = undefined;
  self._id_A6B4 = undefined;
  self._id_A1FC = undefined;
  _id_2373();

  if(isPlayer(self))
    _id_680C();

  self setclientomnvar("ui_lmg_mount_state", 0);
  self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);
}

_id_9EA3() {
  var_0 = undefined;

  if(isDefined(self._id_76EC))
    var_0 = _lengthsquared(self.angles - self._id_76EC);

  self._id_76EC = self.angles;
  var_1 = getdvarfloat("weapon_plant_max_turn_angle_vect_distance_sq", 70.0);

  if(isDefined(var_0) && var_0 > var_1)
    return 1;

  return 0;
}

_id_1F65() {
  if(isDefined(self._id_2FAF) && self._id_2FAF)
    return 0;

  if(isDefined(self._id_2016) && isDefined(self._id_2016.carryweapon) && (self._id_2016.carryweapon == "iw5_carrydrone_mp" || self._id_2016.carryweapon == "relic_mp"))
    return 0;

  if(isDefined(self._id_5525) && self._id_5525)
    return 0;

  if(!self._id_A1FC && self isonground() && !self _meth_82E5() && !self ismantling() && !self isusingoffhand() && !self isswitchingweapon() && !self isusingturret() && !self _meth_817A() && !_id_9EA3() && !isDefined(self getmovingplatformparent()))
    return 1;

  return 0;
}

_id_5855() {
  if(self _meth_803D())
    return 1;

  if(!isDefined(self._id_7077))
    return 0;

  switch (self._id_7077) {
    case "STATE_PLANTED_TO_CARRY":
    case "STATE_PLANTED":
    case "STATE_PLANTED_NO_CARRY":
    case "STATE_CARRY_TO_PLANT":
      return 1;
    default:
      return 0;
  }
}

_id_584E() {
  if(!isDefined(self._id_7077))
    return 0;

  if(self._id_7077 == "STATE_PLANTED_TO_CARRY")
    return 1;
  else
    return 0;
}

_id_2F97() {
  self allowstand(1);
  self allowcrouch(1);
  self allowprone(1);
  self allowlean(1);
  self allowmantle(1);
  self allowjump(1);
  self allowmelee(1);
  _id_6518(1);

  if(_id_8B6B())
    common_scripts\utility::_id_0617();

  self enableoffhandweapons();
  self enableusability();
}

_id_707A() {
  var_0 = _id_43D9();
  var_1 = getdvarfloat("weapon_plant_limits_forward_offset", 0.0);
  var_2 = getdvarfloat("weapon_plant_limits_upward_offset", 5.0);
  var_3 = self.angles;

  if(isDefined(self._id_7075)) {
    self._id_7073 = self._id_7075;
    self._id_7076 = "stand";
  }

  var_4 = self _meth_86B0();
  var_5 = max(10, var_4[0] - 15);
  var_4 = (-1 * var_5, var_4[1], var_4[2]);
  var_4 = _rotatevector(var_4, var_3);
  var_6 = self._id_7073 + var_4;
  self._id_76E7 = self getstance();

  if(isDefined(self._id_7076)) {
    var_7 = self._id_7076;
    var_8 = self setstance(var_7);

    if(isDefined(self._id_7075) && !var_8)
      var_8 = self setstance(var_7, 0);
  } else
    var_7 = self._id_76E7;

  if(isDefined(self._id_7075))
    self._id_7075 = undefined;

  var_9 = undefined;

  if(var_7 == "prone")
    var_9 = vectortoangles(self._id_7073 - self.origin);
  else
    var_9 = self.angles;

  [var_11, var_12, var_13, var_14] = _id_4355(var_7);
  var_15 = var_11;
  var_16 = var_12;
  var_17 = var_13;
  var_18 = var_14;

  if(_id_8B53())
    [var_15, var_16, var_17, var_18] = _id_028B::_id_43D8(self.origin[2], self._id_7073, var_6, var_9, var_2, var_1, var_0, var_11, var_12, var_13, var_14, _id_4074());

  _id_941B(var_15, var_16, var_17, var_18);

  if(var_7 != "stand")
    self allowstand(0);

  if(var_7 != "crouch")
    self allowcrouch(0);

  if(var_7 != "prone")
    self allowprone(0);

  self allowjump(0);
  self allowmantle(0);
  self allowmelee(0);
  _id_6518(0);

  if(_id_8B6B())
    common_scripts\utility::_id_0603();

  self disableoffhandweapons();
  self disableusability();
  self _meth_803B(self._id_7073, var_15, var_16, var_17, var_18);
  _id_707B(var_7, self._id_7073, self.angles);

  if(_id_43DD() == "SCRIPTED_SWAP") {
    var_20 = self getweaponammoclip(self.carryweapon);
    var_21 = self getweaponammostock(self.carryweapon);
    var_22 = get_weapon_paintjobid();
    var_23 = get_weapon_charmguid();
    self giveweapon(self._id_706A, undefined, 1, self, var_22, var_23);
    self setweaponammoclip(self._id_706A, var_20);
    self setweaponammostock(self._id_706A, var_21);
    self switchtoweapon(self._id_706A);
    self waittill("weapon_change");
  } else if(_id_43DD() == "SCRIPTED_ALTSWITCH") {
    self _meth_8329();
    self switchtoweapon(self._id_706A);
    wait 1;
    self _meth_8328();
  } else if(_id_43DD() == "NATIVE_DPAD_LEFT") {
    thread _id_14F3(0.75);

    while(self getcurrentweapon() != self._id_706A)
      waitframe();

    self _meth_8328();

    while(self _meth_8678() || self _meth_8677())
      waitframe();

    if(self getcurrentweapon() != self._id_706A) {}
  }

  self notify("WEAPON_PLANT_MOUNTED", var_7, self._id_7073, self.angles, self._id_706D);
}

_id_14F3(var_0) {
  self endon("weapon_change");
  wait(var_0);

  if(self getcurrentweapon() != self._id_706A)
    self switchtoweapon(self._id_706A);
}

forcedismountweapon() {
  self notify("weapon_plant_cleanup");
}

_id_2FED(var_0) {
  self allowstand(1);
  self allowcrouch(1);
  self allowprone(1);

  if(isDefined(self._id_76E7)) {
    self setstance(self._id_76E7);
    self._id_76E7 = undefined;
  }

  self._id_7076 = undefined;
  self _meth_803C(1);
  _id_2FEE();

  if(_id_43DD() == "SCRIPTED_SWAP") {
    if(self hasweapon(self._id_706A)) {
      var_1 = self getweaponammoclip(self._id_706A);
      var_2 = self getweaponammostock(self._id_706A);

      if(self getcurrentweapon() == self._id_706A)
        self switchtoweapon(self.carryweapon);

      self setweaponammoclip(self.carryweapon, var_1);
      self setweaponammostock(self.carryweapon, var_2);
      common_scripts\utility::_id_A71A(1.0, "weapon_change");

      if(self getcurrentweapon() == self._id_706A)
        self switchtoweapon(self.carryweapon);

      self takeweapon(self._id_706A);
    }
  } else if(_id_43DD() == "SCRIPTED_ALTSWITCH") {
    self _meth_8329();

    if(var_0) {
      self switchtoweapon(self.carryweapon);
      wait 1;
    } else
      self switchtoweaponimmediate(self.carryweapon);

    self _meth_8328();
  } else if(_id_43DD() == "NATIVE_DPAD_LEFT") {
    if(var_0) {
      while(self getcurrentweapon() == self._id_706A)
        waitframe();

      self _meth_8328();

      while(self _meth_8678() || self _meth_8677())
        waitframe();

      if(self getcurrentweapon() == self._id_706A) {}
    } else
      self switchtoweaponimmediate(self.carryweapon);
  }

  _id_2F97();
  self notify("weapon_plant_dismount");
}

_id_63F7() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");

  for(;;) {
    self waittill("use_button_down");
    self._id_A1FC = 1;
    self waittill("use_button_up");
    self._id_A1FC = 0;
    waitframe();
  }
}

_id_63BE() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");
  self._id_A6B4 = 1;
  self waittill("plant_button_up");
  self._id_A6B4 = 0;
}

_id_21B6() {
  if(self._id_A6B4)
    self waittill("plant_button_up");
}

_id_A6A5(var_0) {
  level endon("game_ended");
  _id_98DF();

  if(isDefined(var_0)) {
    childthread _id_21D0(var_0);
    var_1 = common_scripts\utility::waittill_any_return("plant_button_down", "plantOnEntityRemoved", "native_dpad_force_plant");

    if(isDefined(var_1) && var_1 == "plantOnEntityRemoved")
      return 1;
  } else
    var_1 = common_scripts\utility::waittill_any_return("plant_button_down", "native_dpad_force_plant");

  if(_id_43DD() != "NATIVE_DPAD_LEFT") {
    _id_98E0();
    thread _id_63BE();
    var_2 = getdvarfloat("weapon_plant_input_hold_duration", 0.2);

    if(var_2 > 0)
      common_scripts\utility::_id_A63E(var_2, "plant_button_up");
  }

  return 1;
}

_id_A774() {
  for(;;) {
    if(self getcurrentweapon() == self._id_706A && !self _meth_8677())
      return 1;
    else
      waitframe();
  }
}

_id_A772(var_0) {
  _id_98DF();

  if(isDefined(var_0))
    childthread _id_21D0(var_0);

  for(;;) {
    if(self getcurrentweapon() == self.carryweapon || self getcurrentweapon() == self._id_706A && self _meth_8677()) {
      _id_98E0();
      return 1;
    } else
      waitframe();
  }
}

_id_A771() {
  for(;;) {
    if(self getcurrentweapon() == self._id_706A && self _meth_8678() || self getcurrentweapon() == self.carryweapon && self _meth_8677()) {
      waitframe();
      continue;
    }

    return 1;
  }
}

_id_37BF(var_0) {
  self._id_7077 = var_0;
}

_id_38F6() {
  switch (self._id_7077) {
    case "STATE_CARRY":
    case "STATE_FIRST_CARRY":
      _id_37BF("STATE_CARRY_TO_PLANT");
      break;
    case "STATE_CARRY_TO_PLANT":
      _id_37BF("STATE_PLANTED_NO_CARRY");
      break;
    case "STATE_PLANTED_NO_CARRY":
      _id_37BF("STATE_PLANTED");
      break;
    case "STATE_PLANTED":
      _id_37BF("STATE_PLANTED_TO_CARRY");
      break;
    case "STATE_PLANTED_TO_CARRY":
      _id_37BF("STATE_CARRY_NO_PLANT");
      break;
    case "STATE_CARRY_NO_PLANT":
      _id_37BF("STATE_CARRY");
      break;
  }
}

_id_9963() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");
  var_0 = -1;
  var_1 = 0;

  for(;;) {
    var_2 = gettime();

    if(!isDefined(self._id_7077)) {
      return;
    }
    switch (self._id_7077) {
      case "STATE_CARRY":
      case "STATE_FIRST_CARRY":
        if(isDefined(_id_A6A5())) {
          if(isDefined(self._id_7073))
            _id_38F6();
          else if(self getstance() == "prone" && _id_1F65())
            _id_3A66();
        }

        break;
      case "STATE_CARRY_TO_PLANT":
        _id_707A();
        self allowlean(1);
        _id_38F6();
        break;
      case "STATE_PLANTED_NO_CARRY":
        if(_id_43DD() == "NATIVE_DPAD_LEFT")
          _id_A774();
        else
          _id_21B6();

        _id_38F6();
        break;
      case "STATE_PLANTED":
        var_3 = undefined;

        if(_id_43DD() == "NATIVE_DPAD_LEFT")
          var_3 = _id_A772(self._id_706D);
        else
          var_3 = _id_A6A5(self._id_706D);

        if(isDefined(var_3))
          _id_38F6();

        break;
      case "STATE_PLANTED_TO_CARRY":
        _id_2FED(1);
        _id_38F6();
        break;
      case "STATE_CARRY_NO_PLANT":
        if(_id_43DD() == "NATIVE_DPAD_LEFT")
          _id_A771();
        else
          _id_21B6();

        _id_38F6();
        break;
      default:
        continue;
    }

    if(var_0 == var_2) {
      var_1++;

      if(var_1 > 5)
        waitframe();

      continue;
    }

    var_1 = 0;
    var_0 = var_2;
  }
}

_id_A123() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");

  for(;;) {
    if(!isDefined(self._id_7077)) {
      return;
    }
    switch (self._id_7077) {
      case "STATE_CARRY":
      case "STATE_FIRST_CARRY":
        if(self isusingturret()) {
          waitframe();
          continue;
        }

        if(isDefined(self._id_7073)) {
          self setclientomnvar("ui_lmg_mount_state", 0);
          self setclientomnvar("ui_show_division_lmg_ability_prompt", 1);
        } else
          self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);

        break;
      case "STATE_PLANTED":
        self setclientomnvar("ui_lmg_mount_state", 1);

        if(!isDefined(self._id_706E) || !self._id_706E)
          self setclientomnvar("ui_show_division_lmg_ability_prompt", 1);
        else
          self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);

        if(_id_43DD() == "SCRIPTED_SWAP") {
          if(isDefined(self._id_706A) && self getcurrentweapon() == self._id_706A) {
            var_0 = self getweaponammoclip(self._id_706A);
            var_1 = self getweaponammostock(self._id_706A);

            if(var_1 == 0 && var_0 < 2) {
              self setweaponammoclip(self.carryweapon, var_0);
              self setweaponammostock(self.carryweapon, var_1);
            }
          }
        }

        break;
      case "STATE_CARRY_NO_PLANT":
      case "STATE_PLANTED_TO_CARRY":
      case "STATE_PLANTED_NO_CARRY":
      case "STATE_CARRY_TO_PLANT":
        self setclientomnvar("ui_show_division_lmg_ability_prompt", 0);
        break;
    }

    waitframe();
  }
}

_id_62DA() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("weapon_plant_cleanup");
  var_0 = undefined;
  var_1 = 0;

  for(;;) {
    var_2 = getdvarint("weapon_plant_enabled", 1);

    if(!(var_2 && isDefined(self._id_7077))) {
      self notify("weapon_plant_cleanup");
      return;
    }

    switch (self._id_7077) {
      case "STATE_CARRY":
      case "STATE_FIRST_CARRY":
        self._id_7073 = undefined;
        self._id_7070 = undefined;
        self._id_706D = undefined;

        if(!_id_1F65()) {
          break;
        }

        var_3 = getdvarint("weapon_plant_prone_plant", 1);
        var_4 = var_3 && self getstance() == "prone";
        var_5 = getdvarint("turret_clip_plant", 1);
        var_6 = getdvarint("turret_mantle_plant", 0);
        var_7 = undefined;
        var_8 = undefined;
        var_7 = getdvarfloat("4485");

        if(var_4)
          var_8 = var_7;

        var_9 = undefined;

        if(isDefined(self._id_7075))
          self._id_7073 = self._id_7075;
        else {
          [var_11, var_12, var_9] = _id_028B::_id_9F90(var_5, var_6, var_4, var_7, var_8);

          if(var_4 && isDefined(var_11)) {
            self._id_7073 = var_11;
            self._id_7076 = "prone";

            if(!self _meth_803A(self._id_7073))
              self._id_7073 = undefined;
          } else if(isDefined(var_11) && _id_028B::_id_4B43(var_11, var_7, _id_4074())) {
            self._id_7073 = var_11;
            self._id_7076 = undefined;
            var_13 = getdvarfloat("3235", 48.0);
            var_14 = getdvarfloat("1492", 34.0);
            var_15 = var_11[2] - self.origin[2];

            if(var_15 >= var_13) {
              var_16 = _id_43DE();
              var_17 = var_13 + var_16;

              if(var_15 <= var_17 + 0.001)
                self._id_7076 = "stand";
              else {
                self._id_7073 = undefined;
                break;
              }
            } else if(var_15 > var_14)
              self._id_7076 = "stand";

            if(!isDefined(self._id_7076)) {
              if(var_15 <= var_14) {
                var_18 = _id_43DA();
                var_19 = var_14 - var_18;

                if(var_15 >= var_19 - 0.001)
                  self._id_7076 = "crouch";
                else {
                  self._id_7073 = undefined;
                  break;
                }
              }
            }
          }
        }

        if(isDefined(self._id_7075))
          var_0 = self._id_7075;
        else if(isDefined(self._id_7073)) {
          if(isDefined(self._id_706F) && self._id_706F) {
            self._id_7070 = self._id_7073;
            self._id_7073 = undefined;
          } else {
            self._id_706D = var_9;
            var_0 = self._id_7073;
          }
        }

        break;
      case "STATE_CARRY_TO_PLANT":
        break;
      case "STATE_PLANTED":
      case "STATE_PLANTED_NO_CARRY":
        self._id_7073 = undefined;
        break;
      case "STATE_CARRY_NO_PLANT":
        self._id_7073 = undefined;
        break;
    }

    if(_id_43DD() == "NATIVE_DPAD_LEFT") {
      var_20 = undefined;

      if(isDefined(self._id_706E) && self._id_706E)
        var_20 = 0;
      else {
        switch (self._id_7077) {
          case "STATE_CARRY":
          case "STATE_FIRST_CARRY":
            var_20 = isDefined(self._id_7073) || isDefined(self._id_7075);
            break;
          case "STATE_CARRY_TO_PLANT":
            var_20 = -1;
            break;
          case "STATE_PLANTED_NO_CARRY":
            var_20 = -1;
            break;
          case "STATE_PLANTED":
            var_20 = 1;
            break;
          case "STATE_PLANTED_TO_CARRY":
            var_20 = -1;
            break;
          case "STATE_CARRY_NO_PLANT":
            var_20 = -1;
            break;
        }
      }

      if(var_20 == 1) {
        if(!self _meth_85EC()) {
          self _meth_8329();
          _id_680D();
        }
      } else if(var_20 == 0) {
        if(self _meth_85EC()) {
          self._id_A1FC = 0;
          self._id_A6B4 = 0;
          self _meth_8328();
          _id_680C();
        }
      }

      if(self._id_7077 == "STATE_CARRY" && !self _meth_85EC() && self _meth_86B1("to_alt")) {
        self._id_7073 = var_0;
        self notify("native_dpad_force_plant");
      }
    }

    waitframe();
  }
}

_id_6370() {
  self endon("disconnect");
  self endon("cleanupWeaponPlantImmediate");
  self notify("monitor_planted_weapon_cleanup");
  self endon("monitor_planted_weapon_cleanup");
  var_0 = common_scripts\utility::_id_A716("weapon_plant_cleanup", "weapon_change", "death", "joined_team", "joined_spectators", "weaponPlantFiringRange");

  if(var_0 == "weapon_change") {
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = self getcurrentweapon();

    if(_id_43DD() == "SCRIPTED_SWAP") {
      var_1 = 0;
      var_2 = isDefined(self._id_706A) && var_4 == self._id_706A;
      var_3 = isDefined(self._id_706A) && var_4 == self.carryweapon;

      if(var_3) {
        if(isDefined(self._id_706A) && self hasweapon(self._id_706A)) {
          var_5 = self getweaponammoclip(self._id_706A);
          var_6 = self getweaponammostock(self._id_706A);
          var_7 = var_5 == 0 && var_6 == 0;

          if(var_7) {
            var_8 = getdvarfloat("weapon_plant_input_hold_duration", 0.2);
            self notify("plant_button_down");
            wait(var_8);
            self notify("plant_button_up");
          }
        }
      }
    } else
      var_1 = var_4 == self.carryweapon || var_4 == self._id_706A;

    if(var_4 != "none" && (var_1 || var_2 || var_3)) {
      thread _id_6370();
      return;
    }
  }

  if(common_scripts\utility::_id_562E(self.tmpplayerfreeze))
    _id_98DF();

  _id_2399(1);
}

_id_98DF() {
  if(_id_43DD() != "NATIVE_DPAD_LEFT")
    self allowlean(1);

  self allowjump(1);
  self allowmantle(1);
  self.tmpplayerfreeze = undefined;
}

_id_98E0() {
  self.tmpplayerfreeze = 1;

  if(_id_43DD() != "NATIVE_DPAD_LEFT")
    self allowlean(0);

  self allowjump(0);
  self allowmantle(0);
}

_id_21D0(var_0) {
  self endon("disconnect");
  self endon("cleanupWeaponPlantImmediate");
  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  var_5 = var_0 _id_8C6C();
  var_6 = var_0.model;
  var_7 = "";

  if(var_0.classname == "scriptable")
    var_7 = var_0 _meth_866B(0);

  if(_id_5778(var_0)) {
    var_2 = var_0.origin;
    var_3 = var_0.angles;

    if(var_0 _meth_8221() && var_0 gettagangles("TAG_YAW") != -1)
      var_4 = var_0 gettagangles("TAG_YAW");
  }

  for(;;) {
    if(!isDefined(var_0))
      var_1 = 1;
    else if(isDefined(var_5) && !var_5 && (var_0.classname == "script_brushmodel" || var_0.classname == "script_model") && var_0 _id_8C6C())
      var_1 = 1;
    else if((var_0.classname == "script_brushmodel" || var_0.classname == "script_model") && !var_0 _meth_86A9())
      var_1 = 1;
    else if(var_0.classname == "scriptable" && var_0 _meth_866B(0) != var_7)
      var_1 = 1;
    else if(isDefined(var_0.model) && var_0.model != "" && (var_0 _meth_8687() && var_0 _meth_8672() > 0.0))
      var_1 = 1;
    else if(isDefined(var_2) && _distance2dsquared(var_2, var_0.origin) > 1.0)
      var_1 = 1;
    else if(isDefined(var_3) && distancesquared(var_3, var_0.angles) > 1.0)
      var_1 = 1;
    else if(isDefined(var_4) && _distance2dsquared(var_4, var_0 gettagangles("TAG_YAW")) > 1.0)
      var_1 = 1;

    if(var_1) {
      self notify("plantOnEntityRemoved");

      if(_id_43DD() == "NATIVE_DPAD_LEFT")
        self switchtoweapon(self.carryweapon);

      return;
    }

    waitframe();
  }
}

_id_6518(var_0) {
  if(isDefined(level._id_A9B1._id_6518))
    return self[[level._id_A9B1._id_6518]](var_0);
}

_id_4295(var_0) {
  return self[[level._id_A9B1._id_4295]](var_0);
}

_id_707B(var_0, var_1, var_2) {
  return self[[level._id_A9B1._id_707B]](var_0, var_1, var_2);
}

_id_2FEE() {
  return self[[level._id_A9B1._id_2FEE]]();
}

_id_3A66() {
  return self[[level._id_A9B1._id_3A66]]();
}

_id_8B6B() {
  return self[[level._id_A9B1._id_8B6B]]();
}

_id_43DE() {
  return self[[level._id_A9B1._id_43DE]]();
}

_id_43DA() {
  return self[[level._id_A9B1._id_43DA]]();
}

_id_941B(var_0, var_1, var_2, var_3) {
  return self[[level._id_A9B1._id_941B]](var_0, var_1, var_2, var_3);
}

_id_2373() {
  return self[[level._id_A9B1._id_2373]]();
}

_id_4355(var_0) {
  return self[[level._id_A9B1._id_4355]](var_0);
}

_id_8B53() {
  return self[[level._id_A9B1._id_8B53]]();
}

_id_4074() {
  return self[[level._id_A9B1._id_4074]]();
}

get_weapon_paintjobid() {
  return self[[level._id_A9B1.get_weapon_paintjobid]]();
}

get_weapon_charmguid() {
  return self[[level._id_A9B1.get_weapon_charmguid]]();
}

_id_43DD() {
  return _id_43DC(self.carryweapon);
}

_id_43DC(var_0) {
  return self[[level._id_A9B1._id_43DC]](var_0);
}

_id_439E(var_0) {
  return self[[level._id_A9B1._id_439E]](var_0);
}

_id_41C4() {
  return self[[level._id_A9B1._id_41C4]]();
}

_id_41B5() {
  return self[[level._id_A9B1._id_41B5]]();
}

_id_43D9() {
  return self[[level._id_A9B1._id_43D9]]();
}

_id_8C6C() {
  if(isDefined(level._id_A9B1._id_8C6C))
    return self[[level._id_A9B1._id_8C6C]]();
  else
    return undefined;
}

_id_5778(var_0) {
  return [[level._id_A9B1._id_5778]](var_0);
}

_id_8BAF() {
  return [[level._id_A9B1._id_8BAF]]();
}