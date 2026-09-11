/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\squadmanager.gsc
***********************************************/

function createsquad(var0, var1) {
  var2 = spawnStruct();
  var2.squadname = var0;
  anim.squads[var0] = var2;
  var2.team = getsquadteam(var1);
  var2.sighttime = 0;
  var2.origin = undefined;
  var2.forward = undefined;
  var2.enemy = undefined;
  var2.isincombat = 0;
  var2.membercount = 0;
  var2.members = [];
  var2.officers = [];
  var2.officercount = 0;
  var2.squadlist = [];
  var2.memberaddfuncs = [];
  var2.memberaddstrings = [];
  var2.memberremovefuncs = [];
  var2.memberremovestrings = [];
  var2.squadupdatefuncs = [];
  var2.squadupdatestrings = [];
  var2.squadid = anim.squadindex.size;
  anim.squadindex[anim.squadindex.size] = var2;
  updatesquadlist(var2);
  level notify("squad created " + var0);
  anim notify("squad created " + var0);

  for(var3 = 0; var3 < anim.squadcreatefuncs.size; var3++) {
    var4 = anim.squadcreatefuncs[var3];
    var2 thread[[var4]]();
  }

  for(var3 = 0; var3 < anim.squadindex.size; var3++) {
    updatesquadlist(anim.squadindex[var3]);
  }

  thread squadtracker();
  thread officerwaiter();
  thread updatememberstates();
  return var2;
}

function deletesquad(var0) {
  if(var0 == "axis" || var0 == "team3" || var0 == "allies" || var0 == "jackal_allies" || var0 == "jackal_axis") {
    return;
  }

  var1 = anim.squads[var0].squadid;
  var2 = anim.squads[var0];
  var2 notify("squad_deleting");

  while(var2.members.size) {
    addtosquad(var2.members[0], var2.members[0].team);
  }

  anim.squadindex[var1] = anim.squadindex[anim.squadindex.size - 1];
  anim.squadindex[var1].squadid = var1;
  anim.squadindex[anim.squadindex.size - 1] = undefined;
  anim.squads[var0] = undefined;
  anim notify("squad deleted " + var0);

  for(var3 = 0; var3 < anim.squadindex.size; var3++) {
    updatesquadlist(anim.squadindex[var3]);
  }
}

function addplayertosquad(var0) {
  if(!isDefined(var0)) {
    if(isDefined(self.script_squadname)) {
      var0 = self.script_squadname;
    } else {
      var0 = self.team;
    }
  }

  if(!isDefined(anim.squads[var0])) {
    createsquad(anim, var0, self);
  }

  var1 = anim.squads[var0];
  var2 = 0;

  if(isDefined(var1.members)) {
    foreach(var4 in var1.members) {
      if(var4 != anim.player) {
        continue;
      }

      var2 = 1;
      break;
    }

    if(!var2) {
      var1.members[var1.members.size] = self;
    }
  }

  self.squad = var1;
}

function playeranimnameswitch() {
  var0 = getEntArray("player", "classname")[0];
  scripts\sp\player\playerchatter::player_update_allowed_callouts();

  if(scripts\engine\utility::player_is_in_jackal()) {
    anim.player = level.player_jackal;

    if(!isDefined(anim.player.team)) {
      anim.player.team = "allies";
    }

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
    addplayertosquad(anim.player, "jackal_allies");

    for(var1 = 0; var1 < anim.squadindex.size; var1++) {
      anim.squadindex[var1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var1].members);
      updatesquadlist(anim.squadindex[var1]);
    }

    scripts\sp\player\playerchatter::init_playerchatter();

    while(scripts\engine\utility::player_is_in_jackal()) {
      wait 0.05;
    }

    goto LOC_00000241;
  }

  anim.player = var1;

  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

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
  addplayertosquad(anim.player, "allies");

  for(var1 = 0; var1 < anim.squadindex.size; var1++) {
    anim.squadindex[var1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var1].members);
    updatesquadlist(anim.squadindex[var1]);
  }

  scripts\sp\player\playerchatter::init_playerchatter();

  for(;;) {
    jumpiftrue(scripts\engine\utility::player_is_in_jackal()) LOC_00000241;
    wait 0.05;
  }

  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      var2 = [];

      foreach(var4 in anim.squads["allies"].members) {
        if(var4 != level.player) {
          var2 = var4;
        }
      }

      anim.squads["allies"].members = var2;
      anim.player = level.player_jackal;

      if(!isDefined(anim.player.team)) {
        anim.player.team = "allies";
      }

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
      addplayertosquad(anim.player, "jackal_allies");

      for(var1 = 0; var1 < anim.squadindex.size; var1++) {
        anim.squadindex[var1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var1].members);
        updatesquadlist(anim.squadindex[var1]);
      }

      scripts\sp\player\playerchatter::init_playerchatter();

      while(scripts\engine\utility::player_is_in_jackal()) {
        wait 0.05;
      }

      continue;
    }

    var2 = [];

    foreach(var4 in anim.squads["allies"].members) {
      if(!isDefined(level.player_jackal) || isDefined(level.player_jackal) && var4 != level.player_jackal) {
        var2 = var4;
      }
    }

    anim.squads["allies"].members = var2;
    anim.player = var1;

    if(!isDefined(anim.player.team)) {
      anim.player.team = "allies";
    }

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
    addplayertosquad(anim.player, "allies");

    for(var1 = 0; var1 < anim.squadindex.size; var1++) {
      anim.squadindex[var1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var1].members);
      updatesquadlist(anim.squadindex[var1]);
    }

    scripts\sp\player\playerchatter::init_playerchatter();

    while(!scripts\engine\utility::player_is_in_jackal()) {
      wait 0.05;
    }
  }
}

function getsquadteam(var0) {
  var1 = "allies";

  if(isDefined(level.template_script) && level.template_script == "phparade") {
    var0.team = "allies";
  }

  if(var0.team == "axis" || var0.team == "neutral" || var0.team == "team3") {
    var1 = var0.team;
  }

  return var1;
}

function addtosquad(var0) {
  if(!isDefined(var0)) {
    if(isDefined(self.script_squadname)) {
      var0 = self.script_squadname;
    } else {
      var0 = self.team;
    }

    if(isDefined(self.bcs_jackal) && self.bcs_jackal) {
      var0 = "jackal_" + self.script_team;
    }
  }

  if(!isDefined(anim.squads[var0])) {
    createsquad(anim, var0, self);
  }

  var1 = anim.squads[var0];

  if(isDefined(self.squad)) {
    if(self.squad == var1) {
      return;
    } else {
      removefromsquad();
    }
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.starttime = gettime();
  self.squad = var1;
  self.squadmemberid = var1.members.size;
  var1.members[self.squadmemberid] = self;
  var1.membercount = var1.members.size;

  if(isDefined(level.loadoutcomplete)) {
    if(self.team == "allies" && scripts\anim\battlechatter::isofficer()) {
      addofficertosquad();
    }
  }

  foreach(var3 in self.squad.memberaddfuncs) {
    self thread[[var3]](self.squad.squadname);
  }

  thread memberdeathwaiter();
}

function removefromsquad() {
  var0 = self.squad;
  var1 = -1;

  if(isDefined(self)) {
    var1 = self.squadmemberid;
  } else {
    for(var2 = 0; var2 < var0.members.size; var2++) {
      if(var0.members[var2] == self) {
        var1 = var2;
      }
    }
  }

  if(var1 != var0.members.size - 1) {
    var3 = var0.members[var0.members.size - 1];
    var0.members[var1] = var3;

    if(isDefined(var3)) {
      var3.squadmemberid = var1;
    }
  }

  var0.members[var0.members.size - 1] = undefined;
  var0.membercount = var0.members.size;

  if(isDefined(self.squadofficerid)) {
    removeofficerfromsquad();
  }

  foreach(var5 in self.squad.memberremovefuncs) {
    self thread[[var5]](var0.squadname);
  }

  if(var0.membercount == 0) {
    deletesquad(var0.squadname);
  }

  if(isDefined(self)) {
    self.squad = undefined;
    self.squadmemberid = undefined;
    self notify("removed from squad");
    return;
  }
}

function addofficertosquad() {
  var0 = self.squad;

  if(isDefined(self.squadofficerid)) {
    return;
  }

  self.squadofficerid = var0.officers.size;
  var0.officers[self.squadofficerid] = self;
  var0.officercount = var0.officers.size;
}

function removeofficerfromsquad() {
  var0 = self.squad;
  var1 = -1;

  if(isDefined(self)) {
    var1 = self.squadofficerid;
  } else {
    for(var2 = 0; var2 < var0.officers.size; var2++) {
      if(var0.officers[var2] == self) {
        var1 = var2;
      }
    }
  }

  if(var1 != var0.officers.size - 1) {
    var3 = var0.officers[var0.officers.size - 1];
    var0.officers[var1] = var3;

    if(isDefined(var3)) {
      var3.squadofficerid = var1;
    }
  }

  var0.officers[var0.officers.size - 1] = undefined;
  var0.officercount = var0.officers.size;

  if(isDefined(self)) {
    self.squadofficerid = undefined;
    return;
  }
}

function officerwaiter() {
  for(var0 = 0; var0 < self.members.size; var0++) {
    if(self.members[var0] scripts\anim\battlechatter::isofficer()) {
      addofficertosquad(self.members[var0]);
    }
  }
}

function squadtracker() {
  anim endon("squad deleted " + self.squadname);

  for(;;) {
    updateall();
    wait 0.1;
  }
}

function memberdeathwaiter() {
  self endon("removed from squad");
  self waittill("death", var0);

  if(isDefined(self)) {
    self.attacker = var0;
  }

  removefromsquad();
}

function updatecombat() {
  self.isincombat = 0;

  for(var0 = 0; var0 < anim.squadindex.size; var0++) {
    self.squadlist[anim.squadindex[var0].squadname].isincontact = 0;
  }

  for(var0 = 0; var0 < self.members.size; var0++) {
    if(isDefined(self.members[var0])) {
      if(isDefined(self.members[var0].enemy) && isDefined(self.members[var0].enemy.squad) && self.members[var0].combattime > 0) {
        self.squadlist[self.members[var0].enemy.squad.squadname].isincontact = 1;
      }
    }
  }
}

function updateall() {
  var0 = (0, 0, 0);
  var1 = (0, 0, 0);
  var2 = 0;
  var3 = undefined;
  var4 = 0;
  updatecombat();
  var5 = !isDefined(self.enemy);

  if(!var5) {
    self.forward = vectorNormalize(self.enemy.origin - self.origin);
  }

  foreach(var7 in self.members) {
    if(!isalive(var7)) {
      continue;
    }

    var2++;
    var0 += var7.origin;

    if(var5) {
      var1 += anglesToForward(var7.angles);
    }

    if(isDefined(var7.enemy) && isDefined(var7.enemy.squad)) {
      if(!isDefined(var3)) {
        var3 = var7.enemy.squad;
        continue;
      }

      if(var7.enemy.squad.membercount > var3.membercount) {
        var3 = var7.enemy.squad;
      }
    }
  }

  if(var2) {
    self.origin = var0 / var2;

    if(var5) {
      self.forward = var1 / var2;
    }
  } else {
    self.origin = var0;

    if(var5) {
      self.forward = var1;
    }
  }

  self.isincombat = var4;
  self.enemy = var3;
}

function updatesquadlist() {
  for(var0 = 0; var0 < anim.squadindex.size; var0++) {
    if(!isDefined(self.squadlist[anim.squadindex[var0].squadname])) {
      self.squadlist[anim.squadindex[var0].squadname] = spawnStruct();
      self.squadlist[anim.squadindex[var0].squadname].isincontact = 0;
    }

    foreach(var2 in self.squadupdatefuncs) {
      self thread[[var2]](anim.squadindex[var0].squadname);
    }
  }
}

function printabovehead(var0, var1, var2, var3) {
  self endon("death");

  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  if(!isDefined(var3)) {
    var3 = (1, 0, 0);
  }

  for(var4 = 0; var4 < var1 * 2; var4++) {
    if(!isalive(self)) {
      return;
    }

    var5 = self getshootatpos() + (0, 0, 10) + var2;
    wait 0.05;
  }
}

function aiupdateanimstate(var0) {
  switch (var0) {
    case "stop":
    case "move":
    case "combat":
    case "death":
      self.a.state = var0;
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

function updatememberstates() {
  anim endon("squad deleted " + self.squadname);
  var0 = 0.05;

  for(;;) {
    foreach(var2 in self.members) {
      if(!isalive(var2) || var2 == anim.player) {
        continue;
      }

      aiupdatecombat(var2, var0);
      aiupdatesuppressed(var2, var0);
    }

    wait var0;
  }
}

function aiupdatecombat(var0) {
  if(!isDefined(self.combattime)) {
    return;
  }

  if(isDefined(self.lastenemysightpos)) {
    if(self.combattime < 0) {
      self.combattime = var0;
    } else {
      self.combattime += var0;
    }

    self.lastenemysighttime = gettime();
    return;
  } else if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    self.combattime += var0;
    return;
  }

  if(self.combattime > 0) {
    self.combattime = 0 - var0;
    return;
  }

  self.combattime -= var0;
}

function aiupdatesuppressed(var0) {
  if(!isDefined(self.suppressedtime)) {
    return;
  }

  if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    if(self.suppressedtime < 0) {
      self.suppressedtime = var0;
      return;
    }

    self.suppressedtime += var0;
    return;
  }

  if(self.suppressedtime > 0) {
    self.suppressedtime = 0 - var0;
    return;
  }

  self.suppressedtime -= var0;
}