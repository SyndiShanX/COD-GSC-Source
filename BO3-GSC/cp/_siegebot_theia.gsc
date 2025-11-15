#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\ai\blackboard_vehicle;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_siegebot;
#using scripts\shared\weapons\_spike_charge_siegebot;
#using_animtree("generic");
#namespace siegebot_theia;

function autoexec __init__sytem__() {
  // Unsupported VM revision (1B).
}

function __init__() {
  // Unsupported VM revision (1B).
}

function siegebot_initialize() {
  // Unsupported VM revision (1B).
}

function init_clientfields() {
  // Unsupported VM revision (1B).
}

function defaultrole() {
  // Unsupported VM revision (1B).
}

function state_death_update() {
  // Unsupported VM revision (1B).
}

function clean_up_spawned() {
  // Unsupported VM revision (1B).
}

function pain_toggle() {
  // Unsupported VM revision (1B).
}

function pain_canenter() {
  // Unsupported VM revision (1B).
}

function pain_enter() {
  // Unsupported VM revision (1B).
}

function pain_exit() {
  // Unsupported VM revision (1B).
}

function pain_update() {
  // Unsupported VM revision (1B).
}

function should_prepare_death() {
  // Unsupported VM revision (1B).
}

function prepare_death_update() {
  // Unsupported VM revision (1B).
}

function scripted_exit() {
  // Unsupported VM revision (1B).
}

function initjumpstruct() {
  // Unsupported VM revision (1B).
}

function can_jump_up() {
  // Unsupported VM revision (1B).
}

function state_jumpup_enter() {
  // Unsupported VM revision (1B).
}

function can_jump_down() {
  // Unsupported VM revision (1B).
}

function state_jumpdown_enter() {
  // Unsupported VM revision (1B).
}

function can_jump_ground_to_ground() {
  // Unsupported VM revision (1B).
}

function state_jump_exit() {
  // Unsupported VM revision (1B).
}

function state_jumpdown_exit() {
  // Unsupported VM revision (1B).
}

function state_jump_update() {
  // Unsupported VM revision (1B).
}

function state_balconycombat_enter() {
  // Unsupported VM revision (1B).
}

function state_balconycombat_update() {
  // Unsupported VM revision (1B).
}

function side_step() {
  // Unsupported VM revision (1B).
}

function state_balconycombat_exit() {
  // Unsupported VM revision (1B).
}

function state_groundcombat_update() {
  // Unsupported VM revision (1B).
}

function footstep_damage() {
  // Unsupported VM revision (1B).
}

function footstep_left_monitor() {
  // Unsupported VM revision (1B).
}

function footstep_right_monitor() {
  // Unsupported VM revision (1B).
}

function highgroundpoint() {
  // Unsupported VM revision (1B).
}

function state_groundcombat_exit() {
  // Unsupported VM revision (1B).
}

function get_player_vehicle() {
  // Unsupported VM revision (1B).
}

function get_player_and_vehicle_array() {
  // Unsupported VM revision (1B).
}

function init_player_threat() {
  // Unsupported VM revision (1B).
}

function init_player_threat_all() {
  // Unsupported VM revision (1B).
}

function reset_player_threat() {
  // Unsupported VM revision (1B).
}

function add_player_threat_damage() {
  // Unsupported VM revision (1B).
}

function add_player_threat_boost() {
  // Unsupported VM revision (1B).
}

function get_player_threat() {
  // Unsupported VM revision (1B).
}

function update_target_player() {
  // Unsupported VM revision (1B).
}

function shoulder_light_focus() {
  // Unsupported VM revision (1B).
}

function debug_line_to_target() {
  // Unsupported VM revision (1B).
}

function pin_first_three_spikes_to_ground() {
  // Unsupported VM revision (1B).
}

function attack_thread_gun() {
  // Unsupported VM revision (1B).
}

function attack_thread_rocket() {
  // Unsupported VM revision (1B).
}

function toggle_rocketaim() {
  // Unsupported VM revision (1B).
}

function locomotion_start() {
  // Unsupported VM revision (1B).
}

function get_strong_target() {
  // Unsupported VM revision (1B).
}

function movement_thread() {
  // Unsupported VM revision (1B).
}

function path_update_interrupt() {
  // Unsupported VM revision (1B).
}

function getnextmoveposition() {
  // Unsupported VM revision (1B).
}

function _sort_by_distance2d() {
  // Unsupported VM revision (1B).
}

function too_close_to_high_ground() {
  // Unsupported VM revision (1B).
}

function get_jumpon_target() {
  // Unsupported VM revision (1B).
}

function stopmovementandsetbrake() {
  // Unsupported VM revision (1B).
}

function face_target() {
  // Unsupported VM revision (1B).
}

function theia_callback_damage() {
  // Unsupported VM revision (1B).
}

function attack_javelin() {
  // Unsupported VM revision (1B).
}

function javeline_incoming() {
  // Unsupported VM revision (1B).
}

function init_fake_targets() {
  // Unsupported VM revision (1B).
}

function pin_to_ground() {
  // Unsupported VM revision (1B).
}

function pin_spike_to_ground() {
  // Unsupported VM revision (1B).
}

function spike_score() {
  // Unsupported VM revision (1B).
}

function spike_group_score() {
  // Unsupported VM revision (1B).
}

function attack_spike_minefield() {
  // Unsupported VM revision (1B).
}

function delay_target_toenemy_thread() {
  // Unsupported VM revision (1B).
}

function is_valid_target() {
  // Unsupported VM revision (1B).
}

function get_enemy() {
  // Unsupported VM revision (1B).
}

function attack_minigun_sweep() {
  // Unsupported VM revision (1B).
}