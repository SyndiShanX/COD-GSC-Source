/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_squadmanager.gsc
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

  for(var5 = 0; var5 < anim.squadindex.size; var5++) {
    updatesquadlist(anim.squadindex[var5]);
  }

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
    for(var3 = 0; var3 < var1.members.size; var3++) {
      var4 = var1.members[var3];

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
  scripts\cp\cp_playerchatter::player_update_allowed_callouts();
  anim.player = var0;

  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

  scripts\cp\cp_playerchatter::player_update_allowed_callouts();
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

  scripts\cp\cp_playerchatter::init_playerchatter();

  for(;;) {
    var2 = [];

    for(var3 = 0; var3 < anim.squads["allies"].members.size; var3++) {
      var4 = anim.squads["allies"].members[var3];

      if(!isDefined(level.player_jackal) || isDefined(level.player_jackal) && var4 != level.player_jackal) {
        var2 = var4;
      }
    }

    anim.squads["allies"].members = var2;
    anim.player = var0;

    if(!isDefined(anim.player.team)) {
      anim.player.team = "allies";
    }

    scripts\cp\cp_playerchatter::player_update_allowed_callouts();
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

    for(var5 = 0; var5 < anim.squadindex.size; var5++) {
      anim.squadindex[var5].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var5].members);
      updatesquadlist(anim.squadindex[var5]);
    }

    scripts\cp\cp_playerchatter::init_playerchatter();
    wait 0.5;
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
  }

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(anim.squads[var0])) {
    createsquad(anim, var0, self);
  }

  var1 = anim.squads[var0];

  if(isDefined(self.squad)) {
    if(self.squad == var1) {
      return;
    } else {
      removefromsquad(self.squad);
    }
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.starttime = gettime();
  self.squad = var1;
  var1.members[var1.members.size] = self;
  var1.membercount = var1.members.size;

  if(isDefined(self.squad.memberaddfuncs)) {
    for(var2 = 0; var2 < self.squad.memberaddfuncs.size; var2++) {
      var3 = self.squad.memberaddfuncs[var2];
      self thread[[var3]](self.squad.squadname);
    }
  }

  thread memberdeathwaiter();
}

function removefromsquad(var0) {
  if(!isDefined(var0) && !isDefined(self.squad)) {
    return;
  }

  var0 = scripts\engine\utility::ter_op(isDefined(var0), var0, self.squad);
  var0.members = scripts\engine\utility::array_removeundefined(var0.members);

  if(isDefined(self)) {
    var0.members = scripts\engine\utility::array_remove(var0.members, self);
    self.squad = var0;
  }

  var0.membercount = var0.members.size;

  for(var1 = 0; var1 < var0.memberremovefuncs.size; var1++) {
    var2 = var0.memberremovefuncs[var1];
    self thread[[var2]](var0.squadname);
  }

  if(var0.members.size == 0) {
    deletesquad(var0.squadname);
  }

  if(isDefined(self)) {
    self.squad = undefined;
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
    if(self.members[var0] scripts\cp\cp_battlechatter::isofficer()) {
      addofficertosquad(self.members[var0]);
    }
  }
}

function memberdeathwaiter() {
  self endon("removed from squad");
  var0 = self.squad;
  self waittill("death", var1);

  if(isDefined(self)) {
    self.attacker = var1;
  }

  removefromsquad(var0);
}

function updatecombat() {}

function updatesquadlist() {
  for(var0 = 0; var0 < anim.squadindex.size; var0++) {
    if(!isDefined(self.squadlist[anim.squadindex[var0].squadname])) {
      self.squadlist[anim.squadindex[var0].squadname] = spawnStruct();
      self.squadlist[anim.squadindex[var0].squadname].isincontact = 0;
    }

    for(var1 = 0; var1 < self.squadupdatefuncs.size; var1++) {
      var2 = self.squadupdatefuncs[var1];
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
    case "move":
    case "stop":
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

function updatememberstates() {
  anim endon("squad deleted " + self.squadname);
  var0 = 0.05;

  for(;;) {
    for(var1 = 0; var1 < self.members.size; var1++) {
      var2 = self.members[var1];

      if(!isalive(var2) || isDefined(anim.player) && var2 == anim.player) {
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