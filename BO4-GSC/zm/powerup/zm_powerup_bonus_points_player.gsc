/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_bonus_points_player.gsc
*********************************************************/

#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_utility;

#namespace zm_powerup_bonus_points_player;

autoexec __init__system__() {
  system::register(#"zm_powerup_bonus_points_player", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("bonus_points_player", &grab_bonus_points_player);
  zm_powerups::register_powerup("bonus_points_player_shared", &function_ec014d54);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("bonus_points_player", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
    zm_powerups::add_zombie_powerup("bonus_points_player_shared", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
  }
}

grab_bonus_points_player(player) {
  level thread bonus_points_player_powerup(self, player);
  player thread zm_powerups::powerup_vo("bonus");

  if(zm_utility::is_standard()) {
    player contracts::increment_zm_contract(#"contract_zm_rush_powerups");
  }
}

function_ec014d54(player) {
  level thread function_56784293(self, player);

  if(player !== self.e_player_owner) {
    player thread zm_powerups::powerup_vo("bonus");

    if(isDefined(self.e_player_owner) && !(isDefined(self.e_player_owner.var_a50db39d) && self.e_player_owner.var_a50db39d)) {
      self.e_player_owner.var_a50db39d = 1;
      self.e_player_owner zm_stats::increment_challenge_stat(#"hash_733e96c5baacb1da");
    }
  }
}

bonus_points_player_powerup(item, player) {
  if(isDefined(item.var_258c5fbc) && item.var_258c5fbc) {
    points = item.var_258c5fbc;
  } else if(isDefined(level.var_a4c782b9) && level.var_a4c782b9) {
    points = randomintrange(1, 25) * 100;
  } else {
    points = 500;
  }

  if(isDefined(level.bonus_points_powerup_override)) {
    points = item[[level.bonus_points_powerup_override]](player);
  }

  if(isDefined(item.bonus_points_powerup_override)) {
    points = item[[item.bonus_points_powerup_override]](player);
  }

  player notify(#"bonus_points_player_grabbed", {
    #e_powerup: item
  });
  player zm_score::player_add_points("bonus_points_powerup", points, undefined, undefined, undefined, undefined, 1);
}

function_56784293(item, player) {
  player notify(#"bonus_points_player_grabbed", {
    #e_powerup: item
  });
  player zm_score::player_add_points("bonus_points_powerup_shared", 500, undefined, undefined, undefined, undefined, 1);
}