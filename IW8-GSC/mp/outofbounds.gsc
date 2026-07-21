/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\outofbounds.gsc
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

unset_relic_rocket_kill_ammo(var_0) {
  if(scripts\mp\utility\game::unset_relic_grounded() && isDefined(level._encstr_8D1417A89B6913AB0BBF63E89C5730CDCD73406063FF93402F))
    return [[level._encstr_8D1417A89B6913AB0BBF63E89C5730CDCD73406063FF93402F]](var_0, 0, 1);
  else
    return !ispointinoutofbounds(var_0);
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

istouchingoobtrigger() {
  if(istrue(self.allowedintrigger))
    return 0;

  if(!isDefined(level.outofboundstriggers))
    return 0;

  foreach(var_1 in level.outofboundstriggers) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!interactswithgivenoobtrigger(var_1, self)) {
      continue;
    }
    if(self istouching(var_1))
      return 1;
  }

  return 0;
}

ispointinoutofbounds(var_0, var_1) {
  if(!isDefined(level.outofboundstriggers))
    return 0;
  else {
    foreach(var_3 in level.outofboundstriggers) {
      if(isDefined(var_3) && ispointinvolume(var_0, var_3)) {
        if(isDefined(var_3.script_team) && isDefined(var_1) && var_3.script_team != var_1)
          continue;
        else
          return 1;
      }
    }

    return 0;
  }
}

useshouldsucceedcallback(var_0) {
  var_1 = 16;
  var_2 = physics_createcontents(["_encstr_92A41EDB523776801EB37F6FC683B8B0AB5BB643FAAFAB2872AC257BF7AF7006"]);
  var_3 = physics_spherecast(var_0, var_0, var_1, var_2, undefined, "_encstr_A1C4111F40CF43E3EE0BC8E002C29B9E07FCA9");

  foreach(var_5 in var_3) {
    var_6 = var_5["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_6) && isDefined(var_6.targetname) && var_6.targetname == "_encstr_8A720C48B3AB7729A26778B853CB")
      return 1;
  }

  return 0;
}

initoob() {
  thread watchoobtriggers();
}

onenteroob(var_0) {
  var_1 = undefined;
  var_2 = getlastoobtrigger(var_0);
  var_3 = gettriggertype(var_0, var_2);

  if(isPlayer(var_0)) {
    if(isDefined(level._id_11C7B))
      var_1 = level._id_11C7B;
    else
      var_1 = ::playerentercallback;
  } else if(isDefined(var_0.oobref)) {
    var_4 = getoobdata();
    var_1 = var_4.entercallbacks[var_0.oobref];
  }

  var_0 notify("_encstr_BE6B119038925E30576F40704020FD99EF8DBC");

  if(isDefined(var_0.oobtimeleft) && previouslytouchedtriggertype(var_0, var_3)) {
    var_5 = var_0.oobtimeleft / 1000;
    var_0.oobendtime = int(gettime() + var_0.oobtimeleft);
    var_0.oobtimeleft = undefined;
    thread watchooboutoftime(var_0, var_5);
  } else {
    var_0.oobtimeleft = undefined;
    var_0.oobtriggertype = var_3;
    var_5 = getoutofboundstime(var_3, var_0);
    var_0.oobendtime = int(gettime() + var_5 * 1000);
    thread watchooboutoftime(var_0, var_5);
  }

  if(isDefined(var_1))
    var_0 thread[[var_1]]("_encstr_A57B09B39BEA4579E755D9", "_encstr_8A930A9BA489684B49377049", var_3);
}

onexitoob(var_0, var_1, var_2) {
  var_0 notify("_encstr_A57B09B39BEA4579E755D9");
  var_3 = undefined;

  if(isPlayer(var_0)) {
    if(isDefined(level._id_11C7C))
      var_3 = level._id_11C7C;
    else
      var_3 = ::playerexitcallback;
  } else if(isDefined(var_0.oobref)) {
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

  if(isPlayer(var_0)) {
    var_2 = 1;

    if(level.gametype == "_encstr_B607038AAB") {
      if(istrue(level.stop_end_breach_fx))
        var_2 = 0;
      else if(isDefined(level.matchcountdowntime) && level.matchcountdowntime < 2)
        var_2 = 0;
    }

    if(var_2)
      var_1 = ::playeroutoftimecallback;
  } else if(isDefined(var_0.oobref)) {
    var_3 = getoobdata();
    var_1 = var_3.outoftimecallbacks[var_0.oobref];
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

playerentercallback(var_0, var_1, var_2) {
  var_3 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "_encstr_B81904B04E6B" && isDefined(var_2) && var_2 == "_encstr_83E00BE4CA6ED1272DC68E5632")
    var_3 = 2;

  self setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", var_3);
  self setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", self.oobendtime);
}

playerexitcallback(var_0, var_1, var_2) {
  self setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", 0);
  self setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
}

playeroutoftimecallback(var_0, var_1) {
  var_2 = getlastoobtrigger(self);
  var_3 = gettriggertype(self, var_2);

  if(var_3 == "_encstr_84D90AA20B9A5A6AE3208D59")
    thread playeroutoftimeminefield(var_0, var_1);
  else if(!isDefined(self.plotarmor) || !self.plotarmor)
    scripts\mp\utility\damage::_suicide();
}

playerclearcallback(var_0) {
  self setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", 0);
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

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  var_0 setscriptablepartstate("_encstr_8E440A950FE01BB76E96BDE6", "_encstr_AB0703DBB9", 0);
  wait 0.05;
  self dodamage(2000, self.origin, self, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8FDA0D3880E2EF6E3F35108F39114B");
  return 1;
}

killstreakentercallback(var_0, var_1, var_2) {
  var_3 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.gametype == "_encstr_B81904B04E6B" && isDefined(var_2) && var_2 == "_encstr_83E00BE4CA6ED1272DC68E5632")
    var_3 = 2;

  if(isDefined(self.owner)) {
    self.owner setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", var_3);
    self.owner setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", self.oobendtime);
  }
}

killstreakexitcallback(var_0, var_1, var_2) {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", 0);
    self.owner setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
  }
}

killstreakoutoftimecallback(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    var_2 = "_encstr_A29408E6D5D6CAAF5B1C";
  else
    var_2 = "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633";

  scripts\mp\utility\killstreak::dodamagetokillstreak(10000, self.owner, self, self.team, self.origin, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_2);
}

killstreakclearcallback() {
  if(isDefined(self.owner)) {
    self.owner setclientomnvar("_encstr_A2C516E30B7F32BD4329677B11B96F5BC515EA916D9B7BF5", 0);
    self.owner setclientomnvar("_encstr_A1A21B281251572343C72894EF33283B45AA60F12AF5AB98BBE42014A6", 0);
  }
}

killstreakregisteroobcallbacks() {
  registeroobentercallback("_encstr_85CE0B9770B02C73A1760F06D2", ::killstreakentercallback);
  registeroobexitcallback("_encstr_85CE0B9770B02C73A1760F06D2", ::killstreakexitcallback);
  registerooboutoftimecallback("_encstr_85CE0B9770B02C73A1760F06D2", ::killstreakoutoftimecallback);
  registeroobclearcallback("_encstr_85CE0B9770B02C73A1760F06D2", ::killstreakclearcallback);
}

watchoobtriggers() {
  if(scripts\mp\utility\game::lpcfeaturegated() && scripts\mp\utility\game::getgametype() != "_encstr_B81904B04E6B" && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
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

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  thread watchoobtriggerexit(var_0);
  thread watchoobtriggerenter(var_0);
}

watchoobtriggerenter(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8AA50991E565083EF82F9D");
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isPlayer(var_1)) {
      if(scripts\mp\utility\game::updatehistoryhud(var_1))
        continue;
      else if(isDefined(var_1.vehicle) && isDefined(var_1.vehicle.turrets)) {
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

watchoobtriggerexit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8AA50991E565083EF82F9D");
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
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  thread watchoobsuppressiontriggerexit(var_0);
  thread watchoobsupressiontriggerenter(var_0);
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

    if(isDefined(var_1)) {
      foreach(var_4, var_3 in var_1) {
        if(!isDefined(var_3))
          var_0.entstouching[var_4] = undefined;

        if(isDefined(var_3) && !var_0 istouching(var_3))
          onexitoobsupressiontrigger(var_0, var_3);
      }
    }

    waitframe();
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

  var_3 = [var_0];

  foreach(var_5 in var_1.oobsupressiontriggers)
  var_3[var_3.size] = var_5;

  var_1.oobsupressiontriggers = var_3;
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

interactswithgivenoobtrigger(var_0, var_1) {
  if(isDefined(var_0.script_team)) {
    if(scripts\mp\utility\game::unset_relic_landlocked())
      return 0;

    var_2 = 0;

    if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle())
      var_2 = 1;

    if(var_2) {
      if(var_2 && isDefined(var_1.team) && var_1.team != "_encstr_A7A408B9CA5D1D4E2C63" && var_1.team != var_0.script_team)
        return 0;

      if(var_2 && isDefined(var_1.owner) && var_1.owner.team != var_0.script_team)
        return 0;

      if(var_2 && isDefined(var_1.occupants)) {
        foreach(var_4 in var_1.occupants) {
          if(var_4.team != var_0.script_team)
            return 0;
        }
      }
    } else if(var_1.team != var_0.script_team)
      return 0;
  }

  return 1;
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
    case "_encstr_970509C3CF3B425F68D9F7":
    case "_encstr_B1B30B51D176511E377A1BC313":
      var_1 = 1;
      break;
  }

  return var_1;
}

gettriggertype(var_0, var_1) {
  var_2 = "_encstr_8B1608EC43B8D647A113";

  if(level.gametype == "_encstr_B607038AAB")
    return "_encstr_B607038AAB";

  if(isDefined(var_1) && isDefined(var_1.script_team))
    return "_encstr_83E00BE4CA6ED1272DC68E5632";

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
    case "_encstr_83E00BE4CA6ED1272DC68E5632":
    case "_encstr_84D90AA20B9A5A6AE3208D59":
    case "_encstr_B607038AAB":
    case "_encstr_8B1608EC43B8D647A113":
      return scripts\mp\utility\game::getmaxoutofboundscooldown();
  }

  return undefined;
}

getoutofboundstime(var_0, var_1) {
  var_2 = var_1._id_12CCE;

  if(istrue(var_2))
    return scripts\mp\utility\game::repair_grill_stop_exit_foley_sfx();

  if(isDefined(var_2) && !var_2)
    return scripts\mp\utility\game::repair_grill_start_enter_foley_sfx();

  if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_3 = var_1 scripts\mp\utility\game::runbrgametypefunc();

    if(isDefined(var_3))
      return var_3;
  }

  switch (var_0) {
    case "_encstr_84D90AA20B9A5A6AE3208D59":
      return scripts\mp\utility\game::getmaxoutofboundsminefieldtime();
    case "_encstr_83E00BE4CA6ED1272DC68E5632":
      return scripts\mp\utility\game::getmaxoutofboundsrestrictedtime();
    case "_encstr_B607038AAB":
      return scripts\mp\utility\game::repair_grill_fixing_short_sfx();
    case "_encstr_8B1608EC43B8D647A113":
      return scripts\mp\utility\game::getmaxoutofboundstime();
  }

  return undefined;
}

getlastoobtrigger(var_0) {
  if(isDefined(var_0.oobtriggers))
    return var_0.oobtriggers[0];

  return undefined;
}

previouslytouchedtriggertype(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0.oobtriggertype)) {
    var_3 = var_0.oobtriggertype;

    if(var_1 == var_3)
      var_2 = 1;
    else if((var_1 == "_encstr_8B1608EC43B8D647A113" || var_1 == "_encstr_84D90AA20B9A5A6AE3208D59") && (var_3 == "_encstr_8B1608EC43B8D647A113" || var_3 == "_encstr_84D90AA20B9A5A6AE3208D59"))
      var_2 = 1;
  }

  return var_2;
}