/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\stealth.gsc
***********************************************/

function initstealthfunctions() {
  self.fnsetstealthstate = &setstealthstate;
  self.fnisinstealthidle = &isidle;
  self.fnisinstealthinvestigate = &isinvestigating;
  self.fnisinstealthhunt = &ishunting;
  self.fnisinstealthcombat = &iscombating;
  self.fnisinstealthidlescriptedanim = &isidlescriptedanim;
  self.fnstealthupdatevisionforlighting = &updatevisionforlighting;
  self.fnstealthisidlecurious = &isidlecurious;
  self.fnclearstealthvolume = &clearstealthvolume;
  self.fnstealthflashlightdetach = &scripts\asm\soldier\patrol::detachflashlight;
}

function ifinstealth(var0) {
  if(!isDefined(self.stealth)) {
    return anim.failure;
  }

  if(self.team == "allies") {
    return anim.failure;
  }

  if(self.stealth.bsmstate == 3) {
    return anim.failure;
  }

  return anim.success;
}

function isidlescriptedanim() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 0 && isDefined(self._blackboard.idlenode);
}

function isidle() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 0;
}

function isinvestigating() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 1;
}

function ishunting() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 2;
}

function iscombating() {
  return isDefined(self.stealth) && self.stealth.bsmstate == 3;
}

function stealth_shouldfriendly(var0) {
  if(self.team == "allies") {
    return anim.success;
  }

  return anim.failure;
}

function stealth_initfriendly(var0) {
  scripts\stealth\friendly::main();
  return anim.success;
}

function stealth_terminatefriendly(var0) {
  self.stealth = undefined;
}

function stealth_shouldneutral(var0) {
  if(self.team == "neutral") {
    return anim.success;
  }

  return anim.failure;
}

function stealth_initneutral(var0) {
  scripts\stealth\neutral::main();
  return anim.success;
}

function isinlight(var0) {
  if(!isDefined(var0)) {
    return !istrue(level.is_dark);
  }

  return var0 >= 0.5;
}

function updatevisionforlighting() {}

function forceflashlightplayercanseeifnecessary() {
  if(isDefined(self.flashlight) && self.flashlight) {
    var0 = 0.1;

    foreach(var2 in level.players) {
      if(isDefined(var2.nvg) && isDefined(var2.nvg.lightmeter) && var2.nvg.lightmeter > var0 && isDefined(var2.nvg.prevlightmeter) && var2.nvg.lightmeter - var2.nvg.prevlightmeter > 0.01) {
        if(self aipointinfov(var2.origin) && !self cansee(var2)) {
          self cansee(var2, 0);
        }
      }
    }

    return;
  }
}

function stealth_enemy_getbsmstate(var0) {
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

function stealth_reacter_updateeveryframe(var0) {
  scripts\stealth\enemy::proximity_check();
  return anim.success;
}

function stealth_enemy_updateeveryframe(var0) {
  var1 = scripts\engine\utility::ent_flag_exist("react_to_dynolights") && scripts\engine\utility::ent_flag("react_to_dynolights");

  if(var1 && !isDefined(self.lightmeter)) {
    scripts\stealth\utility::update_light_meter();
    var1 = 0;
  }

  updatelightbasedflashlight(self.stealth.bsmstate, 0.5);

  if(var1) {
    var2 = self getentitynumber();
    var3 = level.frameduration;

    if(gettime() / var3 % 5 == var2 % 5) {
      scripts\stealth\utility::update_light_meter();
    }
  }

  forceflashlightplayercanseeifnecessary();
  return stealth_reacter_updateeveryframe(var0);
}

function stealth_neutral_updateeveryframe(var0) {
  return stealth_reacter_updateeveryframe(var0);
}

function enterstealthstate(var0) {
  exitstealthstate(self.stealth.bsmstate);
  self.stealth.bsmstate = var0;

  switch (var0) {
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

function exitstealthstate(var0) {
  switch (var0) {
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

function isdonewithsearchmove(var0) {
  var1 = gettime();

  if(var1 > var0.starttime + 500 && (!isDefined(self.pathgoalpos) || distance2dsquared(self.pathgoalpos, self.origin) < 4) && !self.arriving && !isDefined(self._blackboard.doortoopen)) {
    if(!isDefined(var0.goalpos)) {
      return true;
    }

    if(distance2dsquared(self.origin, var0.goalpos) < 3600 && squared(var0.goalpos[2] - self.origin[2]) < 5184) {
      return true;
    }

    var0.numfails++;
    var0.starttime = var1;

    if(var0.numfails >= 10) {
      return true;
    }
  }

  return false;
}

function updatelightbasedflashlight(var0, var1) {
  if(self isinscriptedstate()) {
    return;
  }

  if(gettime() == self.starttime) {
    return;
  }

  var2 = self.lightmeter;

  if(isDefined(self._blackboard.bflashlight)) {
    var3 = self._blackboard.bflashlight;
  } else {
    var3 = 0;
  }

  if(isDefined(self.flashlightoverride)) {
    self._blackboard.bflashlight = self.flashlightoverride;
  } else if(istrue(self.noflashlight)) {
    self._blackboard.bflashlight = 0;
  } else if(isDefined(var3)) {
    var4 = 0.1;

    if(istrue(self._blackboard.bflashlight)) {
      if(var3 > var2 + var4) {
        self._blackboard.bflashlight = 0;
      }
    } else {
      self._blackboard.bflashlight = var3 < var2;
    }
  } else if(istrue(level.is_dark)) {
    self._blackboard.bflashlight = 1;
  } else {
    self._blackboard.bflashlight = 0;
  }

  if(var3 != self._blackboard.bflashlight) {
    if(scripts\asm\asm::asm_getdemeanor() != "patrol" && (!isDefined(self.asm.flashlight) || !self.asm.flashlight)) {
      if(self._blackboard.bflashlight) {
        self[[self.fnstealthflashlighton]]();
        return;
      }

      self[[self.fnstealthflashlightoff]]();
      return;
    }

    return;
  }
}

function idle_updatestyle(var0) {
  scripts\stealth\enemy::setpatrolstyle_base();
  var0.nextstylechecktime = gettime() + randomintrange(500, 2000);

  if(isDefined(self.stealth.patrol_moveplaybackrate)) {
    self.moveplaybackrate = self.stealth.patrol_moveplaybackrate;
    return;
  }

  self.moveplaybackrate = 1;
}

function isidlecurious() {
  return isDefined(self.stealth.bidlecurious) && self.stealth.bidlecurious;
}

function idle_updatecurious(var0) {
  var1 = undefined;
  var2 = 0;

  foreach(var4 in level.players) {
    var5 = self getthreatsight(var4);

    if(!isDefined(var1) || var5 > var2) {
      var1 = var4;
      var2 = var5;
    }
  }

  var5 = var2;
  var7 = 0.25;

  if(self.stealth.bidlecurious) {
    var8 = 2000;

    if(var5 >= var7) {
      var0.curiousstarttime = gettime();
    }

    if(gettime() > var0.curiousstarttime + var8) {
      if(var5 < var7 * 0.9) {
        self.stealth.bidlecurious = 0;
        self.stealth.idlecurioustarget = undefined;

        if(!isDefined(self.pathgoalpos) && isDefined(var0.idlenode)) {
          self._blackboard.idlenode = var0.idlenode;
          return;
        }

        return;
      }

      return;
    }

    return;
  }

  if(var5 >= var7) {
    self.stealth.bidlecurious = 1;
    self.stealth.idlecurioustarget = var1;
    var0.curiousstarttime = gettime();
    var0.idlenode = self._blackboard.idlenode;
    self._blackboard.idlenode = undefined;
    scripts\stealth\utility::set_patrol_react(var1.origin, "small");
    return;
  }
}

function updatesightstate(var0) {
  if(scripts\engine\utility::flag("stealth_spotted")) {
    var0 = "hunt";
  }

  var1 = !isDefined(self.stealth.threat_sight_state);

  if(!var1) {
    switch (self.stealth.threat_sight_state) {
      case "combat_hunt":
        var1 = var0 != "hunt" && var0 != "combat_hunt";
        break;
      case "spotted":
        var1 = var0 != "combat" && var0 != "spotted";
        break;
      case "hidden":
        var1 = var0 != "idle" && var0 != "unaware" && var0 != "hidden";
        break;
      default:
        var1 = self.stealth.threat_sight_state != var0;
        break;
    }
  }

  if(var1) {
    scripts\stealth\enemy::set_sight_state(var0);
    return;
  }
}

function idle_init(var0) {
  self.bt.instancedata[var0] = spawnStruct();
  self.favoriteenemy = undefined;
  self.dontattackme = 1;
  self.shootposoverride = undefined;
  self.stealth.reachedinvestigate = 0;
  thread scripts\stealth\corpse::corpse_clear();
  idle_updatestyle(self.bt.instancedata[var0]);
  self.combatmode = "no_cover";

  foreach(var2 in level.players) {
    if(!isDefined(var2.stealth)) {
      continue;
    }

    if(!isDefined(var2.stealth.spotted_list)) {
      continue;
    }

    var2.stealth.spotted_list[self.unique_id] = undefined;
  }

  self.diequietly = 1;
  self clearenemy();
  self.stealth.bidlecurious = 0;
  self.bt.instancedata[var0].curiousstarttime = -1;
  thread scripts\stealth\enemy::set_alert_level("reset");
  scripts\stealth\event::event_escalation_clear();

  if(isDefined(self.stealth.funcs["hidden"])) {
    scripts\stealth\callbacks::stealth_call_thread("hidden");
  }

  if(isDefined(self.target)) {
    self.goalradius = 32;

    if(isDefined(self.fnstealthgotonode)) {
      self thread[[self.fnstealthgotonode]](undefined, undefined, undefined);
    }
  }

  self.gunposeoverride_internal = "gun_down";
}

function idle_update(var0) {
  scripts\stealth\corpse::corpse_sight();

  if(istrue(self.stealth.blind)) {
    updatesightstate("blind");
  } else {
    updatesightstate("hidden");
  }

  if(isDefined(self.stealth.active_sense_funcs)) {
    foreach(var2 in self.stealth.active_sense_funcs) {
      self[[var2]]();
    }
  }

  var4 = gettime();

  if(var4 >= self.bt.instancedata[var0].nextstylechecktime) {
    idle_updatestyle(self.bt.instancedata[var0]);
  }

  idle_updatecurious(self.bt.instancedata[var0]);
  idle_updateflashlighttarget();
  return anim.running;
}

function idle_terminate(var0) {
  self.diequietly = 0;
  self.stealth.bidlecurious = undefined;
  self.stealth.idlecurioustarget = undefined;
  self._blackboard.idlenode = undefined;

  if(self.stealth.bsmstate != 1) {
    self.cqb_target = undefined;
  }

  scripts\stealth\utility::save_last_goal();
  self.last_set_goalnode = undefined;
  self.last_set_goalent = undefined;
  self.moveplaybackrate = 1;
  self.bt.instancedata[var0] = undefined;
}

function idle_updateflashlighttarget() {
  if(!isDefined(self._blackboard.bflashlight) || !self._blackboard.bflashlight) {
    self.cqb_target = undefined;
    return;
  }

  if(self.stealth.bidlecurious && isDefined(self.stealth.idlecurioustarget)) {
    self.cqb_target = self lastknownpos(self.stealth.idlecurioustarget);
    return;
  }

  var0 = 0;

  foreach(var2 in level.players) {
    if(self getthreatsight(var2) > 0.1) {
      self.cqb_target = self lastknownpos(var2);
      var0 = 1;
      break;
    }
  }

  if(!var0) {
    var4 = anglesToForward(self.angles);
    self.cqb_target = self.origin + var4 * 128;
    return;
  }
}

function stealth_shouldinvestigate(var0) {
  if(self.stealth.bsmstate == 1) {
    return anim.success;
  }

  return anim.failure;
}

function findclosestlospointwithin(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var3)) {
    var7 = findclosestpointbyapproxpathdist(var3, var1, var2, var0.usedpoints, 48);

    if(isDefined(var7) && isDefined(var6) && var6 && !investigate_sanitycheckinitialpos(var1, var7)) {
      return undefined;
    }

    return var7;
  } else if(var6 > 64 && isDefined(var5)) {
    var7 = findopenlookdir(var5, var6, var2, var3, var1.usedpoints, 48);

    if(isDefined(var7) && isDefined(var7) && var7 && !investigate_sanitycheckinitialpos(var2, var7)) {
      return undefined;
    }

    return var7;
  }

  return getrandomnavpoint(var3, 200, self);
}

function investigate_sanitycheckinitialpos(var0, var1) {
  var2 = vectorNormalize(var0 - self.origin);
  var3 = var1 - self.origin;
  var4 = length(var3);

  if(var4 > 256) {
    var3 /= var4;

    if(vectordot(var3, var2) < -0.5) {
      return false;
    }
  }

  return true;
}

function investigate_getcorpseoffsetpos(var0) {
  var1 = var0 - self.origin;
  var2 = var0 - vectorNormalize(var1) * 32;
  var2 = getclosestpointonnavmesh(var2, self);
  return var2;
}

function investigate_getinitialpos() {
  var0 = 1;
  var1 = self.stealth.investigateevent;

  if(isDefined(self.stealth.investigate_point)) {
    var2 = getclosestpointonnavmesh(var1.investigate_pos, self);
    var3 = vectorNormalize(self.goalpos - self.origin);
    var4 = anglesToForward(self.angles);
    var5 = vectorNormalize(var2 - self.origin);

    if(isPlayer(var1.entity) && !isPlayer(self.stealth.investigate_entity)) {
      var0 = 1;
    } else if(vectordot(var3, var5) < 0 && vectordot(var4, var5) < 0) {
      var0 = 1;
    } else if(var1.typeorig == "saw_corpse") {
      var0 = 1;
    } else if(var0 && distancesquared(self.goalpos, var2) < squared(300)) {
      var0 = 0;
    }
  }

  if(var0) {
    var6 = level.stealth.investigate_volumes[self.script_stealthgroup];
    var7 = scripts\stealth\group::getgroup(self.script_stealthgroup);
    var8 = scripts\stealth\group::group_findpod(var7, self);
    var9 = 0;
    var10 = 0;
    var11 = 0;

    if(isDefined(var8.investigateoriginguy) && var8.investigateoriginguy == self || var8.members[0] == self) {
      var9 = 1;
    } else if(distancesquared(self.origin, var1.investigate_pos) < 16384) {
      var11 = 1;
    } else if(var8.members.size > 1 && var8.members[1] == self) {
      var10 = 1;
    }

    if(!isDefined(var8.usedpoints)) {
      var8.usedpoints = [];
      var8.usedpointsexpiry = [];
    }

    var12 = undefined;

    if(var9) {
      if(var1.typeorig == "saw_corpse" || distance2dsquared(self.origin, var1.investigate_pos) < 4096) {
        var12 = var1.investigate_pos;

        if(var1.typeorig == "saw_corpse") {
          var12 = investigate_getcorpseoffsetpos(var12);
        }

        if(isDefined(var6)) {
          var13 = self findlastpointonpathwithinvolume(var12, var6);

          if(isDefined(var13)) {
            var12 = var13;
          }
        }
      }

      if(!isDefined(var12)) {
        var12 = findclosestlospointwithin(var8, var1.investigate_pos, var1.investigate_pos, var6, self.scriptgoalpos, self.goalradius, 1);

        if(!isDefined(var12)) {
          if(isDefined(var6)) {
            var12 = self findlastpointonpathwithinvolume(var1.investigate_pos, var6);
          }

          if(!isDefined(var12)) {
            var12 = findclosestlospointwithin(var8, var1.investigate_pos, self.origin, var6, self.scriptgoalpos, self.goalradius, 1);
          }

          if(!isDefined(var12)) {
            var12 = self.origin;
          }
        }
      }
    } else if(var10) {
      var14 = randomfloatrange(0.7, 0.85);
      var12 = vectorlerp(self.origin, var1.investigate_pos, var14);
      var12 = findclosestlospointwithin(var8, var12, var12, var6, self.scriptgoalpos, self.goalradius);
    } else if(!var11) {
      var12 = findclosestlospointwithin(var8, var1.investigate_pos, self.origin, var6, self.scriptgoalpos, self.goalradius);
    }

    if(isDefined(var12) && !investigate_sanitycheckinitialpos(var1.investigate_pos, var12)) {
      var12 = undefined;
    }

    if(!isDefined(var12)) {
      var12 = investigate_getuninvestigatedpos();
    } else {
      scripts\stealth\group::pod_addusedpoint(var8, var12);
    }

    return var12;
  }
}

function investigate_getuninvestigatedpos() {
  var0 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var1 = scripts\stealth\group::group_findpod(var0, self);

  if(isDefined(var1.investigateoriginguy) && var1.investigateoriginguy == self) {
    var2 = undefined;

    if(isDefined(var1.volume)) {
      var2 = self findlastpointonpathwithinvolume(var1.origin, var1.volume);
    }

    if(!isDefined(var2)) {
      var2 = getclosestpointonnavmesh(var1.origin, self);
    }

    var1.investigateoriginguy = undefined;
  } else {
    var2 = scripts\stealth\group::group_getinvestigatepoint(self);
  }

  return var2;
}

function setinvestigateendtime() {
  var0 = 15;
  var1 = 20;

  if(isDefined(self.stealth.investigatemintime)) {
    var0 = self.stealth.investigatemintime;
  }

  if(isDefined(self.stealth.investigatemaxtime)) {
    var1 = self.stealth.investigatemaxtime;
  }

  self.stealth.investigateendtime = gettime() + randomintrange(var0, var1) * 1000;
}

function findgoodinvestigatelookdir(var0) {
  if(scripts\asm\asm_bb::bb_smartobjectrequested() && isDefined(self.asm.customdata.arrivalangles)) {
    return self.asm.customdata.arrivalangles;
  }

  if(istrue(self.limitstealthturning)) {
    return vectortoangles(var0 - self.origin);
  }

  var1 = makeweapon(var0, 256, 96);

  if(isDefined(var1)) {
    return vectortoangles(var1);
  }
}

function investigate_shouldfacedecentdirectionwhenidle() {
  return !istrue(self.limitstealthturning);
}

function investigate_init() {
  var0 = self.stealth.investigateevent;
  self.stealth.investigate_severity = var0.type;
  self.stealth.investigate_entity = var0.entity;
  self.script_forcegoal = 0;
  updatesightstate("investigate");
  self.diequietly = 1;

  if(investigate_shouldfacedecentdirectionwhenidle()) {
    self._blackboard.bfacesomedecentdirectionwhenidle = 1;
  }

  investigate_setreaction(var0);
  self.stealth.binitialinvestigate = 1;

  if(!self isinscriptedstate()) {
    if(istrue(self.stealthforcegundown)) {
      self.gunposeoverride_internal = "gun_down";
      return;
    }

    self.gunposeoverride_internal = "ready";
    return;
  }
}

function investigate_setreaction(var0) {
  var1 = "small";

  if(var0.typeorig == "bulletwhizby" || var0.typeorig == "grenade danger") {
    var1 = "med";
  } else if(var0.typeorig == "footstep_sprint") {
    if(isDefined(var0.entity) && isPlayer(var0.entity) && var0.entity scripts\stealth\threat_sight::player_is_sprinting_at_me(self)) {
      var1 = "med";
    }
  }

  scripts\stealth\utility::set_patrol_react(var0.investigate_pos, var1);
}

function investigate_updateeveryframe(var0) {
  scripts\stealth\corpse::corpse_sight();

  if(isDefined(self.enemy)) {
    self clearenemy();
  }

  updatesightstate("investigate");

  if(isDefined(self.stealth.active_sense_funcs)) {
    foreach(var2 in self.stealth.active_sense_funcs) {
      self[[var2]]();
    }
  }

  return anim.success;
}

function investigate_setupruntocorpse(var0, var1, var2) {
  scripts\stealth\utility::set_patrol_style("combat", var2, var1, "med");
  var0.nextstylecheck = gettime() + 100;
  var0.nextstylecheckdist = 256;
  var0.nextstylecheckinterval = 100;
  self.asm.customdata.arrivalangles = undefined;
}

function investigate_move_init(var0) {
  self.fovforward = self.alertlevelint <= 2;
  var1 = gettime();
  var2 = spawnStruct();
  var2.starttime = var1;
  var2.cqbtargetnexttwitchtime = var1 + randomintrange(2000, 4000);
  self.bt.instancedata[var0] = var2;
  var3 = self.stealth.investigateevent.typeorig;

  if(var3 == "saw_corpse") {
    if(isDefined(self.stealth.corpse.ent)) {
      var2.nextcorpsechecktime = var1 + 200;
    }
  } else if(var3 == "grenade danger") {
    self.grenadeawareness = 1;
    self.grenadereturnthrowchance = 0;
    scripts\stealth\utility::set_patrol_style("alert");
    return;
  }

  var4 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var5 = scripts\stealth\group::group_findpod(var4, self);

  if(self.stealth.binitialinvestigate) {
    var6 = investigate_getinitialpos();
  } else {
    var6 = investigate_getuninvestigatedpos();
  }

  if(isDefined(var6.needsupdate)) {
    var6.needsupdate = scripts\engine\utility::array_remove(var6.needsupdate, self);
  }

  if(isDefined(var6.investigateoriginguy) && var6.investigateoriginguy == self) {
    var6.investigateoriginguy = undefined;
  }

  if(isDefined(var6)) {
    self.stealth.investigate_point = var6;
    self setbtgoalpos(0, var6);
    self setbtgoalRadius(0, 24);
    var3.goalpos = var6;
    var3.numfails = 0;

    if(self.stealth.binitialinvestigate) {
      if(var4 == "saw_corpse" || var4 == "found_corpse") {
        investigate_setupruntocorpse(self.bt.instancedata[var1], var6, 1);
      } else if(var4 == "bulletwhizby") {
        scripts\stealth\utility::set_patrol_style("cqb");
        self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var6);
      } else {
        scripts\stealth\utility::set_patrol_style("alert");
        var7 = self.stealth.investigateevent.look_pos;

        if(!isDefined(var7)) {
          var7 = self.stealth.investigateevent.investigate_pos;
        }

        investigate_move_setaimtarget(var3, var7, var4);
        self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var6);
      }
    } else {
      scripts\stealth\utility::set_patrol_style("alert");
      self.moveplaybackrate = 1;
      self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var6);
    }

    if(distance2dsquared(self.origin, var6) < 1 && self.stealth.binitialinvestigate || !investigate_shouldfacedecentdirectionwhenidle()) {
      self._blackboard.bfacesomedecentdirectionwhenidle = undefined;
    } else {
      self._blackboard.bfacesomedecentdirectionwhenidle = 1;
    }
  }

  self.disablelookdownpath = 1;
  var3.enablelookdownpathtime = var2 + 2000;
}

function investigate_move_setaimtarget(var0, var1, var2) {
  var3 = 5000;

  if(isDefined(var2)) {
    switch (var2) {
      case "sight":
        var3 = 1000;
        break;
      case "light_killed":
      case "glass_destroyed":
        var3 = 3000;
        break;
    }
  }

  self.cqb_target = var1;
  var0.cqbtargetendtime = gettime() + var3;
}

function setuprandomlooktarget(var0) {
  var1 = 400;
  var0.cqbtwitching = 1;
  var0.cqbtwitchend = gettime() + var1;
  var0.cqbtwitchstate = 0;

  if(scripts\engine\utility::cointoss()) {
    var0.cqbtwitchdir = 1;
    return;
  }

  var0.cqbtwitchdir = -1;
}

function resetcqbtwitch(var0) {
  var0.cqbtargetnexttwitchtime = gettime() + randomintrange(2000, 4000);
  var0.cqbtwitching = undefined;
  var0.cqbtwitchend = undefined;
  var0.cqbtwitchstate = undefined;
  var0.cqbtwitchdir = undefined;
}

function updaterandomlooktarget(var0, var1) {
  var2 = 400;
  var3 = 1000;
  var4 = 20;
  var5 = anglesToForward(self.angles);
  var6 = gettime();

  switch (var0.cqbtwitchstate) {
    case 0:
      var7 = (var0.cqbtwitchend - var6) / var2;

      if(var7 > 0) {
        var8 = var4 * (1 - sin(var7 * 90)) * var0.cqbtwitchdir;
        self.cqb_target = self.origin + rotatevector(var5, (0, var8, 0)) * var1;
        break;
      } else {
        <
        error > .cqbtwitchend = var5 + var2; <
        error > .cqbtwitchstate++;
      }
    case 1:
      if(var5 < < error > .cqbtwitchend) {
        self.cqb_target = self.origin + rotatevector(var4, (0, var3 * < error > .cqbtwitchdir, 0)) * var0;
        break;
      } else {
        <
        error > .cqbtwitchend = var5 + var1; <
        error > .cqbtwitchstate++;
      }
    case 2:
      var7 = ( < error > .cqbtwitchend - var5) / var1;

      if(var7 > 0) {
        var8 = var3 * sin(var7 * 90) * < error > .cqbtwitchdir;
        self.cqb_target = self.origin + rotatevector(var4, (0, var8, 0)) * var0;
      } else {
        resetcqbtwitch( < error > );
      }

      break;
  }
}

function investigate_move_updateaimtarget(var0) {
  var1 = gettime();

  if(isDefined(var0.cqbtargetendtime)) {
    if(isDefined(self.cqb_target)) {
      var2 = self.cqb_target - self.origin;
      var3 = isDefined(self.stealth.patrol_react_magnitude) || isDefined(self.stealth.breacting);

      if(var1 > var0.cqbtargetendtime || !var3 && abs(self.angles[1], vectortoyaw(var2)) > 50) {
        self.cqb_target = undefined;
        var0.cqbtargetendtime = undefined;
        var0.cqbtargetnexttwitchtime = var1 + randomintrange(2000, 4000);
      }
    } else {
      var0.cqbtargetendtime = undefined;
      var0.cqbtargetnexttwitchtime = var1 + randomintrange(2000, 4000);
    }
  }

  if(!isDefined(var0.cqbtargetendtime)) {
    var4 = anglesToForward(self.angles);
    var5 = 0;

    foreach(var7 in level.players) {
      if(self getthreatsight(var7) > 0) {
        var5 = 1;
        resetcqbtwitch(var0);
        self.cqb_target = self lastknownpos(var7);
        break;
      }
    }

    if(!var5) {
      var9 = 400;
      var10 = 1000;
      var11 = 20;

      if(isDefined(var0.cqbtwitching)) {
        updaterandomlooktarget(var0, 78);
        return;
      }

      if(isDefined(var0.cqbtargetnexttwitchtime) && var1 > var0.cqbtargetnexttwitchtime) {
        var0.cqbtwitching = 1;
        var0.cqbtwitchend = var1 + var9;
        var0.cqbtwitchstate = 0;

        if(scripts\engine\utility::cointoss()) {
          var0.cqbtwitchdir = 1;
        } else {
          var0.cqbtwitchdir = -1;
        }

        updaterandomlooktarget(var0, 78);
        return;
      }

      self.cqb_target = self.origin + var4 * 78;
      return;
    }

    return;
  }
}

function investigate_move(var0) {
  if(self islinked()) {
    return anim.success;
  }

  if(self.stealth.investigateevent.typeorig == "grenade danger") {
    return anim.success;
  }

  var1 = gettime();
  var2 = self.bt.instancedata[var0];
  var3 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var4 = scripts\stealth\group::group_findpod(var3, self);
  var5 = scripts\asm\asm_bb::bb_smartobjectrequested();

  if(self.arriving && var5 && distancesquared(self.goalpos, self.origin) < 225) {
    scripts\asm\asm_bb::bb_requestplaysmartobject();
  }

  if(isDefined(var4.needsupdate) && scripts\engine\utility::array_contains(var4.needsupdate, self)) {
    var6 = investigate_getuninvestigatedpos();
    var4.needsupdate = scripts\engine\utility::array_remove(var4.needsupdate, self);
    self setbtgoalpos(0, var6);
    var7 = self.stealth.investigateevent.typeorig;

    if(var7 == "saw_corpse" || var7 == "found_corpse") {
      investigate_setupruntocorpse(var2, var6, 0);
    } else {
      var8 = gettime() > var2.starttime;
      var9 = "alert";
      var10 = "small";

      if(var7 == "bulletwhizby" || scripts\asm\asm::asm_getdemeanor() == "combat") {
        var9 = "cqb";
        var10 = "med";
      }

      if(istrue(self.stealth.binitialinvestigate) && isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, var6) < 576) {
        var8 = 0;
      }

      scripts\stealth\utility::set_patrol_style(var9, var8, var6, var10);
      var11 = self.stealth.investigateevent.look_pos;

      if(!isDefined(var11)) {
        var11 = self.stealth.investigateevent.investigate_pos;
      }

      investigate_move_setaimtarget(var2, var11, var7);
      self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var6);
      var2.nextcorpsechecktime = undefined;
    }
  }

  if(isDefined(var2.nextcorpsechecktime) && var1 > var2.nextcorpsechecktime) {
    if(isDefined(self.stealth.corpse.ent)) {
      var12 = self.stealth.corpse.ent scripts\stealth\utility::getcorpseorigin();
      var12 = investigate_getcorpseoffsetpos(var12);
      self setbtgoalpos(0, var12);
      var2.nextcorpsechecktime = var1 + 200;
    } else {
      var2.nextcorpsechecktime = undefined;
    }
  }

  if(isDefined(var2.enablelookdownpathtime) && var1 > var2.enablelookdownpathtime) {
    self.disablelookdownpath = undefined;
    var2.enablelookdownpathtime = undefined;
  }

  var13 = level.player;

  if(self cansee(var13)) {
    investigate_move_setaimtarget(var2, self lastknownpos(var13) + (0, 0, 32), "sight");
  }

  investigate_move_updateaimtarget(var2);

  if(isdonewithsearchmove(var2)) {
    return anim.success;
  }

  if(isDefined(var2.nextstylecheck) && var1 >= var2.nextstylecheck) {
    var14 = 512;

    if(isDefined(var2.nextstylecheckdist)) {
      var14 = var2.nextstylecheckdist;
    }

    if(self pathdisttogoal() > var14) {
      var15 = 1000;

      if(isDefined(var2.nextstylecheckinterval)) {
        var15 = var2.nextstylecheckinterval;
      }

      var2.nextstylecheck = var1 + var15;
    } else {
      scripts\stealth\utility::set_patrol_style("alert");
      var2.nextstylecheck = undefined;
    }
  }

  return anim.running;
}

function investigate_move_terminate(var0) {
  self.fovforward = 0;
  self.stealth.binitialinvestigate = 0;
  self.bt.instancedata[var0] = undefined;
  self.cqb_target = undefined;
  self.disablelookdownpath = undefined;
  self.stealth.bexaminerequested = undefined;
  scripts\stealth\corpse::corpse_clear();
}

function investigate_lookaround_init(var0) {
  var1 = spawnStruct();
  var1.failsafetimeout = gettime() + 8000;

  if(isDefined(self.stealth.scriptedinitialinvestigatedelay)) {
    var1.initialinvestigatetime = gettime() + self.stealth.scriptedinitialinvestigatedelay * 1000;
    self.stealth.scriptedinitialinvestigatedelay = undefined;
  }

  self.bt.instancedata[var0] = var1;
  self setbtgoalpos(0, self getnavposition());
  scripts\stealth\utility::set_patrol_style("alert");
  self.stealth.binvestigatelookaround = 1;

  if(!self.stealth.binitialinvestigate && !isDefined(self.stealth.investigateendtime)) {
    setinvestigateendtime();
    return;
  }
}

function investigate_lookaround(var0) {
  if(gettime() > self.bt.instancedata[var0].failsafetimeout) {
    return anim.success;
  }

  if(self.stealth.binitialinvestigate) {
    if(isDefined(self.bt.instancedata[var0].initialinvestigatetime) && gettime() < self.bt.instancedata[var0].initialinvestigatetime) {
      return anim.running;
    }

    return anim.success;
  }

  var1 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var2 = scripts\stealth\group::group_findpod(var1, self);

  if(isDefined(var2.needsupdate) && scripts\engine\utility::array_contains(var2.needsupdate, self)) {
    var2.needsupdate = scripts\engine\utility::array_remove(var2.needsupdate, self);
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("investigate_look", "end")) {
    return anim.success;
  }

  foreach(var4 in level.players) {
    if(self getthreatsight(var4) > 0.05) {
      return anim.failure;
    }
  }

  return anim.running;
}

function investigate_lookaround_terminate(var0) {
  self.bt.instancedata[var0] = undefined;
  self.stealth.binvestigatelookaround = 0;
}

function investigate_targetedlookaround(var0) {
  var1 = 0;

  foreach(var3 in level.players) {
    if(self getthreatsight(var3) > 0.05) {
      self.cqb_target = self lastknownpos(var3);
      var1 = 1;
      break;
    }
  }

  if(var1) {
    return anim.running;
  }

  var5 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var6 = scripts\stealth\group::group_findpod(var5, self);
  var6 scripts\stealth\group::pod_updateinvestigateorigin(self, self.cqb_target);
  return anim.success;
}

function investigate_terminate() {
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

function stealth_shouldhunt(var0) {
  if(self.stealth.bsmstate == 2) {
    return anim.success;
  }

  return anim.failure;
}

function hunt_shouldinvestigateorigin(var0, var1) {
  foreach(var3 in level.stealth.groupdata.groups) {
    foreach(var5 in var3.pods) {
      if(var5 == var0) {
        continue;
      }

      if(var5.state == 2 && isDefined(var5.borigininvestigated) && distance2dsquared(var0.origin, var5.origin) < 576) {
        var0.borigininvestigated = 1;
        return false;
      }
    }
  }

  return var0 scripts\stealth\group::pod_getclosestguy(var0.origin) == var1;
}

function hunt_updateregiontoclear() {
  if(!isDefined(self.stealth.cleardata) || !isDefined(self.stealth.cleardata.curregion)) {
    if(!isDefined(self.script_stealth_region_group) || !isDefined(level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group]) || level.stealth.hunt_stealth_group_region_sets[self.script_stealth_region_group].size == 0) {
      return;
    }

    var0 = scripts\stealth\clear_regions::getregionforpos(self.origin);

    if(!isDefined(var0)) {
      return;
    }

    if(!isDefined(self.stealth.cleardata)) {
      self.stealth.cleardata = spawnStruct();
    }

    var1 = self.stealth.cleardata;
    var1.prevregion = [];
    var1.prevregion[0] = var0;
    var1.prevregion[1] = var0;
    var1.isinregion = 0;
    scripts\stealth\clear_regions::huntassigntoregion(var0);
    var1.curroutepoint = scripts\stealth\clear_regions::findcurposonroute(self.origin, var0.route_points);
    var1.brouteforward = 1;
    return;
  }
}

function hunt_clearroomdata() {
  if(isDefined(self.stealth.cleardata)) {
    if(isDefined(self.stealth.cleardata.curregion)) {
      scripts\stealth\clear_regions::huntdecaiassignment(self.stealth.cleardata.curregion);
    }

    self.stealth.cleardata = undefined;
    return;
  }
}

function hunt_finddoorbetween(var0, var1) {
  foreach(var3 in var0.region_links) {
    if(var3.region == var1) {
      var4 = var3.transition_to_point.origin;

      for(var5 = 0; var5 < var1.route_points.size; var5++) {
        if(distancesquared(var1.route_points[var5].origin, var4) < 4) {
          return var5;
        }
      }
    }
  }
}

function hunt_getnextclearpos() {
  var0 = self.stealth.cleardata;
  var1 = undefined;

  for(var2 = 0; var2 < 2; var2++) {
    var3 = scripts\stealth\clear_regions::findnextpointofinterest(self.origin, var0.curregion, var0.curroutepoint, var0.brouteforward);

    if(isDefined(var3)) {
      var1 = var3[0];
      var0.curroutepoint = var3[1];
      break;
    }

    if(var2 == 1) {
      break;
    }

    var4 = var0.curregion;
    scripts\stealth\clear_regions::huntgetnextregion();
    var0.curroutepoint = 0;
    var0.brouteforward = 1;

    if(var4 != var0.curregion) {
      var5 = hunt_finddoorbetween(var4, var0.curregion);

      if(isDefined(var5)) {
        var0.curroutepoint = var5;
      } else {
        var0.curroutepoint = scripts\stealth\clear_regions::findcurposonroute(self.origin, var0.curregion.route_points);
      }

      if(var0.curroutepoint > var0.curregion.route_points.size * 0.5) {
        var0.brouteforward = 0;
      }
    }
  }

  if(isDefined(var1)) {
    self.asm.customdata.arrivalangles = var1.angles;
    scripts\smartobjects\utility::setsmartobject(var1);
    return var1.origin;
  }

  var6 = 0;
  var7 = 1;
  var8 = var0.curregion.route_points.size;

  if(var0.curroutepoint > var8 * 0.5) {
    var6 = var8 - 1;
    var7 = var6 - 1;
  }

  if(var0.brouteforward) {
    var0.curroutepoint = var0.curregion.route_points.size;
  } else {
    var0.curroutepoint = -1;
  }

  if(var7 >= 0 && var7 < var8) {
    self.asm.customdata.arrivalangles = vectortoangles(var0.curregion.route_points[var7].origin - var0.curregion.route_points[var6].origin);
  }

  return var0.curregion.route_points[var6].origin;
}

function hunt_getpos() {
  var0 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var1 = scripts\stealth\group::group_findpod(var0, self);
  var2 = undefined;

  if(isDefined(self.stealth.script_nexthuntpos)) {
    var2 = self.stealth.script_nexthuntpos;
    self.stealth.script_nexthuntpos = undefined;
    hunt_clearroomdata();
  }

  if(!isDefined(var2) && isDefined(var1.origin) && !isDefined(var1.borigininvestigated)) {
    if(hunt_shouldinvestigateorigin(var1, self)) {
      var2 = var1.origin;
      var1.borigininvestigated = 1;
      hunt_clearroomdata();
    }
  }

  if(!isDefined(var2)) {
    hunt_updateregiontoclear();

    if(isDefined(self.stealth.cleardata)) {
      var2 = hunt_getnextclearpos();
    } else {
      var2 = scripts\stealth\group::group_getinvestigatepoint(self, level.stealth.hunt_volumes[self.script_stealthgroup]);
    }
  }

  return var2;
}

function hunt_init() {
  self.combatmode = "no_cover";
  scripts\stealth\enemy::set_sight_state("hunt");
  scripts\stealth\enemy::set_alert_level("combat_hunt");

  if(isDefined(self.fnstealthflashlighton)) {
    self[[self.fnstealthflashlighton]]();
  }

  self.stealth.binitialhunt = 1;
  self.diequietly = 1;
  self.allowturn45 = 1;
  self.last_set_goalnode = undefined;
  self.last_set_goalent = undefined;
  var0 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var1 = scripts\stealth\group::group_findpod(var0, self);

  if(isDefined(var1.borigininvolume) && !var1.borigininvolume) {
    self setbtgoalvolume(0, level.stealth.hunt_volumes[self.script_stealthgroup]);

    if(isDefined(self.script_combatmode)) {
      self.combatmode = self.script_combatmode;
    } else {
      self.combatmode = "cover";
    }
  }

  if(!self isinscriptedstate()) {
    if(istrue(self.stealthforcegundown)) {
      self.gunposeoverride_internal = "gun_down";
      return;
    }

    self.gunposeoverride_internal = "ready";
    return;
  }
}

function hunt_updateeveryframe(var0) {
  return anim.success;
}

function hunt_initialdelay_init(var0) {
  self.bt.instancedata[var0] = gettime() + randomintrange(500, 1500);
}

function hunt_initialdelay(var0) {
  if(!isDefined(self.stealth.binitialhunt) || isDefined(scripts\asm\asm_bb::bb_getcovernode()) || gettime() >= self.bt.instancedata[var0]) {
    return anim.success;
  }

  return anim.running;
}

function hunt_initialdelay_terminate(var0) {
  self.bt.instancedata[var0] = undefined;
}

function hunt_cqbtargetupdate(var0) {
  var1 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var2 = scripts\stealth\group::group_findpod(var1, self);

  if(isDefined(var2.target)) {
    var3 = gettime();

    if(self cansee(var2.target) || self getthreatsight(var2.target) > 0.1) {
      self.cqb_target = var2.target.origin;
      var0.cqbtargettime = var3;
      return true;
    } else if(issentient(var2.target) && (isDefined(self.stealth.btargetlastknown) || isDefined(var0.cqbtargettime) && var3 - var0.cqbtargettime < 2000)) {
      self.cqb_target = self lastknownpos(var2.target);
      return true;
    }
  }

  var4 = anglesToForward(self.angles);
  self.cqb_target = self.origin + var4 * 384;
  return false;
}

function hunt_shouldhunker(var0) {
  var1 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var2 = scripts\stealth\group::group_findpod(var1, self);

  if(istrue(var2.bhunkering)) {
    return anim.success;
  }

  return anim.failure;
}

function hunt_hunker_init(var0) {
  var1 = gettime();
  var2 = spawnStruct();
  var2.nextcoverchecktime = var1 + randomintrange(4000, 6000);
  self.bt.instancedata[var0] = var2;
  self.stealth.hunthunkerlastexposetime = var1;
  scripts\stealth\utility::set_patrol_style("cqb");
  var3 = scripts\stealth\group::getgroup(self.script_stealthgroup);
  var4 = scripts\stealth\group::group_findpod(var3, self);
  var5 = self findbestcovernode(undefined, 0, var4.origin);

  if(isDefined(var5)) {
    if(!isDefined(self.node) || self.node != var5) {
      self.keepclaimednode = 0;
      self.keepclaimednodeifvalid = 0;
      self usecovernode(var5);
      return;
    }

    return;
  }
}

function hunt_hunker(var0) {
  var1 = gettime();

  if(var1 > self.bt.instancedata[var0].nextcoverchecktime) {
    var2 = scripts\stealth\group::getgroup(self.script_stealthgroup);
    var3 = scripts\stealth\group::group_findpod(var2, self);
    var4 = randomint(3) < 1;
    var5 = self findbestcovernode("cover_hunt_hunker", var4, var3.origin);

    if(isDefined(var5)) {
      var6 = 0;

      if(!isDefined(self.node) || self.node != var5) {
        self.keepclaimednode = 0;
        self.keepclaimednodeifvalid = 0;
        var6 = !self usecovernode(var5);
      }

      if(var6) {
        self.bt.instancedata[var0].nextcoverchecktime = var1 + 500;
      } else {
        self.bt.instancedata[var0].nextcoverchecktime = var1 + randomintrange(4000, 6000);
      }
    } else {
      self.bt.instancedata[var0].nextcoverchecktime = var1 + randomintrange(2000, 4000);
    }
  }

  hunt_cqbtargetupdate(self.bt.instancedata[var0]);
  return anim.running;
}

function hunt_hunker_terminate(var0) {
  self.bt.instancedata[var0] = undefined;
}

function hunt_hunker_shouldexpose(var0) {
  var1 = 5000;

  if(!isinlight(self.lightmeter)) {
    var1 = 3000;
  }

  if(gettime() > self.stealth.hunthunkerlastexposetime + var1) {
    return anim.success;
  }

  return anim.failure;
}

function hunt_hunker_expose_init(var0) {
  var1 = spawnStruct();
  var1.endtime = gettime() + 4000;
  var1.nextpostime = 0;
  var1.nextposidx = 0;
  self.bt.instancedata[var0] = var1;
  scripts\asm\asm_bb::bb_requestcoverstate("exposed");

  if(scripts\engine\utility::isnodecoverleft(self.node) || scripts\engine\utility::isnodecoverright(self.node)) {
    scripts\asm\asm_bb::bb_requestcoverexposetype("B");
  } else {
    scripts\asm\asm_bb::bb_requestcoverexposetype("exposed");
  }

  self.stealth.btargetlastknown = 1;
}

function hunt_hunker_expose(var0) {
  var1 = gettime();
  var2 = self.bt.instancedata[var0];

  if(var1 > var2.endtime) {
    return anim.success;
  }

  return anim.running;
}

function hunt_hunker_expose_terminate(var0) {
  self.cqb_target = undefined;
  self.bt.instancedata[var0] = undefined;
  scripts\asm\asm_bb::bb_requestcoverstate("hide");
  self.stealth.btargetlastknown = undefined;
  self.stealth.hunthunkerlastexposetime = gettime();
}

function hunt_isincover(var0) {
  if(!isDefined(self.node)) {
    return anim.failure;
  }

  var1 = 16;

  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > var1) {
      return anim.failure;
    }
  } else if(self.keepclaimednodeifvalid) {
    var1 = 3600;
  } else {
    var1 = 225;
  }

  if(distance2dsquared(self.node.origin, self.origin) > var1) {
    return anim.failure;
  }

  return anim.success;
}

function hunt_active_terminate(var0) {
  scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
}

function hunt_move_init(var0) {
  var1 = gettime();
  var2 = spawnStruct();
  self.bt.instancedata[var0] = var2;
  var2.starttime = var1;
  var3 = hunt_getpos();
  self setbtgoalpos(0, var3);
  var2.goalpos = var3;
  var2.numfails = 0;
  var4 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(var4)) {
    scripts\smartobjects\utility::setcustomsmartobjectarrivaldata(var4);
    self setbtgoalRadius(0, 12);
  } else {
    if(!isDefined(self.asm.customdata.arrivalangles)) {
      self.asm.customdata.arrivalangles = findgoodinvestigatelookdir(var3);
    }

    self setbtgoalRadius(0, 36);
  }

  scripts\stealth\utility::set_patrol_style("cqb");
  self.disablelookdownpath = 1;
  var2.enablelookdownpathtime = var1 + 2000;
}

function hunt_sidechecks(var0) {
  var1 = 36;
  var2 = 36;
  var3 = 36;
  var4 = gettime();
  var5 = 2000;

  if(isDefined(var0.cornerchecknode) && var4 >= var0.cornerchecknodestarttime + var5) {
    var0.cornerchecknode = undefined;
    var0.cornerchecknodestarttime = undefined;
    self._blackboard.forcestrafe = 0;
    self._blackboard.forcestrafefacingpos = undefined;
    scripts\stealth\utility::set_patrol_style("cqb");
    self.disablelookdownpath = undefined;
  }

  if(!isDefined(var0.cornerchecknode) && !self.arriving && self.lookaheaddist > 32 && self pathdisttogoal() > 128) {
    var6 = self getposonpath(var1);
    var7 = anglesToForward(self.angles);
    var8 = getnodesinradius(var6, var3, 0, 60, "Cover");

    if(var8.size > 0) {
      foreach(var10 in var8) {
        if(!var10 doesnodeallowstance("stand")) {
          continue;
        }

        var11 = var10.origin - self.origin;

        if(vectordot(var11, var7) < 0) {
          continue;
        }

        var12 = angleclamp180(var10.angles[1] - self.angles[1]);

        if(var12 > 0 && var10.type != "Cover Right") {
          continue;
        } else if(var12 < 0 && var10.type != "Cover Left") {
          continue;
        }

        var13 = anglesToForward(var10.angles);
        var14 = vectordot(var13, var7);

        if(var14 > 0.5 || var14 < -0.5) {
          continue;
        }

        if(abs(angleclamp180(self.angles[1] - var10.angles[1])) < 45) {
          continue;
        }

        if(vectordot(self.lookaheaddir, var11) > 32) {
          continue;
        }

        var0.cornerchecknode = var10;
        var0.cornerchecknodestarttime = var4;
        break;
      }
    }
  }

  if(isDefined(var0.cornerchecknode)) {
    var17 = var0.cornerchecknode;
    var18 = undefined;
    var19 = anglestoaxis(var17.angles);
    var20 = var19["right"];

    if(var17.type == "Cover Left") {
      var20 = -1 * var20;
    }

    var21 = 20;
    var22 = var17.origin + var21 * var19["forward"] + var21 * var20;
    var23 = self.origin - var17.origin;

    if(vectordot(var23, var20) < var21) {
      var18 = var22;
    } else {
      var18 = self.origin + rotatevector((128, 0, 0), var17.angles);
    }

    self._blackboard.forcestrafe = 1;
    self._blackboard.forcestrafefacingpos = var18;
    scripts\engine\utility::set_movement_speed(30);
    self.disablelookdownpath = 1;
    return;
  }
}

function hunt_move(var0) {
  var1 = self.bt.instancedata[var0];
  var2 = gettime();
  var3 = scripts\asm\asm_bb::bb_smartobjectrequested();

  if(self.arriving && var3 && distancesquared(self.goalpos, self.origin) < 225) {
    scripts\asm\asm_bb::bb_requestplaysmartobject();
  }

  if(isdonewithsearchmove(var1)) {
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("hunt", "knownpos") && (!isDefined(self.stealth.lastephemeraleventrespondedtime) || var2 > self.stealth.lastephemeraleventrespondedtime)) {
    if(var3) {
      scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
    }

    return anim.success;
  }

  if(hunt_shouldhunker() == anim.success) {
    if(var3) {
      scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
    }

    return anim.success;
  }

  if(isDefined(var1.enablelookdownpathtime) && var2 > var1.enablelookdownpathtime) {
    self.disablelookdownpath = undefined;
    var1.enablelookdownpathtime = undefined;
  }

  if(isDefined(self.pathgoalpos) && (self.arrivalfailed || !self.facemotion) && var3 && self pathdisttogoal() < 56) {
    self._blackboard.forcestrafe = 1;
    var4 = scripts\asm\asm_bb::bb_getrequestedsmartobject();
    self._blackboard.forcestrafefacingpos = var4.origin + rotatevector((128, 0, 0), var4.angles);
  } else {
    hunt_sidechecks(var1);
  }

  if(isDefined(self.stealth.cleardata) && isDefined(self.stealth.cleardata.curregion)) {
    scripts\stealth\clear_regions::hunttrytoenterregionvolume(self.stealth.cleardata.curregion);
  }

  hunt_cqbtargetupdate(var1);
  return anim.running;
}

function hunt_move_terminate(var0) {
  self.bt.instancedata[var0] = undefined;

  if(isDefined(self.stealth.breacting)) {
    self.stealth.binitialhunt = 1;
  } else {
    self.stealth.binitialhunt = undefined;
  }

  self.cqb_target = undefined;
  self.asm.customdata.arrivalangles = undefined;
  self.asm.customdata.arrivalstate = undefined;
  self.asm.customdata.arrivalusefootdown = undefined;
  self.disablelookdownpath = undefined;
  self._blackboard.forcestrafe = 0;
  self._blackboard.forcestrafefacingpos = undefined;
}

function hunt_lookaround_init(var0) {
  var1 = 8000;
  var2 = spawnStruct();
  var2.endtime = gettime() + var1;

  if(isDefined(self.stealth.script_huntlookaroundduration)) {
    var2.endtime = gettime() + self.stealth.script_huntlookaroundduration;
  }

  self.bt.instancedata[var0] = var2;
  self setbtgoalpos(0, self getnavposition());
  self setbtgoalRadius(0, 36);

  if(istrue(self.stealth.script_skiplookaroundanim)) {
    if(isDefined(self.stealth.script_huntlookaroundduration)) {
      self.stealth.binvestigatelookaround = 0;
      return;
    }

    return;
  }

  self.stealth.binvestigatelookaround = 1;
}

function hunt_lookaround(var0) {
  if(isDefined(self.stealth.binitialhunt)) {
    return anim.success;
  }

  if(gettime() > self.bt.instancedata[var0].endtime) {
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("hunt", "knownpos") || scripts\asm\asm::asm_ephemeraleventfired("investigate_look", "end") || !isDefined(self.stealth.binvestigatelookaround)) {
    self.stealth.lastephemeraleventrespondedtime = gettime();
    return anim.success;
  }

  var1 = isDefined(self.cqb_target);
  var2 = hunt_cqbtargetupdate(self.bt.instancedata[var0]);

  if(!var1 && isDefined(self.cqb_target) && var2) {
    self.stealth.binvestigatelookaround = undefined;
    var3 = self.cqb_target;

    if(!isvector(self.cqb_target)) {
      var3 = self.cqb_target.origin;
    }

    scripts\stealth\utility::set_patrol_react(var3, "small");
  }

  return anim.running;
}

function hunt_lookaround_terminate(var0) {
  self.bt.instancedata[var0] = undefined;
  self.stealth.binvestigatelookaround = undefined;
}

function hunt_terminate() {
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

function combat_init() {
  self.dontattackme = 0;
  self.diequietly = 0;
  self.bisincombat = 1;
  scripts\stealth\event::event_escalation_clear();

  if(isDefined(self.script_combatmode)) {
    self.combatmode = self.script_combatmode;
  } else {
    self.combatmode = "cover";
  }

  scripts\stealth\enemy::set_sight_state("combat");
  var0 = self.origin;

  if(istrue(self._blackboard.bflashlight)) {
    if(isDefined(self.fnstealthflashlighton)) {
      self[[self.fnstealthflashlighton]]();
    }
  }

  var1 = level.stealth.combat_volumes[self.script_stealthgroup];

  if(isDefined(var1)) {
    self setbtgoalvolume(0, var1);
  } else if(isDefined(level.stealth.combat_goalradius) && isDefined(level.stealth.combat_goalradius[self.script_stealthgroup])) {
    self setbtgoalpos(0, self.scriptgoalpos);
    self setbtgoalRadius(0, level.stealth.combat_goalradius[self.script_stealthgroup]);
  }

  self forceupdategoalpos();

  if(isDefined(self.stealth.funcs["spotted"])) {
    scripts\stealth\callbacks::stealth_call_thread("spotted");
  }

  scripts\common\gameskill::grenadeawareness();
  scripts\aitypes\cover::requestcoverfind(0, 0, undefined);
  self.gunposeoverride_internal = undefined;
}

function combat_terminate() {
  self clearbtgoal(0);
}

function clearstealthvolume() {
  if(isDefined(level.stealth.combat_volumes[self.script_stealthgroup]) && iscombating() || isDefined(level.stealth.hunt_volumes[self.script_stealthgroup]) && ishunting()) {
    self clearbtgoal(0);
    return;
  }
}

function setstealthstate(var0, var1) {
  if(!scripts\engine\utility::flag("stealth_enabled") || !isDefined(self.stealth)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }

  switch (var0) {
    case "idle":
      self.dontattackme = 1;
      self.diequietly = 1;

      if(istrue(self.stealth.blind)) {
        scripts\stealth\enemy::set_sight_state("blind");
      } else {
        scripts\stealth\enemy::set_sight_state("hidden");
      }

      var2 = scripts\stealth\group::getgroup(self.script_stealthgroup);
      scripts\stealth\group::group_removefrompod(var2, self);
      enterstealthstate(0);
      self notify("stealth_idle");
      break;
    case "investigate":
      if(var1.type == "cover_blown") {
        self.stealth.bcoverhasbeenblown = 1;
      }

      if(self.stealth.bsmstate == 1) {
        if(isPlayer(self.stealth.investigate_entity) && !isPlayer(var1.entity) && var1.typeorig != "saw_corpse") {
          break;
        }

        if(isDefined(self.stealth.investigate_severity)) {
          if(self.stealth.investigateevent.typeorig == "saw_corpse" && var1.typeorig == "found_corpse" && var1.entity == self.stealth.investigate_entity) {
            break;
          }

          var3 = scripts\stealth\event::event_severity_compare(self.stealth.investigate_severity, var1.type);

          if(var3 >= 0) {
            self.stealth.investigate_severity = var1.type;
            self.stealth.investigate_entity = var1.entity;
            self.stealth.investigateevent = var1;
          }

          var4 = gettime();
          var5 = var3 > 0 || var4 > self.stealth.investigateevent_time || distancesquared(var1.investigate_pos, self.origin) < distancesquared(self.stealth.investigateevent.investigate_pos, self.origin);

          if(var5) {
            var2 = scripts\stealth\group::getgroup(self.script_stealthgroup);
            var6 = scripts\stealth\group::group_findpod(var2, self);
            var7 = scripts\stealth\group::group_trytojoinexistingpod(var2, var6, 1, self, var1.investigate_pos);

            if(isDefined(var7)) {
              var6 = var7;
            }

            var6 scripts\stealth\group::pod_updateinvestigateorigin(self, var1.investigate_pos);
            self.stealth.investigateevent_time = var4;
          }

          self.stealth.investigateendtime = undefined;
        }
      } else {
        if(var1.type == "cover_blown") {
          scripts\stealth\group::group_eventcoverblown(self.script_stealthgroup, self, var1);
        } else {
          scripts\stealth\group::group_eventinvestigate(self.script_stealthgroup, self, var1);
        }

        self.stealth.investigateevent = var1;
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
        var8 = isDefined(var1) && var1.typeorig == "damage" && self.allowpain && self.allowpain_internal && !self isinscriptedstate();

        if(isDefined(var1) && !var8) {
          var9 = "small";

          switch (var1.typeorig) {
            case "proximity":
              var9 = "smed";
              break;
            case "projectile_impact":
            case "gunshot":
            case "ally_killed":
            case "ally_damaged":
            case "bulletwhizby":
              var9 = "med";
              break;
            case "grenade danger":
            case "explode":
              var9 = "large";
              break;
            case "light_killed":
            case "attack":
            case "combat":
              if(distancesquared(var1.investigate_pos, self.origin) < 40000) {
                var9 = "med";
              }

              break;
          }

          var10 = self.enemy;

          if(!isDefined(var10) && isDefined(var1.entity) && issentient(var1.entity)) {
            var10 = var1.entity;
          }

          if(var9 == "small" && isDefined(var10)) {
            if(self cansee(var10)) {
              var9 = "med";
            } else if(var1.typeorig == "sight") {
              var9 = "smed";
            }
          }

          scripts\stealth\utility::set_patrol_style("combat", 1, var1.investigate_pos, var9);
        } else {
          scripts\stealth\utility::set_patrol_style("combat");
        }

        if(isDefined(var1) && var8 && istrue(self.asm.flashlight)) {
          scripts\asm\soldier\patrol::detachflashlight();
        }
      }

      self.stealth.bcoverhasbeenblown = 1;
      var10 = undefined;

      if(isDefined(var1) && isDefined(var1.entity)) {
        if(issentient(var1.entity) && var1.entity.team == self.team) {
          if(isDefined(var1.entity.enemy) && issentient(var1.entity.enemy)) {
            self copyenemyinfo(var1.entity);
          }
        } else {
          var10 = var1.entity;
        }
      }

      scripts\stealth\group::group_eventcombat(self.script_stealthgroup, self, var10);
      enterstealthstate(3);
      self notify("stealth_combat");
      break;
  }
}