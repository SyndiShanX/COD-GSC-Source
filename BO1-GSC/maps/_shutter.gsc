/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_shutter.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {
  if(!isDefined(level.windStrength)) {
    level.windStrength = 0.2;
  }
  level.animRate["awning"] = 1.0;
  level.animRate["palm"] = 1.0;
  level.animWeightMin = (level.windStrength - 0.5);
  level.animWeightMax = (level.windStrength + 0.2);
  if(level.animWeightMin < 0.1) {
    level.animWeightMin = 0.1;
  }
  if(level.animWeightMax > 1.0) {
    level.animWeightMax = 1.0;
  }
  level.inc = 0;
  awningAnims();
  palmTree_anims();
  array_levelthread(getEntArray("wire", "targetname"), ::wireWander);
  array_levelthread(getEntArray("awning", "targetname"), ::awningWander);
  array_levelthread(getEntArray("palm", "targetname"), ::palmTrees);
  leftShutters = getEntArray("shutter_left", "targetname");
  addShutters = getEntArray("shutter_right_open", "targetname");
  for(i = 0; i < addShutters.size; i++) {
    leftShutters[leftShutters.size] = addShutters[i];
  }
  addShutters = getEntArray("shutter_left_closed", "targetname");
  for(i = 0; i < addShutters.size; i++) {
    leftShutters[leftShutters.size] = addShutters[i];
  }
  for(i = 0; i < leftShutters.size; i++) {
    shutter = leftShutters[i];
    shutter rotateto((shutter.angles[0], shutter.angles[1] + 180, shutter.angles[2]), 0.1);
  }
  wait(0.2);
  for(i = 0; i < leftShutters.size; i++) {
    leftShutters[i].startYaw = leftShutters[i].angles[1];
  }
  rightShutters = getEntArray("shutter_right", "targetname");
  addShutters = getEntArray("shutter_left_open", "targetname");
  for(i = 0; i < addShutters.size; i++) {
    rightShutters[rightShutters.size] = addShutters[i];
  }
  addShutters = getEntArray("shutter_right_closed", "targetname");
  for(i = 0; i < addShutters.size; i++) {
    rightShutters[rightShutters.size] = addShutters[i];
  }
  for(i = 0; i < rightShutters.size; i++) {
    rightShutters[i].startYaw = rightShutters[i].angles[1];
  }
  addShutters = undefined;
  windDirection = "left";
  for(;;) {
    array_levelthread(leftShutters, ::shutterWanderLeft, windDirection);
    array_levelthread(rightShutters, ::shutterWanderRight, windDirection);
    level waittill("wind blows", windDirection);
  }
}

windController() {
  for(;;) {
    windDirection = "left";
    if(randomInt(100) > 50) {
      windDirection = "right";
    }
    level notify("wind blows", windDirection);
    wait(2 + randomfloat(10));
  }
}

shutterWanderLeft(shutter, windDirection) {
  level.inc++;
  level endon("wind blows");
  newYaw = shutter.startYaw;
  if(windDirection == "left") {
    newYaw += 179.9;
  }
  newTime = 0.2;
  shutter rotateto((shutter.angles[0], newYaw, shutter.angles[2]), newTime);
  wait(newTime + 0.1);
  shutter thread shutterSound();
  for(;;) {
    shutter notify("shutterSound");
    rot = randomInt(80);
    if(randomInt(100) > 50) {
      rot *= -1;
    }
    newYaw = shutter.angles[1] + rot;
    altYaw = shutter.angles[1] + (rot * -1);
    if((newYaw < shutter.startYaw) || (newYaw > shutter.startYaw + 179)) {
      newYaw = altYaw;
    }
    dif = abs(shutter.angles[1] - newYaw);
    newTime = dif * 0.02 + randomfloat(2);
    if(newTime < 0.3) {
      newTime = 0.3;
    }
    shutter rotateto((shutter.angles[0], newYaw, shutter.angles[2]), newTime, newTime * 0.5, newTime * 0.5);
    wait(newTime);
  }
}

shutterWanderRight(shutter, windDirection) {
  level.inc++;
  level endon("wind blows");
  newYaw = shutter.startYaw;
  if(windDirection == "left") {
    newYaw += 179.9;
  }
  newTime = 0.2;
  shutter rotateto((shutter.angles[0], newYaw, shutter.angles[2]), newTime);
  wait(newTime + 0.1);
  shutter thread shutterSound();
  for(;;) {
    shutter notify("shutterSound");
    rot = randomInt(80);
    if(randomInt(100) > 50) {
      rot *= -1;
    }
    newYaw = shutter.angles[1] + rot;
    altYaw = shutter.angles[1] + (rot * -1);
    if((newYaw < shutter.startYaw) || (newYaw > shutter.startYaw + 179)) {
      newYaw = altYaw;
    }
    dif = abs(shutter.angles[1] - newYaw);
    newTime = dif * 0.02 + randomfloat(2);
    if(newTime < 0.3) {
      newTime = 0.3;
    }
    shutter rotateto((shutter.angles[0], newYaw, shutter.angles[2]), newTime, newTime * 0.5, newTime * 0.5);
    wait(newTime);
  }
}

shutterSound() {
  for(;;) {
    self waittill("shutterSound");
    self playSound("shutter_move", "sounddone");
    self waittill("sounddone");
    wait(randomfloat(2));
  }
}

wireWander(wire) {
  origins = getEntArray(wire.target, "targetname");
  org1 = origins[0].origin;
  org2 = origins[1].origin;
  angles = vectortoangles(org1 - org2);
  ent = spawn("script_model", (0, 0, 0));
  ent.origin = vector_scale(org1, 0.5) + vector_scale(org2, 0.5);
  ent.angles = angles;
  wire linkto(ent);
  rottimer = 2;
  rotrange = 0.9;
  dist = 4 + randomfloat(2);
  ent rotateroll(dist * 0.5, 0.2);
  wait(0.2);
  for(;;) {
    rottime = rottimer + randomfloat(rotRange) - (rotRange * 0.5);
    ent rotateroll(dist, rottime, rottime * 0.5, rottime * 0.5);
    wait(rottime);
    ent rotateroll(dist * -1, rottime, rottime * 0.5, rottime * 0.5);
    wait(rottime);
  }
}

awningAnims() {}
awningWander(ent) {}
#using_animtree("animated_props");
palmTree_anims() {
  return;
}

palmTrees(ent) {
  ent useAnimTree(#animtree);
  switch (ent.model) {
    case "tree_desertpalm01":
      ent.animname = "tree_desertpalm01";
      break;
    case "tree_desertpalm02":
      ent.animname = "tree_desertpalm02";
      break;
    case "tree_desertpalm03":
      ent.animname = "tree_desertpalm03";
      break;
  }
  if(!isDefined(ent.animname)) {
    return;
  }
  wait randomfloat(2);
  for(;;) {
    fWeight = (level.animWeightMin + randomfloat((level.animWeightMax - level.animWeightMin)));
    fLength = 4;
    ent setanim(level.scr_anim[ent.animname]["wind"][0], fWeight, fLength, level.animRate["palm"]);
    ent setanim(level.scr_anim[ent.animname]["wind"][1], 1 - fWeight, fLength, level.animRate["palm"]);
    wait(1 + randomfloat(3));
  }
}