/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_spawnscoring.gsc
*****************************************************/

zombiecriticalfactors_global(var_0) {
  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidgrenades, var_0)) {
    return "secondary";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidgasclouds, var_0)) {
    return "secondary";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidmines, var_0)) {
    return "secondary";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidairstrikelocations, var_0)) {
    return "secondary";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidcarepackages, var_0)) {
    return "secondary";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidtelefrag, var_0)) {
    return "secondary";
  }

  if(!maps\mp\gametypes\_spawnfactor::critical_factor(maps\mp\gametypes\_spawnfactor::avoidenemyspawn, var_0)) {
    return "secondary";
  }

  return "primary";
}

getzombiesspawnpoint_neartombstone(var_0) {
  var_0 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_0);
  var_1["primary"] = [];
  var_1["secondary"] = [];
  var_1["bad"] = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    maps\mp\gametypes\_spawnscoring::initscoredata(var_4);

    if(!isinvalidzone(var_4)) {
      continue;
    }
    var_4.criticalresult = zombiecriticalfactors_global(var_4);
    var_1[var_4.criticalresult][var_1[var_4.criticalresult].size] = var_4;
    var_2[var_2.size] = var_4;
  }

  if(var_1["primary"].size) {
    var_6 = scorespawns_neartombstone(var_1["primary"]);
  } else if(var_1["secondary"].size) {
    var_6 = scorespawns_neartombstone(var_1["secondary"]);
  } else if(var_2.size) {
    var_6 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_2[0], var_2);
  } else {
    var_6 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_0[0], var_0);
  }

  foreach(var_4 in var_0) {
    maps\mp\gametypes\_spawnscoring::recon_log_spawnpoint_info_wrapper(var_4);
    var_4.criticalresult = undefined;
  }

  return var_6;
}

scorespawns_neartombstone(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    scorefactors_neartombstone(var_3);

    if(!isDefined(var_1) || var_3.totalscore > var_1.totalscore) {
      var_1 = var_3;
    }
  }

  if(isDefined(var_1)) {
    var_1 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_1, var_0);
  } else {
    var_1 = maps\mp\gametypes\_spawnscoring::scorespawns_nearteam(var_0);
  }

  return var_1;
}

scorefactors_neartombstone(var_0) {
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(2.0, ::prefertombstonebydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.5, maps\mp\gametypes\_spawnfactor::preferalliesbydistance, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(1.25, maps\mp\gametypes\_spawnfactor::avoidrecentlyused, var_0);
  var_0.totalscore = var_0.totalscore + var_1;
  var_1 = maps\mp\gametypes\_spawnfactor::score_factor(0.25, maps\mp\gametypes\_spawnfactor::avoidsamespawn, var_0);
  var_0.totalscore = var_0.totalscore + var_1;

  if(isDefined(level.usezoneconnectiontombstonescoring) && level.usezoneconnectiontombstonescoring) {
    var_1 = maps\mp\gametypes\_spawnfactor::score_factor(2.0, ::prefershortzoneconnection, var_0);
    var_0.totalscore = var_0.totalscore + var_1;
  } else if(isDefined(level.zone_is_contaminated_func)) {
    var_1 = maps\mp\gametypes\_spawnfactor::score_factor(2.0, ::prefershortzoneconnectionnoninfected, var_0);
    var_0.totalscore = var_0.totalscore + var_1;
  }
}

isinvalidzone(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return 1;
  }

  if(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled(var_0.script_noteworthy)) {
    return 0;
  }

  if(isDefined(level.zone_is_contaminated_func) && [[level.zone_is_contaminated_func]](var_0.script_noteworthy)) {
    return 0;
  }

  return 1;
}

prefershortzoneconnection(var_0) {
  if(!isDefined(self.lastdeathpos)) {
    return 100;
  }

  var_1 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.lastdeathpos);

  if(!isDefined(var_1)) {
    var_1 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.lastdeathpos + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0));
  }

  if(!isDefined(var_1)) {
    return 100;
  }

  var_2 = maps\mp\zombies\_zombies_zone_manager::getzoneconnectionlength(var_1, var_0.script_noteworthy);

  if(var_2 < 0) {
    return 0;
  }

  if(var_2 == 0) {
    return 100;
  }

  return 100 / var_2;
}

prefershortzoneconnectionnoninfected(var_0) {
  if(!isDefined(self.lastdeathpos)) {
    return 100;
  }

  var_1 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.lastdeathpos);

  if(!isDefined(var_1)) {
    var_1 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(self.lastdeathpos + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0));
  }

  if(!isDefined(var_1)) {
    return 100;
  }

  var_2 = maps\mp\zombies\_zombies_zone_manager::getzoneinfectedconnectionlength(var_1, var_0.script_noteworthy);

  if(var_2 < 0) {
    return 0;
  }

  if(var_2 == 0) {
    return 100;
  }

  return 100 / var_2;
}

prefertombstonebydistance(var_0) {
  if(!isDefined(self.lastdeathpos)) {
    return 100;
  }

  var_1 = distance(var_0.origin, self.lastdeathpos);

  if(var_1 >= 2500 || var_1 <= 500) {
    return 0;
  }

  var_2 = max(0.0, 1.0 - abs(1500 - var_1) / 1000);
  return var_2 * 100;
}

getzombiesspawnpoint_nearteam(var_0) {
  var_0 = maps\mp\gametypes\_spawnscoring::checkdynamicspawns(var_0);
  var_1["primary"] = [];
  var_1["secondary"] = [];
  var_1["bad"] = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    maps\mp\gametypes\_spawnscoring::initscoredata(var_4);

    if(!isinvalidzone(var_4)) {
      continue;
    }
    var_4.criticalresult = zombiecriticalfactors_global(var_4);
    var_1[var_4.criticalresult][var_1[var_4.criticalresult].size] = var_4;
    var_2[var_2.size] = var_4;
  }

  if(var_1["primary"].size) {
    var_6 = scorezombiespawns_nearteam(var_1["primary"]);
  } else if(var_1["secondary"].size) {
    var_6 = scorezombiespawns_nearteam(var_1["secondary"]);
  } else if(var_2.size) {
    var_6 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_2[0], var_2);
  } else {
    var_6 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_0[0], var_0);
  }

  foreach(var_4 in var_0) {
    maps\mp\gametypes\_spawnscoring::recon_log_spawnpoint_info_wrapper(var_4);
    var_4.criticalresult = undefined;
  }

  return var_6;
}

scorezombiespawns_nearteam(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    maps\mp\gametypes\_spawnscoring::scorefactors_nearteam(var_3);

    if(!isDefined(var_1) || var_3.totalscore > var_1.totalscore) {
      var_1 = var_3;
    }
  }

  if(isDefined(var_1)) {
    var_1 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_1, var_0);
  } else {
    var_1 = maps\mp\gametypes\_spawnscoring::scorespawns_nearteam(var_0);
  }

  return var_1;
}

getzombiesspawnpoint_aizombies(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_0) {
    maps\mp\gametypes\_spawnscoring::initscoredata(var_5);

    if(var_5 maps\mp\zombies\_zombies_zone_manager::spawnercanbeusedfor(var_1, var_2)) {
      var_3[var_3.size] = var_5;
    }
  }

  if(var_3.size) {
    var_7 = scorespawns_aizombies(var_3, var_1, var_2);
  } else {
    var_7 = maps\mp\gametypes\_spawnscoring::selectbestspawnpoint(var_0);
  }

  return var_7;
}

scorespawns_aizombies(var_0, var_1, var_2) {
  var_3 = var_0[0];

  foreach(var_5 in var_0) {
    scorefactors_aizombies(var_5, var_1, var_2);

    if(!isDefined(var_3) || var_5.totalscore > var_3.totalscore) {
      var_3 = var_5;
    }
  }

  return var_3;
}

scorefactors_aizombies(var_0, var_1, var_2) {
  var_3 = score_factor_ai(2.0, ::preferplayerinzone, var_0);
  var_0.totalscore = var_0.totalscore + var_3;
  var_3 = score_factor_ai(1.0, ::avoidrecentlyusedspawns, var_0);
  var_0.totalscore = var_0.totalscore + var_3;
  var_3 = score_factor_ai(6.0, ::matchclassname, var_0, var_1, var_2);
  var_0.totalscore = var_0.totalscore + var_3;
}

matchclassname(var_0, var_1, var_2) {
  if(var_0 maps\mp\zombies\_zombies_zone_manager::spawnercanbeusedfor(var_1, var_2)) {
    return 100;
  }

  return 0;
}

preferplayerinzone(var_0) {
  if(!isDefined(var_0.zone_name)) {
    return 0;
  }

  if(maps\mp\zombies\_zombies_zone_manager::isplayerinzone(var_0.zone_name)) {
    return 100;
  }

  return 0;
}

avoidrecentlyusedspawns(var_0) {
  if(isDefined(var_0.lastspawntime)) {
    var_1 = gettime() - var_0.lastspawntime;

    if(var_1 > 30000) {
      return 100;
    }

    return var_1 / 30000 * 100;
  }

  return 100;
}

preferloneplayers(var_0) {
  if(!isDefined(var_0.zone_name)) {
    return 0;
  }

  var_1 = maps\mp\zombies\_zombies_zone_manager::getnumberofplayersinzone(var_0.zone_name);

  if(var_1 == 0) {
    return 0;
  }

  return 100 * (1.0 - var_1 * 0.15);
}

score_factor_ai(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = [[var_1]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    var_5 = [[var_1]](var_2, var_3);
  } else {
    var_5 = [[var_1]](var_2);
  }

  var_5 = clamp(var_5, 0, 100);
  var_5 = var_5 * var_0;
  return var_5;
}