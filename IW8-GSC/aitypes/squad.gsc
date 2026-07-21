/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\squad.gsc
***********************************************/

createsquad() {
  if(!isDefined(level.squad_max_size))
    level.squad_max_size = 4;

  if(!isDefined(level.squad_leader_group_size))
    level.squad_leader_group_size = 2;

  setdvarifuninitialized("scr_ai_squad_move_type", "0");

  if(!isDefined(level.squads))
    level.squads = [];

  var_0 = getnewsquadindex();
  var_1 = gettime();
  level.squads[var_0] = spawnStruct();
  level.squads[var_0].members = [];
  level.squads[var_0].leadergroup = [];
  level.squads[var_0].secondarygroup = [];
  level.squads[var_0].squadmovecounter = 0;
  level.squads[var_0].nextsquadmovementtime = var_1 + 1000;
  level.squads[var_0].nextforcedgroupmovementtime = var_1 + 1000;
  level.squads[var_0].nextsquadmergechecktime = var_1 + 3000;
  return var_0;
}

getnewsquadindex() {
  if(!isDefined(level.squadscounter))
    level.squadscounter = 0;

  var_0 = level.squadscounter;
  level.squadscounter = level.squadscounter + 1;
  return var_0;
}

addtosquad(var_0, var_1) {
  var_2 = level.squads[var_0].members.size;
  level.squads[var_0].members[var_2] = var_1;
  var_1.squadnumber = var_0;
  var_1 thread squadremoveondeath(var_1.squadnumber);
  var_1 scripts\engine\utility::set_bounding_overwatch(1);
  var_1.squadmovementallowed = 0;

  if(var_2 != 0) {
    var_3 = level.squads[var_0].leader;
    var_1 setgoalpos(var_3.goalpos);
    var_1.goalradius = var_3.goalradius;
    var_1 setcoverselectionfocusent(var_3);
  } else
    level.squads[var_0].leader = var_1;

  var_1 squadaddtosubgroup();
}

squadaddtosubgroup() {
  var_0 = level.squads[self.squadnumber];
  var_1 = undefined;

  if(issquadleader()) {
    if(var_0.leadergroup.size >= level.squad_leader_group_size) {
      var_1 = var_0.leadergroup[0];
      var_0.leadergroup[0] = self;
      var_0.secondarygroup[var_0.secondarygroup.size] = var_1;
      return;
    }

    var_0.leadergroup[var_0.leadergroup.size] = self;
  } else if(var_0.leadergroup.size < level.squad_leader_group_size)
    var_0.leadergroup[var_0.leadergroup.size] = self;
  else
    var_0.secondarygroup[var_0.secondarygroup.size] = self;
}

issquadleader() {
  return isDefined(level.squads) && isDefined(level.squads[self.squadnumber]) && level.squads[self.squadnumber].leader == self;
}

squadcreateandadd(var_0) {
  var_1 = createsquad();
  var_0 addtosquad(var_1, var_0);
  return var_1;
}

array_removedeadandai(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isalive(var_4)) {
      continue;
    }
    if(var_4 == var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

removefromsquad(var_0, var_1) {
  if(!isDefined(level.squads[var_0])) {
    return;
  }
  var_1.squadnumber = -1;
  level.squads[var_0].members = array_removedeadandai(level.squads[var_0].members, var_1);
  level.squads[var_0].leadergroup = array_removedeadandai(level.squads[var_0].leadergroup, var_1);
  level.squads[var_0].secondarygroup = array_removedeadandai(level.squads[var_0].secondarygroup, var_1);
  var_2 = level.squads[var_0].members.size;

  if(var_2 == 0)
    level.squads[var_0] = undefined;
  else if(var_2 <= 2) {
    var_3 = level.squads[var_0];
    squadassignnewleader(var_0, 0);
    var_4 = var_3.leader findnearestsquad(var_0, 1);

    if(var_4 == -1) {
      squadassignnewleader(var_0, 0);
      return;
    }

    squadmerge(var_0, var_4);
    return;
  } else
    squadassignnewleader(var_0, 0);
}

squadassignnewleader(var_0, var_1) {
  var_2 = level.squads[var_0].members[var_1];
  level.squads[var_0].leader = var_2;
  level.squads[var_0].leadergroup = scripts\engine\utility::array_remove(level.squads[var_0].leadergroup, var_2);
  level.squads[var_0].secondarygroup = scripts\engine\utility::array_remove(level.squads[var_0].secondarygroup, var_2);
  var_2 squadaddtosubgroup();

  foreach(var_4 in level.squads[var_0].members)
  var_4 setcoverselectionfocusent(var_2);
}

squadmerge(var_0, var_1) {
  if(var_0 == -1 || var_1 == -1) {
    return;
  }
  foreach(var_3 in level.squads[var_0].members) {
    var_3.squadnumber = -1;
    var_3 notify("squad_removed");
    var_3 addtosquad(var_1, var_3);
  }

  level.squads[var_0] = undefined;
}

squadexists(var_0) {
  return isDefined(level.squads[var_0]);
}

setsquadgoalposition(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1024;

  foreach(var_4 in level.squads[var_0].members) {
    var_4.assigned_pos = var_1;
    var_4.goalradius = var_2;
    var_4 setgoalpos(var_1);
    var_4 scripts\engine\utility::set_bounding_overwatch(1);
  }
}

isinsquad() {
  return self.squadnumber >= 0;
}

updatesquad() {
  var_0 = gettime();

  if(!isinsquad())
    findorcreatesquad();
  else if(level.squads[self.squadnumber].nextsquadmergechecktime < var_0 && issquadleader()) {
    if(level.squads[self.squadnumber].size < level.squad_max_size) {
      var_1 = squadfindnearbysquadtomergewith();
      squadmerge(self.squadnumber, var_1);
    }

    level.squads[self.squadnumber].nextsquadmergechecktime = var_0 + 3000;
  }
}

findorcreatesquad() {
  if(!isDefined(level.squads) || level.squads.size == 0)
    return squadcreateandadd(self);

  var_0 = findnearestsquad(-1, 0);

  if(var_0 == -1)
    return squadcreateandadd(self);

  addtosquad(var_0, self);
}

findnearestsquad(var_0, var_1) {
  if(!isDefined(level.squads) || level.squads.size == 0)
    return -1;

  var_2 = -1;
  var_3 = 100000000;
  var_4 = level.squads[var_0];

  foreach(var_8, var_6 in level.squads) {
    var_6 = var_6.members;

    if(var_8 == var_0) {
      continue;
    }
    if(var_6.size >= level.squad_max_size) {
      continue;
    }
    if(!isalive(var_6[0])) {
      continue;
    }
    if(var_6[0].team != self.team) {
      continue;
    }
    var_7 = distancesquared(var_6[0].origin, self.origin);

    if(var_1) {
      if(var_7 > 1000000) {
        continue;
      }
      if(var_6.size + level.squads[var_0].members.size > level.squad_max_size)
        continue;
    } else if(var_7 > 160000) {
      continue;
    }
    if(var_7 < var_3) {
      var_3 = var_7;
      var_2 = var_6[0].squadnumber;
    }
  }

  return var_2;
}

squadfindnearbysquadtomergewith() {
  return findnearestsquad(self.squadnumber, 1);
}

squadremoveondeath(var_0) {
  self endon("squad_removed");
  self waittill("death");

  if(!isDefined(self)) {
    level.squads[var_0].members = scripts\engine\utility::array_removeundefined(level.squads[var_0].members);

    if(level.squads[var_0].members.size == 0)
      level.squads[var_0] = undefined;

    return;
  }

  removefromsquad(self.squadnumber, self);
}