/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_stinger.gsc
***********************************************/

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

  for(;;) {
    var_0 = self getcurrentweapon();
    runlauncherlogic(var_0.basename);

    switch (var_0.basename) {
      case "iw8_la_kgolf_mp":
      case "iw8_la_gromeo_mp":
        thread initstingerusage();
        break;
      case "iw8_la_juliet_mp":
        break;
    }
  }
}

function runlauncherlogic(var_0) {
  self endon("death_or_disconnect");

  switch (var_0) {
    case "iw8_la_kgolf_mp":
    case "iw8_la_gromeo_mp":
      thread stingerusageloop();
      break;
    case "iw8_la_juliet_mp":
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

function softsighttest(var_0) {
  var_1 = 500;

  if(stingtargstruct_isinlos(var_0)) {
    self.stingerlostsightlinetime = 0;
    return true;
  }

  if(self.stingerlostsightlinetime == 0) {
    self.stingerlostsightlinetime = gettime();
  }

  var_2 = gettime() - self.stingerlostsightlinetime;

  if(var_2 >= var_1) {
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

  if(self.stingerstage == 0) {
    var_0 = lockonlaunchers_gettargetarray(0);

    if(var_0.size == 0) {
      return;
    }

    var_1 = self.origin;
    var_0 = sortbydistance(var_0, var_1);
    var_2 = undefined;
    var_3 = 0;

    foreach(var_5 in var_0) {
      if(!isDefined(var_5)) {
        continue;
      }

      var_2 = stingtargstruct_create(self, var_5);
      stingtargstruct_getoffsets(var_2);
      stingtargstruct_getorigins(var_2);
      stingtargstruct_getinreticle(var_2);

      if(stingtargstruct_isinreticle(var_2)) {
        var_3 = 1;
        break;
      }
    }

    if(!var_3) {
      return;
    }

    stingtargstruct_getinlos(var_2);

    if(!stingtargstruct_isinlos(var_2)) {
      return;
    }

    self.stingertarget = var_2.target;
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

    var_2 = stingtargstruct_create(self, self.stingertarget);
    stingtargstruct_getoffsets(var_2);
    stingtargstruct_getorigins(var_2);
    stingtargstruct_getinreticle(var_2);

    if(!stingtargstruct_isinreticle(var_2)) {
      resetstingerlocking();
      return;
    }

    stingtargstruct_getinlos(var_2);

    if(!softsighttest(var_2)) {
      return;
    }

    var_7 = gettime() - self.stingerlockstarttime;

    if(var_7 < 500) {
      return;
    }

    self notify("stop_javelin_locking_feedback");
    thread loopstingerlockedfeedback();
    var_8 = undefined;
    stinger_finalizelock(var_2);

    if(isDefined(level.activekillstreaks)) {}

    self.stingerstage = 2;
  }

  if(self.stingerstage == 2) {
    if(!isDefined(self.stingertarget)) {
      resetstingerlocking();
      return;
    }

    var_2 = stingtargstruct_create(self, self.stingertarget);
    stingtargstruct_getoffsets(var_2);
    stingtargstruct_getorigins(var_2);
    stingtargstruct_getinreticle(var_2);
    stingtargstruct_getinlos(var_2);

    if(!softsighttest(var_2)) {
      return;
    } else {
      stinger_finalizelock(var_2);
    }

    if(!stingtargstruct_isinreticle(var_2)) {
      resetstingerlocking();
      return;
    }

    return;
  }
}

function lockonlaunchers_gettargetarray(var_0) {
  var_1 = [];
  var_2 = 0;

  if(level.teambased) {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_4 in level.characters) {
        if(isDefined(var_4) && isalive(var_4) && (var_4.team != self.team || var_2)) {
          var_1 = var_4;
        }
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_7 in level.activekillstreaks) {
        if(isDefined(var_7.affectedbylockon) && (var_7.team != self.team || var_2)) {
          var_1 = var_7;
        }
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(var_7 in level.all_spawned_vehicles) {
        var_1 = var_7;
      }
    }

    if(isDefined(level.remote_tanks)) {
      foreach(var_7 in level.remote_tanks) {
        var_1 = var_7;
      }
    }

    var_13 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

    foreach(var_15 in var_13) {
      if(var_15.team != self.team || var_2) {
        var_1 = var_15;
      }
    }

    var_17 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("technical");

    foreach(var_19 in var_17) {
      if(isDefined(var_19.team) && var_19.team != self.team || var_2) {
        var_1 = var_19;
      }
    }

    var_21 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");

    foreach(var_23 in var_21) {
      if(var_23.team != self.team || var_2) {
        var_1 = var_23;
      }
    }

    var_25 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("tac_rover");

    foreach(var_27 in var_25) {
      if(var_27.team != self.team || var_2) {
        var_1 = var_27;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var_30 in level.cratedropdata.ac130s) {
          if(var_30.team != self.team || var_2) {
            var_1 = var_30;
          }
        }
      }
    }
  } else {
    if(isDefined(var_23) && var_23 == 1) {
      foreach(var_4 in level.characters) {
        if((!isDefined(var_4) || !isalive(var_4)) && !var_27) {
          continue;
        }

        var_25 = var_4;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_7 in level.activekillstreaks) {
        if(isDefined(var_7.affectedbylockon) && (isDefined(var_7.owner) && var_7.owner != self || var_27)) {
          var_25 = var_7;
        }
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(var_7 in level.all_spawned_vehicles) {
        var_25 = var_7;
      }
    }

    if(isDefined(level.remote_tanks)) {
      foreach(var_7 in level.remote_tanks) {
        var_25 = var_7;
      }
    }

    if(isDefined(level.technicals)) {
      foreach(var_19 in level.technicals) {
        if(isDefined(var_19.owner) && var_19.owner != self || var_27) {
          var_25 = var_19;
        }
      }
    }

    var_13 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

    foreach(var_15 in var_13) {
      if(var_15.owner != self || var_27) {
        var_25 = var_15;
      }
    }

    var_17 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("technical");

    foreach(var_19 in var_17) {
      if(var_19.owner != self || var_27) {
        var_25 = var_19;
      }
    }

    var_21 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");

    foreach(var_23 in var_21) {
      if(var_23.owner != self || var_27) {
        var_25 = var_23;
      }
    }

    var_25 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("tac_rover");

    foreach(var_27 in var_25) {
      if(var_27.owner != self || var_27) {
        var_25 = var_27;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var_30 in level.cratedropdata.ac130s) {
          if(var_30.owner != self || var_27) {
            var_25 = var_30;
          }
        }
      }
    }
  }

  var_52 = [];

  foreach(var_54 in var_25) {
    if(isDefined(var_54)) {
      var_52 = var_54;
    }
  }

  var_25 = var_52;
  return var_25;
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

function stinger_finalizelock(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.inlosid)) {
    var_1 = var_0.offsets[var_0.inlosid];
    var_1 = (var_1[1], -1 * var_1[0], var_1[2]);
  } else {
    var_1 = (0, 0, 0);
  }

  self weaponlockfinalize(self.stingertarget, var_1);
}

function addhudincoming_attacker(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0;

  if(isDefined(var_0.owner) && !isplayerkillstreak(var_0)) {
    var_1 = var_0.owner;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }

  var_1 setclientomnvar("ui_killstreak_missile_warn", 1);
}

function removehudincoming_attacker(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0;

  if(!isplayerkillstreak(var_0)) {
    if(!isDefined(var_0.owner)) {
      return;
    }

    var_1 = var_0.owner;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }

  var_1 setclientomnvar("ui_killstreak_missile_warn", 0);
}

function isplayerkillstreak(var_0) {
  if(!isDefined(var_0.activeplayerstreak)) {
    return 0;
  }

  switch (var_0.activeplayerstreak) {
    default:
      return 0;
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

function isapache(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return false;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return false;
  }

  var_1 = var_0.streakinfo.streakname == "chopper_gunner";
  var_2 = var_0.streakinfo.streakname == "jackal";
  return var_1 || var_2;
}

function isclusterstrike(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "toma_strike";
  return var_1;
}

function isuav(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return false;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return false;
  }

  if(var_0.streakinfo.streakname == "uav" || var_0.streakinfo.streakname == "counter_uav" || var_0.streakinfo.streakname == "directional_uav") {
    return true;
  }

  return false;
}

function isac130(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "ac130";
  return var_1;
}

function isradardrone(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "radar_drone_escort" || var_0.streakinfo.streakname == "radar_drone_recon";
  return var_1;
}

function isscramblerdrone(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "scrambler_drone_guard";
  return var_1;
}

function isradarhelicopter(var_0) {
  if(!isDefined(var_0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var_0.streakinfo.streakname)) {
    return 0;
  }

  var_1 = var_0.streakinfo.streakname == "radar_drone_overwatch";
  return var_1;
}

function isturret(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "misc_turret";
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

        if(var_4 <= 7225) {
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
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
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

  var_8 = scripts\engine\trace::ray_trace(var_0, self.origins[0], var_2, var_1, 0);

  if(var_8["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var_9 = self.target getpointinbounds(1, 0, 0);
  var_8 = scripts\engine\trace::ray_trace(var_0, var_9, var_2, var_1, 0);

  if(var_8["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var_10 = self.target getpointinbounds(-1, 0, 0);
  var_8 = scripts\engine\trace::ray_trace(var_0, var_10, var_2, var_1, 0);

  if(var_8["fraction"] == 1) {
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