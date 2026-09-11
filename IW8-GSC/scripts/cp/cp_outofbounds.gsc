/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outofbounds.gsc
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

function initoob() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var_0 = getEntArray("OutOfBounds", "targetname");

  foreach(var_2 in var_0) {
    level.outofboundstriggers[level.outofboundstriggers.size] = var_2;
  }

  thread watchoobtriggers();
}

function basic_combat(var_0) {
  if(isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers[level.outofboundstriggers.size] = var_0;
  } else {
    level.outofboundstriggers[0] = var_0;
  }

  thread watchoobtrigger(var_0);
}

function onenteroob(var_0) {
  var_1 = undefined;
  var_2 = getlastoobtrigger(var_0);
  var_3 = gettriggertype(var_0, var_2);

  if(isPlayer(var_0)) {
    var_1 = &playerentercallback;
  } else if(isDefined(var_0.oobref)) {
    var_4 = getoobdata();
    var_1 = var_4.entercallbacks[var_0.oobref];
  }

  var_0 notify("oob_cooldown_end");

  if(isDefined(var_0.oobtimeleft)) {
    var_5 = var_0.oobtimeleft / 1000;
    var_0.oobendtime = int(gettime() + var_0.oobtimeleft);
    var_0.oobtimeleft = undefined;
    thread watchooboutoftime(var_0, var_5);
  } else {
    var_1.oobtimeleft = undefined;
    var_1.oobtriggertype = var_5;
    var_5 = getoutofboundstime(var_5);
    var_1.oobendtime = int(gettime() + var_5 * 1000);
    thread watchooboutoftime(var_1, var_5);
  }

  if(isDefined(var_2)) {
    var_1 thread[[var_2]]("exit_oob", "clear_oob");
    return;
  }
}

function onexitoob(var_0, var_1, var_2) {
  var_0 notify("exit_oob");
  var_3 = undefined;

  if(isPlayer(var_0)) {
    var_3 = &playerexitcallback;
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
    var_1 = &playeroutoftimecallback;
  } else if(isDefined(var_0.oobref)) {
    var_2 = getoobdata();
    var_1 = var_2.outoftimecallbacks[var_0.oobref];
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

function playerentercallback(var_0, var_1) {
  self setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

function playerexitcallback(var_0, var_1, var_2) {
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function playeroutoftimecallback(var_0, var_1) {
  var_2 = getlastoobtrigger(self);
  var_3 = gettriggertype(self, var_2);

  if(var_3 == "minefield") {
    thread playeroutoftimeminefield(var_0, var_1);
    return;
  }

  self.oob = 1;
  self.shouldskiplaststand = 1;
  self dodamage(self.health + 100, self.origin);
}

function playerclearcallback(var_0) {
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

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  var_0 setscriptablepartstate("explosion", "on", 0);
  self.shouldskiplaststand = 1;
  self dodamage(2000, self.origin, self, self, "MOD_EXPLOSIVE", "minefield_mp");
  return true;
}

function killstreakentercallback(var_0, var_1) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
    return;
  }
}

function killstreakexitcallback(var_0, var_1, var_2) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
    return;
  }
}

function killstreakoutoftimecallback(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "doDamageToKillstreak")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "nuke_mp");
    return;
  }
}

function killstreakclearcallback() {
  if(isDefined(self.owner)) {
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
  thread watchoobtriggerexit(var_0);
  thread watchoobtriggerenter(var_0);
}

function watchoobtriggerenter(var_0) {
  level endon("game_ended");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      if(isDefined(var_1.c130)) {
        continue;
      }

      if(istrue(var_1.inlaststand) && !scripts\cp\utility::tryingtoleave()) {
        var_1 notify("force_bleed_out");
        continue;
      }
    }

    if(isDefined(var_0.script_team)) {
      var_2 = 0;

      if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        var_2 = 1;
      }

      if(var_2 && isDefined(var_1.owner) && var_1.owner.team != var_0.script_team) {
        continue;
      }

      if(!var_2 && var_1.team != var_0.script_team) {
        continue;
      }
    }

    if(!interactswithoobtriggers(var_1)) {
      continue;
    }

    onenteroobtrigger(var_0, var_1);
  }
}

function watchoobtriggerexit(var_0) {
  level endon("game_ended");
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
  wait 10;
  thread watchoobsuppressiontriggerexit();
  thread watchoobsupressiontriggerenter();
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

    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        var_0.entstouching[var_4] = undefined;
      }

      if(!var_0 istouching(var_3)) {
        onexitoobsupressiontrigger(var_0, var_3);
      }
    }
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

  var_1.oobsupressiontriggers[var_0 getentitynumber()] = var_0;
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
    case "pac_sentry":
      var_1 = 1;
      break;
  }

  return var_1;
}

function gettriggertype(var_0, var_1) {
  var_2 = "default";

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
    case "minefield":
      return getmaxoutofboundscooldown();
    case "default":
      return getmaxoutofboundsminefieldtime();
  }

  return undefined;
}

function getoutofboundstime(var_0) {
  switch (var_0) {
    case "minefield":
      return getmaxoutofboundsminefieldtime();
    case "default":
      return getmaxoutofboundstime();
  }

  return undefined;
}

function getlastoobtrigger(var_0) {
  if(isDefined(var_0.oobtriggers)) {
    return var_0.oobtriggers[0];
  }

  return undefined;
}

function getmaxoutofboundstime() {
  var_0 = level.outofboundstime;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("scr_outOfBoundsTime", 3));
    level.outofboundstime = var_0;
  }

  return var_0;
}

function getmaxoutofboundscooldown() {
  var_0 = level.outofboundscooldown;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("scr_outOfBoundsCooldown", 3));
    level.outofboundscooldown = var_0;
  }

  return var_0;
}

function getmaxoutofboundsminefieldtime() {
  var_0 = level.outofboundstimeminefield;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("scr_outOfBoundsTimeMinefield", 3));
    level.outofboundstimeminefield = var_0;
  }

  return var_0;
}