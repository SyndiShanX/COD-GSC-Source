/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_robot.gsc
*************************************************/

#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_locomotion_utility;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_robot_interface;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\ai_squads;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_state_machine;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\destructible_character;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_raps;
#namespace archetype_robot;

function autoexec __init__sytem__() {
  system::register("robot", &__init__, undefined, undefined);
}

function __init__() {
  spawner::add_archetype_spawn_function("robot", &robotsoldierbehavior::archetyperobotblackboardinit);
  spawner::add_archetype_spawn_function("robot", &robotsoldierserverutils::robotsoldierspawnsetup);
  if(ai::shouldregisterclientfieldforarchetype("robot")) {
    clientfield::register("actor", "robot_mind_control", 1, 2, "int");
    clientfield::register("actor", "robot_mind_control_explosion", 1, 1, "int");
    clientfield::register("actor", "robot_lights", 1, 3, "int");
    clientfield::register("actor", "robot_EMP", 1, 1, "int");
  }
  robotinterface::registerrobotinterfaceattributes();
  robotsoldierbehavior::registerbehaviorscriptfunctions();
}

#namespace robotsoldierbehavior;

function registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreeaction("robotStepIntoAction", &stepintoinitialize, undefined, &stepintoterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("robotStepOutAction", &stepoutinitialize, undefined, &stepoutterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("robotTakeOverAction", &takeoverinitialize, undefined, &takeoverterminate);
  behaviortreenetworkutility::registerbehaviortreeaction("robotEmpIdleAction", &robotempidleinitialize, &robotempidleupdate, &robotempidleterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotBecomeCrawler", &robotbecomecrawler);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotDropStartingWeapon", &robotdropstartingweapon);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotDontTakeCover", &robotdonttakecover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCoverOverInitialize", &robotcoveroverinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCoverOverTerminate", &robotcoveroverterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotExplode", &robotexplode);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotExplodeTerminate", &robotexplodeterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotDeployMiniRaps", &robotdeployminiraps);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotMoveToPlayer", &movetoplayerupdate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotStartSprint", &robotstartsprint);
  behaviorstatemachine::registerbsmscriptapiinternal("robotStartSprint", &robotstartsprint);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotStartSuperSprint", &robotstartsupersprint);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotTacticalWalkActionStart", &robottacticalwalkactionstart);
  behaviorstatemachine::registerbsmscriptapiinternal("robotTacticalWalkActionStart", &robottacticalwalkactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotDie", &robotdie);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCleanupChargeMeleeAttack", &robotcleanupchargemeleeattack);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsMoving", &robotismoving);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotAbleToShoot", &robotabletoshootcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCrawlerCanShootEnemy", &robotcrawlercanshootenemy);
  behaviortreenetworkutility::registerbehaviortreescriptapi("canMoveToEnemy", &canmovetoenemycondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("canMoveCloseToEnemy", &canmoveclosetoenemycondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("hasMiniRaps", &hasminiraps);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsAtCover", &robotisatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldTacticalWalk", &robotshouldtacticalwalk);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotHasCloseEnemyToMelee", &robothascloseenemytomelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotHasEnemyToMelee", &robothasenemytomelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotRogueHasCloseEnemyToMelee", &robotroguehascloseenemytomelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotRogueHasEnemyToMelee", &robotroguehasenemytomelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsCrawler", &robotiscrawler);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsMarching", &robotismarching);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotPrepareForAdjustToCover", &robotprepareforadjusttocover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldAdjustToCover", &robotshouldadjusttocover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldBecomeCrawler", &robotshouldbecomecrawler);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldReactAtCover", &robotshouldreactatcover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldExplode", &robotshouldexplode);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldShutdown", &robotshouldshutdown);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotSupportsOverCover", &robotsupportsovercover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStepIn", &shouldstepincondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldTakeOver", &shouldtakeovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("supportsStepOut", &supportsstepoutcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("setDesiredStanceToStand", &setdesiredstancetostand);
  behaviortreenetworkutility::registerbehaviortreescriptapi("setDesiredStanceToCrouch", &setdesiredstancetocrouch);
  behaviortreenetworkutility::registerbehaviortreescriptapi("toggleDesiredStance", &toggledesiredstance);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotMovement", &robotmovement);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotDelayMovement", &robotdelaymovement);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotInvalidateCover", &robotinvalidatecover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldChargeMelee", &robotshouldchargemelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldMelee", &robotshouldmelee);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotScriptRequiresToSprint", &scriptrequirestosprintcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotScanExposedPainTerminate", &robotscanexposedpainterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotTookEmpDamage", &robottookempdamage);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotNoCloseEnemyService", &robotnocloseenemyservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotWithinSprintRange", &robotwithinsprintrange);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotWithinSuperSprintRange", &robotwithinsupersprintrange);
  behaviorstatemachine::registerbsmscriptapiinternal("robotWithinSuperSprintRange", &robotwithinsupersprintrange);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotOutsideTacticalWalkRange", &robotoutsidetacticalwalkrange);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotOutsideSprintRange", &robotoutsidesprintrange);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotOutsideSuperSprintRange", &robotoutsidesupersprintrange);
  behaviorstatemachine::registerbsmscriptapiinternal("robotOutsideSuperSprintRange", &robotoutsidesupersprintrange);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotLightsOff", &robotlightsoff);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotLightsFlicker", &robotlightsflicker);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotLightsOn", &robotlightson);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldGibDeath", &robotshouldgibdeath);
  behaviortreenetworkutility::registerbehaviortreeaction("robotProceduralTraversal", &robottraversestart, &robotproceduraltraversalupdate, &robottraverseragdollondeath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCalcProceduralTraversal", &robotcalcproceduraltraversal);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotProceduralLanding", &robotprocedurallandingupdate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotTraverseEnd", &robottraverseend);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotTraverseRagdollOnDeath", &robottraverseragdollondeath);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldProceduralTraverse", &robotshouldproceduraltraverse);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotWallrunTraverse", &robotwallruntraverse);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldWallrun", &robotshouldwallrun);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotSetupWallRunJump", &robotsetupwallrunjump);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotSetupWallRunLand", &robotsetupwallrunland);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotWallrunStart", &robotwallrunstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotWallrunEnd", &robotwallrunend);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCanJuke", &robotcanjuke);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCanTacticalJuke", &robotcantacticaljuke);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCanPreemptiveJuke", &robotcanpreemptivejuke);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotJukeInitialize", &robotjukeinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotPreemptiveJukeTerminate", &robotpreemptivejuketerminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCoverScanInitialize", &robotcoverscaninitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCoverScanTerminate", &robotcoverscanterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsAtCoverModeScan", &robotisatcovermodescan);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotExposedCoverService", &robotexposedcoverservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotPositionService", &robotpositionservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotTargetService", &robottargetservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotTryReacquireService", &robottryreacquireservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotRushEnemyService", &robotrushenemyservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotRushNeighborService", &robotrushneighborservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotCrawlerService", &robotcrawlerservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("robotMoveToPlayerService", &movetoplayerupdate);
  animationstatenetwork::registeranimationmocomp("mocomp_ignore_pain_face_enemy", &mocompignorepainfaceenemyinit, &mocompignorepainfaceenemyupdate, &mocompignorepainfaceenemyterminate);
  animationstatenetwork::registeranimationmocomp("robot_procedural_traversal", &mocomprobotproceduraltraversalinit, &mocomprobotproceduraltraversalupdate, &mocomprobotproceduraltraversalterminate);
  animationstatenetwork::registeranimationmocomp("robot_start_traversal", &mocomprobotstarttraversalinit, undefined, &mocomprobotstarttraversalterminate);
  animationstatenetwork::registeranimationmocomp("robot_start_wallrun", &mocomprobotstartwallruninit, &mocomprobotstartwallrunupdate, &mocomprobotstartwallrunterminate);
}

function robotcleanupchargemeleeattack(behaviortreeentity) {
  aiutility::meleereleasemutex(behaviortreeentity);
  aiutility::releaseclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", undefined);
}

function private robotlightsoff(entity, asmstatename) {
  entity ai::set_behavior_attribute("robot_lights", 2);
  clientfield::set("robot_EMP", 1);
  return 4;
}

function private robotlightsflicker(entity, asmstatename) {
  entity ai::set_behavior_attribute("robot_lights", 1);
  clientfield::set("robot_EMP", 1);
  entity notify("emp_fx_start");
  return 4;
}

function private robotlightson(entity, asmstatename) {
  entity ai::set_behavior_attribute("robot_lights", 0);
  clientfield::set("robot_EMP", 0);
  return 4;
}

function private robotshouldgibdeath(entity, asmstatename) {
  return entity.gibdeath;
}

function private robotempidleinitialize(entity, asmstatename) {
  entity.empstoptime = gettime() + entity.empshutdowntime;
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity notify("emp_shutdown_start");
  return 5;
}

function private robotempidleupdate(entity, asmstatename) {
  if(gettime() < entity.empstoptime || entity ai::get_behavior_attribute("shutdown")) {
    if(entity asmgetstatus() == "asm_status_complete") {
      animationstatenetworkutility::requeststate(entity, asmstatename);
    }
    return 5;
  }
  return 4;
}

function private robotempidleterminate(entity, asmstatename) {
  entity notify("emp_shutdown_end");
  return 4;
}

function robotproceduraltraversalupdate(entity, asmstatename) {
  assert(isDefined(entity.traversal));
  traversal = entity.traversal;
  t = min((gettime() - traversal.starttime) / traversal.totaltime, 1);
  curveremaining = traversal.curvelength * (1 - t);
  if(curveremaining < traversal.landingdistance) {
    traversal.landing = 1;
    return 4;
  }
  return 5;
}

function robotprocedurallandingupdate(entity, asmstatename) {
  if(isDefined(entity.traversal)) {
    entity finishtraversal();
  }
  return 5;
}

function robotcalcproceduraltraversal(entity, asmstatename) {
  if(!isDefined(entity.traversestartnode) || !isDefined(entity.traverseendnode)) {
    return true;
  }
  entity.traversal = spawnStruct();
  traversal = entity.traversal;
  traversal.landingdistance = 24;
  traversal.minimumspeed = 18;
  traversal.startnode = entity.traversestartnode;
  traversal.endnode = entity.traverseendnode;
  startiswallrun = traversal.startnode.spawnflags & 2048;
  endiswallrun = traversal.endnode.spawnflags & 2048;
  traversal.startpoint1 = entity.origin;
  traversal.endpoint1 = traversal.endnode.origin;
  if(endiswallrun) {
    facenormal = getnavmeshfacenormal(traversal.endpoint1, 30);
    traversal.endpoint1 = traversal.endpoint1 + ((facenormal * 30) / 2);
  }
  if(!isDefined(traversal.endpoint1)) {
    traversal.endpoint1 = traversal.endnode.origin;
  }
  traversal.distancetoend = distance(traversal.startpoint1, traversal.endpoint1);
  traversal.absheighttoend = abs(traversal.startpoint1[2] - traversal.endpoint1[2]);
  traversal.abslengthtoend = distance2d(traversal.startpoint1, traversal.endpoint1);
  speedboost = 0;
  if(traversal.abslengthtoend > 200) {
    speedboost = 16;
  } else {
    if(traversal.abslengthtoend > 120) {
      speedboost = 8;
    } else if(traversal.abslengthtoend > 80 || traversal.absheighttoend > 80) {
      speedboost = 4;
    }
  }
  if(isDefined(entity.traversalspeedboost)) {
    speedboost = entity[[entity.traversalspeedboost]]();
  }
  traversal.speedoncurve = (traversal.minimumspeed + speedboost) * 12;
  heightoffset = max(traversal.absheighttoend * 0.8, min(traversal.abslengthtoend, 96));
  traversal.startpoint2 = entity.origin + (0, 0, heightoffset);
  traversal.endpoint2 = traversal.endpoint1 + (0, 0, heightoffset);
  if(traversal.startpoint1[2] < traversal.endpoint1[2]) {
    traversal.startpoint2 = traversal.startpoint2 + (0, 0, traversal.absheighttoend);
  } else {
    traversal.endpoint2 = traversal.endpoint2 + (0, 0, traversal.absheighttoend);
  }
  if(startiswallrun || endiswallrun) {
    startdirection = robotstartjumpdirection();
    enddirection = robotendjumpdirection();
    if(startdirection == "out") {
      point2scale = 0.5;
      towardend = (traversal.endnode.origin - entity.origin) * point2scale;
      traversal.startpoint2 = entity.origin + (towardend[0], towardend[1], 0);
      traversal.endpoint2 = traversal.endpoint1 + (0, 0, traversal.absheighttoend * point2scale);
      traversal.angles = entity.angles;
    }
    if(enddirection == "in") {
      point2scale = 0.5;
      towardstart = (entity.origin - traversal.endnode.origin) * point2scale;
      traversal.startpoint2 = entity.origin + (0, 0, traversal.absheighttoend * point2scale);
      traversal.endpoint2 = traversal.endnode.origin + (towardstart[0], towardstart[1], 0);
      facenormal = getnavmeshfacenormal(traversal.endnode.origin, 30);
      direction = _calculatewallrundirection(traversal.startnode.origin, traversal.endnode.origin);
      movedirection = vectorcross(facenormal, (0, 0, 1));
      if(direction == "right") {
        movedirection = movedirection * -1;
      }
      traversal.angles = vectortoangles(movedirection);
    }
    if(endiswallrun) {
      traversal.landingdistance = 110;
    } else {
      traversal.landingdistance = 60;
    }
    traversal.speedoncurve = traversal.speedoncurve * 1.2;
  }
  recordline(traversal.startpoint1, traversal.startpoint2, (1, 0.5, 0), "", entity);
  recordline(traversal.startpoint1, traversal.endpoint1, (1, 0.5, 0), "", entity);
  recordline(traversal.endpoint1, traversal.endpoint2, (1, 0.5, 0), "", entity);
  recordline(traversal.startpoint2, traversal.endpoint2, (1, 0.5, 0), "", entity);
  record3dtext(traversal.abslengthtoend, traversal.endpoint1 + vectorscale((0, 0, 1), 12), (1, 0.5, 0), "", entity);
  segments = 10;
  previouspoint = traversal.startpoint1;
  traversal.curvelength = 0;
  for(index = 1; index <= segments; index++) {
    t = index / segments;
    nextpoint = calculatecubicbezier(t, traversal.startpoint1, traversal.startpoint2, traversal.endpoint2, traversal.endpoint1);
    recordline(previouspoint, nextpoint, (0, 1, 0), "", entity);
    traversal.curvelength = traversal.curvelength + distance(previouspoint, nextpoint);
    previouspoint = nextpoint;
  }
  traversal.starttime = gettime();
  traversal.endtime = traversal.starttime + (traversal.curvelength * (1000 / traversal.speedoncurve));
  traversal.totaltime = traversal.endtime - traversal.starttime;
  traversal.landing = 0;
  return true;
}

function robottraversestart(entity, asmstatename) {
  entity.skipdeath = 1;
  traversal = entity.traversal;
  traversal.starttime = gettime();
  traversal.endtime = traversal.starttime + (traversal.curvelength * (1000 / traversal.speedoncurve));
  traversal.totaltime = traversal.endtime - traversal.starttime;
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

function robottraverseend(entity) {
  robottraverseragdollondeath(entity);
  entity.skipdeath = 0;
  entity.traversal = undefined;
  entity notify("traverse_end");
  return 4;
}

function private robottraverseragdollondeath(entity, asmstatename) {
  if(!isalive(entity)) {
    entity startragdoll();
  }
  return 4;
}

function private robotshouldproceduraltraverse(entity) {
  if(isDefined(entity.traversestartnode) && isDefined(entity.traverseendnode)) {
    isprocedural = entity ai::get_behavior_attribute("traversals") == "procedural" || entity.traversestartnode.spawnflags & 1024 || entity.traverseendnode.spawnflags & 1024;
    return isprocedural;
  }
  return 0;
}

function private robotwallruntraverse(entity) {
  startnode = entity.traversestartnode;
  endnode = entity.traverseendnode;
  if(isDefined(startnode) && isDefined(endnode) && entity shouldstarttraversal()) {
    startiswallrun = startnode.spawnflags & 2048;
    endiswallrun = endnode.spawnflags & 2048;
    return startiswallrun || endiswallrun;
  }
  return 0;
}

function private robotshouldwallrun(entity) {
  return blackboard::getblackboardattribute(entity, "_robot_traversal_type") == "wall";
}

function private mocomprobotstartwallruninit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity setrepairpaths(0);
  entity orientmode("face angle", entity.angles[1]);
  entity.blockingpain = 1;
  entity.clamptonavmesh = 0;
  entity animmode("normal_nogravity", 0);
  entity setavoidancemask("avoid none");
}

function private mocomprobotstartwallrunupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  facenormal = getnavmeshfacenormal(entity.origin, 30);
  positiononwall = getclosestpointonnavmesh(entity.origin, 30, 0);
  direction = blackboard::getblackboardattribute(entity, "_robot_wallrun_direction");
  if(isDefined(facenormal) && isDefined(positiononwall)) {
    facenormal = (facenormal[0], facenormal[1], 0);
    facenormal = vectornormalize(facenormal);
    movedirection = vectorcross(facenormal, (0, 0, 1));
    if(direction == "right") {
      movedirection = movedirection * -1;
    }
    forwardpositiononwall = getclosestpointonnavmesh(positiononwall + (movedirection * 12), 30, 0);
    anglestoend = vectortoangles(forwardpositiononwall - positiononwall);
    recordline(positiononwall, forwardpositiononwall, (1, 0, 0), "", entity);
    entity orientmode("face angle", anglestoend[1]);
  }
}

function private mocomprobotstartwallrunterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity setrepairpaths(1);
  entity setavoidancemask("avoid all");
  entity.blockingpain = 0;
  entity.clamptonavmesh = 1;
}

function private calculatecubicbezier(t, p1, p2, p3, p4) {
  return ((pow(1 - t, 3)) * p1) + (((3 * (pow(1 - t, 2))) * t) * p2) + ((3 * (1 - t)) * pow(t, 2) * p3) + (pow(t, 3) * p4);
}

function private mocomprobotstarttraversalinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  startnode = entity.traversestartnode;
  startiswallrun = startnode.spawnflags & 2048;
  endnode = entity.traverseendnode;
  endiswallrun = endnode.spawnflags & 2048;
  if(!endiswallrun) {
    angletoend = vectortoangles(entity.traverseendnode.origin - entity.traversestartnode.origin);
    entity orientmode("face angle", angletoend[1]);
    if(startiswallrun) {
      entity animmode("normal_nogravity", 0);
    } else {
      entity animmode("gravity", 0);
    }
  } else {
    facenormal = getnavmeshfacenormal(endnode.origin, 30);
    direction = _calculatewallrundirection(startnode.origin, endnode.origin);
    movedirection = vectorcross(facenormal, (0, 0, 1));
    if(direction == "right") {
      movedirection = movedirection * -1;
    }
    recordline(endnode.origin, endnode.origin + (facenormal * 20), (1, 0, 0), "", entity);
    recordline(endnode.origin, endnode.origin + (movedirection * 20), (1, 0, 0), "", entity);
    angles = vectortoangles(movedirection);
    entity orientmode("face angle", angles[1]);
    if(startiswallrun) {
      entity animmode("normal_nogravity", 0);
    } else {
      entity animmode("gravity", 0);
    }
  }
  entity setrepairpaths(0);
  entity.blockingpain = 1;
  entity.clamptonavmesh = 0;
  entity pathmode("dont move");
}

function private mocomprobotstarttraversalterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {}

function private mocomprobotproceduraltraversalinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  traversal = entity.traversal;
  entity setavoidancemask("avoid none");
  entity orientmode("face angle", entity.angles[1]);
  entity setrepairpaths(0);
  entity animmode("noclip", 0);
  entity.blockingpain = 1;
  entity.clamptonavmesh = 0;
  if(isDefined(traversal) && traversal.landing) {
    entity animmode("angle deltas", 0);
  }
}

function private mocomprobotproceduraltraversalupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  traversal = entity.traversal;
  if(isDefined(traversal)) {
    if(entity ispaused()) {
      traversal.starttime = traversal.starttime + 50;
      return;
    }
    endiswallrun = traversal.endnode.spawnflags & 2048;
    realt = (gettime() - traversal.starttime) / traversal.totaltime;
    t = min(realt, 1);
    if(t < 1 || realt == 1 || !endiswallrun) {
      currentpos = calculatecubicbezier(t, traversal.startpoint1, traversal.startpoint2, traversal.endpoint2, traversal.endpoint1);
      angles = entity.angles;
      if(isDefined(traversal.angles)) {
        angles = traversal.angles;
      }
      entity forceteleport(currentpos, angles, 0);
    } else {
      entity animmode("normal_nogravity", 0);
    }
  }
}

function private mocomprobotproceduraltraversalterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  traversal = entity.traversal;
  if(isDefined(traversal) && gettime() >= traversal.endtime) {
    endiswallrun = traversal.endnode.spawnflags & 2048;
    if(!endiswallrun) {
      entity pathmode("move allowed");
    }
  }
  entity.clamptonavmesh = 1;
  entity.blockingpain = 0;
  entity setrepairpaths(1);
  entity setavoidancemask("avoid all");
}

function private mocompignorepainfaceenemyinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.blockingpain = 1;
  if(isDefined(entity.enemy)) {
    entity orientmode("face enemy");
  } else {
    entity orientmode("face angle", entity.angles[1]);
  }
  entity animmode("pos deltas");
}

function private mocompignorepainfaceenemyupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(isDefined(entity.enemy) && entity getanimtime(mocompanim) < 0.5) {
    entity orientmode("face enemy");
  } else {
    entity orientmode("face angle", entity.angles[1]);
  }
}

function private mocompignorepainfaceenemyterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.blockingpain = 0;
}

function private _calculatewallrundirection(startposition, endposition) {
  entity = self;
  facenormal = getnavmeshfacenormal(endposition, 30);
  recordline(startposition, endposition, (1, 0.5, 0), "", entity);
  if(isDefined(facenormal)) {
    recordline(endposition, endposition + (facenormal * 12), (1, 0.5, 0), "", entity);
    angles = vectortoangles(facenormal);
    right = anglestoright(angles);
    d = vectordot(right, endposition) * -1;
    if((vectordot(right, startposition) + d) > 0) {
      return "right";
    }
    return "left";
  }
  return "unknown";
}

function private robotwallrunstart() {
  entity = self;
  entity.skipdeath = 1;
  entity pushactors(0);
  entity pushplayer(1);
  entity.pushable = 0;
}

function private robotwallrunend() {
  entity = self;
  robottraverseragdollondeath(entity);
  entity.skipdeath = 0;
  entity pushactors(1);
  entity pushplayer(0);
  entity.pushable = 1;
}

function private robotsetupwallrunjump() {
  entity = self;
  startnode = entity.traversestartnode;
  endnode = entity.traverseendnode;
  direction = "unknown";
  jumpdirection = "unknown";
  traversaltype = "unknown";
  if(isDefined(startnode) && isDefined(endnode)) {
    startiswallrun = startnode.spawnflags & 2048;
    endiswallrun = endnode.spawnflags & 2048;
    if(endiswallrun) {
      direction = _calculatewallrundirection(startnode.origin, endnode.origin);
    } else {
      direction = _calculatewallrundirection(endnode.origin, startnode.origin);
      if(direction == "right") {
        direction = "left";
      } else {
        direction = "right";
      }
    }
    jumpdirection = robotstartjumpdirection();
    traversaltype = robottraversaltype(startnode);
  }
  blackboard::setblackboardattribute(entity, "_robot_jump_direction", jumpdirection);
  blackboard::setblackboardattribute(entity, "_robot_wallrun_direction", direction);
  blackboard::setblackboardattribute(entity, "_robot_traversal_type", traversaltype);
  robotcalcproceduraltraversal(entity, undefined);
  return 5;
}

function private robotsetupwallrunland() {
  entity = self;
  startnode = entity.traversestartnode;
  endnode = entity.traverseendnode;
  landdirection = "unknown";
  traversaltype = "unknown";
  if(isDefined(startnode) && isDefined(endnode)) {
    landdirection = robotendjumpdirection();
    traversaltype = robottraversaltype(endnode);
  }
  blackboard::setblackboardattribute(entity, "_robot_jump_direction", landdirection);
  blackboard::setblackboardattribute(entity, "_robot_traversal_type", traversaltype);
  return 5;
}

function private robotstartjumpdirection() {
  entity = self;
  startnode = entity.traversestartnode;
  endnode = entity.traverseendnode;
  if(isDefined(startnode) && isDefined(endnode)) {
    startiswallrun = startnode.spawnflags & 2048;
    endiswallrun = endnode.spawnflags & 2048;
    if(startiswallrun) {
      abslengthtoend = distance2d(startnode.origin, endnode.origin);
      if((startnode.origin[2] - endnode.origin[2]) > 48 && abslengthtoend < 250) {
        return "out";
      }
    }
    return "up";
  }
  return "unknown";
}

function private robotendjumpdirection() {
  entity = self;
  startnode = entity.traversestartnode;
  endnode = entity.traverseendnode;
  if(isDefined(startnode) && isDefined(endnode)) {
    startiswallrun = startnode.spawnflags & 2048;
    endiswallrun = endnode.spawnflags & 2048;
    if(endiswallrun) {
      abslengthtoend = distance2d(startnode.origin, endnode.origin);
      if((endnode.origin[2] - startnode.origin[2]) > 48 && abslengthtoend < 250) {
        return "in";
      }
    }
    return "down";
  }
  return "unknown";
}

function private robottraversaltype(node) {
  if(isDefined(node)) {
    if(node.spawnflags & 2048) {
      return "wall";
    }
    return "ground";
  }
  return "unknown";
}

function private archetyperobotblackboardinit() {
  entity = self;
  blackboard::createblackboardforentity(entity);
  ai::createinterfaceforentity(entity);
  entity aiutility::registerutilityblackboardattributes();
  blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_mind_control", "normal", &robotismindcontrolled);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_move_mode", "normal", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_gibbed_limbs", undefined, &robotgetgibbedlimbs);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_robot_jump_direction", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_robot_locomotion_type", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_robot_traversal_type", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_robot_wallrun_direction", undefined, undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  blackboard::registerblackboardattribute(self, "_robot_mode", "normal", undefined);
  if(isactor(self)) {
    self trackblackboardattribute("");
  }
  entity.___archetypeonanimscriptedcallback = &archetyperobotonanimscriptedcallback;
  entity finalizetrackedblackboardattributes();
  if(sessionmodeiscampaigngame() || sessionmodeiszombiesgame()) {
    self thread gameskill::accuracy_buildup_before_fire(self);
  }
  if(self.accuratefire) {
    self thread aiutility::preshootlaserandglinton(self);
    self thread aiutility::postshootlaserandglintoff(self);
  }
}

function private robotcrawlercanshootenemy(entity) {
  if(!isDefined(entity.enemy)) {
    return 0;
  }
  aimlimits = entity getaimlimitsfromentry("robot_crawler");
  yawtoenemy = angleclamp180((vectortoangles(entity lastknownpos(entity.enemy) - entity.origin)[1]) - entity.angles[1]);
  angleepsilon = 10;
  return yawtoenemy <= (aimlimits["aim_left"] + angleepsilon) && yawtoenemy >= (aimlimits["aim_right"] + angleepsilon);
}

function private archetyperobotonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetyperobotblackboardinit();
}

function private robotgetgibbedlimbs() {
  entity = self;
  rightarmgibbed = gibserverutils::isgibbed(entity, 16);
  leftarmgibbed = gibserverutils::isgibbed(entity, 32);
  if(rightarmgibbed && leftarmgibbed) {
    return "both_arms";
  }
  if(rightarmgibbed) {
    return "right_arm";
  }
  if(leftarmgibbed) {
    return "left_arm";
  }
  return "none";
}

function private robotinvalidatecover(entity) {
  entity.steppedoutofcover = 0;
  entity pathmode("move allowed");
}

function private robotdelaymovement(entity) {
  entity pathmode("move delayed", 0, randomfloatrange(1, 2));
}

function private robotmovement(entity) {
  if(blackboard::getblackboardattribute(entity, "_stance") != "stand") {
    blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
  }
}

function private robotcoverscaninitialize(entity) {
  blackboard::setblackboardattribute(entity, "_cover_mode", "cover_scan");
  blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
  blackboard::setblackboardattribute(entity, "_robot_step_in", "slow");
  aiutility::keepclaimnode(entity);
  aiutility::choosecoverdirection(entity, 1);
  entity.steppedoutofcovernode = entity.node;
}

function private robotcoverscanterminate(entity) {
  aiutility::cleanupcovermode(entity);
  entity.steppedoutofcover = 1;
  entity.steppedouttime = gettime() - 8000;
  aiutility::releaseclaimnode(entity);
  entity pathmode("dont move");
}

function robotcanjuke(entity) {
  if(!entity ai::get_behavior_attribute("phalanx") && (!(isDefined(entity.steppedoutofcover) && entity.steppedoutofcover)) && aiutility::canjuke(entity)) {
    jukeevents = blackboard::getblackboardevents("actor_juke");
    tooclosejukedistancesqr = 57600;
    foreach(event in jukeevents) {
      if(distance2dsquared(entity.origin, event.data.origin) <= tooclosejukedistancesqr) {
        return false;
      }
    }
    return true;
  }
  return false;
}

function robotcantacticaljuke(entity) {
  if(entity haspath() && aiutility::bb_getlocomotionfaceenemyquadrant() == "locomotion_face_enemy_front") {
    jukedirection = aiutility::calculatejukedirection(entity, 50, entity.jukedistance);
    return jukedirection != "forward";
  }
  return 0;
}

function robotcanpreemptivejuke(entity) {
  if(!isDefined(entity.enemy) || !isplayer(entity.enemy)) {
    return 0;
  }
  if(blackboard::getblackboardattribute(entity, "_stance") == "crouch") {
    return 0;
  }
  if(!entity.shouldpreemptivejuke) {
    return 0;
  }
  if(isDefined(entity.nextpreemptivejuke) && entity.nextpreemptivejuke > gettime()) {
    return 0;
  }
  if(entity.enemy playerads() < entity.nextpreemptivejukeads) {
    return 0;
  }
  jukemaxdistance = 600;
  if(isweapon(entity.enemy.currentweapon) && isDefined(entity.enemy.currentweapon.enemycrosshairrange) && entity.enemy.currentweapon.enemycrosshairrange > 0) {
    jukemaxdistance = entity.enemy.currentweapon.enemycrosshairrange;
    if(jukemaxdistance > 1200) {
      jukemaxdistance = 1200;
    }
  }
  if(distancesquared(entity.origin, entity.enemy.origin) < (jukemaxdistance * jukemaxdistance)) {
    angledifference = absangleclamp180(entity.angles[1] - entity.enemy.angles[1]);
    record3dtext(angledifference, entity.origin + vectorscale((0, 0, 1), 5), (0, 1, 0), "");
    if(angledifference > 135) {
      enemyangles = entity.enemy getgunangles();
      toenemy = entity.enemy.origin - entity.origin;
      forward = anglesToForward(enemyangles);
      dotproduct = abs(vectordot(vectornormalize(toenemy), forward));
      record3dtext(acos(dotproduct), entity.origin + vectorscale((0, 0, 1), 10), (0, 1, 0), "");
      if(dotproduct > 0.9848) {
        return robotcanjuke(entity);
      }
    }
  }
  return 0;
}

function robotisatcovermodescan(entity) {
  covermode = blackboard::getblackboardattribute(entity, "_cover_mode");
  return covermode == "cover_scan";
}

function private robotprepareforadjusttocover(entity) {
  aiutility::keepclaimnode(entity);
  blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
}

function private robotcrawlerservice(entity) {
  if(isDefined(entity.crawlerlifetime) && entity.crawlerlifetime <= gettime() && entity.health > 0) {
    entity kill();
  }
  return true;
}

function robotiscrawler(entity) {
  return entity.iscrawler;
}

function private robotbecomecrawler(entity) {
  if(!entity ai::get_behavior_attribute("can_become_crawler")) {
    return;
  }
  entity.iscrawler = 1;
  entity.becomecrawler = 0;
  entity allowpitchangle(1);
  entity setpitchorient();
  entity.crawlerlifetime = gettime() + randomintrange(10000, 20000);
  entity notify("bhtn_action_notify", "rbCrawler");
}

function robotshouldbecomecrawler(entity) {
  return entity.becomecrawler;
}

function private robotismarching(entity) {
  return blackboard::getblackboardattribute(entity, "_move_mode") == "marching";
}

function private robotlocomotionspeed() {
  entity = self;
  if(robotismindcontrolled() == "mind_controlled") {
    switch (ai::getaiattribute(entity, "rogue_control_speed")) {
      case "walk": {
        return "locomotion_speed_walk";
      }
      case "run": {
        return "locomotion_speed_run";
      }
      case "sprint": {
        return "locomotion_speed_sprint";
      }
    }
  } else if(ai::getaiattribute(entity, "sprint")) {
    return "locomotion_speed_sprint";
  }
  return "locomotion_speed_walk";
}

function private robotcoveroverinitialize(behaviortreeentity) {
  aiutility::setcovershootstarttime(behaviortreeentity);
  aiutility::keepclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_over");
}

function private robotcoveroverterminate(behaviortreeentity) {
  aiutility::cleanupcovermode(behaviortreeentity);
  aiutility::clearcovershootstarttime(behaviortreeentity);
}

function private robotismindcontrolled() {
  entity = self;
  if(entity.controllevel > 1) {
    return "mind_controlled";
  }
  return "normal";
}

function private robotdonttakecover(entity) {
  entity.combatmode = "no_cover";
  entity.resumecover = gettime() + 4000;
}

function private _isvalidplayer(player) {
  if(!isDefined(player) || !isalive(player) || !isplayer(player) || player.sessionstate == "spectator" || player.sessionstate == "intermission" || player laststand::player_is_in_laststand() || player.ignoreme) {
    return false;
  }
  return true;
}

function private robotrushenemyservice(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }
  distancetoenemy = distance2dsquared(entity.origin, entity.enemy.origin);
  if(distancetoenemy >= 360000 && distancetoenemy <= 1440000) {
    findpathresult = entity findpath(entity.origin, entity.enemy.origin, 1, 0);
    if(findpathresult) {
      entity ai::set_behavior_attribute("move_mode", "rusher");
    }
  }
}

function private _isvalidrusher(entity, neighbor) {
  return isDefined(neighbor) && isDefined(neighbor.archetype) && neighbor.archetype == "robot" && isDefined(neighbor.team) && entity.team == neighbor.team && entity != neighbor && isDefined(neighbor.enemy) && neighbor ai::get_behavior_attribute("move_mode") == "normal" && !neighbor ai::get_behavior_attribute("phalanx") && neighbor ai::get_behavior_attribute("rogue_control") == "level_0" && distancesquared(entity.origin, neighbor.origin) < 160000 && distancesquared(neighbor.origin, neighbor.enemy.origin) < 1440000;
}

function private robotrushneighborservice(entity) {
  actors = getaiarray();
  closestenemy = undefined;
  closestenemydistance = undefined;
  foreach(ai in actors) {
    if(_isvalidrusher(entity, ai)) {
      enemydistance = distancesquared(entity.origin, ai.origin);
      if(!isDefined(closestenemydistance) || enemydistance < closestenemydistance) {
        closestenemydistance = enemydistance;
        closestenemy = ai;
      }
    }
  }
  if(isDefined(closestenemy)) {
    findpathresult = entity findpath(closestenemy.origin, closestenemy.enemy.origin, 1, 0);
    if(findpathresult) {
      closestenemy ai::set_behavior_attribute("move_mode", "rusher");
    }
  }
}

function private _findclosest(entity, entities) {
  closest = spawnStruct();
  if(entities.size > 0) {
    closest.entity = entities[0];
    closest.distancesquared = distancesquared(entity.origin, closest.entity.origin);
    for(index = 1; index < entities.size; index++) {
      distancesquared = distancesquared(entity.origin, entities[index].origin);
      if(distancesquared < closest.distancesquared) {
        closest.distancesquared = distancesquared;
        closest.entity = entities[index];
      }
    }
  }
  return closest;
}

function private robottargetservice(entity) {
  if(robotabletoshootcondition(entity)) {
    return false;
  }
  if(isDefined(entity.ignoreall) && entity.ignoreall) {
    return false;
  }
  if(isDefined(entity.nexttargetserviceupdate) && entity.nexttargetserviceupdate > gettime() && isalive(entity.favoriteenemy)) {
    return false;
  }
  positiononnavmesh = getclosestpointonnavmesh(entity.origin, 200);
  if(!isDefined(positiononnavmesh)) {
    return;
  }
  if(isDefined(entity.favoriteenemy) && isDefined(entity.favoriteenemy._currentroguerobot) && entity.favoriteenemy._currentroguerobot == entity) {
    entity.favoriteenemy._currentroguerobot = undefined;
  }
  aienemies = [];
  playerenemies = [];
  ai = getaiarray();
  players = getplayers();
  foreach(value in ai) {
    if(issentient(value) && entity getignoreent(value)) {
      continue;
    }
    if(value.team != entity.team && isactor(value) && !isDefined(entity.favoriteenemy)) {
      enemypositiononnavmesh = getclosestpointonnavmesh(value.origin, 200, 30);
      if(isDefined(enemypositiononnavmesh) && entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0)) {
        aienemies[aienemies.size] = value;
      }
    }
  }
  foreach(value in players) {
    if(_isvalidplayer(value) && value.team != entity.team) {
      if(issentient(value) && entity getignoreent(value)) {
        continue;
      }
      enemypositiononnavmesh = getclosestpointonnavmesh(value.origin, 200, 30);
      if(isDefined(enemypositiononnavmesh) && entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0)) {
        playerenemies[playerenemies.size] = value;
      }
    }
  }
  closestplayer = _findclosest(entity, playerenemies);
  closestai = _findclosest(entity, aienemies);
  if(!isDefined(closestplayer.entity) && !isDefined(closestai.entity)) {
    return;
  }
  if(!isDefined(closestai.entity)) {
    entity.favoriteenemy = closestplayer.entity;
  } else {
    if(!isDefined(closestplayer.entity)) {
      entity.favoriteenemy = closestai.entity;
      entity.favoriteenemy._currentroguerobot = entity;
    } else {
      if(closestai.distancesquared < closestplayer.distancesquared) {
        entity.favoriteenemy = closestai.entity;
        entity.favoriteenemy._currentroguerobot = entity;
      } else {
        entity.favoriteenemy = closestplayer.entity;
      }
    }
  }
  entity.nexttargetserviceupdate = gettime() + randomintrange(2500, 3500);
}

function private setdesiredstancetostand(behaviortreeentity) {
  currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  if(currentstance == "crouch") {
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
  }
}

function private setdesiredstancetocrouch(behaviortreeentity) {
  currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  if(currentstance == "stand") {
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "crouch");
  }
}

function private toggledesiredstance(entity) {
  currentstance = blackboard::getblackboardattribute(entity, "_stance");
  if(currentstance == "stand") {
    blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
  } else {
    blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
  }
}

function private robotshouldshutdown(entity) {
  return entity ai::get_behavior_attribute("shutdown");
}

function private robotshouldexplode(entity) {
  if(entity.controllevel >= 3) {
    if(entity ai::get_behavior_attribute("rogue_force_explosion")) {
      return 1;
    }
    if(isDefined(entity.enemy)) {
      enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
      return enemydistsq < 3600;
    }
  }
  return 0;
}

function private robotshouldadjusttocover(entity) {
  if(!isDefined(entity.node)) {
    return 0;
  }
  return blackboard::getblackboardattribute(entity, "_stance") != "crouch";
}

function private robotshouldreactatcover(behaviortreeentity) {
  return blackboard::getblackboardattribute(behaviortreeentity, "_stance") == "crouch" && aiutility::canbeflanked(behaviortreeentity) && behaviortreeentity isatcovernodestrict() && behaviortreeentity isflankedatcovernode() && !behaviortreeentity haspath();
}

function private robotexplode(entity) {
  entity.allowdeath = 0;
  entity.nocybercom = 1;
}

function private robotexplodeterminate(entity) {
  blackboard::setblackboardattribute(entity, "_gib_location", "legs");
  entity radiusdamage(entity.origin + vectorscale((0, 0, 1), 36), 60, 100, 50, entity, "MOD_EXPLOSIVE");
  if(math::cointoss()) {
    gibserverutils::gibleftarm(entity);
  } else {
    gibserverutils::gibrightarm(entity);
  }
  gibserverutils::giblegs(entity);
  gibserverutils::gibhead(entity);
  clientfield::set("robot_mind_control_explosion", 1);
  if(isalive(entity)) {
    entity.allowdeath = 1;
    entity kill();
  }
  entity startragdoll();
}

function private robotexposedcoverservice(entity) {
  if(isDefined(entity.steppedoutofcover) && isDefined(entity.steppedoutofcovernode) && (!entity iscovervalid(entity.steppedoutofcovernode) || entity haspath() || !entity issafefromgrenade())) {
    entity.steppedoutofcover = 0;
    entity pathmode("move allowed");
  }
  if(isDefined(entity.resumecover) && gettime() > entity.resumecover) {
    entity.combatmode = "cover";
    entity.resumecover = undefined;
  }
}

function private robotisatcovercondition(entity) {
  enemytooclose = 0;
  if(isDefined(entity.enemy)) {
    lastknownenemypos = entity lastknownpos(entity.enemy);
    distancetoenemysqr = distance2dsquared(entity.origin, lastknownenemypos);
    enemytooclose = distancetoenemysqr <= 57600;
  }
  return !enemytooclose && !entity.steppedoutofcover && entity isatcovernodestrict() && entity shouldusecovernode() && !entity haspath() && entity issafefromgrenade() && entity.combatmode != "no_cover";
}

function private robotsupportsovercover(entity) {
  if(isDefined(entity.node)) {
    if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags & 4) == 4) {
      return entity.node.type == "Cover Stand" || entity.node.type == "Conceal Stand";
    }
    return entity.node.type == "Cover Left" || entity.node.type == "Cover Right" || (entity.node.type == "Cover Crouch" || entity.node.type == "Cover Crouch Window" || entity.node.type == "Conceal Crouch");
  }
  return 0;
}

function private canmovetoenemycondition(entity) {
  if(!isDefined(entity.enemy) || entity.enemy.health <= 0) {
    return 0;
  }
  positiononnavmesh = getclosestpointonnavmesh(entity.origin, 200);
  enemypositiononnavmesh = getclosestpointonnavmesh(entity.enemy.origin, 200, 30);
  if(!isDefined(positiononnavmesh) || !isDefined(enemypositiononnavmesh)) {
    return 0;
  }
  findpathresult = entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0);
  if(!findpathresult) {
    record3dtext("", enemypositiononnavmesh + vectorscale((0, 0, 1), 5), (1, 0.5, 0), "");
    recordline(positiononnavmesh, enemypositiononnavmesh, (1, 0.5, 0), "", entity);
  }
  return findpathresult;
}

function private canmoveclosetoenemycondition(entity) {
  if(!isDefined(entity.enemy) || entity.enemy.health <= 0) {
    return 0;
  }
  queryresult = positionquery_source_navigation(entity.enemy.origin, 0, 120, 120, 20, entity);
  positionquery_filter_inclaimedlocation(queryresult, entity);
  return queryresult.data.size > 0;
}

function private robotstartsprint(entity) {
  blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
  return true;
}

function private robotstartsupersprint(entity) {
  blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_super_sprint");
  return true;
}

function private robottacticalwalkactionstart(entity) {
  aiutility::resetcoverparameters(entity);
  aiutility::setcanbeflanked(entity, 0);
  blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_walk");
  blackboard::setblackboardattribute(entity, "_stance", "stand");
  return true;
}

function private robotdie(entity) {
  if(isalive(entity)) {
    entity kill();
  }
}

function private movetoplayerupdate(entity, asmstatename) {
  entity.keepclaimednode = 0;
  positiononnavmesh = getclosestpointonnavmesh(entity.origin, 200);
  if(!isDefined(positiononnavmesh)) {
    return 4;
  }
  if(isDefined(entity.ignoreall) && entity.ignoreall) {
    entity clearuseposition();
    return 4;
  }
  if(!isDefined(entity.enemy)) {
    return 4;
  }
  if(robotroguehascloseenemytomelee(entity)) {
    return 4;
  }
  if(entity.allowpushactors) {
    if(isDefined(entity.enemy) && distancesquared(entity.origin, entity.enemy.origin) > (300 * 300)) {
      entity pushactors(0);
    } else {
      entity pushactors(1);
    }
  }
  if(entity asmistransdecrunning() || entity asmistransitionrunning()) {
    return 4;
  }
  if(!isDefined(entity.lastknownenemypos)) {
    entity.lastknownenemypos = entity.enemy.origin;
  }
  shouldrepath = !isDefined(entity.lastvalidenemypos);
  if(!shouldrepath && isDefined(entity.enemy)) {
    if(isDefined(entity.nextmovetoplayerupdate) && entity.nextmovetoplayerupdate <= gettime()) {
      shouldrepath = 1;
    } else {
      if(distancesquared(entity.lastknownenemypos, entity.enemy.origin) > (72 * 72)) {
        shouldrepath = 1;
      } else {
        if(distancesquared(entity.origin, entity.enemy.origin) <= (120 * 120)) {
          shouldrepath = 1;
        } else if(isDefined(entity.pathgoalpos)) {
          distancetogoalsqr = distancesquared(entity.origin, entity.pathgoalpos);
          shouldrepath = distancetogoalsqr < (72 * 72);
        }
      }
    }
  }
  if(shouldrepath) {
    entity.lastknownenemypos = entity.enemy.origin;
    queryresult = positionquery_source_navigation(entity.lastknownenemypos, 0, 120, 120, 20, entity);
    positionquery_filter_inclaimedlocation(queryresult, entity);
    if(queryresult.data.size > 0) {
      entity.lastvalidenemypos = queryresult.data[0].origin;
    }
    if(isDefined(entity.lastvalidenemypos)) {
      entity useposition(entity.lastvalidenemypos);
      if(distancesquared(entity.origin, entity.lastvalidenemypos) > (240 * 240)) {
        path = entity calcapproximatepathtoposition(entity.lastvalidenemypos, 0);
        if(getdvarint("")) {
          for(index = 1; index < path.size; index++) {
            recordline(path[index - 1], path[index], (1, 0.5, 0), "", entity);
          }
        }
        deviationdistance = randomintrange(240, 480);
        segmentlength = 0;
        for(index = 1; index < path.size; index++) {
          currentseglength = distance(path[index - 1], path[index]);
          if((segmentlength + currentseglength) > deviationdistance) {
            remaininglength = deviationdistance - segmentlength;
            seedposition = (path[index - 1]) + ((vectornormalize(path[index] - (path[index - 1]))) * remaininglength);
            recordcircle(seedposition, 2, (1, 0.5, 0), "", entity);
            innerzigzagradius = 0;
            outerzigzagradius = 64;
            queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, entity, 16);
            positionquery_filter_inclaimedlocation(queryresult, entity);
            if(queryresult.data.size > 0) {
              point = queryresult.data[randomint(queryresult.data.size)];
              entity useposition(point.origin);
            }
            break;
          }
          segmentlength = segmentlength + currentseglength;
        }
      }
    }
    entity.nextmovetoplayerupdate = gettime() + randomintrange(2000, 3000);
  }
  return 5;
}

function private robotshouldchargemelee(entity) {
  if(aiutility::shouldmutexmelee(entity) && robothasenemytomelee(entity)) {
    return true;
  }
  return false;
}

function private robothasenemytomelee(entity) {
  if(isDefined(entity.enemy) && issentient(entity.enemy) && entity.enemy.health > 0) {
    enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
    if(enemydistsq < (entity.chargemeleedistance * entity.chargemeleedistance) && (abs(entity.enemy.origin[2] - entity.origin[2])) < 24) {
      yawtoenemy = angleclamp180(entity.angles[1] - (vectortoangles(entity.enemy.origin - entity.origin)[1]));
      return abs(yawtoenemy) <= 80;
    }
  }
  return 0;
}

function private robotroguehasenemytomelee(entity) {
  if(isDefined(entity.enemy) && issentient(entity.enemy) && entity.enemy.health > 0 && entity ai::get_behavior_attribute("rogue_control") != "level_3") {
    if(!entity cansee(entity.enemy)) {
      return 0;
    }
    return distancesquared(entity.origin, entity.enemy.origin) < (132 * 132);
  }
  return 0;
}

function private robotshouldmelee(entity) {
  if(aiutility::shouldmutexmelee(entity) && robothascloseenemytomelee(entity)) {
    return true;
  }
  return false;
}

function private robothascloseenemytomelee(entity) {
  if(isDefined(entity.enemy) && issentient(entity.enemy) && entity.enemy.health > 0) {
    if(!entity cansee(entity.enemy)) {
      return 0;
    }
    enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
    if(enemydistsq < (64 * 64)) {
      yawtoenemy = angleclamp180(entity.angles[1] - (vectortoangles(entity.enemy.origin - entity.origin)[1]));
      return abs(yawtoenemy) <= 80;
    }
  }
  return 0;
}

function private robotroguehascloseenemytomelee(entity) {
  if(isDefined(entity.enemy) && issentient(entity.enemy) && entity.enemy.health > 0 && entity ai::get_behavior_attribute("rogue_control") != "level_3") {
    return distancesquared(entity.origin, entity.enemy.origin) < (64 * 64);
  }
  return 0;
}

function private scriptrequirestosprintcondition(entity) {
  return entity ai::get_behavior_attribute("sprint") && !entity ai::get_behavior_attribute("disablesprint");
}

function private robotscanexposedpainterminate(entity) {
  aiutility::cleanupcovermode(entity);
  blackboard::setblackboardattribute(entity, "_robot_step_in", "fast");
}

function private robottookempdamage(entity) {
  if(isDefined(entity.damageweapon) && isDefined(entity.damagemod)) {
    weapon = entity.damageweapon;
    return entity.damagemod == "MOD_GRENADE_SPLASH" && isDefined(weapon.rootweapon) && issubstr(weapon.rootweapon.name, "emp_grenade");
  }
  return 0;
}

function private robotnocloseenemyservice(entity) {
  if(isDefined(entity.enemy) && aiutility::shouldmelee(entity)) {
    entity clearpath();
    return true;
  }
  return false;
}

function private _robotoutsidemovementrange(entity, range, useenemypos) {
  assert(isDefined(range));
  if(!isDefined(entity.enemy) && !entity haspath()) {
    return 0;
  }
  goalpos = entity.pathgoalpos;
  if(isDefined(entity.enemy) && useenemypos) {
    goalpos = entity lastknownpos(entity.enemy);
  }
  if(!isDefined(goalpos)) {
    return 0;
  }
  outsiderange = distancesquared(entity.origin, goalpos) > (range * range);
  return outsiderange;
}

function private robotoutsidesupersprintrange(entity) {
  return !robotwithinsupersprintrange(entity);
}

function private robotwithinsupersprintrange(entity) {
  if(entity ai::get_behavior_attribute("supports_super_sprint") && !entity ai::get_behavior_attribute("disablesprint")) {
    return _robotoutsidemovementrange(entity, entity.supersprintdistance, 0);
  }
  return 0;
}

function private robotoutsidesprintrange(entity) {
  if(entity ai::get_behavior_attribute("supports_super_sprint") && !entity ai::get_behavior_attribute("disablesprint")) {
    return _robotoutsidemovementrange(entity, entity.supersprintdistance * 1.15, 0);
  }
  return 0;
}

function private robotoutsidetacticalwalkrange(entity) {
  if(entity ai::get_behavior_attribute("disablesprint")) {
    return 0;
  }
  if(isDefined(entity.enemy) && distancesquared(entity.origin, entity.goalpos) < (entity.minwalkdistance * entity.minwalkdistance)) {
    return 0;
  }
  return _robotoutsidemovementrange(entity, entity.runandgundist * 1.15, 1);
}

function private robotwithinsprintrange(entity) {
  if(entity ai::get_behavior_attribute("disablesprint")) {
    return 0;
  }
  if(isDefined(entity.enemy) && distancesquared(entity.origin, entity.goalpos) < (entity.minwalkdistance * entity.minwalkdistance)) {
    return 0;
  }
  return _robotoutsidemovementrange(entity, entity.runandgundist, 1);
}

function private shouldtakeovercondition(entity) {
  switch (entity.controllevel) {
    case 0: {
      return isinarray(array("level_1", "level_2", "level_3"), entity ai::get_behavior_attribute("rogue_control"));
    }
    case 1: {
      return isinarray(array("level_2", "level_3"), entity ai::get_behavior_attribute("rogue_control"));
    }
    case 2: {
      return entity ai::get_behavior_attribute("rogue_control") == "level_3";
    }
  }
  return 0;
}

function private hasminiraps(entity) {
  return isDefined(entity.miniraps);
}

function private robotismoving(entity) {
  velocity = entity getvelocity();
  velocity = (velocity[0], 0, velocity[1]);
  velocitysqr = lengthsquared(velocity);
  return velocitysqr > (24 * 24);
}

function private robotabletoshootcondition(entity) {
  return entity.controllevel <= 1;
}

function private robotshouldtacticalwalk(entity) {
  if(!entity haspath()) {
    return 0;
  }
  return !robotismarching(entity);
}

function private _robotcoverposition(entity) {
  if(entity isflankedatcovernode()) {
    return false;
  }
  if(entity shouldholdgroundagainstenemy()) {
    return false;
  }
  shouldusecovernode = undefined;
  itsbeenawhile = gettime() > entity.nextfindbestcovertime;
  isatscriptgoal = undefined;
  if(isDefined(entity.robotnode)) {
    isatscriptgoal = entity isposatgoal(entity.robotnode.origin);
    shouldusecovernode = entity iscovervalid(entity.robotnode);
  } else {
    isatscriptgoal = entity isatgoal();
    shouldusecovernode = entity shouldusecovernode();
  }
  shouldlookforbettercover = !shouldusecovernode || itsbeenawhile || !isatscriptgoal;
  recordenttext((((("" + shouldusecovernode) + "") + itsbeenawhile) + "") + isatscriptgoal, entity, (shouldlookforbettercover ? (0, 1, 0) : (1, 0, 0)), "");
  if(shouldlookforbettercover && isDefined(entity.enemy) && !entity.keepclaimednode) {
    transitionrunning = entity asmistransitionrunning();
    substatepending = entity asmissubstatepending();
    transdecrunning = entity asmistransdecrunning();
    isbehaviortreeinrunningstate = entity getbehaviortreestatus() == 5;
    if(!transitionrunning && !substatepending && !transdecrunning && isbehaviortreeinrunningstate) {
      nodes = entity findbestcovernodes(entity.goalradius, entity.goalpos);
      node = undefined;
      for(nodeindex = 0; nodeindex < nodes.size; nodeindex++) {
        if(entity.robotnode === nodes[nodeindex] || !isDefined(nodes[nodeindex].robotclaimed)) {
          node = nodes[nodeindex];
          break;
        }
      }
      if(isentity(entity.node) && (!isDefined(entity.robotnode) || entity.robotnode != entity.node)) {
        entity.robotnode = entity.node;
        entity.robotnode.robotclaimed = 1;
      }
      goingtodifferentnode = isDefined(node) && (!isDefined(entity.robotnode) || node != entity.robotnode) && (!isDefined(entity.steppedoutofcovernode) || entity.steppedoutofcovernode != node);
      aiutility::setnextfindbestcovertime(entity, node);
      if(goingtodifferentnode) {
        if(randomfloat(1) <= 0.75 || entity ai::get_behavior_attribute("force_cover")) {
          aiutility::usecovernodewrapper(entity, node);
        } else {
          searchradius = entity.goalradius;
          if(searchradius > 200) {
            searchradius = 200;
          }
          covernodepoints = util::positionquery_pointarray(node.origin, 30, searchradius, 72, 30);
          if(covernodepoints.size > 0) {
            entity useposition(covernodepoints[randomint(covernodepoints.size)]);
          } else {
            entity useposition(entity getnodeoffsetposition(node));
          }
        }
        if(isDefined(entity.robotnode)) {
          entity.robotnode.robotclaimed = undefined;
        }
        entity.robotnode = node;
        entity.robotnode.robotclaimed = 1;
        entity pathmode("move delayed", 0, randomfloatrange(0.25, 2));
        return true;
      }
    }
  }
  return false;
}

function private _robotescortposition(entity) {
  if(entity ai::get_behavior_attribute("move_mode") == "escort") {
    escortposition = entity ai::get_behavior_attribute("escort_position");
    if(!isDefined(escortposition)) {
      return true;
    }
    if(distance2dsquared(entity.origin, escortposition) <= 22500) {
      return true;
    }
    if(isDefined(entity.escortnexttime) && gettime() < entity.escortnexttime) {
      return true;
    }
    if(entity getpathmode() == "dont move") {
      return true;
    }
    positiononnavmesh = getclosestpointonnavmesh(escortposition, 200);
    if(!isDefined(positiononnavmesh)) {
      positiononnavmesh = escortposition;
    }
    queryresult = positionquery_source_navigation(positiononnavmesh, 75, 150, 36, 16, entity, 16);
    positionquery_filter_inclaimedlocation(queryresult, entity);
    if(queryresult.data.size > 0) {
      closestpoint = undefined;
      closestdistance = undefined;
      foreach(point in queryresult.data) {
        if(!point.inclaimedlocation) {
          newclosestdistance = distance2dsquared(entity.origin, point.origin);
          if(!isDefined(closestpoint) || newclosestdistance < closestdistance) {
            closestpoint = point.origin;
            closestdistance = newclosestdistance;
          }
        }
      }
      if(isDefined(closestpoint)) {
        entity useposition(closestpoint);
        entity.escortnexttime = gettime() + randomintrange(200, 300);
      }
    }
    return true;
  }
  return false;
}

function private _robotrusherposition(entity) {
  if(entity ai::get_behavior_attribute("move_mode") == "rusher") {
    entity pathmode("move allowed");
    if(!isDefined(entity.enemy)) {
      return true;
    }
    disttoenemysqr = distance2dsquared(entity.origin, entity.enemy.origin);
    if(disttoenemysqr <= (entity.robotrushermaxradius * entity.robotrushermaxradius) && disttoenemysqr >= (entity.robotrusherminradius * entity.robotrusherminradius)) {
      return true;
    }
    if(isDefined(entity.rushernexttime) && gettime() < entity.rushernexttime) {
      return true;
    }
    positiononnavmesh = getclosestpointonnavmesh(entity.enemy.origin, 200);
    if(!isDefined(positiononnavmesh)) {
      positiononnavmesh = entity.enemy.origin;
    }
    queryresult = positionquery_source_navigation(positiononnavmesh, entity.robotrusherminradius, entity.robotrushermaxradius, 36, 16, entity, 16);
    positionquery_filter_inclaimedlocation(queryresult, entity);
    positionquery_filter_sight(queryresult, entity.enemy.origin, entity getEye() - entity.origin, entity, 2, entity.enemy);
    if(queryresult.data.size > 0) {
      closestpoint = undefined;
      closestdistance = undefined;
      foreach(point in queryresult.data) {
        if(!point.inclaimedlocation && point.visibility === 1) {
          newclosestdistance = distance2dsquared(entity.origin, point.origin);
          if(!isDefined(closestpoint) || newclosestdistance < closestdistance) {
            closestpoint = point.origin;
            closestdistance = newclosestdistance;
          }
        }
      }
      if(isDefined(closestpoint)) {
        entity useposition(closestpoint);
        entity.rushernexttime = gettime() + randomintrange(500, 1500);
      }
    }
    return true;
  }
  return false;
}

function private _robotguardposition(entity) {
  if(entity ai::get_behavior_attribute("move_mode") == "guard") {
    if(entity getpathmode() == "dont move") {
      return true;
    }
    if(!isDefined(entity.guardposition) || distancesquared(entity.origin, entity.guardposition) < (60 * 60)) {
      entity pathmode("move delayed", 1, randomfloatrange(1, 1.5));
      queryresult = positionquery_source_navigation(entity.goalpos, 0, entity.goalradius / 2, 36, 36, entity, 72);
      positionquery_filter_inclaimedlocation(queryresult, entity);
      if(queryresult.data.size > 0) {
        minimumdistancesq = entity.goalradius * 0.2;
        minimumdistancesq = minimumdistancesq * minimumdistancesq;
        distantpoints = [];
        foreach(point in queryresult.data) {
          if(distancesquared(entity.origin, point.origin) > minimumdistancesq) {
            distantpoints[distantpoints.size] = point;
          }
        }
        if(distantpoints.size > 0) {
          randomposition = distantpoints[randomint(distantpoints.size)];
          entity.guardposition = randomposition.origin;
          entity.intermediateguardposition = undefined;
          entity.intermediateguardtime = undefined;
        }
      }
    }
    currenttime = gettime();
    if(!isDefined(entity.intermediateguardtime) || entity.intermediateguardtime < currenttime) {
      if(isDefined(entity.intermediateguardposition) && distancesquared(entity.intermediateguardposition, entity.origin) < (24 * 24)) {
        entity.guardposition = entity.origin;
      }
      entity.intermediateguardposition = entity.origin;
      entity.intermediateguardtime = currenttime + 3000;
    }
    if(isDefined(entity.guardposition)) {
      entity useposition(entity.guardposition);
      return true;
    }
  }
  entity.guardposition = undefined;
  entity.intermediateguardposition = undefined;
  entity.intermediateguardtime = undefined;
  return false;
}

function private robotpositionservice(entity) {
  if(getdvarint("") && isDefined(entity.enemy)) {
    lastknownpos = entity lastknownpos(entity.enemy);
    recordline(entity.origin, lastknownpos, (1, 0.5, 0), "", entity);
    record3dtext("", lastknownpos + vectorscale((0, 0, 1), 5), (1, 0.5, 0), "");
  }
  if(!isalive(entity)) {
    if(isDefined(entity.robotnode)) {
      aiutility::releaseclaimnode(entity);
      entity.robotnode.robotclaimed = undefined;
      entity.robotnode = undefined;
    }
    return false;
  }
  if(entity.disablerepath) {
    return false;
  }
  if(!robotabletoshootcondition(entity)) {
    return false;
  }
  if(entity ai::get_behavior_attribute("phalanx")) {
    return false;
  }
  if(aisquads::isfollowingsquadleader(entity)) {
    return false;
  }
  if(_robotrusherposition(entity)) {
    return true;
  }
  if(_robotguardposition(entity)) {
    return true;
  }
  if(_robotescortposition(entity)) {
    return true;
  }
  if(!aiutility::issafefromgrenades(entity)) {
    aiutility::releaseclaimnode(entity);
    aiutility::choosebestcovernodeasap(entity);
  }
  if(_robotcoverposition(entity)) {
    return true;
  }
  return false;
}

function private robotdropstartingweapon(entity, asmstatename) {
  if(entity.weapon.name == level.weaponnone.name) {
    entity shared::placeweaponon(entity.startingweapon, "right");
    entity thread shared::dropaiweapon();
  }
}

function private robotjukeinitialize(entity) {
  aiutility::choosejukedirection(entity);
  entity clearpath();
  entity notify("bhtn_action_notify", "rbJuke");
  jukeinfo = spawnStruct();
  jukeinfo.origin = entity.origin;
  jukeinfo.entity = entity;
  blackboard::addblackboardevent("actor_juke", jukeinfo, 3000);
}

function private robotpreemptivejuketerminate(entity) {
  entity.nextpreemptivejuke = gettime() + randomintrange(4000, 6000);
  entity.nextpreemptivejukeads = randomfloatrange(0.5, 0.95);
}

function private robottryreacquireservice(entity) {
  movemode = entity ai::get_behavior_attribute("move_mode");
  if(movemode == "rusher" || movemode == "escort" || movemode == "guard") {
    return false;
  }
  if(!isDefined(entity.reacquire_state)) {
    entity.reacquire_state = 0;
  }
  if(!isDefined(entity.enemy)) {
    entity.reacquire_state = 0;
    return false;
  }
  if(entity haspath()) {
    return false;
  }
  if(!robotabletoshootcondition(entity)) {
    return false;
  }
  if(entity ai::get_behavior_attribute("force_cover")) {
    return false;
  }
  if(entity cansee(entity.enemy) && entity canshootenemy()) {
    entity.reacquire_state = 0;
    return false;
  }
  dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
  forward = anglesToForward(entity.angles);
  if(vectordot(dirtoenemy, forward) < 0.5) {
    entity.reacquire_state = 0;
    return false;
  }
  switch (entity.reacquire_state) {
    case 0:
    case 1:
    case 2: {
      step_size = 32 + (entity.reacquire_state * 32);
      reacquirepos = entity reacquirestep(step_size);
      break;
    }
    case 4: {
      if(!entity cansee(entity.enemy) || !entity canshootenemy()) {
        entity flagenemyunattackable();
      }
      break;
    }
    default: {
      if(entity.reacquire_state > 15) {
        entity.reacquire_state = 0;
        return false;
      }
      break;
    }
  }
  if(isvec(reacquirepos)) {
    entity useposition(reacquirepos);
    return true;
  }
  entity.reacquire_state++;
  return false;
}

function private takeoverinitialize(entity, asmstatename) {
  switch (entity ai::get_behavior_attribute("rogue_control")) {
    case "level_1": {
      entity robotsoldierserverutils::forcerobotsoldiermindcontrollevel1();
      break;
    }
    case "level_2": {
      entity robotsoldierserverutils::forcerobotsoldiermindcontrollevel2();
      break;
    }
    case "level_3": {
      entity robotsoldierserverutils::forcerobotsoldiermindcontrollevel3();
      break;
    }
  }
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

function private takeoverterminate(entity, asmstatename) {
  switch (entity ai::get_behavior_attribute("rogue_control")) {
    case "level_2":
    case "level_3": {
      entity thread shared::dropaiweapon();
      break;
    }
  }
  return 4;
}

function private stepintoinitialize(entity, asmstatename) {
  aiutility::releaseclaimnode(entity);
  aiutility::usecovernodewrapper(entity, entity.steppedoutofcovernode);
  blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
  aiutility::keepclaimnode(entity);
  entity.steppedoutofcovernode = undefined;
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

function private stepintoterminate(entity, asmstatename) {
  entity.steppedoutofcover = 0;
  aiutility::releaseclaimnode(entity);
  entity pathmode("move allowed");
  return 4;
}

function private stepoutinitialize(entity, asmstatename) {
  entity.steppedoutofcovernode = entity.node;
  aiutility::keepclaimnode(entity);
  if(math::cointoss()) {
    blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
  } else {
    blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
  }
  blackboard::setblackboardattribute(entity, "_robot_step_in", "fast");
  aiutility::choosecoverdirection(entity, 1);
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

function private stepoutterminate(entity, asmstatename) {
  entity.steppedoutofcover = 1;
  entity.steppedouttime = gettime();
  aiutility::releaseclaimnode(entity);
  entity pathmode("dont move");
  return 4;
}

function private supportsstepoutcondition(entity) {
  return entity.node.type == "Cover Left" || entity.node.type == "Cover Right" || entity.node.type == "Cover Pillar";
}

function private shouldstepincondition(entity) {
  if(!isDefined(entity.steppedoutofcover) || !entity.steppedoutofcover || !isDefined(entity.steppedouttime) || !entity.steppedoutofcover) {
    return 0;
  }
  exposedtimeinseconds = (gettime() - entity.steppedouttime) / 1000;
  exceededtime = exposedtimeinseconds >= 4 || exposedtimeinseconds >= 8;
  suppressed = entity.suppressionmeter > entity.suppressionthreshold;
  return exceededtime || (exceededtime && suppressed);
}

function private robotdeployminiraps() {
  entity = self;
  if(isDefined(entity) && isDefined(entity.miniraps)) {
    positiononnavmesh = getclosestpointonnavmesh(entity.origin, 200);
    raps = spawnvehicle("spawner_bo3_mini_raps", positiononnavmesh, (0, 0, 0));
    raps.team = entity.team;
    raps thread robotsoldierserverutils::rapsdetonatecountdown(raps);
    entity.miniraps = undefined;
  }
}

#namespace robotsoldierserverutils;

function private _trygibbinghead(entity, damage, hitloc, isexplosive) {
  if(isexplosive && randomfloatrange(0, 1) <= 0.5) {
    gibserverutils::gibhead(entity);
  } else {
    if(isinarray(array("head", "neck", "helmet"), hitloc) && randomfloatrange(0, 1) <= 1) {
      gibserverutils::gibhead(entity);
    } else if((entity.health - damage) <= 0 && randomfloatrange(0, 1) <= 0.25) {
      gibserverutils::gibhead(entity);
    }
  }
}

function private _trygibbinglimb(entity, damage, hitloc, isexplosive, ondeath) {
  if(gibserverutils::isgibbed(entity, 32) || gibserverutils::isgibbed(entity, 16)) {
    return;
  }
  if(isexplosive && randomfloatrange(0, 1) <= 0.25) {
    if(ondeath && math::cointoss()) {
      gibserverutils::gibrightarm(entity);
    } else {
      gibserverutils::gibleftarm(entity);
    }
  } else {
    if(isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
      gibserverutils::gibleftarm(entity);
    } else {
      if(ondeath && isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
      } else {
        if(robotsoldierbehavior::robotismindcontrolled() == "mind_controlled" && isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
          gibserverutils::gibrightarm(entity);
        } else if(ondeath && randomfloatrange(0, 1) <= 0.25) {
          if(math::cointoss()) {
            gibserverutils::gibleftarm(entity);
          } else {
            gibserverutils::gibrightarm(entity);
          }
        }
      }
    }
  }
}

function private _trygibbinglegs(entity, damage, hitloc, isexplosive, attacker = entity) {
  cangiblegs = (entity.health - damage) <= 0 && entity.allowdeath;
  if(entity ai::get_behavior_attribute("can_become_crawler")) {
    cangiblegs = cangiblegs || (((entity.health - damage) / entity.maxhealth) <= 0.25 && distancesquared(entity.origin, attacker.origin) <= 360000 && !robotsoldierbehavior::robotisatcovercondition(entity) && entity.allowdeath);
  }
  if(entity.gibdeath && (entity.health - damage) <= 0 && entity.allowdeath && !robotsoldierbehavior::robotiscrawler(entity)) {
    return;
  }
  if((entity.health - damage) <= 0 && entity.allowdeath && isexplosive && randomfloatrange(0, 1) <= 0.5) {
    gibserverutils::giblegs(entity);
    entity startragdoll();
  } else {
    if(cangiblegs && isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
      if((entity.health - damage) > 0) {
        becomecrawler(entity);
      }
      gibserverutils::gibleftleg(entity);
    } else {
      if(cangiblegs && isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
        if((entity.health - damage) > 0) {
          becomecrawler(entity);
        }
        gibserverutils::gibrightleg(entity);
      } else if((entity.health - damage) <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.25) {
        if(math::cointoss()) {
          gibserverutils::gibleftleg(entity);
        } else {
          gibserverutils::gibrightleg(entity);
        }
      }
    }
  }
}

function private robotgibdamageoverride(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity = self;
  if(isDefined(attacker) && attacker.team == entity.team) {
    return damage;
  }
  if(!entity ai::get_behavior_attribute("can_gib")) {
    return damage;
  }
  if(((entity.health - damage) / entity.maxhealth) > 0.75) {
    return damage;
  }
  gibserverutils::togglespawngibs(entity, 1);
  destructserverutils::togglespawngibs(entity, 1);
  isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
  _trygibbinghead(entity, damage, hitloc, isexplosive);
  _trygibbinglimb(entity, damage, hitloc, isexplosive, 0);
  _trygibbinglegs(entity, damage, hitloc, isexplosive, attacker);
  return damage;
}

function private robotdeathoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
  entity = self;
  entity ai::set_behavior_attribute("robot_lights", 4);
  return damage;
}

function private robotgibdeathoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
  entity = self;
  if(!entity ai::get_behavior_attribute("can_gib") || entity.skipdeath) {
    return damage;
  }
  gibserverutils::togglespawngibs(entity, 1);
  destructserverutils::togglespawngibs(entity, 1);
  isexplosive = 0;
  if(entity.controllevel >= 3) {
    clientfield::set("robot_mind_control_explosion", 1);
    destructserverutils::destructnumberrandompieces(entity);
    gibserverutils::gibhead(entity);
    if(math::cointoss()) {
      gibserverutils::gibleftarm(entity);
    } else {
      gibserverutils::gibrightarm(entity);
    }
    gibserverutils::giblegs(entity);
    velocity = entity getvelocity() / 9;
    entity startragdoll();
    entity launchragdoll((velocity[0] + (randomfloatrange(-10, 10)), velocity[1] + (randomfloatrange(-10, 10)), randomfloatrange(40, 50)), "j_mainroot");
    physicsexplosionsphere(entity.origin + vectorscale((0, 0, 1), 36), 120, 32, 1);
  } else {
    isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
    _trygibbinglimb(entity, damage, hitloc, isexplosive, 1);
  }
  return damage;
}

function private robotdestructdeathoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
  entity = self;
  if(entity.skipdeath) {
    return damage;
  }
  destructserverutils::togglespawngibs(entity, 1);
  piececount = destructserverutils::getpiececount(entity);
  possiblepieces = [];
  for(index = 1; index <= piececount; index++) {
    if(!destructserverutils::isdestructed(entity, index) && randomfloatrange(0, 1) <= 0.2) {
      possiblepieces[possiblepieces.size] = index;
    }
  }
  gibbedpieces = 0;
  for(index = 0; index < possiblepieces.size && possiblepieces.size > 1 && gibbedpieces < 2; index++) {
    randompiece = randomintrange(0, possiblepieces.size - 1);
    if(!destructserverutils::isdestructed(entity, possiblepieces[randompiece])) {
      destructserverutils::destructpiece(entity, possiblepieces[randompiece]);
      gibbedpieces++;
    }
  }
  return damage;
}

function private robotdamageoverride(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity = self;
  if(hitloc != "helmet" || hitloc != "head" || hitloc != "neck") {
    if(isDefined(attacker) && !isplayer(attacker) && !isvehicle(attacker)) {
      dist = distancesquared(entity.origin, attacker.origin);
      if(dist < 65536) {
        damage = int(damage * 10);
      } else {
        damage = int(damage * 1.5);
      }
    }
  }
  if(hitloc == "helmet" || hitloc == "head" || hitloc == "neck") {
    damage = int(damage * 0.5);
  }
  if(isDefined(dir) && isDefined(meansofdamage) && isDefined(hitloc) && vectordot(anglesToForward(entity.angles), dir) > 0) {
    isbullet = isinarray(array("MOD_RIFLE_BULLET", "MOD_PISTOL_BULLET"), meansofdamage);
    istorsoshot = isinarray(array("torso_upper", "torso_lower"), hitloc);
    if(isbullet && istorsoshot) {
      damage = int(damage * 2);
    }
  }
  if(weapon.name == "sticky_grenade") {
    switch (meansofdamage) {
      case "MOD_IMPACT": {
        entity.stuckwithstickygrenade = 1;
        break;
      }
      case "MOD_GRENADE_SPLASH": {
        if(isDefined(entity.stuckwithstickygrenade) && entity.stuckwithstickygrenade) {
          damage = entity.health;
        }
        break;
      }
    }
  }
  if(meansofdamage == "MOD_TRIGGER_HURT" && entity.ignoretriggerdamage) {
    damage = 0;
  }
  return damage;
}

function private robotdestructrandompieces(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity = self;
  isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdamage);
  if(isexplosive) {
    destructserverutils::destructrandompieces(entity);
  }
  return damage;
}

function private findclosestnavmeshpositiontoenemy(enemy) {
  enemypositiononnavmesh = undefined;
  for(tolerancelevel = 1; tolerancelevel <= 4; tolerancelevel++) {
    enemypositiononnavmesh = getclosestpointonnavmesh(enemy.origin, 200 * tolerancelevel, 30);
    if(isDefined(enemypositiononnavmesh)) {
      break;
    }
  }
  return enemypositiononnavmesh;
}

function private robotchoosecoverdirection(entity, stepout) {
  if(!isDefined(entity.node)) {
    return;
  }
  coverdirection = blackboard::getblackboardattribute(entity, "_cover_direction");
  blackboard::setblackboardattribute(entity, "_previous_cover_direction", coverdirection);
  blackboard::setblackboardattribute(entity, "_cover_direction", aiutility::calculatecoverdirection(entity, stepout));
}

function private robotsoldierspawnsetup() {
  entity = self;
  entity.iscrawler = 0;
  entity.becomecrawler = 0;
  entity.combatmode = "cover";
  entity.fullhealth = entity.health;
  entity.controllevel = 0;
  entity.steppedoutofcover = 0;
  entity.ignoretriggerdamage = 0;
  entity.startingweapon = entity.weapon;
  entity.jukedistance = 90;
  entity.jukemaxdistance = 1200;
  entity.entityradius = 15;
  entity.empshutdowntime = 2000;
  entity.nofriendlyfire = 1;
  entity.ignorerunandgundist = 1;
  entity.disablerepath = 0;
  entity.robotrushermaxradius = 250;
  entity.robotrusherminradius = 150;
  entity.gibdeath = math::cointoss();
  entity.minwalkdistance = 240;
  entity.supersprintdistance = 300;
  entity.treatallcoversasgeneric = 1;
  entity.onlycroucharrivals = 1;
  entity.chargemeleedistance = 125;
  entity.allowpushactors = 1;
  entity.nextpreemptivejukeads = randomfloatrange(0.5, 0.95);
  entity.shouldpreemptivejuke = math::cointoss();
  destructserverutils::togglespawngibs(entity, 1);
  gibserverutils::togglespawngibs(entity, 1);
  clientfield::set("robot_mind_control", 0);
  if(getdvarint("")) {
    entity ai::set_behavior_attribute("", "");
  }
  entity thread cleanupequipment(entity);
  aiutility::addaioverridedamagecallback(entity, &destructserverutils::handledamage);
  aiutility::addaioverridedamagecallback(entity, &robotdamageoverride);
  aiutility::addaioverridedamagecallback(entity, &robotdestructrandompieces);
  aiutility::addaioverridedamagecallback(entity, &robotgibdamageoverride);
  aiutility::addaioverridekilledcallback(entity, &robotdeathoverride);
  aiutility::addaioverridekilledcallback(entity, &robotgibdeathoverride);
  aiutility::addaioverridekilledcallback(entity, &robotdestructdeathoverride);
  if(getdvarint("") == 1) {
    entity ai::set_behavior_attribute("", "");
  } else {
    if(getdvarint("") == 2) {
      entity ai::set_behavior_attribute("", "");
    } else if(getdvarint("") == 3) {
      entity ai::set_behavior_attribute("", "");
    }
  }
  if(getdvarint("") == 1) {
    entity ai::set_behavior_attribute("", "");
  } else {
    if(getdvarint("") == 2) {
      entity ai::set_behavior_attribute("", "");
    } else if(getdvarint("") == 3) {
      entity ai::set_behavior_attribute("", "");
    }
  }
  if(getdvarint("ai_robotForceCrawler") == 1) {
    entity ai::set_behavior_attribute("force_crawler", "gib_legs");
  } else if(getdvarint("ai_robotForceCrawler") == 2) {
    entity ai::set_behavior_attribute("force_crawler", "remove_legs");
  }
}

function private robotgivewasp(entity) {
  if(isDefined(entity) && !isDefined(entity.wasp)) {
    wasp = spawn("script_model", (0, 0, 0));
    wasp setModel("veh_t7_drone_attack_red");
    wasp setscale(0.75);
    wasp linkto(entity, "j_spine4", (5, -15, 0), vectorscale((0, 0, 1), 90));
    entity.wasp = wasp;
  }
}

function private robotdeploywasp(entity) {
  entity endon("death");
  wait(randomfloatrange(7, 10));
  if(isDefined(entity) && isDefined(entity.wasp)) {
    spawnoffset = (5, -15, 0);
    while(!ispointinnavvolume(entity.wasp.origin + spawnoffset, "small volume")) {
      wait(1);
    }
    entity.wasp unlink();
    wasp = spawnvehicle("spawner_bo3_wasp_enemy", entity.wasp.origin + spawnoffset, (0, 0, 0));
    entity.wasp delete();
  }
  entity.wasp = undefined;
}

function private rapsdetonatecountdown(entity) {
  entity endon("death");
  wait(randomfloatrange(20, 30));
  raps::detonate();
}

function private becomecrawler(entity) {
  if(!robotsoldierbehavior::robotiscrawler(entity) && entity ai::get_behavior_attribute("can_become_crawler")) {
    entity.becomecrawler = 1;
  }
}

function private cleanupequipment(entity) {
  entity waittill("death");
  if(!isDefined(entity)) {
    return;
  }
  if(isDefined(entity.miniraps)) {
    entity.miniraps = undefined;
  }
  if(isDefined(entity.wasp)) {
    entity.wasp delete();
    entity.wasp = undefined;
  }
}

function private forcerobotsoldiermindcontrollevel1() {
  entity = self;
  if(entity.controllevel >= 1) {
    return;
  }
  entity.team = "team3";
  entity.controllevel = 1;
  clientfield::set("robot_mind_control", 1);
  entity ai::set_behavior_attribute("rogue_control", "level_1");
}

function private forcerobotsoldiermindcontrollevel2() {
  entity = self;
  if(entity.controllevel >= 2) {
    return;
  }
  rogue_melee_weapon = getweapon("rogue_robot_melee");
  locomotiontypes = array("alt1", "alt2", "alt3", "alt4", "alt5");
  blackboard::setblackboardattribute(entity, "_robot_locomotion_type", locomotiontypes[randomint(locomotiontypes.size)]);
  entity asmsetanimationrate(randomfloatrange(0.95, 1.05));
  entity forcerobotsoldiermindcontrollevel1();
  entity.combatmode = "no_cover";
  entity setavoidancemask("avoid none");
  entity.controllevel = 2;
  entity shared::placeweaponon(entity.weapon, "none");
  entity.meleeweapon = rogue_melee_weapon;
  entity.dontdropweapon = 1;
  entity.ignorepathenemyfightdist = 1;
  if(entity ai::get_behavior_attribute("rogue_allow_predestruct")) {
    destructserverutils::destructrandompieces(entity);
  }
  if(entity.health > (entity.maxhealth * 0.6)) {
    entity.health = int(entity.maxhealth * 0.6);
  }
  clientfield::set("robot_mind_control", 2);
  entity ai::set_behavior_attribute("rogue_control", "level_2");
  entity ai::set_behavior_attribute("can_become_crawler", 0);
}

function private forcerobotsoldiermindcontrollevel3() {
  entity = self;
  if(entity.controllevel >= 3) {
    return;
  }
  forcerobotsoldiermindcontrollevel2();
  entity.controllevel = 3;
  clientfield::set("robot_mind_control", 3);
  entity ai::set_behavior_attribute("rogue_control", "level_3");
}

function robotequipminiraps(entity, attribute, oldvalue, value) {
  entity.miniraps = value;
}

function robotlights(entity, attribute, oldvalue, value) {
  if(value == 3) {
    clientfield::set("robot_lights", 3);
  } else {
    if(value == 0) {
      clientfield::set("robot_lights", 0);
    } else {
      if(value == 1) {
        clientfield::set("robot_lights", 1);
      } else {
        if(value == 2) {
          clientfield::set("robot_lights", 2);
        } else if(value == 4) {
          clientfield::set("robot_lights", 4);
        }
      }
    }
  }
}

function randomgibroguerobot(entity) {
  gibserverutils::togglespawngibs(entity, 0);
  if(math::cointoss()) {
    if(math::cointoss()) {
      gibserverutils::gibrightarm(entity);
    } else if(math::cointoss()) {
      gibserverutils::gibleftarm(entity);
    }
  } else {
    if(math::cointoss()) {
      gibserverutils::gibleftarm(entity);
    } else if(math::cointoss()) {
      gibserverutils::gibrightarm(entity);
    }
  }
}

function roguecontrolattributecallback(entity, attribute, oldvalue, value) {
  switch (value) {
    case "forced_level_1": {
      if(entity.controllevel <= 0) {
        forcerobotsoldiermindcontrollevel1();
      }
      break;
    }
    case "forced_level_2": {
      if(entity.controllevel <= 1) {
        forcerobotsoldiermindcontrollevel2();
        destructserverutils::togglespawngibs(entity, 0);
        if(entity ai::get_behavior_attribute("rogue_allow_pregib")) {
          randomgibroguerobot(entity);
        }
      }
      break;
    }
    case "forced_level_3": {
      if(entity.controllevel <= 2) {
        forcerobotsoldiermindcontrollevel3();
        destructserverutils::togglespawngibs(entity, 0);
        if(entity ai::get_behavior_attribute("rogue_allow_pregib")) {
          randomgibroguerobot(entity);
        }
      }
      break;
    }
  }
}

function robotmovemodeattributecallback(entity, attribute, oldvalue, value) {
  entity.ignorepathenemyfightdist = 0;
  blackboard::setblackboardattribute(entity, "_move_mode", "normal");
  if(value != "guard") {
    entity.guardposition = undefined;
  }
  switch (value) {
    case "normal": {
      break;
    }
    case "rambo": {
      entity.ignorepathenemyfightdist = 1;
      break;
    }
    case "marching": {
      entity.ignorepathenemyfightdist = 1;
      blackboard::setblackboardattribute(entity, "_move_mode", "marching");
      break;
    }
    case "rusher": {
      if(!entity ai::get_behavior_attribute("can_become_rusher")) {
        entity ai::set_behavior_attribute("move_mode", oldvalue);
      }
      break;
    }
  }
}

function robotforcecrawler(entity, attribute, oldvalue, value) {
  if(robotsoldierbehavior::robotiscrawler(entity)) {
    return;
  }
  if(!entity ai::get_behavior_attribute("can_become_crawler")) {
    return;
  }
  switch (value) {
    case "normal": {
      return;
      break;
    }
    case "gib_legs": {
      gibserverutils::togglespawngibs(entity, 1);
      destructserverutils::togglespawngibs(entity, 1);
      break;
    }
    case "remove_legs": {
      gibserverutils::togglespawngibs(entity, 0);
      destructserverutils::togglespawngibs(entity, 0);
      break;
    }
  }
  if(value == "gib_legs" || value == "remove_legs") {
    if(math::cointoss()) {
      if(math::cointoss()) {
        gibserverutils::gibrightleg(entity);
      } else {
        gibserverutils::gibleftleg(entity);
      }
    } else {
      gibserverutils::giblegs(entity);
    }
    if(entity.health > (entity.maxhealth * 0.25)) {
      entity.health = int(entity.maxhealth * 0.25);
    }
    destructserverutils::destructrandompieces(entity);
    if(value == "gib_legs") {
      becomecrawler(entity);
    } else {
      robotsoldierbehavior::robotbecomecrawler(entity);
    }
  }
}

function roguecontrolforcegoalattributecallback(entity, attribute, oldvalue, value) {
  if(!isvec(value)) {
    return;
  }
  roguecontrolled = isinarray(array("level_2", "level_3"), entity ai::get_behavior_attribute("rogue_control"));
  if(!roguecontrolled) {
    entity ai::set_behavior_attribute("rogue_control_force_goal", undefined);
  } else {
    entity.favoriteenemy = undefined;
    entity clearpath();
    entity useposition(entity ai::get_behavior_attribute("rogue_control_force_goal"));
  }
}

function roguecontrolspeedattributecallback(entity, attribute, oldvalue, value) {
  switch (value) {
    case "walk": {
      blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_walk");
      break;
    }
    case "run": {
      blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_run");
      break;
    }
    case "sprint": {
      blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
      break;
    }
  }
}

function robottraversalattributecallback(entity, attribute, oldvalue, value) {
  switch (value) {
    case "normal": {
      entity.manualtraversemode = 0;
      break;
    }
    case "procedural": {
      entity.manualtraversemode = 1;
      break;
    }
  }
}