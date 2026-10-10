/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\launcher_target_lead.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\engine\utility;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace launcher_target_lead;

function targetleadusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  targetlead_init();

  while(true) {
    weapon = self getcurrentweapon();

    if(weapon.basename == "iw8_la_kgolf_mp" && targetlead_shouldtargetleadthink()) {
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

function targetlead_offstateenter(fromstate) {
  if(isDefined(fromstate)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetlead.targetmarkergroup);
    self.targetlead.targetmarkergroup = undefined;
  }
}

function targetlead_offstateupdate() {
  if(self playerads() >= 0.6) {
    targetlead_queuestate("scanning");
  }
}

function targetlead_offstateexit() {}

function targetlead_scanningstateenter(fromstate) {
  self.targetlead.adsraisedelaytimer = gettime() + 100;

  if(isDefined(fromstate) && fromstate == "off") {
    self.targetlead.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("kgolftarget", self, undefined, self);
  }
}

function targetlead_scanningstateupdate() {
  if(gettime() < self.targetlead.adsraisedelaytimer) {
    return;
  }

  vehicletarget = targetlead_scanforvehicletarget();

  if(isDefined(vehicletarget)) {
    function_7ea27fe25f2f18e5("<dev string:x1c>");

    self.targetlead.target = vehicletarget;
    targetlead_queuestate("hold");
  }
}

function targetlead_holdstateenter(fromstate) {
  self.targetlead.lockstarttime = gettime();
  self.targetlead.lostsightlinetime = 0;
  self.targetlead.leadpositionent = spawn_tag_origin();
  self.targetlead.leadpositionent scripts\cp_mp\ent_manager::registerspawncount(1);
  self.targetlead.leadpositionent show();
  targetlead_uimarkentities();
}

function targetlead_holdstateupdate() {
  function_6eee6cec92ff2a91(self.targetlead.target.origin, (0.5, 1, 0.6));

  if(!targetlead_checktargetstillheld(self.targetlead.target)) {
    targetlead_queuestate("scanning");
    return;
  } else {
    newposition = targetlead_getleadposition(self.targetlead.target);

    if(isDefined(newposition)) {
      self.targetlead.leadpositionent moveTo(newposition, 0.05);
    }
  }

  insidereticle = self worldpointinreticle_circle(self.targetlead.leadpositionent.origin, 55, 40);

  if(insidereticle && !self.targetlead.isaimingatreticle) {
    self.targetlead.isaimingatreticle = 1;
    thread targetlead_airburstholdthink();
    return;
  }

  if(!insidereticle && self.targetlead.isaimingatreticle) {
    self.targetlead.isaimingatreticle = 0;
    self notify("stop_airburst_think");
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
    }
  }
}

function targetlead_onstartthink() {}

function targetlead_onstopthink() {
  if(isDefined(self.targetlead.state) && self.targetlead.state != "off") {
    targetlead_enterstate("off");
  }
}

function targetlead_getleadposition(trackedentity) {
  entvelocity = (0, 0, 0);

  if(trackedentity.classname == "script_vehicle") {
    entvelocity = trackedentity vehicle_getvelocity();
  } else if(isgunship(trackedentity) || isuav(trackedentity)) {
    entvelocity = trackedentity.velocity;
  }

  entposition = trackedentity.origin + targetlead_getvehicleoffset(trackedentity);
  playerposition = self getEye();
  missilespeed = 4000;
  intercept = projectileintercept(playerposition, (0, 0, 0), missilespeed, entposition, entvelocity);

  if(isDefined(intercept)) {
    function_6eee6cec92ff2a91(intercept, (0.5, 1, 0.6), 30);

    return intercept;
  }

  return undefined;
}

function targetlead_getvehicleoffset(vehicletarget) {
  offset = (0, 0, 0);

  if(ischoppergunner(vehicletarget)) {
    offset = (0, 0, -50);
  } else if(issupporthelo(vehicletarget)) {
    offset = (0, 0, -100);
  } else if(isgunship(vehicletarget)) {
    offset = (0, 0, 40);
  } else if(isclusterstrike(vehicletarget)) {
    offset = (0, 0, 40);
  } else if(isradardrone(vehicletarget)) {
    offset = (0, 0, 10);
  } else if(isassaultdrone(vehicletarget)) {
    offset = (0, 0, 10);
  } else if(isscramblerdrone(vehicletarget)) {
    offset = (0, 0, 10);
  } else if(isradarhelicopter(vehicletarget)) {
    offset = (0, 0, 30);
  }

  return offset;
}

function targetlead_checktargetstillheld(targetent) {
  if(!isDefined(targetent)) {
    return false;
  }

  insidereticle = self worldpointinreticle_circle(targetent.origin, 55, 240);

  if(!insidereticle) {
    return false;
  }

  if(!targetlead_softsighttest(targetent)) {
    return false;
  }

  return true;
}

function targetlead_looplocalseeksound(alias, interval) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(alias);
    wait interval;
  }
}

function targetlead_queuestate(statename) {
  self.targetlead.queuedstate = statename;
}

function targetlead_getqueuedstate() {
  return self.targetlead.queuedstate;
}

function targetlead_enterstate(statename) {
  assertex(isDefined(self.targetlead.states[statename]), "<dev string:x4e>" + statename + "<dev string:x89>");

  if(isDefined(self.targetlead.state)) {
    assertex(self.targetlead.state != statename, "<dev string:x90>" + statename + "<dev string:xbd>");
  }

  function_7ea27fe25f2f18e5("<dev string:xeb>" + statename + "<dev string:x10b>");

  fromstate = self.targetlead.state;

  if(isDefined(fromstate) && isDefined(self.targetlead.states[fromstate]["exit"])) {
    self[[self.targetlead.states[fromstate]["exit"]]]();
  }

  self.targetlead.state = statename;

  if(isDefined(self.targetlead.states[statename]["enter"])) {
    self[[self.targetlead.states[statename]["enter"]]](fromstate);
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

  while(true) {
    if(isDefined(self.targetlead.stopthinking) && self.targetlead.stopthinking || !targetlead_shouldtargetleadthink()) {
      self notify("targetLead_stop");
      targetlead_onstopthink();
      return;
    }

    targetlead_preupdate();
    queuedstate = targetlead_getqueuedstate();

    if(isDefined(queuedstate)) {
      targetlead_enterstate(queuedstate);
    }

    self[[self.targetlead.states[self.targetlead.state]["update"]]]();
    wait 0.05;
  }
}

function targetlead_earlyoutthink() {
  self endon("targetLead_stop");
  waittill_any_2("death_or_disconnect", "faux_spawn");
  targetlead_onstopthink();
}

function targetlead_scanforvehicletarget() {
  targets = scripts\mp\weapons::lockonlaunchers_gettargetarray();

  if(targets.size != 0) {
    var_8110370edb23215a = [];

    foreach(target in targets) {
      insidereticle = self worldpointinreticle_circle(target.origin, 55, 240);

      if(insidereticle) {
        var_8110370edb23215a[var_8110370edb23215a.size] = target;
      }
    }

    if(var_8110370edb23215a.size != 0) {
      sortedtargets = sortbydistance(var_8110370edb23215a, self.origin);

      if(targetlead_vehiclelocksighttest(sortedtargets[0])) {
        return sortedtargets[0];
      }
    }
  }

  return undefined;
}

function targetlead_vehiclelocksighttest(target) {
  eyepos = self getEye();
  center = target getpointinbounds(0, 0, 0);
  passed = sighttracepassed(eyepos, center, 0, target);

  function_7db309b40a632139(eyepos, center, passed);

  if(passed) {
    return true;
  }

  front = target getpointinbounds(1, 0, 0);
  passed = sighttracepassed(eyepos, front, 0, target);

  function_7db309b40a632139(eyepos, front, passed);

  if(passed) {
    return true;
  }

  back = target getpointinbounds(-1, 0, 0);
  passed = sighttracepassed(eyepos, back, 0, target);

  function_7db309b40a632139(eyepos, back, passed);

  if(passed) {
    return true;
  }

  return false;
}

function targetlead_softsighttest(targetent) {
  if(targetlead_vehiclelocksighttest(targetent)) {
    self.targetlead.lostsightlinetime = 0;
    return true;
  }

  if(self.targetlead.lostsightlinetime == 0) {
    self.targetlead.lostsightlinetime = gettime();
  }

  timepassed = gettime() - self.targetlead.lostsightlinetime;

  if(timepassed >= 500) {
    return false;
  }

  return true;
}

function targetlead_airburstholdthink() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("stop_airburst_think");
  self waittill("missile_fire", projectile);

  if(isDefined(self.targetlead.target)) {
    projectile thread targetlead_airburstmissilethink(self.targetlead.target, self);
  }
}

function targetlead_airburstmissilethink(targetent, missileowner) {
  self endon("death");

  while(true) {
    if(!isDefined(targetent)) {
      iprintlnbold("targetEnt undefined");
      return;
    }

    disttotarget = distance(missileowner.origin, targetent.origin);
    var_9d67e835f1049ffc = distance(missileowner.origin, self.origin);

    if(var_9d67e835f1049ffc > disttotarget) {
      self detonate();
      iprintlnbold("explode");
    }

    wait 0.05;
  }
}

function targetlead_uimarkentities() {
  targetmarkergroupaddentity(self.targetlead.targetmarkergroup, self.targetlead.target);
  targetmarkergroupsetentitystate(self.targetlead.targetmarkergroup, self.targetlead.target, 1);
  targetmarkergroupaddentity(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent);
  targetmarkergroupsetentitystate(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent, 0);
}

function targetlead_uiunmarkentities() {
  targetmarkergroupremoveentity(self.targetlead.targetmarkergroup, self.targetlead.target);
  targetmarkergroupremoveentity(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent);
}

function function_7ea27fe25f2f18e5(text) {
  if(getDvar(@ "missiledebugtext") == "<dev string:x111>") {
    iprintln(text);
  }
}

function function_6eee6cec92ff2a91(point, color, radius) {
  if(getDvar(@ "missiledebugdraw") != "<dev string:x111>") {
    return;
  }

  if(isDefined(radius)) {
    line(point + (radius, 0, 0), point - (radius, 0, 0), color);
    line(point + (0, radius, 0), point - (0, radius, 0), color);
    line(point + (0, 0, radius), point - (0, 0, radius), color);
    return;
  }

  line(point + (10, 0, 0), point - (10, 0, 0), color);
  line(point + (0, 10, 0), point - (0, 10, 0), color);
  line(point + (0, 0, 10), point - (0, 0, 10), color);
}

function function_7db309b40a632139(start, end, passed) {
  if(getDvar(@ "missiledebugdraw") != "<dev string:x111>") {
    return;
  }

  if(passed) {
    color = (0.3, 1, 0.3);
  } else {
    color = (1, 0.2, 0.2);
  }

  my_offset = (0, 0, 5);
  line(start + my_offset, end, color);
}

# /