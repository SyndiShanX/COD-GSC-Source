/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\_birds_dlc.gsc
**************************************************/

#include common_scripts\_csplines;
#include common_scripts\utility;
#include maps\interactive_models\_interactive_utility;

birds(info) {
  if(getDvar("r_reflectionProbeGenerate") == "1") {
    return;
  }
  birds_finishBirdTypeSetup(info);

  if(isSP()) {
    level waittill("load_finished");
  } else {
    level waittill("interactive_start");
  }

  SetDevDvarIfUninitialized("interactives_debug", 0);
  AssertEx(isDefined(level._interactive), "birds() setup run before any _interactive setup has been run.");

  if(!isDefined(level._interactive["birds_setup"])) {
    level._interactive["birds_setup"] = true;

    AssertEx(!isDefined(level._interactive["bird_perches"]), "level._interactive[\"birds_perches\"] already set up!");
    level._interactive["bird_perches"] = [];

    flocks = getEntArray("interactive_birds", "targetname");
    foreach(flock in flocks) {
      flock thread birds_setup();
    }
  }
}

birds_setup() {
  self birds_setUpConnectedPerches();

  if(isDefined(self.script_triggername)) {
    selfStruct = self birds_saveToStruct();
    level waittill("start_" + self.script_triggername);
    selfStruct birds_loadFromStruct();
  } else {
    self birds_createEnts();
    self thread birds_fly(self.target);
  }
}

birds_createEnts() {
  AssertEx(isDefined(self.interactive_type), "Interactive_birds entity does not have an interactive_type keypair.");
  AssertEx(isDefined(level._interactive), "Interactive_birds entity in map, but level._interactive is not defined.");
  AssertEx(isDefined(level._interactive[self.interactive_type]), ("Interactive_birds entity in map, but level._interactive[" + self.interactive_type + "] is not defined."));

  info = level._interactive[self.interactive_type];

  if(!isDefined(self.interactive_number)) {
    self.interactive_number = info.rig_numtags;
  }

  AssertEx(self.interactive_number <= info.rig_numtags, "Interactive_birds at " + self.origin + " has key value interactive_number too high.According to its precache_script, the " + info.rig_model + " model only has tags for " + info.rig_numtags);

  if(info.rig_model != "use_radiant_model") {
    self setModel(info.rig_model);
  }

  if(isSP()) {
    self call[[level.func["useanimtree"]]](info.rig_animtree);
  }
  self HideAllParts();

  self.birds = [];
  self.birdexists = [];
  self.numbirds = 0;
  for(i = 1; i <= self.interactive_number; i++) {
    self.birds[i] = spawn("script_model", self GetTagOrigin("tag_bird" + i));
    self.birds[i] setModel(info.bird_model["idle"]);
    self.birds[i].angles = self.angles;
    self.birds[i] LinkTo(self, ("tag_bird" + i));
    if(isSP()) {
      self.birds[i] call[[level.func["useanimtree"]]](info.bird_animtree);
    }
    delay = (i - RandomFloat(1)) / self.interactive_number;
    self.birds[i] thread wait_then_fn(delay, "Stop initial model setup", ::bird_sit, self, "tag_bird" + i, info.bird_model["idle"], info.birdmodel_anims);

    self.birdexists[i] = true;
    self.numbirds++;
    if(isDefined(info.bird_health)) {
      self.birds[i].health = info.bird_health;
    } else {
      self.birds[i].health = 20;
    }
    self.birds[i] setCanDamage(true);
    self.birds[i] thread bird_waitfordamage(self, i);
  }

  if(isDefined(self.script_triggername)) {
    self thread birds_waitForTriggerStop();
  }

  AssertEx(isDefined(self.target), "Interactive_birds object at " + self.origin + " does not have a target.");

  AssertEx(isDefined(level._interactive["bird_perches"][self.target]), "Interactive birds: problem with target perch \"" + self.target + "\"");
}

birds_setUpConnectedPerches(perchEnt, path) {
  if(!isDefined(perchEnt)) {
    Assert(isDefined(self));
    AssertEx(isDefined(self.target), "Birds must target a perch.Bird at " + self.origin + " does not have a target.");
    perchEnt = GetEnt(self.target, "targetname");
    AssertEx(isDefined(perchEnt), "Birds must target a perch.Cannot find perch with targetname " + self.target + " for bird at " + self.origin + ".");
  }

  perch = spawnStruct();
  perch.targetname = perchEnt.targetname;
  perch.target = perchEnt.target;
  perch.origin = perchEnt.origin;
  perch.angles = perchEnt.angles;
  perch.interactive_takeoffAnim = perchEnt.interactive_takeoffAnim;
  perch.interactive_landAnim = perchEnt.interactive_landAnim;
  perch.script_radius = perchEnt.script_radius;
  perch.script_noteworthy = perchEnt.script_noteworthy;
  perch.script_triggername = perchEnt.script_triggername;
  if(isDefined(path)) {
    Assert(path[0] == perchEnt);
    path[0] = perch;
  }
  if(isDefined(perchEnt.incoming)) {
    AssertEx(0, "It shouldn't be possible to get here any more.Boon 2013-07-01");
    foreach(birdpath in perchEnt.incoming) {
      birdpath.endPerch = perch;
    }
  }
  perchEnt Delete();

  AssertEx(!isDefined(level._interactive["bird_perches"][perch.targetname]), "Bird perches must have unique targetnames.More than one has targetname \"" + perch.targetname + "\"");
  level._interactive["bird_perches"][perch.targetname] = perch;

  if(!isDefined(perch.interactive_takeoffAnim)) perch.interactive_takeoffAnim = "flying";
  if(!isDefined(perch.interactive_landAnim)) perch.interactive_landAnim = "flying";

  perch.triggers = [];
  targets = getEntArray(perch.targetname, "target");
  foreach(target in targets) {
    if(target.classname == "trigger_multiple") {
      perch.triggers[perch.triggers.size] = target;
    }
  }
  if(isDefined(perch.target)) {
    targets = getEntArray(perch.target, "targetname");
    foreach(target in targets) {
      if(target.classname == "trigger_multiple") {
        perch.triggers[perch.triggers.size] = target;
      }
    }
  }
  if(isDefined(perch.script_triggername)) {
    targets = getEntArray(perch.script_triggername, "target");
    foreach(target in targets) {
      if(target.classname == "trigger_multiple") {
        perch.triggers[perch.triggers.size] = target;
      }
    }
  }

  if(!isDefined(path)) {
    AssertEx(isDefined(perch.target), "Interactive Bird perch at " + perch.origin + " does not have a target.");
    pathStarts = GetVehicleNodeArray(perch.target, "targetname");
    AssertEx(pathStarts.size > 0, "Interactive Bird perch at " + perch.origin + " does not connect to any outgoing paths.");
    foreach(pathStart in pathStarts) {
      pathNodes = [];
      pathNodes[0] = perch;
      pathNodes[1] = pathStart;
      for(node_num = 1;
        (!isDefined(pathNodes[node_num].script_noteworthy)) ||
        (pathNodes[node_num].script_noteworthy != "bird_perch"); node_num++) {
        if(!isDefined(pathNodes[node_num].target)) {
          break;
        }
        targetname = pathNodes[node_num].target;
        next_node = GetVehicleNode(targetname, "targetname");
        if(!isDefined(next_node)) {
          next_node = GetNode(targetname, "targetname");
          if(!isDefined(next_node)) {
            next_node = GetEnt(targetname, "targetname");
            if(isDefined(next_node)) {
              AssertEx(next_node.script_noteworthy == "bird_perch", "Bird paths must be made of nodes and bird perches.Path node at " + next_node.origin + " ia neither.");
              next_node = birds_setUpConnectedPerches(next_node);
            } else {
              AssertEx(isDefined(level._interactive["bird_perches"][targetname], "Birds error: Couldn't find a path node or perch with targetname " + targetname + "."));
              next_node = level._interactive["bird_perches"][targetname];
            }
          }
        }
        AssertEx(isDefined(next_node), "birds_findPathnodes: Couldn't find targetted node with targetname " + targetname + ".");
        pathNodes[node_num + 1] = next_node;
      }
      perch birds_perchSetupPath(pathNodes);
    }
  } else {
    perch birds_perchSetupPath(path);
  }
  return perch;
}

birds_perchSetupPath(pathNodes) {
  if(!isDefined(self.outgoing)) {
    self.outgoing = [];
  }
  birdpath = cspline_makePath(pathnodes);

  endPerch = pathNodes[pathNodes.size - 1];
  if(isDefined(endPerch.classname)) {
    AssertEx(0, "It shouldn't be possible to get here any more.Boon 2013-07-01");

    if(!isDefined(endPerch.incoming)) endPerch.incoming = [];
    endPerch.incoming[endPerch.incoming.size] = birdpath;
  }
  if(isDefined(endPerch.script_noteworthy) && endPerch.script_noteworthy == "bird_perch") {
    birdpath.endPerch = endPerch;
    birdpath.landAnim = endPerch.interactive_landAnim;
  }

  birdpath.startOrigin = self.origin;
  birdpath.startAngles = self.angles;
  birdpath.takeoffAnim = self.interactive_takeoffAnim;
  birdpath.endOrigin = endPerch.origin;
  birdpath.endAngles = endPerch.angles;

  self.outgoing[self.outgoing.size] = birdpath;
}

birds_fly(start_perch) {
  self endon("death");
  self.perch = level._interactive["bird_perches"][start_perch];
  info = level._interactive[self.interactive_type];
  AssertEx(isDefined(info.rigmodel_anims[self.perch.interactive_takeoffAnim]), "bird_perch node at " + self.perch.origin + " has .interactive_takeoffAnim key pair of " + self.perch.interactive_takeoffAnim + ", which is not defined for " + info.interactive_type);
  AssertEx(isDefined(info.rigmodel_anims[self.perch.interactive_landAnim]), "bird_perch node at " + self.perch.origin + " has .interactive_landAnim key pair of " + self.perch.interactive_landAnim + ", which is not defined for " + info.interactive_type);

  birdpath = self.perch.outgoing[RandomInt(self.perch.outgoing.size)];
  posVel = cspline_getPointAtDistance(birdpath, 0);
  self.origin = posVel["pos"];
  self.angles = birdpath.startAngles;

  if(isSP()) {
    self call[[level.func["setanimknob"]]](info.rigmodel_anims[birdpath.takeoffAnim], 1, 0, 0);
    self call[[level.func["setanimtime"]]](info.rigmodel_anims[birdpath.takeoffAnim], 0);
  } else {
    self call[[level.func["scriptModelPlayAnim"]]](info.rigmodel_anims[self.perch.interactive_landAnim + "mp"]);
  }

  speed = 0;
  self.landed = 1;

  scareRadius = info.scareRadius;
  if(isDefined(self.perch.script_radius)) {
    scareRadius = self.perch.script_radius;
  }
  if(scareRadius > 0) {
    self.perch thread birds_perchDangerTrigger(scareRadius, "triggered", "leaving perch");
  }

  for(;;) {
    takeoffStartFrac = 0;
    takeoffAnim = info.rigmodel_anims[birdpath.takeoffAnim];
    takeoffAnim_mp = info.rigmodel_anims[birdpath.takeoffAnim + "mp"];
    flyAnim = info.rigmodel_anims["flying"];
    flyAnim_mp = info.rigmodel_anims["flyingmp"];
    if(isDefined(birdpath.landAnim)) {
      landAnim = info.rigmodel_anims[birdpath.landAnim];
      landAnim_mp = info.rigmodel_anims[birdpath.landAnim + "mp"];
    } else {
      landAnim = undefined;
      landAnim_mp = undefined;
    }
    if(isDefined(info.rigmodel_pauseStart[birdpath.takeoffAnim])) {
      pauseStart = info.rigmodel_pauseStart[birdpath.takeoffAnim];
    }
    else pauseStart = 0;
    takeoffStartTime = 0;
    if(!self.landed) {
      if(isSP()) {
        if(isDefined(landAnim) && self.currentAnim == landAnim) {
          takeoffStartFrac = 1 - (self call[[level.func["getanimtime"]]](self.currentAnim));
          takeoffStartTime = takeoffStartFrac * GetAnimLength(takeoffAnim);
          pauseStart -= takeoffStartTime;
          pauseStart = max(0, pauseStart);
        } else {
          takeoffAnim = info.rigmodel_anims["flying"];
          takeoffAnim_mp = info.rigmodel_anims["flyingmp"];
          takeoffStartFrac = self call[[level.func["getanimtime"]]](self.currentAnim);
          takeoffStartTime = takeoffStartFrac * GetAnimLength(takeoffAnim);
          pauseStart = 0;
        }
      } else {
        takeoffAnim = info.rigmodel_anims["flying"];
        takeoffAnim_mp = info.rigmodel_anims["flyingmp"];
        takeoffStartFrac = 0;
        takeoffStartTime = 0;
        pauseStart = 0;
      }
    }
    if(isDefined(landAnim) && isDefined(info.rigmodel_pauseEnd[birdpath.landAnim])) {
      pauseEnd = info.rigmodel_pauseEnd[birdpath.landAnim];
    }
    else pauseEnd = 0;

    accnFrame = info.accn / (20 * 20);
    pathLength = birdpath.Segments[birdpath.Segments.size - 1].endAt;
    topSpeedPossible = sqrt((accnFrame * pathLength) + (speed * speed / 2));
    topSpeedFrame = info.topSpeed / 20;
    if(topSpeedPossible < topSpeedFrame) {
      topSpeedFrame = topSpeedPossible;
    }

    framesAccelerating = Int((topSpeedFrame - speed) / accnFrame);
    distanceAccelerating = (accnFrame * (framesAccelerating / 2) * (framesAccelerating + 1)) + (speed * framesAccelerating);
    if(isDefined(birdpath.endPerch)) {
      framesDecelerating = Int(topSpeedFrame / accnFrame);
      distanceDecelerating = accnFrame * (framesDecelerating / 2) * (framesDecelerating + 1);
      AssertEx(pathLength + topSpeedFrame > distanceAccelerating + distanceDecelerating, "Interactive_birds path math failure.Path from " + birdpath.startorigin + " to " + birdpath.endPerch.targetname + " is " + pathLength + " long, but distance accelerating is longer: " + (distanceAccelerating + distanceDecelerating) + ".");
    } else {
      framesDecelerating = 0;
      distanceDecelerating = 0;
      AssertEx(pathLength + topSpeedFrame > distanceAccelerating + distanceDecelerating, "Interactive_birds path math failure.Path from " + birdpath.startorigin + " to nowhere is " + pathLength + " long, but distance accelerating is longer: " + (distanceAccelerating + distanceDecelerating) + ".");
    }

    framesTopSpeed = (pathLength - (distanceAccelerating + distanceDecelerating)) / topSpeedFrame;
    pathTime = (framesTopSpeed + (framesAccelerating + framesDecelerating)) / 20;
    loopAnimTime = GetAnimLength(flyAnim);
    if(isDefined(landAnim)) {
      otherAnimTime = GetAnimLength(takeoffAnim) + GetAnimLength(landAnim) - (pauseStart + takeoffStartTime + pauseEnd);
    }
    else {
      otherAnimTime = GetAnimLength(takeoffAnim) - (pauseStart + takeoffStartTime + pauseEnd);
    }
    numLoops = Int(((pathTime - otherAnimTime) / loopAnimTime) + 0.5);
    animSpeed = ((numLoops * loopAnimTime) + otherAnimTime) / pathTime;

    angleChange = birdpath.endAngles - birdpath.startAngles;
    angleChange = (AngleClamp180(angleChange[0]), AngleClamp180(angleChange[1]), AngleClamp180(angleChange[2]));

    if(self.landed) {
      self thread idle_cooing(info);
      self.perch waittill("triggered");
      self notify("stop_path");
      self.landed = 0;
      self thread flock_fly_anim(takeoffAnim, 0, flyAnim, landAnim, animSpeed, numLoops, takeoffAnim_mp, flyAnim_mp, landAnim_mp);
      self thread flock_playSound(info, "takeoff");
      skipTakeoff = (pauseStart == 0);
      for(i = 1; i <= self.interactive_number; i++) {
        if(self.birdexists[i]) {
          self.birds[i] thread bird_flyFromPerch(self, ("tag_bird" + i), info.bird_model["fly"], info.bird_model["idle"], info.birdmodel_anims, ("land_" + i), ("takeoff_" + i), skipTakeoff);
        }
      }
    } else {
      self notify("stop_path");
      self thread flock_fly_anim(takeoffAnim, takeoffStartFrac, flyAnim, landAnim, animSpeed, numLoops, takeoffAnim_mp, flyAnim_mp, landAnim_mp);
      for(i = 1; i <= self.interactive_number; i++) {
        if(self.birdexists[i]) {
          if(isSP()) {
            waitTime = undefined;
          }
          else {
            waitTime = RandomFloat(0.5);
          }
          self.birds[i] thread bird_fly(self, ("tag_bird" + i), info.bird_model["fly"], info.bird_model["idle"],
            info.birdmodel_anims, ("land_" + i), waitTime);
        }
      }
    }
    if(isDefined(self.perch)) {
      self.perch notify("leaving perch");
      self.perch = undefined;
    }

    thread cspline_test(birdpath, pathTime);
    self thread debugprint("PathLength: " + pathLength + "\nnumLoops: " + numLoops + "\n" + "Waiting " + pauseStart + " for birds to take off.");

    wait(pauseStart);

    /#self thread debugprint( "Accelerating" );
    Distance = 0;
    while(speed < (topSpeedFrame - accnFrame)) {
      speed += accnFrame;
      Distance += speed;
      posVel = flock_setFlyingPosAndAngles(birdPath, distance, pathLength, speed, angleChange);
      wait 0.05;
    }
    /#self thread debugprint( "Cruising" );

    speed = topSpeedFrame;
    while(Distance < (pathLength - distanceDecelerating)) {
      Distance += speed;
      posVel = flock_setFlyingPosAndAngles(birdPath, distance, pathLength, speed, angleChange);
      wait 0.05;
    }
    if(!isDefined(birdpath.endPerch)) {
      self birds_delete();
      assert(0);
    }

    /#self thread debugprint( "Decelerating" );

    distanceToTravel = pathLength - Distance;
    speedAdjust = distanceToTravel / distanceDecelerating;
    speed = accnFrame * (Int(speed / accnFrame) + 1);

    self.perch = birdpath.endPerch;
    AssertEx(isDefined(info.rigmodel_anims[self.perch.interactive_takeoffAnim]), "bird_perch node at " + self.perch.origin + " has .intaractive_takeoffAnim key pair of " + self.perch.interactive_takeoffAnim + ", which is not defined for " + info.interactive_type);
    AssertEx(isDefined(info.rigmodel_anims[self.perch.interactive_landAnim]), "bird_perch node at " + self.perch.origin + " has .interactive_landAnim key pair of " + self.perch.interactive_landAnim + ", which is not defined for " + info.interactive_type);
    self.perch thread birds_perchDangerTrigger(scareRadius, "triggered", "leaving perch");
    while((speed > topSpeedFrame * 0.75) || ((speed > 0) && (birds_isPerchSafe(self.perch)))) {
      speed -= accnFrame;
      Distance += speed * speedAdjust;
      posVel = flock_setFlyingPosAndAngles(birdPath, distance, pathLength, speed, angleChange);
      wait 0.05;
    }

    if(speed <= 0) {
      /#self thread debugprint( "Waiting for birds to land" );

      AssertEx(abs(Distance - pathLength) < 0.1, "Please let Boon know that his bird path function failed to hit the end spot perfectly.");
      self.origin = self.perch.origin;
      self.angles = self.perch.angles;
      birdpath = self.perch.outgoing[RandomInt(self.perch.outgoing.size)];
      for(i = 0;
        (i < 20 * pauseEnd) && birds_isPerchSafe(self.perch); i++) {
        wait 0.05;
      }
      if(birds_isPerchSafe(self.perch)) {
        self.landed = 1;
        /#self thread debugprint( "Landed safely" );
      }
    } else {
      /#self thread debugprint( "Moving to new path" );

      mainPath = self.perch.outgoing[RandomInt(self.perch.outgoing.size)];
      birdpath = birds_path_move_first_point(mainPath, posVel["pos"], posVel["vel"] * (speed / topSpeedFrame));
      birdpath.startAngles = self.angles;
      self.perch notify("leaving perch");
      self.perch = undefined;
    }
  }
}

idle_cooing(info) {
  if(isDefined(info.sounds) && isDefined(info.sounds["idle"])) {
    self.perch endon("triggered");
    while(1) {
      wait RandomFloatRange(8, 16);
      self thread flock_playSound(info, "idle");
    }
  }
}

debugprint(str) {
  self notify("stop_debugprint");
  self endon("stop_debugprint");
  self endon("death");
  while(1) {
    if(GetDvarInt("interactives_debug")) {
      Print3d(self.origin, str, (0, 0, 1), 1, 2, 1);
      wait(0.05);
    } else {
      wait 1;
    }
  }

}

birds_set_flying_angles(birdFlock, flockVel, birds) {
  tagWeight = 0.2;
  assert(isSP());
  for(i = 1; i <= birds.size; i++) {
    if(self.birdexists[i]) {
      tagAngles = birdFlock GetTagAngles("tag_bird" + i);
      tagForward = anglesToForward(tagAngles) / tagWeight;
      newForward = tagForward + flockVel;
      newAngles = VectorToAngles(newForward);
      anglesToTag = newAngles - tagAngles;
      anglesToTag = (AngleClamp180(anglesToTag[0]) / 3, AngleClamp180(anglesToTag[1]), 0);
      birds[i] LinkTo(birdFlock, ("tag_bird" + i), (0, 0, 0), anglesToTag);

      if(GetDvarInt("interactives_debug")) {
        tagOrigin = birdFlock GetTagOrigin("tag_bird" + i);

        thread draw_line_for_time(tagOrigin, tagOrigin + tagForward, 1, 0, 0, 0.1);
        thread draw_line_for_time(tagOrigin, tagOrigin + flockVel, 0, 1, 0, 0.1);
      }

    }
  }
}

flock_setFlyingPosAndAngles(birdPath, distance, pathLength, speed, angleChange) {
  posVel = cspline_getPointAtDistance(birdpath, distance);
  self.origin = posVel["pos"];
  if(isSP()) {
    self.angles = birdpath.startAngles + ((angleChange) * (distance / pathLength));
    birds_set_flying_angles(self, (posVel["vel"] * speed), self.birds);
  } else {
    lookAhead = 15;
    lookAheadDistance = distance + (speed * lookAhead);
    if(lookAheadDistance < pathLength) {
      targetPosVel = cspline_getPointAtDistance(birdpath, lookAheadDistance);
      pathAngles = VectorToAngles(targetPosVel["vel"]);
      angleChange = pathAngles - self.angles;
      angleChange = anglesSoftClamp(angleChange, 2, 0.3, 8);
    } else {
      angleChange = birdPath.endAngles - self.angles;
      angleChange = (AngleClamp180(angleChange[0]), AngleClamp180(angleChange[1]), AngleClamp180(angleChange[2]));
      if(speed > 0) {
        timeRemaining = (pathLength - distance) / speed;
        if(timeRemaining > 1) {
          angleChange /= timeRemaining;
        }
      }
    }
    self.angles += angleChange;

  }

  return posVel;
}

flock_playSound(info, soundIndex) {
  if(isDefined(info.sounds) && isDefined(info.sounds[soundIndex])) {
    AssertEx(SoundExists(info.sounds[soundIndex]), "Interactive " + info.interactive_type + ": missing soundalias " + info.sounds[soundIndex]);
    self playSound(info.sounds[soundIndex]);
  }
}

flock_fly_anim(takeoffAnim, takeoffFrac, loopAnim, landAnim, animSpeed, numLoops, takeoffAnim_mp, loopAnim_mp, landAnim_mp) {
  self endon("death");
  self endon("stop_path");
  if(isSP()) {
    blendTime = 0;
    if(GetAnimLength(takeoffAnim) == 0) {
      PrintLn("^1ERROR: Animation (printed below) not found.You may need to Repackage the map.\n");
      PrintLn(takeoffAnim);
    } else {
      fracPerFrame = animSpeed / (GetAnimLength(takeoffAnim) * 20);
      takeoffFrac -= 2 * fracPerFrame;
      if(takeoffFrac > fracPerFrame) {
        blendTime = 0.3;
      }

      self call[[level.func["setflaggedanimknob"]]]("bird_rig_takeoff_anim", takeoffAnim, 1, blendTime, animSpeed);
      self.currentAnim = takeoffAnim;
      if(takeoffFrac > fracPerFrame) {
        waitframe();
        self call[[level.func["setanimtime"]]](takeoffAnim, takeoffFrac);
        self waittillmatch("bird_rig_takeoff_anim", "end");

      } else {
        self waittillmatch("bird_rig_takeoff_anim", "end");
      }
    }

    self call[[level.func["setflaggedanimknobrestart"]]]("bird_rig_loop_anim", loopAnim, 1, 0, animSpeed);
    self.currentAnim = loopAnim;
    for(i = 0; i < numLoops; i++) {
      self waittillmatch("bird_rig_loop_anim", "end");
    }

    if(isDefined(landAnim)) {
      self call[[level.func["setflaggedanimknobrestart"]]]("bird_rig_land_anim", landAnim, 1, 0.05, animSpeed);
      self.currentAnim = landAnim;
      self waittillmatch("bird_rig_land_anim", "end");
    }
  } else {
    if(GetAnimLength(takeoffAnim) == 0) {
      PrintLn("^1ERROR: Animation " + takeoffAnim_mp + " not found.You may need to Repackage the map.\n");
    } else {
      if(takeoffFrac < 0.2) {
        self call[[level.func["scriptModelPlayAnim"]]](takeoffAnim_mp);
        self.currentAnim = takeoffAnim;
        wait(GetAnimLength(takeoffAnim));
      }
    }
    self call[[level.func["scriptModelPlayAnim"]]](loopAnim_mp);
    self.currentAnim = loopAnim;
    for(i = 0; i < numLoops; i++) {
      wait(GetAnimLength(loopAnim));
    }
    if(isDefined(landAnim)) {
      self call[[level.func["scriptModelPlayAnim"]]](landAnim_mp);
      self.currentAnim = landAnim;
      wait(GetAnimLength(landAnim));
      for(i = 1; i <= self.birds.size; i++) {
        self notify("bird_rig_land_anim", ("land_" + i));
      }
    }
  }
}

bird_flyFromPerch(rigModel, rigTag, birdFlyModel, birdSitModel, animArray, notifyLand, notifyTakeoff, skipTakeoff) {
  self endon("death");
  rigModel endon("stop_path");
  if(isSP()) {
    if(isDefined(notifyTakeoff) && !skipTakeoff) {
      rigModel waittillmatch("bird_rig_takeoff_anim", notifyTakeoff);
    }
  } else {
    wait(RandomFloat(0.3));
  }
  self notify("Stop initial model setup");
  self setModel(birdFlyModel);
  self notify("stop_loop");
  if(skipTakeoff) {
    flyAnim = self single_anim(animArray, "flying", undefined, false);
    if(isSP()) {
      waitframe();
      self call[[level.func["setanimtime"]]](flyAnim, RandomFloat(1));
    }
  } else if(isDefined(animArray["takeoff"])) {
    takeoffAnim = self single_anim(animArray, "takeoff", "takeoff_anim", true);
    if(isSP()) {
      self waittillmatch("takeoff_anim", "end");
    } else {
      wait(GetAnimLength(takeoffAnim));
    }
  }
  bird_fly(rigModel, rigTag, birdFlyModel, birdSitModel, animArray, notifyLand);
}

bird_fly(rigModel, rigTag, birdFlyModel, birdSitModel, animArray, notifyLand, waitTime) {
  self endon("death");
  rigModel endon("stop_path");

  if(isDefined(waitTime)) {
    wait waitTime;
  }
  self setModel(birdFlyModel);
  self notify("stop_loop");
  self thread loop_anim(animArray, "flying", "stop_loop");

  rigModel waittillmatch("bird_rig_land_anim", notifyLand);
  if(!isSP()) {
    wait(RandomFloat(1) * RandomFloat(1));
  }
  if(isDefined(animArray["land"])) {
    self notify("stop_loop");
    self endon("stop_loop");
    self single_anim(animArray, "land", undefined, true);
  }
  self thread bird_sit(rigModel, rigTag, birdSitModel, animArray);
}

bird_sit(rigModel, rigTag, birdSitModel, animArray) {
  self endon("death");
  self setModel(birdSitModel);
  self notify("stop_loop");
  self loop_anim(animArray, "idle", "stop_loop");
}

bird_waitfordamage(flock, number) {
  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, type);

    if(isDefined(flock.perch)) {
      flock.perch notify("triggered");
      flock.perch.lastAIEventTrigger = GetTime();
    }
    if(isDefined(self.origin)) {
      if(type == "MOD_GRENADE_SPLASH") {
        point = self.origin + (0, 0, 5);
      }
      playFX(level._interactive[flock.interactive_type].death_effect, point);
      if(self.health <= 0) {
        flock.birdexists[number] = false;
        flock.numbirds--;
        if(flock.numbirds == 0) {
          flock Delete();
        }
        self Delete();
      }
    }
  }
}

birds_finishBirdTypeSetup(info, takeoffDelay) {
  AssertEx(isDefined(info.rigmodel_anims["flying"]), "Rig \"Flying\" animation for " + info.interactive_type + " not defined.Birds cannot work without a fly anim.");
  AssertEx(GetAnimLength(info.rigmodel_anims["flying"]) > 0, "Flock fly anim for " + info.interactive_type + " not found.Birds cannot work without a fly anim.");
  if(!isDefined(takeoffDelay)) takeoffDelay = 0;

  info.saveToStructFn = ::birds_saveToStruct;
  info.loadFromStructFn = ::birds_loadFromStruct;

  info.rigmodel_pauseStart = [];
  info.rigmodel_pauseEnd = [];
  indices = GetArrayKeys(info.rigmodel_anims);
  foreach(index in indices) {
    if(!IsEndStr(index, "mp")) {
      if(string_starts_with(index, "takeoff_")) {
        if(GetAnimLength(info.rigmodel_anims[index]) == 0) {
          PrintLn("^1ERROR: Animation " + index + " for interactive " + info.interactive_type + " not found.You may need to Repackage the map.\n");
          info.rigmodel_anims[index] = info.rigmodel_anims["fly"];
          info.rigmodel_pauseStart[index] = 0;
        } else {
          info.rigmodel_pauseStart[index] = birds_get_last_takeoff(info, index, info.rig_numtags) + takeoffDelay;
        }
      } else if(string_starts_with(index, "land_")) {
        if(GetAnimLength(info.rigmodel_anims[index]) == 0) {
          PrintLn("^1ERROR: Animation " + index + " for interactive " + info.interactive_type + " not found.You may need to Repackage the map.\n");
          info.rigmodel_anims[index] = info.rigmodel_anims["fly"];
          info.rigmodel_pauseEnd[index] = 0;
        } else {
          info.rigmodel_pauseEnd[index] = birds_get_first_land(info, index, info.rig_numtags);
        }
      }
    }
  }
}

birds_get_last_takeoff(info, animalias, numtags) {
  Assert(isDefined(info.interactive_type));
  animation = info.rigmodel_anims[animalias];
  Assert(GetAnimLength(animation) > 0);
  lastTime = 0;
  for(i = 1; i <= numtags; i++) {
    times = GetNotetrackTimes(animation, "takeoff_" + i);

    if(times.size <= 0) {
      PrintLn("^1ERROR: Found no notetrack called \"" + "takeoff_" + i + "\" in " + info.interactive_type + " rigmodel animation " + animalias + "\n");
    } else if(times.size > 1) {
      PrintLn("^1ERROR: Found more than one notetrack called \"" + "takeoff_" + i + "\" in " + info.interactive_type + " rigmodel animation " + animalias + "\n");
    } else if(times[0] > lastTime) {
      lastTime = times[0];
    }
  }
  return GetAnimLength(info.rigmodel_anims[animalias]) * lastTime;
}

birds_get_first_land(info, animalias, numtags) {
  Assert(isDefined(info.interactive_type));
  animation = info.rigmodel_anims[animalias];
  Assert(GetAnimLength(animation) > 0);
  firstTime = 1;
  for(i = 1; i <= numtags; i++) {
    times = GetNotetrackTimes(animation, "land_" + i);
    if(times.size <= 0) {
      PrintLn("^1ERROR: Found no notetrack called \"" + "land_" + i + "\" in " + info.interactive_type + " rigmodel animation " + animalias + "\n");
    } else if(times.size > 1) {
      PrintLn("^1ERROR: Found more than one notetrack called \"" + "land_" + i + "\" in " + info.interactive_type + " rigmodel animation " + animalias + "\n");
    } else if(times[0] < firstTime) {
      firstTime = times[0];
    }
  }
  return GetAnimLength(info.rigmodel_anims[animalias]) * (1 - firstTime);
}

birds_perchDangerTrigger(radius, notifyStr, ender) {
  self.trigger = spawn("trigger_radius", self.origin - (0, 0, radius), 23, radius, 2 * radius);
  self thread delete_on_notify(self.trigger, "death", ender);
  self thread birds_perchTouchTrigger(self.trigger, notifyStr, ender);
  self thread birds_perchEventTrigger(radius, notifyStr, ender);
  foreach(trigger in self.triggers) {
  self thread birds_perchTouchTrigger(trigger, notifyStr, ender);
  }
}

birds_perchTouchTrigger(trigger, notifyStr, ender) {
  self endon("death");
  self endon(ender);

  while(1) {
    trigger.anythingTouchingTrigger = 0;
    trigger waittill("trigger");
    self notify(notifyStr);
    trigger.anythingTouchingTrigger = 1;
    /#if( GetDvarInt( "interactives_debug" ) ) {
    Print3d(self.origin, "Triggered by touch", (0, 0, 1), 1, 2, 100);
  }

  wait 1;
}
}

birds_perchEventTrigger(radius, notifyStr, ender) {
  self.lastAIEventTrigger = GetTime() - 500;
  if(isSP()) {
    self endon("death");
    self endon(ender);

    self.sentient = spawn("script_origin", self.origin);
    self.sentient call[[level.makeEntitySentient_func]]("neutral");
    self thread wait_then_fn(ender, "death", ::birds_deletePerchSentient);
    self.sentient call[[level.addAIEventListener_func]]("projectile_impact");
    self.sentient call[[level.addAIEventListener_func]]("bulletwhizby");

    self.sentient call[[level.addAIEventListener_func]]("explode");

    while(1) {
      self.sentient waittill("ai_event", eventType, originator, position);
      if((eventType != "explode" && eventType != "gunshot") || DistanceSquared(self.origin, position) < 2 * radius) {
        self notify(notifyStr);
        self.lastAIEventTrigger = GetTime();
        /#if( GetDvarInt( "interactives_debug" ) ) {
        Print3d(self.origin, "Triggered by event", (0, 0, 1), 1, 2, 100);
      }

    }
  }
}
}

birds_deletePerchSentient() {
  self.sentient Delete();
}

birds_isPerchSafe(perch) {
  AssertEx(isDefined(perch.trigger), "birds_isPerchSafe() called on perch with no trigger.");
  safeFromDmg = 1;
  safeFromTouch = !perch.trigger.anythingTouchingTrigger;
  if(safeFromTouch) {
    foreach(trigger in perch.triggers) {
      if(trigger.anythingTouchingTrigger) {
        safeFromTouch = false;
        continue;
      }
    }

    if(perch.lastAIEventTrigger > GetTime()) {
      perch.lastAIEventTrigger = GetTime() - 500;
    }

    if(GetTime() - perch.lastAIEventTrigger < 500) {
      safeFromDmg = 0;
    }
  }
  return (safeFromTouch && safeFromDmg);
}

birds_path_move_first_point(path, newStartPos, newStartVel) {
  newPath = cspline_moveFirstPoint(path, newStartPos, newStartVel);
  newPath.startOrigin = newStartPos;

  if(isDefined(path.startAngles)) newPath.startAngles = path.startAngles;
  if(isDefined(path.endOrigin)) newPath.endOrigin = path.endOrigin;
  if(isDefined(path.endAngles)) newPath.endAngles = path.endAngles;
  if(isDefined(path.endPerch)) newPath.endPerch = path.endPerch;
  if(isDefined(path.takeoffAnim)) newPath.takeoffAnim = path.takeoffAnim;
  if(isDefined(path.landAnim)) newPath.landAnim = path.landAnim;

  return newPath;
}

birds_SpawnAndFlyAway(birdType, startPos, flyVec, count) {
  Assert(isDefined(level._interactive) && isDefined(level._interactive[birdType]));

  if(!isDefined(level._interactive["scriptSpawnedCount"])) {
    level._interactive["scriptSpawnedCount"] = 0;
  }
  level._interactive["scriptSpawnedCount"]++;

  perch = spawn("script_model", startPos);
  perch.angles = VectorToAngles(flyVec);
  perch.targetname = "scriptSpawned_" + level._interactive["scriptSpawnedCount"];
  perch.script_noteworthy = "bird_perch";
  path = [];
  path[0] = perch;
  path[1] = spawnStruct();
  path[1].origin = startPos + flyVec;
  path[1].angles = perch.angles;
  perch = birds_setUpConnectedPerches(perch, path);

  flockStruct = spawnStruct();
  flockStruct.interactive_type = birdType;
  flockStruct.target = perch.targetname;
  flockStruct.origin = startPos;
  flockStruct.interactive_number = count;
  flockStruct birds_loadFromStruct();

  perch notify("triggered");

  waitframe();
  level._interactive["bird_perches"][perch.targetname] = undefined;
}

birds_waitForTriggerStop() {
  self endon("death");
  level waittill("stop_" + self.script_triggername);
  self thread birds_saveToStructAndWaitForTriggerStart();
}
birds_saveToStructAndWaitForTriggerStart() {
  selfStruct = self birds_saveToStruct();
  level waittill("start_" + self.script_triggername);
  selfStruct birds_loadFromStruct();
}

birds_saveToStruct() {
  AssertEx(isDefined(self.interactive_type), "Interactive_birds entity does not have an interactive_type keypair.");
  AssertEx(isDefined(level._interactive), "Interactive_birds entity in map, but level._interactive is not defined.");
  AssertEx(isDefined(level._interactive[self.interactive_type]), ("Interactive_birds entity in map, but level._interactive[" + self.interactive_type + "] is not defined."));
  AssertEx(isDefined(self.target), "Interactive_birds object at " + self.origin + " does not have a target.");

  struct = spawnStruct();
  struct.interactive_type = self.interactive_type;
  struct.target = self.target;
  struct.origin = self.origin;
  struct.targetname = self.targetname;
  if(isDefined(self.interactive_number)) {
    struct.interactive_number = self.interactive_number;
  }
  struct.script_triggername = self.script_triggername;
  self birds_delete();
  return struct;
}

birds_loadFromStruct() {
  ent = spawn("script_model", self.origin);
  ent.interactive_type = self.interactive_type;
  ent.target = self.target;
  ent.origin = self.origin;
  if(isDefined(self.interactive_number)) {
    ent.interactive_number = self.interactive_number;
  }
  ent.script_triggername = self.script_triggername;
  ent.targetname = "interactive_birds";
  if(!isDefined(level._interactive["bird_perches"][self.target])) {
    ent birds_setUpConnectedPerches();
  }
  ent birds_createEnts();
  ent thread birds_fly(ent.target);
}

birds_delete() {
  if(isDefined(self.birds)) {
    for(i = 1; i <= self.birds.size; i++) {
      if(self.birdexists[i]) {
        self.birds[i] Delete();
      }
    }
  }
  if(isDefined(self.perch)) {
    self.perch notify("leaving perch");
  }
  self Delete();
}

angleSoftClamp(a, softLimit, scaler, hardLimit) {
  assert(softLimit >= 0);

  a = AngleClamp180(a);
  absa = abs(a);
  if(absa <= softLimit) {
    return a;
  } else {
    signa = a / absa;
    absa = ((absa - softLimit) * scaler) + softLimit;
    absa = clamp(absa, 0, hardLimit);
    return absa * signa;
  }
}

anglesSoftClamp(a, softLimit, scaler, hardLimit) {
  return (angleSoftClamp(a[0], softLimit, scaler, hardLimit),
    angleSoftClamp(a[1], softLimit, scaler, hardLimit),
    angleSoftClamp(a[2], softLimit, scaler, hardLimit));
}