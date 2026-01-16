/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_arrival.gsc
*****************************************/

#include animscripts\setposemovement;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\debug;
#include animscripts\anims;
#include common_scripts\utility;
#include maps\_utility;
#include animscripts\shared;
#include maps\_dds;
#include animscripts\run;
#include animscripts\cqb;
#include animscripts\cover_arrival;
#using_animtree("generic_human");

main() {
  self animscripts\debug::debugpushstate("Cover Arrival");

  self endon("killanimscript");

  if(self.a.pose != "stand") {
    self animscripts\debug::debugpopstate("Cover Arrival", "Not standing");

    return;
  }

  newstance = getnewstance();

  if(newstance == "") {
    return;
  }
  assert(isDefined(self.approachanim), "Arrival anim not defined (" + self.animtype + " - exit_" + self.approachtype + " - " + self.approachnumber + ")");
  self clearanim( % root, 0.3);
  self setflaggedanimknobrestart("coverArrival", self.approachanim, 1, 0.3, 1);
  self animscripts\shared::donotetracks("coverArrival");
  self maps\_dds::dds_threat_notify(self.team != "allies");

  if(isDefined(newstance))
    self.a.pose = newstance;

  self.a.movement = "stop";
  self.a.arrivaltype = self.approachtype;
  self clearanim( % root, 0.3);

  self animscripts\debug::debugpopstate("Cover Arrival");
}

setupaapproachnodepreconditions() {
  if(isDefined(self getnegotiationstartnode())) {
    debug_arrival("Not doing approach: path has negotiation start node");

    return false;
  }

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    debug_arrival("Not doing approach: self.disableArrivals is true");

    return false;
  }

  if(!self isstanceallowed("stand") && !self isstanceallowed("crouch")) {
    debug_arrival("Not doing approach: May not be allowed to stand or crouch while arriving");

    return false;
  }

  if(self.a.pose == "prone") {
    debug_arrival("Not doing approach: (ent " + self getentnum() + "): self.a.pose is \"prone\"");

    return false;
  }

  return true;
}

setupapproachnode(firsttime) {
  self endon("killanimscript");

  if(firsttime)
    self.requestarrivalnotify = 1;

  self.a.arrivaltype = undefined;
  self thread dolastminuteexposedapproachwrapper();
  self waittill("corner_approach", approach_dir);

  if(!self setupaapproachnodepreconditions()) {
    return;
  }
  self thread setupapproachnode(0);
  approachtype = "exposed";
  approachpoint = self.pathgoalpos;
  approachnodeyaw = vectortoangles(approach_dir)[1];
  approachfinalyaw = approachnodeyaw;

  if(isDefined(self.node)) {
    determinenodeapproachtype(self.node);

    if(isDefined(self.node.approachtype) && self.node.approachtype != "exposed") {
      approachtype = self.node.approachtype;

      if(approachtype == "stand_saw") {
        approachpoint = (self.node.turretinfo.origin[0], self.node.turretinfo.origin[1], self.node.origin[2]);
        forward = anglestoforward((0, self.node.turretinfo.angles[1], 0));
        right = anglestoright((0, self.node.turretinfo.angles[1], 0));
        approachpoint = approachpoint + vectorscale(forward, -32.545) - vectorscale(right, 6.899);
      } else if(approachtype == "crouch_saw") {
        approachpoint = (self.node.turretinfo.origin[0], self.node.turretinfo.origin[1], self.node.origin[2]);
        forward = anglestoforward((0, self.node.turretinfo.angles[1], 0));
        right = anglestoright((0, self.node.turretinfo.angles[1], 0));
        approachpoint = approachpoint + vectorscale(forward, -32.545) - vectorscale(right, 6.899);
      } else if(approachtype == "prone_saw") {
        approachpoint = (self.node.turretinfo.origin[0], self.node.turretinfo.origin[1], self.node.origin[2]);
        forward = anglestoforward((0, self.node.turretinfo.angles[1], 0));
        right = anglestoright((0, self.node.turretinfo.angles[1], 0));
        approachpoint = approachpoint + vectorscale(forward, -37.36) - vectorscale(right, 13.279);
      } else
        approachpoint = self.node.origin;

      approachnodeyaw = self.node.angles[1];
      approachfinalyaw = approachnodeyaw + getnodestanceyawoffset(approachtype);
    }
  }

  setupapproachnodedebug(approachtype, approach_dir, approachnodeyaw);

  if(approachtype == "exposed" || approachtype == "exposed_cqb") {
    return;
  }
  startcornerapproach(approachtype, approachpoint, approachnodeyaw, approachfinalyaw, approach_dir);
}

startcornerapproachpreconditions(approachtype, approach_dir) {
  if(approachtype == "stand" || approachtype == "crouch") {
    assert(isDefined(self.node));
    forwardangle = absangleclamp180(vectortoangles(approach_dir)[1] - self.node.angles[1] + 180);

    if(forwardangle <= 80) {
      debug_arrival("approach aborted: approach_dir is too far forward for node type " + self.node.type);

      return false;
    }
  }

  return true;
}

startcornerapproachconditions(approachpoint, approachtype, approachnumber, approachfinalyaw) {
  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    debug_arrival("approach aborted at last minute: self.disableArrivals is true");

    return false;
  }

  if(abs(self getmotionangle()) > 45 && isDefined(self.enemy) && vectordot(anglestoforward(self.angles), vectornormalize(self.enemy.origin - self.origin)) > 0.6) {
    if(distancesquared(self.origin, self.enemy.origin) < 262144) {
      debug_arrival("approach aborted at last minute: facing enemy instead of current motion angle");

      return false;
    }
  }

  if(self.a.pose != "stand" || self.a.movement != "run" && self.a.movement != "walk" && !(isDefined(self.cqb) && self.cqb && !(self animscripts\utility::weaponanims() == "pistol"))) {
    debug_arrival("approach aborted at last minute: not standing and running");

    return false;
  }

  requiredyaw = approachfinalyaw - angledeltaarray("arrive_" + approachtype)[approachnumber];

  if(absangleclamp180(requiredyaw - self.angles[1]) > 30) {
    if(isvalidenemy(self.enemy) && self cansee(self.enemy)) {
      if(vectordot(anglestoforward(self.angles), self.enemy.origin - self.origin) > 0) {
        debug_arrival("aborting approach at last minute: don't want to turn back to nearby enemy");

        return false;
      }
    }
  }

  if(!checkcoverenterpos(approachpoint, approachfinalyaw, approachtype, approachnumber, 0)) {
    debug_arrival("approach blocked at last minute");

    return false;
  }

  return true;
}

approachwaittillclose(node, checkdist) {
  if(!isDefined(node)) {
    return;
  }
  while(true) {
    if(!isDefined(self.pathgoalpos))
      self waitforpathgoalpos();

    dist = distance(self.origin, self.pathgoalpos);

    if(dist <= checkdist + 8) {
      break;
    }

    waittime = (dist - checkdist) / 250 - 0.1;

    if(waittime < 0.05)
      waittime = 0.05;

    wait(waittime);
  }
}

getapproachent() {
  if(isDefined(self.node))
    return self.node;

  return undefined;
}

startcornerapproach(approachtype, approachpoint, approachnodeyaw, approachfinalyaw, approach_dir, forcecqb) {
  self endon("killanimscript");
  self endon("corner_approach");
  assert(isDefined(approachtype));

  if(!self startcornerapproachpreconditions(approachtype, approach_dir)) {
    return;
  }
  result = getmaxdirectionsandexcludedirfromapproachtype(approachtype);
  maxdirections = result.maxdirections;
  excludedir = result.excludedir;
  approachnumber = -1;
  node = getapproachent();
  arrivalfromfront = vectordot(approach_dir, anglestoforward(node.angles)) >= 0;
  arrivalfromfront = arrivalfromfront && vectordot(vectornormalize(self.origin - node.origin), anglestoforward(node.angles)) <= 0;
  doingcqbapproach = shoulddocqbtransition(self.node, approachtype, 1, forcecqb);

  if(doingcqbapproach)
    approachtype = approachtype + "_cqb";

  result = self checkarrivalenterpositions(approachpoint, approachfinalyaw, approachtype, approach_dir, maxdirections, excludedir, arrivalfromfront);

  for(i = 0; i < result.data.size; i++)
    debug_arrival(result.data[i]);

  if(result.approachnumber < 0) {
    if(!doingcqbapproach && candocqbtransition(self.node, approachtype, 1)) {
      debug_arrival("approach aborted: " + result.failure);

      debug_arrival("attempting cqb approach");

      return startcornerapproach(approachtype, approachpoint, approachnodeyaw, approachfinalyaw, approach_dir, 1);
    }

    debug_arrival("approach aborted: " + result.failure);

    return;
  }

  approachnumber = result.approachnumber;

  debug_arrival("approach success: dir " + approachnumber);

  if(isDefined(result.approachpoint))
    self.coverenterpos = result.approachpoint;

  if(approachnumber <= 6 && arrivalfromfront) {
    self endon("goal_changed");
    self.arrivalstartdist = longestapproachdist("arrive_" + approachtype);
    approachwaittillclose(node, self.arrivalstartdist + 8);
    dirtonode = vectornormalize(approachpoint - self.origin);

    if(approachnumber == 4)
      excludedir = 7;

    if(approachnumber == 6)
      excludedir = 9;

    result = self checkarrivalenterpositions(approachpoint, approachfinalyaw, approachtype, dirtonode, maxdirections, excludedir, arrivalfromfront);

    if(result.approachnumber != -1 && result.approachnumber != approachnumber)
      approachnumber = result.approachnumber;

    self thread watchgoalchangedwhileapproaching();
    thread debug_arrival_line(self.origin, self.coverenterpos, level.color_debug["red"], 5);

    movedeltaarray = movedeltaarray("arrive_" + approachtype);
    self.arrivalstartdist = length(movedeltaarray[approachnumber]);
    approachwaittillclose(node, self.arrivalstartdist);

    if(!self maymovetopoint(approachpoint)) {
      debug_arrival("approach blocked at last minute");

      self.arrivalstartdist = undefined;
      return;
    }

    if(result.approachnumber < 0) {
      debug_arrival("final approach aborted: " + result.failure);

      self.arrivalstartdist = undefined;
      return;
    }

    if(isDefined(self.a.isturning) && self.a.isturning) {
      return;
    }
    if(!self startcornerapproachconditions(approachpoint, approachtype, approachnumber, approachfinalyaw)) {
      return;
    }
    debug_arrival("final approach success: dir " + approachnumber);

    requiredyaw = approachfinalyaw - angledeltaarray("arrive_" + approachtype)[approachnumber];
  } else {
    self setruntopos(self.coverenterpos);
    self waittill("runto_arrived");
    requiredyaw = approachfinalyaw - angledeltaarray("arrive_" + approachtype)[approachnumber];

    if(!self startcornerapproachconditions(approachpoint, approachtype, approachnumber, approachfinalyaw))
      return;
  }

  self.approachnumber = approachnumber;
  self.approachtype = approachtype;
  self.approachanim = animarray("arrive_" + approachtype)[approachnumber];
  self.startcoverarrival = 1;
  self startcoverarrival(self.coverenterpos, requiredyaw);
}

watchgoalchangedwhileapproaching() {
  self endon("killanimscript");
  self waittill("goal_changed");
  self notify("abort_approach");
}

checkarrivalenterpositions(approachpoint, approachyaw, approachtype, approach_dir, maxdirections, excludedir, arrivalfromfront) {
  angledataobj = spawnstruct();
  calculatenodetransitionangles(angledataobj, approachtype, 1, approachyaw, approach_dir, maxdirections, excludedir);
  sortnodetransitionangles(angledataobj, maxdirections);
  resultobj = spawnstruct();

  resultobj.data = [];

  arrivalpos = (0, 0, 0);
  resultobj.approachnumber = -1;
  resultobj.approachpoint = undefined;
  numattempts = 2;

  if(approachtype == "exposed" || approachtype == "exposed_cqb")
    numattempts = 1;

  for(i = 1; i <= numattempts; i++) {
    assert(angledataobj.transindex[i] != excludedir);
    resultobj.approachnumber = angledataobj.transindex[i];

    if(!self checkcoverenterpos(approachpoint, approachyaw, approachtype, resultobj.approachnumber, arrivalfromfront)) {
      resultobj.data[resultobj.data.size] = "approach blocked: dir " + resultobj.approachnumber;

      continue;
    }

    break;
  }

  if(i > numattempts) {
    resultobj.failure = numattempts + " direction attempts failed";

    resultobj.approachnumber = -1;
    return resultobj;
  }

  disttoapproachpoint = distance(approachpoint, self.origin);
  disttoanimstart = distance(approachpoint, self.coverenterpos);

  disttoapproachpoint = distancesquared(approachpoint, self.origin);
  disttoanimstart = distancesquared(approachpoint, self.coverenterpos);

  recordline(approachpoint, self.coverenterpos, level.color_debug["green"], "Cover", self);

  if(disttoapproachpoint < disttoanimstart) {
    if(disttoapproachpoint < disttoanimstart) {
      resultobj.failure = "too close to destination";

      resultobj.approachnumber = -1;
      return resultobj;
    }

    if(!arrivalfromfront) {
      selftoanimstart = vectornormalize(self.coverenterpos - self.origin);
      animstarttonode = vectornormalize(approachpoint - self.coverenterpos);
      cosangle = vectordot(selftoanimstart, animstarttonode);

      if(cosangle < 0.707) {
        resultobj.failure = "angle to start of animation is too great ( angle of " + acos(cosangle) + " > 45 )";

        resultobj.approachnumber = -1;
        return resultobj;
      }
    }
  }

  return resultobj;
}

checkcoverenterpos(arrivalpoint, arrivalyaw, approachtype, approachnumber, arrivalfromfront) {
  if(debug_arrivals_on_actor())
    debug_arrival("checkCoverEnterPos() checking for arrive_" + approachtype + "_" + approachnumber);

  angle = (0, arrivalyaw - angledeltaarray("arrive_" + approachtype)[approachnumber], 0);
  forwarddir = anglestoforward(angle);
  rightdir = anglestoright(angle);
  movedeltaarray = movedeltaarray("arrive_" + approachtype);
  forward = vectorscale(forwarddir, movedeltaarray[approachnumber][0]);
  right = vectorscale(rightdir, movedeltaarray[approachnumber][1]);
  enterpos = arrivalpoint - forward + right;
  self.coverenterpos = enterpos;

  if(debug_arrivals_on_actor())
    thread debug_arrival_line(enterpos, arrivalpoint, level.color_debug["cyan"], 1.5);

  if(approachnumber <= 6 && arrivalfromfront)
    return 1;

  if(!self maymovefrompointtopoint(enterpos, arrivalpoint))
    return 0;

  if(approachnumber <= 6 || issubstr(tolower(approachtype), "exposed"))
    return 1;

  assert(approachtype == "left" || approachtype == "left_crouch" || approachtype == "right" || approachtype == "right_crouch" || approachtype == "left_cqb" || approachtype == "left_crouch_cqb" || approachtype == "right_cqb" || approachtype == "right_crouch_cqb" || approachtype == "pillar" || approachtype == "pillar_crouch");
  premovedeltaarray = premovedeltaarray("arrive_" + approachtype);
  forward = vectorscale(forwarddir, premovedeltaarray[approachnumber][0]);
  right = vectorscale(rightdir, premovedeltaarray[approachnumber][1]);
  originalenterpos = enterpos - forward + right;
  self.coverenterpos = originalenterpos;

  if(debug_arrivals_on_actor())
    thread debug_arrival_line(originalenterpos, enterpos, level.color_debug["cyan"], 1.5);

  return self maymovefrompointtopoint(originalenterpos, enterpos);
}

dolastminuteexposedapproachwrapper() {
  self endon("killanimscript");
  self notify("doing_last_minute_exposed_approach");
  self endon("doing_last_minute_exposed_approach");
  self thread watchgoalchanged();

  while(true) {
    dolastminuteexposedapproach();

    while(true) {
      self waittill_any("goal_changed", "goal_changed_previous_frame");

      if(isDefined(self.coverenterpos) && isDefined(self.pathgoalpos) && distancesquared(self.coverenterpos, self.pathgoalpos) < 1) {
        continue;
      }
      break;
    }
  }
}

watchgoalchanged() {
  self endon("killanimscript");
  self endon("doing_last_minute_exposed_approach");

  while(true) {
    self waittill("goal_changed");
    wait 0.05;
    self notify("goal_changed_previous_frame");
  }
}

dolastminuteexposedapproachpreconditions() {
  if(isDefined(self getnegotiationstartnode()))
    return false;

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    debug_arrival("Aborting exposed approach because self.disableArrivals is true");

    return false;
  }

  return true;
}

dolastminuteexposedapproachmidconditions() {
  if(self.a.pose != "stand" || self.a.movement != "run" && self.a.movement != "walk") {
    debug_arrival("Aborting exposed approach - not standing and running");

    return false;
  }

  if(isDefined(self.grenade) && isDefined(self.grenade.activator) && self.grenade.activator == self) {
    debug_arrival("Aborting exposed approach - holding the grenade.");

    return false;
  }

  return true;
}

dolastminuteexposedapproachconditions(animdist, allowederror) {
  if(!isDefined(self.pathgoalpos)) {
    debug_arrival("Aborting exposed approach because I have no path");

    return false;
  }

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    debug_arrival("Aborting exposed approach because self.disableArrivals is true");

    return false;
  }

  if(abs(self getmotionangle()) > 45) {
    debug_arrival("Aborting exposed approach because not facing motion and not going to a node");

    return false;
  }

  if(self.a.pose != "stand" || self.a.movement != "run" && self.a.movement != "walk") {
    debug_arrival("approach aborted at last minute: not standing and running");

    return false;
  }

  dist = distance(self.origin, self.pathgoalpos);

  if(!self maymovetopoint(self.pathgoalpos)) {
    debug_arrival("Aborting exposed approach: maymove check failed, AnimDist = " + animdist + " Dist = " + dist);

    return false;
  }

  if(abs(dist - animdist) > allowederror) {
    debug_arrival("Aborting exposed approach because distance difference exceeded allowed error: " + dist + " more than " + allowederror + " from " + animdist);

    return false;
  }

  return true;
}

determineexposedapproachtype(node) {
  type = "exposed";
  stance = node gethighestnodestance();

  if(stance == "prone")
    stance = "crouch";

  if(stance == "crouch")
    type = "exposed_crouch";
  else
    type = "exposed";

  if(self shoulddocqbtransition(node, type))
    type = type + "_cqb";

  return type;
}

faceenemyatendofapproach(node) {
  if(!isvalidenemy(self.enemy))
    return 0;

  if(self.combatmode == "exposed_nodes_only")
    return 1;

  if(isDefined(self.heat) && self.heat && isDefined(node))
    return 0;

  if(self.combatmode == "cover" && issentient(self.enemy) && gettime() - self lastknowntime(self.enemy) > 15000)
    return 0;

  return sighttracepassed(self.enemy getshootatpos(), self.pathgoalpos + vectorscale((0, 0, 1), 60.0), 0, undefined);
}

dolastminuteexposedapproach() {
  self endon("goal_changed");

  if(!self dolastminuteexposedapproachpreconditions()) {
    return;
  }
  self exposedapproachwaittillclose();

  if(!self dolastminuteexposedapproachmidconditions()) {
    return;
  }
  approachtype = "exposed";
  goalmatchesnode = 0;

  if(isDefined(self.node) && isDefined(self.pathgoalpos))
    goalmatchesnode = distancesquared(self.pathgoalpos, self.node.origin) < 1;

  if(goalmatchesnode)
    approachtype = determineexposedapproachtype(self.node);

  approachdir = vectornormalize(self.pathgoalpos - self.origin);
  desiredfacingyaw = vectortoangles(approachdir)[1];

  if(faceenemyatendofapproach(self.node))
    desiredfacingyaw = vectortoangles(self.enemy.origin - self.pathgoalpos)[1];
  else {
    facenodeangle = isDefined(self.node) && goalmatchesnode;
    facenodeangle = facenodeangle && self.node.type != "Path" && (self.node.type != "ambush" || !recentlysawenemy());

    if(facenodeangle)
      desiredfacingyaw = getnodeforwardyaw(self.node);
    else {
      likelyenemydir = self getanglestolikelyenemypath();

      if(isDefined(likelyenemydir))
        desiredfacingyaw = likelyenemydir[1];
    }
  }

  angledataobj = spawnstruct();
  calculatenodetransitionangles(angledataobj, approachtype, 1, desiredfacingyaw, approachdir, 9, -1);
  best = 1;

  for(i = 2; i <= 9; i++) {
    if(angledataobj.transitions[i] > angledataobj.transitions[best])
      best = i;
  }

  if(!issubstr(approachtype, "_cqb") && shoulddocqbtransition(undefined, approachtype))
    approachtype = approachtype + "_cqb";

  self.approachnumber = angledataobj.transindex[best];
  self.approachtype = approachtype;
  self.approachanim = animarray("arrive_" + approachtype)[self.approachnumber];
  animdist = length(movedeltaarray("arrive_" + approachtype)[self.approachnumber]);
  requireddistsq = animdist + 8;
  requireddistsq = requireddistsq * requireddistsq;

  while(isDefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) > requireddistsq)
    wait 0.05;

  if(isDefined(self.arrivalstartdist) && self.arrivalstartdist < animdist + 8) {
    debug_arrival("Aborting exposed approach because cover arrival dist is shorter");

    return;
  }

  if(!self dolastminuteexposedapproachconditions(animdist, 8)) {
    return;
  }
  dist = distance(self.origin, self.pathgoalpos);
  facingyaw = vectortoangles(self.pathgoalpos - self.origin)[1];

  if(animdist > 0) {
    delta = movedeltaarray("arrive_" + approachtype)[self.approachnumber];
    assert(delta[0] != 0);
    yawtomakedeltamatchup = atan(delta[1] / delta[0]);

    if(self.facemotion) {
      requiredyaw = facingyaw - yawtomakedeltamatchup;

      if(absangleclamp180(requiredyaw - self.angles[1]) > 30) {
        debug_arrival("Aborting exposed approach because angle change was too great");

        return;
      }
    } else
      requiredyaw = self.angles[1];

    closerdist = dist - animdist;
    idealstartpos = self.origin + vectorscale(vectornormalize(self.pathgoalpos - self.origin), closerdist);
  } else {
    requiredyaw = self.angles[1];
    idealstartpos = self.origin;
  }

  debug_arrival("Doing exposed approach in direction " + self.approachnumber);

  self startcoverarrival(idealstartpos, requiredyaw);
}

exposedapproachwaittillclose() {
  while(true) {
    if(!isDefined(self.pathgoalpos))
      self waitforpathgoalpos();

    dist = distance(self.origin, self.pathgoalpos);

    if(dist <= longestexposedapproachdist() + 6) {
      break;
    }

    waittime = (dist - longestexposedapproachdist()) / 200 - 0.1;

    if(waittime < 0.05)
      waittime = 0.05;

    wait(waittime);
  }
}

waitforpathgoalpos() {
  while(true) {
    if(isDefined(self.pathgoalpos)) {
      return;
    }
    wait 1;
  }
}

aligntonodeangles() {
  self endon("killanimscript");
  self endon("goal_changed");
  self endon("dont_align_to_node_angles");
  self endon("doing_last_minute_exposed_approach");
  waittillframeend;

  while(true) {
    if(!isDefined(self.node) || isDefined(anim.ispathnode[self.node.type]) || isDefined(anim.iscombatscriptnode[self.node.type]) || !isDefined(self.pathgoalpos) || distancesquared(self.node.origin, self.pathgoalpos) > 1) {
      return;
    }
    if(distancesquared(self.origin, self.node.origin) > 80 * 80) {
      wait 0.05;
      continue;
    }

    if(isDefined(self.coverenterpos) && isDefined(self.pathgoalpos) && distancesquared(self.coverenterpos, self.pathgoalpos) < 1) {
      wait 0.1;
      continue;
    }

    break;
  }

  if(isDefined(self.disablearrivals) && self.disablearrivals) {
    return;
  }
  startdist = distance(self.origin, self.node.origin);

  if(startdist <= 0) {
    return;
  }
  determinenodeapproachtype(self.node);
  startyaw = self.angles[1];
  targetyaw = self.node.angles[1];

  if(isDefined(self.node.approachtype))
    targetyaw = targetyaw + getnodestanceyawoffset(self.node.approachtype);

  targetyaw = startyaw + angleclamp180(targetyaw - startyaw);
  self thread resetorientmodeongoalchange();

  while(true) {
    if(!isDefined(self.node)) {
      self orientmode("face default");
      return;
    }

    dist = distance(self.origin, self.node.origin);

    if(dist > startdist * 1.1) {
      self orientmode("face default");
      return;
    }

    distfrac = 1.0 - dist / startdist;
    currentyaw = startyaw + distfrac * (targetyaw - startyaw);
    self orientmode("face angle", currentyaw);
    wait 0.05;
  }
}

resetorientmodeongoalchange() {
  self endon("killanimscript");
  self waittill_any("goal_changed", "dont_align_to_node_angles");
  self orientmode("face default");
}

startmovetransitionpreconditions() {
  if(!isDefined(self.pathgoalpos)) {
    debug_arrival("not exiting cover (ent " + self getentnum() + "): self.pathGoalPos is undefined");

    return false;
  }

  if(!self shouldfacemotion()) {
    if(!animscripts\run::shouldfullsprint() && self weaponanims() != "rocketlauncher") {
      debug_arrival("not exiting cover (ent " + self getentnum() + "): ShouldFaceMotion is false");

      return false;
    }
  }

  if(self.a.pose == "prone") {
    debug_arrival("not exiting cover (ent " + self getentnum() + "): self.a.pose is \"prone\"");

    return false;
  }

  if(isDefined(self.disableexits) && self.disableexits) {
    debug_arrival("not exiting cover (ent " + self getentnum() + "): self.disableExits is true");

    return false;
  }

  if(!self isstanceallowed("stand")) {
    debug_arrival("not exiting cover (ent " + self getentnum() + "): not allowed to stand");

    return false;
  }

  return true;
}

startmovetransitionmidconditions(exitnode, exittype) {
  if(!isDefined(exittype)) {
    debug_arrival("aborting exit: not supported for node type " + exitnode.type);

    return false;
  }

  if(exittype == "exposed") {
    if(self.a.pose != "stand" && self.a.pose != "crouch") {
      debug_arrival("exposed exit aborted because anim_pose is not \"stand\" or \"crouch\"");

      return false;
    }

    if(self.a.movement != "stop") {
      debug_arrival("exposed exit aborted because anim_movement is not \"stop\"");

      return false;
    }
  }

  return true;
}

startmovetransitionfinalconditions(exittype, approachnumber) {
  if(exittype == "exposed" && approachnumber < 4) {
    if(isvalidenemy(self.enemy)) {
      if(vectordot(anglestoforward(self.angles), self.enemy.origin - self.origin) > 0.707) {
        if(self canseeenemyfromexposed() && distancesquared(self.origin, self.enemy.origin) < 40000) {
          debug_arrival("aborting exit in dir" + approachnumber + ": don't want to turn back to nearby enemy");

          return false;
        }
      }
    }
  }

  return true;
}

startmovetransition() {
  self endon("killanimscript");

  if(!self startmovetransitionpreconditions()) {
    return;
  }
  exitpos = self.origin;
  exityaw = self.angles[1];
  exittype = "exposed";
  exitnode = undefined;

  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 225)
    exitnode = self.node;
  else if(isDefined(self.prevnode))
    exitnode = self.prevnode;

  if(isDefined(exitnode)) {
    determinenodeexittype(exitnode);

    if(isDefined(exitnode.approachtype) && exitnode.approachtype != "exposed" && exitnode.approachtype != "stand_saw" && exitnode.approachtype != "crouch_saw") {
      distancesq = distancesquared(exitnode.origin, self.origin);
      anglediff = absangleclamp180(self.angles[1] - exitnode.angles[1] - getnodestanceyawoffset(exitnode.approachtype));

      if(distancesq < 225 && anglediff < 5) {
        exitpos = exitnode.origin;
        exityaw = exitnode.angles[1];
        exittype = exitnode.approachtype;
      }
    }
  }

  self startmovetransitiondebug(exittype, exityaw);

  if(!startmovetransitionmidconditions(exitnode, exittype)) {
    return;
  }
  if(exittype == "exposed") {
    if(self.a.pose == "crouch")
      exittype = "exposed_crouch";
  }

  leavedir = (-1 * self.lookaheaddir[0], -1 * self.lookaheaddir[1], 0);
  result = getmaxdirectionsandexcludedirfromapproachtype(exittype);
  maxdirections = result.maxdirections;
  excludedir = result.excludedir;
  exityaw = exityaw + getnodestanceyawoffset(exittype);

  if(shoulddocqbtransition(exitnode, exittype))
    exittype = exittype + "_cqb";

  angledataobj = spawnstruct();
  calculatenodetransitionangles(angledataobj, exittype, 0, exityaw, leavedir, maxdirections, excludedir);
  sortnodetransitionangles(angledataobj, maxdirections);
  approachnumber = -1;
  numattempts = 2;

  if(issubstr(exittype, "exposed"))
    numattempts = 1;

  for(i = 1; i <= numattempts; i++) {
    assert(angledataobj.transindex[i] != excludedir);
    approachnumber = angledataobj.transindex[i];

    if(self checkcoverexitpos(exitpos, exityaw, exittype, approachnumber, 1)) {
      break;
    }

    debug_arrival("exit blocked: dir " + approachnumber);

  }

  if(i > numattempts) {
    debug_arrival("aborting exit: too many exit directions blocked");

    return;
  }

  alloweddistsq = distancesquared(self.origin, self.coverexitpos);
  availabledistsq = distancesquared(self.origin, self.pathgoalpos);

  if(availabledistsq < alloweddistsq) {
    debug_arrival("exit failed, too close to destination");

    return;
  }

  if(!startmovetransitionfinalconditions(exittype, approachnumber)) {
    return;
  }
  debug_arrival("exit success: dir " + approachnumber);

  self thread maps\_dds::dds_notify("thrt_breaking", self.team != "allies");
  self maps\_dds::dds_notify("rspns_movement", self.team == "allies");
  self docoverexitanimation(exittype, approachnumber);
}

checkcoverexitpos(exitpoint, exityaw, exittype, approachnumber, checkwithpath) {
  angle = (0, exityaw, 0);
  forwarddir = anglestoforward(angle);
  rightdir = anglestoright(angle);
  movedeltaarray = movedeltaarray("exit_" + exittype);
  forward = vectorscale(forwarddir, movedeltaarray[approachnumber][0]);
  right = vectorscale(rightdir, movedeltaarray[approachnumber][1]);
  exitpos = exitpoint + forward - right;
  self.coverexitpos = exitpos;
  isexposedapproach = exittype == "exposed" || exittype == "exposed_crouch";
  isexposedapproach = isexposedapproach || (exittype == "exposed_cqb" || exittype == "exposed_crouch_cqb");

  if(debug_arrivals_on_actor())
    thread debug_arrival_line(self.origin, exitpos, level.color_debug["green"], 1.5);

  if(!isexposedapproach && checkwithpath && !self checkcoverexitposwithpath(exitpos)) {
    debug_arrival("cover exit " + approachnumber + " path check failed");

    return 0;
  }

  if(!self maymovefrompointtopoint(self.origin, exitpos))
    return 0;

  if(approachnumber <= 6 || isexposedapproach)
    return 1;

  assert(exittype == "left" || exittype == "left_crouch" || exittype == "right" || exittype == "right_crouch" || exittype == "left_cqb" || exittype == "left_crouch_cqb" || exittype == "right_cqb" || exittype == "right_crouch_cqb" || exittype == "pillar" || exittype == "pillar_crouch");
  postmovedeltaarray = postmovedeltaarray("exit_" + exittype);
  forward = vectorscale(forwarddir, postmovedeltaarray[approachnumber][0]);
  right = vectorscale(rightdir, postmovedeltaarray[approachnumber][1]);
  finalexitpos = exitpos + forward - right;
  self.coverexitpos = finalexitpos;

  if(debug_arrivals_on_actor())
    thread debug_arrival_line(exitpos, finalexitpos, level.color_debug["green"], 1.5);

  return self maymovefrompointtopoint(exitpos, finalexitpos);
}

docoverexitanimation(exittype, approachnumber) {
  assert(isDefined(approachnumber));
  assert(approachnumber > 0);
  assert(isDefined(exittype));
  leaveanim = animarray("exit_" + exittype)[approachnumber];
  assert(isDefined(leaveanim), "Exit anim not found (" + self.animtype + " - exit_" + exittype + " - " + approachnumber + ")");
  lookaheadangles = vectortoangles(self.lookaheaddir);

  if(debug_arrivals_on_actor()) {
    endpos = self.origin + vectorscale(self.lookaheaddir, 100);
    thread debug_arrival_line(self.origin, endpos, level.color_debug["red"], 1.5);
  }

  if(self.a.pose == "prone") {
    return;
  }
  self animscripts\debug::debugpushstate("Cover Exit");

  self animmode("zonly_physics", 0);
  self orientmode("face angle", self.angles[1]);
  self setflaggedanimknoballrestart("coverexit", leaveanim, % body, 1, 0.2, 1);
  animstarttime = gettime();
  hasexitalign = animhasnotetrack(leaveanim, "exit_align");

  if(!hasexitalign)
    debug_arrival("^1Animation exit_" + exittype + "[" + approachnumber + "] has no \"exit_align\" notetrack");

  self thread donotetracksforexit("coverexit", hasexitalign);
  self waittillmatch("coverexit", "exit_align");
  self.a.pose = "stand";
  self.a.movement = "run";
  hascodemovenotetrack = animhasnotetrack(leaveanim, "code_move");

  while(true) {
    curfrac = self getanimtime(leaveanim);
    remainingmovedelta = getmovedelta(leaveanim, curfrac, 1);
    remainingangledelta = getangledelta(leaveanim, curfrac, 1);
    faceyaw = lookaheadangles[1] - remainingangledelta;
    forward = anglestoforward((0, faceyaw, 0));
    right = anglestoright((0, faceyaw, 0));
    endpoint = self.origin + vectorscale(forward, remainingmovedelta[0]) - vectorscale(right, remainingmovedelta[1]);

    if(self maymovetopoint(endpoint)) {
      self orientmode("face angle", faceyaw);
      break;
    }

    if(hascodemovenotetrack) {
      break;
    }

    timeleft = getanimlength(leaveanim) * (1 - curfrac) - 0.15 - 0.05;

    if(timeleft < 0.05) {
      break;
    }

    if(timeleft > 0.4)
      timeleft = 0.4;

    wait(timeleft);
  }

  if(hascodemovenotetrack) {
    notetrack_times = getnotetracktimes(leaveanim, "code_move");
    absolute_code_move_time = getanimlength(leaveanim) * notetrack_times[0];
    curfrac = self getanimtime(leaveanim);
    current_anim_time = getanimlength(leaveanim) * curfrac;

    if(absolute_code_move_time > current_anim_time + 0.05) {
      if(absolute_code_move_time + 0.15 > getanimlength(leaveanim))
        wait(getanimlength(leaveanim) - absolute_code_move_time);
      else
        self waittillmatch("coverexit", "code_move");
    }

    self orientmode("face motion");
    self animmode("none", 0);
  }

  totalanimtime = getanimlength(leaveanim) / 1;
  timepassed = (gettime() - animstarttime) / 1000;
  timeleft = totalanimtime - timepassed - 0.15;

  if(timeleft > 0)
    wait(timeleft);

  self clearanim( % root, 0.15);
  self orientmode("face default");
  self animmode("normal", 0);

  self animscripts\debug::debugpopstate("Cover Exit");
}

donotetracksforexit(animname, hasexitalign) {
  self endon("killanimscript");
  self animscripts\shared::donotetracks(animname);

  if(!hasexitalign)
    self notify(animname, "exit_align");
}

getnewstance() {
  newstance = undefined;

  switch (self.approachtype) {
    case "exposed":
    case "exposed_cqb":
    case "left":
    case "left_cqb":
    case "pillar":
    case "right":
    case "right_cqb":
    case "stand":
    case "stand_saw":
      newstance = "stand";
      break;
    case "crouch":
    case "crouch_saw":
    case "exposed_crouch":
    case "exposed_crouch_cqb":
    case "left_crouch":
    case "left_crouch_cqb":
    case "pillar_crouch":
    case "right_crouch":
    case "right_crouch_cqb":
      newstance = "crouch";
      break;
    case "prone_saw":
      newstance = "prone";
      break;
    default:

      assertmsg("bad node approach type: " + self.approachtype);

      return "";
  }

  return newstance;
}

getnodestanceyawoffset(approachtype) {
  if(approachtype == "left" || approachtype == "left_crouch")
    return 90.0;
  else if(approachtype == "right" || approachtype == "right_crouch")
    return -90.0;
  else if(approachtype == "pillar" || approachtype == "pillar_crouch")
    return 180.0;

  return 0;
}

canusesawapproach(node) {
  if(self.weapon != "saw" && self.weapon != "rpd" && self.weapon != "dp28" && self.weapon != "dp28_bipod" && self.weapon != "bren" && self.weapon != "bren_bipod" && self.weapon != "30cal" && self.weapon != "30cal_bipod" && self.weapon != "bar" && self.weapon != "bar_bipod" && self.weapon != "mg42" && self.weapon != "mg42_bipod" && self.weapon != "fg42" && self.weapon != "fg42_bipod" && self.weapon != "type99_lmg" && self.weapon != "type99_lmg_bipod")
    return false;

  if(!isDefined(node.turretinfo))
    return false;

  if(node.type != "Cover Stand" && node.type != "Cover Prone" && node.type != "Cover Crouch")
    return false;

  if(isDefined(self.enemy) && distancesquared(self.enemy.origin, node.origin) < 65536)
    return false;

  if(getnodeyawtoenemy() > 40 || getnodeyawtoenemy() < -40)
    return false;

  return true;
}

determinenodeapproachtype(node) {
  if(canusesawapproach(node)) {
    if(node.type == "Cover Stand")
      node.approachtype = "stand_saw";

    if(node.type == "Cover Crouch")
      node.approachtype = "crouch_saw";
    else if(node.type == "Cover Prone")
      node.approachtype = "prone_saw";

    assert(isDefined(node.approachtype));
    return;
  }

  if(self is_heavy_machine_gun()) {
    if(node.type == "Path")
      self.disablearrivals = 1;
    else
      self.disablearrivals = 0;
  }

  if(!isDefined(anim.approach_types[node.type])) {
    return;
  }
  nodetype = node.type;

  if(nodetype == "Cover Pillar" && usingpistol()) {
    if(node has_spawnflag(1024))
      nodetype = "Cover Right";
    else
      nodetype = "Cover Left";
  }

  stance = node has_spawnflag(4) && !node has_spawnflag(8);
  node.approachtype = anim.approach_types[nodetype][stance];
}

determinenodeexittype(node) {
  if(canusesawapproach(node)) {
    if(node.type == "Cover Stand")
      node.approachtype = "stand_saw";

    if(node.type == "Cover Crouch")
      node.approachtype = "crouch_saw";
    else if(node.type == "Cover Prone")
      node.approachtype = "prone_saw";

    assert(isDefined(node.approachtype));
    return;
  }

  if(!isDefined(anim.approach_types[node.type])) {
    return;
  }
  nodetype = node.type;

  if(nodetype == "Cover Pillar" && usingpistol()) {
    if(node has_spawnflag(1024))
      nodetype = "Cover Right";
    else
      nodetype = "Cover Left";
  }

  if(self.a.pose == "stand")
    node.approachtype = anim.approach_types[nodetype][0];
  else
    node.approachtype = anim.approach_types[nodetype][1];
}

getmaxdirectionsandexcludedirfromapproachtype(approachtype) {
  returnobj = spawnstruct();

  if(approachtype == "left" || approachtype == "left_crouch") {
    returnobj.maxdirections = 9;
    returnobj.excludedir = 9;
  } else if(approachtype == "right" || approachtype == "right_crouch") {
    returnobj.maxdirections = 9;
    returnobj.excludedir = 7;
  } else if(approachtype == "stand" || approachtype == "crouch" || approachtype == "stand_saw" || approachtype == "crouch_saw") {
    returnobj.maxdirections = 6;
    returnobj.excludedir = -1;
  } else if(approachtype == "exposed" || approachtype == "exposed_crouch" || approachtype == "pillar" || approachtype == "pillar_crouch") {
    returnobj.maxdirections = 9;
    returnobj.excludedir = -1;
  } else if(approachtype == "prone_saw") {
    returnobj.maxdirections = 3;
    returnobj.excludedir = -1;
  } else {
    assertmsg("unsupported approach type " + approachtype);

  }

  return returnobj;
}

calculatenodetransitionangles(angledataobj, approachtype, isarrival, arrivalyaw, approach_dir, maxdirections, excludedir) {
  angledataobj.transitions = [];
  angledataobj.transindex = [];
  anglearray = undefined;
  sign = 1;
  offset = 0;

  if(isarrival) {
    anglearray = angledeltaarray("arrive_" + approachtype);
    sign = -1;
    offset = 0;
  } else {
    anglearray = angledeltaarray("exit_" + approachtype);
    sign = 1;
    offset = 180;
  }

  for(i = 1; i <= maxdirections; i++) {
    angledataobj.transindex[i] = i;

    if(i == 5 || i == excludedir || !isDefined(anglearray[i])) {
      angledataobj.transitions[i] = -1.0003;
      continue;
    }

    angles = (0, arrivalyaw + sign * anglearray[i] + offset, 0);
    dir = vectornormalize(anglestoforward(angles));
    angledataobj.transitions[i] = vectordot(approach_dir, dir);
  }
}

sortnodetransitionangles(angledataobj, maxdirections) {
  for(i = 2; i <= maxdirections; i++) {
    currentvalue = angledataobj.transitions[angledataobj.transindex[i]];
    currentindex = angledataobj.transindex[i];

    for(j = i - 1; j >= 1; j--) {
      if(currentvalue < angledataobj.transitions[angledataobj.transindex[j]]) {
        break;
      }

      angledataobj.transindex[j + 1] = angledataobj.transindex[j];
    }

    angledataobj.transindex[j + 1] = currentindex;
  }
}

shoulddocqbtransition(node, type, isexit, forcecqb) {
  if((!isDefined(forcecqb) || !forcecqb) && (isDefined(self.heat) && self.heat))
    return 0;

  if(!animscripts\cqb::shouldcqb()) {
    if(!isDefined(forcecqb) || !forcecqb)
      return 0;
  }

  return candocqbtransition(node, type, isexit);
}

candocqbtransition(node, type, isexit) {
  if(aihasonlypistol())
    return false;

  if(issubstr(type, "_cqb") && !issubstr(tolower(type), "pillar") || type == "exposed" || type == "exposed_crouch")
    return true;

  if(isDefined(isexit) && isexit) {
    assert(isDefined(type));

    if(type == "left" || type == "right")
      return true;
  }

  if(isDefined(node) && (node.type == "Cover Left" || node.type == "Cover Right") && !issubstr(tolower(type), "pillar"))
    return true;

  return false;
}

startmovetransitiondebug(exittype, exityaw) {
  debug_arrival("^3exiting cover (ent " + self getentnum() + ", type \"" + exittype + "\"):");
  debug_arrival("lookaheaddir = (" + self.lookaheaddir[0] + ", " + self.lookaheaddir[1] + ", " + self.lookaheaddir[2] + ")");
  angle = angleclamp180(vectortoangles(self.lookaheaddir)[1] - exityaw);

  if(angle < 0)
    debug_arrival(" (Angle of " + (0 - angle) + " right from node forward.)");
  else
    debug_arrival(" (Angle of " + angle + " left from node forward.)");
}

setupapproachnodedebug(approachtype, approach_dir, approachnodeyaw) {
  debug_arrival("^5approaching cover (ent " + self getentnum() + ", type \"" + approachtype + "\"):");
  debug_arrival(" approach_dir = (" + approach_dir[0] + ", " + approach_dir[1] + ", " + approach_dir[2] + ")");
  angle = angleclamp180(vectortoangles(approach_dir)[1] - approachnodeyaw + 180);

  if(angle < 0)
    debug_arrival(" (Angle of " + (0 - angle) + " right from node forward.)");
  else
    debug_arrival(" (Angle of " + angle + " left from node forward.)");

  if(approachtype == "exposed") {
    if(isDefined(self.node)) {
      if(isDefined(self.node.approachtype))
        debug_arrival("Aborting cover approach: node approach type was " + self.node.approachtype);
      else
        debug_arrival("Aborting cover approach: node approach type was undefined");
    } else
      debug_arrival("Aborting cover approach: self.node is undefined");

    return;
  }

  if(debug_arrivals_on_actor())
    thread drawapproachvec(approach_dir);
}

drawapproachvec(approach_dir) {
  self endon("killanimscript");

  for(;;) {
    if(!isDefined(self.node)) {
      break;
    }

    line(self.node.origin + vectorscale((0, 0, 1), 20.0), self.node.origin - vectorscale(approach_dir, 64) + vectorscale((0, 0, 1), 20.0));
    recordline(self.node.origin + vectorscale((0, 0, 1), 20.0), self.node.origin - vectorscale(approach_dir, 64) + vectorscale((0, 0, 1), 20.0));
    wait 0.05;
  }

}

debug_arrivals_on_actor() {
  dvar = getdvarint(#"_id_3F886B38");

  if(dvar == 0)
    return false;

  if(dvar == 1)
    return true;

  if(int(dvar) == self getentnum())
    return true;

  return false;
}

debug_arrival(msg) {
  if(!debug_arrivals_on_actor()) {
    return;
  }
  println(msg);
  recordenttext(msg, self, level.color_debug["white"], "Cover");
}

debug_arrival_cross(atpoint, radius, color, durationframes) {
  if(!debug_arrivals_on_actor()) {
    return;
  }
  atpoint_high = atpoint + (0, 0, radius);
  atpoint_low = atpoint + (0, 0, -1 * radius);
  atpoint_left = atpoint + (0, radius, 0);
  atpoint_right = atpoint + (0, -1 * radius, 0);
  atpoint_forward = atpoint + (radius, 0, 0);
  atpoint_back = atpoint + (-1 * radius, 0, 0);
  thread debug_arrival_line(atpoint_high, atpoint_low, color, durationframes);
  thread debug_arrival_line(atpoint_left, atpoint_right, color, durationframes);
  thread debug_arrival_line(atpoint_forward, atpoint_back, color, durationframes);
}

debug_arrival_line(start, end, color, duration) {
  if(!debug_arrivals_on_actor()) {
    return;
  }
  if(isDefined(self))
    recordline(start, end, color, "Cover", self);

  debugline(start, end, color, duration);
}

debug_arrival_record_text(msg, position, color) {
  if(!debug_arrivals_on_actor()) {
    return;
  }
  record3dtext(msg, position, color, "Animscript");
}

fakeailogic() {
  self.animtype = "default";
  self.a.script = "move";
  self.a.pose = "stand";
  self.a.prevpose = "stand";
  self.weapon = "ak47_sp";
  self.ignoreme = 1;
  self.ignoreall = 1;
  self animmode("nogravity");
  self forceteleport(get_players()[0].origin + vectorscale((0, 0, -1), 1000.0), self.origin);

  while(isDefined(self) && isalive(self))
    wait 0.05;
}

coverarrivaldebugtool() {
  if(isDefined(level.createfx_enabled) && level.createfx_enabled) {
    return;
  }
  nodecolors = [];
  nodecolors["Cover Stand"] = (0, 0.54, 0.66);
  nodecolors["Cover Crouch"] = (0, 0.93, 0.72);
  nodecolors["Cover Crouch Window"] = (0, 0.7, 0.5);
  nodecolors["Cover Prone"] = (0, 0.6, 0.46);
  nodecolors["Cover Right"] = (0.85, 0.85, 0.1);
  nodecolors["Cover Left"] = (1, 0.7, 0);
  nodecolors["Conceal Stand"] = (0, 0, 1);
  nodecolors["Conceal Crouch"] = vectorscale((0, 0, 1), 0.75);
  nodecolors["Conceal Prone"] = vectorscale((0, 0, 1), 0.5);
  nodecolors["Turret"] = (0, 0.93, 0.72);
  nodecolors["Bad"] = (1, 0, 0);
  nodecolors["Poor"] = (1, 0.5, 0);
  nodecolors["Ok"] = (1, 1, 0);
  nodecolors["Good"] = (0, 1, 0);
  wait_for_first_player();
  player = get_players()[0];
  tracemin = (-15, -15, 18);
  tracemax = (15, 15, 72);
  hudgood = newdebughudelem();
  hudgood.location = 0;
  hudgood.alignx = "left";
  hudgood.aligny = "middle";
  hudgood.foreground = 1;
  hudgood.fontscale = 1.3;
  hudgood.sort = 20;
  hudgood.x = 680;
  hudgood.y = 240;
  hudgood.og_scale = 1;
  hudgood.color = nodecolors["Good"];
  hudgood.alpha = 1;
  hudok = newdebughudelem();
  hudok.location = 0;
  hudok.alignx = "left";
  hudok.aligny = "middle";
  hudok.foreground = 1;
  hudok.fontscale = 1.3;
  hudok.sort = 20;
  hudok.x = 680;
  hudok.y = 260;
  hudok.og_scale = 1;
  hudok.color = nodecolors["Ok"];
  hudok.alpha = 1;
  hudpoor = newdebughudelem();
  hudpoor.location = 0;
  hudpoor.alignx = "left";
  hudpoor.aligny = "middle";
  hudpoor.foreground = 1;
  hudpoor.fontscale = 1.3;
  hudpoor.sort = 20;
  hudpoor.x = 680;
  hudpoor.y = 280;
  hudpoor.og_scale = 1;
  hudpoor.color = nodecolors["Poor"];
  hudpoor.alpha = 1;
  hudbad = newdebughudelem();
  hudbad.location = 0;
  hudbad.alignx = "left";
  hudbad.aligny = "middle";
  hudbad.foreground = 1;
  hudbad.fontscale = 1.3;
  hudbad.sort = 20;
  hudbad.x = 680;
  hudbad.y = 300;
  hudbad.og_scale = 1;
  hudbad.color = nodecolors["Bad"];
  hudbad.alpha = 1;
  hudtotal = newdebughudelem();
  hudtotal.location = 0;
  hudtotal.alignx = "left";
  hudtotal.aligny = "middle";
  hudtotal.foreground = 1;
  hudtotal.fontscale = 1.3;
  hudtotal.sort = 20;
  hudtotal.x = 680;
  hudtotal.y = 330;
  hudtotal.og_scale = 1;
  hudtotal.color = (1, 1, 1);
  hudtotal.alpha = 1;
  hudgoodtext = newdebughudelem();
  hudgoodtext.location = 0;
  hudgoodtext.alignx = "right";
  hudgoodtext.aligny = "middle";
  hudgoodtext.foreground = 1;
  hudgoodtext.fontscale = 1.3;
  hudgoodtext.sort = 20;
  hudgoodtext.x = 670;
  hudgoodtext.y = 240;
  hudgoodtext.og_scale = 1;
  hudgoodtext.color = nodecolors["Good"];
  hudgoodtext.alpha = 1;
  hudgoodtext settext("Good: ");
  hudoktext = newdebughudelem();
  hudoktext.location = 0;
  hudoktext.alignx = "right";
  hudoktext.aligny = "middle";
  hudoktext.foreground = 1;
  hudoktext.fontscale = 1.3;
  hudoktext.sort = 20;
  hudoktext.x = 670;
  hudoktext.y = 260;
  hudoktext.og_scale = 1;
  hudoktext.color = nodecolors["Ok"];
  hudoktext.alpha = 1;
  hudoktext settext("Ok: ");
  hudpoortext = newdebughudelem();
  hudpoortext.location = 0;
  hudpoortext.alignx = "right";
  hudpoortext.aligny = "middle";
  hudpoortext.foreground = 1;
  hudpoortext.fontscale = 1.3;
  hudpoortext.sort = 20;
  hudpoortext.x = 670;
  hudpoortext.y = 280;
  hudpoortext.og_scale = 1;
  hudpoortext.color = nodecolors["Poor"];
  hudpoortext.alpha = 1;
  hudpoortext settext("Poor: ");
  hudbadtext = newdebughudelem();
  hudbadtext.location = 0;
  hudbadtext.alignx = "right";
  hudbadtext.aligny = "middle";
  hudbadtext.foreground = 1;
  hudbadtext.fontscale = 1.3;
  hudbadtext.sort = 20;
  hudbadtext.x = 670;
  hudbadtext.y = 300;
  hudbadtext.og_scale = 1;
  hudbadtext.color = nodecolors["Bad"];
  hudbadtext.alpha = 1;
  hudbadtext settext("Bad: ");
  hudlinetext = newdebughudelem();
  hudlinetext.location = 0;
  hudlinetext.alignx = "left";
  hudlinetext.aligny = "middle";
  hudlinetext.foreground = 1;
  hudlinetext.fontscale = 1.3;
  hudlinetext.sort = 20;
  hudlinetext.x = 630;
  hudlinetext.y = 315;
  hudlinetext.og_scale = 1;
  hudlinetext.color = (1, 1, 1);
  hudlinetext.alpha = 1;
  hudlinetext settext("------------------");
  hudtotaltext = newdebughudelem();
  hudtotaltext.location = 0;
  hudtotaltext.alignx = "right";
  hudtotaltext.aligny = "middle";
  hudtotaltext.foreground = 1;
  hudtotaltext.fontscale = 1.3;
  hudtotaltext.sort = 20;
  hudtotaltext.x = 670;
  hudtotaltext.y = 330;
  hudtotaltext.og_scale = 1;
  hudtotaltext.color = (1, 1, 1);
  hudtotaltext.alpha = 1;
  hudtotaltext settext("Total: ");
  badnode = undefined;
  fakeai = undefined;

  while(true) {
    tool = getdvarint(#"_id_57FCCA16");

    if(tool <= 0 && isDefined(level.nodedrone) && isDefined(level.nodedrone.currentnode))
      tool = 1;

    if(tool <= 0) {
      if(isDefined(fakeai)) {
        fakeai delete();
        fakeai = undefined;
      }

      hudbad.alpha = 0;
      hudpoor.alpha = 0;
      hudok.alpha = 0;
      hudgood.alpha = 0;
      hudtotal.alpha = 0;
      hudbadtext.alpha = 0;
      hudpoortext.alpha = 0;
      hudoktext.alpha = 0;
      hudgoodtext.alpha = 0;
      hudlinetext.alpha = 0;
      hudtotaltext.alpha = 0;
      wait 0.2;
      continue;
    }

    if(!isDefined(fakeai)) {
      spawners = getspawnerarray();

      for(i = 0; i < spawners.size; i++) {
        fakeai = spawners[i] stalingradspawn();

        if(isDefined(fakeai)) {
          fakeai animcustom(::fakeailogic);
          break;
        }
      }

      if(!isDefined(fakeai)) {
        wait 0.2;
        continue;
      }
    }

    hudbad.alpha = 1;
    hudpoor.alpha = 1;
    hudok.alpha = 1;
    hudgood.alpha = 1;
    hudtotal.alpha = 1;
    hudbadtext.alpha = 1;
    hudpoortext.alpha = 1;
    hudoktext.alpha = 1;
    hudgoodtext.alpha = 1;
    hudlinetext.alpha = 1;
    hudtotaltext.alpha = 1;
    numbad = 0;
    numpoor = 0;
    numok = 0;
    numgood = 0;
    tracesthisframe = 0;
    renderedthisframe = 0;
    evaluatedthisframe = 0;
    radius = getdvarfloat(#"_id_876D873E");
    nodes = getanynodearray(player.origin, radius);

    if(tool > 0 && isDefined(level.nodedrone) && isDefined(level.nodedrone.currentnode)) {
      nodes = [];
      nodes[0] = level.nodedrone.currentnode;
    }

    shownodes = getdvarint(#"_id_8FA91890");
    totalnodes = 1;

    if(shownodes > 0 || nodes.size == 0)
      totalnodes = nodes.size;

    fakeai.cqb = 0;
    fakeai.weapon = "ak47_sp";
    fakeai.heat = 0;
    tooltype = getdvarint(#"_id_3F219298");

    if(tooltype == 1)
      fakeai.cqb = 1;
    else if(tooltype == 2)
      fakeai.weapon = "m1911_sp";

    allai = entsearch(level.contents_actor, player.origin, 10000);
    numai = allai.size;

    if(numai < 5)
      numai = 5;
    else if(numai > 15)
      numai = 15;

    maxnodesperframe = (numai - 5) / (15 - 5);
    maxnodesperframe = (1 - maxnodesperframe) * (30 - 5) + 5;
    frameinterval = int(ceil(totalnodes / maxnodesperframe));

    for(i = 0; i < totalnodes && i < nodes.size; i++) {
      node = nodes[i];

      if(!isDefined(node.tool) || node.tool != tool || !isDefined(node.tooltype) || node.tooltype != tooltype) {
        node.angledeltaarray = undefined;
        node.movedeltaarray = undefined;
        node.premovedeltaarray = undefined;
        node.postmovedeltaarray = undefined;
        node.tool = tool;
        node.tooltype = tooltype;
      }

      assert(isDefined(node));

      if(!isDefined(node) || node.type == "BAD NODE" || node.type == "Path") {
        totalnodes++;
        continue;
      } else if(node.type == "Begin") {
        print3d(node.origin, node.animscript, (1, 0, 0), 1, 0.2, frameinterval);
        continue;
      } else if(!isDefined(anim.approach_types[node.type])) {
        totalnodes++;
        continue;
      }

      if(isDefined(node.lastcheckedtime) && gettime() - node.lastcheckedtime < 50 * frameinterval) {
        if(node.lastratio == 0)
          numbad++;
        else if(node.lastratio < 0.5)
          numpoor++;
        else if(node.lastratio < 1.0)
          numok++;
        else
          numgood++;

        continue;
      }

      if(evaluatedthisframe > maxnodesperframe) {
        continue;
      }
      testai = fakeai;
      nearaiarray = entsearch(level.contents_actor, node.origin, 16);

      if(nearaiarray.size > 0)
        testai = nearaiarray[0];

      rendernode = 1;

      if(distancesquared(node.origin, player.origin) > 640000)
        rendernode = 0;

      nodecolor = nodecolors["Good"];
      stance = node has_spawnflag(4) && !node has_spawnflag(8);
      transtype = anim.approach_types[node.type][stance];
      totaltransitions = 0;
      validtransitions = 0;
      animname = "arrive_" + transtype;

      if(tool == 2)
        animname = "exit_" + transtype;

      if(fakeai shoulddocqbtransition(node, transtype))
        animname = animname + "_cqb";

      if(!isDefined(node.angledeltaarray))
        node.angledeltaarray = fakeai angledeltaarray(animname, "move");

      for(j = 1; j <= 9; j++) {
        if(isDefined(node.angledeltaarray[j])) {
          totaltransitions++;
          linecolor = vectorscale((1, 0, 0), 0.5);
          approachisgood = 0;
          originalenterpos = undefined;
          approachfinalyaw = node.angles[1] + animscripts\cover_arrival::getnodestanceyawoffset(transtype);
          angle = (0, approachfinalyaw - node.angledeltaarray[j], 0);

          if(tool == 2)
            angle = (0, approachfinalyaw, 0);

          forwarddir = anglestoforward(angle);
          rightdir = anglestoright(angle);

          if(!isDefined(node.movedeltaarray))
            node.movedeltaarray = fakeai movedeltaarray(animname, "move");

          enterpos = node.origin;
          forward = vectorscale(forwarddir, node.movedeltaarray[j][0]);
          right = vectorscale(rightdir, node.movedeltaarray[j][1]);

          if(tool == 1)
            enterpos = node.origin - forward + right;
          else
            enterpos = node.origin + forward - right;

          if(testai maymovefrompointtopoint(node.origin, enterpos)) {
            approachisgood = 1;
            linecolor = vectorscale((0, 1, 0), 0.75);
          }

          if(rendernode)
            line(node.origin, enterpos, linecolor, 1, 1, frameinterval);

          if(approachisgood && j >= 7 && !issubstr(transtype, "exposed")) {
            originalenterpos = enterpos;

            if(tool == 1) {
              if(!isDefined(node.premovedeltaarray))
                node.premovedeltaarray = fakeai premovedeltaarray(animname, "move");

              forward = vectorscale(forwarddir, node.premovedeltaarray[j][0]);
              right = vectorscale(rightdir, node.premovedeltaarray[j][1]);
              originalenterpos = enterpos - forward + right;
            } else {
              if(!isDefined(node.postmovedeltaarray))
                node.postmovedeltaarray = fakeai postmovedeltaarray(animname, "move");

              forward = vectorscale(forwarddir, node.postmovedeltaarray[j][0]);
              right = vectorscale(rightdir, node.postmovedeltaarray[j][1]);
              originalenterpos = enterpos + forward - right;
            }

            if(!testai maymovefrompointtopoint(originalenterpos, enterpos)) {
              approachisgood = 0;
              linecolor = vectorscale((1, 0, 0), 0.5);
            }

            if(rendernode) {
              line(originalenterpos, enterpos, linecolor, 1, 1, frameinterval);
              print3d(originalenterpos, j + " (" + distance2d(originalenterpos, enterpos) + ")", linecolor, 1, 0.2, frameinterval);
            }
          } else if(rendernode)
            print3d(enterpos, j + " (" + distance2d(node.origin, enterpos) + ")", linecolor, 1, 0.2, frameinterval);

          if(approachisgood)
            validtransitions++;

          tracesthisframe++;
        }
      }

      node.lastratio = validtransitions / totaltransitions;

      if(node.lastratio == 0) {
        nodecolor = nodecolors["Bad"];
        numbad++;
        badnode = node;
      } else if(node.lastratio < 0.5) {
        nodecolor = nodecolors["Poor"];
        numpoor++;
      } else if(node.lastratio < 1.0) {
        nodecolor = nodecolors["Ok"];
        numok++;
      } else
        numgood++;

      if(rendernode) {
        print3d(node.origin, node.type + " (" + transtype + ")", nodecolor, 1, 0.35, frameinterval);
        box(node.origin, vectorscale((-1, -1, 0), 16.0), vectorscale((1, 1, 1), 16.0), node.angles[1], nodecolor, 1, 1, frameinterval);
        nodeforward = anglestoforward(node.angles);
        nodeforward = vectorscale(nodeforward, 8);
        line(node.origin, node.origin + nodeforward, nodecolor, 1, 1, frameinterval);
        renderedthisframe++;
      }

      evaluatedthisframe++;
      node.lastcheckedtime = gettime();
    }

    hudtotal setvalue(numbad + numpoor + numok + numgood);
    hudbad setvalue(numbad);
    hudpoor setvalue(numpoor);
    hudok setvalue(numok);
    hudgood setvalue(numgood);
    wait 0.05;
  }

}