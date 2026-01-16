/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\_interactive_utility.gsc
************************************************************/

#include common_scripts\utility;

delete_on_notify(ent, notify1, notify2, notify3) {
  ent endon("death");
  self waittill_any(notify1, notify2, notify3);
  if(isDefined(ent))
    ent Delete();
}

array_sortByArray(array, sorters) {
  newArray = [];
  newArray[0] = array[0];
  newSorters = [];
  newSorters[0] = sorters[0];
  for(i = 1; i < array.size; i++) {
    sorted = false;
    for(j = 0; j < newArray.size; j++) {
      if(sorters[i] < newSorters[j]) {
        for(k = newArray.size - 1; k >= j; k--) {
          newArray[k + 1] = newArray[k];
          newSorters[k + 1] = newSorters[k];
        }
        newArray[j] = array[i];
        newSorters[j] = sorters[i];
        sorted = true;
        break;
      }
    }
    if(!sorted) {
      newArray[i] = array[i];
      newSorters[i] = sorters[i];
    }
  }
  return newArray;
}

array_sortBySorter(array) {
  newArray = [];
  newArray[0] = array[0];
  for(i = 1; i < array.size; i++) {
    sorted = false;
    for(j = 0; j < newArray.size; j++) {
      if(array[i].sorter < newArray[j].sorter) {
        for(k = newArray.size - 1; k >= j; k--) {
          newArray[k + 1] = newArray[k];
        }
        newArray[j] = array[i];
        sorted = true;
        break;
      }
    }
    if(!sorted) {
      newArray[i] = array[i];
    }
  }
  return newArray;
}

wait_then_fn(notifyStr, enders, fn, arg1, arg2, arg3, arg4) {
  self endon("death");
  if(isDefined(enders)) {
    if(IsArray(enders)) {
      foreach(ender in enders) {
        self endon(ender);
      }
    } else {
      self endon(enders);
    }
  }
  if(isString(notifyStr))
    self waittill(notifyStr);
  else
    wait(notifyStr);
  if(isDefined(arg4))
    self[[fn]](arg1, arg2, arg3, arg4);
  else if(isDefined(arg3))
    self[[fn]](arg1, arg2, arg3);
  else if(isDefined(arg2))
    self[[fn]](arg1, arg2);
  else if(isDefined(arg1))
    self[[fn]](arg1);
  else
    self[[fn]]();
}

waittill_notify(waitStr, notifyEnt, notifyStr, ender, multiple) {
  if(!isDefined(multiple)) multiple = false;
  doItAgain = true;
  while(doItAgain) {
    self endon("death");
    if(isDefined(ender)) self endon(ender);
    self waittill(waitStr);
    notifyEnt notify(notifyStr);
    doItAgain = multiple;
  }
}

loop_anim(animArray, animName, ender, animRate) {
  self endon("death");
  if(isDefined(ender)) self endon(ender);

  while(1) {
    a = self single_anim(animArray, animName, "loop_anim", false, animRate);
    if(isSP()) {
      self waittillmatch("loop_anim", "end");
    } else {
      wait GetAnimLength(a);
    }
  }
}

single_anim(animArray, animName, notifyStr, restartAnim, animRate) {
  if(!isDefined(notifyStr)) notifyStr = "single_anim";
  if(!isDefined(animRate)) animRate = 1;

  if(IsArray(animArray[animName])) {
    if(!isDefined(animArray[(animName + "weight")])) {
      animArray[(animName + "weight")] = [];
      keys = GetArrayKeys(animArray[animName]);
      foreach(key in keys) {
        animArray[(animName + "weight")][key] = 1;
      }
    }
    AssertEx(IsArray(animArray[(animName + "weight")]), "Array of anim weights labeled \"" + animName + "weight\" is not an array.");
    AssertEx(animArray[(animName + "weight")].size == animArray[animName].size, "Array of anims labeled \"" + animName + "\" does not have a matching array of weights.");
    numAnims = animArray[animName].size;
    totalWeight = 0;
    for(i = 0; i < numAnims; i++) {
      totalWeight += animArray[(animName + "weight")][i];
    }
    rand = RandomFloat(totalWeight);
    runningWeight = 0;
    sel = -1;
    while(runningWeight <= rand) {
      sel++;
      runningWeight += animArray[(animName + "weight")][sel];
    }
    animation = animArray[animName][sel];
    if(isDefined(animArray[animName + "mp"])) {
      animation_mp = animArray[animName + "mp"][sel];
    } else {
      animation_mp = undefined;
    }
  } else {
    animation = animArray[animName];
    animation_mp = animArray[animName + "mp"];
  }
  if(isSP()) {
    if(isDefined(restartAnim) && restartAnim)
      self call[[level.func["setflaggedanimknobrestart"]]](notifyStr, animation, 1, 0.1, animRate);
    else
      self call[[level.func["setflaggedanimknob"]]](notifyStr, animation, 1, 0.1, animRate);
  } else {
    self call[[level.func["scriptModelPlayAnim"]]](animation_mp);
  }
  return animation;
}

blendAnimsBySpeed(speed, anims, animSpeeds, animLengths, blendTime) {
  Assert(anims.size == animSpeeds.size && anims.size == animLengths.size);
  for(i = 1; i < animSpeeds.size; i++)
    Assert(animSpeeds[i - 1] < animSpeeds[i]);

  if(!isDefined(blendTime)) blendTime = 0.1;

  speed = clamp(speed, animSpeeds[0], animSpeeds[animSpeeds.size - 1]);
  i = 0;
  while(speed > animSpeeds[i + 1]) {
    i++;
  }
  fastWeight = speed - animSpeeds[i];
  fastWeight /= animSpeeds[i + 1] - animSpeeds[i];
  if(isSP()) {
    fastWeight = clamp(fastWeight, 0.01, 0.99);

    speedRatio = animLengths[i + 1] / animLengths[i];
    fastRate = fastWeight + ((1 - fastWeight) * speedRatio);
    self call[[level.func["setanimlimited"]]](anims[i], 1 - fastWeight, blendTime, fastRate / speedRatio);
    self call[[level.func["setanimlimited"]]](anims[i + 1], fastWeight, blendTime, fastRate);
    for(j = 0; j < i; j++) {
      speedRatio = animLengths[i + 1] / animLengths[j];
      self call[[level.func["setanimlimited"]]](anims[j], 0.01, blendTime, fastRate / speedRatio);
    }
    for(j = i + 2; j < animSpeeds.size; j++) {
      speedRatio = animLengths[i + 1] / animLengths[j];
      self call[[level.func["setanimlimited"]]](anims[j], 0.01, blendTime, fastRate / speedRatio);
    }
  } else {
    if(fastWeight > 0.5) {
      self call[[level.func["scriptModelPlayAnim"]]](anims[i + 1]);
    } else {
      self call[[level.func["scriptModelPlayAnim"]]](anims[i]);
    }
  }
}

detect_events(notifyString) {
  if(isSP()) {
    self endon("death");
    self endon("damage");
    self call[[level.makeEntitySentient_func]]("neutral");
    self call[[level.addAIEventListener_func]]("projectile_impact");
    self call[[level.addAIEventListener_func]]("bulletwhizby");
    self call[[level.addAIEventListener_func]]("gunshot");
    self call[[level.addAIEventListener_func]]("explode");

    while(1) {
      self waittill("ai_event", eventtype);
      self notify(notifyString);
      self.interrupted = true;
      waittillframeend;
      self.interrupted = false;
    }
  }
}

detect_people(radius, notifyStr, endonStr) {
  if(!IsArray(endonStr)) {
    tempStr = endonStr;
    endonStr = [];
    endonStr[0] = tempStr;
  }
  foreach(str in endonStr)
  self endon(str);

  self.detect_people_trigger[notifyStr] = spawn("trigger_radius", self.origin, 23, radius, radius);

  for(i = endonStr.size; i < 3; i++)
    endonStr[i] = undefined;
  self thread delete_on_notify(self.detect_people_trigger[notifyStr], endonStr[0], endonStr[1], endonStr[2]);

  while(1) {
    self.detect_people_trigger[notifyStr] waittill("trigger", interruptedEnt);
    self.interruptedEnt = interruptedEnt;
    self notify(notifyStr);
    self.interrupted = true;
    waittillframeend;
    self.interrupted = false;
  }
}

detect_player_event(radius, notifyStr, endonStr, eventStr) {
  if(!IsArray(endonStr)) {
    tempStr = endonStr;
    endonStr = [];
    endonStr[0] = tempStr;
  }
  foreach(str in endonStr)
  self endon(str);

  while(1) {
    level.player waittill(eventStr);
    if(DistanceSquared(level.player.origin, self.origin) < radius * radius) {
      self notify(notifyStr);
      self.interruptedEnt = level.player;
      self notify(notifyStr);
      self.interrupted = true;
      waittillframeend;
      self.interrupted = false;
    }
  }
}

wrap(number, range) {
  quotient = Int(number / range);
  remainder = number - (range * quotient);
  if(number < 0) remainder += range;
  if(remainder == range) remainder = 0;
  return remainder;
}

interactives_DrawDebugLineForTime(org1, org2, r, g, b, timer) {
  if(GetDvarInt("interactives_debug")) {
    thread draw_line_for_time(org1, org2, r, g, b, timer);
  }

}

drawCross(origin, size, color, timeSeconds) {
  thread draw_line_for_time(origin - (size, 0, 0), origin + (size, 0, 0), color[0], color[1], color[2], timeSeconds);
  thread draw_line_for_time(origin - (0, size, 0), origin + (0, size, 0), color[0], color[1], color[2], timeSeconds);
  thread draw_line_for_time(origin - (0, 0, size), origin + (0, 0, size), color[0], color[1], color[2], timeSeconds);
}

drawCircle(origin, radius, color, timeSeconds) {
  numSegments = 16;
  for(i = 0; i < 360; i += (360 / numSegments)) {
    j = i + (360 / numSegments);
    thread draw_line_for_time(origin + (radius * Cos(i), radius * Sin(i), 0), origin + (radius * Cos(j), radius * Sin(j), 0), color[0], color[1], color[2], timeSeconds);
  }
}

drawCircularArrow(origin, radius, color, timeseconds, degrees) {
  if(degrees == 0) return;
  numSegmentsFullCircle = 16;
  numSegments = int(1 + (numSegmentsFullCircle * abs(degrees) / 360));
  for(seg = 0; seg < numSegments; seg++) {
    i = seg * degrees / numSegments;
    j = i + (degrees / numSegments);
    thread draw_line_for_time(origin + (radius * Cos(i), radius * Sin(i), 0), origin + (radius * Cos(j), radius * Sin(j), 0), color[0], color[1], color[2], timeSeconds);
  }
  i = degrees;
  j = degrees - (sign(degrees) * 20);
  thread draw_line_for_time(origin + (radius * Cos(i), radius * Sin(i), 0), origin + (radius * 0.8 * Cos(j), radius * 0.8 * Sin(j), 0), color[0], color[1], color[2], timeSeconds);
  thread draw_line_for_time(origin + (radius * Cos(i), radius * Sin(i), 0), origin + (radius * 1.2 * Cos(j), radius * 1.2 * Sin(j), 0), color[0], color[1], color[2], timeSeconds);
}

IsInArray(e, array) {
  foreach(a in array) {
    if(e == a) return true;
  }
  return false;
}

newtonsMethod(x0, x1, p3, p2, p1, p0, tolerance) {
  iterations = 5;
  x = (x0 + x1) / 2;
  offset = tolerance + 1;
  while(abs(offset) > tolerance && iterations > 0) {
    value = (p3 * x * x * x) + (p2 * x * x) + (p1 * x) + p0;
    slope = (3 * p3 * x * x) + (2 * p2 * x) + p1;
    AssertEx(slope != 0, "newtonsMethod found zero slope.Can't work with that.");
    offset = -1 * value / slope;
    oldx = x;
    x += offset;

    if(x > x1)
      x = (oldX + (3 * x1)) / 4;
    else if(x < x0)
      x = (oldX + (3 * x0)) / 4;
    iterations--;
    /# if( iterations == 0 )
    Print("_interactive_utility::newtonsMethod failed to converge. x0:" + x0 + ", x1:" + x1 + ", p3:" + p3 + ", p2:" + p2 + ", p1:" + p1 + ", p0:" + p0 + ", x:" + x);

  }
  return x;
}

rootsOfCubic(a, b, c, d) {
  if(a == 0) {
    return rootsOfQuadratic(b, c, d);
  }

  q = (2 * b * b * b) - (9 * a * b * c) + (27 * a * a * d);

  bSquared3ac = (b * b) - (3 * a * c);
  if((bSquared3ac == 0)) {}
  if(q == 0 && bSquared3ac == 0) {
    x[0] = -1 * b / (3 * a);
  } else if(q == 0 && bSquared3ac != 0) {
    x[0] = ((9 * a * a * d) - (4 * a * b * c) + (b * b * b)) / (a * ((3 * a * c) - (b * b)));
  } else {}
}

rootsOfQuadratic(a, b, c) {
  while(abs(a) > 65536 || abs(b) > 65536 || abs(c) > 65536) {
    a /= 10;
    b /= 10;
    c /= 10;
  }
  x = [];
  if(a == 0) {
    if(b != 0) {
      x[0] = -1 * c / b;
    }
  } else {
    bSquared4ac = (b * b) - (4 * a * c);
    if(bSquared4ac > 0) {
      x[0] = ((-1 * b) - sqrt(bSquared4ac)) / (2 * a);
      x[1] = ((-1 * b) + sqrt(bSquared4ac)) / (2 * a);
    } else if(bSquared4ac == 0) {
      x[0] = -1 * b / (2 * a);
    }
  }

  return x;
}

NonVectorLength(array, array2) {
  AssertEx((!isDefined(array2)) || (array.size == array2.size), "NonVectorLength: second array must have same number of components as first array.");
  sum = 0;
  for(i = 0; i < array.size; i++) {
    value = array[i];
    if(isDefined(array2)) value -= array2[i];
    sum += value * value;
  }
  return sqrt(sum);
}

clampAndNormalize(x, min, max) {
  AssertEx(min != max, "clampAndNormalize: min must not equal max");
  if(min < max)
    x = clamp(x, min, max);
  else x = clamp(x, max, min);
  return (x - min) / (max - min);
}

PointOnCircle(center, radius, deg) {
  x = Cos(deg);
  x *= radius;
  x += center[0];
  y = Sin(deg);
  y *= radius;
  y += center[1];
  z = center[2];
  return (x, y, z);
}

zeroComponent(vector, comp) {
  return (vector[0] * (comp != 0), vector[1] * (comp != 1), vector[2] * (comp != 2));
}

rotate90AroundAxis(vector, comp) {
  if(comp == 0) {
    return (vector[0], vector[2], -1 * vector[1]);
  } else if(comp == 1) {
    return (-1 * vector[2], vector[1], vector[0]);
  } else {
    return (vector[1], -1 * vector[0], vector[2]);
  }
}