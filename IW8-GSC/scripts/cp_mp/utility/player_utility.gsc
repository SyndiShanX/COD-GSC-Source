/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\player_utility.gsc
****************************************************/

function _isalive() {
  return isalive(self) && !isDefined(self.fauxdead) && !istrue(self.delayedspawnedplayernotify);
}

function setusingremote(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setUsingRemote")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setUsingRemote")]](var_0);
    return;
  }
}

function clearusingremote(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "clearUsingRemote")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "clearUsingRemote")]](var_0);
    return;
  }
}

function isusingremote() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isUsingRemote")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isUsingRemote")]]();
  }

  return 0;
}

function isinvehicle(var_0) {
  if(isDefined(self.vehicle) && isDefined(self.vehicle.vehiclename)) {
    return true;
  }

  if(istrue(var_0)) {
    if(isDefined(self.ref_1425d) && isDefined(self.ref_1425d.vehiclename)) {
      return true;
    }
  }

  return false;
}

function getvehicle() {
  if(!isinvehicle()) {
    return undefined;
  }

  return self.vehicle;
}

function _freezecontrols(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeControls")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeControls")]](var_0, var_1, var_2);
  }
}

function ai_offhandfiremanager() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeControlsDebug")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeControlsDebug")]]();
  }
}

function _freezelookcontrols(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeLookControls")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeLookControls")]](var_0, var_1);
  }
}

function getplayersuperfaction(var_0) {
  var_1 = 0;

  if(isDefined(var_0.operatorcustomization)) {
    var_1 = var_0.operatorcustomization.superfaction;
  }

  return var_1;
}

function setthermalvision(var_0, var_1, var_2) {
  if(istrue(var_0)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(var_1, var_2, 20, 20);
    self thermalvisionon();
    return;
  }

  self disablephysicaldepthoffieldscripting();
  self thermalvisionoff();
}

function watchthermalinputchange() {
  self notify("watch_thermal_input_change");
  self endon("watch_thermal_input_change");

  for(;;) {
    var_0 = getthermalswitchplayercommand();
    self notifyonplayercommand("switch_thermal_mode", var_0);
    var_1 = scripts\engine\utility::ref_143b4("input_type_changed", "thermal_handling_ended");
    self notifyonplayercommandremove("switch_thermal_mode", var_0);

    if(!isDefined(var_1) || var_1 == "thermal_handling_ended") {
      break;
    }
  }
}

function stopwatchingthermalinputchange() {
  self notify("thermal_handling_ended");
}

function getthermalswitchplayercommand() {
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    return "+stance";
  }

  return "nightvision";
}

function enabledemeanorsafe() {
  if(!isDefined(self.demeanorsafeenabled)) {
    self.demeanorsafeenabled = 0;
  }

  self.demeanorsafeenabled++;

  if(self.demeanorsafeenabled == 1) {
    forcedemeanorsafe(1);
    return;
  }
}

function disabledemeanorsafe() {
  self.demeanorsafeenabled--;

  if(self.demeanorsafeenabled == 0) {
    self.demeanorsafeenabled = undefined;
    forcedemeanorsafe(0);
    return;
  }
}

function forcedemeanorsafe(var_0) {
  if(var_0 && self getdemeanorviewmodel() != "safe") {
    thread forcedemeanorsafeinteral(var_0);
    return;
  }

  if(!var_0 && self getdemeanorviewmodel() == "safe") {
    thread forcedemeanorsafeinteral(var_0);
    return;
  }
}

function forcedemeanorsafeinteral(var_0) {
  self endon("death_or_disconnect");
  self notify("forceDemeanorSafeInteral");
  self endon("forceDemeanorSafeInteral");
  var_1 = self issprinting();

  if(!istrue(self.demeanorsprintdisable)) {
    scripts\common\utility::allow_sprint(0);
    self.demeanorsprintdisable = 1;
  }

  if(var_1) {
    wait 0.5;
  }

  if(var_0) {
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
  } else {
    self setdemeanorviewmodel("normal");
  }

  wait 0.5;

  if(istrue(self.demeanorsprintdisable)) {
    scripts\common\utility::allow_sprint(1);
    self.demeanorsprintdisable = undefined;
    return;
  }
}

function cleardemeanorsafe() {
  self.demeanorsafeenabled = undefined;
  self.demeanorsprintdisable = undefined;
}

function playersareenemies(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_0.team) || !isDefined(var_1.team)) {
    return undefined;
  }

  if(level.teambased) {
    return (var_0.team != var_1.team);
  }

  return var_0 != var_1;
}

function ref_12510() {
  return self setclientkillstreakindexes() || scripts\common\utility::iswegameplatform();
}

function temp_debug_wait_and_stop_music_loop() {
  level.ref_126c0 = [];
}

function being_kicked_from_inactivity() {
  if(!self clearvehicleturretsticker()) {
    level.ref_126c0[self getxuid()] = self;
    return;
  }
}

function ref_12c03() {
  level.ref_126c0[self getxuid()] = undefined;
}

function relic_nuketimer_timer() {
  return level.ref_126c0;
}

function allowunresolvedcollision() {
  if(!isDefined(self.ref_125cd)) {
    self.ref_125cd = 0;
  }

  if(self.ref_125cd == 0) {
    self playerhide();
  }

  self.ref_125cd++;
}

function allplayers_clearphysicaldof() {
  if(isDefined(self.ref_125cd)) {
    if(self.ref_125cd == 1) {
      self playershow();
    }

    self.ref_125cd--;

    if(self.ref_125cd <= 0) {
      self.ref_125cd = undefined;
      return;
    }

    return;
  }

  self playershow();
}

function ref_125d0() {
  self.ref_125cd = undefined;

  if(!isDefined(level.ref_12693)) {
    level.ref_12693 = getdvarint("scr_playerShowOnReset", 0);
  }

  if(level.ref_12693) {
    self playershow();
    return;
  }
}