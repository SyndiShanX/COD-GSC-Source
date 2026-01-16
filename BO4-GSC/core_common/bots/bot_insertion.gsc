/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_insertion.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player_insertion;
#include scripts\core_common\system_shared;

#namespace bot_insertion;

autoexec __init__system__() {
  system::register(#"bot_insertion", &__init__, undefined, undefined);
}

__init__() {
  callback::add_callback(#"freefall", &function_c9a18304);
}

private function_b7de760d() {
  foreach(insertion in level.insertions) {
    player_insertion::function_a5fd9aa8(insertion);

    foreach(player in insertion.players) {
      if(player == self) {
        return true;
      }
    }
  }

  return false;
}

private function_58a44f22() {
  teammates = getplayers(self.team);

  foreach(player in teammates) {
    if(isplayer(player) && !isbot(player) && player function_b7de760d()) {
      return true;
    }
  }

  return false;
}

private function_9ea8f9d6() {
  teammates = getplayers(self.team);

  foreach(player in teammates) {
    if(isplayer(player) && !isbot(player) && player function_b7de760d()) {
      return player;
    }
  }

  return undefined;
}

function_a4f516ef() {
  self endon(#"death", #"disconnect");

  if(getdvarint(#"scr_disable_infiltration", 0)) {
    return;
  }

  if(!self flagsys::get(#"hash_287397edba8966f9")) {
    var_f9664338 = [#"hash_287397edba8966f9", #"hash_224cb97b8f682317"];
    self flagsys::wait_till_any(var_f9664338);
  }

  if(function_58a44f22()) {
    waitresult = self waittill(#"hash_3a41cbe85bdb81e1", #"hash_224cb97b8f682317");

    if(waitresult._notify != #"hash_224cb97b8f682317") {
      self flagsys::wait_till_timeout(function_8ed212d(), #"hash_224cb97b8f682317");
    }

    return;
  }

  assert(isDefined(self.var_33a2e995));
  self flagsys::wait_till_timeout(self.var_33a2e995, #"hash_224cb97b8f682317");
}

function_2ed2a1bb(max) {
  random = randomfloat(1);
  return random * random * random * max;
}

function_9526ce62(max) {
  return function_2ed2a1bb(max);
}

function_8ed212d() {
  return 1 + function_2ed2a1bb(3);
}

function_24ca8ecf(insertion) {
  assert(isstruct(insertion));
  bots = [];

  foreach(player in insertion.players) {
    if(isbot(player)) {
      if(!isDefined(bots[player.team])) {
        bots[player.team] = [];
      }

      if(!isDefined(bots[player.team])) {
        bots[player.team] = [];
      } else if(!isarray(bots[player.team])) {
        bots[player.team] = array(bots[player.team]);
      }

      bots[player.team][bots[player.team].size] = player;
    }
  }

  if(!isDefined(insertion.start_point) || !isDefined(insertion.end_point)) {
    return;
  }

  distance = distance2d(insertion.start_point, insertion.end_point);
  var_5d59bc67 = 2640;
  var_ef4bfcd8 = distance / var_5d59bc67;

  foreach(team in bots) {
    var_28cd9792 = function_9526ce62(var_ef4bfcd8);

    foreach(bot in team) {
      bot.var_33a2e995 = var_28cd9792 + function_8ed212d();
    }
  }
}

function_d7ba3d0b() {
  self thread function_39c5371e();
  return function_9526ce62(5);
}

function_9699dc95() {
  self thread function_39c5371e();
}

function_39c5371e() {}

private function_8f2f3bcd() {
  center = (0, 0, 0);
  radius = 0;

  if(isDefined(level.deathcircle)) {
    center = level.deathcircle.origin;
    radius = level.deathcircle.radius * 0.75;
  }

  goal = center + anglesToForward((0, randomint(360), 0)) * radius;
  return goal;
}

function_d26744ff(target_point, lead_player) {
  direction = vectornormalize(target_point - self.origin);
  goal_angles = vectortoangles(direction);

  if(goal_angles[0] < 45) {
    distance = distance(target_point, self.origin);

    if(distance > 20000) {
      goal_angles = (0, goal_angles[1], 0);
    }
  }

  return goal_angles;
}

function_233a1027(target_point, lead_player) {
  if(!isplayer(lead_player)) {
    return (0, 0, 0);
  }

  if(lead_player isonground()) {
    return self function_d26744ff(lead_player.origin, lead_player);
  }

  goal_angles = lead_player.angles;
  return goal_angles;
}

function_13ba9cec(target_point, lead_player, var_282c0a8e) {
  assert(isDefined(var_282c0a8e));

  if(self isonground()) {
    return false;
  }

  goal_angles = [[var_282c0a8e]](target_point, lead_player);
  var_8fbb46cd = vectornormalize(self getvelocity());
  var_e0db94ca = vectortoangles(var_8fbb46cd);
  angle_delta = goal_angles - var_e0db94ca;
  var_ce2f4ce0 = function_dac81c9a(angleclamp180(angle_delta[0]));
  angle_yaw = function_dac81c9a(angleclamp180(angle_delta[1]));
  angles = var_e0db94ca + (var_ce2f4ce0, angle_yaw, 0);
  angles = (angleclamp180(angles[0]), angleclamp180(angles[1]), 0);
  self botsetmoveangles(angles);
  self botsetlookangles(angles);
  return true;
}

function_c9a18304(params) {
  if(!isbot(self)) {
    return;
  }

  if(params.freefall === 1) {
    self notify("262092a28e60152c");
    self endon("262092a28e60152c");
    self endon(#"death", #"disconnect");
    waitframe(1);
    self botsetmovemagnitude(1);
    target_point = function_8f2f3bcd();
    direction = vectornormalize(target_point - self.origin);
    angles = vectortoangles(direction);
    angles = (90, angles[1], 0);
    self botsetmoveangles(angles);
    self botsetlookangles(angles);

    while(true) {
      if(length(self getvelocity()) * 0.0568182 > 110) {
        break;
      }

      wait 1;
    }

    var_26a66f9d = &function_d26744ff;
    var_2706b530 = function_9ea8f9d6();

    if(isDefined(var_2706b530)) {
      var_26a66f9d = &function_233a1027;
    }

    while(true) {
      if(!self function_13ba9cec(target_point, var_2706b530, var_26a66f9d)) {
        return;
      }

      waitframe(1);
    }

    return;
  }

  self botsetmovemagnitude(0);
}

private function_dac81c9a(angle_delta) {
  max_delta = getdvarint(#"hash_11e45cd7d81b76c", 30);

  if(angle_delta > 0) {
    return math::clamp(max_delta, angle_delta * -1, angle_delta);
  }

  return math::clamp(max_delta * -1, angle_delta, angle_delta * -1);
}