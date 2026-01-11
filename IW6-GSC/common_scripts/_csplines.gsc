/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_csplines.gsc
****************************************/

#include common_scripts\utility;

cspline_calcTangent(P1, P3, Length1, Length2, tension) {
  incoming = [];
  outgoing = [];
  for(i = 0; i < 3; i++) {
    incoming[i] = (1 - tension) * (P3[i] - P1[i]);
    outgoing[i] = incoming[i];
    incoming[i] *= (2 * Length1 / (Length1 + Length2));
    outgoing[i] *= (2 * Length2 / (Length1 + Length2));
  }
  R = [];
  R["incoming"] = (incoming[0], incoming[1], incoming[2]);
  R["outgoing"] = (outgoing[0], outgoing[1], outgoing[2]);
  return R;
}

cspline_calcTangentTCB(P1, P2, P3, Length1, Length2, t, c, b) {
  incoming = [];
  outgoing = [];
  for(i = 0; i < 3; i++) {
    incoming[i] = (1 - t) * (1 - c) * (1 + b) * 0.5 * (P2[i] - P1[i]);
    incoming[i] += (1 - t) * (1 + c) * (1 - b) * 0.5 * (P3[i] - P2[i]);
    incoming[i] *= (2 * Length1 / (Length1 + Length2));
    outgoing[i] = (1 - t) * (1 + c) * (1 + b) * 0.5 * (P2[i] - P1[i]);
    outgoing[i] += (1 - t) * (1 - c) * (1 - b) * 0.5 * (P3[i] - P2[i]);
    outgoing[i] *= (2 * Length2 / (Length1 + Length2));
  }
  R = [];
  R["incoming"] = (incoming[0], incoming[1], incoming[2]);
  R["outgoing"] = (outgoing[0], outgoing[1], outgoing[2]);
  return R;
}

cspline_calcTangentNatural(P1, P2, R1) {
  numDimensions = 3;
  incoming = [];
  outgoing = [];
  if(isDefined(R1)) {
    for(i = 0; i < numDimensions; i++) {
      incoming[i] = (-3 * P1[i] + 3 * P2[i] - R1[i]) / 2;
      outgoing[i] = incoming[i];
    }
  } else {
    for(i = 0; i < numDimensions; i++) {
      incoming[i] = P2[i] - P1[i];
      outgoing[i] = P2[i] - P1[i];
    }
  }
  R = [];
  R["incoming"] = (incoming[0], incoming[1], incoming[2]);
  R["outgoing"] = (outgoing[0], outgoing[1], outgoing[2]);
  return R;
}

csplineSeg_calcCoeffs(P1, P2, R1, R2) {
  numDimensions = 3;
  segVars = spawnStruct();
  segVars.n3 = [];
  segVars.n2 = [];
  segVars.n = [];
  segVars.c = [];
  for(i = 0; i < numDimensions; i++) {
    segVars.n3[i] = 2 * P1[i] - 2 * P2[i] + R1[i] + R2[i];
    segVars.n2[i] = -3 * P1[i] + 3 * P2[i] - 2 * R1[i] - R2[i];
    segVars.n[i] = R1[i];
    segVars.c[i] = P1[i];
  }
  return segVars;
}

csplineSeg_calcCoeffsCapSpeed(P1, P2, R1, R2, segLength) {
  csSeg = csplineSeg_calcCoeffs(P1, P2, R1, R2);

  topSpeed = csplineSeg_calcTopSpeed(csSeg, segLength);
  if(topSpeed > 1) {
    segLength *= topSpeed;
    R1 /= topSpeed;
    R2 /= topSpeed;

    csSeg = csplineSeg_calcCoeffs(P1, P2, R1, R2);
  }

  csSeg.endAt = segLength;
  return csSeg;
}

cspline_getNodes(csPath) {
  array = [];
  segLength = csPath.Segments[0].endAt;
  array[0] = csplineSeg_getPoint(csPath.Segments[0], 0, segLength, csPath.Segments[0].speedStart);
  array[0]["time"] = 0;
  startDist = 0;
  for(segNum = 0; segNum < csPath.Segments.size; segNum++) {
    segLength = csPath.Segments[segNum].endAt - startDist;
    array[segNum + 1] = csplineSeg_getPoint(csPath.Segments[segNum], 1, segLength, csPath.Segments[segNum].speedEnd);
    posVelStart = csplineSeg_getPoint(csPath.Segments[segNum], 0, segLength, csPath.Segments[segNum].speedStart);
    array[segNum]["acc_out"] = posVelStart["acc"];
    array[segNum + 1]["time"] = csPath.Segments[segNum].endTime;
    startDist = csPath.Segments[segNum].endAt;
  }
  array[csPath.Segments.size]["acc_out"] = array[csPath.Segments.size]["acc"];
  return array;
}

csplineSeg_getPoint(csplineSeg, x, segLength, speedMult) {
  numDimensions = 3;
  posArray = [];
  velArray = [];
  accArray = [];
  returnArray = [];
  for(i = 0; i < numDimensions; i++) {
    posArray[i] = (csplineSeg.n3[i] * x * x * x) + (csplineSeg.n2[i] * x * x) + (csplineSeg.n[i] * x) + csplineSeg.c[i];
    velArray[i] = (3 * csplineSeg.n3[i] * x * x) + (2 * csplineSeg.n2[i] * x) + csplineSeg.n[i];
    accArray[i] = (6 * csplineSeg.n3[i] * x) + (2 * csplineSeg.n2[i]);
  }

  returnArray["pos"] = (posArray[0], posArray[1], posArray[2]);
  returnArray["vel"] = (velArray[0], velArray[1], velArray[2]);
  returnArray["acc"] = (accArray[0], accArray[1], accArray[2]);
  if(isDefined(segLength)) {
    returnArray["vel"] /= segLength;
    returnArray["acc"] /= segLength * segLength;
  }
  if(isDefined(speedMult)) {
    returnArray["vel"] *= speedMult;
    returnArray["acc"] *= speedMult * speedMult;
  }
  returnArray["speed"] = speedMult;
  return returnArray;
}

csplineSeg_calcTopSpeed(csplineSeg, segLength) {
  v1 = csplineSeg_calcTopSpeedByDeriving(csplineSeg, segLength);

  return v1;
}

csplineSeg_calcTopSpeedByDeriving(csplineSeg, segLength) {
  n3_n3 = 0;
  n3_n2 = 0;
  n3_n = 0;
  n2_n2 = 0;
  n2_n = 0;
  n_n = 0;
  for(axis = 0; axis < 3; axis++) {
    n3_n3 += csplineSeg.n3[axis] * csplineSeg.n3[axis];
    n3_n2 += csplineSeg.n3[axis] * csplineSeg.n2[axis];
    n3_n += csplineSeg.n3[axis] * csplineSeg.n[axis];
    n2_n2 += csplineSeg.n2[axis] * csplineSeg.n2[axis];
    n2_n += csplineSeg.n2[axis] * csplineSeg.n[axis];
    n_n += csplineSeg.n[axis] * csplineSeg.n[axis];
  }

  a = 36 * n3_n3;
  b = 36 * n3_n2;
  c = 12 * n3_n + 8 * n2_n2;
  d = 4 * n2_n;

  values = [];
  values[0] = 0;
  if(a == 0) {
    if((b == 0) && (c == 0) && (d == 0)) {
      return sqrt(n_n) / segLength;
    }

    cubicRoots = maps\interactive_models\_interactive_utility::rootsOfQuadratic(b, c, d);
    if(isDefined(cubicRoots[0]) && cubicRoots[0] > 0 && cubicRoots[0] < 1) {
      slope = (2 * b * cubicRoots[0]) + c;
      if(slope < 0) {
        values[values.size] = cubicRoots[0];
      }
    }
    if(isDefined(cubicRoots[1]) && cubicRoots[1] > 0 && cubicRoots[1] < 1) {
      slope = (2 * b * cubicRoots[0]) + c;
      if(slope < 0) {
        values[values.size] = cubicRoots[1];
      }
    }
  } else {
    quadRoots = maps\interactive_models\_interactive_utility::rootsOfQuadratic(3 * a, 2 * b, c);
    i = 0;
    points[0] = 0;
    for(i = 0; i < quadRoots.size; i++) {
      if(quadRoots[i] > 0 && quadRoots[i] < 1) {
        points[points.size] = quadRoots[i];
      }
    }
    points[points.size] = 1;
    for(i = 1; i < points.size; i++) {
      x0 = points[i - 1];
      x1 = points[i];
      startVal = (a * x0 * x0 * x0) + (b * x0 * x0) + (c * x0) + d;
      endVal = (a * x1 * x1 * x1) + (b * x1 * x1) + (c * x1) + d;
      if((startVal > 0) && (endVal < 0)) {
        values[values.size] = maps\interactive_models\_interactive_utility::newtonsMethod(x0, x1, a, b, c, d, 0.02);
      }
    }
  }
  values[values.size] = 1;

  a = 9 * n3_n3;
  b = 12 * n3_n2;
  c = 6 * n3_n + 4 * n2_n2;
  d = 4 * n2_n;
  e = n_n;

  maxSpeedSq = 0;
  foreach(x in values) {
    speedSq = (a * x * x * x * x) + (b * x * x * X) + (c * x * x) + (d * x) + e;
    if(speedSq > maxSpeedSq) {
      maxSpeedSq = speedSq;
    }

  }

  return (sqrt(maxSpeedSq) / segLength);
}

csplineSeg_calcLengthByStepping(csplineSeg, numSteps) {
  oldPos = csplineSeg_getPoint(csplineSeg, 0);
  distance = 0;
  for(i = 1; i <= numSteps; i++) {
    n = i / numSteps;
    newPos = csplineSeg_getPoint(csplineSeg, n);
    distance += Length(oldPos["pos"] - newPos["pos"]);
    oldPos = newPos;
  }
  return distance;
}

csplineSeg_calcTopSpeedByStepping(csplineSeg, numSteps, segLength) {
  oldPos = csplineSeg_getPoint(csplineSeg, 0);
  topSpeed = 0;
  for(i = 1; i <= numSteps; i++) {
    n = i / numSteps;
    newPos = csplineSeg_getPoint(csplineSeg, n);
    distance = Length(oldPos["pos"] - newPos["pos"]);
    if(distance > topSpeed) topSpeed = distance;
    oldPos = newPos;
  }
  topSpeed *= numSteps / segLength;
  return topSpeed;
}

cspline_findPathnodes(first_node) {
  next_node = first_node;
  array = [];

  for(node_num = 0; isDefined(next_node.target); node_num++) {
    array[node_num] = next_node;
    targetname = next_node.target;
    next_node = GetNode(targetname, "targetname");
    if(!isDefined(next_node)) {
      next_node = GetVehicleNode(targetname, "targetname");
      if(!isDefined(next_node)) {
        next_node = GetEnt(targetname, "targetname");
        if(!isDefined(next_node)) {
          next_node = getstruct(targetname, "targetname");
        }
      }
    }

    AssertEx(isDefined(next_node), "cspline_findPathnodes: Couldn't find targetted node with targetname " + targetname + ".");
  }
  array[node_num] = next_node;
  return (array);
}

cspline_makePath1Seg(startOrg, endOrg, startVel, endVel) {
  nodes = [];
  nodes[0] = spawnStruct();
  nodes[0].origin = startOrg;
  if(isDefined(startVel)) {
    nodes[0].speed = Length(startVel);
    startVel /= nodes[0].speed;
    nodes[0].speed *= 20;
  } else {
    nodes[0].speed = 20;
  }
  nodes[1] = spawnStruct();
  nodes[1].origin = endOrg;
  if(isDefined(endVel)) {
    nodes[1].speed = Length(endVel);
    endVel /= nodes[1].speed;
    nodes[1].speed *= 20;
  } else {
    nodes[1].speed = 20;
  }
  return cspline_makePath(nodes, true, startVel, endVel);
}

cspline_makePathToPoint(startOrg, endOrg, startVel, endVel, forceCreateIntermediateNodes) {
  dirs = [];
  if(!isDefined(forceCreateIntermediateNodes)) forceCreateIntermediateNodes = false;
  if(isDefined(startVel)) {
    startSpeed = Length(startVel);
    dirs[0] = startVel / startSpeed;
    startSpeed *= 20;
  } else {
    startSpeed = 20;
  }
  if(isDefined(endVel)) {
    endSpeed = Length(endVel);
    dirs[1] = endVel / endSpeed;
    endSpeed *= 20;
  } else {
    endSpeed = 20;
  }
  if((startSpeed / endSpeed > 1.2) || (endSpeed / startSpeed > 1.2) || (forceCreateIntermediateNodes)) {
    if(!isDefined(dirs[0])) {
      dirs[0] = (0, 0, 0);
    }
    if(!isDefined(dirs[1])) {
      dirs[1] = (0, 0, 0);
    }
  }
  pathVec = endOrg - startOrg;
  pathLength = Length(pathVec);
  pathDir = pathVec / pathLength;

  nodes = [];
  nodes[0] = spawnStruct();
  nodes[0].origin = startOrg;
  nodes[0].speed = startSpeed;

  offsetLengths = [];
  midSpeed = max(startSpeed, endSpeed);
  if(isDefined(dirs[0])) {
    offsetLengths[0] = (startSpeed + midSpeed) / (2 * 20);
  }
  if(isDefined(dirs[1])) {
    offsetLengths[1] = (endSpeed + midSpeed) / (2 * 20);
  }
  for(i = 0; i < 2; i++) {
    if(isDefined(dirs[i])) {
      sign = (0.5 - i) * 2;
      offsetVec = dirs[i];
      offsetVec *= sign;
      offsetDotPath = VectorDot(offsetVec, pathDir);

      if((offsetDotPath * sign < 0.3) || (startSpeed / endSpeed > 1.2) || (endSpeed / startSpeed > 1.2) || forceCreateIntermediateNodes) {
        if(offsetDotPath * sign < 0) {
          offsetAlongPath = offsetDotPath * pathDir;
          offsetVec -= offsetAlongPath;
          AssertEx(VectorDot(offsetVec, pathDir) == 0, "Dot result should be 0: " + VectorDot(offsetVec, pathDir));
          offsetVec = VectorNormalize(offsetVec);
          offsetVec += offsetAlongPath;
        }

        offsetVec += pathDir * sign;
        offsetVec = offsetVec * offsetLengths[i];
        offsetVec *= sqrt(pathLength) * 2;
        nodes[nodes.size] = spawnStruct();
        if(i == 0) {
          nodes[nodes.size - 1].origin = startOrg + offsetVec;
        } else {
          nodes[nodes.size - 1].origin = endOrg + offsetVec;
        }
        nodes[nodes.size - 1].speed = midSpeed;
      }
    }
  }
  n = nodes.size;
  nodes[n] = spawnStruct();
  nodes[n].origin = endOrg;
  nodes[n].speed = endSpeed;

  if(GetDvarInt("interactives_debug")) {
    thread draw_line_for_time(startOrg, endOrg, 0, .7, .7, 1);
    for(n = 1; n < nodes.size; n++) {
      thread draw_line_for_time(nodes[n - 1].origin, nodes[n].origin, 0, .7, .7, 1);
    }
  }

  return cspline_makePath(nodes, true, dirs[0], dirs[1]);
}

cspline_makePath(nodes, useNodeSpeeds, startVel, endVel, capSpeed) {
  csPath = spawnStruct();
  csPath.Segments = [];
  if(!isDefined(useNodeSpeeds)) useNodeSpeeds = false;
  AssertEx(!useNodeSpeeds || isDefined(nodes[0].speed), "cspline_makePath: Speed keypair required for first node in path (node at " + nodes[0].origin + ")");
  if(!isDefined(capSpeed)) capSpeed = true;

  AssertEx(isDefined(nodes[0]), "cspline_makePath: No nodes supplied");
  AssertEx(isDefined(nodes[1]), "cspline_makePath: Only one node supplied");
  path_length = 0;
  nextTangent = [];
  nextSegLength = Distance(nodes[0].origin, nodes[1].origin);

  while(isDefined(nodes[csPath.Segments.size + 2])) {
    i = csPath.Segments.size;
    prevPoint = nodes[i].origin;
    nextPoint = nodes[i + 1].origin;
    nextNextPoint = nodes[i + 2].origin;
    thisSegLength = nextSegLength;
    nextSegLength = Distance(nodes[i + 1].origin, nodes[i + 2].origin);
    prevTangent = nextTangent;
    nextTangent = cspline_calcTangent(prevPoint, nextNextPoint, thisSegLength, nextSegLength, 0.5);
    AssertEx(abs(Length(nextTangent["incoming"])) <= thisSegLength, "cspline_makePath: Tangent slope is > 1.This shouldn't be possible.");
    AssertEx(abs(Length(nextTangent["outgoing"])) <= nextSegLength, "cspline_makePath: Tangent slope is > 1.This shouldn't be possible.");
    if(i == 0) {
      if(isDefined(startVel)) {
        prevTangent["outgoing"] = startVel * thisSegLength;
      } else {
        prevTangent = cspline_calcTangentNatural(prevPoint, nextPoint, nextTangent["incoming"]);
      }
    }
    if(capSpeed) {
      csPath.Segments[i] = csplineSeg_calcCoeffsCapSpeed(prevPoint, nextPoint, prevTangent["outgoing"], nextTangent["incoming"], thisSegLength);
      path_length += csPath.Segments[i].endAt;
    } else {
      csPath.Segments[i] = csplineSeg_calcCoeffs(prevPoint, nextPoint, prevTangent["outgoing"], nextTangent["incoming"]);
      path_length += thisSegLength;
    }
    csPath.Segments[i].endAt = path_length;
  }
  i = csPath.Segments.size;
  prevPoint = nodes[i].origin;
  nextPoint = nodes[i + 1].origin;
  thisSegLength = nextSegLength;
  prevTangent = nextTangent;
  if(i == 0 && isDefined(startVel)) {
    prevTangent["outgoing"] = startVel * thisSegLength;
  }
  if(isDefined(endVel)) {
    nextTangent["incoming"] = endVel * thisSegLength;
  } else {
    nextTangent = cspline_calcTangentNatural(prevPoint, nextPoint, prevTangent["outgoing"]);
  }
  if(i == 0 && !isDefined(startVel)) {
    prevTangent = cspline_calcTangentNatural(prevPoint, nextPoint, nextTangent["incoming"]);
  }
  if(capSpeed) {
    csPath.Segments[i] = csplineSeg_calcCoeffsCapSpeed(prevPoint, nextPoint, prevTangent["outgoing"], nextTangent["incoming"], thisSegLength);
    path_length += csPath.Segments[i].endAt;
  } else {
    csPath.Segments[i] = csplineSeg_calcCoeffs(prevPoint, nextPoint, prevTangent["outgoing"], nextTangent["incoming"]);
    path_length += thisSegLength;
  }
  csPath.Segments[i].endAt = path_length;

  if(useNodeSpeeds) {
    pathTime = 0;
    prevEndAt = 0;
    for(i = 0; i < csPath.Segments.size; i++) {
      if(!isDefined(nodes[i + 1].speed)) {
        nodes[i + 1].speed = nodes[i].speed;
      }
      thisSegLength = csPath.Segments[i].endAt - prevEndAt;
      segTime = 2 * thisSegLength / ((nodes[i].speed + nodes[i + 1].speed) / 20);
      pathTime += segTime;
      csPath.Segments[i].endTime = pathTime;
      prevEndAt = csPath.Segments[i].endAt;
      csPath.Segments[i].speedStart = nodes[i].speed / 20;
      csPath.Segments[i].speedEnd = nodes[i + 1].speed / 20;
    }
  } else {
    for(i = 0; i < csPath.Segments.size; i++) {
      csPath.Segments[i].endTime = csPath.Segments[i].endAt;
      csPath.Segments[i].speedStart = 1;
      csPath.Segments[i].speedEnd = 1;
    }
  }

  return csPath;
}

cspline_moveFirstPoint(csPath, newStartPos, newStartVel) {
  newPath = spawnStruct();
  newPath.Segments = [];
  posVel = csplineSeg_getPoint(csPath.Segments[0], 1);
  segLength3D = posVel["pos"] - newStartPos;
  segLength = Length(segLength3D);
  newPath.Segments[0] = csplineSeg_calcCoeffs(newStartPos, posVel["pos"], newStartVel * segLength, posVel["vel"]);
  newPath.Segments[0].endTime = csPath.Segments[0].endTime * segLength / csPath.Segments[0].endAt;
  newPath.Segments[0].endAt = segLength;
  lengthDiff = segLength - csPath.Segments[0].endAt;
  timeDiff = newPath.Segments[0].endTime - csPath.Segments[0].endTime;

  for(seg = 1; seg < csPath.Segments.size; seg++) {
    newPath.Segments[seg] = csplineSeg_copy(csPath.Segments[seg]);
    newPath.Segments[seg].endAt += lengthDiff;
    newPath.Segments[seg].endTime += timeDiff;
  }
  return newPath;
}

cspline_getPointAtDistance(csPath, distance, speedIsImportant) {
  if(distance <= 0) {
    segLength = csPath.Segments[0].endAt;
    posVel = csplineSeg_getPoint(csPath.Segments[0], 0, segLength, csPath.Segments[0].speedStart);
    return posVel;
  } else if(distance >= csPath.Segments[csPath.Segments.size - 1].endAt) {
    if(csPath.Segments.size > 1) {
      segLength = csPath.Segments[csPath.Segments.size - 1].endAt - csPath.Segments[csPath.Segments.size - 2].endAt;
    } else {
      segLength = csPath.Segments[csPath.Segments.size - 1].endAt;
    }
    posVel = csplineSeg_getPoint(csPath.Segments[csPath.Segments.size - 1], 1, segLength, csPath.Segments[csPath.Segments.size - 1].speedEnd);
    return posVel;
  } else {
    segNum = 0;
    while(csPath.Segments[segNum].endAt < distance) {
      segNum++;
    }
    if(segNum > 0) {
      startAt = csPath.Segments[segNum - 1].endAt;
    } else {
      startAt = 0;
    }
    segLength = csPath.Segments[segNum].endAt - startAt;
    normalized = (distance - startAt) / segLength;
    speed = undefined;
    if(isDefined(speedIsImportant) && speedIsImportant) {
      speed = cspline_speedFromDistance(csPath.Segments[segNum].speedStart, csPath.Segments[segNum].speedEnd, normalized);
    }
    posVel = csplineSeg_getPoint(csPath.Segments[segNum], normalized, segLength, speed);
    return posVel;
  }
}

cspline_getPointAtTime(csPath, time) {
  if(time <= 0) {
    segLength = csPath.Segments[0].endAt;
    posVel = csplineSeg_getPoint(csPath.Segments[0], 0, segLength, csPath.Segments[0].speedStart);
    return posVel;
  } else if(time >= csPath.Segments[csPath.Segments.size - 1].endTime) {
    if(csPath.Segments.size > 1) {
      segLength = csPath.Segments[csPath.Segments.size - 1].endAt - csPath.Segments[csPath.Segments.size - 2].endAt;
    } else {
      segLength = csPath.Segments[csPath.Segments.size - 1].endAt;
    }
    posVel = csplineSeg_getPoint(csPath.Segments[csPath.Segments.size - 1], 1, segLength, csPath.Segments[csPath.Segments.size - 1].speedEnd);
    return posVel;
  } else {
    segNum = 0;
    while(csPath.Segments[segNum].endTime < time) {
      segNum++;
    }
    if(segNum > 0) {
      startTime = csPath.Segments[segNum - 1].endTime;
      segLength = csPath.Segments[segNum].endAt - csPath.Segments[segNum - 1].endAt;
    } else {
      startTime = 0;
      segLength = csPath.Segments[0].endAt;
    }

    segTime = csPath.Segments[segNum].endTime - startTime;
    normTime = (time - startTime) / segTime;
    speed = csPath.Segments[segNum].speedStart + (normTime * (csPath.Segments[segNum].speedEnd - csPath.Segments[segNum].speedStart));
    dist = (time - startTime) * (csPath.Segments[segNum].speedStart + speed) / 2;
    normDist = dist / segLength;
    posVel = csplineSeg_getPoint(csPath.Segments[segNum], normDist, segLength, speed);
    return posVel;
  }
}

cspline_speedFromDistance(speedStart, speedEnd, normalizedDistance) {
  d = normalizedDistance;
  a = (speedEnd - speedStart) * (speedEnd + speedStart) / 2;
  return sqrt((2 * a * d) + (speedStart * speedStart));
}

cspline_adjustTime(csPath, newTime) {
  oldTime = cspline_time(csPath);
  t0 = csPath.Segments[0].endTime;
  t1 = csPath.Segments[csPath.Segments.size - 2].endTime - t0;
  t2 = csPath.Segments[csPath.Segments.size - 1].endTime - csPath.Segments[csPath.Segments.size - 2].endTime;
  tempsum = (2 * t0) + t1 + (2 * t2) - newtime;
  R = (sqrt((tempsum * tempsum) + (4 * t1 * newTime)) + tempsum) / (2 * newTime);

  checkNewTime = ((t0 + t2) * 2 / (1 + R)) + (t1 / R);
  AssertEx(abs(checkNewTime - newTime) < 0.001, "cspline_adjustTime math failure: " + checkNewTime + " != " + newTime);

  nextTime = undefined;
  checkEndTime = undefined;
  csPath.Segments[0].speedEnd *= R;
  offset = csPath.Segments[0].endtime * ((1 / R) - (2 / (1 + R)));

  checkEndTime = (csPath.Segments[0].endtime / R) - offset;
  nextTime = csPath.Segments[1].endtime - csPath.Segments[0].endtime;

  csPath.Segments[0].endtime /= (1 + R) / 2;
  AssertEx(abs(checkEndTime - csPath.Segments[0].endtime) < 0.001, "cspline_adjustTime math failure (offset). " + checkEndTime + " != " + csPath.Segments[0].endtime);
  for(i = 1; i < csPath.Segments.size - 1; i++) {
    thisOldTime = undefined;

    thisOldTime = nextTime;
    nextTime = csPath.Segments[i + 1].endtime - csPath.Segments[i].endtime;

    csPath.Segments[i].speedStart *= R;
    csPath.Segments[i].speedEnd *= R;
    csPath.Segments[i].endtime /= R;
    csPath.Segments[i].endtime -= offset;

    thisTime = csPath.Segments[i].endtime - csPath.Segments[i - 1].endtime;
    AssertEx(abs(thisTime - (thisOldTime / R)) < 0.001, "cspline_adjustTime math failure. " + thisTime + " != " + (thisOldTime / R));

  }
  i = csPath.Segments.size - 1;
  csPath.Segments[i].speedStart *= R;
  csPath.Segments[i].endtime = newTime;

  t0New = csPath.Segments[0].endtime;
  t1new = csPath.Segments[csPath.Segments.size - 2].endtime - csPath.Segments[0].endtime;
  t2New = csPath.Segments[i].endtime - csPath.Segments[i - 1].endtime;
  AssertEx(abs(t0New - (t0 * 2 / (1 + R))) < 0.001, "cspline_adjustTime math failure t0. " + t0New + " != " + (t0 * 2 / (1 + R)));
  AssertEx(abs(t1new - (t1 / R)) < 0.001, "cspline_adjustTime math failure t1. " + t1new + " != " + (t1 / R));
  AssertEx(abs(t2New - (t2 * 2 / (1 + R))) < 0.001, "cspline_adjustTime math failure t2. " + t2New + " != " + (t2 * 2 / (1 + R)));
}

cspline_makeNoisePath(size, minVal, maxVal, firstVal) {
  nodes = cspline_makeNoisePathNodes(size, minVal, maxVal);
  if(isDefined(firstVal)) {
    nodes[1].origin = firstVal;
  }

  newNode = spawnStruct();
  newNode.origin = nodes[0].origin;
  nodes[nodes.size] = newNode;
  newNode = spawnStruct();
  newNode.origin = nodes[1].origin;
  nodes[nodes.size] = newNode;
  newNode = spawnStruct();
  newNode.origin = nodes[2].origin;
  nodes[nodes.size] = newNode;

  cspath = cspline_makePath(nodes);

  newPath = spawnStruct();
  newPath.Segments = [];
  for(seg = 0; seg < csPath.Segments.size - 2; seg++) {
    newPath.Segments[seg] = csplineSeg_copy(csPath.Segments[seg + 1]);
    newPath.Segments[seg].endAt = seg + 1;
  }
  return newPath;
}

cspline_makeNoisePathNodes(size, minVal, maxVal) {
  AssertEx(minVal[0] < maxVal[0] && minVal[1] < maxVal[1] && minVal[2] < maxVal[2], "minVal must be < maxVal: " + minVal + ", " + maxVal);
  nodes = [];
  for(i = 0; i < size; i++) {
    nodes[i] = spawnStruct();

    x = RandomFloatRange(minVal[0], maxVal[0]);
    y = RandomFloatRange(minVal[1], maxVal[1]);
    z = RandomFloatRange(minVal[2], maxVal[2]);

    nodes[i].origin = (x, y, z);
  }
  return nodes;
}

cspline_test(csPath, timeSecs) {
  sec = 0;
  arrowLength = 10;
  arrowSpacing = 50;
  maxArrows = 50;

  for(;;) {
    if(GetDvarInt("interactives_debug")) {
      pathLength = cspline_time(csPath);
      minArrowSpacing = pathLength / maxArrows;
      col = (minArrowSpacing / arrowSpacing, arrowSpacing / minArrowSpacing, 0);
      if(minArrowSpacing > arrowSpacing) arrowSpacing = minArrowSpacing;
      posVel = cspline_getPointAtTime(csPath, 0);
      for(time = 0; time <= cspline_time(csPath); time += arrowSpacing) {
        prevPos = posVel["pos"];
        if(isDefined(csPath.Segments[0].speedEnd)) {
          posVel = cspline_getPointAtTime(csPath, time);
        } else {
          posVel = cspline_getPointAtDistance(csPath, time);
        }
        thread draw_arrow_time(prevPos, posVel["pos"], (0, 1, 0), 1);
      }
      hsArray = cspline_getNodes(csPath);
      size = 12;
      foreach(i in [0, hsArray.size - 1]) {
        thread draw_line_for_time(hsArray[i]["pos"] - (size, 0, 0), hsArray[i]["pos"] + (size, 0, 0), 1, 0, 0, 1);
        thread draw_line_for_time(hsArray[i]["pos"] - (0, size, 0), hsArray[i]["pos"] + (0, size, 0), 1, 0, 0, 1);
        thread draw_line_for_time(hsArray[i]["pos"] - (0, 0, size), hsArray[i]["pos"] + (0, 0, size), 1, 0, 0, 1);

      }
      for(i = 1; i < hsArray.size - 1; i++) {
        thread draw_line_for_time(hsArray[i]["pos"] - (size, 0, 0), hsArray[i]["pos"] + (size, 0, 0), 1, 1, 0, 1);
        thread draw_line_for_time(hsArray[i]["pos"] - (0, size, 0), hsArray[i]["pos"] + (0, size, 0), 1, 1, 0, 1);
        thread draw_line_for_time(hsArray[i]["pos"] - (0, 0, size), hsArray[i]["pos"] + (0, 0, size), 1, 1, 0, 1);

      }
    }
    wait 1;
    sec++;
    if(isDefined(timeSecs) && (sec >= timeSecs)) break;
  }

}

cspline_testNodes(nodes, timeSecs) {
  size = 20;
  prevNode = undefined;
  foreach(node in nodes) {
    if(isDefined(prevNode)) {
      thread draw_arrow_time(prevNode.origin, node.origin, (0, 1, 0), timeSecs);
    }
    prevNode = node;
  }
  foreach(node in nodes) {
    thread draw_line_for_time(node.origin - (size, 0, 0), node.origin + (size, 0, 0), 1, 1, 0, timeSecs);
    thread draw_line_for_time(node.origin - (0, size, 0), node.origin + (0, size, 0), 1, 1, 0, timeSecs);
    thread draw_line_for_time(node.origin - (0, 0, size), node.origin + (0, 0, size), 1, 1, 0, timeSecs);
  }
}

csplineSeg_copy(csSeg) {
  newSeg = spawnStruct();
  numDimensions = 3;
  for(d = 0; d < numDimensions; d++) {
    newSeg.n3[d] = csSeg.n3[d];
    newSeg.n2[d] = csSeg.n2[d];
    newSeg.n[d] = csSeg.n[d];
    newSeg.c[d] = csSeg.c[d];
  }
  newSeg.endAt = csSeg.endAt;
  newSeg.endTime = csSeg.endTime;
  return newSeg;
}

cspline_length(csPath) {
  return csPath.Segments[csPath.Segments.size - 1].endAt;
}
cspline_time(csPath) {
  return csPath.Segments[csPath.Segments.size - 1].endTime;
}

cspline_InitNoise(center, variance_amt, variance_time, startPoint) {
  ns = spawnStruct();
  largeAmt = variance_amt;
  ns.largeStep = variance_time;

  centerMin = (center[0] - largeAmt, center[1] - largeAmt, center[2] - largeAmt);
  centerMax = (center[0] + largeAmt, center[1] + largeAmt, center[2] + largeAmt);
  startPoint = (center[0], center[1], center[2] - largeAmt);
  ns.largeScale = cspline_makeNoisePath(10, centerMin, centerMax, startPoint);

  ns.largeScale.Length = ns.largeScale.Segments[ns.largeScale.Segments.size - 1].endAt;

  thread cspline_test(ns.largeScale, 20);
  return ns;
}

cspline_Noise(ns, frameNum) {
  tl = mod(frameNum / ns.largeStep, ns.largeScale.length);

  pl = cspline_getPointAtDistance(ns.largeScale, tl);

  return pl["pos"];
}