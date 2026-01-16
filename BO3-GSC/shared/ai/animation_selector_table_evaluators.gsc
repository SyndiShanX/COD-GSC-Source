/*************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\animation_selector_table_evaluators.gsc
*************************************************************/

#using scripts\shared\ai\systems\animation_selector_table;
#using scripts\shared\array_shared;
#namespace animation_selector_table_evaluators;

function autoexec registerastscriptfunctions() {
  animationselectortable::registeranimationselectortableevaluator("testFunction", & testfunction);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", & evaluateblockedanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateHumanTurnAnimations", & evaluatehumanturnanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateHumanExposedArrivalAnimations", & evaluatehumanexposedarrivalanimations);
}

function testfunction(entity, animations) {
  if(isarray(animations) && animations.size > 0) {
    return animations[0];
  }
}

function private evaluator_checkanimationagainstgeo(entity, animation) {
  pixbeginevent("Evaluator_CheckAnimationAgainstGeo");
  assert(isactor(entity));
  localdeltahalfvector = getmovedelta(animation, 0, 0.5, entity);
  midpoint = entity localtoworldcoords(localdeltahalfvector);
  midpoint = (midpoint[0], midpoint[1], entity.origin[2]);
  recordline(entity.origin, midpoint, (1, 0.5, 0), "", entity);
  if(entity maymovetopoint(midpoint, 1, 1)) {
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
    recordline(midpoint, endpoint, (1, 0.5, 0), "", entity);
    if(entity maymovefrompointtopoint(midpoint, endpoint, 1, 1)) {
      pixendevent();
      return true;
    }
  }
  pixendevent();
  return false;
}

function private evaluator_checkanimationendpointagainstgeo(entity, animation) {
  pixbeginevent("Evaluator_CheckAnimationEndPointAgainstGeo");
  assert(isactor(entity));
  localdeltavector = getmovedelta(animation, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);
  endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
  if(entity maymovetopoint(endpoint, 0, 0)) {
    pixendevent();
    return true;
  }
  pixendevent();
  return false;
}

function private evaluator_checkanimationforovershootinggoal(entity, animation) {
  pixbeginevent("Evaluator_CheckAnimationForOverShootingGoal");
  assert(isactor(entity));
  localdeltavector = getmovedelta(animation, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);
  animdistsq = lengthsquared(localdeltavector);
  if(entity haspath()) {
    startpos = entity.origin;
    goalpos = entity.pathgoalpos;
    assert(isdefined(goalpos));
    disttogoalsq = distancesquared(startpos, goalpos);
    if(animdistsq < disttogoalsq) {
      pixendevent();
      return true;
    }
  }
  pixendevent();
  return false;
}

function private evaluator_checkanimationagainstnavmesh(entity, animation) {
  assert(isactor(entity));
  localdeltavector = getmovedelta(animation, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);
  if(ispointonnavmesh(endpoint, entity)) {
    return true;
  }
  return false;
}

function private evaluator_checkanimationarrivalposition(entity, animation) {
  localdeltavector = getmovedelta(animation, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);
  animdistsq = lengthsquared(localdeltavector);
  startpos = entity.origin;
  goalpos = entity.pathgoalpos;
  disttogoalsq = distancesquared(startpos, goalpos);
  return disttogoalsq < animdistsq && entity isposatgoal(endpoint);
}

function private evaluator_findfirstvalidanimation(entity, animations, tests) {
  assert(isarray(animations), "");
  assert(isarray(tests), "");
  foreach(aliasanimations in animations) {
    if(aliasanimations.size > 0) {
      valid = 1;
      animation = aliasanimations[0];
      foreach(test in tests) {
        if(![
            [test]
          ](entity, animation)) {
          valid = 0;
          break;
        }
      }
      if(valid) {
        return animation;
      }
    }
  }
}

function private evaluateblockedanimations(entity, animations) {
  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array( & evaluator_checkanimationagainstgeo, & evaluator_checkanimationforovershootinggoal));
  }
  return undefined;
}

function private evaluatehumanturnanimations(entity, animations) {
  if(isdefined(level.ai_dontturn) && level.ai_dontturn) {
    return undefined;
  }
  record3dtext(("" + gettime()) + "", entity.origin, (1, 0.5, 0), "", entity);
  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array( & evaluator_checkanimationforovershootinggoal, & evaluator_checkanimationagainstgeo, & evaluator_checkanimationagainstnavmesh));
  }
  return undefined;
}

function private evaluatehumanexposedarrivalanimations(entity, animations) {
  if(!isdefined(entity.pathgoalpos)) {
    return undefined;
  }
  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array( & evaluator_checkanimationarrivalposition));
  }
  return undefined;
}