/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\squadmanager.gsc
***********************************************/

createsquad(squadname, _id_5346A21915702367) {
  squad = spawnStruct();
  squad.squadname = squadname;
  anim.squads[squadname] = squad;
  squad.team = getsquadteam(_id_5346A21915702367);
  squad.members = [];
  squad.squadlist = [];
  squad._id_0010D358F42E97EA = [];
  squad.squadid = anim.squadindex.size;
  anim.squadindex[squad.squadid] = squad;
  level notify("squad created " + squadname);
  anim notify("squad created " + squadname);

  if(isDefined(anim._id_417D31A4284FD63F))
    squad thread[[anim._id_417D31A4284FD63F]]();

  return squad;
}

deletesquad(squadname) {
  if(squadname == "axis" || squadname == "team3" || squadname == "allies" || squadname == "neutral") {
    return;
  }
  squadid = anim.squads[squadname].squadid;
  squad = anim.squads[squadname];
  anim.squadindex[squadid] = anim.squadindex[anim.squadindex.size - 1];
  anim.squadindex[squadid].squadid = squadid;
  anim.squadindex[anim.squadindex.size - 1] = undefined;
  anim.squads[squadname] = undefined;
  anim notify("squad deleted " + squadname);
}

getsquadteam(_id_5346A21915702367) {
  if(isDefined(_id_5346A21915702367.team))
    _id_BA212ECE21791E5C = _id_5346A21915702367.team;
  else
    _id_BA212ECE21791E5C = "allies";

  return _id_BA212ECE21791E5C;
}

addtosquad(squadname) {
  if(!isDefined(squadname)) {
    if(isDefined(self.script_squadname))
      squadname = self.script_squadname;
    else
      squadname = self.team;
  }

  if(!isDefined(anim.squads[squadname]))
    anim createsquad(squadname, self);

  squad = anim.squads[squadname];

  if(isDefined(self.squad)) {
    if(self.squad == squad)
      return;
    else
      removefromsquad(self.squad);
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.starttime = gettime();
  _id_9DA2D14FE5BB01CC = squad.members.size;
  self.squad = squad;
  squad.members[_id_9DA2D14FE5BB01CC] = self;
  thread _id_0F4E8D02D2F70888::addtosystem();
  _id_D593DF307AA2C457(_id_9DA2D14FE5BB01CC);
}

_id_D593DF307AA2C457(index) {
  self notify("squad index changed");
  thread memberdeathwaiter(self.squad, index);
}

removefromsquad(squad, index) {
  if(!isDefined(squad)) {
    return;
  }
  if(index != squad.members.size - 1) {
    other = squad.members[squad.members.size - 1];
    squad.members[index] = other;

    if(isDefined(other))
      other thread _id_D593DF307AA2C457(index);
  }

  squad.members[squad.members.size - 1] = undefined;
  thread _id_0F4E8D02D2F70888::removefromsystem(squad);

  if(squad.members.size == 0)
    deletesquad(squad.squadname);

  if(isDefined(self))
    self notify("removed from squad");
}

_id_A5C82B8BA8A0C279(_id_9CB951DE1A571D32, _id_F901CA059B18A27B, _id_A4136D44AE0EF2DE) {
  if(_id_9CB951DE1A571D32) {
    if(isfunction(_id_F901CA059B18A27B))
      return [[_id_F901CA059B18A27B]]();
    else
      return _id_F901CA059B18A27B;
  }

  if(isfunction(_id_A4136D44AE0EF2DE))
    return [[_id_A4136D44AE0EF2DE]]();
  else
    return _id_A4136D44AE0EF2DE;
}

_id_1CB4F2EF6B07869C() {
  _id_2F05FDC372F83530 = randomint(self.members.size);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.members.size; _id_AC0E594AC96AA3A8++) {
    index = (_id_2F05FDC372F83530 + _id_AC0E594AC96AA3A8) % self.members.size;
    guy = self.members[index];

    if(!isalive(guy) || !isDefined(guy.enemy) || !guy.bisincombat)
      continue;
  }

  return self.members[_id_2F05FDC372F83530];
}

_id_4E6E09A47E502152() {
  array = [];

  foreach(ai in getaiarray()) {
    if(isenemyteam(self.team, ai.team))
      array[array.size] = ai;
  }

  return array;
}

_id_48706811C593324B() {
  return isDefined(self.enemy) && isDefined(self.enemy.node) && isDefined(self.enemy.covernode);
}

squadtracker() {
  anim endon("squad deleted " + self.squadname);
}

memberdeathwaiter(squad, index) {
  self endon("removed from squad");
  self endon("squad index changed");
  self waittill("death", attacker);

  if(isDefined(self))
    self.attacker = attacker;

  removefromsquad(squad, index);
}

updateall() {
  _id_A9706ADAF7C52E27 = (0, 0, 0);
  _id_217B7BEE279E546D = (0, 0, 0);
  _id_8BF9F8D903167B37 = 0;
  _id_0EA3B9998985B96F = undefined;
  isincombat = 0;
  _id_D835C6CAD3821C61 = !isDefined(self.enemy);

  if(!_id_D835C6CAD3821C61)
    self.forward = vectorNormalize(self.enemy.origin - self.origin);

  foreach(_id_80EF668C09FFB70F in self.members) {
    if(!isalive(_id_80EF668C09FFB70F)) {
      continue;
    }
    _id_8BF9F8D903167B37++;
    _id_A9706ADAF7C52E27 = _id_A9706ADAF7C52E27 + _id_80EF668C09FFB70F.origin;

    if(_id_D835C6CAD3821C61)
      _id_217B7BEE279E546D = _id_217B7BEE279E546D + anglesToForward(_id_80EF668C09FFB70F.angles);

    if(istrue(_id_80EF668C09FFB70F.bisincombat))
      isincombat = 1;

    if(isDefined(_id_80EF668C09FFB70F.enemy) && isDefined(_id_80EF668C09FFB70F.enemy.squad)) {
      if(!isDefined(_id_0EA3B9998985B96F)) {
        _id_0EA3B9998985B96F = _id_80EF668C09FFB70F.enemy.squad;
        continue;
      }

      if(_id_80EF668C09FFB70F.enemy.squad.members.size > _id_0EA3B9998985B96F.members.size)
        _id_0EA3B9998985B96F = _id_80EF668C09FFB70F.enemy.squad;
    }
  }

  if(_id_8BF9F8D903167B37) {
    self.origin = _id_A9706ADAF7C52E27 / _id_8BF9F8D903167B37;

    if(_id_D835C6CAD3821C61)
      self.forward = _id_217B7BEE279E546D / _id_8BF9F8D903167B37;
  } else {
    self.origin = undefined;

    if(_id_D835C6CAD3821C61)
      self.forward = undefined;
  }

  self.isincombat = isincombat;
  self.enemy = _id_0EA3B9998985B96F;
}

updatememberstates() {
  anim endon("squad deleted " + self.squadname);
}

aiupdatecombat(_id_BC08E2B32A09AB5A) {
  if(!isDefined(self.combattime)) {
    return;
  }
  if(isDefined(self.lastenemysightpos)) {
    if(self.combattime < 0)
      self.combattime = _id_BC08E2B32A09AB5A;
    else
      self.combattime = self.combattime + _id_BC08E2B32A09AB5A;

    self.lastenemysighttime = gettime();
    return;
  } else if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    self.combattime = self.combattime + _id_BC08E2B32A09AB5A;
    return;
  }

  if(self.combattime > 0)
    self.combattime = 0 - _id_BC08E2B32A09AB5A;
  else
    self.combattime = self.combattime - _id_BC08E2B32A09AB5A;
}

aiupdatesuppressed(_id_BC08E2B32A09AB5A) {
  if(!isDefined(self.suppressedtime)) {
    return;
  }
  if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    if(self.suppressedtime < 0)
      self.suppressedtime = _id_BC08E2B32A09AB5A;
    else
      self.suppressedtime = self.suppressedtime + _id_BC08E2B32A09AB5A;
  } else {
    if(self.suppressedtime > 0) {
      self.suppressedtime = 0 - _id_BC08E2B32A09AB5A;
      return;
    }

    self.suppressedtime = self.suppressedtime - _id_BC08E2B32A09AB5A;
  }
}