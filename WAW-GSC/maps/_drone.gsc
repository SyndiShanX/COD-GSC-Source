/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_drone.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\utility;
#include animscripts\combat_utility;
#using_animtree("generic_human");

init() {
  if(getdvar("debug_drones") == "")
    setdvar("debug_drones", "0");
  if(!isDefined(level.traceHeight))
    level.traceHeight = 400;
  if(!isDefined(level.droneStepHeight))
    level.droneStepHeight = 100;
  if(!isDefined(level.lookAhead_value))
    level.drone_lookAhead_value = 200;
  if(!isDefined(level.drone_run_speed))
    level.drone_run_speed = 170;
  if(!isDefined(level.max_drones))
    level.max_drones = [];
  if(!isDefined(level.max_drones["allies"]))
    level.max_drones["allies"] = 32;
  if(!isDefined(level.max_drones["axis"]))
    level.max_drones["axis"] = 32;
  if(!isDefined(level.max_drones["neutral"]))
    level.max_drones["neutral"] = 32;
  if(level.max_drones["axis"] > 32) {
    level.max_drones["axis"] = 32;
  }
  if(level.max_drones["allies"] > 32) {
    level.max_drones["allies"] = 32;
  }
  if(level.max_drones["neutral"] > 32) {
    level.max_drones["neutral"] = 32;
  }
  if(!isDefined(level.drones))
    level.drones = [];
  if(!isDefined(level.drones["allies"]))
    level.drones["allies"] = struct_arrayspawn();
  if(!isDefined(level.drones["axis"]))
    level.drones["axis"] = struct_arrayspawn();
  if(!isDefined(level.drones["neutral"]))
    level.drones["neutral"] = struct_arrayspawn();
  level.drone_anims["stand"]["idle"] = % exposed_aim_5;
  level.drone_anims["stand"]["run"] = % drone_stand_run;
  level.drone_anims["stand"]["death"] = % drone_stand_death;
  level.drone_anims["stand"]["aim_straight"] = % stand_aim_straight;
  level.drone_anims["stand"]["aim_up"] = % stand_aim_up;
  level.drone_anims["stand"]["aim_down"] = % stand_aim_down;
  level.drone_anims["stand"]["reload"] = % exposed_crouch_reload;
  level.drone_anims["tread_water"]["idle"] = % ch_pby_float1;
  level.drone_anims["stand"]["swim"] = % ch_pby_swim_freestyle_hi;
  level.drone_anim["paddle_boat"]["guy1"] = % ch_raft_paddling_guy1;
  level.drone_anim["paddle_boat"]["guy2"] = % ch_raft_paddling_guy2;
  level.drone_anim["paddle_boat"]["guy3"] = % ch_raft_paddling_guy3;
  level.drone_anim["paddle_boat"]["guy4"] = % ch_raft_paddling_guy4;
  level.drone_muzzleflash = loadfx("weapon/muzzleflashes/standardflashworld");
  if(isDefined(level.droneExtraAnims))
    self thread[[level.droneExtraAnims]]();
  level.drone_spawn_func = ::drone_init;
}

drone_init() {
  assertEx(isDefined(level.max_drones), "You need to put maps\_drone::init(); in your level script!");
  if(level.drones[self.team].array.size >= level.max_drones[self.team]) {
    self delete();
    return;
  }
  structarray_add(level.drones[self.team], self);
  self.health = 150;
  self setCanDamage(true);
  self.targetname = "drone";
  self useAnimTree(#animtree);
  if(self.team == "allies") {
    self.voice = "american";
    self maps\_names::get_name();
    self setlookattext(self.name, & "");
  }
  if(isDefined(level.droneCallbackThread))
    self thread[[level.droneCallbackThread]]();
  level thread maps\_friendlyfire::friendly_fire_think(self);
  if(isDefined(level.droneCustomDeath))
    self thread[[level.droneCustomDeath]]();
  else
    level thread drone_death_thread(self);
  if(isDefined(self.target) && !isDefined(self.script_moveoverride))
    self drone_move();
  self drone_idle();
}

drone_death_thread(drone) {
  while (isDefined(drone)) {
    drone waittill("damage");
    if(drone.health <= 0) {
      break;
    }
  }
  drone notify("death");
  drone stopAnimScripted();
  if(isDefined(drone.skipDeathAnim)) {
    drone startragdoll();
    drone drone_play_anim(level.drone_anims["stand"]["death"]);
  } else {
    drone drone_play_anim(level.drone_anims["stand"]["death"]);
    drone startragdoll();
  }
  wait 10;
  if(isDefined(drone))
    drone delete();
}

drone_play_anim(droneAnim) {
  if(isDefined(self.need_notetrack)) {
    self thread drone_notetrack("drone_anim");
  }
  self animscripted("drone_anim", self.origin, self.angles, droneAnim);
  self waittillmatch("drone_anim", "end");
  self notify("stop_droneNoteTrack");
}

drone_notetrack(msg) {
  self endon("stop_droneNoteTrack");
  while (1) {
    self waittill(msg, notetrack);
    if(notetrack == "start_ragdoll") {
      self StartRagdoll();
      wait(1);
      break;
    }
  }
}

drone_idle() {
  self stopAnimScripted();
  self thread drone_play_anim(level.drone_anims["stand"]["idle"]);
}

drone_idle_row_boat(drones, boat) {
  anims = [];
  anims[0] = level.drone_anim["paddle_boat"]["guy1"];
  anims[1] = level.drone_anim["paddle_boat"]["guy2"];
  anims[2] = level.drone_anim["paddle_boat"]["guy3"];
  anims[3] = level.drone_anim["paddle_boat"]["guy4"];
  for (i = 0; i < drones.size; i++) {
    drones[i] LinkTo(boat);
    drones[i] thread drone_play_paddle_anim(anims[i], boat);
  }
}

drone_play_paddle_anim(_anim, boat) {
  self endon("death");
  boat endon("death");
  self endon("stop paddling");
  while (1) {
    startorg = getstartOrigin(boat GetTagOrigin("origin_animate_jnt"), boat GetTagAngles("origin_animate_jnt"), _anim);
    startang = getstartAngles(boat GetTagOrigin("origin_animate_jnt"), boat GetTagAngles("origin_animate_jnt"), _anim);
    self animscripted("drone_anim", startorg, startang, _anim);
    self waittillmatch("drone_anim", "end");
  }
}

drone_tread_water_idle() {
  self stopAnimScripted();
  self thread drone_play_anim(level.drone_anims["tread_water"]["idle"]);
}

drone_move_to_ent(target_ent) {
  if(isDefined(self)) {
    self.target = target_ent.targetname;
    self.angles = VectorToAngles(target_ent.origin - self.origin);
    self thread drone_move();
  }
}

drone_swim_to_ent(target_ent) {
  level.drone_anims["stand"]["run"] = level.drone_anims["stand"]["swim"];
  self.target = target_ent.targetname;
  self.angles = VectorToAngles(target_ent.origin - self.origin);
  self thread drone_move();
}

drone_move_to_ent_and_fire(target_ent, other_target) {
  self endon("death");
  self notify("stop_firing");
  self thread drone_move_to_ent(target_ent);
  self waittill("goal");
  self drone_fire_at_target(other_target, true);
}

drone_move_to_ent_and_delete(target_ent) {
  self thread delete_at_goal();
  self thread drone_move_to_ent(target_ent);
}

delete_at_goal() {
  self endon("death");
  self waittill("goal");
  self Delete();
}

drone_move() {
  self endon("death");
  wait randomfloat(0.5);
  self thread drone_play_anim(level.drone_anims["stand"]["run"]);
  nodes = self getPathArray(self.target, self.origin);
  assert(isDefined(nodes));
  assert(isDefined(nodes[0]));
  prof_begin("drone_math");
  currentNode_LookAhead = 0;
  loopTime = 0.5;
  for (;;) {
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
    while (lookaheadDistanceFromNode > nodes[currentNode_LookAhead]["dist"]) {
      lookaheadDistanceFromNode = lookaheadDistanceFromNode - nodes[currentNode_LookAhead]["dist"];
      currentNode_LookAhead++;
      if(!isDefined(nodes[currentNode_LookAhead]["dist"])) {
        self rotateTo(vectorToAngles(nodes[nodes.size - 1]["vec"]), loopTime);
        d = distance(self.origin, nodes[nodes.size - 1]["origin"]);
        timeOfMove = (d / level.drone_run_speed);
        moveToDest = physicstrace(nodes[nodes.size - 1]["origin"] + (0, 0, level.traceHeight), nodes[nodes.size - 1]["origin"] - (0, 0, level.traceHeight));
        self moveTo(moveToDest, timeOfMove);
        wait timeOfMove;
        prof_end("drone_math");
        self notify("goal");
        return;
      }
      if(!isDefined(nodes[currentNode_LookAhead])) {
        prof_end("drone_math");
        self notify("goal");
        return;
      }
      assert(isDefined(nodes[currentNode_LookAhead]));
    }
    assert(isDefined(nodes[currentNode_LookAhead]["vec"]));
    assert(isDefined(nodes[currentNode_LookAhead]["vec"][0]));
    assert(isDefined(nodes[currentNode_LookAhead]["vec"][1]));
    assert(isDefined(nodes[currentNode_LookAhead]["vec"][2]));
    desiredPosition = vectorScale(nodes[currentNode_LookAhead]["vec"], lookaheadDistanceFromNode);
    desiredPosition = desiredPosition + nodes[currentNode_LookAhead]["origin"];
    lookaheadPoint = desiredPosition;
    lookaheadPoint = physicstrace(lookaheadPoint + (0, 0, level.traceHeight), lookaheadPoint - (0, 0, level.traceHeight));
    if(getdvar("debug_drones") == "1") {
      thread draw_line_for_time(self.origin + (0, 0, 16), lookaheadPoint, 1, 0, 0, loopTime);
      println(lookaheadDistanceFromNode + "/" + nodes[currentNode_LookAhead]["dist"] + " units forward from node[" + currentNode_LookAhead + "]");
    }
    assert(isDefined(lookaheadPoint));
    characterFaceDirection = VectorToAngles(lookaheadPoint - self.origin);
    assert(isDefined(characterFaceDirection));
    assert(isDefined(characterFaceDirection[0]));
    assert(isDefined(characterFaceDirection[1]));
    assert(isDefined(characterFaceDirection[2]));
    self rotateTo((0, characterFaceDirection[1], 0), loopTime);
    characterDistanceToMove = (level.drone_run_speed * loopTime);
    moveVec = vectorNormalize(lookaheadPoint - self.origin);
    desiredPosition = vectorScale(moveVec, characterDistanceToMove);
    desiredPosition = desiredPosition + self.origin;
    if(getdvar("debug_drones") == "1")
      thread draw_line_for_time(self.origin, desiredPosition, 0, 0, 1, loopTime);
    self moveTo(desiredPosition, loopTime);
    wait loopTime;
  }
  prof_end("drone_math");
  self notify("goal");
}

getPathArray(firstTargetName, initialPoint) {
  usingNodes = true;
  assert(isDefined(firstTargetName));
  prof_begin("drone_math");
  assert(isDefined(initialPoint));
  nodes = [];
  nodes[0]["origin"] = initialPoint;
  nodes[0]["dist"] = 0;
  nextNodeName = undefined;
  nextNodeName = firstTargetName;
  for (;;) {
    index = nodes.size;
    node = getstruct(nextNodeName, "targetname");
    if(!isDefined(node)) {
      if(index == 0)
        assertMsg("Drone was told to walk to a node with a targetname that doesnt match a script_struct targetname");
      break;
    }
    org = node.origin;
    if(isDefined(node.radius)) {
      assert(node.radius > 0);
      if(!isDefined(self.droneRunOffset))
        self.droneRunOffset = (0 - 1 + (randomfloat(2)));
      if(!isDefined(node.angles))
        node.angles = (0, 0, 0);
      prof_begin("drone_math");
      forwardVec = anglestoforward(node.angles);
      rightVec = anglestoright(node.angles);
      upVec = anglestoup(node.angles);
      relativeOffset = (0, (self.droneRunOffset * node.radius), 0);
      org += vector_multiply(forwardVec, relativeOffset[0]);
      org += vector_multiply(rightVec, relativeOffset[1]);
      org += vector_multiply(upVec, relativeOffset[2]);
      prof_end("drone_math");
    }
    nodes[index]["origin"] = org;
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

drone_scripted_spawn(classname, spawn_script_origin) {
  assert(isDefined(level.dronestruct[classname]));
  struct = level.dronestruct[classname];
  drone = spawn("script_model", spawn_script_origin.origin);
  drone.angles = spawn_script_origin.angles;
  drone setmodel(struct.model);
  drone UseAnimTree(#animtree);
  drone makefakeai();
  attachedmodels = struct.attachedmodels;
  attachedtags = struct.attachedtags;
  for (i = 0; i < attachedmodels.size; i++)
    drone attach(attachedmodels[i], attachedtags[i]);
  if(isDefined(spawn_script_origin.script_startingposition))
    drone.script_startingposition = spawn_script_origin.script_startingposition;
  if(isDefined(spawn_script_origin.script_noteworthy))
    drone.script_noteworthy = spawn_script_origin.script_noteworthy;
  if(isDefined(spawn_script_origin.script_deleteai))
    drone.script_deleteai = spawn_script_origin.script_deleteai;
  if(isDefined(spawn_script_origin.script_linkto))
    drone.script_linkto = spawn_script_origin.script_linkto;
  if(isDefined(spawn_script_origin.script_moveoverride))
    drone.script_moveoverride = spawn_script_origin.script_moveoverride;
  if(isDefined(spawn_script_origin.script_string))
    drone.script_string = spawn_script_origin.script_string;
  if(issubstr(classname, "ally"))
    drone.team = "allies";
  else if(issubstr(classname, "enemy") || issubstr(classname, "axis"))
    drone.team = "axis";
  else
    drone.team = "neutral";
  if(isDefined(spawn_script_origin.target))
    drone.target = spawn_script_origin.target;
  assert(isDefined(drone));
  if(isDefined(spawn_script_origin.script_noteworthy) && spawn_script_origin.script_noteworthy == "drone_delete_on_unload")
    drone.drone_delete_on_unload = true;
  else
    drone.drone_delete_on_unload = false;
  if(isDefined(spawn_script_origin.script_friendname)) {
    drone.script_friendname = spawn_script_origin.script_friendname;
  }
  drone drone_init();
  spawn_script_origin notify("drone_spawned", drone);
  return drone;
}

drone_hide_weapon() {
  tagname = "j_helmet";
  size = self getattachsize();
  for (i = 0; i < size; i++) {
    model = self getattachmodelname(i);
    if(issubstr(model, "weapon")) {
      self.hidden_weapon = model;
      self detach(model, "tag_weapon_right");
      break;
    }
  }
}

drone_show_weapon() {
  if(isDefined(self.hidden_weapon)) {
    weapon = getWeaponModel(self.hidden_weapon);
    self attach(self.hidden_weapon, "tag_weapon_right");
  }
}

drone_fire_at_target(target, was_moving) {
  if(isDefined(was_moving)) {
    self drone_idle();
  }
  drone = self;
  drone thread drone_track_ent(target);
  drone endon("death");
  drone endon("stop_firing");
  target endon("death");
  fire_count = RandomIntRange(6, 24);
  temp_count = 0;
  while (true) {
    if(Distance2d(drone.origin, target.origin) < 5000) {
      playfxontag(level.drone_muzzleflash, self, "tag_flash");
      MagicBullet("type99_rifle", drone GetTagOrigin("tag_flash"), target.origin);
      wait(RandomFloatRange(1.0, 2.0));
      temp_count++;
    } else {
      wait(0.1);
    }
    if(temp_count > fire_count) {
      drone notify("stop_to_reload");
      fire_count = RandomIntRange(6, 24);
      temp_count = 0;
      drone stopAnimScripted();
      drone drone_play_anim(level.drone_anims["stand"]["reload"]);
      drone thread drone_track_ent(target);
    }
  }
}

drone_fire_at_vehicle_type(_vehicletype, _range) {
  self endon("death");
  self endon("stop vehicle target");
  if(!isDefined(_range)) {
    _range = 5000;
  }
  my_target = -1;
  while (1) {
    target_list = GetEntArray("script_vehicle", "classname");
    for (i = 0; i < target_list.size; i++) {
      if(target_list[i].vehicletype == _vehicletype) {
        if(distance(self.origin, target_list[i].origin) < _range) {
          my_target = i;
          break;
        }
      }
    }
    if(my_target != -1) {
      self thread drone_fire_at_target(target_list[my_target]);
      target_list[my_target] waittill("death");
      wait(1);
    } else {
      wait(0.5);
    }
    my_target = -1;
  }
}

drone_track_ent(target) {
  drone = self;
  drone endon("death");
  drone endon("stop_firing");
  drone endon("stop_to_reload");
  target endon("death");
  drone thread drone_track_ent_height(target);
  drone stopAnimScripted();
  drone drone_play_anim(level.drone_anims["stand"]["aim_straight"]);
  drone.current_aim = "straight";
  while (1) {
    target_org = (target.origin[0], target.origin[1], 0);
    drone_org = (drone.origin[0], drone.origin[1], 0);
    drone.angles = VectorToAngles(target_org - drone_org);
    wait(0.05);
  }
}

drone_track_ent_height(target) {
  drone = self;
  drone endon("death");
  drone endon("stop_firing");
  drone endon("stop_to_reload");
  target endon("death");
  drone stopAnimScripted();
  drone drone_play_anim(level.drone_anims["stand"]["aim_straight"]);
  drone.current_aim = "straight";
  while (1) {
    if(target.origin[2] - drone.origin[2] > 500) {
      if(drone.current_aim != "up") {
        drone stopAnimScripted();
        drone drone_play_anim(level.drone_anims["stand"]["aim_up"]);
        drone.current_aim = "up";
      }
    } else if(drone.origin[2] - target.origin[2] > 500) {
      if(drone.current_aim != "down") {
        drone stopAnimScripted();
        drone maps\_drone::drone_play_anim(level.drone_anims["stand"]["aim_down"]);
        drone.current_aim = "down";
      }
    } else {
      if(drone.current_aim != "straight") {
        drone drone_play_anim(level.drone_anims["stand"]["aim_straight"]);
        drone.current_aim = "straight";
      }
    }
    wait(0.05);
  }
}

trackShootEntOrPos(target) {
  if(isDefined(self) && isDefined(target)) {
    drone = self;
    drone endon("death");
    drone endon("stop_firing");
    drone endon("stop_to_reload");
    target endon("death");
    drone.shootEnt = target;
    drone.a = drone;
    drone.a.aimweight = 0;
    drone.a.aimweight_start = 0;
    drone.a.aimweight_end = 0;
    drone.a.aimweight_transframes = 0;
    drone.rightAimLimit = 60;
    drone.leftAimLimit = -60;
    drone.upAimLimit = 75;
    drone.downAimLimit = -75;
    drone trackLoop( % exposed_aim_2, % exposed_aim_4, % exposed_aim_6, % exposed_aim_8);
  }
}

trackLoop(aim2, aim4, aim6, aim8) {
  self animscripts\shared::setAnimAimWeight(1, .2);
  players = get_players();
  deltaChangePerFrame = 5;
  aimBlendTime = .05;
  prevYawDelta = 0;
  prevPitchDelta = 0;
  maxYawDeltaChange = 5;
  maxPitchDeltaChange = 5;
  pitchAdd = 0;
  yawAdd = 0;
  doMaxAngleCheck = true;
  yawDelta = 0;
  pitchDelta = 0;
  firstFrame = true;
  for (;;) {
    animscripts\shared::incrAnimAimWeight();
    selfShootAtPos = (self.origin[0], self.origin[1], self.origin[2] + 60);
    shootPos = self.shootPos;
    if(isDefined(self.shootEnt))
      shootPos = self.shootEnt getShootAtPos();
    if(!isDefined(shootPos) && self animscripts\cqb::shouldCQB()) {
      selfForward = anglesToForward(self.angles);
      if(isDefined(self.cqb_target)) {
        shootPos = self.cqb_target getShootAtPos();
        dir = shootPos - selfShootAtPos;
        vdot = vectorDot(dir, selfForward);
        if((vdot < 0.0) || (vdot * vdot < 0.413449 * lengthsquared(dir)))
          shootPos = undefined;
      }
      if(!isDefined(shootPos) && isDefined(self.cqb_point_of_interest)) {
        shootPos = self.cqb_point_of_interest;
        dir = shootPos - selfShootAtPos;
        vdot = vectorDot(dir, selfForward);
        if((vdot < 0.0) || (vdot * vdot < 0.413449 * lengthsquared(dir)))
          shootPos = undefined;
      }
    }
    if(!isDefined(shootPos)) {
      assert(!isDefined(self.shootEnt));
      if(isDefined(self.node) && self.node.type == "Guard" && distanceSquared(self.origin, self.node.origin) < 16) {
        yawDelta = AngleClamp180(self.angles[1] - self.node.angles[1]);
        pitchDelta = 0;
      } else {
        likelyEnemyDir = self getAnglesToLikelyEnemyPath();
        if(isDefined(likelyEnemyDir)) {
          yawDelta = AngleClamp180(self.angles[1] - likelyEnemyDir[1]);
          pitchDelta = AngleClamp180(360 - likelyEnemyDir[0]);
        } else {
          yawDelta = 0;
          pitchDelta = 0;
        }
      }
    } else {
      vectorToShootPos = shootPos - selfShootAtPos;
      anglesToShootPos = vectorToAngles(vectorToShootPos);
      pitchDelta = 360 - anglesToShootPos[0];
      pitchDelta = AngleClamp180(pitchDelta + pitchAdd);
      yawDelta = self.angles[1] - anglesToShootPos[1];
      yawDelta = AngleClamp180(yawDelta + yawAdd);
    }
    if(doMaxAngleCheck && (abs(yawDelta) > 60 || abs(pitchDelta) > 60)) {
      yawDelta = 0;
      pitchDelta = 0;
    } else {
      if(yawDelta > self.rightAimLimit)
        yawDelta = self.rightAimLimit;
      else if(yawDelta < self.leftAimLimit)
        yawDelta = self.leftAimLimit;
      if(pitchDelta > self.upAimLimit)
        pitchDelta = self.upAimLimit;
      else if(pitchDelta < self.downAimLimit)
        pitchDelta = self.downAimLimit;
    }
    if(firstFrame) {
      firstFrame = false;
    } else {
      yawDeltaChange = yawDelta - prevYawDelta;
      if(abs(yawDeltaChange) > maxYawDeltaChange)
        yawDelta = prevYawDelta + maxYawDeltaChange * sign(yawDeltaChange);
      pitchDeltaChange = pitchDelta - prevPitchDelta;
      if(abs(pitchDeltaChange) > maxPitchDeltaChange)
        pitchDelta = prevPitchDelta + maxPitchDeltaChange * sign(pitchDeltaChange);
    }
    prevYawDelta = yawDelta;
    prevPitchDelta = pitchDelta;
    if(yawDelta > 0) {
      assert(yawDelta <= self.rightAimLimit);
      weight = yawDelta / self.rightAimLimit * self.a.aimweight;
      self setAnimLimited(aim4, 0, aimBlendTime);
      self setAnimLimited(aim6, weight, aimBlendTime);
    } else if(yawDelta < 0) {
      assert(yawDelta >= self.leftAimLimit);
      weight = yawDelta / self.leftAimLimit * self.a.aimweight;
      self setAnimLimited(aim6, 0, aimBlendTime);
      self setAnimLimited(aim4, weight, aimBlendTime);
    }
    if(pitchDelta > 0) {
      assert(pitchDelta <= self.upAimLimit);
      weight = pitchDelta / self.upAimLimit * self.a.aimweight;
      self setAnimLimited(aim2, 0, aimBlendTime);
      self setAnimLimited(aim8, weight, aimBlendTime);
    } else if(pitchDelta < 0) {
      assert(pitchDelta >= self.downAimLimit);
      weight = pitchDelta / self.downAimLimit * self.a.aimweight;
      self setAnimLimited(aim8, 0, aimBlendTime);
      self setAnimLimited(aim2, weight, aimBlendTime);
    }
    if(players.size == 1) {
      wait(0.05);
    } else {
      wait(1);
    }
  }
}