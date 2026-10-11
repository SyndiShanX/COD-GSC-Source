/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\anim\squadmanager.gsc
***********************************************/

#using scripts\anim\battlechatter_ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace squadmanager;

function createsquad(squadname, squadcreator) {
  assertex(!isDefined(anim.squads[squadname]), "createSquad attempted to create a squad with the same name as an existing squad");
  squad = spawnStruct();
  squad.squadname = squadname;
  anim.squads[squadname] = squad;
  squad.team = getsquadteam(squadcreator);
  squad.members = [];
  squad.squadlist = [];
  squad.cooldowntimes = [];
  squad.squadid = anim.squadindex.size;
  anim.squadindex[squad.squadid] = squad;
  level notify("squad created " + squadname);
  anim notify("squad created " + squadname);

  if(isDefined(anim.squadcreatefunc)) {
    squad thread[[anim.squadcreatefunc]]();
  }

  squad thread function_1e0a52e0fce5e432();

  return squad;
}

function deletesquad(squadname) {
  if(squadname == "axis" || squadname == "team3" || squadname == "allies" || squadname == "neutral") {
    return;
  }

  assertex(isDefined(anim.squads[squadname]), "deleteSquad attempted to delete a squad '" + squadname + "' that does not exist");
  squadid = anim.squads[squadname].squadid;
  squad = anim.squads[squadname];
  anim.squadindex[squadid] = anim.squadindex[anim.squadindex.size - 1];
  anim.squadindex[squadid].squadid = squadid;
  anim.squadindex[anim.squadindex.size - 1] = undefined;
  anim.squads[squadname] = undefined;
  anim notify("squad deleted " + squadname);
}

function getsquadteam(squadcreator) {
  if(isDefined(squadcreator.team)) {
    squadteam = squadcreator.team;
  } else {
    squadteam = "allies";
  }

  return squadteam;
}

function addtosquad(squadname) {
  assertex(issentient(self), "Attempted to add a non-sentient member to a squad");

  if(!isDefined(squadname)) {
    if(isDefined(self.script_squadname)) {
      squadname = self.script_squadname;
    } else {
      squadname = self.team;
    }
  }

  if(!isDefined(anim.squads[squadname])) {
    anim createsquad(squadname, self);
  }

  squad = anim.squads[squadname];

  if(isDefined(self.squad)) {
    if(self.squad == squad) {
      return;
    } else {
      removefromsquad(self.squad, self.squadid);
    }
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.starttime = gettime();
  squad.var_f54c29e2793a21fb = default_to(squad.var_f54c29e2793a21fb, 0);
  squadid = squad.var_f54c29e2793a21fb;
  squad.members[squadid] = self;
  squad.var_f54c29e2793a21fb++;
  self.squad = squad;
  self.squadid = squadid;
  thread scripts\anim\battlechatter_ai::addtosystem();
  thread memberdeathwaiter(squad, squadid);
}

function removefromsquad(squad, squadid) {
  if(!isDefined(squad)) {
    return;
  }

  assertex(isDefined(squadid), "entity squadID is undefined - cannot remove from squad");

  if(isDefined(self)) {
    assertex(squad.members.size != 0, "Trying to remove a member from an empty squad!");
    assertex(squad.members[squadid] == self, "Trying to remove a member from a squad but the entity doesn't match the member at this squadID!");
  } else {
    assertex(!isDefined(squad.members[squadid]), "Trying to remove a removed entity member from a squad but the index has an entity defined!");
  }

  squad.members[squadid] = undefined;

  if(isDefined(self)) {
    thread scripts\anim\battlechatter_ai::removefromsystem(squad);
  }

  if(squad.members.size == 0) {
    deletesquad(squad.squadname);
  }

  if(isDefined(self)) {
    self notify("removed from squad");
  }
}

function function_a5c82b8ba8a0c279(statement, true_value, false_value) {
  if(statement) {
    if(isfunction(true_value)) {
      return [[true_value]]();
    } else {
      return true_value;
    }
  }

  if(isfunction(false_value)) {
    return [[false_value]]();
  }

  return false_value;
}

function function_1cb4f2ef6b07869c() {
  start_index = randomint(self.members.size);

  for(i = 0; i < self.members.size; i++) {
    index = (start_index + i) % self.members.size;
    guy = self.members[index];

    if(!isalive(guy) || !isDefined(guy.enemy) || !guy.bisincombat) {}
  }

  return self.members[start_index];
}

function getenemyarray() {
  array = [];

  foreach(ai in getaiarray()) {
    if(isenemyteam(self.team, ai.team)) {
      array[array.size] = ai;
    }
  }

  return array;
}

function enemyisincover() {
  return isDefined(self.enemy) && isDefined(self.enemy.node) && isDefined(self.enemy.covernode);
}

function squadtracker() {
  anim endon("squad deleted " + self.squadname);
}

function memberdeathwaiter(squad, squadid) {
  self endon("removed from squad");
  self waittill("death", attacker);

  if(isDefined(self)) {
    self.attacker = attacker;
  }

  removefromsquad(squad, squadid);
}

function updateall() {
  neworigin = (0, 0, 0);
  newheading = (0, 0, 0);
  numinfluences = 0;
  curenemy = undefined;
  isincombat = 0;
  needheading = !isDefined(self.enemy);

  if(!needheading) {
    self.forward = vectorNormalize(self.enemy.origin - self.origin);
  }

  foreach(member in self.members) {
    if(!isalive(member)) {
      continue;
    }

    numinfluences++;
    neworigin += member.origin;

    if(needheading) {
      newheading += anglesToForward(member.angles);
    }

    if(istrue(member.bisincombat)) {
      isincombat = 1;
    }

    if(isDefined(member.enemy) && isDefined(member.enemy.squad)) {
      if(!isDefined(curenemy)) {
        curenemy = member.enemy.squad;
        continue;
      }

      if(member.enemy.squad.members.size > curenemy.members.size) {
        curenemy = member.enemy.squad;
      }
    }
  }

  if(numinfluences) {
    self.origin = neworigin / numinfluences;

    if(needheading) {
      self.forward = newheading / numinfluences;
    }
  } else {
    self.origin = undefined;

    if(needheading) {
      self.forward = undefined;
    }
  }

  self.isincombat = isincombat;
  self.enemy = curenemy;
}

function updatememberstates() {
  anim endon("squad deleted " + self.squadname);
}

function aiupdatecombat(timeslice) {
  if(!isDefined(self.combattime)) {
    return;
  }

  if(isDefined(self.lastenemysightpos)) {
    if(self.combattime < 0) {
      self.combattime = timeslice;
    } else {
      self.combattime += timeslice;
    }

    self.lastenemysighttime = gettime();
    return;
  } else if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    self.combattime += timeslice;
    return;
  }

  if(self.combattime > 0) {
    self.combattime = 0 - timeslice;
    return;
  }

  self.combattime -= timeslice;
}

function aiupdatesuppressed(timeslice) {
  if(!isDefined(self.suppressedtime)) {
    return;
  }

  if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    if(self.suppressedtime < 0) {
      self.suppressedtime = timeslice;
      return;
    }

    self.suppressedtime += timeslice;
    return;
  }

  if(self.suppressedtime > 0) {
    self.suppressedtime = 0 - timeslice;
    return;
  }

  self.suppressedtime -= timeslice;
}

function function_1e0a52e0fce5e432() {
  if(getdvarint(@ "hash_664a823c04104c0b") < 1) {
    return;
  }

  anim endon("<dev string:x1c>" + self.squadname);

  while(true) {
    wait 0.05;
    function_11287c170b69b7f2(self.origin, self.forward);

    foreach(member in self.members) {
      if(!isalive(member)) {
        continue;
      }

      line(self.origin, member.origin, (0.5, 0.5, 0.5));
    }
  }
}

function function_11287c170b69b7f2(pos, forward) {
  angles = vectortoangles(forward);
  range = 100;
  forward = anglesToForward(angles) * range;
  right = anglestoright(angles) * range;
  up = anglestoup(angles) * range;
  _draw_arrow(pos, pos + forward, (1, 0, 0));
  _draw_arrow(pos, pos + up, (0, 1, 0));
  _draw_arrow(pos, pos + right, (0, 0, 1));
}

function _draw_arrow(start, end, color) {
  angle = vectortoangles(end - start);
  dist = length(end - start);
  forward = anglesToForward(angle);
  forwardfar = forward * dist;
  arrow_size = 5;
  forwardclose = forward * (dist - arrow_size);
  right = anglestoright(angle);
  leftdraw = right * arrow_size * -1;
  rightdraw = right * arrow_size;
  line(start, end, color, 1, 0, 1);
  line(start, start + forwardfar, color, 1, 0, 1);
  line(start + forwardfar, start + forwardclose + rightdraw, color, 1, 0, 1);
  line(start + forwardfar, start + forwardclose + leftdraw, color, 1, 0, 1);
}

# /