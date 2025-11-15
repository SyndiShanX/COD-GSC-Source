/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_debug.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

debugchains() {
  nodes = getallnodes();
  fnodenum = 0;
  fnodes = [];
  for(i = 0; i < nodes.size; i++) {
    if((!(nodes[i] has_spawnflag(level.SPAWNFLAG_PATH_NOT_CHAIN))) &&
      (
        ((isDefined(nodes[i].target)) && ((getnodearray(nodes[i].target, "targetname")).size > 0)) ||
        ((isDefined(nodes[i].targetname)) && ((getnodearray(nodes[i].targetname, "target")).size > 0))
      )
    ) {
      fnodes[fnodenum] = nodes[i];
      fnodenum++;
    }
  }
  count = 0;
  while(1) {
    if(getDvar(#"chain") == "1") {
      for(i = 0; i < fnodes.size; i++) {
        players = get_players();
        if(distance(players[0] getorigin(), fnodes[i].origin) < 1500) {
          print3d(fnodes[i].origin, "yo", (0.2, 0.8, 0.5), 0.45);
        }
      }
      friends = getaiarray("allies");
      for(i = 0; i < friends.size; i++) {
        node = friends[i] animscripts\utility::GetClaimedNode();
        if(isDefined(node)) {
          line(friends[i].origin + (0, 0, 35), node.origin, (0.2, 0.5, 0.8), 0.5);
        }
      }
    }
    maps\_spawner::waitframe();
  }
}

debug_enemyPos(num) {
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(ai[i] getEntityNumber() != num) {
      continue;
    }
    ai[i] thread debug_enemyPosProc();
    break;
  }
}

debug_stopEnemyPos(num) {
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    if(ai[i] getEntityNumber() != num) {
      continue;
    }
    ai[i] notify("stop_drawing_enemy_pos");
    break;
  }
}

debug_enemyPosProc() {
  self endon("death");
  self endon("stop_drawing_enemy_pos");
  for(;;) {
    wait(0.05);
    if(isalive(self.enemy)) {
      line(self.origin + (0, 0, 70), self.enemy.origin + (0, 0, 70), (0.8, 0.2, 0.0), 0.5);
    }
    if(!self animscripts\utility::hasEnemySightPos()) {
      continue;
    }
    pos = animscripts\utility::getEnemySightPos();
    line(self.origin + (0, 0, 70), pos, (0.9, 0.5, 0.3), 0.5);
  }
}

debug_enemyPosReplay() {
  ai = getaiarray();
  guy = undefined;
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isalive(guy)) {
      continue;
    }
    if(isDefined(guy.lastEnemySightPos)) {
      line(guy.origin + (0, 0, 65), guy.lastEnemySightPos, (1, 0, 1), 0.5);
    }
    if(guy.goodShootPosValid) {
      if(guy.team == "axis") {
        color = (1, 0, 0);
      } else {
        color = (0, 0, 1);
      }
      nodeOffset = guy.origin + (0, 0, 54);
      if(isDefined(guy.node)) {
        if(guy.node.type == "Cover Left") {
          cornerNode = true;
          nodeOffset = anglestoright(guy.node.angles);
          nodeOffset = vector_scale(nodeOffset, -32);
          nodeOffset = (nodeOffset[0], nodeOffset[1], 64);
          nodeOffset = guy.node.origin + nodeOffset;
        } else if(guy.node.type == "Cover Right") {
          cornerNode = true;
          nodeOffset = anglestoright(guy.node.angles);
          nodeOffset = vector_scale(nodeOffset, 32);
          nodeOffset = (nodeOffset[0], nodeOffset[1], 64);
          nodeOffset = guy.node.origin + nodeOffset;
        }
      }
      draw_arrow(nodeOffset, guy.goodShootPos, color);
    }
  }
  if(1) {
    return;
  }
  if(!isalive(guy)) {
    return;
  }
  if(isalive(guy.enemy)) {
    line(guy.origin + (0, 0, 70), guy.enemy.origin + (0, 0, 70), (0.6, 0.2, 0.2), 0.5);
  }
  if(isDefined(guy.lastEnemySightPos)) {
    line(guy.origin + (0, 0, 65), guy.lastEnemySightPos, (0, 0, 1), 0.5);
  }
  if(isalive(guy.goodEnemy)) {
    line(guy.origin + (0, 0, 50), guy.goodEnemy.origin, (1, 0, 0), 0.5);
  }
  if(!guy animscripts\utility::hasEnemySightPos()) {
    return;
  }
  pos = guy animscripts\utility::getEnemySightPos();
  line(guy.origin + (0, 0, 55), pos, (0.2, 0.2, 0.6), 0.5);
  if(guy.goodShootPosValid) {
    line(guy.origin + (0, 0, 45), guy.goodShootPos, (0.2, 0.6, 0.2), 0.5);
  }
}

drawEntTag(num) {}
drawTag(tag, opcolor) {
  org = self GetTagOrigin(tag);
  ang = self GetTagAngles(tag);
  drawArrow(org, ang, opcolor);
}

drawOrgForever(opcolor) {
  for(;;) {
    drawArrow(self.origin, self.angles, opcolor);
    wait(0.05);
  }
}

drawArrowForever(org, ang) {
  for(;;) {
    drawArrow(org, ang);
    wait(0.05);
  }
}

drawOriginForever() {
  for(;;) {
    drawArrow(self.origin, self.angles);
    wait(0.05);
  }
}

drawArrow(org, ang, opcolor) {
  scale = 50;
  forward = anglesToForward(ang);
  forwardFar = vector_scale(forward, scale);
  forwardClose = vector_scale(forward, (scale * 0.8));
  right = anglestoright(ang);
  leftdraw = vector_scale(right, (scale * -0.2));
  rightdraw = vector_scale(right, (scale * 0.2));
  up = anglestoup(ang);
  right = vector_scale(right, scale);
  up = vector_scale(up, scale);
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);
  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }
  line(org, org + forwardFar, red, 0.9);
  line(org + forwardFar, org + forwardClose + rightdraw, red, 0.9);
  line(org + forwardFar, org + forwardClose + leftdraw, red, 0.9);
  line(org, org + right, blue, 0.9);
  line(org, org + up, green, 0.9);
}

drawPlayerViewForever() {
  for(;;) {
    drawArrow(level.player.origin, level.player getplayerangles(), (1, 1, 1));
    wait(0.05);
  }
}

drawTagForever(tag, opcolor) {
  self endon("death");
  for(;;) {
    drawTag(tag, opcolor);
    wait(0.05);
  }
}

dragTagUntilDeath(tag) {
  for(;;) {
    if(!isDefined(self.origin)) {
      break;
    }
    drawTag(tag);
    wait(0.05);
  }
}

viewTag(type, tag) {
  if(type == "ai") {
    ai = getaiarray();
    for(i = 0; i < ai.size; i++) {
      ai[i] drawTag(tag);
    }
  } else {
    vehicle = getEntArray("script_vehicle", "classname");
    for(i = 0; i < vehicle.size; i++) {
      vehicle[i] drawTag(tag);
    }
  }
}

debug_corner() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i].ignoreme = true;
  }
  nodes = getallnodes();
  corners = [];
  for(i = 0; i < nodes.size; i++) {
    if(nodes[i].type == "Cover Left") {
      corners[corners.size] = nodes[i];
    }
    if(nodes[i].type == "Cover Right") {
      corners[corners.size] = nodes[i];
    }
  }
  ai = getaiarray();
  for(i = 0; i < ai.size; i++) {
    ai[i] delete();
  }
  level.debugspawners = getspawnerarray();
  level.activeNodes = [];
  level.completedNodes = [];
  for(i = 0; i < level.debugspawners.size; i++) {
    level.debugspawners[i].targetname = "blah";
  }
  covered = 0;
  for(i = 0; i < 30; i++) {
    if(i >= corners.size) {
      break;
    }
    corners[i] thread coverTest();
    covered++;
  }
  if(corners.size <= 30) {
    return;
  }
  for(;;) {
    level waittill("debug_next_corner");
    if(covered >= corners.size) {
      covered = 0;
    }
    corners[covered] thread coverTest();
    covered++;
  }
}

coverTest() {
  coverSetupAnim();
}

#using_animtree("generic_human");
coverSetupAnim() {
  spawn = undefined;
  spawner = undefined;
  for(;;) {
    for(i = 0; i < level.debugspawners.size; i++) {
      wait(0.05);
      spawner = level.debugspawners[i];
      nearActive = false;
      for(p = 0; p < level.activeNodes.size; p++) {
        if(distance(level.activeNodes[p].origin, self.origin) > 250) {
          continue;
        }
        nearActive = true;
        break;
      }
      if(nearActive) {
        continue;
      }
      completed = false;
      for(p = 0; p < level.completedNodes.size; p++) {
        if(level.completedNodes[p] != self) {
          continue;
        }
        completed = true;
        break;
      }
      if(completed) {
        continue;
      }
      level.activeNodes[level.activeNodes.size] = self;
      spawner.origin = self.origin;
      spawner.angles = self.angles;
      spawner.count = 1;
      spawn = spawner stalingradspawn();
      if(spawn_failed(spawn)) {
        removeActiveSpawner(self);
        continue;
      }
      break;
    }
    if(isalive(spawn)) {
      break;
    }
  }
  wait(1);
  if(isalive(spawn)) {
    spawn.ignoreme = true;
    spawn.team = "neutral";
    spawn setgoalpos(spawn.origin);
    thread createLine(self.origin);
    spawn thread debugorigin();
    thread createLineConstantly(spawn);
    spawn waittill("death");
  }
  removeActiveSpawner(self);
  level.completedNodes[level.completedNodes.size] = self;
}

removeActiveSpawner(spawner) {
  newSpawners = [];
  for(p = 0; p < level.activeNodes.size; p++) {
    if(level.activeNodes[p] == spawner) {
      continue;
    }
    newSpawners[newSpawners.size] = level.activeNodes[p];
  }
  level.activeNodes = newSpawners;
}

createLine(org) {
  for(;;) {
    line(org + (0, 0, 35), org, (0.2, 0.5, 0.8), 0.5);
    wait(0.05);
  }
}

createLineConstantly(ent) {
  org = undefined;
  while(isalive(ent)) {
    org = ent.origin;
    wait(0.05);
  }
  for(;;) {
    line(org + (0, 0, 35), org, (1.0, 0.2, 0.1), 0.5);
    wait(0.05);
  }
}

debugMisstime() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");
  for(;;) {
    if(self.a.misstime <= 0) {
      print3d(self gettagorigin("TAG_EYE") + (0, 0, 15), "hit", (0.3, 1, 1), 1);
    } else {
      print3d(self gettagorigin("TAG_EYE") + (0, 0, 15), self.a.misstime / 20, (0.3, 1, 1), 1);
    }
    wait(0.05);
  }
}

debugMisstimeOff() {
  self notify("stopdebugmisstime");
}

setEmptyDvar(dvar, setting) {}
debugJump(num) {}
debugDvars() {}
remove_reflection_objects() {}
create_reflection_objects() {}
create_reflection_object() {}
debug_reflection() {}
debug_reflection_buttons() {}
showDebugTrace() {
  startOverride = undefined;
  endOverride = undefined;
  startOverride = (15.1859, -12.2822, 4.071);
  endOverride = (947.2, -10918, 64.9514);
  assert(!isDefined(level.traceEnd));
  for(;;) {
    players = get_players();
    wait(0.05);
    start = startOverride;
    end = endOverride;
    if(!isDefined(startOverride)) {
      start = level.traceStart;
    }
    if(!isDefined(endOverride)) {
      end = players[0] getEye();
    }
    trace = bulletTrace(start, end, false, undefined);
    line(start, trace["position"], (0.9, 0.5, 0.8), 0.5);
  }
}

hatmodel() {}
debug_nuke() {
  players = get_players();
  player = players[0];
  dvar = getDvar(#"debug_nuke");
  if(dvar == "on") {
    ai = getaispeciesarray("axis", "all");
    for(i = 0; i < ai.size; i++) {
      ai[i] dodamage(300, (0, 0, 0), player);
    }
  } else if(dvar == "ai") {
    ai = getaiarray("axis");
    for(i = 0; i < ai.size; i++) {
      ai[i] dodamage(300, (0, 0, 0), player);
    }
  } else if(dvar == "dogs") {
    ai = getaispeciesarray("axis", "dog");
    for(i = 0; i < ai.size; i++) {
      ai[i] dodamage(300, (0, 0, 0), player);
    }
  }
  setdvar("debug_nuke", "off");
}

debug_missTime() {}
camera() {
  wait(0.05);
  cameras = getEntArray("camera", "targetname");
  for(i = 0; i < cameras.size; i++) {
    ent = getEnt(cameras[i].target, "targetname");
    cameras[i].origin2 = ent.origin;
    cameras[i].angles = vectortoangles(ent.origin - cameras[i].origin);
  }
  for(;;) {
    ai = getaiarray("axis");
    if(!ai.size) {
      freePlayer();
      wait(0.5);
      continue;
    }
    cameraWithEnemy = [];
    for(i = 0; i < cameras.size; i++) {
      for(p = 0; p < ai.size; p++) {
        if(distance(cameras[i].origin, ai[p].origin) > 256) {
          continue;
        }
        cameraWithEnemy[cameraWithEnemy.size] = cameras[i];
        break;
      }
    }
    if(!cameraWithEnemy.size) {
      freePlayer();
      wait(0.5);
      continue;
    }
    cameraWithPlayer = [];
    for(i = 0; i < cameraWithEnemy.size; i++) {
      camera = cameraWithEnemy[i];
      start = camera.origin2;
      end = camera.origin;
      difference = vectorToAngles((end[0], end[1], end[2]) - (start[0], start[1], start[2]));
      angles = (0, difference[1], 0);
      forward = anglesToForward(angles);
      players = get_players();
      difference = vectornormalize(end - players[0].origin);
      dot = vectordot(forward, difference);
      if(dot < 0.85) {
        continue;
      }
      cameraWithPlayer[cameraWithPlayer.size] = camera;
    }
    if(!cameraWithPlayer.size) {
      freePlayer();
      wait(0.5);
      continue;
    }
    players = get_players();
    dist = distance(players[0].origin, cameraWithPlayer[0].origin);
    newcam = cameraWithPlayer[0];
    for(i = 1; i < cameraWithPlayer.size; i++) {
      newdist = distance(players[0].origin, cameraWithPlayer[i].origin);
      if(newdist > dist) {
        continue;
      }
      newcam = cameraWithPlayer[i];
      dist = newdist;
    }
    setPlayerToCamera(newcam);
    wait(3);
  }
}

freePlayer() {
  setdvar("cl_freemove", "0");
}

setPlayerToCamera(camera) {
  setdvar("cl_freemove", "2");
  setdebugangles(camera.angles);
  setdebugorigin(camera.origin + (0, 0, -60));
}

deathspawnerPreview() {
  waittillframeend;
  for(i = 0; i < 50; i++) {
    if(!isDefined(level.deathspawnerents[i])) {
      continue;
    }
    array = level.deathspawnerents[i];
    for(p = 0; p < array.size; p++) {
      ent = array[p];
      if(isDefined(ent.truecount)) {
        print3d(ent.origin, i + ": " + ent.truecount, (0, 0.8, 0.6), 5);
      } else {
        print3d(ent.origin, i + ": " + ".", (0, 0.8, 0.6), 5);
      }
    }
  }
}

lastSightPosWatch() {}
watchMinimap() {
  precacheItem("defaultweapon");
  while(1) {
    updateMinimapSetting();
    wait .25;
  }
}

updateMinimapSetting() {
  requiredMapAspectRatio = GetDvarFloat(#"scr_requiredMapAspectRatio");
  if(!isDefined(level.minimapheight)) {
    setdvar("scr_minimap_height", "0");
    level.minimapheight = 0;
  }
  minimapheight = GetDvarFloat(#"scr_minimap_height");
  if(minimapheight != level.minimapheight) {
    if(isDefined(level.minimaporigin)) {
      level.minimapplayer unlink();
      level.minimaporigin delete();
      level notify("end_draw_map_bounds");
    }
    if(minimapheight > 0) {
      level.minimapheight = minimapheight;
      players = get_players();
      player = players[0];
      corners = getEntArray("minimap_corner", "targetname");
      if(corners.size == 2) {
        viewpos = (corners[0].origin + corners[1].origin);
        viewpos = (viewpos[0] * .5, viewpos[1] * .5, viewpos[2] * .5);
        maxcorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
        mincorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
        if(corners[1].origin[0] > corners[0].origin[0]) {
          maxcorner = (corners[1].origin[0], maxcorner[1], maxcorner[2]);
        } else {
          mincorner = (corners[1].origin[0], mincorner[1], mincorner[2]);
        }
        if(corners[1].origin[1] > corners[0].origin[1]) {
          maxcorner = (maxcorner[0], corners[1].origin[1], maxcorner[2]);
        } else {
          mincorner = (mincorner[0], corners[1].origin[1], mincorner[2]);
        }
        viewpostocorner = maxcorner - viewpos;
        viewpos = (viewpos[0], viewpos[1], viewpos[2] + minimapheight);
        origin = spawn("script_origin", player.origin);
        northvector = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        eastvector = (northvector[1], 0 - northvector[0], 0);
        disttotop = vectordot(northvector, viewpostocorner);
        if(disttotop < 0) {
          disttotop = 0 - disttotop;
        }
        disttoside = vectordot(eastvector, viewpostocorner);
        if(disttoside < 0) {
          disttoside = 0 - disttoside;
        }
        if(requiredMapAspectRatio > 0) {
          mapAspectRatio = disttoside / disttotop;
          if(mapAspectRatio < requiredMapAspectRatio) {
            incr = requiredMapAspectRatio / mapAspectRatio;
            disttoside *= incr;
            addvec = vecscale(eastvector, vectordot(eastvector, maxcorner - viewpos) * (incr - 1));
            mincorner -= addvec;
            maxcorner += addvec;
          } else {
            incr = mapAspectRatio / requiredMapAspectRatio;
            disttotop *= incr;
            addvec = vecscale(northvector, vectordot(northvector, maxcorner - viewpos) * (incr - 1));
            mincorner -= addvec;
            maxcorner += addvec;
          }
        }
        if(level.console) {
          aspectratioguess = 16.0 / 9.0;
          angleside = 2 * atan(disttoside * .8 / minimapheight);
          angletop = 2 * atan(disttotop * aspectratioguess * .8 / minimapheight);
        } else {
          aspectratioguess = 4.0 / 3.0;
          angleside = 2 * atan(disttoside * 1.05 / minimapheight);
          angletop = 2 * atan(disttotop * aspectratioguess * 1.05 / minimapheight);
        }
        if(angleside > angletop) {
          angle = angleside;
        } else {
          angle = angletop;
        }
        znear = minimapheight - 1000;
        if(znear < 16) {
          znear = 16;
        }
        if(znear > 10000) {
          znear = 10000;
        }
        player playerlinktoabsolute(origin);
        origin.origin = viewpos + (0, 0, -62);
        origin.angles = (90, getnorthyaw(), 0);
        player GiveWeapon("defaultweapon");
        player setClientDvar("cg_fov", angle);
        level.minimapplayer = player;
        level.minimaporigin = origin;
        thread drawMiniMapBounds(viewpos, mincorner, maxcorner);
      } else {
        println("^1Error: There are not exactly 2 \"minimap_corner\" entities in the level.");
      }
    }
  }
}

getchains() {
  chainarray = [];
  chainarray = getEntArray("minimap_line", "script_noteworthy");
  array = [];
  for(i = 0; i < chainarray.size; i++) {
    array[i] = chainarray[i] getchain();
  }
  return array;
}

getchain() {
  array = [];
  ent = self;
  while(isDefined(ent)) {
    array[array.size] = ent;
    if(!isDefined(ent) || !isDefined(ent.target)) {
      break;
    }
    ent = getEnt(ent.target, "targetname");
    if(isDefined(ent) && ent == array[0]) {
      array[array.size] = ent;
      break;
    }
  }
  originarray = [];
  for(i = 0; i < array.size; i++) {
    originarray[i] = array[i].origin;
  }
  return originarray;
}

vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

drawMiniMapBounds(viewpos, mincorner, maxcorner) {
  level notify("end_draw_map_bounds");
  level endon("end_draw_map_bounds");
  viewheight = (viewpos[2] - maxcorner[2]);
  diaglen = length(mincorner - maxcorner);
  mincorneroffset = (mincorner - viewpos);
  mincorneroffset = vectornormalize((mincorneroffset[0], mincorneroffset[1], 0));
  mincorner = mincorner + vecscale(mincorneroffset, diaglen * 1 / 800 * 0);
  maxcorneroffset = (maxcorner - viewpos);
  maxcorneroffset = vectornormalize((maxcorneroffset[0], maxcorneroffset[1], 0));
  maxcorner = maxcorner + vecscale(maxcorneroffset, diaglen * 1 / 800 * 0);
  north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  diagonal = maxcorner - mincorner;
  side = vecscale(north, vectordot(diagonal, north));
  sidenorth = vecscale(north, abs(vectordot(diagonal, north)));
  corner0 = mincorner;
  corner1 = mincorner + side;
  corner2 = maxcorner;
  corner3 = maxcorner - side;
  toppos = vecscale(mincorner + maxcorner, .5) + vecscale(sidenorth, .51);
  textscale = diaglen * .003;
  chains = getchains();
  while(1) {
    line(corner0, corner1);
    line(corner1, corner2);
    line(corner2, corner3);
    line(corner3, corner0);
    array_levelthread(chains, maps\_utility::plot_points);
    print3d(toppos, "This Side Up", (1, 1, 1), 1, textscale);
    wait .05;
  }
}

debug_vehiclesittags() {
  vehicles = getEntArray("script_vehicle", "classname");
  type = "none";
  for(i = 0; i < vehicles.size; i++) {
    if(!isDefined(level.vehicle_aianims[vehicles[i].vehicletype])) {
      continue;
    }
    anims = level.vehicle_aianims[vehicles[i].vehicletype];
    for(j = 0; j < anims.size; j++) {
      players = get_players();
      if(isDefined(anims[j].sittag)) {
        vehicles[i] thread drawtag(anims[j].sittag);
        org = vehicles[i] gettagorigin(anims[j].sittag);
        if(players[0] islookingatorigin(org)) {
          print3d(org + (0, 0, 16), anims[j].sittag, (1, 1, 1), 1, 1);
        }
      }
    }
  }
}

islookingatorigin(origin) {
  normalvec = vectorNormalize(origin - self getShootAtPos());
  veccomp = vectorNormalize((origin - (0, 0, 24)) - self getShootAtPos());
  insidedot = vectordot(normalvec, veccomp);
  anglevec = anglesToForward(self getplayerangles());
  vectordot = vectordot(anglevec, normalvec);
  if(vectordot > insidedot) {
    return true;
  } else {
    return false;
  }
}

debug_colornodes() {
  wait(0.05);
  ai = getaiarray();
  array = [];
  array["axis"] = [];
  array["allies"] = [];
  array["neutral"] = [];
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isDefined(guy.currentColorCode)) {
      continue;
    }
    array[guy.team][guy.currentColorCode] = true;
    color = (1, 1, 1);
    if(isDefined(guy.script_forceColor)) {
      color = level.color_debug[guy.script_forceColor];
    }
    print3d(guy.origin + (0, 0, 50), guy.currentColorCode, color, 1, 1);
    if(guy.team == "axis") {
      continue;
    }
    guy try_to_draw_line_to_node();
  }
  draw_colorNodes(array, "allies");
  draw_colorNodes(array, "axis");
}

draw_colorNodes(array, team) {
  keys = getArrayKeys(array[team]);
  for(i = 0; i < keys.size; i++) {
    color = (1, 1, 1);
    color = level.color_debug[getsubstr(keys[i], 0, 1)];
    if(isDefined(level.colorNodes_debug_array[team][keys[i]])) {
      teamArray = level.colorNodes_debug_array[team][keys[i]];
      for(p = 0; p < teamArray.size; p++) {
        print3d(teamArray[p].origin, "N-" + keys[i], color, 1, 1);
      }
    }
  }
}

get_team_substr() {
  if(self.team == "allies") {
    if(!isDefined(self.node.script_color_allies)) {
      return;
    }
    return self.node.script_color_allies;
  }
  if(self.team == "axis") {
    if(!isDefined(self.node.script_color_axis)) {
      return;
    }
    return self.node.script_color_axis;
  }
}

try_to_draw_line_to_node() {
  if(!isDefined(self.node)) {
    return;
  }
  if(!isDefined(self.script_forceColor)) {
    return;
  }
  substr = get_team_substr();
  if(!isDefined(substr)) {
    return;
  }
  if(!issubstr(substr, self.script_forceColor)) {
    return;
  }
  line(self.origin + (0, 0, 64), self.node.origin, level.color_debug[self.script_forceColor]);
}

fogcheck() {
  if(getDvar(#"depth_close") == "") {
    setdvar("depth_close", "0");
  }
  if(getDvar(#"depth_far") == "") {
    setdvar("depth_far", "1500");
  }
  close = GetDvarInt(#"depth_close");
  far = GetDvarInt(#"depth_far");
  setexpfog(close, far, 1, 1, 1, 0);
}

debugThreat() {
  {
    level.last_threat_debug = gettime();
    thread debugThreatCalc();
  }
}

debugThreatCalc() {}
displayThreat(entity, entityGroup) {
  self endon("death");
  if(self.team == entity.team) {
    return;
  }
  selfthreat = 0;
  selfthreat += self.threatBias;
  threat = 0;
  threat += entity.threatBias;
  myGroup = undefined;
  if(isDefined(entityGroup)) {
    myGroup = self getthreatbiasgroup();
    if(isDefined(myGroup)) {
      threat += getthreatbias(entityGroup, myGroup);
      selfThreat += getthreatbias(myGroup, entityGroup);
    }
  }
  if(entity.ignoreme || threat < -900000) {
    threat = "Ignore";
  }
  if(self.ignoreme || selfthreat < -900000) {
    selfthreat = "Ignore";
  }
  players = get_players();
  timer = 1 * 20;
  col = (1, 0.5, 0.2);
  col2 = (0.2, 0.5, 1);
  pacifist = self != players[0] && self.pacifist;
  for(i = 0; i <= timer; i++) {
    print3d(self.origin + (0, 0, 65), "Him to Me:", col, 3);
    print3d(self.origin + (0, 0, 50), threat, col, 5);
    if(isDefined(entityGroup)) {
      print3d(self.origin + (0, 0, 35), entityGroup, col, 2);
    }
    print3d(self.origin + (0, 0, 15), "Me to Him:", col2, 3);
    print3d(self.origin + (0, 0, 0), selfThreat, col2, 5);
    if(isDefined(mygroup)) {
      print3d(self.origin + (0, 0, -15), mygroup, col2, 2);
    }
    if(pacifist) {
      print3d(self.origin + (0, 0, 25), "( Pacifist )", col2, 5);
    }
    wait(0.05);
  }
}

debugColorFriendlies() {
  level.debug_color_friendlies = [];
  level.debug_color_huds = [];
  level thread debugColorFriendliesToggleWatch();
  for(;;) {
    level waittill("updated_color_friendlies");
    draw_color_friendlies();
  }
}

debugColorFriendliesToggleWatch() {}
draw_color_friendlies() {
  level endon("updated_color_friendlies");
  keys = getarraykeys(level.debug_color_friendlies);
  colored_friendlies = [];
  colors = [];
  colors[colors.size] = "r";
  colors[colors.size] = "o";
  colors[colors.size] = "y";
  colors[colors.size] = "g";
  colors[colors.size] = "c";
  colors[colors.size] = "b";
  colors[colors.size] = "p";
  rgb = get_script_palette();
  for(i = 0; i < colors.size; i++) {
    colored_friendlies[colors[i]] = 0;
  }
  for(i = 0; i < keys.size; i++) {
    color = level.debug_color_friendlies[keys[i]];
    colored_friendlies[color]++;
  }
  for(i = 0; i < level.debug_color_huds.size; i++) {
    level.debug_color_huds[i] destroy();
  }
  level.debug_color_huds = [];
  x = 15;
  y = 365;
  offset_x = 25;
  offset_y = 25;
  for(i = 0; i < colors.size; i++) {
    if(colored_friendlies[colors[i]] <= 0) {
      continue;
    }
    for(p = 0; p < colored_friendlies[colors[i]]; p++) {
      overlay = newHudElem();
      overlay.x = x + 25 * p;
      overlay.y = y;
      overlay setshader("white", 16, 16);
      overlay.alignX = "left";
      overlay.alignY = "bottom";
      overlay.alpha = 1;
      overlay.color = rgb[colors[i]];
      level.debug_color_huds[level.debug_color_huds.size] = overlay;
    }
    y += offset_y;
  }
}

drawUsers() {
  if(isalive(self.color_user)) {
    line(self.origin + (0, 0, 35), self.color_user.origin + (0, 0, 35), (1, 1, 1), 1.0);
    print3d(self.origin + (0, 0, -25), "in-use", (1, 1, 1), 1, 1);
  }
}

colordebug() {
  wait(0.5);
  col = [];
  col[col.size] = "r";
  col[col.size] = "g";
  col[col.size] = "b";
  col[col.size] = "y";
  col[col.size] = "o";
  col[col.size] = "p";
  col[col.size] = "c";
  for(;;) {
    for(i = 0; i < col.size; i++) {
      color = level.currentColorForced["allies"][col[i]];
      if(isDefined(color)) {
        draw_colored_nodes(color);
      }
    }
    wait(0.05);
  }
}

draw_colored_nodes(color) {
  nodes = level.arrays_of_colorCoded_nodes["allies"][color];
  array_thread(nodes, ::drawUsers);
}

init_animSounds() {
  level.animSounds = [];
  level.animSound_aliases = [];
  waittillframeend;
  waittillframeend;
  animnames = getarraykeys(level.scr_notetrack);
  for(i = 0; i < animnames.size; i++) {
    init_notetracks_for_animname(animnames[i]);
  }
  animnames = getarraykeys(level.scr_animSound);
  for(i = 0; i < animnames.size; i++) {
    init_animSounds_for_animname(animnames[i]);
  }
}

init_notetracks_for_animname(animname) {
  notetracks = getarraykeys(level.scr_notetrack[animname]);
  for(i = 0; i < notetracks.size; i++) {
    soundalias = level.scr_notetrack[animname][i]["sound"];
    if(!isDefined(soundalias)) {
      continue;
    }
    anime = level.scr_notetrack[animname][i]["anime"];
    notetrack = level.scr_notetrack[animname][i]["notetrack"];
    level.animSound_aliases[animname][anime][notetrack]["soundalias"] = soundalias;
    if(isDefined(level.scr_notetrack[animname][i]["created_by_animSound"])) {
      level.animSound_aliases[animname][anime][notetrack]["created_by_animSound"] = true;
    }
  }
}

init_animSounds_for_animname(animname) {
  animes = getarraykeys(level.scr_animSound[animname]);
  for(i = 0; i < animes.size; i++) {
    anime = animes[i];
    soundalias = level.scr_animSound[animname][anime];
    level.animSound_aliases[animname][anime]["#" + anime]["soundalias"] = soundalias;
    level.animSound_aliases[animname][anime]["#" + anime]["created_by_animSound"] = true;
  }
}

add_hud_line(x, y, msg) {
  hudelm = newHudElem();
  hudelm.alignX = "left";
  hudelm.alignY = "middle";
  hudelm.x = x;
  hudelm.y = y;
  hudelm.alpha = 1;
  hudelm.fontScale = 1;
  hudelm.label = msg;
  level.animsound_hud_extralines[level.animsound_hud_extralines.size] = hudelm;
  return hudelm;
}

debug_animSound() {}
draw_animsounds_in_hud() {
  guy = level.animsound_tagged;
  animsounds = guy.animSounds;
  animname = "generic";
  if(isDefined(guy.animname)) {
    animname = guy.animname;
  }
  level.animsound_hud_animname.label = "Actor: " + animname;
  players = get_players();
  if(players[0] buttonPressed("f12")) {
    if(!level.animsound_locked_pressed) {
      level.animsound_locked = !level.animsound_locked;
      level.animsound_locked_pressed = true;
    }
  } else {
    level.animsound_locked_pressed = false;
  }
  if(players[0] buttonPressed("UPARROW")) {
    if(level.animsound_input != "up") {
      level.animsound_selected--;
    }
    level.animsound_input = "up";
  } else if(players[0] buttonPressed("DOWNARROW")) {
    if(level.animsound_input != "down") {
      level.animsound_selected++;
    }
    level.animsound_input = "down";
  } else {
    level.animsound_input = "none";
  }
  for(i = 0; i < level.animsound_hudlimit; i++) {
    hudelm = level.animsound_hud[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
    hudelm = level.animsound_hud_timer[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
    hudelm = level.animsound_hud_alias[i];
    hudelm.label = "";
    hudelm.color = (1, 1, 1);
  }
  keys = getarraykeys(animsounds);
  highest = -1;
  for(i = 0; i < keys.size; i++) {
    if(keys[i] > highest) {
      highest = keys[i];
    }
  }
  if(highest == -1) {
    return;
  }
  if(level.animsound_selected > highest) {
    level.animsound_selected = highest;
  }
  if(level.animsound_selected < 0) {
    level.animsound_selected = 0;
  }
  for(;;) {
    if(isDefined(animsounds[level.animsound_selected])) {
      break;
    }
    level.animsound_selected--;
    if(level.animsound_selected < 0) {
      level.animsound_selected = highest;
    }
  }
  level.animsound_hud_anime.label = "Anim: " + animsounds[level.animsound_selected].anime;
  level.animsound_hud[level.animsound_selected].color = (1, 1, 0);
  level.animsound_hud_timer[level.animsound_selected].color = (1, 1, 0);
  level.animsound_hud_alias[level.animsound_selected].color = (1, 1, 0);
  time = gettime();
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    animsound = animsounds[key];
    hudelm = level.animsound_hud[key];
    soundalias = get_alias_from_stored(animSound);
    hudelm.label = (key + 1) + ". " + animsound.notetrack;
    hudelm = level.animsound_hud_timer[key];
    hudelm.label = int((time - (animsound.end_time - 60000)) * 0.001);
    if(isDefined(soundalias)) {
      hudelm = level.animsound_hud_alias[key];
      hudelm.label = soundalias;
      if(!is_from_animsound(animSound.animname, animSound.anime, animSound.notetrack)) {
        hudelm.color = (0.7, 0.7, 0.7);
      }
    }
  }
  players = get_players();
  if(players[0] buttonPressed("del")) {
    animsound = animsounds[level.animsound_selected];
    soundalias = get_alias_from_stored(animsound);
    if(!isDefined(soundalias)) {
      return;
    }
    if(!is_from_animsound(animSound.animname, animSound.anime, animSound.notetrack)) {
      return;
    }
    level.animSound_aliases[animSound.animname][animSound.anime][animSound.notetrack] = undefined;
    debug_animSoundSave();
  }
}

get_alias_from_stored(animSound) {
  if(!isDefined(level.animSound_aliases[animSound.animname])) {
    return;
  }
  if(!isDefined(level.animSound_aliases[animSound.animname][animSound.anime])) {
    return;
  }
  if(!isDefined(level.animSound_aliases[animSound.animname][animSound.anime][animSound.notetrack])) {
    return;
  }
  return level.animSound_aliases[animSound.animname][animSound.anime][animSound.notetrack]["soundalias"];
}

is_from_animsound(animname, anime, notetrack) {
  return isDefined(level.animSound_aliases[animname][anime][notetrack]["created_by_animSound"]);
}

display_animSound() {
  players = get_players();
  if(distance(players[0].origin, self.origin) > 1500) {
    return;
  }
  level.animSounds_thisframe[level.animSounds_thisframe.size] = self;
}

debug_animSoundTag(tagnum) {}
debug_animSoundTagSelected() {}
tag_sound(tag, tagnum) {
  if(!isDefined(level.animsound_tagged)) {
    return;
  }
  if(!isDefined(level.animsound_tagged.animsounds[tagnum])) {
    return;
  }
  animSound = level.animsound_tagged.animsounds[tagnum];
  soundalias = get_alias_from_stored(animSound);
  if(!isDefined(soundalias) || is_from_animsound(animSound.animname, animSound.anime, animSound.notetrack)) {
    level.animSound_aliases[animSound.animname][animSound.anime][animSound.notetrack]["soundalias"] = tag;
    level.animSound_aliases[animSound.animname][animSound.anime][animSound.notetrack]["created_by_animSound"] = true;
    debug_animSoundSave();
  }
}

debug_animSoundSave() {}
print_aliases_to_file(file) {
  tab = "";
  fprintln(file, "#include maps\\_anim;");
  fprintln(file, "main()");
  fprintln(file, "{");
  fprintln(file, tab + "// Autogenerated by AnimSounds. Threaded off so that it can be placed before _load( has to create level.scr_notetrack first ).");
  fprintln(file, tab + "thread init_animsounds();");
  fprintln(file, "}");
  fprintln(file, "");
  fprintln(file, "init_animsounds()");
  fprintln(file, "{");
  fprintln(file, tab + "waittillframeend;");
  animnames = getarraykeys(level.animSound_aliases);
  for(i = 0; i < animnames.size; i++) {
    animes = getarraykeys(level.animSound_aliases[animnames[i]]);
    for(p = 0; p < animes.size; p++) {
      anime = animes[p];
      notetracks = getarraykeys(level.animSound_aliases[animnames[i]][anime]);
      for(z = 0; z < notetracks.size; z++) {
        notetrack = notetracks[z];
        if(!is_from_animsound(animnames[i], anime, notetrack)) {
          continue;
        }
        alias = level.animSound_aliases[animnames[i]][anime][notetrack]["soundalias"];
        if(notetrack == "#" + anime) {
          fprintln(file, tab + "addOnStart_animSound( " + tostr(animnames[i]) + ", " + tostr(anime) + ", " + tostr(alias) + " ); ");
        } else {
          fprintln(file, tab + "addNotetrack_animSound( " + tostr(animnames[i]) + ", " + tostr(anime) + ", " + tostr(notetrack) + ", " + tostr(alias) + " ); ");
        }
        println("^1Saved alias ^4" + alias + "^1 to notetrack ^4" + notetrack);
      }
    }
  }
  fprintln(file, "}");
}

tostr(str) {
  newstr = "\"";
  for(i = 0; i < str.size; i++) {
    if(str[i] == "\"") {
      newstr += "\\";
      newstr += "\"";
      continue;
    }
    newstr += str[i];
  }
  newstr += "\"";
  return newstr;
}

drawDebugLineInternal(fromPoint, toPoint, color, durationFrames) {
  for(i = 0; i < durationFrames; i++) {
    line(fromPoint, toPoint, color);
    wait(0.05);
  }
}

drawDebugLine(fromPoint, toPoint, color, durationFrames) {
  thread drawDebugLineInternal(fromPoint, toPoint, color, durationFrames);
}

complete_me() {
  if(getDvar(#"credits_active") == "1") {
    wait 7;
    setdvar("credits_active", "0");
    maps\_endmission::credits_end();
    return;
  }
  wait 7;
  nextmission();
}

debug_bayonet() {}
new_hud(hud_name, msg, x, y, scale) {
  if(!isDefined(level.hud_array)) {
    level.hud_array = [];
  }
  if(!isDefined(level.hud_array[hud_name])) {
    level.hud_array[hud_name] = [];
  }
  hud = maps\_createmenu::set_hudelem(msg, x, y, scale);
  level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
  return hud;
}

debug_show_viewpos() {
  wait_for_first_player();
  hud_title = NewDebugHudElem();
  hud_title.x = 10;
  hud_title.y = 300;
  hud_title.alpha = 0;
  hud_title.alignX = "left";
  hud_title.fontscale = 1.2;
  hud_title SetText(&"DEBUG_POSITION");
  x_pos = hud_title.x + 50;
  hud_x = NewDebugHudElem();
  hud_x.x = x_pos;
  hud_x.y = 300;
  hud_x.alpha = 0;
  hud_x.alignX = "left";
  hud_x.fontscale = 1.2;
  hud_x SetValue(0);
  hud_y = NewDebugHudElem();
  hud_y.x = 10;
  hud_y.y = 300;
  hud_y.alpha = 0;
  hud_y.alignX = "left";
  hud_y.fontscale = 1.2;
  hud_y SetValue(0);
  hud_z = NewDebugHudElem();
  hud_z.x = 10;
  hud_z.y = 300;
  hud_z.alpha = 0;
  hud_z.alignX = "left";
  hud_z.fontscale = 1.2;
  hud_z SetValue(0);
  SetDvar("debug_show_viewpos", "0");
  players = get_players();
  while(1) {
    if(GetDvarInt(#"debug_show_viewpos") > 0) {
      hud_title.alpha = 1;
      hud_x.alpha = 1;
      hud_y.alpha = 1;
      hud_z.alpha = 1;
      x = players[0].origin[0];
      y = players[0].origin[1];
      z = players[0].origin[2];
      spacing1 = ((2 + number_before_decimal(x)) * 8) + 10;
      spacing2 = ((2 + number_before_decimal(y)) * 8) + 10;
      hud_y.x = x_pos + spacing1;
      hud_z.x = x_pos + spacing1 + spacing2;
      hud_x SetValue(round_to(x, 100));
      hud_y SetValue(round_to(y, 100));
      hud_z SetValue(round_to(z, 100));
    } else {
      hud_title.alpha = 0;
      hud_x.alpha = 0;
      hud_y.alpha = 0;
      hud_z.alpha = 0;
    }
    wait(0.5);
  }
}

number_before_decimal(num) {
  abs_num = abs(num);
  count = 0;
  while(1) {
    abs_num *= 0.1;
    count += 1;
    if(abs_num < 1) {
      return count;
    }
  }
}

round_to(val, num) {
  return Int(val * num) / num;
}

set_event_printname_thread(text, focus) {}
get_playerone() {
  return get_players()[0];
}

engagement_distance_debug_toggle() {}
dvar_turned_on(val) {
  if(val <= 0) {
    return false;
  } else {
    return true;
  }
}

engagement_distance_debug_init() {
  level.debug_xPos = -50;
  level.debug_yPos = 250;
  level.debug_yInc = 18;
  level.debug_fontScale = 1.5;
  level.white = (1, 1, 1);
  level.green = (0, 1, 0);
  level.yellow = (1, 1, 0);
  level.red = (1, 0, 0);
  level.realtimeEngageDist = NewHudElem();
  level.realtimeEngageDist.alignX = "left";
  level.realtimeEngageDist.fontScale = level.debug_fontScale;
  level.realtimeEngageDist.x = level.debug_xPos;
  level.realtimeEngageDist.y = level.debug_yPos;
  level.realtimeEngageDist.color = level.white;
  level.realtimeEngageDist SetText("Current Engagement Distance: ");
  xPos = level.debug_xPos + 207;
  level.realtimeEngageDist_value = NewHudElem();
  level.realtimeEngageDist_value.alignX = "left";
  level.realtimeEngageDist_value.fontScale = level.debug_fontScale;
  level.realtimeEngageDist_value.x = xPos;
  level.realtimeEngageDist_value.y = level.debug_yPos;
  level.realtimeEngageDist_value.color = level.white;
  level.realtimeEngageDist_value SetValue(0);
  xPos += 37;
  level.realtimeEngageDist_middle = NewHudElem();
  level.realtimeEngageDist_middle.alignX = "left";
  level.realtimeEngageDist_middle.fontScale = level.debug_fontScale;
  level.realtimeEngageDist_middle.x = xPos;
  level.realtimeEngageDist_middle.y = level.debug_yPos;
  level.realtimeEngageDist_middle.color = level.white;
  level.realtimeEngageDist_middle SetText(" units, SHORT/LONG by ");
  xPos += 105;
  level.realtimeEngageDist_offvalue = NewHudElem();
  level.realtimeEngageDist_offvalue.alignX = "left";
  level.realtimeEngageDist_offvalue.fontScale = level.debug_fontScale;
  level.realtimeEngageDist_offvalue.x = xPos;
  level.realtimeEngageDist_offvalue.y = level.debug_yPos;
  level.realtimeEngageDist_offvalue.color = level.white;
  level.realtimeEngageDist_offvalue SetValue(0);
  hudObjArray = [];
  hudObjArray[0] = level.realtimeEngageDist;
  hudObjArray[1] = level.realtimeEngageDist_value;
  hudObjArray[2] = level.realtimeEngageDist_middle;
  hudObjArray[3] = level.realtimeEngageDist_offvalue;
  return hudObjArray;
}

engage_dist_debug_hud_destroy(hudArray, killNotify) {
  level waittill(killNotify);
  for(i = 0; i < hudArray.size; i++) {
    hudArray[i] Destroy();
  }
}

weapon_engage_dists_init() {
  level.engageDists = [];
  genericPistol = spawnStruct();
  genericPistol.engageDistMin = 125;
  genericPistol.engageDistOptimal = 225;
  genericPistol.engageDistMulligan = 50;
  genericPistol.engageDistMax = 400;
  shotty = spawnStruct();
  shotty.engageDistMin = 50;
  shotty.engageDistOptimal = 200;
  shotty.engageDistMulligan = 75;
  shotty.engageDistMax = 350;
  genericSMG = spawnStruct();
  genericSMG.engageDistMin = 100;
  genericSMG.engageDistOptimal = 275;
  genericSMG.engageDistMulligan = 100;
  genericSMG.engageDistMax = 500;
  genericLMG = spawnStruct();
  genericLMG.engageDistMin = 325;
  genericLMG.engageDistOptimal = 550;
  genericLMG.engageDistMulligan = 150;
  genericLMG.engageDistMax = 850;
  genericRifleSA = spawnStruct();
  genericRifleSA.engageDistMin = 325;
  genericRifleSA.engageDistOptimal = 550;
  genericRifleSA.engageDistMulligan = 150;
  genericRifleSA.engageDistMax = 850;
  genericRifleBolt = spawnStruct();
  genericRifleBolt.engageDistMin = 350;
  genericRifleBolt.engageDistOptimal = 600;
  genericRifleBolt.engageDistMulligan = 150;
  genericRifleBolt.engageDistMax = 900;
  genericHMG = spawnStruct();
  genericHMG.engageDistMin = 390;
  genericHMG.engageDistOptimal = 600;
  genericHMG.engageDistMulligan = 100;
  genericHMG.engageDistMax = 900;
  genericSniper = spawnStruct();
  genericSniper.engageDistMin = 950;
  genericSniper.engageDistOptimal = 1700;
  genericSniper.engageDistMulligan = 300;
  genericSniper.engageDistMax = 3000;
  engage_dists_add("pistol", genericPistol);
  engage_dists_add("smg", genericSMG);
  engage_dists_add("spread", shotty);
  engage_dists_add("mg", genericHMG);
  engage_dists_add("rifle", genericRifleSA);
  engage_dists_add("springfield_scoped", genericSniper);
  engage_dists_add("type99_rifle_scoped", genericSniper);
  engage_dists_add("mosin_rifle_scoped", genericSniper);
  engage_dists_add("kar98k_scoped", genericSniper);
  engage_dists_add("fg42_scoped", genericSniper);
  engage_dists_add("lee_enfield_scoped", genericSniper);
  level thread engage_dists_watcher();
}

engage_dists_add(weapontypeStr, values) {
  level.engageDists[weapontypeStr] = values;
}

get_engage_dists(weapontypeStr) {
  if(isDefined(level.engageDists[weapontypeStr])) {
    return level.engageDists[weapontypeStr];
  } else {
    return undefined;
  }
}

engage_dists_watcher() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_engage_dists_watcher");
  while(1) {
    player = get_playerone();
    playerWeapon = player GetCurrentWeapon();
    if(!isDefined(player.lastweapon)) {
      player.lastweapon = playerWeapon;
    } else {
      if(player.lastweapon == playerWeapon) {
        wait(0.05);
        continue;
      }
    }
    values = get_engage_dists(WeaponClass(playerWeapon));
    if(isDefined(values)) {
      level.weaponEngageDistValues = values;
    } else {
      level.weaponEngageDistValues = undefined;
    }
    player.lastweapon = playerWeapon;
    wait(0.05);
  }
}

debug_realtime_engage_dist() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_realtime_engagement_distance_debug");
  hudObjArray = engagement_distance_debug_init();
  level thread engage_dist_debug_hud_destroy(hudObjArray, "kill_all_engage_dist_debug");
  level.debugRTEngageDistColor = level.green;
  player = get_playerone();
  while(1) {
    lastTracePos = (0, 0, 0);
    direction = player GetPlayerAngles();
    direction_vec = anglesToForward(direction);
    eye = player getEye();
    trace = bulletTrace(eye, eye + vector_scale(direction_vec, 10000), true, player);
    tracePoint = trace["position"];
    traceNormal = trace["normal"];
    traceDist = int(Distance(eye, tracePoint));
    if(tracePoint != lastTracePos) {
      lastTracePos = tracePoint;
      if(!isDefined(level.weaponEngageDistValues)) {
        hudobj_changecolor(hudObjArray, level.white);
        hudObjArray engagedist_hud_changetext("nodata", tracedist);
      } else {
        engageDistMin = level.weaponEngageDistValues.engageDistMin;
        engageDistOptimal = level.weaponEngageDistValues.engageDistOptimal;
        engageDistMulligan = level.weaponEngageDistValues.engageDistMulligan;
        engageDistMax = level.weaponEngageDistValues.engageDistMax;
        if((traceDist >= engageDistMin) && (traceDist <= engageDistMax)) {
          if((traceDist >= (engageDistOptimal - engageDistMulligan)) &&
            (traceDist <= (engageDistOptimal + engageDistMulligan))) {
            hudObjArray engagedist_hud_changetext("optimal", tracedist);
            hudobj_changecolor(hudObjArray, level.green);
          } else {
            hudObjArray engagedist_hud_changetext("ok", tracedist);
            hudobj_changecolor(hudObjArray, level.yellow);
          }
        } else if(traceDist < engageDistMin) {
          hudobj_changecolor(hudObjArray, level.red);
          hudObjArray engagedist_hud_changetext("short", tracedist);
        } else if(traceDist > engageDistMax) {
          hudobj_changecolor(hudObjArray, level.red);
          hudObjArray engagedist_hud_changetext("long", tracedist);
        }
      }
    }
    thread plot_circle_fortime(1, 5, 0.05, level.debugRTEngageDistColor, tracePoint, traceNormal);
    thread plot_circle_fortime(1, 1, 0.05, level.debugRTEngageDistColor, tracePoint, traceNormal);
    wait(0.05);
  }
}

hudobj_changecolor(hudObjArray, newcolor) {
  for(i = 0; i < hudObjArray.size; i++) {
    hudObj = hudObjArray[i];
    if(hudObj.color != newcolor) {
      hudObj.color = newcolor;
      level.debugRTEngageDistColor = newcolor;
    }
  }
}

engagedist_hud_changetext(engageDistType, units) {
  if(!isDefined(level.lastDistType)) {
    level.lastDistType = "none";
  }
  if(engageDistType == "optimal") {
    self[1] SetValue(units);
    self[2] SetText("units: OPTIMAL!");
    self[3].alpha = 0;
  } else if(engageDistType == "ok") {
    self[1] SetValue(units);
    self[2] SetText("units: OK!");
    self[3].alpha = 0;
  } else if(engageDistType == "short") {
    amountUnder = level.weaponEngageDistValues.engageDistMin - units;
    self[1] SetValue(units);
    self[3] SetValue(amountUnder);
    self[3].alpha = 1;
    if(level.lastDistType != engageDistType) {
      self[2] SetText("units: SHORT by ");
    }
  } else if(engageDistType == "long") {
    amountOver = units - level.weaponEngageDistValues.engageDistMax;
    self[1] SetValue(units);
    self[3] SetValue(amountOver);
    self[3].alpha = 1;
    if(level.lastDistType != engageDistType) {
      self[2] SetText("units: LONG by ");
    }
  } else if(engageDistType == "nodata") {
    self[1] SetValue(units);
    self[2] SetText(" units: (NO CURRENT WEAPON VALUES)");
    self[3].alpha = 0;
  }
  level.lastDistType = engageDistType;
}

debug_ai_engage_dist() {
  level endon("kill_all_engage_dist_debug");
  level endon("kill_ai_engagement_distance_debug");
  player = get_playerone();
  while(1) {
    axis = GetAIArray("axis");
    if(isDefined(axis) && axis.size > 0) {
      playerEye = player getEye();
      for(i = 0; i < axis.size; i++) {
        ai = axis[i];
        aiEye = ai getEye();
        if(SightTracePassed(playerEye, aiEye, false, player)) {
          dist = Distance(playerEye, aiEye);
          drawColor = level.white;
          drawString = "-";
          if(!isDefined(level.weaponEngageDistValues)) {
            drawColor = level.white;
          } else {
            engageDistMin = level.weaponEngageDistValues.engageDistMin;
            engageDistOptimal = level.weaponEngageDistValues.engageDistOptimal;
            engageDistMulligan = level.weaponEngageDistValues.engageDistMulligan;
            engageDistMax = level.weaponEngageDistValues.engageDistMax;
            if((dist >= engageDistMin) && (dist <= engageDistMax)) {
              if((dist >= (engageDistOptimal - engageDistMulligan)) &&
                (dist <= (engageDistOptimal + engageDistMulligan))) {
                drawColor = level.green;
                drawString = "RAD";
              } else {
                drawColor = level.yellow;
                drawString = "MEH";
              }
            } else if(dist < engageDistMin) {
              drawColor = level.red;
              drawString = "BAD";
            } else if(dist > engageDistMax) {
              drawColor = level.red;
              drawString = "BAD";
            }
          }
          scale = dist / 525;
          Print3d(ai.origin + (0, 0, 67), drawString, drawColor, 1, scale);
        }
      }
    }
    wait(0.05);
  }
}

plot_circle_fortime(radius1, radius2, time, color, origin, normal) {
  if(!isDefined(color)) {
    color = (0, 1, 0);
  }
  hangtime = .05;
  circleres = 6;
  hemires = circleres / 2;
  circleinc = 360 / circleres;
  circleres++;
  plotpoints = [];
  rad = 0.00;
  timer = gettime() + (time * 1000);
  radius = radius1;
  while(gettime() < timer) {
    radius = radius2;
    angletoplayer = vectortoangles(normal);
    for(i = 0; i < circleres; i++) {
      plotpoints[plotpoints.size] = origin + vector_scale(anglesToForward((angletoplayer + (rad, 90, 0))), radius);
      rad += circleinc;
    }
    maps\_utility::plot_points(plotpoints, color[0], color[1], color[2], hangtime);
    plotpoints = [];
    wait hangtime;
  }
}

dynamic_ai_spawner() {
  if(!isDefined(level.debug_dynamic_ai_spawner)) {
    dynamic_ai_spawner_init();
    level.debug_dynamic_ai_spawner = true;
  }
  get_players()[0] thread spawn_guy_placement(level.enemy_spawner);
  level waittill("kill dynamic spawning");
  if(isDefined(level.dynamic_spawn_hud)) {
    level.dynamic_spawn_hud destroy();
  }
  if(isDefined(level.dynamic_spawn_dummy_model)) {
    level.dynamic_spawn_dummy_model delete();
  }
}

dynamic_ai_spawner_init() {
  level.enemy_spawner = dynamic_ai_spawner_create_enemy_spawner();
  if(!isDefined(level.enemy_spawner)) {
    return;
  }
}

dynamic_ai_spawner_create_enemy_spawner() {
  spawners = getspawnerarray();
  for(i = 0; i < spawners.size; i++) {
    if(isDefined(spawners[i].targetname) && issubstr(spawners[i].targetname, "debug_spawner")) {
      enemy_spawner = spawners[i];
      enemy_spawner.script_forcespawn = 1;
      return enemy_spawner;
    }
  }
  for(i = 0; i < spawners.size; i++) {
    if(issubstr(spawners[i].classname, "_e_")) {
      enemy_spawner = spawners[i];
      enemy_spawner.script_forcespawn = 1;
      return enemy_spawner;
    }
  }
}

spawn_guy_placement(spawner) {
  level endon("kill dynamic spawning");
  if(!isDefined(spawner)) {
    assertEX(isDefined(spawner), "No spawners in the level!");
    return;
  }
  level.dynamic_spawn_hud = NewClientHudElem(get_players()[0]);
  level.dynamic_spawn_hud.alignX = "right";
  level.dynamic_spawn_hud.x = 110;
  level.dynamic_spawn_hud.y = 225;
  level.dynamic_spawn_hud.fontscale = 2;
  level.dynamic_spawn_hud settext("Press X to spawn AI");
  level.dynamic_spawn_dummy_model = spawn("script_model", (0, 0, 0));
  level.dynamic_spawn_dummy_model setModel("defaultactor");
  wait 0.1;
  for(;;) {
    direction = self getPlayerAngles();
    direction_vec = anglesToForward(direction);
    eye = self getEye();
    trace = bulletTrace(eye, eye + vector_scale(direction_vec, 8000), 0, undefined);
    dist = distance(eye, trace["position"]);
    position = eye + vector_scale(direction_vec, (dist - 64));
    spawner.origin = position;
    spawner.angles = self.angles + (0, 180, 0);
    level.dynamic_spawn_dummy_model.origin = position;
    level.dynamic_spawn_dummy_model.angles = self.angles + (0, 180, 0);
    self spawn_anywhere(spawner);
    wait(0.05);
  }
}

spawn_anywhere(spawner) {
  level endon("kill dynamic spawning");
  if(self UseButtonPressed()) {
    spawn = spawner spawn_ai();
    if(spawn_failed(spawn)) {
      assertex(0, "spawn failed from spawn anywhere guy");
      return;
    }
    wait 0.4;
  }
  spawner.count = 50;
}

display_module_text() {}
debug_goalradius() {}
ai_puppeteer() {
  ai_puppeteer_create_hud();
  level.ai_puppet_highlighting = false;
  player = get_players()[0];
  player thread ai_puppet_cursor_tracker();
  player thread ai_puppet_manager();
  player.ignoreMe = true;
  level waittill("kill ai puppeteer");
  player.ignoreMe = false;
  ai_puppet_release(true);
  if(isDefined(level.ai_puppet_target)) {
    level.ai_puppet_target Delete();
  }
  ai_puppeteer_destroy_hud();
}

ai_puppet_manager() {
  level endon("kill ai puppeteer");
  self endon("death");
  while(1) {
    if(self ButtonPressed("BUTTON_RTRIG")) {
      if(isDefined(level.ai_puppet)) {
        if(isDefined(level.ai_puppet_target)) {
          if(IsAi(level.ai_puppet_target)) {
            self thread ai_puppeteer_highlight_ai(level.ai_puppet_target, (1, 0, 0));
            level.ai_puppet ClearEntityTarget();
            level.ai_puppet_target = undefined;
          } else {
            self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglesToForward(self getplayerangles()), (1, 0, 0));
            level.ai_puppet ClearEntityTarget();
            level.ai_puppet_target Delete();
          }
        } else {
          if(isDefined(level.playerCursorAi)) {
            if(level.playerCursorAi != level.ai_puppet) {
              level.ai_puppet SetEntityTarget(level.playerCursorAi);
              level.ai_puppet_target = level.playerCursorAi;
              level.ai_puppet GetPerfectInfo(level.ai_puppet_target);
              self thread ai_puppeteer_highlight_ai(level.playerCursorAi, (1, 0, 0));
            }
          } else {
            level.ai_puppet_target = spawn("script_origin", level.playerCursor["position"]);
            level.ai_puppet_target_normal = level.playerCursor["normal"];
            level.ai_puppet SetEntityTarget(level.ai_puppet_target);
            self thread ai_puppeteer_highlight_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglesToForward(self getplayerangles()), (1, 0, 0));
          }
          level.ai_puppet animscripts\weaponList::RefillClip();
        }
      }
      wait(0.2);
    } else if(self ButtonPressed("BUTTON_A")) {
      if(isDefined(level.ai_puppet)) {
        if(isDefined(level.playerCursorAi) && level.playerCursorAi != level.ai_puppet) {
          level.ai_puppet SetGoalEntity(level.playerCursorAi);
          level.ai_puppet.goalradius = 64;
          self thread ai_puppeteer_highlight_ai(level.playerCursorAi, (0, 1, 0));
        } else if(isDefined(level.playerCursorNode)) {
          level.ai_puppet SetGoalNode(level.playerCursorNode);
          level.ai_puppet.goalradius = 16;
          self thread ai_puppeteer_highlight_node(level.playerCursorNode);
        } else {
          if(isDefined(level.ai_puppet.scriptenemy)) {
            to_target = level.ai_puppet.scriptenemy.origin - level.ai_puppet.origin;
          } else {
            to_target = level.playerCursor["position"] - level.ai_puppet.origin;
          }
          angles = VectorToAngles(to_target);
          level.ai_puppet SetGoalPos(level.playerCursor["position"], angles);
          level.ai_puppet.goalradius = 8;
          self thread ai_puppeteer_highlight_point(level.playerCursor["position"], level.playerCursor["normal"], anglesToForward(self getplayerangles()), (0, 1, 0));
        }
      }
      wait(0.2);
    } else if(self ButtonPressed("BUTTON_X")) {
      if(isDefined(level.playerCursorAi)) {
        if(isDefined(level.ai_puppet) && level.playerCursorAi == level.ai_puppet) {
          ai_puppet_release(true);
        } else {
          if(isDefined(level.ai_puppet)) {
            ai_puppet_release(false);
          }
          ai_puppet_set(level.playerCursorAi);
          self thread ai_puppeteer_highlight_ai(level.ai_puppet, (0, 1, 1));
        }
      }
      wait(0.2);
    }
    if(isDefined(level.ai_puppet)) {
      ai_puppeteer_render_ai(level.ai_puppet, (0, 1, 1));
      if(isDefined(level.ai_puppet.scriptenemy) && !level.ai_puppet_highlighting) {
        if(IsAi(level.ai_puppet.scriptenemy)) {
          ai_puppeteer_render_ai(level.ai_puppet.scriptenemy, (1, 0, 0));
        } else if(isDefined(level.ai_puppet_target)) {
          self thread ai_puppeteer_render_point(level.ai_puppet_target.origin, level.ai_puppet_target_normal, anglesToForward(self getplayerangles()), (1, 0, 0));
        }
      }
    }
    wait(0.05);
  }
}

ai_puppet_set(puppet) {
  level.ai_puppet = level.playerCursorAi;
  level.ai_puppet.old_goalradius = level.ai_puppet.goalradius;
  level.ai_puppet StopAnimScripted();
}

ai_puppet_release(restore) {
  if(isDefined(level.ai_puppet)) {
    if(restore) {
      level.ai_puppet.goalradius = level.ai_puppet.old_goalradius;
      level.ai_puppet ClearEntityTarget();
    }
    level.ai_puppet = undefined;
  }
}

ai_puppet_cursor_tracker() {
  level endon("kill ai puppeteer");
  self endon("death");
  while(1) {
    forward = anglesToForward(self getplayerangles());
    forward_vector = vector_scale(forward, 4000);
    level.playerCursor = bulletTrace(self getEye(), self getEye() + forward_vector, true, self);
    level.playerCursorAi = undefined;
    level.playerCursorNode = undefined;
    cursorColor = (0, 1, 1);
    hitEnt = level.playerCursor["entity"];
    if(isDefined(hitEnt) && IsAi(hitEnt)) {
      cursorColor = (1, 0, 0);
      if(isDefined(level.ai_puppet) && level.ai_puppet != hitEnt) {
        if(!level.ai_puppet_highlighting) {
          ai_puppeteer_render_ai(hitEnt, cursorColor);
        }
      }
      level.playerCursorAi = hitEnt;
    } else if(isDefined(level.ai_puppet)) {
      nodes = GetAnyNodeArray(level.playerCursor["position"], 24);
      if(nodes.size > 0) {
        node = nodes[0];
        if(node.type != "Path" && distanceSquared(node.origin, level.playerCursor["position"]) < 24 * 24) {
          if(!level.ai_puppet_highlighting) {
            ai_puppeteer_render_node(node, (0, 1, 1));
          }
          level.playerCursorNode = node;
        }
      }
    }
    if(!level.ai_puppet_highlighting) {
      ai_puppeteer_render_point(level.playerCursor["position"], level.playerCursor["normal"], forward, cursorColor);
    }
    wait(0.05);
  }
}

ai_puppeteer_create_hud() {
  level.puppeteer_hud_select = NewDebugHudElem();
  level.puppeteer_hud_select.x = 0;
  level.puppeteer_hud_select.y = 180;
  level.puppeteer_hud_select.fontscale = 1.5;
  level.puppeteer_hud_select.alignX = "left";
  level.puppeteer_hud_select.horzAlign = "left";
  level.puppeteer_hud_select.color = (0, 0, 1);
  level.puppeteer_hud_goto = NewDebugHudElem();
  level.puppeteer_hud_goto.x = 0;
  level.puppeteer_hud_goto.y = 200;
  level.puppeteer_hud_goto.fontscale = 1.5;
  level.puppeteer_hud_goto.alignX = "left";
  level.puppeteer_hud_goto.horzAlign = "left";
  level.puppeteer_hud_goto.color = (0, 1, 0);
  level.puppeteer_hud_shoot = NewDebugHudElem();
  level.puppeteer_hud_shoot.x = 0;
  level.puppeteer_hud_shoot.y = 220;
  level.puppeteer_hud_shoot.fontscale = 1.5;
  level.puppeteer_hud_shoot.alignX = "left";
  level.puppeteer_hud_shoot.horzAlign = "left";
  level.puppeteer_hud_shoot.color = (1, 1, 1);
  level.puppeteer_hud_select SetText("X for select");
  level.puppeteer_hud_goto SetText("A for goto");
  level.puppeteer_hud_shoot SetText("R_TRIG for shoot");
}

ai_puppeteer_destroy_hud() {
  if(isDefined(level.puppeteer_hud_select)) {
    level.puppeteer_hud_select Destroy();
  }
  if(isDefined(level.puppeteer_hud_goto)) {
    level.puppeteer_hud_goto Destroy();
  }
  if(isDefined(level.puppeteer_hud_shoot)) {
    level.puppeteer_hud_shoot Destroy();
  }
}

ai_puppeteer_render_point(point, normal, forward, color) {
  surface_vector = VectorCross(forward, normal);
  surface_vector = VectorNormalize(surface_vector);
  line(point, point + vector_scale(surface_vector, 5), color, 1, true);
  line(point, point + vector_scale(surface_vector, -5), color, 1, true);
  surface_vector = VectorCross(normal, surface_vector);
  surface_vector = VectorNormalize(surface_vector);
  line(point, point + vector_scale(surface_vector, 5), color, 1, true);
  line(point, point + vector_scale(surface_vector, -5), color, 1, true);
}

ai_puppeteer_render_node(node, color) {
  print3d(node.origin, node.type, color, 1, 0.35);
  box(node.origin, (-16, -16, 0), (16, 16, 16), node.angles[1], color, 1, 1);
  nodeForward = anglesToForward(node.angles);
  nodeForward = vector_scale(nodeForward, 8);
  line(node.origin, node.origin + nodeForward, color, 1, 1);
}

ai_puppeteer_render_ai(ai, color) {
  circle(ai.origin + (0, 0, 1), 15, color, false, true);
}

ai_puppeteer_highlight_point(point, normal, forward, color) {
  level endon("kill ai puppeteer");
  self endon("death");
  level.ai_puppet_highlighting = true;
  maxTime = 0.7;
  timer = 0;
  waitTime = 0.15;
  while(timer < maxTime) {
    ai_puppeteer_render_point(point, normal, forward, color);
    timer += waitTime;
    wait(waitTime);
  }
  level.ai_puppet_highlighting = false;
}

ai_puppeteer_highlight_node(node) {
  level endon("kill ai puppeteer");
  self endon("death");
  level.ai_puppet_highlighting = true;
  maxTime = 0.7;
  timer = 0;
  waitTime = 0.15;
  while(timer < maxTime) {
    ai_puppeteer_render_node(node, (0, 1, 0));
    timer += waitTime;
    wait(waitTime);
  }
  level.ai_puppet_highlighting = false;
}

ai_puppeteer_highlight_ai(ai, color) {
  level endon("kill ai puppeteer");
  self endon("death");
  level.ai_puppet_highlighting = true;
  maxTime = 0.7;
  timer = 0;
  waitTime = 0.15;
  while(timer < maxTime && isDefined(ai)) {
    ai_puppeteer_render_ai(ai, color);
    timer += waitTime;
    wait(waitTime);
  }
  level.ai_puppet_highlighting = false;
}