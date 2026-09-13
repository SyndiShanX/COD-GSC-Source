/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\javelin.gsc
***********************************************/

javelinusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  javelin_init();
  thread _id_2F8E1A565D6BF787();

  for(;;) {
    weapon = self getcurrentweapon();

    if(issubstr(weapon.basename, "la_juliet_mp") && javelin_shouldjavelinthink()) {
      self.javelin.stopthinking = 0;
      thread javelin_think();
    } else
      self.javelin.stopthinking = 1;

    self waittill("weapon_change");
  }
}

_id_2F8E1A565D6BF787() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self waittill("end_launcher");
  javelin_forceclear();
}

javelin_init() {
  self.javelin = spawnStruct();

  if(!isDefined(level.javelin)) {
    level.javelin = spawnStruct();
    level.javelin.states = [];
    level.javelin.states["off"] = [];
    level.javelin.states["off"]["enter"] = ::javelin_offstateenter;
    level.javelin.states["off"]["update"] = ::javelin_offstateupdate;
    level.javelin.states["off"]["exit"] = ::javelin_offstateexit;
    level.javelin.states["scanning"] = [];
    level.javelin.states["scanning"]["enter"] = ::javelin_scanningstateenter;
    level.javelin.states["scanning"]["update"] = ::javelin_scanningstateupdate;
    level.javelin.states["hold"] = [];
    level.javelin.states["hold"]["enter"] = ::javelin_holdstateenter;
    level.javelin.states["hold"]["update"] = ::javelin_holdstateupdate;
    level.javelin.states["hold"]["exit"] = ::javelin_holdstateexit;
    level.javelin.states["fire"] = [];
    level.javelin.states["fire"]["enter"] = ::javelin_firestateenter;
    level.javelin.states["fire"]["update"] = ::javelin_firestateupdate;
    level.javelin.states["fire"]["exit"] = ::javelin_firestateexit;
    level.javelin.states["too_close"] = [];
    level.javelin.states["too_close"]["enter"] = ::javelin_tooclosestateenter;
    level.javelin.states["too_close"]["update"] = ::javelin_tooclosestateupdate;
  }
}

javelin_reset() {
  if(!isDefined(self.javelin)) {
    return;
  }
  self.javelin.adsraisedelaytimer = undefined;
  self.javelin.target = undefined;
  self.javelin.lockstarttime = undefined;
  self.javelin.vehiclelostsightlinetime = undefined;
  self.javelin.groundlockmisses = 0;
  self.javelin.targetnormal = undefined;

  if(isDefined(self.javelin.groundlockonent)) {
    self.javelin.groundlockonent scripts\cp_mp\ent_manager::deregisterspawn();
    self.javelin.groundlockonent delete();
  }

  self.javelin.groundlockonent = undefined;
  self.javelin.groundpoints = undefined;
  self.javelin.state = undefined;
  self.javelin.queuedstate = undefined;
}

javelin_offstateenter(_id_8F4EF4FDB5E7800A) {
  if(isDefined(self.javelin.target)) {
    scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);
    self.javelin.target = undefined;
  }

  if(isDefined(self.javelin.groundlockonent)) {
    self.javelin.groundlockonent scripts\cp_mp\ent_manager::deregisterspawn();
    self.javelin.groundlockonent delete();
  }

  self.javelin.groundlockonent = undefined;
  javelin_hidenormalhud(0);
  javelin_setuistate(0);
}

javelin_offstateupdate() {
  if(self playerads() >= 0.9)
    javelin_queuestate("scanning");
}

javelin_offstateexit() {
  javelin_hidenormalhud(1);
}

_id_22C8F0D0E0492F51() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("death", "end_launcher", "faux_spawn");
  javelin_hidenormalhud(0);
  javelin_setuistate(0);
}

_id_F8DB769BE3A46D46() {
  self endon("weapon_change");
  self waittill("death_or_disconnect");

  if(isDefined(self.javelin)) {
    if(isDefined(self.javelin.target)) {
      scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);
      self weaponlockfree();
      self.javelin.target = undefined;
    }

    if(isDefined(self.javelin.groundlockonent)) {
      self.javelin.groundlockonent scripts\cp_mp\ent_manager::deregisterspawn();
      self.javelin.groundlockonent delete();
      self.javelin.groundlockonent = undefined;
    }
  }
}

javelin_scanningstateenter(_id_8F4EF4FDB5E7800A) {
  javelin_setuistate(1);
  self.javelin.adsraisedelaytimer = gettime() + 100;
}

javelin_scanningstateupdate() {
  if(gettime() < self.javelin.adsraisedelaytimer) {
    return;
  }
  _id_9CB7C709F17E1C56 = javelin_scanforvehicletarget();

  if(isDefined(_id_9CB7C709F17E1C56)) {
    if(javelin_targetpointtooclose(_id_9CB7C709F17E1C56.origin)) {
      javelin_queuestate("too_close");
      return;
    }

    if(isDefined(self.javelin.target) && self.javelin.target == _id_9CB7C709F17E1C56)
      _id_AC0E414AC96A6EE0 = 1;

    self.javelin.target = _id_9CB7C709F17E1C56;

    if(isDefined(self.javelin.target))
      scripts\cp_mp\utility\weapon_utility::addlockedon(self.javelin.target, self);

    if(!isDefined(self.javelinlocationtargeted))
      marklocation(self.javelin.target);

    javelin_queuestate("hold");
  } else if(self attackButtonPressed()) {
    if(self.javelin.groundlockmisses >= 1) {
      self.javelin.groundlockmisses = 0;
      self.javelin.groundpoints = undefined;
      return;
    }

    traceresults = javelin_eyetraceforward();

    if(!isDefined(traceresults)) {
      self.javelin.groundlockmisses++;
      return;
    }

    if(javelin_targetpointtooclose(traceresults[0])) {
      javelin_queuestate("too_close");
      return;
    }

    if(isDefined(self.javelin.groundpoints)) {
      _id_82D5206F31AAFAC2 = averagepoint(self.javelin.groundpoints);
      dist = distance(_id_82D5206F31AAFAC2, traceresults[0]);

      if(dist > 400) {
        self.javelin.groundlockmisses++;
        return;
      }
    } else {
      self.javelin.groundpoints = [];
      self.javelin.groundnormals = [];
    }

    self.javelin.groundpoints[self.javelin.groundpoints.size] = traceresults[0];
    self.javelin.groundnormals[self.javelin.groundnormals.size] = traceresults[1];
    self.javelin.groundlockmisses = 0;

    if(self.javelin.groundpoints.size < 2) {
      return;
    }
    _id_91BE2B7482F940BA = averagepoint(self.javelin.groundpoints);
    self.javelin.groundlockonent = scripts\engine\utility::spawn_tag_origin(_id_91BE2B7482F940BA);
    self.javelin.groundlockonent scripts\cp_mp\ent_manager::registerspawncount(1);
    self.javelin.target = self.javelin.groundlockonent;
    self.javelin.target._id_2059B69CE0EC9247 = scripts\engine\utility::spawn_tag_origin(traceresults[2]);
    self.javelin.target._id_2059B69CE0EC9247 scripts\cp_mp\ent_manager::registerspawncount(1);
    self.javelin.groundlockmisses = 0;
    self.javelin.groundpoints = undefined;
    self.javelin.groundnormals = undefined;

    if(!isDefined(self.javelinlocationtargeted))
      marklocation(self.javelin.target._id_2059B69CE0EC9247);

    javelin_queuestate("hold");
  }
}

javelin_holdstateenter(_id_8F4EF4FDB5E7800A) {
  if(!isDefined(self.javelin.target)) {
    return;
  }
  javelin_setuistate(2);
  self.javelin.lockstarttime = gettime();
  self.javelin.lostsightlinetime = 0;

  if(isent(self.javelin.target))
    self weaponlockstart(self.javelin.target);
  else
    self weaponlockstart(self.javelin.target.origin);

  thread javelin_looplocalseeksound("javelin_clu_acquiring_lock", 0.5);
}

javelin_holdstateupdate() {
  _id_E688B198AA9A4B3F = 0;

  if(!isDefined(self.javelin.target)) {
    javelin_queuestate("scanning");
    return;
  }

  _id_0AB121F888311D66 = 0;

  if(!_id_E688B198AA9A4B3F && (self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.javelin.target, self))) {
    if(!isDefined(self.javelin.target.sentientpool)) {
      javelin_queuestate("scanning");
      _id_0AB121F888311D66 = 1;
    }
  }

  if(!javelin_checktargetstillheld(self.javelin.target)) {
    javelin_queuestate("scanning");
    _id_0AB121F888311D66 = 1;
  }

  if(javelin_targetpointtooclose(self.javelin.target.origin)) {
    javelin_queuestate("too_close");
    _id_0AB121F888311D66 = 1;
  }

  if(_id_0AB121F888311D66) {
    if(isDefined(self.javelin.target))
      scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);

    self weaponlockfree();
    self.javelin.target = undefined;

    if(isDefined(self.javelin.groundlockonent))
      self.javelin.groundlockonent delete();
  }

  _id_3B5803E733581858 = gettime() - self.javelin.lockstarttime;

  if(_id_3B5803E733581858 < 1150) {
    return;
  }
  javelin_queuestate("fire");
}

javelin_holdstateexit() {
  self notify("stop_lockon_sound");
  self stoplocalsound("javelin_clu_acquiring_lock");
}

javelin_firestateenter(_id_8F4EF4FDB5E7800A) {
  javelin_setuistate(3);

  if(!isDefined(self.javelin.target)) {
    return;
  }
  _id_98D6306F2F5F9E66 = isent(self.javelin.target);

  if(_id_98D6306F2F5F9E66 && isPlayer(self.javelin.target))
    self weaponlockfinalize(self.javelin.target, (0, 0, 64), 0);
  else if(isDefined(self.javelin.groundlockonent))
    self weaponlockfinalize(self.javelin.target, (0, 0, 0), 1);
  else if(!_id_98D6306F2F5F9E66)
    self weaponlockfinalize(self.javelin.target.origin, (0, 0, 0), 1);
  else {
    _id_F4C1BA742ECDDFC0 = javelin_getvehicleoffset(self.javelin.target);
    self weaponlockfinalize(self.javelin.target, _id_F4C1BA742ECDDFC0, 0);
  }

  thread javelin_looplocalseeksound("javelin_clu_lock", 1.6);
}

javelin_firestateupdate() {
  _id_E688B198AA9A4B3F = 0;

  if(!isDefined(self.javelin.target)) {
    javelin_queuestate("scanning");
    return;
  }

  if(!_id_E688B198AA9A4B3F && (self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.javelin.target, self))) {
    if(!isDefined(self.javelin.target.sentientpool))
      javelin_queuestate("scanning");
  }

  if(!javelin_checktargetstillheld(self.javelin.target))
    javelin_queuestate("scanning");

  if(javelin_targetpointtooclose(self.javelin.target.origin))
    javelin_queuestate("too_close");
}

javelin_firestateexit() {
  if(isDefined(self.javelin.target))
    scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);

  self weaponlockfree();
  self.javelin.target = undefined;

  if(isDefined(self.javelin.groundlockonent))
    self.javelin.groundlockonent delete();

  self notify("stop_lockon_sound");
  self stoplocalsound("javelin_clu_lock");
}

javelin_tooclosestateenter(_id_8F4EF4FDB5E7800A) {
  javelin_setuistate(4);
}

javelin_tooclosestateupdate() {
  _id_9CB7C709F17E1C56 = javelin_scanforvehicletarget();

  if(isDefined(_id_9CB7C709F17E1C56)) {
    if(!javelin_targetpointtooclose(_id_9CB7C709F17E1C56.origin)) {
      javelin_queuestate("scanning");
      return;
    }
  } else {
    traceresults = javelin_eyetraceforward();

    if(!isDefined(traceresults) || isDefined(traceresults) && javelin_targetpointtooclose(traceresults[0]) == 0) {
      javelin_queuestate("scanning");
      return;
    }
  }
}

javelin_preupdate() {
  if(isDefined(self.javelin.state) && self.javelin.state != "off") {
    if(self playerads() < 0.9)
      javelin_queuestate("off");
  }
}

javelin_checktargetstillheld(targetent) {
  if(!isDefined(targetent))
    return 0;

  _id_A9FC24033722AA10 = targetent;

  if(isDefined(targetent._id_2059B69CE0EC9247))
    _id_A9FC24033722AA10 = targetent._id_2059B69CE0EC9247;

  _id_A298EF0BBEFC9AAB = self worldpointinreticle_rect(_id_A9FC24033722AA10.origin, 35, 120, 80);

  if(!_id_A298EF0BBEFC9AAB)
    return 0;

  if(!isDefined(self.javelin.groundlockonent) && !javelin_softsighttest(targetent))
    return 0;

  if(isDefined(self.javelin.groundlockonent)) {
    if(!self attackButtonPressed())
      return 0;
  }

  return 1;
}

javelin_eyetraceforward() {
  origin = self getEye();
  _id_F432E8F2C3B65BAD = self getgunangles();
  _id_33B453837F886DAE = anglesToForward(_id_F432E8F2C3B65BAD);
  endpoint = origin + _id_33B453837F886DAE * 15000;
  _id_D2B09A5F70A0530A = scripts\engine\trace::ray_trace(origin, endpoint, undefined, undefined, 1);

  if(!isDefined(_id_D2B09A5F70A0530A) || _id_D2B09A5F70A0530A["surfacetype"] == "surftype_none" && _id_D2B09A5F70A0530A["hittype"] == "hittype_none" || _id_D2B09A5F70A0530A["surfacetype"] == "default")
    return undefined;

  _id_7F74BE76BA001A7A = _id_D2B09A5F70A0530A;
  _id_6B27AB83A5049B73 = _id_CEEB605CF6974148(_id_D2B09A5F70A0530A, _id_33B453837F886DAE);

  if(isDefined(_id_6B27AB83A5049B73))
    _id_7F74BE76BA001A7A = _id_6B27AB83A5049B73;

  results = [];
  results[0] = _id_7F74BE76BA001A7A["position"];
  results[1] = _id_7F74BE76BA001A7A["normal"];
  results[2] = _id_D2B09A5F70A0530A["position"];
  return results;
}

_id_CEEB605CF6974148(_id_D2B09A5F70A0530A, _id_33B453837F886DAE) {
  _id_94168349C721C815 = 5000;
  _id_031AE59F63933229 = getdvarint("dvar_0A0CF49119410B52", 100);
  _id_10C80CB240F98C74 = getdvarint("dvar_F14ADD14FF4C308B", 100);

  if(abs(_id_D2B09A5F70A0530A["normal"][2]) > 0.1)
    return undefined;

  _id_BDB5669D537521A0 = _id_D2B09A5F70A0530A["position"];
  _id_208B20B100E6C745 = _id_BDB5669D537521A0 + _id_33B453837F886DAE * _id_10C80CB240F98C74;
  _id_A09791F8B1DAFD16 = scripts\engine\trace::ray_trace_get_all_results(_id_208B20B100E6C745 + (0, 0, 100000), _id_208B20B100E6C745 - (0, 0, _id_94168349C721C815), undefined, undefined, 1);
  _id_C8BF52A3FD4AEC68 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A09791F8B1DAFD16.size - 1; _id_AC0E594AC96AA3A8++) {
    hit = _id_A09791F8B1DAFD16[_id_AC0E594AC96AA3A8];

    if(hit["surfacetype"] == "surftype_none")
      continue;
    else {
      _id_C8BF52A3FD4AEC68 = hit;
      break;
    }
  }

  if(!isDefined(_id_C8BF52A3FD4AEC68))
    return undefined;

  _id_F435D883A28D8BC2 = _id_C8BF52A3FD4AEC68["position"];
  _id_8242D42FA4C4D38E = _id_F435D883A28D8BC2[2] - _id_BDB5669D537521A0[2];

  if(isDefined(_id_C8BF52A3FD4AEC68) && _id_8242D42FA4C4D38E < _id_031AE59F63933229 && _id_C6B77E459CBD9727(_id_C8BF52A3FD4AEC68["position"]))
    return _id_C8BF52A3FD4AEC68;
}

_id_C6B77E459CBD9727(point) {
  if(!isDefined(level.outofboundstriggers))
    return 1;

  foreach(trigger in level.outofboundstriggers) {
    if(ispointinvolume(point + (0, 0, 20), trigger))
      return 0;
  }

  return 1;
}

javelin_targetpointtooclose(_id_91BE2B7482F940BA) {
  dist = distance(self.origin, _id_91BE2B7482F940BA);

  if(dist < 850)
    return 1;

  return 0;
}

javelin_looplocalseeksound(alias, interval) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(alias);
    wait(interval);
  }
}

javelin_queuestate(statename) {
  self.javelin.queuedstate = statename;
}

javelin_getqueuedstate() {
  return self.javelin.queuedstate;
}

javelin_enterstate(statename) {
  _id_8F4EF4FDB5E7800A = self.javelin.state;

  if(isDefined(_id_8F4EF4FDB5E7800A) && isDefined(level.javelin.states[_id_8F4EF4FDB5E7800A]["exit"]))
    self[[level.javelin.states[_id_8F4EF4FDB5E7800A]["exit"]]]();

  self.javelin.state = statename;

  if(isDefined(level.javelin.states[statename]["enter"]))
    self[[level.javelin.states[statename]["enter"]]](_id_8F4EF4FDB5E7800A);

  self.javelin.queuedstate = undefined;
}

javelin_shouldjavelinthink() {
  return !scripts\cp_mp\emp_debuff::is_empd();
}

javelin_think() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("weapon_change");
  self notify("javelin_think");
  self endon("javelin_think");
  javelin_reset();
  javelin_enterstate("off");
  thread _id_22C8F0D0E0492F51();
  thread _id_F8DB769BE3A46D46();
  _id_263BBA08EB70BE2D = 0;

  for(;;) {
    if(isDefined(self.javelin.stopthinking) && self.javelin.stopthinking) {
      javelin_enterstate("off");
      return;
    }

    _id_1EAEB562566A61AA = !javelin_shouldjavelinthink();

    if(_id_1EAEB562566A61AA) {
      if(!_id_263BBA08EB70BE2D) {
        _id_263BBA08EB70BE2D = 1;
        javelin_enterstate("off");
      }
    } else {
      _id_263BBA08EB70BE2D = 0;
      javelin_preupdate();
      queuedstate = javelin_getqueuedstate();

      if(isDefined(queuedstate))
        javelin_enterstate(queuedstate);

      self[[level.javelin.states[self.javelin.state]["update"]]]();
    }

    wait 0.05;
  }
}

javelin_scanforvehicletarget() {
  targets = scripts\mp\weapons::lockonlaunchers_gettargetarray();
  _id_DB87E220986304F4 = getdvarint("dvar_EB7D16D9FA10A208", 625000000);

  if(targets.size != 0) {
    _id_8110370EDB23215A = [];

    foreach(target in targets) {
      if(!isDefined(target)) {
        continue;
      }
      _id_A298EF0BBEFC9AAB = self worldpointinreticle_rect(target.origin, 35, 120, 80);

      if(_id_A298EF0BBEFC9AAB && distancesquared(target.origin, self.origin) <= _id_DB87E220986304F4)
        _id_8110370EDB23215A[_id_8110370EDB23215A.size] = target;
    }

    if(_id_8110370EDB23215A.size != 0) {
      _id_6F500807B0D7B1DA = sortbydistance(_id_8110370EDB23215A, self.origin);

      foreach(target in _id_6F500807B0D7B1DA) {
        if(javelin_vehiclelocksighttest(target))
          return target;
      }
    }
  }

  return undefined;
}

javelin_vehiclelocksighttest(target) {
  _id_52241BCC3A205EF4 = self getEye();

  if(!isent(target)) {
    contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_playernosight"]);
    _id_7C44F2C83CC7CF1E = [self];
    _id_E021C2744CC7ED68 = physics_raycast(_id_52241BCC3A205EF4, target.origin, contents, _id_7C44F2C83CC7CF1E, 0, "physicsquery_closest", 1);

    if(!isDefined(_id_E021C2744CC7ED68) || _id_E021C2744CC7ED68.size == 0)
      return 1;

    return 0;
  }

  center = target getpointinbounds(0, 0, 1);
  passed = sighttracepassed(_id_52241BCC3A205EF4, center, 0, target);

  if(passed)
    return 1;

  _id_CFF021654A47B60C = target getpointinbounds(1, 0, 0);
  passed = sighttracepassed(_id_52241BCC3A205EF4, _id_CFF021654A47B60C, 0, target);

  if(passed)
    return 1;

  back = target getpointinbounds(-1, 0, 0);
  passed = sighttracepassed(_id_52241BCC3A205EF4, back, 0, target);

  if(passed)
    return 1;

  return 0;
}

javelin_getvehicleoffset(_id_9CB7C709F17E1C56) {
  offset = (0, 0, 0);

  if(!isDefined(_id_9CB7C709F17E1C56))
    return offset;

  if(scripts\mp\utility\entity::ischoppergunner(_id_9CB7C709F17E1C56))
    offset = (0, 0, -50);
  else if(scripts\mp\utility\entity::issupporthelo(_id_9CB7C709F17E1C56))
    offset = (0, 0, -100);
  else if(scripts\mp\utility\entity::isgunship(_id_9CB7C709F17E1C56))
    offset = (0, 0, 50);
  else if(scripts\mp\utility\entity::isclusterstrike(_id_9CB7C709F17E1C56))
    offset = (0, 0, 40);
  else if(scripts\mp\utility\entity::isradardrone(_id_9CB7C709F17E1C56))
    offset = (0, 0, 10);
  else if(scripts\mp\utility\entity::isassaultdrone(_id_9CB7C709F17E1C56))
    offset = (0, 0, 10);
  else if(scripts\mp\utility\entity::isscramblerdrone(_id_9CB7C709F17E1C56))
    offset = (0, 0, 10);
  else if(scripts\mp\utility\entity::isradarhelicopter(_id_9CB7C709F17E1C56))
    offset = (0, 0, -30);
  else if(isDefined(_id_9CB7C709F17E1C56.vehiclename) && _id_9CB7C709F17E1C56.vehiclename == "loot_chopper")
    offset = (0, 0, -100);

  return offset;
}

javelin_softsighttest(targetent) {
  if(javelin_vehiclelocksighttest(targetent)) {
    self.javelin.lostsightlinetime = 0;
    return 1;
  }

  if(self.javelin.lostsightlinetime == 0)
    self.javelin.lostsightlinetime = gettime();

  _id_3B5803E733581858 = gettime() - self.javelin.lostsightlinetime;

  if(_id_3B5803E733581858 >= 500)
    return 0;

  return 1;
}

javelin_hidenormalhud(enable) {
  if(!isDefined(self)) {
    return;
  }
  if(enable)
    self setclientomnvar("ui_javelin_view", 1);
  else
    self setclientomnvar("ui_javelin_view", 0);
}

javelin_setuistate(state) {
  self setclientomnvar("ui_javelin_state", state);
}

marklocation(_id_9E3A8D7DC51A2CAE) {
  if(!isDefined(_id_9E3A8D7DC51A2CAE.owner))
    _id_9E3A8D7DC51A2CAE.owner = self;

  if(_id_9E3A8D7DC51A2CAE.model == "tag_origin")
    _id_9E3A8D7DC51A2CAE show();

  _id_F27C7690B259EC3A = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("javelincrosshair", self, _id_9E3A8D7DC51A2CAE, self);
  self.javelinlocationtargeted = 1;
  thread watchtargetmarkerentstatus(_id_9E3A8D7DC51A2CAE, _id_F27C7690B259EC3A, 1);
}

watchtargetmarkerentstatus(_id_D99ED5531D1FDC1F, targetmarkergroup, _id_2045169349EF8877) {
  level endon("game_ended");

  while(isDefined(self.javelin.target) && self.javelin.state != "off")
    waitframe();

  if(isDefined(targetmarkergroup))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(targetmarkergroup);

  self.javelinlocationtargeted = undefined;
}

javelin_forceclear() {
  javelin_hidenormalhud(0);
  javelin_setuistate(0);

  if(isDefined(self.javelin)) {
    if(isDefined(self.javelin.target)) {
      scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);
      self weaponlockfree();
      self.javelin.target = undefined;
    }

    if(isDefined(self.javelin.groundlockonent)) {
      self.javelin.groundlockonent scripts\cp_mp\ent_manager::deregisterspawn();
      self.javelin.groundlockonent delete();
    }
  }

  self notify("stop_lockon_sound");
  self stoplocalsound("javelin_clu_lock");
}