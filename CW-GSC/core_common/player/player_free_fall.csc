/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_free_fall.csc
***************************************************/

#using script_7ca3324ffa5389e4;
#using scripts\core_common\animation_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace player_free_fall;

function private autoexec __init__system__() {
  system::register(#"player_free_fall", &preinit, undefined, undefined, undefined);
}

function private preinit() {}

function private function_c9a18304(eventstruct) {
  if(!(isPlayer(self) || self isplayercorpse())) {
    return;
  }

  if(self function_21c0fa55()) {}
}

function private function_26d46af3(eventstruct) {
  if(!(isPlayer(self) || self isplayercorpse())) {
    return;
  }

  if(self function_21c0fa55()) {}
}

function private function_f99c2453(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  if(self function_21c0fa55()) {}
}