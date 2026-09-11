/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\player_utility.gsc
****************************************************/

function _isalive() {
  return isalive(self) && !isDefined(self.fauxdead) && !istrue(self.delayedspawnedplayernotify);
}

function setusingremote(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setUsingRemote")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setUsingRemote")]](var0);
    return;
  }
}

function clearusingremote(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "clearUsingRemote")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "clearUsingRemote")]](var0);
    return;
  }
}

function isusingremote() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isUsingRemote")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isUsingRemote")]]();
  }

  return 0;
}

function isinvehicle(var0) {
  if(isDefined(self.vehicle) && isDefined(self.vehicle.vehiclename)) {
    return true;
  }

  if(istrue(var0)) {
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

function _freezecontrols(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeControls")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeControls")]](var0, var1, var2);
  }
}

function ai_offhandfiremanager() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeControlsDebug")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeControlsDebug")]]();
  }
}

function _freezelookcontrols(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeLookControls")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeLookControls")]](var0, var1);
  }
}

function getplayersuperfaction(var0) {
  var1 = 0;

  if(isDefined(var0.operatorcustomization)) {
    var1 = var0.operatorcustomization.superfaction;
  }

  return var1;
}

function setthermalvision(var0, var1, var2) {
  if(istrue(var0)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(var1, var2, 20, 20);
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
    var0 = getthermalswitchplayercommand();
    self notifyonplayercommand("switch_thermal_mode", var0);
    var1 = scripts\engine\utility::ref_143b4("input_type_changed", "thermal_handling_ended");
    self notifyonplayercommandremove("switch_thermal_mode", var0);

    if(!isDefined(var1) || var1 == "thermal_handling_ended") {
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

function forcedemeanorsafe(var0) {
  if(var0 && self getdemeanorviewmodel() != "safe") {
    thread forcedemeanorsafeinteral(var0);
    return;
  }

  if(!var0 && self getdemeanorviewmodel() == "safe") {
    thread forcedemeanorsafeinteral(var0);
    return;
  }
}

function forcedemeanorsafeinteral(var0) {
  self endon("death_or_disconnect");
  self notify("forceDemeanorSafeInteral");
  self endon("forceDemeanorSafeInteral");
  var1 = self issprinting();

  if(!istrue(self.demeanorsprintdisable)) {
    scripts\common\utility::allow_sprint(0);
    self.demeanorsprintdisable = 1;
  }

  if(var1) {
    wait 0.5;
  }

  if(var0) {
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

function playersareenemies(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return undefined;
  }

  if(!isDefined(var0.team) || !isDefined(var1.team)) {
    return undefined;
  }

  if(level.teambased) {
    return (var0.team != var1.team);
  }

  return var0 != var1;
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