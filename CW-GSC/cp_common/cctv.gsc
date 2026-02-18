/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\cctv.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_35ae72be7b4fec10;
#using script_4937c6974f43bb71;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace cctv;

function private autoexec __init__system__() {
  system::register(#"cctv", &_preload, undefined, undefined, undefined);
}

function private _preload() {
  function_bc948200();
}

function private function_bc948200() {
  clientfield::register("toplayer", "cctv_postfx", 1, 1, "int");
  clientfield::register("toplayer", "cull_outside_nuke_room", 1, 1, "int");
}

function function_c238a64a(var_d7eb0053, var_cfa5cedf, var_de721607, var_1aebd615, var_dd3b452) {
  level.player = isDefined(level.player) ? level.player : getplayers()[0];

  if(!namespace_61e6d095::exists(#"hash_48087cf592ac15d8")) {
    namespace_61e6d095::create(#"hash_48087cf592ac15d8", #"cctv");
  }

  namespace_82bfe441::fade(1, "FadeImmediate");

  if(!isDefined(var_d7eb0053)) {
    var_d7eb0053 = # "";
  }

  if(!isDefined(var_cfa5cedf)) {
    var_cfa5cedf = # "";
  }

  if(!isDefined(var_de721607)) {
    var_de721607 = # "";
  }

  if(!isDefined(var_1aebd615)) {
    var_1aebd615 = 0;
  }

  if(!isDefined(var_dd3b452)) {
    var_dd3b452 = 1;
  }

  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_name", var_d7eb0053);
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_location", var_cfa5cedf);
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_date", var_de721607);
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_timer_start", var_1aebd615);
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_zoom", var_dd3b452);
  level.player clientfield::set_to_player("cctv_postfx", 1);
  namespace_c8e236da::removelist();
  namespace_c8e236da::function_ebf737f8(#"hash_4d41512a9dd19c05");
  namespace_c8e236da::function_ebf737f8(#"hash_69591e6984149ba7");
  namespace_c8e236da::function_ebf737f8(#"hash_4e10d70903ef5630");
}

function function_bd2b7003(var_6acccd9c = # "", var_7a6d5da7 = # "") {
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_name", var_6acccd9c);
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_location", var_7a6d5da7);
}

function function_6e6cbceb(var_862f0a8a = # "", var_d3e70c7c = 0) {
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_date", var_862f0a8a);
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_timer_start", var_d3e70c7c);
}

function function_b0adb9ba(var_5bb68104) {
  namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_zoom", var_5bb68104);
}

function function_173bb173(var_67df10fb = 1) {
  level.player clientfield::set_to_player("cctv_postfx", 0);
  self notify("210cf6bbc1fd890d");
  self endon("210cf6bbc1fd890d");

  if(var_67df10fb >= float(function_60d95f53()) / 1000) {
    wait var_67df10fb;
  }

  if(namespace_61e6d095::exists(#"hash_48087cf592ac15d8")) {
    namespace_61e6d095::function_9ade1d9b(#"hash_48087cf592ac15d8", "camera_fade_out_time", var_67df10fb);
  }

  if(var_67df10fb > 0) {
    wait 2;
  }

  if(namespace_61e6d095::exists(#"hash_48087cf592ac15d8")) {
    namespace_61e6d095::remove(#"hash_48087cf592ac15d8");
  }

  namespace_c8e236da::removelist();
  namespace_82bfe441::fade(0, "FadeMedium");
  level.player clientfield::set_to_player("cull_outside_nuke_room", 0);
}