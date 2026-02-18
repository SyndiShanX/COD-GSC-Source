/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\easing.csc
***********************************************/

#using script_140d5347de8af85c;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace easing;

function function_a037b7c9(localclientnum, ui_model, value, time, ease_type, ease_in, ease_out, var_33ce6852) {
  self thread function_d4a4a726(localclientnum, getuimodelvalue(ui_model), value, time, &function_3d07aeab, ease_type, "ease_uimodel_" + ui_model, "ease_uimodel_" + ui_model, ease_in, ease_out, var_33ce6852, ui_model);
}

function ease_camera_position(start, target, time, ease_type, ease_in, ease_out, var_33ce6852) {
  assert(self isPlayer());

  if(!isDefined(start)) {
    start = self getcampos();
  }

  localclientnum = self getlocalclientnumber();
  self thread function_d4a4a726(localclientnum, start, target, time, &function_5b854508, ease_type, "ease_camera_position", "ease_camera_position", ease_in, ease_out, var_33ce6852);
}

function ease_camera_angles(start, target, time, ease_type, ease_in, ease_out, var_33ce6852) {
  assert(self isPlayer());

  if(!isDefined(start)) {
    start = self getcamangles();
  }

  start = angleclamp180(start);
  target = start + angleclamp180(target - start);
  localclientnum = self getlocalclientnumber();
  self thread function_d4a4a726(localclientnum, start, target, time, &function_d4923609, ease_type, "ease_camera_angles", "ease_camera_angles", ease_in, ease_out, var_33ce6852);
}

function function_f95cb457(start, target, time, ease_type, ease_in, ease_out, var_33ce6852, min, max) {
  assert(self isPlayer());
  assert(target > 0);

  if(!isDefined(start) && ease_type == # "linear") {
    self function_49cdf043(math::clamp(target, isDefined(min) ? min : 1e-05, isDefined(max) ? max : 2147483647), time);
    return;
  }

  var_aca17b66 = self function_82f1cbd2();

  if(!isDefined(start)) {
    start = var_aca17b66;
  }

  if(getdvarint(#"hash_32f02866d46e6e7b", 0)) {
    var_18b7d7a4 = self function_838f0a04();
    delta = var_18b7d7a4 - getdvarfloat(#"cg_focallength", var_18b7d7a4);

    if(abs(delta) > 0.001) {
      start -= delta;
    }
  }

  localclientnum = self getlocalclientnumber();
  self thread function_d4a4a726(localclientnum, start, target, time, &function_c426caa9, ease_type, "ease_camera_lens_focal_length", ["ease_camera_lens_focal_length", "deactivate_camera_lens_overrides"], ease_in, ease_out, var_33ce6852, min, max);
}

function function_b6f1c993(start, target, time, ease_type, ease_in, ease_out, var_33ce6852, min, max) {
  assert(self isPlayer());
  assert(target > 0);

  if(!isDefined(start)) {
    start = self function_78bf7752();
  }

  localclientnum = self getlocalclientnumber();
  self thread function_d4a4a726(localclientnum, start, target, time, &function_dd427b21, ease_type, "ease_camera_lens_focal_distance", ["ease_camera_lens_focal_distance", "deactivate_camera_lens_overrides"], ease_in, ease_out, var_33ce6852, min, max);
}

function function_136edb11(start, target, time, ease_type, ease_in, ease_out, var_33ce6852, min, max) {
  assert(self isPlayer());
  assert(target > 0);

  if(!isDefined(start)) {
    start = self function_28aef982();
  }

  localclientnum = self getlocalclientnumber();
  self thread function_d4a4a726(localclientnum, start, target, time, &function_9f966a98, ease_type, "ease_camera_lens_fstop", ["ease_camera_lens_fstop", "deactivate_camera_lens_overrides"], ease_in, ease_out, var_33ce6852, min, max);
}

function ease_dvar(localclientnum, dvar, var_c7ec7d60, value, time, ease_type, ease_in, ease_out, var_33ce6852) {
  self thread function_d4a4a726(localclientnum, getdvarfloat(dvar), value, time, &function_8ff186e5, ease_type, "ease_dvar_" + dvar, "ease_dvar_" + dvar, ease_in, ease_out, var_33ce6852, dvar, var_c7ec7d60);
}

function ease_origin(localclientnum, target, time, ease_type, axis, additive, ease_in, ease_out, var_33ce6852) {
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

  self thread function_d4a4a726(localclientnum, start_value, target, time, callback, ease_type, "ease_origin", endons, ease_in, ease_out, var_33ce6852, axis);
}

function ease_angles(localclientnum, target, time, ease_type, axis, additive, ease_in, ease_out, var_33ce6852) {
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

  self thread function_d4a4a726(localclientnum, start_value, target, time, callback, ease_type, "ease_angles", endons, ease_in, ease_out, var_33ce6852, axis);
}

function function_d4a4a726(localclientnum, start_value, target_value, time, callback_func, ease_type = # "linear", notifies, endons, ease_in, ease_out, var_33ce6852, ...) {
  assert(isDefined(level.ease_funcs));
  assert(isDefined(level.ease_funcs[ease_type]));
  localplayer = function_5c10bd79(localclientnum);

  if(!isDefined(localplayer)) {
    return;
  }

  localplayer endon(#"death");

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
  last_time = float(localplayer getclienttime()) / 1000;
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
    new_time = float(localplayer getclienttime()) / 1000;
    cur_time += new_time - last_time;
    last_time = new_time;
  }

  var_b3160f0.cur_value = target_value;
  var_b3160f0.delta = var_b3160f0.target_value - var_88a4b08c;
  var_b3160f0.var_37e98bce = 1;
  var_b3160f0.localclientnum = localclientnum;
  util::function_50f54b6f(self, callback_func, var_b3160f0, vararg);

  if(isDefined(self)) {
    self notify(#"ease_done", {
      #start_value: start_value, #target_value: target_value, #time: time, #callback_func: callback_func, #ease_type: ease_type, #localclientnum: localclientnum
    });
  }
}

function private function_3d07aeab(var_b3160f0, ui_model) {
  setuimodelvalue(ui_model, var_b3160f0.cur_value);
}

function private function_5b854508(var_b3160f0) {
  self camerasetposition(var_b3160f0.cur_value);
}

function private function_d4923609(var_b3160f0) {
  self camerasetlookat(var_b3160f0.cur_value);
}

function private function_c426caa9(var_b3160f0, min_val = 0.01, max_val = 2147483647) {
  self function_49cdf043(math::clamp(var_b3160f0.cur_value, min_val, max_val), 0);
}

function private function_dd427b21(var_b3160f0, min_val = 0.01, max_val = 2147483647) {
  self function_d7be9a9f(math::clamp(var_b3160f0.cur_value, min_val, max_val), 0);
}

function private function_9f966a98(var_b3160f0, min_val = 0.01, max_val = 2147483647) {
  self function_1816c600(math::clamp(var_b3160f0.cur_value, min_val, max_val), 0);
}