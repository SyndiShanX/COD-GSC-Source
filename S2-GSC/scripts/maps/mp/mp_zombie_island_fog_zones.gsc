/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_fog_zones.gsc
**********************************************************/

init() {
  var_0 = spawnStruct();
  var_0.iszombie = 0;
  var_0.initialfunc = ::init_player_fog_callback;
  var_0.newzonefunc = ::on_player_zone_change;
  var_0.enterfunc = ::on_player_entered_fog;
  var_0.exitfunc = ::on_player_left_fog;
  var_1 = spawnStruct();
  var_1.check = ::should_restore_fog_vision_from_camo;
  var_1._id_3F02 = ::clear_player_vision;
  var_2 = spawnStruct();
  var_2.check = ::should_restore_fog_vision_isolated_room;
  var_2._id_3F02 = ::clear_restore_fog_vision_isolated_room;
  var_0.optionalstatechangechecks = [var_1, var_2];
  level thread maps\mp\_utility::_id_6F74(::run_fog_callbacks, var_0);
  level thread island_intro_window_countdown();
}

run_fog_callbacks(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.initialfunc = var_2;
    var_0.newzonefunc = var_3;
    var_0.enterfunc = var_4;
    var_0.exitfunc = var_5;
    var_0.optionalstatechangechecks = var_6;
    var_0.iszombie = var_1;
  }

  var_0.endon_notification = common_scripts\utility::_id_98E7(common_scripts\utility::_id_562E(var_0.iszombie), "death", "disconnect");
  self.fog_callback_data = var_0;
  run_fog_callbacks_internal();
  self.fog_callback_data = undefined;
}

run_fog_callbacks_internal() {
  self endon(self.fog_callback_data.endon_notification);

  if(isDefined(self.fog_callback_data.initialfunc)) {
    self[[self.fog_callback_data.initialfunc]]();
  }

  for(;;) {
    var_0 = level.zmb_island_fog_volumes get_fog_volumn_touched(self);
    var_1 = fog_state_has_change_for_agent(var_0);
    var_2 = should_force_fog_change(self.fog_callback_data.optionalstatechangechecks);

    if(var_1 || var_2) {
      var_3 = get_fog_and_light_set(var_0);
      self.current_volume = var_0;
      self.current_fog_state = level.island_fog_is_thick;

      if(isDefined(self.fog_callback_data.newzonefunc)) {
        self[[self.fog_callback_data.newzonefunc]](var_3, var_0, var_2);
      }

      var_4 = fog_is_thick_for_agent(var_3.fog);
      self.isinfogzone = var_4;

      if(var_4) {
        if(isDefined(self.fog_callback_data.enterfunc)) {
          self[[self.fog_callback_data.enterfunc]]();
        }
      } else if(isDefined(self.fog_callback_data.exitfunc))
        self[[self.fog_callback_data.exitfunc]]();
    }

    waitframe();
  }
}

on_player_entered_fog() {
  self.disablecamovisionchange = 1;
}

on_player_left_fog() {
  self.disablecamovisionchange = 0;
}

fog_is_thick_for_agent(var_0) {
  return issubstr(var_0, "fog") && !issubstr(var_0, "transition");
}

on_player_zone_change(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self notify("new_fog_change");
  self endon("new_fog_change");

  if(_id_0547::_id_5565(var_1.name, "introduction")) {
    var_3 = 0;
  } else {
    var_3 = var_0.time;
  }

  if(common_scripts\utility::_id_562E(var_2)) {
    var_3 = 0;
  }

  var_4 = get_fog_and_light_set(var_1, 1);
  self.current_volume_is_interior = !fog_is_thick_for_agent(var_4.fog);
  childthread set_light_and_fog(var_0.fog, var_0._id_5CCE, var_3);
}

clear_player_vision() {
  self visionsetnakedforplayer("", 0.25);
}

should_force_fog_change(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = 0;

  foreach(var_3 in var_0) {
    if(self[[var_3.check]]()) {
      if(isDefined(var_3._id_3F02)) {
        self[[var_3._id_3F02]]();
      }

      var_1 = 1;
    }
  }

  return var_1;
}

init_player_fog_callback() {
  self.current_volume_is_interior = 0;
  childthread apply_clientside_volume_exploder();
}

fog_state_has_change_for_agent(var_0) {
  return player_touching_new_volume(var_0) || player_entered_new_fog_state();
}

should_restore_fog_vision_from_camo() {
  if(common_scripts\utility::_id_562E(self.camovisionrestored) && !common_scripts\utility::_id_562E(self._id_569F)) {
    self.camovisionrestored = 0;
  }

  if(common_scripts\utility::_id_562E(self._id_569F) && common_scripts\utility::_id_562E(level.island_fog_is_thick) && !common_scripts\utility::_id_562E(self.camovisionrestored)) {
    self.camovisionrestored = 1;
    return 1;
  } else
    return 0;
}

set_should_restore_fog_vision_isolated_room() {
  self.haspommelflushed = 1;
}

should_restore_fog_vision_isolated_room() {
  return common_scripts\utility::_id_562E(self.haspommelflushed);
}

clear_restore_fog_vision_isolated_room() {
  self.haspommelflushed = 0;
}

apply_clientside_volume_exploder() {
  foreach(var_1 in level.clientside_exploder_runners) {
    childthread toggle_on_player_touch(var_1);
  }
}

toggle_on_player_touch(var_0) {
  for(;;) {
    wait_for_touching_any_volume(var_0);
    [[var_0._id_6B05]](self);
    wait_for_touching_no_volume(var_0);
    [[var_0.onvacantfunc]](self);
  }
}

wait_for_touching_any_volume(var_0) {
  for(;;) {
    foreach(var_2 in var_0._id_A615) {
      if(self istouching(var_2)) {
        return;
      }
    }

    waitframe();
  }
}

wait_for_touching_no_volume(var_0) {
  var_1 = 1;

  while(var_1) {
    var_1 = 0;

    foreach(var_3 in var_0._id_A615) {
      if(self istouching(var_3)) {
        var_1 = 1;
      }
    }

    waitframe();
  }
}

island_intro_window_countdown() {
  wait 0;
  wait 2;
  level.island_fog_introduction_done = 1;
}

set_fog_is_heavy(var_0) {
  level.island_fog_is_thick = var_0;
}

unlock_fog_from_lock() {
  level.fog_locked = 0;
}

player_entered_new_fog_state() {
  return !_id_0547::_id_5565(self.current_fog_state, level.island_fog_is_thick);
}

player_touching_new_volume(var_0) {
  return !_id_0547::_id_5565(self.current_volume, var_0);
}

get_fog_and_light_set(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = common_scripts\utility::_id_562E(level.island_fog_is_thick);

  if(common_scripts\utility::_id_562E(var_1)) {
    var_3 = 1;
  }

  if(var_3) {
    var_2.fog = var_0.fog_set_active;
    var_2._id_5CCE = var_0.light_set_active;
  } else {
    var_2.fog = var_0.fog_set_normal;
    var_2._id_5CCE = var_0.light_set_normal;
  }

  var_2.time = level._id_A565[var_2.fog]._id_9C83;
  return var_2;
}

get_fog_volumn_touched(var_0) {
  if(!common_scripts\utility::_id_562E(level.island_fog_introduction_done)) {
    return self[1];
  }

  foreach(var_2 in self) {
    foreach(var_4 in var_2._id_A615) {
      if(var_0 istouching(var_4)) {
        return var_2;
      }
    }
  }

  return self[0];
}

set_light_and_fog(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::_id_562E(self.fog_set_is_locked)) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_3)) {
    self.fog_set_is_locked = 1;
  }

  self setclienttriggervisionset(var_0, var_2);
  self lightsetoverrideenableforplayer(var_1, var_2);
  wait(var_2);
}