/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_squadmanager.gsc
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
  level notify("_encstr_95430F88034BDB91A24B1685219BF9A966" + var_0);
  anim notify("_encstr_95430F88034BDB91A24B1685219BF9A966" + var_0);

  for(var_3 = 0; var_3 < anim.squadcreatefuncs.size; var_3++) {
    var_4 = anim.squadcreatefuncs[var_3];
    var_2 thread[[var_4]]();
  }

  for(var_5 = 0; var_5 < anim.squadindex.size; var_5++)
    anim.squadindex[var_5] updatesquadlist();

  return var_2;
}

deletesquad(var_0) {
  if(var_0 == "_encstr_8E8405EA382B2A" || var_0 == "_encstr_B848067B63177293" || var_0 == "_encstr_9A8507BA4040188D08" || var_0 == "_encstr_8E700E721E729711544F2040AB79A91F" || var_0 == "_encstr_AB650C9AD13FD87BA531C0104A3A") {
    return;
  }
  var_1 = anim.squads[var_0].squadid;
  var_2 = anim.squads[var_0];
  var_2 notify("_encstr_964C0FF733ED392996690F3C6BE3832D97");

  while(var_2.members.size)
    var_2.members[0] addtosquad(var_2.members[0].team);

  anim.squadindex[var_1] = anim.squadindex[anim.squadindex.size - 1];
  anim.squadindex[var_1].squadid = var_1;
  anim.squadindex[anim.squadindex.size - 1] = undefined;
  anim.squads[var_0] = undefined;
  anim notify("_encstr_A6A30F6EB8AB0BC80123ACC6CA3A959180" + var_0);

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
    for(var_3 = 0; var_3 < var_1.members.size; var_3++) {
      var_4 = var_1.members[var_3];

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
  var_0 = getEntArray("_encstr_8BB007E03658CBCAE4", "_encstr_AC110A7F14873B5B3D073009")[0];
  scripts\cp\cp_playerchatter::player_update_allowed_callouts();
  anim.player = var_0;

  if(!isDefined(anim.player.team))
    anim.player.team = "_encstr_9A8507BA4040188D08";

  scripts\cp\cp_playerchatter::player_update_allowed_callouts();
  anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_831805DFAF3BF3"] = 9000;
  anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_8C950626C2CB5B19"] = 5000;
  level.bcs_maxthreatdistsqrdfromplayer = squared(5000);
  level.bcs_maxtalkingdistsqrdfromplayer = squared(3000);
  level.bcs_maxstealthdistsqrdfromplayer = squared(1500);
  anim.teamthreatcalloutlimittimeout = 120000;
  anim.fbt_desireddistmax = 620;
  anim.fbt_waitmin = 12;
  anim.fbt_waitmax = 24;
  anim.fbt_linebreakmin = 2;
  anim.fbt_linebreakmax = 5;
  anim.player addplayertosquad("_encstr_9A8507BA4040188D08");

  for(var_1 = 0; var_1 < anim.squadindex.size; var_1++) {
    anim.squadindex[var_1].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var_1].members);
    anim.squadindex[var_1] updatesquadlist();
  }

  scripts\cp\cp_playerchatter::init_playerchatter();

  for(;;) {
    var_2 = [];

    for(var_3 = 0; var_3 < anim.squads["_encstr_9A8507BA4040188D08"].members.size; var_3++) {
      var_4 = anim.squads["_encstr_9A8507BA4040188D08"].members[var_3];

      if(!isDefined(level.player_jackal) || isDefined(level.player_jackal) && var_4 != level.player_jackal)
        var_2[var_2.size] = var_4;
    }

    anim.squads["_encstr_9A8507BA4040188D08"].members = var_2;
    anim.player = var_0;

    if(!isDefined(anim.player.team))
      anim.player.team = "_encstr_9A8507BA4040188D08";

    scripts\cp\cp_playerchatter::player_update_allowed_callouts();
    anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_831805DFAF3BF3"] = 9000;
    anim.eventactionminwait["_encstr_85CB07BDE04321538B"]["_encstr_8C950626C2CB5B19"] = 5000;
    level.bcs_maxthreatdistsqrdfromplayer = squared(5000);
    level.bcs_maxtalkingdistsqrdfromplayer = squared(3000);
    level.bcs_maxstealthdistsqrdfromplayer = squared(1500);
    anim.teamthreatcalloutlimittimeout = 120000;
    anim.fbt_desireddistmax = 620;
    anim.fbt_waitmin = 12;
    anim.fbt_waitmax = 24;
    anim.fbt_linebreakmin = 2;
    anim.fbt_linebreakmax = 5;
    anim.player addplayertosquad("_encstr_9A8507BA4040188D08");

    for(var_5 = 0; var_5 < anim.squadindex.size; var_5++) {
      anim.squadindex[var_5].members = scripts\engine\utility::array_removeundefined(anim.squadindex[var_5].members);
      anim.squadindex[var_5] updatesquadlist();
    }

    scripts\cp\cp_playerchatter::init_playerchatter();
    wait 0.5;
  }
}

getsquadteam(var_0) {
  var_1 = "_encstr_9A8507BA4040188D08";

  if(isDefined(level.template_script) && level.template_script == "_encstr_A38109E00D0E0B9C583259")
    var_0.team = "_encstr_9A8507BA4040188D08";

  if(var_0.team == "_encstr_8E8405EA382B2A" || var_0.team == "_encstr_A7A408B9CA5D1D4E2C63" || var_0.team == "_encstr_B848067B63177293")
    var_1 = var_0.team;

  return var_1;
}

addtosquad(var_0) {
  if(!isDefined(var_0)) {
    if(isDefined(self.script_squadname))
      var_0 = self.script_squadname;
    else
      var_0 = self.team;
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(anim.squads[var_0]))
    anim createsquad(var_0, self);

  var_1 = anim.squads[var_0];

  if(isDefined(self.squad)) {
    if(self.squad == var_1)
      return;
    else
      removefromsquad(self.squad);
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

removefromsquad(var_0) {
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

  if(var_0.members.size == 0)
    deletesquad(var_0.squadname);

  if(isDefined(self)) {
    self.squad = undefined;
    self notify("_encstr_AD4A13272BB6ED9D568C4033C9DB5B02E62EEA8546");
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
    if(self.members[var_0] scripts\cp\cp_battlechatter::isofficer())
      self.members[var_0] addofficertosquad();
  }
}

memberdeathwaiter() {
  self endon("_encstr_AD4A13272BB6ED9D568C4033C9DB5B02E62EEA8546");
  var_0 = self.squad;
  self waittill("_encstr_AD75063D571AE108", var_1);

  if(isDefined(self))
    self.attacker = var_1;

  removefromsquad(var_0);
}

updatecombat() {}

updatesquadlist() {
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

printabovehead(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

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
    case "_encstr_ACA20538F84D39":
    case "_encstr_B419059BD17BE0":
    case "_encstr_AA7C07466F9DA30713":
    case "_encstr_AD75063D571AE108":
      self.a.state = var_0;
      break;
    case "_encstr_ACA90DE733E02B61F923C8DFB36D02":
    case "_encstr_B60D055B0E3128":
      break;
    case "_encstr_ACEC189FB9FF8A2130D1AA76A9E173F2CC2313B77F9E62F57058":
    case "_encstr_996F1249CA7DBBD0A358A8E373D3C6186C70D6D0":
    case "_encstr_8E6A12E740B89FFF3A307585BD658792C69FCA77":
    case "_encstr_961A13BED5EACFA9614B98C05BAC2607937D2D366C":
    case "_encstr_8711118DF69DB239AF779619ACEB4EA5CED0A3":
    case "_encstr_AF071059ED4E1006B1978391F79941A8F683":
    case "_encstr_8C7D0C5E3065DAE27E186B17C011":
    case "_encstr_91280CE8026B33B37F7ABBA448FB":
    case "_encstr_87970BBFC71BCD10D7953951BB":
    case "_encstr_96BC0CA9321B0D2861C34163F697":
    case "_encstr_8DE30D6CF69D2B937DB1277BAE8DD0":
      self.a.state = "_encstr_B68E06D8F6B3CA27";
      break;
    case "_encstr_885F16D899991D40E89CBAC6D6C9D2235904D8ED5B31168E":
    case "_encstr_8719040B4BB5":
      self.a.state = "_encstr_AA7C07466F9DA30713";
      break;
  }
}

updatememberstates() {
  anim endon("_encstr_A6A30F6EB8AB0BC80123ACC6CA3A959180" + self.squadname);
  var_0 = 0.05;

  for(;;) {
    for(var_1 = 0; var_1 < self.members.size; var_1++) {
      var_2 = self.members[var_1];

      if(!isalive(var_2) || isDefined(anim.player) && var_2 == anim.player) {
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
  } else if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "_encstr_B88607820996877650" && self issuppressed()) {
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
  if(isDefined(self.bt_escaping) && self.bt_escaping || isDefined(self.asmname) && self.asmname != "_encstr_B88607820996877650" && self issuppressed()) {
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