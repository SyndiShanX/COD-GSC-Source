/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_audio.gsc
*********************************************/

init_audio() {
  if(!isDefined(level.audio)) {
    level.audio = spawnStruct();
  }

  init_reverb();
  init_whizby();
  level.onplayerconnectaudioinit = ::onplayerconnectaudioinit;
}

onplayerconnectaudioinit() {
  apply_reverb("default");
}

init_reverb() {
  add_reverb("default", "generic", 0.15, 0.9, 2);
}

add_reverb(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  is_roomtype_valid(param_01);
  var_05["roomtype"] = param_01;
  var_05["wetlevel"] = param_02;
  var_05["drylevel"] = param_03;
  var_05["fadetime"] = param_04;
  level.audio.reverb_settings[param_00] = var_05;
}

is_roomtype_valid(param_00) {}

apply_reverb(param_00) {
  if(!isDefined(level.audio.reverb_settings[param_00])) {
    var_01 = level.audio.reverb_settings["default"];
  } else {
    var_01 = level.audio.reverb_settings[var_01];
  }

  self method_8631("snd_enveffectsprio_level", var_01["roomtype"], var_01["drylevel"], var_01["wetlevel"], var_01["fadetime"]);
}

init_whizby() {
  level.audio.whizby_settings = [];
  set_whizby_radius(15, 30, 50);
  set_whizby_spread(150, 250, 350);
}

set_whizby_radius(param_00, param_01, param_02) {
  level.audio.whizby_settings["radius"] = [param_00, param_01, param_02];
}

set_whizby_spread(param_00, param_01, param_02) {
  level.audio.whizby_settings["spread"] = [param_00, param_01, param_02];
}

apply_whizby() {
  var_00 = level.audio.whizby_settings;
  var_01 = var_00["spread"];
  var_02 = var_00["radius"];
  self setwhizbyspreads(0, var_01[0], var_01[1], var_01[2]);
  self setwhizbyradii(0, var_02[0], var_02[1], var_02[2]);
}

func_8D29(param_00, param_01) {
  if(!isDefined(level.var_11CB.var_7A31)) {
    level.var_11CB.var_7A31 = spawnStruct();
    level.var_11CB.var_7A31.var_94D7 = param_00;
    level.var_11CB.var_7A31.var_7A30 = 0;
  }

  var_02 = [param_00, param_01];
  foreach(var_04 in var_02) {
    if(var_04 > 100) {
      var_04 = 100;
    }

    if(var_04 < 1) {
      var_04 = 1;
    }
  }

  var_06 = randomintrange(1, 100);
  var_07 = level.var_11CB.var_7A31.var_94D7 + level.var_11CB.var_7A31.var_7A30;
  if(var_06 <= var_07) {
    level.var_11CB.var_7A31.var_7A30 = 0;
    return 1;
  }

  if(var_06 >= var_07) {
    level.var_11CB.var_7A31.var_7A30 = level.var_11CB.var_7A31.var_7A30 + param_01;
    return 0;
  }
}

snd_play_team_splash(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = "null";
  }

  if(!isDefined(param_01)) {
    param_01 = "null";
  }

  if(level.teambased) {
    foreach(var_03 in level.players) {
      if(isDefined(var_03) && issentient(var_03) && issentient(self) && var_03.team != self.team) {
        if(function_0344(param_01)) {
          var_03 playlocalsound(param_01);
        }

        continue;
      }

      if(isDefined(var_03) && issentient(var_03) && issentient(self) && var_03.team == self.team) {
        if(function_0344(param_00)) {
          var_03 playlocalsound(param_00);
        }
      }
    }
  }
}

snd_play_on_notetrack_timer(param_00, param_01, param_02, param_03) {}

snd_play_on_notetrack(param_00, param_01, param_02) {
  self endon("stop_sequencing_notetracks");
  self endon("death");
  sndx_play_on_notetrack_internal(param_00, param_01, param_02);
}

sndx_play_on_notetrack_internal(param_00, param_01, param_02) {
  for(;;) {
    self waittill(param_01, var_03);
    if(isDefined(var_03) && var_03 != "end") {
      if(isarray(param_00)) {
        var_04 = param_00[var_03];
        if(isDefined(var_04)) {
          self playSound(var_04);
        }

        continue;
      }

      if(param_01 == var_03) {
        self playSound(param_00);
      }
    }
  }
}

scriptmodelplayanimwithnotify(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_04)) {
    level endon(param_04);
  }

  param_00 method_8278(param_01, param_02);
  thread scriptmodelplayanimwithnotify_notetracks(param_00, param_02, param_03, param_04, param_05, param_06);
}

scriptmodelplayanimwithnotify_notetracks(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_03)) {
    level endon(param_03);
  }

  if(isDefined(param_04)) {
    param_00 endon(param_04);
  }

  if(isDefined(param_05)) {
    param_00 endon(param_05);
  }

  param_00 endon("death");
  for(;;) {
    param_00 waittill(param_01, var_06);
    if(isDefined(var_06) && var_06 == param_01) {
      param_00 playSound(param_02);
    }
  }
}

func_8321(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(isDefined(param_05)) {
    level endon(param_05);
  }

  param_00 method_8278(param_01, param_02);
  thread func_8320(param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_8320(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_04)) {
    level endon(param_04);
  }

  if(isDefined(param_05)) {
    param_00 endon(param_05);
  }

  if(isDefined(param_06)) {
    param_00 endon(param_06);
  }

  param_00 endon("death");
  if(isarray(param_02)) {
    var_07 = param_02.size;
    for(;;) {
      param_00 waittill(param_01, var_08);
      if(isDefined(var_08)) {
        for(var_09 = 0; var_09 < var_07; var_09++) {
          if(var_08 == param_02[var_09]) {
            param_00 playSound(param_03[var_09]);
          }
        }
      }
    }

    return;
  }

  for(;;) {
    param_00 waittill(param_01, var_08);
    if(isDefined(var_08) && var_08 == param_02) {
      param_00 playSound(param_03);
    }
  }
}

snd_veh_play_loops(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = [param_00, param_01, param_02];
  var_05[0] = spawn("script_origin", var_03.origin);
  var_05[0] method_8449(var_03);
  var_05[0] method_861D(param_00);
  var_05[1] = spawn("script_origin", var_03.origin);
  var_05[1] method_8449(var_03);
  var_05[1] method_861D(param_01);
  var_05[2] = spawn("script_origin", var_03.origin);
  var_05[2] method_8449(var_03);
  var_05[2] method_861D(param_02);
  var_03 waittill("death");
  foreach(var_07 in var_05) {
    if(isDefined(var_07)) {
      wait(0.06);
      var_07 delete();
    }
  }
}

deprecated_aud_map(param_00, param_01) {
  var_02 = 0;
  var_03 = param_01.size;
  var_04 = param_01[0];
  for(var_05 = 1; var_05 < param_01.size; var_05++) {
    var_06 = param_01[var_05];
    if(param_00 >= var_04[0] && param_00 <= var_06[0]) {
      var_07 = var_04[0];
      var_08 = var_06[0];
      var_09 = var_04[1];
      var_0A = var_06[1];
      var_0B = param_00 - var_07 / var_08 - var_07;
      var_02 = var_09 + var_0B * var_0A - var_09;
      break;
    } else {
      var_04 = var_06;
    }
  }

  return var_02;
}

snd_play_loop_in_space(param_00, param_01, param_02, param_03) {
  var_04 = 0.2;
  if(isDefined(param_03)) {
    var_04 = param_03;
  }

  var_05 = spawn("script_origin", param_01);
  var_05 method_861D(param_00);
  thread sndx_play_loop_in_space_internal(var_05, param_02, var_04);
  return var_05;
}

sndx_play_loop_in_space_internal(param_00, param_01, param_02) {
  level waittill(param_01);
  if(isDefined(param_00)) {
    param_00 method_861B(0, param_02);
    wait(param_02 + 0.05);
    param_00 delete();
  }
}

snd_script_timer(param_00) {
  level.timer_number = 0;
  if(!isDefined(param_00)) {
    param_00 = 0.1;
  }

  for(;;) {
    iprintln(level.timer_number);
    wait(param_00);
    level.timer_number = level.timer_number + param_00;
  }
}

func_8DA0(param_00, param_01, param_02, param_03) {
  playsoundatpos(param_01, param_00);
}

func_8DA1(param_00, param_01, param_02, param_03, param_04) {
  thread func_8E87(param_01, param_00, param_02);
}

func_8E87(param_00, param_01, param_02) {
  wait(param_02);
  playsoundatpos(param_00, param_01);
}

func_8DA2(param_00, param_01, param_02, param_03) {
  var_04 = playclientsound(param_00, param_01, undefined, undefined, undefined, "hard", undefined, param_03);
}

func_8DA4(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0.05;
  }

  var_03 = playclientsound(param_00, param_01, undefined, undefined, undefined, "hard", undefined, param_02);
}

func_12A4(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  thread aud_print_3d_on_ent(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

aud_print_3d_on_ent(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(self)) {
    var_07 = (1, 1, 1);
    var_08 = (1, 0, 0);
    var_09 = (0, 1, 0);
    var_0A = (0, 1, 1);
    var_0B = 5;
    var_0C = var_07;
    var_0D = 0;
    if(isDefined(param_01)) {
      var_0B = param_01;
    }

    if(isDefined(param_05)) {
      var_0D = param_05;
    }

    var_0B = var_0B * -1;
    if(isDefined(param_02)) {
      var_0C = param_02;
      switch (var_0C) {
        case "red":
          var_0C = var_08;
          break;

        case "white":
          var_0C = var_07;
          break;

        case "blue":
          var_0C = var_0A;
          break;

        case "green":
          var_0C = var_09;
          break;

        default:
          var_0C = var_07;
          break;
      }
    }

    if(isDefined(param_04)) {
      thread audx_print_3d_timer(param_04);
    }

    if(!isDefined(param_06)) {
      param_06 = 0.05;
    }

    self endon("death");
    self endon("aud_stop_3D_print");
    var_0E = param_06 / 0.05;
    while(isDefined(self)) {
      var_10 = param_00;
      if(isDefined(param_03)) {
        var_10 = var_10 + self[[param_03]]();
      }

      wait(param_06);
    }
  }
}

audx_print_3d_timer(param_00) {
  self endon("death");
  wait(param_00);
  if(isDefined(self)) {
    self notify("aud_stop_3D_print");
  }
}

snd_vehicle_mp() {}