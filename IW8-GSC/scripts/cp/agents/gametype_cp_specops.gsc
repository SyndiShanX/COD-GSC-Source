/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\agents\gametype_cp_specops.gsc
*****************************************************/

function initmissilelauncherusage() {
  self.missilelauncherstage = undefined;
  self.missilelaunchertarget = undefined;
  self.missilelauncherlockstarttime = undefined;
  self.missilelauncherlostsightlinetime = undefined;
  thread resetmissilelauncherlockingondeath();
}

function resetmissilelauncherlocking() {
  if(!isDefined(self.missilelauncheruseentered)) {
    return;
  }

  self.missilelauncheruseentered = undefined;
  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");
  self notify("missileLauncher_lock_lost");
  self weaponlockfree();
  self stoplocalsound("maaws_reticle_tracking");
  self stoplocalsound("maaws_reticle_locked");

  if(isDefined(self.missilelaunchertarget)) {
    scripts\cp_mp\utility\weapon_utility::removelockedon(self.missilelaunchertarget, self);
  }

  initmissilelauncherusage();
}

function resetmissilelauncherlockingondeath() {
  self endon("disconnect");
  self notify("ResetMissileLauncherLockingOnDeath");
  self endon("ResetMissileLauncherLockingOnDeath");

  for(;;) {
    self waittill("death");
    resetmissilelauncherlocking();
  }
}

function loopmissilelauncherlockingfeedback() {
  self endon("death_or_disconnect");
  self endon("stop_javelin_locking_feedback");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner) {
      level.gunshipplayer playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel) {
      level.gunshipplayer playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_tracking");
    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.6;
  }
}

function loopmissilelauncherlockedfeedback() {
  self endon("death_or_disconnect");
  self endon("stop_javelin_locked_feedback");
  self playlocalsound("maaws_reticle_locked");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner) {
      level.gunshipplayer playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel) {
      level.gunshipplayer playlocalsound("maaws_incoming_lp");
    }

    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.25;
  }
}

function softsighttest(var0) {
  var1 = 500;

  if(stingtargstruct_isinlos(var0)) {
    self.missilelauncherlostsightlinetime = 0;
    return true;
  }

  if(self.missilelauncherlostsightlinetime == 0) {
    self.missilelauncherlostsightlinetime = gettime();
  }

  var2 = gettime() - self.missilelauncherlostsightlinetime;

  if(var2 >= var1) {
    resetmissilelauncherlocking();
    return false;
  }

  return true;
}

function missilelauncherusage() {
  var0 = 0;

  if(self playerads() < 0.95) {
    resetmissilelauncherlocking();
    return;
  }

  self.missilelauncheruseentered = 1;

  if(!isDefined(self.missilelauncherstage)) {
    self.missilelauncherstage = 0;
  }

  if(self.missilelauncherstage == 0) {
    var1 = scripts\cp\cp_weapon::lockonlaunchers_gettargetarray(0);

    if(var1.size == 0) {
      return;
    }

    var1 = sortbydistance(var1, self.origin);
    var2 = undefined;
    var3 = 0;

    foreach(var5 in var1) {
      if(!isDefined(var5)) {
        continue;
      }

      var2 = stingtargstruct_create(self, var5);
      stingtargstruct_getoffsets(var2);
      stingtargstruct_getorigins(var2);
      stingtargstruct_getinreticle(var2);

      if(stingtargstruct_isinreticle(var2)) {
        var3 = 1;
        break;
      }
    }

    if(!var3) {
      return;
    }

    stingtargstruct_getinlos(var2);

    if(!stingtargstruct_isinlos(var2)) {
      return;
    }

    self.missilelaunchertarget = var2.target;
    self.missilelauncherlockstarttime = gettime();
    self.missilelauncherstage = 1;
    self.missilelauncherlostsightlinetime = 0;

    if(isDefined(self.missilelaunchertarget)) {
      scripts\cp_mp\utility\weapon_utility::addlockedon(self.missilelaunchertarget, self);
    }

    thread loopmissilelauncherlockingfeedback();
  }

  if(self.missilelauncherstage == 1) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var0 && self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::ref_141b9(self.missilelaunchertarget, self)) {
      resetmissilelauncherlocking();
      return;
    }

    var2 = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct_getoffsets(var2);
    stingtargstruct_getorigins(var2);
    stingtargstruct_getinreticle(var2);

    if(!stingtargstruct_isinreticle(var2)) {
      resetmissilelauncherlocking();
      return;
    }

    stingtargstruct_getinlos(var2);

    if(!softsighttest(var2)) {
      return;
    }

    var7 = gettime() - self.missilelauncherlockstarttime;

    if(scripts\cp\utility::_hasperk("specialty_fasterlockon")) {
      if(var7 < 250) {
        return;
      }
    } else if(var7 < 500) {
      return;
    }

    self notify("stop_javelin_locking_feedback");
    thread loopmissilelauncherlockedfeedback();
    var8 = undefined;
    missilelauncher_finalizelock(var2);

    if(isDefined(level.activekillstreaks)) {
      if(scripts\engine\utility::array_contains(level.activekillstreaks, self.missilelaunchertarget)) {
        thread scripts\cp\cp_player_battlechatter::killstreaklockedon(self.missilelaunchertarget.streakname);
      }
    }

    self.missilelauncherstage = 2;
  }

  if(self.missilelauncherstage == 2) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var0 && self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::ref_141b9(self.missilelaunchertarget, self)) {
      resetmissilelauncherlocking();
      return;
    }

    var2 = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct_getoffsets(var2);
    stingtargstruct_getorigins(var2);
    stingtargstruct_getinreticle(var2);
    stingtargstruct_getinlos(var2);

    if(!softsighttest(var2)) {
      return;
    } else {
      missilelauncher_finalizelock(var2);
    }

    if(!stingtargstruct_isinreticle(var2)) {
      resetmissilelauncherlocking();
      return;
    }

    return;
  }
}

function missilelauncherusageloop() {
  if(!isPlayer(self)) {
    return;
  }

  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  initmissilelauncherusage();

  for(;;) {
    wait 0.05;
    missilelauncherusage();
  }
}

function missilelauncher_finalizelock(var0) {
  var1 = undefined;

  if(isDefined(var0.inlosid)) {
    var1 = var0.offsets[var0.inlosid];
    var1 = (var1[1], -1 * var1[0], var1[2]);
  } else {
    var1 = (0, 0, 0);
  }

  self weaponlockfinalize(self.missilelaunchertarget, var1);
}

function addhudincoming_attacker(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = var0;

  if(isDefined(var0.owner)) {
    var1 = var0.owner;
  }

  if(!isDefined(var1) || !isPlayer(var1)) {
    return;
  }
}

function removehudincoming_attacker(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = var0;

  if(!isDefined(var0.owner)) {
    return;
  }

  var1 = var0.owner;

  if(!isDefined(var1) || !isPlayer(var1)) {
    return;
  }
}

function stingtargstruct_create(var0, var1) {
  var2 = spawnStruct();
  var2.player = var0;
  var2.target = var1;
  var2.offsets = [];
  var2.origins = [];
  var2.inreticledistssqr = [];
  var2.inreticlesortedids = [];
  var2.inlosid = undefined;
  var2.useoldlosverification = 1;
  return var2;
}

function stingtargstruct_getoffsets() {
  self.offsets = [];

  if(scripts\cp\utility\entity::ischoppergunner(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\cp\utility\entity::tutorial_jumpfromplane(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\cp\utility\entity::issupporthelo(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -100);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\cp\utility\entity::isgunship(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\cp\utility\entity::isclusterstrike(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 40);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\cp\utility\entity::isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\cp\utility\entity::isradardrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\cp\utility\entity::isscramblerdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\cp\utility\entity::isradarhelicopter(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -30);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "light_tank") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
    return;
  }

  self.offsets[self.offsets.size] = (0, 0, 0);
}

function stingtargstruct_getorigins() {
  var0 = self.target.origin;
  var1 = self.target.angles;
  var2 = anglesToForward(var1);
  var3 = anglestoright(var1);
  var4 = anglestoup(var1);

  for(var5 = 0; var5 < self.offsets.size; var5++) {
    var6 = self.offsets[var5];
    self.origins[var5] = var0 + var3 * var6[0] + var2 * var6[1] + var4 * var6[2];
  }
}

function stingtargstruct_getinreticle() {
  foreach(var1 in self.origins) {
    for(var2 = 0; var2 < self.origins.size; var2++) {
      var3 = self.player worldpointtoscreenpos(self.origins[var2], 65);

      if(isDefined(var3)) {
        var4 = length2dsquared(var3);

        if(var4 <= 7225) {
          self.inreticlesortedids[self.inreticlesortedids.size] = var2;
          self.inreticledistssqr[var2] = var4;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(var2 = 0; var2 < self.inreticlesortedids.size; var2++) {
      for(var6 = var2 + 1; var6 < self.inreticlesortedids.size; var6++) {
        var7 = self.inreticlesortedids[var2];
        var8 = self.inreticlesortedids[var6];
        var9 = self.inreticledistssqr[var7];
        var10 = self.inreticledistssqr[var8];

        if(var10 < var9) {
          var11 = var7;
          self.inreticlesortedids[var2] = var8;
          self.inreticlesortedids[var6] = var11;
        }
      }
    }

    return;
  }
}

function stingtargstruct_getinlos() {
  var0 = self.player getEye();
  var1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  var2 = [self.player, self.target];
  var3 = self.target getlinkedchildren();

  if(isDefined(var3) && var3.size > 0) {
    var2 = scripts\engine\utility::array_combine(var2, var3);
  }

  if(!self.useoldlosverification) {
    for(var4 = 0; var4 < self.inreticlesortedids.size; var4++) {
      var5 = self.inreticlesortedids[var4];
      var6 = self.origins[var5];
      var7 = physics_raycast(var0, var6, var1, var2, 0, "physicsquery_closest", 1);

      if(!isDefined(var7) || var7.size == 0) {
        self.inlosid = var5;
        return;
      }
    }

    return;
  }

  var8 = self.target getpointinbounds(0, 0, 1);
  var9 = scripts\engine\trace::ray_trace(var0, var8, var2, var1, 0);

  if(var9["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var10 = self.target getpointinbounds(1, 0, 0);
  var9 = scripts\engine\trace::ray_trace(var0, var10, var2, var1, 0);

  if(var9["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var11 = self.target getpointinbounds(-1, 0, 0);
  var9 = scripts\engine\trace::ray_trace(var0, var11, var2, var1, 0);

  if(var9["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }
}

function stingtargstruct_isinreticle() {
  return self.inreticlesortedids.size > 0;
}

function stingtargstruct_isinlos() {
  return isDefined(self.inlosid);
}