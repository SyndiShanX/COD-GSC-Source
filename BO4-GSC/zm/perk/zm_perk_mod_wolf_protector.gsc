/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_wolf_protector.gsc
**************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm\powerup\zm_powerup_bonus_points_player;
#include scripts\zm\powerup\zm_powerup_hero_weapon_power;
#include scripts\zm\powerup\zm_powerup_small_ammo;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_mod_wolf_protector;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_wolf_protector", &__init__, undefined, undefined);
}

__init__() {
  if(getdvarint(#"hash_4e1190045ef3588b", 0)) {
    function_27473e44();
  }
}

function_27473e44() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_wolf_protector", "mod_wolf_protector", #"perk_wolf_protector", #"specialty_wolf_protector", 4000);
  zm_perks::register_perk_clientfields(#"specialty_mod_wolf_protector", &register_clientfield, &set_clientfield);
  zm_perks::register_perk_threads(#"specialty_mod_wolf_protector", &give_perk, &take_perk);
  callback::on_ai_killed(&on_ai_killed);
  zm_powerups::register_powerup("wolf_bonus_points", &function_5517e41a);
  zm_powerups::register_powerup("wolf_bonus_ammo", &zm_powerup_small_ammo::function_81558cdf);
  zm_powerups::register_powerup("wolf_bonus_hero_power", &zm_powerup_hero_weapon_power::hero_weapon_power);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("wolf_bonus_points", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
    zm_powerups::add_zombie_powerup("wolf_bonus_ammo", "p7_zm_power_up_max_ammo", #"hash_69256172c78db147", &zm_powerups::func_should_never_drop, 1, 0, 0);
    zm_powerups::add_zombie_powerup("wolf_bonus_hero_power", "p8_zm_powerup_full_power", #"zombie_powerup_free_perk", &zm_powerup_hero_weapon_power::function_7e51ac0f, 1, 0, 0);
  }
}

register_clientfield() {}

set_clientfield(state) {}

give_perk() {}

take_perk(b_pause, str_perk, str_result, n_slot) {}

function_5517e41a(player) {
  level thread zm_powerup_bonus_points_player::bonus_points_player_powerup(self, player);
}

on_ai_killed(s_params) {
  e_attacker = s_params.einflictor;

  if(isDefined(e_attacker) && isplayer(e_attacker.player_owner) && e_attacker.player_owner hasperk(#"specialty_mod_wolf_protector")) {
    if(level.active_powerups.size < 75) {
      if(math::cointoss(25)) {
        roll = randomintrangeinclusive(0, 100);

        if(roll <= 33) {
          e_powerup = zm_powerups::specific_powerup_drop("wolf_bonus_hero_power", self.origin, undefined, 0.1, e_attacker.player_owner, 0, 1);

          if(isDefined(e_powerup)) {
            e_powerup setscale(0.3);
            e_powerup.var_c2bcd604 = 5;
          }

          return;
        }

        if(roll >= 66) {
          e_powerup = zm_powerups::specific_powerup_drop("wolf_bonus_ammo", self.origin, undefined, 0.1, e_attacker.player_owner, 0, 1);

          if(isDefined(e_powerup)) {
            e_powerup setscale(0.3);
          }

          return;
        }

        e_powerup = zm_powerups::specific_powerup_drop("wolf_bonus_points", self.origin, undefined, 0.1, e_attacker.player_owner, 0, 1);

        if(isDefined(e_powerup)) {
          e_powerup setscale(0.3);
          e_powerup.var_258c5fbc = 10;
        }
      }
    }
  }
}