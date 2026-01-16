/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\flag_shared.csc
***********************************************/

#include scripts\core_common\util_shared;

#namespace flag;

init(str_flag, b_val = 0, b_is_trigger = 0) {
  if(!isDefined(self.flag)) {
    self.flag = [];
  }

  if(!isDefined(level.first_frame)) {
    assert(!isDefined(self.flag[str_flag]), "<dev string:x38>" + str_flag + "<dev string:x62>");
  }

  self.flag[str_flag] = b_val;
}

exists(str_flag) {
  return isDefined(self.flag) && isDefined(self.flag[str_flag]);
}

set(str_flag) {
  assert(exists(str_flag), "<dev string:x71>" + function_9e72a96(str_flag) + "<dev string:x8e>");
  self.flag[str_flag] = 1;
  self notify(str_flag);
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

set_for_time(n_time, str_flag) {
  self notify("__flag::set_for_time__" + str_flag);
  self endon("__flag::set_for_time__" + str_flag);
  set(str_flag);
  wait n_time;
  clear(str_flag);
}

clear(str_flag) {
  assert(exists(str_flag), "<dev string:xaa>" + str_flag + "<dev string:x8e>");

  if(self.flag[str_flag]) {
    self.flag[str_flag] = 0;
    self notify(str_flag);
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
  assert(exists(str_flag), "<dev string:xc9>" + str_flag + "<dev string:x8e>");
  return self.flag[str_flag];
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
      return flag;
    }
  }

  self waittill(a_flags);
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

  println("<dev string:xdf>" + str_flag);
}