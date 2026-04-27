/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_drone.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#using_animtree("generic_human");

DRONE_RUN_SPEED = 170;
TRACE_HEIGHT = 100;
MAX_DRONES_ALLIES = 99999;
MAX_DRONES_AXIS = 99999;
MAX_DRONES_TEAM3 = 99999;
MAX_DRONES_CIVILIAN = 99999;
DEATH_DELETE_FOV = 0.5;

initGlobals() {
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

  if(getDvar("debug_drones") == "")
    setDvar("debug_drones", "0");

  assert(isDefined(level.drone_anims));

  if(!isDefined(level.lookAhead_value))
    level.drone_lookAhead_value = 200;

  if(!isDefined(level.max_drones))
    level.max_drones = [];
  if(!isDefined(level.max_drones["allies"]))
    level.max_drones["allies"] = MAX_DRONES_ALLIES;
  if(!isDefined(level.max_drones["axis"]))
    level.max_drones["axis"] = MAX_DRONES_AXIS;
  if(!isDefined(level.max_drones["team3"]))
    level.max_drones["team3"] = MAX_DRONES_TEAM3;
  if(!isDefined(level.max_drones["neutral"]))
    level.max_drones["neutral"] = MAX_DRONES_CIVILIAN;

  if(!isDefined(level.drones))
    level.drones = [];
  if(!isDefined(level.drones["allies"]))
    level.drones["allies"] = struct_arrayspawn();
  if(!isDefined(level.drones["axis"]))
    level.drones["axis"] = struct_arrayspawn();
  if(!isDefined(level.drones["team3"]))
    level.drones["team3"] = struct_arrayspawn();
  if(!isDefined(level.drones["neutral"]))
    level.drones["neutral"] = struct_arrayspawn();

  level.drone_spawn_func = ::drone_init;
}

drone_give_soul() {
  self useAnimTree(#animtree);

  self startUsingHeroOnlyLighting();

  if(isDefined(self.script_moveplaybackrate))
    self.moveplaybackrate = self.script_moveplaybackrate;
  else
    self.moveplaybackrate = 1;

  if(self.team == "allies") {
    self maps\_names::get_name();

    self setlookattext(self.name, &"");
  }

  if(isDefined(level.droneCallbackThread))
    self thread[[level.droneCallbackThread]]();

  level thread maps\_friendlyfire::friendly_fire_think(self);
}

drone_init() {
  assertEx(isDefined(level.max_drones), "You need to put maps\_drone::init(); in your level script!");
  if(level.drones[self.team].array.size >= level.max_drones[self.team]) {
    self delete();
    return;
  }

  thread drone_array_handling(self);

  self setCanDamage(true);

  drone_give_soul();

  if(isDefined(self.script_drone_override)) {
    return;
  }

  thread drone_death_thread();

  if(isDefined(self.target)) {
    if(!isDefined(self.script_moveoverride))
      self thread drone_move();
    else
      self thread drone_wait_move();
  }
  if((isDefined(self.script_looping)) && (self.script_looping == 0)) {
    return;
  }

  self thread drone_idle();
}

drone_array_handling(drone) {
  structarray_add(level.drones[drone.team], drone);

  team = drone.team;

  drone waittill("death");

  if(isDefined(drone) && isDefined(drone.struct_array_index))
    structarray_remove_index(level.drones[team], drone.struct_array_index);
  else
    structarray_remove_undefined(level.drones[team]);
}

drone_death_thread() {
  while(isDefined(self)) {
    self waittill("damage");

    if(isDefined(self.damageShield) && self.damageShield) {
      self.health = 100000;
      continue;
    }

    if(self.health <= 0) {
      break;
    }
  }

  deathanim = level.drone_anims[self.team]["stand"]["death"];
  if(isDefined(self.deathanim))
    deathanim = self.deathanim;

  self notify("death");

  if(!(isDefined(self.noragdoll) && isDefined(self.skipDeathAnim))) {
    if(isDefined(self.noragdoll)) {
      self drone_play_scripted_anim(deathanim, "deathplant");
    } else
    if(isDefined(self.skipDeathAnim)) {
      self startragdoll();
      self drone_play_scripted_anim(deathanim, "deathplant");
    } else {
      self drone_play_scripted_anim(deathanim, "deathplant");
      self startragdoll();
    }
  }

  self notsolid();

  if(isDefined(self) && isDefined(self.nocorpsedelete)) {
    return;
  }
  wait 10;
  while(isDefined(self)) {
    if(!within_fov(level.player.origin, level.player.angles, self.origin, DEATH_DELETE_FOV))
      self delete();
    wait(5);
  }
}
drone_play_looping_anim(droneAnim, rate) {
  self ClearAnim(%body, 0.2);
  self StopAnimScripted();

  self SetFlaggedAnimKnobAllRestart("drone_anim", droneAnim, %body, 1, 0.2, rate);
}
drone_play_scripted_anim(droneAnim, deathplant) {
  self clearAnim(%body, 0.2);
  self stopAnimScripted();

  mode = "normal";
  if(isDefined(deathplant))
    mode = "deathplant";

  flag = "drone_anim";
  self animscripted(flag, self.origin, self.angles, droneAnim, mode);

  self waittillmatch("drone_anim", "end");
}

drone_drop_real_weapon_on_death() {
  if(!isDefined(self)) {
    return;
  }
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }
  weapon_model = getWeaponModel(self.weapon);
  weapon = self.weapon;
  if(isDefined(weapon_model)) {
    self detach(weapon_model, "tag_weapon_right");
    org = self gettagorigin("tag_weapon_right");
    ang = self gettagangles("tag_weapon_right");
    gun = spawn("weapon_" + weapon, (0, 0, 0));
    gun.angles = ang;
    gun.origin = org;
  }
}

drone_idle(lastNode, moveToDest) {
  if((isDefined(lastNode)) && (isDefined(lastNode["script_noteworthy"])) && (isDefined(level.drone_anims[self.team][lastNode["script_noteworthy"]]))) {
    self thread drone_fight(lastNode["script_noteworthy"], lastNode, moveToDest);
  } else {
    self drone_play_looping_anim(level.drone_anims[self.team]["stand"]["idle"], 1);
  }
}

drone_get_goal_loc_with_arrival(dist, node) {
  animset = node["script_noteworthy"];
  if(!isDefined(level.drone_anims[self.team][animset]["arrival"]))
    return dist;
  animDelta = GetMoveDelta(level.drone_anims[self.team][animset]["arrival"], 0, 1);
  animDelta = length(animDelta);
  assertex(animDelta < dist, "Drone with export " + self.export+" does not have enough room to play an arrival anim. Space nodes out more and ensure he has a straight path into the last node");
  dist = (dist - animDelta);
  return dist;
}

drone_fight(animset, struct, moveToDest) {
  self endon("death");
  self endon("stop_drone_fighting");
  self.animset = animset;
  self.weaponsound = undefined;
  iRand = randomintrange(1, 4);

  if(self.team == "axis") {
    if(iRand == 1)
      self.weaponsound = "drone_ak47_fire_npc";
    else if(iRand == 2)
      self.weaponsound = "drone_g36c_fire_npc";
    if(iRand == 3)
      self.weaponsound = "drone_fnp90_fire_npc";
  } else {
    if(iRand == 1)
      self.weaponsound = "drone_m4carbine_fire_npc";
    else if(iRand == 2)
      self.weaponsound = "drone_m16_fire_npc";
    if(iRand == 3)
      self.weaponsound = "drone_m249saw_fire_npc";
  }

  self.angles = (0, self.angles[1], self.angles[2]);

  if(animset == "coverprone")
    self moveto(self.origin + (0, 0, 8), .05);

  self.noragdoll = true;
  self.deathanim = level.drone_anims[self.team][animset]["death"];
  bPopUpToFire = 1;
  while(isDefined(self)) {
    self drone_play_scripted_anim(level.drone_anims[self.team][animset]["idle"][randomint(level.drone_anims[self.team][animset]["idle"].size)]);

    if((cointoss()) && (!isDefined(self.ignoreall))) {
      if(animset == "coverprone") {
        if(cointoss())
          bPopUpToFire = 0;
        else
          bPopUpToFire = 1;
      } else if(animset == "coverguard")
        bPopUpToFire = 0;

      if(bPopUpToFire == 1) {
        self drone_play_scripted_anim(level.drone_anims[self.team][animset]["hide_2_aim"]);
        wait(getanimlength(level.drone_anims[self.team][animset]["hide_2_aim"]) - .5);
      }

      if(isDefined(level.drone_anims[self.team][animset]["fire"])) {
        if((animset == "coverprone") && (bPopUpToFire == 1))
          self thread drone_play_looping_anim(level.drone_anims[self.team][animset]["fire_exposed"], 1);
        else
          self thread drone_play_looping_anim(level.drone_anims[self.team][animset]["fire"], 1);

        self drone_fire_randomly();
      } else {
        self drone_shoot();
        wait(.15);
        self drone_shoot();
        wait(.15);
        self drone_shoot();
        wait(.15);
        self drone_shoot();
      }

      if(bPopUpToFire == 1)
        self drone_play_scripted_anim(level.drone_anims[self.team][animset]["aim_2_hide"]);

      self drone_play_scripted_anim(level.drone_anims[self.team][animset]["reload"]);
    }
  }
}

drone_fire_randomly() {
  self endon("death");

  if(cointoss()) {
    self drone_shoot();
    wait(.1);
    self drone_shoot();
    wait(.1);
    self drone_shoot();

    if(cointoss()) {
      wait(.1);
      self drone_shoot();
    }

    if(cointoss()) {
      wait(.1);
      self drone_shoot();
      wait(.1);
      self drone_shoot();
      wait(.1);
    }
    if(cointoss())
      wait(randomfloatrange(1, 2));
  } else {
    self drone_shoot();
    wait(randomfloatrange(.25, .75));
    self drone_shoot();
    wait(randomfloatrange(.15, .75));
    self drone_shoot();
    wait(randomfloatrange(.15, .75));
    self drone_shoot();
    wait(randomfloatrange(.15, .75));
  }
}

drone_shoot() {
  self endon("death");
  self notify("firing");
  self endon("firing");
  drone_shoot_fx();
  fireAnim = % exposed_crouch_shoot_auto_v2;

  self setAnimKnobRestart(fireAnim, 1, .2, 1.0);
  self delaycall(.25, ::clearAnim, fireAnim, 0);
}

drone_shoot_fx() {
  shoot_fx = getfx("ak47_muzzleflash");
  if(self.team == "allies") {
    shoot_fx = getfx("m16_muzzleflash");
  }

  self thread drone_play_weapon_sound(self.weaponsound);
  playFXOnTag(shoot_fx, self, "tag_flash");
}

drone_play_weapon_sound(weaponsound) {
  self playSound(weaponsound);
}

drone_wait_move() {
  self endon("death");
  self waittill("move");
  self thread drone_move();
}

drone_init_path() {
  if(!isDefined(self.target))
    return;
  if(isDefined(level.drone_paths[self.target])) {
    return;
  }

  level.drone_paths[self.target] = true;

  target = self.target;
  node = getstruct(target, "targetname");
  if(!isDefined(node)) {
    return;
  }
  vectors = [];

  completed_nodes = [];
  original_node = node;

  for(;;) {
    node = original_node;
    found_new_node = false;

    for(;;) {
      if(!isDefined(node.target)) {
        break;
      }

      nextNodes = getStructArray(node.target, "targetname");
      if(nextNodes.size) {
        break;
      }

      nextNode = undefined;
      foreach(newNode in nextNodes) {
        if(isDefined(completed_nodes[newNode.origin + ""])) {
          continue;
        }
        nextNode = newNode;
        break;
      }
      if(!isDefined(nextNode)) {
        break;
      }

      completed_nodes[nextNode.origin + ""] = true;

      vectors[node.targetname] = nextNode.origin - node.origin;
      node.angles = vectortoangles(vectors[node.targetname]);

      node = nextNode;
      found_new_node = true;
    }

    if(!found_new_node) {
      break;
    }
  }

  target = self.target;
  node = getstruct(target, "targetname");
  prevNode = node;
  completed_nodes = [];

  for(;;) {
    node = original_node;
    found_new_node = false;

    for(;;) {
      if(!isDefined(node.target)) {
        return;
      }
      if(!isDefined(vectors[node.targetname])) {
        return;
      }
      nextNodes = getStructArray(node.target, "targetname");
      if(nextNodes.size) {
        break;
      }

      nextNode = undefined;
      foreach(newNode in nextNodes) {
        if(isDefined(completed_nodes[newNode.origin + ""])) {
          continue;
        }
        nextNode = newNode;
        break;
      }
      if(!isDefined(nextNode)) {
        break;
      }

      if(isDefined(node.radius)) {
        vec1 = vectors[prevNode.targetname];
        vec2 = vectors[node.targetname];
        vec = (vec1 + vec2) * 0.5;
        node.angles = vectorToAngles(vec);
      }

      found_new_node = true;
      prevNode = node;
      node = nextNode;
    }

    if(!found_new_node) {
      break;
    }
  }
}

drone_move() {
  self endon("death");

  wait randomfloat(0.5);

  runAnim = level.drone_anims[self.team]["stand"]["run"];
  if(isDefined(self.runanim))
    runAnim = self.runanim;

  self drone_play_looping_anim(runAnim, self.moveplaybackrate);

  nodes = self getPathArray(self.target, self.origin);
  assert(isDefined(nodes));
  assert(isDefined(nodes[0]));

  prof_begin("drone_math");

  loopTime = 0.5;
  currentNode_LookAhead = 0;
  for(;;) {
    if(!isDefined(nodes[currentNode_LookAhead])) {
      break;
    }

    vec1 = nodes[currentNode_LookAhead]["vec"];
    vec2 = (self.origin - nodes[currentNode_LookAhead]["origin"]);
    distanceFromPoint1 = vectorDot(vectorNormalize(vec1), vec2);

    if(!isDefined(nodes[currentNode_LookAhead]["dist"])) {
      break;
    }

    lookaheadDistanceFromNode = (distanceFromPoint1 + level.drone_lookAhead_value);
    assert(isDefined(lookaheadDistanceFromNode));

    assert(isDefined(currentNode_LookAhead));
    assert(isDefined(nodes[currentNode_LookAhead]));
    assert(isDefined(nodes[currentNode_LookAhead]["dist"]));

    while(lookaheadDistanceFromNode > nodes[currentNode_LookAhead]["dist"]) {
      lookaheadDistanceFromNode = lookaheadDistanceFromNode - nodes[currentNode_LookAhead]["dist"];
      currentNode_LookAhead++;

      if(!isDefined(nodes[currentNode_LookAhead]["dist"])) {
        self rotateTo(vectorToAngles(nodes[nodes.size - 1]["vec"]), loopTime);
        d = distance(self.origin, nodes[nodes.size - 1]["origin"]);
        timeOfMove = (d / (DRONE_RUN_SPEED * self.moveplaybackrate));

        traceOrg1 = nodes[nodes.size - 1]["origin"] + (0, 0, TRACE_HEIGHT);
        traceOrg2 = nodes[nodes.size - 1]["origin"] - (0, 0, TRACE_HEIGHT);
        moveToDest = physicstrace(traceOrg1, traceOrg2);

        if(getDvar("debug_drones") == "1") {
          thread draw_line_for_time(traceOrg1, traceOrg2, 1, 1, 1, loopTime);
          thread draw_line_for_time(self.origin, moveToDest, 0, 0, 1, loopTime);
        }
        self moveTo(moveToDest, timeOfMove);

        wait timeOfMove;
        prof_end("drone_math");
        self notify("goal");
        self thread check_delete();
        self thread drone_idle(nodes[nodes.size - 1], moveToDest);
        return;
      }

      if(!isDefined(nodes[currentNode_LookAhead])) {
        prof_end("drone_math");
        self notify("goal");
        self thread drone_idle();
        return;
      }

      assert(isDefined(nodes[currentNode_LookAhead]));
    }

    assert(isDefined(nodes[currentNode_LookAhead]["vec"][0]));
    assert(isDefined(nodes[currentNode_LookAhead]["vec"][1]));
    assert(isDefined(nodes[currentNode_LookAhead]["vec"][2]));
    desiredPosition = vector_multiply(nodes[currentNode_LookAhead]["vec"], lookaheadDistanceFromNode);
    desiredPosition = desiredPosition + nodes[currentNode_LookAhead]["origin"];
    lookaheadPoint = desiredPosition;

    traceOrg1 = lookaheadPoint + (0, 0, TRACE_HEIGHT);
    traceOrg2 = lookaheadPoint - (0, 0, TRACE_HEIGHT);
    lookaheadPoint = physicstrace(traceOrg1, traceOrg2);

    if(getDvar("debug_drones") == "1") {
      thread draw_line_for_time(traceOrg1, traceOrg2, 1, 1, 1, loopTime);
      thread draw_point(lookaheadPoint, 1, 0, 0, 16, loopTime);
      println(lookaheadDistanceFromNode + "/" + nodes[currentNode_LookAhead]["dist"] + " units forward from node[" + currentNode_LookAhead + "]");
    }

    characterFaceDirection = VectorToAngles(lookaheadPoint - self.origin);
    assert(isDefined(characterFaceDirection));
    assert(isDefined(characterFaceDirection[0]));
    assert(isDefined(characterFaceDirection[1]));
    assert(isDefined(characterFaceDirection[2]));
    self rotateTo((0, characterFaceDirection[1], 0), loopTime);

    moveVec = vectorNormalize(lookaheadPoint - self.origin);
    desiredPosition = vector_multiply(moveVec, characterDistanceToMove);
    desiredPosition = desiredPosition + self.origin;
    if(getDvar("debug_drones") == "1")
      thread draw_line_for_time(self.origin, desiredPosition, 0, 0, 1, loopTime);
    self moveTo(desiredPosition, loopTime);
  }

  self thread drone_idle();

  prof_end("drone_math");
}

getPathArray(firstTargetName, initialPoint) {
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

  usingNodes = true;
  assert(isDefined(firstTargetName));

  prof_begin("drone_math");

  assert(isDefined(initialPoint));

  nodes = [];
  nodes[0]["origin"] = initialPoint;
  nodes[0]["dist"] = 0;

  nextNodeName = undefined;
  nextNodeName = firstTargetName;

  get_target_func["entity"] = maps\_spawner::get_target_ents;
  get_target_func["node"] = maps\_spawner::get_target_nodes;
  get_target_func["struct"] = maps\_spawner::get_target_structs;

  goal_type = undefined;
  test_ent = [[get_target_func["entity"]]](nextNodeName);
  test_nod = [[get_target_func["node"]]](nextNodeName);
  test_str = [[get_target_func["struct"]]](nextNodeName);

  if(test_ent.size)
    goal_type = "entity";
  else
  if(test_nod.size)
    goal_type = "node";
  else
  if(test_str.size)
    goal_type = "struct";

  for(;;) {
    index = nodes.size;

    nextNodes = [[get_target_func[goal_type]]](nextNodeName);
    node = random(nextNodes);

    org = node.origin;

    if(isDefined(node.radius)) {
      assert(node.radius > 0);

      if(!isDefined(self.droneRunOffset))
        self.droneRunOffset = (0 - 1 + (randomfloat(2)));

      if(!isDefined(node.angles))
        node.angles = (0, 0, 0);

      prof_begin("drone_math");
      forwardVec = anglesToForward(node.angles);
      rightVec = anglestoright(node.angles);
      upVec = anglestoup(node.angles);
      relativeOffset = (0, (self.droneRunOffset * node.radius), 0);
      org += vector_multiply(forwardVec, relativeOffset[0]);
      org += vector_multiply(rightVec, relativeOffset[1]);
      org += vector_multiply(upVec, relativeOffset[2]);
      prof_end("drone_math");
    }
    nodes[index]["origin"] = org;
    if(isDefined(node.script_noteworthy))
      nodes[index]["script_noteworthy"] = node.script_noteworthy;

    nodes[index - 1]["dist"] = distance(nodes[index]["origin"], nodes[index - 1]["origin"]);
    nodes[index - 1]["vec"] = vectorNormalize(nodes[index]["origin"] - nodes[index - 1]["origin"]);

    if(!isDefined(node.target)) {
      break;
    }

    nextNodeName = node.target;
  }

  nodes[index]["vec"] = nodes[index - 1]["vec"];

  node = undefined;

  prof_end("drone_math");

  return nodes;
}

draw_point(org, r, g, b, size, time) {
  point1 = org + (size, 0, 0);
  point2 = org - (size, 0, 0);
  thread draw_line_for_time(point1, point2, r, g, b, time);

  point1 = org + (0, size, 0);
  point2 = org - (0, size, 0);
  thread draw_line_for_time(point1, point2, r, g, b, time);

  point1 = org + (0, 0, size);
  point2 = org - (0, 0, size);
  thread draw_line_for_time(point1, point2, r, g, b, time);
}

check_delete() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.script_noteworthy)) {
    return;
  }
  if(self.script_noteworthy != "delete_on_goal") {
    return;
  }
  self delete();
}