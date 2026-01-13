/**************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_ghost_activation.gsc
**************************************************************/

init_ghost_n_skull_quest() {
  scripts\cp\zombies\zombie_quest::register_quest_step("ghost", 0, ::blank, ::pop_all_balloons_in_beginning_area, ::complete_pop_all_balloons_in_beginning_area, ::debug_pop_all_balloons_in_beginning_area);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghost", 1, ::blank, ::spell_the_word_ghost, ::complete_spell_the_word_ghost, ::debug_spell_the_word_ghost);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghost", 2, ::blank, ::get_1_9_8_4_kills_on_dance_floor, ::complete_get_1_9_8_4_kills_on_dance_floor, ::debug_get_1_9_8_4_kills_on_dance_floor);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghost", 3, ::blank, ::play_arcade_games_and_make_critical_shot, ::complete_play_arcade_games_and_make_critical_shot, ::debug_play_arcade_games_and_make_critical_shot);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghost", 4, ::blank, ::hit_the_floating_skull_with_spaceland_laser, ::complete_hit_the_floating_skull_with_spaceland_laser, ::debug_hit_the_floating_skull_with_spaceland_laser);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghost", 5, ::blank, ::brute_hit_arcade_cabinet_with_laser, ::complete_brute_hit_arcade_cabinet_with_laser, ::debug_brute_hit_arcade_cabinet_with_laser);
  scripts\cp\zombies\zombie_quest::register_quest_step("ghost", 6, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
}

blank() {}

pop_all_balloons_in_beginning_area() {
  wait(3);
  var_0 = getscriptablearray("beginning_area_balloons", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread balloon_pop_monitor(var_2);
  }

  for(var_4 = var_0.size; var_4 > 0; var_4--) {
    level waittill("balloon_popped");
  }

  scripts\cp\zombies\zombie_analytics::log_balloons_popped(level.wave_num);
}

balloon_pop_monitor(var_0) {
  var_0 setnonstick(1);
  var_0 waittill("scriptableNotification");
  level notify("balloon_popped");
}

complete_pop_all_balloons_in_beginning_area() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(1);
}

debug_pop_all_balloons_in_beginning_area() {}

shoot_ice_monster_eye_during_coaster_ride() {
  level thread coaster_monitor();
  level waittill("got_all_ice_monster_eyes");
}

coaster_monitor() {
  level endon("got_all_ice_monster_eyes");
  for(;;) {
    level waittill("coaster_started", var_0);
    var_0 thread shoot_ice_monster_eyes_monitor(var_0);
    var_0 waittill("ride_finished");
  }
}

shoot_ice_monster_eyes_monitor(var_0) {
  var_0 endon("ride_finished");
  var_1 = wait_for_8bitskull_damage("polar_peak_ride_ice_monster_1_eye", var_0, 25);
  if(!var_1) {
    return;
  }

  var_2 = wait_for_8bitskull_damage("polar_peak_ride_ice_monster_2_eye", var_0, 40);
  if(!var_2) {
    return;
  }

  var_3 = wait_for_8bitskull_damage("polar_peak_ride_ice_monster_3_eye", var_0, 40);
  if(!var_3) {
    return;
  }

  level notify("got_all_ice_monster_eyes");
}

wait_for_8bitskull_damage(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  var_4 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_5 = spawnfx(level._effect["skull_target"], var_4.origin, anglesToForward(var_4.angles), anglestoup(var_4.angles));
  var_3 thread eye_damage_monitor(var_3, var_1);
  wait(2);
  triggerfx(var_5);
  var_6 = var_3 scripts\engine\utility::waittill_any_timeout_1(var_2, "got_one_ice_monster_eye");
  if(var_6 == "timeout") {
    var_5 delete();
    return 0;
  } else {
    playFX(level._effect["pickup"], var_5.origin);
    var_5 delete();
    return 1;
  }

  return 0;
}

eye_damage_monitor(var_0, var_1) {
  var_0 endon("got_one_ice_monster_eye");
  var_1 endon("ride_finished");
  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
    if(isDefined(var_3) && scripts\engine\utility::istrue(var_3.linked_to_coaster)) {
      var_3 scripts\cp\cp_damage::updatedamagefeedback("standard");
      var_3 playlocalsound("ghosts_8bit_target_explo");
      break;
    }
  }

  var_0 notify("got_one_ice_monster_eye");
}

complete_shoot_ice_monster_eye_during_coaster_ride() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

debug_shoot_ice_monster_eye_during_coaster_ride() {}

spell_the_word_ghost() {
  level endon("spelled_the_word_ghost");
  var_0 = getent("ghost_activation_letters_trigger", "targetname");
  var_0 delete();
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("zmb_8_bit_price");
  var_1 dontinterpolate();
  var_2 = [[(3930, 308, 336), (0, 180, 0)],
    [(2379, 1247, 302), (0, 180, 0)]];
  var_3 = [[(-3530, 650, 676), (0, 360, 0)],
    [(-651, -946, 625), (0, 0, 0)]];
  var_4 = [[(-2675, -2532, 524), (0, 90, 0)],
    [(1276, 719, 203), (0, 180, 0)]];
  var_5 = [[(3791, -602, 368), (0, 15, 0)],
    [(3602, 2189, 387), (0, 225, 0)]];
  var_6 = [[(-1047, 1084, 408), (0, 180, 0)],
    [(-1467, -307, 548), (0, 180, 0)]];
  require_player_look_at_skull(var_1, scripts\engine\utility::random(var_2));
  require_player_look_at_skull(var_1, scripts\engine\utility::random(var_3));
  require_player_look_at_skull(var_1, scripts\engine\utility::random(var_4));
  require_player_look_at_skull(var_1, scripts\engine\utility::random(var_5));
  require_player_look_at_skull(var_1, scripts\engine\utility::random(var_6));
  var_1 delete();
}

require_player_look_at_skull(var_0, var_1) {
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_0.origin = var_2;
  var_0.angles = var_3;
  var_4 = int(15);
  for(;;) {
    if(any_player_look_at_skull(var_0)) {
      for(var_5 = 1; var_5 <= var_4; var_5++) {
        wait(0.1);
        if(any_player_look_at_skull(var_0)) {
          if(var_5 == var_4) {
            playFX(level._effect["skull_discovered"], var_2, anglesToForward(var_3), anglestoup(var_3));
            return;
          }

          continue;
        } else {
          break;
        }
      }
    }

    wait(0.1);
  }
}

any_player_look_at_skull(var_0) {
  foreach(var_2 in level.players) {
    if(player_look_at_skull(var_0, var_2)) {
      return 1;
    }
  }

  return 0;
}

player_look_at_skull(var_0, var_1) {
  var_2 = 6400;
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

complete_spell_the_word_ghost() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

debug_spell_the_word_ghost() {}

get_1_9_8_4_kills_on_dance_floor() {
  level.onzombiekilledfunc = ::check_kill_on_dance_floor;
  level.kill_order_on_dance_floor = ["green", "blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue", "pink", "pink", "pink", "pink", "pink", "pink", "pink", "pink", "black", "black", "black", "black"];
  level waittill("got_1_9_8_4_kills");
}

check_kill_on_dance_floor(var_0, var_1) {
  if(isDefined(var_0) && isplayer(var_0)) {
    var_2 = get_dance_floor_tile_color(var_0.origin);
    if(is_correct_color(var_2)) {
      update_kill_order_on_dance_floor();
      if(kill_sequence_completed()) {
        level notify("got_1_9_8_4_kills");
        return;
      }
    }
  }
}

is_correct_color(var_0) {
  return isDefined(var_0) && var_0 == level.kill_order_on_dance_floor[0];
}

kill_sequence_completed() {
  return level.kill_order_on_dance_floor.size == 0;
}

update_kill_order_on_dance_floor() {
  var_0 = [];
  for(var_1 = 1; var_1 < level.kill_order_on_dance_floor.size; var_1++) {
    var_0[var_0.size] = level.kill_order_on_dance_floor[var_1];
  }

  level.kill_order_on_dance_floor = var_0;
}

get_dance_floor_tile_color(var_0) {
  var_1 = ["green", "blue", "pink", "black"];
  foreach(var_3 in var_1) {
    var_4 = getEntArray("astrocade_" + var_3 + "_tile", "targetname");
    foreach(var_6 in var_4) {
      if(ispointinvolume(var_0, var_6)) {
        return var_3;
      }
    }
  }

  return undefined;
}

complete_get_1_9_8_4_kills_on_dance_floor() {
  level.onzombiekilledfunc = undefined;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(3);
}

debug_get_1_9_8_4_kills_on_dance_floor() {}

play_arcade_games_and_make_critical_shot() {
  set_up_start_arcade_game_callback();
  var_0 = ["zombie_zoom", "bowling_for_planets", "rings_of_saturn", "cryptid_attack", "black_hole"];
  for(;;) {
    level waittill("beat_arcade_game", var_1);
    var_0 = scripts\engine\utility::array_remove(var_0, var_1);
    if(var_0.size == 0) {
      break;
    }
  }

  level notify("beat_all_arcade_games");
}

arcade_games_performance_monitor() {
  level endon("beat_all_arcade_games");
  for(;;) {
    level waittill("update_arcade_game_performance", var_0, var_1);
    switch (var_0) {
      case "zombie_zoom":
        check_arcade_game_performance_at_most(var_0, var_1, 9900);
        break;

      case "bowling_for_planets":
        check_arcade_game_performance_at_least(var_0, var_1, 150);
        break;

      case "rings_of_saturn":
        check_arcade_game_performance_at_least(var_0, var_1, 60);
        break;

      case "cryptid_attack":
        check_arcade_game_performance_at_least(var_0, var_1, 60);
        break;

      case "black_hole":
        check_arcade_game_performance_at_least(var_0, var_1, 50);
        break;
    }
  }
}

check_arcade_game_performance_at_most(var_0, var_1, var_2) {
  if(var_1 <= var_2) {
    level notify("beat_arcade_game", var_0);
  }
}

check_arcade_game_performance_at_least(var_0, var_1, var_2) {
  if(var_1 >= var_2) {
    level notify("beat_arcade_game", var_0);
  }
}

complete_play_arcade_games_and_make_critical_shot() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(4);
}

debug_play_arcade_games_and_make_critical_shot() {}

set_up_start_arcade_game_callback() {
  level.start_rings_of_saturn_func = ::start_rings_of_saturn;
  level.start_bowling_for_planets_func = ::start_bowling_for_planets;
  level.start_cryptid_attack_func = ::start_cryptid_attack;
  level.start_black_hole_func = ::start_black_hole;
  level.start_zombie_zoom_func = ::start_zombie_zoom;
}

start_rings_of_saturn(var_0, var_1) {
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("spawned");
  var_1 endon("disconnect");
  var_1 endon("bball_timer_expired");
  var_2 = 3;
  var_3 = 4;
  if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    return;
  }

  for(;;) {
    var_4 = 1;
    while(var_4 <= var_2 - 1) {
      var_1 waittill("throw_a_basketball");
      var_5 = var_1 scripts\engine\utility::waittill_any_return("score_a_basket", "ready_to_throw_next_basketball");
      if(var_5 == "ready_to_throw_next_basketball") {
        break;
      }

      if(var_4 == var_2 - 1) {
        var_6 = get_basketball_skull_spawn_info(var_0);
        var_0 thread critical_shot_watcher(var_1, "rings_of_saturn", "score_a_basket", var_3, var_6);
        return;
      }

      var_5++;
    }
  }
}

get_basketball_skull_spawn_info(var_0) {
  var_1 = spawnStruct();
  switch (var_0.script_location) {
    case "zombie_bball_game_3_is_active":
      var_1.pos = (2236, -1062, 216);
      var_1.angles = (0, 315, 0);
      break;

    case "zombie_bball_game_1_is_active":
      var_1.pos = (2129.5, -1165.5, 216);
      var_1.angles = (0, 315, 0);
      break;

    default:
      break;
  }

  return var_1;
}

start_bowling_for_planets(var_0, var_1) {
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("spawned");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_2 = 3;
  var_3 = 3;
  var_4 = [5, 10, 15, 25, 50];
  if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    return;
  }

  var_5 = randomintrange(1, var_2 + 1);
  for(var_6 = 1; var_6 < var_5; var_6++) {
    var_1 waittill("throw_a_bowling_for_planet");
  }

  var_7 = scripts\engine\utility::random(var_4);
  var_8 = get_bowling_skull_spawn_info(var_7);
  var_0 thread critical_shot_watcher(var_1, "bowling_for_planets", "hit_the_target_planet", var_3, var_8);
  var_1 waittill("score_in_bowling_for_planet", var_9);
  if(var_9 == var_7) {
    var_1 notify("hit_the_target_planet");
  }
}

get_bowling_skull_spawn_info(var_0) {
  var_1 = spawnStruct();
  switch (var_0) {
    case 5:
      var_1.pos = (3162, -1875.5, 146.5);
      var_1.angles = (0, 180, 0);
      break;

    case 10:
      var_1.pos = (3162, -1845.5, 144.5);
      var_1.angles = (0, 180, 0);
      break;

    case 15:
      var_1.pos = (3162, -1877.5, 164.5);
      var_1.angles = (0, 180, 0);
      break;

    case 25:
      var_1.pos = (3162, -1844.5, 173.5);
      var_1.angles = (0, 180, 0);
      break;

    case 50:
      var_1.pos = (3162, -1866.5, 174.5);
      var_1.angles = (0, 180, 0);
      break;

    default:
      break;
  }

  return var_1;
}

start_cryptid_attack(var_0, var_1) {
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("spawned");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_2 = 6;
  var_3 = 2;
  if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    return;
  }

  var_4 = randomintrange(1, var_2 + 1);
  for(var_5 = 1; var_5 < var_4; var_5++) {
    var_1 waittill("throw_a_ball_at_cryptid_attack");
  }

  wait(0.5);
  var_6 = scripts\engine\utility::random(var_0.remaining_teeth);
  var_7 = get_cryptid_skull_spawn_info(var_6);
  var_0 thread critical_shot_watcher(var_1, "cryptid_attack", "hit_the_target_tooth", var_3, var_7);
  var_1 waittill("hit_a_cryptid_tooth", var_8);
  if(var_6 == var_8) {
    var_1 notify("hit_the_target_tooth");
  }
}

get_cryptid_skull_spawn_info(var_0) {
  var_1 = spawnStruct();
  switch (int(var_0.origin[0])) {
    case 3279:
      var_1.pos = (3279, -414.5, 298.5);
      var_1.angles = (0, 270, 0);
      break;

    case 3284:
      var_1.pos = (3284, -414.5, 297.5);
      var_1.angles = (0, 270, 0);
      break;

    case 3289:
      var_1.pos = (3289, -414.5, 296.5);
      var_1.angles = (0, 270, 0);
      break;

    case 3294:
      var_1.pos = (3294, -414.5, 296.5);
      var_1.angles = (0, 270, 0);
      break;

    case 3299:
      var_1.pos = (3299, -414.5, 297.5);
      var_1.angles = (0, 270, 0);
      break;

    case 3304:
      var_1.pos = (3304, -414.5, 298.5);
      var_1.angles = (0, 270, 0);
      break;

    default:
      break;
  }

  return var_1;
}

start_black_hole(var_0, var_1) {
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("spawned");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_2 = 3;
  if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    return;
  }

  var_3 = get_black_hole_skull_spawn_info();
  var_0 thread critical_shot_watcher(var_1, "black_hole", "hit_black_hole_50", var_2, var_3);
  var_1 waittill("hit_black_hole", var_4);
  if(var_4 == 50) {
    var_1 notify("hit_black_hole_50");
  }
}

get_black_hole_skull_spawn_info() {
  var_0 = spawnStruct();
  var_0.pos = (2425.5, -421, 262);
  var_0.angles = (279.4, 270, 0);
  return var_0;
}

start_zombie_zoom(var_0, var_1) {
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("spawned");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_2 = 9.9;
  var_3 = 120;
  if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    return;
  }

  var_4 = scripts\engine\utility::random([0.3, 0.4, 0.5, 0.6, 0.7]);
  var_5 = var_3 * var_4;
  var_6 = var_2 * var_4;
  var_7 = get_zombie_zoom_skull_spawn_info(var_0, var_5);
  var_0 thread critical_shot_watcher(var_1, "zombie_zoom", "hit_zombie_zoom_skull", var_6, var_7);
  wait(var_6);
  if(distance2d(var_0.horse.og_origin, var_0.horse.origin) + 2 >= var_5) {
    var_1 notify("hit_zombie_zoom_skull");
  }
}

get_zombie_zoom_skull_spawn_info(var_0, var_1) {
  var_2 = spawnStruct();
  switch (var_0.horse.script_parameters) {
    case "x":
      var_2.pos = var_0.horse.og_origin + (var_1, 0, 0);
      break;

    case "-x":
      var_2.pos = var_0.horse.og_origin + (-1 * var_1, 0, 0);
      break;

    case "y":
      var_2.pos = var_0.horse.og_origin + (0, var_1, 0);
      break;

    case "-y":
      var_2.pos = var_0.horse.og_origin + (0, -1 * var_1, 0);
      break;
  }

  var_2.angles = (0, 270, 0);
  return var_2;
}

critical_shot_watcher(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_4.pos);
  var_5 setModel("zmb_8_bit_price");
  var_5.angles = var_4.angles;
  var_6 = var_0 scripts\engine\utility::waittill_any_timeout_1(var_3, var_2, "arcade_game_over_for_player", "spawned", "disconnect", "bball_timer_expired", "last_stand");
  if(var_6 == var_2) {
    deactivate_start_arcade_game_func(var_1);
    playFX(level._effect["skull_discovered"], var_4.pos, anglesToForward(var_4.angles), anglestoup(var_4.angles));
    level notify("beat_arcade_game", var_1);
  }

  var_5 delete();
}

deactivate_start_arcade_game_func(var_0) {
  switch (var_0) {
    case "rings_of_saturn":
      level.start_rings_of_saturn_func = undefined;
      break;

    case "bowling_for_planets":
      level.start_bowling_for_planets_func = undefined;
      break;

    case "cryptid_attack":
      level.start_cryptid_attack_func = undefined;
      break;

    case "black_hole":
      level.start_black_hole_func = undefined;
      break;

    case "zombie_zoom":
      level.start_zombie_zoom_func = undefined;
      break;

    default:
      break;
  }
}

hit_the_floating_skull_with_spaceland_laser() {
  var_0 = (1007, 621, 901);
  var_1 = "zmb_pixel_skull";
  var_2 = (90, 340, 70);
  var_3 = 10;
  var_4 = 5;
  scripts\engine\utility::flag_wait("ufo_destroyed");
  var_5 = randomintrange(var_4, var_3);
  wait(var_5);
  var_6 = spawn("script_model", var_0);
  var_6 setModel(var_1);
  var_6.angles = var_2;
  var_6 setCanDamage(1);
  var_6.health = 999999;
  var_6 thread movement_logic(var_6);
  var_6 thread visibility_monitor(var_6);
  for(;;) {
    var_6 waittill("damage", var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10);
    var_6.health = var_6.health + var_7;
    if(can_floating_skull_be_destroyed(var_10)) {
      break;
    }
  }

  playFX(level._effect["skull_discovered"], var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));
  var_6 delete();
}

can_floating_skull_be_destroyed(var_0) {
  var_1 = "iw7_spaceland_wmd";
  if(var_0 == var_1 && at_least_one_player_wearing_glasses()) {
    return 1;
  }

  return 0;
}

at_least_one_player_wearing_glasses() {
  foreach(var_1 in level.players) {
    if(scripts\engine\utility::istrue(var_1.wearing_dischord_glasses)) {
      return 1;
    }
  }

  return 0;
}

movement_logic(var_0) {
  var_0 endon("death");
  var_1 = 1.5;
  var_2 = 4.5;
  var_3 = 6;
  var_4 = 120;
  for(;;) {
    for(var_5 = 1; var_5 <= var_3; var_5++) {
      var_0 moveto(var_0.origin - (var_4, 0, 0), var_1);
      wait(var_2);
    }

    for(var_5 = 1; var_5 <= var_3; var_5++) {
      var_0 moveto(var_0.origin + (var_4, 0, 0), var_1);
      wait(var_2);
    }
  }
}

visibility_monitor(var_0) {
  var_0 endon("death");
  foreach(var_2 in level.players) {
    var_0 hidefromplayer(var_2);
  }

  for(;;) {
    foreach(var_2 in level.players) {
      if(scripts\engine\utility::istrue(var_2.wearing_dischord_glasses)) {
        var_0 showtoplayer(var_2);
        var_0 hudoutlineenable(1, 1, 0);
        continue;
      }

      var_0 hidefromplayer(var_2);
    }

    wait(0.25);
  }
}

complete_hit_the_floating_skull_with_spaceland_laser() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(5);
}

debug_hit_the_floating_skull_with_spaceland_laser() {}

brute_hit_arcade_cabinet_with_laser() {
  level endon("brute_laser_hit_cabinet");
  var_0 = getent("ghost_arcade_damage_trigger", "targetname");
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(isDefined(var_2) && isDefined(var_2.agent_type) && var_2.agent_type == "zombie_brute" && isDefined(var_5) && var_5 == "MOD_RIFLE_BULLET") {
      break;
    }
  }
}

complete_brute_hit_arcade_cabinet_with_laser() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(6);
}

debug_brute_hit_arcade_cabinet_with_laser() {}

wait_for_player_activation() {
  level endon("player_debug_activate_cabinet");
  var_0 = disable_arcade_cabinet_next_to_ghost_n_skull();
  var_1 = getent("ghost_arcade_activation_area", "targetname");
  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], (2859, -553, 286));
  triggerfx(level.gns_game_console_vfx);
  var_2 = (2874, -542, 242);
  var_3 = 2500;
  for(;;) {
    var_4 = 1;
    foreach(var_6 in level.players) {
      if(scripts\engine\utility::istrue(var_6.inlaststand)) {
        var_4 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_6.iscarrying)) {
        var_4 = 0;
        break;
      }

      if(distancesquared(var_6.origin, var_2) > var_3) {
        var_4 = 0;
        break;
      }

      if(!var_6 usebuttonpressed()) {
        var_4 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_4) {
      var_4 = 1;
      foreach(var_6 in level.players) {
        if(scripts\engine\utility::istrue(var_6.inlaststand)) {
          var_4 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_6.iscarrying)) {
          var_4 = 0;
          break;
        }

        if(distancesquared(var_6.origin, var_2) > var_3) {
          var_4 = 0;
          break;
        }

        if(!var_6 usebuttonpressed()) {
          var_4 = 0;
          break;
        }
      }
    }

    if(var_4) {
      level.gns_game_console_vfx delete();
      enable_arcade_cabinet_next_to_ghost_n_skull(var_0);
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

disable_arcade_cabinet_next_to_ghost_n_skull() {
  var_0 = get_arcade_interaction_next_to_ghost_n_skull();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  return var_0;
}

enable_arcade_cabinet_next_to_ghost_n_skull(var_0) {
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

get_arcade_interaction_next_to_ghost_n_skull() {
  var_0 = (2829, -538, 241);
  foreach(var_2 in level.current_interaction_structs) {
    if(distancesquared(var_2.origin, var_0) < 100) {
      return var_2;
    }
  }
}

reactive_ghost_n_skull_cabinet() {
  if(!scripts\cp\zombies\zombie_quest::quest_line_exist("reactivateghost")) {
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 0, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet, ::brute_hit_arcade_cabinet_with_laser, ::complete_brute_hit_arcade_cabinet_with_laser, ::debug_brute_hit_arcade_cabinet_with_laser);
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 1, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation);
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("reactivateghost");
}