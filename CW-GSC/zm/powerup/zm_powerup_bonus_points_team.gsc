/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_bonus_points_team.gsc
*******************************************************/

#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#namespace zm_powerup_bonus_points_team;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_bonus_points_team", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::register_powerup("bonus_points_team", &grab_bonus_points_team);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", #"hash_5162c283a9d6ee16", &zm_powerups::func_should_always_drop, 0, 0, 0);
  }
}

function grab_bonus_points_team(player) {
  level thread bonus_points_team_powerup(self, player);
  player thread zm_powerups::powerup_vo("bonus");
}

function bonus_points_team_powerup(item, player) {
  if(is_true(level.var_a4c782b9)) {
    points = randomintrange(2, 11) * 100;
  } else {
    points = 500;
  }

  if(isDefined(level.bonus_points_powerup_override)) {
    points = item[[level.bonus_points_powerup_override]](player);
  }

  foreach(e_player in level.players) {
    if(isDefined(e_player) && isPlayer(e_player) && isDefined(item.hint)) {
      e_player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", item.hint);
    }

    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: e_player, #scoreevent: "bonus_points_powerup_zm"
    });
  }
}