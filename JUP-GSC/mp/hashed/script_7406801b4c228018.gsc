/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7406801b4c228018.gsc
*************************************************/

#using scripts\engine\utility;
#using scripts\mp\utility\teams;
#namespace namespace_f3e2bfae6c100ef7;

function getobjectiveparam(member, defvalue) {
  if(isDefined(level.zone) && isDefined(level.zone.objective.params[member])) {
    return level.zone.objective.params[member];
  }

  return defvalue;
}

function function_75354d8de2adc2a(zone) {
  bombsites = zone.bombzones;

  foreach(player in level.players) {
    if(istrue(player.isplanting)) {
      return false;
    }
  }

  return true;
}

function function_edcbb313f774a31a(zone) {
  sam_sites = zone.turrets;

  foreach(turret in sam_sites) {
    if(!isDefined(turret)) {
      continue;
    }

    if(is_equal(turret.var_f236a45969f96bb4, "defuse")) {
      return false;
    }
  }

  foreach(player in level.players) {
    if(istrue(player.var_385a26c0bfc712b4)) {
      return false;
    }
  }

  return true;
}

function function_9080aa9578d94aca(zone) {
  foreach(capture_zone in zone.capture_zones) {
    if(capture_zone.touchlist[game["attackers"]].size > 0) {
      return false;
    }
  }

  return true;
}

function function_375f5ed9ca0d5437(zone) {
  if(!isDefined(level.escortvehicles[0])) {
    return true;
  }

  tank = level.escortvehicles[0];

  if(is_equal(zone.objectivetype, 11)) {
    nearbyrange = getdvarint(@ "hash_f1c723884f919c10", 200);
  } else {
    nearbyrange = getdvarint(@ "hash_9133c54c3f6aee07", 300);
  }

  attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
  var_95f2a51e7b487eb2 = sortbydistancecullbyradius(attackers, tank.origin, nearbyrange);

  if(var_95f2a51e7b487eb2.size > 0) {
    return false;
  }

  return true;
}

function function_585d9ea0d3567c2f(zone) {
  foreach(hackzone in zone.hackzones) {
    if(istrue(hackzone.ishacking)) {
      return false;
    }

    if(istrue(hackzone.hacked) && !istrue(hackzone.complete)) {
      return false;
    }
  }

  return true;
}

function function_59da849245283fc8(zone) {
  if(zone.currentphase == "hack") {
    return function_585d9ea0d3567c2f(zone);
  } else if(zone.currentphase == "bomb") {
    foreach(bombzone in zone.bombzones) {
      if(istrue(bombzone.var_b7c18e4654e6881a) || istrue(bombzone.robbed)) {
        return false;
      }
    }
  }

  return true;
}

function function_c59f8281fad3515b(zone) {
  if(zone.currentphase == "capture_zone") {
    if(zone.flag_capture_zone.touchlist[game["attackers"]].size > 0) {
      return false;
    }

    return true;
  }

  return true;
}

function function_23eb8b768403db5e(zone) {
  if(zone.currentphase == "wheelson_escort") {
    return function_375f5ed9ca0d5437(zone);
  }

  foreach(capture_zone in zone.var_3abf844425ac7c00.capture_zones) {
    if(capture_zone.touchlist[game["attackers"]].size > 0) {
      return 0;
    }
  }

  return 1;
}

function function_af28caae69f5d8f2(zone) {
  if(!isDefined(level.escortvehicles[0])) {
    return true;
  }

  foreach(tank in level.escortvehicles) {
    if(is_equal(zone.objectivetype, 11)) {
      nearbyrange = getdvarint(@ "hash_f1c723884f919c10", 200);
    } else {
      nearbyrange = getdvarint(@ "hash_9133c54c3f6aee07", 300);
    }

    attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
    var_95f2a51e7b487eb2 = sortbydistancecullbyradius(attackers, tank.origin, nearbyrange);

    if(var_95f2a51e7b487eb2.size > 0) {
      return false;
    }
  }

  return true;
}

function function_bbaf59363e16090d(zone) {
  foreach(bombzone in zone.bombzones) {
    if(istrue(bombzone.complete)) {
      continue;
    }

    if(istrue(bombzone.var_b7c18e4654e6881a) || istrue(bombzone.robbed)) {
      return false;
    }
  }

  return true;
}

function function_5755f5c774e319d6(zone) {
  foreach(target in level.var_7f636ee164a47ef7) {
    if(istrue(target.marker.complete)) {
      continue;
    }

    if(istrue(target.underattack)) {
      return false;
    }
  }

  return true;
}

function function_2d5f2773c38a9b93(time) {
  level.extratime += time;
}