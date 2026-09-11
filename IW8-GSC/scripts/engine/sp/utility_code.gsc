/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\sp\utility_code.gsc
***********************************************/

function structarray_swap(var0, var1) {
  var2 = var0.struct_array_index;
  var3 = var1.struct_array_index;
  self.array[var3] = var0;
  self.array[var2] = var1;
  self.array[var2].struct_array_index = var2;
  self.array[var3].struct_array_index = var3;
}

function wait_until_done_speaking() {
  self endon("death");
  self endon("removed from battleChatter");

  while(self.battlechatter.isspeaking) {
    wait 0.05;
  }
}

function wait_for_trigger_think(var0) {
  self endon("death");
  var0 endon("trigger");
  self waittill("trigger");
  var0 notify("trigger");
}

function wait_for_trigger(var0, var1) {
  var2 = getEntArray(var0, var1);
  var3 = spawnStruct();
  scripts\engine\utility::array_thread(var2, &wait_for_trigger_think, var3);
  var3 waittill("trigger");
}

function ent_waits_for_trigger(var0) {
  self endon("done");
  var0 waittill("trigger");
  self notify("done");
}

function update_debug_friendlycolor_on_death() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  var0 = self.unique_id;
  self waittill("death");
  level.debug_color_friendlies[var0] = undefined;
  level notify("updated_color_friendlies");
}

function update_debug_friendlycolor(var0) {
  thread update_debug_friendlycolor_on_death();

  if(isDefined(self.script_forcecolor)) {
    level.debug_color_friendlies[var0] = self.script_forcecolor;
  } else {
    level.debug_color_friendlies[var0] = undefined;
  }

  level notify("updated_color_friendlies");
}

function insure_player_does_not_set_forcecolor_twice_in_one_frame() {}

function new_color_being_set(var0) {
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

function waittill_either_function_internal(var0, var1, var2) {
  var0 endon("done");
  [[var1]](var2);
  var0 notify("done");
}

function hintprintbreakout(var0, var1) {
  self endon("hint_print_timeout");
  self endon("hint_print_remove");
  var1 endon("new_hint");

  for(;;) {
    self.fadeout = 1;

    if(isDefined(level.hint_breakfunc) && [[level.hint_breakfunc]]() || var1.current_global_hint != var0) {
      break;
    }

    wait 0.05;
  }
}

function hint_timeout(var0) {
  wait var0;
  self.fadeout = 1;
  self notify("hint_print_timeout");
}

function destroy_hint_on_endon(var0, var1) {
  self endon("removing_hint");

  if(isarray(var0) || isarray(var1)) {
    destroy_hint_on_endon_proc(var0, var1);
  } else {
    var0[0] waittill(var1[0]);
  }

  self.fadeout = 1;
  self notify("hint_print_remove");
}

function destroy_hint_on_endon_proc(var0, var1) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  if(!isarray(var1)) {
    var1 = [var1];
  }

  foreach(var3 in var0) {
    foreach(var5 in var1) {
      var3 endon(var5);
    }
  }

  level waittill("forever");
}

function hint_stick_get_updated(var0, var1, var2, var3, var4, var5, var6) {
  return var0 + _hint_stick_get_config_suffix(var1, var2, var3, var4, var5, var6);
}

function _hint_stick_get_config_suffix(var0, var1, var2, var3, var4, var5) {
  var6 = getsticksconfig();

  if(level.player scripts\engine\utility::is_player_gamepad_enabled()) {
    if(level.player isps4player()) {
      if(issubstr(var6, "southpaw") || var5 && issubstr(var6, "legacy")) {
        return var4;
      }

      return var3;
    }

    if(issubstr(var6, "southpaw") || var5 && issubstr(var6, "legacy")) {
      return var2;
    }

    return var1;
  }

  return var0;
}

function _hint_stick_update_breakfunc(var0, var1) {
  var2 = var1 + var0;
  var3 = level.trigger_hint_func[var2];
  level.hint_breakfunc = var3;
}

function _hint_stick_update_string(var0, var1) {
  var2 = var1 + var0;
  var3 = level.trigger_hint_string[var2];
  var4 = scripts\engine\sp\utility::get_player_from_self();
  var4 sethudtutorialmessage(var3);
}

function hint_stick_update(var0, var1, var2, var3, var4, var5, var6) {
  level notify("hint_change_config");
  level endon("hint_change_config");
  var7 = _hint_stick_get_config_suffix(var1, var2, var3, var4, var5, var6);

  while(isDefined(level.current_hint_active) && level.current_hint_active) {
    var8 = _hint_stick_get_config_suffix(var1, var2, var3, var4, var5, var6);

    if(var8 != var7) {
      var7 = var8;
      _hint_stick_update_breakfunc(var7, var0);
      _hint_stick_update_string(var7, var0);
    }

    waitframe();
  }
}

function hintprint(var0, var1, var2, var3, var4, var5) {
  self notify("new_hint");

  if(getdvarint("scr_disable_hints") > 0) {
    return;
  }

  var6 = gettime();

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isalive(self)) {
    return;
  }

  scripts\engine\utility::ent_flag_waitopen("global_hint_in_use");

  if(isDefined(self.current_global_hint)) {
    if(self.current_global_hint == var0) {
      return;
    } else {
      self.current_global_hint = var0;
      scripts\engine\utility::ent_flag_set("global_hint_in_use");
      wait 0.05;
    }
  }

  self.current_global_hint = var0;
  scripts\engine\utility::ent_flag_set("global_hint_in_use");
  level.current_hint_active = 1;
  level.hint_breakfunc = var1;
  level endon("friendlyfire_mission_fail");
  self sethudtutorialmessage(var0);
  var7 = spawnStruct();
  var7.fadeout = 0;

  if(isDefined(var2)) {
    thread hint_timeout(var7);
  }

  thread destroy_hint_on_friendlyfire();
  thread destroy_hint_on_player_death();

  if(isDefined(var4) && isDefined(var5)) {
    thread destroy_hint_on_endon(var7, var4);
  }

  hintprintbreakout(var7, var0, self);

  if(!istrue(var7.fadeout)) {
    self clearhudtutorialmessage(1);
  }

  scripts\engine\sp\utility::wait_for_buffer_time_to_pass(var6, var3);
  var7 notify("removing_hint");
  self.current_global_hint = undefined;

  if(var7.fadeout) {
    self clearhudtutorialmessage();
  }

  level.current_hint_active = 0;
  scripts\engine\utility::ent_flag_clear("global_hint_in_use");
}

function destroy_hint_on_friendlyfire(var0) {
  self endon("removing_hint");
  level waittill("friendlyfire_mission_fail");
  self.fadeout = 1;
  self notify("hint_print_remove");
}

function destroy_hint_on_player_death(var0) {
  self endon("removing_hint");
  level.player waittill("death");
  self.fadeout = 1;
  self notify("hint_print_remove");
}

function function_stack_wait(var0) {
  self endon("death");
  var0 scripts\engine\utility::waittill_either("function_done", "death");
}

function function_stack_wait_finish(var0) {
  function_stack_wait(var0);

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

function function_stack_proc(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");

  if(!isDefined(var0.function_stack)) {
    var0.function_stack = [];
  }

  var0.function_stack[var0.function_stack.size] = self;
  thread function_stack_self_death(var0);
  function_stack_caller_waits_for_turn(var0);

  if(isDefined(var0) && isDefined(var0.function_stack)) {
    self.function_stack_func_begun = 1;
    self notify("function_stack_func_begun");

    if(isDefined(var6)) {
      var0[[var1]](var2, var3, var4, var5, var6);
    } else if(isDefined(var5)) {
      var0[[var1]](var2, var3, var4, var5);
    } else if(isDefined(var4)) {
      var0[[var1]](var2, var3, var4);
    } else if(isDefined(var3)) {
      var0[[var1]](var2, var3);
    } else if(isDefined(var2)) {
      var0[[var1]](var2);
    } else {
      var0[[var1]]();
    }

    if(isDefined(var0) && isDefined(var0.function_stack)) {
      var0.function_stack = scripts\engine\utility::array_remove(var0.function_stack, self);
      var0 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self.function_stack_func_begun = 0;
    self notify("function_done");
    return;
  }
}

function function_stack_self_death(var0) {
  self endon("function_done");
  self waittill("death");

  if(isDefined(var0)) {
    var0.function_stack = scripts\engine\utility::array_remove(var0.function_stack, self);
    var0 notify("level_function_stack_ready");
    return;
  }
}

function function_stack_caller_waits_for_turn(var0) {
  var0 endon("death");
  self endon("death");
  var0 endon("clear_function_stack");

  while(var0.function_stack[0] != self) {
    var0 waittill("level_function_stack_ready");
  }
}

function array_waitlogic1(var0, var1, var2) {
  array_waitlogic2(var0, var1, var2);
  self._array_wait = 0;
  self notify("_array_wait");
}

function array_waitlogic2(var0, var1, var2) {
  var0 endon(var1);
  var0 endon("death");

  if(isDefined(var2)) {
    wait var2;
    return;
  }

  var0 waittill(var1);
}

function exec_call(var0) {
  if(var0.parms.size == 0) {
    var0.caller builtin[[var0.func]]();
  } else if(var0.parms.size == 1) {
    var0.caller builtin[[var0.func]](var0.parms[0]);
  } else if(var0.parms.size == 2) {
    var0.caller builtin[[var0.func]](var0.parms[0], var0.parms[1]);
  } else if(var0.parms.size == 3) {
    var0.caller builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2]);
  }

  if(var0.parms.size == 4) {
    var0.caller builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3]);
  }

  if(var0.parms.size == 5) {
    var0.caller builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3], var0.parms[4]);
    return;
  }
}

function exec_call_noself(var0) {
  if(var0.parms.size == 0) {
    builtin[[var0.func]]();
  } else if(var0.parms.size == 1) {
    builtin[[var0.func]](var0.parms[0]);
  } else if(var0.parms.size == 2) {
    builtin[[var0.func]](var0.parms[0], var0.parms[1]);
  } else if(var0.parms.size == 3) {
    builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2]);
  }

  if(var0.parms.size == 4) {
    builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3]);
  }

  if(var0.parms.size == 5) {
    builtin[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3], var0.parms[4]);
    return;
  }
}

function exec_func(var0, var1) {
  if(!isDefined(var0.caller)) {
    return;
  }

  for(var2 = 0; var2 < var1.size; var2++) {
    var1[var2].caller endon(var1[var2].ender);
  }

  if(var0.parms.size == 0) {
    var0.caller[[var0.func]]();
  } else if(var0.parms.size == 1) {
    var0.caller[[var0.func]](var0.parms[0]);
  } else if(var0.parms.size == 2) {
    var0.caller[[var0.func]](var0.parms[0], var0.parms[1]);
  } else if(var0.parms.size == 3) {
    var0.caller[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2]);
  }

  if(var0.parms.size == 4) {
    var0.caller[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3]);
  }

  if(var0.parms.size == 5) {
    var0.caller[[var0.func]](var0.parms[0], var0.parms[1], var0.parms[2], var0.parms[3], var0.parms[4]);
    return;
  }
}

function waittill_func_ends(var0, var1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var0, var1);
  self.count--;
  self notify("func_ended");
}

function waittill_abort_func_ends(var0, var1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  exec_func(var0, var1);
  self.abort_count--;
  self notify("abort_func_ended");
}

function do_abort(var0) {
  self endon("all_funcs_ended");

  if(!var0.size) {
    return;
  }

  var1 = 0;
  self.abort_count = var0.size;
  var2 = [];
  scripts\engine\utility::array_levelthread(var0, &waittill_abort_func_ends, var2);

  for(;;) {
    if(self.abort_count <= var1) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

function translate_local_on_ent(var0) {
  if(isDefined(self.forward)) {
    var1 = anglesToForward(var0.angles);
    var0.origin += var1 * self.forward;
  }

  if(isDefined(self.right)) {
    var2 = anglestoright(var0.angles);
    var0.origin += var2 * self.right;
  }

  if(isDefined(self.up)) {
    var3 = anglestoup(var0.angles);
    var0.origin += var3 * self.up;
  }

  if(isDefined(self.yaw)) {
    var0 addyaw(self.yaw);
  }

  if(isDefined(self.pitch)) {
    var0 addpitch(self.pitch);
  }

  if(isDefined(self.roll)) {
    var0 addroll(self.roll);
    return;
  }
}

function dynamic_run_speed_thread(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");
  self endon("stop_dynamic_run_speed");
  var7 = 1;
  var8 = anglesToForward(self.angles);

  for(;;) {
    var9 = dynamic_run_speed_goalpos();

    if(distancesquared(var9, self.origin) > 0) {
      var10 = scripts\engine\utility::flat_origin(var9);
      var11 = scripts\engine\utility::flat_origin(self.origin);

      if(distancesquared(var10, var11) > 100) {
        var8 = vectorNormalize(var10 - var11);
      }

      var12 = self.origin + var8 * var5;
      var13 = vectorNormalize(var0.origin - var12);
      var14 = vectordot(var13, var8);

      if(var14 > 0) {
        dynamic_run_speed_set(var0, var4, var5, var8, var3, var2, 0);
      } else {
        dynamic_run_speed_set(var0, var5, var6, var8, var2, var1, 1);
      }
    }

    waitframe();
  }
}

function dynamic_run_speed_set(var0, var1, var2, var3, var4, var5, var6) {
  var7 = vectortoangles(var3);
  var8 = anglestoright(var7);
  var9 = self.origin + var3 * var1;
  var10 = self.origin + var3 * var2;
  var11 = pointonsegmentnearesttopoint(var9, var10, var0.origin);
  var12 = distance(var9, var11);
  var13 = var1 - var2;
  var14 = 1 - scripts\engine\math::lerp_fraction(0, abs(var13), var12);
  var15 = scripts\engine\math::lerp(var5, var4, var14);
  var15 = clamp(var15, 23, 250);
  scripts\engine\utility::set_movement_speed(var15);
}

function dynamic_run_speed_goalpos() {
  var0 = undefined;

  if(isDefined(self.follow_ent)) {
    var0 = self.follow_ent.origin;
  } else if(isDefined(self.goalnode)) {
    var0 = self.goalnode.origin;
  } else {
    var0 = self.scriptgoalpos;
  }

  return var0;
}

function handsignal(var0, var1, var2, var3) {
  var4 = 1;

  if(isDefined(var1)) {
    var4 = !var1;
  }

  if(isDefined(var2)) {
    level endon(var2);
  }

  if(isDefined(var3)) {
    level waittill(var3);
  }

  var5 = "signal_" + var0;

  if(self.currentpose == "crouch") {
    var5 += "_crouch";
  } else if(self.script == "cover_right") {
    var5 += "_coverR";
  } else if(scripts\anim\utility::iscqbwalking()) {
    var5 += "_cqb";
  }

  if(var4) {
    self setanimrestart(scripts\engine\sp\utility::getgenericanim(var5), 1, 0, 1.1);
    return;
  }

  scripts\common\anim::anim_generic(self, var5);
}

function g_speed_get_func(var0) {
  return int(getDvar("NSRPQNLSNK"));
}

function g_speed_set_func(var0, var1) {
  setsaveddvar("NSRPQNLSNK", int(var0));
}

function g_bob_scale_get_func(var0) {
  return level.player getbobrate();
}

function g_bob_scale_set_func(var0, var1) {
  level.player setbobrate(var0);
}

function movespeed_get_func(var0) {
  if(!isDefined(var0)) {
    var0 = "default";
  }

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[var0])) {
    return 1;
  }

  return self.movespeedscales[var0];
}

function movespeed_set_func(var0, var1) {
  var2 = 1;

  if(!isDefined(var1)) {
    var1 = "default";
  }

  self.movespeedscales[var1] = var0;

  foreach(var0 in self.movespeedscales) {
    if(var0 == 1) {
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, var4);
    }

    var2 *= var0;
  }

  self.movespeedscale = var2;
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
  self waittill("grenade_fire", var0);
  thread autosave_tactical_grenade_check_dieout(var0);
  self notify("autosave_grenade_thrown");
}

function autosave_tactical_nade_flag_clear() {
  waittillframeend();

  if(!level.autosave_tactical_player_nades) {
    scripts\engine\utility::flag_clear("autosave_tactical_player_nade");
    return;
  }
}

function autosave_tactical_grenade_check_dieout(var0) {
  level.autosave_tactical_player_nades++;
  var0 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
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

  var0 = getaiarray("axis");

  foreach(var2 in var0) {
    if(isDefined(var2.enemy) && isPlayer(var2.enemy)) {
      return;
    }
  }

  waittillframeend();
  scripts\engine\sp\utility::autosave_by_name();
}

function doslide(var0, var1, var2) {
  self endon("death");
  self endon("stop_sliding");
  var3 = self;
  var4 = undefined;
  var5 = var0.origin;
  var6 = var0.origin;
  var7 = undefined;

  for(;;) {
    var8 = var3 getnormalizedmovement();
    var9 = anglesToForward(var3.angles);
    var10 = anglestoright(var3.angles);
    var8 = (var8[1] * var10[0] + var8[0] * var9[0], var8[1] * var10[1] + var8[0] * var9[1], 0);
    var0.slidevelocity += var8 * var1;
    var3.fx_tag.origin = var0.origin + anglesToForward(var0.gesture_target.angles) * 400;
    wait 0.05;
    var0.slidevelocity *= 1 - var2;
  }
}

function kill_deathflag_proc(var0) {
  self endon("death");

  if(isDefined(var0)) {
    wait randomfloat(var0);
  }

  playFXOnTag(scripts\engine\utility::getfx("flesh_hit"), self, "tag_eye");
  self kill(level.player.origin);
}

function update_rumble_intensity(var0, var1) {
  self endon("death");
  var2 = 0;

  for(;;) {
    if(self.intensity > 0.0001 && gettime() > 300) {
      if(!var2) {
        self playrumblelooponentity(var1);
        var2 = 1;
      }
    } else if(var2) {
      self stoprumble(var1);
      var2 = 0;
    }

    var3 = 1 - self.intensity;
    var3 *= 1000;
    self.origin = var0 getEye() + (0, 0, var3);
    wait 0.05;
  }
}

function process_blend(var0, var1, var2, var3, var4) {
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

  var5 = self.time * 20;
  var6 = self.end - self.start;
  self.stop_blend = 0;

  if(isDefined(var4)) {
    for(var7 = 0; var7 <= var5 && !self.stop_blend; var7++) {
      var8 = self.base + var7 * var6 / var5;
      var1 thread[[var0]](var8, var2, var3, var4);
      wait 0.05;
    }

    return;
  }

  if(isDefined(var5)) {
    for(var7 = 0; var7 <= var7 && !self.stop_blend; var7++) {
      var8 = self.base + var7 * var8 / var7;
      var3 thread[[var2]](var8, var4, var5);
      wait 0.05;
    }

    return;
  }

  if(isDefined(var6)) {
    for(var7 = 0; var7 <= var7 && !self.stop_blend; var7++) {
      var8 = self.base + var7 * var8 / var7;
      var5 thread[[var4]](var8, var6);
      wait 0.05;
    }

    return;
  }

  for(var7 = 0; var7 <= var7 && !self.stop_blend; var7++) {
    var8 = self.base + var7 * var8 / var7;
    var7 thread[[var6]](var8);
    wait 0.05;
  }
}

function get_color_info_from_trigger() {
  var0 = "allies";

  if(isDefined(self.script_color_axis)) {
    var0 = "axis";
  }

  var0 = scripts\sp\colors::get_team(var0);
  var1 = [];

  if(var0 == "allies") {
    var2 = scripts\sp\colors::get_colorcodes_from_trigger(self.script_color_allies, "allies");
    var1 = var2["colorCodes"];
  } else {
    var2 = scripts\sp\colors::get_colorcodes_from_trigger(self.script_color_axis, "axis");
    var2 = var2["colorCodes"];
  }

  var3 = [];
  GscBinSkip0(0x2e, "team", var1);
}

function delaychildthread_proc(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("death");
  self endon("stop_delay_thread");
  wait var1;

  if(isDefined(var7)) {
    childthread[[var0]](var2, var3, var4, var5, var6, var7);
    return;
  }

  if(isDefined(var6)) {
    childthread[[var0]](var2, var3, var4, var5, var6);
    return;
  }

  if(isDefined(var5)) {
    childthread[[var0]](var2, var3, var4, var5);
    return;
  }

  if(isDefined(var4)) {
    childthread[[var0]](var2, var3, var4);
    return;
  }

  if(isDefined(var3)) {
    childthread[[var0]](var2, var3);
    return;
  }

  if(isDefined(var2)) {
    childthread[[var0]](var2);
    return;
  }

  childthread[[var0]]();
}

function flagwaitthread_proc(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");
  scripts\engine\utility::flag_wait(var1[0]);
  scripts\engine\utility::delaythread_proc(var0, var1[1], var2, var3, var4, var5, var6);
}

function waittillthread_proc(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");
  self waittill(var1[0]);
  scripts\engine\utility::delaythread_proc(var0, var1[1], var2, var3, var4, var5, var6);
}

function add_wait_asserter() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for(var0 = 0; var0 < 20; var0++) {
    waittillframeend();
  }
}

function update_battlechatter_hud() {}

function comparesizesfx(var0, var1, var2, var3) {
  if(!var1.size) {
    return undefined;
  }

  if(isDefined(var2)) {
    var4 = undefined;
    var5 = getarraykeys(var1);

    for(var6 = 0; var6 < var5.size; var6++) {
      var7 = distance(var1[var5[var6]].v["origin"], var0);

      if([[var3]](var7, var2)) {
        continue;
      }

      var2 = var7;
      var4 = var1[var5[var6]];
    }

    return var4;
  }

  var5 = getarraykeys(var5);
  var4 = var5[var5[0]];
  var6 = distance(var4.v["origin"], var4);

  for(var6 = 1; var6 < var5.size; var6++) {
    var7 = distance(var5[var5[var6]].v["origin"], var4);

    if([[var7]](var7, var6)) {
      continue;
    }

    var6 = var7;
    var4 = var5[var5[var6]];
  }

  return var4;
}

function waittill_triggered_current() {
  for(;;) {
    self waittill("trigger", var0);
    waittillframeend();

    if(var0.currentnode == self) {
      return var0;
    }
  }
}

function add_trigger_func_thread() {
  self.trigger_functions = [];
  self waittill("trigger", var0);
  var1 = self.trigger_functions;
  self.trigger_functions = undefined;
  var2 = var1;
  var4 = getfirstarraykey(var2);

  if(isDefined(var4)) {
    var3 = var2[var4];
    GscBinSkip1(0x74, var3, var0);
  }

  var2 = undefined;
  var4 = undefined;
}

function add_to_radio(var0) {
  if(!isDefined(level.scr_radio[var0])) {
    level.scr_radio[var0] = var0;
    return;
  }
}

function add_to_player_dialogue(var0) {
  if(!isDefined(level.scr_plrdialogue[var0])) {
    level.scr_plrdialogue[var0] = var0;
    return;
  }
}

function add_to_dialogue(var0) {
  if(!isDefined(level.scr_anim[self.animname])) {
    level.scr_anim[self.animname] = [];
  }

  if(!isDefined(level.scr_sound[self.animname])) {
    level.scr_sound[self.animname] = [];
  }

  if(!isDefined(level.scr_sound[self.animname][var0])) {
    level.scr_sound[self.animname][var0] = var0;
    return;
  }
}

function add_to_dialogue_generic(var0) {
  if(!isDefined(level.scr_sound["generic"])) {
    level.scr_sound["generic"] = [];
  }

  if(!isDefined(level.scr_sound["generic"][var0])) {
    level.scr_sound["generic"][var0] = var0;
    return;
  }
}

function _flag_wait_trigger(var0, var1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var2);
    scripts\engine\utility::flag_set(var0);

    if(!var1) {
      return;
    }

    while(var2 istouching(self)) {
      wait 0.05;
    }

    scripts\engine\utility::flag_clear(var0);
  }
}

function fx_volume_pause(var0, var1) {
  var0.fx_paused = 1;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(var1) {
    array_thread_mod_delayed(var0.fx, &scripts\engine\utility::pauseeffect);
    return;
  }

  scripts\engine\utility::array_thread(var0.fx, &scripts\engine\utility::pauseeffect);
}

function array_thread_mod_delayed(var0, var1, var2) {
  var3 = 0;

  if(!isDefined(var2)) {
    var2 = 5;
  }

  var4 = [];

  foreach(var6 in var0) {
    var4 = var6;
    var3++;
    var3 %= var2;

    if(var2 == 0) {
      scripts\engine\utility::array_thread(var4, var1);
      wait 0.05;
      var4 = [];
    }
  }
}

function battlechatter_on_thread(var0) {
  level endon("battlechatter_off_thread");
  scripts\anim\battlechatter::bcs_setup_chatter_toggle_array();

  while(!isDefined(anim.chatinitialized)) {
    waitframe();
  }

  anim.bcs_enabled = 1;
  wait 1.5;
  jumpiffalse(isDefined(var0)) LOC_00000042;
  scripts\engine\sp\utility::set_battlechatter_variable(var0, 1);
  var1 = getaiarray(var0);
  goto LOC_00000077;
}

function set_flag_on_spawned(var0, var1) {
  thread scripts\engine\sp\utility::set_flag_on_func_wait_proc(var0, var1, &scripts\engine\sp\utility::empty_func, "set_flag_on_spawned");
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function waittill_dead_thread(var0) {
  self waittill("death");
  var0.count--;
  var0 notify("waittill_dead guy died");
}

function waittill_dead_or_dying_thread(var0) {
  scripts\engine\utility::waittill_either("death", "long_death");
  var0.count--;
  var0 notify("waittill_dead_guy_dead_or_dying");
}

function waittill_dead_timeout(var0) {
  wait var0;
  self notify("thread_timed_out");
}

function dyndof_thread() {
  self endon("death");
  level endon("stop_dyndof");

  for(;;) {
    var0 = dyndof_distance();

    if(!isint(var0)) {
      if(getdvarint("debug_dof_functions", 0)) {}

      level.player setphysicaldepthoffield(level.dyndof.fstop, 1, level.dyndof.focusspeed, level.dyndof.aperturespeed, var0);
    }

    waitframe();
  }
}

function dyndof_distance() {
  self endon("death");

  if(self != level) {
    GscBinSkip1(0x45, "entity", self);
  }

  var2 = dyndof_getplayerorigin();
  var8 = dyndof_getplayerangles();

  if(level.dyndof.prevorigin == var2 && level.dyndof.prevangles == var8) {
    if(!isDefined(level.dyndof.firstnomovetime)) {
      level.dyndof.firstnomovetime = gettime();
    } else if(gettime() - level.dyndof.firstnomovetime > 2000) {
      return -1;
    }
  } else {
    level.dyndof.firstnomovetime = undefined;
  }

  level.dyndof.prevorigin = var2;
  level.dyndof.prevangles = var8;
  var8 = [];
  var9 = level.dyndof.traceangle;
  var8 = (var9 * -1, 0, 0);
  var8 = (0, var9, 0);
  var8 = (0, var9 * -1, 0);
  var8 = (0, 0, 0);
  var10 = [];

  foreach(var12 in var8) {
    var13 = dyndof_trace_internal(var12);

    if(!isDefined(var13)) {
      continue;
    }

    var10 = var13[0];
  }

  if(var10.size == 0) {
    level notify("stop_dyndof_debug");
    return (dyndof_getplayerorigin() + anglesToForward(dyndof_getplayerangles()) * level.dyndof.maxfocusdist);
  }

  var14 = 0;
  var0 = var10[var14];

  for(var4 = 1; var4 < var10.size; var4++) {
    if(var10[var4]["fraction"] < var0["fraction"]) {
      var0 = var10[var4];
    }
  }

  thread dyndof_debug(level, var10);
  return var0["position"];
}

function dyndof_trace_internal(var0, var1) {
  var2 = dyndof_getplayerorigin();
  var0 = combineangles(dyndof_getplayerangles(), var0);

  if(!isDefined(var1)) {
    var1 = dyndof_getplayerorigin() + anglesToForward(var0) * level.dyndof.maxfocusdist;
  }

  return physics_raycast(var2, var1, level.dyndof.contents, level.dyndof.ignorelist, 1, "physicsquery_closest", 1);
}

function dyndof_trace_target(var0) {
  if(istrue(level.dyndof.ignorecollision)) {
    return true;
  }

  var1 = dyndof_trace_internal((0, 0, 0), var0);

  if(isDefined(var1) && isDefined(var1[0]) && isDefined(var1[0]["position"])) {
    if(distance(var1[0]["position"], var0) < 8) {
      if(getdvarint("debug_dof_functions", 0)) {
        var2 = dyndof_getplayerorigin();
      }

      return true;
    } else {
      if(getdvarint("debug_dof_functions", 0)) {
        var2 = dyndof_getplayerorigin();
      }

      return false;
    }
  }

  if(getdvarint("debug_dof_functions", 0)) {
    var2 = dyndof_getplayerorigin();
  }

  return true;
}

function dyndof_getplayerorigin() {
  if(level.player islinked()) {
    var0 = level.player getlinkedparent();

    if(!isDefined(var0.dyndof_hastag)) {
      var0.dyndof_hastag = 0;

      if(isDefined(var0.model)) {
        if(scripts\engine\utility::hastag(var0.model, "tag_camera")) {
          var0.dyndof_hastag = 1;
        }
      }
    }

    if(var0.dyndof_hastag) {
      return var0 gettagorigin("tag_camera");
    }
  }

  return level.player getvieworigin();
}

function dyndof_getplayerangles() {
  var0 = level.player getplayerangles();
  return var0;
}

function create_dyndof() {
  var0 = spawnStruct();
  var0.maxfocusdist = 50000;
  var0.contents = get_dyndof_contents();
  var0.traceangle = 3;
  var0.prevangles = (0, 0, 0);
  var0.prevorigin = (0, 0, 0);
  return var0;
}

function destroy_dyndof() {
  level.dyndof = undefined;
}

function get_dyndof_contents() {
  var0 = ["physicscontents_actor", "physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_mantle", "physicscontents_player", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_water"];
  return physics_createcontents(var0);
}

function dyndof_debug(var0, var1) {
  level notify("stop_dyndof_debug");
  level endon("stop_dyndof");
  level endon("stop_dyndof_debug");
}

function scripter_note_proc(var0) {
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
    var1 = level.scripternote.notes[0];
    level.scripternote.notes = scripts\engine\utility::array_remove_index(level.scripternote.notes, 0);
    update_scripternote_huds();
    thread destroy_scripternote();
  }

  if(!isDefined(level.scripternote.bg)) {
    var2 = newhudelem();
    var2.destroying = 0;
    level.scripternote.intro = 1;
    var2.alpha = 0.7;
    var2 setshader("black", level.scripternote.width, 50);
    var3 = newhudelem();
    var3 settext("Note");
    level.scripternote.bg = var2;
    level.scripternote.title = var3;
    var4 = [var2, var3];

    foreach(var6 in var4) {
      var6.alignx = "left";
      var6.aligny = "top";
      var6.horzalign = "fullscreen";
      var6.vertalign = "fullscreen";
      var6.x = -200;
      var6.y = 120;
      var6 moveovertime(0.2);
      var6.x = 0;
    }

    wait 0.3;
    level.scripternote.intro = 0;
    level.scripternote notify("intro_done");
  } else {
    var2 = level.scripternote.bg;
    var2.alpha = 0.7;
    var3 = level.scripternote.title;
    var3.alpha = 1;
  }

  if(level.scripternote.intro) {
    level.scripternote waittill("intro_done");
  }

  var8 = newhudelem();
  var9 = level.scripternote.notes.size;
  var8.fontscale = 1;
  var8.horzalign = "fullscreen";
  var8.vertalign = "fullscreen";
  var8.x = 20;
  var8.y = 140 + var9 * 12;
  var8.width = 0;
  var8.text = var3;
  var8 settext(var3);
  level.scripternote.notes[var9] = var8;
  update_scripternote_width();
  level.scripternote.bg scaleovertime(0.2, level.scripternote.width, 50 + (level.scripternote.notes.size - 1) * 10);
  var8.alpha = 0;
  var8 fadeovertime(0.2);
  var8.alpha = 1;
  var8 endon("death");
  wait 5;
  update_scripternote_huds();
  thread destroy_scripternote();
}

function update_scripternote_width() {
  var0 = 200;
  var1 = 0;

  foreach(var3 in level.scripternote.notes) {
    if(var3.text.size > var1) {
      var1 = var3.text.size;
      var0 = var3.text.size * 6;
    }
  }

  if(var0 < 200) {
    level.scripternote.width = 200;
    return;
  }

  level.scripternote.width = var0;
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
  var0 = [level.scripternote.bg, level.scripternote.title];

  foreach(var2 in var0) {
    var2 fadeovertime(0.2);
    var2.alpha = 0;
  }

  wait 0.2;

  foreach(var2 in var0) {
    var2 destroy();
  }
}

function update_scripternote_huds() {
  foreach(var1 in level.scripternote.notes) {
    var1 moveovertime(0.2);
    var1.y = 140 + var2 * 12;
  }

  update_scripternote_width();
  level.scripternote.bg scaleovertime(0.2, level.scripternote.width, 50 + (level.scripternote.notes.size - 1) * 10);
}