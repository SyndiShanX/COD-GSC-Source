/*********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_bonus_points_player.gsc
*********************************************************/

#using scripts\core_common\laststand_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_powerup_bonus_points_player;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_bonus_points_player", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::register_powerup("bonus_points_player", &grab_bonus_points_player);
  zm_powerups::register_powerup("bonus_points_player_shared", &function_ec014d54);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("bonus_points_player", "zombie_z_money_icon", #"hash_5162c283a9d6ee16", &zm_powerups::func_should_never_drop, 1, 0, 0);
    zm_powerups::add_zombie_powerup("bonus_points_player_shared", "zombie_z_money_icon", #"hash_5162c283a9d6ee16", &zm_powerups::func_should_never_drop, 1, 0, 0);
  }
}

function grab_bonus_points_player(player) {
  level thread bonus_points_player_powerup(self, player);
  player thread zm_powerups::powerup_vo("bonus");

  if(zm_utility::is_standard()) {
    player contracts::increment_zm_contract(#"contract_zm_rush_powerups");
  }
}

function function_ec014d54(player) {
  level thread function_56784293(self, player);

  if(player !== self.e_player_owner) {
    player thread zm_powerups::powerup_vo("bonus");

    if(isDefined(self.e_player_owner) && !is_true(self.e_player_owner.var_a50db39d)) {
      self.e_player_owner.var_a50db39d = 1;
      self.e_player_owner zm_stats::increment_challenge_stat(#"hash_733e96c5baacb1da");
    }
  }
}

function bonus_points_player_powerup(item, player) {
  if(is_true(item.var_258c5fbc)) {
    points = item.var_258c5fbc;

    if(points == 100) {
      item.var_df23dc7d = "essence_pickup_small";
    } else if(points == 250) {
      item.var_df23dc7d = "essence_pickup_medium";
    }
  } else if(is_true(level.var_a4c782b9)) {
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

  if(isDefined(player) && isPlayer(player) && isDefined(item.hint)) {
    player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", item.hint);
  }

  player notify(#"bonus_points_player_grabbed", {
    #e_powerup: item
  });
  level scoreevents::doscoreeventcallback("scoreEventZM", {
    #attacker: player, #scoreevent: isDefined(item.var_df23dc7d) ? item.var_df23dc7d : "bonus_points_powerup_zm"});
}

function function_56784293(item, player) {
  if(isDefined(player) && isPlayer(player) && isDefined(item.hint)) {
    player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", item.hint);
  }

  player notify(#"bonus_points_player_grabbed", {
    #e_powerup: item
  });
  level scoreevents::doscoreeventcallback("scoreEventZM", {
    #attacker: player, #scoreevent: isDefined(item.var_df23dc7d) ? item.var_df23dc7d : "bonus_points_powerup_zm"
  });
}