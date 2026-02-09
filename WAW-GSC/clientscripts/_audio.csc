/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_audio.csc
**************************************/

#include clientscripts\_utility;

soundRandom_Thread(localClientNum, randSound) {
  if(!isDefined(randSound.script_wait_min)) {
    randSound.script_wait_min = 1;
  }
  if(!isDefined(randSound.script_wait_max)) {
    randSound.script_wait_max = 3;
  }

  if(getdvarint("debug_audio") > 0) {
    println("*** Client : SR ( " + randSound.script_wait_min + " - " + randSound.script_wait_max + ")");
  }

  while(1) {
    pause = RandomFloatRange(randSound.script_wait_min, randSound.script_wait_max);
    wait(pause);
    playSound(localClientNum, randSound.script_sound, randSound.origin);

    if(getdvarint("debug_audio") > 0) {
      print3d(randSound.origin, randSound.script_sound, (0.0, 0.8, 0.0), 1, 3, 45);
    }
  }
}
soundLoop_Thread(localClientNum, loopSound) {
  playloopat(localClientNum, loopSound.script_sound, loopSound.origin, 1);

  if(getdvarint("debug_audio") > 0) {
    while(1) {
      print3d(loopSound.origin, loopSound.script_sound, (0.0, 0.8, 0.0), 1, 3, 30);
      wait(1);
    }
  }

}
closest_point_on_line_to_point(Point, LineStart, LineEnd) {
  self endon("end line sound");

  LineMagSqrd = lengthsquared(LineEnd - LineStart);

  t = (((Point[0] - LineStart[0]) * (LineEnd[0] - LineStart[0])) + ((Point[1] - LineStart[1]) * (LineEnd[1] - LineStart[1])) + ((Point[2] - LineStart[2]) * (LineEnd[2] - LineStart[2]))) /
    (LineMagSqrd);

  if(t < 0.0) {
    self.origin = LineStart;
  } else if(t > 1.0) {
    self.origin = LineEnd;
  } else {
    start_x = LineStart[0] + t * (LineEnd[0] - LineStart[0]);
    start_y = LineStart[1] + t * (LineEnd[1] - LineStart[1]);
    start_z = LineStart[2] + t * (LineEnd[2] - LineStart[2]);

    self.origin = (start_x, start_y, start_z);
  }
}

line_sound_player() {
  if(isDefined(self.script_looping)) {
    self.fake_ent = spawnfakeent(self.localClientNum);
    setfakeentorg(self.localClientNum, self.fake_ent, self.origin);
    playLoopSound(self.localClientNum, self.fake_ent, self.script_sound, 1);
  } else {
    playSound(self.localClientNum, self.script_sound, self.origin);
  }
}

debug_line_emitter() {
  while(1) {
    if(getdvarint("debug_audio") > 0) {
      line(self.start, self.end, (0, 1, 0));

      print3d(self.start, "START", (0.0, 0.8, 0.0), 1, 3, 1);
      print3d(self.end, "END", (0.0, 0.8, 0.0), 1, 3, 1);
      print3d(self.origin, self.script_sound, (0.0, 0.8, 0.0), 1, 3, 1);
    }

    wait(0.01);
  }
}

watch_player() {
  self endon("end line sound");

  UPDATE_THRESHOLD = 128 * 128;
  p = getlocalclientpos(0);

  while(1) {
    q = getlocalclientpos(0);
    d = DistanceSquared(p, q);
    p = q;

    if(d > UPDATE_THRESHOLD) {
      level notify("sound_line_player_moved");
    }

    wait(.05);
  }
}

update_line_position() {
  self closest_point_on_line_to_point(getlocalclientpos(0), self.start, self.end);

  if(isDefined(self.fake_ent)) {
    setfakeentorg(self.localClientNum, self.fake_ent, self.origin);
  }
}

move_sound_along_line_fixup() {
  self endon("end line sound");

  while(1) {
    level waittill("sound_line_player_moved");
    self update_line_position();
  }
}

move_sound_along_line() {
  closest_dist = undefined;

  self thread debug_line_emitter();

  while(1) {
    self update_line_position();

    closest_dist = DistanceSquared(getlocalclientpos(0), self.origin);

    if(closest_dist > 1024 * 1024) {
      wait(2);
    } else if(closest_dist > 512 * 512) {
      wait(0.2);
    } else {
      wait(0.05);
    }
  }
}

lineEmitter_Thread(localClientNum) {
  thread waitforclient(0);

  startOfLine = self;

  if(!isDefined(startOfLine)) {
    assertmsg("_audio::spawn_line_sound(): Could not find start of line entity! Aborting...");
    return;
  }

  self.soundmover = [];

  endOfLineEntity = undefined;

  if(isDefined(self.target)) {
    endOfLineEntity = getstruct(self.target, "targetname");
  }

  if(isDefined(endOfLineEntity)) {
    soundMover = spawnStruct();

    soundMover.start = self.origin;
    soundMover.origin = self.origin;
    soundMover.end = endOfLineEntity.origin;
    soundMover.script_sound = self.script_sound;
    soundMover.localClientNum = localClientNum;

    self.soundmover = soundMover;

    if(isDefined(self.script_looping)) {
      soundMover.script_looping = self.script_looping;
    }

    soundMover line_sound_player();
    soundMover thread move_sound_along_line();
    soundMover thread move_sound_along_line_fixup();
  }
}

startSoundRandoms(localClientNum) {
  randoms = GetStructArray("random", "script_label");

  if(isDefined(randoms) && randoms.size > 0) {
    println("*** Client : Initialising random sounds - " + randoms.size + " emitters.");
    for(i = 0; i < randoms.size; i++) {
      thread soundRandom_Thread(localClientNum, randoms[i]);
    }
  } else {
    println("*** Client : No random sounds.");
  }
}

startSoundLoops(localClientNum) {
  loopers = GetStructArray("looper", "script_label");

  if(isDefined(loopers) && loopers.size > 0) {
    println("*** Client : Initialising looper sounds - " + loopers.size + " emitters.");
    for(i = 0; i < loopers.size; i++) {
      thread soundLoop_Thread(localClientNum, loopers[i]);
    }
  } else {
    println("*** Client : No looper sounds.");
  }
}

startLineEmitters(localClientNum) {
  lineEmitters = GetStructArray("line_emitter", "script_label");

  if(isDefined(lineEmitters) && lineEmitters.size > 0) {
    println("*** Client : Initialising line emitter sounds - " + lineEmitters.size + " emitters.");
    for(i = 0; i < lineEmitters.size; i++) {
      lineEmitters[i] thread lineEmitter_Thread(localClientNum);
    }
  } else {
    println("*** Client : No line emitter sounds.");
  }
}

berzerk_thread() {
  ent = spawnfakeent(0);
  for(;;) {
    level waittill("berzerk_audio_on");
    playLoopSound(0, ent, "berzerker_loop", 1);
    level waittill("berzerk_audio_off");
    stoploopsound(0, ent, 1);
  }
}

audio_init(localClientNum) {
  startSoundRandoms(localClientNum);
  startSoundLoops(localClientNum);
  startLineEmitters(localClientNum);
  thread watch_player();
  thread berzerk_thread();
}

playloopat(localClientNum, aliasname, origin, fade) {
  if(!isDefined(fade)) {
    fade = 0;
  }
  fake_ent = spawnfakeent(localClientNum);
  setfakeentorg(localClientNum, fake_ent, origin);
  playLoopSound(localClientNum, fake_ent, aliasname, fade);
  return fake_ent;
}

soundwait(id) {
  while(soundplaying(id)) {
    wait(.1);
  }
}