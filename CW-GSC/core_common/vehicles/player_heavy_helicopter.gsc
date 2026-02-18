/************************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_heavy_helicopter.gsc
************************************************************/

#using script_47d08d7129406c5a;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_heavy_helicopter;

function private autoexec __init__system__() {
  system::register(#"player_heavy_helicopter", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  clientfield::register("toplayer", "hind_gunner_postfx_active", 1, 1, "int");
  clientfield::register("vehicle", "hind_compass_icon", 1, 2, "int");
  vehicle::add_main_callback("helicopter_heavy", &function_8220feb0);
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_8f37f11);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &change_seat);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_1ec626d7);
}

function private function_8220feb0() {
  self.var_dc20225f = 1;
  self.var_7d3d0f72 = 2;
  namespace_c8fb02a7::function_a01726dd();
}

function function_8f37f11(params) {
  self endon(#"death");

  if(isalive(self)) {
    if(isDefined(params.player)) {
      enter_seat = params.eventstruct.seat_index;

      if(namespace_c8fb02a7::function_9ffa5fd(undefined, enter_seat)) {
        self function_6ffe1aa7(params.player, undefined, enter_seat);
      }
    }

    self thread function_912f52a1();
  }
}

function function_1ec626d7(params) {
  params.player clientfield::set_to_player("hind_gunner_postfx_active", 0);
  self thread function_912f52a1();
}

function change_seat(params) {
  self endon(#"death");

  if(isalive(self)) {
    if(isDefined(params.player)) {
      enter_seat = params.eventstruct.seat_index;
      exit_seat = params.eventstruct.old_seat_index;

      if(namespace_c8fb02a7::function_9ffa5fd(exit_seat, enter_seat)) {
        self function_6ffe1aa7(params.player, exit_seat, enter_seat);
      }
    }

    self thread function_912f52a1();
  }
}

function function_912f52a1() {
  self endon(#"death");
  self notify("7cabfd7760270dbb");
  self endon("7cabfd7760270dbb");
  owner = self getvehoccupants()[0];

  if(isDefined(owner)) {
    self clientfield::set("hind_compass_icon", 1);
    wait 2;
    self clientfield::set("hind_compass_icon", 2);
    return;
  }

  self clientfield::set("hind_compass_icon", 1);
  wait 2;
  self clientfield::set("hind_compass_icon", 0);
}

function function_6ffe1aa7(player, var_92eb9b7d, var_6d872cea) {
  if(!(var_92eb9b7d === 1 || var_6d872cea === 1)) {
    return;
  }

  tweentime = self function_ff1bf59c(var_92eb9b7d, var_6d872cea);
  wait tweentime;

  if(var_6d872cea === 1) {
    player clientfield::set_to_player("hind_gunner_postfx_active", 1);
    return;
  }

  if(var_92eb9b7d === 1) {
    player clientfield::set_to_player("hind_gunner_postfx_active", 0);
  }
}