/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_timer.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_stalingrad_timer;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_timer", & __init__, & __main__, undefined);
}

function __init__() {}

function __main__() {
  clientfield::register("world", "time_attack_reward", 12000, 3, "int", & function_b94ee48a, 0, 0);
  level.wallbuy_callback_hack_override = & function_3ec869e2;
}

function function_b94ee48a(n_local_client, var_3bf16bb3, var_6998917a, b_new_ent, var_b54312de, str_field_name, b_was_time_jump) {
  level.var_dd724c18 = var_6998917a;
}

function function_3ec869e2() {
  switch (level.var_dd724c18) {
    case 1: {
      self setmodel("wpn_t7_loot_wrench_world");
      break;
    }
    case 2: {
      self setmodel("wpn_t7_loot_ritual_dagger_world");
      break;
    }
    case 3: {
      self setmodel("wpn_t7_loot_axe_world");
      break;
    }
    case 4: {
      self setmodel("wpn_t7_loot_sword_world");
      break;
    }
    case 5: {
      self setmodel("wpn_t7_loot_daisho_world");
      break;
    }
  }
}