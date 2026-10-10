/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\equipment\cp_stinger.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_stinger;

function initstingerusage() {
  self.stingerstage = undefined;
  self.stingertarget = undefined;
  self.stingerlockstarttime = undefined;
  self.stingerlostsightlinetime = undefined;
  thread resetstingerlockingondeath();
}

function resetstingerlocking() {
  if(!isDefined(self.stingeruseentered)) {
    return;
  }

  self.stingeruseentered = undefined;
  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");
  self notify("stinger_lock_lost");
  self weaponlockfree();
  self stoplocalsound("maaws_reticle_tracking");
  self stoplocalsound("maaws_reticle_locked");
  removehudincoming_attacker(self.stingertarget);
  initstingerusage();
}

function resetstingerlockingondeath() {
  self endon("disconnect");
  self notify("ResetStingerLockingOnDeath");
  self endon("ResetStingerLockingOnDeath");

  for(;;) {
    self waittill("death");
    resetstingerlocking();
  }
}

function watchlauncherusage() {
  self endon("death_or_disconnect");

  while(true) {
    weapon = self getcurrentweapon();
    runlauncherlogic(weapon.basename);

    switch (weapon.basename) {
      case #"hash_3e782fd775b72022":
      case #"hash_a9e31b8ffd42a67b":
      case #"hash_e704ecf8710c6f57":
        thread initstingerusage();
        break;
      case #"hash_5cbb3a1a84d47f1d":
        break;
    }
  }
}

function runlauncherlogic(weaponname) {
  self endon("death_or_disconnect");

  switch (weaponname) {
    case #"hash_3e782fd775b72022":
    case #"hash_a9e31b8ffd42a67b":
    case #"hash_e704ecf8710c6f57":
      thread stingerusageloop();
      break;
    case #"hash_5cbb3a1a84d47f1d":
      break;
  }

  self waittill("weapon_change");
}

function loopstingerlockingfeedback() {
  self endon("stop_javelin_locking_feedback");
  self endon("end_launcher");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingertarget) && self.stingertarget == level.chopper.gunner) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.ac130player) && isDefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_tracking");
    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.6;
  }
}

function loopstingerlockedfeedback() {
  self endon("stop_javelin_locked_feedback");
  self endon("end_launcher");
  self playlocalsound("maaws_reticle_locked");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingertarget) && self.stingertarget == level.chopper.gunner) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.ac130player) && isDefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.25;
  }
}

function softsighttest(stingtargstruct) {
  lost_sight_limit = 500;

  if(istrue(level.faster_lockon)) {
    lost_sight_limit = 1500;
  }

  if(stingtargstruct stingtargstruct_isinlos()) {
    self.stingerlostsightlinetime = 0;
    return true;
  }

  if(self.stingerlostsightlinetime == 0) {
    self.stingerlostsightlinetime = gettime();
  }

  timepassed = gettime() - self.stingerlostsightlinetime;

  if(timepassed >= lost_sight_limit) {
    resetstingerlocking();
    return false;
  }

  return true;
}

function stingerusage() {
  if(self playerads() < 0.95) {
    resetstingerlocking();
    return;
  }

  self.stingeruseentered = 1;

  if(!isDefined(self.stingerstage)) {
    self.stingerstage = 0;
  }

  function_ea032d8f50d4fef2(self.stingertarget);

  if(self.stingerstage == 0) {
    targets = lockonlaunchers_gettargetarray(0);

    if(targets.size == 0) {
      return;
    }

    org = self.origin;
    targets = sortbydistance(targets, org);
    stingtargstruct = undefined;
    var_9da8a1d3ba23c681 = 0;

    foreach(target in targets) {
      if(!isDefined(target)) {
        continue;
      }

      stingtargstruct = stingtargstruct_create(self, target);
      stingtargstruct stingtargstruct_getoffsets();
      stingtargstruct stingtargstruct_getorigins();
      stingtargstruct stingtargstruct_getinreticle();

      if(stingtargstruct stingtargstruct_isinreticle()) {
        var_9da8a1d3ba23c681 = 1;
        break;
      }
    }

    if(!var_9da8a1d3ba23c681) {
      return;
    }

    stingtargstruct stingtargstruct_getinlos();

    if(!stingtargstruct stingtargstruct_isinlos()) {
      return;
    }

    self.stingertarget = stingtargstruct.target;
    self.stingerlockstarttime = gettime();
    self.stingerstage = 1;
    self.stingerlostsightlinetime = 0;
    addhudincoming_attacker(self.stingertarget);
    thread loopstingerlockingfeedback();
  }

  if(self.stingerstage == 1) {
    if(!isDefined(self.stingertarget)) {
      resetstingerlocking();
      return;
    }

    stingtargstruct = stingtargstruct_create(self, self.stingertarget);
    stingtargstruct stingtargstruct_getoffsets();
    stingtargstruct stingtargstruct_getorigins();
    stingtargstruct stingtargstruct_getinreticle();

    if(!stingtargstruct stingtargstruct_isinreticle()) {
      resetstingerlocking();
      return;
    }

    stingtargstruct stingtargstruct_getinlos();

    if(!softsighttest(stingtargstruct)) {
      return;
    }

    timepassed = gettime() - self.stingerlockstarttime;

    if(istrue(level.faster_lockon)) {
      if(timepassed < 250) {
        return;
      }
    } else if(timepassed < 500) {
      return;
    }

    self notify("stop_javelin_locking_feedback");
    thread loopstingerlockedfeedback();
    offset = undefined;
    stinger_finalizelock(stingtargstruct);

    if(isDefined(level.activekillstreaks)) {}

    self.stingerstage = 2;
  }

  if(self.stingerstage == 2) {
    if(!isDefined(self.stingertarget)) {
      resetstingerlocking();
      return;
    }

    stingtargstruct = stingtargstruct_create(self, self.stingertarget);
    stingtargstruct stingtargstruct_getoffsets();
    stingtargstruct stingtargstruct_getorigins();
    stingtargstruct stingtargstruct_getinreticle();
    stingtargstruct stingtargstruct_getinlos();

    if(!softsighttest(stingtargstruct)) {
      return;
    } else {
      stinger_finalizelock(stingtargstruct);
    }

    if(!stingtargstruct stingtargstruct_isinreticle()) {
      resetstingerlocking();
      return;
    }
  }
}

function lockonlaunchers_gettargetarray(addcharacters) {
  targets = [];
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(level.teambased) {
    if(isDefined(addcharacters) && addcharacters == 1) {
      foreach(char in level.characters) {
        if(isDefined(char) && isalive(char) && (char.team != self.team || var_e688b198aa9a4b3f)) {
          targets[targets.size] = char;
        }
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(streak in level.activekillstreaks) {
        if(isDefined(streak.affectedbylockon) && (streak.team != self.team || var_e688b198aa9a4b3f)) {
          targets[targets.size] = streak;
        }
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(streak in level.all_spawned_vehicles) {
        targets[targets.size] = streak;
      }
    }

    if(isDefined(level.remote_tanks)) {
      foreach(streak in level.remote_tanks) {
        targets[targets.size] = streak;
      }
    }

    bradleys = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

    foreach(bradley in bradleys) {
      if(bradley.team != self.team || var_e688b198aa9a4b3f) {
        targets[targets.size] = bradley;
      }
    }

    technicals = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("technical");

    foreach(technical in technicals) {
      if(isDefined(technical.team) && technical.team != self.team || var_e688b198aa9a4b3f) {
        targets[targets.size] = technical;
      }
    }

    littlebirds = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");

    foreach(littlebird in littlebirds) {
      if(littlebird.team != self.team || var_e688b198aa9a4b3f) {
        targets[targets.size] = littlebird;
      }
    }

    tacrovers = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("tac_rover");

    foreach(var_af4e3d6d8c66ff39 in tacrovers) {
      if(var_af4e3d6d8c66ff39.team != self.team || var_e688b198aa9a4b3f) {
        targets[targets.size] = var_af4e3d6d8c66ff39;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(ac130.team != self.team || var_e688b198aa9a4b3f) {
            targets[targets.size] = ac130;
          }
        }
      }
    }
  } else {
    if(isDefined(addcharacters) && addcharacters == 1) {
      foreach(char in level.characters) {
        if((!isDefined(char) || !isalive(char)) && !var_e688b198aa9a4b3f) {
          continue;
        }

        targets[targets.size] = char;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(streak in level.activekillstreaks) {
        if(isDefined(streak.affectedbylockon) && (isDefined(streak.owner) && streak.owner != self || var_e688b198aa9a4b3f)) {
          targets[targets.size] = streak;
        }
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(streak in level.all_spawned_vehicles) {
        targets[targets.size] = streak;
      }
    }

    if(isDefined(level.remote_tanks)) {
      foreach(streak in level.remote_tanks) {
        targets[targets.size] = streak;
      }
    }

    if(isDefined(level.technicals)) {
      foreach(technical in level.technicals) {
        if(isDefined(technical.owner) && technical.owner != self || var_e688b198aa9a4b3f) {
          targets[targets.size] = technical;
        }
      }
    }

    bradleys = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

    foreach(bradley in bradleys) {
      if(bradley.owner != self || var_e688b198aa9a4b3f) {
        targets[targets.size] = bradley;
      }
    }

    technicals = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("technical");

    foreach(technical in technicals) {
      if(technical.owner != self || var_e688b198aa9a4b3f) {
        targets[targets.size] = technical;
      }
    }

    littlebirds = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");

    foreach(littlebird in littlebirds) {
      if(littlebird.owner != self || var_e688b198aa9a4b3f) {
        targets[targets.size] = littlebird;
      }
    }

    tacrovers = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("tac_rover");

    foreach(var_af4e3d6d8c66ff39 in tacrovers) {
      if(var_af4e3d6d8c66ff39.owner != self || var_e688b198aa9a4b3f) {
        targets[targets.size] = var_af4e3d6d8c66ff39;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(ac130.owner != self || var_e688b198aa9a4b3f) {
            targets[targets.size] = ac130;
          }
        }
      }
    }
  }

  cleaned_array = [];

  foreach(guy in targets) {
    if(isDefined(guy)) {
      cleaned_array[cleaned_array.size] = guy;
    }
  }

  targets = cleaned_array;
  return targets;
}

function stingerusageloop() {
  if(!isPlayer(self)) {
    return;
  }

  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  initstingerusage();

  for(;;) {
    wait 0.05;
    stingerusage();
  }
}

function stinger_finalizelock(stingtargstruct) {
  offset = undefined;

  if(isDefined(stingtargstruct.inlosid)) {
    offset = stingtargstruct.offsets[stingtargstruct.inlosid];
    offset = (offset[1], -1 * offset[0], offset[2]);
  } else {
    offset = (0, 0, 0);
  }

  self weaponlockfinalize(self.stingertarget, offset);
}

function addhudincoming_attacker(target) {
  if(!isDefined(target)) {
    return;
  }

  var_5e48d2fe6f684a18 = target;

  if(isDefined(target.owner)) {
    var_5e48d2fe6f684a18 = target.owner;
  }

  if(!isPlayer(var_5e48d2fe6f684a18)) {
    return;
  }

  var_5e48d2fe6f684a18 setclientomnvar("ui_killstreak_missile_warn", 1);
}

function removehudincoming_attacker(target) {
  if(!isDefined(target)) {
    return;
  }

  var_5e48d2fe6f684a18 = target.owner;

  if(!isPlayer(var_5e48d2fe6f684a18)) {
    return;
  }

  var_5e48d2fe6f684a18 setclientomnvar("ui_killstreak_missile_warn", 0);
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

  if(isapache(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
    return;
  }

  if(isac130(self.target)) {
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

  if(isscramblerdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  if(isradarhelicopter(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -30);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "bradley") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
    return;
  }

  self.offsets[self.offsets.size] = (0, 0, 0);
}

function isapache(ent) {
  if(!isDefined(ent.streakinfo)) {
    return false;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return false;
  }

  ischoppergunner = ent.streakinfo.streakname == "chopper_gunner";
  var_15cd55a03b5c886b = ent.streakinfo.streakname == "jackal";
  return ischoppergunner || var_15cd55a03b5c886b;
}

function isclusterstrike(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  var_30c3ced8e8637755 = ent.streakinfo.streakname == "toma_strike";
  return var_30c3ced8e8637755;
}

function isuav(ent) {
  if(!isDefined(ent.streakinfo)) {
    return false;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return false;
  }

  if(ent.streakinfo.streakname == "uav" || ent.streakinfo.streakname == "counter_uav" || ent.streakinfo.streakname == "directional_uav") {
    return true;
  }

  return false;
}

function isac130(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  var_ab8d41683a88cb = ent.streakinfo.streakname == "ac130";
  return var_ab8d41683a88cb;
}

function isradardrone(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  isradar = ent.streakinfo.streakname == "radar_drone_escort" || ent.streakinfo.streakname == "radar_drone_recon";
  return isradar;
}

function isscramblerdrone(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  isscrambler = ent.streakinfo.streakname == "scrambler_drone_guard";
  return isscrambler;
}

function isradarhelicopter(ent) {
  if(!isDefined(ent.streakinfo)) {
    return 0;
  }

  if(!isDefined(ent.streakinfo.streakname)) {
    return 0;
  }

  isradar = ent.streakinfo.streakname == "radar_drone_overwatch";
  return isradar;
}

function isturret(ent) {
  return isDefined(ent.classname) && ent.classname == "misc_turret";
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

        if(distsqr <= 7225) {
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
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
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

  trace = ray_trace(caststart, self.origins[0], ignorearr, contents, 0);

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
  jackal endon("<dev string:x1c>");
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
  supertrophy endon("<dev string:x1c>");
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
  microturret endon("<dev string:x1c>");
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
  shocksentry endon("<dev string:x1c>");
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

function function_ea032d8f50d4fef2(target) {
  if(getDvar(@ "missiledebugdraw") != "<dev string:x22>") {
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