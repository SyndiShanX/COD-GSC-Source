/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_missilelauncher.gsc
***********************************************/

initmissilelauncherusage() {
  self.missilelauncherstage = undefined;
  self.missilelaunchertarget = undefined;
  self.missilelauncherlockstarttime = undefined;
  self.missilelauncherlostsightlinetime = undefined;
  thread resetmissilelauncherlockingondeath();
}

resetmissilelauncherlocking() {
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

  if(isDefined(self.missilelaunchertarget))
    scripts\cp_mp\utility\weapon_utility::removelockedon(self.missilelaunchertarget, self);

  initmissilelauncherusage();
}

resetmissilelauncherlockingondeath() {
  self endon("disconnect");
  self notify("ResetMissileLauncherLockingOnDeath");
  self endon("ResetMissileLauncherLockingOnDeath");

  for(;;) {
    self waittill("death");
    resetmissilelauncherlocking();
  }
}

loopmissilelauncherlockingfeedback() {
  self endon("death_or_disconnect");
  self endon("stop_javelin_locking_feedback");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner)
      level.gunshipplayer playlocalsound("maaws_incoming_lp");

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel)
      level.gunshipplayer playlocalsound("maaws_incoming_lp");

    self playlocalsound("maaws_reticle_tracking");
    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.6;
  }
}

loopmissilelauncherlockedfeedback() {
  self endon("death_or_disconnect");
  self endon("stop_javelin_locked_feedback");
  self playlocalsound("maaws_reticle_locked");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner)
      level.gunshipplayer playlocalsound("maaws_incoming_lp");

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel)
      level.gunshipplayer playlocalsound("maaws_incoming_lp");

    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.25;
  }
}

softsighttest(_id_1FE8EEB95943F79F) {
  _id_A4B9B562E1E9AA71 = 500;

  if(_id_1FE8EEB95943F79F stingtargstruct_isinlos()) {
    self.missilelauncherlostsightlinetime = 0;
    return 1;
  }

  if(self.missilelauncherlostsightlinetime == 0)
    self.missilelauncherlostsightlinetime = gettime();

  _id_3B5803E733581858 = gettime() - self.missilelauncherlostsightlinetime;

  if(_id_3B5803E733581858 >= _id_A4B9B562E1E9AA71) {
    resetmissilelauncherlocking();
    return 0;
  }

  return 1;
}

missilelauncherusage() {
  _id_E688B198AA9A4B3F = 0;

  if(self playerads() < 0.95) {
    resetmissilelauncherlocking();
    return;
  }

  self.missilelauncheruseentered = 1;

  if(!isDefined(self.missilelauncherstage))
    self.missilelauncherstage = 0;

  if(self.missilelauncherstage == 0) {
    targets = _id_74502A9E0EF1F19C::lockonlaunchers_gettargetarray(0);

    if(targets.size == 0) {
      return;
    }
    targets = sortbydistance(targets, self.origin);
    _id_1FE8EEB95943F79F = undefined;
    _id_C7F50DD357B9CDCF = 0;

    foreach(target in targets) {
      if(!isDefined(target)) {
        continue;
      }
      _id_1FE8EEB95943F79F = stingtargstruct_create(self, target);
      _id_1FE8EEB95943F79F stingtargstruct_getoffsets();
      _id_1FE8EEB95943F79F stingtargstruct_getorigins();
      _id_1FE8EEB95943F79F stingtargstruct_getinreticle();

      if(_id_1FE8EEB95943F79F stingtargstruct_isinreticle()) {
        _id_C7F50DD357B9CDCF = 1;
        break;
      }
    }

    if(!_id_C7F50DD357B9CDCF) {
      return;
    }
    _id_1FE8EEB95943F79F stingtargstruct_getinlos();

    if(!_id_1FE8EEB95943F79F stingtargstruct_isinlos()) {
      return;
    }
    self.missilelaunchertarget = _id_1FE8EEB95943F79F.target;
    self.missilelauncherlockstarttime = gettime();
    self.missilelauncherstage = 1;
    self.missilelauncherlostsightlinetime = 0;

    if(isDefined(self.missilelaunchertarget))
      scripts\cp_mp\utility\weapon_utility::addlockedon(self.missilelaunchertarget, self);

    thread loopmissilelauncherlockingfeedback();
  }

  if(self.missilelauncherstage == 1) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!_id_E688B198AA9A4B3F && (self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.missilelaunchertarget, self))) {
      resetmissilelauncherlocking();
      return;
    }

    _id_1FE8EEB95943F79F = stingtargstruct_create(self, self.missilelaunchertarget);
    _id_1FE8EEB95943F79F stingtargstruct_getoffsets();
    _id_1FE8EEB95943F79F stingtargstruct_getorigins();
    _id_1FE8EEB95943F79F stingtargstruct_getinreticle();
    self.missilelaunchertarget notify("lockon_evade");

    if(!_id_1FE8EEB95943F79F stingtargstruct_isinreticle()) {
      resetmissilelauncherlocking();
      return;
    }

    _id_1FE8EEB95943F79F stingtargstruct_getinlos();

    if(!softsighttest(_id_1FE8EEB95943F79F)) {
      return;
    }
    _id_3B5803E733581858 = gettime() - self.missilelauncherlockstarttime;

    if(scripts\cp\utility::_hasperk("specialty_fasterlockon")) {
      if(_id_3B5803E733581858 < 250.0)
        return;
    } else if(_id_3B5803E733581858 < 500) {
      return;
    }
    self notify("stop_javelin_locking_feedback");
    thread loopmissilelauncherlockedfeedback();
    offset = undefined;
    missilelauncher_finalizelock(_id_1FE8EEB95943F79F);
    self.missilelauncherstage = 2;
  }

  if(self.missilelauncherstage == 2) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!_id_E688B198AA9A4B3F && (self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.missilelaunchertarget, self))) {
      resetmissilelauncherlocking();
      return;
    }

    _id_1FE8EEB95943F79F = stingtargstruct_create(self, self.missilelaunchertarget);
    _id_1FE8EEB95943F79F stingtargstruct_getoffsets();
    _id_1FE8EEB95943F79F stingtargstruct_getorigins();
    _id_1FE8EEB95943F79F stingtargstruct_getinreticle();
    _id_1FE8EEB95943F79F stingtargstruct_getinlos();

    if(!softsighttest(_id_1FE8EEB95943F79F))
      return;
    else
      missilelauncher_finalizelock(_id_1FE8EEB95943F79F);

    if(!_id_1FE8EEB95943F79F stingtargstruct_isinreticle()) {
      resetmissilelauncherlocking();
      return;
    }
  }
}

missilelauncherusageloop() {
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

missilelauncher_finalizelock(_id_1FE8EEB95943F79F) {
  offset = undefined;

  if(isDefined(_id_1FE8EEB95943F79F.inlosid)) {
    offset = _id_1FE8EEB95943F79F.offsets[_id_1FE8EEB95943F79F.inlosid];
    offset = (offset[1], -1 * offset[0], offset[2]);
  } else
    offset = (0, 0, 0);

  self weaponlockfinalize(self.missilelaunchertarget, offset);
}

addhudincoming_attacker(target) {
  if(!isDefined(target)) {
    return;
  }
  _id_5E48D2FE6F684A18 = target;

  if(isDefined(target.owner))
    _id_5E48D2FE6F684A18 = target.owner;

  if(!isDefined(_id_5E48D2FE6F684A18) || !isPlayer(_id_5E48D2FE6F684A18))
    return;
}

removehudincoming_attacker(target) {
  if(!isDefined(target)) {
    return;
  }
  _id_5E48D2FE6F684A18 = target;

  if(!isDefined(target.owner)) {
    return;
  }
  _id_5E48D2FE6F684A18 = target.owner;

  if(!isDefined(_id_5E48D2FE6F684A18) || !isPlayer(_id_5E48D2FE6F684A18))
    return;
}

stingtargstruct_create(player, target) {
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

stingtargstruct_getoffsets() {
  self.offsets = [];

  if(scripts\cp\utility\entity::ischoppergunner(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isbossheli(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::issupporthelo(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -100);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isgunship(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isclusterstrike(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 40);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isradardrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isscramblerdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isradarhelicopter(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -30);
    self.useoldlosverification = 0;
  } else if(isDefined(self.target.vehiclename) && self.target.vehiclename == "light_tank") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
  } else
    self.offsets[self.offsets.size] = (0, 0, 0);
}

stingtargstruct_getorigins() {
  origin = self.target.origin;
  angles = self.target.angles;
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.offsets.size; _id_AC0E594AC96AA3A8++) {
    offset = self.offsets[_id_AC0E594AC96AA3A8];
    self.origins[_id_AC0E594AC96AA3A8] = origin + right * offset[0] + forward * offset[1] + up * offset[2];
  }
}

stingtargstruct_getinreticle() {
  foreach(id, origin in self.origins) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.origins.size; _id_AC0E594AC96AA3A8++) {
      _id_B8AA7ACC219D6829 = self.player worldpointtoscreenpos(self.origins[_id_AC0E594AC96AA3A8], 65);

      if(isDefined(_id_B8AA7ACC219D6829)) {
        _id_457471485336C961 = length2dsquared(_id_B8AA7ACC219D6829);

        if(_id_457471485336C961 <= 7225) {
          self.inreticlesortedids[self.inreticlesortedids.size] = _id_AC0E594AC96AA3A8;
          self.inreticledistssqr[_id_AC0E594AC96AA3A8] = _id_457471485336C961;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.inreticlesortedids.size; _id_AC0E594AC96AA3A8++) {
      for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 + 1; _id_AC0E5C4AC96AAA41 < self.inreticlesortedids.size; _id_AC0E5C4AC96AAA41++) {
        _id_766150B8375AFF90 = self.inreticlesortedids[_id_AC0E594AC96AA3A8];
        _id_A1A802F9A569B2F7 = self.inreticlesortedids[_id_AC0E5C4AC96AAA41];
        _id_8EBA9EC305D4A611 = self.inreticledistssqr[_id_766150B8375AFF90];
        _id_CF5F902786383F74 = self.inreticledistssqr[_id_A1A802F9A569B2F7];

        if(_id_CF5F902786383F74 < _id_8EBA9EC305D4A611) {
          _id_ACE88BEFE8A4F706 = _id_766150B8375AFF90;
          self.inreticlesortedids[_id_AC0E594AC96AA3A8] = _id_A1A802F9A569B2F7;
          self.inreticlesortedids[_id_AC0E5C4AC96AAA41] = _id_ACE88BEFE8A4F706;
        }
      }
    }
  }
}

stingtargstruct_getinlos() {
  caststart = self.player getEye();
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  _id_7C44F2C83CC7CF1E = [self.player, self.target];
  _id_D4A24E02D124AC38 = self.target getlinkedchildren();

  if(isDefined(_id_D4A24E02D124AC38) && _id_D4A24E02D124AC38.size > 0)
    _id_7C44F2C83CC7CF1E = scripts\engine\utility::array_combine(_id_7C44F2C83CC7CF1E, _id_D4A24E02D124AC38);

  if(!self.useoldlosverification) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.inreticlesortedids.size; _id_AC0E594AC96AA3A8++) {
      id = self.inreticlesortedids[_id_AC0E594AC96AA3A8];
      castend = self.origins[id];
      _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, _id_7C44F2C83CC7CF1E, 0, "physicsquery_closest", 1);

      if(!isDefined(_id_E021C2744CC7ED68) || _id_E021C2744CC7ED68.size == 0) {
        self.inlosid = id;
        return;
      }
    }
  } else {
    top = self.target getpointinbounds(0, 0, 1);
    trace = scripts\engine\trace::ray_trace(caststart, top, _id_7C44F2C83CC7CF1E, contents, 0);

    if(trace["fraction"] == 1) {
      self.inlosid = 0;
      return;
    }

    _id_CFF021654A47B60C = self.target getpointinbounds(1, 0, 0);
    trace = scripts\engine\trace::ray_trace(caststart, _id_CFF021654A47B60C, _id_7C44F2C83CC7CF1E, contents, 0);

    if(trace["fraction"] == 1) {
      self.inlosid = 0;
      return;
    }

    back = self.target getpointinbounds(-1, 0, 0);
    trace = scripts\engine\trace::ray_trace(caststart, back, _id_7C44F2C83CC7CF1E, contents, 0);

    if(trace["fraction"] == 1) {
      self.inlosid = 0;
      return;
    }
  }
}

stingtargstruct_isinreticle() {
  return self.inreticlesortedids.size > 0;
}

stingtargstruct_isinlos() {
  return isDefined(self.inlosid);
}