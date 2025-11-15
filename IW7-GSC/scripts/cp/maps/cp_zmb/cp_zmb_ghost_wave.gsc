/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave.gsc
********************************************************/

init() {
  init_ghost_related_vfx();
  setup_ghost_wave_specific_power();
  init_ghost_spawn_loc();
  init_zombie_ghosts();
  init_ghost_killed_func();
  init_available_formations();
  init_formation_movements();
  init_moving_target_waves();
  scripts\mp\agents\zombie_ghost\zombie_ghost_agent::registerscriptedagent();
}

init_available_formations() {
  level.available_formations = [];
  for(var_00 = 1; var_00 <= level.gns_num_of_wave; var_00++) {
    level.available_formations[var_00] = [];
  }
}

init_formation_movements() {
  if(isDefined(level.init_formation_movement_func)) {
    [[level.init_formation_movement_func]]();
    return;
  }

  init_formation_movements_default();
}

init_formation_movements_default() {
  level.formation_movements = [];
  register_formation_movements(1, ::formation_1_move_pattern);
  register_formation_movements(2, ::formation_2_move_pattern);
  register_formation_movements(3, ::formation_3_move_pattern);
  register_formation_movements(4, ::formation_4_move_pattern);
  register_formation_movements(5, ::formation_5_move_pattern);
  register_formation_movements(6, ::formation_6_move_pattern);
  register_formation_movements(7, ::formation_7_move_pattern);
  register_formation_movements(8, ::formation_8_move_pattern);
  register_formation_movements(9, ::formation_9_move_pattern);
  register_formation_movements(10, ::formation_10_move_pattern);
  register_formation_movements(11, ::formation_11_move_pattern);
  register_formation_movements(12, ::formation_12_move_pattern);
  register_formation_movements(13, ::formation_13_move_pattern);
  register_formation_movements(14, ::formation_14_move_pattern);
  register_formation_movements(15, ::formation_15_move_pattern);
}

init_moving_target_waves() {
  level.moving_target_wave_info = [];
}

register_moving_target_wave(param_00, param_01, param_02, param_03) {
  var_04 = spawnStruct();
  var_04.move_time = param_01;
  var_04.solo_move_time = param_02;
  var_04.wait_between_group_move = param_03;
  var_04.formation_id = scripts\engine\utility::random(level.available_formations[param_00]);
  var_04.move_pattern_func = level.formation_movements[var_04.formation_id];
  level.moving_target_wave_info[param_00] = var_04;
}

use_entangler(param_00) {
  param_00 giveweapon("iw7_entangler_zm");
  param_00 switchtoweaponimmediate("iw7_entangler_zm");
  param_00 scripts\engine\utility::allow_weapon_switch(0);
  param_00 thread entangler_hit_monitor(param_00);
  param_00 thread entangler_recharge_monitor(param_00);
  param_00.powers_before_entangler = param_00 scripts\cp\powers\coop_powers::get_info_for_player_powers(param_00);
  param_00 scripts\cp\powers\coop_powers::clearpowers();
}

stop_using_entangler(param_00) {
  param_00 scripts\engine\utility::allow_weapon_switch(1);
  param_00 takeweapon("iw7_entangler_zm");
  if(!param_00 hasweapon(param_00.weapon_before_entangler)) {
    param_00 scripts\cp\utility::_giveweapon(param_00.weapon_before_entangler, undefined, undefined, 1);
  }

  param_00 switchtoweapon(param_00.weapon_before_entangler);
  param_00 scripts\cp\powers\coop_powers::restore_powers(param_00, param_00.powers_before_entangler);
  param_00 clear_up_previous_scu(param_00);
}

entangler_hit_monitor(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("stop_using_entabgler");
  for(;;) {
    record_entangler_progress_percent(param_00, 0);
    var_01 = 0;
    for(;;) {
      var_02 = param_00 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(0.2, "entangler_hit_same_target");
      if(var_02 == "entangler_hit_same_target") {
        var_01 = var_01 + 0.2;
        var_03 = min(var_01 / get_entangler_track_time(), 1);
        record_entangler_progress_percent(param_00, var_03);
        if(var_03 == 1 && isalive(param_00.current_entangler_target) && !scripts\aitypes\zombie_ghost\behaviors::isentangled(param_00.current_entangler_target) && !isDefined(param_00.ghost_in_entanglement)) {
          param_00.current_entangler_target scripts\aitypes\zombie_ghost\behaviors::entangleghost(param_00.current_entangler_target, param_00);
        }

        continue;
      }

      break;
    }
  }
}

get_entangler_track_time() {
  return 1.25;
}

entangler_recharge_monitor(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("stop_using_entabgler");
  for(;;) {
    wait(0.5);
    param_00 setweaponammoclip("iw7_entangler_zm", weaponclipsize("iw7_entangler_zm"));
  }
}

record_entangler_progress_percent(param_00, param_01) {
  param_00 setclientomnvar("zom_entangler_progress_percent", param_01);
}

update_entangler_progress(param_00, param_01) {
  if(!isDefined(param_00.current_entangler_target) && param_00.current_entangler_target == param_01) {
    param_00 thread current_entangler_target_monitor(param_00, param_01);
    return;
  }

  param_00 notify("entangler_hit_same_target");
}

current_entangler_target_monitor(param_00, param_01) {
  param_00 endon("disconnect");
  param_01 notify("entangler_target_monitor");
  param_01 endon("entangler_target_monitor");
  param_00.current_entangler_target = param_01;
  scripts\engine\utility::waitframe();
  param_00.current_entangler_target = undefined;
}

setup_ghost_wave_specific_power() {
  level.scu_use_func = ::use_scu;
}

use_scu(param_00) {
  var_01 = self;
  param_00 endon("death");
  var_01 endon("death");
  var_01 endon("disconnect");
  if(!scripts\cp\utility::isreallyalive(var_01)) {
    param_00 delete();
    return;
  }

  var_01 thread scripts\cp\powers\coop_powers::givepower("power_scu", "secondary", undefined, undefined, undefined, 0, 0);
  clear_up_previous_scu(var_01);
  var_01.deployed_scu = param_00;
  param_00 waittill("missile_stuck", var_02);
  param_00 thread scu_vfx_manager(param_00, var_01);
  for(;;) {
    scripts\engine\utility::waitframe();
    if(isDefined(var_01.current_entangler_target) && scripts\aitypes\zombie_ghost\behaviors::isentangled(var_01.current_entangler_target)) {
      var_03 = var_01.current_entangler_target;
      if(ghost_can_be_contained(var_03, param_00)) {
        level thread ghost_trail_to_scu(var_03.origin + (0, 0, 40), var_01.deployed_scu.origin, var_01);
        var_03.nocorpse = 1;
        var_03 suicide();
      }
    }
  }
}

ghost_trail_to_scu(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_00);
  var_03 setModel("tag_origin");
  wait(0.1);
  playFXOnTag(level._effect["zombie_ghost_trail"], var_03, "tag_origin");
  var_04 = param_01;
  for(;;) {
    var_03 moveto(var_04, 0.5, 0.125);
    var_03 waittill("movedone");
    if(!isDefined(param_02) && isDefined(param_02.deployed_scu)) {
      break;
    }

    var_04 = param_02.deployed_scu.origin;
    if(distancesquared(var_03.origin, var_04) < 400) {
      break;
    }
  }

  var_03 delete();
}

clear_up_previous_scu(param_00) {
  if(isDefined(param_00.deployed_scu)) {
    if(isDefined(param_00.deployed_scu.light_fx)) {
      param_00.deployed_scu.light_fx delete();
    }

    param_00.deployed_scu delete();
  }
}

scu_vfx_manager(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("disconnect");
  param_00.light_fx = spawnfx(level._effect["zombie_ghost_scu"], param_00.origin);
  scripts\engine\utility::waitframe();
  if(isDefined(param_00)) {
    triggerfx(param_00.light_fx);
  }
}

ghost_can_be_contained(param_00, param_01) {
  if(distancesquared(param_00.origin, param_01.origin) < 6400) {
    return 1;
  }

  return 0;
}

init_ghost_related_vfx() {
  level._effect["zombie_ghost_trail"] = loadfx("vfx\iw7\_requests\coop\zmb_ghost_soultrail");
  level._effect["zombie_ghost_scu"] = loadfx("vfx\iw7\_requests\coop\vfx_ghost_scu");
  level._effect["moving_target_explode"] = loadfx("vfx\iw7\core\zombie\powerups\vfx_zom_powerup_pickup.vfx");
  level._effect["moving_target_portal"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_ghost_portal_green.vfx");
  level._effect["GnS_activation"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_GnS_game_elec_bolts.vfx");
  level._effect["skull_discovered"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_ghost_exp.vfx");
}

init_ghost_spawn_loc() {
  level.zombie_ghost_spawn_nodes = scripts\engine\utility::getstructarray("ghost_spawn", "targetname");
}

spawn_zombie_ghost(param_00, param_01, param_02) {
  if(!isDefined(level.zombie_ghosts)) {
    level.zombie_ghosts = [];
  }

  if(!isDefined(param_02)) {
    param_02 = "axis";
  }

  var_03 = scripts\mp\mp_agent::spawnnewagent("zombie_ghost", param_02, param_00, param_01);
  level.zombie_ghosts[level.zombie_ghosts.size] = var_03;
  return var_03;
}

stop_ghosts_attack_logic() {
  level notify("stop_ghosts_attack_logic");
}

ghosts_attack_logic() {
  level endon("game_ended");
  level endon("stop_ghosts_attack_logic");
  wait(15);
  for(;;) {
    foreach(var_01 in level.players) {
      if(var_01 can_be_attacked_by_ghost(var_01)) {
        var_02 = sortbydistance(level.zombie_ghosts, var_01.origin);
        foreach(var_04 in var_02) {
          if(var_04 can_attack()) {
            var_04 attack(var_01);
            break;
          }
        }
      }
    }

    wait(0.5);
  }
}

can_be_attacked_by_ghost(param_00) {
  if(param_00 scripts\cp\utility::isignoremeenabled()) {
    return 0;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    return 0;
  }

  if(scripts\mp\agents\zombie\zombie_util::isplayerteleporting(param_00)) {
    return 0;
  }

  if(!isalive(param_00)) {
    return 0;
  }

  if(get_num_of_ghosts_attacking_me(param_00) > get_max_num_ghosts_per_player()) {
    return 0;
  }

  if(time_since_last_ghost_attack(param_00) < get_min_player_attack_by_frequency()) {
    return 0;
  }

  return 1;
}

get_max_num_ghosts_per_player() {
  return 4;
}

get_min_player_attack_by_frequency() {
  return 3;
}

can_attack() {
  if(is_ghost_attack_disabled()) {
    return 0;
  }

  var_00 = self;
  if(scripts\aitypes\zombie_ghost\behaviors::isentangled(var_00)) {
    return 0;
  }

  if(var_00 scripts\aitypes\zombie_ghost\behaviors::getghostnavmode() == "attack") {
    return 0;
  }

  if(time_since_last_attack(var_00) < 7) {
    return 0;
  }

  return 1;
}

is_ghost_attack_disabled() {
  return 1;
}

get_num_of_ghosts_attacking_me(param_00) {
  if(!isDefined(param_00.num_of_ghosts_attacking_me)) {
    param_00.num_of_ghosts_attacking_me = 0;
  }

  return param_00.num_of_ghosts_attacking_me;
}

time_since_last_ghost_attack(param_00) {
  if(!isDefined(param_00.last_ghost_attack_time)) {
    param_00.last_ghost_attack_time = 0;
  }

  return gettime() - param_00.last_ghost_attack_time / 1000;
}

time_since_last_attack(param_00) {
  if(!isDefined(param_00.last_attack_time)) {
    param_00.last_attack_time = 0;
  }

  return gettime() - param_00.last_attack_time / 1000;
}

attack(param_00) {
  var_01 = self;
  set_ghost_attack_records(var_01, param_00);
  var_01 thread scripts\aitypes\zombie_ghost\behaviors::ghostattack(param_00);
}

set_ghost_attack_records(param_00, param_01) {
  var_02 = gettime();
  param_01.num_of_ghosts_attacking_me++;
  param_01.last_ghost_attack_time = var_02;
  param_00.last_attack_time = var_02;
}

spawn_ghost_group(param_00) {
  level thread spawn_ghost_group_internal(param_00);
}

spawn_ghost_group_internal(param_00) {
  for(var_01 = 0; var_01 < param_00; var_01++) {
    var_02 = scripts\engine\utility::random(level.zombie_ghost_spawn_nodes);
    var_03 = spawn_zombie_ghost(var_02.origin, (0, 0, 0), "axis");
    scripts\engine\utility::waitframe();
  }
}

init_zombie_ghosts() {
  level.zombie_ghosts = [];
}

start_ghost_wave() {
  if(scripts\engine\utility::istrue(level.gns_active)) {
    return;
  }

  level.gns_active = 1;
  scripts\cp\zombies\zombie_analytics::log_activate_enter_ghostskulls_game(level.wave_num);
  scripts\cp\zombies\coop_wall_buys::set_weapon_purchase_disabled(1);
  disable_pistol_during_laststand();
  start_death_trigger_monitor();
  play_start_ghost_vo_to_players();
  level.ghostskullstimestart = gettime();
  level.processing_ghost_wave_failing = 0;
  level thread moving_targets_sequence();
  level thread ghosts_attack_logic();
  level thread start_ghosts_spawning();
  level thread player_connect_monitor();
  if(isDefined(level.gns_start_func)) {
    [[level.gns_start_func]]();
  }

  foreach(var_01 in level.players) {
    enter_ghosts_n_skulls(var_01);
  }
}

play_start_ghost_vo_to_players() {
  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("ghost_start", "zmb_comment_vo", "low", 3, 0, 0, 1);
  }
}

enter_ghosts_n_skulls(param_00) {
  if(isDefined(level.enter_ghosts_n_skulls_func)) {
    [[level.enter_ghosts_n_skulls_func]](param_00);
  }

  param_00.dontremoveperks = 1;
  param_00 scripts\cp\cp_laststand::enable_self_revive(param_00);
  param_00.weapon_before_entangler = param_00 scripts\cp\utility::getweapontoswitchbackto();
  param_00 scripts\cp\zombies\arcade_game_utility::take_player_super_pre_game();
  param_00.disable_self_revive_fnf = 1;
  param_00.allow_carry = 0;
  param_00.ghost_in_entanglement = undefined;
  param_00.disable_consumables = 1;
  param_00.playing_ghosts_n_skulls = 1;
  param_00 store_and_take_perks(param_00);
  param_00 turn_on_ghost_arcade_hud(param_00);
  param_00 teleport_into_arcade_console(param_00);
  param_00 display_objective_message(param_00);
  param_00 use_entangler(param_00);
  param_00 store_and_reset_currency(param_00);
  param_00 allowmelee(0);
  if(isDefined(level.gns_laststand_monitor)) {
    param_00 thread[[level.gns_laststand_monitor]](param_00);
  }
}

player_connect_monitor() {
  level endon("game_ended");
  level endon("delay_end_ghost");
  for(;;) {
    level waittill("player_spawned", var_00);
    var_00 thread delay_enter_ghosts_n_skulls(var_00);
  }
}

delay_enter_ghosts_n_skulls(param_00) {
  level endon("game_ended");
  level endon("delay_end_ghost");
  param_00 endon("disconnect");
  if(isDefined(level.gns_hotjoin_wait_notify)) {
    param_00 waittill(level.gns_hotjoin_wait_notify);
  }

  wait(5);
  enter_ghosts_n_skulls(param_00);
}

start_death_trigger_monitor() {
  if(scripts\engine\utility::istrue(level.disable_gns_death_trigger)) {
    return;
  }

  var_00 = getent("ghost_death_trigger", "targetname");
  var_00 thread ghost_death_trigger_monitor(var_00);
}

ghost_death_trigger_monitor(param_00) {
  level endon("game_ended");
  param_00 endon("stop_death_trigger_monitor");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isplayer(var_01)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_01)) {
      continue;
    }

    var_01 setvelocity((0, 1400, 700));
    var_01 viewkick(10, var_01.origin);
    var_01 shellshock("default", 3);
    var_01 dodamage(var_01.health, var_01.origin);
  }
}

end_ghost_wave() {
  scripts\cp\zombies\coop_wall_buys::set_weapon_purchase_disabled(0);
  enable_pistol_during_laststand();
  stop_moving_targets_sequence();
  stop_ghosts_attack_logic();
  level thread stop_ghosts_spawning();
}

stop_death_trigger_monitor() {
  var_00 = getent("ghost_death_trigger", "targetname");
  var_00 notify("stop_death_trigger_monitor");
}

end_ghost_sequence(param_00) {
  if(!scripts\engine\utility::istrue(param_00.playing_ghosts_n_skulls)) {
    return;
  }

  param_00 endon("disconnect");
  param_00 restore_all_previous_perks(param_00);
  if(scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    param_00 scripts\cp\cp_laststand::instant_revive(param_00);
    scripts\engine\utility::waitframe();
  }

  param_00 scripts\cp\cp_laststand::disable_self_revive(param_00);
  param_00 turn_off_ghost_arcade_hud(param_00);
  param_00 turn_off_ghost_arcade_scores(param_00);
  param_00 remove_ghost_arcade_message(param_00);
  param_00 stop_using_entangler(param_00);
  param_00 teleport_out_of_arcade_console(param_00);
  param_00 restore_currency(param_00);
  param_00 scripts\cp\utility::restore_super_weapon();
  param_00.dontremoveperks = undefined;
  param_00.disable_self_revive_fnf = undefined;
  param_00.allow_carry = 1;
  param_00.disable_consumables = undefined;
  param_00.playing_ghosts_n_skulls = undefined;
  param_00 allowmelee(1);
  if(isDefined(level.end_ghosts_n_skulls_func)) {
    [[level.end_ghosts_n_skulls_func]](param_00);
  }

  param_00 thread scripts\cp\cp_vo::try_to_play_vo("ghost_end", "zmb_comment_vo", "highest");
}

start_ghosts_spawning() {
  level endon("game_ended");
  level.zombies_paused = 1;
  foreach(var_01 in level.spawned_enemies) {
    if(isDefined(var_01)) {
      var_01.died_poorly = 1;
      var_01.nocorpse = 1;
      var_01 suicide();
    }
  }

  scripts\engine\utility::waitframe();
  level thread scripts\cp\zombies\zombies_spawning::spawn_ghosts();
}

stop_ghosts_spawning() {
  level endon("game_ended");
  level.zombies_paused = 0;
  level notify("stop_ghost_spawn");
  scripts\engine\utility::waitframe();
  foreach(var_01 in level.zombie_ghosts) {
    var_01.died_poorly = 1;
    var_01.nocorpse = 1;
    var_01 suicide();
  }
}

init_ghost_killed_func(param_00, param_01) {
  level.ghost_killed_update_func = ::update_on_ghost_killed;
}

update_on_ghost_killed(param_00, param_01) {
  level.zombie_ghosts = scripts\engine\utility::array_remove(level.zombie_ghosts, self);
  level.characters = scripts\engine\utility::array_remove(level.characters, self);
}

moving_targets_sequence() {
  level endon("game_ended");
  level endon("stop_moving_target_sequence");
  start_ghost_portal_vfx();
  for(var_00 = 1; var_00 <= level.gns_num_of_wave; var_00++) {
    var_01 = scripts\engine\utility::getstructarray("ghost_formation_" + get_formationfunc_for_wave(var_00), "targetname");
    if(var_01.size > 0) {
      level.ghostskulls_total_waves++;
      run_moving_target_wave(var_00, var_01);
      if(isDefined(level.complete_one_gns_wave_func)) {
        level thread[[level.complete_one_gns_wave_func]]();
      }

      continue;
    }

    break;
  }

  game_won_sequence();
}

run_moving_target_wave(param_00, param_01) {
  reset_moving_target_wave_data();
  reset_num_moving_target_reached_goal();
  reset_death_grid_lines_and_trigger();
  wait(2);
  moving_target_intro_sequence(param_01, param_00);
  activate_moving_targets(param_00);
  activate_death_grid_lines_and_trigger();
  level thread moving_targets_attack_logic();
  if(isDefined(level.moving_target_activation_func)) {
    level thread[[level.moving_target_activation_func]](param_00);
  }

  var_02 = get_wave_move_time(param_00);
  var_03 = get_wave_wait_time_between_group(param_00);
  while(active_moving_target_available()) {
    foreach(var_06, var_05 in level.moving_target_groups) {
      if(var_05.size == 0) {
        continue;
      }

      move_group(var_06, var_05, var_02, var_03);
      level notify("moving_target_attack", var_05);
    }
  }
}

move_group(param_00, param_01, param_02, param_03) {
  var_04 = get_group_move_direction(param_00);
  var_05 = get_active_moving_target_in_group(param_01);
  if(isDefined(var_05) && isDefined(var_05.origin)) {
    try_advance_death_grid_lines_and_trigger(var_05.origin + var_04);
  }

  foreach(var_07 in param_01) {
    if(!isDefined(var_07)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_07.flying_to_portal)) {
      continue;
    }

    var_07 moveto(var_07.origin + var_04, param_02);
  }

  wait(param_02 + param_03);
}

get_active_moving_target_in_group(param_00) {
  foreach(var_02 in param_00) {
    if(!isDefined(var_02)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_02.flying_to_portal)) {
      continue;
    }

    return var_02;
  }

  return undefined;
}

reset_moving_target_wave_data() {
  level.moving_target_groups = [];
  level.moving_target_priority = [];
  level.moving_target_priority["high"] = [];
  level.moving_target_priority["medium"] = [];
  level.moving_target_priority["low"] = [];
  level.moving_target_pattern = [];
  level.num_moving_target_escaped = 0;
  update_num_targets_escaped_hud();
  if(isDefined(level.reset_moving_target_wave_data)) {
    [[level.reset_moving_target_wave_data]]();
  }
}

moving_target_intro_sequence(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_04 = spawn_moving_target_group(var_03);
    level.moving_target_groups[level.moving_target_groups.size] = var_04;
  }

  foreach(var_07, var_04 in level.moving_target_groups) {
    level.moving_target_pattern[var_07] = get_moving_target_pattern(param_01, var_04);
  }

  wait(1);
}

get_moving_target_pattern(param_00, param_01) {
  var_02 = level.moving_target_wave_info[param_00];
  var_03 = [
    [var_02.move_pattern_func]
  ](param_01);
  return var_03;
}

spawn_moving_target_group(param_00) {
  var_01 = [];
  var_01[var_01.size] = spawn_moving_target(param_00);
  scripts\engine\utility::waitframe();
  foreach(var_03 in scripts\engine\utility::getstructarray(param_00.target, "targetname")) {
    var_01[var_01.size] = spawn_moving_target(var_03);
    scripts\engine\utility::waitframe();
  }

  return var_01;
}

spawn_moving_target(param_00) {
  var_01 = scripts\engine\utility::getstruct("ghost_wave_start_pos", "targetname");
  var_02 = spawn("script_model", var_01.origin);
  var_02 setModel(get_moving_target_model());
  var_02.angles = var_01.angles;
  var_02.script_parameters = param_00.script_parameters;
  var_02.angles_to_face_when_activated = param_00.angles;
  if(isDefined(level.assign_moving_target_flags_func)) {
    [[level.assign_moving_target_flags_func]](param_00, var_02);
  }

  var_02 moveto(param_00.origin, 1);
  var_03 = param_00.script_noteworthy;
  level.moving_target_priority[var_03][level.moving_target_priority[var_03].size] = var_02;
  return var_02;
}

get_moving_target_model() {
  if(isDefined(level.gns_moving_target_model)) {
    return level.gns_moving_target_model;
  }

  return "zmb_pixel_skull";
}

activate_moving_targets(param_00) {
  if(isDefined(level.activate_moving_targets_func)) {
    [[level.activate_moving_targets_func]](param_00);
    return;
  }

  activate_moving_targets_default(param_00);
}

activate_moving_targets_default(param_00) {
  foreach(var_02 in level.moving_target_groups) {
    foreach(var_04 in var_02) {
      var_04.original_angles_to_face = var_04.angles;
      var_04 rotateto(var_04.angles_to_face_when_activated, 1, 1);
    }
  }

  wait(1);
  if(isDefined(level.post_moving_target_rotate_func)) {
    level thread[[level.post_moving_target_rotate_func]]();
  }

  foreach(var_02 in level.moving_target_groups) {
    foreach(var_04 in var_02) {
      [
        [level.set_moving_target_color_func]
      ](var_04, param_00);
    }
  }
}

all_moving_targets_hide_color() {
  foreach(var_01 in level.moving_target_groups) {
    foreach(var_03 in var_01) {
      if(var_03.color == "red") {
        continue;
      }

      if(scripts\engine\utility::istrue(var_03.flying_to_portal)) {
        continue;
      }

      var_03 thread hide_color(var_03);
    }
  }
}

all_moving_targets_show_color() {
  foreach(var_01 in level.moving_target_groups) {
    foreach(var_03 in var_01) {
      if(var_03.color == "red") {
        continue;
      }

      if(scripts\engine\utility::istrue(var_03.flying_to_portal)) {
        continue;
      }

      var_03 thread show_color(var_03);
    }
  }
}

hide_color(param_00) {
  param_00 endon("death");
  param_00 endon("become_red_moving_target");
  param_00 rotateto(param_00.original_angles_to_face, 1, 1);
  wait(1);
  param_00 setscriptablepartstate("skull_vfx", "off");
}

show_color(param_00) {
  param_00 endon("death");
  param_00 rotateto(param_00.angles_to_face_when_activated, 1, 1);
  wait(1);
  param_00 setscriptablepartstate("skull_vfx", param_00.color);
}

start_ghost_portal_vfx() {
  var_00 = scripts\engine\utility::getstruct("ghost_wave_portal", "targetname");
  var_01 = spawnfx(level._effect["moving_target_portal"], var_00.origin, anglesToForward(var_00.angles), anglestoup(var_00.angles));
  wait(1);
  triggerfx(var_01);
  level.ghost_portal_vfx = var_01;
}

stop_ghost_portal_vfx() {
  if(isDefined(level.ghost_portal_vfx)) {
    level.ghost_portal_vfx delete();
  }
}

activate_red_moving_target(param_00) {
  param_00 notify("become_red_moving_target");
  param_00.angles = param_00.angles_to_face_when_activated;
  set_moving_target_color(param_00, "red");
  var_01 = param_00 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(level.moving_target_pre_fly_time, "death");
  if(var_01 == "timeout") {
    param_00 fly_back_into_portal(param_00);
  }
}

set_moving_target_color(param_00, param_01) {
  param_00.color = param_01;
  param_00 setscriptablepartstate("skull_vfx", param_01);
}

moving_targets_attack_logic() {
  level notify("moving_targets_attack_logic");
  level endon("moving_targets_attack_logic");
  level endon("game_ended");
  level endon("stop_moving_target_sequence");
  var_00 = 0;
  while(active_moving_target_available()) {
    level waittill("moving_target_attack", var_01);
    var_02 = gettime();
    if(!allow_to_attack(var_00, var_02)) {
      continue;
    }

    var_00 = var_02 + get_moving_target_attack_interval();
    var_03 = select_moving_target_player_pair(var_01);
    if(!isDefined(var_03)) {
      continue;
    }

    var_04 = var_03.moving_target;
    var_05 = var_03.player;
    var_06 = vectornormalize(var_05 getEye() - var_04.origin);
    var_07 = var_04.origin + var_06 * 60;
    var_08 = var_05.origin;
    level thread shoot_8bit_lasers(var_07, var_08);
  }
}

get_moving_target_attack_interval() {
  if(isDefined(level.moving_target_attack_interval)) {
    return level.moving_target_attack_interval;
  }

  return 1500;
}

allow_to_attack(param_00, param_01) {
  return param_01 > param_00;
}

shoot_8bit_lasers(param_00, param_01) {
  for(var_02 = 0; var_02 < 3; var_02++) {
    magicbullet("zmb_8bit_laser", param_00, param_01);
    wait(0.25);
  }
}

select_moving_target_player_pair(param_00) {
  if(param_00.size == 0) {
    return undefined;
  }

  var_01 = spawnStruct();
  var_02 = [];
  foreach(var_04 in param_00) {
    if(isDefined(var_04)) {
      var_02[var_02.size] = var_04;
    }
  }

  var_02 = scripts\engine\utility::array_randomize(var_02);
  foreach(var_07 in var_02) {
    var_08 = select_player_to_shoot_at(var_07);
    if(isDefined(var_08)) {
      var_01.moving_target = var_07;
      var_01.player = var_08;
      return var_01;
    }
  }

  return undefined;
}

select_player_to_shoot_at(param_00) {
  var_01 = [];
  foreach(var_03 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_03)) {
      continue;
    }

    if(!bullettracepassed(param_00.origin, var_03 getEye(), 0, param_00)) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return scripts\engine\utility::random(var_01);
}

stop_moving_targets_sequence() {
  stop_ghost_portal_vfx();
  foreach(var_01 in level.moving_target_groups) {
    foreach(var_03 in var_01) {
      if(isDefined(var_03)) {
        var_03 delete();
      }
    }
  }

  level notify("stop_moving_target_sequence");
}

purge_undefined_from_moving_target_array() {
  foreach(var_02, var_01 in level.moving_target_groups) {
    level.moving_target_groups[var_02] = scripts\engine\utility::array_removeundefined(var_01);
  }

  foreach(var_04, var_01 in level.moving_target_priority) {
    level.moving_target_priority[var_04] = scripts\engine\utility::array_removeundefined(var_01);
  }
}

game_won_sequence() {
  level thread delay_end_ghost_when_won();
}

delay_end_ghost_when_won() {
  level endon("game_ended");
  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_acrcade_play_success", "zmb_comment_vo", "highest", 3, 0, 0, 1);
  }

  delay_end_ghost(1);
  level.ghostskulls_complete_status = 1;
  scripts\cp\zombies\zombie_analytics::log_player_exits_ghostskulls_games(level.ghostskulls_total_waves, level.ghostskulls_complete_status, gettime() - level.ghostskullstimestart / 1000);
  if(isDefined(level.gns_reward_func)) {
    level thread[[level.gns_reward_func]]();
  }
}

delay_end_ghost(param_00) {
  level notify("delay_end_ghost");
  level endon("delay_end_ghost");
  func_8E9F();
  end_ghost_wave();
  show_ghost_arcade_scores(param_00);
  stop_death_trigger_monitor();
  if(isDefined(level.pre_gns_end_func)) {
    level thread[[level.pre_gns_end_func]]();
  }

  wait(5);
  foreach(var_02 in level.players) {
    var_02 thread end_ghost_sequence(var_02);
  }

  scripts\engine\utility::waitframe();
  reset_death_grid_lines_and_trigger();
  level.gns_active = 0;
  if(param_00 == 2) {
    level notify("end_this_thread_of_gns_fnf_card");
  }

  if(isDefined(level.gns_end_func)) {
    [[level.gns_end_func]]();
  }
}

func_8E9F() {
  foreach(var_01 in level.players) {
    var_01 thread hide_entangler_hud(var_01);
  }
}

hide_entangler_hud(param_00) {
  param_00 endon("disconnect");
  param_00 notify("stop_using_entabgler");
  scripts\engine\utility::waitframe();
  param_00 setclientomnvar("zm_ui_ghost_arcade_message", 0);
  param_00 setclientomnvar("zom_entangler_progress_percent", 0);
}

store_and_take_perks(param_00) {
  param_00.pre_ghost_perks = [];
  if(!isDefined(param_00.zombies_perks)) {
    return;
  }

  foreach(var_03, var_02 in param_00.zombies_perks) {
    if(scripts\engine\utility::istrue(param_00.zombies_perks[var_03]) && should_be_removed_for_gns(var_03)) {
      param_00.pre_ghost_perks = scripts\engine\utility::array_add(param_00.pre_ghost_perks, var_03);
      param_00 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_03);
      gns_take_perks_handler(param_00, var_03);
    }
  }
}

gns_take_perks_handler(param_00, param_01) {
  switch (param_01) {
    case "perk_machine_revive":
      param_00.self_revives_purchased--;
      break;

    default:
      break;
  }
}

should_be_removed_for_gns(param_00) {
  switch (param_00) {
    case "perk_machine_more":
      return 0;

    default:
      return 1;
  }
}

restore_all_previous_perks(param_00) {
  foreach(var_02 in param_00.pre_ghost_perks) {
    param_00 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_02, 0);
  }
}

display_objective_message(param_00) {
  param_00 thread display_ghost_arcade_message(param_00, 1, 6);
}

remove_ghost_arcade_message(param_00) {
  param_00 setclientomnvar("zm_ui_ghost_arcade_message", 0);
}

display_ghost_arcade_message(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  param_00 notify("display_ghost_arcade_message");
  param_00 endon("display_ghost_arcade_message");
  if(!isDefined(param_01)) {
    return;
  }

  param_00 setclientomnvar("zm_ui_ghost_arcade_message", param_01);
  wait(param_02);
  remove_ghost_arcade_message(param_00);
}

reset_num_moving_target_reached_goal() {
  level.num_moving_target_reached_goal = 0;
}

active_moving_target_available() {
  return get_num_of_active_moving_target() > 0;
}

get_num_of_active_moving_target() {
  var_00 = 0;
  foreach(var_02 in level.moving_target_priority) {
    var_00 = var_00 + var_02.size;
  }

  return var_00;
}

get_group_move_direction(param_00) {
  var_01 = level.moving_target_pattern[param_00];
  var_02 = var_01[0];
  if(var_01.size > 1) {
    var_03 = [];
    for(var_04 = 1; var_04 < var_01.size; var_04++) {
      var_03[var_03.size] = var_01[var_04];
    }

    var_03[var_03.size] = var_02;
    level.moving_target_pattern[param_00] = var_03;
  }

  return translate_direction_to_vector(var_02);
}

get_wave_move_time(param_00) {
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    return level.moving_target_wave_info[param_00].solo_move_time;
  }

  return level.moving_target_wave_info[param_00].move_time;
}

get_wave_wait_time_between_group(param_00) {
  return level.moving_target_wave_info[param_00].wait_between_group_move;
}

translate_direction_to_vector(param_00) {
  switch (param_00) {
    case "R":
      return (120, 0, 0);

    case "L":
      return (-120, 0, 0);

    case "F":
      return (0, 120, 0);

    case "U":
      return (0, 0, 120);

    case "D":
      return (0, 0, -120);

    case "RU":
      return (120, 0, 120);

    case "LU":
      return (-120, 0, 120);

    case "RD":
      return (120, 0, -120);

    case "LD":
      return (-120, 0, -120);

    default:
      break;
  }
}

get_active_moving_target_based_on_priority() {
  if(level.moving_target_priority["high"].size > 0) {
    return scripts\engine\utility::random(level.moving_target_priority["high"]);
  }

  if(level.moving_target_priority["medium"].size > 0) {
    return scripts\engine\utility::random(level.moving_target_priority["medium"]);
  }

  if(level.moving_target_priority["low"].size > 0) {
    return scripts\engine\utility::random(level.moving_target_priority["low"]);
  }

  return undefined;
}

fly_back_into_portal(param_00) {
  param_00 endon("death");
  param_00.flying_to_portal = 1;
  var_01 = scripts\engine\utility::getstruct("ghost_wave_start_pos", "targetname");
  param_00 moveto(var_01.origin, 6);
  param_00 waittill("movedone");
  level.num_moving_target_escaped++;
  display_target_escaped_message();
  determine_game_fail();
  remove_undefined_from_moving_target_array(param_00);
  param_00 delete();
}

display_target_escaped_message() {
  display_skull_escaped_message();
  update_num_targets_escaped_hud();
}

display_skull_escaped_message() {
  foreach(var_01 in level.players) {
    var_01 thread display_ghost_arcade_message(var_01, get_skull_escaped_message_id(), 4);
  }
}

get_skull_escaped_message_id() {
  switch (level.num_moving_target_escaped) {
    case 1:
      return 2;

    case 2:
      return 3;

    case 3:
      return 4;
  }
}

update_num_targets_escaped_hud() {
  foreach(var_01 in level.players) {
    var_01 setclientomnvar("zm_ui_num_targets_escaped", level.num_moving_target_escaped);
  }
}

remove_undefined_from_moving_target_array(param_00) {
  foreach(var_03, var_02 in level.moving_target_groups) {
    level.moving_target_groups[var_03] = scripts\engine\utility::array_remove(var_02, param_00);
  }

  foreach(var_05, var_02 in level.moving_target_priority) {
    level.moving_target_priority[var_05] = scripts\engine\utility::array_remove(var_02, param_00);
  }
}

determine_game_fail() {
  if(level.num_moving_target_escaped >= 3) {
    level thread delay_end_ghost_wave_on_fail();
  }
}

delay_end_ghost_wave_on_fail() {
  level endon("game_ended");
  if(scripts\engine\utility::istrue(level.processing_ghost_wave_failing)) {
    return;
  }

  level.processing_ghost_wave_failing = 1;
  level.ghostskulls_complete_status = 0;
  foreach(var_01 in level.players) {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_acrcade_play_fail", "zmb_comment_vo", "highest", 3, 0, 0, 1);
  }

  scripts\cp\zombies\zombie_analytics::log_player_exits_ghostskulls_games(level.ghostskulls_total_waves, level.ghostskulls_complete_status, gettime() - level.ghostskullstimestart / 1000);
  if(isDefined(level.ghost_n_skull_reactivate_func)) {
    level thread[[level.ghost_n_skull_reactivate_func]]();
  }

  delay_end_ghost(2);
}

teleport_into_arcade_console(param_00) {
  var_01 = scripts\engine\utility::getstructarray("ghost_wave_player_start", "targetname");
  var_02 = var_01[param_00 getentitynumber()];
  param_00 setorigin(var_02.origin);
  param_00 setplayerangles(var_02.angles);
}

teleport_out_of_arcade_console(param_00) {
  var_01 = scripts\engine\utility::getstructarray("ghost_wave_player_end", "targetname");
  var_02 = var_01[param_00 getentitynumber()];
  param_00 setorigin(scripts\engine\utility::drop_to_ground(var_02.origin, 50, -300));
  param_00 setplayerangles(var_02.angles);
}

turn_on_ghost_arcade_hud(param_00) {
  param_00 setclientomnvar("zm_ui_player_playing_ghost_arcade", 1);
}

turn_off_ghost_arcade_hud(param_00) {
  param_00 setclientomnvar("zm_ui_player_playing_ghost_arcade", 0);
}

show_ghost_arcade_scores(param_00) {
  foreach(var_02 in level.players) {
    if(scripts\engine\utility::istrue(var_02.playing_ghosts_n_skulls)) {
      turn_on_ghost_arcade_scores(var_02, param_00);
    }
  }
}

turn_on_ghost_arcade_scores(param_00, param_01) {
  param_00 setclientomnvar("zm_ui_show_ghost_arcade_scores", param_01);
}

turn_off_ghost_arcade_scores(param_00) {
  param_00 setclientomnvar("zm_ui_show_ghost_arcade_scores", 0);
}

register_available_formation(param_00, param_01) {
  level.available_formations[param_00] = scripts\engine\utility::array_add(level.available_formations[param_00], param_01);
}

register_formation_movements(param_00, param_01) {
  level.formation_movements[param_00] = param_01;
}

get_formationfunc_for_wave(param_00) {
  return level.moving_target_wave_info[param_00].formation_id;
}

disable_pistol_during_laststand() {
  level.can_use_pistol_during_laststand_func = ::ghost_wave_can_use_pistol_in_laststand;
}

enable_pistol_during_laststand() {
  level.can_use_pistol_during_laststand_func = undefined;
}

ghost_wave_can_use_pistol_in_laststand(param_00) {
  return 0;
}

store_and_reset_currency(param_00) {
  param_00.pre_ghost_currency = param_00 scripts\cp\cp_persistence::get_player_currency();
  param_00 setplayerdata("cp", "alienSession", "currency", 0);
  param_00 scripts\cp\cp_persistence::eog_player_update_stat("currency", 0, 1);
}

restore_currency(param_00) {
  param_00 setplayerdata("cp", "alienSession", "currency", int(param_00.pre_ghost_currency));
  param_00 scripts\cp\cp_persistence::eog_player_update_stat("currency", int(param_00.pre_ghost_currency), 1);
}

increment_alien_head_destroyed_count(param_00) {
  var_01 = param_00 getplayerdata("cp", "alienSession", "currency");
  param_00 setplayerdata("cp", "alienSession", "currency", int(var_01 + 1));
  param_00 scripts\cp\cp_persistence::eog_player_update_stat("currency", int(var_01 + 1), 1);
}

try_advance_death_grid_lines_and_trigger(param_00) {
  if(param_00[1] < level.current_death_grid_lines_front_y_pos) {
    return;
  }

  advance_death_grid_lines_and_trigger();
}

reset_death_grid_lines_and_trigger() {
  level.current_death_grid_lines_front_y_pos = level.original_death_grid_lines_front_y_pos;
  set_death_grid_lines_and_trigger_y_pos(level.death_trigger_reset_y_pos);
}

activate_death_grid_lines_and_trigger() {
  level.current_death_grid_lines_front_y_pos = level.original_death_grid_lines_front_y_pos;
  set_death_grid_lines_and_trigger_y_pos(level.death_trigger_activate_y_pos);
}

advance_death_grid_lines_and_trigger() {
  var_00 = getent("ghost_death_trigger", "targetname");
  var_01 = var_00.origin[1];
  var_02 = var_01 + 217;
  var_03 = level.death_trigger_activate_y_pos + 217 * get_max_num_of_death_trigger_advance();
  if(var_02 >= var_03) {
    level thread delay_end_ghost_wave_on_fail();
  }

  level.current_death_grid_lines_front_y_pos = level.current_death_grid_lines_front_y_pos + 217;
  set_death_grid_lines_and_trigger_y_pos(var_02);
}

get_max_num_of_death_trigger_advance() {
  if(isDefined(level.max_num_of_death_trigger_advance)) {
    return level.max_num_of_death_trigger_advance;
  }

  return 13;
}

set_death_grid_lines_and_trigger_y_pos(param_00) {
  var_01 = getent("ghost_death_trigger", "targetname");
  var_02 = getent("ghost_death_grid_lines", "targetname");
  var_01 dontinterpolate();
  var_02 dontinterpolate();
  var_01.origin = (var_01.origin[0], param_00, var_01.origin[2]);
  var_02.origin = (var_02.origin[0], param_00, var_02.origin[2]);
}

formation_1_move_pattern(param_00) {
  return ["R", "R", "R", "F", "L", "L", "L", "F"];
}

formation_2_move_pattern(param_00) {
  return ["U", "D", "D", "U", "F"];
}

formation_3_move_pattern(param_00) {
  return ["R", "R", "R", "F", "L", "L", "L", "F"];
}

formation_4_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "LU":
          return ["LU", "F", "RD", "F"];

        case "RU":
          return ["RU", "F", "LD", "F"];

        case "LD":
          return ["LD", "F", "RU", "F"];

        case "RD":
          return ["RD", "F", "LU", "F"];

        default:
          break;
      }
    }
  }
}

formation_5_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "LU":
          return ["LU", "F", "RD", "F"];

        case "RU":
          return ["RU", "F", "LD", "F"];

        case "LD":
          return ["LD", "F", "RU", "F"];

        case "RD":
          return ["RD", "F", "LU", "F"];

        default:
          break;
      }
    }
  }
}

formation_6_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "LU":
          return ["LU", "F", "RD", "F"];

        case "RU":
          return ["RU", "F", "LD", "F"];

        case "LD":
          return ["LD", "F", "RU", "F"];

        case "RD":
          return ["RD", "F", "LU", "F"];

        default:
          break;
      }
    }
  }
}

formation_7_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "L":
          return ["L", "R", "F"];

        case "R":
          return ["R", "L", "F"];

        case "U":
          return ["U", "D", "F"];

        default:
          break;
      }
    }
  }
}

formation_8_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "LD":
          return ["LD", "RU", "F"];

        case "RD":
          return ["RD", "LU", "F"];

        case "U":
          return ["U", "D", "F"];

        default:
          break;
      }
    }
  }
}

formation_9_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "L":
          return ["L", "R", "F"];

        case "R":
          return ["R", "L", "F"];

        case "D":
          return ["D", "U", "F"];

        default:
          break;
      }
    }
  }
}

formation_10_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "U":
          return ["U", "F", "D", "F"];

        case "D":
          return ["D", "F", "U", "F"];

        default:
          break;
      }
    }
  }
}

formation_11_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "U":
          return ["U", "F", "D", "F"];

        case "D":
          return ["D", "F", "U", "F"];

        default:
          break;
      }
    }
  }
}

formation_12_move_pattern(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_parameters)) {
      switch (var_02.script_parameters) {
        case "L":
          return ["L", "F", "R", "F"];

        case "R":
          return ["R", "F", "L", "F"];

        default:
          break;
      }
    }
  }
}

formation_13_move_pattern(param_00) {
  return ["R", "R", "F", "L", "L", "F"];
}

formation_14_move_pattern(param_00) {
  return ["R", "R", "F", "L", "L", "F"];
}

formation_15_move_pattern(param_00) {
  return ["R", "R", "F", "D", "F", "U", "F", "L", "L", "F"];
}

give_gns_base_reward(param_00) {
  param_00 scripts\cp\cp_persistence::give_player_xp(1000, 1);
  param_00.have_permanent_perks = 1;
  param_00.have_gns_perk = 1;
  param_00 thread earn_all_perks(param_00);
}

earn_all_perks(param_00) {
  param_00 endon("disconnect");
  var_01 = ["perk_machine_boom", "perk_machine_flash", "perk_machine_fwoosh", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_revive", "perk_machine_run", "perk_machine_smack", "perk_machine_tough", "perk_machine_zap"];
  if(isDefined(level.all_perk_list)) {
    var_01 = level.all_perk_list;
  }

  foreach(var_03 in var_01) {
    if(param_00 scripts\cp\utility::has_zombie_perk(var_03)) {
      continue;
    }

    wait(0.5);
    param_00 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_03, 0);
  }
}

notify_activation_progress(param_00, param_01) {
  level thread update_num_of_coin_inserted(param_00);
  if(soundexists("ghosts_quest_step_notify")) {
    foreach(var_03 in level.players) {
      var_03 playlocalsound("ghosts_quest_step_notify");
    }
  }
}

update_num_of_coin_inserted(param_00, param_01) {
  level endon("game_ended");
  if(param_00 == 6) {
    foreach(var_03 in level.players) {
      if(var_03 scripts\cp\utility::is_consumable_active("activate_gns_machine")) {
        var_03 notify("activate_gns_machine_timeup");
        var_03 notify("activate_gns_machine_exited_early");
      }
    }
  }

  if(isDefined(param_01)) {
    wait(param_01);
  }

  setomnvar("zm_num_ghost_n_skull_coin", param_00);
  level.skulls_before_activation = param_00;
}

reactivate_cabinet() {
  setomnvar("zm_num_ghost_n_skull_coin", 5);
}

set_consumable_meter_scalar(param_00, param_01) {
  param_00.consumable_meter_scalar = param_01;
}