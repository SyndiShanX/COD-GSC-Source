/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\utility.gsc
********************************/

noself_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(level.func)) {
    return;
  }
  if(!isdefined(level.func[var_0])) {
    return;
  }
  if(!isdefined(var_1)) {
    call[[level.func[var_0]]]();
    return;
  }

  if(!isdefined(var_2)) {
    call[[level.func[var_0]]](var_1);
    return;
  }

  if(!isdefined(var_3)) {
    call[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isdefined(var_4)) {
    call[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

self_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(level.func[var_0])) {
    return;
  }
  if(!isdefined(var_1)) {
    self call[[level.func[var_0]]]();
    return;
  }

  if(!isdefined(var_2)) {
    self call[[level.func[var_0]]](var_1);
    return;
  }

  if(!isdefined(var_3)) {
    self call[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isdefined(var_4)) {
    self call[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  self call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

vectorscale(var_0, var_1) {
  var_0 = (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
  return var_0;
}

randomvector(var_0) {
  return (randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5);
}

randomvectorrange(var_0, var_1) {
  var_2 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0)
    var_2 = var_2 * -1;

  var_3 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0)
    var_3 = var_3 * -1;

  var_4 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0)
    var_4 = var_4 * -1;

  return (var_2, var_3, var_4);
}

randomvectorincone(var_0, var_1) {
  var_2 = randomfloat(var_1);
  var_3 = randomfloat(360);
  var_4 = sin(var_2);
  var_5 = cos(var_2);
  var_6 = sin(var_3);
  var_7 = cos(var_3);
  var_8 = (var_5, var_7 * var_4, var_6 * var_4);
  return rotatevector(var_8, vectortoangles(var_0));
}

vectorisnormalized(var_0) {
  return abs(lengthsquared(var_0) - 1) < 0.002;
}

sign(var_0) {
  if(var_0 >= 0)
    return 1;

  return -1;
}

mod(var_0, var_1) {
  var_2 = int(var_0 / var_1);

  if(var_0 * var_1 < 0)
    var_2 = var_2 - 1;

  return var_0 - var_2 * var_1;
}

tostring(var_0) {
  return "" + var_0;
}

track(var_0) {
  if(isdefined(self.current_target)) {
    if(var_0 == self.current_target)
      return;
  }

  self.current_target = var_0;
}

get_enemy_team(var_0) {
  var_1 = [];
  var_1["axis"] = "allies";
  var_1["allies"] = "axis";
  return var_1[var_0];
}

clear_exception(var_0) {
  self.exception[var_0] = anim.defaultexception;
}

set_exception(var_0, var_1) {
  self.exception[var_0] = var_1;
}

set_all_exceptions(var_0) {
  var_1 = getarraykeys(self.exception);

  for (var_2 = 0; var_2 < var_1.size; var_2++)
    self.exception[var_1[var_2]] = var_0;
}

cointoss() {
  return randomint(100) >= 50;
}

choose_from_weighted_array(var_0, var_1) {
  var_2 = randomint(var_1[var_1.size - 1] + 1);

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_2 <= var_1[var_3])
      return var_0[var_3];
  }
}

get_cumulative_weights(var_0) {
  var_1 = [];
  var_2 = 0;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_2 + var_0[var_3];
    var_1[var_3] = var_2;
  }

  return var_1;
}

waittillend(var_0) {
  self waittillmatch(var_0, "end");
}

waittill_string(var_0, var_1) {
  if(var_0 != "death")
    self endon("death");

  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

waittill_string_parms(var_0, var_1) {
  if(var_0 != "death")
    self endon("death");

  var_1 endon("die");
  self waittill(var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_12 = [];
  var_12[0] = var_0;

  if(isdefined(var_2))
    var_12[1] = var_2;

  if(isdefined(var_3))
    var_12[2] = var_3;

  if(isdefined(var_4))
    var_12[3] = var_4;

  if(isdefined(var_5))
    var_12[4] = var_5;

  if(isdefined(var_6))
    var_12[5] = var_6;

  if(isdefined(var_7))
    var_12[6] = var_7;

  if(isdefined(var_8))
    var_12[7] = var_8;

  if(isdefined(var_9))
    var_12[8] = var_9;

  if(isdefined(var_10))
    var_12[9] = var_10;

  if(isdefined(var_11))
    var_12[10] = var_11;

  var_1 notify("returned", var_12);
}

waittill_string_no_endon_death(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

waittill_multiple(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = spawnstruct();
  var_5.threads = 0;

  if(isdefined(var_0)) {
    childthread waittill_string(var_0, var_5);
    var_5.threads++;
  }

  if(isdefined(var_1)) {
    childthread waittill_string(var_1, var_5);
    var_5.threads++;
  }

  if(isdefined(var_2)) {
    childthread waittill_string(var_2, var_5);
    var_5.threads++;
  }

  if(isdefined(var_3)) {
    childthread waittill_string(var_3, var_5);
    var_5.threads++;
  }

  if(isdefined(var_4)) {
    childthread waittill_string(var_4, var_5);
    var_5.threads++;
  }

  while (var_5.threads) {
    var_5 waittill("returned");
    var_5.threads--;
  }

  var_5 notify("die");
}

waittill_multiple_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_8 = spawnstruct();
  var_8.threads = 0;

  if(isdefined(var_0)) {
    var_0 childthread waittill_string(var_1, var_8);
    var_8.threads++;
  }

  if(isdefined(var_2)) {
    var_2 childthread waittill_string(var_3, var_8);
    var_8.threads++;
  }

  if(isdefined(var_4)) {
    var_4 childthread waittill_string(var_5, var_8);
    var_8.threads++;
  }

  if(isdefined(var_6)) {
    var_6 childthread waittill_string(var_7, var_8);
    var_8.threads++;
  }

  while (var_8.threads) {
    var_8 waittill("returned");
    var_8.threads--;
  }

  var_8 notify("die");
}

waittill_any_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isdefined(var_0) || var_0 != "death") && (!isdefined(var_1) || var_1 != "death") && (!isdefined(var_2) || var_2 != "death") && (!isdefined(var_3) || var_3 != "death") && (!isdefined(var_4) || var_4 != "death") && (!isdefined(var_5) || var_5 != "death") && (!isdefined(var_6) || var_6 != "death"))
    self endon("death");

  var_7 = spawnstruct();

  if(isdefined(var_0))
    childthread waittill_string(var_0, var_7);

  if(isdefined(var_1))
    childthread waittill_string(var_1, var_7);

  if(isdefined(var_2))
    childthread waittill_string(var_2, var_7);

  if(isdefined(var_3))
    childthread waittill_string(var_3, var_7);

  if(isdefined(var_4))
    childthread waittill_string(var_4, var_7);

  if(isdefined(var_5))
    childthread waittill_string(var_5, var_7);

  if(isdefined(var_6))
    childthread waittill_string(var_6, var_7);

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

waittill_any_return_parms(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if((!isdefined(var_0) || var_0 != "death") && (!isdefined(var_1) || var_1 != "death") && (!isdefined(var_2) || var_2 != "death") && (!isdefined(var_3) || var_3 != "death") && (!isdefined(var_4) || var_4 != "death") && (!isdefined(var_5) || var_5 != "death") && (!isdefined(var_6) || var_6 != "death") && (!isdefined(var_7) || var_7 != "death"))
    self endon("death");

  var_8 = spawnstruct();

  if(isdefined(var_0))
    childthread waittill_string_parms(var_0, var_8);

  if(isdefined(var_1))
    childthread waittill_string_parms(var_1, var_8);

  if(isdefined(var_2))
    childthread waittill_string_parms(var_2, var_8);

  if(isdefined(var_3))
    childthread waittill_string_parms(var_3, var_8);

  if(isdefined(var_4))
    childthread waittill_string_parms(var_4, var_8);

  if(isdefined(var_5))
    childthread waittill_string_parms(var_5, var_8);

  if(isdefined(var_6))
    childthread waittill_string_parms(var_6, var_8);

  if(isdefined(var_7))
    childthread waittill_string_parms(var_7, var_8);

  var_8 waittill("returned", var_9);
  var_8 notify("die");
  return var_9;
}

waittill_any_return_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();

  if(isdefined(var_0))
    childthread waittill_string_no_endon_death(var_0, var_6);

  if(isdefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_6);

  if(isdefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_6);

  if(isdefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_6);

  if(isdefined(var_4))
    childthread waittill_string_no_endon_death(var_4, var_6);

  if(isdefined(var_5))
    childthread waittill_string_no_endon_death(var_5, var_6);

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

waittill_any_in_array_return(var_0) {
  var_1 = spawnstruct();
  var_2 = 0;

  foreach(var_4 in var_0) {
    childthread waittill_string(var_4, var_1);

    if(var_4 == "death")
      var_2 = 1;
  }

  if(!var_2)
    self endon("death");

  var_1 waittill("returned", var_6);
  var_1 notify("die");
  return var_6;
}

waittill_any_in_array_return_no_endon_death(var_0) {
  var_1 = spawnstruct();

  foreach(var_3 in var_0)
  childthread waittill_string_no_endon_death(var_3, var_1);

  var_1 waittill("returned", var_5);
  var_1 notify("die");
  return var_5;
}

waittill_any_in_array_or_timeout(var_0, var_1) {
  var_2 = spawnstruct();
  var_3 = 0;

  foreach(var_5 in var_0) {
    childthread waittill_string(var_5, var_2);

    if(var_5 == "death")
      var_3 = 1;
  }

  if(!var_3)
    self endon("death");

  var_2 childthread _timeout(var_1);
  var_2 waittill("returned", var_7);
  var_2 notify("die");
  return var_7;
}

waittill_any_in_array_or_timeout_no_endon_death(var_0, var_1) {
  var_2 = spawnstruct();

  foreach(var_4 in var_0)
  childthread waittill_string_no_endon_death(var_4, var_2);

  var_2 thread _timeout(var_1);
  var_2 waittill("returned", var_6);
  var_2 notify("die");
  return var_6;
}

waittill_any_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isdefined(var_1) || var_1 != "death") && (!isdefined(var_2) || var_2 != "death") && (!isdefined(var_3) || var_3 != "death") && (!isdefined(var_4) || var_4 != "death") && (!isdefined(var_5) || var_5 != "death") && (!isdefined(var_6) || var_6 != "death"))
    self endon("death");

  var_7 = spawnstruct();

  if(isdefined(var_1))
    childthread waittill_string(var_1, var_7);

  if(isdefined(var_2))
    childthread waittill_string(var_2, var_7);

  if(isdefined(var_3))
    childthread waittill_string(var_3, var_7);

  if(isdefined(var_4))
    childthread waittill_string(var_4, var_7);

  if(isdefined(var_5))
    childthread waittill_string(var_5, var_7);

  if(isdefined(var_6))
    childthread waittill_string(var_6, var_7);

  var_7 childthread _timeout(var_0);
  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

_timeout(var_0) {
  self endon("die");
  wait(var_0);
  self notify("returned", "timeout");
}

waittill_any_timeout_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();

  if(isdefined(var_1))
    childthread waittill_string_no_endon_death(var_1, var_6);

  if(isdefined(var_2))
    childthread waittill_string_no_endon_death(var_2, var_6);

  if(isdefined(var_3))
    childthread waittill_string_no_endon_death(var_3, var_6);

  if(isdefined(var_4))
    childthread waittill_string_no_endon_death(var_4, var_6);

  if(isdefined(var_5))
    childthread waittill_string_no_endon_death(var_5, var_6);

  var_6 childthread _timeout(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

waittill_any(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isdefined(var_1))
    self endon(var_1);

  if(isdefined(var_2))
    self endon(var_2);

  if(isdefined(var_3))
    self endon(var_3);

  if(isdefined(var_4))
    self endon(var_4);

  if(isdefined(var_5))
    self endon(var_5);

  if(isdefined(var_6))
    self endon(var_6);

  if(isdefined(var_7))
    self endon(var_7);

  self waittill(var_0);
}

waittill_any_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isdefined(var_2) && isdefined(var_3))
    var_2 endon(var_3);

  if(isdefined(var_4) && isdefined(var_5))
    var_4 endon(var_5);

  if(isdefined(var_6) && isdefined(var_7))
    var_6 endon(var_7);

  if(isdefined(var_8) && isdefined(var_9))
    var_8 endon(var_9);

  if(isdefined(var_10) && isdefined(var_11))
    var_10 endon(var_11);

  if(isdefined(var_12) && isdefined(var_13))
    var_12 endon(var_13);

  var_0 waittill(var_1);
}

isflashed() {
  var_0 = gettime();

  if(isdefined(self.flashendtime) && var_0 < self.flashendtime)
    return 1;

  if(isdefined(self.concussionendtime) && var_0 < self.concussionendtime)
    return 1;

  return 0;
}

flag_exist(var_0) {
  return isdefined(level.flag[var_0]);
}

flag(var_0) {
  return level.flag[var_0];
}

flags(var_0) {
  foreach(var_2 in var_0) {
    if(!flag(var_2))
      return 0;
  }

  return 1;
}

init_flags() {
  level.flag = [];
  level.flags_lock = [];
  level.generic_index = 0;

  if(!isdefined(level.sp_stat_tracking_func))
    level.sp_stat_tracking_func = ::empty_init_func;

  level.flag_struct = spawnstruct();
  level.flag_struct assign_unique_id();
}

flag_init(var_0) {
  if(!isdefined(level.flag))
    init_flags();

  level.flag[var_0] = 0;

  if(!isdefined(level.trigger_flags)) {
    init_trigger_flags();
    level.trigger_flags[var_0] = [];
  } else if(!isdefined(level.trigger_flags[var_0]))
    level.trigger_flags[var_0] = [];

  if(issuffix(var_0, "aa_"))
    thread[[level.sp_stat_tracking_func]](var_0);
}

empty_init_func(var_0) {}

issuffix(var_0, var_1) {
  if(var_1.size > var_0.size)
    return 0;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0[var_2] != var_1[var_2])
      return 0;
  }

  return 1;
}

flag_set(var_0, var_1) {
  level.flag[var_0] = 1;
  set_trigger_flag_permissions(var_0);

  if(isdefined(var_1))
    level notify(var_0, var_1);
  else
    level notify(var_0);
}

assign_unique_id() {
  self.unique_id = "generic" + level.generic_index;
  level.generic_index++;
}

flag_wait(var_0) {
  var_1 = undefined;

  while (!flag(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isdefined(var_1))
    return var_1;
}

flag_clear(var_0) {
  if(!flag(var_0)) {
    return;
  }
  level.flag[var_0] = 0;
  set_trigger_flag_permissions(var_0);
  level notify(var_0);
}

flag_waitopen(var_0) {
  while (flag(var_0))
    level waittill(var_0);
}

waittill_either(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
}

array_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isdefined(var_2)) {
    foreach(var_12 in var_0)
    var_12 thread[[var_1]]();
  } else {
    if(!isdefined(var_3)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2);

      return;
    }

    if(!isdefined(var_4)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3);

      return;
    }

    if(!isdefined(var_5)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4);

      return;
    }

    if(!isdefined(var_6)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5);

      return;
    }

    if(!isdefined(var_7)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6);

      return;
    }

    if(!isdefined(var_8)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);

      return;
    }

    if(!isdefined(var_9)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);

      return;
    }

    if(!isdefined(var_10)) {
      foreach(var_12 in var_0)
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

      return;
    }

    foreach(var_12 in var_0)
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }
}

array_call(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_4)) {
    foreach(var_6 in var_0)
    var_6 call[[var_1]](var_2, var_3, var_4);

    return;
  }

  if(isdefined(var_3)) {
    foreach(var_6 in var_0)
    var_6 call[[var_1]](var_2, var_3);

    return;
  }

  if(isdefined(var_2)) {
    foreach(var_6 in var_0)
    var_6 call[[var_1]](var_2);

    return;
  }

  foreach(var_6 in var_0)
  var_6 call[[var_1]]();
}

noself_array_call(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_4)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isdefined(var_3)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isdefined(var_2)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  call[[var_1]](var_6);
}

array_thread4(var_0, var_1, var_2, var_3, var_4, var_5) {
  array_thread(var_0, var_1, var_2, var_3, var_4, var_5);
}

array_thread5(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  array_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

trigger_on(var_0, var_1) {
  if(isdefined(var_0) && isdefined(var_1)) {
    var_2 = getentarray(var_0, var_1);
    array_thread(var_2, ::trigger_on_proc);
  } else
    trigger_on_proc();
}

trigger_on_proc() {
  if(isdefined(self.realorigin))
    self.origin = self.realorigin;

  self.trigger_off = undefined;
}

trigger_off(var_0, var_1) {
  if(isdefined(var_0) && isdefined(var_1)) {
    var_2 = getentarray(var_0, var_1);
    array_thread(var_2, ::trigger_off_proc);
  } else
    trigger_off_proc();
}

trigger_off_proc() {
  if(!isdefined(self.realorigin))
    self.realorigin = self.origin;

  if(self.origin == self.realorigin)
    self.origin = self.origin + (0, 0, -10000);

  self.trigger_off = 1;
}

set_trigger_flag_permissions(var_0) {
  if(!isdefined(level.trigger_flags)) {
    return;
  }
  level.trigger_flags[var_0] = array_removeundefined(level.trigger_flags[var_0]);
  array_thread(level.trigger_flags[var_0], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  var_0 = 1;

  if(isdefined(self.script_flag_true)) {
    var_0 = 0;
    var_1 = create_flags_and_return_tokens(self.script_flag_true);

    foreach(var_3 in var_1) {
      if(flag(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  var_5 = 1;

  if(isdefined(self.script_flag_false)) {
    var_1 = create_flags_and_return_tokens(self.script_flag_false);

    foreach(var_3 in var_1) {
      if(flag(var_3)) {
        var_5 = 0;
        break;
      }
    }
  }

  [[level.trigger_func[var_0 && var_5]]]();
}

create_flags_and_return_tokens(var_0) {
  var_1 = strtok(var_0, " ");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isdefined(level.flag[var_1[var_2]]))
      flag_init(var_1[var_2]);
  }

  return var_1;
}

init_trigger_flags() {
  level.trigger_flags = [];
  level.trigger_func[1] = ::trigger_on;
  level.trigger_func[0] = ::trigger_off;
}

getstruct(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isdefined(var_2))
    return undefined;

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

getstructarray(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isdefined(var_2))
    return [];

  return var_2;
}

struct_class_init() {
  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];

  foreach(var_1 in level.struct)
  add_struct_to_global_array(var_1);
}

add_struct_to_global_array(var_0) {
  if(isdefined(var_0.targetname)) {
    if(!isdefined(level.struct_class_names["targetname"][var_0.targetname]))
      level.struct_class_names["targetname"][var_0.targetname] = [];

    var_1 = level.struct_class_names["targetname"][var_0.targetname].size;
    level.struct_class_names["targetname"][var_0.targetname][var_1] = var_0;
  }

  if(isdefined(var_0.target)) {
    if(!isdefined(level.struct_class_names["target"][var_0.target]))
      level.struct_class_names["target"][var_0.target] = [];

    var_1 = level.struct_class_names["target"][var_0.target].size;
    level.struct_class_names["target"][var_0.target][var_1] = var_0;
  }

  if(isdefined(var_0.script_noteworthy)) {
    if(!isdefined(level.struct_class_names["script_noteworthy"][var_0.script_noteworthy]))
      level.struct_class_names["script_noteworthy"][var_0.script_noteworthy] = [];

    var_1 = level.struct_class_names["script_noteworthy"][var_0.script_noteworthy].size;
    level.struct_class_names["script_noteworthy"][var_0.script_noteworthy][var_1] = var_0;
  }

  if(isdefined(var_0.script_linkname)) {
    if(!isdefined(level.struct_class_names["script_linkname"][var_0.script_linkname]))
      level.struct_class_names["script_linkname"][var_0.script_linkname] = [];

    var_1 = level.struct_class_names["script_linkname"][var_0.script_linkname].size;
    level.struct_class_names["script_linkname"][var_0.script_linkname][0] = var_0;
  }
}

fileprint_map_start() {}

fileprint_map_header(var_0) {
  if(!isdefined(var_0))
    var_0 = 0;
}

fileprint_map_keypairprint(var_0, var_1) {}

fileprint_map_entity_start() {}

fileprint_map_entity_end() {}

fileprint_radiant_vec(var_0) {}

array_remove(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1)
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_remove_array(var_0, var_1) {
  foreach(var_3 in var_1)
  var_0 = array_remove(var_0, var_3);

  return var_0;
}

array_removeundefined(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isdefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_remove_duplicates(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isdefined(var_3)) {
      continue;
    }
    var_4 = 1;

    foreach(var_6 in var_1) {
      if(var_3 == var_6) {
        var_4 = 0;
        break;
      }
    }

    if(var_4)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_levelthread(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_4)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isdefined(var_3)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isdefined(var_2)) {
    foreach(var_6 in var_0)
    thread[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  thread[[var_1]](var_6);
}

array_levelcall(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_4)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isdefined(var_3)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isdefined(var_2)) {
    foreach(var_6 in var_0)
    call[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0)
  call[[var_1]](var_6);
}

add_to_array(var_0, var_1) {
  if(!isdefined(var_1))
    return var_0;

  if(!isdefined(var_0))
    var_0[0] = var_1;
  else
    var_0[var_0.size] = var_1;

  return var_0;
}

flag_assert(var_0) {}

flag_wait_either(var_0, var_1) {
  for (;;) {
    if(flag(var_0)) {
      return;
    }
    if(flag(var_1)) {
      return;
    }
    level waittill_either(var_0, var_1);
  }
}

flag_wait_either_return(var_0, var_1) {
  for (;;) {
    if(flag(var_0))
      return var_0;

    if(flag(var_1))
      return var_1;

    var_2 = level waittill_any_return(var_0, var_1);
    return var_2;
  }
}

flag_waitopen_either(var_0, var_1) {
  for (;;) {
    if(!flag(var_0))
      return var_0;

    if(!flag(var_1))
      return var_1;

    level waittill_either(var_0, var_1);
  }
}

flag_waitopen_either_return(var_0, var_1) {
  return flag_waitopen_either(var_0, var_1);
}

flag_wait_any(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isdefined(var_5)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
    var_6[var_6.size] = var_5;
  } else if(isdefined(var_4)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
  } else if(isdefined(var_3)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
  } else if(isdefined(var_2)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
  } else if(isdefined(var_1)) {
    flag_wait_either(var_0, var_1);
    return;
  } else
    return;

  for (;;) {
    for (var_7 = 0; var_7 < var_6.size; var_7++) {
      if(flag(var_6[var_7]))
        return;
    }

    level waittill_any(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

flag_wait_any_return(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isdefined(var_4)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
    var_5[var_5.size] = var_4;
  } else if(isdefined(var_3)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
  } else if(isdefined(var_2)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
  } else if(isdefined(var_1)) {
    var_6 = flag_wait_either_return(var_0, var_1);
    return var_6;
  } else
    return;

  for (;;) {
    for (var_7 = 0; var_7 < var_5.size; var_7++) {
      if(flag(var_5[var_7]))
        return var_5[var_7];
    }

    var_6 = level waittill_any_return(var_0, var_1, var_2, var_3, var_4);
    return var_6;
  }
}

flag_wait_all(var_0, var_1, var_2, var_3) {
  if(isdefined(var_0))
    flag_wait(var_0);

  if(isdefined(var_1))
    flag_wait(var_1);

  if(isdefined(var_2))
    flag_wait(var_2);

  if(isdefined(var_3))
    flag_wait(var_3);
}

flag_wait_or_timeout(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for (;;) {
    if(flag(var_0)) {
      break;
    }

    if(gettime() >= var_3 + var_2) {
      break;
    }

    var_4 = var_2 - (gettime() - var_3);
    var_5 = var_4 / 1000;
    wait_for_flag_or_time_elapses(var_0, var_5);
  }
}

flag_waitopen_or_timeout(var_0, var_1) {
  var_2 = gettime();

  for (;;) {
    if(!flag(var_0)) {
      break;
    }

    if(gettime() >= var_2 + var_1 * 1000) {
      break;
    }

    wait_for_flag_or_time_elapses(var_0, var_1);
  }
}

wait_for_flag_or_time_elapses(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
}

delaycall(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  thread delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait(var_1);

  if(isdefined(var_10))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  else if(isdefined(var_9))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isdefined(var_8))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isdefined(var_7))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isdefined(var_6))
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isdefined(var_5))
    self call[[var_0]](var_2, var_3, var_4, var_5);
  else if(isdefined(var_4))
    self call[[var_0]](var_2, var_3, var_4);
  else if(isdefined(var_3))
    self call[[var_0]](var_2, var_3);
  else if(isdefined(var_2))
    self call[[var_0]](var_2);
  else
    self call[[var_0]]();
}

delay_script_call(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  thread delay_script_call_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

delay_script_call_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  wait(var_1);

  if(isdefined(var_10))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  else if(isdefined(var_9))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(isdefined(var_8))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  else if(isdefined(var_7))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  else if(isdefined(var_6))
    self[[var_0]](var_2, var_3, var_4, var_5, var_6);
  else if(isdefined(var_5))
    self[[var_0]](var_2, var_3, var_4, var_5);
  else if(isdefined(var_4))
    self[[var_0]](var_2, var_3, var_4);
  else if(isdefined(var_3))
    self[[var_0]](var_2, var_3);
  else if(isdefined(var_2))
    self[[var_0]](var_2);
  else
    self[[var_0]]();
}

noself_delaycall(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread noself_delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5);
}

noself_delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(var_1);

  if(isdefined(var_5))
    call[[var_0]](var_2, var_3, var_4, var_5);
  else if(isdefined(var_4))
    call[[var_0]](var_2, var_3, var_4);
  else if(isdefined(var_3))
    call[[var_0]](var_2, var_3);
  else if(isdefined(var_2))
    call[[var_0]](var_2);
  else
    call[[var_0]]();
}

issp() {
  if(!isdefined(level.issp))
    level.issp = !string_starts_with(getdvar("mapname"), "mp_");

  return level.issp;
}

issp_towerdefense() {
  if(!isdefined(level.issp_towerdefense))
    level.issp_towerdefense = string_starts_with(getdvar("mapname"), "so_td_");

  return level.issp_towerdefense;
}

string_starts_with(var_0, var_1) {
  if(var_0.size < var_1.size)
    return 0;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(tolower(var_0[var_2]) != tolower(var_1[var_2]))
      return 0;
  }

  return 1;
}

string_find(var_0, var_1) {
  if(var_0.size < var_1.size)
    return -1;

  if(var_1.size == 0)
    return 0;

  var_2 = 0;

  for (var_3 = 0; var_2 < var_0.size; var_2++) {
    if(tolower(var_0[var_2]) == tolower(var_1[var_3]))
      var_3++;
    else {
      var_3 = 0;

      if(tolower(var_0[var_2]) == tolower(var_1[var_3]))
        var_3++;
      else if(var_2 > var_0.size - var_1.size)
        return -1;
    }

    if(var_3 >= var_1.size)
      return var_2 - var_3 + 1;
  }

  return -1;
}

plot_points(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0[0];

  if(!isdefined(var_1))
    var_1 = 1;

  if(!isdefined(var_2))
    var_2 = 1;

  if(!isdefined(var_3))
    var_3 = 1;

  if(!isdefined(var_4))
    var_4 = 0.05;

  for (var_6 = 1; var_6 < var_0.size; var_6++) {
    thread draw_line_for_time(var_5, var_0[var_6], var_1, var_2, var_3, var_4);
    var_5 = var_0[var_6];
  }
}

draw_line_for_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isdefined(var_6))
    var_6 = 0;

  var_5 = gettime() + var_5 * 1000;

  while (gettime() < var_5)
    wait 0.05;
}

table_combine(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0)
  var_2[var_5] = var_4;

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = var_4;

  return var_2;
}

array_combine(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isdefined(var_4))
      var_2[var_2.size] = var_4;
  }

  foreach(var_4 in var_1) {
    if(isdefined(var_4))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_combine_reverse_keys(var_0, var_1) {
  if(!var_0.size)
    return var_1;

  var_2 = [];
  var_3 = getarraykeys(var_0);
  var_3 = array_reverse(var_3);

  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];
    var_2[var_2.size] = var_0[var_5];
  }

  var_3 = getarraykeys(var_1);
  var_3 = array_reverse(var_3);

  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];
    var_2[var_2.size] = var_1[var_5];
  }

  return var_2;
}

array_combine_non_integer_indices(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0)
  var_2[var_5] = var_4;

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = var_4;

  return var_2;
}

array_randomize(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = randomint(var_0.size);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return var_0;
}

array_add(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

array_first(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_1 = var_3;
    break;
  }

  return var_1;
}

array_insert(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for (var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}

array_contains(var_0, var_1) {
  if(var_0.size <= 0)
    return 0;

  foreach(var_3 in var_0) {
    if(var_3 == var_1)
      return 1;
  }

  return 0;
}

array_find(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3 == var_1)
      return var_4;
  }

  return undefined;
}

flat_angle(var_0) {
  var_1 = (0, var_0[1], 0);
  return var_1;
}

flat_origin(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  return var_1;
}

draw_arrow_time(var_0, var_1, var_2, var_3) {
  level endon("newpath");
  var_4 = [];
  var_5 = vectortoangles(var_0 - var_1);
  var_6 = anglestoright(var_5);
  var_7 = anglestoforward(var_5);
  var_8 = anglestoup(var_5);
  var_9 = distance(var_0, var_1);
  var_10 = [];
  var_11 = 0.1;
  var_10[0] = var_0;
  var_10[1] = var_0 + var_6 * (var_9 * var_11) + var_7 * (var_9 * -0.1);
  var_10[2] = var_1;
  var_10[3] = var_0 + var_6 * (var_9 * (-1 * var_11)) + var_7 * (var_9 * -0.1);
  var_10[4] = var_0;
  var_10[5] = var_0 + var_8 * (var_9 * var_11) + var_7 * (var_9 * -0.1);
  var_10[6] = var_1;
  var_10[7] = var_0 + var_8 * (var_9 * (-1 * var_11)) + var_7 * (var_9 * -0.1);
  var_10[8] = var_0;
  var_12 = var_2[0];
  var_13 = var_2[1];
  var_14 = var_2[2];
  plot_points(var_10, var_12, var_13, var_14, var_3);
}

get_linked_ents() {
  var_0 = [];

  if(isdefined(self.script_linkto)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getentarray(var_3, "script_linkname");

      if(var_4.size > 0)
        var_0 = array_combine(var_0, var_4);
    }
  }

  return var_0;
}

get_linked_vehicle_nodes() {
  var_0 = [];

  if(isdefined(self.script_linkto)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");

      if(var_4.size > 0)
        var_0 = array_combine(var_0, var_4);
    }
  }

  return var_0;
}

get_linked_ent() {
  var_0 = get_linked_ents();
  return var_0[0];
}

get_linked_vehicle_node() {
  var_0 = get_linked_vehicle_nodes();
  return var_0[0];
}

get_links() {
  return strtok(self.script_linkto, " ");
}

run_thread_on_targetname(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getentarray(var_0, "targetname");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getstructarray(var_0, "targetname");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "targetname");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "targetname");
  array_thread(var_5, var_1, var_2, var_3, var_4);
}

run_thread_on_noteworthy(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getentarray(var_0, "script_noteworthy");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getstructarray(var_0, "script_noteworthy");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "script_noteworthy");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "script_noteworthy");
  array_thread(var_5, var_1, var_2, var_3, var_4);
}

draw_arrow(var_0, var_1, var_2) {
  level endon("newpath");
  var_3 = [];
  var_4 = vectortoangles(var_0 - var_1);
  var_5 = anglestoright(var_4);
  var_6 = anglestoforward(var_4);
  var_7 = distance(var_0, var_1);
  var_8 = [];
  var_9 = 0.05;
  var_8[0] = var_0;
  var_8[1] = var_0 + var_5 * (var_7 * var_9) + var_6 * (var_7 * -0.2);
  var_8[2] = var_1;
  var_8[3] = var_0 + var_5 * (var_7 * (-1 * var_9)) + var_6 * (var_7 * -0.2);

  for (var_10 = 0; var_10 < 4; var_10++) {
    var_11 = var_10 + 1;

    if(var_11 >= 4)
      var_11 = 0;
  }
}

draw_entity_bounds(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_2))
    var_2 = (0, 1, 0);

  if(!isdefined(var_3))
    var_3 = 0;

  if(!isdefined(var_4))
    var_4 = 0.05;

  if(var_3)
    var_5 = int(var_4 / 0.05);
  else
    var_5 = int(var_1 / 0.05);

  var_6 = [];
  var_7 = [];
  var_8 = gettime();

  for (var_9 = var_8 + var_1 * 1000; var_8 < var_9 && isdefined(var_0); var_8 = gettime()) {
    var_6[0] = var_0 getpointinbounds(1, 1, 1);
    var_6[1] = var_0 getpointinbounds(1, 1, -1);
    var_6[2] = var_0 getpointinbounds(-1, 1, -1);
    var_6[3] = var_0 getpointinbounds(-1, 1, 1);
    var_7[0] = var_0 getpointinbounds(1, -1, 1);
    var_7[1] = var_0 getpointinbounds(1, -1, -1);
    var_7[2] = var_0 getpointinbounds(-1, -1, -1);
    var_7[3] = var_0 getpointinbounds(-1, -1, 1);

    for (var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_10 + 1;

      if(var_11 == 4)
        var_11 = 0;
    }

    if(!var_3) {
      return;
    }
    wait(var_4);
  }
}

draw_volume(var_0, var_1, var_2, var_3, var_4) {
  draw_entity_bounds(var_0, var_1, var_2, var_3, var_4);
}

draw_trigger(var_0, var_1, var_2, var_3, var_4) {
  draw_entity_bounds(var_0, var_1, var_2, var_3, var_4);
}

getfx(var_0) {
  return level._effect[var_0];
}

fxexists(var_0) {
  return isdefined(level._effect[var_0]);
}

print_csv_asset(var_0, var_1) {
  var_2 = var_1 + "," + var_0;

  if(isdefined(level.csv_lines[var_2])) {
    return;
  }
  level.csv_lines[var_2] = 1;
}

fileprint_csv_start(var_0) {}

getlastweapon() {
  return self.saved_lastweapon;
}

playerunlimitedammothread() {}

isusabilityenabled() {
  return !self.disabledusability;
}

_disableusability() {
  if(!isdefined(self.disabledusability))
    self.disabledusability = 0;

  self.disabledusability++;
  self disableusability();
}

_enableusability() {
  if(!isdefined(self.disabledusability))
    self.disabledusability = 0;
  else if(self.disabledusability > 0) {
    self.disabledusability--;

    if(self.disabledusability == 0)
      self enableusability();
  }
}

resetusability() {
  self.disabledusability = 0;
  self enableusability();
}

_disableweapon() {
  if(!isdefined(self.disabledweapon))
    self.disabledweapon = 0;

  self.disabledweapon++;
  self disableweapons();
}

_enableweapon() {
  if(!isdefined(self.disabledweapon))
    self.disabledweapon = 0;

  self.disabledweapon--;

  if(!self.disabledweapon)
    self enableweapons();
}

isweaponenabled() {
  return !self.disabledweapon;
}

_disableweaponswitch() {
  if(!isdefined(self.disabledweaponswitch))
    self.disabledweaponswitch = 0;

  self.disabledweaponswitch++;
  self disableweaponswitch();
}

_enableweaponswitch() {
  if(!isdefined(self.disabledweaponswitch))
    self.disabledweaponswitch = 0;

  self.disabledweaponswitch--;

  if(!self.disabledweaponswitch) {
    if(isdefined(level.hordeweaponsjammed) && level.hordeweaponsjammed == 1)
      return;
    else
      self enableweaponswitch();
  }
}

isweaponswitchenabled() {
  return !self.disabledweaponswitch;
}

_disableoffhandweapons() {
  if(!isdefined(self.disabledoffhandweapons))
    self.disabledoffhandweapons = 0;

  self.disabledoffhandweapons++;
  self disableoffhandweapons();
}

_enableoffhandweapons() {
  if(!isdefined(self.disabledoffhandweapons))
    self.disabledoffhandweapons = 0;

  self.disabledoffhandweapons--;

  if(!self.disabledoffhandweapons)
    self enableoffhandweapons();
}

isoffhandweaponenabled() {
  return !self.disabledoffhandweapons;
}

_enabledetonate(var_0, var_1) {
  if(!self hasweapon(var_0)) {
    return;
  }
  if(self getdetonateenabled(var_0) == var_1) {
    return;
  }
  self enabledetonate(var_0, var_1);

  if(var_1)
    self notify("WeaponDetonateEnabled", var_0);
  else
    self notify("WeaponDetonateDisabled", var_0);
}

random(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_1.size] = var_3;

  if(!var_1.size)
    return undefined;

  return var_1[randomint(var_1.size)];
}

random_weight_sorted(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_1.size] = var_3;

  if(!var_1.size)
    return undefined;

  var_5 = randomint(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - int(sqrt(var_5))];
}

spawn_tag_origin() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setmodel("tag_origin");
  var_0 hide();

  if(isdefined(self.origin))
    var_0.origin = self.origin;

  if(isdefined(self.angles))
    var_0.angles = self.angles;

  return var_0;
}

waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

waittill_notify_or_timeout_return(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
  return "timeout";
}

fileprint_launcher_start_file() {
  level.fileprintlauncher_linecount = 0;
  level.fileprint_launcher = 1;
  fileprint_launcher("GAMEPRINTSTARTFILE:");
}

fileprint_launcher(var_0) {
  level.fileprintlauncher_linecount++;

  if(level.fileprintlauncher_linecount > 200) {
    wait 0.05;
    level.fileprintlauncher_linecount = 0;
  }
}

fileprint_launcher_end_file(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 0;

  if(var_1)
    fileprint_launcher("GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_0);
  else
    fileprint_launcher("GAMEPRINTENDFILE:" + var_0);

  var_2 = gettime() + 4000;

  while (getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getdvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var_2)
    wait 0.05;

  if(!(gettime() < var_2)) {
    iprintlnbold("LAUNCHER_PRINT_FAIL:(TIMEOUT): launcherconflict? restart launcher and try again? ");
    level.fileprint_launcher = undefined;
    return 0;
  }

  var_3 = getdvar("LAUNCHER_PRINT_FAIL");

  if(var_3 != "0") {
    iprintlnbold("LAUNCHER_PRINT_FAIL:(" + var_3 + "): launcherconflict? restart launcher and try again? ");
    level.fileprint_launcher = undefined;
    return 0;
  }

  level.fileprint_launcher = undefined;
  return 1;
}

launcher_write_clipboard(var_0) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher("LAUNCHER_CLIP:" + var_0);
}

isdestructible() {
  if(!isdefined(self))
    return 0;

  return isdefined(self.destructible_type);
}

pauseeffect() {
  common_scripts\_createfx::stop_fx_looper();
}

activate_individual_exploder() {
  common_scripts\_exploder::activate_individual_exploder_proc();
}

get_target_ent(var_0) {
  if(!isdefined(var_0))
    var_0 = self.target;

  var_1 = getent(var_0, "targetname");

  if(isdefined(var_1))
    return var_1;

  if(issp()) {
    var_1 = call[[level.getnodefunction]](var_0, "targetname");

    if(isdefined(var_1))
      return var_1;
  }

  var_1 = getstruct(var_0, "targetname");

  if(isdefined(var_1))
    return var_1;

  var_1 = getvehiclenode(var_0, "targetname");

  if(isdefined(var_1))
    return var_1;
}

get_noteworthy_ent(var_0) {
  var_1 = getent(var_0, "script_noteworthy");

  if(isdefined(var_1))
    return var_1;

  if(issp()) {
    var_1 = call[[level.getnodefunction]](var_0, "script_noteworthy");

    if(isdefined(var_1))
      return var_1;
  }

  var_1 = getstruct(var_0, "script_noteworthy");

  if(isdefined(var_1))
    return var_1;

  var_1 = getvehiclenode(var_0, "script_noteworthy");

  if(isdefined(var_1))
    return var_1;
}

do_earthquake(var_0, var_1) {
  var_2 = level.earthquake[var_0];
  earthquake(var_2["magnitude"], var_2["duration"], var_1, var_2["radius"]);
}

play_loopsound_in_space(var_0, var_1) {
  if(!soundexists(var_0)) {
    return;
  }
  var_2 = spawn("script_origin", (0, 0, 0));

  if(!isdefined(var_1))
    var_1 = self.origin;

  var_2.origin = var_1;
  var_2 playloopsound(var_0);
  return var_2;
}

play_loopsound_in_space_with_end(var_0, var_1, var_2) {
  var_3 = play_loopsound_in_space(var_0, var_1);

  if(isdefined(var_2))
    self waittill(var_2);

  var_3 stoploopsound(var_0);
  var_3 delete();
}

play_sound_in_space_with_angles(var_0, var_1, var_2, var_3) {
  if(!soundexists(var_0)) {
    return;
  }
  var_4 = spawn("script_origin", (0, 0, 1));

  if(!isdefined(var_1))
    var_1 = self.origin;

  var_4.origin = var_1;
  var_4.angles = var_2;

  if(issp()) {
    if(isdefined(var_3) && var_3)
      var_4 playsoundasmaster(var_0, "sounddone");
    else
      var_4 playsound(var_0, "sounddone");

    var_4 waittill("sounddone");
  } else if(isdefined(var_3) && var_3)
    var_4 playsoundasmaster(var_0);
  else
    var_4 playsound(var_0);

  var_4 delete();
}

play_sound_in_space(var_0, var_1, var_2) {
  play_sound_in_space_with_angles(var_0, var_1, (0, 0, 0), var_2);
}

loop_fx_sound(var_0, var_1, var_2, var_3, var_4) {
  if(!soundexists(var_0)) {
    return;
  }
  if(isdefined(var_3))
    var_2 = undefined;

  if(isdefined(var_2) && var_2 && (!isdefined(level.first_frame) || level.first_frame == 1))
    spawnloopingsound(var_0, var_1, (0, 0, 0));
  else {
    var_5 = spawn("script_origin", (0, 0, 0));

    if(isdefined(var_3)) {
      thread loop_sound_delete(var_3, var_5);
      self endon(var_3);
    }

    var_5.origin = var_1;
    var_5 playloopsound(var_0);
    var_5 willneverchange();
  }
}

loop_fx_sound_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!soundexists(var_0)) {
    return;
  }
  if(isdefined(var_3) && var_3) {
    if(!isdefined(level.first_frame) || level.first_frame == 1)
      spawnloopingsound(var_0, var_1, var_2);
  } else {
    if(isdefined(level.createfx_enabled) && level.createfx_enabled && isdefined(var_5.loopsound_ent))
      var_7 = var_5.loopsound_ent;
    else
      var_7 = spawn("script_origin", (0, 0, 0));

    if(isdefined(var_4)) {
      thread loop_sound_delete(var_4, var_7);
      self endon(var_4);
    }

    var_7.origin = var_1;
    var_7.angles = var_2;
    var_7 playloopsound(var_0);

    if(isdefined(level.createfx_enabled) && level.createfx_enabled)
      var_5.loopsound_ent = var_7;
    else
      var_7 willneverchange();
  }
}

loop_fx_sound_interval(var_0, var_1, var_2, var_3, var_4, var_5) {
  loop_fx_sound_interval_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3, var_4, var_5);
}

loop_fx_sound_interval_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawn("script_origin", (0, 0, 0));

  if(isdefined(var_3)) {
    thread loop_sound_delete(var_3, var_7);
    self endon(var_3);
  }

  var_7.origin = var_1;
  var_7.angles = var_2;

  if(var_5 >= var_6) {
    for (;;)
      wait 0.05;
  }

  if(!soundexists(var_0)) {
    for (;;)
      wait 0.05;
  }

  for (;;) {
    wait(randomfloatrange(var_5, var_6));
    lock("createfx_looper");
    thread play_sound_in_space_with_angles(var_0, var_7.origin, var_7.angles, undefined);
    unlock("createfx_looper");
  }
}

loop_sound_delete(var_0, var_1) {
  var_1 endon("death");
  self waittill(var_0);
  var_1 delete();
}

createloopeffect(var_0) {
  var_1 = common_scripts\_createfx::createeffect("loopfx", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getloopeffectdelaydefault();
  return var_1;
}

createoneshoteffect(var_0) {
  var_1 = common_scripts\_createfx::createeffect("oneshotfx", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getoneshoteffectdelaydefault();
  return var_1;
}

createexploder(var_0) {
  var_1 = common_scripts\_createfx::createeffect("exploder", var_0);
  var_1.v["delay"] = common_scripts\_createfx::getexploderdelaydefault();
  var_1.v["exploder_type"] = "normal";
  return var_1;
}

alphabetize(var_0) {
  if(var_0.size <= 1)
    return var_0;

  var_1 = 0;

  for (var_2 = var_0.size - 1; var_2 >= 1; var_2--) {
    var_3 = var_0[var_2];
    var_4 = var_2;

    for (var_5 = 0; var_5 < var_2; var_5++) {
      var_6 = var_0[var_5];

      if(stricmp(var_6, var_3) > 0) {
        var_3 = var_6;
        var_4 = var_5;
      }
    }

    if(var_4 != var_2) {
      var_0[var_4] = var_0[var_2];
      var_0[var_2] = var_3;
    }
  }

  return var_0;
}

is_later_in_alphabet(var_0, var_1) {
  return stricmp(var_0, var_1) > 0;
}

play_loop_sound_on_entity(var_0, var_1, var_2, var_3) {
  if(!soundexists(var_0)) {
    return;
  }
  var_4 = spawn("script_origin", (0, 0, 0));
  var_4 endon("death");
  thread delete_on_death(var_4);

  if(isdefined(var_1)) {
    var_4.origin = self.origin + var_1;
    var_4.angles = self.angles;
    var_4 linktosynchronizedparent(self);
  } else {
    var_4.origin = self.origin;
    var_4.angles = self.angles;
    var_4 linktosynchronizedparent(self);
  }

  if(isdefined(var_2) && var_2 > 0)
    var_4 setvolume(0);

  var_4 playloopsound(var_0);

  if(isdefined(var_2) && var_2 > 0)
    var_4 scalevolume(1, var_2);

  self waittill("stop sound" + var_0);

  if(isdefined(var_3) && var_3 > 0) {
    var_4 scalevolume(0, var_3);
    wait(var_3 + 0.05);
  }

  var_4 stoploopsound(var_0);
  var_4 delete();
}

stop_loop_sound_on_entity(var_0) {
  self notify("stop sound" + var_0);
}

delete_on_death(var_0) {
  var_0 endon("death");
  waittill_any("death", "disconnect");

  if(isdefined(var_0))
    var_0 delete();
}

error(var_0) {
  waitframe();
}

create_dvar(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
}

void(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {}

tag_project(var_0, var_1) {
  var_2 = self gettagorigin(var_0);
  var_3 = self gettagangles(var_0);
  var_4 = anglestoforward(var_3);
  var_4 = vectornormalize(var_4) * var_1;
  return var_2 + var_4;
}

ter_op(var_0, var_1, var_2) {
  if(var_0)
    return var_1;

  return var_2;
}

create_lock(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 1;

  if(!isdefined(level.lock))
    level.lock = [];

  var_2 = spawnstruct();
  var_2.max_count = var_1;
  var_2.count = 0;
  level.lock[var_0] = var_2;
}

lock_exists(var_0) {
  if(!isdefined(level.lock))
    return 0;

  return isdefined(level.lock[var_0]);
}

lock(var_0) {
  var_1 = level.lock[var_0];

  while (var_1.count >= var_1.max_count)
    var_1 waittill("unlocked");

  var_1.count++;
}

is_locked(var_0) {
  var_1 = level.lock[var_0];
  return var_1.count > var_1.max_count;
}

unlock_wait(var_0) {
  thread unlock_thread(var_0);
  wait 0.05;
}

unlock(var_0) {
  thread unlock_thread(var_0);
}

unlock_thread(var_0) {
  wait 0.05;
  var_1 = level.lock[var_0];
  var_1.count--;
  var_1 notify("unlocked");
}

get_template_level() {
  var_0 = level.script;

  if(isdefined(level.template_script))
    var_0 = level.template_script;

  return var_0;
}

array_reverse(var_0) {
  var_1 = [];

  for (var_2 = var_0.size - 1; var_2 >= 0; var_2--)
    var_1[var_1.size] = var_0[var_2];

  return var_1;
}

distance_2d_squared(var_0, var_1) {
  return length2dsquared(var_0 - var_1);
}

get_array_of_farthest(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_array_of_closest(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = array_reverse(var_6);
  return var_6;
}

get_array_of_closest(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_3))
    var_3 = var_1.size;

  if(!isdefined(var_2))
    var_2 = [];

  var_6 = undefined;

  if(isdefined(var_4))
    var_6 = var_4 * var_4;

  var_7 = 0;

  if(isdefined(var_5))
    var_7 = var_5 * var_5;

  if(var_2.size == 0 && var_3 >= var_1.size && var_7 == 0 && !isdefined(var_6))
    return sortbydistance(var_1, var_0);

  var_8 = [];

  foreach(var_10 in var_1) {
    var_11 = 0;

    foreach(var_13 in var_2) {
      if(var_10 == var_13) {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }
    var_15 = distancesquared(var_0, var_10.origin);

    if(isdefined(var_6) && var_15 > var_6) {
      continue;
    }
    if(var_15 < var_7) {
      continue;
    }
    var_8[var_8.size] = var_10;
  }

  var_8 = sortbydistance(var_8, var_0);

  if(var_3 >= var_8.size)
    return var_8;

  var_17 = [];

  for (var_18 = 0; var_18 < var_3; var_18++)
    var_17[var_18] = var_8[var_18];

  return var_17;
}

is_player_gamepad_enabled() {
  if(!level.console) {
    var_0 = self usinggamepad();

    if(isdefined(var_0))
      return var_0;
    else
      return 0;
  }

  return 1;
}

drop_to_ground(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = 1500;

  if(!isdefined(var_2))
    var_2 = -12000;

  return physicstrace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2));
}

add_destructible_type_function(var_0, var_1) {
  if(!isdefined(level.destructible_functions))
    level.destructible_functions = [];

  level.destructible_functions[var_0] = var_1;
}

add_destructible_type_transient(var_0, var_1) {
  if(!isdefined(level.destructible_transient))
    level.destructible_transient = [];

  level.destructible_transient[var_0] = var_1;
}

within_fov(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_2 - var_0);
  var_5 = anglestoforward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

entity_path_disconnect_thread(var_0) {
  self notify("entity_path_disconnect_thread");
  self endon("entity_path_disconnect_thread");
  self endon("death");
  level endon("game_ended");
  var_1 = 0;
  self.forcedisconnectuntil = 0;

  for (;;) {
    var_2 = self.origin;
    var_3 = waittill_any_timeout(var_0, "path_disconnect");
    var_4 = 0;
    var_5 = distancesquared(self.origin, var_2) > 0;

    if(var_5)
      var_4 = 1;

    if(isdefined(var_3) && var_3 == "path_disconnect")
      var_4 = 1;

    if(gettime() < self.forcedisconnectuntil)
      var_4 = 1;

    foreach(var_7 in level.characters) {
      if(isai(var_7) && distancesquared(self.origin, var_7.origin) < 250000) {
        var_4 = 1;
        self.forcedisconnectuntil = max(gettime() + 30000, self.forcedisconnectuntil);
      }
    }

    if(var_4 != var_1 || var_5) {
      if(var_4)
        self disconnectpaths();
      else
        self connectpaths();

      var_1 = var_4;
    }
  }
}

make_entity_sentient_mp(var_0, var_1) {
  if(level.gametype == "aliens" && isdefined(level.aliens_make_entity_sentient_func))
    return self[[level.aliens_make_entity_sentient_func]](var_0, var_1);

  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["bots_make_entity_sentient"]))
    return self[[level.bot_funcs["bots_make_entity_sentient"]]](var_0, var_1);
}

ai_3d_sighting_model(var_0) {
  if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["ai_3d_sighting_model"]))
    return self[[level.bot_funcs["ai_3d_sighting_model"]]](var_0);
}

set_basic_animated_model(var_0, var_1, var_2) {
  if(!isdefined(level.anim_prop_models))
    level.anim_prop_models = [];

  var_3 = tolower(getdvar("mapname"));
  var_4 = 1;

  if(string_starts_with(var_3, "mp_"))
    var_4 = 0;

  if(var_4)
    level.anim_prop_models[var_0]["basic"] = var_1;
  else
    level.anim_prop_models[var_0]["basic"] = var_2;
}

getclosest(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 500000;

  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!isdefined(var_5)) {
      continue;
    }
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_5;
  }

  return var_3;
}

getfarthest(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = 500000;

  var_3 = 0;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = distance(var_6.origin, var_0);

    if(var_7 <= var_3 || var_7 >= var_2) {
      continue;
    }
    var_3 = var_7;
    var_4 = var_6;
  }

  return var_4;
}

missile_settargetandflightmode(var_0, var_1, var_2) {
  var_2 = ter_op(isdefined(var_2), var_2, (0, 0, 0));
  self missile_settargetent(var_0, var_2);

  switch (var_1) {
    case "direct":
      self missile_setflightmodedirect();
      break;
    case "top":
      self missile_setflightmodetop();
      break;
  }
}

evfromluminancenits(var_0) {
  return log(var_0 + 0.000061) / log(2.0) + 2.84;
}

lineartogamma_srgb(var_0) {
  if(var_0 <= 0.0031308)
    return var_0 * 12.92;
  else
    return pow(var_0, 0.416667) * 1.055 - 0.055;
}

convertlegacyfog(var_0) {
  if(!isdefined(var_0.hdrcolorintensity)) {
    if(isusinghdr()) {
      var_1 = max(var_0.red, max(var_0.green, var_0.blue));
      var_2 = evfromluminancenits(var_1 * getradiometricunit());

      if(var_1 > 0) {
        var_0.red = var_0.red / var_1;
        var_0.green = var_0.green / var_1;
        var_0.blue = var_0.blue / var_1;
        var_0.red = lineartogamma_srgb(var_0.red);
        var_0.green = lineartogamma_srgb(var_0.green);
        var_0.blue = lineartogamma_srgb(var_0.blue);
        var_0.hdrcolorintensity = var_2;
      } else
        var_0.hdrcolorintensity = 0.0;
    } else
      var_0.hdrcolorintensity = 1.0;
  }

  if(isdefined(var_0.sunfogenabled) && var_0.sunfogenabled) {
    if(!isdefined(var_0.hdrsuncolorintensity)) {
      if(isusinghdr()) {
        var_1 = max(var_0.red, var_0.green, var_0.blue);
        var_2 = evfromluminancenits(var_1 * getradiometricunit());

        if(var_1 > 0) {
          var_0.sunred = var_0.sunred / var_1;
          var_0.sungreen = var_0.sungreen / var_1;
          var_0.sunblue = var_0.sunblue / var_1;
          var_0.sunred = lineartogamma_srgb(var_0.red);
          var_0.sungreen = lineartogamma_srgb(var_0.green);
          var_0.sunblue = lineartogamma_srgb(var_0.blue);
          var_0.hdrsuncolorintensity = var_2;
          return;
        }

        var_0.hdrsuncolorintensity = 0.0;
        return;
      } else
        var_0.hdrsuncolorintensity = 1.0;
    }
  }
}

convertfogtech(var_0) {
  if(isdefined(level.exclusive_fog_tech)) {
    switch (level.exclusive_fog_tech) {
      case "dfog":
        if(level.exclusive_fog_tech == "dfog" && var_0.sunfogenabled == 0) {
          var_0.sunfogenabled = 1;
          var_0.sunred = 0;
          var_0.sungreen = 0;
          var_0.sunblue = 0;
          var_0.hdrsuncolorintensity = 0;
          var_0.sundir = (0, 0, 0);
          var_0.sunbeginfadeangle = 0;
          var_0.sunendfageangle = 0;
          var_0.normalfogscale = 1;
        }

        break;
      case "normal_fog":
        if(var_0.sunfogenabled == 1)
          var_0.sunfogenabled = 0;

        break;
      default:
    }
  }
}

set_fog_to_ent_values_dfog(var_0, var_1) {
  if(isdefined(var_0.sunfogenabled) && var_0.sunfogenabled) {
    if(!isplayer(self))
      setexpfogext(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.hdrcolorintensity, var_0.maxopacity, var_1, var_0.sunred, var_0.sungreen, var_0.sunblue, var_0.hdrsuncolorintensity, var_0.sundir, var_0.sunbeginfadeangle, var_0.sunendfadeangle, var_0.normalfogscale, var_0.skyfogintensity, var_0.skyfogminangle, var_0.skyfogmaxangle, var_0.heightfogenabled, var_0.heightfogbaseheight, var_0.heightfoghalfplanedistance);
    else
      self playersetexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.hdrcolorintensity, var_0.maxopacity, var_1, var_0.sunred, var_0.sungreen, var_0.sunblue, var_0.hdrsuncolorintensity, var_0.sundir, var_0.sunbeginfadeangle, var_0.sunendfadeangle, var_0.normalfogscale, var_0.skyfogintensity, var_0.skyfogminangle, var_0.skyfogmaxangle, var_0.heightfogenabled, var_0.heightfogbaseheight, var_0.heightfoghalfplanedistance);
  } else if(!isplayer(self))
    setexpfogext(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.hdrcolorintensity, var_0.maxopacity, var_1, var_0.skyfogintensity, var_0.skyfogminangle, var_0.skyfogmaxangle, var_0.heightfogenabled, var_0.heightfogbaseheight, var_0.heightfoghalfplanedistance);
  else
    self playersetexpfog(var_0.startdist, var_0.halfwaydist, var_0.red, var_0.green, var_0.blue, var_0.hdrcolorintensity, var_0.maxopacity, var_1, var_0.skyfogintensity, var_0.skyfogminangle, var_0.skyfogmaxangle, var_0.heightfogenabled, var_0.heightfogbaseheight, var_0.heightfoghalfplanedistance);
}

set_fog_to_ent_values(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 0;

  if(!isdefined(var_0.skyfogintensity)) {
    var_0.skyfogintensity = 0;
    var_0.skyfogminangle = 0;
    var_0.skyfogmaxangle = 0;
  }

  if(!isdefined(var_0.heightfogenabled)) {
    var_0.heightfogenabled = 0;
    var_0.heightfogbaseheight = 0;
    var_0.heightfoghalfplanedistance = 1000;
  }

  convertlegacyfog(var_0);
  convertfogtech(var_0);

  if(isdefined(var_0.atmosfogenabled)) {
    if(level.nextgen && var_0.atmosfogenabled) {
      if(isplayer(self))
        self playersetatmosfog(var_1, var_0.atmosfogsunfogcolor, var_0.atmosfoghazecolor, var_0.atmosfoghazestrength, var_0.atmosfoghazespread, var_0.atmosfogextinctionstrength, var_0.atmosfoginscatterstrength, var_0.atmosfoghalfplanedistance, var_0.atmosfogstartdistance, var_0.atmosfogdistancescale, int(var_0.atmosfogskydistance), var_0.atmosfogskyangularfalloffenabled, var_0.atmosfogskyfalloffstartangle, var_0.atmosfogskyfalloffanglerange, var_0.atmosfogsundirection, var_0.atmosfogheightfogenabled, var_0.atmosfogheightfogbaseheight, var_0.atmosfogheightfoghalfplanedistance);
      else
        setatmosfog(var_1, var_0.atmosfogsunfogcolor, var_0.atmosfoghazecolor, var_0.atmosfoghazestrength, var_0.atmosfoghazespread, var_0.atmosfogextinctionstrength, var_0.atmosfoginscatterstrength, var_0.atmosfoghalfplanedistance, var_0.atmosfogstartdistance, var_0.atmosfogdistancescale, int(var_0.atmosfogskydistance), var_0.atmosfogskyangularfalloffenabled, var_0.atmosfogskyfalloffstartangle, var_0.atmosfogskyfalloffanglerange, var_0.atmosfogsundirection, var_0.atmosfogheightfogenabled, var_0.atmosfogheightfogbaseheight, var_0.atmosfogheightfoghalfplanedistance);
    } else
      set_fog_to_ent_values_dfog(var_0, var_1);
  } else
    set_fog_to_ent_values_dfog(var_0, var_1);
}

add_fx(var_0, var_1) {
  if(!isdefined(level._effect))
    level._effect = [];

  level._effect[var_0] = loadfx(var_1);
}

array_sort_by_handler(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    for (var_3 = var_2 + 1; var_3 < var_0.size; var_3++) {
      if(var_0[var_3][
          [var_1]
        ]() < var_0[var_2][
          [var_1]
        ]()) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_2];
        var_0[var_2] = var_4;
      }
    }
  }

  return var_0;
}

array_sort_with_func(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = -1;

  for (var_3 = 1; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    for (var_5 = var_3 - 1; var_5 >= 0 && ![
        [var_1]
      ](var_0[var_5], var_4); var_5--)
      var_0[var_5 + 1] = var_0[var_5];

    var_0[var_5 + 1] = var_4;

    if(var_2 > 0 && var_3 % var_2 == 0)
      wait 0.05;
  }

  return var_0;
}

hide_notsolid() {
  if(!isdefined(self.oldcontents))
    self.oldcontents = self setcontents(0);

  self hide();
}

show_solid() {
  if(!isai(self))
    self solid();

  if(isdefined(self.oldcontents))
    self setcontents(self.oldcontents);

  self show();
}

setlightingstate(var_0) {
  var_1 = getentarray();
  setomnvar("lighting_state", var_0);

  if(!getdvarint("r_reflectionProbeGenerate")) {
    foreach(var_3 in var_1) {
      if(isdefined(var_3.lightingstate) && (var_3.classname == "script_brushmodel" || var_3.classname == "script_model")) {
        if(var_3.lightingstate == 0) {
          continue;
        }
        if(var_3.lightingstate == var_0) {
          var_3 show_solid();
          continue;
        }

        var_3 hide_notsolid();
      }
    }
  }
}

getstatsgroup_ranked() {
  return "rankedMatchData";
}

getstatsgroup_private() {
  return "privateMatchData";
}

getstatsgroup_coop() {
  return "coopMatchData";
}

getstatsgroup_common() {
  return "commonData";
}

getstatsgroup_horde() {
  return "hordeMatchData";
}

getstatsgroup_sp() {
  return "spData";
}

hide_friendname_until_flag_or_notify(var_0) {
  thread hide_friendname_waittill_flag_or_notify(var_0);
}

hide_friendname_waittill_flag_or_notify(var_0) {
  if(!isdefined(self.name)) {
    return;
  }
  level.player endon("death");
  self endon("death");
  self.old_name = self.name;
  self.name = " ";
  level waittill(var_0);
  self.name = self.old_name;
}