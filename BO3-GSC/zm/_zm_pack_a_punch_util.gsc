/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_pack_a_punch_util.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_weapons;
#namespace zm_pap_util;

function init_parameters() {
  if(!isDefined(level.pack_a_punch)) {
    level.pack_a_punch = spawnStruct();
    level.pack_a_punch.timeout = 15;
    level.pack_a_punch.interaction_height = 35;
    level.pack_a_punch.move_in_func = & pap_weapon_move_in;
    level.pack_a_punch.move_out_func = & pap_weapon_move_out;
    level.pack_a_punch.grabbable_by_anyone = 0;
    level.pack_a_punch.swap_attachments_on_reuse = 0;
    level.pack_a_punch.triggers = [];
  }
}

function set_timeout(n_timeout_s) {
  init_parameters();
  level.pack_a_punch.timeout = n_timeout_s;
}

function set_interaction_height(n_height) {
  init_parameters();
  level.pack_a_punch.interaction_height = n_height;
}

function set_interaction_trigger_radius(n_radius) {
  init_parameters();
  level.pack_a_punch.interaction_trigger_radius = n_radius;
}

function set_interaction_trigger_height(n_height) {
  init_parameters();
  level.pack_a_punch.set_interaction_trigger_height = n_height;
}

function set_move_in_func(fn_move_weapon_in) {
  init_parameters();
  level.pack_a_punch.move_in_func = fn_move_weapon_in;
}

function set_move_out_func(fn_move_weapon_out) {
  init_parameters();
  level.pack_a_punch.move_out_func = fn_move_weapon_out;
}

function set_grabbable_by_anyone() {
  init_parameters();
  level.pack_a_punch.grabbable_by_anyone = 1;
}

function get_triggers() {
  init_parameters();
  if(level.pack_a_punch.triggers.size == 0) {
    println("");
  }
  return level.pack_a_punch.triggers;
}

function is_pap_trigger() {
  return isDefined(self.script_noteworthy) && self.script_noteworthy == "pack_a_punch";
}

function enable_swap_attachments() {
  init_parameters();
  level.pack_a_punch.swap_attachments_on_reuse = 1;
}

function can_swap_attachments() {
  if(!isDefined(level.pack_a_punch)) {
    return 0;
  }
  return level.pack_a_punch.swap_attachments_on_reuse;
}

function update_hint_string(player) {
  if(self flag::get("pap_offering_gun")) {
    self sethintstring(&"ZOMBIE_GET_UPGRADED_FILL");
    return;
  }
  w_curr_player_weapon = player getcurrentweapon();
  if(zm_weapons::is_weapon_upgraded(w_curr_player_weapon)) {
    self sethintstring(&"ZOMBIE_PERK_PACKAPUNCH_AAT", self.aat_cost);
  } else {
    self sethintstring(&"ZOMBIE_PERK_PACKAPUNCH", self.cost);
  }
}

function private pap_weapon_move_in(player, trigger, origin_offset, angles_offset) {
  level endon("pack_a_punch_off");
  trigger endon("pap_player_disconnected");
}

function private pap_weapon_move_out(player, trigger, origin_offset, interact_offset) {
  level endon("pack_a_punch_off");
  trigger endon("pap_player_disconnected");
}