/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_fire_sale.gsc
***********************************************/

#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_magicbox;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#namespace zm_powerup_fire_sale;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_fire_sale", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::register_powerup("fire_sale", &grab_fire_sale);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("fire_sale", #"p7_zm_power_up_firesale", #"hash_2c7bc0fa0980f8f5", &func_should_drop_fire_sale, 0, 0, 0, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
  }
}

function grab_fire_sale(player) {
  if(zm_powerups::function_cfd04802("fire_sale")) {
    level thread function_3ceac0e1(self, player);
  } else {
    level thread start_fire_sale(self);
  }

  player thread zm_powerups::powerup_vo("firesale");
}

function function_3ceac0e1(e_powerup, player) {
  self notify("4e8ac3aa35304135");
  self endon("4e8ac3aa35304135");
  player endon(#"disconnect");
  player thread zm_powerups::function_5091b029("fire_sale");

  if(isDefined(player) && isPlayer(player) && isDefined(e_powerup.hint)) {
    player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", e_powerup.hint);
  }

  player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_on", 1);
  player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_time", 30);
  level waittilltimeout(30, #"end_game");
  player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_on", 0);
}

function start_fire_sale(item) {
  if(is_true(level.custom_firesale_box_leave)) {
    while(firesale_chest_is_leaving()) {
      waitframe(1);
    }
  }

  if(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") > 0 && is_true(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on"))) {
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") + 30);
    return;
  }

  level notify(#"powerup_fire_sale");
  level endon(#"powerup_fire_sale");
  zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 1);
  level.disable_firesale_drop = 1;
  level thread toggle_fire_sale_on();
  players = getplayers();

  foreach(e_player in players) {
    if(isDefined(e_player) && isPlayer(e_player) && isDefined(item.hint)) {
      e_player zm_utility::function_846eb7dd(#"hash_1d757d99eb407952", item.hint);
    }
  }

  zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 30);
  level notify(#"hash_7a941ba8e576862e");

  if(bgb::is_team_enabled(#"zm_bgb_temporal_gift")) {
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") + 30);
  }

  while(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") > 0) {
    waitframe(1);
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") - 0.05);
  }

  level thread check_to_clear_fire_sale();
  zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
  level notify(#"fire_sale_off");
}

function check_to_clear_fire_sale() {
  level endon(#"powerup_fire_sale");

  while(firesale_chest_is_leaving()) {
    waitframe(1);
  }

  wait 1;
  level.disable_firesale_drop = undefined;
}

function firesale_chest_is_leaving() {
  for(i = 0; i < level.chests.size; i++) {
    if(i !== level.chest_index) {
      if(level.chests[i].zbarrier.state === "leaving" || level.chests[i].zbarrier.state === "open" || level.chests[i].zbarrier.state === "close" || level.chests[i].zbarrier.state === "closing") {
        return true;
      }
    }
  }

  return false;
}

function toggle_fire_sale_on() {
  level endon(#"powerup_fire_sale");

  if(!isDefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on"))) {
    return;
  }

  if(!isDefined(level.chest_index)) {
    level.chest_index = 0;
  }

  level thread sndfiresalemusic_start();

  for(i = 0; i < level.chests.size; i++) {
    show_firesale_box = level.chests[i][[level._zombiemode_check_firesale_loc_valid_func]]();

    if(show_firesale_box) {
      level.chests[i].zombie_cost = 10;

      if(level.chest_index != i) {
        if(zm_custom::function_901b751c(#"zmmysteryboxstate") != 3) {
          level.chests[i].was_temp = 1;
        }

        if(is_true(level.chests[i].hidden)) {
          level.chests[i] thread apply_fire_sale_to_chest();
        }
      }
    }
  }

  level notify(#"fire_sale_on");
  level waittill(#"fire_sale_off");
  waittillframeend();
  level thread sndfiresalemusic_stop();

  for(i = 0; i < level.chests.size; i++) {
    show_firesale_box = level.chests[i][[level._zombiemode_check_firesale_loc_valid_func]]();

    if(show_firesale_box) {
      if(level.chest_index != i && isDefined(level.chests[i].was_temp)) {
        level.chests[i].was_temp = undefined;
        level thread remove_temp_chest(i);
      }

      level.chests[i].zombie_cost = level.chests[i].old_cost;
    }
  }
}

function apply_fire_sale_to_chest() {
  level endon(#"fire_sale_off");

  if(self.zbarrier.state == "leaving") {
    self.zbarrier waittilltimeout(10, #"left");
  }

  wait 0.1;
  self thread zm_magicbox::show_chest();
}

function remove_temp_chest(chest_index) {
  if(!isDefined(level.chests[chest_index])) {
    return;
  }

  level.chests[chest_index].being_removed = 1;

  while(isDefined(level.chests[chest_index]) && (isDefined(level.chests[chest_index].chest_user) || isDefined(level.chests[chest_index]._box_open) && level.chests[chest_index]._box_open == 1)) {
    util::wait_network_frame();
  }

  if(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
    level.chests[chest_index].was_temp = 1;
    level.chests[chest_index].zombie_cost = 10;
    level.chests[chest_index].being_removed = 0;
    return;
  }

  for(i = 0; i < chest_index; i++) {
    util::wait_network_frame();
  }

  playFX(level._effect[# "poltergeist"], level.chests[chest_index].orig_origin);
  util::wait_network_frame();

  if(is_true(level.custom_firesale_box_leave)) {
    level.chests[chest_index] zm_magicbox::hide_chest(1);
  } else {
    level.chests[chest_index] zm_magicbox::hide_chest();
  }

  level.chests[chest_index].being_removed = 0;
}

function func_should_drop_fire_sale() {
  if(zm_custom::function_901b751c(#"zmmysteryboxstate") == 0 || zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") == 1 || level.chest_moves < 1 || is_true(level.disable_firesale_drop)) {
    return false;
  }

  return true;
}

function sndfiresalemusic_start() {
  array = level.chests;

  foreach(struct in array) {
    if(!isDefined(struct.sndent)) {
      struct.sndent = spawn("script_origin", struct.origin + (0, 0, 100));
    }

    if(is_true(level.player_4_vox_override)) {
      struct.sndent playLoopSound(#"mus_fire_sale_rich", 1);
      continue;
    }

    struct.sndent playLoopSound(#"mus_fire_sale", 1);
  }
}

function sndfiresalemusic_stop() {
  array = level.chests;

  foreach(struct in array) {
    if(isDefined(struct.sndent)) {
      struct.sndent playSound(#"hash_332ced69176833bb");
      waitframe(1);
      struct.sndent delete();
      struct.sndent = undefined;
    }
  }
}