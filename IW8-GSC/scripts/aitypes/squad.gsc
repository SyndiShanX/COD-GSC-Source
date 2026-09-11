/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\squad.gsc
***********************************************/

function createsquad() {
  if(!isDefined(level.squad_max_size)) {
    level.squad_max_size = 4;
  }

  if(!isDefined(level.squad_leader_group_size)) {
    level.squad_leader_group_size = 2;
  }

  setdvarifuninitialized("scr_ai_squad_move_type", "0");

  if(!isDefined(level.squads)) {
    level.squads = [];
  }

  var0 = getnewsquadindex();
  var1 = gettime();
  level.squads[var0] = spawnStruct();
  level.squads[var0].members = [];
  level.squads[var0].leadergroup = [];
  level.squads[var0].secondarygroup = [];
  level.squads[var0].squadmovecounter = 0;
  level.squads[var0].nextsquadmovementtime = var1 + 1000;
  level.squads[var0].nextforcedgroupmovementtime = var1 + 1000;
  level.squads[var0].nextsquadmergechecktime = var1 + 3000;
  return var0;
}

function getnewsquadindex() {
  if(!isDefined(level.squadscounter)) {
    level.squadscounter = 0;
  }

  var0 = level.squadscounter;
  level.squadscounter += 1;
  return var0;
}

function addtosquad(var0, var1) {
  var2 = level.squads[var0].members.size;
  level.squads[var0].members[var2] = var1;
  var1.squadnumber = var0;
  thread squadremoveondeath(var1);
  var1 scripts\engine\utility::set_bounding_overwatch(1);
  var1.squadmovementallowed = 0;

  if(var2 != 0) {
    var3 = level.squads[var0].leader;
    var1 setgoalpos(var3.goalpos);
    var1.goalradius = var3.goalradius;
    var1 setcoverselectionfocusent(var3);
  } else {
    level.squads[var0].leader = var1;
  }

  squadaddtosubgroup(var1);
}

function squadaddtosubgroup() {
  var0 = level.squads[self.squadnumber];
  var1 = undefined;

  if(issquadleader()) {
    if(var0.leadergroup.size >= level.squad_leader_group_size) {
      var1 = var0.leadergroup[0];
      var0.leadergroup[0] = self;
      var0.secondarygroup[var0.secondarygroup.size] = var1;
      return;
    }

    var0.leadergroup[var0.leadergroup.size] = self;
    return;
  }

  if(var0.leadergroup.size < level.squad_leader_group_size) {
    var0.leadergroup[var0.leadergroup.size] = self;
    return;
  }

  var0.secondarygroup[var0.secondarygroup.size] = self;
}

function issquadleader() {
  return isDefined(level.squads) && isDefined(level.squads[self.squadnumber]) && level.squads[self.squadnumber].leader == self;
}

function squadcreateandadd(var0) {
  var1 = createsquad();
  addtosquad(var0, var1, var0);
  return var1;
}

function array_removedeadandai(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(!isalive(var4)) {
      continue;
    }

    if(var4 == var1) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function removefromsquad(var0, var1) {
  if(!isDefined(level.squads[var0])) {
    return;
  }

  var1.squadnumber = -1;
  level.squads[var0].members = array_removedeadandai(level.squads[var0].members, var1);
  level.squads[var0].leadergroup = array_removedeadandai(level.squads[var0].leadergroup, var1);
  level.squads[var0].secondarygroup = array_removedeadandai(level.squads[var0].secondarygroup, var1);
  var2 = level.squads[var0].members.size;

  if(var2 == 0) {
    level.squads[var0] = undefined;
    return;
  }

  if(var2 <= 2) {
    var3 = level.squads[var0];
    squadassignnewleader(var0, 0);
    var4 = findnearestsquad(var3.leader, var0, 1);

    if(var4 == -1) {
      squadassignnewleader(var0, 0);
      return;
    }

    squadmerge(var0, var4);
    return;
  }

  squadassignnewleader(var0, 0);
}

function squadassignnewleader(var0, var1) {
  var2 = level.squads[var0].members[var1];
  level.squads[var0].leader = var2;
  level.squads[var0].leadergroup = scripts\engine\utility::array_remove(level.squads[var0].leadergroup, var2);
  level.squads[var0].secondarygroup = scripts\engine\utility::array_remove(level.squads[var0].secondarygroup, var2);
  squadaddtosubgroup(var2);

  foreach(var4 in level.squads[var0].members) {
    var4 setcoverselectionfocusent(var2);
  }
}

function squadmerge(var0, var1) {
  if(var0 == -1 || var1 == -1) {
    return;
  }

  foreach(var3 in level.squads[var0].members) {
    var3.squadnumber = -1;
    var3 notify("squad_removed");
    addtosquad(var3, var1, var3);
  }

  level.squads[var0] = undefined;
}

function squadexists(var0) {
  return isDefined(level.squads[var0]);
}

function setsquadgoalposition(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1024;
  }

  foreach(var4 in level.squads[var0].members) {
    var4.assigned_pos = var1;
    var4.goalradius = var2;
    var4 setgoalpos(var1);
    var4 scripts\engine\utility::set_bounding_overwatch(1);
  }
}

function isinsquad() {
  return self.squadnumber >= 0;
}

function updatesquad() {
  var0 = gettime();

  if(!isinsquad()) {
    findorcreatesquad();
    return;
  }

  if(level.squads[self.squadnumber].nextsquadmergechecktime < var0 && issquadleader()) {
    if(level.squads[self.squadnumber].size < level.squad_max_size) {
      var1 = squadfindnearbysquadtomergewith();
      squadmerge(self.squadnumber, var1);
    }

    level.squads[self.squadnumber].nextsquadmergechecktime = var0 + 3000;
    return;
  }
}

function findorcreatesquad() {
  if(!isDefined(level.squads) || level.squads.size == 0) {
    return squadcreateandadd(self);
  }

  var0 = findnearestsquad(-1, 0);

  if(var0 == -1) {
    return squadcreateandadd(self);
  }

  addtosquad(var0, self);
}

function findnearestsquad(var0, var1) {
  if(!isDefined(level.squads) || level.squads.size == 0) {
    return -1;
  }

  var2 = -1;
  var3 = 100000000;
  var4 = level.squads[var0];

  foreach(var6 in level.squads) {
    var6 = var6.members;

    if(var8 == var0) {
      continue;
    }

    if(var6.size >= level.squad_max_size) {
      continue;
    }

    if(!isalive(var6[0])) {
      continue;
    }

    if(var6[0].team != self.team) {
      continue;
    }

    var7 = distancesquared(var6[0].origin, self.origin);

    if(var1) {
      if(var7 > 1000000) {
        continue;
      }

      if(var6.size + level.squads[var0].members.size > level.squad_max_size) {
        continue;
      }
    } else if(var7 > 160000) {
      continue;
    }

    if(var7 < var3) {
      var3 = var7;
      var2 = var6[0].squadnumber;
    }
  }

  return var2;
}

function squadfindnearbysquadtomergewith() {
  return findnearestsquad(self.squadnumber, 1);
}

function squadremoveondeath(var0) {
  self endon("squad_removed");
  self waittill("death");

  if(!isDefined(self)) {
    level.squads[var0].members = scripts\engine\utility::array_removeundefined(level.squads[var0].members);

    if(level.squads[var0].members.size == 0) {
      level.squads[var0] = undefined;
    }

    return;
  }

  removefromsquad(self.squadnumber, self);
}