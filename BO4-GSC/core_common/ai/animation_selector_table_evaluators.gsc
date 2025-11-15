/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\animation_selector_table_evaluators.gsc
******************************************************************/

#include scripts\core_common\ai\systems\animation_selector_table;

#namespace animation_selector_table_evaluators;

autoexec registerastscriptfunctions() {
  animationselectortable::registeranimationselectortableevaluator("testFunction", &testfunction);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", &evaluateblockedanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsRelaxed", &evaluateblockedanimationsrelaxed);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsOffNavmesh", &evaluateblockedanimationsoffnavmesh);
  animationselectortable::registeranimationselectortableevaluator("evaluateHumanTurnAnimations", &evaluatehumanturnanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateHumanExposedArrivalAnimations", &evaluatehumanexposedarrivalanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateJukeBlockedAnimations", &evaluatejukeblockedanimations);
}

testfunction(entity, animations) {
  if(isarray(animations) && animations.size > 0) {
    return animations[0];
  }
}

private function_aa7530df(entity, animation) {
  pixbeginevent(#"evaluator_checkanimationagainstgeo");
  assert(isactor(entity));
  forwarddir = anglesToForward(entity.angles);
  localdeltavector = getmovedelta(animation, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);
  forwardpoint = endpoint + vectorscale(forwarddir, 100);

  recordline(entity.origin, endpoint, (0, 0, 1), "<dev string:x38>", entity);
  recordline(endpoint, forwardpoint, (1, 0.5, 0), "<dev string:x38>", entity);

  if(entity maymovefrompointtopoint(endpoint, forwardpoint, 1, 1)) {
    pixendevent();
    return true;
  }

  pixendevent();
  return false;
}

private evaluatejukeblockedanimations(entity, animations) {
  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &function_aa7530df, &evaluator_checkanimationforovershootinggoal));
  }
}

private evaluator_checkanimationagainstgeo(entity, animation) {
  pixbeginevent(#"evaluator_checkanimationagainstgeo");
  assert(isactor(entity));
  localdeltahalfvector = getmovedelta(animation, 0, 0.5, entity);
  midpoint = entity localtoworldcoords(localdeltahalfvector);
  midpoint = (midpoint[0], midpoint[1], entity.origin[2]);

  recordline(entity.origin, midpoint, (1, 0.5, 0), "<dev string:x38>", entity);

  if(entity maymovetopoint(midpoint, 1, 1)) {
    localdeltavector = getmovedelta(animation, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    endpoint = (endpoint[0], endpoint[1], entity.origin[2]);

    recordline(midpoint, endpoint, (1, 0.5, 0), "<dev string:x38>", entity);

    if(entity maymovefrompointtopoint(midpoint, endpoint, 1, 1)) {
      pixendevent();
      return true;
    }
  }

  pixendevent();
  return false;
}

private evaluator_checkanimationendpointagainstgeo(entity, animation) {
  pixbeginevent(#"evaluator_checkanimationendpointagainstgeo");
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

private evaluator_checkanimationforovershootinggoal(entity, animation) {
  pixbeginevent(#"evaluator_checkanimationforovershootinggoal");
  assert(isactor(entity));
  localdeltavector = getmovedelta(animation, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);
  animdistsq = lengthsquared(localdeltavector);

  if(entity haspath()) {
    startpos = entity.origin;
    goalpos = entity.pathgoalpos;
    assert(isDefined(goalpos));
    disttogoalsq = distancesquared(startpos, goalpos);

    if(animdistsq < disttogoalsq * 0.9) {
      pixendevent();
      return true;
    }
  }

  record3dtext("<dev string:x45>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

  pixendevent();
  return false;
}

private evaluator_checkanimationagainstnavmesh(entity, animation) {
  assert(isactor(entity));
  localdeltavector = getmovedelta(animation, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);

  if(ispointonnavmesh(endpoint, entity)) {
    return true;
  }

  record3dtext("<dev string:x5e>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

  return false;
}

private evaluator_checkanimationarrivalposition(entity, animation) {
  localdeltavector = getmovedelta(animation, 0, 1, entity);
  endpoint = entity localtoworldcoords(localdeltavector);
  animdistsq = lengthsquared(localdeltavector);
  startpos = entity.origin;
  goalpos = entity.pathgoalpos;
  disttogoalsq = distancesquared(startpos, goalpos);

  if(disttogoalsq < animdistsq) {
    if(isDefined(entity.ai.var_a5dabb8b) && entity.ai.var_a5dabb8b) {
      return true;
    }

    if(entity isposatgoal(endpoint)) {
      return true;
    }
  }

  return false;
}

private evaluator_findfirstvalidanimation(entity, animations, tests) {
  assert(isarray(animations), "<dev string:x75>");
  assert(isarray(tests), "<dev string:xb5>");

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

private evaluateblockedanimations(entity, animations) {
  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal));
  }

  return undefined;
}

private evaluateblockedanimationsrelaxed(entity, animations) {
  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal));
  }

  return undefined;
}

private evaluateblockedanimationsoffnavmesh(entity, animations) {
  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstgeo));
  }

  return undefined;
}

private evaluatehumanturnanimations(entity, animations) {
  if(isDefined(level.ai_dontturn) && level.ai_dontturn) {
    return undefined;
  }

  record3dtext("<dev string:xfe>" + gettime() + "<dev string:x101>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal, &evaluator_checkanimationagainstgeo, &evaluator_checkanimationagainstnavmesh));
  }

  return undefined;
}

private evaluatehumanexposedarrivalanimations(entity, animations) {
  if(!isDefined(entity.pathgoalpos)) {
    return undefined;
  }

  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationarrivalposition));
  }

  return undefined;
}