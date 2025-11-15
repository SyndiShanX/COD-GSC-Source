/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_human_locomotion.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_state_machine;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#namespace archetype_human_locomotion;

function autoexec registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareForMovement", & prepareformovement);
  behaviorstatemachine::registerbsmscriptapiinternal("prepareForMovement", & prepareformovement);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldTacticalArrive", & shouldtacticalarrivecondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("humanShouldSprint", & humanshouldsprint);
  behaviorstatemachine::registerbsmscriptapiinternal("planHumanArrivalAtCover", & planhumanarrivalatcover);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldPlanArrivalIntoCover", & shouldplanarrivalintocover);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldArriveExposed", & shouldarriveexposed);
  behaviorstatemachine::registerbsmscriptapiinternal("nonCombatLocomotionUpdate", & noncombatlocomotionupdate);
  behaviorstatemachine::registerbsmscriptapiinternal("combatLocomotionStart", & combatlocomotionstart);
  behaviorstatemachine::registerbsmscriptapiinternal("combatLocomotionUpdate", & combatlocomotionupdate);
  behaviorstatemachine::registerbsmscriptapiinternal("humanNonCombatLocomotionCondition", & humannoncombatlocomotioncondition);
  behaviorstatemachine::registerbsmscriptapiinternal("humanCombatLocomotionCondition", & humancombatlocomotioncondition);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldSwitchToTacticalWalkFromRun", & shouldswitchtotacticalwalkfromrun);
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToStopNearEnemy", & preparetostopnearenemy);
  behaviorstatemachine::registerbsmscriptapiinternal("prepareToStopNearEnemy", & preparetostopnearenemy);
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToMoveAwayFromNearByEnemy", & preparetomoveawayfromnearbyenemy);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalkPain", & shouldtacticalwalkpain);
  behaviorstatemachine::registerbsmscriptapiinternal("beginTacticalWalkPain", & begintacticalwalkpain);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldContinueTacticalWalkPain", & shouldcontinuetacticalwalkpain);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalkScan", & shouldtacticalwalkscan);
  behaviorstatemachine::registerbsmscriptapiinternal("continueTacticalWalkScan", & continuetacticalwalkscan);
  behaviorstatemachine::registerbsmscriptapiinternal("tacticalWalkScanTerminate", & tacticalwalkscanterminate);
  behaviorstatemachine::registerbsmscriptapiinternal("BSMLocomotionHasValidPainInterrupt", & bsmlocomotionhasvalidpaininterrupt);
}

function private tacticalwalkscanterminate(entity) {
  entity.lasttacticalscantime = gettime();
  return true;
}

function private shouldtacticalwalkscan(entity) {
  if(isDefined(entity.lasttacticalscantime) && (entity.lasttacticalscantime + 2000) > gettime()) {
    return 0;
  }
  if(!entity haspath()) {
    return 0;
  }
  if(isDefined(entity.enemy)) {
    return 0;
  }
  if(entity shouldfacemotion()) {
    if(ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk")) {
      return 0;
    }
  }
  animation = entity asmgetcurrentdeltaanimation();
  if(isDefined(animation)) {
    animtime = entity getanimtime(animation);
    return animtime <= 0.05;
  }
  return 0;
}

function private continuetacticalwalkscan(entity) {
  if(!entity haspath()) {
    return 0;
  }
  if(isDefined(entity.enemy)) {
    return 0;
  }
  if(entity shouldfacemotion()) {
    if(ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk")) {
      return 0;
    }
  }
  animation = entity asmgetcurrentdeltaanimation();
  if(isDefined(animation)) {
    animlength = getanimlength(animation);
    animtime = entity getanimtime(animation) * animlength;
    normalizedtime = (animtime + 0.2) / animlength;
    return normalizedtime < 1;
  }
  return 0;
}

function private shouldtacticalwalkpain(entity) {
  if(!isDefined(entity.startpaintime) || (entity.startpaintime + 3000) < gettime() && randomfloat(1) > 0.25) {
    return bsmlocomotionhasvalidpaininterrupt(entity);
  }
  return 0;
}

function private begintacticalwalkpain(entity) {
  entity.startpaintime = gettime();
  return true;
}

function private shouldcontinuetacticalwalkpain(entity) {
  return (entity.startpaintime + 100) >= gettime();
}

function private bsmlocomotionhasvalidpaininterrupt(entity) {
  return entity hasvalidinterrupt("pain");
}

function private shouldarriveexposed(behaviortreeentity) {
  if(behaviortreeentity ai::get_behavior_attribute("disablearrivals")) {
    return false;
  }
  if(behaviortreeentity haspath()) {
    if(isDefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node) && isDefined(behaviortreeentity.pathgoalpos) && distancesquared(behaviortreeentity.pathgoalpos, behaviortreeentity getnodeoffsetposition(behaviortreeentity.node)) < 8) {
      return false;
    }
  }
  return true;
}

function private preparetostopnearenemy(behaviortreeentity) {
  behaviortreeentity clearpath();
  behaviortreeentity.keepclaimednode = 1;
}

function private preparetomoveawayfromnearbyenemy(behaviortreeentity) {
  behaviortreeentity clearpath();
  behaviortreeentity.keepclaimednode = 1;
}

function private shouldplanarrivalintocover(behaviortreeentity) {
  goingtocovernode = isDefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node);
  if(!goingtocovernode) {
    return false;
  }
  if(isDefined(behaviortreeentity.pathgoalpos)) {
    if(isDefined(behaviortreeentity.arrivalfinalpos)) {
      if(behaviortreeentity.arrivalfinalpos != behaviortreeentity.pathgoalpos) {
        return true;
      }
      if(behaviortreeentity.replannedcoverarrival === 0 && isDefined(behaviortreeentity.exitpos) && isDefined(behaviortreeentity.predictedexitpos)) {
        behaviortreeentity.replannedcoverarrival = 1;
        exitdir = vectornormalize(behaviortreeentity.predictedexitpos - behaviortreeentity.exitpos);
        currentdir = vectornormalize(behaviortreeentity.origin - behaviortreeentity.exitpos);
        if(vectordot(exitdir, currentdir) < cos(30)) {
          behaviortreeentity.predictedarrivaldirectionvalid = 0;
          return true;
        }
      }
    }
  }
  return false;
}

function private shouldswitchtotacticalwalkfromrun(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }
  if(ai::hasaiattribute(behaviortreeentity, "forceTacticalWalk") && ai::getaiattribute(behaviortreeentity, "forceTacticalWalk")) {
    return true;
  }
  goalpos = undefined;
  if(isDefined(behaviortreeentity.arrivalfinalpos)) {
    goalpos = behaviortreeentity.arrivalfinalpos;
  } else {
    goalpos = behaviortreeentity.pathgoalpos;
  }
  if(isDefined(behaviortreeentity.pathstartpos) && isDefined(goalpos)) {
    pathdist = distancesquared(behaviortreeentity.pathstartpos, goalpos);
    if(pathdist < (250 * 250)) {
      return true;
    }
  }
  if(!behaviortreeentity shouldfacemotion()) {
    return true;
  }
  return false;
}

function private humannoncombatlocomotioncondition(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }
  if(isDefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
    return true;
  }
  if(behaviortreeentity humanshouldsprint()) {
    return true;
  }
  if(isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  return true;
}

function private humancombatlocomotioncondition(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }
  if(isDefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
    return false;
  }
  if(behaviortreeentity humanshouldsprint()) {
    return false;
  }
  if(isDefined(behaviortreeentity.enemy)) {
    return true;
  }
  return false;
}

function private combatlocomotionstart(behaviortreeentity) {
  randomchance = randomint(100);
  if(randomchance > 50) {
    blackboard::setblackboardattribute(behaviortreeentity, "_run_n_gun_variation", "variation_forward");
    return true;
  }
  if(randomchance > 25) {
    blackboard::setblackboardattribute(behaviortreeentity, "_run_n_gun_variation", "variation_strafe_1");
    return true;
  }
  blackboard::setblackboardattribute(behaviortreeentity, "_run_n_gun_variation", "variation_strafe_2");
  return true;
}

function private noncombatlocomotionupdate(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }
  if(isDefined(behaviortreeentity.enemy) && (!(isDefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) && !behaviortreeentity humanshouldsprint())) {
    return false;
  }
  if(!behaviortreeentity asmistransitionrunning()) {
    blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
    if(!isDefined(behaviortreeentity.replannedcoverarrival)) {
      behaviortreeentity.replannedcoverarrival = 0;
    }
  } else {
    behaviortreeentity.replannedcoverarrival = undefined;
  }
  return true;
}

function private combatlocomotionupdate(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }
  if(behaviortreeentity humanshouldsprint()) {
    return false;
  }
  if(!behaviortreeentity asmistransitionrunning()) {
    blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
    if(!isDefined(behaviortreeentity.replannedcoverarrival)) {
      behaviortreeentity.replannedcoverarrival = 0;
    }
  } else {
    behaviortreeentity.replannedcoverarrival = undefined;
  }
  if(isDefined(behaviortreeentity.enemy)) {
    return true;
  }
  return false;
}

function private prepareformovement(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
  return true;
}

function private isarrivingfour(arrivalangle) {
  if(arrivalangle >= 45 && arrivalangle <= 120) {
    return true;
  }
  return false;
}

function private isarrivingone(arrivalangle) {
  if(arrivalangle >= 120 && arrivalangle <= 165) {
    return true;
  }
  return false;
}

function private isarrivingtwo(arrivalangle) {
  if(arrivalangle >= 165 && arrivalangle <= 195) {
    return true;
  }
  return false;
}

function private isarrivingthree(arrivalangle) {
  if(arrivalangle >= 195 && arrivalangle <= 240) {
    return true;
  }
  return false;
}

function private isarrivingsix(arrivalangle) {
  if(arrivalangle >= 240 && arrivalangle <= 315) {
    return true;
  }
  return false;
}

function private isfacingfour(facingangle) {
  if(facingangle >= 45 && facingangle <= 135) {
    return true;
  }
  return false;
}

function private isfacingeight(facingangle) {
  if(facingangle >= -45 && facingangle <= 45) {
    return true;
  }
  return false;
}

function private isfacingseven(facingangle) {
  if(facingangle >= 0 && facingangle <= 90) {
    return true;
  }
  return false;
}

function private isfacingsix(facingangle) {
  if(facingangle >= -135 && facingangle <= -45) {
    return true;
  }
  return false;
}

function private isfacingnine(facingangle) {
  if(facingangle >= -90 && facingangle <= 0) {
    return true;
  }
  return false;
}

function private shouldtacticalarrivecondition(behaviortreeentity) {
  if(getdvarint("enableTacticalArrival") != 1) {
    return false;
  }
  if(!isDefined(behaviortreeentity.node)) {
    return false;
  }
  if(!behaviortreeentity.node.type == "Cover Left") {
    return false;
  }
  stance = blackboard::getblackboardattribute(behaviortreeentity, "_arrival_stance");
  if(stance != "stand") {
    return false;
  }
  arrivaldistance = 35;
  arrivaldvar = getdvarint("");
  if(arrivaldvar != 0) {
    arrivaldistance = arrivaldvar;
  }
  nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
  if(distance(nodeoffsetposition, behaviortreeentity.origin) > arrivaldistance || distance(nodeoffsetposition, behaviortreeentity.origin) < 25) {
    return false;
  }
  entityangles = vectortoangles(behaviortreeentity.origin - nodeoffsetposition);
  if((abs(behaviortreeentity.node.angles[1] - entityangles[1])) < 60) {
    return false;
  }
  tacticalfaceangle = blackboard::getblackboardattribute(behaviortreeentity, "_tactical_arrival_facing_yaw");
  arrivalangle = blackboard::getblackboardattribute(behaviortreeentity, "_locomotion_arrival_yaw");
  if(isarrivingfour(arrivalangle)) {
    if(!isfacingsix(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingfour(tacticalfaceangle)) {
      return false;
    }
  } else {
    if(isarrivingone(arrivalangle)) {
      if(!isfacingnine(tacticalfaceangle) && !isfacingseven(tacticalfaceangle)) {
        return false;
      }
    } else {
      if(isarrivingtwo(arrivalangle)) {
        if(!isfacingeight(tacticalfaceangle)) {
          return false;
        }
      } else {
        if(isarrivingthree(arrivalangle)) {
          if(!isfacingseven(tacticalfaceangle) && !isfacingnine(tacticalfaceangle)) {
            return false;
          }
        } else {
          if(isarrivingsix(arrivalangle)) {
            if(!isfacingfour(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingsix(tacticalfaceangle)) {
              return false;
            }
          } else {
            return false;
          }
        }
      }
    }
  }
  return true;
}

function private humanshouldsprint() {
  currentlocomovementtype = blackboard::getblackboardattribute(self, "_human_locomotion_movement_type");
  return currentlocomovementtype == "human_locomotion_movement_sprint";
}

function private planhumanarrivalatcover(behaviortreeentity, arrivalanim) {
  if(behaviortreeentity ai::get_behavior_attribute("disablearrivals")) {
    return false;
  }
  blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
  if(!isDefined(arrivalanim)) {
    return false;
  }
  if(isDefined(behaviortreeentity.node) && isDefined(behaviortreeentity.pathgoalpos)) {
    if(!iscovernode(behaviortreeentity.node)) {
      return false;
    }
    nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
    if(nodeoffsetposition != behaviortreeentity.pathgoalpos) {
      return false;
    }
    if(isDefined(arrivalanim)) {
      isright = behaviortreeentity.node.type == "Cover Right";
      splittime = getarrivalsplittime(arrivalanim, isright);
      issplitarrival = splittime < 1;
      nodeapproachyaw = behaviortreeentity getnodeoffsetangles(behaviortreeentity.node)[1];
      angle = (0, nodeapproachyaw - getangledelta(arrivalanim), 0);
      if(issplitarrival) {
        forwarddir = anglesToForward(angle);
        rightdir = anglestoright(angle);
        animlength = getanimlength(arrivalanim);
        movedelta = getmovedelta(arrivalanim, 0, (animlength - 0.2) / animlength);
        premovedelta = getmovedelta(arrivalanim, 0, splittime);
        postmovedelta = movedelta - premovedelta;
        forward = vectorscale(forwarddir, postmovedelta[0]);
        right = vectorscale(rightdir, postmovedelta[1]);
        coverenterpos = (nodeoffsetposition - forward) + right;
        postenterpos = coverenterpos;
        forward = vectorscale(forwarddir, premovedelta[0]);
        right = vectorscale(rightdir, premovedelta[1]);
        coverenterpos = (coverenterpos - forward) + right;
        recordline(postenterpos, nodeoffsetposition, (1, 0.5, 0), "", behaviortreeentity);
        recordline(coverenterpos, postenterpos, (1, 0.5, 0), "", behaviortreeentity);
        if(!behaviortreeentity maymovefrompointtopoint(postenterpos, nodeoffsetposition, 1, 0)) {
          return false;
        }
        if(!behaviortreeentity maymovefrompointtopoint(coverenterpos, postenterpos, 1, 0)) {
          return false;
        }
      } else {
        forwarddir = anglesToForward(angle);
        rightdir = anglestoright(angle);
        movedeltaarray = getmovedelta(arrivalanim);
        forward = vectorscale(forwarddir, movedeltaarray[0]);
        right = vectorscale(rightdir, movedeltaarray[1]);
        coverenterpos = (nodeoffsetposition - forward) + right;
        if(!behaviortreeentity maymovefrompointtopoint(coverenterpos, nodeoffsetposition, 1, 1)) {
          return false;
        }
      }
      if(!checkcoverarrivalconditions(coverenterpos, nodeoffsetposition)) {
        return false;
      }
      if(ispointonnavmesh(coverenterpos, behaviortreeentity)) {
        recordcircle(coverenterpos, 2, (1, 0, 0), "", behaviortreeentity);
        behaviortreeentity useposition(coverenterpos, behaviortreeentity.pathgoalpos);
        return true;
      }
    }
  }
  return false;
}

function private checkcoverarrivalconditions(coverenterpos, coverpos) {
  distsqtonode = distancesquared(self.origin, coverpos);
  distsqfromnodetoenterpos = distancesquared(coverpos, coverenterpos);
  awayfromenterpos = distsqtonode >= (distsqfromnodetoenterpos + 150);
  if(!awayfromenterpos) {
    return false;
  }
  trace = groundtrace(coverenterpos + vectorscale((0, 0, 1), 72), coverenterpos + (vectorscale((0, 0, -1), 72)), 0, 0, 0);
  if(isDefined(trace["position"]) && (abs(trace["position"][2] - coverpos[2])) > 30) {
    if(getdvarint("")) {
      recordcircle(coverenterpos, 1, (1, 0, 0), "");
      record3dtext("", coverenterpos, (1, 0, 0), "", undefined, 0.4);
      recordcircle(trace[""], 1, (1, 0, 0), "");
      record3dtext("" + (int(abs(trace[""][2] - coverpos[2]))), trace[""] + vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
      record3dtext("" + 30, trace[""], (1, 0, 0), "", undefined, 0.4);
      recordline(coverenterpos, trace[""], (1, 0, 0), "");
    }
    return false;
  }
  return true;
}

function private getarrivalsplittime(arrivalanim, isright) {
  if(!isDefined(level.animarrivalsplittimes)) {
    level.animarrivalsplittimes = [];
  }
  if(isDefined(level.animarrivalsplittimes[arrivalanim])) {
    return level.animarrivalsplittimes[arrivalanim];
  }
  bestsplit = -1;
  if(animhasnotetrack(arrivalanim, "cover_split")) {
    times = getnotetracktimes(arrivalanim, "cover_split");
    assert(times.size > 0);
    bestsplit = times[0];
  } else {
    animlength = getanimlength(arrivalanim);
    normalizedlength = (animlength - 0.2) / animlength;
    angledelta = getangledelta(arrivalanim, 0, normalizedlength);
    fulldelta = getmovedelta(arrivalanim, 0, normalizedlength);
    bestvalue = -100000000;
    for(i = 0; i < 100; i++) {
      splittime = (1 * i) / (100 - 1);
      delta = getmovedelta(arrivalanim, 0, splittime);
      delta = deltarotate(fulldelta - delta, 180 - angledelta);
      if(isright) {
        delta = (delta[0], 0 - delta[1], delta[2]);
      }
      val = min(delta[0] - 32, delta[1]);
      if(val > bestvalue || bestsplit < 0) {
        bestvalue = val;
        bestsplit = splittime;
      }
    }
  }
  level.animarrivalsplittimes[arrivalanim] = bestsplit;
  return bestsplit;
}

function private deltarotate(delta, yaw) {
  cosine = cos(yaw);
  sine = sin(yaw);
  return ((delta[0] * cosine) - (delta[1] * sine), (delta[1] * cosine) + (delta[0] * sine), 0);
}