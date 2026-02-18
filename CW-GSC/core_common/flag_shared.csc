/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\flag_shared.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace flag;

function init_dvar(str_dvar) {
  util::init_dvar(str_dvar, 0, &function_4a18565a);
}

function private function_4a18565a(params) {
  level set_val(params.name, is_true(int(params.value)));
}

function init(str_flag, b_val = 0) {
  if(!isDefined(self.flag)) {
    self.flag = [];
  }

  if(!isDefined(self.var_491938f6)) {
    self.var_491938f6 = [];
  }

  if(!isDefined(level.first_frame)) {
    assert(!isDefined(self.flag[str_flag]), "<dev string:x38>" + str_flag + "<dev string:x63>");
  }

  self.flag[str_flag] = b_val;
  self.var_491938f6[str_flag] = 1;
}

function exists(str_flag) {
  return isDefined(self.flag) && isDefined(self.flag[str_flag]);
}

function delete(str_flag) {
  if(isDefined(self.var_491938f6) && isDefined(self.var_491938f6[str_flag])) {
    self.var_491938f6[str_flag] = undefined;
  }

  if(isDefined(self.var_491938f6) && self.var_491938f6.size == 0) {
    self.var_491938f6 = undefined;
  }

  clear(str_flag);
}

function delay_set(n_delay, str_flag, str_cancel) {
  self thread _delay_set(n_delay, str_flag, str_cancel);
}

function private _delay_set(n_delay, str_flag, str_cancel) {
  if(isDefined(str_cancel)) {
    self endon(str_cancel);
  }

  self endon(#"death");
  wait n_delay;
  set(str_flag);
}

function set(str_flag) {
  if(!isDefined(self.flag)) {
    self.flag = [];
  }

  self.flag[str_flag] = 1;
  self notify(str_flag);

  if(isDefined(level.var_53af20e)) {
    [[level.var_53af20e]](str_flag);
  }
}

function set_val(str_flag, b_val) {
  assert(isDefined(b_val), "<dev string:x73>");

  if(b_val) {
    set(str_flag);
    return;
  }

  clear(str_flag);
}

function increment(str_flag) {
  if(!isDefined(self.flag_count)) {
    self.flag_count = [];
  }

  if(!isDefined(self.flag_count[str_flag])) {
    self.flag_count[str_flag] = 0;
  }

  self.flag_count[str_flag]++;
  set(str_flag);
}

function decrement(str_flag) {
  assert(isDefined(self.flag_count[str_flag]) && self.flag_count[str_flag] > 0, "<dev string:x9f>");
  self.flag_count[str_flag]--;

  if(self.flag_count[str_flag] == 0) {
    clear(str_flag);
  }
}

function set_for_time(n_time, str_flag) {
  self notify("__flag::set_for_time__" + str_flag);
  self endon("__flag::set_for_time__" + str_flag);
  set(str_flag);
  wait n_time;
  clear(str_flag);
}

function clear(str_flag) {
  if(is_true(self.flag[str_flag])) {
    if(is_true(self.var_491938f6[str_flag])) {
      self.flag[str_flag] = 0;
    } else {
      self.flag[str_flag] = undefined;
    }

    self notify(str_flag);

    if(isDefined(level.var_53af20e)) {
      [[level.var_53af20e]](str_flag);
    }
  }
}

function function_c58ecb49(str_flag) {
  clear(str_flag);

  if(isDefined(self.flag_count[str_flag])) {
    self.flag_count[str_flag] = 0;
  }
}

function toggle(str_flag) {
  set_val(str_flag, !get(str_flag));
}

function get(str_flag) {
  return is_true(self.flag[str_flag]);
}

function get_any(&array) {
  foreach(str_flag in array) {
    if(get(str_flag)) {
      return true;
    }
  }

  return false;
}

function get_all(&array) {
  foreach(str_flag in array) {
    if(!get(str_flag)) {
      return false;
    }
  }

  return true;
}

function wait_till(str_flag) {
  self endon(#"death");

  while(!get(str_flag)) {
    self waittill(str_flag);
  }
}

function wait_till_timeout(n_timeout, str_flag) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till(str_flag);
}

function wait_till_all(a_flags) {
  self endon(#"death");

  for(i = 0; i < a_flags.size; i++) {
    str_flag = a_flags[i];

    if(!get(str_flag)) {
      self waittill(str_flag);
      i = -1;
    }
  }
}

function wait_till_all_timeout(n_timeout, a_flags) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_all(a_flags);
}

function wait_till_any(a_flags) {
  self endon(#"death");

  foreach(flag in a_flags) {
    if(get(flag)) {
      return {
        #_notify: flag
      };
    }
  }

  return self waittill(a_flags);
}

function wait_till_any_timeout(n_timeout, a_flags) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_any(a_flags);
}

function wait_till_clear(str_flag) {
  self endon(#"death");

  while(get(str_flag)) {
    self waittill(str_flag);
  }
}

function wait_till_clear_timeout(n_timeout, str_flag) {
  self endon(#"death");

  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_clear(str_flag);
}

function wait_till_clear_all(a_flags) {
  self endon(#"death");

  for(i = 0; i < a_flags.size; i++) {
    str_flag = a_flags[i];

    if(get(str_flag)) {
      self waittill(str_flag);
      i = -1;
    }
  }
}

function function_4bf6d64f(var_5d544245, var_44bd221) {
  self endon(#"death");

  foreach(flag in var_5d544245) {
    if(get(flag)) {
      return {
        #_notify: flag
      };
    }
  }

  foreach(flag in var_44bd221) {
    if(!get(flag)) {
      return {
        #_notify: flag
      };
    }
  }

  var_b1f5a9d1 = arraycombine(var_5d544245, var_44bd221, 1);
  var_36b86152 = [];

  foreach(flag in var_5d544245) {
    if(!isDefined(var_36b86152)) {
      var_36b86152 = [];
    } else if(!isarray(var_36b86152)) {
      var_36b86152 = array(var_36b86152);
    }

    var_36b86152[var_36b86152.size] = hash(flag);
  }

  var_c50f1f7b = [];

  foreach(flag in var_44bd221) {
    if(!isDefined(var_c50f1f7b)) {
      var_c50f1f7b = [];
    } else if(!isarray(var_c50f1f7b)) {
      var_c50f1f7b = array(var_c50f1f7b);
    }

    var_c50f1f7b[var_c50f1f7b.size] = hash(flag);
  }

  while(true) {
    result = self waittill(var_b1f5a9d1);
    flag = result._notify;

    if(isinarray(var_36b86152, flag) && get(flag)) {
      return {
        #_notify: flag
      };
    }

    if(isinarray(var_c50f1f7b, flag) && !get(flag)) {
      return {
        #_notify: flag
      };
    }
  }
}

function function_5f02becb(n_timeout) {
  if(isDefined(n_timeout) && n_timeout > 0) {
    if(isDefined(n_timeout)) {
      __s = spawnStruct();
      __s endon(#"timeout");
      __s util::delay_notify(n_timeout, "timeout");
    }
  }

  if(isDefined(self.script_flag_true)) {
    var_ed5ed076 = util::create_flags_and_return_tokens(self.script_flag_true);
    level wait_till_all(var_ed5ed076);
  }

  if(isDefined(self.script_flag_false)) {
    var_b1418b4 = util::create_flags_and_return_tokens(self.script_flag_false);
    level wait_till_clear_all(var_b1418b4);
  }
}

function wait_till_clear_all_timeout(n_timeout, a_flags) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_clear_all(a_flags);
}

function wait_till_clear_any(a_flags) {
  self endon(#"death");

  while(true) {
    foreach(flag in a_flags) {
      if(!get(flag)) {
        return {
          #_notify: flag
        };
      }
    }

    return self waittill(a_flags);
  }
}

function wait_till_clear_any_timeout(n_timeout, a_flags) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_clear_any(a_flags);
}

function script_flag_wait() {
  if(isDefined(self.script_flag_wait)) {
    self wait_till(self.script_flag_wait);
    return true;
  }

  return false;
}