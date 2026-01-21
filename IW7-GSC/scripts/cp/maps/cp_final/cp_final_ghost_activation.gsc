/******************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  var_0 = scripts\engine\utility::getstructarray("ghost_n_skull_box", "script_noteworthy");
  var_1 = scripts\engine\utility::random(var_0);
  set_up_ghost_box(var_1);
  wait_for_explosive_damage(var_1);
  var_2 = box_open_sequence(var_1);
  var_2 thread skull_damage_monitor(var_2);
  var_2 waittill("death");
}

box_open_sequence(var_0) {
  var_1 = 0.7;
  var_2 = 25;
  var_3 = 0.8;
  var_0.var_2F12 setModel("ship_hallway_control_box_body");
  var_4 = spawn("script_model", var_0.door_struct.origin);
  var_4 setModel("ship_hallway_control_box_door");
  var_4.angles = var_0.door_struct.angles;
  var_0.var_5978 = var_4;
  var_5 = spawn("script_model", var_0.skull_struct.origin);
  var_5 setModel("zmb_8_bit_price_unlit");
  var_5.angles = var_0.skull_struct.angles;
  var_0.skull = var_5;
  var_5 setscriptablepartstate("skull_vfx", "green");
  var_0.var_5978 rotateto(var_0.door_open_struct.angles, var_1);
  wait(var_1);
  var_6 = var_5.origin + anglesToForward(var_5.angles) * var_2;
  var_5 moveto(var_6, var_3);
  return var_5;
}

skull_damage_monitor(var_0) {
  var_0.health = 999999;
  var_0 setCanDamage(1);
  var_0 setCanRadiusDamage(1);
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;
    if(isDefined(var_2) && isplayer(var_2)) {
      playFX(level._effect["ghost_explosion_death_green"], var_0.origin);
      var_0 delete();
      return;
    }
  }
}

wait_for_explosive_damage(var_0) {
  var_1 = var_0.var_2F12;
  var_1.health = 999999;
  var_1 setCanDamage(1);
  var_1 setCanRadiusDamage(1);
  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_1.health = 999999;
    if(isDefined(var_6) && is_explosive_damage(var_6)) {
      return;
    }
  }
}

is_explosive_damage(var_0) {
  switch (var_0) {
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

set_up_ghost_box(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "ghost_n_skull_door":
        var_0.door_struct = var_3;
        break;

      case "ghost_n_skull_door_open":
        var_0.door_open_struct = var_3;
        break;

      case "ghost_n_skull_skull":
        var_0.skull_struct = var_3;
        break;
    }
  }

  var_5 = spawn("script_model", var_0.origin);
  var_5 setModel("ship_hallway_control_box");
  var_5.angles = var_0.angles;
  var_0.var_2F12 = var_5;
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
      var_0 = level scripts\engine\utility::waittill_any_timeout(1.5, "not_all_player_on_pressure_plate");
      if(var_0 == "not_all_player_on_pressure_plate") {
        continue;
      }
    }

    turn_off_map_marker();
    start_pressure_plate_zombie_spawn();
    turn_on_plate_center_vfx();
    turn_on_pressure_beam_vfx();
    turn_on_skull_meter();
    var_0 = level scripts\engine\utility::waittill_any_timeout(60, "not_all_player_on_pressure_plate");
    turn_off_plate_center_vfx();
    turn_off_pressure_beam_vfx();
    if(var_0 == "timeout") {
      turn_off_rise_loop_sfx();
      play_charge_complete_sfx();
      skull_meter_move_to_collection_loc();
      level.skull_meter thread skull_time_out_monitor();
      level.skull_meter thread skull_picked_up_monitor();
      var_0 = level.skull_meter scripts\engine\utility::waittill_any_return("skull_time_out", "skull_picked_up");
      turn_off_skull_meter();
      stop_pressure_plate_zombie_spawn();
      if(var_0 == "skull_picked_up") {
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
  var_0 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.vfx_ent setscriptablepartstate("map_marker", "on");
  }
}

turn_off_map_marker() {
  var_0 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.vfx_ent setscriptablepartstate("map_marker", "off");
  }
}

skull_picked_up_monitor() {
  level.skull_meter endon("skull_time_out");
  for(;;) {
    foreach(var_1 in level.players) {
      if(isDefined(level.skull_meter)) {
        if(distancesquared(var_1 getEye(), level.skull_meter.origin) <= 2500) {
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
  for(var_0 = 3; var_0 > 0; var_0--) {
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
  var_0 = spawn("script_model", (1467, 2775, -277));
  var_0 setModel("final_gns_quest_origin");
  level.pressure_beam_vfx_ent = var_0;
}

turn_on_skull_meter() {
  var_0 = spawn("script_model", (1467, 2775, -267));
  var_0 setModel("final_gns_quest_origin");
  var_0 playLoopSound("cp_final_pressure_plate_skull_rise_lp");
  var_0 thread skull_meter_glow_manager(var_0);
  var_0 thread skull_meter_move_up(var_0);
  var_0 thread keep_rotate(var_0);
  level.skull_meter = var_0;
}

turn_off_rise_loop_sfx() {
  level.skull_meter stoploopsound("cp_final_pressure_plate_skull_rise_lp");
}

skull_meter_move_to_collection_loc() {
  level.skull_meter setModel("zmb_8_bit_price_unlit");
  level.skull_meter setscriptablepartstate("skull_vfx", "green");
  playFX(level._effect["gns_skull_meter_burst"], level.skull_meter.origin);
  var_0 = [(1923, 3117, -72), (1650, 2449, -72), (1173, 3407, 76), (1311, 2369, 76)];
  var_1 = scripts\engine\utility::random(var_0);
  level.skull_meter moveto(var_1, 0.5, 0.5);
  level.skull_meter waittill("movedone");
}

skull_meter_move_up(var_0) {
  var_0 moveto(var_0.origin + (0, 0, 200), 60);
}

skull_meter_glow_manager(var_0) {
  var_0 endon("death");
  var_1 = 20;
  var_0 setscriptablepartstate("skull_vfx", "small_glow");
  wait(var_1);
  var_0 setscriptablepartstate("skull_vfx", "mid_glow");
  wait(var_1);
  var_0 setscriptablepartstate("skull_vfx", "big_glow");
}

keep_rotate(var_0) {
  var_0 endon("death");
  for(;;) {
    var_0 rotateyaw(360, 3);
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
  var_0 = getent("pressure_plate_volume", "targetname");
  for(;;) {
    if(all_players_touch_volume(var_0)) {
      level notify("all_player_on_pressure_plate");
    } else {
      level notify("not_all_player_on_pressure_plate");
    }

    scripts\engine\utility::waitframe();
  }
}

all_players_touch_volume(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 istouching(var_0)) {
      return 0;
    }
  }

  var_4 = level.players.size;
  if(var_4 == 1) {
    return 1;
  }

  for(var_5 = 0; var_5 < var_4 - 1; var_5++) {
    var_6 = level.players[var_5];
    var_7 = level.players[var_5 + 1];
    if(distance2dsquared(var_6.origin, var_7.origin) < 10000) {
      return 0;
    }
  }

  return 1;
}

spawn_vfx_ent_at_plate_center() {
  var_0 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("final_gns_quest_origin");
    var_2.vfx_ent = var_3;
  }
}

turn_on_plate_center_vfx() {
  var_0 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(player_standing_on_plate(var_2)) {
      var_2.vfx_ent setscriptablepartstate("pressure_plate", "on");
    }
  }
}

turn_off_plate_center_vfx() {
  var_0 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.vfx_ent setscriptablepartstate("pressure_plate", "off");
  }
}

player_standing_on_plate(var_0) {
  foreach(var_2 in level.players) {
    if(distance2dsquared(var_0.vfx_ent.origin, var_2.origin) <= 6400) {
      return 1;
    }
  }

  return 0;
}

clean_up_vfx_ent() {
  var_0 = scripts\engine\utility::getstructarray("pressure_plate_center", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.vfx_ent)) {
      var_2.vfx_ent delete();
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
  var_0 = 12;
  set_pressure_plate_max_zombie_spawn(12, 11, 10, 9);
  set_pressure_plate_zombie_spawn_delay(2.7, 2.8, 2.9, 3);
  level.max_wave_spawn_num = 10;
  level.wait_time_between_wave = 3.5;
  wait(var_0);
  set_pressure_plate_max_zombie_spawn(14, 13, 12, 11);
  set_pressure_plate_zombie_spawn_delay(2.5, 2.6, 2.7, 2.8);
  level.max_wave_spawn_num = 12;
  level.wait_time_between_wave = 3;
  wait(var_0);
  set_pressure_plate_max_zombie_spawn(16, 15, 14, 13);
  set_pressure_plate_zombie_spawn_delay(2.3, 2.4, 2.5, 2.6);
  level.max_wave_spawn_num = 14;
  level.wait_time_between_wave = 2.5;
  wait(var_0);
  set_pressure_plate_max_zombie_spawn(18, 17, 16, 15);
  set_pressure_plate_zombie_spawn_delay(2.1, 2.2, 2.3, 2.4);
  level.max_wave_spawn_num = 16;
  level.wait_time_between_wave = 2;
  wait(var_0);
  set_pressure_plate_max_zombie_spawn(20, 19, 18, 17);
  set_pressure_plate_zombie_spawn_delay(1.9, 2, 2.1, 2.2);
  level.max_wave_spawn_num = 18;
  level.wait_time_between_wave = 1.5;
}

set_pressure_plate_max_zombie_spawn(var_0, var_1, var_2, var_3) {
  switch (level.players.size) {
    case 4:
      level.pressure_plate_max_zombie_spawn = var_0;
      break;

    case 3:
      level.pressure_plate_max_zombie_spawn = var_1;
      break;

    case 2:
      level.pressure_plate_max_zombie_spawn = var_2;
      break;

    case 1:
      level.pressure_plate_max_zombie_spawn = var_3;
      break;

    default:
      break;
  }
}

set_pressure_plate_zombie_spawn_delay(var_0, var_1, var_2, var_3) {
  switch (level.players.size) {
    case 4:
      level.pressure_plate_zombie_spawn_delay = var_0;
      break;

    case 3:
      level.pressure_plate_zombie_spawn_delay = var_1;
      break;

    case 2:
      level.pressure_plate_zombie_spawn_delay = var_2;
      break;

    case 1:
      level.pressure_plate_zombie_spawn_delay = var_3;
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
  var_0 = 0;
  for(;;) {
    if(can_spawn_zombie()) {
      var_1 = get_zombie_spawner();
      var_2 = var_1 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1, var_1);
      if(isDefined(var_2)) {
        var_0++;
        var_2.dont_cleanup = 1;
        var_2.synctransients = "sprint";
        var_2 thread play_intro(var_2);
      }
    }

    wait(get_zombie_spawn_delay());
    if(!scripts\engine\utility::flag("pressure_plate_zombie_spawn")) {
      scripts\engine\utility::flag_wait("pressure_plate_zombie_spawn");
      continue;
    }

    if(should_do_wave_spawn()) {
      if(should_do_wait_between_wave(var_0)) {
        var_0 = 0;
        wait_between_wave();
      }
    }
  }
}

play_intro(var_0) {
  var_0 endon("death");
  var_0 waittill("intro_vignette_done");
  var_0.synctransients = "sprint";
}

get_zombie_spawner() {
  var_0 = 20;
  var_1 = undefined;
  var_2 = [(1142, 2093, -173), (1363, 1911, -173), (1876, 2162, -173), (2011, 2180, -173), (2118, 3432, -173), (1843, 3575, -173), (1561, 3488, -173), (1391, 3544, -173), (1254, 3316, -173), (869, 3239, -173)];
  var_1 = scripts\engine\utility::random(var_2);
  var_3 = randomfloatrange(var_0 * -1, var_0);
  var_4 = randomfloatrange(var_0 * -1, var_0);
  var_1 = (var_1[0] + var_3, var_1[1] + var_4, var_1[2]);
  var_1 = getclosestpointonnavmesh(var_1);
  var_5 = spawnStruct();
  var_5.origin = var_1;
  var_5.angles = vectortoangles((-26, -110, 18));
  var_5.script_parameters = "ground_spawn_no_boards";
  var_5.script_animation = "spawn_ground";
  var_5.script_fxid = "concrete";
  return var_5;
}

can_spawn_zombie() {
  var_0 = 20;
  if(isDefined(level.pressure_plate_max_zombie_spawn)) {
    var_1 = level.pressure_plate_max_zombie_spawn;
  } else {
    var_1 = var_1;
  }

  return get_num_alive_agent_of_type("generic_zombie") < var_1;
}

get_num_alive_agent_of_type(var_0) {
  var_1 = 0;
  foreach(var_3 in level.spawned_enemies) {
    if(isDefined(var_3.agent_type) && var_3.agent_type == var_0) {
      var_1++;
    }
  }

  return var_1;
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

should_do_wait_between_wave(var_0) {
  return var_0 >= level.max_wave_spawn_num;
}

wait_between_wave() {
  var_0 = 10;
  if(isDefined(level.wait_time_between_wave)) {
    wait(level.wait_time_between_wave);
    return;
  }

  wait(var_0);
}

wait_one_wave() {
  level scripts\engine\utility::waittill_any("regular_wave_starting", "event_wave_starting");
}

select_odd_cipher() {
  var_0 = [(5284, -6290, 85), (4805, -6460, 69), (1945, 2637, -264), (280, 4022, 65), (-308, 5397, 66), (3, 4033, 40), (3379, -4234, 68), (265, 4916, 20)];
  var_1 = [(360, 180, 90), (0, 0, 90), (0, 73, 90), (360, 90, 90), (360, 180, 90), (0, 0, 90), (0, 90, 90), (0, 350, 90)];
  var_2 = ["p", "w", "z", "y"];
  var_3 = ["a", "k", "t", "x"];
  var_4 = [var_2, var_3];
  var_5 = [0, 1, 2, 3, 4, 5, 6, 7];
  for(;;) {
    var_6 = scripts\engine\utility::array_randomize_objects(var_5);
    var_7 = get_cipher_group_index(var_4);
    var_8 = var_4[var_7.target_index];
    var_9 = var_4[var_7.non_target_index];
    var_9 = scripts\engine\utility::array_randomize_objects(var_9);
    var_10 = scripts\engine\utility::random(var_8);
    var_11 = [];
    for(var_12 = 0; var_12 < 3; var_12++) {
      var_11[var_12] = var_9[var_12];
    }

    level.gns_ciphers = [];
    for(var_13 = 0; var_13 < 4; var_13++) {
      if(var_13 == 3) {
        create_cipher(var_10, var_0[var_6[var_13]], var_1[var_6[var_13]], "correct_choice");
        continue;
      }

      create_cipher(var_11[var_13], var_0[var_6[var_13]], var_1[var_6[var_13]], "wrong_choice");
    }

    level waittill("GnS_cipher_selected", var_14);
    clean_up_ciphers();
    if(var_14 == "correct_choice") {
      break;
    } else {
      wait_one_wave();
    }
  }
}

get_cipher_group_index(var_0) {
  var_1 = spawnStruct();
  var_2 = [];
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2[var_3] = var_3;
  }

  var_1.target_index = scripts\engine\utility::random(var_2);
  var_2 = scripts\engine\utility::array_remove(var_2, var_1.target_index);
  var_1.non_target_index = scripts\engine\utility::random(var_2);
  return var_1;
}

clean_up_ciphers() {
  if(isDefined(level.gns_ciphers)) {
    foreach(var_1 in level.gns_ciphers) {
      if(scripts\engine\utility::istrue(var_1.fading_out)) {
        continue;
      }

      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }
}

create_cipher(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_1);
  var_4 setModel("final_gns_quest_origin");
  var_4.angles = var_2;
  var_4.cipher_character = var_0;
  var_4 setscriptablepartstate("cipher", var_0);
  level.gns_ciphers[level.gns_ciphers.size] = var_4;
  var_4 thread wait_for_selection(var_4, var_3);
}

wait_for_selection(var_0, var_1) {
  var_0 endon("death");
  wait_for_player_look_at(var_0);
  var_0 thread cipher_vfx_fade_out(var_0);
  if(var_1 == "wrong_choice") {
    playsoundatpos(var_0.origin, "mpq_fail_buzzer");
  }

  level notify("GnS_cipher_selected", var_1);
}

cipher_vfx_fade_out(var_0) {
  var_0.fading_out = 1;
  var_0 endon("death");
  var_0 setscriptablepartstate("cipher", var_0.cipher_character + "_fade");
  wait(3);
  var_0 delete();
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

complete_select_odd_cipher() {
  clean_up_ciphers();
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(3);
}

debug_select_odd_cipher() {}

follow_the_light() {
  for(;;) {
    level thread follow_the_light_manager();
    var_0 = level scripts\engine\utility::waittill_any_return("succeed_follow_the_light", "fail_follow_the_light");
    if(var_0 == "succeed_follow_the_light") {
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
  var_0 = get_follow_the_light_map_marker();
  reset_follow_the_light_setup();
  wait_players_trigger_start();
  var_0 delete();
  create_follow_the_light_node(scripts\engine\utility::getstruct("gns_path_start", "targetname"));
  level waittill("follow_the_light_start_node_picked_up");
  level thread follow_the_light_time_out_monitor();
  for(;;) {
    level waittill("regular_light_node_picked_up");
    expand_light_node_path();
  }
}

get_follow_the_light_map_marker() {
  var_0 = (-274, 3873, 118);
  var_1 = spawn("script_model", var_0);
  var_1 setModel("final_gns_quest_origin");
  var_1 setscriptablepartstate("map_marker", "on");
  return var_1;
}

follow_the_light_time_out_monitor() {
  level endon("game_ended");
  level endon("fail_follow_the_light");
  level endon("succeed_follow_the_light");
  for(;;) {
    var_0 = level scripts\engine\utility::waittill_any_timeout(1.2, "regular_light_node_picked_up");
    if(var_0 == "timeout") {
      play_time_out_sfx();
      level thread fail_follow_the_light();
      return;
    }
  }
}

play_time_out_sfx() {
  var_0 = scripts\engine\utility::random(level.active_light_nodes);
  playsoundatpos(var_0.origin, "mpq_fail_buzzer");
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

  var_0 = get_light_node_structs_to_expand();
  if(var_0.size == 1) {
    foreach(var_2 in var_0) {
      var_2.light_color = level.follow_the_light_target_color;
    }
  }

  foreach(var_2 in var_0) {
    create_follow_the_light_node(var_2);
  }
}

get_light_node_structs_to_expand() {
  var_0 = scripts\engine\utility::getstructarray(level.leading_light_node_struct.target, "targetname");
  if(isDefined(level.leading_light_node_struct.script_parameters) && level.leading_light_node_struct.script_parameters == "gns_path_split") {
    return [scripts\engine\utility::random(var_0)];
  }

  return var_0;
}

create_follow_the_light_node(var_0) {
  level.leading_light_node_struct = var_0;
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel(get_follow_the_light_node_model(var_0));
  var_1 apply_node_scriptable_state(var_1, var_0);
  add_to_active_light_nodes(var_1);
  if(isDefined(var_0.angles)) {
    var_1.angles = var_0.angles;
  }

  if(isDefined(var_0.script_noteworthy)) {
    var_1.progress_index = int(var_0.script_noteworthy);
  }

  var_1 thread player_pick_up_monitor(var_1, var_0);
}

add_to_active_light_nodes(var_0) {
  level.active_light_nodes[level.active_light_nodes.size] = var_0;
}

remove_active_light_nodes_with_index(var_0) {
  foreach(var_2 in level.active_light_nodes) {
    if(isDefined(var_2.progress_index) && var_2.progress_index == var_0) {
      level.active_light_nodes = scripts\engine\utility::array_remove(level.active_light_nodes, var_2);
      var_2 delete();
    }
  }
}

player_pick_up_monitor(var_0, var_1) {
  if(isDefined(var_1.var_336) && var_1.var_336 == "gns_path_start") {
    var_0 thread path_start_pick_up_monitor(var_0);
    return;
  }

  if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "gns_path_end") {
    var_0 thread path_end_pick_up_monitor(var_0);
    return;
  }

  var_0 thread regular_node_pick_up_monitor(var_0);
}

path_start_pick_up_monitor(var_0) {
  var_0 endon("death");
  for(;;) {
    foreach(var_2 in level.players) {
      if(distance2dsquared(var_2.origin, var_0.origin) <= 900) {
        level.follow_the_light_player = var_2;
        level.current_light_node_progress_index++;
        for(var_3 = 0; var_3 < 3; var_3++) {
          expand_light_node_path();
        }

        var_2 turn_on_timer_hud(var_2);
        var_2 thread follow_the_light_timer_logic(var_2);
        var_2 playlocalsound("purchase_ticket");
        level notify("follow_the_light_start_node_picked_up");
        level.active_light_nodes = scripts\engine\utility::array_remove(level.active_light_nodes, var_0);
        var_0 delete();
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

turn_on_timer_hud(var_0) {
  var_0 setclientomnvar("zom_show_gns_timer", 1);
}

turn_off_timer_hud(var_0) {
  if(isDefined(var_0)) {
    var_0 setclientomnvar("zom_show_gns_timer", 0);
  }
}

follow_the_light_timer_logic(var_0) {
  var_0 notify("follow_the_light_timer_logic");
  var_0 endon("follow_the_light_timer_logic");
  var_1 = int(24);
  var_1 = var_1 - 2;
  for(var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = 1 - var_2 / var_1;
    var_0 setclientomnvar("zom_gns_timer_percent", var_3);
    scripts\engine\utility::waitframe();
  }
}

path_end_pick_up_monitor(var_0) {
  var_0 endon("death");
  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || scripts\cp\cp_laststand::player_in_laststand(var_2)) {
        continue;
      }

      if(level.follow_the_light_player != var_2) {
        continue;
      }

      if(distance2dsquared(var_2.origin, var_0.origin) <= 900) {
        if(any_other_active_light_node(var_0)) {
          playsoundatpos(var_0.origin, "mpq_fail_buzzer");
          turn_off_timer_hud(var_2);
          level thread fail_follow_the_light();
          return;
        } else {
          playFX(level._effect["ghost_explosion_death_green"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
          turn_off_timer_hud(var_2);
          level notify("succeed_follow_the_light");
          var_0 delete();
          return;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

any_other_active_light_node(var_0) {
  foreach(var_2 in level.active_light_nodes) {
    if(var_2 == var_0) {
      continue;
    } else {
      return 1;
    }
  }

  return 0;
}

regular_node_pick_up_monitor(var_0) {
  var_0 endon("death");
  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || scripts\cp\cp_laststand::player_in_laststand(var_2)) {
        continue;
      }

      if(level.follow_the_light_player != var_2) {
        continue;
      }

      if(distance2dsquared(var_2.origin, var_0.origin) <= 400) {
        if(var_0.progress_index != level.current_light_node_progress_index) {
          playsoundatpos(var_0.origin, "mpq_fail_buzzer");
          level thread fail_follow_the_light();
          return;
        }

        if(var_0.light_color == level.follow_the_light_target_color) {
          var_2 playlocalsound("purchase_ticket");
          level.current_light_node_progress_index++;
          level notify("regular_light_node_picked_up");
          var_2 thread follow_the_light_timer_logic(var_2);
          level thread remove_active_light_nodes_with_index(level.current_light_node_progress_index - 1);
          return;
        } else {
          playsoundatpos(var_0.origin, "mpq_fail_buzzer");
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
    foreach(var_1 in level.active_light_nodes) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }

    level.active_light_nodes = [];
  }
}

get_follow_the_light_node_model(var_0) {
  if(isDefined(var_0.var_336) && var_0.var_336 == "gns_path_start") {
    return "zmb_8_bit_price_unlit";
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "gns_path_end") {
    return "zmb_8_bit_price_unlit";
  }

  return "final_gns_quest_origin";
}

apply_node_scriptable_state(var_0, var_1) {
  if(isDefined(var_1.var_336) && var_1.var_336 == "gns_path_start") {
    var_0.light_color = level.follow_the_light_target_color;
    var_0 setscriptablepartstate("skull_vfx", "safe_" + level.follow_the_light_target_color);
    return;
  }

  if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "gns_path_end") {
    var_0.light_color = level.follow_the_light_target_color;
    var_0 setscriptablepartstate("skull_vfx", "safe_" + level.follow_the_light_target_color);
    return;
  }

  var_2 = get_regular_light_path_color(var_1);
  var_0.light_color = var_2;
  var_0 setscriptablepartstate("light_to_follow", var_2);
}

get_regular_light_path_color(var_0) {
  if(isDefined(var_0.light_color)) {
    return var_0.light_color;
  }

  if(level.paired_light_node_color.size == 0) {
    level.paired_light_node_color = ["green", "yellow"];
  }

  var_1 = scripts\engine\utility::random(level.paired_light_node_color);
  level.paired_light_node_color = scripts\engine\utility::array_remove(level.paired_light_node_color, var_1);
  return var_1;
}

wait_players_trigger_start() {
  var_0 = int(30);
  var_1 = getent("gns_path_start_volume", "targetname");
  var_2 = 0;
  for(;;) {
    if(any_player_touch_volume(var_1)) {
      var_2++;
      if(var_2 == var_0) {
        return;
      }
    } else {
      var_2 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

any_player_touch_volume(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 istouching(var_0)) {
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

player_interact_monitor(var_0) {
  level endon("complete_solve_eight_queen");
  for(;;) {
    foreach(var_2 in level.players) {
      if(player_interact_with_chess_board(var_2, var_0)) {
        var_3 = var_2.queen_piece_struct_currently_looking_at;
        if(is_empty_queen_piece_struct(var_3)) {
          var_2.num_of_queen_pieces_on_me--;
          var_4 = place_a_queen_on_board_internal(var_3, 1, 0);
          var_4 hudoutlineenableforclient(var_2, 1, 1, 0);
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

player_interact_with_chess_board(var_0, var_1) {
  if(!isDefined(var_0.num_of_queen_pieces_on_me)) {
    return 0;
  }

  if(var_0.num_of_queen_pieces_on_me == 0) {
    return 0;
  }

  if(isDefined(var_0.next_queen_piece_place_time) && gettime() < var_0.next_queen_piece_place_time) {
    return 0;
  }

  if(!player_in_play_space(var_0, var_1)) {
    return 0;
  }

  if(!player_looking_at_any_queen_piece(var_0)) {
    return 0;
  }

  if(!var_0 usebuttonpressed()) {
    return 0;
  }

  return 1;
}

update_player_monitor(var_0) {
  level endon("complete_solve_eight_queen");
  for(;;) {
    foreach(var_2 in level.players) {
      update_queen_piece_state_for_player(var_2, var_0);
    }

    scripts\engine\utility::waitframe();
  }
}

update_queen_piece_state_for_player(var_0, var_1) {
  if(!player_in_play_space(var_0, var_1)) {
    if(player_looking_at_any_queen_piece_struct(var_0)) {
      clear_queen_piece_state_for_player(var_0);
    }

    return;
  }

  var_2 = get_queen_piece_struct_currently_looking_at(var_0, var_1);
  if(isDefined(var_2)) {
    if(!looking_at_the_same_queen_piece(var_0, var_2)) {
      if(player_looking_at_any_queen_piece(var_0)) {
        clear_queen_piece_state_for_player(var_0);
      }

      set_queen_piece_struct_currently_looking_at(var_0, var_2);
    }
  }
}

set_queen_piece_struct_currently_looking_at(var_0, var_1) {
  if(is_empty_queen_piece_struct(var_1)) {
    show_empty_queen_piece_for_player(var_0, var_1);
  } else {
    show_queen_piece_outline_for_player(var_0, var_1);
  }

  var_0.queen_piece_struct_currently_looking_at = var_1;
}

show_queen_piece_outline_for_player(var_0, var_1) {
  var_1.queen_piece hudoutlineenableforclient(var_0, 1, 1, 0);
}

show_empty_queen_piece_for_player(var_0, var_1) {
  if(!isDefined(var_0.num_of_queen_pieces_on_me)) {
    return;
  }

  if(var_0.num_of_queen_pieces_on_me == 0) {
    return;
  }

  if(!isDefined(var_1.empty_queen_piece)) {
    var_1.empty_queen_piece = spawn("script_model", var_1.origin);
    var_1.empty_queen_piece setModel("cp_final_chess_queen_red");
  }
}

player_looking_at_any_queen_piece(var_0) {
  return isDefined(var_0.queen_piece_struct_currently_looking_at);
}

looking_at_the_same_queen_piece(var_0, var_1) {
  return isDefined(var_0.queen_piece_struct_currently_looking_at) && var_0.queen_piece_struct_currently_looking_at == var_1;
}

get_queen_piece_struct_currently_looking_at(var_0, var_1) {
  var_2 = [];
  foreach(var_4 in var_1.queen_piece_struct) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6.allow_pick_up) && var_6.allow_pick_up == 0) {
        continue;
      }

      if(var_0 worldpointinreticle_circle(var_6.origin, 25, 75)) {
        var_2[var_2.size] = var_6;
      }
    }
  }

  return scripts\engine\utility::getclosest(var_0.origin, var_2);
}

clear_queen_piece_state_for_player(var_0) {
  var_1 = var_0.queen_piece_struct_currently_looking_at;
  if(is_empty_queen_piece_struct(var_1)) {
    clear_empty_queen_piece_for_player(var_0, var_1);
  } else {
    hide_queen_piece_outline_for_player(var_0, var_1);
  }

  var_0.queen_piece_struct_currently_looking_at = undefined;
}

hide_queen_piece_outline_for_player(var_0, var_1) {
  var_1.queen_piece hudoutlinedisableforclient(var_0);
}

clear_empty_queen_piece_for_player(var_0, var_1) {
  if(any_other_player_looking_at_it(var_0, var_1)) {
    return;
  }

  if(isDefined(var_1.empty_queen_piece)) {
    var_1.empty_queen_piece delete();
  }
}

any_other_player_looking_at_it(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }

    if(isDefined(var_3.queen_piece_struct_currently_looking_at) && var_3.queen_piece_struct_currently_looking_at == var_1) {
      return 1;
    }
  }

  return 0;
}

player_in_play_space(var_0, var_1) {
  return ispointinvolume(var_0.origin, var_1.play_area);
}

player_looking_at_any_queen_piece_struct(var_0) {
  return isDefined(var_0.queen_piece_struct_currently_looking_at);
}

place_a_queen_on_board(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = get_queen_piece_struct_at(var_1, var_2);
  place_a_queen_on_board_internal(var_3, 0, 0);
}

place_a_queen_on_board_internal(var_0, var_1, var_2) {
  if(!isDefined(level.eight_queen_struct.active_queen_pieces)) {
    level.eight_queen_struct.active_queen_pieces = [];
  }

  if(isDefined(var_0.empty_queen_piece)) {
    var_0.empty_queen_piece delete();
  }

  level.eight_queen_struct.active_queen_pieces[level.eight_queen_struct.active_queen_pieces.size] = var_0;
  return place_a_queen_piece_at(var_0, var_1, var_2, 1);
}

remove_a_queen_from_board(var_0) {
  level.eight_queen_struct.active_queen_pieces = scripts\engine\utility::array_remove(level.eight_queen_struct.active_queen_pieces, var_0);
}

get_queen_piece_struct_at(var_0, var_1) {
  return level.eight_queen_struct.queen_piece_struct[var_0][var_1];
}

create_queen_pieces_for_pick_up(var_0) {
  var_1 = scripts\engine\utility::getstructarray("eight_queen_pick_up", "targetname");
  var_1 = remove_non_empty_queen_struct(var_1);
  var_1 = scripts\engine\utility::array_randomize_objects(var_1);
  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = var_1[var_2];
    place_a_queen_piece_at(var_3, 1, 1, 0);
    scripts\engine\utility::waitframe();
  }
}

place_a_queen_piece_at(var_0, var_1, var_2, var_3) {
  var_0.allow_pick_up = var_1;
  var_4 = spawn("script_model", var_0.origin);
  var_4 setModel(get_queen_piece_model(var_1));
  if(isDefined(var_0.angles)) {
    var_4.angles = var_0.angles;
  }

  var_0.queen_piece = var_4;
  if(scripts\engine\utility::istrue(var_1)) {
    var_0 thread player_pick_up_queen_piece_monitor(var_0, var_3);
  }

  return var_4;
}

player_pick_up_queen_piece_monitor(var_0, var_1) {
  var_0.queen_piece endon("death");
  level endon("complete_solve_eight_queen");
  wait(1);
  for(;;) {
    foreach(var_3 in level.players) {
      if(player_use_queen_piece_struct(var_0, var_3)) {
        play_pick_up_vfx(var_0, var_3);
        if(!isDefined(var_3.num_of_queen_pieces_on_me)) {
          var_3.num_of_queen_pieces_on_me = 0;
        }

        if(scripts\engine\utility::istrue(var_1)) {
          var_3.next_queen_piece_place_time = gettime() + 1000;
          remove_a_queen_from_board(var_0);
        }

        var_3.num_of_queen_pieces_on_me++;
        var_3 thread eight_queen_player_disconnect_monitor(var_3);
        remove_a_queen_piece_from(var_0);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

eight_queen_player_connect_monitor() {
  level endon("complete_solve_eight_queen");
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread eight_queen_player_disconnect_monitor(var_0);
  }
}

eight_queen_player_disconnect_monitor(var_0) {
  level endon("complete_solve_eight_queen");
  var_0 notify("eight_queen_player_disconnect_monitor");
  var_0 endon("eight_queen_player_disconnect_monitor");
  var_0 waittill("disconnect");
  if(isDefined(var_0.num_of_queen_pieces_on_me) && var_0.num_of_queen_pieces_on_me > 0) {
    level thread create_queen_pieces_for_pick_up(var_0.num_of_queen_pieces_on_me);
  }
}

play_pick_up_vfx(var_0, var_1) {
  playFX(level._effect["sb_quest_item_pickup"], var_0.origin);
}

player_use_queen_piece_struct(var_0, var_1) {
  if(isDefined(var_1.queen_piece_struct_currently_looking_at) && var_1.queen_piece_struct_currently_looking_at != var_0) {
    return 0;
  }

  if(distance2dsquared(var_0.origin, var_1.origin) > 6400) {
    return 0;
  }

  if(!var_1 usebuttonpressed()) {
    return 0;
  }

  if(!var_1 worldpointinreticle_circle(var_0.origin, 55, 75)) {
    return 0;
  }

  return 1;
}

remove_a_queen_piece_from(var_0) {
  if(isDefined(var_0.queen_piece)) {
    var_0.queen_piece delete();
  }
}

get_queen_piece_model(var_0) {
  if(scripts\engine\utility::istrue(var_0)) {
    return "misc_interior_chess_game_white_queen";
  }

  return "misc_interior_chess_game_black_queen";
}

remove_non_empty_queen_struct(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    if(is_empty_queen_piece_struct(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

is_empty_queen_piece_struct(var_0) {
  return !isDefined(var_0.queen_piece);
}

set_up_controlling_struct() {
  var_0 = scripts\engine\utility::getstruct("eight_queen_control", "targetname");
  var_0.queen_piece_struct = [];
  for(var_1 = 1; var_1 <= 8; var_1++) {
    var_0.queen_piece_struct[var_1 + ""] = [];
  }

  var_2 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_4 in var_2) {
    var_5 = var_4.script_noteworthy;
    var_5 = strtok(var_5, " ");
    var_6 = var_5[0];
    var_7 = var_5[1];
    var_0.queen_piece_struct[var_6][var_7] = var_4;
  }

  var_9 = getEntArray(var_0.target, "targetname");
  foreach(var_11 in var_9) {
    switch (var_11.script_noteworthy) {
      case "play_area":
        var_0.play_area = var_11;
        break;
    }
  }

  return var_0;
}

get_initial_queen_placement() {
  var_0 = [["1", "4"], ["3", "4"], ["4", "4"], ["5", "4"], ["6", "4"], ["7", "4"], ["8", "4"]];
  return scripts\engine\utility::random(var_0);
}

complete_solve_eight_queen() {
  clear_queen_piece_outline_for_players();
  level notify("complete_solve_eight_queen");
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(5);
}

clear_queen_piece_outline_for_players() {
  if(isDefined(level.eight_queen_struct) && isDefined(level.eight_queen_struct.active_queen_pieces)) {
    foreach(var_1 in level.eight_queen_struct.active_queen_pieces) {
      if(isDefined(var_1.queen_piece)) {
        foreach(var_3 in level.players) {
          var_1.queen_piece hudoutlinedisableforclient(var_3);
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
  for(var_0 = 1; var_0 <= 8; var_0++) {
    var_1 = get_num_of_queen_along_path(var_0, 1, 0, 1);
    if(var_1 > 1) {
      return 1;
    }
  }

  return 0;
}

fail_column_check() {
  for(var_0 = 1; var_0 <= 8; var_0++) {
    var_1 = get_num_of_queen_along_path(1, var_0, 1, 0);
    if(var_1 > 1) {
      return 1;
    }
  }

  return 0;
}

fail_up_down_check() {
  for(var_0 = 1; var_0 <= 8; var_0++) {
    var_1 = get_num_of_queen_along_path(var_0, 1, 1, 1);
    if(var_1 > 1) {
      return 1;
    }
  }

  for(var_0 = 1; var_0 <= 8; var_0++) {
    var_1 = get_num_of_queen_along_path(1, var_0, 1, 1);
    if(var_1 > 1) {
      return 1;
    }
  }

  return 0;
}

fail_down_up_check() {
  for(var_0 = 1; var_0 <= 8; var_0++) {
    var_1 = get_num_of_queen_along_path(var_0, 1, -1, 1);
    if(var_1 > 1) {
      return 1;
    }
  }

  for(var_0 = 1; var_0 <= 8; var_0++) {
    var_1 = get_num_of_queen_along_path(8, var_0, -1, 1);
    if(var_1 > 1) {
      return 1;
    }
  }

  return 0;
}

get_num_of_queen_along_path(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = var_0;
  var_6 = var_1;
  for(;;) {
    if(var_5 > 8 || var_5 < 1) {
      return var_4;
    }

    if(var_6 > 8 || var_6 < 1) {
      return var_4;
    }

    var_7 = get_queen_piece_struct_at("" + var_5, "" + var_6);
    if(!is_empty_queen_piece_struct(var_7)) {
      var_4++;
    }

    var_5 = var_5 + var_2;
    var_6 = var_6 + var_3;
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
    foreach(var_1 in level.players) {
      if(distance2dsquared(var_1.origin, (5734, -6217, 120)) < 10000) {
        if(!scripts\engine\utility::istrue(var_1.secret_button_combo_watcher_active)) {
          var_1.secret_button_combo_watcher_active = 1;
          var_1 thread secret_button_combo_watcher(var_1);
        }

        continue;
      }

      var_1 notify("leave_secret_button_combo_range");
      var_1.secret_button_combo_watcher_active = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

determine_secret_button_combo() {
  if(isDefined(level.gns_secret_button_combo)) {
    return;
  }

  var_0 = select_first_piece_of_paper();
  var_1 = select_second_piece_of_paper();
  var_2 = select_third_piece_of_paper();
  place_papers_in_level(var_0.model, var_1.model, var_2.model);
  var_3 = [];
  var_3 = scripts\engine\utility::array_combine(var_3, var_0.button_combo);
  var_3 = scripts\engine\utility::array_combine(var_3, var_1.button_combo);
  var_3 = scripts\engine\utility::array_combine(var_3, var_2.button_combo);
  level.gns_secret_button_combo = var_3;
}

place_papers_in_level(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstructarray("gns_button_combo_paper", "targetname");
  var_3 = scripts\engine\utility::array_randomize_objects(var_3);
  place_paper_at(var_3[0], var_0);
  place_paper_at(var_3[1], var_1);
  place_paper_at(var_3[2], var_2);
}

place_paper_at(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_1);
  var_2.angles = var_0.angles;
}

select_first_piece_of_paper() {
  var_0 = spawnStruct();
  var_1 = ["cp_final_button_combo_paper_1a", "cp_final_button_combo_paper_2a", "cp_final_button_combo_paper_3a"];
  var_2 = [["up_D_pad", "right_D_pad", "down_D_pad"], ["down_D_pad", "up_D_pad", "right_D_pad"], ["up_D_pad", "down_D_pad", "up_D_pad"]];
  var_3 = randomint(var_1.size);
  var_0.model = var_1[var_3];
  var_0.button_combo = var_2[var_3];
  return var_0;
}

select_second_piece_of_paper() {
  var_0 = spawnStruct();
  var_1 = ["cp_final_button_combo_paper_1b", "cp_final_button_combo_paper_2b", "cp_final_button_combo_paper_3b"];
  var_2 = [["right_D_pad", "right_D_pad", "down_D_pad"], ["up_D_pad", "up_D_pad", "down_D_pad"], ["down_D_pad", "down_D_pad", "right_D_pad"]];
  var_3 = randomint(var_1.size);
  var_0.model = var_1[var_3];
  var_0.button_combo = var_2[var_3];
  return var_0;
}

select_third_piece_of_paper() {
  var_0 = spawnStruct();
  var_1 = ["cp_final_button_combo_paper_1c", "cp_final_button_combo_paper_2c", "cp_final_button_combo_paper_3c"];
  var_2 = [["up_D_pad", "down_D_pad"], ["right_D_pad", "up_D_pad"], ["down_D_pad", "right_D_pad"]];
  var_3 = randomint(var_1.size);
  var_0.model = var_1[var_3];
  var_0.button_combo = var_2[var_3];
  return var_0;
}

secret_button_combo_watcher(var_0) {
  level endon("game_ended");
  level endon("complete_secret_button_bombo");
  var_0 endon("disconnect");
  var_0 endon("leave_secret_button_combo_range");
  var_0 set_up_secret_button_notify(var_0);
  for(;;) {
    var_1 = 0;
    var_2 = level.gns_secret_button_combo[0];
    var_0 waittill(var_2);
    for(var_3 = 1; var_3 < level.gns_secret_button_combo.size; var_3++) {
      var_2 = level.gns_secret_button_combo[var_3];
      var_4 = var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["up_D_pad", "down_D_pad", "right_D_pad", "jump"], 1);
      if(!var_4 == var_2) {
        break;
      }

      if(var_3 == level.gns_secret_button_combo.size - 1 && var_4 == var_2) {
        var_1 = 1;
      }
    }

    if(var_1 == 1) {
      break;
    }
  }

  level notify("GnS_secret_button_combo_entered");
}

set_up_secret_button_notify(var_0) {
  if(scripts\engine\utility::istrue(var_0.set_up_secret_button_notify)) {
    return;
  }

  var_0 notifyonplayercommand("up_D_pad", "+actionslot 1");
  var_0 notifyonplayercommand("down_D_pad", "+actionslot 2");
  var_0 notifyonplayercommand("right_D_pad", "+actionslot 4");
  var_0 notifyonplayercommand("jump", "+gostand");
  var_0 notifyonplayercommand("jump", "+moveup");
  var_0.set_up_secret_button_notify = 1;
}

complete_secret_button_combo() {
  level notify("complete_secret_button_bombo");
  foreach(var_1 in level.players) {
    if(randomint(100) > 50) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("access_ghostnskulls", "final_comment_vo");
      continue;
    }

    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcade_power_on", "final_comment_vo");
  }

  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(6);
}

debug_secret_button_combo() {}

wait_for_player_activation() {
  level endon("player_debug_activate_cabinet");
  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], (5638, -6260, 103));
  triggerfx(level.gns_game_console_vfx);
  var_0 = (5652, -6231, 71);
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

      if(scripts\engine\utility::istrue(var_4.isusingsupercard)) {
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

        if(scripts\engine\utility::istrue(var_4.isusingsupercard)) {
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
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(1, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_1_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(2, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_2_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(3, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_3_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(4, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_4_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(5, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_5_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(6, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_6_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(7, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_7_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(8, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_8_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(9, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_9_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(10, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_10_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(11, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_11_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(12, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_12_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(13, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_13_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(14, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_14_move_pattern);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_formation_movements(15, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::formation_15_move_pattern);
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

cp_final_set_moving_target_color(var_0, var_1) {}

cp_final_hit_wrong_moving_target_func(var_0, var_1, var_2) {
  level thread cp_final_hit_wrong_moving_target_func_internal(var_0, var_1, var_2);
}

cp_final_hit_wrong_moving_target_func_internal(var_0, var_1, var_2) {
  var_3 = 0.3;
  var_4 = get_combo_group_index_for(var_1);
  var_5 = get_moving_targets_in_combo(var_1);
  delete_combo_group_at(var_4);
  add_to_escaping_skulls(var_5);
  foreach(var_7 in var_5) {
    var_7 notify("break_from_combo");
    scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_moving_target_color(var_7, "red");
  }

  foreach(var_7 in var_5) {
    if(isDefined(var_7)) {
      level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_7);
    }

    wait(var_3);
  }
}

add_to_escaping_skulls(var_0) {
  if(!isDefined(level.escaping_skulls)) {
    level.escaping_skulls = [];
  }

  level.escaping_skulls = scripts\engine\utility::array_combine(level.escaping_skulls, var_0);
}

get_moving_targets_in_combo(var_0) {
  var_1 = get_combo_group_index_for(var_0);
  return get_combo_group_at_index(var_1);
}

cp_final_should_moving_target_explode(var_0, var_1) {
  var_2 = get_ghost_color(var_0);
  if(isDefined(var_1.color) && var_1.color != var_2) {
    return 0;
  }

  return 1;
}

get_ghost_color(var_0) {
  if(is_bomb(var_0)) {
    return strtok(var_0.color, "_")[0];
  }

  return var_0.color;
}

cp_final_ghost_color_manager() {
  var_0 = 6;
  var_1 = 6;
  var_2 = 6;
  var_3 = 1;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  foreach(var_12 in level.zombie_ghosts) {
    if(var_12.color == "red_bomb") {
      var_7++;
    }

    if(var_12.color == "green_bomb") {
      var_8++;
    }

    if(var_12.color == "yellow_bomb") {
      var_9++;
    }

    if(var_12.color == "blue_bomb") {
      var_10++;
    }

    if(var_12.color == "green") {
      var_4++;
    }

    if(var_12.color == "yellow") {
      var_5++;
    }

    if(var_12.color == "blue") {
      var_6++;
    }
  }

  if(var_7 < var_3) {
    level.zombie_ghost_model = "zombie_ghost_bomb_red";
    return;
  }

  if(var_8 < var_3) {
    level.zombie_ghost_model = "zombie_ghost_bomb_green";
    return;
  }

  if(var_9 < var_3) {
    level.zombie_ghost_model = "zombie_ghost_bomb_yellow";
    return;
  }

  if(var_10 < var_3) {
    level.zombie_ghost_model = "zombie_ghost_bomb_blue";
    return;
  }

  if(var_4 < var_0) {
    level.zombie_ghost_model = "zombie_ghost_cube_green";
    return;
  }

  if(var_5 < var_1) {
    level.zombie_ghost_model = "zombie_ghost_cube_yellow";
    return;
  }

  level.zombie_ghost_model = "zombie_ghost_cube_blue";
}

final_get_fake_ghost_model_func(var_0) {
  if(issubstr(var_0, "bomb")) {
    var_1 = strtok(var_0, "_")[0];
    return "fake_zombie_ghost_bomb_" + var_1;
  }

  return "fake_zombie_ghost_cube_" + var_1;
}

cp_final_process_moving_target_hit_with_right_color(var_0, var_1, var_2) {
  if(is_bomb(var_2)) {
    level thread explode_combo_group(var_0, var_1);
    return;
  }

  moving_target_hit_by_cube(var_0, var_1, var_2);
}

explode_combo_group(var_0, var_1) {
  if(!isDefined(var_0.color)) {
    return;
  }

  if(var_0.color == "red") {
    var_2 = level.escaping_skulls;
    level.escaping_skulls = [];
  } else {
    var_3 = get_combo_group_index_for(var_1);
    var_2 = get_moving_targets_in_combo(var_0);
    delete_combo_group_at(var_3);
  }

  var_4 = 0;
  foreach(var_6 in var_2) {
    if(isDefined(var_6)) {
      var_4++;
      playFX(level._effect["ghost_explosion_death_" + var_6.color], var_6.origin, anglesToForward(var_6.angles), anglestoup(var_6.angles));
      scripts\aitypes\zombie_ghost\behaviors::remove_moving_target_default(var_6, var_1);
    }
  }

  if(var_4 >= 10 && !scripts\engine\utility::istrue(var_1.combo_achievement_awarded)) {
    var_1 scripts\cp\zombies\achievement::update_achievement("SUPER_DUPER_COMBO", 1);
    var_1.combo_achievement_awarded = 1;
  }
}

is_bomb(var_0) {
  return issubstr(var_0.color, "bomb");
}

moving_target_hit_by_cube(var_0, var_1, var_2) {
  if(isDefined(var_0.color) && var_0.color == var_2.color) {
    return;
  }

  if(!isDefined(var_0.color)) {
    var_0.color = var_2.color;
    var_0 setscriptablepartstate("skull_vfx", var_2.color);
  }

  var_3 = get_same_color_moving_targets_in_same_group(var_0);
  if(var_3.size == 1) {
    create_new_combo_group([var_0]);
    return;
  }

  add_to_combo_group(var_3, var_0);
  foreach(var_5 in var_3) {
    if(var_5 == var_0) {
      continue;
    }

    level thread create_combo_link_between(var_5, var_0);
  }
}

create_new_combo_group(var_0) {
  var_1 = get_available_combo_group_index();
  level.moving_target_combo_group[var_1] = var_0;
}

get_available_combo_group_index() {
  for(var_0 = 0; var_0 < 100; var_0++) {
    if(!isDefined(level.moving_target_combo_group[var_0])) {
      return var_0;
    }
  }
}

add_to_combo_group(var_0, var_1) {
  var_0 = scripts\engine\utility::array_remove(var_0, var_1);
  var_2 = get_combo_group_index(var_0);
  if(isDefined(var_2)) {
    var_3 = level.moving_target_combo_group[var_2];
    var_3 = scripts\engine\utility::array_add(var_3, var_1);
    level.moving_target_combo_group[var_2] = var_3;
    return;
  }

  create_new_combo_group(scripts\engine\utility::array_add(var_0, var_1));
}

get_combo_group_index(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = get_combo_group_index_for(var_3);
    if(isDefined(var_4)) {
      if(!scripts\engine\utility::array_contains(var_1, var_4)) {
        var_1[var_1.size] = var_4;
      }
    }
  }

  if(var_1.size == 1) {
    return var_1[0];
  }

  var_6 = [];
  foreach(var_4 in var_1) {
    var_8 = get_combo_group_at_index(var_4);
    if(isDefined(var_8)) {
      var_6 = scripts\engine\utility::array_combine(var_6, var_8);
      delete_combo_group_at(var_4);
    }
  }

  create_new_combo_group(var_6);
  return get_combo_group_index_for(var_0[0]);
}

delete_combo_group_at(var_0) {
  level.moving_target_combo_group[var_0] = undefined;
}

get_combo_group_at_index(var_0) {
  return level.moving_target_combo_group[var_0];
}

get_combo_group_index_for(var_0) {
  foreach(var_3, var_2 in level.moving_target_combo_group) {
    if(scripts\engine\utility::array_contains(var_2, var_0)) {
      return var_3;
    }
  }

  return undefined;
}

get_same_color_moving_targets_in_same_group(var_0) {
  var_1 = -31311;
  var_2 = [];
  var_3 = undefined;
  foreach(var_5 in level.moving_target_groups) {
    if(scripts\engine\utility::array_contains(var_5, var_0)) {
      var_3 = var_5;
    }
  }

  foreach(var_8 in var_3) {
    if(isDefined(var_8.color) && var_8.color == var_0.color && distancesquared(var_8.origin, var_0.origin) <= var_1) {
      var_2[var_2.size] = var_8;
    }
  }

  return var_2;
}

break_combo_group_for(var_0) {
  var_0 notify("break_from_combo");
  if(isDefined(var_0.linked_moving_targets)) {
    foreach(var_2 in var_0.linked_moving_targets) {
      if(isDefined(var_2.linked_moving_targets)) {
        var_2.linked_moving_targets = scripts\engine\utility::array_remove(var_2.linked_moving_targets, var_0);
      }
    }
  }
}

create_combo_link_between(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  var_0 endon("break_from_combo");
  var_1 endon("break_from_combo");
  for(;;) {
    var_2 = var_0.origin;
    var_3 = var_1.origin;
    var_4 = var_3 - var_2;
    var_5 = vectortoangles(var_4);
    playfxbetweenpoints(level._effect["combo_arc_long_" + var_0.color], var_2, var_5, var_3);
    wait(0.2);
  }
}

final_gns_player_reward_func() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_1);
    var_1 scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_consumable_meter_scalar(var_1, 2);
    if(!scripts\engine\utility::istrue(level.entered_thru_card)) {
      var_1 scripts\cp\zombies\achievement::update_achievement("CRACKING_SKULLS", 1);
    }
  }

  level notify("end_this_thread_of_gns_fnf_card");
}

cp_final_reset_moving_target_wave_data() {
  level.moving_target_combo_group = [];
}

cp_final_moving_target_activation_func(var_0) {}

final_gns_start_func() {
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_remove(level.additional_laststand_weapon_exclusion, "iw7_entangler_zm");
}

final_pre_gns_end_func() {
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_add(level.additional_laststand_weapon_exclusion, "iw7_entangler_zm");
}

reactivate_skullbuster_cabinet() {
  if(!scripts\cp\zombies\zombie_quest::quest_line_exist("reactivateghost")) {
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 0, scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet, ::secret_button_combo, ::complete_secret_button_combo, ::debug_secret_button_combo, 5, "Enter secret button combo");
    scripts\cp\zombies\zombie_quest::register_quest_step("reactivateghost", 1, ::blank, ::wait_for_player_activation, ::complete_clean_arcade_cabinet, ::debug_wait_for_player_activation, 5, "Wait for player activation");
  }

  level thread scripts\cp\zombies\zombie_quest::start_quest_line("reactivateghost");
}