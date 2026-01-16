/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_hero_weapon_power.gsc
*******************************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_powerup_hero_weapon_power;

autoexec __init__system__() {
  system::register(#"zm_powerup_hero_weapon_power", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("hero_weapon_power", &hero_weapon_power);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("hero_weapon_power", "p8_zm_powerup_full_power", #"zombie_powerup_free_perk", &function_7e51ac0f, 1, 0, 0);
  }
}

function_7e51ac0f() {
  return level.var_ff96c5e4;
}

hero_weapon_power(e_player) {
  e_player endon(#"death");

  if(isDefined(self.var_1f23fe79) && self.var_1f23fe79) {
    self waittill(#"hash_3eaa776332738598");
  }

  if(isDefined(self.var_c2bcd604) && self.var_c2bcd604) {
    e_player gadgetpowerchange(level.var_a53a05b5, self.var_c2bcd604);
  } else {
    e_player gadgetpowerset(level.var_a53a05b5, 100);
  }

  e_player thread function_5792ec16();
}

private function_5792ec16() {
  self endon(#"disconnect");
  self.var_c09e6d59 = 1;
  wait 2;
  self.var_c09e6d59 = undefined;
}