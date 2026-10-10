/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\shellshock_utility.gsc
****************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace shellshock_utility;

function init() {
  level._effect["melee_spray"] = loadfx("vfx/core/screen/vfx_melee_blood_spray");
  level.enableshellshockfunc = &enableshellshockfunc;
  level.disableshellshockfunc = &disableshellshockfunc;
  level.shockpriorities = [];
  level.shockpriorities["top"] = 0;
  level.shockpriorities["flash"] = 1;
  level.shockpriorities["stun"] = 2;
  level.shockpriorities["gas"] = 3;
  level.shockpriorities["poison"] = 4;
  level.shockpriorities["explosion"] = 5;
  level.shockpriorities["damage"] = 6;
  level.shockpriorities["bottom"] = 7;
  level.shockinterruptdelayfuncs["top"] = &shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs["flash"] = &shellshock_flashinterruptdelayfunc;
  level.shockinterruptdelayfuncs["stun"] = &shellshock_stuninterruptdelayfunc;
  level.shockinterruptdelayfuncs["gas"] = &shellshock_gasinterruptdelayfunc;
  level.shockinterruptdelayfuncs["poison"] = &shellshock_gasinterruptdelayfunc;
  level.shockinterruptdelayfuncs["explosion"] = &shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs["damage"] = &shellshock_damageinterruptdelayfunc;
  level.shockinterruptdelayfuncs["bottom"] = &shellshock_nointerruptdelayfunc;
}

function _shellshock(name, category, duration, animationresponse, interruptdelayms) {
  assertex(isDefined(level.shockpriorities), "<dev string:x1c>");
  assertex(array_contains(getarraykeys(level.shockpriorities), category), "<dev string:x54>");

  if(!isDefined(interruptdelayms)) {
    assertex(isDefined(level.shockinterruptdelayfuncs[category]), "<dev string:xd0>" + category + "<dev string:x109>");
    interruptdelayms = [[level.shockinterruptdelayfuncs[category]]](name, duration);
    assertex(isDefined(interruptdelayms), "<dev string:x10e>" + name + "<dev string:x131>" + category + "<dev string:x144>");
  }

  var_e1b45ec24abdbe91 = gettime() + interruptdelayms;

  if(category != "top") {
    if(!val::get("shellshock")) {
      return 0;
    }
  }

  if(isDefined(self.shockcategory)) {
    curpriority = level.shockpriorities[self.shockcategory];
    newpriority = level.shockpriorities[category];

    if(newpriority > curpriority) {
      if(gettime() < self.shockinterrupttime) {
        return 0;
      }
    } else if(newpriority == curpriority) {
      if(var_e1b45ec24abdbe91 < self.shockinterrupttime) {
        return 0;
      }
    }
  }

  self.shockname = name;
  self.shockcategory = category;
  self.shockinterrupttime = var_e1b45ec24abdbe91;
  var_5cd5209e58a2b1c8 = 0;

  if(function_f3bb4f4911a1beb2("perk", "hasPerk", "specialty_dauntless") || function_f3bb4f4911a1beb2("game", "isSpawnProtected")) {
    var_5cd5209e58a2b1c8 = 1;
  }

  if(isDefined(animationresponse)) {
    self shellshock(name, duration, animationresponse, var_5cd5209e58a2b1c8);
  } else {
    self shellshock(name, duration, undefined, var_5cd5209e58a2b1c8);
  }

  self notify("_shellshock_cleanup");
  thread shellshock_cleanup(duration);
}

function shellshock_cleanup(duration) {
  self endon("disconnect");
  self endon("_stopShellShock");
  self endon("_shellshock_cleanup");
  wait duration;
  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function _stopshellshock(fromdeath) {
  self notify("_stopShellShock");

  if(!istrue(fromdeath)) {
    self stopshellshock();
  }

  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function enableshellshockfunc() {}

function disableshellshockfunc() {
  _stopshellshock(function_287a1854579369f5());
}

function shellshock_interruptdelayfunc(name, duration) {
  return 250;
}

function shellshock_flashinterruptdelayfunc(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case #"hash_d072a0adddda0068":
      if(issharedfuncdefined("shellshock", "flashInterruptDelayFunc")) {
        interruptdelay = [[getsharedfunc("shellshock", "flashInterruptDelayFunc")]](duration);
      }

      break;
    default:
      assertmsg("<dev string:x15c>");
      break;
  }

  return interruptdelay;
}

function shellshock_stuninterruptdelayfunc(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case #"hash_1a5a56a6fdfa6d6b":
    case #"hash_32d1f6b72c93028a":
    case #"hash_34e7a4cd11aed6bc":
    case #"hash_4084fa47c230dc38":
    case #"hash_986a886b26c9ea90":
    case #"hash_ed469a6bfff6b265":
    case #"hash_f64bad791b444c94":
      if(issharedfuncdefined("shellshock", "concussionInterruptDelayFunc")) {
        interruptdelay = [[getsharedfunc("shellshock", "concussionInterruptDelayFunc")]](duration);
      }

      break;
    case #"hash_606cb2a6a1a3bd0a":
      if(issharedfuncdefined("thermobaric_grenade", "thermobaric_shellshock_interrupt_delay")) {
        interruptdelay = [[getsharedfunc("thermobaric_grenade", "thermobaric_shellshock_interrupt_delay")]](duration);
      }

      break;
    default:
      assertmsg("<dev string:x19f>");
      break;
  }

  return interruptdelay;
}

function shellshock_gasinterruptdelayfunc(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case #"hash_7cd59e9057f449d":
    case #"hash_7ef263b8ce60aa24":
      if(issharedfuncdefined("shellshock", "gasInterruptDelayFunc")) {
        interruptdelay = [[getsharedfunc("shellshock", "gasInterruptDelayFunc")]](duration);
      }

      break;
    default:
      interruptdelay = shellshock_interruptdelayfunc(duration);
      break;
  }

  return interruptdelay;
}

function shellshock_damageinterruptdelayfunc(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case #"hash_6f7dfab682794a56":
      if(issharedfuncdefined("shellshock", "lastStandInterruptDelayFunc")) {
        interruptdelay = [[getsharedfunc("shellshock", "lastStandInterruptDelayFunc")]](duration);
      }

      break;
    default:
      interruptdelay = shellshock_interruptdelayfunc(duration);
      break;
  }

  return interruptdelay;
}

function shellshock_nointerruptdelayfunc(name, duration) {
  return false;
}

function bloodmeleeeffect(objweapon) {
  self endon("disconnect");

  if(!isdismembermentenabled()) {
    return;
  }

  scriptablestate = usescriptablemeleeblood(objweapon);

  if(isDefined(scriptablestate)) {
    thread activatemeleeblood(scriptablestate);
    return;
  }

  string_array = ["death"];
  thread play_fx_with_entity(level._effect["melee_spray"], string_array, 1.5);
}

function usescriptablemeleeblood(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.receiver)) {
    return undefined;
  }

  if(function_bb839bb513295f10(objweapon)) {
    return "bloodFXNova";
  }

  if(function_55d5c766b382551e(objweapon)) {
    return "bloodFXDoom";
  }

  if(objweapon.receiver == "iw9_me_sword01") {
    return "bloodFX";
  }

  return undefined;
}

function function_bb839bb513295f10(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(!isDefined(weapon.basename) || !isDefined(weapon.variantid)) {
    return false;
  }

  if(weapon.basename == "iw9_me_sword01_mp" && weapon.variantid == 2) {
    return true;
  }

  return false;
}

function function_55d5c766b382551e(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "rec_pickaxe" && weapon.receivervarindex == 2) {
      return true;
    }
  }

  return false;
}

function activatemeleeblood(state) {
  self endon("disconnect");
  self setscriptablepartstate("meleeBlood", state);
  waitframe();
  waitframe();
  self setscriptablepartstate("meleeBlood", "neutral");
}

function play_fx_with_entity(fx, string_array, timeout) {
  self endon("disconnect");
  var_22f48fd7df6c56fb = function_1f9d1f30f6845dd(fx, self getEye(), self);
  triggerfx(var_22f48fd7df6c56fb);
  var_22f48fd7df6c56fb function_e531ef189c6c5d1d();
  waittill_any_in_array_or_timeout(string_array, timeout);
  var_22f48fd7df6c56fb delete();
}