/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\inventory.gsc
***********************************************/

getlastweapon() {
  return self.lastnormalweaponobj;
}

switchtolastweapon() {
  if(!isai(self)) {
    lastweaponobj = getlastweapon();

    if(scripts\mp\utility\killstreak::isjuggernaut())
      lastweaponobj = scripts\mp\juggernaut::jugg_getminigunweapon();
    else if(!self hasweapon(lastweaponobj))
      lastweaponobj = getfirstprimaryweapon();

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(lastweaponobj);
  } else
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
}

getfirstprimaryweapon() {
  _id_8CAC01EF5BCB1816 = self getweaponslistprimaries();

  if(isDefined(self.pers["altStates"]) && _id_8CAC01EF5BCB1816.size > 0) {
    _id_366B0ECC2F28AEAD = getcompleteweaponname(_id_8CAC01EF5BCB1816[0]);

    if(istrue(self.pers["altStates"][_id_366B0ECC2F28AEAD]))
      return _id_8CAC01EF5BCB1816[0] getaltweapon();
  }

  return _id_8CAC01EF5BCB1816[0];
}

registerweaponchangecallback(_id_847D2A046CAA4B54, _id_342B4A7404FD91AB, _id_83D988341D1D6755) {
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

  if(istrue(_id_342B4A7404FD91AB)) {
    id = data.nextoneshotid;
    data.nextoneshotid--;
    data.oneshotcallbacks[id] = _id_847D2A046CAA4B54;
  } else {
    id = data.nextid;
    data.nextid++;
    data.callbacks[id] = _id_847D2A046CAA4B54;
  }

  if(istrue(_id_83D988341D1D6755))
    data.persistentcallbacks[id] = id;

  return id;
}

unregisterweaponchangecallback(id) {
  data = self.weaponchangecallbacks;

  if(id < 0)
    data.oneshotcallbacks[id] = undefined;
  else
    data.callbacks[id] = undefined;
}

handleweaponchangecallbacksondeath() {
  data = self.weaponchangecallbacks;

  if(!isDefined(data)) {
    return;
  }
  foreach(id, callback in data.callbacks) {
    if(!isDefined(data.persistentcallbacks[id]))
      data.callbacks[id] = undefined;
  }

  foreach(id, callback in data.oneshotcallbacks) {
    if(!isDefined(data.persistentcallbacks[id]))
      data.oneshotcallbacks[id] = undefined;
  }
}