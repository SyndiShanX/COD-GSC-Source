/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_truck_transport.gsc
***********************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_truck_transport;

function private autoexec __init__system__() {
  system::register(#"player_truck_transport", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_truck_transport", &function_3391a69f);
}

function private function_3391a69f() {
  self setmovingplatformenabled(1, 0);
  self.var_96c0f900 = [];
  self.var_96c0f900[1] = 1000;
  self.var_4ca92b57 = 30;
  self.var_57371c71 = 60;
  self.var_84fed14b = 40;
  self.var_d6691161 = 175;
  self.var_5d662124 = 2;
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &player_enter);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &player_exit);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_379a71bd);
  callback::function_d8abfc3d(#"hash_551381cffdc79048", &player_vehicle::function_948f0984);
  self vehicle::toggle_control_bone_group(1, 1);
  self thread player_vehicle::function_5bce3f3a(1, 1000);
}

function private function_135c137c(player) {
  if(!isDefined(self.var_9be5a571)) {
    self.var_9be5a571 = [];
  }

  if(!isDefined(self.var_3800be7e)) {
    self thread player_vehicle::function_53f7a11f(player);
  }
}

function private function_3a991b11() {
  if(!isDefined(self.var_3800be7e)) {
    self.overridevehicledamage = undefined;
  }
}

function private function_e2ade94b() {
  self vehicle::toggle_control_bone_group(1, 0);
}

function private function_86c4506d() {
  self vehicle::toggle_control_bone_group(1, 1);
}

function private player_enter(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(isDefined(eventstruct.seat_index)) {
    switch (eventstruct.seat_index) {
      case 0:
        self function_135c137c(player);
        break;
      case 1:
        self function_e2ade94b();
        break;
    }
  }
}

function private player_exit(params) {
  eventstruct = params.eventstruct;
  player = params.player;

  if(isDefined(eventstruct.seat_index)) {
    switch (eventstruct.seat_index) {
      case 0:
        self function_3a991b11();
        break;
      case 1:
        self function_86c4506d();
        break;
    }
  }
}

function private function_379a71bd(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(isDefined(eventstruct.seat_index)) {
    switch (eventstruct.seat_index) {
      case 0:
        self function_135c137c(player);
        break;
      case 1:
        self function_e2ade94b();
        break;
    }
  }

  if(isDefined(eventstruct.old_seat_index)) {
    switch (eventstruct.old_seat_index) {
      case 0:
        self function_3a991b11();
        break;
      case 1:
        self function_86c4506d();
        break;
    }
  }
}