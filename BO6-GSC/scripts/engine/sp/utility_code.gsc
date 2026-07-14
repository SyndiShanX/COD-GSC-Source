/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\sp\utility_code.gsc
**********************************************/

#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\colors;
#namespace utility_code;

function structarray_swap(object1, object2) {
  index1 = object1.struct_array_index;
  index2 = object2.struct_array_index;
  self.array[index2] = object1;
  self.array[index1] = object2;
  self.array[index1].struct_array_index = index1;
  self.array[index2].struct_array_index = index2;
}

function wait_until_done_speaking() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("yV8\xd1)\x1c\xfe\xab\x99^H\xd0\xbf\xc04\xc9\xc9^\x18\xa0\xb86v\x19\xb1f");

  while(self.battlechatter.isspeaking) {
    wait 0.05;
  }
}

function wait_for_trigger_think(ent) {
  self endon("\x1e\xfd\xd1\xa2\a");
  ent endon("\x91`\xb1\xe7T\x97>");
  self waittill("\x91`\xb1\xe7T\x97>");
  ent notify("\x91`\xb1\xe7T\x97>");
}

function wait_for_trigger(msg, type) {
  triggers = getEntArray(msg, type);
  ent = spawnStruct();
  utility::array_thread(triggers, &wait_for_trigger_think, ent);
  ent waittill("\x91`\xb1\xe7T\x97>");
}

function ent_waits_for_trigger(trigger) {
  self endon("\x7f5dI");
  trigger waittill("\x91`\xb1\xe7T\x97>");
  self notify("\x7f5dI");
}

function update_debug_friendlycolor_on_death() {
  self notify("\xf4\xaeT\x8f\xf4\xbe\xbbDD\xd7UL\x95\xec\xfb9{\xbc");
  self endon("\xf4\xaeT\x8f\xf4\xbe\xbbDD\xd7UL\x95\xec\xfb9{\xbc");
  num = self.unique_id;
  self waittill("\x1e\xfd\xd1\xa2\a");
  level.debug_color_friendlies[num] = undefined;
  level notify("\x9cm\x91\xf1S\x89\xcd9\x80\x97\x050\x93l\xbd\xa2\xa4\xc54QP\x97\xc5\xa1");
}

function update_debug_friendlycolor(num) {
  thread update_debug_friendlycolor_on_death();

  if(isDefined(self.script_forcecolor)) {
    level.debug_color_friendlies[num] = self.script_forcecolor;
  } else {
    level.debug_color_friendlies[num] = undefined;
  }

  level notify("\x9cm\x91\xf1S\x89\xcd9\x80\x97\x050\x93l\xbd\xa2\xa4\xc54QP\x97\xc5\xa1");
}

function insure_player_does_not_set_forcecolor_twice_in_one_frame() {
  assert(!isDefined(self.setforcecolor), "<dev string:x24>");
  self.setforcecolor = 1;
  waittillframeend();

  if(!isalive(self)) {
    return;
  }

  self.setforcecolor = undefined;
}

function new_color_being_set(color) {
  self notify("\xe6\xac\xdd\xaf\x8d\xbd6\xb7r\xfa1\xb2Z\xb9v\xafs\xb2t");
  self.new_force_color_being_set = 1;
  colors::left_color_node();
  self endon("\xe6\xac\xdd\xaf\x8d\xbd6\xb7r\xfa1\xb2Z\xb9v\xafs\xb2t");
  self endon("\x1e\xfd\xd1\xa2\a");
  waittillframeend();
  waittillframeend();

  if(isDefined(self.script_forcecolor)) {
    self.currentcolorcode = level.currentcolorforced[colors::get_team()][self.script_forcecolor];

    if(isDefined(self.dontcolormove)) {
      self.dontcolormove = undefined;
    } else {
      thread colors::goto_current_colorindex();
    }
  }

  self.new_force_color_being_set = undefined;
  self notify("\xfd&mB\xe6K[\x11\x17\x9fVl\x84f\xc4Q1&m8n\xca");

  update_debug_friendlycolor(self.unique_id);
}

function waittill_either_function_internal(ent, func, parm) {
  ent endon("\x7f5dI");
  [[func]](parm);
  ent notify("\x7f5dI");
}

function hintprintbreakout(string, user) {
  self endon("BSr\xc2Y\x80fT\x0eu7\xdc\v9\x9c\x8c\x15j");
  self endon("\x0f\xc8\xa17\xfd4\xac,C\xb1~wO\xfc\xe1*\x9b");
  user endon("\x9e\vH\xbePGv[");

  while(true) {
    self.fadeout = 1;

    if(isDefined(level.hint_breakfunc) && [[level.hint_breakfunc]]() || user.current_global_hint != string) {
      break;
    }

    wait 0.05;
  }
}

function hint_timeout(timeout) {
  wait timeout;
  self.fadeout = 1;
  self notify("BSr\xc2Y\x80fT\x0eu7\xdc\v9\x9c\x8c\x15j");
}

function destroy_hint_on_endon(endonentities, endonmessages) {
  self endon("9ek\xbd\xceZ\xe6v_4-\x9b\xe8");

  if(isarray(endonentities) || isarray(endonmessages)) {
    destroy_hint_on_endon_proc(endonentities, endonmessages);
  } else {
    endonentities[0] waittill(endonmessages[0]);
  }

  self.fadeout = 1;
  self notify("\x0f\xc8\xa17\xfd4\xac,C\xb1~wO\xfc\xe1*\x9b");
}

function destroy_hint_on_endon_proc(endonentities, endonmessages) {
  if(!isarray(endonentities)) {
    endonentities = [endonentities];
  }

  if(!isarray(endonmessages)) {
    endonmessages = [endonmessages];
  }

  foreach(entity in endonentities) {
    foreach(message in endonmessages) {
      entity endon(message);
    }
  }

  level waittill(")\xb0\x16\xd5YF\xae");
}

function hint_stick_get_updated(base_hint, pc_suffix, gamepad_suffix, var_a052e51956db3763, var_de2724b308c90ba, var_cf4e45807f6fcdd8, var_30166e1f9ca0e74d) {
  return base_hint + _hint_stick_get_config_suffix(pc_suffix, gamepad_suffix, var_a052e51956db3763, var_de2724b308c90ba, var_cf4e45807f6fcdd8, var_30166e1f9ca0e74d);
}

function _hint_stick_get_config_suffix(pc_suffix, gamepad_suffix, var_a052e51956db3763, var_de2724b308c90ba, var_cf4e45807f6fcdd8, var_30166e1f9ca0e74d) {
  config = getsticksconfig();

  if(level.player utility::is_player_gamepad_enabled()) {
    if(level.player isps4player()) {
      if(issubstr(config, "x\xeffu\x14\a\xe2'") || var_30166e1f9ca0e74d && issubstr(config, "\x8f\x99&\x97\x88\xc3")) {
        return var_cf4e45807f6fcdd8;
      } else {
        return var_de2724b308c90ba;
      }
    } else if(issubstr(config, "x\xeffu\x14\a\xe2'") || var_30166e1f9ca0e74d && issubstr(config, "\x8f\x99&\x97\x88\xc3")) {
      return var_a052e51956db3763;
    } else {
      return gamepad_suffix;
    }

    return;
  }

  return pc_suffix;
}

function _hint_stick_update_breakfunc(config, base_hint) {
  var_f1bbd301097bf148 = base_hint + config;
  breakfunc = level.trigger_hint_func[var_f1bbd301097bf148];
  level.hint_breakfunc = breakfunc;
}

function _hint_stick_update_string(config, base_hint) {
  var_f1bbd301097bf148 = base_hint + config;
  locstrng = level.trigger_hint_string[var_f1bbd301097bf148];
  player = utility_sp::get_player_from_self();
  player sethudtutorialmessage(locstrng);
}

function hint_stick_update(base_hint, pc_suffix, gamepad_suffix, var_a052e51956db3763, var_de2724b308c90ba, var_cf4e45807f6fcdd8, var_30166e1f9ca0e74d) {
  level notify("\xc7\xe0\x97f>\xff\x197Q\xadE\xe2\x93\xed\xd5\x16\x8d\xfb");
  level endon("\xc7\xe0\x97f>\xff\x197Q\xadE\xe2\x93\xed\xd5\x16\x8d\xfb");
  config = _hint_stick_get_config_suffix(pc_suffix, gamepad_suffix, var_a052e51956db3763, var_de2724b308c90ba, var_cf4e45807f6fcdd8, var_30166e1f9ca0e74d);

  while(isDefined(level.current_hint_active) && level.current_hint_active) {
    new_config = _hint_stick_get_config_suffix(pc_suffix, gamepad_suffix, var_a052e51956db3763, var_de2724b308c90ba, var_cf4e45807f6fcdd8, var_30166e1f9ca0e74d);

    if(new_config != config) {
      config = new_config;
      _hint_stick_update_breakfunc(config, base_hint);
      _hint_stick_update_string(config, base_hint);
    }

    waitframe();
  }
}

function hintprint(string, breakfunc, timeout, mintime, hintstate, endonentities, endonmessages) {
  self notify("\x9e\vH\xbePGv[");

  if(getdvarint(@ "hash_76af6bc866243118") > 0) {
    return;
  }

  start_time = gettime();

  if(!isDefined(mintime)) {
    mintime = 0;
  }

  assert(isPlayer(self));

  if(!isalive(self)) {
    return;
  }

  utility::function_18e9f1084badc1c7("\xfb\x17rZ%\xbb\x0f^N\xfb\x81\x1ci2\xd9\xda\xa63");

  if(isDefined(self.current_global_hint)) {
    if(self.current_global_hint == string) {
      return;
    } else {
      self.current_global_hint = string;
      utility::ent_flag_set("\xfb\x17rZ%\xbb\x0f^N\xfb\x81\x1ci2\xd9\xda\xa63");
      wait 0.05;
    }
  }

  self.current_global_hint = string;
  utility::ent_flag_set("\xfb\x17rZ%\xbb\x0f^N\xfb\x81\x1ci2\xd9\xda\xa63");
  level.current_hint_active = 1;
  level.hint_breakfunc = breakfunc;
  level endon("\xc9\x95c\x92\xe0d\xf6C2t3(\xa4^\t{\xe2\xf6\x9d\xcfO\x80\x9b\"\x02");

  if(!isDefined(hintstate)) {
    hintstate = 1;
  }

  self sethudtutorialmessage(string, hintstate);
  active_hint = spawnStruct();
  active_hint.fadeout = 0;

  if(isDefined(timeout)) {
    active_hint thread hint_timeout(timeout);
  }

  active_hint thread destroy_hint_on_friendlyfire();
  active_hint thread destroy_hint_on_player_death();

  if(isDefined(endonentities) && isDefined(endonmessages)) {
    active_hint thread destroy_hint_on_endon(endonentities, endonmessages);
  }

  active_hint hintprintbreakout(string, self);

  if(!istrue(active_hint.fadeout)) {
    self clearhudtutorialmessage(1);
  }

  utility_sp::wait_for_buffer_time_to_pass(start_time, mintime);
  active_hint notify("9ek\xbd\xceZ\xe6v_4-\x9b\xe8");
  self.current_global_hint = undefined;

  if(active_hint.fadeout) {
    self clearhudtutorialmessage();
  }

  level.current_hint_active = 0;
  utility::ent_flag_clear("\xfb\x17rZ%\xbb\x0f^N\xfb\x81\x1ci2\xd9\xda\xa63");
}

function destroy_hint_on_friendlyfire(hint) {
  self endon("9ek\xbd\xceZ\xe6v_4-\x9b\xe8");
  level waittill("\xc9\x95c\x92\xe0d\xf6C2t3(\xa4^\t{\xe2\xf6\x9d\xcfO\x80\x9b\"\x02");
  self.fadeout = 1;
  self notify("\x0f\xc8\xa17\xfd4\xac,C\xb1~wO\xfc\xe1*\x9b");
}

function destroy_hint_on_player_death(hint) {
  self endon("9ek\xbd\xceZ\xe6v_4-\x9b\xe8");
  level.player waittill("\x1e\xfd\xd1\xa2\a");
  self.fadeout = 1;
  self notify("\x0f\xc8\xa17\xfd4\xac,C\xb1~wO\xfc\xe1*\x9b");
}

function function_stack_wait(localentity) {
  self endon("\x1e\xfd\xd1\xa2\a");
  localentity utility::waittill_any("\x85X\x90r\xce>;\xba^dP\xd7\xce", "\x1e\xfd\xd1\xa2\a");
}

function function_stack_wait_finish(localentity) {
  function_stack_wait(localentity);

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

function function_stack_proc(caller, func, varargcount, vararg) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(caller.function_stack)) {
    caller.function_stack = [];
  }

  caller.function_stack[caller.function_stack.size] = self;
  thread function_stack_self_death(caller);
  function_stack_caller_waits_for_turn(caller);

  if(isDefined(caller) && isDefined(caller.function_stack)) {
    self.function_stack_func_begun = 1;
    self notify("tGC|T\r\x7fa_\x13`\x8b|\x8c\x0f\xf7\xc4\xa1#\xef.Sk\x98{");
    caller[[func]](flat_args(vararg, varargcount));

    if(isDefined(caller) && isDefined(caller.function_stack)) {
      caller.function_stack = arrayremove(caller.function_stack, self);
      caller notify("\xef\xe2\xf3E\x0f\xa01V\xc5\xfbwI\xc1\x17\xe4\x95\x99x\xc4\x8d\xca2\xff\xb2-]");
    }
  }

  if(isDefined(self)) {
    self.function_stack_func_begun = 0;
    self notify("\x85X\x90r\xce>;\xba^dP\xd7\xce");
  }
}

function function_stack_self_death(caller) {
  self endon("\x85X\x90r\xce>;\xba^dP\xd7\xce");
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(isDefined(caller)) {
    caller.function_stack = arrayremove(caller.function_stack, self);
    caller notify("\xef\xe2\xf3E\x0f\xa01V\xc5\xfbwI\xc1\x17\xe4\x95\x99x\xc4\x8d\xca2\xff\xb2-]");
  }
}

function function_stack_caller_waits_for_turn(caller) {
  caller endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1e\xfd\xd1\xa2\a");
  caller endon("~%\xe2g\xa9\x06\xa5\xf7%G\xf7wA1:\xed\xc6\xfa\x04)");

  while(caller.function_stack[0] != self) {
    caller waittill("\xef\xe2\xf3E\x0f\xa01V\xc5\xfbwI\xc1\x17\xe4\x95\x99x\xc4\x8d\xca2\xff\xb2-]");
  }
}

function array_waitlogic1(ent, msg, timeout) {
  array_waitlogic2(ent, msg, timeout);
  self._array_wait = 0;
  self notify("\b>g$Z\x0f'\t\xd0\x7fK");
}

function array_waitlogic2(ent, msg, timeout) {
  ent endon(msg);
  ent endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(timeout)) {
    wait timeout;
    return;
  }

  ent waittill(msg);
}

function exec_call(func) {
  func.caller builtin[[func.func]](flat_args(func.parms, func.parmscount));
}

function exec_call_noself(func) {
  builtin[[func.func]](flat_args(func.parms, func.parmscount));
}

function exec_func(func, endons) {
  if(!isDefined(func.caller)) {
    return;
  }

  for(i = 0; i < endons.size; i++) {
    endons[i].caller endon(endons[i].ender);
  }

  func.caller[[func.func]](flat_args(func.parms, func.parmscount));
}

function waittill_func_ends(func, endons) {
  self endon("\x17\xf7\xa28\x06\xb4\\H`\x86/\xf1-\xf2#");
  self endon("\x95*m(mje|\x1e,\x9c\\\x0f\xac\xd8LU");
  exec_func(func, endons);
  self.count--;
  self notify("\xcc\xd57\xc6\xd7\xac\xb9F\xca2");
}

function waittill_abort_func_ends(func, endons) {
  self endon("\x17\xf7\xa28\x06\xb4\\H`\x86/\xf1-\xf2#");
  self endon("\x95*m(mje|\x1e,\x9c\\\x0f\xac\xd8LU");
  exec_func(func, endons);
  self.abort_count--;
  self notify(",\x89\xf6't\xd7\xccWnc\xf5\xacn\x8c\xcad");
}

function do_abort(array) {
  self endon("\x17\xf7\xa28\x06\xb4\\H`\x86/\xf1-\xf2#");

  if(!array.size) {
    return;
  }

  var_8330474cba580c21 = 0;
  self.abort_count = array.size;
  endons = [];
  utility::array_levelthread(array, &waittill_abort_func_ends, endons);

  for(;;) {
    if(self.abort_count <= var_8330474cba580c21) {
      break;
    }

    self waittill(",\x89\xf6't\xd7\xccWnc\xf5\xacn\x8c\xcad");
  }

  self notify("\x95*m(mje|\x1e,\x9c\\\x0f\xac\xd8LU");
}

function translate_local_on_ent(entity) {
  if(isDefined(self.forward)) {
    forward = anglesToForward(entity.angles);
    entity.origin += forward * self.forward;
  }

  if(isDefined(self.right)) {
    right = anglestoright(entity.angles);
    entity.origin += right * self.right;
  }

  if(isDefined(self.up)) {
    up = anglestoup(entity.angles);
    entity.origin += up * self.up;
  }

  if(isDefined(self.yaw)) {
    entity addyaw(self.yaw);
  }

  if(isDefined(self.pitch)) {
    entity addpitch(self.pitch);
  }

  if(isDefined(self.roll)) {
    entity addroll(self.roll);
  }
}

function dynamic_run_speed_thread(followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("E\xb1em\\W\xc4zQ\x1f\x8cY\x9f07\xbb\as4r\xe8\xbb");
  followent endon("\x1e\xfd\xd1\xa2\a");
  scale = 1;
  dir = anglesToForward(self.angles);
  self.dynamicrunspeedwait = 0;

  while(true) {
    goalpos = dynamic_run_speed_goalpos();

    if(distancesquared(goalpos, self.origin) > 0) {
      if(getdvarint(@ "hash_c459efa5216607ee")) {
        line(self.origin, goalpos, (0.9, 0.9, 0.9));
        print3d(goalpos, "<dev string:x78>", (0.9, 0.9, 0.9), 0.9, 0.4);
      }

      goalpos2d = utility::flat_origin(goalpos);
      origin2d = utility::flat_origin(self.origin);

      if(distancesquared(goalpos2d, origin2d) > 100) {
        dir = vectorNormalize(goalpos2d - origin2d);
      }

      midpos = self.origin + dir * middist;
      relativedir = vectorNormalize(followent.origin - midpos);
      dot = vectordot(relativedir, dir);

      if(dot > 0) {
        dynamic_run_speed_set(followent, frontdist, middist, dir, maxspeed, midspeed, 0);
      } else {
        dynamic_run_speed_set(followent, middist, backdist, dir, midspeed, minspeed, 1);
      }
    }

    waitframe();
  }
}

function dynamic_run_speed_set(followent, forwarddist, backdist, dir, maxspeed, minspeed, isbehind) {
  debugangles = vectortoangles(dir);
  debugright = anglestoright(debugangles);
  forwardpos = self.origin + dir * forwarddist;
  backpos = self.origin + dir * backdist;
  playerpos = pointonsegmentnearesttopoint(forwardpos, backpos, followent.origin);
  dist = distance(forwardpos, playerpos);
  totaldist = forwarddist - backdist;
  scale = 1 - math::lerp_fraction(0, abs(totaldist), dist);
  speed = math::lerp(minspeed, maxspeed, scale);
  speed = clamp(speed, 23, 250);
  stopspeed = 30;
  minmovespeed = stopspeed + 1;

  if(isbehind && speed <= stopspeed) {
    if(!istrue(self.dynamicrunspeedwait)) {
      utility::set_movement_speed(0);
      self.dynamicrunspeedwait = 1;
    }
  } else if(speed >= minmovespeed) {
    if(istrue(self.dynamicrunspeedwait)) {
      self notify("e\xbb\xe6j\xce 3\xc7\xb6; 3JO\r\x7fm\x8f\x8d`\xc6 0\xe1");
      self.dynamicrunspeedwait = undefined;
    }

    if(istrue(self.var_d97cce39056b9d62)) {
      if(speed <= stopspeed) {
        if(!istrue(self.var_3b43342c8e4acafd)) {
          self.var_3b43342c8e4acafd = gettime() + 800;
        }

        speed = 0;
      }

      if(istrue(self.var_3b43342c8e4acafd)) {
        if(gettime() <= self.var_3b43342c8e4acafd) {
          speed = 0;
        } else {
          self.var_3b43342c8e4acafd = undefined;
        }
      }
    }

    utility::set_movement_speed(speed);
  }

  if(getdvarint(@ "hash_c459efa5216607ee")) {
    line(forwardpos + debugright * 100, forwardpos + debugright * -100, (0.9, 0.9, 0));
    line(backpos + debugright * 100, backpos + debugright * -100, (0.9, 0.9, 0));
    line(followent.origin, playerpos);
    print3d(playerpos + (0, 0, -4), speed, (0.9, 0.9, 0.9), 0.9, 0.4);
  }
}

function dynamic_run_speed_goalpos() {
  goalpos = undefined;

  if(isDefined(self.follow_ent)) {
    goalpos = self.follow_ent.origin;
  } else if(isDefined(self.goalnode)) {
    goalpos = self.goalnode.origin;
  } else {
    goalpos = self.scriptgoalpos;
  }

  return goalpos;
}

function g_speed_get_func(null) {
  return int(getDvar(@ "g_speed"));
}

function g_speed_set_func(goalspeed, null) {
  setsaveddvar(@ "g_speed", int(goalspeed));
}

function g_bob_scale_get_func(null) {
  return level.player getbobrate();
}

function g_bob_scale_set_func(goalscale, null) {
  level.player setbobrate(goalscale);
}

function movespeed_get_func(channel) {
  if(!isDefined(channel)) {
    channel = "\x91\xca\xcc\v\xab\xd8:";
  }

  if(!(isDefined(self.movespeedscales) && isDefined(self.movespeedscales[channel]))) {
    return 1;
  }

  return self.movespeedscales[channel];
}

function movespeed_set_func(scale, channel) {
  finalscale = 1;

  if(!isDefined(channel)) {
    channel = "\x91\xca\xcc\v\xab\xd8:";
  }

  self.movespeedscales[channel] = scale;

  foreach(scale in self.movespeedscales) {
    if(scale == 1) {
      self.movespeedscales = utility::array_remove_key(self.movespeedscales, key);
    }

    finalscale *= scale;
  }

  self.movespeedscale = finalscale;

  if(self.movespeedscale == 1) {
    val::reset_all("\r\xc8\xf4a\xf3\xd8\xae\a4\xfcvBa\x99I\xf7\xee\xa8");
    return;
  }

  val::set("\r\xc8\xf4a\xf3\xd8\xae\a4\xfcvBa\x99I\xf7\xee\xa8", "\ny\xb3\x0f\xed\xf447XI\xfa\xe70x\t\xbf", self.movespeedscale);
}

function autosave_tactical_setup() {
  if(utility::flag_exist("\x03\xefp\xa6\"h\xde\x912\xf6\xc5C\xfe\"\x10\x1aR\xde1\x9638\xd2w\xa8g\x9b\xab\x12")) {
    return;
  }

  utility::flag_init("\x03\xefp\xa6\"h\xde\x912\xf6\xc5C\xfe\"\x10\x1aR\xde1\x9638\xd2w\xa8g\x9b\xab\x12");
  level.autosave_tactical_player_nades = 0;
  notifyoncommand("\xcf\\+\xaa\xac,\xe0\xf1=\xd9B\np\xad:\xe5\xb1,\xb0\xbc", "n-\xa2\xff\xb9");
  notifyoncommand("\xcf\\+\xaa\xac,\xe0\xf1=\xd9B\np\xad:\xe5\xb1,\xb0\xbc", "K\x9b5GR\xf2");
  notifyoncommand("\xcf\\+\xaa\xac,\xe0\xf1=\xd9B\np\xad:\xe5\xb1,\xb0\xbc", "?s\x87\xf6\xa0\xc0");
  utility::array_thread(level.players, &autosave_tactical_grenade_check);
}

function autosave_tactical_grenade_check() {
  while(true) {
    self waittill("\xcf\\+\xaa\xac,\xe0\xf1=\xd9B\np\xad:\xe5\xb1,\xb0\xbc");
    utility::flag_set("\x03\xefp\xa6\"h\xde\x912\xf6\xc5C\xfe\"\x10\x1aR\xde1\x9638\xd2w\xa8g\x9b\xab\x12");
    thread autosave_tactical_grenade_check_wait_throw();
    utility::waittill_any_timeout(10, "\xba\xd4GqaR{\xe5\xb8/\xf4\xbc\x11\x1c\xfb+\xc5\x96\x9f\x82\xd9eN");
    self notify("cx\xa9l<u\xb5\x9b\xfe\xae\x9fkL\xcc>\x9bv+\x01#l~\x9f\xb2\xc6WU(\x89\x12");
    autosave_tactical_nade_flag_clear();
  }
}

function autosave_tactical_grenade_check_wait_throw() {
  self endon("cx\xa9l<u\xb5\x9b\xfe\xae\x9fkL\xcc>\x9bv+\x01#l~\x9f\xb2\xc6WU(\x89\x12");
  self waittill("\xe0\x99\xc7\xf1\a3\x81c\xa5\xe17G", grenade);
  thread autosave_tactical_grenade_check_dieout(grenade);
  self notify("\xba\xd4GqaR{\xe5\xb8/\xf4\xbc\x11\x1c\xfb+\xc5\x96\x9f\x82\xd9eN");
}

function autosave_tactical_nade_flag_clear() {
  waittillframeend();

  if(!level.autosave_tactical_player_nades) {
    utility::flag_clear("\x03\xefp\xa6\"h\xde\x912\xf6\xc5C\xfe\"\x10\x1aR\xde1\x9638\xd2w\xa8g\x9b\xab\x12");
  }
}

function autosave_tactical_grenade_check_dieout(grenade) {
  level.autosave_tactical_player_nades++;
  grenade utility::waittill_notify_or_timeout("\x1e\xfd\xd1\xa2\a", 10);
  level.autosave_tactical_player_nades--;
  autosave_tactical_nade_flag_clear();
}

function autosave_tactical_proc() {
  level notify("\x0e\x9d\t\x11\x9c\xd5\xdex\xeb\xbc2=L$G\x94\xe3T\x8ep\b\xe2");
  level endon("\x0e\x9d\t\x11\x9c\xd5\xdex\xeb\xbc2=L$G\x94\xe3T\x8ep\b\xe2");
  level thread utility_sp::notify_delay("\xf5\x03x;\xe2\xbd\xcf\v\xc7", 5);
  level endon("\xf5\x03x;\xe2\xbd\xcf\v\xc7");
  level endon("\x03\xefp\xa6\"h\xde\x912\xf6\xc5C\xfe\"\x10\x1aR\xde1\x9638\xd2w\xa8g\x9b\xab\x12");

  if(utility::flag("\x03\xefp\xa6\"h\xde\x912\xf6\xc5C\xfe\"\x10\x1aR\xde1\x9638\xd2w\xa8g\x9b\xab\x12")) {
    utility::flag_waitopen_or_timeout("\x03\xefp\xa6\"h\xde\x912\xf6\xc5C\xfe\"\x10\x1aR\xde1\x9638\xd2w\xa8g\x9b\xab\x12", 4);

    if(utility::flag("\x03\xefp\xa6\"h\xde\x912\xf6\xc5C\xfe\"\x10\x1aR\xde1\x9638\xd2w\xa8g\x9b\xab\x12")) {
      return;
    }
  }

  enemies = getaiarray("?\xb1\xc0\x9a");

  foreach(ai in enemies) {
    if(isDefined(ai.enemy) && isPlayer(ai.enemy)) {
      return;
    }
  }

  waittillframeend();
  utility_sp::autosave_by_name();
}

function kill_deathflag_proc(time) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(time)) {
    wait randomfloat(time);
  }

  playFXOnTag(utility::getfx("\xf6\x1e\x90\x1f\xa4\xd1>/O"), self, "\xc7\xae?f\x10\xbcr");
  self kill(level.player.origin);
}

function update_rumble_intensity(player, rumble) {
  self endon("\x1e\xfd\xd1\xa2\a");
  rumble_playing = 0;

  for(;;) {
    if(self.intensity > 0.0001 && gettime() > 300) {
      if(!rumble_playing) {
        self playrumblelooponentity(rumble);
        rumble_playing = 1;
      }
    } else if(rumble_playing) {
      self stoprumble(rumble);
      rumble_playing = 0;
    }

    height = 1 - self.intensity;
    height *= 1000;
    self.origin = player getEye() + (0, 0, height);
    wait 0.05;
  }
}

function process_blend(func, caller, var1, var2, var3) {
  waittillframeend();
  assert(isDefined(self.time), "<dev string:x80>");

  if(!isDefined(self.start)) {
    self.start = 0;
  }

  if(!isDefined(self.end)) {
    self.end = 1;
  }

  if(!isDefined(self.base)) {
    self.base = 0;
  }

  frames = self.time * 20;
  range = self.end - self.start;
  self.stop_blend = 0;

  if(isDefined(var3)) {
    for(i = 0; i <= frames && !self.stop_blend; i++) {
      value = self.base + i * range / frames;
      caller thread[[func]](value, var1, var2, var3);
      wait 0.05;
    }

    return;
  }

  if(isDefined(var2)) {
    for(i = 0; i <= frames && !self.stop_blend; i++) {
      value = self.base + i * range / frames;
      caller thread[[func]](value, var1, var2);
      wait 0.05;
    }

    return;
  }

  if(isDefined(var1)) {
    for(i = 0; i <= frames && !self.stop_blend; i++) {
      value = self.base + i * range / frames;
      caller thread[[func]](value, var1);
      wait 0.05;
    }

    return;
  }

  for(i = 0; i <= frames && !self.stop_blend; i++) {
    value = self.base + i * range / frames;
    caller thread[[func]](value);
    wait 0.05;
  }
}

function get_color_info_from_trigger() {
  if(isDefined(self.script_color_allies)) {
    assert(!isDefined(self.script_color_axis), "<dev string:xbb>");
  } else if(isDefined(self.script_color_axis)) {
    assert(!isDefined(self.script_color_allies), "<dev string:xbb>");
  } else {
    assertmsg("<dev string:xda>");
  }

  team = "O\x15\x1b\xad\x9ff";

  if(isDefined(self.script_color_axis)) {
    team = "?\xb1\xc0\x9a";
  }

  team = colors::get_team(team);
  colorcodes = [];

  if(team == "O\x15\x1b\xad\x9ff") {
    array = colors::get_colorcodes_from_trigger(self.script_color_allies, "O\x15\x1b\xad\x9ff");
    colorcodes = array["\xe6=\xc8 4hw\x03\x9b\v"];
  } else {
    array = colors::get_colorcodes_from_trigger(self.script_color_axis, "?\xb1\xc0\x9a");
    colorcodes = array["\xe6=\xc8 4hw\x03\x9b\v"];
  }

  assert(colorcodes.size, "<dev string:xff>");
  info = [];
  info["\x03\x94=b"] = team;
  info["l\xbdFVs"] = colorcodes;
  return info;
}

function delaychildthread_proc(func, timer, varargcount, vararg) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xc2\xc1r\xd8\xf1J'\tm1\xe3y\xde\t\xed#K");
  wait timer;
  childthread[[func]](flat_args(vararg, varargcount));
}

function flagwaitthread_proc(func, flag, varargcount, vararg) {
  self endon("\x1e\xfd\xd1\xa2\a");
  utility::flag_wait(flag[0]);
  utility::delaythread(flag[1], func, flat_args(vararg, varargcount));
}

function waittillthread_proc(func, note, varargcount, vararg) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill(note[0]);
  utility::delaythread(note[1], func, flat_args(vararg, varargcount));
}

function add_wait_asserter() {
  level notify("\xd7d\x16\n~Hq\\:\xc7\xdf\x8a\xb9O\xe7\\\x86i\x8c\xcd\xd9A");
  level endon("\xd7d\x16\n~Hq\\:\xc7\xdf\x8a\xb9O\xe7\\\x86i\x8c\xcd\xd9A");

  for(i = 0; i < 20; i++) {
    waittillframeend();
  }

  assertmsg("<dev string:x136>");
}

function update_battlechatter_hud() {
  if(getDvar(@ "loc_warnings", 0) == "<dev string:x173>") {
    return;
  }

  if(getDvar(@ "hash_2f6380dc3031a0fc") != "<dev string:x178>") {
    return;
  }

  if(!isDefined(level.bcs_hud)) {
    x = -50;
    y = 460;
    x_offset = 22;
    hud = newhudelem();
    hud.x = x;
    hud.y = y;
    hud.color = (0.4, 0.55, 0.9);
    level.bcs_hud = hud;
  }

  if(getDvar(@ "debug_battlechatter") != "<dev string:x17c>") {
    level.bcs_hud settext("<dev string:x178>");
    return;
  }

  msg = "<dev string:x182>";
  count = 0;

  if(isDefined(level.battlechatter)) {
    teams = [];
    teams["<dev string:x19d>"] = level.battlechatter["<dev string:x19d>"];
    teams["<dev string:x1a7>"] = level.battlechatter["<dev string:x1a7>"];

    foreach(val in teams) {
      if(val) {
        msg = msg + team + "<dev string:x1af>";
        count++;
      }
    }
  } else {
    msg += "<dev string:x1b4>";
    count++;
  }

  if(count == 0) {
    msg += "<dev string:x1d7>";
  }

  level.bcs_hud settext(msg);
}

function comparesizesfx(org, array, dist, comparefunc) {
  if(!array.size) {
    return undefined;
  }

  if(isDefined(dist)) {
    struct = undefined;
    keys = getarraykeys(array);

    for(i = 0; i < keys.size; i++) {
      newdist = distance(array[keys[i]].v["\xb0$R\x8b\xc9\x17"], org);

      if([[comparefunc]](newdist, dist)) {
        continue;
      }

      dist = newdist;
      struct = array[keys[i]];
    }

    return struct;
  }

  keys = getarraykeys(array);
  struct = array[keys[0]];
  dist = distance(struct.v["\xb0$R\x8b\xc9\x17"], org);

  for(i = 1; i < keys.size; i++) {
    newdist = distance(array[keys[i]].v["\xb0$R\x8b\xc9\x17"], org);

    if([[comparefunc]](newdist, dist)) {
      continue;
    }

    dist = newdist;
    struct = array[keys[i]];
  }

  return struct;
}

function waittill_triggered_current() {
  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>", other);
    waittillframeend();

    if(other.currentnode == self) {
      return other;
    }
  }
}

function add_trigger_func_thread() {
  self.trigger_functions = [];
  self waittill("\x91`\xb1\xe7T\x97>", other);
  trigger_functions = self.trigger_functions;
  self.trigger_functions = undefined;

  foreach(function in trigger_functions) {
    thread[[function]](other);
  }
}

function function_61b57876517c1c55() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.var_e291e4ca3d7215ab = [];

  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>", other);

    foreach(function in self.var_e291e4ca3d7215ab) {
      thread[[function]](other);
    }
  }
}

function add_to_radio(dialogue) {
  if(!isDefined(level.scr_radio[dialogue])) {
    level.scr_radio[dialogue] = dialogue;
  }
}

function add_to_player_dialogue(dialogue) {
  if(!isDefined(level.scr_plrdialogue[dialogue])) {
    level.scr_plrdialogue[dialogue] = dialogue;
  }
}

function add_to_dialogue(dialogue) {
  if(!isDefined(level.scr_anim[self.animname])) {
    level.scr_anim[self.animname] = [];
  }

  if(!isDefined(level.scr_sound[self.animname])) {
    level.scr_sound[self.animname] = [];
  }

  if(!isDefined(level.scr_sound[self.animname][dialogue])) {
    level.scr_sound[self.animname][dialogue] = dialogue;
  }
}

function add_to_dialogue_generic(dialogue) {
  if(!isDefined(level.scr_sound["RF\x9e\xe1\xc4\x1f\xe7"])) {
    level.scr_sound["RF\x9e\xe1\xc4\x1f\xe7"] = [];
  }

  if(!isDefined(level.scr_sound["RF\x9e\xe1\xc4\x1f\xe7"][dialogue])) {
    level.scr_sound["RF\x9e\xe1\xc4\x1f\xe7"][dialogue] = dialogue;
  }
}

function _flag_wait_trigger(message, continuous) {
  self endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    self waittill("\x91`\xb1\xe7T\x97>", other);
    utility::flag_set(message);

    if(!continuous) {
      return;
    }

    while(other istouching(self)) {
      wait 0.05;
    }

    utility::flag_clear(message);
  }
}

function fx_volume_pause(volume, dodelayed) {
  assert(isDefined(volume));
  volume.fx_paused = 1;

  if(!isDefined(dodelayed)) {
    dodelayed = 0;
  }

  if(dodelayed) {
    array_thread_mod_delayed(volume.fx, &utility::pauseeffect);
    return;
  }

  utility::array_thread(volume.fx, &utility::pauseeffect);
}

function array_thread_mod_delayed(array, threadname, mod) {
  inc = 0;

  if(!isDefined(mod)) {
    mod = 5;
  }

  send_array = [];

  foreach(object in array) {
    send_array[send_array.size] = object;
    inc++;
    inc %= mod;

    if(mod == 0) {
      utility::array_thread(send_array, threadname);
      wait 0.05;
      send_array = [];
    }
  }
}

function set_flag_on_spawned(spawners, strflag) {
  thread utility_sp::set_flag_on_func_wait_proc(spawners, strflag, &utility::empty_init_func, "\x17\"a\xef\xf5\xa21\xfd\xf7\xdc\x04R>/\t4E?U");
}

function endondeath() {
  self waittill("\x1e\xfd\xd1\xa2\a");
  waittillframeend();
  self notify("\x13,S#\xb1d\nC\x83~\xa8");
}

function waittill_dead_thread(ent) {
  self waittill("\x1e\xfd\xd1\xa2\a");
  ent.count--;
  ent notify("N\xe85\xf06l}\xcbz\x98\xa3\r\xf6\x88\xf4\xc5\xfd\xe4\x89\x9e\x1d>");
}

function waittill_dead_or_dying_thread(ent) {
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "*\xeb\x7f!\xa4\xb9\xe6/\xcf\a", "w\xc7\xe5\xd8\x84\x87\x9b\xac\xfbGF\x1b\xd4");
  ent.count--;
  ent notify("\xc0\x95!B\xb6=\xc9\x0e\n\xb1<b\x0f\xe12\x8fQ0\xe7\xa9`S\x87a\xe3\xfd\xd5z\x8e\x8a\xd6");
}

function waittill_dead_timeout(timeoutlength) {
  wait timeoutlength;
  self notify("X\xb0nG\xc1]\xc3\x15\xfdR\x15\x99\x16\x968\xb8");
}

function scripter_note_proc(str, duration) {
  if(getdvarint(@ "hash_8496c6305e4b772") == 0 || getdvarint(@ "hash_72b7da075887f96f") == 1) {
    return;
  }

  if(!isDefined(duration)) {
    duration = 5;
  }

  level notify("#\x15(\xda\a\xccgO\xb9\x10ks\x8a\xea\x9a\xdbu");

  if(!isDefined(level.scripternote)) {
    level.scripternote = spawnStruct();
    level.scripternote.width = 200;
  }

  if(!isDefined(level.scripternote.notes)) {
    level.scripternote.notes = [];
  }

  if(level.scripternote.notes.size == 5) {
    oldhud = level.scripternote.notes[0];
    level.scripternote.notes = utility::array_remove_index(level.scripternote.notes, 0);
    update_scripternote_huds();
    oldhud thread destroy_scripternote();
  }

  if(!isDefined(level.scripternote.bg)) {
    bg = newhudelem();
    bg.destroying = 0;
    level.scripternote.intro = 1;
    bg.alpha = 0.7;
    bg setshader("\x8a-\v\xa1\xbd", level.scripternote.width, 50);
    title = newhudelem();
    title settext("%)\xc1\xfb");
    level.scripternote.bg = bg;
    level.scripternote.title = title;
    array = [bg, title];

    foreach(hud in array) {
      hud.alignx = "=\xff0b";
      hud.aligny = "\x1d Q";
      hud.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
      hud.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
      hud.x = -200;
      hud.y = 120;
      hud moveovertime(0.2);
      hud.x = 0;
    }

    wait 0.3;
    level.scripternote.intro = 0;
    level.scripternote notify("\x82\x03@.\x95\x88p\xc9\xc0\xd1");
  } else {
    bg = level.scripternote.bg;
    bg.alpha = 0.7;
    title = level.scripternote.title;
    title.alpha = 1;
  }

  if(level.scripternote.intro) {
    level.scripternote waittill("\x82\x03@.\x95\x88p\xc9\xc0\xd1");
  }

  note = newhudelem();
  index = level.scripternote.notes.size;
  note.fontscale = 1;
  note.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  note.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  note.x = 20;
  note.y = 140 + index * 12;
  note.width = 0;
  note.text = str;
  note settext(str);
  level.scripternote.notes[index] = note;
  update_scripternote_width();
  level.scripternote.bg scaleovertime(0.2, level.scripternote.width, 50 + (level.scripternote.notes.size - 1) * 10);
  note.alpha = 0;
  note fadeovertime(0.2);
  note.alpha = 1;
  note endon("\x1e\xfd\xd1\xa2\a");
  update_scripternote_huds();
  wait duration;
  note thread destroy_scripternote();
}

function update_scripternote_width() {
  width = 200;
  count = 0;

  foreach(n in level.scripternote.notes) {
    if(n.text.size > count) {
      count = n.text.size;
      width = n.text.size * 6;
    }
  }

  if(width < 200) {
    level.scripternote.width = 200;
    return;
  }

  level.scripternote.width = width;
}

function destroy_scripternote() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(level.scripternote.notes.size == 1) {
    level thread destroy_scripternote_bg();
  }

  level.scripternote.notes = arrayremove(level.scripternote.notes, self);
  update_scripternote_huds();
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y -= 12;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function destroy_scripternote_bg() {
  level endon("#\x15(\xda\a\xccgO\xb9\x10ks\x8a\xea\x9a\xdbu");
  level.scripternote.bg.destroying = 1;
  huds = [level.scripternote.bg, level.scripternote.title];

  foreach(hud in huds) {
    hud fadeovertime(0.2);
    hud.alpha = 0;
  }

  wait 0.2;

  foreach(hud in huds) {
    hud destroy();
  }
}

function update_scripternote_huds() {
  foreach(hud in level.scripternote.notes) {
    hud moveovertime(0.2);
    hud.y = 140 + index * 12;
  }

  update_scripternote_width();
  level.scripternote.bg scaleovertime(0.2, level.scripternote.width, 50 + (level.scripternote.notes.size - 1) * 10);
}