/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_pers_upgrades_system.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_pers_upgrades_system;

function pers_register_upgrade(name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved) {
  if(!isdefined(level.pers_upgrades)) {
    level.pers_upgrades = [];
    level.pers_upgrades_keys = [];
  }
  if(isdefined(level.pers_upgrades[name])) {
    assert(0, "" + name);
  }
  level.pers_upgrades_keys[level.pers_upgrades_keys.size] = name;
  level.pers_upgrades[name] = spawnstruct();
  level.pers_upgrades[name].stat_names = [];
  level.pers_upgrades[name].stat_desired_values = [];
  level.pers_upgrades[name].upgrade_active_func = upgrade_active_func;
  level.pers_upgrades[name].game_end_reset_if_not_achieved = game_end_reset_if_not_achieved;
  add_pers_upgrade_stat(name, stat_name, stat_desired_value);
  if(isdefined(level.devgui_add_ability)) {
    [
      [level.devgui_add_ability]
    ](name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved);
  }
}

function add_pers_upgrade_stat(name, stat_name, stat_desired_value) {
  if(!isdefined(level.pers_upgrades[name])) {
    assert(0, name + "");
  }
  stats_size = level.pers_upgrades[name].stat_names.size;
  level.pers_upgrades[name].stat_names[stats_size] = stat_name;
  level.pers_upgrades[name].stat_desired_values[stats_size] = stat_desired_value;
}

function pers_upgrades_monitor() {
  if(!isdefined(level.pers_upgrades)) {
    return;
  }
  if(!zm_utility::is_classic()) {
    return;
  }
  level thread wait_for_game_end();
  while (true) {
    waittillframeend();
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
      player = players[player_index];
      if(zm_utility::is_player_valid(player) && isdefined(player.stats_this_frame)) {
        if(!player.stats_this_frame.size && (!(isdefined(player.pers_upgrade_force_test) && player.pers_upgrade_force_test))) {
          continue;
        }
        for (pers_upgrade_index = 0; pers_upgrade_index < level.pers_upgrades_keys.size; pers_upgrade_index++) {
          pers_upgrade = level.pers_upgrades[level.pers_upgrades_keys[pers_upgrade_index]];
          is_stat_updated = player is_any_pers_upgrade_stat_updated(pers_upgrade);
          if(is_stat_updated) {
            should_award = player check_pers_upgrade(pers_upgrade);
            if(should_award) {
              if(isdefined(player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]]) && player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]]) {
                continue;
              }
              player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]] = 1;
              if(level flag::get("initial_blackscreen_passed") && (!(isdefined(player.is_hotjoining) && player.is_hotjoining))) {
                type = "upgrade";
                if(isdefined(level.snd_pers_upgrade_force_type)) {
                  type = level.snd_pers_upgrade_force_type;
                }
                player playsoundtoplayer("evt_player_upgrade", player);
                if(isdefined(level.pers_upgrade_vo_spoken) && level.pers_upgrade_vo_spoken) {
                  player util::delay(1, undefined, & zm_audio::create_and_play_dialog, "general", type, level.snd_pers_upgrade_force_variant);
                }
                if(isdefined(player.upgrade_fx_origin)) {
                  else {}
                  fx_org = player.upgrade_fx_origin;
                  player.upgrade_fx_origin = undefined;
                } else {
                  fx_org = player.origin;
                  v_dir = anglestoforward(player getplayerangles());
                  v_up = anglestoup(player getplayerangles());
                  fx_org = (fx_org + (v_dir * 30)) + (v_up * 12);
                }
                playfx(level._effect["upgrade_aquired"], fx_org);
                level thread zm::disable_end_game_intermission(1.5);
              }
              player iprintlnbold("");
              if(isdefined(pers_upgrade.upgrade_active_func)) {
                player thread[[pers_upgrade.upgrade_active_func]]();
              }
              continue;
            }
            if(isdefined(player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]]) && player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]]) {
              if(level flag::get("initial_blackscreen_passed") && (!(isdefined(player.is_hotjoining) && player.is_hotjoining))) {
                player playsoundtoplayer("evt_player_downgrade", player);
              }
              player iprintlnbold("");
            }
            player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]] = 0;
          }
        }
        player.pers_upgrade_force_test = 0;
        player.stats_this_frame = [];
      }
    }
    wait(0.05);
  }
}

function wait_for_game_end() {
  if(!zm_utility::is_classic()) {
    return;
  }
  level waittill("end_game");
  players = getplayers();
  for (player_index = 0; player_index < players.size; player_index++) {
    player = players[player_index];
    for (index = 0; index < level.pers_upgrades_keys.size; index++) {
      str_name = level.pers_upgrades_keys[index];
      game_end_reset_if_not_achieved = level.pers_upgrades[str_name].game_end_reset_if_not_achieved;
      if(isdefined(game_end_reset_if_not_achieved) && game_end_reset_if_not_achieved == 1) {
        if(!(isdefined(player.pers_upgrades_awarded[str_name]) && player.pers_upgrades_awarded[str_name])) {
          for (stat_index = 0; stat_index < level.pers_upgrades[str_name].stat_names.size; stat_index++) {
            player zm_stats::zero_client_stat(level.pers_upgrades[str_name].stat_names[stat_index], 0);
          }
        }
      }
    }
  }
}

function check_pers_upgrade(pers_upgrade) {
  should_award = 1;
  for (i = 0; i < pers_upgrade.stat_names.size; i++) {
    stat_name = pers_upgrade.stat_names[i];
    should_award = self check_pers_upgrade_stat(stat_name, pers_upgrade.stat_desired_values[i]);
    if(!should_award) {
      break;
    }
  }
  return should_award;
}

function is_any_pers_upgrade_stat_updated(pers_upgrade) {
  if(isdefined(self.pers_upgrade_force_test) && self.pers_upgrade_force_test) {
    return 1;
  }
  result = 0;
  for (i = 0; i < pers_upgrade.stat_names.size; i++) {
    stat_name = pers_upgrade.stat_names[i];
    if(isdefined(self.stats_this_frame[stat_name])) {
      result = 1;
      break;
    }
  }
  return result;
}

function check_pers_upgrade_stat(stat_name, stat_desired_value) {
  should_award = 1;
  current_stat_value = self zm_stats::get_global_stat(stat_name);
  if(current_stat_value < stat_desired_value) {
    should_award = 0;
  }
  return should_award;
}

function round_end() {
  if(!zm_utility::is_classic()) {
    return;
  }
  self notify("pers_stats_end_of_round");
  if(isdefined(self.pers["pers_max_round_reached"])) {
    if(level.round_number > self.pers["pers_max_round_reached"]) {
      self zm_stats::set_client_stat("pers_max_round_reached", level.round_number, 0);
    }
  }
}