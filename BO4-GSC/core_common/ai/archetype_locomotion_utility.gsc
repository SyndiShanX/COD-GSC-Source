/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_locomotion_utility.gsc
***********************************************************/

#include scripts\core_common\ai\archetype_cover_utility;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\math_shared;

#namespace aiutility;

autoexec registerbehaviorscriptfunctions() {
  assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_locomotionbehaviorcondition", &btapi_locomotionbehaviorcondition);
  assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_locomotionbehaviorcondition", &btapi_locomotionbehaviorcondition);
  assert(isscriptfunctionptr(&noncombatlocomotioncondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"noncombatlocomotioncondition", &noncombatlocomotioncondition);
  assert(isscriptfunctionptr(&setdesiredstanceformovement));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"setdesiredstanceformovement", &setdesiredstanceformovement);
  assert(isscriptfunctionptr(&clearpathfromscript));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"clearpathfromscript", &clearpathfromscript);
  assert(isscriptfunctionptr(&locomotionshouldpatrol));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldpatrol", &locomotionshouldpatrol);
  assert(isscriptfunctionptr(&locomotionshouldpatrol));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldpatrol", &locomotionshouldpatrol);
  assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
  behaviortreenetworkutility::registerbehaviortreescriptapi("btApi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
  assert(isscriptfunctionptr(&shouldtacticalwalk));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldtacticalwalk", &shouldtacticalwalk);
  assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
  behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
  assert(isscriptfunctionptr(&shouldtacticalwalk));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldtacticalwalk", &shouldtacticalwalk);
  assert(isscriptfunctionptr(&shouldadjuststanceattacticalwalk));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldadjuststanceattacticalwalk", &shouldadjuststanceattacticalwalk);
  assert(isscriptfunctionptr(&adjuststancetofaceenemyinitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"adjuststancetofaceenemyinitialize", &adjuststancetofaceenemyinitialize);
  assert(isscriptfunctionptr(&adjuststancetofaceenemyterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"adjuststancetofaceenemyterminate", &adjuststancetofaceenemyterminate);
  assert(isscriptfunctionptr(&tacticalwalkactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"tacticalwalkactionstart", &tacticalwalkactionstart);
  assert(isscriptfunctionptr(&tacticalwalkactionstart));
  behaviorstatemachine::registerbsmscriptapiinternal(#"tacticalwalkactionstart", &tacticalwalkactionstart);
  assert(isscriptfunctionptr(&cleararrivalpos));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleararrivalpos", &cleararrivalpos);
  assert(isscriptfunctionptr(&cleararrivalpos));
  behaviorstatemachine::registerbsmscriptapiinternal(#"cleararrivalpos", &cleararrivalpos);
  assert(isscriptfunctionptr(&shouldstartarrivalcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstartarrival", &shouldstartarrivalcondition);
  assert(isscriptfunctionptr(&shouldstartarrivalcondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstartarrival", &shouldstartarrivalcondition);
  assert(isscriptfunctionptr(&locomotionshouldtraverse));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldtraverse", &locomotionshouldtraverse);
  assert(isscriptfunctionptr(&locomotionshouldtraverse));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldtraverse", &locomotionshouldtraverse);
  assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldparametrictraverse", &locomotionshouldparametrictraverse);
  assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldparametrictraverse", &locomotionshouldparametrictraverse);
  assert(isscriptfunctionptr(&function_5ef5b35a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7234c48b18665dc6", &function_5ef5b35a);
  assert(isscriptfunctionptr(&function_5ef5b35a));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7234c48b18665dc6", &function_5ef5b35a);
  assert(isscriptfunctionptr(&function_8a8c5d44));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4c93e133d3b1accc", &function_8a8c5d44);
  assert(isscriptfunctionptr(&function_8a8c5d44));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4c93e133d3b1accc", &function_8a8c5d44);
  assert(isscriptfunctionptr(&traverseactionstart));
  behaviorstatemachine::registerbsmscriptapiinternal(#"traverseactionstart", &traverseactionstart);
  assert(isscriptfunctionptr(&wpn_debug_bot_joinleave));
  behaviorstatemachine::registerbsmscriptapiinternal(#"traverseactionterminate", &wpn_debug_bot_joinleave);
  assert(isscriptfunctionptr(&traverseactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"traverseactionstart", &traverseactionstart);
  assert(isscriptfunctionptr(&wpn_debug_bot_joinleave));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"traverseactionterminate", &wpn_debug_bot_joinleave);
  assert(!isDefined(&traverseactionstart) || isscriptfunctionptr(&traverseactionstart));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&wpn_debug_bot_joinleave) || isscriptfunctionptr(&wpn_debug_bot_joinleave));
  behaviortreenetworkutility::registerbehaviortreeaction(#"traverseactionstart", &traverseactionstart, undefined, &wpn_debug_bot_joinleave);
  assert(isscriptfunctionptr(&traversesetup));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"traversesetup", &traversesetup);
  assert(isscriptfunctionptr(&traversesetup));
  behaviorstatemachine::registerbsmscriptapiinternal(#"traversesetup", &traversesetup);
  assert(isscriptfunctionptr(&disablerepath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"disablerepath", &disablerepath);
  assert(isscriptfunctionptr(&enablerepath));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"enablerepath", &enablerepath);
  assert(isscriptfunctionptr(&canjuke));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"canjuke", &canjuke);
  assert(isscriptfunctionptr(&choosejukedirection));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"choosejukedirection", &choosejukedirection);
  assert(isscriptfunctionptr(&locomotionpainbehaviorcondition));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionpainbehaviorcondition", &locomotionpainbehaviorcondition);
  assert(isscriptfunctionptr(&locomotionisonstairs));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionisonstairs", &locomotionisonstairs);
  assert(isscriptfunctionptr(&locomotionshouldlooponstairs));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldlooponstairs", &locomotionshouldlooponstairs);
  assert(isscriptfunctionptr(&locomotionshouldskipstairs));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldskipstairs", &locomotionshouldskipstairs);
  assert(isscriptfunctionptr(&locomotionstairsstart));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionstairsstart", &locomotionstairsstart);
  assert(isscriptfunctionptr(&locomotionstairsend));
  behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionstairsend", &locomotionstairsend);
  assert(isscriptfunctionptr(&delaymovement));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"delaymovement", &delaymovement);
  assert(isscriptfunctionptr(&delaymovement));
  behaviorstatemachine::registerbsmscriptapiinternal(#"delaymovement", &delaymovement);
}

private locomotionisonstairs(behaviortreeentity) {
  startnode = behaviortreeentity.traversestartnode;

  if(isDefined(startnode) && behaviortreeentity shouldstarttraversal()) {
    if(isDefined(startnode.animscript) && issubstr(tolower(startnode.animscript), "stairs")) {
      return true;
    }
  }

  return false;
}

private locomotionshouldskipstairs(behaviortreeentity) {
  assert(isDefined(behaviortreeentity._stairsstartnode) && isDefined(behaviortreeentity._stairsendnode));
  numtotalsteps = behaviortreeentity getblackboardattribute("_staircase_num_total_steps");
  stepssofar = behaviortreeentity getblackboardattribute("_staircase_num_steps");
  direction = behaviortreeentity getblackboardattribute("_staircase_direction");

  if(direction != "staircase_up") {
    return false;
  }

  numoutsteps = 2;
  totalstepswithoutout = numtotalsteps - numoutsteps;

  if(stepssofar >= totalstepswithoutout) {
    return false;
  }

  remainingsteps = totalstepswithoutout - stepssofar;

  if(remainingsteps >= 3 || remainingsteps >= 6 || remainingsteps >= 8) {
    return true;
  }

  return false;
}

private locomotionshouldlooponstairs(behaviortreeentity) {
  assert(isDefined(behaviortreeentity._stairsstartnode) && isDefined(behaviortreeentity._stairsendnode));
  numtotalsteps = behaviortreeentity getblackboardattribute("_staircase_num_total_steps");
  stepssofar = behaviortreeentity getblackboardattribute("_staircase_num_steps");
  exittype = behaviortreeentity getblackboardattribute("_staircase_exit_type");
  direction = behaviortreeentity getblackboardattribute("_staircase_direction");
  numoutsteps = 2;

  if(direction == "staircase_up") {
    switch (exittype) {
      case #"staircase_up_exit_l_3_stairs":
      case #"staircase_up_exit_r_3_stairs":
        numoutsteps = 3;
        break;
      case #"staircase_up_exit_r_4_stairs":
      case #"staircase_up_exit_l_4_stairs":
        numoutsteps = 4;
        break;
    }
  }

  if(stepssofar >= numtotalsteps - numoutsteps) {
    behaviortreeentity setstairsexittransform();
    return false;
  }

  return true;
}

private locomotionstairsstart(behaviortreeentity) {
  startnode = behaviortreeentity.traversestartnode;
  endnode = behaviortreeentity.traverseendnode;
  assert(isDefined(startnode) && isDefined(endnode));
  behaviortreeentity._stairsstartnode = startnode;
  behaviortreeentity._stairsendnode = endnode;

  if(startnode.type == #"begin") {
    direction = "staircase_down";
  } else {
    direction = "staircase_up";
  }

  behaviortreeentity setblackboardattribute("_staircase_type", behaviortreeentity._stairsstartnode.animscript);
  behaviortreeentity setblackboardattribute("_staircase_state", "staircase_start");
  behaviortreeentity setblackboardattribute("_staircase_direction", direction);
  numtotalsteps = undefined;

  if(isDefined(startnode.script_int)) {
    numtotalsteps = int(endnode.script_int);
  } else if(isDefined(endnode.script_int)) {
    numtotalsteps = int(endnode.script_int);
  }

  assert(isDefined(numtotalsteps) && isint(numtotalsteps) && numtotalsteps > 0);
  behaviortreeentity setblackboardattribute("_staircase_num_total_steps", numtotalsteps);
  behaviortreeentity setblackboardattribute("_staircase_num_steps", 0);
  exittype = undefined;

  if(direction == "staircase_up") {
    switch (int(behaviortreeentity._stairsstartnode.script_int) % 4) {
      case 0:
        exittype = "staircase_up_exit_r_3_stairs";
        break;
      case 1:
        exittype = "staircase_up_exit_r_4_stairs";
        break;
      case 2:
        exittype = "staircase_up_exit_l_3_stairs";
        break;
      case 3:
        exittype = "staircase_up_exit_l_4_stairs";
        break;
    }
  } else {
    switch (int(behaviortreeentity._stairsstartnode.script_int) % 2) {
      case 0:
        exittype = "staircase_down_exit_l_2_stairs";
        break;
      case 1:
        exittype = "staircase_down_exit_r_2_stairs";
        break;
    }
  }

  behaviortreeentity setblackboardattribute("_staircase_exit_type", exittype);
  return true;
}

private locomotionstairloopstart(behaviortreeentity) {
  assert(isDefined(behaviortreeentity._stairsstartnode) && isDefined(behaviortreeentity._stairsendnode));
  behaviortreeentity setblackboardattribute("_staircase_state", "staircase_loop");
}

private locomotionstairsend(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_staircase_state", undefined);
  behaviortreeentity setblackboardattribute("_staircase_direction", undefined);
}

private locomotionpainbehaviorcondition(entity) {
  return entity haspath() && entity hasvalidinterrupt("pain");
}

clearpathfromscript(behaviortreeentity) {
  behaviortreeentity clearpath();
}

private noncombatlocomotioncondition(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }

  if(isDefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
    return true;
  }

  if(isDefined(behaviortreeentity.enemy)) {
    return false;
  }

  return true;
}

private combatlocomotioncondition(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }

  if(isDefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
    return false;
  }

  if(isDefined(behaviortreeentity.enemy)) {
    return true;
  }

  return false;
}

private setdesiredstanceformovement(behaviortreeentity) {
  if(behaviortreeentity getblackboardattribute("_stance") != "stand") {
    behaviortreeentity setblackboardattribute("_desired_stance", "stand");
  }
}

private locomotionshouldtraverse(behaviortreeentity) {
  startnode = behaviortreeentity.traversestartnode;

  if(isDefined(startnode) && behaviortreeentity shouldstarttraversal()) {
    record3dtext("<dev string:x38>", self.origin, (1, 0, 0), "<dev string:x4d>");

    return true;
  }

  return false;
}

private locomotionshouldparametrictraverse(entity) {
  startnode = entity.traversestartnode;

  if(isDefined(startnode) && entity shouldstarttraversal()) {
    traversaltype = entity getblackboardattribute("_parametric_traversal_type");

    record3dtext("<dev string:x38>", self.origin, (1, 0, 0), "<dev string:x4d>");

    return (traversaltype != "unknown_traversal");
  }

  return false;
}

private function_5ef5b35a(behaviortreeentity) {
  startnode = behaviortreeentity.traversestartnode;

  if(isDefined(startnode) && behaviortreeentity function_420d1e6b()) {
    record3dtext("<dev string:x56>", self.origin, (1, 0, 0), "<dev string:x4d>");

    return true;
  }

  return false;
}

private function_8a8c5d44(entity) {
  startnode = entity.traversestartnode;

  if(isDefined(startnode) && entity function_420d1e6b()) {
    traversaltype = entity getblackboardattribute("_parametric_traversal_type");

    record3dtext("<dev string:x56>", self.origin, (1, 0, 0), "<dev string:x4d>");

    return (traversaltype != "unknown_traversal");
  }

  return false;
}

private traversesetup(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_stance", "stand");
  behaviortreeentity setblackboardattribute("_traversal_type", behaviortreeentity.traversestartnode.animscript);
  return true;
}

traverseactionstart(behaviortreeentity, asmstatename) {
  traversesetup(behaviortreeentity);

  if(!isDefined(asmstatename) && isDefined(self.ai.var_2b570fa6)) {
    asmstatename = self.ai.var_2b570fa6;
  }

  behaviortreeentity.var_efe0efe7 = behaviortreeentity function_b7350442();
  behaviortreeentity.var_846d7e33 = behaviortreeentity function_f650e40b();
  behaviortreeentity allowpitchangle(0);
  behaviortreeentity clearpitchorient();

  result = behaviortreeentity astsearch(asmstatename);

  if(!isDefined(result[#"animation"])) {
    record3dtext("<dev string:x6e>", self.origin + (0, 0, 16), (1, 0, 0), "<dev string:x4d>");
  } else {
    record3dtext("<dev string:xa6>" + (ishash(result[#"animation"]) ? function_9e72a96(result[#"animation"]) : result[#"animation"]), self.origin + (0, 0, 16), (1, 0, 0), "<dev string:x4d>");
  }

  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

wpn_debug_bot_joinleave(behaviortreeentity, asmstatename) {
  behaviortreeentity allowpitchangle(isDefined(behaviortreeentity.var_efe0efe7) && behaviortreeentity.var_efe0efe7);

  if(isDefined(behaviortreeentity.var_846d7e33) && behaviortreeentity.var_846d7e33) {
    behaviortreeentity setpitchorient();
  }

  behaviortreeentity.var_efe0efe7 = undefined;
  behaviortreeentity.var_846d7e33 = undefined;
  return 4;
}

private disablerepath(entity) {
  entity.disablerepath = 1;
}

private enablerepath(entity) {
  entity.disablerepath = 0;
}

shouldstartarrivalcondition(behaviortreeentity) {
  if(behaviortreeentity shouldstartarrival()) {
    return true;
  }

  return false;
}

cleararrivalpos(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.isarrivalpending) || isDefined(behaviortreeentity.isarrivalpending) && behaviortreeentity.isarrivalpending) {
    self function_d4c687c9();
  }

  return true;
}

delaymovement(entity) {
  entity pathmode("move delayed", 0, randomfloatrange(1, 2));
  return true;
}

private shouldadjuststanceattacticalwalk(behaviortreeentity) {
  stance = behaviortreeentity getblackboardattribute("_stance");

  if(stance != "stand") {
    return true;
  }

  return false;
}

private adjuststancetofaceenemyinitialize(behaviortreeentity) {
  behaviortreeentity.newenemyreaction = 0;
  behaviortreeentity setblackboardattribute("_desired_stance", "stand");
  behaviortreeentity orientmode("face enemy");
  return true;
}

private adjuststancetofaceenemyterminate(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_stance", "stand");
}

private tacticalwalkactionstart(behaviortreeentity) {
  cleararrivalpos(behaviortreeentity);
  resetcoverparameters(behaviortreeentity);
  setcanbeflanked(behaviortreeentity, 0);
  behaviortreeentity setblackboardattribute("_stance", "stand");
  behaviortreeentity orientmode("face enemy");
  return true;
}

private validjukedirection(entity, entitynavmeshposition, forwardoffset, lateraloffset) {
  jukenavmeshthreshold = 6;
  forwardposition = entity.origin + lateraloffset + forwardoffset;
  backwardposition = entity.origin + lateraloffset - forwardoffset;
  forwardpositionvalid = ispointonnavmesh(forwardposition, entity) && tracepassedonnavmesh(entity.origin, forwardposition);
  backwardpositionvalid = ispointonnavmesh(backwardposition, entity) && tracepassedonnavmesh(entity.origin, backwardposition);

  if(!isDefined(entity.ignorebackwardposition)) {
    return (forwardpositionvalid && backwardpositionvalid);
  } else {
    return forwardpositionvalid;
  }

  return 0;
}

calculatejukedirection(entity, entityradius, jukedistance) {
  jukenavmeshthreshold = 30;
  defaultdirection = "forward";

  if(isDefined(entity.defaultjukedirection)) {
    defaultdirection = entity.defaultjukedirection;
  }

  if(isDefined(entity.enemy)) {
    navmeshposition = getclosestpointonnavmesh(entity.origin, jukenavmeshthreshold);

    if(!isvec(navmeshposition)) {
      return defaultdirection;
    }

    vectortoenemy = entity.enemy.origin - entity.origin;
    vectortoenemyangles = vectortoangles(vectortoenemy);
    forwarddistance = anglesToForward(vectortoenemyangles) * entityradius;
    rightjukedistance = anglestoright(vectortoenemyangles) * jukedistance;
    preferleft = undefined;

    if(entity haspath()) {
      rightposition = entity.origin + rightjukedistance;
      leftposition = entity.origin - rightjukedistance;
      preferleft = distancesquared(leftposition, entity.pathgoalpos) <= distancesquared(rightposition, entity.pathgoalpos);
    } else {
      preferleft = math::cointoss();
    }

    if(preferleft) {
      if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1)) {
        return "left";
      } else if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance)) {
        return "right";
      }
    } else if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance)) {
      return "right";
    } else if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1)) {
      return "left";
    }
  }

  return defaultdirection;
}

private calculatedefaultjukedirection(entity) {
  jukedistance = 30;
  entityradius = 15;

  if(isDefined(entity.jukedistance)) {
    jukedistance = entity.jukedistance;
  }

  if(isDefined(entity.entityradius)) {
    entityradius = entity.entityradius;
  }

  return calculatejukedirection(entity, entityradius, jukedistance);
}

canjuke(entity) {
  if(isDefined(entity.jukemaxdistance) && isDefined(entity.enemy)) {
    maxdistsquared = entity.jukemaxdistance * entity.jukemaxdistance;

    if(distance2dsquared(entity.origin, entity.enemy.origin) > maxdistsquared) {
      return false;
    }
  }

  jukedirection = calculatedefaultjukedirection(entity);
  return jukedirection != "forward";
}

choosejukedirection(entity) {
  jukedirection = calculatedefaultjukedirection(entity);
  entity setblackboardattribute("_juke_direction", jukedirection);
}