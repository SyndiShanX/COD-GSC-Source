/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\flag_shared.gsc
***********************************************/

#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;

#namespace flag;

init(str_flag, b_val = 0) {
  if(!isDefined(self.flag)) {
    self.flag = [];
  }

  if(!isDefined(self.flag_count)) {
    self.flag_count = [];
  }

  if(!isDefined(level.first_frame)) {
    assert(!isDefined(self.flag[str_flag]), "<dev string:x38>" + str_flag + "<dev string:x62>");
  }

  self.flag[str_flag] = b_val;
  self.flag_count[str_flag] = 0;
}

exists(str_flag) {
  return isDefined(self.flag) && isDefined(self.flag[str_flag]);
}

set(str_flag) {
  assert(exists(str_flag), "<dev string:x71>" + function_9e72a96(str_flag) + "<dev string:x8e>");
  self.flag[str_flag] = 1;
  self notify(str_flag);
  trigger::set_flag_permissions(str_flag);
}

increment(str_flag) {
  assert(exists(str_flag), "<dev string:xaa>" + function_9e72a96(str_flag) + "<dev string:x8e>");
  self.flag_count[str_flag]++;
  set(str_flag);
}

decrement(str_flag) {
  assert(exists(str_flag), "<dev string:xcd>" + function_9e72a96(str_flag) + "<dev string:x8e>");
  assert(self.flag_count[str_flag] > 0, "<dev string:xf0>");
  self.flag_count[str_flag]--;

  if(self.flag_count[str_flag] == 0) {
    clear(str_flag);
  }
}

delay_set(n_delay, str_flag, str_cancel) {
  self thread _delay_set(n_delay, str_flag, str_cancel);
}

_delay_set(n_delay, str_flag, str_cancel) {
  if(isDefined(str_cancel)) {
    self endon(str_cancel);
  }

  self endon(#"death");
  wait n_delay;
  set(str_flag);
}

set_val(str_flag, b_val) {
  assert(isDefined(b_val), "<dev string:x12f>");

  if(b_val) {
    set(str_flag);
    return;
  }

  clear(str_flag);
}

set_for_time(n_time, str_flag) {
  self notify("__flag::set_for_time__" + str_flag);
  self endon("__flag::set_for_time__" + str_flag);
  set(str_flag);
  wait n_time;
  clear(str_flag);
}

clear(str_flag) {
  assert(exists(str_flag), "<dev string:x15d>" + str_flag + "<dev string:x8e>");

  if(self.flag[str_flag]) {
    self.flag[str_flag] = 0;
    self notify(str_flag);
    trigger::set_flag_permissions(str_flag);
  }
}

toggle(str_flag) {
  if(get(str_flag)) {
    clear(str_flag);
    return;
  }

  set(str_flag);
}

get(str_flag) {
  assert(exists(str_flag), "<dev string:x17c>" + str_flag + "<dev string:x8e>");
  return self.flag[str_flag];
}

get_any(&array) {
  foreach(str_flag in array) {
    if(get(str_flag)) {
      return true;
    }
  }

  return false;
}

get_all(&array) {
  foreach(str_flag in array) {
    if(!get(str_flag)) {
      return false;
    }
  }

  return true;
}

wait_till(str_flag) {
  self endon(#"death");

  while(!get(str_flag)) {
    self waittill(str_flag);
  }
}

wait_till_timeout(n_timeout, str_flag) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till(str_flag);
}

wait_till_all(a_flags) {
  self endon(#"death");

  for(i = 0; i < a_flags.size; i++) {
    str_flag = a_flags[i];

    if(!get(str_flag)) {
      self waittill(str_flag);
      i = -1;
    }
  }
}

wait_till_all_timeout(n_timeout, a_flags) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_all(a_flags);
}

wait_till_any(a_flags) {
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

wait_till_any_timeout(n_timeout, a_flags) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_any(a_flags);
}

wait_till_clear(str_flag) {
  self endon(#"death");

  while(get(str_flag)) {
    self waittill(str_flag);
  }
}

wait_till_clear_timeout(n_timeout, str_flag) {
  self endon(#"death");

  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_clear(str_flag);
}

wait_till_clear_all(a_flags) {
  self endon(#"death");

  for(i = 0; i < a_flags.size; i++) {
    str_flag = a_flags[i];

    if(get(str_flag)) {
      self waittill(str_flag);
      i = -1;
    }
  }
}

function_5f02becb(n_timeout) {
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

wait_till_clear_all_timeout(n_timeout, a_flags) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_clear_all(a_flags);
}

wait_till_clear_any(a_flags) {
  self endon(#"death");

  while(true) {
    foreach(flag in a_flags) {
      if(!get(flag)) {
        return flag;
      }
    }

    self waittill(a_flags);
  }
}

wait_till_clear_any_timeout(n_timeout, a_flags) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  wait_till_clear_any(a_flags);
}

delete(str_flag) {
  if(isDefined(self.flag[str_flag])) {
    self.flag[str_flag] = undefined;
    return;
  }

  println("<dev string:x192>" + str_flag);
}

script_flag_wait() {
  if(isDefined(self.script_flag_wait)) {
    self wait_till(self.script_flag_wait);
    return true;
  }

  return false;
}