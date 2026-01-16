/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\squadmanager.gsc
****************************************/

init_squadmanager() {
  if(isdefined(anim.squadinitialized) && anim.squadinitialized) {
    return;
  }
  anim.squadcreatefuncs = [];
  anim.squadcreatestrings = [];
  anim.squads = [];
  anim.squadindex = [];
  anim.squadrand = 0;
  anim.squadinitialized = 1;
  maps\_utility::set_console_status();
}

createsquad(var_0, var_1) {
  anim.squads[var_0] = spawnstruct();
  var_2 = anim.squads[var_0];
  var_2.squadname = var_0;
  var_2.team = getsquadteam(var_1);
  var_2.sighttime = 0;
  var_2.origin = undefined;
  var_2.forward = undefined;
  var_2.enemy = undefined;
  var_2.isincombat = 0;
  var_2.membercount = 0;
  var_2.members = [];
  var_2.officers = [];
  var_2.officercount = 0;
  var_2.squadlist = [];
  var_2.memberaddfuncs = [];
  var_2.memberaddstrings = [];
  var_2.memberremovefuncs = [];
  var_2.memberremovestrings = [];
  var_2.squadupdatefuncs = [];
  var_2.squadupdatestrings = [];
  var_2.squadid = anim.squadindex.size;
  var_2 initstate("combat", 0.75);
  var_2 initstate("cover", 0.75);
  var_2 initstate("move", 0.75);
  var_2 initstate("stop", 0.75);
  var_2 initstate("death", 0.75);
  var_2 initstate("suppressed", 0.75);
  var_2 initstate("attacking", 0.5);
  anim.squadindex[anim.squadindex.size] = var_2;
  var_2 updatesquadlist();
  level notify("squad created " + var_0);
  anim notify("squad created " + var_0);

  for (var_3 = 0; var_3 < anim.squadcreatefuncs.size; var_3++) {
    var_4 = anim.squadcreatefuncs[var_3];
    var_2 thread[[var_4]]();
  }

  for (var_3 = 0; var_3 < anim.squadindex.size; var_3++)
    anim.squadindex[var_3] updatesquadlist();

  var_2 thread updatewaiter();
  var_2 thread squadtracker();
  var_2 thread officerwaiter();
  var_2 thread updatememberstates();
  return var_2;
}

deletesquad(var_0) {
  if(var_0 == "axis" || var_0 == "team3" || var_0 == "allies") {
    return;
  }
  var_1 = anim.squads[var_0].squadid;
  var_2 = anim.squads[var_0];
  var_2 notify("squad_deleting");

  while (var_2.members.size)
    var_2.members[0] addtosquad(var_2.members[0].team);

  anim.squadindex[var_1] = anim.squadindex[anim.squadindex.size - 1];
  anim.squadindex[var_1].squadid = var_1;
  anim.squadindex[anim.squadindex.size - 1] = undefined;
  anim.squads[var_0] = undefined;
  level notify("squad deleted " + var_0);
  anim notify("squad deleted " + var_0);

  for (var_3 = 0; var_3 < anim.squadindex.size; var_3++)
    anim.squadindex[var_3] updatesquadlist();
}

generatesquadname() {
  var_0 = "auto" + anim.squadrand;
  anim.squadrand++;
  return var_0;
}

addplayertosquad(var_0) {
  if(!isdefined(var_0)) {
    if(isdefined(self.script_squadname))
      var_0 = self.script_squadname;
    else
      var_0 = self.team;
  }

  if(!isdefined(anim.squads[var_0]))
    anim createsquad(var_0, self);

  var_1 = anim.squads[var_0];
  self.squad = var_1;
}

squadchange() {
  self endon("death");
  wait 10.0;

  if(!isdefined(self.script_squadname))
    var_0 = self.team + self.script_flanker;
  else
    var_0 = self.script_squadname + self.script_flanker;

  addtosquad(var_0);
}

getsquadteam(var_0) {
  var_1 = "allies";

  if(var_0.team == "axis" || var_0.team == "neutral" || var_0.team == "team3")
    var_1 = var_0.team;

  return var_1;
}

addtosquad(var_0) {
  if(!isdefined(var_0)) {
    if(isdefined(self.script_flanker))
      thread squadchange();

    if(isdefined(self.script_squadname))
      var_0 = self.script_squadname;
    else
      var_0 = self.team;
  }

  if(!isdefined(anim.squads[var_0]))
    anim createsquad(var_0, self);

  var_1 = anim.squads[var_0];

  if(isdefined(self.squad)) {
    if(self.squad == var_1)
      return;
    else
      removefromsquad();
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.squad = var_1;
  self.memberid = var_1.members.size;
  var_1.members[self.memberid] = self;
  var_1.membercount = var_1.members.size;

  if(isdefined(level.loadoutcomplete)) {
    if(self.team == "allies" && animscripts\battlechatter::isofficer())
      addofficertosquad();
  }

  for (var_2 = 0; var_2 < self.squad.memberaddfuncs.size; var_2++) {
    var_3 = self.squad.memberaddfuncs[var_2];
    self thread[[var_3]](self.squad.squadname);
  }

  thread membercombatwaiter();
  thread memberdeathwaiter();
}

removefromsquad() {
  var_0 = self.squad;
  var_1 = -1;

  if(isdefined(self))
    var_1 = self.memberid;
  else {
    for (var_2 = 0; var_2 < var_0.members.size; var_2++) {
      if(var_0.members[var_2] == self)
        var_1 = var_2;
    }
  }

  if(var_1 != var_0.members.size - 1) {
    var_3 = var_0.members[var_0.members.size - 1];
    var_0.members[var_1] = var_3;

    if(isdefined(var_3))
      var_3.memberid = var_1;
  }

  var_0.members[var_0.members.size - 1] = undefined;
  var_0.membercount = var_0.members.size;

  if(isdefined(self.officerid))
    removeofficerfromsquad();

  for (var_2 = 0; var_2 < self.squad.memberremovefuncs.size; var_2++) {
    var_4 = self.squad.memberremovefuncs[var_2];
    self thread[[var_4]](var_0.squadname);
  }

  if(var_0.membercount == 0)
    deletesquad(var_0.squadname);

  if(isdefined(self)) {
    self.squad = undefined;
    self.memberid = undefined;
  }

  self notify("removed from squad");
}

addofficertosquad() {
  var_0 = self.squad;

  if(isdefined(self.officerid)) {
    return;
  }
  self.officerid = var_0.officers.size;
  var_0.officers[self.officerid] = self;
  var_0.officercount = var_0.officers.size;
}

removeofficerfromsquad() {
  var_0 = self.squad;
  var_1 = -1;

  if(isdefined(self))
    var_1 = self.officerid;
  else {
    for (var_2 = 0; var_2 < var_0.officers.size; var_2++) {
      if(var_0.officers[var_2] == self)
        var_1 = var_2;
    }
  }

  if(var_1 != var_0.officers.size - 1) {
    var_3 = var_0.officers[var_0.officers.size - 1];
    var_0.officers[var_1] = var_3;

    if(isdefined(var_3))
      var_3.officerid = var_1;
  }

  var_0.officers[var_0.officers.size - 1] = undefined;
  var_0.officercount = var_0.officers.size;

  if(isdefined(self))
    self.officerid = undefined;
}

officerwaiter() {
  if(!isdefined(level.loadoutcomplete))
    anim waittill("loadout complete");

  for (var_0 = 0; var_0 < self.members.size; var_0++) {
    if(self.members[var_0] animscripts\battlechatter::isofficer())
      self.members[var_0] addofficertosquad();
  }
}

updatewaiter() {
  for (;;) {
    anim waittill("squadupdate", var_0);

    switch (var_0) {
      case "squadlist":
        updatesquadlist();
        break;
      case "combat":
        updatecombat();
        break;
      case "origin":
        updateorigin();
        break;
      case "forward":
        updateheading();
        break;
    }
  }
}

squadtracker() {
  anim endon("squad deleted " + self.squadname);
  var_0 = 0.1;

  if(level.currentgen)
    var_0 = 0.5;

  for (;;) {
    updateall();
    wait(var_0);
  }
}

memberdeathwaiter() {
  self endon("removed from squad");
  self waittill("death", var_0);

  if(isdefined(self))
    self.attacker = var_0;

  removefromsquad();
}

membercombatwaiter() {
  self endon("removed from squad");

  for (;;) {
    self waittill("enemy");

    if(!isdefined(self.enemy))
      self.squad notify("squadupdate", "combat");
    else
      self.squad.isincombat = 1;

    wait 0.05;
  }
}

updateheading() {
  if(isdefined(self.enemy))
    self.forward = vectornormalize(self.enemy.origin - self.origin);
  else {
    var_0 = (0, 0, 0);
    var_1 = 0;

    for (var_2 = 0; var_2 < self.members.size; var_2++) {
      if(!isalive(self.members[var_2])) {
        continue;
      }
      var_0 = var_0 + anglestoforward(self.members[var_2].angles);
      var_1++;
    }

    if(var_1) {
      self.forward = (var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1);
      return;
    }

    self.forward = var_0;
  }
}

updateorigin() {
  var_0 = (0, 0, 0);
  var_1 = 0;

  for (var_2 = 0; var_2 < self.members.size; var_2++) {
    if(!isalive(self.members[var_2])) {
      continue;
    }
    var_0 = var_0 + self.members[var_2].origin;
    var_1++;
  }

  if(var_1)
    self.origin = (var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1);
  else
    self.origin = var_0;
}

updatecombat() {
  self.isincombat = 0;

  for (var_0 = 0; var_0 < anim.squadindex.size; var_0++)
    self.squadlist[anim.squadindex[var_0].squadname].isincontact = 0;

  for (var_0 = 0; var_0 < self.members.size; var_0++) {
    if(isdefined(self.members[var_0].enemy) && isdefined(self.members[var_0].enemy.squad) && self.members[var_0].combattime > 0)
      self.squadlist[self.members[var_0].enemy.squad.squadname].isincontact = 1;
  }
}

updateenemy() {
  var_0 = undefined;

  for (var_1 = 0; var_1 < self.members.size; var_1++) {
    if(isdefined(self.members[var_1].enemy) && isdefined(self.members[var_1].enemy.squad)) {
      if(!isdefined(var_0)) {
        var_0 = self.members[var_1].enemy.squad;
        continue;
      }

      if(self.members[var_1].enemy.squad.membercount > var_0.membercount)
        var_0 = self.members[var_1].enemy.squad;
    }
  }

  self.enemy = var_0;
}

updateall() {
  var_0 = (0, 0, 0);
  var_1 = 0;
  var_2 = undefined;
  var_3 = 0;
  updatecombat();

  for (var_4 = 0; var_4 < self.members.size; var_4++) {
    if(!isalive(self.members[var_4])) {
      continue;
    }
    var_0 = var_0 + self.members[var_4].origin;
    var_1++;

    if(isdefined(self.members[var_4].enemy) && isdefined(self.members[var_4].enemy.squad)) {
      if(!isdefined(var_2)) {
        var_2 = self.members[var_4].enemy.squad;
        continue;
      }

      if(self.members[var_4].enemy.squad.membercount > var_2.membercount)
        var_2 = self.members[var_4].enemy.squad;
    }
  }

  if(var_1)
    self.origin = (var_0[0] / var_1, var_0[1] / var_1, var_0[2] / var_1);
  else
    self.origin = var_0;

  self.isincombat = var_3;
  self.enemy = var_2;
  updateheading();
}

updatesquadlist() {
  for (var_0 = 0; var_0 < anim.squadindex.size; var_0++) {
    if(!isdefined(self.squadlist[anim.squadindex[var_0].squadname])) {
      self.squadlist[anim.squadindex[var_0].squadname] = spawnstruct();
      self.squadlist[anim.squadindex[var_0].squadname].isincontact = 0;
    }

    for (var_1 = 0; var_1 < self.squadupdatefuncs.size; var_1++) {
      var_2 = self.squadupdatefuncs[var_1];
      self thread[[var_2]](anim.squadindex[var_0].squadname);
    }
  }
}

printabovehead(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isdefined(var_2))
    var_2 = (0, 0, 0);

  if(!isdefined(var_3))
    var_3 = (1, 0, 0);

  for (var_4 = 0; var_4 < var_1 * 2; var_4++) {
    if(!isalive(self)) {
      return;
    }
    var_5 = self getshootatpos() + (0, 0, 10) + var_2;
    wait 0.05;
  }
}

aiupdateanimstate(var_0) {
  switch (var_0) {
    case "combat":
    case "death":
    case "move":
    case "stop":
      self.a.state = var_0;
      break;
    case "grenadecower":
    case "pain":
      break;
    case "stalingrad_cover_crouch":
    case "concealment_stand":
    case "concealment_prone":
    case "concealment_crouch":
    case "cover_wide_right":
    case "cover_wide_left":
    case "cover_swim_up":
    case "cover_swim_right":
    case "cover_swim_left":
    case "cover_multi":
    case "cover_prone":
    case "cover_right":
    case "cover_left":
    case "cover_stand":
    case "cover_crouch":
      self.a.state = "cover";
      break;
    case "l33t truckride combat":
    case "aim":
      self.a.state = "combat";
      break;
  }
}

updatestates() {
  resetstate("combat");
  resetstate("cover");
  resetstate("move");
  resetstate("stop");
  resetstate("death");
  resetstate("suppressed");
  resetstate("attacking");

  for (var_0 = 0; var_0 < self.members.size; var_0++) {
    if(!isalive(self.members[var_0])) {
      continue;
    }
    querymemberanimstate(self.members[var_0]);
    querymemberstate(self.members[var_0], "suppressed");
    querymemberstate(self.members[var_0], "combat");
    querymemberstate(self.members[var_0], "attacking");
    querymemberstate(self.members[var_0], "cover");
  }
}

updatememberstates() {
  anim endon("squad deleted " + self.squadname);
  var_0 = 0.05;

  if(level.currentgen)
    var_0 = 0.25;

  for (;;) {
    for (var_1 = 0; var_1 < self.members.size; var_1++) {
      if(!isalive(self.members[var_1])) {
        continue;
      }
      self.members[var_1] aiupdatecombat(var_0);
      self.members[var_1] aiupdatesuppressed(var_0);
    }

    wait(var_0);
  }
}

aiupdatecombat(var_0) {
  if(isdefined(self.lastenemysightpos)) {
    if(self.combattime < 0)
      self.combattime = var_0;
    else
      self.combattime = self.combattime + var_0;

    self.lastenemysighttime = gettime();
    return;
  } else if(self issuppressed()) {
    self.combattime = self.combattime + var_0;
    return;
  }

  if(self.combattime > 0)
    self.combattime = 0 - var_0;
  else
    self.combattime = self.combattime - var_0;
}

aiupdatesuppressed(var_0) {
  if(self.suppressed) {
    if(self.suppressedtime < 0)
      self.suppressedtime = var_0;
    else
      self.suppressedtime = self.suppressedtime + var_0;
  } else {
    if(self.suppressedtime > 0) {
      self.suppressedtime = 0 - var_0;
      return;
    }

    self.suppressedtime = self.suppressedtime - var_0;
  }
}

initstate(var_0, var_1) {
  self.squadstates[var_0] = spawnstruct();
  self.squadstates[var_0].activateratio = var_1;
  self.squadstates[var_0].isactive = 0;
  self.squadstates[var_0].numactive = 0;
}

resetstate(var_0) {
  self.squadstates[var_0].isactive = 0;
  self.squadstates[var_0].numactive = 0;
}

querymemberanimstate(var_0) {
  self.squadstates[var_0.a.state].numactive++;

  if(self.squadstates[var_0.a.state].numactive > self.squadstates[var_0.a.state].activateratio * self.members.size)
    self.squadstates[var_0.a.state].isactive = 1;
}

querymemberstate(var_0, var_1) {
  switch (var_1) {
    case "suppressed":
      if(var_0.suppressedtime > 1.0)
        self.squadstates[var_1].numactive++;

      break;
    case "combat":
      if(var_0.combattime > 0.0)
        self.squadstates[var_1].numactive++;

      break;
    case "attacking":
      if(gettime() < var_0.a.lastshoottime + 2000)
        self.squadstates[var_1].numactive++;

      break;
    case "cover":
      if(!var_0 animscripts\battlechatter::isexposed())
        self.squadstates[var_1].numactive++;

      break;
  }

  if(self.squadstates[var_1].numactive > self.squadstates[var_1].activateratio * self.members.size)
    self.squadstates[var_1].isactive = 1;
}