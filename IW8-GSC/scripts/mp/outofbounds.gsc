/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\outofbounds.gsc
***********************************************/

function registerentforoob(var_0, var_1) {
  var_0.oobref = var_1;
}

function deregisterentforoob(var_0) {
  var_0.oobref = undefined;
}

function registeroobentercallback(var_0, var_1) {
  var_2 = getoobdata();
  var_2.entercallbacks[var_0] = var_1;
}

function registeroobexitcallback(var_0, var_1) {
  var_2 = getoobdata();
  var_2.exitcallbacks[var_0] = var_1;
}

function registerooboutoftimecallback(var_0, var_1) {
  var_2 = getoobdata();
  var_2.outoftimecallbacks[var_0] = var_1;
}

function registeroobclearcallback(var_0, var_1) {
  var_2 = getoobdata();
  var_2.clearcallbacks[var_0] = var_1;
}

function unset_relic_rocket_kill_ammo(var_0) {
  if(scripts\mp\utility\game::unset_relic_grounded() && isDefined(level.br_ispointinboundsfunc)) {
    return [[level.br_ispointinboundsfunc]](var_0, 0, 1);
  }

  return !ispointinoutofbounds(var_0);
}

function isoob(var_0, var_1) {
  if(isoobimmune(var_0)) {
    return false;
  }

  if(istrue(var_1) && isoobimmune(var_0)) {
    return false;
  }

  return isDefined(var_0.oob) && var_0.oob > 0;
}

function enableoob(var_0) {
  if(!isDefined(var_0.oob)) {
    var_0.oob = 0;
  }

  var_0.oob++;

  if(var_0.oob == 1) {
    if(!isDefined(var_0.oobimmunity) || var_0.oobimmunity <= 0) {
      onenteroob(var_0);
      return;
    }

    return;
  }
}

function disableoob(var_0) {
  var_0.oob--;

  if(var_0.oob == 0) {
    var_0.oob = undefined;

    if(!isDefined(var_0.oobimmunity) || var_0.oobimmunity <= 0) {
      onexitoob(var_0, 0);
      return;
    }

    return;
  }
}

function isoobimmune(var_0) {
  return isDefined(var_0.oobimmunity) && var_0.oobimmunity > 0;
}

function enableoobimmunity(var_0) {
  if(!isDefined(var_0.oobimmunity)) {
    var_0.oobimmunity = 0;
  }

  var_0.oobimmunity++;

  if(var_0.oobimmunity == 1) {
    if(isDefined(var_0.oob) && var_0.oob > 0) {
      onexitoob(var_0, 0);
      return;
    }

    return;
  }
}

function disableoobimmunity(var_0) {
  var_0.oobimmunity--;

  if(var_0.oobimmunity == 0) {
    var_0.oobimmunity = undefined;

    if(isDefined(var_0.oob) && var_0.oob > 0) {
      onenteroob(var_0);
      return;
    }

    return;
  }
}

function clearoob(var_0, var_1) {
  var_0 notify("clear_oob");

  if(isoob(var_0, 1)) {
    onexitoob(var_0, var_1, 1);
  }

  var_2 = undefined;

  if(isPlayer(var_0)) {
    var_2 = &playerclearcallback;
  } else if(isDefined(var_0.oobref)) {
    var_3 = getoobdata();
    var_2 = var_3.clearcallbacks[var_0.oobref];
  }

  if(isDefined(var_2)) {
    var_0[[var_2]]();
  }

  var_0.oobref = undefined;
  var_0.oob = undefined;
  var_0.oobimmunity = undefined;
  var_0.oobtimeleft = undefined;
  var_0.oobendtime = undefined;
  var_0.oobtriggertype = undefined;

  if(isDefined(var_0.oobtriggers)) {
    foreach(var_5 in var_0.oobtriggers) {
      var_5.entstouching[var_0 getentitynumber()] = undefined;
    }

    var_0.oobtriggers = undefined;
  }

  if(isDefined(var_0.oobsupressiontriggers)) {
    foreach(var_5 in var_0.oobsupressiontriggers) {
      var_5.entstouching[var_0 getentitynumber()] = undefined;
    }

    var_0.oobsupressiontriggers = undefined;
    return;
  }
}

function istouchingoobtrigger() {
  if(istrue(self.allowedintrigger)) {
    return false;
  }

  if(!isDefined(level.outofboundstriggers)) {
    return false;
  }

  foreach(var_1 in level.outofboundstriggers) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(!interactswithgivenoobtrigger(var_1, self)) {
      continue;
    }

    if(self istouching(var_1)) {
      return true;
    }
  }

  return false;
}

function ispointinoutofbounds(var_0, var_1) {
  if(!isDefined(level.outofboundstriggers)) {
    return 0;
  }

  foreach(var_3 in level.outofboundstriggers) {
    if(isDefined(var_3) && ispointinvolume(var_0, var_3)) {
      if(isDefined(var_3.script_team) && isDefined(var_1) && var_3.script_team != var_1) {
        continue;
      }

      return 1;
    }
  }

  return 0;
}

function useshouldsucceedcallback(var_0) {
  var_1 = 16;
  var_2 = physics_createcontents(["physicscontents_playertrigger"]);
  var_3 = physics_spherecast(var_0, var_0, var_1, var_2, undefined, "physicsquery_all");

  foreach(var_5 in var_3) {
    var_6 = var_5["entity"];

    if(isDefined(var_6) && isDefined(var_6.targetname) && var_6.targetname == "OutOfBounds") {
      return true;
    }
  }

  return false;
}

function initoob() {
  thread watchoobtriggers();
}

function onenteroob(var_0) {
  var_1 = undefined;
  var_2 = getlastoobtrigger(var_0);
  var_3 = gettriggertype(var_0, var_2);

  if(isPlayer(var_0)) {
    if(isDefined(level.ref_11c7b)) {
      var_1 = level.ref_11c7b;
    } else {
      var_1 = &playerentercallback;
    }
  } else if(isDefined(var_0.oobref)) {
    var_4 = getoobdata();
    var_1 = var_4.entercallbacks[var_0.oobref];
  }

  var_0 notify("oob_cooldown_end");

  if(isDefined(var_0.oobtimeleft) && previouslytouchedtriggertype(var_0, var_3)) {
    var_5 = var_0.oobtimeleft / 1000;
    var_0.oobendtime = int(gettime() + var_0.oobtimeleft);
    var_0.oobtimeleft = undefined;
    thread watchooboutoftime(var_0, var_5);
  } else {
    var_1.oobtimeleft = undefined;
    var_1.oobtriggertype = var_5;
    var_5 = getoutofboundstime(var_5, var_1);
    var_1.oobendtime = int(gettime() + var_5 * 1000);
    thread watchooboutoftime(var_1, var_5);
  }

  if(isDefined(var_2)) {
    var_1 thread[[var_2]]("exit_oob", "clear_oob", var_5);
    return;
  }
}

function onexitoob(var_0, var_1, var_2) {
  var_0 notify("exit_oob");
  var_3 = undefined;

  if(isPlayer(var_0)) {
    if(isDefined(level.ref_11c7c)) {
      var_3 = level.ref_11c7c;
    } else {
      var_3 = &playerexitcallback;
    }
  } else if(isDefined(var_0.oobref)) {
    var_4 = getoobdata();
    var_3 = var_4.exitcallbacks[var_0.oobref];
  }

  var_0 notify("oob_timeout_end");

  if(!istrue(var_2)) {
    if(isDefined(var_0.oobendtime)) {
      var_0.oobtimeleft = int(max(0, var_0.oobendtime - gettime()));
      var_0.oobendtime = undefined;
      var_5 = getlastoobtrigger(var_0);
      var_6 = gettriggertype(var_0, var_5);
      var_7 = getcooldowntime(var_6);
      thread watchoobcooldown(var_0, var_7);
    }
  }

  if(isDefined(var_3)) {
    var_0 thread[[var_3]](var_1, var_2, "clear_oob");
    return;
  }
}

function onooboutoftime(var_0) {
  var_1 = undefined;

  if(isPlayer(var_0)) {
    var_2 = 1;

    if(level.gametype == "br") {
      if(istrue(level.stop_end_breach_fx)) {
        var_2 = 0;
      } else if(isDefined(level.matchcountdowntime) && level.matchcountdowntime < 2) {
        var_2 = 0;
      }
    }

    if(var_2) {
      var_1 = &playeroutoftimecallback;
    }
  } else if(isDefined(var_0.oobref)) {
    var_3 = getoobdata();
    var_1 = var_3.outoftimecallbacks[var_0.oobref];
  }

  if(isDefined(var_1)) {
    var_0 thread[[var_1]]("oob_timeout_end", "clear_oob");
    return;
  }
}

function watchooboutoftime(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_0 endon("death_or_disconnect");
  } else {
    var_0 endon("death");
  }

  var_0 notify("oob_timeout_end");
  var_0 endon("oob_timeout_end");
  var_0 endon("clear_oob");
  wait var_1;
  thread onooboutoftime(var_0);
}

function watchoobcooldown(var_0, var_1) {
  if(isPlayer(var_0)) {
    var_0 endon("death_or_disconnect");
  } else {
    var_0 endon("death");
  }

  var_0 notify("oob_cooldown_end");
  var_0 endon("oob_cooldown_end");
  var_0 endon("clear_oob");
  wait var_1;
  var_0.oobtimeleft = undefined;
  var_0.oobtriggertype = undefined;
}

function playerentercallback(var_0, var_1, var_2) {
  var_3 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isDefined(var_2) && var_2 == "restricted") {
    var_3 = 2;
  }

  self setclientomnvar("ui_out_of_bounds_type", var_3);
  self setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

function playerexitcallback(var_0, var_1, var_2) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function playeroutoftimecallback(var_0, var_1) {
  var_2 = getlastoobtrigger(self);
  var_3 = gettriggertype(self, var_2);

  if(var_3 == "minefield") {
    thread playeroutoftimeminefield(var_0, var_1);
    return;
  }

  if(!isDefined(self.plotarmor) || !self.plotarmor) {
    scripts\mp\utility\damage::_suicide();
    return;
  }
}

function playerclearcallback(var_0) {
  self setclientomnvar("ui_out_of_bounds_type", 0);
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function playeroutoftimeminefield(var_0, var_1) {
  var_2 = self.origin;
  var_3 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self);

  if(isDefined(var_3["hittype"] != "hittype_none") && isDefined(var_3["position"])) {
    var_2 = var_3["position"];
  }

  var_4 = spawn("script_model", var_2);
  var_4 setModel("ks_minefield_mp");
  var_4 setentityowner(self);
  var_4 setotherent(self);
  var_4 setscriptablepartstate("warning_click", "on", 0);
  var_5 = playeroutoftimeminefieldinternal(var_4, var_0, var_1);

  if(istrue(var_5)) {
    wait 2;
  }

  var_4 delete();
}

function playeroutoftimeminefieldinternal(var_0, var_1, var_2) {
  self endon("death_or_disconnect");

  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  var_0 setscriptablepartstate("explosion", "on", 0);
  wait 0.05;
  self dodamage(2000, self.origin, self, var_0, "MOD_EXPLOSIVE", "minefield_mp");
  return true;
}

function killstreakentercallback(var_0, var_1, var_2) {
  var_3 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "arm" && isDefined(var_2) && var_2 == "restricted") {
    var_3 = 2;
  }

  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", var_3);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
    return;
  }
}

function killstreakexitcallback(var_0, var_1, var_2) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", 0);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
    return;
  }
}

function killstreakoutoftimecallback(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    var_2 = "nuke_mp";
  } else {
    var_2 = "danger_circle_br";
  }

  scripts\mp\utility\killstreak::dodamagetokillstreak(10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", var_2);
}

function killstreakclearcallback() {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_type", 0);
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
    return;
  }
}

function killstreakregisteroobcallbacks() {
  registeroobentercallback("killstreak", &killstreakentercallback);
  registeroobexitcallback("killstreak", &killstreakexitcallback);
  registerooboutoftimecallback("killstreak", &killstreakoutoftimecallback);
  registeroobclearcallback("killstreak", &killstreakclearcallback);
}

function watchoobtriggers() {
  if(scripts\mp\utility\game::lpcfeaturegated() && scripts\mp\utility\game::getgametype() != "arm" && scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(var_1 in level.outofboundstriggers) {
      thread watchoobtrigger(var_1);
    }

    if(isDefined(level.outofboundstriggerpatches)) {
      foreach(var_1 in level.outofboundstriggerpatches) {
        thread watchoobsuppressiontrigger(var_1);
      }

      return;
    }

    return;
  }
}

function watchoobtrigger(var_0) {
  var_0.entstouching = [];

  if(scripts\mp\utility\game::getgametype() != "br") {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  thread watchoobtriggerexit(var_0);
  thread watchoobtriggerenter(var_0);
}

function watchoobtriggerenter(var_0) {
  level endon("game_ended");
  var_0 endon("clearOOB");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      if(scripts\mp\utility\game::updatehistoryhud(var_1)) {
        continue;
      } else if(isDefined(var_1.vehicle) && isDefined(var_1.vehicle.turrets)) {
        foreach(var_3 in var_1.vehicle.turrets) {
          if(scripts\engine\utility::is_equal(var_3.owner, var_1)) {
            var_1 = var_1.vehicle;
            break;
          }
        }
      }
    }

    if(!interactswithgivenoobtrigger(var_0, var_1)) {
      continue;
    }

    if(!interactswithoobtriggers(var_1)) {
      continue;
    }

    onenteroobtrigger(var_0, var_1);
  }
}

function watchoobtriggerexit(var_0) {
  level endon("game_ended");
  var_0 endon("clearOOB");
  var_0 endon("death");

  for(;;) {
    var_1 = var_0.entstouching;

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        var_0.entstouching[var_4] = undefined;
      }

      if(isDefined(var_3) && !var_0 istouching(var_3)) {
        onexitoobtrigger(var_0, var_3);
      }
    }

    waitframe();
  }
}

function onenteroobtrigger(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.entstouching[var_2])) {
    return;
  }

  var_0.entstouching[var_2] = var_1;

  if(!isDefined(var_1.oobtriggers)) {
    var_1.oobtriggers = [];
  }

  var_3 = [var_0];

  foreach(var_5 in var_1.oobtriggers) {
    var_3 = var_5;
  }

  var_1.oobtriggers = var_3;
  enableoob(var_1);
}

function onexitoobtrigger(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_0.entstouching[var_2] = undefined;
  disableoob(var_1);
  var_1.oobtriggers = scripts\engine\utility::array_remove(var_1.oobtriggers, var_0);

  if(var_1.oobtriggers.size == 0) {
    var_1.oobtriggers = undefined;
    return;
  }
}

function watchoobsuppressiontrigger(var_0) {
  var_0.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchoobsuppressiontriggerexit(var_0);
  thread watchoobsupressiontriggerenter(var_0);
}

function watchoobsupressiontriggerenter(var_0) {
  level endon("game_ended");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!interactswithoobtriggers(var_1)) {
      continue;
    }

    onenteroobsuppressiontrigger(var_0, var_1);
  }
}

function watchoobsuppressiontriggerexit(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = var_0.entstouching;

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {
        if(!isDefined(var_3)) {
          var_0.entstouching[var_4] = undefined;
        }

        if(isDefined(var_3) && !var_0 istouching(var_3)) {
          onexitoobsupressiontrigger(var_0, var_3);
        }
      }
    }

    waitframe();
  }
}

function onenteroobsuppressiontrigger(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.entstouching[var_2])) {
    return;
  }

  var_0.entstouching[var_2] = var_1;

  if(!isDefined(var_1.oobsupressiontriggers)) {
    var_1.oobsupressiontriggers = [];
  }

  var_3 = [var_0];

  foreach(var_5 in var_1.oobsupressiontriggers) {
    var_3 = var_5;
  }

  var_1.oobsupressiontriggers = var_3;
  enableoobimmunity(var_1);
}

function onexitoobsupressiontrigger(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_0.entstouching[var_2] = undefined;
  var_1.oobsupressiontriggers[var_0 getentitynumber()] = undefined;

  if(var_1.oobsupressiontriggers.size == 0) {
    var_1.oobsupressiontriggers = undefined;
  }

  disableoobimmunity(var_1);
}

function interactswithgivenoobtrigger(var_0, var_1) {
  if(isDefined(var_0.script_team)) {
    if(scripts\mp\utility\game::unset_relic_landlocked()) {
      return false;
    }

    var_2 = 0;

    if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      var_2 = 1;
    }

    if(var_2) {
      if(var_2 && isDefined(var_1.team) && var_1.team != "neutral" && var_1.team != var_0.script_team) {
        return false;
      }

      if(var_2 && isDefined(var_1.owner) && var_1.owner.team != var_0.script_team) {
        return false;
      }

      if(var_2 && isDefined(var_1.occupants)) {
        foreach(var_4 in var_1.occupants) {
          if(var_4.team != var_0.script_team) {
            return false;
          }
        }
      }
    } else if(var_1.team != var_0.script_team) {
      return false;
    }
  }

  return true;
}

function interactswithoobtriggers(var_0) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
        return true;
      }
    }

    if(isDefined(var_0.oobref)) {
      if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(var_0.isdestroyed)) {
          return true;
        }
      }

      if(isDefined(var_0.streakinfo) && iskillstreakaffectedbyobb(var_0.streakinfo.streakname)) {
        return true;
      }
    }
  }

  return false;
}

function getoobdata() {
  var_0 = level.oobdata;

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.entercallbacks = [];
    var_0.exitcallbacks = [];
    var_0.outoftimecallbacks = [];
    var_0.clearcallbacks = [];
    level.oobdata = var_0;
  }

  return var_0;
}

function iskillstreakaffectedbyobb(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "radar_drone_recon":
    case "rcxd_rad":
    case "pac_sentry":
      var_1 = 1;
      break;
  }

  return var_1;
}

function gettriggertype(var_0, var_1) {
  var_2 = "default";

  if(level.gametype == "br") {
    return "br";
  }

  if(isDefined(var_1) && isDefined(var_1.script_team)) {
    return "restricted";
  }

  if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return "default";
  }

  if(isDefined(var_0) && isDefined(var_0.streakinfo)) {
    return "default";
  }

  if(isDefined(var_1) && isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "MineField") {
    var_2 = "minefield";
  }

  return var_2;
}

function getcooldowntime(var_0) {
  switch (var_0) {
    case "restricted":
    case "minefield":
    case "br":
    case "default":
      return scripts\mp\utility\game::getmaxoutofboundscooldown();
  }

  return undefined;
}

function getoutofboundstime(var_0, var_1) {
  var_2 = var_1.ref_12cce;

  if(istrue(var_2)) {
    return scripts\mp\utility\game::repair_grill_stop_exit_foley_sfx();
  }

  if(isDefined(var_2) && !var_2) {
    return scripts\mp\utility\game::repair_grill_start_enter_foley_sfx();
  }

  if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_3 = var_1 scripts\mp\utility\game::runbrgametypefunc();

    if(isDefined(var_3)) {
      return var_3;
    }
  }

  switch (var_0) {
    case "minefield":
      return scripts\mp\utility\game::getmaxoutofboundsminefieldtime();
    case "restricted":
      return scripts\mp\utility\game::getmaxoutofboundsrestrictedtime();
    case "br":
      return scripts\mp\utility\game::repair_grill_fixing_short_sfx();
    case "default":
      return scripts\mp\utility\game::getmaxoutofboundstime();
  }

  return undefined;
}

function getlastoobtrigger(var_0) {
  if(isDefined(var_0.oobtriggers)) {
    return var_0.oobtriggers[0];
  }

  return undefined;
}

function previouslytouchedtriggertype(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0.oobtriggertype)) {
    var_3 = var_0.oobtriggertype;

    if(var_1 == var_3) {
      var_2 = 1;
    } else if((var_1 == "default" || var_1 == "minefield") && (var_3 == "default" || var_3 == "minefield")) {
      var_2 = 1;
    }
  }

  return var_2;
}