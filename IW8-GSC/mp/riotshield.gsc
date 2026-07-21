/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\riotshield.gsc
***********************************************/

isriotshield(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return 0;

  if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  return weapontype(var_0) == "_encstr_A5450BC280BF4B604068C33187";
}

riotshield_hasweapon() {
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

riotshield_hastwo() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(isriotshield(var_3))
      var_0++;

    if(var_0 == 2) {
      break;
    }
  }

  return var_0 == 2;
}

riotshield_attach(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self.riotshieldmodel = var_1;
    var_2 = "_encstr_BE860CEA7128332BDB0821C70301";
  } else {
    self.riotshieldmodelstowed = var_1;
    var_2 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
  }

  self attachshieldmodel(var_1, var_2, 0, !var_0);
  self.hasriotshield = riotshield_hasweapon();
}

riotshield_detach(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0) {
    var_1 = self.riotshieldmodel;
    var_2 = "_encstr_BE860CEA7128332BDB0821C70301";
  } else {
    var_1 = self.riotshieldmodelstowed;
    var_2 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
  }

  self detachshieldmodel(var_1, var_2);

  if(var_0)
    self.riotshieldmodel = undefined;
  else
    self.riotshieldmodelstowed = undefined;

  self.hasriotshield = riotshield_hasweapon();
}

riotshield_move(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(var_0) {
    var_3 = self.riotshieldmodel;
    var_1 = "_encstr_BE860CEA7128332BDB0821C70301";
    var_2 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
  } else {
    var_3 = self.riotshieldmodelstowed;
    var_1 = "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC";
    var_2 = "_encstr_BE860CEA7128332BDB0821C70301";
  }

  self moveshieldmodel(var_3, var_1, var_2, var_0);

  if(var_0) {
    self.riotshieldmodelstowed = var_3;
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodel = var_3;
    self.riotshieldmodelstowed = undefined;
  }
}

riotshield_clear() {
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

riotshield_getmodel() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(isriotshield(var_2)) {
      var_3 = getweaponmodel(var_2);

      if(var_3 != "_encstr_B40101")
        return var_3;
    }
  }
}

setignoreriotshieldxp() {
  self.ignoreriotshieldxp = 1;
}

clearignoreriotshieldxp() {
  self.ignoreriotshieldxp = undefined;
}