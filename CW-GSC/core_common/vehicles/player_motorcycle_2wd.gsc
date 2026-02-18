/**********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_motorcycle_2wd.gsc
**********************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_motorcycle_2wd;

function private autoexec __init__system__() {
  system::register(#"player_motorcycle_2wd", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_motorcycle_2wd", &function_9835edf5);
}

function private function_9835edf5() {
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_d0a9a026);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_e1f72671);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_177abcbb);
  callback::function_d8abfc3d(#"hash_551381cffdc79048", &function_8ba31952);
  self.var_d6691161 = 200;
  self.var_5002d77c = 0.6;
  self.var_a195943 = 1;
  self vehicle::toggle_control_bone_group(1, 1);
  self player_vehicle::function_cc30c4bb(#"hash_22c22a196fd2cc77", 6);
}

function private function_e1f72671(params) {
  occupants = self getvehoccupants();

  if(!isDefined(occupants) || occupants.size == 0) {
    self notify(#"hash_7d134b21d3606f90");

    if(lengthsquared(self.velocity) > sqr(200)) {
      var_6ceae60 = (0, -5, 0);
      var_99d6b963 = rotatepoint(var_6ceae60, self.angles);
      var_63c1fd8 = (-25 + randomfloat(30), 0, -22 + randomfloat(5));
      self launchvehicle(var_99d6b963, var_63c1fd8, 1, 1);
    } else {
      self vehicle::toggle_control_bone_group(1, 1);
    }

    self notify(#"no_occupants");
    return;
  }

  if(isDefined(occupants) && occupants.size >= 0 && params.eventstruct.seat_index === 0) {
    function_164c8246();
  }
}

function private function_d0a9a026(params) {
  if(params.eventstruct.seat_index === 0) {
    function_8892a46e();
  }

  if(!isDefined(self.var_fbc196ab)) {
    self thread function_1f6bee9c();
  }
}

function function_177abcbb(params) {
  if(isalive(self)) {
    eventstruct = params.eventstruct;

    if(eventstruct.seat_index === 6 || eventstruct.old_seat_index === 6) {
      return;
    }

    if(eventstruct.seat_index === 0) {
      function_8892a46e();
      return;
    }

    function_164c8246();
  }
}

function private function_8892a46e() {
  self launchvehicle((0, 0, 0), (0, 0, 0), 0, 2);
  self vehicle::toggle_control_bone_group(1, 0);
  self notify(#"hash_7d134b21d3606f90");
}

function private function_164c8246() {
  if(lengthsquared(self.velocity) > sqr(200)) {
    self thread function_45cb4291();
    return;
  }

  self vehicle::toggle_control_bone_group(1, 1);
}

function private function_45cb4291() {
  self notify("5e6d62a7a17f26b6");
  self endon("5e6d62a7a17f26b6");
  self endon(#"death", #"hash_7d134b21d3606f90");

  while(true) {
    wait 1;

    if(isalive(self)) {
      if(lengthsquared(self.velocity) <= sqr(200)) {
        self vehicle::toggle_control_bone_group(1, 1);
        return;
      }

      continue;
    }

    return;
  }
}

function private function_8ba31952(params) {
  if(!isalive(self)) {
    return;
  }

  occupants = self getvehoccupants();

  if(!isDefined(occupants) || occupants.size == 0) {
    self launchvehicle((0, 0, 0), (0, 0, 0), 0, 1);
  }
}

function function_1f6bee9c() {
  self notify(#"hash_654356262621e15f");
  self endoncallback(&function_e972bd62, #"death", #"no_occupants", #"hash_654356262621e15f");
  self.var_fbc196ab = 1;

  while(true) {
    self waittill(#"veh_inair");
    time = gettime();
    self waittill(#"veh_landed");
    land_time = gettime();
    var_a56294c1 = land_time - time;

    if(var_a56294c1 < 800) {
      continue;
    }

    var_cf61b7dd = int(float(var_a56294c1 + 500) / 1000);
    occupants = self getvehoccupants();

    foreach(occupant in occupants) {
      if(!isPlayer(occupant)) {
        continue;
      }

      occupant stats::function_dad108fa(#"hash_2d553b0cd6606d50", var_cf61b7dd);
    }
  }
}

function function_e972bd62(str_notify) {
  if(!isalive(self)) {
    return;
  }

  self.var_fbc196ab = undefined;
}