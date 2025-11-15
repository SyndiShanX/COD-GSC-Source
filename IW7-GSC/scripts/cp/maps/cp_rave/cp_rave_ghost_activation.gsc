/****************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_ghost_activation.gsc
****************************************************************/

init_ghost_n_skull_2_quest() {
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostTwo", 0, ::blank, ::get_1_9_9_2_kills_from_trap, ::complete_1_9_9_2_kills_from_trap, ::debug_1_9_9_2_kills_from_trap);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostTwo", 1, ::blank, ::match_the_right_symbol, ::complete_match_the_right_symbol, ::debug_match_the_right_symbol);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostTwo", 2, ::blank, ::hit_skull_at_wheel_of_misfortune, ::complete_hit_skull_at_wheel_of_misfortune, ::debug_hit_skull_at_wheel_of_misfortune);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostTwo", 3, ::blank, ::spell_skull, ::complete_spell_skull, ::debug_spell_skull);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostTwo", 4, ::blank, ::shoot_skull_during_boat, ::complete_shoot_skull_during_boat, ::debug_shoot_skull_during_boat);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostTwo", 5, ::blank, ::hit_gns_cabinet_with_ben_franklin, ::complete_hit_gns_cabinet_with_ben_franklin, ::debug_hit_gns_cabinet_with_ben_franklin);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghostTwo", 6, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
}

blank() {}

get_1_9_9_2_kills_from_trap() {
  wait_for_trap_kills("logswing_trap_kills", 1);
  wait_for_trap_kills("woodchipper_trap_kills", 9);
  wait_for_trap_kills("speaker_trap_kills", 9);
  wait_for_trap_kills("waterfall_trap_kills", 2);
}

wait_for_trap_kills(param_00, param_01) {
  for(;;) {
    level waittill(param_00, var_02);
    if(var_02 == param_01) {
      return;
    }
  }
}

complete_1_9_9_2_kills_from_trap() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(1);
}

debug_1_9_9_2_kills_from_trap() {}

match_the_right_symbol() {
  var_00 = ["c", "e", "p", "w", "z"];
  for(;;) {
    wait_one_wave();
    var_01 = scripts\engine\utility::random(var_00);
    player_look_at_initial_symbol(var_01);
    wait_one_wave();
    var_02 = player_select_one_symbol();
    if(var_02 == var_01) {
      break;
    }
  }
}

player_look_at_initial_symbol(param_00) {
  var_01 = spawn_quest_vfx_symbol((-280, -1483, 440), (0, 270, 45), param_00);
  level.gns_symbol_to_match = var_01;
  wait_for_player_look_at(var_01);
  var_01 thread quest_vfx_fade_out(var_01);
}

player_select_one_symbol() {
  level.gns_quest_letter_symbols = [];
  var_00 = ["c", "e", "p", "w", "z"];
  var_01 = [(2984, 150, 380), (-184, -1328, 76), (-3306, -3040, 184), (-1320, -4748, 360), (-1648, 1119, -58), (-5972, 4600, 330), (1918, -2184, 196), (-3616, 1376, 23), (-2046, -1306, 46), (776, 1432, 261)];
  var_02 = [(0, 330, 90), (0, 0, 90), (0, 168, 90), (0, 240, 90), (0, 225, 90), (0, 11, 90), (0, 150, 90), (0, 205, 90), (0, 220, 90), (0, 0, 90)];
  var_03 = scripts\engine\utility::array_randomize([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  foreach(var_0A, var_05 in var_00) {
    var_06 = var_03[var_0A];
    var_07 = var_01[var_06];
    var_08 = var_02[var_06];
    var_09 = spawn_quest_vfx_symbol(var_07, var_08, var_05);
    var_09 thread wait_for_selection(var_09);
    level.gns_quest_letter_symbols[level.gns_quest_letter_symbols.size] = var_09;
    scripts\engine\utility::waitframe();
  }

  level waittill("GnS_letter_selected", var_0B);
  delete_letter_symbols();
  return var_0B;
}

spawn_quest_vfx_symbol(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_00);
  var_03.angles = param_01;
  var_03 setModel("gns_quest_origin");
  var_03 setscriptablepartstate("vfx", param_02);
  var_03.letter = param_02;
  return var_03;
}

wait_for_selection(param_00) {
  param_00 endon("death");
  wait_for_player_look_at(param_00);
  param_00 thread quest_vfx_fade_out(param_00);
  level.gns_quest_letter_symbols = scripts\engine\utility::array_remove(level.gns_quest_letter_symbols, param_00);
  level notify("GnS_letter_selected", param_00.letter);
}

wait_for_player_look_at(param_00) {
  var_01 = int(10);
  for(;;) {
    if(any_player_look_at_target(param_00)) {
      for(var_02 = 1; var_02 <= var_01; var_02++) {
        wait(0.15);
        if(any_player_look_at_target(param_00)) {
          if(var_02 == var_01) {
            return;
          }

          continue;
        } else {
          break;
        }
      }
    }

    wait(0.15);
  }
}

any_player_look_at_target(param_00) {
  foreach(var_02 in level.players) {
    if(player_look_at_target(param_00, var_02)) {
      return 1;
    }
  }

  return 0;
}

player_look_at_target(param_00, param_01) {
  var_02 = 6400;
  if(!scripts\engine\utility::istrue(param_01.rave_mode)) {
    return 0;
  }

  if(!param_01 adsbuttonpressed()) {
    return 0;
  }

  if(!param_01 worldpointinreticle_circle(param_00.origin, 25, 75)) {
    return 0;
  }

  var_03 = bulletTrace(param_01 getEye(), param_00.origin, 0, param_01);
  var_04 = var_03["position"];
  if(distancesquared(var_04, param_00.origin) > var_02) {
    return 0;
  }

  return 1;
}

quest_vfx_fade_out(param_00) {
  param_00 endon("death");
  param_00 setscriptablepartstate("vfx", param_00.letter + "_fade");
  wait(3);
  param_00 delete();
}

complete_match_the_right_symbol() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

delete_letter_symbols() {
  if(isDefined(level.gns_quest_letter_symbols)) {
    foreach(var_01 in level.gns_quest_letter_symbols) {
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }
  }
}

debug_match_the_right_symbol() {}

wait_one_wave() {
  level waittill("regular_wave_starting");
}

hit_skull_at_wheel_of_misfortune() {
  setup_skull_on_wheel_of_misfortune();
  level.gns_wheel_of_misfortune_start_func = ::wheel_of_misfortune_start_func;
  level waittill("hit_GnS_skull_during_wheel_of_misfortune");
  level.gns_wheel_of_misfortune_start_func = undefined;
}

complete_hit_skull_at_wheel_of_misfortune() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(3);
  clear_skull_on_wheel_of_misfortune();
}

debug_hit_skull_at_wheel_of_misfortune() {}

setup_skull_on_wheel_of_misfortune() {
  var_00 = scripts\engine\utility::getstructarray("interaction_knife_throw", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02.knife_throw_target.origin);
    var_03.angles = var_02.knife_throw_target.angles;
    var_03 setModel("p7_skulls_bones_head_01");
    var_03 setscriptablepartstate("vfx", "green_eyes");
    var_02.knife_throw_target.skull_target = var_03;
    var_03 hide();
  }
}

clear_skull_on_wheel_of_misfortune() {
  var_00 = scripts\engine\utility::getstructarray("interaction_knife_throw", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.knife_throw_target.skull_target)) {
      var_02.knife_throw_target.skull_target delete();
    }
  }
}

wheel_of_misfortune_start_func(param_00, param_01) {
  var_02 = [(-571, -1582, 122), (-602, -1612, 122), (-579, -1604, 98)];
  var_03 = scripts\engine\utility::random(var_02);
  var_04 = param_00.skull_target;
  var_04.origin = var_03;
  var_04.angles = param_00.angles;
  var_04 linkto(param_00);
  var_05 = randomfloatrange(0.1, 0.7);
  wait(var_05);
  var_04 show();
  var_04 thread damage_monitor(var_04);
  var_06 = var_04 scripts\cp\utility::waittill_any_ents_or_timeout_return(5, var_04, "skull_hit_by_knife", param_01, "arcade_game_over_for_player");
  var_04 hide();
  var_04 unlink();
  if(var_06 == "skull_hit_by_knife") {
    playFX(level._effect["ghost_explosion_death_green"], var_04.origin, anglesToForward(var_04.angles), anglestoup(var_04.angles));
    level notify("hit_GnS_skull_during_wheel_of_misfortune");
    return;
  }

  var_04 notify("timeout");
}

damage_monitor(param_00) {
  param_00 endon("timeout");
  param_00 setCanDamage(1);
  param_00.health = 999999;
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    param_00.health = 999999;
    if(isplayer(var_02) && isDefined(var_0A) && var_0A == "iw7_cpknifethrow_mp") {
      break;
    }
  }

  param_00 notify("skull_hit_by_knife");
}

spell_skull() {
  for(;;) {
    wait_one_wave();
    set_up_characters();
    var_00 = "";
    for(var_01 = 0; var_01 < 5; var_01++) {
      level waittill("gns_character_selected", var_02);
      var_00 = var_00 + var_02;
    }

    if(var_00 == "skull") {
      break;
    }
  }
}

set_up_characters() {
  var_00 = [(2984, 150, 380), (-184, -1328, 76), (-3306, -3040, 184), (-1320, -4748, 360), (-1648, 1119, -58), (-5972, 4600, 330), (1918, -2184, 196), (-3616, 1376, 23), (-2046, -1306, 46), (776, 1432, 261)];
  var_01 = [(0, 330, 90), (0, 0, 90), (0, 168, 90), (0, 240, 90), (0, 225, 90), (0, 11, 90), (0, 150, 90), (0, 205, 90), (0, 220, 90), (0, 0, 90)];
  var_02 = ["s", "k", "u", "l", "l"];
  var_03 = scripts\engine\utility::array_randomize([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  level.gns_spell_character_ents = [];
  for(var_04 = 0; var_04 < 5; var_04++) {
    var_05 = var_03[var_04];
    var_06 = spawn_quest_vfx_symbol(var_00[var_05], var_01[var_05], var_02[var_04]);
    var_06 thread player_select_monitor(var_06);
    level.gns_spell_character_ents[level.gns_spell_character_ents.size] = var_06;
    scripts\engine\utility::waitframe();
  }
}

player_select_monitor(param_00) {
  param_00 endon("death");
  wait_for_player_look_at(param_00);
  level.gns_spell_character_ents = scripts\engine\utility::array_remove(level.gns_spell_character_ents, param_00);
  level notify("gns_character_selected", param_00.letter);
  param_00 setscriptablepartstate("vfx", param_00.letter + "_fade");
  wait(3);
  param_00 delete();
}

clear_gns_spell_letters() {
  if(isDefined(level.gns_spell_character_ents)) {
    foreach(var_01 in level.gns_spell_character_ents) {
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }
  }
}

complete_spell_skull() {
  clear_gns_spell_letters();
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(4);
}

debug_spell_skull() {}

shoot_skull_during_boat() {
  level.start_boat_ride_func = ::gns_start_boat_ride_func;
  level waittill("shoot_all_escaping_skulls_during_boat_ride");
  level.start_boat_ride_func = undefined;
}

gns_start_boat_ride_func() {
  wait(12);
  level thread activate_scaping_skulls();
}

activate_scaping_skulls() {
  level endon("skull_escaped");
  var_00 = [1, 2, 3, 4, 5, 6, 7, 8];
  var_01 = var_00;
  level.skull_destroyed = 0;
  level.escaping_skulls = [];
  for(var_02 = 0; var_02 < 12; var_02++) {
    if(var_02 % 8 == 0) {
      var_01 = scripts\engine\utility::array_randomize(var_00);
    }

    var_03 = var_01[var_02 % 8];
    level thread skull_escape((-2335, 5347, -107) + (146 * var_03, -120 * var_03, 0), 6);
    wait(1);
  }
}

skull_escape(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  level.escaping_skulls[level.escaping_skulls.size] = var_02;
  var_02 endon("death");
  var_02 setModel("zmb_pixel_skull");
  var_02 show_to_boat_players(var_02);
  var_02 thread skull_damage_monitor(var_02);
  var_02 thread color_manager(var_02, param_01);
  var_02.angles = (0, 225, 0);
  var_02 set_skull_color(var_02, "green");
  var_02 moveto(param_00 + (0, 0, 500), param_01);
  var_02 waittill("movedone");
  level notify("skull_escaped");
  level thread clear_escaping_skulls();
}

clear_escaping_skulls() {
  if(isDefined(level.escaping_skulls)) {
    foreach(var_01 in level.escaping_skulls) {
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }
  }
}

color_manager(param_00, param_01) {
  param_00 endon("death");
  param_00 set_skull_color(param_00, "green");
  wait(param_01 - 2);
  param_00 set_skull_color(param_00, "red");
}

set_skull_color(param_00, param_01) {
  param_00.color = param_01;
  param_00 setscriptablepartstate("skull_vfx", param_01);
}

show_to_boat_players(param_00) {
  param_00 hide();
  foreach(var_02 in level.players) {
    if(scripts\engine\utility::istrue(var_02.linked_to_boat)) {
      param_00 showtoplayer(var_02);
    }
  }
}

exp_vfx_to_boat_player(param_00) {
  foreach(var_02 in level.players) {
    if(scripts\engine\utility::istrue(var_02.linked_to_boat)) {
      playFX(level._effect["ghost_explosion_death_" + param_00.color], param_00.origin, (1, 1, 0), (0, 0, 1), var_02);
    }
  }
}

skull_damage_monitor(param_00) {
  param_00 endon("death");
  param_00 setCanDamage(1);
  param_00.health = 999999;
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    param_00.health = 999999;
    if(!isplayer(var_02)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_02.linked_to_boat)) {
      continue;
    }

    break;
  }

  exp_vfx_to_boat_player(param_00);
  level.skull_destroyed++;
  if(level.skull_destroyed == 12) {
    level notify("shoot_all_escaping_skulls_during_boat_ride");
  }

  param_00 delete();
}

complete_shoot_skull_during_boat() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(5);
}

debug_shoot_skull_during_boat() {}

hit_gns_cabinet_with_ben_franklin() {
  for(;;) {
    level waittill("ben_franklin_lightning_pos", var_00);
    if(var_00[2] > 467) {
      continue;
    }

    if(var_00[2] < 386) {
      continue;
    }

    if(distance2dsquared(var_00, (-275, -1483, 431)) > 484) {
      continue;
    }

    break;
  }
}

complete_hit_gns_cabinet_with_ben_franklin() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(6);
}

debug_hit_gns_cabinet_with_ben_franklin() {}

wait_for_player_activation() {
  level endon("player_debug_activate_cabinet");
  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], (-282, -1483, 437));
  triggerfx(level.gns_game_console_vfx);
  var_00 = (-294, -1469, 396);
  var_01 = 2500;
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
      level.gns_game_console_vfx delete();
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

reactive_ghost_n_skull_cabinet() {
  if(!scripts\cp\zombies\zombie_quest::quest_line_exist("reactivateghost")) {
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 0, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet, ::hit_gns_cabinet_with_ben_franklin, ::complete_hit_gns_cabinet_with_ben_franklin, ::debug_hit_gns_cabinet_with_ben_franklin);
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 1, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("reactivateghost");
}