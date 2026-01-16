/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 2584.gsc
***********************************************/

func_1180F(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.enemy);
  self.bt.instancedata[var_0] = gettime() + 4000;
}

func_11811(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var_0] = undefined;
}

func_11812(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(self.a.pose != self.a.var_85E2) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0)) {
    self.bt.instancedata[var_0] = self.bt.instancedata[var_0] + 10000;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end")) {
    return anim.success;
  }

  if(gettime() > self.bt.instancedata[var_0]) {
    return anim.failure;
  }

  return anim.running;
}

func_8BF7(var_0) {
  if(func_BE18() && (gettime() >= 10000 || isDefined(level.var_932B) && level.var_932B)) {
    self.a.nextgrenadetrytime = gettime() + 500;
    return anim.success;
  }

  return anim.failure;
}

func_3928(var_0) {
  if(isDefined(self.pathgoalpos) || isDefined(self.script) && self.script == "cover_arrival") {
    return anim.failure;
  }

  if(self.grenadeweapon == "none") {
    return anim.failure;
  }

  if(isDefined(self.enemy) && isDefined(self.enemy.var_5963) && self.enemy.var_5963) {
    return anim.failure;
  }

  if(isDefined(self.dontevershoot) && self.dontevershoot) {
    return anim.failure;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return anim.failure;
  }

  if(scripts\anim\utility_common::usingmg()) {
    return anim.failure;
  }

  if(isDefined(anim.var_11813) && isalive(level.player)) {
    if(func_85E3(level.player, 200)) {
      return anim.success;
    }
  }

  if(isDefined(self.enemy) && func_85E3(self.enemy, self.var_B781)) {
    return anim.success;
  }

  return anim.failure;
}

func_85E3(var_0, var_1) {
  var_2 = var_0.origin;

  if(!self cansee(var_0)) {
    if(isDefined(self.enemy) && var_0 == self.enemy && isDefined(self.var_FECF)) {
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

  if(!func_85B5(var_0)) {
    return 0;
  }

  var_3 = scripts\engine\utility::getyawtospot(var_2);

  if(abs(var_3) > 60) {
    return 0;
  }

  if(self.weapon == "mg42" || self.grenadeammo <= 0) {
    return 0;
  }

  if(isDefined(self.enemy) && var_0 == self.enemy) {
    if(!func_3E1C()) {
      return 0;
    }

    if(scripts\anim\utility_common::canseeenemyfromexposed()) {
      if(!self isgrenadepossafe(var_0, var_0.origin)) {
        return 0;
      }

      return 1;
    }

    if(scripts\anim\utility_common::cansuppressenemyfromexposed()) {
      return 1;
    }

    if(!self isgrenadepossafe(var_0, var_0.origin)) {
      return 0;
    }
  }

  return 1;
}

func_BE18() {
  return gettime() >= self.a.nextgrenadetrytime;
}

func_3E1C() {
  var_0 = self.enemy.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));

  if(self.grenadeweapon == "flash_grenade") {
    return var_1 < 589824;
  }

  return var_1 >= 40000 && var_1 <= 1562500;
}

func_D022() {
  if(isDefined(self.var_71C7)) {
    return [[self.var_71C7]]();
  }

  return 0;
}

func_85B5(var_0) {
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
    self.var_1652.timername = self.grenadeweapon;
  } else {
    self.var_1652.isplayertimer = 0;
    self.var_1652.timername = "AI_" + self.grenadeweapon;
  }
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
  } else {
    return anim.grenadetimers[var_0.timername];
  }
}

func_1182C(var_0) {
  scripts\asm\asm_bb::bb_requestfire(1, self.enemy);
  self.bt.instancedata[var_0] = gettime() + 4000;
}

func_1182D(var_0) {
  scripts\asm\asm_bb::bb_requestfire(0);
  self.bt.instancedata[var_0] = undefined;
}

func_1182E(var_0) {
  var_1 = scripts\asm\asm_bb::func_2931();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwSeeker", "start", 0)) {
    self.bt.instancedata[var_0] = self.bt.instancedata[var_0] + 10000;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwSeeker", "end")) {
    return anim.success;
  }

  if(gettime() > self.bt.instancedata[var_0]) {
    return anim.failure;
  }

  return anim.running;
}

func_3929(var_0) {
  if(isDefined(self.pathgoalpos)) {
    return anim.failure;
  }

  if(self.grenadeweapon == "none") {
    return anim.failure;
  }

  if(isDefined(self.enemy) && isDefined(self.enemy.var_5963) && self.enemy.var_5963) {
    return anim.failure;
  }

  if(isDefined(self.dontevershoot) && self.dontevershoot) {
    return anim.failure;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return anim.failure;
  }

  func_F62B(self.enemy);

  if(!func_85B5(self.enemy)) {
    return 0;
  }

  return anim.success;
}