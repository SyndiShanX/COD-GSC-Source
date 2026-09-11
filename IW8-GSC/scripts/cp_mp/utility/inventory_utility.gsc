/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\inventory_utility.gsc
*******************************************************/

function _giveweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self giveweapon(var_0, var_1, istrue(var_2), -1, var_3);
}

function _switchtoweapon(var_0) {
  self switchtoweapon(var_0);
}

function _switchtoweaponimmediate(var_0) {
  self switchtoweaponimmediate(var_0);
}

function _takeweapon(var_0, var_1) {
  var_2 = 0;

  if(issameweapon(var_0)) {
    var_2 = self gethighpriorityweapon() == var_0;
  } else {
    var_2 = createheadicon(self gethighpriorityweapon()) == var_0;
  }

  if(var_2) {
    var_3 = var_0;

    if(!isstring(var_3) && issameweapon(var_0)) {
      var_3 = createheadicon(var_0);
    }

    self clearhighpriorityweapon(var_0);
  }

  self takeweapon(var_0);
}

function takeweaponwhensafe(var_0) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_1 = 0;

    if(!iscurrentweapon(var_0)) {
      var_2 = self getweaponmeleeslot();

      if(!nullweapon(var_2) && self.currentweapon == var_2) {
        var_1 = 0;
      } else {
        var_1 = 1;
      }
    }

    if(var_1) {
      break;
    }

    waitframe();
  }

  _takeweapon(var_0);
}

function getcurrentmonitoredweaponswitchweapon() {
  validatehighpriorityflag();
  var_0 = self gethighpriorityweapon();

  if(nullweapon(var_0)) {
    return undefined;
  }

  return var_0;
}

function isanymonitoredweaponswitchinprogress() {
  return isDefined(getcurrentmonitoredweaponswitchweapon());
}

function isswitchingtoweaponwithmonitoring(var_0) {
  if(isstring(var_0)) {
    var_0 = asmdevgetallstates(var_0);
  }

  var_1 = getcurrentmonitoredweaponswitchweapon();
  return isDefined(var_1) && var_1 == var_0 && !iscurrentweapon(var_0);
}

function candomonitoredswitchtoweapon(var_0, var_1) {
  if(!self hasweapon(var_0)) {
    return false;
  }

  if(!scripts\common\utility::is_weapon_allowed()) {
    return false;
  }

  if(!istrue(var_1) && !scripts\common\utility::is_weapon_switch_allowed() && !scripts\common\utility::is_script_weapon_switch_allowed()) {
    return false;
  }

  var_2 = getcurrentmonitoredweaponswitchweapon();

  if(isDefined(var_2)) {
    var_3 = getweaponbasename(var_0);
    var_4 = 0;

    if(var_3 == "briefcase_bomb_mp" || var_3 == "briefcase_bomb_defuse_mp" || var_3 == "iw8_cyberemp_mp" || var_3 == "iw7_tdefball_mp") {
      var_4 = 1;
    } else if(weaponinventorytype(var_2) == "primary") {
      var_4 = 1;
    }

    if(!var_4) {
      return false;
    }
  }

  if(iscurrentweapon(var_0)) {
    return false;
  }

  return true;
}

function abortmonitoredweaponswitch(var_0) {
  if(self gethighpriorityweapon() == var_0) {
    self clearhighpriorityweapon(var_0);
  }

  _takeweapon(var_0);
}

function domonitoredweaponswitch(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("death");

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!candomonitoredswitchtoweapon(var_0, var_2)) {
    return 0;
  }

  if(isanymonitoredweaponswitchinprogress()) {
    self clearhighpriorityweapon(getcurrentmonitoredweaponswitchweapon());
  }

  self sethighpriorityweapon(var_0);

  if(istrue(var_1)) {
    _switchtoweaponimmediate(var_0);
  }

  for(;;) {
    if(iscurrentweapon(var_0)) {
      validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(var_0) || !self hasweapon(var_0)) {
      return 0;
    }

    if(!scripts\common\utility::is_weapon_allowed() || !istrue(var_2) && !scripts\common\utility::is_weapon_switch_allowed() && !scripts\common\utility::is_script_weapon_switch_allowed()) {
      self clearhighpriorityweapon(var_0);
      return 0;
    }

    waitframe();
  }
}

function validatehighpriorityflag() {
  var_0 = self getcurrentweapon();

  if(self ishighpriorityweapon(var_0)) {
    self clearhighpriorityweapon(var_0);
    return;
  }
}

function getridofweapon(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(!self hasweapon(var_0)) {
    return false;
  }

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return true;
  }

  while(isanymonitoredweaponswitchinprogress()) {
    waitframe();
  }

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return true;
  }

  var_2 = domonitoredweaponswitch(self.lastdroppableweaponobj, var_1);

  if(isbot(self)) {
    self switchtoweaponimmediate(isundefinedweapon());
    var_2 = 1;
  }

  _takeweapon(var_0);
  self notify("bomb_allow_offhands");

  if(!var_2) {
    forcevalidweapon();
  }

  return true;
}

function forcevalidweapon(var_0) {
  self endon("death");
  self endon("disconnect");

  while(nullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    var_1 = var_0;

    if(istrue(self.isjuggernaut)) {
      var_2 = "iw8_minigunksjugg_mp";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "getMinigunWeapon")) {
        var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "getMinigunWeapon")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(istrue(var_3)) {
          if(isDefined(self.lastdroppableweaponobj) && self hasweapon(self.lastdroppableweaponobj)) {
            var_2 = self.lastdroppableweaponobj;
          } else {
            var_4 = getcurrentprimaryweaponsminusalt();

            if(var_4.size > 0) {
              var_2 = var_4[0];
            }
          }
        }
      }

      var_1 = getcompleteweaponname(var_2);
    } else {
      var_4 = getcurrentprimaryweaponsminusalt();

      if(!isDefined(var_1) || !self hasweapon(var_1)) {
        if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "none") {
          break;
        }

        if(self hasweapon(self.lastdroppableweaponobj)) {
          var_0 = self.lastdroppableweaponobj;
        } else if(var_1.size > 0) {
          var_0 = var_1[0];
        }
      }

      if(isDefined(var_0) && getweaponbasename(var_0) == "iw7_axe_mp" && self getweaponammoclip(var_0) == 0 && var_1.size == 1) {
        var_0.basename = "iw8_fists_mp";
      } else if(self hasweapon("iw8_fists_mp")) {
        if(var_1.size == 1) {
          var_0 = var_1[0];
        } else if(var_1.size == 2 && (self hasweapon("iw8_knifestab_mp") || self hasweapon("iw8_throwingknife_fire_melee_mp") || self hasweapon("iw8_throwingknife_electric_melee_mp") || self hasweapon("iw8_throwingknife_drill_melee_mp"))) {
          if(var_1[0].basename == "iw8_fists_mp") {
            var_0 = var_1[0];
          } else {
            var_0 = var_1[1];
          }
        }
      }
    }

    domonitoredweaponswitch(var_0);
    waitframe();
  }
}

function iscurrentweapon(var_0) {
  if(isstring(var_0)) {
    var_0 = asmdevgetallstates(var_0);
  }

  return isnullweapon(self getcurrentweapon(), var_0, 1);
}

function getcurrentprimaryweaponsminusalt() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(!var_3.isalternate) {
      var_0 = var_3;
    }
  }

  return var_0;
}