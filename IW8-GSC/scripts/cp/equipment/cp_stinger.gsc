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
    var0 = self getcurrentweapon();
    runlauncherlogic(var0.basename);

    switch (var0.basename) {
      case "iw8_la_kgolf_mp":
      case "iw8_la_gromeo_mp":
        thread initstingerusage();
        break;
      case "iw8_la_juliet_mp":
        break;
    }
  }
}

function runlauncherlogic(var0) {
  self endon("death_or_disconnect");

  switch (var0) {
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

function softsighttest(var0) {
  var1 = 500;

  if(stingtargstruct_isinlos(var0)) {
    self.stingerlostsightlinetime = 0;
    return true;
  }

  if(self.stingerlostsightlinetime == 0) {
    self.stingerlostsightlinetime = gettime();
  }

  var2 = gettime() - self.stingerlostsightlinetime;

  if(var2 >= var1) {
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
    var0 = lockonlaunchers_gettargetarray(0);

    if(var0.size == 0) {
      return;
    }

    var1 = self.origin;
    var0 = sortbydistance(var0, var1);
    var2 = undefined;
    var3 = 0;

    foreach(var5 in var0) {
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

    self.stingertarget = var2.target;
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

    var2 = stingtargstruct_create(self, self.stingertarget);
    stingtargstruct_getoffsets(var2);
    stingtargstruct_getorigins(var2);
    stingtargstruct_getinreticle(var2);

    if(!stingtargstruct_isinreticle(var2)) {
      resetstingerlocking();
      return;
    }

    stingtargstruct_getinlos(var2);

    if(!softsighttest(var2)) {
      return;
    }

    var7 = gettime() - self.stingerlockstarttime;

    if(var7 < 500) {
      return;
    }

    self notify("stop_javelin_locking_feedback");
    thread loopstingerlockedfeedback();
    var8 = undefined;
    stinger_finalizelock(var2);

    if(isDefined(level.activekillstreaks)) {}

    self.stingerstage = 2;
  }

  if(self.stingerstage == 2) {
    if(!isDefined(self.stingertarget)) {
      resetstingerlocking();
      return;
    }

    var2 = stingtargstruct_create(self, self.stingertarget);
    stingtargstruct_getoffsets(var2);
    stingtargstruct_getorigins(var2);
    stingtargstruct_getinreticle(var2);
    stingtargstruct_getinlos(var2);

    if(!softsighttest(var2)) {
      return;
    } else {
      stinger_finalizelock(var2);
    }

    if(!stingtargstruct_isinreticle(var2)) {
      resetstingerlocking();
      return;
    }

    return;
  }
}

function lockonlaunchers_gettargetarray(var0) {
  var1 = [];
  var2 = 0;

  if(level.teambased) {
    if(isDefined(var0) && var0 == 1) {
      foreach(var4 in level.characters) {
        if(isDefined(var4) && isalive(var4) && (var4.team != self.team || var2)) {
          var1 = var4;
        }
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var7 in level.activekillstreaks) {
        if(isDefined(var7.affectedbylockon) && (var7.team != self.team || var2)) {
          var1 = var7;
        }
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(var7 in level.all_spawned_vehicles) {
        var1 = var7;
      }
    }

    if(isDefined(level.remote_tanks)) {
      foreach(var7 in level.remote_tanks) {
        var1 = var7;
      }
    }

    var13 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

    foreach(var15 in var13) {
      if(var15.team != self.team || var2) {
        var1 = var15;
      }
    }

    var17 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("technical");

    foreach(var19 in var17) {
      if(isDefined(var19.team) && var19.team != self.team || var2) {
        var1 = var19;
      }
    }

    var21 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");

    foreach(var23 in var21) {
      if(var23.team != self.team || var2) {
        var1 = var23;
      }
    }

    var25 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("tac_rover");

    foreach(var27 in var25) {
      if(var27.team != self.team || var2) {
        var1 = var27;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var30 in level.cratedropdata.ac130s) {
          if(var30.team != self.team || var2) {
            var1 = var30;
          }
        }
      }
    }
  } else {
    if(isDefined(var23) && var23 == 1) {
      foreach(var4 in level.characters) {
        if((!isDefined(var4) || !isalive(var4)) && !var27) {
          continue;
        }

        var25 = var4;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var7 in level.activekillstreaks) {
        if(isDefined(var7.affectedbylockon) && (isDefined(var7.owner) && var7.owner != self || var27)) {
          var25 = var7;
        }
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(var7 in level.all_spawned_vehicles) {
        var25 = var7;
      }
    }

    if(isDefined(level.remote_tanks)) {
      foreach(var7 in level.remote_tanks) {
        var25 = var7;
      }
    }

    if(isDefined(level.technicals)) {
      foreach(var19 in level.technicals) {
        if(isDefined(var19.owner) && var19.owner != self || var27) {
          var25 = var19;
        }
      }
    }

    var13 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

    foreach(var15 in var13) {
      if(var15.owner != self || var27) {
        var25 = var15;
      }
    }

    var17 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("technical");

    foreach(var19 in var17) {
      if(var19.owner != self || var27) {
        var25 = var19;
      }
    }

    var21 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");

    foreach(var23 in var21) {
      if(var23.owner != self || var27) {
        var25 = var23;
      }
    }

    var25 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("tac_rover");

    foreach(var27 in var25) {
      if(var27.owner != self || var27) {
        var25 = var27;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var30 in level.cratedropdata.ac130s) {
          if(var30.owner != self || var27) {
            var25 = var30;
          }
        }
      }
    }
  }

  var52 = [];

  foreach(var54 in var25) {
    if(isDefined(var54)) {
      var52 = var54;
    }
  }

  var25 = var52;
  return var25;
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

function stinger_finalizelock(var0) {
  var1 = undefined;

  if(isDefined(var0.inlosid)) {
    var1 = var0.offsets[var0.inlosid];
    var1 = (var1[1], -1 * var1[0], var1[2]);
  } else {
    var1 = (0, 0, 0);
  }

  self weaponlockfinalize(self.stingertarget, var1);
}

function addhudincoming_attacker(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = var0;

  if(isDefined(var0.owner) && !isplayerkillstreak(var0)) {
    var1 = var0.owner;
  }

  if(!isDefined(var1) || !isPlayer(var1)) {
    return;
  }

  var1 setclientomnvar("ui_killstreak_missile_warn", 1);
}

function removehudincoming_attacker(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = var0;

  if(!isplayerkillstreak(var0)) {
    if(!isDefined(var0.owner)) {
      return;
    }

    var1 = var0.owner;
  }

  if(!isDefined(var1) || !isPlayer(var1)) {
    return;
  }

  var1 setclientomnvar("ui_killstreak_missile_warn", 0);
}

function isplayerkillstreak(var0) {
  if(!isDefined(var0.activeplayerstreak)) {
    return 0;
  }

  switch (var0.activeplayerstreak) {
    default:
      return 0;
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

function isapache(var0) {
  if(!isDefined(var0.streakinfo)) {
    return false;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return false;
  }

  var1 = var0.streakinfo.streakname == "chopper_gunner";
  var2 = var0.streakinfo.streakname == "jackal";
  return var1 || var2;
}

function isclusterstrike(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "toma_strike";
  return var1;
}

function isuav(var0) {
  if(!isDefined(var0.streakinfo)) {
    return false;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return false;
  }

  if(var0.streakinfo.streakname == "uav" || var0.streakinfo.streakname == "counter_uav" || var0.streakinfo.streakname == "directional_uav") {
    return true;
  }

  return false;
}

function isac130(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "ac130";
  return var1;
}

function isradardrone(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "radar_drone_escort" || var0.streakinfo.streakname == "radar_drone_recon";
  return var1;
}

function isscramblerdrone(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "scrambler_drone_guard";
  return var1;
}

function isradarhelicopter(var0) {
  if(!isDefined(var0.streakinfo)) {
    return 0;
  }

  if(!isDefined(var0.streakinfo.streakname)) {
    return 0;
  }

  var1 = var0.streakinfo.streakname == "radar_drone_overwatch";
  return var1;
}

function isturret(var0) {
  return isDefined(var0.classname) && var0.classname == "misc_turret";
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

  var8 = scripts\engine\trace::ray_trace(var0, self.origins[0], var2, var1, 0);

  if(var8["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var9 = self.target getpointinbounds(1, 0, 0);
  var8 = scripts\engine\trace::ray_trace(var0, var9, var2, var1, 0);

  if(var8["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var10 = self.target getpointinbounds(-1, 0, 0);
  var8 = scripts\engine\trace::ray_trace(var0, var10, var2, var1, 0);

  if(var8["fraction"] == 1) {
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