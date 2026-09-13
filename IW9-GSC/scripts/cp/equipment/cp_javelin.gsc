/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_javelin.gsc
***********************************************/

javelinusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  javelin_init();

  for(;;) {
    weapon = self getcurrentweapon();

    if(weapon.basename == "iw9_la_juliet_mp" && javelin_shouldjavelinthink()) {
      self.javelin.stopthinking = 0;
      thread javelin_think();
    } else
      self.javelin.stopthinking = 1;

    self waittill("weapon_change");
  }
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

javelin_deathwatcher() {
  self endon("weapon_change");
  self waittill("death");
  javelin_hidenormalhud(0);
  javelin_setuistate(0);
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
    self.javelin.groundlockmisses = 0;
    self.javelin.groundpoints = undefined;
    self.javelin.groundnormals = undefined;

    if(!isDefined(self.javelinlocationtargeted))
      marklocation(self.javelin.target);

    javelin_queuestate("hold");
  }
}

javelin_holdstateenter(_id_8F4EF4FDB5E7800A) {
  javelin_setuistate(2);
  self.javelin.lockstarttime = gettime();
  self.javelin.lostsightlinetime = 0;
  self weaponlockstart(self.javelin.target);
  thread javelin_looplocalseeksound("javelin_clu_acquiring_lock", 0.5);
}

javelin_holdstateupdate() {
  _id_E688B198AA9A4B3F = 0;
  _id_0AB121F888311D66 = 0;

  if(!_id_E688B198AA9A4B3F && (self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.javelin.target, self))) {
    javelin_queuestate("scanning");
    _id_0AB121F888311D66 = 1;
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
  if(isPlayer(self.javelin.target))
    self weaponlockfinalize(self.javelin.target, (0, 0, 64), 0);
  else if(isDefined(self.javelin.groundlockonent))
    self weaponlockfinalize(self.javelin.target, (0, 0, 0), 1);
  else {
    _id_F4C1BA742ECDDFC0 = javelin_getvehicleoffset(self.javelin.target);
    self weaponlockfinalize(self.javelin.target, _id_F4C1BA742ECDDFC0, 0);
  }

  thread javelin_looplocalseeksound("javelin_clu_lock", 1.6);
}

javelin_firestateupdate() {
  _id_E688B198AA9A4B3F = 0;

  if(!_id_E688B198AA9A4B3F && (self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.javelin.target, self)))
    javelin_queuestate("scanning");

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

  _id_A298EF0BBEFC9AAB = self worldpointinreticle_rect(targetent.origin, 35, 120, 80);

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
  angles = self getplayerangles();
  forward = anglesToForward(angles);
  endpoint = origin + forward * 15000;
  _id_CBA415031462E005 = scripts\engine\trace::_bullet_trace(origin, endpoint, 0, undefined);

  if(_id_CBA415031462E005["surfacetype"] == "surftype_none" && _id_CBA415031462E005["hittype"] == "hittype_none")
    return undefined;

  if(_id_CBA415031462E005["surfacetype"] == "default")
    return undefined;

  ent = _id_CBA415031462E005["entity"];
  results = [];
  results[0] = _id_CBA415031462E005["position"];
  results[1] = _id_CBA415031462E005["normal"];
  return results;
}

javelin_targetpointtooclose(_id_91BE2B7482F940BA) {
  _id_71E6D19172E88145 = 1100;

  if(!isDefined(_id_91BE2B7482F940BA))
    return 0;

  dist = distance(self.origin, _id_91BE2B7482F940BA);

  if(dist < _id_71E6D19172E88145)
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
  thread javelin_deathwatcher();

  for(;;) {
    if(isDefined(self.javelin.stopthinking) && self.javelin.stopthinking) {
      javelin_enterstate("off");
      return;
    }

    if(!javelin_shouldjavelinthink()) {
      javelin_enterstate("off");
      return;
    }

    javelin_preupdate();
    queuedstate = javelin_getqueuedstate();

    if(isDefined(queuedstate))
      javelin_enterstate(queuedstate);

    self[[level.javelin.states[self.javelin.state]["update"]]]();
    wait 0.05;
  }
}

javelin_scanforvehicletarget() {
  targets = _id_74502A9E0EF1F19C::lockonlaunchers_gettargetarray();

  foreach(target in targets) {
    if(!isent(target))
      targets = scripts\engine\utility::array_remove(targets, target);
  }

  if(targets.size != 0) {
    _id_8110370EDB23215A = [];

    foreach(target in targets) {
      _id_A298EF0BBEFC9AAB = self worldpointinreticle_rect(target.origin, 35, 120, 80);

      if(_id_A298EF0BBEFC9AAB)
        _id_8110370EDB23215A[_id_8110370EDB23215A.size] = target;
    }

    if(_id_8110370EDB23215A.size != 0) {
      _id_6F500807B0D7B1DA = sortbydistance(_id_8110370EDB23215A, self.origin);

      if(javelin_vehiclelocksighttest(_id_6F500807B0D7B1DA[0]))
        return _id_6F500807B0D7B1DA[0];
    }
  }

  return undefined;
}

javelin_vehiclelocksighttest(target) {
  _id_52241BCC3A205EF4 = self getEye();
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

  if(scripts\cp\utility\entity::ischoppergunner(_id_9CB7C709F17E1C56))
    offset = (0, 0, -50);
  else if(scripts\cp\utility\entity::issupporthelo(_id_9CB7C709F17E1C56))
    offset = (0, 0, -100);
  else if(scripts\cp\utility\entity::isgunship(_id_9CB7C709F17E1C56))
    offset = (0, 0, 50);
  else if(scripts\cp\utility\entity::isclusterstrike(_id_9CB7C709F17E1C56))
    offset = (0, 0, 40);
  else if(scripts\cp\utility\entity::isradardrone(_id_9CB7C709F17E1C56))
    offset = (0, 0, 10);
  else if(scripts\cp\utility\entity::isscramblerdrone(_id_9CB7C709F17E1C56))
    offset = (0, 0, 10);
  else if(scripts\cp\utility\entity::isradarhelicopter(_id_9CB7C709F17E1C56))
    offset = (0, 0, -30);

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
  if(enable)
    self setclientomnvar("ui_javelin_view", 1);
  else
    self setclientomnvar("ui_javelin_view", 0);
}

javelin_setuistate(state) {
  self setclientomnvar("ui_javelin_state", state);
}

marklocation(_id_9E3A8D7DC51A2CAE) {
  _id_F27C7690B259EC3A = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("javelincrosshair", self, _id_9E3A8D7DC51A2CAE, self);

  if(_id_9E3A8D7DC51A2CAE.model == "tag_origin")
    _id_9E3A8D7DC51A2CAE show();

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