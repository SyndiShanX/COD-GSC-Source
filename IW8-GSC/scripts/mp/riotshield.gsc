/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\riotshield.gsc
***********************************************/

function isriotshield(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return false;
  }

  if(isstring(var0) && var0 == "none") {
    return false;
  }

  return weapontype(var0) == "riotshield";
}

function riotshield_hasweapon() {
  var0 = 0;
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    if(isriotshield(var3)) {
      var0 = 1;
      break;
    }
  }

  return var0;
}

function riotshield_hastwo() {
  var0 = 0;
  var1 = self getweaponslistprimaries();

  foreach(var3 in var1) {
    if(isriotshield(var3)) {
      var0++;
    }

    if(var0 == 2) {
      break;
    }
  }

  return var0 == 2;
}

function riotshield_attach(var0, var1) {
  var2 = undefined;

  if(var0) {
    self.riotshieldmodel = var1;
    var2 = "j_shield_ri";
  } else {
    self.riotshieldmodelstowed = var1;
    var2 = "tag_shield_back";
  }

  self attachshieldmodel(var1, var2, 0, !var0);
  self.hasriotshield = riotshield_hasweapon();
}

function riotshield_detach(var0) {
  var1 = undefined;
  var2 = undefined;

  if(var0) {
    var1 = self.riotshieldmodel;
    var2 = "j_shield_ri";
  } else {
    var1 = self.riotshieldmodelstowed;
    var2 = "tag_shield_back";
  }

  self detachshieldmodel(var1, var2);

  if(var0) {
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodelstowed = undefined;
  }

  self.hasriotshield = riotshield_hasweapon();
}

function riotshield_move(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;

  if(var0) {
    var3 = self.riotshieldmodel;
    var1 = "j_shield_ri";
    var2 = "tag_shield_back";
  } else {
    var3 = self.riotshieldmodelstowed;
    var1 = "tag_shield_back";
    var2 = "j_shield_ri";
  }

  self moveshieldmodel(var3, var1, var2, var0);

  if(var0) {
    self.riotshieldmodelstowed = var3;
    self.riotshieldmodel = undefined;
    return;
  }

  self.riotshieldmodel = var3;
  self.riotshieldmodelstowed = undefined;
}

function riotshield_clear() {
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

function riotshield_getmodel() {
  var0 = self getweaponslistprimaries();

  foreach(var2 in var0) {
    if(isriotshield(var2)) {
      var3 = getweaponmodel(var2);

      if(var3 != "") {
        return var3;
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