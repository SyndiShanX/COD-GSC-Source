/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\stealth.gsc
***********************************************/

initstealthfunctions() {
  self.fnsetstealthstate = ::setstealthstate;
  self.fnisinstealthidle = ::isidle;
  self.fnisinstealthinvestigate = ::isinvestigating;
  self.fnisinstealthhunt = ::ishunting;
  self.fnisinstealthcombat = ::iscombating;
  self.fnisinstealthidlescriptedanim = ::isidlescriptedanim;
  self.fnstealthupdatevisionforlighting = ::updatevisionforlighting;
  self.fnstealthisidlecurious = ::isidlecurious;
  self.fnclearstealthvolume = ::clearstealthvolume;
  self.fnstealthflashlightdetach = scripts\asm\soldier\patrol::detachflashlight;
}

ifinstealth(var_0) {
  if(!isDefined(self.stealth))
    return anim.failure;

  if(self.team == "allies")
    return anim.failure;

  if(self.stealth.bsmstate == 3)
    return anim.failure;

  return anim.success;
}

isidlescriptedanim() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 0 && isDefined(self._blackboard.idlenode);
}

isidle() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 0;
}

isinvestigating() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 1;
}

ishunting() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 2;
}

iscombating() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 3;
}

stealth_shouldfriendly(var_0) {
  if(self.team == "allies")
    return anim.success;

  return anim.failure;
}

stealth_initfriendly(var_0) {
  scripts\stealth\friendly::main();
  return anim.success;
}

stealth_terminatefriendly(var_0) {
  self.stealth = undefined;
}

stealth_shouldneutral(var_0) {
  if(self.team == "neutral")
    return anim.success;

  return anim.failure;
}

stealth_initneutral(var_0) {
  scripts\stealth\neutral::main();
  return anim.success;
}

isinlight(var_0) {
  if(!isDefined(var_0))
    return !istrue(level.is_dark);

  return var_0 >= 0.5;
}

updatevisionforlighting() {}

forceflashlightplayercanseeifnecessary() {
  if(isDefined(self.flashlight) && self.flashlight) {
    var_0 = 0.1;

    foreach(var_2 in level.players) {
      if(isDefined(var_2.nvg) && isDefined(var_2.nvg.lightmeter) && var_2.nvg.lightmeter > var_0 && isDefined(var_2.nvg.prevlightmeter) && var_2.nvg.lightmeter - var_2.nvg.prevlightmeter > 0.01) {
        if(self aipointinfov(var_2.origin) && !self cansee(var_2))
          self cansee(var_2, 0);
      }
    }
  }
}

stealth_enemy_getbsmstate(var_0) {
  switch (self.stealth.bsmstate) {
    case 0:
      return "Stealth_Idle";
    case 1:
      if(isDefined(self.stealth.investigateendtime) && gettime() >= self.stealth.investigateendtime) {
        setstealthstate("idle");
        return "Stealth_Idle";
      }

      return "Stealth_Investigate";
    case 2:
      return "Stealth_Hunt";
    case 3:
      return "Stealth_Combat";
  }
}

stealth_reacter_updateeveryframe(var_0) {
  scripts\stealth\enemy::proximity_check();
  return anim.success;
}

stealth_enemy_updateeveryframe(var_0) {
  var_1 = scripts\engine\utility::ent_flag_exist("react_to_dynolights") && scripts\engine\utility::ent_flag("react_to_dynolights");

  if(var_1 && !isDefined(self.lightmeter)) {
    scripts\stealth\utility::update_light_meter();
    var_1 = 0;
  }

  updatelightbasedflashlight(self.stealth.bsmstate, 0.5);

  if(var_1) {
    var_2 = self getentitynumber();
    var_3 = level.frameduration;

    if(gettime() / var_3 % 5 == var_2 % 5)
      scripts\stealth\utility::update_light_meter();
  }

  forceflashlightplayercanseeifnecessary();
  return stealth_reacter_updateeveryframe(var_0);
}

stealth_neutral_updateeveryframe(var_0) {
  return stealth_reacter_updateeveryframe(var_0);
}

enterstealthstate(var_0) {
  exitstealthstate(self.stealth.bsmstate);
  self.stealth.bsmstate = var_0;

  switch (var_0) {
    case 1:
      investigate_init();
      break;
    case 2:
      hunt_init();
      break;
    case 3:
      combat_init();
      break;
  }
}

exitstealthstate(var_0) {
  switch (var_0) {
    case 1:
      investigate_terminate();
      break;
    case 2:
      hunt_terminate();
      break;
    case 3:
      combat_terminate();
      break;
  }
}

isdonewithsearchmove(var_0) {
  var_1 = gettime();

  if(var_1 > var_0.starttime + 500 && (!isDefined(self.pathgoalpos) || distance2dsquared(self.pathgoalpos, self.origin) < 4) && !self.arriving && !isDefined(self._blackboard.doortoopen)) {
    if(!isDefined(var_0.goalpos))
      return 1;

    if(distance2dsquared(self.origin, var_0.goalpos) < 3600 && squared(var_0.goalpos[2] - self.origin[2]) < 5184)
      return 1;

    var_0.numfails++;
    var_0.starttime = var_1;

    if(var_0.numfails >= 10)
      return 1;
  }

  return 0;
}

updatelightbasedflashlight(var_0, var_1) {
  if(self isinscriptedstate()) {
    return;
  }
  if(gettime() == self.starttime) {
    return;
  }
  var_2 = self.lightmeter;

  if(isDefined(self._blackboard.bflashlight))
    var_3 = self._blackboard.bflashlight;
  else
    var_3 = 0;

  if(isDefined(self.flashlightoverride))
    self._blackboard.bflashlight = self.flashlightoverride;
  else if(istrue(self.noflashlight))
    self._blackboard.bflashlight = 0;
  else if(isDefined(var_2)) {
    var_4 = 0.1;

    if(istrue(self._blackboard.bflashlight)) {
      if(var_2 > var_1 + var_4)
        self._blackboard.bflashlight = 0;
    } else
      self._blackboard.bflashlight = var_2 < var_1;
  } else if(istrue(level.is_dark))
    self._blackboard.bflashlight = 1;
  else
    self._blackboard.bflashlight = 0;

  if(var_3 != self._blackboard.bflashlight) {
    if(scripts\asm\asm::asm_getdemeanor() != "patrol" && (!isDefined(self.asm.flashlight) || !self.asm.flashlight)) {
      if(self._blackboard.bflashlight)
        self[[self.fnstealthflashlighton]]();
      else
        self[[self.fnstealthflashlightoff]]();
    }
  }
}

idle_updatestyle(var_0) {
  scripts\stealth\enemy::setpatrolstyle_base();
  var_0.nextstylechecktime = gettime() + randomintrange(500, 2000);

  if(isDefined(self.stealth.patrol_moveplaybackrate))
    self.moveplaybackrate = self.stealth.patrol_moveplaybackrate;
  else
    self.moveplaybackrate = 1;
}

isidlecurious() {
  return isDefined(self.stealth.bidlecurious) && self.stealth.bidlecurious;
}

idle_updatecurious(var_0) {
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_5 = self getthreatsight(var_4);

    if(!isDefined(var_1) || var_5 > var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  var_5 = var_2;
  var_7 = 0.25;

  if(self.stealth.bidlecurious) {
    var_8 = 2000;

    if(var_5 >= var_7)
      var_0.curiousstarttime = gettime();

    if(gettime() > var_0.curiousstarttime + var_8) {
      if(var_5 < var_7 * 0.9) {
        self.stealth.bidlecurious = 0;
        self.stealth.idlecurioustarget = undefined;

        if(!isDefined(self.pathgoalpos) && isDefined(var_0.idlenode)) {
          self._blackboard.idlenode = var_0.idlenode;
          return;
        }

        return;
      }

      return;
    }
  } else if(var_5 >= var_7) {
    self.stealth.bidlecurious = 1;
    self.stealth.idlecurioustarget = var_1;
    var_0.curiousstarttime = gettime();
    var_0.idlenode = self._blackboard.idlenode;
    self._blackboard.idlenode = undefined;
    scripts\stealth\utility::set_patrol_react(var_1.origin, "small");
  }
}

updatesightstate(var_0) {
  if(scripts\engine\utility::flag("stealth_spotted"))
    var_0 = "hunt";

  var_1 = !isDefined(self.stealth.threat_sight_state);

  if(!var_1) {
    switch (self.stealth.threat_sight_state) {
      case "combat_hunt":
        var_1 = var_0 != "hunt" && var_0 != "combat_hunt";
        break;
      case "spotted":
        var_1 = var_0 != "combat" && var_0 != "spotted";
        break;
      case "hidden":
        var_1 = var_0 != "idle" && var_0 != "unaware" && var_0 != "hidden";
        break;
      default:
        var_1 = self.stealth.threat_sight_state != var_0;
        break;
    }
  }

  if(var_1)
    scripts\stealth\enemy::set_sight_state(var_0);
}

idle_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.favoriteenemy = undefined;
  self.dontattackme = 1;
  self.shootposoverride = undefined;
  self.stealth.reachedinvestigate = 0;
  thread scripts\stealth\corpse::corpse_clear();
  idle_updatestyle(self.bt.instancedata[var_0]);
  self.combatmode = "no_cover";

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.stealth)) {
      continue;
    }
    if(!isDefined(var_2.stealth.spotted_list)) {
      continue;
    }
    var_2.stealth.spotted_list[self.unique_id] = undefined;
  }

  self.diequietly = 1;
  self clearenemy();
  self.stealth.bidlecurious = 0;
  self.bt.instancedata[var_0].curiousstarttime = -1;
  thread scripts\stealth\enemy::set_alert_level("reset");
  scripts\stealth\event::event_escalation_clear();

  if(isDefined(self.stealth.funcs["hidden"]))
    scripts\stealth\callbacks::stealth_call_thread("hidden");

  if(isDefined(self.target)) {
    self.goalradius = 32;

    if(isDefined(self.fnstealthgotonode))
      self thread[[self.fnstealthgotonode]](undefined, undefined, undefined);
  }

  self.gunposeoverride_internal = "gun_down";
}

idle_update(var_0) {
  scripts\stealth\corpse::corpse_sight();

  if(istrue(self.stealth.blind))
    updatesightstate("blind");
  else
    updatesightstate("hidden");

  if(isDefined(self.stealth.active_sense_funcs)) {
    foreach(var_2 in self.stealth.active_sense_funcs)
    self[[var_2]]();
  }

  var_4 = gettime();

  if(var_4 >= self.bt.instancedata[var_0].nextstylechecktime)
    idle_updatestyle(self.bt.instancedata[var_0]);

  idle_updatecurious(self.bt.instancedata[var_0]);
  idle_updateflashlighttarget();
  return anim.running;
}

idle_terminate(var_0) {
  self.diequietly = 0;
  self.stealth.bidlecurious = undefined;
  self.stealth.idlecurioustarget = undefined;
  self._blackboard.idlenode = undefined;

  if(self.stealth.bsmstate != 1)
    self.cqb_target = undefined;

  scripts\stealth\utility::save_last_goal();
  self.last_set_goalnode = undefined;
  self.last_set_goalent = undefined;
  self.moveplaybackrate = 1;
  self.bt.instancedata[var_0] = undefined;
}

idle_updateflashlighttarget() {
  if(!isDefined(self._blackboard.bflashlight) || !self._blackboard.bflashlight)
    self.cqb_target = undefined;
  else {
    if(self.stealth.bidlecurious && isDefined(self.stealth.idlecurioustarget)) {
      self.cqb_target = self lastknownpos(self.stealth.idlecurioustarget);
      return;
    }

    var_0 = 0;

    foreach(var_2 in level.players) {
      if(self getthreatsight(var_2) > 0.1) {
        self.cqb_target = self lastknownpos(var_2);
        var_0 = 1;
        break;
      }
    }

    if(!var_0) {
      var_4 = anglesToForward(self.angles);
      self.cqb_target = self.origin + var_4 * 128;
    }
  }
}

stealth_shouldinvestigate(var_0) {
  if(self.stealth.bsmstate == 1)
    return anim.success;

  return anim.failure;
}

findclosestlospointwithin(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3)) {
    var_7 = findclosestpointbyapproxpathdist(var_3, var_1, var_2, var_0.usedpoints, 48);

    if(isDefined(var_7) && isDefined(var_6) && var_6 && !investigate_sanitycheckinitialpos(var_1, var_7))
      return undefined;

    return var_7;
  } else if(var_5 > 64 && isDefined(var_4)) {
    var_7 = findopenlookdir(var_4, var_5, var_1, var_2, var_0.usedpoints, 48);

    if(isDefined(var_7) && isDefined(var_6) && var_6 && !investigate_sanitycheckinitialpos(var_1, var_7))
      return undefined;

    return var_7;
  }

  return getrandomnavpoint(var_1, 200, self);
}

investigate_sanitycheckinitialpos(var_0, var_1) {
  var_2 = vectorNormalize(var_0 - self.origin);
  var_3 = var_1 - self.origin;
  var_4 = length(var_3);

  if(var_4 > 256) {
    var_3 = var_3 / var_4;

    if(vectordot(var_3, var_2) < -0.5)
      return 0;
  }

  return 1;
}

investigate_getcorpseoffsetpos(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = var_0 - vectorNormalize(var_1) * 32;
  var_2 = getclosestpointonnavmesh(var_2, self);
  return var_2;
}

investigate_getinitialpos() {
  var_0 = 1;
  var_1 = self.stealth.investigateevent;

  if(isDefined(self.stealth.investigate_point)) {
    var_2 = getclosestpointonnavmesh(var_1.investigate_pos, self);
    var_3 = vectorNormalize(self.goalpos - self.origin);
    var_4 = anglesToForward(self.angles);
    var_5 = vectorNormalize(var_2 - self.origin);

    if(isPlayer(var_1.entity) && !isPlayer(self.stealth.investigate_entity))
      var_0 = 1;
    else if(vectordot(var_3, var_5) < 0 && vectordot(var_4, var_5) < 0)
      var_0 = 1;
    else if(var_1.typeorig == "saw_corpse")
      var_0 = 1;
    else if(var_0 && distancesquared(self.goalpos, var_2) < squared(300))
      var_0 = 0;
  }

  if(var_0) {
    var_6 = level.stealth.investigate_volumes[self.script_stealthgroup];
    var_7 = scripts\stealth\group::getgroup(self.script_stealthgroup);
    var_8 = scripts\stealth\group::group_findpod(var_7, self);
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;

    if(isDefined(var_8.investigateoriginguy) && var_8.investigateoriginguy == self || var_8.members[0] == self)
      var_9 = 1;
    else if(distancesquared(self.origin, var_1.investigate_pos) < 16384)
      var_11 = 1;
    else if(var_8.members.size > 1 && var_8.members[1] == self)
      var_10 = 1;

    if(!isDefined(var_8.usedpoints)) {
      var_8.usedpoints = [];
      var_8.usedpointsexpiry = [];
    }

    var_12 = undefined;

    if(var_9) {
      if(var_1.typeorig == "saw_corpse" || distance2dsquared(self.origin, var_1.investigate_pos) < 4096) {
        var_12 = var_1.investigate_pos;

        if(var_1.typeorig == "saw_corpse")
          var_12 = investigate_getcorpseoffsetpos(var_12);

        if(isDefined(var_6)) {
          var_13 = self findlastpointonpathwithinvolume(var_12, var_6);

          if(isDefined(var_13))
            var_12 = var_13;
        }
      }

      if(!isDefined(var_12)) {
        var_12 = findclosestlospointwithin(var_8, var_1.investigate_pos, var_1.investigate_pos, var_6, self.scriptgoalpos, self.goalradius, 1);

        if(!isDefined(var_12)) {
          if(isDefined(var_6))
            var_12 = self findlastpointonpathwithinvolume(var_1.investigate_pos, var_6);

          if(!isDefined(var_12))
            var_12 = findclosestlospointwithin(var_8, var_1.investigate_pos, self.origin, var_6, self.scriptgoalpos, self.goalradius, 1);

          if(!isDefined(var_12))
            var_12 = self.origin;
        }
      }
    } else if(var_10) {
      var_14 = randomfloatrange(0.7, 0.85);
      var_12 = vectorlerp(self.origin, var_1.investigate_pos, var_14);
      var_12 = findclosestlospointwithin(var_8, var_12, var_12, var_6, self.scriptgoalpos, self.goalradius);
    } else if(!var_11)
      var_12 = findclosestlospointwithin(var_8, var_1.investigate_pos, self.origin, var_6, self.scriptgoalpos, self.goalradius);

    if(isDefined(var_12) && !investigate_sanitycheckinitialpos(var_1.investigate_pos, var_12))
      var_12 = undefined;

    if(!isDefined(var_12))
      var_12 = investigate_getuninvestigatedpos();
    else
      scripts\stealth\group::pod_addusedpoint(var_8, var_12);

    return var_12;
  }
}

investigate_getuninvestigatedpos() {
  var_0 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_1 = scripts\stealth\group::group_findpod(var_0, self);

  if(isDefined(var_1.investigateoriginguy) && var_1.investigateoriginguy == self) {
    var_2 = undefined;

    if(isDefined(var_1.volume))
      var_2 = self findlastpointonpathwithinvolume(var_1.origin, var_1.volume);

    if(!isDefined(var_2))
      var_2 = getclosestpointonnavmesh(var_1.origin, self);

    var_1.investigateoriginguy = undefined;
  } else
    var_2 = scripts\stealth\group::group_getinvestigatepoint(self);

  return var_2;
}

setinvestigateendtime() {
  var_0 = 15;
  var_1 = 20;

  if(isDefined(self.stealth.investigatemintime))
    var_0 = self.stealth.investigatemintime;

  if(isDefined(self.stealth.investigatemaxtime))
    var_1 = self.stealth.investigatemaxtime;

  self.stealth.investigateendtime = gettime() + randomintrange(var_0, var_1) * 1000;
}

findgoodinvestigatelookdir(var_0) {
  if(scripts\asm\asm_bb::bb_smartobjectrequested() && isDefined(self.asm.customdata.arrivalangles))
    return self.asm.customdata.arrivalangles;

  if(istrue(self.limitstealthturning))
    return vectortoangles(var_0 - self.origin);

  var_1 = makeweapon(var_0, 256, 96);

  if(isDefined(var_1))
    return vectortoangles(var_1);
}

investigate_shouldfacedecentdirectionwhenidle() {
  return !istrue(self.limitstealthturning);
}

investigate_init() {
  var_0 = self.stealth.investigateevent;
  self.stealth.investigate_severity = var_0.type;
  self.stealth.investigate_entity = var_0.entity;
  self.script_forcegoal = 0;
  updatesightstate("investigate");
  self.diequietly = 1;

  if(investigate_shouldfacedecentdirectionwhenidle())
    self._blackboard.bfacesomedecentdirectionwhenidle = 1;

  investigate_setreaction(var_0);
  self.stealth.binitialinvestigate = 1;

  if(!self isinscriptedstate()) {
    if(istrue(self.stealthforcegundown))
      self.gunposeoverride_internal = "gun_down";
    else
      self.gunposeoverride_internal = "ready";
  }
}

investigate_setreaction(var_0) {
  var_1 = "small";

  if(var_0.typeorig == "bulletwhizby" || var_0.typeorig == "grenade danger")
    var_1 = "med";
  else if(var_0.typeorig == "footstep_sprint") {
    if(isDefined(var_0.entity) && isPlayer(var_0.entity) && var_0.entity scripts\stealth\threat_sight::player_is_sprinting_at_me(self))
      var_1 = "med";
  }

  scripts\stealth\utility::set_patrol_react(var_0.investigate_pos, var_1);
}

investigate_updateeveryframe(var_0) {
  scripts\stealth\corpse::corpse_sight();

  if(isDefined(self.enemy))
    self clearenemy();

  updatesightstate("investigate");

  if(isDefined(self.stealth.active_sense_funcs)) {
    foreach(var_2 in self.stealth.active_sense_funcs)
    self[[var_2]]();
  }

  return anim.success;
}

investigate_setupruntocorpse(var_0, var_1, var_2) {
  scripts\stealth\utility::set_patrol_style("combat", var_2, var_1, "med");
  var_0.nextstylecheck = gettime() + 100;
  var_0.nextstylecheckdist = 256;
  var_0.nextstylecheckinterval = 100;
  self.asm.customdata.arrivalangles = undefined;
}

investigate_move_init(var_0) {
  self.fovforward = self.alertlevelint <= 2;
  var_1 = gettime();
  var_2 = spawnStruct();
  var_2.starttime = var_1;
  var_2.cqbtargetnexttwitchtime = var_1 + randomintrange(2000, 4000);
  self.bt.instancedata[var_0] = var_2;
  var_3 = self.stealth.investigateevent.typeorig;

  if(var_3 == "saw_corpse") {
    if(isDefined(self.stealth.corpse.ent))
      var_2.nextcorpsechecktime = var_1 + 200;
  } else if(var_3 == "grenade danger") {
    self.grenadeawareness = 1.0;
    self.grenadereturnthrowchance = 0;
    scripts\stealth\utility::set_patrol_style("alert");
    return;
  }

  var_4 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_5 = scripts\stealth\group::group_findpod(var_4, self);

  if(self.stealth.binitialinvestigate)
    var_6 = investigate_getinitialpos();
  else
    var_6 = investigate_getuninvestigatedpos();

  if(isDefined(var_5.needsupdate))
    var_5.needsupdate = scripts\engine\utility::array_remove(var_5.needsupdate, self);

  if(isDefined(var_5.investigateoriginguy) && var_5.investigateoriginguy == self)
    var_5.investigateoriginguy = undefined;

  if(isDefined(var_6)) {
    self.stealth.investigate_point = var_6;
    self setbtgoalpos(0, var_6);
    self setbtgoalRadius(0, 24);
    var_2.goalpos = var_6;
    var_2.numfails = 0;

    if(self.stealth.binitialinvestigate) {
      if(var_3 == "saw_corpse" || var_3 == "found_corpse")
        investigate_setupruntocorpse(self.bt.instancedata[var_0], var_6, 1);
      else if(var_3 == "bulletwhizby") {
        scripts\stealth\utility::set_patrol_style("cqb");
        self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var_6);
      } else {
        scripts\stealth\utility::set_patrol_style("alert");
        var_7 = self.stealth.investigateevent.look_pos;

        if(!isDefined(var_7))
          var_7 = self.stealth.investigateevent.investigate_pos;

        investigate_move_setaimtarget(var_2, var_7, var_3);
        self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var_6);
      }
    } else {
      scripts\stealth\utility::set_patrol_style("alert");
      self.moveplaybackrate = 1;
      self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var_6);
    }

    if(distance2dsquared(self.origin, var_6) < 1 && self.stealth.binitialinvestigate || !investigate_shouldfacedecentdirectionwhenidle())
      self._blackboard.bfacesomedecentdirectionwhenidle = undefined;
    else
      self._blackboard.bfacesomedecentdirectionwhenidle = 1;
  }

  self.disablelookdownpath = 1;
  var_2.enablelookdownpathtime = var_1 + 2000;
}

investigate_move_setaimtarget(var_0, var_1, var_2) {
  var_3 = 5000;

  if(isDefined(var_2)) {
    switch (var_2) {
      case "sight":
        var_3 = 1000;
        break;
      case "light_killed":
      case "glass_destroyed":
        var_3 = 3000;
        break;
    }
  }

  self.cqb_target = var_1;
  var_0.cqbtargetendtime = gettime() + var_3;
}

setuprandomlooktarget(var_0) {
  var_1 = 400;
  var_0.cqbtwitching = 1;
  var_0.cqbtwitchend = gettime() + var_1;
  var_0.cqbtwitchstate = 0;

  if(scripts\engine\utility::cointoss())
    var_0.cqbtwitchdir = 1;
  else
    var_0.cqbtwitchdir = -1;
}

resetcqbtwitch(var_0) {
  var_0.cqbtargetnexttwitchtime = gettime() + randomintrange(2000, 4000);
  var_0.cqbtwitching = undefined;
  var_0.cqbtwitchend = undefined;
  var_0.cqbtwitchstate = undefined;
  var_0.cqbtwitchdir = undefined;
}

updaterandomlooktarget(var_0, var_1) {
  var_2 = 400;
  var_3 = 1000;
  var_4 = 20;
  var_5 = anglesToForward(self.angles);
  var_6 = gettime();

  switch (var_0.cqbtwitchstate) {
    case 0:
      var_7 = (var_0.cqbtwitchend - var_6) / var_2;

      if(var_7 > 0) {
        var_8 = var_4 * (1 - sin(var_7 * 90)) * var_0.cqbtwitchdir;
        self.cqb_target = self.origin + rotatevector(var_5, (0, var_8, 0)) * var_1;
        break;
      } else {
        var_0.cqbtwitchend = var_6 + var_3;
        var_0.cqbtwitchstate++;
      }
    case 1:
      if(var_6 < var_0.cqbtwitchend) {
        self.cqb_target = self.origin + rotatevector(var_5, (0, var_4 * var_0.cqbtwitchdir, 0)) * var_1;
        break;
      } else {
        var_0.cqbtwitchend = var_6 + var_2;
        var_0.cqbtwitchstate++;
      }
    case 2:
      var_7 = (var_0.cqbtwitchend - var_6) / var_2;

      if(var_7 > 0) {
        var_8 = var_4 * sin(var_7 * 90) * var_0.cqbtwitchdir;
        self.cqb_target = self.origin + rotatevector(var_5, (0, var_8, 0)) * var_1;
      } else
        resetcqbtwitch(var_0);

      break;
  }
}

investigate_move_updateaimtarget(var_0) {
  var_1 = gettime();

  if(isDefined(var_0.cqbtargetendtime)) {
    if(isDefined(self.cqb_target)) {
      var_2 = self.cqb_target - self.origin;
      var_3 = isDefined(self.stealth.patrol_react_magnitude) || isDefined(self.stealth.breacting);

      if(var_1 > var_0.cqbtargetendtime || !var_3 && abs(self.angles[1], vectortoyaw(var_2)) > 50) {
        self.cqb_target = undefined;
        var_0.cqbtargetendtime = undefined;
        var_0.cqbtargetnexttwitchtime = var_1 + randomintrange(2000, 4000);
      }
    } else {
      var_0.cqbtargetendtime = undefined;
      var_0.cqbtargetnexttwitchtime = var_1 + randomintrange(2000, 4000);
    }
  }

  if(!isDefined(var_0.cqbtargetendtime)) {
    var_4 = anglesToForward(self.angles);
    var_5 = 0;

    foreach(var_7 in level.players) {
      if(self getthreatsight(var_7) > 0) {
        var_5 = 1;
        resetcqbtwitch(var_0);
        self.cqb_target = self lastknownpos(var_7);
        break;
      }
    }

    if(!var_5) {
      var_9 = 400;
      var_10 = 1000;
      var_11 = 20;

      if(isDefined(var_0.cqbtwitching))
        updaterandomlooktarget(var_0, 78);
      else if(isDefined(var_0.cqbtargetnexttwitchtime) && var_1 > var_0.cqbtargetnexttwitchtime) {
        var_0.cqbtwitching = 1;
        var_0.cqbtwitchend = var_1 + var_9;
        var_0.cqbtwitchstate = 0;

        if(scripts\engine\utility::cointoss())
          var_0.cqbtwitchdir = 1;
        else
          var_0.cqbtwitchdir = -1;

        updaterandomlooktarget(var_0, 78);
      } else
        self.cqb_target = self.origin + var_4 * 78;
    }
  }
}

investigate_move(var_0) {
  if(self islinked())
    return anim.success;

  if(self.stealth.investigateevent.typeorig == "grenade danger")
    return anim.success;

  var_1 = gettime();
  var_2 = self.bt.instancedata[var_0];
  var_3 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_4 = scripts\stealth\group::group_findpod(var_3, self);
  var_5 = scripts\asm\asm_bb::bb_smartobjectrequested();

  if(self.arriving && var_5 && distancesquared(self.goalpos, self.origin) < 225)
    scripts\asm\asm_bb::bb_requestplaysmartobject();

  if(isDefined(var_4.needsupdate) && scripts\engine\utility::array_contains(var_4.needsupdate, self)) {
    var_6 = investigate_getuninvestigatedpos();
    var_4.needsupdate = scripts\engine\utility::array_remove(var_4.needsupdate, self);
    self setbtgoalpos(0, var_6);
    var_7 = self.stealth.investigateevent.typeorig;

    if(var_7 == "saw_corpse" || var_7 == "found_corpse")
      investigate_setupruntocorpse(var_2, var_6, 0);
    else {
      var_8 = gettime() > var_2.starttime;
      var_9 = "alert";
      var_10 = "small";

      if(var_7 == "bulletwhizby" || scripts\asm\asm::asm_getdemeanor() == "combat") {
        var_9 = "cqb";
        var_10 = "med";
      }

      if(istrue(self.stealth.binitialinvestigate) && isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, var_6) < 576)
        var_8 = 0;

      scripts\stealth\utility::set_patrol_style(var_9, var_8, var_6, var_10);
      var_11 = self.stealth.investigateevent.look_pos;

      if(!isDefined(var_11))
        var_11 = self.stealth.investigateevent.investigate_pos;

      investigate_move_setaimtarget(var_2, var_11, var_7);
      self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var_6);
      var_2.nextcorpsechecktime = undefined;
    }
  }

  if(isDefined(var_2.nextcorpsechecktime) && var_1 > var_2.nextcorpsechecktime) {
    if(isDefined(self.stealth.corpse.ent)) {
      var_12 = self.stealth.corpse.ent scripts\stealth\utility::getcorpseorigin();
      var_12 = investigate_getcorpseoffsetpos(var_12);
      self setbtgoalpos(0, var_12);
      var_2.nextcorpsechecktime = var_1 + 200;
    } else
      var_2.nextcorpsechecktime = undefined;
  }

  if(isDefined(var_2.enablelookdownpathtime) && var_1 > var_2.enablelookdownpathtime) {
    self.disablelookdownpath = undefined;
    var_2.enablelookdownpathtime = undefined;
  }

  var_13 = level.player;

  if(self cansee(var_13))
    investigate_move_setaimtarget(var_2, self lastknownpos(var_13) + (0, 0, 32), "sight");

  investigate_move_updateaimtarget(var_2);

  if(isdonewithsearchmove(var_2))
    return anim.success;

  if(isDefined(var_2.nextstylecheck) && var_1 >= var_2.nextstylecheck) {
    var_14 = 512;

    if(isDefined(var_2.nextstylecheckdist))
      var_14 = var_2.nextstylecheckdist;

    if(self pathdisttogoal() > var_14) {
      var_15 = 1000;

      if(isDefined(var_2.nextstylecheckinterval))
        var_15 = var_2.nextstylecheckinterval;

      var_2.nextstylecheck = var_1 + var_15;
    } else {
      scripts\stealth\utility::set_patrol_style("alert");
      var_2.nextstylecheck = undefined;
    }
  }

  return anim.running;
}

investigate_move_terminate(var_0) {
  self.fovforward = 0;
  self.stealth.binitialinvestigate = 0;
  self.bt.instancedata[var_0] = undefined;
  self.cqb_target = undefined;
  self.disablelookdownpath = undefined;
  self.stealth.bexaminerequested = undefined;
  scripts\stealth\corpse::corpse_clear();
}

investigate_lookaround_init(var_0) {
  var_1 = spawnStruct();
  var_1.failsafetimeout = gettime() + 8000;

  if(isDefined(self.stealth.scriptedinitialinvestigatedelay)) {
    var_1.initialinvestigatetime = gettime() + self.stealth.scriptedinitialinvestigatedelay * 1000;
    self.stealth.scriptedinitialinvestigatedelay = undefined;
  }

  self.bt.instancedata[var_0] = var_1;
  self setbtgoalpos(0, self getnavposition());
  scripts\stealth\utility::set_patrol_style("alert");
  self.stealth.binvestigatelookaround = 1;

  if(!self.stealth.binitialinvestigate && !isDefined(self.stealth.investigateendtime))
    setinvestigateendtime();
}

investigate_lookaround(var_0) {
  if(gettime() > self.bt.instancedata[var_0].failsafetimeout)
    return anim.success;

  if(self.stealth.binitialinvestigate) {
    if(isDefined(self.bt.instancedata[var_0].initialinvestigatetime) && gettime() < self.bt.instancedata[var_0].initialinvestigatetime)
      return anim.running;

    return anim.success;
  }

  var_1 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_2 = scripts\stealth\group::group_findpod(var_1, self);

  if(isDefined(var_2.needsupdate) && scripts\engine\utility::array_contains(var_2.needsupdate, self)) {
    var_2.needsupdate = scripts\engine\utility::array_remove(var_2.needsupdate, self);
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("investigate_look", "end"))
    return anim.success;

  foreach(var_4 in level.players) {
    if(self getthreatsight(var_4) > 0.05)
      return anim.failure;
  }

  return anim.running;
}

investigate_lookaround_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.stealth.binvestigatelookaround = 0;
}

investigate_targetedlookaround(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(self getthreatsight(var_3) > 0.05) {
      self.cqb_target = self lastknownpos(var_3);
      var_1 = 1;
      break;
    }
  }

  if(var_1)
    return anim.running;

  var_5 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_6 = scripts\stealth\group::group_findpod(var_5, self);
  var_6 scripts\stealth\group::pod_updateinvestigateorigin(self, self.cqb_target);
  return anim.success;
}

investigate_terminate() {
  self clearbtgoal(0);
  self.diequietly = 0;
  self.stealth.investigate_point = undefined;
  self.stealth.investigate_severity = undefined;
  self.stealth.investigate_entity = undefined;
  self.stealth.investigateevent_time = undefined;
  self.stealth.investigateevent = undefined;
  self.stealth.binitialinvestigate = undefined;
  self.stealth.binvestigateoutofrange = undefined;
  self.stealth.investigateendtime = undefined;
  self._blackboard.bfacesomedecentdirectionwhenidle = undefined;
  self.asm.customdata.arrivalangles = undefined;
  self.moveplaybackrate = 1;
  self.cqb_target = undefined;
  scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
  scripts\stealth\corpse::corpse_clear();
}

stealth_shouldhunt(var_0) {
  if(self.stealth.bsmstate == 2)
    return anim.success;

  return anim.failure;
}

hunt_shouldinvestigateorigin(var_0, var_1) {
  foreach(var_3 in level.stealth.groupdata.groups) {
    foreach(var_5 in var_3.pods) {
      if(var_5 == var_0) {
        continue;
      }
      if(var_5.state == 2 && isDefined(var_5.borigininvestigated) && distance2dsquared(var_0.origin, var_5.origin) < 576) {
        var_0.borigininvestigated = 1;
        return 0;
      }
    }
  }

  return var_0 scripts\stealth\group::pod_getclosestguy(var_0.origin) == var_1;
}

hunt_updateregiontoclear() {
  if(!isDefined(self.stealth.cleardata) || !isDefined(self.stealth.cleardata.curregion)) {
    if(!isDefined(self.script_stealth_region_group) || !isDefined(level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group]) || level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].size == 0) {
      return;
    }
    var_0 = scripts\stealth\clear_regions::getregionforpos(self.origin);

    if(!isDefined(var_0)) {
      return;
    }
    if(!isDefined(self.stealth.cleardata))
      self.stealth.cleardata = spawnStruct();

    var_1 = self.stealth.cleardata;
    var_1.prevregion = [];
    var_1.prevregion[0] = var_0;
    var_1.prevregion[1] = var_0;
    var_1.isinregion = 0;
    scripts\stealth\clear_regions::huntassigntoregion(var_0);
    var_1.curroutepoint = scripts\stealth\clear_regions::findcurposonroute(self.origin, var_0.route_points);
    var_1.brouteforward = 1;
  }
}

hunt_clearroomdata() {
  if(isDefined(self.stealth.cleardata)) {
    if(isDefined(self.stealth.cleardata.curregion))
      scripts\stealth\clear_regions::huntdecaiassignment(self.stealth.cleardata.curregion);

    self.stealth.cleardata = undefined;
  }
}

hunt_finddoorbetween(var_0, var_1) {
  foreach(var_3 in var_0.region_links) {
    if(var_3.region == var_1) {
      var_4 = var_3.transition_to_point.origin;

      for(var_5 = 0; var_5 < var_1.route_points.size; var_5++) {
        if(distancesquared(var_1.route_points[var_5].origin, var_4) < 4)
          return var_5;
      }
    }
  }
}

hunt_getnextclearpos() {
  var_0 = self.stealth.cleardata;
  var_1 = undefined;
  var_2 = 0;

  while(var_2 < 2) {
    var_3 = scripts\stealth\clear_regions::findnextpointofinterest(self.origin, var_0.curregion, var_0.curroutepoint, var_0.brouteforward);

    if(isDefined(var_3)) {
      var_1 = var_3[0];
      var_0.curroutepoint = var_3[1];
      break;
    } else {
      if(var_2 == 1) {
        break;
      }

      var_4 = var_0.curregion;
      scripts\stealth\clear_regions::huntgetnextregion();
      var_0.curroutepoint = 0;
      var_0.brouteforward = 1;

      if(var_4 != var_0.curregion) {
        var_5 = hunt_finddoorbetween(var_4, var_0.curregion);

        if(isDefined(var_5))
          var_0.curroutepoint = var_5;
        else
          var_0.curroutepoint = scripts\stealth\clear_regions::findcurposonroute(self.origin, var_0.curregion.route_points);

        if(var_0.curroutepoint > var_0.curregion.route_points.size * 0.5)
          var_0.brouteforward = 0;
      }

      var_2++;
    }
  }

  if(isDefined(var_1)) {
    self.asm.customdata.arrivalangles = var_1.angles;
    scripts\smartobjects\utility::setsmartobject(var_1);
    return var_1.origin;
  }

  var_6 = 0;
  var_7 = 1;
  var_8 = var_0.curregion.route_points.size;

  if(var_0.curroutepoint > var_8 * 0.5) {
    var_6 = var_8 - 1;
    var_7 = var_6 - 1;
  }

  if(var_0.brouteforward)
    var_0.curroutepoint = var_0.curregion.route_points.size;
  else
    var_0.curroutepoint = -1;

  if(var_7 >= 0 && var_7 < var_8)
    self.asm.customdata.arrivalangles = vectortoangles(var_0.curregion.route_points[var_7].origin - var_0.curregion.route_points[var_6].origin);

  return var_0.curregion.route_points[var_6].origin;
}

hunt_getpos() {
  var_0 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_1 = scripts\stealth\group::group_findpod(var_0, self);
  var_2 = undefined;

  if(isDefined(self.stealth.script_nexthuntpos)) {
    var_2 = self.stealth.script_nexthuntpos;
    self.stealth.script_nexthuntpos = undefined;
    hunt_clearroomdata();
  }

  if(!isDefined(var_2) && isDefined(var_1.origin) && !isDefined(var_1.borigininvestigated)) {
    if(hunt_shouldinvestigateorigin(var_1, self)) {
      var_2 = var_1.origin;
      var_1.borigininvestigated = 1;
      hunt_clearroomdata();
    }
  }

  if(!isDefined(var_2)) {
    hunt_updateregiontoclear();

    if(isDefined(self.stealth.cleardata))
      var_2 = hunt_getnextclearpos();
    else
      var_2 = scripts\stealth\group::group_getinvestigatepoint(self, level.stealth.hunt_volumes[self.script_stealthgroup]);
  }

  return var_2;
}

hunt_init() {
  self.combatmode = "no_cover";
  scripts\stealth\enemy::set_sight_state("hunt");
  scripts\stealth\enemy::set_alert_level("combat_hunt");

  if(isDefined(self.fnstealthflashlighton))
    self[[self.fnstealthflashlighton]]();

  self.stealth.binitialhunt = 1;
  self.diequietly = 1;
  self.allowturn45 = 1;
  self.last_set_goalnode = undefined;
  self.last_set_goalent = undefined;
  var_0 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_1 = scripts\stealth\group::group_findpod(var_0, self);

  if(isDefined(var_1.borigininvolume) && !var_1.borigininvolume) {
    self setbtgoalvolume(0, level.stealth.hunt_volumes[self.script_stealthgroup]);

    if(isDefined(self.script_combatmode))
      self.combatmode = self.script_combatmode;
    else
      self.combatmode = "cover";
  }

  if(!self isinscriptedstate()) {
    if(istrue(self.stealthforcegundown))
      self.gunposeoverride_internal = "gun_down";
    else
      self.gunposeoverride_internal = "ready";
  }
}

hunt_updateeveryframe(var_0) {
  return anim.success;
}

hunt_initialdelay_init(var_0) {
  self.bt.instancedata[var_0] = gettime() + randomintrange(500, 1500);
}

hunt_initialdelay(var_0) {
  if(!isDefined(self.stealth.binitialhunt) || isDefined(scripts\asm\asm_bb::bb_getcovernode()) || gettime() >= self.bt.instancedata[var_0])
    return anim.success;

  return anim.running;
}

hunt_initialdelay_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

hunt_cqbtargetupdate(var_0) {
  var_1 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_2 = scripts\stealth\group::group_findpod(var_1, self);

  if(isDefined(var_2.target)) {
    var_3 = gettime();

    if(self cansee(var_2.target) || self getthreatsight(var_2.target) > 0.1) {
      self.cqb_target = var_2.target.origin;
      var_0.cqbtargettime = var_3;
      return 1;
    } else if(issentient(var_2.target) && (isDefined(self.stealth.btargetlastknown) || isDefined(var_0.cqbtargettime) && var_3 - var_0.cqbtargettime < 2000)) {
      self.cqb_target = self lastknownpos(var_2.target);
      return 1;
    }
  }

  var_4 = anglesToForward(self.angles);
  self.cqb_target = self.origin + var_4 * 384;
  return 0;
}

hunt_shouldhunker(var_0) {
  var_1 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_2 = scripts\stealth\group::group_findpod(var_1, self);

  if(istrue(var_2.bhunkering))
    return anim.success;

  return anim.failure;
}

hunt_hunker_init(var_0) {
  var_1 = gettime();
  var_2 = spawnStruct();
  var_2.nextcoverchecktime = var_1 + randomintrange(4000, 6000);
  self.bt.instancedata[var_0] = var_2;
  self.stealth.hunthunkerlastexposetime = var_1;
  scripts\stealth\utility::set_patrol_style("cqb");
  var_3 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var_4 = scripts\stealth\group::group_findpod(var_3, self);
  var_5 = self findbestcovernode(undefined, 0, var_4.origin);

  if(isDefined(var_5)) {
    if(!isDefined(self.node) || self.node != var_5) {
      self.keepclaimednode = 0;
      self.keepclaimednodeifvalid = 0;
      self usecovernode(var_5);
    }
  }
}

hunt_hunker(var_0) {
  var_1 = gettime();

  if(var_1 > self.bt.instancedata[var_0].nextcoverchecktime) {
    var_2 = scripts\stealth\group::getgroup(self.script_stealthgroup);
    var_3 = scripts\stealth\group::group_findpod(var_2, self);
    var_4 = randomint(3) < 1;
    var_5 = self findbestcovernode("cover_hunt_hunker", var_4, var_3.origin);

    if(isDefined(var_5)) {
      var_6 = 0;

      if(!isDefined(self.node) || self.node != var_5) {
        self.keepclaimednode = 0;
        self.keepclaimednodeifvalid = 0;
        var_6 = !self usecovernode(var_5);
      }

      if(var_6)
        self.bt.instancedata[var_0].nextcoverchecktime = var_1 + 500;
      else
        self.bt.instancedata[var_0].nextcoverchecktime = var_1 + randomintrange(4000, 6000);
    } else
      self.bt.instancedata[var_0].nextcoverchecktime = var_1 + randomintrange(2000, 4000);
  }

  hunt_cqbtargetupdate(self.bt.instancedata[var_0]);
  return anim.running;
}

hunt_hunker_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

hunt_hunker_shouldexpose(var_0) {
  var_1 = 5000;

  if(!isinlight(self.lightmeter))
    var_1 = 3000;

  if(gettime() > self.stealth.hunthunkerlastexposetime + var_1)
    return anim.success;

  return anim.failure;
}

hunt_hunker_expose_init(var_0) {
  var_1 = spawnStruct();
  var_1.endtime = gettime() + 4000;
  var_1.nextpostime = 0;
  var_1.nextposidx = 0;
  self.bt.instancedata[var_0] = var_1;
  scripts\asm\asm_bb::bb_requestcoverstate("exposed");

  if(scripts\engine\utility::isnodecoverleft(self.node) || scripts\engine\utility::isnodecoverright(self.node))
    scripts\asm\asm_bb::bb_requestcoverexposetype("B");
  else
    scripts\asm\asm_bb::bb_requestcoverexposetype("exposed");

  self.stealth.btargetlastknown = 1;
}

hunt_hunker_expose(var_0) {
  var_1 = gettime();
  var_2 = self.bt.instancedata[var_0];

  if(var_1 > var_2.endtime)
    return anim.success;

  return anim.running;
}

hunt_hunker_expose_terminate(var_0) {
  self.cqb_target = undefined;
  self.bt.instancedata[var_0] = undefined;
  scripts\asm\asm_bb::bb_requestcoverstate("hide");
  self.stealth.btargetlastknown = undefined;
  self.stealth.hunthunkerlastexposetime = gettime();
}

hunt_isincover(var_0) {
  if(!isDefined(self.node))
    return anim.failure;

  var_1 = 16;

  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > var_1)
      return anim.failure;
  } else if(self.keepclaimednodeifvalid)
    var_1 = 3600;
  else
    var_1 = 225;

  if(distance2dsquared(self.node.origin, self.origin) > var_1)
    return anim.failure;

  return anim.success;
}

hunt_active_terminate(var_0) {
  scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
}

hunt_move_init(var_0) {
  var_1 = gettime();
  var_2 = spawnStruct();
  self.bt.instancedata[var_0] = var_2;
  var_2.starttime = var_1;
  var_3 = hunt_getpos();
  self setbtgoalpos(0, var_3);
  var_2.goalpos = var_3;
  var_2.numfails = 0;
  var_4 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(var_4)) {
    scripts\smartobjects\utility::setcustomsmartobjectarrivaldata(var_4);
    self setbtgoalRadius(0, 12);
  } else {
    if(!isDefined(self.asm.customdata.arrivalangles))
      self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var_3);

    self setbtgoalRadius(0, 36);
  }

  scripts\stealth\utility::set_patrol_style("cqb");
  self.disablelookdownpath = 1;
  var_2.enablelookdownpathtime = var_1 + 2000;
}

hunt_sidechecks(var_0) {
  var_1 = 36;
  var_2 = 36;
  var_3 = 36;
  var_4 = gettime();
  var_5 = 2000;

  if(isDefined(var_0.cornerchecknode) && var_4 >= var_0.cornerchecknodestarttime + var_5) {
    var_0.cornerchecknode = undefined;
    var_0.cornerchecknodestarttime = undefined;
    self._blackboard.forcestrafe = 0;
    self._blackboard.forcestrafefacingpos = undefined;
    scripts\stealth\utility::set_patrol_style("cqb");
    self.disablelookdownpath = undefined;
  }

  if(!isDefined(var_0.cornerchecknode) && !self.arriving && self.lookaheaddist > 32 && self pathdisttogoal() > 128) {
    var_6 = self getposonpath(var_1);
    var_7 = anglesToForward(self.angles);
    var_8 = getnodesinradius(var_6, var_3, 0, 60, "Cover");

    if(var_8.size > 0) {
      foreach(var_10 in var_8) {
        if(!var_10 doesnodeallowstance("stand")) {
          continue;
        }
        var_11 = var_10.origin - self.origin;

        if(vectordot(var_11, var_7) < 0) {
          continue;
        }
        var_12 = angleclamp180(var_10.angles[1] - self.angles[1]);

        if(var_12 > 0 && var_10.type != "Cover Right")
          continue;
        else if(var_12 < 0 && var_10.type != "Cover Left") {
          continue;
        }
        var_13 = anglesToForward(var_10.angles);
        var_14 = vectordot(var_13, var_7);

        if(var_14 > 0.5 || var_14 < -0.5) {
          continue;
        }
        if(abs(angleclamp180(self.angles[1] - var_10.angles[1])) < 45) {
          continue;
        }
        if(vectordot(self.lookaheaddir, var_11) > 32) {
          continue;
        }
        var_0.cornerchecknode = var_10;
        var_0.cornerchecknodestarttime = var_4;
        break;
      }
    }
  }

  if(isDefined(var_0.cornerchecknode)) {
    var_17 = var_0.cornerchecknode;
    var_18 = undefined;
    var_19 = anglestoaxis(var_17.angles);
    var_20 = var_19["right"];

    if(var_17.type == "Cover Left")
      var_20 = -1 * var_20;

    var_21 = 20;
    var_22 = var_17.origin + var_21 * var_19["forward"] + var_21 * var_20;
    var_23 = self.origin - var_17.origin;

    if(vectordot(var_23, var_20) < var_21)
      var_18 = var_22;
    else
      var_18 = self.origin + rotatevector((128, 0, 0), var_17.angles);

    self._blackboard.forcestrafe = 1;
    self._blackboard.forcestrafefacingpos = var_18;
    scripts\engine\utility::set_movement_speed(30);
    self.disablelookdownpath = 1;
  }
}

hunt_move(var_0) {
  var_1 = self.bt.instancedata[var_0];
  var_2 = gettime();
  var_3 = scripts\asm\asm_bb::bb_smartobjectrequested();

  if(self.arriving && var_3 && distancesquared(self.goalpos, self.origin) < 225)
    scripts\asm\asm_bb::bb_requestplaysmartobject();

  if(isdonewithsearchmove(var_1))
    return anim.success;

  if(scripts\asm\asm::asm_ephemeraleventfired("hunt", "knownpos") && (!isDefined(self.stealth.lastephemeraleventrespondedtime) || var_2 > self.stealth.lastephemeraleventrespondedtime)) {
    if(var_3)
      scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());

    return anim.success;
  }

  if(hunt_shouldhunker() == anim.success) {
    if(var_3)
      scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());

    return anim.success;
  }

  if(isDefined(var_1.enablelookdownpathtime) && var_2 > var_1.enablelookdownpathtime) {
    self.disablelookdownpath = undefined;
    var_1.enablelookdownpathtime = undefined;
  }

  if(isDefined(self.pathgoalpos) && (self.arrivalfailed || !self.facemotion) && var_3 && self pathdisttogoal() < 56) {
    self._blackboard.forcestrafe = 1;
    var_4 = scripts\asm\asm_bb::bb_getrequestedsmartobject();
    self._blackboard.forcestrafefacingpos = var_4.origin + rotatevector((128, 0, 0), var_4.angles);
  } else
    hunt_sidechecks(var_1);

  if(isDefined(self.stealth.cleardata) && isDefined(self.stealth.cleardata.curregion))
    scripts\stealth\clear_regions::hunttrytoenterregionvolume(self.stealth.cleardata.curregion);

  hunt_cqbtargetupdate(var_1);
  return anim.running;
}

hunt_move_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;

  if(isDefined(self.stealth.breacting))
    self.stealth.binitialhunt = 1;
  else
    self.stealth.binitialhunt = undefined;

  self.cqb_target = undefined;
  self.asm.customdata.arrivalangles = undefined;
  self.asm.customdata.arrivalstate = undefined;
  self.asm.customdata.arrivalusefootdown = undefined;
  self.disablelookdownpath = undefined;
  self._blackboard.forcestrafe = 0;
  self._blackboard.forcestrafefacingpos = undefined;
}

hunt_lookaround_init(var_0) {
  var_1 = 8000;
  var_2 = spawnStruct();
  var_2.endtime = gettime() + var_1;

  if(isDefined(self.stealth.script_huntlookaroundduration))
    var_2.endtime = gettime() + self.stealth.script_huntlookaroundduration;

  self.bt.instancedata[var_0] = var_2;
  self setbtgoalpos(0, self getnavposition());
  self setbtgoalRadius(0, 36);

  if(istrue(self.stealth.script_skiplookaroundanim)) {
    if(isDefined(self.stealth.script_huntlookaroundduration))
      self.stealth.binvestigatelookaround = 0;
  } else
    self.stealth.binvestigatelookaround = 1;
}

hunt_lookaround(var_0) {
  if(isDefined(self.stealth.binitialhunt))
    return anim.success;

  if(gettime() > self.bt.instancedata[var_0].endtime)
    return anim.success;

  if(scripts\asm\asm::asm_ephemeraleventfired("hunt", "knownpos") || scripts\asm\asm::asm_ephemeraleventfired("investigate_look", "end") || !isDefined(self.stealth.binvestigatelookaround)) {
    self.stealth.lastephemeraleventrespondedtime = gettime();
    return anim.success;
  }

  var_1 = isDefined(self.cqb_target);
  var_2 = hunt_cqbtargetupdate(self.bt.instancedata[var_0]);

  if(!var_1 && isDefined(self.cqb_target) && var_2) {
    self.stealth.binvestigatelookaround = undefined;
    var_3 = self.cqb_target;

    if(!isvector(self.cqb_target))
      var_3 = self.cqb_target.origin;

    scripts\stealth\utility::set_patrol_react(var_3, "small");
  }

  return anim.running;
}

hunt_lookaround_terminate(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self.stealth.binvestigatelookaround = undefined;
}

hunt_terminate() {
  self.stealth.binitialhunt = undefined;
  self.stealth.hunthunkerlastexposetime = undefined;
  self.diequietly = 0;
  self.moveplaybackrate = 1;
  self.allowturn45 = undefined;
  self.asm.customdata.arrivalangles = undefined;
  self.asm.customdata.arrivalstate = undefined;
  self.asm.customdata.arrivalusefootdown = undefined;
  hunt_clearroomdata();
  self.cqb_target = undefined;
  self clearbtgoal(0);
}

combat_init() {
  self.dontattackme = 0;
  self.diequietly = 0;
  self.bisincombat = 1;
  scripts\stealth\event::event_escalation_clear();

  if(isDefined(self.script_combatmode))
    self.combatmode = self.script_combatmode;
  else
    self.combatmode = "cover";

  scripts\stealth\enemy::set_sight_state("combat");
  var_0 = self.origin;

  if(istrue(self._blackboard.bflashlight)) {
    if(isDefined(self.fnstealthflashlighton))
      self[[self.fnstealthflashlighton]]();
  }

  var_1 = level.stealth.combat_volumes[self.script_stealthgroup];

  if(isDefined(var_1))
    self setbtgoalvolume(0, var_1);
  else if(isDefined(level.stealth.combat_goalradius) && isDefined(level.stealth.combat_goalradius[self.script_stealthgroup])) {
    self setbtgoalpos(0, self.scriptgoalpos);
    self setbtgoalRadius(0, level.stealth.combat_goalradius[self.script_stealthgroup]);
  }

  self forceupdategoalpos();

  if(isDefined(self.stealth.funcs["spotted"]))
    scripts\stealth\callbacks::stealth_call_thread("spotted");

  scripts\common\gameskill::grenadeawareness();
  scripts\aitypes\cover::requestcoverfind(0, 0, undefined);
  self.gunposeoverride_internal = undefined;
}

combat_terminate() {
  self clearbtgoal(0);
}

clearstealthvolume() {
  if(isDefined(level.stealth.combat_volumes[self.script_stealthgroup]) && iscombating() || isDefined(level.stealth.hunt_volumes[self.script_stealthgroup]) && ishunting())
    self clearbtgoal(0);
}

setstealthstate(var_0, var_1) {
  if(!scripts\engine\utility::flag("stealth_enabled") || !isDefined(self.stealth)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  switch (var_0) {
    case "idle":
      self.dontattackme = 1;
      self.diequietly = 1;

      if(istrue(self.stealth.blind))
        scripts\stealth\enemy::set_sight_state("blind");
      else
        scripts\stealth\enemy::set_sight_state("hidden");

      var_2 = scripts\stealth\group::getgroup(self.script_stealthgroup);
      scripts\stealth\group::group_removefrompod(var_2, self);
      enterstealthstate(0);
      self notify("stealth_idle");
      break;
    case "investigate":
      if(var_1.type == "cover_blown")
        self.stealth.bcoverhasbeenblown = 1;

      if(self.stealth.bsmstate == 1) {
        if(isPlayer(self.stealth.investigate_entity) && !isPlayer(var_1.entity) && var_1.typeorig != "saw_corpse") {
          break;
        }

        if(isDefined(self.stealth.investigate_severity)) {
          if(self.stealth.investigateevent.typeorig == "saw_corpse" && var_1.typeorig == "found_corpse" && var_1.entity == self.stealth.investigate_entity) {
            break;
          }

          var_3 = scripts\stealth\event::event_severity_compare(self.stealth.investigate_severity, var_1.type);

          if(var_3 >= 0) {
            self.stealth.investigate_severity = var_1.type;
            self.stealth.investigate_entity = var_1.entity;
            self.stealth.investigateevent = var_1;
          }

          var_4 = gettime();
          var_5 = var_3 > 0 || var_4 > self.stealth.investigateevent_time || distancesquared(var_1.investigate_pos, self.origin) < distancesquared(self.stealth.investigateevent.investigate_pos, self.origin);

          if(var_5) {
            var_2 = scripts\stealth\group::getgroup(self.script_stealthgroup);
            var_6 = scripts\stealth\group::group_findpod(var_2, self);
            var_7 = scripts\stealth\group::group_trytojoinexistingpod(var_2, var_6, 1, self, var_1.investigate_pos);

            if(isDefined(var_7))
              var_6 = var_7;

            var_6 scripts\stealth\group::pod_updateinvestigateorigin(self, var_1.investigate_pos);
            self.stealth.investigateevent_time = var_4;
          }

          self.stealth.investigateendtime = undefined;
        }
      } else {
        if(var_1.type == "cover_blown")
          scripts\stealth\group::group_eventcoverblown(self.script_stealthgroup, self, var_1);
        else
          scripts\stealth\group::group_eventinvestigate(self.script_stealthgroup, self, var_1);

        self.stealth.investigateevent = var_1;
        self.stealth.investigateevent_time = gettime();
        enterstealthstate(1);
        self notify("stealth_investigate");
      }

      break;
    case "hunt":
      self.stealth.bcoverhasbeenblown = 1;
      scripts\stealth\group::group_eventhunt(self.script_stealthgroup, self);
      enterstealthstate(2);
      self notify("stealth_hunt");
      break;
    case "combat":
      if(self.stealth.bsmstate != 3) {
        var_8 = isDefined(var_1) && var_1.typeorig == "damage" && self.allowpain && self.allowpain_internal && !self isinscriptedstate();

        if(isDefined(var_1) && !var_8) {
          var_9 = "small";

          switch (var_1.typeorig) {
            case "proximity":
              var_9 = "smed";
              break;
            case "projectile_impact":
            case "gunshot":
            case "ally_killed":
            case "ally_damaged":
            case "bulletwhizby":
              var_9 = "med";
              break;
            case "grenade danger":
            case "explode":
              var_9 = "large";
              break;
            case "light_killed":
            case "attack":
            case "combat":
              if(distancesquared(var_1.investigate_pos, self.origin) < 40000)
                var_9 = "med";

              break;
          }

          var_10 = self.enemy;

          if(!isDefined(var_10) && isDefined(var_1.entity) && issentient(var_1.entity))
            var_10 = var_1.entity;

          if(var_9 == "small" && isDefined(var_10)) {
            if(self cansee(var_10))
              var_9 = "med";
            else if(var_1.typeorig == "sight")
              var_9 = "smed";
          }

          scripts\stealth\utility::set_patrol_style("combat", 1, var_1.investigate_pos, var_9);
        } else
          scripts\stealth\utility::set_patrol_style("combat");

        if(isDefined(var_1) && var_8 && istrue(self.asm.flashlight))
          scripts\asm\soldier\patrol::detachflashlight();
      }

      self.stealth.bcoverhasbeenblown = 1;
      var_10 = undefined;

      if(isDefined(var_1) && isDefined(var_1.entity)) {
        if(issentient(var_1.entity) && var_1.entity.team == self.team) {
          if(isDefined(var_1.entity.enemy) && issentient(var_1.entity.enemy))
            self copyenemyinfo(var_1.entity);
        } else
          var_10 = var_1.entity;
      }

      scripts\stealth\group::group_eventcombat(self.script_stealthgroup, self, var_10);
      enterstealthstate(3);
      self notify("stealth_combat");
      break;
  }
}