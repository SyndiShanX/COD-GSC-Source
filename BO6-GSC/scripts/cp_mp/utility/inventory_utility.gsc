/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\inventory_utility.gsc
*******************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\engine\utility;
#namespace inventory_utility;

function _giveweapon(weapon, variant, dualwieldoverride, usedbefore) {
  if(!isDefined(variant)) {
    variant = -1;
  }

  if(!isDefined(usedbefore)) {
    usedbefore = utility::shouldskipfirstraise();
  }

  if(getdvarint(@ "hash_111ef391787da7e1", 0) == 1) {
    usedbefore = 0;
    self iprintlnbold("<dev string:x24>");
  }

  self giveweapon(weapon, variant, istrue(dualwieldoverride), -1, usedbefore);
}

function _switchtoweapon(weapon) {
  if(isweapon(weapon) || isstring(weapon)) {
    debugweaponchangeprint("<dev string:x44>", weapon);

    self switchtoweapon(weapon);
    return;
  }

  assertmsg("<dev string:x5c>" + weapon);
}

function _switchtoweaponimmediate(weapon) {
  debugweaponchangeprint("<dev string:x87>", weapon);

  self switchtoweaponimmediate(weapon);
}

function _takeweapon(weapon) {
  if(getdvarint(@ "hash_e6a5211d6811a3e", 0) != 0) {
    debugweaponchangeprint("<dev string:xa8>", weapon);

    if(iscurrentweapon(weapon)) {
      println("<dev string:xbc>");
    }
  }

  if(isweapon(weapon) && isnullweapon(weapon)) {
    assertmsg("<dev string:xdb>");
    return;
  }

  var_f3cb828363807f0e = 0;

  if(isweapon(weapon)) {
    var_f3cb828363807f0e = self gethighpriorityweapon() == weapon;
  } else {
    assert(isstring(weapon));
    var_f3cb828363807f0e = getcompleteweaponname(self gethighpriorityweapon()) == weapon;
  }

  if(var_f3cb828363807f0e) {
    weaponstring = weapon;

    if(!isstring(weaponstring) && isweapon(weapon)) {
      weaponstring = getcompleteweaponname(weapon);
    }

    assertmsg("<dev string:x102>" + weaponstring + "<dev string:x149>");
    self clearhighpriorityweapon(weapon);
  }

  self takeweapon(weapon);
}

function takeweaponwhensafe(weapon) {
  self endon("death");
  self endon("disconnect");

  while(true) {
    var_342a2e2a90f812bd = 0;

    if(!iscurrentweapon(weapon)) {
      meleeoverrideweapon = self getweaponmeleeslot();

      if(!isnullweapon(meleeoverrideweapon) && self.currentweapon == meleeoverrideweapon) {
        var_342a2e2a90f812bd = 0;
      } else {
        var_342a2e2a90f812bd = 1;
      }
    }

    if(var_342a2e2a90f812bd) {
      break;
    }

    waitframe();
  }

  _takeweapon(weapon);
}

function getcurrentmonitoredweaponswitchweapon() {
  validatehighpriorityflag();
  currenthighpriorityweapon = self gethighpriorityweapon();

  if(isnullweapon(currenthighpriorityweapon)) {
    return undefined;
  }

  return currenthighpriorityweapon;
}

function isanymonitoredweaponswitchinprogress() {
  return isDefined(getcurrentmonitoredweaponswitchweapon());
}

function isswitchingtoweaponwithmonitoring(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);
  currentswitchweapon = getcurrentmonitoredweaponswitchweapon();
  return isDefined(currentswitchweapon) && isDefined(weaponobj) && currentswitchweapon == weaponobj && !iscurrentweapon(weaponobj);
}

function candomonitoredswitchtoweapon(weapon, var_e90b0e794aa74425) {
  if(!self hasweapon(weapon)) {
    return false;
  }

  if(!val::get("weapon")) {
    return false;
  }

  if(!var_e90b0e794aa74425 && !val::get("weapon_switch") && !val::get("script_weapon_switch")) {
    return false;
  }

  if(self isviewmodelanimplaying()) {
    return false;
  }

  currenthighpriorityweapon = getcurrentmonitoredweaponswitchweapon();

  if(isDefined(currenthighpriorityweapon)) {
    weaponbasename = getweaponbasename(weapon);
    newweaponhaspriority = 0;

    if(weaponbasename == "briefcase_bomb_mp" || weaponbasename == "briefcase_bomb_defuse_mp" || weaponbasename == "briefcase_silent_mp" || weaponbasename == "briefcase_defuse_silent_mp" || weaponbasename == "counter_attack_bomb_mp" || weaponbasename == "counter_attack_bomb_defuse_mp" || weaponbasename == "counter_attack_bomb_silent_mp" || weaponbasename == "counter_attack_bomb_defuse_silent_mp" || weaponbasename == "briefcase_bomb_mp_nuke" || weaponbasename == "iw9_cyberemp_mp" || weaponbasename == "iw7_tdefball_mp") {
      newweaponhaspriority = 1;
    } else if(weaponinventorytype(currenthighpriorityweapon) == "primary") {
      newweaponhaspriority = 1;
    }

    if(!newweaponhaspriority) {
      return false;
    }
  }

  if(iscurrentweapon(weapon)) {
    return false;
  }

  return true;
}

function abortmonitoredweaponswitch(weapon) {
  debugweaponchangeprint("<dev string:x16a>", weapon);

  assert(!iscurrentweapon(weapon), "<dev string:x177>");

  if(self gethighpriorityweapon() == weapon) {
    self clearhighpriorityweapon(weapon);
  }

  _takeweapon(weapon);
}

function domonitoredweaponswitch(weapon, switchimmediate, var_e90b0e794aa74425, canceloffhand) {
  self endon("disconnect");
  self endon("death");

  if(!isDefined(weapon)) {
    return 0;
  }

  debugweaponchangeprint("<dev string:x1c4>", weapon);

  if(!candomonitoredswitchtoweapon(weapon, var_e90b0e794aa74425)) {
    debugweaponchangeprint("<dev string:x1eb>", weapon);

    return 0;
  }

  if(isanymonitoredweaponswitchinprogress()) {
    self clearhighpriorityweapon(getcurrentmonitoredweaponswitchweapon());
  }

  self sethighpriorityweapon(weapon);

  if(switchimmediate) {
    _switchtoweaponimmediate(weapon);
  }

  while(true) {
    if(iscurrentweapon(weapon)) {
      validatehighpriorityflag();

      debugweaponchangeprint("<dev string:x219>", weapon);

      return 1;
    }

    if(!self ishighpriorityweapon(weapon) || !self hasweapon(weapon)) {
      debugweaponchangeprint("<dev string:x242>", weapon);

      return 0;
    }

    if(!val::get("weapon") || !var_e90b0e794aa74425 && !val::get("weapon_switch") && !val::get("script_weapon_switch")) {
      debugweaponchangeprint("<dev string:x287>", weapon);

      self clearhighpriorityweapon(weapon);
      return 0;
    }

    if(canceloffhand && !isnullweapon(self getheldoffhand())) {
      self canceloffhands();
    }

    waitframe();
  }
}

function function_17bee3f2e45888ee() {
  return "iw9_gunless_mp";
}

function function_772803634a9c0f0a() {
  return "iw9_gunless_quickdrop_mp";
}

function givegunlessweapon(switchimmediate) {
  return function_9ecb1e4c6649d1c2(switchimmediate, function_17bee3f2e45888ee());
}

function function_c13571020bd38158(switchimmediate) {
  return function_9ecb1e4c6649d1c2(switchimmediate, function_772803634a9c0f0a());
}

function function_9ecb1e4c6649d1c2(switchimmediate, weaponname) {
  self endon("death_or_disconnect");

  if(!isDefined(weaponname)) {
    return;
  }

  if(isDefined(self.gunnlessweapon)) {
    return;
  }

  gunless = makeweapon(weaponname);
  _giveweapon(gunless, undefined, undefined, 1);
  self.gunnlessweapon = gunless;
  val::reset_all("gunless");
  val::set("gunless", "script_weapon_switch", 1);
  println(self.name + "<dev string:x2bf>");

  if(!isDefined(switchimmediate)) {
    switchimmediate = 0;
  }

  success = domonitoredweaponswitch(gunless, switchimmediate);

  if(!success) {
    _takeweapon(gunless);
    forcevalidweapon();
  }

  val::reset("gunless", "script_weapon_switch");
  println(self.name + "<dev string:x2ea>");
  return success;
}

function takegunlessweapon(restoredweapon) {
  self endon("death_or_disconnect");

  if(!isDefined(self.gunnlessweapon)) {
    return;
  }

  if(!self hasweapon(self.gunnlessweapon)) {
    self.gunnlessweapon = undefined;
    return;
  }

  if(utility::ent_flag_exist("swapLoadout_pending") && utility::ent_flag("swapLoadout_pending")) {
    utility::ent_flag_wait("swapLoadout_complete");
  }

  val::reset_all("gunless");
  val::set("gunless", "script_weapon_switch", 1);
  println(self.name + "<dev string:x315>");

  while(isDefined(self.gunnlessweapon) && self hasweapon(self.gunnlessweapon)) {
    if(!iscurrentweapon(self.gunnlessweapon)) {
      abortmonitoredweaponswitch(self.gunnlessweapon);
    } else {
      _takeweapon(self.gunnlessweapon);

      if(isweapon(restoredweapon)) {
        domonitoredweaponswitch(restoredweapon);

        if(self getcurrentweapon().basename == "none") {
          forcevalidweapon();
        }
      } else {
        forcevalidweapon();
      }
    }

    waitframe();
  }

  self.gunnlessweapon = undefined;
  val::reset("gunless", "script_weapon_switch");
  println(self.name + "<dev string:x340>");
}

function validatehighpriorityflag() {
  currentweapon = self getcurrentweapon();

  if(self ishighpriorityweapon(currentweapon)) {
    self clearhighpriorityweapon(currentweapon);
  }
}

function getridofweapon(weapon, switchimmediate) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self)) {
    return false;
  }

  if(!self hasweapon(weapon)) {
    return false;
  }

  if(!iscurrentweapon(weapon)) {
    _takeweapon(weapon);
    return true;
  }

  while(isanymonitoredweaponswitchinprogress()) {
    waitframe();
  }

  if(!iscurrentweapon(weapon)) {
    _takeweapon(weapon);
    return true;
  }

  lastvalidweapon = self.lastdroppableweaponobj;

  if(utility::issharedfuncdefined(#"weapons", #"isCurrentTertiaryWeapon") && [[utility::getsharedfunc(#"weapons", #"isCurrentTertiaryWeapon")]](self, self.lastnormalweaponobj)) {
    lastvalidweapon = self.lastnormalweaponobj;
  }

  switchresult = domonitoredweaponswitch(lastvalidweapon, switchimmediate);

  if(isbot(self)) {
    self switchtoweaponimmediate(nullweapon());
    switchresult = 1;
  }

  _takeweapon(weapon);
  self notify("bomb_allow_offhands");

  if(!switchresult && !isDefined(self.vehicle)) {
    forcevalidweapon();
  }

  return true;
}

function forcevalidweapon(bestweaponobj) {
  self endon("death");
  self endon("disconnect");

  while(isnullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    var_fdce5d6df27760eb = bestweaponobj;

    if(self.isjuggernaut) {
      var_a3742a26443de44b = "iw9_minigunksjugg_mp";

      if(utility::issharedfuncdefined(#"juggernaut", #"getMinigunWeapon")) {
        var_a3742a26443de44b = self[[utility::getsharedfunc(#"juggernaut", #"getMinigunWeapon")]]();
      }

      if(utility::issharedfuncdefined(#"juggernaut", #"canUseWeaponPickups")) {
        canUseWeaponPickups = self[[utility::getsharedfunc(#"juggernaut", #"canUseWeaponPickups")]]();

        if(canUseWeaponPickups) {
          if(isDefined(self.lastdroppableweaponobj) && self hasweapon(self.lastdroppableweaponobj)) {
            var_a3742a26443de44b = self.lastdroppableweaponobj;
          } else {
            currentprimaries = getcurrentprimaryweaponsminusalt();

            if(currentprimaries.size > 0) {
              var_a3742a26443de44b = currentprimaries[0];
            }
          }
        }
      }

      if(isstring(var_a3742a26443de44b)) {
        var_fdce5d6df27760eb = makeweapon(var_a3742a26443de44b);
      } else {
        var_fdce5d6df27760eb = var_a3742a26443de44b;
      }
    } else {
      currentprimaries = getcurrentprimaryweaponsminusalt();

      if(!isDefined(var_fdce5d6df27760eb) || !self hasweapon(var_fdce5d6df27760eb)) {
        if((!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "none") && !self hasweapon(level.defaultfist)) {
          assertmsg("<dev string:x36b>");
          break;
        }

        if(self hasweapon(self.lastdroppableweaponobj)) {
          var_fdce5d6df27760eb = self.lastdroppableweaponobj;
        } else if(currentprimaries.size > 0) {
          var_fdce5d6df27760eb = currentprimaries[0];
        }
      }

      if(self hasweapon(level.defaultfist)) {
        if(currentprimaries.size == 1) {
          var_fdce5d6df27760eb = currentprimaries[0];
        } else if(currentprimaries.size == 2 && self hasweapon(level.defaultknifestab)) {
          if(weapon::isfistweapon(currentprimaries[0])) {
            var_fdce5d6df27760eb = currentprimaries[0];
          } else {
            var_fdce5d6df27760eb = currentprimaries[1];
          }
        }
      }
    }

    domonitoredweaponswitch(var_fdce5d6df27760eb);
    waitframe();
  }
}

function iscurrentweapon(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);
  return issameweapon(self getcurrentweapon(), weaponobj, 1);
}

function getcurrentprimaryweaponsminusalt() {
  primaryweapons = [];
  currentweapons = self getweaponslistprimaries();

  foreach(weapon in currentweapons) {
    if(!weapon.isalternate) {
      primaryweapons[primaryweapons.size] = weapon;
    }
  }

  return primaryweapons;
}

function debugweaponchangeprint(message, weapon) {
  weaponstring = undefined;

  if(isstring(weapon)) {
    weaponstring = weapon;
  } else {
    weaponstring = getcompleteweaponname(weapon);
  }

  if(getdvarint(@ "hash_e6a5211d6811a3e", 0) != 0) {
    println(message + "<dev string:x3d0>" + weaponstring);
  }
}

# /