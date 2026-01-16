/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2582.gsc
*********************************************/

func_98D2() {
  self.bt.var_EB89 = spawnStruct();
  self.bt.var_EB89.var_BF75 = gettime() + 500;
  self.bt.var_EB89.var_BFB3["engage"] = gettime() + 1000;
  self.bt.var_EB89.enabled = 1;
  self.bt.var_EB89.var_D895 = undefined;
  self.bt.var_EB89.var_3D4C = [];
  if(self.unittype == "c12") {
    self.bt.var_EB89.var_71CE = ::func_360A;
  }

  if(isDefined(level.var_10E5D)) {
    return;
  }

  level.var_10E5F["c12"] = 300;
  level.var_10E5E["c12"] = 500;
}

func_360A(var_0) {
  switch (var_0.type) {
    case "seek":
      var_0.alias = "vox_c12_seeking";
      var_0.priority = 0.2;
      break;

    case "targeting":
      var_0.alias = "vox_c12_targetting";
      var_0.priority = 1;
      break;

    case "newenemy":
      var_0.alias = "vox_c12_threatdetected";
      var_0.priority = 0.75;
      break;

    case "engage":
      var_0.alias = "vox_c12_engaging";
      var_0.priority = 0.5;
      break;
  }
}

func_12F2C(var_0) {
  if(isDefined(self.bt.var_F1F8) && self.bt.var_F1F8) {
    return level.failure;
  }

  if(gettime() < self.bt.var_EB89.var_BF75) {
    return level.failure;
  }

  updateenemy();
  if(func_D53D()) {
    self.bt.var_EB89.var_BF75 = gettime() + randomfloatrange(level.var_10E5F[self.unittype], level.var_10E5E[self.unittype]);
  }

  return level.failure;
}

updateenemy() {
  if(isDefined(self.enemy)) {
    if(!isDefined(self.bt.var_EB89.var_D895) || self.bt.var_EB89.var_D895 != self.enemy) {
      func_17BA("newenemy", self.enemy);
    } else if(gettime() > self.bt.var_EB89.var_BFB3["engage"]) {
      self.bt.var_EB89.var_BFB3["engage"] = gettime() + randomfloatrange(1000, 3000);
      func_17BA("engage", self.enemy);
    }

    self.bt.var_EB89.var_D895 = self.enemy;
  }
}

func_81C5(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    if(!func_9FA6(var_3)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return sortbydistance(var_1, level.player.origin);
}

func_9FA6(var_0) {
  if(distancesquared(level.player.origin, var_0.origin) > 6250000) {
    return 0;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0)) {
    return 0;
  }

  return 1;
}

func_D53D() {
  if(!isalive(self)) {
    return 0;
  }

  if(!scripts\anim\battlechatter::func_29CA()) {
    return 0;
  }

  if(isDefined(self.var_9F6B) && self.var_9F6B) {
    return 0;
  }

  if(!self.bt.var_EB89.enabled) {
    return 0;
  }

  if(level.isteamspeaking[self.team]) {
    return 0;
  }

  var_0 = func_7EFD();
  if(!isDefined(var_0)) {
    return 0;
  }

  thread func_D53E(var_0);
  return 1;
}

func_7EFD() {
  var_0 = -1;
  var_1 = undefined;
  foreach(var_3 in self.bt.var_EB89.var_3D4C) {
    if(var_3.priority > var_0) {
      var_1 = var_3;
      var_0 = var_3.priority;
    }
  }

  return var_1;
}

func_17BA(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.alias = undefined;
  var_3.type = var_0;
  [[self.bt.var_EB89.var_71CE]](var_3);
  if(!isDefined(var_3.alias)) {
    return undefined;
  }

  if(isDefined(var_1)) {
    var_3.var_117B9 = var_1;
  }

  if(!isDefined(var_3.priority)) {
    var_3.priority = 0;
  }

  if(!isDefined(self.var_3D4C)) {
    self.bt.var_EB89.var_3D4C = [];
  }

  self.bt.var_EB89.var_3D4C[var_0] = var_3;
}

func_D53E(var_0) {
  self endon("death");
  if(scripts\anim\battlechatter::battlechatter_canprint()) {}

  self.bt.var_EB89.var_3D4C[var_0.type] = undefined;
  self.var_9F6B = 1;
  self getyawtoenemy(var_0.alias, var_0.alias, 1);
  self waittill(var_0.alias);
  self.var_9F6B = 0;
}