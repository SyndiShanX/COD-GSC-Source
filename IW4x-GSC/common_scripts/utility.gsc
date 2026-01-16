/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\utility.gsc
**************************************/

scriptPrintln(channel, msg) {
  setprintchannel(channel);
  println(msg);
  setprintchannel("script");
}

debugPrintln(channel, msg) {
  setprintchannel("script_debug");
  println(msg);
  setprintchannel("script");
}

draw_debug_line(start, end, timer) {
  for (i = 0; i < timer * 20; i++) {
    line(start, end, (1, 1, 0.5));
    wait(0.05);
  }
}

waittillend(msg) {
  self waittillmatch(msg, "end");
}

noself_func(func, parm1, parm2, parm3, parm4) {
  if(!isdefined(level.func))
    return;
  if(!isdefined(level.func[func])) {
    return;
  }
  if(!isdefined(parm1)) {
    call[[level.func[func]]]();
    return;
  }

  if(!isdefined(parm2)) {
    call[[level.func[func]]](parm1);
    return;
  }
  if(!isdefined(parm3)) {
    call[[level.func[func]]](parm1, parm2);
    return;
  }
  if(!isdefined(parm4)) {
    call[[level.func[func]]](parm1, parm2, parm3);
    return;
  }

  call[[level.func[func]]](parm1, parm2, parm3, parm4);
}

self_func(func, parm1, parm2, parm3, parm4) {
  if(!isdefined(level.func[func])) {
    return;
  }
  if(!isdefined(parm1)) {
    self call[[level.func[func]]]();
    return;
  }

  if(!isdefined(parm2)) {
    self call[[level.func[func]]](parm1);
    return;
  }
  if(!isdefined(parm3)) {
    self call[[level.func[func]]](parm1, parm2);
    return;
  }
  if(!isdefined(parm4)) {
    self call[[level.func[func]]](parm1, parm2, parm3);
    return;
  }

  self call[[level.func[func]]](parm1, parm2, parm3, parm4);
}

randomvector(num) {
  return (randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5, randomfloat(num) - num * 0.5);
}

randomvectorrange(num_min, num_max) {
  assert(isdefined(num_min));
  assert(isdefined(num_max));

  x = randomfloatrange(num_min, num_max);
  if(randomint(2) == 0)
    x *= -1;

  y = randomfloatrange(num_min, num_max);
  if(randomint(2) == 0)
    y *= -1;

  z = randomfloatrange(num_min, num_max);
  if(randomint(2) == 0)
    z *= -1;

  return (x, y, z);
}

angle_dif(oldangle, newangle) {
  // returns the difference between two yaws
  if(oldangle == newangle)
    return 0;

  while (newangle > 360)
    newangle -= 360;

  while (newangle < 0)
    newangle += 360;

  while (oldangle > 360)
    oldangle -= 360;

  while (oldangle < 0)
    oldangle += 360;

  olddif = undefined;
  newdif = undefined;

  if(newangle > 180)
    newdif = 360 - newangle;
  else
    newdif = newangle;

  if(oldangle > 180)
    olddif = 360 - oldangle;
  else
    olddif = oldangle;

  outerdif = newdif + olddif;
  innerdif = 0;

  if(newangle > oldangle)
    innerdif = newangle - oldangle;
  else
    innerdif = oldangle - newangle;

  if(innerdif < outerdif)
    return innerdif;
  else
    return outerdif;
}

sign(x) {
  if(x >= 0)
    return 1;
  return -1;
}

track(spot_to_track) {
  if(isdefined(self.current_target)) {
    if(spot_to_track == self.current_target)
      return;
  }
  self.current_target = spot_to_track;
}

get_enemy_team(team) {
  assertEx(team != "neutral", "Team must be allies or axis");

  teams = [];
  teams["axis"] = "allies";
  teams["allies"] = "axis";

  return teams[team];
}

clear_exception(type) {
  assert(isdefined(self.exception[type]));
  self.exception[type] = anim.defaultException;
}

set_exception(type, func) {
  assert(isdefined(self.exception[type]));
  self.exception[type] = func;
}

set_all_exceptions(exceptionFunc) {
  keys = getArrayKeys(self.exception);
  for (i = 0; i < keys.size; i++) {
    self.exception[keys[i]] = exceptionFunc;
  }
}

cointoss() {
  return randomint(100) >= 50;
}

choose_from_weighted_array(values, weights) {
  assert(values.size == weights.size);

  randomval = randomint(weights[weights.size - 1] + 1);

  for (i = 0; i < weights.size; i++) {
    if(randomval <= weights[i])
      return values[i];
  }
}

get_cumulative_weights(weights) {
  cumulative_weights = [];

  sum = 0;
  for (i = 0; i < weights.size; i++) {
    sum += weights[i];
    cumulative_weights[i] = sum;
  }

  return cumulative_weights;
}

waittill_string(msg, ent) {
  if(msg != "death")
    self endon("death");

  ent endon("die");
  self waittill(msg);
  ent notify("returned", msg);
}

waittill_multiple(string1, string2, string3, string4, string5) {
  self endon("death");
  ent = spawnstruct();
  ent.threads = 0;

  if(isdefined(string1)) {
    self thread waittill_string(string1, ent);
    ent.threads++;
  }
  if(isdefined(string2)) {
    self thread waittill_string(string2, ent);
    ent.threads++;
  }
  if(isdefined(string3)) {
    self thread waittill_string(string3, ent);
    ent.threads++;
  }
  if(isdefined(string4)) {
    self thread waittill_string(string4, ent);
    ent.threads++;
  }
  if(isdefined(string5)) {
    self thread waittill_string(string5, ent);
    ent.threads++;
  }

  while (ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

waittill_multiple_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4) {
  self endon("death");
  ent = spawnstruct();
  ent.threads = 0;

  if(isdefined(ent1)) {
    assert(isdefined(string1));
    ent1 thread waittill_string(string1, ent);
    ent.threads++;
  }
  if(isdefined(ent2)) {
    assert(isdefined(string2));
    ent2 thread waittill_string(string2, ent);
    ent.threads++;
  }
  if(isdefined(ent3)) {
    assert(isdefined(string3));
    ent3 thread waittill_string(string3, ent);
    ent.threads++;
  }
  if(isdefined(ent4)) {
    assert(isdefined(string4));
    ent4 thread waittill_string(string4, ent);
    ent.threads++;
  }

  while (ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }

  ent notify("die");
}

waittill_any_return(string1, string2, string3, string4, string5) {
  if((!isdefined(string1) || string1 != "death") &&
    (!isdefined(string2) || string2 != "death") &&
    (!isdefined(string3) || string3 != "death") &&
    (!isdefined(string4) || string4 != "death") &&
    (!isdefined(string5) || string5 != "death"))
    self endon("death");

  ent = spawnstruct();

  if(isdefined(string1))
    self thread waittill_string(string1, ent);

  if(isdefined(string2))
    self thread waittill_string(string2, ent);

  if(isdefined(string3))
    self thread waittill_string(string3, ent);

  if(isdefined(string4))
    self thread waittill_string(string4, ent);

  if(isdefined(string5))
    self thread waittill_string(string5, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any_timeout(timeOut, string1, string2, string3, string4, string5) {
  if((!isdefined(string1) || string1 != "death") &&
    (!isdefined(string2) || string2 != "death") &&
    (!isdefined(string3) || string3 != "death") &&
    (!isdefined(string4) || string4 != "death") &&
    (!isdefined(string5) || string5 != "death"))
    self endon("death");

  ent = spawnstruct();

  if(isdefined(string1))
    self thread waittill_string(string1, ent);

  if(isdefined(string2))
    self thread waittill_string(string2, ent);

  if(isdefined(string3))
    self thread waittill_string(string3, ent);

  if(isdefined(string4))
    self thread waittill_string(string4, ent);

  if(isdefined(string5))
    self thread waittill_string(string5, ent);

  ent thread _timeout(timeOut);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

_timeout(delay) {
  self endon("die");

  wait(delay);
  self notify("returned", "timeout");
}

waittill_any(string1, string2, string3, string4, string5, string6, string7, string8) {
  assert(isdefined(string1));

  if(isdefined(string2))
    self endon(string2);

  if(isdefined(string3))
    self endon(string3);

  if(isdefined(string4))
    self endon(string4);

  if(isdefined(string5))
    self endon(string5);

  if(isdefined(string6))
    self endon(string6);

  if(isdefined(string7))
    self endon(string7);

  if(isdefined(string8))
    self endon(string8);

  self waittill(string1);
}

waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isdefined(ent1));
  assert(isdefined(string1));

  if((isdefined(ent2)) && (isdefined(string2)))
    ent2 endon(string2);

  if((isdefined(ent3)) && (isdefined(string3)))
    ent3 endon(string3);

  if((isdefined(ent4)) && (isdefined(string4)))
    ent4 endon(string4);

  if((isdefined(ent5)) && (isdefined(string5)))
    ent5 endon(string5);

  if((isdefined(ent6)) && (isdefined(string6)))
    ent6 endon(string6);

  if((isdefined(ent7)) && (isdefined(string7)))
    ent7 endon(string7);

  ent1 waittill(string1);
}

isFlashed() {
  if(!isdefined(self.flashEndTime))
    return false;

  return gettime() < self.flashEndTime;
}

flag_exist(message) {
  return isdefined(level.flag[message]);
}

flag(message) {
  assertEx(isdefined(message), "Tried to check flag but the flag was not defined.");
  assertEx(isdefined(level.flag[message]), "Tried to check flag " + message + " but the flag was not initialized.");

  return level.flag[message];
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

flag_init(message) {
  if(!isDefined(level.flag)) {
    init_flags();
  }

  if(isdefined(level.first_frame) && level.first_frame == -1)
    assertEx(!isDefined(level.flag[message]), "Attempt to reinitialize existing message: " + message);

  level.flag[message] = false;
  // lock check
  if(!isdefined(level.trigger_flags)) {
    init_trigger_flags();
    level.trigger_flags[message] = [];
  } else
  if(!isdefined(level.trigger_flags[message])) {
    level.trigger_flags[message] = [];
  }

  if(issuffix(message, "aa_")) {
    thread[[level.sp_stat_tracking_func]](message);
  }
}

empty_init_func(empty) {}

issuffix(msg, suffix) {
  if(suffix.size > msg.size)
    return false;

  for (i = 0; i < suffix.size; i++) {
    if(msg[i] != suffix[i])
      return false;
  }
  return true;
}

flag_set(message, setter) {
  assertEx(isDefined(level.flag[message]), "Attempt to set a flag before calling flag_init: " + message);
  //lock check

  level.flag[message] = true;
  set_trigger_flag_permissions(message);
  if(isdefined(setter)) {
    level notify(message, setter); // notify needs to be very last thing called
  } else {
    level notify(message); // notify needs to be very last thing called
  }
}

assign_unique_id() {
  self.unique_id = "generic" + level.generic_index;
  level.generic_index++;
}

flag_wait(msg, entity) {
  other = undefined;
  while (!flag(msg)) {
    other = undefined;
    level waittill(msg, other);

    // if we're waiting for the flag on a specific entity then we have to check
    // to see if the flag is set on that specific entity
    if(isdefined(entity) && flag(msg, entity)) {
      break;
    }
  }
  if(isdefined(other))
    return other;
}

flag_clear(message) {
  assertEx(isDefined(level.flag[message]), "Attempt to set a flag before calling flag_init: " + message);
  // lock implementation tbd
  //do this check so we don't unneccessarily send a notify
  if(!flag(message)) {
    return;
  }
  level.flag[message] = false;

  set_trigger_flag_permissions(message);
  level notify(message); // the notify needs to be the very last thing called in this function
}

flag_waitopen(msg) {
  while (flag(msg))
    level waittill(msg);
}

waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

array_thread(entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isdefined(var1)) {
    foreach(ent in entities)
    ent thread[[process]]();
    return;
  }

  if(!isdefined(var2)) {
    foreach(ent in entities)
    ent thread[[process]](var1);
    return;
  }

  if(!isdefined(var3)) {
    foreach(ent in entities)
    ent thread[[process]](var1, var2);
    return;
  }

  if(!isdefined(var4)) {
    foreach(ent in entities)
    ent thread[[process]](var1, var2, var3);
    return;
  }

  if(!isdefined(var5)) {
    foreach(ent in entities)
    ent thread[[process]](var1, var2, var3, var4);
    return;
  }

  if(!isdefined(var6)) {
    foreach(ent in entities)
    ent thread[[process]](var1, var2, var3, var4, var5);
    return;
  }

  if(!isdefined(var7)) {
    foreach(ent in entities)
    ent thread[[process]](var1, var2, var3, var4, var5, var6);
    return;
  }

  if(!isdefined(var8)) {
    foreach(ent in entities)
    ent thread[[process]](var1, var2, var3, var4, var5, var6, var7);
    return;
  }

  if(!isdefined(var9)) {
    foreach(ent in entities)
    ent thread[[process]](var1, var2, var3, var4, var5, var6, var7, var8);
    return;
  }

  foreach(ent in entities)
  ent thread[[process]](var1, var2, var3, var4, var5, var6, var7, var8, var9);
  return;
}

array_call(entities, process, var1, var2, var3) {
  if(isdefined(var3)) {
    foreach(ent in entities)
    ent call[[process]](var1, var2, var3);

    return;
  }

  if(isdefined(var2)) {
    foreach(ent in entities)
    ent call[[process]](var1, var2);

    return;
  }

  if(isdefined(var1)) {
    foreach(ent in entities)
    ent call[[process]](var1);

    return;
  }

  foreach(ent in entities)
  ent call[[process]]();
}

array_thread4(entities, process, var1, var2, var3, var4) {
  array_thread(entities, process, var1, var2, var3, var4);
}

array_thread5(entities, process, var1, var2, var3, var4, var5) {
  array_thread(entities, process, var1, var2, var3, var4, var5);
}

remove_undefined_from_array(array) {
  newarray = [];
  for (i = 0; i < array.size; i++) {
    if(!isdefined(array[i]))
      continue;
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

trigger_on(name, type) {
  if(isdefined(name) && isdefined(type)) {
    ents = getentarray(name, type);
    array_thread(ents, ::trigger_on_proc);
  } else
    self trigger_on_proc();
}

trigger_on_proc() {
  if(isDefined(self.realOrigin))
    self.origin = self.realOrigin;
  self.trigger_off = undefined;
}

trigger_off(name, type) {
  if(isdefined(name) && isdefined(type)) {
    ents = getentarray(name, type);
    array_thread(ents, ::trigger_off_proc);
  } else
    self trigger_off_proc();
}

trigger_off_proc() {
  if(!isDefined(self.realOrigin))
    self.realOrigin = self.origin;

  if(self.origin == self.realorigin)
    self.origin += (0, 0, -10000);
  self.trigger_off = true;
}

set_trigger_flag_permissions(msg) {
  // turns triggers on or off depending on if they have the proper flags set, based on their shift-g menu settings

  // this can be init before _load has run, thanks to AI.
  if(!isdefined(level.trigger_flags)) {
    return;
  }
  // cheaper to do the upkeep at this time rather than with endons and waittills on the individual triggers	
  level.trigger_flags[msg] = remove_undefined_from_array(level.trigger_flags[msg]);
  array_thread(level.trigger_flags[msg], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  true_on = true;
  if(isdefined(self.script_flag_true)) {
    true_on = false;
    tokens = create_flags_and_return_tokens(self.script_flag_true);

    // stay off unless all the flags are false
    foreach(token in tokens) {
      if(flag(token)) {
        true_on = true;
        break;
      }
    }
  }

  false_on = true;
  if(isdefined(self.script_flag_false)) {
    tokens = create_flags_and_return_tokens(self.script_flag_false);

    // stay off unless all the flags are false
    foreach(token in tokens) {
      if(flag(token)) {
        false_on = false;
        break;
      }
    }
  }

  [[level.trigger_func[true_on && false_on]]]();
}

create_flags_and_return_tokens(flags) {
  tokens = strtok(flags, " ");

  // create the flag if level script does not
  for (i = 0; i < tokens.size; i++) {
    if(!isdefined(level.flag[tokens[i]])) {
      flag_init(tokens[i]);
    }
  }

  return tokens;
}

init_trigger_flags() {
  level.trigger_flags = [];
  level.trigger_func[true] = ::trigger_on;
  level.trigger_func[false] = ::trigger_off;
}

getstruct(name, type) {
  assertex(isdefined(name) && isdefined(type), "Did not fill in name and type");
  assertEx(isdefined(level.struct_class_names), "Tried to getstruct before the structs were init");

  array = level.struct_class_names[type][name];
  if(!isdefined(array)) {
    return undefined;
  }

  if(array.size > 1) {
    assertMsg("getstruct used for more than one struct of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

getstructarray(name, type) {
  assertEx(isdefined(level.struct_class_names), "Tried to getstruct before the structs were init");

  array = level.struct_class_names[type][name];
  if(!isdefined(array))
    return [];
  return array;
}

struct_class_init() {
  assertEx(!isdefined(level.struct_class_names), "level.struct_class_names is being initialized in the wrong place! It shouldn't be initialized yet.");

  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];

  foreach(struct in level.struct) {
    if(isdefined(struct.targetname)) {
      if(!isdefined(level.struct_class_names["targetname"][struct.targetname]))
        level.struct_class_names["targetname"][struct.targetname] = [];

      size = level.struct_class_names["targetname"][struct.targetname].size;
      level.struct_class_names["targetname"][struct.targetname][size] = struct;
    }
    if(isdefined(struct.target)) {
      if(!isdefined(level.struct_class_names["target"][struct.target]))
        level.struct_class_names["target"][struct.target] = [];

      size = level.struct_class_names["target"][struct.target].size;
      level.struct_class_names["target"][struct.target][size] = struct;
    }
    if(isdefined(struct.script_noteworthy)) {
      if(!isdefined(level.struct_class_names["script_noteworthy"][struct.script_noteworthy]))
        level.struct_class_names["script_noteworthy"][struct.script_noteworthy] = [];

      size = level.struct_class_names["script_noteworthy"][struct.script_noteworthy].size;
      level.struct_class_names["script_noteworthy"][struct.script_noteworthy][size] = struct;
    }
    if(isdefined(struct.script_linkname)) {
      assertex(!isdefined(level.struct_class_names["script_linkname"][struct.script_linkname]), "Two structs have the same linkname");
      level.struct_class_names["script_linkname"][struct.script_linkname][0] = struct;
    }
  }
}

fileprint_start(file) {
  filename = file;
  level.fileprint = 1;
  level.fileprintlinecount = 0;
  level.fileprint_filename = filename;
}

fileprint_map_start() {
  // for the entity count
  level.fileprint_mapentcount = 0;
  fileprint_map_header(true);

}

fileprint_map_header(bInclude_blank_worldspawn) {
  if(!isdefined(bInclude_blank_worldspawn))
    bInclude_blank_worldspawn = false;

  fileprint_launcher("iwmap 6");
  fileprint_launcher("\"000_Global\" flagsactive");
  fileprint_launcher("\"The Map\" flags");

  if(!bInclude_blank_worldspawn) {
    return;
  }
  fileprint_map_entity_start();
  fileprint_map_keypairprint("classname", "worldspawn");
  fileprint_map_entity_end();

}

fileprint_map_keypairprint(key1, key2) {
  fileprint_launcher("\"" + key1 + "\" \"" + key2 + "\"");
}

fileprint_map_entity_start() {
  assert(isdefined(level.fileprint_mapentcount), "need to start a map with fileprint_map_start() first");
  assert(!isdefined(level.fileprint_entitystart));
  level.fileprint_entitystart = true;
  fileprint_launcher("entity " + level.fileprint_mapentcount);
  fileprint_launcher("{");
  level.fileprint_mapentcount++;
}

fileprint_map_entity_end() {
  fileprint_launcher("}");
  level.fileprint_entitystart = undefined;
}

fileprint_radiant_vec(vector) {
  string = "" + vector[0] + " " + vector[1] + " " + vector[2] + "";
  return string;
}

vector_multiply(vec, dif) {
  vec = (vec[0] * dif, vec[1] * dif, vec[2] * dif);
  return vec;
}

array_remove(ents, remover) {
  newents = [];
  foreach(index in ents) {
    if(index != remover)
      newents[newents.size] = index;
  }

  return newents;
}

array_remove_array(ents, remover_array) {
  foreach(remover in remover_array)
  ents = array_remove(ents, remover);

  return ents;
}

array_removeUndefined(array) {
  newArray = [];
  for (i = 0; i < array.size; i++) {
    if(!isdefined(array[i]))
      continue;
    newArray[newArray.size] = array[i];
  }

  return newArray;
}

array_levelthread(array, process, var1, var2, var3) {
  if(isdefined(var3)) {
    foreach(ent in array)
    thread[[process]](ent, var1, var2, var3);

    return;
  }

  if(isdefined(var2)) {
    foreach(ent in array)
    thread[[process]](ent, var1, var2);

    return;
  }

  if(isdefined(var1)) {
    foreach(ent in array)
    thread[[process]](ent, var1);

    return;
  }

  foreach(ent in array)
  thread[[process]](ent);
}

array_levelcall(array, process, var1, var2, var3) {
  if(isdefined(var3)) {
    foreach(ent in array)
    call[[process]](ent, var1, var2, var3);

    return;
  }

  if(isdefined(var2)) {
    foreach(ent in array)
    call[[process]](ent, var1, var2);

    return;
  }

  if(isdefined(var1)) {
    foreach(ent in array)
    call[[process]](ent, var1);

    return;
  }

  foreach(ent in array)
  call[[process]](ent);
}

add_to_array(array, ent) {
  if(!isdefined(ent))
    return array;

  if(!isdefined(array))
    array[0] = ent;
  else
    array[array.size] = ent;

  return array;
}

flag_assert(msg) {
  assertEx(!flag(msg), "Flag " + msg + " set too soon!");
}

flag_wait_either(flag1, flag2) {
  for (;;) {
    if(flag(flag1))
      return;
    if(flag(flag2)) {
      return;
    }
    level waittill_either(flag1, flag2);
  }
}

flag_wait_either_return(flag1, flag2) {
  for (;;) {
    if(flag(flag1))
      return flag1;
    if(flag(flag2))
      return flag2;

    msg = level waittill_any_return(flag1, flag2);
    return msg;
  }
}

flag_wait_any(flag1, flag2, flag3, flag4, flag5, flag6) {
  array = [];
  if(isdefined(flag6)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
    array[array.size] = flag5;
    array[array.size] = flag6;
  } else if(isdefined(flag5)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
    array[array.size] = flag5;
  } else if(isdefined(flag4)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
  } else if(isdefined(flag3)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
  } else if(isdefined(flag2)) {
    flag_wait_either(flag1, flag2);
    return;
  } else {
    assertmsg("flag_wait_any() needs at least 2 flags passed to it");
    return;
  }

  for (;;) {
    for (i = 0; i < array.size; i++) {
      if(flag(array[i]))
        return;
    }

    level waittill_any(flag1, flag2, flag3, flag4, flag5, flag6);
  }
}

flag_wait_any_return(flag1, flag2, flag3, flag4, flag5, flag6) {
  array = [];
  if(isdefined(flag6)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
    array[array.size] = flag5;
    array[array.size] = flag6;
  } else if(isdefined(flag5)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
    array[array.size] = flag5;
  } else if(isdefined(flag4)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
    array[array.size] = flag4;
  } else if(isdefined(flag3)) {
    array[array.size] = flag1;
    array[array.size] = flag2;
    array[array.size] = flag3;
  } else if(isdefined(flag2)) {
    msg = flag_wait_either_return(flag1, flag2);
    return msg;
  } else {
    assertmsg("flag_wait_any_return() needs at least 2 flags passed to it");
    return;
  }

  for (;;) {
    for (i = 0; i < array.size; i++) {
      if(flag(array[i]))
        return array[i];
    }

    msg = level waittill_any_return(flag1, flag2, flag3, flag4, flag5, flag6);
    return msg;
  }
}

flag_wait_all(flag1, flag2, flag3, flag4) {
  if(isdefined(flag1))
    flag_wait(flag1);

  if(isdefined(flag2))
    flag_wait(flag2);

  if(isdefined(flag3))
    flag_wait(flag3);

  if(isdefined(flag4))
    flag_wait(flag4);
}

flag_wait_or_timeout(flagname, timer) {
  timerMS = timer * 1000;
  start_time = GetTime();

  for (;;) {
    if(flag(flagname)) {
      break;
    }

    if(GetTime() >= start_time + timerMS) {
      break;
    }

    timeRemaining = timerMS - (GetTime() - start_time); // figure out how long we waited already, if at all
    timeRemainingSecs = timeRemaining / 1000;
    wait_for_flag_or_time_elapses(flagname, timeRemainingSecs);
  }
}

flag_waitopen_or_timeout(flagname, timer) {
  start_time = gettime();
  for (;;) {
    if(!flag(flagname)) {
      break;
    }

    if(gettime() >= start_time + timer * 1000) {
      break;
    }

    wait_for_flag_or_time_elapses(flagname, timer);
  }
}

wait_for_flag_or_time_elapses(flagname, timer) {
  level endon(flagname);
  wait(timer);
}

delayCall(timer, func, param1, param2, param3, param4) {
  // to thread it off
  thread delayCall_proc(func, timer, param1, param2, param3, param4);
}

delayCall_proc(func, timer, param1, param2, param3, param4) {
  if(isSP())
    self endon("death");

  wait(timer);
  if(isdefined(param4))
    self call[[func]](param1, param2, param3, param4);
  else
  if(isdefined(param3))
    self call[[func]](param1, param2, param3);
  else
  if(isdefined(param2))
    self call[[func]](param1, param2);
  else
  if(isdefined(param1))
    self call[[func]](param1);
  else
    self call[[func]]();
}

noself_delayCall(timer, func, param1, param2, param3, param4) {
  // to thread it off
  thread noself_delayCall_proc(func, timer, param1, param2, param3, param4);
}

noself_delayCall_proc(func, timer, param1, param2, param3, param4) {
  wait(timer);
  if(isdefined(param4))
    call[[func]](param1, param2, param3, param4);
  else
  if(isdefined(param3))
    call[[func]](param1, param2, param3);
  else
  if(isdefined(param2))
    call[[func]](param1, param2);
  else
  if(isdefined(param1))
    call[[func]](param1);
  else
    call[[func]]();
}

isSP() {
  return false; // this code is only loaded in MP, so obviously this is MP
}

string_starts_with(string, start) {
  assert(isdefined(string));
  assert(isdefined(start));
  if(string.size < start.size)
    return false;

  for (i = 0; i < start.size; i++) {
    if(tolower(string[i]) != tolower(start[i]))
      return false;
  }

  return true;
}

plot_points(plotpoints, r, g, b, timer) {
  lastpoint = plotpoints[0];
  if(!isdefined(r))
    r = 1;
  if(!isdefined(g))
    g = 1;
  if(!isdefined(b))
    b = 1;
  if(!isdefined(timer))
    timer = 0.05;
  for (i = 1; i < plotpoints.size; i++) {
    thread draw_line_for_time(lastpoint, plotpoints[i], r, g, b, timer);
    lastpoint = plotpoints[i];
  }
}

draw_line_for_time(org1, org2, r, g, b, timer) {
  timer = gettime() + (timer * 1000);
  while (gettime() < timer) {
    line(org1, org2, (r, g, b), 1);
    wait .05;
  }

}

array_combine(array1, array2) {
  array3 = [];
  foreach(item in array1) {
    array3[array3.size] = item;
  }
  foreach(item in array2) {
    array3[array3.size] = item;
  }
  return array3;
}

flat_angle(angle) {
  rangle = (0, angle[1], 0);
  return rangle;
}

flat_origin(org) {
  rorg = (org[0], org[1], 0);
  return rorg;

}

draw_arrow_time(start, end, color, duration) {
  level endon("newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglestoforward(angles);
  up = anglestoup(angles);

  dist = distance(start, end);
  arrow = [];
  range = 0.1;

  arrow[0] = start;
  arrow[1] = start + vector_multiply(right, dist * (range)) + vector_multiply(forward, dist * -0.1);
  arrow[2] = end;
  arrow[3] = start + vector_multiply(right, dist * (-1 * range)) + vector_multiply(forward, dist * -0.1);

  arrow[4] = start;
  arrow[5] = start + vector_multiply(up, dist * (range)) + vector_multiply(forward, dist * -0.1);
  arrow[6] = end;
  arrow[7] = start + vector_multiply(up, dist * (-1 * range)) + vector_multiply(forward, dist * -0.1);
  arrow[8] = start;

  r = color[0];
  g = color[1];
  b = color[2];

  plot_points(arrow, r, g, b, duration);
}

get_linked_ents() {
  array = [];

  if(isdefined(self.script_linkto)) {
    linknames = get_links();
    foreach(name in linknames) {
      entities = getentarray(name, "script_linkname");
      if(entities.size > 0)
        array = array_combine(array, entities);
    }
  }

  return array;
}

get_linked_ent() {
  array = get_linked_ents();
  assert(array.size == 1);
  assert(isdefined(array[0]));
  return array[0];
}

get_links() {
  return strtok(self.script_linkTo, " ");
}

run_thread_on_targetname(msg, func, param1, param2, param3) {
  array = getentarray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);

  array = getstructarray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);

  array = call[[level.getNodeArrayFunction]](msg, "targetname");
  array_thread(array, func, param1, param2, param3);

  array = getvehiclenodearray(msg, "targetname");
  array_thread(array, func, param1, param2, param3);
}

run_thread_on_noteworthy(msg, func, param1, param2, param3) {
  array = getentarray(msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);

  array = getstructarray(msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);

  array = call[[level.getNodeArrayFunction]](msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);

  array = getvehiclenodearray(msg, "script_noteworthy");
  array_thread(array, func, param1, param2, param3);
}

draw_arrow(start, end, color) {
  level endon("newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglestoforward(angles);

  dist = distance(start, end);
  arrow = [];
  range = 0.05;
  arrow[0] = start;
  arrow[1] = start + vector_multiply(right, dist * (range)) + vector_multiply(forward, dist * -0.2);
  arrow[2] = end;
  arrow[3] = start + vector_multiply(right, dist * (-1 * range)) + vector_multiply(forward, dist * -0.2);

  for (p = 0; p < 4; p++) {
    nextpoint = p + 1;
    if(nextpoint >= 4)
      nextpoint = 0;
    line(arrow[p], arrow[nextpoint], color, 1.0);
  }
}

cap_value(value, minValue, maxValue) {
  assert(isdefined(value));

  // handle a min value larger than a max value
  if(minValue > maxValue)
    return cap_value(value, maxValue, minValue);

  assert(minValue <= maxValue);

  if(isdefined(minValue) && (value < minValue))
    return minValue;

  if(isdefined(maxValue) && (value > maxValue))
    return maxValue;

  return value;
}

getfx(fx) {
  assertEx(isdefined(level._effect[fx]), "Fx " + fx + " is not defined in level._effect.");
  return level._effect[fx];
}

fxExists(fx) {
  return isdefined(level._effect[fx]);
}

print_csv_asset(asset, type) {
  fileline = type + "," + asset;
  if(isdefined(level.csv_lines[fileline]))
    return;
  level.csv_lines[fileline] = true;
  //	fileprint_chk( level.fileprint, fileline );
}

fileprint_csv_start(file) {
  file = "scriptgen/" + file + ".csv";
  level.csv_lines = [];
}

_loadfx(effect) {
  return loadfx(effect);
}

getLastWeapon() {
  assert(isDefined(self.saved_lastWeapon));

  return self.saved_lastWeapon;
}

PlayerUnlimitedAmmoThread() {
  if(!isdefined(self) || self == level || self.code_classname != "player")
    player = level.player;
  else
    player = self;

  assert(isdefined(player));

  while (1) {
    wait .5;

    if(getdvar("UnlimitedAmmoOff") == "1") {
      continue;
    }
    currentWeapon = player getCurrentWeapon();
    if(currentWeapon != "none") {
      currentAmmo = player GetFractionMaxAmmo(currentWeapon);
      if(currentAmmo < 0.2)
        player GiveMaxAmmo(currentWeapon);
    }
    currentoffhand = player GetCurrentOffhand();
    if(currentoffhand != "none") {
      currentAmmo = player GetFractionMaxAmmo(currentoffhand);
      if(currentAmmo < 0.4)
        player GiveMaxAmmo(currentoffhand);
    }
  }
}

isUsabilityEnabled() {
  return (!self.disabledUsability);
}

_disableUsability() {
  self.disabledUsability++;
  self DisableUsability();
}

_enableUsability() {
  self.disabledUsability--;

  assert(self.disabledUsability >= 0);

  if(!self.disabledUsability)
    self EnableUsability();
}

resetUsability() {
  self.disabledUsability = 0;
  self EnableUsability();
}

_disableWeapon() {
  self.disabledWeapon++;
  self disableWeapons();
}

_enableWeapon() {
  self.disabledWeapon--;

  assert(self.disabledWeapon >= 0);

  if(!self.disabledWeapon)
    self enableWeapons();
}

isWeaponEnabled() {
  return (!self.disabledWeapon);
}

_disableWeaponSwitch() {
  self.disabledWeaponSwitch++;
  self disableWeaponSwitch();
}

_enableWeaponSwitch() {
  self.disabledWeaponSwitch--;

  assert(self.disabledWeaponSwitch >= 0);

  if(!self.disabledWeaponSwitch)
    self enableWeaponSwitch();
}

isWeaponSwitchEnabled() {
  return (!self.disabledWeaponSwitch);
}

_disableOffhandWeapons() {
  self.disabledOffhandWeapons++;
  self DisableOffhandWeapons();
}

_enableOffhandWeapons() {
  self.disabledOffhandWeapons--;

  assert(self.disabledOffhandWeapons >= 0);

  if(!self.disabledOffhandWeapons)
    self EnableOffhandWeapons();
}

isOffhandWeaponEnabled() {
  return (!self.disabledOffhandWeapons);
}

random(array) {
  // process the array so it'll work with any string index arrays and arrays with missing entries.
  newarray = [];
  foreach(index, value in array) {
    newarray[newarray.size] = value;
  }

  if(!newarray.size)
    return undefined;

  return newarray[randomint(newarray.size)];
}

spawn_tag_origin() {
  tag_origin = spawn("script_model", (0, 0, 0));
  tag_origin setmodel("tag_origin");
  tag_origin hide();
  if(isdefined(self.origin))
    tag_origin.origin = self.origin;
  if(isdefined(self.angles))
    tag_origin.angles = self.angles;

  return tag_origin;
}

waittill_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait(timer);
}

fileprint_launcher_start_file() {
  AssertEx(!isdefined(level.fileprint_launcher), "Can't open more than one file at a time to print through launcher.");
  level.fileprintlauncher_linecount = 0;
  level.fileprint_launcher = true;
  fileprint_launcher("GAMEPRINTSTARTFILE:");
}

fileprint_launcher(string) {
  assert(isdefined(level.fileprintlauncher_linecount));
  level.fileprintlauncher_linecount++;
  if(level.fileprintlauncher_linecount > 200) {
    wait .05;
    level.fileprintlauncher_linecount = 0;
  }
  println("LAUNCHERPRINTLN:" + string);
}

fileprint_launcher_end_file(file_relative_to_game, bIsPerforceEnabled) {
  if(!isdefined(bIsPerforceEnabled))
    bIsPerforceEnabled = false;

  setDevDvarIfUninitialized("LAUNCHER_PRINT_FAIL", "0");
  setDevDvarIfUninitialized("LAUNCHER_PRINT_SUCCESS", "0");

  if(bIsPerforceEnabled)
    fileprint_launcher("GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + file_relative_to_game);
  else
    fileprint_launcher("GAMEPRINTENDFILE:" + file_relative_to_game);

  // wait for launcher to tell us that it's done writing the file 
  TimeOut = gettime() + 4000; // give launcher 4 seconds to print the file.
  while (getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getdvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < TimeOut)
    wait .05;

  if(!(gettime() < TimeOut)) {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
    setdevdvar("LAUNCHER_PRINT_FAIL", "0");
    level.fileprint_launcher = undefined;
    return false;
  }

  failvar = getdvar("LAUNCHER_PRINT_FAIL");
  if(failvar != "0") {
    iprintlnbold("LAUNCHER_PRINT_FAIL:( " + failvar + " ): launcherconflict? restart launcher and try again? ");
    setdevdvar("LAUNCHER_PRINT_FAIL", "0");
    level.fileprint_launcher = undefined;
    return false;
  }

  setdevdvar("LAUNCHER_PRINT_FAIL", "0");
  setdevdvar("LAUNCHER_PRINT_SUCCESS", "0");

  level.fileprint_launcher = undefined;
  return true;
}

launcher_write_clipboard(str) {
  level.fileprintlauncher_linecount = 0;
  fileprint_launcher("LAUNCHER_CLIP:" + str);
}

isDestructible() {
  if(!isdefined(self))
    return false;
  return isdefined(self.destructible_type);
}

pauseEffect() {
  common_scripts\_createfx::stop_fx_looper();
}

activate_individual_exploder() {
  if(IsDefined(self.v["firefx"]))
    self thread fire_effect();

  if(IsDefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
    self thread cannon_effect();
  else
  if(IsDefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
    self thread sound_effect();

  if(IsDefined(self.v["loopsound"]) && self.v["loopsound"] != "nil")
    self thread effect_loopsound();

  if(IsDefined(self.v["damage"]))
    self thread exploder_damage();

  if(IsDefined(self.v["earthquake"]))
    self thread exploder_earthquake();

  if(IsDefined(self.v["rumble"]))
    self thread exploder_rumble();

  if(self.v["exploder_type"] == "exploder")
    self thread brush_show();
  else
  if((self.v["exploder_type"] == "exploderchunk") || (self.v["exploder_type"] == "exploderchunk visible"))
    self thread brush_throw();
  else
    self thread brush_delete();
}

waitframe() {
  wait(0.05);
}

brush_delete() {
  // 		if( ent.v[ "exploder_type" ] != "normal" && !isdefined( ent.v[ "fxid" ] ) && !isdefined( ent.v[ "soundalias" ] ) )
  // 		if( !isdefined( ent.script_fxid ) )

  num = self.v["exploder"];
  if(IsDefined(self.v["delay"]))
    wait(self.v["delay"]);
  else
    wait(.05); // so it disappears after the replacement appears

  if(!isdefined(self.model)) {
    return;
  }
  Assert(IsDefined(self.model));

  if(isSP() && (self.model.spawnflags & 1))
    self.model call[[level.connectPathsFunction]]();

  if(level.createFX_enabled) {
    if(IsDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    self.model Hide();
    self.model NotSolid();

    wait(3);
    self.exploded = undefined;
    self.model Show();
    self.model Solid();
    return;
  }

  if(!isdefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
    self.v["exploder"] = undefined;

  waittillframeend; // so it hides stuff after it shows the new stuff
  self.model Delete();
}

brush_throw() {
  if(IsDefined(self.v["delay"]))
    wait(self.v["delay"]);

  ent = undefined;
  if(IsDefined(self.v["target"]))
    ent = get_target_ent(self.v["target"]);

  if(!isdefined(ent)) {
    self.model Delete();
    return;
  }

  self.model Show();

  if(IsDefined(self.v["delay_post"]))
    wait(self.v["delay_post"]);

  startorg = self.v["origin"];
  startang = self.v["angles"];
  org = ent.origin;

  temp_vec = (org - self.v["origin"]);
  x = temp_vec[0];
  y = temp_vec[1];
  z = temp_vec[2];

  physics = IsDefined(self.v["physics"]);
  if(physics) {
    target = undefined;
    if(IsDefined(ent.target))
      target = ent get_target_ent();

    if(!isdefined(target)) {
      contact_point = startorg; // no spin just push it.
      throw_vec = ent.origin;
    } else {
      contact_point = ent.origin;
      throw_vec = vector_multiply(target.origin - ent.origin, self.v["physics"]);

    }

    // 		model = Spawn( "script_model", startorg );
    // 		model.angles = startang;
    // 		model PhysicsLaunchClient( model.origin, temp_vec );
    self.model PhysicsLaunchClient(contact_point, throw_vec);
    return;
  } else {
    self.model RotateVelocity((x, y, z), 12);
    self.model MoveGravity((x, y, z), 12);
  }

  if(level.createFX_enabled) {
    if(IsDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    wait(3);
    self.exploded = undefined;
    self.v["origin"] = startorg;
    self.v["angles"] = startang;
    self.model Hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait(6);
  self.model Delete();
  // 	self Delete();
}

get_target_ent(target) {
  if(!isdefined(target))
    target = self.target;

  AssertEx(IsDefined(target), "Self had no target!");

  ent = GetEnt(target, "targetname");
  if(IsDefined(ent))
    return ent;

  if(isSP()) {
    ent = call[[level.getNodeFunction]](target, "targetname");
    if(IsDefined(ent))
      return ent;
  }

  ent = getstruct(target, "targetname");
  if(IsDefined(ent))
    return ent;

  ent = GetVehicleNode(target, "targetname");
  if(IsDefined(ent))
    return ent;

  AssertEx("Tried to get ent, but there was no ent.");
}

brush_show() {
  if(IsDefined(self.v["delay"]))
    wait(self.v["delay"]);

  Assert(IsDefined(self.model));

  self.model Show();
  self.model Solid();

  self.brush_shown = true; // used for hiding an exploder.

  if(isSP() && (self.model.spawnflags & 1)) {
    if(!isdefined(self.model.disconnect_paths))
      self.model call[[level.connectPathsFunction]]();
    else
      self.model call[[level.disconnectPathsFunction]]();
  }

  if(level.createFX_enabled) {
    if(IsDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    wait(3);
    self.exploded = undefined;
    self.model Hide();
    self.model NotSolid();
  }
}

exploder_earthquake() {
  self exploder_delay();
  eq = level.earthquake[self.v["earthquake"]];
  Earthquake(eq["magnitude"], eq["duration"], self.v["origin"], eq["radius"]);
}

exploder_rumble() {
  if(!isSP()) {
    return;
  }
  self exploder_delay();
  level.player PlayRumbleOnEntity(self.v["rumble"]);
}

exploder_delay() {
  if(!isdefined(self.v["delay"]))
    self.v["delay"] = 0;

  min_delay = self.v["delay"];
  max_delay = self.v["delay"] + 0.001; // cant randomfloatrange on the same #
  if(IsDefined(self.v["delay_min"]))
    min_delay = self.v["delay_min"];

  if(IsDefined(self.v["delay_max"]))
    max_delay = self.v["delay_max"];

  if(min_delay > 0)
    wait(RandomFloatRange(min_delay, max_delay));
}

exploder_damage() {
  if(IsDefined(self.v["delay"]))
    delay = self.v["delay"];
  else
    delay = 0;

  if(IsDefined(self.v["damage_radius"]))
    radius = self.v["damage_radius"];
  else
    radius = 128;

  damage = self.v["damage"];
  origin = self.v["origin"];

  wait(delay);
  // Range, max damage, min damage
  RadiusDamage(origin, radius, damage, damage);
}

effect_loopsound() {
  if(IsDefined(self.loopsound_ent)) {
    self.loopsound_ent Delete();
  }
  // save off this info in case we delete the effect
  origin = self.v["origin"];
  alias = self.v["loopsound"];
  self exploder_delay();

  self.loopsound_ent = play_loopsound_in_space(alias, origin);
}

play_loopsound_in_space(alias, origin) {
  org = Spawn("script_origin", (0, 0, 0));
  if(!isdefined(origin))
    origin = self.origin;

  org.origin = origin;

  org PlayLoopSound(alias, "sounddone");
  return org;
}

sound_effect() {
  self effect_soundalias();
}

effect_soundalias() {
  // save off this info in case we delete the effect
  origin = self.v["origin"];
  alias = self.v["soundalias"];
  self exploder_delay();
  play_sound_in_space(alias, origin);
}

play_sound_in_space(alias, origin, master) {
  org = Spawn("script_origin", (0, 0, 1));
  if(!isdefined(origin))
    origin = self.origin;
  org.origin = origin;
  if(isSP()) {
    if(IsDefined(master) && master)
      org PlaySoundAsMaster(alias, "sounddone");
    else
      org PlaySound(alias, "sounddone");
  } else {
    if(IsDefined(master) && master)
      org PlaySoundAsMaster(alias);
    else
      org PlaySound(alias);
  }
  org waittill("sounddone");
  org Delete();
}

cannon_effect() {
  if(IsDefined(self.v["repeat"])) {
    thread exploder_playSound();
    for (i = 0; i < self.v["repeat"]; i++) {
      PlayFX(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      self exploder_delay();
    }
    return;
  }
  self exploder_delay();

  //	PlayFX( level._effect[ self.v[ "fxid" ] ], self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
  if(IsDefined(self.looper))
    self.looper Delete();

  self.looper = SpawnFx(getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  TriggerFX(self.looper);
  exploder_playSound();
}

exploder_playSound() {
  if(!isdefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect() {
  forward = self.v["forward"];
  up = self.v["up"];

  org = undefined;

  firefxSound = self.v["firefxsound"];
  origin = self.v["origin"];
  firefx = self.v["firefx"];
  ender = self.v["ender"];
  if(!isdefined(ender))
    ender = "createfx_effectStopper";
  timeout = self.v["firefxtimeout"];

  fireFxDelay = 0.5;
  if(IsDefined(self.v["firefxdelay"]))
    fireFxDelay = self.v["firefxdelay"];

  self exploder_delay();

  if(IsDefined(firefxSound))
    level thread loop_fx_sound(firefxSound, origin, ender, timeout);

  PlayFX(level._effect[firefx], self.v["origin"], forward, up);

  // 	loopfx( 				fxId, 	fxPos, 	waittime, 	fxPos2, 	fxStart, 	fxStop, 	timeout )
  // 	maps\_fx::loopfx( 	firefx, 	origin, 	delay, 		org, 	undefined, 	ender, 	timeout );
}

loop_fx_sound(alias, origin, ender, timeout) {
  org = Spawn("script_origin", (0, 0, 0));
  if(IsDefined(ender)) {
    thread loop_sound_delete(ender, org);
    self endon(ender);
  }
  org.origin = origin;
  org PlayLoopSound(alias);
  if(!isdefined(timeout)) {
    org willNeverChange();
    return;
  }

  wait(timeout);
  // 	org Delete();
}

loop_sound_delete(ender, ent) {
  ent endon("death");
  self waittill(ender);
  ent Delete();
}

exploder_before_load(num) {
  // gotta wait twice because the createfx_init function waits once then inits all exploders. This guarentees
  // that if an exploder is run on the first frame, it happens after the fx are init.
  waittillframeend;
  waittillframeend;
  activate_exploder(num);
}

exploder_after_load(num) {
  activate_exploder(num);
}

activate_exploder(num) {
  num += "";

  prof_begin("activate_exploder");

  //here's a hook so you can know when a certain number of an exploder is going off
  level notify("exploding_" + num);

  for (i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(!isdefined(ent)) {
      continue;
    }
    if(ent.v["type"] != "exploder") {
      continue;
    }
    // make the exploder actually removed the array instead?
    if(!isdefined(ent.v["exploder"])) {
      continue;
    }
    if(ent.v["exploder"] + "" != num) {
      continue;
    }
    ent activate_individual_exploder();
  }
  prof_end("activate_exploder");
}

createLoopEffect(fxid) {
  ent = common_scripts\_createfx::createEffect("loopfx", fxid);
  ent.v["delay"] = 0.5;
  return ent;
}

createOneshotEffect(fxid) {
  // uses triggerfx
  ent = common_scripts\_createfx::createEffect("oneshotfx", fxid);
  ent.v["delay"] = -15;
  return ent;
}

createExploder(fxid) {
  ent = common_scripts\_createfx::createEffect("exploder", fxid);
  ent.v["delay"] = 0;
  ent.v["exploder_type"] = "normal";
  return ent;
}

alphabetize(array) {
  if(array.size <= 1)
    return array;

  addwaits = false;
  if(isSP())
    addwaits = true;

  count = 0;
  for (;;) {
    changed = false;
    for (i = 0; i < array.size - 1; i++) {
      if(is_later_in_alphabet(array[i], array[i + 1])) {
        val = array[i];
        array[i] = array[i + 1];
        array[i + 1] = val;
        changed = true;

        if(addwaits) {
          count++;
          if(count >= 10) {
            count = 0;
            waitframe();
          }
        }
      }
    }

    if(!changed)
      return array;
  }

  return array;
}

is_later_in_alphabet(string1, string2) {
  count = string1.size;
  if(count >= string2.size)
    count = string2.size;

  for (i = 0; i < count; i++) {
    val = alphabet_compare(string1[i], string2[i]);
    if(val == "1st")
      return true;
    if(val == "2nd")
      return false;
  }

  return string1.size > string2.size;
}

alphabet_compare(a, b) {
  list = [];
  val = 1;
  list["0"] = val;
  val++;
  list["1"] = val;
  val++;
  list["2"] = val;
  val++;
  list["3"] = val;
  val++;
  list["4"] = val;
  val++;
  list["5"] = val;
  val++;
  list["6"] = val;
  val++;
  list["7"] = val;
  val++;
  list["8"] = val;
  val++;
  list["9"] = val;
  val++;
  list["_"] = val;
  val++;
  list["a"] = val;
  val++;
  list["b"] = val;
  val++;
  list["c"] = val;
  val++;
  list["d"] = val;
  val++;
  list["e"] = val;
  val++;
  list["f"] = val;
  val++;
  list["g"] = val;
  val++;
  list["h"] = val;
  val++;
  list["i"] = val;
  val++;
  list["j"] = val;
  val++;
  list["k"] = val;
  val++;
  list["l"] = val;
  val++;
  list["m"] = val;
  val++;
  list["n"] = val;
  val++;
  list["o"] = val;
  val++;
  list["p"] = val;
  val++;
  list["q"] = val;
  val++;
  list["r"] = val;
  val++;
  list["s"] = val;
  val++;
  list["t"] = val;
  val++;
  list["u"] = val;
  val++;
  list["v"] = val;
  val++;
  list["w"] = val;
  val++;
  list["x"] = val;
  val++;
  list["y"] = val;
  val++;
  list["z"] = val;
  val++;

  a = ToLower(a);
  b = ToLower(b);
  val1 = 0;
  if(IsDefined(list[a]))
    val1 = list[a];

  val2 = 0;
  if(IsDefined(list[b]))
    val2 = list[b];

  if(val1 > val2)
    return "1st";
  if(val1 < val2)
    return "2nd";
  return "same";
}

play_loop_sound_on_entity(alias, offset) {
  org = Spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread delete_on_death(org);

  if(IsDefined(offset)) {
    org.origin = self.origin + offset;
    org.angles = self.angles;
    org LinkTo(self);
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org LinkTo(self);
  }

  // 	org endon( "death" );
  org PlayLoopSound(alias);
  // 	PrintLn( "playing loop sound ", alias, " on entity at origin ", self.origin, " at ORIGIN ", org.origin );

  self waittill("stop sound" + alias);
  org StopLoopSound(alias);
  org Delete();
}

stop_loop_sound_on_entity(alias) {
  self notify("stop sound" + alias);
}

delete_on_death(ent) {
  //self ==> the entity you want to wait to die before deleting the ent
  ent endon("death");
  self waittill("death");
  if(IsDefined(ent))
    ent Delete();
}

error(msg) {
  PrintLn("^c * ERROR * ", msg);
  waitframe();

  if(GetDvar("debug") != "1")
    AssertMsg("This is a forced error - attach the log file. \n" + msg);
}

exploder(num) {
  [[level.exploderFunction]](num);
}

create_dvar(var, val) {
  SetDvarIfUninitialized(var, val);
}

setPing(ping) {}

getPing() {
  return self.ping;
}

getIP() {
  return self.address;
}

void() {}