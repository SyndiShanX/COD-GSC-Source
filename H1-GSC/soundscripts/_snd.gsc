/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_snd.gsc
********************************/

snd_init() {
  if(!isdefined(level._snd)) {
    level._snd = spawnstruct();
    level._snd.guid = 0;
    level._snd.default_vid_log_vol = 1.0;
    thread snd_init_done();
    snd_debug_init();
    soundscripts\_snd_hud::snd_hud_init();
    snd_set_soundtable_name(level.script);
    soundscripts\_snd_filters::snd_load_dsp_buses();
    soundscripts\_snd_filters::snd_filters_init();
    soundscripts\_snd_timescale::snd_timescale_init();
    soundscripts\_snd_foley::snd_foley_init();
    snd_message_init();
    soundscripts\_snd_common::snd_common_init();
  }
}

snd_init_done() {
  level._snd.is_first_frame = 1;
  waittillframeend;
  level._snd.is_first_frame = 0;
}

snd_is_first_frame() {
  return level._snd.is_first_frame;
}

snd_message_init() {
  level._snd.messages = [];
}

snd_register_message(var_0, var_1) {
  level._snd.messages[var_0] = var_1;
}

snd_music_message(var_0, var_1, var_2) {
  level notify("stop_other_music");
  level endon("stop_other_music");

  if(isdefined(var_2))
    childthread snd_message("snd_music_handler", var_0, var_1, var_2);
  else if(isdefined(var_1))
    childthread snd_message("snd_music_handler", var_0, var_1);
  else
    childthread snd_message("snd_music_handler", var_0);
}

snd_message(var_0, var_1, var_2, var_3) {
  if(isdefined(level._snd.messages[var_0])) {
    if(isdefined(var_3))
      thread[[level._snd.messages[var_0]]](var_1, var_2, var_3);
    else if(isdefined(var_2))
      thread[[level._snd.messages[var_0]]](var_1, var_2);
    else if(isdefined(var_1))
      thread[[level._snd.messages[var_0]]](var_1);
    else
      thread[[level._snd.messages[var_0]]]();
  }
}

snd_println(var_0) {}

snd_printlnbold(var_0) {}

snd_get_tagarg(var_0, var_1) {
  var_2 = undefined;

  if(isarray(var_1))
    var_2 = var_1[var_0];

  return var_2;
}

snd_get_secs() {
  return gettime() * 0.001;
}

snd_new_guid() {
  level._snd.guid++;
  return level._snd.guid;
}

snd_map(var_0, var_1) {
  return piecewiselinearlookup(var_0, var_1);
}

snd_flash_white() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("white", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1.0;
  var_0.foreground = 1;
  wait 0.05;
  var_0 destroy();
}

snd_slate(var_0) {}

snd_throttle_wait() {
  if(self.count >= self.max_calls_per_frame)
    wait 0.05;
  else
    self.count++;

  if(!self.reset_thread_sent)
    thread snd_throttler_reset();
}

snd_throttler_reset() {
  self.reset_thread_sent = 1;
  waittillframeend;
  self.reset_thread_sent = 0;
  self.count = 0;
}

snd_get_throttler(var_0) {
  var_1 = spawnstruct();
  var_1.name = "throttle_waiter";
  var_1.count = 0;
  var_1.reset_thread_sent = 0;
  var_2 = 10;

  if(isdefined(var_0))
    var_2 = max(var_0, 1);

  var_1.max_calls_per_frame = var_2;
  return var_1;
}

snd_set_soundtable_name(var_0) {
  level._snd.soundtable = var_0;
}

snd_get_soundtable_name() {
  return level._snd.soundtable;
}

snd_parse_preset_header(var_0, var_1, var_2) {
  var_3 = [];

  for (var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_1, var_4);
    var_3[var_5] = var_4;
  }

  return var_3;
}

snd_parse_soundtables(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  for (var_6 = 0; var_6 < var_1.size; var_6++) {
    var_7 = var_1[var_6];
    var_8 = 0;
    var_9 = undefined;
    var_10 = 0;
    var_11 = 0;
    var_12 = undefined;
    var_13 = "";
    var_14 = packedtablesectionlookup(var_7, var_3, var_4);

    if(isdefined(var_14)) {
      while (var_10 < 10 && var_8 + var_14[0] < var_14[1]) {
        var_15 = tablelookupbyrow(var_7, var_8 + var_14[0], var_11);

        if(var_15 != "") {
          var_10 = 0;

          if(!isdefined(var_9)) {
            var_9 = snd_parse_preset_header(var_7, var_8 + var_14[0], var_2);
            var_11 = var_9[var_3];
          } else {
            var_16 = 0;

            if(!isdefined(var_12))
              var_16 = 1;
            else if(var_15 != var_13) {
              var_5[var_13] = var_12;
              var_16 = 1;
            }

            if(var_16) {
              var_12 = spawnstruct();
              var_12.name = var_15;
              var_12.settings = [];
              var_13 = var_15;
            }

            var_17 = [];

            foreach(var_21, var_19 in var_9) {
              var_20 = tablelookupbyrow(var_7, var_8 + var_14[0], var_19);

              if(var_21 == var_3) {
                if(var_20 != var_13) {
                  break;
                }
              } else {
                if(maps\_utility::is_string_a_number(var_20)) {
                  var_17[var_21] = float(var_20);
                  continue;
                }

                var_17[var_21] = var_20;
              }
            }

            var_12.settings[var_12.settings.size] = var_17;
          }
        } else {
          if(isdefined(var_12)) {
            var_5[var_13] = var_12;
            var_12 = undefined;
          }

          var_10++;
        }

        var_8++;
      }

      if(isdefined(var_12)) {
        var_5[var_13] = var_12;
        var_12 = undefined;
      }
    }
  }

  return var_5;
}

snd_debug_init() {}