/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_insta_kill.gsc
************************************************/

#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#namespace zm_powerup_insta_kill;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_insta_kill", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::register_powerup("insta_kill", &grab_insta_kill);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("insta_kill", "p7_zm_power_up_insta_kill", #"hash_1784640b956f2f85", &zm_powerups::func_should_always_drop, 0, 0, 0, undefined, "powerup_instant_kill", "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
  }
}

function grab_insta_kill(player) {
  if(zm_powerups::function_cfd04802(#"insta_kill")) {
    level thread function_d7a1e6a8(self, player);
  } else {
    level thread insta_kill_powerup(self, player);
  }

  player thread zm_powerups::powerup_vo("insta_kill");
}

function function_d7a1e6a8(e_powerup, player) {
  player notify(#"powerup instakill");
  player endon(#"powerup instakill", #"disconnect");

  if(player bgb::is_enabled(#"zm_bgb_temporal_gift")) {
    n_wait_time = 60;
  } else {
    n_wait_time = 30;
  }

  player thread zm_powerups::function_5091b029("insta_kill");

  if(isDefined(player) && isPlayer(player) && isDefined(e_powerup.hint)) {
    player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", e_powerup.hint);
  }

  player zombie_utility::set_zombie_var_player(#"zombie_insta_kill", 1);
  level waittilltimeout(n_wait_time, #"end_game");
  player zombie_utility::set_zombie_var_player(#"zombie_insta_kill", 0);
  player notify(#"insta_kill_over");
}

function insta_kill_powerup(drop_item, player) {
  level notify("powerup instakill_" + player.team);
  level endon("powerup instakill_" + player.team);

  if(isDefined(level.insta_kill_powerup_override)) {
    level thread[[level.insta_kill_powerup_override]](drop_item, player);
    return;
  }

  team = player.team;
  level thread zm_powerups::show_on_hud(team, "insta_kill");
  players = getplayers();

  foreach(e_player in players) {
    if(isDefined(e_player) && isPlayer(e_player) && isDefined(drop_item.hint)) {
      e_player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", drop_item.hint);
    }
  }

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