/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_reinsertion.gsc
*****************************************************/

#using script_305d57cf0618009d;
#using script_6e9b46ba8331f1f;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot_insertion;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\death_circle;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_free_fall;
#using scripts\core_common\player\player_insertion;
#using scripts\core_common\system_shared;
#namespace player_reinsertion;

function private autoexec __init__system__() {
  system::register(#"player_reinsertion", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(level.var_f2814a96 !== 0) {
    return;
  }

  callback::add_callback(#"hash_6b7d26d34885b425", &function_4012c0ab);
  callback::on_game_playing(&on_game_playing);
  level.reinsertion = spawnStruct();
}

function on_game_playing() {
  level thread function_3d39c260();

  level thread function_a6eac3b7();
}

function function_3d39c260() {
  if(level.numlives == 1) {
    return;
  }

  var_7eb8f61a = isDefined(getgametypesetting(#"wzplayerinsertiontypeindex")) ? getgametypesetting(#"wzplayerinsertiontypeindex") : 0;

  if(var_7eb8f61a != 0 && var_7eb8f61a != 3 || is_true(level.wave_spawn)) {
    return;
  }

  var_f8d960b2 = 0.6;
  height = 30000;
  center = (0, 0, height);
  radius = function_cf96c89c() * var_f8d960b2;
  vehicle = function_d5d96302(center, radius);

  if(!isDefined(vehicle)) {
    return;
  }

  level.reinsertion.vehicle = vehicle;
  vehicle thread function_14f79b33(center, radius, height, var_f8d960b2);
  level.reinsertion.cameraent = function_15e6e9ae(vehicle);
  level thread function_eb815c5();
}

function function_a20b914d(circle_origin, circle_radius) {
  angles = (0, randomint(360), 0);
  direction = anglesToForward(angles);
  spawn_origin = circle_origin - direction * circle_radius;
  return spawn_origin;
}

function function_cf96c89c() {
  minimaporigins = getEntArray("map_corner", "targetname");

  if(minimaporigins.size) {
    x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
    y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
    return min(x, y);
  }

  return 0;
}

function function_93376ccd(center, origin) {
  left = vectornormalize(origin - center);
  forward = vectorcross(left, (0, 0, 1));
  return vectortoangles(forward);
}

function function_d5d96302(center, radius) {
  while(getplayers().size == 0) {
    wait 0.5;
  }

  origin = function_a20b914d(center, radius);
  angles = function_93376ccd(center, origin);
  vehicle = spawnvehicle("vehicle_t9_mil_helicopter_care_package", origin, angles);
  vehicle.takedamage = 0;
  vehicle setneargoalnotifydist(512);
  vehicle clientfield::set("infiltration_landing_gear", 1);
  vehicle setrotorspeed(1);
  vehicle setspeedimmediate(100);
  return vehicle;
}

function function_15e6e9ae(vehicle) {
  camera = player_insertion::function_57fe9b21(level.insertion, vehicle.origin);
  camera.origin = vehicle.origin;
  camera.angles = vehicle.angles;
  camera linkto(vehicle);
  return camera;
}

function private function_521bff14(center, goal, var_e294ac7d) {
  direction = goal - center;
  steps = int(length(direction) / 1000);
  direction = vectornormalize(direction);
  var_3d4c4e94 = player_insertion::function_f31cf3bb(center, direction, 1000, 0, steps);

  if(!isDefined(var_3d4c4e94)) {
    var_3d4c4e94 = center;
  }

  if(distance2dsquared(goal, var_3d4c4e94) > sqr(0.01)) {
    delta = var_3d4c4e94 - center;
    length = length(delta);
    direction = vectornormalize(delta);
    new_point = center + direction * length * var_e294ac7d;

    var_ced865d2 = center + direction * length;
    thread player_insertion::debug_line(center, new_point, (1, 0, 0), level.reinsertion.debug_duration);
    thread player_insertion::debug_line(new_point, var_ced865d2, (0, 1, 1), level.reinsertion.debug_duration);
    thread player_insertion::debug_line(var_ced865d2, goal, (1, 0, 1), level.reinsertion.debug_duration);

    return new_point;
  }

  thread player_insertion::debug_line(center, goal, (1, 0, 0), level.reinsertion.debug_duration);

  return goal;
}

function function_8ea9be1c() {
  if(!isDefined(level.reinsertion.vehicle)) {
    return;
  }

  level.reinsertion.vehicle function_beba57b9(30000);
}

function private function_beba57b9(height) {
  var_e8a39fb = function_cf96c89c();
  goal = rotatepoint((1, 0, 0), (0, randomint(360), 0)) * var_e8a39fb * 2;
  goal = (goal[0], goal[1], height);
  self function_a57c34b7(goal, 0, 0);
}

function private function_14f79b33(center, radius, height, var_e294ac7d) {
  self endon(#"death");
  var_5d59bc67 = 1760;
  time_step = 5;

  while(true) {
    if(!death_circle::is_active()) {
      circle_origin = center;
      circle_radius = radius;
    } else {
      circle_origin = death_circle::function_b980b4ca();
      circle_origin = (circle_origin[0], circle_origin[1], height);
      circle_radius = death_circle::function_f8dae197() * var_e294ac7d;
    }

    if(circle_radius < 0.01) {
      self function_beba57b9(height);
      return;
    }

    level.reinsertion.debug_duration = 1000;
    thread player_insertion::debug_line(circle_origin, level.reinsertion.vehicle.origin, (0, 0, 1), level.reinsertion.debug_duration);

    var_9c068ab1 = vectornormalize(level.reinsertion.vehicle.origin - circle_origin);
    var_c40f2e06 = vectortoangles(var_9c068ab1);
    current_yaw = var_c40f2e06[1];
    var_c5a2c1c9 = var_5d59bc67 / circle_radius * 57.2958;
    new_yaw = current_yaw + time_step * var_c5a2c1c9;
    new_angles = (0, new_yaw, 0);
    goal = circle_origin + anglesToForward(new_angles) * circle_radius;
    goal = function_521bff14(circle_origin, goal, var_e294ac7d);

    thread player_insertion::debug_line(level.reinsertion.vehicle.origin, goal, (0, 1, 0), level.reinsertion.debug_duration);

    self function_a57c34b7(goal, 0, 0);
    self waittill(#"goal", #"near_goal");
  }
}

function private function_4f356be(start, end, offset, var_3a5f8906) {
  self endon(#"death");
  self function_a57c34b7(end, 0, 0);
  distance = distance(end, start);
  var_27dfb385 = int(distance / 5000);
  remainingdist = int(distance) % 5000;

  for(i = 1; i <= var_27dfb385; i++) {
    self pathvariableoffset((offset, offset, offset) * (var_27dfb385 - i + 1), var_3a5f8906);
    self player_insertion::function_85635daf(start, distance, i * 5000 / distance);
  }

  if(remainingdist > 0) {
    self pathvariableoffset((offset, offset, offset), var_3a5f8906);
  }

  self waittill(#"goal", #"near_goal");
}

function function_b24f3a72(origin, radius, height) {
  point = self.origin;
  distance = distance2d(point, origin);

  if(distance == 0) {
    return origin;
  }

  angle = cos(radius / distance);
  vec = vectornormalize(point - origin);
  goal = rotatepoint(vec, (0, angle, 0)) * radius;
  return (goal[0], goal[1], height);
}

function function_8655661f(radius_t, height) {
  if(!death_circle::is_active()) {
    return self function_b24f3a72((0, 0, height), 50000 * radius_t, height);
  }

  origin = death_circle::function_b980b4ca();
  origin = (origin[0], origin[1], height);
  radius = death_circle::function_f8dae197() * radius_t;
  goal = self function_b24f3a72(origin, radius, height);
  return goal;
}

function function_b2df2693() {
  var_48bc2733 = [];

  foreach(team in level.teams) {
    if(function_a1ef346b(team).size > 0) {
      players = getplayers(team);

      player_alive = 0;

      foreach(player in players) {
        if(isalive(player) && player.sessionstate == "<dev string:x38>") {
          player_alive = 1;
          break;
        }
      }

      assert(player_alive, "<dev string:x43>");

      if(player_alive == 0) {
        continue;
      }

      foreach(player in players) {
        if(!isalive(player) || player.sessionstate != "playing") {
          var_48bc2733[var_48bc2733.size] = player;
        }
      }
    }
  }

  return var_48bc2733;
}

function private function_c3ab4925() {
  self.var_97b0977 = 0;
  self setclientuivisibilityflag("weapon_hud_visible", 0);
  self flag::clear(#"hash_224cb97b8f682317");
  self flag::clear(#"hash_287397edba8966f9");
  self function_c62b5591();

  if(isbot(self)) {
    self bot_insertion::function_d7ba3d0b();
  }
}

function private function_564e0871() {
  self.var_97b0977 = 0;
  self flag::clear(#"hash_224cb97b8f682317");
  self flag::set(#"hash_287397edba8966f9");
  self function_c62b5591();

  if(isbot(self)) {
    self bot_insertion::function_d7ba3d0b();
  }
}

function private function_acdf637e() {
  if(isDefined(getgametypesetting(#"hash_4149d5d65eb07138")) ? getgametypesetting(#"hash_4149d5d65eb07138") : 0) {
    if(isDefined(level.var_317fb13c)) {
      self thread[[level.var_317fb13c]]();
    }
  }
}

function private function_c62b5591() {
  if(isDefined(level.reinsertion) && isDefined(level.reinsertion.cameraent)) {
    level.reinsertion.cameraent clientfield::set("infiltration_plane", player_insertion::function_1e4302d0(1, level.insertion.index));
    level.reinsertion.cameraent clientfield::set("infiltration_ent", player_insertion::function_1e4302d0(1, level.insertion.index));
    level.reinsertion.cameraent setvisibletoplayer(self);
  }

  self player_insertion::show_postfx();
}

function private function_402101af() {
  if(isDefined(level.reinsertion) && isDefined(level.reinsertion.cameraent)) {
    level.reinsertion.cameraent setinvisibletoplayer(self);
  }

  self player_insertion::hide_postfx();
}

function function_eb815c5() {
  if(isDefined(level.reinsertion) && isDefined(level.reinsertion.cameraent)) {
    level.reinsertion.cameraent clientfield::set("infiltration_camera", player_insertion::function_1e4302d0(2, level.insertion.index));
  }

  level callback::add_callback(#"hash_74b19f5972b0ee52", &function_6198f712);
}

function private function_6198f712(eventstruct) {
  if(isDefined(eventstruct.player)) {
    eventstruct.player function_402101af();
  }
}

function function_218283c4() {
  self luinotifyevent(#"hash_175f8739ed7a932", 0);
}

function function_de24c569() {
  player_insertion::function_a5fd9aa8(level.insertion);

  foreach(player in level.insertion.players) {
    player function_218283c4();
  }
}

function function_f9348c1d() {
  circle_center = death_circle::function_b980b4ca();
  angles = (0, 0, 0);

  if(isDefined(level.reinsertion) && isDefined(level.reinsertion.vehicle)) {
    var_9c068ab1 = vectornormalize(circle_center - level.reinsertion.vehicle.origin);
    angles = vectortoangles(var_9c068ab1);
  }

  return angles;
}

function function_39a51e47() {
  self endon(#"disconnect");

  if(!isDefined(level.warp_portal_vehicles)) {
    self thread player_insertion::function_77132caf();
    self function_acdf637e();
    return;
  }

  var_8c305d53 = self function_5425f45d();

  if(var_8c305d53) {
    self function_acdf637e();
    self thread namespace_b9471dc1::function_f2867466();
    return;
  }

  self thread player_insertion::function_77132caf();
  self function_acdf637e();
}

function function_3c4884f1(var_819e1b79) {
  self endon(#"disconnect");
  targetorigin = self.lastdeathpos;
  angles = undefined;
  players = [];

  foreach(player in getplayers(self.team)) {
    if(player != self && isalive(player)) {
      players[players.size] = player;
    }
  }

  if(players.size > 0) {
    targetplayer = players[randomint(players.size)];
    targetorigin = player.origin;
    targetangles = player.angles;
  } else if(isDefined(self.lastdeathpos)) {
    targetorigin = self.lastdeathpos;

    if(death_circle::is_active()) {
      targetangles = vectortoangles(death_circle::function_b980b4ca() - targetorigin);
    } else {
      targetangles = self.angles;
    }
  }

  if(isDefined(targetorigin)) {
    fwd = anglesToForward(targetangles);
    spawnorigin = targetorigin - fwd * 1000 + (0, 0, 500);
    self setorigin(spawnorigin);
    self player_insertion::start_freefall(fwd * 1000, 0);
  }

  self function_acdf637e();
}

function function_584c9f1() {
  self endon(#"disconnect");

  if(!isDefined(level.reinsertion.vehicle)) {
    self thread player_insertion::function_77132caf();
    return;
  }

  var_c40f2e06 = function_f9348c1d();
  self function_564e0871();
  self player_insertion::function_f795bf83(level.insertion, level.reinsertion.vehicle, var_c40f2e06[1]);
  self setplayerangles(var_c40f2e06);
  self function_acdf637e();
}

function function_836fe662() {
  wait 1;

  if(isDefined(level.deathcircleindex)) {
    level clientfield::set_world_uimodel("hudItems.warzone.reinsertionIndex", level.deathcircleindex + 1);
    return;
  }

  level clientfield::set_world_uimodel("hudItems.warzone.reinsertionIndex", 0);
}

function function_fec68e5c() {
  var_7eb8f61a = isDefined(getgametypesetting(#"wzplayerinsertiontypeindex")) ? getgametypesetting(#"wzplayerinsertiontypeindex") : 0;

  if(getdvarint(#"scr_disable_infiltration", 0)) {
    level.insertion.players = arraycopy(function_b2df2693());

    foreach(player in level.insertion.players) {
      player.var_c5134737 = 1;
      player thread[[level.spawnclient]]();

      if(isDefined(player.lastdeathpos)) {
        player setorigin(player.lastdeathpos);
      }
    }

    return;
  }

  if(!isDefined(level.insertion) || !is_true(level.insertion.allowed)) {
    return;
  }

  level thread function_836fe662();
  player_insertion::function_a21d9dc(level.insertion);
  level.insertion.players = arraycopy(function_b2df2693());
  level thread function_de24c569();
  wait 0.5 + 0.1;
  player_insertion::function_a5fd9aa8(level.insertion);

  foreach(player in level.insertion.players) {
    player.var_c5134737 = 1;
    player thread[[level.spawnclient]]();
    player player_insertion::function_b9a53f50();
  }

  level.insertion flag::set(#"insertion_teleport_completed");
  level.insertion flag::wait_till_timeout(1 + 2.5 + 0.5, #"insertion_presentation_completed");
  level.reinsertion.vehicle player_insertion::function_bc16f3b4(level.insertion);
  assert(10 > 0);
  wait 10;

  foreach(player in level.insertion.players) {
    if(!isDefined(player) || is_true(player.var_97b0977)) {
      continue;
    }

    player clientfield::set_to_player("infiltration_final_warning", 1);
  }

  wait 5;
  player_insertion::function_a5fd9aa8(level.insertion);

  foreach(player in level.insertion.players) {
    if(!isDefined(player) || is_true(player.var_97b0977)) {
      continue;
    }

    player flag::set(#"hash_224cb97b8f682317");
    player flag::set(#"hash_287397edba8966f9");
  }

  wait 1;
  level.reinsertion.vehicle clientfield::set("infiltration_transport", 0);
}

function function_5425f45d() {
  if(death_circle::is_active()) {
    var_d89a84b0 = level.deathcircles.size - 1;
    step_height = 20000 / var_d89a84b0;
    height_diff = level.deathcircleindex * step_height;
    center = death_circle::function_b980b4ca();
    radius = death_circle::function_f8dae197() * 0.5;
    angle = 0;
    var_180a7b48 = self namespace_b9471dc1::function_ec7cfdb();
    portal = level.warp_portal_vehicles[var_180a7b48];

    if(isDefined(portal) && isDefined(portal.angle_step)) {
      angle = isDefined(portal.angle_step) ? portal.angle_step : 0;
      x_pos = center[0] + radius * cos(angle);
      y_pos = center[1] + radius * sin(angle);
      height = 20000 - height_diff;
      z_pos = math::clamp(height, 12000, 20000);

      if(death_circle::function_9956f107()) {
        height = 12000;
      }

      portal.origin = (x_pos, y_pos, z_pos);
      target = death_circle::get_next_origin() - portal.origin;
      target = vectornormalize(target);
      angles = vectortoangles(target);
      portal.angles = angles;
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function function_4012c0ab(params) {
  count = function_c14f7557();
  level clientfield::set_world_uimodel("hudItems.warzone.reinsertionPassengerCount", count);
}

function function_c14f7557() {
  if(game.state != # "pregame" && game.state != # "playing") {
    return 0;
  }

  if(is_true(level.spawnsystem.deathcirclerespawn) && death_circle::function_4dc40125()) {
    return 0;
  }

  if(is_true(level.wave_spawn) && death_circle::function_9956f107()) {
    return 0;
  }

  count = 0;

  foreach(team in level.teams) {
    players = getplayers(team);
    var_40073db2 = 0;
    var_ead60f69 = 0;

    foreach(player in players) {
      if(isalive(player)) {
        var_40073db2++;
        continue;
      }

      if(player.sessionstate != "playing" && player globallogic_player::function_38527849()) {
        var_ead60f69++;
      }
    }

    if(!level.spawnsystem.var_c2cc011f || var_40073db2 > 0) {
      count += var_ead60f69;
    }
  }

  return count;
}

function private function_a6eac3b7() {
  while(true) {
    if(getDvar(#"hash_3fb4a63926f3fa15", 0) > 0) {
      function_9536aa3d();
      setDvar(#"hash_3fb4a63926f3fa15", "<dev string:x86>");
    }

    waitframe(1);
  }
}

function function_9536aa3d() {
  var_269add6e = [];
  var_ef4e0b0 = [];

  foreach(team in level.teams) {
    var_d3934390 = 0;
    players_on_team = array::randomize(getplayers(team));

    foreach(person in players_on_team) {
      if(!isalive(person) || person laststand::player_is_in_laststand()) {
        continue;
      }

      if(var_d3934390 == 0) {
        var_d3934390 = 1;
        var_269add6e[var_269add6e.size] = person;
        continue;
      }

      var_ef4e0b0[var_ef4e0b0.size] = person;
    }
  }

  foreach(not in var_ef4e0b0) {
    if(var_269add6e.size) {
      killer = var_269add6e[randomint(var_269add6e.size)];
    } else {
      killer = not;
    }

    not thread function_c833e81f(killer);
  }

  center = death_circle::function_b980b4ca();
  radius = death_circle::function_f8dae197() * 0.5;

  if(radius == 0) {
    radius = 500;
  }

  foreach(lucky in var_269add6e) {
    spawn_point = rotatepoint((radius, 0, 0), (0, randomint(360), 0));
    lucky setorigin(center + spawn_point + (0, 0, 20000));
    lucky player_free_fall::function_7705a7fc(2, 0);
  }
}

function private function_c833e81f(killer) {
  self endon(#"disconnect");
  self dodamage(self.health + 10000, self.origin + (0, 0, 1), killer);
  wait 1;
  self dodamage(self.health + 10000, self.origin + (0, 0, 1), killer);
}

function function_b5ee47fa(func) {
  level.var_43341799 = func;
}

function function_42a8e289() {
  return isDefined(level.var_43341799);
}

function function_1579c63e() {
  self thread[[level.var_43341799]]();
}