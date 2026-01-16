/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\hackable.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\system_shared;

#namespace hackable;

autoexec __init__system__() {
  system::register(#"hackable", &init, undefined, undefined);
}

init() {
  if(!isDefined(level.hackable_items)) {
    level.hackable_items = [];
  }
}

add_hackable_object(obj, test_callback, start_callback, fail_callback, complete_callback) {
  cleanup_hackable_objects();

  if(!isDefined(level.hackable_items)) {
    level.hackable_items = [];
  } else if(!isarray(level.hackable_items)) {
    level.hackable_items = array(level.hackable_items);
  }

  level.hackable_items[level.hackable_items.size] = obj;

  if(!isDefined(obj.hackable_distance_sq)) {
    obj.hackable_distance_sq = getdvarfloat(#"scr_hacker_default_distance", 0) * getdvarfloat(#"scr_hacker_default_distance", 0);
  }

  if(!isDefined(obj.hackable_angledot)) {
    obj.hackable_angledot = getdvarfloat(#"scr_hacker_default_angledot", 0);
  }

  if(!isDefined(obj.hackable_timeout)) {
    obj.hackable_timeout = getdvarfloat(#"scr_hacker_default_timeout", 0);
  }

  if(!isDefined(obj.hackable_progress_prompt)) {
    obj.hackable_progress_prompt = #"weapon/hacking";
  }

  if(!isDefined(obj.hackable_cost_mult)) {
    obj.hackable_cost_mult = 1;
  }

  if(!isDefined(obj.hackable_hack_time)) {
    obj.hackable_hack_time = getdvarfloat(#"scr_hacker_default_hack_time", 0);
  }

  obj.hackable_test_callback = test_callback;
  obj.hackable_start_callback = start_callback;
  obj.hackable_fail_callback = fail_callback;
  obj.hackable_hacked_callback = complete_callback;
}

remove_hackable_object(obj) {
  arrayremovevalue(level.hackable_items, obj);
  cleanup_hackable_objects();
}

cleanup_hackable_objects() {
  level.hackable_items = array::filter(level.hackable_items, 0, &filter_deleted);
}

filter_deleted(val) {
  return isDefined(val);
}

find_hackable_object() {
  cleanup_hackable_objects();
  candidates = [];
  origin = self.origin;
  forward = anglesToForward(self.angles);

  foreach(obj in level.hackable_items) {
    if(self is_object_hackable(obj, origin, forward)) {
      if(!isDefined(candidates)) {
        candidates = [];
      } else if(!isarray(candidates)) {
        candidates = array(candidates);
      }

      candidates[candidates.size] = obj;
    }
  }

  if(candidates.size > 0) {
    return arraygetclosest(self.origin, candidates);
  }

  return undefined;
}

is_object_hackable(obj, origin, forward) {
  if(distancesquared(origin, obj.origin) < obj.hackable_distance_sq) {
    to_obj = obj.origin - origin;
    to_obj = (to_obj[0], to_obj[1], 0);
    to_obj = vectornormalize(to_obj);
    dot = vectordot(to_obj, forward);

    if(dot >= obj.hackable_angledot) {
      if(isDefined(obj.hackable_test_callback)) {
        return obj[[obj.hackable_test_callback]](self);
      }

      return 1;
    } else {
    }
  }

  return 0;
}

start_hacking_object(obj) {
  obj.hackable_being_hacked = 1;
  obj.hackable_hacked_amount = 0;

  if(isDefined(obj.hackable_start_callback)) {
    obj thread[[obj.hackable_start_callback]](self);
  }
}

fail_hacking_object(obj) {
  if(isDefined(obj.hackable_fail_callback)) {
    obj thread[[obj.hackable_fail_callback]](self);
  }

  obj.hackable_hacked_amount = 0;
  obj.hackable_being_hacked = 0;
  obj notify(#"hackable_watch_timeout");
}

complete_hacking_object(obj) {
  obj notify(#"hackable_watch_timeout");

  if(isDefined(obj.hackable_hacked_callback)) {
    obj thread[[obj.hackable_hacked_callback]](self);
  }

  obj.hackable_hacked_amount = 0;
  obj.hackable_being_hacked = 0;
}

watch_timeout(obj, time) {
  obj notify(#"hackable_watch_timeout");
  obj endon(#"hackable_watch_timeout");
  wait time;

  if(isDefined(obj)) {
    fail_hacking_object(obj);
  }
}

continue_hacking_object(obj) {
  origin = self.origin;
  forward = anglesToForward(self.angles);

  if(self is_object_hackable(obj, origin, forward)) {
    if(!(isDefined(obj.hackable_being_hacked) && obj.hackable_being_hacked)) {
      self start_hacking_object(obj);
    }

    if(isDefined(obj.hackable_timeout) && obj.hackable_timeout > 0) {
      self thread watch_timeout(obj, obj.hackable_timeout);
    }

    amt = 1 / 20 * obj.hackable_hack_time;
    obj.hackable_hacked_amount += amt;

    if(obj.hackable_hacked_amount > 1) {
      self complete_hacking_object(obj);
    }

    if(isDefined(obj.hackable_being_hacked) && obj.hackable_being_hacked) {
      return obj.hackable_hacked_amount;
    }
  }

  if(isDefined(obj.hackable_being_hacked) && obj.hackable_being_hacked) {}

  return -1;
}