/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\30.gsc
**************************************/

scriptprintln(var_0, var_1) {}

debugprintln(var_0, var_1) {}

draw_debug_line(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_2 * 20; var_3++) {
    wait 0.05;
  }
}

waittillend(var_0) {
  self waittillmatch(var_0, "end");
}

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

angle_dif(var_0, var_1) {
  if(var_0 == var_1) {
    return 0;

  }
  while(var_1 > 360) {
    var_1 = var_1 - 360;

  }
  while(var_1 < 0) {
    var_1 = var_1 + 360;

  }
  while(var_0 > 360) {
    var_0 = var_0 - 360;

  }
  while(var_0 < 0) {
    var_0 = var_0 + 360;

  }
  var_2 = undefined;
  var_3 = undefined;

  if(var_1 > 180) {
    var_3 = 360 - var_1;
  } else {
    var_3 = var_1;

  }
  if(var_0 > 180) {
    var_2 = 360 - var_0;
  } else {
    var_2 = var_0;

  }
  var_4 = var_3 + var_2;
  var_5 = 0;

  if(var_1 > var_0) {
    var_5 = var_1 - var_0;
  } else {
    var_5 = var_0 - var_1;

  }
  if(var_5 < var_4) {
    return var_5;
  } else {
    return var_4;
  }
}

sign(var_0) {
  if(var_0 >= 0) {
    return 1;

  }
  return -1;
}

track(var_0) {
  if(isDefined(self.current_target)) {
    if(var_0 == self.current_target) {
      return;
    }
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
  self.defaultexception[var_0] = anim.exception;
}

set_exception(var_0, var_1) {
  self.defaultexception[var_0] = var_1;
}

set_all_exceptions(var_0) {
  var_1 = getarraykeys(self.defaultexception);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    self.defaultexception[var_1[var_2]] = var_0;
  }
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

get_cumulative_weights(var_0) {
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2 = var_2 + var_0[var_3];
    var_1[var_3] = var_2;
  }

  return var_1;
}

waittill_string(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");

  }
  var_1 endon("die");
  self waittill(var_0);
  var_1 notify("returned", var_0);
}

waittill_multiple(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = spawnStruct();
  var_5.threads = 0;

  if(isDefined(var_0)) {
    thread waittill_string(var_0, var_5);
    var_5.threads++;
  }

  if(isDefined(var_1)) {
    thread waittill_string(var_1, var_5);
    var_5.threads++;
  }

  if(isDefined(var_2)) {
    thread waittill_string(var_2, var_5);
    var_5.threads++;
  }

  if(isDefined(var_3)) {
    thread waittill_string(var_3, var_5);
    var_5.threads++;
  }

  if(isDefined(var_4)) {
    thread waittill_string(var_4, var_5);
    var_5.threads++;
  }

  while(var_5.threads) {
    var_5 waittill("returned");
    var_5.threads--;
  }

  var_5 notify("die");
}

waittill_multiple_ents(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_8 = spawnStruct();
  var_8.threads = 0;

  if(isDefined(var_0)) {
    var_0 thread waittill_string(var_1, var_8);
    var_8.threads++;
  }

  if(isDefined(var_2)) {
    var_2 thread waittill_string(var_3, var_8);
    var_8.threads++;
  }

  if(isDefined(var_4)) {
    var_4 thread waittill_string(var_5, var_8);
    var_8.threads++;
  }

  if(isDefined(var_6)) {
    var_6 thread waittill_string(var_7, var_8);
    var_8.threads++;
  }

  while(var_8.threads) {
    var_8 waittill("returned");
    var_8.threads--;
  }

  var_8 notify("die");
}

waittill_any_return(var_0, var_1, var_2, var_3, var_4) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death")) {
    self endon("death");

  }
  var_5 = spawnStruct();

  if(isDefined(var_0)) {
    thread waittill_string(var_0, var_5);

  }
  if(isDefined(var_1)) {
    thread waittill_string(var_1, var_5);

  }
  if(isDefined(var_2)) {
    thread waittill_string(var_2, var_5);

  }
  if(isDefined(var_3)) {
    thread waittill_string(var_3, var_5);

  }
  if(isDefined(var_4)) {
    thread waittill_string(var_4, var_5);

  }
  var_5 waittill("returned", var_6);
  var_5 notify("die");
  return var_6;
}

waittill_any_timeout(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death") && (!isDefined(var_5) || var_5 != "death")) {
    self endon("death");

  }
  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    thread waittill_string(var_1, var_6);

  }
  if(isDefined(var_2)) {
    thread waittill_string(var_2, var_6);

  }
  if(isDefined(var_3)) {
    thread waittill_string(var_3, var_6);

  }
  if(isDefined(var_4)) {
    thread waittill_string(var_4, var_6);

  }
  if(isDefined(var_5)) {
    thread waittill_string(var_5, var_6);

  }
  var_6 thread _timeout(var_0);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_timeout(var_0) {
  self endon("die");
  wait(var_0);
  self notify("returned", "timeout");
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
  return isDefined(level.flag[var_0]);
}

flag(var_0) {
  return level.flag[var_0];
}

init_flags() {
  level.flag = [];
  level.flags_lock = [];
  level.generic_index = 0;

  if(!isDefined(level.sp_stat_tracking_func)) {
    level.sp_stat_tracking_func = ::empty_init_func;

  }
  level.flag_struct = spawnStruct();
  level.flag_struct assign_unique_id();
}

flag_init(var_0) {
  if(!isDefined(level.flag)) {
    init_flags();

  }
  level.flag[var_0] = 0;

  if(!isDefined(level.trigger_flags)) {
    init_trigger_flags();
    level.trigger_flags[var_0] = [];
  } else if(!isDefined(level.trigger_flags[var_0])) {
    level.trigger_flags[var_0] = [];

  }
  if(issuffix(var_0, "aa_")) {
    thread[[level.sp_stat_tracking_func]](var_0);
  }
}

empty_init_func(var_0) {}

issuffix(var_0, var_1) {
  if(var_1.size > var_0.size) {
    return 0;

  }
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0[var_2] != var_1[var_2]) {
      return 0;
    }
  }

  return 1;
}

flag_set(var_0, var_1) {
  level.flag[var_0] = 1;
  set_trigger_flag_permissions(var_0);

  if(isDefined(var_1)) {
    level notify(var_0, var_1);
  } else {
    level notify(var_0);
  }
}

assign_unique_id() {
  self.unique_id = "generic" + level.generic_index;
  level.generic_index++;
}

flag_wait(var_0, var_1) {
  var_2 = undefined;

  while(!flag(var_0)) {
    var_2 = undefined;
    level waittill(var_0, var_2);

    if(isDefined(var_1) && flag(var_0, var_1)) {
      break;
    }
  }

  if(isDefined(var_2)) {
    return var_2;
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
}

array_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_2)) {
    foreach(var_12 in var_0) {}
    var_12 thread[[var_1]]();
  } else {
    if(!isDefined(var_3)) {
      foreach(var_12 in var_0) {}
      var_12 thread[[var_1]](var_2);

      return;
    }

    if(!isDefined(var_4)) {
      foreach(var_12 in var_0) {}
      var_12 thread[[var_1]](var_2, var_3);

      return;
    }

    if(!isDefined(var_5)) {
      foreach(var_12 in var_0) {}
      var_12 thread[[var_1]](var_2, var_3, var_4);

      return;
    }

    if(!isDefined(var_6)) {
      foreach(var_12 in var_0) {}
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5);

      return;
    }

    if(!isDefined(var_7)) {
      foreach(var_12 in var_0) {}
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6);

      return;
    }

    if(!isDefined(var_8)) {
      foreach(var_12 in var_0) {}
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);

      return;
    }

    if(!isDefined(var_9)) {
      foreach(var_12 in var_0) {}
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);

      return;
    }

    if(!isDefined(var_10)) {
      foreach(var_12 in var_0) {}
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

      return;
    }

    foreach(var_12 in var_0) {}
    var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }
}

array_call(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {}
    var_6 call[[var_1]](var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {}
    var_6 call[[var_1]](var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {}
    var_6 call[[var_1]](var_2);

    return;
  }

  foreach(var_6 in var_0) {}
  var_6 call[[var_1]]();
}

array_thread4(var_0, var_1, var_2, var_3, var_4, var_5) {
  array_thread(var_0, var_1, var_2, var_3, var_4, var_5);
}

array_thread5(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  array_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

trigger_on(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    array_thread(var_2, ::trigger_on_proc);
  } else {
    trigger_on_proc();
  }
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
  } else {
    trigger_off_proc();
  }
}

trigger_off_proc() {
  if(!isDefined(self.realorigin)) {
    self.realorigin = self.origin;

  }
  if(self.origin == self.realorigin) {
    self.origin = self.origin + (0, 0, -10000);

  }
  self.trigger_off = 1;
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
  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];

  foreach(var_1 in level.struct) {
    if(isDefined(var_1.targetname)) {
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
      level.struct_class_names["script_linkname"][var_1.script_linkname][0] = var_1;
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
  foreach(var_3 in var_1) {}
  var_0 = array_remove(var_0, var_3);

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

array_levelthread(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {}
    thread[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {}
    thread[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {}
    thread[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0) {}
  thread[[var_1]](var_6);
}

array_levelcall(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    foreach(var_6 in var_0) {}
    call[[var_1]](var_6, var_2, var_3, var_4);

    return;
  }

  if(isDefined(var_3)) {
    foreach(var_6 in var_0) {}
    call[[var_1]](var_6, var_2, var_3);

    return;
  }

  if(isDefined(var_2)) {
    foreach(var_6 in var_0) {}
    call[[var_1]](var_6, var_2);

    return;
  }

  foreach(var_6 in var_0) {}
  call[[var_1]](var_6);
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
  } else {
    return;

  }
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
  } else {
    return;

  }
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

delaycall(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread delaycall_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

delaycall_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(issp()) {
    self endon("death");

  }
  wait(var_1);

  if(isDefined(var_9)) {
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

issp() {
  if(!isDefined(level.issp)) {
    level.issp = !string_starts_with(getdvar("mapname"), "mp_");

  }
  return level.issp;
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
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(tolower(var_0[var_2]) != tolower(var_1[var_2])) {
      return 0;
    }
  }

  return 1;
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

array_combine(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {}
  var_2[var_2.size] = var_4;

  foreach(var_4 in var_1) {}
  var_2[var_2.size] = var_4;

  return var_2;
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

get_linked_ents() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getEntArray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = array_combine(var_0, var_4);
      }
    }
  }

  return var_0;
}

get_linked_vehicle_nodes() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = get_links();

    foreach(var_3 in var_1) {
      var_4 = getvehiclenodearray(var_3, "script_linkname");

      if(var_4.size > 0) {
        var_0 = array_combine(var_0, var_4);
      }
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
  var_5 = getEntArray(var_0, "targetname");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getstructarray(var_0, "targetname");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = call[[level.getnodearrayfunction]](var_0, "targetname");
  array_thread(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "targetname");
  array_thread(var_5, var_1, var_2, var_3, var_4);
}

run_thread_on_noteworthy(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray(var_0, "script_noteworthy");
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

getfx(var_0) {
  return level._effect[var_0];
}

fxexists(var_0) {
  return isDefined(level._effect[var_0]);
}

print_csv_asset(var_0, var_1) {
  var_2 = var_1 + "," + var_0;

  if(isDefined(level.csv_lines[var_2])) {
    return;
  }
  level.csv_lines[var_2] = 1;
}

fileprint_csv_start(var_0) {}

_loadfx(var_0) {
  return loadfx(var_0);
}

getlastweapon() {
  return self.saved_lastweapon;
}

playerunlimitedammothread() {}

isusabilityenabled() {
  return !self.disabledusability;
}

_disableusability() {
  self.disabledusability++;
  self disableusability();
}

_enableusability() {
  self.disabledusability--;

  if(!self.disabledusability) {
    self enableusability();
  }
}

resetusability() {
  self.disabledusability = 0;
  self enableusability();
}

_disableweapon() {
  self.disabledweapon++;
  self disableweapons();
}

_enableweapon() {
  self.disabledweapon--;

  if(!self.disabledweapon) {
    self enableweapons();
  }
}

isweaponenabled() {
  return !self.disabledweapon;
}

_disableweaponswitch() {
  self.disabledweaponswitch++;
  self disableweaponswitch();
}

_enableweaponswitch() {
  self.disabledweaponswitch--;

  if(!self.disabledweaponswitch) {
    self enableweaponswitch();
  }
}

isweaponswitchenabled() {
  return !self.disabledweaponswitch;
}

_disableoffhandweapons() {
  self.disabledoffhandweapons++;
  self disableoffhandweapons();
}

_enableoffhandweapons() {
  self.disabledoffhandweapons--;

  if(!self.disabledoffhandweapons) {
    self enableoffhandweapons();
  }
}

isoffhandweaponenabled() {
  return !self.disabledoffhandweapons;
}

random(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {}
  var_1[var_1.size] = var_3;

  if(!var_1.size) {
    return undefined;

  }
  return var_1[randomint(var_1.size)];
}

spawn_tag_origin() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 hide();

  if(isDefined(self.origin)) {
    var_0.origin = self.origin;

  }
  if(isDefined(self.angles)) {
    var_0.angles = self.angles;

  }
  return var_0;
}

waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
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
    iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
    level.fileprint_launcher = undefined;
    return 0;
  }

  var_3 = getdvar("LAUNCHER_PRINT_FAIL");

  if(var_3 != "0") {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( " + var_3 + " ): launcherconflict? restart launcher and try again? ");
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
  if(!isDefined(self)) {
    return 0;

  }
  return isDefined(self.destructible_type);
}

pauseeffect() {
  common_scripts\_createfx::stop_fx_looper();
}

activate_individual_exploder() {
  if(isDefined(self.v["firefx"])) {
    thread fire_effect();

  }
  if(isDefined(self.v["fxid"]) && self.v["fxid"] != "No FX") {
    thread cannon_effect();
  } else if(isDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil") {
    thread sound_effect();

  }
  if(isDefined(self.v["loopsound"]) && self.v["loopsound"] != "nil") {
    thread effect_loopsound();

  }
  if(isDefined(self.v["damage"])) {
    thread exploder_damage();

  }
  if(isDefined(self.v["earthquake"])) {
    thread exploder_earthquake();

  }
  if(isDefined(self.v["rumble"])) {
    thread exploder_rumble();

  }
  if(self.v["exploder_type"] == "exploder") {
    thread brush_show();
  } else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible") {
    thread brush_throw();
  } else {
    thread brush_delete();
  }
}

waitframe() {
  wait 0.05;
}

brush_delete() {
  var_0 = self.v["exploder"];

  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  } else {
    wait 0.05;

  }
  if(!isDefined(self.model)) {
    return;
  }
  if(isDefined(self.model.classname)) {
    if(issp() && self.model.spawnflags & 1) {
      self.model call[[level.connectpathsfunction]]();
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    self.model hide();
    self.model notsolid();
    wait 3;
    self.exploded = undefined;
    self.model show();
    self.model solid();
    return;
  }

  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;

  }
  waittillframeend;

  if(isDefined(self.model) && isDefined(self.model.classname)) {
    self.model delete();
  }
}

brush_throw() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);

  }
  var_0 = undefined;

  if(isDefined(self.v["target"])) {
    var_0 = get_target_ent(self.v["target"]);

  }
  if(!isDefined(var_0)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isDefined(self.v["delay_post"])) {
    wait(self.v["delay_post"]);

  }
  var_1 = self.v["origin"];
  var_2 = self.v["angles"];
  var_3 = var_0.origin;
  var_4 = var_3 - self.v["origin"];
  var_5 = var_4[0];
  var_6 = var_4[1];
  var_7 = var_4[2];
  var_8 = isDefined(self.v["physics"]);

  if(var_8) {
    var_9 = undefined;

    if(isDefined(var_0.target)) {
      var_9 = var_0 get_target_ent();

    }
    if(!isDefined(var_9)) {
      var_10 = var_1;
      var_11 = var_0.origin;
    } else {
      var_10 = var_0.origin;
      var_11 = (var_9.origin - var_0.origin) * self.v["physics"];
    }

    self.model physicslaunchclient(var_10, var_11);
    return;
  } else {
    self.model rotatevelocity((var_5, var_6, var_7), 12);
    self.model movegravity((var_5, var_6, var_7), 12);
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;
    self.v["origin"] = var_1;
    self.v["angles"] = var_2;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
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

brush_show() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);

  }
  if(!isDefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    var_0 = self.model spawn_tag_origin();

    if(isDefined(self.model.script_linkname)) {
      var_0.script_linkname = self.model.script_linkname;

    }
    var_0 setModel(self.model.script_modelname);
    var_0 show();
  }

  self.brush_shown = 1;

  if(issp() && !isDefined(self.model.script_modelname) && self.model.spawnflags & 1) {
    if(!isDefined(self.model.disconnect_paths)) {
      self.model call[[level.connectpathsfunction]]();
    } else {
      self.model call[[level.disconnectpathsfunction]]();
    }
  }

  if(level.createfx_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;

    if(!isDefined(self.model.script_modelname)) {
      self.model hide();
      self.model notsolid();
    }
  }
}

exploder_earthquake() {
  exploder_delay();
  do_earthquake(self.v["earthquake"], self.v["origin"]);
}

do_earthquake(var_0, var_1) {
  var_2 = level.earthquake[var_0];
  earthquake(var_2["magnitude"], var_2["duration"], var_1, var_2["radius"]);
}

exploder_rumble() {
  if(!issp()) {
    return;
  }
  exploder_delay();
  level.player playrumbleonentity(self.v["rumble"]);
}

exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;

  }
  var_0 = self.v["delay"];
  var_1 = self.v["delay"] + 0.001;

  if(isDefined(self.v["delay_min"])) {
    var_0 = self.v["delay_min"];

  }
  if(isDefined(self.v["delay_max"])) {
    var_1 = self.v["delay_max"];

  }
  if(var_0 > 0) {
    wait(randomfloatrange(var_0, var_1));
  }
}

exploder_damage() {
  if(isDefined(self.v["delay"])) {
    var_0 = self.v["delay"];
  } else {
    var_0 = 0;

  }
  if(isDefined(self.v["damage_radius"])) {
    var_1 = self.v["damage_radius"];
  } else {
    var_1 = 128;

  }
  var_2 = self.v["damage"];
  var_3 = self.v["origin"];
  wait(var_0);
  radiusdamage(var_3, var_1, var_2, var_2);
}

effect_loopsound() {
  if(isDefined(self.loopsound_ent)) {
    self.loopsound_ent delete();

  }
  var_0 = self.v["origin"];
  var_1 = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = play_loopsound_in_space(var_1, var_0);
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

sound_effect() {
  effect_soundalias();
}

effect_soundalias() {
  var_0 = self.v["origin"];
  var_1 = self.v["soundalias"];
  exploder_delay();
  play_sound_in_space(var_1, var_0);
}

play_sound_in_space(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 1));

  if(!isDefined(var_1)) {
    var_1 = self.origin;

  }
  var_3.origin = var_1;

  if(issp()) {
    if(isDefined(var_2) && var_2) {
      var_3 playsoundasmaster(var_0, "sounddone");
    } else {
      var_3 playSound(var_0, "sounddone");
    }
  } else if(isDefined(var_2) && var_2) {
    var_3 playsoundasmaster(var_0);
  } else {
    var_3 playSound(var_0);

  }
  var_3 waittill("sounddone");
  var_3 delete();
}

cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    thread exploder_playSound();

    for(var_0 = 0; var_0 < self.v["repeat"]; var_0++) {
      playFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      exploder_delay();
    }

    return;
  }

  exploder_delay();

  if(isDefined(self.looper)) {
    self.looper delete();

  }
  self.looper = spawnfx(getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper);
  exploder_playSound();
}

exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect() {
  var_0 = self.v["forward"];
  var_1 = self.v["up"];
  var_2 = undefined;
  var_3 = self.v["firefxsound"];
  var_4 = self.v["origin"];
  var_5 = self.v["firefx"];
  var_6 = self.v["ender"];

  if(!isDefined(var_6)) {
    var_6 = "createfx_effectStopper";

  }
  var_7 = self.v["firefxtimeout"];
  var_8 = 0.5;

  if(isDefined(self.v["firefxdelay"])) {
    var_8 = self.v["firefxdelay"];

  }
  exploder_delay();

  if(isDefined(var_3)) {
    level thread loop_fx_sound(var_3, var_4, 1, var_6, var_7);

  }
  playFX(level._effect[var_5], self.v["origin"], var_0, var_1);
}

loop_fx_sound(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == 1) {
    if(!isDefined(level.first_frame) || level.first_frame == 1) {
      spawnloopingsound(var_0, var_1);
    }
  } else {
    var_5 = spawn("script_origin", (0, 0, 0));

    if(isDefined(var_3)) {
      thread loop_sound_delete(var_3, var_5);
      self endon(var_3);
    }

    var_5.origin = var_1;
    var_5 playLoopSound(var_0);
    var_6 = 0;

    if(isDefined(level.createfx_enabled)) {
      var_6 = level.createfx_enabled;

    }
    if(!isDefined(var_4) && !var_6) {
      var_5 willneverchange();
      return;
    }

    if(isDefined(var_4)) {
      wait(var_4);
    }
  }
}

loop_fx_sound_interval(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_origin", (0, 0, 0));

  if(isDefined(var_2)) {
    thread loop_sound_delete(var_2, var_6);
    self endon(var_2);
  }

  var_6.origin = var_1;

  if(var_4 >= var_5) {
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
    lock("createfx_looper");
    thread play_sound_in_space(var_0, var_6.origin);
    unlock("createfx_looper");
    wait(randomfloatrange(var_4, var_5));
  }
}

loop_sound_delete(var_0, var_1) {
  var_1 endon("death");
  self waittill(var_0);
  var_1 delete();
}

exploder_before_load(var_0) {
  waittillframeend;
  waittillframeend;
  activate_exploder(var_0);
}

exploder_after_load(var_0) {
  activate_exploder(var_0);
}

activate_exploder(var_0) {
  var_0 = var_0 + "";
  level notify("exploding_" + var_0);

  if(isDefined(level.createfxexploders) && !level.createfx_enabled) {
    var_1 = level.createfxexploders[var_0];

    if(isDefined(var_1)) {
      foreach(var_3 in var_1) {}
      var_3 activate_individual_exploder();

      return;
    }
  } else {
    for(var_5 = 0; var_5 < level.createfxent.size; var_5++) {
      var_3 = level.createfxent[var_5];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_0) {
        continue;
      }
      var_3 activate_individual_exploder();
    }
  }
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

is_later_in_alphabet(var_0, var_1) {
  return stricmp(var_0, var_1) > 0;
}

alphabet_compare(var_0, var_1) {
  var_2 = [];
  var_3 = 1;
  var_2["0"] = var_3;
  var_3++;
  var_2["1"] = var_3;
  var_3++;
  var_2["2"] = var_3;
  var_3++;
  var_2["3"] = var_3;
  var_3++;
  var_2["4"] = var_3;
  var_3++;
  var_2["5"] = var_3;
  var_3++;
  var_2["6"] = var_3;
  var_3++;
  var_2["7"] = var_3;
  var_3++;
  var_2["8"] = var_3;
  var_3++;
  var_2["9"] = var_3;
  var_3++;
  var_2["_"] = var_3;
  var_3++;
  var_2["a"] = var_3;
  var_3++;
  var_2["b"] = var_3;
  var_3++;
  var_2["c"] = var_3;
  var_3++;
  var_2["d"] = var_3;
  var_3++;
  var_2["e"] = var_3;
  var_3++;
  var_2["f"] = var_3;
  var_3++;
  var_2["g"] = var_3;
  var_3++;
  var_2["h"] = var_3;
  var_3++;
  var_2["i"] = var_3;
  var_3++;
  var_2["j"] = var_3;
  var_3++;
  var_2["k"] = var_3;
  var_3++;
  var_2["l"] = var_3;
  var_3++;
  var_2["m"] = var_3;
  var_3++;
  var_2["n"] = var_3;
  var_3++;
  var_2["o"] = var_3;
  var_3++;
  var_2["p"] = var_3;
  var_3++;
  var_2["q"] = var_3;
  var_3++;
  var_2["r"] = var_3;
  var_3++;
  var_2["s"] = var_3;
  var_3++;
  var_2["t"] = var_3;
  var_3++;
  var_2["u"] = var_3;
  var_3++;
  var_2["v"] = var_3;
  var_3++;
  var_2["w"] = var_3;
  var_3++;
  var_2["x"] = var_3;
  var_3++;
  var_2["y"] = var_3;
  var_3++;
  var_2["z"] = var_3;
  var_3++;
  var_0 = tolower(var_0);
  var_1 = tolower(var_1);
  var_4 = 0;

  if(isDefined(var_2[var_0])) {
    var_4 = var_2[var_0];

  }
  var_5 = 0;

  if(isDefined(var_2[var_1])) {
    var_5 = var_2[var_1];

  }
  if(var_4 > var_5) {
    return "1st";

  }
  if(var_4 < var_5) {
    return "2nd";

  }
  return "same";
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

exploder(var_0) {
  [[level.exploderfunction]](var_0);
}

create_dvar(var_0, var_1) {
  setdvarifuninitialized(var_0, var_1);
}

void() {}

tag_project(var_0, var_1) {
  var_2 = self gettagorigin(var_0);
  var_3 = self gettagangles(var_0);
  var_4 = anglesToForward(var_3);
  var_4 = vectornormalize(var_4) * var_1;
  return var_2 + var_4;
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

  if(isDefined(level.template_script)) {
    var_0 = level.template_script;

  }
  return var_0;
}