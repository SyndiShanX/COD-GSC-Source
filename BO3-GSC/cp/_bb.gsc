/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_bb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\bb_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace bb;

function autoexec __init__sytem__() {
  system::register("bb", &__init__, undefined, undefined);
}

function __init__() {
  init_shared();
}

function private function_edae084d(player) {
  var_24a24c3f = "";
  if(isDefined(player.var_b3dc8451)) {
    for(index = 0; index < player.var_b3dc8451.size; index++) {
      if(isDefined(player.var_b3dc8451[index]) && player.var_b3dc8451[index]) {
        if(isDefined(var_24a24c3f) && var_24a24c3f != "") {
          var_24a24c3f = var_24a24c3f + ";";
        }
        var_24a24c3f = var_24a24c3f + index;
      }
    }
  }
  return var_24a24c3f;
}

function private function_b918cb9(player) {
  var_6a98da9a = "";
  foreach(var_3ca39bd6, var_ee404e07 in player.var_1c0132c) {
    if(var_6a98da9a != "") {
      var_6a98da9a = var_6a98da9a + ";";
    }
    var_6a98da9a = var_6a98da9a + ((var_3ca39bd6 + ":") + var_ee404e07);
  }
  return var_6a98da9a;
}

function logmatchsummary(player) {
  if(!isPlayer(player)) {
    return;
  }
  var_4b34a5fc = 1;
  if(isDefined(player.deaths) && player.deaths > 0) {
    var_4b34a5fc = player.deaths;
  }
  kdratio = player.kills / var_4b34a5fc;
  playertime = 0;
  if(isDefined(player.connectedtime)) {
    playertime = gettime() - player.connectedtime;
  }
  totalshots = 0;
  shotshit = 0;
  if(isDefined(player._bbdata)) {
    totalshots = (isDefined(player._bbdata["shots"]) ? player._bbdata["shots"] : 0);
    shotshit = (isDefined(player._bbdata["hits"]) ? player._bbdata["hits"] : 0);
  }
  accuracy = 0;
  if(totalshots > 0) {
    accuracy = shotshit / totalshots;
  }
  var_6a98da9a = function_b918cb9(player);
  var_24a24c3f = function_edae084d(player);
  corners = getEntArray("minimap_corner", "targetname");
  dimensions0 = 0;
  dimensions1 = 0;
  if(isDefined(corners) && corners.size >= 2) {
    dimensions0 = corners[1].origin[0] - corners[0].origin[0];
    dimensions1 = corners[1].origin[1] - corners[0].origin[1];
  }
  rankxp = 0;
  rank = 0;
  if(isDefined(player.pers)) {
    if(isDefined(player.pers["rank"])) {
      rank = player.pers["rank"];
    }
    if(isDefined(player.pers["rankxp"])) {
      rankxp = player.pers["rankxp"];
    }
  }
  doublejumpdistance = 0;
  doublejumpcount = 0;
  doublejumptime = 0;
  wallrundistance = 0;
  wallruncount = 0;
  wallruntime = 0;
  sprintdistance = 0;
  sprintcount = 0;
  sprinttime = 0;
  if(isDefined(player.movementtracking)) {
    if(isDefined(player.movementtracking.doublejump)) {
      doublejumpdistance = player.movementtracking.doublejump.distance;
      doublejumpcount = player.movementtracking.doublejump.count;
      doublejumptime = player.movementtracking.doublejump.time;
    }
    if(isDefined(player.movementtracking.wallrunning)) {
      wallrundistance = player.movementtracking.wallrunning.distance;
      wallruncount = player.movementtracking.wallrunning.count;
      wallruntime = player.movementtracking.wallrunning.time;
    }
    if(isDefined(player.movementtracking.sprinting)) {
      sprintdistance = player.movementtracking.sprinting.distance;
      sprintcount = player.movementtracking.sprinting.count;
      sprinttime = player.movementtracking.sprinting.time;
    }
  }
  playerid = getplayerspawnid(player);
  bestkillstreak = (isDefined(player.pers["best_kill_streak"]) ? player.pers["best_kill_streak"] : 0);
  meleekills = (isDefined(player.meleekills) ? player.meleekills : 0);
  headshots = (isDefined(player.headshots) ? player.headshots : 0);
  var_7b9eb83b = (isDefined(player.primaryloadoutweapon) ? player.primaryloadoutweapon.name : "undefined");
  currentweapon = (isDefined(player.currentweapon) ? player.currentweapon.name : "undefined");
  grenadesused = (isDefined(player.grenadesused) ? player.grenadesused : 0);
  playername = (isDefined(player.name) ? player.name : "undefined");
  kills = (isDefined(player.kills) ? player.kills : 0);
  deaths = (isDefined(player.deaths) ? player.deaths : 0);
  incaps = (isDefined(player.pers["incaps"]) ? player.pers["incaps"] : 0);
  assists = (isDefined(player.assists) ? player.assists : 0);
  score = (isDefined(player.score) ? player.score : 0);
  bbprint("cpplayermatchsummary", "gametime %d spawnid %d username %s kills %d deaths %d incaps %d kd %f shotshit %d totalshots %d accuracy %f assists %d score %d playertime %d meleekills %d headshots %d primaryloadoutweapon %s currentweapon %s grenadesused %d bestkillstreak %d dj_dist %d dj_count %d dj_time %d wallrun_dist %d wallrun_count %d wallrun_time %d sprint_dist %d sprint_count %d sprint_time %d cybercomsused %s dim0 %d dim1 %d rank %d rankxp %d collectibles %s", gettime(), playerid, playername, kills, deaths, incaps, kdratio, shotshit, totalshots, accuracy, assists, score, playertime, meleekills, headshots, var_7b9eb83b, currentweapon, grenadesused, bestkillstreak, doublejumpdistance, doublejumpcount, doublejumptime, wallrundistance, wallruncount, wallruntime, sprintdistance, sprintcount, sprinttime, var_6a98da9a, dimensions0, dimensions1, rank, rankxp, var_24a24c3f);
}

function logobjectivestatuschange(objectivename, player, status) {
  playerid = -1;
  if(isPlayer(player)) {
    playerid = getplayerspawnid(player);
  } else {
    return;
  }
  bbprint("cpcheckpoints", "gametime %d spawnid %d username %s checkpointname %s eventtype %s playerx %d playery %d playerz %d kills %d revives %d deathcount %d deaths %d headshots %d hits %d score %d shotshit %d shotsmissed %d suicides %d downs %d difficulty %s", gettime(), playerid, player.name, objectivename, status, player.origin, player.kills, player.revives, player.deathcount, player.deaths, player.headshots, player.hits, player.score, player.shotshit, player.shotsmissed, player.suicides, player.downs, level.currentdifficulty);
}

function logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned) {
  victimid = -1;
  victimname = "";
  victimtype = "";
  victimorigin = (0, 0, 0);
  victimignoreme = 0;
  victimignoreall = 0;
  victimfovcos = 0;
  victimmaxsightdistsqrd = 0;
  victimanimname = "";
  victimlaststand = 0;
  victimdowns = 0;
  attackerid = -1;
  attackername = "";
  attackertype = "";
  attackerorigin = (0, 0, 0);
  attackerignoreme = 0;
  attackerignoreall = 0;
  attackerfovcos = 0;
  attackermaxsightdistsqrd = 0;
  attackeranimname = "";
  attackerlaststand = 0;
  var_e5f9350b = "";
  var_b8b49851 = "";
  aivictimcombatmode = "";
  var_c46938ee = "";
  var_5833b024 = "";
  aiattackercombatmode = "";
  if(isDefined(attacker)) {
    if(isPlayer(attacker)) {
      attackerid = getplayerspawnid(attacker);
      attackertype = "_player";
      attackername = attacker.name;
    } else {
      if(isai(attacker)) {
        attackertype = "_ai";
        aiattackercombatmode = attacker.combatmode;
        attackerid = attacker.actor_id;
      } else {
        attackertype = "_other";
      }
    }
    attackerorigin = attacker.origin;
    attackerignoreme = attacker.ignoreme;
    attackerfovcos = attacker.fovcosine;
    attackermaxsightdistsqrd = attacker.maxsightdistsqrd;
    if(isDefined(attacker.animname)) {
      attackeranimname = attacker.animname;
    }
    if(isDefined(attacker.laststand)) {
      attackerlaststand = attacker.laststand;
    }
  }
  if(isDefined(victim)) {
    if(isPlayer(victim)) {
      victimid = getplayerspawnid(victim);
      victimtype = "_player";
      victimname = victim.name;
      victimdowns = victim.downs;
    } else {
      if(isai(victim)) {
        victimtype = "_ai";
        aivictimcombatmode = victim.combatmode;
        victimid = victim.actor_id;
      } else {
        victimtype = "_other";
      }
    }
    victimorigin = victim.origin;
    victimignoreme = victim.ignoreme;
    victimfovcos = victim.fovcosine;
    victimmaxsightdistsqrd = victim.maxsightdistsqrd;
    if(isDefined(victim.animname)) {
      victimanimname = victim.animname;
    }
    if(isDefined(victim.laststand)) {
      victimlaststand = victim.laststand;
    }
  }
  bbprint("cpattacks", "gametime %d attackerid %d attackertype %s attackername %s attackerweapon %s attackerx %d attackery %d attackerz %d aiattckercombatmode %s attackerignoreme %d attackerignoreall %d attackerfovcos %d attackermaxsightdistsqrd %d attackeranimname %s attackerlaststand %d victimid %d victimtype %s victimname %s victimx %d victimy %d victimz %d aivictimcombatmode %s victimignoreme %d victimignoreall %d victimfovcos %d victimmaxsightdistsqrd %d victimanimname %s victimlaststand %d damage %d damagetype %s damagelocation %s death %d victimdowned %d downs %d", gettime(), attackerid, attackertype, attackername, weapon.name, attackerorigin, aiattackercombatmode, attackerignoreme, attackerignoreall, attackerfovcos, attackermaxsightdistsqrd, attackeranimname, attackerlaststand, victimid, victimtype, victimname, victimorigin, aivictimcombatmode, victimignoreme, victimignoreall, victimfovcos, victimmaxsightdistsqrd, victimanimname, victimlaststand, damage, damagetype, hitlocation, victimkilled, victimdowned, victimdowns);
}

function logaispawn(aient, spawner) {
  bbprint("cpaispawn", "gametime %d actorid %d aitype %s archetype %s airank %s accuracy %d originx %d originy %d originz %d weapon %s team %s alertlevel %s grenadeawareness %d canflank %d engagemaxdist %d engagemaxfalloffdist %d engagemindist %d engageminfalloffdist %d health %d", gettime(), aient.actor_id, aient.aitype, aient.archetype, aient.airank, aient.accuracy, aient.origin, aient.primaryweapon.name, aient.team, aient.alertlevel, aient.grenadeawareness, aient.canflank, aient.engagemaxdist, aient.var_48ae01f2, aient.engagemindist, aient.engageminfalloffdist, aient.health);
}

function logplayermapnotification(notificationtype, player) {
  playerid = -1;
  playertype = "";
  playerposition = (0, 0, 0);
  playername = "";
  if(isai(player)) {
    playerid = player.actor_id;
    playertype = "_ai";
    playerposition = player.origin;
  } else if(isPlayer(player)) {
    playerid = getplayerspawnid(player);
    playertype = "_player";
    playerposition = player.origin;
    playername = player.name;
  }
  bbprint("cpnotifications", "gametime %d notificationtype %s spawnid %d username %s spawnidtype %s locationx %d locationy %d locationz %d", gettime(), notificationtype, playerid, playername, playertype, playerposition);
}

function logcybercomevent(player, event, gadget) {
  userid = -1;
  usertype = "";
  userposition = (0, 0, 0);
  username = "";
  if(isai(player)) {
    userid = player.actor_id;
    usertype = "_ai";
    userposition = player.origin;
  } else if(isPlayer(player)) {
    userid = getplayerspawnid(player);
    usertype = "_player";
    userposition = player.origin;
    username = player.name;
  }
  bbprint("cpcybercomevents", "gametime %d userid %d username %s usertype %s eventtype %s gadget %s locationx %d locationy %d locationz %d", gettime(), userid, username, usertype, event, gadget, userposition);
}

function logexplosionevent(destructible_ent, attacker, logexplosionevent, radius) {
  attackerid = -1;
  attackertype = "";
  attackerposition = (0, 0, 0);
  attackerusername = "";
  if(isai(attacker)) {
    attackerid = attacker.actor_id;
    attackertype = "_ai";
    attackerposition = attacker.origin;
  } else if(isPlayer(attacker)) {
    attackerid = getplayerspawnid(attacker);
    attackertype = "_player";
    attackerposition = attacker.origin;
    attackerusername = attacker.name;
  }
  bbprint("cpexplosionevents", "gametime %d explosiontype %s objectname %s attackerid %d attackerusername %s attackertype %s locationx %d locationy %d locationz %d radius %d attackerx %d attackery %d attackerz %d", gettime(), logexplosionevent, destructible_ent.classname, attackerid, attackerusername, attackertype, destructible_ent.origin, radius, attackerposition);
}