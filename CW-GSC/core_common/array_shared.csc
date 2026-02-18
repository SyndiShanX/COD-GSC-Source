/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\array_shared.csc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace array;

function filter(&array, b_keep_keys, func_filter, ...) {
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

      if(is_true(b_keep_keys)) {
        a_new[key] = val;
        continue;
      }

      a_new[a_new.size] = val;
    }
  }

  return a_new;
}

function filter_classname(&array, b_keep_keys, str_classname) {
  return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

function function_f23011ac(&array, b_keep_keys, str_classname) {
  return filter(array, b_keep_keys, &function_e01a747e, str_classname);
}

function get_touching(a_ents, e_volume) {
  a_touching = [];

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

function remove_index(array, index, b_keep_keys) {
  a_new = [];

  foreach(key, val in array) {
    if(key == index) {
      continue;
    }

    if(is_true(b_keep_keys)) {
      a_new[key] = val;
      continue;
    }

    a_new[a_new.size] = val;
  }

  return a_new;
}

function function_b1d17853(&array) {
  remove = [];
  checked = [];

  foreach(key, item in array) {
    if(!isDefined(item)) {
      add(remove, key);
      continue;
    }

    checked[key] = 1;

    foreach(var_279de89e, var_cc6c9b0a in array) {
      if(var_279de89e != key && var_cc6c9b0a == item && !isDefined(checked[var_279de89e])) {
        add(remove, key);
        break;
      }
    }
  }

  foreach(key in remove) {
    array[key] = undefined;
  }

  return array;
}

function delete_all(&array, is_struct) {
  foreach(ent in array) {
    if(isDefined(ent)) {
      if(is_true(is_struct)) {
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

function notify_all(&array, str_notify) {
  foreach(elem in array) {
    elem notify(str_notify);
  }
}

function thread_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entities), "<dev string:x38>");
  assert(isDefined(func), "<dev string:x6e>");

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

function thread_all_ents(&entities, func, arg1, arg2, arg3, arg4, arg5) {
  assert(isDefined(entities), "<dev string:xa0>");
  assert(isDefined(func), "<dev string:xdb>");

  if(isarray(entities)) {
    foreach(v in entities) {
      util::single_thread(self, func, v, arg1, arg2, arg3, arg4, arg5);
    }

    return;
  }

  util::single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
}

function run_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entities), "<dev string:x112>");
  assert(isDefined(func), "<dev string:x145>");

  if(isarray(entities)) {
    foreach(ent in entities) {
      util::single_func(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    return;
  }

  util::single_func(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

function exclude(array, array_exclude) {
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

function add(&array, item, allow_dupes = 1) {
  if(isDefined(item)) {
    if(allow_dupes || !isinarray(array, item)) {
      array[array.size] = item;
    }
  }
}

function add_sorted(&array, item, allow_dupes = 1, func_compare, var_e19f0739 = 0) {
  if(isDefined(item)) {
    if(allow_dupes || !isinarray(array, item)) {
      for(i = 0; i <= array.size; i++) {
        if(i == array.size || isDefined(func_compare) && ([[func_compare]](item, array[i]) || var_e19f0739) || !isDefined(func_compare) && (item <= array[i] || var_e19f0739)) {
          arrayinsert(array, item, i);
          break;
        }
      }
    }
  }
}

function wait_till(&array, notifies, n_timeout) {
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

function wait_till_match(&array, str_notify, str_match, n_timeout) {
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

function _waitlogic_match(s_tracker, str_notify, str_match) {
  self endon(#"death");
  self waittillmatch(str_match, str_notify);
  update_waitlogic_tracker(s_tracker);
}

function _waitlogic_death(s_tracker) {
  self waittill(#"death");
  update_waitlogic_tracker(s_tracker);
}

function update_waitlogic_tracker(s_tracker) {
  s_tracker._array_wait_count--;

  if(s_tracker._array_wait_count == 0) {
    s_tracker notify(#"array_wait");
  }
}

function flag_wait(&array, str_flag) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];

    if(!ent flag::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

function function_d77ef691(&array, ...) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];

    if(isDefined(ent)) {
      b_flag_set = 0;

      foreach(str_flag in vararg) {
        if(ent flag::get(str_flag)) {
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

function flag_wait_clear(&array, str_flag, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }

  for(i = 0; i < array.size; i++) {
    ent = array[i];

    if(ent flag::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

function wait_any(array, msg, n_timeout) {
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

function _waitlogic2(s_tracker, ent, msg) {
  s_tracker endon(#"array_wait");

  if(msg != "death") {
    ent endon(#"death");
  }

  ent waittill(msg);
  s_tracker notify(#"array_wait");
}

function flag_wait_any(array, str_flag) {
  self endon(#"death");

  foreach(ent in array) {
    if(ent flag::get(str_flag)) {
      return ent;
    }
  }

  wait_any(array, str_flag);
}

function random(array) {
  keys = getarraykeys(array);
  return array[keys[randomint(keys.size)]];
}

function randomize(array) {
  for(i = 0; i < array.size; i++) {
    j = randomint(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}

function function_20973c2b(array) {
  for(i = 0; i < array.size; i++) {
    j = function_d59c2d03(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }

  return array;
}

function reverse(array) {
  a_array2 = [];

  for(i = array.size - 1; i >= 0; i--) {
    a_array2[a_array2.size] = array[i];
  }

  return a_array2;
}

function slice(&array, var_12692bcf = 0, var_d88b3814 = 2147483647, n_increment = 1) {
  var_d88b3814 = min(var_d88b3814, array.size - 1);
  a_ret = [];
  i = var_12692bcf;

  while(i <= var_d88b3814) {
    a_ret[a_ret.size] = array[i];
    i += n_increment;
  }

  return a_ret;
}

function remove_keys(array) {
  a_new = [];

  foreach(val in array) {
    if(isDefined(val)) {
      a_new[a_new.size] = val;
    }
  }

  return a_new;
}

function swap(&array, index1, index2) {
  assert(index1 < array.size, "<dev string:x174>");
  assert(index2 < array.size, "<dev string:x193>");
  temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
}

function pop(&array, index, b_keep_keys = 1) {
  if(array.size > 0) {
    if(!isDefined(index)) {
      index = getlastarraykey(array);
    }

    if(isDefined(array[index])) {
      ret = array[index];
      arrayremoveindex(array, index, b_keep_keys);
      return ret;
    }
  }
}

function pop_front(&array, b_keep_keys = 1) {
  index = getfirstarraykey(array);
  return pop(array, index, b_keep_keys);
}

function push(&array, val, index = array.size + 1) {
  arrayinsert(array, val, index);
}

function push_front(&array, val) {
  push(array, val, 0);
}

function replace(array, value, replacement) {
  foreach(i, val in array) {
    if(val === value) {
      array[i] = replacement;
    }
  }

  return array;
}

function private function_80fe1cb6(a, b) {
  return a === b;
}

function find(&array, ent, func_compare = &function_80fe1cb6) {
  for(i = 0; i < array.size; i++) {
    if([[func_compare]](array[i], ent)) {
      return i;
    }
  }
}

function closerfunc(dist1, dist2) {
  return dist1 >= dist2;
}

function fartherfunc(dist1, dist2) {
  return dist1 <= dist2;
}

function get_all_closest(org, &array, excluders = [], max = array.size, maxdist) {
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

function alphabetize(&array) {
  return sort_by_value(array, 1);
}

function sort_by_value(&array, b_lowest_first = 0) {
  return merge_sort(array, &_compare_value, b_lowest_first);
}

function sort_by_script_int(&a_ents, b_lowest_first = 0) {
  return merge_sort(a_ents, &_compare_script_int, b_lowest_first);
}

function merge_sort(&current_list, func_sort, param) {
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

function merge(left, right, func_sort, param) {
  result = [];
  li = 0;

  for(ri = 0; li < left.size && ri < right.size; ri++) {
    b_result = undefined;

    if(isDefined(param)) {
      b_result = [[func_sort]](left[li], right[ri], param);
    } else {
      b_result = [[func_sort]](left[li], right[ri]);
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

function bubble_sort(&array, sort_func) {
  start = 0;
  end = array.size;
  var_f9038db1 = 1;

  while(var_f9038db1 && start < end) {
    var_f9038db1 = 0;
    i = start;

    for(j = start + 1; j < end; j++) {
      if([[sort_func]](array[j], array[i])) {
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
        if([[sort_func]](array[j], array[i])) {
          swap(array, j, i);
          var_f9038db1 = 1;
        }

        i--;
      }

      start++;
    }
  }
}

function spread_all(&entities, func, arg1, arg2, arg3, arg4, arg5) {
  assert(isDefined(entities), "<dev string:x1b2>");
  assert(isDefined(func), "<dev string:x1ed>");

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

function wait_till_touching(&a_ents, e_volume) {
  while(!is_touching(a_ents, e_volume)) {
    waitframe(1);
  }
}

function is_touching(&a_ents, e_volume) {
  foreach(e_ent in a_ents) {
    if(!e_ent istouching(e_volume)) {
      return false;
    }
  }

  return true;
}

function contains(array_or_val, value) {
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

function quick_sort(&array, compare_func) {
  sorted_array = arraycopy(array);
  quick_sort_mid(sorted_array, 0, sorted_array.size - 1, compare_func);
  return sorted_array;
}

function quick_sort_mid(&array, start, end, compare_func) {
  if(end - start >= 1) {
    if(!isDefined(compare_func)) {
      compare_func = &_compare_value;
    }

    pivot = array[end];
    i = start;

    for(k = start; k < end; k++) {
      if([[compare_func]](array[k], pivot)) {
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

function _compare_value(val1, val2, b_lowest_first = 1) {
  if(b_lowest_first) {
    return (val1 <= val2);
  }

  return val1 > val2;
}

function function_5b554cb6(val1, val2) {
  return val1 > val2;
}

function _compare_script_int(e1, e2, b_lowest_first = 1) {
  if(b_lowest_first) {
    return (e1.script_int <= e2.script_int);
  }

  return e1.script_int > e2.script_int;
}

function _filter_undefined(val) {
  return isDefined(val);
}

function _filter_dead(val) {
  return isalive(val);
}

function _filter_classname(val, arg) {
  return isDefined(val.classname) && issubstr(val.classname, arg);
}

function function_e01a747e(val, arg) {
  return !(isDefined(val.classname) && issubstr(val.classname, arg));
}

function function_f2d037b1() {
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

function function_d1f43a84(max_entries, minval, maxval, compare_func, var_c8e96eee) {
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
  println("<dev string:x224>" + var_365f3054 + "<dev string:x240>" + minval + "<dev string:x25e>" + maxval + "<dev string:x266>");
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
      assert(sorted_array[i] <= sorted_array[i + 1], "<dev string:x275>");
    }
  } else {
    for(i = 0; i < var_365f3054 - 1; i++) {
      assert(sorted_array[i] >= sorted_array[i + 1], "<dev string:x275>");
    }
  }

  println("<dev string:x28b>");
}

function function_81d0d595() {
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

function function_70daaa9d(max_entries, minval, maxval, compare_func, var_c8e96eee) {
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
  println("<dev string:x293>" + var_365f3054 + "<dev string:x240>" + minval + "<dev string:x25e>" + maxval + "<dev string:x266>");
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
      assert(sorted_array[i] <= sorted_array[i + 1], "<dev string:x2b0>");
    }
  } else {
    for(i = 0; i < var_365f3054 - 1; i++) {
      assert(sorted_array[i] >= sorted_array[i + 1], "<dev string:x2b0>");
    }
  }

  println("<dev string:x28b>");
}