/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_shared.gsc
*****************************************/

#include maps\_utility;
#include animscripts\zombie_utility;
#include animscripts\combat_utility;
#include common_scripts\utility;
#using_animtree("generic_human");
deleteAtLimit() {
  wait 30.0;
  self delete();
}

LookAtEntity(lookTargetEntity, lookDuration, lookSpeed, eyesOnly, interruptOthers) {
  return;
}

LookAtPosition(lookTargetPos, lookDuration, lookSpeed, eyesOnly, interruptOthers) {
  assertEX(isAI(self), "Can only call this function on an AI character");
  assertEX(self.a.targetLookInitilized == true, "LookAtPosition called on AI that lookThread was not called on");
  assertEX((lookSpeed == "casual") || (lookSpeed == "alert"), "lookSpeed must be casual or alert");
  if(!isDefined(interruptOthers) || (interruptOthers == "interrupt others") || (GetTime() > self.a.lookEndTime)) {
    self.a.lookTargetPos = lookTargetPos;
    self.a.lookEndTime = GetTime() + (lookDuration * 1000);
    if(lookSpeed == "casual") {
      self.a.lookTargetSpeed = 800;
    } else {
      self.a.lookTargetSpeed = 1600;
    }
    if(isDefined(eyesOnly) && (eyesOnly == "eyes only")) {
      self notify("eyes look now");
    } else {
      self notify("look now");
    }
  }
}

LookAtAnimations(leftanim, rightanim) {
  self.a.LookAnimationLeft = leftanim;
  self.a.LookAnimationRight = rightanim;
}

HandleDogSoundNoteTracks(note) {
  if(note == "sound_dogstep_run_default") {
    self PlaySound("fly_dog_step_run_default");
    return true;
  }
  prefix = getsubstr(note, 0, 5);
  if(prefix != "sound") {
    return false;
  }
  alias = "aml" + getsubstr(note, 5);
  if(IsAlive(self)) {
    self thread play_sound_on_tag_endon_death(alias, "tag_eye");
  } else {
    self thread play_sound_in_space(alias, self gettagorigin("tag_eye"));
  }
  return true;
}

growling() {
  return isDefined(self.script_growl);
}

registerNoteTracks() {
  anim.notetracks["anim_pose = \"stand\""] = ::noteTrackPoseStand;
  anim.notetracks["anim_pose = \"crouch\""] = ::noteTrackPoseCrouch;
  anim.notetracks["anim_movement = \"stop\""] = ::noteTrackMovementStop;
  anim.notetracks["anim_movement = \"walk\""] = ::noteTrackMovementWalk;
  anim.notetracks["anim_movement = \"run\""] = ::noteTrackMovementRun;
  anim.notetracks["anim_alertness = causal"] = ::noteTrackAlertnessCasual;
  anim.notetracks["anim_alertness = alert"] = ::noteTrackAlertnessAlert;
  anim.notetracks["gravity on"] = ::noteTrackGravity;
  anim.notetracks["gravity off"] = ::noteTrackGravity;
  anim.notetracks["gravity code"] = ::noteTrackGravity;
  anim.notetracks["bodyfall large"] = ::noteTrackBodyFall;
  anim.notetracks["bodyfall small"] = ::noteTrackBodyFall;
  anim.notetracks["footstep"] = ::noteTrackFootStep;
  anim.notetracks["step"] = ::noteTrackFootStep;
  anim.notetracks["footstep_right_large"] = ::noteTrackFootStep;
  anim.notetracks["footstep_right_small"] = ::noteTrackFootStep;
  anim.notetracks["footstep_left_large"] = ::noteTrackFootStep;
  anim.notetracks["footstep_left_small"] = ::noteTrackFootStep;
  anim.notetracks["footscrape"] = ::noteTrackFootScrape;
  anim.notetracks["land"] = ::noteTrackLand;
  anim.notetracks["start_ragdoll"] = ::noteTrackStartRagdoll;
}

noteTrackStopAnim(note, flagName) {}
noteTrackStartRagdoll(note, flagName) {
  if(isDefined(self.noragdoll)) {
    return;
  }
  self Unlink();
  self startRagdoll();
}

noteTrackMovementStop(note, flagName) {
  if(IsSentient(self)) {
    self.a.movement = "stop";
  }
}

noteTrackMovementWalk(note, flagName) {
  if(IsSentient(self)) {
    self.a.movement = "walk";
  }
}

noteTrackMovementRun(note, flagName) {
  if(IsSentient(self)) {
    self.a.movement = "run";
  }
}

noteTrackAlertnessCasual(note, flagName) {
  if(IsSentient(self)) {
    self.a.alertness = "casual";
  }
}

noteTrackAlertnessAlert(note, flagName) {
  if(IsSentient(self)) {
    self.a.alertness = "alert";
  }
}

noteTrackPoseStand(note, flagName) {
  self.a.pose = "stand";
  self notify("entered_pose" + "stand");
}

noteTrackPoseCrouch(note, flagName) {
  self.a.pose = "crouch";
  self notify("entered_pose" + "crouch");
  if(self.a.crouchPain) {
    self.a.crouchPain = false;
    self.health = 150;
  }
}

noteTrackGravity(note, flagName) {
  if(isSubStr(note, "on")) {
    self AnimMode("gravity");
  } else if(isSubStr(note, "off")) {
    self AnimMode("nogravity");
    self.nogravity = true;
  } else if(isSubStr(note, "code")) {
    self AnimMode("none");
    self.nogravity = undefined;
  }
}

noteTrackBodyFall(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }
  if(isSubStr(note, "large")) {
    self PlaySound("fly_bodyfall_large_" + groundType);
  } else if(isSubStr(note, "small")) {
    self PlaySound("fly_bodyfall_small_" + groundType);
  }
}

noteTrackFootStep(note, flagName) {
  if(isSubStr(note, "left")) {
    playFootStep("J_Ball_LE");
  } else {
    playFootStep("J_BALL_RI");
  }
  if(!level.clientScripts) {
    self PlaySound("fly_gear_run");
  }
}

noteTrackFootScrape(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }
  self PlaySound("fly_step_scrape_" + groundType);
}

noteTrackLand(note, flagName) {
  if(isDefined(self.groundType)) {
    groundType = self.groundType;
  } else {
    groundType = "dirt";
  }
  self PlaySound("fly_land_npc_" + groundType);
}

HandleNoteTrack(note, flagName, customFunction, var1) {
  if(isAI(self) && self.isdog) {
    if(HandleDogSoundNoteTracks(note)) {
      return;
    }
  }
  notetrackFunc = anim.notetracks[note];
  if(isDefined(notetrackFunc)) {
    return [
      [notetrackFunc]
    ](note, flagName);
  }
  switch (note) {
    case "end":
    case "finish":
    case "undefined":
      if(isAI(self) && self.a.pose == "back") {}
      return note;
    case "swish small":
      self thread play_sound_in_space("fly_gear_enemy", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "swish large":
      self thread play_sound_in_space("fly_gear_enemy_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "no death":
      self.a.nodeath = true;
      break;
    case "no pain":
      self.allowpain = false;
      break;
    case "allow pain":
      self.allowpain = true;
      break;
    case "anim_melee = right":
    case "anim_melee = \"right\"":
      self.a.meleeState = "right";
      break;
    case "anim_melee = left":
    case "anim_melee = \"left\"":
      self.a.meleeState = "left";
      break;
    case "swap taghelmet to tagleft":
      if(isDefined(self.hatModel)) {
        if(isDefined(self.helmetSideModel)) {
          self detach(self.helmetSideModel, "TAG_HELMETSIDE");
          self.helmetSideModel = undefined;
        }
        self detach(self.hatModel, "");
        self attach(self.hatModel, "TAG_WEAPON_LEFT");
        self.hatModel = undefined;
      }
      break;
    case "stop anim":
      anim_stopanimscripted();
      return note;
    default:
      if(isDefined(customFunction)) {
        if(!isDefined(var1)) {
          return [
            [customFunction]
          ](note);
        } else {
          return [
            [customFunction]
          ](note, var1);
        }
      }
      break;
  }
}

DoNoteTracks(flagName, customFunction, debugIdentifier, var1) {
  for(;;) {
    self waittill(flagName, note);
    if(!isDefined(note)) {
      note = "undefined";
    }
    val = self HandleNoteTrack(note, flagName, customFunction, var1);
    if(isDefined(val)) {
      return val;
    }
  }
}

DoNoteTracksIntercept(flagName, interceptFunction, debugIdentifier) {
  assert(isDefined(interceptFunction));
  for(;;) {
    self waittill(flagName, note);
    if(!isDefined(note)) {
      note = "undefined";
    }
    intercepted = [
      [interceptFunction]
    ](note);
    if(isDefined(intercepted) && intercepted) {
      continue;
    }
    val = self HandleNoteTrack(note, flagName);
    if(isDefined(val)) {
      return val;
    }
  }
}

DoNoteTracksPostCallback(flagName, postFunction) {
  assert(isDefined(postFunction));
  for(;;) {
    self waittill(flagName, note);
    if(!isDefined(note)) {
      note = "undefined";
    }
    val = self HandleNoteTrack(note, flagName);
    [
      [postFunction]
    ](note);
    if(isDefined(val)) {
      return val;
    }
  }
}

DoNoteTracksForever(flagName, killString, customFunction, debugIdentifier) {
  DoNoteTracksForeverProc(::DoNoteTracks, flagName, killString, customFunction, debugIdentifier);
}

DoNoteTracksForeverIntercept(flagName, killString, interceptFunction, debugIdentifier) {
  DoNoteTracksForeverProc(::DoNoteTracksIntercept, flagName, killString, interceptFunction, debugIdentifier);
}

DoNoteTracksForeverProc(notetracksFunc, flagName, killString, customFunction, debugIdentifier) {
  if(isDefined(killString)) {
    self endon(killString);
  }
  self endon("killanimscript");
  if(!isDefined(debugIdentifier)) {
    debugIdentifier = "undefined";
  }
  for(;;) {
    time = GetTime();
    returnedNote = [
      [notetracksFunc]
    ](flagName, customFunction, debugIdentifier);
    timetaken = GetTime() - time;
    if(timetaken < 0.05) {
      time = GetTime();
      returnedNote = [
        [notetracksFunc]
      ](flagName, customFunction, debugIdentifier);
      timetaken = GetTime() - time;
      if(timetaken < 0.05) {
        println(GetTime() + " " + debugIdentifier + " animscripts\zombie_shared::DoNoteTracksForever is trying to cause an infinite loop on anim " + flagName + ", returned " + returnedNote + ".");
        wait(0.05 - timetaken);
      }
    }
  }
}

DoNoteTracksForTime(time, flagName, customFunction, debugIdentifier) {
  ent = SpawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForever, time, flagName, customFunction, debugIdentifier, ent);
}

DoNoteTracksForTimeIntercept(time, flagName, interceptFunction, debugIdentifier) {
  ent = SpawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForeverIntercept, time, flagName, interceptFunction, debugIdentifier, ent);
}

DoNoteTracksForTimeProc(doNoteTracksForeverFunc, time, flagName, customFunction, debugIdentifier, ent) {
  ent endon("stop_notetracks");
  [[doNoteTracksForeverFunc]](flagName, undefined, customFunction, debugIdentifier);
}

doNoteTracksForTimeEndNotify(time) {
  wait(time);
  self notify("stop_notetracks");
}

playFootStep(foot) {
  if(!level.clientScripts) {
    if(!isAI(self)) {
      self PlaySound("fly_step_run_dirt");
      return;
    }
  }
  groundType = undefined;
  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastGroundtype)) {
      if(!level.clientScripts) {
        self PlaySound("fly_step_run_dirt");
      }
      return;
    }
    groundtype = self.lastGroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastGroundtype = self.groundType;
  }
  if(!level.clientScripts) {
    self PlaySound("fly_step_run_" + groundType);
  }
  [[anim.optionalStepEffectFunction]](foot, groundType);
}

playFootStepEffect(foot, groundType) {
  if(level.clientScripts) {
    return;
  }
  for(i = 0; i < anim.optionalStepEffects.size; i++) {
    if(isDefined(self.fire_footsteps) && self.fire_footsteps) {
      groundType = "fire";
    }
    if(groundType != anim.optionalStepEffects[i]) {
      continue;
    }
    org = self gettagorigin(foot);
    playfx(level._effect["step_" + anim.optionalStepEffects[i]], org, org + (0, 0, 100));
    return;
  }
}

moveToOriginOverTime(origin, time) {
  self endon("killanimscript");
  if(distanceSquared(self.origin, origin) > 16 * 16 && !self mayMoveToPoint(origin)) {
    return;
  }
  self.keepClaimedNodeInGoal = true;
  offset = self.origin - origin;
  frames = int(time * 20);
  offsetreduction = vector_scale(offset, 1.0 / frames);
  for(i = 0; i < frames; i++) {
    offset -= offsetreduction;
    self Teleport(origin + offset);
    wait .05;
  }
  self.keepClaimedNodeInGoal = false;
}

returnTrue() {
  return true;
}