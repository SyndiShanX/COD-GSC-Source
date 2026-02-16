/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_elevator.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  platform_triggers = getEntArray("elevator_trigger", "targetname");
  if(platform_triggers.size <= 0) {
    return;
  }

  platform_switches = [];
  platforms_non_switched = [];
  platforms_total = [];
  trigger_target_targets = [];

  for(i = 0; i < platform_triggers.size; i++) {
    trigger_target = getEnt(platform_triggers[i].target, "targetname");

    if(!isDefined(trigger_target)) {
      AssertMsg("This trigger does not have a target: " + platform_triggers[i].origin);
    }

    if(isDefined(trigger_target)) {
      trigger_target_targets = getEntArray(trigger_target.target, "targetname");

      if(isDefined(trigger_target_targets) && (trigger_target_targets.size == 1)) {
        platform_switches[platform_switches.size] = trigger_target;
      } else {
        platforms_non_switched[platforms_non_switched.size] = trigger_target;
      }
    }
  }

  for(i = 0; i < platform_switches.size; i++) {
    platform = getEnt(platform_switches[i].target, "targetname");

    if(!isDefined(platform)) {
      AssertMsg("This switch does not target a platform: " + platform_switches[i].origin);
    } else {
      counter = 0;

      for(x = 0; x < platforms_total.size; x++) {
        if(platform == platforms_total[x]) {
          {}
          counter++;
        }
      }

      if(counter > 0) {
        continue;
      } else {
        platforms_total[platforms_total.size] = platform;
      }
    }
  }

  for(i = 0; i < platforms_non_switched.size; i++) {
    counter = 0;

    for(x = 0; x < platforms_total.size; x++) {
      if(platforms_non_switched[i] == platforms_total[x]) {
        counter++;
      }
    }

    if(counter > 0) {
      continue;
    } else {
      platforms_total[platforms_total.size] = platforms_non_switched[i];
    }
  }

  array_thread(platforms_total, ::define_elevator_parts);
}
define_elevator_parts() {
  audio_points = [];
  klaxon_speakers = [];
  elevator_gates = [];
  platform_start = undefined;

  platform = self;
  platform_name = platform.targetname;
  platform.at_start = true;

  platform_triggers = [];
  targets_platform = getEntArray(platform_name, "target");

  for(i = 0; i < targets_platform.size; i++) {
    if(targets_platform[i].classname == "script_model" || targets_platform[i].classname == "script_brushmodel") {
      switch_trigger = getEnt(targets_platform[i].targetname, "target");
      platform_triggers[platform_triggers.size] = switch_trigger;
    } else {
      platform_triggers[platform_triggers.size] = targets_platform[i];
    }
  }

  platform_targets_Ents = getEntArray(platform.target, "targetname");
  platform_targets_Structs = getStructArray(platform.target, "targetname");
  platform_targets = array_combine(platform_targets_Ents, platform_targets_Structs);

  if(platform_targets.size <= 0) {
    AssertMsg("This platform does not have any targets: " + platform.origin);
  }

  if(isDefined(platform_targets)) {
    for(i = 0; i < platform_targets.size; i++) {
      if(isDefined(platform_targets[i].script_noteworthy)) {
        if(platform_targets[i].script_noteworthy == "audio_point") {
          {}
          audio_points[audio_points.size] = platform_targets[i];
        }

        if(platform_targets[i].script_noteworthy == "elevator_gate") {
          {}
          elevator_gates[elevator_gates.size] = platform_targets[i];
        }

        if(platform_targets[i].script_noteworthy == "elevator_klaxon_speaker") {
          {}
          klaxon_speakers[klaxon_speakers.size] = platform_targets[i];
        }

        if(platform_targets[i].script_noteworthy == "platform_start") {
          {}
          platform_start = platform_targets[i];
        }
      }
    }
  }

  if(!isDefined(platform_start)) {
    AssertMsg("This platform does not target a script_struct with a script_noteworthy of platform_start: " + platform.origin);
  }

  if(isDefined(elevator_gates) && (elevator_gates.size > 0)) {
    array_thread(elevator_gates, ::setup_elevator_gates, platform_name);
  }

  if(isDefined(klaxon_speakers) && (klaxon_speakers.size > 0)) {
    array_thread(klaxon_speakers, ::elevator_looping_sounds, "elevator_" + platform_name + "_move", "stop_" + platform_name + "_movement_sound");
  }

  if(isDefined(audio_points) && (audio_points.size > 0)) {
    array_thread(audio_points, ::elevator_looping_sounds, "start_" + platform_name + "_klaxon", "stop_" + platform_name + "_klaxon");
  }

  array_thread(platform_triggers, ::trigger_think, platform_name);

  platform thread move_platform(platform_start, platform_name);
}
trigger_think(platform_name) {
  while(1) {
    self waittill("trigger");

    level notify("start_" + platform_name + "_klaxon");

    wait 2;

    level notify("elevator_" + platform_name + "_move");

    level waittill("elevator_" + platform_name + "_stop");

    level notify("stop_" + platform_name + "_klaxon");
  }
}
elevator_looping_sounds(notify_play, notify_stop) {
  level waittill(notify_play);

  if(isDefined(self.script_sound)) {
    self thread loop_sound_in_space(level.scr_sound[self.script_sound], self.origin, notify_stop);
  }
}
setup_elevator_gates(platform_name) {
  struct = getStruct(self.target, "targetname");
  if(!isDefined(struct)) {
    AssertMsg("This gate does not target a script_struct: " + self.origin);
  }

  self.origin = struct.origin;
  self.angles = struct.angles;

  self thread move_elevator_gates(platform_name, "raise_");
  self thread move_elevator_gates(platform_name, "lower_");
}
move_elevator_gates(platform_name, direction) {
  amount = undefined;
  speed = undefined;

  if(isDefined(self.script_int)) {
    amount = (self.script_int);
  } else {
    amount = (90);
  }

  if(direction == "raise_") {
    amount = (amount * -1);
  }

  if(isDefined(self.script_delay)) {
    speed = self.script_delay;
  } else {
    speed = 1;
  }

  while(1) {
    level waittill(direction + platform_name + "_gates");
    self rotatePitch(amount, speed);
  }
}
move_platform(platform_start, platform_name) {
  move_up = [];
  move_down = [];

  move_up[move_up.size] = platform_start;

  platform_start_first_target = getStruct(platform_start.target, "targetname");

  if(!isDefined(platform_start_first_target)) {
    AssertMsg("This platform start point does not have a script_struct target to move to. There needs to be at least two script_structs to make a path for the elevator to move along: " + platform_start.origin);
  }

  path = true;
  pstruct = platform_start;

  while(path) {
    if(isDefined(pstruct.target)) {
      pstruct = getStruct(pstruct.target, "targetname");

      if(isDefined(pstruct)) {
        move_up[move_up.size] = pstruct;
      }
    } else {
      path = false;
    }
  }

  for(i = move_up.size - 1; i >= 0; i--) {
    move_down[move_down.size] = move_up[i];
  }

  while(1) {
    level waittill("elevator_" + platform_name + "_move");

    wait 2;

    if(isDefined(level.scr_sound["elevator_start"])) {
      self playSound(level.scr_sound["elevator_start"]);
    }

    if(self.at_start) {
      speed = -1;

      for(i = 0; i < move_up.size; i++) {
        org = move_up[i + 1];

        if(isDefined(org)) {
          {}
          speed = get_speed(org, speed);

          time = distance(self.origin, org.origin) / speed;
          self moveto(org.origin, time);
          wait time;
        }
      }

      if(isDefined(self.script_sound)) {
        self playSound(level.scr_sound[self.script_sound]);
      }

      level notify("elevator_" + platform_name + "_stop");
      level notify("stop_" + platform_name + "_movement_sound");
      level notify("stop_" + platform_name + "_klaxon");
      level notify("lower_" + platform_name + "_gates");

      if(isDefined(level.scr_sound["elevator_end"])) {
        self playSound(level.scr_sound["elevator_end"]);
      }

      self.at_start = false;
    } else {
      level notify("raise_" + platform_name + "_gates");

      wait 2;

      level notify("elevator_" + platform_name + "_move");

      if(isDefined(level.scr_sound["elevator_start"])) {
        self playSound(level.scr_sound["elevator_start"]);
      }

      speed = -1;

      for(i = 0; i < move_down.size; i++) {
        org = move_down[i + 1];

        if(isDefined(org)) {
          {}
          speed = get_speed(org, speed);

          time = distance(self.origin, org.origin) / speed;
          self moveto(org.origin, time);
          wait time;
        }
      }

      if(isDefined(self.script_sound)) {
        self playSound(level.scr_sound[self.script_sound]);
      }

      level notify("elevator_" + platform_name + "_stop");
      level notify("stop_" + platform_name + "_movement_sound");
      level notify("stop_" + platform_name + "_klaxon");

      if(isDefined(level.scr_sound["elevator_end"])) {
        self playSound(level.scr_sound["elevator_end"]);
      }

      self.at_start = true;
    }
  }
}
get_speed(path_point, speed) {
  if(speed <= 0) {
    speed = 100;
  }

  if(isDefined(path_point.speed)) {
    speed = path_point.speed;
  }

  return speed;
}