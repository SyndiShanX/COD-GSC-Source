/******************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\animation_selector_table_evaluators.gsc
******************************************************************/

#using scripts\core_common\ai\systems\animation_selector_table;
#using scripts\core_common\animation_shared;
#namespace animation_selector_table_evaluators;

function autoexec registerastscriptfunctions() {
  animationselectortable::registeranimationselectortableevaluator("testFunction", &testfunction);
  animationselectortable::registeranimationselectortableevaluator("evaluateMoveToCQBAnimations", &evaluatemovetocqbanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", &evaluateblockedanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedCoverArrivalAnimations", &evaluateblockedcoverarrivalanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedCoverExitAnimations", &evaluateblockedcoverexitanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedNoStairsAnimations", &evaluateblockednostairsanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsRelaxed", &evaluateblockedanimationsrelaxed);
  animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsOffNavmesh", &evaluateblockedanimationsoffnavmesh);
  animationselectortable::registeranimationselectortableevaluator("evaluateHumanTurnAnimations", &evaluatehumanturnanimations);
  animationselectortable::registeranimationselectortableevaluator("matchPrePlannedTurn", &matchpreplannedturn);
  animationselectortable::registeranimationselectortableevaluator("planHumanTurnAnimations", &planhumanturnanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateHumanExposedArrivalAnimations", &evaluatehumanexposedarrivalanimations);
  animationselectortable::registeranimationselectortableevaluator("evaluateJukeBlockedAnimations", &evaluatejukeblockedanimations);
  animationselectortable::registeranimationselectortableevaluator("humanDeathEvaluation", &humandeathevaluation);
}

function testfunction(entity, animations) {
  if(isarray(animations) && animations.size > 0) {
    return animations[0];
  }
}

function private function_aa7530df(entity, animation) {
  pixbeginevent(#"");
  assert(isactor(entity));
  forwarddir = anglesToForward(entity.angles);
  localdeltavector = getmovedelta(animation, 0, 1);
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

function private evaluatejukeblockedanimations(entity, animations) {
  if(animations.size > 0) {
    return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &function_aa7530df, &evaluator_checkanimationforovershootinggoal));
  }
}

function private evaluator_checkanimationagainstgeo(entity, animation) {
  pixbeginevent(#"");
  assert(isactor(entity));
  splittime = function_382b0cfb(animation);
  localdeltahalfvector = getmovedelta(animation, 0, splittime);
  midpoint = entity localtoworldcoords(localdeltahalfvector);
  midpoint = (midpoint[0], midpoint[1], entity.origin[2] + 6);

  recordline(entity.origin, midpoint, (1, 0.5, 0), "<dev string:x38>", entity);

  if(entity maymovetopoint(midpoint, 1, 1, entity, 0.05)) {
    localdeltavector = getmovedelta(animation, 0, 1);
    endpoint = entity localtoworldcoords(localdeltavector);
    endpoint = (endpoint[0], endpoint[1], entity.origin[2] + 6);

    recordline(midpoint, endpoint, (1, 0.5, 0), "<dev string:x38>", entity);

    if(entity maymovefrompointtopoint(midpoint, endpoint, 1, 1, entity, 0.05)) {
      pixendevent();
      return true;
    }
  }

  pixendevent();
  return false;
}

function private evaluator_checkanimationendpointagainstgeo(entity, animation) {
  pixbeginevent(#"");
  assert(isactor(entity));
  localdeltavector = getmovedelta(animation, 0, 1);
  var_e21fa5a4 = entity.angles + (0, entity function_144f21ef(), 0);
  endpoint = coordtransform(localdeltavector, entity.origin, var_e21fa5a4);
  endpoint = (endpoint[0], endpoint[1], entity.origin[2]);

  if(entity maymovetopoint(endpoint, 0, 0)) {
    pixendevent();
    return true;
  }

  pixendevent();
  return false;
}

function private function_91a832bb(entity, animation) {
  localdeltavector = getmovedelta(animation, 0, 1);
  var_f0ccb726 = lengthsquared(localdeltavector);

  if(var_f0ccb726 > sqr(entity getpathlength())) {
    return false;
  }

  splittime = function_382b0cfb(animation);
  localdeltavector = getmovedelta(animation, 0, splittime);
  var_773216e9 = length(localdeltavector);
  disttocorner = distance2d(entity.origin, entity.var_14b548c5);

  if(var_773216e9 >= disttocorner && var_773216e9 < disttocorner * 1.2) {
    return true;
  }

  return false;
}

function private function_3c7d2020(entity, animation) {
  if(animhasnotetrack(animation, "corner")) {
    return 1;
  }

  return evaluator_checkanimationforovershootinggoal(entity, animation);
}

function private evaluator_checkanimationforovershootinggoal(entity, animation) {
  pixbeginevent(#"");
  assert(isactor(entity));

  if(entity haspath()) {
    startpos = entity.origin;
    goalpos = entity.var_14b548c5;
    assert(isDefined(goalpos));
    disttogoalsq = distance2dsquared(startpos, goalpos);
    localdeltavector = getmovedelta(animation, 0, 1);
    animdistsq = lengthsquared(localdeltavector);

    if(entity.traversalstartdist > 0 && animdistsq > sqr(entity.traversalstartdist)) {
      pixendevent();
      return false;
    } else if((isDefined(entity.var_c4c50a0b) ? entity.var_c4c50a0b : 0) && animdistsq > disttogoalsq) {
      pixendevent();
      return false;
    }

    codemovetime = function_199662d1(animation);
    localdeltavector = getmovedelta(animation, 0, codemovetime);
    animdistsq = lengthsquared(localdeltavector);

    if(entity.isarrivalpending && distance2dsquared(startpos, entity.overridegoalpos) < disttogoalsq) {
      goalpos = entity.overridegoalpos;
      disttogoalsq = distance2dsquared(startpos, goalpos);
    }

    if(animdistsq < disttogoalsq * 0.9) {
      pixendevent();
      return true;
    }

    record3dtext("<dev string:x46>" + function_9e72a96(animation) + "<dev string:x63>" + sqrt(animdistsq) + "<dev string:x72>" + sqrt(disttogoalsq), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.4);
  } else {
    record3dtext("<dev string:x83>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.4);
  }

  pixendevent();
  return false;
}

function private function_da29fa63(entity, animation) {
  pixbeginevent(#"hash_4de9b510d8b94b2c");
  assert(isactor(entity));

  if(isDefined(entity.node)) {
    if(entity haspath()) {
      startpos = entity.origin;
      goalpos = entity getnodeoffsetposition(entity.node);
      disttogoalsq = distance2dsquared(startpos, goalpos);
      localdeltavector = getmovedelta(animation, 0, 1);
      animdistsq = lengthsquared(localdeltavector);

      if(animdistsq <= disttogoalsq) {
        pixendevent();
        return true;
      }
    }

    record3dtext("<dev string:xa7>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);
  }

  pixendevent();
  return false;
}

function private function_89b21ba9(entity, animation) {
  assert(isactor(entity));
  localdeltavector = getmovedelta(animation, 0, 1);
  endpoint = coordtransform(localdeltavector, entity.origin, entity.angles);

  if(!ispointonstairs(endpoint)) {
    return true;
  }

  record3dtext("<dev string:xc0>" + endpoint, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

  return false;
}

function private function_8bd6d54d(entity, animation) {
  assert(isactor(entity));
  maxdist = entity getpathfindingradius() * 2;
  maxdistsq = sqr(maxdist);
  localdeltavector = getmovedelta(animation, 0, 1);
  endpoint = entity localtoworldcoords(localdeltavector);
  radius = length(localdeltavector) + maxdist;
  allies = function_e45cbe76(entity.origin, radius, entity.team);

  foreach(ally in allies) {
    if(ally != entity) {
      var_6560f463 = function_39ceb9d4(entity.origin, endpoint, ally.origin);

      if(var_6560f463 < maxdistsq) {
        record3dtext("<dev string:xd5>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

        return false;
      }
    }
  }

  return true;
}

function private evaluator_checkanimationagainstnavmesh(entity, animation) {
  assert(isactor(entity));
  localdeltavector = getmovedelta(animation, 0, 1);
  var_e21fa5a4 = entity.angles + (0, entity function_144f21ef(), 0);
  endpoint = coordtransform(localdeltavector, entity.origin, var_e21fa5a4);

  if(ispointonnavmesh(endpoint)) {
    return true;
  }

  record3dtext("<dev string:xf5>" + endpoint, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

  return false;
}

function function_50c1352d(entity, animation) {
  localdeltavector = getmovedelta(animation, 0, 1);
  animdistsq = lengthsquared(localdeltavector);
  goalpos = entity.pathgoalpos;
  disttogoalsq = distance2dsquared(entity.origin, goalpos);

  if(disttogoalsq <= animdistsq && abs(goalpos[2] - entity.origin[2]) < 48) {
    if(is_true(entity.ai.var_a5dabb8b)) {
      return true;
    }

    var_4da2186 = coordtransform(localdeltavector, entity.origin, entity.angles);

    if(distance2dsquared(goalpos, var_4da2186) < sqr(16) && abs(goalpos[2] - var_4da2186[2]) < 48) {
      return true;
    }
  }

  return false;
}

function evaluator_findfirstvalidanimation(entity, animations, tests) {
  assert(isarray(animations), "<dev string:x10e>");
  assert(isarray(tests), "<dev string:x14f>");

  foreach(aliasanimations in animations) {
    if(aliasanimations.size > 0) {
      valid = 1;
      animation = aliasanimations[0];

      foreach(test in tests) {
        if(![[test]](entity, animation)) {
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

function private evaluatemovetocqbanimations(entity, animations) {
  if(is_true(entity.var_81238017)) {
    return undefined;
  }

  anim = evaluateblockedanimations(entity, animations);

  if(isDefined(anim)) {
    record3dtext("<dev string:x199>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);
  } else {
    record3dtext("<dev string:x1bd>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);
  }

  return anim;
}

function private evaluateblockedanimations(entity, animations) {
  if(animations.size > 0) {
    anim = evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal));

    if(isDefined(anim)) {
      record3dtext("<dev string:x1ea>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

      return anim;
    }
  }

  record3dtext("<dev string:x20c>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

  return undefined;
}

function private evaluateblockedcoverarrivalanimations(entity, animations) {
  if(animations.size > 0) {
    anim = evaluator_findfirstvalidanimation(entity, animations, array(&function_da29fa63));

    if(isDefined(anim)) {
      record3dtext("<dev string:x237>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

      return anim;
    }
  }

  record3dtext("<dev string:x265>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

  return undefined;
}

function private evaluateblockedcoverexitanimations(entity, animations) {
  if(animations.size > 0) {
    anim = evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &function_3c7d2020, &function_89b21ba9, &function_8bd6d54d));

    if(isDefined(anim)) {
      record3dtext("<dev string:x29c>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

      return anim;
    }
  }

  record3dtext("<dev string:x2c7>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

  return undefined;
}

function private evaluateblockednostairsanimations(entity, animations) {
  if(animations.size > 0) {
    anim = evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal, &function_89b21ba9));

    if(isDefined(anim)) {
      record3dtext("<dev string:x2fb>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

      return anim;
    }
  }

  record3dtext("<dev string:x325>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

  return undefined;
}

function private evaluateblockedanimationsrelaxed(entity, animations) {
  if(animations.size > 0) {
    anim = evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal));

    if(isDefined(anim)) {
      record3dtext("<dev string:x358>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

      return anim;
    }
  }

  record3dtext("<dev string:x325>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

  return undefined;
}

function private evaluateblockedanimationsoffnavmesh(entity, animations) {
  if(animations.size > 0) {
    anim = evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstgeo));

    if(isDefined(anim)) {
      record3dtext("<dev string:x381>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

      return anim;
    }
  }

  record3dtext("<dev string:x3ad>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

  return undefined;
}

function private evaluatehumanturnanimations(entity, animations) {
  if(is_true(level.ai_dontturn)) {
    return undefined;
  }

  record3dtext("<dev string:x3e2>" + gettime() + "<dev string:x3e6>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

  if(animations.size > 0) {
    anim = evaluator_findfirstvalidanimation(entity, animations, array(&function_91a832bb, &evaluator_checkanimationagainstgeo, &evaluator_checkanimationagainstnavmesh));

    if(isDefined(anim)) {
      record3dtext("<dev string:x3fa>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

      return anim;
    }
  }

  record3dtext("<dev string:x41e>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);

  return undefined;
}

function evaluatehumanexposedarrivalanimations(entity, animations) {
  if(isDefined(entity.pathgoalpos)) {
    if(animations.size > 0) {
      var_5e259f59 = evaluator_findfirstvalidanimation(entity, animations, array(&function_50c1352d));

      if(isDefined(var_5e259f59)) {
        record3dtext("<dev string:x44b>" + function_9e72a96(var_5e259f59), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);
      } else {
        record3dtext("<dev string:x479>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);
      }

      return var_5e259f59;
    }
  } else if(!entity haspath() && !isDefined(entity.node)) {
    if(animations.size > 0) {
      foreach(aliasanimations in animations) {
        if(aliasanimations.size > 0) {
          anim = aliasanimations[0];

          if(isDefined(anim)) {
            record3dtext("<dev string:x44b>" + function_9e72a96(anim), entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);
          } else {
            record3dtext("<dev string:x479>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity, 0.65);
          }

          return anim;
        }
      }
    }
  }

  return undefined;
}

function private function_199662d1(animation) {
  codemovetime = 1;

  if(animhasnotetrack(animation, "code_move")) {
    times = getnotetracktimes(animation, "code_move");
    codemovetime = times[0];
  } else if(animhasnotetrack(animation, "mocomp_end")) {
    times = getnotetracktimes(animation, "mocomp_end");
    codemovetime = times[0];
  }

  return codemovetime;
}

function private function_382b0cfb(animation) {
  splittime = 0.5;

  if(animhasnotetrack(animation, "corner")) {
    times = getnotetracktimes(animation, "corner");
    assert(times.size == 1, "<dev string:x4b0>" + function_9e72a96(animation) + "<dev string:x4bf>" + "<dev string:x4de>" + "<dev string:x4e8>");
    splittime = times[0];
  }

  return splittime;
}

function private matchpreplannedturn(entity, animations) {
  if(isDefined(entity.var_7b1f015a.animation)) {
    for(i = 0; i < animations.size; i++) {
      if(animations[i][0] == entity.var_7b1f015a.animation) {
        return animations[i][0];
      }
    }
  }

  return undefined;
}

function private planhumanturnanimations(entity, animations) {
  if(!isDefined(entity.var_7b1f015a)) {
    entity.var_7b1f015a = {};
  }

  if(animations.size > 0) {
    var_bff64930 = evaluator_findfirstvalidanimation(entity, animations, array(&function_147224));
    entity.var_7b1f015a.animation = var_bff64930;

    if(isDefined(var_bff64930)) {
      splittime = function_382b0cfb(var_bff64930);
      halftime = splittime * 0.5;
      speed = animation::function_a23b2a60(var_bff64930, 0, halftime);

      record3dtext("<dev string:x3e2>" + gettime() + "<dev string:x4f7>" + function_9e72a96(var_bff64930) + "<dev string:x50e>" + speed, entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

      entity.var_3b77553e = speed;
      entity.var_7b1f015a.pos = entity.var_14b548c5;
      entity.var_7b1f015a.angle = entity.var_871c9e86;
      entity.var_7b1f015a.var_568d90d2 = function_15a5703b(#"human", entity function_359fd121());
      return var_bff64930;
    } else {
      record3dtext("<dev string:x3e2>" + gettime() + "<dev string:x51b>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

      entity.var_3b77553e = -1;
    }

    return var_bff64930;
  }

  record3dtext("<dev string:x3e2>" + gettime() + "<dev string:x540>", entity.origin, (1, 0.5, 0), "<dev string:x38>", entity);

  entity.var_3b77553e = -1;
  return undefined;
}

function private function_fe8e7e36(point) {
  if(abs(self.pathgoalpos[2] - self.origin[2]) > 0.5) {
    trace = groundtrace(point + (0, 0, 72), point + (0, 0, -72), 0, 0, 0);
    point = (point[0], point[1], trace[# "position"][2] + 6);
  }

  return point;
}

function private function_147224(entity, animation) {
  pixbeginevent(#"");
  assert(isactor(entity));
  midpoint = (entity.var_14b548c5[0], entity.var_14b548c5[1], entity.origin[2] + 6);
  midpoint = entity function_fe8e7e36(midpoint);
  splittime = function_382b0cfb(animation);
  localdeltahalfvector = getmovedelta(animation, 0, splittime);
  var_3f5aa15b = distance2dsquared(entity.origin, midpoint);

  if(var_3f5aa15b > 0 && var_3f5aa15b < length2dsquared(localdeltahalfvector)) {
    pixendevent();
    return false;
  }

  entrypoint = midpoint + vectornormalize(entity.origin - midpoint) * length(localdeltahalfvector);
  entrypoint = entity function_fe8e7e36(entrypoint);

  if(entity maymovefrompointtopoint(entrypoint, midpoint, 1, 1, entity, 0.75)) {
    recordline(midpoint, entrypoint, (1, 0.5, 0), "<dev string:x38>", entity);

    codemovetime = function_199662d1(animation);
    var_16ebe729 = getmovedelta(animation, 0, codemovetime);
    var_d66f5018 = vectortoangles(midpoint - entrypoint);
    endpoint = coordtransform(var_16ebe729, entrypoint, var_d66f5018);
    endpoint = entity function_fe8e7e36(endpoint);

    if(entity maymovefrompointtopoint(midpoint, endpoint, 1, 1, entity, 0.75)) {
      recordline(midpoint, endpoint, (0, 1, 0), "<dev string:x38>", entity);

      pixendevent();
      return true;
    } else {
      recordline(midpoint, endpoint, (1, 0, 0), "<dev string:x38>", entity);
    }
  } else {
    recordline(midpoint, entrypoint, (1, 0, 0), "<dev string:x38>", entity);
  }

  pixendevent();
  return false;
}

function private humandeathevaluation(entity, animations) {
  var_bec12c3d = 0;

  if((isDefined(self.script_longdeath) ? self.script_longdeath : 1) == 0 || (isDefined(level.var_d03f21c6) ? level.var_d03f21c6 : 0) > gettime()) {
    var_bec12c3d = 1;
  }

  var_f4e2809d = undefined;

  if(var_bec12c3d) {
    validcount = 0;

    for(i = 0; i < animations.size; i++) {
      length = getanimlength(animations[i]);

      if(length < 4) {
        validcount++;

        if(randomint(validcount) == validcount - 1) {
          var_f4e2809d = animations[i];
        }
      }
    }
  } else {
    randomindex = randomint(animations.size);
    var_f4e2809d = animations[randomindex];
    length = getanimlength(var_f4e2809d);

    if(length >= 4) {
      level.var_d03f21c6 = gettime() + 30000;
    }
  }

  return var_f4e2809d;
}