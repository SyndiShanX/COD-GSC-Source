/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_fire_sale.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_bgb_machine;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#namespace zm_powerup_fire_sale;

function autoexec __init__sytem__() {
  system::register("zm_powerup_fire_sale", & __init__, undefined, undefined);
}

function __init__() {
  zm_powerups::register_powerup("fire_sale", & grab_fire_sale);
  if(tolower(getdvarstring("g_gametype")) != "zcleansed") {
    zm_powerups::add_zombie_powerup("fire_sale", "p7_zm_power_up_firesale", & "ZOMBIE_POWERUP_MAX_AMMO", & func_should_drop_fire_sale, 0, 0, 0, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
  }
}

function grab_fire_sale(player) {
  level thread start_fire_sale(self);
  player thread zm_powerups::powerup_vo("firesale");
}

function start_fire_sale(item) {
  if(isDefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave) {
    while(firesale_chest_is_leaving()) {
      wait(0.05);
    }
  }
  if(level.zombie_vars["zombie_powerup_fire_sale_time"] > 0 && (isDefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"])) {
    level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] + 30;
    return;
  }
  level notify("hash_3b3c2756");
  level endon("hash_3b3c2756");
  level thread zm_audio::sndannouncerplayvox("fire_sale");
  level.zombie_vars["zombie_powerup_fire_sale_on"] = 1;
  level.disable_firesale_drop = 1;
  level thread toggle_fire_sale_on();
  level.zombie_vars["zombie_powerup_fire_sale_time"] = 30;
  if(bgb::is_team_enabled("zm_bgb_temporal_gift")) {
    level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] + 30;
  }
  while(level.zombie_vars["zombie_powerup_fire_sale_time"] > 0) {
    wait(0.05);
    level.zombie_vars["zombie_powerup_fire_sale_time"] = level.zombie_vars["zombie_powerup_fire_sale_time"] - 0.05;
  }
  level thread check_to_clear_fire_sale();
  level.zombie_vars["zombie_powerup_fire_sale_on"] = 0;
  level notify("fire_sale_off");
}

function check_to_clear_fire_sale() {
  while(firesale_chest_is_leaving()) {
    wait(0.05);
  }
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
  level endon("hash_3b3c2756");
  if(!isDefined(level.zombie_vars["zombie_powerup_fire_sale_on"])) {
    return;
  }
  level thread sndfiresalemusic_start();
  bgb_machine::turn_on_fire_sale();
  for(i = 0; i < level.chests.size; i++) {
    show_firesale_box = level.chests[i][[level._zombiemode_check_firesale_loc_valid_func]]();
    if(show_firesale_box) {
      level.chests[i].zombie_cost = 10;
      if(level.chest_index != i) {
        level.chests[i].was_temp = 1;
        if(isDefined(level.chests[i].hidden) && level.chests[i].hidden) {
          level.chests[i] thread apply_fire_sale_to_chest();
        }
      }
    }
  }
  level notify("fire_sale_on");
  level waittill("fire_sale_off");
  waittillframeend();
  level thread sndfiresalemusic_stop();
  bgb_machine::turn_off_fire_sale();
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
  if(self.zbarrier getzbarrierpiecestate(1) == "closing") {
    while(self.zbarrier getzbarrierpiecestate(1) == "closing") {
      wait(0.1);
    }
    self.zbarrier waittill("left");
  }
  wait(0.1);
  self thread zm_magicbox::show_chest();
}

function remove_temp_chest(chest_index) {
  level.chests[chest_index].being_removed = 1;
  while(isDefined(level.chests[chest_index].chest_user) || (isDefined(level.chests[chest_index]._box_open) && level.chests[chest_index]._box_open == 1)) {
    util::wait_network_frame();
  }
  if(level.zombie_vars["zombie_powerup_fire_sale_on"]) {
    level.chests[chest_index].was_temp = 1;
    level.chests[chest_index].zombie_cost = 10;
    level.chests[chest_index].being_removed = 0;
    return;
  }
  for(i = 0; i < chest_index; i++) {
    util::wait_network_frame();
  }
  playFX(level._effect["poltergeist"], level.chests[chest_index].orig_origin);
  level.chests[chest_index].zbarrier playSound("zmb_box_poof_land");
  level.chests[chest_index].zbarrier playSound("zmb_couch_slam");
  util::wait_network_frame();
  if(isDefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave) {
    level.chests[chest_index] zm_magicbox::hide_chest(1);
  } else {
    level.chests[chest_index] zm_magicbox::hide_chest();
  }
  level.chests[chest_index].being_removed = 0;
}

function func_should_drop_fire_sale() {
  if(level.zombie_vars["zombie_powerup_fire_sale_on"] == 1 || level.chest_moves < 1 || (isDefined(level.disable_firesale_drop) && level.disable_firesale_drop)) {
    return false;
  }
  return true;
}

function sndfiresalemusic_start() {
  array = level.chests;
  foreach(struct in array) {
    if(!isDefined(struct.sndent)) {
      struct.sndent = spawn("script_origin", struct.origin + vectorscale((0, 0, 1), 100));
    }
    if(isDefined(level.player_4_vox_override) && level.player_4_vox_override) {
      struct.sndent playLoopSound("mus_fire_sale_rich", 1);
      continue;
    }
    struct.sndent playLoopSound("mus_fire_sale", 1);
  }
}

function sndfiresalemusic_stop() {
  array = level.chests;
  foreach(struct in array) {
    if(isDefined(struct.sndent)) {
      struct.sndent delete();
      struct.sndent = undefined;
    }
  }
}