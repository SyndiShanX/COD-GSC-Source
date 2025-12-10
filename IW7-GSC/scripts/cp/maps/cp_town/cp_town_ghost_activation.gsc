/****************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_ghost_activation.gsc
****************************************************************/

init_ghost_n_skull_4_quest() {
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostFour", 0, ::blank, ::shoot_skulls_in_map, ::complete_shoot_skulls_in_map, ::debug_shoot_skulls_in_map, 5, "Shoot skulls around the map");
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostFour", 1, ::blank, ::find_radiation_extractor_collect_radiation, ::complete_radiation_extractor_collect_radiation, ::debug_radiation_extractor_collect_radiation, 5, "Collect radiation");
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostFour", 2, ::blank, ::pollute_pool_and_kills, ::complete_pollute_pool_and_kills, ::debug_pollute_pool_and_kills, 5, "Pollute Pool and Kill");
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostFour", 3, ::blank, ::cipher_quest, ::complete_cipher_quest, ::debug_cipher_quest, 5, "Cipher Quest");
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostFour", 4, ::blank, ::weeping_angels_start, ::complete_weeping_angels_start, ::debug_weeping_angels_start, 5, "Weeping angles");
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostFour", 5, ::blank, ::shoot_the_machine, ::complete_shoot_the_machine, ::debug_shoot_the_machine, 5, "Shoot the arcade machine");
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostFour", 6, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation, 5, "Wait for player activation");
  init();
  init_cipher_clue_texture();
}

init_cipher_clue_texture() {
  var_00 = getent("cipher_word_hint", "script_noteworthy");
  level.cipher_hint = var_00;
  setomnvar("zm_ui_skull_top_ent", level.cipher_hint);
}

blank() {}

watch_for_skull_death() {
  level endon("shoot_skulls_in_map_done");
  self endon("end_this_thread_for_" + self.object_num);
  for(;;) {
    self.model waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!isplayer(var_01)) {
      continue;
    }

    level.skulls_killed++;
    playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_03);
    var_01 playlocalsound("part_pickup");
    if(self.model.health < 0) {
      self.model delete();
      self notify("end_this_thread_for_" + self.object_num);
    }
  }
}

shoot_skulls_in_map() {
  level waittill("prematch_done");
  foreach(var_01 in level.weeping_angels_note) {
    var_01 thread watch_for_damage_on_struct();
  }

  var_03 = 0;
  while(!scripts\engine\utility::istrue(var_03)) {
    if(isDefined(level.skulls_killed)) {
      if(level.skulls_killed >= 5) {
        var_03 = 1;
      }
    }

    wait(1);
  }

  level notify("shoot_skulls_in_map_done");
}

complete_shoot_skulls_in_map() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(1);
}

debug_shoot_skulls_in_map() {
  level.skulls_killed = 5;
}

find_radiation_extractor_collect_radiation() {
  level waittill("radiation_extraction_started");
  level.radiation_extractor.ticks_of_radiation = 0;
  level thread watch_radiation_extractor_ticks();
  foreach(var_01 in level.players) {
    var_01 thread watch_for_player_position();
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(level.radiation_extraction_interaction);
  level scripts\engine\utility::waittill_any_3("completed_extraction", "debug_radiation_extractor_collect_radiation");
  level notify("stop_tick_on_loop");
}

watch_radiation_extractor_ticks() {
  level endon("completed_extraction");
  level endon("debug_radiation_extractor_collect_radiation");
  for(;;) {
    if(level.radiation_extractor.ticks_of_radiation > 9) {
      level.radiation_extractor.ticks_of_radiation = 0;
      level.radiation_extractor thread move_model_after_tick(0);
    } else if(level.radiation_extractor.ticks_of_radiation == 9) {
      level.radiation_extractor.origin = level.radiation_extraction_interaction.origin;
      level.radiation_extractor.angles = level.radiation_extraction_interaction.angles;
      level.radiation_extractor setModel("cp_town_radiation_extractor");
      level.radiation_extractor thread play_tick_on_loop();
      wait(30);
      level notify("stop_tick_on_loop");
      level.radiation_extractor thread move_model_after_tick(0);
    }

    if(scripts\engine\utility::istrue(level.charge_machine)) {
      level.radiation_extractor.ticks_of_radiation++;
      level.radiation_extractor thread move_model_after_tick(1);
      wait(30);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

play_tick_on_loop() {
  level endon("stop_tick_on_loop");
  for(;;) {
    scripts\engine\utility::play_sound_in_space("town_radiation_extractor_tick_up", self.origin + (0, 0, 5));
    wait(0.6);
    scripts\engine\utility::play_sound_in_space("town_radiation_extractor_tick_up_final", self.origin + (0, 0, 5));
    wait(2.7);
  }
}

watch_for_player_position() {
  self endon("disconnect");
  level endon("completed_extraction");
  level endon("debug_radiation_extractor_collect_radiation");
  self notify("one_thread_instance_for_player" + self.name);
  self endon("one_thread_instance_for_player" + self.name);
  for(;;) {
    if(!isDefined(level.radiation_extraction_interaction)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(distance2dsquared(level.radiation_extraction_interaction.origin, self.origin) <= 1000000 && !scripts\engine\utility::istrue(self.in_afterlife_arcade)) {
      level.charge_machine = 1;
    } else {
      level.charge_machine = 0;
    }

    wait(1);
  }
}

complete_radiation_extractor_collect_radiation() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

debug_radiation_extractor_collect_radiation() {}

wait_for_trap_kills(param_00, param_01) {
  for(;;) {
    level waittill(param_00, var_02);
    if(var_02 == param_01) {
      return;
    }
  }
}

pollute_pool_and_kills() {
  level waittill("placed_extractor_in_pool");
  wait_for_trap_kills("pool_trap_kills", 16);
  if(isDefined(level.pool_extraction_fx)) {
    level.pool_extraction_fx delete();
  }

  level.rad_extractor_owner = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(level.radiation_extraction_interaction);
  level.completed_pool_part_skulltop_quest = 1;
}

complete_pollute_pool_and_kills() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(3);
}

debug_pollute_pool_and_kills() {}

calculate_cipher_from_current_interaction(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    param_01 = "0";
    level.cipher_choices[0].model setscriptablepartstate("cipher_glyph", "neutral");
  } else {
    level.cipher_choices[0].model setscriptablepartstate("cipher_glyph", param_01);
  }

  if(!isDefined(param_02)) {
    param_02 = "0";
    level.cipher_choices[1].model setscriptablepartstate("cipher_glyph", "neutral");
  } else {
    level.cipher_choices[1].model setscriptablepartstate("cipher_glyph", param_02);
  }

  if(!isDefined(param_03)) {
    param_03 = "0";
    level.cipher_choices[2].model setscriptablepartstate("cipher_glyph", "neutral");
  } else {
    level.cipher_choices[2].model setscriptablepartstate("cipher_glyph", param_03);
  }

  if(!isDefined(param_04)) {
    param_04 = "0";
    level.cipher_choices[3].model setscriptablepartstate("cipher_glyph", "neutral");
  } else {
    level.cipher_choices[3].model setscriptablepartstate("cipher_glyph", param_04);
  }

  var_05 = 1;
  var_06 = 2;
  var_07 = 3;
  var_08 = 4;
  var_09 = 3;
  var_0A = 6;
  var_0B = 9;
  var_0C = 0;
  var_0D = 0;
  var_0E = 0;
  var_0F = level.alphabets[param_01];
  if(param_02 == "0") {
    var_0C = 0;
  } else if(param_02 == level.cipherlettera) {
    var_0C = var_05 * var_09 + level.alphabets[param_02];
  } else if(param_02 == level.cipherletterb) {
    var_0C = var_06 * var_09 + level.alphabets[param_02];
  } else if(param_02 == level.cipherletterc) {
    var_0C = var_07 * var_09 + level.alphabets[param_02];
  } else if(param_02 == level.cipherletterd) {
    var_0C = var_08 * var_09 + level.alphabets[param_02];
  }

  if(param_03 == "0") {
    var_0D = 0;
  } else if(param_03 == level.cipherlettera) {
    var_0D = var_05 * var_0A + level.alphabets[param_03];
  } else if(param_03 == level.cipherletterb) {
    var_0D = var_06 * var_0A + level.alphabets[param_03];
  } else if(param_03 == level.cipherletterc) {
    var_0D = var_07 * var_0A + level.alphabets[param_03];
  } else if(param_03 == level.cipherletterd) {
    var_0D = var_08 * var_0A + level.alphabets[param_03];
  }

  if(param_04 == "0") {
    var_0E = 0;
  } else if(param_04 == level.cipherlettera) {
    var_0E = var_05 * var_0B + level.alphabets[param_04];
  } else if(param_04 == level.cipherletterb) {
    var_0E = var_06 * var_0B + level.alphabets[param_04];
  } else if(param_04 == level.cipherletterc) {
    var_0E = var_07 * var_0B + level.alphabets[param_04];
  } else if(param_04 == level.cipherletterd) {
    var_0E = var_08 * var_0B + level.alphabets[param_04];
  }

  var_10 = 0;
  if(!isDefined(var_0F)) {
    var_10 = var_0C + var_0D + var_0E;
  } else {
    var_10 = var_0F + var_0C + var_0D + var_0E;
  }

  var_11 = 0;
  var_12 = var_10;
  if(var_12 >= 26) {
    var_12 = var_12 - 26 * int(floor(var_12 / 26));
  } else {
    var_12 = var_10;
  }

  if(var_12 < 1) {
    var_12 = 26;
  } else {
    var_12 = var_12 - 26 * int(floor(var_12 / 26));
  }

  var_11 = var_12;
  var_13 = "";
  foreach(var_16, var_15 in level.alphabets) {
    if(var_11 == var_15) {
      var_13 = var_16;
      break;
    }
  }

  return var_13;
}

calculate_cipher_from_letters_initially(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.alphabets)) {
    level.alphabets = [];
    level.alphabets["a"] = level.alphabets.size + 1;
    level.alphabets["b"] = level.alphabets.size + 1;
    level.alphabets["c"] = level.alphabets.size + 1;
    level.alphabets["d"] = level.alphabets.size + 1;
    level.alphabets["e"] = level.alphabets.size + 1;
    level.alphabets["f"] = level.alphabets.size + 1;
    level.alphabets["g"] = level.alphabets.size + 1;
    level.alphabets["h"] = level.alphabets.size + 1;
    level.alphabets["i"] = level.alphabets.size + 1;
    level.alphabets["j"] = level.alphabets.size + 1;
    level.alphabets["k"] = level.alphabets.size + 1;
    level.alphabets["l"] = level.alphabets.size + 1;
    level.alphabets["m"] = level.alphabets.size + 1;
    level.alphabets["n"] = level.alphabets.size + 1;
    level.alphabets["o"] = level.alphabets.size + 1;
    level.alphabets["p"] = level.alphabets.size + 1;
    level.alphabets["q"] = level.alphabets.size + 1;
    level.alphabets["r"] = level.alphabets.size + 1;
    level.alphabets["s"] = level.alphabets.size + 1;
    level.alphabets["t"] = level.alphabets.size + 1;
    level.alphabets["u"] = level.alphabets.size + 1;
    level.alphabets["v"] = level.alphabets.size + 1;
    level.alphabets["w"] = level.alphabets.size + 1;
    level.alphabets["x"] = level.alphabets.size + 1;
    level.alphabets["y"] = level.alphabets.size + 1;
    level.alphabets["z"] = level.alphabets.size + 1;
  }

  var_04 = [param_00 + "_" + param_03 + "_" + param_01 + "_" + param_02 + "", param_00 + "_" + param_03 + "_" + param_02 + "_" + param_01 + "", param_00 + "_" + param_01 + "_" + param_03 + "_" + param_02 + "", param_00 + "_" + param_01 + "_" + param_02 + "_" + param_03 + "", param_00 + "_" + param_02 + "_" + param_03 + "_" + param_01 + "", param_00 + "_" + param_02 + "_" + param_01 + "_" + param_03 + "", param_03 + "_" + param_00 + "_" + param_02 + "_" + param_01 + "", param_03 + "_" + param_00 + "_" + param_01 + "_" + param_02 + "", param_03 + "_" + param_01 + "_" + param_02 + "_" + param_00 + "", param_03 + "_" + param_01 + "_" + param_00 + "_" + param_02 + "", param_03 + "_" + param_02 + "_" + param_01 + "_" + param_00 + "", param_03 + "_" + param_02 + "_" + param_00 + "_" + param_01 + "", param_01 + "_" + param_00 + "_" + param_03 + "_" + param_02 + "", param_01 + "_" + param_00 + "_" + param_02 + "_" + param_03 + "", param_01 + "_" + param_03 + "_" + param_00 + "_" + param_02 + "", param_01 + "_" + param_03 + "_" + param_02 + "_" + param_00 + "", param_01 + "_" + param_02 + "_" + param_00 + "_" + param_03 + "", param_01 + "_" + param_02 + "_" + param_03 + "_" + param_00 + "", param_02 + "_" + param_00 + "_" + param_01 + "_" + param_03 + "", param_02 + "_" + param_00 + "_" + param_03 + "_" + param_01 + "", param_02 + "_" + param_03 + "_" + param_01 + "_" + param_00 + "", param_02 + "_" + param_03 + "_" + param_00 + "_" + param_01 + "", param_02 + "_" + param_01 + "_" + param_03 + "_" + param_00 + "", param_02 + "_" + param_01 + "_" + param_00 + "_" + param_03 + "", param_00 + "_" + param_03 + "_" + param_01 + "_" + 0 + "", param_00 + "_" + param_01 + "_" + param_03 + "_" + 0 + "", param_03 + "_" + param_00 + "_" + param_01 + "_" + 0 + "", param_03 + "_" + param_01 + "_" + param_00 + "_" + 0 + "", param_01 + "_" + param_00 + "_" + param_03 + "_" + 0 + "", param_01 + "_" + param_03 + "_" + param_00 + "_" + 0 + "", param_00 + "_" + param_03 + "_" + param_02 + "_" + 0 + "", param_00 + "_" + param_02 + "_" + param_03 + "_" + 0 + "", param_03 + "_" + param_00 + "_" + param_02 + "_" + 0 + "", param_03 + "_" + param_02 + "_" + param_00 + "_" + 0 + "", param_02 + "_" + param_00 + "_" + param_03 + "_" + 0 + "", param_02 + "_" + param_03 + "_" + param_00 + "_" + 0 + "", param_00 + "_" + param_01 + "_" + param_02 + "_" + 0 + "", param_00 + "_" + param_02 + "_" + param_01 + "_" + 0 + "", param_01 + "_" + param_00 + "_" + param_02 + "_" + 0 + "", param_01 + "_" + param_02 + "_" + param_00 + "_" + 0 + "", param_02 + "_" + param_00 + "_" + param_01 + "_" + 0 + "", param_02 + "_" + param_01 + "_" + param_00 + "_" + 0 + "", param_03 + "_" + param_01 + "_" + param_02 + "_" + 0 + "", param_03 + "_" + param_02 + "_" + param_01 + "_" + 0 + "", param_01 + "_" + param_03 + "_" + param_02 + "_" + 0 + "", param_01 + "_" + param_02 + "_" + param_03 + "_" + 0 + "", param_02 + "_" + param_03 + "_" + param_01 + "_" + 0 + "", param_02 + "_" + param_01 + "_" + param_03 + "_" + 0 + "", param_00 + "_" + param_01 + "_" + 0 + "_" + 0 + "", param_01 + "_" + param_00 + "_" + 0 + "_" + 0 + "", param_00 + "_" + param_02 + "_" + 0 + "_" + 0 + "", param_02 + "_" + param_00 + "_" + 0 + "_" + 0 + "", param_00 + "_" + param_03 + "_" + 0 + "_" + 0 + "", param_03 + "_" + param_00 + "_" + 0 + "_" + 0 + "", param_01 + "_" + param_02 + "_" + 0 + "_" + 0 + "", param_02 + "_" + param_01 + "_" + 0 + "_" + 0 + "", param_01 + "_" + param_03 + "_" + 0 + "_" + 0 + "", param_03 + "_" + param_01 + "_" + 0 + "_" + 0 + "", param_02 + "_" + param_03 + "_" + 0 + "_" + 0 + "", param_03 + "_" + param_02 + "_" + 0 + "_" + 0 + "", param_00 + "_" + param_00 + "_" + param_00 + "_" + 0 + "", param_01 + "_" + param_01 + "_" + param_01 + "_" + 0 + "", param_02 + "_" + param_02 + "_" + param_02 + "_" + 0 + "", param_03 + "_" + param_03 + "_" + param_03 + "_" + 0 + "", param_00 + "_" + param_00 + "_" + param_00 + "_" + 0 + "", param_01 + "_" + param_01 + "_" + param_01 + "_" + 0 + "", param_02 + "_" + param_02 + "_" + param_02 + "_" + 0 + "", param_03 + "_" + param_03 + "_" + param_03 + "_" + 0 + "", param_00 + "_" + param_00 + "_" + 0 + "_" + 0 + "", param_01 + "_" + param_01 + "_" + 0 + "_" + 0 + "", param_02 + "_" + param_02 + "_" + 0 + "_" + 0 + "", param_03 + "_" + param_03 + "_" + 0 + "_" + 0 + "", param_00 + "_" + 0 + "_" + 0 + "_" + 0 + "", param_01 + "_" + 0 + "_" + 0 + "_" + 0 + "", param_02 + "_" + 0 + "_" + 0 + "_" + 0 + "", param_03 + "_" + 0 + "_" + 0 + "_" + 0 + "", param_00 + "_" + param_00 + "_" + param_00 + "_" + param_00 + "", param_01 + "_" + param_01 + "_" + param_01 + "_" + param_01 + "", param_02 + "_" + param_02 + "_" + param_02 + "_" + param_02 + "", param_03 + "_" + param_03 + "_" + param_03 + "_" + param_03 + "", param_00 + "_" + param_00 + "_" + param_00 + "_" + 0 + "", param_01 + "_" + param_01 + "_" + param_01 + "_" + 0 + "", param_02 + "_" + param_02 + "_" + param_02 + "_" + 0 + "", param_03 + "_" + param_03 + "_" + param_03 + "_" + 0 + "", param_00 + "_" + param_00 + "_" + 0 + "_" + 0 + "", param_01 + "_" + param_01 + "_" + 0 + "_" + 0 + "", param_02 + "_" + param_02 + "_" + 0 + "_" + 0 + "", param_03 + "_" + param_03 + "_" + 0 + "_" + 0 + ""];
  var_05 = [];
  var_06 = [];
  var_07 = [];
  var_08 = [];
  foreach(var_0A in var_04) {
    var_0B = strtok(var_0A, "_");
    var_05[var_05.size] = var_0B[0];
    var_06[var_06.size] = var_0B[1];
    var_07[var_07.size] = var_0B[2];
    var_08[var_08.size] = var_0B[3];
  }

  var_0D = 1;
  var_0E = 2;
  var_0F = 3;
  var_10 = 4;
  var_11 = 3;
  var_12 = 6;
  var_13 = 9;
  var_14 = [];
  var_15 = [];
  var_16 = [];
  var_17 = [];
  foreach(var_0A in var_05) {
    foreach(var_1B, var_1A in level.alphabets) {
      if(var_0A == var_1B) {
        var_14[var_14.size] = level.alphabets[var_0A];
      }
    }
  }

  foreach(var_0A in var_06) {
    if(var_0A == "0") {
      var_15[var_15.size] = 0;
      continue;
    }

    foreach(var_1B, var_1A in level.alphabets) {
      if(var_0A == var_1B) {
        if(var_0A == param_00) {
          var_15[var_15.size] = var_0D * var_11 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_01) {
          var_15[var_15.size] = var_0E * var_11 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_02) {
          var_15[var_15.size] = var_0F * var_11 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_03) {
          var_15[var_15.size] = var_10 * var_11 + level.alphabets[var_1B];
        }
      }
    }
  }

  foreach(var_0A in var_07) {
    if(var_0A == "0") {
      var_16[var_16.size] = 0;
      continue;
    }

    foreach(var_1B, var_1A in level.alphabets) {
      if(var_0A == var_1B) {
        if(var_0A == param_00) {
          var_16[var_16.size] = var_0D * var_12 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_01) {
          var_16[var_16.size] = var_0E * var_12 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_02) {
          var_16[var_16.size] = var_0F * var_12 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_03) {
          var_16[var_16.size] = var_10 * var_12 + level.alphabets[var_1B];
        }
      }
    }
  }

  foreach(var_0A in var_08) {
    if(var_0A == "0") {
      var_17[var_17.size] = 0;
      continue;
    }

    foreach(var_1B, var_1A in level.alphabets) {
      if(var_0A == var_1B) {
        if(var_0A == param_00) {
          var_17[var_17.size] = var_0D * var_13 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_01) {
          var_17[var_17.size] = var_0E * var_13 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_02) {
          var_17[var_17.size] = var_0F * var_13 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == param_03) {
          var_17[var_17.size] = var_10 * var_13 + level.alphabets[var_1B];
        }
      }
    }
  }

  level.ciphertotalcolumn = [];
  for(var_26 = 0; var_26 < var_14.size; var_26++) {
    level.ciphertotalcolumn[var_26] = var_14[var_26] + var_15[var_26] + var_16[var_26] + var_17[var_26];
  }

  level.final_cipher_letter_numbers = [];
  foreach(var_2A, var_28 in level.ciphertotalcolumn) {
    var_29 = var_28;
    if(var_29 >= 26) {
      var_29 = var_29 - 26 * int(floor(var_29 / 26));
    } else {
      var_29 = var_28;
    }

    if(var_29 < 1) {
      var_29 = 26;
    } else {
      var_29 = var_29 - 26 * int(floor(var_29 / 26));
    }

    level.final_cipher_letter_numbers[var_2A] = var_29;
  }

  level.available_letters_for_cipher = [];
  foreach(var_2C in level.final_cipher_letter_numbers) {
    foreach(var_1B, var_2E in level.alphabets) {
      if(var_2C == var_2E) {
        level.available_letters_for_cipher[level.available_letters_for_cipher.size] = var_1B;
      }
    }
  }
}

cipher_quest() {
  foreach(var_01 in level.cipher_interactions_structs) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
    var_01.model show();
  }

  foreach(var_04 in level.cipher_model_structs) {
    var_04.model show();
  }

  level waittill("cipher_solved");
}

complete_cipher_quest() {
  level.completed_cipher = 1;
  foreach(var_01 in level.cipher_interactions_structs) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_01);
    var_01.model hide();
  }

  foreach(var_04 in level.cipher_model_structs) {
    var_04.model hide();
  }

  foreach(var_08, var_07 in level.cipher_choices) {
    level.cipher_choices[var_08].model setscriptablepartstate("cipher_glyph", "neutral");
  }

  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(4);
}

debug_cipher_quest() {}

slow_mo_sphere(param_00) {
  self.sacred_ground = spawn("trigger_radius", param_00.origin, 0, 400, 256);
  self.sacred_ground.fx = spawnfx(level._effect["slow_time_bubble"], param_00.origin);
  self.sacred_ground.var_FB2F = scripts\engine\utility::play_loopsound_in_space("town_mute_circle_lp", param_00.origin);
  thread scripts\engine\utility::play_sound_in_space("town_mute_circle_start", param_00.origin);
  self.zombie_list = [];
  playFX(scripts\engine\utility::getfx("hidden_figure_death"), param_00.origin);
  wait(1);
  triggerfx(self.sacred_ground.fx);
  self.sacred_ground thread apply_slow_mo_on_trigger();
  level waittill("end_painting_" + param_00.name);
  if(isDefined(self.sacred_ground.fx)) {
    self.sacred_ground.fx delete();
  }

  if(isDefined(self.sacred_ground.var_FB2F)) {
    self.sacred_ground.var_FB2F delete();
  }

  if(isDefined(self.sacred_ground)) {
    self.sacred_ground delete();
  }

  param_00.model setModel("cp_town_willard_painting");
  var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_03 in var_01) {
    var_03 scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoAttack");
    var_03.activated_slomo_sphere = 0;
    var_03.noturnanims = 0;
    var_03.isfrozen = undefined;
  }
}

custom_unslow_func(param_00) {
  param_00 endon("death");
  if(!isalive(param_00)) {
    return;
  }

  param_00.precacheleaderboards = 0;
  param_00.nocorpse = undefined;
  param_00.full_gib = undefined;
  param_00.noturnanims = undefined;
}

custom_slow_time_func(param_00) {
  param_00 endon("death");
  param_00.isfrozen = 1;
  param_00.precacheleaderboards = 1;
  param_00.nocorpse = 1;
  param_00.full_gib = 1;
  param_00.noturnanims = 1;
  param_00 waittill("unslow_zombie");
  param_00.isfrozen = undefined;
}

apply_slow_mo_on_trigger() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    foreach(var_01 in level.players) {
      if(var_01 istouching(self)) {
        if(!scripts\engine\utility::istrue(var_01.inside_slow_sphere)) {
          var_01 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_01);
        }

        var_01.inside_slow_sphere = 1;
        continue;
      }

      if(scripts\engine\utility::istrue(var_01.inside_slow_sphere)) {
        var_01 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_01);
      }

      var_01.inside_slow_sphere = 0;
    }

    var_03 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    level.zombie_list = var_03;
    foreach(var_05 in level.zombie_list) {
      if(!isDefined(var_05)) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(!var_05 scripts\cp\utility::is_zombie_agent()) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(var_05 scripts\cp\utility::agentisfnfimmune()) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(!scripts\engine\utility::istrue(var_05.entered_playspace)) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(var_05 istouching(self)) {
        var_05 scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoAttack");
        var_05.activated_slomo_sphere = 1;
        var_05.noturnanims = 1;
        var_05.isfrozen = 1;
        continue;
      }

      var_05 scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoAttack");
      var_05.activated_slomo_sphere = 0;
      var_05.noturnanims = 0;
      var_05.isfrozen = undefined;
      var_05 notify("unslow_zombie");
    }

    scripts\engine\utility::waitframe();
  }
}

weeping_angels_start() {
  foreach(var_01 in level.weeping_angels_note) {
    var_01.model show();
  }

  level waittill("weeping_angels_note_read");
  foreach(var_04 in level.players) {
    var_04.weeping_angels_puzzle = 1;
  }

  level.frozenzombiefunc = ::custom_slow_time_func;
  level.thawzombiefunc = ::custom_unslow_func;
  var_06 = 0;
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  level scripts\engine\utility::waittill_multiple("painting_01_done", "painting_02_done", "painting_03_done", "painting_04_done");
}

wait_for_painting_kills_complete(param_00, param_01, param_02) {
  for(;;) {
    level waittill(param_00, var_03);
    if(var_03 == param_01) {
      param_02 = 1;
      return param_02;
    }
  }
}

complete_weeping_angels_start() {
  level.frozenzombiefunc = ::scripts\cp\zombies\zombie_scriptable_states::freeze_zombie;
  level.thawzombiefunc = ::scripts\cp\zombies\zombie_scriptable_states::unfreeze_zombie;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(5);
}

debug_weeping_angels_start() {}

shoot_the_machine() {
  level.skulltop_machine = getent("skullhop_machine", "targetname");
  level.skulltop_machine setCanDamage(1);
  level.skulltop_machine.health = 5;
  level.skulltop_machine.maxhealth = 5;
  level.skulltop_machine thread watch_for_damage_on_machine();
  level waittill("machine_hit_successfully");
  level thread play_gns_success_vo();
}

play_gns_success_vo() {
  level endon("game_ended");
  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("access_ghostnskulls", "town_comment_vo");
  }
}

watch_for_damage_on_machine() {
  self endon("end_func_on" + self.model);
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!var_01 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_04) && var_04 == "MOD_MELEE") {
      self.maxhealth = 5;
      self.health = 5;
      continue;
    }

    if(!issubstr(var_09, "cutie")) {
      self.maxhealth = 5;
      self.health = 5;
      continue;
    }

    if(scripts\engine\utility::istrue(var_01.fired_fov_beam)) {
      var_0A = getomnvar("zm_num_ghost_n_skull_coin");
      if(isDefined(var_0A) && var_0A >= 5) {
        level notify("machine_hit_successfully");
      } else {
        continue;
      }

      self notify("end_func_on" + self.model);
    }
  }
}

complete_shoot_the_machine() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(6);
}

debug_shoot_the_machine() {}

wait_for_player_activation() {
  level endon("player_debug_activate_cabinet");
  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], (5459, -4767, 29));
  triggerfx(level.gns_game_console_vfx);
  var_00 = (5444, -4760, -14);
  var_01 = 10000;
  for(;;) {
    var_02 = 1;
    foreach(var_04 in level.players) {
      if(scripts\engine\utility::istrue(var_04.inlaststand)) {
        var_02 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_04.iscarrying)) {
        var_02 = 0;
        break;
      }

      if(distancesquared(var_04.origin, var_00) > var_01) {
        var_02 = 0;
        break;
      }

      if(!var_04 usebuttonpressed()) {
        var_02 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_02) {
      var_02 = 1;
      foreach(var_04 in level.players) {
        if(scripts\engine\utility::istrue(var_04.inlaststand)) {
          var_02 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_04.iscarrying)) {
          var_02 = 0;
          break;
        }

        if(distancesquared(var_04.origin, var_00) > var_01) {
          var_02 = 0;
          break;
        }

        if(!var_04 usebuttonpressed()) {
          var_02 = 0;
          break;
        }
      }
    }

    if(var_02) {
      if(isDefined(level.gns_game_console_vfx)) {
        level.gns_game_console_vfx delete();
      }

      return;
    }

    scripts\engine\utility::waitframe();
  }
}

complete_clean_arcade_cabinet() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(-1, 0.5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::start_ghost_wave();
}

debug_wait_for_player_activation() {}

wait_one_wave() {
  level waittill("regular_wave_starting");
}

cp_town_gns_4_setup() {
  level.skulls_killed = 0;
  level.gns_num_of_wave = 3;
  level.init_formation_movement_func = ::gns3_formation_movement;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
  level.death_trigger_reset_y_pos = 424;
  level.death_trigger_activate_y_pos = 1353;
  level.original_death_grid_lines_front_y_pos = 3020;
  level.zombie_ghost_model = "zombie_ghost_cube_white";
  level.set_moving_target_color_func = ::cp_town_set_moving_target_color;
  level.should_moving_target_explode = ::cp_town_should_moving_target_explode;
  level.hit_wrong_moving_target_func = ::cp_town_hit_wrong_moving_target_func;
  level.moving_target_pre_fly_time = 0.5;
  level.gns_hotjoin_wait_notify = "finish_intro_gesture";
  level.gns_reward_func = ::town_gns_player_reward_func;
  level.get_fake_ghost_model_func = ::town_get_fake_ghost_model_func;
  level.max_num_of_death_trigger_advance = 9;
  level.gns_end_func = ::town_gns_end_func;
  level.gns_start_func = ::town_gns_start_func;
  level.enter_ghosts_n_skulls_func = ::cp_town_enter_ghosts_n_skulls_func;
  level.end_ghosts_n_skulls_func = ::cp_town_end_ghosts_n_skulls_func;
  level.disable_gns_death_trigger = 1;
  level.post_moving_target_rotate_func = ::color_indicator_manager;
  level.complete_one_gns_wave_func = ::kill_color_indicator_manager;
  level.pre_gns_end_func = ::deactivate_color_indicator;
  level.ghost_n_skull_reactivate_func = ::reactivate_skullbuster_cabinet;
  level.moving_target_attack_interval = 9000;
  level.grab_same_ghost_string = &"CP_TOWN_GNS_TRACK_SAME_CUBE";
  level.all_perk_list = ["perk_machine_boom", "perk_machine_flash", "perk_machine_fwoosh", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_revive", "perk_machine_run", "perk_machine_deadeye", "perk_machine_tough", "perk_machine_change", "perk_machine_zap", "perk_machine_smack"];
  level.placed_crafted_traps = [];
  level.pool_placement_volume = getent("pool_extraction_volume", "targetname");
  level.radiation_collection_volume = getent("radiation_extraction_volume", "targetname");
  init_skulls_to_shoot();
  register_ghost_form();
  register_waves_movement();
  load_cp_town_ghost_exp_vfx();
  set_up_platform_and_trigger();
  level thread init_weeping_angels_note();
  if(!isDefined(level.hidden_figures)) {
    level.hidden_figures = [];
  }

  level.hidden_figures[0] = spawnStruct();
  level.hidden_figures[0].origin = (4058, -4359, 76);
  level.hidden_figures[0].powered_on = 0;
  level.hidden_figures[0].requires_power = 0;
  level.hidden_figures[0].name = "hidden_figure_objects";
  level.hidden_figures[0].script_noteworthy = "figure_1";
  level.hidden_figures[0].script_parameters = "default";
  level.hidden_figures[0].var_336 = "interaction";
  var_00 = scripts\engine\utility::getstructarray("figure_1", "script_noteworthy");
  level.hidden_figures[1] = spawnStruct();
  level.hidden_figures[1].origin = (4058, -4359, 76);
  level.hidden_figures[1].powered_on = 0;
  level.hidden_figures[1].requires_power = 0;
  level.hidden_figures[1].name = "hidden_figure_objects";
  level.hidden_figures[1].script_noteworthy = "figure_2";
  level.hidden_figures[1].script_parameters = "default";
  level.hidden_figures[1].var_336 = "interaction";
  var_00 = scripts\engine\utility::getstructarray("figure_2", "script_noteworthy");
  level.hidden_figures[2] = spawnStruct();
  level.hidden_figures[2].origin = (4058, -4359, 76);
  level.hidden_figures[2].powered_on = 0;
  level.hidden_figures[2].requires_power = 0;
  level.hidden_figures[2].name = "hidden_figure_objects";
  level.hidden_figures[2].script_noteworthy = "figure_3";
  level.hidden_figures[2].script_parameters = "default";
  level.hidden_figures[2].var_336 = "interaction";
  var_00 = scripts\engine\utility::getstructarray("figure_3", "script_noteworthy");
  level.hidden_figures[3] = spawnStruct();
  level.hidden_figures[3].origin = (4058, -4359, 76);
  level.hidden_figures[3].powered_on = 0;
  level.hidden_figures[3].requires_power = 0;
  level.hidden_figures[3].name = "hidden_figure_objects";
  level.hidden_figures[3].script_noteworthy = "figure_4";
  level.hidden_figures[3].script_parameters = "default";
  level.hidden_figures[3].var_336 = "interaction";
  var_00 = scripts\engine\utility::getstructarray("figure_4", "script_noteworthy");
  foreach(var_02 in level.hidden_figures) {
    var_02.groupname = "locOverride";
    var_02.playeroffset = [];
    setup_hidden_figure_models(var_02, var_02.script_noteworthy);
  }

  init_ghost_n_skull_4_quest();
}

cp_town_enter_ghosts_n_skulls_func(param_00) {
  param_00 thread restore_color_in_gns(param_00);
  param_00 thread entangled_cube_color_manager(param_00);
}

restore_color_in_gns(param_00) {
  param_00 endon("disconnect");
  var_01 = 0;
  foreach(var_03 in level.players) {
    if(scripts\engine\utility::istrue(var_03.activate_gns_machine)) {
      var_01 = 1;
      break;
    }
  }

  if(var_01) {
    param_00 visionsetnakedforplayer("cp_town_color", 1);
    wait(2);
  }

  param_00 visionsetnakedforplayer("cp_zmb_ghost_path", 1);
}

cp_town_end_ghosts_n_skulls_func(param_00) {
  param_00 notify("stop_entangled_cube_color_manager");
  param_00 visionsetnakedforplayer(level.current_vision_set, 0);
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::hide_charge_progress(param_00);
}

entangled_cube_color_manager(param_00) {
  param_00 endon("disconnect");
  param_00 endon("stop_entangled_cube_color_manager");
  for(;;) {
    if(isDefined(param_00.ghost_in_entanglement)) {
      var_01 = param_00.ghost_in_entanglement;
      var_02 = get_platform_trigger_color(param_00);
      if(isDefined(var_01.color) && var_02 != var_01.color) {
        change_cube_color(var_01, var_02);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

set_up_platform_and_trigger() {
  var_00 = ["blue", "green", "yellow", "red"];
  foreach(var_02 in var_00) {
    var_03 = getent(var_02 + "_platform", "targetname");
    var_04 = getent(var_02 + "_platform_trigger", "targetname");
    var_03.var_C725 = var_03.origin;
    var_04.var_C725 = var_04.origin;
    var_04 enablelinkto();
    var_04 linkto(var_03);
  }
}

get_platform_trigger_color(param_00) {
  var_01 = ["blue", "green", "yellow", "red"];
  foreach(var_03 in var_01) {
    var_04 = getent(var_03 + "_platform_trigger", "targetname");
    if(param_00 istouching(var_04)) {
      return var_03;
    }
  }

  return "white";
}

color_indicator_manager() {
  level endon("kill_color_indicator_manager");
  var_00 = 15;
  var_01 = 0.5;
  var_02 = "none";
  var_03 = ["green", "red", "blue", "yellow"];
  for(;;) {
    var_04 = scripts\engine\utility::array_remove(var_03, var_02);
    var_02 = scripts\engine\utility::random(var_04);
    update_color_indicator_color(var_02);
    wait(var_00 - var_01 * 5);
    turn_off_color_indicator();
    wait(var_01);
    turn_on_color_indicator();
    wait(var_01);
    turn_off_color_indicator();
    wait(var_01);
    turn_on_color_indicator();
    wait(var_01);
    turn_off_color_indicator();
    wait(var_01);
  }
}

turn_off_color_indicator() {
  foreach(var_01 in level.skull_hop_color_indicators) {
    var_01 setscriptablepartstate("skull_hop_indicator", "off");
  }
}

turn_on_color_indicator() {
  foreach(var_01 in level.skull_hop_color_indicators) {
    var_01 setscriptablepartstate("skull_hop_indicator", level.color_indicator_color);
  }
}

kill_color_indicator_manager() {
  level notify("kill_color_indicator_manager");
  update_color_indicator_color("off");
}

init_cipher_interactions() {
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "cipher_interaction", undefined, undefined, ::radiation_collection_hint_func, ::cipher_activation_func, 0, 0, ::init_cipher_interaction_structs, undefined);
  thread init_cipher_choices();
  thread init_cipher_letters();
}

init_cipher_choices() {
  var_00 = scripts\engine\utility::getstructarray("cipher_choice_model", "script_noteworthy");
  level.cipher_choices = [];
  foreach(var_02 in var_00) {
    var_03 = undefined;
    switch (var_02.name) {
      case "cipher_choice_1":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        break;

      case "cipher_choice_2":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        break;

      case "cipher_choice_3":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        break;

      case "cipher_choice_4":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        break;

      default:
        break;
    }

    var_03 setscriptablepartstate("cipher_glyph", "neutral");
    if(isDefined(var_03)) {
      var_02.model = var_03;
    }

    var_04 = strtok(var_02.name, "_");
    var_02.index = int(var_04[2]);
    level.cipher_choices[var_02.index - 1] = var_02;
  }
}

init_cipher_letters() {
  level.words_for_cipher = [];
  level.words_for_cipher[0] = ["chlorination", "bromination", "solvolysis", "azides", "alkenes", "hydrogenation", "oxidation", "reduction", "ethers", "ethyl", "aldehydes", "benzene", "nitriles", "allomer", "neutrino", "sublimation", "zwitterion"];
  level.chosen_cipher_word = scripts\engine\utility::random(level.words_for_cipher[0]);
  roll_correct_letter_combination(level.chosen_cipher_word);
  level thread set_omnvar_based_on_word(level.chosen_cipher_word);
  var_00 = scripts\engine\utility::getstructarray("cipher_letter_model", "script_noteworthy");
  level.cipher_model_structs = [];
  foreach(var_02 in var_00) {
    switch (var_02.name) {
      case "cipher_letter_13":
      case "cipher_letter_12":
      case "cipher_letter_11":
      case "cipher_letter_10":
      case "cipher_letter_9":
      case "cipher_letter_8":
      case "cipher_letter_7":
      case "cipher_letter_6":
      case "cipher_letter_5":
      case "cipher_letter_4":
      case "cipher_letter_3":
      case "cipher_letter_2":
      case "cipher_letter_1":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        var_03 setCanDamage(1);
        var_03.maxhealth = 99999;
        var_03.health = 99999;
        var_02.model = var_03;
        var_02.current_letter = "";
        var_02.completed_cipher_letter = 0;
        var_04 = strtok(var_02.name, "_");
        var_05 = var_04[2];
        var_02.model setscriptablepartstate("cipher_glyph", "neutral");
        var_02.model hide();
        var_02 thread watch_for_damage_on_cipher_letter(var_05);
        level.cipher_model_structs[int(var_05) - 1] = [];
        level.cipher_model_structs[int(var_05) - 1] = var_02;
        break;
    }

    if(!isDefined(level.cipher_pointer)) {
      level.cipher_pointer = 0;
    }
  }

  level thread watch_for_correct_combination_of_letters_entered();
}

set_omnvar_based_on_word(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "chlorination":
      var_01 = 1;
      break;

    case "bromination":
      var_01 = 2;
      break;

    case "solvolysis":
      var_01 = 3;
      break;

    case "azides":
      var_01 = 4;
      break;

    case "alkenes":
      var_01 = 5;
      break;

    case "hydrogenation":
      var_01 = 6;
      break;

    case "oxidation":
      var_01 = 7;
      break;

    case "reduction":
      var_01 = 8;
      break;

    case "ethers":
      var_01 = 9;
      break;

    case "ethyl":
      var_01 = 10;
      break;

    case "aldehydes":
      var_01 = 11;
      break;

    case "benzene":
      var_01 = 12;
      break;

    case "nitriles":
      var_01 = 13;
      break;

    case "bro":
      var_01 = 14;
      break;

    case "allomer":
      var_01 = 15;
      break;

    case "neutrino":
      var_01 = 16;
      break;

    case "sublimation":
      var_01 = 17;
      break;

    case "zwitterion":
      var_01 = 18;
      break;
  }

  setomnvar("skulltop_cipher_hint", var_01);
}

watch_for_correct_combination_of_letters_entered() {
  level endon("cipher_solved");
  for(;;) {
    if(!isDefined(level.chosen_cipher_word)) {
      continue;
    }

    var_00 = "";
    for(var_01 = 0; var_01 < level.cipher_pointer; var_01++) {
      var_00 = var_00 + level.cipher_model_structs[var_01].current_letter;
      if(level.chosen_cipher_word == var_00) {
        level notify("cipher_solved");
      }
    }

    wait(1);
  }
}

roll_correct_letter_combination(param_00) {
  var_01 = getrandomletter();
  var_02 = getrandomletter();
  var_03 = getrandomletter();
  var_04 = getrandomletter();
  for(;;) {
    if(does_cipher_have_all_letters(var_01, var_02, var_03, var_04, param_00)) {
      level.cipherlettera = var_01;
      level.cipherletterb = var_02;
      level.cipherletterc = var_03;
      level.cipherletterd = var_04;
      return;
    } else {
      var_01 = getrandomletter();
      var_02 = getrandomletter();
      var_03 = getrandomletter();
      var_04 = getrandomletter();
    }

    scripts\engine\utility::waitframe();
  }
}

does_cipher_have_all_letters(param_00, param_01, param_02, param_03, param_04) {
  calculate_cipher_from_letters_initially(param_00, param_01, param_02, param_03);
  var_05 = scripts\engine\utility::array_remove_duplicates(level.available_letters_for_cipher);
  var_06 = [];
  var_06 = get_chars_of_word_as_array(param_04);
  var_07 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  foreach(var_09 in var_06) {
    if(!scripts\engine\utility::array_contains(var_05, var_09)) {
      return 0;
    }
  }

  return 1;
}

get_chars_of_word_as_array(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_01[var_02] = param_00[var_02];
  }

  return var_01;
}

cipher_activation_func(param_00, param_01) {
  param_01 endon("disconnect");
  if(scripts\engine\utility::istrue(level.completed_cipher)) {
    return;
  }

  if(!isDefined(level.letter_roll)) {
    level.letter_roll = [];
  }

  if(!isDefined(level.letter_roll["a"])) {
    level.letter_roll["a"] = "0";
  }

  if(!isDefined(level.letter_roll["b"])) {
    level.letter_roll["b"] = "0";
  }

  if(!isDefined(level.letter_roll["c"])) {
    level.letter_roll["c"] = "0";
  }

  if(!isDefined(level.letter_roll["d"])) {
    level.letter_roll["d"] = "0";
  }

  if(!isDefined(level.letter_inputs)) {
    level.letter_inputs = [];
  }

  switch (param_00.name) {
    case "cipher_interaction_01":
      level.letter_roll["a"] = param_00.letter;
      break;

    case "cipher_interaction_02":
      level.letter_roll["b"] = param_00.letter;
      break;

    case "cipher_interaction_03":
      level.letter_roll["c"] = param_00.letter;
      break;

    case "cipher_interaction_04":
      level.letter_roll["d"] = param_00.letter;
      break;

    default:
      break;
  }

  if(!isDefined(level.cipherlettera) || !isDefined(level.cipherletterb) || !isDefined(level.cipherletterc) || !isDefined(level.cipherletterd)) {
    wait(0.8);
    return;
  }

  level.letter_inputs[level.letter_inputs.size] = param_00.letter;
  var_02 = calculate_cipher_from_current_interaction(param_01, level.letter_inputs[0], level.letter_inputs[1], level.letter_inputs[2], level.letter_inputs[3]);
  spawn_fx_on_theatre_screen(param_01, var_02);
  if(level.letter_inputs.size >= 4) {
    level thread clear_up_input_display_after_time(20);
    level.letter_inputs = [];
  }
}

clear_up_input_display_after_time(param_00) {
  level endon("end_clear_input_func");
  level thread watch_for_inputs_reentered();
  wait(param_00);
  foreach(var_03, var_02 in level.cipher_choices) {
    level.cipher_choices[var_03].model setscriptablepartstate("cipher_glyph", "neutral");
  }
}

watch_for_inputs_reentered() {
  level endon("end_clear_input_func");
  level notify("one_instance_of_func");
  level endon("one_instance_of_func");
  for(;;) {
    if(level.letter_inputs.size > 0) {
      level notify("end_clear_input_func");
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

delay_enable_linked_interaction(param_00, param_01, param_02) {
  param_02 endon("disconnect");
  level waittill("spawn_wave_done");
  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(param_00, param_02);
}

spawn_fx_on_theatre_screen(param_00, param_01) {
  var_02 = (5076, -2547, 473);
  var_03 = (0, 300, 0);
  level.cipher_model_structs[level.cipher_pointer].model setscriptablepartstate("cipher_glyph", param_01);
  level.cipher_model_structs[level.cipher_pointer].current_letter = param_01;
}

getrandomletter() {
  var_00 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  return scripts\engine\utility::random(var_00);
}

init_painting_interactions() {
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "painting_interaction", undefined, undefined, ::radiation_collection_hint_func, ::paintings_activation_function, 0, 0, ::init_paintings_interaction, undefined);
}

paintings_activation_function(param_00, param_01) {
  level.frozenzombiefunc = ::custom_slow_time_func;
  level.thawzombiefunc = ::custom_unslow_func;
  if(!scripts\engine\utility::istrue(param_01.weeping_angels_puzzle)) {
    return;
  }

  if(isDefined(param_00.painting_owner)) {
    if(param_00.painting_owner == param_01) {
      return;
    } else {
      return;
    }
  }

  if(scripts\engine\utility::istrue(level.painting_active)) {
    return;
  }

  level.painting_active = 1;
  param_00.painting_owner = param_01;
  param_01.hidden_figures_hit = 0;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  level thread watch_for_player_disconnect_after_painting_trigger(param_00, param_01);
  level thread look_at_painting(param_00, param_01);
  level thread slow_mo_sphere(param_00);
  wait(40);
  level notify("end_painting_" + param_00.name);
  param_01.triggered_rad_extractor_device = 0;
  level.painting_active = 0;
  param_00.painting_owner = undefined;
  param_01.inside_slow_sphere = 0;
  level.frozenzombiefunc = ::scripts\cp\zombies\zombie_scriptable_states::freeze_zombie;
  level.thawzombiefunc = ::scripts\cp\zombies\zombie_scriptable_states::unfreeze_zombie;
  if(param_01.hidden_figures_hit >= 7) {
    level notify(param_00.name + "_done");
    level thread scripts\engine\utility::play_sound_in_space("part_pickup", param_00.origin);
    if(isDefined(param_01.array_of_weeping_angels)) {
      foreach(var_03 in param_01.array_of_weeping_angels) {
        var_03 delete();
      }
    }

    param_01.hidden_figures_hit = 0;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    return;
  }

  param_01.hidden_figures_hit = 0;
  if(isDefined(param_01.array_of_weeping_angels)) {
    foreach(var_03 in param_01.array_of_weeping_angels) {
      var_03 delete();
    }
  }

  param_01 playlocalsound("perk_machine_deny");
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

watch_for_player_disconnect_after_painting_trigger(param_00, param_01) {
  level endon("game_ended");
  level endon("end_disconnect_thread_for_" + param_00.name);
  for(;;) {
    param_01 waittill("disconnect");
    if(isDefined(param_01.array_of_weeping_angels)) {
      foreach(var_03 in param_01.array_of_weeping_angels) {
        var_03 delete();
      }
    }

    param_00.model setModel("cp_town_willard_painting");
    level.painting_active = 0;
    param_00.painting_owner = undefined;
    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    level notify("end_disconnect_thread_for_" + param_00.name);
  }
}

look_at_painting(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("end_painting_" + param_00.name);
  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(param_00.origin, param_01.origin) > 5184) {
      scripts\engine\utility::waitframe();
      param_00.model setModel("cp_town_willard_painting");
      continue;
    }

    if(scripts\engine\utility::within_fov(param_01.origin, param_01.angles, param_00.origin, cos(70))) {
      param_00.model setModel("cp_town_willard_painting");
      scripts\engine\utility::waitframe();
      continue;
    } else if(randomint(100) > 98) {
      param_00.model setModel("cp_town_willard_painting_skull");
      param_01 dodamage(param_01.health / 15, param_01.origin);
    }

    scripts\engine\utility::waitframe();
  }
}

init_skullbusters_interactions() {
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "radiation_collector_interaction", undefined, undefined, ::radiation_collection_hint_func, ::collector_activation_func, 0, 0, ::init_collector_func, undefined);
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "radiation_extraction_interaction", undefined, undefined, ::radiation_collection_hint_func, ::extraction_activation_func, 0, 0, ::init_extraction_point_func, undefined);
  scripts\cp\maps\cp_town\cp_town_chemistry::init_setup_radio_prefabs();
  scripts\cp\maps\cp_town\cp_town_chemistry::init_chem_reaction_interactions();
  init_painting_interactions();
  init_cipher_interactions();
}

collector_activation_func(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("game_ended");
  if(scripts\engine\utility::istrue(level.picked_up_radiation_collector)) {
    param_01 playlocalsound("perk_machine_deny");
    return;
  }

  if(!isDefined(level.skulls_killed)) {
    param_01 playlocalsound("perk_machine_deny");
    return;
  }

  if(isDefined(level.skulls_killed) && level.skulls_killed < 5) {
    param_01 playlocalsound("perk_machine_deny");
    return;
  }

  level.picked_up_radiation_collector = 1;
  playFX(scripts\engine\utility::getfx("hidden_figure_death"), param_00.origin);
  param_01 playlocalsound("part_pickup");
  param_00.model hide();
  level notify("radiation_collector_found");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
}

last_stand_watcher(param_00) {
  for(;;) {
    scripts\engine\utility::waittill_any_3("last_stand", "death", "disconnect");
    if(!scripts\engine\utility::istrue(level.picked_up_radiation_collector)) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
      level.picked_up_radiation_collector = undefined;
      param_00.model show();
    }
  }
}

pickup_extractor_after_collecting_radiation(param_00) {
  playFX(scripts\engine\utility::getfx("hidden_figure_death"), level.radiation_extraction_interaction.origin);
  param_00 playlocalsound("part_pickup");
  level.rad_extractor_owner = param_00;
  give_crafted_rad_extractor(level.radiation_extraction_interaction, param_00);
  param_00 thread last_stand_watcher_extractor_craft(level.radiation_extraction_interaction);
  level notify("completed_extraction");
}

last_stand_watcher_extractor_craft(param_00) {
  for(;;) {
    scripts\engine\utility::waittill_any_3("last_stand", "death", "disconnect");
    level.rad_extractor_owner = undefined;
  }
}

extraction_activation_func(param_00, param_01) {
  if(!scripts\engine\utility::istrue(level.picked_up_radiation_collector)) {
    return;
  }

  if(isDefined(level.radiation_extractor) && isDefined(level.radiation_extractor.ticks_of_radiation)) {
    if(level.radiation_extractor.ticks_of_radiation == 9) {
      if(!isDefined(level.rad_extractor_owner)) {
        thread pickup_extractor_after_collecting_radiation(param_01);
        return;
      }

      return;
    } else if(level.radiation_extractor.ticks_of_radiation < 9 || level.radiation_extractor.ticks_of_radiation > 9) {
      return;
    }
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.radiation_collector[0]);
  level.radiation_extraction_interaction = param_00;
  var_02 = spawn("script_model", param_00.origin);
  var_02 setModel("cp_town_radiation_extractor_top");
  var_02.angles = param_00.angles;
  level.radiation_extractor = var_02;
  param_01 thread last_stand_watcher_extractor_craft(param_00);
  param_01 playlocalsound("part_pickup");
  level notify("radiation_extraction_started");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.radiation_extraction_interaction);
}

move_model_after_tick(param_00) {
  if(param_00 == 0) {
    var_01 = level.radiation_extraction_interaction.origin;
    self.angles = level.radiation_extraction_interaction.angles;
    self setModel("cp_town_radiation_extractor_top");
    self moveto(var_01, 1);
  } else {
    var_01 = self.origin + (0, 0, var_01 * 0.666);
    self moveto(var_01, 0.5);
  }

  scripts\engine\utility::play_sound_in_space("town_radiation_extractor_tick_up", self.origin + (0, 0, 5));
}

init_cipher_interaction_structs() {
  var_00 = scripts\engine\utility::getstructarray("cipher_interaction", "script_noteworthy");
  if(isDefined(level.cipher_interactions_structs)) {
    return;
  }

  foreach(var_04, var_02 in var_00) {
    var_03 = undefined;
    switch (var_02.name) {
      case "cipher_interaction_01":
        var_03 = spawn("script_model", var_02.origin + (0, 0, 10));
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        var_03 setscriptablepartstate("cipher_glyph", level.cipherlettera);
        var_02.letter = level.cipherlettera;
        break;

      case "cipher_interaction_02":
        var_03 = spawn("script_model", var_02.origin + (0, 0, 10));
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        var_03 setscriptablepartstate("cipher_glyph", level.cipherletterb);
        var_02.letter = level.cipherletterb;
        break;

      case "cipher_interaction_03":
        var_03 = spawn("script_model", var_02.origin + (0, 0, 10));
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        var_03 setscriptablepartstate("cipher_glyph", level.cipherletterc);
        var_02.letter = level.cipherletterc;
        break;

      case "cipher_interaction_04":
        var_03 = spawn("script_model", var_02.origin + (0, 0, 10));
        var_03 setModel("tag_origin_cipher_letter");
        var_03.angles = var_02.angles + (0, 90, 0);
        var_03 setscriptablepartstate("cipher_glyph", level.cipherletterd);
        var_02.letter = level.cipherletterd;
        break;

      default:
        break;
    }

    if(isDefined(var_03)) {
      var_02.model = var_03;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
    var_02.model hide();
    level.cipher_interactions_structs[var_04] = var_02;
    level.cipher_failures = 0;
  }
}

watch_for_damage_on_cipher_letter(param_00) {
  self endon("death");
  level endon("game_ended");
  self endon("end_this_thread_for_" + self.name);
  for(;;) {
    self.model waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!var_02 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_05) && var_05 == "MOD_MELEE") {
      self.model.maxhealth = 99999;
      self.model.health = 99999;
      continue;
    }

    if(scripts\engine\utility::istrue(self.completed_cipher_letter)) {
      self.model.maxhealth = 99999;
      self.model.health = 99999;
      continue;
    }

    if(int(param_00) - 1 >= level.chosen_cipher_word.size) {
      self.model.maxhealth = 99999;
      self.model.health = 99999;
      continue;
    }

    if(self.current_letter == level.chosen_cipher_word[int(param_00) - 1]) {
      playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_04);
      level thread scripts\engine\utility::play_sound_in_space("part_pickup", var_04);
      self.completed_cipher_letter = 1;
      level.cipher_pointer++;
      continue;
    }

    level.cipher_failures++;
    level thread scripts\engine\utility::play_sound_in_space("purchase_deny", var_04);
    if(level.cipher_failures >= 6) {
      foreach(var_0C in level.cipher_interactions_structs) {
        foreach(var_0E in level.players) {
          scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0C, var_0E);
          level thread delay_enable_linked_interaction(var_0C, 30, var_0E);
          level.cipher_failures = 0;
        }
      }
    }
  }
}

init_paintings_interaction() {
  var_00 = scripts\engine\utility::getstructarray("painting_interaction", "script_noteworthy");
  if(isDefined(level.paintings_struct)) {
    return;
  }

  foreach(var_04, var_02 in var_00) {
    var_03 = getent(var_02.target, "targetname");
    var_02.model = var_03;
    level.paintings_struct[var_04] = var_02;
  }
}

init_collector_func() {
  var_00 = scripts\engine\utility::getstructarray("radiation_collector_interaction", "script_noteworthy");
  foreach(var_04, var_02 in var_00) {
    var_03 = undefined;
    switch (var_02.name) {
      case "radiation_collector":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("cp_town_radiation_extractor");
        var_03.angles = var_02.angles;
        break;

      default:
        break;
    }

    if(isDefined(var_03)) {
      var_02.model = var_03;
    }

    level.radiation_collector[var_04] = var_02;
  }
}

init_extraction_point_func() {
  var_00 = scripts\engine\utility::getstructarray("radiation_extraction_interaction", "script_noteworthy");
  foreach(var_04, var_02 in var_00) {
    var_03 = undefined;
    switch (var_02.name) {
      case "radiation_extraction_point":
        var_03 = spawn("script_model", var_02.origin);
        var_03 setModel("cp_town_radiation_extractor_base");
        var_03.angles = var_02.angles;
        break;

      default:
        break;
    }

    if(isDefined(var_03)) {
      var_02.model = var_03;
    }

    level.radiation_collector[var_04] = var_02;
  }
}

radiation_collection_hint_func(param_00, param_01) {
  return "";
}

init_skulls_to_shoot() {
  var_00 = scripts\engine\utility::getstructarray("gns_skull", "script_noteworthy");
  var_01 = ["skull1", "skull2", "skull3", "skull4", "skull5", "skull6", "skull7", "skull8", "skull9", "skull10"];
  var_02 = 0;
  foreach(var_08, var_04 in var_00) {
    if(var_02 >= 5) {
      break;
    }

    var_05 = scripts\engine\utility::random(var_01);
    var_01 = scripts\engine\utility::array_remove(var_01, var_05);
    var_06 = scripts\engine\utility::getstruct(var_05, "targetname");
    var_02++;
    var_07 = undefined;
    switch (var_05) {
      case "skull1":
        var_07 = spawn("script_model", var_06.origin);
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = var_06.angles;
        var_06.object_num = 1;
        break;

      case "skull2":
        var_07 = spawn("script_model", var_06.origin);
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = var_06.angles;
        var_06.object_num = 2;
        break;

      case "skull3":
        var_07 = spawn("script_model", (7147, 2187, 328));
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = (0, 168.9, 0);
        var_06.object_num = 3;
        break;

      case "skull4":
        var_07 = spawn("script_model", var_06.origin);
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = var_06.angles;
        var_06.object_num = 4;
        break;

      case "skull5":
        var_07 = spawn("script_model", var_06.origin);
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = var_06.angles;
        var_06.object_num = 5;
        break;

      case "skull6":
        var_07 = spawn("script_model", var_06.origin);
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = var_06.angles;
        var_06.object_num = 6;
        break;

      case "skull7":
        var_07 = spawn("script_model", var_06.origin);
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = var_04.angles;
        var_06.object_num = 7;
        break;

      case "skull8":
        var_07 = spawn("script_model", var_06.origin);
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = var_06.angles;
        var_06.object_num = 8;
        break;

      case "skull9":
        var_07 = spawn("script_model", (6785, -2650.5, 105));
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = (0, 243.3, 0);
        var_06.object_num = 9;
        break;

      case "skull10":
        var_07 = spawn("script_model", var_06.origin);
        var_07 setModel("zmb_8_bit_price_town");
        var_07.angles = var_06.angles;
        var_06.object_num = 10;
        break;

      default:
        break;
    }

    var_07 setCanDamage(1);
    var_07.maxhealth = 5;
    var_07.health = 5;
    var_07.damage_done = 0;
    if(isDefined(var_07)) {
      var_06.model = var_07;
    }

    level.skullbusters_map_skulls[var_08] = var_06;
    level.skullbusters_map_skulls[var_08] thread watch_for_skull_death();
  }
}

load_gns_3_vfx() {
  level._effect["combo_arc_green"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_green.vfx");
  level._effect["combo_arc_red"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_red.vfx");
  level._effect["combo_arc_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_blue.vfx");
  level._effect["combo_arc_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_yellow.vfx");
}

cp_town_set_moving_target_color(param_00, param_01) {}

determine_color(param_00) {
  var_01 = scripts\engine\utility::array_randomize(param_00);
  level.moving_target_color_based_on_priority = [];
  level.moving_target_color_based_on_priority["low"] = var_01[0];
  level.moving_target_color_based_on_priority["medium"] = var_01[1];
  level.moving_target_color_based_on_priority["high"] = var_01[2];
}

cp_town_should_moving_target_explode(param_00, param_01) {
  if(!isDefined(level.color_indicator_color)) {
    return 0;
  }

  if(level.color_indicator_color == "off") {
    return 0;
  }

  return param_00.color == level.color_indicator_color;
}

cp_town_hit_wrong_moving_target_func(param_00, param_01, param_02) {
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(param_01);
}

delay_determine_game_fail() {
  level endon("game_ended");
  var_00 = 2;
  wait(var_00);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::determine_game_fail();
}

town_gns_player_reward_func() {
  level.unlimited_fnf = 1;
  foreach(var_01 in level.players) {
    if(!scripts\engine\utility::istrue(level.entered_thru_card)) {
      var_01 scripts\cp\zombies\achievement::update_achievement("QUARTER_MUNCHER", 1);
    }

    var_01 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_01);
  }

  level notify("end_this_thread_of_gns_fnf_card");
}

upgrade_magic_wheel() {
  level.magic_wheel_upgraded_pap1 = 1;
  if(isDefined(level.current_active_wheel)) {
    level.current_active_wheel setscriptablepartstate("fx", "upgrade");
  }
}

gns3_formation_movement() {
  level.formation_movements = [];
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(1, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_1_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(2, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_2_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(3, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_3_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(4, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_4_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(5, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_5_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(6, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_6_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(7, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_7_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(8, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_8_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(9, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_9_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(10, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_10_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(11, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_11_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(12, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_12_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(13, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_13_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(14, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_14_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(15, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_15_move_pattern);
}

register_ghost_form() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 1);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 2);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 3);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 4);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1, 5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 6);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 7);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 8);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 9);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 10);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 11);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 12);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 13);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 14);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 15);
}

register_waves_movement() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(1, 1, 2, 0.7);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(2, 1, 2, 0.7);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(3, 2, 4, 0.7);
  level.available_formations = undefined;
  level.formation_movements = undefined;
}

load_cp_town_ghost_exp_vfx() {
  level._effect["ghost_explosion_death_red"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_red.vfx");
  level._effect["ghost_explosion_death_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_yellow.vfx");
  level._effect["ghost_explosion_death_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_blue.vfx");
  level._effect["ghost_explosion_death_white"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_white.vfx");
  level._effect["sb_quest_item_pickup"] = loadfx("vfx\iw7\core\zombie\vfx_zom_souvenir_pickup.vfx");
}

activate_gns_platforms() {
  var_00 = scripts\engine\utility::array_randomize(["up_down", "up_down", "forward_backward", "forward_backward"]);
  var_01 = scripts\engine\utility::array_randomize(["green", "yellow", "blue", "red"]);
  foreach(var_04, var_03 in var_01) {
    level thread activate_platform_color(var_03, var_00[var_04]);
  }
}

town_gns_start_func() {
  record_vision_set();
  activate_gns_platforms();
  activate_death_floor();
  activate_color_indicator();
}

town_gns_end_func() {
  restore_vision_set();
  deactivate_platforms();
  deactivate_death_floor();
}

record_vision_set() {
  level.pre_gns_vision_set_override = level.vision_set_override;
  level.vision_set_override = "cp_zmb_ghost_path";
}

restore_vision_set() {
  level.vision_set_override = level.pre_gns_vision_set_override;
}

activate_death_floor() {
  var_00 = getent("skull_hop_death_floor", "targetname");
  var_00 thread death_floor_player_monitor(var_00);
}

deactivate_death_floor() {
  var_00 = getent("skull_hop_death_floor", "targetname");
  var_00 notify("stop_death_floor");
}

activate_color_indicator() {
  var_00 = [(-8222, 2421, -2090), (-6356, 2402, -2090)];
  level.skull_hop_color_indicators = [];
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02);
    var_03 setModel("crab_boss_origin");
    level.skull_hop_color_indicators[level.skull_hop_color_indicators.size] = var_03;
  }
}

deactivate_color_indicator() {
  kill_color_indicator_manager();
  foreach(var_01 in level.skull_hop_color_indicators) {
    var_01 delete();
  }
}

update_color_indicator_color(param_00) {
  level.color_indicator_color = param_00;
  foreach(var_02 in level.skull_hop_color_indicators) {
    var_02 setscriptablepartstate("skull_hop_indicator", param_00);
  }
}

death_floor_player_monitor(param_00) {
  param_00 endon("stop_death_floor");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isplayer(var_01)) {
      scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::teleport_into_arcade_console(var_01);
      var_02 = scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::get_active_moving_target_based_on_priority();
      if(isDefined(var_02)) {
        level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_02);
      }
    }
  }
}

deactivate_platforms() {
  level notify("stop_GnS_platforms");
  var_00 = ["blue", "red", "green", "yellow"];
  foreach(var_02 in var_00) {
    var_03 = getent(var_02 + "_platform", "targetname");
    var_04 = getent(var_02 + "_platform_trigger", "targetname");
    var_03.origin = var_03.var_C725;
    var_04.origin = var_04.var_C725;
  }
}

activate_platform_color(param_00, param_01) {
  level endon("game_ended");
  level endon("stop_GnS_platforms");
  var_02 = 48;
  var_03 = 32;
  var_04 = 64;
  var_05 = getent(param_00 + "_platform", "targetname");
  var_06 = getent(param_00 + "_platform_trigger", "targetname");
  var_05.origin = var_05.var_C725;
  var_06.origin = var_06.var_C725;
  var_07 = var_04 * scripts\engine\utility::ter_op(randomintrange(0, 100) > 5, 1, -1);
  var_08 = randomfloatrange(var_03, var_02);
  var_09 = var_04 / var_08;
  if(param_01 == "up_down") {
    var_05 moveto(var_05.origin + (0, 0, var_07), var_09);
    var_05 waittill("movedone");
    for(;;) {
      var_05 moveto(var_05.origin + (0, 0, var_07 * -2), var_09);
      var_05 waittill("movedone");
      var_05 moveto(var_05.origin + (0, 0, var_07 * 2), var_09);
      var_05 waittill("movedone");
    }

    return;
  }

  var_05 moveto(var_05.origin + (0, var_07, 0), var_09);
  var_05 waittill("movedone");
  for(;;) {
    var_05 moveto(var_05.origin + (0, var_07 * -2, 0), var_09);
    var_05 waittill("movedone");
    var_05 moveto(var_05.origin + (0, var_07 * 2, 0), var_09);
    var_05 waittill("movedone");
  }
}

change_cube_color(param_00, param_01) {
  param_00.color = param_01;
  param_00 setscriptablepartstate("cube", param_01);
}

town_get_fake_ghost_model_func(param_00) {
  return "fake_zombie_ghost_cube_" + param_00;
}

reveal_moving_target_color(param_00) {
  param_00 setModel("zmb_pixel_skull");
  param_00.revealed = 1;
  param_00 setscriptablepartstate("skull_vfx", param_00.color);
}

set_allow_skulls_to_explode(param_00) {
  level.allow_skulls_to_explode = param_00;
}

get_moving_targets_in_same_subgroup(param_00) {
  var_01 = [];
  foreach(var_03 in level.moving_target_groups) {
    foreach(var_05 in var_03) {
      if(isDefined(var_05) && var_05.subgroup == param_00) {
        var_01[var_01.size] = var_05;
      }
    }
  }

  return var_01;
}

all_moving_targets_are_revealed(param_00) {
  foreach(var_02 in param_00) {
    if(var_02.revealed == 0) {
      return 0;
    }
  }

  return 1;
}

explode_moving_targets(param_00, param_01) {
  var_02 = 1;
  var_03 = get_vfx_start_moving_target(param_00);
  foreach(var_05 in param_00) {
    if(var_05 == var_03) {
      var_05 thread delay_moving_target_explode(var_05, param_01, var_02);
      continue;
    }

    var_05 thread delay_moving_target_explode(var_05, param_01, var_02, var_03);
  }
}

get_vfx_start_moving_target(param_00) {
  foreach(var_02 in param_00) {
    if(scripts\engine\utility::istrue(var_02.vfx_start)) {
      return var_02;
    }
  }
}

delay_moving_target_explode(param_00, param_01, param_02, param_03) {
  play_combo_arc_vfx(param_00, param_02, param_03);
  playFX(level._effect["ghost_explosion_death_" + param_00.color], param_00.origin, anglesToForward(param_00.angles), anglestoup(param_00.angles));
  scripts\aitypes\zombie_ghost\behaviors::remove_moving_target_default(param_00, param_01);
}

play_combo_arc_vfx(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    var_03 = int(param_01 * 20);
    for(var_04 = 0; var_04 < var_03; var_04++) {
      var_05 = param_02.origin;
      var_06 = param_00.origin;
      var_07 = var_06 - var_05;
      var_08 = vectortoangles(var_07);
      playfxbetweenpoints(level._effect["combo_arc_" + param_00.color], var_05, var_08, var_06);
      scripts\engine\utility::waitframe();
    }

    return;
  }

  wait(param_01);
}

adjust_player_exit_gns_pos() {
  level endon("game_ended");
  wait(5);
  var_00 = scripts\engine\utility::getstructarray("ghost_wave_player_end", "targetname");
  foreach(var_02 in var_00) {
    if(var_02.origin == (-743, 2620, 906)) {
      var_02.origin = (-745, 2620, 906);
      var_02.angles = (0, 345, 0);
      continue;
    }

    if(var_02.origin == (-743, 2572, 906)) {
      var_02.origin = (-771, 2598, 906);
      var_02.angles = (0, 15, 0);
      continue;
    }

    if(var_02.origin == (-743, 2596, 906)) {
      var_02.origin = (-784, 2621, 906);
      var_02.angles = (0, 355, 0);
    }
  }
}

adjust_mahjong_pick_up_pos() {
  level endon("game_ended");
  wait(5);
  var_00 = scripts\engine\utility::getstructarray("sb_mahjong_tile", "targetname");
  foreach(var_02 in var_00) {
    if(var_02.origin == (1393, 816, 801)) {
      var_02.origin = (1040, 568, 790.6);
      var_02.angles = (7, 135, -1);
    }
  }
}

reactivate_skullbuster_cabinet() {
  if(!scripts\cp\zombies\zombie_quest::quest_line_exist("reactivateghost")) {
    var_00 = getomnvar("zm_num_ghost_n_skull_coin");
    if(isDefined(var_00) && var_00 < 5) {
      return;
    }

    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 0, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet, ::shoot_the_machine, ::complete_shoot_the_machine, ::debug_shoot_the_machine);
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 1, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("reactivateghost");
}

init_weeping_angels_note() {
  var_00 = scripts\engine\utility::getstructarray("weeping_angels_struct", "script_noteworthy");
  level.weeping_angels_note = [];
  foreach(var_04, var_02 in var_00) {
    var_03 = spawn("script_model", var_02.origin + (0, 0, 0.05));
    var_03.angles = var_02.angles;
    var_03 setModel("cp_town_paper_note_02");
    var_03 setCanDamage(1);
    var_03.maxhealth = 5;
    var_03.health = 5;
    if(isDefined(var_03)) {
      var_02.model = var_03;
    }

    var_02.model hide();
    level.weeping_angels_note[var_04] = var_02;
  }
}

watch_for_damage_on_struct() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self.model waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!isplayer(var_01)) {
      continue;
    }

    if(!var_01 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!scripts\engine\utility::istrue(level.completed_cipher)) {
      continue;
    }

    if(isDefined(var_04) && var_04 != "MOD_MELEE") {
      continue;
    }

    playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_03);
    var_01 playlocalsound("part_pickup");
    self.model delete();
    level notify("weeping_angels_note_read");
  }
}

init() {
  var_00 = spawnStruct();
  var_00.timeout = 40;
  var_00.lifespan = 40;
  var_00.pow = &"COOP_CRAFTABLES_PICKUP";
  var_00.placestring = &"COOP_CRAFTABLES_PLACE";
  var_00.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_00.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_00.var_74BF = &"ZOMBIE_CRAFTING_SOUVENIRS_DETONATE";
  var_00.var_9F43 = 0;
  var_00.placementheighttolerance = 30;
  var_00.placementradius = 16;
  var_00.carriedtrapoffset = (0, 0, 35);
  var_00.carriedtrapangles = (0, -90, 0);
  var_00.modelbase = "cp_town_radiation_extractor";
  var_00.modelplacement = "cp_town_radiation_extractor";
  var_00.modelplacementfailed = "cp_town_radiation_extractor";
  level.rad_extractor_settings = [];
  level.rad_extractor_settings["crafted_rad_extractor"] = var_00;
}

give_crafted_medusa(param_00, param_01) {
  param_01.itemtype = "crafted_rad_extractor";
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_rad_extractor");
  param_01 setclientomnvar("zom_crafted_weapon", 3);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_rad_extractor", ::give_crafted_medusa, param_01);
}

watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_medusa", "+actionslot 3");
  for(;;) {
    self waittill("pullout_medusa");
    if(scripts\engine\utility::istrue(self.iscarrying)) {
      continue;
    }

    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }

  thread shootturret(1, 40);
}

shootturret(param_00, param_01) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_02 = func_49E8(self);
  scripts\cp\utility::remove_player_perks();
  self.carriedsentry = var_02;
  var_03 = setcarryingims(var_02, param_00, param_01);
  self.carriedsentry = undefined;
  thread scripts\cp\utility::wait_restore_player_perk();
  self.iscarrying = 0;
  if(isDefined(var_02)) {
    return 1;
  }

  return 0;
}

setcarryingims(param_00, param_01, param_02, param_03) {
  self endon("disconnect");
  param_00 func_B543(self, param_01);
  scripts\engine\utility::allow_weapon(0);
  self notifyonplayercommand("place_medusa", "+attack");
  self notifyonplayercommand("place_medusa", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_medusa", "+actionslot 3");
  if(!level.console) {
    self notifyonplayercommand("cancel_medusa", "+actionslot 5");
    self notifyonplayercommand("cancel_medusa", "+actionslot 6");
    self notifyonplayercommand("cancel_medusa", "+actionslot 7");
  }

  for(;;) {
    var_04 = scripts\engine\utility::waittill_any_return("place_medusa", "cancel_medusa", "force_cancel_placement");
    if(!isDefined(param_00)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_04)) {
      var_04 = "force_cancel_placement";
    }

    if(var_04 == "cancel_medusa" || var_04 == "force_cancel_placement") {
      if(!param_01 && var_04 == "cancel_medusa") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
      param_00 func_B542();
      if(var_04 != "force_cancel_placement") {
        thread watch_dpad();
      } else if(param_01) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!param_00.canbeplaced) {
      continue;
    }

    if(param_01) {
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    param_00 func_B545(param_02, undefined, self);
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_49E8(param_00) {
  var_01 = spawnturret("misc_turret", param_00.origin + (0, 0, 25), "sentry_minigun_mp");
  var_01.angles = param_00.angles;
  var_01.triggerportableradarping = param_00;
  var_01.name = "crafted_rad_extractor";
  var_01 hide();
  var_01.carriedmedusa = spawn("script_model", var_01.origin + (0, 0, 25));
  var_01.carriedmedusa setModel(level.rad_extractor_settings["crafted_rad_extractor"].modelbase);
  var_01 getvalidattachments();
  var_01 setturretmodechangewait(1);
  var_01 give_player_session_tokens("sentry_offline");
  var_01 makeunusable();
  var_01 setsentryowner(param_00);
  var_01 func_B53F(param_00);
  return var_01;
}

func_B53F(param_00) {
  self.canbeplaced = 1;
  func_B544();
}

func_B53C(param_00) {
  self waittill("death");
  level.rad_extractor_owner = undefined;
  if(!isDefined(self)) {
    return;
  }

  func_B544();
  self playSound("sentry_explode");
  if(isDefined(self.charge_fx)) {
    self.charge_fx delete();
  }

  scripts\cp\utility::removefromtraplist();
  if(isDefined(self)) {
    playFXOnTag(scripts\engine\utility::getfx("hidden_figure_death"), self, "tag_origin");
    self playSound("sentry_explode_smoke");
    wait(0.1);
    if(isDefined(self)) {
      self delete();
    }
  }
}

func_B53D() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("trigger", var_00);
    if(!var_00 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_00.iscarrying)) {
      continue;
    }

    var_00 thread shootturret(0, self.lifespan);
    self playSound("trap_medusa_pickup");
    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

func_B545(param_00, param_01, param_02) {
  var_03 = spawn("script_model", self.origin + (0, 0, 0));
  var_03.angles = self.angles;
  var_03.name = "crafted_rad_extractor";
  self.carriedmedusa delete();
  var_03 solid();
  if(!isDefined(param_02.var_B546)) {
    param_02.var_B546 = 1;
  }

  var_04 = "cp_town_radiation_extractor";
  var_03 setModel(var_04);
  var_03 setCanDamage(1);
  var_03.health = 5;
  var_03.maxhealth = 5;
  var_03.lifespan = 40;
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  param_02.iscarrying = 0;
  var_03.triggerportableradarping = param_02;
  if(ispointinvolume(var_03.origin, level.pool_placement_volume)) {
    level thread radiation_extractor_after_pool_part(var_03.origin);
    level.pool_extraction_fx = spawnfx(level._effect["pool_radiation"], var_03.origin + (0, 0, 3));
    triggerfx(level.pool_extraction_fx);
    level notify("placed_extractor_in_pool");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.radiation_extraction_interaction);
    level.medusa_after_placed = var_03;
    func_B544();
  } else {
    var_03 thread func_B541(param_00);
  }

  self notify("placed");
  self delete();
}

func_B542() {
  self.carriedby getrigindexfromarchetyperef();
  if(isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping.iscarrying = 0;
  }

  self.carriedmedusa delete();
  self delete();
}

func_B543(param_00, param_01) {
  self setModel(level.rad_extractor_settings["crafted_rad_extractor"].modelplacement);
  self setsentrycarrier(param_00);
  self setCanDamage(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  if(param_01) {
    self.firstplacement = 1;
  }

  param_00 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedmedusa, level.rad_extractor_settings["crafted_rad_extractor"]);
  thread scripts\cp\utility::item_oncarrierdeath(param_00);
  thread scripts\cp\utility::item_oncarrierdisconnect(param_00);
  thread scripts\cp\utility::item_ongameended(param_00);
  func_B544();
  self notify("carried");
}

func_B541(param_00, param_01) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.rad_extractor_settings["crafted_rad_extractor"].pow);
  self makeusable();
  self _meth_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread medusa_watch_for_player_melee(self.triggerportableradarping);
  thread func_B53C(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("medusa_handleOwner");
  thread scripts\cp\utility::item_timeout(param_00, level.rad_extractor_settings["crafted_rad_extractor"].timeout);
  thread func_B53D();
  scripts\cp\utility::addtotraplist();
}

medusa_watch_for_player_melee(param_00) {
  self.health = 5;
  self.maxhealth = 5;
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isplayer(var_02)) {
      continue;
    }

    if(var_02 != param_00) {
      continue;
    }

    if(!var_02 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_05) && var_05 != "MOD_MELEE") {
      self.health = 5;
      self.maxhealth = 5;
      var_02 playlocalsound("perk_machine_deny");
      continue;
    }

    if(!scripts\engine\utility::istrue(var_02.triggered_rad_extractor_device)) {
      var_02.triggered_rad_extractor_device = 1;
      self.health = 5;
      self.maxhealth = 5;
      var_02 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_02);
    }
  }
}

func_B544() {
  self makeunusable();
  scripts\cp\utility::removefromtraplist();
}

give_crafted_rad_extractor(param_00, param_01) {
  param_01 thread watch_dpad();
  param_01 notify("new_power", "crafted_rad_extractor");
  param_01 setclientomnvar("zom_crafted_weapon", 16);
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_rad_extractor", ::give_crafted_rad_extractor, param_01);
}

radiation_extractor_after_pool_part(param_00) {
  level.radiation_extraction_interaction.origin = param_00;
  level.radiation_extractor.origin = param_00;
  playFX(scripts\engine\utility::getfx("hidden_figure_death"), param_00);
  scripts\engine\utility::play_sound_in_space("part_pickup", param_00);
  scripts\cp\cp_interaction::add_to_current_interaction_list(level.radiation_extraction_interaction);
}

removememorystructonconnect(param_00) {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_01);
    var_01 thread removememorystructswhenvalid(param_00, var_01);
  }
}

removememorystructswhenvalid(param_00, param_01) {
  while(!isDefined(param_01.disabled_interactions)) {
    scripts\engine\utility::waitframe();
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_00, param_01);
  param_01 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(param_01);
}

setup_hidden_figure_models(param_00, param_01) {
  scripts\cp\maps\cp_town\cp_town::addtopersonalinteractionlist(param_00);
  switch (param_01) {
    case "figure_4":
    case "figure_3":
    case "figure_2":
    case "figure_1":
      param_00.shot_by_player = 0;
      param_00.player_who_shot_figure = undefined;
      break;
  }
}

mem_object_hint(param_00, param_01) {
  return "";
}

mem_object_func(param_00, param_01) {}

activatefiguredamage(param_00, param_01, param_02) {
  level notify(param_00.script_noteworthy + "_" + param_01.name);
  level endon(param_00.script_noteworthy + "_" + param_01.name);
  level endon("game_ended");
  param_01 endon("disconnect");
  param_01 endon("last_stand");
  level endon("end_hidden_figures_sequence_for_" + param_01.name);
  param_02 endon("p_ent_reset");
  if(!isDefined(param_02)) {
    return;
  }

  param_02.health = 5;
  param_02.maxhealth = 5;
  param_02 setCanDamage(1);
  param_02 endon("end_thread_for_" + param_02.model);
  for(;;) {
    param_02 waittill("damage", var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C);
    if(!isplayer(var_04)) {
      continue;
    }

    if(var_04 != param_01) {
      continue;
    }

    if(!var_04 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(param_02.got_hit_by_player)) {
      continue;
    }

    if(param_02.health < 0) {
      param_02.health = 5;
      param_02.maxhealth = 5;
      param_02 setscriptablepartstate("figure_effect", "death");
      level thread scripts\engine\utility::play_sound_in_space("town_kill_black_ghost_success", var_06);
      param_02.got_hit_by_player = 1;
      if(isDefined(var_04.hidden_figures_hit)) {
        var_04.hidden_figures_hit++;
        if(var_04.hidden_figures_hit >= 4) {
          var_04 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_04);
        }
      }

      param_02 hidefromplayer(var_04);
      param_02 notify("end_thread_for_" + param_02.model);
    }
  }
}

showhiddenfigurestoplayer(param_00, param_01, param_02, param_03) {
  param_03 notify("one_instance_of_" + param_01.script_noteworthy + "_for_" + param_03.name);
  param_03 endon("one_instance_of_" + param_01.script_noteworthy + "_for_" + param_03.name);
  param_03 endon("death");
  param_03 endon("disconnect");
  level endon("game_ended");
  level endon("end_hidden_figures_sequence_for_" + param_03.name);
  if(!isDefined(param_03.vo_prefix)) {
    return;
  }

  if(!isDefined(param_01.script_noteworthy)) {
    return;
  }

  if(!scripts\engine\utility::istrue(param_03.triggered_rad_extractor_device)) {
    return;
  }

  var_04 = 0.5;
  var_05 = 10000;
  if(scripts\engine\utility::istrue(param_03.inside_slow_sphere)) {
    var_04 = 1.5;
    var_05 = -25536;
  }

  var_06 = [];
  var_07 = gettime();
  param_00.got_hit_by_player = 0;
  thread activatefiguredamage(param_01, param_03, param_00);
  param_00 showtoplayer(param_03);
  while(gettime() <= var_07 + var_05) {
    var_08 = randomintrange(-200, 200);
    var_09 = randomintrange(-200, 200);
    var_0A = randomintrange(90, 200);
    param_03.figure_one_offset = (var_08, var_09, var_0A);
    var_0B = randomintrange(-200, 200);
    var_0C = randomintrange(-200, 200);
    var_0D = randomintrange(90, 200);
    param_03.figure_two_offset = (var_0B, var_0C, var_0D);
    var_0E = randomintrange(-200, 200);
    var_0F = randomintrange(-200, 200);
    var_10 = randomintrange(90, 200);
    param_03.figure_three_offset = (var_0E, var_0F, var_10);
    var_11 = randomintrange(-200, 200);
    var_12 = randomintrange(-200, 200);
    var_13 = randomintrange(90, 200);
    param_03.figure_four_offset = (var_11, var_12, var_13);
    switch (param_01.script_noteworthy) {
      case "figure_1":
        param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_one_offset;
        param_00 setModel("tag_origin_hidden_figure");
        param_00 setscriptablepartstate("figure_effect", "active");
        param_00.origin = param_03.origin + param_03.figure_one_offset;
        break;

      case "figure_2":
        param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_two_offset;
        param_00 setModel("tag_origin_hidden_figure");
        param_00 setscriptablepartstate("figure_effect", "active");
        param_00.origin = param_03.origin + param_03.figure_two_offset;
        break;

      case "figure_3":
        param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_three_offset;
        param_00 setModel("tag_origin_hidden_figure");
        param_00 setscriptablepartstate("figure_effect", "active");
        param_00.origin = param_03.origin + param_03.figure_three_offset;
        break;

      case "figure_4":
        param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_four_offset;
        param_00 setModel("tag_origin_hidden_figure");
        param_00 setscriptablepartstate("figure_effect", "active");
        param_00.origin = param_03.origin + param_03.figure_four_offset;
        break;
    }

    if(int(distance(param_00.origin, param_03.origin)) <= 120) {
      param_03 dodamage(int(param_03.health / 4), param_03.origin);
    }

    param_00.angles = vectortoangles(param_03.origin - param_00.origin);
    param_01.model = param_00;
    wait(var_04);
  }

  param_00 setscriptablepartstate("figure_effect", "neutral");
  scripts\engine\utility::waitframe();
  param_00 setscriptablepartstate("figure_effect", "death");
  param_03.triggered_rad_extractor_device = 0;
  level notify("end_hidden_figures_sequence_for_" + param_03.name);
}

init_fig1() {
  level.special_mode_activation_funcs["figure_1"] = ::showhiddenfigurestoplayer;
  level.normal_mode_activation_funcs["figure_1"] = ::showhiddenfigurestoplayer;
  level.hidden_figures[0] = spawnStruct();
  level.hidden_figures[0].origin = (4058, -4359, 76);
  level.hidden_figures[0].powered_on = 0;
  level.hidden_figures[0].requires_power = 0;
  level.hidden_figures[0].name = "hidden_figure_objects";
  level.hidden_figures[0].script_noteworthy = "figure_1";
  level.hidden_figures[0].script_parameters = "default";
  level.hidden_figures[0].var_336 = "interaction";
  var_00 = scripts\engine\utility::getstructarray("figure_1", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.groupname = "locOverride";
    var_02.playeroffset = [];
    setup_hidden_figure_models(var_02, "figure_1");
  }
}

init_fig2() {
  level.special_mode_activation_funcs["figure_2"] = ::showhiddenfigurestoplayer;
  level.normal_mode_activation_funcs["figure_2"] = ::showhiddenfigurestoplayer;
  level.hidden_figures[1] = spawnStruct();
  level.hidden_figures[1].origin = (4058, -4359, 76);
  level.hidden_figures[1].powered_on = 0;
  level.hidden_figures[1].requires_power = 0;
  level.hidden_figures[1].name = "hidden_figure_objects";
  level.hidden_figures[1].script_noteworthy = "figure_2";
  level.hidden_figures[1].script_parameters = "default";
  level.hidden_figures[1].var_336 = "interaction";
  var_00 = scripts\engine\utility::getstructarray("figure_2", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.groupname = "locOverride";
    var_02.playeroffset = [];
    setup_hidden_figure_models(var_02, "figure_2");
  }
}

init_fig3() {
  level.special_mode_activation_funcs["figure_3"] = ::showhiddenfigurestoplayer;
  level.normal_mode_activation_funcs["figure_3"] = ::showhiddenfigurestoplayer;
  level.hidden_figures[2] = spawnStruct();
  level.hidden_figures[2].origin = (4058, -4359, 76);
  level.hidden_figures[2].powered_on = 0;
  level.hidden_figures[2].requires_power = 0;
  level.hidden_figures[2].name = "hidden_figure_objects";
  level.hidden_figures[2].script_noteworthy = "figure_3";
  level.hidden_figures[2].script_parameters = "default";
  level.hidden_figures[2].var_336 = "interaction";
  var_00 = scripts\engine\utility::getstructarray("figure_3", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.groupname = "locOverride";
    var_02.playeroffset = [];
    setup_hidden_figure_models(var_02, "figure_3");
  }
}

init_fig4() {
  level.special_mode_activation_funcs["figure_4"] = ::showhiddenfigurestoplayer;
  level.normal_mode_activation_funcs["figure_4"] = ::showhiddenfigurestoplayer;
  level.hidden_figures[3] = spawnStruct();
  level.hidden_figures[3].origin = (4058, -4359, 76);
  level.hidden_figures[3].powered_on = 0;
  level.hidden_figures[3].requires_power = 0;
  level.hidden_figures[3].name = "hidden_figure_objects";
  level.hidden_figures[3].script_noteworthy = "figure_4";
  level.hidden_figures[3].script_parameters = "default";
  level.hidden_figures[3].var_336 = "interaction";
  var_00 = scripts\engine\utility::getstructarray("figure_4", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.groupname = "locOverride";
    var_02.playeroffset = [];
    setup_hidden_figure_models(var_02, "figure_4");
  }
}