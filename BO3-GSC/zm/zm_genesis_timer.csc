/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_timer.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_genesis_timer;

function autoexec __init__sytem__() {
  system::register("zm_genesis_timer", &__init__, &__main__, undefined);
}

function __init__() {}

function __main__() {
  clientfield::register("world", "time_attack_reward", 12000, 3, "int", &function_b94ee48a, 0, 0);
  level.wallbuy_callback_hack_override = &function_3ec869e2;
}

function function_b94ee48a(n_local_client, var_3bf16bb3, var_6998917a, b_new_ent, var_b54312de, str_field_name, b_was_time_jump) {
  level.var_dd724c18 = var_6998917a;
}

function function_3ec869e2() {
  s_parent = self.parent_struct;
  if(!isDefined(s_parent.var_67b0ba8d)) {
    s_parent.var_67b0ba8d = s_parent.origin;
  }
  if(!isDefined(self.var_cd859c93)) {
    self.var_cd859c93 = self.angles;
  }
  v_offset_origin = (0, 0, 0);
  var_5c51aae8 = (0, 0, 0);
  switch (level.var_dd724c18) {
    case 1: {
      self setModel("wpn_t7_loot_nunchucks_world");
      break;
    }
    case 2: {
      self setModel("wpn_t7_loot_mace_world");
      var_5c51aae8 = vectorscale((1, 0, 0), 90);
      break;
    }
    case 3: {
      self setModel("wpn_t7_loot_improvise_world");
      v_offset_origin = vectorscale((0, -1, 0), 3);
      var_5c51aae8 = vectorscale((1, 0, 0), 90);
      break;
    }
    case 4: {
      self setModel("wpn_t7_loot_boneglass_world");
      v_offset_origin = (0, -6, 1);
      var_5c51aae8 = vectorscale((-1, 0, 0), 15);
      break;
    }
    case 5: {
      self setModel("wpn_t7_loot_melee_katana_world");
      v_offset_origin = (1, -22, 0);
      var_5c51aae8 = vectorscale((-1, 0, 0), 88);
      break;
    }
  }
  s_parent.origin = s_parent.var_67b0ba8d + v_offset_origin;
  self.angles = self.var_cd859c93 + var_5c51aae8;
}