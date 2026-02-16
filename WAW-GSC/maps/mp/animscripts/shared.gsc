/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\animscripts\shared.gsc
******************************************/

#include common_scripts\utility;
#include maps\mp\animscripts\utility;
#include maps\mp\_utility;

HandleDogSoundNoteTracks(note) {
  if(note == "sound_dogstep_run_default") {
    return true;
  }

  prefix = getsubstr(note, 0, 5);

  if(prefix != "sound") {
    return false;
  }

  return true;
}

growling() {
  return isDefined(self.script_growl);
}

HandleNoteTrack(note, flagName, customFunction, var1) {
  if(getdvarint("debug_dog_notetracks")) {
    println("dog notetrack: " + flagName + " " + note + " " + GetTime());
  }

  if(isAI(self) && self.type == "dog") {
    if(HandleDogSoundNoteTracks(note)) {
      return;
    }
  }
  switch (note) {
    case "end":
    case "finish":
    case "undefined":
      return note;
    default:
      if(isDefined(customFunction)) {
        if(!isDefined(var1)) {
          {}
          return [[customFunction]](note);
        } else {
          {}
          return [[customFunction]](note, var1);
        }
      }
      break;
  }
}
DoNoteTracks(flagName, customFunction, var1) {
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

DoNoteTracksForeverProc(notetracksFunc, flagName, killString, customFunction, var1) {
  if(isDefined(killString)) {
    self endon(killString);
  }
  self endon("killanimscript");

  for(;;) {
    time = GetTime();
    returnedNote = [[notetracksFunc]](flagName, customFunction, var1);
    timetaken = GetTime() - time;
    if(timetaken < 0.05) {
      time = GetTime();
      returnedNote = [[notetracksFunc]](flagName, customFunction, var1);
      timetaken = GetTime() - time;
      if(timetaken < 0.05) {
        println(GetTime() + " animscripts\shared::DoNoteTracksForever is trying to cause an infinite loop on anim " + flagName + ", returned " + returnedNote + ".");

        wait(0.05 - timetaken);
      }
    }
  }
}
DoNoteTracksForever(flagName, killString, customFunction, var1) {
  DoNoteTracksForeverProc(::DoNoteTracks, flagName, killString, customFunction, var1);
}

DoNoteTracksForTimeProc(doNoteTracksForeverFunc, time, flagName, customFunction, ent, var1) {
  ent endon("stop_notetracks");
  [[doNoteTracksForeverFunc]](flagName, undefined, customFunction, var1);
}
DoNoteTracksForTime(time, flagName, customFunction, var1) {
  ent = spawnStruct();
  ent thread doNoteTracksForTimeEndNotify(time);
  DoNoteTracksForTimeProc(::DoNoteTracksForever, time, flagName, customFunction, ent, var1);
}

doNoteTracksForTimeEndNotify(time) {
  wait(time);
  self notify("stop_notetracks");
}

trackLoop() {
  players = get_players();
  deltaChangePerFrame = 5;

  aimBlendTime = .05;

  prevYawDelta = 0;
  prevPitchDelta = 0;
  maxYawDeltaChange = 5;
  maxPitchDeltaChange = 5;

  pitchAdd = 0;
  yawAdd = 0;

  if(self.type == "dog") {
    doMaxAngleCheck = false;
    self.shootEnt = self.enemy;
  } else {
    doMaxAngleCheck = true;
    if(self.a.script == "cover_crouch" && isDefined(self.a.coverMode) && self.a.coverMode == "lean") {
      pitchAdd = -1 * anim.coverCrouchLeanPitch;
    }
    if((self.a.script == "cover_left" || self.a.script == "cover_right") && isDefined(self.a.cornerMode) && self.a.cornerMode == "lean") {
      yawAdd = self.coverNode.angles[1] - self.angles[1];
    }
  }

  yawDelta = 0;
  pitchDelta = 0;

  firstFrame = true;

  for(;;) {
    incrAnimAimWeight();

    selfShootAtPos = (self.origin[0], self.origin[1], self getEye()[2]);

    shootPos = undefined;
    if(isDefined(self.enemy)) {
      shootPos = self.enemy getShootAtPos();
    }

    if(!isDefined(shootPos)) {
      yawDelta = 0;
      pitchDelta = 0;
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
      if(yawDelta > self.rightAimLimit) {
        yawDelta = self.rightAimLimit;
      } else if(yawDelta < self.leftAimLimit) {
        yawDelta = self.leftAimLimit;
      }
      if(pitchDelta > self.upAimLimit) {
        pitchDelta = self.upAimLimit;
      } else if(pitchDelta < self.downAimLimit) {
        pitchDelta = self.downAimLimit;
      }
    }

    if(firstFrame) {
      firstFrame = false;
    } else {
      yawDeltaChange = yawDelta - prevYawDelta;
      if(abs(yawDeltaChange) > maxYawDeltaChange) {
        yawDelta = prevYawDelta + maxYawDeltaChange * sign(yawDeltaChange);
      }

      pitchDeltaChange = pitchDelta - prevPitchDelta;
      if(abs(pitchDeltaChange) > maxPitchDeltaChange) {
        pitchDelta = prevPitchDelta + maxPitchDeltaChange * sign(pitchDeltaChange);
      }
    }

    prevYawDelta = yawDelta;
    prevPitchDelta = pitchDelta;

    updown = 0;
    leftright = 0;

    if(yawDelta > 0) {
      assert(yawDelta <= self.rightAimLimit);
      weight = yawDelta / self.rightAimLimit * self.a.aimweight;
      leftright = weight;
    } else if(yawDelta < 0) {
      assert(yawDelta >= self.leftAimLimit);
      weight = yawDelta / self.leftAimLimit * self.a.aimweight;
      leftright = -1 * weight;
    }

    if(pitchDelta > 0) {
      assert(pitchDelta <= self.upAimLimit);
      weight = pitchDelta / self.upAimLimit * self.a.aimweight;
      updown = weight;
    } else if(pitchDelta < 0) {
      assert(pitchDelta >= self.downAimLimit);
      weight = pitchDelta / self.downAimLimit * self.a.aimweight;
      updown = -1 * weight;
    }

    self SetAimAnimWeights(updown, leftright);
    wait(0.05);
  }
}
setAnimAimWeight(goalweight, goaltime) {
  if(!isDefined(goaltime) || goaltime <= 0) {
    self.a.aimweight = goalweight;
    self.a.aimweight_start = goalweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = 0;
  } else {
    self.a.aimweight = goalweight;
    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = int(goaltime * 20);
  }
  self.a.aimweight_t = 0;
}

incrAnimAimWeight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    t = 1.0 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - t) + self.a.aimweight_end * t;
  }
}