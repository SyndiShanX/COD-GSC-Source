/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\throwgrenade.gsc
***********************************************/

function throwgrenade_init(var0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.enemy);
  self.bt.instancedata[var0] = spawnStruct();
  self.bt.instancedata[var0].timeout = gettime() + 4000;
}

function throwgrenade_terminate(var0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var0] = undefined;
}

function throwgrenade_update(var0) {
  var1 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();

  if(!isDefined(var1)) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0)) {
    self.bt.instancedata[var0].started = 1;
    self.bt.instancedata[var0].timeout += 10000;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end")) {
    return anim.success;
  }

  if(gettime() > self.bt.instancedata[var0].timeout) {
    return anim.failure;
  }

  if(!istrue(self.bt.instancedata[var0].started)) {
    var2 = scripts\engine\utility::getyawtospot(var1.origin);

    if(abs(var2) > 90) {
      return anim.failure;
    }
  }

  return anim.running;
}

function hasgrenadetimerelapsed(var0) {
  if(mygrenadecooldownelapsed() && (gettime() >= 10000 || isDefined(level.ignoregrenadesafetime) && level.ignoregrenadesafetime)) {
    self.a.nextgrenadetrytime = gettime() + 500;
    return anim.success;
  }

  return anim.failure;
}

function canthrowgrenade(var0) {
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

function grenadepossafewrapper(var0, var1) {
  if(isDefined(self.grenadesafedist) && !self isgrenadepossafe(var0, var1, self.grenadesafedist)) {
    return false;
  } else if(!self isgrenadepossafe(var0, var1)) {
    return false;
  }

  return true;
}

function grenadethrowvaliditycheck(var0, var1) {
  var2 = var0.origin;

  if(!self cansee(var0)) {
    if(isDefined(self.enemy) && var0 == self.enemy && isDefined(self.shootpos)) {
      var2 = self.shootpos;
    }

    var1 = 100;
  } else if(!isDefined(var1)) {
    var1 = 100;
  }

  if(distancesquared(self.origin, var2) < var1 * var1) {
    return false;
  }

  setactivegrenadetimer(var0);

  if(!grenadecooldownelapsed(var0)) {
    return false;
  }

  var3 = scripts\engine\utility::getyawtospot(var2);

  if(abs(var3) > 60) {
    return false;
  }

  if(self.weapon.basename == "mg42" || self.grenadeammo <= 0) {
    return false;
  }

  if(isDefined(self.enemy) && var0 == self.enemy) {
    if(!checkgrenadethrowdist()) {
      return false;
    }

    if(!grenadepossafewrapper(var0, var0.origin)) {
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
  var0 = self.enemy.origin - self.origin;
  var1 = lengthsquared((var0[0], var0[1], 0));

  if(self.grenadeweapon.basename == "flash_grenade") {
    return (var1 < 589824);
  }

  return var1 >= 40000 && var1 <= 1562500;
}

function grenadecooldownelapsed(var0) {
  if(isDefined(self.fngrenadecooldownelapsedoverride)) {
    return [[self.fngrenadecooldownelapsedoverride]](var0);
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
    return maythrowdoublegrenade(var0);
  }

  return 0;
}

function setactivegrenadetimer(var0) {
  self.activegrenadetimer = spawnStruct();

  if(isPlayer(var0) && isDefined(var0.grenadetimers)) {
    self.activegrenadetimer.isplayertimer = 1;
    self.activegrenadetimer.player = var0;
    self.activegrenadetimer.timername = self.grenadeweapon.basename;
    return;
  }

  self.activegrenadetimer.isplayertimer = 0;
  self.activegrenadetimer.timername = "AI_" + self.grenadeweapon.basename;
}

function maythrowdoublegrenade(var0) {
  if(scripts\engine\utility::player_died_recently()) {
    return false;
  }

  if(!var0.gs.double_grenades_allowed) {
    return false;
  }

  var1 = gettime();

  if(var1 < var0.grenadetimers["double_grenade"]) {
    return false;
  }

  if(var1 > var0.lastfraggrenadetoplayerstart + 3000) {
    return false;
  }

  if(var1 < var0.lastfraggrenadetoplayerstart + 500) {
    return false;
  }

  return var0.numgrenadesinprogresstowardsplayer < 2;
}

function getgrenadetimertime(var0) {
  if(var0.isplayertimer) {
    return var0.player.grenadetimers[var0.timername];
  }

  return anim.grenadetimers[var0.timername];
}