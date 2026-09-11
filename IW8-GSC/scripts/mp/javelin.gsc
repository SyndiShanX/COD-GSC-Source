/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\javelin.gsc
***********************************************/

function javelinusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  javelin_init();

  for(;;) {
    var0 = self getcurrentweapon();

    if(var0.basename == "iw8_la_juliet_mp" && javelin_shouldjavelinthink()) {
      self.javelin.stopthinking = 0;
      thread javelin_think();
    } else {
      self.javelin.stopthinking = 1;
    }

    scripts\engine\utility::ref_143a5("weapon_change", "emp_cleared");
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

function javelin_offstateenter(var0) {
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

  if(isDefined(self)) {
    javelin_hidenormalhud(0);
    javelin_setuistate(0);
    return;
  }
}

function javelin_scanningstateenter(var0) {
  javelin_setuistate(1);
  self.javelin.adsraisedelaytimer = gettime() + 100;
}

function javelin_scanningstateupdate() {
  if(gettime() < self.javelin.adsraisedelaytimer) {
    return;
  }

  var0 = javelin_scanforvehicletarget();

  if(isDefined(var0)) {
    if(javelin_targetpointtooclose(var0.origin)) {
      javelin_queuestate("too_close");
      return;
    }

    if(isDefined(self.javelin.target) && self.javelin.target == var0) {
      var1 = 1;
    }

    self.javelin.target = var0;

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

    var5 = javelin_eyetraceforward();

    if(!isDefined(var5)) {
      self.javelin.groundlockmisses++;
      return;
    }

    if(javelin_targetpointtooclose(var5[0])) {
      javelin_queuestate("too_close");
      return;
    }

    if(isDefined(self.javelin.groundpoints)) {
      var6 = averagepoint(self.javelin.groundpoints);
      var7 = distance(var6, var5[0]);

      if(var7 > 400) {
        self.javelin.groundlockmisses++;
        return;
      }
    } else {
      self.javelin.groundpoints = [];
      self.javelin.groundnormals = [];
    }

    self.javelin.groundpoints[self.javelin.groundpoints.size] = var5[0];
    self.javelin.groundnormals[self.javelin.groundnormals.size] = var5[1];
    self.javelin.groundlockmisses = 0;

    if(self.javelin.groundpoints.size < 2) {
      return;
    }

    var8 = averagepoint(self.javelin.groundpoints);
    self.javelin.groundlockonent = scripts\engine\utility::spawn_tag_origin(var8);
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

function javelin_holdstateenter(var0) {
  if(!isDefined(self.javelin.target)) {
    return;
  }

  javelin_setuistate(2);
  self.javelin.lockstarttime = gettime();
  self.javelin.lostsightlinetime = 0;
  self weaponlockstart(self.javelin.target);
  thread javelin_looplocalseeksound("javelin_clu_acquiring_lock", 0.5);
}

function javelin_holdstateupdate() {
  var0 = 0;

  if(!isDefined(self.javelin.target)) {
    javelin_queuestate("scanning");
    return;
  }

  var1 = 0;

  if(!var0 && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::ref_141b9(self.javelin.target, self)) {
    javelin_queuestate("scanning");
    var1 = 1;
  }

  if(!javelin_checktargetstillheld(self.javelin.target)) {
    javelin_queuestate("scanning");
    var1 = 1;
  }

  if(javelin_targetpointtooclose(self.javelin.target.origin)) {
    javelin_queuestate("too_close");
    var1 = 1;
  }

  if(var1) {
    if(isDefined(self.javelin.target)) {
      scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);
    }

    self weaponlockfree();
    self.javelin.target = undefined;

    if(isDefined(self.javelin.groundlockonent)) {
      self.javelin.groundlockonent delete();
    }
  }

  var2 = gettime() - self.javelin.lockstarttime;

  if(var2 < 1150) {
    return;
  }

  javelin_queuestate("fire");
}

function javelin_holdstateexit() {
  self notify("stop_lockon_sound");
  self stoplocalsound("javelin_clu_acquiring_lock");
}

function javelin_firestateenter(var0) {
  javelin_setuistate(3);

  if(!isDefined(self.javelin.target)) {
    return;
  }

  if(isPlayer(self.javelin.target)) {
    self weaponlockfinalize(self.javelin.target, (0, 0, 64), 0);
  } else if(isDefined(self.javelin.groundlockonent)) {
    self weaponlockfinalize(self.javelin.target, (0, 0, 0), 1);
  } else {
    var1 = javelin_getvehicleoffset(self.javelin.target);
    self weaponlockfinalize(self.javelin.target, var1, 0);
  }

  thread javelin_looplocalseeksound("javelin_clu_lock", 1.6);
}

function javelin_firestateupdate() {
  var0 = 0;

  if(!isDefined(self.javelin.target)) {
    javelin_queuestate("scanning");
    return;
  }

  if(!var0 && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::ref_141b9(self.javelin.target, self)) {
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

function javelin_tooclosestateenter(var0) {
  javelin_setuistate(4);
}

function javelin_tooclosestateupdate() {
  var0 = javelin_scanforvehicletarget();

  if(isDefined(var0)) {
    if(!javelin_targetpointtooclose(var0.origin)) {
      javelin_queuestate("scanning");
      return;
    }

    return;
  }

  var1 = javelin_eyetraceforward();

  if(!isDefined(var1) || isDefined(var1) && javelin_targetpointtooclose(var1[0]) == 0) {
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

function javelin_checktargetstillheld(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = self worldpointinreticle_rect(var0.origin, 35, 120, 80);

  if(!var1) {
    return false;
  }

  if(!isDefined(self.javelin.groundlockonent) && !javelin_softsighttest(var0)) {
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
  var0 = self getEye();
  var1 = self getplayerangles();
  var2 = anglesToForward(var1);
  var3 = var0 + var2 * 15000;
  var4 = scripts\engine\trace::_bullet_trace(var0, var3, 0, undefined);

  if(var4["surfacetype"] == "surftype_none" && var4["hittype"] == "hittype_none") {
    return undefined;
  }

  if(var4["surfacetype"] == "default") {
    return undefined;
  }

  var5 = var4["entity"];
  var6 = [];
  GscBinSkip0(0x2e, 0, var4["position"]);
}

function javelin_targetpointtooclose(var0) {
  var1 = 1100;
  var2 = distance(self.origin, var0);

  if(var2 < var1) {
    return true;
  }

  return false;
}

function javelin_looplocalseeksound(var0, var1) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(var0);
    wait var1;
  }
}

function javelin_queuestate(var0) {
  self.javelin.queuedstate = var0;
}

function javelin_getqueuedstate() {
  return self.javelin.queuedstate;
}

function javelin_enterstate(var0) {
  var1 = self.javelin.state;

  if(isDefined(var1) && isDefined(level.javelin.states[var1]["exit"])) {
    self[[level.javelin.states[var1]["exit"]]]();
  }

  self.javelin.state = var0;

  if(isDefined(level.javelin.states[var0]["enter"])) {
    self[[level.javelin.states[var0]["enter"]]](var1);
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
    var0 = javelin_getqueuedstate();

    if(isDefined(var0)) {
      javelin_enterstate(var0);
    }

    self[[level.javelin.states[self.javelin.state]["update"]]]();
    wait 0.05;
  }
}

function javelin_scanforvehicletarget() {
  var0 = scripts\mp\weapons::lockonlaunchers_gettargetarray();
  var1 = getdvarint("scr_maxmissilelockonrange", 625000000);

  if(var0.size != 0) {
    var2 = [];

    foreach(var4 in var0) {
      if(!isDefined(var4)) {
        continue;
      }

      var5 = self worldpointinreticle_rect(var4.origin, 35, 120, 80);

      if(var5 && distancesquared(var4.origin, self.origin) <= var1) {
        var2 = var4;
      }
    }

    if(var2.size != 0) {
      var7 = sortbydistance(var2, self.origin);

      if(javelin_vehiclelocksighttest(var7[0])) {
        return var7[0];
      }
    }
  }

  return undefined;
}

function javelin_vehiclelocksighttest(var0) {
  var1 = self getEye();
  var2 = var0 getpointinbounds(0, 0, 1);
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

function javelin_getvehicleoffset(var0) {
  var1 = (0, 0, 0);

  if(!isDefined(var0)) {
    return var1;
  }

  if(scripts\mp\utility\entity::ischoppergunner(var0)) {
    var1 = (0, 0, -50);
  } else if(scripts\mp\utility\entity::issupporthelo(var0)) {
    var1 = (0, 0, -100);
  } else if(scripts\mp\utility\entity::isgunship(var0)) {
    var1 = (0, 0, 50);
  } else if(scripts\mp\utility\entity::isclusterstrike(var0)) {
    var1 = (0, 0, 40);
  } else if(scripts\mp\utility\entity::isradardrone(var0)) {
    var1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::turret_op(var0)) {
    var1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::isscramblerdrone(var0)) {
    var1 = (0, 0, 10);
  } else if(scripts\mp\utility\entity::isradarhelicopter(var0)) {
    var1 = (0, 0, -30);
  } else if(isDefined(var0.vehiclename) && var0.vehiclename == "loot_chopper") {
    var1 = (0, 0, -100);
  }

  return var1;
}

function javelin_softsighttest(var0) {
  if(javelin_vehiclelocksighttest(var0)) {
    self.javelin.lostsightlinetime = 0;
    return true;
  }

  if(self.javelin.lostsightlinetime == 0) {
    self.javelin.lostsightlinetime = gettime();
  }

  var1 = gettime() - self.javelin.lostsightlinetime;

  if(var1 >= 500) {
    return false;
  }

  return true;
}

function javelin_hidenormalhud(var0) {
  if(var0) {
    self setclientomnvar("ui_javelin_view", 1);
    return;
  }

  self setclientomnvar("ui_javelin_view", 0);
}

function javelin_setuistate(var0) {
  self setclientomnvar("ui_javelin_state", var0);
}

function marklocation(var0) {
  var1 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("javelincrosshair", self, var0, self);

  if(var0.model == "tag_origin") {
    var0 show();
  }

  self.javelinlocationtargeted = 1;
  thread watchtargetmarkerentstatus(var0, var1, 1);
}

function watchtargetmarkerentstatus(var0, var1, var2) {
  level endon("game_ended");

  while(isDefined(self.javelin.target) && self.javelin.state != "off") {
    waitframe();
  }

  if(isDefined(var1)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var1);
  }

  self.javelinlocationtargeted = undefined;
}

function vehicle_damage_deregistervisualpercentcallback() {
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