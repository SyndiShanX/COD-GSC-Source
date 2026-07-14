/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\squadmanager.gsc
*****************************************/

#using scripts\anim\battlechatter_ai;
#namespace squadmanager;

function createsquad(squadname, squadcreator) {
  assert(!isDefined(anim.squads[squadname]), "<dev string:x24>");
  squad = spawnStruct();
  squad.squadname = squadname;
  anim.squads[squadname] = squad;
  squad.team = getsquadteam(squadcreator);
  squad.members = [];
  squad.squadlist = [];
  squad.cooldowntimes = [];
  squad.squadid = anim.squadindex.size;
  anim.squadindex[squad.squadid] = squad;
  level notify("7\x17\xba\xb02\b6'e\x85\x1d\xb2\x8c\x80" + squadname);
  anim notify("7\x17\xba\xb02\b6'e\x85\x1d\xb2\x8c\x80" + squadname);

  if(isDefined(anim.squadcreatefunc)) {
    squad thread[[anim.squadcreatefunc]]();
  }

  squad thread function_5267dbb0206e70fb();

  return squad;
}

function deletesquad(squadname) {
  if(squadname == "?\xb1\xc0\x9a" || squadname == "\x8c\x1b\xab)\xd1" || squadname == "O\x15\x1b\xad\x9ff" || squadname == "\xba\xa5\x1f\xc9m\x80i") {
    return;
  }

  assert(isDefined(anim.squads[squadname]), "<dev string:x77>" + squadname + "<dev string:xa4>");
  squadid = anim.squads[squadname].squadid;
  squad = anim.squads[squadname];
  anim.squadindex[squadid] = anim.squadindex[anim.squadindex.size - 1];
  anim.squadindex[squadid].squadid = squadid;
  anim.squadindex[anim.squadindex.size - 1] = undefined;
  anim.squads[squadname] = undefined;
  anim notify("\xfe\x85M\x85\x9aP\xea\xb2\x06\xca,}8}" + squadname);
}

function getsquadteam(squadcreator) {
  if(isDefined(squadcreator.team)) {
    squadteam = squadcreator.team;
  } else {
    squadteam = "O\x15\x1b\xad\x9ff";
  }

  return squadteam;
}

function addtosquad(squadname) {
  assert(issentient(self), "<dev string:xbd>");

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

  if(!isDefined(squad.var_2b7ceca89eb9e082)) {
    squad.var_2b7ceca89eb9e082 = 0;
  }

  squadid = squad.var_2b7ceca89eb9e082;
  squad.members[squadid] = self;
  squad.var_2b7ceca89eb9e082++;
  self.squad = squad;
  self.squadid = squadid;
  thread battlechatter_ai::addtosystem();
  thread memberdeathwaiter(squad, squadid);
}

function removefromsquad(squad, squadid) {
  if(!isDefined(squad)) {
    return;
  }

  assert(isDefined(squadid), "<dev string:xf2>");

  if(isDefined(self)) {
    assert(squad.members.size != 0, "<dev string:x12c>");
    assert(squad.members[squadid] == self, "<dev string:x15e>");
  } else {
    assert(!isDefined(squad.members[squadid]), "<dev string:x1c1>");
  }

  squad.members[squadid] = undefined;

  if(isDefined(self)) {
    thread battlechatter_ai::removefromsystem(squad);
  }

  if(squad.members.size == 0) {
    deletesquad(squad.squadname);
  }

  if(isDefined(self)) {
    self notify("\xc9\xac\xado\x9d\xca\x19\x10\x99N\xf6\xd6\x04\xdc\xb8u\v2");
  }
}

function function_b60b3e510557b150(var_b23c348a80a27047, true_value, false_value) {
  if(var_b23c348a80a27047) {
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

function function_a129f273fbd2c479() {
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
  return isDefined(self.enemy.node) && isDefined(self.enemy) && isDefined(self.enemy.covernode);
}

function squadtracker() {
  anim endon("\xfe\x85M\x85\x9aP\xea\xb2\x06\xca,}8}" + self.squadname);
}

function memberdeathwaiter(squad, squadid) {
  self endon("\xc9\xac\xado\x9d\xca\x19\x10\x99N\xf6\xd6\x04\xdc\xb8u\v2");
  self waittill("\x1e\xfd\xd1\xa2\a", attacker);

  if(isDefined(self)) {
    self.attacker = attacker;
  }

  removefromsquad(squad, squadid);
}

function updateall() {
  neworigin = (0, 0, 0);
  newheading = (0, 0, 0);
  var_a40e15752ccfb806 = 0;
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

    var_a40e15752ccfb806++;
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

  if(var_a40e15752ccfb806) {
    self.origin = neworigin / var_a40e15752ccfb806;

    if(needheading) {
      self.forward = newheading / var_a40e15752ccfb806;
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
  anim endon("\xfe\x85M\x85\x9aP\xea\xb2\x06\xca,}8}" + self.squadname);
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
  } else if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "\xae51W\xac]" && self issuppressed()) {
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

  if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "\xae51W\xac]" && self issuppressed()) {
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

function function_5267dbb0206e70fb() {
  if(getdvarint(@ "debug_squadmanager") < 1) {
    return;
  }

  anim endon("<dev string:x21f>" + self.squadname);

  while(true) {
    wait 0.05;
    function_37ae80d8b14274c3(self.origin, self.forward);

    foreach(member in self.members) {
      if(!isalive(member)) {
        continue;
      }

      line(self.origin, member.origin, (0.5, 0.5, 0.5));
    }
  }
}

function function_37ae80d8b14274c3(pos, forward) {
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