/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicleriders_shared.gsc
************************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace vehicle;

class class_358332cc {
  var riders;
  var var_3acc1a95;
  var var_4301b21d;
  var var_709c0a6f;
  var var_9e2a2132;
  var var_dad0959b;

  constructor() {
    riders = [];
    var_4301b21d = 0;
    var_3acc1a95 = 0;
    var_9e2a2132 = 0;
    var_709c0a6f = 0;
    var_dad0959b = 0;
  }

}

autoexec init() {
  function_d64f1d30();
  callback::on_vehicle_spawned(&on_vehicle_spawned);
  callback::on_vehicle_killed(&on_vehicle_killed);
}

private function_d64f1d30() {
  a_registered_fields = [];

  foreach(bundle in struct::get_script_bundles("vehicleriders")) {
    foreach(object in bundle.objects) {
      if(isDefined(object.vehicleenteranim)) {
        array::add(a_registered_fields, object.position + "_enter", 0);
      }

      if(isDefined(object.vehicleexitanim)) {
        array::add(a_registered_fields, object.position + "_exit", 0);
      }

      if(isDefined(object.vehiclecloseanim)) {
        array::add(a_registered_fields, object.position + "_close", 0);
      }

      if(isDefined(object.vehicleriderdeathanim)) {
        array::add(a_registered_fields, object.position + "_death", 0);
      }
    }
  }

  foreach(str_clientfield in a_registered_fields) {
    clientfield::register("vehicle", str_clientfield, 1, 1, "counter");
  }
}

function_196797c9(vehicle) {
  assert(isvehicle(vehicle));

  if(isDefined(vehicle.vehicleridersbundle)) {
    return true;
  }

  return false;
}

private function_810a3de5(vehicle) {}

private function_41cf7b1d(vehicle) {
  assert(isvehicle(vehicle));
  var_4301b21d = function_999240f5(vehicle);
  bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);

  for(seat = 0; seat < var_4301b21d; seat++) {
    position = bundle.objects[seat].position;

    if(issubstr(position, "driver")) {
      return true;
    }
  }

  return false;
}

private function_f7ce77b(vehicle) {
  assert(isvehicle(vehicle));
  var_4301b21d = function_999240f5(vehicle);
  bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);

  for(seat = 0; seat < var_4301b21d; seat++) {
    position = bundle.objects[seat].position;

    if(position == "passenger1") {
      return true;
    }
  }

  return false;
}

private function_2453a4a2(vehicle) {
  assert(isvehicle(vehicle));
  var_4301b21d = function_999240f5(vehicle);
  bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);

  for(seat = 0; seat < var_4301b21d; seat++) {
    position = bundle.objects[seat].position;

    if(position == "gunner1") {
      return true;
    }
  }

  return false;
}

private function_72b503cc(vehicle) {
  assert(isvehicle(vehicle));
  var_4301b21d = function_999240f5(vehicle);
  var_3acc1a95 = 0;
  bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);

  for(seat = 0; seat < var_4301b21d; seat++) {
    position = bundle.objects[seat].position;

    if(issubstr(position, "crew")) {
      var_3acc1a95++;
    }
  }

  return var_3acc1a95;
}

function_999240f5(vehicle) {
  assert(isvehicle(vehicle));

  if(!function_196797c9(vehicle)) {
    return 0;
  }

  assert(isDefined(vehicle.vehicleridersbundle));
  var_4301b21d = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle).var_4301b21d;

  if(isDefined(var_4301b21d)) {
    return var_4301b21d;
  }

  return 0;
}

private on_vehicle_spawned() {
  assert(isvehicle(self));

  if(!function_196797c9(self)) {
    return;
  }

  function_810a3de5(self);
  var_4301b21d = function_999240f5(self);

  if(!isDefined(var_4301b21d) || var_4301b21d <= 0) {
    return;
  }

  self.var_761c973 = new class_358332cc();
  self.var_761c973.riders = [];
  self.var_761c973.var_4301b21d = var_4301b21d;
  self flag::init("driver_occupied", 0);
  self flag::init("passenger1_occupied", 0);
  self flag::init("gunner1_occupied", 0);

  if(function_41cf7b1d(self)) {
    self.var_761c973.var_9e2a2132 = 1;
  }

  if(function_f7ce77b(self)) {
    self.var_761c973.var_709c0a6f = 1;
  }

  if(function_2453a4a2(self)) {
    self.var_761c973.var_dad0959b = 1;
  }

  var_3acc1a95 = function_72b503cc(self);
  self.var_761c973.var_3acc1a95 = var_3acc1a95;

  for(position = 1; position <= 9; position++) {
    flag::init("crew" + position + "_occupied", 0);
  }

  if(isDefined(self.script_vehicleride)) {
    a_spawners = getactorspawnerarray(self.script_vehicleride, "script_vehicleride");

    foreach(sp in a_spawners) {
      if(isDefined(sp)) {
        if(self.spawner !== sp) {
          ai_rider = sp spawner::spawn(1);

          if(isDefined(ai_rider)) {
            seat = undefined;

            if(isDefined(ai_rider.script_startingposition) && ai_rider.script_startingposition != "undefined") {
              seat = ai_rider.script_startingposition;

              if(issubstr(seat, "crew")) {
                seat = "crew";
              } else if(issubstr(seat, "pass")) {
                seat = "passenger1";
              } else if(issubstr(seat, "driver")) {
                seat = "driver";
              } else {
                seat = undefined;
              }

              if(isDefined(seat)) {
                ai_rider get_in(ai_rider, self, seat, 1);
              }

              continue;
            }

            ai_rider get_in(ai_rider, self, undefined, 1);
          }
        }
      }
    }
  }
}

private function_e1008fbd(vehicle) {
  assert(isDefined(vehicle));
  assert(isDefined(vehicle.var_761c973));
  assert(isDefined(vehicle.var_761c973.var_3acc1a95));

  for(position = 1; position <= vehicle.var_761c973.var_3acc1a95; position++) {
    if(!vehicle flag::get("crew" + position + "_occupied")) {
      return ("crew" + position);
    }
  }

  return "none";
}

private function_2cec1af6(vehicle, seat) {
  flag = seat + "_occupied";
  assert(vehicle flag::exists(flag));
  assert(!vehicle flag::get(flag));
  vehicle flag::set(flag);
}

private function_2e28cc0(vehicle, seat) {
  flag = seat + "_occupied";
  assert(vehicle flag::exists(flag));
  assert(!vehicle flag::get(flag));
  vehicle flag::clear(flag);
}

get_human_bundle(assertifneeded = 1) {
  if(assertifneeded) {
    assert(isDefined(self.vehicleridersbundle), "<dev string:x38>");
  }

  return struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
}

get_robot_bundle(assertifneeded = 1) {
  if(assertifneeded) {
    assert(isDefined(self.vehicleridersrobotbundle), "<dev string:x8b>");
  }

  return struct::get_script_bundle("vehicleriders", self.vehicleridersrobotbundle);
}

get_warlord_bundle(assertifneeded = 1) {
  if(assertifneeded) {
    assert(isDefined(self.vehicleriderswarlordbundle), "<dev string:xe4>");
  }

  return struct::get_script_bundle("vehicleriders", self.vehicleriderswarlordbundle);
}

private function_e84837df(ai, vehicle) {
  assert(isactor(ai));
  assert(isDefined(ai.archetype));
  assert(function_196797c9(vehicle));

  if(ai.archetype == #"robot") {
    return vehicle get_robot_bundle();
  }

  if(ai.archetype == #"warlord") {
    return vehicle get_warlord_bundle();
  }

  assert(ai.archetype == #"human", "<dev string:x13f>" + ai.archetype);
  return vehicle get_human_bundle();
}

function_b9342b7d(ai, vehicle, seat) {
  assert(isactor(ai));
  bundle = undefined;
  bundle = vehicle function_e84837df(ai, vehicle);

  foreach(s_rider in bundle.objects) {
    if(s_rider.position == seat) {
      return s_rider;
    }
  }
}

private init_rider(ai, vehicle, seat) {
  assert(isDefined(vehicle));
  assert(isactor(ai));
  assert(!isDefined(ai.var_ec30f5da));
  ai.var_ec30f5da = function_b9342b7d(ai, vehicle, seat);
  ai.vehicle = vehicle;
  ai.var_5574287b = seat;

  if(isDefined(ai.var_ec30f5da.rideanim) && !isanimlooping(ai.var_ec30f5da.rideanim)) {
    assertmsg("<dev string:x174>" + seat + "<dev string:x199>" + function_9e72a96(ai.vehicle.vehicletype) + "<dev string:x1a9>");
  }

  if(isDefined(ai.var_ec30f5da.aligntag) && !isDefined(ai.vehicle gettagorigin(ai.var_ec30f5da.aligntag))) {
    assertmsg("<dev string:x174>" + seat + "<dev string:x199>" + function_9e72a96(ai.vehicle.vehicletype) + "<dev string:x1c4>" + ai.var_ec30f5da.aligntag + "<dev string:x1d9>");
  }

  ai flag::init("in_vehicle");
  ai flag::init("riding_vehicle");
}

fill_riders(a_ai, vehicle, seat) {
  assert(isvehicle(vehicle));

  if(!function_196797c9(vehicle)) {
    assertmsg("<dev string:x1de>" + function_9e72a96(vehicle.vehicletype) + "<dev string:x1f1>");
    return;
  }

  if(isDefined(seat)) {
    assert(seat == "<dev string:x216>" || seat == "<dev string:x21f>" || seat == "<dev string:x22c>");
  } else {
    seat = "all";
  }

  if(!isalive(vehicle)) {
    return;
  }

  a_ai_remaining = arraycopy(a_ai);

  switch (seat) {
    case #"driver":
      if(get_in(a_ai[0], vehicle, "driver", 0)) {
        arrayremovevalue(a_ai_remaining, a_ai[0]);
      }

      break;
    case #"passenger1":
      if(get_in(a_ai[0], vehicle, "passenger1", 0)) {
        arrayremovevalue(a_ai_remaining, a_ai[0]);
      }

      break;
    case #"gunner1":
      if(get_in(a_ai[0], vehicle, "gunner1", 0)) {
        arrayremovevalue(a_ai_remaining, a_ai[0]);
      }

      break;
    case #"crew":
      foreach(ai in a_ai) {
        if(get_in(ai, vehicle, "crew", 0)) {
          arrayremovevalue(a_ai_remaining, ai);
        }
      }

      break;
    case #"all":
      index = 0;

      if(get_in(a_ai[index], vehicle, "driver", 0)) {
        arrayremovevalue(a_ai_remaining, a_ai[index]);
        index++;
      }

      if(get_in(a_ai[index], vehicle, "passenger1", 0)) {
        arrayremovevalue(a_ai_remaining, a_ai[index]);
        index++;
      }

      for(i = index; i < a_ai.size; i++) {
        if(get_in(a_ai[index], vehicle, "crew", 0)) {
          arrayremovevalue(a_ai_remaining, a_ai[index]);
          index++;
        }
      }

      if(get_in(a_ai[index], vehicle, "gunner1", 0)) {
        arrayremovevalue(a_ai_remaining, a_ai[index]);
      }

      break;
  }

  return a_ai_remaining;
}

unload(seat) {
  assert(isvehicle(self));

  if(!function_196797c9(self)) {
    assertmsg("<dev string:x1de>" + function_9e72a96(self.vehicletype) + "<dev string:x1f1>");
    return;
  }

  if(isDefined(seat) && seat != "undefined") {
    if(seat == "passengers") {
      seat = "passenger1";
    } else if(seat == "gunners") {
      seat = "gunner1";
    }

    assert(seat == "<dev string:x216>" || seat == "<dev string:x21f>" || seat == "<dev string:x22c>" || seat == "<dev string:x233>" || seat == "<dev string:x23d>");
  } else {
    seat = "all";
  }

  if(!isDefined(self.var_761c973.riders)) {
    return;
  }

  self.var_761c973.riders = array::remove_undefined(self.var_761c973.riders, 1);

  if(self.var_761c973.riders.size <= 0) {
    return;
  }

  var_4301b21d = self.var_761c973.var_4301b21d;
  assert(var_4301b21d > 0);

  switch (seat) {
    case #"driver":
      function_114d7bd3(self);
      break;
    case #"passenger1":
      function_b56639f2(self);
      break;
    case #"gunner1":
      function_2ef91b74(self);
      break;
    case #"crew":
      function_2ca26543(self);
      break;
    default:
      function_114d7bd3(self);
      function_b56639f2(self);
      function_2ca26543(self);
      function_2ef91b74(self);
      break;
  }
}

private function_114d7bd3(vehicle) {
  if(!vehicle.var_761c973.var_9e2a2132) {
    return;
  }

  if(vehicle flag::get("driver_occupied") && isDefined(vehicle.var_761c973.riders[#"driver"]) && isalive(vehicle.var_761c973.riders[#"driver"])) {
    ai = vehicle.var_761c973.riders[#"driver"];
    assert(ai flag::get("<dev string:x243>"));
    closeanim = undefined;

    if(isDefined(ai.var_ec30f5da.vehiclecloseanim)) {
      closeanim = ai.var_ec30f5da.vehiclecloseanim;
    }

    ai get_out(vehicle, ai, "driver");

    if(isDefined(closeanim) && isDefined(vehicle)) {
      vehicle clientfield::increment("driver" + "_close", 1);
      vehicle setanim(closeanim, 1, 0, 1);
    }
  }
}

private function_b56639f2(vehicle) {
  if(!vehicle.var_761c973.var_709c0a6f) {
    return;
  }

  if(vehicle flag::get("passenger1_occupied") && isDefined(vehicle.var_761c973.riders[#"passenger1"]) && isalive(vehicle.var_761c973.riders[#"passenger1"])) {
    ai = vehicle.var_761c973.riders[#"passenger1"];
    assert(ai flag::get("<dev string:x243>"));
    closeanim = undefined;

    if(isDefined(ai.var_ec30f5da.vehiclecloseanim)) {
      closeanim = ai.var_ec30f5da.vehiclecloseanim;
    }

    ai get_out(vehicle, ai, "passenger1");

    if(isDefined(closeanim) && isDefined(vehicle)) {
      vehicle clientfield::increment("passenger1" + "_close", 1);
      vehicle setanim(closeanim, 1, 0, 1);
    }
  }
}

private function_2ef91b74(vehicle) {
  if(!vehicle.var_761c973.var_dad0959b) {
    return;
  }

  if(vehicle flag::get("gunner1_occupied") && isDefined(vehicle.var_761c973.riders[#"gunner1"]) && isalive(vehicle.var_761c973.riders[#"gunner1"])) {
    ai = vehicle.var_761c973.riders[#"gunner1"];
    assert(ai flag::get("<dev string:x243>"));
    closeanim = undefined;

    if(isDefined(ai.var_ec30f5da.vehiclecloseanim)) {
      closeanim = ai.var_ec30f5da.vehiclecloseanim;
    }

    ai get_out(vehicle, ai, "gunner1");

    if(isDefined(closeanim) && isDefined(vehicle)) {
      vehicle clientfield::increment("gunner1" + "_close", 1);
      vehicle setanim(closeanim, 1, 0, 1);
    }
  }
}

private function_2ca26543(vehicle) {
  assert(isDefined(vehicle.var_761c973.var_4301b21d) && vehicle.var_761c973.var_4301b21d > 0);

  if(!isDefined(vehicle.var_761c973.var_3acc1a95)) {
    return;
  }

  if(vehicle.var_761c973.var_3acc1a95 <= 0) {
    return;
  }

  var_681d39ad = [];
  var_91b346cc = undefined;
  n_crew_door_close_position = undefined;

  for(position = 1; position <= vehicle.var_761c973.var_3acc1a95; position++) {
    seat = "crew" + position;
    flag = seat + "_occupied";

    if(vehicle flag::get(flag) && isDefined(vehicle.var_761c973.riders[seat]) && isalive(vehicle.var_761c973.riders[seat])) {
      ai = vehicle.var_761c973.riders[seat];
      assert(ai flag::get("<dev string:x243>"));

      if(!isDefined(var_91b346cc)) {
        if(isDefined(ai.var_ec30f5da.vehiclecloseanim)) {
          n_crew_door_close_position = seat;
          var_91b346cc = ai.var_ec30f5da.vehiclecloseanim;
        }
      }

      ai thread get_out(vehicle, vehicle.var_761c973.riders[seat], seat);
      array::add(var_681d39ad, ai);
    }
  }

  if(var_681d39ad.size > 0) {
    timeout = vehicle.unloadtimeout;
    array::wait_till(var_681d39ad, "exited_vehicle");
    array::flagsys_wait_clear(var_681d39ad, "in_vehicle", isDefined(timeout) ? timeout : 4);

    if(isDefined(vehicle)) {
      vehicle notify(#"unload", var_681d39ad);
      vehicle remove_riders_after_wait(vehicle, var_681d39ad);
    }
  }

  if(isDefined(var_91b346cc) && isDefined(vehicle)) {
    vehicle clientfield::increment(n_crew_door_close_position + "_close", 1);
    vehicle setanim(var_91b346cc, 1, 0, 1);
  }
}

get_out(vehicle, ai, seat) {
  assert(isDefined(ai));
  assert(isalive(ai), "<dev string:x250>");
  assert(isactor(ai), "<dev string:x273>");
  assert(isDefined(ai.vehicle), "<dev string:x2aa>");
  assert(isDefined(ai.var_ec30f5da));
  assert(seat == "<dev string:x216>" || seat == "<dev string:x21f>" || issubstr(seat, "<dev string:x22c>") || seat == "<dev string:x233>");
  ai notify(#"exiting_vehicle");

  if(isDefined(ai.var_ec30f5da.vehicleexitanim)) {
    ai.vehicle clientfield::increment(ai.var_ec30f5da.position + "_exit", 1);
    ai.vehicle setanim(ai.var_ec30f5da.vehicleexitanim, 1, 0, 1);
  }

  if(isDefined(vehicle) && isalive(vehicle)) {
    switch (seat) {
      case #"driver":
        vehicle flag::clear("driver_occupied");
        break;
      case #"passenger1":
        vehicle flag::clear("passenger1_occupied");
        break;
      case #"gunner1":
        vehicle flag::clear("gunner1_occupied");
        break;
      case #"crew":
        seat = "crew" + seat;
        flag = seat + "_occupied";
        vehicle flag::clear(flag);
        break;
    }
  }

  str_mode = "ground";

  if(vehicle.vehicleclass === "helicopter") {
    str_mode = "variable";
  }

  switch (str_mode) {
    case #"ground":
      exit_ground(ai);
      break;
    case #"variable":
      exit_variable(ai);
      break;
    default:
      assertmsg("<dev string:x2c2>");
      return;
  }

  if(isDefined(ai)) {
    ai flag::clear("in_vehicle");
    ai flag::clear("riding_vehicle");
    ai.vehicle = undefined;
    ai.var_ec30f5da = undefined;
    ai animation::set_death_anim(undefined);
    ai notify(#"exited_vehicle");
  }
}

exit_ground(ai) {
  assert(isDefined(ai));
  ai endon(#"death");

  if(!isDefined(self.var_ec30f5da.exitgrounddeathanim)) {
    ai thread ragdoll_dead_exit_rider(ai);
  } else {
    ai animation::set_death_anim(ai.var_ec30f5da.exitgrounddeathanim);
  }

  assert(isDefined(ai.var_ec30f5da.exitgroundanim), "<dev string:x2e4>" + ai.var_ec30f5da.position + "<dev string:x2fe>");

  if(isDefined(ai.var_ec30f5da.exitgroundanim)) {
    animation::play(ai.var_ec30f5da.exitgroundanim, ai.vehicle, ai.var_ec30f5da.aligntag);
  }
}

remove_riders_after_wait(vehicle, a_riders_to_remove) {
  assert(isDefined(vehicle) && isDefined(a_riders_to_remove));
  assert(isDefined(vehicle.var_761c973.riders));

  if(isDefined(a_riders_to_remove)) {
    foreach(ai in a_riders_to_remove) {
      arrayremovevalue(vehicle.var_761c973.riders, ai, 1);
    }
  }
}

private handle_falling_death() {
  self endon(#"landed");
  self waittill(#"death");

  if(isactor(self)) {
    self unlink();
    self startragdoll();
  }
}

ragdoll_dead_exit_rider(ai) {
  assert(isactor(ai));
  ai endon(#"exited_vehicle");
  ai waittill(#"death");

  if(isDefined(ai) && !ai isragdoll()) {
    ai unlink();
    ai startragdoll();
  }

  ai notify(#"exited_vehicle");
}

private forward_euler_integration(e_move, v_target_landing, n_initial_speed) {
  landed = 0;
  position = self.origin;
  velocity = (0, 0, n_initial_speed * -1);
  gravity = (0, 0, -385.8);

  while(!landed) {
    previousposition = position;
    velocity += gravity * 0.1;
    position += velocity * 0.1;

    if(position[2] + velocity[2] * 0.1 <= v_target_landing[2]) {
      landed = 1;
      position = v_target_landing;
    }

    recordline(previousposition, position, (1, 0.5, 0), "<dev string:x321>", self);

    hostmigration::waittillhostmigrationdone();
    e_move moveto(position, 0.1);

    if(!landed) {
      wait 0.1;
    }
  }
}

exit_variable(ai) {
  assert(isDefined(ai));
  ai endon(#"death");
  ai notify(#"exiting_vehicle");
  ai thread handle_falling_death();
  ai animation::set_death_anim(ai.var_ec30f5da.exithighdeathanim);
  assert(isDefined(ai.var_ec30f5da.exithighanim), "<dev string:x2e4>" + ai.var_ec30f5da.position + "<dev string:x2fe>");
  animation::play(ai.var_ec30f5da.exithighanim, ai.vehicle, ai.var_ec30f5da.aligntag, 1, 0, 0);
  ai animation::set_death_anim(ai.var_ec30f5da.exithighloopdeathanim);
  n_cur_height = get_height(ai.vehicle);
  bundle = ai.vehicle function_e84837df(ai, ai.vehicle);
  n_target_height = bundle.highexitlandheight;

  if(isDefined(ai.var_ec30f5da.dropundervehicleorigin) && ai.var_ec30f5da.dropundervehicleorigin || isDefined(ai.dropundervehicleoriginoverride) && ai.dropundervehicleoriginoverride) {
    v_target_landing = (ai.vehicle.origin[0], ai.vehicle.origin[1], ai.origin[2] - n_cur_height + n_target_height);
  } else {
    v_target_landing = (ai.origin[0], ai.origin[1], ai.origin[2] - n_cur_height + n_target_height);
  }

  if(isDefined(ai.overridedropposition)) {
    v_target_landing = (ai.overridedropposition[0], ai.overridedropposition[1], v_target_landing[2]);
  }

  if(isDefined(ai.targetangles)) {
    angles = ai.targetangles;
  } else {
    angles = ai.angles;
  }

  e_move = util::spawn_model("tag_origin", ai.origin, angles);
  ai thread exit_high_loop_anim(e_move);
  distance = n_target_height - n_cur_height;
  initialspeed = bundle.dropspeed;
  n_fall_time = (initialspeed * -1 + sqrt(pow(initialspeed, 2) - 2 * 385.8 * distance)) / 385.8;
  ai notify(#"falling", {
    #fall_time: n_fall_time
  });
  forward_euler_integration(e_move, v_target_landing, bundle.dropspeed);
  e_move waittill(#"movedone");
  ai notify(#"landing");
  ai animation::set_death_anim(ai.var_ec30f5da.exithighlanddeathanim);
  animation::play(ai.var_ec30f5da.exithighlandanim, e_move, "tag_origin");
  ai notify(#"landed");
  ai unlink();
  waitframe(1);
  e_move delete();
  ai notify(#"exited_vehicle");
}

exit_high_loop_anim(e_parent) {
  self endon(#"death", #"landing");

  while(true) {
    animation::play(self.var_ec30f5da.exithighloopanim, e_parent, "tag_origin");
  }
}

get_height(e_ignore = self) {
  trace = groundtrace(self.origin + (0, 0, 10), self.origin + (0, 0, -10000), 0, e_ignore, 0);

  recordline(self.origin + (0, 0, 10), trace[#"position"], (1, 0.5, 0), "<dev string:x321>", self);

  return distance(self.origin, trace[#"position"]);
}

get_in(ai, vehicle, seat, var_7c3e4d44 = 1) {
  vehicle endon(#"death");

  if(!isDefined(ai)) {
    return 0;
  }

  if(!isDefined(seat) || seat == "undefined") {
    if(vehicle.var_761c973.var_9e2a2132 && !vehicle flag::get("driver_occupied")) {
      seat = "driver";
    } else if(vehicle.var_761c973.var_709c0a6f && !vehicle flag::get("passenger1_occupied")) {
      seat = "passenger1";
    } else {
      seat = "crew";
    }
  }

  assert(isactor(ai));
  assert(isDefined(seat) && (seat == "<dev string:x216>" || seat == "<dev string:x21f>" || seat == "<dev string:x22c>"));

  switch (seat) {
    case #"driver":
      if(vehicle.var_761c973.var_9e2a2132 && vehicle flag::get("driver_occupied")) {
        if(var_7c3e4d44) {
          assertmsg("<dev string:x32e>" + function_9e72a96(vehicle.vehicletype) + "<dev string:x355>");
        }

        return 0;
      }

      init_rider(ai, vehicle, "driver");
      break;
    case #"passenger1":
      if(vehicle.var_761c973.var_709c0a6f && vehicle flag::get("passenger1_occupied")) {
        if(var_7c3e4d44) {
          assertmsg("<dev string:x381>" + function_9e72a96(vehicle.vehicletype) + "<dev string:x3ab>");
        }

        return 0;
      }

      init_rider(ai, vehicle, "passenger1");
      break;
    case #"gunner1":
      if(vehicle.var_761c973.var_dad0959b && vehicle flag::get("gunner1_occupied")) {
        if(var_7c3e4d44) {
          assertmsg("<dev string:x3da>" + function_9e72a96(vehicle.vehicletype) + "<dev string:x401>");
        }

        return 0;
      }

      init_rider(ai, vehicle, "gunner1");
      break;
    default:
      var_b11e7fca = function_e1008fbd(vehicle);

      if(var_b11e7fca == "none") {
        if(var_7c3e4d44) {
          assertmsg("<dev string:x42d>" + function_9e72a96(vehicle.vehicletype) + "<dev string:x452>");
        }

        return 0;
      }

      init_rider(ai, vehicle, var_b11e7fca);
      seat = var_b11e7fca;
      break;
  }

  assert(isDefined(ai.var_ec30f5da));
  assert(isDefined(ai.vehicle));

  if(!isDefined(ai.var_ec30f5da.rideanim)) {
    assertmsg("<dev string:x48f>" + seat + "<dev string:x199>" + function_9e72a96(vehicle.vehicletype) + "<dev string:x4b2>" + function_e84837df(ai, vehicle));
    return;
  }

  assert(isDefined(vehicle.var_761c973.riders));
  assert(!isDefined(vehicle.var_761c973.riders[seat]));
  vehicle.var_761c973.riders[seat] = ai;

  if(seat != "none") {
    function_2cec1af6(vehicle, seat);
  }

  ai flag::set("in_vehicle");
  ai flag::set("riding_vehicle");
  ai thread animation::play(ai.var_ec30f5da.rideanim, ai.vehicle, ai.var_ec30f5da.aligntag, 1, 0.2, 0.2, 0, 0, 0, 0);
  ai thread handle_rider_death(ai, vehicle);
  return 1;
}

private handle_rider_death(ai, vehicle) {
  ai endon(#"death", #"exiting_vehicle");
  vehicle endon(#"death");
  assert(isDefined(ai.var_ec30f5da));

  if(isDefined(ai.var_ec30f5da.ridedeathanim)) {
    ai animation::set_death_anim(ai.var_ec30f5da.ridedeathanim);
  }

  callback::on_ai_killed(&function_15dbe5e9);
}

private function_15dbe5e9(params) {
  if(self flag::exists("riding_vehicle") && self flag::get("riding_vehicle") && isDefined(self.vehicle) && isDefined(self.var_ec30f5da) && isDefined(self.var_ec30f5da.vehicleriderdeathanim)) {
    self.vehicle clientfield::increment(self.var_ec30f5da.position + "_death", 1);
    self.vehicle setanimknobrestart(self.var_ec30f5da.vehicleriderdeathanim, 1, 0, 1);
  }
}

private on_vehicle_killed() {
  if(!isDefined(self.var_761c973)) {
    return;
  }

  if(!isDefined(self.var_761c973.riders)) {
    return;
  }

  foreach(rider in self.var_761c973.riders) {
    kill_rider(rider);
  }
}

kill_rider(entity) {
  if(isDefined(entity)) {
    if(isalive(entity) && !gibserverutils::isgibbed(entity, 2)) {
      if(entity isplayinganimscripted()) {
        entity stopanimscripted();
      }

      if(getdvarint(#"tu1_vehicleridersinvincibility", 1)) {
        util::stop_magic_bullet_shield(entity);
      }

      gibserverutils::gibleftarm(entity);
      gibserverutils::gibrightarm(entity);
      gibserverutils::giblegs(entity);
      gibserverutils::annihilate(entity);
      entity unlink();
      entity kill();
    }

    entity ghost();
    level thread delete_rider_asap(entity);
  }
}

delete_rider_asap(entity) {
  waitframe(1);

  if(isDefined(entity)) {
    entity delete();
  }
}

function_86c7bebb(seat = "all") {
  assert(isDefined(self) && isvehicle(self) && isDefined(seat));
  ais = [];

  if(!isDefined(self.var_761c973)) {
    return ais;
  }

  if(!isDefined(self.var_761c973.riders)) {
    return ais;
  }

  if(isDefined(seat)) {
    if(seat == "passengers") {
      seat = "passenger1";
    } else if(seat == "gunners") {
      seat = "gunner1";
    }

    assert(seat == "<dev string:x216>" || seat == "<dev string:x21f>" || seat == "<dev string:x22c>" || seat == "<dev string:x233>" || seat == "<dev string:x23d>");
  } else {
    seat = "all";
  }

  if(isDefined(self.var_761c973.riders)) {
    if(seat == "all") {
      foreach(ai in self.var_761c973.riders) {
        if(isDefined(ai) && isalive(ai)) {
          ais[ais.size] = ai;
        }
      }

      return ais;
    } else {
      foreach(ai in self.var_761c973.riders) {
        if(isDefined(ai) && isalive(ai) && ai.var_5574287b === seat) {
          ais[ais.size] = ai;
        }
      }

      return ais;
    }
  }

  return ais;
}