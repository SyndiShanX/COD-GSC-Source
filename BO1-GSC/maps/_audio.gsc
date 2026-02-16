/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_audio.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_music;

main() {
  array_thread(getEntArray("audio_sound_trigger", "targetname"), ::thread_sound_trigger);
  thread fadeinSound();
}
fadeinSound() {
  flag_wait("all_players_connected");
  get_players()[0] playSound("uin_transition_" + level.script);
}
wait_until_first_player() {
  players = get_players();
  if(!isDefined(players[0])) {
    level waittill("first_player_ready");
  }
}
thread_sound_trigger() {
  self waittill("trigger");
  struct_targs = getStructArray(self.target, "targetname");
  ent_targs = getEntArray(self.target, "targetname");
  if(isDefined(struct_targs)) {
    for(i = 0; i < struct_targs.size; i++) {
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
    for(i = 0; i < ent_targs.size; i++) {
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
    self playLoopSound(self.script_sound);
  } else {
    self playSound(self.script_sound);
  }
}
move_sound_along_line() {
  self endon("end line sound");
  wait_until_first_player();
  closest_dist = undefined;
  while(1) {
    self closest_point_on_line_to_point(get_players()[0].origin, self.start, self.end);
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
static_sound_random_play(soundpoint) {
  wait(RandomIntRange(1, 5));
  if(!isDefined(self.script_wait_min)) {
    self.script_wait_min = 1;
  }
  if(!isDefined(self.script_wait_max)) {
    self.script_wait_max = 3;
  }
  while(1) {
    wait(RandomFloatRange(self.script_wait_min, self.script_wait_max));
    soundpoint playSound(self.script_sound);
  }
}
static_sound_loop_play(soundpoint) {
  self playLoopSound(self.script_sound);
}
get_number_variants(aliasPrefix) {
  for(i = 0; i < 100; i++) {
    if(!SoundExists(aliasPrefix + "_" + i)) {
      return i;
    }
  }
}
create_2D_sound_list(sound_alias) {
  player = getplayers();
  if(!isDefined(sound_alias)) {
    return;
  }
  if(!isDefined(level.sound_alias)) {
    level.sound_alias = [];
    level.sound_alias_available = [];
    num_variants = get_number_variants(sound_alias);
    assertex(num_variants > 0, "No variants found for category: " + sound_alias);
    for(i = 0; i < num_variants; i++) {
      level.sound_alias[i] = sound_alias + "_" + i;
    }
  }
  if(level.sound_alias_available.size <= 0) {
    level.sound_alias_available = level.sound_alias;
  }
  variation = random(level.sound_alias_available);
  level.sound_alias_available = array_remove(level.sound_alias_available, variation);
  player[0] playSound(variation, "sound_done");
  player[0] waittill("sound_done");
  level notify("2D_sound_finished");
}
switch_music_wait(music_state, waittime) {
  wait(waittime);
  setmusicstate(music_state);
}
missile_audio_watcher() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    self waittill("missile_fire", missile, weap);
    switch (weap) {
      case "m202_flash_sp":
        break;
      case "m47_dragon_sp":
        break;
      case "m72_law_sp":
        break;
      case "rpg_sp":
        break;
      case "strela_sp":
        break;
      default:
        break;
    }
  }
}
missionFailWatcher() {
  level waittill("missionfailed");
  self notify("death_notify");
}
death_sounds() {
  self thread missionFailWatcher();
  self waittill_either("death_notify", "death");
  println("Sound : do death sound");
  self playSound("chr_death");
}