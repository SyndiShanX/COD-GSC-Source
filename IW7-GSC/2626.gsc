/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2626.gsc
***************************************/

noself_func(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(level.func)) {
    return;
  }
  if(!isDefined(level.func[var_00])) {
    return;
  }
  if(!isDefined(var_01)) {
    call[[level.func[var_00]]]();
    return;
  }

  if(!isDefined(var_02)) {
    call[[level.func[var_00]]](var_01);
    return;
  }

  if(!isDefined(var_03)) {
    call[[level.func[var_00]]](var_01, var_02);
    return;
  }

  if(!isDefined(var_04)) {
    call[[level.func[var_00]]](var_01, var_02, var_03);
    return;
  }

  call[[level.func[var_00]]](var_01, var_02, var_03, var_04);
}

self_func(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(level.func[var_00])) {
    return;
  }
  if(!isDefined(var_01)) {
    self call[[level.func[var_00]]]();
    return;
  }

  if(!isDefined(var_02)) {
    self call[[level.func[var_00]]](var_01);
    return;
  }

  if(!isDefined(var_03)) {
    self call[[level.func[var_00]]](var_01, var_02);
    return;
  }

  if(!isDefined(var_04)) {
    self call[[level.func[var_00]]](var_01, var_02, var_03);
    return;
  }

  self call[[level.func[var_00]]](var_01, var_02, var_03, var_04);
}

anglebetweenvectors(var_00, var_01) {
  return acos(vectordot(var_00, var_01) / (length(var_00) * length(var_01)));
}

anglebetweenvectorsunit(var_00, var_01) {
  return acos(vectordot(var_00, var_01));
}

anglebetweenvectorssigned(var_00, var_01, var_02) {
  var_03 = vectornormalize(var_00);
  var_04 = vectornormalize(var_01);
  var_05 = acos(clamp(vectordot(var_03, var_04), -1, 1));
  var_06 = vectorcross(var_03, var_04);

  if(vectordot(var_06, var_02) < 0)
    var_05 = var_05 * -1;

  return var_05;
}

segmentvssphere(var_00, var_01, var_02, var_03) {
  if(var_00 == var_01)
    return 0;

  var_04 = var_02 - var_00;
  var_05 = var_01 - var_00;
  var_06 = clamp(vectordot(var_04, var_05) / vectordot(var_05, var_05), 0, 1);
  var_07 = var_00 + var_05 * var_06;
  return lengthsquared(var_02 - var_07) <= var_03 * var_03;
}

randomvector(var_00) {
  return (randomfloat(var_00) - var_00 * 0.5, randomfloat(var_00) - var_00 * 0.5, randomfloat(var_00) - var_00 * 0.5);
}

randomvectorrange(var_00, var_01) {
  var_02 = randomfloatrange(var_00, var_01);

  if(randomint(2) == 0)
    var_02 = var_02 * -1;

  var_03 = randomfloatrange(var_00, var_01);

  if(randomint(2) == 0)
    var_03 = var_03 * -1;

  var_04 = randomfloatrange(var_00, var_01);

  if(randomint(2) == 0)
    var_04 = var_04 * -1;

  return (var_02, var_03, var_04);
}

sign(var_00) {
  if(var_00 >= 0)
    return 1;

  return -1;
}

mod(var_00, var_01) {
  var_02 = int(var_00 / var_01);

  if(var_00 * var_01 < 0)
    var_02 = var_02 - 1;

  return var_00 - var_02 * var_01;
}

get_enemy_team(var_00) {
  var_01 = [];
  var_1["axis"] = "allies";
  var_1["allies"] = "axis";
  return var_1[var_00];
}

clear_exception(var_00) {
  self.exception[var_00] = anim.defaultexception;
}

cointoss() {
  return randomint(100) >= 50;
}

choose_from_weighted_array(var_00, var_01) {
  var_02 = randomint(var_1[var_1.size - 1] + 1);

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    if(var_02 <= var_1[var_03])
      return var_0[var_03];
  }
}

waittill_string(var_00, var_01) {
  if(var_00 != "death")
    self endon("death");

  var_01 endon("die");
  self waittill(var_00);
  var_01 notify("returned", var_00);
}

waittillmatch_string(var_00, var_01, var_02) {
  if(var_01 != "death")
    self endon("death");

  var_02 endon("die");
  self waittillmatch(var_00, var_01);
  var_02 notify("returned", var_01);
}

waittill_string_no_endon_death(var_00, var_01) {
  var_01 endon("die");
  self waittill(var_00);
  var_01 notify("returned", var_00);
}

waittill_multiple(var_00, var_01, var_02, var_03, var_04) {
  self endon("death");
  var_05 = spawnStruct();
  var_5.threads = 0;

  if(isDefined(var_00)) {
    childthread waittill_string(var_00, var_05);
    var_5.threads++;
  }

  if(isDefined(var_01)) {
    childthread waittill_string(var_01, var_05);
    var_5.threads++;
  }

  if(isDefined(var_02)) {
    childthread waittill_string(var_02, var_05);
    var_5.threads++;
  }

  if(isDefined(var_03)) {
    childthread waittill_string(var_03, var_05);
    var_5.threads++;
  }

  if(isDefined(var_04)) {
    childthread waittill_string(var_04, var_05);
    var_5.threads++;
  }

  while(var_5.threads) {
    var_05 waittill("returned");
    var_5.threads--;
  }

  var_05 notify("die");
}

waittillmatch_notify(var_00, var_01, var_02) {
  self endon("death");
  self waittillmatch(var_00, var_01);
  self notify(var_02);
}

waittill_any_return(var_00, var_01, var_02, var_03, var_04, var_05) {
  if((!isDefined(var_00) || var_00 != "death") && (!isDefined(var_01) || var_01 != "death") && (!isDefined(var_02) || var_02 != "death") && (!isDefined(var_03) || var_03 != "death") && (!isDefined(var_04) || var_04 != "death") && (!isDefined(var_05) || var_05 != "death"))
    self endon("death");

  var_06 = spawnStruct();

  if(isDefined(var_00))
    childthread waittill_string(var_00, var_06);

  if(isDefined(var_01))
    childthread waittill_string(var_01, var_06);

  if(isDefined(var_02))
    childthread waittill_string(var_02, var_06);

  if(isDefined(var_03))
    childthread waittill_string(var_03, var_06);

  if(isDefined(var_04))
    childthread waittill_string(var_04, var_06);

  if(isDefined(var_05))
    childthread waittill_string(var_05, var_06);

  var_06 waittill("returned", var_07);
  var_06 notify("die");
  return var_07;
}

waittillmatch_any_return(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if((!isDefined(var_01) || var_01 != "death") && (!isDefined(var_02) || var_02 != "death") && (!isDefined(var_03) || var_03 != "death") && (!isDefined(var_04) || var_04 != "death") && (!isDefined(var_05) || var_05 != "death") && (!isDefined(var_06) || var_06 != "death"))
    self endon("death");

  var_07 = spawnStruct();

  if(isDefined(var_01))
    childthread waittillmatch_string(var_00, var_01, var_07);

  if(isDefined(var_02))
    childthread waittillmatch_string(var_00, var_02, var_07);

  if(isDefined(var_03))
    childthread waittillmatch_string(var_00, var_03, var_07);

  if(isDefined(var_04))
    childthread waittillmatch_string(var_00, var_04, var_07);

  if(isDefined(var_05))
    childthread waittillmatch_string(var_00, var_05, var_07);

  if(isDefined(var_06))
    childthread waittillmatch_string(var_00, var_06, var_07);

  var_07 waittill("returned", var_08);
  var_07 notify("die");
  return var_08;
}

waittill_any_return_no_endon_death(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnStruct();

  if(isDefined(var_00))
    childthread waittill_string_no_endon_death(var_00, var_06);

  if(isDefined(var_01))
    childthread waittill_string_no_endon_death(var_01, var_06);

  if(isDefined(var_02))
    childthread waittill_string_no_endon_death(var_02, var_06);

  if(isDefined(var_03))
    childthread waittill_string_no_endon_death(var_03, var_06);

  if(isDefined(var_04))
    childthread waittill_string_no_endon_death(var_04, var_06);

  if(isDefined(var_05))
    childthread waittill_string_no_endon_death(var_05, var_06);

  var_06 waittill("returned", var_07);
  var_06 notify("die");
  return var_07;
}

waittill_any_in_array_return(var_00) {
  var_01 = spawnStruct();
  var_02 = 0;

  foreach(var_04 in var_00) {
    childthread waittill_string(var_04, var_01);

    if(var_04 == "death")
      var_02 = 1;
  }

  if(!var_02)
    self endon("death");

  var_01 waittill("returned", var_06);
  var_01 notify("die");
  return var_06;
}

waittill_any_in_array_return_no_endon_death(var_00) {
  var_01 = spawnStruct();

  foreach(var_03 in var_00)
  childthread waittill_string_no_endon_death(var_03, var_01);

  var_01 waittill("returned", var_05);
  var_01 notify("die");
  return var_05;
}

waittill_any_in_array_or_timeout(var_00, var_01) {
  var_02 = spawnStruct();
  var_03 = 0;

  foreach(var_05 in var_00) {
    childthread waittill_string(var_05, var_02);

    if(var_05 == "death")
      var_03 = 1;
  }

  if(!var_03)
    self endon("death");

  var_02 childthread _timeout(var_01);
  var_02 waittill("returned", var_07);
  var_02 notify("die");
  return var_07;
}

waittill_any_in_array_or_timeout_no_endon_death(var_00, var_01) {
  var_02 = spawnStruct();

  foreach(var_04 in var_00)
  childthread waittill_string_no_endon_death(var_04, var_02);

  var_02 thread _timeout(var_01);
  var_02 waittill("returned", var_06);
  var_02 notify("die");
  return var_06;
}

waittill_any_timeout(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if((!isDefined(var_01) || var_01 != "death") && (!isDefined(var_02) || var_02 != "death") && (!isDefined(var_03) || var_03 != "death") && (!isDefined(var_04) || var_04 != "death") && (!isDefined(var_05) || var_05 != "death") && (!isDefined(var_06) || var_06 != "death"))
    self endon("death");

  var_07 = spawnStruct();

  if(isDefined(var_01))
    childthread waittill_string(var_01, var_07);

  if(isDefined(var_02))
    childthread waittill_string(var_02, var_07);

  if(isDefined(var_03))
    childthread waittill_string(var_03, var_07);

  if(isDefined(var_04))
    childthread waittill_string(var_04, var_07);

  if(isDefined(var_05))
    childthread waittill_string(var_05, var_07);

  if(isDefined(var_06))
    childthread waittill_string(var_06, var_07);

  var_07 childthread _timeout(var_00);
  var_07 waittill("returned", var_08);
  var_07 notify("die");
  return var_08;
}

_timeout(var_00) {
  self endon("die");
  wait(var_00);
  self notify("returned", "timeout");
}

waittill_any_timeout_no_endon_death(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnStruct();

  if(isDefined(var_01))
    childthread waittill_string_no_endon_death(var_01, var_06);

  if(isDefined(var_02))
    childthread waittill_string_no_endon_death(var_02, var_06);

  if(isDefined(var_03))
    childthread waittill_string_no_endon_death(var_03, var_06);

  if(isDefined(var_04))
    childthread waittill_string_no_endon_death(var_04, var_06);

  if(isDefined(var_05))
    childthread waittill_string_no_endon_death(var_05, var_06);

  var_06 childthread _timeout(var_00);
  var_06 waittill("returned", var_07);
  var_06 notify("die");
  return var_07;
}

waittill_any(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(isDefined(var_01))
    self endon(var_01);

  if(isDefined(var_02))
    self endon(var_02);

  if(isDefined(var_03))
    self endon(var_03);

  if(isDefined(var_04))
    self endon(var_04);

  if(isDefined(var_05))
    self endon(var_05);

  if(isDefined(var_06))
    self endon(var_06);

  if(isDefined(var_07))
    self endon(var_07);

  self waittill(var_00);
}

waittill_any_ents(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  if(isDefined(var_02) && isDefined(var_03))
    var_02 endon(var_03);

  if(isDefined(var_04) && isDefined(var_05))
    var_04 endon(var_05);

  if(isDefined(var_06) && isDefined(var_07))
    var_06 endon(var_07);

  if(isDefined(var_08) && isDefined(var_09))
    var_08 endon(var_09);

  if(isDefined(var_10) && isDefined(var_11))
    var_10 endon(var_11);

  if(isDefined(var_12) && isDefined(var_13))
    var_12 endon(var_13);

  var_00 waittill(var_01);
}

isflashed() {
  if(!isDefined(self.flashendtime))
    return 0;

  return gettime() < self.flashendtime;
}

flag_exist(var_00) {
  if(!isDefined(level.flag))
    return 0;

  return isDefined(level.flag[var_00]);
}

flag(var_00) {
  return level.flag[var_00];
}

flag_init(var_00) {
  if(!isDefined(level.flag))
    scripts\engine\flags::init_flags();

  level.flag[var_00] = 0;
  init_trigger_flags();

  if(!isDefined(level.trigger_flags[var_00]))
    level.trigger_flags[var_00] = [];

  if(getsubstr(var_00, 0, 3) == "aa_")
    thread[[level.func["sp_stat_tracking_func"]]](var_00);
}

empty_init_func(var_00) {}

flag_set(var_00, var_01) {
  level.flag[var_00] = 1;
  set_trigger_flag_permissions(var_00);

  if(isDefined(var_01))
    level notify(var_00, var_01);
  else
    level notify(var_00);
}

flag_wait(var_00) {
  var_01 = undefined;

  while(!flag(var_00)) {
    var_01 = undefined;
    level waittill(var_00, var_01);
  }

  if(isDefined(var_01))
    return var_01;
}

flag_clear(var_00) {
  if(!flag(var_00)) {
    return;
  }
  level.flag[var_00] = 0;
  set_trigger_flag_permissions(var_00);
  level notify(var_00);
}

flag_waitopen(var_00) {
  while(flag(var_00))
    level waittill(var_00);
}

waittill_either(var_00, var_01) {
  self endon(var_00);
  self waittill(var_01);
  return var_01;
}

array_thread_safe(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(!isDefined(var_03)) {
    foreach(var_13 in var_00) {
      var_13 thread[[var_01]]();
      wait(var_02);
    }
  } else {
    if(!isDefined(var_04)) {
      foreach(var_13 in var_00) {
        var_13 thread[[var_01]](var_03);
        wait(var_02);
      }

      return;
    }

    if(!isDefined(var_05)) {
      foreach(var_13 in var_00) {
        var_13 thread[[var_01]](var_03, var_04);
        wait(var_02);
      }

      return;
    }

    if(!isDefined(var_06)) {
      foreach(var_13 in var_00) {
        var_13 thread[[var_01]](var_03, var_04, var_05);
        wait(var_02);
      }

      return;
    }

    if(!isDefined(var_07)) {
      foreach(var_13 in var_00) {
        var_13 thread[[var_01]](var_03, var_04, var_05, var_06);
        wait(var_02);
      }

      return;
    }

    if(!isDefined(var_08)) {
      foreach(var_13 in var_00) {
        var_13 thread[[var_01]](var_03, var_04, var_05, var_06, var_07);
        wait(var_02);
      }

      return;
    }

    if(!isDefined(var_09)) {
      foreach(var_13 in var_00) {
        var_13 thread[[var_01]](var_03, var_04, var_05, var_06, var_07, var_08);
        wait(var_02);
      }

      return;
    }

    if(!isDefined(var_10)) {
      foreach(var_13 in var_00) {
        var_13 thread[[var_01]](var_03, var_04, var_05, var_06, var_07, var_08, var_09);
        wait(var_02);
      }

      return;
    }

    if(!isDefined(var_11)) {
      foreach(var_13 in var_00) {
        var_13 thread[[var_01]](var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
        wait(var_02);
      }

      return;
    }

    foreach(var_13 in var_00) {
      var_13 thread[[var_01]](var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
      wait(var_02);
    }
  }
}

array_thread(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(isDefined(var_10)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);

    return;
  }

  if(isDefined(var_09)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    return;
  }

  if(isDefined(var_08)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02, var_03, var_04, var_05, var_06, var_07, var_08);

    return;
  }

  if(isDefined(var_07)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02, var_03, var_04, var_05, var_06, var_07);

    return;
  }

  if(isDefined(var_06)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02, var_03, var_04, var_05, var_06);

    return;
  }

  if(isDefined(var_05)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02, var_03, var_04, var_05);

    return;
  }

  if(isDefined(var_04)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02, var_03, var_04);

    return;
  }

  if(isDefined(var_03)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02, var_03);

    return;
  }

  if(isDefined(var_02)) {
    foreach(var_12 in var_00)
    var_12 thread[[var_01]](var_02);

    return;
  }

  foreach(var_12 in var_00)
  var_12 thread[[var_01]]();
}

array_call(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isDefined(var_09)) {
    foreach(var_11 in var_00)
    var_11 call[[var_01]](var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

    return;
  }

  if(isDefined(var_08)) {
    foreach(var_11 in var_00)
    var_11 call[[var_01]](var_02, var_03, var_04, var_05, var_06, var_07, var_08);

    return;
  }

  if(isDefined(var_07)) {
    foreach(var_11 in var_00)
    var_11 call[[var_01]](var_02, var_03, var_04, var_05, var_06, var_07);

    return;
  }

  if(isDefined(var_06)) {
    foreach(var_11 in var_00)
    var_11 call[[var_01]](var_02, var_03, var_04, var_05, var_06);

    return;
  }

  if(isDefined(var_05)) {
    foreach(var_11 in var_00)
    var_11 call[[var_01]](var_02, var_03, var_04, var_05);

    return;
  }

  if(isDefined(var_04)) {
    foreach(var_11 in var_00)
    var_11 call[[var_01]](var_02, var_03, var_04);

    return;
  }

  if(isDefined(var_03)) {
    foreach(var_11 in var_00)
    var_11 call[[var_01]](var_02, var_03);

    return;
  }

  if(isDefined(var_02)) {
    foreach(var_11 in var_00)
    var_11 call[[var_01]](var_02);

    return;
  }

  foreach(var_11 in var_00)
  var_11 call[[var_01]]();
}

trigger_on(var_00, var_01) {
  if(isDefined(var_00) && isDefined(var_01)) {
    var_02 = getEntArray(var_00, var_01);
    array_thread(var_02, ::trigger_on_proc);
  } else
    trigger_on_proc();
}

trigger_on_proc() {
  if(isDefined(self.realorigin))
    self.origin = self.realorigin;

  self.trigger_off = undefined;
}

trigger_off(var_00, var_01) {
  if(isDefined(var_00) && isDefined(var_01)) {
    var_02 = getEntArray(var_00, var_01);
    array_thread(var_02, ::trigger_off_proc);
  } else
    trigger_off_proc();
}

trigger_off_proc() {
  if(!isDefined(self.realorigin))
    self.realorigin = self.origin;

  if(self.origin == self.realorigin)
    self.origin = self.origin + (0, 0, -10000);

  self.trigger_off = 1;
  self notify("trigger_off");
}

set_trigger_flag_permissions(var_00) {
  if(!isDefined(level.trigger_flags)) {
    return;
  }
  level.trigger_flags[var_00] = array_removeundefined(level.trigger_flags[var_00]);
  array_thread(level.trigger_flags[var_00], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  var_00 = 1;

  if(isDefined(self.script_flag_true)) {
    var_00 = 0;
    var_01 = create_flags_and_return_tokens(self.script_flag_true);

    foreach(var_03 in var_01) {
      if(flag(var_03)) {
        var_00 = 1;
        break;
      }
    }
  }

  var_05 = 1;

  if(isDefined(self.script_flag_false)) {
    var_01 = create_flags_and_return_tokens(self.script_flag_false);

    foreach(var_03 in var_01) {
      if(flag(var_03)) {
        var_05 = 0;
        break;
      }
    }
  }

  [
    [level.trigger_func[var_00 && var_05]]
  ]();
}

create_flags_and_return_tokens(var_00) {
  var_01 = strtok(var_00, " ");

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(!isDefined(level.flag[var_1[var_02]]))
      flag_init(var_1[var_02]);
  }

  return var_01;
}

init_trigger_flags() {
  if(!add_init_script("trigger_flags", ::init_trigger_flags)) {
    return;
  }
  level.trigger_flags = [];
  level.trigger_func[1] = ::trigger_on;
  level.trigger_func[0] = ::trigger_off;
}

getstruct(var_00, var_01) {
  var_02 = level.struct_class_names[var_01][var_00];

  if(!isDefined(var_02))
    return undefined;

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

getstructarray(var_00, var_01) {
  var_02 = level.struct_class_names[var_01][var_00];

  if(!isDefined(var_02))
    return [];

  return var_02;
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

  foreach(var_03, var_01 in level.struct) {
    if(isDefined(var_1.targetname)) {
      if(var_1.targetname == "delete_on_load") {
        level.struct[var_03] = undefined;
        continue;
      }

      if(!isDefined(level.struct_class_names["targetname"][var_1.targetname]))
        level.struct_class_names["targetname"][var_1.targetname] = [];

      var_02 = level.struct_class_names["targetname"][var_1.targetname].size;
      level.struct_class_names["targetname"][var_1.targetname][var_02] = var_01;
    }

    if(isDefined(var_1.target)) {
      if(!isDefined(level.struct_class_names["target"][var_1.target]))
        level.struct_class_names["target"][var_1.target] = [];

      var_02 = level.struct_class_names["target"][var_1.target].size;
      level.struct_class_names["target"][var_1.target][var_02] = var_01;
    }

    if(isDefined(var_1.script_noteworthy)) {
      if(!isDefined(level.struct_class_names["script_noteworthy"][var_1.script_noteworthy]))
        level.struct_class_names["script_noteworthy"][var_1.script_noteworthy] = [];

      var_02 = level.struct_class_names["script_noteworthy"][var_1.script_noteworthy].size;
      level.struct_class_names["script_noteworthy"][var_1.script_noteworthy][var_02] = var_01;
    }

    if(isDefined(var_1.script_linkname)) {
      if(!isDefined(level.struct_class_names["script_linkname"][var_1.script_linkname]))
        level.struct_class_names["script_linkname"][var_1.script_linkname] = [];

      var_02 = level.struct_class_names["script_linkname"][var_1.script_linkname].size;
      level.struct_class_names["script_linkname"][var_1.script_linkname][var_02] = var_01;
    }
  }
}

fileprint_start(var_00) {}

fileprint_map_start() {}

fileprint_map_header(var_00) {
  if(!isDefined(var_00))
    var_00 = 0;
}

fileprint_map_keypairprint(var_00, var_01) {}

fileprint_map_entity_start() {}

fileprint_map_entity_end() {}

fileprint_radiant_vec(var_00) {}

array_remove(var_00, var_01) {
  var_02 = [];

  foreach(var_04 in var_00) {
    if(var_04 != var_01)
      var_2[var_2.size] = var_04;
  }

  return var_02;
}

array_remove_array(var_00, var_01) {
  foreach(var_03 in var_01)
  var_00 = array_remove(var_00, var_03);

  return var_00;
}

array_removeundefined(var_00) {
  var_01 = [];

  foreach(var_04, var_03 in var_00) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

array_remove_duplicates(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!isDefined(var_03)) {
      continue;
    }
    var_04 = 1;

    foreach(var_06 in var_01) {
      if(var_03 == var_06) {
        var_04 = 0;
        break;
      }
    }

    if(var_04)
      var_1[var_1.size] = var_03;
  }

  return var_01;
}

array_levelthread(var_00, var_01, var_02, var_03, var_04) {
  if(isDefined(var_04)) {
    foreach(var_06 in var_00)
    thread[[var_01]](var_06, var_02, var_03, var_04);

    return;
  }

  if(isDefined(var_03)) {
    foreach(var_06 in var_00)
    thread[[var_01]](var_06, var_02, var_03);

    return;
  }

  if(isDefined(var_02)) {
    foreach(var_06 in var_00)
    thread[[var_01]](var_06, var_02);

    return;
  }

  foreach(var_06 in var_00)
  thread[[var_01]](var_06);
}

array_levelcall(var_00, var_01, var_02, var_03, var_04) {
  if(isDefined(var_04)) {
    foreach(var_06 in var_00)
    call[[var_01]](var_06, var_02, var_03, var_04);

    return;
  }

  if(isDefined(var_03)) {
    foreach(var_06 in var_00)
    call[[var_01]](var_06, var_02, var_03);

    return;
  }

  if(isDefined(var_02)) {
    foreach(var_06 in var_00)
    call[[var_01]](var_06, var_02);

    return;
  }

  foreach(var_06 in var_00)
  call[[var_01]](var_06);
}

add_to_array(var_00, var_01) {
  if(!isDefined(var_01))
    return var_00;

  if(!isDefined(var_00))
    var_0[0] = var_01;
  else
    var_0[var_0.size] = var_01;

  return var_00;
}

exist_in_array_MAYBE(var_00, var_01) {
  var_02 = 0;

  if(var_0.size > 0) {
    foreach(var_04 in var_00) {
      if(var_04 == var_01) {
        var_02 = 1;
        break;
      }
    }
  }

  return var_02;
}

delaycall(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  thread delaycall_proc(var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
}

delaycall_proc(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  if(issp()) {
    self endon("death");
    self endon("stop_delay_call");
  }

  wait(var_01);

  if(isDefined(var_13))
    self call[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
  else if(isDefined(var_12))
    self call[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12);
  else if(isDefined(var_11))
    self call[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
  else if(isDefined(var_10))
    self call[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
  else if(isDefined(var_09))
    self call[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  else if(isDefined(var_08))
    self call[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07, var_08);
  else if(isDefined(var_07))
    self call[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07);
  else if(isDefined(var_06))
    self call[[var_00]](var_02, var_03, var_04, var_05, var_06);
  else if(isDefined(var_05))
    self call[[var_00]](var_02, var_03, var_04, var_05);
  else if(isDefined(var_04))
    self call[[var_00]](var_02, var_03, var_04);
  else if(isDefined(var_03))
    self call[[var_00]](var_02, var_03);
  else if(isDefined(var_02))
    self call[[var_00]](var_02);
  else
    self call[[var_00]]();
}

issp() {
  if(!isDefined(level.issp)) {
    var_00 = getdvar("mapname");
    var_01 = "";

    for(var_02 = 0; var_02 < min(var_0.size, 3); var_2++)
      var_01 = var_01 + var_0[var_02];

    level.issp = var_01 != "mp_" && var_01 != "cp_";
  }

  return level.issp;
}

iscp() {
  return string_starts_with(getdvar("mapname"), "cp_");
}

issp_towerdefense() {
  if(!isDefined(level.issp_towerdefense))
    level.issp_towerdefense = string_starts_with(getdvar("mapname"), "so_td_");

  return level.issp_towerdefense;
}

string_starts_with(var_00, var_01) {
  if(var_0.size < var_1.size)
    return 0;

  var_02 = getsubstr(var_00, 0, var_1.size);

  if(var_02 == var_01)
    return 1;

  return 0;
}

plot_points(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_0[0];

  if(!isDefined(var_01))
    var_01 = 1;

  if(!isDefined(var_02))
    var_02 = 1;

  if(!isDefined(var_03))
    var_03 = 1;

  if(!isDefined(var_04))
    var_04 = 0.05;

  for(var_06 = 1; var_06 < var_0.size; var_6++) {
    thread draw_line_for_time(var_05, var_0[var_06], var_01, var_02, var_03, var_04);
    var_05 = var_0[var_06];
  }
}

draw_line_for_time(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_05 = gettime() + var_05 * 1000;

  while(gettime() < var_05)
    wait 0.05;
}

array_combine(var_00, var_01, var_02, var_03) {
  var_04 = [];

  if(isDefined(var_00)) {
    foreach(var_06 in var_00)
    var_4[var_4.size] = var_06;
  }

  if(isDefined(var_01)) {
    foreach(var_06 in var_01)
    var_4[var_4.size] = var_06;
  }

  if(isDefined(var_02)) {
    foreach(var_06 in var_02)
    var_4[var_4.size] = var_06;
  }

  if(isDefined(var_03)) {
    foreach(var_06 in var_03)
    var_4[var_4.size] = var_06;
  }

  return var_04;
}

array_combine_multiple(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    foreach(var_05 in var_03)
    var_1[var_1.size] = var_05;
  }

  return var_01;
}

array_combine_unique(var_00, var_01) {
  var_02 = [];

  foreach(var_04 in var_00)
  var_2[var_2.size] = var_04;

  foreach(var_04 in var_01) {
    if(array_contains(var_02, var_04)) {
      continue;
    }
    var_2[var_2.size] = var_04;
  }

  return var_02;
}

array_combine_non_integer_indices(var_00, var_01) {
  var_02 = [];

  foreach(var_05, var_04 in var_00)
  var_2[var_05] = var_04;

  foreach(var_05, var_04 in var_01)
  var_2[var_05] = var_04;

  return var_02;
}

array_randomize(var_00) {
  for(var_01 = 0; var_01 <= var_0.size - 2; var_1++) {
    var_02 = randomintrange(var_01, var_0.size - 1);
    var_03 = var_0[var_01];
    var_0[var_01] = var_0[var_02];
    var_0[var_02] = var_03;
  }

  return var_00;
}

array_randomize_objects(var_00) {
  var_01 = [];

  for(var_02 = var_00; var_2.size > 0; var_02 = var_04) {
    var_03 = randomintrange(0, var_2.size);
    var_04 = [];
    var_05 = 0;

    foreach(var_08, var_07 in var_02) {
      if(var_05 == var_03)
        var_1[ter_op(isstring(var_08), var_08, var_1.size)] = var_07;
      else
        var_4[ter_op(isstring(var_08), var_08, var_4.size)] = var_07;

      var_5++;
    }
  }

  return var_01;
}

array_add(var_00, var_01) {
  var_0[var_0.size] = var_01;
  return var_00;
}

array_insert(var_00, var_01, var_02) {
  if(var_02 == var_0.size) {
    var_03 = var_00;
    var_3[var_3.size] = var_01;
    return var_03;
  }

  var_03 = [];
  var_04 = 0;

  for(var_05 = 0; var_05 < var_0.size; var_5++) {
    if(var_05 == var_02) {
      var_3[var_05] = var_01;
      var_04 = 1;
    }

    var_3[var_05 + var_04] = var_0[var_05];
  }

  return var_03;
}

array_contains(var_00, var_01) {
  if(var_0.size <= 0)
    return 0;

  foreach(var_03 in var_00) {
    if(var_03 == var_01)
      return 1;
  }

  return 0;
}

array_find(var_00, var_01) {
  foreach(var_04, var_03 in var_00) {
    if(var_03 == var_01)
      return var_04;
  }

  return undefined;
}

flat_angle(var_00) {
  var_01 = (0, var_0[1], 0);
  return var_01;
}

flat_origin(var_00) {
  var_01 = (var_0[0], var_0[1], 0);
  return var_01;
}

flatten_vector(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = (0, 0, 1);

  var_02 = vectornormalize(var_00 - vectordot(var_01, var_00) * var_01);
  return var_02;
}

draw_arrow_time(var_00, var_01, var_02, var_03) {
  level endon("newpath");
  var_04 = [];
  var_05 = vectortoangles(var_00 - var_01);
  var_06 = anglestoright(var_05);
  var_07 = anglesToForward(var_05);
  var_08 = anglestoup(var_05);
  var_09 = distance(var_00, var_01);
  var_10 = [];
  var_11 = 0.1;
  var_10[0] = var_00;
  var_10[1] = var_00 + var_06 * (var_09 * var_11) + var_07 * (var_09 * -0.1);
  var_10[2] = var_01;
  var_10[3] = var_00 + var_06 * (var_09 * (-1 * var_11)) + var_07 * (var_09 * -0.1);
  var_10[4] = var_00;
  var_10[5] = var_00 + var_08 * (var_09 * var_11) + var_07 * (var_09 * -0.1);
  var_10[6] = var_01;
  var_10[7] = var_00 + var_08 * (var_09 * (-1 * var_11)) + var_07 * (var_09 * -0.1);
  var_10[8] = var_00;
  var_12 = var_2[0];
  var_13 = var_2[1];
  var_14 = var_2[2];
  plot_points(var_10, var_12, var_13, var_14, var_03);
}

get_links() {
  return strtok(self.script_linkto, " ");
}

draw_arrow(var_00, var_01, var_02) {
  level endon("newpath");
  var_03 = [];
  var_04 = vectortoangles(var_00 - var_01);
  var_05 = anglestoright(var_04);
  var_06 = anglesToForward(var_04);
  var_07 = distance(var_00, var_01);
  var_08 = [];
  var_09 = 0.05;
  var_8[0] = var_00;
  var_8[1] = var_00 + var_05 * (var_07 * var_09) + var_06 * (var_07 * -0.2);
  var_8[2] = var_01;
  var_8[3] = var_00 + var_05 * (var_07 * (-1 * var_09)) + var_06 * (var_07 * -0.2);

  for(var_10 = 0; var_10 < 4; var_10++) {
    var_11 = var_10 + 1;

    if(var_11 >= 4)
      var_11 = 0;
  }
}

draw_capsule(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(!isDefined(var_03))
    var_03 = (0, 0, 0);

  if(!isDefined(var_05))
    var_05 = 0;

  if(!isDefined(var_06))
    var_06 = 1;

  var_07 = anglesToForward(var_03);
  var_08 = anglestoright(var_03);
  var_09 = anglestoup(var_03);
  var_10 = var_00 + var_09 * var_01;
  var_11 = var_00 + var_09 * var_02;
  var_11 = var_11 - var_09 * var_01;
  var_12 = var_10 + var_07 * var_01;
  var_13 = var_11 + var_07 * var_01;
  var_14 = var_10 - var_07 * var_01;
  var_15 = var_11 - var_07 * var_01;
  var_16 = var_10 + var_08 * var_01;
  var_17 = var_11 + var_08 * var_01;
  var_18 = var_10 - var_08 * var_01;
  var_19 = var_11 - var_08 * var_01;
}

draw_character_capsule(var_00, var_01, var_02) {
  var_03 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var_3["radius"], var_3["half_height"] * 2, self.angles, var_00, var_01, var_02);
}

draw_player_capsule(var_00, var_01, var_02) {
  var_03 = self physics_getcharactercollisioncapsule();
  draw_capsule(self getorigin(), var_3["radius"], var_3["half_height"] * 2, self getplayerangles(), var_00, var_01, var_02);
}

draw_ent_bone_forever(var_00, var_01) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    var_02 = self gettagorigin(var_00);
    var_03 = self gettagangles(var_00);
    draw_angles(var_03, var_02, var_01);
    waitframe();
  }
}

draw_ent_axis_forever(var_00, var_01) {
  self endon("stop_drawing_axis");
  self endon("death");

  for(;;) {
    draw_ent_axis(var_00, undefined, var_01);
    waitframe();
  }
}

draw_ent_axis(var_00, var_01, var_02) {
  waittillframeend;

  if(isDefined(self.angles))
    var_03 = self.angles;
  else
    var_03 = (0, 0, 0);

  draw_angles(var_03, self.origin, var_00, var_01, var_02);
}

draw_angles(var_00, var_01, var_02, var_03, var_04) {
  waittillframeend;
  var_05 = anglesToForward(var_00);
  var_06 = anglestoright(var_00);
  var_07 = anglestoup(var_00);

  if(!isDefined(var_02))
    var_02 = (1, 0, 1);

  if(!isDefined(var_03))
    var_03 = 1;

  if(!isDefined(var_04))
    var_04 = 10;
}

draw_entity_bounds(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_02))
    var_02 = (0, 1, 0);

  if(!isDefined(var_03))
    var_03 = 0;

  if(!isDefined(var_04))
    var_04 = 0.05;

  if(var_03)
    var_05 = int(var_04 / 0.05);
  else
    var_05 = int(var_01 / 0.05);

  var_06 = [];
  var_07 = [];
  var_08 = gettime();

  for(var_09 = var_08 + var_01 * 1000; var_08 < var_09 && isDefined(var_00); var_08 = gettime()) {
    var_6[0] = var_00 getpointinbounds(1, 1, 1);
    var_6[1] = var_00 getpointinbounds(1, 1, -1);
    var_6[2] = var_00 getpointinbounds(-1, 1, -1);
    var_6[3] = var_00 getpointinbounds(-1, 1, 1);
    var_7[0] = var_00 getpointinbounds(1, -1, 1);
    var_7[1] = var_00 getpointinbounds(1, -1, -1);
    var_7[2] = var_00 getpointinbounds(-1, -1, -1);
    var_7[3] = var_00 getpointinbounds(-1, -1, 1);

    for(var_10 = 0; var_10 < 4; var_10++) {
      var_11 = var_10 + 1;

      if(var_11 == 4)
        var_11 = 0;
    }

    if(!var_03) {
      return;
    }
    wait(var_04);
  }
}

getfx(var_00) {
  return level._effect[var_00];
}

fxexists(var_00) {
  return isDefined(level._effect[var_00]);
}

getlastweapon() {
  return self.saved_lastweapon;
}

playerunlimitedammothread() {}

isusabilityallowed() {
  return !isDefined(self.disabledusability) || !self.disabledusability;
}

allow_usability(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledusability))
      self.disabledusability = 0;

    self.disabledusability--;

    if(!self.disabledusability)
      self enableusability();
  } else {
    if(!isDefined(self.disabledusability))
      self.disabledusability = 0;

    self.disabledusability++;
    self disableusability();
  }
}

allow_weapon(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledweapon))
      self.disabledweapon = 0;

    self.disabledweapon--;

    if(!self.disabledweapon) {
      self enableweapons();

      if(isDefined(level.allow_weapon_func))
        self[[level.allow_weapon_func]](1);
    }
  } else {
    if(!isDefined(self.disabledweapon))
      self.disabledweapon = 0;

    if(!self.disabledweapon) {
      if(isDefined(level.allow_weapon_func))
        self[[level.allow_weapon_func]](0);

      self getradiuspathsighttestnodes();
    }

    self.disabledweapon++;
  }
}

isweaponallowed() {
  return !isDefined(self.disabledweapon) || !self.disabledweapon;
}

allow_weapon_switch(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledweaponswitch))
      self.disabledweaponswitch = 0;

    self.disabledweaponswitch--;

    if(!self.disabledweaponswitch)
      self enableweaponswitch();
  } else {
    if(!isDefined(self.disabledweaponswitch))
      self.disabledweaponswitch = 0;

    self.disabledweaponswitch++;
    self getraidspawnpoint();
  }
}

allow_offhand_weapons(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledoffhandweapons))
      self.disabledoffhandweapons = 0;

    self.disabledoffhandweapons--;

    if(!self.disabledoffhandweapons)
      self enableoffhandweapons();

    if(!isDefined(level.ismp) || level.ismp == 0)
      allow_offhand_shield_weapons(1);
  } else {
    if(!isDefined(self.disabledoffhandweapons))
      self.disabledoffhandweapons = 0;

    self.disabledoffhandweapons++;
    self getquadrant();

    if(!isDefined(level.ismp) || level.ismp == 0)
      allow_offhand_shield_weapons(0);
  }
}

allow_offhand_primary_weapons(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledoffhandprimaryweapons))
      self.disabledoffhandprimaryweapons = 0;
    else
      self.disabledoffhandprimaryweapons--;

    if(!self.disabledoffhandprimaryweapons)
      self grenade_earthquakeatposition_internal();
  } else {
    if(!isDefined(self.disabledoffhandprimaryweapons))
      self.disabledoffhandprimaryweapons = 0;

    self.disabledoffhandprimaryweapons++;
    self grenade_earthquakeatposition();
  }
}

allow_offhand_secondary_weapons(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledoffhandsecondaryweapons))
      self.disabledoffhandsecondaryweapons = 0;
    else
      self.disabledoffhandsecondaryweapons--;

    if(!self.disabledoffhandsecondaryweapons)
      self enableoffhandsecondaryweapons();

    allow_offhand_shield_weapons(1);
  } else {
    if(!isDefined(self.disabledoffhandsecondaryweapons))
      self.disabledoffhandsecondaryweapons = 0;

    self.disabledoffhandsecondaryweapons++;
    self disableoffhandsecondaryweapons();
    allow_offhand_shield_weapons(0);
  }
}

allow_offhand_shield_weapons(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledoffhandshieldweapons))
      self.disabledoffhandshieldweapons = 0;

    self.disabledoffhandshieldweapons--;

    if(!self.disabledoffhandshieldweapons)
      self allowoffhandshieldweapons(1);
  } else {
    if(!isDefined(self.disabledoffhandshieldweapons))
      self.disabledoffhandshieldweapons = 0;

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

allow_prone(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledprone))
      self.disabledprone = 0;
    else
      self.disabledprone--;

    if(!self.disabledprone)
      self getnumownedactiveagents(1);
  } else {
    if(!isDefined(self.disabledprone))
      self.disabledprone = 0;

    self.disabledprone++;
    self getnumownedactiveagents(0);
  }
}

allow_crouch(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledcrouch))
      self.disabledcrouch = 0;
    else
      self.disabledcrouch--;

    if(!self.disabledcrouch)
      self getnumberoffrozenticksfromwave(1);
  } else {
    if(!isDefined(self.disabledcrouch))
      self.disabledcrouch = 0;

    self.disabledcrouch++;
    self getnumberoffrozenticksfromwave(0);
  }
}

allow_stances(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledstances))
      self.disabledstances = 0;
    else
      self.disabledstances--;

    if(!self.disabledstances)
      self getnumownedjackals(1);
  } else {
    if(!isDefined(self.disabledstances))
      self.disabledstances = 0;

    self.disabledstances++;
    self getnumownedjackals(0);
  }
}

allow_sprint(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledsprint))
      self.disabledsprint = 0;
    else
      self.disabledsprint--;

    if(!self.disabledsprint)
      self getnumownedagentsonteambytype(1);
  } else {
    if(!isDefined(self.disabledsprint))
      self.disabledsprint = 0;

    self.disabledsprint++;
    self getnumownedagentsonteambytype(0);
  }
}

allow_mantle(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledmantle))
      self.disabledmantle = 0;
    else
      self.disabledmantle--;

    if(!self.disabledmantle)
      self allowmantle(1);
  } else {
    if(!isDefined(self.disabledmantle))
      self.disabledmantle = 0;

    self.disabledmantle++;
    self allowmantle(0);
  }
}

allow_fire(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledfire))
      self.disabledfire = 0;
    else
      self.disabledfire--;

    if(!self.disabledfire)
      self allowfire(1);
  } else {
    if(!isDefined(self.disabledfire))
      self.disabledfire = 0;

    self.disabledfire++;
    self allowfire(0);
  }
}

allow_ads(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledads))
      self.disabledads = 0;
    else
      self.disabledads--;

    if(!self.disabledads)
      self allowads(1);
  } else {
    if(!isDefined(self.disabledads))
      self.disabledads = 0;

    self.disabledads++;
    self allowads(0);
  }
}

allow_jump(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledjump))
      self.disabledjump = 0;
    else
      self.disabledjump--;

    if(!self.disabledjump)
      self allowjump(1);
  } else {
    if(!isDefined(self.disabledjump))
      self.disabledjump = 0;

    self.disabledjump++;
    self allowjump(0);
  }
}

allow_wallrun(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledwallrun))
      self.disabledwallrun = 0;
    else
      self.disabledwallrun--;

    if(!self.disabledwallrun)
      self allowwallrun(1);
  } else {
    if(!isDefined(self.disabledwallrun))
      self.disabledwallrun = 0;

    self.disabledwallrun++;
    self allowwallrun(0);
  }
}

allow_doublejump(var_00) {
  if(var_00) {
    if(!isDefined(self.disableddoublejump))
      self.disableddoublejump = 0;
    else
      self.disableddoublejump--;

    if(!self.disableddoublejump) {
      self goal_radius(0, self.doublejumpenergy);
      self goalflag(0, self.doublejumpenergyrestorerate);
      self.doublejumpenergy = undefined;
      self.doublejumpenergyrestorerate = undefined;
      self allowdoublejump(1);
    }
  } else {
    if(!isDefined(self.disableddoublejump))
      self.disableddoublejump = 0;

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

allow_melee(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledmelee))
      self.disabledmelee = 0;
    else
      self.disabledmelee--;

    if(!self.disabledmelee)
      self allowmelee(1);
  } else {
    if(!isDefined(self.disabledmelee))
      self.disabledmelee = 0;

    self.disabledmelee++;
    self allowmelee(0);
  }
}

allow_slide(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledslide))
      self.disabledslide = 0;
    else
      self.disabledslide--;

    if(!self.disabledslide)
      self allowslide(1);
  } else {
    if(!isDefined(self.disabledslide))
      self.disabledslide = 0;

    self.disabledslide++;
    self allowslide(0);
  }
}

get_doublejumpenergy() {
  if(!isDefined(self.doublejumpenergy))
    return self goal_position(0);

  return self.doublejumpenergy;
}

set_doublejumpenergy(var_00) {
  if(!isDefined(self.doublejumpenergy))
    self goal_radius(0, var_00);
  else
    self.doublejumpenergy = var_00;
}

get_doublejumpenergyrestorerate() {
  if(!isDefined(self.doublejumpenergyrestorerate))
    return self energy_getrestorerate(0);

  return self.doublejumpenergyrestorerate;
}

set_doublejumpenergyrestorerate(var_00) {
  if(!isDefined(self.doublejumpenergyrestorerate))
    self goalflag(0, var_00);
  else
    self.doublejumpenergyrestorerate = var_00;
}

random(var_00) {
  var_01 = [];

  foreach(var_04, var_03 in var_00)
  var_1[var_1.size] = var_03;

  if(!var_1.size)
    return undefined;

  return var_1[randomint(var_1.size)];
}

random_weight_sorted(var_00) {
  var_01 = [];

  foreach(var_04, var_03 in var_00)
  var_1[var_1.size] = var_03;

  if(!var_1.size)
    return undefined;

  var_05 = randomint(var_1.size * var_1.size);
  return var_1[var_1.size - 1 - int(sqrt(var_05))];
}

spawn_tag_origin(var_00, var_01) {
  if(!isDefined(var_01) && isDefined(self.angles))
    var_01 = self.angles;

  if(!isDefined(var_00) && isDefined(self.origin))
    var_00 = self.origin;
  else if(!isDefined(var_00))
    var_00 = (0, 0, 0);

  var_02 = spawn("script_model", var_00);
  var_02 setModel("tag_origin");
  var_02 hide();

  if(isDefined(var_01))
    var_2.angles = var_01;

  return var_02;
}

waittill_notify_or_timeout(var_00, var_01) {
  self endon(var_00);
  wait(var_01);
}

waittill_notify_or_timeout_return(var_00, var_01) {
  self endon(var_00);
  wait(var_01);
  return "timeout";
}

waittill_notify_and_time(var_00, var_01) {
  var_02 = gettime();
  self waittill(var_00);
  var_03 = var_02 + var_01 * 1000;
  var_04 = var_03 - var_02;

  if(var_04 > 0) {
    var_05 = var_04 / 1000.0;
    wait(var_05);
  }
}

fileprint_launcher_start_file() {
  level.fileprintlauncher_linecount = 0;
  level.fileprint_launcher = 1;
  fileprint_launcher("GAMEPRINTSTARTFILE:");
}

fileprint_launcher(var_00) {
  level.fileprintlauncher_linecount++;

  if(level.fileprintlauncher_linecount > 200) {
    wait 0.05;
    level.fileprintlauncher_linecount = 0;
  }
}

fileprint_launcher_end_file(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 0;

  if(var_01)
    fileprint_launcher("GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_00);
  else
    fileprint_launcher("GAMEPRINTENDFILE:" + var_00);

  var_02 = gettime() + 4000;

  while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getdvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < var_02)
    wait 0.05;

  if(!(gettime() < var_02)) {
    iprintlnbold("LAUNCHER_PRINT_FAIL:(TIMEOUT): launcherconflict? restart launcher and try again? ");
    level.fileprint_launcher = undefined;
    return 0;
  }

  var_03 = getdvar("LAUNCHER_PRINT_FAIL");

  if(var_03 != "0") {
    iprintlnbold("LAUNCHER_PRINT_FAIL:(" + var_03 + "): launcherconflict? restart launcher and try again? ");
    level.fileprint_launcher = undefined;
    return 0;
  }

  iprintlnbold("Launcher write to file successful!");
  level.fileprint_launcher = undefined;
  return 1;
}

launcher_write_clipboard(var_00) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher("LAUNCHER_CLIP:" + var_00);
}

activate_individual_exploder() {
  scripts\common\exploder::activate_individual_exploder_proc();
}

waitframe() {
  wait 0.05;
}

get_target_ent(var_00) {
  if(!isDefined(var_00))
    var_00 = self.target;

  var_01 = getent(var_00, "targetname");

  if(isDefined(var_01))
    return var_01;

  if(issp()) {
    var_01 = call[[level.getnodefunction]](var_00, "targetname");

    if(isDefined(var_01))
      return var_01;

    var_01 = call[[level.func["getspawner"]]](var_00, "targetname");

    if(isDefined(var_01))
      return var_01;
  }

  var_01 = getstruct(var_00, "targetname");

  if(isDefined(var_01))
    return var_01;

  var_01 = getvehiclenode(var_00, "targetname");

  if(isDefined(var_01))
    return var_01;
}

do_earthquake(var_00, var_01) {
  var_02 = level.earthquake[var_00];
  earthquake(var_2["magnitude"], var_2["duration"], var_01, var_2["radius"]);
}

play_loopsound_in_space(var_00, var_01) {
  var_02 = spawn("script_origin", (0, 0, 0));

  if(!isDefined(var_01))
    var_01 = self.origin;

  var_2.origin = var_01;
  var_02 playLoopSound(var_00);
  return var_02;
}

play_sound_in_space_with_angles(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawn("script_origin", (0, 0, 1));

  if(!isDefined(var_01))
    var_01 = self.origin;

  var_5.origin = var_01;
  var_5.angles = var_02;

  if(isDefined(var_04))
    var_05 linkto(var_04);

  if(issp()) {
    if(isDefined(var_03) && var_03)
      var_05 playsoundasmaster(var_00, "sounddone");
    else
      var_05 playSound(var_00, "sounddone");

    var_05 waittill("sounddone");
  } else if(isDefined(var_03) && var_03)
    var_05 playsoundasmaster(var_00);
  else
    var_05 playSound(var_00);

  var_05 delete();
}

play_sound_in_space(var_00, var_01, var_02, var_03) {
  play_sound_in_space_with_angles(var_00, var_01, (0, 0, 0), var_02, var_03);
}

loop_fx_sound(var_00, var_01, var_02, var_03, var_04) {
  loop_fx_sound_with_angles(var_00, var_01, (0, 0, 0), var_02, var_03, var_04);
}

loop_fx_sound_with_angles(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isDefined(var_03) && var_03) {
    if(!isDefined(level.first_frame) || level.first_frame == 1)
      spawnloopingsound(var_00, var_01, var_02);
  } else {
    if(level.createfx_enabled && isDefined(var_5.loopsound_ent))
      var_07 = var_5.loopsound_ent;
    else
      var_07 = spawn("script_origin", (0, 0, 0));

    if(isDefined(var_04)) {
      thread loop_sound_delete(var_04, var_07);
      self endon(var_04);
    }

    var_7.origin = var_01;
    var_7.angles = var_02;
    var_07 playLoopSound(var_00);

    if(level.createfx_enabled)
      var_5.loopsound_ent = var_07;
    else
      var_07 willneverchange();
  }
}

loop_fx_sound_interval(var_00, var_01, var_02, var_03, var_04, var_05) {
  loop_fx_sound_interval_with_angles(var_00, var_01, (0, 0, 0), var_02, var_03, var_04, var_05);
}

loop_fx_sound_interval_with_angles(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self.origin = var_01;
  self.angles = var_02;

  if(isDefined(var_03))
    self endon(var_03);

  if(var_05 >= var_06) {
    for(;;)
      wait 0.05;
  }

  if(!soundexists(var_00)) {
    for(;;)
      wait 0.05;
  }

  for(;;) {
    wait(randomfloatrange(var_05, var_06));
    lock("createfx_looper");
    thread play_sound_in_space_with_angles(var_00, self.origin, self.angles, undefined);
    unlock("createfx_looper");
  }
}

loop_sound_delete(var_00, var_01) {
  var_01 endon("death");
  self waittill(var_00);
  var_01 delete();
}

createloopeffect(var_00) {
  var_01 = scripts\common\createfx::createeffect("loopfx", var_00);
  var_1.v["delay"] = scripts\common\createfx::getloopeffectdelaydefault();
  return var_01;
}

createoneshoteffect(var_00) {
  var_01 = scripts\common\createfx::createeffect("oneshotfx", var_00);
  var_1.v["delay"] = scripts\common\createfx::getoneshoteffectdelaydefault();
  return var_01;
}

createexploder(var_00) {
  var_01 = scripts\common\createfx::createeffect("exploder", var_00);
  var_1.v["delay"] = scripts\common\createfx::getexploderdelaydefault();
  var_1.v["exploder_type"] = "normal";
  return var_01;
}

alphabetize(var_00) {
  if(var_0.size <= 1)
    return var_00;

  var_01 = 0;

  for(var_02 = var_0.size - 1; var_02 >= 1; var_2--) {
    var_03 = var_0[var_02];
    var_04 = var_02;

    for(var_05 = 0; var_05 < var_02; var_5++) {
      var_06 = var_0[var_05];

      if(stricmp(var_06, var_03) > 0) {
        var_03 = var_06;
        var_04 = var_05;
      }
    }

    if(var_04 != var_02) {
      var_0[var_04] = var_0[var_02];
      var_0[var_02] = var_03;
    }
  }

  return var_00;
}

play_loop_sound_on_entity(var_00, var_01) {
  var_02 = spawn("script_origin", (0, 0, 0));
  var_02 endon("death");
  thread delete_on_death(var_02);

  if(isDefined(var_01)) {
    var_2.origin = self.origin + var_01;
    var_2.angles = self.angles;
    var_02 linkto(self);
  } else {
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_02 linkto(self);
  }

  var_02 playLoopSound(var_00);
  self waittill("stop sound" + var_00);
  var_02 stoploopsound(var_00);
  var_02 delete();
}

stop_loop_sound_on_entity(var_00) {
  self notify("stop sound" + var_00);
}

delete_on_death(var_00) {
  var_00 endon("death");
  self waittill("death");

  if(isDefined(var_00))
    var_00 delete();
}

error(var_00) {
  waitframe();
}

exploder(var_00, var_01, var_02) {
  [
    [level._fx.exploderfunction]
  ](var_00, var_01, var_02);
}

ter_op(var_00, var_01, var_02) {
  if(var_00)
    return var_01;

  return var_02;
}

create_lock(var_00, var_01) {
  if(!isDefined(var_01))
    var_01 = 1;

  if(!isDefined(level.lock))
    level.lock = [];

  var_02 = spawnStruct();
  var_2.max_count = var_01;
  var_2.count = 0;
  level.lock[var_00] = var_02;
}

lock(var_00) {
  var_01 = level.lock[var_00];

  while(var_1.count >= var_1.max_count)
    var_01 waittill("unlocked");

  var_1.count++;
}

unlock(var_00) {
  thread unlock_thread(var_00);
}

unlock_thread(var_00) {
  wait 0.05;
  var_01 = level.lock[var_00];
  var_1.count--;
  var_01 notify("unlocked");
}

get_template_script_MAYBE() {
  var_00 = level.script;

  if(isDefined(level.template_script))
    var_00 = level.template_script;

  return var_00;
}

is_player_gamepad_enabled() {
  if(!level.console) {
    var_00 = self global_fx();

    if(isDefined(var_00))
      return var_00;
    else
      return 0;
  }

  return 1;
}

array_reverse(var_00) {
  var_01 = [];

  for(var_02 = var_0.size - 1; var_02 >= 0; var_2--)
    var_1[var_1.size] = var_0[var_02];

  return var_01;
}

distance_2d_squared(var_00, var_01) {
  return length2dsquared(var_00 - var_01);
}

get_array_of_farthest(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = get_array_of_closest(var_00, var_01, var_02, var_03, var_04, var_05);
  var_06 = array_reverse(var_06);
  return var_06;
}

get_array_of_closest(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_03))
    var_03 = var_1.size;

  if(!isDefined(var_02))
    var_02 = [];

  var_06 = undefined;

  if(isDefined(var_04))
    var_06 = var_04 * var_04;

  var_07 = 0;

  if(isDefined(var_05))
    var_07 = var_05 * var_05;

  if(var_2.size == 0 && var_03 >= var_1.size && var_07 == 0 && !isDefined(var_06))
    return sortbydistance(var_01, var_00);

  var_08 = [];

  foreach(var_10 in var_01) {
    var_11 = 0;

    foreach(var_13 in var_02) {
      if(var_10 == var_13) {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }
    var_15 = distancesquared(var_00, var_10.origin);

    if(isDefined(var_06) && var_15 > var_06) {
      continue;
    }
    if(var_15 < var_07) {
      continue;
    }
    var_8[var_8.size] = var_10;
  }

  var_08 = sortbydistance(var_08, var_00);

  if(var_03 >= var_8.size)
    return var_08;

  var_17 = [];

  for(var_18 = 0; var_18 < var_03; var_18++)
    var_17[var_18] = var_8[var_18];

  return var_17;
}

drop_to_ground(var_00, var_01, var_02) {
  if(!isDefined(var_01))
    var_01 = 1500;

  if(!isDefined(var_02))
    var_02 = -12000;

  return _physicstrace(var_00 + (0, 0, var_01), var_00 + (0, 0, var_02));
}

within_fov(var_00, var_01, var_02, var_03) {
  var_04 = vectornormalize(var_02 - var_00);
  var_05 = anglesToForward(var_01);
  var_06 = vectordot(var_05, var_04);
  return var_06 >= var_03;
}

make_entity_sentient_mp(var_00, var_01) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_make_entity_sentient"]))
    return self[[level.bot_funcs["bots_make_entity_sentient"]]](var_00, var_01);
}

ai_3d_sighting_model(var_00) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["ai_3d_sighting_model"]))
    return self[[level.bot_funcs["ai_3d_sighting_model"]]](var_00);
}

getclosest(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 500000;

  var_03 = undefined;

  foreach(var_05 in var_01) {
    var_06 = distance(var_5.origin, var_00);

    if(var_06 >= var_02) {
      continue;
    }
    var_02 = var_06;
    var_03 = var_05;
  }

  return var_03;
}

missile_settargetandflightmode(var_00, var_01, var_02) {
  var_02 = ter_op(isDefined(var_02), var_02, (0, 0, 0));
  self missile_settargetent(var_00, var_02);

  switch (var_01) {
    case "direct":
      self missile_setflightmodedirect();
      break;
    case "top":
      self missile_setflightmodetop();
      break;
  }
}

add_fx(var_00, var_01) {
  if(!isDefined(level._effect))
    level._effect = [];

  level._effect[var_00] = loadfx(var_01);
}

array_sort_with_func(var_00, var_01) {
  for(var_02 = 1; var_02 < var_0.size; var_2++) {
    var_03 = var_0[var_02];

    for(var_04 = var_02 - 1; var_04 >= 0 && ![
        [var_01]
      ](var_0[var_04], var_03); var_4--)
      var_0[var_04 + 1] = var_0[var_04];

    var_0[var_04 + 1] = var_03;
  }

  return var_00;
}

add_func_ref_MAYBE(var_00, var_01) {
  if(!isDefined(level.func))
    level.func = [];

  level.func[var_00] = var_01;
}

init_empty_func_ref_MAYBE(var_00) {
  if(!isDefined(level.func))
    level.func = [];

  if(!isDefined(level.func[var_00]))
    add_func_ref_MAYBE(var_00, ::empty_init_func);
}

add_init_script(var_00, var_01) {
  if(!isDefined(level.init_script))
    level.init_script = [];

  if(isDefined(level.init_script[var_00]))
    return 0;

  level.init_script[var_00] = var_01;
  return 1;
}

func_D959() {}

func_C953() {
  if(getdvar("g_connectpaths") == "2")
    level waittill("eternity");
}

getdamagetype(var_00) {
  if(!isDefined(var_00))
    return "unknown";

  var_00 = tolower(var_00);

  switch (var_00) {
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

add_frame_event(var_00) {
  if(!isDefined(self.frame_events)) {
    self.frame_events = [var_00];
    thread process_frame_events();
  } else
    self.frame_events[self.frame_events.size] = var_00;
}

process_frame_events() {
  for(;;) {
    if(isDefined(self)) {
      foreach(var_01 in self.frame_events)
      self thread[[var_01]]();
    } else
      break;

    wait 0.05;
  }
}

delaythread(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  thread delaythread_proc(var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07);
}

delaythread_proc(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self endon("death");
  self endon("stop_delay_thread");
  wait(var_01);

  if(isDefined(var_07))
    thread[[var_00]](var_02, var_03, var_04, var_05, var_06, var_07);
  else if(isDefined(var_06))
    thread[[var_00]](var_02, var_03, var_04, var_05, var_06);
  else if(isDefined(var_05))
    thread[[var_00]](var_02, var_03, var_04, var_05);
  else if(isDefined(var_04))
    thread[[var_00]](var_02, var_03, var_04);
  else if(isDefined(var_03))
    thread[[var_00]](var_02, var_03);
  else if(isDefined(var_02))
    thread[[var_00]](var_02);
  else
    thread[[var_00]]();
}

isprotectedbyriotshield(var_00) {
  if(isDefined(var_0.hasriotshield) && var_0.hasriotshield) {
    var_01 = self.origin - var_0.origin;
    var_02 = vectornormalize((var_1[0], var_1[1], 0));
    var_03 = anglesToForward(var_0.angles);
    var_04 = vectordot(var_03, var_01);

    if(var_0.hasriotshieldequipped) {
      if(var_04 > 0.766)
        return 1;
    } else if(var_04 < -0.766)
      return 1;
  }

  return 0;
}

isprotectedbyaxeblock(var_00) {
  var_01 = 0;
  var_02 = self getcurrentweapon();
  var_03 = self adsbuttonpressed();
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  var_07 = anglesToForward(self.angles);
  var_08 = vectornormalize(var_0.origin - self.origin);
  var_09 = vectordot(var_08, var_07);

  if(var_09 > 0.5)
    var_04 = 1;

  if(var_02 == "iw6_axe_mp" || var_02 == "iw7_axe_zm") {
    var_06 = self getcurrentweaponclipammo();
    var_05 = 1;
  }

  if(var_05 && var_03 && var_04 && var_06 > 0) {
    self setweaponammoclip(var_02, var_06 - 1);
    self playSound("crate_impact");
    earthquake(0.75, 0.5, self.origin, 100);
    var_01 = 1;
  }

  return var_01;
}

isairdropmarker(var_00) {
  switch (var_00) {
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

isdestructibleweapon(var_00) {
  if(!isDefined(var_00))
    return 0;

  switch (var_00) {
    case "barrel_mp":
    case "destructible_toy":
    case "destructible_car":
    case "destructible":
      return 1;
  }

  return 0;
}

weaponclass(var_00) {
  if(isDefined(var_00) && var_00 != "" && var_00 != "none") {
    var_01 = getweaponbasename(var_00);

    if(var_01 == "iw7_emc")
      return "pistol";

    if(var_01 == "iw7_devastator")
      return "spread";

    if(var_01 == "iw7_steeldragon")
      return "beam";
  }

  return weaponclass(var_00);
}

damagelocationisany(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(isDefined(self.damagelocation)) {
    if(!isDefined(var_00))
      return 0;

    if(self.damagelocation == var_00)
      return 1;

    if(!isDefined(var_01))
      return 0;

    if(self.damagelocation == var_01)
      return 1;

    if(!isDefined(var_02))
      return 0;

    if(self.damagelocation == var_02)
      return 1;

    if(!isDefined(var_03))
      return 0;

    if(self.damagelocation == var_03)
      return 1;

    if(!isDefined(var_04))
      return 0;

    if(self.damagelocation == var_04)
      return 1;

    if(!isDefined(var_05))
      return 0;

    if(self.damagelocation == var_05)
      return 1;

    if(!isDefined(var_06))
      return 0;

    if(self.damagelocation == var_06)
      return 1;

    if(!isDefined(var_07))
      return 0;

    if(self.damagelocation == var_07)
      return 1;

    if(!isDefined(var_08))
      return 0;

    if(self.damagelocation == var_08)
      return 1;

    if(!isDefined(var_09))
      return 0;

    if(self.damagelocation == var_09)
      return 1;

    if(!isDefined(var_10))
      return 0;

    if(self.damagelocation == var_10)
      return 1;
  }

  return damagesubpartlocationisany(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
}

damagesubpartlocationisany(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(!isDefined(self.damagedsubpart))
    return 0;

  if(!isDefined(var_00))
    return 0;

  if(self.damagedsubpart == var_00)
    return 1;

  if(!isDefined(var_01))
    return 0;

  if(self.damagedsubpart == var_01)
    return 1;

  if(!isDefined(var_02))
    return 0;

  if(self.damagedsubpart == var_02)
    return 1;

  if(!isDefined(var_03))
    return 0;

  if(self.damagedsubpart == var_03)
    return 1;

  if(!isDefined(var_04))
    return 0;

  if(self.damagedsubpart == var_04)
    return 1;

  if(!isDefined(var_05))
    return 0;

  if(self.damagedsubpart == var_05)
    return 1;

  if(!isDefined(var_06))
    return 0;

  if(self.damagedsubpart == var_06)
    return 1;

  if(!isDefined(var_07))
    return 0;

  if(self.damagedsubpart == var_07)
    return 1;

  if(!isDefined(var_08))
    return 0;

  if(self.damagedsubpart == var_08)
    return 1;

  if(!isDefined(var_09))
    return 0;

  if(self.damagedsubpart == var_09)
    return 1;

  if(!isDefined(var_10))
    return 0;

  if(self.damagedsubpart == var_10)
    return 1;

  return 0;
}

isbulletdamage(var_00) {
  var_01 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

  if(issubstr(var_01, var_00))
    return 1;

  return 0;
}

isnodecoverleft(var_00) {
  return var_0.type == "Cover Left";
}

isnodecoverright(var_00) {
  return var_0.type == "Cover Right";
}

isnode3d(var_00) {
  return isnodecover3d(var_00) || isnodeexposed3d(var_00);
}

isnodecover3d(var_00) {
  return var_0.type == "Cover Stand 3D" || var_0.type == "Cover 3D";
}

isnodeexposed3d(var_00) {
  return var_0.type == "Exposed 3D" || var_0.type == "Path 3D";
}

isnodecovercrouch(var_00) {
  return var_0.type == "Cover Crouch" || var_0.type == "Cover Crouch Window" || var_0.type == "Conceal Crouch";
}

absangleclamp180(var_00) {
  return abs(angleclamp180(var_00));
}

getaimyawtopoint(var_00) {
  var_01 = getyawtospot(var_00);
  var_02 = distance(self.origin, var_00);

  if(var_02 > 3) {
    var_03 = atan(-3 / var_02);
    var_01 = var_01 - var_03;
  }

  var_01 = angleclamp180(var_01);
  return var_01;
}

getyawtospot(var_00) {
  if(actor_is3d()) {
    var_01 = anglesToForward(self.angles);
    var_02 = rotatepointaroundvector(var_01, var_00 - self.origin, self.angles[2] * -1);
    var_00 = var_02 + self.origin;
  }

  var_03 = getyaw(var_00) - self.angles[1];
  var_03 = angleclamp180(var_03);
  return var_03;
}

getyaw(var_00) {
  return vectortoyaw(var_00 - self.origin);
}

getaimyawtopoint3d(var_00) {
  var_01 = getyawtospot3d(var_00);
  var_02 = distance(self.origin, var_00);

  if(var_02 > 3) {
    var_03 = atan(-3 / var_02);
    var_01 = var_01 - var_03;
  }

  var_01 = angleclamp180(var_01);
  return var_01;
}

getyawtospot3d(var_00) {
  var_01 = var_00 - self.origin;
  var_02 = rotatevectorinverted(var_01, self.angles);
  var_03 = vectortoyaw(var_02);
  var_04 = angleclamp180(var_03);
  return var_04;
}

getaimpitchtopoint3d(var_00) {
  var_01 = getpitchtospot3d(var_00);
  var_02 = distance(self.origin, var_00);

  if(var_02 > 3) {
    var_03 = atan(-3 / var_02);
    var_01 = var_01 - var_03;
  }

  var_01 = angleclamp180(var_01);
  return var_01;
}

getpitchtospot3d(var_00) {
  var_01 = var_00 - self.origin;
  var_02 = rotatevectorinverted(var_01, self.angles);
  var_03 = _vectortopitch(var_02);
  var_04 = angleclamp180(var_03);
  return var_04;
}

actor_isspace() {
  return is_true(self.space);
}

actor_is3d() {
  return actor_isspace();
}

getpredictedaimyawtoshootentorpos(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    if(!isDefined(var_02))
      return 0;

    return getaimyawtopoint(var_02);
  }

  var_03 = (0, 0, 0);

  if(isplayer(var_01))
    var_03 = var_01 getvelocity();
  else if(isai(var_01))
    var_03 = var_1.velocity;

  var_04 = var_1.origin + var_03 * var_00;
  return getaimyawtopoint(var_04);
}

getpredictedaimyawtoshootentorpos3d(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    if(!isDefined(var_02))
      return 0;

    return getaimyawtopoint3d(var_02);
  }

  var_03 = (0, 0, 0);

  if(isplayer(var_01))
    var_03 = var_01 getvelocity();
  else if(isai(var_01))
    var_03 = var_1.velocity;

  var_04 = var_1.origin + var_03 * var_00;
  return getaimyawtopoint3d(var_04);
}

getpredictedaimpitchtoshootentorpos3d(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    if(!isDefined(var_02))
      return 0;

    return getaimpitchtopoint3d(var_02);
  }

  var_03 = (0, 0, 0);

  if(isplayer(var_01))
    var_03 = var_01 getvelocity();
  else if(isai(var_01))
    var_03 = var_1.velocity;

  var_04 = var_1.origin + var_03 * var_00;
  return getaimpitchtopoint3d(var_04);
}

meleegrab_ksweapon_used() {
  var_00 = ["mars_killstreak", "iw7_jackal_support_designator"];

  if(array_contains(var_00, level.player getcurrentweapon()))
    return 1;

  if(level.player isdroppingweapon())
    return 1;

  if(level.player israisingweapon()) {
    if(array_contains(var_00, level.player getcurrentweapon()))
      return 1;
  }

  return 0;
}

wasdamagedbyoffhandshield() {
  if(!isDefined(self.damagemod) || self.damagemod != "MOD_MELEE")
    return 0;

  if(!isDefined(self.damageweapon) || weapontype(self.damageweapon) != "shield")
    return 0;

  return 1;
}

is_true(var_00) {
  if(isDefined(var_00) && var_00)
    return 1;

  return 0;
}

player_is_in_jackal() {
  if(isDefined(level.player _meth_8473()))
    return 1;
  else
    return 0;
}

set_createfx_enabled() {
  if(!isDefined(level.createfx_enabled))
    level.createfx_enabled = getdvar("createfx") != "";
}

flag_set_delayed(var_00, var_01, var_02) {
  wait(var_01);
  flag_set(var_00, var_02);
}

noself_array_call(var_00, var_01, var_02, var_03, var_04) {
  if(isDefined(var_04)) {
    foreach(var_06 in var_00)
    call[[var_01]](var_06, var_02, var_03, var_04);

    return;
  }

  if(isDefined(var_03)) {
    foreach(var_06 in var_00)
    call[[var_01]](var_06, var_02, var_03);

    return;
  }

  if(isDefined(var_02)) {
    foreach(var_06 in var_00)
    call[[var_01]](var_06, var_02);

    return;
  }

  foreach(var_06 in var_00)
  call[[var_01]](var_06);
}

flag_assert(var_00) {}

flag_wait_either(var_00, var_01) {
  for(;;) {
    if(flag(var_00)) {
      return;
    }
    if(flag(var_01)) {
      return;
    }
    level waittill_either(var_00, var_01);
  }
}

flag_wait_either_return(var_00, var_01) {
  for(;;) {
    if(flag(var_00))
      return var_00;

    if(flag(var_01))
      return var_01;

    var_02 = level waittill_any_return(var_00, var_01);
    return var_02;
  }
}

flag_wait_any(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = [];

  if(isDefined(var_05)) {
    var_6[var_6.size] = var_00;
    var_6[var_6.size] = var_01;
    var_6[var_6.size] = var_02;
    var_6[var_6.size] = var_03;
    var_6[var_6.size] = var_04;
    var_6[var_6.size] = var_05;
  } else if(isDefined(var_04)) {
    var_6[var_6.size] = var_00;
    var_6[var_6.size] = var_01;
    var_6[var_6.size] = var_02;
    var_6[var_6.size] = var_03;
    var_6[var_6.size] = var_04;
  } else if(isDefined(var_03)) {
    var_6[var_6.size] = var_00;
    var_6[var_6.size] = var_01;
    var_6[var_6.size] = var_02;
    var_6[var_6.size] = var_03;
  } else if(isDefined(var_02)) {
    var_6[var_6.size] = var_00;
    var_6[var_6.size] = var_01;
    var_6[var_6.size] = var_02;
  } else if(isDefined(var_01)) {
    flag_wait_either(var_00, var_01);
    return;
  } else
    return;

  for(;;) {
    for(var_07 = 0; var_07 < var_6.size; var_7++) {
      if(flag(var_6[var_07]))
        return;
    }

    level waittill_any(var_00, var_01, var_02, var_03, var_04, var_05);
  }
}

flag_wait_any_return(var_00, var_01, var_02, var_03, var_04) {
  var_05 = [];

  if(isDefined(var_04)) {
    var_5[var_5.size] = var_00;
    var_5[var_5.size] = var_01;
    var_5[var_5.size] = var_02;
    var_5[var_5.size] = var_03;
    var_5[var_5.size] = var_04;
  } else if(isDefined(var_03)) {
    var_5[var_5.size] = var_00;
    var_5[var_5.size] = var_01;
    var_5[var_5.size] = var_02;
    var_5[var_5.size] = var_03;
  } else if(isDefined(var_02)) {
    var_5[var_5.size] = var_00;
    var_5[var_5.size] = var_01;
    var_5[var_5.size] = var_02;
  } else if(isDefined(var_01)) {
    var_06 = flag_wait_either_return(var_00, var_01);
    return var_06;
  } else
    return;

  for(;;) {
    for(var_07 = 0; var_07 < var_5.size; var_7++) {
      if(flag(var_5[var_07]))
        return var_5[var_07];
    }

    var_06 = level waittill_any_return(var_00, var_01, var_02, var_03, var_04);
    return var_06;
  }
}

flag_wait_all(var_00, var_01, var_02, var_03) {
  if(isDefined(var_00))
    flag_wait(var_00);

  if(isDefined(var_01))
    flag_wait(var_01);

  if(isDefined(var_02))
    flag_wait(var_02);

  if(isDefined(var_03))
    flag_wait(var_03);
}

flag_wait_or_timeout(var_00, var_01) {
  var_02 = var_01 * 1000;
  var_03 = gettime();

  for(;;) {
    if(flag(var_00)) {
      break;
    }
    if(gettime() >= var_03 + var_02) {
      break;
    }
    var_04 = var_02 - (gettime() - var_03);
    var_05 = var_04 / 1000;
    wait_for_flag_or_time_elapses(var_00, var_05);
  }
}

flag_waitopen_or_timeout(var_00, var_01) {
  var_02 = gettime();

  for(;;) {
    if(!flag(var_00)) {
      break;
    }
    if(gettime() >= var_02 + var_01 * 1000) {
      break;
    }
    wait_for_flag_or_time_elapses(var_00, var_01);
  }
}

wait_for_flag_or_time_elapses(var_00, var_01) {
  level endon(var_00);
  wait(var_01);
}

noself_delaycall(var_00, var_01, var_02, var_03, var_04, var_05) {
  thread noself_delaycall_proc(var_01, var_00, var_02, var_03, var_04, var_05);
}

noself_delaycall_proc(var_00, var_01, var_02, var_03, var_04, var_05) {
  wait(var_01);

  if(isDefined(var_05))
    call[[var_00]](var_02, var_03, var_04, var_05);
  else if(isDefined(var_04))
    call[[var_00]](var_02, var_03, var_04);
  else if(isDefined(var_03))
    call[[var_00]](var_02, var_03);
  else if(isDefined(var_02))
    call[[var_00]](var_02);
  else
    call[[var_00]]();
}

get_target_array(var_00) {
  if(!isDefined(var_00))
    var_00 = self.target;

  var_01 = getEntArray(var_00, "targetname");

  if(var_1.size > 0)
    return var_01;

  if(issp()) {
    var_01 = call[[level.getnodearrayfunction]](var_00, "targetname");

    if(var_1.size > 0)
      return var_01;
  }

  var_01 = getstructarray(var_00, "targetname");

  if(var_1.size > 0)
    return var_01;

  var_01 = getvehiclenodearray(var_00, "targetname");

  if(var_1.size > 0)
    return var_01;
}

pauseeffect() {
  scripts\common\createfx::stop_fx_looper();
}

spawn_script_origin(var_00, var_01) {
  if(!isDefined(var_01) && isDefined(self.angles))
    var_01 = self.angles;

  if(!isDefined(var_00) && isDefined(self.origin))
    var_00 = self.origin;
  else if(!isDefined(var_00))
    var_00 = (0, 0, 0);

  var_02 = spawn("script_origin", var_00);

  if(isDefined(var_01))
    var_2.angles = var_01;

  return var_02;
}

allow_lean(var_00) {
  if(var_00) {
    if(!isDefined(self.disabledlean))
      self.disabledlean = 0;
    else
      self.disabledlean--;

    if(!self.disabledlean)
      self allowlean(1);
  } else {
    if(!isDefined(self.disabledlean))
      self.disabledlean = 0;

    self.disabledlean++;
    self allowlean(0);
  }
}

allow_reload(var_00, var_01) {
  if(var_00) {
    if(!isDefined(self.disabledreload))
      self.disabledreload = 0;
    else
      self.disabledreload--;

    if(!self.disabledreload)
      self allowreload(1);
  } else {
    if(!isDefined(self.disabledreload))
      self.disabledreload = 0;

    self.disabledreload++;
    self allowreload(0);

    if(!isDefined(var_01) || !var_01)
      self _meth_8545();
  }
}

allow_autoreload(var_00) {
  if(var_00) {
    if(!isDefined(self.disableautoreload))
      self.disableautoreload = 0;
    else
      self.disableautoreload--;

    if(!self.disableautoreload)
      self getrankforxp();
  } else {
    if(!isDefined(self.disableautoreload))
      self.disableautoreload = 0;

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

get_noteworthy_array(var_00) {
  var_01 = getEntArray(var_00, "script_noteworthy");

  if(var_1.size > 0)
    return var_01;

  if(issp()) {
    var_01 = call[[level.getnodearrayfunction]](var_00, "script_noteworthy");

    if(var_1.size > 0)
      return var_01;
  }

  var_01 = getstructarray(var_00, "script_noteworthy");

  if(var_1.size > 0)
    return var_01;

  var_01 = getvehiclenodearray(var_00, "script_noteworthy");

  if(var_1.size > 0)
    return var_01;
}

get_cumulative_weights(var_00) {
  var_01 = [];
  var_02 = 0;

  for(var_03 = 0; var_03 < var_0.size; var_3++) {
    var_02 = var_02 + var_0[var_03];
    var_1[var_03] = var_02;
  }

  return var_01;
}

void() {}

func_9DA3() {
  if(!isDefined(self.enemy))
    return 0;

  if(!issentient(self.enemy))
    return 1;

  if(self getpersstat(self.enemy))
    return 1;

  var_00 = self lastknowntime(self.enemy);

  if(var_00 == 0)
    return 0;

  var_01 = gettime() - var_00;

  if(var_01 > 10000)
    return 0;

  if(distancesquared(self.enemy.origin, self.origin) > 4194304)
    return 0;

  return 1;
}

get_notetrack_time(var_00, var_01) {
  var_02 = getnotetracktimes(var_00, var_01);
  var_03 = getanimlength(var_00);
  return var_2[0] * var_03;
}

mph_to_ips(var_00) {
  return var_00 * 17.6;
}

ips_to_mph(var_00) {
  return var_00 * 0.056818;
}

closestdistancebetweenlines(var_00, var_01, var_02, var_03) {
  var_04 = var_00 - var_02;
  var_05 = var_03 - var_02;

  if(abs(var_5[0]) < 0.000001 && abs(var_5[1]) < 0.000001 && abs(var_5[2]) < 0.000001)
    return undefined;

  var_06 = var_01 - var_00;

  if(abs(var_6[0]) < 0.000001 && abs(var_6[1]) < 0.000001 && abs(var_6[2]) < 0.000001)
    return undefined;

  var_07 = var_4[0] * var_5[0] + var_4[1] * var_5[1] + var_4[2] * var_5[2];
  var_08 = var_5[0] * var_6[0] + var_5[1] * var_6[1] + var_5[2] * var_6[2];
  var_09 = var_4[0] * var_6[0] + var_4[1] * var_6[1] + var_4[2] * var_6[2];
  var_10 = var_5[0] * var_5[0] + var_5[1] * var_5[1] + var_5[2] * var_5[2];
  var_11 = var_6[0] * var_6[0] + var_6[1] * var_6[1] + var_6[2] * var_6[2];
  var_12 = var_11 * var_10 - var_08 * var_08;

  if(abs(var_12) < 0.000001)
    return undefined;

  var_13 = var_07 * var_08 - var_09 * var_10;
  var_14 = var_13 / var_12;
  var_15 = (var_07 + var_08 * var_14) / var_10;
  var_16 = var_00 + var_14 * var_06;
  var_17 = var_02 + var_15 * var_05;
  var_18 = [var_16, var_17, distance(var_16, var_17)];
  return var_18;
}

closestdistancebetweensegments(var_00, var_01, var_02, var_03) {
  var_04 = var_01 - var_00;
  var_05 = var_03 - var_02;
  var_06 = var_00 - var_02;
  var_07 = vectordot(var_04, var_04);
  var_08 = vectordot(var_04, var_05);
  var_09 = vectordot(var_05, var_05);
  var_10 = vectordot(var_04, var_06);
  var_11 = vectordot(var_05, var_06);
  var_12 = var_07 * var_09 - var_08 * var_08;
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
    var_14 = var_09;
  } else {
    var_16 = var_08 * var_11 - var_09 * var_10;
    var_18 = var_07 * var_11 - var_08 * var_10;

    if(var_16 < 0.0) {
      var_16 = 0;
      var_18 = var_11;
      var_14 = var_09;
    } else if(var_16 > var_13) {
      var_16 = var_13;
      var_18 = var_11 + var_08;
      var_14 = var_09;
    }
  }

  if(var_18 < 0.0) {
    var_18 = 0.0;

    if(var_10 * -1 < 0.0)
      var_16 = 0.0;
    else if(var_10 * -1 > var_07)
      var_16 = var_13;
    else {
      var_16 = var_10 * -1;
      var_13 = var_07;
    }
  } else if(var_18 > var_14) {
    var_18 = var_14;

    if(var_08 - var_10 < 0.0)
      var_16 = 0;
    else if(var_08 - var_10 > var_07)
      var_16 = var_13;
    else {
      var_16 = var_08 - var_10;
      var_13 = var_07;
    }
  }

  if(abs(var_16) > 0.00000001)
    var_15 = var_16 / var_13;

  if(abs(var_18) > 0.00000001)
    var_17 = var_18 / var_14;

  var_19 = var_00 + var_15 * var_04;
  var_20 = var_02 + var_17 * var_05;
  var_21 = [var_19, var_20, distance(var_19, var_20)];
  return var_21;
}

getcamotablecolumnindex(var_00) {
  switch (var_00) {
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