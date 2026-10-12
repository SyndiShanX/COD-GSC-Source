/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\outofbounds.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\hostmigration;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\game_utility_mp;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace outofbounds;

function registerentforoob(ent, ref) {
  ent.oobref = ref;

  ignoreoob = getdvarint(@ "hash_d197b236ea8564e", 0);

  if(ignoreoob) {
    scripts\mp\outofbounds::enableoobimmunity(ent);
  }
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

  if(!isDefined(ent.oobimmunity) || ent.oobimmunity <= 0) {
    onenteroob(ent);
  }

  if(isDefined(ent.ontouchoob)) {
    [[ent.ontouchoob]](ent);
  }
}

function disableoob(ent) {
  if(!isDefined(ent.oob)) {
    return;
  }

  assertex(isDefined(ent.oob), "<dev string:x1c>");
  assertex(ent.oob > 0, "<dev string:x5a>");
  ent.oob--;

  if(ent.oob == 0) {
    ent.oob = undefined;
  }

  if(!isDefined(ent.oobimmunity) || ent.oobimmunity <= 0) {
    onexitoob(ent, 0);
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
  assertex(isDefined(ent.oobimmunity), "<dev string:x83>");
  assertex(ent.oobimmunity > 0, "<dev string:xcd>");
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
  ent.oobtype = undefined;

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

function istouchingoobtrigger() {
  if(isDefined(level.var_5d435d19e6cdf0b5) && istrue(self[[level.var_5d435d19e6cdf0b5]]())) {
    return true;
  }

  if(istrue(self.allowedintrigger)) {
    return false;
  }

  if(!isDefined(level.outofboundstriggers)) {
    return false;
  }

  foreach(trigger in level.outofboundstriggers) {
    if(!scripts\mp\outofbounds::interactswithgivenoobtrigger(trigger, self)) {
      continue;
    }

    if(self istouching(trigger)) {
      return true;
    }
  }

  return false;
}

function ispointinoutofbounds(pointtocheck, teamtocheck) {
  if(isDefined(level.var_29977dc303738053) && istrue([[level.var_29977dc303738053]](pointtocheck, teamtocheck))) {
    return 1;
  }

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

function initoob() {
  thread watchoobtriggers();
  val::group_register("enterOOB", ["killstreaks", "supers"]);
}

function onenteroob(ent) {
  var_aadbc2b08cd0c218 = [];
  trigger = self;

  if(!isDefined(trigger)) {
    trigger = self;
  }

  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent)) {
    var_aadbc2b08cd0c218[var_aadbc2b08cd0c218.size] = &playerentercallback;
  }

  if(isDefined(ent.oobref)) {
    struct = getoobdata();
    var_aadbc2b08cd0c218[var_aadbc2b08cd0c218.size] = struct.entercallbacks[ent.oobref];
  }

  ent notify("oob_cooldown_end");

  if(isDefined(ent.oobtimeleft) && previouslytouchedtriggertype(ent, triggertype) && !isDefined(ent.vehicle)) {
    outofboundstime = ent.oobtimeleft / 1000;
    ent.oobendtime = int(gettime() + ent.oobtimeleft);
    ent.oobtimeleft = undefined;
    thread watchooboutoftime(ent, outofboundstime);
  } else {
    outofboundstime = getoutofboundstime(triggertype);

    if(isPlayer(ent) && isDefined(ent.vehicle) && isDefined(ent.vehicle.oobendtime)) {
      outofboundstime = (ent.vehicle.oobendtime - gettime()) / 1000;
    } else if(isDefined(ent.oobtimeleft)) {
      outofboundstime = min(ent.oobtimeleft / 1000, outofboundstime);
    } else if(isDefined(ent.oobendtime)) {
      outofboundstime = min((ent.oobendtime - gettime()) / 1000, outofboundstime);
    }

    ent.oobtimeleft = undefined;
    ent.oobtriggertype = triggertype;
    ent.oobendtime = int(gettime() + outofboundstime * 1000);
    thread watchooboutoftime(ent, outofboundstime);
  }

  foreach(cb in var_aadbc2b08cd0c218) {
    if(isDefined(cb)) {
      ent thread[[cb]]("exit_oob", "clear_oob", triggertype);
    }
  }

  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(occupant in occupants) {
      onenteroobtrigger(self, occupant);
    }
  }
}

function onexitoob(ent, fromdeath, fromclear) {
  trigger = self;
  ent notify("exit_oob");
  exitcallback = undefined;

  if(!isDefined(ent.oob)) {
    ent notify("oob_timeout_end");

    if(isPlayer(ent)) {
      exitcallback = &playerexitcallback;
    } else if(isDefined(ent.oobref)) {
      struct = getoobdata();
      exitcallback = struct.exitcallbacks[ent.oobref];
    }

    if(!istrue(fromclear)) {
      if(isDefined(ent.oobendtime)) {
        ent.oobtimeleft = int(max(0, ent.oobendtime - gettime()));
        ent.oobendtime = undefined;
        triggertype = gettriggertype(ent, trigger);
        cooldowntime = getcooldowntime(triggertype);
        thread watchoobcooldown(ent, cooldowntime);
      }
    }
  }

  if(isDefined(exitcallback)) {
    ent thread[[exitcallback]](fromdeath, fromclear, "clear_oob");
  }

  if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo)) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

    foreach(occupant in occupants) {
      if(isDefined(occupant)) {
        onexitoobtrigger(trigger, occupant);
      }
    }
  }

  level callback::callback(#"hash_51b5835095bd776a", {
    #fromclear: fromclear, #fromdeath: fromdeath, #trigger: trigger, #ent: ent
  });
}

function onooboutoftime(ent) {
  outoftimecallback = undefined;

  if(isPlayer(ent)) {
    var_775c9a68f9c00019 = 1;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      if(istrue(level.infilcinematicactive)) {
        var_775c9a68f9c00019 = 0;
      } else if(isDefined(level.matchcountdowntime) && level.matchcountdowntime < 2) {
        var_775c9a68f9c00019 = 0;
      }
    }

    if(var_775c9a68f9c00019) {
      outoftimecallback = &playeroutoftimecallback;
    }
  } else if(isDefined(ent.oobref)) {
    struct = getoobdata();
    outoftimecallback = struct.outoftimecallbacks[ent.oobref];
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

function playerentercallback(exitnotify, clearnotify, triggertype) {
  var_49e84ec5d8aa4f0a = function_c6aa39a55c49dc1(triggertype);
  self.oobtype = var_49e84ec5d8aa4f0a;
  self setclientomnvar("ui_out_of_bounds_type", var_49e84ec5d8aa4f0a);
  self setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
  val::group_set("enterOOB", 0);

  if(isDefined(self.offhandweapon) && self isthrowinggrenade() && scripts\mp\utility\weapon::issuperweapon(self.offhandweapon)) {
    self canceloffhands();
  }

  if(!isDefined(self.vehicle)) {
    thread function_39c5bd55494a224b();
  }
}

function playerexitcallback(fromdeath, fromclear, clearnotify) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
  val::group_reset("enterOOB");

  if(istrue(self.var_f9b51be13b8defc)) {
    self.var_f9b51be13b8defc = undefined;
  }
}

function playeroutoftimecallback(timeoutendnotify, clearnotify) {
  trigger = getlastoobtrigger(self);
  triggertype = gettriggertype(self, trigger);

  if(triggertype == "minefield") {
    thread playeroutoftimeminefield(timeoutendnotify, clearnotify);
    return;
  }

  self.oobdeath = 1;
  _suicide(undefined, 1);
  self.oobdeath = undefined;
}

function playerclearcallback(clearnotify) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
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

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  mine setscriptablepartstate("explosion", "on", 0);
  wait 0.05;
  self dodamage(2000, self.origin, self, mine, "MOD_EXPLOSIVE", "minefield_mp");
  return true;
}

function function_39c5bd55494a224b() {
  self endon("death_or_disconnect");
  self endon("exit_oob");
  self waittill("vehicle_enter");

  if(isDefined(self.vehicle) && !scripts\common\vehicle::function_a0f7306fc3c08ecf(self.vehicle, 1)) {
    self.var_f9b51be13b8defc = 1;
  }
}

function checkinvalidoobtriggers() {
  foreach(trigger in self.oobtriggers) {
    if(!function_4badb9b6ac027b93(self, trigger)) {
      onexitoobtrigger(trigger, self);
    }
  }
}

function killstreakentercallback(exitnotify, clearnotify, triggertype) {
  var_49e84ec5d8aa4f0a = function_c6aa39a55c49dc1(triggertype);
  self.oobtype = var_49e84ec5d8aa4f0a;

  if(isDefined(self.owner) && istrue(self.ispiloted)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", var_49e84ec5d8aa4f0a);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
  }
}

function killstreakexitcallback(fromdeath, fromclear, clearnotify) {
  if(isDefined(self.owner) && istrue(self.ispiloted)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", 0);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
  }
}

function killstreakoutoftimecallback(timeoutendnotify, clearnotify) {
  dodamagetokillstreak(10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "nuke_multi_mp");
}

function killstreakclearcallback() {
  if(isDefined(self.owner) && istrue(self.ispiloted)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", 0);
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
  if(scripts\mp\utility\game::lpcfeaturegated() && !scripts\mp\utility\game_utility_mp::function_9a2fd0d19774edde() && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      thread watchoobtrigger(trigger);
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

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  }

  thread watchoobtriggerexit(trigger);
  thread watchoobtriggerenter(trigger);
}

function watchoobtriggerenter(trigger) {
  level endon("game_ended");
  level endon("switch_oob");

  while(true) {
    trigger waittill("trigger", ent);

    if(!function_4badb9b6ac027b93(ent, trigger)) {
      continue;
    }

    onenteroobtrigger(trigger, ent);
  }
}

function function_4badb9b6ac027b93(ent, trigger) {
  if(istrue(trigger.isdisabled)) {
    return false;
  }

  if(isDefined(level.var_54d973dccda0ef8b) && [[level.var_54d973dccda0ef8b]](ent)) {
    return false;
  }

  if(isPlayer(ent) && isDefined(ent.c130)) {
    return false;
  }

  if(!interactswithgivenoobtrigger(trigger, ent)) {
    return false;
  }

  if(!interactswithoobtriggers(ent)) {
    return false;
  }

  return true;
}

function watchoobtriggerexit(trigger) {
  level endon("game_ended");
  level endon("switch_oob");
  var_c30cd90a1a82d688 = isent(trigger);

  while(true) {
    temparr = trigger.entstouching;

    foreach(id, ent in temparr) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
      }

      if(isDefined(ent) && (istrue(ent.var_f9b51be13b8defc) || !trigger istouchingtrigger(ent, var_c30cd90a1a82d688) && !isDefined(ent.vehicle))) {
        onexitoobtrigger(trigger, ent);
      }
    }

    waitframe();
  }
}

function private istouchingtrigger(ent, var_994e7746ed176aec) {
  return var_994e7746ed176aec && self istouching(ent) || !var_994e7746ed176aec && ispointinvolume(ent.origin, self);
}

function onenteroobtrigger(trigger, ent, forceentry) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum]) && !istrue(forceentry)) {
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
  trigger enableoob(ent);
}

function onexitoobtrigger(trigger, ent) {
  if(!isDefined(ent)) {
    return;
  }

  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  trigger disableoob(ent);

  if(!isDefined(ent.oobtriggers)) {
    return;
  }

  ent.oobtriggers = array_remove(ent.oobtriggers, trigger);

  if(ent.oobtriggers.size == 0) {
    ent.oobtriggers = undefined;
  }
}

function watchoobsuppressiontrigger(trigger) {
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchoobsuppressiontriggerexit(trigger);
  thread watchoobsupressiontriggerenter(trigger);
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

    if(isDefined(temparr)) {
      foreach(id, ent in temparr) {
        if(!isDefined(ent)) {
          trigger.entstouching[id] = undefined;
        }

        if(isDefined(ent) && !trigger istouching(ent)) {
          onexitoobsupressiontrigger(trigger, ent);
        }
      }
    }

    waitframe();
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

  temparr = [trigger];

  foreach(oobsuppressiontrigger in ent.oobsupressiontriggers) {
    temparr[temparr.size] = oobsuppressiontrigger;
  }

  ent.oobsupressiontriggers = temparr;
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

function interactswithgivenoobtrigger(trigger, ent) {
  isvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();

  if(isDefined(trigger.script_team)) {
    if(isgroundwarcoremode() || istrue(level.ignoreteamoob)) {
      return false;
    }

    if(isvehicle) {
      if(isDefined(ent.team) && ent.team != "neutral" && ent.team != trigger.script_team) {
        return false;
      }

      if(isDefined(ent.owner) && ent.owner.team != trigger.script_team) {
        return false;
      }

      if(isDefined(ent.occupants)) {
        foreach(occupant in ent.occupants) {
          if(isDefined(occupant.team) && occupant.team != trigger.script_team) {
            return false;
          }
        }
      }
    } else if(!isDefined(ent.team) || ent.team != trigger.script_team) {
      return false;
    }
  }

  if(isvehicle) {
    ref = ent scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();

    if(issharedfuncdefined(ref, "interactsWithOOBTrigger")) {
      if(!callsharedfunc(ref, "interactsWithOOBTrigger", trigger, ent)) {
        return false;
      }
    }
  }

  if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "onlyVehOOB") {
    if(!istrue(isvehicle)) {
      return false;
    }
  }

  return true;
}

function interactswithoobtriggers(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive()) {
        return true;
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
    case #"hash_9e36e3bd3a9dd00d":
    case #"hash_cf0ef5bef19a311b":
    case #"hash_e40585107590f016":
      affectedbyobb = 1;
      break;
  }

  return affectedbyobb;
}

function gettriggertype(ent, trigger) {
  triggertype = "default";

  if(trigger scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return "vehicle";
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return "br";
  }

  if(isDefined(trigger) && isDefined(trigger.script_team)) {
    return "restricted";
  }

  if(isDefined(ent) && ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return "default";
  }

  if(isDefined(ent) && isDefined(ent.streakinfo)) {
    return "default";
  }

  if(isDefined(trigger) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "MineField") {
    triggertype = "minefield";
  }

  return triggertype;
}

function private function_c6aa39a55c49dc1(triggertype) {
  oobtype = 1;
  var_7c4a4f886922a011 = 0;

  if(islargemap()) {
    gametype = getgametype();

    switch (gametype) {
      case #"hash_ca6516c10db2c95":
      case #"hash_5e78ea9021845d4a":
      case #"hash_7f9c384a34cc392f":
      case #"hash_9a6f07d0214a87db":
      case #"hash_c065cef60f38490a":
        var_7c4a4f886922a011 = 1;
        break;
    }

    if(isgroundwarcoremode()) {
      var_7c4a4f886922a011 = 1;
    }
  }

  if(istrue(var_7c4a4f886922a011)) {
    if(isDefined(triggertype) && triggertype == "restricted") {
      oobtype = 2;
    }
  }

  return oobtype;
}

function getcooldowntime(triggertype) {
  switch (triggertype) {
    case #"hash_18ad1d5da2e56d4c":
    case #"hash_6b15362474c2e2b2":
    case #"hash_7038dec66d8275be":
    case #"hash_b9c0ff6cd406fe0f":
    case #"hash_fa21c4f6bd5e3815":
      return getmaxoutofboundscooldown();
  }

  return undefined;
}

function getoutofboundstime(triggertype) {
  switch (triggertype) {
    case #"hash_6b15362474c2e2b2":
      return getmaxoutofboundsminefieldtime();
    case #"hash_18ad1d5da2e56d4c":
      return getmaxoutofboundsrestrictedtime();
    case #"hash_fa21c4f6bd5e3815":
      return getmaxoutofboundsbrtime();
    case #"hash_7038dec66d8275be":
      return getmaxoutofboundstime();
    case #"hash_b9c0ff6cd406fe0f":
      return function_a01d18a56c6cc1aa();
  }

  return undefined;
}

function getlastoobtrigger(ent) {
  if(isDefined(ent.oobtriggers)) {
    return ent.oobtriggers[0];
  }

  return undefined;
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

function function_420d6eda841fd001(triggertype, origin, angles, radius, height, drawdebug) {
  trigger = spawn(triggertype, origin, 0, radius, height);
  trigger.angles = angles;
  level.outofboundstriggers[level.outofboundstriggers.size] = trigger;

  if(drawdebug == 1) {
    thread scripts\mp\utility\debug::drawsphere(trigger.origin, radius, 1000, (1, 1, 0));
  }
}

function function_49f55ab317da5250() {
  drawdebug = 0;
  oobspawns = getStructArray("OutOfBounds", "targetname");

  if(isDefined(oobspawns)) {
    foreach(oobspawn in oobspawns) {
      function_420d6eda841fd001("trigger_rotatable_radius", oobspawn.origin, oobspawn.angles, oobspawn.radius, oobspawn.height, drawdebug);
    }
  }
}

function function_99d6508da7894de2(triggers) {
  foreach(trigger in triggers) {
    if(isDefined(trigger.script_team)) {
      trigger.script_team = game[trigger.script_team];
    }
  }
}