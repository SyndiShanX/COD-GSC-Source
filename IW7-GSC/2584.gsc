/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2584.gsc
*********************************************/

func_1180F(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.isnodeoccupied);
  self.bt.instancedata[var_0] = gettime() + 4000;
}

func_11811(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var_0] = undefined;
}

func_11812(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  if(self.a.pose != self.a.var_85E2) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0)) {
    self.bt.instancedata[var_0] = self.bt.instancedata[var_0] + 10000;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end")) {
    return level.success;
  }

  if(gettime() > self.bt.instancedata[var_0]) {
    return level.failure;
  }

  return level.running;
}

func_8BF7(var_0) {
  if(func_BE18() && gettime() >= 10000 || isDefined(level.var_932B) && level.var_932B) {
    self.a.nextgrenadetrytime = gettime() + 500;
    return level.success;
  }

  return level.failure;
}

func_3928(var_0) {
  if(isDefined(self.vehicle_getspawnerarray) || isDefined(self.script) && self.script == "cover_arrival") {
    return level.failure;
  }

  if(self.objective_team == "none") {
    return level.failure;
  }

  if(isDefined(self.isnodeoccupied) && isDefined(self.isnodeoccupied.var_5963) && self.isnodeoccupied.var_5963) {
    return level.failure;
  }

  if(isDefined(self.dontevershoot) && self.dontevershoot) {
    return level.failure;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return level.failure;
  }

  if(scripts\anim\utility_common::usingmg()) {
    return level.failure;
  }

  if(isDefined(level.var_11813) && isalive(level.player)) {
    if(func_85E3(level.player, 200)) {
      return level.success;
    }
  }

  if(isDefined(self.isnodeoccupied) && func_85E3(self.isnodeoccupied, self.var_B781)) {
    return level.success;
  }

  return level.failure;
}

func_85E3(var_0, var_1) {
  var_2 = var_0.origin;
  if(!self getpersstat(var_0)) {
    if(isDefined(self.isnodeoccupied) && var_0 == self.isnodeoccupied && isDefined(self.var_FECF)) {
      var_2 = self.var_FECF;
    }

    var_1 = 100;
  } else if(!isDefined(var_1)) {
    var_1 = 100;
  }

  if(distancesquared(self.origin, var_2) < var_1 * var_1) {
    return 0;
  }

  if(self.a.pose != self.a.var_85E2) {
    return 0;
  }

  func_F62B(var_0);
  if(!_meth_85B5(var_0)) {
    return 0;
  }

  var_3 = scripts\engine\utility::getyawtospot(var_2);
  if(abs(var_3) > 60) {
    return 0;
  }

  if(self.var_394 == "mg42" || self.objective_state <= 0) {
    return 0;
  }

  if(isDefined(self.isnodeoccupied) && var_0 == self.isnodeoccupied) {
    if(!func_3E1C()) {
      return 0;
    }

    if(scripts\anim\utility_common::canseeenemyfromexposed()) {
      if(!self _meth_81A2(var_0, var_0.origin)) {
        return 0;
      }

      return 1;
    }

    if(scripts\anim\utility_common::cansuppressenemyfromexposed()) {
      return 1;
    }

    if(!self _meth_81A2(var_0, var_0.origin)) {
      return 0;
    }
  }

  return 1;
}

func_BE18() {
  return gettime() >= self.a.nextgrenadetrytime;
}

func_3E1C() {
  var_0 = self.isnodeoccupied.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));
  if(self.objective_team == "flash_grenade") {
    return var_1 < 589824;
  }

  return var_1 >= -25536 && var_1 <= 1562500;
}

func_D022() {
  if(isDefined(self.var_71C7)) {
    return [[self.var_71C7]]();
  }

  return 0;
}

_meth_85B5(var_0) {
  if(func_D022()) {
    return 0;
  }

  if(isDefined(self.script_forcegrenade) && self.script_forcegrenade == 1) {
    return 1;
  }

  if(gettime() >= func_7EE9(self.var_1652)) {
    return 1;
  }

  if(self.var_1652.isplayertimer && self.var_1652.timername == "fraggrenade") {
    return func_B4EF(var_0);
  }

  return 0;
}

func_F62B(var_0) {
  self.var_1652 = spawnStruct();
  if(isplayer(var_0) && isDefined(var_0.grenadetimers)) {
    self.var_1652.isplayertimer = 1;
    self.var_1652.player = var_0;
    self.var_1652.timername = self.objective_team;
    return;
  }

  self.var_1652.isplayertimer = 0;
  self.var_1652.timername = "AI_" + self.objective_team;
}

func_B4EF(var_0) {
  if(func_D022()) {
    return 0;
  }

  if(!var_0.gs.double_grenades_allowed) {
    return 0;
  }

  var_1 = gettime();
  if(var_1 < var_0.grenadetimers["double_grenade"]) {
    return 0;
  }

  if(var_1 > var_0.lastfraggrenadetoplayerstart + 3000) {
    return 0;
  }

  if(var_1 < var_0.lastfraggrenadetoplayerstart + 500) {
    return 0;
  }

  return var_0.numgrenadesinprogresstowardsplayer < 2;
}

func_7EE9(var_0) {
  if(var_0.isplayertimer) {
    return var_0.player.grenadetimers[var_0.timername];
  }

  return level.grenadetimers[var_0.timername];
}

func_1182C(var_0) {
  scripts\asm\asm_bb::bb_requestfire(1, self.isnodeoccupied);
  self.bt.instancedata[var_0] = gettime() + 4000;
}

func_1182D(var_0) {
  scripts\asm\asm_bb::bb_requestfire(0);
  self.bt.instancedata[var_0] = undefined;
}

func_1182E(var_0) {
  var_1 = scripts\asm\asm_bb::func_2931();
  if(!isDefined(var_1)) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwSeeker", "start", 0)) {
    self.bt.instancedata[var_0] = self.bt.instancedata[var_0] + 10000;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwSeeker", "end")) {
    return level.success;
  }

  if(gettime() > self.bt.instancedata[var_0]) {
    return level.failure;
  }

  return level.running;
}

func_3929(var_0) {
  if(isDefined(self.vehicle_getspawnerarray)) {
    return level.failure;
  }

  if(self.objective_team == "none") {
    return level.failure;
  }

  if(isDefined(self.isnodeoccupied) && isDefined(self.isnodeoccupied.var_5963) && self.isnodeoccupied.var_5963) {
    return level.failure;
  }

  if(isDefined(self.dontevershoot) && self.dontevershoot) {
    return level.failure;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return level.failure;
  }

  func_F62B(self.isnodeoccupied);
  if(!_meth_85B5(self.isnodeoccupied)) {
    return 0;
  }

  return level.success;
}