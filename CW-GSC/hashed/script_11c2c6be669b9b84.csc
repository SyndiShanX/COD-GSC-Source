/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_11c2c6be669b9b84.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#namespace namespace_61e6d095;

function private autoexec __init__system__() {
  system::register(#"hash_7f2a4dd4a17f2f59", &preload, undefined, undefined, undefined);
}

function private preload() {
  callback::add_callback(#"on_player_spawned", &on_player_spawn);
}

function on_player_spawn(localclientnum) {
  self endon(#"death");
  inputs = [];
  inputs[# "ui_confirm"] = "confirm";
  inputs[# "ui_cancel"] = "cancel";
  inputs[# "ui_alt1"] = "alt1";
  inputs[# "ui_alt2"] = "alt2";
  inputs[# "ui_navup"] = "navup";
  inputs[# "ui_navdown"] = "navdown";
  inputs[# "ui_navleft"] = "navleft";
  inputs[# "ui_navright"] = "navright";
  inputs[# "ui_prevtab"] = "prevtab";
  inputs[# "ui_nexttab"] = "nexttab";
  inputs[# "hash_5686e6f2a8315663"] = "backspace";

  foreach(key, value in inputs) {
    self flag::clear(key);
  }

  while(true) {
    waitresult = level waittill(#"ui_input");
    self childthread flag::set_for_time(0.05, waitresult.param1);
  }
}

function function_affb1af1() {
  return self flag::get(#"ui_confirm");
}

function function_57fbd346() {
  return self flag::get(#"ui_cancel");
}

function function_e4d62f9a() {
  return self flag::get(#"ui_alt1");
}

function function_728aec47() {
  return self flag::get(#"ui_alt2");
}

function function_aef1e8c3() {
  return self flag::get(#"ui_navup");
}

function function_9975a94d() {
  return self flag::get(#"ui_navdown");
}

function function_c2d8a326() {
  return self flag::get(#"ui_navleft");
}

function function_3d680c10() {
  return self flag::get(#"ui_navright");
}

function function_d0beaa6e() {
  return self flag::get(#"ui_prevtab");
}

function function_1e9035e9() {
  return self flag::get(#"ui_nexttab");
}

function function_57799116() {
  return self flag::get(#"hash_5686e6f2a8315663");
}

function function_9c365c3b() {
  return function_cf2348e7(function_90d058e8(#"left_stick"));
}

function function_6cbc939b() {
  return function_cf2348e7(function_90d058e8(#"right_stick"));
}

function private function_cf2348e7(model) {
  var_b0672ef2 = getuimodel(model, #"degrees");
  var_9487f37 = getuimodel(model, #"length");
  var_f76e6210 = getuimodel(model, #"x");
  var_f1cc2bf9 = getuimodel(model, #"y");
  return {
    #degrees: getuimodelvalue(var_b0672ef2), #length: getuimodelvalue(var_9487f37), #x: getuimodelvalue(var_f76e6210), #y: getuimodelvalue(var_f1cc2bf9)
  };
}

function function_f2b01a83() {
  return function_c63f7472(function_90d058e8(#"hash_39502e607f052b14"));
}

function function_f540dc93() {
  return function_c63f7472(function_90d058e8(#"hash_25c2b6d37ccf0023"));
}

function private function_c63f7472(model) {
  var_68abddbb = getuimodel(model, #"amount");
  return getuimodelvalue(var_68abddbb);
}