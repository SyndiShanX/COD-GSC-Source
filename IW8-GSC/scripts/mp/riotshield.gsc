/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\riotshield.gsc
***********************************************/

function isriotshield(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0)) {
    return false;
  }

  if(isstring(var_0) && var_0 == "none") {
    return false;
  }

  return weapontype(var_0) == "riotshield";
}

function riotshield_hasweapon() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(isriotshield(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

function riotshield_hastwo() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(isriotshield(var_3)) {
      var_0++;
    }

    if(var_0 == 2) {
      break;
    }
  }

  return var_0 == 2;
}

function riotshield_attach(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self.riotshieldmodel = var_1;
    var_2 = "j_shield_ri";
  } else {
    self.riotshieldmodelstowed = var_1;
    var_2 = "tag_shield_back";
  }

  self attachshieldmodel(var_1, var_2, 0, !var_0);
  self.hasriotshield = riotshield_hasweapon();
}

function riotshield_detach(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0) {
    var_1 = self.riotshieldmodel;
    var_2 = "j_shield_ri";
  } else {
    var_1 = self.riotshieldmodelstowed;
    var_2 = "tag_shield_back";
  }

  self detachshieldmodel(var_1, var_2);

  if(var_0) {
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodelstowed = undefined;
  }

  self.hasriotshield = riotshield_hasweapon();
}

function riotshield_move(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(var_0) {
    var_3 = self.riotshieldmodel;
    var_1 = "j_shield_ri";
    var_2 = "tag_shield_back";
  } else {
    var_3 = self.riotshieldmodelstowed;
    var_1 = "tag_shield_back";
    var_2 = "j_shield_ri";
  }

  self moveshieldmodel(var_3, var_1, var_2, var_0);

  if(var_0) {
    self.riotshieldmodelstowed = var_3;
    self.riotshieldmodel = undefined;
    return;
  }

  self.riotshieldmodel = var_3;
  self.riotshieldmodelstowed = undefined;
}

function riotshield_clear() {
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

function riotshield_getmodel() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(isriotshield(var_2)) {
      var_3 = getweaponmodel(var_2);

      if(var_3 != "") {
        return var_3;
      }
    }
  }
}

function setignoreriotshieldxp() {
  self.ignoreriotshieldxp = 1;
}

function clearignoreriotshieldxp() {
  self.ignoreriotshieldxp = undefined;
}