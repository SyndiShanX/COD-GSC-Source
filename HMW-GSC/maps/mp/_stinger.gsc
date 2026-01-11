initstingerusage() {
  self.stingerstage = undefined;
  self.stingertarget = undefined;
  self.stingerlockstarttime = undefined;
  self.stingerlostsightlinetime = undefined;
  thread resetstingerlockingondeath();
}

resetstingerlocking() {
  if(!isDefined(self.stingeruseentered)) {
    return;
  }
  self.stingeruseentered = undefined;
  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");
  self weaponlockfree();
  initstingerusage();
}

resetstingerlockingondeath() {
  self endon("disconnect");
  self notify("ResetStingerLockingOnDeath");
  self endon("ResetStingerLockingOnDeath");
  level endon("game_ended");

  for(;;) {
    self waittill("death");
    resetstingerlocking();
  }
}

stillvalidstingerlock(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!self worldpointinreticle_circle(var_0.origin, 65, 85)) {
    return 0;
  }

  if(isDefined(level.ac130) && self.stingertarget == level.ac130.planemodel && !isDefined(level.ac130player)) {
    return 0;
  }

  return 1;
}

loopstingerlockingfeedback() {
  self endon("faux_spawn");
  self endon("stop_javelin_locking_feedback");
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingertarget) && self.stingertarget == level.chopper.gunner) {
      level.chopper.gunner playlocalsound("missile_locking");
    }

    if(isDefined(level.ac130player) && isDefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel) {
      level.ac130player playlocalsound("missile_locking");
    }

    self playlocalsound("h2_stinger_locking");
    self playrumbleonentity("ac130_25mm_fire");
    wait 0.6;
  }
}

loopstingerlockedfeedback() {
  self endon("faux_spawn");
  self endon("stop_javelin_locked_feedback");
  level endon("game_ended");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingertarget) && self.stingertarget == level.chopper.gunner) {
      level.chopper.gunner playlocalsound("missile_locking");
    }

    if(isDefined(level.ac130player) && isDefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel) {
      level.ac130player playlocalsound("missile_locking");
    }

    self playlocalsound("h2_stinger_locked");
    self playrumbleonentity("ac130_25mm_fire");
    wait 0.25;
  }
}

locksighttest(var_0) {
  var_1 = self getEye();

  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = sighttracepassed(var_1, var_0.origin, 0, var_0);

  if(var_2) {
    return 1;
  }

  var_3 = var_0 getpointinbounds(1, 0, 0);
  var_2 = sighttracepassed(var_1, var_3, 0, var_0);

  if(var_2) {
    return 1;
  }

  var_4 = var_0 getpointinbounds(-1, 0, 0);
  var_2 = sighttracepassed(var_1, var_4, 0, var_0);

  if(var_2) {
    return 1;
  }

  return 0;
}

stingerdebugdraw(var_0) {}

softsighttest() {
  var_0 = 500;

  if(locksighttest(self.stingertarget)) {
    self.stingerlostsightlinetime = 0;
    return 1;
  }

  if(self.stingerlostsightlinetime == 0) {
    self.stingerlostsightlinetime = gettime();
  }

  var_1 = gettime() - self.stingerlostsightlinetime;

  if(var_1 >= var_0) {
    resetstingerlocking();
    return 0;
  }

  return 1;
}

GetTargetList() {
  targets = [];

  if(maps\mp\_utility::invirtuallobby()) {
    return targets;
  }

  if(level.teamBased) {
    if(isDefined(level.chopper) && (level.chopper.team != self.team || level.chopper.owner == self)) {
      targets[targets.size] = level.chopper;
    }

    if(isDefined(level.ac130player) && level.ac130player.team != self.team) {
      targets[targets.size] = level.ac130.planemodel;
    }

    if(isDefined(level.harriers)) {
      foreach(harrier in level.harriers) {
        if(isDefined(harrier) && (harrier.team != self.team || (isDefined(harrier.owner) && harrier.owner == self))) {
          targets[targets.size] = harrier;
        }
      }
    }

    if(level.UAVModels[level.otherTeam[self.team]].size) {
      foreach(UAV in level.UAVModels[level.otherTeam[self.team]]) {
        targets[targets.size] = UAV;
      }
    }

    if(isDefined(level.littleBird)) {
      foreach(bird in level.littleBird) {
        if(!isDefined(bird)) {
          continue;
        }
        if(self.team != bird.owner.team || self == bird.owner) {
          targets[targets.size] = bird;
        }
      }
    }

  } else {
    if(isDefined(level.chopper) && (level.chopper.owner != self)) ///check for teams
      targets[targets.size] = level.chopper;

    if(isDefined(level.ac130player)) {
      targets[targets.size] = level.ac130.planemodel;
    }

    if(isDefined(level.harriers)) {
      foreach(harrier in level.harriers) {
        if(isDefined(harrier)) {
          targets[targets.size] = harrier;
        }
      }
    }

    if(level.UAVModels.size) {
      foreach(ownerGuid, UAV in level.UAVModels) {
        if(isDefined(UAV.owner) && UAV.owner == self) {
          continue;
        }
        targets[targets.size] = UAV;
      }
    }
  }

  return targets;
}

stingerusageloop() {
  if(!isplayer(self)) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  var_0 = 1000;
  initstingerusage();

  for(;;) {
    wait 0.05;

    if(self playerads() < 0.95) {
      resetstingerlocking();
      continue;
    }

    var_1 = self getcurrentweapon();

    if(issubstr(var_1, "stingerm7")) {
      continue;
    }
    if(var_1 != "stinger_mp" && var_1 != "at4_mp") {
      resetstingerlocking();
      continue;
    }

    self.stingeruseentered = 1;

    if(!isDefined(self.stingerstage)) {
      self.stingerstage = 0;
    }

    stingerdebugdraw(self.stingertarget);

    if(self.stingerstage == 0) {
      var_2 = gettargetlist();

      if(var_2.size == 0) {
        continue;
      }
      var_3 = [];

      foreach(var_5 in var_2) {
        if(!isDefined(var_5)) {
          continue;
        }
        var_6 = self worldpointinreticle_circle(var_5.origin, 65, 75);

        if(var_6) {
          var_3[var_3.size] = var_5;
        }
      }

      if(var_3.size == 0) {
        continue;
      }
      var_8 = sortbydistance(var_3, self.origin);

      if(!locksighttest(var_8[0])) {
        continue;
      }
      thread loopstingerlockingfeedback();
      self.stingertarget = var_8[0];
      self.stingerlockstarttime = gettime();
      self.stingerstage = 1;
      self.stingerlostsightlinetime = 0;
    }

    if(self.stingerstage == 1) {
      if(!stillvalidstingerlock(self.stingertarget)) {
        resetstingerlocking();
        continue;
      }

      var_9 = softsighttest();

      if(!var_9) {
        continue;
      }
      var_10 = gettime() - self.stingerlockstarttime;

      if(maps\mp\_utility::_hasperk("specialty_fasterlockon")) {
        if(var_10 < var_0 * 0.5) {
          continue;
        }
      } else if(var_10 < var_0) {
        continue;
      }
      self notify("stop_javelin_locking_feedback");
      thread loopstingerlockedfeedback();
      self weaponlockfinalize(self.stingertarget);
      self.stingerstage = 2;
    }

    if(self.stingerstage == 2) {
      var_9 = softsighttest();

      if(!var_9) {
        continue;
      }
      if(!stillvalidstingerlock(self.stingertarget)) {
        resetstingerlocking();
        continue;
      }
    }
  }
}