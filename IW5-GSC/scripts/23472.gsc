/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23472.gsc
**************************************/

init() {
  precacherumble("stinger_lock_rumble");

  foreach(var_1 in level.players) {}
  var_1 clearirtarget();

  foreach(var_1 in level.players) {
    var_1 thread stingerfirednotify();
    var_1 thread stingertoggleloop();
  }
}

clearirtarget() {
  if(!isDefined(self.stinger)) {
    self.stinger = spawnStruct();
  }
  self.stinger.stingerlockstarttime = 0;
  self.stinger.stingerlockstarted = 0;
  self.stinger.stingerlockfinalized = 0;
  self.stinger.stingertarget = undefined;
  self notify("stinger_irt_cleartarget");
  self notify("stop_lockon_sound");
  self notify("stop_locked_sound");
  self.stinger.stingerlocksound = undefined;
  self stoprumble("stinger_lock_rumble");
  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);
  self stoplocalsound("javelin_clu_lock");
  self stoplocalsound("javelin_clu_aquiring_lock");
}

stingerfirednotify() {
  for(;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();

    if(var_0 != "stinger") {
      continue;
    }
    self notify("stinger_fired");
  }
}

stingertoggleloop() {
  self endon("death");

  for(;;) {
    while(!playerstingerads()) {
      wait 0.05;
    }
    thread stingerirtloop();

    while(playerstingerads()) {
      wait 0.05;
    }
    self notify("stinger_IRT_off");
    clearirtarget();
  }
}

stingerirtloop() {
  self endon("death");
  self endon("stinger_IRT_off");
  var_0 = 1150;

  for(;;) {
    wait 0.05;

    if(self.stinger.stingerlockfinalized) {
      if(!isstillvalidtarget(self.stinger.stingertarget)) {
        clearirtarget();
        continue;
      }

      thread looplocallocksound("javelin_clu_lock", 0.75);
      settargettooclose(self.stinger.stingertarget);
      continue;
    }

    if(self.stinger.stingerlockstarted) {
      if(!isstillvalidtarget(self.stinger.stingertarget)) {
        clearirtarget();
        continue;
      }

      var_1 = gettime() - self.stinger.stingerlockstarttime;

      if(var_1 < var_0) {
        continue;
      }
      self notify("stop_lockon_sound");
      self.stinger.stingerlockfinalized = 1;
      self weaponlockfinalize(self.stinger.stingertarget);
      settargettooclose(self.stinger.stingertarget);
      continue;
    }

    var_2 = getbeststingertarget();

    if(!isDefined(var_2)) {
      continue;
    }
    self.stinger.stingertarget = var_2;
    self.stinger.stingerlockstarttime = gettime();
    self.stinger.stingerlockstarted = 1;
    thread looplocalseeksound("javelin_clu_aquiring_lock", 0.6);
  }
}

getbeststingertarget() {
  var_0 = target_getarray();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(insidestingerreticlenolock(var_0[var_2])) {
      var_1[var_1.size] = var_0[var_2];
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }
  var_3 = var_1[0];

  if(var_1.size > 1) {}

  return var_3;
}

insidestingerreticlenolock(var_0) {
  return target_isincircle(var_0, self, 65, 60);
}

insidestingerreticlelocked(var_0) {
  return target_isincircle(var_0, self, 65, 75);
}

isstillvalidtarget(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!target_istarget(var_0)) {
    return 0;
  }
  if(!insidestingerreticlelocked(var_0)) {
    return 0;
  }
  return 1;
}

playerstingerads() {
  var_0 = self getcurrentweapon();

  if(var_0 != "stinger") {
    return 0;
  }
  if(self playerads() == 1.0) {
    return 1;
  }
  return 0;
}

settargettooclose(var_0) {
  var_1 = 1000;

  if(!isDefined(var_0)) {
    return 0;
  }
  var_2 = distance2d(self.origin, var_0.origin);

  if(var_2 < var_1) {
    self.stinger.targettoclose = 1;
    self weaponlocktargettooclose(1);
  } else {
    self.stinger.targettoclose = 0;
    self weaponlocktargettooclose(0);
  }
}

looplocalseeksound(var_0, var_1) {
  self endon("stop_lockon_sound");
  self endon("death");

  for(;;) {
    self playlocalsound(var_0);
    self playRumbleOnEntity("stinger_lock_rumble");
    wait(var_1);
  }
}

looplocallocksound(var_0, var_1) {
  self endon("stop_locked_sound");
  self endon("death");

  if(isDefined(self.stinger.stingerlocksound)) {
    return;
  }
  self.stinger.stingerlocksound = 1;

  for(;;) {
    self playlocalsound(var_0);
    self playRumbleOnEntity("stinger_lock_rumble");
    wait(var_1 / 3);
    self playRumbleOnEntity("stinger_lock_rumble");
    wait(var_1 / 3);
    self playRumbleOnEntity("stinger_lock_rumble");
    wait(var_1 / 3);
    self stoprumble("stinger_lock_rumble");
  }

  self.stinger.stingerlocksound = undefined;
}