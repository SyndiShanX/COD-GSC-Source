/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spectate_view.csc
***********************************************/

#using script_13da4e6b98ca81a1;
#using script_544e81d6e48b88c0;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#namespace spectate_view;

function private autoexec __init__system__() {
  system::register(#"spectate_view", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::add_callback(#"territory", &function_59941838);
  callback::function_a880899e(&function_a880899e);
}

function private function_59941838(local_client_num, eventstruct) {
  namespace_99c84a33::function_bb3bbc2c("overhead_spectate_cam", 64);
}

function function_a880899e(eventparams) {
  localclientnum = eventparams.localclientnum;

  if(!codcaster::function_b8fe9b52(localclientnum)) {
    if(eventparams.enabled) {
      self codeplaypostfxbundle("pstfx_spawn_cam");
      return;
    }

    self codestoppostfxbundle("pstfx_spawn_cam");
  }
}