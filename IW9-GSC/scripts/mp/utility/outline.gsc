/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\outline.gsc
***********************************************/

outlineenableforall(_id_F20913FEC7561C5F, hudoutlineassetname, prioritygroup) {
  playersvisibleto = level.players;
  return scripts\mp\outline::outlineenableinternal(_id_F20913FEC7561C5F, playersvisibleto, hudoutlineassetname, prioritygroup, "ALL");
}

outlineenableforteam(_id_F20913FEC7561C5F, _id_00FA3B23D51C2DC7, hudoutlineassetname, prioritygroup, _id_213FDD3689D4B33E) {
  if(scripts\mp\utility\teams::isgameplayteam(_id_00FA3B23D51C2DC7))
    playersvisibleto = scripts\mp\utility\teams::getteamdata(_id_00FA3B23D51C2DC7, "players");
  else
    playersvisibleto = [];

  if(isDefined(_id_213FDD3689D4B33E)) {
    _id_404EEAFD8DC3F0F0 = [];

    if(isarray(_id_213FDD3689D4B33E))
      _id_404EEAFD8DC3F0F0 = _id_213FDD3689D4B33E;
    else if(isPlayer(_id_213FDD3689D4B33E))
      _id_404EEAFD8DC3F0F0 = [_id_213FDD3689D4B33E];

    foreach(_id_6B0EE97314AED333 in _id_404EEAFD8DC3F0F0) {
      if(isDefined(_id_6B0EE97314AED333.team) && _id_6B0EE97314AED333.team == _id_00FA3B23D51C2DC7)
        playersvisibleto = scripts\engine\utility::array_remove(playersvisibleto, _id_6B0EE97314AED333);
    }
  }

  return scripts\mp\outline::outlineenableinternal(_id_F20913FEC7561C5F, playersvisibleto, hudoutlineassetname, prioritygroup, "TEAM", _id_00FA3B23D51C2DC7);
}

outlineenableforsquad(_id_F20913FEC7561C5F, _id_00FA3B23D51C2DC7, squadindex, hudoutlineassetname, prioritygroup) {
  playersvisibleto = level.squaddata[_id_00FA3B23D51C2DC7][squadindex].players;
  return scripts\mp\outline::outlineenableinternal(_id_F20913FEC7561C5F, playersvisibleto, hudoutlineassetname, prioritygroup, "SQUAD", _id_00FA3B23D51C2DC7, squadindex);
}

outlineenableforplayer(_id_F20913FEC7561C5F, _id_18EBEB29BB7541E3, hudoutlineassetname, prioritygroup) {
  if(isagent(_id_18EBEB29BB7541E3))
    return scripts\mp\outline::outlinegenerateuniqueid();

  return scripts\mp\outline::outlineenableinternal(_id_F20913FEC7561C5F, [_id_18EBEB29BB7541E3], hudoutlineassetname, prioritygroup, "ENTITY");
}

outlinedisable(id, _id_420A996E67989DC4) {
  scripts\mp\outline::outlinedisableinternal(id, _id_420A996E67989DC4);
}

outlinerefresh(_id_420A996E67989DC4) {
  scripts\mp\outline::outlinerefreshinternal(_id_420A996E67989DC4);
}

initoutlineoccluders() {
  level.outlineoccluders = [];
  level.outlineoccludersid = 0;
}

addoutlineoccluder(position, radius) {
  _id_F676533B6410938E = spawnStruct();
  _id_F676533B6410938E.position = position;
  _id_F676533B6410938E.radius = radius;
  id = level.outlineoccludersid;
  level.outlineoccluders[id] = _id_F676533B6410938E;
  level.outlineoccludersid++;
  return id;
}

removeoutlineoccluder(id) {
  level.outlineoccluders[id] = undefined;
}

outlineoccluded(startpoint, endpoint) {
  foreach(occluder in level.outlineoccluders) {
    if(!isDefined(occluder) || !isDefined(occluder.position) || !isDefined(occluder.radius)) {
      continue;
    }
    if(scripts\engine\math::segmentvssphere(startpoint, endpoint, occluder.position, occluder.radius))
      return 1;
  }

  return 0;
}

_id_6B8603FF55F4ED2C(_id_FD3CFE676991B240, attacker, _id_9CC7D33E2E2EBFEF, duration, _id_F106E72340798FFC, prioritygroup) {
  if(!isDefined(_id_9CC7D33E2E2EBFEF))
    _id_9CC7D33E2E2EBFEF = [attacker];

  if(!isDefined(duration))
    duration = 1000;
  else
    duration = duration * 1000;

  if(!isDefined(_id_F106E72340798FFC))
    _id_F106E72340798FFC = "snapshotgrenade";

  if(!isDefined(prioritygroup))
    prioritygroup = "equipment";

  _id_7AA1FF687CFC30D1 = undefined;
  _id_7AA1FF687CFC30D1 = spawnStruct();
  _id_7AA1FF687CFC30D1.owner = attacker;
  _id_7AA1FF687CFC30D1.isalive = 1;
  _id_7AA1FF687CFC30D1.targets = [];
  _id_7AA1FF687CFC30D1.endtimes = [];
  _id_7AA1FF687CFC30D1.outlineids = [];

  foreach(victim in _id_FD3CFE676991B240) {
    entnum = victim getentitynumber();
    _id_7AA1FF687CFC30D1.targets[entnum] = victim;
    _id_7AA1FF687CFC30D1.endtimes[entnum] = gettime() + duration;
    _id_7AA1FF687CFC30D1.outlineids[entnum] = scripts\mp\outline::outlineenableinternal(victim, _id_9CC7D33E2E2EBFEF, _id_F106E72340798FFC, prioritygroup, "ENTITY");
  }

  _id_7AA1FF687CFC30D1 thread _id_2F7892FD0B6B8251();
}

_id_2F7892FD0B6B8251() {
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

      if(!isDefined(target) || !scripts\mp\utility\player::isreallyalive(target) || gettime() >= endtime) {
        outlinedisable(outlineid, target);

        if(isDefined(target) && (isPlayer(target) || isbot(target)))
          target _hudoutlineviewmodeldisable();

        self.targets[id] = undefined;
        self.endtimes[id] = undefined;
        self.outlineids[id] = undefined;
      }
    }

    waitframe();
  }

  _id_357B6DF5A3D41E9C();
}

_id_357B6DF5A3D41E9C() {
  self notify("death");
  self.isalive = 0;

  foreach(id, target in self.targets) {
    target = self.targets[id];
    outlineid = self.outlineids[id];
    outlinedisable(outlineid, target);

    if(isDefined(target) && (isPlayer(target) || isbot(target)))
      target _hudoutlineviewmodeldisable();
  }
}

_hudoutlineviewmodeldisable() {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  self hudoutlineviewmodeldisable();
}

_hudoutlineviewmodelenable(hudoutlineassetname, _id_DAFD99B070FB282A) {
  if(!isDefined(_id_DAFD99B070FB282A))
    _id_DAFD99B070FB282A = 0;

  if(!isPlayer(self)) {
    return;
  }
  if(!_id_DAFD99B070FB282A && !scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(_id_DAFD99B070FB282A && !scripts\cp_mp\utility\player_utility::_isalive()) {
    thread hudoutlineviewmodelenableonnextspawn(hudoutlineassetname);
    return;
  }

  self hudoutlineviewmodelenable(hudoutlineassetname);
}

hudoutlineviewmodelenableonnextspawn(hudoutlineassetname) {
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