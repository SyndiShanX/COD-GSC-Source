/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_audio.gsc
*****************************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {
  array_thread(GetEntArray("audio_sound_trigger", "targetname"), ::thread_sound_trigger);
  array_thread(GetEntArray("audio_bump_trigger", "targetname"), ::thread_bump_trigger);
  array_thread(GetEntArray("audio_step_trigger", "targetname"), ::thread_step_trigger);
}

wait_until_first_player() {
  players = get_players();
  if(!isDefined(players[0])) {
    level waittill("first_player_ready");
  }
}

thread_sound_trigger() {
  self waittill("trigger");
  struct_targs = getstructarray(self.target, "targetname");
  ent_targs = getentarray(self.target, "targetname");
  if(isDefined(struct_targs)) {
    for (i = 0; i < struct_targs.size; i++) {
      if(!level.clientscripts) {
        if(!isDefined(struct_targs[i].script_sound)) {
          assertmsg("_audio::thread_sound_trigger(): script_sound is UNDEFINED! Aborting..." + struct_targs[i].origin);
          return;
        }
        struct_targs[i] thread spawn_line_sound(struct_targs[i].script_sound);
      }
    }
  }
  if(isDefined(ent_targs)) {
    for (i = 0; i < ent_targs.size; i++) {
      if(!isDefined(ent_targs[i].script_sound)) {
        assertmsg("_audio::thread_sound_trigger(): script_sound is UNDEFINED! Aborting... " + ent_targs[i].origin);
        return;
      }
      if(isDefined(ent_targs[i].script_label) && ent_targs[i].script_label == "random") {
        if(!level.clientscripts) {
          ent_targs[i] thread static_sound_random_play(ent_targs[i]);
        }
      } else if(isDefined(ent_targs[i].script_label) && ent_targs[i].script_label == "looper") {
        if(!level.clientscripts) {
          ent_targs[i] thread static_sound_loop_play(ent_targs[i]);
        }
      }
    }
  }
}

spawn_line_sound(sound) {
  startOfLine = self;
  if(!isDefined(startOfLine)) {
    assertmsg("_audio::spawn_line_sound(): Could not find start of line entity! Aborting...");
    return;
  }
  self.soundmover = [];
  endOfLineEntity = getstruct(startOfLine.target, "targetname");
  if(isDefined(endOfLineEntity)) {
    start = startOfLine.origin;
    end = endOfLineEntity.origin;
    soundMover = spawn("script_origin", start);
    soundMover.script_sound = sound;
    self.soundmover = soundMover;
    if(isDefined(self.script_looping)) {
      soundMover.script_looping = self.script_looping;
    }
    if(isDefined(soundMover)) {
      soundMover.start = start;
      soundMover.end = end;
      soundMover line_sound_player();
      soundMover thread move_sound_along_line();
    } else {
      assertmsg("Unable to create line emitter script origin");
    }
  } else {
    assertmsg("_audio::spawn_line_sound(): Could not find end of line entity! Aborting...");
  }
}

line_sound_player() {
  self endon("end line sound");
  if(isDefined(self.script_looping)) {
    self playloopsound(self.script_sound);
  } else {
    self playsound(self.script_sound);
  }
}

move_sound_along_line() {
  self endon("end line sound");
  wait_until_first_player();
  closest_dist = undefined;
  while (1) {
    self closest_point_on_line_to_point(get_players()[0].origin, self.start, self.end);
    if(getdvarint("debug_audio") > 0) {
      line(self.start, self.end, (0, 1, 0));
      print3d(self.start, "START", (1.0, 0.8, 0.5), 1, 3);
      print3d(self.end, "END", (1.0, 0.8, 0.5), 1, 3);
      print3d(self.origin, self.script_sound, (1.0, 0.8, 0.5), 1, 3);
    }
    closest_dist = DistanceSquared(get_players()[0].origin, self.origin);
    if(closest_dist > 1024 * 1024) {
      wait(2);
    } else if(closest_dist > 512 * 512) {
      wait(0.2);
    } else {
      wait(0.05);
    }
  }
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

stop_line_sound(startOfLineEntity) {
  startpoints = getstructarray(startOfLineEntity, "script_noteworthy");
  for (i = 0; i < startpoints.size; i++) {
    if(!isDefined(startpoints[i].soundmover)) {
      println("Line emitter wasn't spawned before delete call... are you sure this isn't messed up?");
      return;
    }
    startpoints[i].soundmover notify("end line sound");
    startpoints[i].soundmover delete();
  }
}

static_sound_random_play(soundpoint) {
  wait(RandomIntRange(1, 5));
  if(!isDefined(self.script_wait_min)) {
    self.script_wait_min = 1;
  }
  if(!isDefined(self.script_wait_max)) {
    self.script_wait_max = 3;
  }
  while (1) {
    wait(RandomFloatRange(self.script_wait_min, self.script_wait_max));
    soundpoint playsound(self.script_sound);
    if(getdvarint("debug_audio") > 0) {
      print3d(soundpoint.origin, self.script_sound, (1.0, 0.8, 0.5), 1, 3, 5);
    }
  }
}

static_sound_loop_play(soundpoint) {
  self playloopsound(self.script_sound);
  if(getdvarint("debug_audio") > 0) {
    while (1) {
      print3d(soundpoint.origin, self.script_sound, (1.0, 0.8, 0.5), 1, 3, 5);
      wait(1);
    }
  }
}

thread_bump_trigger() {
  self thread bump_trigger_listener();
  if(!isDefined(self.script_activated)) {
    self.script_activated = 1;
  }
  while (1) {
    self waittill("trigger", who);
    if(isDefined(self.script_sound) && self.script_activated) {
      self playsound(self.script_sound);
    }
    while (isDefined(who) && (who) IsTouching(self)) {
      wait(0.1);
    }
  }
}

stand_think(trig) {
  killText = "kill_stand_think" + trig getentitynumber();
  self endon("disconnect");
  self endon("death");
  self endon(killText);
  if(!isDefined(trig.script_wait_min) || !isDefined(trig.script_wait_max)) {
    return;
  }
  while (1) {
    wait(randomfloatrange(trig.script_wait_min, trig.script_wait_max));
    self playsound(trig.script_label);
  }
}

thread_enter_exit_sound(trig) {
  self endon("death");
  self endon("disconnect");
  trig.touchingPlayers[self getentitynumber()] = 1;
  if(isDefined(trig.script_sound) && trig.script_activated) {
    self playsound(trig.script_sound);
  }
  self thread stand_think(trig);
  while (self IsTouching(trig)) {
    wait(0.1);
  }
  self notify("kill_stand_think" + trig getentitynumber());
  self playsound(trig.script_noteworthy);
  trig.touchingPlayers[self getentitynumber()] = 0;
}

thread_step_trigger() {
  iprintlnbold("found_a_step_trig");
  if(!isDefined(self.script_activated)) {
    self.script_activated = 1;
  }
  if(!isDefined(self.touchingPlayers)) {
    self.touchingPlayers = [];
    for (i = 0; i < 4; i++) {
      self.touchingPlayers[i] = 0;
    }
  }
  while (1) {
    self waittill("trigger", who);
    if(self.touchingPlayers[who getentitynumber()] == 0) {
      who thread thread_enter_exit_sound(self);
    }
  }
}

disable_bump_trigger(triggername) {
  triggers = GetEntArray("audio_bump_trigger", "targetname");
  if(isDefined(triggers)) {
    for (i = 0; i < triggers.size; i++) {
      if(isDefined(triggers[i].script_label) && triggers[i].script_label == triggername) {
        triggers[i].script_activated = 0;
      }
    }
  }
}

bump_trigger_listener() {
  if(isDefined(self.script_label)) {
    level waittill(self.script_label);
    self.script_activated = 0;
  }
}

get_player_index_number(player) {
  players = get_players();
  for (i = 0; i < players.size; i++) {
    if(players[i] == player) {
      return i;
    }
  }
  return 1;
}