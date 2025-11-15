/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\flagsys_shared.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace flagsys;

autoexec __init__system__() {
  system::register(#"flagsys", &__init__, undefined, undefined);
}

__init__() {
  level thread update_flag_dvars();
}

update_flag_dvars() {
  while(true) {
    if(isDefined(level.flag_dvars)) {
      foreach(str_dvar in level.flag_dvars) {
        set_val(str_dvar, getdvarint(str_dvar, 0));
      }
    }

    wait randomfloatrange(0.666667, 1.33333);
  }
}

init_dvar(str_dvar) {
  if(!isDefined(level.flag_dvars)) {
    level.flag_dvars = [];
  } else if(!isarray(level.flag_dvars)) {
    level.flag_dvars = array(level.flag_dvars);
  }

  if(!isinarray(level.flag_dvars, str_dvar)) {
    level.flag_dvars[level.flag_dvars.size] = str_dvar;
  }
}

set(str_flag) {
  if(!isDefined(self.flag)) {
    self.flag = [];
  }

  self.flag[str_flag] = 1;
  self notify(str_flag);
}

increment(str_flag) {
  if(!isDefined(self.flag_count)) {
    self.flag_count = [];
  }

  if(!isDefined(self.flag_count[str_flag])) {
    self.flag_count[str_flag] = 0;
  }

  self.flag_count[str_flag]++;
  set(str_flag);
}

decrement(str_flag) {
  assert(isDefined(self.flag_count) && isDefined(self.flag_count[str_flag]) && self.flag_count[str_flag] > 0, "<dev string:x38>");
  self.flag_count[str_flag]--;

  if(self.flag_count[str_flag] == 0) {
    clear(str_flag);
  }
}

set_for_time(n_time, str_flag) {
  self notify("__flag::set_for_time__" + str_flag);
  self endon("__flag::set_for_time__" + str_flag);
  set(str_flag);
  wait n_time;
  clear(str_flag);
}

clear(str_flag) {
  if(isDefined(self) && isDefined(self.flag) && isDefined(self.flag[str_flag]) && self.flag[str_flag]) {
    self.flag[str_flag] = undefined;
    self notify(str_flag);
  }
}

set_val(str_flag, b_val) {
  assert(isDefined(b_val), "<dev string:x77>");

  if(b_val) {
    set(str_flag);
    return;
  }

  clear(str_flag);
}

toggle(str_flag) {
  set_val(str_flag, !get(str_flag));
}

get(str_flag) {
  return isDefined(self.flag) && isDefined(self.flag[str_flag]) && self.flag[str_flag];
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
  clear(str_flag);
}

script_flag_wait() {
  if(isDefined(self.script_flag_wait)) {
    self wait_till(self.script_flag_wait);
    return true;
  }

  return false;
}