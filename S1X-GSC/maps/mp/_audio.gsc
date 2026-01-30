/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_audio.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init_audio() {
  if(!isDefined(level.audio)) {
    level.audio = spawnStruct();
  }

  init_reverb();
  init_whizby();

  level.onPlayerConnectAudioInit = ::OnPlayerConnectAudioInit;
}

OnPlayerConnectAudioInit() {
  self apply_reverb("default");
}

init_reverb() {
  add_reverb("default", "generic", 0.15, 0.9, 2);
}

add_reverb(name, type, wetlevel, drylevel, fadetime) {
  Assert(isDefined(type));
  Assert(isDefined(wetlevel));
  Assert(isDefined(drylevel));

  reverb = [];

  is_roomtype_valid(type);

  reverb["roomtype"] = type;
  reverb["wetlevel"] = wetlevel;
  reverb["drylevel"] = drylevel;
  reverb["fadetime"] = fadetime;

  level.audio.reverb_settings[name] = reverb;
}

is_roomtype_valid(type) {
  switch (type) {
    case "generic":
    case "paddedcell":
    case "room":
    case "bathroom":
    case "livingroom":
    case "stoneroom":
    case "auditorium":
    case "concerthall":
    case "cave":
    case "arena":
    case "hangar":
    case "carpetedhallway":
    case "hallway":
    case "stonecorridor":
    case "alley":
    case "forest":
    case "city":
    case "mountains":
    case "quarry":
    case "plain":
    case "parkinglot":
    case "sewerpipe":
    case "underwater":
    case "drugged":
    case "dizzy":
    case "psychotic":
      return;
    default:
      AssertMsg(type + " is an Invalid Roomtype");
      break;
  }

}

apply_reverb(name) {
  if(!isDefined(level.audio.reverb_settings[name])) {
    reverb = level.audio.reverb_settings["default"];
  } else {
    reverb = level.audio.reverb_settings[name];
  }

  self SetReverb("snd_enveffectsprio_level", reverb["roomtype"], reverb["drylevel"], reverb["wetlevel"], reverb["fadetime"]);
}

init_whizby() {
  SetDevDvar("snd_newwhizby", 1);

  level.audio.whizby_settings = [];
  set_whizby_radius(15.0, 30.0, 50.0);
  set_whizby_spread(150.0, 250.0, 350.0);
}

set_whizby_radius(near, medium, far) {
  level.audio.whizby_settings["radius"] = [near, medium, far];
}

set_whizby_spread(near, medium, far) {
  level.audio.whizby_settings["spread"] = [near, medium, far];
}

apply_whizby() {
  settings = level.audio.whizby_settings;

  spread = settings["spread"];
  rad = settings["radius"];

  self SetWhizbySpreads(spread[0], spread[1], spread[2]);
  self SetWhizbyRadii(rad[0], rad[1], rad[2]);
}

snd_play_team_splash(ally_sfx, enemy_sfx) {
  if(!isDefined(ally_sfx)) {
    ally_sfx = "null";
  }
  if(!isDefined(enemy_sfx)) {
    enemy_sfx = "null";
  }

  if(level.teambased) {
    foreach(player in level.players) {
      if(isDefined(player) && IsSentient(player) && IsSentient(self) && player.team != self.team) {
        if(SoundExists(enemy_sfx)) {
          player playlocalsound(enemy_sfx);
        }
      } else if(isDefined(player) && IsSentient(player) && IsSentient(self) && player.team == self.team) {
        if(SoundExists(ally_sfx)) {
          player playlocalsound(ally_sfx);
        }
      }
    }
  }
}

snd_play_on_notetrack_timer(alias, notetrack_frame, start_frame, _cleanup_time) {}

snd_play_on_notetrack(aliases, notetrack, _customfunction) {
  self endon("stop_sequencing_notetracks");
  self endon("death");
  self sndx_play_on_notetrack_internal(aliases, notetrack, _customfunction);
}

sndx_play_on_notetrack_internal(aliases, notetrack, _customfunction) {
  for(;;) {
    self waittill(notetrack, note);

    if(isDefined(note) && note != "end") {
      if(isarray(aliases)) {
        alias = aliases[note];
        if(isDefined(alias)) {
          self playSound(alias);
        }
      } else {
        if(notetrack == note) {
          self playSound(aliases);
        }
      }
    }
  }
}

ScriptModelPlayAnimWithNotify(guy, animName, notifyName, alias, customlevelend, customguyend1, customguyend2) {
  if(isDefined(customlevelend)) {
    level endon(customlevelend);
  }

  guy ScriptModelPlayAnimDeltaMotion(animName, notifyName);
  thread ScriptModelPlayAnimWithNotify_Notetracks(guy, notifyName, alias, customlevelend, customguyend1, customguyend2);
}

ScriptModelPlayAnimWithNotify_Notetracks(guy, notifyName, alias, customlevelend, customguyend1, customguyend2) {
  if(isDefined(customlevelend)) {
    level endon(customlevelend);
  }

  if(isDefined(customguyend1)) {
    guy endon(customguyend1);
  }

  if(isDefined(customguyend2)) {
    guy endon(customguyend2);
  }

  guy endon("death");

  for(;;) {
    guy waittill(notifyName, note);

    if(isDefined(note) && (note == notifyName)) {
      guy playSound(alias);
    }
  }
}

snd_veh_play_loops(loop_01, loop_02, loop_03) {
  vehicle = self;
  loop_array = [loop_01, loop_02, loop_03];

  ent_array[0] = spawn("script_origin", vehicle.origin);
  ent_array[0] LinkToSynchronizedParent(vehicle);
  ent_array[0] playLoopSound(loop_01);

  ent_array[1] = spawn("script_origin", vehicle.origin);
  ent_array[1] LinkToSynchronizedParent(vehicle);
  ent_array[1] playLoopSound(loop_02);

  ent_array[2] = spawn("script_origin", vehicle.origin);
  ent_array[2] LinkToSynchronizedParent(vehicle);
  ent_array[2] playLoopSound(loop_03);

  vehicle waittill("death");

  foreach(ent in ent_array) {
    if(isDefined(ent)) {
      wait(0.06);
      ent delete();
    }
  }
}

DEPRECATED_aud_map(input, env_points) {
  assert(isDefined(input));
  assert(input >= 0.0 && input <= 1.0);
  assert(isDefined(env_points));

  output = 0.0;
  num_points = env_points.size;

  prev_point = env_points[0];
  for(i = 1; i < env_points.size; i++) {
    next_point = env_points[i];
    if(input >= prev_point[0] && input <= next_point[0]) {
      prev_x = prev_point[0];
      next_x = next_point[0];
      prev_y = prev_point[1];
      next_y = next_point[1];
      x_fract = (input - prev_x) / (next_x - prev_x);
      output = prev_y + x_fract * (next_y - prev_y);
      break;
    } else {
      prev_point = next_point;
    }
  }

  assert(output >= 0.0 && output <= 1.0);

  return output;
}

snd_play_loop_in_space(alias_name, org, stop_loop_notify, fadeout_time_) {
  fadeout_time = 0.2;

  if(isDefined(fadeout_time_)) {
    fadeout_time = fadeout_time_;
  }

  snd_ent = spawn("script_origin", org);
  snd_ent playLoopSound(alias_name);

  thread sndx_play_loop_in_space_internal(snd_ent, stop_loop_notify, fadeout_time);

  return snd_ent;
}

sndx_play_loop_in_space_internal(snd_ent, stop_loop_notify, fadeout_time) {
  level waittill(stop_loop_notify);

  if(isDefined(snd_ent)) {
    snd_ent scalevolume(0, fadeout_time);
    wait(fadeout_time + 0.05);
    snd_ent delete();
  }
}

snd_script_timer(speed) {
  level.timer_number = 0;

  if(!isDefined(speed)) {
    speed = 0.1;
  }

  while(1) {
    iprintln(level.timer_number);
    wait(speed);
    level.timer_number = level.timer_number + speed;
  }
}

snd_play_in_space(alias_name, org, _cleanup_time, _fadeout_time) {
  cleanup_time = 9;
  fadeout_time = 0.75;

  snd_ent = spawn("script_origin", org);
  snd_ent playSound(alias_name);
  snd_ent thread sndx_play_in_space_internal(cleanup_time, fadeout_time);
  return snd_ent;
}

sndx_play_in_space_internal(_cleanup_time, _fadeout_time) {
  cleanup_time = 9;
  fadeout_time = 0.05;
  snd_ent = self;

  if(isDefined(_cleanup_time)) {
    cleanup_time = _cleanup_time;
  }

  if(isDefined(_fadeout_time)) {
    fadeout_time = _fadeout_time;
  }

  wait(cleanup_time);

  if(isDefined(snd_ent)) {
    snd_ent scalevolume(0, fadeout_time);
    wait(fadeout_time + 0.05);

    if(isDefined(snd_ent)) {
      snd_ent delete();
    }
  }
}

snd_play_in_space_delayed(alias_name, org, delay_time, _cleanup_time, _fadeout_time) {
  cleanup_time = 9;
  fadeout_time = 0.75;

  snd_ent = spawn("script_origin", org);
  snd_ent thread sndx_play_in_space_delayed_internal(alias_name, delay_time, _cleanup_time, _fadeout_time);
  return snd_ent;
}

sndx_play_in_space_delayed_internal(alias_name, delay_time, _cleanup_time, _fadeout_time) {
  wait(delay_time);
  cleanup_time = 9;
  fadeout_time = 0.05;
  snd_ent = self;

  snd_ent playSound(alias_name);

  if(isDefined(_cleanup_time)) {
    cleanup_time = _cleanup_time;
  }

  if(isDefined(_fadeout_time)) {
    fadeout_time = _fadeout_time;
  }

  wait(cleanup_time);

  if(isDefined(snd_ent)) {
    snd_ent scalevolume(0, fadeout_time);
    wait(fadeout_time + 0.05);

    if(isDefined(snd_ent)) {
      snd_ent delete();
    }
  }
}

snd_play_linked(alias_name, ent, _cleanup_time, _fadeout_time) {
  snd_ent = spawn("script_origin", ent.origin);
  snd_ent linkto(ent);
  snd_ent thread sndx_play_linked_internal(alias_name, ent, _cleanup_time, _fadeout_time);
  return snd_ent;
}

sndx_play_linked_internal(alias_name, ent, _cleanup_time, _fadeout_time) {
  cleanup_time = 9;
  fadeout_time = 0.05;
  snd_ent = self;

  snd_ent playSound(alias_name);

  if(isDefined(_cleanup_time)) {
    cleanup_time = _cleanup_time;
  }

  if(isDefined(_fadeout_time)) {
    fadeout_time = _fadeout_time;
  }

  wait(cleanup_time);

  if(isDefined(snd_ent)) {
    snd_ent scalevolume(0, fadeout_time);
    wait(fadeout_time + 0.05);
    snd_ent delete();
  }
}

snd_play_linked_loop(alias_name, ent, _fadeout_time) {
  snd_ent = spawn("script_origin", ent.origin);
  snd_ent linkto(ent);
  snd_ent thread sndx_play_linked_loop_internal(alias_name, ent, _fadeout_time);
  return snd_ent;
}

sndx_play_linked_loop_internal(alias_name, ent, _fadeout_time) {
  fadeout_time = 0.05;
  snd_ent = self;

  snd_ent playLoopSound(alias_name);

  if(isDefined(_fadeout_time)) {
    fadeout_time = _fadeout_time;
  }

  ent waittill("death");

  if(isDefined(snd_ent)) {
    snd_ent scalevolume(0, fadeout_time);
    wait(fadeout_time + 0.05);
    snd_ent delete();
  }
}

aud_print_3d_on_ent(msg, _size, _text_color, _msg_callback, durration_) {
  if(isDefined(self)) {
    white = (1, 1, 1);
    red = (1, 0, 0);
    green = (0, 1, 0);
    blue = (0, 1, 1);

    size = 5;
    text_color = white;

    if(isDefined(_size)) {
      size = _size;
    }

    if(isDefined(_text_color)) {
      text_color = _text_color;

      switch (text_color) {
        case "red": {
          text_color = red;
        }
        break;
        case "white": {
          text_color = white;
        }
        break;
        case "blue": {
          text_color = blue;
        }
        break;
        case "green": {
          text_color = green;
        }
        break;

        default: {
          text_color = white;
        }
      }
    }

    if(isDefined(durration_)) {
      self thread audx_print_3d_timer(durration_);
    }

    self endon("death");
    self endon("aud_stop_3D_print");

    while(isDefined(self)) {
      full_msg = msg;
      if(isDefined(_msg_callback)) {
        full_msg = full_msg + self[[_msg_callback]]();
      }
      Print3d(self.origin, full_msg, text_color, 1, size, 1);
      wait(0.05);
    }
  }
}

audx_print_3d_timer(durration_) {
  self endon("death");
  assert(isDefined(durration_));
  wait(durration_);
  if(isDefined(self)) {
    self notify("aud_stop_3D_print");
  }
}

snd_vehicle_mp() {}