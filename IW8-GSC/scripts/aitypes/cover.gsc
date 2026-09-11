/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\cover.gsc
***********************************************/

function initcover(var0) {
  self.bt.cover = spawnStruct();
  scripts\asm\asm_bb::bb_requestcoverstate("none");
  self.covernode = self.node;
  self.bt.cover.starttime = gettime();
  self.bt.cover.nextmayshuffletime = gettime() + randomintrange(3000, 7000);
  self._blackboard.lastusednode = self.node;

  if(isDefined(self._blackboard.deployedlmgnode)) {}

  scripts\asm\asm_bb::bb_setcovernode(self.covernode);
  self.couldntseeenemypos = self.origin;

  if(!isDefined(self.bt.cover.nextpossibleblindfiretime) || !isDefined(self._blackboard.shufflenode)) {
    setnextpossibleblindfiretime();
  }

  setnextlookforcovertime();

  if(!isDefined(self.coverexposenoenemyangle)) {
    self.coverexposenoenemyangle = 30;
  }

  if(!isDefined(self.coverexposenoenemytimemin)) {
    self.coverexposenoenemytimemin = 2;
  }

  if(!isDefined(self.coverexposenoenemytimemax)) {
    self.coverexposenoenemytimemax = 3;
  }

  if(!isDefined(self.coverexposelostenemytime)) {
    self.coverexposelostenemytime = 5;
  }

  return anim.success;
}

function initcoverbb(var0) {
  self.bt.cover.taskid = var0;
}

function clearcoverbb(var0) {
  if(isDefined(self.bt.cover) && self.bt.cover.taskid != var0) {
    return anim.success;
  }

  if(scripts\asm\asm_bb::bb_hadcovernode()) {
    scripts\asm\asm_bb::bb_setcovernode(undefined);
    scripts\asm\asm_bb::bb_requestcoverstate("hide");
    self._blackboard.deployedlmgnode = undefined;

    if(isDefined(self.pathgoalpos) || self._blackboard.desiredstance == "prone") {
      var1 = scripts\asm\shared\utility::gethighestallowedstance();
      scripts\asm\asm_bb::bb_requeststance(var1);
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

function setcoverstate(var0) {
  var1 = self._blackboard.coverstate;

  if(var0 == "hide" && (var1 == "exposed" || var1 == "none")) {
    inithidetimers();
  }

  scripts\asm\asm_bb::bb_requestcoverstate(var0);
}

function getcoverstate() {
  return self._blackboard.coverstate;
}

function isboredofnode(var0) {
  if(self.doingambush) {
    return anim.failure;
  }

  if(isDefined(self.covernode) && gettime() > self.coverstarttime + self.boredofcoverinterval) {
    return anim.success;
  }

  return anim.failure;
}

function setnextlookforcovertime() {
  if(self.doingambush) {
    self.bt.nextlookforcovertime = gettime();
    return;
  }

  self.bt.nextlookforcovertime = gettime() + self.boredofcoverinterval;
}

function movetocovernode(var0) {
  if(isDefined(self.fnmovetocovernode)) {
    self[[self.fnmovetocovernode]](var0);
    return;
  }
}

function shouldlookforinitialcover(var0) {
  if(isDefined(self.fnshouldlookforcover)) {
    return self[[self.fnshouldlookforcover]](var0);
  }

  return anim.failure;
}

function lookforinitialcover(var0) {
  if(isDefined(self.fnlookforcover)) {
    return self[[self.fnlookforcover]](var0);
  }

  return anim.failure;
}

function usecovernodeifpossible(var0) {
  var1 = self.keepclaimednodeifvalid;
  var2 = self.keepclaimednode;
  self.keepclaimednodeifvalid = 0;
  self.keepclaimednode = 0;

  if(self usecovernode(var0, 0)) {
    movetocovernode(var0);
    return true;
  }

  self.keepclaimednodeifvalid = var1;
  self.keepclaimednode = var2;
  return false;
}

function lookforbettercoverduetowallblock(var0) {
  if(self.fixednode || self.doingambush) {
    return anim.failure;
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(isDefined(self._blackboard.deployedlmgnode)) {
    return anim.failure;
  }

  var1 = undefined;

  if(istrue(self.boundingoverwatchenabled)) {
    var1 = "cover_bounding_overwatch";
  }

  requestcoverfind(1, 1, var1);
  return anim.success;
}

function cover_shouldlookforbettercover() {
  if(self.fixednode) {
    return false;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  var0 = self._blackboard.coverstate;

  if(self.doingambush) {
    if(var0 == "exposed" && !self.arriving) {
      return !self ambushiscurrentnodevalid();
    }

    return false;
  }

  if(gettime() < self.coverstarttime + self.boredofcoverinterval) {
    return false;
  }

  if(var0 == "hide" || var0 == "exposed") {
    if(!isDefined(self._blackboard.deployedlmgnode) || !scripts\asm\shared\utility::iscovernodevalid(self._blackboard.deployedlmgnode)) {
      return true;
    }
  }

  return false;
}

function shouldadvanceusingboundingoverwatch() {
  if(!istrue(self.boundingoverwatchenabled)) {
    return 0;
  }

  if(!cover_shouldlookforbettercover()) {
    return 0;
  }

  return self canboundingoverwatchmove();
}

function lookforboundingoverwatchcover(var0) {
  if(shouldadvanceusingboundingoverwatch()) {
    requestcoverfind(0, 1, "cover_bounding_overwatch");
    return anim.success;
  }

  return anim.failure;
}

function requestcoverfind(var0, var1, var2) {
  self.nextlookforcovertime = gettime();

  if(!self.requestdifferentcover) {
    self.requestdifferentcover = var0;
  }

  self.repeatcoverfindiffailed = var1;
  self.coverselectoroverride = var2;
}

function lookforbettercover(var0) {
  if(istrue(self.boundingoverwatchenabled)) {
    return anim.failure;
  }

  if(cover_shouldlookforbettercover()) {
    if(self.doingambush) {
      doambushcoverfind();
      return anim.success;
    }

    var1 = 1;
    var2 = undefined;

    if(scripts\anim\utility_common::usingmg()) {
      var2 = "cover_lmg";
    }

    requestcoverfind(var1, 0, var2);
  }

  return anim.success;
}

function lookforbettercover_internal(var0, var1, var2) {
  if(self.arriving) {
    return false;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(self.doingambush) {
    var3 = self ambushgetnextambushnode();
  } else {
    if(!isDefined(var3) && scripts\anim\utility_common::usingmg()) {
      var3 = "cover_lmg";
    }

    var3 = self findbestcovernode(var3, var2, undefined, self.boundingoverwatchenabled);
  }

  if(isDefined(var3)) {
    if(!isDefined(self.node) || var3 != self.node || isDefined(var1) && var3 != var1) {
      if(usecovernodeifpossible(var3)) {
        if(self.doingambush) {
          if(self ambushcheckpath(var3)) {
            return true;
          } else {
            self clearpath();
            self.keepclaimednodeifvalid = 0;
            self.keepclaimednode = 0;
            return false;
          }
        }

        return true;
      }
    }
  }

  return false;
}

function exposed_shouldlookforbettercover() {
  if(self.fixednode) {
    return false;
  }

  if(isDefined(self.bt.cover)) {
    return false;
  }

  if(self.doingambush) {
    if(!self.arriving) {
      return !self ambushiscurrentnodevalid();
    }

    return false;
  }

  if(!isDefined(self._blackboard.lastusednode)) {
    return false;
  }

  return true;
}

function doambushcoverfind() {
  var0 = self ambushgetnextambushnode();

  if(isDefined(var0) && (!isDefined(self.covernode) || self.node != self.covernode)) {
    if(self ambushcheckpath(var0)) {
      usecovernodeifpossible(var0);
    }
  }

  setnextlookforcovertime();
}

function updateexposedatnodestate(var0) {
  if(exposed_shouldlookforbettercover()) {
    if(!self.doingambush && !scripts\engine\utility::actor_is3d() && isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, self.origin) > 4) {
      self._blackboard.lastusednode = undefined;
      self.bt.nextlookforcovertime = undefined;
    } else if(!self.doingambush && isDefined(self.node) && self.node != self._blackboard.lastusednode) {
      self._blackboard.lastusednode = undefined;
      self.bt.nextlookforcovertime = undefined;
    } else {
      if(!isDefined(self.bt.nextlookforcovertime)) {
        setnextlookforcovertime();
      }

      if(gettime() >= self.bt.nextlookforcovertime) {
        if(self.doingambush) {
          doambushcoverfind();
          return anim.success;
        }

        var1 = undefined;

        if(istrue(self.boundingoverwatchenabled)) {
          var1 = "cover_bounding_overwatch";
        }

        requestcoverfind(1, 1, var1);
        setnextlookforcovertime();
      }
    }
  }

  return anim.success;
}

function update(var0) {
  var1 = self.covernode;
  return anim.success;
}

function update_lmg(var0) {
  return anim.success;
}

function candeploylmg(var0) {
  if(var0 isnodelmgmountable()) {
    return true;
  }

  return false;
}

function hasdroppedlmg(var0) {
  return istrue(self._blackboard.droppedlmg) && isDefined(self._blackboard.deployedlmgnode) && self._blackboard.deployedlmgnode == var0 && (!isDefined(self._blackboard.droppedlmgpickuptime) || gettime() > self._blackboard.droppedlmgpickuptime);
}

function shoulddeploylmg(var0) {
  var1 = isDefined(self.node) && hasdroppedlmg(self.node);
  var2 = candeploylmg(self.node) && (scripts\anim\utility_common::usingmg() || isDefined(scripts\asm\asm_bb::bb_getrequestedturret()) || var1);

  if(var2) {
    return anim.success;
  }

  return anim.failure;
}

function isdoingambush(var0) {
  return self.doingambush;
}

function updatehide(var0) {
  setcoverstate("hide");
  return anim.success;
}

function isincover(var0) {
  if(isDefined(self.bt.cover)) {
    if(!isDefined(self.covernode)) {
      return anim.failure;
    }

    if(self.covernode != self.node && !istrue(self.pathpending)) {
      return anim.failure;
    }

    if(isDefined(self.enemy)) {
      var1 = 0;

      if(shouldbeinlmgcover()) {
        var1 = iscovervalidforlmg(self.covernode);
      } else {
        var1 = scripts\asm\shared\utility::iscovervalid();
      }

      if(!var1 && !scripts\asm\shared\utility::fixednodeshouldsticktocover() && scripts\asm\shared\utility::cover_canattackfromexposed()) {
        return anim.failure;
      }
    }
  } else if(isDefined(self.enemy)) {
    if(scripts\asm\shared\utility::iscoverinvalidagainstenemy()) {
      return anim.failure;
    }

    if(scripts\asm\shared\utility::shouldinitiallyattackfromexposed()) {
      scripts\asm\asm_bb::bb_requeststance("stand");
      return anim.failure;
    }
  }

  return anim.success;
}

function shouldbeinlmgcover() {
  return (weaponclass(self.weapon) == "mg" || hasdroppedlmg(self.covernode)) && self.covernode.type != "Cover Left" && self.covernode.type != "Cover Right";
}

function iscovervalidforlmg(var0) {
  if(!isDefined(self.enemy) || !isDefined(self.node)) {
    return false;
  }

  var1 = var0.angles[1] - vectortoyaw(self.enemy.origin - var0.origin);
  var1 = angleclamp180(var1);

  if(var1 < 0) {
    var1 = -1 * var1;
  }

  if(var1 <= self.leftaimlimit) {
    return true;
  }

  return false;
}

function shouldreload(var0, var1) {
  if(self.bulletsinclip > weaponclipsize(self.weapon) * var1) {
    return anim.failure;
  }

  return anim.success;
}

function initreload(var0) {
  thread scripts\anim\battlechatter_wrapper::evaluatereloadevent();
  inithidetimers();
}

function terminatereload(var0) {
  scripts\asm\asm_bb::bb_requestreload(0);
}

function inithide(var0) {
  setcoverstate("hide");

  if(isDefined(self.enemy) && !isDefined(self.bt.cover.changestanceforfuntime)) {
    setcoverchangestanceforfuntime();
    return;
  }
}

function coverhide(var0) {
  setcoverstate("hide");

  if(isDefined(self.enemy) && !scripts\asm\shared\utility::iscovervalid()) {
    self.bt.nextlookforcovertime -= 1000;
  }

  return anim.success;
}

function setpeeklookstarttime(var0) {
  var1 = 1000;
  var2 = 3000;

  if(self.team == "allies") {
    var1 = 2500;
    var2 = 3500;
  }

  self.bt.cover.peeklooktimer_canstarttime = gettime() + randomintrange(var1, var2);
}

function inithidetimers() {
  var0 = gettime();
  self.bt.cover.timestarted_hide = var0;
  setpeeklookstarttime(1);
}

function terminatehide(var0) {}

function iscoversuppressed(var0) {
  if(self.doingambush) {
    return 0;
  }

  if(isDefined(self.balwayscoverexposed)) {
    return anim.failure;
  }

  if(scripts\anim\utility_common::issuppressedwrapper()) {
    return anim.success;
  }

  return anim.failure;
}

function shouldpeekwhilecanseefromexposed(var0) {
  if(shouldlookorpeek(var0) == anim.failure) {
    return anim.failure;
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(!issentient(self.enemy)) {
    return anim.failure;
  }

  var1 = distancesquared(self.enemy.origin, self.origin);

  if(var1 < 65536) {
    return anim.failure;
  }

  var2 = self lastknowntime(self.enemy);

  if(gettime() - var2 < 1000) {
    return anim.failure;
  }

  return anim.success;
}

function shouldlookorpeek(var0) {
  if(getcoverstate() != "hide") {
    return anim.failure;
  }

  if(self.doingambush) {
    return anim.failure;
  }

  if(!isDefined(self.bt.cover.timestarted_hide)) {
    return anim.failure;
  }

  if(!isDefined(self.bt.cover.peeklooktimer_canstarttime)) {
    return anim.failure;
  }

  if(gettime() < self.bt.cover.peeklooktimer_canstarttime) {
    return anim.failure;
  }

  if(isDefined(self.node.allow_lookpeek) && !self.node.allow_lookpeek) {
    return anim.failure;
  }

  return anim.success;
}

function initlook(var0) {
  var1 = 500;
  var2 = 1500;
  var3 = gettime();
  self.bt.cover.looktimestarted = var3;
  self.bt.cover.lookduration = randomintrange(var1, var2);
  self.bt.cover.lookdelay = 3000;
}

function terminatelook(var0) {
  if(isDefined(self.bt.cover)) {
    setpeeklookstarttime(0);
    return;
  }
}

function coverlook(var0) {
  setcoverstate("look");
  var1 = self.bt.cover.looktimestarted;
  var2 = self.bt.cover.lookduration;
  var3 = self.bt.cover.lookdelay;

  if(isDefined(self.pathgoalpos)) {
    return anim.success;
  }

  if(self issuppressed()) {
    return anim.success;
  }

  if(isDefined(self.node.allow_lookpeek) && !self.node.allow_lookpeek) {
    return anim.success;
  }

  var4 = gettime();

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end")) {
    var3 = var4 - var1;
  }

  if(var4 - var1 > var3 + var2) {
    return anim.success;
  }

  return anim.running;
}

function coverpeek(var0) {
  setcoverstate("peek");

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_peek", "end")) {
    return anim.success;
  }

  return anim.running;
}

function terminatepeek(var0) {
  if(isDefined(self.bt.cover)) {
    setcoverstate("hide");
    setpeeklookstarttime(0);
    return;
  }
}

function mustchangestance(var0) {
  if(!isDefined(self.node) && self.currentpose == "prone") {
    return anim.success;
  }

  if(self.node.type == "Conceal Prone" || self.node.type == "Cover Prone") {
    if(self.currentpose != "prone" || scripts\asm\asm_bb::bb_getrequestedstance() != "prone") {
      return anim.success;
    }

    return anim.failure;
  }

  if(!self isstanceallowed(self.currentpose)) {
    return anim.success;
  }

  var1 = undefined;

  if(self.node doesnodeallowstance("stand") && !self.node doesnodeallowstance("crouch")) {
    var1 = "stand";
  } else if(self.node doesnodeallowstance("crouch") && !self.node doesnodeallowstance("stand")) {
    var1 = "crouch";
  }

  if(isDefined(self._blackboard.croucharrivaltype) && self._blackboard.croucharrivaltype != self.node.type) {
    var1 = "crouch";
  }

  if(isDefined(var1)) {
    scripts\asm\asm_bb::bb_requeststance(var1);
  }

  return anim.failure;
}

function shouldchangestanceforfun(var0) {
  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(isDefined(self.rambochance) && self.currentpose == "stand") {
    return anim.failure;
  }

  if(self.node.type != "Cover Right" && self.node.type != "Cover Left") {
    return anim.failure;
  }

  if(scripts\engine\utility::isnodecover3d(self.node)) {
    return anim.failure;
  }

  if(self.currentpose == "stand" && !self.node doesnodeallowstance("crouch")) {
    return anim.failure;
  }

  if(self.currentpose == "crouch" && !self.node doesnodeallowstance("stand")) {
    return anim.failure;
  }

  if(!isDefined(self.bt.cover.changestanceforfuntime)) {
    setcoverchangestanceforfuntime();
  }

  if(gettime() < self.bt.cover.changestanceforfuntime) {
    return anim.failure;
  }

  return anim.success;
}

function setcoverchangestanceforfuntime() {
  self.bt.cover.changestanceforfuntime = gettime() + randomintrange(5000, 20000);
}

function initchangestance(var0) {
  setcoverchangestanceforfuntime();
  self.a.prevattack = undefined;
  var1 = undefined;

  if((self.currentpose != "prone" || scripts\asm\asm_bb::bb_getrequestedstance() != "prone") && isDefined(self.node) && (self.node.type == "Conceal Prone" || self.node.type == "Cover Prone")) {
    var1 = "prone";
  } else {
    var2 = ["stand", "crouch", "prone"];

    for(var3 = 0; var3 < var2.size; var3++) {
      var4 = var2[var3];

      if(self isstanceallowed(var4)) {
        var1 = var4;
        break;
      }
    }
  }

  scripts\asm\asm_bb::bb_requeststance(var1);
  self.bt.cover.changestancestarttime = gettime();
}

function coverchangestance(var0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_stance_trans", "end")) {
    return anim.success;
  }

  var1 = 5000;
  var2 = self.bt.cover.changestancestarttime;

  if(gettime() - var2 > var1) {
    return anim.success;
  }

  if(self.currentpose == scripts\asm\asm_bb::bb_getrequestedstance()) {
    return anim.success;
  }

  return anim.running;
}

function terminatechangestance(var0) {
  scripts\asm\asm_bb::bb_requeststance(self.currentpose);
}

function hasroomtofullexposecorner(var0) {
  var1 = 36;
  var2 = var0.origin;

  if(scripts\engine\utility::isnodecoverright(var0)) {
    var2 += anglestoright(var0.angles) * var1;
  } else {
    var2 += anglestoleft(var0.angles) * var1;
  }

  if(!self maymovecheckfriendlyfire(var2)) {
    return false;
  }

  if(!ispointonnavmesh(var2, self, 1)) {
    return false;
  }

  if(!scripts\engine\trace::capsule_trace_passed(var0.origin, var2, 15, 36, (0, 0, 0), self, scripts\engine\trace::create_character_contents())) {
    return false;
  }

  return true;
}

function covershouldexpose(var0) {
  if(self.arriving || self codemoverequested()) {
    return anim.failure;
  }

  if(isDefined(self.balwayscoverexposed)) {
    return anim.success;
  }

  if(self.doingambush) {
    return anim.success;
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(scripts\engine\utility::actor_is3d() && scripts\engine\utility::isnode3d(self.node)) {
    if(scripts\engine\utility::isnodeexposed3d(self.node)) {
      return anim.success;
    }

    var1 = scripts\asm\shared\utility::getnodeforwardangles(self.node, 0);
    var2 = angleclamp180(self.angles[0] - var1[0]);
    var3 = angleclamp180(self.angles[1] - var1[1]);
    var4 = angleclamp180(self.angles[2] - var1[2]);

    if(abs(var2) > 5 || abs(var3) > 5 || abs(var4) > 5) {
      return anim.failure;
    }

    var5 = (self.enemy.origin + scripts\anim\utility_common::getenemyeyepos()) / 2;
    var6 = var5 - self.origin;
    var7 = rotatevectorinverted(var6, self.node.angles);
    var8 = vectortoangles(var7);
    var2 = angleclamp180(var8[0]);
    var3 = angleclamp180(var8[1]);
    var9 = getcovercrouchanglelimits(self.node, self.currentpose);

    if(var2 > var9[1] || var2 < var9[0]) {
      return anim.failure;
    }

    if(var3 > var9[3] || var3 < var9[2]) {
      return anim.failure;
    }

    return anim.success;
  }

  var10 = get3dcoveranglelimits(self.node, self.currentpose);
  var11 = self.node.origin + scripts\anim\utility_common::getnodeoffset(self.node);
  var6 = self.enemy.origin - var11;
  var12 = vectortoangles(var6);
  var8 = angleclamp180(var12[1] - self.node.angles[1]);

  if(var10[0] <= var8 && var8 <= var10[1]) {
    if(scripts\engine\utility::isnodecoverright(self.node) && var8 > var10[3] || scripts\engine\utility::isnodecoverleft(self.node) && var8 < var10[2]) {
      var13 = scripts\engine\utility::getcornerstepoutsdisabled();

      if(!hasroomtofullexposecorner(self.node) || var13) {
        return anim.failure;
      }
    }

    return anim.success;
  }

  return anim.failure;
}

function initexpose(var0) {
  if(getcoverstate() != "exposed" || !isDefined(self.bt.cover.timestarted_expose)) {
    self.bt.cover.timestarted_expose = gettime() + 3000;
  }

  scripts\asm\asm_bb::bb_claimshootparams(var0);
  self.bt.m_bfiring = 0;
  var1 = scripts\anim\utility_common::isasniper();

  if(var1) {
    scripts\aitypes\combat::shoot_enableconvergence();
    return;
  }
}

function terminateexpose(var0) {
  if(istrue(self._blackboard.shootparams_valid) && self._blackboard.shootparams_taskid == var0) {
    scripts\asm\asm_bb::bb_clearshootparams();
    scripts\aitypes\combat::shoot_clearconvergence();
    self.bt.m_bfiring = undefined;
  }

  scripts\asm\asm_bb::bb_requestfire(0);
}

function coverexpose(var0) {
  if(!isDefined(self.enemy) && !self.doingambush) {
    return anim.failure;
  }

  var1 = self getentitynumber() * 3 % 1000;
  var2 = 3500 + var1;
  var3 = 2500 + var1;
  var4 = 1000;

  if(scripts\asm\asm::asm_ephemeraleventfired("cover_trans", "end")) {
    self.bt.cover.timestarted_expose = gettime();
  }

  var5 = self.bt.cover.timestarted_expose;
  var6 = gettime() - var5;

  if(self.doingambush && var6 > var4) {
    lookforbettercover(var0);
  }

  var7 = self.covernode;

  if(isDefined(self.balwayscoverexposed)) {
    covershoot(var0);

    if(scripts\engine\utility::isnodecoverleft(var7) || scripts\engine\utility::isnodecoverright(var7)) {
      scripts\asm\asm_bb::bb_requestcoverexposetype("B");
    } else {
      scripts\asm\asm_bb::bb_requestcoverexposetype("full exposed");
    }

    setcoverstate("exposed");

    if(shouldreload(var0, 0) == anim.success) {
      scripts\asm\asm_bb::bb_requestreload(1);
      return anim.failure;
    }

    scripts\asm\asm_bb::bb_requestreload(0);
    return anim.running;
  }

  if(shouldreload(var0, 0) == anim.success) {
    if(var6 > var4) {
      return anim.failure;
    }

    scripts\aitypes\combat::reload_cheatammo();
  }

  var8 = undefined;
  var9 = undefined;
  var10 = undefined;
  var11 = undefined;

  if(scripts\engine\utility::actor_is3d()) {
    var12 = self.enemy getcentroid();
    var13 = var12 - self getEye();

    if(scripts\engine\utility::isnodeexposed3d(var7)) {
      var11 = vectortoangles(var13);
    } else if(scripts\engine\utility::isnode3d(var7)) {
      var8 = getcovercrouchanglelimits(var7, self.currentpose);
      var13 = rotatevectorinverted(var13, var7.angles);
      var11 = vectortoangles(var13);
      var14 = angleclamp180(var11[0]);
      var15 = angleclamp180(var11[1]);

      if(var14 > var8[1] || var14 < var8[0]) {
        return anim.failure;
      }

      if(var15 > var8[3] || var15 < var8[2]) {
        return anim.failure;
      }
    }
  } else {
    var9 = get3dcoveranglelimits(var8, self.currentpose);
    var16 = undefined;

    if(issentient(self.enemy) && !self cansee(self.enemy)) {
      var16 = scripts\engine\utility::ter_op(isDefined(self.smartfacingpos), self.smartfacingpos, self.enemy.origin + (0, 0, 60));
    } else {
      var16 = scripts\anim\utility_common::getenemyeyepos();
    }

    var17 = var8.origin + scripts\anim\utility_common::getnodeoffset(var8);
    var13 = var16 - var17;
    var13 = vectortoangles(var13);
    var10 = angleclamp180(var13[1] - var8.angles[1]);
    var11 = angleclamp180(var13[0] - var8.angles[0]);

    if(var10 < var9[0] || var10 > var9[1]) {
      if(self.doingambush) {
        covershoot(var1);

        if(scripts\engine\utility::isnodecoverleft(var8) || scripts\engine\utility::isnodecoverright(var8)) {
          scripts\asm\asm_bb::bb_requestcoverexposetype("B");
        } else {
          scripts\asm\asm_bb::bb_requestcoverexposetype("full exposed");
        }

        setcoverstate("exposed");

        if(shouldreload(var1, 0) == anim.success) {
          scripts\asm\asm_bb::bb_requestreload(1);
        } else {
          scripts\asm\asm_bb::bb_requestreload(0);
        }

        return anim.running;
      } else {
        return anim.failure;
      }
    }
  }

  var18 = covershoot(var1);

  if(!istrue(self._blackboard.shootparams_bconvergeontarget)) {
    if(!var18) {
      if(var7 > var4 && !self.doingambush) {
        return anim.failure;
      }
    } else if(var7 > var3 && !self.doingambush) {
      return anim.failure;
    }
  }

  var19 = self scriptabledooropen(var10, var11, scripts\engine\utility::getcornerstepoutsdisabled(), scripts\asm\asm_bb::bb_isshort(), gettime() - self.a.paintime);

  if(var19) {
    return anim.running;
  }

  return anim.failure;
}

function covershoot(var0) {
  var1 = scripts\aitypes\combat::shouldshoot();

  if(var1) {
    var1 = scripts\aitypes\combat::calcgoodshootpos();
  } else {
    self.goodshootpos = undefined;
  }

  if(!var1) {
    self.bt.m_bfiring = 0;
    scripts\asm\asm_bb::bb_requestfire(0);
    return false;
  }

  if(self cansee(self.enemy)) {
    scripts\asm\asm_bb::bb_updateshootparams(self.enemy getshootatpos(), self.enemy, 1);
  } else {
    scripts\asm\asm_bb::bb_updateshootparams(self.goodshootpos, self.enemy, 0);
  }

  if(istrue(self.baimedataimtarget) || scripts\aitypes\combat::isaimedataimtarget()) {
    if(scripts\asm\shared\utility::blockedbywall(0)) {
      self.bt.m_bfiring = 0;
      scripts\asm\asm_bb::bb_requestfire(0);
      return false;
    }

    if(!self.bt.m_bfiring) {
      scripts\aitypes\combat::resetmisstime();
    }

    scripts\aitypes\combat::chooseshootposandobjective();
    self.bt.m_bfiring = istrue(self._blackboard.shootparams_valid);
  } else {
    self.bt.m_bfiring = 0;
  }

  if(scripts\asm\asm_bb::bb_shootparams_empty()) {
    self.bt.m_bfiring = 0;
    scripts\asm\asm_bb::bb_requestfire(0);
    return false;
  }

  scripts\asm\asm_bb::bb_requestfire(self.bt.m_bfiring);
  return true;
}

function isenemyvisiblefromexposed(var0, var1) {
  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(distancesquared(self.enemy.origin, self.couldntseeenemypos) < 256) {
    return anim.failure;
  }

  if(scripts\anim\utility_common::canseeenemyfromexposed()) {
    return anim.success;
  }

  return anim.failure;
}

function shouldtryleavenode(var0) {
  var1 = 50;

  if(istrue(self.aggressiveblindfire)) {
    var1 = 30;
  }

  return randomint(100) <= var1;
}

function setnextpossibleblindfiretime() {
  if(isDefined(self.bt.cover)) {
    if(istrue(self.aggressiveblindfire)) {
      self.bt.cover.nextpossibleblindfiretime = gettime() + randomintrange(5000, 7000);
      return;
    }

    self.bt.cover.nextpossibleblindfiretime = gettime() + randomintrange(7000, 12000);
    return;
  }
}

function setglobalnextpossibleblindfiretime() {
  level.nextpossibleblindfiretime = gettime() + randomintrange(3000, 5000);
}

function canblindfire() {
  if(self.team == "allies" && !istrue(self.allowallyblindfire)) {
    return false;
  }

  if(self.unittype == "c6") {
    return false;
  }

  if(!scripts\anim\weaponlist::usingautomaticweapon()) {
    return false;
  }

  if(weaponclass(self.weapon) == "mg") {
    return false;
  }

  if(isDefined(self.disable_blindfire) && self.disable_blindfire == 1) {
    return false;
  }

  if(isDefined(self.covernode.script_parameters) && self.covernode.script_parameters == "no_blindfire") {
    return false;
  }

  if(abs(self.enemy.origin[2] - self.origin[2]) > 100) {
    return false;
  }

  var0 = self.covernode.type;

  switch (var0) {
    case "Cover Right":
    case "Cover Left":
      return true;
    case "Conceal Prone":
    case "Cover Prone":
    case "Conceal Stand":
    case "Conceal Crouch":
      return false;
    case "Cover Stand":
      if(self.node scripts\engine\utility::isvalidpeekoutdir("over")) {
        return true;
      }

      return false;
  }

  return true;
}

function shouldblindfire(var0) {
  if(!canblindfire()) {
    return anim.failure;
  }

  if(isDefined(level.nextpossibleblindfiretime) && gettime() < level.nextpossibleblindfiretime) {
    return anim.failure;
  }

  if(gettime() < self.bt.cover.nextpossibleblindfiretime) {
    return anim.failure;
  }

  if(!isenemyvisiblefromexposed() && !scripts\anim\utility_common::cansuppressenemyfromexposed()) {
    return anim.failure;
  }

  return anim.success;
}

function coverblindfire(var0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("cover_blindfire", "end")) {
    return anim.success;
  }

  scripts\asm\asm_bb::bb_requestcoverblindfire(1);
  return anim.running;
}

function terminateblindfire(var0) {
  scripts\asm\asm_bb::bb_requestcoverblindfire(0);
  setnextpossibleblindfiretime();
  setglobalnextpossibleblindfiretime();
}

function shouldthrowgrenadeatenemyasap(var0) {
  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(!isalive(self.enemy)) {
    return anim.failure;
  }

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return anim.failure;
  }

  var1 = 0;

  if(isDefined(anim.throwgrenadeatplayerasap) && isPlayer(self.enemy)) {
    var1 = 1;
  } else if(isDefined(self.throwgrenadeatenemyasap)) {
    var1 = 1;
  }

  if(!var1) {
    return anim.failure;
  }

  scripts\aitypes\throwgrenade::setactivegrenadetimer(self.enemy);
  return anim.success;
}

function shouldthrowgrenade(var0) {
  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(self.doingambush) {
    return anim.failure;
  }

  if(self.grenadeammo <= 0) {
    return anim.failure;
  }

  if(nullweapon(self.grenadeweapon)) {
    return anim.failure;
  }

  if(isDefined(self.enemy) && isDefined(self.enemy.dontgrenademe)) {
    return anim.failure;
  }

  var1 = self.covernode;

  if(var1.type == "Cover Prone" || var1.type == "Conceal Prone") {
    return anim.failure;
  }

  if(istrue(self.nogrenadethrow)) {
    return anim.failure;
  }

  var2 = self.enemy;
  var3 = anglesToForward(var1.angles);
  var4 = var2.origin - self.origin;
  var5 = lengthsquared(var4);
  var6 = 2560000;

  if(var5 > var6) {
    return anim.failure;
  }

  var7 = vectorNormalize(var4);

  if(vectordot(var3, var7) < 0) {
    return anim.failure;
  }

  var8 = 0.4;
  var9 = gettime();

  if(isDefined(self.bt.cover.lastgrenadethrowchecktime) && var9 < self.bt.cover.lastgrenadethrowchecktime + var8) {
    return anim.failure;
  }

  self.bt.cover.lastgrenadethrowchecktime = var9;

  if(self.doingambush && !scripts\anim\utility_common::recentlysawenemy()) {
    return anim.failure;
  }

  if(istrue(self.dontevershoot) || istrue(var2.dontattackme)) {
    return anim.failure;
  }

  scripts\aitypes\throwgrenade::setactivegrenadetimer(self.enemy);

  if(!scripts\aitypes\throwgrenade::grenadecooldownelapsed(var2)) {
    return anim.failure;
  }

  if(scripts\anim\utility_common::canseeenemyfromexposed()) {
    if(!scripts\aitypes\throwgrenade::grenadepossafewrapper(var2, var2.origin)) {
      return anim.failure;
    }

    return anim.success;
  }

  if(scripts\anim\utility_common::cansuppressenemyfromexposed()) {
    return anim.success;
  }

  if(!scripts\aitypes\throwgrenade::grenadepossafewrapper(var2, var2.origin)) {
    return anim.failure;
  }

  return anim.success;
}

function initthrowgrenade(var0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(1, self.enemy);
  setcoverstate("hide");
  self.bt.instancedata[var0] = gettime() + 3000;
}

function coverthrowgrenade(var0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "end")) {
    return anim.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("throwgrenade", "start", 0)) {
    self.bt.instancedata[var0] += 10000;
  }

  if(gettime() > self.bt.instancedata[var0]) {
    return anim.failure;
  }

  return anim.running;
}

function terminatethrowgrenade(var0) {
  scripts\asm\asm_bb::bb_requestthrowgrenade(0);
  self.bt.instancedata[var0] = undefined;
}

function updatealwayscoverexposed(var0) {
  if(isDefined(self.balwayscoverexposed)) {
    if(self.health < self.maxhealth * 0.75) {
      self.balwayscoverexposed = undefined;
    } else if(isDefined(self._blackboard.scriptableparts) && self._blackboard.scriptableparts.size >= 2) {
      self.balwayscoverexposed = undefined;
    }
  }

  return anim.success;
}

function isalwayscoverexposed(var0) {
  if(self.doingambush) {
    return anim.success;
  }

  if(isDefined(self.balwayscoverexposed)) {
    return anim.success;
  }

  return anim.failure;
}

function updatecovercroucharrivaltype(var0) {
  if(!isDefined(self.node) || self.node.type != "Cover Crouch") {
    self._blackboard.croucharrivaltype = undefined;
    self._blackboard.croucharrivalnode = undefined;
    return anim.success;
  }

  if(!isDefined(self._blackboard.croucharrivaltype) || self._blackboard.croucharrivalnode != self.node) {
    var1 = self pathdisttogoal();

    if(var1 > 0 && var1 < 512) {
      var2 = getDvar("scr_ai_cover_crouch_type");

      if(isDefined(self.node.covercrouchtype)) {
        var2 = self.node.covercrouchtype;

        if(var2 != "Cover Right Crouch" && var2 != "Cover Left Crouch" && var2 != "Cover Crouch") {
          var2 = undefined;
        }
      } else if(var2 == "") {
        var2 = undefined;
      }

      self._blackboard.croucharrivalnode = self.node;
      self._blackboard.croucharrivaltype = var2;
    }
  }

  return anim.success;
}

function shouldcovermultiswitch(var0) {
  var1 = self.covernode;

  if(!isDefined(var1)) {
    return anim.failure;
  }

  if(!var1 iscovermultinode()) {
    return anim.failure;
  }

  return anim.success;
}

function covermultiswitch(var0) {
  if(scripts\asm\asm_bb::bb_iscovermultiswitchrequested()) {
    var1 = scripts\asm\asm_bb::bb_getrequestedcovermultiswitchnodetype();
    var2 = var1[0];
    var3 = var1[1];
    var1 = undefined;
    var4 = scripts\asm\asm_bb::bb_getcovernode();

    if(var3 == var2.type) {
      scripts\asm\asm_bb::bb_resetcovermultiswitch();
    }

    return anim.running;
  }

  var4 = scripts\asm\asm_bb::bb_getcovernode();
  var5 = scripts\engine\utility::getbestcovermultinodetype(var4);

  if(!isDefined(var5)) {
    return anim.failure;
  }

  if(var4.type == var5) {
    return anim.failure;
  }

  scripts\asm\asm_bb::bb_requestcoverstate("hide");
  scripts\asm\asm_bb::bb_requestcovermultiswitch(var4, var5);
  return anim.running;
}

function terminatecovermultiswitch(var0) {
  if(scripts\asm\asm_bb::bb_iscovermultiswitchrequested()) {
    scripts\asm\asm_bb::bb_resetcovermultiswitch();
    return;
  }
}

function covershouldexposenoenemy(var0) {
  if(!istrue(self.coverexposenoenemy)) {
    return anim.failure;
  }

  if(!isDefined(self.enemy)) {
    return anim.success;
  }

  return anim.failure;
}

function initcoverexposenoenemy(var0) {
  var1 = scripts\asm\asm_bb::bb_getcovernode();

  if(scripts\engine\utility::isnodecoverleft(var1) || scripts\engine\utility::isnodecoverright(var1)) {
    scripts\asm\asm_bb::bb_requestcoverexposetype("B");
  } else if(var1 doesnodeallowstance("stand")) {
    scripts\asm\asm_bb::bb_requestcoverexposetype("full exposed");
  } else {
    scripts\asm\asm_bb::bb_requestcoverexposetype("exposed");
  }

  setcoverstate("exposed");
  scripts\asm\asm_bb::bb_claimshootparams(var0);
}

function coverexposenoenemy(var0) {
  var1 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(self.coverexposenewtargettime) || self.coverexposenewtargettime < gettime()) {
    var2 = randomintrange(self.coverexposenoenemytimemin, self.coverexposenoenemytimemax);
    self.coverexposenewtargettime = gettime() + int(var2 * 1000);
    var3 = undefined;

    if(!isDefined(self.enemy)) {
      var4 = var1.angles;
      var3 = (var4[0], var4[1] + randomintrange(0 - self.coverexposenoenemyangle, self.coverexposenoenemyangle), var4[2]);
    } else {
      var5 = self lastknownpos(self.enemy);

      if(distancesquared(var5, self.enemy.origin) < 62500) {
        var3 = self getanglestolikelyenemypath();

        if(isDefined(var3) && anglesdelta(var3, var1.angles) > 50) {
          var3 = undefined;
        }
      }

      if(!isDefined(var3)) {
        var3 = var1.angles;
      }
    }

    if(isDefined(var3)) {
      var6 = anglesToForward(var3) * 500;
      var7 = self getapproxeyepos() + var6;

      if(!istrue(self._blackboard.shootparams_valid)) {
        scripts\asm\asm_bb::bb_newshootparams(var7, undefined, 0);
      } else {
        scripts\asm\asm_bb::bb_updateshootparams(var7, undefined, 0);
      }

      self._blackboard.shootparams_forceaim = 1;
      self.shootposoverride = 1;
    }
  }

  return anim.running;
}

function terminatecoverexposenoenemy(var0) {
  self._blackboard.shootparams_forceaim = undefined;
  self.shootposoverride = undefined;

  if(istrue(self._blackboard.shootparams_valid) && self._blackboard.shootparams_taskid == var0) {
    scripts\asm\asm_bb::bb_clearshootparams();
    return;
  }
}

function covershouldexposelostenemy(var0) {
  if(!istrue(self.coverexposenoenemy)) {
    return anim.failure;
  }

  if(!isDefined(self.enemy)) {
    return anim.failure;
  }

  if(!issentient(self.enemy)) {
    return anim.failure;
  }

  if(gettime() - self lastknowntime(self.enemy) > self.coverexposelostenemytime * 1000) {
    var1 = self getsecondarytargets();

    if(!isDefined(var1) || var1.size == 0) {
      return anim.success;
    }
  }

  return anim.failure;
}