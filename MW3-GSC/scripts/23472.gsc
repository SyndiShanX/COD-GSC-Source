/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23472.gsc
**************************************/

init() {
  precacherumble("stinger_lock_rumble");

  foreach(var_1 in level.players) {}
  var_1 _id_5BA2();

  foreach(var_1 in level.players) {
    var_1 thread _id_5BA7();
    var_1 thread _id_5BA8();
  }
}

_id_5BA2() {
  if(!isDefined(self._id_5BA3)) {
    self._id_5BA3 = spawnStruct();

  }
  self._id_5BA3.stingerlockstarttime = 0;
  self._id_5BA3._id_5BA4 = 0;
  self._id_5BA3._id_5BA5 = 0;
  self._id_5BA3.stingertarget = undefined;
  self notify("stinger_irt_cleartarget");
  self notify("stop_lockon_sound");
  self notify("stop_locked_sound");
  self._id_5BA3._id_5BA6 = undefined;
  self stoprumble("stinger_lock_rumble");
  self weaponlockfree();
  self weaponlocktargettooclose(0);
  self weaponlocknoclearance(0);
  self stoplocalsound("javelin_clu_lock");
  self stoplocalsound("javelin_clu_aquiring_lock");
}

_id_5BA7() {
  for(;;) {
    self waittill("weapon_fired");
    var_0 = self getcurrentweapon();

    if(var_0 != "stinger") {
      continue;
    }
    self notify("stinger_fired");
  }
}

_id_5BA8() {
  self endon("death");

  for(;;) {
    while(!_id_5BAD()) {
      wait 0.05;

    }
    thread _id_5BA9();

    while(_id_5BAD()) {
      wait 0.05;

    }
    self notify("stinger_IRT_off");
    _id_5BA2();
  }
}

_id_5BA9() {
  self endon("death");
  self endon("stinger_IRT_off");
  var_0 = 1150;

  for(;;) {
    wait 0.05;

    if(self._id_5BA3._id_5BA5) {
      if(!_id_55A1(self._id_5BA3.stingertarget)) {
        _id_5BA2();
        continue;
      }

      thread _id_55A3("javelin_clu_lock", 0.75);
      _id_5BAE(self._id_5BA3.stingertarget);
      continue;
    }

    if(self._id_5BA3._id_5BA4) {
      if(!_id_55A1(self._id_5BA3.stingertarget)) {
        _id_5BA2();
        continue;
      }

      var_1 = gettime() - self._id_5BA3.stingerlockstarttime;

      if(var_1 < var_0) {
        continue;
      }
      self notify("stop_lockon_sound");
      self._id_5BA3._id_5BA5 = 1;
      self weaponlockfinalize(self._id_5BA3.stingertarget);
      _id_5BAE(self._id_5BA3.stingertarget);
      continue;
    }

    var_2 = _id_5BAA();

    if(!isDefined(var_2)) {
      continue;
    }
    self._id_5BA3.stingertarget = var_2;
    self._id_5BA3.stingerlockstarttime = gettime();
    self._id_5BA3._id_5BA4 = 1;
    thread looplocalseeksound("javelin_clu_aquiring_lock", 0.6);
  }
}

_id_5BAA() {
  var_0 = target_getarray();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(_id_5BAB(var_0[var_2])) {
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

_id_5BAB(var_0) {
  return target_isincircle(var_0, self, 65, 60);
}

_id_5BAC(var_0) {
  return target_isincircle(var_0, self, 65, 75);
}

_id_55A1(var_0) {
  if(!isDefined(var_0)) {
    return 0;

  }
  if(!target_istarget(var_0)) {
    return 0;

  }
  if(!_id_5BAC(var_0)) {
    return 0;

  }
  return 1;
}

_id_5BAD() {
  var_0 = self getcurrentweapon();

  if(var_0 != "stinger") {
    return 0;

  }
  if(self playerads() == 1.0) {
    return 1;

  }
  return 0;
}

_id_5BAE(var_0) {
  var_1 = 1000;

  if(!isDefined(var_0)) {
    return 0;

  }
  var_2 = distance2d(self.origin, var_0.origin);

  if(var_2 < var_1) {
    self._id_5BA3._id_5BAF = 1;
    self weaponlocktargettooclose(1);
  } else {
    self._id_5BA3._id_5BAF = 0;
    self weaponlocktargettooclose(0);
  }
}

looplocalseeksound(var_0, var_1) {
  self endon("stop_lockon_sound");
  self endon("death");

  for(;;) {
    self playlocalsound(var_0);
    self playrumbleonentity("stinger_lock_rumble");
    wait(var_1);
  }
}

_id_55A3(var_0, var_1) {
  self endon("stop_locked_sound");
  self endon("death");

  if(isDefined(self._id_5BA3._id_5BA6)) {
    return;
  }
  self._id_5BA3._id_5BA6 = 1;

  for(;;) {
    self playlocalsound(var_0);
    self playrumbleonentity("stinger_lock_rumble");
    wait(var_1 / 3);
    self playrumbleonentity("stinger_lock_rumble");
    wait(var_1 / 3);
    self playrumbleonentity("stinger_lock_rumble");
    wait(var_1 / 3);
    self stoprumble("stinger_lock_rumble");
  }

  self._id_5BA3._id_5BA6 = undefined;
}