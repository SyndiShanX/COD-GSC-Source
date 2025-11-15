/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\array_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\util_shared;
#namespace array;

function filter( & array, b_keep_keys, func_filter, arg1, arg2, arg3, arg4, arg5) {
  a_new = [];
  foreach(key, val in array) {
    if(util::single_func(self, func_filter, val, arg1, arg2, arg3, arg4, arg5)) {
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

function remove_undefined(array, b_keep_keys) {
  if(isDefined(b_keep_keys)) {
    arrayremovevalue(array, undefined, b_keep_keys);
  } else {
    arrayremovevalue(array, undefined);
  }
  return array;
}

function get_touching( & array, b_keep_keys) {
  return filter(array, b_keep_keys, & istouching);
}

function remove_index(array, index, b_keep_keys) {
  a_new = [];
  foreach(key, val in array) {
    if(key == index) {
      continue;
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

function delete_all( & array, is_struct) {
  foreach(ent in array) {
    if(isDefined(ent)) {
      if(isDefined(is_struct) && is_struct) {
        ent struct::delete();
        continue;
      }
      if(isDefined(ent.__vtable)) {
        ent notify("death");
        ent = undefined;
        continue;
      }
      ent delete();
    }
  }
}

function notify_all( & array, str_notify) {
  foreach(elem in array) {
    elem notify(str_notify);
  }
}

function thread_all( & entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entities), "");
  assert(isDefined(func), "");
  if(isarray(entities)) {
    if(isDefined(arg6)) {
      foreach(ent in entities) {
        ent thread[[func]](arg1, arg2, arg3, arg4, arg5, arg6);
      }
    } else {
      if(isDefined(arg5)) {
        foreach(ent in entities) {
          ent thread[[func]](arg1, arg2, arg3, arg4, arg5);
        }
      } else {
        if(isDefined(arg4)) {
          foreach(ent in entities) {
            ent thread[[func]](arg1, arg2, arg3, arg4);
          }
        } else {
          if(isDefined(arg3)) {
            foreach(ent in entities) {
              ent thread[[func]](arg1, arg2, arg3);
            }
          } else {
            if(isDefined(arg2)) {
              foreach(ent in entities) {
                ent thread[[func]](arg1, arg2);
              }
            } else {
              if(isDefined(arg1)) {
                foreach(ent in entities) {
                  ent thread[[func]](arg1);
                }
              } else {
                foreach(ent in entities) {
                  ent thread[[func]]();
                }
              }
            }
          }
        }
      }
    }
  } else {
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
  }
}

function thread_all_ents( & entities, func, arg1, arg2, arg3, arg4, arg5) {
  assert(isDefined(entities), "");
  assert(isDefined(func), "");
  if(isarray(entities)) {
    if(entities.size) {
      keys = getarraykeys(entities);
      for(i = 0; i < keys.size; i++) {
        util::single_thread(self, func, entities[keys[i]], arg1, arg2, arg3, arg4, arg5);
      }
    }
  } else {
    util::single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
  }
}

function run_all( & entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  assert(isDefined(entities), "");
  assert(isDefined(func), "");
  if(isarray(entities)) {
    if(isDefined(arg6)) {
      foreach(ent in entities) {
        ent[[func]](arg1, arg2, arg3, arg4, arg5, arg6);
      }
    } else {
      if(isDefined(arg5)) {
        foreach(ent in entities) {
          ent[[func]](arg1, arg2, arg3, arg4, arg5);
        }
      } else {
        if(isDefined(arg4)) {
          foreach(ent in entities) {
            ent[[func]](arg1, arg2, arg3, arg4);
          }
        } else {
          if(isDefined(arg3)) {
            foreach(ent in entities) {
              ent[[func]](arg1, arg2, arg3);
            }
          } else {
            if(isDefined(arg2)) {
              foreach(ent in entities) {
                ent[[func]](arg1, arg2);
              }
            } else {
              if(isDefined(arg1)) {
                foreach(ent in entities) {
                  ent[[func]](arg1);
                }
              } else {
                foreach(ent in entities) {
                  ent[[func]]();
                }
              }
            }
          }
        }
      }
    }
  } else {
    util::single_func(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
  }
}

function exclude(array, array_exclude) {
  newarray = array;
  if(isarray(array_exclude)) {
    for(i = 0; i < array_exclude.size; i++) {
      arrayremovevalue(newarray, array_exclude[i]);
    }
  } else {
    arrayremovevalue(newarray, array_exclude);
  }
  return newarray;
}

function add( & array, item, allow_dupes = 1) {
  if(isDefined(item)) {
    if(allow_dupes || !isinarray(array, item)) {
      array[array.size] = item;
    }
  }
  return array;
}

function add_sorted( & array, item, allow_dupes = 1) {
  if(isDefined(item)) {
    if(allow_dupes || !isinarray(array, item)) {
      for(i = 0; i <= array.size; i++) {
        if(i == array.size || item <= array[i]) {
          arrayinsert(array, item, i);
          break;
        }
      }
    }
  }
}

function wait_till( & array, msg, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }
  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;
  foreach(ent in array) {
    if(isDefined(ent)) {
      ent thread util::timeout(n_timeout, & util::_waitlogic, s_tracker, msg);
    }
  }
  if(s_tracker._wait_count > 0) {
    s_tracker waittill("waitlogic_finished");
  }
}

function flag_wait( & array, str_flag) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];
    if(!ent flag::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

function flagsys_wait( & array, str_flag) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];
    if(!ent flagsys::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

function flagsys_wait_any_flag( & array, ...) {
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
        ent util::waittill_any_array(vararg);
        i = -1;
      }
    }
  }
}

function flag_wait_clear( & array, str_flag) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];
    if(ent flag::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

function flagsys_wait_clear( & array, str_flag) {
  for(i = 0; i < array.size; i++) {
    ent = array[i];
    if(ent flagsys::get(str_flag)) {
      ent waittill(str_flag);
      i = -1;
    }
  }
}

function wait_any(array, msg, n_timeout) {
  if(isDefined(n_timeout)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(n_timeout, "timeout");
  }
  s_tracker = spawnStruct();
  a_structs = [];
  foreach(ent in array) {
    if(isDefined(ent)) {
      s = spawnStruct();
      s thread util::timeout(n_timeout, & _waitlogic2, s_tracker, ent, msg);
      if(!isDefined(a_structs)) {
        a_structs = [];
      } else if(!isarray(a_structs)) {
        a_structs = array(a_structs);
      }
      a_structs[a_structs.size] = s;
    }
  }
  s_tracker endon("array_wait");
  wait_till(array, "death");
}

function _waitlogic2(s_tracker, ent, msg) {
  s_tracker endon("array_wait");
  ent endon("death");
  ent waittill(msg);
  s_tracker notify("array_wait");
}

function flag_wait_any(array, str_flag) {
  self endon("death");
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

function reverse(array) {
  a_array2 = [];
  for(i = array.size - 1; i >= 0; i--) {
    a_array2[a_array2.size] = array[i];
  }
  return a_array2;
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

function swap( & array, index1, index2) {
  assert(index1 < array.size, "");
  assert(index2 < array.size, "");
  temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
}

function pop( & array, index, b_keep_keys = 1) {
  if(array.size > 0) {
    if(!isDefined(index)) {
      keys = getarraykeys(array);
      index = keys[0];
    }
    if(isDefined(array[index])) {
      ret = array[index];
      arrayremoveindex(array, index, b_keep_keys);
      return ret;
    }
  }
}

function pop_front( & array, b_keep_keys = 1) {
  keys = getarraykeys(array);
  index = keys[keys.size - 1];
  return pop(array, index, b_keep_keys);
}

function push( & array, val, index) {
  if(!isDefined(index)) {
    index = 0;
    foreach(key in getarraykeys(array)) {
      if(isint(key) && key >= index) {
        index = key + 1;
      }
    }
  }
  arrayinsert(array, val, index);
}

function push_front( & array, val) {
  push(array, val, 0);
}

function get_closest(org, & array, dist = undefined) {
  assert(0, "");
}

function get_farthest(org, & array, dist = undefined) {
  assert(0, "");
}

function closerfunc(dist1, dist2) {
  return dist1 >= dist2;
}

function fartherfunc(dist1, dist2) {
  return dist1 <= dist2;
}

function get_all_farthest(org, & array, excluders, max) {
  sorted_array = get_closest(org, array, excluders);
  if(isDefined(max)) {
    temp_array = [];
    for(i = 0; i < sorted_array.size; i++) {
      temp_array[temp_array.size] = sorted_array[sorted_array.size - i];
    }
    sorted_array = temp_array;
  }
  sorted_array = reverse(sorted_array);
  return sorted_array;
}

function get_all_closest(org, & array, excluders = [], max = array.size, maxdist) {
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
    for(i = 0; i < (dist.size - 1); i++) {
      if(dist[i] <= (dist[i + 1])) {
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

function alphabetize( & array) {
  return sort_by_value(array, 1);
}

function sort_by_value( & array, b_lowest_first = 0) {
  return merge_sort(array, & _sort_by_value_compare_func, b_lowest_first);
}

function _sort_by_value_compare_func(val1, val2, b_lowest_first) {
  if(b_lowest_first) {
    return val1 < val2;
  }
  return val1 > val2;
}

function sort_by_script_int( & a_ents, b_lowest_first = 0) {
  return merge_sort(a_ents, & _sort_by_script_int_compare_func, b_lowest_first);
}

function _sort_by_script_int_compare_func(e1, e2, b_lowest_first) {
  if(b_lowest_first) {
    return e1.script_int < e2.script_int;
  }
  return e1.script_int > e2.script_int;
}

function merge_sort( & current_list, func_sort, param) {
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
  ri = 0;
  while(li < left.size && ri < right.size) {
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
    } else {
      result[result.size] = right[ri];
      ri++;
    }
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

function spread_all( & entities, func, arg1, arg2, arg3, arg4, arg5) {
  assert(isDefined(entities), "");
  assert(isDefined(func), "");
  if(isarray(entities)) {
    foreach(ent in entities) {
      util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5);
      wait(randomfloatrange(0.06666666, 0.1333333));
    }
  } else {
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
    wait(randomfloatrange(0.06666666, 0.1333333));
  }
}