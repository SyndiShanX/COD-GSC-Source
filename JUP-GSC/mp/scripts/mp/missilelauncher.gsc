/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\missilelauncher.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace missilelauncher;

function initmissilelauncherusage() {
  resetmissilelaunchertargets();
}

function resetmissilelaunchertargets() {
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
    removelockedon(self.missilelaunchertarget, self);
  }

  resetmissilelaunchertargets();
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

function softsighttest(stingtargstruct) {
  lost_sight_limit = 500;

  if(stingtargstruct stingtargstruct_isinlos()) {
    self.missilelauncherlostsightlinetime = 0;
    return true;
  }

  if(self.missilelauncherlostsightlinetime == 0) {
    self.missilelauncherlostsightlinetime = gettime();
  }

  timepassed = gettime() - self.missilelauncherlostsightlinetime;

  if(timepassed >= lost_sight_limit) {
    resetmissilelauncherlocking();
    return false;
  }

  return true;
}

function missilelauncherusage() {
  var_db87e220986304f4 = getdvarint(@ "hash_eb7d16d9fa10a208", 625000000);
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(!scripts\cp_mp\utility\weapon_utility::ismissilelauncherlockonallowed()) {
    return;
  }

  if(self playerads() < 0.95) {
    resetmissilelauncherlocking();
    return;
  }

  self.missilelauncheruseentered = 1;

  if(!isDefined(self.missilelauncherstage)) {
    self.missilelauncherstage = 0;
  }

  function_5875284c0e0f1e40(self.missilelaunchertarget);

  if(self.missilelauncherstage == 0) {
    targets = scripts\mp\weapons::lockonlaunchers_gettargetarray(0);

    if(targets.size == 0) {
      return;
    }

    targets = sortbydistance(targets, self.origin);
    stingtargstruct = undefined;
    var_c7f50dd357b9cdcf = 0;

    foreach(target in targets) {
      if(!isDefined(target)) {
        continue;
      }

      stingtargstruct = stingtargstruct_create(self, target);
      stingtargstruct stingtargstruct_getoffsets();
      stingtargstruct stingtargstruct_getorigins();
      stingtargstruct stingtargstruct_getinreticle();

      if(stingtargstruct stingtargstruct_isinreticle()) {
        if(distancesquared(target.origin, self.origin) > var_db87e220986304f4) {
          break;
        }

        var_c7f50dd357b9cdcf = 1;
        break;
      }
    }

    if(!var_c7f50dd357b9cdcf) {
      return;
    }

    stingtargstruct stingtargstruct_getinlos();

    if(!stingtargstruct stingtargstruct_isinlos()) {
      return;
    }

    self.missilelaunchertarget = stingtargstruct.target;
    self.missilelauncherlockstarttime = gettime();
    self.missilelauncherstage = 1;
    self.missilelauncherlostsightlinetime = 0;

    if(isDefined(self.missilelaunchertarget)) {
      addlockedon(self.missilelaunchertarget, self);
    }

    thread loopmissilelauncherlockingfeedback();
  }

  if(self.missilelauncherstage == 1) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var_e688b198aa9a4b3f && self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.missilelaunchertarget, self)) {
      resetmissilelauncherlocking();
      return;
    }

    stingtargstruct = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct stingtargstruct_getoffsets();
    stingtargstruct stingtargstruct_getorigins();
    stingtargstruct stingtargstruct_getinreticle();

    if(!stingtargstruct stingtargstruct_isinreticle()) {
      resetmissilelauncherlocking();
      return;
    }

    stingtargstruct stingtargstruct_getinlos();

    if(!softsighttest(stingtargstruct)) {
      return;
    }

    timepassed = gettime() - self.missilelauncherlockstarttime;

    if(_hasperk("specialty_fasterlockon")) {
      if(timepassed < 250) {
        return;
      }
    } else if(timepassed < 500) {
      return;
    }

    self notify("stop_javelin_locking_feedback");
    thread loopmissilelauncherlockedfeedback();
    offset = undefined;
    missilelauncher_finalizelock(stingtargstruct);
    self.missilelauncherstage = 2;
  }

  if(self.missilelauncherstage == 2) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var_e688b198aa9a4b3f && self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.missilelaunchertarget, self)) {
      resetmissilelauncherlocking();
      return;
    }

    stingtargstruct = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct stingtargstruct_getoffsets();
    stingtargstruct stingtargstruct_getorigins();
    stingtargstruct stingtargstruct_getinreticle();
    stingtargstruct stingtargstruct_getinlos();

    if(!softsighttest(stingtargstruct)) {
      return;
    } else {
      missilelauncher_finalizelock(stingtargstruct);
    }

    if(!stingtargstruct stingtargstruct_isinreticle()) {
      resetmissilelauncherlocking();
      return;
    }
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

function missilelauncher_finalizelock(stingtargstruct) {
  offset = undefined;

  if(isDefined(stingtargstruct.target) && isDefined(stingtargstruct.target.vehiclename) && stingtargstruct.target.vehiclename == "light_tank") {
    offset = (0, 0, 75);
  } else if(isDefined(stingtargstruct.inlosid)) {
    offset = stingtargstruct.offsets[stingtargstruct.inlosid];
    offset = (offset[1], -1 * offset[0], offset[2]);
  } else {
    offset = (0, 0, 0);
  }

  if(!isent(self.missilelaunchertarget)) {
    self weaponlockfinalize(self.missilelaunchertarget.origin, offset);
    return;
  }

  self weaponlockfinalize(self.missilelaunchertarget, offset);
}

function stingtargstruct_create(player, target) {
  struct = spawnStruct();
  struct.player = player;
  struct.target = target;
  struct.offsets = [];
  struct.origins = [];
  struct.inreticledistssqr = [];
  struct.inreticlesortedids = [];
  struct.inlosid = undefined;
  struct.useoldlosverification = 1;
  return struct;
}

function stingtargstruct_getoffsets() {
  self.offsets = [];

  if(ischoppergunner(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
    return;
  }

  if(issupporthelo(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -100);
    self.useoldlosverification = 0;
    return;
  }

  if(isgunship(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
    return;
  }

  if(isclusterstrike(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 40);
    self.useoldlosverification = 0;
    return;
  }

  if(isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  if(isradardrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
    return;
  }

  if(isassaultdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
    return;
  }

  if(isscramblerdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 15);
    self.useoldlosverification = 0;
    return;
  }

  if(isradarhelicopter(self.target)) {
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

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "jeep" || self.target.vehiclename == "tac_rover")) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "veh9_rhib" || self.target.vehiclename == "veh9_rhib_hsk")) {
    self.offsets[self.offsets.size] = (0, 0, 20);
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
  origin = self.target.origin;
  angles = self.target.angles;
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  for(i = 0; i < self.offsets.size; i++) {
    offset = self.offsets[i];
    self.origins[i] = origin + right * offset[0] + forward * offset[1] + up * offset[2];
  }
}

function stingtargstruct_getinreticle() {
  foreach(origin in self.origins) {
    for(i = 0; i < self.origins.size; i++) {
      screenpos = self.player worldpointtoscreenpos(self.origins[i], 65);

      if(isDefined(screenpos)) {
        distsqr = length2dsquared(screenpos);

        if(distsqr <= 576) {
          self.inreticlesortedids[self.inreticlesortedids.size] = i;
          self.inreticledistssqr[i] = distsqr;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(i = 0; i < self.inreticlesortedids.size; i++) {
      for(j = i + 1; j < self.inreticlesortedids.size; j++) {
        i_id = self.inreticlesortedids[i];
        j_id = self.inreticlesortedids[j];
        var_8eba9ec305d4a611 = self.inreticledistssqr[i_id];
        var_cf5f902786383f74 = self.inreticledistssqr[j_id];

        if(var_cf5f902786383f74 < var_8eba9ec305d4a611) {
          tempid = i_id;
          self.inreticlesortedids[i] = j_id;
          self.inreticlesortedids[j] = tempid;
        }
      }
    }
  }
}

function stingtargstruct_getinlos() {
  caststart = self.player getEye();
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_playernosight"]);

  if(!isent(self.target)) {
    ignorearr = [self.player];

    for(i = 0; i < self.inreticlesortedids.size; i++) {
      id = self.inreticlesortedids[i];
      castend = self.origins[id];
      castresults = physics_raycast(caststart, castend, contents, ignorearr, 0, "physicsquery_closest", 1);

      if(!isDefined(castresults) || castresults.size == 0) {
        self.inlosid = id;
        return;
      }
    }

    return;
  }

  ignorearr = [self.player, self.target];
  var_d4a24e02d124ac38 = self.target getlinkedchildren();

  if(isDefined(var_d4a24e02d124ac38) && var_d4a24e02d124ac38.size > 0) {
    ignorearr = array_combine(ignorearr, var_d4a24e02d124ac38);
  }

  if(!self.useoldlosverification) {
    for(i = 0; i < self.inreticlesortedids.size; i++) {
      id = self.inreticlesortedids[i];
      castend = self.origins[id];
      castresults = physics_raycast(caststart, castend, contents, ignorearr, 0, "physicsquery_closest", 1);

      if(!isDefined(castresults) || castresults.size == 0) {
        self.inlosid = id;
        return;
      }
    }

    return;
  }

  top = self.target getpointinbounds(0, 0, 1);
  trace = ray_trace(caststart, top, ignorearr, contents, 0);

  if(getDvar(@ "missiledebugdraw") == "<dev string:x1c>") {
    playerangles = self.player getplayerangles();
    forward = anglesToForward(playerangles);
    left = anglestoleft(playerangles);
    hitpos = trace["<dev string:x21>"];
    sphere(hitpos, 10, (1, 0, 0), 0, 1);
    sphere(hitpos, 10, (0, 1, 0), 1, 1);
    var_29f55613421c5159 = distance(caststart, hitpos);
    print3d(hitpos + left * -20, "<dev string:x2d>" + var_29f55613421c5159, (1, 1, 1), 1, 1, 1);
    var_ad791987651b3ba3 = self.player.origin;
    var_633eaa5f21008b6f = var_ad791987651b3ba3 + left * 50;
    line(var_633eaa5f21008b6f, hitpos, (0, 1, 0), 1, 1, 1);
    var_3eacd3938ccd4b6c = var_ad791987651b3ba3 + left * -50;
    line(var_3eacd3938ccd4b6c, hitpos, (0, 1, 0), 1, 1, 1);
    var_633eaa5f21008b6f += (0, 0, 100);
    line(var_633eaa5f21008b6f, hitpos, (0, 1, 0), 1, 1, 1);
    var_3eacd3938ccd4b6c += (0, 0, 100);
    line(var_3eacd3938ccd4b6c, hitpos, (0, 1, 0), 1, 1, 1);
  }

  if(trace["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  front = self.target getpointinbounds(1, 0, 0);
  trace = ray_trace(caststart, front, ignorearr, contents, 0);

  if(trace["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  back = self.target getpointinbounds(-1, 0, 0);
  trace = ray_trace(caststart, back, ignorearr, contents, 0);

  if(trace["fraction"] == 1) {
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

function debug_init() {
  setdevdvarifuninitialized(@ "hash_ad918199a0825d3a", 125);
  setdevdvarifuninitialized(@ "hash_84a8019a3bb27871", 250);
  setdevdvarifuninitialized(@ "hash_ffbdbf4d8f631e47", 125);
  setdevdvarifuninitialized(@ "hash_84a8059a3bb2813d", 425);
  setdevdvarifuninitialized(@ "hash_1578b7af746ab2fb", 125);
  setdevdvarifuninitialized(@ "hash_6fc78931494d8833", 250);
  setdevdvarifuninitialized(@ "hash_60e1bbd430b85fe9", 140);
  setdevdvarifuninitialized(@ "hash_fead31902c16c7ef", 215);
  setdevdvarifuninitialized(@ "hash_9b2345c5373f7e68", 30);
  setdevdvarifuninitialized(@ "hash_a6d283ccfd72e0d2", 5);
  setdevdvarifuninitialized(@ "hash_c3840a33843aa1f2", 15);
  setdevdvarifuninitialized(@ "hash_5a2bc3bd648b860c", 42);
  setdevdvarifuninitialized(@ "hash_9bb2d0feba0e1fde", 5);
}

function function_b787474070c5281b(jackal) {
  jackal endon("<dev string:x31>");
  spheresize = 50;

  while(true) {
    forward = anglesToForward(jackal.angles);
    right = anglestoright(jackal.angles);
    up = anglestoup(jackal.angles);
    origin = jackal.origin;
    centerpos = jackal.origin;
    centerpos += up * getdvarfloat(@ "hash_ad918199a0825d3a", 0);
    frontpos = origin;
    frontpos += forward * getdvarfloat(@ "hash_84a8019a3bb27871", 0);
    frontpos += up * getdvarfloat(@ "hash_ffbdbf4d8f631e47", 0);
    backpos = origin;
    backpos += -1 * forward * getdvarfloat(@ "hash_84a8059a3bb2813d", 0);
    backpos += up * getdvarfloat(@ "hash_1578b7af746ab2fb", 0);
    leftpos = origin;
    leftpos += -1 * right * getdvarfloat(@ "hash_6fc78931494d8833", 0);
    leftpos += -1 * forward * getdvarfloat(@ "hash_fead31902c16c7ef", 0);
    leftpos += up * getdvarfloat(@ "hash_60e1bbd430b85fe9", 0);
    rightpos = origin;
    rightpos += right * getdvarfloat(@ "hash_6fc78931494d8833", 0);
    rightpos += -1 * forward * getdvarfloat(@ "hash_fead31902c16c7ef", 0);
    rightpos += up * getdvarfloat(@ "hash_60e1bbd430b85fe9", 0);
    thread drawsphere(centerpos, spheresize, 0.05, (1, 0, 0));
    thread drawsphere(frontpos, spheresize, 0.05, (1, 0, 0));
    thread drawsphere(backpos, spheresize, 0.05, (1, 0, 0));
    thread drawsphere(leftpos, spheresize, 0.05, (1, 0, 0));
    thread drawsphere(rightpos, spheresize, 0.05, (1, 0, 0));
    waitframe();
  }
}

function function_86fc943ed3331734(supertrophy) {
  supertrophy endon("<dev string:x31>");
  spheresize = 4;

  while(true) {
    up = anglestoup(supertrophy.angles);
    origin = supertrophy.origin;
    toppos = origin;
    toppos += up * getdvarfloat(@ "hash_9b2345c5373f7e68", 0);
    botpos = origin;
    botpos += up * getdvarfloat(@ "hash_a6d283ccfd72e0d2", 0);
    thread drawsphere(toppos, spheresize, 0.05, (1, 0, 0));
    thread drawsphere(botpos, spheresize, 0.05, (1, 0, 0));
    waitframe();
  }
}

function function_5942767696e14755(microturret) {
  microturret endon("<dev string:x31>");
  spheresize = 4;

  while(true) {
    up = anglestoup(microturret.angles);
    origin = microturret.origin;
    centerpos = origin;
    centerpos += up * getdvarfloat(@ "hash_c3840a33843aa1f2", 0);
    thread drawsphere(centerpos, spheresize, 0.05, (1, 0, 0));
    waitframe();
  }
}

function function_7ea2aeeed11a82c8(shocksentry) {
  shocksentry endon("<dev string:x31>");
  spheresize = 4;

  while(true) {
    up = anglestoup(shocksentry.angles);
    origin = shocksentry.origin;
    toppos = origin;
    toppos += up * getdvarfloat(@ "hash_5a2bc3bd648b860c", 0);
    botpos = origin;
    botpos += up * getdvarfloat(@ "hash_9bb2d0feba0e1fde", 0);
    thread drawsphere(toppos, spheresize, 0.05, (1, 0, 0));
    thread drawsphere(botpos, spheresize, 0.05, (1, 0, 0));
    waitframe();
  }
}

function function_5875284c0e0f1e40(target) {
  if(getDvar(@ "missiledebugdraw") != "<dev string:x3a>") {
    return;
  }

  if(!isDefined(target)) {
    return;
  }

  org = target.origin;
  drawstar(org);
  org = target getpointinbounds(1, 0, 0);
  drawstar(org);
  org = target getpointinbounds(-1, 0, 0);
  drawstar(org);
}

function drawstar(point) {
  line(point + (10, 0, 0), point - (10, 0, 0));
  line(point + (0, 10, 0), point - (0, 10, 0));
  line(point + (0, 0, 10), point - (0, 0, 10));
}

# /