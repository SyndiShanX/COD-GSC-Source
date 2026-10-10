/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_48324b060b129b7b.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_3a8f9ace195c9da9;
#using scripts\anim\dialogue;
#using scripts\cp\utility;
#using scripts\cp_mp\stealth\stealth_music;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\utility;
#namespace namespace_e36cb7ca6117d2cc;

function function_b020837be462da86(temp_text, end_on) {
  if(isDefined(end_on)) {
    level endon(end_on);
  }

  if(getdvarint(@ "hash_f4b32b8d0c852808", 1) == 1 && getdvarint(@ "gl_video", 0) == 0) {
    temp_dialogue(temp_text);
  }

  wait 4;
}

function temp_dialogue(string) {
  if(getdvarint(@ "hash_f4b32b8d0c852808", 1) == 1 && getdvarint(@ "gl_video", 0) == 0) {
    level thread function_ccd1abbf81f9fa6(string);
  }
}

function private function_ccd1abbf81f9fa6(string) {
  level notify("<dev string:x1c>");
  var_4321c6192701317e = 0.3;
  holdtime = 4;
  fadetime = 2;
  fontscale = 1.2;
  var_b54520c420443a7c = int(5.9 * fontscale);
  var_d102c78475d99749 = int(24 * fontscale);
  endy = 300;
  bg = newhudelem();
  text = newhudelem();
  min_width = 350;
  width = int(max(string.size * var_b54520c420443a7c, min_width));
  array = [bg, text];
  array_thread(array, &dialog_new_line_monitor);

  foreach(hud in array) {
    hud.alignx = "<dev string:x29>";
    hud.aligny = "<dev string:x30>";
    hud.x = 320;
    hud.y = endy;
    hud.sort = 5;
  }

  bg.alpha = 0.1;
  bg setshader("<dev string:x37>", width, var_d102c78475d99749);

  text setdevtext(string);

  text.fontscale = fontscale;
  wait holdtime;

  foreach(hud in array) {
    hud fadeovertime(fadetime);
    hud.alpha = 0;
  }

  wait fadetime;

  foreach(hud in array) {
    hud destroy();
  }
}

function private dialog_new_line_monitor() {
  self endon("death");

  while(true) {
    level waittill("new_dialogue");
    self moveovertime(0.35);
    self.y += 30;
    waitframe();
  }
}

function function_31fcf0528e5d8d3f(vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_cebad859d459605c("critical", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check);
}

function function_171dea4e0c9a6281(var_bc597ccfa6d07960, vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_82656546efb86120(var_bc597ccfa6d07960, "critical", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check);
}

function function_227d97458ce08880(vo, trigger_check, endon_check, vo_combat, combat_check) {
  return function_cebad859d459605c("noncritical", vo, trigger_check, endon_check, vo_combat, combat_check);
}

function function_d6ae85f5832a5aec(var_bc597ccfa6d07960, vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_82656546efb86120(var_bc597ccfa6d07960, "noncritical", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check);
}

function function_8f7dd478ffe07d07(vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_cebad859d459605c("persistent", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check);
}

function function_eef4df793801949(var_bc597ccfa6d07960, vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_82656546efb86120(var_bc597ccfa6d07960, "persistent", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check);
}

function function_cb768dd6f5442c68(var_e87fdd2c64f9716c, var_746bbca5c4516524, vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_cebad859d459605c("nag", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check, var_e87fdd2c64f9716c, var_746bbca5c4516524);
}

function function_64d16d22e137d314(var_bc597ccfa6d07960, var_e87fdd2c64f9716c, var_746bbca5c4516524, vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_82656546efb86120(var_bc597ccfa6d07960, "nag", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check, var_e87fdd2c64f9716c, var_746bbca5c4516524);
}

function function_86ee87fa1ec56de9(vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_cebad859d459605c("incidental", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check);
}

function function_72658a29dde85577(var_bc597ccfa6d07960, vo_noncombat, trigger_check, endon_check, vo_combat, combat_check) {
  return function_82656546efb86120(var_bc597ccfa6d07960, "incidental", vo_noncombat, trigger_check, endon_check, vo_combat, combat_check);
}

function private function_82656546efb86120(var_bc597ccfa6d07960, vo_type, vo_noncombat, trigger_check, endon_check, vo_combat, combat_check, time, repeat_nag) {
  level endon("game_over");
  level endon("game_ended");
  self endon("death");
  var_8a096e9ae8c05f06 = undefined;

  if(isDefined(vo_noncombat)) {
    assertex(isarray(vo_noncombat) || vo_noncombat == "", "say_dungeon_once() expects an array of conversation arrays for its vo_noncombat parameter.");

    if(isstring(vo_noncombat) && vo_noncombat == "") {
      var_8a096e9ae8c05f06 = vo_noncombat;
    } else {
      if(isDefined(level.player.pers["one_off_lines"])) {
        foreach(vo in vo_noncombat) {
          for(string_id = vo; isarray(string_id); string_id = string_id[0]) {}

          if(!isDefined(level.player.pers["one_off_lines"][string_id])) {
            var_8a096e9ae8c05f06 = vo;
            break;
          }
        }

        if(!isDefined(var_8a096e9ae8c05f06) && var_bc597ccfa6d07960) {
          var_8a096e9ae8c05f06 = vo_noncombat[vo_noncombat.size - 1];
        }
      } else {
        var_8a096e9ae8c05f06 = vo_noncombat[0];
      }

      vo_override = getdvarint(@ "hash_116d6ef2cec84d51", 0);

      if(vo_override > 0) {
        if(vo_override > vo_noncombat.size) {
          if(var_bc597ccfa6d07960) {
            var_8a096e9ae8c05f06 = vo_noncombat[vo_noncombat.size - 1];
          } else {
            var_8a096e9ae8c05f06 = undefined;
          }
        } else {
          var_8a096e9ae8c05f06 = vo_noncombat[vo_override - 1];
        }
      }

    }
  }

  var_674adaa25840b45b = undefined;

  if(isDefined(vo_combat)) {
    assertex(isarray(vo_combat) || vo_combat == "", "say_dungeon_once() expects an array of conversation arrays for its vo_combat parameter.");

    if(isstring(vo_combat) && vo_combat == "") {
      var_674adaa25840b45b = vo_combat;
    } else {
      if(isDefined(level.player.pers["one_off_lines"])) {
        foreach(vo in vo_combat) {
          for(string_id = vo; isarray(string_id); string_id = string_id[0]) {}

          if(!isDefined(level.player.pers["one_off_lines"][string_id])) {
            var_674adaa25840b45b = vo;
            break;
          }
        }

        if(!isDefined(var_674adaa25840b45b) && var_bc597ccfa6d07960) {
          var_674adaa25840b45b = vo_combat[vo_combat.size - 1];
        }
      } else {
        var_674adaa25840b45b = vo_combat[0];
      }

      vo_override = getdvarint(@ "hash_116d6ef2cec84d51", 0);

      if(vo_override > 0) {
        if(vo_override > vo_combat.size) {
          if(var_bc597ccfa6d07960) {
            var_674adaa25840b45b = vo_combat[vo_combat.size - 1];
          } else {
            var_674adaa25840b45b = undefined;
          }
        } else {
          var_674adaa25840b45b = vo_combat[vo_override - 1];
        }
      }

    }
  }

  if(!isDefined(var_8a096e9ae8c05f06) && !isDefined(var_674adaa25840b45b)) {
    if(isDefined(trigger_check)) {
      if(!isarray(trigger_check)) {
        trigger_check = [trigger_check];
      }
    }

    if(isDefined(endon_check)) {
      if(isstring(endon_check)) {
        endon_check = [endon_check];
      }
    }

    while(isDefined(trigger_check) && !function_d2d3ee8c76511439(trigger_check) && isDefined(endon_check) && !function_6907702392fb190c(endon_check)) {
      wait 1;
    }

    return 0;
  }

  return function_cebad859d459605c(vo_type, var_8a096e9ae8c05f06, trigger_check, endon_check, var_674adaa25840b45b, combat_check, time, repeat_nag, 1);
}

function private function_cebad859d459605c(vo_type, vo_noncombat, trigger_check, endon_check, vo_combat, combat_check, time, repeat, var_9ae28940ec3c9121) {
  if(isDefined(time) && isint(time)) {
    time = float(time);
  }

  assertex(isDefined(vo_noncombat) || isDefined(vo_combat), "_say_dungeon() function called with neither combat nor noncombat VO line defined.");
  assertex(!isDefined(trigger_check) || isstring(trigger_check) || isarray(trigger_check) || isfunction(trigger_check), "trigger_check parameter in _say_dungeon() is not a string nor an array of strings.");
  assertex(!isDefined(endon_check) || isstring(endon_check) || isarray(endon_check) || isfunction(trigger_check), "endon_check parameter in _say_dungeon() is not a string nor an array of strings.");
  assertex(vo_type != "nag" || isfloat(time), "_say_dungeon() function is attempting to play a 'nag' vo, but nag time isn't defined. Is the VO tag string being passed in instead of a nag time?");
  level endon("game_over");
  level endon("game_ended");
  self endon("death");

  if(isDefined(endon_check)) {
    if(isstring(endon_check)) {
      endon_check = [endon_check];
    }

    foreach(item in endon_check) {
      level endon(item);
      self endon(item);
    }
  }

  if(isDefined(trigger_check)) {
    if(!isarray(trigger_check)) {
      trigger_check = [trigger_check];
    }
  }

  team = "allies";

  if(isDefined(self.scope)) {
    team = self.scope;
  } else if(isDefined(self.team)) {
    team = self.team;
  }

  var_ccc6a03fe3ca4fe6 = undefined;
  var_fe5facc98db35a69 = undefined;
  repeat = default_to(repeat, 0);
  var_9ae28940ec3c9121 = default_to(var_9ae28940ec3c9121, 0);
  priority = undefined;
  timeout = undefined;
  endons = undefined;

  if(isfunction(endon_check)) {
    timeout = endon_check;
  } else if(isarray(endon_check) || isstring(endon_check)) {
    endons = endon_check;
  }

  switch (vo_type) {
    case #"hash_7b0c1410a389e6e8":
      priority = 1;
      break;
    case #"hash_54cfd0b53dec463d":
      var_ccc6a03fe3ca4fe6 = 0;
      priority = 0.5;
      break;
    case #"hash_aba5a17ce738e820":
      var_ccc6a03fe3ca4fe6 = 5;
      priority = 0.5;
      break;
    case #"hash_365dda7285aaf39a":
    case #"hash_4075266c2bfb0d95":
      var_ccc6a03fe3ca4fe6 = 15;
      priority = 0;
      timeout = 0;
      break;
  }

  while(true) {
    var_873549b569d7b961 = function_d2d3ee8c76511439(trigger_check);

    if(!var_873549b569d7b961) {
      if(vo_type == "nag") {
        var_fe5facc98db35a69 = undefined;
      }

      waitframe();
      continue;
    }

    if(vo_type == "nag") {
      if(!isDefined(var_fe5facc98db35a69)) {
        var_fe5facc98db35a69 = gettime();
      }

      if(gettime() - var_fe5facc98db35a69 < time * 1000) {
        waitframe();
        continue;
      }
    }

    if(vo_type != "critical") {
      if(team == "allies") {
        if(function_6c31b0b0edd184ed([level.player], var_ccc6a03fe3ca4fe6)) {
          wait 1;
          continue;
        }
      } else if(function_6c31b0b0edd184ed([self], var_ccc6a03fe3ca4fe6)) {
        wait 1;
        continue;
      }
    }

    vo_line = undefined;

    if(isDefined(vo_noncombat) && !isDefined(vo_combat)) {
      vo_line = vo_noncombat;
    } else if(isDefined(vo_combat) && !isDefined(vo_noncombat)) {
      vo_line = vo_combat;
    } else if(isDefined(vo_noncombat) && isDefined(vo_combat)) {
      combat_check = default_to(combat_check, &namespace_a0852b262a68d01::function_155f16ed1b7f00cd);
      vo_line = ter_op([[combat_check]](), vo_combat, vo_noncombat);

      if(!isarray(vo_line) && (vo_line == "" || vo_line == " ")) {
        vo_line = undefined;
      }
    }

    if(isDefined(vo_line)) {
      if(vo_type == "critical") {
        if(team == "allies") {
          function_cb329cf8896edeaa(team);
        } else {
          stop_dialogue();
        }

        wait 0.1;
      }

      vo_played = say_sequence(vo_line, priority, timeout, undefined, undefined, undefined, endons);

      if(!isDefined(vo_played)) {
        if(istrue(var_9ae28940ec3c9121)) {
          function_a4aa053d45ddbe50(vo_line);
        }

        return 1;
      } else if(vo_played) {
        if(istrue(var_9ae28940ec3c9121)) {
          function_a4aa053d45ddbe50(vo_line);
        }

        if(vo_type == "nag" && repeat) {
          var_fe5facc98db35a69 = undefined;
        } else {
          return 1;
        }
      } else {
        switch (vo_type) {
          case #"hash_7b0c1410a389e6e8":
            waitframe();
            break;
          case #"hash_4075266c2bfb0d95":
          case #"hash_aba5a17ce738e820":
            wait 1;
            break;
          case #"hash_365dda7285aaf39a":
          case #"hash_54cfd0b53dec463d":
            return 0;
        }
      }
    }

    waitframe();
  }
}

function function_a4aa053d45ddbe50(vo) {
  while(!isDefined(level.player)) {
    waitframe();
  }

  if(!isDefined(level.player.pers["one_off_lines"])) {
    level.player.pers["one_off_lines"] = [];
  }

  if(isstring(vo)) {
    level.player.pers["one_off_lines"][vo] = 1;
    return;
  }

  if(isarray(vo)) {
    foreach(id in vo) {
      level.player.pers["one_off_lines"][id] = 1;
    }
  }
}

function function_53b88af7755302d2(music_hidden, music_investigate, music_hunt, music_spotted) {
  flag_wait("flag_dungeon_intro_complete");

  if(!isDefined(music_hidden)) {
    music_hidden = "mx_sys_hidden";
  }

  if(!isDefined(music_spotted)) {
    music_spotted = "mx_sys_spotted";
  }

  thread scripts\cp_mp\stealth\stealth_music::function_9ff225017ef5ce19();
  level thread scripts\stealth\utility::stealth_music(music_hidden, music_spotted);
}

function function_4ded73402b984ff9(surfacetype) {
  slidestartsound = "slide_start_plr";

  if(isDefined(surfacetype)) {
    if(surfacetype == "wet") {
      slidestartsound = "slide_plr_dam_wall_wet_start";
    } else if(surfacetype == "dry") {
      slidestartsound = "slide_plr_dam_wall_dry_start";
    }

    if(soundexists(slidestartsound)) {
      thread play_sound_on_entity(slidestartsound);
    }

    return;
  }

  var_73b8384749fff985 = create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1);
  surface_trace = ray_trace(level.player getEye() + (0, 0, 200), level.player getEye() - (0, 0, 100), level.player, var_73b8384749fff985, 1);

  if(isDefined(surface_trace)) {
    surface = function_2e84a570d6af300a(surface_trace["surfacetype"], "surftype_");

    if(isDefined(surface)) {
      level.slidesurface = surface;
    }
  }

  if(isDefined(level.slidesurface)) {
    self playsurfacesound(slidestartsound, level.slidesurface);
  }
}

function function_ddf979aedbe53699(surfacetype) {
  slideloopsound = "slide_loop_plr";

  if(isDefined(surfacetype)) {
    if(surfacetype == "wet") {
      slideloopsound = "slide_plr_dam_wall_wet";
    } else if(surfacetype == "dry") {
      slideloopsound = "slide_plr_dam_wall_dry";
    }

    if(soundexists(slideloopsound)) {
      thread play_loop_sound_on_entity(slideloopsound);
    }

    return;
  }

  if(isDefined(level.slidesurface)) {
    self playsurfacesound(slideloopsound, level.slidesurface);
  }
}

function function_215b249240166e44(surfacetype) {
  slideloopsound = "slide_loop_plr";
  slideendsound = "slide_ease_out_plr";

  if(isDefined(surfacetype)) {
    if(surfacetype == "wet") {
      slideloopsound = "slide_plr_dam_wall_wet";
      slideendsound = "slide_plr_dam_wall_wet_ease_out";
    } else if(surfacetype == "dry") {
      slideloopsound = "slide_plr_dam_wall_dry";
      slideendsound = "slide_plr_dam_wall_dry_ease_out";
    }

    thread stop_loop_sound_on_entity(slideloopsound);

    if(soundexists(slideendsound)) {
      thread play_sound_on_entity(slideendsound);
    }

    return;
  }

  thread stop_loop_sound_on_entity(slideloopsound);

  if(isDefined(level.slidesurface)) {
    self playsurfacesound(slideendsound, level.slidesurface);
  }
}

function function_a60e7c732b5440e2(var_a2e02bc146e6ebfd) {
  playsoundatpos(var_a2e02bc146e6ebfd, "zipline_rope_lower");
}

function set_slowmo_dialogue_start() {
  soundsettimescalefactor("voice_air_3d", 0);
  soundsettimescalefactor("voice_special_2d", 0);
  soundsettimescalefactor("voice_narration_2d", 0);
  soundsettimescalefactor("voice_plr_2d", 0);
  soundsettimescalefactor("voice_radio_2d", 0);
  soundsettimescalefactor("voice_plr_efforts_2d", 0);
  soundsettimescalefactor("voice_plr_breath_2d", 0);
  soundsettimescalefactor("voice_animal_1_3d", 0);
  soundsettimescalefactor("voice_bchatter_1_3d", 0);
}

function stop_deaths_door_audio() {
  if(isDefined(level.deathsdoor_sfx)) {
    wait 2;

    if(isDefined(level.deathsdoor_sfx)) {
      level.deathsdoor_sfx stopsounds();
    }

    wait 0.05;

    if(isDefined(level.deathsdoor_sfx)) {
      level.deathsdoor_sfx delete();
    }
  }
}