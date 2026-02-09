/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_flooded.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_flooded_precache::main();
  maps\createart\mp_flooded_art::main();
  maps\mp\mp_flooded_fx::main();
  maps\mp\_water::waterShallowFx();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_flooded");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  if(!is_gen4()) {
    setDvar("r_texFilterProbeBilinear", 1);
  }

  if(level.ps3) {
    setDvar("sm_sunShadowScale", "0.55");
    setDvar("sm_sunsamplesizenear", ".15");
  } else if(level.xenon) {
    setDvar("sm_sunShadowScale", "0.85");
    setDvar("sm_sunsamplesizenear", ".22");
  } else {
    setDvar("sm_sunShadowScale", "0.9");
    setDvar("sm_sunsamplesizenear", ".27");
  }

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  setDvar("r_reactiveMotionWindAmplitudeScale", 1);
  setDvar("r_reactiveMotionWindAreaScale", 10);
  setDvar("r_reactiveMotionWindDir", (0.3, -1, -.5));
  setDvar("r_reactiveMotionWindFrequencyScale", .25);
  setDvar("r_reactiveMotionWindStrength", 1);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  maps\mp\_water::waterShallowInit(205, 212);

  movers = getEntArray("vehicle_movers", "targetname");
  foreach(moverTrigger in movers) {
    sinkingPlatform_Create(moverTrigger, 12, 12);
  }

  level thread initExtraCollision();
}

initExtraCollision() {
  collision1 = GetEnt("clip128x128x8", "targetname");
  collision1Ent = spawn("script_model", (1392, -584, 386));
  collision1Ent.angles = (336, 0, 90);
  collision1Ent CloneBrushmodelToScriptmodel(collision1);
}

sinkingPlatform_Create(triggerEnt, sinkTime, riseTime) {
  clip = GetEnt(triggerEnt.target, "targetname");
  if(!isDefined(clip)) {
    print("Could not find clip named " + triggerEnt.target + "\n");
    return;
  }

  entName = clip.target;
  ent = GetEnt(entName, "targetname");
  if(!isDefined(ent)) {
    print("Could not find entity named " + entName + "\n");
    return;
  }

  ent.clip = clip;
  ent.trigger = triggerEnt;
  ent.clip.unresolved_collision_func = ::handleUnreslovedCollision;

  clip LinkTo(ent);

  pathBlock = GetEnt(ent.script_noteworthy, "targetname");
  ent.pathBlock = pathBlock;
  ent thread sinkingPlatformEnablePathsOnStart();

  endStruct = getstruct(ent.target, "targetname");
  if(!isDefined(endStruct)) {
    print("Could not find target struct named " + ent.target + "\n");
    return;
  }
  ent.startPos = ent.origin;
  ent.startRot = ent.angles;

  ent.endPos = endStruct.origin;
  ent.endRot = endStruct.angles;

  moveDist = Distance(ent.endPos, ent.startPos);

  if(isDefined(endStruct.script_duration)) {
    sinkTime = endStruct.script_duration;
  }

  if(isDefined(triggerEnt.script_duration)) {
    riseTime = triggerEnt.script_duration;
  }

  ent.sinkRate = sinkTime / moveDist;
  ent.riseRate = riseTime / moveDist;

  ent.entsInTrigger = [];

  ent thread sinkingPlatform_WaitForEnter();

  return ent;
}

sinkingPlatform_WaitForEnter() {
  level endon("game_ended");

  while(true) {
    self.trigger waittill("trigger", other);

    if(self canEntTriggerPlatform(other) && isReallyAlive(other)) {
      self.entsInTrigger[other GetEntityNumber()] = other;

      curSize = self.entsInTrigger.size;
      if(curSize == 1) {
        self sinkingPlatform_Start();
      } else if(!isDefined(self.reachedBottom)) {
        self updateSinkRate(curSize);
      }
    }
  }
}

kMIN_ACCEL = 0.5;
sinkingPlatform_Start() {
  self notify("platform_sink");

  t = Distance(self.endPos, self.origin) * self.sinkRate;

  minAccel = min(0.5 * t, kMIN_ACCEL);

  self MoveTo(self.endPos, t, minAccel, minAccel);
  self RotateTo(self.endRot, t, minAccel, minAccel);

  self thread sinkingPlatformPlaySfxSequence("scn_car_sinking_down_start", "scn_car_sinking_down_loop", "scn_car_sinking_down_end", 1, 0.25, t);

  self thread sinkingPlatform_WaitForExit();
  self thread sinkingPlatform_WaitForReachedBottom();
}

sinkingPlatform_WaitForExit() {
  level endon("game_ended");

  while(self.entsInTrigger.size > 0) {
    wait(0.1);

    startSize = self.entsInTrigger.size;

    foreach(index, player in self.entsInTrigger) {
      if(!isDefined(player) || !(player IsTouching(self.trigger)) || !isReallyAlive(player)) {
        self.entsInTrigger[index] = undefined;
      }
    }

    if(!isDefined(self.reachedBottom)) {
      curSize = self.entsInTrigger.size;
      if(curSize > 0 && curSize != startSize) {
        self updateSinkRate(curSize);
      }
    }
  }

  self sinkingPlatform_Return();
}

sinkingPlatform_WaitForReachedBottom() {
  level endon("game_ended");
  self endon("platform_return");

  self waittill("movedone");

  self.reachedBottom = true;
}

sinkingPlatform_WaitForReachedTop() {
  level endon("game_ended");
  self endon("platform_sink");

  self waittill("movedone");
}

sinkingPlatform_Return() {
  self notify("platform_return");
  self.reachedBottom = undefined;

  t = Distance(self.startPos, self.origin) * self.riseRate;

  minAccel = min(0.5 * t, kMIN_ACCEL);

  self MoveTo(self.startPos, t, minAccel, minAccel);
  self RotateTo(self.startRot, t, minAccel, minAccel);

  self thread sinkingPlatformPlaySfxSequence("scn_car_floating_up_start", "scn_car_floating_up_loop", "scn_car_floating_up_end", .5, 0.25, t);

  self thread sinkingPlatform_WaitForReachedTop();
}

canEntTriggerPlatform(other) {
  return ((isPlayer(other) || (IsAgent(other) && isDefined(other.agent_type) && other.agent_type != "dog")) && !isDefined(self.entsInTrigger[other GetEntityNumber()]));
}

updateSinkRate(numBodies) {
  t = Distance(self.endPos, self.origin) * self.sinkRate;
  t /= numBodies;

  if(t > 0) {
    minAccel = min(0.5 * t, kMIN_ACCEL);

    self.clip MoveTo(self.endPos, t, minAccel, minAccel);
    self.clip RotateTo(self.endRot, t, minAccel, minAccel);
  } else {
    print("Error! t = " + t * numBodies + " bodies: " + numBodies + "\n");
  }
}

sinkingPlatformPlaySfxSequence(startSfx, loopSfx, endSfx, startTime, endTime, totalTime) {
  self notify("stopSinkingSfx");
  self StopSounds();
  self StopLoopSound();

  self endon("stopSinkingSfx");

  self playSound(startSfx);
  wait(startTime);

  actualLoopTime = totalTime - startTime - endTime;

  if(actualLoopTime > 0) {
    self playLoopSound(loopSfx);
    wait(actualLoopTime);
    self StopLoopSound();
  }

  self playSound(endSfx);
}

sinkingPlatformEnablePathsOnStart() {
  wait(0.1);
  self sinkingPlatformEnablePaths();
}

sinkingPlatformEnablePaths() {
  if(isDefined(self.pathBlock)) {
    self.pathBlock ConnectPaths();
    self.pathBlock Hide();
  }
}

sinkingPlatformDisablePaths() {
  if(isDefined(self.pathBlock)) {
    self.pathBlock Show();
    self.pathBlock DisconnectPaths();
  }
}

moverCreate(triggerName) {
  trigger = GetEnt(triggerName, "targetname");
  if(!isDefined(trigger)) {
    print("Could not find trigger named " + triggerName + "\n");
    return;
  }

  clip = GetEnt(trigger.target, "targetname");
  if(!isDefined(clip)) {
    print("Could not find brush named " + trigger.target + "\n");
    return;
  }

  ent = GetEnt(clip.target, "targetname");
  if(!isDefined(ent)) {
    print("Could not find entity named " + clip.target + "\n");
    return;
  }
  ent.trigger = trigger;
  ent.clip = clip;

  clip LinkTo(ent);

  ent.keyframes = [];
  keyframeName = ent.target;
  i = 0;
  while(isDefined(keyframeName)) {
    struct = getstruct(keyframeName, "targetname");
    if(isDefined(struct)) {
      if(!isDefined(struct.script_duration)) {
        print("Keyframe " + keyframeName + " is missing a script_duration value!\n");
        struct.script_duration = 6;
      }

      if(!isDefined(struct.script_accel)) {
        struct.script_accel = 0.5 * struct.script_duration;
      }

      if(!isDefined(struct.script_decel)) {
        struct.script_decel = 0.25 * struct.script_duration;
      }

      struct.clipAngles = struct.angles - ent.angles + clip.angles;

      ent.keyframes[i] = struct;

      i++;
      keyframeName = struct.target;
    } else {
      break;
    }
  }

  ent.trigger SetHintString(&"PLATFORM_HOLD_TO_USE");
  ent.trigger MakeUsable();
  ent thread moverWaitForUse();

  return ent;
}

moverWaitForUse() {
  level endon("game_ended");

  self.trigger waittill("trigger");

  self.trigger MakeUnusable();

  self moverDoMove();
}

moverDoMove() {
  level endon("game_ended");

  for(i = 0; i < self.keyframes.size; i++) {
    kf = self.keyframes[i];

    self MoveTo(kf.origin, kf.script_duration, kf.script_accel, kf.script_decel);
    self RotateTo(kf.angles, kf.script_duration, kf.script_accel, kf.script_decel);

    self waittill("movedone");

    if(isDefined(kf.script_delay)) {
      wait(kf.script_delay);
    }
  }

}

handleUnreslovedCollision(hitEnt) {}