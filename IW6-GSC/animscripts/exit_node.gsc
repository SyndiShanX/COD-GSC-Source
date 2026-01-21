/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\exit_node.gsc
*****************************************************/

startmovetransition() {
  if(isDefined(self.custommovetransition)) {
    custommovetransition();
    return;
  }

  self endon("killanimscript");

  if(!checktransitionpreconditions()) {
    return;
  }
  var_0 = self.origin;
  var_1 = self.angles[1];
  var_2 = "exposed";
  var_3 = 0;
  var_4 = getexitnode();

  if(isDefined(var_4)) {
    var_5 = determinenodeexittype(var_4);

    if(isDefined(var_5)) {
      var_2 = var_5;
      var_3 = 1;

      if(isDefined(self.heat))
        var_2 = determineheatcoverexittype(var_4, var_2);

      if(!isDefined(anim.exposedtransition[var_2]) && var_2 != "stand_saw" && var_2 != "crouch_saw") {
        var_6 = animscripts\utility::absangleclamp180(self.angles[1] - animscripts\utility::getnodeforwardyaw(var_4));

        if(var_6 < 5) {
          if(!isDefined(self.heat))
            var_0 = var_4.origin;

          var_1 = animscripts\utility::getnodeforwardyaw(var_4);
        }
      }
    }
  }

  if(!checktransitionconditions(var_2, var_4)) {
    return;
  }
  var_7 = isDefined(anim.exposedtransition[var_2]);

  if(!var_3)
    var_2 = determinenonnodeexittype();

  var_8 = (-1 * self.lookaheaddir[0], -1 * self.lookaheaddir[1], 0);
  var_9 = getmaxdirectionsandexcludedirfromapproachtype(var_4);
  var_10 = var_9.maxdirections;
  var_11 = var_9.excludedir;
  var_12 = spawnStruct();
  calculatenodetransitionangles(var_12, var_2, 0, var_1, var_8, var_10, var_11);
  sortnodetransitionangles(var_12, var_10);
  var_13 = -1;
  var_14 = 3;

  if(var_7)
    var_14 = 1;

  for(var_15 = 1; var_15 <= var_14; var_15++) {
    var_13 = var_12.transindex[var_15];

    if(checknodeexitpos(var_0, var_1, var_2, var_7, var_13)) {
      break;
    }
  }

  if(var_15 > var_14) {
    return;
  }
  var_16 = distancesquared(self.origin, self.coverexitpos) * 1.25 * 1.25;

  if(distancesquared(self.origin, self.pathgoalpos) < var_16) {
    return;
  }
  donodeexitanimation(var_2, var_13);
}

determinenodeexittype(var_0) {
  if(animscripts\cover_arrival::canusesawapproach(var_0)) {
    if(var_0.type == "Cover Stand")
      return "stand_saw";

    if(var_0.type == "Cover Crouch")
      return "crouch_saw";
    else if(var_0.type == "Cover Prone")
      return "prone_saw";
  }

  if(!isDefined(anim.approach_types[var_0.type])) {
    return;
  }
  if(isDefined(anim.requiredexitstance[var_0.type]) && anim.requiredexitstance[var_0.type] != self.a.pose) {
    return;
  }
  var_1 = self.a.pose;

  if(var_1 == "prone")
    var_1 = "crouch";

  var_2 = anim.approach_types[var_0.type][var_1];

  if(animscripts\cover_arrival::usereadystand() && var_2 == "exposed")
    var_2 = "exposed_ready";

  if(animscripts\utility::shouldcqb()) {
    var_3 = var_2 + "_cqb";

    if(isDefined(anim.archetypes["soldier"]["cover_exit"][var_3]))
      var_2 = var_3;
  }

  return var_2;
}

checktransitionpreconditions() {
  if(!isDefined(self.pathgoalpos))
    return 0;

  if(!self shouldfacemotion())
    return 0;

  if(self.a.pose == "prone")
    return 0;

  if(isDefined(self.disableexits) && self.disableexits)
    return 0;

  if(self.stairsstate != "none")
    return 0;

  if(!self isstanceallowed("stand") && !isDefined(self.heat))
    return 0;

  if(distancesquared(self.origin, self.pathgoalpos) < 10000)
    return 0;

  return 1;
}

checktransitionconditions(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 == "exposed" || isDefined(self.heat)) {
    if(self.a.pose != "stand" && self.a.pose != "crouch")
      return 0;

    if(self.a.movement != "stop")
      return 0;
  }

  if(!isDefined(self.heat) && isDefined(self.enemy) && vectordot(self.lookaheaddir, self.enemy.origin - self.origin) < 0) {
    if(animscripts\utility::canseeenemyfromexposed() && distancesquared(self.origin, self.enemy.origin) < 90000)
      return 0;
  }

  return 1;
}

determinenonnodeexittype(var_0) {
  if(self.a.pose == "stand")
    var_0 = "exposed";
  else
    var_0 = "exposed_crouch";

  if(animscripts\cover_arrival::usereadystand())
    var_0 = "exposed_ready";

  if(animscripts\utility::shouldcqb())
    var_0 = var_0 + "_cqb";
  else if(isDefined(self.heat))
    var_0 = "heat";

  return var_0;
}

getmaxdirectionsandexcludedirfromapproachtype(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0) && isDefined(anim.maxdirections[var_0.type])) {
    var_1.maxdirections = anim.maxdirections[var_0.type];
    var_1.excludedir = anim.excludedir[var_0.type];
  } else {
    var_1.maxdirections = 9;
    var_1.excludedir = -1;
  }

  return var_1;
}

calculatenodetransitionangles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0.transitions = [];
  var_0.transindex = [];
  var_7 = undefined;
  var_8 = 1;
  var_9 = 0;

  if(var_2) {
    var_7 = animscripts\utility::lookupanim("cover_trans_angles", var_1);
    var_8 = -1;
    var_9 = 0;
  } else {
    var_7 = animscripts\utility::lookupanim("cover_exit_angles", var_1);
    var_8 = 1;
    var_9 = 180;
  }

  for(var_10 = 1; var_10 <= var_5; var_10++) {
    var_0.transindex[var_10] = var_10;

    if(var_10 == 5 || var_10 == var_6 || !isDefined(var_7[var_10])) {
      var_0.transitions[var_10] = -1.0003;
      continue;
    }

    var_11 = (0, var_3 + var_8 * var_7[var_10] + var_9, 0);
    var_12 = vectornormalize(anglesToForward(var_11));
    var_0.transitions[var_10] = vectordot(var_4, var_12);
  }
}

sortnodetransitionangles(var_0, var_1) {
  for(var_2 = 2; var_2 <= var_1; var_2++) {
    var_3 = var_0.transitions[var_0.transindex[var_2]];
    var_4 = var_0.transindex[var_2];

    for(var_5 = var_2 - 1; var_5 >= 1; var_5--) {
      if(var_3 < var_0.transitions[var_0.transindex[var_5]]) {
        break;
      }

      var_0.transindex[var_5 + 1] = var_0.transindex[var_5];
    }

    var_0.transindex[var_5 + 1] = var_4;
  }
}

checknodeexitpos(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, var_1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = animscripts\utility::lookuptransitionanim("cover_exit_dist", var_2, var_4);
  var_9 = var_6 * var_8[0];
  var_10 = var_7 * var_8[1];
  var_11 = var_0 + var_9 - var_10;
  self.coverexitpos = var_11;

  if(!var_3 && !self checkcoverexitposwithpath(var_11))
    return 0;

  if(!self maymovefrompointtopoint(self.origin, var_11))
    return 0;

  if(var_4 <= 6 || var_3)
    return 1;

  var_12 = animscripts\utility::lookuptransitionanim("cover_exit_postdist", var_2, var_4);
  var_9 = var_6 * var_12[0];
  var_10 = var_7 * var_12[1];
  var_13 = var_11 + var_9 - var_10;
  self.coverexitpos = var_13;
  return self maymovefrompointtopoint(var_11, var_13);
}

#using_animtree("generic_human");

donodeexitanimation(var_0, var_1) {
  var_2 = animscripts\utility::lookuptransitionanim("cover_exit", var_0, var_1);
  var_3 = vectortoangles(self.lookaheaddir);

  if(self.a.pose == "prone") {
    return;
  }
  var_5 = 0.2;

  if(self.swimmer)
    self animmode("nogravity", 0);
  else
    self animmode("zonly_physics", 0);

  self orientmode("face angle", self.angles[1]);
  self setflaggedanimknoballrestart("coverexit", var_2, %body, 1, var_5, self.movetransitionrate);
  animscripts\shared::donotetracks("coverexit");
  self.a.pose = "stand";
  self.a.movement = "run";
  self.ignorepathchange = undefined;
  self orientmode("face motion");
  self animmode("none", 0);
  finishcoverexitnotetracks("coverexit");
  self clearanim(%root, 0.2);
  self orientmode("face default");
  self animmode("normal", 0);
}

finishcoverexitnotetracks(var_0) {
  self endon("move_loop_restart");
  animscripts\shared::donotetracks(var_0);
}

determineheatcoverexittype(var_0, var_1) {
  if(var_0.type == "Cover Right")
    var_1 = "heat_right";
  else if(var_0.type == "Cover Left")
    var_1 = "heat_left";

  return var_1;
}

getexitnode() {
  var_0 = undefined;

  if(!isDefined(self.heat))
    var_1 = 400;
  else
    var_1 = 4096;

  if(animscripts\utility::isspaceai())
    var_1 = 1024;

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
    var_0 = self.node;
  else if(isDefined(self.prevnode) && distancesquared(self.origin, self.prevnode.origin) < var_1)
    var_0 = self.prevnode;

  if(isDefined(var_0) && isDefined(self.heat) && animscripts\utility::absangleclamp180(self.angles[1] - var_0.angles[1]) > 30)
    return undefined;

  return var_0;
}

custommovetransition() {
  var_0 = self.custommovetransition;

  if(!isDefined(self.permanentcustommovetransition))
    self.custommovetransition = undefined;

  var_1 = [[var_0]]();

  if(!isDefined(self.permanentcustommovetransition))
    self.startmovetransitionanim = undefined;

  if(!isDefined(var_1))
    var_1 = 0.2;

  self clearanim(%root, var_1);
  self orientmode("face default");
  self animmode("none", 0);
}

debug_arrival(var_0) {
  if(!animscripts\cover_arrival::debug_arrivals_on_actor())
    return;
}