/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\aats\zm_aat_kill_o_watt.gsc
*************************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\callbacks;

#namespace zm_aat_kill_o_watt;

autoexec __init__system__() {
  system::register("zm_aat_kill_o_watt", &__init__, undefined, #"aat");
}

__init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }

  aat::register("zm_aat_kill_o_watt", 0.33, 0, 30, 5, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, 3);
  clientfield::register("actor", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter");
  clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter");
  clientfield::register("actor", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int");
  clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int");
  level.var_7fe61e7a = lightning_chain::create_lightning_chain_params(6, 7, 160);
  level.var_7fe61e7a.head_gib_chance = 0;
  level.var_7fe61e7a.network_death_choke = 4;
  level.var_7fe61e7a.should_kill_enemies = 0;
  level.var_7fe61e7a.challenge_stat_name = #"zombie_hunter_kill_o_watt";
  level.var_7fe61e7a.no_fx = 1;
  level.var_7fe61e7a.clientside_fx = 0;
  level.var_7fe61e7a.str_mod = "MOD_AAT";
  level.var_7fe61e7a.n_damage_max = 20000;
  level.var_7fe61e7a.var_a9255d36 = #"hash_1003dc8cc0b680f2";
  callback::function_4b58e5ab(&function_439d6573);
}

result(death, attacker, mod, weapon) {
  if(!isDefined(zombie_utility::get_zombie_var(#"tesla_head_gib_chance"))) {
    zombie_utility::set_zombie_var(#"tesla_head_gib_chance", 50);
  }

  level.var_7fe61e7a.weapon = weapon;
  self thread function_1d0f645d(attacker);
}

function_1d0f645d(player) {
  if(isDefined(self.spawn_time) && gettime() == self.spawn_time) {
    waitframe(1);
  }

  if(isDefined(self)) {
    self clientfield::increment("zm_aat_kill_o_watt" + "_explosion", 1);
  }

  a_zombies = getaiteamarray(level.zombie_team);
  a_zombies = arraysortclosest(a_zombies, self getcentroid(), 6, 0, 160);

  foreach(e_zombie in a_zombies) {
    e_zombie function_3c98a3f4(player, self);
  }
}

function_3c98a3f4(player, var_fb0999c0) {
  if(!isalive(self)) {
    return;
  }

  if(isDefined(level.aat[#"zm_aat_kill_o_watt"].immune_result_indirect[self.archetype]) && level.aat[#"zm_aat_kill_o_watt"].immune_result_indirect[self.archetype]) {
    return;
  }

  if(self == var_fb0999c0 && isDefined(level.aat[#"zm_aat_kill_o_watt"].immune_result_direct[self.archetype]) && level.aat[#"zm_aat_kill_o_watt"].immune_result_direct[self.archetype]) {
    return;
  }

  if(self ai::is_stunned() || isDefined(self.var_661d1e79) && self.var_661d1e79) {
    return;
  }

  self.var_661d1e79 = 1;
  self thread function_fbd6ea47(player);
}

function_fbd6ea47(player) {
  self endon(#"death");
  self clientfield::set("zm_aat_kill_o_watt" + "_zap", 1);
  self lightning_chain::arc_damage_ent(player, 2, level.var_7fe61e7a);
  wait 6;
  self thread function_439d6573();
}

function_439d6573() {
  if(isDefined(self.var_661d1e79) && self.var_661d1e79) {
    self.var_661d1e79 = 0;
    self clientfield::set("zm_aat_kill_o_watt" + "_zap", 0);
    self notify(#"hash_1003dc8cc0b680f2");
  }
}