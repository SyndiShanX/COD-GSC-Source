/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\shellshock_utility.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace shellshock_utility;

function init() {
  level._effect["5G\xb5\x9es\x9e\xe3 \xd0\xee\x8c"] = loadfxasset(level.gamemodebundle.var_511c58d58f5473a3 ?? "\x1f\x92*6\xce\x9amq\xbf\xac\x97\x8a\xb9M\x90i\xddB\x0f\xb9o\x94\xe8\xf3\xf3+X!?\xe8\x87\xda\xdc");
  level.enableshellshockfunc = &enableshellshockfunc;
  level.disableshellshockfunc = &disableshellshockfunc;
  level.shockpriorities = [];
  level.shockpriorities[#"top"] = 0;
  level.shockpriorities[#"flash"] = 1;
  level.shockpriorities[#"stun"] = 2;
  level.shockpriorities[#"gas"] = 3;
  level.shockpriorities[#"poison"] = 4;
  level.shockpriorities[#"explosion"] = 5;
  level.shockpriorities[#"damage"] = 6;
  level.shockpriorities[#"bottom"] = 7;
  level.shockinterruptdelayfuncs[#"top"] = &shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs[#"flash"] = &shellshock_flashinterruptdelayfunc;
  level.shockinterruptdelayfuncs[#"stun"] = &shellshock_stuninterruptdelayfunc;
  level.shockinterruptdelayfuncs[#"gas"] = &shellshock_gasinterruptdelayfunc;
  level.shockinterruptdelayfuncs[#"poison"] = &shellshock_gasinterruptdelayfunc;
  level.shockinterruptdelayfuncs[#"explosion"] = &shellshock_interruptdelayfunc;
  level.shockinterruptdelayfuncs[#"damage"] = &shellshock_damageinterruptdelayfunc;
  level.shockinterruptdelayfuncs[#"bottom"] = &shellshock_nointerruptdelayfunc;
}

function _shellshock(name, category, duration, animationresponse, interruptdelayms) {
  if(!isDefined(interruptdelayms)) {
    if(isDefined(level.shockinterruptdelayfuncs[category])) {
      interruptdelayms = [[level.shockinterruptdelayfuncs[category]]](name, duration);

      if(!isDefined(interruptdelayms)) {
        assertmsg("<dev string:x24>" + getxhashsourcename(name) + "<dev string:x47>" + getxhashsourcename(category) + "<dev string:x5a>");
        interruptdelayms = 0;
      }
    } else {
      assertmsg("<dev string:x72>" + getxhashsourcename(category) + "<dev string:xab>");
      interruptdelayms = 0;
    }
  }

  var_776533417a97073c = gettime() + interruptdelayms;

  if(category != "\x1d Q") {
    if(!val::get("\xcd\x1a+l\x1bnh\xf6\x1bk")) {
      return 0;
    }
  }

  if(isDefined(self.shockcategory)) {
    curpriority = level.shockpriorities[self.shockcategory];
    newpriority = level.shockpriorities[category];

    if(!isDefined(newpriority)) {
      assert(isDefined(level.shockpriorities), "<dev string:xb0>");
      assert(isxhash(category), "<dev string:xe8>");
      assert(isDefined(level.shockpriorities[category]), "<dev string:x124>");
      newpriority = 0;
    }

    if(newpriority > curpriority) {
      if(gettime() < self.shockinterrupttime) {
        return 0;
      }
    } else if(newpriority == curpriority) {
      if(var_776533417a97073c < self.shockinterrupttime) {
        return 0;
      }
    }
  }

  self.shockname = name;
  self.shockcategory = category;
  self.shockinterrupttime = var_776533417a97073c;
  assert(isxhashasset(self.shockname));
  var_ca2a29a85fe54345 = 0;

  if(istrue(utility::callsharedfunc(#"perk", #"hasperk", "\xa1\xd7f\xc3kY\xcb\t3\xdc\xdc\xed\x0eb\xd7\xbd\xd9$y")) || istrue(utility::callsharedfunc(#"game", #"isspawnprotected"))) {
    var_ca2a29a85fe54345 = 1;
  }

  if(isDefined(animationresponse)) {
    self shellshock(name, duration, animationresponse, var_ca2a29a85fe54345);
  } else {
    self shellshock(name, duration, 0, var_ca2a29a85fe54345);
  }

  self notify("\xdd\x97E\rt`\x90\xd4\xb7\xf1\xca\xc4\xc4\xd1\x980\xce\xd5y");
  thread shellshock_cleanup(duration);
}

function shellshock_cleanup(duration) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x13\xd5\x9a#z\xd9(H\xe2\xf2?\xa53\xb7\x84");
  self endon("\xdd\x97E\rt`\x90\xd4\xb7\xf1\xca\xc4\xc4\xd1\x980\xce\xd5y");
  wait duration;
  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function _stopshellshock(fromdeath) {
  if(!isDefined(self)) {
    return;
  }

  self notify("\x13\xd5\x9a#z\xd9(H\xe2\xf2?\xa53\xb7\x84");

  if(!istrue(fromdeath)) {
    self stopshellshock();
  }

  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function enableshellshockfunc() {}

function disableshellshockfunc() {
  _stopshellshock(namespace_bc7cdace2d7445a5::isalivesharedfunc());
}

function shellshock_interruptdelayfunc(name, duration) {
  return 250;
}

function shellshock_flashinterruptdelayfunc(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case % "flash_grenade_mp":
      if(utility::issharedfuncdefined(#"shellshock", #"flashinterruptdelayfunc")) {
        interruptdelay = [[utility::getsharedfunc(#"shellshock", #"flashinterruptdelayfunc")]](duration);
      }

      break;
    default:
      assertmsg("<dev string:x1a0>");
      break;
  }

  return interruptdelay;
}

function shellshock_stuninterruptdelayfunc(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case % "sound_veil_reduced_mp":
    case % "concussion_grenade_mp":
    case % "concussion_grenade_tac_mask_mp":
    case % "sound_veil_mp":
    case % "emp":
    case % "suppression_rounds_mp":
    case % "bomb_stun_mp":
      if(utility::issharedfuncdefined(#"shellshock", #"concussioninterruptdelayfunc")) {
        interruptdelay = [[utility::getsharedfunc(#"shellshock", #"concussioninterruptdelayfunc")]](duration);
      }

      break;
    case % "thermobaric_grenade":
      if(utility::issharedfuncdefined(#"thermobaric_grenade", #"thermobaric_shellshock_interrupt_delay")) {
        interruptdelay = [[utility::getsharedfunc(#"thermobaric_grenade", #"thermobaric_shellshock_interrupt_delay")]](duration);
      }

      break;
    default:
      assertmsg("<dev string:x1e3>");
      break;
  }

  return interruptdelay;
}

function shellshock_gasinterruptdelayfunc(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case % "gas_grenade_light_mp":
    case % "gas_grenade_heavy_mp":
      if(utility::issharedfuncdefined(#"shellshock", #"gasinterruptdelayfunc")) {
        interruptdelay = [[utility::getsharedfunc(#"shellshock", #"gasinterruptdelayfunc")]](duration);
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
    case % "last_stand_mp":
      if(utility::issharedfuncdefined(#"shellshock", #"laststandinterruptdelayfunc")) {
        interruptdelay = [[utility::getsharedfunc(#"shellshock", #"laststandinterruptdelayfunc")]](duration);
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
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  if(!isdismembermentenabled()) {
    return;
  }

  scriptablestate = usescriptablemeleeblood(objweapon);

  if(isDefined(scriptablestate)) {
    thread activatemeleeblood(scriptablestate);
    return;
  }

  string_array = ["\x1e\xfd\xd1\xa2\a"];
  thread play_fx_with_entity(level._effect["5G\xb5\x9es\x9e\xe3 \xd0\xee\x8c"], string_array, 1.5);
}

function usescriptablemeleeblood(objweapon) {
  if(!(isDefined(objweapon) && isDefined(objweapon.receiver))) {
    return undefined;
  }

  if(function_649db5c38c182a9(objweapon)) {
    return "\x13\xd8\xed\xb7\x19F\x85r\xbd\xce,";
  }

  if(isdoomchainsaw(objweapon)) {
    return "\xbd\x14\xad\b]s\xe1\xd5\xb8\xba\xf7";
  }

  if(objweapon.receiver == "\x86\xaf<\xc1\xc6\v\fu\xc30\x81\x99H\x86") {
    return "c\xe4\xf0\x85S\xa7<";
  }

  return undefined;
}

function function_649db5c38c182a9(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(!(isDefined(weapon.basename) && isDefined(weapon.variantid))) {
    return false;
  }

  if(weapon.basename == "i\xdd'\xeb[\xca_7\xdd\xf69#`\x13\xeb\xb5\x0e" && weapon.variantid == 2) {
    return true;
  }

  return false;
}

function isdoomchainsaw(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "\xbd\xe3\xee>\xa7\x10ob\xf0\xf2q" && weapon.receivervarindex == 2) {
      return true;
    }
  }

  return false;
}

function activatemeleeblood(state) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self setscriptablepartstate("j\xc6DS\xf9F\xeb\x88\x80g", state);
  waitframe();
  waitframe();
  self setscriptablepartstate("j\xc6DS\xf9F\xeb\x88\x80g", "\xba\xa5\x1f\xc9m\x80i");
}

function play_fx_with_entity(fx, string_array, timeout) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  var_b7960b40f2bd2da = namespace_bc7cdace2d7445a5::spawnfxforclientsharedfunc(fx, self getEye(), self);
  triggerfx(var_b7960b40f2bd2da);
  var_b7960b40f2bd2da namespace_bc7cdace2d7445a5::setfxkilldefondeletesharedfunc();
  utility::waittill_any_in_array_or_timeout(string_array, timeout);
  var_b7960b40f2bd2da delete();
}