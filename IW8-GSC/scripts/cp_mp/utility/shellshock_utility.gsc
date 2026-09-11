/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\shellshock_utility.gsc
********************************************************/

function _shellshock(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = [[level.shockinterruptdelayfuncs[var_1]]](var_0, var_2);
  }

  var_5 = gettime() + var_4;

  if(var_1 != "top") {
    if(!scripts\common\utility::is_shellshock_allowed()) {
      return 0;
    }
  }

  if(isDefined(self.shockcategory)) {
    var_6 = level.shockpriorities[self.shockcategory];
    var_7 = level.shockpriorities[var_1];

    if(var_7 > var_6) {
      if(gettime() < self.shockinterrupttime) {
        return 0;
      }
    } else if(var_7 == var_6) {
      if(var_5 < self.shockinterrupttime) {
        return 0;
      }
    } else if(var_7 < var_6) {
      return 0;
    }
  }

  self.shockname = var_0;
  self.shockcategory = var_1;
  self.shockinterrupttime = var_5;

  if(isDefined(var_3)) {
    self shellshock(var_0, var_2, var_3);
  } else {
    self shellshock(var_0, var_2);
  }

  self notify("_shellshock_cleanup");
  thread shellshock_cleanup(var_2);
}

function _stopshellshock(var_0) {
  self notify("_stopShellShock");

  if(!istrue(var_0)) {
    self stopshellshock();
  }

  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function enableshellshockfunc() {}

function disableshellshockfunc() {
  _stopshellshock(scripts\cp_mp\utility\player_utility::_isalive());
}

function shellshock_artilleryearthquake(var_0, var_1, var_2, var_3, var_4) {
  playrumbleonposition("artillery_rumble", var_0);

  if(!isDefined(var_1)) {
    var_1 = 0.7;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  if(!isDefined(var_3)) {
    var_3 = 800;
  }

  earthquake(var_1, var_2, var_0, var_3);
  shellshock_screenshakeonposition(var_0, var_3, var_4);
}

function shellshock_screenshakeonposition(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::playersinsphere(var_0, var_1);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }

    if(isDefined(var_2)) {
      if(isarray(var_2)) {
        if(scripts\engine\utility::array_contains(var_2, var_5)) {
          continue;
        }
      } else if(var_5 == var_2) {
        continue;
      }
    }

    if(var_5 scripts\cp_mp\utility\player_utility::isusingremote()) {
      continue;
    }

    var_5 setclientomnvar("ui_hud_shake", 1);
  }
}

function shellshock_utility_init() {
  level.enableshellshockfunc = &enableshellshockfunc;
  level.disableshellshockfunc = &disableshellshockfunc;
  level.shockpriorities = [];
  level.shockpriorities["top"] = 0;
  level.shockpriorities["flash"] = 1;
  level.shockpriorities["stun"] = 2;
  level.shockpriorities["gas"] = 3;
  level.shockpriorities["explosion"] = 4;
  level.shockpriorities["damage"] = 4;
  level.shockpriorities["bottom"] = 5;
  level.shockinterruptdelayfuncs["top"] = &shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs["flash"] = &shellshock_flashinterruptdelayfunc;
  level.shockinterruptdelayfuncs["stun"] = &shellshock_stuninterruptdelayfunc;
  level.shockinterruptdelayfuncs["gas"] = &shellshock_gasinterruptdelayfunc;
  level.shockinterruptdelayfuncs["explosion"] = &shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs["damage"] = &shellshock_damageinterruptdelayfunc;
  level.shockinterruptdelayfuncs["bottom"] = &shellshock_nointerruptdelayfunc;
}

function shellshock_cleanup(var_0) {
  self endon("disconnect");
  self endon("_stopShellShock");
  self endon("_shellshock_cleanup");
  wait var_0;
  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function shellshock_interruptdelayfunc(var_0, var_1) {
  return 250;
}

function shellshock_flashinterruptdelayfunc(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "flash_grenade_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "flashInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "flashInterruptDelayFunc")]](var_1);
      }

      break;
    case "flash_grenade_mp_x2":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "flashInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "flashInterruptDelayFunc")]](var_1);
      }

      break;
    default:
      break;
  }

  return var_2;
}

function shellshock_stuninterruptdelayfunc(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "concussion_grenade_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "concussionInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "concussionInterruptDelayFunc")]](var_1);
      }

      break;
    default:
      break;
  }

  return var_2;
}

function shellshock_gasinterruptdelayfunc(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "gas_grenade_light_mp":
    case "gas_grenade_heavy_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "gasInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "gasInterruptDelayFunc")]](var_1);
      }

      break;
    default:
      var_2 = shellshock_interruptdelayfunc(var_1);
      break;
  }

  return var_2;
}

function shellshock_damageinterruptdelayfunc(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "last_stand_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "lastStandInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "lastStandInterruptDelayFunc")]](var_1);
      }

      break;
    default:
      var_2 = shellshock_interruptdelayfunc(var_1);
      break;
  }

  return var_2;
}

function shellshock_nointerruptdelayfunc(var_0, var_1) {
  return false;
}