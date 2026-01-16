/****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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

wait_for_trap_kills(var_0, var_1) {
  for(;;) {
    level waittill(var_0, var_2);
    if(var_2 == var_1) {
      return;
    }
  }
}

complete_1_9_9_2_kills_from_trap() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(1);
}

debug_1_9_9_2_kills_from_trap() {}

match_the_right_symbol() {
  var_0 = ["c", "e", "p", "w", "z"];
  for(;;) {
    wait_one_wave();
    var_1 = scripts\engine\utility::random(var_0);
    player_look_at_initial_symbol(var_1);
    wait_one_wave();
    var_2 = player_select_one_symbol();
    if(var_2 == var_1) {
      break;
    }
  }
}

player_look_at_initial_symbol(var_0) {
  var_1 = spawn_quest_vfx_symbol((-280, -1483, 440), (0, 270, 45), var_0);
  level.gns_symbol_to_match = var_1;
  wait_for_player_look_at(var_1);
  var_1 thread quest_vfx_fade_out(var_1);
}

player_select_one_symbol() {
  level.gns_quest_letter_symbols = [];
  var_0 = ["c", "e", "p", "w", "z"];
  var_1 = [(2984, 150, 380), (-184, -1328, 76), (-3306, -3040, 184), (-1320, -4748, 360), (-1648, 1119, -58), (-5972, 4600, 330), (1918, -2184, 196), (-3616, 1376, 23), (-2046, -1306, 46), (776, 1432, 261)];
  var_2 = [(0, 330, 90), (0, 0, 90), (0, 168, 90), (0, 240, 90), (0, 225, 90), (0, 11, 90), (0, 150, 90), (0, 205, 90), (0, 220, 90), (0, 0, 90)];
  var_3 = scripts\engine\utility::array_randomize([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  foreach(var_10, var_5 in var_0) {
    var_6 = var_3[var_10];
    var_7 = var_1[var_6];
    var_8 = var_2[var_6];
    var_9 = spawn_quest_vfx_symbol(var_7, var_8, var_5);
    var_9 thread wait_for_selection(var_9);
    level.gns_quest_letter_symbols[level.gns_quest_letter_symbols.size] = var_9;
    scripts\engine\utility::waitframe();
  }

  level waittill("GnS_letter_selected", var_11);
  delete_letter_symbols();
  return var_11;
}

spawn_quest_vfx_symbol(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;
  var_3 setModel("gns_quest_origin");
  var_3 setscriptablepartstate("vfx", var_2);
  var_3.letter = var_2;
  return var_3;
}

wait_for_selection(var_0) {
  var_0 endon("death");
  wait_for_player_look_at(var_0);
  var_0 thread quest_vfx_fade_out(var_0);
  level.gns_quest_letter_symbols = scripts\engine\utility::array_remove(level.gns_quest_letter_symbols, var_0);
  level notify("GnS_letter_selected", var_0.letter);
}

wait_for_player_look_at(var_0) {
  var_1 = int(10);
  for(;;) {
    if(any_player_look_at_target(var_0)) {
      for(var_2 = 1; var_2 <= var_1; var_2++) {
        wait(0.15);
        if(any_player_look_at_target(var_0)) {
          if(var_2 == var_1) {
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

any_player_look_at_target(var_0) {
  foreach(var_2 in level.players) {
    if(player_look_at_target(var_0, var_2)) {
      return 1;
    }
  }

  return 0;
}

player_look_at_target(var_0, var_1) {
  var_2 = 6400;
  if(!scripts\engine\utility::istrue(var_1.rave_mode)) {
    return 0;
  }

  if(!var_1 adsbuttonpressed()) {
    return 0;
  }

  if(!var_1 worldpointinreticle_circle(var_0.origin, 25, 75)) {
    return 0;
  }

  var_3 = bulletTrace(var_1 getEye(), var_0.origin, 0, var_1);
  var_4 = var_3["position"];
  if(distancesquared(var_4, var_0.origin) > var_2) {
    return 0;
  }

  return 1;
}

quest_vfx_fade_out(var_0) {
  var_0 endon("death");
  var_0 setscriptablepartstate("vfx", var_0.letter + "_fade");
  wait(3);
  var_0 delete();
}

complete_match_the_right_symbol() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

delete_letter_symbols() {
  if(isDefined(level.gns_quest_letter_symbols)) {
    foreach(var_1 in level.gns_quest_letter_symbols) {
      if(isDefined(var_1)) {
        var_1 delete();
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
  var_0 = scripts\engine\utility::getstructarray("interaction_knife_throw", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.knife_throw_target.origin);
    var_3.angles = var_2.knife_throw_target.angles;
    var_3 setModel("p7_skulls_bones_head_01");
    var_3 setscriptablepartstate("vfx", "green_eyes");
    var_2.knife_throw_target.skull_target = var_3;
    var_3 hide();
  }
}

clear_skull_on_wheel_of_misfortune() {
  var_0 = scripts\engine\utility::getstructarray("interaction_knife_throw", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.knife_throw_target.skull_target)) {
      var_2.knife_throw_target.skull_target delete();
    }
  }
}

wheel_of_misfortune_start_func(var_0, var_1) {
  var_2 = [(-571, -1582, 122), (-602, -1612, 122), (-579, -1604, 98)];
  var_3 = scripts\engine\utility::random(var_2);
  var_4 = var_0.skull_target;
  var_4.origin = var_3;
  var_4.angles = var_0.angles;
  var_4 linkto(var_0);
  var_5 = randomfloatrange(0.1, 0.7);
  wait(var_5);
  var_4 show();
  var_4 thread damage_monitor(var_4);
  var_6 = var_4 scripts\cp\utility::waittill_any_ents_or_timeout_return(5, var_4, "skull_hit_by_knife", var_1, "arcade_game_over_for_player");
  var_4 hide();
  var_4 unlink();
  if(var_6 == "skull_hit_by_knife") {
    playFX(level._effect["ghost_explosion_death_green"], var_4.origin, anglesToForward(var_4.angles), anglestoup(var_4.angles));
    level notify("hit_GnS_skull_during_wheel_of_misfortune");
    return;
  }

  var_4 notify("timeout");
}

damage_monitor(var_0) {
  var_0 endon("timeout");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;
    if(isplayer(var_2) && isDefined(var_10) && var_10 == "iw7_cpknifethrow_mp") {
      break;
    }
  }

  var_0 notify("skull_hit_by_knife");
}

spell_skull() {
  for(;;) {
    wait_one_wave();
    set_up_characters();
    var_0 = "";
    for(var_1 = 0; var_1 < 5; var_1++) {
      level waittill("gns_character_selected", var_2);
      var_0 = var_0 + var_2;
    }

    if(var_0 == "skull") {
      break;
    }
  }
}

set_up_characters() {
  var_0 = [(2984, 150, 380), (-184, -1328, 76), (-3306, -3040, 184), (-1320, -4748, 360), (-1648, 1119, -58), (-5972, 4600, 330), (1918, -2184, 196), (-3616, 1376, 23), (-2046, -1306, 46), (776, 1432, 261)];
  var_1 = [(0, 330, 90), (0, 0, 90), (0, 168, 90), (0, 240, 90), (0, 225, 90), (0, 11, 90), (0, 150, 90), (0, 205, 90), (0, 220, 90), (0, 0, 90)];
  var_2 = ["s", "k", "u", "l", "l"];
  var_3 = scripts\engine\utility::array_randomize([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
  level.gns_spell_character_ents = [];
  for(var_4 = 0; var_4 < 5; var_4++) {
    var_5 = var_3[var_4];
    var_6 = spawn_quest_vfx_symbol(var_0[var_5], var_1[var_5], var_2[var_4]);
    var_6 thread player_select_monitor(var_6);
    level.gns_spell_character_ents[level.gns_spell_character_ents.size] = var_6;
    scripts\engine\utility::waitframe();
  }
}

player_select_monitor(var_0) {
  var_0 endon("death");
  wait_for_player_look_at(var_0);
  level.gns_spell_character_ents = scripts\engine\utility::array_remove(level.gns_spell_character_ents, var_0);
  level notify("gns_character_selected", var_0.letter);
  var_0 setscriptablepartstate("vfx", var_0.letter + "_fade");
  wait(3);
  var_0 delete();
}

clear_gns_spell_letters() {
  if(isDefined(level.gns_spell_character_ents)) {
    foreach(var_1 in level.gns_spell_character_ents) {
      if(isDefined(var_1)) {
        var_1 delete();
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
  var_0 = [1, 2, 3, 4, 5, 6, 7, 8];
  var_1 = var_0;
  level.skull_destroyed = 0;
  level.escaping_skulls = [];
  for(var_2 = 0; var_2 < 12; var_2++) {
    if(var_2 % 8 == 0) {
      var_1 = scripts\engine\utility::array_randomize(var_0);
    }

    var_3 = var_1[var_2 % 8];
    level thread skull_escape((-2335, 5347, -107) + (146 * var_3, -120 * var_3, 0), 6);
    wait(1);
  }
}

skull_escape(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  level.escaping_skulls[level.escaping_skulls.size] = var_2;
  var_2 endon("death");
  var_2 setModel("zmb_pixel_skull");
  var_2 show_to_boat_players(var_2);
  var_2 thread skull_damage_monitor(var_2);
  var_2 thread color_manager(var_2, var_1);
  var_2.angles = (0, 225, 0);
  var_2 set_skull_color(var_2, "green");
  var_2 moveto(var_0 + (0, 0, 500), var_1);
  var_2 waittill("movedone");
  level notify("skull_escaped");
  level thread clear_escaping_skulls();
}

clear_escaping_skulls() {
  if(isDefined(level.escaping_skulls)) {
    foreach(var_1 in level.escaping_skulls) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

color_manager(var_0, var_1) {
  var_0 endon("death");
  var_0 set_skull_color(var_0, "green");
  wait(var_1 - 2);
  var_0 set_skull_color(var_0, "red");
}

set_skull_color(var_0, var_1) {
  var_0.color = var_1;
  var_0 setscriptablepartstate("skull_vfx", var_1);
}

show_to_boat_players(var_0) {
  var_0 hide();
  foreach(var_2 in level.players) {
    if(scripts\engine\utility::istrue(var_2.linked_to_boat)) {
      var_0 showtoplayer(var_2);
    }
  }
}

exp_vfx_to_boat_player(var_0) {
  foreach(var_2 in level.players) {
    if(scripts\engine\utility::istrue(var_2.linked_to_boat)) {
      playFX(level._effect["ghost_explosion_death_" + var_0.color], var_0.origin, (1, 1, 0), (0, 0, 1), var_2);
    }
  }
}

skull_damage_monitor(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;
    if(!isplayer(var_2)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_2.linked_to_boat)) {
      continue;
    }

    break;
  }

  exp_vfx_to_boat_player(var_0);
  level.skull_destroyed++;
  if(level.skull_destroyed == 12) {
    level notify("shoot_all_escaping_skulls_during_boat_ride");
  }

  var_0 delete();
}

complete_shoot_skull_during_boat() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(5);
}

debug_shoot_skull_during_boat() {}

hit_gns_cabinet_with_ben_franklin() {
  for(;;) {
    level waittill("ben_franklin_lightning_pos", var_0);
    if(var_0[2] > 467) {
      continue;
    }

    if(var_0[2] < 386) {
      continue;
    }

    if(distance2dsquared(var_0, (-275, -1483, 431)) > 484) {
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
  var_0 = (-294, -1469, 396);
  var_1 = 2500;
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
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 0, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet, ::hit_gns_cabinet_with_ben_franklin, ::complete_hit_gns_cabinet_with_ben_franklin, ::debug_hit_gns_cabinet_with_ben_franklin);
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 1, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("reactivateghost");
}