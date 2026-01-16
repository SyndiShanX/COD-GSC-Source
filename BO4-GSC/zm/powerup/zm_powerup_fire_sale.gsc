/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_fire_sale.gsc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_powerup_fire_sale;

autoexec __init__system__() {
  system::register(#"zm_powerup_fire_sale", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("fire_sale", &grab_fire_sale);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("fire_sale", "p7_zm_power_up_firesale", #"zombie/powerup_max_ammo", &func_should_drop_fire_sale, 0, 0, 0, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
  }
}

grab_fire_sale(player) {
  if(zm_powerups::function_cfd04802("fire_sale")) {
    level thread function_3ceac0e1(self, player);
  } else {
    level thread start_fire_sale(self);
  }

  player thread zm_powerups::powerup_vo("firesale");
}

function_3ceac0e1(e_powerup, player) {
  self notify("602aa2e210cb16a0");
  self endon("602aa2e210cb16a0");
  player endon(#"disconnect");
  player thread zm_powerups::function_5091b029("fire_sale");
  player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_on", 1);
  player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_time", 30);
  level waittilltimeout(30, #"end_game");
  player zombie_utility::set_zombie_var_player(#"zombie_powerup_fire_sale_on", 0);
}

start_fire_sale(item) {
  if(isDefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave) {
    while(firesale_chest_is_leaving()) {
      waitframe(1);
    }
  }

  if(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") > 0 && isDefined(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) && zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on")) {
    zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_time") + 30);
    return;
  }

  level notify(#"powerup_fire_sale");
  level endon(#"powerup_fire_sale");
  level thread zm_audio::sndannouncerplayvox(#"fire_sale");
  zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 1);
  level.disable_firesale_drop = 1;
  level thread toggle_fire_sale_on();
  zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 30);

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

check_to_clear_fire_sale() {
  level endon(#"powerup_fire_sale");

  while(firesale_chest_is_leaving()) {
    waitframe(1);
  }

  wait 1;
  level.disable_firesale_drop = undefined;
}

firesale_chest_is_leaving() {
  for(i = 0; i < level.chests.size; i++) {
    if(i !== level.chest_index) {
      if(level.chests[i].zbarrier.state === "leaving" || level.chests[i].zbarrier.state === "open" || level.chests[i].zbarrier.state === "close" || level.chests[i].zbarrier.state === "closing") {
        return true;
      }
    }
  }

  return false;
}

toggle_fire_sale_on() {
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

        if(isDefined(level.chests[i].hidden) && level.chests[i].hidden) {
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

apply_fire_sale_to_chest() {
  level endon(#"fire_sale_off");

  if(self.zbarrier.state == "leaving") {
    self.zbarrier waittilltimeout(10, #"left");
  }

  wait 0.1;
  self thread zm_magicbox::show_chest();
}

remove_temp_chest(chest_index) {
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

  playFX(level._effect[#"poltergeist"], level.chests[chest_index].orig_origin);
  util::wait_network_frame();

  if(isDefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave) {
    level.chests[chest_index] zm_magicbox::hide_chest(1);
  } else {
    level.chests[chest_index] zm_magicbox::hide_chest();
  }

  level.chests[chest_index].being_removed = 0;
}

func_should_drop_fire_sale() {
  if(zm_custom::function_901b751c(#"zmmysteryboxstate") == 0 || zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") == 1 || level.chest_moves < 1 || isDefined(level.disable_firesale_drop) && level.disable_firesale_drop) {
    return false;
  }

  return true;
}

sndfiresalemusic_start() {
  array = level.chests;

  foreach(struct in array) {
    if(!isDefined(struct.sndent)) {
      struct.sndent = spawn("script_origin", struct.origin + (0, 0, 100));
    }

    if(isDefined(level.player_4_vox_override) && level.player_4_vox_override) {
      struct.sndent playLoopSound(#"mus_fire_sale_rich", 1);
      continue;
    }

    struct.sndent playLoopSound(#"mus_fire_sale", 1);
  }
}

sndfiresalemusic_stop() {
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