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
  for(var_0 = 1; var_0 <= level.gns_num_of_wave; var_0++) {
    level.available_formations[var_0] = [];
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

register_moving_target_wave(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.move_time = var_1;
  var_4.solo_move_time = var_2;
  var_4.wait_between_group_move = var_3;
  var_4.formation_id = scripts\engine\utility::random(level.available_formations[var_0]);
  var_4.move_pattern_func = level.formation_movements[var_4.formation_id];
  level.moving_target_wave_info[var_0] = var_4;
}

use_entangler(var_0) {
  var_0 giveweapon("iw7_entangler_zm");
  var_0 switchtoweaponimmediate("iw7_entangler_zm");
  var_0 scripts\engine\utility::allow_weapon_switch(0);
  var_0 thread entangler_hit_monitor(var_0);
  var_0 thread entangler_recharge_monitor(var_0);
  var_0.powers_before_entangler = var_0 scripts\cp\powers\coop_powers::get_info_for_player_powers(var_0);
  var_0 scripts\cp\powers\coop_powers::clearpowers();
}

stop_using_entangler(var_0) {
  var_0 scripts\engine\utility::allow_weapon_switch(1);
  var_0 takeweapon("iw7_entangler_zm");
  if(!var_0 hasweapon(var_0.weapon_before_entangler)) {
    var_0 scripts\cp\utility::_giveweapon(var_0.weapon_before_entangler, undefined, undefined, 1);
  }

  var_0 switchtoweapon(var_0.weapon_before_entangler);
  var_0 scripts\cp\powers\coop_powers::restore_powers(var_0, var_0.powers_before_entangler);
  var_0 clear_up_previous_scu(var_0);
}

entangler_hit_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("stop_using_entabgler");
  for(;;) {
    record_entangler_progress_percent(var_0, 0);
    var_1 = 0;
    for(;;) {
      var_2 = var_0 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(0.2, "entangler_hit_same_target");
      if(var_2 == "entangler_hit_same_target") {
        var_1 = var_1 + 0.2;
        var_3 = min(var_1 / get_entangler_track_time(), 1);
        record_entangler_progress_percent(var_0, var_3);
        if(var_3 == 1 && isalive(var_0.current_entangler_target) && !scripts\aitypes\zombie_ghost\behaviors::isentangled(var_0.current_entangler_target) && !isDefined(var_0.ghost_in_entanglement)) {
          var_0.current_entangler_target scripts\aitypes\zombie_ghost\behaviors::entangleghost(var_0.current_entangler_target, var_0);
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

entangler_recharge_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("stop_using_entabgler");
  for(;;) {
    wait(0.5);
    var_0 setweaponammoclip("iw7_entangler_zm", weaponclipsize("iw7_entangler_zm"));
  }
}

record_entangler_progress_percent(var_0, var_1) {
  var_0 setclientomnvar("zom_entangler_progress_percent", var_1);
}

update_entangler_progress(var_0, var_1) {
  if(!isDefined(var_0.current_entangler_target) && var_0.current_entangler_target == var_1) {
    var_0 thread current_entangler_target_monitor(var_0, var_1);
    return;
  }

  var_0 notify("entangler_hit_same_target");
}

current_entangler_target_monitor(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 notify("entangler_target_monitor");
  var_1 endon("entangler_target_monitor");
  var_0.current_entangler_target = var_1;
  scripts\engine\utility::waitframe();
  var_0.current_entangler_target = undefined;
}

setup_ghost_wave_specific_power() {
  level.scu_use_func = ::use_scu;
}

use_scu(var_0) {
  var_1 = self;
  var_0 endon("death");
  var_1 endon("death");
  var_1 endon("disconnect");
  if(!scripts\cp\utility::isreallyalive(var_1)) {
    var_0 delete();
    return;
  }

  var_1 thread scripts\cp\powers\coop_powers::givepower("power_scu", "secondary", undefined, undefined, undefined, 0, 0);
  clear_up_previous_scu(var_1);
  var_1.deployed_scu = var_0;
  var_0 waittill("missile_stuck", var_2);
  var_0 thread scu_vfx_manager(var_0, var_1);
  for(;;) {
    scripts\engine\utility::waitframe();
    if(isDefined(var_1.current_entangler_target) && scripts\aitypes\zombie_ghost\behaviors::isentangled(var_1.current_entangler_target)) {
      var_3 = var_1.current_entangler_target;
      if(ghost_can_be_contained(var_3, var_0)) {
        level thread ghost_trail_to_scu(var_3.origin + (0, 0, 40), var_1.deployed_scu.origin, var_1);
        var_3.nocorpse = 1;
        var_3 suicide();
      }
    }
  }
}

ghost_trail_to_scu(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("tag_origin");
  wait(0.1);
  playFXOnTag(level._effect["zombie_ghost_trail"], var_3, "tag_origin");
  var_4 = var_1;
  for(;;) {
    var_3 moveto(var_4, 0.5, 0.125);
    var_3 waittill("movedone");
    if(!isDefined(var_2) && isDefined(var_2.deployed_scu)) {
      break;
    }

    var_4 = var_2.deployed_scu.origin;
    if(distancesquared(var_3.origin, var_4) < 400) {
      break;
    }
  }

  var_3 delete();
}

clear_up_previous_scu(var_0) {
  if(isDefined(var_0.deployed_scu)) {
    if(isDefined(var_0.deployed_scu.light_fx)) {
      var_0.deployed_scu.light_fx delete();
    }

    var_0.deployed_scu delete();
  }
}

scu_vfx_manager(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("disconnect");
  var_0.light_fx = spawnfx(level._effect["zombie_ghost_scu"], var_0.origin);
  scripts\engine\utility::waitframe();
  if(isDefined(var_0)) {
    triggerfx(var_0.light_fx);
  }
}

ghost_can_be_contained(var_0, var_1) {
  if(distancesquared(var_0.origin, var_1.origin) < 6400) {
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

spawn_zombie_ghost(var_0, var_1, var_2) {
  if(!isDefined(level.zombie_ghosts)) {
    level.zombie_ghosts = [];
  }

  if(!isDefined(var_2)) {
    var_2 = "axis";
  }

  var_3 = scripts\mp\mp_agent::spawnnewagent("zombie_ghost", var_2, var_0, var_1);
  level.zombie_ghosts[level.zombie_ghosts.size] = var_3;
  return var_3;
}

stop_ghosts_attack_logic() {
  level notify("stop_ghosts_attack_logic");
}

ghosts_attack_logic() {
  level endon("game_ended");
  level endon("stop_ghosts_attack_logic");
  wait(15);
  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 can_be_attacked_by_ghost(var_1)) {
        var_2 = sortbydistance(level.zombie_ghosts, var_1.origin);
        foreach(var_4 in var_2) {
          if(var_4 can_attack()) {
            var_4 attack(var_1);
            break;
          }
        }
      }
    }

    wait(0.5);
  }
}

can_be_attacked_by_ghost(var_0) {
  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    return 0;
  }

  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return 0;
  }

  if(scripts\mp\agents\zombie\zombie_util::isplayerteleporting(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(get_num_of_ghosts_attacking_me(var_0) > get_max_num_ghosts_per_player()) {
    return 0;
  }

  if(time_since_last_ghost_attack(var_0) < get_min_player_attack_by_frequency()) {
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

  var_0 = self;
  if(scripts\aitypes\zombie_ghost\behaviors::isentangled(var_0)) {
    return 0;
  }

  if(var_0 scripts\aitypes\zombie_ghost\behaviors::getghostnavmode() == "attack") {
    return 0;
  }

  if(time_since_last_attack(var_0) < 7) {
    return 0;
  }

  return 1;
}

is_ghost_attack_disabled() {
  return 1;
}

get_num_of_ghosts_attacking_me(var_0) {
  if(!isDefined(var_0.num_of_ghosts_attacking_me)) {
    var_0.num_of_ghosts_attacking_me = 0;
  }

  return var_0.num_of_ghosts_attacking_me;
}

time_since_last_ghost_attack(var_0) {
  if(!isDefined(var_0.last_ghost_attack_time)) {
    var_0.last_ghost_attack_time = 0;
  }

  return gettime() - var_0.last_ghost_attack_time / 1000;
}

time_since_last_attack(var_0) {
  if(!isDefined(var_0.last_attack_time)) {
    var_0.last_attack_time = 0;
  }

  return gettime() - var_0.last_attack_time / 1000;
}

attack(var_0) {
  var_1 = self;
  set_ghost_attack_records(var_1, var_0);
  var_1 thread scripts\aitypes\zombie_ghost\behaviors::ghostattack(var_0);
}

set_ghost_attack_records(var_0, var_1) {
  var_2 = gettime();
  var_1.num_of_ghosts_attacking_me++;
  var_1.last_ghost_attack_time = var_2;
  var_0.last_attack_time = var_2;
}

spawn_ghost_group(var_0) {
  level thread spawn_ghost_group_internal(var_0);
}

spawn_ghost_group_internal(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = scripts\engine\utility::random(level.zombie_ghost_spawn_nodes);
    var_3 = spawn_zombie_ghost(var_2.origin, (0, 0, 0), "axis");
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

  foreach(var_1 in level.players) {
    enter_ghosts_n_skulls(var_1);
  }
}

play_start_ghost_vo_to_players() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("ghost_start", "zmb_comment_vo", "low", 3, 0, 0, 1);
  }
}

enter_ghosts_n_skulls(var_0) {
  if(isDefined(level.enter_ghosts_n_skulls_func)) {
    [[level.enter_ghosts_n_skulls_func]](var_0);
  }

  var_0.dontremoveperks = 1;
  var_0 scripts\cp\cp_laststand::enable_self_revive(var_0);
  var_0.weapon_before_entangler = var_0 scripts\cp\utility::getweapontoswitchbackto();
  var_0 scripts\cp\zombies\arcade_game_utility::take_player_super_pre_game();
  var_0.disable_self_revive_fnf = 1;
  var_0.allow_carry = 0;
  var_0.ghost_in_entanglement = undefined;
  var_0.disable_consumables = 1;
  var_0.playing_ghosts_n_skulls = 1;
  var_0 store_and_take_perks(var_0);
  var_0 turn_on_ghost_arcade_hud(var_0);
  var_0 teleport_into_arcade_console(var_0);
  var_0 display_objective_message(var_0);
  var_0 use_entangler(var_0);
  var_0 store_and_reset_currency(var_0);
  var_0 allowmelee(0);
  if(isDefined(level.gns_laststand_monitor)) {
    var_0 thread[[level.gns_laststand_monitor]](var_0);
  }
}

player_connect_monitor() {
  level endon("game_ended");
  level endon("delay_end_ghost");
  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 thread delay_enter_ghosts_n_skulls(var_0);
  }
}

delay_enter_ghosts_n_skulls(var_0) {
  level endon("game_ended");
  level endon("delay_end_ghost");
  var_0 endon("disconnect");
  if(isDefined(level.gns_hotjoin_wait_notify)) {
    var_0 waittill(level.gns_hotjoin_wait_notify);
  }

  wait(5);
  enter_ghosts_n_skulls(var_0);
}

start_death_trigger_monitor() {
  if(scripts\engine\utility::istrue(level.disable_gns_death_trigger)) {
    return;
  }

  var_0 = getent("ghost_death_trigger", "targetname");
  var_0 thread ghost_death_trigger_monitor(var_0);
}

ghost_death_trigger_monitor(var_0) {
  level endon("game_ended");
  var_0 endon("stop_death_trigger_monitor");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isplayer(var_1)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
      continue;
    }

    var_1 setvelocity((0, 1400, 700));
    var_1 viewkick(10, var_1.origin);
    var_1 shellshock("default", 3);
    var_1 dodamage(var_1.health, var_1.origin);
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
  var_0 = getent("ghost_death_trigger", "targetname");
  var_0 notify("stop_death_trigger_monitor");
}

end_ghost_sequence(var_0) {
  if(!scripts\engine\utility::istrue(var_0.playing_ghosts_n_skulls)) {
    return;
  }

  var_0 endon("disconnect");
  var_0 restore_all_previous_perks(var_0);
  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    var_0 scripts\cp\cp_laststand::instant_revive(var_0);
    scripts\engine\utility::waitframe();
  }

  var_0 scripts\cp\cp_laststand::disable_self_revive(var_0);
  var_0 turn_off_ghost_arcade_hud(var_0);
  var_0 turn_off_ghost_arcade_scores(var_0);
  var_0 remove_ghost_arcade_message(var_0);
  var_0 stop_using_entangler(var_0);
  var_0 teleport_out_of_arcade_console(var_0);
  var_0 restore_currency(var_0);
  var_0 scripts\cp\utility::restore_super_weapon();
  var_0.dontremoveperks = undefined;
  var_0.disable_self_revive_fnf = undefined;
  var_0.allow_carry = 1;
  var_0.disable_consumables = undefined;
  var_0.playing_ghosts_n_skulls = undefined;
  var_0 allowmelee(1);
  if(isDefined(level.end_ghosts_n_skulls_func)) {
    [[level.end_ghosts_n_skulls_func]](var_0);
  }

  var_0 thread scripts\cp\cp_vo::try_to_play_vo("ghost_end", "zmb_comment_vo", "highest");
}

start_ghosts_spawning() {
  level endon("game_ended");
  level.zombies_paused = 1;
  foreach(var_1 in level.spawned_enemies) {
    if(isDefined(var_1)) {
      var_1.died_poorly = 1;
      var_1.nocorpse = 1;
      var_1 suicide();
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
  foreach(var_1 in level.zombie_ghosts) {
    var_1.died_poorly = 1;
    var_1.nocorpse = 1;
    var_1 suicide();
  }
}

init_ghost_killed_func(var_0, var_1) {
  level.ghost_killed_update_func = ::update_on_ghost_killed;
}

update_on_ghost_killed(var_0, var_1) {
  level.zombie_ghosts = scripts\engine\utility::array_remove(level.zombie_ghosts, self);
  level.characters = scripts\engine\utility::array_remove(level.characters, self);
}

moving_targets_sequence() {
  level endon("game_ended");
  level endon("stop_moving_target_sequence");
  start_ghost_portal_vfx();
  for(var_0 = 1; var_0 <= level.gns_num_of_wave; var_0++) {
    var_1 = scripts\engine\utility::getstructarray("ghost_formation_" + get_formationfunc_for_wave(var_0), "targetname");
    if(var_1.size > 0) {
      level.ghostskulls_total_waves++;
      run_moving_target_wave(var_0, var_1);
      if(isDefined(level.complete_one_gns_wave_func)) {
        level thread[[level.complete_one_gns_wave_func]]();
      }

      continue;
    }

    break;
  }

  game_won_sequence();
}

run_moving_target_wave(var_0, var_1) {
  reset_moving_target_wave_data();
  reset_num_moving_target_reached_goal();
  reset_death_grid_lines_and_trigger();
  wait(2);
  moving_target_intro_sequence(var_1, var_0);
  activate_moving_targets(var_0);
  activate_death_grid_lines_and_trigger();
  level thread moving_targets_attack_logic();
  if(isDefined(level.moving_target_activation_func)) {
    level thread[[level.moving_target_activation_func]](var_0);
  }

  var_2 = get_wave_move_time(var_0);
  var_3 = get_wave_wait_time_between_group(var_0);
  while(active_moving_target_available()) {
    foreach(var_6, var_5 in level.moving_target_groups) {
      if(var_5.size == 0) {
        continue;
      }

      move_group(var_6, var_5, var_2, var_3);
      level notify("moving_target_attack", var_5);
    }
  }
}

move_group(var_0, var_1, var_2, var_3) {
  var_4 = get_group_move_direction(var_0);
  var_5 = get_active_moving_target_in_group(var_1);
  if(isDefined(var_5) && isDefined(var_5.origin)) {
    try_advance_death_grid_lines_and_trigger(var_5.origin + var_4);
  }

  foreach(var_7 in var_1) {
    if(!isDefined(var_7)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_7.flying_to_portal)) {
      continue;
    }

    var_7 moveto(var_7.origin + var_4, var_2);
  }

  wait(var_2 + var_3);
}

get_active_moving_target_in_group(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.flying_to_portal)) {
      continue;
    }

    return var_2;
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

moving_target_intro_sequence(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_4 = spawn_moving_target_group(var_3);
    level.moving_target_groups[level.moving_target_groups.size] = var_4;
  }

  foreach(var_7, var_4 in level.moving_target_groups) {
    level.moving_target_pattern[var_7] = get_moving_target_pattern(var_1, var_4);
  }

  wait(1);
}

get_moving_target_pattern(var_0, var_1) {
  var_2 = level.moving_target_wave_info[var_0];
  var_3 = [[var_2.move_pattern_func]](var_1);
  return var_3;
}

spawn_moving_target_group(var_0) {
  var_1 = [];
  var_1[var_1.size] = spawn_moving_target(var_0);
  scripts\engine\utility::waitframe();
  foreach(var_3 in scripts\engine\utility::getstructarray(var_0.target, "targetname")) {
    var_1[var_1.size] = spawn_moving_target(var_3);
    scripts\engine\utility::waitframe();
  }

  return var_1;
}

spawn_moving_target(var_0) {
  var_1 = scripts\engine\utility::getstruct("ghost_wave_start_pos", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel(get_moving_target_model());
  var_2.angles = var_1.angles;
  var_2.script_parameters = var_0.script_parameters;
  var_2.angles_to_face_when_activated = var_0.angles;
  if(isDefined(level.assign_moving_target_flags_func)) {
    [[level.assign_moving_target_flags_func]](var_0, var_2);
  }

  var_2 moveto(var_0.origin, 1);
  var_3 = var_0.script_noteworthy;
  level.moving_target_priority[var_3][level.moving_target_priority[var_3].size] = var_2;
  return var_2;
}

get_moving_target_model() {
  if(isDefined(level.gns_moving_target_model)) {
    return level.gns_moving_target_model;
  }

  return "zmb_pixel_skull";
}

activate_moving_targets(var_0) {
  if(isDefined(level.activate_moving_targets_func)) {
    [[level.activate_moving_targets_func]](var_0);
    return;
  }

  activate_moving_targets_default(var_0);
}

activate_moving_targets_default(var_0) {
  foreach(var_2 in level.moving_target_groups) {
    foreach(var_4 in var_2) {
      var_4.original_angles_to_face = var_4.angles;
      var_4 rotateto(var_4.angles_to_face_when_activated, 1, 1);
    }
  }

  wait(1);
  if(isDefined(level.post_moving_target_rotate_func)) {
    level thread[[level.post_moving_target_rotate_func]]();
  }

  foreach(var_2 in level.moving_target_groups) {
    foreach(var_4 in var_2) {
      [
        [level.set_moving_target_color_func]
      ](var_4, var_0);
    }
  }
}

all_moving_targets_hide_color() {
  foreach(var_1 in level.moving_target_groups) {
    foreach(var_3 in var_1) {
      if(var_3.color == "red") {
        continue;
      }

      if(scripts\engine\utility::istrue(var_3.flying_to_portal)) {
        continue;
      }

      var_3 thread hide_color(var_3);
    }
  }
}

all_moving_targets_show_color() {
  foreach(var_1 in level.moving_target_groups) {
    foreach(var_3 in var_1) {
      if(var_3.color == "red") {
        continue;
      }

      if(scripts\engine\utility::istrue(var_3.flying_to_portal)) {
        continue;
      }

      var_3 thread show_color(var_3);
    }
  }
}

hide_color(var_0) {
  var_0 endon("death");
  var_0 endon("become_red_moving_target");
  var_0 rotateto(var_0.original_angles_to_face, 1, 1);
  wait(1);
  var_0 setscriptablepartstate("skull_vfx", "off");
}

show_color(var_0) {
  var_0 endon("death");
  var_0 rotateto(var_0.angles_to_face_when_activated, 1, 1);
  wait(1);
  var_0 setscriptablepartstate("skull_vfx", var_0.color);
}

start_ghost_portal_vfx() {
  var_0 = scripts\engine\utility::getstruct("ghost_wave_portal", "targetname");
  var_1 = spawnfx(level._effect["moving_target_portal"], var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  wait(1);
  triggerfx(var_1);
  level.ghost_portal_vfx = var_1;
}

stop_ghost_portal_vfx() {
  if(isDefined(level.ghost_portal_vfx)) {
    level.ghost_portal_vfx delete();
  }
}

activate_red_moving_target(var_0) {
  var_0 notify("become_red_moving_target");
  var_0.angles = var_0.angles_to_face_when_activated;
  set_moving_target_color(var_0, "red");
  var_1 = var_0 scripts\engine\utility::waittill_any_timeout_no_endon_death_2(level.moving_target_pre_fly_time, "death");
  if(var_1 == "timeout") {
    var_0 fly_back_into_portal(var_0);
  }
}

set_moving_target_color(var_0, var_1) {
  var_0.color = var_1;
  var_0 setscriptablepartstate("skull_vfx", var_1);
}

moving_targets_attack_logic() {
  level notify("moving_targets_attack_logic");
  level endon("moving_targets_attack_logic");
  level endon("game_ended");
  level endon("stop_moving_target_sequence");
  var_0 = 0;
  while(active_moving_target_available()) {
    level waittill("moving_target_attack", var_1);
    var_2 = gettime();
    if(!allow_to_attack(var_0, var_2)) {
      continue;
    }

    var_0 = var_2 + get_moving_target_attack_interval();
    var_3 = select_moving_target_player_pair(var_1);
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_3.moving_target;
    var_5 = var_3.player;
    var_6 = vectornormalize(var_5 getEye() - var_4.origin);
    var_7 = var_4.origin + var_6 * 60;
    var_8 = var_5.origin;
    level thread shoot_8bit_lasers(var_7, var_8);
  }
}

get_moving_target_attack_interval() {
  if(isDefined(level.moving_target_attack_interval)) {
    return level.moving_target_attack_interval;
  }

  return 1500;
}

allow_to_attack(var_0, var_1) {
  return var_1 > var_0;
}

shoot_8bit_lasers(var_0, var_1) {
  for(var_2 = 0; var_2 < 3; var_2++) {
    magicbullet("zmb_8bit_laser", var_0, var_1);
    wait(0.25);
  }
}

select_moving_target_player_pair(var_0) {
  if(var_0.size == 0) {
    return undefined;
  }

  var_1 = spawnStruct();
  var_2 = [];
  foreach(var_4 in var_0) {
    if(isDefined(var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  var_2 = scripts\engine\utility::array_randomize(var_2);
  foreach(var_7 in var_2) {
    var_8 = select_player_to_shoot_at(var_7);
    if(isDefined(var_8)) {
      var_1.moving_target = var_7;
      var_1.player = var_8;
      return var_1;
    }
  }

  return undefined;
}

select_player_to_shoot_at(var_0) {
  var_1 = [];
  foreach(var_3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    if(!bullettracepassed(var_0.origin, var_3 getEye(), 0, var_0)) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return scripts\engine\utility::random(var_1);
}

stop_moving_targets_sequence() {
  stop_ghost_portal_vfx();
  foreach(var_1 in level.moving_target_groups) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        var_3 delete();
      }
    }
  }

  level notify("stop_moving_target_sequence");
}

purge_undefined_from_moving_target_array() {
  foreach(var_2, var_1 in level.moving_target_groups) {
    level.moving_target_groups[var_2] = ::scripts\engine\utility::array_removeundefined(var_1);
  }

  foreach(var_4, var_1 in level.moving_target_priority) {
    level.moving_target_priority[var_4] = ::scripts\engine\utility::array_removeundefined(var_1);
  }
}

game_won_sequence() {
  level thread delay_end_ghost_when_won();
}

delay_end_ghost_when_won() {
  level endon("game_ended");
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_acrcade_play_success", "zmb_comment_vo", "highest", 3, 0, 0, 1);
  }

  delay_end_ghost(1);
  level.ghostskulls_complete_status = 1;
  scripts\cp\zombies\zombie_analytics::log_player_exits_ghostskulls_games(level.ghostskulls_total_waves, level.ghostskulls_complete_status, gettime() - level.ghostskullstimestart / 1000);
  if(isDefined(level.gns_reward_func)) {
    level thread[[level.gns_reward_func]]();
  }
}

delay_end_ghost(var_0) {
  level notify("delay_end_ghost");
  level endon("delay_end_ghost");
  func_8E9F();
  end_ghost_wave();
  show_ghost_arcade_scores(var_0);
  stop_death_trigger_monitor();
  if(isDefined(level.pre_gns_end_func)) {
    level thread[[level.pre_gns_end_func]]();
  }

  wait(5);
  foreach(var_2 in level.players) {
    var_2 thread end_ghost_sequence(var_2);
  }

  scripts\engine\utility::waitframe();
  reset_death_grid_lines_and_trigger();
  level.gns_active = 0;
  if(var_0 == 2) {
    level notify("end_this_thread_of_gns_fnf_card");
  }

  if(isDefined(level.gns_end_func)) {
    [[level.gns_end_func]]();
  }
}

func_8E9F() {
  foreach(var_1 in level.players) {
    var_1 thread hide_entangler_hud(var_1);
  }
}

hide_entangler_hud(var_0) {
  var_0 endon("disconnect");
  var_0 notify("stop_using_entabgler");
  scripts\engine\utility::waitframe();
  var_0 setclientomnvar("zm_ui_ghost_arcade_message", 0);
  var_0 setclientomnvar("zom_entangler_progress_percent", 0);
}

store_and_take_perks(var_0) {
  var_0.pre_ghost_perks = [];
  if(!isDefined(var_0.zombies_perks)) {
    return;
  }

  foreach(var_3, var_2 in var_0.zombies_perks) {
    if(scripts\engine\utility::istrue(var_0.zombies_perks[var_3]) && should_be_removed_for_gns(var_3)) {
      var_0.pre_ghost_perks = scripts\engine\utility::array_add(var_0.pre_ghost_perks, var_3);
      var_0 scripts\cp\zombies\zombies_perk_machines::take_zombies_perk(var_3);
      gns_take_perks_handler(var_0, var_3);
    }
  }
}

gns_take_perks_handler(var_0, var_1) {
  switch (var_1) {
    case "perk_machine_revive":
      var_0.self_revives_purchased--;
      break;

    default:
      break;
  }
}

should_be_removed_for_gns(var_0) {
  switch (var_0) {
    case "perk_machine_more":
      return 0;

    default:
      return 1;
  }
}

restore_all_previous_perks(var_0) {
  foreach(var_2 in var_0.pre_ghost_perks) {
    var_0 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_2, 0);
  }
}

display_objective_message(var_0) {
  var_0 thread display_ghost_arcade_message(var_0, 1, 6);
}

remove_ghost_arcade_message(var_0) {
  var_0 setclientomnvar("zm_ui_ghost_arcade_message", 0);
}

display_ghost_arcade_message(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_0 notify("display_ghost_arcade_message");
  var_0 endon("display_ghost_arcade_message");
  if(!isDefined(var_1)) {
    return;
  }

  var_0 setclientomnvar("zm_ui_ghost_arcade_message", var_1);
  wait(var_2);
  remove_ghost_arcade_message(var_0);
}

reset_num_moving_target_reached_goal() {
  level.num_moving_target_reached_goal = 0;
}

active_moving_target_available() {
  return get_num_of_active_moving_target() > 0;
}

get_num_of_active_moving_target() {
  var_0 = 0;
  foreach(var_2 in level.moving_target_priority) {
    var_0 = var_0 + var_2.size;
  }

  return var_0;
}

get_group_move_direction(var_0) {
  var_1 = level.moving_target_pattern[var_0];
  var_2 = var_1[0];
  if(var_1.size > 1) {
    var_3 = [];
    for(var_4 = 1; var_4 < var_1.size; var_4++) {
      var_3[var_3.size] = var_1[var_4];
    }

    var_3[var_3.size] = var_2;
    level.moving_target_pattern[var_0] = var_3;
  }

  return translate_direction_to_vector(var_2);
}

get_wave_move_time(var_0) {
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    return level.moving_target_wave_info[var_0].solo_move_time;
  }

  return level.moving_target_wave_info[var_0].move_time;
}

get_wave_wait_time_between_group(var_0) {
  return level.moving_target_wave_info[var_0].wait_between_group_move;
}

translate_direction_to_vector(var_0) {
  switch (var_0) {
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

fly_back_into_portal(var_0) {
  var_0 endon("death");
  var_0.flying_to_portal = 1;
  var_1 = scripts\engine\utility::getstruct("ghost_wave_start_pos", "targetname");
  var_0 moveto(var_1.origin, 6);
  var_0 waittill("movedone");
  level.num_moving_target_escaped++;
  display_target_escaped_message();
  determine_game_fail();
  remove_undefined_from_moving_target_array(var_0);
  var_0 delete();
}

display_target_escaped_message() {
  display_skull_escaped_message();
  update_num_targets_escaped_hud();
}

display_skull_escaped_message() {
  foreach(var_1 in level.players) {
    var_1 thread display_ghost_arcade_message(var_1, get_skull_escaped_message_id(), 4);
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
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("zm_ui_num_targets_escaped", level.num_moving_target_escaped);
  }
}

remove_undefined_from_moving_target_array(var_0) {
  foreach(var_3, var_2 in level.moving_target_groups) {
    level.moving_target_groups[var_3] = ::scripts\engine\utility::array_remove(var_2, var_0);
  }

  foreach(var_5, var_2 in level.moving_target_priority) {
    level.moving_target_priority[var_5] = ::scripts\engine\utility::array_remove(var_2, var_0);
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
  foreach(var_1 in level.players) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("quest_acrcade_play_fail", "zmb_comment_vo", "highest", 3, 0, 0, 1);
  }

  scripts\cp\zombies\zombie_analytics::log_player_exits_ghostskulls_games(level.ghostskulls_total_waves, level.ghostskulls_complete_status, gettime() - level.ghostskullstimestart / 1000);
  if(isDefined(level.ghost_n_skull_reactivate_func)) {
    level thread[[level.ghost_n_skull_reactivate_func]]();
  }

  delay_end_ghost(2);
}

teleport_into_arcade_console(var_0) {
  var_1 = scripts\engine\utility::getstructarray("ghost_wave_player_start", "targetname");
  var_2 = var_1[var_0 getentitynumber()];
  var_0 setorigin(var_2.origin);
  var_0 setplayerangles(var_2.angles);
}

teleport_out_of_arcade_console(var_0) {
  var_1 = scripts\engine\utility::getstructarray("ghost_wave_player_end", "targetname");
  var_2 = var_1[var_0 getentitynumber()];
  var_0 setorigin(scripts\engine\utility::drop_to_ground(var_2.origin, 50, -300));
  var_0 setplayerangles(var_2.angles);
}

turn_on_ghost_arcade_hud(var_0) {
  var_0 setclientomnvar("zm_ui_player_playing_ghost_arcade", 1);
}

turn_off_ghost_arcade_hud(var_0) {
  var_0 setclientomnvar("zm_ui_player_playing_ghost_arcade", 0);
}

show_ghost_arcade_scores(var_0) {
  foreach(var_2 in level.players) {
    if(scripts\engine\utility::istrue(var_2.playing_ghosts_n_skulls)) {
      turn_on_ghost_arcade_scores(var_2, var_0);
    }
  }
}

turn_on_ghost_arcade_scores(var_0, var_1) {
  var_0 setclientomnvar("zm_ui_show_ghost_arcade_scores", var_1);
}

turn_off_ghost_arcade_scores(var_0) {
  var_0 setclientomnvar("zm_ui_show_ghost_arcade_scores", 0);
}

register_available_formation(var_0, var_1) {
  level.available_formations[var_0] = ::scripts\engine\utility::array_add(level.available_formations[var_0], var_1);
}

register_formation_movements(var_0, var_1) {
  level.formation_movements[var_0] = var_1;
}

get_formationfunc_for_wave(var_0) {
  return level.moving_target_wave_info[var_0].formation_id;
}

disable_pistol_during_laststand() {
  level.can_use_pistol_during_laststand_func = ::ghost_wave_can_use_pistol_in_laststand;
}

enable_pistol_during_laststand() {
  level.can_use_pistol_during_laststand_func = undefined;
}

ghost_wave_can_use_pistol_in_laststand(var_0) {
  return 0;
}

store_and_reset_currency(var_0) {
  var_0.pre_ghost_currency = var_0 scripts\cp\cp_persistence::get_player_currency();
  var_0 setplayerdata("cp", "alienSession", "currency", 0);
  var_0 scripts\cp\cp_persistence::eog_player_update_stat("currency", 0, 1);
}

restore_currency(var_0) {
  var_0 setplayerdata("cp", "alienSession", "currency", int(var_0.pre_ghost_currency));
  var_0 scripts\cp\cp_persistence::eog_player_update_stat("currency", int(var_0.pre_ghost_currency), 1);
}

increment_alien_head_destroyed_count(var_0) {
  var_1 = var_0 getplayerdata("cp", "alienSession", "currency");
  var_0 setplayerdata("cp", "alienSession", "currency", int(var_1 + 1));
  var_0 scripts\cp\cp_persistence::eog_player_update_stat("currency", int(var_1 + 1), 1);
}

try_advance_death_grid_lines_and_trigger(var_0) {
  if(var_0[1] < level.current_death_grid_lines_front_y_pos) {
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
  var_0 = getent("ghost_death_trigger", "targetname");
  var_1 = var_0.origin[1];
  var_2 = var_1 + 217;
  var_3 = level.death_trigger_activate_y_pos + 217 * get_max_num_of_death_trigger_advance();
  if(var_2 >= var_3) {
    level thread delay_end_ghost_wave_on_fail();
  }

  level.current_death_grid_lines_front_y_pos = level.current_death_grid_lines_front_y_pos + 217;
  set_death_grid_lines_and_trigger_y_pos(var_2);
}

get_max_num_of_death_trigger_advance() {
  if(isDefined(level.max_num_of_death_trigger_advance)) {
    return level.max_num_of_death_trigger_advance;
  }

  return 13;
}

set_death_grid_lines_and_trigger_y_pos(var_0) {
  var_1 = getent("ghost_death_trigger", "targetname");
  var_2 = getent("ghost_death_grid_lines", "targetname");
  var_1 dontinterpolate();
  var_2 dontinterpolate();
  var_1.origin = (var_1.origin[0], var_0, var_1.origin[2]);
  var_2.origin = (var_2.origin[0], var_0, var_2.origin[2]);
}

formation_1_move_pattern(var_0) {
  return ["R", "R", "R", "F", "L", "L", "L", "F"];
}

formation_2_move_pattern(var_0) {
  return ["U", "D", "D", "U", "F"];
}

formation_3_move_pattern(var_0) {
  return ["R", "R", "R", "F", "L", "L", "L", "F"];
}

formation_4_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_5_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_6_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_7_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_8_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_9_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_10_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_11_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_12_move_pattern(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
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

formation_13_move_pattern(var_0) {
  return ["R", "R", "F", "L", "L", "F"];
}

formation_14_move_pattern(var_0) {
  return ["R", "R", "F", "L", "L", "F"];
}

formation_15_move_pattern(var_0) {
  return ["R", "R", "F", "D", "F", "U", "F", "L", "L", "F"];
}

give_gns_base_reward(var_0) {
  var_0 scripts\cp\cp_persistence::give_player_xp(1000, 1);
  var_0.have_permanent_perks = 1;
  var_0.have_gns_perk = 1;
  var_0 thread earn_all_perks(var_0);
}

earn_all_perks(var_0) {
  var_0 endon("disconnect");
  var_1 = ["perk_machine_boom", "perk_machine_flash", "perk_machine_fwoosh", "perk_machine_more", "perk_machine_rat_a_tat", "perk_machine_revive", "perk_machine_run", "perk_machine_smack", "perk_machine_tough", "perk_machine_zap"];
  if(isDefined(level.all_perk_list)) {
    var_1 = level.all_perk_list;
  }

  foreach(var_3 in var_1) {
    if(var_0 scripts\cp\utility::has_zombie_perk(var_3)) {
      continue;
    }

    wait(0.5);
    var_0 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_3, 0);
  }
}

notify_activation_progress(var_0, var_1) {
  level thread update_num_of_coin_inserted(var_0);
  if(soundexists("ghosts_quest_step_notify")) {
    foreach(var_3 in level.players) {
      var_3 playlocalsound("ghosts_quest_step_notify");
    }
  }
}

update_num_of_coin_inserted(var_0, var_1) {
  level endon("game_ended");
  if(var_0 == 6) {
    foreach(var_3 in level.players) {
      if(var_3 scripts\cp\utility::is_consumable_active("activate_gns_machine")) {
        var_3 notify("activate_gns_machine_timeup");
        var_3 notify("activate_gns_machine_exited_early");
      }
    }
  }

  if(isDefined(var_1)) {
    wait(var_1);
  }

  setomnvar("zm_num_ghost_n_skull_coin", var_0);
  level.skulls_before_activation = var_0;
}

reactivate_cabinet() {
  setomnvar("zm_num_ghost_n_skull_coin", 5);
}

set_consumable_meter_scalar(var_0, var_1) {
  var_0.consumable_meter_scalar = var_1;
}