/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_outofbounds.gsc
***********************************************/

registerentforoob(var_0, var_1) {
  var_0.oobref = var_1;
}

deregisterentforoob(var_0) {
  var_0.oobref = undefined;
}

registeroobentercallback(var_0, var_1) {
  var_2 = getoobdata();
  var_2.entercallbacks[var_0] = var_1;
}

registeroobexitcallback(var_0, var_1) {
  var_2 = getoobdata();
  var_2.exitcallbacks[var_0] = var_1;
}

registerooboutoftimecallback(var_0, var_1) {
  var_2 = getoobdata();
  var_2.outoftimecallbacks[var_0] = var_1;
}

registeroobclearcallback(var_0, var_1) {
  var_2 = getoobdata();
  var_2.clearcallbacks[var_0] = var_1;
}

isoob(var_0, var_1) {
  if(isoobimmune(var_0))
    return 0;

  if(istrue(var_1) && isoobimmune(var_0))
    return 0;

  return isDefined(var_0.oob) && var_0.oob > 0;
}

enableoob(var_0) {
  if(!isDefined(var_0.oob))
    var_0.oob = 0;

  var_0.oob++;

  if(var_0.oob == 1) {
    if(!isDefined(var_0.oobimmunity) || var_0.oobimmunity <= 0)
      onenteroob(var_0);
  }
}

disableoob(var_0) {
  var_0.oob--;

  if(var_0.oob == 0) {
    var_0.oob = undefined;

    if(!isDefined(var_0.oobimmunity) || var_0.oobimmunity <= 0)
      onexitoob(var_0, 0);
  }
}

isoobimmune(var_0) {
  return isDefined(var_0.oobimmunity) && var_0.oobimmunity > 0;
}

enableoobimmunity(var_0) {
  if(!isDefined(var_0.oobimmunity))
    var_0.oobimmunity = 0;

  var_0.oobimmunity++;

  if(var_0.oobimmunity == 1) {
    if(isDefined(var_0.oob) && var_0.oob > 0)
      onexitoob(var_0, 0);
  }
}

disableoobimmunity(var_0) {
  var_0.oobimmunity--;

  if(var_0.oobimmunity == 0) {
    var_0.oobimmunity = undefined;

    if(isDefined(var_0.oob) && var_0.oob > 0)
      onenteroob(var_0);
  }
}

clearoob(var_0, var_1) {
  var_0 notify("_encstr_8A930A9BA489684B49377049");

  if(isoob(var_0, 1))
    onexitoob(var_0, var_1, 1);

  var_2 = undefined;

  if(isPlayer(var_0))
    var_2 = ::playerclearcallback;
  else if(isDefined(var_0.oobref)) {
    var_3 = getoobdata();
    var_2 = var_3.clearcallbacks[var_0.oobref];
  }

  if(isDefined(var_2))
    var_0[[var_2]]();

  var_0.oobref = undefined;
  var_0.oob = undefined;
  var_0.oobimmunity = undefined;
  var_0.oobtimeleft = undefined;
  var_0.oobendtime = undefined;
  var_0.oobtriggertype = undefined;

  if(isDefined(var_0.oobtriggers)) {
    foreach(var_5 in var_0.oobtriggers)
    var_5.entstouching[var_0 getentitynumber()] = undefined;

    var_0.oobtriggers = undefined;
  }

  if(isDefined(var_0.oobsupressiontriggers)) {
    foreach(var_5 in var_0.oobsupressiontriggers)
    var_5.entstouching[var_0 getentitynumber()] = undefined;

    var_0.oobsupressiontriggers = undefined;
  }
}

initoob() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  var_0 = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  level.outofboundstriggers[level.outofboundstriggers.size] = var_2;

  thread watchoobtriggers();
}

basic_combat(var_0) {
  if(isDefined(level.outofboundstriggers))
    level.outofboundstriggers[level.outofboundstriggers.size] = var_0;
  else
    level.outofboundstriggers[0] = var_0;

  thread watchoobtrigger(var_0);
}

onenteroob(var_0) {
  var_1 = undefined;
  var_2 = getlastoobtrigger(var_0);
  var_3 = gettriggertype(var_0, var_2);

  if(isPlayer(var_0))
    var_1 = ::playerentercallback;
  else if(isDefined(var_0.oobref)) {
    var_4 = getoobdata();
    var_1 = var_4.entercallbacks[var_0.oobref];
  }

  var_0 notify("_encstr_BE6B119038925E30576F40704020FD99EF8DBC");

  if(isDefined(var_0.oobtimeleft)) {
    var_5 = var_0.oobtimeleft / 1000;
    var_0.oobendtime = int(gettime() + var_0.oobtimeleft);
    var_0.oobtimeleft = undefined;
    thread watchooboutoftime(var_0, var_5);
  } else {
    var_0.oobtimeleft = undefined;
    var_0.oobtriggertype = var_3;
    var_5 = getoutofboundstime(var_3);
    var_0.oobendtime = int(gettime() + var_5 * 1000);
    thread watchooboutoftime(var_0, var_5);
  }

  if(isDefined(var_1))
    var_0 thread[[var_1]]("_encstr_A57B09B39BEA4579E755D9", "_encstr_8A930A9BA489684B49377049");
}

onexitoob(var_0, var_1, var_2) {
  var_0 notify("_encstr_A57B09B39BEA4579E755D9");
  var_3 = undefined;

  if(isPlayer(var_0))
    var_3 = ::playerexitcallback;
  else if(isDefined(var_0.oobref)) {
    var_4 = getoobdata();
    var_3 = var_4.exitcallbacks[var_0.oobref];
  }

  var_0 notify("_encstr_BE1910DBDE89F5A3B4D6CAB7AB3A7DAC9B91");

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

  if(isDefined(var_3))
    var_0 thread[[var_3]](var_1, var_2, "_encstr_8A930A9BA489684B49377049");
}

onooboutoftime(var_0) {
  var_1 = undefined;

  if(isPlayer(var_0))
    var_1 = ::playeroutoftimecallback;
  else if(isDefined(var_0.oobref)) {
    var_2 = getoobdata();
    var_1 = var_2.outoftimecallbacks[var_0.oobref];
  }

  if(isDefined(var_1))
    var_0 thread[[var_1]]("_encstr_BE1910DBDE89F5A3B4D6CAB7AB3A7DAC9B91", "_encstr_8A930A9BA489684B49377049");
}

watchooboutoftime(var_0, var_1) {
  if(isPlayer(var_0))
    var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  else
    var_0 endon("_encstr_AD75063D571AE108");

  var_0 notify("_encstr_BE1910DBDE89F5A3B4D6CAB7AB3A7DAC9B91");
  var_0 endon("_encstr_BE1910DBDE89F5A3B4D6CAB7AB3A7DAC9B91");
  var_0 endon("_encstr_8A930A9BA489684B49377049");
  wait(var_1);
  thread onooboutoftime(var_0);
}

watchoobcooldown(var_0, var_1) {
  if(isPlayer(var_0))
    var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  else
    var_0 endon("_encstr_AD75063D571AE108");

  var_0 notify("_encstr_BE6B119038925E30576F40704020FD99EF8DBC");
  var_0 endon("_encstr_BE6B119038925E30576F40704020FD99EF8DBC");
  var_0 endon("_encstr_8A930A9BA489684B49377049");
  wait(var_1);
  var_0.oobtimeleft = undefined;
  var_0.oobtriggertype = undefined;
}

playerentercallback(var_0, var_1) {
  self setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", self.oobendtime);
}

playerexitcallback(var_0, var_1, var_2) {
  self setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}

playeroutoftimecallback(var_0, var_1) {
  var_2 = getlastoobtrigger(self);
  var_3 = gettriggertype(self, var_2);

  if(var_3 == "_encstr_84D90AA20B9A5A6AE3208D59")
    thread playeroutoftimeminefield(var_0, var_1);
  else {
    self.oob = 1;
    self.shouldskiplaststand = 1;
    self dodamage(self.health + 100, self.origin);
  }
}

playerclearcallback(var_0) {
  self setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}

playeroutoftimeminefield(var_0, var_1) {
  var_2 = self.origin;
  var_3 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self);

  if(isDefined(var_3["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") && isDefined(var_3["_encstr_BD260953AA97E3F014279D"]))
    var_2 = var_3["_encstr_BD260953AA97E3F014279D"];

  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_4 setModel("_encstr_BD7210A32F319577E071827A59C99BC148D1");
  var_4 setentityowner(self);
  var_4 setotherent(self);
  var_4 setscriptablepartstate("_encstr_96130ECB91867B9CB81F878331B826A7", "_encstr_AB0703DBB9", 0);
  var_5 = playeroutoftimeminefieldinternal(var_4, var_0, var_1);

  if(istrue(var_5))
    wait 2;

  var_4 delete();
}

playeroutoftimeminefieldinternal(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_1))
    self endon(var_1);

  if(isDefined(var_2))
    self endon(var_2);

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  var_0 setscriptablepartstate("_encstr_8E440A950FE01BB76E96BDE6", "_encstr_AB0703DBB9", 0);
  self.shouldskiplaststand = 1;
  self dodamage(2000, self.origin, self, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8FDA0D3880E2EF6E3F35108F39114B");
  return 1;
}

killstreakentercallback(var_0, var_1) {
  if(isDefined(self.owner))
    self.owner setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", self.oobendtime);
}

killstreakexitcallback(var_0, var_1, var_2) {
  if(isDefined(self.owner))
    self.owner setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}

killstreakoutoftimecallback(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9F8150DE578FB9851B708B9AF43D029220AFD8EFF8257"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9F8150DE578FB9851B708B9AF43D029220AFD8EFF8257")]](10000, self.owner, self, self.team, self.origin, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A29408E6D5D6CAAF5B1C");
}

killstreakclearcallback() {
  if(isDefined(self.owner))
    self.owner setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}

killstreakregisteroobcallbacks() {
  registeroobentercallback("_encstr_85CE0B9770B02C73A1760F06D2", ::killstreakentercallback);
  registeroobexitcallback("_encstr_85CE0B9770B02C73A1760F06D2", ::killstreakexitcallback);
  registerooboutoftimecallback("_encstr_85CE0B9770B02C73A1760F06D2", ::killstreakoutoftimecallback);
  registeroobclearcallback("_encstr_85CE0B9770B02C73A1760F06D2", ::killstreakclearcallback);
}

watchoobtriggers() {
  if(isDefined(level.outofboundstriggers)) {
    foreach(var_1 in level.outofboundstriggers)
    thread watchoobtrigger(var_1);

    if(isDefined(level.outofboundstriggerpatches)) {
      foreach(var_1 in level.outofboundstriggerpatches)
      thread watchoobsuppressiontrigger(var_1);
    }
  }
}

watchoobtrigger(var_0) {
  var_0.entstouching = [];
  thread watchoobtriggerexit(var_0);
  thread watchoobtriggerenter(var_0);
}

watchoobtriggerenter(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isPlayer(var_1)) {
      if(isDefined(var_1.c130)) {
        continue;
      }
      if(istrue(var_1.inlaststand) && !scripts\cp\utility::tryingtoleave()) {
        var_1 notify("_encstr_966410CE10EB2FC727804AD250B9B1E7E305");
        continue;
      }
    }

    if(isDefined(var_0.script_team)) {
      var_2 = 0;

      if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle())
        var_2 = 1;

      if(var_2 && isDefined(var_1.owner) && var_1.owner.team != var_0.script_team) {
        continue;
      }
      if(!var_2 && var_1.team != var_0.script_team)
        continue;
    }

    if(!interactswithoobtriggers(var_1)) {
      continue;
    }
    onenteroobtrigger(var_0, var_1);
  }
}

watchoobtriggerexit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_1 = var_0.entstouching;

    foreach(var_4, var_3 in var_1) {
      if(!isDefined(var_3))
        var_0.entstouching[var_4] = undefined;

      if(isDefined(var_3) && !var_0 istouching(var_3))
        onexitoobtrigger(var_0, var_3);
    }

    waitframe();
  }
}

onenteroobtrigger(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.entstouching[var_2])) {
    return;
  }
  var_0.entstouching[var_2] = var_1;

  if(!isDefined(var_1.oobtriggers))
    var_1.oobtriggers = [];

  var_3 = [var_0];

  foreach(var_5 in var_1.oobtriggers)
  var_3[var_3.size] = var_5;

  var_1.oobtriggers = var_3;
  enableoob(var_1);
}

onexitoobtrigger(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_0.entstouching[var_2] = undefined;
  disableoob(var_1);
  var_1.oobtriggers = scripts\engine\utility::array_remove(var_1.oobtriggers, var_0);

  if(var_1.oobtriggers.size == 0)
    var_1.oobtriggers = undefined;
}

watchoobsuppressiontrigger(var_0) {
  var_0.entstouching = [];
  wait 10;
  thread watchoobsuppressiontriggerexit();
  thread watchoobsupressiontriggerenter();
}

watchoobsupressiontriggerenter(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!interactswithoobtriggers(var_1)) {
      continue;
    }
    onenteroobsuppressiontrigger(var_0, var_1);
  }
}

watchoobsuppressiontriggerexit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = var_0.entstouching;

    foreach(var_4, var_3 in var_1) {
      if(!isDefined(var_3))
        var_0.entstouching[var_4] = undefined;

      if(!var_0 istouching(var_3))
        onexitoobsupressiontrigger(var_0, var_3);
    }
  }
}

onenteroobsuppressiontrigger(var_0, var_1) {
  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.entstouching[var_2])) {
    return;
  }
  var_0.entstouching[var_2] = var_1;

  if(!isDefined(var_1.oobsupressiontriggers))
    var_1.oobsupressiontriggers = [];

  var_1.oobsupressiontriggers[var_0 getentitynumber()] = var_0;
  enableoobimmunity(var_1);
}

onexitoobsupressiontrigger(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_0.entstouching[var_2] = undefined;
  var_1.oobsupressiontriggers[var_0 getentitynumber()] = undefined;

  if(var_1.oobsupressiontriggers.size == 0)
    var_1.oobsupressiontriggers = undefined;

  disableoobimmunity(var_1);
}

interactswithoobtriggers(var_0) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0)) {
      if(var_0 scripts\cp_mp\utility\player_utility::_isalive())
        return 1;
    }

    if(isDefined(var_0.oobref)) {
      if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(var_0.isdestroyed))
          return 1;
      }

      if(isDefined(var_0.streakinfo) && iskillstreakaffectedbyobb(var_0.streakinfo.streakname))
        return 1;
    }
  }

  return 0;
}

getoobdata() {
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

iskillstreakaffectedbyobb(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC":
    case "_encstr_B1B30B51D176511E377A1BC313":
      var_1 = 1;
      break;
  }

  return var_1;
}

gettriggertype(var_0, var_1) {
  var_2 = "_encstr_8B1608EC43B8D647A113";

  if(isDefined(var_0) && var_0 scripts\cp_mp\vehicles\vehicle::isvehicle())
    return "_encstr_8B1608EC43B8D647A113";

  if(isDefined(var_0) && isDefined(var_0.streakinfo))
    return "_encstr_8B1608EC43B8D647A113";

  if(isDefined(var_1) && isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "_encstr_84D90AA00B9A5A68E3208D59")
    var_2 = "_encstr_84D90AA20B9A5A6AE3208D59";

  return var_2;
}

getcooldowntime(var_0) {
  switch (var_0) {
    case "_encstr_84D90AA20B9A5A6AE3208D59":
      return getmaxoutofboundscooldown();
    case "_encstr_8B1608EC43B8D647A113":
      return getmaxoutofboundsminefieldtime();
  }

  return undefined;
}

getoutofboundstime(var_0) {
  switch (var_0) {
    case "_encstr_84D90AA20B9A5A6AE3208D59":
      return getmaxoutofboundsminefieldtime();
    case "_encstr_8B1608EC43B8D647A113":
      return getmaxoutofboundstime();
  }

  return undefined;
}

getlastoobtrigger(var_0) {
  if(isDefined(var_0.oobtriggers))
    return var_0.oobtriggers[0];

  return undefined;
}

getmaxoutofboundstime() {
  var_0 = level.outofboundstime;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("_encstr_870314ABF20B10C0EBC4376DDA552840FB6BC710FA8F", 3));
    level.outofboundstime = var_0;
  }

  return var_0;
}

getmaxoutofboundscooldown() {
  var_0 = level.outofboundscooldown;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("_encstr_877E182E4EB32F60FD530140630FFB957AF2BEB8252A1128C723", 3));
    level.outofboundscooldown = var_0;
  }

  return var_0;
}

getmaxoutofboundsminefieldtime() {
  var_0 = level.outofboundstimeminefield;

  if(!isDefined(var_0)) {
    var_0 = max(0, getdvarfloat("_encstr_8D961DA686034127A53B7475A56F885A99FB14820DCF448B3D77E4A855BB5D", 3));
    level.outofboundstimeminefield = var_0;
  }

  return var_0;
}