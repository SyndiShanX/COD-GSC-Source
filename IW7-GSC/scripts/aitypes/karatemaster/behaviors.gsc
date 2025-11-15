/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\karatemaster\behaviors.gsc
******************************************************/

init(param_00) {
  var_01 = gettime();
  self.var_3135.nextteleporttime = var_01 + 1000;
  self.var_3135.lastflyingkicktime = 0;
  self.var_3135.lastthrowtime = var_01;
  return level.success;
}

pickdesiredmeleeanimindex(param_00) {
  var_01 = param_00 + "_melee";
  if(isDefined(level.karatemastermeleedist[var_01])) {
    var_02 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
    if(isDefined(var_02)) {
      var_03 = [];
      var_04 = distance2dsquared(self.origin, var_02.origin);
      for(var_05 = 0; var_05 < level.karatemastermeleedist[var_01].size; var_05++) {
        var_06 = level.karatemastermeleedist[var_01][var_05];
        if(var_06 * var_06 < var_04) {
          var_03[var_03.size] = var_05;
          continue;
        }

        break;
      }

      var_05 = 0;
      if(var_03.size > 0) {
        var_07 = randomint(var_03.size);
        var_05 = var_03[var_07];
        self.desiredmovemeleeindex[var_01] = var_05;
      }

      self.desiredmovemeleedist = level.karatemastermeleedist[var_01][var_05] + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cwiggleroom;
      self.desiredmovemeleetimetoimpact = level.karatemastermeleetimetoimpact[var_01][var_05];
    }

    self.lastdesiredmovemeleetime = gettime();
  }
}

pickbetterenemy(param_00, param_01) {
  var_02 = self getpersstat(param_00);
  var_03 = self getpersstat(param_01);
  if(var_02 != var_03) {
    if(var_02) {
      return param_00;
    }

    return param_01;
  }

  var_04 = distancesquared(self.origin, param_00.origin);
  var_05 = distancesquared(self.origin, param_01.origin);
  if(var_04 < var_05) {
    return param_00;
  }

  return param_01;
}

shouldignoreenemy(param_00) {
  if(!isalive(param_00)) {
    return 1;
  }

  if(param_00.ignoreme || isDefined(param_00.triggerportableradarping) && param_00.triggerportableradarping.ignoreme) {
    return 1;
  }

  if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(param_00)) {
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

  var_00 = undefined;
  foreach(var_02 in level.players) {
    if(shouldignoreenemy(var_02)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_02.isfasttravelling)) {
      continue;
    }

    if(!isDefined(var_00)) {
      var_00 = var_02;
      continue;
    }

    var_00 = pickbetterenemy(var_00, var_02);
  }

  if(!isDefined(var_00)) {
    self.myenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.myenemy) || var_00 != self.myenemy) {
    self.myenemy = var_00;
    self.myenemystarttime = gettime();
  }
}

updateeveryframe(param_00) {
  scripts\asm\asm_bb::bb_requestmovetype(self.desiredmovemode);
  updateenemy();
  if(!isDefined(self.desiredmovemeleeindex[self.desiredmovemode])) {
    pickdesiredmeleeanimindex(self.desiredmovemode);
  }

  return level.failure;
}

candostandmelee() {
  if(isDefined(self.vehicle_getspawnerarray)) {
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
  var_00 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  var_01 = var_00 getvelocity();
  var_02 = length2d(var_01);
  var_03 = self.desiredmovemeleetimetoimpact;
  var_04 = var_00.origin + var_01 * var_03;
  return var_04;
}

getstandmeleeattackswithinrange(param_00, param_01) {
  var_02 = [];
  var_03 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  for(var_04 = level.karatemastermeleedist["stand_melee"].size - 1; var_04 >= 0; var_04--) {
    var_05 = param_00 + param_01 * level.karatemastermeleetimetoimpact["stand_melee"][var_04];
    var_06 = distance2d(var_05, self.origin);
    if(var_06 > level.karatemastermeleedist["stand_melee"][var_04] + var_03.cstandattackwiggleroom) {
      break;
    }

    var_02[var_02.size] = var_04;
  }

  if(var_02.size == 0) {
    return undefined;
  }

  return var_02;
}

pickstandmeleeattack(param_00) {
  var_01 = getstandmeleeattackswithinrange(param_00.origin, param_00 getvelocity());
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = randomint(var_01.size);
  var_03 = var_01[var_02];
  self.desiredmovemeleeindex["stand_melee"] = var_03;
  self.desiredmovemeleedist = level.karatemastermeleedist["stand_melee"][var_03] + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cwiggleroom;
  self.desiredmovemeleetimetoimpact = level.karatemastermeleetimetoimpact["stand_melee"][var_03];
  self.var_1198.meleetype = "stand_melee";
  return 1;
}

shouldmelee(param_00) {
  var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  if(abs(var_01.origin[2] - self.origin[2]) > scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cmeleemaxzdiff) {
    return level.failure;
  }

  if(candostandmelee()) {
    if(!pickstandmeleeattack(var_01)) {
      return level.failure;
    }

    return level.success;
  }

  var_02 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  var_03 = var_01.origin;
  if(isDefined(self.vehicle_getspawnerarray)) {
    var_03 = getpredictedenemypos();
  }

  if(gettime() > self.lastdesiredmovemeleetime + var_02.crethinkmovemeleetime) {
    pickdesiredmeleeanimindex(self.desiredmovemode);
  }

  var_04 = distance2dsquared(var_03, self.origin);
  if(var_04 > getmovemeleedistsq()) {
    return level.failure;
  }

  var_05 = self _meth_84AC();
  var_06 = getclosestpointonnavmesh(var_01.origin, self);
  if(!navisstraightlinereachable(var_05, var_06, self)) {
    return level.failure;
  }

  self.var_1198.meleetype = self.desiredmovemode + "_melee";
  return level.success;
}

melee_init(param_00) {
  var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  self.var_3135.instancedata[param_00] = spawnStruct();
  self.var_3135.instancedata[param_00].meleetarget = var_01;
  self.var_3135.instancedata[param_00].starttime = gettime();
  self.var_1198.bmeleerequested = 1;
  self.var_1198.meleetarget = var_01;
  self.curmeleetarget = var_01;
}

domelee(param_00) {
  var_01 = 5000;
  if(gettime() > self.var_3135.instancedata[param_00].starttime + var_01) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("melee_anim", "end")) {
    return level.success;
  }

  self ghostskulls_complete_status(self.origin);
  self ghostskulls_total_waves(36);
  return level.running;
}

melee_cleanup(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
  self.var_1198.bmeleerequested = undefined;
  self.var_1198.meleetarget = undefined;
  self.var_1198.meleetype = undefined;
  var_01 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  var_02 = gettime() + var_01.cminteleportwaittimeaftermelee;
  if(!isDefined(self.var_3135.nextteleporttime) || self.var_3135.nextteleporttime <= var_02) {
    self.var_3135.nextteleporttime = var_02;
  }

  pickdesiredmeleeanimindex(self.desiredmovemode);
}

ispositiontooclosetoaplayer(param_00) {
  foreach(var_02 in level.players) {
    var_03 = abs(var_02.origin[2] - param_00[2]);
    if(var_03 > 128) {
      continue;
    }

    var_04 = distancesquared(param_00, var_02.origin);
    if(var_04 < 10000) {
      return 1;
    }
  }

  return 0;
}

findteleportspotinfrontofsprinter(param_00, param_01) {
  var_02 = param_00.angles[1];
  var_03 = param_00.angles;
  var_04 = undefined;
  for(var_05 = 0; var_05 < 5; var_05++) {
    var_06 = randomintrange(param_01.csprinterteleportminangledelta, param_01.csprinterteleportmaxangledelta);
    if(randomint(100) < 50) {
      var_06 = var_06 * -1;
    }

    var_07 = randomfloatrange(param_01.csprinterteleportmindist, param_01.csprinterteleportmaxdist);
    var_08 = angleclamp180(var_03[1] + var_06);
    var_09 = anglesToForward((0, var_08, 0));
    var_0A = param_00.origin + var_09 * var_07;
    var_04 = getclosestpointonnavmesh(var_0A, self);
    if(ispositiontooclosetoaplayer(var_04)) {
      var_04 = undefined;
      continue;
    }

    if(navisstraightlinereachable(var_04, param_00.origin)) {
      break;
    }

    var_04 = undefined;
  }

  if(!isDefined(var_04)) {
    return undefined;
  }

  var_0B = self findpath(var_04, param_00.origin, 0, 0, "seeker");
  if(!isDefined(var_0B) || var_0B.size < 2) {
    self.var_3135.nextteleporttime = gettime() + 150;
    return undefined;
  }

  var_0C = getgroundposition(var_04, 8);
  if(abs(var_0C[2] - var_04[2]) > 60) {
    return undefined;
  }

  return var_0C;
}

findteleportspotinenemyview(param_00, param_01) {
  var_02 = param_00.angles[1];
  var_03 = param_00.angles;
  var_04 = param_00.origin + param_00 getvelocity() * 0.5;
  var_05 = distance(self.origin, var_04);
  var_06 = undefined;
  for(var_07 = 0; var_07 < 4; var_07++) {
    var_08 = randomintrange(param_01.cfastteleportminangledelta, param_01.cfastteleportmaxangledelta);
    if(randomint(100) < 50) {
      var_08 = var_08 * -1;
    }

    var_09 = randomfloatrange(param_01.cfastteleportcloseindistpctmin, param_01.cfastteleportcloseindistpctmax);
    var_0A = var_05 * var_09;
    if(var_0A < param_01.cfastteleportmindisttoenemytoteleport) {
      var_0A = param_01.cfastteleportmindisttoenemytoteleport;
    }

    var_0B = angleclamp180(var_03[1] + var_08);
    var_0C = anglesToForward((0, var_0B, 0));
    var_0D = var_04 + var_0C * var_0A;
    var_06 = getclosestpointonnavmesh(var_0D, self);
    if(!isDefined(var_06)) {
      continue;
    }

    if(ispositiontooclosetoaplayer(var_06)) {
      var_06 = undefined;
      continue;
    }

    break;
  }

  if(!isDefined(var_06)) {
    return undefined;
  }

  var_0E = self findpath(var_06, param_00.origin, 0, 0);
  if(!isDefined(var_0E) || var_0E.size < 2) {
    return undefined;
  }

  var_0F = getgroundposition(var_06, 8);
  if(abs(var_0F[2] - var_06[2]) > 60) {
    return undefined;
  }

  return var_0F;
}

findbunchedupteleportspot(param_00, param_01) {
  return findteleportspotinenemyview(param_00, param_01.bunchedupteleportparams);
}

iscrowded(param_00, param_01) {
  var_02 = scripts\mp\mp_agent::getactiveagentsoftype(self.agent_type);
  var_03 = [];
  var_04 = 0;
  foreach(var_06 in var_02) {
    var_07 = distancesquared(var_06.origin, self.origin);
    if(var_07 > param_01.ccrowdedradiussq) {
      continue;
    }

    if(!var_06 scripts\asm\asm::asm_isinstate("run_loop") && !var_06 scripts\asm\asm::asm_isinstate("sprint_loop") && !var_06 scripts\asm\asm::asm_isinstate("walk_loop") && !var_06 scripts\asm\asm::asm_isinstate("slow_walk_loop")) {
      continue;
    }

    if(isDefined(var_06.isnodeoccupied) && var_06.isnodeoccupied == param_00) {
      var_04++;
    }
  }

  if(var_04 >= param_01.ccrowdedcount) {
    return 1;
  }

  return 0;
}

getfastteleportdest(param_00, param_01) {
  if(scripts\asm\asm::asm_isinstate("teleport_in")) {
    return undefined;
  }

  if(scripts\asm\asm::asm_isinstate("teleport_out")) {
    return undefined;
  }

  var_02 = distance(param_00.origin, self.origin);
  if(!isDefined(self.vehicle_getspawnerarray) || var_02 > param_01.cminenemydistforlongpathteleport) {
    if(!isDefined(self.vehicle_getspawnerarray) || self pathdisttogoal() > var_02 * param_01.cfastteleportduetolongpathmultiplier) {
      var_03 = findteleportspotinenemyview(param_00, param_01.fastteleportparams);
      if(isDefined(var_03)) {
        return var_03;
      }
    }
  }

  var_04 = scripts\mp\agents\karatemaster\karatemaster_agent::getdamageaccumulator();
  if(isDefined(var_04)) {
    if(param_01.cfastteleportduetodamagechance > 0 && var_04.accumulateddamage > 0) {
      var_05 = var_04.accumulateddamage / self.maxhealth;
      if(var_05 >= param_01.cfastteleportdamagepct) {
        scripts\mp\agents\karatemaster\karatemaster_agent::cleardamageaccumulator();
        var_06 = randomint(100);
        if(var_06 < param_01.cfastteleportduetodamagechance) {
          self.var_1198.bfastteleport = 1;
          return findteleportspotinenemyview(param_00, param_01.fastteleportparams);
        }
      }
    }
  }

  if(param_01.ballowteleportinfrontofsprinter && param_00 issprinting()) {
    var_07 = param_00.origin - self.origin;
    var_08 = anglesToForward(param_00.angles);
    var_09 = vectordot(var_07, var_08);
    if(var_09 > 0) {
      var_0A = findteleportspotinfrontofsprinter(param_00, param_01.sprinterteleportparams);
      if(isDefined(var_0A)) {
        self.var_1198.bfastteleport = 1;
        return var_0A;
      }
    }
  }

  if(iscrowded(param_00, param_01)) {
    self.var_1198.bfastteleport = 1;
    if(!param_00 issprinting()) {
      var_0B = param_00 getvelocity();
      var_0C = length2dsquared(var_0B);
      if(var_0C > 16129) {
        var_07 = vectornormalize(param_00.origin - self.origin);
        var_08 = anglesToForward(param_00.angles);
        var_0D = vectordot(var_07, var_08);
        var_0E = vectornormalize(var_0B);
        var_0F = vectordot(var_08, var_0E);
        if(var_0D > param_01.cplayerfacingawayfrommedot && var_0F > 0.9) {
          var_0A = findteleportspotinfrontofsprinter(param_00, param_01.runnerteleportparams);
          if(isDefined(var_0A)) {
            self.var_1198.bfastteleport = 1;
            return var_0A;
          }
        }
      }
    }

    return findbunchedupteleportspot(param_00, param_01);
  }

  return undefined;
}

shouldteleport(param_00) {
  if(scripts\engine\utility::istrue(self.bdisableteleport)) {
    return level.failure;
  }

  var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  if(!isDefined(var_01)) {
    return level.failure;
  }

  if(gettime() < self.var_3135.nextteleporttime) {
    return level.failure;
  }

  var_02 = scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata();
  if(!isDefined(level.last_karatemaster_teleport_time)) {
    level.last_karatemaster_teleport_time = gettime();
  } else if(gettime() - level.last_karatemaster_teleport_time < var_02.cteleportmintimebetween_global) {
    return level.failure;
  }

  if(isDefined(self.vehicle_getspawnerarray)) {
    var_03 = self pathdisttogoal();
    var_04 = self _meth_84F9(var_03);
    if(isDefined(var_04)) {
      var_05 = var_04["node"];
      var_06 = var_04["position"];
      var_07 = var_05.opcode::OP_ScriptMethodCallPointer;
      if(isDefined(var_07)) {
        var_08 = self.asmname;
        var_09 = level.asm[var_08];
        var_0A = var_09.states[var_07];
        if(!isDefined(var_0A)) {
          var_07 = "traverse_external";
        }

        if(var_07 == "traverse_external") {
          self.initialteleportpos = var_06;
          self.btraversalteleport = 1;
          level.last_karatemaster_teleport_time = gettime();
          return level.success;
        }
      }
    }
  }

  if(scripts\engine\utility::istrue(self.is_traversing)) {
    return level.failure;
  }

  self.initialteleportpos = getfastteleportdest(var_01, var_02);
  if(isDefined(self.initialteleportpos)) {
    level.last_karatemaster_teleport_time = gettime();
    return level.success;
  }

  return level.failure;
}

teleport_init(param_00) {
  self.var_3135.instancedata[param_00] = spawnStruct();
  self.var_3135.instancedata[param_00].starttime = gettime();
  if(scripts\engine\utility::istrue(self.var_1198.bfastteleport) || scripts\engine\utility::istrue(self.btraversalteleport)) {
    var_01 = self.initialteleportpos;
  } else {
    var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::findgoodteleportcloserspot();
  }

  self.var_3135.instancedata[param_00].teleportspot = var_01;
  if(isDefined(var_01)) {
    self.var_1198.bteleportrequested = 1;
    self.var_1198.teleportspot = var_01;
  }

  self clearpath();
}

doteleport(param_00) {
  if(!isDefined(self.var_3135.instancedata[param_00].teleportspot)) {
    return level.failure;
  }

  var_01 = 10000;
  if(gettime() > self.var_3135.instancedata[param_00].starttime + var_01) {
    return level.failure;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("teleport_anim", "end")) {
    self.var_3135.nextteleporttime = gettime() + scripts\mp\agents\karatemaster\karatemaster_tunedata::gettunedata().cteleportmintimebetween;
    return level.success;
  }

  return level.running;
}

teleport_cleanup(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
  self.var_1198.bteleportrequested = undefined;
  self.var_1198.teleportspot = undefined;
}

followenemy_begin(param_00) {
  self.var_3135.instancedata[param_00] = gettime();
}

findclosestenemy() {
  var_00 = 99999999;
  var_01 = undefined;
  foreach(var_03 in level.players) {
    if(!isalive(var_03)) {
      continue;
    }

    if(var_03.ignoreme || isDefined(var_03.triggerportableradarping) && var_03.triggerportableradarping.ignoreme) {
      continue;
    }

    if(scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_03)) {
      continue;
    }

    var_04 = distancesquared(self.origin, var_03.origin);
    if(!isDefined(var_01) || var_04 < var_00) {
      var_01 = var_03;
      var_00 = var_04;
    }
  }

  return var_01;
}

followenemy_tick(param_00) {
  var_01 = scripts\mp\agents\karatemaster\karatemaster_agent::getenemy();
  if(!isDefined(var_01)) {
    var_01 = findclosestenemy();
  }

  if(!isDefined(var_01)) {
    return level.failure;
  }

  var_02 = gettime();
  if(var_02 >= self.var_3135.instancedata[param_00] || distancesquared(self.origin, var_01.origin) < 10000) {
    var_03 = getclosestpointonnavmesh(var_01.origin, self);
    self ghostskulls_complete_status(var_03);
    self.var_3135.instancedata[param_00] = var_02 + 200;
  }

  return level.running;
}

followenemy_end(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
}

spawnkaratemaster(param_00) {
  param_00 endon("death");
}