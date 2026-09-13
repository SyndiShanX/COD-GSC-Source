/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\shellshock_utility.gsc
********************************************************/

_shellshock(name, category, duration, _id_58B4CF4257914E62, _id_85D98965B00F0093) {
  if(!isDefined(_id_85D98965B00F0093))
    _id_85D98965B00F0093 = [[level.shockinterruptdelayfuncs[category]]](name, duration);

  _id_E1B45EC24ABDBE91 = gettime() + _id_85D98965B00F0093;

  if(category != "top") {
    if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("shellshock"))
      return 0;
  }

  if(isDefined(self.shockcategory)) {
    _id_A88C64ED9E813835 = level.shockpriorities[self.shockcategory];
    _id_0ECE43214E2FD6E1 = level.shockpriorities[category];

    if(_id_0ECE43214E2FD6E1 > _id_A88C64ED9E813835) {
      if(gettime() < self.shockinterrupttime)
        return 0;
    } else if(_id_0ECE43214E2FD6E1 == _id_A88C64ED9E813835) {
      if(_id_E1B45EC24ABDBE91 < self.shockinterrupttime)
        return 0;
    }
  }

  self.shockname = name;
  self.shockcategory = category;
  self.shockinterrupttime = _id_E1B45EC24ABDBE91;

  if(isDefined(_id_58B4CF4257914E62))
    self shellshock(name, duration, _id_58B4CF4257914E62);
  else
    self shellshock(name, duration);

  self notify("_shellshock_cleanup");
  thread shellshock_cleanup(duration);
}

_stopshellshock(_id_FCEF8D217A441961) {
  self notify("_stopShellShock");

  if(!istrue(_id_FCEF8D217A441961))
    self stopshellshock();

  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

enableshellshockfunc() {}

disableshellshockfunc() {
  _stopshellshock(scripts\cp_mp\utility\player_utility::_isalive());
}

shellshock_artilleryearthquake(position, scale, duration, radius, _id_078CE85A35312119) {
  playrumbleonposition("artillery_rumble", position);

  if(!isDefined(scale))
    scale = 0.7;

  if(!isDefined(duration))
    duration = 0.5;

  if(!isDefined(radius))
    radius = 800;

  earthquake(scale, duration, position, radius);
  shellshock_screenshakeonposition(position, radius, _id_078CE85A35312119);
}

shellshock_screenshakeonposition(position, radius, _id_078CE85A35312119) {
  _id_8E190D59EEE1DE81 = scripts\common\utility::playersinsphere(position, radius);

  foreach(player in _id_8E190D59EEE1DE81) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(_id_078CE85A35312119)) {
      if(isarray(_id_078CE85A35312119)) {
        if(scripts\engine\utility::array_contains(_id_078CE85A35312119, player))
          continue;
      } else if(player == _id_078CE85A35312119)
        continue;
    }

    if(player scripts\cp_mp\utility\player_utility::isusingremote()) {
      continue;
    }
    player setclientomnvar("ui_hud_shake", 1);
  }
}

shellshock_utility_init() {
  level.enableshellshockfunc = ::enableshellshockfunc;
  level.disableshellshockfunc = ::disableshellshockfunc;
  level.shockpriorities = [];
  level.shockpriorities["top"] = 0;
  level.shockpriorities["flash"] = 1;
  level.shockpriorities["stun"] = 2;
  level.shockpriorities["gas"] = 3;
  level.shockpriorities["poison"] = 4;
  level.shockpriorities["explosion"] = 5;
  level.shockpriorities["damage"] = 6;
  level.shockpriorities["bottom"] = 7;
  level.shockinterruptdelayfuncs["top"] = ::shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs["flash"] = ::shellshock_flashinterruptdelayfunc;
  level.shockinterruptdelayfuncs["stun"] = ::shellshock_stuninterruptdelayfunc;
  level.shockinterruptdelayfuncs["gas"] = ::shellshock_gasinterruptdelayfunc;
  level.shockinterruptdelayfuncs["poison"] = ::shellshock_gasinterruptdelayfunc;
  level.shockinterruptdelayfuncs["explosion"] = ::shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs["damage"] = ::shellshock_damageinterruptdelayfunc;
  level.shockinterruptdelayfuncs["bottom"] = ::shellshock_nointerruptdelayfunc;
}

shellshock_cleanup(duration) {
  self endon("disconnect");
  self endon("_stopShellShock");
  self endon("_shellshock_cleanup");
  wait(duration);
  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

shellshock_interruptdelayfunc(name, duration) {
  return 250.0;
}

shellshock_flashinterruptdelayfunc(name, duration) {
  _id_C583D4C408E4580B = undefined;

  switch (name) {
    case "flash_grenade_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "flashInterruptDelayFunc"))
        _id_C583D4C408E4580B = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "flashInterruptDelayFunc")]](duration);

      break;
    default:
  }

  return _id_C583D4C408E4580B;
}

shellshock_stuninterruptdelayfunc(name, duration) {
  _id_C583D4C408E4580B = undefined;

  switch (name) {
    case "butcher_shout_mp":
    case "butcher_slam_mp":
    case "butcher_headbutt_mp":
    case "bomb_stun_mp":
    case "sound_veil_reduced_mp":
    case "sound_veil_mp":
    case "suppression_rounds_mp":
    case "concussion_grenade_mp":
    case "emp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "concussionInterruptDelayFunc"))
        _id_C583D4C408E4580B = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "concussionInterruptDelayFunc")]](duration);

      break;
    default:
  }

  return _id_C583D4C408E4580B;
}

shellshock_gasinterruptdelayfunc(name, duration) {
  _id_C583D4C408E4580B = undefined;

  switch (name) {
    case "gas_grenade_light_mp":
    case "gas_grenade_heavy_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "gasInterruptDelayFunc"))
        _id_C583D4C408E4580B = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "gasInterruptDelayFunc")]](duration);

      break;
    default:
      _id_C583D4C408E4580B = shellshock_interruptdelayfunc(duration);
  }

  return _id_C583D4C408E4580B;
}

shellshock_damageinterruptdelayfunc(name, duration) {
  _id_C583D4C408E4580B = undefined;

  switch (name) {
    case "last_stand_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "lastStandInterruptDelayFunc"))
        _id_C583D4C408E4580B = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "lastStandInterruptDelayFunc")]](duration);

      break;
    default:
      _id_C583D4C408E4580B = shellshock_interruptdelayfunc(duration);
  }

  return _id_C583D4C408E4580B;
}

shellshock_nointerruptdelayfunc(name, duration) {
  return 0;
}