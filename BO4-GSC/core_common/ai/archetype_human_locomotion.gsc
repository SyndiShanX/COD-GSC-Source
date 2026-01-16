/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human_locomotion.gsc
*********************************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai_shared;

#namespace archetype_human_locomotion;

autoexec registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&prepareformovement));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareformovement", &prepareformovement);
  assert(isscriptfunctionptr(&prepareformovement));
  behaviorstatemachine::registerbsmscriptapiinternal(#"prepareformovement", &prepareformovement);
  assert(isscriptfunctionptr(&shouldtacticalarrivecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldtacticalarrive", &shouldtacticalarrivecondition);
  assert(isscriptfunctionptr(&planhumanarrivalatcover));
  behaviorstatemachine::registerbsmscriptapiinternal(#"planhumanarrivalatcover", &planhumanarrivalatcover);
  assert(isscriptfunctionptr(&shouldplanarrivalintocover));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldplanarrivalintocover", &shouldplanarrivalintocover);
  assert(iscodefunctionptr(&btapi_shouldarriveexposed));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldarriveexposed", &btapi_shouldarriveexposed);
  assert(isscriptfunctionptr(&shouldarriveexposed));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldarriveexposed", &shouldarriveexposed);
  assert(iscodefunctionptr(&btapi_humannoncombatlocomotionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humannoncombatlocomotionupdate", &btapi_humannoncombatlocomotionupdate);
  assert(isscriptfunctionptr(&noncombatlocomotionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"noncombatlocomotionupdate", &noncombatlocomotionupdate);
  assert(isscriptfunctionptr(&combatlocomotionstart));
  behaviorstatemachine::registerbsmscriptapiinternal(#"combatlocomotionstart", &combatlocomotionstart);
  assert(iscodefunctionptr(&btapi_combatlocomotionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_combatlocomotionupdate", &btapi_combatlocomotionupdate);
  assert(isscriptfunctionptr(&combatlocomotionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"combatlocomotionupdate", &combatlocomotionupdate);
  assert(iscodefunctionptr(&btapi_humannoncombatlocomotioncondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humannoncombatlocomotioncondition", &btapi_humannoncombatlocomotioncondition);
  assert(isscriptfunctionptr(&humannoncombatlocomotioncondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"humannoncombatlocomotioncondition", &humannoncombatlocomotioncondition);
  assert(iscodefunctionptr(&btapi_humancombatlocomotioncondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humancombatlocomotioncondition", &btapi_humancombatlocomotioncondition);
  assert(isscriptfunctionptr(&humancombatlocomotioncondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"humancombatlocomotioncondition", &humancombatlocomotioncondition);
  assert(iscodefunctionptr(&btapi_shouldswitchtotacticalwalkfromrun));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldswitchtotacticalwalkfromrun", &btapi_shouldswitchtotacticalwalkfromrun);
  assert(isscriptfunctionptr(&shouldswitchtotacticalwalkfromrun));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldswitchtotacticalwalkfromrun", &shouldswitchtotacticalwalkfromrun);
  assert(isscriptfunctionptr(&preparetostopnearenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"preparetostopnearenemy", &preparetostopnearenemy);
  assert(isscriptfunctionptr(&preparetostopnearenemy));
  behaviorstatemachine::registerbsmscriptapiinternal(#"preparetostopnearenemy", &preparetostopnearenemy);
  assert(isscriptfunctionptr(&preparetomoveawayfromnearbyenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"preparetomoveawayfromnearbyenemy", &preparetomoveawayfromnearbyenemy);
  assert(isscriptfunctionptr(&shouldtacticalwalkpain));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldtacticalwalkpain", &shouldtacticalwalkpain);
  assert(isscriptfunctionptr(&begintacticalwalkpain));
  behaviorstatemachine::registerbsmscriptapiinternal(#"begintacticalwalkpain", &begintacticalwalkpain);
  assert(isscriptfunctionptr(&shouldcontinuetacticalwalkpain));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldcontinuetacticalwalkpain", &shouldcontinuetacticalwalkpain);
  assert(isscriptfunctionptr(&shouldtacticalwalkscan));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldtacticalwalkscan", &shouldtacticalwalkscan);
  assert(isscriptfunctionptr(&continuetacticalwalkscan));
  behaviorstatemachine::registerbsmscriptapiinternal(#"continuetacticalwalkscan", &continuetacticalwalkscan);
  assert(isscriptfunctionptr(&tacticalwalkscanterminate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"tacticalwalkscanterminate", &tacticalwalkscanterminate);
  assert(isscriptfunctionptr(&bsmlocomotionhasvalidpaininterrupt));
  behaviorstatemachine::registerbsmscriptapiinternal(#"bsmlocomotionhasvalidpaininterrupt", &bsmlocomotionhasvalidpaininterrupt);
}

private tacticalwalkscanterminate(entity) {
  entity.lasttacticalscantime = gettime();
  return true;
}

private shouldtacticalwalkscan(entity) {
  if(isDefined(entity.lasttacticalscantime) && entity.lasttacticalscantime + 2000 > gettime()) {
    return false;
  }

  if(!entity haspath()) {
    return false;
  }

  if(isDefined(entity.enemy)) {
    return false;
  }

  if(entity shouldfacemotion()) {
    if(ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk")) {
      return false;
    }
  }

  animation = entity asmgetcurrentdeltaanimation();

  if(isDefined(animation)) {
    animtime = entity getanimtime(animation);
    return (animtime <= 0.05);
  }

  return false;
}

private continuetacticalwalkscan(entity) {
  if(!entity haspath()) {
    return false;
  }

  if(isDefined(entity.enemy)) {
    return false;
  }

  if(entity shouldfacemotion()) {
    if(ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk")) {
      return false;
    }
  }

  animation = entity asmgetcurrentdeltaanimation();

  if(isDefined(animation)) {
    animlength = getanimlength(animation);
    animtime = entity getanimtime(animation) * animlength;
    normalizedtime = (animtime + 0.2) / animlength;
    return (normalizedtime < 1);
  }

  return false;
}

private shouldtacticalwalkpain(entity) {
  if((!isDefined(entity.startpaintime) || entity.startpaintime + 3000 < gettime()) && randomfloat(1) > 0.25) {
    return bsmlocomotionhasvalidpaininterrupt(entity);
  }

  return 0;
}

private begintacticalwalkpain(entity) {
  entity.startpaintime = gettime();
  return true;
}

private shouldcontinuetacticalwalkpain(entity) {
  return entity.startpaintime + 100 >= gettime();
}

private bsmlocomotionhasvalidpaininterrupt(entity) {
  return entity hasvalidinterrupt("pain");
}

private shouldarriveexposed(behaviortreeentity) {
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

private preparetostopnearenemy(behaviortreeentity) {
  behaviortreeentity clearpath();
  behaviortreeentity.keepclaimednode = 1;
}

private preparetomoveawayfromnearbyenemy(behaviortreeentity) {
  behaviortreeentity clearpath();
  behaviortreeentity.keepclaimednode = 1;
}

private shouldplanarrivalintocover(behaviortreeentity) {
  goingtocovernode = isDefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node);

  if(!goingtocovernode) {
    return false;
  }

  if(isDefined(behaviortreeentity.pathgoalpos)) {
    if(isDefined(behaviortreeentity.arrivalfinalpos)) {
      if(behaviortreeentity.arrivalfinalpos != behaviortreeentity.pathgoalpos) {
        return true;
      } else if(behaviortreeentity.ai.replannedcoverarrival === 0 && isDefined(behaviortreeentity.exitpos) && isDefined(behaviortreeentity.predictedexitpos)) {
        behaviortreeentity.ai.replannedcoverarrival = 1;
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

private shouldswitchtotacticalwalkfromrun(behaviortreeentity) {
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

    if(pathdist < 250 * 250) {
      return true;
    }
  }

  if(!behaviortreeentity shouldfacemotion()) {
    return true;
  }

  return false;
}

private humannoncombatlocomotioncondition(behaviortreeentity) {
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

private humancombatlocomotioncondition(behaviortreeentity) {
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

private combatlocomotionstart(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_desired_stance", "stand");
  randomchance = randomint(100);

  if(randomchance > 50) {
    behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_forward");
    return true;
  }

  if(randomchance > 25) {
    behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_strafe_1");
    return true;
  }

  behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_strafe_2");
  return true;
}

private noncombatlocomotionupdate(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }

  if(isDefined(behaviortreeentity.enemy) && !(isDefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) && !behaviortreeentity humanshouldsprint()) {
    return false;
  }

  if(!behaviortreeentity asmistransitionrunning()) {
    behaviortreeentity setblackboardattribute("_stance", "stand");

    if(!isDefined(behaviortreeentity.ai.replannedcoverarrival)) {
      behaviortreeentity.ai.replannedcoverarrival = 0;
    }
  } else {
    behaviortreeentity.ai.replannedcoverarrival = undefined;
  }

  return true;
}

private combatlocomotionupdate(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }

  if(behaviortreeentity humanshouldsprint()) {
    return false;
  }

  if(!behaviortreeentity asmistransitionrunning()) {
    behaviortreeentity setblackboardattribute("_stance", "stand");

    if(!isDefined(behaviortreeentity.replannedcoverarrival)) {
      behaviortreeentity.ai.replannedcoverarrival = 0;
    }
  } else {
    behaviortreeentity.ai.replannedcoverarrival = undefined;
  }

  if(isDefined(behaviortreeentity.enemy)) {
    return true;
  }

  return false;
}

private prepareformovement(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_stance", "stand");
  return true;
}

private isarrivingfour(arrivalangle) {
  if(arrivalangle >= 45 && arrivalangle <= 120) {
    return true;
  }

  return false;
}

private isarrivingone(arrivalangle) {
  if(arrivalangle >= 120 && arrivalangle <= 165) {
    return true;
  }

  return false;
}

private isarrivingtwo(arrivalangle) {
  if(arrivalangle >= 165 && arrivalangle <= 195) {
    return true;
  }

  return false;
}

private isarrivingthree(arrivalangle) {
  if(arrivalangle >= 195 && arrivalangle <= 240) {
    return true;
  }

  return false;
}

private isarrivingsix(arrivalangle) {
  if(arrivalangle >= 240 && arrivalangle <= 315) {
    return true;
  }

  return false;
}

private isfacingfour(facingangle) {
  if(facingangle >= 45 && facingangle <= 135) {
    return true;
  }

  return false;
}

private isfacingeight(facingangle) {
  if(facingangle >= -45 && facingangle <= 45) {
    return true;
  }

  return false;
}

private isfacingseven(facingangle) {
  if(facingangle >= 0 && facingangle <= 90) {
    return true;
  }

  return false;
}

private isfacingsix(facingangle) {
  if(facingangle >= -135 && facingangle <= -45) {
    return true;
  }

  return false;
}

private isfacingnine(facingangle) {
  if(facingangle >= -90 && facingangle <= 0) {
    return true;
  }

  return false;
}

private shouldtacticalarrivecondition(behaviortreeentity) {
  if(getdvarint(#"enabletacticalarrival", 0) != 1) {
    return false;
  }

  if(!isDefined(behaviortreeentity.node)) {
    return false;
  }

  if(!(behaviortreeentity.node.type == #"cover left")) {
    return false;
  }

  stance = behaviortreeentity getblackboardattribute("_arrival_stance");

  if(stance != "stand") {
    return false;
  }

  arrivaldistance = 35;

  arrivaldvar = getdvarint(#"tacarrivaldistance", 0);

  if(arrivaldvar != 0) {
    arrivaldistance = arrivaldvar;
  }

  nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);

  if(distance(nodeoffsetposition, behaviortreeentity.origin) > arrivaldistance || distance(nodeoffsetposition, behaviortreeentity.origin) < 25) {
    return false;
  }

  entityangles = vectortoangles(behaviortreeentity.origin - nodeoffsetposition);

  if(abs(behaviortreeentity.node.angles[1] - entityangles[1]) < 60) {
    return false;
  }

  tacticalfaceangle = behaviortreeentity getblackboardattribute("_tactical_arrival_facing_yaw");
  arrivalangle = behaviortreeentity getblackboardattribute("_locomotion_arrival_yaw");

  if(isarrivingfour(arrivalangle)) {
    if(!isfacingsix(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingfour(tacticalfaceangle)) {
      return false;
    }
  } else if(isarrivingone(arrivalangle)) {
    if(!isfacingnine(tacticalfaceangle) && !isfacingseven(tacticalfaceangle)) {
      return false;
    }
  } else if(isarrivingtwo(arrivalangle)) {
    if(!isfacingeight(tacticalfaceangle)) {
      return false;
    }
  } else if(isarrivingthree(arrivalangle)) {
    if(!isfacingseven(tacticalfaceangle) && !isfacingnine(tacticalfaceangle)) {
      return false;
    }
  } else if(isarrivingsix(arrivalangle)) {
    if(!isfacingfour(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingsix(tacticalfaceangle)) {
      return false;
    }
  } else {
    return false;
  }

  return true;
}

private humanshouldsprint() {
  currentlocomovementtype = self getblackboardattribute("_human_locomotion_movement_type");
  return currentlocomovementtype == "human_locomotion_movement_sprint";
}

private planhumanarrivalatcover(behaviortreeentity, arrivalanim) {
  if(behaviortreeentity ai::get_behavior_attribute("disablearrivals")) {
    return false;
  }

  behaviortreeentity setblackboardattribute("_desired_stance", "stand");

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
      isright = behaviortreeentity.node.type == #"cover right";
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
        coverenterpos = nodeoffsetposition - forward + right;
        postenterpos = coverenterpos;
        forward = vectorscale(forwarddir, premovedelta[0]);
        right = vectorscale(rightdir, premovedelta[1]);
        coverenterpos = coverenterpos - forward + right;

        recordline(postenterpos, nodeoffsetposition, (1, 0.5, 0), "<dev string:x38>", behaviortreeentity);
        recordline(coverenterpos, postenterpos, (1, 0.5, 0), "<dev string:x38>", behaviortreeentity);

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
        coverenterpos = nodeoffsetposition - forward + right;

        if(!behaviortreeentity maymovefrompointtopoint(coverenterpos, nodeoffsetposition, 1, 1)) {
          return false;
        }
      }

      if(!checkcoverarrivalconditions(coverenterpos, nodeoffsetposition)) {
        return false;
      }

      if(ispointonnavmesh(coverenterpos, behaviortreeentity)) {
        recordcircle(coverenterpos, 2, (1, 0, 0), "<dev string:x45>", behaviortreeentity);

        behaviortreeentity function_a57c34b7(coverenterpos, behaviortreeentity.pathgoalpos);
        return true;
      }
    }
  }

  return false;
}

private checkcoverarrivalconditions(coverenterpos, coverpos) {
  distsqtonode = distancesquared(self.origin, coverpos);
  distsqfromnodetoenterpos = distancesquared(coverpos, coverenterpos);
  awayfromenterpos = distsqtonode >= distsqfromnodetoenterpos + 150;

  if(!awayfromenterpos) {
    return false;
  }

  trace = groundtrace(coverenterpos + (0, 0, 72), coverenterpos + (0, 0, -72), 0, 0, 0);

  if(isDefined(trace[#"position"]) && abs(trace[#"position"][2] - coverpos[2]) > 30) {
    if(getdvarint(#"ai_debugarrivals", 0)) {
      recordcircle(coverenterpos, 1, (1, 0, 0), "<dev string:x38>");
      record3dtext("<dev string:x4e>", coverenterpos, (1, 0, 0), "<dev string:x38>", undefined, 0.4);
      recordcircle(trace[#"position"], 1, (1, 0, 0), "<dev string:x38>");
      record3dtext("<dev string:x67>" + int(abs(trace[#"position"][2] - coverpos[2])), trace[#"position"] + (0, 0, 5), (1, 0, 0), "<dev string:x38>", undefined, 0.4);
      record3dtext("<dev string:x7e>" + 30, trace[#"position"], (1, 0, 0), "<dev string:x38>", undefined, 0.4);
      recordline(coverenterpos, trace[#"position"], (1, 0, 0), "<dev string:x38>");
    }

    return false;
  }

  return true;
}

private getarrivalsplittime(arrivalanim, isright) {
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
    bestsplit = 0.4;
  }

  level.animarrivalsplittimes[arrivalanim] = bestsplit;
  return bestsplit;
}

private deltarotate(delta, yaw) {
  cosine = cos(yaw);
  sine = sin(yaw);
  return (delta[0] * cosine - delta[1] * sine, delta[1] * cosine + delta[0] * sine, 0);
}