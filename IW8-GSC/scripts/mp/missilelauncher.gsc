/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\missilelauncher.gsc
***********************************************/

function initmissilelauncherusage() {
  ref_12C74();
}

function ref_12C74() {
  self.missilelauncherstage = undefined;
  self.missilelaunchertarget = undefined;
  self.missilelauncherlockstarttime = undefined;
  self.missilelauncherlostsightlinetime = undefined;
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

  ref_12C74();
}

function resetmissilelauncherlockingondeath() {
  self endon("disconnect");
  self notify("ResetMissileLauncherLockingOnDeath");
  self endon("ResetMissileLauncherLockingOnDeath");
  self endon("end_launcher");

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

function softsighttest(var_0) {
  var_1 = 500;

  if(stingtargstruct_isinlos(var_0)) {
    self.missilelauncherlostsightlinetime = 0;
    return true;
  }

  if(self.missilelauncherlostsightlinetime == 0) {
    self.missilelauncherlostsightlinetime = gettime();
  }

  var_2 = gettime() - self.missilelauncherlostsightlinetime;

  if(var_2 >= var_1) {
    resetmissilelauncherlocking();
    return false;
  }

  return true;
}

function missilelauncherusage() {
  var_0 = getdvarint("scr_maxMissileLockOnRange", 625000000);
  var_1 = 0;

  if(self playerads() < 0.95) {
    resetmissilelauncherlocking();
    return;
  }

  self.missilelauncheruseentered = 1;

  if(!isDefined(self.missilelauncherstage)) {
    self.missilelauncherstage = 0;
  }

  if(self.missilelauncherstage == 0) {
    var_2 = scripts\mp\weapons::lockonlaunchers_gettargetarray(0);

    if(var_2.size == 0) {
      return;
    }

    var_2 = sortbydistance(var_2, self.origin);
    var_3 = undefined;
    var_4 = 0;

    foreach(var_6 in var_2) {
      if(!isDefined(var_6)) {
        continue;
      }

      var_3 = stingtargstruct_create(self, var_6);
      stingtargstruct_getoffsets(var_3);
      stingtargstruct_getorigins(var_3);
      stingtargstruct_getinreticle(var_3);

      if(stingtargstruct_isinreticle(var_3)) {
        if(distancesquared(var_6.origin, self.origin) > var_0) {
          break;
        }

        var_4 = 1;
        break;
      }
    }

    if(!var_4) {
      return;
    }

    stingtargstruct_getinlos(var_3);

    if(!stingtargstruct_isinlos(var_3)) {
      return;
    }

    self.missilelaunchertarget = var_3.target;
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

    if(!var_1 && self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::ref_141B9(self.missilelaunchertarget, self)) {
      resetmissilelauncherlocking();
      return;
    }

    var_3 = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct_getoffsets(var_3);
    stingtargstruct_getorigins(var_3);
    stingtargstruct_getinreticle(var_3);

    if(!stingtargstruct_isinreticle(var_3)) {
      resetmissilelauncherlocking();
      return;
    }

    stingtargstruct_getinlos(var_3);

    if(!softsighttest(var_3)) {
      return;
    }

    var_8 = gettime() - self.missilelauncherlockstarttime;

    if(scripts\mp\utility\perk::_hasperk("specialty_fasterlockon")) {
      if(var_8 < 250) {
        return;
      }
    } else if(var_8 < 500) {
      return;
    }

    self notify("stop_javelin_locking_feedback");
    thread loopmissilelauncherlockedfeedback();
    var_9 = undefined;
    missilelauncher_finalizelock(var_3);

    if(isDefined(level.activekillstreaks)) {
      if(scripts\engine\utility::array_contains(level.activekillstreaks, self.missilelaunchertarget)) {
        thread scripts\mp\battlechatter_mp::killstreaklockedon(self.missilelaunchertarget.streakname);
      }
    }

    self.missilelauncherstage = 2;
  }

  if(self.missilelauncherstage == 2) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var_1 && self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::ref_141B9(self.missilelaunchertarget, self)) {
      resetmissilelauncherlocking();
      return;
    }

    var_3 = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct_getoffsets(var_3);
    stingtargstruct_getorigins(var_3);
    stingtargstruct_getinreticle(var_3);
    stingtargstruct_getinlos(var_3);

    if(!softsighttest(var_3)) {
      return;
    } else {
      missilelauncher_finalizelock(var_3);
    }

    if(!stingtargstruct_isinreticle(var_3)) {
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
  thread resetmissilelauncherlockingondeath();

  for(;;) {
    wait 0.05;
    missilelauncherusage();
  }
}

function missilelauncher_finalizelock(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.target) && isDefined(var_0.target.vehiclename) && var_0.target.vehiclename == "light_tank") {
    var_1 = (0, 0, 75);
  } else if(isDefined(var_0.inlosid)) {
    var_1 = var_0.offsets[var_0.inlosid];
    var_1 = (var_1[1], -1 * var_1[0], var_1[2]);
  } else {
    var_1 = (0, 0, 0);
  }

  self weaponlockfinalize(self.missilelaunchertarget, var_1);
}

function addhudincoming_attacker(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0;

  if(isDefined(var_0.owner) && !scripts\mp\utility\killstreak::isplayerkillstreak(var_0)) {
    var_1 = var_0.owner;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
}

function removehudincoming_attacker(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0;

  if(!scripts\mp\utility\killstreak::isplayerkillstreak(var_0)) {
    if(!isDefined(var_0.owner)) {
      return;
    }

    var_1 = var_0.owner;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
}

function stingtargstruct_create(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.player = var_0;
  var_2.target = var_1;
  var_2.offsets = [];
  var_2.origins = [];
  var_2.inreticledistssqr = [];
  var_2.inreticlesortedids = [];
  var_2.inlosid = undefined;
  var_2.useoldlosverification = 1;
  return var_2;
}

function stingtargstruct_getoffsets() {
  self.offsets = [];

  if(scripts\mp\utility\entity::ischoppergunner(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility\entity::issupporthelo(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -100);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility\entity::isgunship(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility\entity::isclusterstrike(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 40);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility\entity::isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility\entity::isradardrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility\entity::turret_op(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility\entity::isscramblerdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 15);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility\entity::isradarhelicopter(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -30);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "light_tank") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "apc_russian") {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "cargo_truck" || self.target.vehiclename == "cargo_truck_mg")) {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "large_transport") {
    self.offsets[self.offsets.size] = (0, 0, 65);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "medium_transport") {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "pickup_truck" || self.target.vehiclename == "technical")) {
    self.offsets[self.offsets.size] = (0, 0, 55);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "atv") {
    self.offsets[self.offsets.size] = (0, 0, 30);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "motorcycle") {
    self.offsets[self.offsets.size] = (0, 0, 30);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "jeep" || self.target.vehiclename == "tac_rover" || self.target.vehiclename == "open_jeep_carpoc")) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "loot_chopper") {
    self.offsets[self.offsets.size] = (0, 0, -100);
    self.useoldlosverification = 0;
    return;
  }

  self.offsets[self.offsets.size] = (0, 0, 0);
}

function stingtargstruct_getorigins() {
  var_0 = self.target.origin;
  var_1 = self.target.angles;
  var_2 = anglesToForward(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglestoup(var_1);

  for(var_5 = 0; var_5 < self.offsets.size; var_5++) {
    var_6 = self.offsets[var_5];
    self.origins[var_5] = var_0 + var_3 * var_6[0] + var_2 * var_6[1] + var_4 * var_6[2];
  }
}

function stingtargstruct_getinreticle() {
  foreach(var_1 in self.origins) {
    for(var_2 = 0; var_2 < self.origins.size; var_2++) {
      var_3 = self.player worldpointtoscreenpos(self.origins[var_2], 65);

      if(isDefined(var_3)) {
        var_4 = length2dsquared(var_3);

        if(var_4 <= 2916) {
          self.inreticlesortedids[self.inreticlesortedids.size] = var_2;
          self.inreticledistssqr[var_2] = var_4;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(var_2 = 0; var_2 < self.inreticlesortedids.size; var_2++) {
      for(var_6 = var_2 + 1; var_6 < self.inreticlesortedids.size; var_6++) {
        var_7 = self.inreticlesortedids[var_2];
        var_8 = self.inreticlesortedids[var_6];
        var_9 = self.inreticledistssqr[var_7];
        var_10 = self.inreticledistssqr[var_8];

        if(var_10 < var_9) {
          var_11 = var_7;
          self.inreticlesortedids[var_2] = var_8;
          self.inreticlesortedids[var_6] = var_11;
        }
      }
    }

    return;
  }
}

function stingtargstruct_getinlos() {
  var_0 = self.player getEye();
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item", "physicscontents_playernosight"]);
  var_2 = [self.player, self.target];
  var_3 = self.target getlinkedchildren();

  if(isDefined(var_3) && var_3.size > 0) {
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  if(!self.useoldlosverification) {
    for(var_4 = 0; var_4 < self.inreticlesortedids.size; var_4++) {
      var_5 = self.inreticlesortedids[var_4];
      var_6 = self.origins[var_5];
      var_7 = physics_raycast(var_0, var_6, var_1, var_2, 0, "physicsquery_closest", 1);

      if(!isDefined(var_7) || var_7.size == 0) {
        self.inlosid = var_5;
        return;
      }
    }

    return;
  }

  var_8 = self.target getpointinbounds(0, 0, 1);
  var_9 = scripts\engine\trace::ray_trace(var_0, var_8, var_2, var_1, 0);

  if(var_9["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var_18 = self.target getpointinbounds(1, 0, 0);
  var_9 = scripts\engine\trace::ray_trace(var_0, var_18, var_2, var_1, 0);

  if(var_9["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var_19 = self.target getpointinbounds(-1, 0, 0);
  var_9 = scripts\engine\trace::ray_trace(var_0, var_19, var_2, var_1, 0);

  if(var_9["fraction"] == 1) {
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