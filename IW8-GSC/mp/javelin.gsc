/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\javelin.gsc
***********************************************/

javelinusageloop() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  javelin_init();

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename == "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920" && javelin_shouldjavelinthink()) {
      self.javelin.stopthinking = 0;
      thread javelin_think();
    } else
      self.javelin.stopthinking = 1;

    scripts\engine\utility::_id_143A5("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_99C40CA749E1F16B80389FEB2BB9");
  }
}

javelin_init() {
  self.javelin = spawnStruct();

  if(!isDefined(level.javelin)) {
    level.javelin = spawnStruct();
    level.javelin.states = [];
    level.javelin.states["_encstr_BA19049F4B2D"] = [];
    level.javelin.states["_encstr_BA19049F4B2D"]["_encstr_99BF0603D0C4979A"] = ::javelin_offstateenter;
    level.javelin.states["_encstr_BA19049F4B2D"]["_encstr_BD3107D507320BA356"] = ::javelin_offstateupdate;
    level.javelin.states["_encstr_BA19049F4B2D"]["_encstr_A760055987D2E8"] = ::javelin_offstateexit;
    level.javelin.states["_encstr_AF74091BB6D9354A87BA2F"] = [];
    level.javelin.states["_encstr_AF74091BB6D9354A87BA2F"]["_encstr_99BF0603D0C4979A"] = ::javelin_scanningstateenter;
    level.javelin.states["_encstr_AF74091BB6D9354A87BA2F"]["_encstr_BD3107D507320BA356"] = ::javelin_scanningstateupdate;
    level.javelin.states["_encstr_B6CC0586B78D46"] = [];
    level.javelin.states["_encstr_B6CC0586B78D46"]["_encstr_99BF0603D0C4979A"] = ::javelin_holdstateenter;
    level.javelin.states["_encstr_B6CC0586B78D46"]["_encstr_BD3107D507320BA356"] = ::javelin_holdstateupdate;
    level.javelin.states["_encstr_B6CC0586B78D46"]["_encstr_A760055987D2E8"] = ::javelin_holdstateexit;
    level.javelin.states["_encstr_88780599B4E495"] = [];
    level.javelin.states["_encstr_88780599B4E495"]["_encstr_99BF0603D0C4979A"] = ::javelin_firestateenter;
    level.javelin.states["_encstr_88780599B4E495"]["_encstr_BD3107D507320BA356"] = ::javelin_firestateupdate;
    level.javelin.states["_encstr_88780599B4E495"]["_encstr_A760055987D2E8"] = ::javelin_firestateexit;
    level.javelin.states["_encstr_91A60A39BF153176734ADB01"] = [];
    level.javelin.states["_encstr_91A60A39BF153176734ADB01"]["_encstr_99BF0603D0C4979A"] = ::javelin_tooclosestateenter;
    level.javelin.states["_encstr_91A60A39BF153176734ADB01"]["_encstr_BD3107D507320BA356"] = ::javelin_tooclosestateupdate;
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

javelin_offstateenter(var_0) {
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
    javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");
}

javelin_offstateexit() {
  javelin_hidenormalhud(1);
}

javelin_deathwatcher() {
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

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
  }
}

javelin_scanningstateenter(var_0) {
  javelin_setuistate(1);
  self.javelin.adsraisedelaytimer = gettime() + 100;
}

javelin_scanningstateupdate() {
  if(gettime() < self.javelin.adsraisedelaytimer) {
    return;
  }
  var_0 = javelin_scanforvehicletarget();

  if(isDefined(var_0)) {
    if(javelin_targetpointtooclose(var_0.origin)) {
      javelin_queuestate("_encstr_91A60A39BF153176734ADB01");
      return;
    }

    if(isDefined(self.javelin.target) && self.javelin.target == var_0)
      var_1 = 1;

    self.javelin.target = var_0;

    if(isDefined(self.javelin.target))
      scripts\cp_mp\utility\weapon_utility::addlockedon(self.javelin.target, self);

    if(!isDefined(self.javelinlocationtargeted))
      marklocation(self.javelin.target);

    javelin_queuestate("_encstr_B6CC0586B78D46");
  } else if(self attackButtonPressed()) {
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
      javelin_queuestate("_encstr_91A60A39BF153176734ADB01");
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

    if(!isDefined(self.javelinlocationtargeted))
      marklocation(self.javelin.target);

    javelin_queuestate("_encstr_B6CC0586B78D46");
  }
}

javelin_holdstateenter(var_0) {
  if(!isDefined(self.javelin.target)) {
    return;
  }
  javelin_setuistate(2);
  self.javelin.lockstarttime = gettime();
  self.javelin.lostsightlinetime = 0;
  self weaponlockstart(self.javelin.target);
  thread javelin_looplocalseeksound("_encstr_AC661B380AB3A32DF37D195AC9371F865ECAD8AF4390852CCF4AAF68D7", 0.5);
}

javelin_holdstateupdate() {
  var_0 = 0;

  if(!isDefined(self.javelin.target)) {
    javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");
    return;
  }

  var_1 = 0;

  if(!var_0 && (self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::_id_141B9(self.javelin.target, self))) {
    javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");
    var_1 = 1;
  }

  if(!javelin_checktargetstillheld(self.javelin.target)) {
    javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");
    var_1 = 1;
  }

  if(javelin_targetpointtooclose(self.javelin.target.origin)) {
    javelin_queuestate("_encstr_91A60A39BF153176734ADB01");
    var_1 = 1;
  }

  if(var_1) {
    if(isDefined(self.javelin.target))
      scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);

    self weaponlockfree();
    self.javelin.target = undefined;

    if(isDefined(self.javelin.groundlockonent))
      self.javelin.groundlockonent delete();
  }

  var_2 = gettime() - self.javelin.lockstarttime;

  if(var_2 < 1150) {
    return;
  }
  javelin_queuestate("_encstr_88780599B4E495");
}

javelin_holdstateexit() {
  self notify("_encstr_A36612ABED38131911B88A02D07D414790D50E34");
  self stoplocalsound("_encstr_AC661B380AB3A32DF37D195AC9371F865ECAD8AF4390852CCF4AAF68D7");
}

javelin_firestateenter(var_0) {
  javelin_setuistate(3);

  if(!isDefined(self.javelin.target)) {
    return;
  }
  if(isPlayer(self.javelin.target))
    self weaponlockfinalize(self.javelin.target, (0, 0, 64), 0);
  else if(isDefined(self.javelin.groundlockonent))
    self weaponlockfinalize(self.javelin.target, (0, 0, 0), 1);
  else {
    var_1 = javelin_getvehicleoffset(self.javelin.target);
    self weaponlockfinalize(self.javelin.target, var_1, 0);
  }

  thread javelin_looplocalseeksound("_encstr_8D1B114D85D95936B4B9BE1BD85DEB367B6CB5", 1.6);
}

javelin_firestateupdate() {
  var_0 = 0;

  if(!isDefined(self.javelin.target)) {
    javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");
    return;
  }

  if(!var_0 && (self.javelin.target scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::_id_141B9(self.javelin.target, self)))
    javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");

  if(!javelin_checktargetstillheld(self.javelin.target))
    javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");

  if(javelin_targetpointtooclose(self.javelin.target.origin))
    javelin_queuestate("_encstr_91A60A39BF153176734ADB01");
}

javelin_firestateexit() {
  if(isDefined(self.javelin.target))
    scripts\cp_mp\utility\weapon_utility::removelockedon(self.javelin.target, self);

  self weaponlockfree();
  self.javelin.target = undefined;

  if(isDefined(self.javelin.groundlockonent))
    self.javelin.groundlockonent delete();

  self notify("_encstr_A36612ABED38131911B88A02D07D414790D50E34");
  self stoplocalsound("_encstr_8D1B114D85D95936B4B9BE1BD85DEB367B6CB5");
}

javelin_tooclosestateenter(var_0) {
  javelin_setuistate(4);
}

javelin_tooclosestateupdate() {
  var_0 = javelin_scanforvehicletarget();

  if(isDefined(var_0)) {
    if(!javelin_targetpointtooclose(var_0.origin)) {
      javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");
      return;
    }
  } else {
    var_1 = javelin_eyetraceforward();

    if(!isDefined(var_1) || isDefined(var_1) && javelin_targetpointtooclose(var_1[0]) == 0) {
      javelin_queuestate("_encstr_AF74091BB6D9354A87BA2F");
      return;
    }
  }
}

javelin_preupdate() {
  if(isDefined(self.javelin.state) && self.javelin.state != "_encstr_BA19049F4B2D") {
    if(self playerads() < 0.9)
      javelin_queuestate("_encstr_BA19049F4B2D");
  }
}

javelin_checktargetstillheld(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = self worldpointinreticle_rect(var_0.origin, 35, 120, 80);

  if(!var_1)
    return 0;

  if(!isDefined(self.javelin.groundlockonent) && !javelin_softsighttest(var_0))
    return 0;

  if(isDefined(self.javelin.groundlockonent)) {
    if(!self attackButtonPressed())
      return 0;
  }

  return 1;
}

javelin_eyetraceforward() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 15000;
  var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 0, undefined);

  if(var_4["_encstr_8BCA0C2BFD504F333E6D7513637B"] == "_encstr_9B0C0EE65DE4991DE53856AFB97BE6B2" && var_4["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A")
    return undefined;

  if(var_4["_encstr_8BCA0C2BFD504F333E6D7513637B"] == "_encstr_8B1608EC43B8D647A113")
    return undefined;

  var_5 = var_4["_encstr_850E077B0BF30318B9"];
  var_6 = [];
  var_6[0] = var_4["_encstr_BD260953AA97E3F014279D"];
  var_6[1] = var_4["_encstr_820E07FAE8780B3A4C"];
  return var_6;
}

javelin_targetpointtooclose(var_0) {
  var_1 = 1100;
  var_2 = distance(self.origin, var_0);

  if(var_2 < var_1)
    return 1;

  return 0;
}

javelin_looplocalseeksound(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A36612ABED38131911B88A02D07D414790D50E34");

  for(;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}

javelin_queuestate(var_0) {
  self.javelin.queuedstate = var_0;
}

javelin_getqueuedstate() {
  return self.javelin.queuedstate;
}

javelin_enterstate(var_0) {
  var_1 = self.javelin.state;

  if(isDefined(var_1) && isDefined(level.javelin.states[var_1]["_encstr_A760055987D2E8"]))
    self[[level.javelin.states[var_1]["_encstr_A760055987D2E8"]]]();

  self.javelin.state = var_0;

  if(isDefined(level.javelin.states[var_0]["_encstr_99BF0603D0C4979A"]))
    self[[level.javelin.states[var_0]["_encstr_99BF0603D0C4979A"]]](var_1);

  self.javelin.queuedstate = undefined;
}

javelin_shouldjavelinthink() {
  return !scripts\cp_mp\emp_debuff::is_empd();
}

javelin_think() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self notify("_encstr_8F970ED4FFBD0234701017A338A8FE2A");
  self endon("_encstr_8F970ED4FFBD0234701017A338A8FE2A");
  javelin_reset();
  javelin_enterstate("_encstr_BA19049F4B2D");
  thread javelin_deathwatcher();

  for(;;) {
    if(isDefined(self.javelin.stopthinking) && self.javelin.stopthinking) {
      javelin_enterstate("_encstr_BA19049F4B2D");
      return;
    }

    if(!javelin_shouldjavelinthink()) {
      javelin_enterstate("_encstr_BA19049F4B2D");
      return;
    }

    javelin_preupdate();
    var_0 = javelin_getqueuedstate();

    if(isDefined(var_0))
      javelin_enterstate(var_0);

    self[[level.javelin.states[self.javelin.state]["_encstr_BD3107D507320BA356"]]]();
    wait 0.05;
  }
}

javelin_scanforvehicletarget() {
  var_0 = scripts\mp\weapons::lockonlaunchers_gettargetarray();
  var_1 = getdvarint("_encstr_82E71AB936C9F55B8587ADA59B9BB4C6CA8D7B8D6DDBB9932CCD9D95", 625000000);

  if(var_0.size != 0) {
    var_2 = [];

    foreach(var_4 in var_0) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = self worldpointinreticle_rect(var_4.origin, 35, 120, 80);

      if(var_5 && distancesquared(var_4.origin, self.origin) <= var_1)
        var_2[var_2.size] = var_4;
    }

    if(var_2.size != 0) {
      var_7 = sortbydistance(var_2, self.origin);

      if(javelin_vehiclelocksighttest(var_7[0]))
        return var_7[0];
    }
  }

  return undefined;
}

javelin_vehiclelocksighttest(var_0) {
  var_1 = self getEye();
  var_2 = var_0 getpointinbounds(0, 0, 1);
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

javelin_getvehicleoffset(var_0) {
  var_1 = (0, 0, 0);

  if(!isDefined(var_0))
    return var_1;

  if(scripts\mp\utility\entity::ischoppergunner(var_0))
    var_1 = (0, 0, -50);
  else if(scripts\mp\utility\entity::issupporthelo(var_0))
    var_1 = (0, 0, -100);
  else if(scripts\mp\utility\entity::isgunship(var_0))
    var_1 = (0, 0, 50);
  else if(scripts\mp\utility\entity::isclusterstrike(var_0))
    var_1 = (0, 0, 40);
  else if(scripts\mp\utility\entity::isradardrone(var_0))
    var_1 = (0, 0, 10);
  else if(scripts\mp\utility\entity::turret_op(var_0))
    var_1 = (0, 0, 10);
  else if(scripts\mp\utility\entity::isscramblerdrone(var_0))
    var_1 = (0, 0, 10);
  else if(scripts\mp\utility\entity::isradarhelicopter(var_0))
    var_1 = (0, 0, -30);
  else if(isDefined(var_0.vehiclename) && var_0.vehiclename == "_encstr_A7B30DE187CA05B92B54B8537A15E8")
    var_1 = (0, 0, -100);

  return var_1;
}

javelin_softsighttest(var_0) {
  if(javelin_vehiclelocksighttest(var_0)) {
    self.javelin.lostsightlinetime = 0;
    return 1;
  }

  if(self.javelin.lostsightlinetime == 0)
    self.javelin.lostsightlinetime = gettime();

  var_1 = gettime() - self.javelin.lostsightlinetime;

  if(var_1 >= 500)
    return 0;

  return 1;
}

javelin_hidenormalhud(var_0) {
  if(var_0)
    self setclientomnvar("_encstr_82471033BB5FA2F08ED16D3B8E173DE4EF38", 1);
  else
    self setclientomnvar("_encstr_82471033BB5FA2F08ED16D3B8E173DE4EF38", 0);
}

javelin_setuistate(var_0) {
  self setclientomnvar("_encstr_A74D1165C3E98C9F2489EAA2F0E89F436091ED", var_0);
}

marklocation(var_0) {
  var_1 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_A74D117AD3A04FABABE81A13D0FE9F4460ABFA", self, var_0, self);

  if(var_0.model == "_encstr_A2B40B8E2C3B7DDB274B9D4B37")
    var_0 show();

  self.javelinlocationtargeted = 1;
  thread watchtargetmarkerentstatus(var_0, var_1, 1);
}

watchtargetmarkerentstatus(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(self.javelin.target) && self.javelin.state != "_encstr_BA19049F4B2D")
    waitframe();

  if(isDefined(var_1))
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_1);

  self.javelinlocationtargeted = undefined;
}

vehicle_damage_deregistervisualpercentcallback() {
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

  self notify("_encstr_A36612ABED38131911B88A02D07D414790D50E34");
  self stoplocalsound("_encstr_8D1B114D85D95936B4B9BE1BD85DEB367B6CB5");
}