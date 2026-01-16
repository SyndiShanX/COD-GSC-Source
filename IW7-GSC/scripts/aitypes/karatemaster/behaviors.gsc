/******************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\karatemaster\behaviors.gsc
******************************************************/

init(var_0) {
  var_1 = gettime();
  self.bt.nextteleporttime = var_1 + 1000;
  self.bt.lastflyingkicktime = 0;
  self.bt.lastthrowtime = var_1;
  return anim.success;
}

pickdesiredmeleeanimindex(var_0) {
  var_1 = var_0 + "_melee";

  if(isDefined(level.karatemastermeleedist[var_1])) {
    var_2 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();

    if(isDefined(var_2)) {
      var_3 = [];
      var_4 = distance2dsquared(self.origin, var_2.origin);

      for(var_5 = 0; var_5 < level.karatemastermeleedist[var_1].size; var_5++) {
        var_6 = level.karatemastermeleedist[var_1][var_5];

        if(var_6 * var_6 < var_4) {
          var_3[var_3.size] = var_5;
          continue;
        }

        break;
      }

      var_5 = 0;

      if(var_3.size > 0) {
        var_7 = randomint(var_3.size);
        var_5 = var_3[var_7];
        self.desiredmovemeleeindex[var_1] = var_5;
      }

      self.desiredmovemeleedist = level.karatemastermeleedist[var_1][var_5] + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cwiggleroom;
      self.desiredmovemeleetimetoimpact = level.karatemastermeleetimetoimpact[var_1][var_5];
    }

    self.lastdesiredmovemeleetime = gettime();
  }
}

pickbetterenemy(var_0, var_1) {
  var_2 = self cansee(var_0);
  var_3 = self cansee(var_1);

  if(var_2 != var_3) {
    if(var_2) {
      return var_0;
    }

    return var_1;
  }

  var_4 = distancesquared(self.origin, var_0.origin);
  var_5 = distancesquared(self.origin, var_1.origin);

  if(var_4 < var_5) {
    return var_0;
  }

  return var_1;
}

shouldignoreenemy(var_0) {
  if(!isalive(var_0)) {
    return 1;
  }

  if(var_0.ignoreme || isDefined(var_0.owner) && var_0.owner.ignoreme) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_0)) {
    return 1;
  }

  return 0;
}

updateenemy() {
  if(isDefined(self.myenemy) && !shouldignoreenemy(self.myenemy)) {
    if(gettime() - self.myenemystarttime < 3000) {
      return self.myenemy;
    }
  }

  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(shouldignoreenemy(var_2)) {
      continue;
    }
    if(scripts\engine\utility::is_true(var_2.isfasttravelling)) {
      continue;
    }
    if(!isDefined(var_0)) {
      var_0 = var_2;
      continue;
    }

    var_0 = pickbetterenemy(var_0, var_2);
  }

  if(!isDefined(var_0)) {
    self.myenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.myenemy) || var_0 != self.myenemy) {
    self.myenemy = var_0;
    self.myenemystarttime = gettime();
  }
}

updateeveryframe(var_0) {
  scripts\asm\asm_bb::bb_requestmovetype(self.desiredmovemode);
  updateenemy();

  if(!isDefined(self.desiredmovemeleeindex[self.desiredmovemode])) {
    pickdesiredmeleeanimindex(self.desiredmovemode);
  }

  return anim.failure;
}

candostandmelee() {
  if(isDefined(self.pathgoalpos)) {
    return 0;
  }

  return 1;
}

getmovemeleedistsq() {
  if(isDefined(self.desiredmovemeleedist)) {
    return self.desiredmovemeleedist * self.desiredmovemeleedist;
  }

  return scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cmeleemaxstanddistsq;
}

getpredictedenemypos() {
  var_0 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  var_1 = var_0 getvelocity();
  var_2 = length2d(var_1);
  var_3 = self.desiredmovemeleetimetoimpact;
  var_4 = var_0.origin + var_1 * var_3;
  return var_4;
}

getstandmeleeattackswithinrange(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();

  for(var_4 = level.karatemastermeleedist["stand_melee"].size - 1; var_4 >= 0; var_4--) {
    var_5 = var_0 + var_1 * level.karatemastermeleetimetoimpact["stand_melee"][var_4];
    var_6 = distance2d(var_5, self.origin);

    if(var_6 > level.karatemastermeleedist["stand_melee"][var_4] + var_3.cstandattackwiggleroom) {
      break;
    }

    var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0) {
    return undefined;
  }

  return var_2;
}

pickstandmeleeattack(var_0) {
  var_1 = getstandmeleeattackswithinrange(var_0.origin, var_0 getvelocity());

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = randomint(var_1.size);
  var_3 = var_1[var_2];
  self.desiredmovemeleeindex["stand_melee"] = var_3;
  self.desiredmovemeleedist = level.karatemastermeleedist["stand_melee"][var_3] + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cwiggleroom;
  self.desiredmovemeleetimetoimpact = level.karatemastermeleetimetoimpact["stand_melee"][var_3];
  self._blackboard.meleetype = "stand_melee";
  return 1;
}

shouldmelee(var_0) {
  var_1 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(abs(var_1.origin[2] - self.origin[2]) > scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cmeleemaxzdiff) {
    return anim.failure;
  }

  if(candostandmelee()) {
    if(!pickstandmeleeattack(var_1)) {
      return anim.failure;
    }

    return anim.success;
  }

  var_2 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  var_3 = var_1.origin;

  if(isDefined(self.pathgoalpos)) {
    var_3 = getpredictedenemypos();
  }

  if(gettime() > self.lastdesiredmovemeleetime + var_2.crethinkmovemeleetime) {
    pickdesiredmeleeanimindex(self.desiredmovemode);
  }

  var_4 = distance2dsquared(var_3, self.origin);

  if(var_4 > getmovemeleedistsq()) {
    return anim.failure;
  }

  var_5 = self func_84AC();
  var_6 = getclosestpointonnavmesh(var_1.origin, self);

  if(!func_2AC(var_5, var_6, self)) {
    return anim.failure;
  }

  self._blackboard.meleetype = self.desiredmovemode + "_melee";
  return anim.success;
}

melee_init(var_0) {
  var_1 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].meleetarget = var_1;
  self.bt.instancedata[var_0].starttime = gettime();
  self._blackboard.bmeleerequested = 1;
  self._blackboard.meleetarget = var_1;
  self.curmeleetarget = var_1;
}

domelee(var_0) {
  var_1 = 5000;

  if(gettime() > self.bt.instancedata[var_0].starttime + var_1) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_anim", "end")) {
    return anim.success;
  }

  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(36);
  return anim.running;
}

melee_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self._blackboard.bmeleerequested = undefined;
  self._blackboard.meleetarget = undefined;
  self._blackboard.meleetype = undefined;
  var_1 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  var_2 = gettime() + var_1.cminteleportwaittimeaftermelee;

  if(!isDefined(self.bt.nextteleporttime) || self.bt.nextteleporttime <= var_2) {
    self.bt.nextteleporttime = var_2;
  }

  pickdesiredmeleeanimindex(self.desiredmovemode);
}

ispositiontooclosetoaplayer(var_0) {
  foreach(var_2 in level.players) {
    var_3 = abs(var_2.origin[2] - var_0[2]);

    if(var_3 > 128) {
      continue;
    }
    var_4 = distancesquared(var_0, var_2.origin);

    if(var_4 < 10000) {
      return 1;
    }
  }

  return 0;
}

findteleportspotinfrontofsprinter(var_0, var_1) {
  var_2 = var_0.angles[1];
  var_3 = var_0.angles;
  var_4 = undefined;

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_6 = randomintrange(var_1.csprinterteleportminangledelta, var_1.csprinterteleportmaxangledelta);

    if(randomint(100) < 50) {
      var_6 = var_6 * -1;
    }

    var_7 = randomfloatrange(var_1.csprinterteleportmindist, var_1.csprinterteleportmaxdist);
    var_8 = angleclamp180(var_3[1] + var_6);
    var_9 = anglesToForward((0, var_8, 0));
    var_10 = var_0.origin + var_9 * var_7;
    var_4 = getclosestpointonnavmesh(var_10, self);

    if(ispositiontooclosetoaplayer(var_4)) {
      var_4 = undefined;
      continue;
    }

    if(func_2AC(var_4, var_0.origin)) {
      break;
    }

    var_4 = undefined;
  }

  if(!isDefined(var_4)) {
    return undefined;
  }

  var_11 = self findpath(var_4, var_0.origin, 0, 0, "seeker");

  if(!isDefined(var_11) || var_11.size < 2) {
    self.bt.nextteleporttime = gettime() + 150;
    return undefined;
  }

  var_12 = getgroundposition(var_4, 8);

  if(abs(var_12[2] - var_4[2]) > 60) {
    return undefined;
  }

  return var_12;
}

findteleportspotinenemyview(var_0, var_1) {
  var_2 = var_0.angles[1];
  var_3 = var_0.angles;
  var_4 = var_0.origin + var_0 getvelocity() * 0.5;
  var_5 = distance(self.origin, var_4);
  var_6 = undefined;

  for(var_7 = 0; var_7 < 4; var_7++) {
    var_8 = randomintrange(var_1.cfastteleportminangledelta, var_1.cfastteleportmaxangledelta);

    if(randomint(100) < 50) {
      var_8 = var_8 * -1;
    }

    var_9 = randomfloatrange(var_1.cfastteleportcloseindistpctmin, var_1.cfastteleportcloseindistpctmax);
    var_10 = var_5 * var_9;

    if(var_10 < var_1.cfastteleportmindisttoenemytoteleport) {
      var_10 = var_1.cfastteleportmindisttoenemytoteleport;
    }

    var_11 = angleclamp180(var_3[1] + var_8);
    var_12 = anglesToForward((0, var_11, 0));
    var_13 = var_4 + var_12 * var_10;
    var_6 = getclosestpointonnavmesh(var_13, self);

    if(!isDefined(var_6)) {
      continue;
    }
    if(ispositiontooclosetoaplayer(var_6)) {
      var_6 = undefined;
      continue;
    }

    break;
  }

  if(!isDefined(var_6)) {
    return undefined;
  }

  var_14 = self findpath(var_6, var_0.origin, 0, 0);

  if(!isDefined(var_14) || var_14.size < 2) {
    return undefined;
  }

  var_15 = getgroundposition(var_6, 8);

  if(abs(var_15[2] - var_6[2]) > 60) {
    return undefined;
  }

  return var_15;
}

findbunchedupteleportspot(var_0, var_1) {
  return findteleportspotinenemyview(var_0, var_1.bunchedupteleportparams);
}

iscrowded(var_0, var_1) {
  var_2 = scripts\mp\mp_agent::getactiveagentsoftype(self.agent_type);
  var_3 = [];
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_7 = distancesquared(var_6.origin, self.origin);

    if(var_7 > var_1.ccrowdedradiussq) {
      continue;
    }
    if(!var_6 scripts\asm\asm::asm_isinstate("run_loop") && !var_6 scripts\asm\asm::asm_isinstate("sprint_loop") && !var_6 scripts\asm\asm::asm_isinstate("walk_loop") && !var_6 scripts\asm\asm::asm_isinstate("slow_walk_loop")) {
      continue;
    }
    if(isDefined(var_6.enemy) && var_6.enemy == var_0) {
      var_4++;
    }
  }

  if(var_4 >= var_1.ccrowdedcount) {
    return 1;
  }

  return 0;
}

getfastteleportdest(var_0, var_1) {
  if(scripts\asm\asm::asm_isinstate("teleport_in")) {
    return undefined;
  }

  if(scripts\asm\asm::asm_isinstate("teleport_out")) {
    return undefined;
  }

  var_2 = distance(var_0.origin, self.origin);

  if(!isDefined(self.pathgoalpos) || var_2 > var_1.cminenemydistforlongpathteleport) {
    if(!isDefined(self.pathgoalpos) || self pathdisttogoal() > var_2 * var_1.cfastteleportduetolongpathmultiplier) {
      var_3 = findteleportspotinenemyview(var_0, var_1.fastteleportparams);

      if(isDefined(var_3)) {
        return var_3;
      }
    }
  }

  var_4 = scripts\mp\agents\karatemaster\karatemaster_agent::getdamageaccumulator();

  if(isDefined(var_4)) {
    if(var_1.cfastteleportduetodamagechance > 0 && var_4.accumulateddamage > 0) {
      var_5 = var_4.accumulateddamage / self.maxhealth;

      if(var_5 >= var_1.cfastteleportdamagepct) {
        scripts\mp\agents\karatemaster\karatemaster_agent::cleardamageaccumulator();
        var_6 = randomint(100);

        if(var_6 < var_1.cfastteleportduetodamagechance) {
          self._blackboard.bfastteleport = 1;
          return findteleportspotinenemyview(var_0, var_1.fastteleportparams);
        }
      }
    }
  }

  if(var_1.ballowteleportinfrontofsprinter && var_0 issprinting()) {
    var_7 = var_0.origin - self.origin;
    var_8 = anglesToForward(var_0.angles);
    var_9 = vectordot(var_7, var_8);

    if(var_9 > 0) {
      var_10 = findteleportspotinfrontofsprinter(var_0, var_1.sprinterteleportparams);

      if(isDefined(var_10)) {
        self._blackboard.bfastteleport = 1;
        return var_10;
      }
    }
  }

  if(iscrowded(var_0, var_1)) {
    self._blackboard.bfastteleport = 1;

    if(!var_0 issprinting()) {
      var_11 = var_0 getvelocity();
      var_12 = length2dsquared(var_11);

      if(var_12 > 16129) {
        var_7 = vectornormalize(var_0.origin - self.origin);
        var_8 = anglesToForward(var_0.angles);
        var_13 = vectordot(var_7, var_8);
        var_14 = vectornormalize(var_11);
        var_15 = vectordot(var_8, var_14);

        if(var_13 > var_1.cplayerfacingawayfrommedot && var_15 > 0.9) {
          var_10 = findteleportspotinfrontofsprinter(var_0, var_1.runnerteleportparams);

          if(isDefined(var_10)) {
            self._blackboard.bfastteleport = 1;
            return var_10;
          }
        }
      }
    }

    return findbunchedupteleportspot(var_0, var_1);
  }

  return undefined;
}

shouldteleport(var_0) {
  if(scripts\engine\utility::is_true(self.bdisableteleport)) {
    return anim.failure;
  }

  var_1 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  if(gettime() < self.bt.nextteleporttime) {
    return anim.failure;
  }

  var_2 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();

  if(!isDefined(level.last_karatemaster_teleport_time)) {
    level.last_karatemaster_teleport_time = gettime();
  } else if(gettime() - level.last_karatemaster_teleport_time < var_2.cteleportmintimebetween_global) {
    return anim.failure;
  }

  if(isDefined(self.pathgoalpos)) {
    var_3 = self pathdisttogoal();
    var_4 = self func_84F9(var_3);

    if(isDefined(var_4)) {
      var_5 = var_4["node"];
      var_6 = var_4["position"];
      var_7 = var_5.animscript;

      if(isDefined(var_7)) {
        var_8 = self.asmname;
        var_9 = anim.asm[var_8];
        var_10 = var_9.states[var_7];

        if(!isDefined(var_10)) {
          var_7 = "traverse_external";
        }

        if(var_7 == "traverse_external") {
          self.initialteleportpos = var_6;
          self.btraversalteleport = 1;
          level.last_karatemaster_teleport_time = gettime();
          return anim.success;
        }
      }
    }
  }

  if(scripts\engine\utility::is_true(self.is_traversing)) {
    return anim.failure;
  }

  self.initialteleportpos = getfastteleportdest(var_1, var_2);

  if(isDefined(self.initialteleportpos)) {
    level.last_karatemaster_teleport_time = gettime();
    return anim.success;
  }

  return anim.failure;
}

teleport_init(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0].starttime = gettime();

  if(scripts\engine\utility::is_true(self._blackboard.bfastteleport) || scripts\engine\utility::is_true(self.btraversalteleport)) {
    var_1 = self.initialteleportpos;
  } else {
    var_1 = scripts\mp\agents\karatemaster\karatemaster_agent::findgoodteleportcloserspot();
  }

  self.bt.instancedata[var_0].teleportspot = var_1;

  if(isDefined(var_1)) {
    self._blackboard.bteleportrequested = 1;
    self._blackboard.teleportspot = var_1;
  }

  self clearpath();
}

doteleport(var_0) {
  if(!isDefined(self.bt.instancedata[var_0].teleportspot)) {
    return anim.failure;
  }

  var_1 = 10000;

  if(gettime() > self.bt.instancedata[var_0].starttime + var_1) {
    return anim.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("teleport_anim", "end")) {
    self.bt.nextteleporttime = gettime() + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cteleportmintimebetween;
    return anim.success;
  }

  return anim.running;
}

teleport_cleanup(var_0) {
  self.bt.instancedata[var_0] = undefined;
  self._blackboard.bteleportrequested = undefined;
  self._blackboard.teleportspot = undefined;
}

followenemy_begin(var_0) {
  self.bt.instancedata[var_0] = gettime();
}

findclosestenemy() {
  var_0 = 99999999;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3.ignoreme || isDefined(var_3.owner) && var_3.owner.ignoreme) {
      continue;
    }
    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_3)) {
      continue;
    }
    var_4 = distancesquared(self.origin, var_3.origin);

    if(!isDefined(var_1) || var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_1;
}

followenemy_tick(var_0) {
  var_1 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();

  if(!isDefined(var_1)) {
    var_1 = findclosestenemy();
  }

  if(!isDefined(var_1)) {
    return anim.failure;
  }

  var_2 = gettime();

  if(var_2 >= self.bt.instancedata[var_0] || distancesquared(self.origin, var_1.origin) < 10000) {
    var_3 = getclosestpointonnavmesh(var_1.origin, self);
    self scragentsetgoalpos(var_3);
    self.bt.instancedata[var_0] = var_2 + 200;
  }

  return anim.running;
}

followenemy_end(var_0) {
  self.bt.instancedata[var_0] = undefined;
}

spawnkaratemaster(var_0) {
  var_0 endon("death");
}