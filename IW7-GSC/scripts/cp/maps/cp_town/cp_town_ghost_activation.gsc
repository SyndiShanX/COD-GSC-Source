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
  var_0 = getent("cipher_word_hint", "script_noteworthy");
  level.cipher_hint = var_0;
  setomnvar("zm_ui_skull_top_ent", level.cipher_hint);
}

blank() {}

watch_for_skull_death() {
  level endon("shoot_skulls_in_map_done");
  self endon("end_this_thread_for_" + self.object_num);
  for(;;) {
    self.model waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(!isplayer(var_1)) {
      continue;
    }

    level.skulls_killed++;
    playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_3);
    var_1 playlocalsound("part_pickup");
    if(self.model.health < 0) {
      self.model delete();
      self notify("end_this_thread_for_" + self.object_num);
    }
  }
}

shoot_skulls_in_map() {
  level waittill("prematch_done");
  foreach(var_1 in level.weeping_angels_note) {
    var_1 thread watch_for_damage_on_struct();
  }

  var_3 = 0;
  while(!scripts\engine\utility::istrue(var_3)) {
    if(isDefined(level.skulls_killed)) {
      if(level.skulls_killed >= 5) {
        var_3 = 1;
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
  foreach(var_1 in level.players) {
    var_1 thread watch_for_player_position();
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

wait_for_trap_kills(var_0, var_1) {
  for(;;) {
    level waittill(var_0, var_2);
    if(var_2 == var_1) {
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

calculate_cipher_from_current_interaction(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = "0";
    level.cipher_choices[0].model setscriptablepartstate("cipher_glyph", "neutral");
  } else {
    level.cipher_choices[0].model setscriptablepartstate("cipher_glyph", var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = "0";
    level.cipher_choices[1].model setscriptablepartstate("cipher_glyph", "neutral");
  } else {
    level.cipher_choices[1].model setscriptablepartstate("cipher_glyph", var_2);
  }

  if(!isDefined(var_3)) {
    var_3 = "0";
    level.cipher_choices[2].model setscriptablepartstate("cipher_glyph", "neutral");
  } else {
    level.cipher_choices[2].model setscriptablepartstate("cipher_glyph", var_3);
  }

  if(!isDefined(var_4)) {
    var_4 = "0";
    level.cipher_choices[3].model setscriptablepartstate("cipher_glyph", "neutral");
  } else {
    level.cipher_choices[3].model setscriptablepartstate("cipher_glyph", var_4);
  }

  var_5 = 1;
  var_6 = 2;
  var_7 = 3;
  var_8 = 4;
  var_9 = 3;
  var_0A = 6;
  var_0B = 9;
  var_0C = 0;
  var_0D = 0;
  var_0E = 0;
  var_0F = level.alphabets[var_1];
  if(var_2 == "0") {
    var_0C = 0;
  } else if(var_2 == level.cipherlettera) {
    var_0C = var_5 * var_9 + level.alphabets[var_2];
  } else if(var_2 == level.cipherletterb) {
    var_0C = var_6 * var_9 + level.alphabets[var_2];
  } else if(var_2 == level.cipherletterc) {
    var_0C = var_7 * var_9 + level.alphabets[var_2];
  } else if(var_2 == level.cipherletterd) {
    var_0C = var_8 * var_9 + level.alphabets[var_2];
  }

  if(var_3 == "0") {
    var_0D = 0;
  } else if(var_3 == level.cipherlettera) {
    var_0D = var_5 * var_0A + level.alphabets[var_3];
  } else if(var_3 == level.cipherletterb) {
    var_0D = var_6 * var_0A + level.alphabets[var_3];
  } else if(var_3 == level.cipherletterc) {
    var_0D = var_7 * var_0A + level.alphabets[var_3];
  } else if(var_3 == level.cipherletterd) {
    var_0D = var_8 * var_0A + level.alphabets[var_3];
  }

  if(var_4 == "0") {
    var_0E = 0;
  } else if(var_4 == level.cipherlettera) {
    var_0E = var_5 * var_0B + level.alphabets[var_4];
  } else if(var_4 == level.cipherletterb) {
    var_0E = var_6 * var_0B + level.alphabets[var_4];
  } else if(var_4 == level.cipherletterc) {
    var_0E = var_7 * var_0B + level.alphabets[var_4];
  } else if(var_4 == level.cipherletterd) {
    var_0E = var_8 * var_0B + level.alphabets[var_4];
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

calculate_cipher_from_letters_initially(var_0, var_1, var_2, var_3) {
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

  var_4 = [var_0 + "_" + var_3 + "_" + var_1 + "_" + var_2 + "", var_0 + "_" + var_3 + "_" + var_2 + "_" + var_1 + "", var_0 + "_" + var_1 + "_" + var_3 + "_" + var_2 + "", var_0 + "_" + var_1 + "_" + var_2 + "_" + var_3 + "", var_0 + "_" + var_2 + "_" + var_3 + "_" + var_1 + "", var_0 + "_" + var_2 + "_" + var_1 + "_" + var_3 + "", var_3 + "_" + var_0 + "_" + var_2 + "_" + var_1 + "", var_3 + "_" + var_0 + "_" + var_1 + "_" + var_2 + "", var_3 + "_" + var_1 + "_" + var_2 + "_" + var_0 + "", var_3 + "_" + var_1 + "_" + var_0 + "_" + var_2 + "", var_3 + "_" + var_2 + "_" + var_1 + "_" + var_0 + "", var_3 + "_" + var_2 + "_" + var_0 + "_" + var_1 + "", var_1 + "_" + var_0 + "_" + var_3 + "_" + var_2 + "", var_1 + "_" + var_0 + "_" + var_2 + "_" + var_3 + "", var_1 + "_" + var_3 + "_" + var_0 + "_" + var_2 + "", var_1 + "_" + var_3 + "_" + var_2 + "_" + var_0 + "", var_1 + "_" + var_2 + "_" + var_0 + "_" + var_3 + "", var_1 + "_" + var_2 + "_" + var_3 + "_" + var_0 + "", var_2 + "_" + var_0 + "_" + var_1 + "_" + var_3 + "", var_2 + "_" + var_0 + "_" + var_3 + "_" + var_1 + "", var_2 + "_" + var_3 + "_" + var_1 + "_" + var_0 + "", var_2 + "_" + var_3 + "_" + var_0 + "_" + var_1 + "", var_2 + "_" + var_1 + "_" + var_3 + "_" + var_0 + "", var_2 + "_" + var_1 + "_" + var_0 + "_" + var_3 + "", var_0 + "_" + var_3 + "_" + var_1 + "_" + 0 + "", var_0 + "_" + var_1 + "_" + var_3 + "_" + 0 + "", var_3 + "_" + var_0 + "_" + var_1 + "_" + 0 + "", var_3 + "_" + var_1 + "_" + var_0 + "_" + 0 + "", var_1 + "_" + var_0 + "_" + var_3 + "_" + 0 + "", var_1 + "_" + var_3 + "_" + var_0 + "_" + 0 + "", var_0 + "_" + var_3 + "_" + var_2 + "_" + 0 + "", var_0 + "_" + var_2 + "_" + var_3 + "_" + 0 + "", var_3 + "_" + var_0 + "_" + var_2 + "_" + 0 + "", var_3 + "_" + var_2 + "_" + var_0 + "_" + 0 + "", var_2 + "_" + var_0 + "_" + var_3 + "_" + 0 + "", var_2 + "_" + var_3 + "_" + var_0 + "_" + 0 + "", var_0 + "_" + var_1 + "_" + var_2 + "_" + 0 + "", var_0 + "_" + var_2 + "_" + var_1 + "_" + 0 + "", var_1 + "_" + var_0 + "_" + var_2 + "_" + 0 + "", var_1 + "_" + var_2 + "_" + var_0 + "_" + 0 + "", var_2 + "_" + var_0 + "_" + var_1 + "_" + 0 + "", var_2 + "_" + var_1 + "_" + var_0 + "_" + 0 + "", var_3 + "_" + var_1 + "_" + var_2 + "_" + 0 + "", var_3 + "_" + var_2 + "_" + var_1 + "_" + 0 + "", var_1 + "_" + var_3 + "_" + var_2 + "_" + 0 + "", var_1 + "_" + var_2 + "_" + var_3 + "_" + 0 + "", var_2 + "_" + var_3 + "_" + var_1 + "_" + 0 + "", var_2 + "_" + var_1 + "_" + var_3 + "_" + 0 + "", var_0 + "_" + var_1 + "_" + 0 + "_" + 0 + "", var_1 + "_" + var_0 + "_" + 0 + "_" + 0 + "", var_0 + "_" + var_2 + "_" + 0 + "_" + 0 + "", var_2 + "_" + var_0 + "_" + 0 + "_" + 0 + "", var_0 + "_" + var_3 + "_" + 0 + "_" + 0 + "", var_3 + "_" + var_0 + "_" + 0 + "_" + 0 + "", var_1 + "_" + var_2 + "_" + 0 + "_" + 0 + "", var_2 + "_" + var_1 + "_" + 0 + "_" + 0 + "", var_1 + "_" + var_3 + "_" + 0 + "_" + 0 + "", var_3 + "_" + var_1 + "_" + 0 + "_" + 0 + "", var_2 + "_" + var_3 + "_" + 0 + "_" + 0 + "", var_3 + "_" + var_2 + "_" + 0 + "_" + 0 + "", var_0 + "_" + var_0 + "_" + var_0 + "_" + 0 + "", var_1 + "_" + var_1 + "_" + var_1 + "_" + 0 + "", var_2 + "_" + var_2 + "_" + var_2 + "_" + 0 + "", var_3 + "_" + var_3 + "_" + var_3 + "_" + 0 + "", var_0 + "_" + var_0 + "_" + var_0 + "_" + 0 + "", var_1 + "_" + var_1 + "_" + var_1 + "_" + 0 + "", var_2 + "_" + var_2 + "_" + var_2 + "_" + 0 + "", var_3 + "_" + var_3 + "_" + var_3 + "_" + 0 + "", var_0 + "_" + var_0 + "_" + 0 + "_" + 0 + "", var_1 + "_" + var_1 + "_" + 0 + "_" + 0 + "", var_2 + "_" + var_2 + "_" + 0 + "_" + 0 + "", var_3 + "_" + var_3 + "_" + 0 + "_" + 0 + "", var_0 + "_" + 0 + "_" + 0 + "_" + 0 + "", var_1 + "_" + 0 + "_" + 0 + "_" + 0 + "", var_2 + "_" + 0 + "_" + 0 + "_" + 0 + "", var_3 + "_" + 0 + "_" + 0 + "_" + 0 + "", var_0 + "_" + var_0 + "_" + var_0 + "_" + var_0 + "", var_1 + "_" + var_1 + "_" + var_1 + "_" + var_1 + "", var_2 + "_" + var_2 + "_" + var_2 + "_" + var_2 + "", var_3 + "_" + var_3 + "_" + var_3 + "_" + var_3 + "", var_0 + "_" + var_0 + "_" + var_0 + "_" + 0 + "", var_1 + "_" + var_1 + "_" + var_1 + "_" + 0 + "", var_2 + "_" + var_2 + "_" + var_2 + "_" + 0 + "", var_3 + "_" + var_3 + "_" + var_3 + "_" + 0 + "", var_0 + "_" + var_0 + "_" + 0 + "_" + 0 + "", var_1 + "_" + var_1 + "_" + 0 + "_" + 0 + "", var_2 + "_" + var_2 + "_" + 0 + "_" + 0 + "", var_3 + "_" + var_3 + "_" + 0 + "_" + 0 + ""];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  foreach(var_0A in var_4) {
    var_0B = strtok(var_0A, "_");
    var_5[var_5.size] = var_0B[0];
    var_6[var_6.size] = var_0B[1];
    var_7[var_7.size] = var_0B[2];
    var_8[var_8.size] = var_0B[3];
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
  foreach(var_0A in var_5) {
    foreach(var_1B, var_1A in level.alphabets) {
      if(var_0A == var_1B) {
        var_14[var_14.size] = level.alphabets[var_0A];
      }
    }
  }

  foreach(var_0A in var_6) {
    if(var_0A == "0") {
      var_15[var_15.size] = 0;
      continue;
    }

    foreach(var_1B, var_1A in level.alphabets) {
      if(var_0A == var_1B) {
        if(var_0A == var_0) {
          var_15[var_15.size] = var_0D * var_11 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_1) {
          var_15[var_15.size] = var_0E * var_11 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_2) {
          var_15[var_15.size] = var_0F * var_11 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_3) {
          var_15[var_15.size] = var_10 * var_11 + level.alphabets[var_1B];
        }
      }
    }
  }

  foreach(var_0A in var_7) {
    if(var_0A == "0") {
      var_16[var_16.size] = 0;
      continue;
    }

    foreach(var_1B, var_1A in level.alphabets) {
      if(var_0A == var_1B) {
        if(var_0A == var_0) {
          var_16[var_16.size] = var_0D * var_12 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_1) {
          var_16[var_16.size] = var_0E * var_12 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_2) {
          var_16[var_16.size] = var_0F * var_12 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_3) {
          var_16[var_16.size] = var_10 * var_12 + level.alphabets[var_1B];
        }
      }
    }
  }

  foreach(var_0A in var_8) {
    if(var_0A == "0") {
      var_17[var_17.size] = 0;
      continue;
    }

    foreach(var_1B, var_1A in level.alphabets) {
      if(var_0A == var_1B) {
        if(var_0A == var_0) {
          var_17[var_17.size] = var_0D * var_13 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_1) {
          var_17[var_17.size] = var_0E * var_13 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_2) {
          var_17[var_17.size] = var_0F * var_13 + level.alphabets[var_1B];
          continue;
        }

        if(var_0A == var_3) {
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
  foreach(var_1 in level.cipher_interactions_structs) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
    var_1.model show();
  }

  foreach(var_4 in level.cipher_model_structs) {
    var_4.model show();
  }

  level waittill("cipher_solved");
}

complete_cipher_quest() {
  level.completed_cipher = 1;
  foreach(var_1 in level.cipher_interactions_structs) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_1);
    var_1.model hide();
  }

  foreach(var_4 in level.cipher_model_structs) {
    var_4.model hide();
  }

  foreach(var_8, var_7 in level.cipher_choices) {
    level.cipher_choices[var_8].model setscriptablepartstate("cipher_glyph", "neutral");
  }

  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(4);
}

debug_cipher_quest() {}

slow_mo_sphere(var_0) {
  self.sacred_ground = spawn("trigger_radius", var_0.origin, 0, 400, 256);
  self.sacred_ground.fx = spawnfx(level._effect["slow_time_bubble"], var_0.origin);
  self.sacred_ground.var_FB2F = scripts\engine\utility::play_loopsound_in_space("town_mute_circle_lp", var_0.origin);
  thread scripts\engine\utility::play_sound_in_space("town_mute_circle_start", var_0.origin);
  self.zombie_list = [];
  playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_0.origin);
  wait(1);
  triggerfx(self.sacred_ground.fx);
  self.sacred_ground thread apply_slow_mo_on_trigger();
  level waittill("end_painting_" + var_0.name);
  if(isDefined(self.sacred_ground.fx)) {
    self.sacred_ground.fx delete();
  }

  if(isDefined(self.sacred_ground.var_FB2F)) {
    self.sacred_ground.var_FB2F delete();
  }

  if(isDefined(self.sacred_ground)) {
    self.sacred_ground delete();
  }

  var_0.model setModel("cp_town_willard_painting");
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_3 in var_1) {
    var_3 scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoAttack");
    var_3.activated_slomo_sphere = 0;
    var_3.noturnanims = 0;
    var_3.isfrozen = undefined;
  }
}

custom_unslow_func(var_0) {
  var_0 endon("death");
  if(!isalive(var_0)) {
    return;
  }

  var_0.precacheleaderboards = 0;
  var_0.nocorpse = undefined;
  var_0.full_gib = undefined;
  var_0.noturnanims = undefined;
}

custom_slow_time_func(var_0) {
  var_0 endon("death");
  var_0.isfrozen = 1;
  var_0.precacheleaderboards = 1;
  var_0.nocorpse = 1;
  var_0.full_gib = 1;
  var_0.noturnanims = 1;
  var_0 waittill("unslow_zombie");
  var_0.isfrozen = undefined;
}

apply_slow_mo_on_trigger() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self)) {
        if(!scripts\engine\utility::istrue(var_1.inside_slow_sphere)) {
          var_1 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_1);
        }

        var_1.inside_slow_sphere = 1;
        continue;
      }

      if(scripts\engine\utility::istrue(var_1.inside_slow_sphere)) {
        var_1 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_1);
      }

      var_1.inside_slow_sphere = 0;
    }

    var_3 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    level.zombie_list = var_3;
    foreach(var_5 in level.zombie_list) {
      if(!isDefined(var_5)) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(!var_5 scripts\cp\utility::is_zombie_agent()) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(var_5 scripts\cp\utility::agentisfnfimmune()) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(!scripts\engine\utility::istrue(var_5.entered_playspace)) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(var_5 istouching(self)) {
        var_5 scripts\mp\agents\_scriptedagents::setstatelocked(1, "DoAttack");
        var_5.activated_slomo_sphere = 1;
        var_5.noturnanims = 1;
        var_5.isfrozen = 1;
        continue;
      }

      var_5 scripts\mp\agents\_scriptedagents::setstatelocked(0, "DoAttack");
      var_5.activated_slomo_sphere = 0;
      var_5.noturnanims = 0;
      var_5.isfrozen = undefined;
      var_5 notify("unslow_zombie");
    }

    scripts\engine\utility::waitframe();
  }
}

weeping_angels_start() {
  foreach(var_1 in level.weeping_angels_note) {
    var_1.model show();
  }

  level waittill("weeping_angels_note_read");
  foreach(var_4 in level.players) {
    var_4.weeping_angels_puzzle = 1;
  }

  level.frozenzombiefunc = ::custom_slow_time_func;
  level.thawzombiefunc = ::custom_unslow_func;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  level scripts\engine\utility::waittill_multiple("painting_01_done", "painting_02_done", "painting_03_done", "painting_04_done");
}

wait_for_painting_kills_complete(var_0, var_1, var_2) {
  for(;;) {
    level waittill(var_0, var_3);
    if(var_3 == var_1) {
      var_2 = 1;
      return var_2;
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
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("access_ghostnskulls", "town_comment_vo");
  }
}

watch_for_damage_on_machine() {
  self endon("end_func_on" + self.model);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_4) && var_4 == "MOD_MELEE") {
      self.maxhealth = 5;
      self.health = 5;
      continue;
    }

    if(!issubstr(var_9, "cutie")) {
      self.maxhealth = 5;
      self.health = 5;
      continue;
    }

    if(scripts\engine\utility::istrue(var_1.fired_fov_beam)) {
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
  var_0 = (5444, -4760, -14);
  var_1 = 10000;
  for(;;) {
    var_2 = 1;
    foreach(var_4 in level.players) {
      if(scripts\engine\utility::istrue(var_4.inlaststand)) {
        var_2 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_4.iscarrying)) {
        var_2 = 0;
        break;
      }

      if(distancesquared(var_4.origin, var_0) > var_1) {
        var_2 = 0;
        break;
      }

      if(!var_4 usebuttonpressed()) {
        var_2 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_2) {
      var_2 = 1;
      foreach(var_4 in level.players) {
        if(scripts\engine\utility::istrue(var_4.inlaststand)) {
          var_2 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_4.iscarrying)) {
          var_2 = 0;
          break;
        }

        if(distancesquared(var_4.origin, var_0) > var_1) {
          var_2 = 0;
          break;
        }

        if(!var_4 usebuttonpressed()) {
          var_2 = 0;
          break;
        }
      }
    }

    if(var_2) {
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
  var_0 = scripts\engine\utility::getstructarray("figure_1", "script_noteworthy");
  level.hidden_figures[1] = spawnStruct();
  level.hidden_figures[1].origin = (4058, -4359, 76);
  level.hidden_figures[1].powered_on = 0;
  level.hidden_figures[1].requires_power = 0;
  level.hidden_figures[1].name = "hidden_figure_objects";
  level.hidden_figures[1].script_noteworthy = "figure_2";
  level.hidden_figures[1].script_parameters = "default";
  level.hidden_figures[1].var_336 = "interaction";
  var_0 = scripts\engine\utility::getstructarray("figure_2", "script_noteworthy");
  level.hidden_figures[2] = spawnStruct();
  level.hidden_figures[2].origin = (4058, -4359, 76);
  level.hidden_figures[2].powered_on = 0;
  level.hidden_figures[2].requires_power = 0;
  level.hidden_figures[2].name = "hidden_figure_objects";
  level.hidden_figures[2].script_noteworthy = "figure_3";
  level.hidden_figures[2].script_parameters = "default";
  level.hidden_figures[2].var_336 = "interaction";
  var_0 = scripts\engine\utility::getstructarray("figure_3", "script_noteworthy");
  level.hidden_figures[3] = spawnStruct();
  level.hidden_figures[3].origin = (4058, -4359, 76);
  level.hidden_figures[3].powered_on = 0;
  level.hidden_figures[3].requires_power = 0;
  level.hidden_figures[3].name = "hidden_figure_objects";
  level.hidden_figures[3].script_noteworthy = "figure_4";
  level.hidden_figures[3].script_parameters = "default";
  level.hidden_figures[3].var_336 = "interaction";
  var_0 = scripts\engine\utility::getstructarray("figure_4", "script_noteworthy");
  foreach(var_2 in level.hidden_figures) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, var_2.script_noteworthy);
  }

  init_ghost_n_skull_4_quest();
}

cp_town_enter_ghosts_n_skulls_func(var_0) {
  var_0 thread restore_color_in_gns(var_0);
  var_0 thread entangled_cube_color_manager(var_0);
}

restore_color_in_gns(var_0) {
  var_0 endon("disconnect");
  var_1 = 0;
  foreach(var_3 in level.players) {
    if(scripts\engine\utility::istrue(var_3.activate_gns_machine)) {
      var_1 = 1;
      break;
    }
  }

  if(var_1) {
    var_0 visionsetnakedforplayer("cp_town_color", 1);
    wait(2);
  }

  var_0 visionsetnakedforplayer("cp_zmb_ghost_path", 1);
}

cp_town_end_ghosts_n_skulls_func(var_0) {
  var_0 notify("stop_entangled_cube_color_manager");
  var_0 visionsetnakedforplayer(level.current_vision_set, 0);
  scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::hide_charge_progress(var_0);
}

entangled_cube_color_manager(var_0) {
  var_0 endon("disconnect");
  var_0 endon("stop_entangled_cube_color_manager");
  for(;;) {
    if(isDefined(var_0.ghost_in_entanglement)) {
      var_1 = var_0.ghost_in_entanglement;
      var_2 = get_platform_trigger_color(var_0);
      if(isDefined(var_1.color) && var_2 != var_1.color) {
        change_cube_color(var_1, var_2);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

set_up_platform_and_trigger() {
  var_0 = ["blue", "green", "yellow", "red"];
  foreach(var_2 in var_0) {
    var_3 = getent(var_2 + "_platform", "targetname");
    var_4 = getent(var_2 + "_platform_trigger", "targetname");
    var_3.var_C725 = var_3.origin;
    var_4.var_C725 = var_4.origin;
    var_4 enablelinkto();
    var_4 linkto(var_3);
  }
}

get_platform_trigger_color(var_0) {
  var_1 = ["blue", "green", "yellow", "red"];
  foreach(var_3 in var_1) {
    var_4 = getent(var_3 + "_platform_trigger", "targetname");
    if(var_0 istouching(var_4)) {
      return var_3;
    }
  }

  return "white";
}

color_indicator_manager() {
  level endon("kill_color_indicator_manager");
  var_0 = 15;
  var_1 = 0.5;
  var_2 = "none";
  var_3 = ["green", "red", "blue", "yellow"];
  for(;;) {
    var_4 = scripts\engine\utility::array_remove(var_3, var_2);
    var_2 = scripts\engine\utility::random(var_4);
    update_color_indicator_color(var_2);
    wait(var_0 - var_1 * 5);
    turn_off_color_indicator();
    wait(var_1);
    turn_on_color_indicator();
    wait(var_1);
    turn_off_color_indicator();
    wait(var_1);
    turn_on_color_indicator();
    wait(var_1);
    turn_off_color_indicator();
    wait(var_1);
  }
}

turn_off_color_indicator() {
  foreach(var_1 in level.skull_hop_color_indicators) {
    var_1 setscriptablepartstate("skull_hop_indicator", "off");
  }
}

turn_on_color_indicator() {
  foreach(var_1 in level.skull_hop_color_indicators) {
    var_1 setscriptablepartstate("skull_hop_indicator", level.color_indicator_color);
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
  var_0 = scripts\engine\utility::getstructarray("cipher_choice_model", "script_noteworthy");
  level.cipher_choices = [];
  foreach(var_2 in var_0) {
    var_3 = undefined;
    switch (var_2.name) {
      case "cipher_choice_1":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        break;

      case "cipher_choice_2":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        break;

      case "cipher_choice_3":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        break;

      case "cipher_choice_4":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        break;

      default:
        break;
    }

    var_3 setscriptablepartstate("cipher_glyph", "neutral");
    if(isDefined(var_3)) {
      var_2.model = var_3;
    }

    var_4 = strtok(var_2.name, "_");
    var_2.index = int(var_4[2]);
    level.cipher_choices[var_2.index - 1] = var_2;
  }
}

init_cipher_letters() {
  level.words_for_cipher = [];
  level.words_for_cipher[0] = ["chlorination", "bromination", "solvolysis", "azides", "alkenes", "hydrogenation", "oxidation", "reduction", "ethers", "ethyl", "aldehydes", "benzene", "nitriles", "allomer", "neutrino", "sublimation", "zwitterion"];
  level.chosen_cipher_word = scripts\engine\utility::random(level.words_for_cipher[0]);
  roll_correct_letter_combination(level.chosen_cipher_word);
  level thread set_omnvar_based_on_word(level.chosen_cipher_word);
  var_0 = scripts\engine\utility::getstructarray("cipher_letter_model", "script_noteworthy");
  level.cipher_model_structs = [];
  foreach(var_2 in var_0) {
    switch (var_2.name) {
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
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        var_3 setCanDamage(1);
        var_3.maxhealth = 99999;
        var_3.health = 99999;
        var_2.model = var_3;
        var_2.current_letter = "";
        var_2.completed_cipher_letter = 0;
        var_4 = strtok(var_2.name, "_");
        var_5 = var_4[2];
        var_2.model setscriptablepartstate("cipher_glyph", "neutral");
        var_2.model hide();
        var_2 thread watch_for_damage_on_cipher_letter(var_5);
        level.cipher_model_structs[int(var_5) - 1] = [];
        level.cipher_model_structs[int(var_5) - 1] = var_2;
        break;
    }

    if(!isDefined(level.cipher_pointer)) {
      level.cipher_pointer = 0;
    }
  }

  level thread watch_for_correct_combination_of_letters_entered();
}

set_omnvar_based_on_word(var_0) {
  var_1 = 0;
  switch (var_0) {
    case "chlorination":
      var_1 = 1;
      break;

    case "bromination":
      var_1 = 2;
      break;

    case "solvolysis":
      var_1 = 3;
      break;

    case "azides":
      var_1 = 4;
      break;

    case "alkenes":
      var_1 = 5;
      break;

    case "hydrogenation":
      var_1 = 6;
      break;

    case "oxidation":
      var_1 = 7;
      break;

    case "reduction":
      var_1 = 8;
      break;

    case "ethers":
      var_1 = 9;
      break;

    case "ethyl":
      var_1 = 10;
      break;

    case "aldehydes":
      var_1 = 11;
      break;

    case "benzene":
      var_1 = 12;
      break;

    case "nitriles":
      var_1 = 13;
      break;

    case "bro":
      var_1 = 14;
      break;

    case "allomer":
      var_1 = 15;
      break;

    case "neutrino":
      var_1 = 16;
      break;

    case "sublimation":
      var_1 = 17;
      break;

    case "zwitterion":
      var_1 = 18;
      break;
  }

  setomnvar("skulltop_cipher_hint", var_1);
}

watch_for_correct_combination_of_letters_entered() {
  level endon("cipher_solved");
  for(;;) {
    if(!isDefined(level.chosen_cipher_word)) {
      continue;
    }

    var_0 = "";
    for(var_1 = 0; var_1 < level.cipher_pointer; var_1++) {
      var_0 = var_0 + level.cipher_model_structs[var_1].current_letter;
      if(level.chosen_cipher_word == var_0) {
        level notify("cipher_solved");
      }
    }

    wait(1);
  }
}

roll_correct_letter_combination(var_0) {
  var_1 = getrandomletter();
  var_2 = getrandomletter();
  var_3 = getrandomletter();
  var_4 = getrandomletter();
  for(;;) {
    if(does_cipher_have_all_letters(var_1, var_2, var_3, var_4, var_0)) {
      level.cipherlettera = var_1;
      level.cipherletterb = var_2;
      level.cipherletterc = var_3;
      level.cipherletterd = var_4;
      return;
    } else {
      var_1 = getrandomletter();
      var_2 = getrandomletter();
      var_3 = getrandomletter();
      var_4 = getrandomletter();
    }

    scripts\engine\utility::waitframe();
  }
}

does_cipher_have_all_letters(var_0, var_1, var_2, var_3, var_4) {
  calculate_cipher_from_letters_initially(var_0, var_1, var_2, var_3);
  var_5 = scripts\engine\utility::array_remove_duplicates(level.available_letters_for_cipher);
  var_6 = [];
  var_6 = get_chars_of_word_as_array(var_4);
  var_7 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  foreach(var_9 in var_6) {
    if(!scripts\engine\utility::array_contains(var_5, var_9)) {
      return 0;
    }
  }

  return 1;
}

get_chars_of_word_as_array(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = var_0[var_2];
  }

  return var_1;
}

cipher_activation_func(var_0, var_1) {
  var_1 endon("disconnect");
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

  switch (var_0.name) {
    case "cipher_interaction_01":
      level.letter_roll["a"] = var_0.letter;
      break;

    case "cipher_interaction_02":
      level.letter_roll["b"] = var_0.letter;
      break;

    case "cipher_interaction_03":
      level.letter_roll["c"] = var_0.letter;
      break;

    case "cipher_interaction_04":
      level.letter_roll["d"] = var_0.letter;
      break;

    default:
      break;
  }

  if(!isDefined(level.cipherlettera) || !isDefined(level.cipherletterb) || !isDefined(level.cipherletterc) || !isDefined(level.cipherletterd)) {
    wait(0.8);
    return;
  }

  level.letter_inputs[level.letter_inputs.size] = var_0.letter;
  var_2 = calculate_cipher_from_current_interaction(var_1, level.letter_inputs[0], level.letter_inputs[1], level.letter_inputs[2], level.letter_inputs[3]);
  spawn_fx_on_theatre_screen(var_1, var_2);
  if(level.letter_inputs.size >= 4) {
    level thread clear_up_input_display_after_time(20);
    level.letter_inputs = [];
  }
}

clear_up_input_display_after_time(var_0) {
  level endon("end_clear_input_func");
  level thread watch_for_inputs_reentered();
  wait(var_0);
  foreach(var_3, var_2 in level.cipher_choices) {
    level.cipher_choices[var_3].model setscriptablepartstate("cipher_glyph", "neutral");
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

delay_enable_linked_interaction(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  level waittill("spawn_wave_done");
  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_2);
}

spawn_fx_on_theatre_screen(var_0, var_1) {
  var_2 = (5076, -2547, 473);
  var_3 = (0, 300, 0);
  level.cipher_model_structs[level.cipher_pointer].model setscriptablepartstate("cipher_glyph", var_1);
  level.cipher_model_structs[level.cipher_pointer].current_letter = var_1;
}

getrandomletter() {
  var_0 = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
  return scripts\engine\utility::random(var_0);
}

init_painting_interactions() {
  scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1, "painting_interaction", undefined, undefined, ::radiation_collection_hint_func, ::paintings_activation_function, 0, 0, ::init_paintings_interaction, undefined);
}

paintings_activation_function(var_0, var_1) {
  level.frozenzombiefunc = ::custom_slow_time_func;
  level.thawzombiefunc = ::custom_unslow_func;
  if(!scripts\engine\utility::istrue(var_1.weeping_angels_puzzle)) {
    return;
  }

  if(isDefined(var_0.painting_owner)) {
    if(var_0.painting_owner == var_1) {
      return;
    } else {
      return;
    }
  }

  if(scripts\engine\utility::istrue(level.painting_active)) {
    return;
  }

  level.painting_active = 1;
  var_0.painting_owner = var_1;
  var_1.hidden_figures_hit = 0;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level thread watch_for_player_disconnect_after_painting_trigger(var_0, var_1);
  level thread look_at_painting(var_0, var_1);
  level thread slow_mo_sphere(var_0);
  wait(40);
  level notify("end_painting_" + var_0.name);
  var_1.triggered_rad_extractor_device = 0;
  level.painting_active = 0;
  var_0.painting_owner = undefined;
  var_1.inside_slow_sphere = 0;
  level.frozenzombiefunc = ::scripts\cp\zombies\zombie_scriptable_states::freeze_zombie;
  level.thawzombiefunc = ::scripts\cp\zombies\zombie_scriptable_states::unfreeze_zombie;
  if(var_1.hidden_figures_hit >= 7) {
    level notify(var_0.name + "_done");
    level thread scripts\engine\utility::play_sound_in_space("part_pickup", var_0.origin);
    if(isDefined(var_1.array_of_weeping_angels)) {
      foreach(var_3 in var_1.array_of_weeping_angels) {
        var_3 delete();
      }
    }

    var_1.hidden_figures_hit = 0;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    return;
  }

  var_1.hidden_figures_hit = 0;
  if(isDefined(var_1.array_of_weeping_angels)) {
    foreach(var_3 in var_1.array_of_weeping_angels) {
      var_3 delete();
    }
  }

  var_1 playlocalsound("perk_machine_deny");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

watch_for_player_disconnect_after_painting_trigger(var_0, var_1) {
  level endon("game_ended");
  level endon("end_disconnect_thread_for_" + var_0.name);
  for(;;) {
    var_1 waittill("disconnect");
    if(isDefined(var_1.array_of_weeping_angels)) {
      foreach(var_3 in var_1.array_of_weeping_angels) {
        var_3 delete();
      }
    }

    var_0.model setModel("cp_town_willard_painting");
    level.painting_active = 0;
    var_0.painting_owner = undefined;
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    level notify("end_disconnect_thread_for_" + var_0.name);
  }
}

look_at_painting(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("end_painting_" + var_0.name);
  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(var_0.origin, var_1.origin) > 5184) {
      scripts\engine\utility::waitframe();
      var_0.model setModel("cp_town_willard_painting");
      continue;
    }

    if(scripts\engine\utility::within_fov(var_1.origin, var_1.angles, var_0.origin, cos(70))) {
      var_0.model setModel("cp_town_willard_painting");
      scripts\engine\utility::waitframe();
      continue;
    } else if(randomint(100) > 98) {
      var_0.model setModel("cp_town_willard_painting_skull");
      var_1 dodamage(var_1.health / 15, var_1.origin);
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

collector_activation_func(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  if(scripts\engine\utility::istrue(level.picked_up_radiation_collector)) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  if(!isDefined(level.skulls_killed)) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  if(isDefined(level.skulls_killed) && level.skulls_killed < 5) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  level.picked_up_radiation_collector = 1;
  playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_0.origin);
  var_1 playlocalsound("part_pickup");
  var_0.model hide();
  level notify("radiation_collector_found");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

last_stand_watcher(var_0) {
  for(;;) {
    scripts\engine\utility::waittill_any_3("last_stand", "death", "disconnect");
    if(!scripts\engine\utility::istrue(level.picked_up_radiation_collector)) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
      level.picked_up_radiation_collector = undefined;
      var_0.model show();
    }
  }
}

pickup_extractor_after_collecting_radiation(var_0) {
  playFX(scripts\engine\utility::getfx("hidden_figure_death"), level.radiation_extraction_interaction.origin);
  var_0 playlocalsound("part_pickup");
  level.rad_extractor_owner = var_0;
  give_crafted_rad_extractor(level.radiation_extraction_interaction, var_0);
  var_0 thread last_stand_watcher_extractor_craft(level.radiation_extraction_interaction);
  level notify("completed_extraction");
}

last_stand_watcher_extractor_craft(var_0) {
  for(;;) {
    scripts\engine\utility::waittill_any_3("last_stand", "death", "disconnect");
    level.rad_extractor_owner = undefined;
  }
}

extraction_activation_func(var_0, var_1) {
  if(!scripts\engine\utility::istrue(level.picked_up_radiation_collector)) {
    return;
  }

  if(isDefined(level.radiation_extractor) && isDefined(level.radiation_extractor.ticks_of_radiation)) {
    if(level.radiation_extractor.ticks_of_radiation == 9) {
      if(!isDefined(level.rad_extractor_owner)) {
        thread pickup_extractor_after_collecting_radiation(var_1);
        return;
      }

      return;
    } else if(level.radiation_extractor.ticks_of_radiation < 9 || level.radiation_extractor.ticks_of_radiation > 9) {
      return;
    }
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.radiation_collector[0]);
  level.radiation_extraction_interaction = var_0;
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("cp_town_radiation_extractor_top");
  var_2.angles = var_0.angles;
  level.radiation_extractor = var_2;
  var_1 thread last_stand_watcher_extractor_craft(var_0);
  var_1 playlocalsound("part_pickup");
  level notify("radiation_extraction_started");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(level.radiation_extraction_interaction);
}

move_model_after_tick(var_0) {
  if(var_0 == 0) {
    var_1 = level.radiation_extraction_interaction.origin;
    self.angles = level.radiation_extraction_interaction.angles;
    self setModel("cp_town_radiation_extractor_top");
    self moveto(var_1, 1);
  } else {
    var_1 = self.origin + (0, 0, var_1 * 0.666);
    self moveto(var_1, 0.5);
  }

  scripts\engine\utility::play_sound_in_space("town_radiation_extractor_tick_up", self.origin + (0, 0, 5));
}

init_cipher_interaction_structs() {
  var_0 = scripts\engine\utility::getstructarray("cipher_interaction", "script_noteworthy");
  if(isDefined(level.cipher_interactions_structs)) {
    return;
  }

  foreach(var_4, var_2 in var_0) {
    var_3 = undefined;
    switch (var_2.name) {
      case "cipher_interaction_01":
        var_3 = spawn("script_model", var_2.origin + (0, 0, 10));
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        var_3 setscriptablepartstate("cipher_glyph", level.cipherlettera);
        var_2.letter = level.cipherlettera;
        break;

      case "cipher_interaction_02":
        var_3 = spawn("script_model", var_2.origin + (0, 0, 10));
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        var_3 setscriptablepartstate("cipher_glyph", level.cipherletterb);
        var_2.letter = level.cipherletterb;
        break;

      case "cipher_interaction_03":
        var_3 = spawn("script_model", var_2.origin + (0, 0, 10));
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        var_3 setscriptablepartstate("cipher_glyph", level.cipherletterc);
        var_2.letter = level.cipherletterc;
        break;

      case "cipher_interaction_04":
        var_3 = spawn("script_model", var_2.origin + (0, 0, 10));
        var_3 setModel("tag_origin_cipher_letter");
        var_3.angles = var_2.angles + (0, 90, 0);
        var_3 setscriptablepartstate("cipher_glyph", level.cipherletterd);
        var_2.letter = level.cipherletterd;
        break;

      default:
        break;
    }

    if(isDefined(var_3)) {
      var_2.model = var_3;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    var_2.model hide();
    level.cipher_interactions_structs[var_4] = var_2;
    level.cipher_failures = 0;
  }
}

watch_for_damage_on_cipher_letter(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("end_this_thread_for_" + self.name);
  for(;;) {
    self.model waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_5) && var_5 == "MOD_MELEE") {
      self.model.maxhealth = 99999;
      self.model.health = 99999;
      continue;
    }

    if(scripts\engine\utility::istrue(self.completed_cipher_letter)) {
      self.model.maxhealth = 99999;
      self.model.health = 99999;
      continue;
    }

    if(int(var_0) - 1 >= level.chosen_cipher_word.size) {
      self.model.maxhealth = 99999;
      self.model.health = 99999;
      continue;
    }

    if(self.current_letter == level.chosen_cipher_word[int(var_0) - 1]) {
      playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_4);
      level thread scripts\engine\utility::play_sound_in_space("part_pickup", var_4);
      self.completed_cipher_letter = 1;
      level.cipher_pointer++;
      continue;
    }

    level.cipher_failures++;
    level thread scripts\engine\utility::play_sound_in_space("purchase_deny", var_4);
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
  var_0 = scripts\engine\utility::getstructarray("painting_interaction", "script_noteworthy");
  if(isDefined(level.paintings_struct)) {
    return;
  }

  foreach(var_4, var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_2.model = var_3;
    level.paintings_struct[var_4] = var_2;
  }
}

init_collector_func() {
  var_0 = scripts\engine\utility::getstructarray("radiation_collector_interaction", "script_noteworthy");
  foreach(var_4, var_2 in var_0) {
    var_3 = undefined;
    switch (var_2.name) {
      case "radiation_collector":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("cp_town_radiation_extractor");
        var_3.angles = var_2.angles;
        break;

      default:
        break;
    }

    if(isDefined(var_3)) {
      var_2.model = var_3;
    }

    level.radiation_collector[var_4] = var_2;
  }
}

init_extraction_point_func() {
  var_0 = scripts\engine\utility::getstructarray("radiation_extraction_interaction", "script_noteworthy");
  foreach(var_4, var_2 in var_0) {
    var_3 = undefined;
    switch (var_2.name) {
      case "radiation_extraction_point":
        var_3 = spawn("script_model", var_2.origin);
        var_3 setModel("cp_town_radiation_extractor_base");
        var_3.angles = var_2.angles;
        break;

      default:
        break;
    }

    if(isDefined(var_3)) {
      var_2.model = var_3;
    }

    level.radiation_collector[var_4] = var_2;
  }
}

radiation_collection_hint_func(var_0, var_1) {
  return "";
}

init_skulls_to_shoot() {
  var_0 = scripts\engine\utility::getstructarray("gns_skull", "script_noteworthy");
  var_1 = ["skull1", "skull2", "skull3", "skull4", "skull5", "skull6", "skull7", "skull8", "skull9", "skull10"];
  var_2 = 0;
  foreach(var_8, var_4 in var_0) {
    if(var_2 >= 5) {
      break;
    }

    var_5 = scripts\engine\utility::random(var_1);
    var_1 = scripts\engine\utility::array_remove(var_1, var_5);
    var_6 = scripts\engine\utility::getstruct(var_5, "targetname");
    var_2++;
    var_7 = undefined;
    switch (var_5) {
      case "skull1":
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = var_6.angles;
        var_6.object_num = 1;
        break;

      case "skull2":
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = var_6.angles;
        var_6.object_num = 2;
        break;

      case "skull3":
        var_7 = spawn("script_model", (7147, 2187, 328));
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = (0, 168.9, 0);
        var_6.object_num = 3;
        break;

      case "skull4":
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = var_6.angles;
        var_6.object_num = 4;
        break;

      case "skull5":
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = var_6.angles;
        var_6.object_num = 5;
        break;

      case "skull6":
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = var_6.angles;
        var_6.object_num = 6;
        break;

      case "skull7":
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = var_4.angles;
        var_6.object_num = 7;
        break;

      case "skull8":
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = var_6.angles;
        var_6.object_num = 8;
        break;

      case "skull9":
        var_7 = spawn("script_model", (6785, -2650.5, 105));
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = (0, 243.3, 0);
        var_6.object_num = 9;
        break;

      case "skull10":
        var_7 = spawn("script_model", var_6.origin);
        var_7 setModel("zmb_8_bit_price_town");
        var_7.angles = var_6.angles;
        var_6.object_num = 10;
        break;

      default:
        break;
    }

    var_7 setCanDamage(1);
    var_7.maxhealth = 5;
    var_7.health = 5;
    var_7.damage_done = 0;
    if(isDefined(var_7)) {
      var_6.model = var_7;
    }

    level.skullbusters_map_skulls[var_8] = var_6;
    level.skullbusters_map_skulls[var_8] thread watch_for_skull_death();
  }
}

load_gns_3_vfx() {
  level._effect["combo_arc_green"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_green.vfx");
  level._effect["combo_arc_red"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_red.vfx");
  level._effect["combo_arc_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_blue.vfx");
  level._effect["combo_arc_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_yellow.vfx");
}

cp_town_set_moving_target_color(var_0, var_1) {}

determine_color(var_0) {
  var_1 = scripts\engine\utility::array_randomize(var_0);
  level.moving_target_color_based_on_priority = [];
  level.moving_target_color_based_on_priority["low"] = var_1[0];
  level.moving_target_color_based_on_priority["medium"] = var_1[1];
  level.moving_target_color_based_on_priority["high"] = var_1[2];
}

cp_town_should_moving_target_explode(var_0, var_1) {
  if(!isDefined(level.color_indicator_color)) {
    return 0;
  }

  if(level.color_indicator_color == "off") {
    return 0;
  }

  return var_0.color == level.color_indicator_color;
}

cp_town_hit_wrong_moving_target_func(var_0, var_1, var_2) {
  level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_1);
}

delay_determine_game_fail() {
  level endon("game_ended");
  var_0 = 2;
  wait(var_0);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::determine_game_fail();
}

town_gns_player_reward_func() {
  level.unlimited_fnf = 1;
  foreach(var_1 in level.players) {
    if(!scripts\engine\utility::istrue(level.entered_thru_card)) {
      var_1 scripts\cp\zombies\achievement::update_achievement("QUARTER_MUNCHER", 1);
    }

    var_1 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_1);
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
  var_0 = scripts\engine\utility::array_randomize(["up_down", "up_down", "forward_backward", "forward_backward"]);
  var_1 = scripts\engine\utility::array_randomize(["green", "yellow", "blue", "red"]);
  foreach(var_4, var_3 in var_1) {
    level thread activate_platform_color(var_3, var_0[var_4]);
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
  var_0 = getent("skull_hop_death_floor", "targetname");
  var_0 thread death_floor_player_monitor(var_0);
}

deactivate_death_floor() {
  var_0 = getent("skull_hop_death_floor", "targetname");
  var_0 notify("stop_death_floor");
}

activate_color_indicator() {
  var_0 = [(-8222, 2421, -2090), (-6356, 2402, -2090)];
  level.skull_hop_color_indicators = [];
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2);
    var_3 setModel("crab_boss_origin");
    level.skull_hop_color_indicators[level.skull_hop_color_indicators.size] = var_3;
  }
}

deactivate_color_indicator() {
  kill_color_indicator_manager();
  foreach(var_1 in level.skull_hop_color_indicators) {
    var_1 delete();
  }
}

update_color_indicator_color(var_0) {
  level.color_indicator_color = var_0;
  foreach(var_2 in level.skull_hop_color_indicators) {
    var_2 setscriptablepartstate("skull_hop_indicator", var_0);
  }
}

death_floor_player_monitor(var_0) {
  var_0 endon("stop_death_floor");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isplayer(var_1)) {
      scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::teleport_into_arcade_console(var_1);
      var_2 = scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::get_active_moving_target_based_on_priority();
      if(isDefined(var_2)) {
        level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_2);
      }
    }
  }
}

deactivate_platforms() {
  level notify("stop_GnS_platforms");
  var_0 = ["blue", "red", "green", "yellow"];
  foreach(var_2 in var_0) {
    var_3 = getent(var_2 + "_platform", "targetname");
    var_4 = getent(var_2 + "_platform_trigger", "targetname");
    var_3.origin = var_3.var_C725;
    var_4.origin = var_4.var_C725;
  }
}

activate_platform_color(var_0, var_1) {
  level endon("game_ended");
  level endon("stop_GnS_platforms");
  var_2 = 48;
  var_3 = 32;
  var_4 = 64;
  var_5 = getent(var_0 + "_platform", "targetname");
  var_6 = getent(var_0 + "_platform_trigger", "targetname");
  var_5.origin = var_5.var_C725;
  var_6.origin = var_6.var_C725;
  var_7 = var_4 * scripts\engine\utility::ter_op(randomintrange(0, 100) > 5, 1, -1);
  var_8 = randomfloatrange(var_3, var_2);
  var_9 = var_4 / var_8;
  if(var_1 == "up_down") {
    var_5 moveto(var_5.origin + (0, 0, var_7), var_9);
    var_5 waittill("movedone");
    for(;;) {
      var_5 moveto(var_5.origin + (0, 0, var_7 * -2), var_9);
      var_5 waittill("movedone");
      var_5 moveto(var_5.origin + (0, 0, var_7 * 2), var_9);
      var_5 waittill("movedone");
    }

    return;
  }

  var_5 moveto(var_5.origin + (0, var_7, 0), var_9);
  var_5 waittill("movedone");
  for(;;) {
    var_5 moveto(var_5.origin + (0, var_7 * -2, 0), var_9);
    var_5 waittill("movedone");
    var_5 moveto(var_5.origin + (0, var_7 * 2, 0), var_9);
    var_5 waittill("movedone");
  }
}

change_cube_color(var_0, var_1) {
  var_0.color = var_1;
  var_0 setscriptablepartstate("cube", var_1);
}

town_get_fake_ghost_model_func(var_0) {
  return "fake_zombie_ghost_cube_" + var_0;
}

reveal_moving_target_color(var_0) {
  var_0 setModel("zmb_pixel_skull");
  var_0.revealed = 1;
  var_0 setscriptablepartstate("skull_vfx", var_0.color);
}

set_allow_skulls_to_explode(var_0) {
  level.allow_skulls_to_explode = var_0;
}

get_moving_targets_in_same_subgroup(var_0) {
  var_1 = [];
  foreach(var_3 in level.moving_target_groups) {
    foreach(var_5 in var_3) {
      if(isDefined(var_5) && var_5.subgroup == var_0) {
        var_1[var_1.size] = var_5;
      }
    }
  }

  return var_1;
}

all_moving_targets_are_revealed(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.revealed == 0) {
      return 0;
    }
  }

  return 1;
}

explode_moving_targets(var_0, var_1) {
  var_2 = 1;
  var_3 = get_vfx_start_moving_target(var_0);
  foreach(var_5 in var_0) {
    if(var_5 == var_3) {
      var_5 thread delay_moving_target_explode(var_5, var_1, var_2);
      continue;
    }

    var_5 thread delay_moving_target_explode(var_5, var_1, var_2, var_3);
  }
}

get_vfx_start_moving_target(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::istrue(var_2.vfx_start)) {
      return var_2;
    }
  }
}

delay_moving_target_explode(var_0, var_1, var_2, var_3) {
  play_combo_arc_vfx(var_0, var_2, var_3);
  playFX(level._effect["ghost_explosion_death_" + var_0.color], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  scripts\aitypes\zombie_ghost\behaviors::remove_moving_target_default(var_0, var_1);
}

play_combo_arc_vfx(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = int(var_1 * 20);
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = var_2.origin;
      var_6 = var_0.origin;
      var_7 = var_6 - var_5;
      var_8 = vectortoangles(var_7);
      playfxbetweenpoints(level._effect["combo_arc_" + var_0.color], var_5, var_8, var_6);
      scripts\engine\utility::waitframe();
    }

    return;
  }

  wait(var_1);
}

adjust_player_exit_gns_pos() {
  level endon("game_ended");
  wait(5);
  var_0 = scripts\engine\utility::getstructarray("ghost_wave_player_end", "targetname");
  foreach(var_2 in var_0) {
    if(var_2.origin == (-743, 2620, 906)) {
      var_2.origin = (-745, 2620, 906);
      var_2.angles = (0, 345, 0);
      continue;
    }

    if(var_2.origin == (-743, 2572, 906)) {
      var_2.origin = (-771, 2598, 906);
      var_2.angles = (0, 15, 0);
      continue;
    }

    if(var_2.origin == (-743, 2596, 906)) {
      var_2.origin = (-784, 2621, 906);
      var_2.angles = (0, 355, 0);
    }
  }
}

adjust_mahjong_pick_up_pos() {
  level endon("game_ended");
  wait(5);
  var_0 = scripts\engine\utility::getstructarray("sb_mahjong_tile", "targetname");
  foreach(var_2 in var_0) {
    if(var_2.origin == (1393, 816, 801)) {
      var_2.origin = (1040, 568, 790.6);
      var_2.angles = (7, 135, -1);
    }
  }
}

reactivate_skullbuster_cabinet() {
  if(!scripts\cp\zombies\zombie_quest::quest_line_exist("reactivateghost")) {
    var_0 = getomnvar("zm_num_ghost_n_skull_coin");
    if(isDefined(var_0) && var_0 < 5) {
      return;
    }

    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 0, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet, ::shoot_the_machine, ::complete_shoot_the_machine, ::debug_shoot_the_machine);
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 1, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("reactivateghost");
}

init_weeping_angels_note() {
  var_0 = scripts\engine\utility::getstructarray("weeping_angels_struct", "script_noteworthy");
  level.weeping_angels_note = [];
  foreach(var_4, var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin + (0, 0, 0.05));
    var_3.angles = var_2.angles;
    var_3 setModel("cp_town_paper_note_02");
    var_3 setCanDamage(1);
    var_3.maxhealth = 5;
    var_3.health = 5;
    if(isDefined(var_3)) {
      var_2.model = var_3;
    }

    var_2.model hide();
    level.weeping_angels_note[var_4] = var_2;
  }
}

watch_for_damage_on_struct() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self.model waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(!isplayer(var_1)) {
      continue;
    }

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!scripts\engine\utility::istrue(level.completed_cipher)) {
      continue;
    }

    if(isDefined(var_4) && var_4 != "MOD_MELEE") {
      continue;
    }

    playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_3);
    var_1 playlocalsound("part_pickup");
    self.model delete();
    level notify("weeping_angels_note_read");
  }
}

init() {
  var_0 = spawnStruct();
  var_0.timeout = 40;
  var_0.lifespan = 40;
  var_0.pow = &"COOP_CRAFTABLES_PICKUP";
  var_0.placestring = &"COOP_CRAFTABLES_PLACE";
  var_0.cannotplacestring = &"COOP_CRAFTABLES_CANNOT_PLACE";
  var_0.placecancelablestring = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
  var_0.var_74BF = &"ZOMBIE_CRAFTING_SOUVENIRS_DETONATE";
  var_0.var_9F43 = 0;
  var_0.placementheighttolerance = 30;
  var_0.placementradius = 16;
  var_0.carriedtrapoffset = (0, 0, 35);
  var_0.carriedtrapangles = (0, -90, 0);
  var_0.modelbase = "cp_town_radiation_extractor";
  var_0.modelplacement = "cp_town_radiation_extractor";
  var_0.modelplacementfailed = "cp_town_radiation_extractor";
  level.rad_extractor_settings = [];
  level.rad_extractor_settings["crafted_rad_extractor"] = var_0;
}

give_crafted_medusa(var_0, var_1) {
  var_1.itemtype = "crafted_rad_extractor";
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_rad_extractor");
  var_1 setclientomnvar("zom_crafted_weapon", 3);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_rad_extractor", ::give_crafted_medusa, var_1);
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

shootturret(var_0, var_1) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessage("msg_power_hint");
  var_2 = func_49E8(self);
  scripts\cp\utility::remove_player_perks();
  self.carriedsentry = var_2;
  var_3 = setcarryingims(var_2, var_0, var_1);
  self.carriedsentry = undefined;
  thread scripts\cp\utility::wait_restore_player_perk();
  self.iscarrying = 0;
  if(isDefined(var_2)) {
    return 1;
  }

  return 0;
}

setcarryingims(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  var_0 func_B543(self, var_1);
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
    var_4 = scripts\engine\utility::waittill_any_return("place_medusa", "cancel_medusa", "force_cancel_placement");
    if(!isDefined(var_0)) {
      scripts\engine\utility::allow_weapon(1);
      return 1;
    }

    if(!isDefined(var_4)) {
      var_4 = "force_cancel_placement";
    }

    if(var_4 == "cancel_medusa" || var_4 == "force_cancel_placement") {
      if(!var_1 && var_4 == "cancel_medusa") {
        continue;
      }

      scripts\engine\utility::allow_weapon(1);
      var_0 func_B542();
      if(var_4 != "force_cancel_placement") {
        thread watch_dpad();
      } else if(var_1) {
        scripts\cp\utility::remove_crafted_item_from_inventory(self);
      }

      return 0;
    }

    if(!var_0.canbeplaced) {
      continue;
    }

    if(var_1) {
      scripts\cp\utility::remove_crafted_item_from_inventory(self);
    }

    var_0 func_B545(var_2, undefined, self);
    scripts\engine\utility::allow_weapon(1);
    return 1;
  }
}

func_49E8(var_0) {
  var_1 = spawnturret("misc_turret", var_0.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = var_0.angles;
  var_1.triggerportableradarping = var_0;
  var_1.name = "crafted_rad_extractor";
  var_1 hide();
  var_1.carriedmedusa = spawn("script_model", var_1.origin + (0, 0, 25));
  var_1.carriedmedusa setModel(level.rad_extractor_settings["crafted_rad_extractor"].modelbase);
  var_1 getvalidattachments();
  var_1 setturretmodechangewait(1);
  var_1 give_player_session_tokens("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(var_0);
  var_1 func_B53F(var_0);
  return var_1;
}

func_B53F(var_0) {
  self.canbeplaced = 1;
  func_B544();
}

func_B53C(var_0) {
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
    self waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_0.iscarrying)) {
      continue;
    }

    var_0 thread shootturret(0, self.lifespan);
    self playSound("trap_medusa_pickup");
    scripts\cp\utility::removefromtraplist();
    self delete();
  }
}

func_B545(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin + (0, 0, 0));
  var_3.angles = self.angles;
  var_3.name = "crafted_rad_extractor";
  self.carriedmedusa delete();
  var_3 solid();
  if(!isDefined(var_2.var_B546)) {
    var_2.var_B546 = 1;
  }

  var_4 = "cp_town_radiation_extractor";
  var_3 setModel(var_4);
  var_3 setCanDamage(1);
  var_3.health = 5;
  var_3.maxhealth = 5;
  var_3.lifespan = 40;
  self.carriedby getrigindexfromarchetyperef();
  self.carriedby = undefined;
  var_2.iscarrying = 0;
  var_3.triggerportableradarping = var_2;
  if(ispointinvolume(var_3.origin, level.pool_placement_volume)) {
    level thread radiation_extractor_after_pool_part(var_3.origin);
    level.pool_extraction_fx = spawnfx(level._effect["pool_radiation"], var_3.origin + (0, 0, 3));
    triggerfx(level.pool_extraction_fx);
    level notify("placed_extractor_in_pool");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(level.radiation_extraction_interaction);
    level.medusa_after_placed = var_3;
    func_B544();
  } else {
    var_3 thread func_B541(var_0);
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

func_B543(var_0, var_1) {
  self setModel(level.rad_extractor_settings["crafted_rad_extractor"].modelplacement);
  self setsentrycarrier(var_0);
  self setCanDamage(0);
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  if(var_1) {
    self.firstplacement = 1;
  }

  var_0 thread scripts\cp\utility::update_trap_placement_internal(self, self.carriedmedusa, level.rad_extractor_settings["crafted_rad_extractor"]);
  thread scripts\cp\utility::item_oncarrierdeath(var_0);
  thread scripts\cp\utility::item_oncarrierdisconnect(var_0);
  thread scripts\cp\utility::item_ongameended(var_0);
  func_B544();
  self notify("carried");
}

func_B541(var_0, var_1) {
  self setcursorhint("HINT_NOICON");
  self sethintstring(level.rad_extractor_settings["crafted_rad_extractor"].pow);
  self makeusable();
  self _meth_84A7("tag_fx");
  self setusefov(120);
  self setuserange(96);
  thread medusa_watch_for_player_melee(self.triggerportableradarping);
  thread func_B53C(self.triggerportableradarping);
  thread scripts\cp\utility::item_handleownerdisconnect("medusa_handleOwner");
  thread scripts\cp\utility::item_timeout(var_0, level.rad_extractor_settings["crafted_rad_extractor"].timeout);
  thread func_B53D();
  scripts\cp\utility::addtotraplist();
}

medusa_watch_for_player_melee(var_0) {
  self.health = 5;
  self.maxhealth = 5;
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(!isplayer(var_2)) {
      continue;
    }

    if(var_2 != var_0) {
      continue;
    }

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(var_5) && var_5 != "MOD_MELEE") {
      self.health = 5;
      self.maxhealth = 5;
      var_2 playlocalsound("perk_machine_deny");
      continue;
    }

    if(!scripts\engine\utility::istrue(var_2.triggered_rad_extractor_device)) {
      var_2.triggered_rad_extractor_device = 1;
      self.health = 5;
      self.maxhealth = 5;
      var_2 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_2);
    }
  }
}

func_B544() {
  self makeunusable();
  scripts\cp\utility::removefromtraplist();
}

give_crafted_rad_extractor(var_0, var_1) {
  var_1 thread watch_dpad();
  var_1 notify("new_power", "crafted_rad_extractor");
  var_1 setclientomnvar("zom_crafted_weapon", 16);
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\utility::set_crafted_inventory_item("crafted_rad_extractor", ::give_crafted_rad_extractor, var_1);
}

radiation_extractor_after_pool_part(var_0) {
  level.radiation_extraction_interaction.origin = var_0;
  level.radiation_extractor.origin = var_0;
  playFX(scripts\engine\utility::getfx("hidden_figure_death"), var_0);
  scripts\engine\utility::play_sound_in_space("part_pickup", var_0);
  scripts\cp\cp_interaction::add_to_current_interaction_list(level.radiation_extraction_interaction);
}

removememorystructonconnect(var_0) {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_1);
    var_1 thread removememorystructswhenvalid(var_0, var_1);
  }
}

removememorystructswhenvalid(var_0, var_1) {
  while(!isDefined(var_1.disabled_interactions)) {
    scripts\engine\utility::waitframe();
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  var_1 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_1);
}

setup_hidden_figure_models(var_0, var_1) {
  scripts\cp\maps\cp_town\cp_town::addtopersonalinteractionlist(var_0);
  switch (var_1) {
    case "figure_4":
    case "figure_3":
    case "figure_2":
    case "figure_1":
      var_0.shot_by_player = 0;
      var_0.player_who_shot_figure = undefined;
      break;
  }
}

mem_object_hint(var_0, var_1) {
  return "";
}

mem_object_func(var_0, var_1) {}

activatefiguredamage(var_0, var_1, var_2) {
  level notify(var_0.script_noteworthy + "_" + var_1.name);
  level endon(var_0.script_noteworthy + "_" + var_1.name);
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  level endon("end_hidden_figures_sequence_for_" + var_1.name);
  var_2 endon("p_ent_reset");
  if(!isDefined(var_2)) {
    return;
  }

  var_2.health = 5;
  var_2.maxhealth = 5;
  var_2 setCanDamage(1);
  var_2 endon("end_thread_for_" + var_2.model);
  for(;;) {
    var_2 waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C);
    if(!isplayer(var_4)) {
      continue;
    }

    if(var_4 != var_1) {
      continue;
    }

    if(!var_4 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.got_hit_by_player)) {
      continue;
    }

    if(var_2.health < 0) {
      var_2.health = 5;
      var_2.maxhealth = 5;
      var_2 setscriptablepartstate("figure_effect", "death");
      level thread scripts\engine\utility::play_sound_in_space("town_kill_black_ghost_success", var_6);
      var_2.got_hit_by_player = 1;
      if(isDefined(var_4.hidden_figures_hit)) {
        var_4.hidden_figures_hit++;
        if(var_4.hidden_figures_hit >= 4) {
          var_4 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_4);
        }
      }

      var_2 hidefromplayer(var_4);
      var_2 notify("end_thread_for_" + var_2.model);
    }
  }
}

showhiddenfigurestoplayer(var_0, var_1, var_2, var_3) {
  var_3 notify("one_instance_of_" + var_1.script_noteworthy + "_for_" + var_3.name);
  var_3 endon("one_instance_of_" + var_1.script_noteworthy + "_for_" + var_3.name);
  var_3 endon("death");
  var_3 endon("disconnect");
  level endon("game_ended");
  level endon("end_hidden_figures_sequence_for_" + var_3.name);
  if(!isDefined(var_3.vo_prefix)) {
    return;
  }

  if(!isDefined(var_1.script_noteworthy)) {
    return;
  }

  if(!scripts\engine\utility::istrue(var_3.triggered_rad_extractor_device)) {
    return;
  }

  var_4 = 0.5;
  var_5 = 10000;
  if(scripts\engine\utility::istrue(var_3.inside_slow_sphere)) {
    var_4 = 1.5;
    var_5 = -25536;
  }

  var_6 = [];
  var_7 = gettime();
  var_0.got_hit_by_player = 0;
  thread activatefiguredamage(var_1, var_3, var_0);
  var_0 showtoplayer(var_3);
  while(gettime() <= var_7 + var_5) {
    var_8 = randomintrange(-200, 200);
    var_9 = randomintrange(-200, 200);
    var_0A = randomintrange(90, 200);
    var_3.figure_one_offset = (var_8, var_9, var_0A);
    var_0B = randomintrange(-200, 200);
    var_0C = randomintrange(-200, 200);
    var_0D = randomintrange(90, 200);
    var_3.figure_two_offset = (var_0B, var_0C, var_0D);
    var_0E = randomintrange(-200, 200);
    var_0F = randomintrange(-200, 200);
    var_10 = randomintrange(90, 200);
    var_3.figure_three_offset = (var_0E, var_0F, var_10);
    var_11 = randomintrange(-200, 200);
    var_12 = randomintrange(-200, 200);
    var_13 = randomintrange(90, 200);
    var_3.figure_four_offset = (var_11, var_12, var_13);
    switch (var_1.script_noteworthy) {
      case "figure_1":
        var_1.playeroffset[var_3.name] = var_3.origin + var_3.figure_one_offset;
        var_0 setModel("tag_origin_hidden_figure");
        var_0 setscriptablepartstate("figure_effect", "active");
        var_0.origin = var_3.origin + var_3.figure_one_offset;
        break;

      case "figure_2":
        var_1.playeroffset[var_3.name] = var_3.origin + var_3.figure_two_offset;
        var_0 setModel("tag_origin_hidden_figure");
        var_0 setscriptablepartstate("figure_effect", "active");
        var_0.origin = var_3.origin + var_3.figure_two_offset;
        break;

      case "figure_3":
        var_1.playeroffset[var_3.name] = var_3.origin + var_3.figure_three_offset;
        var_0 setModel("tag_origin_hidden_figure");
        var_0 setscriptablepartstate("figure_effect", "active");
        var_0.origin = var_3.origin + var_3.figure_three_offset;
        break;

      case "figure_4":
        var_1.playeroffset[var_3.name] = var_3.origin + var_3.figure_four_offset;
        var_0 setModel("tag_origin_hidden_figure");
        var_0 setscriptablepartstate("figure_effect", "active");
        var_0.origin = var_3.origin + var_3.figure_four_offset;
        break;
    }

    if(int(distance(var_0.origin, var_3.origin)) <= 120) {
      var_3 dodamage(int(var_3.health / 4), var_3.origin);
    }

    var_0.angles = vectortoangles(var_3.origin - var_0.origin);
    var_1.model = var_0;
    wait(var_4);
  }

  var_0 setscriptablepartstate("figure_effect", "neutral");
  scripts\engine\utility::waitframe();
  var_0 setscriptablepartstate("figure_effect", "death");
  var_3.triggered_rad_extractor_device = 0;
  level notify("end_hidden_figures_sequence_for_" + var_3.name);
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
  var_0 = scripts\engine\utility::getstructarray("figure_1", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, "figure_1");
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
  var_0 = scripts\engine\utility::getstructarray("figure_2", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, "figure_2");
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
  var_0 = scripts\engine\utility::getstructarray("figure_3", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, "figure_3");
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
  var_0 = scripts\engine\utility::getstructarray("figure_4", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_hidden_figure_models(var_2, "figure_4");
  }
}