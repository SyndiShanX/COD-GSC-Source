/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_stinger.gsc
***********************************************/

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
  self notify("stinger_lock_lost");
  self weaponlockfree();
  self stoplocalsound("maaws_reticle_tracking");
  self stoplocalsound("maaws_reticle_locked");
  removehudincoming_attacker(self.stingertarget);
  initstingerusage();
}

resetstingerlockingondeath() {
  self endon("disconnect");
  self notify("ResetStingerLockingOnDeath");
  self endon("ResetStingerLockingOnDeath");

  for(;;) {
    self waittill("death");
    resetstingerlocking();
  }
}

watchlauncherusage() {
  self endon("death_or_disconnect");

  for(;;) {
    weapon = self getcurrentweapon();
    runlauncherlogic(weapon.basename);

    switch (weapon.basename) {
      case "iw8_la_kgolf_mp":
      case "iw8_la_gromeo_mp":
      case "iw9_la_gromeo_mp":
        thread initstingerusage();
        break;
      case "iw8_la_juliet_mp":
        break;
    }
  }
}

runlauncherlogic(weaponname) {
  self endon("death_or_disconnect");

  switch (weaponname) {
    case "iw8_la_kgolf_mp":
    case "iw8_la_gromeo_mp":
    case "iw9_la_gromeo_mp":
      thread stingerusageloop();
      break;
    case "iw8_la_juliet_mp":
      break;
  }

  self waittill("weapon_change");
}

loopstingerlockingfeedback() {
  self endon("stop_javelin_locking_feedback");
  self endon("end_launcher");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingertarget) && self.stingertarget == level.chopper.gunner)
      level.ac130player playlocalsound("maaws_incoming_lp");

    if(isDefined(level.ac130player) && isDefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel)
      level.ac130player playlocalsound("maaws_incoming_lp");

    self playlocalsound("maaws_reticle_tracking");
    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.6;
  }
}

loopstingerlockedfeedback() {
  self endon("stop_javelin_locked_feedback");
  self endon("end_launcher");
  self playlocalsound("maaws_reticle_locked");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingertarget) && self.stingertarget == level.chopper.gunner)
      level.ac130player playlocalsound("maaws_incoming_lp");

    if(isDefined(level.ac130player) && isDefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel)
      level.ac130player playlocalsound("maaws_incoming_lp");

    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.25;
  }
}

softsighttest(_id_1FE8EEB95943F79F) {
  _id_A4B9B562E1E9AA71 = 500;

  if(istrue(level._id_A2CEB61B8D6F9A0B))
    _id_A4B9B562E1E9AA71 = 1500;

  if(_id_1FE8EEB95943F79F stingtargstruct_isinlos()) {
    self.stingerlostsightlinetime = 0;
    return 1;
  }

  if(self.stingerlostsightlinetime == 0)
    self.stingerlostsightlinetime = gettime();

  _id_3B5803E733581858 = gettime() - self.stingerlostsightlinetime;

  if(_id_3B5803E733581858 >= _id_A4B9B562E1E9AA71) {
    resetstingerlocking();
    return 0;
  }

  return 1;
}

stingerusage() {
  if(self playerads() < 0.95) {
    resetstingerlocking();
    return;
  }

  self.stingeruseentered = 1;

  if(!isDefined(self.stingerstage))
    self.stingerstage = 0;

  if(self.stingerstage == 0) {
    targets = lockonlaunchers_gettargetarray(0);

    if(targets.size == 0) {
      return;
    }
    org = self.origin;
    targets = sortbydistance(targets, org);
    _id_1FE8EEB95943F79F = undefined;
    _id_9DA8A1D3BA23C681 = 0;

    foreach(target in targets) {
      if(!isDefined(target)) {
        continue;
      }
      _id_1FE8EEB95943F79F = stingtargstruct_create(self, target);
      _id_1FE8EEB95943F79F stingtargstruct_getoffsets();
      _id_1FE8EEB95943F79F stingtargstruct_getorigins();
      _id_1FE8EEB95943F79F stingtargstruct_getinreticle();

      if(_id_1FE8EEB95943F79F stingtargstruct_isinreticle()) {
        _id_9DA8A1D3BA23C681 = 1;
        break;
      }
    }

    if(!_id_9DA8A1D3BA23C681) {
      return;
    }
    _id_1FE8EEB95943F79F stingtargstruct_getinlos();

    if(!_id_1FE8EEB95943F79F stingtargstruct_isinlos()) {
      return;
    }
    self.stingertarget = _id_1FE8EEB95943F79F.target;
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

    _id_1FE8EEB95943F79F = stingtargstruct_create(self, self.stingertarget);
    _id_1FE8EEB95943F79F stingtargstruct_getoffsets();
    _id_1FE8EEB95943F79F stingtargstruct_getorigins();
    _id_1FE8EEB95943F79F stingtargstruct_getinreticle();

    if(!_id_1FE8EEB95943F79F stingtargstruct_isinreticle()) {
      resetstingerlocking();
      return;
    }

    _id_1FE8EEB95943F79F stingtargstruct_getinlos();

    if(!softsighttest(_id_1FE8EEB95943F79F)) {
      return;
    }
    _id_3B5803E733581858 = gettime() - self.stingerlockstarttime;

    if(istrue(level._id_A2CEB61B8D6F9A0B)) {
      if(_id_3B5803E733581858 < 250.0)
        return;
    } else if(_id_3B5803E733581858 < 500) {
      return;
    }
    self notify("stop_javelin_locking_feedback");
    thread loopstingerlockedfeedback();
    offset = undefined;
    stinger_finalizelock(_id_1FE8EEB95943F79F);

    if(isDefined(level.activekillstreaks)) {}

    self.stingerstage = 2;
  }

  if(self.stingerstage == 2) {
    if(!isDefined(self.stingertarget)) {
      resetstingerlocking();
      return;
    }

    _id_1FE8EEB95943F79F = stingtargstruct_create(self, self.stingertarget);
    _id_1FE8EEB95943F79F stingtargstruct_getoffsets();
    _id_1FE8EEB95943F79F stingtargstruct_getorigins();
    _id_1FE8EEB95943F79F stingtargstruct_getinreticle();
    _id_1FE8EEB95943F79F stingtargstruct_getinlos();

    if(!softsighttest(_id_1FE8EEB95943F79F))
      return;
    else
      stinger_finalizelock(_id_1FE8EEB95943F79F);

    if(!_id_1FE8EEB95943F79F stingtargstruct_isinreticle()) {
      resetstingerlocking();
      return;
    }
  }
}

lockonlaunchers_gettargetarray(_id_FE608D14719843BC) {
  targets = [];
  _id_E688B198AA9A4B3F = 0;

  if(level.teambased) {
    if(isDefined(_id_FE608D14719843BC) && _id_FE608D14719843BC == 1) {
      foreach(_id_B5517D24E9DC9A49 in level.characters) {
        if(isDefined(_id_B5517D24E9DC9A49) && isalive(_id_B5517D24E9DC9A49) && (_id_B5517D24E9DC9A49.team != self.team || _id_E688B198AA9A4B3F))
          targets[targets.size] = _id_B5517D24E9DC9A49;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(_id_153FDEE861E0F06F in level.activekillstreaks) {
        if(isDefined(_id_153FDEE861E0F06F.affectedbylockon) && (_id_153FDEE861E0F06F.team != self.team || _id_E688B198AA9A4B3F))
          targets[targets.size] = _id_153FDEE861E0F06F;
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(_id_153FDEE861E0F06F in level.all_spawned_vehicles)
      targets[targets.size] = _id_153FDEE861E0F06F;
    }

    if(isDefined(level.remote_tanks)) {
      foreach(_id_153FDEE861E0F06F in level.remote_tanks)
      targets[targets.size] = _id_153FDEE861E0F06F;
    }

    _id_DDDC24BA34981C53 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

    foreach(bradley in _id_DDDC24BA34981C53) {
      if(bradley.team != self.team || _id_E688B198AA9A4B3F)
        targets[targets.size] = bradley;
    }

    technicals = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("technical");

    foreach(technical in technicals) {
      if(isDefined(technical.team) && technical.team != self.team || _id_E688B198AA9A4B3F)
        targets[targets.size] = technical;
    }

    littlebirds = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");

    foreach(_id_2D5132FBC622EF42 in littlebirds) {
      if(_id_2D5132FBC622EF42.team != self.team || _id_E688B198AA9A4B3F)
        targets[targets.size] = _id_2D5132FBC622EF42;
    }

    tacrovers = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("tac_rover");

    foreach(_id_AF4E3D6D8C66FF39 in tacrovers) {
      if(_id_AF4E3D6D8C66FF39.team != self.team || _id_E688B198AA9A4B3F)
        targets[targets.size] = _id_AF4E3D6D8C66FF39;
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(ac130.team != self.team || _id_E688B198AA9A4B3F)
            targets[targets.size] = ac130;
        }
      }
    }
  } else {
    if(isDefined(_id_FE608D14719843BC) && _id_FE608D14719843BC == 1) {
      foreach(_id_B5517D24E9DC9A49 in level.characters) {
        if((!isDefined(_id_B5517D24E9DC9A49) || !isalive(_id_B5517D24E9DC9A49)) && !_id_E688B198AA9A4B3F) {
          continue;
        }
        targets[targets.size] = _id_B5517D24E9DC9A49;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(_id_153FDEE861E0F06F in level.activekillstreaks) {
        if(isDefined(_id_153FDEE861E0F06F.affectedbylockon) && (isDefined(_id_153FDEE861E0F06F.owner) && _id_153FDEE861E0F06F.owner != self || _id_E688B198AA9A4B3F))
          targets[targets.size] = _id_153FDEE861E0F06F;
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(_id_153FDEE861E0F06F in level.all_spawned_vehicles)
      targets[targets.size] = _id_153FDEE861E0F06F;
    }

    if(isDefined(level.remote_tanks)) {
      foreach(_id_153FDEE861E0F06F in level.remote_tanks)
      targets[targets.size] = _id_153FDEE861E0F06F;
    }

    if(isDefined(level.technicals)) {
      foreach(technical in level.technicals) {
        if(isDefined(technical.owner) && technical.owner != self || _id_E688B198AA9A4B3F)
          targets[targets.size] = technical;
      }
    }

    _id_DDDC24BA34981C53 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

    foreach(bradley in _id_DDDC24BA34981C53) {
      if(bradley.owner != self || _id_E688B198AA9A4B3F)
        targets[targets.size] = bradley;
    }

    technicals = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("technical");

    foreach(technical in technicals) {
      if(technical.owner != self || _id_E688B198AA9A4B3F)
        targets[targets.size] = technical;
    }

    littlebirds = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("little_bird");

    foreach(_id_2D5132FBC622EF42 in littlebirds) {
      if(_id_2D5132FBC622EF42.owner != self || _id_E688B198AA9A4B3F)
        targets[targets.size] = _id_2D5132FBC622EF42;
    }

    tacrovers = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("tac_rover");

    foreach(_id_AF4E3D6D8C66FF39 in tacrovers) {
      if(_id_AF4E3D6D8C66FF39.owner != self || _id_E688B198AA9A4B3F)
        targets[targets.size] = _id_AF4E3D6D8C66FF39;
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(ac130.owner != self || _id_E688B198AA9A4B3F)
            targets[targets.size] = ac130;
        }
      }
    }
  }

  _id_1F94AEFC3C500BF1 = [];

  foreach(guy in targets) {
    if(isDefined(guy))
      _id_1F94AEFC3C500BF1[_id_1F94AEFC3C500BF1.size] = guy;
  }

  targets = _id_1F94AEFC3C500BF1;
  return targets;
}

stingerusageloop() {
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

stinger_finalizelock(_id_1FE8EEB95943F79F) {
  offset = undefined;

  if(isDefined(_id_1FE8EEB95943F79F.inlosid)) {
    offset = _id_1FE8EEB95943F79F.offsets[_id_1FE8EEB95943F79F.inlosid];
    offset = (offset[1], -1 * offset[0], offset[2]);
  } else
    offset = (0, 0, 0);

  self weaponlockfinalize(self.stingertarget, offset);
}

addhudincoming_attacker(target) {
  if(!isDefined(target)) {
    return;
  }
  _id_5E48D2FE6F684A18 = target;

  if(isDefined(target.owner) && !isplayerkillstreak(target))
    _id_5E48D2FE6F684A18 = target.owner;

  if(!isDefined(_id_5E48D2FE6F684A18) || !isPlayer(_id_5E48D2FE6F684A18)) {
    return;
  }
  _id_5E48D2FE6F684A18 setclientomnvar("ui_killstreak_missile_warn", 1);
}

removehudincoming_attacker(target) {
  if(!isDefined(target)) {
    return;
  }
  _id_5E48D2FE6F684A18 = target;

  if(!isplayerkillstreak(target)) {
    if(!isDefined(target.owner)) {
      return;
    }
    _id_5E48D2FE6F684A18 = target.owner;
  }

  if(!isDefined(_id_5E48D2FE6F684A18) || !isPlayer(_id_5E48D2FE6F684A18)) {
    return;
  }
  _id_5E48D2FE6F684A18 setclientomnvar("ui_killstreak_missile_warn", 0);
}

isplayerkillstreak(ent) {
  if(!isDefined(ent.activeplayerstreak))
    return 0;

  switch (ent.activeplayerstreak) {
    default:
      return 0;
  }
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

  if(isapache(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
  } else if(isac130(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
  } else if(isclusterstrike(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 40);
    self.useoldlosverification = 0;
  } else if(isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else if(isradardrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
  } else if(isscramblerdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else if(isradarhelicopter(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -30);
    self.useoldlosverification = 0;
  } else if(isDefined(self.target.vehiclename) && self.target.vehiclename == "bradley") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
  } else
    self.offsets[self.offsets.size] = (0, 0, 0);
}

isapache(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  ischoppergunner = ent.streakinfo.streakname == "chopper_gunner";
  _id_15CD55A03B5C886B = ent.streakinfo.streakname == "jackal";
  return ischoppergunner || _id_15CD55A03B5C886B;
}

isclusterstrike(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_30C3CED8E8637755 = ent.streakinfo.streakname == "toma_strike";
  return _id_30C3CED8E8637755;
}

isuav(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  if(ent.streakinfo.streakname == "uav" || ent.streakinfo.streakname == "counter_uav" || ent.streakinfo.streakname == "directional_uav")
    return 1;

  return 0;
}

isac130(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_00AB8D41683A88CB = ent.streakinfo.streakname == "ac130";
  return _id_00AB8D41683A88CB;
}

isradardrone(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_15D89ECD7562A1E7 = ent.streakinfo.streakname == "radar_drone_escort" || ent.streakinfo.streakname == "radar_drone_recon";
  return _id_15D89ECD7562A1E7;
}

isscramblerdrone(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_152BE1BDA3C25940 = ent.streakinfo.streakname == "scrambler_drone_guard";
  return _id_152BE1BDA3C25940;
}

isradarhelicopter(ent) {
  if(!isDefined(ent.streakinfo))
    return 0;

  if(!isDefined(ent.streakinfo.streakname))
    return 0;

  _id_15D89ECD7562A1E7 = ent.streakinfo.streakname == "radar_drone_overwatch";
  return _id_15D89ECD7562A1E7;
}

isturret(ent) {
  return isDefined(ent.classname) && ent.classname == "misc_turret";
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
    trace = scripts\engine\trace::ray_trace(caststart, self.origins[0], _id_7C44F2C83CC7CF1E, contents, 0);

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