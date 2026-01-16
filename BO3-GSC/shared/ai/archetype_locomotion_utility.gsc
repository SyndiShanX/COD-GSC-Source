/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_locomotion_utility.gsc
******************************************************/

#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_state_machine;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\math_shared;
#namespace aiutility;

function autoexec registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionBehaviorCondition", & locomotionbehaviorcondition);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionBehaviorCondition", & locomotionbehaviorcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("nonCombatLocomotionCondition", & noncombatlocomotioncondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("setDesiredStanceForMovement", & setdesiredstanceformovement);
  behaviortreenetworkutility::registerbehaviortreescriptapi("clearPathFromScript", & clearpathfromscript);
  behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldPatrol", & locomotionshouldpatrol);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldPatrol", & locomotionshouldpatrol);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldTacticalWalk", & shouldtacticalwalk);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalk", & shouldtacticalwalk);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAdjustStanceAtTacticalWalk", & shouldadjuststanceattacticalwalk);
  behaviortreenetworkutility::registerbehaviortreescriptapi("adjustStanceToFaceEnemyInitialize", & adjuststancetofaceenemyinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("adjustStanceToFaceEnemyTerminate", & adjuststancetofaceenemyterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("tacticalWalkActionStart", & tacticalwalkactionstart);
  behaviorstatemachine::registerbsmscriptapiinternal("tacticalWalkActionStart", & tacticalwalkactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("clearArrivalPos", & cleararrivalpos);
  behaviorstatemachine::registerbsmscriptapiinternal("clearArrivalPos", & cleararrivalpos);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStartArrival", & shouldstartarrivalcondition);
  behaviorstatemachine::registerbsmscriptapiinternal("shouldStartArrival", & shouldstartarrivalcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldTraverse", & locomotionshouldtraverse);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldTraverse", & locomotionshouldtraverse);
  behaviortreenetworkutility::registerbehaviortreeaction("traverseActionStart", & traverseactionstart, undefined, undefined);
  behaviorstatemachine::registerbsmscriptapiinternal("traverseSetup", & traversesetup);
  behaviortreenetworkutility::registerbehaviortreescriptapi("disableRepath", & disablerepath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("enableRepath", & enablerepath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("canJuke", & canjuke);
  behaviortreenetworkutility::registerbehaviortreescriptapi("chooseJukeDirection", & choosejukedirection);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionPainBehaviorCondition", & locomotionpainbehaviorcondition);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionIsOnStairs", & locomotionisonstairs);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldLoopOnStairs", & locomotionshouldlooponstairs);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldSkipStairs", & locomotionshouldskipstairs);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionStairsStart", & locomotionstairsstart);
  behaviorstatemachine::registerbsmscriptapiinternal("locomotionStairsEnd", & locomotionstairsend);
  behaviortreenetworkutility::registerbehaviortreescriptapi("delayMovement", & delaymovement);
  behaviorstatemachine::registerbsmscriptapiinternal("delayMovement", & delaymovement);
}

function private locomotionisonstairs(behaviortreeentity) {
  startnode = behaviortreeentity.traversestartnode;
  if(isdefined(startnode) && behaviortreeentity shouldstarttraversal()) {
    if(isdefined(startnode.animscript) && issubstr(tolower(startnode.animscript), "stairs")) {
      return true;
    }
  }
  return false;
}

function private locomotionshouldskipstairs(behaviortreeentity) {
  assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
  numtotalsteps = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_num_total_steps");
  stepssofar = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_num_steps");
  direction = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_direction");
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

function private locomotionshouldlooponstairs(behaviortreeentity) {
  assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
  numtotalsteps = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_num_total_steps");
  stepssofar = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_num_steps");
  exittype = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_exit_type");
  direction = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_direction");
  numoutsteps = 2;
  if(direction == "staircase_up") {
    switch (exittype) {
      case "staircase_up_exit_l_3_stairs":
      case "staircase_up_exit_r_3_stairs": {
        numoutsteps = 3;
        break;
      }
      case "staircase_up_exit_l_4_stairs":
      case "staircase_up_exit_r_4_stairs": {
        numoutsteps = 4;
        break;
      }
    }
  }
  if(stepssofar >= (numtotalsteps - numoutsteps)) {
    behaviortreeentity setstairsexittransform();
    return false;
  }
  return true;
}

function private locomotionstairsstart(behaviortreeentity) {
  startnode = behaviortreeentity.traversestartnode;
  endnode = behaviortreeentity.traverseendnode;
  assert(isdefined(startnode) && isdefined(endnode));
  behaviortreeentity._stairsstartnode = startnode;
  behaviortreeentity._stairsendnode = endnode;
  if(startnode.type == "Begin") {
    direction = "staircase_down";
  } else {
    direction = "staircase_up";
  }
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_type", behaviortreeentity._stairsstartnode.animscript);
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_state", "staircase_start");
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_direction", direction);
  numtotalsteps = undefined;
  if(isdefined(startnode.script_int)) {
    numtotalsteps = int(endnode.script_int);
  } else if(isdefined(endnode.script_int)) {
    numtotalsteps = int(endnode.script_int);
  }
  assert(isdefined(numtotalsteps) && isint(numtotalsteps) && numtotalsteps > 0);
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_num_total_steps", numtotalsteps);
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_num_steps", 0);
  exittype = undefined;
  if(direction == "staircase_up") {
    switch (int(behaviortreeentity._stairsstartnode.script_int) % 4) {
      case 0: {
        exittype = "staircase_up_exit_r_3_stairs";
        break;
      }
      case 1: {
        exittype = "staircase_up_exit_r_4_stairs";
        break;
      }
      case 2: {
        exittype = "staircase_up_exit_l_3_stairs";
        break;
      }
      case 3: {
        exittype = "staircase_up_exit_l_4_stairs";
        break;
      }
    }
  } else {
    switch (int(behaviortreeentity._stairsstartnode.script_int) % 2) {
      case 0: {
        exittype = "staircase_down_exit_l_2_stairs";
        break;
      }
      case 1: {
        exittype = "staircase_down_exit_r_2_stairs";
        break;
      }
    }
  }
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_exit_type", exittype);
  return true;
}

function private locomotionstairloopstart(behaviortreeentity) {
  assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_state", "staircase_loop");
}

function private locomotionstairsend(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_state", undefined);
  blackboard::setblackboardattribute(behaviortreeentity, "_staircase_direction", undefined);
}

function private locomotionpainbehaviorcondition(entity) {
  return entity haspath() && entity hasvalidinterrupt("pain");
}

function clearpathfromscript(behaviortreeentity) {
  behaviortreeentity clearpath();
}

function private noncombatlocomotioncondition(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }
  if(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
    return true;
  }
  if(isdefined(behaviortreeentity.enemy)) {
    return false;
  }
  return true;
}

function private combatlocomotioncondition(behaviortreeentity) {
  if(!behaviortreeentity haspath()) {
    return false;
  }
  if(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
    return false;
  }
  if(isdefined(behaviortreeentity.enemy)) {
    return true;
  }
  return false;
}

function locomotionbehaviorcondition(behaviortreeentity) {
  return behaviortreeentity haspath();
}

function private setdesiredstanceformovement(behaviortreeentity) {
  if(blackboard::getblackboardattribute(behaviortreeentity, "_stance") != "stand") {
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
  }
}

function private locomotionshouldtraverse(behaviortreeentity) {
  startnode = behaviortreeentity.traversestartnode;
  if(isdefined(startnode) && behaviortreeentity shouldstarttraversal()) {
    return true;
  }
  return false;
}

function traversesetup(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
  blackboard::setblackboardattribute(behaviortreeentity, "_traversal_type", behaviortreeentity.traversestartnode.animscript);
  return true;
}

function traverseactionstart(behaviortreeentity, asmstatename) {
  traversesetup(behaviortreeentity);
  animationresults = behaviortreeentity astsearch(istring(asmstatename));
  assert(isdefined(animationresults[""]), ((((behaviortreeentity.archetype + "") + behaviortreeentity.traversestartnode.animscript) + "") + behaviortreeentity.traversestartnode.origin) + "");
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function private disablerepath(entity) {
  entity.disablerepath = 1;
}

function private enablerepath(entity) {
  entity.disablerepath = 0;
}

function shouldstartarrivalcondition(behaviortreeentity) {
  if(behaviortreeentity shouldstartarrival()) {
    return true;
  }
  return false;
}

function cleararrivalpos(behaviortreeentity) {
  if(!isdefined(behaviortreeentity.isarrivalpending) || (isdefined(behaviortreeentity.isarrivalpending) && behaviortreeentity.isarrivalpending)) {
    self clearuseposition();
  }
  return true;
}

function delaymovement(entity) {
  entity pathmode("move delayed", 0, randomfloatrange(1, 2));
  return true;
}

function private shouldadjuststanceattacticalwalk(behaviortreeentity) {
  stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  if(stance != "stand") {
    return true;
  }
  return false;
}

function private adjuststancetofaceenemyinitialize(behaviortreeentity) {
  behaviortreeentity.newenemyreaction = 0;
  blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
  behaviortreeentity orientmode("face enemy");
  return true;
}

function private adjuststancetofaceenemyterminate(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
}

function private tacticalwalkactionstart(behaviortreeentity) {
  cleararrivalpos(behaviortreeentity);
  resetcoverparameters(behaviortreeentity);
  setcanbeflanked(behaviortreeentity, 0);
  blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
  behaviortreeentity orientmode("face enemy");
  return true;
}

function private validjukedirection(entity, entitynavmeshposition, forwardoffset, lateraloffset) {
  jukenavmeshthreshold = 6;
  forwardposition = (entity.origin + lateraloffset) + forwardoffset;
  backwardposition = (entity.origin + lateraloffset) - forwardoffset;
  forwardpositionvalid = ispointonnavmesh(forwardposition, entity) && tracepassedonnavmesh(entity.origin, forwardposition);
  backwardpositionvalid = ispointonnavmesh(backwardposition, entity) && tracepassedonnavmesh(entity.origin, backwardposition);
  if(!isdefined(entity.ignorebackwardposition)) {
    return forwardpositionvalid && backwardpositionvalid;
  }
  return forwardpositionvalid;
}

function calculatejukedirection(entity, entityradius, jukedistance) {
  jukenavmeshthreshold = 6;
  defaultdirection = "forward";
  if(isdefined(entity.defaultjukedirection)) {
    defaultdirection = entity.defaultjukedirection;
  }
  if(isdefined(entity.enemy)) {
    navmeshposition = getclosestpointonnavmesh(entity.origin, jukenavmeshthreshold);
    if(!isvec(navmeshposition)) {
      return defaultdirection;
    }
    vectortoenemy = entity.enemy.origin - entity.origin;
    vectortoenemyangles = vectortoangles(vectortoenemy);
    forwarddistance = anglestoforward(vectortoenemyangles) * entityradius;
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
      }
      if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance)) {
        return "right";
      }
    } else {
      if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance)) {
        return "right";
      }
      if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1)) {
        return "left";
      }
    }
  }
  return defaultdirection;
}

function private calculatedefaultjukedirection(entity) {
  jukedistance = 30;
  entityradius = 15;
  if(isdefined(entity.jukedistance)) {
    jukedistance = entity.jukedistance;
  }
  if(isdefined(entity.entityradius)) {
    entityradius = entity.entityradius;
  }
  return calculatejukedirection(entity, entityradius, jukedistance);
}

function canjuke(entity) {
  if(isdefined(self.is_disabled) && self.is_disabled) {
    return 0;
  }
  if(isdefined(entity.jukemaxdistance) && isdefined(entity.enemy)) {
    maxdistsquared = entity.jukemaxdistance * entity.jukemaxdistance;
    if(distance2dsquared(entity.origin, entity.enemy.origin) > maxdistsquared) {
      return 0;
    }
  }
  jukedirection = calculatedefaultjukedirection(entity);
  return jukedirection != "forward";
}

function choosejukedirection(entity) {
  jukedirection = calculatedefaultjukedirection(entity);
  blackboard::setblackboardattribute(entity, "_juke_direction", jukedirection);
}