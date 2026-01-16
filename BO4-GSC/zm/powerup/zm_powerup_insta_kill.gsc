/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_insta_kill.gsc
************************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_powerup_insta_kill;

autoexec __init__system__() {
  system::register(#"zm_powerup_insta_kill", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("insta_kill", &grab_insta_kill);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("insta_kill", "p7_zm_power_up_insta_kill", #"hash_1784640b956f2f85", &zm_powerups::func_should_always_drop, 0, 0, 0, undefined, "powerup_instant_kill", "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
  }
}

grab_insta_kill(player) {
  if(zm_powerups::function_cfd04802(#"insta_kill")) {
    level thread function_d7a1e6a8(self, player);
  } else {
    level thread insta_kill_powerup(self, player);
  }

  player thread zm_powerups::powerup_vo("insta_kill");
}

function_d7a1e6a8(e_powerup, player) {
  player notify(#"powerup instakill");
  player endon(#"powerup instakill", #"disconnect");

  if(player bgb::is_enabled(#"zm_bgb_temporal_gift")) {
    n_wait_time = 60;
  } else {
    n_wait_time = 30;
  }

  player thread zm_powerups::function_5091b029("insta_kill");
  player zombie_utility::set_zombie_var_player(#"zombie_insta_kill", 1);
  level waittilltimeout(n_wait_time, #"end_game");
  player zombie_utility::set_zombie_var_player(#"zombie_insta_kill", 0);
  player notify(#"insta_kill_over");
}

insta_kill_powerup(drop_item, player) {
  level notify("powerup instakill_" + player.team);
  level endon("powerup instakill_" + player.team);

  if(isDefined(level.insta_kill_powerup_override)) {
    level thread[[level.insta_kill_powerup_override]](drop_item, player);
    return;
  }

  team = player.team;
  level thread zm_powerups::show_on_hud(team, "insta_kill");
  zombie_utility::set_zombie_var_team(#"zombie_insta_kill", team, 1);
  n_wait_time = 30;

  if(bgb::is_team_enabled(#"zm_bgb_temporal_gift")) {
    n_wait_time += 30;
  }

  wait n_wait_time;
  zombie_utility::set_zombie_var_team(#"zombie_insta_kill", team, 0);
  players = getplayers(team);

  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      players[i] notify(#"insta_kill_over");
    }
  }
}