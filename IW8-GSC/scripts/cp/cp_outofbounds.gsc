/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_outofbounds.gsc
***********************************************/

function registerentforoob(var0, var1) {
  var0.oobref = var1;
}

function deregisterentforoob(var0) {
  var0.oobref = undefined;
}

function registeroobentercallback(var0, var1) {
  var2 = getoobdata();
  var2.entercallbacks[var0] = var1;
}

function registeroobexitcallback(var0, var1) {
  var2 = getoobdata();
  var2.exitcallbacks[var0] = var1;
}

function registerooboutoftimecallback(var0, var1) {
  var2 = getoobdata();
  var2.outoftimecallbacks[var0] = var1;
}

function registeroobclearcallback(var0, var1) {
  var2 = getoobdata();
  var2.clearcallbacks[var0] = var1;
}

function isoob(var0, var1) {
  if(isoobimmune(var0)) {
    return false;
  }

  if(istrue(var1) && isoobimmune(var0)) {
    return false;
  }

  return isDefined(var0.oob) && var0.oob > 0;
}

function enableoob(var0) {
  if(!isDefined(var0.oob)) {
    var0.oob = 0;
  }

  var0.oob++;

  if(var0.oob == 1) {
    if(!isDefined(var0.oobimmunity) || var0.oobimmunity <= 0) {
      onenteroob(var0);
      return;
    }

    return;
  }
}

function disableoob(var0) {
  var0.oob--;

  if(var0.oob == 0) {
    var0.oob = undefined;

    if(!isDefined(var0.oobimmunity) || var0.oobimmunity <= 0) {
      onexitoob(var0, 0);
      return;
    }

    return;
  }
}

function isoobimmune(var0) {
  return isDefined(var0.oobimmunity) && var0.oobimmunity > 0;
}

function enableoobimmunity(var0) {
  if(!isDefined(var0.oobimmunity)) {
    var0.oobimmunity = 0;
  }

  var0.oobimmunity++;

  if(var0.oobimmunity == 1) {
    if(isDefined(var0.oob) && var0.oob > 0) {
      onexitoob(var0, 0);
      return;
    }

    return;
  }
}

function disableoobimmunity(var0) {
  var0.oobimmunity--;

  if(var0.oobimmunity == 0) {
    var0.oobimmunity = undefined;

    if(isDefined(var0.oob) && var0.oob > 0) {
      onenteroob(var0);
      return;
    }

    return;
  }
}

function clearoob(var0, var1) {
  var0 notify("clear_oob");

  if(isoob(var0, 1)) {
    onexitoob(var0, var1, 1);
  }

  var2 = undefined;

  if(isPlayer(var0)) {
    var2 = &playerclearcallback;
  } else if(isDefined(var0.oobref)) {
    var3 = getoobdata();
    var2 = var3.clearcallbacks[var0.oobref];
  }

  if(isDefined(var2)) {
    var0[[var2]]();
  }

  var0.oobref = undefined;
  var0.oob = undefined;
  var0.oobimmunity = undefined;
  var0.oobtimeleft = undefined;
  var0.oobendtime = undefined;
  var0.oobtriggertype = undefined;

  if(isDefined(var0.oobtriggers)) {
    foreach(var5 in var0.oobtriggers) {
      var5.entstouching[var0 getentitynumber()] = undefined;
    }

    var0.oobtriggers = undefined;
  }

  if(isDefined(var0.oobsupressiontriggers)) {
    foreach(var5 in var0.oobsupressiontriggers) {
      var5.entstouching[var0 getentitynumber()] = undefined;
    }

    var0.oobsupressiontriggers = undefined;
    return;
  }
}

function initoob() {
  if(!isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers = [];
  }

  var0 = getEntArray("OutOfBounds", "targetname");

  foreach(var2 in var0) {
    level.outofboundstriggers[level.outofboundstriggers.size] = var2;
  }

  thread watchoobtriggers();
}

function basic_combat(var0) {
  if(isDefined(level.outofboundstriggers)) {
    level.outofboundstriggers[level.outofboundstriggers.size] = var0;
  } else {
    level.outofboundstriggers[0] = var0;
  }

  thread watchoobtrigger(var0);
}

function onenteroob(var0) {
  var1 = undefined;
  var2 = getlastoobtrigger(var0);
  var3 = gettriggertype(var0, var2);

  if(isPlayer(var0)) {
    var1 = &playerentercallback;
  } else if(isDefined(var0.oobref)) {
    var4 = getoobdata();
    var1 = var4.entercallbacks[var0.oobref];
  }

  var0 notify("oob_cooldown_end");

  if(isDefined(var0.oobtimeleft)) {
    var5 = var0.oobtimeleft / 1000;
    var0.oobendtime = int(gettime() + var0.oobtimeleft);
    var0.oobtimeleft = undefined;
    thread watchooboutoftime(var0, var5);
  } else {
    var1.oobtimeleft = undefined;
    var1.oobtriggertype = var5;
    var5 = getoutofboundstime(var5);
    var1.oobendtime = int(gettime() + var5 * 1000);
    thread watchooboutoftime(var1, var5);
  }

  if(isDefined(var2)) {
    var1 thread[[var2]]("exit_oob", "clear_oob");
    return;
  }
}

function onexitoob(var0, var1, var2) {
  var0 notify("exit_oob");
  var3 = undefined;

  if(isPlayer(var0)) {
    var3 = &playerexitcallback;
  } else if(isDefined(var0.oobref)) {
    var4 = getoobdata();
    var3 = var4.exitcallbacks[var0.oobref];
  }

  var0 notify("oob_timeout_end");

  if(!istrue(var2)) {
    if(isDefined(var0.oobendtime)) {
      var0.oobtimeleft = int(max(0, var0.oobendtime - gettime()));
      var0.oobendtime = undefined;
      var5 = getlastoobtrigger(var0);
      var6 = gettriggertype(var0, var5);
      var7 = getcooldowntime(var6);
      thread watchoobcooldown(var0, var7);
    }
  }

  if(isDefined(var3)) {
    var0 thread[[var3]](var1, var2, "clear_oob");
    return;
  }
}

function onooboutoftime(var0) {
  var1 = undefined;

  if(isPlayer(var0)) {
    var1 = &playeroutoftimecallback;
  } else if(isDefined(var0.oobref)) {
    var2 = getoobdata();
    var1 = var2.outoftimecallbacks[var0.oobref];
  }

  if(isDefined(var1)) {
    var0 thread[[var1]]("oob_timeout_end", "clear_oob");
    return;
  }
}

function watchooboutoftime(var0, var1) {
  if(isPlayer(var0)) {
    var0 endon("death_or_disconnect");
  } else {
    var0 endon("death");
  }

  var0 notify("oob_timeout_end");
  var0 endon("oob_timeout_end");
  var0 endon("clear_oob");
  wait var1;
  thread onooboutoftime(var0);
}

function watchoobcooldown(var0, var1) {
  if(isPlayer(var0)) {
    var0 endon("death_or_disconnect");
  } else {
    var0 endon("death");
  }

  var0 notify("oob_cooldown_end");
  var0 endon("oob_cooldown_end");
  var0 endon("clear_oob");
  wait var1;
  var0.oobtimeleft = undefined;
  var0.oobtriggertype = undefined;
}

function playerentercallback(var0, var1) {
  self setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
}

function playerexitcallback(var0, var1, var2) {
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function playeroutoftimecallback(var0, var1) {
  var2 = getlastoobtrigger(self);
  var3 = gettriggertype(self, var2);

  if(var3 == "minefield") {
    thread playeroutoftimeminefield(var0, var1);
    return;
  }

  self.oob = 1;
  self.shouldskiplaststand = 1;
  self dodamage(self.health + 100, self.origin);
}

function playerclearcallback(var0) {
  self setclientomnvar("ui_out_of_bounds_countdown", 0);
}

function playeroutoftimeminefield(var0, var1) {
  var2 = self.origin;
  var3 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self);

  if(isDefined(var3["hittype"] != "hittype_none") && isDefined(var3["position"])) {
    var2 = var3["position"];
  }

  var4 = spawn("script_model", var2);
  var4 setModel("ks_minefield_mp");
  var4 setentityowner(self);
  var4 setotherent(self);
  var4 setscriptablepartstate("warning_click", "on", 0);
  var5 = playeroutoftimeminefieldinternal(var4, var0, var1);

  if(istrue(var5)) {
    wait 2;
  }

  var4 delete();
}

function playeroutoftimeminefieldinternal(var0, var1, var2) {
  self endon("death_or_disconnect");

  if(isDefined(var1)) {
    self endon(var1);
  }

  if(isDefined(var2)) {
    self endon(var2);
  }

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  var0 setscriptablepartstate("explosion", "on", 0);
  self.shouldskiplaststand = 1;
  self dodamage(2000, self.origin, self, self, "MOD_EXPLOSIVE", "minefield_mp");
  return true;
}

function killstreakentercallback(var0, var1) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", self.oobendtime);
    return;
  }
}

function killstreakexitcallback(var0, var1, var2) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("ui_out_of_bounds_countdown", 0);
    return;
  }
}

function killstreakoutoftimecallback(var0, var1) {
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
    foreach(var1 in level.outofboundstriggers) {
      thread watchoobtrigger(var1);
    }

    if(isDefined(level.outofboundstriggerpatches)) {
      foreach(var1 in level.outofboundstriggerpatches) {
        thread watchoobsuppressiontrigger(var1);
      }

      return;
    }

    return;
  }
}

function watchoobtrigger(var0) {
  var0.entstouching = [];
  thread watchoobtriggerexit(var0);
  thread watchoobtriggerenter(var0);
}

function watchoobtriggerenter(var0) {
  level endon("game_ended");
  var0 endon("death");

  for(;;) {
    var0 waittill("trigger", var1);

    if(isPlayer(var1)) {
      if(isDefined(var1.c130)) {
        continue;
      }

      if(istrue(var1.inlaststand) && !scripts\cp\utility::tryingtoleave()) {
        var1 notify("force_bleed_out");
        continue;
      }
    }

    if(isDefined(var0.script_team)) {
      var2 = 0;

      if(var1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        var2 = 1;
      }

      if(var2 && isDefined(var1.owner) && var1.owner.team != var0.script_team) {
        continue;
      }

      if(!var2 && var1.team != var0.script_team) {
        continue;
      }
    }

    if(!interactswithoobtriggers(var1)) {
      continue;
    }

    onenteroobtrigger(var0, var1);
  }
}

function watchoobtriggerexit(var0) {
  level endon("game_ended");
  var0 endon("death");

  for(;;) {
    var1 = var0.entstouching;

    foreach(var3 in var1) {
      if(!isDefined(var3)) {
        var0.entstouching[var4] = undefined;
      }

      if(isDefined(var3) && !var0 istouching(var3)) {
        onexitoobtrigger(var0, var3);
      }
    }

    waitframe();
  }
}

function onenteroobtrigger(var0, var1) {
  var2 = var1 getentitynumber();

  if(isDefined(var0.entstouching[var2])) {
    return;
  }

  var0.entstouching[var2] = var1;

  if(!isDefined(var1.oobtriggers)) {
    var1.oobtriggers = [];
  }

  var3 = [var0];

  foreach(var5 in var1.oobtriggers) {
    var3 = var5;
  }

  var1.oobtriggers = var3;
  enableoob(var1);
}

function onexitoobtrigger(var0, var1) {
  var2 = var1 getentitynumber();
  var0.entstouching[var2] = undefined;
  disableoob(var1);
  var1.oobtriggers = scripts\engine\utility::array_remove(var1.oobtriggers, var0);

  if(var1.oobtriggers.size == 0) {
    var1.oobtriggers = undefined;
    return;
  }
}

function watchoobsuppressiontrigger(var0) {
  var0.entstouching = [];
  wait 10;
  thread watchoobsuppressiontriggerexit();
  thread watchoobsupressiontriggerenter();
}

function watchoobsupressiontriggerenter(var0) {
  level endon("game_ended");

  for(;;) {
    var0 waittill("trigger", var1);

    if(!interactswithoobtriggers(var1)) {
      continue;
    }

    onenteroobsuppressiontrigger(var0, var1);
  }
}

function watchoobsuppressiontriggerexit(var0) {
  level endon("game_ended");

  for(;;) {
    var1 = var0.entstouching;

    foreach(var3 in var1) {
      if(!isDefined(var3)) {
        var0.entstouching[var4] = undefined;
      }

      if(!var0 istouching(var3)) {
        onexitoobsupressiontrigger(var0, var3);
      }
    }
  }
}

function onenteroobsuppressiontrigger(var0, var1) {
  var2 = var1 getentitynumber();

  if(isDefined(var0.entstouching[var2])) {
    return;
  }

  var0.entstouching[var2] = var1;

  if(!isDefined(var1.oobsupressiontriggers)) {
    var1.oobsupressiontriggers = [];
  }

  var1.oobsupressiontriggers[var0 getentitynumber()] = var0;
  enableoobimmunity(var1);
}

function onexitoobsupressiontrigger(var0, var1) {
  var2 = var1 getentitynumber();
  var0.entstouching[var2] = undefined;
  var1.oobsupressiontriggers[var0 getentitynumber()] = undefined;

  if(var1.oobsupressiontriggers.size == 0) {
    var1.oobsupressiontriggers = undefined;
  }

  disableoobimmunity(var1);
}

function interactswithoobtriggers(var0) {
  if(isDefined(var0)) {
    if(isPlayer(var0)) {
      if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
        return true;
      }
    }

    if(isDefined(var0.oobref)) {
      if(var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(var0.isdestroyed)) {
          return true;
        }
      }

      if(isDefined(var0.streakinfo) && iskillstreakaffectedbyobb(var0.streakinfo.streakname)) {
        return true;
      }
    }
  }

  return false;
}

function getoobdata() {
  var0 = level.oobdata;

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.entercallbacks = [];
    var0.exitcallbacks = [];
    var0.outoftimecallbacks = [];
    var0.clearcallbacks = [];
    level.oobdata = var0;
  }

  return var0;
}

function iskillstreakaffectedbyobb(var0) {
  var1 = 0;

  switch (var0) {
    case "radar_drone_recon":
    case "pac_sentry":
      var1 = 1;
      break;
  }

  return var1;
}

function gettriggertype(var0, var1) {
  var2 = "default";

  if(isDefined(var0) && var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return "default";
  }

  if(isDefined(var0) && isDefined(var0.streakinfo)) {
    return "default";
  }

  if(isDefined(var1) && isDefined(var1.script_noteworthy) && var1.script_noteworthy == "MineField") {
    var2 = "minefield";
  }

  return var2;
}

function getcooldowntime(var0) {
  switch (var0) {
    case "minefield":
      return getmaxoutofboundscooldown();
    case "default":
      return getmaxoutofboundsminefieldtime();
  }

  return undefined;
}

function getoutofboundstime(var0) {
  switch (var0) {
    case "minefield":
      return getmaxoutofboundsminefieldtime();
    case "default":
      return getmaxoutofboundstime();
  }

  return undefined;
}

function getlastoobtrigger(var0) {
  if(isDefined(var0.oobtriggers)) {
    return var0.oobtriggers[0];
  }

  return undefined;
}

function getmaxoutofboundstime() {
  var0 = level.outofboundstime;

  if(!isDefined(var0)) {
    var0 = max(0, getdvarfloat("scr_outOfBoundsTime", 3));
    level.outofboundstime = var0;
  }

  return var0;
}

function getmaxoutofboundscooldown() {
  var0 = level.outofboundscooldown;

  if(!isDefined(var0)) {
    var0 = max(0, getdvarfloat("scr_outOfBoundsCooldown", 3));
    level.outofboundscooldown = var0;
  }

  return var0;
}

function getmaxoutofboundsminefieldtime() {
  var0 = level.outofboundstimeminefield;

  if(!isDefined(var0)) {
    var0 = max(0, getdvarfloat("scr_outOfBoundsTimeMinefield", 3));
    level.outofboundstimeminefield = var0;
  }

  return var0;
}