/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_232f31def1450dbb.gsc
*****************************************************/

#using scripts\common\values;
#using scripts\engine\utility;
#namespace namespace_ce85794d215160e3;

function _giveweapon(weapon, variant, dualwieldoverride, usedbefore) {
  if(!isDefined(variant)) {
    variant = -1;
  }

  if(!isDefined(usedbefore)) {
    usedbefore = 0;
  }

  self giveweapon(weapon, variant, istrue(dualwieldoverride), -1, usedbefore);
}

function _switchtoweapon(weapon) {
  debugweaponchangeprint("<dev string:x24>", weapon);

  self switchtoweapon(weapon);
}

function _switchtoweaponimmediate(weapon) {
  debugweaponchangeprint("<dev string:x3c>", weapon);

  self switchtoweaponimmediate(weapon);
}

function _takeweapon(weapon) {
  if(getdvarint(@ "hash_e6a5211d6811a3e", 0) != 0) {
    debugweaponchangeprint("<dev string:x5d>", weapon);

    if(iscurrentweapon(weapon)) {
      println("<dev string:x71>");
    }
  }

  var_bca1975f71794268 = 0;

  if(isweapon(weapon)) {
    var_bca1975f71794268 = self gethighpriorityweapon() == weapon;
  } else {
    assert(isstring(weapon));
    var_bca1975f71794268 = getcompleteweaponname(self gethighpriorityweapon()) == weapon;
  }

  if(var_bca1975f71794268) {
    weaponstring = weapon;

    if(!isstring(weaponstring) && isweapon(weapon)) {
      weaponstring = getcompleteweaponname(weapon);
    }

    assertmsg("<dev string:x90>" + weaponstring + "<dev string:xd7>");
    self clearhighpriorityweapon(weapon);
  }

  self takeweapon(weapon);
}

function takeweaponwhensafe(weapon) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  while(true) {
    var_a34d4701a8b1c17f = 0;

    if(!iscurrentweapon(weapon)) {
      meleeoverrideweapon = self getweaponmeleeslot();

      if(!isnullweapon(meleeoverrideweapon) && self.currentweapon == meleeoverrideweapon) {
        var_a34d4701a8b1c17f = 0;
      } else {
        var_a34d4701a8b1c17f = 1;
      }
    }

    if(var_a34d4701a8b1c17f) {
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
  weaponobj = utility::function_3aac010105913843(weapon);
  currentswitchweapon = getcurrentmonitoredweaponswitchweapon();
  return isDefined(currentswitchweapon) && isDefined(weaponobj) && currentswitchweapon == weaponobj && !iscurrentweapon(weaponobj);
}

function candomonitoredswitchtoweapon(weapon, var_2bfd2b499935cc27) {
  if(!self hasweapon(weapon)) {
    return false;
  }

  if(!val::get("\xe5\x06\xb0\bE\x16")) {
    return false;
  }

  if(!istrue(var_2bfd2b499935cc27) && !val::get("\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e") && !val::get("\xf0\xd5j\v\x0f\xa7\x1e|\xca\xd9I\x92\xce\xda#E\xff\x1b\xe8X")) {
    return false;
  }

  currenthighpriorityweapon = getcurrentmonitoredweaponswitchweapon();

  if(isDefined(currenthighpriorityweapon)) {
    weaponbasename = getweaponbasename(weapon);
    newweaponhaspriority = 0;

    if(weaponinventorytype(currenthighpriorityweapon) == "\xe6\xaa6=\x93`Y") {
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
  debugweaponchangeprint("<dev string:xf8>", weapon);

  assert(!iscurrentweapon(weapon), "<dev string:x105>");

  if(self gethighpriorityweapon() == weapon) {
    self clearhighpriorityweapon(weapon);
  }

  _takeweapon(weapon);
}

function domonitoredweaponswitch(weapon, switchimmediate, var_2bfd2b499935cc27) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(weapon)) {
    return 0;
  }

  debugweaponchangeprint("<dev string:x152>", weapon);

  if(!candomonitoredswitchtoweapon(weapon, var_2bfd2b499935cc27)) {
    debugweaponchangeprint("<dev string:x179>", weapon);

    return 0;
  }

  if(isanymonitoredweaponswitchinprogress()) {
    self clearhighpriorityweapon(getcurrentmonitoredweaponswitchweapon());
  }

  self sethighpriorityweapon(weapon);

  if(istrue(switchimmediate)) {
    _switchtoweaponimmediate(weapon);
  }

  while(true) {
    if(iscurrentweapon(weapon)) {
      validatehighpriorityflag();

      debugweaponchangeprint("<dev string:x1a7>", weapon);

      return 1;
    }

    if(!self ishighpriorityweapon(weapon) || !self hasweapon(weapon)) {
      debugweaponchangeprint("<dev string:x1d0>", weapon);

      return 0;
    }

    if(!val::get("\xe5\x06\xb0\bE\x16") || !istrue(var_2bfd2b499935cc27) && !val::get("\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e") && !val::get("\xf0\xd5j\v\x0f\xa7\x1e|\xca\xd9I\x92\xce\xda#E\xff\x1b\xe8X")) {
      debugweaponchangeprint("<dev string:x215>", weapon);

      self clearhighpriorityweapon(weapon);
      return 0;
    }

    waitframe();
  }
}

function function_fcde8c257916f4c4() {
  return "@\xdf\":9\xc6\x1c3\xe0\xf9k\x91\f\x1e";
}

function function_f562168081bb972e() {
  return "Zw\x93_\xec]\x9b\xb1+\x9b\xcd\xf5\xc5\xea\xa5\xc6m\x91'\xde\x83\xf5m\xc1";
}

function givegunlessweapon(switchimmediate) {
  return function_23bec485f450e558(switchimmediate, function_fcde8c257916f4c4());
}

function function_7134bd6d55e592f2(switchimmediate) {
  return function_23bec485f450e558(switchimmediate, function_f562168081bb972e());
}

function function_23bec485f450e558(switchimmediate, weaponname) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(!isDefined(weaponname)) {
    return;
  }

  if(isDefined(self.gunnlessweapon)) {
    return;
  }

  gunless = makeweapon(weaponname);
  _giveweapon(gunless, undefined, undefined, 1);
  val::reset_all("7X\xf8\xf4;K\xa7");
  val::set("7X\xf8\xf4;K\xa7", "\xf0\xd5j\v\x0f\xa7\x1e|\xca\xd9I\x92\xce\xda#E\xff\x1b\xe8X", 1);
  println(self.name + "<dev string:x24d>");

  if(!isDefined(switchimmediate)) {
    switchimmediate = 0;
  }

  success = domonitoredweaponswitch(gunless, switchimmediate);

  if(success) {
    self.gunnlessweapon = gunless;
  } else {
    _takeweapon(gunless);
    forcevalidweapon();
  }

  val::set("7X\xf8\xf4;K\xa7", "\xf0\xd5j\v\x0f\xa7\x1e|\xca\xd9I\x92\xce\xda#E\xff\x1b\xe8X", 0);
  println(self.name + "<dev string:x278>");
  return success;
}

function takegunlessweapon() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }

  if(utility::ent_flag_exist("\xc2U\x1a\x19/(a\x82\x13\xadu\x1e\x8c\xe5f\xab\x03\xcc\xfb") && utility::ent_flag("\xc2U\x1a\x19/(a\x82\x13\xadu\x1e\x8c\xe5f\xab\x03\xcc\xfb")) {
    utility::ent_flag_wait("\x8a\t+\x86\xfa\xe0\x15\xfc1\nv|f-.Jm\xed\xe8\xef");
  }

  val::reset_all("7X\xf8\xf4;K\xa7");
  val::set("7X\xf8\xf4;K\xa7", "\xf0\xd5j\v\x0f\xa7\x1e|\xca\xd9I\x92\xce\xda#E\xff\x1b\xe8X", 1);
  println(self.name + "<dev string:x2a3>");

  while(self hasweapon(self.gunnlessweapon)) {
    if(!iscurrentweapon(self.gunnlessweapon)) {
      abortmonitoredweaponswitch(self.gunnlessweapon);
    } else {
      _takeweapon(self.gunnlessweapon);
      forcevalidweapon();
    }

    waitframe();
  }

  self.gunnlessweapon = undefined;
  val::set("7X\xf8\xf4;K\xa7", "\xf0\xd5j\v\x0f\xa7\x1e|\xca\xd9I\x92\xce\xda#E\xff\x1b\xe8X", 0);
  println(self.name + "<dev string:x2ce>");
}

function validatehighpriorityflag() {
  currentweapon = self getcurrentweapon();

  if(self ishighpriorityweapon(currentweapon)) {
    self clearhighpriorityweapon(currentweapon);
  }
}

function getridofweapon(weapon, switchimmediate) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

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

  switchresult = domonitoredweaponswitch(self.lastdroppableweaponobj, switchimmediate);

  if(isbot(self)) {
    self switchtoweaponimmediate(nullweapon());
    switchresult = 1;
  }

  _takeweapon(weapon);
  self notify("3)g\x1bTY\x88,\x18\x94\xae\x94\vG5\x7f\xc3\x02\x1f");

  if(!switchresult) {
    forcevalidweapon();
  }

  return true;
}

function forcevalidweapon(bestweaponobj) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  while(isnullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    var_44b51d8a5e58ac3f = bestweaponobj;

    if(istrue(self.isjuggernaut)) {
      var_32a462ea124fe59f = "\xd2w\x93\xf5\xb5\x96\x9b\xd2g\xae7\xb6\xe6j\xbag;\xaf\xad8";

      if(utility::issharedfuncdefined(#"juggernaut", #"getMinigunWeapon")) {
        var_32a462ea124fe59f = self[[utility::getsharedfunc(#"juggernaut", #"getMinigunWeapon")]]();
      }

      if(utility::issharedfuncdefined(#"juggernaut", #"canUseWeaponPickups")) {
        canuseweaponpickups = self[[utility::getsharedfunc(#"juggernaut", #"canUseWeaponPickups")]]();

        if(istrue(canuseweaponpickups)) {
          if(isDefined(self.lastdroppableweaponobj) && self hasweapon(self.lastdroppableweaponobj)) {
            var_32a462ea124fe59f = self.lastdroppableweaponobj;
          } else {
            currentprimaries = getcurrentprimaryweaponsminusalt();

            if(currentprimaries.size > 0) {
              var_32a462ea124fe59f = currentprimaries[0];
            }
          }
        }
      }

      if(isstring(var_32a462ea124fe59f)) {
        var_44b51d8a5e58ac3f = makeweapon(var_32a462ea124fe59f);
      } else {
        var_44b51d8a5e58ac3f = var_32a462ea124fe59f;
      }
    } else {
      currentprimaries = getcurrentprimaryweaponsminusalt();

      if(!isDefined(var_44b51d8a5e58ac3f) || !self hasweapon(var_44b51d8a5e58ac3f)) {
        if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "\r+x5") {
          assertmsg("<dev string:x2f9>");
          break;
        }

        if(self hasweapon(self.lastdroppableweaponobj)) {
          var_44b51d8a5e58ac3f = self.lastdroppableweaponobj;
        } else if(currentprimaries.size > 0) {
          var_44b51d8a5e58ac3f = currentprimaries[0];
        }
      }

      if(weaponexists("\x8e\x97\x90cn\xe3\x7f\x88\x81xe") && self hasweapon("\x8e\x97\x90cn\xe3\x7f\x88\x81xe")) {
        if(currentprimaries.size == 1) {
          var_44b51d8a5e58ac3f = currentprimaries[0];
        } else if(currentprimaries.size == 2 && (self hasweapon("=W8\x81p\f\xb8~\xd0\xb0@\xd36}\xb1\x98") || self hasweapon("t\xeb\xbf\x8dc:\xd0\f\xbd\x13\xd8\x88A\xa2\xfdIf\xbb\xd37\r\xd3\xe6\x05&\xb5[\f\xa2/\xc1") || self hasweapon("\xb3\x9a\xf0n\xc2\x8e\xec\x04\x86\xf8c\x1a\xcb\xa5>H\xb6H\x95B\x88\xf2\r\x8eA\xe3\xed\x8bf\x86?Z\x1aPg"))) {
          if(currentprimaries[0].basename == "\x8e\x97\x90cn\xe3\x7f\x88\x81xe") {
            var_44b51d8a5e58ac3f = currentprimaries[0];
          } else {
            var_44b51d8a5e58ac3f = currentprimaries[1];
          }
        }
      }
    }

    domonitoredweaponswitch(var_44b51d8a5e58ac3f);
    waitframe();
  }
}

function iscurrentweapon(weapon) {
  weaponobj = utility::function_3aac010105913843(weapon);
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
    println(message + "<dev string:x35e>" + weaponstring);
  }
}

# /