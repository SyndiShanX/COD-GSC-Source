/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2501.gsc
*************************************************/

_isalive() {
  return isalive(self) && !isDefined(self._id_59E0) && !istrue(self._id_46C3);
}

_id_D8D4(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setUsingRemote")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setUsingRemote")]](var_0);
  }
}

_id_3990(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "clearUsingRemote")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "clearUsingRemote")]](var_0);
  }
}

_id_8ACE() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isUsingRemote")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isUsingRemote")]]();
  }

  return 0;
}

isinvehicle(var_0) {
  if(isDefined(self.vehicle) && isDefined(self.vehicle._id_1031E)) {
    return 1;
  }

  if(istrue(var_0)) {
    if(isDefined(self._id_10329) && isDefined(self._id_10329._id_1031E)) {
      return 1;
    }
  }

  return 0;
}

getvehicle() {
  if(!isinvehicle()) {
    return undefined;
  }

  return self.vehicle;
}

_freezecontrols(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeControls")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeControls")]](var_0, var_1);
  }
}

_id_0BEE(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeLookControls")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeLookControls")]](var_0, var_1);
  }
}

_id_6C67(var_0) {
  var_1 = 0;

  if(isDefined(var_0._id_AC3D)) {
    var_1 = var_0._id_AC3D._id_EB25;
  }

  return var_1;
}

_id_D720(var_0, var_1, var_2) {
  if(istrue(var_0)) {
    self _meth_865D();
    self _meth_8660(var_1, var_2, 20, 20);
    self _meth_840B();
  } else {
    self _meth_865E();
    self _meth_840A();
  }
}

_id_10C17() {
  self notify("watch_thermal_input_change");
  self endon("watch_thermal_input_change");

  for(;;) {
    var_0 = _id_6DE1();
    self notifyonplayercommand("switch_thermal_mode", var_0);
    var_1 = scripts\engine\utility::_id_1089F("input_type_changed", "thermal_handling_ended");
    self _meth_824C("switch_thermal_mode", var_0);

    if(!isDefined(var_1) || var_1 == "thermal_handling_ended") {
      break;
    }
  }
}

_id_E94B() {
  self notify("thermal_handling_ended");
}

_id_6DE1() {
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    return "+stance";
  }

  return "nightvision";
}

_id_5244() {
  if(!isDefined(self._id_47AC)) {
    self._id_47AC = 0;
  }

  self._id_47AC++;

  if(self._id_47AC == 1) {
    _id_5E8E(1);
  }
}

_id_4A9A() {
  self._id_47AC--;

  if(self._id_47AC == 0) {
    self._id_47AC = undefined;
    _id_5E8E(0);
  }
}

_id_5E8E(var_0) {
  if(var_0 && self _meth_84AD() != "safe") {
    thread _id_5E8F(var_0);
  } else if(!var_0 && self _meth_84AD() == "safe") {
    thread _id_5E8F(var_0);
  }
}

_id_5E8F(var_0) {
  self endon("death_or_disconnect");
  self notify("forceDemeanorSafeInteral");
  self endon("forceDemeanorSafeInteral");
  var_1 = self issprinting();

  if(!istrue(self._id_47AD)) {
    scripts\common\utility::_id_1581(0);
    self._id_47AD = 1;
  }

  if(var_1) {
    wait 0.5;
  }

  if(var_0) {
    self _meth_84AC("safe", "iw8_ges_demeanor_safe");
  } else {
    self _meth_84AC("normal");
  }

  wait 0.5;

  if(istrue(self._id_47AD)) {
    scripts\common\utility::_id_1581(1);
    self._id_47AD = undefined;
  }
}

_id_3937() {
  self._id_47AC = undefined;
  self._id_47AD = undefined;
}

_id_B78C(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_0.team) || !isDefined(var_1.team)) {
    return undefined;
  }

  if(level.teambased) {
    return var_0.team != var_1.team;
  } else {
    return var_0 != var_1;
  }
}

_id_B667() {
  return scripts\common\utility::_id_8B11();
}

_id_8182() {
  level._id_B7EE = [];
}

_id_115B() {
  if(!self _meth_87A6()) {
    level._id_B7EE[self getxuid()] = self;
  }
}

_id_C4A8() {
  level._id_B7EE[self getxuid()] = undefined;
}

_id_69E4() {
  return level._id_B7EE;
}

_id_0C91() {
  if(!isDefined(self._id_B6D7)) {
    self._id_B6D7 = 0;
  }

  if(self._id_B6D7 == 0) {
    self playerhide();
  }

  self._id_B6D7++;
}

_id_0C93() {
  if(self._id_B6D7 == 1) {
    self playershow();
  }

  self._id_B6D7--;

  if(self._id_B6D7 == 0) {
    self._id_B6D7 = undefined;
  }
}

_id_B6D8() {
  self._id_B6D7 = undefined;

  if(!isDefined(level._id_B7B3)) {
    level._id_B7B3 = getdvarint("#x3e30ad2c2dae99efb", 0);
  }

  if(level._id_B7B3) {
    self playershow();
  }
}

monitorammoregen() {
  self notify("monitorAmmoRegen");
  self endon("monitorAmmoRegen");
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    foreach(var_1 in self._id_034A) {
      if(issubstr(var_1.basename, "emike1")) {
        self setweaponammostock(var_1, 300);
      }
    }

    waitframe();
  }
}