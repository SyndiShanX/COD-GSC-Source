/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\sp\utility_code.gsc
***********************************************/

function structarray_swap(var_0, var_1) {
  var_2 = var_0.struct_array_index;
  var_3 = var_1.struct_array_index;
  self.array[var_3] = var_0;
  self.array[var_2] = var_1;
  self.array[var_2].struct_array_index = var_2;
  self.array[var_3].struct_array_index = var_3;
}

function wait_until_done_speaking() {
  self endon("death");
  self endon("removed from battleChatter");

  while(self.battlechatter.isspeaking) {
    wait 0.05;
  }
}

function wait_for_trigger_think(var_0) {
  self endon("death");
  var_0 endon("trigger");
  self waittill("trigger");
  var_0 notify("trigger");
}

function wait_for_trigger(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = spawnStruct();
  scripts\engine\utility::array_thread(var_2, &wait_for_trigger_think, var_3);
  var_3 waittill("trigger");
}

function ent_waits_for_trigger(var_0) {
  self endon("done");
  var_0 waittill("trigger");
  self notify("done");
}

function update_debug_friendlycolor_on_death() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  var_0 = self.unique_id;
  self waittill("death");
  level.debug_color_friendlies[var_0] = undefined;
  level notify("updated_color_friendlies");
}

function update_debug_friendlycolor(var_0) {
  thread update_debug_friendlycolor_on_death();

  if(isDefined(self.script_forcecolor)) {
    level.debug_color_friendlies[var_0] = self.script_forcecolor;
  } else {
    level.debug_color_friendlies[var_0] = undefined;
  }

  level notify("updated_color_friendlies");
}

function insure_player_does_not_set_forcecolor_twice_in_one_frame() {}

function new_color_being_set(var_0) {
  self notify("new_color_being_set");
  self.new_force_color_being_set = 1;
  scripts\sp\colors::left_color_node();
  self endon("new_color_being_set");
  self endon("death");
  waittillframeend();
  waittillframeend();

  if(isDefined(self.script_forcecolor)) {
    self.currentcolorcode = level.currentcolorforced[scripts\sp\colors::get_team()][self.script_forcecolor];

    if(isDefined(self.dontcolormove)) {
      self.dontcolormove = undefined;
    } else {
      thread scripts\sp\colors::goto_current_colorindex();
    }
  }

  self.new_force_color_being_set = undefined;
  self notify("done_setting_new_color");
}

function waittill_either_function_internal(var_0, var_1, var_2) {
  var_0 endon("done");
  [[var_1]](var_2);
  var_0 notify("done");
}

function hintprintbreakout(var_0, var_1) {
  self endon("hint_print_timeout");
  self endon("hint_print_remove");
  var_1 endon("new_hint");

  for(;;) {
    self.fadeout = 1;

    if(isDefined(level.hint_breakfunc) && [[level.hint_breakfunc]]() || var_1.current_global_hint != var_0) {
      break;
    }

    wait 0.05;
  }
}

function hint_timeout(var_0) {
  wait var_0;
  self.fadeout = 1;
  self notify("hint_print_timeout");
}

function destroy_hint_on_endon(var_0, var_1) {
  self endon("removing_hint");

  if(isarray(var_0) || isarray(var_1)) {
    destroy_hint_on_endon_proc(var_0, var_1);
  } else {
    var_0[0] waittill(var_1[0]);
  }

  self.fadeout = 1;
  self notify("hint_print_remove");
}

function destroy_hint_on_endon_proc(var_0, var_1) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_3 in var_0) {
    foreach(var_5 in var_1) {
      var_3 endon(var_5);
    }
  }

  level waittill("forever");
}

function hint_stick_get_updated(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return var_0 + _hint_stick_get_config_suffix(var_1, var_2, var_3, var_4, var_5, var_6);
}

function _hint_stick_get_config_suffix(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getsticksconfig();

  if(level.player scripts\engine\utility::is_player_gamepad_enabled()) {
    if(level.player isps4player()) {
      if(issubstr(var_6, "southpaw") || var_5 && issubstr(var_6, "legacy")) {
        return var_4;
      }

      return var_3;
    }

    if(issubstr(var_6, "southpaw") || var_5 && issubstr(var_6, "legacy")) {
      return var_2;
    }

    return var_1;
  }

  return var_0;
}

function _hint_stick_update_breakfunc(var_0, var_1) {
  var_2 = var_1 + var_0;
  var_3 = level.trigger_hint_func[var_2];
  level.hint_breakfunc = var_3;
}

function _hint_stick_update_string(var_0, var_1) {
  var_2 = var_1 + var_0;
  var_3 = level.trigger_hint_string[var_2];
  var_4 = scripts\engine\sp\utility::get_player_from_self();
  var_4 sethudtutorialmessage(var_3);
}

function hint_stick_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level notify("hint_change_config");
  level endon("hint_change_config");
  var_7 = _hint_stick_get_config_suffix(var_1, var_2, var_3, var_4, var_5, var_6);

  while(isDefined(level.current_hint_active) && level.current_hint_active) {
    var_8 = _hint_stick_get_config_suffix(var_1, var_2, var_3, var_4, var_5, var_6);

    if(var_8 != var_7) {
      var_7 = var_8;
      _hint_stick_update_breakfunc(var_7, var_0);
      _hint_stick_update_string(var_7, var_0);
    }

    waitframe();
  }
}

function hintprint(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("new_hint");

  if(getdvarint("scr_disable_hints") > 0) {
    return;
  }

  var_6 = gettime();

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isalive(self)) {
    return;
  }

  scripts\engine\utility::ent_flag_waitopen("global_hint_in_use");

  if(isDefined(self.current_global_hint)) {
    if(self.current_global_hint == var_0) {
      return;
    } else {
      self.current_global_hint = var_0;
      scripts\engine\utility::ent_flag_set("global_hint_in_use");
      wait 0.05;
    }
  }

  self.current_global_hint = var_0;
  scripts\engine\utility::ent_flag_set("global_hint_in_use");
  level.current_hint_active = 1;
  level.hint_breakfunc = var_1;
  level endon("friendlyfire_mission_fail");
  self sethudtutorialmessage(var_0);
  var_7 = spawnStruct();
  var_7.fadeout = 0;

  if(isDefined(var_2)) {
    thread hint_timeout(var_7);
  }

  thread destroy_hint_on_friendlyfire();
  thread destroy_hint_on_player_death();

  if(isDefined(var_4) && isDefined(var_5)) {
    thread destroy_hint_on_endon(var_7, var_4);
  }

  hintprintbreakout(var_7, var_0, self);

  if(!istrue(var_7.fadeout)) {
    self clearhudtutorialmessage(1);
  }

  scripts\engine\sp\utility::wait_for_buffer_time_to_pass(var_6, var_3);
  var_7 notify("removing_hint");
  self.current_global_hint = undefined;

  if(var_7.fadeout) {
    self clearhudtutorialmessage();
  }

  level.current_hint_active = 0;
  scripts\engine\utility::ent_flag_clear("global_hint_in_use");
}

function destroy_hint_on_friendlyfire(var_0) {
  self endon("removing_hint");
  level waittill("friendlyfire_mission_fail");
  self.fadeout = 1;
  self notify("hint_print_remove");
}

function destroy_hint_on_player_death(var_0) {
  self endon("removing_hint");
  level.player waittill("death");
  self.fadeout = 1;
  self notify("hint_print_remove");
}

function function_stack_wait(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_either("function_done", "death");
}

function function_stack_wait_finish(var_0) {
  function_stack_wait(var_0);

  if(!isDefined(self)) {
    return false;
  }

  if(!issentient(self)) {
    return true;
  }

  if(isalive(self)) {
    return true;
  }

  return false;
}

function function_stack_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isDefined(var_0.function_stack)) {
    var_0.function_stack = [];
  }

  var_0.function_stack[var_0.function_stack.size] = self;
  thread function_stack_self_death(var_0);
  function_stack_caller_waits_for_turn(var_0);

  if(isDefined(var_0) && isDefined(var_0.function_stack)) {
    self.function_stack_func_begun = 1;
    self notify("function_stack_func_begun");

    if(isDefined(var_6)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5, var_6);
    } else if(isDefined(var_5)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5);
    } else if(isDefined(var_4)) {
      var_0[[var_1]](var_2, var_3, var_4);
    } else if(isDefined(var_3)) {
      var_0[[var_1]](var_2, var_3);
    } else if(isDefined(var_2)) {
      var_0[[var_1]](var_2);
    } else {
      var_0[[var_1]]();
    }

    if(isDefined(var_0) && isDefined(var_0.function_stack)) {
      var_0.function_stack = scripts\engine\utility::array_remove(var_0.function_stack, self);
      var_0 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self.function_stack_func_begun = 0;
    self notify("function_done");
    return;
  }
}

function function_stack_self_death(var_0) {
  self endon("function_done");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0.function_stack = scripts\engine\utility::array_remove(var_0.function_stack, self);
    var_0 notify("level_function_stack_ready");
    return;
  }
}

function function_stack_caller_waits_for_turn(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("clear_function_stack");

  while(var_0.function_stack[0] != self) {
    var_0 waittill("level_function_stack_ready");
  }
}

function array_waitlogic1(var_0, var_1, var_2) {
  array_waitlogic2(var_0, var_1, var_2);
  self._array_wait = 0;
  self notify("_array_wait");
}

function array_waitlogic2(var_0, var_1, var_2) {
  var_0 endon(var_1);
  var_0 endon("death");

  if(isDefined(var_2)) {
    wait var_2;
    return;
  }

  var_0 waittill(var_1);
}

function exec_call(var_0) {
  if(var_0.parms.size == 0) {
    var_0.caller builtin[[var_0.func]]();
  } else if(var_0.parms.size == 1) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0]);
  } else if(var_0.parms.size == 2) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  } else if(var_0.parms.size == 3) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);
  }

  if(var_0.parms.size == 4) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);
  }

  if(var_0.parms.size == 5) {
    var_0.caller builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
    return;
  }
}

function exec_call_noself(var_0) {
  if(var_0.parms.size == 0) {
    builtin[[var_0.func]]();
  } else if(var_0.parms.size == 1) {
    builtin[[var_0.func]](var_0.parms[0]);
  } else if(var_0.parms.size == 2) {
    builtin[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  } else if(var_0.parms.size == 3) {
    builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);
  }

  if(var_0.parms.size == 4) {
    builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);
  }

  if(var_0.parms.size == 5) {
    builtin[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
    return;
  }
}

function exec_func(var_0, var_1) {
  if(!isDefined(var_0.caller)) {
    return;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2].caller endon(var_1[var_2].ender);
  }

  if(var_0.parms.size == 0) {
    var_0.caller[[var_0.func]]();
  } else if(var_0.parms.size == 1) {
    var_0.caller[[var_0.func]](var_0.parms[0]);
  } else if(var_0.parms.size == 2) {
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1]);
  } else if(var_0.parms.size == 3) {
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2]);
  }

  if(var_0.parms.size == 4) {
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3]);
  }

  if(var_0.parms.size == 5) {
    var_0.caller[[var_0.func]](var_0.parms[0], var_0.parms[1], var_0.parms[2], var_0.parms[3], var_0.parms[4]);
    return;
  }
}

function waittill_func_ends(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var_0, var_1);
  self.count--;
  self notify("func_ended");
}

function waittill_abort_func_ends(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var_0, var_1);
  self.abort_count--;
  self notify("abort_func_ended");
}

function do_abort(var_0) {
  self endon("all_funcs_ended");

  if(!var_0.size) {
    return;
  }

  var_1 = 0;
  self.abort_count = var_0.size;
  var_2 = [];
  scripts\engine\utility::array_levelthread(var_0, &waittill_abort_func_ends, var_2);

  for(;;) {
    if(self.abort_count <= var_1) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

function translate_local_on_ent(var_0) {
  if(isDefined(self.forward)) {
    var_1 = anglesToForward(var_0.angles);
    var_0.origin += var_1 * self.forward;
  }

  if(isDefined(self.right)) {
    var_2 = anglestoright(var_0.angles);
    var_0.origin += var_2 * self.right;
  }

  if(isDefined(self.up)) {
    var_3 = anglestoup(var_0.angles);
    var_0.origin += var_3 * self.up;
  }

  if(isDefined(self.yaw)) {
    var_0 addyaw(self.yaw);
  }

  if(isDefined(self.pitch)) {
    var_0 addpitch(self.pitch);
  }

  if(isDefined(self.roll)) {
    var_0 addroll(self.roll);
    return;
  }
}

function dynamic_run_speed_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("stop_dynamic_run_speed");
  var_7 = 1;
  var_8 = anglesToForward(self.angles);

  for(;;) {
    var_9 = dynamic_run_speed_goalpos();

    if(distancesquared(var_9, self.origin) > 0) {
      var_10 = scripts\engine\utility::flat_origin(var_9);
      var_11 = scripts\engine\utility::flat_origin(self.origin);

      if(distancesquared(var_10, var_11) > 100) {
        var_8 = vectorNormalize(var_10 - var_11);
      }

      var_12 = self.origin + var_8 * var_5;
      var_13 = vectorNormalize(var_0.origin - var_12);
      var_14 = vectordot(var_13, var_8);

      if(var_14 > 0) {
        dynamic_run_speed_set(var_0, var_4, var_5, var_8, var_3, var_2, 0);
      } else {
        dynamic_run_speed_set(var_0, var_5, var_6, var_8, var_2, var_1, 1);
      }
    }

    waitframe();
  }
}

function dynamic_run_speed_set(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = vectortoangles(var_3);
  var_8 = anglestoright(var_7);
  var_9 = self.origin + var_3 * var_1;
  var_10 = self.origin + var_3 * var_2;
  var_11 = pointonsegmentnearesttopoint(var_9, var_10, var_0.origin);
  var_12 = distance(var_9, var_11);
  var_13 = var_1 - var_2;
  var_14 = 1 - scripts\engine\math::lerp_fraction(0, abs(var_13), var_12);
  var_15 = scripts\engine\math::lerp(var_5, var_4, var_14);
  var_15 = clamp(var_15, 23, 250);
  scripts\engine\utility::set_movement_speed(var_15);
}

function dynamic_run_speed_goalpos() {
  var_0 = undefined;

  if(isDefined(self.follow_ent)) {
    var_0 = self.follow_ent.origin;
  } else if(isDefined(self.goalnode)) {
    var_0 = self.goalnode.origin;
  } else {
    var_0 = self.scriptgoalpos;
  }

  return var_0;
}

function handsignal(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_1)) {
    var_4 = !var_1;
  }

  if(isDefined(var_2)) {
    level endon(var_2);
  }

  if(isDefined(var_3)) {
    level waittill(var_3);
  }

  var_5 = "signal_" + var_0;

  if(self.currentpose == "crouch") {
    var_5 += "_crouch";
  } else if(self.script == "cover_right") {
    var_5 += "_coverR";
  } else if(scripts\anim\utility::iscqbwalking()) {
    var_5 += "_cqb";
  }

  if(var_4) {
    self setanimrestart(scripts\engine\sp\utility::getgenericanim(var_5), 1, 0, 1.1);
    return;
  }

  scripts\common\anim::anim_generic(self, var_5);
}

function g_speed_get_func(var_0) {
  return int(getDvar("NSRPQNLSNK"));
}

function g_speed_set_func(var_0, var_1) {
  setsaveddvar("NSRPQNLSNK", int(var_0));
}

function g_bob_scale_get_func(var_0) {
  return level.player getbobrate();
}

function g_bob_scale_set_func(var_0, var_1) {
  level.player setbobrate(var_0);
}

function movespeed_get_func(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[var_0])) {
    return 1;
  }

  return self.movespeedscales[var_0];
}

function movespeed_set_func(var_0, var_1) {
  var_2 = 1;

  if(!isDefined(var_1)) {
    var_1 = "default";
  }

  self.movespeedscales[var_1] = var_0;

  foreach(var_0 in self.movespeedscales) {
    if(var_0 == 1) {
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, var_4);
    }

    var_2 *= var_0;
  }

  self.movespeedscale = var_2;
  self setmovespeedscale(self.movespeedscale);
}

function autosave_tactical_setup() {
  if(scripts\engine\utility::flag_exist("autosave_tactical_player_nade")) {
    return;
  }

  scripts\engine\utility::flag_init("autosave_tactical_player_nade");
  level.autosave_tactical_player_nades = 0;
  notifyoncommand("autosave_player_nade", "+frag");
  notifyoncommand("autosave_player_nade", "-smoke");
  notifyoncommand("autosave_player_nade", "+smoke");
  scripts\engine\utility::array_thread(level.players, &autosave_tactical_grenade_check);
}

function autosave_tactical_grenade_check() {
  for(;;) {
    self waittill("autosave_player_nade");
    scripts\engine\utility::flag_set("autosave_tactical_player_nade");
    thread autosave_tactical_grenade_check_wait_throw();
    scripts\engine\utility::waittill_any_timeout(10, "autosave_grenade_thrown");
    self notify("autosave_grenade_throw_timeout");
    autosave_tactical_nade_flag_clear();
  }
}

function autosave_tactical_grenade_check_wait_throw() {
  self endon("autosave_grenade_throw_timeout");
  self waittill("grenade_fire", var_0);
  thread autosave_tactical_grenade_check_dieout(var_0);
  self notify("autosave_grenade_thrown");
}

function autosave_tactical_nade_flag_clear() {
  waittillframeend();

  if(!level.autosave_tactical_player_nades) {
    scripts\engine\utility::flag_clear("autosave_tactical_player_nade");
    return;
  }
}

function autosave_tactical_grenade_check_dieout(var_0) {
  level.autosave_tactical_player_nades++;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
  level.autosave_tactical_player_nades--;
  autosave_tactical_nade_flag_clear();
}

function autosave_tactical_proc() {
  level notify("autosave_tactical_proc");
  level endon("autosave_tactical_proc");
  level thread scripts\engine\sp\utility::notify_delay("kill_save", 5);
  level endon("kill_save");
  level endon("autosave_tactical_player_nade");

  if(scripts\engine\utility::flag("autosave_tactical_player_nade")) {
    scripts\engine\utility::flag_waitopen_or_timeout("autosave_tactical_player_nade", 4);

    if(scripts\engine\utility::flag("autosave_tactical_player_nade")) {
      return;
    }
  }

  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.enemy) && isPlayer(var_2.enemy)) {
      return;
    }
  }

  waittillframeend();
  scripts\engine\sp\utility::autosave_by_name();
}

function doslide(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_sliding");
  var_3 = self;
  var_4 = undefined;
  var_5 = var_0.origin;
  var_6 = var_0.origin;
  var_7 = undefined;

  for(;;) {
    var_8 = var_3 getnormalizedmovement();
    var_9 = anglesToForward(var_3.angles);
    var_10 = anglestoright(var_3.angles);
    var_8 = (var_8[1] * var_10[0] + var_8[0] * var_9[0], var_8[1] * var_10[1] + var_8[0] * var_9[1], 0);
    var_0.slidevelocity += var_8 * var_1;
    var_3.fx_tag.origin = var_0.origin + anglesToForward(var_0.gesture_target.angles) * 400;
    wait 0.05;
    var_0.slidevelocity *= 1 - var_2;
  }
}

function kill_deathflag_proc(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    wait randomfloat(var_0);
  }

  playFXOnTag(scripts\engine\utility::getfx("flesh_hit"), self, "tag_eye");
  self kill(level.player.origin);
}

function update_rumble_intensity(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  for(;;) {
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
    var_3 *= 1000;
    self.origin = var_0 getEye() + (0, 0, var_3);
    wait 0.05;
  }
}

function process_blend(var_0, var_1, var_2, var_3, var_4) {
  waittillframeend();

  if(!isDefined(self.start)) {
    self.start = 0;
  }

  if(!isDefined(self.end)) {
    self.end = 1;
  }

  if(!isDefined(self.base)) {
    self.base = 0;
  }

  var_5 = self.time * 20;
  var_6 = self.end - self.start;
  self.stop_blend = 0;

  if(isDefined(var_4)) {
    for(var_7 = 0; var_7 <= var_5 && !self.stop_blend; var_7++) {
      var_8 = self.base + var_7 * var_6 / var_5;
      var_1 thread[[var_0]](var_8, var_2, var_3, var_4);
      wait 0.05;
    }

    return;
  }

  if(isDefined(var_5)) {
    for(var_7 = 0; var_7 <= var_7 && !self.stop_blend; var_7++) {
      var_8 = self.base + var_7 * var_8 / var_7;
      var_3 thread[[var_2]](var_8, var_4, var_5);
      wait 0.05;
    }

    return;
  }

  if(isDefined(var_6)) {
    for(var_7 = 0; var_7 <= var_7 && !self.stop_blend; var_7++) {
      var_8 = self.base + var_7 * var_8 / var_7;
      var_5 thread[[var_4]](var_8, var_6);
      wait 0.05;
    }

    return;
  }

  for(var_7 = 0; var_7 <= var_7 && !self.stop_blend; var_7++) {
    var_8 = self.base + var_7 * var_8 / var_7;
    var_7 thread[[var_6]](var_8);
    wait 0.05;
  }
}

function get_color_info_from_trigger() {
  var_0 = "allies";

  if(isDefined(self.script_color_axis)) {
    var_0 = "axis";
  }

  var_0 = scripts\sp\colors::get_team(var_0);
  var_1 = [];

  if(var_0 == "allies") {
    var_2 = scripts\sp\colors::get_colorcodes_from_trigger(self.script_color_allies, "allies");
    var_1 = var_2["colorCodes"];
  } else {
    var_2 = scripts\sp\colors::get_colorcodes_from_trigger(self.script_color_axis, "axis");
    var_2 = var_2["colorCodes"];
  }

  var_3 = [];
  GscBinSkip0(0x2e, "team", var_1);
}

function delaychildthread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  wait var_1;

  if(isDefined(var_7)) {
    childthread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
    return;
  }

  if(isDefined(var_6)) {
    childthread[[var_0]](var_2, var_3, var_4, var_5, var_6);
    return;
  }

  if(isDefined(var_5)) {
    childthread[[var_0]](var_2, var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    childthread[[var_0]](var_2, var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    childthread[[var_0]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    childthread[[var_0]](var_2);
    return;
  }

  childthread[[var_0]]();
}

function flagwaitthread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  scripts\engine\utility::flag_wait(var_1[0]);
  scripts\engine\utility::delaythread_proc(var_0, var_1[1], var_2, var_3, var_4, var_5, var_6);
}

function waittillthread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self waittill(var_1[0]);
  scripts\engine\utility::delaythread_proc(var_0, var_1[1], var_2, var_3, var_4, var_5, var_6);
}

function add_wait_asserter() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for(var_0 = 0; var_0 < 20; var_0++) {
    waittillframeend();
  }
}

function update_battlechatter_hud() {}

function comparesizesfx(var_0, var_1, var_2, var_3) {
  if(!var_1.size) {
    return undefined;
  }

  if(isDefined(var_2)) {
    var_4 = undefined;
    var_5 = getarraykeys(var_1);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = distance(var_1[var_5[var_6]].v["origin"], var_0);

      if([[var_3]](var_7, var_2)) {
        continue;
      }

      var_2 = var_7;
      var_4 = var_1[var_5[var_6]];
    }

    return var_4;
  }

  var_5 = getarraykeys(var_5);
  var_4 = var_5[var_5[0]];
  var_6 = distance(var_4.v["origin"], var_4);

  for(var_6 = 1; var_6 < var_5.size; var_6++) {
    var_7 = distance(var_5[var_5[var_6]].v["origin"], var_4);

    if([[var_7]](var_7, var_6)) {
      continue;
    }

    var_6 = var_7;
    var_4 = var_5[var_5[var_6]];
  }

  return var_4;
}

function waittill_triggered_current() {
  for(;;) {
    self waittill("trigger", var_0);
    waittillframeend();

    if(var_0.currentnode == self) {
      return var_0;
    }
  }
}

function add_trigger_func_thread() {
  self.trigger_functions = [];
  self waittill("trigger", var_0);
  var_1 = self.trigger_functions;
  self.trigger_functions = undefined;
  var_2 = var_1;
  var_4 = getfirstarraykey(var_2);

  if(isDefined(var_4)) {
    var_3 = var_2[var_4];
    GscBinSkip1(0x74, var_3, var_0);
  }

  var_2 = undefined;
  var_4 = undefined;
}

function add_to_radio(var_0) {
  if(!isDefined(level.scr_radio[var_0])) {
    level.scr_radio[var_0] = var_0;
    return;
  }
}

function add_to_player_dialogue(var_0) {
  if(!isDefined(level.scr_plrdialogue[var_0])) {
    level.scr_plrdialogue[var_0] = var_0;
    return;
  }
}

function add_to_dialogue(var_0) {
  if(!isDefined(level.scr_anim[self.animname])) {
    level.scr_anim[self.animname] = [];
  }

  if(!isDefined(level.scr_sound[self.animname])) {
    level.scr_sound[self.animname] = [];
  }

  if(!isDefined(level.scr_sound[self.animname][var_0])) {
    level.scr_sound[self.animname][var_0] = var_0;
    return;
  }
}

function add_to_dialogue_generic(var_0) {
  if(!isDefined(level.scr_sound["generic"])) {
    level.scr_sound["generic"] = [];
  }

  if(!isDefined(level.scr_sound["generic"][var_0])) {
    level.scr_sound["generic"][var_0] = var_0;
    return;
  }
}

function _flag_wait_trigger(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);
    scripts\engine\utility::flag_set(var_0);

    if(!var_1) {
      return;
    }

    while(var_2 istouching(self)) {
      wait 0.05;
    }

    scripts\engine\utility::flag_clear(var_0);
  }
}

function fx_volume_pause(var_0, var_1) {
  var_0.fx_paused = 1;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    array_thread_mod_delayed(var_0.fx, &scripts\engine\utility::pauseeffect);
    return;
  }

  scripts\engine\utility::array_thread(var_0.fx, &scripts\engine\utility::pauseeffect);
}

function array_thread_mod_delayed(var_0, var_1, var_2) {
  var_3 = 0;

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  var_4 = [];

  foreach(var_6 in var_0) {
    var_4 = var_6;
    var_3++;
    var_3 %= var_2;

    if(var_2 == 0) {
      scripts\engine\utility::array_thread(var_4, var_1);
      wait 0.05;
      var_4 = [];
    }
  }
}

function battlechatter_on_thread(var_0) {
  level endon("battlechatter_off_thread");
  scripts\anim\battlechatter::bcs_setup_chatter_toggle_array();

  while(!isDefined(anim.chatinitialized)) {
    waitframe();
  }

  anim.bcs_enabled = 1;
  wait 1.5;
  jumpiffalse(isDefined(var_0)) LOC_00000042;
  scripts\engine\sp\utility::set_battlechatter_variable(var_0, 1);
  var_1 = getaiarray(var_0);
  goto LOC_00000077;
}

function set_flag_on_spawned(var_0, var_1) {
  thread scripts\engine\sp\utility::set_flag_on_func_wait_proc(var_0, var_1, &scripts\engine\sp\utility::empty_func, "set_flag_on_spawned");
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function waittill_dead_thread(var_0) {
  self waittill("death");
  var_0.count--;
  var_0 notify("waittill_dead guy died");
}

function waittill_dead_or_dying_thread(var_0) {
  scripts\engine\utility::waittill_either("death", "long_death");
  var_0.count--;
  var_0 notify("waittill_dead_guy_dead_or_dying");
}

function waittill_dead_timeout(var_0) {
  wait var_0;
  self notify("thread_timed_out");
}

function dyndof_thread() {
  self endon("death");
  level endon("stop_dyndof");

  for(;;) {
    var_0 = dyndof_distance();

    if(!isint(var_0)) {
      if(getdvarint("debug_dof_functions", 0)) {}

      level.player setphysicaldepthoffield(level.dyndof.fstop, 1, level.dyndof.focusspeed, level.dyndof.aperturespeed, var_0);
    }

    waitframe();
  }
}

function dyndof_distance() {
  self endon("death");

  if(self != level) {
    GscBinSkip1(0x45, "entity", self);
  }

  var_2 = dyndof_getplayerorigin();
  var_8 = dyndof_getplayerangles();

  if(level.dyndof.prevorigin == var_2 && level.dyndof.prevangles == var_8) {
    if(!isDefined(level.dyndof.firstnomovetime)) {
      level.dyndof.firstnomovetime = gettime();
    } else if(gettime() - level.dyndof.firstnomovetime > 2000) {
      return -1;
    }
  } else {
    level.dyndof.firstnomovetime = undefined;
  }

  level.dyndof.prevorigin = var_2;
  level.dyndof.prevangles = var_8;
  var_8 = [];
  var_9 = level.dyndof.traceangle;
  var_8 = (var_9 * -1, 0, 0);
  var_8 = (0, var_9, 0);
  var_8 = (0, var_9 * -1, 0);
  var_8 = (0, 0, 0);
  var_10 = [];

  foreach(var_12 in var_8) {
    var_13 = dyndof_trace_internal(var_12);

    if(!isDefined(var_13)) {
      continue;
    }

    var_10 = var_13[0];
  }

  if(var_10.size == 0) {
    level notify("stop_dyndof_debug");
    return (dyndof_getplayerorigin() + anglesToForward(dyndof_getplayerangles()) * level.dyndof.maxfocusdist);
  }

  var_14 = 0;
  var_0 = var_10[var_14];

  for(var_4 = 1; var_4 < var_10.size; var_4++) {
    if(var_10[var_4]["fraction"] < var_0["fraction"]) {
      var_0 = var_10[var_4];
    }
  }

  thread dyndof_debug(level, var_10);
  return var_0["position"];
}

function dyndof_trace_internal(var_0, var_1) {
  var_2 = dyndof_getplayerorigin();
  var_0 = combineangles(dyndof_getplayerangles(), var_0);

  if(!isDefined(var_1)) {
    var_1 = dyndof_getplayerorigin() + anglesToForward(var_0) * level.dyndof.maxfocusdist;
  }

  return physics_raycast(var_2, var_1, level.dyndof.contents, level.dyndof.ignorelist, 1, "physicsquery_closest", 1);
}

function dyndof_trace_target(var_0) {
  if(istrue(level.dyndof.ignorecollision)) {
    return true;
  }

  var_1 = dyndof_trace_internal((0, 0, 0), var_0);

  if(isDefined(var_1) && isDefined(var_1[0]) && isDefined(var_1[0]["position"])) {
    if(distance(var_1[0]["position"], var_0) < 8) {
      if(getdvarint("debug_dof_functions", 0)) {
        var_2 = dyndof_getplayerorigin();
      }

      return true;
    } else {
      if(getdvarint("debug_dof_functions", 0)) {
        var_2 = dyndof_getplayerorigin();
      }

      return false;
    }
  }

  if(getdvarint("debug_dof_functions", 0)) {
    var_2 = dyndof_getplayerorigin();
  }

  return true;
}

function dyndof_getplayerorigin() {
  if(level.player islinked()) {
    var_0 = level.player getlinkedparent();

    if(!isDefined(var_0.dyndof_hastag)) {
      var_0.dyndof_hastag = 0;

      if(isDefined(var_0.model)) {
        if(scripts\engine\utility::hastag(var_0.model, "tag_camera")) {
          var_0.dyndof_hastag = 1;
        }
      }
    }

    if(var_0.dyndof_hastag) {
      return var_0 gettagorigin("tag_camera");
    }
  }

  return level.player getvieworigin();
}

function dyndof_getplayerangles() {
  var_0 = level.player getplayerangles();
  return var_0;
}

function create_dyndof() {
  var_0 = spawnStruct();
  var_0.maxfocusdist = 50000;
  var_0.contents = get_dyndof_contents();
  var_0.traceangle = 3;
  var_0.prevangles = (0, 0, 0);
  var_0.prevorigin = (0, 0, 0);
  return var_0;
}

function destroy_dyndof() {
  level.dyndof = undefined;
}

function get_dyndof_contents() {
  var_0 = ["physicscontents_actor", "physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_mantle", "physicscontents_player", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_water"];
  return physics_createcontents(var_0);
}

function dyndof_debug(var_0, var_1) {
  level notify("stop_dyndof_debug");
  level endon("stop_dyndof");
  level endon("stop_dyndof_debug");
}

function scripter_note_proc(var_0) {
  if(getdvarint("scr_showScripterNote") == 0 || getdvarint("lui_footage_capture_enabled") == 1) {
    return;
  }

  level notify("new_scripter_note");

  if(!isDefined(level.scripternote)) {
    level.scripternote = spawnStruct();
    level.scripternote.width = 200;
  }

  if(!isDefined(level.scripternote.notes)) {
    level.scripternote.notes = [];
  }

  if(level.scripternote.notes.size == 5) {
    var_1 = level.scripternote.notes[0];
    level.scripternote.notes = scripts\engine\utility::array_remove_index(level.scripternote.notes, 0);
    update_scripternote_huds();
    thread destroy_scripternote();
  }

  if(!isDefined(level.scripternote.bg)) {
    var_2 = newhudelem();
    var_2.destroying = 0;
    level.scripternote.intro = 1;
    var_2.alpha = 0.7;
    var_2 setshader("black", level.scripternote.width, 50);
    var_3 = newhudelem();
    var_3 settext("Note");
    level.scripternote.bg = var_2;
    level.scripternote.title = var_3;
    var_4 = [var_2, var_3];

    foreach(var_6 in var_4) {
      var_6.alignx = "left";
      var_6.aligny = "top";
      var_6.horzalign = "fullscreen";
      var_6.vertalign = "fullscreen";
      var_6.x = -200;
      var_6.y = 120;
      var_6 moveovertime(0.2);
      var_6.x = 0;
    }

    wait 0.3;
    level.scripternote.intro = 0;
    level.scripternote notify("intro_done");
  } else {
    var_2 = level.scripternote.bg;
    var_2.alpha = 0.7;
    var_3 = level.scripternote.title;
    var_3.alpha = 1;
  }

  if(level.scripternote.intro) {
    level.scripternote waittill("intro_done");
  }

  var_8 = newhudelem();
  var_9 = level.scripternote.notes.size;
  var_8.fontscale = 1;
  var_8.horzalign = "fullscreen";
  var_8.vertalign = "fullscreen";
  var_8.x = 20;
  var_8.y = 140 + var_9 * 12;
  var_8.width = 0;
  var_8.text = var_3;
  var_8 settext(var_3);
  level.scripternote.notes[var_9] = var_8;
  update_scripternote_width();
  level.scripternote.bg scaleovertime(0.2, level.scripternote.width, 50 + (level.scripternote.notes.size - 1) * 10);
  var_8.alpha = 0;
  var_8 fadeovertime(0.2);
  var_8.alpha = 1;
  var_8 endon("death");
  wait 5;
  update_scripternote_huds();
  thread destroy_scripternote();
}

function update_scripternote_width() {
  var_0 = 200;
  var_1 = 0;

  foreach(var_3 in level.scripternote.notes) {
    if(var_3.text.size > var_1) {
      var_1 = var_3.text.size;
      var_0 = var_3.text.size * 6;
    }
  }

  if(var_0 < 200) {
    level.scripternote.width = 200;
    return;
  }

  level.scripternote.width = var_0;
}

function destroy_scripternote() {
  self endon("death");

  if(level.scripternote.notes.size == 1) {
    thread destroy_scripternote_bg();
  }

  level.scripternote.notes = scripts\engine\utility::array_remove(level.scripternote.notes, self);
  update_scripternote_huds();
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y -= 12;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function destroy_scripternote_bg() {
  level endon("new_scripter_note");
  level.scripternote.bg.destroying = 1;
  var_0 = [level.scripternote.bg, level.scripternote.title];

  foreach(var_2 in var_0) {
    var_2 fadeovertime(0.2);
    var_2.alpha = 0;
  }

  wait 0.2;

  foreach(var_2 in var_0) {
    var_2 destroy();
  }
}

function update_scripternote_huds() {
  foreach(var_1 in level.scripternote.notes) {
    var_1 moveovertime(0.2);
    var_1.y = 140 + var_2 * 12;
  }

  update_scripternote_width();
  level.scripternote.bg scaleovertime(0.2, level.scripternote.width, 50 + (level.scripternote.notes.size - 1) * 10);
}