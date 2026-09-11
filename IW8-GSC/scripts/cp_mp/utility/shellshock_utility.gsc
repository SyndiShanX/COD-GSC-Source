/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\shellshock_utility.gsc
********************************************************/

function _shellshock(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = [[level.shockinterruptdelayfuncs[var1]]](var0, var2);
  }

  var5 = gettime() + var4;

  if(var1 != "top") {
    if(!scripts\common\utility::is_shellshock_allowed()) {
      return 0;
    }
  }

  if(isDefined(self.shockcategory)) {
    var6 = level.shockpriorities[self.shockcategory];
    var7 = level.shockpriorities[var1];

    if(var7 > var6) {
      if(gettime() < self.shockinterrupttime) {
        return 0;
      }
    } else if(var7 == var6) {
      if(var5 < self.shockinterrupttime) {
        return 0;
      }
    } else if(var7 < var6) {
      return 0;
    }
  }

  self.shockname = var0;
  self.shockcategory = var1;
  self.shockinterrupttime = var5;

  if(isDefined(var3)) {
    self shellshock(var0, var2, var3);
  } else {
    self shellshock(var0, var2);
  }

  self notify("_shellshock_cleanup");
  thread shellshock_cleanup(var2);
}

function _stopshellshock(var0) {
  self notify("_stopShellShock");

  if(!istrue(var0)) {
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

function shellshock_artilleryearthquake(var0, var1, var2, var3, var4) {
  playrumbleonposition("artillery_rumble", var0);

  if(!isDefined(var1)) {
    var1 = 0.7;
  }

  if(!isDefined(var2)) {
    var2 = 0.5;
  }

  if(!isDefined(var3)) {
    var3 = 800;
  }

  earthquake(var1, var2, var0, var3);
  shellshock_screenshakeonposition(var0, var3, var4);
}

function shellshock_screenshakeonposition(var0, var1, var2) {
  var3 = scripts\common\utility::playersinsphere(var0, var1);

  foreach(var5 in var3) {
    if(!isDefined(var5)) {
      continue;
    }

    if(isDefined(var2)) {
      if(isarray(var2)) {
        if(scripts\engine\utility::array_contains(var2, var5)) {
          continue;
        }
      } else if(var5 == var2) {
        continue;
      }
    }

    if(var5 scripts\cp_mp\utility\player_utility::isusingremote()) {
      continue;
    }

    var5 setclientomnvar("ui_hud_shake", 1);
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

function shellshock_cleanup(var0) {
  self endon("disconnect");
  self endon("_stopShellShock");
  self endon("_shellshock_cleanup");
  wait var0;
  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function shellshock_interruptdelayfunc(var0, var1) {
  return 250;
}

function shellshock_flashinterruptdelayfunc(var0, var1) {
  var2 = undefined;

  switch (var0) {
    case "flash_grenade_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "flashInterruptDelayFunc")) {
        var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "flashInterruptDelayFunc")]](var1);
      }

      break;
    case "flash_grenade_mp_x2":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "flashInterruptDelayFunc")) {
        var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "flashInterruptDelayFunc")]](var1);
      }

      break;
    default:
      break;
  }

  return var2;
}

function shellshock_stuninterruptdelayfunc(var0, var1) {
  var2 = undefined;

  switch (var0) {
    case "concussion_grenade_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "concussionInterruptDelayFunc")) {
        var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "concussionInterruptDelayFunc")]](var1);
      }

      break;
    default:
      break;
  }

  return var2;
}

function shellshock_gasinterruptdelayfunc(var0, var1) {
  var2 = undefined;

  switch (var0) {
    case "gas_grenade_light_mp":
    case "gas_grenade_heavy_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "gasInterruptDelayFunc")) {
        var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "gasInterruptDelayFunc")]](var1);
      }

      break;
    default:
      var2 = shellshock_interruptdelayfunc(var1);
      break;
  }

  return var2;
}

function shellshock_damageinterruptdelayfunc(var0, var1) {
  var2 = undefined;

  switch (var0) {
    case "last_stand_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "lastStandInterruptDelayFunc")) {
        var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "lastStandInterruptDelayFunc")]](var1);
      }

      break;
    default:
      var2 = shellshock_interruptdelayfunc(var1);
      break;
  }

  return var2;
}

function shellshock_nointerruptdelayfunc(var0, var1) {
  return false;
}