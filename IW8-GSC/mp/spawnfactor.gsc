/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\spawnfactor.gsc
***********************************************/

init_spawn_factors() {
  if(!isDefined(level.spawn_closeenemydistsq))
    level.spawn_closeenemydistsq = 250000;

  if(!isDefined(level.enemyspawninfluencedistsq))
    level.enemyspawninfluencedistsq = 810000;

  registerfactor("_encstr_AC90138353379821F8385BE3A9F9C8742324047C86", ::preferoptimalttlos, 0, undefined);
  registerfactor("_encstr_B24A1BA790C8416A9703E5DA75F1F21DD12927BFC8618D63AFABEF545D", ::avoidshorttimetoenemysight, 0, undefined);
  registerfactor("_encstr_82DC1747DAA03CDD42B7C1910BEF5371131B8B6F0870956EA7", ::preferalliesbydistance, 0, undefined);
  registerfactor("_encstr_816912E3CB7FD4C8429B0917B3EF09289742F84A", ::preferclosetoally, 0, undefined);
  registerfactor("_encstr_B88B1B5913CFDB48F2059F9B2623509B4F3B5161F82F15D0D715B38343", ::avoidrecentlyusedbyenemies, 0, undefined);
  registerfactor("_encstr_853A172B331A5BD0BD65A9A04C45B016D343B397538290A0B5", ::avoidenemiesbydistance, 0, undefined);
  registerfactor("_encstr_818F14B0D9EDA546A89B566BBC94DCCCD8BAAC9B1B95", ::avoidenemyinfluence, 0, undefined);
  registerfactor("_encstr_9B4B17474B407B7721DEA269D5CFBF34E169F028939BD1C5AA", ::avoidlastdeathlocation, 0, undefined);
  registerfactor("_encstr_BA291A853BDB96C813B0DC47058EA32CB16D2B9313B71B0B1DD2DBCD", ::avoidlastattackerlocation, 0, undefined);
  registerfactor("_encstr_A343228F36FF68819AD220F02B6353200FFCB7E2AD5FF3C3BD4A7918D2C54BBF57771B75", ::avoidshorttimetojumpingenemysight, 0, undefined);
  registerfactor("_encstr_9BC926D763E0ABA8AB1918C341101713D31BA0330A99F74AC78870B7B0BF39EDE520F19FCFE740ED", ::avoidveryshorttimetojumpingenemysight, 0, undefined);
  registerfactor("_encstr_84BE0FD0BB053369A791414D5BD331C7AD", ::avoidsamespawn, 0, undefined);
  registerfactor("_encstr_841D1A2C3BB75A2329B28DB237A3C6F255E6561990CB82E697B7B9AC", ::avoidrecentlyusedbyanyone, 0, undefined);
  registerfactor("_encstr_AD5E1139587319DEAD9A0E58EE9BD4D87B9C59", ::randomspawnscore, 0, undefined);
  registerfactor("_encstr_B1DC18CBEDB56265683CB7BE93B1A98B95090707ABF64B5998C0", ::prefernearlastteamspawn, 0, undefined);
  registerfactor("_encstr_82481C03250DDADD2064FFC6DBB1F282DDB98707E53D5291B06CF68BD1F8", ::preferneargroupsofteammates, 0, undefined);
  registerfactor("_encstr_971114614BD2B4A0E245F1C9F3C8887D9ADB3BD58F1B", ::preferoccupiedlanes, 0, undefined);
  registerfactor("_encstr_B2AD15EACDC38D3FA54BA0FEA8C12110C092E497F27BF2", ::prefertobalancelanes, 0, undefined);
  registerfactor("_encstr_8433120FB67FE8011E12A078BA2AE9A5A34D81FB", ::avoidclosestenemy, 0, undefined);
  registerfactor("_encstr_B1140FDCC6C996C18EF4731BBCA22BDC3A", ::scriptonlytest, 1, ["_encstr_82EF0594EDAE31"]);
  registerfactor("_encstr_8D571C5A3B20A2225758E83765D74D98B09F2FC82AF3BD98CBB107BD527F", ::avoidclosestenemybydistance, 1, ["_encstr_B6421CDFE1BF8870FE8B55C53F7F20EB55B7D9B30F5DAF5311ECAE61092A"]);
  registerfactor("_encstr_8EDC168B93BB53BB757571B01BD99B85E8CD07A95F40E3F9", ::prefernearsinglepoint, 1, ["_encstr_AC010F235BF6E9C08D57B80373D379FD42", "_encstr_AB4A1707F878FC2A27FDDB0D763B126780306B874B9004B17B", "_encstr_B6F71772A8518F3FFBB5DCEFDE40DB8F911029EA4025FB9F93", "_encstr_8B7619B96C4B981652F39F93339ADEC8FE472011DA8FB8305B7FAB"]);
  registerfactor("_encstr_959210DB1EC5BD5F6BC5A72DA8DFFB937373", ::preferdompoints, 1, ["_encstr_A57C1399B32A4CA8FA123911B7DFD0EF22472DE9DF", "_encstr_BA38137FA7A6E765EDA628911497B859DF983A1137"]);
  registerfactor("_encstr_887C1DC139CA992B399A0DF627D1CACDA3442D9B3A517BA5F4A88469BD9BCA", ::prefershortestdisttokothzone, 1, ["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239", "_encstr_AC921AF7627031A3C02F53A7A46D886BA324607C1E2B45B62B6B3B4A"]);
  registerfactor("_encstr_83EC15B7DD98BA4C3990CDD2A9599F5070619BC347B022", ::avoidclosetokothzone, 1, ["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239", "_encstr_A1F117DA7BD18669F6CD5922B28523A7B7E65944D2DCD14DE2"]);
  registerfactor("_encstr_B4E4125303A7CE0FFB9D092882E0D9359C63FBBB", ::preferclosepoints, 1, ["_encstr_96F30E26F427F36B7AEB31C05255318B"]);
  registerfactor("_encstr_A6D013FA16B53842D1F81F101B475C9EFB8B65BA7E", ::avoidrugbyoffsides, 1, ["_encstr_ADD8088D2D8F6867F773", "_encstr_B228102AB360C687444022BA09AD3F3A2249"]);
  registerfactor("_encstr_B4390D7BDCB2AADC954D832CDDDCCD", ::oneusespawns, 1, undefined);
  registerfactor("_encstr_8894191667DE4B190DB1BDB9598A7B882B33CA73C8CA93C81B853B", ::checkuseconditioninthink, 1, ["_encstr_AA3116F74B5B5B70C8386B125311196BAF6FE64264B8C2A2", "_encstr_AC51159A71EC777DC83B8A46D118C76B802BC223583023", "_encstr_850A20BFD580A2540989874FC0209DCBFC09472F293D6A0C81D0BD577D90B3E32E8B"]);
  registerfactor("_encstr_99F21E2CCEBD4B460D8D7BCDCA51F622B233959B32CA27C81BB0ECA9C12CEE73", ::checkweaponswitch, 1, ["_encstr_850A20BFD580A2540989874FC0209DCBFC09472F293D6A0C81D0BD577D90B3E32E8B"]);
  initfrontline();
}

registerfactor(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.spawnglobals.factors))
    level.spawnglobals.factors = [];

  var_4 = spawnStruct();
  level.spawnglobals.factors[var_0] = var_4;
  var_4.function = var_1;
  var_4.paramreflist = var_3;
  var_4.isscriptonly = var_2;
}

isfactorregistered(var_0) {
  return isDefined(level.spawnglobals.factors[var_0]);
}

isfactorscriptonly(var_0) {
  return level.spawnglobals.factors[var_0].isscriptonly;
}

getfactorfunction(var_0) {
  return level.spawnglobals.factors[var_0].function;
}

getfactorparamreflist(var_0) {
  return level.spawnglobals.factors[var_0].paramreflist;
}

calculatefactorscore(var_0, var_1, var_2) {
  if(!isfactorregistered(var_1))
    return 0;

  var_3 = getfactorfunction(var_1);
  var_4 = getfactorparamreflist(var_1);
  var_5 = level.spawnglobals.activespawncontext;

  if(isDefined(var_4)) {
    if(!isDefined(var_5.factorparams)) {}
  }

  var_13 = [[var_3]](var_0);
  var_13 = clamp(var_13, 0, 100);
  var_13 = var_13 * var_2;
  var_0.totalpossiblescore = var_0.totalpossiblescore + 100 * var_2;
  var_0.lastscore[self.team] = var_0.lastscore[self.team] + var_13;
  var_0.totalscore = var_0.totalscore + var_13;
  return var_13;
}

critical_factor(var_0, var_1) {
  var_2 = [[var_0]](var_1);
  var_2 = clamp(var_2, 0, 100);
  return var_2;
}

avoidcarepackages(var_0) {
  foreach(var_2 in level.carepackages) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 22500)
      return 0;
  }

  return 100;
}

avoidbradleys(var_0) {
  if(isDefined(level.bradley)) {
    foreach(var_2 in level.bradley.activevehicles["_encstr_BE7D0633C08849E2"]) {
      if(distancesquared(var_0.origin, var_2.origin) < 50625)
        return 0;
    }

    foreach(var_2 in level.bradley.inactivevehicles["_encstr_BE7D0633C08849E2"]) {
      if(distancesquared(var_0.origin, var_2.origin) < 50625)
        return 0;
    }
  }

  return 100;
}

avoidgrenades(var_0) {
  foreach(var_2 in level.grenades) {
    if(!isDefined(var_2) || !var_2 isexplosivedangeroustoplayer(self) || istrue(var_2.shouldnotblockspawns)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_2.origin) < 122500)
      return 0;
  }

  return 100;
}

avoidmines(var_0) {
  var_1 = level.mines;

  if(isDefined(level.traps) && level.traps.size > 0)
    var_1 = scripts\engine\utility::array_combine(var_1, level.traps);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !var_3 isexplosivedangeroustoplayer(self) || istrue(var_3.shouldnotblockspawns)) {
      continue;
    }
    if(distancesquared(var_0.origin, var_3.origin) < 122500)
      return 0;
  }

  return 100;
}

isexplosivedangeroustoplayer(var_0) {
  if(!level.teambased || level.friendlyfire || !isDefined(var_0.team))
    return 1;
  else {
    var_1 = undefined;

    if(isDefined(self.owner)) {
      if(var_0 == self.owner)
        return 1;

      var_1 = self.owner.team;
    }

    if(isDefined(var_1))
      return var_1 != var_0.team;
    else
      return 1;
  }
}

avoidcornervisibleenemies(var_0) {
  var_1 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  if(var_0.cornersights[var_1] > 0)
    return 0;

  return 100;
}

avoidfullvisibleenemies(var_0) {
  var_1 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  if(var_0.fullsights[var_1] > 0)
    return 0;

  return 100;
}

avoidcloseenemies(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased)
    var_1[0] = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  else
    var_1[var_1.size] = "_encstr_AF1904A7F929";

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0)
    return 100;

  foreach(var_4 in var_2) {
    if(var_0.mindistsquared[var_4] < level.spawn_closeenemydistsq)
      return 0;
  }

  return 100;
}

avoidtelefrag(var_0) {
  return 100;
}

avoidsamespawn(var_0) {
  if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == var_0)
    return 0;

  return 100;
}

avoidenemyspawn(var_0) {
  if(isDefined(self.team) && isDefined(var_0.lastspawnteam) && (!level.teambased || var_0.lastspawnteam != self.team)) {
    var_1 = var_0.lastspawntime + 500;

    if(gettime() < var_1)
      return 0;
  }

  return 100;
}

avoidrecentlyusedbyenemies(var_0) {
  var_1 = !level.teambased || isDefined(var_0.lastspawnteam) && self.team != var_0.lastspawnteam;

  if(var_1 && isDefined(var_0.lastspawntime)) {
    var_2 = gettime() - var_0.lastspawntime;
    var_0.analytics.spawnusedbyenemies = var_2 / 1000;

    if(var_2 > 4000)
      return 100;

    return var_2 / 4000 * 100;
  }

  return 100;
}

avoidrecentlyusedbyanyone(var_0) {
  if(isDefined(var_0.lastspawntime)) {
    var_1 = gettime() - var_0.lastspawntime;
    var_0.analytics.timesincelastspawn = var_1 / 1000;

    if(var_1 > 4000)
      return 100;

    return var_1 / 4000 * 100;
  }

  return 100;
}

avoidlastdeathlocation(var_0) {
  if(!isDefined(self.lastdeathpos))
    return 100;

  var_1 = distancesquared(var_0.origin, self.lastdeathpos);

  if(var_1 > 810000)
    return 100;

  var_2 = var_1 / 810000;
  return var_2 * 100;
}

avoidlastattackerlocation(var_0) {
  if(!isDefined(self.lastattacker) || !isDefined(self.lastattacker.origin))
    return 100;

  if(!scripts\mp\utility\player::isreallyalive(self.lastattacker))
    return 100;

  var_1 = distancesquared(var_0.origin, self.lastattacker.origin);

  if(var_1 > 810000)
    return 100;

  var_2 = var_1 / 810000;
  return var_2 * 100;
}

initfrontline() {
  var_0 = getglobalfrontlineinfo();

  if(getdvarint("_encstr_819F1C4F2B5B460B5212B8CEBD989CC018C2C3B0839EA2614F807103E818", 0) == 1) {
    return;
  }
  var_1 = [];

  if(istrue(level.testtdmanywhere)) {
    var_2 = getdvarfloat("_encstr_A18C21E63693D71D91AD05CDBCBB34B29CCAEBCC9CEDDCA3C696E62B42952C32B4E63B", randomfloatrange(0, 359));
    var_0.usinganchors = 1;
    var_0.anchordir = anglesToForward((0, var_2, 0));
    var_0.anchorrt = anglestoright((0, var_2, 0));

    if(isDefined(level.mapcenter))
      var_0.primaryanchorpos = (level.mapcenter[0], level.mapcenter[1], 0);

    level.tdmanywherefrontline = var_0;
  } else {
    var_1 = getEntArray("_encstr_A92714032BDE9C2BF7A833F3D9062D89187E3F30802B", "_encstr_AC110A7F14873B5B3D073009");

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      var_3 = [];

      foreach(var_5 in var_1) {
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == level.localeid) {
          var_3[var_3.size] = var_5;
          continue;
        }

        var_5 delete();
      }

      var_1 = var_3;
    } else if(var_1.size != 1) {
      var_7 = [];

      foreach(var_5 in var_1) {
        if(!isDefined(var_5.script_noteworthy) || !issubstr(var_5.script_noteworthy, "_encstr_82E007C2104628C1CF")) {
          var_7[var_7.size] = var_5;
          continue;
        }

        var_5 delete();
      }

      var_1 = var_7;
    }

    if(var_1.size != 0) {
      var_0.usinganchors = 1;
      var_0.anchordir = anglesToForward(var_1[0].angles);
      var_0.primaryanchorpos = (var_1[0].origin[0], var_1[0].origin[1], 0);
    }
  }
}

updatefrontline(var_0) {
  if(!updatefrontlineposition()) {
    return;
  }
  runfrontlinespawntrapchecks(var_0);
  updatefrontlinedebug();
}

updatefrontlineposition() {
  if(!currentspawnlogicsupportsfrontline())
    return 0;

  var_0 = getglobalfrontlineinfo();
  var_1 = gettime();

  if(!isDefined(var_0.lastupdatetime))
    var_0.lastupdatetime = var_1;
  else if(var_0.isactive["_encstr_9A8507BA4040188D08"] && var_0.isactive["_encstr_8E8405EA382B2A"])
    var_0.uptime = var_0.uptime + var_0.lastupdatetimedelta;
  else
    var_0.downtime = var_0.downtime + var_0.lastupdatetimedelta;

  var_2 = (var_1 - var_0.lastupdatetime) / 1000.0;
  var_0.lastupdatetime = var_1;
  var_0.lastupdatetimedelta = var_2;
  var_3 = getfrontlineteamcenter("_encstr_9A8507BA4040188D08");

  if(!isDefined(var_3))
    return 0;

  var_3 = (var_3[0], var_3[1], 0);
  var_0.alliesaverage = var_3;
  var_4 = getfrontlineteamcenter("_encstr_8E8405EA382B2A");

  if(!isDefined(var_4))
    return 0;

  var_4 = (var_4[0], var_4[1], 0);
  var_0.axisaverage = var_4;

  if(var_0.usinganchors) {
    var_5 = var_3 - var_0.primaryanchorpos;
    var_6 = vectordot(var_0.anchordir, var_5);
    var_7 = var_0.anchordir * var_6 + var_0.primaryanchorpos;
    var_0.projectedalliescenter = var_7;
    var_5 = var_4 - var_0.primaryanchorpos;
    var_8 = vectordot(var_0.anchordir, var_5);
    var_9 = var_0.anchordir * var_8 + var_0.primaryanchorpos;
    var_0.projectedaxiscenter = var_9;
    var_10 = abs(var_6 - var_8);

    if(var_10 < 600 && isDefined(var_0.teamdiffyaw))
      var_0.contested = 1;
    else {
      var_0.contested = 0;
      var_0.midpoint = var_7 + (var_9 - var_7) * 0.5;
      var_11 = var_9 - var_7;
      var_0.teamdiffyaw = vectortoyaw(var_11);
    }
  } else {
    var_12 = var_4 - var_3;
    var_13 = vectortoyaw(var_12);
    var_0.teamdiffyaw = var_13;
    var_14 = var_3 + var_12 * 0.5;
    var_0.midpoint = var_14;
  }

  var_15 = anglesToForward((0, var_0.teamdiffyaw, 0));
  var_16 = level.spawnpoints;
  var_16 = scripts\mp\spawnscoring::checkdynamicspawns(var_16);

  foreach(var_18 in var_16) {
    var_19 = var_0.midpoint - var_18.origin;
    var_20 = vectordot(var_19, var_15);
    var_18.frontlineteam = scripts\engine\utility::ter_op(var_20 > 0, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");
  }

  return 1;
}

updatefrontlinedebug() {
  var_0 = isDefined(level.matchrecording_logevent) && isDefined(level.matchrecording_generateid);
  var_1 = scripts\mp\analyticslog::analyticslogenabled();

  if(!var_0 && !var_1) {
    return;
  }
  var_2 = getglobalfrontlineinfo();

  if(!isDefined(var_2.logids) && isDefined(level.matchrecording_generateid)) {
    var_2.logids = [];
    var_2.logids["_encstr_A61C0D18E5A0C8C10FD33720B39FEB"] = [[level.matchrecording_generateid]]();
    var_2.logids["_encstr_BE210B490B1358C78725F5190A"] = [[level.matchrecording_generateid]]();
  }

  if(!var_2.isactive["_encstr_9A8507BA4040188D08"] && !var_2.isactive["_encstr_8E8405EA382B2A"]) {
    return;
  }
  var_3 = (var_2.midpoint[0], var_2.midpoint[1], level.mapcenter[2]);
  var_4 = anglestoright((0, var_2.teamdiffyaw, 0));
  logfrontlinetomatchrecording(var_3, var_4, var_2.isactive["_encstr_9A8507BA4040188D08"], var_2.isactive["_encstr_8E8405EA382B2A"]);

  if(isDefined(level.matchrecording_logevent)) {
    var_5 = scripts\engine\utility::ter_op(var_2.isactive["_encstr_8E8405EA382B2A"], var_2.axisaverage, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_2.logids["_encstr_BE210B490B1358C78725F5190A"], "_encstr_8E8405EA382B2A", "_encstr_A28407059C3442D329", var_5[0], var_5[1], gettime());
    var_6 = scripts\engine\utility::ter_op(var_2.isactive["_encstr_9A8507BA4040188D08"], var_2.alliesaverage, (10000, 10000, 10000));
    [[level.matchrecording_logevent]](var_2.logids["_encstr_A61C0D18E5A0C8C10FD33720B39FEB"], "_encstr_9A8507BA4040188D08", "_encstr_A28407059C3442D329", var_6[0], var_6[1], gettime());
  }
}

logfrontlinetomatchrecording(var_0, var_1, var_2, var_3) {
  if(isDefined(level.matchrecording_logevent)) {
    var_4 = var_0 + var_1 * 5000;
    var_5 = var_0 - var_1 * 5000;

    if(!isDefined(level.matchrecording_frontlinelogid))
      level.matchrecording_frontlinelogid = [[level.matchrecording_generateid]]();

    var_6 = undefined;

    if(var_2 && var_3)
      var_6 = "_encstr_B60A0BC8A93925F9E1A13365EF";
    else
      var_6 = scripts\engine\utility::ter_op(var_2, "_encstr_AB9912D996470C8C37DCF98C81078D0C91C3CD11", "_encstr_820710B9253DA8D7D0D993854B8FBBAB53DB");

    [[level.matchrecording_logevent]](level.matchrecording_frontlinelogid, "_encstr_9A8507BA4040188D08", var_6, var_4[0], var_4[1], gettime(), undefined, var_5[0], var_5[1]);
  }
}

getfrontlineteamcenter(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_3)) {
      continue;
    }
    if(!var_3 scripts\mp\utility\player::isplayerallowedforspawnlogic()) {
      continue;
    }
    if(var_3.team == var_0)
      var_1[var_1.size] = var_3;
  }

  if(var_1.size == 0)
    return undefined;

  var_5 = scripts\mp\utility\entity::getaverageorigin(var_1);
  return var_5;
}

runfrontlinespawntrapchecks(var_0) {
  if(!currentspawnlogicsupportsfrontline()) {
    return;
  }
  var_1 = getglobalfrontlineinfo();
  var_1.isactive[var_0] = 1;

  if(getdvarint("_encstr_8F5D1A63278BEFAA650DB8FC911BB52D611343B7B0CFCFC8351E57A3") == 0) {
    return;
  }
  var_2 = getdvarint("_encstr_ADD919BF3BCAA97C83B2F0BBEA872020299D330D9F721837AFBA2B", 0);

  if(var_2 == 0)
    var_2 = 4;

  var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];
  var_4 = 0;
  var_5 = level.spawnpoints;
  var_5 = scripts\mp\spawnscoring::checkdynamicspawns(var_5);

  foreach(var_7 in var_5) {
    if(!isDefined(var_7.frontlineteam) || var_7.frontlineteam != var_0) {
      continue;
    }
    if(!isDefined(var_7.fullsights) || !isDefined(var_7.fullsights[var_3]) || var_7.fullsights[var_3] <= 0)
      var_4++;
  }

  var_9 = var_4 / var_5.size;

  if(var_4 < var_2 || var_9 < 0.0) {
    if(var_4 < var_2)
      var_1.disabledreason[var_0] = 0;
    else
      var_1.disabledreason[var_0] = 1;

    var_1.isactive[var_0] = 0;
  }
}

currentspawnlogicsupportsfrontline() {
  return istrue(level.spawnglobals.frontlinelogictypes[level.spawnglobals.activespawnlogic]);
}

getglobalfrontlineinfo() {
  if(!isDefined(level.frontlineinfo)) {
    level.frontlineinfo = spawnStruct();
    level.frontlineinfo.isactive = [];
    level.frontlineinfo.isactive["_encstr_9A8507BA4040188D08"] = 0;
    level.frontlineinfo.isactive["_encstr_8E8405EA382B2A"] = 0;
    level.frontlineinfo.uptime = 0.0;
    level.frontlineinfo.downtime = 0.0;
    level.frontlineinfo.contested = 0;
    level.frontlineinfo.usinganchors = 0;
  }

  return level.frontlineinfo;
}

preferalliesbydistance(var_0) {
  if(var_0.totalplayers[self.team] == 0)
    return 0;

  var_1 = var_0.distsumsquared[self.team] / var_0.totalplayers[self.team];
  var_1 = min(var_1, 3240000);
  var_0.analytics.allyaveragedist = var_1;
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

preferclosetoally(var_0) {
  var_1 = min(var_0.mindistsquared[self.team], 3240000);
  var_2 = 1 - var_1 / 3240000;
  return var_2 * 100;
}

avoidenemiesbydistance(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased)
    var_1[0] = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  else
    var_1[var_1.size] = "_encstr_AF1904A7F929";

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0)
    return 100;

  foreach(var_4 in var_2) {
    if(var_0.mindistsquared[var_4] < 250000)
      return 0;
  }

  var_8 = 0;
  var_9 = 0;

  foreach(var_4 in var_2) {
    var_8 = var_8 + var_0.distsumsquaredcapped[var_4];
    var_9 = var_9 + var_0.totalplayers[var_4];
  }

  var_12 = var_8 / var_9;
  var_12 = min(var_12, 7290000);
  var_13 = var_12 / 7290000;
  var_0.analytics.enemyaveragedist = var_12;
  return var_13 * 100;
}

avoidenemyinfluence(var_0) {
  var_1 = undefined;

  if(level.teambased)
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  else
    var_1 = "_encstr_AF1904A7F929";

  if(var_0.mindistsquared[var_1] < level.enemyspawninfluencedistsq)
    return 0;

  return 100;
}

avoidclosestenemy(var_0) {
  var_1 = [];
  var_2 = [];

  if(level.teambased)
    var_1[0] = scripts\mp\utility\teams::getenemyteams(self.team)[0];
  else
    var_1[var_1.size] = "_encstr_AF1904A7F929";

  foreach(var_4 in var_1) {
    if(var_0.totalplayers[var_4] == 0) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0)
    return 100;

  var_6 = 0;

  foreach(var_4 in var_2) {
    if(var_0.mindistsquared[var_4] < 250000)
      return 0;

    var_8 = min(var_0.mindistsquared[var_4], 3240000);
    var_9 = var_8 / 3240000;
    var_6 = var_6 + var_9 * 100;
  }

  return var_6 / var_2.size;
}

avoidclosestenemybydistance(var_0) {
  var_1 = level.spawnglobals.activespawncontext.factorparams["_encstr_B6421CDFE1BF8870FE8B55C53F7F20EB55B7D9B30F5DAF5311ECAE61092A"];
  var_2 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_2 = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  var_3 = 0;

  foreach(var_5 in level.teamdata[var_2]["_encstr_9775086022BE1B413B8B"]) {
    var_6 = distancesquared(var_0.origin, var_5.origin);

    if(var_6 < var_3)
      var_3 = var_6;
  }

  if(var_3 < 250000)
    return 0;

  var_8 = min(var_3, var_1);
  var_9 = var_8 / var_1;
  return var_9 * 100;
}

preferdompoints(var_0) {
  var_1 = level.spawnglobals.activespawncontext.factorparams["_encstr_A57C1399B32A4CA8FA123911B7DFD0EF22472DE9DF"];
  var_2 = level.spawnglobals.activespawncontext.factorparams["_encstr_BA38137FA7A6E765EDA628911497B859DF983A1137"];
  var_3 = var_0.scriptdata;

  if(isDefined(var_3.domflagassignments)) {
    if(var_3.domflagassignments &var_1)
      return 100;
    else if(var_3.domflagassignments &var_2)
      return 50.0;
  }

  return 0;
}

preferclosepoints(var_0) {
  var_1 = level.spawnglobals.activespawncontext.factorparams["_encstr_96F30E26F427F36B7AEB31C05255318B"];

  foreach(var_3 in var_1) {
    if(var_0 == var_3)
      return 100;
  }

  return 0;
}

preferbyteambase(var_0, var_1) {
  if(isDefined(var_0.teambase) && var_0.teambase == var_1)
    return 100;

  return 0;
}

preferoptimalttlos(var_0) {
  var_1 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  var_2 = 1.0 - var_0.maxsightvalue[var_1];
  var_3 = scripts\mp\spawnlogic::getmaxdistancetolos();
  var_4 = var_2 * var_3;

  if(var_4 > 1200) {
    var_5 = (var_3 - var_4) / (var_3 - 1200);
    return 100 * var_5;
  } else {
    var_5 = var_4 / 1200;
    return 100 * var_5;
  }
}

avoidshorttimetoenemysight(var_0) {
  var_1 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  var_2 = 1.0 - var_0.maxsightvalue[var_1];
  var_0.analytics.maxenemysightfraction = var_2;
  return (1.0 - var_2) * 0 + var_2 * 100;
}

avoidshorttimetojumpingenemysight(var_0) {
  var_1 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  var_2 = 1.0 - var_0.maxjumpsightvalue[var_1];
  var_0.analytics.maxjumpingenemysightfraction = var_2;
  return (1.0 - var_2) * 0 + var_2 * 100;
}

avoidveryshorttimetojumpingenemysight(var_0) {
  var_1 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_1 = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  var_2 = 1.0 - var_0.maxjumpsightvalue[var_1];
  var_3 = var_2 * scripts\mp\spawnlogic::getmaxdistancetolos();

  if(var_3 < 300)
    return 0;
  else
    return 100;
}

randomspawnscore(var_0) {
  var_0.analytics.randomscore = randomintrange(0, 99);
  return var_0.analytics.randomscore;
}

maxplayerspawninfluencedistsquared(var_0) {
  return 3240000;
}

prefershortestdisttokothzone(var_0) {
  var_1 = level.spawnglobals.activespawncontext;
  var_2 = var_1.factorparams["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239"];
  var_3 = var_0.scriptdata.distsqtokothzones[var_2];
  var_4 = var_1.factorparams["_encstr_AC921AF7627031A3C02F53A7A46D886BA324607C1E2B45B62B6B3B4A"];
  var_5 = 1.0 - var_3 / var_4;
  return 100 * var_5 + 0;
}

avoidclosetokothzone(var_0) {
  var_1 = level.spawnglobals.activespawncontext;
  var_2 = var_1.factorparams["_encstr_95E3152CC6A35AEC5996A7A284A5BD9BCAE457B513B239"];
  var_3 = var_0.scriptdata.distsqtokothzones[var_2];
  var_4 = var_1.factorparams["_encstr_A1F117DA7BD18669F6CD5922B28523A7B7E65944D2DCD14DE2"];
  return scripts\engine\utility::ter_op(var_3 < var_4, 0, 100);
}

prefernearlastteamspawn(var_0) {
  var_1 = level.spawnglobals.lastteamspawnpoints[self.team];

  if(!isDefined(var_1))
    return 0;

  var_2 = distancesquared(var_1.origin, var_0.origin);
  var_2 = int(min(var_2, 9000000));
  var_3 = 1.0 - var_2 / 9000000;
  return 100 * var_3 + 0;
}

preferneargroupsofteammates(var_0) {
  var_1 = level.spawnglobals;
  var_2 = -1;

  foreach(var_4 in var_1.teamclusters[self.team].clusterlist) {
    if(var_4.players.size <= 1) {
      continue;
    }
    var_5 = distance2dsquared(var_4.center, var_0.origin);

    if(var_2 < 0 || var_5 < var_2)
      var_2 = var_5;
  }

  if(var_2 < 0)
    return 0;

  if(var_2 < 10000)
    return 100;

  var_2 = int(min(var_2, 9000000));
  var_7 = 1.0 - (var_2 - 10000) / 8990000;
  return 100 * var_7 + 0;
}

preferoccupiedlanes(var_0) {
  var_1 = level.spawnglobals;
  var_2 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_2 = scripts\mp\utility\teams::getenemyteams(self.team)[0];

  if(!isDefined(var_1.occupiedlanemasks[var_2]))
    return 0;

  if((var_0.lanemask &var_1.occupiedlanemasks[var_2]) != 0)
    return 100;
  else
    return 0;
}

prefertobalancelanes(var_0) {
  var_1 = level.spawnglobals;
  var_2 = scripts\mp\spawnlogic::getspawnteam(self);
  var_3 = "_encstr_AF1904A7F929";

  if(level.teambased)
    var_3 = scripts\mp\utility\teams::getenemyteams(var_2)[0];

  if(!isDefined(var_1.occupiedlanemasks[var_3]))
    return 0;

  var_4 = var_0.lanemask &var_1.occupiedlanemasks[var_3];
  var_5 = isDefined(var_1.occupiedlanemasks[var_2]) && var_0.lanemask &var_1.occupiedlanemasks[var_2];

  if(var_4 && !var_5)
    return 100;
  else
    return 0;
}

scriptonlytest(var_0) {
  return 0;
}

prefernearsinglepoint(var_0) {
  var_1 = level.spawnglobals.activespawncontext;
  var_2 = var_1.factorparams["_encstr_AC010F235BF6E9C08D57B80373D379FD42"];
  var_3 = var_1.factorparams["_encstr_AB4A1707F878FC2A27FDDB0D763B126780306B874B9004B17B"];
  var_4 = var_1.factorparams["_encstr_B6F71772A8518F3FFBB5DCEFDE40DB8F911029EA4025FB9F93"];
  var_5 = var_1.factorparams["_encstr_8B7619B96C4B981652F39F93339ADEC8FE472011DA8FB8305B7FAB"];
  var_6 = distance2dsquared(var_2, var_0.origin);

  if(var_6 >= var_4)
    return 0;

  if(var_6 <= var_3)
    return 100;

  var_7 = 1.0 - (var_6 - var_3) / var_5;
  return 100 * var_7;
}

avoidrugbyoffsides(var_0) {
  var_1 = level.spawnglobals.activespawncontext;
  var_2 = var_1.factorparams["_encstr_ADD8088D2D8F6867F773"];
  var_3 = var_1.factorparams["_encstr_B228102AB360C687444022BA09AD3F3A2249"];
  var_4 = (var_0.origin - var_2) * (1, 1, 0);
  var_5 = vectordot(var_4, var_3);

  if(var_5 >= 0)
    return 0;

  return 100;
}

oneusespawns(var_0) {
  var_1 = var_0.scriptdata;

  if(istrue(var_1.used))
    return 0;
  else
    return 100;
}

checkuseconditioninthink(var_0, var_1) {
  var_2 = undefined;
  var_3 = var_1["_encstr_AA3116F74B5B5B70C8386B125311196BAF6FE64264B8C2A2"];
  var_4 = var_1["_encstr_AC51159A71EC777DC83B8A46D118C76B802BC223583023"];
  var_5 = var_1["_encstr_850A20BFD580A2540989874FC0209DCBFC09472F293D6A0C81D0BD577D90B3E32E8B"];

  if(isDefined(var_3))
    var_2 = var_3;
  else if(isDefined(var_4))
    var_2 = var_4;

  if(isDefined(var_2)) {
    var_6 = distancesquared(var_2, var_0.origin);
    return scripts\engine\utility::ter_op(var_6 < var_5, 0, 100);
  } else
    return 100;
}

checkweaponswitch(var_0, var_1) {
  var_2 = var_0.scriptdata.lootchopper_createobjective;
  var_3 = var_1["_encstr_850A20BFD580A2540989874FC0209DCBFC09472F293D6A0C81D0BD577D90B3E32E8B"];
  return scripts\engine\utility::ter_op(var_2 < var_3, 0, 100);
}