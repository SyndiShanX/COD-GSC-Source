/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_door_powerup.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_utility;

#namespace zm_white_door_powerup;

init() {
  init_flags();
  level thread perks_behind_door();
}

init_flags() {
  level flag::init("magic_door_power_up_grabbed");
  level flag::init("population_count_step_complete");
}

door_powerup_drop(powerup_name, var_e3a28454, powerup_team, powerup_location) {
  if(isDefined(level.door_powerup)) {
    level.door_powerup zm_powerups::powerup_delete();
  }

  powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", var_e3a28454 + (0, 0, 40));
  powerup setModel(#"tag_origin");
  level notify(#"powerup_dropped", powerup);

  if(isDefined(powerup)) {
    powerup.grabbed_level_notify = #"magic_door_power_up_grabbed";
    powerup function_94cd396e(powerup_name, powerup_team, var_e3a28454);
    powerup thread zm_powerups::powerup_wobble();
    powerup thread zm_powerups::powerup_grab(powerup_team);
    level.door_powerup = powerup;
  }
}

perks_behind_door() {
  if(level.enable_magic !== 1) {
    return;
  }

  if(!zm_custom::function_901b751c("zmPowerupsActive") || zm_custom::function_901b751c("zmPowerupsIsLimitedRound") || !zm_custom::function_901b751c("zmPowerupNuke") || !zm_custom::function_901b751c("zmPowerupDouble") || !zm_custom::function_901b751c("zmPowerupInstakill") || !zm_custom::function_901b751c("zmPowerupFireSale") || !zm_custom::function_901b751c("zmPowerupMaxAmmo")) {
    return;
  }

  level endon(#"magic_door_power_up_grabbed", #"population_count_step_complete");
  level thread powerup_grabbed_watcher();
  level flag::wait_till("initial_blackscreen_passed");
  level.var_2cc90a51 = [];
  level.var_2cc90a51[0] = "nuke";
  level.var_2cc90a51[1] = "double_points";
  level.var_2cc90a51[2] = "insta_kill";
  level.var_2cc90a51[3] = "fire_sale";
  level.var_2cc90a51[4] = "full_ammo";
  index = 0;
  level.ammodrop = struct::get("zm_nuked_ammo_drop", "script_noteworthy");
  level.perk_type = level.var_2cc90a51[index];
  index++;
  door_powerup_drop(level.perk_type, level.ammodrop.origin);

  while(true) {
    level waittill(#"nuke_clock_moved");

    if(index == level.var_2cc90a51.size) {
      index = 0;
    }

    level.perk_type = level.var_2cc90a51[index];
    index++;
    door_powerup_drop(level.perk_type, level.ammodrop.origin);
  }
}

powerup_grabbed_watcher() {
  level waittill(#"magic_door_power_up_grabbed");
  level flag::set(#"magic_door_power_up_grabbed");
}

function_94cd396e(powerup_override, powerup_team, powerup_location, powerup_player, shouldplaysound = 1, var_a6d11a96) {
  str_powerup = undefined;

  if(!isDefined(powerup_override)) {
    str_powerup = zm_powerups::get_valid_powerup();
  } else {
    str_powerup = powerup_override;

    if("tesla" == str_powerup && zm_powerups::tesla_powerup_active()) {
      str_powerup = "minigun";
    }
  }

  struct = level.zombie_powerups[str_powerup];

  if(isDefined(powerup_team)) {
    self.powerup_team = powerup_team;
  }

  if(isDefined(powerup_location)) {
    self.powerup_location = powerup_location;
  }

  if(isDefined(powerup_player)) {
    self.powerup_player = powerup_player;
  } else {
    assert(!(isDefined(struct.player_specific) && struct.player_specific), "<dev string:x38>");
  }

  self.powerup_name = struct.powerup_name;
  self.hint = struct.hint;
  self.only_affects_grabber = struct.only_affects_grabber;
  self.any_team = struct.any_team;
  self.zombie_grabbable = struct.zombie_grabbable;
  self.func_should_drop_with_regular_powerups = struct.func_should_drop_with_regular_powerups;

  if(isDefined(level._custom_powerups) && isDefined(level._custom_powerups[str_powerup]) && isDefined(level._custom_powerups[str_powerup].setup_powerup)) {
    self[[level._custom_powerups[str_powerup].setup_powerup]]();
  } else {
    self zm_powerups::function_76678c8d(powerup_location, struct.model_name, var_a6d11a96);
  }

  if(isDefined(struct.fx)) {
    self.fx = struct.fx;
  }

  if(isDefined(struct.can_pick_up_in_last_stand)) {
    self.can_pick_up_in_last_stand = struct.can_pick_up_in_last_stand;
  }

  var_b9dc5e9 = isDefined(struct.var_184f74ef) ? struct.var_184f74ef : 0;

  if(!(isDefined(var_b9dc5e9) && var_b9dc5e9)) {
    if((str_powerup == "bonus_points_player" || str_powerup == "bonus_points_player_shared") && zm_utility::is_standard()) {
      self playSound(#"hash_1229e9d60b3181ef");
      self playLoopSound(#"hash_46b9bf1ae523021c");
    } else {
      self playSound(#"zmb_spawn_powerup");
      self playLoopSound(#"zmb_spawn_powerup_loop");
    }
  }

  level.active_powerups[level.active_powerups.size] = self;
  self thread zm_powerups::function_14b7208c(str_powerup, powerup_team, powerup_location, powerup_player);
}