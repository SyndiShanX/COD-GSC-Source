/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\easing.gsc
***********************************************/

#using script_37f9ff47f340fbe8;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace easing;

function ease_dvar(dvar, var_c7ec7d60, value, time, ease_type, ease_in, ease_out, var_33ce6852) {
  self thread function_d4a4a726(getdvarfloat(dvar), value, time, &function_8ff186e5, ease_type, "ease_dvar_" + dvar, "ease_dvar_" + dvar, ease_in, ease_out, var_33ce6852, dvar, var_c7ec7d60);
}

function ease_origin(target, time, ease_type, axis, additive, ease_in, ease_out, var_33ce6852) {
  assert(self != level);
  endons = undefined;
  callback = &function_54354e4e;
  start_value = self.origin;

  if(is_true(additive)) {
    callback = &function_92b063ff;
  } else {
    endons = ["ease_origin", "ease_origin_x", "ease_origin_y", "ease_origin_z"];
  }

  if(isDefined(axis)) {
    assert(axis >= 0 && axis <= 2);
    start_value = start_value[axis];
  } else {
    axis = -1;
  }

  self thread function_d4a4a726(start_value, target, time, callback, ease_type, "ease_origin", endons, ease_in, ease_out, var_33ce6852, axis);
}

function ease_angles(target, time, ease_type, axis, additive, ease_in, ease_out, var_33ce6852) {
  assert(self != level);
  endons = undefined;
  callback = &function_3b3f9801;
  start_value = self.angles;

  if(is_true(additive)) {
    callback = &function_faea843b;
  } else {
    endons = ["ease_angles", "ease_pitch", "ease_yaw", "ease_roll"];
  }

  if(isDefined(axis)) {
    assert(axis >= 0 && axis <= 2);
    start_value = start_value[axis];
  } else {
    axis = -1;
  }

  self thread function_d4a4a726(start_value, target, time, callback, ease_type, "ease_angles", endons, ease_in, ease_out, var_33ce6852, axis);
}

function function_d4a4a726(start_value, target_value, time, callback_func, ease_type = # "linear", notifies, endons, ease_in, ease_out, var_33ce6852, ...) {
  assert(isDefined(level.ease_funcs));
  assert(isDefined(level.ease_funcs[ease_type]));

  if(!isDefined(notifies)) {
    notifies = [];
  } else if(!isarray(notifies)) {
    notifies = array(notifies);
  }

  foreach(notify_str in notifies) {
    self notify(notify_str);
  }

  if(isDefined(endons)) {
    self endon(endons);
  }

  if(!isDefined(var_33ce6852)) {
    var_33ce6852 = [];
  } else if(!isarray(var_33ce6852)) {
    var_33ce6852 = array(var_33ce6852);
  }

  var_b3160f0 = spawnStruct();
  var_b3160f0.start_value = start_value;
  var_b3160f0.target_value = target_value;
  var_b3160f0.cur_value = start_value;
  var_b3160f0.var_37e98bce = 0;
  var_88a4b08c = var_b3160f0.cur_value;
  cur_time = 0;

  while(cur_time < time) {
    var_b3160f0.pct = min(1, cur_time / time);
    var_88a4b08c = var_b3160f0.cur_value;

    switch (var_33ce6852.size) {
      case 3:
        var_b3160f0.cur_value = [[level.ease_funcs[ease_type]]](start_value, target_value, var_b3160f0.pct, ease_in, ease_out, var_33ce6852[0], var_33ce6852[1], var_33ce6852[2]);
        break;
      case 2:
        var_b3160f0.cur_value = [[level.ease_funcs[ease_type]]](start_value, target_value, var_b3160f0.pct, ease_in, ease_out, var_33ce6852[0], var_33ce6852[1]);
        break;
      case 1:
        var_b3160f0.cur_value = [[level.ease_funcs[ease_type]]](start_value, target_value, var_b3160f0.pct, ease_in, ease_out, var_33ce6852[0]);
        break;
      default:
        var_b3160f0.cur_value = [[level.ease_funcs[ease_type]]](start_value, target_value, var_b3160f0.pct, ease_in, ease_out);
        break;
    }

    var_b3160f0.delta = var_b3160f0.cur_value - var_88a4b08c;
    util::function_50f54b6f(self, callback_func, var_b3160f0, vararg);
    waitframe(1);
    cur_time += float(function_60d95f53()) / 1000;
  }

  var_b3160f0.cur_value = target_value;
  var_b3160f0.delta = var_b3160f0.target_value - var_88a4b08c;
  var_b3160f0.var_37e98bce = 1;
  util::function_50f54b6f(self, callback_func, var_b3160f0, vararg);

  if(isDefined(self)) {
    self notify(#"ease_done", {
      #start_value: start_value, #target_value: target_value, #time: time, #callback_func: callback_func, #ease_type: ease_type
    });
  }
}