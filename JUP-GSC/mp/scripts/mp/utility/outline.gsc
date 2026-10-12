/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\outline.gsc
***********************************************/

#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\outline;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace outline;

function outlineenableforall(var_f20913fec7561c5f, hudoutlineassetname, prioritygroup) {
  playersvisibleto = level.players;
  return scripts\mp\outline::outlineenableinternal(var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, "ALL");
}

function outlineenableforteam(var_f20913fec7561c5f, teamvisibleto, hudoutlineassetname, prioritygroup, var_213fdd3689d4b33e) {
  if(isgameplayteam(teamvisibleto)) {
    playersvisibleto = getteamdata(teamvisibleto, "players");
  } else {
    playersvisibleto = [];
  }

  if(isDefined(var_213fdd3689d4b33e)) {
    var_404eeafd8dc3f0f0 = [];

    if(isarray(var_213fdd3689d4b33e)) {
      var_404eeafd8dc3f0f0 = var_213fdd3689d4b33e;
    } else if(isPlayer(var_213fdd3689d4b33e)) {
      var_404eeafd8dc3f0f0 = [var_213fdd3689d4b33e];
    }

    foreach(playertoignore in var_404eeafd8dc3f0f0) {
      if(isDefined(playertoignore.team) && playertoignore.team == teamvisibleto) {
        playersvisibleto = scripts\engine\utility::array_remove(playersvisibleto, playertoignore);
      }
    }
  }

  return scripts\mp\outline::outlineenableinternal(var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, "TEAM", teamvisibleto);
}

function outlineenableforsquad(var_f20913fec7561c5f, teamvisibleto, squadindex, hudoutlineassetname, prioritygroup) {
  assertex(scripts\cp_mp\utility\squad_utility::issquadmode(), "<dev string:x1c>");
  assertex(isDefined(level.squaddata[teamvisibleto]), "<dev string:x54>" + teamvisibleto);
  assertex(!isDefined(level.squaddata[teamvisibleto]) || isDefined(level.squaddata[teamvisibleto][squadindex]), "<dev string:x99>" + squadindex);
  playersvisibleto = level.squaddata[teamvisibleto][squadindex].players;
  return scripts\mp\outline::outlineenableinternal(var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, "SQUAD", teamvisibleto, squadindex);
}

function outlineenableforplayer(var_f20913fec7561c5f, var_18ebeb29bb7541e3, hudoutlineassetname, prioritygroup) {
  if(isagent(var_18ebeb29bb7541e3)) {
    return scripts\mp\outline::outlinegenerateuniqueid();
  }

  return scripts\mp\outline::outlineenableinternal(var_f20913fec7561c5f, [var_18ebeb29bb7541e3], hudoutlineassetname, prioritygroup, "ENTITY");
}

function outlinedisable(id, entoutlined) {
  assertex(isDefined(id) && int(id) == id, "<dev string:xed>");
  scripts\mp\outline::outlinedisableinternal(id, entoutlined);
}

function outlinerefresh(entoutlined) {
  assertex(isDefined(entoutlined), "<dev string:x116>");
  scripts\mp\outline::outlinerefreshinternal(entoutlined);
}

function initoutlineoccluders() {
  level.outlineoccluders = [];
  level.outlineoccludersid = 0;
}

function addoutlineoccluder(position, radius) {
  outlineoccluder = spawnStruct();
  outlineoccluder.position = position;
  outlineoccluder.radius = radius;
  id = level.outlineoccludersid;
  level.outlineoccluders[id] = outlineoccluder;
  level.outlineoccludersid++;
  return id;
}

function removeoutlineoccluder(id) {
  level.outlineoccluders[id] = undefined;
}

function outlineoccluded(startpoint, endpoint) {
  foreach(occluder in level.outlineoccluders) {
    if(!isDefined(occluder) || !isDefined(occluder.position) || !isDefined(occluder.radius)) {
      continue;
    }

    if(math::segmentvssphere(startpoint, endpoint, occluder.position, occluder.radius)) {
      return true;
    }
  }

  return false;
}

function function_6b8603ff55f4ed2c(victimgroup, attacker, var_9cc7d33e2e2ebfef, duration, outlineassetname, prioritygroup) {
  assertex(isDefined(victimgroup), "<dev string:x14a>");
  assertex(isDefined(attacker), "<dev string:x1a6>");

  if(!isDefined(var_9cc7d33e2e2ebfef)) {
    var_9cc7d33e2e2ebfef = [attacker];
  }

  if(!isDefined(duration)) {
    duration = 1000;
  } else {
    duration *= 1000;
  }

  if(!isDefined(outlineassetname)) {
    outlineassetname = "snapshotgrenade";
  }

  if(!isDefined(prioritygroup)) {
    prioritygroup = "equipment";
  }

  outlinedata = undefined;
  outlinedata = spawnStruct();
  outlinedata.owner = attacker;
  outlinedata.isalive = 1;
  outlinedata.targets = [];
  outlinedata.endtimes = [];
  outlinedata.outlineids = [];

  foreach(victim in victimgroup) {
    if(!isent(victim)) {
      continue;
    }

    entnum = victim getentitynumber();
    outlinedata.targets[entnum] = victim;
    outlinedata.endtimes[entnum] = gettime() + duration;
    outlinedata.outlineids[entnum] = scripts\mp\outline::outlineenableinternal(victim, var_9cc7d33e2e2ebfef, outlineassetname, prioritygroup, "ENTITY");
  }

  outlinedata thread function_2f7892fd0b6b8251();
}

function private function_2f7892fd0b6b8251() {
  self endon("death");
  self.owner endon("death_or_disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  if(!istrue(self.isalive)) {
    return;
  }

  while(self.targets.size > 0) {
    foreach(id, target in self.targets) {
      target = self.targets[id];
      endtime = self.endtimes[id];
      outlineid = self.outlineids[id];

      if(!isDefined(target) || !isreallyalive(target) || gettime() >= endtime) {
        scripts\mp\utility\outline::outlinedisable(outlineid, target);

        if(isDefined(target) && (isPlayer(target) || isbot(target))) {
          target scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
        }

        self.targets[id] = undefined;
        self.endtimes[id] = undefined;
        self.outlineids[id] = undefined;
      }
    }

    waitframe();
  }

  function_357b6df5a3d41e9c();
}

function private function_357b6df5a3d41e9c() {
  self notify("death");
  self.isalive = 0;

  foreach(id, target in self.targets) {
    target = self.targets[id];
    outlineid = self.outlineids[id];
    scripts\mp\utility\outline::outlinedisable(outlineid, target);

    if(isDefined(target) && (isPlayer(target) || isbot(target))) {
      target scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
    }
  }
}

function _hudoutlineviewmodeldisable() {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  self hudoutlineviewmodeldisable();
}

function _hudoutlineviewmodelenable(hudoutlineassetname, var_dafd99b070fb282a) {
  if(!isDefined(var_dafd99b070fb282a)) {
    var_dafd99b070fb282a = 0;
  }

  if(!isPlayer(self)) {
    assertmsg("<dev string:x20f>");
    return;
  }

  if(!var_dafd99b070fb282a && !scripts\cp_mp\utility\player_utility::_isalive()) {
    assertmsg("<dev string:x22a>");
    return;
  }

  if(var_dafd99b070fb282a && !scripts\cp_mp\utility\player_utility::_isalive()) {
    thread hudoutlineviewmodelenableonnextspawn(hudoutlineassetname);
    return;
  }

  self hudoutlineviewmodelenable(hudoutlineassetname);
}

function hudoutlineviewmodelenableonnextspawn(hudoutlineassetname) {
  level endon("game_ended");
  self waittill("spawned");

  if(!isDefined(self)) {
    return;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  self hudoutlineviewmodelenable(hudoutlineassetname);
}