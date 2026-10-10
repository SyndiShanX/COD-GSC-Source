/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\helicopter_ai.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\helicopter_globals;
#using scripts\sp\utility;
#namespace helicopter_ai;

function evasive_think(vehicle) {
  vehicle endon("death");

  while(vehicle.health > 0) {
    vehicle waittill("missile_lock", enemyvehicle);
    points = evasive_createmaneuvers(vehicle, "random");
    evasive_startmaneuvers(vehicle, points);
    wait 0.05;
  }
}

function evasive_createmaneuvers(vehicle, var_17240fd48aa84699) {
  assert(isDefined(var_17240fd48aa84699));

  switch (var_17240fd48aa84699) {
    case #"hash_debe8da4c699f42b":
      vehicle evasive_addpoint(3000, -1500, 500, "average");
      vehicle evasive_addpoint(6000, 3000, -700, "average");
      vehicle evasive_addpoint(3000, -1500, 200, "average");
      break;
    case #"hash_2d6fcc61f644ff59":
      vehicle evasive_addpoint(3000, 1500, 500, "average");
      vehicle evasive_addpoint(6000, -3000, -700, "average");
      vehicle evasive_addpoint(3000, 1500, 200, "average");
      break;
    case #"hash_29bf81a76004cc09":
      vehicle evasive_addpoint(1500, 1500, 200, "none");
      vehicle evasive_addpoint(0, 1500, 200, "none");
      vehicle evasive_addpoint(-1500, 1500, 200, "none");
      vehicle evasive_addpoint(-1500, 0, 0, "none");
      vehicle evasive_addpoint(-1000, -1000, -200, "none");
      vehicle evasive_addpoint(0, -1000, -200, "none");
      vehicle evasive_addpoint(1000, -1000, -200, "none");
      break;
    case #"hash_d6d4eaf7870ac1f6":
      vehicle evasive_addpoint(1500, -1500, 200, "none");
      vehicle evasive_addpoint(0, -1500, 200, "none");
      vehicle evasive_addpoint(-1500, -1500, 200, "none");
      vehicle evasive_addpoint(-1500, 0, 0, "none");
      vehicle evasive_addpoint(-1000, 1000, -200, "none");
      vehicle evasive_addpoint(0, 1000, -200, "none");
      vehicle evasive_addpoint(1000, 1000, -200, "none");
      break;
    case #"hash_82dd7c3e206217c2":
      var_5f8b2ace8e5b3dc5 = [];
      var_5f8b2ace8e5b3dc5[0] = "strafe_left_right";
      var_5f8b2ace8e5b3dc5[1] = "strafe_right_left";
      var_5f8b2ace8e5b3dc5[2] = "360_clockwise";
      var_5f8b2ace8e5b3dc5[3] = "360_counter_clockwise";
      return evasive_createmaneuvers(vehicle, var_5f8b2ace8e5b3dc5[randomint(var_5f8b2ace8e5b3dc5.size)]);
  }

  points = evasive_getallpoints(vehicle);
  return points;
}

function evasive_startmaneuvers(vehicle, points) {
  vehicle notify("taking_evasive_actions");
  vehicle endon("taking_evasive_actions");
  vehicle endon("death");
  vehicle notify("evasive_action_done");
  thread evasive_endmaneuvers(vehicle);

  if(getDvar(@ "hash_c9ab8c9fc46c92cf") == "1") {
    vehicle evasive_drawpoints(points);
  }

  vehicle setneargoalnotifydist(1500);
  vehicle vehicle_setspeed(100, 30, 30);
  forwardyaw = vehicle.angles[1];

  for(i = 1; i < points.size; i++) {
    if(isDefined(points[i + 1])) {
      var_29d072a4081c09aa = vectortoangles(points[i + 1]["pos"] - points[i]["pos"]);
    } else {
      var_29d072a4081c09aa = (0, forwardyaw, 0);
    }

    var_bad4333aad3972a0 = var_29d072a4081c09aa[1];

    if(points[i]["goalYawMethod"] == "average") {
      var_bad4333aad3972a0 = (var_29d072a4081c09aa[1] + forwardyaw) / 2;
    } else if(points[i]["goalYawMethod"] == "forward") {
      var_bad4333aad3972a0 = vehicle.angles[1];
    }

    if(getDvar(@ "hash_c9ab8c9fc46c92cf") == "1") {
      thread draw_line_until_notify(points[i]["pos"], points[i]["pos"] + anglesToForward((0, var_bad4333aad3972a0, 0)) * 250, 1, 1, 0.2, vehicle, "evasive_action_done");
    }

    vehicle settargetyaw(var_bad4333aad3972a0);
    vehicle thread scripts\common\vehicle_code::setvehgoalpos_wrap(points[i]["pos"], 0);
    vehicle waittill("near_goal");
  }

  vehicle notify("evasive_action_done");
  vehicle thread utility::vehicle_resumepath();
}

function evasive_endmaneuvers(vehicle) {
  vehicle notify("end_maneuvers");
  vehicle endon("end_maneuvers");
  vehicle endon("evasive_action_done");
  vehicle endon("death");
  vehicle waittill("missile_lock_ended");
  vehicle thread utility::vehicle_resumepath();
}

function evasive_addpoint(forward, side, up, goalyawmethod) {
  if(!isDefined(self.evasive_points)) {
    self.evasive_points = [];
    self.evasive_points[0]["pos"] = self.origin;
    self.evasive_points[0]["ang"] = (0, self.angles[1], 0);
  }

  index = self.evasive_points.size;

  if(!isDefined(goalyawmethod)) {
    goalyawmethod = "none";
  }

  if(!isDefined(up)) {
    up = 0;
  }

  self.evasive_points[index]["forward"] = forward;
  self.evasive_points[index]["side"] = side;
  self.evasive_points[index]["up"] = up;
  vec_forward = anglesToForward(self.evasive_points[0]["ang"]);
  vec_right = anglestoright(self.evasive_points[0]["ang"]);
  self.evasive_points[index]["pos"] = self.evasive_points[index - 1]["pos"] + vec_forward * self.evasive_points[index]["forward"] + vec_right * self.evasive_points[index]["side"] + (0, 0, up);
  self.evasive_points[index]["goalYawMethod"] = goalyawmethod;
}

function evasive_getallpoints(vehicle) {
  points = vehicle.evasive_points;
  vehicle.evasive_points = undefined;
  return points;
}

function evasive_drawpoints(points) {
  for(i = 1; i < points.size; i++) {
    thread draw_line_until_notify(points[i - 1]["pos"], points[i]["pos"], 1, 0.2, 0.2, self, "evasive_action_done");
  }
}

function wingman_think(vehicle) {
  vehicle endon("death");
  level.playervehicle endon("death");
  dist_forward = 2200;
  dist_side = 1500;
  dist_up = 0;
  var_b608f355e5ab52b8 = 1;
  var_40b0f17ed8bcc0f1 = 1.2;
  var_f70c456b97d2571b = 50;
  var_fb993e89949902c0 = 60;
  var_260b7df16f367f60 = 2000;
  var_a2e4675d403a8346 = getplayerhelispeed();
  var_a9848973d185d972 = 0;
  var_c71354f9021ff3f3 = gettime();
  goalpos = wingman_getgoalpos(dist_forward, dist_side, dist_up);
  vehicle vehicle_setspeed(30, 20, 20);
  vehicle settargetyaw(level.playervehicle.angles[1]);
  vehicle setvehgoalpos(goalpos, 1);

  for(;;) {
    goalpos = wingman_getgoalpos(dist_forward, dist_side, dist_up);

    if(getDvar(@ "hash_c9ab8c9fc46c92cf") == "1") {
      thread draw_line_for_time(level.playervehicle.origin, goalpos, 0, 1, 0, var_b608f355e5ab52b8);
      thread draw_line_for_time(level.playervehicle.origin, vehicle.origin, 0, 0, 1, var_b608f355e5ab52b8);
      thread draw_line_for_time(vehicle.origin, goalpos, 1, 1, 0, var_b608f355e5ab52b8);
    }

    time = gettime();

    if(time >= var_c71354f9021ff3f3 + var_260b7df16f367f60) {
      var_c71354f9021ff3f3 = time;
      var_a9848973d185d972 = var_a2e4675d403a8346;
      var_a2e4675d403a8346 = getplayerhelispeed();
    }

    var_a50ec07292aca5f5 = 0;
    var_425db4d77182c705 = 0;

    if(var_a9848973d185d972 > 20) {
      var_425db4d77182c705 = var_a9848973d185d972;
      var_a50ec07292aca5f5 = 1;
    } else if(var_a9848973d185d972 <= 20 && getplayerhelispeed() > 20) {
      var_425db4d77182c705 = getplayerhelispeed();
      var_a50ec07292aca5f5 = 1;
    }

    if(var_a50ec07292aca5f5 && var_425db4d77182c705 > 0) {
      var_425db4d77182c705 *= var_40b0f17ed8bcc0f1;
      accel = var_f70c456b97d2571b;
      decel = var_fb993e89949902c0;

      if(accel >= var_425db4d77182c705 / 2) {
        accel = var_425db4d77182c705 / 2;
      }

      if(decel >= var_425db4d77182c705 / 2) {
        decel = var_425db4d77182c705 / 2;
      }

      vehicle vehicle_setspeed(var_425db4d77182c705, accel, decel);
      vehicle settargetyaw(level.playervehicle.angles[1]);
      bstop = 0;

      if(getplayerhelispeed() <= 30) {
        bstop = 1;
      }

      if(getDvar(@ "hash_c9ab8c9fc46c92cf") == "1") {
        iprintln("wingman speed: " + var_425db4d77182c705 + " : " + bstop);
      }

      vehicle setvehgoalpos(goalpos, bstop);
    }

    wait var_b608f355e5ab52b8;
  }
}

function wingman_getgoalpos(dist_forward, dist_side, dist_up) {
  vec_forward = anglesToForward(flat_angle(level.playervehicle.angles));
  vec_right = anglestoright(flat_angle(level.playervehicle.angles));
  goalpos = level.playervehicle.origin + vec_forward * dist_forward + vec_right * dist_side + (0, 0, dist_up);
  return goalpos;
}

function getplayerhelispeed() {
  return level.playervehicle vehicle_getspeed();
}