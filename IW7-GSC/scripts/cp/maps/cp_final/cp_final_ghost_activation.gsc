/******************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_ghost_activation.gsc
******************************************************************/

init_ghost_n_skull_5_quest() {
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("ghostFive", 0, ::blank, ::blow_up_ghost_box, ::complete_blow_up_ghost_box, ::debug_blow_up_ghost_box, 5, "Blow up Ghost-n-Skull box");
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("ghostFive", 1, ::blank, ::stay_on_pressure_plates, ::complete_stay_on_pressure_plates, ::debug_stay_on_pressure_plates, 5, "Stay at pressure plates");
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("ghostFive", 2, ::blank, ::select_odd_cipher, ::complete_select_odd_cipher, ::debug_select_odd_cipher, 5, "Select odd cipher");
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("ghostFive", 3, ::blank, ::follow_the_light, ::complete_follow_the_light, ::debug_follow_the_light, 5, "Follow the light");
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("ghostFive", 4, ::blank, ::solve_eight_queen, ::complete_solve_eight_queen, ::debug_solve_eight_queen, 5, "Solve eight queen problem");
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("ghostFive", 5, ::blank, ::secret_button_combo, ::complete_secret_button_combo, ::debug_secret_button_combo, 5, "Enter secret button combo");
  scripts\cp\maps\cp_final\cp_final_mpq::finalqueststepregistration("ghostFive", 6, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation, 5, "Wait for player activation");
}

blank() {}

blow_up_ghost_box() {
  var_00 = scripts\engine\utility::getstructarray("ghost_n_skull_box", "script_noteworthy");
  var_01 = scripts\engine\utility::random(var_00);
  set_up_ghost_box(var_01);
  wait_for_explosive_damage(var_01);
  var_02 = box_open_sequence(var_01);
  var_02 thread skull_damage_monitor(var_02);
  var_02 waittill("death");
}

box_open_sequence(param_00) {
  var_01 = 0.7;
  var_02 = 25;
  var_03 = 0.8;
  param_00.var_2F12 setModel("ship_hallway_control_box_body");
  var_04 = spawn("script_model", param_00.door_struct.origin);
  var_04 setModel("ship_hallway_control_box_door");
  var_04.angles = param_00.door_struct.angles;
  param_00.var_5978 = var_04;
  var_05 = spawn("script_model", param_00.skull_struct.origin);
  var_05 setModel("zmb_8_bit_price_unlit");
  var_05.angles = param_00.skull_struct.angles;
  param_00.skull = var_05;
  var_05 setscriptablepartstate("skull_vfx", "green");
  param_00.var_5978 rotateto(param_00.door_open_struct.angles, var_01);
  wait(var_01);
  var_06 = var_05.origin + anglesToForward(var_05.angles) * var_02;
  var_05 moveto(var_06, var_03);
  return var_05;
}

skull_damage_monitor(param_00) {
  param_00.health = 999999;
  param_00 setCanDamage(1);
  param_00 setCanRadiusDamage(1);
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    param_00.health = 999999;
    if(isDefined(var_02) && isplayer(var_02)) {
      playFX(level._effect["ghost_explosion_death_green"], param_00.origin);
      param_00 delete();
      return;
    }
  }
}

wait_for_explosive_damage(param_00) {
  var_01 = param_00.var_2F12;
  var_01.health = 999999;
  var_01 setCanDamage(1);
  var_01 setCanRadiusDamage(1);
  for(;;) {
    var_01 waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    var_01.health = 999999;
    if(isDefined(var_06) && is_explosive_damage(var_06)) {
      return;
    }
  }
}

is_explosive_damage(param_00) {
  switch (param_00) {
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_PROJECTILE":
    case "MOD_GRENADE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_EXPLOSIVE":
      return 1;

    default:
      return 0;
  }
}

set_up_ghost_box(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    switch (var_03.script_noteworthy) {
      case "ghost_n_skull_door":
        param_00.door_struct = var_03;
        break;

      case "ghost_n_skull_door_open":
        param_00.door_open_struct = var_03;
        break;

      case "ghost_n_skull_skull":
        param_00.skull_struct = var_03;
        break;
    }
  }

  var_05 = spawn("script_model", param_00.origin);
  var_05 setModel("ship_hallway_control_box");
  var_05.angles = param_00.angles;
  param_00.var_2F12 = var_05;
}

complete_blow_up_ghost_box() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(1);
}

debug_blow_up_ghost_box() {}

stay_on_pressure_plates() {
  spawn_vfx_ent_at_plate_center();
  spawn_pressure_beam_vfx_ent();
  level thread all_players_on_pressure_plate_monitor();
  level thread pressure_plate_zombie_spawn_manager();
  for(;;) {
    turn_on_map_marker();
    level waittill("all_player_on_pressure_plate");
    if(level.players.size == 1) {
      var_00 = level scripts\engine\utility::waittill_any_timeout_1(1.5, "not_all_player_on_pressure_plate");
      if(var_00 == "not_all_player_on_pressure_plate") {
        continue;
      }
    }

    turn_off_map_marker();
    start_pressure_plate_zombie_spawn();
    turn_on_plate_center_vfx();
    turn_on_pressure_beam_vfx();
    turn_on_skull_meter();
    var_00 = level scripts\engine\utility::waittill_any_timeout_1(60, "not_all_player_on_pressure_plate");
    turn_off_plate_center_vfx();
    turn_off_pressure_beam_vfx();
    if(var_00 == "timeout") {
      turn_off_rise_loop_sfx();
      play_charge_complete_sfx();
      skull_meter_move_to_collection_loc();
      level.skull_meter thread skull_time_out_monitor();
      level.skull_meter thread skull_picked_up_monitor();
      var_00 = level.skull_meter scripts\engine\utility::waittill_any_return("skull_time_out", "skull_picked_up");
      turn_off_skull_meter();
      stop_pressure_plate_zombie_spawn();
      if(var_00 == "skull_picked_up") {
        return;
      }
    } else {
      turn_off_skull_meter();
      stop_pressure_plate_zombie_spawn();
    }

    wait_one_wave();
  }
}

play_charge_complete_sfx() {
  level.skull_meter playSound("cp_final_pressure_plate_skull_complete_charge");
}

turn_on_map_marker() {
  var_00 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.vfx_ent setscriptablepartstate("map_marker", "on");
  }
}

turn_off_map_marker() {
  var_00 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.vfx_ent setscriptablepartstate("map_marker", "off");
  }
}

skull_picked_up_monitor() {
  level.skull_meter endon("skull_time_out");
  for(;;) {
    foreach(var_01 in level.players) {
      if(isDefined(level.skull_meter)) {
        if(distancesquared(var_01 getEye(), level.skull_meter.origin) <= 2500) {
          level.skull_meter notify("skull_picked_up");
          playFX(level._effect["ghost_explosion_death_green"], level.skull_meter.origin, anglesToForward(level.skull_meter.angles), anglestoup(level.skull_meter.angles));
          return;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

skull_time_out_monitor() {
  level.skull_meter endon("skull_picked_up");
  wait(12);
  for(var_00 = 3; var_00 > 0; var_00--) {
    level.skull_meter hide();
    wait(0.6);
    level.skull_meter show();
    wait(0.4);
  }

  level.skull_meter notify("skull_time_out");
}

complete_stay_on_pressure_plates() {
  level notify("complete_stay_on_pressure_plates");
  clean_up_vfx_ent();
  clean_up_pressure_beam_vfx();
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(2);
}

spawn_pressure_beam_vfx_ent() {
  var_00 = spawn("script_model", (1467, 2775, -277));
  var_00 setModel("final_gns_quest_origin");
  level.pressure_beam_vfx_ent = var_00;
}

turn_on_skull_meter() {
  var_00 = spawn("script_model", (1467, 2775, -267));
  var_00 setModel("final_gns_quest_origin");
  var_00 playLoopSound("cp_final_pressure_plate_skull_rise_lp");
  var_00 thread skull_meter_glow_manager(var_00);
  var_00 thread skull_meter_move_up(var_00);
  var_00 thread keep_rotate(var_00);
  level.skull_meter = var_00;
}

turn_off_rise_loop_sfx() {
  level.skull_meter stoploopsound("cp_final_pressure_plate_skull_rise_lp");
}

skull_meter_move_to_collection_loc() {
  level.skull_meter setModel("zmb_8_bit_price_unlit");
  level.skull_meter setscriptablepartstate("skull_vfx", "green");
  playFX(level._effect["gns_skull_meter_burst"], level.skull_meter.origin);
  var_00 = [(1923, 3117, -72), (1650, 2449, -72), (1173, 3407, 76), (1311, 2369, 76)];
  var_01 = scripts\engine\utility::random(var_00);
  level.skull_meter moveto(var_01, 0.5, 0.5);
  level.skull_meter waittill("movedone");
}

skull_meter_move_up(param_00) {
  param_00 moveto(param_00.origin + (0, 0, 200), 60);
}

skull_meter_glow_manager(param_00) {
  param_00 endon("death");
  var_01 = 20;
  param_00 setscriptablepartstate("skull_vfx", "small_glow");
  wait(var_01);
  param_00 setscriptablepartstate("skull_vfx", "mid_glow");
  wait(var_01);
  param_00 setscriptablepartstate("skull_vfx", "big_glow");
}

keep_rotate(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00 rotateyaw(360, 3);
    wait(3);
  }
}

turn_off_skull_meter() {
  turn_off_rise_loop_sfx();
  if(isDefined(level.skull_meter)) {
    level.skull_meter delete();
  }
}

turn_on_pressure_beam_vfx() {
  level.pressure_beam_vfx_ent setscriptablepartstate("pressure_plate_beam", "on");
}

turn_off_pressure_beam_vfx() {
  level.pressure_beam_vfx_ent setscriptablepartstate("pressure_plate_beam", "off");
}

clean_up_pressure_beam_vfx() {
  if(isDefined(level.pressure_beam_vfx_ent)) {
    level.pressure_beam_vfx_ent delete();
  }
}

debug_stay_on_pressure_plates() {}

all_players_on_pressure_plate_monitor() {
  level endon("complete_stay_on_pressure_plates");
  var_00 = getent("pressure_plate_volume", "targetname");
  for(;;) {
    if(all_players_touch_volume(var_00)) {
      level notify("all_player_on_pressure_plate");
    } else {
      level notify("not_all_player_on_pressure_plate");
    }

    scripts\engine\utility::waitframe();
  }
}

all_players_touch_volume(param_00) {
  foreach(var_02 in level.players) {
    if(!var_02 istouching(param_00)) {
      return 0;
    }
  }

  var_04 = level.players.size;
  if(var_04 == 1) {
    return 1;
  }

  for(var_05 = 0; var_05 < var_04 - 1; var_05++) {
    var_06 = level.players[var_05];
    var_07 = level.players[var_05 + 1];
    if(distance2dsquared(var_06.origin, var_07.origin) < 10000) {
      return 0;
    }
  }

  return 1;
}

spawn_vfx_ent_at_plate_center() {
  var_00 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02.origin);
    var_03 setModel("final_gns_quest_origin");
    var_02.vfx_ent = var_03;
  }
}

turn_on_plate_center_vfx() {
  var_00 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(player_standing_on_plate(var_02)) {
      var_02.vfx_ent setscriptablepartstate("pressure_plate", "on");
    }
  }
}

turn_off_plate_center_vfx() {
  var_00 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.vfx_ent setscriptablepartstate("pressure_plate", "off");
  }
}

player_standing_on_plate(param_00) {
  foreach(var_02 in level.players) {
    if(distance2dsquared(param_00.vfx_ent.origin, var_02.origin) <= 6400) {
      return 1;
    }
  }

  return 0;
}

clean_up_vfx_ent() {
  var_00 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.vfx_ent)) {
      var_02.vfx_ent delete();
    }
  }
}

start_pressure_plate_zombie_spawn() {
  stop_spawn_wave();
  scripts\engine\utility::flag_set("pressure_plate_zombie_spawn");
  level thread pressure_plate_spawn_difficulty_logic();
}

pressure_plate_spawn_difficulty_logic() {
  level endon("stop_pressure_plate_spawn_difficulty_logic");
  var_00 = 12;
  set_pressure_plate_max_zombie_spawn(12, 11, 10, 9);
  set_pressure_plate_zombie_spawn_delay(2.7, 2.8, 2.9, 3);
  level.max_wave_spawn_num = 10;
  level.wait_time_between_wave = 3.5;
  wait(var_00);
  set_pressure_plate_max_zombie_spawn(14, 13, 12, 11);
  set_pressure_plate_zombie_spawn_delay(2.5, 2.6, 2.7, 2.8);
  level.max_wave_spawn_num = 12;
  level.wait_time_between_wave = 3;
  wait(var_00);
  set_pressure_plate_max_zombie_spawn(16, 15, 14, 13);
  set_pressure_plate_zombie_spawn_delay(2.3, 2.4, 2.5, 2.6);
  level.max_wave_spawn_num = 14;
  level.wait_time_between_wave = 2.5;
  wait(var_00);
  set_pressure_plate_max_zombie_spawn(18, 17, 16, 15);
  set_pressure_plate_zombie_spawn_delay(2.1, 2.2, 2.3, 2.4);
  level.max_wave_spawn_num = 16;
  level.wait_time_between_wave = 2;
  wait(var_00);
  set_pressure_plate_max_zombie_spawn(20, 19, 18, 17);
  set_pressure_plate_zombie_spawn_delay(1.9, 2, 2.1, 2.2);
  level.max_wave_spawn_num = 18;
  level.wait_time_between_wave = 1.5;
}

set_pressure_plate_max_zombie_spawn(param_00, param_01, param_02, param_03) {
  switch (level.players.size) {
    case 4:
      level.pressure_plate_max_zombie_spawn = param_00;
      break;

    case 3:
      level.pressure_plate_max_zombie_spawn = param_01;
      break;

    case 2:
      level.pressure_plate_max_zombie_spawn = param_02;
      break;

    case 1:
      level.pressure_plate_max_zombie_spawn = param_03;
      break;

    default:
      break;
  }
}

set_pressure_plate_zombie_spawn_delay(param_00, param_01, param_02, param_03) {
  switch (level.players.size) {
    case 4:
      level.pressure_plate_zombie_spawn_delay = param_00;
      break;

    case 3:
      level.pressure_plate_zombie_spawn_delay = param_01;
      break;

    case 2:
      level.pressure_plate_zombie_spawn_delay = param_02;
      break;

    case 1:
      level.pressure_plate_zombie_spawn_delay = param_03;
      break;

    default:
      break;
  }
}

stop_pressure_plate_zombie_spawn() {
  level endon("stop_pressure_plate_spawn_difficulty_logic");
  scripts\engine\utility::flag_clear("pressure_plate_zombie_spawn");
  resume_spawn_wave();
}

pressure_plate_zombie_spawn_manager() {
  level endon("complete_stay_on_pressure_plates");
  level.allow_wave_spawn = 1;
  level.max_wave_spawn_num = 9999999;
  scripts\engine\utility::flag_init("pressure_plate_zombie_spawn");
  scripts\engine\utility::flag_wait("pressure_plate_zombie_spawn");
  var_00 = 0;
  for(;;) {
    if(can_spawn_zombie()) {
      var_01 = get_zombie_spawner();
      var_02 = var_01 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1, var_01);
      if(isDefined(var_02)) {
        var_00++;
        var_02.dont_cleanup = 1;
        var_02.synctransients = "sprint";
        var_02 thread play_intro(var_02);
      }
    }

    wait(get_zombie_spawn_delay());
    if(!scripts\engine\utility::flag("pressure_plate_zombie_spawn")) {
      scripts\engine\utility::flag_wait("pressure_plate_zombie_spawn");
      continue;
    }

    if(should_do_wave_spawn()) {
      if(should_do_wait_between_wave(var_00)) {
        var_00 = 0;
        wait_between_wave();
      }
    }
  }
}

play_intro(param_00) {
  param_00 endon("death");
  param_00 waittill("intro_vignette_done");
  param_00.synctransients = "sprint";
}

get_zombie_spawner() {
  var_00 = 20;
  var_01 = undefined;
  var_02 = [(1142, 2093, -173), (1363, 1911, -173), (1876, 2162, -173), (2011, 2180, -173), (2118, 3432, -173), (1843, 3575, -173), (1561, 3488, -173), (1391, 3544, -173), (1254, 3316, -173), (869, 3239, -173)];
  var_01 = scripts\engine\utility::random(var_02);
  var_03 = randomfloatrange(var_00 * -1, var_00);
  var_04 = randomfloatrange(var_00 * -1, var_00);
  var_01 = (var_01[0] + var_03, var_01[1] + var_04, var_01[2]);
  var_01 = getclosestpointonnavmesh(var_01);
  var_05 = spawnStruct();
  var_05.origin = var_01;
  var_05.angles = vectortoangles((-26, -110, 18));
  var_05.script_parameters = "ground_spawn_no_boards";
  var_05.script_animation = "spawn_ground";
  var_05.script_fxid = "concrete";
  return var_05;
}

can_spawn_zombie() {
  var_00 = 20;
  if(isDefined(level.pressure_plate_max_zombie_spawn)) {
    var_01 = level.pressure_plate_max_zombie_spawn;
  } else {
    var_01 = var_01;
  }

  return get_num_alive_agent_of_type("generic_zombie") < var_01;
}

get_num_alive_agent_of_type(param_00) {
  var_01 = 0;
  foreach(var_03 in level.spawned_enemies) {
    if(isDefined(var_03.agent_type) && var_03.agent_type == param_00) {
      var_01++;
    }
  }

  return var_01;
}

stop_spawn_wave() {
  scripts\engine\utility::flag_set("pause_wave_progression");
  level.zombies_paused = 1;
  level.dont_resume_wave_after_solo_afterlife = 1;
}

resume_spawn_wave() {
  level.dont_resume_wave_after_solo_afterlife = undefined;
  level.zombies_paused = 0;
  scripts\engine\utility::flag_clear("pause_wave_progression");
}

get_zombie_spawn_delay() {
  if(isDefined(level.pressure_plate_zombie_spawn_delay)) {
    return level.pressure_plate_zombie_spawn_delay;
  }

  return 2;
}

should_do_wave_spawn() {
  if(scripts\engine\utility::istrue(level.allow_wave_spawn)) {
    if(level.players.size == 1) {
      return 1;
    }

    return 0;
  }

  return 0;
}

should_do_wait_between_wave(param_00) {
  return param_00 >= level.max_wave_spawn_num;
}

wait_between_wave() {
  var_00 = 10;
  if(isDefined(level.wait_time_between_wave)) {
    wait(level.wait_time_between_wave);
    return;
  }

  wait(var_00);
}

wait_one_wave() {
  level scripts\engine\utility::waittill_any_3("regular_wave_starting", "event_wave_starting");
}

select_odd_cipher() {
  var_00 = [(5284, -6290, 85), (4805, -6460, 69), (1945, 2637, -264), (280, 4022, 65), (-308, 5397, 66), (3, 4033, 40), (3379, -4234, 68), (265, 4916, 20)];
  var_01 = [(360, 180, 90), (0, 0, 90), (0, 73, 90), (360, 90, 90), (360, 180, 90), (0, 0, 90), (0, 90, 90), (0, 350, 90)];
  var_02 = ["p", "w", "z", "y"];
  var_03 = ["a", "k", "t", "x"];
  var_04 = [var_02, var_03];
  var_05 = [0, 1, 2, 3, 4, 5, 6, 7];
  for(;;) {
    var_06 = scripts\engine\utility::array_randomize_objects(var_05);
    var_07 = get_cipher_group_index(var_04);
    var_08 = var_04[var_07.target_index];
    var_09 = var_04[var_07.non_target_index];
    var_09 = scripts\engine\utility::array_randomize_objects(var_09);
    var_0A = scripts\engine\utility::random(var_08);
    var_0B = [];
    for(var_0C = 0; var_0C < 3; var_0C++) {
      var_0B[var_0C] = var_09[var_0C];
    }

    level.gns_ciphers = [];
    for(var_0D = 0; var_0D < 4; var_0D++) {
      if(var_0D == 3) {
        create_cipher(var_0A, var_00[var_06[var_0D]], var_01[var_06[var_0D]], "correct_choice");
        continue;
      }

      create_cipher(var_0B[var_0D], var_00[var_06[var_0D]], var_01[var_06[var_0D]], "wrong_choice");
    }

    level waittill("GnS_cipher_selected", var_0E);
    clean_up_ciphers();
    if(var_0E == "correct_choice") {
      break;
    } else {
      wait_one_wave();
    }
  }
}

get_cipher_group_index(param_00) {
  var_01 = spawnStruct();
  var_02 = [];
  for(var_03 = 0; var_03 < param_00.size; var_03++) {
    var_02[var_03] = var_03;
  }

  var_01.target_index = scripts\engine\utility::random(var_02);
  var_02 = scripts\engine\utility::array_remove(var_02, var_01.target_index);
  var_01.non_target_index = scripts\engine\utility::random(var_02);
  return var_01;
}

clean_up_ciphers() {
  if(isDefined(level.gns_ciphers)) {
    foreach(var_01 in level.gns_ciphers) {
      if(scripts\engine\utility::istrue(var_01.fading_out)) {
        continue;
      }

      if(isDefined(var_01)) {
        var_01 delete();
      }
    }
  }
}

create_cipher(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_model", param_01);
  var_04 setModel("final_gns_quest_origin");
  var_04.angles = param_02;
  var_04.cipher_character = param_00;
  var_04 setscriptablepartstate("cipher", param_00);
  level.gns_ciphers[level.gns_ciphers.size] = var_04;
  var_04 thread wait_for_selection(var_04, param_03);
}

wait_for_selection(param_00, param_01) {
  param_00 endon("death");
  wait_for_player_look_at(param_00);
  param_00 thread cipher_vfx_fade_out(param_00);
  if(param_01 == "wrong_choice") {
    playsoundatpos(param_00.origin, "mpq_fail_buzzer");
  }

  level notify("GnS_cipher_selected", param_01);
}

cipher_vfx_fade_out(param_00) {
  param_00.fading_out = 1;
  param_00 endon("death");
  param_00 setscriptablepartstate("cipher", param_00.cipher_character + "_fade");
  wait(3);
  param_00 delete();
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

complete_select_odd_cipher() {
  clean_up_ciphers();
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(3);
}

debug_select_odd_cipher() {}

follow_the_light() {
  for(;;) {
    level thread follow_the_light_manager();
    var_00 = level scripts\engine\utility::waittill_any_return("succeed_follow_the_light", "fail_follow_the_light");
    if(var_00 == "succeed_follow_the_light") {
      return;
    } else {
      wait_one_wave();
    }
  }
}

follow_the_light_manager() {
  level endon("game_ended");
  level endon("fail_follow_the_light");
  level endon("succeed_follow_the_light");
  var_00 = get_follow_the_light_map_marker();
  reset_follow_the_light_setup();
  wait_players_trigger_start();
  var_00 delete();
  create_follow_the_light_node(scripts\engine\utility::getstruct("gns_path_start", "targetname"));
  level waittill("follow_the_light_start_node_picked_up");
  level thread follow_the_light_time_out_monitor();
  for(;;) {
    level waittill("regular_light_node_picked_up");
    expand_light_node_path();
  }
}

get_follow_the_light_map_marker() {
  var_00 = (-274, 3873, 118);
  var_01 = spawn("script_model", var_00);
  var_01 setModel("final_gns_quest_origin");
  var_01 setscriptablepartstate("map_marker", "on");
  return var_01;
}

follow_the_light_time_out_monitor() {
  level endon("game_ended");
  level endon("fail_follow_the_light");
  level endon("succeed_follow_the_light");
  for(;;) {
    var_00 = level scripts\engine\utility::waittill_any_timeout_1(1.2, "regular_light_node_picked_up");
    if(var_00 == "timeout") {
      play_time_out_sfx();
      level thread fail_follow_the_light();
      return;
    }
  }
}

play_time_out_sfx() {
  var_00 = scripts\engine\utility::random(level.active_light_nodes);
  playsoundatpos(var_00.origin, "mpq_fail_buzzer");
}

reset_follow_the_light_setup() {
  level.follow_the_light_player = undefined;
  level.follow_the_light_target_color = scripts\engine\utility::random(["green", "yellow"]);
  level.paired_light_node_color = ["green", "yellow"];
  level.leading_light_node_struct = undefined;
  level.current_light_node_progress_index = 0;
  level.active_light_nodes = [];
}

expand_light_node_path() {
  if(isDefined(level.leading_light_node_struct.script_noteworthy) && level.leading_light_node_struct.script_noteworthy == "gns_path_end") {
    return;
  }

  var_00 = get_light_node_structs_to_expand();
  if(var_00.size == 1) {
    foreach(var_02 in var_00) {
      var_02.light_color = level.follow_the_light_target_color;
    }
  }

  foreach(var_02 in var_00) {
    create_follow_the_light_node(var_02);
  }
}

get_light_node_structs_to_expand() {
  var_00 = scripts\engine\utility::getstructarray(level.leading_light_node_struct.target, "targetname");
  if(isDefined(level.leading_light_node_struct.script_parameters) && level.leading_light_node_struct.script_parameters == "gns_path_split") {
    return [scripts\engine\utility::random(var_00)];
  }

  return var_00;
}

create_follow_the_light_node(param_00) {
  level.leading_light_node_struct = param_00;
  var_01 = spawn("script_model", param_00.origin);
  var_01 setModel(get_follow_the_light_node_model(param_00));
  var_01 apply_node_scriptable_state(var_01, param_00);
  add_to_active_light_nodes(var_01);
  if(isDefined(param_00.angles)) {
    var_01.angles = param_00.angles;
  }

  if(isDefined(param_00.script_noteworthy)) {
    var_01.progress_index = int(param_00.script_noteworthy);
  }

  var_01 thread player_pick_up_monitor(var_01, param_00);
}

add_to_active_light_nodes(param_00) {
  level.active_light_nodes[level.active_light_nodes.size] = param_00;
}

remove_active_light_nodes_with_index(param_00) {
  foreach(var_02 in level.active_light_nodes) {
    if(isDefined(var_02.progress_index) && var_02.progress_index == param_00) {
      level.active_light_nodes = scripts\engine\utility::array_remove(level.active_light_nodes, var_02);
      var_02 delete();
    }
  }
}

player_pick_up_monitor(param_00, param_01) {
  if(isDefined(param_01.var_336) && param_01.var_336 == "gns_path_start") {
    param_00 thread path_start_pick_up_monitor(param_00);
    return;
  }

  if(isDefined(param_01.script_noteworthy) && param_01.script_noteworthy == "gns_path_end") {
    param_00 thread path_end_pick_up_monitor(param_00);
    return;
  }

  param_00 thread regular_node_pick_up_monitor(param_00);
}

path_start_pick_up_monitor(param_00) {
  param_00 endon("death");
  for(;;) {
    foreach(var_02 in level.players) {
      if(distance2dsquared(var_02.origin, param_00.origin) <= 900) {
        level.follow_the_light_player = var_02;
        level.current_light_node_progress_index++;
        for(var_03 = 0; var_03 < 3; var_03++) {
          expand_light_node_path();
        }

        var_02 turn_on_timer_hud(var_02);
        var_02 thread follow_the_light_timer_logic(var_02);
        var_02 playlocalsound("purchase_ticket");
        level notify("follow_the_light_start_node_picked_up");
        level.active_light_nodes = scripts\engine\utility::array_remove(level.active_light_nodes, param_00);
        param_00 delete();
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

turn_on_timer_hud(param_00) {
  param_00 setclientomnvar("zom_show_gns_timer", 1);
}

turn_off_timer_hud(param_00) {
  if(isDefined(param_00)) {
    param_00 setclientomnvar("zom_show_gns_timer", 0);
  }
}

follow_the_light_timer_logic(param_00) {
  param_00 notify("follow_the_light_timer_logic");
  param_00 endon("follow_the_light_timer_logic");
  var_01 = int(24);
  var_01 = var_01 - 2;
  for(var_02 = 0; var_02 <= var_01; var_02++) {
    var_03 = 1 - var_02 / var_01;
    param_00 setclientomnvar("zom_gns_timer_percent", var_03);
    scripts\engine\utility::waitframe();
  }
}

path_end_pick_up_monitor(param_00) {
  param_00 endon("death");
  for(;;) {
    foreach(var_02 in level.players) {
      if(!isDefined(var_02) || scripts\cp\cp_laststand::player_in_laststand(var_02)) {
        continue;
      }

      if(level.follow_the_light_player != var_02) {
        continue;
      }

      if(distance2dsquared(var_02.origin, param_00.origin) <= 900) {
        if(any_other_active_light_node(param_00)) {
          playsoundatpos(param_00.origin, "mpq_fail_buzzer");
          turn_off_timer_hud(var_02);
          level thread fail_follow_the_light();
          return;
        } else {
          playFX(level._effect["ghost_explosion_death_green"], param_00.origin, anglesToForward(param_00.angles), anglestoup(param_00.angles));
          turn_off_timer_hud(var_02);
          level notify("succeed_follow_the_light");
          param_00 delete();
          return;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

any_other_active_light_node(param_00) {
  foreach(var_02 in level.active_light_nodes) {
    if(var_02 == param_00) {
      continue;
    } else {
      return 1;
    }
  }

  return 0;
}

regular_node_pick_up_monitor(param_00) {
  param_00 endon("death");
  for(;;) {
    foreach(var_02 in level.players) {
      if(!isDefined(var_02) || scripts\cp\cp_laststand::player_in_laststand(var_02)) {
        continue;
      }

      if(level.follow_the_light_player != var_02) {
        continue;
      }

      if(distance2dsquared(var_02.origin, param_00.origin) <= 400) {
        if(param_00.progress_index != level.current_light_node_progress_index) {
          playsoundatpos(param_00.origin, "mpq_fail_buzzer");
          level thread fail_follow_the_light();
          return;
        }

        if(param_00.light_color == level.follow_the_light_target_color) {
          var_02 playlocalsound("purchase_ticket");
          level.current_light_node_progress_index++;
          level notify("regular_light_node_picked_up");
          var_02 thread follow_the_light_timer_logic(var_02);
          level thread remove_active_light_nodes_with_index(level.current_light_node_progress_index - 1);
          return;
        } else {
          playsoundatpos(param_00.origin, "mpq_fail_buzzer");
          level thread fail_follow_the_light();
          return;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

fail_follow_the_light() {
  turn_off_timer_hud(level.follow_the_light_player);
  delete_all_active_light_nodes();
  level notify("fail_follow_the_light");
}

delete_all_active_light_nodes() {
  if(isDefined(level.active_light_nodes)) {
    foreach(var_01 in level.active_light_nodes) {
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }

    level.active_light_nodes = [];
  }
}

get_follow_the_light_node_model(param_00) {
  if(isDefined(param_00.var_336) && param_00.var_336 == "gns_path_start") {
    return "zmb_8_bit_price_unlit";
  }

  if(isDefined(param_00.script_noteworthy) && param_00.script_noteworthy == "gns_path_end") {
    return "zmb_8_bit_price_unlit";
  }

  return "final_gns_quest_origin";
}

apply_node_scriptable_state(param_00, param_01) {
  if(isDefined(param_01.var_336) && param_01.var_336 == "gns_path_start") {
    param_00.light_color = level.follow_the_light_target_color;
    param_00 setscriptablepartstate("skull_vfx", "safe_" + level.follow_the_light_target_color);
    return;
  }

  if(isDefined(param_01.script_noteworthy) && param_01.script_noteworthy == "gns_path_end") {
    param_00.light_color = level.follow_the_light_target_color;
    param_00 setscriptablepartstate("skull_vfx", "safe_" + level.follow_the_light_target_color);
    return;
  }

  var_02 = get_regular_light_path_color(param_01);
  param_00.light_color = var_02;
  param_00 setscriptablepartstate("light_to_follow", var_02);
}

get_regular_light_path_color(param_00) {
  if(isDefined(param_00.light_color)) {
    return param_00.light_color;
  }

  if(level.paired_light_node_color.size == 0) {
    level.paired_light_node_color = ["green", "yellow"];
  }

  var_01 = scripts\engine\utility::random(level.paired_light_node_color);
  level.paired_light_node_color = scripts\engine\utility::array_remove(level.paired_light_node_color, var_01);
  return var_01;
}

wait_players_trigger_start() {
  var_00 = int(30);
  var_01 = getent("gns_path_start_volume", "targetname");
  var_02 = 0;
  for(;;) {
    if(any_player_touch_volume(var_01)) {
      var_02++;
      if(var_02 == var_00) {
        return;
      }
    } else {
      var_02 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

any_player_touch_volume(param_00) {
  foreach(var_02 in level.players) {
    if(var_02 istouching(param_00)) {
      return 1;
    }
  }

  return 0;
}

complete_follow_the_light() {
  turn_off_timer_hud(level.follow_the_light_player);
  delete_all_active_light_nodes();
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(4);
}

debug_follow_the_light() {}

solve_eight_queen() {
  level thread eight_queen_player_connect_monitor();
  level thread create_queen_pieces_for_pick_up(7);
  level.eight_queen_struct = set_up_controlling_struct();
  place_a_queen_on_board(get_initial_queen_placement());
  level thread update_player_monitor(level.eight_queen_struct);
  level thread player_interact_monitor(level.eight_queen_struct);
  level waittill("solve_eight_queen_problem");
  scripts\engine\utility::exploder(200);
}

player_interact_monitor(param_00) {
  level endon("complete_solve_eight_queen");
  for(;;) {
    foreach(var_02 in level.players) {
      if(player_interact_with_chess_board(var_02, param_00)) {
        var_03 = var_02.queen_piece_struct_currently_looking_at;
        if(is_empty_queen_piece_struct(var_03)) {
          var_02.num_of_queen_pieces_on_me--;
          var_04 = place_a_queen_on_board_internal(var_03, 1, 0);
          var_04 hudoutlineenableforclient(var_02, 1, 1, 0);
          if(check_eight_queen_solution()) {
            level notify("solve_eight_queen_problem");
          }
        }

        wait(1);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

player_interact_with_chess_board(param_00, param_01) {
  if(!isDefined(param_00.num_of_queen_pieces_on_me)) {
    return 0;
  }

  if(param_00.num_of_queen_pieces_on_me == 0) {
    return 0;
  }

  if(isDefined(param_00.next_queen_piece_place_time) && gettime() < param_00.next_queen_piece_place_time) {
    return 0;
  }

  if(!player_in_play_space(param_00, param_01)) {
    return 0;
  }

  if(!player_looking_at_any_queen_piece(param_00)) {
    return 0;
  }

  if(!param_00 usebuttonpressed()) {
    return 0;
  }

  return 1;
}

update_player_monitor(param_00) {
  level endon("complete_solve_eight_queen");
  for(;;) {
    foreach(var_02 in level.players) {
      update_queen_piece_state_for_player(var_02, param_00);
    }

    scripts\engine\utility::waitframe();
  }
}

update_queen_piece_state_for_player(param_00, param_01) {
  if(!player_in_play_space(param_00, param_01)) {
    if(player_looking_at_any_queen_piece_struct(param_00)) {
      clear_queen_piece_state_for_player(param_00);
    }

    return;
  }

  var_02 = get_queen_piece_struct_currently_looking_at(param_00, param_01);
  if(isDefined(var_02)) {
    if(!looking_at_the_same_queen_piece(param_00, var_02)) {
      if(player_looking_at_any_queen_piece(param_00)) {
        clear_queen_piece_state_for_player(param_00);
      }

      set_queen_piece_struct_currently_looking_at(param_00, var_02);
    }
  }
}

set_queen_piece_struct_currently_looking_at(param_00, param_01) {
  if(is_empty_queen_piece_struct(param_01)) {
    show_empty_queen_piece_for_player(param_00, param_01);
  } else {
    show_queen_piece_outline_for_player(param_00, param_01);
  }

  param_00.queen_piece_struct_currently_looking_at = param_01;
}

show_queen_piece_outline_for_player(param_00, param_01) {
  param_01.queen_piece hudoutlineenableforclient(param_00, 1, 1, 0);
}

show_empty_queen_piece_for_player(param_00, param_01) {
  if(!isDefined(param_00.num_of_queen_pieces_on_me)) {
    return;
  }

  if(param_00.num_of_queen_pieces_on_me == 0) {
    return;
  }

  if(!isDefined(param_01.empty_queen_piece)) {
    param_01.empty_queen_piece = spawn("script_model", param_01.origin);
    param_01.empty_queen_piece setModel("cp_final_chess_queen_red");
  }
}

player_looking_at_any_queen_piece(param_00) {
  return isDefined(param_00.queen_piece_struct_currently_looking_at);
}

looking_at_the_same_queen_piece(param_00, param_01) {
  return isDefined(param_00.queen_piece_struct_currently_looking_at) && param_00.queen_piece_struct_currently_looking_at == param_01;
}

get_queen_piece_struct_currently_looking_at(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_01.queen_piece_struct) {
    foreach(var_06 in var_04) {
      if(isDefined(var_06.allow_pick_up) && var_06.allow_pick_up == 0) {
        continue;
      }

      if(param_00 worldpointinreticle_circle(var_06.origin, 25, 75)) {
        var_02[var_02.size] = var_06;
      }
    }
  }

  return scripts\engine\utility::getclosest(param_00.origin, var_02);
}

clear_queen_piece_state_for_player(param_00) {
  var_01 = param_00.queen_piece_struct_currently_looking_at;
  if(is_empty_queen_piece_struct(var_01)) {
    clear_empty_queen_piece_for_player(param_00, var_01);
  } else {
    hide_queen_piece_outline_for_player(param_00, var_01);
  }

  param_00.queen_piece_struct_currently_looking_at = undefined;
}

hide_queen_piece_outline_for_player(param_00, param_01) {
  param_01.queen_piece hudoutlinedisableforclient(param_00);
}

clear_empty_queen_piece_for_player(param_00, param_01) {
  if(any_other_player_looking_at_it(param_00, param_01)) {
    return;
  }

  if(isDefined(param_01.empty_queen_piece)) {
    param_01.empty_queen_piece delete();
  }
}

any_other_player_looking_at_it(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(var_03 == param_00) {
      continue;
    }

    if(isDefined(var_03.queen_piece_struct_currently_looking_at) && var_03.queen_piece_struct_currently_looking_at == param_01) {
      return 1;
    }
  }

  return 0;
}

player_in_play_space(param_00, param_01) {
  return ispointinvolume(param_00.origin, param_01.play_area);
}

player_looking_at_any_queen_piece_struct(param_00) {
  return isDefined(param_00.queen_piece_struct_currently_looking_at);
}

place_a_queen_on_board(param_00) {
  var_01 = param_00[0];
  var_02 = param_00[1];
  var_03 = get_queen_piece_struct_at(var_01, var_02);
  place_a_queen_on_board_internal(var_03, 0, 0);
}

place_a_queen_on_board_internal(param_00, param_01, param_02) {
  if(!isDefined(level.eight_queen_struct.active_queen_pieces)) {
    level.eight_queen_struct.active_queen_pieces = [];
  }

  if(isDefined(param_00.empty_queen_piece)) {
    param_00.empty_queen_piece delete();
  }

  level.eight_queen_struct.active_queen_pieces[level.eight_queen_struct.active_queen_pieces.size] = param_00;
  return place_a_queen_piece_at(param_00, param_01, param_02, 1);
}

remove_a_queen_from_board(param_00) {
  level.eight_queen_struct.active_queen_pieces = scripts\engine\utility::array_remove(level.eight_queen_struct.active_queen_pieces, param_00);
}

get_queen_piece_struct_at(param_00, param_01) {
  return level.eight_queen_struct.queen_piece_struct[param_00][param_01];
}

create_queen_pieces_for_pick_up(param_00) {
  var_01 = scripts\engine\utility::getstructarray("eight_queen_pick_up", "targetname");
  var_01 = remove_non_empty_queen_struct(var_01);
  var_01 = scripts\engine\utility::array_randomize_objects(var_01);
  for(var_02 = 0; var_02 < param_00; var_02++) {
    var_03 = var_01[var_02];
    place_a_queen_piece_at(var_03, 1, 1, 0);
    scripts\engine\utility::waitframe();
  }
}

place_a_queen_piece_at(param_00, param_01, param_02, param_03) {
  param_00.allow_pick_up = param_01;
  var_04 = spawn("script_model", param_00.origin);
  var_04 setModel(get_queen_piece_model(param_01));
  if(isDefined(param_00.angles)) {
    var_04.angles = param_00.angles;
  }

  param_00.queen_piece = var_04;
  if(scripts\engine\utility::istrue(param_01)) {
    param_00 thread player_pick_up_queen_piece_monitor(param_00, param_03);
  }

  return var_04;
}

player_pick_up_queen_piece_monitor(param_00, param_01) {
  param_00.queen_piece endon("death");
  level endon("complete_solve_eight_queen");
  wait(1);
  for(;;) {
    foreach(var_03 in level.players) {
      if(player_use_queen_piece_struct(param_00, var_03)) {
        play_pick_up_vfx(param_00, var_03);
        if(!isDefined(var_03.num_of_queen_pieces_on_me)) {
          var_03.num_of_queen_pieces_on_me = 0;
        }

        if(scripts\engine\utility::istrue(param_01)) {
          var_03.next_queen_piece_place_time = gettime() + 1000;
          remove_a_queen_from_board(param_00);
        }

        var_03.num_of_queen_pieces_on_me++;
        var_03 thread eight_queen_player_disconnect_monitor(var_03);
        remove_a_queen_piece_from(param_00);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

eight_queen_player_connect_monitor() {
  level endon("complete_solve_eight_queen");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread eight_queen_player_disconnect_monitor(var_00);
  }
}

eight_queen_player_disconnect_monitor(param_00) {
  level endon("complete_solve_eight_queen");
  param_00 notify("eight_queen_player_disconnect_monitor");
  param_00 endon("eight_queen_player_disconnect_monitor");
  param_00 waittill("disconnect");
  if(isDefined(param_00.num_of_queen_pieces_on_me) && param_00.num_of_queen_pieces_on_me > 0) {
    level thread create_queen_pieces_for_pick_up(param_00.num_of_queen_pieces_on_me);
  }
}

play_pick_up_vfx(param_00, param_01) {
  playFX(level._effect["sb_quest_item_pickup"], param_00.origin);
}

player_use_queen_piece_struct(param_00, param_01) {
  if(isDefined(param_01.queen_piece_struct_currently_looking_at) && param_01.queen_piece_struct_currently_looking_at != param_00) {
    return 0;
  }

  if(distance2dsquared(param_00.origin, param_01.origin) > 6400) {
    return 0;
  }

  if(!param_01 usebuttonpressed()) {
    return 0;
  }

  if(!param_01 worldpointinreticle_circle(param_00.origin, 55, 75)) {
    return 0;
  }

  return 1;
}

remove_a_queen_piece_from(param_00) {
  if(isDefined(param_00.queen_piece)) {
    param_00.queen_piece delete();
  }
}

get_queen_piece_model(param_00) {
  if(scripts\engine\utility::istrue(param_00)) {
    return "misc_interior_chess_game_white_queen";
  }

  return "misc_interior_chess_game_black_queen";
}

remove_non_empty_queen_struct(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(is_empty_queen_piece_struct(var_03)) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

is_empty_queen_piece_struct(param_00) {
  return !isDefined(param_00.queen_piece);
}

set_up_controlling_struct() {
  var_00 = scripts\engine\utility::getstruct("eight_queen_control", "targetname");
  var_00.queen_piece_struct = [];
  for(var_01 = 1; var_01 <= 8; var_01++) {
    var_00.queen_piece_struct[var_01 + ""] = [];
  }

  var_02 = scripts\engine\utility::getstructarray(var_00.target, "targetname");
  foreach(var_04 in var_02) {
    var_05 = var_04.script_noteworthy;
    var_05 = strtok(var_05, " ");
    var_06 = var_05[0];
    var_07 = var_05[1];
    var_00.queen_piece_struct[var_06][var_07] = var_04;
  }

  var_09 = getEntArray(var_00.target, "targetname");
  foreach(var_0B in var_09) {
    switch (var_0B.script_noteworthy) {
      case "play_area":
        var_00.play_area = var_0B;
        break;
    }
  }

  return var_00;
}

get_initial_queen_placement() {
  var_00 = [["1", "4"],
    ["3", "4"],
    ["4", "4"],
    ["5", "4"],
    ["6", "4"],
    ["7", "4"],
    ["8", "4"]];
  return scripts\engine\utility::random(var_00);
}

complete_solve_eight_queen() {
  clear_queen_piece_outline_for_players();
  level notify("complete_solve_eight_queen");
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(5);
}

clear_queen_piece_outline_for_players() {
  if(isDefined(level.eight_queen_struct) && isDefined(level.eight_queen_struct.active_queen_pieces)) {
    foreach(var_01 in level.eight_queen_struct.active_queen_pieces) {
      if(isDefined(var_01.queen_piece)) {
        foreach(var_03 in level.players) {
          var_01.queen_piece hudoutlinedisableforclient(var_03);
        }
      }
    }
  }
}

check_eight_queen_solution() {
  if(level.eight_queen_struct.active_queen_pieces.size < 8) {
    return 0;
  }

  if(fail_row_check()) {
    return 0;
  }

  if(fail_column_check()) {
    return 0;
  }

  if(fail_up_down_check()) {
    return 0;
  }

  if(fail_down_up_check()) {
    return 0;
  }

  return 1;
}

fail_row_check() {
  for(var_00 = 1; var_00 <= 8; var_00++) {
    var_01 = get_num_of_queen_along_path(var_00, 1, 0, 1);
    if(var_01 > 1) {
      return 1;
    }
  }

  return 0;
}

fail_column_check() {
  for(var_00 = 1; var_00 <= 8; var_00++) {
    var_01 = get_num_of_queen_along_path(1, var_00, 1, 0);
    if(var_01 > 1) {
      return 1;
    }
  }

  return 0;
}

fail_up_down_check() {
  for(var_00 = 1; var_00 <= 8; var_00++) {
    var_01 = get_num_of_queen_along_path(var_00, 1, 1, 1);
    if(var_01 > 1) {
      return 1;
    }
  }

  for(var_00 = 1; var_00 <= 8; var_00++) {
    var_01 = get_num_of_queen_along_path(1, var_00, 1, 1);
    if(var_01 > 1) {
      return 1;
    }
  }

  return 0;
}

fail_down_up_check() {
  for(var_00 = 1; var_00 <= 8; var_00++) {
    var_01 = get_num_of_queen_along_path(var_00, 1, -1, 1);
    if(var_01 > 1) {
      return 1;
    }
  }

  for(var_00 = 1; var_00 <= 8; var_00++) {
    var_01 = get_num_of_queen_along_path(8, var_00, -1, 1);
    if(var_01 > 1) {
      return 1;
    }
  }

  return 0;
}

get_num_of_queen_along_path(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  var_05 = param_00;
  var_06 = param_01;
  for(;;) {
    if(var_05 > 8 || var_05 < 1) {
      return var_04;
    }

    if(var_06 > 8 || var_06 < 1) {
      return var_04;
    }

    var_07 = get_queen_piece_struct_at("" + var_05, "" + var_06);
    if(!is_empty_queen_piece_struct(var_07)) {
      var_04++;
    }

    var_05 = var_05 + param_02;
    var_06 = var_06 + param_03;
  }
}

debug_solve_eight_queen() {}

secret_button_combo() {
  determine_secret_button_combo();
  level thread player_secret_button_combo_monitor();
  level waittill("GnS_secret_button_combo_entered");
}

player_secret_button_combo_monitor() {
  level endon("game_ended");
  level endon("complete_secret_button_bombo");
  for(;;) {
    foreach(var_01 in level.players) {
      if(distance2dsquared(var_01.origin, (5734, -6217, 120)) < 10000) {
        if(!scripts\engine\utility::istrue(var_01.secret_button_combo_watcher_active)) {
          var_01.secret_button_combo_watcher_active = 1;
          var_01 thread secret_button_combo_watcher(var_01);
        }

        continue;
      }

      var_01 notify("leave_secret_button_combo_range");
      var_01.secret_button_combo_watcher_active = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

determine_secret_button_combo() {
  if(isDefined(level.gns_secret_button_combo)) {
    return;
  }

  var_00 = select_first_piece_of_paper();
  var_01 = select_second_piece_of_paper();
  var_02 = select_third_piece_of_paper();
  place_papers_in_level(var_00.model, var_01.model, var_02.model);
  var_03 = [];
  var_03 = scripts\engine\utility::array_combine(var_03, var_00.button_combo);
  var_03 = scripts\engine\utility::array_combine(var_03, var_01.button_combo);
  var_03 = scripts\engine\utility::array_combine(var_03, var_02.button_combo);
  level.gns_secret_button_combo = var_03;
}

place_papers_in_level(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::getstructarray("gns_button_combo_paper", "targetname");
  var_03 = scripts\engine\utility::array_randomize_objects(var_03);
  place_paper_at(var_03[0], param_00);
  place_paper_at(var_03[1], param_01);
  place_paper_at(var_03[2], param_02);
}

place_paper_at(param_00, param_01) {
  var_02 = spawn("script_model", param_00.origin);
  var_02 setModel(param_01);
  var_02.angles = param_00.angles;
}

select_first_piece_of_paper() {
  var_00 = spawnStruct();
  var_01 = ["cp_final_button_combo_paper_1a", "cp_final_button_combo_paper_2a", "cp_final_button_combo_paper_3a"];
  var_02 = [["up_D_pad", "right_D_pad", "down_D_pad"],
    ["down_D_pad", "up_D_pad", "right_D_pad"],
    ["up_D_pad", "down_D_pad", "up_D_pad"]];
  var_03 = randomint(var_01.size);
  var_00.model = var_01[var_03];
  var_00.button_combo = var_02[var_03];
  return var_00;
}

select_second_piece_of_paper() {
  var_00 = spawnStruct();
  var_01 = ["cp_final_button_combo_paper_1b", "cp_final_button_combo_paper_2b", "cp_final_button_combo_paper_3b"];
  var_02 = [["right_D_pad", "right_D_pad", "down_D_pad"],
    ["up_D_pad", "up_D_pad", "down_D_pad"],
    ["down_D_pad", "down_D_pad", "right_D_pad"]];
  var_03 = randomint(var_01.size);
  var_00.model = var_01[var_03];
  var_00.button_combo = var_02[var_03];
  return var_00;
}

select_third_piece_of_paper() {
  var_00 = spawnStruct();
  var_01 = ["cp_final_button_combo_paper_1c", "cp_final_button_combo_paper_2c", "cp_final_button_combo_paper_3c"];
  var_02 = [["up_D_pad", "down_D_pad"],
    ["right_D_pad", "up_D_pad"],
    ["down_D_pad", "right_D_pad"]];
  var_03 = randomint(var_01.size);
  var_00.model = var_01[var_03];
  var_00.button_combo = var_02[var_03];
  return var_00;
}

secret_button_combo_watcher(param_00) {
  level endon("game_ended");
  level endon("complete_secret_button_bombo");
  param_00 endon("disconnect");
  param_00 endon("leave_secret_button_combo_range");
  param_00 set_up_secret_button_notify(param_00);
  for(;;) {
    var_01 = 0;
    var_02 = level.gns_secret_button_combo[0];
    param_00 waittill(var_02);
    for(var_03 = 1; var_03 < level.gns_secret_button_combo.size; var_03++) {
      var_02 = level.gns_secret_button_combo[var_03];
      var_04 = param_00 scripts\engine\utility::waittill_any_in_array_or_timeout(["up_D_pad", "down_D_pad", "right_D_pad", "jump"], 1);
      if(!var_04 == var_02) {
        break;
      }

      if(var_03 == level.gns_secret_button_combo.size - 1 && var_04 == var_02) {
        var_01 = 1;
      }
    }

    if(var_01 == 1) {
      break;
    }
  }

  level notify("GnS_secret_button_combo_entered");
}

set_up_secret_button_notify(param_00) {
  if(scripts\engine\utility::istrue(param_00.set_up_secret_button_notify)) {
    return;
  }

  param_00 notifyonplayercommand("up_D_pad", "+actionslot 1");
  param_00 notifyonplayercommand("down_D_pad", "+actionslot 2");
  param_00 notifyonplayercommand("right_D_pad", "+actionslot 4");
  param_00 notifyonplayercommand("jump", "+gostand");
  param_00 notifyonplayercommand("jump", "+moveup");
  param_00.set_up_secret_button_notify = 1;
}

complete_secret_button_combo() {
  level notify("complete_secret_button_bombo");
  foreach(var_01 in level.players) {
    if(randomint(100) > 50) {
      var_01 thread scripts\cp\cp_vo::try_to_play_vo("access_ghostnskulls", "final_comment_vo");
      continue;
    }

    var_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcade_power_on", "final_comment_vo");
  }

  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(6);
}

debug_secret_button_combo() {}

wait_for_player_activation() {
  level endon("player_debug_activate_cabinet");
  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], (5638, -6260, 103));
  triggerfx(level.gns_game_console_vfx);
  var_00 = (5652, -6231, 71);
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

      if(scripts\engine\utility::istrue(var_04.isusingsupercard)) {
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

        if(scripts\engine\utility::istrue(var_04.isusingsupercard)) {
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
  level notify("players_activated_gns");
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(-1, 0.5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::start_ghost_wave();
}

debug_wait_for_player_activation() {}

cp_final_gns_5_setup() {
  level.gns_num_of_wave = 3;
  level.init_formation_movement_func = ::gns4_formation_movement;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
  level.death_trigger_reset_y_pos = 9434;
  level.death_trigger_activate_y_pos = 10363;
  level.original_death_grid_lines_front_y_pos = 12030;
  level.moving_target_pre_fly_time = 0.5;
  level.zombie_ghost_color_manager = ::cp_final_ghost_color_manager;
  level.get_fake_ghost_model_func = ::final_get_fake_ghost_model_func;
  level.set_moving_target_color_func = ::cp_final_set_moving_target_color;
  level.hit_wrong_moving_target_func = ::cp_final_hit_wrong_moving_target_func;
  level.should_moving_target_explode = ::cp_final_should_moving_target_explode;
  level.process_moving_target_hit_func = ::cp_final_process_moving_target_hit_with_right_color;
  level.moving_target_activation_func = ::cp_final_moving_target_activation_func;
  level.ghost_n_skull_reactivate_func = ::reactivate_skullbuster_cabinet;
  level.gns_reward_func = ::final_gns_player_reward_func;
  level.gns_hotjoin_wait_notify = "finish_intro_gesture";
  level.reset_moving_target_wave_data = ::cp_final_reset_moving_target_wave_data;
  level.gns_start_func = ::final_gns_start_func;
  level.pre_gns_end_func = ::final_pre_gns_end_func;
  init_ghost_n_skull_5_quest();
  load_cp_final_ghost_vfx();
  register_ghost_form();
  register_waves_movement();
}

load_cp_final_ghost_vfx() {
  level._effect["ghost_explosion_death_red"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_red.vfx");
  level._effect["ghost_explosion_death_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_yellow.vfx");
  level._effect["ghost_explosion_death_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_zmb_ghost_imp_blue.vfx");
  level._effect["combo_arc_long_green"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_long_green.vfx");
  level._effect["combo_arc_long_blue"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_long_blue.vfx");
  level._effect["combo_arc_long_yellow"] = loadfx("vfx\iw7\core\zombie\ghosts_n_skulls\vfx_ghost_combo_arc_long_yellow.vfx");
  level._effect["sb_quest_item_pickup"] = loadfx("vfx\iw7\core\zombie\vfx_zom_souvenir_pickup.vfx");
  level._effect["gns_skull_meter_burst"] = loadfx("vfx\iw7\levels\cp_final\gns\vfx_skull_complete.vfx");
}

gns4_formation_movement() {
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
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 6);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 8);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2, 9);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 13);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3, 15);
}

register_waves_movement() {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(1, 2, 4, 0.5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(2, 2, 4, 0.5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(3, 2, 4.3, 0.5);
  level.available_formations = undefined;
  level.formation_movements = undefined;
}

cp_final_set_moving_target_color(param_00, param_01) {}

cp_final_hit_wrong_moving_target_func(param_00, param_01, param_02) {
  level thread cp_final_hit_wrong_moving_target_func_internal(param_00, param_01, param_02);
}

cp_final_hit_wrong_moving_target_func_internal(param_00, param_01, param_02) {
  var_03 = 0.3;
  var_04 = get_combo_group_index_for(param_01);
  var_05 = get_moving_targets_in_combo(param_01);
  delete_combo_group_at(var_04);
  add_to_escaping_skulls(var_05);
  foreach(var_07 in var_05) {
    var_07 notify("break_from_combo");
    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_moving_target_color(var_07, "red");
  }

  foreach(var_07 in var_05) {
    if(isDefined(var_07)) {
      level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_07);
    }

    wait(var_03);
  }
}

add_to_escaping_skulls(param_00) {
  if(!isDefined(level.escaping_skulls)) {
    level.escaping_skulls = [];
  }

  level.escaping_skulls = scripts\engine\utility::array_combine(level.escaping_skulls, param_00);
}

get_moving_targets_in_combo(param_00) {
  var_01 = get_combo_group_index_for(param_00);
  return get_combo_group_at_index(var_01);
}

cp_final_should_moving_target_explode(param_00, param_01) {
  var_02 = get_ghost_color(param_00);
  if(isDefined(param_01.color) && param_01.color != var_02) {
    return 0;
  }

  return 1;
}

get_ghost_color(param_00) {
  if(is_bomb(param_00)) {
    return strtok(param_00.color, "_")[0];
  }

  return param_00.color;
}

cp_final_ghost_color_manager() {
  var_00 = 6;
  var_01 = 6;
  var_02 = 6;
  var_03 = 1;
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  var_0A = 0;
  foreach(var_0C in level.zombie_ghosts) {
    if(var_0C.color == "red_bomb") {
      var_07++;
    }

    if(var_0C.color == "green_bomb") {
      var_08++;
    }

    if(var_0C.color == "yellow_bomb") {
      var_09++;
    }

    if(var_0C.color == "blue_bomb") {
      var_0A++;
    }

    if(var_0C.color == "green") {
      var_04++;
    }

    if(var_0C.color == "yellow") {
      var_05++;
    }

    if(var_0C.color == "blue") {
      var_06++;
    }
  }

  if(var_07 < var_03) {
    level.zombie_ghost_model = "zombie_ghost_bomb_red";
    return;
  }

  if(var_08 < var_03) {
    level.zombie_ghost_model = "zombie_ghost_bomb_green";
    return;
  }

  if(var_09 < var_03) {
    level.zombie_ghost_model = "zombie_ghost_bomb_yellow";
    return;
  }

  if(var_0A < var_03) {
    level.zombie_ghost_model = "zombie_ghost_bomb_blue";
    return;
  }

  if(var_04 < var_00) {
    level.zombie_ghost_model = "zombie_ghost_cube_green";
    return;
  }

  if(var_05 < var_01) {
    level.zombie_ghost_model = "zombie_ghost_cube_yellow";
    return;
  }

  level.zombie_ghost_model = "zombie_ghost_cube_blue";
}

final_get_fake_ghost_model_func(param_00) {
  if(issubstr(param_00, "bomb")) {
    var_01 = strtok(param_00, "_")[0];
    return "fake_zombie_ghost_bomb_" + var_01;
  }

  return "fake_zombie_ghost_cube_" + var_01;
}

cp_final_process_moving_target_hit_with_right_color(param_00, param_01, param_02) {
  if(is_bomb(param_02)) {
    level thread explode_combo_group(param_00, param_01);
    return;
  }

  moving_target_hit_by_cube(param_00, param_01, param_02);
}

explode_combo_group(param_00, param_01) {
  if(!isDefined(param_00.color)) {
    return;
  }

  if(param_00.color == "red") {
    var_02 = level.escaping_skulls;
    level.escaping_skulls = [];
  } else {
    var_03 = get_combo_group_index_for(param_01);
    var_02 = get_moving_targets_in_combo(param_00);
    delete_combo_group_at(var_03);
  }

  var_04 = 0;
  foreach(var_06 in var_02) {
    if(isDefined(var_06)) {
      var_04++;
      playFX(level._effect["ghost_explosion_death_" + var_06.color], var_06.origin, anglesToForward(var_06.angles), anglestoup(var_06.angles));
      scripts\aitypes\zombie_ghost\behaviors::remove_moving_target_default(var_06, param_01);
    }
  }

  if(var_04 >= 10 && !scripts\engine\utility::istrue(param_01.combo_achievement_awarded)) {
    param_01 scripts\cp\zombies\achievement::update_achievement("SUPER_DUPER_COMBO", 1);
    param_01.combo_achievement_awarded = 1;
  }
}

is_bomb(param_00) {
  return issubstr(param_00.color, "bomb");
}

moving_target_hit_by_cube(param_00, param_01, param_02) {
  if(isDefined(param_00.color) && param_00.color == param_02.color) {
    return;
  }

  if(!isDefined(param_00.color)) {
    param_00.color = param_02.color;
    param_00 setscriptablepartstate("skull_vfx", param_02.color);
  }

  var_03 = get_same_color_moving_targets_in_same_group(param_00);
  if(var_03.size == 1) {
    create_new_combo_group([param_00]);
    return;
  }

  add_to_combo_group(var_03, param_00);
  foreach(var_05 in var_03) {
    if(var_05 == param_00) {
      continue;
    }

    level thread create_combo_link_between(var_05, param_00);
  }
}

create_new_combo_group(param_00) {
  var_01 = get_available_combo_group_index();
  level.moving_target_combo_group[var_01] = param_00;
}

get_available_combo_group_index() {
  for(var_00 = 0; var_00 < 100; var_00++) {
    if(!isDefined(level.moving_target_combo_group[var_00])) {
      return var_00;
    }
  }
}

add_to_combo_group(param_00, param_01) {
  param_00 = scripts\engine\utility::array_remove(param_00, param_01);
  var_02 = get_combo_group_index(param_00);
  if(isDefined(var_02)) {
    var_03 = level.moving_target_combo_group[var_02];
    var_03 = scripts\engine\utility::array_add(var_03, param_01);
    level.moving_target_combo_group[var_02] = var_03;
    return;
  }

  create_new_combo_group(scripts\engine\utility::array_add(param_00, param_01));
}

get_combo_group_index(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_04 = get_combo_group_index_for(var_03);
    if(isDefined(var_04)) {
      if(!scripts\engine\utility::array_contains(var_01, var_04)) {
        var_01[var_01.size] = var_04;
      }
    }
  }

  if(var_01.size == 1) {
    return var_01[0];
  }

  var_06 = [];
  foreach(var_04 in var_01) {
    var_08 = get_combo_group_at_index(var_04);
    if(isDefined(var_08)) {
      var_06 = scripts\engine\utility::array_combine(var_06, var_08);
      delete_combo_group_at(var_04);
    }
  }

  create_new_combo_group(var_06);
  return get_combo_group_index_for(param_00[0]);
}

delete_combo_group_at(param_00) {
  level.moving_target_combo_group[param_00] = undefined;
}

get_combo_group_at_index(param_00) {
  return level.moving_target_combo_group[param_00];
}

get_combo_group_index_for(param_00) {
  foreach(var_03, var_02 in level.moving_target_combo_group) {
    if(scripts\engine\utility::array_contains(var_02, param_00)) {
      return var_03;
    }
  }

  return undefined;
}

get_same_color_moving_targets_in_same_group(param_00) {
  var_01 = -31311;
  var_02 = [];
  var_03 = undefined;
  foreach(var_05 in level.moving_target_groups) {
    if(scripts\engine\utility::array_contains(var_05, param_00)) {
      var_03 = var_05;
    }
  }

  foreach(var_08 in var_03) {
    if(isDefined(var_08.color) && var_08.color == param_00.color && distancesquared(var_08.origin, param_00.origin) <= var_01) {
      var_02[var_02.size] = var_08;
    }
  }

  return var_02;
}

break_combo_group_for(param_00) {
  param_00 notify("break_from_combo");
  if(isDefined(param_00.linked_moving_targets)) {
    foreach(var_02 in param_00.linked_moving_targets) {
      if(isDefined(var_02.linked_moving_targets)) {
        var_02.linked_moving_targets = scripts\engine\utility::array_remove(var_02.linked_moving_targets, param_00);
      }
    }
  }
}

create_combo_link_between(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("death");
  param_00 endon("break_from_combo");
  param_01 endon("break_from_combo");
  for(;;) {
    var_02 = param_00.origin;
    var_03 = param_01.origin;
    var_04 = var_03 - var_02;
    var_05 = vectortoangles(var_04);
    playfxbetweenpoints(level._effect["combo_arc_long_" + param_00.color], var_02, var_05, var_03);
    wait(0.2);
  }
}

final_gns_player_reward_func() {
  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_01);
    var_01 scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_consumable_meter_scalar(var_01, 2);
    if(!scripts\engine\utility::istrue(level.entered_thru_card)) {
      var_01 scripts\cp\zombies\achievement::update_achievement("CRACKING_SKULLS", 1);
    }
  }

  level notify("end_this_thread_of_gns_fnf_card");
}

cp_final_reset_moving_target_wave_data() {
  level.moving_target_combo_group = [];
}

cp_final_moving_target_activation_func(param_00) {}

final_gns_start_func() {
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_remove(level.additional_laststand_weapon_exclusion, "iw7_entangler_zm");
}

final_pre_gns_end_func() {
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_add(level.additional_laststand_weapon_exclusion, "iw7_entangler_zm");
}

reactivate_skullbuster_cabinet() {
  if(!scripts\cp\zombies\zombie_quest::quest_line_exist("reactivateghost")) {
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 0, ::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet, ::secret_button_combo, ::complete_secret_button_combo, ::debug_secret_button_combo, 5, "Enter secret button combo");
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 1, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation, 5, "Wait for player activation");
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("reactivateghost");
}