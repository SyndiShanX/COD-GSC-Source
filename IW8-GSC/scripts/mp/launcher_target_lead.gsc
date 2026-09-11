/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\launcher_target_lead.gsc
***********************************************/

function targetleadusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  targetlead_init();

  for(;;) {
    var0 = self getcurrentweapon();

    if(var0.basename == "iw8_la_kgolf_mp" && targetlead_shouldtargetleadthink()) {
      self.targetlead.stopthinking = 0;
      thread targetlead_think();
    } else {
      self.targetlead.stopthinking = 1;
    }

    self waittill("weapon_change");
  }
}

function targetlead_init() {
  self.targetlead = spawnStruct();
  self.targetlead.states = [];
  self.targetlead.states["off"] = [];
  self.targetlead.states["off"]["enter"] = &targetlead_offstateenter;
  self.targetlead.states["off"]["update"] = &targetlead_offstateupdate;
  self.targetlead.states["off"]["exit"] = &targetlead_offstateexit;
  self.targetlead.states["scanning"] = [];
  self.targetlead.states["scanning"]["enter"] = &targetlead_scanningstateenter;
  self.targetlead.states["scanning"]["update"] = &targetlead_scanningstateupdate;
  self.targetlead.states["hold"] = [];
  self.targetlead.states["hold"]["enter"] = &targetlead_holdstateenter;
  self.targetlead.states["hold"]["update"] = &targetlead_holdstateupdate;
  self.targetlead.states["hold"]["exit"] = &targetlead_holdstateexit;
}

function targetlead_reset() {
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

function targetlead_offstateenter(var0) {
  if(isDefined(var0)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetlead.targetmarkergroup);
    self.targetlead.targetmarkergroup = undefined;
    return;
  }
}

function targetlead_offstateupdate() {
  if(self playerads() >= 0.6) {
    targetlead_queuestate("scanning");
    return;
  }
}

function targetlead_offstateexit() {}

function targetlead_scanningstateenter(var0) {
  self.targetlead.adsraisedelaytimer = gettime() + 100;

  if(isDefined(var0) && var0 == "off") {
    self.targetlead.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("kgolftarget", self, undefined, self);
    return;
  }
}

function targetlead_scanningstateupdate() {
  if(gettime() < self.targetlead.adsraisedelaytimer) {
    return;
  }

  var0 = targetlead_scanforvehicletarget();

  if(isDefined(var0)) {
    self.targetlead.target = var0;
    targetlead_queuestate("hold");
    return;
  }
}

function targetlead_holdstateenter(var0) {
  self.targetlead.lockstarttime = gettime();
  self.targetlead.lostsightlinetime = 0;
  self.targetlead.leadpositionent = scripts\engine\utility::spawn_tag_origin();
  self.targetlead.leadpositionent scripts\cp_mp\ent_manager::registerspawncount(1);
  self.targetlead.leadpositionent show();
  targetlead_uimarkentities();
}

function targetlead_holdstateupdate() {
  if(!targetlead_checktargetstillheld(self.targetlead.target)) {
    targetlead_queuestate("scanning");
    return;
  } else {
    var0 = targetlead_getleadposition(self.targetlead.target);

    if(isDefined(var0)) {
      self.targetlead.leadpositionent moveTo(var0, 0.05);
    }
  }

  var1 = self worldpointinreticle_circle(self.targetlead.leadpositionent.origin, 55, 40);

  if(var1 && !self.targetlead.isaimingatreticle) {
    self.targetlead.isaimingatreticle = 1;
    thread targetlead_airburstholdthink();
    return;
  }

  if(!var1 && self.targetlead.isaimingatreticle) {
    self.targetlead.isaimingatreticle = 0;
    self notify("stop_airburst_think");
    return;
  }
}

function targetlead_holdstateexit() {
  targetlead_uiunmarkentities();

  if(isDefined(self.targetlead.leadpositionent)) {
    self.targetlead.leadpositionent scripts\cp_mp\ent_manager::deregisterspawn();
    self.targetlead.leadpositionent delete();
  }

  self.targetlead.leadpositionent = undefined;
  self.targetlead.isaimingatreticle = 0;
  self notify("stop_airburst_think");
}

function targetlead_preupdate() {
  if(self.targetlead.state != "off") {
    if(self playerads() < 0.6) {
      targetlead_queuestate("off");
      return;
    }

    return;
  }
}

function targetlead_onstartthink() {}

function targetlead_onstopthink() {
  if(isDefined(self.targetlead.state) && self.targetlead.state != "off") {
    targetlead_enterstate("off");
    return;
  }
}

function targetlead_getleadposition(var0) {
  var1 = (0, 0, 0);

  if(var0.classname == "script_vehicle") {
    var1 = var0 vehicle_getvelocity();
  } else if(scripts\mp\utility\entity::isgunship(var0) || scripts\mp\utility\entity::isuav(var0)) {
    var1 = var0.velocity;
  }

  var2 = var0.origin + targetlead_getvehicleoffset(var0);
  var3 = self getEye();
  var4 = 4000;
  var5 = projectileintercept(var3, (0, 0, 0), var4, var2, var1);

  if(isDefined(var5)) {
    return var5;
  }

  return undefined;
}

function targetlead_getvehicleoffset(var0) {
  var1 = (0, 0, 0);

  if(scripts\mp\utility\entity::ischoppergunner(var0)) {
    var1 = (0, 0, -50);
  } else if(scripts\mp\utility\entity::issupporthelo(var0)) {
    var1 = (0, 0, -100);
  } else if(scripts\mp\utility\entity::isgunship(var0)) {
    var1 = (0, 0, 40);
  } else if(scripts\mp\utility\entity::isclusterstrike(var0)) {
    var1 = (0, 0, 40);
  } else if(scripts\mp\utility\entity::isradardrone(var0)) {
    var1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::turret_op(var0)) {
    var1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::isscramblerdrone(var0)) {
    var1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::isradarhelicopter(var0)) {
    var1 = (0, 0, 30);
  }

  return var1;
}

function targetlead_checktargetstillheld(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = self worldpointinreticle_circle(var0.origin, 55, 240);

  if(!var1) {
    return false;
  }

  if(!targetlead_softsighttest(var0)) {
    return false;
  }

  return true;
}

function targetlead_looplocalseeksound(var0, var1) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(var0);
    wait var1;
  }
}

function targetlead_queuestate(var0) {
  self.targetlead.queuedstate = var0;
}

function targetlead_getqueuedstate() {
  return self.targetlead.queuedstate;
}

function targetlead_enterstate(var0) {
  if(isDefined(self.targetlead.state)) {}

  var1 = self.targetlead.state;

  if(isDefined(var1) && isDefined(self.targetlead.states[var1]["exit"])) {
    self[[self.targetlead.states[var1]["exit"]]]();
  }

  self.targetlead.state = var0;

  if(isDefined(self.targetlead.states[var0]["enter"])) {
    self[[self.targetlead.states[var0]["enter"]]](var1);
  }

  self.targetlead.queuedstate = undefined;
}

function targetlead_shouldtargetleadthink() {
  return !scripts\cp_mp\emp_debuff::is_empd();
}

function targetlead_think() {
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
    var0 = targetlead_getqueuedstate();

    if(isDefined(var0)) {
      targetlead_enterstate(var0);
    }

    self[[self.targetlead.states[self.targetlead.state]["update"]]]();
    wait 0.05;
  }
}

function targetlead_earlyoutthink() {
  self endon("targetLead_stop");
  scripts\engine\utility::ref_143a5("death_or_disconnect", "faux_spawn");
  targetlead_onstopthink();
}

function targetlead_scanforvehicletarget() {
  var0 = scripts\mp\weapons::lockonlaunchers_gettargetarray();

  if(var0.size != 0) {
    var1 = [];

    foreach(var3 in var0) {
      var4 = self worldpointinreticle_circle(var3.origin, 55, 240);

      if(var4) {
        var1 = var3;
      }
    }

    if(var1.size != 0) {
      var6 = sortbydistance(var1, self.origin);

      if(targetlead_vehiclelocksighttest(var6[0])) {
        return var6[0];
      }
    }
  }

  return undefined;
}

function targetlead_vehiclelocksighttest(var0) {
  var1 = self getEye();
  var2 = var0 getpointinbounds(0, 0, 0);
  var3 = sighttracepassed(var1, var2, 0, var0);

  if(var3) {
    return true;
  }

  var4 = var0 getpointinbounds(1, 0, 0);
  var3 = sighttracepassed(var1, var4, 0, var0);

  if(var3) {
    return true;
  }

  var5 = var0 getpointinbounds(-1, 0, 0);
  var3 = sighttracepassed(var1, var5, 0, var0);

  if(var3) {
    return true;
  }

  return false;
}

function targetlead_softsighttest(var0) {
  if(targetlead_vehiclelocksighttest(var0)) {
    self.targetlead.lostsightlinetime = 0;
    return true;
  }

  if(self.targetlead.lostsightlinetime == 0) {
    self.targetlead.lostsightlinetime = gettime();
  }

  var1 = gettime() - self.targetlead.lostsightlinetime;

  if(var1 >= 500) {
    return false;
  }

  return true;
}

function targetlead_airburstholdthink() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("stop_airburst_think");
  self waittill("missile_fire", var0);

  if(isDefined(self.targetlead.target)) {
    thread targetlead_airburstmissilethink(var0, self.targetlead.target);
    return;
  }
}

function targetlead_airburstmissilethink(var0, var1) {
  self endon("death");

  for(;;) {
    if(!isDefined(var0)) {
      iprintlnbold("targetEnt undefined");
      return;
    }

    var2 = distance(var1.origin, var0.origin);
    var3 = distance(var1.origin, self.origin);

    if(var3 > var2) {
      self detonate();
      iprintlnbold("explode");
    }

    wait 0.05;
  }
}

function targetlead_uimarkentities() {
  targetmarkergroupremoveentity(self.targetlead.targetmarkergroup, self.targetlead.target);
  targetmarkergroupsetextrastate(self.targetlead.targetmarkergroup, self.targetlead.target, 1);
  targetmarkergroupremoveentity(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent);
  targetmarkergroupsetextrastate(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent, 0);
}

function targetlead_uiunmarkentities() {
  targetmarkergroupsetentitystate(self.targetlead.targetmarkergroup, self.targetlead.target);
  targetmarkergroupsetentitystate(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent);
}