/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\inventory_utility.gsc
*******************************************************/

function _giveweapon(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = -1;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  self giveweapon(var0, var1, istrue(var2), -1, var3);
}

function _switchtoweapon(var0) {
  self switchtoweapon(var0);
}

function _switchtoweaponimmediate(var0) {
  self switchtoweaponimmediate(var0);
}

function _takeweapon(var0, var1) {
  var2 = 0;

  if(issameweapon(var0)) {
    var2 = self gethighpriorityweapon() == var0;
  } else {
    var2 = createheadicon(self gethighpriorityweapon()) == var0;
  }

  if(var2) {
    var3 = var0;

    if(!isstring(var3) && issameweapon(var0)) {
      var3 = createheadicon(var0);
    }

    self clearhighpriorityweapon(var0);
  }

  self takeweapon(var0);
}

function takeweaponwhensafe(var0) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var1 = 0;

    if(!iscurrentweapon(var0)) {
      var2 = self getweaponmeleeslot();

      if(!nullweapon(var2) && self.currentweapon == var2) {
        var1 = 0;
      } else {
        var1 = 1;
      }
    }

    if(var1) {
      break;
    }

    waitframe();
  }

  _takeweapon(var0);
}

function getcurrentmonitoredweaponswitchweapon() {
  validatehighpriorityflag();
  var0 = self gethighpriorityweapon();

  if(nullweapon(var0)) {
    return undefined;
  }

  return var0;
}

function isanymonitoredweaponswitchinprogress() {
  return isDefined(getcurrentmonitoredweaponswitchweapon());
}

function isswitchingtoweaponwithmonitoring(var0) {
  if(isstring(var0)) {
    var0 = asmdevgetallstates(var0);
  }

  var1 = getcurrentmonitoredweaponswitchweapon();
  return isDefined(var1) && var1 == var0 && !iscurrentweapon(var0);
}

function candomonitoredswitchtoweapon(var0, var1) {
  if(!self hasweapon(var0)) {
    return false;
  }

  if(!scripts\common\utility::is_weapon_allowed()) {
    return false;
  }

  if(!istrue(var1) && !scripts\common\utility::is_weapon_switch_allowed() && !scripts\common\utility::is_script_weapon_switch_allowed()) {
    return false;
  }

  var2 = getcurrentmonitoredweaponswitchweapon();

  if(isDefined(var2)) {
    var3 = getweaponbasename(var0);
    var4 = 0;

    if(var3 == "briefcase_bomb_mp" || var3 == "briefcase_bomb_defuse_mp" || var3 == "iw8_cyberemp_mp" || var3 == "iw7_tdefball_mp") {
      var4 = 1;
    } else if(weaponinventorytype(var2) == "primary") {
      var4 = 1;
    }

    if(!var4) {
      return false;
    }
  }

  if(iscurrentweapon(var0)) {
    return false;
  }

  return true;
}

function abortmonitoredweaponswitch(var0) {
  if(self gethighpriorityweapon() == var0) {
    self clearhighpriorityweapon(var0);
  }

  _takeweapon(var0);
}

function domonitoredweaponswitch(var0, var1, var2) {
  self endon("disconnect");
  self endon("death");

  if(!isDefined(var0)) {
    return 0;
  }

  if(!candomonitoredswitchtoweapon(var0, var2)) {
    return 0;
  }

  if(isanymonitoredweaponswitchinprogress()) {
    self clearhighpriorityweapon(getcurrentmonitoredweaponswitchweapon());
  }

  self sethighpriorityweapon(var0);

  if(istrue(var1)) {
    _switchtoweaponimmediate(var0);
  }

  for(;;) {
    if(iscurrentweapon(var0)) {
      validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(var0) || !self hasweapon(var0)) {
      return 0;
    }

    if(!scripts\common\utility::is_weapon_allowed() || !istrue(var2) && !scripts\common\utility::is_weapon_switch_allowed() && !scripts\common\utility::is_script_weapon_switch_allowed()) {
      self clearhighpriorityweapon(var0);
      return 0;
    }

    waitframe();
  }
}

function validatehighpriorityflag() {
  var0 = self getcurrentweapon();

  if(self ishighpriorityweapon(var0)) {
    self clearhighpriorityweapon(var0);
    return;
  }
}

function getridofweapon(var0, var1) {
  self endon("death");
  self endon("disconnect");

  if(!self hasweapon(var0)) {
    return false;
  }

  if(!iscurrentweapon(var0)) {
    _takeweapon(var0);
    return true;
  }

  while(isanymonitoredweaponswitchinprogress()) {
    waitframe();
  }

  if(!iscurrentweapon(var0)) {
    _takeweapon(var0);
    return true;
  }

  var2 = domonitoredweaponswitch(self.lastdroppableweaponobj, var1);

  if(isbot(self)) {
    self switchtoweaponimmediate(isundefinedweapon());
    var2 = 1;
  }

  _takeweapon(var0);
  self notify("bomb_allow_offhands");

  if(!var2) {
    forcevalidweapon();
  }

  return true;
}

function forcevalidweapon(var0) {
  self endon("death");
  self endon("disconnect");

  while(nullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    var1 = var0;

    if(istrue(self.isjuggernaut)) {
      var2 = "iw8_minigunksjugg_mp";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "getMinigunWeapon")) {
        var2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "getMinigunWeapon")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(istrue(var3)) {
          if(isDefined(self.lastdroppableweaponobj) && self hasweapon(self.lastdroppableweaponobj)) {
            var2 = self.lastdroppableweaponobj;
          } else {
            var4 = getcurrentprimaryweaponsminusalt();

            if(var4.size > 0) {
              var2 = var4[0];
            }
          }
        }
      }

      var1 = getcompleteweaponname(var2);
    } else {
      var4 = getcurrentprimaryweaponsminusalt();

      if(!isDefined(var1) || !self hasweapon(var1)) {
        if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "none") {
          break;
        }

        if(self hasweapon(self.lastdroppableweaponobj)) {
          var0 = self.lastdroppableweaponobj;
        } else if(var1.size > 0) {
          var0 = var1[0];
        }
      }

      if(isDefined(var0) && getweaponbasename(var0) == "iw7_axe_mp" && self getweaponammoclip(var0) == 0 && var1.size == 1) {
        var0.basename = "iw8_fists_mp";
      } else if(self hasweapon("iw8_fists_mp")) {
        if(var1.size == 1) {
          var0 = var1[0];
        } else if(var1.size == 2 && (self hasweapon("iw8_knifestab_mp") || self hasweapon("iw8_throwingknife_fire_melee_mp") || self hasweapon("iw8_throwingknife_electric_melee_mp") || self hasweapon("iw8_throwingknife_drill_melee_mp"))) {
          if(var1[0].basename == "iw8_fists_mp") {
            var0 = var1[0];
          } else {
            var0 = var1[1];
          }
        }
      }
    }

    domonitoredweaponswitch(var0);
    waitframe();
  }
}

function iscurrentweapon(var0) {
  if(isstring(var0)) {
    var0 = asmdevgetallstates(var0);
  }

  return isnullweapon(self getcurrentweapon(), var0, 1);
}

function getcurrentprimaryweaponsminusalt() {
  var0 = [];
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    if(!var3.isalternate) {
      var0 = var3;
    }
  }

  return var0;
}