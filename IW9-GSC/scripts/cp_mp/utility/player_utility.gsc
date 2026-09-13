/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\player_utility.gsc
****************************************************/

getstancecenter() {
  if(self getstance() == "crouch")
    center = self.origin + (0, 0, 24);
  else if(self getstance() == "prone")
    center = self.origin + (0, 0, 10);
  else
    center = self.origin + (0, 0, 32);

  return center;
}

getstancetop(_id_2EEA482C1A2F43A9) {
  _id_6497396FB64EA3B9 = self getstance();

  if(isDefined(_id_2EEA482C1A2F43A9))
    _id_6497396FB64EA3B9 = _id_2EEA482C1A2F43A9;

  if(_id_6497396FB64EA3B9 == "crouch")
    top = self.origin + (0, 0, 48);
  else if(_id_6497396FB64EA3B9 == "prone")
    top = self.origin + (0, 0, 20);
  else
    top = self.origin + (0, 0, 64);

  return top;
}

_isalive() {
  return isalive(self) && !isDefined(self.fauxdead) && !istrue(self.delayedspawnedplayernotify) && !istrue(self._id_C4C8B91E0B16AA5E);
}

setusingremote(_id_7B0C72F7301EB1C4) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "setUsingRemote"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "setUsingRemote")]](_id_7B0C72F7301EB1C4);
}

clearusingremote(_id_2C111F02D48E2671) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "clearUsingRemote"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "clearUsingRemote")]](_id_2C111F02D48E2671);
}

isusingremote() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isUsingRemote"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isUsingRemote")]]();

  return 0;
}

_id_1E4A0E61FDB00E32(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isOOB"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isOOB")]](player);

  return isDefined(player.oob) && player.oob > 0;
}

isenemy(other) {
  if(level.teambased) {
    if(isDefined(other.team) && isDefined(self.team))
      return other.team != self.team;
    else
      return 1;
  } else if(isDefined(other.owner))
    return other.owner != self;
  else
    return other != self;
}

isinvehicle(_id_A24A6968CFC1C46D) {
  if(isDefined(self.vehicle) && isDefined(self.vehicle.vehiclename))
    return 1;

  if(istrue(_id_A24A6968CFC1C46D)) {
    if(isDefined(self.vehiclereserved) && isDefined(self.vehiclereserved.vehiclename))
      return 1;
  }

  return 0;
}

getvehicle(_id_03FCD58F5BAE3BD0) {
  if(isinvehicle())
    return self.vehicle;
  else if(istrue(_id_03FCD58F5BAE3BD0))
    return self._id_ABD157413AC4E022;

  return undefined;
}

_id_F8789F15330DE751(player) {
  if(!isDefined(player) || isbot(player) || isagent(player))
    return 0;

  return istrue(player isinvehicle(1)) || isDefined(player getmovingplatformparent());
}

_freezecontrols(frozen, _id_F8048727716242B0, debug) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeControls"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeControls")]](frozen, _id_F8048727716242B0, debug);
}

_id_8213D31F7A3C32E2() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeControlsDebug"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeControlsDebug")]]();
}

_freezelookcontrols(frozen, _id_F8048727716242B0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "freezeLookControls"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "freezeLookControls")]](frozen, _id_F8048727716242B0);
}

_id_82F44F5F304BA91A(enabled) {
  self allowmovement(!enabled);
  self allowprone(!enabled);
  self allowjump(!enabled);
  self allowmelee(!enabled);
  self freezecontrols(enabled);
  self freezelookcontrols(enabled);
}

getplayersuperfaction(player) {
  _id_A67AA6A470CEEB29 = 0;

  if(isDefined(player.operatorcustomization))
    _id_A67AA6A470CEEB29 = player.operatorcustomization.superfaction;

  return _id_A67AA6A470CEEB29;
}

setthermalvision(_id_E3108E412AFB3811, fstop, focusdistance) {
  if(istrue(_id_E3108E412AFB3811)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(fstop, focusdistance, 20, 20);
    self thermalvisionon();
  } else {
    self disablephysicaldepthoffieldscripting();
    self thermalvisionoff();
  }
}

watchthermalinputchange(_id_2153D566F8B7319A) {
  self notify("watch_thermal_input_change");
  self endon("watch_thermal_input_change");
  self endon("disconnect");

  for(;;) {
    _id_FF8E235B01CD7409 = getthermalswitchplayercommand(_id_2153D566F8B7319A);
    self notifyonplayercommand("switch_thermal_mode", _id_FF8E235B01CD7409);
    _id_FD99CC32B0AC87B4 = scripts\engine\utility::waittill_any_return_no_endon_death_2("input_type_changed", "thermal_handling_ended");
    self notifyonplayercommandremove("switch_thermal_mode", _id_FF8E235B01CD7409);

    if(!isDefined(_id_FD99CC32B0AC87B4) || _id_FD99CC32B0AC87B4 == "thermal_handling_ended") {
      break;
    }
  }
}

stopwatchingthermalinputchange() {
  self notify("thermal_handling_ended");
}

updateinputtypewatcher() {
  _id_51EC07DC533464B5 = scripts\engine\utility::is_player_gamepad_enabled();

  if(!isDefined(self.gamepadwasenabled) || self.gamepadwasenabled != _id_51EC07DC533464B5) {
    self notify("input_type_changed", _id_51EC07DC533464B5);
    self.gamepadwasenabled = _id_51EC07DC533464B5;
  }
}

getthermalswitchplayercommand(_id_2153D566F8B7319A) {
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    if(istrue(_id_2153D566F8B7319A))
      return "+stance";

    return "+gostand";
  }

  return "nightvision";
}

enabledemeanorsafe() {
  if(!isDefined(self.demeanorsafeenabled))
    self.demeanorsafeenabled = 0;

  self.demeanorsafeenabled++;

  if(self.demeanorsafeenabled == 1)
    forcedemeanorsafe(1);
}

disabledemeanorsafe() {
  self.demeanorsafeenabled--;

  if(self.demeanorsafeenabled == 0) {
    self.demeanorsafeenabled = undefined;
    forcedemeanorsafe(0);
  }
}

forcedemeanorsafe(_id_E3108E412AFB3811) {
  if(_id_E3108E412AFB3811 && self getdemeanorviewmodel() != "safe")
    thread forcedemeanorsafeinteral(_id_E3108E412AFB3811);
  else if(!_id_E3108E412AFB3811 && self getdemeanorviewmodel() == "safe")
    thread forcedemeanorsafeinteral(_id_E3108E412AFB3811);
}

forcedemeanorsafeinteral(_id_E3108E412AFB3811) {
  self endon("death_or_disconnect");
  self notify("forceDemeanorSafeInteral");
  self endon("forceDemeanorSafeInteral");
  _id_E71278C78BF4BE92 = self issprinting();

  if(!istrue(self.demeanorsprintdisable)) {
    _id_3B64EB40368C1450::set("forceDemeanor", "sprint", 0);
    self.demeanorsprintdisable = 1;
  }

  if(_id_E71278C78BF4BE92)
    wait 0.5;

  if(_id_E3108E412AFB3811)
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
  else
    self setdemeanorviewmodel("normal");

  wait 0.5;

  if(istrue(self.demeanorsprintdisable)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("forceDemeanor");
    self.demeanorsprintdisable = undefined;
  }
}

cleardemeanorsafe() {
  self.demeanorsafeenabled = undefined;
  self.demeanorsprintdisable = undefined;
}

playersareenemies(_id_17F832B5DE7083A0, _id_204DA528AA0A3464, _id_B2B9B3D299FBAEB1) {
  if(!isDefined(_id_17F832B5DE7083A0) || !isDefined(_id_204DA528AA0A3464))
    return 0;

  if(!isDefined(_id_17F832B5DE7083A0.team) || !isDefined(_id_204DA528AA0A3464.team))
    return 0;

  if(level.teambased) {
    _id_8B1B7044E27E6A56 = _id_17F832B5DE7083A0.team == _id_204DA528AA0A3464.team;

    if(istrue(_id_B2B9B3D299FBAEB1)) {
      _id_A64BC29810299920 = 0;

      if(isDefined(_id_17F832B5DE7083A0._id_B5091EFEFE8E436B) && isDefined(_id_204DA528AA0A3464._id_B5091EFEFE8E436B) && _id_17F832B5DE7083A0._id_B5091EFEFE8E436B != "none")
        _id_A64BC29810299920 = _id_17F832B5DE7083A0._id_B5091EFEFE8E436B == _id_204DA528AA0A3464._id_B5091EFEFE8E436B;

      return !_id_8B1B7044E27E6A56 && !_id_A64BC29810299920;
    }

    return !_id_8B1B7044E27E6A56;
  } else
    return _id_17F832B5DE7083A0 != _id_204DA528AA0A3464;
}

getteamindex(_id_FABF84450735DD93) {
  return level.teamdata[_id_FABF84450735DD93]["index"];
}

playerbloodrestricted() {
  return scripts\common\utility::iswegameplatform();
}

initdismembermentlist() {
  level.playerswithoutdismemberment = [];
}

addtodismembermentlist() {
  if(!self isdismembermentenabledforplayer())
    level.playerswithoutdismemberment[self getxuid()] = self;
}

removefromdismembermentlist() {
  level.playerswithoutdismemberment[self getxuid()] = undefined;
}

getdismembermentlist() {
  return level.playerswithoutdismemberment;
}

_id_305FB8C759FA4DE5() {
  if(!isDefined(self._id_5B98A9FA81294730))
    self._id_5B98A9FA81294730 = 0;

  if(self._id_5B98A9FA81294730 == 0)
    _id_A593971D75D82113();

  self._id_5B98A9FA81294730++;
}

_id_A593971D75D82113(_id_1FFFB4C6D7B458A3) {
  _id_0CBB0697DE4C5728::_id_112E56B7DBE18137();

  if(istrue(_id_1FFFB4C6D7B458A3))
    self playerhide(1);
  else
    self playerhide();
}

_id_379BB555405C16BB(_id_401C3A2E68AAB0FD) {
  if(getdvarint("dvar_B5FE5BE1CF552F2E", 0) == 0) {
    return;
  }
  logprint("PlayerHide(): " + _id_401C3A2E68AAB0FD);
}

_id_F81E91F54BDDAF46() {
  if(self._id_5B98A9FA81294730 == 1)
    _id_6FB380927695EE76();

  self._id_5B98A9FA81294730--;

  if(self._id_5B98A9FA81294730 == 0)
    self._id_5B98A9FA81294730 = undefined;
}

_id_6FB380927695EE76(_id_1FFFB4C6D7B458A3) {
  if(istrue(_id_1FFFB4C6D7B458A3))
    self playershow(1);
  else
    self playershow();

  _id_0CBB0697DE4C5728::_id_33637806FC5AC024();
}

_id_985B0973F29DA4F8(_id_401C3A2E68AAB0FD) {
  if(getdvarint("dvar_11B8360F35C60D6F", 0) == 0) {
    return;
  }
  logprint("PlayerShow(): " + _id_401C3A2E68AAB0FD);
}

_id_C28310E3B33872CB() {
  self._id_5B98A9FA81294730 = undefined;

  if(!isDefined(level._id_61A823F67A0CB19F))
    level._id_61A823F67A0CB19F = getdvarint("dvar_E6A081201F8D6465", 0);

  if(level._id_61A823F67A0CB19F)
    self playershow();
}

isreallyalive(player) {
  return isalive(player) && !isDefined(player.fauxdead) && !istrue(player.delayedspawnedplayernotify) && !istrue(player._id_C4C8B91E0B16AA5E);
}

_id_EBA2F2E094684B8F(perk) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk"))
    return self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]](perk);
  else
    return 0;
}

isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

_id_988138367C74B1F5() {
  return self _meth_E40102956C887F7C() && self _meth_6F55D55CCFF20D14();
}

_id_D474B372046544B0() {
  return self _meth_E40102956C887F7C() && !self _meth_6F55D55CCFF20D14();
}

playplayerandnpcsounds(player, _id_1CAB65DA5C44046F, _id_81E52266244F7216) {
  player playlocalsound(_id_1CAB65DA5C44046F);
  player playSound(_id_81E52266244F7216, player);
}

_id_F7348E400B4A608D(player, _id_3BE15D8AD8B7024D, priority, _id_D072D3A2581E3699) {
  if(!isDefined(player) || isbot(player) || isagent(player)) {
    return;
  }
  if(!isDefined(player._id_82B2C97DAD24DE07)) {
    player._id_82B2C97DAD24DE07 = spawnStruct();
    player._id_82B2C97DAD24DE07._id_0DC609EF4988D3EF = _id_3BE15D8AD8B7024D;
    player._id_82B2C97DAD24DE07.priority = priority;
  } else if(istrue(_id_D072D3A2581E3699) || !isDefined(player._id_82B2C97DAD24DE07.priority) || player._id_82B2C97DAD24DE07.priority <= priority) {
    player._id_82B2C97DAD24DE07._id_0DC609EF4988D3EF = _id_3BE15D8AD8B7024D;
    player._id_82B2C97DAD24DE07.priority = priority;
  } else
    return;

  player setcinematicmotionoverride(_id_3BE15D8AD8B7024D);
}

_id_56D83CDE22535F96(player) {
  if(!isDefined(player) || isbot(player) || isagent(player)) {
    return;
  }
  player clearcinematicmotionoverride();

  if(isDefined(player._id_82B2C97DAD24DE07)) {
    player._id_82B2C97DAD24DE07._id_0DC609EF4988D3EF = undefined;
    player._id_82B2C97DAD24DE07.priority = undefined;
  }
}

_visionsetnaked(_id_FC0043E95242D5CB, time) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isai(player)) {
      continue;
    }
    player visionsetnakedforplayer(_id_FC0043E95242D5CB, time);
  }

  return;
}

waittillrecoveredhealth(time, interval) {
  self endon("death_or_disconnect");
  _id_19B16D351AFFA487 = 0;

  if(!isDefined(interval))
    interval = 0.05;

  if(!isDefined(time))
    time = 0;

  for(;;) {
    if(self.health != self.maxhealth)
      _id_19B16D351AFFA487 = 0;
    else
      _id_19B16D351AFFA487 = _id_19B16D351AFFA487 + interval;

    wait(interval);

    if(self.health == self.maxhealth && _id_19B16D351AFFA487 >= time) {
      break;
    }
  }

  return;
}

hidehudenable() {
  if(!isDefined(self.ui_hudhidden))
    self.hidehudenabled = 0;

  if(self.hidehudenabled == 0)
    self setclientomnvar("ui_hide_hud", 1);

  self.hidehudenabled++;
}

hidehuddisable() {
  if(self.hidehudenabled == 1)
    self setclientomnvar("ui_hide_hud", 0);

  self.hidehudenabled--;
}

hidehudclear() {
  self.hidehudenabled = undefined;
  self setclientomnvar("ui_hide_hud", 0);
}

_id_A104C06453297036(player, ignoreents, contentoverride) {
  contents = scripts\engine\trace::create_default_contents();

  if(isDefined(contentoverride)) {
    if(isarray(contentoverride))
      contentoverride = physics_createcontents(contentoverride);

    contents = contentoverride;
  }

  _id_22C4300CE1D248E8 = player getvieworigin();

  if(player _meth_C1092F42B6BBE490())
    _id_22C4300CE1D248E8 = player _meth_842574CE5FCD5B52();

  _id_98C6610C2907BA2B = _id_22C4300CE1D248E8 + anglesToForward(player getplayerangles()) * 20000;
  trace = scripts\engine\trace::ray_trace(_id_22C4300CE1D248E8, _id_98C6610C2907BA2B, ignoreents, contentoverride);
  endpos = undefined;

  if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none")
    endpos = trace["position"];

  return endpos;
}

_id_44D612709F857370() {
  return self jumpbuttonPressed();
}

_id_1551F039785A297D() {
  return self _meth_5304F90E15C214D2();
}

_id_B7869F6D9D4242E3(reviver) {
  return istrue(reviver.revivingteammate) && !istrue(reviver._id_383E041E3E341315);
}