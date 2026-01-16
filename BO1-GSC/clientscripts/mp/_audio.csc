/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_audio.csc
***************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_ambientpackage;

audio_init(localClientNum) {
  level.loudenemies = false;
  waitforclient(0);
  if(localClientNum == 0) {
    snd_snapshot_init();
    startSoundRandoms(localClientNum);
    startSoundLoops();
    startLineEmitters();
    thread snd_ninja_pro_checker();
    thread bump_trigger_start();
    thread init_audio_step_triggers();
    thread snd_mp_end_round();
    thread snd_final_killcam();
  }
}
snd_snapshot_init() {
  level._sndActiveSnapshot = "default";
  level._sndNextSnapshot = "default";
  setgroupsnapshot(level._sndActiveSnapshot);
  thread snd_snapshot_think();
}
snd_set_snapshot(state) {
  level._sndNextSnapshot = state;
  println("snd snapshot debug: set state '" + state + "'");
  level notify("new_bus");
}
snd_snapshot_think() {
  for (;;) {
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
snd_mp_end_round() {
  level waittill("snd_end_rnd");
  println("setting round end snapshot");
  snd_set_snapshot("mp_round_end");
}
snd_mp_snapshot_reset() {}
soundRandom_Thread(localClientNum, randSound) {
  if(!isDefined(randSound.script_wait_min)) {
    randSound.script_wait_min = 1;
  }
  if(!isDefined(randSound.script_wait_max)) {
    randSound.script_wait_max = 3;
  }
  while (1) {
    wait(RandomFloatRange(randSound.script_wait_min, randSound.script_wait_max));
    if(!isDefined(randSound.script_sound)) {
      println("ambient sound at " + randSound.origin + " has undefined script_sound");
    } else {
      playsound(localClientNum, randSound.script_sound, randSound.origin);
    }
  }
}
startSoundRandoms(localClientNum) {
  randoms = GetStructArray("random", "script_label");
  if(isDefined(randoms) && randoms.size > 0) {
    println("*** Client : Initialising random sounds - " + randoms.size + " emitters.");
    for (i = 0; i < randoms.size; i++) {
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
    for (;;) {
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
    println(" starting line notify");
    for (;;) {
      level waittill(notifyName);
      if(started) {
        soundStopLineEmitter(self.script_sound, self.origin, target.origin);
      } else {
        soundLineEmitter(self.script_sound, self.origin, target.origin);
      }
      started = !started;
    }
  } else {
    println("line doesn't take notifies");
  }
}
startSoundLoops() {
  loopers = GetStructArray("looper", "script_label");
  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;
    for (i = 0; i < loopers.size; i++) {
      loopers[i] thread soundLoopThink();
      delay += 1;
      if(delay % 20 == 0) {
        wait(0.01);
      }
    }
  } else {}
}
startLineEmitters() {
  lineEmitters = GetStructArray("line_emitter", "script_label");
  if(isDefined(lineEmitters) && lineEmitters.size > 0) {
    delay = 0;
    for (i = 0; i < lineEmitters.size; i++) {
      lineEmitters[i] thread soundLineThink();
      delay += 1;
      if(delay % 20 == 0) {
        wait(0.01);
      }
    }
  } else {}
}
init_audio_step_triggers() {
  waitforclient(0);
  trigs = GetEntArray(0, "audio_step_trigger", "targetname");
  array_thread(trigs, ::audio_step_trigger);
}
audio_step_trigger(trig) {
  for (;;) {
    self waittill("trigger", trigPlayer);
    self thread trigger_thread(trigPlayer, ::trig_enter_audio_step_trigger, ::trig_leave_audio_step_trigger);
  }
}
trig_enter_audio_step_trigger(trigPlayer) {
  if(trigPlayer HasPerk("specialty_quieter")) {
    return;
  }
  if(!isDefined(trigPlayer.movementtype)) {
    trigPlayer.movementtype = "none";
  }
  if(!isDefined(trigPlayer.inStepTrigger)) {
    trigPlayer.inStepTrigger = 0;
  }
  if(Isdefined(self.script_label)) {
    trigPlayer.step_sound = self.script_label;
    trigPlayer.inStepTrigger = trigPlayer.inStepTrigger + 1;
  }
  if(Isdefined(self.script_sound) && (trigPlayer.movementtype == "sprint")) {
    volume = get_vol_from_speed(trigPlayer);
    trigPlayer playsound(0, self.script_sound, self.origin, volume);
  }
}
trig_leave_audio_step_trigger(trigPlayer) {
  if(trigPlayer HasPerk("specialty_quieter")) {
    return;
  }
  if(Isdefined(self.script_noteworthy) && (trigPlayer.movementtype == "sprint")) {
    volume = get_vol_from_speed(trigPlayer);
    trigPlayer playsound(0, self.script_noteworthy, self.origin, volume);
  }
  trigPlayer.inStepTrigger = trigPlayer.inStepTrigger - 1;
  if(trigPlayer.inStepTrigger < 0) {
    println("AUDIO WARNING InStepTrigger less than 0. Should never be. setting to 0");
    trigPlayer.inStepTrigger = 0;
  }
  if(trigPlayer.inStepTrigger == 0) {
    trigPlayer.step_sound = "none";
  }
}
bump_trigger_start() {
  bump_trigs = GetEntArray(0, "audio_bump_trigger", "targetname");
  for (i = 0; i < bump_trigs.size; i++) {
    bump_trigs[i] thread thread_bump_trigger();
  }
}
thread_bump_trigger() {
  self thread bump_trigger_listener();
  if(!isDefined(self.script_activated)) {
    self.script_activated = 1;
  }
  for (;;) {
    self waittill("trigger", trigPlayer);
    self thread trigger_thread(trigPlayer, ::trig_enter_bump, ::trig_leave_bump);
  }
}
trig_enter_bump(ent) {
  if(ent HasPerk("specialty_quieter")) {
    return;
  }
  volume = get_vol_from_speed(ent);
  if(isDefined(self.script_sound) && (self.script_activated)) {
    if(isDefined(self.script_noteworthy) && (self.script_wait > volume)) {
      test_id = ent playsound(0, self.script_noteworthy, self.origin, volume);
    }
    if(isDefined(self.script_parameters)) {
      test_id = ent playsound(0, self.script_parameters, self.origin, volume);
    }
    if(!isDefined(self.script_wait) || (self.script_wait <= volume)) {
      test_id = ent playsound(0, self.script_sound, self.origin, volume);
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
snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area) {
  for (i = 0; i < level.createFXent.size; i++) {
    if(level.createFXent[i].v["fxid"] == fxid) {
      level.createFXent[i].soundEnt = spawnFakeEnt(0);
      if(isDefined(area)) {
        level.createFXent[i].soundEntArea = area;
      }
      origin = level.createFXent[i].v["origin"];
      if(isDefined(offsetx) && offsetx > 0) {
        origin = origin + (offsetx, 0, 0);
      }
      if(isDefined(offsety) && offsetx > 0) {
        origin = origin + (0, offsety, 0);
      }
      if(isDefined(offsetz) && offsetx > 0) {
        origin = origin + (0, 0, offsetz);
      }
      if(isDefined(onground) && onground) {
        trace = undefined;
        d = undefined;
        FxOrigin = origin;
        trace = bullettrace(FxOrigin, FxOrigin - (0, 0, 100000), false, undefined);
        d = distance(FxOrigin, trace["position"]);
        origin = trace["position"];
      }
      setfakeentorg(0, level.createFXent[i].soundEnt, origin);
      playloopsound(0, level.createFXent[i].soundEnt, alias, .5);
    }
  }
}
snd_play_auto_fx_area_emmiters() {
  for (i = 0; i < level.createFXent.size; i++) {
    if(level.createFXent[i].soundEntArea > 1) {}
  }
}
snd_print_fx_id(fxid, type, ent) {}
debug_line_emitter() {
  while (1) {}
}
move_sound_along_line() {
  closest_dist = undefined;
  while (1) {
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
    playloopsound(self.localClientNum, self.fake_ent, self.script_sound);
  } else {
    playsound(self.localClientNum, self.script_sound, self.origin);
  }
}
playloopat(localClientNum, aliasname, origin, fade) {
  if(!isDefined(fade))
    fade = 0;
  fake_ent = spawnfakeent(localClientNum);
  setfakeentorg(localClientNum, fake_ent, origin);
  playloopsound(localClientNum, fake_ent, aliasname, fade);
  return fake_ent;
}
player_printer() {
  wait(40);
  for (;;) {
    players = getlocalplayers();
    println(players[0] getspeed());
    wait(0.1);
  }
}
soundwait(id) {
  while (soundplaying(id)) {
    wait(0.1);
  }
}
snd_final_killcam() {
  while (true) {
    level waittill("fkcb");
    playsound(0, "mpl_final_kill_cam_sting");
    activateAmbientRoom(0, "final_kill_cam", 10);
    level waittill("fkce");
    wait(.01);
    deactivateAmbientRoom(0, "final_kill_cam", 10);
  }
}
snd_ninja_pro_watcher() {
  while (1) {
    level waittill("loudenemies_on");
    level waittill("loudenemies_off");
  }
}
snd_ninja_pro_checker() {
  while (1) {
    players = getlocalplayers();
    if(players[0] HasPerk("Specialty_loudenemies")) {
      level.loudenemies = true;
    } else {
      level.loudenemies = false;
    }
    wait(1);
  }
}