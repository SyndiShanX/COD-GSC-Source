/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\inventory.gsc
***********************************************/

function getlastweapon() {
  return self.lastnormalweaponobj;
}

function switchtolastweapon() {
  if(!isai(self)) {
    var0 = getlastweapon();

    if(scripts\mp\utility\killstreak::isjuggernaut()) {
      var0 = getcompleteweaponname(scripts\mp\juggernaut::vehicle_damage_setweaponclassmoddamageforvehicle());
    } else if(!self hasweapon(var0)) {
      var0 = getfirstprimaryweapon();
    }

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var0);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
}

function getfirstprimaryweapon() {
  var0 = self.primaryweapons;
  return var0[0];
}

function registerweaponchangecallback(var0, var1, var2) {
  var3 = self.weaponchangecallbacks;

  if(!isDefined(var3)) {
    var3 = spawnStruct();
    self.weaponchangecallbacks = var3;
    var3.nextid = 1;
    var3.nextoneshotid = -1;
    var3.callbacks = [];
    var3.oneshotcallbacks = [];
    var3.persistentcallbacks = [];
  }

  var4 = undefined;

  if(istrue(var1)) {
    var4 = var3.nextoneshotid;
    var3.nextoneshotid--;
    var3.oneshotcallbacks[var4] = var0;
  } else {
    var4 = var3.nextid;
    var3.nextid++;
    var3.callbacks[var4] = var0;
  }

  if(istrue(var2)) {
    var3.persistentcallbacks[var4] = var4;
  }

  return var4;
}

function unregisterweaponchangecallback(var0) {
  var1 = self.weaponchangecallbacks;

  if(var0 < 0) {
    var1.oneshotcallbacks[var0] = undefined;
    return;
  }

  var1.callbacks[var0] = undefined;
}

function handleweaponchangecallbacksondeath() {
  var0 = self.weaponchangecallbacks;

  if(!isDefined(var0)) {
    return;
  }

  foreach(var3, var2 in var0.callbacks) {
    if(!isDefined(var0.persistentcallbacks[var3])) {
      var0.callbacks[var3] = undefined;
    }
  }

  foreach(var3, var2 in var0.oneshotcallbacks) {
    if(!isDefined(var0.persistentcallbacks[var3])) {
      var0.oneshotcallbacks[var3] = undefined;
    }
  }
}