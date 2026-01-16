/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_bonus_points_team.gsc
*******************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;

#namespace zm_powerup_bonus_points_team;

autoexec __init__system__() {
  system::register(#"zm_powerup_bonus_points_team", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("bonus_points_team", &grab_bonus_points_team);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_always_drop, 0, 0, 0);
  }
}

grab_bonus_points_team(player) {
  level thread bonus_points_team_powerup(self, player);
  player thread zm_powerups::powerup_vo("bonus");
}

bonus_points_team_powerup(item, player) {
  if(isDefined(level.var_a4c782b9) && level.var_a4c782b9) {
    points = randomintrange(2, 11) * 100;
  } else {
    points = 500;
  }

  if(isDefined(level.bonus_points_powerup_override)) {
    points = item[[level.bonus_points_powerup_override]](player);
  }

  foreach(e_player in level.players) {
    e_player zm_score::player_add_points("bonus_points_powerup", points, undefined, undefined, undefined, undefined, 1);
  }
}