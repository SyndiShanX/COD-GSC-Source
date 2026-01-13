/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2626.gsc
**************************************/

noself_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func)) {
    return;
  }
  if(!isDefined(level.func[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    call[[level.func[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    call[[level.func[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    call[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    call[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

self_func(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.func[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    self call[[level.func[var_0]]]();
    return;
  }

  if(!isDefined(var_2)) {
    self call[[level.func[var_0]]](var_1);
    return;
  }

  if(!isDefined(var_3)) {
    self call[[level.func[var_0]]](var_1, var_2);
    return;
  }

  if(!isDefined(var_4)) {
    self call[[level.func[var_0]]](var_1, var_2, var_3);
    return;
  }

  self call[[level.func[var_0]]](var_1, var_2, var_3, var_4);
}

anglebetweenvectors(var_0, var_1) {
  return acos(vectordot(var_0, var_1) / (length(var_0) * length(var_1)));
}

anglebetweenvectorsunit(var_0, var_1) {
  return acos(vectordot(var_0, var_1));
}

anglebetweenvectorssigned(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_0);
  var_4 = vectornormalize(var_1);
  var_5 = acos(clamp(vectordot(var_3, var_4), -1, 1));
  var_6 = vectorcross(var_3, var_4);

  if(vectordot(var_6, var_2) < 0) {
    var_5 = var_5 * -1;
  }

  return var_5;
}

segmentvssphere(var_0, var_1, var_2, var_3) {
  if(var_0 == var_1) {
    return 0;
  }

  var_4 = var_2 - var_0;
  var_5 = var_1 - var_0;
  var_6 = clamp(vectordot(var_4, var_5) / vectordot(var_5, var_5), 0, 1);
  var_7 = var_0 + var_5 * var_6;
  return lengthsquared(var_2 - var_7) <= var_3 * var_3;
}

randomvector(var_0) {
  return (randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5, randomfloat(var_0) - var_0 * 0.5);
}

randomvectorrange(var_0, var_1) {
  var_2 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_2 = var_2 * -1;
  }

  var_3 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_3 = var_3 * -1;
  }

  var_4 = randomfloatrange(var_0, var_1);

  if(randomint(2) == 0) {
    var_4 = var_4 * -1;
  }

  return (var_2, var_3, var_4);
}

sign(var_0) {
  if(var_0 >= 0) {
    return 1;
  }

  return -1;
}

mod(var_0, var_1) {
  var_2 = int(var_0 / var_1);

  if(var_0 * var_1 < 0) {
    var_2 = var_2 - 1;
  }

  return var_0 - var_2 * var_1;
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

cointoss() {
  return randomint(100) >= 50;
}

choose_from_weighted_array(var_0, var_1) {
  var_2 = randomint(var_1[var_1.size - 1] + 1);

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_2 <= var_1[var_3]) {
      return var_0[var_3];
    }
  }
}

waittill_string(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

waittillmatch_string(var_0, var_1, var_2) {
  if(var_1 != "death") {
    self endon("death");
  }

  var_2 endon("die");
  self waittillmatch(var_0, var_1);
  var_2 notify("returned", var_1);
}

waittill_string_no_endon_death(var_0, var_1) {
  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

waittill_multiple(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = spawnStruct();
  var_5.threads = 0;

  if(isDefined(var_0)) {
    childthread waittill_string(var_0, var_5);
    var_5.threads++;
  }

  if(isDefined(var_1)) {
    childthread waittill_string(var_1, var_5);
    var_5.threads++;
  }

  if(isDefined(var_2)) {
    childthread waittill_string(var_2, var_5);
    var_5.threads++;
  }

  if(isDefined(var_3)) {
    childthread waittill_string(var_3, var_5);
    var_5.threads++;
  }

  if(isDefined(var_4)) {
    childthread waittill_string(var_4, var_5);
    var_5.threads++;
  }

  while(var_5.threads) {
    var_5 waittill("returned");
    var_5.threads--;
  }

  var_5 notify("die");
}

waittillmatch_notify(var_0, var_1, var_2) {
  self endon("death");
  self waittillmatch(var_0, var_1);
  self notify(var_2);
}

waittill_any_return(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death")) {
    self endon("death");
  }

  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    childthread waittill_string(var_0, var_6);
  }

  if(isDefined(var_1)) {
    childthread waittill_string(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread waittill_string(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread waittill_string(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread waittill_string(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread waittill_string(var_5, var_6);
  }

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

waittillmatch_any_return(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    childthread waittillmatch_string(var_0, var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread waittillmatch_string(var_0, var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread waittillmatch_string(var_0, var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread waittillmatch_string(var_0, var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread waittillmatch_string(var_0, var_5, var_7);
  }

  if(isDefined(var_6)) {
    childthread waittillmatch_string(var_0, var_6, var_7);
  }

  var_7 waittill("returned", var_8);
  var_7 notify("die");
  return var_8;
}

waittill_any_return_no_endon_death(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    childthread waittill_string_no_endon_death(var_0, var_6);
  }

  if(isDefined(var_1)) {
    childthread waittill_string_no_endon_death(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread waittill_string_no_endon_death(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread waittill_string_no_endon_death(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread waittill_string_no_endon_death(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread waittill_string_no_endon_death(var_5, var_6);
  }

  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

waittill_any_in_array_return(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  foreach(var_4 in var_0) {
    childthread waittill_string(var_4, var_1);

    if(var_4 == "death") {
      var_2 = 1;
    }
  }

  if(!var_2) {
    self endon("death");
  }

  var_1 waittill("returned", var_6);
  var_1 notify("die");
  return var_6;
}

waittill_any_in_array_return_no_endon_death(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0) {
    childthread waittill_string_no_endon_death(var_3, var_1);
  }

  var_1 waittill("returned", var_5);
  var_1 notify("die");
  return var_5;
}

waittill_any_in_array_or_timeout(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = 0;

  foreach(var_5 in var_0) {
    childthread waittill_string(var_5, var_2);

    if(var_5 == "death") {
      var_3 = 1;
    }
  }

  if(!var_3) {
    self endon("death");
  }

  var_2 childthread _timeout(var_1);
  var_2 waittill("returned", var_7);
  var_2 notify("die");
  return var_7;
}

waittill_any_in_array_or_timeout_no_endon_death(var_0, var_1) {
  var_2 = spawnStruct();

  foreach(var_4 in var_0) {
    childthread waittill_string_no_endon_death(var_4, var_2);
  }

  var_2 thread _timeout(var_1);
  var_2 waittill("returned", var_6);
  var_2 notify("die");
  return var_6;
}

waittill_any_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death") && (!isDefined(var_6) || var_6 != "death")) {
    self endon("death");
  }

  var_7 = spawnStruct();

  if(isDefined(var_1)) {
    childthread waittill_string(var_1, var_7);
  }

  if(isDefined(var_2)) {
    childthread waittill_string(var_2, var_7);
  }

  if(isDefined(var_3)) {
    childthread waittill_string(var_3, var_7);
  }

  if(isDefined(var_4)) {
    childthread waittill_string(var_4, var_7);
  }

  if(isDefined(var_5)) {
    childthread waittill_string(var_5, var_7);
  }

  if(isDefined(var_6)) {
    childthread waittill_string(var_6, var_7);
  }

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
  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    childthread waittill_string_no_endon_death(var_1, var_6);
  }

  if(isDefined(var_2)) {
    childthread waittill_string_no_endon_death(var_2, var_6);
  }

  if(isDefined(var_3)) {
    childthread waittill_string_no_endon_death(var_3, var_6);
  }

  if(isDefined(var_4)) {
    childthread waittill_string_no_endon_death(var_4, var_6);
  }

  if(isDefined(var_5)) {
    childthread waittill_string_no_endon_death(var_5, var_6);
  }

  var_6 childthread _timeout(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

waittill_any(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(isDefined(var_4)) {
    self endon(var_4);
  }

  if(isDefined(var_5)) {
    self endon(var_5);
  }

  if(isDefined(var_6)) {
    self endon(var_6);
  }

  if(isDefined(var_7)) {
    self endon(var_7);
  }

  self waittill(var_0);
}

waittill_any_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_2) && isDefined(var_3)) {
    var_2 endon(var_3);
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_4 endon(var_5);
  }

  if(isDefined(var_6) && isDefined(var_7)) {
    var_6 endon(var_7);
  }

  if(isDefined(var_8) && isDefined(var_9)) {
    var_8 endon(var_9);
  }

  if(isDefined(var_10) && isDefined(var_11)) {
    var_10 endon(var_11);
  }

  if(isDefined(var_12) && isDefined(var_13)) {
    var_12 endon(var_13);
  }

  var_0 waittill(var_1);
}

isflashed() {
  if(!isDefined(self.flashendtime)) {
    return 0;
  }

  return gettime() < self.flashendtime;
}

flag_exist(var_0) {
  if(!isDefined(level.flag)) {
    return 0;
  }

  return isDefined(level.flag[var_0]);
}

flag(var_0) {
  return level.flag[var_0];
}

flag_init(var_0) {
  if(!isDefined(level.flag)) {
    scripts\engine\flags::init_flags();
  }

  level.flag[var_0] = 0;
  init_trigger_flags();

  if(!isDefined(level.trigger_flags[var_0])) {
    level.trigger_flags[var_0] = [];
  }

  if(getsubstr(var_0, 0, 3) == "aa_") {
    thread[[level.func["sp_stat_tracking_func"]]](var_0);
  }
}

empty_init_func(var_0) {}

flag_set(var_0, var_1) {
  level.flag[var_0] = 1;
  set_trigger_flag_permissions(var_0);

  if(isDefined(var_1)) {
    level notify(var_0, var_1);
  } else {
    level notify(var_0);
  }
}

flag_wait(var_0) {
  var_1 = undefined;

  while(!flag(var_0)) {
    var_1 = undefined;
    level waittill(var_0, var_1);
  }

  if(isDefined(var_1)) {
    return var_1;
  }
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
  while(flag(var_0)) {
    level waittill(var_0);
  }
}

waittill_either(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
  return var_1;
}

array_thread_safe(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_3)) {
    foreach(var_13 in var_0) {
      var_13 thread[[var_1]]();
      wait(var_2);
    }
  } else {
    if(!isDefined(var_4)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_5)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_6)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_7)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_8)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_9)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_10)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        wait(var_2);
      }

      return;
    }

    if(!isDefined(var_11)) {
      foreach(var_13 in var_0) {
        var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
        wait(var_2);
      }

      return;
    }

    foreach(var_13 in var_0) {
      var_13 thread[[var_1]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
      wait(var_2);
    }
  }
}

array_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_10)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }

    return;
  }

  if(isDefined(var_9)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    return;
  }

  if(isDefined(var_8)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    return;
  }

  if(isDefined(var_7)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
    }

    return;
  }

  if(isDefined(var_6)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6);
    }

    return;
  }

  if(isDefined(var_5)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5);
    }

    return;
  }

  if(isDefined(var_4)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_12 in var_0) {
      var_12 thread[[var_1]](var_2);
    }

    return;
  }

  foreach(var_12 in var_0) {
    var_12 thread[[var_1]]();
  }
}

array_call(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_9)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }

    return;
  }

  if(isDefined(var_8)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    return;
  }

  if(isDefined(var_7)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
    }

    return;
  }

  if(isDefined(var_6)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5, var_6);
    }

    return;
  }

  if(isDefined(var_5)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4, var_5);
    }

    return;
  }

  if(isDefined(var_4)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_11 in var_0) {
      var_11 call[[var_1]](var_2);
    }

    return;
  }

  foreach(var_11 in var_0) {
    var_11 call[[var_1]]();
  }
}

trigger_on(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    array_thread(var_2, ::trigger_on_proc);
  } else
    trigger_on_proc();
}

trigger_on_proc() {
  if(isDefined(self.realorigin)) {
    self.origin = self.realorigin;
  }

  self.trigger_off = undefined;
}

trigger_off(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    array_thread(var_2, ::trigger_off_proc);
  } else
    trigger_off_proc();
}

trigger_off_proc() {
  if(!isDefined(self.realorigin)) {
    self.realorigin = self.origin;
  }

  if(self.origin == self.realorigin) {
    self.origin = self.origin + (0, 0, -10000);
  }

  self.trigger_off = 1;
  self notify("trigger_off");
}

set_trigger_flag_permissions(var_0) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }
  level.trigger_flags[var_0] = array_removeundefined(level.trigger_flags[var_0]);
  array_thread(level.trigger_flags[var_0], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  var_0 = 1;

  if(isDefined(self.script_flag_true)) {
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

  if(isDefined(self.script_flag_false)) {
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

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(level.flag[var_1[var_2]])) {
      flag_init(var_1[var_2]);
    }
  }

  return var_1;
}

init_trigger_flags() {
  if(!add_init_script("trigger_flags", ::init_trigger_flags)) {
    return;
  }
  level.trigger_flags = [];
  level.trigger_func[1] = ::trigger_on;
  level.trigger_func[0] = ::trigger_off;
}

getstruct(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(var_2.size > 1) {
    return undefined;
  }

  return var_2[0];
}

getstructarray(var_0, var_1) {
  var_2 = level.struct_class_names[var_1][var_0];

  if(!isDefined(var_2)) {
    return [];
  }

  return var_2;
}

struct_class_init() {
  if(!add_init_script("struct_classes", ::struct_class_init)) {
    return;
  }
  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];

  foreach(var_3, var_1 in level.struct) {
    if(isDefined(var_1.targetname)) {
      if(var_1.targetname == "delete_on_load") {
        level.struct[var_3] = undefined;
        continue;
      }

      if(!isDefined(level.struct_class_names["targetname"][var_1.targetname])) {
        level.struct_class_names["targetname"][var_1.targetname] = [];
      }

      var_2 = level.struct_class_names["targetname"][var_1.targetname].size;
      level.struct_class_names["targetname"][var_1.targetname][var_2] = var_1;
    }

    if(isDefined(var_1.target)) {
      if(!isDefined(level.struct_class_names["target"][var_1.target])) {
        level.struct_class_names["target"][var_1.target] = [];
      }

      var_2 = level.struct_class_names["target"][var_1.target].size;
      level.struct_class_names["target"][var_1.target][var_2] = var_1;
    }

    if(isDefined(var_1.script_noteworthy)) {
      if(!isDefined(level.struct_class_names["script_noteworthy"][var_1.script_noteworthy])) {
        level.struct_class_names["script_noteworthy"][var_1.script_noteworthy] = [];
      }

      var_2 = level.struct_class_names["script_noteworthy"][var_1.script_noteworthy].size;
      level.struct_class_names["script_noteworthy"][var_1.script_noteworthy][var_2] = var_1;
    }

    if(isDefined(var_1.script_linkname)) {
      if(!isDefined(level.struct_class_names["script_linkname"][var_1.script_linkname])) {
        level.struct_class_names["script_linkname"][var_1.script_linkname] = [];
      }

      var_2 = level.struct_class_names["script_linkname"][var_1.script_linkname].size;
      level.struct_class_names["script_linkname"][var_1.script_linkname][var_2] = var_1;
    }
  }
}

fileprint_start(var_0) {}

fileprint_map_start() {}

fileprint_map_header(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
}

fileprint_map_keypairprint(var_0, var_1) {}

fileprint_map_entity_start() {}

fileprint_map_entity_end() {}

fileprint_radiant_vec(var_0) {}

array_remove(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

array_remove_array(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_0 = array_remove(var_0, var_3);
  }

  return var_0;
}

array_removeundefined(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_remove_duplicates(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = 1;

    foreach(var_6 in var_1) {
      if(var_3 == var_6) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

array_levelthread(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      thread[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    thread[[var_1]](var_6);
  }
}

array_levelcall(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    call[[var_1]](var_6);
  }
}

add_to_array(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0)) {
    var_0[0] = var_1;
  } else {
    var_0[var_0.size] = var_1;
  }

  return var_0;
}

exist_in_array_MAYBE(var_0, var_1) {
  var_2 = 0;

  if(var_0.size > 0) {
    foreach(var_4 in var_0) {
      if(var_4 == var_1) {
        var_2 = 1;
        break;
      }
    }
  }

  return var_2;
}

delaycall(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  thread delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait(var_1);

  if(isDefined(var_13)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
  } else if(isDefined(var_12)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  } else if(isDefined(var_11)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  } else if(isDefined(var_10)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_9)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_8)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else if(isDefined(var_7)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    self call[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    self call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    self call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    self call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    self call[[var_0]](var_2);
  } else {
    self call[[var_0]]();
  }
}

issp() {
  if(!isDefined(level.issp)) {
    var_0 = getdvar("mapname");
    var_1 = "";

    for(var_2 = 0; var_2 < min(var_0.size, 3); var_2++) {
      var_1 = var_1 + var_0[var_2];
    }

    level.issp = var_1 != "mp_" && var_1 != "cp_";
  }

  return level.issp;
}

iscp() {
  return string_starts_with(getdvar("mapname"), "cp_");
}

issp_towerdefense() {
  if(!isDefined(level.issp_towerdefense)) {
    level.issp_towerdefense = string_starts_with(getdvar("mapname"), "so_td_");
  }

  return level.issp_towerdefense;
}

string_starts_with(var_0, var_1) {
  if(var_0.size < var_1.size) {
    return 0;
  }

  var_2 = getsubstr(var_0, 0, var_1.size);

  if(var_2 == var_1) {
    return 1;
  }

  return 0;
}

plot_points(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0[0];

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.05;
  }

  for(var_6 = 1; var_6 < var_0.size; var_6++) {
    thread draw_line_for_time(var_5, var_0[var_6], var_1, var_2, var_3, var_4);
    var_5 = var_0[var_6];
  }
}

draw_line_for_time(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while(gettime() < var_5) {
    wait 0.05;
  }
}

array_combine(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(isDefined(var_0)) {
    foreach(var_6 in var_0) {
      var_4[var_4.size] = var_6;
    }
  }

  if(isDefined(var_1)) {
    foreach(var_6 in var_1) {
      var_4[var_4.size] = var_6;
    }
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_2) {
      var_4[var_4.size] = var_6;
    }
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_3) {
      var_4[var_4.size] = var_6;
    }
  }

  return var_4;
}

array_combine_multiple(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3) {
      var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

array_combine_unique(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_2[var_2.size] = var_4;
  }

  foreach(var_4 in var_1) {
    if(array_contains(var_2, var_4)) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

array_combine_non_integer_indices(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    var_2[var_5] = var_4;
  }

  foreach(var_5, var_4 in var_1) {
    var_2[var_5] = var_4;
  }

  return var_2;
}

array_randomize(var_0) {
  for(var_1 = 0; var_1 <= var_0.size - 2; var_1++) {
    var_2 = randomintrange(var_1, var_0.size - 1);
    var_3 = var_0[var_1];
    var_0[var_1] = var_0[var_2];
    var_0[var_2] = var_3;
  }

  return var_0;
}

array_randomize_objects(var_0) {
  var_1 = [];

  for(var_2 = var_0; var_2.size > 0; var_2 = var_4) {
    var_3 = randomintrange(0, var_2.size);
    var_4 = [];
    var_5 = 0;

    foreach(var_8, var_7 in var_2) {
      if(var_5 == var_3) {
        var_1[ter_op(isstring(var_8), var_8, var_1.size)] = var_7;
      } else {
        var_4[ter_op(isstring(var_8), var_8, var_4.size)] = var_7;
      }

      var_5++;
    }
  }

  return var_1;
}

array_add(var_0, var_1) {
  var_0[var_0.size] = var_1;
  return var_0;
}

array_insert(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}

array_contains(var_0, var_1) {
  if(var_0.size <= 0) {
    return 0;
  }

  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

array_find(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_3 == var_1) {
      return var_4;
    }
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

flatten_vector(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 1);
  }

  var_2 = vectornormalize(var_0 - vectordot(var_1, var_0) * var_1);
  return var_2;
}

draw_arrow_time(var_0, var_1, var_2, var_3) {
  level endon("newpath");
  var_4 = [];
  var_5 = vectortoangles(var_0 - var_1);
  var_6 = anglestoright(var_5);
  var_7 = anglesToForward(var_5);
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

get_links() {
  return strtok(self.script_linkto, " ");
}

draw_arrow(var_0, var_1, var_2) {
  level endon("newpath");
  var_3 = [];
  var_4 = vectortoangles(var_0 - var_1);
  var_5 = anglestoright(var_4);
  var_6 = anglesToForward(var_4);
  var_7 = distance(var_0, var_1);
  var_8 = [];
  var_9 = 0.05;
  var_8[0] = var_0;
  var_8[1] = var_0 + var_5 * (var_7 * var_9) + var_6 * (var_7 * -0.2);
  var_8[2] = var_1;
  var_8[3] = var_0 + var_5 * (var_7 * (-1 * var_9)) + var_6 * (var_7 * -0.2);

  for(var_10 = 0; var_10 < 4; var_10++) {
    var_11 = var_10 + 1;

    if(var_11 >= 4) {
      var_11 = 0;
    }
  }
}

draw_capsule(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  var_7 = anglesToForward(var_3);
  var_8 = anglestoright(var_3);
  var_9 = anglestoup(var_3);
  var_10 = var_0 + var_9 * var_1;
  var_11 = var_0 + var_9 * var_2;
  var_11 = var_11 - var_9 * var_1;
  var_12 = var_10 + var_7 * var_1;
  var_13 = var_11 + var_7 * var_1;
  var_14 = var_10 - var_7 * var_1;
  var_15 = var_11 - var_7 * var_1;
  var_16 = var_10 + var_8 * var_1;
  var_17 = var_11 + var_8 * var_1;
  var_18 = var_10 - var_8 * var_1;
  var_19 = var_11 - var_8 * var_1;
}

draw_character_capsule(var_0, var_1, var_2) {
  var_3 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var_3["radius"], var_3["half_height"] * 2, self.angles, var_0, var_1, var_2);
}

draw_player_capsule(var_0, var_1, var_2) {
  var_3 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var_3["radius"], var_3["half_height"] * 2, self getplayerangles(), var_0, var_1, var_2);
}

draw_ent_bone_forever(var_0, var_1) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    var_2 = self gettagorigin(var_0);
    var_3 = self gettagangles(var_0);
    draw_angles(var_3, var_2, var_1);
    waitframe();
  }
}

draw_ent_axis_forever(var_0, var_1) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    draw_ent_axis(var_0, undefined, var_1);
    waitframe();
  }
}

draw_ent_axis(var_0, var_1, var_2) {
  waittillframeend;

  if(isDefined(self.angles)) {
    var_3 = self.angles;
  } else {
    var_3 = (0, 0, 0);
  }

  draw_angles(var_3, self.origin, var_0, var_1, var_2);
}

draw_angles(var_0, var_1, var_2, var_3, var_4) {
  waittillframeend;
  var_5 = anglesToForward(var_0);
  var_6 = anglestoright(var_0);
  var_7 = anglestoup(var_0);

  if(!isDefined(var_2)) {
    var_2 = (1, 0, 1);
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 10;
  }
}

draw_entity_bounds(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = (0, 1, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0.05;
  }

  if(var_3) {
    var_5 = int(var_4 / 0.05);
  } else {
    var_5 = int(var_1 / 0.05);
  }

  var_6 = [];
  var_7 = [];
  var_8 = gettime();

  for(var_9 = var_8 + var_1 * 1000; var_8 < var_9 && isDefined(var_0); var_8 = gettime()) {
    var_6[0] = var_0 getpointinbounds(1, 1, 1);
    var_6[1] = var_0 getpointinbounds(1, 1, -1);
    var_6[2] = var_0 getpointinbounds(-1, 1, -1);
    var_6[3] = var_0 getpointinbounds(-1, 1, 1);
    var_7[0] = var_0 getpointinbounds(1, -1, 1);
    var_7[1] = var_0 getpointinbounds(1, -1, -1);
    var_7[2] = var_0 getpointinbounds(-1, -1, -1);
    var_7[3] = var_0 getpointinbounds(-1, -1, 1);

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_10 + 1;

      if(var_11 == 4) {
        var_11 = 0;
      }
    }

    if(!var_3) {
      return;
    }
    wait(var_4);
  }
}

getfx(var_0) {
  return level._effect[var_0];
}

fxexists(var_0) {
  return isDefined(level._effect[var_0]);
}

getlastweapon() {
  return self.saved_lastweapon;
}

playerunlimitedammothread() {}

isusabilityallowed() {
  return !isDefined(self.disabledusability) || !self.disabledusability;
}

allow_usability(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledusability)) {
      self.disabledusability = 0;
    }

    self.disabledusability--;

    if(!self.disabledusability) {
      self enableusability();
    }
  } else {
    if(!isDefined(self.disabledusability)) {
      self.disabledusability = 0;
    }

    self.disabledusability++;
    self disableusability();
  }
}

allow_weapon(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledweapon)) {
      self.disabledweapon = 0;
    }

    self.disabledweapon--;

    if(!self.disabledweapon) {
      self enableweapons();

      if(isDefined(level.allow_weapon_func)) {
        self[[level.allow_weapon_func]](1);
      }
    }
  } else {
    if(!isDefined(self.disabledweapon)) {
      self.disabledweapon = 0;
    }

    if(!self.disabledweapon) {
      if(isDefined(level.allow_weapon_func)) {
        self[[level.allow_weapon_func]](0);
      }

      self getradiuspathsighttestnodes();
    }

    self.disabledweapon++;
  }
}

isweaponallowed() {
  return !isDefined(self.disabledweapon) || !self.disabledweapon;
}

allow_weapon_switch(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledweaponswitch)) {
      self.disabledweaponswitch = 0;
    }

    self.disabledweaponswitch--;

    if(!self.disabledweaponswitch) {
      self enableweaponswitch();
    }
  } else {
    if(!isDefined(self.disabledweaponswitch)) {
      self.disabledweaponswitch = 0;
    }

    self.disabledweaponswitch++;
    self getraidspawnpoint();
  }
}

allow_offhand_weapons(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledoffhandweapons)) {
      self.disabledoffhandweapons = 0;
    }

    self.disabledoffhandweapons--;

    if(!self.disabledoffhandweapons) {
      self enableoffhandweapons();
    }

    if(!isDefined(level.ismp) || level.ismp == 0) {
      allow_offhand_shield_weapons(1);
    }
  } else {
    if(!isDefined(self.disabledoffhandweapons)) {
      self.disabledoffhandweapons = 0;
    }

    self.disabledoffhandweapons++;
    self getquadrant();

    if(!isDefined(level.ismp) || level.ismp == 0) {
      allow_offhand_shield_weapons(0);
    }
  }
}

allow_offhand_primary_weapons(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledoffhandprimaryweapons)) {
      self.disabledoffhandprimaryweapons = 0;
    } else {
      self.disabledoffhandprimaryweapons--;
    }

    if(!self.disabledoffhandprimaryweapons) {
      self grenade_earthquakeatposition_internal();
    }
  } else {
    if(!isDefined(self.disabledoffhandprimaryweapons)) {
      self.disabledoffhandprimaryweapons = 0;
    }

    self.disabledoffhandprimaryweapons++;
    self grenade_earthquakeatposition();
  }
}

allow_offhand_secondary_weapons(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledoffhandsecondaryweapons)) {
      self.disabledoffhandsecondaryweapons = 0;
    } else {
      self.disabledoffhandsecondaryweapons--;
    }

    if(!self.disabledoffhandsecondaryweapons) {
      self enableoffhandsecondaryweapons();
    }

    allow_offhand_shield_weapons(1);
  } else {
    if(!isDefined(self.disabledoffhandsecondaryweapons)) {
      self.disabledoffhandsecondaryweapons = 0;
    }

    self.disabledoffhandsecondaryweapons++;
    self disableoffhandsecondaryweapons();
    allow_offhand_shield_weapons(0);
  }
}

allow_offhand_shield_weapons(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledoffhandshieldweapons)) {
      self.disabledoffhandshieldweapons = 0;
    }

    self.disabledoffhandshieldweapons--;

    if(!self.disabledoffhandshieldweapons) {
      self allowoffhandshieldweapons(1);
    }
  } else {
    if(!isDefined(self.disabledoffhandshieldweapons)) {
      self.disabledoffhandshieldweapons = 0;
    }

    self.disabledoffhandshieldweapons++;
    self allowoffhandshieldweapons(0);
  }
}

isweaponswitchallowed() {
  return !isDefined(self.disabledweaponswitch) || !self.disabledweaponswitch;
}

isoffhandweaponsallowed() {
  return !isDefined(self.disabledoffhandweapons) || !self.disabledoffhandweapons;
}

isoffhandprimaryweaponsallowed() {
  return !isDefined(self.disabledoffhandprimaryweapons) || !self.disabledoffhandprimaryweapons;
}

isoffhandsecondaryweaponsallowed() {
  return !isDefined(self.disabledoffhandsecondaryweapons) || !self.disabledoffhandsecondaryweapons;
}

allow_prone(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledprone)) {
      self.disabledprone = 0;
    } else {
      self.disabledprone--;
    }

    if(!self.disabledprone) {
      self getnumownedactiveagents(1);
    }
  } else {
    if(!isDefined(self.disabledprone)) {
      self.disabledprone = 0;
    }

    self.disabledprone++;
    self getnumownedactiveagents(0);
  }
}

allow_crouch(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledcrouch)) {
      self.disabledcrouch = 0;
    } else {
      self.disabledcrouch--;
    }

    if(!self.disabledcrouch) {
      self getnumberoffrozenticksfromwave(1);
    }
  } else {
    if(!isDefined(self.disabledcrouch)) {
      self.disabledcrouch = 0;
    }

    self.disabledcrouch++;
    self getnumberoffrozenticksfromwave(0);
  }
}

allow_stances(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledstances)) {
      self.disabledstances = 0;
    } else {
      self.disabledstances--;
    }

    if(!self.disabledstances) {
      self getnumownedjackals(1);
    }
  } else {
    if(!isDefined(self.disabledstances)) {
      self.disabledstances = 0;
    }

    self.disabledstances++;
    self getnumownedjackals(0);
  }
}

allow_sprint(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledsprint)) {
      self.disabledsprint = 0;
    } else {
      self.disabledsprint--;
    }

    if(!self.disabledsprint) {
      self getnumownedagentsonteambytype(1);
    }
  } else {
    if(!isDefined(self.disabledsprint)) {
      self.disabledsprint = 0;
    }

    self.disabledsprint++;
    self getnumownedagentsonteambytype(0);
  }
}

allow_mantle(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledmantle)) {
      self.disabledmantle = 0;
    } else {
      self.disabledmantle--;
    }

    if(!self.disabledmantle) {
      self allowmantle(1);
    }
  } else {
    if(!isDefined(self.disabledmantle)) {
      self.disabledmantle = 0;
    }

    self.disabledmantle++;
    self allowmantle(0);
  }
}

allow_fire(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledfire)) {
      self.disabledfire = 0;
    } else {
      self.disabledfire--;
    }

    if(!self.disabledfire) {
      self allowfire(1);
    }
  } else {
    if(!isDefined(self.disabledfire)) {
      self.disabledfire = 0;
    }

    self.disabledfire++;
    self allowfire(0);
  }
}

allow_ads(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledads)) {
      self.disabledads = 0;
    } else {
      self.disabledads--;
    }

    if(!self.disabledads) {
      self allowads(1);
    }
  } else {
    if(!isDefined(self.disabledads)) {
      self.disabledads = 0;
    }

    self.disabledads++;
    self allowads(0);
  }
}

allow_jump(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledjump)) {
      self.disabledjump = 0;
    } else {
      self.disabledjump--;
    }

    if(!self.disabledjump) {
      self allowjump(1);
    }
  } else {
    if(!isDefined(self.disabledjump)) {
      self.disabledjump = 0;
    }

    self.disabledjump++;
    self allowjump(0);
  }
}

allow_wallrun(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledwallrun)) {
      self.disabledwallrun = 0;
    } else {
      self.disabledwallrun--;
    }

    if(!self.disabledwallrun) {
      self allowwallrun(1);
    }
  } else {
    if(!isDefined(self.disabledwallrun)) {
      self.disabledwallrun = 0;
    }

    self.disabledwallrun++;
    self allowwallrun(0);
  }
}

allow_doublejump(var_0) {
  if(var_0) {
    if(!isDefined(self.disableddoublejump)) {
      self.disableddoublejump = 0;
    } else {
      self.disableddoublejump--;
    }

    if(!self.disableddoublejump) {
      self goal_radius(0, self.doublejumpenergy);
      self goalflag(0, self.doublejumpenergyrestorerate);
      self.doublejumpenergy = undefined;
      self.doublejumpenergyrestorerate = undefined;
      self allowdoublejump(1);
    }
  } else {
    if(!isDefined(self.disableddoublejump)) {
      self.disableddoublejump = 0;
    }

    if(self.disableddoublejump == 0) {
      self.doublejumpenergy = self goal_position(0);
      self.doublejumpenergyrestorerate = self energy_getrestorerate(0);
      self goal_radius(0, 0);
      self goalflag(0, 0);
    }

    self.disableddoublejump++;
    self allowdoublejump(0);
  }
}

allow_melee(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledmelee)) {
      self.disabledmelee = 0;
    } else {
      self.disabledmelee--;
    }

    if(!self.disabledmelee) {
      self allowmelee(1);
    }
  } else {
    if(!isDefined(self.disabledmelee)) {
      self.disabledmelee = 0;
    }

    self.disabledmelee++;
    self allowmelee(0);
  }
}

allow_slide(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledslide)) {
      self.disabledslide = 0;
    } else {
      self.disabledslide--;
    }

    if(!self.disabledslide) {
      self allowslide(1);
    }
  } else {
    if(!isDefined(self.disabledslide)) {
      self.disabledslide = 0;
    }

    self.disabledslide++;
    self allowslide(0);
  }
}

get_doublejumpenergy() {
  if(!isDefined(self.doublejumpenergy)) {
    return self goal_position(0);
  }

  return self.doublejumpenergy;
}

set_doublejumpenergy(var_0) {
  if(!isDefined(self.doublejumpenergy)) {
    self goal_radius(0, var_0);
  } else {
    self.doublejumpenergy = var_0;
  }
}

get_doublejumpenergyrestorerate() {
  if(!isDefined(self.doublejumpenergyrestorerate)) {
    return self energy_getrestorerate(0);
  }

  return self.doublejumpenergyrestorerate;
}

set_doublejumpenergyrestorerate(var_0) {
  if(!isDefined(self.doublejumpenergyrestorerate)) {
    self goalflag(0, var_0);
  } else {
    self.doublejumpenergyrestorerate = var_0;
  }
}

random(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_1.size] = var_3;
  }

  if(!var_1.size) {
    return undefined;
  }

  return var_1[randomint(var_1.size)];
}

random_weight_sorted(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    var_1[var_1.size] = var_3;
  }

  if(!var_1.size) {
    return undefined;
  }

  var_5 = randomint(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - int(sqrt(var_5))];
}

spawn_tag_origin(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_0) && isDefined(self.origin)) {
    var_0 = self.origin;
  } else if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  var_2 hide();

  if(isDefined(var_1)) {
    var_2.angles = var_1;
  }

  return var_2;
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

waittill_notify_and_time(var_0, var_1) {
  var_2 = gettime();
  self waittill(var_0);
  var_3 = var_2 + var_1 * 1000;
  var_4 = var_3 - var_2;

  if(var_4 > 0) {
    var_5 = var_4 / 1000.0;
    wait(var_5);
  }
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
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    fileprint_launcher("GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_0);
  } else {
    fileprint_launcher("GAMEPRINTENDFILE:" + var_0);
  }

  var_2 = gettime() + 4000;

  while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getdvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var_2) {
    wait 0.05;
  }

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

  iprintlnbold("Launcher write to file successful!");
  level.fileprint_launcher = undefined;
  return 1;
}

launcher_write_clipboard(var_0) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher("LAUNCHER_CLIP:" + var_0);
}

activate_individual_exploder() {
  scripts\common\exploder::activate_individual_exploder_proc();
}

waitframe() {
  wait 0.05;
}

get_target_ent(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }

  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  if(issp()) {
    var_1 = call[[level.getnodefunction]](var_0, "targetname");

    if(isDefined(var_1)) {
      return var_1;
    }

    var_1 = call[[level.func["getspawner"]]](var_0, "targetname");

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  var_1 = getstruct(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = getvehiclenode(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }
}

do_earthquake(var_0, var_1) {
  var_2 = level.earthquake[var_0];
  earthquake(var_2["magnitude"], var_2["duration"], var_1, var_2["radius"]);
}

play_loopsound_in_space(var_0, var_1) {
  var_2 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_2.origin = var_1;
  var_2 playLoopSound(var_0);
  return var_2;
}

play_sound_in_space_with_angles(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", (0, 0, 1));

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  var_5.origin = var_1;
  var_5.angles = var_2;

  if(isDefined(var_4)) {
    var_5 linkto(var_4);
  }

  if(issp()) {
    if(isDefined(var_3) && var_3) {
      var_5 playsoundasmaster(var_0, "sounddone");
    } else {
      var_5 playSound(var_0, "sounddone");
    }

    var_5 waittill("sounddone");
  } else if(isDefined(var_3) && var_3)
    var_5 playsoundasmaster(var_0);
  else {
    var_5 playSound(var_0);
  }

  var_5 delete();
}

play_sound_in_space(var_0, var_1, var_2, var_3) {
  play_sound_in_space_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3);
}

loop_fx_sound(var_0, var_1, var_2, var_3, var_4) {
  loop_fx_sound_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3, var_4);
}

loop_fx_sound_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_3) && var_3) {
    if(!isDefined(level.first_frame) || level.first_frame == 1) {
      spawnloopingsound(var_0, var_1, var_2);
    }
  } else {
    if(level.createfx_enabled && isDefined(var_5.loopsound_ent)) {
      var_7 = var_5.loopsound_ent;
    } else {
      var_7 = spawn("script_origin", (0, 0, 0));
    }

    if(isDefined(var_4)) {
      thread loop_sound_delete(var_4, var_7);
      self endon(var_4);
    }

    var_7.origin = var_1;
    var_7.angles = var_2;
    var_7 playLoopSound(var_0);

    if(level.createfx_enabled) {
      var_5.loopsound_ent = var_7;
    } else {
      var_7 willneverchange();
    }
  }
}

loop_fx_sound_interval(var_0, var_1, var_2, var_3, var_4, var_5) {
  loop_fx_sound_interval_with_angles(var_0, var_1, (0, 0, 0), var_2, var_3, var_4, var_5);
}

loop_fx_sound_interval_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.origin = var_1;
  self.angles = var_2;

  if(isDefined(var_3)) {
    self endon(var_3);
  }

  if(var_5 >= var_6) {
    for(;;) {
      wait 0.05;
    }
  }

  if(!soundexists(var_0)) {
    for(;;) {
      wait 0.05;
    }
  }

  for(;;) {
    wait(randomfloatrange(var_5, var_6));
    lock("createfx_looper");
    thread play_sound_in_space_with_angles(var_0, self.origin, self.angles, undefined);
    unlock("createfx_looper");
  }
}

loop_sound_delete(var_0, var_1) {
  var_1 endon("death");
  self waittill(var_0);
  var_1 delete();
}

createloopeffect(var_0) {
  var_1 = scripts\common\createfx::createeffect("loopfx", var_0);
  var_1.v["delay"] = ::scripts\common\createfx::getloopeffectdelaydefault();
  return var_1;
}

createoneshoteffect(var_0) {
  var_1 = scripts\common\createfx::createeffect("oneshotfx", var_0);
  var_1.v["delay"] = ::scripts\common\createfx::getoneshoteffectdelaydefault();
  return var_1;
}

createexploder(var_0) {
  var_1 = scripts\common\createfx::createeffect("exploder", var_0);
  var_1.v["delay"] = ::scripts\common\createfx::getexploderdelaydefault();
  var_1.v["exploder_type"] = "normal";
  return var_1;
}

alphabetize(var_0) {
  if(var_0.size <= 1) {
    return var_0;
  }

  var_1 = 0;

  for(var_2 = var_0.size - 1; var_2 >= 1; var_2--) {
    var_3 = var_0[var_2];
    var_4 = var_2;

    for(var_5 = 0; var_5 < var_2; var_5++) {
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

play_loop_sound_on_entity(var_0, var_1) {
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 endon("death");
  thread delete_on_death(var_2);

  if(isDefined(var_1)) {
    var_2.origin = self.origin + var_1;
    var_2.angles = self.angles;
    var_2 linkto(self);
  } else {
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linkto(self);
  }

  var_2 playLoopSound(var_0);
  self waittill("stop sound" + var_0);
  var_2 stoploopsound(var_0);
  var_2 delete();
}

stop_loop_sound_on_entity(var_0) {
  self notify("stop sound" + var_0);
}

delete_on_death(var_0) {
  var_0 endon("death");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

error(var_0) {
  waitframe();
}

exploder(var_0, var_1, var_2) {
  [[level._fx.exploderfunction]](var_0, var_1, var_2);
}

ter_op(var_0, var_1, var_2) {
  if(var_0) {
    return var_1;
  }

  return var_2;
}

create_lock(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(level.lock)) {
    level.lock = [];
  }

  var_2 = spawnStruct();
  var_2.max_count = var_1;
  var_2.count = 0;
  level.lock[var_0] = var_2;
}

lock(var_0) {
  var_1 = level.lock[var_0];

  while(var_1.count >= var_1.max_count) {
    var_1 waittill("unlocked");
  }

  var_1.count++;
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

get_template_script_MAYBE() {
  var_0 = level.script;

  if(isDefined(level.template_script)) {
    var_0 = level.template_script;
  }

  return var_0;
}

is_player_gamepad_enabled() {
  if(!level.console) {
    var_0 = self global_fx();

    if(isDefined(var_0)) {
      return var_0;
    } else {
      return 0;
    }
  }

  return 1;
}

array_reverse(var_0) {
  var_1 = [];

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    var_1[var_1.size] = var_0[var_2];
  }

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
  if(!isDefined(var_3)) {
    var_3 = var_1.size;
  }

  if(!isDefined(var_2)) {
    var_2 = [];
  }

  var_6 = undefined;

  if(isDefined(var_4)) {
    var_6 = var_4 * var_4;
  }

  var_7 = 0;

  if(isDefined(var_5)) {
    var_7 = var_5 * var_5;
  }

  if(var_2.size == 0 && var_3 >= var_1.size && var_7 == 0 && !isDefined(var_6)) {
    return sortbydistance(var_1, var_0);
  }

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

    if(isDefined(var_6) && var_15 > var_6) {
      continue;
    }
    if(var_15 < var_7) {
      continue;
    }
    var_8[var_8.size] = var_10;
  }

  var_8 = sortbydistance(var_8, var_0);

  if(var_3 >= var_8.size) {
    return var_8;
  }

  var_17 = [];

  for(var_18 = 0; var_18 < var_3; var_18++) {
    var_17[var_18] = var_8[var_18];
  }

  return var_17;
}

drop_to_ground(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1500;
  }

  if(!isDefined(var_2)) {
    var_2 = -12000;
  }

  return _physicstrace(var_0 + (0, 0, var_1), var_0 + (0, 0, var_2));
}

within_fov(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

make_entity_sentient_mp(var_0, var_1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_make_entity_sentient"])) {
    return self[[level.bot_funcs["bots_make_entity_sentient"]]](var_0, var_1);
  }
}

ai_3d_sighting_model(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["ai_3d_sighting_model"])) {
    return self[[level.bot_funcs["ai_3d_sighting_model"]]](var_0);
  }
}

getclosest(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 500000;
  }

  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = distance(var_5.origin, var_0);

    if(var_6 >= var_2) {
      continue;
    }
    var_2 = var_6;
    var_3 = var_5;
  }

  return var_3;
}

missile_settargetandflightmode(var_0, var_1, var_2) {
  var_2 = ter_op(isDefined(var_2), var_2, (0, 0, 0));
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

add_fx(var_0, var_1) {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level._effect[var_0] = loadfx(var_1);
}

array_sort_with_func(var_0, var_1) {
  for(var_2 = 1; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    for(var_4 = var_2 - 1; var_4 >= 0 && ![
        [var_1]
      ](var_0[var_4], var_3); var_4--)
      var_0[var_4 + 1] = var_0[var_4];

    var_0[var_4 + 1] = var_3;
  }

  return var_0;
}

add_func_ref_MAYBE(var_0, var_1) {
  if(!isDefined(level.func)) {
    level.func = [];
  }

  level.func[var_0] = var_1;
}

init_empty_func_ref_MAYBE(var_0) {
  if(!isDefined(level.func)) {
    level.func = [];
  }

  if(!isDefined(level.func[var_0])) {
    add_func_ref_MAYBE(var_0, ::empty_init_func);
  }
}

add_init_script(var_0, var_1) {
  if(!isDefined(level.init_script)) {
    level.init_script = [];
  }

  if(isDefined(level.init_script[var_0])) {
    return 0;
  }

  level.init_script[var_0] = var_1;
  return 1;
}

func_D959() {}

func_C953() {
  if(getdvar("g_connectpaths") == "2") {
    level waittill("eternity");
  }
}

getdamagetype(var_0) {
  if(!isDefined(var_0)) {
    return "unknown";
  }

  var_0 = tolower(var_0);

  switch (var_0) {
    case "melee":
    case "mod_crush":
    case "mod_melee":
      return "melee";
    case "bullet":
    case "mod_rifle_bullet":
    case "mod_pistol_bullet":
      return "bullet";
    case "splash":
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
      return "splash";
    case "mod_impact":
      return "impact";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}

add_frame_event(var_0) {
  if(!isDefined(self.frame_events)) {
    self.frame_events = [var_0];
    thread process_frame_events();
  } else
    self.frame_events[self.frame_events.size] = var_0;
}

process_frame_events() {
  for(;;) {
    if(isDefined(self)) {
      foreach(var_1 in self.frame_events) {
        self thread[[var_1]]();
      }
    } else
      break;

    wait 0.05;
  }
}

delaythread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

delaythread_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  wait(var_1);

  if(isDefined(var_7)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    thread[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    thread[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    thread[[var_0]](var_2);
  } else {
    thread[[var_0]]();
  }
}

isprotectedbyriotshield(var_0) {
  if(isDefined(var_0.hasriotshield) && var_0.hasriotshield) {
    var_1 = self.origin - var_0.origin;
    var_2 = vectornormalize((var_1[0], var_1[1], 0));
    var_3 = anglesToForward(var_0.angles);
    var_4 = vectordot(var_3, var_1);

    if(var_0.hasriotshieldequipped) {
      if(var_4 > 0.766) {
        return 1;
      }
    } else if(var_4 < -0.766)
      return 1;
  }

  return 0;
}

isprotectedbyaxeblock(var_0) {
  var_1 = 0;
  var_2 = self getcurrentweapon();
  var_3 = self adsbuttonpressed();
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = anglesToForward(self.angles);
  var_8 = vectornormalize(var_0.origin - self.origin);
  var_9 = vectordot(var_8, var_7);

  if(var_9 > 0.5) {
    var_4 = 1;
  }

  if(var_2 == "iw6_axe_mp" || var_2 == "iw7_axe_zm") {
    var_6 = self getcurrentweaponclipammo();
    var_5 = 1;
  }

  if(var_5 && var_3 && var_4 && var_6 > 0) {
    self setweaponammoclip(var_2, var_6 - 1);
    self playSound("crate_impact");
    earthquake(0.75, 0.5, self.origin, 100);
    var_1 = 1;
  }

  return var_1;
}

isairdropmarker(var_0) {
  switch (var_0) {
    case "airdrop_escort_marker_mp":
    case "airdrop_tank_marker_mp":
    case "airdrop_juggernaut_maniac_mp":
    case "airdrop_juggernaut_def_mp":
    case "airdrop_juggernaut_mp":
    case "airdrop_sentry_marker_mp":
    case "airdrop_mega_marker_mp":
    case "airdrop_marker_support_mp":
    case "airdrop_marker_assault_mp":
    case "airdrop_marker_mp":
      return 1;
    default:
      return 0;
  }
}

isdestructibleweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "barrel_mp":
    case "destructible_toy":
    case "destructible_car":
    case "destructible":
      return 1;
  }

  return 0;
}

weaponclass(var_0) {
  if(isDefined(var_0) && var_0 != "" && var_0 != "none") {
    var_1 = getweaponbasename(var_0);

    if(var_1 == "iw7_emc") {
      return "pistol";
    }

    if(var_1 == "iw7_devastator") {
      return "spread";
    }

    if(var_1 == "iw7_steeldragon") {
      return "beam";
    }
  }

  return weaponclass(var_0);
}

damagelocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(self.damagelocation)) {
    if(!isDefined(var_0)) {
      return 0;
    }

    if(self.damagelocation == var_0) {
      return 1;
    }

    if(!isDefined(var_1)) {
      return 0;
    }

    if(self.damagelocation == var_1) {
      return 1;
    }

    if(!isDefined(var_2)) {
      return 0;
    }

    if(self.damagelocation == var_2) {
      return 1;
    }

    if(!isDefined(var_3)) {
      return 0;
    }

    if(self.damagelocation == var_3) {
      return 1;
    }

    if(!isDefined(var_4)) {
      return 0;
    }

    if(self.damagelocation == var_4) {
      return 1;
    }

    if(!isDefined(var_5)) {
      return 0;
    }

    if(self.damagelocation == var_5) {
      return 1;
    }

    if(!isDefined(var_6)) {
      return 0;
    }

    if(self.damagelocation == var_6) {
      return 1;
    }

    if(!isDefined(var_7)) {
      return 0;
    }

    if(self.damagelocation == var_7) {
      return 1;
    }

    if(!isDefined(var_8)) {
      return 0;
    }

    if(self.damagelocation == var_8) {
      return 1;
    }

    if(!isDefined(var_9)) {
      return 0;
    }

    if(self.damagelocation == var_9) {
      return 1;
    }

    if(!isDefined(var_10)) {
      return 0;
    }

    if(self.damagelocation == var_10) {
      return 1;
    }
  }

  return damagesubpartlocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

damagesubpartlocationisany(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self.damagedsubpart)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(self.damagedsubpart == var_0) {
    return 1;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(self.damagedsubpart == var_1) {
    return 1;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(self.damagedsubpart == var_2) {
    return 1;
  }

  if(!isDefined(var_3)) {
    return 0;
  }

  if(self.damagedsubpart == var_3) {
    return 1;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  if(self.damagedsubpart == var_4) {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 0;
  }

  if(self.damagedsubpart == var_5) {
    return 1;
  }

  if(!isDefined(var_6)) {
    return 0;
  }

  if(self.damagedsubpart == var_6) {
    return 1;
  }

  if(!isDefined(var_7)) {
    return 0;
  }

  if(self.damagedsubpart == var_7) {
    return 1;
  }

  if(!isDefined(var_8)) {
    return 0;
  }

  if(self.damagedsubpart == var_8) {
    return 1;
  }

  if(!isDefined(var_9)) {
    return 0;
  }

  if(self.damagedsubpart == var_9) {
    return 1;
  }

  if(!isDefined(var_10)) {
    return 0;
  }

  if(self.damagedsubpart == var_10) {
    return 1;
  }

  return 0;
}

isbulletdamage(var_0) {
  var_1 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

  if(issubstr(var_1, var_0)) {
    return 1;
  }

  return 0;
}

isnodecoverleft(var_0) {
  return var_0.type == "Cover Left";
}

isnodecoverright(var_0) {
  return var_0.type == "Cover Right";
}

isnode3d(var_0) {
  return isnodecover3d(var_0) || isnodeexposed3d(var_0);
}

isnodecover3d(var_0) {
  return var_0.type == "Cover Stand 3D" || var_0.type == "Cover 3D";
}

isnodeexposed3d(var_0) {
  return var_0.type == "Exposed 3D" || var_0.type == "Path 3D";
}

isnodecovercrouch(var_0) {
  return var_0.type == "Cover Crouch" || var_0.type == "Cover Crouch Window" || var_0.type == "Conceal Crouch";
}

absangleclamp180(var_0) {
  return abs(angleclamp180(var_0));
}

getaimyawtopoint(var_0) {
  var_1 = getyawtospot(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = atan(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

getyawtospot(var_0) {
  if(actor_is3d()) {
    var_1 = anglesToForward(self.angles);
    var_2 = rotatepointaroundvector(var_1, var_0 - self.origin, self.angles[2] * -1);
    var_0 = var_2 + self.origin;
  }

  var_3 = getyaw(var_0) - self.angles[1];
  var_3 = angleclamp180(var_3);
  return var_3;
}

getyaw(var_0) {
  return vectortoyaw(var_0 - self.origin);
}

getaimyawtopoint3d(var_0) {
  var_1 = getyawtospot3d(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = atan(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

getyawtospot3d(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = rotatevectorinverted(var_1, self.angles);
  var_3 = vectortoyaw(var_2);
  var_4 = angleclamp180(var_3);
  return var_4;
}

getaimpitchtopoint3d(var_0) {
  var_1 = getpitchtospot3d(var_0);
  var_2 = distance(self.origin, var_0);

  if(var_2 > 3) {
    var_3 = atan(-3 / var_2);
    var_1 = var_1 - var_3;
  }

  var_1 = angleclamp180(var_1);
  return var_1;
}

getpitchtospot3d(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = rotatevectorinverted(var_1, self.angles);
  var_3 = _vectortopitch(var_2);
  var_4 = angleclamp180(var_3);
  return var_4;
}

actor_isspace() {
  return is_true(self.space);
}

actor_is3d() {
  return actor_isspace();
}

getpredictedaimyawtoshootentorpos(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return getaimyawtopoint(var_2);
  }

  var_3 = (0, 0, 0);

  if(isplayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1.velocity;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return getaimyawtopoint(var_4);
}

getpredictedaimyawtoshootentorpos3d(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return getaimyawtopoint3d(var_2);
  }

  var_3 = (0, 0, 0);

  if(isplayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1.velocity;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return getaimyawtopoint3d(var_4);
}

getpredictedaimpitchtoshootentorpos3d(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    if(!isDefined(var_2)) {
      return 0;
    }

    return getaimpitchtopoint3d(var_2);
  }

  var_3 = (0, 0, 0);

  if(isplayer(var_1)) {
    var_3 = var_1 getvelocity();
  } else if(isai(var_1)) {
    var_3 = var_1.velocity;
  }

  var_4 = var_1.origin + var_3 * var_0;
  return getaimpitchtopoint3d(var_4);
}

meleegrab_ksweapon_used() {
  var_0 = ["mars_killstreak", "iw7_jackal_support_designator"];

  if(array_contains(var_0, level.player getcurrentweapon())) {
    return 1;
  }

  if(level.player isdroppingweapon()) {
    return 1;
  }

  if(level.player israisingweapon()) {
    if(array_contains(var_0, level.player getcurrentweapon())) {
      return 1;
    }
  }

  return 0;
}

wasdamagedbyoffhandshield() {
  if(!isDefined(self.damagemod) || self.damagemod != "MOD_MELEE") {
    return 0;
  }

  if(!isDefined(self.damageweapon) || weapontype(self.damageweapon) != "shield") {
    return 0;
  }

  return 1;
}

is_true(var_0) {
  if(isDefined(var_0) && var_0) {
    return 1;
  }

  return 0;
}

player_is_in_jackal() {
  if(isDefined(level.player _meth_8473())) {
    return 1;
  } else {
    return 0;
  }
}

set_createfx_enabled() {
  if(!isDefined(level.createfx_enabled)) {
    level.createfx_enabled = getdvar("createfx") != "";
  }
}

flag_set_delayed(var_0, var_1, var_2) {
  wait(var_1);
  flag_set(var_0, var_2);
}

noself_array_call(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3, var_4);
    }

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2, var_3);
    }

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {
      call[[var_1]](var_6, var_2);
    }

    return;
  }

  foreach(var_6 in var_0) {
    call[[var_1]](var_6);
  }
}

flag_assert(var_0) {}

flag_wait_either(var_0, var_1) {
  for(;;) {
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
  for(;;) {
    if(flag(var_0)) {
      return var_0;
    }

    if(flag(var_1)) {
      return var_1;
    }

    var_2 = level waittill_any_return(var_0, var_1);
    return var_2;
  }
}

flag_wait_any(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(isDefined(var_5)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
    var_6[var_6.size] = var_5;
  } else if(isDefined(var_4)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
    var_6[var_6.size] = var_4;
  } else if(isDefined(var_3)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
    var_6[var_6.size] = var_3;
  } else if(isDefined(var_2)) {
    var_6[var_6.size] = var_0;
    var_6[var_6.size] = var_1;
    var_6[var_6.size] = var_2;
  } else if(isDefined(var_1)) {
    flag_wait_either(var_0, var_1);
    return;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(flag(var_6[var_7])) {
        return;
      }
    }

    level waittill_any(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

flag_wait_any_return(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(isDefined(var_4)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
    var_5[var_5.size] = var_4;
  } else if(isDefined(var_3)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
    var_5[var_5.size] = var_3;
  } else if(isDefined(var_2)) {
    var_5[var_5.size] = var_0;
    var_5[var_5.size] = var_1;
    var_5[var_5.size] = var_2;
  } else if(isDefined(var_1)) {
    var_6 = flag_wait_either_return(var_0, var_1);
    return var_6;
  } else
    return;

  for(;;) {
    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(flag(var_5[var_7])) {
        return var_5[var_7];
      }
    }

    var_6 = level waittill_any_return(var_0, var_1, var_2, var_3, var_4);
    return var_6;
  }
}

flag_wait_all(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    flag_wait(var_0);
  }

  if(isDefined(var_1)) {
    flag_wait(var_1);
  }

  if(isDefined(var_2)) {
    flag_wait(var_2);
  }

  if(isDefined(var_3)) {
    flag_wait(var_3);
  }
}

flag_wait_or_timeout(var_0, var_1) {
  var_2 = var_1 * 1000;
  var_3 = gettime();

  for(;;) {
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

  for(;;) {
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

noself_delaycall(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread noself_delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5);
}

noself_delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(var_1);

  if(isDefined(var_5)) {
    call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    call[[var_0]](var_2);
  } else {
    call[[var_0]]();
  }
}

get_target_array(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.target;
  }

  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }

  if(issp()) {
    var_1 = call[[level.getnodearrayfunction]](var_0, "targetname");

    if(var_1.size > 0) {
      return var_1;
    }
  }

  var_1 = getstructarray(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }

  var_1 = getvehiclenodearray(var_0, "targetname");

  if(var_1.size > 0) {
    return var_1;
  }
}

pauseeffect() {
  scripts\common\createfx::stop_fx_looper();
}

spawn_script_origin(var_0, var_1) {
  if(!isDefined(var_1) && isDefined(self.angles)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_0) && isDefined(self.origin)) {
    var_0 = self.origin;
  } else if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  var_2 = spawn("script_origin", var_0);

  if(isDefined(var_1)) {
    var_2.angles = var_1;
  }

  return var_2;
}

allow_lean(var_0) {
  if(var_0) {
    if(!isDefined(self.disabledlean)) {
      self.disabledlean = 0;
    } else {
      self.disabledlean--;
    }

    if(!self.disabledlean) {
      self allowlean(1);
    }
  } else {
    if(!isDefined(self.disabledlean)) {
      self.disabledlean = 0;
    }

    self.disabledlean++;
    self allowlean(0);
  }
}

allow_reload(var_0, var_1) {
  if(var_0) {
    if(!isDefined(self.disabledreload)) {
      self.disabledreload = 0;
    } else {
      self.disabledreload--;
    }

    if(!self.disabledreload) {
      self allowreload(1);
    }
  } else {
    if(!isDefined(self.disabledreload)) {
      self.disabledreload = 0;
    }

    self.disabledreload++;
    self allowreload(0);

    if(!isDefined(var_1) || !var_1) {
      self _meth_8545();
    }
  }
}

allow_autoreload(var_0) {
  if(var_0) {
    if(!isDefined(self.disableautoreload)) {
      self.disableautoreload = 0;
    } else {
      self.disableautoreload--;
    }

    if(!self.disableautoreload) {
      self getrankforxp();
    }
  } else {
    if(!isDefined(self.disableautoreload)) {
      self.disableautoreload = 0;
    }

    self.disableautoreload++;
    self disableautoreload();
  }
}

forceenable_weapon_MAYBE() {
  self.disabledweapon = 0;
  self enableweapons();
}

forceenable_fire_MAYBE() {
  self.disabledfire = 0;
  self allowfire(1);
}

forceenable_melee_MAYBE() {
  self.disabledmelee = 0;
  self allowmelee(1);
}

get_noteworthy_array(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }

  if(issp()) {
    var_1 = call[[level.getnodearrayfunction]](var_0, "script_noteworthy");

    if(var_1.size > 0) {
      return var_1;
    }
  }

  var_1 = getstructarray(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }

  var_1 = getvehiclenodearray(var_0, "script_noteworthy");

  if(var_1.size > 0) {
    return var_1;
  }
}

get_cumulative_weights(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_2 + var_0[var_3];
    var_1[var_3] = var_2;
  }

  return var_1;
}

void() {}

func_9DA3() {
  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(!issentient(self.enemy)) {
    return 1;
  }

  if(self getpersstat(self.enemy)) {
    return 1;
  }

  var_0 = self lastknowntime(self.enemy);

  if(var_0 == 0) {
    return 0;
  }

  var_1 = gettime() - var_0;

  if(var_1 > 10000) {
    return 0;
  }

  if(distancesquared(self.enemy.origin, self.origin) > 4194304) {
    return 0;
  }

  return 1;
}

get_notetrack_time(var_0, var_1) {
  var_2 = getnotetracktimes(var_0, var_1);
  var_3 = getanimlength(var_0);
  return var_2[0] * var_3;
}

mph_to_ips(var_0) {
  return var_0 * 17.6;
}

ips_to_mph(var_0) {
  return var_0 * 0.056818;
}

closestdistancebetweenlines(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - var_2;
  var_5 = var_3 - var_2;

  if(abs(var_5[0]) < 0.000001 && abs(var_5[1]) < 0.000001 && abs(var_5[2]) < 0.000001) {
    return undefined;
  }

  var_6 = var_1 - var_0;

  if(abs(var_6[0]) < 0.000001 && abs(var_6[1]) < 0.000001 && abs(var_6[2]) < 0.000001) {
    return undefined;
  }

  var_7 = var_4[0] * var_5[0] + var_4[1] * var_5[1] + var_4[2] * var_5[2];
  var_8 = var_5[0] * var_6[0] + var_5[1] * var_6[1] + var_5[2] * var_6[2];
  var_9 = var_4[0] * var_6[0] + var_4[1] * var_6[1] + var_4[2] * var_6[2];
  var_10 = var_5[0] * var_5[0] + var_5[1] * var_5[1] + var_5[2] * var_5[2];
  var_11 = var_6[0] * var_6[0] + var_6[1] * var_6[1] + var_6[2] * var_6[2];
  var_12 = var_11 * var_10 - var_8 * var_8;

  if(abs(var_12) < 0.000001) {
    return undefined;
  }

  var_13 = var_7 * var_8 - var_9 * var_10;
  var_14 = var_13 / var_12;
  var_15 = (var_7 + var_8 * var_14) / var_10;
  var_16 = var_0 + var_14 * var_6;
  var_17 = var_2 + var_15 * var_5;
  var_18 = [var_16, var_17, distance(var_16, var_17)];
  return var_18;
}

closestdistancebetweensegments(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = var_3 - var_2;
  var_6 = var_0 - var_2;
  var_7 = vectordot(var_4, var_4);
  var_8 = vectordot(var_4, var_5);
  var_9 = vectordot(var_5, var_5);
  var_10 = vectordot(var_4, var_6);
  var_11 = vectordot(var_5, var_6);
  var_12 = var_7 * var_9 - var_8 * var_8;
  var_13 = var_12;
  var_14 = var_12;
  var_15 = 0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;

  if(var_12 < 0.00000001) {
    var_16 = 0;
    var_13 = 1;
    var_18 = var_11;
    var_14 = var_9;
  } else {
    var_16 = var_8 * var_11 - var_9 * var_10;
    var_18 = var_7 * var_11 - var_8 * var_10;

    if(var_16 < 0.0) {
      var_16 = 0;
      var_18 = var_11;
      var_14 = var_9;
    } else if(var_16 > var_13) {
      var_16 = var_13;
      var_18 = var_11 + var_8;
      var_14 = var_9;
    }
  }

  if(var_18 < 0.0) {
    var_18 = 0.0;

    if(var_10 * -1 < 0.0) {
      var_16 = 0.0;
    } else if(var_10 * -1 > var_7) {
      var_16 = var_13;
    } else {
      var_16 = var_10 * -1;
      var_13 = var_7;
    }
  } else if(var_18 > var_14) {
    var_18 = var_14;

    if(var_8 - var_10 < 0.0) {
      var_16 = 0;
    } else if(var_8 - var_10 > var_7) {
      var_16 = var_13;
    } else {
      var_16 = var_8 - var_10;
      var_13 = var_7;
    }
  }

  if(abs(var_16) > 0.00000001) {
    var_15 = var_16 / var_13;
  }

  if(abs(var_18) > 0.00000001) {
    var_17 = var_18 / var_14;
  }

  var_19 = var_0 + var_15 * var_4;
  var_20 = var_2 + var_17 * var_5;
  var_21 = [var_19, var_20, distance(var_19, var_20)];
  return var_21;
}

getcamotablecolumnindex(var_0) {
  switch (var_0) {
    case "index":
      return 0;
    case "ref":
      return 1;
    case "type":
      return 2;
    case "target_material":
      return 3;
    case "tint":
      return 4;
    case "atlas_dims":
      return 5;
    case "name":
      return 6;
    case "image":
      return 7;
    case "weapon_index":
      return 8;
    case "bot_valid":
      return 9;
    case "description":
      return 10;
    case "category":
      return 11;
    default:
      return undefined;
  }
}