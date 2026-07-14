/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_6b02b82c6fcb7983.gsc
*****************************************************/

#using scripts\common\queue;
#using scripts\engine\hud_management;
#namespace namespace_ea595839f459b385;

function function_7806501c4b8818a5(params) {
  if(!isstruct(params)) {
    params = spawnStruct();
  }

  if(!isDefined(params.ref)) {
    params.ref = "\xd9\x8d\xfa\xae$\xd0\x1c\x04\xc3SA";
  }

  if(!isDefined(params.widget_type)) {
    params.widget_type = "\xdc69\xd2\aGYF_\xeeZ#g\xac\x1d\xebve\xcde9-\xb1\xd7tY\x1e\xa3\xf5r\xcav\xb2\x85\xc6";
  }

  if(!isDefined(params.x_pos)) {
    params.x_pos = 0;
  }

  if(!isDefined(params.y_pos)) {
    params.y_pos = -200;
  }

  if(!isDefined(params.x_anchor)) {
    params.x_anchor = 1;
  }

  if(!isDefined(params.y_anchor)) {
    params.y_anchor = 1;
  }

  if(!isDefined(params.font_height)) {
    params.font_height = 24;
  }

  if(!isDefined(params.reveal_time)) {
    params.reveal_time = 7;
  }

  if(!isDefined(params.reveal_scale)) {
    params.reveal_scale = 1.5;
  }

  item = spawnStruct();
  item.init_func = &function_bf4f9fc7f4c15b07;
  item.break_func = &function_f0703fdd6b6cbf8b;
  item.interrupt_func = &function_6560fd9e3db1052f;
  item.func_params = params;
  thread queue::function_e964ae838fe2a244(params.ref, item);
}

function function_9b838a13d50c7d41(message, ref, widget_type, param, x_pos, y_pos, x_anchor, y_anchor, delay, font_height, reveal_time, reveal_scale) {
  params = spawnStruct();
  params.message = message;
  params.ref = ref;
  params.widget_type = widget_type;
  params.x_pos = x_pos;
  params.y_pos = y_pos;
  params.x_anchor = x_anchor;
  params.y_anchor = y_anchor;
  params.font_height = font_height;
  params.reveal_time = reveal_time;
  params.reveal_scale = reveal_scale;
  params.param = param;
  params.delay = delay;
  function_7806501c4b8818a5(params);
}

function private function_bf4f9fc7f4c15b07(params, start_time, endons) {
  if(isDefined(params.delay)) {
    foreach(end in endons) {
      self endon(end);
    }

    wait params.delay;
  }

  hud_management::function_35924dfcb78711f4(params.ref, params.widget_type);
  hud_management::function_85d8a0ba2e35b6f2(params.ref, params.x_pos, params.y_pos, params.x_anchor, params.y_anchor);

  if(isDefined(params.param)) {
    hud_management::function_b683400f784cb7dc(params.ref, params.param);
  }

  fields = [];
  fields["\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:"] = function_30e4f86dded0873(params.message);
  fields["E\xc0V\xad\x9f\x06\x16\xb2\xf4\xacn"] = params.font_height;
  fields["\x93\xea:T3\xe0\xcf{\xed\a\x89"] = params.reveal_time;
  fields["\xeeE\xac\xba\x83\x7f\xfb~\xc5jKL"] = params.reveal_scale;
  hud_management::function_41ff479ac45608d6(params.ref, fields, 1);
}

function private function_f0703fdd6b6cbf8b(params, start_time, before_init) {
  if(istrue(before_init)) {
    return false;
  }

  if(isDefined(params.delay) && gettime() < start_time + params.delay * 1000 + 0.05) {
    return false;
  }

  return !hud_management::function_48c98ea9a4f0da89(params.ref);
}

function private function_6560fd9e3db1052f(params, start_time) {
  hud_management::scripted_widget_destroy(params.ref);
}