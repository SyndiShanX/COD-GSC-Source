/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_audio_ambient.gsc
*****************************************************/

init_ambient() {
  if(isDefined(level._audio.ambient)) {
    return;
  }
  level._audio.ambient = spawnStruct();
  level._audio.ambient.thread_active = 0;
  level._audio.ambient.current_zone = "";
  level._audio.ambient.current = [];
  level._audio.ambient.current["zone"] = [];
  level._audio.ambient.elem_weights = [];
  level._audio.ambient.cached_ambients = [];
  level._audio.ambient.cached_elems = [];
  level._audio.ambient.max_sound_ents = 15;
  level._audio.ambient.sound_ents = [];
}

start_ambient_event_zone(var_0) {
  start_ambient_event_internal("zone", var_0);
}

start_ambient_event_internal(var_0, var_1, var_2, var_3, var_4) {
  maps\_audio_code::cache_ambient(var_1);

  if(!isDefined(level._audio.ambient.cached_ambients[var_1])) {
    return;
  }
  level._audio.ambient.current_zone = var_1;

  if(!level._audio.ambient.thread_active) {
    level thread ambient_event_thread();
  }
}

stop_ambient_event_zone(var_0, var_1) {
  if(var_0 == "") {
    return;
  }
  if(level._audio.ambient.current_zone == var_0) {
    level._audio.ambient.current_zone = "";
    fade_ambient_elems(var_0, var_1);
  }
}

stop_current_ambient() {
  if(level._audio.ambient.current_zone == "") {
    return;
  }
  stop_ambient_event_zone(level._audio.ambient.current_zone);
}

stop_all_ambient_events() {
  stop_ambient_event_zone(level._audio.ambient.current_zone);
}

fade_ambient_elems(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  foreach(var_3 in level._audio.ambient.sound_ents) {
    if(!isDefined(var_3.ambient) || var_3.ambient != var_0) {
      continue;
    }
    var_3 thread fade_ambient_elem_internal(var_1);
  }
}

fade_ambient_elem_internal(var_0) {
  if(isDefined(self.fading)) {
    return;
  }
  self endon("sounddone");
  self.fading = 1;
  thread fade_ambient_elem_reset();
  self scalevolume(0.0, var_0);
  wait(var_0);
  self stopsounds();
  self notify("sounddone");
}

fade_ambient_elem_reset() {
  self waittill("sounddone");
  self scalevolume(1);
  self.fading = undefined;
}

swap_ambient_event_zones(var_0, var_1, var_2, var_3) {
  swap_ambient_event_zone_internal(var_0, var_1);
  swap_ambient_event_zone_internal(var_2, var_3);
}

swap_ambient_event_zone_internal(var_0, var_1) {
  if(isDefined(var_0) && var_0 != "" && var_0 != "none") {
    if(var_1 == 0) {
      stop_ambient_event_zone(var_0);
    } else {
      start_ambient_event_zone(var_0);
    }
  }
}

ambient_event_thread() {
  level endon("stop_ambient_event_thread");
  var_0 = "";
  level._audio.ambient.thread_active = 1;

  for(;;) {
    var_1 = gettime();

    if(level._audio.ambient.current_zone != "") {
      var_2 = level._audio.ambient.current_zone;
      var_3 = level._audio.ambient.cached_ambients[var_2];

      if(isDefined(var_3.serialized)) {
        if(!isDefined(var_3.next_play_time)) {
          var_3 set_next_play_time(1);
        }

        if(var_3.next_play_time <= var_1) {
          if(var_3.events.size > 1) {
            for(var_4 = var_3 get_random_event(); var_4.elem == var_0; var_4 = var_3 get_random_event()) {
              wait 0.05;
            }
          } else
            var_4 = var_3.events[0];

          play_ambient_elem(var_4, var_2);

          if(level._audio.ambient.current_zone != "") {
            var_0 = var_4.elem;
            var_3 set_next_play_time(1);
          }
        }
      } else {
        foreach(var_4 in var_3.events) {
          if(!isDefined(var_4.next_play_time)) {
            var_4 set_next_play_time();
          }

          if(var_4.next_play_time <= var_1) {
            level thread play_ambient_elem(var_4, var_2);
            var_4 set_next_play_time();
          }
        }
      }
    }

    wait 0.05;
  }
}

stop_ambient_event_thread() {
  level notify("stop_ambient_event_thread");
  level._audio.ambient.thread_active = 0;
}

play_ambient_elem(var_0, var_1) {
  var_2 = level._audio.ambient.cached_elems[var_0.elem];
  play_ambient_elem_oneshot(var_2, var_1);
}

play_ambient_elem_oneshot(var_0, var_1) {
  var_2 = var_0["alias"];
  var_3 = get_sound_ent();

  if(!isDefined(var_3)) {
    maps\_audio_code::debug_println("^3play_ambient_elem_oneshot cannot play, out of sound ents");
    return;
  }

  maps\_audio_code::debug_println("play_ambient_elem_oneshot -- ambient: \"" + var_1 + "\" alias: \"" + var_2 + "\"");
  var_3.ambient = var_1;
  var_3.is_playing = 1;
  var_4 = get_elem_position(var_0);
  var_3.origin = var_4 + level.player.origin;
  var_3 playSound(var_2, "sounddone");
  var_3 waittill("sounddone");
  wait 0.1;
  var_3.ambient = undefined;
  var_3.is_playing = 0;
}

get_elem_position(var_0) {
  var_1 = randomfloatrange(var_0["range"][0], var_0["range"][1]);
  var_2 = undefined;

  if(isDefined(var_0["cone"])) {
    var_2 = randomfloatrange(var_0["cone"][0], var_0["cone"][1]);
  } else {
    var_2 = randomfloatrange(0, 360);
  }

  var_3 = anglesToForward((0, var_2, 0)) * var_1;
  return (var_3[0], var_3[1], 0);
}

set_next_play_time(var_0) {
  if(isDefined(var_0)) {
    var_1 = level._audio.ambient.cached_ambients[level._audio.ambient.current_zone].data;
  } else {
    var_1 = level._audio.ambient.cached_elems[self.elem];
  }

  var_2 = randomfloatrange(var_1["time"][0], var_1["time"][1]);
  self.next_play_time = gettime() + var_2 * 1000;
}

get_random_event() {
  var_0 = 0;

  foreach(var_2 in self.events) {
    var_0 = var_0 + var_2.weight;
  }

  var_4 = randomfloat(var_0);
  var_5 = 0;
  var_6 = undefined;

  foreach(var_2 in self.events) {
    var_5 = var_5 + var_2.weight;

    if(var_4 < var_5) {
      var_6 = var_2;
      break;
    }
  }

  return var_6;
}

get_sound_ent() {
  foreach(var_1 in level._audio.ambient.sound_ents) {
    if(!var_1.is_playing) {
      return var_1;
    }
  }

  if(level._audio.ambient.sound_ents.size < level._audio.ambient.max_sound_ents) {
    var_1 = spawn("script_origin", (0, 0, 0));
    var_1.is_playing = 0;
    level._audio.ambient.sound_ents[level._audio.ambient.sound_ents.size] = var_1;
    return var_1;
  }

  return undefined;
}