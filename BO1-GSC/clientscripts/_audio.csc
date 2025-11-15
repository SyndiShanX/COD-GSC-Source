/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_audio.csc
**************************************/

#include clientscripts\_utility;

audio_init(localClientNum) {
  if(localClientNum == 0) {
    snd_snapshot_init();
    thread snd_snapshot_level_fadein();
    startSoundRandoms(localClientNum);
    startSoundLoops();
    startLineEmitters();
    thread bump_trigger_start();
    thread init_audio_step_triggers();
    thread start_player_health_snapshot();
    init_after_save_restore();
  }
}

init_after_save_restore() {
  level waittill("save_restore");
  level thread audio_init(0);
}

snd_snapshot_init() {
  level._sndActiveSnapshot = "default";
  if(!isDefined(level._sndNextSnapshot)) {
    level._sndNextSnapshot = "default";
  }
  setgroupsnapshot(level._sndActiveSnapshot);
  thread snd_snapshot_think();
  thread snd_snapshot_save();
}

snd_snapshot_save() {
  level waittill("save_restore");
  setgroupsnapshot(level._sndActiveSnapshot);
}

snd_set_snapshot(state) {
  level._sndNextSnapshot = state;
  println("snd snapshot debug: set state '" + state + "'");
  level notify("new_bus");
}

snd_snapshot_think() {
  level endon("save_restore");
  for(;;) {
    if(level._sndActiveSnapshot == level._sndNextSnapshot) {
      level waittill("new_bus");
    }
    if(level._sndActiveSnapshot == level._sndNextSnapshot) {
      continue;
    }
    assert(isDefined(level._sndNextSnapshot));
    assert(isDefined(level._sndActiveSnapshot));
    setgroupsnapshot(level._sndNextSnapshot);
    level._sndActiveSnapshot = level._sndNextSnapshot;
  }
}

snd_snapshot_level_fadein() {
  level notify("end_duplicate_fadein");
  level endon("end_duplicate_fadein");
  for(;;) {
    SetLevelFadeSnapshot("fadein", 1.0);
    waitforclient(0);
    wait(0.5);
    snapshot_value = 1.0;
    while(snapshot_value > 0.0) {
      snapshot_value -= 0.05;
      SetLevelFadeSnapshot("fadein", snapshot_value);
      wait(0.02);
    }
    SetLevelFadeSnapshot("fadein", 0.0);
    if(level.zombiemode == true) {
      return;
    }
    player = getlocalplayer(0);
    player waittill("respawn");
  }
}

soundRandom_Thread(localClientNum, randSound) {
  level endon("save_restore");
  if(!isDefined(randSound.script_wait_min)) {
    randSound.script_wait_min = 1;
  }
  if(!isDefined(randSound.script_wait_max)) {
    randSound.script_wait_max = 3;
  }
  while(1) {
    wait(RandomFloatRange(randSound.script_wait_min, randSound.script_wait_max));
    if(!isDefined(randSound.script_sound)) {
      println("ambient sound at " + randSound.origin + " has undefined script_sound");
    } else {
      playSound(localClientNum, randSound.script_sound, randSound.origin);
    }
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

soundLoopThink() {
  if(!isDefined(self.script_sound)) {
    return;
  }
  if(!isDefined(self.origin)) {
    return;
  }
  level endon("save_restore");
  notifyName = "";
  assert(isDefined(notifyName));
  if(isDefined(self.script_string)) {
    notifyName = self.script_string;
  }
  assert(isDefined(notifyName));
  started = true;
  if(isDefined(self.script_int)) {
    started = self.script_int != 0;
  }
  if(started) {
    soundloopemitter(self.script_sound, self.origin);
  }
  if(notifyName != "") {
    println("starting loop notify");
    for(;;) {
      level waittill(notifyName);
      if(started) {
        soundstoploopemitter(self.script_sound, self.origin);
      } else {
        soundloopemitter(self.script_sound, self.origin);
      }
      started = !started;
    }
  } else {}
}

soundLineThink() {
  level endon("save_restore");
  if(!isDefined(self.target)) {
    return;
  }
  target = getstruct(self.target, "targetname");
  if(!isDefined(target)) {
    return;
  }
  notifyName = "";
  if(isDefined(self.script_string)) {
    notifyName = self.script_string;
  }
  started = true;
  if(isDefined(self.script_int)) {
    started = self.script_int != 0;
  }
  if(started) {
    soundLineEmitter(self.script_sound, self.origin, target.origin);
  }
  if(notifyName != "") {
    println("starting line notify");
    for(;;) {
      level waittill(notifyName);
      if(started) {
        soundStopLineEmitter(self.script_sound, self.origin, target.origin);
      } else {
        soundLineEmitter(self.script_sound, self.origin, target.origin);
      }
      started = !started;
    }
  } else {}
}

startSoundLoops() {
  loopers = GetStructArray("looper", "script_label");
  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;
    println("*** Client : Initialising looper sounds - " + loopers.size + " emitters.");
    for(i = 0; i < loopers.size; i++) {
      loopers[i] thread soundLoopThink();
      delay += 1;
      if(delay % 20 == 0) {
        wait(0.01);
      }
    }
  } else {
    println("*** Client : No looper sounds.");
  }
}

startLineEmitters() {
  lineEmitters = GetStructArray("line_emitter", "script_label");
  if(isDefined(lineEmitters) && lineEmitters.size > 0) {
    delay = 0;
    println("*** Client : Initialising line emitter sounds - " + lineEmitters.size + " emitters.");
    for(i = 0; i < lineEmitters.size; i++) {
      lineEmitters[i] thread soundLineThink();
      delay += 1;
      if(delay % 20 == 0) {
        wait(0.01);
      }
    }
  } else {
    println("*** Client : No line emitter sounds.");
  }
}

init_audio_step_triggers() {
  waitforclient(0);
  trigs = getEntArray(0, "audio_step_trigger", "targetname");
  println("Client : " + trigs.size + " audio_step_triggers.");
  array_thread(trigs, ::audio_step_trigger);
}

audio_step_trigger(trig) {
  for(;;) {
    self waittill("trigger", trigPlayer);
    self thread trigger_thread(trigPlayer, ::trig_enter_audio_step_trigger, ::trig_leave_audio_step_trigger);
  }
}

trig_enter_audio_step_trigger(trigPlayer) {
  if(!isDefined(trigPlayer.movementtype)) {
    trigPlayer.movementtype = "null";
  }
  if(isDefined(self.script_label)) {
    trigPlayer.step_sound = self.script_label;
  }
  if(isDefined(self.script_sound) && (trigPlayer.movementtype == "sprint")) {
    volume = 9;
    self playSound(0, self.script_sound, self.origin, volume);
  }
}

trig_leave_audio_step_trigger(trigPlayer) {
  if(isDefined(self.script_noteworthy) && (trigPlayer.movementtype == "sprint")) {
    volume = 9;
    self playSound(0, self.script_noteworthy, self.origin, volume);
  }
  trigPlayer.step_sound = "null";
}

bump_trigger_start() {
  bump_trigs = getEntArray(0, "audio_bump_trigger", "targetname");
  for(i = 0; i < bump_trigs.size; i++) {
    bump_trigs[i] thread thread_bump_trigger();
  }
}

thread_bump_trigger() {
  self thread bump_trigger_listener();
  if(!isDefined(self.script_activated)) {
    self.script_activated = 1;
  }
  for(;;) {
    self waittill("trigger", trigPlayer);
    self thread trigger_thread(trigPlayer, ::trig_enter_bump, ::trig_leave_bump);
  }
}

trig_enter_bump(ent) {
  volume = get_vol_from_speed(ent);
  if(isDefined(self.script_sound) && self.script_activated) {
    if(isDefined(self.script_noteworthy) && isDefined(self.script_wait) && (self.script_wait > volume)) {
      test_id = self playSound(0, self.script_noteworthy, self.origin, volume);
    }
    if(!isDefined(self.script_wait) || (self.script_wait <= volume)) {
      test_id = self playSound(0, self.script_sound, self.origin, volume);
    }
  }
}

trig_leave_bump(ent) {}
bump_trigger_listener() {
  if(isDefined(self.script_label)) {
    level waittill(self.script_label);
    self.script_activated = 0;
  }
}

start_player_health_snapshot() {
  if(isDefined(level.zombiemode) && level.zombiemode == true) {
    return;
  }
  level endon("save_restore");
  wait(1);
  max_health = GetLocalClientMaxHealth(0);
  last_health = 0;
  health_snapshot = "pain_heavy_occlude";
  SetHealthSnapshot(health_snapshot, 0);
  for(;;) {
    wait(0.05);
    health = GetLocalClientHealth(0);
    if(health > 70) {
      health_scale = 0;
    } else {
      health_scale = 1 - (health * (1 / 100));
    }
    SetHealthSnapshot(health_snapshot, health_scale);
  }
}

scale_speed(x1, x2, y1, y2, z) {
  if(z < x1)
    z = x1;
  if(z > x2)
    z = x2;
  dx = x2 - x1;
  n = (z - x1) / dx;
  dy = y2 - y1;
  w = (n * dy + y1);
  return w;
}

get_vol_from_speed(player) {
  min_speed = 21;
  max_speed = 285;
  max_vol = 1;
  min_vol = .1;
  speed = player getspeed();
  if(speed == 0) {
    speed = 175;
  }
  if(isDefined(level.footstep_vol_override)) {
    min_vol = .5;
  }
  abs_speed = absolute_value(int(speed));
  volume = scale_speed(min_speed, max_speed, min_vol, max_vol, abs_speed);
  return volume;
}

absolute_value(fowd) {
  if(fowd < 0)
    return (fowd * -1);
  else
    return fowd;
}

closest_point_on_line_to_point(Point, LineStart, LineEnd) {
  self endon("end line sound");
  LineMagSqrd = lengthsquared(LineEnd - LineStart);
  t = (((Point[0] - LineStart[0]) * (LineEnd[0] - LineStart[0])) +
      ((Point[1] - LineStart[1]) * (LineEnd[1] - LineStart[1])) +
      ((Point[2] - LineStart[2]) * (LineEnd[2] - LineStart[2]))) /
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

playloopat(localClientNum, aliasname, origin, fade) {
  if(!isDefined(fade))
    fade = 0;
  fake_ent = spawnfakeent(localClientNum);
  setfakeentorg(localClientNum, fake_ent, origin);
  playLoopSound(localClientNum, fake_ent, aliasname, fade);
  return fake_ent;
}

snd_play_auto_fx(fxid, alias) {
  for(i = 0; i < level.createFXent.size; i++) {
    if(level.createFXent[i].v["fxid"] == fxid && !isDefined(level.createFXent[i].soundEnt)) {
      level.createFXent[i].soundEnt = spawnFakeEnt(0);
      setfakeentorg(0, level.createFXent[i].soundEnt, level.createFXent[i].v["origin"]);
      playLoopSound(0, level.createFXent[i].soundEnt, alias, .5);
    }
  }
}

snd_delete_auto_fx(fxid) {
  for(i = 0; i < level.createFXent.size; i++) {
    if(level.createFXent[i].v["fxid"] == fxid && isDefined(level.createFXent[i].soundEnt)) {
      deletefakeent(0, level.createFXent[i].soundEnt);
      level.createFXent[i].soundEnt = undefined;
    }
  }
}

snd_print_fx_id(fxid, type, ent) {
  printLn("^5******* fxid; " + fxid + "^5 type; " + type);
}

debug_line_emitter() {
  while(1) {}
}

move_sound_along_line() {
  closest_dist = undefined;
  while(1) {
    self closest_point_on_line_to_point(getlocalclientpos(0), self.start, self.end);
    if(isDefined(self.fake_ent)) {
      setfakeentorg(self.localClientNum, self.fake_ent, self.origin);
    }
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

line_sound_player() {
  if(isDefined(self.script_looping)) {
    self.fake_ent = spawnfakeent(self.localClientNum);
    setfakeentorg(self.localClientNum, self.fake_ent, self.origin);
    playLoopSound(self.localClientNum, self.fake_ent, self.script_sound);
  } else {
    playSound(self.localClientNum, self.script_sound, self.origin);
  }
}

soundwait(id) {
  while(soundplaying(id)) {
    wait(0.1);
  }
}

sound_movie_snapshot_start() {
  while(1) {
    level waittill("pms");
    wait(0.3);
    snd_set_snapshot("alloff_except_voice_music");
  }
}

sound_movie_snapshot_alloff_but_mid_start() {
  while(1) {
    level waittill("pmsao");
    wait(0.2);
    snd_set_snapshot("flashback_duck");
  }
}

sound_movie_snapshot_stop() {
  while(1) {
    level waittill("pmo");
    snd_set_snapshot("default");
  }
}