/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\utility\inventory.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\juggernaut;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#namespace inventory;

function getlastweapon() {
  assert(isDefined(self.lastnormalweaponobj));
  return self.lastnormalweaponobj;
}

function switchtolastweapon() {
  if(!isai(self)) {
    lastweaponobj = getlastweapon();

    if(scripts\mp\utility\killstreak::isjuggernaut()) {
      lastweaponobj = scripts\mp\juggernaut::jugg_getminigunweapon();
    } else if(!self hasweapon(lastweaponobj)) {
      lastweaponobj = getfirstprimaryweapon();
    }

    if(isDefined(lastweaponobj)) {
      _switchtoweapon(lastweaponobj);
    }

    return;
  }

  _switchtoweapon("none");
}

function getfirstprimaryweapon() {
  weaponslist = self getweaponslistprimaries();

  if(isDefined(self.pers["altStates"]) && weaponslist.size > 0) {
    fullweaponstring = getcompleteweaponname(weaponslist[0]);

    if(istrue(self.pers["altStates"][fullweaponstring])) {
      return weaponslist[0] getaltweapon();
    }
  }

  return weaponslist[0];
}

function registerweaponchangecallback(callbackfunc, isoneshot, var_83d988341d1d6755) {
  data = self.weaponchangecallbacks;

  if(!isDefined(data)) {
    data = spawnStruct();
    self.weaponchangecallbacks = data;
    data.nextid = 1;
    data.nextoneshotid = -1;
    data.callbacks = [];
    data.oneshotcallbacks = [];
    data.persistentcallbacks = [];
  }

  id = undefined;

  if(istrue(isoneshot)) {
    foreach(oneshotcallback in data.oneshotcallbacks) {
      assertex(oneshotcallback != callbackfunc, "<dev string:x1c>");
    }

    id = data.nextoneshotid;
    data.nextoneshotid--;
    data.oneshotcallbacks[id] = callbackfunc;
  } else {
    foreach(othercallback in data.callbacks) {
      assertex(othercallback != callbackfunc, "<dev string:x6a>");
    }

    id = data.nextid;
    data.nextid++;
    data.callbacks[id] = callbackfunc;
  }

  if(istrue(var_83d988341d1d6755)) {
    data.persistentcallbacks[id] = id;
  }

  return id;
}

function unregisterweaponchangecallback(id) {
  data = self.weaponchangecallbacks;
  assert(isDefined(data));

  if(id < 0) {
    data.oneshotcallbacks[id] = undefined;
    return;
  }

  data.callbacks[id] = undefined;
}

function handleweaponchangecallbacksondeath() {
  data = self.weaponchangecallbacks;

  if(!isDefined(data)) {
    return;
  }

  foreach(id, callback in data.callbacks) {
    if(!isDefined(data.persistentcallbacks[id])) {
      data.callbacks[id] = undefined;
    }
  }

  foreach(id, callback in data.oneshotcallbacks) {
    if(!isDefined(data.persistentcallbacks[id])) {
      data.oneshotcallbacks[id] = undefined;
    }
  }
}