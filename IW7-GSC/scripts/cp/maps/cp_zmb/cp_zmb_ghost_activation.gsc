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
  var_00 = getscriptablearray("beginning_area_balloons", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread balloon_pop_monitor(var_02);
  }

  for(var_04 = var_00.size; var_04 > 0; var_04--) {
    level waittill("balloon_popped");
  }

  scripts\cp\zombies\zombie_analytics::log_balloons_popped(level.wave_num);
}

balloon_pop_monitor(param_00) {
  param_00 setnonstick(1);
  param_00 waittill("scriptableNotification");
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
    level waittill("coaster_started", var_00);
    var_00 thread shoot_ice_monster_eyes_monitor(var_00);
    var_00 waittill("ride_finished");
  }
}

shoot_ice_monster_eyes_monitor(param_00) {
  param_00 endon("ride_finished");
  var_01 = wait_for_8bitskull_damage("polar_peak_ride_ice_monster_1_eye", param_00, 25);
  if(!var_01) {
    return;
  }

  var_02 = wait_for_8bitskull_damage("polar_peak_ride_ice_monster_2_eye", param_00, 40);
  if(!var_02) {
    return;
  }

  var_03 = wait_for_8bitskull_damage("polar_peak_ride_ice_monster_3_eye", param_00, 40);
  if(!var_03) {
    return;
  }

  level notify("got_all_ice_monster_eyes");
}

wait_for_8bitskull_damage(param_00, param_01, param_02) {
  var_03 = getent(param_00, "targetname");
  var_04 = scripts\engine\utility::getstruct(param_00, "targetname");
  var_05 = spawnfx(level._effect["skull_target"], var_04.origin, anglesToForward(var_04.angles), anglestoup(var_04.angles));
  var_03 thread eye_damage_monitor(var_03, param_01);
  wait(2);
  triggerfx(var_05);
  var_06 = var_03 scripts\engine\utility::waittill_any_timeout_1(param_02, "got_one_ice_monster_eye");
  if(var_06 == "timeout") {
    var_05 delete();
    return 0;
  } else {
    playFX(level._effect["pickup"], var_05.origin);
    var_05 delete();
    return 1;
  }

  return 0;
}

eye_damage_monitor(param_00, param_01) {
  param_00 endon("got_one_ice_monster_eye");
  param_01 endon("ride_finished");
  for(;;) {
    param_00 waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(isDefined(var_03) && scripts\engine\utility::istrue(var_03.linked_to_coaster)) {
      var_03 scripts\cp\cp_damage::updatedamagefeedback("standard");
      var_03 playlocalsound("ghosts_8bit_target_explo");
      break;
    }
  }

  param_00 notify("got_one_ice_monster_eye");
}

complete_shoot_ice_monster_eye_during_coaster_ride() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

debug_shoot_ice_monster_eye_during_coaster_ride() {}

spell_the_word_ghost() {
  level endon("spelled_the_word_ghost");
  var_00 = getent("ghost_activation_letters_trigger", "targetname");
  var_00 delete();
  var_01 = spawn("script_model", (0, 0, 0));
  var_01 setModel("zmb_8_bit_price");
  var_01 dontinterpolate();
  var_02 = [[(3930, 308, 336), (0, 180, 0)],
    [(2379, 1247, 302), (0, 180, 0)]];
  var_03 = [[(-3530, 650, 676), (0, 360, 0)],
    [(-651, -946, 625), (0, 0, 0)]];
  var_04 = [[(-2675, -2532, 524), (0, 90, 0)],
    [(1276, 719, 203), (0, 180, 0)]];
  var_05 = [[(3791, -602, 368), (0, 15, 0)],
    [(3602, 2189, 387), (0, 225, 0)]];
  var_06 = [[(-1047, 1084, 408), (0, 180, 0)],
    [(-1467, -307, 548), (0, 180, 0)]];
  require_player_look_at_skull(var_01, scripts\engine\utility::random(var_02));
  require_player_look_at_skull(var_01, scripts\engine\utility::random(var_03));
  require_player_look_at_skull(var_01, scripts\engine\utility::random(var_04));
  require_player_look_at_skull(var_01, scripts\engine\utility::random(var_05));
  require_player_look_at_skull(var_01, scripts\engine\utility::random(var_06));
  var_01 delete();
}

require_player_look_at_skull(param_00, param_01) {
  var_02 = param_01[0];
  var_03 = param_01[1];
  param_00.origin = var_02;
  param_00.angles = var_03;
  var_04 = int(15);
  for(;;) {
    if(any_player_look_at_skull(param_00)) {
      for(var_05 = 1; var_05 <= var_04; var_05++) {
        wait(0.1);
        if(any_player_look_at_skull(param_00)) {
          if(var_05 == var_04) {
            playFX(level._effect["skull_discovered"], var_02, anglesToForward(var_03), anglestoup(var_03));
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

any_player_look_at_skull(param_00) {
  foreach(var_02 in level.players) {
    if(player_look_at_skull(param_00, var_02)) {
      return 1;
    }
  }

  return 0;
}

player_look_at_skull(param_00, param_01) {
  var_02 = 6400;
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

complete_spell_the_word_ghost() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

debug_spell_the_word_ghost() {}

get_1_9_8_4_kills_on_dance_floor() {
  level.onzombiekilledfunc = ::check_kill_on_dance_floor;
  level.kill_order_on_dance_floor = ["green", "blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue", "pink", "pink", "pink", "pink", "pink", "pink", "pink", "pink", "black", "black", "black", "black"];
  level waittill("got_1_9_8_4_kills");
}

check_kill_on_dance_floor(param_00, param_01) {
  if(isDefined(param_00) && isplayer(param_00)) {
    var_02 = get_dance_floor_tile_color(param_00.origin);
    if(is_correct_color(var_02)) {
      update_kill_order_on_dance_floor();
      if(kill_sequence_completed()) {
        level notify("got_1_9_8_4_kills");
        return;
      }
    }
  }
}

is_correct_color(param_00) {
  return isDefined(param_00) && param_00 == level.kill_order_on_dance_floor[0];
}

kill_sequence_completed() {
  return level.kill_order_on_dance_floor.size == 0;
}

update_kill_order_on_dance_floor() {
  var_00 = [];
  for(var_01 = 1; var_01 < level.kill_order_on_dance_floor.size; var_01++) {
    var_00[var_00.size] = level.kill_order_on_dance_floor[var_01];
  }

  level.kill_order_on_dance_floor = var_00;
}

get_dance_floor_tile_color(param_00) {
  var_01 = ["green", "blue", "pink", "black"];
  foreach(var_03 in var_01) {
    var_04 = getEntArray("astrocade_" + var_03 + "_tile", "targetname");
    foreach(var_06 in var_04) {
      if(ispointinvolume(param_00, var_06)) {
        return var_03;
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
  var_00 = ["zombie_zoom", "bowling_for_planets", "rings_of_saturn", "cryptid_attack", "black_hole"];
  for(;;) {
    level waittill("beat_arcade_game", var_01);
    var_00 = scripts\engine\utility::array_remove(var_00, var_01);
    if(var_00.size == 0) {
      break;
    }
  }

  level notify("beat_all_arcade_games");
}

arcade_games_performance_monitor() {
  level endon("beat_all_arcade_games");
  for(;;) {
    level waittill("update_arcade_game_performance", var_00, var_01);
    switch (var_00) {
      case "zombie_zoom":
        check_arcade_game_performance_at_most(var_00, var_01, 9900);
        break;

      case "bowling_for_planets":
        check_arcade_game_performance_at_least(var_00, var_01, 150);
        break;

      case "rings_of_saturn":
        check_arcade_game_performance_at_least(var_00, var_01, 60);
        break;

      case "cryptid_attack":
        check_arcade_game_performance_at_least(var_00, var_01, 60);
        break;

      case "black_hole":
        check_arcade_game_performance_at_least(var_00, var_01, 50);
        break;
    }
  }
}

check_arcade_game_performance_at_most(param_00, param_01, param_02) {
  if(param_01 <= param_02) {
    level notify("beat_arcade_game", param_00);
  }
}

check_arcade_game_performance_at_least(param_00, param_01, param_02) {
  if(param_01 >= param_02) {
    level notify("beat_arcade_game", param_00);
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

start_rings_of_saturn(param_00, param_01) {
  param_01 endon("arcade_game_over_for_player");
  param_01 endon("spawned");
  param_01 endon("disconnect");
  param_01 endon("bball_timer_expired");
  var_02 = 3;
  var_03 = 4;
  if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    return;
  }

  for(;;) {
    var_04 = 1;
    while(var_04 <= var_02 - 1) {
      param_01 waittill("throw_a_basketball");
      var_05 = param_01 scripts\engine\utility::waittill_any_return("score_a_basket", "ready_to_throw_next_basketball");
      if(var_05 == "ready_to_throw_next_basketball") {
        break;
      }

      if(var_04 == var_02 - 1) {
        var_06 = get_basketball_skull_spawn_info(param_00);
        param_00 thread critical_shot_watcher(param_01, "rings_of_saturn", "score_a_basket", var_03, var_06);
        return;
      }

      var_05++;
    }
  }
}

get_basketball_skull_spawn_info(param_00) {
  var_01 = spawnStruct();
  switch (param_00.script_location) {
    case "zombie_bball_game_3_is_active":
      var_01.pos = (2236, -1062, 216);
      var_01.angles = (0, 315, 0);
      break;

    case "zombie_bball_game_1_is_active":
      var_01.pos = (2129.5, -1165.5, 216);
      var_01.angles = (0, 315, 0);
      break;

    default:
      break;
  }

  return var_01;
}

start_bowling_for_planets(param_00, param_01) {
  param_01 endon("arcade_game_over_for_player");
  param_01 endon("spawned");
  param_01 endon("disconnect");
  param_01 endon("last_stand");
  var_02 = 3;
  var_03 = 3;
  var_04 = [5, 10, 15, 25, 50];
  if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    return;
  }

  var_05 = randomintrange(1, var_02 + 1);
  for(var_06 = 1; var_06 < var_05; var_06++) {
    param_01 waittill("throw_a_bowling_for_planet");
  }

  var_07 = scripts\engine\utility::random(var_04);
  var_08 = get_bowling_skull_spawn_info(var_07);
  param_00 thread critical_shot_watcher(param_01, "bowling_for_planets", "hit_the_target_planet", var_03, var_08);
  param_01 waittill("score_in_bowling_for_planet", var_09);
  if(var_09 == var_07) {
    param_01 notify("hit_the_target_planet");
  }
}

get_bowling_skull_spawn_info(param_00) {
  var_01 = spawnStruct();
  switch (param_00) {
    case 5:
      var_01.pos = (3162, -1875.5, 146.5);
      var_01.angles = (0, 180, 0);
      break;

    case 10:
      var_01.pos = (3162, -1845.5, 144.5);
      var_01.angles = (0, 180, 0);
      break;

    case 15:
      var_01.pos = (3162, -1877.5, 164.5);
      var_01.angles = (0, 180, 0);
      break;

    case 25:
      var_01.pos = (3162, -1844.5, 173.5);
      var_01.angles = (0, 180, 0);
      break;

    case 50:
      var_01.pos = (3162, -1866.5, 174.5);
      var_01.angles = (0, 180, 0);
      break;

    default:
      break;
  }

  return var_01;
}

start_cryptid_attack(param_00, param_01) {
  param_01 endon("arcade_game_over_for_player");
  param_01 endon("spawned");
  param_01 endon("disconnect");
  param_01 endon("last_stand");
  var_02 = 6;
  var_03 = 2;
  if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    return;
  }

  var_04 = randomintrange(1, var_02 + 1);
  for(var_05 = 1; var_05 < var_04; var_05++) {
    param_01 waittill("throw_a_ball_at_cryptid_attack");
  }

  wait(0.5);
  var_06 = scripts\engine\utility::random(param_00.remaining_teeth);
  var_07 = get_cryptid_skull_spawn_info(var_06);
  param_00 thread critical_shot_watcher(param_01, "cryptid_attack", "hit_the_target_tooth", var_03, var_07);
  param_01 waittill("hit_a_cryptid_tooth", var_08);
  if(var_06 == var_08) {
    param_01 notify("hit_the_target_tooth");
  }
}

get_cryptid_skull_spawn_info(param_00) {
  var_01 = spawnStruct();
  switch (int(param_00.origin[0])) {
    case 3279:
      var_01.pos = (3279, -414.5, 298.5);
      var_01.angles = (0, 270, 0);
      break;

    case 3284:
      var_01.pos = (3284, -414.5, 297.5);
      var_01.angles = (0, 270, 0);
      break;

    case 3289:
      var_01.pos = (3289, -414.5, 296.5);
      var_01.angles = (0, 270, 0);
      break;

    case 3294:
      var_01.pos = (3294, -414.5, 296.5);
      var_01.angles = (0, 270, 0);
      break;

    case 3299:
      var_01.pos = (3299, -414.5, 297.5);
      var_01.angles = (0, 270, 0);
      break;

    case 3304:
      var_01.pos = (3304, -414.5, 298.5);
      var_01.angles = (0, 270, 0);
      break;

    default:
      break;
  }

  return var_01;
}

start_black_hole(param_00, param_01) {
  param_01 endon("arcade_game_over_for_player");
  param_01 endon("spawned");
  param_01 endon("disconnect");
  param_01 endon("last_stand");
  var_02 = 3;
  if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    return;
  }

  var_03 = get_black_hole_skull_spawn_info();
  param_00 thread critical_shot_watcher(param_01, "black_hole", "hit_black_hole_50", var_02, var_03);
  param_01 waittill("hit_black_hole", var_04);
  if(var_04 == 50) {
    param_01 notify("hit_black_hole_50");
  }
}

get_black_hole_skull_spawn_info() {
  var_00 = spawnStruct();
  var_00.pos = (2425.5, -421, 262);
  var_00.angles = (279.4, 270, 0);
  return var_00;
}

start_zombie_zoom(param_00, param_01) {
  param_01 endon("arcade_game_over_for_player");
  param_01 endon("spawned");
  param_01 endon("disconnect");
  param_01 endon("last_stand");
  var_02 = 9.9;
  var_03 = 120;
  if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    return;
  }

  var_04 = scripts\engine\utility::random([0.3, 0.4, 0.5, 0.6, 0.7]);
  var_05 = var_03 * var_04;
  var_06 = var_02 * var_04;
  var_07 = get_zombie_zoom_skull_spawn_info(param_00, var_05);
  param_00 thread critical_shot_watcher(param_01, "zombie_zoom", "hit_zombie_zoom_skull", var_06, var_07);
  wait(var_06);
  if(distance2d(param_00.horse.og_origin, param_00.horse.origin) + 2 >= var_05) {
    param_01 notify("hit_zombie_zoom_skull");
  }
}

get_zombie_zoom_skull_spawn_info(param_00, param_01) {
  var_02 = spawnStruct();
  switch (param_00.horse.script_parameters) {
    case "x":
      var_02.pos = param_00.horse.og_origin + (param_01, 0, 0);
      break;

    case "-x":
      var_02.pos = param_00.horse.og_origin + (-1 * param_01, 0, 0);
      break;

    case "y":
      var_02.pos = param_00.horse.og_origin + (0, param_01, 0);
      break;

    case "-y":
      var_02.pos = param_00.horse.og_origin + (0, -1 * param_01, 0);
      break;
  }

  var_02.angles = (0, 270, 0);
  return var_02;
}

critical_shot_watcher(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawn("script_model", param_04.pos);
  var_05 setModel("zmb_8_bit_price");
  var_05.angles = param_04.angles;
  var_06 = param_00 scripts\engine\utility::waittill_any_timeout_1(param_03, param_02, "arcade_game_over_for_player", "spawned", "disconnect", "bball_timer_expired", "last_stand");
  if(var_06 == param_02) {
    deactivate_start_arcade_game_func(param_01);
    playFX(level._effect["skull_discovered"], param_04.pos, anglesToForward(param_04.angles), anglestoup(param_04.angles));
    level notify("beat_arcade_game", param_01);
  }

  var_05 delete();
}

deactivate_start_arcade_game_func(param_00) {
  switch (param_00) {
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
  var_00 = (1007, 621, 901);
  var_01 = "zmb_pixel_skull";
  var_02 = (90, 340, 70);
  var_03 = 10;
  var_04 = 5;
  scripts\engine\utility::flag_wait("ufo_destroyed");
  var_05 = randomintrange(var_04, var_03);
  wait(var_05);
  var_06 = spawn("script_model", var_00);
  var_06 setModel(var_01);
  var_06.angles = var_02;
  var_06 setCanDamage(1);
  var_06.health = 999999;
  var_06 thread movement_logic(var_06);
  var_06 thread visibility_monitor(var_06);
  for(;;) {
    var_06 waittill("damage", var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10);
    var_06.health = var_06.health + var_07;
    if(can_floating_skull_be_destroyed(var_10)) {
      break;
    }
  }

  playFX(level._effect["skull_discovered"], var_06.origin, anglesToForward(var_06.angles), anglestoup(var_06.angles));
  var_06 delete();
}

can_floating_skull_be_destroyed(param_00) {
  var_01 = "iw7_spaceland_wmd";
  if(param_00 == var_01 && at_least_one_player_wearing_glasses()) {
    return 1;
  }

  return 0;
}

at_least_one_player_wearing_glasses() {
  foreach(var_01 in level.players) {
    if(scripts\engine\utility::istrue(var_01.wearing_dischord_glasses)) {
      return 1;
    }
  }

  return 0;
}

movement_logic(param_00) {
  param_00 endon("death");
  var_01 = 1.5;
  var_02 = 4.5;
  var_03 = 6;
  var_04 = 120;
  for(;;) {
    for(var_05 = 1; var_05 <= var_03; var_05++) {
      param_00 moveto(param_00.origin - (var_04, 0, 0), var_01);
      wait(var_02);
    }

    for(var_05 = 1; var_05 <= var_03; var_05++) {
      param_00 moveto(param_00.origin + (var_04, 0, 0), var_01);
      wait(var_02);
    }
  }
}

visibility_monitor(param_00) {
  param_00 endon("death");
  foreach(var_02 in level.players) {
    param_00 hidefromplayer(var_02);
  }

  for(;;) {
    foreach(var_02 in level.players) {
      if(scripts\engine\utility::istrue(var_02.wearing_dischord_glasses)) {
        param_00 showtoplayer(var_02);
        param_00 hudoutlineenable(1, 1, 0);
        continue;
      }

      param_00 hidefromplayer(var_02);
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
  var_00 = getent("ghost_arcade_damage_trigger", "targetname");
  for(;;) {
    var_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(isDefined(var_02) && isDefined(var_02.agent_type) && var_02.agent_type == "zombie_brute" && isDefined(var_05) && var_05 == "MOD_RIFLE_BULLET") {
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
  var_00 = disable_arcade_cabinet_next_to_ghost_n_skull();
  var_01 = getent("ghost_arcade_activation_area", "targetname");
  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], (2859, -553, 286));
  triggerfx(level.gns_game_console_vfx);
  var_02 = (2874, -542, 242);
  var_03 = 2500;
  for(;;) {
    var_04 = 1;
    foreach(var_06 in level.players) {
      if(scripts\engine\utility::istrue(var_06.inlaststand)) {
        var_04 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_06.iscarrying)) {
        var_04 = 0;
        break;
      }

      if(distancesquared(var_06.origin, var_02) > var_03) {
        var_04 = 0;
        break;
      }

      if(!var_06 usebuttonpressed()) {
        var_04 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_04) {
      var_04 = 1;
      foreach(var_06 in level.players) {
        if(scripts\engine\utility::istrue(var_06.inlaststand)) {
          var_04 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_06.iscarrying)) {
          var_04 = 0;
          break;
        }

        if(distancesquared(var_06.origin, var_02) > var_03) {
          var_04 = 0;
          break;
        }

        if(!var_06 usebuttonpressed()) {
          var_04 = 0;
          break;
        }
      }
    }

    if(var_04) {
      level.gns_game_console_vfx delete();
      enable_arcade_cabinet_next_to_ghost_n_skull(var_00);
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
  var_00 = get_arcade_interaction_next_to_ghost_n_skull();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_00);
  return var_00;
}

enable_arcade_cabinet_next_to_ghost_n_skull(param_00) {
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

get_arcade_interaction_next_to_ghost_n_skull() {
  var_00 = (2829, -538, 241);
  foreach(var_02 in level.current_interaction_structs) {
    if(distancesquared(var_02.origin, var_00) < 100) {
      return var_02;
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