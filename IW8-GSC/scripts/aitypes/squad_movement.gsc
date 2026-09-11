/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\squad_movement.gsc
***********************************************/

function shouldupdatesquadleadermovement(var0) {
  if(!scripts\aitypes\squad::isinsquad() || !scripts\aitypes\squad::issquadleader()) {
    return anim.failure;
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(!self isingoal(self.origin)) {
    return anim.failure;
  }

  if(gettime() < level.squads[self.squadnumber].nextsquadmovementtime) {
    return anim.failure;
  }

  if(!havesquadmemberscompletedmove() && gettime() < level.squads[self.squadnumber].nextforcedgroupmovementtime) {
    return anim.failure;
  }

  return anim.success;
}

function havesquadmemberscompletedmove() {
  var0 = 1;

  for(var1 = 0; var1 < level.squads[self.squadnumber].members.size; var1++) {
    var2 = level.squads[self.squadnumber].members[var1];

    if(var2.squadmovementallowed || var2 codemoverequested()) {
      var3 = 1000000;

      if(isDefined(var2.pathgoalpos)) {
        if(distancesquared(var2.origin, var2.pathgoalpos) < var3) {
          return false;
        }
      }

      continue;
    }

    var0 = 0;
  }

  return !var0;
}

function updatesquadleadermovement(var0) {
  if(getDvar("scr_ai_squad_move_type", "0") == "1") {
    updatedistance();
  } else {
    updategroups();
  }

  return anim.failure;
}

function updategroups() {
  var0 = [];

  if(level.squads[self.squadnumber].squadmovecounter == 0) {
    var0 = level.squads[self.squadnumber].secondarygroup;
  } else {
    var0 = level.squads[self.squadnumber].leadergroup;
  }

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];

    if(isclosetogoal(var2)) {
      continue;
    }

    var2.squadmovementallowed = 1;
    thread monitorsquadmovement();
  }

  level.squads[self.squadnumber].squadmovecounter++;

  if(level.squads[self.squadnumber].squadmovecounter > 1) {
    level.squads[self.squadnumber].squadmovecounter = 0;
  }

  level.squads[self.squadnumber].nextsquadmovementtime = gettime() + 4000;
  level.squads[self.squadnumber].nextforcedgroupmovementtime = gettime() + 8000;
}

function updatedistance() {
  var0 = level.squads[self.squadnumber].members.size;
  var1 = level.squads[self.squadnumber];
  var2 = vectorNormalize(self.enemy.origin - self.origin);
  var3 = [];

  for(var4 = 0; var4 < var0; var4++) {
    var5 = var1.members[var4];

    if(istrue(var5.squadmovementallowed) || var5 codemoverequested()) {
      return anim.failure;
    }

    if(var5 == self) {
      continue;
    }

    if(isclosetogoal(var5)) {
      continue;
    }

    var6 = var5.origin - self.origin;
    var7 = vectordot(var2, var6);

    if(var7 < 400) {
      var3 = var5;
    }
  }

  var8 = var3.size;
  var9 = 1;

  if(isclosetogoal()) {
    var9 = min(var8, 3);
    var1.squadmovecounter++;
  } else if(var1.squadmovecounter < 4 && var8 > 1) {
    var9 = min(var8 - 1, 3);
    var1.squadmovecounter++;
  } else {
    var9 = min(1, var3.size);
    self.squadmovementallowed = 1;
    var1.squadmovecounter = 0;
    thread monitorsquadmovement();
  }

  for(var10 = 0; var10 < var9; var10++) {
    var3[var10].squadmovementallowed = 1;
    thread monitorsquadmovement();
  }

  var1.nextsquadmovementtime = gettime() + 4000;
  var1.nextforcedgroupmovementtime = gettime() + 8000;
}

function isclosetogoal() {
  if(!isDefined(self.node)) {
    return false;
  }

  if(isDefined(self.enemy)) {
    var0 = length(self.enemy.origin - self.origin);

    if(var0 > self.engagemindist && var0 < self.engagemaxdist) {
      return true;
    }
  }

  return false;
}

function monitorsquadmovement() {
  self endon("death");
  var0 = gettime() + 3000;

  while(!self codemoverequested() && gettime() < var0) {
    if(!self.squadmovementallowed) {
      return;
    }

    waitframe();
  }

  var1 = 4096;

  while(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > var1) {
    if(!self.squadmovementallowed) {
      return;
    }

    waitframe();
  }

  self.squadmovementallowed = 0;
}