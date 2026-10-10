/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\javelin.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\javelin;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace javelin;

function javelinusageloop() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  javelin_init();
  thread function_2f8e1a565d6bf787();

  while(true) {
    weapon = self getcurrentweapon();

    if(issubstr(weapon.basename, "la_juliet_mp") && javelin_shouldjavelinthink()) {
      self.javelin.stopthinking = 0;
      thread javelin_think();
    } else {
      self.javelin.stopthinking = 1;
    }

    self waittill("weapon_change");
  }
}

function function_2f8e1a565d6bf787() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self waittill("end_launcher");
  javelin_forceclear();
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

function function_22c8f0d0e0492f51() {
  self endon("disconnect");
  waittill_any_3("death", "end_launcher", "faux_spawn");
  javelin_hidenormalhud(0);
  javelin_setuistate(0);
}

function function_f8db769be3a46d46() {
  self endon("weapon_change");
  self waittill("death_or_disconnect");

  if(isDefined(self.javelin)) {
    if(isDefined(self.javelin.target)) {
      removelockedon(self.javelin.target, self);
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

    if(getDvar(@ "missiledebugdraw") == "<dev string:x4a>" && isDefined(self.javelin.groundpoints)) {
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
    self.javelin.target.firsthitent = spawn_tag_origin(traceresults[2]);
    self.javelin.target.firsthitent scripts\cp_mp\ent_manager::registerspawncount(1);
    self.javelin.groundlockmisses = 0;
    self.javelin.groundpoints = undefined;
    self.javelin.groundnormals = undefined;

    if(!isDefined(self.javelinlocationtargeted)) {
      marklocation(self.javelin.target.firsthitent);
    }

    javelin_queuestate("hold");
  }
}

function javelin_holdstateenter(fromstate) {
  if(!isDefined(self.javelin.target)) {
    return;
  }

  javelin_setuistate(2);
  self.javelin.lockstarttime = gettime();
  self.javelin.lostsightlinetime = 0;

  if(isent(self.javelin.target)) {
    self weaponlockstart(self.javelin.target);
  } else {
    self weaponlockstart(self.javelin.target.origin);
  }

  thread javelin_looplocalseeksound("javelin_clu_acquiring_lock", 0.5);
}

function javelin_holdstateupdate() {
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(getDvar(@ "missiledebugdraw") == "<dev string:x4a>") {
    function_2230e7ba8b6c416f(self.javelin.target.origin, (0.5, 1, 0.6));
  }

  if(!isDefined(self.javelin.target)) {
    javelin_queuestate("scanning");
    return;
  }

  losthold = 0;

  if(!var_e688b198aa9a4b3f && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.javelin.target, self)) {
    if(!isDefined(self.javelin.target.sentientpool)) {
      javelin_queuestate("scanning");
      losthold = 1;
    }
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

  isentity = isent(self.javelin.target);

  if(isentity && isPlayer(self.javelin.target)) {
    self weaponlockfinalize(self.javelin.target, (0, 0, 64), 0);
  } else if(isDefined(self.javelin.groundlockonent)) {
    self weaponlockfinalize(self.javelin.target, (0, 0, 0), 1);
  } else if(!isentity) {
    self weaponlockfinalize(self.javelin.target.origin, (0, 0, 0), 1);
  } else {
    vehicleoffset = javelin_getvehicleoffset(self.javelin.target);
    self weaponlockfinalize(self.javelin.target, vehicleoffset, 0);
  }

  thread javelin_looplocalseeksound("javelin_clu_lock", 1.6);
}

function javelin_firestateupdate() {
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(!isDefined(self.javelin.target)) {
    javelin_queuestate("scanning");
    return;
  }

  if(!var_e688b198aa9a4b3f && self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self.javelin.target, self)) {
    if(!isDefined(self.javelin.target.sentientpool)) {
      javelin_queuestate("scanning");
    }
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

  var_a9fc24033722aa10 = targetent;

  if(isDefined(targetent.firsthitent)) {
    var_a9fc24033722aa10 = targetent.firsthitent;
  }

  insidereticle = self worldpointinreticle_rect(var_a9fc24033722aa10.origin, 35, 120, 80);

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
  gunangles = self getgunangles();
  gunforward = anglesToForward(gunangles);
  endpoint = origin + gunforward * 15000;
  firsthit = scripts\engine\trace::ray_trace(origin, endpoint, undefined, undefined, 1);

  if(!isDefined(firsthit) || firsthit["surfacetype"] == "surftype_none" && firsthit["hittype"] == "hittype_none" || firsthit["surfacetype"] == "default") {
    return undefined;
  }

  var_7f74be76ba001a7a = firsthit;
  var_6b27ab83a5049b73 = function_ceeb605cf6974148(firsthit, gunforward);

  if(isDefined(var_6b27ab83a5049b73)) {
    var_7f74be76ba001a7a = var_6b27ab83a5049b73;
  }

  if(getDvar(@ "missiledebugdraw") == "<dev string:x4a>") {
    thread scripts\engine\trace::draw_trace(firsthit, (1, 1, 0), 0, 1000);
    thread scripts\mp\utility\debug::drawsphere(var_7f74be76ba001a7a["<dev string:x4f>"], 5, 20, (1, 0, 1));
    iprintlnbold(distance(origin, var_7f74be76ba001a7a["<dev string:x4f>"]));
  }

  results = [];
  results[0] = var_7f74be76ba001a7a["position"];
  results[1] = var_7f74be76ba001a7a["normal"];
  results[2] = firsthit["position"];
  return results;
}

function function_ceeb605cf6974148(firsthit, gunforward) {
  var_94168349c721c815 = 5000;
  var_31ae59f63933229 = getdvarint(@ "hash_a0cf49119410b52", 100);
  var_10c80cb240f98c74 = getdvarint(@ "hash_f14add14ff4c308b", 100);

  if(abs(firsthit["normal"][2]) > 0.1) {
    return undefined;
  }

  firsthitpos = firsthit["position"];
  testpoint = firsthitpos + gunforward * var_10c80cb240f98c74;
  var_a09791f8b1dafd16 = scripts\engine\trace::ray_trace_get_all_results(testpoint + (0, 0, 100000), testpoint - (0, 0, var_94168349c721c815), undefined, undefined, 1);
  var_c8bf52a3fd4aec68 = undefined;

  for(i = 0; i < var_a09791f8b1dafd16.size - 1; i++) {
    hit = var_a09791f8b1dafd16[i];

    if(hit["surfacetype"] == "surftype_none") {
      continue;
    }

    var_c8bf52a3fd4aec68 = hit;
    break;
  }

  if(!isDefined(var_c8bf52a3fd4aec68)) {
    return undefined;
  }

  var_f435d883a28d8bc2 = var_c8bf52a3fd4aec68["position"];
  var_8242d42fa4c4d38e = var_f435d883a28d8bc2[2] - firsthitpos[2];

  if(isDefined(var_c8bf52a3fd4aec68) && var_8242d42fa4c4d38e < var_31ae59f63933229 && pointinbounds(var_c8bf52a3fd4aec68["position"])) {
    return var_c8bf52a3fd4aec68;
  }
}

function pointinbounds(point) {
  if(!isDefined(level.outofboundstriggers)) {
    return true;
  }

  foreach(trigger in level.outofboundstriggers) {
    if(ispointinvolume(point + (0, 0, 20), trigger)) {
      return false;
    }
  }

  return true;
}

function javelin_targetpointtooclose(targetpoint) {
  dist = distance(self.origin, targetpoint);

  if(dist < 850) {
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
  assertex(isDefined(level.javelin.states[statename]), "<dev string:x5b>" + statename + "<dev string:x91>");

  function_26c6f6de312b721f("<dev string:x98>" + statename + "<dev string:xb4>");

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
  thread function_22c8f0d0e0492f51();
  thread function_f8db769be3a46d46();
  var_263bba08eb70be2d = 0;

  while(true) {
    if(isDefined(self.javelin.stopthinking) && self.javelin.stopthinking) {
      javelin_enterstate("off");
      return;
    }

    blockthink = !javelin_shouldjavelinthink();

    if(blockthink) {
      if(!var_263bba08eb70be2d) {
        var_263bba08eb70be2d = 1;
        javelin_enterstate("off");
      }
    } else {
      var_263bba08eb70be2d = 0;
      javelin_preupdate();
      queuedstate = javelin_getqueuedstate();

      if(isDefined(queuedstate)) {
        javelin_enterstate(queuedstate);
      }

      self[[level.javelin.states[self.javelin.state]["update"]]]();
    }

    wait 0.05;
  }
}

function javelin_scanforvehicletarget() {
  targets = scripts\mp\weapons::lockonlaunchers_gettargetarray();
  var_db87e220986304f4 = getdvarint(@ "hash_eb7d16d9fa10a208", 625000000);

  if(targets.size != 0) {
    var_8110370edb23215a = [];

    foreach(target in targets) {
      if(!isDefined(target)) {
        continue;
      }

      insidereticle = self worldpointinreticle_rect(target.origin, 35, 120, 80);

      if(insidereticle && distancesquared(target.origin, self.origin) <= var_db87e220986304f4) {
        var_8110370edb23215a[var_8110370edb23215a.size] = target;
      }
    }

    if(var_8110370edb23215a.size != 0) {
      sortedtargets = sortbydistance(var_8110370edb23215a, self.origin);

      foreach(target in sortedtargets) {
        if(javelin_vehiclelocksighttest(target)) {
          return target;
        }
      }
    }
  }

  return undefined;
}

function javelin_vehiclelocksighttest(target) {
  eyepos = self getEye();

  if(!isent(target)) {
    contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_playernosight"]);
    ignorearr = [self];
    castresults = physics_raycast(eyepos, target.origin, contents, ignorearr, 0, "physicsquery_closest", 1);

    if(!isDefined(castresults) || castresults.size == 0) {
      return true;
    }

    return false;
  }

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
  } else if(isassaultdrone(vehicletarget)) {
    offset = (0, 0, 10);
  } else if(isscramblerdrone(vehicletarget)) {
    offset = (0, 0, 10);
  } else if(isradarhelicopter(vehicletarget)) {
    offset = (0, 0, -30);
  } else if(isDefined(vehicletarget.vehiclename) && vehicletarget.vehiclename == "loot_chopper") {
    offset = (0, 0, -100);
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
  if(!isDefined(self)) {
    return;
  }

  if(enable) {
    self setclientomnvar("ui_javelin_view", 1);

    if(getDvar(@ "missiledebugtext") == "<dev string:x4a>") {
      self setclientomnvar("<dev string:xba>", 0);
    }

    return;
  }

  self setclientomnvar("ui_javelin_view", 0);
}

function javelin_setuistate(state) {
  self setclientomnvar("ui_javelin_state", state);

  if(getDvar(@ "missiledebugtext") == "<dev string:x4a>") {
    if(state == 0) {
      iprintlnbold("<dev string:xcd>");
      return;
    }

    if(state == 1) {
      iprintlnbold("<dev string:xdf>");
      return;
    }

    if(state == 2) {
      iprintlnbold("<dev string:xf6>");
      return;
    }

    if(state == 3) {
      iprintlnbold("<dev string:x109>");
      return;
    }

    if(state == 4) {
      iprintlnbold("<dev string:x11c>");
    }
  }

}

function marklocation(markpos) {
  if(!isDefined(markpos.owner)) {
    markpos.owner = self;
  }

  if(markpos.model == "tag_origin") {
    markpos show();
  }

  var_f27c7690b259ec3a = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("javelincrosshair", self, markpos, self);
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
  if(getDvar(@ "missiledebugtext") == "<dev string:x4a>") {
    iprintln(text);
  }
}

function function_2230e7ba8b6c416f(point, color) {
  line(point + (10, 0, 0), point - (10, 0, 0), color);
  line(point + (0, 10, 0), point - (0, 10, 0), color);
  line(point + (0, 0, 10), point - (0, 0, 10), color);
}

function function_9c1d49cefcf64a9b(start, end, passed) {
  if(getDvar(@ "missiledebugdraw") != "<dev string:x4a>") {
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

function javelin_forceclear() {
  scripts\mp\javelin::javelin_hidenormalhud(0);
  scripts\mp\javelin::javelin_setuistate(0);

  if(isDefined(self.javelin)) {
    if(isDefined(self.javelin.target)) {
      removelockedon(self.javelin.target, self);
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