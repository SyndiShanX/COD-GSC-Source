/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2582.gsc
************************/

func_98D2() {
  self.var_3135.var_EB89 = spawnStruct();
  self.var_3135.var_EB89.var_BF75 = gettime() + 500;
  self.var_3135.var_EB89.var_BFB3["engage"] = gettime() + 1000;
  self.var_3135.var_EB89.enabled = 1;
  self.var_3135.var_EB89.var_D895 = undefined;
  self.var_3135.var_EB89.var_3D4C = [];
  if(self.unittype == "c12") {
    self.var_3135.var_EB89.var_71CE = ::func_360A;
  }

  if(isDefined(level.var_10E5D)) {
    return;
  }

  level.var_10E5F["c12"] = 300;
  level.var_10E5E["c12"] = 500;
}

func_360A(param_00) {
  switch (param_00.type) {
    case "seek":
      param_00.alias = "vox_c12_seeking";
      param_00.priority = 0.2;
      break;

    case "targeting":
      param_00.alias = "vox_c12_targetting";
      param_00.priority = 1;
      break;

    case "newenemy":
      param_00.alias = "vox_c12_threatdetected";
      param_00.priority = 0.75;
      break;

    case "engage":
      param_00.alias = "vox_c12_engaging";
      param_00.priority = 0.5;
      break;
  }
}

func_12F2C(param_00) {
  if(isDefined(self.var_3135.var_F1F8) && self.var_3135.var_F1F8) {
    return level.failure;
  }

  if(gettime() < self.var_3135.var_EB89.var_BF75) {
    return level.failure;
  }

  updateenemy();
  if(func_D53D()) {
    self.var_3135.var_EB89.var_BF75 = gettime() + randomfloatrange(level.var_10E5F[self.unittype], level.var_10E5E[self.unittype]);
  }

  return level.failure;
}

updateenemy() {
  if(isDefined(self.isnodeoccupied)) {
    if(!isDefined(self.var_3135.var_EB89.var_D895) || self.var_3135.var_EB89.var_D895 != self.isnodeoccupied) {
      func_17BA("newenemy", self.isnodeoccupied);
    } else if(gettime() > self.var_3135.var_EB89.var_BFB3["engage"]) {
      self.var_3135.var_EB89.var_BFB3["engage"] = gettime() + randomfloatrange(1000, 3000);
      func_17BA("engage", self.isnodeoccupied);
    }

    self.var_3135.var_EB89.var_D895 = self.isnodeoccupied;
  }
}

_meth_81C5(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!func_9FA6(var_03)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return sortbydistance(var_01, level.player.origin);
}

func_9FA6(param_00) {
  if(distancesquared(level.player.origin, param_00.origin) > 6250000) {
    return 0;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, param_00.origin, 0)) {
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

  if(!self.var_3135.var_EB89.enabled) {
    return 0;
  }

  if(level.isteamspeaking[self.team]) {
    return 0;
  }

  var_00 = func_7EFD();
  if(!isDefined(var_00)) {
    return 0;
  }

  thread func_D53E(var_00);
  return 1;
}

func_7EFD() {
  var_00 = -1;
  var_01 = undefined;
  foreach(var_03 in self.var_3135.var_EB89.var_3D4C) {
    if(var_03.priority > var_00) {
      var_01 = var_03;
      var_00 = var_03.priority;
    }
  }

  return var_01;
}

func_17BA(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.alias = undefined;
  var_03.type = param_00;
  [[self.var_3135.var_EB89.var_71CE]](var_03);
  if(!isDefined(var_03.alias)) {
    return undefined;
  }

  if(isDefined(param_01)) {
    var_03.var_117B9 = param_01;
  }

  if(!isDefined(var_03.priority)) {
    var_03.priority = 0;
  }

  if(!isDefined(self.var_3D4C)) {
    self.var_3135.var_EB89.var_3D4C = [];
  }

  self.var_3135.var_EB89.var_3D4C[param_00] = var_03;
}

func_D53E(param_00) {
  self endon("death");
  if(scripts\anim\battlechatter::battlechatter_canprint()) {}

  self.var_3135.var_EB89.var_3D4C[param_00.type] = undefined;
  self.var_9F6B = 1;
  self getyawtoenemy(param_00.alias, param_00.alias, 1);
  self waittill(param_00.alias);
  self.var_9F6B = 0;
}