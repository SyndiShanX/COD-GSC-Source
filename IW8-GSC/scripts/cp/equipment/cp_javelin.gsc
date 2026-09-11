/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_javelin.gsc
***********************************************/

function javelinusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  javelin_init();

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename == "iw8_la_juliet_mp" && javelin_shouldjavelinthink()) {
      self.javelin.stopthinking = 0;
      thread javelin_think();
    } else {
      self.javelin.stopthinking = 1;
    }

    self waittill("weapon_change");
  }
}

function javelin_init() {
  self.javelin = spawnStruct();

  if(!isDefined(level.javelin)) {
    level.javelin = spawnStruct();
    level.javelin.states = [];
    level.javelin.states["off"] = [];
    level.javelin.states["off"]["enter"] = &javelin_offstateenter;
    level.javelin.states["off"]["update"] = &javelin_offstateupdate;
    level.javelin.states["off"]["exit"] = &javelin_offstateexit;
    level.javelin.states["scanning"] = [];
    level.javelin.states["scanning"]["enter"] = &javelin_scanningstateenter;
    level.javelin.states["scanning"]["update"] = &javelin_scanningstateupdate;
    level.javelin.states["hold"] = [];
    level.javelin.states["hold"]["enter"] = &javelin_holdstateenter;
    level.javelin.states["hold"]["update"] = &javelin_holdstateupdate;
    level.javelin.states["hold"]["exit"] = &javelin_holdstateexit;
    level.javelin.states["fire"] = [];
    level.javelin.states["fire"]["enter"] = &javelin_firestateenter;
    level.javelin.states["fire"]["update"] = &javelin_firestateupdate;
    level.javelin.states["fire"]["exit"] = &javelin_firestateexit;
    level.javelin.states["too_close"] = [];
    level.javelin.states["too_close"]["enter"] = &javelin_tooclosestateenter;
    level.javelin.states["too_close"]["update"] = &javelin_tooclosestateupdate;
    return;
  }
}

function javelin_reset() {
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

function javelin_offstateenter(var_0) {
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

function javelin_offstateupdate() {
  if(self playerads() >= 0.9) {
    javelin_queuestate("scanning");
    return;
  }
}

function javelin_offstateexit() {
  javelin_hidenormalhud(1);
}

function javelin_deathwatcher() {
  self endon("weapon_change");
  self waittill("death");
  javelin_hidenormalhud(0);
  javelin_setuistate(0);
}

function javelin_scanningstateenter(var_0) {
  javelin_setuistate(1);
  self.javelin.adsraisedelaytimer = gettime() + 100;
}

function javelin_scanningstateupdate() {
  if(gettime() < self.javelin.adsraisedelaytimer) {
    return;
  }

  var_0 = javelin_scanforvehicletarget();

  if(isDefined(var_0)) {
    if(javelin_targetpointtooclose(var_0.origin)) {
      javelin_queuestate("too_close");
      return;
    }

    if(isDefined(self.javelin.target) && self.javelin.target == var_0) {
      var_1 = 1;
    }

    self.javelin.target = var_0;

    if(isDefined(self.javelin.target)) {
      scripts\cp_mp\utility\weapon_utility::addlockedon(self.javelin.target, self);
    }

    if(!isDefined(self.javelinlocationtargeted)) {
      marklocation(self.javelin.target);
    }

    javelin_queuestate("hold");
    return;
  }

  if(self attackButtonPressed()) {
    if(self.javelin.groundlockmisses >= 1) {
      self.javelin.groundlockmisses = 0;
      self.javelin.groundpoints = undefined;
      return;
    }

    var_5 = javelin_eyetraceforward();

    if(!isDefined(var_5)) {
      self.javelin.groundlockmisses++;
      return;
    }

    if(javelin_targetpointtooclose(var_5[0])) {
      javelin_queuestate("too_close");
      return;
    }

    if(isDefined(self.javelin.groundpoints)) {
      var_6 = averagepoint(self.javelin.groundpoints);
      var_7 = distance(var_6, var_5[0]);

      if(var_7 > 400) {
        self.javelin.groundlockmisses++;
        return;
      }
    } else {
      self.javelin.groundpoints = [];
      self.javelin.groundnormals = [];
    }

    self.javelin.groundpoints[self.javelin.groundpoints.size] = var_5[0];
    self.javelin.groundnormals[self.javelin.groundnormals.size] = var_5[1];
    self.javelin.groundlockmisses = 0;

    if(self.javelin.groundpoints.size < 2) {
      return;
    }

    var_8 = averagepoint(self.javelin.groundpoints);
    self.javelin.groundlockonent = scripts\engine\utility::spawn_tag_origin(var_8);
    self.javelin.groundlockonent scripts\cp_mp\ent_manager::registerspawncount(1);
    self.javelin.target = self.javelin.groundlockonent;
    self.javelin.groundlockmisses = 0;
    self.javelin.groundpoints = undefined;
    self.javelin.groundnormals = undefined;

    if(!isDefined(self.javelinlocationtargeted)) {
      marklocation(self.javelin.target);
    }

    javelin_queuestate("hold");
    return;
  }
}

function javelin_holdstateenter(var_0) {
  javelin_setuistate(2);
  self.javelin.lockstarttime = gettime();
  self.javelin.lostsightlinetime = 0;
  self weaponlockstart(self.javelin.target);
  thread javelin_looplocalseeksound("javelin_clu_acquiring_lock", 0.5);
}

function javelin_holdstateupdate() {
  var_0 = 0;
  var_1 = 0;

  if(!var_0 && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::ref_141b9(self.javelin.target, self)) {
    javelin_queuestate("scanning");
    var_1 = 1;
  }

  if(!javelin_checktargetstillheld(self.javelin.target)) {
    javelin_queuestate("scanning");
    var_1 = 1;
  }

  if(javelin_targetpointtooclose(self.javelin.target.origin)) {
    javelin_queuestate("too_close");
    var_1 = 1;
  }

  if(var_1) {
    if(isDefined(self.javelin.target)) {
      scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);
    }

    self weaponlockfree();
    self.javelin.target = undefined;

    if(isDefined(self.javelin.groundlockonent)) {
      self.javelin.groundlockonent delete();
    }
  }

  var_2 = gettime() - self.javelin.lockstarttime;

  if(var_2 < 1150) {
    return;
  }

  javelin_queuestate("fire");
}

function javelin_holdstateexit() {
  self notify("stop_lockon_sound");
  self stoplocalsound("javelin_clu_acquiring_lock");
}

function javelin_firestateenter(var_0) {
  javelin_setuistate(3);

  if(!isDefined(self.javelin.target)) {
    return;
  }

  if(isPlayer(self.javelin.target)) {
    self weaponlockfinalize(self.javelin.target, (0, 0, 64), 0);
  } else if(isDefined(self.javelin.groundlockonent)) {
    self weaponlockfinalize(self.javelin.target, (0, 0, 0), 1);
  } else {
    var_1 = javelin_getvehicleoffset(self.javelin.target);
    self weaponlockfinalize(self.javelin.target, var_1, 0);
  }

  thread javelin_looplocalseeksound("javelin_clu_lock", 1.6);
}

function javelin_firestateupdate() {
  var_0 = 0;

  if(!var_0 && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::ref_141b9(self.javelin.target, self)) {
    javelin_queuestate("scanning");
  }

  if(!javelin_checktargetstillheld(self.javelin.target)) {
    javelin_queuestate("scanning");
  }

  if(javelin_targetpointtooclose(self.javelin.target.origin)) {
    javelin_queuestate("too_close");
    return;
  }
}

function javelin_firestateexit() {
  if(isDefined(self.javelin.target)) {
    scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);
  }

  self weaponlockfree();
  self.javelin.target = undefined;

  if(isDefined(self.javelin.groundlockonent)) {
    self.javelin.groundlockonent delete();
  }

  self notify("stop_lockon_sound");
  self stoplocalsound("javelin_clu_lock");
}

function javelin_tooclosestateenter(var_0) {
  javelin_setuistate(4);
}

function javelin_tooclosestateupdate() {
  var_0 = javelin_scanforvehicletarget();

  if(isDefined(var_0)) {
    if(!javelin_targetpointtooclose(var_0.origin)) {
      javelin_queuestate("scanning");
      return;
    }

    return;
  }

  var_1 = javelin_eyetraceforward();

  if(!isDefined(var_1) || isDefined(var_1) && javelin_targetpointtooclose(var_1[0]) == 0) {
    javelin_queuestate("scanning");
    return;
  }
}

function javelin_preupdate() {
  if(isDefined(self.javelin.state) && self.javelin.state != "off") {
    if(self playerads() < 0.9) {
      javelin_queuestate("off");
      return;
    }

    return;
  }
}

function javelin_checktargetstillheld(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = self worldpointinreticle_rect(var_0.origin, 35, 120, 80);

  if(!var_1) {
    return false;
  }

  if(!isDefined(self.javelin.groundlockonent) && !javelin_softsighttest(var_0)) {
    return false;
  }

  if(isDefined(self.javelin.groundlockonent)) {
    if(!self attackButtonPressed()) {
      return false;
    }
  }

  return true;
}

function javelin_eyetraceforward() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 15000;
  var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 0, undefined);

  if(var_4["surfacetype"] == "surftype_none" && var_4["hittype"] == "hittype_none") {
    return undefined;
  }

  if(var_4["surfacetype"] == "default") {
    return undefined;
  }

  var_5 = var_4["entity"];
  var_6 = [];
  GscBinSkip0(0x2e, 0, var_4["position"]);
}

function javelin_targetpointtooclose(var_0) {
  var_1 = 1100;

  if(!isDefined(var_0)) {
    return false;
  }

  var_2 = distance(self.origin, var_0);

  if(var_2 < var_1) {
    return true;
  }

  return false;
}

function javelin_looplocalseeksound(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(var_0);
    wait var_1;
  }
}

function javelin_queuestate(var_0) {
  self.javelin.queuedstate = var_0;
}

function javelin_getqueuedstate() {
  return self.javelin.queuedstate;
}

function javelin_enterstate(var_0) {
  var_1 = self.javelin.state;

  if(isDefined(var_1) && isDefined(level.javelin.states[var_1]["exit"])) {
    self[[level.javelin.states[var_1]["exit"]]]();
  }

  self.javelin.state = var_0;

  if(isDefined(level.javelin.states[var_0]["enter"])) {
    self[[level.javelin.states[var_0]["enter"]]](var_1);
  }

  self.javelin.queuedstate = undefined;
}

function javelin_shouldjavelinthink() {
  return !scripts\cp_mp\emp_debuff::is_empd();
}

function javelin_think() {
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
    var_0 = javelin_getqueuedstate();

    if(isDefined(var_0)) {
      javelin_enterstate(var_0);
    }

    self[[level.javelin.states[self.javelin.state]["update"]]]();
    wait 0.05;
  }
}

function javelin_scanforvehicletarget() {
  var_0 = scripts\cp\cp_weapon::lockonlaunchers_gettargetarray();

  foreach(var_2 in var_0) {
    if(!isent(var_2)) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
    }
  }

  if(var_0.size != 0) {
    var_4 = [];

    foreach(var_2 in var_0) {
      var_6 = self worldpointinreticle_rect(var_2.origin, 35, 120, 80);

      if(var_6) {
        var_4 = var_2;
      }
    }

    if(var_4.size != 0) {
      var_8 = sortbydistance(var_4, self.origin);

      if(javelin_vehiclelocksighttest(var_8[0])) {
        return var_8[0];
      }
    }
  }

  return undefined;
}

function javelin_vehiclelocksighttest(var_0) {
  var_1 = self getEye();
  var_2 = var_0 getpointinbounds(0, 0, 1);
  var_3 = sighttracepassed(var_1, var_2, 0, var_0);

  if(var_3) {
    return true;
  }

  var_4 = var_0 getpointinbounds(1, 0, 0);
  var_3 = sighttracepassed(var_1, var_4, 0, var_0);

  if(var_3) {
    return true;
  }

  var_5 = var_0 getpointinbounds(-1, 0, 0);
  var_3 = sighttracepassed(var_1, var_5, 0, var_0);

  if(var_3) {
    return true;
  }

  return false;
}

function javelin_getvehicleoffset(var_0) {
  var_1 = (0, 0, 0);

  if(!isDefined(var_0)) {
    return var_1;
  }

  if(scripts\cp\utility\entity::ischoppergunner(var_0)) {
    var_1 = (0, 0, -50);
  } else if(scripts\cp\utility\entity::issupporthelo(var_0)) {
    var_1 = (0, 0, -100);
  } else if(scripts\cp\utility\entity::isgunship(var_0)) {
    var_1 = (0, 0, 50);
  } else if(scripts\cp\utility\entity::isclusterstrike(var_0)) {
    var_1 = (0, 0, 40);
  } else if(scripts\cp\utility\entity::isradardrone(var_0)) {
    var_1 = (0, 0, 10);
  } else if(scripts\cp\utility\entity::isscramblerdrone(var_0)) {
    var_1 = (0, 0, 10);
  } else if(scripts\cp\utility\entity::isradarhelicopter(var_0)) {
    var_1 = (0, 0, -30);
  }

  return var_1;
}

function javelin_softsighttest(var_0) {
  if(javelin_vehiclelocksighttest(var_0)) {
    self.javelin.lostsightlinetime = 0;
    return true;
  }

  if(self.javelin.lostsightlinetime == 0) {
    self.javelin.lostsightlinetime = gettime();
  }

  var_1 = gettime() - self.javelin.lostsightlinetime;

  if(var_1 >= 500) {
    return false;
  }

  return true;
}

function javelin_hidenormalhud(var_0) {
  if(var_0) {
    self setclientomnvar("ui_javelin_view", 1);
    return;
  }

  self setclientomnvar("ui_javelin_view", 0);
}

function javelin_setuistate(var_0) {
  self setclientomnvar("ui_javelin_state", var_0);
}

function marklocation(var_0) {
  var_1 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("javelincrosshair", self, var_0, self);

  if(var_0.model == "tag_origin") {
    var_0 show();
  }

  self.javelinlocationtargeted = 1;
  thread watchtargetmarkerentstatus(var_0, var_1, 1);
}

function watchtargetmarkerentstatus(var_0, var_1, var_2) {
  level endon("game_ended");

  while(isDefined(self.javelin.target) && self.javelin.state != "off") {
    waitframe();
  }

  if(isDefined(var_1)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_1);
  }

  self.javelinlocationtargeted = undefined;
}