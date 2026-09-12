/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_fog_zones.gsc
**************************************************/

init() {
  var_00 = spawnStruct();
  var_00.iszombie = 0;
  var_00.initialfunc = ::init_player_fog_callback;
  var_00.newzonefunc = ::on_player_zone_change;
  var_00.enterfunc = ::on_player_entered_fog;
  var_00.exitfunc = ::on_player_left_fog;
  var_01 = spawnStruct();
  var_01.check = ::should_restore_fog_vision_from_camo;
  var_01.var_3F02 = ::clear_player_vision;
  var_02 = spawnStruct();
  var_02.check = ::should_restore_fog_vision_isolated_room;
  var_02.var_3F02 = ::clear_restore_fog_vision_isolated_room;
  var_00.optionalstatechangechecks = [var_01, var_02];
  level thread maps\mp\_utility::func_6F74(::run_fog_callbacks, var_00);
  level thread island_intro_window_countdown();
}

run_fog_callbacks(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(param_00)) {
    param_00 = spawnStruct();
    param_00.initialfunc = param_02;
    param_00.newzonefunc = param_03;
    param_00.enterfunc = param_04;
    param_00.exitfunc = param_05;
    param_00.optionalstatechangechecks = param_06;
    param_00.iszombie = param_01;
  }

  param_00.endon_notification = common_scripts\utility::func_98E7(common_scripts\utility::func_562E(param_00.iszombie), "death", "disconnect");
  self.fog_callback_data = param_00;
  run_fog_callbacks_internal();
  self.fog_callback_data = undefined;
}

run_fog_callbacks_internal() {
  self endon(self.fog_callback_data.endon_notification);
  if(isDefined(self.fog_callback_data.initialfunc)) {
    self[[self.fog_callback_data.initialfunc]]();
  }

  for(;;) {
    var_00 = level.zmb_island_fog_volumes get_fog_volumn_touched(self);
    var_01 = fog_state_has_change_for_agent(var_00);
    var_02 = should_force_fog_change(self.fog_callback_data.optionalstatechangechecks);
    if(var_01 || var_02) {
      var_03 = get_fog_and_light_set(var_00);
      self.current_volume = var_00;
      self.current_fog_state = level.island_fog_is_thick;
      if(isDefined(self.fog_callback_data.newzonefunc)) {
        self[[self.fog_callback_data.newzonefunc]](var_03, var_00, var_02);
      }

      var_04 = fog_is_thick_for_agent(var_03.fog);
      self.isinfogzone = var_04;
      if(var_04) {
        if(isDefined(self.fog_callback_data.enterfunc)) {
          self[[self.fog_callback_data.enterfunc]]();
        }
      } else if(isDefined(self.fog_callback_data.exitfunc)) {
        self[[self.fog_callback_data.exitfunc]]();
      }
    }

    wait 0.05;
  }
}

on_player_entered_fog() {
  self.disablecamovisionchange = 1;
}

on_player_left_fog() {
  self.disablecamovisionchange = 0;
}

fog_is_thick_for_agent(param_00) {
  return issubstr(param_00, "fog") && !issubstr(param_00, "transition");
}

on_player_zone_change(param_00, param_01, param_02) {
  self endon("death");
  self endon("disconnect");
  self notify("new_fog_change");
  self endon("new_fog_change");
  if(lib_0547::func_5565(param_01.name, "introduction")) {
    var_03 = 0;
  } else {
    var_03 = param_01.time;
  }

  if(common_scripts\utility::func_562E(param_02)) {
    var_03 = 0;
  }

  var_04 = get_fog_and_light_set(param_01, 1);
  self.current_volume_is_interior = !fog_is_thick_for_agent(var_04.fog);
  childthread set_light_and_fog(param_00.fog, param_00.var_5CCE, var_03);
}

clear_player_vision() {
  self visionsetnakedforplayer("", 0.25);
}

should_force_fog_change(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = 0;
  foreach(var_03 in param_00) {
    if(self[[var_03.check]]()) {
      if(isDefined(var_03.var_3F02)) {
        self[[var_03.var_3F02]]();
      }

      var_01 = 1;
    }
  }

  return var_01;
}

init_player_fog_callback() {
  self.current_volume_is_interior = 0;
  childthread apply_clientside_volume_exploder();
}

fog_state_has_change_for_agent(param_00) {
  return player_touching_new_volume(param_00) || player_entered_new_fog_state();
}

should_restore_fog_vision_from_camo() {
  if(common_scripts\utility::func_562E(self.camovisionrestored) && !common_scripts\utility::func_562E(self.var_569F)) {
    self.camovisionrestored = 0;
  }

  if(common_scripts\utility::func_562E(self.var_569F) && common_scripts\utility::func_562E(level.island_fog_is_thick) && !common_scripts\utility::func_562E(self.camovisionrestored)) {
    self.camovisionrestored = 1;
    return 1;
  }

  return 0;
}

set_should_restore_fog_vision_isolated_room() {
  self.haspommelflushed = 1;
}

should_restore_fog_vision_isolated_room() {
  return common_scripts\utility::func_562E(self.haspommelflushed);
}

clear_restore_fog_vision_isolated_room() {
  self.haspommelflushed = 0;
}

apply_clientside_volume_exploder() {
  foreach(var_01 in level.clientside_exploder_runners) {
    childthread toggle_on_player_touch(var_01);
  }
}

toggle_on_player_touch(param_00) {
  for(;;) {
    wait_for_touching_any_volume(param_00);
    [[param_00.var_6B05]](self);
    wait_for_touching_no_volume(param_00);
    [[param_00.onvacantfunc]](self);
  }
}

wait_for_touching_any_volume(param_00) {
  for(;;) {
    foreach(var_02 in param_00.var_A615) {
      if(self istouching(var_02)) {
        return;
      }
    }

    wait 0.05;
  }
}

wait_for_touching_no_volume(param_00) {
  var_01 = 1;
  while(var_01) {
    var_01 = 0;
    foreach(var_03 in param_00.var_A615) {
      if(self istouching(var_03)) {
        var_01 = 1;
      }
    }

    wait 0.05;
  }
}

island_intro_window_countdown() {
  wait(0);
  wait(2);
  level.island_fog_introduction_done = 1;
}

set_fog_is_heavy(param_00) {
  level.island_fog_is_thick = param_00;
}

unlock_fog_from_lock() {
  level.fog_locked = 0;
}

player_entered_new_fog_state() {
  return !lib_0547::func_5565(self.current_fog_state, level.island_fog_is_thick);
}

player_touching_new_volume(param_00) {
  return !lib_0547::func_5565(self.current_volume, param_00);
}

get_fog_and_light_set(param_00, param_01) {
  var_02 = spawnStruct();
  var_03 = common_scripts\utility::func_562E(level.island_fog_is_thick);
  if(common_scripts\utility::func_562E(param_01)) {
    var_03 = 1;
  }

  if(var_03) {
    var_02.fog = param_00.fog_set_active;
    var_02.var_5CCE = param_00.light_set_active;
  } else {
    var_02.fog = param_00.fog_set_normal;
    var_02.var_5CCE = param_00.light_set_normal;
  }

  var_02.time = level.vision_set_fog[var_02.fog].transitiontime;
  return var_02;
}

get_fog_volumn_touched(param_00) {
  if(!common_scripts\utility::func_562E(level.island_fog_introduction_done)) {
    return self[1];
  }

  foreach(var_02 in self) {
    foreach(var_04 in var_02.var_A615) {
      if(param_00 istouching(var_04)) {
        return var_02;
      }
    }
  }

  return self[0];
}

set_light_and_fog(param_00, param_01, param_02, param_03) {
  if(common_scripts\utility::func_562E(self.fog_set_is_locked)) {
    return;
  }

  if(common_scripts\utility::func_562E(param_03)) {
    self.fog_set_is_locked = 1;
  }

  self method_8483(param_00, param_02);
  self lightsetoverrideenableforplayer(param_01, param_02);
  wait(param_02);
}