/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\cover.gsc
***********************************************/

initcover(var_0) {
  self.bt.cover = spawnStruct();
  scripts\asm\asm_bb::bb_requestcoverstate("none");
  self.covernode = self.node;
  self.bt.cover.starttime = gettime();
  self.bt.cover.nextmayshuffletime = gettime() + randomintrange(3000, 7000);
  self._blackboard.lastusednode = self.node;

  if(isDefined(self._blackboard.deployedlmgnode)) {}

  scripts\asm\asm_bb::bb_setcovernode(self.covernode);
  self.couldntseeenemypos = self.origin;

  if(!isDefined(self.bt.cover.nextpossibleblindfiretime) || !isDefined(self._blackboard.shufflenode))
    setnextpossibleblindfiretime();

  setnextlookforcovertime();

  if(!isDefined(self.coverexposenoenemyangle))
    self.coverexposenoenemyangle = 30;

  if(!isDefined(self.coverexposenoenemytimemin))
    self.coverexposenoenemytimemin = 2;

  if(!isDefined(self.coverexposenoenemytimemax))
    self.coverexposenoenemytimemax = 3;

  if(!isDefined(self.coverexposelostenemytime))
    self.coverexposelostenemytime = 5;

  return anim.success;
}

initcoverbb(var_0) {
  self.bt.cover.taskid = var_0;
}

clearcoverbb(var_0) {
  if(isDefined(self.bt.cover) && self.bt.cover.taskid != var_0)
    return anim.success;

  if(scripts\asm\asm_bb::bb_hadcovernode()) {
    scripts\asm\asm_bb::bb_setcovernode(undefined);
    scripts\asm\asm_bb::bb_requestcoverstate("hide");
    self._blackboard.deployedlmgnode = undefined;

    if(isDefined(self.pathgoalpos) || self._blackboard.desiredstance == "prone") {
      var_1 = scripts\asm\shared\utility::gethighestallowedstance();
      scripts\asm\asm_bb::bb_requeststance(var_1);
    }

    scripts\asm\asm_bb::bb_requestcoverexposetype(undefined);
    self.bt.cover = undefined;
    self.covernode = undefined;
    scripts\asm\asm_bb::bb_clearshootparams();
    scripts\asm\asm_bb::bb_requestfire(0);
  }

  self._blackboard.initialcovergunblockedbywalltime = undefined;
  return anim.success;
}

setcoverstate(var_0) {
  var_1 = self._blackboard.coverstate;

  if(var_0 == "hide" && (var_1 == "exposed" || var_1 == "none"))
    inithidetimers();

  scripts\asm\asm_bb::bb_requestcoverstate(var_0);
}

getcoverstate() {
  return self._blackboard.coverstate;
}

isboredofnode(var_0) {
  if(self.doingambush)
    return anim.failure;

  if(isDefined(self.covernode) && gettime() > self.coverstarttime + self.boredofcoverinterval)
    return anim.success;

  return anim.failure;
}

setnextlookforcovertime() {
  if(self.doingambush) {
    self.bt.nextlookforcovertime = gettime();
    return;
  }

  self.bt.nextlookforcovertime = gettime() + self.boredofcoverinterval;
}

movetocovernode(var_0) {
  if(isDefined(self.fnmovetocovernode))
    self[[self.fnmovetocovernode]](var_0);
}

shouldlookforinitialcover(var_0) {
  if(isDefined(self.fnshouldlookforcover))
    return self[[self.fnshouldlookforcover]](var_0);

  return anim.failure;
}

lookforinitialcover(var_0) {
  if(isDefined(self.fnlookforcover))
    return self[[self.fnlookforcover]](var_0);

  return anim.failure;
}

usecovernodeifpossible(var_0) {
  var_1 = self.keepclaimednodeifvalid;
  var_2 = self.keepclaimednode;
  self.keepclaimednodeifvalid = 0;
  self.keepclaimednode = 0;

  if(self usecovernode(var_0, 0)) {
    movetocovernode(var_0);
    return 1;
  } else {}

  self.keepclaimednodeifvalid = var_1;
  self.keepclaimednode = var_2;
  return 0;
}

lookforbettercoverduetowallblock(var_0) {
  if(self.fixednode || self.doingambush)
    return anim.failure;

  if(!isDefined(self.enemy))
    return anim.failure;

  if(isDefined(self._blackboard.deployedlmgnode))
    return anim.failure;

  var_1 = undefined;

  if(istrue(self.boundingoverwatchenabled))
    var_1 = "cover_bounding_overwatch";

  requestcoverfind(1, 1, var_1);
  return anim.success;
}

cover_shouldlookforbettercover() {
  if(self.fixednode)
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  var_0 = self._blackboard.coverstate;

  if(self.doingambush) {
    if(var_0 == "exposed" && !self.arriving)
      return !self ambushiscurrentnodevalid();

    return 0;
  }

  if(gettime() < self.coverstarttime + self.boredofcoverinterval)
    return 0;

  if(var_0 == "hide" || var_0 == "exposed") {
    if(!isDefined(self._blackboard.deployedlmgnode) || !scripts\asm\shared\utility::iscovernodevalid(self._blackboard.deployedlmgnode))
      return 1;
  }

  return 0;
}

shouldadvanceusingboundingoverwatch() {
  if(!istrue(self.boundingoverwatchenabled))
    return 0;

  if(!cover_shouldlookforbettercover())
    return 0;

  return self canboundingoverwatchmove();
}

lookforboundingoverwatchcover(var_0) {
  if(shouldadvanceusingboundingoverwatch()) {
    requestcoverfind(0, 1, "cover_bounding_overwatch");
    return anim.success;
  }

  return anim.failure;
}

requestcoverfind(var_0, var_1, var_2) {
  self.nextlookforcovertime = gettime();

  if(!self.requestdifferentcover)
    self.requestdifferentcover = var_0;

  self.repeatcoverfindiffailed = var_1;
  self.coverselectoroverride = var_2;
}

lookforbettercover(var_0) {
  if(istrue(self.boundingoverwatchenabled))
    return anim.failure;

  if(cover_shouldlookforbettercover()) {
    if(self.doingambush) {
      doambushcoverfind();
      return anim.success;
    }

    var_1 = 1;
    var_2 = undefined;

    if(scripts\anim\utility_common.gsc::usingmg())
      var_2 = "cover_lmg";

    requestcoverfind(var_1, 0, var_2);
  }

  return anim.success;
}

lookforbettercover_internal(var_0, var_1, var_2) {
  if(self.arriving)
    return 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(self.doingambush)
    var_3 = self ambushgetnextambushnode();
  else {
    if(!isDefined(var_2) && scripts\anim\utility_common.gsc::usingmg())
      var_2 = "cover_lmg";

    var_3 = self findbestcovernode(var_2, var_1, undefined, self.boundingoverwatchenabled);
  }

  if(isDefined(var_3)) {
    if(!isDefined(self.node) || var_3 != self.node || isDefined(var_0) && var_3 != var_0) {
      if(usecovernodeifpossible(var_3)) {
        if(self.doingambush) {
          if(self ambushcheckpath(var_3))
            return 1;
          else {
            self clearpath();
            self.keepclaimednodeifvalid = 0;
            self.keepclaimednode = 0;
            return 0;
          }
        }

        return 1;
      }
    }
  }

  return 0;
}

exposed_shouldlookforbettercover() {
  if(self.fixednode)
    return 0;

  if(isDefined(self.bt.cover))
    return 0;

  if(self.doingambush) {
    if(!self.arriving)
      return !self ambushiscurrentnodevalid();

    return 0;
  }

  if(!isDefined(self._blackboard.lastusednode))
    return 0;

  return 1;
}

doambushcoverfind() {
  var_0 = self ambushgetnextambushnode();

  if(isDefined(var_0) && (!isDefined(self.covernode) || self.node != self.covernode)) {
    if(self ambushcheckpath(var_0))
      usecovernodeifpossible(var_0);
  }

  setnextlookforcovertime();
}

updateexposedatnodestate(var_0) {
  if(exposed_shouldlookforbettercover()) {
    if(!self.doingambush && !scripts\engine\utility::actor_is3d() && isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, self.origin) > 4.0) {
      self._blackboard.lastusednode = undefined;
      self.bt.nextlookforcovertime = undefined;
    } else if(!self.doingambush && isDefined(self.node) && self.node != self._blackboard.lastusednode) {
      self._blackboard.lastusednode = undefined;
      self.bt.nextlookforcovertime = undefined;
    } else {
      if(!isDefined(self.bt.nextlookforcovertime))
        setnextlookforcovertime();

      if(gettime() >= self.bt.nextlookforcovertime) {
        if(self.doingambush) {
          doambushcoverfind();
          return anim.success;
        }

        var_1 = undefined;

        if(istrue(self.boundingoverwatchenabled))
          var_1 = "cover_bounding_overwatch";

        requestcoverfind(1, 1, var_1);
        setnextlookforcovertime();
      }
    }
  }

  return anim.success;
}

update(var_0) {
  var_1 = self.covernode;
  return anim.success;
}

update_lmg(var_0) {
  return anim.success;
}

candeploylmg(var_0) {
  if(var_0 isnodelmgmountable())
    return 1;

  return 0;
}

hasdroppedlmg(var_0) {
  return istrue(self._blackboard.droppedlmg) && isDefined(self._blackboard.deployedlmgnode) && self._blackboard.deployedlmgnode == var_0 && (!isDefined(self._blackboard.droppedlmgpickuptime) || gettime() > self._blackboard.droppedlmgpickuptime);
}

shoulddeploylmg(var_0) {
  var_1 = isDefined(self.node) && hasdroppedlmg(self.node);
  var_2 = candeploylmg(self.node) && (scripts\anim\utility_common.gsc::usingmg() || isDefined(scripts\asm\asm_bb::bb_getrequestedturret()) || var_1);

  if(var_2)
    return anim.success;

  return anim.failure;
}

isdoingambush(var_0) {
  return self.doingambush;
}

updatehide(var_0) {
  setcoverstate("hide");
  return anim.success;
}

isincover(var_0) {
  if(isDefined(self.bt.cover)) {
    if(!isDefined(self.covernode))
      return anim.failure;

    if(self.covernode != self.node && !istrue(self.pathpending))
      return anim.failure;

    if(isDefined(self.enemy)) {
      var_1 = 0;

      if(shouldbeinlmgcover())
        var_1 = iscovervalidforlmg(self.covernode);
      else
        var_1 = scripts\asm\shared\utility::iscovervalid();

      if(!var_1 && !scripts\asm\shared\utility::fixednodeshouldsticktocover() && scripts\asm\shared\utility::cover_canattackfromexposed())
        return anim.failure;
    }
  } else if(isDefined(self.enemy)) {
    if(scripts\asm\shared\utility::iscoverinvalidagainstenemy())
      return anim.failure;

    if(scripts\asm\shared\utility::shouldinitiallyattackfromexposed()) {
      scripts\asm\asm_bb::bb_requeststance("stand");
      return anim.failure;
    }
  }

  return anim.success;
}

shouldbeinlmgcover() {
  return (weaponclass(self.weapon) == "mg" || hasdroppedlmg(self.covernode)) && self.covernode.type != "Cover Left" && self.covernode.type != "Cover Right";
}

iscovervalidforlmg(var_0) {
  if(!isDefined(self.enemy) || !isDefined(self.node))
    return 0;

  var_1 = var_0.angles[1] - vectortoyaw(self.enemy.origin - var_0.origin);
  var_1 = angleclamp180(var_1);

  if(var_1 < 0)
    var_1 = -1 * var_1;

  if(var_1 <= self.leftaimlimit)
    return 1;

  return 0;
}

shouldreload(var_0, var_1) {
  if(self.bulletsinclip > weaponclipsize(self.weapon) * var_1)
    return anim.failure;

  return anim.success;
}

initreload(var_0) {
  thread scripts\anim\battlechatter_wrapper.gsc::evaluatereloadevent();
  inithidetimers();
}

terminatereload(var_0) {
  scripts\asm\asm_bb::bb_requestreload(0);
}

inithide(var_0) {
  setcoverstate("hide");

  if(isDefined(self.enemy) && !isDefined(self.bt.cover.changestanceforfuntime))
    setcoverchangestanceforfuntime();
}

coverhide(var_0) {
  setcoverstate("hide");

  if(isDefined(self.enemy) && !scripts\asm\shared\utility::iscovervalid())
    self.bt.nextlookforcovertime = self.bt.nextlookforcovertime - 1000;

  return anim.success;
}

setpeeklookstarttime(var_0) {
  var_1 = 1000;
  var_2 = 3000;

  if(self.team == "allies") {
    var_1 = 2500;
    var_2 = 3500;
  }

  self.bt.cover.peeklooktimer_canstarttime = gettime() + randomintrange(var_1, var_2);
}

inithidetimers() {
  var_0 = gettime();
  self.bt.cover.timestarted_hide = var_0;
  setpeeklookstarttime(1);
}

terminatehide(var_0) {}

iscoversuppressed(var_0) {
  if(self.doingambush)
    return 0;

  if(isDefined(self.balwayscoverexposed))
    return anim.failure;

  if(scripts\anim\utility_common.gsc::issuppressedwrapper())
    return anim.success;

  return anim.failure;
}

shouldpeekwhilecanseefromexposed(var_0) {
  if(shouldlookorpeek(var_0) == anim.failure)
    return anim.failure;

  if(!isDefined(self.enemy))
    return anim.failure;

  if(!issentient(self.enemy))
    return anim.failure;

  var_1 = distancesquared(self.enemy.origin, self.origin);

  if(var_1 < 65536)
    return anim.failure;

  var_2 = self lastknowntime(self.enemy);

  if(gettime() - var_2 < 1000)
    return anim.failure;

  return anim.success;
}

shouldlookorpeek(var_0) {
  if(getcoverstate() != "hide")
    return anim.failure;

  if(self.doingambush)
    return anim.failure;

  if(!isDefined(self.bt.cover.timestarted_hide))
    return anim.failure;

  if(!isDefined(self.bt.cover.peeklooktimer_canstarttime))
    return anim.failure;

  if(gettime() < self.bt.cover.peeklooktimer_canstarttime)
    return anim.failure;

  if(isDefined(self.node.allow_lookpeek) && !self.node.allow_lookpeek)
    return anim.failure;

  return anim.success;
}

initlook(var_0) {
  var_1 = 500;
  var_2 = 1500;
  var_3 = gettime();
  self.bt.cover.looktimestarted = var_3;
  self.bt.cover.lookduration = randomintrange(var_1, var_2);
  self.bt.cover.lookdelay = 3000;
}

terminatelook(var_0) {
  if(isDefined(self.bt.cover))
    setpeeklookstarttime(0);
}

coverlook(var_0) {
  setcoverstate("look");
  var_1 = self.bt.cover.looktimestarted;
  var_2 = self.bt.cover.lookduration;
  var_3 = self.bt.cover.lookdelay;

  if(isDefined(self.pathgoalpos))
    return anim.success;

  if(self issuppressed())
    return anim.success;

  if(isDefined(self.node.allow_lookpeek) && !self.node.allow_lookpeek)
    return anim.success;

  var_4 = gettime();

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end"))
    var_3 = var_4 - var_1;

  if(var_4 - var_1 > var_3 + var_2)
    return anim.success;

  return anim.running;
}

coverpeek(var_0) {
  setcoverstate("peek");

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_peek", "end"))
    return anim.success;

  return anim.running;
}

terminatepeek(var_0) {
  if(isDefined(self.bt.cover)) {
    setcoverstate("hide");
    setpeeklookstarttime(0);
  }
}

mustchangestance(var_0) {
  if(!isDefined(self.node) && self.currentpose == "prone")
    return anim.success;

  if(self.node.type == "Conceal Prone" || self.node.type == "Cover Prone") {
    if(self.currentpose != "prone" || scripts\asm\asm_bb::bb_getrequestedstance() != "prone")
      return anim.success;

    return anim.failure;
  }

  if(!self isstanceallowed(self.currentpose))
    return anim.success;

  var_1 = undefined;

  if(self.node doesnodeallowstance("stand") && !self.node doesnodeallowstance("crouch"))
    var_1 = "stand";
  else if(self.node doesnodeallowstance("crouch") && !self.node doesnodeallowstance("stand"))
    var_1 = "crouch";

  if(isDefined(self._blackboard.croucharrivaltype) && self._blackboard.croucharrivaltype != self.node.type)
    var_1 = "crouch";

  if(isDefined(var_1))
    scripts\asm\asm_bb::bb_requeststance(var_1);

  return anim.failure;
}

shouldchangestanceforfun(var_0) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(isDefined(self.rambochance) && self.currentpose == "stand")
    return anim.failure;

  if(self.node.type != "Cover Right" && self.node.type != "Cover Left")
    return anim.failure;

  if(scripts\engine\utility::isnodecover3d(self.node))
    return anim.failure;

  if(self.currentpose == "stand" && !self.node doesnodeallowstance("crouch"))
    return anim.failure;

  if(self.currentpose == "crouch" && !self.node doesnodeallowstance("stand"))
    return anim.failure;

  if(!isDefined(self.bt.cover.changestanceforfuntime))
    setcoverchangestanceforfuntime();

  if(gettime() < self.bt.cover.changestanceforfuntime)
    return anim.failure;

  return anim.success;
}

setcoverchangestanceforfuntime() {
  self.bt.cover.changestanceforfuntime = gettime() + randomintrange(5000, 20000);
}

initchangestance(var_0) {
  setcoverchangestanceforfuntime();
  self.a.prevattack = undefined;
  var_1 = undefined;

  if((self.currentpose != "prone" || scripts\asm\asm_bb::bb_getrequestedstance() != "prone") && isDefined(self.node) && (self.node.type == "Conceal Prone" || self.node.type == "Cover Prone"))
    var_1 = "prone";
  else {
    var_2 = ["stand", "crouch", "prone"];

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(self isstanceallowed(var_4)) {
        var_1 = var_4;
        break;
      }
    }
  }

  scripts\asm\asm_bb::bb_requeststance(var_1);
  self.bt.cover.changestancestarttime = gettime();
}

coverchangestance(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_stance_trans", "end"))
    return anim.success;

  var_1 = 5000;
  var_2 = self.bt.cover.changestancestarttime;

  if(gettime() - var_2 > var_1)
    return anim.success;

  if(self.currentpose == scripts\asm\asm_bb::bb_getrequestedstance())
    return anim.success;

  return anim.running;
}

terminatechangestance(var_0) {
  scripts\asm\asm_bb::bb_requeststance(self.currentpose);
}

hasroomtofullexposecorner(var_0) {
  var_1 = 36;
  var_2 = var_0.origin;

  if(scripts\engine\utility::isnodecoverright(var_0))
    var_2 = var_2 + anglestoright(var_0.angles) * var_1;
  else
    var_2 = var_2 + anglestoleft(var_0.angles) * var_1;

  if(!self maymovecheckfriendlyfire(var_2))
    return 0;

  if(!ispointonnavmesh(var_2, self, 1))
    return 0;

  if(!scripts\engine\trace::capsule_trace_passed(var_0.origin, var_2, 15, 36, (0, 0, 0), self, scripts\engine\trace::create_character_contents()))
    return 0;

  return 1;
}

covershouldexpose(var_0) {
  if(self.arriving || self codemoverequested())
    return anim.failure;

  if(isDefined(self.balwayscoverexposed))
    return anim.success;

  if(self.doingambush)
    return anim.success;

  if(!isDefined(self.enemy))
    return anim.failure;

  if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(self.node)) {
    if(scripts\engine\utility::isnodeexposed3d(self.node))
      return anim.success;

    var_1 = scripts\asm\shared\utility::getnodeforwardangles(self.node, 0);
    var_2 = angleclamp180(self.angles[0] - var_1[0]);
    var_3 = angleclamp180(self.angles[1] - var_1[1]);
    var_4 = angleclamp180(self.angles[2] - var_1[2]);

    if(abs(var_2) > 5 || abs(var_3) > 5 || abs(var_4) > 5)
      return anim.failure;

    var_5 = (self.enemy.origin + scripts\anim\utility_common.gsc::getenemyeyepos()) / 2;
    var_6 = var_5 - self.origin;
    var_7 = rotatevectorinverted(var_6, self.node.angles);
    var_8 = vectortoangles(var_7);
    var_2 = angleclamp180(var_8[0]);
    var_3 = angleclamp180(var_8[1]);
    var_9 = getcovercrouchanglelimits(self.node, self.currentpose);

    if(var_2 > var_9[1] || var_2 < var_9[0])
      return anim.failure;

    if(var_3 > var_9[3] || var_3 < var_9[2])
      return anim.failure;

    return anim.success;
  } else {
    var_10 = get3dcoveranglelimits(self.node, self.currentpose);
    var_11 = self.node.origin + scripts\anim\utility_common.gsc::getnodeoffset(self.node);
    var_6 = self.enemy.origin - var_11;
    var_12 = vectortoangles(var_6);
    var_8 = angleclamp180(var_12[1] - self.node.angles[1]);

    if(var_10[0] <= var_8 && var_8 <= var_10[1]) {
      if(scripts\engine\utility::isnodecoverright(self.node) && var_8 > var_10[3] || scripts\engine\utility::isnodecoverleft(self.node) && var_8 < var_10[2]) {
        var_13 = scripts\engine\utility::getcornerstepoutsdisabled();

        if(!hasroomtofullexposecorner(self.node) || var_13)
          return anim.failure;
      }

      return anim.success;
    }

    return anim.failure;
  }
}

initexpose(var_0) {
  if(getcoverstate() != "exposed" || !isDefined(self.bt.cover.timestarted_expose))
    self.bt.cover.timestarted_expose = gettime() + 3000;

  scripts\asm\asm_bb::bb_claimshootparams(var_0);
  self.bt.m_bfiring = 0;
  var_1 = scripts\anim\utility_common.gsc::isasniper();

  if(var_1)
    scripts\aitypes\combat::shoot_enableconvergence();
}

terminateexpose(var_0) {
  if(istrue(self._blackboard.shootparams_valid) && self._blackboard.shootparams_taskid == var_0) {
    scripts\asm\asm_bb::bb_clearshootparams();
    scripts\aitypes\combat::shoot_clearconvergence();
    self.bt.m_bfiring = undefined;
  }

  scripts\asm\asm_bb::bb_requestfire(0);
}

coverexpose(var_0) {
  if(!isDefined(self.enemy) && !self.doingambush)
    return anim.failure;

  var_1 = self getentitynumber() * 3 % 1000;
  var_2 = 3500 + var_1;
  var_3 = 2500 + var_1;
  var_4 = 1000;

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end"))
    self.bt.cover.timestarted_expose = gettime();

  var_5 = self.bt.cover.timestarted_expose;
  var_6 = gettime() - var_5;

  if(self.doingambush && var_6 > var_4)
    lookforbettercover(var_0);

  var_7 = self.covernode;

  if(isDefined(self.balwayscoverexposed)) {
    covershoot(var_0);

    if(scripts\engine\utility::isnodecoverleft(var_7) || scripts\engine\utility::isnodecoverright(var_7))
      scripts\asm\asm_bb::bb_requestcoverexposetype("B");
    else
      scripts\asm\asm_bb::bb_requestcoverexposetype("full exposed");

    setcoverstate("exposed");

    if(shouldreload(var_0, 0) == anim.success) {
      scripts\asm\asm_bb::bb_requestreload(1);
      return anim.failure;
    }

    scripts\asm\asm_bb::bb_requestreload(0);
    return anim.running;
  }

  if(shouldreload(var_0, 0) == anim.success) {
    if(var_6 > var_4)
      return anim.failure;

    scripts\aitypes\combat::reload_cheatammo();
  }

  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;

  if(scripts\engine\utility::actor_is3d()) {
    var_12 = self.enemy getcentroid();
    var_13 = var_12 - self getEye();

    if(scripts\engine\utility::isnodeexposed3d(var_7))
      var_11 = vectortoangles(var_13);
    else if(scripts\engine\utility::isnode3d(var_7)) {
      var_8 = getcovercrouchanglelimits(var_7, self.currentpose);
      var_13 = rotatevectorinverted(var_13, var_7.angles);
      var_11 = vectortoangles(var_13);
      var_14 = angleclamp180(var_11[0]);
      var_15 = angleclamp180(var_11[1]);

      if(var_14 > var_8[1] || var_14 < var_8[0])
        return anim.failure;

      if(var_15 > var_8[3] || var_15 < var_8[2])
        return anim.failure;
    }
  } else {
    var_8 = get3dcoveranglelimits(var_7, self.currentpose);
    var_16 = undefined;

    if(issentient(self.enemy) && !self cansee(self.enemy))
      var_16 = scripts\engine\utility::ter_op(isDefined(self.smartfacingpos), self.smartfacingpos, self.enemy.origin + (0, 0, 60));
    else
      var_16 = scripts\anim\utility_common.gsc::getenemyeyepos();

    var_17 = var_7.origin + scripts\anim\utility_common.gsc::getnodeoffset(var_7);
    var_13 = var_16 - var_17;
    var_11 = vectortoangles(var_13);
    var_9 = angleclamp180(var_11[1] - var_7.angles[1]);
    var_10 = angleclamp180(var_11[0] - var_7.angles[0]);

    if(var_9 < var_8[0] || var_9 > var_8[1]) {
      if(self.doingambush) {
        covershoot(var_0);

        if(scripts\engine\utility::isnodecoverleft(var_7) || scripts\engine\utility::isnodecoverright(var_7))
          scripts\asm\asm_bb::bb_requestcoverexposetype("B");
        else
          scripts\asm\asm_bb::bb_requestcoverexposetype("full exposed");

        setcoverstate("exposed");

        if(shouldreload(var_0, 0) == anim.success)
          scripts\asm\asm_bb::bb_requestreload(1);
        else
          scripts\asm\asm_bb::bb_requestreload(0);

        return anim.running;
      } else
        return anim.failure;
    }
  }

  var_18 = covershoot(var_0);

  if(!istrue(self._blackboard.shootparams_bconvergeontarget)) {
    if(!var_18) {
      if(var_6 > var_3 && !self.doingambush)
        return anim.failure;
    } else if(var_6 > var_2 && !self.doingambush)
      return anim.failure;
  }

  var_19 = self scriptabledooropen(var_9, var_10, scripts\engine\utility::getcornerstepoutsdisabled(), scripts\asm\asm_bb::bb_isshort(), gettime() - self.a.paintime);

  if(var_19)
    return anim.running;

  return anim.failure;
}

covershoot(var_0) {
  var_1 = scripts\aitypes\combat::shouldshoot();

  if(var_1)
    var_1 = scripts\aitypes\combat::calcgoodshootpos();
  else
    self.goodshootpos = undefined;

  if(!var_1) {
    self.bt.m_bfiring = 0;
    scripts\asm\asm_bb::bb_requestfire(0);
    return 0;
  }

  if(self cansee(self.enemy))
    scripts\asm\asm_bb::bb_updateshootparams(self.enemy getshootatpos(), self.enemy, 1);
  else
    scripts\asm\asm_bb::bb_updateshootparams(self.goodshootpos, self.enemy, 0);

  if(istrue(self.baimedataimtarget) || scripts\aitypes\combat::isaimedataimtarget()) {
    if(scripts\asm\shared\utility::blockedbywall(0)) {
      self.bt.m_bfiring = 0;
      scripts\asm\asm_bb::bb_requestfire(0);
      return 0;
    }

    if(!self.bt.m_bfiring)
      scripts\aitypes\combat::resetmisstime();

    scripts\aitypes\combat::chooseshootposandobjective();
    self.bt.m_bfiring = istrue(self._blackboard.shootparams_valid);
  } else
    self.bt.m_bfiring = 0;

  if(scripts\asm\asm_bb::bb_shootparams_empty()) {
    self.bt.m_bfiring = 0;
    scripts\asm\asm_bb::bb_requestfire(0);
    return 0;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return 1;
}

isenemyvisiblefromexposed(var_0, var_1) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(distancesquared(self.enemy.origin, self.couldntseeenemypos) < 256)
    return anim.failure;
  else if(scripts\anim\utility_common.gsc::canseeenemyfromexposed())
    return anim.success;
  else
    return anim.failure;
}

shouldtryleavenode(var_0) {
  var_1 = 50;

  if(istrue(self.aggressiveblindfire))
    var_1 = 30;

  return randomint(100) <= var_1;
}

setnextpossibleblindfiretime() {
  if(isDefined(self.bt.cover)) {
    if(istrue(self.aggressiveblindfire))
      self.bt.cover.nextpossibleblindfiretime = gettime() + randomintrange(5000, 7000);
    else
      self.bt.cover.nextpossibleblindfiretime = gettime() + randomintrange(7000, 12000);
  }
}

setglobalnextpossibleblindfiretime() {
  level.nextpossibleblindfiretime = gettime() + randomintrange(3000, 5000);
}

canblindfire() {
  if(self.team == "allies" && !istrue(self.allowallyblindfire))
    return 0;

  if(self.unittype == "c6")
    return 0;

  if(!scripts\anim\weaponlist.gsc::usingautomaticweapon())
    return 0;

  if(weaponclass(self.weapon) == "mg")
    return 0;

  if(isDefined(self.disable_blindfire) && self.disable_blindfire == 1)
    return 0;

  if(isDefined(self.covernode.script_parameters) && self.covernode.script_parameters == "no_blindfire")
    return 0;

  if(abs(self.enemy.origin[2] - self.origin[2]) > 100)
    return 0;

  var_0 = self.covernode.type;

  switch (var_0) {
    case "Cover Right":
    case "Cover Left":
      return 1;
    case "Conceal Prone":
    case "Cover Prone":
    case "Conceal Stand":
    case "Conceal Crouch":
      return 0;
    case "Cover Stand":
      if(self.node scripts\engine\utility::isvalidpeekoutdir("over"))
        return 1;

      return 0;
  }

  return 1;
}

shouldblindfire(var_0) {
  if(!canblindfire())
    return anim.failure;

  if(isDefined(level.nextpossibleblindfiretime) && gettime() < level.nextpossibleblindfiretime)
    return anim.failure;

  if(gettime() < self.bt.cover.nextpossibleblindfiretime)
    return anim.failure;

  if(!isenemyvisiblefromexposed() && !scripts\anim\utility_common.gsc::cansuppressenemyfromexposed())
    return anim.failure;

  return anim.success;
}

coverblindfire(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_blindfire", "end"))
    return anim.success;

  scripts\asm\asm_bb::bb_requestcoverblindfire(1);
  return anim.running;
}

terminateblindfire(var_0) {
  scripts\asm\asm_bb::bb_requestcoverblindfire(0);
  setnextpossibleblindfiretime();
  setglobalnextpossibleblindfiretime();
}

shouldthrowgrenadeatenemyasap(var_0) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(!isalive(self.enemy))
    return anim.failure;

  if(scripts\asm\asm_bb::bb_moverequested())
    return anim.failure;

  var_1 = 0;

  if(isDefined(anim.throwgrenadeatplayerasap) && isPlayer(self.enemy))
    var_1 = 1;
  else if(isDefined(self.throwgrenadeatenemyasap))
    var_1 = 1;

  if(!var_1)
    return anim.failure;

  scripts\aitypes\throwgrenade::setactivegrenadetimer(self.enemy);
  return anim.success;
}

shouldthrowgrenade(var_0) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(self.doingambush)
    return anim.failure;

  if(self.grenadeammo <= 0)
    return anim.failure;

  if(nullweapon(self.grenadeweapon))
    return anim.failure;

  if(isDefined(self.enemy) && isDefined(self.enemy.dontgrenademe))
    return anim.failure;

  var_1 = self.covernode;

  if(var_1.type == "Cover Prone" || var_1.type == "Conceal Prone")
    return anim.failure;

  if(istrue(self.nogrenadethrow))
    return anim.failure;

  var_2 = self.enemy;
  var_3 = anglesToForward(var_1.angles);
  var_4 = var_2.origin - self.origin;
  var_5 = lengthsquared(var_4);
  var_6 = 2560000;

  if(var_5 > var_6)
    return anim.failure;

  var_7 = vectorNormalize(var_4);

  if(vectordot(var_3, var_7) < 0)
    return anim.failure;

  var_8 = 0.4;
  var_9 = gettime();

  if(isDefined(self.bt.cover.lastgrenadethrowchecktime) && var_9 < self.bt.cover.lastgrenadethrowchecktime + var_8)
    return anim.failure;

  self.bt.cover.lastgrenadethrowchecktime = var_9;

  if(self.doingambush && !scripts\anim\utility_common.gsc::recentlysawenemy())
    return anim.failure;

  if(istrue(self.dontevershoot) || istrue(var_2.dontattackme))
    return anim.failure;

  scripts\aitypes\throwgrenade::setactivegrenadetimer(self.enemy);

  if(!scripts\aitypes\throwgrenade::grenadecooldownelapsed(var_2))
    return anim.failure;

  if(scripts\anim\utility_common.gsc::canseeenemyfromexposed()) {
    if(!scripts\aitypes\throwgrenade::grenadepossafewrapper(var_2, var_2.origin))
      return anim.failure;

    return anim.success;
  }

  if(scripts\anim\utility_common.gsc::cansuppressenemyfromexposed())
    return anim.success;

  if(!scripts\aitypes\throwgrenade::grenadepossafewrapper(var_2, var_2.origin))
    return anim.failure;

  return anim.success;
}

initthrowgrenade(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.enemy);
  setcoverstate("hide");
  self.bt.instancedata[var_0] = gettime() + 3000;
}

coverthrowgrenade(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end"))
    return anim.success;

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0))
    self.bt.instancedata[var_0] = self.bt.instancedata[var_0] + 10000;

  if(gettime() > self.bt.instancedata[var_0])
    return anim.failure;

  return anim.running;
}

terminatethrowgrenade(var_0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var_0] = undefined;
}

updatealwayscoverexposed(var_0) {
  if(isDefined(self.balwayscoverexposed)) {
    if(self.health < self.maxhealth * 0.75)
      self.balwayscoverexposed = undefined;
    else if(isDefined(self._blackboard.scriptableparts) && self._blackboard.scriptableparts.size >= 2)
      self.balwayscoverexposed = undefined;
  }

  return anim.success;
}

isalwayscoverexposed(var_0) {
  if(self.doingambush)
    return anim.success;

  if(isDefined(self.balwayscoverexposed))
    return anim.success;

  return anim.failure;
}

updatecovercroucharrivaltype(var_0) {
  if(!isDefined(self.node) || self.node.type != "Cover Crouch") {
    self._blackboard.croucharrivaltype = undefined;
    self._blackboard.croucharrivalnode = undefined;
    return anim.success;
  }

  if(!isDefined(self._blackboard.croucharrivaltype) || self._blackboard.croucharrivalnode != self.node) {
    var_1 = self pathdisttogoal();

    if(var_1 > 0 && var_1 < 512) {
      var_2 = getDvar("scr_ai_cover_crouch_type");

      if(isDefined(self.node.covercrouchtype)) {
        var_2 = self.node.covercrouchtype;

        if(var_2 != "Cover Right Crouch" && var_2 != "Cover Left Crouch" && var_2 != "Cover Crouch")
          var_2 = undefined;
      } else if(var_2 == "")
        var_2 = undefined;

      self._blackboard.croucharrivalnode = self.node;
      self._blackboard.croucharrivaltype = var_2;
    }
  }

  return anim.success;
}

shouldcovermultiswitch(var_0) {
  var_1 = self.covernode;

  if(!isDefined(var_1))
    return anim.failure;

  if(!var_1 iscovermultinode())
    return anim.failure;

  return anim.success;
}

covermultiswitch(var_0) {
  if(scripts\asm\asm_bb::bb_iscovermultiswitchrequested()) {
    [var_2, var_3] = scripts\asm\asm_bb::bb_getrequestedcovermultiswitchnodetype();
    var_4 = scripts\asm\asm_bb::bb_getcovernode();

    if(var_3 == var_2.type)
      scripts\asm\asm_bb::bb_resetcovermultiswitch();

    return anim.running;
  }

  var_4 = scripts\asm\asm_bb::bb_getcovernode();
  var_5 = scripts\engine\utility::getbestcovermultinodetype(var_4);

  if(!isDefined(var_5))
    return anim.failure;

  if(var_4.type == var_5)
    return anim.failure;

  scripts\asm\asm_bb::bb_requestcoverstate("hide");
  scripts\asm\asm_bb::bb_requestcovermultiswitch(var_4, var_5);
  return anim.running;
}

terminatecovermultiswitch(var_0) {
  if(scripts\asm\asm_bb::bb_iscovermultiswitchrequested())
    scripts\asm\asm_bb::bb_resetcovermultiswitch();
}

covershouldexposenoenemy(var_0) {
  if(!istrue(self.coverexposenoenemy))
    return anim.failure;

  if(!isDefined(self.enemy))
    return anim.success;

  return anim.failure;
}

initcoverexposenoenemy(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getcovernode();

  if(scripts\engine\utility::isnodecoverleft(var_1) || scripts\engine\utility::isnodecoverright(var_1))
    scripts\asm\asm_bb::bb_requestcoverexposetype("B");
  else if(var_1 doesnodeallowstance("stand"))
    scripts\asm\asm_bb::bb_requestcoverexposetype("full exposed");
  else
    scripts\asm\asm_bb::bb_requestcoverexposetype("exposed");

  setcoverstate("exposed");
  scripts\asm\asm_bb::bb_claimshootparams(var_0);
}

coverexposenoenemy(var_0) {
  var_1 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(self.coverexposenewtargettime) || self.coverexposenewtargettime < gettime()) {
    var_2 = randomintrange(self.coverexposenoenemytimemin, self.coverexposenoenemytimemax);
    self.coverexposenewtargettime = gettime() + int(var_2 * 1000);
    var_3 = undefined;

    if(!isDefined(self.enemy)) {
      var_4 = var_1.angles;
      var_3 = (var_4[0], var_4[1] + randomintrange(0 - self.coverexposenoenemyangle, self.coverexposenoenemyangle), var_4[2]);
    } else {
      var_5 = self lastknownpos(self.enemy);

      if(distancesquared(var_5, self.enemy.origin) < 62500) {
        var_3 = self getanglestolikelyenemypath();

        if(isDefined(var_3) && anglesdelta(var_3, var_1.angles) > 50)
          var_3 = undefined;
      }

      if(!isDefined(var_3))
        var_3 = var_1.angles;
    }

    if(isDefined(var_3)) {
      var_6 = anglesToForward(var_3) * 500;
      var_7 = self getapproxeyepos() + var_6;

      if(!istrue(self._blackboard.shootparams_valid))
        scripts\asm\asm_bb::bb_newshootparams(var_7, undefined, 0);
      else
        scripts\asm\asm_bb::bb_updateshootparams(var_7, undefined, 0);

      self._blackboard.shootparams_forceaim = 1;
      self.shootposoverride = 1;
    }
  }

  return anim.running;
}

terminatecoverexposenoenemy(var_0) {
  self._blackboard.shootparams_forceaim = undefined;
  self.shootposoverride = undefined;

  if(istrue(self._blackboard.shootparams_valid) && self._blackboard.shootparams_taskid == var_0)
    scripts\asm\asm_bb::bb_clearshootparams();
}

covershouldexposelostenemy(var_0) {
  if(!istrue(self.coverexposenoenemy))
    return anim.failure;

  if(!isDefined(self.enemy))
    return anim.failure;

  if(!issentient(self.enemy))
    return anim.failure;

  if(gettime() - self lastknowntime(self.enemy) > self.coverexposelostenemytime * 1000) {
    var_1 = self getsecondarytargets();

    if(!isDefined(var_1) || var_1.size == 0)
      return anim.success;
  }

  return anim.failure;
}