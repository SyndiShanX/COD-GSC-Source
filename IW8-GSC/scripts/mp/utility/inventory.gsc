/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\inventory.gsc
***********************************************/

function getlastweapon() {
  return self.lastnormalweaponobj;
}

function switchtolastweapon() {
  if(!isai(self)) {
    var_0 = getlastweapon();

    if(scripts\mp\utility\killstreak::isjuggernaut()) {
      var_0 = getcompleteweaponname(scripts\mp\juggernaut::vehicle_damage_setweaponclassmoddamageforvehicle());
    } else if(!self hasweapon(var_0)) {
      var_0 = getfirstprimaryweapon();
    }

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_0);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
}

function getfirstprimaryweapon() {
  var_0 = self.primaryweapons;
  return var_0[0];
}

function registerweaponchangecallback(var_0, var_1, var_2) {
  var_3 = self.weaponchangecallbacks;

  if(!isDefined(var_3)) {
    var_3 = spawnStruct();
    self.weaponchangecallbacks = var_3;
    var_3.nextid = 1;
    var_3.nextoneshotid = -1;
    var_3.callbacks = [];
    var_3.oneshotcallbacks = [];
    var_3.persistentcallbacks = [];
  }

  var_4 = undefined;

  if(istrue(var_1)) {
    var_4 = var_3.nextoneshotid;
    var_3.nextoneshotid--;
    var_3.oneshotcallbacks[var_4] = var_0;
  } else {
    var_4 = var_3.nextid;
    var_3.nextid++;
    var_3.callbacks[var_4] = var_0;
  }

  if(istrue(var_2)) {
    var_3.persistentcallbacks[var_4] = var_4;
  }

  return var_4;
}

function unregisterweaponchangecallback(var_0) {
  var_1 = self.weaponchangecallbacks;

  if(var_0 < 0) {
    var_1.oneshotcallbacks[var_0] = undefined;
    return;
  }

  var_1.callbacks[var_0] = undefined;
}

function handleweaponchangecallbacksondeath() {
  var_0 = self.weaponchangecallbacks;

  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_3, var_2 in var_0.callbacks) {
    if(!isDefined(var_0.persistentcallbacks[var_3])) {
      var_0.callbacks[var_3] = undefined;
    }
  }

  foreach(var_3, var_2 in var_0.oneshotcallbacks) {
    if(!isDefined(var_0.persistentcallbacks[var_3])) {
      var_0.oneshotcallbacks[var_3] = undefined;
    }
  }
}