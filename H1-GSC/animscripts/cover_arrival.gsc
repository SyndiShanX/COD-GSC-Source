/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\cover_arrival.gsc
*****************************************/

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  self endon("abort_approach");

  if(self.swimmer) {
    animscripts\swim::swim_coverarrival_main();
    return;
  }

  if(isdefined(self.customarrivalfunc)) {
    [
      [self.customarrivalfunc]
    ]();
    return;
  }

  var_0 = self.approachnumber;
  var_1 = animscripts\utility::lookupanim("cover_trans", self.approachtype)[var_0];

  if(!isdefined(self.heat))
    thread abortapproachifthreatened();

  self clearanim( % body, 0.2);
  self setflaggedanimrestart("coverArrival", var_1, 1, 0.2, self.movetransitionrate);
  animscripts\face::playfacialanim(var_1, "run");
  animscripts\shared::donotetracks("coverArrival", ::handlestartaim);
  var_2 = anim.arrivalendstance[self.approachtype];

  if(isdefined(var_2))
    self.a.pose = var_2;

  self.a.movement = "stop";
  self.a.arrivaltype = self.approachtype;
  self clearanim( % animscript_root, 0.2);
  self.lastapproachaborttime = undefined;
}

handlestartaim(var_0) {
  if(var_0 == "start_aim") {
    if(isdefined(self.a.dontstartaim) && self.a.dontstartaim) {
      return;
    }
    if(self.a.pose == "stand")
      animscripts\animset::set_animarray_standing();
    else if(self.a.pose == "crouch")
      animscripts\animset::set_animarray_crouching();
    else {

    }

    animscripts\combat::set_aim_and_turn_limits();
    self.previouspitchdelta = 0.0;
    animscripts\combat_utility::setupaim(0.2);
    thread animscripts\track::trackshootentorpos();
  }
}

isthreatenedbyenemy() {
  if(!isdefined(self.node))
    return 0;

  if(isdefined(self.enemy) && self seerecently(self.enemy, 1.5) && distancesquared(self.origin, self.enemy.origin) < 250000)
    return !self iscovervalidagainstenemy();

  return 0;
}

abortapproachifthreatened() {
  self endon("killanimscript");

  for (;;) {
    if(!isdefined(self.node)) {
      return;
    }
    if(isthreatenedbyenemy()) {
      self clearanim( % animscript_root, 0.3);
      self notify("abort_approach");
      self.lastapproachaborttime = gettime();
      return;
    }

    wait 0.1;
  }
}

canusesawapproach(var_0) {
  if(!animscripts\utility::usingmg())
    return 0;

  if(!isdefined(var_0.turretinfo))
    return 0;

  if(var_0.type != "Cover Stand" && var_0.type != "Cover Prone" && var_0.type != "Cover Crouch")
    return 0;

  if(isdefined(self.enemy) && distancesquared(self.enemy.origin, var_0.origin) < 65536)
    return 0;

  if(animscripts\utility::getnodeyawtoenemy() > 40 || animscripts\utility::getnodeyawtoenemy() < -40)
    return 0;

  return 1;
}

determinenodeapproachtype(var_0) {
  if(isdefined(self.mech) && self.mech)
    return "exposed";

  var_1 = var_0.type;

  if(animscripts\utility::is_free_running() && var_1 == "Cover Crouch")
    return "free_run_into_cover_crouch";

  if(var_1 == "Cover Multi") {
    if(!isdefined(self.cover))
      self.cover = spawnstruct();

    var_2 = animscripts\cover_multi::covermulti_getbestvaliddir(["over", ["left", "right"]]);
    self.cover.arrivalnodetype = var_2;
    var_3 = animscripts\cover_multi::covermulti_getstatefromdir(var_0, var_2);
    var_1 = animscripts\utility::getcovermultipretendtype(var_0, var_3);
  }

  if(canusesawapproach(var_0)) {
    if(var_1 == "Cover Stand")
      return "stand_saw";

    if(var_1 == "Cover Crouch")
      return "crouch_saw";
    else if(var_1 == "Cover Prone")
      return "prone_saw";
  }

  if(!isdefined(anim.approach_types[var_1])) {
    return;
  }
  if(isdefined(var_0.arrivalstance))
    var_4 = var_0.arrivalstance;
  else if(isdefined(var_0.classname) && var_0.classname == "script_origin")
    var_4 = "stand";
  else
    var_4 = var_0 gethighestnodestance();

  if(var_4 == "prone")
    var_4 = "crouch";

  var_5 = anim.approach_types[var_1][var_4];

  if(usereadystand() && var_5 == "exposed")
    var_5 = "exposed_ready";

  if(animscripts\utility::isunstableground()) {
    if(var_5 == "exposed") {
      var_5 = "exposed_unstable";

      if(self.movemode == "run")
        var_5 = var_5 + "_run";

      return var_5;
    } else if(var_5 == "stand") {
      var_5 = "stand_unstable";

      if(self.movemode == "run")
        var_5 = var_5 + "_run";

      return var_5;
    }
  }

  if(animscripts\utility::shouldcqb()) {
    var_6 = var_5 + "_cqb";

    if(isdefined(anim.archetypes["soldier"]["cover_trans"][var_6]))
      var_5 = var_6;
  }

  return var_5;
}

determineexposedapproachtype(var_0) {
  if(isdefined(self.heat))
    return "heat";

  if(isdefined(var_0.arrivalstance))
    var_1 = var_0.arrivalstance;
  else
    var_1 = var_0 gethighestnodestance();

  if(var_1 == "prone")
    var_1 = "crouch";

  if(var_1 == "crouch")
    var_2 = "exposed_crouch";
  else
    var_2 = "exposed";

  if(var_2 == "exposed" && usereadystand())
    var_2 = var_2 + "_ready";

  if(var_2 == "exposed" && animscripts\utility::isunstableground()) {
    var_2 = "exposed_unstable";

    if(self.movemode == "run")
      var_2 = var_2 + "_run";

    return var_2;
  }

  if(animscripts\utility::shouldcqb())
    return var_2 + "_cqb";

  return var_2;
}

calculatenodeoffsetfromanimationdelta(var_0, var_1) {
  var_2 = anglestoright(var_0);
  var_3 = anglestoforward(var_0);
  return var_3 * var_1[0] + var_2 * (0 - var_1[1]);
}

getapproachent() {
  if(isdefined(self.scriptedarrivalent))
    return self.scriptedarrivalent;

  if(isdefined(self.node))
    return self.node;

  return undefined;
}

getapproachpoint(var_0, var_1) {
  if(var_1 == "stand_saw") {
    var_2 = (var_0.turretinfo.origin[0], var_0.turretinfo.origin[1], var_0.origin[2]);
    var_3 = anglestoforward((0, var_0.turretinfo.angles[1], 0));
    var_4 = anglestoright((0, var_0.turretinfo.angles[1], 0));
    var_2 = var_2 + var_3 * -32.545 - var_4 * 6.899;
  } else if(var_1 == "crouch_saw") {
    var_2 = (var_0.turretinfo.origin[0], var_0.turretinfo.origin[1], var_0.origin[2]);
    var_3 = anglestoforward((0, var_0.turretinfo.angles[1], 0));
    var_4 = anglestoright((0, var_0.turretinfo.angles[1], 0));
    var_2 = var_2 + var_3 * -32.545 - var_4 * 6.899;
  } else if(var_1 == "prone_saw") {
    var_2 = (var_0.turretinfo.origin[0], var_0.turretinfo.origin[1], var_0.origin[2]);
    var_3 = anglestoforward((0, var_0.turretinfo.angles[1], 0));
    var_4 = anglestoright((0, var_0.turretinfo.angles[1], 0));
    var_2 = var_2 + var_3 * -37.36 - var_4 * 13.279;
  } else if(isdefined(self.scriptedarrivalent))
    var_2 = self.goalpos;
  else
    var_2 = var_0.origin;

  return var_2;
}

checkapproachpreconditions() {
  if(isdefined(self getnegotiationstartnode()))
    return 0;

  if(isdefined(self.disablearrivals) && self.disablearrivals)
    return 0;

  return 1;
}

checkapproachconditions(var_0, var_1, var_2) {
  if(isdefined(anim.exposedtransition[var_0]))
    return 0;

  if(var_0 == "stand" || var_0 == "crouch" || var_0 == "stand_unstable") {
    if(animscripts\utility::absangleclamp180(vectortoyaw(var_1) - var_2.angles[1] + 180) < 60)
      return 0;
  }

  if(isthreatenedbyenemy() || isdefined(self.lastapproachaborttime) && self.lastapproachaborttime + 500 > gettime())
    return 0;

  return 1;
}

setupapproachnode(var_0) {
  self endon("killanimscript");

  if(isdefined(self.heat)) {
    thread dolastminuteexposedapproachwrapper();
    return;
  }

  if(var_0)
    self.requestarrivalnotify = 1;

  if(self.swimmer == 1) {
    thread animscripts\swim::swim_setupapproach();
    return;
  }

  self.a.arrivaltype = undefined;
  thread dolastminuteexposedapproachwrapper();
  self waittill("cover_approach", var_1);

  if(!checkapproachpreconditions()) {
    return;
  }
  thread setupapproachnode(0);
  var_2 = "exposed";
  var_3 = self.pathgoalpos;
  var_4 = vectortoyaw(var_1);
  var_5 = var_4;
  var_6 = getapproachent();

  if(isdefined(var_6)) {
    var_2 = determinenodeapproachtype(var_6);

    if(isdefined(var_2) && var_2 != "exposed") {
      var_3 = getapproachpoint(var_6, var_2);
      var_4 = var_6.angles[1];
      var_5 = animscripts\utility::getnodeforwardyaw(var_6);
    }
  } else if(usereadystand()) {
    if(animscripts\utility::shouldcqb())
      var_2 = "exposed_ready_cqb";
    else
      var_2 = "exposed_ready";
  }

  if(!checkapproachconditions(var_2, var_1, var_6)) {
    return;
  }
  startcoverapproach(var_2, var_3, var_4, var_5, var_1);
}

coverapproachlastminutecheck(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(self.disablearrivals) && self.disablearrivals)
    return 0;

  if(abs(self getmotionangle()) > 45 && isdefined(self.enemy) && vectordot(anglestoforward(self.angles), vectornormalize(self.enemy.origin - self.origin)) > 0.8)
    return 0;

  if(self.a.pose != "stand" || self.a.movement != "run" && !animscripts\utility::iscqbwalkingorfacingenemy())
    return 0;

  if(animscripts\utility::absangleclamp180(var_4 - self.angles[1]) > 30) {
    if(isdefined(self.enemy) && self cansee(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 65536) {
      if(vectordot(anglestoforward(self.angles), self.enemy.origin - self.origin) > 0)
        return 0;
    }
  }

  if(!checkcoverenterpos(var_0, var_1, var_2, var_3, 0))
    return 0;

  return 1;
}

approachwaittillclose(var_0, var_1, var_2) {
  if(!isdefined(var_0)) {
    return;
  }
  var_3 = undefined;

  for (;;) {
    if(!isdefined(self.pathgoalpos))
      waitforpathgoalpos();

    var_4 = distance(self.origin, self.pathgoalpos);

    if(isdefined(var_2)) {
      var_5 = calculateapproachdir();
      var_6 = calculatedesiredfacingyaw(var_5);
      var_7 = calculatelastminuteanimdistance(var_5, var_6, var_0, 1, var_2.approachtype);
      var_8 = vectornormalize(var_2.approachpoint - self.origin);
      var_3 = checkarrivalenterpositions(var_2.approachpoint, var_2.approachfinalyaw, var_2.approachtype, var_8, var_2.maxdirections, var_2.excludedir, var_2.arrivalfromfront);

      if(var_3.approachnumber > 0)
        var_1 = length(animscripts\utility::lookuptransitionanim("cover_trans_dist", var_2.approachtype, var_3.approachnumber));
    }

    if(var_4 <= var_1 + 8) {
      break;
    }

    var_9 = self.moveplaybackrate;

    if(level.script == "scoutsniper" && self getanimweight( % h1_sprint_loop) > 0.5)
      var_9 = var_9 * 1.25;

    var_10 = (var_4 - var_1) / (250 * var_9) - 0.1;

    if(var_10 < 0.05)
      var_10 = 0.05;

    wait(var_10);
  }

  return var_3;
}

startcoverapproach(var_0, var_1, var_2, var_3, var_4) {
  self endon("killanimscript");
  self endon("cover_approach");

  if(isdefined(self.disablearrivals) && self.disablearrivals) {
    return;
  }
  var_5 = getapproachent();
  var_6 = animscripts\exit_node::getmaxdirectionsandexcludedirfromapproachtype(var_5);
  var_7 = var_6.maxdirections;
  var_8 = var_6.excludedir;
  var_9 = vectordot(var_4, anglestoforward(var_5.angles)) >= 0;
  var_6 = checkarrivalenterpositions(var_1, var_3, var_0, var_4, var_7, var_8, var_9);

  if(var_6.approachnumber < 0) {
    return;
  }
  var_10 = var_6.approachnumber;

  if(var_10 <= 6 && var_9) {
    self endon("goal_changed");

    if(isdefined(self.animarchetype) && isdefined(anim.archetypes[self.animarchetype]) && isdefined(anim.archetypes[self.animarchetype]["CoverTransLongestDist"][var_0]))
      self.arrivalstartdist = anim.archetypes[self.animarchetype]["CoverTransLongestDist"][var_0];
    else if(isdefined(anim.archetypes["soldier"]["CoverTransLongestDist"][var_0]))
      self.arrivalstartdist = anim.archetypes["soldier"]["CoverTransLongestDist"][var_0];
    else
      self.arrivalstartdist = 8;

    approachwaittillclose(var_5, self.arrivalstartdist);
    var_11 = vectornormalize(var_1 - self.origin);
    var_6 = checkarrivalenterpositions(var_1, var_3, var_0, var_11, var_7, var_8, var_9);
    self.arrivalstartdist = length(animscripts\utility::lookuptransitionanim("cover_trans_dist", var_0, var_10));
    var_12 = spawnstruct();
    var_12.approachtype = var_0;
    var_12.approachpoint = var_1;
    var_12.arrivalfromfront = var_9;
    var_12.excludedir = var_8;
    var_12.maxdirections = var_7;
    var_12.approachfinalyaw = var_3;
    var_6 = approachwaittillclose(var_5, self.arrivalstartdist, var_12);

    if(!self maymovetopoint(var_1)) {
      self.arrivalstartdist = undefined;
      return;
    }

    if(var_6.approachnumber < 0) {
      self.arrivalstartdist = undefined;
      return;
    }

    var_10 = var_6.approachnumber;
    var_13 = var_3 - animscripts\utility::lookuptransitionanim("cover_trans_angles", var_0, var_10);
  } else {
    self setruntopos(self.coverenterpos);
    self waittill("runto_arrived");
    var_13 = var_3 - animscripts\utility::lookuptransitionanim("cover_trans_angles", var_0, var_10);

    if(!coverapproachlastminutecheck(var_1, var_3, var_0, var_10, var_13))
      return;
  }

  self.approachnumber = var_10;
  self.approachtype = var_0;
  self.arrivalstartdist = undefined;

  if(animscripts\utility::using_cover_transition_angle_correction()) {
    self.arrivalanim = animscripts\utility::lookupanim("cover_trans", self.approachtype)[self.approachnumber];
    var_14 = animscripts\utility::lookuptransitionanim("cover_trans_move_end", var_0, self.approachnumber);
    self.arrivalangles = self _meth_8567(self.coverenterpos, var_13, 0, self.arrivalanim, var_14);
  } else
    self.arrivalangles = self startcoverarrival(self.coverenterpos, var_13, 0);
}

checkarrivalenterpositions(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnstruct();
  animscripts\exit_node::calculatenodetransitionangles(var_7, var_2, 1, var_1, var_3, var_4, var_5);
  animscripts\exit_node::sortnodetransitionangles(var_7, var_4);
  var_8 = spawnstruct();
  var_9 = (0, 0, 0);
  var_8.approachnumber = -1;
  var_10 = 2;

  for (var_11 = 1; var_11 <= var_10; var_11++) {
    var_8.approachnumber = var_7.transindex[var_11];

    if(!checkcoverenterpos(var_0, var_1, var_2, var_8.approachnumber, var_6)) {
      continue;
    }
    break;
  }

  if(var_11 > var_10) {
    var_8.approachnumber = -1;
    return var_8;
  }

  var_12 = distancesquared(var_0, self.origin);
  var_13 = distancesquared(var_0, self.coverenterpos);

  if(var_12 < var_13 * 2 * 2) {
    if(var_12 < var_13) {
      var_8.approachnumber = -1;
      return var_8;
    }

    if(!var_6) {
      var_14 = vectornormalize(self.coverenterpos - self.origin);
      var_15 = var_1 - animscripts\utility::lookuptransitionanim("cover_trans_angles", var_2, var_8.approachnumber);
      var_16 = anglestoforward((0, var_15, 0));
      var_17 = vectordot(var_14, var_16);

      if(var_17 < 0.707) {
        var_8.approachnumber = -1;
        return var_8;
      }
    }
  }

  return var_8;
}

dolastminuteexposedapproachwrapper() {
  self endon("killanimscript");
  self endon("move_interrupt");
  self notify("doing_last_minute_exposed_approach");
  self endon("doing_last_minute_exposed_approach");
  thread watchgoalchanged();

  for (;;) {
    dolastminuteexposedapproach();

    for (;;) {
      common_scripts\utility::waittill_any("goal_changed", "goal_changed_previous_frame");

      if(isdefined(self.coverenterpos) && isdefined(self.pathgoalpos) && distance2d(self.coverenterpos, self.pathgoalpos) < 1) {
        continue;
      }
      break;
    }
  }
}

watchgoalchanged() {
  self endon("killanimscript");
  self endon("doing_last_minute_exposed_approach");

  for (;;) {
    self waittill("goal_changed");
    wait 0.05;
    self notify("goal_changed_previous_frame");
  }
}

exposedapproachconditioncheck(var_0, var_1) {
  if(!isdefined(self.pathgoalpos))
    return 0;

  if(isdefined(self.disablearrivals) && self.disablearrivals)
    return 0;

  if(isdefined(self.approachconditioncheckfunc)) {
    if(!self[[self.approachconditioncheckfunc]](var_0))
      return 0;
  } else {
    if(!self.facemotion && (!isdefined(var_0) || var_0.type == "Path" || var_0.type == "Path 3D"))
      return 0;

    if(self.a.pose != "stand")
      return 0;
  }

  if(isthreatenedbyenemy() || isdefined(self.lastapproachaborttime) && self.lastapproachaborttime + 500 > gettime())
    return 0;

  if(!self maymovetopoint(self.pathgoalpos, 1, 0, level.h1_arrival_ignores_player))
    return 0;

  return 1;
}

exposedapproachwaittillclose() {
  for (;;) {
    if(!isdefined(self.pathgoalpos))
      waitforpathgoalpos();

    var_0 = getapproachent();

    if(isdefined(var_0) && !isdefined(self.heat))
      var_1 = var_0.origin;
    else
      var_1 = self.pathgoalpos;

    var_2 = distance(self.origin, var_1);
    var_3 = 0;

    if(isdefined(self.animarchetype) && isdefined(anim.archetypes[self.animarchetype]) && isdefined(anim.archetypes[self.animarchetype]["longestExposedApproachDist"]))
      var_3 = anim.archetypes[self.animarchetype]["longestExposedApproachDist"];
    else
      var_3 = anim.archetypes["soldier"]["longestExposedApproachDist"];

    if(var_2 <= var_3 + 8) {
      break;
    }

    var_4 = (var_2 - var_3) / (250 * self.moveplaybackrate) - 0.1;

    if(var_4 < 0) {
      break;
    }

    if(var_4 < 0.05)
      var_4 = 0.05;

    wait(var_4);
  }
}

faceenemyatendofapproach(var_0) {
  if(!isdefined(self.enemy))
    return 0;

  if(isdefined(self.heat) && isdefined(var_0))
    return 0;

  if(self.combatmode == "cover" && issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 15000)
    return 0;

  if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
    return self cansee(self.enemy);

  return sighttracepassed(self.enemy getshootatpos(), self.pathgoalpos + (0, 0, 60), 0, undefined);
}

calculatelastminuteanimdistance(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(self.faceenemyarrival))
    var_1 = self.angles[1];
  else if(faceenemyatendofapproach(var_2))
    var_1 = vectortoyaw(self.enemy.origin - self.pathgoalpos);
  else {
    var_5 = isdefined(var_2) && var_3;
    var_5 = var_5 && var_2.type != "Path" && var_2.type != "Path 3D" && (var_2.type != "Ambush" || !animscripts\utility::recentlysawenemy());

    if(var_5)
      var_1 = animscripts\utility::getnodeforwardyaw(var_2);
    else {
      var_6 = self getanglestolikelyenemypath();

      if(isdefined(var_6))
        var_1 = var_6[1];
    }
  }

  var_7 = spawnstruct();
  animscripts\exit_node::calculatenodetransitionangles(var_7, var_4, 1, var_1, var_0, 9, -1);
  var_8 = 1;

  for (var_9 = 2; var_9 <= 9; var_9++) {
    if(var_7.transitions[var_9] > var_7.transitions[var_8])
      var_8 = var_9;
  }

  self.approachnumber = var_7.transindex[var_8];
  self.approachtype = var_4;
  var_10 = animscripts\utility::lookuptransitionanim("cover_trans", var_4, self.approachnumber);

  if(!isdefined(var_10) || isdefined(self.disableapproach)) {
    return;
  }
  var_11 = length(animscripts\utility::lookuptransitionanim("cover_trans_dist", var_4, self.approachnumber));
  return var_11;
}

calculatelastminuterequireddistsq(var_0) {
  var_1 = var_0 + 8;
  var_1 = var_1 * var_1;
  return var_1;
}

calculateapproachdir() {
  var_0 = vectornormalize(self.pathgoalpos - self.origin);
  return var_0;
}

calculatedesiredfacingyaw(var_0) {
  var_1 = vectortoyaw(var_0);
  return var_1;
}

dolastminuteexposedapproach() {
  self endon("goal_changed");
  self endon("move_interrupt");

  if(isdefined(self.disablearrivals) && self.disablearrivals) {
    return;
  }
  if(isdefined(self getnegotiationstartnode())) {
    return;
  }
  exposedapproachwaittillclose();

  if(isdefined(self.grenade) && isdefined(self.grenade.activator) && self.grenade.activator == self) {
    return;
  }
  var_0 = "exposed";
  var_1 = 1;

  if(isdefined(self.approachtypefunc))
    var_0 = self[[self.approachtypefunc]]();
  else if(animscripts\utility::isunstableground()) {
    var_0 = "exposed_unstable";

    if(self.movemode == "run")
      var_0 = var_0 + "_run";
  } else if(usereadystand()) {
    if(animscripts\utility::shouldcqb())
      var_0 = "exposed_ready_cqb";
    else
      var_0 = "exposed_ready";
  } else if(animscripts\utility::shouldcqb())
    var_0 = "exposed_cqb";
  else if(isdefined(self.heat)) {
    var_0 = "heat";
    var_1 = 4096;
  } else if(animscripts\utility::usingsmg())
    var_0 = "exposed_smg";

  var_2 = getapproachent();

  if(isdefined(var_2) && isdefined(self.pathgoalpos) && !isdefined(self.disablecoverarrivalsonly))
    var_3 = distancesquared(self.pathgoalpos, var_2.origin) < var_1;
  else
    var_3 = 0;

  if(var_3 && !isdefined(self.approachtypefunc))
    var_0 = determineexposedapproachtype(var_2);

  if(isdefined(self.mech) && self.mech)
    var_0 = "exposed";

  var_4 = calculateapproachdir();
  var_5 = calculatedesiredfacingyaw(var_4);
  var_6 = calculatelastminuteanimdistance(var_4, var_5, var_2, var_3, var_0);

  if(!isdefined(var_6)) {
    return;
  }
  var_7 = calculatelastminuterequireddistsq(var_6);

  while (isdefined(self.pathgoalpos) && isdefined(var_7) && distancesquared(self.origin, self.pathgoalpos) > var_7) {
    var_4 = calculateapproachdir();
    var_5 = calculatedesiredfacingyaw(var_4);
    var_6 = calculatelastminuteanimdistance(var_4, var_5, var_2, var_3, var_0);
    var_7 = calculatelastminuterequireddistsq(var_6);
    wait 0.05;
  }

  if(isdefined(self.arrivalstartdist) && self.arrivalstartdist < var_6 + 8) {
    return;
  }
  if(!exposedapproachconditioncheck(var_2, var_3)) {
    return;
  }
  var_8 = distance(self.origin, self.pathgoalpos);

  if(abs(var_8 - var_6) > 8) {
    return;
  }
  var_9 = vectortoyaw(self.pathgoalpos - self.origin);

  if(isdefined(self.heat) && var_3) {
    var_10 = var_5 - animscripts\utility::lookuptransitionanim("cover_trans_angles", var_0, self.approachnumber);
    var_11 = getarrivalstartpos(self.pathgoalpos, var_5, var_0, self.approachnumber);
  } else if(isdefined(self.a.forceapproachfacenodeyaw) && self.a.forceapproachfacenodeyaw) {
    var_5 = var_2.angles[1];
    var_10 = var_5 - animscripts\utility::lookuptransitionanim("cover_trans_angles", var_0, self.approachnumber);
    var_11 = getarrivalstartpos(self.pathgoalpos, var_5, var_0, self.approachnumber);
  } else if(var_6 > 0) {
    var_12 = animscripts\utility::lookuptransitionanim("cover_trans_dist", var_0, self.approachnumber);
    var_13 = atan(var_12[1] / var_12[0]);

    if(!isdefined(self.faceenemyarrival) || self.facemotion) {
      var_10 = var_9 - var_13;

      if(animscripts\utility::absangleclamp180(var_10 - self.angles[1]) > 30)
        return;
    } else
      var_10 = self.angles[1];

    var_14 = var_8 - var_6;
    var_11 = self.origin + vectornormalize(self.pathgoalpos - self.origin) * var_14;
  } else {
    var_10 = self.angles[1];
    var_11 = self.origin;
  }

  self.approachtype = var_0;

  if(animscripts\utility::using_cover_transition_angle_correction()) {
    self.arrivalanim = animscripts\utility::lookupanim("cover_trans", self.approachtype)[self.approachnumber];
    var_15 = animscripts\utility::lookuptransitionanim("cover_trans_move_end", var_0, self.approachnumber);
    self.arrivalangles = self _meth_8567(var_11, var_10, 0, self.arrivalanim, var_15);
  } else
    self.arrivalangles = self startcoverarrival(var_11, var_10, 0);
}

waitforpathgoalpos() {
  for (;;) {
    if(isdefined(self.pathgoalpos)) {
      return;
    }
    wait 0.1;
  }
}

custommovetransitionfunc() {
  if(!isdefined(self.startmovetransitionanim)) {
    return;
  }
  self animmode("zonly_physics", 0);
  self orientmode("face current");
  self setflaggedanimknoballrestart("move", self.startmovetransitionanim, % animscript_root, 1);
  animscripts\face::playfacialanim(self.startmovetransitionanim, "run");

  if(animhasnotetrack(self.startmovetransitionanim, "code_move")) {
    animscripts\shared::donotetracks("move");
    self orientmode("face motion");
    self animmode("none", 0);
  }

  animscripts\shared::donotetracks("move");
}

customidletransitionfunc() {
  if(!isdefined(self.startidletransitionanim)) {
    return;
  }
  var_0 = self.approachnumber;
  var_1 = self.startidletransitionanim;

  if(!isdefined(self.heat))
    thread abortapproachifthreatened();

  self clearanim( % body, 0.2);
  self setflaggedanimrestart("coverArrival", var_1, 1, 0.2, self.movetransitionrate);
  animscripts\face::playfacialanim(var_1, "run");
  animscripts\shared::donotetracks("coverArrival", ::handlestartaim);
  var_2 = anim.arrivalendstance[self.approachtype];

  if(isdefined(var_2))
    self.a.pose = var_2;

  self.a.movement = "stop";
  self.a.arrivaltype = self.approachtype;
  self clearanim( % animscript_root, 0.3);
  self.lastapproachaborttime = undefined;
}

str(var_0) {
  if(!isdefined(var_0))
    return "{undefined}";

  return var_0;
}

drawvec(var_0, var_1, var_2, var_3) {
  for (var_4 = 0; var_4 < var_2 * 100; var_4++)
    wait 0.05;
}

drawapproachvec(var_0) {
  self endon("killanimscript");

  for (;;) {
    if(!isdefined(self.node)) {
      break;
    }

    wait 0.05;
  }
}

getarrivalstartpos(var_0, var_1, var_2, var_3) {
  var_4 = (0, var_1 - animscripts\utility::lookuptransitionanim("cover_trans_angles", var_2, var_3), 0);
  var_5 = anglestoforward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = animscripts\utility::lookuptransitionanim("cover_trans_dist", var_2, var_3);
  var_8 = var_5 * var_7[0];
  var_9 = var_6 * var_7[1];
  return var_0 - var_8 + var_9;
}

getarrivalprestartpos(var_0, var_1, var_2, var_3) {
  var_4 = (0, var_1 - animscripts\utility::lookuptransitionanim("cover_trans_angles", var_2, var_3), 0);
  var_5 = anglestoforward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = animscripts\utility::lookuptransitionanim("cover_trans_predist", var_2, var_3);
  var_8 = var_5 * var_7[0];
  var_9 = var_6 * var_7[1];
  return var_0 - var_8 + var_9;
}

checkcoverenterpos(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getarrivalstartpos(var_0, var_1, var_2, var_3);
  self.coverenterpos = var_5;

  if(var_3 <= 6 && var_4)
    return 1;

  if(!self maymovefrompointtopoint(var_5, var_0))
    return 0;

  if(var_3 <= 6 || isdefined(anim.exposedtransition[var_2]))
    return 1;

  var_6 = getarrivalprestartpos(var_5, var_1, var_2, var_3);
  self.coverenterpos = var_6;
  return self maymovefrompointtopoint(var_6, var_5);
}

usereadystand() {
  if(!isdefined(anim.readystand_anims_inited))
    return 0;

  if(!anim.readystand_anims_inited)
    return 0;

  if(!isdefined(self.busereadyidle))
    return 0;

  if(!self.busereadyidle)
    return 0;

  return 1;
}

debug_arrivals_on_actor() {
  return 0;
}

debug_arrival(var_0) {
  if(!debug_arrivals_on_actor())
    return;
}