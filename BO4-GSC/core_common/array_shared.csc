/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\array_shared.csc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace array;

filter(&array, b_keep_keys, func_filter, ...) {
  a_new = [];

  foreach(key, val in array) {
    a_args = arraycombine(array(val), vararg, 1, 0);

    if(util::single_func_argarray(undefined, func_filter, a_args)) {
      if(isstring(key) || isweapon(key)) {
        if(isDefined(b_keep_keys) && !b_keep_keys) {
          a_new[a_new.size] = val;
        } else {
          a_new[key] = val;
        }

        continue;
      }

      if(isDefined(b_keep_keys) && b_keep_keys) {
        a_new[key] = val;
        continue;
      }

      a_new[a_new.size] = val;
    }
  }

  return a_new;
}

remove_undefined(&array, b_keep_keys) {
  return filter(array, b_keep_keys, &_filter_undefined);
}

remove_dead(&array, b_keep_keys) {
  return filter(array, b_keep_keys, &_filter_dead);
}

filter_classname(&array, b_keep_keys, str_classname) {
  return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

function_f23011ac(&array, b_keep_keys, str_classname) {
  return filter(array, b_keep_keys, &function_e01a747e, str_classname);
}

get_touching(a_ents, e_volume) {
  a_touching = undefined;

  foreach(e_ent in a_ents) {
    if(e_ent istouching(e_volume)) {
      if(!isDefined(a_touching)) {
        a_touching = [];
      } else if(!isarray(a_touching)) {
        a_touching = array(a_touching);
      }

      a_touching[a_touching.size] = e_ent;
    }
  }

  return a_touching;
}

remove_index(array, index, b_keep_keys) {
  a_new = [];

  foreach(key, val in array) {
    if(key == index) {
      continue;
    }

    if(isDefined(b_keep_keys) && b_keep_keys) {
      a_new[key] = val;
      continue;
    }

    a_new[a_new.size] = val;
  }

  return a_new;
}

delete_all(&array, is_struct) {
  foreach(ent in array) {
    if(isDefined(ent)) {
      if(isDefined(is_struct) && is_struct) {
        ent struct::delete();
        continue;
      }

      if(isDefined(ent.__vtable)) {
        ent._deleted = 1;
        ent notify(#"death");
        ent = undefined;
        continue;
      }

      ent delete();
    }
  }
}

notify_all(&array, str_notify) {
  foreach(elem in array) {
    elem notify(str_notify);
  }
}

thread_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entities), "<dev string:x38>");
  assert(isDefined(func), "<dev string:x6d>");

  if(isarray(entities)) {
    foreach(ent in entities) {
      if(!isDefined(ent)) {
        continue;
      }

      util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    return;
  }

  util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

thread_all_ents(&entities, func, arg1, arg2, arg3, arg4, arg5) {
  assert(isDefined(entities), "<dev string:x9e>");
  assert(isDefined(func), "<dev string:xd8>");

  if(isarray(entities)) {
    foreach(v in entities) {
      util::single_thread(self, func, v, arg1, arg2, arg3, arg4, arg5);
    }

    return;
  }

  util::single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
}

run_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entities), "<dev string:x10e>");
  assert(isDefined(func), "<dev string:x140>");

  if(isarray(entities)) {
    foreach(ent in entities) {
      util::single_func(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    return;
  }

  util::single_func(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

exclude(array, array_exclude) {
  newarray = array;

  if(isarray(array_exclude)) {
    foreach(exclude_item in array_exclude) {
      arrayremovevalue(newarray, exclude_item);
    }
  } else {
    arrayremovevalue(newarray, array_exclude);
  }

  return newarray;
}

add(&array, item, allow_dupes = 1) {
  if(isDefined(item)) {
    if(allow_dupes || !isinarray(array, item)) {
      array[array.size] = item;
    }
  }
}

add_sorted(&array, item, allow_dupes = 1, func_compare, var_e19f0739 = 0) {
  if(isDefined(item)) {
    if(allow_dupes || !isinarray(array, item)) {
      for(i = 0; i <= array.size; i++) {
        if(i == array.size || isDefined(func_compare) && ([
            [func_compare]
          ](item, array[i]) || var_e19f0739) || !isDefined(func_compare) && (item <= array[i] || var_e19f0739)) {
          arrayinsert(array, item, i);
          break;
        }
      }
    }
  }
}

wait_till(&array, notifies, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;

  foreach(ent in array) {
    if(isDefined(ent)) {
      ent thread util::timeout(n_timeout, &util::_waitlogic, s_tracker, notifies);
    }
  }

  if(s_tracker._wait_count > 0) {
    s_tracker waittill(#"waitlogic_finished");
  }
}

wait_till_match(&array, str_notify, str_match, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  s_tracker = spawnStruct();
  s_tracker._array_wait_count = 0;

  foreach(ent in array) {
    if(isDefined(ent)) {
      s_tracker._array_wait_count++;
      ent thread util::timeout(n_timeout, &_waitlogic_match, s_tracker, str_notify, str_match);
      ent thread util::timeout(n_timeout, &_waitlogic_death, s_tracker);
    }
  }

  if(s_tracker._array_wait_count > 0) {
    s_tracker waittill(#"array_wait");
  }
}

_waitlogic_match(s_tracker, str_notify, str_match) {
  self endon(#"death");
  self waittillmatch(str_match, str_notify);
  update_waitlogic_tracker(s_tracker);
}

_waitlogic_death(s_tracker) {
  self waittill(#"death");
  update_waitlogic_tracker(s_tracker);
}

update_waitlogic_tracker(s_tracker) {
  s_tracker._array_wait_count--;

  if(s_tracker._array_wait_count == 0) {
    s_tracker notify(#"array_wait");
  }
}

flag_wait(&array, str_flag) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];

    if(!ent flag::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

flagsys_wait(&array, str_flag) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];

    if(!ent flagsys::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

flagsys_wait_any_flag(&array, ...) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];

    if(isDefined(ent)) {
      b_flag_set = 0;

      foreach(str_flag in vararg) {
        if(ent flagsys::get(str_flag)) {
          b_flag_set = 1;
          break;
        }
      }

      if(!b_flag_set) {
        ent waittill(vararg);
        i = -1;
      }
    }
  }
}

flagsys_wait_any(&array, str_flag) {
  foreach(ent in array) {
    if(ent flagsys::get(str_flag)) {
      return ent;
    }
  }

  wait_any(array, str_flag);
}

flag_wait_clear(&array, str_flag) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];

    if(ent flag::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

flagsys_wait_clear(&array, str_flag, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  for(i = 0; i < array.size; i++) {
    ent = array[i];

    if(isDefined(ent) && ent flagsys::get(str_flag)) {
      ent util::waittill_either("death", str_flag);
      i = -1;
    }
  }
}

wait_any(array, msg, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  s_tracker = spawnStruct();

  foreach(ent in array) {
    if(isDefined(ent)) {
      level thread util::timeout(n_timeout, &_waitlogic2, s_tracker, ent, msg);
    }
  }

  s_tracker endon(#"array_wait");
  wait_till(array, "death");
}

_waitlogic2(s_tracker, ent, msg) {
  s_tracker endon(#"array_wait");

  if(msg != "death") {
    ent endon(#"death");
  }

  ent waittill(msg);
  s_tracker notify(#"array_wait");
}

flag_wait_any(array, str_flag) {
  self endon(#"death");

  foreach(ent in array) {
    if(ent flag::get(str_flag)) {
      return ent;
    }
  }

  wait_any(array, str_flag);
}

random(array) {
  keys = getarraykeys(array);
  return array[keys[randomint(keys.size)]];
}

randomize(array) {
  for(i = 0; i < array.size; i++) {
    j = randomint(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}

reverse(array) {
  a_array2 = [];

  for(i = array.size - 1; i >= 0; i--) {
    a_array2[a_array2.size] = array[i];
  }

  return a_array2;
}

slice(&array, var_12692bcf = 0, var_d88b3814 = 2147483647, n_increment = 1) {
  var_d88b3814 = min(var_d88b3814, array.size - 1);
  a_ret = [];
  i = var_12692bcf;

  while(i <= var_d88b3814) {
    a_ret[a_ret.size] = array[i];
    i += n_increment;
  }

  return a_ret;
}

remove_keys(array) {
  a_new = [];

  foreach(val in array) {
    if(isDefined(val)) {
      a_new[a_new.size] = val;
    }
  }

  return a_new;
}

swap(&array, index1, index2) {
  assert(index1 < array.size, "<dev string:x16e>");
  assert(index2 < array.size, "<dev string:x18c>");
  temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
}

pop(&array, index, b_keep_keys = 1) {
  if(array.size > 0) {
    if(!isDefined(index)) {
      index = getfirstarraykey(array);
    }

    if(isDefined(array[index])) {
      ret = array[index];
      arrayremoveindex(array, index, b_keep_keys);
      return ret;
    }
  }
}

push(&array, val, index = getlastarraykey(array) + 1) {
  arrayinsert(array, val, index);
}

push_front(&array, val) {
  push(array, val, 0);
}

replace(array, value, replacement) {
  foreach(i, val in array) {
    if(val === value) {
      array[i] = replacement;
    }
  }

  return array;
}

private function_80fe1cb6(a, b) {
  return a === b;
}

find(&array, ent, func_compare = &function_80fe1cb6) {
  for(i = 0; i < array.size; i++) {
    if([
        [func_compare]
      ](array[i], ent)) {
      return i;
    }
  }
}

closerfunc(dist1, dist2) {
  return dist1 >= dist2;
}

fartherfunc(dist1, dist2) {
  return dist1 <= dist2;
}

get_all_closest(org, &array, excluders = [], max = array.size, maxdist) {
  maxdists2rd = undefined;

  if(isDefined(maxdist)) {
    maxdists2rd = maxdist * maxdist;
  }

  dist = [];
  index = [];

  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i])) {
      continue;
    }

    excluded = 0;

    for(p = 0; p < excluders.size; p++) {
      if(array[i] != excluders[p]) {
        continue;
      }

      excluded = 1;
      break;
    }

    if(excluded) {
      continue;
    }

    length = distancesquared(org, array[i].origin);

    if(isDefined(maxdists2rd) && maxdists2rd < length) {
      continue;
    }

    dist[dist.size] = length;
    index[index.size] = i;
  }

  for(;;) {
    change = 0;

    for(i = 0; i < dist.size - 1; i++) {
      if(dist[i] <= dist[i + 1]) {
        continue;
      }

      change = 1;
      temp = dist[i];
      dist[i] = dist[i + 1];
      dist[i + 1] = temp;
      temp = index[i];
      index[i] = index[i + 1];
      index[i + 1] = temp;
    }

    if(!change) {
      break;
    }
  }

  newarray = [];

  if(max > dist.size) {
    max = dist.size;
  }

  for(i = 0; i < max; i++) {
    newarray[i] = array[index[i]];
  }

  return newarray;
}

alphabetize(&array) {
  return sort_by_value(array, 1);
}

sort_by_value(&array, b_lowest_first = 0) {
  return merge_sort(array, &_compare_value, b_lowest_first);
}

sort_by_script_int(&a_ents, b_lowest_first = 0) {
  return merge_sort(a_ents, &_compare_script_int, b_lowest_first);
}

merge_sort(&current_list, func_sort, param) {
  if(current_list.size <= 1) {
    return current_list;
  }

  left = [];
  right = [];
  middle = current_list.size / 2;

  for(x = 0; x < middle; x++) {
    if(!isDefined(left)) {
      left = [];
    } else if(!isarray(left)) {
      left = array(left);
    }

    left[left.size] = current_list[x];
  }

  while(x < current_list.size) {
    if(!isDefined(right)) {
      right = [];
    } else if(!isarray(right)) {
      right = array(right);
    }

    right[right.size] = current_list[x];
    x++;
  }

  left = merge_sort(left, func_sort, param);
  right = merge_sort(right, func_sort, param);
  result = merge(left, right, func_sort, param);
  return result;
}

merge(left, right, func_sort, param) {
  result = [];
  li = 0;

  for(ri = 0; li < left.size && ri < right.size; ri++) {
    b_result = undefined;

    if(isDefined(param)) {
      b_result = [
        [func_sort]
      ](left[li], right[ri], param);
    } else {
      b_result = [
        [func_sort]
      ](left[li], right[ri]);
    }

    if(b_result) {
      result[result.size] = left[li];
      li++;
      continue;
    }

    result[result.size] = right[ri];
  }

  while(li < left.size) {
    result[result.size] = left[li];
    li++;
  }

  while(ri < right.size) {
    result[result.size] = right[ri];
    ri++;
  }

  return result;
}

bubble_sort(&array, sort_func) {
  start = 0;
  end = array.size;
  var_f9038db1 = 1;

  while(var_f9038db1 && start < end) {
    var_f9038db1 = 0;
    i = start;

    for(j = start + 1; j < end; j++) {
      if([
          [sort_func]
        ](array[j], array[i])) {
        swap(array, j, i);
        var_f9038db1 = 1;
      }

      i++;
    }

    end--;

    if(var_f9038db1 && start < end) {
      var_f9038db1 = 0;
      i = end - 2;

      for(j = i + 1; i >= start; j--) {
        if([
            [sort_func]
          ](array[j], array[i])) {
          swap(array, j, i);
          var_f9038db1 = 1;
        }

        i--;
      }

      start++;
    }
  }
}

spread_all(&entities, func, arg1, arg2, arg3, arg4, arg5) {
  assert(isDefined(entities), "<dev string:x1aa>");
  assert(isDefined(func), "<dev string:x1e4>");

  if(isarray(entities)) {
    foreach(ent in entities) {
      if(isDefined(ent)) {
        util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5);
      }

      wait randomfloatrange(0.0666667, 0.133333);
    }

    return;
  }

  util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
  wait randomfloatrange(0.0666667, 0.133333);
}

wait_till_touching(&a_ents, e_volume) {
  while(!is_touching(a_ents, e_volume)) {
    waitframe(1);
  }
}

is_touching(&a_ents, e_volume) {
  foreach(e_ent in a_ents) {
    if(!e_ent istouching(e_volume)) {
      return false;
    }
  }

  return true;
}

contains(array_or_val, value) {
  if(isarray(array_or_val)) {
    foreach(element in array_or_val) {
      if(element === value) {
        return true;
      }
    }

    return false;
  }

  return array_or_val === value;
}

quick_sort(&array, compare_func) {
  sorted_array = arraycopy(array);
  quick_sort_mid(sorted_array, 0, sorted_array.size - 1, compare_func);
  return sorted_array;
}

quick_sort_mid(&array, start, end, compare_func) {
  if(end - start >= 1) {
    if(!isDefined(compare_func)) {
      compare_func = &_compare_value;
    }

    pivot = array[end];
    i = start;

    for(k = start; k < end; k++) {
      if([
          [compare_func]
        ](array[k], pivot)) {
        swap(array, i, k);
        i++;
      }
    }

    if(i != end) {
      swap(array, i, end);
    }

    quick_sort_mid(array, start, i - 1, compare_func);
    quick_sort_mid(array, i + 1, end, compare_func);
  }
}

_compare_value(val1, val2, b_lowest_first = 1) {
  if(b_lowest_first) {
    return (val1 <= val2);
  }

  return val1 > val2;
}

function_5b554cb6(val1, val2) {
  return val1 > val2;
}

_compare_script_int(e1, e2, b_lowest_first = 1) {
  if(b_lowest_first) {
    return (e1.script_int <= e2.script_int);
  }

  return e1.script_int > e2.script_int;
}

_filter_undefined(val) {
  return isDefined(val);
}

_filter_dead(val) {
  return isalive(val);
}

_filter_classname(val, arg) {
  return isDefined(val.classname) && issubstr(val.classname, arg);
}

function_e01a747e(val, arg) {
  return !(isDefined(val.classname) && issubstr(val.classname, arg));
}

function_f2d037b1() {
  wait 5;

  for(maxval = 0; maxval < 100; maxval++) {
    for(i = 0; i < 100; i++) {
      minval = randomintrangeinclusive(0, maxval);
      function_d1f43a84(undefined, minval, maxval);
      function_d1f43a84(undefined, minval, maxval, &function_5b554cb6, 0);
      waitframe(1);
    }
  }
}

function_d1f43a84(max_entries, minval, maxval, compare_func, var_c8e96eee) {
  if(!isDefined(max_entries)) {
    max_entries = 20;
  }

  if(!isDefined(minval)) {
    minval = 0;
  }

  if(!isDefined(maxval)) {
    maxval = 100;
  }

  if(!isDefined(compare_func)) {
    compare_func = undefined;
  }

  if(!isDefined(var_c8e96eee)) {
    var_c8e96eee = 1;
  }

  var_365f3054 = randomintrange(0, max_entries);
  println("<dev string:x21a>" + var_365f3054 + "<dev string:x235>" + minval + "<dev string:x252>" + maxval + "<dev string:x259>");
  source_array = [];

  for(i = 0; i < var_365f3054; i++) {
    if(!isDefined(source_array)) {
      source_array = [];
    } else if(!isarray(source_array)) {
      source_array = array(source_array);
    }

    source_array[source_array.size] = randomintrangeinclusive(minval, maxval);
  }

  test_array = arraycopy(source_array);
  sorted_array = quick_sort(test_array, compare_func);

  if(var_c8e96eee) {
    for(i = 0; i < var_365f3054 - 1; i++) {
      assert(sorted_array[i] <= sorted_array[i + 1], "<dev string:x267>");
    }
  } else {
    for(i = 0; i < var_365f3054 - 1; i++) {
      assert(sorted_array[i] >= sorted_array[i + 1], "<dev string:x267>");
    }
  }

  println("<dev string:x27c>");
}

function_81d0d595() {
  wait 5;

  for(maxval = 0; maxval < 100; maxval++) {
    for(i = 0; i < 100; i++) {
      minval = randomintrangeinclusive(0, maxval);
      function_70daaa9d(undefined, minval, maxval, &_compare_value);
      function_70daaa9d(undefined, minval, maxval, &function_5b554cb6, 0);
      waitframe(1);
    }
  }
}

function_70daaa9d(max_entries, minval, maxval, compare_func, var_c8e96eee) {
  if(!isDefined(max_entries)) {
    max_entries = 50;
  }

  if(!isDefined(minval)) {
    minval = 0;
  }

  if(!isDefined(maxval)) {
    maxval = 100;
  }

  if(!isDefined(compare_func)) {
    compare_func = undefined;
  }

  if(!isDefined(var_c8e96eee)) {
    var_c8e96eee = 1;
  }

  var_365f3054 = randomintrange(0, max_entries);
  println("<dev string:x283>" + var_365f3054 + "<dev string:x235>" + minval + "<dev string:x252>" + maxval + "<dev string:x259>");
  source_array = [];

  for(i = 0; i < var_365f3054; i++) {
    if(!isDefined(source_array)) {
      source_array = [];
    } else if(!isarray(source_array)) {
      source_array = array(source_array);
    }

    source_array[source_array.size] = randomintrangeinclusive(minval, maxval);
  }

  sorted_array = arraycopy(source_array);
  bubble_sort(sorted_array, compare_func);

  if(var_c8e96eee) {
    for(i = 0; i < var_365f3054 - 1; i++) {
      assert(sorted_array[i] <= sorted_array[i + 1], "<dev string:x29f>");
    }
  } else {
    for(i = 0; i < var_365f3054 - 1; i++) {
      assert(sorted_array[i] >= sorted_array[i + 1], "<dev string:x29f>");
    }
  }

  println("<dev string:x27c>");
}

