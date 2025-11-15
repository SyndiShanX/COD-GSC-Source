/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_impatient.gsc
********************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_talisman;
#include scripts\zm_common\zm_utility;

#namespace zm_talisman_impatient;

autoexec __init__system__() {
  system::register(#"zm_talisman_impatient", &__init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_impatient", &activate_talisman);
}

activate_talisman() {
  self endon(#"disconnect");
  self.var_135a4148 = 0;

  while(true) {
    self waittill(#"bled_out");
    self thread special_revive();
  }
}

special_revive() {
  self endon(#"disconnect", #"end_of_round");

  if(self.var_135a4148 == zm_round_logic::get_round_number()) {
    return;
  }

  if(level.zombie_total <= 3) {
    wait 1;
  }

  n_target_kills = level.zombie_player_killed_count + 100;

  while(level.zombie_player_killed_count < n_target_kills && level.zombie_total >= 3) {
    waitframe(1);
  }

  self.var_135a4148 = zm_round_logic::get_round_number();
  self zm_player::spectator_respawn_player();
  self val::set(#"talisman_impatient", "ignoreme");
  wait 5;
  self val::reset(#"talisman_impatient", "ignoreme");
}