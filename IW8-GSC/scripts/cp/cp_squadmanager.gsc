/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_squadmanager.gsc
***********************************************/

function createsquad(var_0, var_1) {
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
  updatesquadlist(var_2);
  level notify("squad created " + var_0);
  anim notify("squad created " + var_0);

  for(var_3 = 0; var_3 < anim.squadcreatefuncs.size; var_3++) {
    var_4 = anim.squadcreatefuncs[var_3];
    var_2 thread[[var_4]]();
  }

  for(var_5 = 0; var_5 < anim.squadindex.size; var_5++) {
    updatesquadlist(anim.squadindex[var_5]);
  }

  return var_2;
}

function deletesquad(var_0) {
  if(var_0 == "axis" || var_0 == "team3" || var_0 == "allies" || var_0 == "jackal_allies" || var_0 == "jackal_axis") {
    return;
  }

  var_1 = anim.squads[var_0].squadid;
  var_2 = anim.squads[var_0];
  var_2 notify("squad_deleting");

  while(var_2.members.size) {
    addtosquad(var_2.members[0], var_2.members[0].team);
  }

  anim.squadindex[var_1] = anim.squadindex[anim.squadindex.size - 1];
  anim.squadindex[var_1].squadid = var_1;
  anim.squadindex[anim.squadindex.size - 1] = undefined;
  anim.squads[var_0] = undefined;
  anim notify("squad deleted " + var_0);

  for(var_3 = 0; var_3 < anim.squadindex.size; var_3++) {
    updatesquadlist(anim.squadindex[var_3]);
  }
}

function addplayertosquad(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.script_squadname)) {
      var_0 = self.script_squadname;
    } else {
      var_0 = self.team;
    }
  }

  if(!isDefined(anim.squads[var_0])) {
    createsquad(anim, var_0, self);
  }

  var_1 = anim.squads[var_0];
  var_2 = 0;

  if(isDefined(var_1.members)) {
    for(var_3 = 0; var_3 < var_1.members.size; var_3++) {
      var_4 = var_1.members[var_3];

      if(var_4 != anim.player) {
        continue;
      }

      var_2 = 1;
      break;
    }

    if(!var_2) {
      var_1.members[var_1.members.size] = self;
    }
  }

  self.squad = var_1;
}

function playeranimnameswitch() {
  var_0 = getEntArray("player", "classname")[0];
  scripts\cp\cp_playerchatter::player_update_allowed_callouts();
  anim.player = var_0;

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

  for(var_1 = 0; var_1 < anim.squadindex.size; var_1++) {
    anim.squadindex[var_1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var_1].members);
    updatesquadlist(anim.squadindex[var_1]);
  }

  scripts\cp\cp_playerchatter::init_playerchatter();

  for(;;) {
    var_2 = [];

    for(var_3 = 0; var_3 < anim.squads["allies"].members.size; var_3++) {
      var_4 = anim.squads["allies"].members[var_3];

      if(!isDefined(level.player_jackal) || isDefined(level.player_jackal) && var_4 != level.player_jackal) {
        var_2 = var_4;
      }
    }

    anim.squads["allies"].members = var_2;
    anim.player = var_0;

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

    for(var_5 = 0; var_5 < anim.squadindex.size; var_5++) {
      anim.squadindex[var_5].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var_5].members);
      updatesquadlist(anim.squadindex[var_5]);
    }

    scripts\cp\cp_playerchatter::init_playerchatter();
    wait 0.5;
  }
}

function getsquadteam(var_0) {
  var_1 = "allies";

  if(isDefined(level.template_script) && level.template_script == "phparade") {
    var_0.team = "allies";
  }

  if(var_0.team == "axis" || var_0.team == "neutral" || var_0.team == "team3") {
    var_1 = var_0.team;
  }

  return var_1;
}

function addtosquad(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.script_squadname)) {
      var_0 = self.script_squadname;
    } else {
      var_0 = self.team;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(anim.squads[var_0])) {
    createsquad(anim, var_0, self);
  }

  var_1 = anim.squads[var_0];

  if(isDefined(self.squad)) {
    if(self.squad == var_1) {
      return;
    } else {
      removefromsquad(self.squad);
    }
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.starttime = gettime();
  self.squad = var_1;
  var_1.members[var_1.members.size] = self;
  var_1.membercount = var_1.members.size;

  if(isDefined(self.squad.memberaddfuncs)) {
    for(var_2 = 0; var_2 < self.squad.memberaddfuncs.size; var_2++) {
      var_3 = self.squad.memberaddfuncs[var_2];
      self thread[[var_3]](self.squad.squadname);
    }
  }

  thread memberdeathwaiter();
}

function removefromsquad(var_0) {
  if(!isDefined(var_0) && !isDefined(self.squad)) {
    return;
  }

  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, self.squad);
  var_0.members = scripts\engine\utility::array_removeundefined(var_0.members);

  if(isDefined(self)) {
    var_0.members = scripts\engine\utility::array_remove(var_0.members, self);
    self.squad = var_0;
  }

  var_0.membercount = var_0.members.size;

  for(var_1 = 0; var_1 < var_0.memberremovefuncs.size; var_1++) {
    var_2 = var_0.memberremovefuncs[var_1];
    self thread[[var_2]](var_0.squadname);
  }

  if(var_0.members.size == 0) {
    deletesquad(var_0.squadname);
  }

  if(isDefined(self)) {
    self.squad = undefined;
    self notify("removed from squad");
    return;
  }
}

function addofficertosquad() {
  var_0 = self.squad;

  if(isDefined(self.squadofficerid)) {
    return;
  }

  self.squadofficerid = var_0.officers.size;
  var_0.officers[self.squadofficerid] = self;
  var_0.officercount = var_0.officers.size;
}

function removeofficerfromsquad() {
  var_0 = self.squad;
  var_1 = -1;

  if(isDefined(self)) {
    var_1 = self.squadofficerid;
  } else {
    for(var_2 = 0; var_2 < var_0.officers.size; var_2++) {
      if(var_0.officers[var_2] == self) {
        var_1 = var_2;
      }
    }
  }

  if(var_1 != var_0.officers.size - 1) {
    var_3 = var_0.officers[var_0.officers.size - 1];
    var_0.officers[var_1] = var_3;

    if(isDefined(var_3)) {
      var_3.squadofficerid = var_1;
    }
  }

  var_0.officers[var_0.officers.size - 1] = undefined;
  var_0.officercount = var_0.officers.size;

  if(isDefined(self)) {
    self.squadofficerid = undefined;
    return;
  }
}

function officerwaiter() {
  for(var_0 = 0; var_0 < self.members.size; var_0++) {
    if(self.members[var_0] scripts\cp\cp_battlechatter::isofficer()) {
      addofficertosquad(self.members[var_0]);
    }
  }
}

function memberdeathwaiter() {
  self endon("removed from squad");
  var_0 = self.squad;
  self waittill("death", var_1);

  if(isDefined(self)) {
    self.attacker = var_1;
  }

  removefromsquad(var_0);
}

function updatecombat() {}

function updatesquadlist() {
  for(var_0 = 0; var_0 < anim.squadindex.size; var_0++) {
    if(!isDefined(self.squadlist[anim.squadindex[var_0].squadname])) {
      self.squadlist[anim.squadindex[var_0].squadname] = spawnStruct();
      self.squadlist[anim.squadindex[var_0].squadname].isincontact = 0;
    }

    for(var_1 = 0; var_1 < self.squadupdatefuncs.size; var_1++) {
      var_2 = self.squadupdatefuncs[var_1];
      self thread[[var_2]](anim.squadindex[var_0].squadname);
    }
  }
}

function printabovehead(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = (1, 0, 0);
  }

  for(var_4 = 0; var_4 < var_1 * 2; var_4++) {
    if(!isalive(self)) {
      return;
    }

    var_5 = self getshootatpos() + (0, 0, 10) + var_2;
    wait 0.05;
  }
}

function aiupdateanimstate(var_0) {
  switch (var_0) {
    case "move":
    case "stop":
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
  var_0 = 0.05;

  for(;;) {
    for(var_1 = 0; var_1 < self.members.size; var_1++) {
      var_2 = self.members[var_1];

      if(!isalive(var_2) || isDefined(anim.player) && var_2 == anim.player) {
        continue;
      }

      aiupdatecombat(var_2, var_0);
      aiupdatesuppressed(var_2, var_0);
    }

    wait var_0;
  }
}

function aiupdatecombat(var_0) {
  if(!isDefined(self.combattime)) {
    return;
  }

  if(isDefined(self.lastenemysightpos)) {
    if(self.combattime < 0) {
      self.combattime = var_0;
    } else {
      self.combattime += var_0;
    }

    self.lastenemysighttime = gettime();
    return;
  } else if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    self.combattime += var_0;
    return;
  }

  if(self.combattime > 0) {
    self.combattime = 0 - var_0;
    return;
  }

  self.combattime -= var_0;
}

function aiupdatesuppressed(var_0) {
  if(!isDefined(self.suppressedtime)) {
    return;
  }

  if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "jackal" && self issuppressed()) {
    if(self.suppressedtime < 0) {
      self.suppressedtime = var_0;
      return;
    }

    self.suppressedtime += var_0;
    return;
  }

  if(self.suppressedtime > 0) {
    self.suppressedtime = 0 - var_0;
    return;
  }

  self.suppressedtime -= var_0;
}