/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\launcher_target_lead.gsc
***********************************************/

targetleadusageloop() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  targetlead_init();

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename == "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA" && targetlead_shouldtargetleadthink()) {
      self.targetlead.stopthinking = 0;
      thread targetlead_think();
    } else
      self.targetlead.stopthinking = 1;

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }
}

targetlead_init() {
  self.targetlead = spawnStruct();
  self.targetlead.states = [];
  self.targetlead.states["_encstr_BA19049F4B2D"] = [];
  self.targetlead.states["_encstr_BA19049F4B2D"]["_encstr_99BF0603D0C4979A"] = ::targetlead_offstateenter;
  self.targetlead.states["_encstr_BA19049F4B2D"]["_encstr_BD3107D507320BA356"] = ::targetlead_offstateupdate;
  self.targetlead.states["_encstr_BA19049F4B2D"]["_encstr_A760055987D2E8"] = ::targetlead_offstateexit;
  self.targetlead.states["_encstr_AF74091BB6D9354A87BA2F"] = [];
  self.targetlead.states["_encstr_AF74091BB6D9354A87BA2F"]["_encstr_99BF0603D0C4979A"] = ::targetlead_scanningstateenter;
  self.targetlead.states["_encstr_AF74091BB6D9354A87BA2F"]["_encstr_BD3107D507320BA356"] = ::targetlead_scanningstateupdate;
  self.targetlead.states["_encstr_B6CC0586B78D46"] = [];
  self.targetlead.states["_encstr_B6CC0586B78D46"]["_encstr_99BF0603D0C4979A"] = ::targetlead_holdstateenter;
  self.targetlead.states["_encstr_B6CC0586B78D46"]["_encstr_BD3107D507320BA356"] = ::targetlead_holdstateupdate;
  self.targetlead.states["_encstr_B6CC0586B78D46"]["_encstr_A760055987D2E8"] = ::targetlead_holdstateexit;
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

targetlead_offstateenter(var_0) {
  if(isDefined(var_0)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetlead.targetmarkergroup);
    self.targetlead.targetmarkergroup = undefined;
  }
}

targetlead_offstateupdate() {
  if(self playerads() >= 0.6)
    targetlead_queuestate("_encstr_AF74091BB6D9354A87BA2F");
}

targetlead_offstateexit() {}

targetlead_scanningstateenter(var_0) {
  self.targetlead.adsraisedelaytimer = gettime() + 100;

  if(isDefined(var_0) && var_0 == "_encstr_BA19049F4B2D")
    self.targetlead.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_AC180C47F755E8B4536A3B81328B", self, undefined, self);
}

targetlead_scanningstateupdate() {
  if(gettime() < self.targetlead.adsraisedelaytimer) {
    return;
  }
  var_0 = targetlead_scanforvehicletarget();

  if(isDefined(var_0)) {
    self.targetlead.target = var_0;
    targetlead_queuestate("_encstr_B6CC0586B78D46");
  }
}

targetlead_holdstateenter(var_0) {
  self.targetlead.lockstarttime = gettime();
  self.targetlead.lostsightlinetime = 0;
  self.targetlead.leadpositionent = scripts\engine\utility::spawn_tag_origin();
  self.targetlead.leadpositionent scripts\cp_mp\ent_manager::registerspawncount(1);
  self.targetlead.leadpositionent show();
  targetlead_uimarkentities();
}

targetlead_holdstateupdate() {
  if(!targetlead_checktargetstillheld(self.targetlead.target)) {
    targetlead_queuestate("_encstr_AF74091BB6D9354A87BA2F");
    return;
  } else {
    var_0 = targetlead_getleadposition(self.targetlead.target);

    if(isDefined(var_0))
      self.targetlead.leadpositionent moveTo(var_0, 0.05);
  }

  var_1 = self worldpointinreticle_circle(self.targetlead.leadpositionent.origin, 55, 40);

  if(var_1 && !self.targetlead.isaimingatreticle) {
    self.targetlead.isaimingatreticle = 1;
    thread targetlead_airburstholdthink();
  } else if(!var_1 && self.targetlead.isaimingatreticle) {
    self.targetlead.isaimingatreticle = 0;
    self notify("_encstr_ACE6141A9310DB690770D8391D9313E1FFC4AB2F7D3C");
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
  self notify("_encstr_ACE6141A9310DB690770D8391D9313E1FFC4AB2F7D3C");
}

targetlead_preupdate() {
  if(self.targetlead.state != "_encstr_BA19049F4B2D") {
    if(self playerads() < 0.6)
      targetlead_queuestate("_encstr_BA19049F4B2D");
  }
}

targetlead_onstartthink() {}

targetlead_onstopthink() {
  if(isDefined(self.targetlead.state) && self.targetlead.state != "_encstr_BA19049F4B2D")
    targetlead_enterstate("_encstr_BA19049F4B2D");
}

targetlead_getleadposition(var_0) {
  var_1 = (0, 0, 0);

  if(var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
    var_1 = var_0 vehicle_getvelocity();
  else if(scripts\mp\utility\entity::isgunship(var_0) || scripts\mp\utility\entity::isuav(var_0))
    var_1 = var_0.velocity;

  var_2 = var_0.origin + targetlead_getvehicleoffset(var_0);
  var_3 = self getEye();
  var_4 = 4000;
  var_5 = projectileintercept(var_3, (0, 0, 0), var_4, var_2, var_1);

  if(isDefined(var_5))
    return var_5;

  return undefined;
}

targetlead_getvehicleoffset(var_0) {
  var_1 = (0, 0, 0);

  if(scripts\mp\utility\entity::ischoppergunner(var_0))
    var_1 = (0, 0, -50);
  else if(scripts\mp\utility\entity::issupporthelo(var_0))
    var_1 = (0, 0, -100);
  else if(scripts\mp\utility\entity::isgunship(var_0))
    var_1 = (0, 0, 40);
  else if(scripts\mp\utility\entity::isclusterstrike(var_0))
    var_1 = (0, 0, 40);
  else if(scripts\mp\utility\entity::isradardrone(var_0))
    var_1 = (0, 0, 10);
  else if(scripts\mp\utility\entity::turret_op(var_0))
    var_1 = (0, 0, 10);
  else if(scripts\mp\utility\entity::isscramblerdrone(var_0))
    var_1 = (0, 0, 10);
  else if(scripts\mp\utility\entity::isradarhelicopter(var_0))
    var_1 = (0, 0, 30);

  return var_1;
}

targetlead_checktargetstillheld(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = self worldpointinreticle_circle(var_0.origin, 55, 240);

  if(!var_1)
    return 0;

  if(!targetlead_softsighttest(var_0))
    return 0;

  return 1;
}

targetlead_looplocalseeksound(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A36612ABED38131911B88A02D07D414790D50E34");

  for(;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}

targetlead_queuestate(var_0) {
  self.targetlead.queuedstate = var_0;
}

targetlead_getqueuedstate() {
  return self.targetlead.queuedstate;
}

targetlead_enterstate(var_0) {
  if(isDefined(self.targetlead.state)) {}

  var_1 = self.targetlead.state;

  if(isDefined(var_1) && isDefined(self.targetlead.states[var_1]["_encstr_A760055987D2E8"]))
    self[[self.targetlead.states[var_1]["_encstr_A760055987D2E8"]]]();

  self.targetlead.state = var_0;

  if(isDefined(self.targetlead.states[var_0]["_encstr_99BF0603D0C4979A"]))
    self[[self.targetlead.states[var_0]["_encstr_99BF0603D0C4979A"]]](var_1);

  self.targetlead.queuedstate = undefined;
}

targetlead_shouldtargetleadthink() {
  return !scripts\cp_mp\emp_debuff::is_empd();
}

targetlead_think() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self notify("_encstr_BE68111D3F82592B614C61581861C954EC8DB3");
  self endon("_encstr_BE68111D3F82592B614C61581861C954EC8DB3");
  targetlead_reset();
  targetlead_enterstate("_encstr_BA19049F4B2D");
  targetlead_onstartthink();
  thread targetlead_earlyoutthink();

  for(;;) {
    if(isDefined(self.targetlead.stopthinking) && self.targetlead.stopthinking || !targetlead_shouldtargetleadthink()) {
      self notify("_encstr_816B1063FA2354C8C3941B0BA46130A52F83");
      targetlead_onstopthink();
      return;
    }

    targetlead_preupdate();
    var_0 = targetlead_getqueuedstate();

    if(isDefined(var_0))
      targetlead_enterstate(var_0);

    self[[self.targetlead.states[self.targetlead.state]["_encstr_BD3107D507320BA356"]]]();
    wait 0.05;
  }
}

targetlead_earlyoutthink() {
  self endon("_encstr_816B1063FA2354C8C3941B0BA46130A52F83");
  scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_91D70BC8AF032B0F1B734F731A");
  targetlead_onstopthink();
}

targetlead_scanforvehicletarget() {
  var_0 = scripts\mp\weapons::lockonlaunchers_gettargetarray();

  if(var_0.size != 0) {
    var_1 = [];

    foreach(var_3 in var_0) {
      var_4 = self worldpointinreticle_circle(var_3.origin, 55, 240);

      if(var_4)
        var_1[var_1.size] = var_3;
    }

    if(var_1.size != 0) {
      var_6 = sortbydistance(var_1, self.origin);

      if(targetlead_vehiclelocksighttest(var_6[0]))
        return var_6[0];
    }
  }

  return undefined;
}

targetlead_vehiclelocksighttest(var_0) {
  var_1 = self getEye();
  var_2 = var_0 getpointinbounds(0, 0, 0);
  var_3 = sighttracepassed(var_1, var_2, 0, var_0);

  if(var_3)
    return 1;

  var_4 = var_0 getpointinbounds(1, 0, 0);
  var_3 = sighttracepassed(var_1, var_4, 0, var_0);

  if(var_3)
    return 1;

  var_5 = var_0 getpointinbounds(-1, 0, 0);
  var_3 = sighttracepassed(var_1, var_5, 0, var_0);

  if(var_3)
    return 1;

  return 0;
}

targetlead_softsighttest(var_0) {
  if(targetlead_vehiclelocksighttest(var_0)) {
    self.targetlead.lostsightlinetime = 0;
    return 1;
  }

  if(self.targetlead.lostsightlinetime == 0)
    self.targetlead.lostsightlinetime = gettime();

  var_1 = gettime() - self.targetlead.lostsightlinetime;

  if(var_1 >= 500)
    return 0;

  return 1;
}

targetlead_airburstholdthink() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_ACE6141A9310DB690770D8391D9313E1FFC4AB2F7D3C");
  self waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0);

  if(isDefined(self.targetlead.target))
    var_0 thread targetlead_airburstmissilethink(self.targetlead.target, self);
}

targetlead_airburstmissilethink(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(var_0)) {
      iprintlnbold("_encstr_A72E143A8527ECB247A837A308D59B8CCA995A73598C");
      return;
    }

    var_2 = distance(var_1.origin, var_0.origin);
    var_3 = distance(var_1.origin, self.origin);

    if(var_3 > var_2) {
      self detonate();
      iprintlnbold("_encstr_860808CB78E2984063BA");
    }

    wait 0.05;
  }
}

targetlead_uimarkentities() {
  targetmarkergroupremoveentity(self.targetlead.targetmarkergroup, self.targetlead.target);
  targetmarkergroupsetextrastate(self.targetlead.targetmarkergroup, self.targetlead.target, 1);
  targetmarkergroupremoveentity(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent);
  targetmarkergroupsetextrastate(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent, 0);
}

targetlead_uiunmarkentities() {
  targetmarkergroupsetentitystate(self.targetlead.targetmarkergroup, self.targetlead.target);
  targetmarkergroupsetentitystate(self.targetlead.targetmarkergroup, self.targetlead.leadpositionent);
}