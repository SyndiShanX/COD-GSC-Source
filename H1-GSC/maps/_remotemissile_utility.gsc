/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_remotemissile_utility.gsc
*******************************************/

setup_remote_missile_target() {
  if(!isdefined(level.remote_missile_targets))
    level.remote_missile_targets = [];

  level.remote_missile_targets[self.unique_id] = self;

  if(isdefined(level.uav_struct.draw_red_boxes) && !isdefined(level.uav_is_destroyed)) {
    level endon("draw_target_end");

    while (isdefined(level.setup_remote_missile_target_last_add_time) && level.setup_remote_missile_target_last_add_time == gettime())
      wait 0.05;

    level.setup_remote_missile_target_last_add_time = gettime();

    if(isalive(self))
      maps\_remotemissile::draw_target();
  }

  self waittill("death");
  level.remote_missile_targets[self.unique_id] = undefined;

  if(!isdefined(self)) {
    return;
  }
  if(isdefined(self.has_target_shader)) {
    self.has_target_shader = undefined;
    target_remove(self);
  }
}

player_uav_rig() {
  if(isdefined(level.uavrig))
    return level.uavrig;

  var_0 = maps\_remotemissile::get_current_uav_rig();
  return var_0;
}

create_uav_rigs(var_0) {
  foreach(var_2 in level.players) {
    var_3 = common_scripts\utility::spawn_tag_origin();
    var_3.origin = self.origin;
    var_3.uav = self;
    var_3 thread maps\_remotemissile::run_rig_function_when_player_uses_uav(var_0, var_2);
    var_2 add_player_rig(var_3);
    var_2 thread maps\_remotemissile::cycle_uav_rigs();
  }
}

add_player_rig(var_0) {
  if(!isdefined(self.uav_rigs))
    self.uav_rigs = [];

  self.uav_rigs[self.uav_rigs.size] = var_0;
}

give_player_remote_missiles() {
  self giveweapon("remote_missile_detonator");
  self.remotemissile_actionslot = 4;
  thread remotemissile_with_autoreloading();
  common_scripts\utility::flag_clear("predator_missile_launch_allowed");
  self setactionslot(self.remotemissile_actionslot, "weapon", "remote_missile_detonator");
}

remotemissile_reload() {
  level endon("stop_uav_reload");
  level endon("special_op_terminated");

  if(common_scripts\utility::flag("uav_reloading")) {
    if(isdefined(level.uav_is_destroyed)) {
      return;
    }
    maps\_remotemissile::disable_uav_weapon();

    if(common_scripts\utility::flag("uav_collecting_stats")) {
      level waittill("uav_collecting_stats");
      maps\_remotemissile::play_kills_dialogue();
    }

    if(isdefined(level.uav_is_destroyed)) {
      return;
    }
    level.uav_user = undefined;

    if(common_scripts\utility::flag("uav_reloading"))
      level waittill("uav_reloading");

    if(isdefined(level.uav_is_destroyed)) {
      return;
    }
    if(!common_scripts\utility::flag("uav_enabled")) {
      return;
    }
    if(self getweaponammoclip(self.uav_weaponname) < 1) {
      maps\_remotemissile::disable_uav();
      return;
    }

    maps\_remotemissile::restore_uav_weapon();
    thread maps\_remotemissile::remotemissile_radio("uav_online");
    thread maps\_remotemissile::remotemissile_radio_reminder();
  }
}

remotemissile_with_autoreloading() {
  maps\_remotemissile::remotemissile_player_input(::remotemissile_reload);
}

remotemissile_no_autoreload() {
  maps\_remotemissile::remotemissile_player_input();
}

remotemissile_move_player() {
  return isdefined(level.remotemissile_temp_move_player);
}