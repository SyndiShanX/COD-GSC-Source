/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outofbounds.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\laststand;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_outofbounds;

function registerentforoob(ent, ref) {
  ent.oobref = ref;
}

function deregisterentforoob(ent) {
  ent.oobref = undefined;
}

function registeroobentercallback(ref, callback) {
  struct = getoobdata();
  struct.entercallbacks[ref] = callback;
}

function registeroobexitcallback(ref, callback) {
  struct = getoobdata();
  struct.exitcallbacks[ref] = callback;
}

function registerooboutoftimecallback(ref, callback) {
  struct = getoobdata();
  struct.outoftimecallbacks[ref] = callback;
}

function registeroobclearcallback(ref, callback) {
  struct = getoobdata();
  struct.clearcallbacks[ref] = callback;
}

function isoob(ent, var_3e36f415f762070e) {
  if(isoobimmune(ent)) {
    return false;
  }

  if(istrue(var_3e36f415f762070e) && isoobimmune(ent)) {
    return false;
  }

  return isDefined(ent.oob) && ent.oob > 0;
}

function enableoob(ent) {
  if(!isDefined(ent.oob)) {
    ent.oob = 0;
  }

  ent.oob++;

  if(ent.oob == 1) {
    if(!isDefined(ent.oobimmunity) || ent.oobimmunity <= 0) {
      onenteroob(ent);
    }
  }
}

function disableoob(ent) {
  assertex(isDefined(ent.oob), "disableOOB called on an entity that was not out of bounds.");
  assertex(ent.oob > 0, "disableOOB more times than enableOOB.");
  ent.oob--;

  if(ent.oob == 0) {
    ent.oob = undefined;

    if(!isDefined(ent.oobimmunity) || ent.oobimmunity <= 0) {
      onexitoob(ent, 0);
    }
  }
}

function isoobimmune(ent) {
  return isDefined(ent.oobimmunity) && ent.oobimmunity > 0;
}

function enableoobimmunity(ent) {
  if(!isDefined(ent.oobimmunity)) {
    ent.oobimmunity = 0;
  }

  ent.oobimmunity++;

  if(ent.oobimmunity == 1) {
    if(isDefined(ent.oob) && ent.oob > 0) {
      onexitoob(ent, 0);
    }
  }
}

function disableoobimmunity(ent) {
  assertex(isDefined(ent.oobimmunity), "disableOOBImmunity called on an entity without out of bounds immunity.");
  assertex(ent.oobimmunity > 0, "disableOOBImmunity more times than enableOOBImmunity.");
  ent.oobimmunity--;

  if(ent.oobimmunity == 0) {
    ent.oobimmunity = undefined;

    if(isDefined(ent.oob) && ent.oob > 0) {
      onenteroob(ent);
    }
  }
}

function clearoob(ent, fromdeath) {
  ent notify("clear_oob");

  if(isoob(ent, 1)) {
    onexitoob(ent, fromdeath, 1);
  }

  clearcallback = undefined;

  if(isPlayer(ent)) {
    clearcallback = &playerclearcallback;
  } else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    clearcallback = struct.clearcallbacks[ent.oobref];
  }

  if(isDefined(clearcallback)) {
    ent[[clearcallback]]();
  }

  ent.oobref = undefined;
  ent.oob = undefined;
  ent.oobimmunity = undefined;
  ent.oobtimeleft = undefined;
  ent.oobendtime = undefined;
  ent.oobtriggertype = undefined;

  if(isDefined(ent.oobtriggers)) {
    foreach(trigger in ent.oobtriggers) {
      trigger.entstouching[ent getentitynumber()] = undefined;
    }

    ent.oobtriggers = undefined;
  }

  if(isDefined(ent.oobsupressiontriggers)) {
    foreach(trigger in ent.oobsupressiontriggers) {
      trigger.entstouching[ent getentitynumber()] = undefined;
    }

    ent.oobsupressiontriggers = undefined;
  }
}

function initoob() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  outofboundstriggers = getEntArray("OutOfBounds", "targetname");

  foreach(trigger in outofboundstriggers) {
    level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
  }

  val::group_register("enterOOB", ["killstreaks", "supers"]);
  thread watchoobtriggers();
}

function ispointinoutofbounds(pointtocheck, teamtocheck) {
  pointinoutofbounds = 0;

  if(!isDefined(level.outofboundstriggers)) {
    return pointinoutofbounds;
  } else {
    foreach(trigger in level.outofboundstriggers) {
      if(ispointinvolume(pointtocheck, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(teamtocheck) && trigger.script_team != teamtocheck) {
          continue;
        }

        pointinoutofbounds = 1;
        break;
      }
    }
  }

  return pointinoutofbounds;
}

function add_trigger_to_oob_system(trigger) {
  if(isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
  } else {
    level.outofboundstriggers[0] = trigger;
  }

  thread watchoobtrigger(trigger);
}

function onenteroob(ent) {
  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(occupant in occupants) {
      onenteroobtrigger(self, occupant);
    }
  }

  entercallback = undefined;
  trigger = getlastoobtrigger(ent);

  if(!isDefined(trigger)) {
    trigger = self;
  }

  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent)) {
    entercallback = &playerentercallback;
  } else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    entercallback = struct.entercallbacks[ent.oobref];
  }

  ent notify("oob_cooldown_end");

  if(isDefined(ent.oobtimeleft) && previouslytouchedtriggertype(ent, triggertype)) {
    outofboundstime = ent.oobtimeleft / 1000;
    ent.oobendtime = int(gettime() + ent.oobtimeleft);
    ent.oobtimeleft = undefined;
    thread watchooboutoftime(ent, outofboundstime);
  } else {
    ent.oobtimeleft = undefined;
    ent.oobtriggertype = triggertype;
    outofboundstime = getoutofboundstime(triggertype);
    ent.oobendtime = int(gettime() + outofboundstime * 1000);
    thread watchooboutoftime(ent, outofboundstime);
  }

  if(isDefined(entercallback)) {
    ent thread[[entercallback]]("exit_oob", "clear_oob");
  }
}

function previouslytouchedtriggertype(var_7edface381884ca9, currenttriggertype) {
  var_1b99bb6cc4aec0fe = 0;

  if(isDefined(var_7edface381884ca9.oobtriggertype)) {
    previoustriggertype = var_7edface381884ca9.oobtriggertype;

    if(currenttriggertype == previoustriggertype) {
      var_1b99bb6cc4aec0fe = 1;
    } else if((currenttriggertype == "default" || currenttriggertype == "minefield") && (previoustriggertype == "default" || previoustriggertype == "minefield")) {
      var_1b99bb6cc4aec0fe = 1;
    }
  }

  return var_1b99bb6cc4aec0fe;
}

function onexitoob(ent, fromdeath, fromclear) {
  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(occupant in occupants) {
      onexitoobtrigger(self, occupant);
    }
  }

  ent notify("exit_oob");
  exitcallback = undefined;

  if(isPlayer(ent)) {
    exitcallback = &playerexitcallback;
  } else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    exitcallback = struct.exitcallbacks[ent.oobref];
  }

  ent notify("oob_timeout_end");

  if(!istrue(fromclear)) {
    if(isDefined(ent.oobendtime)) {
      ent.oobtimeleft = int(max(0, ent.oobendtime - gettime()));
      ent.oobendtime = undefined;
      trigger = getlastoobtrigger(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread watchoobcooldown(ent, cooldowntime);
    }
  }

  if(isDefined(exitcallback)) {
    ent thread[[exitcallback]](fromdeath, fromclear, "clear_oob");
  }
}

function onooboutoftime(ent) {
  outoftimecallback = undefined;

  if(isDefined(ent.vehicle)) {
    ent.vehicle scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_outoftimecallback("oob_timeout_end", "clear_oob");
  } else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    outoftimecallback = struct.outoftimecallbacks[ent.oobref];
  } else if(isPlayer(ent)) {
    outoftimecallback = &playeroutoftimecallback;
  }

  if(isDefined(outoftimecallback)) {
    ent thread[[outoftimecallback]]("oob_timeout_end", "clear_oob");
  }
}

function watchooboutoftime(ent, timeleft) {
  if(isPlayer(ent)) {
    ent endon("death_or_disconnect");
  } else {
    ent endon("death");
  }

  ent notify("oob_timeout_end");
  ent endon("oob_timeout_end");
  ent endon("clear_oob");
  wait timeleft;
  thread onooboutoftime(ent);
}

function watchoobcooldown(ent, timeleft) {
  if(isPlayer(ent)) {
    ent endon("death_or_disconnect");
  } else {
    ent endon("death");
  }

  ent notify("oob_cooldown_end");
  ent endon("oob_cooldown_end");
  ent endon("clear_oob");
  wait timeleft;
  ent.oobtimeleft = undefined;
  ent.oobtriggertype = undefined;
}

function function_c61001f433dfd696() {
  self notify("oob_last_stand");
  self endon("death");
  self endon("oob_last_stand");

  while(!scripts\cp\laststand::player_in_laststand(self)) {
    wait 0.1;
  }

  kill_player_on_timeout();
}

function playerentercallback(exitnotify, clearnotify, triggertype) {
  var_49e84ec5d8aa4f0a = 5;
  self.oobtype = var_49e84ec5d8aa4f0a;
  self setclientomnvar("ui_out_of_bounds_type", var_49e84ec5d8aa4f0a);
  self setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
  val::group_set("enterOOB", 0);
  thread function_c61001f433dfd696();
}

function playerexitcallback(fromdeath, fromclear, clearnotify) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  val::group_reset("enterOOB");
  self notify("oob_last_stand");
}

function playeroutoftimecallback(timeoutendnotify, clearnotify) {
  trigger = getlastoobtrigger(self);
  triggertype = gettriggertype(self, trigger);

  if(triggertype == "minefield") {
    thread playeroutoftimeminefield(timeoutendnotify, clearnotify);
    return;
  }

  kill_player_on_timeout();
}

function kill_player_on_timeout() {
  self.oob = 1;
  self.shouldskiplaststand = 1;

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(vehicle)) {
      vehicle scripts\cp_mp\vehicles\vehicle::vehicle_explode();
    }
  }

  self dodamage(self.health + 100, self.origin, undefined, undefined, "MOD_SUICIDE");

  if(scripts\cp\laststand::player_in_laststand(self)) {
    self suicide();
  }
}

function playerclearcallback(clearnotify) {
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function playeroutoftimeminefield(timeoutendnotify, clearnotify) {
  minespawnpos = self.origin;
  minetrace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self);

  if(isDefined(minetrace["hittype"] != "hittype_none") && isDefined(minetrace["position"])) {
    minespawnpos = minetrace["position"];
  }

  mine = spawn("script_model", minespawnpos);
  mine setModel("ks_minefield_mp");
  mine setentityowner(self);
  mine setotherent(self);
  mine setscriptablepartstate("warning_click", "on", 0);
  mineexploded = playeroutoftimeminefieldinternal(mine, timeoutendnotify, clearnotify);

  if(istrue(mineexploded)) {
    wait 2;
  }

  mine delete();
}

function playeroutoftimeminefieldinternal(mine, timeoutendnotify, clearnotify) {
  self endon("death_or_disconnect");

  if(isDefined(timeoutendnotify)) {
    self endon(timeoutendnotify);
  }

  if(isDefined(clearnotify)) {
    self endon(clearnotify);
  }

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  mine setscriptablepartstate("explosion", "on", 0);
  self.shouldskiplaststand = 1;

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(isDefined(vehicle)) {
      vehicle scripts\cp_mp\vehicles\vehicle::vehicle_explode();
    }
  }

  self dodamage(2000, self.origin, self, self, "MOD_EXPLOSIVE", "minefield_mp");
  return true;
}

function killstreakentercallback(exitnotify, clearnotify) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
  }
}

function killstreakexitcallback(fromdeath, fromclear, clearnotify) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

function killstreakoutoftimecallback(timeoutendnotify, clearnotify) {
  if(issharedfuncdefined("killstreak", "doDamageToKillstreak")) {
    self[[getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "nuke_mp");
  }
}

function killstreakclearcallback() {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

function killstreakregisteroobcallbacks() {
  registeroobentercallback("killstreak", &killstreakentercallback);
  registeroobexitcallback("killstreak", &killstreakexitcallback);
  registerooboutoftimecallback("killstreak", &killstreakoutoftimecallback);
  registeroobclearcallback("killstreak", &killstreakclearcallback);
}

function watchoobtriggers() {
  if(isDefined(level.outofboundstriggers)) {
    for(i = 0; i < level.outofboundstriggers.size; i++) {
      thread watchoobtrigger(level.outofboundstriggers[i]);
    }

    if(isDefined(level.outofboundstriggerpatches)) {
      foreach(trigger in level.outofboundstriggerpatches) {
        thread watchoobsuppressiontrigger(trigger);
      }
    }
  }
}

function watchoobtrigger(trigger) {
  trigger.entstouching = [];
  thread watchoobtriggerexit(trigger);
  thread watchoobtriggerenter(trigger);
}

function watchoobtriggerenter(trigger) {
  level endon("game_ended");
  trigger endon("death");

  if(isDefined(trigger.target)) {
    trigger.failtrigger = getEnt(trigger.target, "targetname");
    trigger.failtrigger childthread function_4ac27cf95f50d024(trigger);
  }

  while(true) {
    trigger waittill("trigger", ent);
    playerent = ent;

    if(getdvarint(@ "hash_51412b605eba83b2", 0)) {
      wait 1;
      continue;
    }

    if(istrue(level.var_c3da524e90fa9fb4)) {
      wait 1;
      continue;
    }

    if(isPlayer(ent)) {
      if(isDefined(ent.c130)) {
        continue;
      }
    }

    if(isDefined(ent.vehiclename) && ent.vehiclename == "cruise_predator") {
      if(gettime() < ent.birthtime + 5000) {
        continue;
      }
    }

    if(isDefined(trigger.script_team)) {
      var_5af6b346cd92a66b = 0;

      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        var_5af6b346cd92a66b = 1;
      }

      if(var_5af6b346cd92a66b && isDefined(ent.owner) && ent.owner.team != trigger.script_team) {
        continue;
      }

      if(!var_5af6b346cd92a66b && ent.team != trigger.script_team) {
        continue;
      }
    }

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(ent.owner)) {
      playerent = ent.owner;
    }

    if(ent scripts\cp_mp\killstreaks\helper_drone::ishelperdrone() && scripts\cp_mp\killstreaks\helper_drone::function_de3c015e3c7130e7(ent.helperdronetype)) {
      continue;
    }

    if(!interactswithoobtriggers(playerent)) {
      continue;
    }

    onenteroobtrigger(trigger, playerent);
  }
}

function function_4ac27cf95f50d024(parent_trigger) {
  self endon("death");
  self endon("stop_failthread");

  while(true) {
    self waittill("trigger", ent);
    playerent = ent;

    if(getdvarint(@ "hash_51412b605eba83b2", 0)) {
      wait 1;
      continue;
    }

    if(istrue(level.var_c3da524e90fa9fb4)) {
      wait 1;
      continue;
    }

    if(isPlayer(ent)) {
      if(isDefined(ent.c130)) {
        continue;
      }
    }

    if(isDefined(self.script_team)) {
      var_5af6b346cd92a66b = 0;

      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        var_5af6b346cd92a66b = 1;
      }

      if(var_5af6b346cd92a66b && isDefined(ent.owner) && ent.owner.team != self.script_team) {
        continue;
      }

      if(!var_5af6b346cd92a66b && ent.team != self.script_team) {
        continue;
      }
    }

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(ent.owner)) {
      playerent = ent.owner;
    }

    if(!interactswithoobtriggers(playerent)) {
      continue;
    }

    if(isoobimmune(playerent)) {
      continue;
    }

    playerent setclientomnvar("ui_out_of_bounds_countdown", 0);
    playerent notify("oob_timeout_end");
    thread onooboutoftime(playerent);
    break;
  }
}

function watchoobtriggerexit(trigger) {
  level endon("game_ended");
  trigger endon("death");

  while(true) {
    temparr = trigger.entstouching;

    foreach(ent in temparr) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
      }

      if(isDefined(ent) && !trigger istouching(ent)) {
        onexitoobtrigger(trigger, ent);
      }
    }

    waitframe();
  }
}

function onenteroobtrigger(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.oobtriggers)) {
    ent.oobtriggers = [];
  }

  temparr = [trigger];

  foreach(oobtrigger in ent.oobtriggers) {
    temparr[temparr.size] = oobtrigger;
  }

  ent.oobtriggers = temparr;
  enableoob(ent);
}

function onexitoobtrigger(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  disableoob(ent);
  ent.oobtriggers = array_remove(ent.oobtriggers, trigger);

  if(ent.oobtriggers.size == 0) {
    ent.oobtriggers = undefined;
  }
}

function watchoobsuppressiontrigger(trigger) {
  trigger.entstouching = [];
  wait 10;
  thread watchoobsuppressiontriggerexit();
  thread watchoobsupressiontriggerenter();
}

function watchoobsupressiontriggerenter(trigger) {
  level endon("game_ended");

  while(true) {
    trigger waittill("trigger", ent);

    if(!interactswithoobtriggers(ent)) {
      continue;
    }

    onenteroobsuppressiontrigger(trigger, ent);
  }
}

function watchoobsuppressiontriggerexit(trigger) {
  level endon("game_ended");

  while(true) {
    temparr = trigger.entstouching;

    foreach(ent in temparr) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
      }

      if(!trigger istouching(ent)) {
        onexitoobsupressiontrigger(trigger, ent);
      }
    }
  }
}

function onenteroobsuppressiontrigger(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.oobsupressiontriggers)) {
    ent.oobsupressiontriggers = [];
  }

  ent.oobsupressiontriggers[trigger getentitynumber()] = trigger;
  enableoobimmunity(ent);
}

function onexitoobsupressiontrigger(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent.oobsupressiontriggers[trigger getentitynumber()] = undefined;

  if(ent.oobsupressiontriggers.size == 0) {
    ent.oobsupressiontriggers = undefined;
  }

  disableoobimmunity(ent);
}

function interactswithoobtriggers(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive()) {
        return true;
      }
    }

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      if(istrue(ent.oobimmunity)) {
        return false;
      } else if(isDefined(ent.owner) && isPlayer(ent.owner)) {
        if(ent.owner scripts\cp_mp\utility\player_utility::_isalive()) {
          return true;
        }
      }
    }

    if(isDefined(ent.oobref)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed)) {
          return true;
        }
      }

      if(isDefined(ent.streakinfo) && iskillstreakaffectedbyobb(ent.streakinfo.streakname)) {
        return true;
      }
    }
  }

  return false;
}

function getoobdata() {
  struct = level.oobdata;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level.oobdata = struct;
  }

  return struct;
}

function iskillstreakaffectedbyobb(streakname) {
  affectedbyobb = 0;

  switch (streakname) {
    case #"hash_cf0ef5bef19a311b":
    case #"hash_e40585107590f016":
      affectedbyobb = 1;
      break;
  }

  return affectedbyobb;
}

function gettriggertype(ent, trigger) {
  triggertype = "default";

  if(isDefined(ent) && ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    return "default";
  }

  if(isDefined(ent) && isDefined(ent.streakinfo)) {
    return "killstreak";
  }

  if(isDefined(trigger) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "MineField") {
    triggertype = "minefield";
  }

  return triggertype;
}

function getcooldowntime(triggertype) {
  switch (triggertype) {
    case #"hash_1cac65e1b8bf24a7":
    case #"hash_6b15362474c2e2b2":
    case #"hash_7038dec66d8275be":
      return getmaxoutofboundscooldown();
  }

  return undefined;
}

function getoutofboundstime(triggertype) {
  switch (triggertype) {
    case #"hash_1cac65e1b8bf24a7":
      return 10;
    case #"hash_6b15362474c2e2b2":
      return getmaxoutofboundsminefieldtime();
    case #"hash_7038dec66d8275be":
      return getmaxoutofboundstime();
  }

  return undefined;
}

function getlastoobtrigger(ent) {
  if(isDefined(ent.oobtriggers)) {
    return ent.oobtriggers[0];
  }

  return undefined;
}

function getmaxoutofboundstime() {
  if(level.player isinvehicle()) {
    outofboundstime = level.var_c40a8076a9c58b32;

    if(!isDefined(outofboundstime)) {
      outofboundstime = max(0, getdvarfloat(@ "scr_outofboundstime", 4));
      level.var_c40a8076a9c58b32 = outofboundstime;
    }

    return outofboundstime;
  }

  outofboundstime = level.outofboundstime;

  if(!isDefined(outofboundstime)) {
    outofboundstime = max(0, getdvarfloat(@ "scr_outofboundstime", 15));
    level.outofboundstime = outofboundstime;
  }

  return outofboundstime;
}

function getmaxoutofboundscooldown() {
  return max(0, getdvarfloat(@ "hash_1e90a42100ff3964", 3));

  outofboundscooldown = level.outofboundscooldown;

  if(!isDefined(outofboundscooldown)) {
    outofboundscooldown = max(0, getdvarfloat(@ "hash_1e90a42100ff3964", 3));
    level.outofboundscooldown = outofboundscooldown;
  }

  return outofboundscooldown;
}

function getmaxoutofboundsminefieldtime() {
  return max(0, getdvarfloat(@ "hash_e4bb2af9293410e5", 10));

  outofboundstimeminefield = level.outofboundstimeminefield;

  if(!isDefined(outofboundstimeminefield)) {
    outofboundstimeminefield = max(0, getdvarfloat(@ "hash_e4bb2af9293410e5", 10));
    level.outofboundstimeminefield = outofboundstimeminefield;
  }

  return outofboundstimeminefield;
}

function function_34db328baed4337e(bool) {
  level.var_c3da524e90fa9fb4 = !bool;
}

function function_4ff3dde013cb8715(seconds) {
  level.outofboundstime = seconds;
}

function function_74fda8a1be219946(seconds) {
  level.outofboundstimeminefield = seconds;
}

function function_85b91de4920ec82d(seconds) {
  level.outofboundscooldown = seconds;
}