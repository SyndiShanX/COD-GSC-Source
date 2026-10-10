/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\equipment\cp_javelin.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\cp\utility\entity;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_javelin;

function javelinusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  javelin_init();

  while(true) {
    weapon = self getcurrentweapon();

    if(weapon.basename == "iw9_la_juliet_mp" && javelin_shouldjavelinthink()) {
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

function javelin_offstateenter(fromstate) {
  if(isDefined(self.javelin.target)) {
    removelockedon(self.javelin.target, self);
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

function javelin_scanningstateenter(fromstate) {
  javelin_setuistate(1);
  self.javelin.adsraisedelaytimer = gettime() + 100;
}

function javelin_scanningstateupdate() {
  if(gettime() < self.javelin.adsraisedelaytimer) {
    return;
  }

  vehicletarget = javelin_scanforvehicletarget();

  if(isDefined(vehicletarget)) {
    if(javelin_targetpointtooclose(vehicletarget.origin)) {
      javelin_queuestate("too_close");
      return;
    }

    function_26c6f6de312b721f("<dev string:x1c>");

    if(isDefined(self.javelin.target) && self.javelin.target == vehicletarget) {
      q = 1;
    }

    self.javelin.target = vehicletarget;

    if(isDefined(self.javelin.target)) {
      addlockedon(self.javelin.target, self);
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

    if(getDvar(@ "missiledebugdraw") == "<dev string:x47>" && isDefined(self.javelin.groundpoints)) {
      foreach(var_8ed3cf11185e5d34 in self.javelin.groundpoints) {
        function_2230e7ba8b6c416f(var_8ed3cf11185e5d34, (0.8, 1, 0.8));
      }

      function_2230e7ba8b6c416f(self.javelin.groundpoints[self.javelin.groundpoints.size - 1], (1, 1, 0.2));
      function_2230e7ba8b6c416f(averagepoint(self.javelin.groundpoints), (0.2, 0.2, 1));
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
      var_82d5206f31aafac2 = averagepoint(self.javelin.groundpoints);
      dist = distance(var_82d5206f31aafac2, traceresults[0]);

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

    targetpoint = averagepoint(self.javelin.groundpoints);
    self.javelin.groundlockonent = spawn_tag_origin(targetpoint);
    self.javelin.groundlockonent scripts\cp_mp\ent_manager::registerspawncount(1);
    self.javelin.target = self.javelin.groundlockonent;
    self.javelin.groundlockmisses = 0;
    self.javelin.groundpoints = undefined;
    self.javelin.groundnormals = undefined;

    if(!isDefined(self.javelinlocationtargeted)) {
      marklocation(self.javelin.target);
    }

    javelin_queuestate("hold");
  }
}

function javelin_holdstateenter(fromstate) {
  javelin_setuistate(2);
  self.javelin.lockstarttime = gettime();
  self.javelin.lostsightlinetime = 0;
  self weaponlockstart(self.javelin.target);
  thread javelin_looplocalseeksound("javelin_clu_acquiring_lock", 0.5);
}

function javelin_holdstateupdate() {
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(getDvar(@ "missiledebugdraw") == "<dev string:x47>") {
    function_2230e7ba8b6c416f(self.javelin.target.origin, (0.5, 1, 0.6));
  }

  losthold = 0;

  if(!var_e688b198aa9a4b3f && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.javelin.target, self)) {
    javelin_queuestate("scanning");
    losthold = 1;
  }

  if(!javelin_checktargetstillheld(self.javelin.target)) {
    javelin_queuestate("scanning");
    losthold = 1;
  }

  if(javelin_targetpointtooclose(self.javelin.target.origin)) {
    javelin_queuestate("too_close");
    losthold = 1;
  }

  if(losthold) {
    if(isDefined(self.javelin.target)) {
      removelockedon(self.javelin.target, self);
    }

    self weaponlockfree();
    self.javelin.target = undefined;

    if(isDefined(self.javelin.groundlockonent)) {
      self.javelin.groundlockonent delete();
    }
  }

  timepassed = gettime() - self.javelin.lockstarttime;

  if(timepassed < 1150) {
    return;
  }

  javelin_queuestate("fire");
}

function javelin_holdstateexit() {
  self notify("stop_lockon_sound");
  self stoplocalsound("javelin_clu_acquiring_lock");
}

function javelin_firestateenter(fromstate) {
  javelin_setuistate(3);

  if(!isDefined(self.javelin.target)) {
    return;
  }

  if(isPlayer(self.javelin.target)) {
    self weaponlockfinalize(self.javelin.target, (0, 0, 64), 0);
  } else if(isDefined(self.javelin.groundlockonent)) {
    self weaponlockfinalize(self.javelin.target, (0, 0, 0), 1);
  } else {
    vehicleoffset = javelin_getvehicleoffset(self.javelin.target);
    self weaponlockfinalize(self.javelin.target, vehicleoffset, 0);
  }

  thread javelin_looplocalseeksound("javelin_clu_lock", 1.6);
}

function javelin_firestateupdate() {
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(!var_e688b198aa9a4b3f && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.javelin.target, self)) {
    javelin_queuestate("scanning");
  }

  if(!javelin_checktargetstillheld(self.javelin.target)) {
    javelin_queuestate("scanning");
  }

  if(javelin_targetpointtooclose(self.javelin.target.origin)) {
    javelin_queuestate("too_close");
  }
}

function javelin_firestateexit() {
  if(isDefined(self.javelin.target)) {
    removelockedon(self.javelin.target, self);
  }

  self weaponlockfree();
  self.javelin.target = undefined;

  if(isDefined(self.javelin.groundlockonent)) {
    self.javelin.groundlockonent delete();
  }

  self notify("stop_lockon_sound");
  self stoplocalsound("javelin_clu_lock");
}

function javelin_tooclosestateenter(fromstate) {
  javelin_setuistate(4);
}

function javelin_tooclosestateupdate() {
  vehicletarget = javelin_scanforvehicletarget();

  if(isDefined(vehicletarget)) {
    if(!javelin_targetpointtooclose(vehicletarget.origin)) {
      javelin_queuestate("scanning");
      return;
    }

    return;
  }

  traceresults = javelin_eyetraceforward();

  if(!isDefined(traceresults) || isDefined(traceresults) && javelin_targetpointtooclose(traceresults[0]) == 0) {
    javelin_queuestate("scanning");
    return;
  }
}

function javelin_preupdate() {
  if(isDefined(self.javelin.state) && self.javelin.state != "off") {
    if(self playerads() < 0.9) {
      javelin_queuestate("off");
    }
  }
}

function javelin_checktargetstillheld(targetent) {
  if(!isDefined(targetent)) {
    return false;
  }

  insidereticle = self worldpointinreticle_rect(targetent.origin, 35, 120, 80);

  if(!insidereticle) {
    return false;
  }

  if(!isDefined(self.javelin.groundlockonent) && !javelin_softsighttest(targetent)) {
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
  origin = self getEye();
  angles = self getplayerangles();
  forward = anglesToForward(angles);
  endpoint = origin + forward * 15000;
  res = scripts\engine\trace::_bullet_trace(origin, endpoint, 0, undefined);

  if(getDvar(@ "missiledebugdraw") == "<dev string:x47>") {}

  if(res["surfacetype"] == "surftype_none" && res["hittype"] == "hittype_none") {
    return undefined;
  }

  if(res["surfacetype"] == "default") {
    return undefined;
  }

  ent = res["entity"];
  results = [];
  results[0] = res["position"];
  results[1] = res["normal"];
  return results;
}

function javelin_targetpointtooclose(targetpoint) {
  var_71e6d19172e88145 = 1100;

  if(!isDefined(targetpoint)) {
    return false;
  }

  dist = distance(self.origin, targetpoint);

  if(dist < var_71e6d19172e88145) {
    return true;
  }

  return false;
}

function javelin_looplocalseeksound(alias, interval) {
  self endon("death_or_disconnect");
  self endon("stop_lockon_sound");

  for(;;) {
    self playlocalsound(alias);
    wait interval;
  }
}

function javelin_queuestate(statename) {
  self.javelin.queuedstate = statename;
}

function javelin_getqueuedstate() {
  return self.javelin.queuedstate;
}

function javelin_enterstate(statename) {
  assertex(isDefined(level.javelin.states[statename]), "javelin_setState called with uninitialized state '" + statename + "' !");

  function_26c6f6de312b721f("<dev string:x49>" + statename + "<dev string:x62>");

  fromstate = self.javelin.state;

  if(isDefined(fromstate) && isDefined(level.javelin.states[fromstate]["exit"])) {
    self[[level.javelin.states[fromstate]["exit"]]]();
  }

  self.javelin.state = statename;

  if(isDefined(level.javelin.states[statename]["enter"])) {
    self[[level.javelin.states[statename]["enter"]]](fromstate);
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

  while(true) {
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

    if(isDefined(queuedstate)) {
      javelin_enterstate(queuedstate);
    }

    self[[level.javelin.states[self.javelin.state]["update"]]]();
    wait 0.05;
  }
}

function javelin_scanforvehicletarget() {
  targets = scripts\cp\weapon::lockonlaunchers_gettargetarray();

  foreach(target in targets) {
    if(!isent(target)) {
      targets = array_remove(targets, target);
    }
  }

  if(targets.size != 0) {
    var_8110370edb23215a = [];

    foreach(target in targets) {
      insidereticle = self worldpointinreticle_rect(target.origin, 35, 120, 80);

      if(insidereticle) {
        var_8110370edb23215a[var_8110370edb23215a.size] = target;
      }
    }

    if(var_8110370edb23215a.size != 0) {
      sortedtargets = sortbydistance(var_8110370edb23215a, self.origin);

      if(javelin_vehiclelocksighttest(sortedtargets[0])) {
        return sortedtargets[0];
      }
    }
  }

  return undefined;
}

function javelin_vehiclelocksighttest(target) {
  eyepos = self getEye();
  center = target getpointinbounds(0, 0, 1);
  passed = sighttracepassed(eyepos, center, 0, target);

  function_9c1d49cefcf64a9b(eyepos, center, passed);

  if(passed) {
    return true;
  }

  front = target getpointinbounds(1, 0, 0);
  passed = sighttracepassed(eyepos, front, 0, target);

  function_9c1d49cefcf64a9b(eyepos, front, passed);

  if(passed) {
    return true;
  }

  back = target getpointinbounds(-1, 0, 0);
  passed = sighttracepassed(eyepos, back, 0, target);

  function_9c1d49cefcf64a9b(eyepos, back, passed);

  if(passed) {
    return true;
  }

  return false;
}

function javelin_getvehicleoffset(vehicletarget) {
  offset = (0, 0, 0);

  if(!isDefined(vehicletarget)) {
    return offset;
  }

  if(ischoppergunner(vehicletarget)) {
    offset = (0, 0, -50);
  } else if(issupporthelo(vehicletarget)) {
    offset = (0, 0, -100);
  } else if(isgunship(vehicletarget)) {
    offset = (0, 0, 50);
  } else if(isclusterstrike(vehicletarget)) {
    offset = (0, 0, 40);
  } else if(isradardrone(vehicletarget)) {
    offset = (0, 0, 10);
  } else if(isscramblerdrone(vehicletarget)) {
    offset = (0, 0, 10);
  } else if(isradarhelicopter(vehicletarget)) {
    offset = (0, 0, -30);
  }

  return offset;
}

function javelin_softsighttest(targetent) {
  if(javelin_vehiclelocksighttest(targetent)) {
    self.javelin.lostsightlinetime = 0;
    return true;
  }

  if(self.javelin.lostsightlinetime == 0) {
    self.javelin.lostsightlinetime = gettime();
  }

  timepassed = gettime() - self.javelin.lostsightlinetime;

  if(timepassed >= 500) {
    return false;
  }

  return true;
}

function javelin_hidenormalhud(enable) {
  if(enable) {
    self setclientomnvar("ui_javelin_view", 1);

    if(getDvar(@ "missiledebugtext") == "<dev string:x47>") {
      self setclientomnvar("<dev string:x65>", 0);
    }

    return;
  }

  self setclientomnvar("ui_javelin_view", 0);
}

function javelin_setuistate(state) {
  self setclientomnvar("ui_javelin_state", state);

  if(getDvar(@ "missiledebugtext") == "<dev string:x47>") {
    if(state == 0) {
      iprintlnbold("<dev string:x75>");
      return;
    }

    if(state == 1) {
      iprintlnbold("<dev string:x84>");
      return;
    }

    if(state == 2) {
      iprintlnbold("<dev string:x98>");
      return;
    }

    if(state == 3) {
      iprintlnbold("<dev string:xa8>");
      return;
    }

    if(state == 4) {
      iprintlnbold("<dev string:xb8>");
    }
  }

}

function marklocation(markpos) {
  var_f27c7690b259ec3a = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("javelincrosshair", self, markpos, self);

  if(markpos.model == "tag_origin") {
    markpos show();
  }

  self.javelinlocationtargeted = 1;
  thread watchtargetmarkerentstatus(markpos, var_f27c7690b259ec3a, 1);
}

function watchtargetmarkerentstatus(var_d99ed5531d1fdc1f, targetmarkergroup, istag) {
  level endon("game_ended");

  while(isDefined(self.javelin.target) && self.javelin.state != "off") {
    waitframe();
  }

  if(isDefined(targetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(targetmarkergroup);
  }

  self.javelinlocationtargeted = undefined;
}

function function_26c6f6de312b721f(text) {
  if(getDvar(@ "missiledebugtext") == "<dev string:x47>") {
    iprintln(text);
  }
}

function function_2230e7ba8b6c416f(point, color) {
  line(point + (10, 0, 0), point - (10, 0, 0), color);
  line(point + (0, 10, 0), point - (0, 10, 0), color);
  line(point + (0, 0, 10), point - (0, 0, 10), color);
}

function function_9c1d49cefcf64a9b(start, end, passed) {
  if(getDvar(@ "missiledebugdraw") != "<dev string:x47>") {
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