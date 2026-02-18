/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_uaz.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_uaz;

function private autoexec __init__system__() {
  system::register(#"player_uaz", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_uaz", &function_bc02ac38);
}

function private function_bc02ac38() {
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_5433bc44);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_b6eaa74f);
  self.var_84fed14b = 40;
  self.var_d6691161 = 175;
  self.var_5d662124 = 2;
}

function function_5433bc44(params) {
  player = params.player;

  if(!isDefined(player)) {
    return;
  }
}

function function_b6eaa74f(params) {
  player = params.player;

  if(!isDefined(player)) {
    return;
  }

  if(!isalive(self)) {
    return;
  }
}