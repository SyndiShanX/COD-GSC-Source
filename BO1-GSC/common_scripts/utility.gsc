/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\utility.gsc
**************************************/

array(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z) {
  array = [];
  if(isDefined(a)) array[0] = a;
  else return array;
  if(isDefined(b)) array[1] = b;
  else return array;
  if(isDefined(c)) array[2] = c;
  else return array;
  if(isDefined(d)) array[3] = d;
  else return array;
  if(isDefined(e)) array[4] = e;
  else return array;
  if(isDefined(f)) array[5] = f;
  else return array;
  if(isDefined(g)) array[6] = g;
  else return array;
  if(isDefined(h)) array[7] = h;
  else return array;
  if(isDefined(i)) array[8] = i;
  else return array;
  if(isDefined(j)) array[9] = j;
  else return array;
  if(isDefined(k)) array[10] = k;
  else return array;
  if(isDefined(l)) array[11] = l;
  else return array;
  if(isDefined(m)) array[12] = m;
  else return array;
  if(isDefined(n)) array[13] = n;
  else return array;
  if(isDefined(o)) array[14] = o;
  else return array;
  if(isDefined(p)) array[15] = p;
  else return array;
  if(isDefined(q)) array[16] = q;
  else return array;
  if(isDefined(r)) array[17] = r;
  else return array;
  if(isDefined(s)) array[18] = s;
  else return array;
  if(isDefined(t)) array[19] = t;
  else return array;
  if(isDefined(u)) array[20] = u;
  else return array;
  if(isDefined(v)) array[21] = v;
  else return array;
  if(isDefined(w)) array[22] = w;
  else return array;
  if(isDefined(x)) array[23] = x;
  else return array;
  if(isDefined(y)) array[24] = y;
  else return array;
  if(isDefined(z)) array[25] = z;
  return array;
}

add_to_array(array, item, allow_dupes) {
  if(!isDefined(item)) {
    return array;
  }
  if(!isDefined(allow_dupes)) {
    allow_dupes = true;
  }
  if(!isDefined(array)) {
    array[0] = item;
  } else if(allow_dupes || !is_in_array(array, item)) {
    array[array.size] = item;
  }
  return array;
}

array_add(array, item) {
  array[array.size] = item;
  return array;
}

array_delete(array) {
  for(i = 0; i < array.size; i++) {
    if(isDefined(array[i])) {
      array[i] delete();
    }
  }
}

array_randomize(array) {
  for(i = 0; i < array.size; i++) {
    j = randomInt(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
}

array_reverse(array) {
  array2 = [];
  for(i = array.size - 1; i >= 0; i--) {
    array2[array2.size] = array[i];
  }
  return array2;
}

array_removeUndefined(array) {
  newArray = [];
  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i])) {
      continue;
    }
    newArray[newArray.size] = array[i];
  }
  return newArray;
}

array_insert(array, object, index) {
  if(index == array.size) {
    temp = array;
    temp[temp.size] = object;
    return temp;
  }
  temp = [];
  offset = 0;
  for(i = 0; i < array.size; i++) {
    if(i == index) {
      temp[i] = object;
      offset = 1;
    }
    temp[i + offset] = array[i];
  }
  return temp;
}

array_remove(ents, remover, keepArrayKeys) {
  newents = [];
  keys = getArrayKeys(ents);
  if(isDefined(keepArrayKeys)) {
    for(i = keys.size - 1; i >= 0; i--) {
      if(ents[keys[i]] != remover) {
        newents[keys[i]] = ents[keys[i]];
      }
    }
    return newents;
  }
  for(i = keys.size - 1; i >= 0; i--) {
    if(ents[keys[i]] != remover) {
      newents[newents.size] = ents[keys[i]];
    }
  }
  return newents;
}

array_remove_nokeys(ents, remover) {
  newents = [];
  for(i = 0; i < ents.size; i++) {
    if(ents[i] != remover) {
      newents[newents.size] = ents[i];
    }
  }
  return newents;
}

array_remove_index(array, index) {
  newArray = [];
  keys = getArrayKeys(array);
  for(i = (keys.size - 1); i >= 0; i--) {
    if(keys[i] != index) {
      newArray[newArray.size] = array[keys[i]];
    }
  }
  return newArray;
}

array_combine(array1, array2) {
  if(!array1.size) {
    return array2;
  }
  array3 = [];
  keys = GetArrayKeys(array1);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    array3[array3.size] = array1[key];
  }
  keys = GetArrayKeys(array2);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    array3[array3.size] = array2[key];
  }
  return array3;
}

array_merge(array1, array2) {
  if(array1.size == 0) {
    return array2;
  }
  if(array2.size == 0) {
    return array1;
  }
  newarray = array1;
  for(i = 0; i < array2.size; i++) {
    foundmatch = false;
    for(j = 0; j < array1.size; j++) {
      if(array2[i] == array1[j]) {
        foundmatch = true;
        break;
      }
    }
    if(foundmatch) {
      continue;
    } else {
      newarray[newarray.size] = array2[i];
    }
  }
  return newarray;
}

array_exclude(array, arrayExclude) {
  newarray = array;
  if(IsArray(arrayExclude)) {
    for(i = 0; i < arrayExclude.size; i++) {
      if(is_in_array(array, arrayExclude[i])) {
        newarray = array_remove(newarray, arrayExclude[i]);
      }
    }
  } else {
    if(is_in_array(array, arrayExclude)) {
      newarray = array_remove(newarray, arrayExclude);
    }
  }
  return newarray;
}

array_notify(ents, notifier) {
  for(i = 0; i < ents.size; i++) {
    ents[i] notify(notifier);
  }
}

array_wait(array, msg, timeout) {
  keys = getarraykeys(array);
  structs = [];
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    structs[key] = spawnStruct();
    structs[key]._array_wait = true;
    structs[key] thread array_waitlogic1(array[key], msg, timeout);
  }
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    if(isDefined(array[key]) && structs[key]._array_wait) {
      structs[key] waittill("_array_wait");
    }
  }
}

array_wait_any(array, msg, timeout) {
  if(array.size == 0) {
    return undefined;
  }
  keys = getarraykeys(array);
  structs = [];
  internal_msg = msg + "array_wait";
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    structs[key] = spawnStruct();
    structs[key]._array_wait = true;
    structs[key] thread array_waitlogic3(array[key], msg, internal_msg, timeout);
  }
  level waittill(internal_msg, ent);
  return ent;
}

array_waitlogic1(ent, msg, timeout) {
  self array_waitlogic2(ent, msg, timeout);
  self._array_wait = false;
  self notify("_array_wait");
}

array_waitlogic2(ent, msg, timeout) {
  ent endon(msg);
  ent endon("death");
  if(isDefined(timeout)) {
    wait timeout;
  } else {
    ent waittill(msg);
  }
}

array_waitlogic3(ent, msg, internal_msg, timeout) {
  if(msg != "death") {
    ent endon("death");
  }
  level endon(internal_msg);
  self array_waitlogic2(ent, msg, timeout);
  level notify(internal_msg, ent);
}

array_check_for_dupes(array, single) {
  for(i = 0; i < array.size; i++) {
    if(array[i] == single) {
      return false;
    }
  }
  return true;
}

array_swap(array, index1, index2) {
  assertEx(index1 < array.size, "index1 to swap out of range");
  assertEx(index2 < array.size, "index2 to swap out of range");
  temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
  return array;
}

array_average(array) {
  assert(IsArray(array));
  assert(array.size > 0);
  total = 0;
  for(i = 0; i < array.size; i++) {
    total += array[i];
  }
  return (total / array.size);
}

array_std_deviation(array, mean) {
  assert(IsArray(array));
  assert(array.size > 0);
  tmp = [];
  for(i = 0; i < array.size; i++) {
    tmp[i] = (array[i] - mean) * (array[i] - mean);
  }
  total = 0;
  for(i = 0; i < tmp.size; i++) {
    total = total + tmp[i];
  }
  return Sqrt(total / array.size);
}

random_normal_distribution(mean, std_deviation, lower_bound, upper_bound) {
  x1 = 0;
  x2 = 0;
  w = 1;
  y1 = 0;
  while(w >= 1) {
    x1 = 2 * RandomFloatRange(0, 1) - 1;
    x2 = 2 * RandomFloatRange(0, 1) - 1;
    w = x1 * x1 + x2 * x2;
  }
  w = Sqrt((-2.0 * Log(w)) / w);
  y1 = x1 * w;
  number = mean + y1 * std_deviation;
  if(isDefined(lower_bound) && number < lower_bound) {
    number = lower_bound;
  }
  if(isDefined(upper_bound) && number > upper_bound) {
    number = upper_bound;
  }
  return (number);
}

random(array) {
  keys = GetArrayKeys(array);
  return array[keys[randomInt(keys.size)]];
}

is_in_array(aeCollection, eFindee) {
  for(i = 0; i < aeCollection.size; i++) {
    if(aeCollection[i] == eFindee) {
      return (true);
    }
  }
  return (false);
}

vector_compare(vec1, vec2) {
  return (abs(vec1[0] - vec2[0]) < .001) && (abs(vec1[1] - vec2[1]) < .001) && (abs(vec1[2] - vec2[2]) < .001);
}

vector_scale(vec, scale) {
  vec = (vec * scale);
  return vec;
}

vector_multiply(vec, vec2) {
  vec = (vec * vec2);
  return vec;
}

draw_debug_line(start, end, timer) {
  for(i = 0; i < timer * 20; i++) {
    line(start, end, (1, 1, 0.5));
    wait(0.05);
  }
}

waittillend(msg) {
  self waittillmatch(msg, "end");
}

randomvector(num) {
  return (RandomFloat(num) - num * 0.5, RandomFloat(num) - num * 0.5, RandomFloat(num) - num * 0.5);
}

angle_dif(oldangle, newangle) {
  if(oldangle == newangle)
    return 0;
  while(newangle > 360)
    newangle -= 360;
  while(newangle < 0)
    newangle += 360;
  while(oldangle > 360)
    oldangle -= 360;
  while(oldangle < 0)
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
  if(isDefined(self.current_target)) {
    if(spot_to_track == self.current_target)
      return;
  }
  self.current_target = spot_to_track;
}

clear_exception(type) {
  assert(isDefined(self.exception[type]));
  self.exception[type] = anim.defaultException;
}

set_exception(type, func) {
  assert(isDefined(self.exception[type]));
  self.exception[type] = func;
}

set_all_exceptions(exceptionFunc) {
  keys = getArrayKeys(self.exception);
  for(i = 0; i < keys.size; i++) {
    self.exception[keys[i]] = exceptionFunc;
  }
}

cointoss() {
  return randomInt(100) >= 50;
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
  ent = spawnStruct();
  ent.threads = 0;
  if(isDefined(string1)) {
    self thread waittill_string(string1, ent);
    ent.threads++;
  }
  if(isDefined(string2)) {
    self thread waittill_string(string2, ent);
    ent.threads++;
  }
  if(isDefined(string3)) {
    self thread waittill_string(string3, ent);
    ent.threads++;
  }
  if(isDefined(string4)) {
    self thread waittill_string(string4, ent);
    ent.threads++;
  }
  if(isDefined(string5)) {
    self thread waittill_string(string5, ent);
    ent.threads++;
  }
  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }
  ent notify("die");
}

waittill_multiple_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4) {
  self endon("death");
  ent = spawnStruct();
  ent.threads = 0;
  if(isDefined(ent1)) {
    assert(isDefined(string1));
    ent1 thread waittill_string(string1, ent);
    ent.threads++;
  }
  if(isDefined(ent2)) {
    assert(isDefined(string2));
    ent2 thread waittill_string(string2, ent);
    ent.threads++;
  }
  if(isDefined(ent3)) {
    assert(isDefined(string3));
    ent3 thread waittill_string(string3, ent);
    ent.threads++;
  }
  if(isDefined(ent4)) {
    assert(isDefined(string4));
    ent4 thread waittill_string(string4, ent);
    ent.threads++;
  }
  while(ent.threads) {
    ent waittill("returned");
    ent.threads--;
  }
  ent notify("die");
}

waittill_any_return(string1, string2, string3, string4, string5, string6) {
  if((!isDefined(string1) || string1 != "death") &&
    (!isDefined(string2) || string2 != "death") &&
    (!isDefined(string3) || string3 != "death") &&
    (!isDefined(string4) || string4 != "death") &&
    (!isDefined(string5) || string5 != "death") &&
    (!isDefined(string6) || string6 != "death"))
    self endon("death");
  ent = spawnStruct();
  if(isDefined(string1))
    self thread waittill_string(string1, ent);
  if(isDefined(string2))
    self thread waittill_string(string2, ent);
  if(isDefined(string3))
    self thread waittill_string(string3, ent);
  if(isDefined(string4))
    self thread waittill_string(string4, ent);
  if(isDefined(string5))
    self thread waittill_string(string5, ent);
  if(isDefined(string6))
    self thread waittill_string(string6, ent);
  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

waittill_any(string1, string2, string3, string4, string5) {
  assert(isDefined(string1));
  if(isDefined(string2))
    self endon(string2);
  if(isDefined(string3))
    self endon(string3);
  if(isDefined(string4))
    self endon(string4);
  if(isDefined(string5))
    self endon(string5);
  self waittill(string1);
}

waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));
  if((isDefined(ent2)) && (isDefined(string2)))
    ent2 endon(string2);
  if((isDefined(ent3)) && (isDefined(string3)))
    ent3 endon(string3);
  if((isDefined(ent4)) && (isDefined(string4)))
    ent4 endon(string4);
  if((isDefined(ent5)) && (isDefined(string5)))
    ent5 endon(string5);
  if((isDefined(ent6)) && (isDefined(string6)))
    ent6 endon(string6);
  if((isDefined(ent7)) && (isDefined(string7)))
    ent7 endon(string7);
  ent1 waittill(string1);
}

isFlashed() {
  if(!isDefined(self.flashEndTime))
    return false;
  return GetTime() < self.flashEndTime;
}

flag(message) {
  assertEx(isDefined(message), "Tried to check flag but the flag was not defined.");
  assertEx(isDefined(level.flag[message]), "Tried to check flag " + message + " but the flag was not initialized.");
  if(!level.flag[message])
    return false;
  return true;
}

flag_init(message, val) {
  if(!isDefined(level.flag)) {
    level.flag = [];
    level.flags_lock = [];
  }
  if(!isDefined(level.sp_stat_tracking_func)) {
    level.sp_stat_tracking_func = ::empty_init_func;
  }
  if(!isDefined(level.first_frame)) {
    assertEx(!isDefined(level.flag[message]), "Attempt to reinitialize existing flag: " + message);
  }
  if(is_true(val)) {
    level.flag[message] = true;
  } else {
    level.flag[message] = false;
  }
  if(!isDefined(level.trigger_flags)) {
    init_trigger_flags();
    level.trigger_flags[message] = [];
  } else if(!isDefined(level.trigger_flags[message])) {
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
  for(i = 0; i < suffix.size; i++) {
    if(msg[i] != suffix[i])
      return false;
  }
  return true;
}

flag_set(message) {
  level.flag[message] = true;
  level notify(message);
  set_trigger_flag_permissions(message);
}

flag_toggle(message) {
  if(flag(message)) {
    flag_clear(message);
  } else {
    flag_set(message);
  }
}

flag_wait(msg) {
  while(!level.flag[msg])
    level waittill(msg);
}

flag_clear(message) {
  if(level.flag[message]) {
    level.flag[message] = false;
    level notify(message);
    set_trigger_flag_permissions(message);
  }
}

flag_waitopen(msg) {
  while(level.flag[msg])
    level waittill(msg);
}

flag_exists(msg) {
  if(self == level) {
    if(!isDefined(level.flag))
      return false;
    if(isDefined(level.flag[msg]))
      return true;
  } else {
    if(!isDefined(self.ent_flag))
      return false;
    if(isDefined(self.ent_flag[msg]))
      return true;
  }
  return false;
}

script_gen_dump_addline(string, signature) {
  if(!isDefined(string))
    string = "nowrite";
  if(!isDefined(level._loadstarted)) {
    if(!isDefined(level.script_gen_dump_preload))
      level.script_gen_dump_preload = [];
    struct = spawnStruct();
    struct.string = string;
    struct.signature = signature;
    level.script_gen_dump_preload[level.script_gen_dump_preload.size] = struct;
    return;
  }
  if(!isDefined(level.script_gen_dump[signature]))
    level.script_gen_dump_reasons[level.script_gen_dump_reasons.size] = "Added: " + string;
  level.script_gen_dump[signature] = string;
  level.script_gen_dump2[signature] = string;
}

array_func(entities, func, arg1, arg2, arg3, arg4, arg5) {
  if(!isDefined(entities)) {
    return;
  }
  if(IsArray(entities)) {
    if(entities.size) {
      keys = GetArrayKeys(entities);
      for(i = 0; i < keys.size; i++) {
        single_func(entities[keys[i]], func, arg1, arg2, arg3, arg4, arg5);
      }
    }
  } else {
    single_func(entities, func, arg1, arg2, arg3, arg4, arg5);
  }
}

single_func(entity, func, arg1, arg2, arg3, arg4, arg5) {
  if(!isDefined(entity)) {
    entity = level;
  }
  if(isDefined(arg5)) {
    entity[[func]](arg1, arg2, arg3, arg4, arg5);
  } else if(isDefined(arg4)) {
    entity[[func]](arg1, arg2, arg3, arg4);
  } else if(isDefined(arg3)) {
    entity[[func]](arg1, arg2, arg3);
  } else if(isDefined(arg2)) {
    entity[[func]](arg1, arg2);
  } else if(isDefined(arg1)) {
    entity[[func]](arg1);
  } else {
    entity[[func]]();
  }
}

array_thread(entities, func, arg1, arg2, arg3, arg4, arg5) {
  AssertEX(isDefined(entities), "Undefined array passed to common_scripts\utility::array_thread()");
  if(IsArray(entities)) {
    if(entities.size) {
      keys = GetArrayKeys(entities);
      for(i = 0; i < keys.size; i++) {
        single_thread(entities[keys[i]], func, arg1, arg2, arg3, arg4, arg5);
      }
    }
  } else {
    single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
  }
}

single_thread(entity, func, arg1, arg2, arg3, arg4, arg5) {
  AssertEX(isDefined(entity), "Undefined entity passed to common_scripts\utility::single_thread()");
  if(isDefined(arg5)) {
    entity thread[[func]](arg1, arg2, arg3, arg4, arg5);
  } else if(isDefined(arg4)) {
    entity thread[[func]](arg1, arg2, arg3, arg4);
  } else if(isDefined(arg3)) {
    entity thread[[func]](arg1, arg2, arg3);
  } else if(isDefined(arg2)) {
    entity thread[[func]](arg1, arg2);
  } else if(isDefined(arg1)) {
    entity thread[[func]](arg1);
  } else {
    entity thread[[func]]();
  }
}

remove_undefined_from_array(array) {
  newarray = [];
  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i]))
      continue;
    newarray[newarray.size] = array[i];
  }
  return newarray;
}

realWait(seconds) {
  start = GetTime();
  while(GetTime() - start < seconds * 1000) {
    wait(.05);
  }
}

trigger_on(name, type) {
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
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
  if(isDefined(name) && isDefined(type)) {
    ents = getEntArray(name, type);
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

trigger_wait(strName, strKey) {
  if(!isDefined(strKey)) {
    strKey = "targetname";
  }
  triggers = getEntArray(strName, strKey);
  AssertEX(isDefined(triggers) && triggers.size > 0, "trigger not found: " + strName + " key: " + strKey);
  ent = spawnStruct();
  array_thread(triggers, ::trigger_wait_think, ent);
  ent waittill("trigger", eOther, trigger_hit);
  level notify(strName, eOther);
  if(isDefined(trigger_hit)) {
    trigger_hit.who = eother;
    return trigger_hit;
  } else {
    return eOther;
  }
}

trigger_wait_think(ent) {
  self endon("death");
  ent endon("trigger");
  self waittill("trigger", eother);
  ent notify("trigger", eother, self);
}

set_trigger_flag_permissions(msg) {
  if(!isDefined(level.trigger_flags))
    return;
  level.trigger_flags[msg] = remove_undefined_from_array(level.trigger_flags[msg]);
  array_thread(level.trigger_flags[msg], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags() {
  true_on = true;
  if(isDefined(self.script_flag_true)) {
    true_on = false;
    tokens = create_flags_and_return_tokens(self.script_flag_true);
    for(i = 0; i < tokens.size; i++) {
      if(flag(tokens[i])) {
        true_on = true;
        break;
      }
    }
  }
  false_on = true;
  if(isDefined(self.script_flag_false)) {
    tokens = create_flags_and_return_tokens(self.script_flag_false);
    for(i = 0; i < tokens.size; i++) {
      if(flag(tokens[i])) {
        false_on = false;
        break;
      }
    }
  }
  [[level.trigger_func[true_on && false_on]]]();
}

create_flags_and_return_tokens(flags) {
  tokens = strtok(flags, " ");
  for(i = 0; i < tokens.size; i++) {
    if(!isDefined(level.flag[tokens[i]])) {
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
  assertEx(isDefined(level.struct_class_names), "Tried to getstruct before the structs were init");
  if(!isDefined(type)) {
    type = "targetname";
  }
  array = level.struct_class_names[type][name];
  if(!isDefined(array)) {
    return undefined;
  }
  if(array.size > 1) {
    assertMsg("getstruct used for more than one struct of type " + type + " called " + name + ".");
    return undefined;
  }
  return array[0];
}

getstructarray(name, type) {
  assertEx(isDefined(level.struct_class_names), "Tried to getstruct before the structs were init");
  if(!isDefined(type)) {
    type = "targetname";
  }
  array = level.struct_class_names[type][name];
  if(!isDefined(array))
    return [];
  return array;
}

struct_class_init() {
  assertEx(!isDefined(level.struct_class_names), "level.struct_class_names is being initialized in the wrong place! It shouldn't be initialized yet.");
  level.struct_class_names = [];
  level.struct_class_names["target"] = [];
  level.struct_class_names["targetname"] = [];
  level.struct_class_names["script_noteworthy"] = [];
  level.struct_class_names["script_linkname"] = [];
  for(i = 0; i < level.struct.size; i++) {
    if(isDefined(level.struct[i].targetname)) {
      if(!isDefined(level.struct_class_names["targetname"][level.struct[i].targetname]))
        level.struct_class_names["targetname"][level.struct[i].targetname] = [];
      size = level.struct_class_names["targetname"][level.struct[i].targetname].size;
      level.struct_class_names["targetname"][level.struct[i].targetname][size] = level.struct[i];
    }
    if(isDefined(level.struct[i].target)) {
      if(!isDefined(level.struct_class_names["target"][level.struct[i].target]))
        level.struct_class_names["target"][level.struct[i].target] = [];
      size = level.struct_class_names["target"][level.struct[i].target].size;
      level.struct_class_names["target"][level.struct[i].target][size] = level.struct[i];
    }
    if(isDefined(level.struct[i].script_noteworthy)) {
      if(!isDefined(level.struct_class_names["script_noteworthy"][level.struct[i].script_noteworthy]))
        level.struct_class_names["script_noteworthy"][level.struct[i].script_noteworthy] = [];
      size = level.struct_class_names["script_noteworthy"][level.struct[i].script_noteworthy].size;
      level.struct_class_names["script_noteworthy"][level.struct[i].script_noteworthy][size] = level.struct[i];
    }
    if(isDefined(level.struct[i].script_linkname)) {
      assertex(!isDefined(level.struct_class_names["script_linkname"][level.struct[i].script_linkname]), "Two structs have the same linkname");
      level.struct_class_names["script_linkname"][level.struct[i].script_linkname][0] = level.struct[i];
    }
  }
  for(i = 0; i < level.struct.size; i++) {
    if(!isDefined(level.struct[i].target)) {
      continue;
    }
    level.struct[i].targeted = level.struct_class_names["targetname"][level.struct[i].target];
  }
}

fileprint_start(file) {}
fileprint_map_start(file) {}
fileprint_chk(file, str) {}
fileprint_map_header(bInclude_blank_worldspawn) {
  if(!isDefined(bInclude_blank_worldspawn))
    bInclude_blank_worldspawn = false;
  assert(isDefined(level.fileprint));
}

fileprint_map_keypairprint(key1, key2) {}
fileprint_map_entity_start() {}
fileprint_map_entity_end() {}
fileprint_end() {}
fileprint_radiant_vec(vector) {}
is_mature() {
  if(level.onlineGame)
    return true;
  return GetDvarInt(#"cg_mature");
}

is_german_build() {
  if(getDvar(#"language") == "german") {
    return true;
  }
  return false;
}

is_gib_restricted_build() {
  if(getDvar(#"language") == "german") {
    return true;
  }
  if(getDvar(#"language") == "japanese") {
    return true;
  }
  return false;
}

is_true(check) {
  return (isDefined(check) && check);
}

is_false(check) {
  return (isDefined(check) && !check);
}

has_spawnflag(spawnflags) {
  if(isDefined(self.spawnflags)) {
    return ((self.spawnflags & spawnflags) == spawnflags);
  }
  return false;
}

clamp(val, val_min, val_max) {
  if(val < val_min) {
    val = val_min;
  } else if(val > val_max) {
    val = val_max;
  }
  return val;
}

linear_map(num, min_a, max_a, min_b, max_b) {
  return clamp(((num - min_a) / (max_a - min_a) * (max_b - min_b) + min_b), min_b, max_b);
}

death_notify_wrapper(attacker, damageType) {
  level notify("face", "death", self);
  self notify("death", attacker, damageType);
}

damage_notify_wrapper(damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags) {
  level notify("face", "damage", self);
  self notify("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags);
}

explode_notify_wrapper() {
  level notify("face", "explode", self);
  self notify("explode");
}

alert_notify_wrapper() {
  level notify("face", "alert", self);
  self notify("alert");
}

shoot_notify_wrapper() {
  level notify("face", "shoot", self);
  self notify("shoot");
}

melee_notify_wrapper() {
  level notify("face", "melee", self);
  self notify("melee");
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