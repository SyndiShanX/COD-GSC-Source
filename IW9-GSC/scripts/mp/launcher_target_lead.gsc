/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\launcher_target_lead.gsc
***********************************************/

targetleadusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  targetlead_init();

  for(;;) {
    weapon = self getcurrentweapon();

    if(weapon.basename == "iw8_la_kgolf_mp" && targetlead_shouldtargetleadthink()) {
      self.targetlead.stopthinking = 0;
      thread targetlead_think();
    } else
      self.targetlead.stopthinking = 1;

    self waittill("weapon_change");
  }
}

targetlead_init() {
  self.targetlead = spawnStruct();
  self.targetlead.states = [];
  self.targetlead.states["off"] = [];
  self.targetlead.states["off"]["enter"] = ::targetlead_offstateenter;
  self.targetlead.states["off"]["update"] = ::targetlead_offstateupdate;
  self.targetlead.states["off"]["exit"] = ::targetlead_offstateexit;
  self.targetlead.states["scanning"] = [];
  self.targetlead.states["scanning"]["enter"] = ::targetlead_scanningstateenter;
  self.targetlead.states["scanning"]["update"] = ::targetlead_scanningstateupdate;
  self.targetlead.states["hold"] = [];
  self.targetlead.states["hold"]["enter"] = ::targetlead_holdstateenter;
  self.targetlead.states["hold"]["update"] = ::targetlead_holdstateupdate;
  self.targetlead.states["hold"]["exit"] = ::targetlead_holdstateexit;
}

targetlead_reset() {
  self.targetlead.adsraisedelaytimer = undefined;
  self.targetlead.target = undefined;
  self.targetlead.lockstarttime = undefined;
  self.targetlead.vehiclelostsightlinetime = undefined;
  self.targetlead.isaimingatreticle = 0;

  if(isDefined(self.targetlead.leadpositionent)) {
    self.targetlead.leadpositionent scripts\cp_mp\ent_manager::deregisterspawn();
    self.targetlead.leadpositionent delete();
  }

  self.targetlead.leadpositionent = undefined;
  self.targetlead.state = undefined;
  self.targetlead.queuedstate = undefined;
}

targetlead_offstateenter(_id_8F4EF4FDB5E7800A) {
  if(isDefined(_id_8F4EF4FDB5E7800A)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetlead.targetmarkergroup);
    self.targetlead.targetmarkergroup = undefined;
  }
}

targetlead_offstateupdate() {
  if(self playerads() >= 0.6)
    targetlead_queuestate("scanning");
}

targetlead_offstateexit() {}

targetlead_scanningstateenter(_id_8F4EF4FDB5E7800A) {
  self.targetlead.adsraisedelaytimer = gettime() + 100;

  if(isDefined(_id_8F4EF4FDB5E7800A) && _id_8F4EF4FDB5E7800A == "off")
    self.targetlead.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("kgolftarget", self, undefined, self);
}

targetlead_scanningstateupdate() {
  if(gettime() < self.targetlead.adsraisedelaytimer) {
    return;
  }
  _id_9CB7C709F17E1C56 = targetlead_scanforvehicletarget();

  if(isDefined(_id_9CB7C709F17E1C56)) {
    self.targetlead.target = _id_9CB7C709F17E1C56;
    targetlead_queuestate("hold");
  }
}

targetlead_holdstateenter(_id_8F4EF4FDB5E7800A) {
  self.targetlead.lockstarttime = gettime();
  self.targetlead.lostsightlinetime = 0;
  self.targetlead.leadpositionent = scripts\engine\utility::spawn_tag_origin();
  self.targetlead.leadpositionent scripts\cp_mp\ent_manager::registerspawncount(1);
  self.targetlead.leadpositionent show();
  targetlead_uimarkentities();
}

targetlead_holdstateupdate() {
  if(!targetlead_checktargetstillheld(self.targetlead.target)) {
    targetlead_queuestate("scanning");
    return;
  } else {
    _id_762114A68005AF12 = targetlead_getleadposition(self.targetlead.target);

    if(isDefined(_id_762114A68005AF12))
      self.targetlead.leadpositionent moveTo(_id_762114A68005AF12, 0.05);
  }

  _id_A298EF0BBEFC9AAB = self worldpointinreticle_circle(self.targetlead.leadpositionent.origin, 55, 40);

  if(_id_A298EF0BBEFC9AAB && !self.targetlead.isaimingatreticle) {
    self.targetlead.isaimingatreticle = 1;
    thread targetlead_airburstholdthink();
  } else if(!_id_A298EF0BBEFC9AAB && self.targetlead.isaimingatreticle) {
    self.targetlead.isaimingatreticle = 0;
    self notify("stop_airburst_think");
  }
}

targetlead_holdstateexit() {
  targetlead_uiunmarkentities();

  if(isDefined(self.targetlead.leadpositionent)) {
    self.targetlead.leadpositionent scripts\cp_mp\ent_manager::deregisterspawn();
    self.targetlead.leadpositionent delete();
  }

  self.targetlead.leadpositionent = undefined;
  self.targetlead.isaimingatreticle = 0;
  self notify("stop_airburst_think");
}

targetlead_preupdate() {
  if(self.targetlead.state != "off") {
    if(self playerads() < 0.6)
      targetlead_queuestate("off");
  }
}

targetlead_onstartthink() {}

targetlead_onstopthink() {
  if(isDefined(self.targetlead.state) && self.targetlead.state != "off")
    targetlead_enterstate("off");
}

targetlead_getleadposition(_id_0E252E6FDBDF18FE) {
  _id_69E287A8208138F5 = (0, 0, 0);

  if(_id_0E252E6FDBDF18FE.classname == "script_vehicle")
    _id_69E287A8208138F5 = _id_0E252E6FDBDF18FE vehicle_getvelocity();
  else if(scripts\mp\utility\entity::isgunship(_id_0E252E6FDBDF18FE) || scripts\mp\utility\entity::isuav(_id_0E252E6FDBDF18FE))
    _id_69E287A8208138F5 = _id_0E252E6FDBDF18FE.velocity;

  _id_4A210EEDC2B480D1 = _id_0E252E6FDBDF18FE.origin + targetlead_getvehicleoffset(_id_0E252E6FDBDF18FE);
  _id_920886B23146CDBF = self getEye();
  _id_BA1ADD3AFE35926A = 4000;
  _id_4BFFFE4F58A90EF1 = projectileintercept(_id_920886B23146CDBF, (0, 0, 0), _id_BA1ADD3AFE35926A, _id_4A210EEDC2B480D1, _id_69E287A8208138F5);

  if(isDefined(_id_4BFFFE4F58A90EF1))
    return _id_4BFFFE4F58A90EF1;

  return undefined;
}

targetlead_getvehicleoffset(_id_9CB7C709F17E1C56) {
  offset = (0, 0, 0);

  if(scripts\mp\utility\entity::ischoppergunner(_id_9CB7C709F17E1C56))
    offset = (0, 0, -50);
  else if(scripts\mp\utility\entity::issupporthelo(_id_9CB7C709F17E1C56))
    offset = (0, 0, -100);
  else if(scripts\mp\utility\entity::isgunship(_id_9CB7C709F17E1C56))
    offset = (0, 0, 40);
  else if(scripts\mp\utility\entity::isclusterstrike(_id_9CB7C709F17E1C56))
    offset = (0, 0, 40);
  else if(scripts\mp\utility\entity::isradardrone(_id_9CB7C709F17E1C56))
    offset = (0, 0, 10);
  else if(scripts\mp\utility\entity::isassaultdrone(_id_9CB7C709F17E1C56))
    offset = (0, 0, 10);
  else if(scripts\mp\utility\entity::isscramblerdrone(_id_9CB7C709F17E1C56))
    offset = (0, 0, 10);
  else if(scripts\mp\utility\entity::isradarhelicopter(_id_9CB7C709F17E1C56))
    offset = (0, 0, 30);

  return offset;
}

targetlead_checktargetstillheld(targetent) {
  if(!isDefined(targetent))
    return 0;

  _id_A298EF0BBEFC9AAB = self worldpointinreticle_circle(targetent.origin, 55, 240);

  if(!_id_A298EF0BBEFC9AAB)
    return 0;

  if(!targetlead_softsighttest(targetent))
    return 0;

  return 1;
}

targetlead_looplocalseeksound(alias, interval) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(alias);
    wait(interval);
  }
}

targetlead_queuestate(statename) {
  self.targetlead.queuedstate = statename;
}

targetlead_getqueuedstate() {
  return self.targetlead.queuedstate;
}

targetlead_enterstate(statename) {
  if(isDefined(self.targetlead.state)) {}

  _id_8F4EF4FDB5E7800A = self.targetlead.state;

  if(isDefined(_id_8F4EF4FDB5E7800A) && isDefined(self.targetlead.states[_id_8F4EF4FDB5E7800A]["exit"]))
    self[[self.targetlead.states[_id_8F4EF4FDB5E7800A]["exit"]]]();

  self.targetlead.state = statename;

  if(isDefined(self.targetlead.states[statename]["enter"]))
    self[[self.targetlead.states[statename]["enter"]]](_id_8F4EF4FDB5E7800A);

  self.targetlead.queuedstate = undefined;
}

targetlead_shouldtargetleadthink() {
  return !scripts\cp_mp\emp_debuff::is_empd();
}

targetlead_think() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self notify("targetLead_think");
  self endon("targetLead_think");
  targetlead_reset();
  targetlead_enterstate("off");
  targetlead_onstartthink();
  thread targetlead_earlyoutthink();

  for(;;) {
    if(isDefined(self.targetlead.stopthinking) && self.targetlead.stopthinking || !targetlead_shouldtargetleadthink()) {
      self notify("targetLead_stop");
      targetlead_onstopthink();
      return;
    }

    targetlead_preupdate();
    queuedstate = targetlead_getqueuedstate();

    if(isDefined(queuedstate))
      targetlead_enterstate(queuedstate);

    self[[self.targetlead.states[self.targetlead.state]["update"]]]();
    wait 0.05;
  }
}

targetlead_earlyoutthink() {
  self endon("targetLead_stop");
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "faux_spawn");
  targetlead_onstopthink();
}

targetlead_scanforvehicletarget() {
  targets = scripts\mp\weapons::lockonlaunchers_gettargetarray();

  if(targets.size != 0) {
    _id_8110370EDB23215A = [];

    foreach(target in targets) {
      _id_A298EF0BBEFC9AAB = self worldpointinreticle_circle(target.origin, 55, 240);

      if(_id_A298EF0BBEFC9AAB)
        _id_8110370EDB23215A[_id_8110370EDB23215A.size] = target;
    }

    if(_id_8110370EDB23215A.size != 0) {
      _id_6F500807B0D7B1DA = sortbydistance(_id_8110370EDB23215A, self.origin);

      if(targetlead_vehiclelocksighttest(_id_6F500807B0D7B1DA[0]))
        return _id_6F500807B0D7B1DA[0];
    }
  }

  return undefined;
}

targetlead_vehiclelocksighttest(target) {
  _id_52241BCC3A205EF4 = self getEye();
  center = target getpointinbounds(0, 0, 0);
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

targetlead_softsighttest(targetent) {
  if(targetlead_vehiclelocksighttest(targetent)) {
    self.targetlead.lostsightlinetime = 0;
    return 1;
  }

  if(self.targetlead.lostsightlinetime == 0)
    self.targetlead.lostsightlinetime = gettime();

  _id_3B5803E733581858 = gettime() - self.targetlead.lostsightlinetime;

  if(_id_3B5803E733581858 >= 500)
    return 0;

  return 1;
}

targetlead_airburstholdthink() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("stop_airburst_think");
  self waittill("missile_fire", projectile);

  if(isDefined(self.targetlead.target))
    projectile thread targetlead_airburstmissilethink(self.targetlead.target, self);
}

targetlead_airburstmissilethink(targetent, _id_4084C95C19C7937A) {
  self endon("death");

  for(;;) {
    if(!isDefined(targetent)) {
      iprintlnbold("targetEnt undefined");
      return;
    }

    _id_1AC96A06E64C75CD = distance(_id_4084C95C19C7937A.origin, targetent.origin);
    _id_9D67E835F1049FFC = distance(_id_4084C95C19C7937A.origin, self.origin);

    if(_id_9D67E835F1049FFC > _id_1AC96A06E64C75CD) {
      self detonate();
      iprintlnbold("explode");
    }

    wait 0.05;
  }
}

targetlead_uimarkentities() {
  targetmarkergroupaddentity(self.targetlead.targetmarkergroup, self.targetlead.target);
  targetmarkergroupsetentitystate(self.targetlead.targetmarkergroup, self.targetlead.target, 1);
  targetmarkergroupaddentity(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent);
  targetmarkergroupsetentitystate(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent, 0);
}

targetlead_uiunmarkentities() {
  targetmarkergroupremoveentity(self.targetlead.targetmarkergroup, self.targetlead.target);
  targetmarkergroupremoveentity(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent);
}