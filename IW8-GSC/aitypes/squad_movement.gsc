/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\squad_movement.gsc
***********************************************/

shouldupdatesquadleadermovement(var_0) {
  if(!scripts\aitypes\squad::isinsquad() || !scripts\aitypes\squad::issquadleader())
    return anim.failure;

  if(!isDefined(self.enemy))
    return anim.failure;

  if(!self isingoal(self.origin))
    return anim.failure;

  if(gettime() < level.squads[self.squadnumber].nextsquadmovementtime)
    return anim.failure;

  if(!havesquadmemberscompletedmove() && gettime() < level.squads[self.squadnumber].nextforcedgroupmovementtime)
    return anim.failure;

  return anim.success;
}

havesquadmemberscompletedmove() {
  var_0 = 1;

  for(var_1 = 0; var_1 < level.squads[self.squadnumber].members.size; var_1++) {
    var_2 = level.squads[self.squadnumber].members[var_1];

    if(var_2.squadmovementallowed || var_2 codemoverequested()) {
      var_3 = 1000000;

      if(isDefined(var_2.pathgoalpos)) {
        if(distancesquared(var_2.origin, var_2.pathgoalpos) < var_3)
          return 0;
      }

      continue;
    }

    var_0 = 0;
  }

  return !var_0;
}

updatesquadleadermovement(var_0) {
  if(getDvar("scr_ai_squad_move_type", "0") == "1")
    updatedistance();
  else
    updategroups();

  return anim.failure;
}

updategroups() {
  var_0 = [];

  if(level.squads[self.squadnumber].squadmovecounter == 0)
    var_0 = level.squads[self.squadnumber].secondarygroup;
  else
    var_0 = level.squads[self.squadnumber].leadergroup;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 isclosetogoal()) {
      continue;
    }
    var_2.squadmovementallowed = 1;
    var_2 thread monitorsquadmovement();
  }

  level.squads[self.squadnumber].squadmovecounter++;

  if(level.squads[self.squadnumber].squadmovecounter > 1)
    level.squads[self.squadnumber].squadmovecounter = 0;

  level.squads[self.squadnumber].nextsquadmovementtime = gettime() + 4000;
  level.squads[self.squadnumber].nextforcedgroupmovementtime = gettime() + 8000;
}

updatedistance() {
  var_0 = level.squads[self.squadnumber].members.size;
  var_1 = level.squads[self.squadnumber];
  var_2 = vectorNormalize(self.enemy.origin - self.origin);
  var_3 = [];

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_5 = var_1.members[var_4];

    if(istrue(var_5.squadmovementallowed) || var_5 codemoverequested())
      return anim.failure;

    if(var_5 == self) {
      continue;
    }
    if(var_5 isclosetogoal()) {
      continue;
    }
    var_6 = var_5.origin - self.origin;
    var_7 = vectordot(var_2, var_6);

    if(var_7 < 400)
      var_3[var_3.size] = var_5;
  }

  var_8 = var_3.size;
  var_9 = 1;

  if(isclosetogoal()) {
    var_9 = min(var_8, 3);
    var_1.squadmovecounter++;
  } else if(var_1.squadmovecounter < 4 && var_8 > 1) {
    var_9 = min(var_8 - 1, 3);
    var_1.squadmovecounter++;
  } else {
    var_9 = min(1, var_3.size);
    self.squadmovementallowed = 1;
    var_1.squadmovecounter = 0;
    thread monitorsquadmovement();
  }

  for(var_10 = 0; var_10 < var_9; var_10++) {
    var_3[var_10].squadmovementallowed = 1;
    var_3[var_10] thread monitorsquadmovement();
  }

  var_1.nextsquadmovementtime = gettime() + 4000;
  var_1.nextforcedgroupmovementtime = gettime() + 8000;
}

isclosetogoal() {
  if(!isDefined(self.node))
    return 0;

  if(isDefined(self.enemy)) {
    var_0 = length(self.enemy.origin - self.origin);

    if(var_0 > self.engagemindist && var_0 < self.engagemaxdist)
      return 1;
  }

  return 0;
}

monitorsquadmovement() {
  self endon("death");
  var_0 = gettime() + 3000;

  while(!self codemoverequested() && gettime() < var_0) {
    if(!self.squadmovementallowed) {
      return;
    }
    waitframe();
  }

  var_1 = 4096;

  while(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > var_1) {
    if(!self.squadmovementallowed) {
      return;
    }
    waitframe();
  }

  self.squadmovementallowed = 0;
}