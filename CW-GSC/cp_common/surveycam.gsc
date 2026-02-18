/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\surveycam.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_4937c6974f43bb71;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace surveycam;

function private autoexec __init__system__() {
  system::register(#"surveycam", &_preload, undefined, undefined, undefined);
}

function private _preload() {
  function_bc948200();
}

function private function_bc948200() {
  clientfield::register("toplayer", "surveycam_state", 1, 1, "int");
  clientfield::register("toplayer", "surveycam_min_focal_length", 1, 6, "int");
  clientfield::register("toplayer", "surveycam_max_focal_length", 1, 6, "int");
}

function function_87b9c1ef(var_27169374 = 25, var_25c457e2 = 60) {
  if(is_true(level.var_5be43b2d)) {
    return;
  }

  level.player = isDefined(level.player) ? level.player : getplayers()[0];

  if(!namespace_61e6d095::exists(#"hash_71351bf35e6d6353")) {
    namespace_61e6d095::create(#"hash_71351bf35e6d6353", #"surveycam");
  }

  namespace_82bfe441::fade(1, "FadeImmediate");
  level.player clientfield::set_to_player("surveycam_min_focal_length", var_27169374);
  level.player clientfield::set_to_player("surveycam_max_focal_length", var_25c457e2);
  namespace_61e6d095::function_9ade1d9b(#"hash_71351bf35e6d6353", "pitch", 0);
  namespace_61e6d095::function_9ade1d9b(#"hash_71351bf35e6d6353", "yaw", 0);
  namespace_61e6d095::function_9ade1d9b(#"hash_71351bf35e6d6353", "zoom", 1);
  level.player clientfield::set_to_player("surveycam_state", 1);
}

function function_56d93dca(var_67df10fb = 1) {
  self notify("6a61dd7e08b958be");
  self endon("6a61dd7e08b958be");

  if(var_67df10fb >= float(function_60d95f53()) / 1000) {
    wait var_67df10fb;
  }

  if(namespace_61e6d095::exists(#"hash_71351bf35e6d6353")) {
    namespace_61e6d095::function_9ade1d9b(#"hash_71351bf35e6d6353", "camera_fade_out_time", var_67df10fb);
  }

  if(var_67df10fb > 0) {
    wait 2;
  }

  if(namespace_61e6d095::exists(#"hash_71351bf35e6d6353")) {
    namespace_61e6d095::remove(#"hash_71351bf35e6d6353");
  }

  namespace_82bfe441::fade(0, "FadeMedium");
  level.player clientfield::set_to_player("surveycam_state", 0);
}