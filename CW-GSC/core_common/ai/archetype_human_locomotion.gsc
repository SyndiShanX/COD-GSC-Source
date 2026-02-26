/*********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human_locomotion.gsc
*********************************************************/

#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai_shared;
#namespace namespace_2dd2c4d8;

function autoexec registerbehaviorscriptfunctions() {
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
  assert(isscriptfunctionptr(&function_d68785cf));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_68e2b8b69e5739d0", &function_d68785cf);
  assert(iscodefunctionptr(&btapi_humannoncombatlocomotionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humannoncombatlocomotionupdate", &btapi_humannoncombatlocomotionupdate);
  assert(isscriptfunctionptr(&combatlocomotionstart));
  behaviorstatemachine::registerbsmscriptapiinternal(#"combatlocomotionstart", &combatlocomotionstart);
  assert(isscriptfunctionptr(&function_52950d3d));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6b12744ac88be28f", &function_52950d3d);
  assert(isscriptfunctionptr(&function_4937d436));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5ff9dd2b25d5c185", &function_4937d436);
  assert(isscriptfunctionptr(&function_145df88b));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_57981ededd43a0de", &function_145df88b);
  assert(isscriptfunctionptr(&function_2985b5fa));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4caa5fa7a97f83ea", &function_2985b5fa);
  assert(isscriptfunctionptr(&function_31a6aada));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_341f9ccd69da418c", &function_31a6aada);
  assert(isscriptfunctionptr(&function_41ae663f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_cf6fb7a59d64171", &function_41ae663f);
  assert(isscriptfunctionptr(&function_76ff98aa));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1fa0b1eca87bd7ef", &function_76ff98aa);
  assert(isscriptfunctionptr(&function_e20dbfa4));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_66f99f9da0a69762", &function_e20dbfa4);
  assert(isscriptfunctionptr(&function_888d9ea5));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_58eba240a42bbdcd", &function_888d9ea5);
  assert(isscriptfunctionptr(&function_e20dbfa4));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_66f99f9da0a69762", &function_e20dbfa4);
  assert(isscriptfunctionptr(&function_888d9ea5));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58eba240a42bbdcd", &function_888d9ea5);
  assert(isscriptfunctionptr(&function_45d8f364));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4160e8b3456ab234", &function_45d8f364);
  assert(isscriptfunctionptr(&function_27c368b1));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6c5516f89d4ff0c7", &function_27c368b1);
  assert(isscriptfunctionptr(&function_45d8f364));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4160e8b3456ab234", &function_45d8f364);
  assert(isscriptfunctionptr(&function_27c368b1));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6c5516f89d4ff0c7", &function_27c368b1);
  assert(iscodefunctionptr(&btapi_combatlocomotionupdate));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_combatlocomotionupdate", &btapi_combatlocomotionupdate);
  assert(iscodefunctionptr(&btapi_humannoncombatlocomotioncondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humannoncombatlocomotioncondition", &btapi_humannoncombatlocomotioncondition);
  assert(iscodefunctionptr(&btapi_humancombatlocomotioncondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humancombatlocomotioncondition", &btapi_humancombatlocomotioncondition);
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
  assert(isscriptfunctionptr(&bsmlocomotionhasvalidpaininterrupt));
  behaviorstatemachine::registerbsmscriptapiinternal(#"bsmlocomotionhasvalidpaininterrupt", &bsmlocomotionhasvalidpaininterrupt);
  assert(isscriptfunctionptr(&function_1972c057));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_61aa304b516f76a7", &function_1972c057);
  assert(isscriptfunctionptr(&function_968efd1f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_17b044df7de84a21", &function_968efd1f);
  assert(isscriptfunctionptr(&function_80c579d8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2a9f4015fc6217df", &function_80c579d8);
  assert(iscodefunctionptr(&function_2da76de));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_34f3c9eb834c01fb", &function_2da76de);
  assert(iscodefunctionptr(&function_2da76de));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34f3c9eb834c01fb", &function_2da76de);
  assert(isscriptfunctionptr(&function_c34dd9f8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2746da0437b7aaf9", &function_c34dd9f8);
  assert(isscriptfunctionptr(&function_f2c9142));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_77f68c7d2552ba09", &function_f2c9142);
  assert(isscriptfunctionptr(&function_d8a81861));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3d48a4a68d62f9b2", &function_d8a81861);
  assert(isscriptfunctionptr(&function_ab6f96b6));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_25898377b0649f0e", &function_ab6f96b6);
  assert(isscriptfunctionptr(&function_7ba867a8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_631ad7fc5b704ad", &function_7ba867a8);
  assert(isscriptfunctionptr(&function_52c3ab28));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_799d1239ee7780df", &function_52c3ab28);
  assert(isscriptfunctionptr(&function_b1092561));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7a0baaf803e988e1", &function_b1092561);
}

function private shouldtacticalwalkpain(entity) {
  if((!isDefined(entity.startpaintime) || entity.startpaintime + 3000 < gettime()) && randomfloat(1) > 0.25) {
    return bsmlocomotionhasvalidpaininterrupt(entity);
  }

  return 0;
}

function private begintacticalwalkpain(entity) {
  entity.startpaintime = gettime();
  return true;
}

function private shouldcontinuetacticalwalkpain(entity) {
  return entity.startpaintime + 100 >= gettime();
}

function private bsmlocomotionhasvalidpaininterrupt(entity) {
  return entity hasvalidinterrupt("pain");
}

function private preparetostopnearenemy(behaviortreeentity) {
  behaviortreeentity clearpath();
  aiutility::keepclaimnode(behaviortreeentity);
}

function private preparetomoveawayfromnearbyenemy(behaviortreeentity) {
  behaviortreeentity clearpath();
  aiutility::keepclaimnode(behaviortreeentity);
}

function private shouldplanarrivalintocover(behaviortreeentity) {
  goingtocovernode = isDefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node) && behaviortreeentity function_4c2fffe6(behaviortreeentity.node);

  if(!goingtocovernode) {
    return false;
  }

  if(!aiutility::function_c94f0d1(behaviortreeentity)) {
    return false;
  }

  if(isDefined(behaviortreeentity.pathgoalpos)) {
    if(is_true(behaviortreeentity.ai.var_ee9a2dfd)) {
      return true;
    } else if(isDefined(behaviortreeentity.arrivalfinalpos)) {
      nodeoffsetpos = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);

      if(behaviortreeentity.arrivalfinalpos != nodeoffsetpos) {
        return true;
      } else if(behaviortreeentity.ai.replannedcoverarrival === 0 && isDefined(behaviortreeentity.exitpos) && isDefined(behaviortreeentity.predictedexitpos)) {
        behaviortreeentity.ai.replannedcoverarrival = 1;
        exitdir = vectornormalize(behaviortreeentity.predictedexitpos - behaviortreeentity.exitpos);
        currentdir = vectornormalize(behaviortreeentity.origin - behaviortreeentity.exitpos);

        if(lengthsquared(exitdir) > 0.0001 && lengthsquared(currentdir) > 0.0001 && vectordot(exitdir, currentdir) < cos(30)) {
          behaviortreeentity.predictedarrivaldirectionvalid = 0;
          return true;
        }

        var_f4f4457e = function_15a5703b(#"human", behaviortreeentity function_28e7d252());

        if(behaviortreeentity.var_2dc0ed5e !== var_f4f4457e) {
          return true;
        }
      }
    } else {
      return true;
    }
  }

  return false;
}

function private combatlocomotionstart(behaviortreeentity) {
  behaviortreeentity.ai.exitstance = behaviortreeentity getblackboardattribute("_stance");
  behaviortreeentity setblackboardattribute("_desired_stance", "stand");
  behaviortreeentity ai::function_fc7bd6c7();
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

function private function_52950d3d(behaviortreeentity) {
  behaviortreeentity.ai.exitstance = undefined;
  behaviortreeentity ai::function_f6060793();
  return true;
}

function function_3b9e6ead(entity, var_cddf6299) {
  if(function_52c3ab28(entity)) {
    entity astsearch(var_cddf6299, "planHumanTurnAnimations");
  }
}

function private function_4937d436(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_desired_stance", "stand");
  behaviortreeentity function_ed7c3705("run_n_gun");
  behaviortreeentity ai::function_fc7bd6c7();
  behaviortreeentity.var_f334caee = 1;
  behaviortreeentity.var_e62db63f = 0;
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

function private function_145df88b(entity) {
  if(is_true(entity.var_f334caee)) {
    if(!entity asmistransitionrunning()) {
      entity.var_d4a1d7ed = gettime() + 2000;
      entity.var_f334caee = undefined;
    }
  }

  if(btapi_combatlocomotionupdate(entity)) {
    function_3b9e6ead(entity, "turn@locomotion");
    return true;
  }

  return false;
}

function private function_2985b5fa(behaviortreeentity) {
  behaviortreeentity ai::function_f6060793();
  behaviortreeentity function_ed7c3705("none");
  behaviortreeentity.var_d4a1d7ed = 0;
  return true;
}

function private function_31a6aada(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_desired_stance", "stand");
  behaviortreeentity function_ed7c3705("non_combat_run");
  behaviortreeentity ai::function_fc7bd6c7();
  return true;
}

function private function_41ae663f(entity) {
  if(btapi_humannoncombatlocomotionupdate(entity)) {
    function_3b9e6ead(entity, "turn@locomotion");
    return true;
  }

  return false;
}

function private function_76ff98aa(behaviortreeentity) {
  behaviortreeentity ai::function_f6060793();
  behaviortreeentity function_ed7c3705("none");
  return true;
}

function private function_e20dbfa4(behaviortreeentity) {
  behaviortreeentity ai::function_fc7bd6c7();
  return true;
}

function private function_888d9ea5(behaviortreeentity) {
  behaviortreeentity ai::function_f6060793();
  return true;
}

function private function_45d8f364(behaviortreeentity) {
  behaviortreeentity ai::function_fc7bd6c7();
  return true;
}

function private function_27c368b1(behaviortreeentity) {
  behaviortreeentity ai::function_f6060793();
  return true;
}

function private prepareformovement(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_stance", "stand");
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
  if(getdvarint(#"enabletacticalarrival", 0) != 1) {
    return false;
  }

  if(!isDefined(behaviortreeentity.node)) {
    return false;
  }

  if(!(behaviortreeentity.node.type == # "cover left")) {
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

function private planhumanarrivalatcover(behaviortreeentity, arrivalanim) {
  behaviortreeentity.ai.var_ee9a2dfd = undefined;

  if(behaviortreeentity ai::get_behavior_attribute("disablearrivals")) {
    return false;
  }

  behaviortreeentity setblackboardattribute("_desired_stance", "stand");

  if(!isDefined(arrivalanim)) {
    return false;
  }

  if(!aiutility::function_c94f0d1(behaviortreeentity)) {
    return false;
  }

  if(isDefined(behaviortreeentity.node) && isDefined(behaviortreeentity.pathgoalpos)) {
    if(!iscovernode(behaviortreeentity.node) || !behaviortreeentity function_4c2fffe6(behaviortreeentity.node)) {
      return false;
    }

    nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);

    if(isDefined(arrivalanim)) {
      splittime = getarrivalsplittime(arrivalanim);
      issplitarrival = splittime > 0 && splittime < 1;
      nodeapproachyaw = behaviortreeentity getnodeoffsetangles(behaviortreeentity.node)[1];
      angle = (0, nodeapproachyaw - getangledelta(arrivalanim), 0);
      forwarddir = anglesToForward(angle);
      rightdir = anglestoright(angle);
      animlength = getanimlength(arrivalanim);
      var_ff177acc = getmovedelta(arrivalanim, 0, (animlength - 0.2) / animlength);

      if(issplitarrival) {
        var_d56d1d2d = getmovedelta(arrivalanim, 0, splittime);
        var_f0dd8bc8 = var_ff177acc - var_d56d1d2d;
        var_fb34812f = vectorscale(forwarddir, var_d56d1d2d[0]);
        var_944b0150 = vectorscale(rightdir, var_d56d1d2d[1]);
        var_85e98eb9 = vectorscale(forwarddir, var_f0dd8bc8[0]);
        var_a358ca3 = vectorscale(rightdir, var_f0dd8bc8[1]);
        var_6e775fcc = nodeoffsetposition - var_85e98eb9 + var_a358ca3;
        coverenterpos = var_6e775fcc - var_fb34812f + var_944b0150;
        var_5fd77fe1 = var_6e775fcc + (0, 0, 8);
        var_c7c8e445 = nodeoffsetposition + (0, 0, 8);
        var_6c21c197 = coverenterpos + (0, 0, 8);

        recordline(var_5fd77fe1, var_c7c8e445, (1, 0.5, 0), "<dev string:x38>");
        record3dtext("<dev string:x46>", var_5fd77fe1, (1, 0.5, 0), "<dev string:x38>");
        recordline(var_6c21c197, var_5fd77fe1, (1, 0.5, 0), "<dev string:x38>");
        record3dtext("<dev string:x5e>", var_6c21c197, (1, 0.5, 0), "<dev string:x38>");

        if(!behaviortreeentity maymovefrompointtopoint(var_5fd77fe1, var_c7c8e445, 1, 1, behaviortreeentity, 0.05)) {
          return false;
        }

        if(!behaviortreeentity maymovefrompointtopoint(var_6c21c197, var_5fd77fe1, 1, 1, behaviortreeentity, 0.05)) {
          return false;
        }
      } else {
        forward = vectorscale(forwarddir, var_ff177acc[0]);
        right = vectorscale(rightdir, var_ff177acc[1]);
        coverenterpos = nodeoffsetposition - forward + right;
        var_c7c8e445 = nodeoffsetposition + (0, 0, 8);
        var_6c21c197 = coverenterpos + (0, 0, 8);

        recordline(var_6c21c197, var_c7c8e445, (1, 0.5, 0), "<dev string:x38>");
        record3dtext("<dev string:x5e>", var_6c21c197, (1, 0.5, 0), "<dev string:x38>");

        if(!behaviortreeentity maymovefrompointtopoint(var_6c21c197, var_c7c8e445, 1, 1, behaviortreeentity, 0.05)) {
          return false;
        }
      }

      if(!checkcoverarrivalconditions(coverenterpos, nodeoffsetposition)) {
        return false;
      }

      if(ispointonnavmesh(coverenterpos, behaviortreeentity)) {
        behaviortreeentity.var_2dc0ed5e = function_15a5703b(#"human", behaviortreeentity function_28e7d252());

        recordcircle(coverenterpos, 2, (1, 0, 0), "<dev string:x74>");

        behaviortreeentity function_a57c34b7(coverenterpos, nodeoffsetposition, "arrival");
        return true;
      }
    }
  }

  return false;
}

function private checkcoverarrivalconditions(coverenterpos, coverpos) {
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
      record3dtext("<dev string:x7e>", coverenterpos, (1, 0, 0), "<dev string:x38>", undefined, 0.4);
      recordcircle(trace[#"position"], 1, (1, 0, 0), "<dev string:x38>");
      record3dtext("<dev string:x98>" + int(abs(trace[#"position"][2] - coverpos[2])), trace[#"position"] + (0, 0, 5), (1, 0, 0), "<dev string:x38>", undefined, 0.4);
      record3dtext("<dev string:xb0>" + 30, trace[#"position"], (1, 0, 0), "<dev string:x38>", undefined, 0.4);
      recordline(coverenterpos, trace[#"position"], (1, 0, 0), "<dev string:x38>");
    }

    return false;
  }

  return true;
}

function private getarrivalsplittime(arrivalanim) {
  if(!isDefined(level.animarrivalsplittimes)) {
    level.animarrivalsplittimes = [];
  }

  if(isDefined(level.animarrivalsplittimes[arrivalanim])) {
    return level.animarrivalsplittimes[arrivalanim];
  }

  bestsplit = -1;

  if(animhasnotetrack(arrivalanim, "corner")) {
    times = getnotetracktimes(arrivalanim, "corner");
    assert(times.size == 1, "<dev string:xde>" + function_9e72a96(arrivalanim) + "<dev string:xf0>" + "<dev string:x10f>" + "<dev string:x119>");
    bestsplit = times[0];
  } else {
    var_1e582813 = function_9e72a96(arrivalanim);
    var_ccd34262 = issubstr(var_1e582813, "<dev string:x128>") || issubstr(var_1e582813, "<dev string:x12e>") || issubstr(var_1e582813, "<dev string:x134>");
    var_ffc4381b = issubstr(var_1e582813, "<dev string:x13a>");

    if(var_ccd34262 && !var_ffc4381b && self.archetype == # "human") {
      assertmsg("<dev string:xde>" + var_1e582813 + "<dev string:x145>" + "<dev string:x10f>" + "<dev string:x154>");
    }
  }

  level.animarrivalsplittimes[arrivalanim] = bestsplit;
  return bestsplit;
}

function private deltarotate(delta, yaw) {
  cosine = cos(yaw);
  sine = sin(yaw);
  return (delta[0] * cosine - delta[1] * sine, delta[1] * cosine + delta[0] * sine, 0);
}

function private function_e7f9cf11() {
  assert(self.archetype == # "human" || self.archetype == # "civilian");
  speed = self function_28e7d252();
  return speed;
}

function private function_3298688b() {
  assert(self.archetype == # "human");
  speed = self function_359fd121();
  return speed;
}

function private function_eb731440() {
  assert(self.archetype == # "human");
  return self.var_55a3f1d3;
}

function private function_631d7179() {
  assert(self.archetype == # "human");

  if(is_true(self.var_dd1cd771)) {
    return self.var_31162969;
  }

  return self.var_55a3f1d3;
}

function private function_cb9c22a2(entity) {
  if(entity haspath() && !isDefined(entity.traversestartnode) && !entity function_3c566724()) {
    if(entity getorientmode("script") != "face enemy strafe") {
      entity.var_6a36b46d = 1;
      entity animmode("zonly_physics");
      entity orientmode("face enemy strafe");
      entity.var_6a36b46d = 0;
    }
  }

  var_55a3f1d3 = entity function_144f21ef();

  if(is_true(entity.ai.var_c978f9a1)) {
    if(-85 < var_55a3f1d3 && var_55a3f1d3 < 35) {
      return false;
    }

    return true;
  }

  if(var_55a3f1d3 < -90 || var_55a3f1d3 > 90) {
    return true;
  }

  return false;
}

function private function_1972c057(entity) {
  if(function_cb9c22a2(entity)) {
    return true;
  }

  return false;
}

function private function_968efd1f(entity) {
  if(!function_cb9c22a2(entity)) {
    return true;
  }

  return false;
}

function private function_c2fb1a1e(entity) {
  if(!level.enablehipflip) {
    return false;
  }

  starttime = entity.ai.var_f92c6536;

  if(!isDefined(starttime)) {
    return false;
  }

  if(gettime() - starttime < 1000) {
    return false;
  }

  return true;
}

function private function_aede5c43(entity) {
  if(entity haspath()) {
    disttogoalsq = distancesquared(entity.pathgoalpos, entity.origin);

    if(disttogoalsq < sqr(150)) {
      return false;
    }
  }

  footstep = entity function_4b57124f(150);

  if(footstep != "left foot") {
    return false;
  }

  return true;
}

function private function_c34dd9f8(entity) {
  if(!function_c2fb1a1e(entity)) {
    return false;
  }

  if(!is_true(entity.ai.var_c978f9a1)) {
    var_55a3f1d3 = entity.ai.var_7979fbb2;

    if(var_55a3f1d3 < -120 && var_55a3f1d3 < entity.ai.var_798e85cd) {
      return function_aede5c43(entity);
    }

    if(var_55a3f1d3 > 55 && var_55a3f1d3 < 90 && var_55a3f1d3 > entity.ai.var_798e85cd) {
      return function_aede5c43(entity);
    }
  }

  return false;
}

function private function_f2c9142(entity) {
  if(!function_c2fb1a1e(entity)) {
    return false;
  }

  if(is_true(entity.ai.var_c978f9a1)) {
    var_55a3f1d3 = entity.ai.var_7979fbb2;

    if(var_55a3f1d3 < 55 && var_55a3f1d3 > 20 && var_55a3f1d3 < entity.ai.var_798e85cd) {
      return function_aede5c43(entity);
    }

    if(var_55a3f1d3 > -135 && var_55a3f1d3 < -105 && var_55a3f1d3 > entity.ai.var_798e85cd) {
      return function_aede5c43(entity);
    }
  }

  return false;
}

function private function_d8a81861(entity) {
  if(!level.enablehipflip) {
    return function_1972c057(entity);
  }

  if(!is_true(entity.ai.var_c978f9a1)) {
    var_55a3f1d3 = entity.ai.var_7979fbb2;

    if(var_55a3f1d3 > 135 && var_55a3f1d3 > entity.ai.var_798e85cd) {
      return true;
    }

    if(var_55a3f1d3 < -135 && var_55a3f1d3 < entity.ai.var_798e85cd) {
      return true;
    }
  }

  return false;
}

function private function_ab6f96b6(entity) {
  if(!level.enablehipflip) {
    return function_968efd1f(entity);
  }

  if(is_true(entity.ai.var_c978f9a1)) {
    var_55a3f1d3 = entity.ai.var_7979fbb2;

    if(var_55a3f1d3 > -60 && var_55a3f1d3 < 45) {
      return true;
    }
  }

  return false;
}

function function_7ba867a8(entity) {
  var_422d3ed4 = entity function_fe54a83e();

  if(var_422d3ed4 >= 45 && var_422d3ed4 <= 315) {
    return 1;
  }

  entity.var_3b77553e = -1;
  return 0;
}

function function_52c3ab28(entity) {
  if(!function_7ba867a8(entity)) {
    return false;
  } else if(!isDefined(entity.var_3b77553e) || entity.var_3b77553e <= 0) {
    return true;
  } else if(!isDefined(entity.var_7b1f015a)) {
    return true;
  } else if(distance2dsquared(entity.var_7b1f015a.pos, entity.var_14b548c5) > sqr(4)) {
    return true;
  } else if(abs(entity.var_7b1f015a.angle - entity.var_871c9e86) > 1) {
    return true;
  } else if(entity.var_7b1f015a.var_568d90d2 != function_15a5703b(#"human", entity function_359fd121())) {
    return true;
  }

  return false;
}

function function_b1092561(entity) {
  if((isDefined(entity.var_3b77553e) ? entity.var_3b77553e : 0) > 0 && isDefined(entity.var_7b1f015a.animation) && isDefined(entity.var_14b548c5)) {
    splittime = 0.5;

    if(animhasnotetrack(entity.var_7b1f015a.animation, "corner")) {
      times = getnotetracktimes(entity.var_7b1f015a.animation, "corner");
      assert(times.size == 1, "<dev string:x183>" + function_9e72a96(entity.var_7b1f015a.animation) + "<dev string:xf0>" + "<dev string:x10f>" + "<dev string:x119>");
      splittime = times[0];
    }

    localdeltahalfvector = getmovedelta(entity.var_7b1f015a.animation, 0, splittime);

    if(distance2dsquared(entity.origin, entity.var_14b548c5) <= lengthsquared(localdeltahalfvector)) {
      return true;
    }
  }

  return false;
}

function private function_80c579d8(entity) {
  return self.var_ca796dd1;
}

function function_2fa3d847() {
  enemy = self.enemy;

  if(!isDefined(enemy)) {
    return self.var_e62db63f;
  }

  var_3e0a4a57 = self function_584873ef();
  var_7c8caf6 = var_3e0a4a57 - self.var_e62db63f;
  var_b3aae738 = 1;

  if(var_7c8caf6 < 0) {
    var_b3aae738 = -1;
  }

  var_7c8caf6 = min(abs(var_7c8caf6), self.var_1f35a3cf);
  var_d4699b3f = self.var_e62db63f + var_b3aae738 * var_7c8caf6;
  self.var_e62db63f = var_d4699b3f;

  recordenttext("<dev string:x192>" + var_d4699b3f, self, (1, 0, 0), "<dev string:x38>");

  return var_d4699b3f;
}

function private function_d68785cf(entity) {
  if(btapi_shouldarriveexposed(entity)) {
    var_55a3f1d3 = entity function_144f21ef();

    if(abs(var_55a3f1d3) < 3) {
      return true;
    }
  }

  return false;
}