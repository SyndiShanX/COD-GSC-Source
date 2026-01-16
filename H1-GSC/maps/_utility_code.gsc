/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_utility_code.gsc
********************************/

linetime_proc(var_0, var_1, var_2, var_3) {
  for (var_4 = 0; var_4 < var_3 * 20; var_4++)
    wait 0.05;
}

structarray_swap(var_0, var_1) {
  var_2 = var_0.struct_array_index;
  var_3 = var_1.struct_array_index;
  self.array[var_3] = var_0;
  self.array[var_2] = var_1;
  self.array[var_2].struct_array_index = var_2;
  self.array[var_3].struct_array_index = var_3;
}

waitspread_code(var_0, var_1) {
  waittillframeend;
  var_2 = [];

  if(level.wait_spreaders == 1) {
    var_2[0] = randomfloatrange(var_0, var_1);
    level.wait_spreader_allotment = var_2;
    level.active_wait_spread = undefined;
    return;
  }

  var_2[0] = var_0;
  var_2[var_2.size] = var_1;

  for (var_3 = 1; var_3 < level.wait_spreaders - 1; var_3++)
    var_2 = waitspread_insert(var_2);

  level.wait_spreader_allotment = common_scripts\utility::array_randomize(var_2);
  level.active_wait_spread = undefined;
}

waitspread_insert(var_0) {
  var_1 = -1;
  var_2 = 0;

  for (var_3 = 0; var_3 < var_0.size - 1; var_3++) {
    var_4 = var_0[var_3 + 1] - var_0[var_3];

    if(var_4 <= var_2) {
      continue;
    }
    var_2 = var_4;
    var_1 = var_3;
  }

  var_5 = [];

  for (var_6 = 0; var_6 < var_0.size; var_6++) {
    if(var_1 == var_6 - 1)
      var_5[var_5.size] = randomfloatrange(var_0[var_1], var_0[var_1 + 1]);

    var_5[var_5.size] = var_0[var_6];
  }

  return var_5;
}

waittill_objective_event_proc(var_0) {
  while (level.deathspawner[self.script_deathchain] > 0)
    level waittill("spawner_expired" + self.script_deathchain);

  if(var_0)
    self waittill("trigger");

  var_1 = maps\_utility::get_trigger_flag();
  common_scripts\utility::flag_set(var_1);
}

wait_until_done_speaking() {
  self endon("death");
  self endon("removed from battleChatter");

  while (self.isspeaking)
    wait 0.05;
}

wait_for_trigger_think(var_0) {
  self endon("death");
  var_0 endon("trigger");
  self waittill("trigger");
  var_0 notify("trigger");
}

wait_for_trigger(var_0, var_1) {
  var_2 = getentarray(var_0, var_1);
  var_3 = spawnstruct();
  common_scripts\utility::array_thread(var_2, ::wait_for_trigger_think, var_3);
  var_3 waittill("trigger");
}

ent_waits_for_trigger(var_0) {
  self endon("done");
  var_0 waittill("trigger");
  self notify("done");
}

update_debug_friendlycolor_on_death() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  var_0 = self.unique_id;
  self waittill("death");
  level.debug_color_friendlies[var_0] = undefined;
  level notify("updated_color_friendlies");
}

update_debug_friendlycolor(var_0) {
  thread update_debug_friendlycolor_on_death();

  if(isdefined(self.script_forcecolor))
    level.debug_color_friendlies[var_0] = self.script_forcecolor;
  else
    level.debug_color_friendlies[var_0] = undefined;

  level notify("updated_color_friendlies");
}

new_color_being_set(var_0) {
  self notify("new_color_being_set");
  self.new_force_color_being_set = 1;
  maps\_colors::left_color_node();
  self endon("new_color_being_set");
  self endon("death");
  waittillframeend;
  waittillframeend;

  if(isdefined(self.script_forcecolor)) {
    self.currentcolorcode = level.currentcolorforced[self.team][self.script_forcecolor];

    if(!isdefined(self.dontcolormove))
      thread maps\_colors::goto_current_colorindex();
    else
      self.dontcolormove = undefined;
  }

  self.new_force_color_being_set = undefined;
  self notify("done_setting_new_color");
}

radio_queue_thread(var_0) {
  var_1 = gettime();

  for (;;) {
    if(!isdefined(self._radio_queue)) {
      break;
    }

    self waittill("finished_radio");

    if(gettime() > var_1 + 7500)
      return;
  }

  self._radio_queue = 1;
  maps\_utility::wait_for_buffer_time_to_pass(level.last_mission_sound_time, 0.5);
  level.player maps\_utility::play_sound_on_entity(level.scr_radio[var_0]);
  self._radio_queue = undefined;
  level.last_mission_sound_time = gettime();
  self notify("finished_radio");
}

ent_wait_for_flag_or_time_elapses(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

waittill_either_function_internal(var_0, var_1, var_2) {
  var_0 endon("done");
  [[var_1]](var_2);
  var_0 notify("done");
}

hintprintwait(var_0, var_1) {
  if(!isdefined(var_1)) {
    wait(var_0);
    return;
  }

  var_2 = var_0 * 20;

  for (var_3 = 0; var_3 < var_2; var_3++) {
    if([
        [var_1]
      ]()) {
      break;
    }

    wait 0.05;
  }
}

hint_timeout(var_0) {
  wait(var_0);
  self.timed_out = 1;
}

hint_stick_get_updated(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return var_0 + _hint_stick_get_config_suffix(var_1, var_2, var_3, var_4, var_5, var_6);
}

_hint_stick_get_config_suffix(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getsticksconfig();

  if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
    if(isdefined(level.ps3) && level.ps3 || isdefined(level.ps4) && level.ps4) {
      if(issubstr(var_6, "southpaw") || var_5 && issubstr(var_6, "legacy"))
        return var_4;
      else
        return var_3;
    } else if(issubstr(var_6, "southpaw") || var_5 && issubstr(var_6, "legacy"))
      return var_2;
    else
      return var_1;
  } else
    return var_0;
}

_hint_stick_update_string(var_0, var_1) {
  var_2 = var_1 + var_0;
  var_3 = level.trigger_hint_func[var_2];
  level.hint_breakfunc = var_3;
}

_hint_stick_update_breakfunc(var_0, var_1) {
  var_2 = var_1 + var_0;
  var_3 = level.trigger_hint_string[var_2];
  level.current_hint settext(var_3);
}

hint_stick_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level notify("hint_change_config");
  level endon("hint_change_config");
  var_7 = _hint_stick_get_config_suffix(var_1, var_2, var_3, var_4, var_5, var_6);
  _hint_stick_update_string(var_7, var_0);
  _hint_stick_update_breakfunc(var_7, var_0);

  while (isdefined(level.current_hint)) {
    var_8 = _hint_stick_get_config_suffix(var_1, var_2, var_3, var_4, var_5, var_6);

    if(var_8 != var_7) {
      var_7 = var_8;
      _hint_stick_update_string(var_7, var_0);
      _hint_stick_update_breakfunc(var_7, var_0);
    }

    waitframe();
  }
}

hintprint(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = gettime();

  if(!isdefined(var_6))
    var_6 = 0;

  if(!isalive(self)) {
    return;
  }
  if(!isdefined(var_7))
    var_7 = 0;

  if(isdefined(var_8))
    var_7 = var_7 - 14;

  var_10 = var_7;

  if(level.console)
    var_10 = var_10 - 1;

  var_11 = 1.0;
  var_12 = 0.75;
  var_13 = 1.0;
  var_14 = 0.5;

  if(isdefined(level.hint_fontscale))
    var_14 = level.hint_fontscale;

  if(isdefined(self.current_global_hint)) {
    if(self.current_global_hint == var_0)
      return;
  }

  maps\_utility::ent_flag_waitopen("global_hint_in_use");

  if(isdefined(self.current_global_hint)) {
    if(self.current_global_hint == var_0)
      return;
  }

  maps\_utility::ent_flag_set("global_hint_in_use");
  self.current_global_hint = var_0;
  maps\_hud_util::add_hint_background(var_8, var_7);
  var_15 = maps\_hud_util::createclientfontstring("timer", var_14);
  level.current_hint = var_15;
  level.hint_breakfunc = var_1;
  thread destroy_hint_on_friendlyfire(var_15);
  level endon("friendlyfire_mission_fail");
  var_15.alpha = 1.0;
  var_15 maps\_hud_util::setpoint("TOP", undefined, 0, 127 + var_10);
  var_15.foreground = 0;
  var_15.hidewhendead = 1;
  var_15.hidewheninmenu = 1;
  var_15 settext(var_0);

  if(isdefined(level.hint_nofadein) && level.hint_nofadein || isdefined(level.slowmo.speed_slow) && level.slowmo.speed_slow < 0.1) {
    var_15.alpha = var_13;
    hintprintwait(0, level.hint_breakfunc);
  } else {
    var_15.alpha = 0;
    var_15 fadeovertime(var_11);
    var_15.alpha = var_13;
    hintprintwait(var_11, level.hint_breakfunc);
  }

  var_16 = 0;

  if(isdefined(var_4))
    var_16 = 3;
  else if(isdefined(var_3))
    var_16 = 2;
  else if(isdefined(var_2))
    var_16 = 1;

  var_17 = spawnstruct();
  var_17.timed_out = 0;

  if(isdefined(var_5))
    var_17 thread hint_timeout(var_5);

  if(isdefined(level.hint_breakfunc)) {
    for (;;) {
      hintprintwait(var_12, level.hint_breakfunc);

      if(var_16 == 3) {
        if([
            [level.hint_breakfunc]
          ](var_2, var_3, var_4)) {
          break;
        }
      } else if(var_16 == 2) {
        if([
            [level.hint_breakfunc]
          ](var_2, var_3)) {
          break;
        }
      } else if(var_16 == 1) {
        if([
            [level.hint_breakfunc]
          ](var_2)) {
          break;
        }
      } else if([
          [level.hint_breakfunc]
        ]()) {
        break;
      }
    }
  } else {
    for (var_18 = 0; var_18 < 10; var_18++)
      hintprintwait(var_12, level.hint_breakfunc);
  }

  maps\_utility::wait_for_buffer_time_to_pass(var_9, var_6);
  var_15 notify("destroying");
  self.current_global_hint = undefined;
  maps\_hud_util::clear_hint_background();
  var_15 destroy();
  level.current_hint = undefined;
  maps\_utility::ent_flag_clear("global_hint_in_use");
}

hintdisplayhandlerupdate(var_0) {
  level.player notify("HintDisplayHandlerEnd");
  level.player endon("HintDisplayHandlerEnd");
  level.player maps\_utility::ent_flag_waitopen("global_hint_in_use");
  level.player maps\_utility::ent_flag_wait("global_hint_in_use");

  while (level.player maps\_utility::ent_flag("global_hint_in_use")) {
    if(!level.player common_scripts\utility::is_player_gamepad_enabled() && isdefined(level.hint_list[var_0]["pc"]))
      level.current_hint settext(level.hint_list[var_0]["pc"]);
    else {
      var_1 = getsticksconfig();

      if(issubstr(var_1, "southpaw") && isdefined(level.hint_list[var_0]["southpaw"]))
        level.current_hint settext(level.hint_list[var_0]["southpaw"]);
      else
        level.current_hint settext(level.hint_list[var_0]["gamepad"]);
    }

    wait 0.05;
  }
}

hintdisplayhandlersetup(var_0) {
  if(!level.player common_scripts\utility::is_player_gamepad_enabled() && isdefined(level.hint_list[var_0]["pc"]))
    level.trigger_hint_string[var_0] = level.hint_list[var_0]["pc"];
  else {
    var_1 = getsticksconfig();

    if(issubstr(var_1, "southpaw") && isdefined(level.hint_list[var_0]["southpaw"]))
      level.trigger_hint_string[var_0] = level.hint_list[var_0]["southpaw"];
    else
      level.trigger_hint_string[var_0] = level.hint_list[var_0]["gamepad"];
  }

  if((isdefined(level.hint_list[var_0]["pc"]) || isdefined(level.hint_list[var_0]["southpaw"])) && ![
      [level.trigger_hint_func[var_0]]
    ]())
    thread hintdisplayhandlerupdate(var_0);
  else
    level.player notify("HintDisplayHandlerEnd");
}

destroy_hint_on_friendlyfire(var_0) {
  var_0 endon("destroying");
  level waittill("friendlyfire_mission_fail");

  if(!isdefined(var_0)) {
    return;
  }
  self.current_global_hint = undefined;
  var_0 destroy();
  maps\_utility::ent_flag_clear("global_hint_in_use");
}

showhintprint_struct(var_0) {
  var_0.timed_out = 0;

  if(!isalive(self)) {
    return;
  }
  var_1 = 1.0;
  var_2 = 0.75;
  var_3 = 0.95;
  var_4 = 0.4;
  maps\_utility::ent_flag_waitopen("global_hint_in_use");
  maps\_utility::ent_flag_set("global_hint_in_use");

  if(var_0.timed_out) {
    return;
  }
  if(isdefined(var_0.timeout))
    var_0 thread hint_timeout(var_0.timeout);

  var_5 = maps\_hud_util::createclientfontstring("objective", 2);
  var_5.alpha = 0.9;
  var_5.x = 0;
  var_5.y = -38;
  var_5.alignx = "center";
  var_5.aligny = "middle";
  var_5.horzalign = "center";
  var_5.vertalign = "middle";
  var_5.foreground = 0;
  var_5.hidewhendead = 1;
  var_5 settext(var_0.string);
  var_5.alpha = 0;
  var_5 fadeovertime(var_1);
  var_5.alpha = var_3;
  hintprintwait(var_1);

  for (;;) {
    var_5 fadeovertime(var_2);
    var_5.alpha = var_4;
    hintprintwait(var_2);

    if(var_0.timed_out) {
      break;
    }

    var_5 fadeovertime(var_2);
    var_5.alpha = var_3;
    hintprintwait(var_2);

    if(var_0.timed_out) {
      break;
    }
  }

  var_5 destroy();
  maps\_utility::ent_flag_clear("global_hint_in_use");
}

lerp_player_view_to_tag_smoothly_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isdefined(self.first_frame_time) && self.first_frame_time == gettime())
    wait 0.1;

  var_8 = self gettagorigin(var_1);
  var_9 = self gettagangles(var_1);
  var_10 = var_0 maps\_utility::lerp_player_view_to_position_leave_linked(var_8, var_9, var_2, var_3, var_4, var_5, var_6, var_7);
  var_0 playerlinktodelta(self, var_1, var_3, var_4, var_5, var_6, var_7);
  var_10 delete();
}

lerp_player_view_to_tag_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isdefined(self.first_frame_time) && self.first_frame_time == gettime())
    wait 0.1;

  var_9 = self gettagorigin(var_1);
  var_10 = self gettagangles(var_1);
  var_0 maps\_utility::lerp_player_view_to_position(var_9, var_10, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(var_8) {
    return;
  }
  var_0 playerlinkto(self, var_1, var_3, var_4, var_5, var_6, var_7, 0);
}

lerp_player_view_to_tag_oldstyle_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isdefined(self.first_frame_time) && self.first_frame_time == gettime())
    wait 0.1;

  var_9 = self gettagorigin(var_1);
  var_10 = self gettagangles(var_1);
  var_0 maps\_utility::lerp_player_view_to_position_oldstyle(var_9, var_10, var_2, var_3, var_4, var_5, var_6, var_7, 1);

  if(var_8) {
    return;
  }
  var_0 playerlinktodelta(self, var_1, var_3, var_4, var_5, var_6, var_7, 0);
}

function_stack_wait(var_0) {
  self endon("death");
  var_0 common_scripts\utility::waittill_either("function_done", "death");
}

function_stack_wait_finish(var_0) {
  function_stack_wait(var_0);

  if(!isdefined(self))
    return 0;

  if(!issentient(self))
    return 1;

  if(isalive(self))
    return 1;

  return 0;
}

function_stack_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isdefined(var_0.function_stack))
    var_0.function_stack = [];

  var_0.function_stack[var_0.function_stack.size] = self;
  thread function_stack_self_death(var_0);
  self.param1 = var_2;
  function_stack_caller_waits_for_turn(var_0);

  if(isdefined(var_0) && isdefined(var_0.function_stack)) {
    self.function_stack_func_begun = 1;
    self notify("function_stack_func_begun");
    var_7 = gettime();

    if(isdefined(var_6))
      var_0[[var_1]](var_2, var_3, var_4, var_5, var_6);
    else if(isdefined(var_5))
      var_0[[var_1]](var_2, var_3, var_4, var_5);
    else if(isdefined(var_4))
      var_0[[var_1]](var_2, var_3, var_4);
    else if(isdefined(var_3))
      var_0[[var_1]](var_2, var_3);
    else if(isdefined(var_2))
      var_0[[var_1]](var_2);
    else
      var_0[[var_1]]();

    if(gettime() == var_7)
      waittillframeend;

    if(isdefined(var_0) && isdefined(var_0.function_stack)) {
      var_0.function_stack = common_scripts\utility::array_remove(var_0.function_stack, self);
      var_0 notify("level_function_stack_ready");
    }
  }

  if(isdefined(self)) {
    self.function_stack_func_begun = 0;
    self notify("function_done");
  }
}

function_stack_self_death(var_0) {
  self endon("function_done");
  self waittill("death");

  if(isdefined(var_0)) {
    var_0.function_stack = common_scripts\utility::array_remove(var_0.function_stack, self);
    var_0 notify("level_function_stack_ready");
  }
}

function_stack_caller_waits_for_turn(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("clear_function_stack");

  while (isdefined(var_0.function_stack) && var_0.function_stack[0] != self)
    var_0 waittill("level_function_stack_ready");
}

unflash_flag(var_0) {
  level endon("player_flashed");
  wait(var_0);
  thread soundscripts\_audio::aud_restore_after_flashbang();
  common_scripts\utility::flag_clear("player_flashed");
}

wait_for_sounddone_or_death(var_0) {
  self endon("death");
  var_0 waittill("sounddone");
  return 1;
}

init_vision_set(var_0) {
  level.lvl_visionset = var_0;

  if(!isdefined(level.vision_cheat_enabled)) {
    level.vision_cheat_enabled = 0;
    setsaveddvar("using_vision_cheat", 0);
  }

  return level.vision_cheat_enabled;
}

array_waitlogic1(var_0, var_1, var_2) {
  array_waitlogic2(var_0, var_1, var_2);
  self._array_wait = 0;
  self notify("_array_wait");
}

array_waitlogic2(var_0, var_1, var_2) {
  var_0 endon(var_1);
  var_0 endon("death");

  if(isdefined(var_2))
    wait(var_2);
  else
    var_0 waittill(var_1);
}

exec_call(var_0) {
  if(var_0.parms.size == 0)
    var_0.caller call[[var_0.func]]();
  else if(var_0.parms.size == 1)
    var_0.caller call[[var_0.func]](var_0.parms[0]);
  else if(var_0.parms.size == 2)
    var_0.caller call[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  else if(var_0.parms.size == 3)
    var_0.caller call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);

  if(var_0.parms.size == 4)
    var_0.caller call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);

  if(var_0.parms.size == 5)
    var_0.caller call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
}

exec_call_noself(var_0) {
  if(var_0.parms.size == 0)
    call[[var_0.func]]();
  else if(var_0.parms.size == 1)
    call[[var_0.func]](var_0.parms[0]);
  else if(var_0.parms.size == 2)
    call[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  else if(var_0.parms.size == 3)
    call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);

  if(var_0.parms.size == 4)
    call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);

  if(var_0.parms.size == 5)
    call[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
}

exec_func(var_0, var_1) {
  if(!isdefined(var_0.caller)) {
    return;
  }
  for (var_2 = 0; var_2 < var_1.size; var_2++)
    var_1[var_2].caller endon(var_1[var_2].ender);

  if(var_0.parms.size == 0)
    var_0.caller[[var_0.func]]();
  else if(var_0.parms.size == 1)
    var_0.caller[[var_0.func]](var_0.parms[0]);
  else if(var_0.parms.size == 2)
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  else if(var_0.parms.size == 3)
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);

  if(var_0.parms.size == 4)
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);

  if(var_0.parms.size == 5)
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
}

waittill_func_ends(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var_0, var_1);
  self.count--;
  self notify("func_ended");
}

waittill_abort_func_ends(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var_0, var_1);
  self.abort_count--;
  self notify("abort_func_ended");
}

do_abort(var_0) {
  self endon("all_funcs_ended");

  if(!var_0.size) {
    return;
  }
  var_1 = 0;
  self.abort_count = var_0.size;
  var_2 = [];
  common_scripts\utility::array_levelthread(var_0, ::waittill_abort_func_ends, var_2);

  for (;;) {
    if(self.abort_count <= var_1) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

translate_local_on_ent(var_0) {
  if(isdefined(self.forward)) {
    var_1 = anglestoforward(var_0.angles);
    var_0.origin = var_0.origin + var_1 * self.forward;
  }

  if(isdefined(self.right)) {
    var_2 = anglestoright(var_0.angles);
    var_0.origin = var_0.origin + var_2 * self.right;
  }

  if(isdefined(self.up)) {
    var_3 = anglestoup(var_0.angles);
    var_0.origin = var_0.origin + var_3 * self.up;
  }

  if(isdefined(self.yaw))
    var_0 addyaw(self.yaw);

  if(isdefined(self.pitch))
    var_0 addpitch(self.pitch);

  if(isdefined(self.roll))
    var_0 addroll(self.roll);
}

dynamic_run_speed_proc(var_0, var_1, var_2, var_3, var_4) {
  self notify("start_dynamic_run_speed");
  self endon("death");
  self endon("stop_dynamic_run_speed");
  self endon("start_dynamic_run_speed");
  level endon("_stealth_spotted");

  if(maps\_utility::ent_flag_exist("_stealth_custom_anim"))
    maps\_utility::ent_flag_waitopen("_stealth_custom_anim");

  if(!maps\_utility::ent_flag_exist("dynamic_run_speed_stopped")) {
    maps\_utility::ent_flag_init("dynamic_run_speed_stopped");
    maps\_utility::ent_flag_init("dynamic_run_speed_stopping");
  } else {
    maps\_utility::ent_flag_clear("dynamic_run_speed_stopping");
    maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
  }

  self.run_speed_state = "";
  self.old_moveplaybackrate = self.moveplaybackrate;
  thread stop_dynamic_run_speed();
  var_5 = var_0 * var_0;
  var_6 = var_1 * var_1;
  var_7 = var_2 * var_2;
  var_8 = var_3 * var_3;

  for (;;) {
    wait 0.05;
    var_9 = level.players[0];

    foreach(var_11 in level.players) {
      if(distancesquared(var_9.origin, self.origin) > distancesquared(var_11.origin, self.origin))
        var_9 = var_11;
    }

    var_13 = anglestoforward(self.angles);
    var_14 = vectornormalize(var_9.origin - self.origin);
    var_15 = vectordot(var_13, var_14);
    var_16 = distancesquared(self.origin, var_9.origin);
    var_17 = var_16;

    if(isdefined(var_4)) {
      var_18 = common_scripts\utility::getclosest(var_9.origin, var_4);
      var_17 = distancesquared(var_18.origin, var_9.origin);
    }

    var_19 = 0;

    if(isdefined(self.last_set_goalent))
      var_19 = [
        [level.drs_ahead_test]
      ](self.last_set_goalent, var_1);
    else if(isdefined(self.last_set_goalnode))
      var_19 = [
        [level.drs_ahead_test]
      ](self.last_set_goalnode, var_1);

    if(isdefined(self.cqbwalking) && self.cqbwalking && !self.dontchangemoveplaybackrate)
      self.moveplaybackrate = 1;

    if(var_16 < var_6 || var_15 > -0.25 || var_19) {
      dynamic_run_set("sprint");
      wait 0.5;
      continue;
    } else if(var_16 < var_5 || var_15 > -0.25) {
      dynamic_run_set("run");
      wait 0.5;
      continue;
    } else if(var_17 > var_7) {
      if(self.a.movement != "stop") {
        dynamic_run_set("stop");
        wait 0.5;
      }

      continue;
    } else if(var_16 > var_8) {
      dynamic_run_set("jog");
      wait 0.5;
      continue;
    }
  }
}

stop_dynamic_run_speed() {
  self endon("start_dynamic_run_speed");
  self endon("death");
  stop_dynamic_run_speed_wait();

  if(!self.dontchangemoveplaybackrate)
    self.moveplaybackrate = self.old_moveplaybackrate;

  if(isdefined(level.scr_anim["generic"]["DRS_run"])) {
    if(isarray(level.scr_anim["generic"]["DRS_run"]))
      maps\_utility::set_generic_run_anim_array("DRS_run");
    else
      maps\_utility::set_generic_run_anim("DRS_run");
  } else
    maps\_utility::clear_run_anim();

  self notify("stop_loop");
  maps\_utility::ent_flag_clear("dynamic_run_speed_stopping");
  maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
}

stop_dynamic_run_speed_wait() {
  level endon("_stealth_spotted");
  self waittill("stop_dynamic_run_speed");
}

dynamic_run_ahead_test(var_0, var_1) {
  if(!isdefined(var_0.classname)) {
    if(!isdefined(var_0.type))
      var_2 = maps\_spawner::get_target_structs;
    else
      var_2 = maps\_spawner::get_target_nodes;
  } else
    var_2 = maps\_spawner::get_target_ents;

  return maps\_spawner::go_to_node_wait_for_player(var_0, var_2, var_1);
}

dynamic_run_set(var_0) {
  if(self.run_speed_state == var_0) {
    return;
  }
  self.run_speed_state = var_0;

  switch (var_0) {
    case "sprint":
      if(isdefined(self.cqbwalking) && self.cqbwalking && !self.dontchangemoveplaybackrate)
        self.moveplaybackrate = 1;
      else if(!self.dontchangemoveplaybackrate)
        self.moveplaybackrate = 1.15;

      if(isarray(level.scr_anim["generic"]["DRS_sprint"]))
        maps\_utility::set_generic_run_anim_array("DRS_sprint");
      else
        maps\_utility::set_generic_run_anim("DRS_sprint");

      self notify("stop_loop");
      maps\_utility::anim_stopanimscripted();
      maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
      break;
    case "run":
      if(!self.dontchangemoveplaybackrate)
        self.moveplaybackrate = self.old_moveplaybackrate;

      if(isdefined(level.scr_anim["generic"]["DRS_run"])) {
        if(isarray(level.scr_anim["generic"]["DRS_run"]))
          maps\_utility::set_generic_run_anim_array("DRS_run");
        else
          maps\_utility::set_generic_run_anim("DRS_run");
      } else
        maps\_utility::clear_run_anim();

      self notify("stop_loop");
      maps\_utility::anim_stopanimscripted();
      maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
      break;
    case "stop":
      thread dynamic_run_speed_stopped();
      break;
    case "jog":
      if(!self.dontchangemoveplaybackrate)
        self.moveplaybackrate = self.old_moveplaybackrate;

      if(isdefined(level.scr_anim["generic"]["DRS_combat_jog"])) {
        if(isarray(level.scr_anim["generic"]["DRS_combat_jog"]))
          maps\_utility::set_generic_run_anim_array("DRS_combat_jog");
        else
          maps\_utility::set_generic_run_anim("DRS_combat_jog");
      } else
        maps\_utility::clear_run_anim();

      self notify("stop_loop");
      maps\_utility::anim_stopanimscripted();
      maps\_utility::ent_flag_clear("dynamic_run_speed_stopped");
      break;
    case "crouch":
      break;
  }
}

dynamic_run_speed_stopped() {
  self endon("death");

  if(maps\_utility::ent_flag("dynamic_run_speed_stopped")) {
    return;
  }
  if(maps\_utility::ent_flag("dynamic_run_speed_stopping")) {
    return;
  }
  self endon("stop_dynamic_run_speed");
  maps\_utility::ent_flag_set("dynamic_run_speed_stopping");
  maps\_utility::ent_flag_set("dynamic_run_speed_stopped");
  self endon("dynamic_run_speed_stopped");
  var_0 = "DRS_run_2_stop";
  maps\_anim::anim_generic_custom_animmode(self, "gravity", var_0);
  maps\_utility::ent_flag_clear("dynamic_run_speed_stopping");

  while (maps\_utility::ent_flag("dynamic_run_speed_stopped")) {
    var_1 = "DRS_stop_idle";
    thread maps\_anim::anim_generic_loop(self, var_1);

    if(isdefined(level.scr_anim["generic"]["signal_go"]))
      maps\_utility::handsignal("go");

    wait(randomfloatrange(12, 20));

    if(maps\_utility::ent_flag_exist("_stealth_stance_handler"))
      maps\_utility::ent_flag_waitopen("_stealth_stance_handler");

    self notify("stop_loop");

    if(!maps\_utility::ent_flag("dynamic_run_speed_stopped")) {
      return;
    }
    if(isdefined(level.dynamic_run_speed_dialogue)) {
      var_2 = common_scripts\utility::random(level.dynamic_run_speed_dialogue);
      level thread maps\_utility::radio_dialogue_queue(var_2);
    }

    if(isdefined(level.scr_anim["generic"]["signal_go"]))
      maps\_utility::handsignal("go");
  }
}

g_speed_get_func() {
  return int(getdvar("g_speed"));
}

g_speed_set_func(var_0) {
  setsaveddvar("g_speed", int(var_0));
}

g_bob_scale_get_func() {
  return level.player getbobrate();
}

g_bob_scale_set_func(var_0) {
  level.player setbobrate(var_0);
}

movespeed_get_func() {
  return self.movespeedscale;
}

movespeed_set_func(var_0) {
  self.movespeedscale = var_0;
  self setmovespeedscale(var_0);
}

movespeed_ramp_over_time(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("movespeed_ramp_over_time");
  var_0 endon("movespeed_ramp_over_time");
  var_5 = var_1;
  var_6 = (var_2 - var_1) * 0.05 / var_3;

  for (var_7 = 0; var_7 < var_3; var_7 = var_7 + 0.05) {
    var_5 = var_5 + var_6;

    if(isai(var_0))
      var_0 maps\_utility::set_moveplaybackrate(var_5, undefined, var_4);
    else
      var_0 setmovespeedscale(var_5);

    waitframe();
  }

  if(isai(var_0))
    var_0 maps\_utility::set_moveplaybackrate(var_2, undefined, var_4);
  else
    var_0 setmovespeedscale(var_2);
}

autosave_tactical_setup() {
  if(common_scripts\utility::flag_exist("autosave_tactical_player_nade")) {
    return;
  }
  common_scripts\utility::flag_init("autosave_tactical_player_nade");
  level.autosave_tactical_player_nades = 0;
  notifyoncommand("autosave_player_nade", "+frag");
  notifyoncommand("autosave_player_nade", "-smoke");
  notifyoncommand("autosave_player_nade", "+smoke");
  common_scripts\utility::array_thread(level.players, ::autosave_tactical_grenade_check);
}

autosave_tactical_grenade_check() {
  for (;;) {
    self waittill("autosave_player_nade");
    common_scripts\utility::flag_set("autosave_tactical_player_nade");
    self waittill("grenade_fire", var_0);
    thread autosave_tactical_grenade_check_dieout(var_0);
  }
}

autosave_tactical_grenade_check_dieout(var_0) {
  level.autosave_tactical_player_nades++;
  var_0 common_scripts\utility::waittill_notify_or_timeout("death", 10);
  level.autosave_tactical_player_nades--;
  waittillframeend;

  if(!level.autosave_tactical_player_nades)
    common_scripts\utility::flag_clear("autosave_tactical_player_nade");
}

autosave_tactical_proc() {
  level notify("autosave_tactical_proc");
  level endon("autosave_tactical_proc");
  level thread maps\_utility::notify_delay("kill_save", 5);
  level endon("kill_save");
  level endon("autosave_tactical_player_nade");

  if(common_scripts\utility::flag("autosave_tactical_player_nade")) {
    common_scripts\utility::flag_waitopen_or_timeout("autosave_tactical_player_nade", 4);

    if(common_scripts\utility::flag("autosave_tactical_player_nade"))
      return;
  }

  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isdefined(var_2.enemy) && isplayer(var_2.enemy))
      return;
  }

  waittillframeend;
  maps\_utility::autosave_by_name();
}

music_play_internal_stop_with_fade_then_call(var_0, var_1, var_2, var_3) {
  maps\_utility::music_stop(var_1);
  level endon("stop_music");
  wait(var_1);
  thread maps\_utility::music_play(var_0, undefined, var_2, var_3);
}

music_loop_internal_stop_with_fade_then_call(var_0, var_1, var_2, var_3, var_4, var_5) {
  maps\_utility::music_stop(var_2);
  level endon("stop_music");
  wait(var_2);
  thread music_loop_internal(var_0, var_1, undefined, var_3, var_4, var_5);
}

music_loop_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isdefined(var_2) && var_2 > 0) {
    thread music_loop_internal_stop_with_fade_then_call(var_0, var_1, var_2, var_3, var_4, var_5);
    return;
  }

  maps\_utility::music_stop();
  level endon("stop_music");
  maps\_utility::musicplaywrapper(var_0, var_3, var_4);

  if(isdefined(var_5) && var_5 == 1 && common_scripts\utility::flag_exist("_stealth_spotted")) {
    level endon("_stealth_spotted");
    thread music_loop_stealth_pause(var_0, var_1, var_2);
  }

  var_6 = maps\_utility::musiclength(var_0);

  if(!isdefined(var_1))
    var_1 = 1;

  if(var_1 <= 10)
    var_6 = var_6 + var_1;

  wait(var_6);
  maps\_utility::music_loop(var_0, var_1, var_2, var_3, var_4);
}

music_loop_stealth_pause(var_0, var_1, var_2) {
  level endon("stop_music");
  common_scripts\utility::flag_wait("_stealth_spotted");
  musicstop(0.5);

  while (common_scripts\utility::flag("_stealth_spotted")) {
    common_scripts\utility::flag_waitopen("_stealth_spotted");
    wait 1;
  }

  thread maps\_utility::music_loop(var_0, var_1, var_2);
}

doslide(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_sliding");
  var_3 = self;
  var_4 = undefined;

  for (;;) {
    var_5 = var_3 getnormalizedmovement();
    var_6 = anglestoforward(var_3.angles);
    var_7 = anglestoright(var_3.angles);
    var_5 = (var_5[1] * var_7[0] + var_5[0] * var_6[0], var_5[1] * var_7[1] + var_5[0] * var_6[1], 0);
    var_0.slidevelocity = var_0.slidevelocity + var_5 * var_1;
    wait 0.05;
    var_0.slidevelocity = var_0.slidevelocity * (1 - var_2);
  }
}

kill_deathflag_proc(var_0, var_1) {
  self endon("death");

  if(isdefined(var_0))
    wait(randomfloat(var_0));

  if(isdefined(var_1) && var_1 && maps\_utility::player_can_see_ai(self)) {
    return;
  }
  playfxontag(common_scripts\utility::getfx("flesh_hit"), self, "tag_eye");
  self kill(level.player.origin);
}

update_rumble_intensity(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  for (;;) {
    if(self.intensity > 0.0001 && gettime() > 300) {
      if(!var_2) {
        self playrumblelooponentity(var_1);
        var_2 = 1;
      }
    } else if(var_2) {
      self stoprumble(var_1);
      var_2 = 0;
    }

    var_3 = 1 - self.intensity;
    var_3 = var_3 * 1000;

    if(isdefined(self.rumble_base_entity))
      self.origin = self.rumble_base_entity.origin + (0, 0, var_3);
    else
      self.origin = var_0 geteye() + (0, 0, var_3);

    wait 0.05;
  }
}

start_glow(var_0) {
  var_1 = spawn("script_model", self.origin);
  self.glow_model = var_1;
  var_1.angles = self.angles;
  var_1 setmodel(var_0);
  var_1 endon("death");
  self waittill("death");
  var_1 delete();
}

process_blend(var_0, var_1, var_2, var_3, var_4) {
  waittillframeend;

  if(!isdefined(self.start))
    self.start = 0;

  if(!isdefined(self.end))
    self.end = 1;

  if(!isdefined(self.base))
    self.base = 0;

  var_5 = self.time * 20;
  var_6 = self.end - self.start;
  self.stop_blend = 0;

  if(isdefined(var_4)) {
    for (var_7 = 0; var_7 <= var_5 && !self.stop_blend; var_7++) {
      var_8 = self.base + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2, var_3, var_4);
      wait 0.05;
    }
  } else if(isdefined(var_3)) {
    for (var_7 = 0; var_7 <= var_5 && !self.stop_blend; var_7++) {
      var_8 = self.base + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2, var_3);
      wait 0.05;
    }
  } else if(isdefined(var_2)) {
    for (var_7 = 0; var_7 <= var_5 && !self.stop_blend; var_7++) {
      var_8 = self.base + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2);
      wait 0.05;
    }
  } else {
    for (var_7 = 0; var_7 <= var_5 && !self.stop_blend; var_7++) {
      var_8 = self.base + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8);
      wait 0.05;
    }
  }
}

add_trace_fx_proc(var_0) {
  waittillframeend;

  if(!isdefined(level.trace_fx))
    level.trace_fx = [];

  if(!isdefined(level.trace_fx))
    level.trace_fx[var_0] = [];

  if(isdefined(self.fx))
    level.trace_fx[var_0][self.surface]["fx"] = self.fx;

  if(isdefined(self.fx_array))
    level.trace_fx[var_0][self.surface]["fx_array"] = self.fx_array;

  if(isdefined(self.sound))
    level.trace_fx[var_0][self.surface]["sound"] = self.sound;

  if(isdefined(self.rumble))
    level.trace_fx[var_0][self.surface]["rumble"] = self.rumble;

  if(!isdefined(level.trace_fx[var_0]["default"]))
    level.trace_fx[var_0]["default"] = level.trace_fx[var_0][self.surface];
}

put_toy_in_volume(var_0) {
  var_1 = spawnstruct();
  precachemodel(var_0.model);
  var_1.toy_model = var_0.model;
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.script_noteworthy = var_0.script_noteworthy;
  var_1.script_linkto = var_0.script_linkto;
  var_1.targetname = var_0.targetname;
  var_1.target = var_0.target;
  var_1.destructible_type = var_0.destructible_type;
  var_1.script_noflip = var_0.script_noflip;
  var_0 maps\_utility::precache_destructible(var_0.destructible_type);
  self.destructibles[self.destructibles.size] = var_1;
  var_0 notify("masking_destructible");
  var_0 delete();
}

delaythread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  wait(var_1);

  if(isdefined(var_7))
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isdefined(var_6))
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isdefined(var_5))
    thread[[var_0]](var_2, var_3, var_4, var_5);
  else if(isdefined(var_4))
    thread[[var_0]](var_2, var_3, var_4);
  else if(isdefined(var_3))
    thread[[var_0]](var_2, var_3);
  else if(isdefined(var_2))
    thread[[var_0]](var_2);
  else
    thread[[var_0]]();
}

delaychildthread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  wait(var_1);

  if(isdefined(var_7))
    childthread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isdefined(var_6))
    childthread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isdefined(var_5))
    childthread[[var_0]](var_2, var_3, var_4, var_5);
  else if(isdefined(var_4))
    childthread[[var_0]](var_2, var_3, var_4);
  else if(isdefined(var_3))
    childthread[[var_0]](var_2, var_3);
  else if(isdefined(var_2))
    childthread[[var_0]](var_2);
  else
    childthread[[var_0]]();
}

flagwaitthread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon(maps\_utility::string(var_1[0] + "_stop_flagWaitThread"));
  common_scripts\utility::flag_wait(var_1[0]);
  delaythread_proc(var_0, var_1[1], var_2, var_3, var_4, var_5, var_6, var_7);
}

waittillthread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon(maps\_utility::string(var_1[0] + "_stop_waittillThread"));
  self waittill(var_1[0]);
  delaythread_proc(var_0, var_1[1], var_2, var_3, var_4, var_5, var_6, var_7);
}

add_wait_asserter() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for (var_0 = 0; var_0 < 20; var_0++)
    waittillframeend;
}

update_battlechatter_hud() {}

comparesizesfx(var_0, var_1, var_2, var_3) {
  if(!var_1.size)
    return undefined;

  if(isdefined(var_2)) {
    var_4 = undefined;
    var_5 = getarraykeys(var_1);

    for (var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = distance(var_1[var_5[var_6]].v["origin"], var_0);

      if([
          [var_3]
        ](var_7, var_2)) {
        continue;
      }
      var_2 = var_7;
      var_4 = var_1[var_5[var_6]];
    }

    return var_4;
  }

  var_5 = getarraykeys(var_1);
  var_4 = var_1[var_5[0]];
  var_2 = distance(var_4.v["origin"], var_0);

  for (var_6 = 1; var_6 < var_5.size; var_6++) {
    var_7 = distance(var_1[var_5[var_6]].v["origin"], var_0);

    if([
        [var_3]
      ](var_7, var_2)) {
      continue;
    }
    var_2 = var_7;
    var_4 = var_1[var_5[var_6]];
  }

  return var_4;
}

waittill_triggered_current() {
  for (;;) {
    self waittill("trigger", var_0);
    waittillframeend;

    if(var_0.currentnode == self)
      return var_0;
  }
}

add_trigger_func_thread() {
  self.trigger_functions = [];
  self waittill("trigger", var_0);
  var_1 = self.trigger_functions;
  self.trigger_functions = undefined;

  foreach(var_3 in var_1)
  thread[[var_3]](var_0);
}

add_to_radio(var_0) {
  if(!isdefined(level.scr_radio[var_0]))
    level.scr_radio[var_0] = var_0;
}

add_to_dialogue(var_0) {
  if(!isdefined(level.scr_anim[self.animname]))
    level.scr_anim[self.animname] = [];

  if(!isdefined(level.scr_sound[self.animname]))
    level.scr_sound[self.animname] = [];

  if(!isdefined(level.scr_sound[self.animname][var_0]))
    level.scr_sound[self.animname][var_0] = var_0;
}

add_to_dialogue_generic(var_0) {
  if(!isdefined(level.scr_sound["generic"]))
    level.scr_sound["generic"] = [];

  if(!isdefined(level.scr_sound["generic"][var_0]))
    level.scr_sound["generic"][var_0] = var_0;
}

objective_recon(var_0) {
  if(!maps\_utility::is_default_start()) {
    return;
  }
  var_1 = get_leveltime();
  var_2 = var_1;

  if(isdefined(level.recon_objective_lasttime))
    var_2 = var_1 - level.recon_objective_lasttime;

  level.recon_objective_lasttime = var_1;
  reconevent("script_objective: objective %d, leveltime %d, deltatime %d", var_0, var_1, var_2);
}

mission_recon(var_0) {
  if(maps\_utility::is_default_start()) {
    if(!isdefined(var_0))
      var_0 = 1;

    var_1 = get_leveltime();
    var_2 = var_1;
    reconevent("script_level: leveltime %d, deltatime %d, success %d", var_2, var_1, var_0);
  }
}

get_leveltime() {
  return getlevelticks() * 0.05;
}

_flag_wait_trigger(var_0, var_1) {
  self endon("death");

  for (;;) {
    self waittill("trigger", var_2);
    common_scripts\utility::flag_set(var_0);

    if(!var_1) {
      return;
    }
    while (var_2 istouching(self))
      wait 0.05;

    common_scripts\utility::flag_clear(var_0);
  }
}

ai_save_ignore_setting(var_0, var_1, var_2) {
  if(isdefined(var_0))
    self._ignore_settings_old[var_1] = var_0;
  else
    self._ignore_settings_old[var_1] = "none";

  return var_2;
}

ai_restore_ignore_setting(var_0, var_1) {
  if(isdefined(self._ignore_settings_old)) {
    if(isstring(self._ignore_settings_old[var_0]) && self._ignore_settings_old[var_0] == "none")
      return var_1;
    else
      return self._ignore_settings_old[var_0];
  }

  return var_1;
}

_tff_sync_triggers() {
  var_0 = getentarray("tff_sync_trigger", "targetname");

  if(!isdefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0)
  var_2 thread _tff_sync_trigger_think();
}

_tff_sync_trigger_think() {
  self waittill("trigger");
  maps\_utility::tff_sync();
}