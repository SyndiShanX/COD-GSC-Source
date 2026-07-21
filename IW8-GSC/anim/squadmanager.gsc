/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\squadmanager.gsc
***********************************************/

createsquad(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.squadname = var_0;
  anim.squads[var_0] = var_2;
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
  anim.squadindex[anim.squadindex.size] = var_2;
  var_2 updatesquadlist();
  level notify("squad created " + var_0);
  anim notify("squad created " + var_0);

  for(var_3 = 0; var_3 < anim.squadcreatefuncs.size; var_3++) {
    var_4 = anim.squadcreatefuncs[var_3];
    var_2 thread[[var_4]]();
  }

  for(var_3 = 0; var_3 < anim.squadindex.size; var_3++)
    anim.squadindex[var_3] updatesquadlist();

  var_2 thread squadtracker();
  var_2 thread officerwaiter();
  var_2 thread updatememberstates();
  return var_2;
}

deletesquad(var_0) {
  if(var_0 == "axis" || var_0 == "team3" || var_0 == "allies" || var_0 == "jackal_allies" || var_0 == "jackal_axis") {
    return;
  }
  var_1 = anim.squads[var_0].squadid;
  var_2 = anim.squads[var_0];
  var_2 notify("squad_deleting");

  while(var_2.members.size)
    var_2.members[0] addtosquad(var_2.members[0].team);

  anim.squadindex[var_1] = anim.squadindex[anim.squadindex.size - 1];
  anim.squadindex[var_1].squadid = var_1;
  anim.squadindex[anim.squadindex.size - 1] = undefined;
  anim.squads[var_0] = undefined;
  anim notify("squad deleted " + var_0);

  for(var_3 = 0; var_3 < anim.squadindex.size; var_3++)
    anim.squadindex[var_3] updatesquadlist();
}

addplayertosquad(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.script_squadname))
      var_0 = self.script_squadname;
    else
      var_0 = self.team;
  }

  if(!isDefined(anim.squads[var_0]))
    anim createsquad(var_0, self);

  var_1 = anim.squads[var_0];
  var_2 = 0;

  if(isDefined(var_1.members)) {
    foreach(var_4 in var_1.members) {
      if(var_4 != anim.player)
        continue;
      else {
        var_2 = 1;
        break;
      }
    }

    if(!var_2)
      var_1.members[var_1.members.size] = self;
  }

  self.squad = var_1;
}

playeranimnameswitch() {
  var_0 = getEntArray("player", "classname")[0];
  scripts\sp\player\playerchatter::player_update_allowed_callouts();

  if(scripts\engine\utility::player_is_in_jackal()) {
    anim.player = level.player_jackal;

    if(!isDefined(anim.player.team))
      anim.player.team = "allies";

    anim.eventactionminwait["threat"]["self"] = 11000;
    anim.eventactionminwait["threat"]["squad"] = 7000;
    level.bcs_maxthreatdistsqrdfromplayer = squared(9999999);
    level.bcs_maxtalkingdistsqrdfromplayer = squared(9999999);
    level.bcs_maxstealthdistsqrdfromplayer = squared(9999999);
    anim.teamthreatcalloutlimittimeout = 300000;
    anim.fbt_desireddistmax = 9999999;
    anim.fbt_waitmin = 2;
    anim.fbt_waitmax = 5;
    anim.fbt_linebreakmin = 0.5;
    anim.fbt_linebreakmax = 3;
    anim.player addplayertosquad("jackal_allies");

    for(var_1 = 0; var_1 < anim.squadindex.size; var_1++) {
      anim.squadindex[var_1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var_1].members);
      anim.squadindex[var_1] updatesquadlist();
    }

    scripts\sp\player\playerchatter::init_playerchatter();

    while(scripts\engine\utility::player_is_in_jackal())
      wait 0.05;
  } else {
    anim.player = var_0;

    if(!isDefined(anim.player.team))
      anim.player.team = "allies";

    scripts\sp\player\playerchatter::player_update_allowed_callouts();
    anim.eventactionminwait["threat"]["self"] = 9000;
    anim.eventactionminwait["threat"]["squad"] = 5000;
    level.bcs_maxthreatdistsqrdfromplayer = squared(5000);
    level.bcs_maxtalkingdistsqrdfromplayer = squared(3000);
    level.bcs_maxstealthdistsqrdfromplayer = squared(1500);
    anim.teamthreatcalloutlimittimeout = 120000;
    anim.fbt_desireddistmax = 620;
    anim.fbt_waitmin = 12;
    anim.fbt_waitmax = 24;
    anim.fbt_linebreakmin = 2;
    anim.fbt_linebreakmax = 5;
    anim.player addplayertosquad("allies");

    for(var_1 = 0; var_1 < anim.squadindex.size; var_1++) {
      anim.squadindex[var_1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var_1].members);
      anim.squadindex[var_1] updatesquadlist();
    }

    scripts\sp\player\playerchatter::init_playerchatter();

    while(!scripts\engine\utility::player_is_in_jackal())
      wait 0.05;
  }

  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      var_2 = [];

      foreach(var_4 in anim.squads["allies"].members) {
        if(var_4 != level.player)
          var_2[var_2.size] = var_4;
      }

      anim.squads["allies"].members = var_2;
      anim.player = level.player_jackal;

      if(!isDefined(anim.player.team))
        anim.player.team = "allies";

      scripts\sp\player\playerchatter::player_update_allowed_callouts();
      anim.eventactionminwait["threat"]["self"] = 11000;
      anim.eventactionminwait["threat"]["squad"] = 7000;
      level.bcs_maxthreatdistsqrdfromplayer = squared(9999999);
      level.bcs_maxtalkingdistsqrdfromplayer = squared(9999999);
      level.bcs_maxstealthdistsqrdfromplayer = squared(9999999);
      anim.teamthreatcalloutlimittimeout = 300000;
      anim.fbt_desireddistmax = 9999999;
      anim.fbt_waitmin = 2;
      anim.fbt_waitmax = 5;
      anim.fbt_linebreakmin = 0.5;
      anim.fbt_linebreakmax = 3;
      anim.player addplayertosquad("jackal_allies");

      for(var_1 = 0; var_1 < anim.squadindex.size; var_1++) {
        anim.squadindex[var_1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var_1].members);
        anim.squadindex[var_1] updatesquadlist();
      }

      scripts\sp\player\playerchatter::init_playerchatter();

      while(scripts\engine\utility::player_is_in_jackal())
        wait 0.05;

      continue;
    }

    var_2 = [];

    foreach(var_4 in anim.squads["allies"].members) {
      if(!isDefined(level.player_jackal) || isDefined(level.player_jackal) && var_4 != level.player_jackal)
        var_2[var_2.size] = var_4;
    }

    anim.squads["allies"].members = var_2;
    anim.player = var_0;

    if(!isDefined(anim.player.team))
      anim.player.team = "allies";

    scripts\sp\player\playerchatter::player_update_allowed_callouts();
    anim.eventactionminwait["threat"]["self"] = 9000;
    anim.eventactionminwait["threat"]["squad"] = 5000;
    level.bcs_maxthreatdistsqrdfromplayer = squared(5000);
    level.bcs_maxtalkingdistsqrdfromplayer = squared(3000);
    level.bcs_maxstealthdistsqrdfromplayer = squared(1500);
    anim.teamthreatcalloutlimittimeout = 120000;
    anim.fbt_desireddistmax = 620;
    anim.fbt_waitmin = 12;
    anim.fbt_waitmax = 24;
    anim.fbt_linebreakmin = 2;
    anim.fbt_linebreakmax = 5;
    anim.player addplayertosquad("allies");

    for(var_1 = 0; var_1 < anim.squadindex.size; var_1++) {
      anim.squadindex[var_1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var_1].members);
      anim.squadindex[var_1] updatesquadlist();
    }

    scripts\sp\player\playerchatter::init_playerchatter();

    while(!scripts\engine\utility::player_is_in_jackal())
      wait 0.05;
  }
}

getsquadteam(var_0) {
  var_1 = "allies";

  if(isDefined(level.template_script) && level.template_script == "phparade")
    var_0.team = "allies";

  if(var_0.team == "axis" || var_0.team == "neutral" || var_0.team == "team3")
    var_1 = var_0.team;

  return var_1;
}

addtosquad(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.script_squadname))
      var_0 = self.script_squadname;
    else
      var_0 = self.team;

    if(isDefined(self.bcs_jackal) && self.bcs_jackal)
      var_0 = "jackal_" + self.script_team;
  }

  if(!isDefined(anim.squads[var_0]))
    anim createsquad(var_0, self);

  var_1 = anim.squads[var_0];

  if(isDefined(self.squad)) {
    if(self.squad == var_1)
      return;
    else
      removefromsquad();
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.starttime = gettime();
  self.squad = var_1;
  self.squadmemberid = var_1.members.size;
  var_1.members[self.squadmemberid] = self;
  var_1.membercount = var_1.members.size;

  if(isDefined(level.loadoutcomplete)) {
    if(self.team == "allies" && scripts\anim\battlechatter.gsc::isofficer())
      addofficertosquad();
  }

  foreach(var_3 in self.squad.memberaddfuncs)
  self thread[[var_3]](self.squad.squadname);

  thread memberdeathwaiter();
}

removefromsquad() {
  var_0 = self.squad;
  var_1 = -1;

  if(isDefined(self))
    var_1 = self.squadmemberid;
  else {
    for(var_2 = 0; var_2 < var_0.members.size; var_2++) {
      if(var_0.members[var_2] == self)
        var_1 = var_2;
    }
  }

  if(var_1 != var_0.members.size - 1) {
    var_3 = var_0.members[var_0.members.size - 1];
    var_0.members[var_1] = var_3;

    if(isDefined(var_3))
      var_3.squadmemberid = var_1;
  }

  var_0.members[var_0.members.size - 1] = undefined;
  var_0.membercount = var_0.members.size;

  if(isDefined(self.squadofficerid))
    removeofficerfromsquad();

  foreach(var_5 in self.squad.memberremovefuncs)
  self thread[[var_5]](var_0.squadname);

  if(var_0.membercount == 0)
    deletesquad(var_0.squadname);

  if(isDefined(self)) {
    self.squad = undefined;
    self.squadmemberid = undefined;
    self notify("removed from squad");
  }
}

addofficertosquad() {
  var_0 = self.squad;

  if(isDefined(self.squadofficerid)) {
    return;
  }
  self.squadofficerid = var_0.officers.size;
  var_0.officers[self.squadofficerid] = self;
  var_0.officercount = var_0.officers.size;
}

removeofficerfromsquad() {
  var_0 = self.squad;
  var_1 = -1;

  if(isDefined(self))
    var_1 = self.squadofficerid;
  else {
    for(var_2 = 0; var_2 < var_0.officers.size; var_2++) {
      if(var_0.officers[var_2] == self)
        var_1 = var_2;
    }
  }

  if(var_1 != var_0.officers.size - 1) {
    var_3 = var_0.officers[var_0.officers.size - 1];
    var_0.officers[var_1] = var_3;

    if(isDefined(var_3))
      var_3.squadofficerid = var_1;
  }

  var_0.officers[var_0.officers.size - 1] = undefined;
  var_0.officercount = var_0.officers.size;

  if(isDefined(self))
    self.squadofficerid = undefined;
}

officerwaiter() {
  for(var_0 = 0; var_0 < self.members.size; var_0++) {
    if(self.members[var_0] scripts\anim\battlechatter.gsc::isofficer())
      self.members[var_0] addofficertosquad();
  }
}

squadtracker() {
  anim endon("squad deleted " + self.squadname);

  for(;;) {
    updateall();
    wait 0.1;
  }
}

memberdeathwaiter() {
  self endon("removed from squad");
  self waittill("death", var_0);

  if(isDefined(self))
    self.attacker = var_0;

  removefromsquad();
}

updatecombat() {
  self.isincombat = 0;

  for(var_0 = 0; var_0 < anim.squadindex.size; var_0++)
    self.squadlist[anim.squadindex[var_0].squadname].isincontact = 0;

  for(var_0 = 0; var_0 < self.members.size; var_0++) {
    if(isDefined(self.members[var_0])) {
      if(isDefined(self.members[var_0].enemy) && isDefined(self.members[var_0].enemy.squad) && self.members[var_0].combattime > 0)
        self.squadlist[self.members[var_0].enemy.squad.squadname].isincontact = 1;
    }
  }
}

updateall() {
  var_0 = (0, 0, 0);
  var_1 = (0, 0, 0);
  var_2 = 0;
  var_3 = undefined;
  var_4 = 0;
  updatecombat();
  var_5 = !isDefined(self.enemy);

  if(!var_5)
    self.forward = vectorNormalize(self.enemy.origin - self.origin);

  foreach(var_7 in self.members) {
    if(!isalive(var_7)) {
      continue;
    }
    var_2++;
    var_0 = var_0 + var_7.origin;

    if(var_5)
      var_1 = var_1 + anglesToForward(var_7.angles);

    if(isDefined(var_7.enemy) && isDefined(var_7.enemy.squad)) {
      if(!isDefined(var_3)) {
        var_3 = var_7.enemy.squad;
        continue;
      }

      if(var_7.enemy.squad.membercount > var_3.membercount)
        var_3 = var_7.enemy.squad;
    }
  }

  if(var_2) {
    self.origin = var_0 / var_2;

    if(var_5)
      self.forward = var_1 / var_2;
  } else {
    self.origin = var_0;

    if(var_5)
      self.forward = var_1;
  }

  self.isincombat = var_4;
  self.enemy = var_3;
}

updatesquadlist() {
  for(var_0 = 0; var_0 < anim.squadindex.size; var_0++) {
    if(!isDefined(self.squadlist[anim.squadindex[var_0].squadname])) {
      self.squadlist[anim.squadindex[var_0].squadname] = spawnStruct();
      self.squadlist[anim.squadindex[var_0].squadname].isincontact = 0;
    }

    foreach(var_2 in self.squadupdatefuncs)
    self thread[[var_2]](anim.squadindex[var_0].squadname);
  }
}

printabovehead(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = (1, 0, 0);

  for(var_4 = 0; var_4 < var_1 * 2; var_4++) {
    if(!isalive(self)) {
      return;
    }
    var_5 = self getshootatpos() + (0, 0, 10) + var_2;
    wait 0.05;
  }
}

aiupdateanimstate(var_0) {
  switch (var_0) {
    case "stop":
    case "move":
    case "combat":
    case "death":
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
    case "cover_prone":
    case "cover_crouch":
    case "cover_stand":
    case "cover_left":
    case "cover_right":
      self.a.state = "cover";
      break;
    case "l33t truckride combat":
    case "aim":
      self.a.state = "combat";
      break;
  }
}

updatememberstates() {
  anim endon("squad deleted " + self.squadname);
  var_0 = 0.05;

  for(;;) {
    foreach(var_2 in self.members) {
      if(!isalive(var_2) || var_2 == anim.player) {
        continue;
      }
      var_2 aiupdatecombat(var_0);
      var_2 aiupdatesuppressed(var_0);
    }

    wait(var_0);
  }
}

aiupdatecombat(var_0) {
  if(!isDefined(self.combattime)) {
    return;
  }
  if(isDefined(self.lastenemysightpos)) {
    if(self.combattime < 0)
      self.combattime = var_0;
    else
      self.combattime = self.combattime + var_0;

    self.lastenemysighttime = gettime();
    return;
  } else if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    self.combattime = self.combattime + var_0;
    return;
  }

  if(self.combattime > 0)
    self.combattime = 0 - var_0;
  else
    self.combattime = self.combattime - var_0;
}

aiupdatesuppressed(var_0) {
  if(!isDefined(self.suppressedtime)) {
    return;
  }
  if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
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