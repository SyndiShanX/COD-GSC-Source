/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\throwgrenade.gsc
***********************************************/

function throwgrenade_init(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.enemy);
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].timeout = gettime() + 4000;
}

function throwgrenade_terminate(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var_0] = undefined;
}

function throwgrenade_update(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0)) {
    self.bt.instancedata[var_0].started = 1;
    self.bt.instancedata[var_0].timeout += 10000;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end")) {
    return anim.success;
  }

  if(gettime() > self.bt.instancedata[var_0].timeout) {
    return anim.failure;
  }

  if(!istrue(self.bt.instancedata[var_0].started)) {
    var_2 = scripts\engine\utility::getyawtospot(var_1.origin);

    if(abs(var_2) > 90) {
      return anim.failure;
    }
  }

  return anim.running;
}

function hasgrenadetimerelapsed(var_0) {
  if(mygrenadecooldownelapsed() && (gettime() >= 10000 || isDefined(level.ignoregrenadesafetime) && level.ignoregrenadesafetime)) {
    self.a.nextgrenadetrytime = gettime() + 500;
    return anim.success;
  }

  return anim.failure;
}

function canthrowgrenade(var_0) {
  if(isDefined(self.pathgoalpos) || self.arriving) {
    return anim.failure;
  }

  if(nullweapon(self.grenadeweapon)) {
    return anim.failure;
  }

  if(isDefined(self.enemy) && isDefined(self.enemy.dontgrenademe) && self.enemy.dontgrenademe) {
    return anim.failure;
  }

  if(istrue(self.dontevershoot)) {
    return anim.failure;
  }

  if(scripts\engine\utility::actor_is3d()) {
    return anim.failure;
  }

  if(scripts\anim\utility_common::usingmg()) {
    return anim.failure;
  }

  if(isDefined(anim.throwgrenadeatplayerasap) && isalive(level.player)) {
    if(grenadethrowvaliditycheck(level.player, 200)) {
      return anim.success;
    }
  }

  if(isDefined(self.enemy) && grenadethrowvaliditycheck(self.enemy, self.minexposedgrenadedist)) {
    return anim.success;
  }

  return anim.failure;
}

function grenadepossafewrapper(var_0, var_1) {
  if(isDefined(self.grenadesafedist) && !self isgrenadepossafe(var_0, var_1, self.grenadesafedist)) {
    return false;
  } else if(!self isgrenadepossafe(var_0, var_1)) {
    return false;
  }

  return true;
}

function grenadethrowvaliditycheck(var_0, var_1) {
  var_2 = var_0.origin;

  if(!self cansee(var_0)) {
    if(isDefined(self.enemy) && var_0 == self.enemy && isDefined(self.shootpos)) {
      var_2 = self.shootpos;
    }

    var_1 = 100;
  } else if(!isDefined(var_1)) {
    var_1 = 100;
  }

  if(distancesquared(self.origin, var_2) < var_1 * var_1) {
    return false;
  }

  setactivegrenadetimer(var_0);

  if(!grenadecooldownelapsed(var_0)) {
    return false;
  }

  var_3 = scripts\engine\utility::getyawtospot(var_2);

  if(abs(var_3) > 60) {
    return false;
  }

  if(self.weapon.basename == "mg42" || self.grenadeammo <= 0) {
    return false;
  }

  if(isDefined(self.enemy) && var_0 == self.enemy) {
    if(!checkgrenadethrowdist()) {
      return false;
    }

    if(!grenadepossafewrapper(var_0, var_0.origin)) {
      return false;
    }

    if(scripts\anim\utility_common::canseeenemyfromexposed()) {
      return true;
    }

    if(scripts\anim\utility_common::cansuppressenemyfromexposed()) {
      return true;
    }
  }

  return true;
}

function mygrenadecooldownelapsed() {
  return gettime() >= self.a.nextgrenadetrytime;
}

function checkgrenadethrowdist() {
  var_0 = self.enemy.origin - self.origin;
  var_1 = lengthsquared((var_0[0], var_0[1], 0));

  if(self.grenadeweapon.basename == "flash_grenade") {
    return (var_1 < 589824);
  }

  return var_1 >= 40000 && var_1 <= 1562500;
}

function grenadecooldownelapsed(var_0) {
  if(isDefined(self.fngrenadecooldownelapsedoverride)) {
    return [[self.fngrenadecooldownelapsedoverride]](var_0);
  }

  if(scripts\engine\utility::player_died_recently()) {
    return 0;
  }

  if(isDefined(self.script_forcegrenade) && self.script_forcegrenade == 1) {
    return 1;
  }

  if(gettime() >= getgrenadetimertime(self.activegrenadetimer)) {
    return 1;
  }

  if(self.activegrenadetimer.isplayertimer && self.activegrenadetimer.timername == "fraggrenade") {
    return maythrowdoublegrenade(var_0);
  }

  return 0;
}

function setactivegrenadetimer(var_0) {
  self.activegrenadetimer = spawnStruct();

  if(isPlayer(var_0) && isDefined(var_0.grenadetimers)) {
    self.activegrenadetimer.isplayertimer = 1;
    self.activegrenadetimer.player = var_0;
    self.activegrenadetimer.timername = self.grenadeweapon.basename;
    return;
  }

  self.activegrenadetimer.isplayertimer = 0;
  self.activegrenadetimer.timername = "AI_" + self.grenadeweapon.basename;
}

function maythrowdoublegrenade(var_0) {
  if(scripts\engine\utility::player_died_recently()) {
    return false;
  }

  if(!var_0.gs.double_grenades_allowed) {
    return false;
  }

  var_1 = gettime();

  if(var_1 < var_0.grenadetimers["double_grenade"]) {
    return false;
  }

  if(var_1 > var_0.lastfraggrenadetoplayerstart + 3000) {
    return false;
  }

  if(var_1 < var_0.lastfraggrenadetoplayerstart + 500) {
    return false;
  }

  return var_0.numgrenadesinprogresstowardsplayer < 2;
}

function getgrenadetimertime(var_0) {
  if(var_0.isplayertimer) {
    return var_0.player.grenadetimers[var_0.timername];
  }

  return anim.grenadetimers[var_0.timername];
}