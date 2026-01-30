/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_orbital_util.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

ORBITAL_BULLETTRACE_MAX_PER_FRAME = 5;
ORBITAL_TRACE_DIST = 24000;
ORBITAL_TRACE_CP_RADIUS = 26;
ORBITAL_TRACE_G_RADIUS = 41;
ORBITAL_TRACE_GROUND_OFFSET = (0, 0, 6);
ORBITAL_DIST_FROM_PLAYER = 500;
ORBITAL_FIND_NODE_MAX_LINKS = 6;

initStart() {
  level.orbital_util_remote_traces_frame = 0;
  level.orbital_util_remote_traces = ORBITAL_BULLETTRACE_MAX_PER_FRAME;

  level.orbital_util_capsule_traces_frame = 0;
  level.orbital_util_capsule_traces = ORBITAL_BULLETTRACE_MAX_PER_FRAME;

  level.orbital_util_last_trace = 0;

  level thread deleteMapRemoteMissileClip();

  level.orbital_util_covered_volumes = getEntArray("orbital_node_covered", "targetname");

  nodes = GetAllNodes();
  if(!NodeHasRemoteMissileSet(nodes[0])) {
    PrintLn("WARNING: remoteMissileSpawn entities are either missing or do not have script_noteworthy set to 0, 1, 2, 3, or 4.");
  }
}

deleteMapRemoteMissileClip() {
  clipbrushes = getEntArray("carepackage_clip", "targetname");
  foreach(brush in clipbrushes) {
    brush Delete();
  }
}

playerGetOutsideNode(type) {
  if(!isDefined(type)) {
    type = "goliath";
  }

  node = self playerGetNodeLookingAt(type);
  if(!isDefined(node)) {
    return;
  }

  self.lastNodeLookingAtTrace = undefined;

  return node;
}

playerGetOrbitalStartPos(node, type) {
  if(!isDefined(type)) {
    type = "goliath";
  }

  remoteMissileSpawns = maps\mp\killstreaks\_aerial_utility::getEntOrStructArray("remoteMissileSpawn", "targetname");
  org = nodeGetRemoteMissileOrigin(node, remoteMissileSpawns, type);
  if(isDefined(org)) {
    return org;
  } else {
    return nodeGetRemoteMissileOrgFromAbove(node);
  }
}

getStartPositionAbove(node) {
  return (node.origin + (0, 0, ORBITAL_TRACE_DIST));
}

addDropMarker(markerEnt, type) {
  if(!isDefined(type)) {
    type = "goliath";
  }

  markerEnt.orbitalType = type;

  level.orbitalDropMarkers[level.orbitalDropMarkers.size] = markerEnt;

  thread _addDropMarkerInternal(markerEnt);
}

playerPlayInvalidPositionEffect(effectRef) {
  trace = self.lastNodeLookingAtTrace;
  nearestNode = self.lastNearestNode;
  if(!isDefined(trace)) {
    playerDir = anglesToForward(self GetPlayerAngles());
    start = self getEye();
    end = start + (playerDir * ORBITAL_DIST_FROM_PLAYER);
    trace = bulletTrace(start, end, false, self, true, false, false, false, false);
  }
  self.lastNodeLookingAtTrace = undefined;
  self.lastNearestNode = undefined;

  effectOrg = trace["position"];

  if(isDefined(nearestNode)) {
    normal = trace["normal"];
    isGroundFlat = normal[2] > 0.8;
    if(!isGroundFlat) {
      effectOrg = nearestNode.origin;
    }
  }

  marker = spawn("script_model", effectOrg + (0, 0, 5));
  marker.angles = (-90, 0, 0);
  marker setModel("tag_origin");
  marker Hide();
  marker ShowToPlayer(self);
  playFXOnTag(effectRef, marker, "tag_origin");

  wait 5;

  marker Delete();
}

playerGetNodeLookingAt(type) {
  playerDir = anglesToForward(self GetPlayerAngles());
  start = self getEye();
  end = start + (playerDir * ORBITAL_DIST_FROM_PLAYER);
  trace = bulletTrace(start, end, false, self, true, false, false, false, false);
  self.lastNodeLookingAtTrace = trace;
  lookingAway = (trace["fraction"] == 1);
  /# debugPlacementLine( start, start + ( playerDir * ORBITAL_DIST_FROM_PLAYER * trace[ "fraction" ] ), ( 0, 1, 0 ), ( 1, 0, 0 ), lookingAway );
  if(lookingAway) {
    return playerGetNearestNode(undefined, type);
  }

  position = trace["position"];
  nodes = GetNodesInRadius(position, 128, 0, 60);
  outOfPlaySpace = (nodes.size == 0);
  if(outOfPlaySpace) {
    return playerGetNearestNode(undefined, type);
  }

  normal = trace["normal"];
  isGroundFlat = normal[2] > 0.8;
  /# debugPlacementLine( position, position + ( normal * 20 ), ( 0, 1, 0 ), ( 1, 0, 0 ), !isGroundFlat );
  if(!isGroundFlat) {
    return playerGetNearestNode(position, type);
  }

  if(isDefined(level.orbital_util_covered_volumes) && level.orbital_util_covered_volumes.size > 0) {
    pointInVolume = false;
    foreach(volume in level.orbital_util_covered_volumes) {
      pointInVolume = IsPointInVolume(position, volume);
      if(pointInVolume) {
        break;
      }
    }
    /# debugPlacementSphere( position, 5.0, ( 0, 1, 0 ), ( 1, 0, 0 ), pointInVolume );
    if(pointInVolume) {
      return playerGetNearestNode(position, type);
    }
  }

  if(type == "goliath") {
    if(goliathBadLandingCheck(position)) {
      return playerGetNearestNode(position, type);
    }
  }

  tracePassed = carepackageTrace(position, self, type);

  radius = ORBITAL_TRACE_G_RADIUS;
  if(type == "carepackage") {
    radius = ORBITAL_TRACE_CP_RADIUS;
  }
  debugPlacementSphere(position, radius, (0, 1, 0), (1, 0, 0), !tracePassed);

  if(!tracePassed) {
    return playerGetNearestNode(position, type);
  }

  if(groundPositionOffEdge(position, type)) {
    return playerGetNearestNode(position, type);
  }

  node = spawnStruct();
  node.origin = position;
  remoteMissileSpawns = maps\mp\killstreaks\_aerial_utility::getEntOrStructArray("remoteMissileSpawn", "targetname");
  org = nodeGetRemoteMissileOrigin(node, remoteMissileSpawns, type);
  if(!isDefined(org)) {
    return playerGetNearestNode(position, type);
  }

  return node;
}

groundPositionOffEdge(position, type) {
  if(type == "goliath") {
    radius = ORBITAL_TRACE_G_RADIUS;
  } else {
    radius = ORBITAL_TRACE_CP_RADIUS;
  }

  xPos = (radius, 0, 0);
  xNeg = -1 * xPos;
  yPos = (0, radius, 0);
  yNeg = -1 * yPos;

  endOffset = (0, 0, -10);

  testDirections = [xPos, xNeg, yPos, yNeg];
  foreach(dir in testDirections) {
    start = position + dir;
    end = position + dir + endOffset;
    tracePassed = BulletTracePassed(start, end, false, undefined);
    if(tracePassed) {
      return true;
    }
  }

  return false;
}

_nodeFindNewRemoteMissileOrg(node, remoteMissileSpawns, type) {
  ent = nodeFindRemoteMissleEnt(node, remoteMissileSpawns, type);
  if(isDefined(ent)) {
    /# debugNodeFindNewRemoteMissileEnt( node, ent.script_noteworthy );
    return nodeGetRemoteMissleEntOrg(node, remoteMissileSpawns);
  }

  org = nodeTestFireFromAbove(node, type);
  if(isDefined(org)) {
    /# debugNodeFindNewRemoteMissileEnt( node, "up" );
    return nodeGetRemoteMissileOrgFromAbove(node);
  } else {
    /# debugNodeFindNewRemoteMissileEnt( node, "none" );
  }
}

nodeGetRemoteMissileOrigin(node, remoteMissileSpawns, type) {
  if(GetDvarInt("scr_remoteMissile_redo_node", 0) != 0) {
    if(nodeHasRemoteMissileDataSet(node)) {
      return _nodeFindNewRemoteMissileOrg(node, remoteMissileSpawns, type);
    }

    return;
  }

  if(nodeHasRemoteMissileDataSet(node)) {
    if(!nodeIsRemoteMissileFromAbove(node)) {
      return nodeGetRemoteMissleEntOrg(node, remoteMissileSpawns);
    } else {
      return nodeGetRemoteMissileOrgFromAbove(node);
    }
  } else {
    return _nodeFindNewRemoteMissileOrg(node, remoteMissileSpawns, type);
  }
}

nodeIsPathnode(node) {
  return (isDefined(node.type));
}

nodeIsRemoteMissileFromAbove(node) {
  return ((nodeIsPathnode(node) && NodeHasRemoteMissileSet(node) && NodeGetRemoteMissileName(node) == "up") || isDefined(node.bestMissileSpawnAbove));
}

nodeHasRemoteMissileDataSet(node) {
  return ((nodeIsPathnode(node) && NodeHasRemoteMissileSet(node)) || (isDefined(node.bestMissileSpawnAbove) || isDefined(node.bestMissileSpawn)));
}

nodeGetRemoteMissileOrgFromAbove(node) {
  return getStartPositionAbove(node);
}

nodeTestFireFromAbove(node, type) {
  org = getStartPositionAbove(node);

  passed = remoteMissileEntTraceToOriginPassedWrapper(org, node.origin, type);
  /# debugPlacementLine( org, node.origin, ( 0, 1, 0 ), ( 1, 0, 0 ), !passed );
  if(passed) {
    node.bestMissileSpawnAbove = org;
    return org;
  }
}

nodeGetRemoteMissleEntOrg(node, remoteMissileSpawns) {
  remoteMissileEnt = undefined;
  if(nodeIsPathnode(node) && NodeHasRemoteMissileSet(node)) {
    name = NodeGetRemoteMissileName(node);
    foreach(ent in remoteMissileSpawns) {
      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == name) {
        remoteMissileEnt = ent;
      }
    }
  } else if(isDefined(node.bestMissileSpawn)) {
    remoteMissileEnt = node.bestMissileSpawn;
  }

  Assert(isDefined(remoteMissileEnt));

  dir = VectorNormalize(remoteMissileEnt.origin - node.origin);
  return (node.origin + (dir * ORBITAL_TRACE_DIST));
}

nodeFindRemoteMissleEnt(node, remoteMissileSpawns, type) {
  remoteMissileSpawns = SortByDistance(remoteMissileSpawns, node.origin);
  foreach(ent in remoteMissileSpawns) {
    passed = remoteMissileEntTraceToOriginPassedWrapper(ent.origin, node.origin, type);
    /# debugPlacementLine( ent.origin, node.origin, ( 0, 1, 0 ), ( 1, 0, 0 ), !passed );
    if(passed) {
      node.bestMissileSpawn = ent;
      return ent;
    }
    waitframe();
  }
}

remoteMissileEntTraceToOriginPassedWrapper(remoteMissileSpawnOrigin, groundOrigin, type) {
  if(level.orbital_util_remote_traces_frame != GetTime()) {
    level.orbital_util_remote_traces_frame = GetTime();
    level.orbital_util_remote_traces = ORBITAL_BULLETTRACE_MAX_PER_FRAME;
  }

  if(level.orbital_util_remote_traces <= 0) {
    if(level.orbital_util_last_trace != GetTime()) {
      waitframe();
      level.orbital_util_last_trace = GetTime();
    }
    level.orbital_util_remote_traces = ORBITAL_BULLETTRACE_MAX_PER_FRAME;
  }

  level.orbital_util_remote_traces--;

  radius = ORBITAL_TRACE_CP_RADIUS;
  if(type == "goliath") {
    radius = ORBITAL_TRACE_G_RADIUS;
  }

  return RemoteMissileEntTraceToOriginPassed(remoteMissileSpawnOrigin, groundOrigin, radius, true);
}

nodeCanHitGround(node, type) {
  if(isDefined(type) && type == "goliath") {
    if(goliathBadLandingCheck(node.origin)) {
      return false;
    }
  }
  if(NodeHasRemoteMissileSet(node)) {
    return (NodeGetRemoteMissileName(node) != "none");
  } else {
    return NodeExposedToSky(node, true);
  }
}

carepackageTrace(position, player, type) {
  HEIGHT = 100;
  if(type == "goliath") {
    radius = ORBITAL_TRACE_G_RADIUS;
  } else {
    radius = ORBITAL_TRACE_CP_RADIUS;
  }

  foreach(marker in level.orbitalDropMarkers) {
    dist = radius;
    if(marker.orbitalType == "goliath") {
      dist += ORBITAL_TRACE_G_RADIUS;
    } else {
      dist += ORBITAL_TRACE_CP_RADIUS;
    }
    distSqMin = dist * dist;
    distSq = Distance2DSquared(marker.origin, position);
    if(distSq < distSqMin) {
      return false;
    }
  }

  if(level.orbital_util_capsule_traces_frame != GetTime()) {
    level.orbital_util_capsule_traces_frame = GetTime();
    level.orbital_util_capsule_traces = ORBITAL_BULLETTRACE_MAX_PER_FRAME;
  }

  if(level.orbital_util_capsule_traces <= 0) {
    if(level.orbital_util_last_trace != GetTime()) {
      waitframe();
      level.orbital_util_last_trace = GetTime();
    }
    level.orbital_util_capsule_traces = ORBITAL_BULLETTRACE_MAX_PER_FRAME;
  }

  level.orbital_util_capsule_traces--;

  return CapsuleTracePassed(position + ORBITAL_TRACE_GROUND_OFFSET, radius, radius * 2, player, false);
}

playerGetNearestNode(point, type) {
  if(!isDefined(point)) {
    DIST = 300;
    start = self getEye();
    dir = anglesToForward(self.angles);
    end = start + (dir * DIST);
    trace = bulletTrace(start, end, false, self);

    point = end;
    if(trace["fraction"] < 1) {
      point = start + (dir * DIST * trace["fraction"]);
    }
  }

  nearestNode = GetClosestNodeInSight(point, true);
  nearestNodeValid = isDefined(nearestNode);
  if(nearestNodeValid) {
    nearestNodeValid = nodeCanHitGround(nearestNode, type) && carepackageTrace(nearestNode.origin, self, type);
    /#debugPlacementBox( nearestNode.origin + ( 0, 0, 20 ), ( 0, 1, 0 ), ( 1, 0, 0 ), !nearestNodeValid );
  }

  if(nearestNodeValid) {
    return nearestNode;
  }

  result = spawnStruct();
  result.maxTracesPerFrame = 5;
  result.maxNodes = 20;
  result.numTraces = 5;
  self playerFindNodeInFront(point, type, result);
  bestNode = result.nearestNode;
  if(isDefined(bestNode)) {
    return bestNode;
  }

  if(!isDefined(nearestNode)) {
    nearestNode = self playerGetClosestNode(500, 100, self.origin, false, true, type);
    if(!isDefined(nearestNode)) {
      nearestNode = self playerGetClosestNode(500, 0, self.origin, false, false, type);
    }
    if(!isDefined(nearestNode)) {
      nearestNode = self GetNearestNode();
    }
  }

  self.lastNearestNode = nearestNode;

  if(isDefined(nearestNode)) {
    return playerFindAltNode(nearestNode, type);
  }
}

goliathBadLandingCheck(pos) {
  if(isDefined(level.goliath_bad_landing_volumes)) {
    foreach(trig_volume in level.goliath_bad_landing_volumes) {
      if(IsPointInVolume(pos, trig_volume)) {
        return true;
      }
    }
  }
  return false;
}

playerFindNodeInFront(point, type, result) {
  maxDistSearch = ORBITAL_DIST_FROM_PLAYER;
  minDistSearch = 100;

  nodeFound = playerFindNodeInFrontInternal(point, minDistSearch, maxDistSearch, type, result);

  if(!isDefined(nodeFound) && result.maxNodes > 0) {
    minDistSearch = 0;

    nodeFound = playerFindNodeInFrontInternal(point, minDistSearch, maxDistSearch, type, result);
  }

  result.nearestNode = nodeFound;
}

playerFindNodeInFrontInternal(point, minDistSearch, maxDistSearch, type, result) {
  while(minDistSearch < maxDistSearch && result.maxNodes > 0) {
    nextNode = self playerGetClosestNode(maxDistSearch, minDistSearch, point, true, true, type);

    if(result.numTraces <= 0 && !traceDoneRecently()) {
      waitframe();
      result.numTraces = result.maxTracesPerFrame;
    }

    if(isDefined(nextNode)) {
      result.numTraces--;
      result.maxNodes--;
      start = self getEye();
      end = nextNode.origin + ORBITAL_TRACE_GROUND_OFFSET;
      trace = bulletTrace(start, end, false, self);

      nextNodeValid = (trace["fraction"] == 1) && carepackageTrace(nextNode.origin, self, type);
      /#debugPlacementBox( nextNode.origin + ( 0, 0, 20 ), ( 0, 1, 0 ), ( 1, 0, 0 ), !nextNodeValid );
      if(nextNodeValid) {
        return nextNode;
      }

      minDistSearch = Distance(point, nextNode.origin) + 1;
    } else {
      minDistSearch = maxDistSearch + 1;
    }
  }
}

playerFindAltNode(nearestNode, type) {
  bestNode = checkNodeStart(nearestNode, self, type);

  if(isDefined(bestNode)) {
    if(type == "goliath") {
      if(goliathBadLandingCheck(bestNode.origin)) {
        return undefined;
      }
    }
    return bestNode;
  }
}

traceDoneRecently() {
  return (level.orbital_util_last_trace == GetTime());
}

checkNodeStart(startNode, player, type) {
  MAX_DIST_SQ = ORBITAL_DIST_FROM_PLAYER * ORBITAL_DIST_FROM_PLAYER;
  NODES_PER_FRAME = 20;

  startNode.linkDistance = 0;
  startNode.nodeChecked = true;
  nodeContainer = spawnStruct();
  nodeContainer.nodesToCheck = [];
  nodeContainer.nodesChecked = [];
  nodeContainer.nodesChecked["" + startNode GetNodeNumber()] = startNode;
  nodeContainer.nextNodes = GetLinkedNodes(startNode, true);
  addNodesToBeChecked(nodeContainer, 1, startNode, MAX_DIST_SQ, player, type);
  numNodes = 0;
  while(true) {
    nextNode = getNextNode(nodeContainer);
    if(isDefined(nextNode)) {
      numNodes++;
      if(!carepackageTrace(nextNode.origin, player, type)) {
        nextNode.nodeChecked = true;
        nodeContainer.nodesToCheck["" + nextNode GetNodeNumber()] = undefined;
        nodeContainer.nodesChecked["" + nextNode GetNodeNumber()] = nextNode;
        /# drawBadPathDebug( nextNode );
        nextLinkDistance = nextNode.linkDistance + 1;

        if(nextLinkDistance <= ORBITAL_FIND_NODE_MAX_LINKS) {
          nodeContainer.nextNodes = GetLinkedNodes(nextNode, true);
          addNodesToBeChecked(nodeContainer, nextLinkDistance, nextNode, MAX_DIST_SQ, player, type);
        }
      } else {
        cleanupNodeFields(nodeContainer);
        /# drawParentPathDebug( nextNode ); /
        # removeNodeParents(nodeContainer);
        return nextNode;
      }
    } else {
      cleanupNodeFields(nodeContainer);

      /# removeNodeParents( nodeContainer );
      return;
    }

    if(numNodes >= NODES_PER_FRAME) {
      if(!traceDoneRecently()) {
        waitframe();
      }
      numNodes = 0;
    }
  }
}

cleanupNodeFields(nodeContainer) {
  foreach(node in nodeContainer.nodesToCheck) {
    node.linkDistance = undefined;
    node.nodeChecked = undefined;
  }
  foreach(node in nodeContainer.nodesChecked) {
    node.linkDistance = undefined;
    node.nodeChecked = undefined;
  }
}

getNextNode(nodeContainer) {
  if(nodeContainer.nodesToCheck.size == 0) {
    return;
  }

  bestNode = undefined;
  bestLinkDistance = undefined;
  keys = GetArrayKeys(nodeContainer.nodesToCheck);
  for(i = 0; i < keys.size; i++) {
    node = nodeContainer.nodesToCheck[keys[i]];
    if(!isDefined(bestNode) || node.linkDistance < bestLinkDistance) {
      bestNode = node;
      bestLinkDistance = node.linkDistance;
    }
  }

  return bestNode;
}

addNodesToBeChecked(nodeContainer, linkDistance, parentNode, maxDistSq, player, type) {
  for(i = 0; i < nodeContainer.nextNodes.size; i++) {
    node = nodeContainer.nextNodes[i];
    if(!isDefined(node.nodeChecked)) {
      validNode = nodeCanHitGround(node, type);

      if(validNode) {
        distSq = DistanceSquared(node.origin, player.origin);
        validNode = distSq < maxDistSq;
      }

      if(!validNode) {
        node.nodeChecked = true;
        nodeContainer.nodesChecked["" + node GetNodeNumber()] = node;
      } else {
        if(!isDefined(node.linkDistance)) {
          node.linkDistance = linkDistance;
          nodeContainer.nodesToCheck["" + node GetNodeNumber()] = node;
          /# addNodeParent( node, parentNode );
        } else {
          if(node.linkDistance > linkDistance) {
            node.linkDistance = linkDistance;
            /# addNodeParent( node, parentNode );
          }
        }
      }
    }
  }
}

playerGetClosestNode(maxRadius, minRadius, point, checkExposed, checkPlayerFov, type) {
  if(!isDefined(maxRadius)) {
    maxRadius = 1500;
  }
  if(!isDefined(minRadius)) {
    minRadius = 0;
  }
  if(!isDefined(point)) {
    point = self.origin;
  }

  radiusIncrement = 100;

  nextMinRadius = minRadius;
  nextMaxRadius = minRadius + radiusIncrement;

  if(nextMaxRadius > maxRadius) {
    nextMaxRadius = maxRadius;
  }

  while(nextMaxRadius <= maxRadius && nextMinRadius < maxRadius) {
    node = self playerGetClosestNodeInternal(nextMaxRadius, nextMinRadius, point, checkExposed, checkPlayerFov, type);

    if(isDefined(node)) {
      return node;
    }

    nextMinRadius += radiusIncrement;
    nextMaxRadius += radiusIncrement;

    if(nextMaxRadius > maxRadius) {
      nextMaxRadius = maxRadius;
    }
  }
}

playerGetClosestNodeInternal(maxRadius, minRadius, point, checkExposed, checkPlayerFov, type) {
  valid = true;

  nodes = GetNodesInRadiusSorted(point, maxRadius, minRadius, 120, "path");
  for(i = 0; i < nodes.size; i++) {
    if(checkExposed) {
      valid = valid &nodeCanHitGround(nodes[i], type);
    }
    if(checkPlayerFov) {
      valid = valid &self playerWithinFOV2D(nodes[i].origin);
    }

    if(valid) {
      return nodes[i];
    }
  }
}

playerWithinFov2D(origin) {
  fov = cos(60);
  normal = VectorNormalize((origin[0], origin[1], 0) - (self.origin[0], self.origin[1], 0));
  forward = anglesToForward((0, self.angles[1], 0));
  return VectorDot(forward, normal) >= fov;
}

_addDropMarkerInternal(markerEnt) {
  markerEnt waittill("death");

  level.orbitalDropMarkers = array_remove(level.orbitalDropMarkers, markerEnt);
}

nodeSetRemoteMissileNameWrapper(origin, name) {
  AssertEx(name == "0" || name == "1" || name == "2" || name == "3" || name == "4" || name == "up" || name == "none");

  nodes = GetNodesInRadiusSorted(origin, 24, 0);

  if(nodes.size > 0) {
    node = nodes[0];

    NodeSetRemoteMissileName(node, name);
  } else {
    /# PrintLn( "Error: nodeSetRemoteMissileNameWrapper() could not find a node at origin: " + origin );
  }
}

addNodeParent(node, parent) {
  if(GetDvar("scr_orbital_path_debug", "0") != "0") {
    node.parent = parent;
  }
}

removeNodeParents(nodeContainer) {
  if(GetDvar("scr_orbital_path_debug", "0") != "0") {
    foreach(node in nodeContainer.nodesToCheck) {
      node.parent = undefined;
    }
    foreach(node in nodeContainer.nodesChecked) {
      node.parent = undefined;
    }
  }
}

drawBadPathDebug(node) {
  if(GetDvar("scr_orbital_path_debug", "0") != "0") {
    OFFSET = (0, 0, 2);
    if(isDefined(node.parent)) {
      Line(node.origin + OFFSET, node.parent.origin + OFFSET, (1, 0, 0), 1, 0, GetDvarInt("scr_orbital_path_debug_frames", 1000));
    }
    Sphere(node.origin + OFFSET, 4.0, (0, 0, 1), 0, GetDvarInt("scr_orbital_path_debug_frames", 1000));
  }
}

drawParentPathDebug(node) {
  if(GetDvar("scr_orbital_path_debug", "0") != "0") {
    OFFSET = (0, 0, 10);
    numLinks = 0;
    previousNode = node;
    nextNode = node.parent;
    Sphere(previousNode.origin + OFFSET, 5.0, (0, 1, 1), 0, GetDvarInt("scr_orbital_path_debug_frames", 1000));
    Print("PATH DEBUG: Nodes =" + previousNode GetNodeNumber());
    while(isDefined(nextNode) && numLinks <= ORBITAL_FIND_NODE_MAX_LINKS) {
      numLinks++;
      Line(previousNode.origin + OFFSET, nextNode.origin + OFFSET, (0, 1, 0), 1, 0, GetDvarInt("scr_orbital_path_debug_frames", 1000));
      Sphere(nextNode.origin + OFFSET, 5.0, (0, 1, 1), 0, GetDvarInt("scr_orbital_path_debug_frames", 1000));
      Print(" <- " + nextNode GetNodeNumber());
      previousNode = nextNode;
      nextNode = nextNode.parent;
    }
    PrintLn("");
    PrintLn("PATH DEBUG: num links: " + numLinks);
  }
}

debugBestNode(node) {
  if(!isDefined(node)) {
    return;
  }

  if(GetDvar("scr_goliath_debug_placement", "0") != "0") {
    debugPlacementBox(node.origin + (0, 0, 20), (0, 1, 0));
    nextNode = node.parentNode;
    prevNode = node;
    while(isDefined(nextNode)) {
      debugPlacementBox(nextNode.origin + (0, 0, 20), (0, 0, 1));
      if(isDefined(prevNode)) {
        debugPlacementLine(nextNode.origin + (0, 0, 20), prevNode.origin + (0, 0, 20), (0, 1, 1));
      }

      prevNode = nextNode;
      nextNode = nextNode.parentNode;
    }
  }
}

debugPlacementLine(pos1, pos2, color1, color2, colorCondition) {
  if(!isDefined(colorCondition)) {
    colorCondition = false;
  }

  if(GetDvar("scr_goliath_debug_placement", "0") != "0") {
    color = color1;
    if(colorCondition) {
      color = color2;
    }
    Line(pos1, pos2, color, 1, 0, GetDvarInt("scr_goliath_debug_placement_frames", 1000));
  }
}

debugPlacementSphere(pos, radius, color1, color2, colorCondition) {
  if(!isDefined(colorCondition)) {
    colorCondition = false;
  }

  if(GetDvar("scr_goliath_debug_placement", "0") != "0") {
    color = color1;
    if(colorCondition) {
      color = color2;
    }
    Sphere(pos, radius, color, 0, GetDvarInt("scr_goliath_debug_placement_frames", 1000));
  }
}

debugPlacementBox(pos, color1, color2, colorCondition) {
  if(!isDefined(colorCondition)) {
    colorCondition = false;
  }

  if(GetDvar("scr_goliath_debug_placement", "0") != "0") {
    color = color1;
    if(colorCondition) {
      color = color2;
    }
    Box(pos, 0, color, 0, GetDvarInt("scr_goliath_debug_placement_frames", 1000));
  }
}

debugNodeFindNewRemoteMissileEnt(node, remoteMissileEntName) {
  if(GetDvarInt("scr_remoteMissile_redo_node", 0) != 0) {
    PrintLn("*********************************************************************");
    PrintLn("To change this nodes remote missile ent add this to your level gsc: ");
    Println("maps\\mp\\killstreaks\\_orbital_util::nodeSetRemoteMissileNameWrapper( " + node.origin + ", \"" + remoteMissileEntName + "\" );");
    PrintLn("*********************************************************************");

    NodeSetRemoteMissileName(node, remoteMissileEntName);
  }
}
# /