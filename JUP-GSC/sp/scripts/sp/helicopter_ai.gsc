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

function evasive_createmaneuvers(vehicle, maneuvername) {
  assert(isDefined(maneuvername));

  switch (maneuvername) {
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
      maneuvernamelist = [];
      maneuvernamelist[0] = "strafe_left_right";
      maneuvernamelist[1] = "strafe_right_left";
      maneuvernamelist[2] = "360_clockwise";
      maneuvernamelist[3] = "360_counter_clockwise";
      return evasive_createmaneuvers(vehicle, maneuvernamelist[randomint(maneuvernamelist.size)]);
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
      evadedirectionyaw = vectortoangles(points[i + 1]["pos"] - points[i]["pos"]);
    } else {
      evadedirectionyaw = (0, forwardyaw, 0);
    }

    goalyawangle = evadedirectionyaw[1];

    if(points[i]["goalYawMethod"] == "average") {
      goalyawangle = (evadedirectionyaw[1] + forwardyaw) / 2;
    } else if(points[i]["goalYawMethod"] == "forward") {
      goalyawangle = vehicle.angles[1];
    }

    if(getDvar(@ "hash_c9ab8c9fc46c92cf") == "1") {
      thread draw_line_until_notify(points[i]["pos"], points[i]["pos"] + anglesToForward((0, goalyawangle, 0)) * 250, 1, 1, 0.2, vehicle, "evasive_action_done");
    }

    vehicle settargetyaw(goalyawangle);
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
  goalposupdatetime = 1;
  wingmanspeedscale = 1.2;
  wingmanbaseacceleration = 50;
  wingmanbasedeceleration = 60;
  vehhelicopter_getspeedtime = 2000;
  vehhelicopter_currentspeed = getplayerhelispeed();
  vehhelicopter_oldspeed = 0;
  vehhelicopter_oldspeedtime = gettime();
  goalpos = wingman_getgoalpos(dist_forward, dist_side, dist_up);
  vehicle vehicle_setspeed(30, 20, 20);
  vehicle settargetyaw(level.playervehicle.angles[1]);
  vehicle setvehgoalpos(goalpos, 1);

  for(;;) {
    goalpos = wingman_getgoalpos(dist_forward, dist_side, dist_up);

    if(getDvar(@ "hash_c9ab8c9fc46c92cf") == "1") {
      thread draw_line_for_time(level.playervehicle.origin, goalpos, 0, 1, 0, goalposupdatetime);
      thread draw_line_for_time(level.playervehicle.origin, vehicle.origin, 0, 0, 1, goalposupdatetime);
      thread draw_line_for_time(vehicle.origin, goalpos, 1, 1, 0, goalposupdatetime);
    }

    time = gettime();

    if(time >= vehhelicopter_oldspeedtime + vehhelicopter_getspeedtime) {
      vehhelicopter_oldspeedtime = time;
      vehhelicopter_oldspeed = vehhelicopter_currentspeed;
      vehhelicopter_currentspeed = getplayerhelispeed();
    }

    bgotogoal = 0;
    wingmanspeed = 0;

    if(vehhelicopter_oldspeed > 20) {
      wingmanspeed = vehhelicopter_oldspeed;
      bgotogoal = 1;
    } else if(vehhelicopter_oldspeed <= 20 && getplayerhelispeed() > 20) {
      wingmanspeed = getplayerhelispeed();
      bgotogoal = 1;
    }

    if(bgotogoal && wingmanspeed > 0) {
      wingmanspeed *= wingmanspeedscale;
      accel = wingmanbaseacceleration;
      decel = wingmanbasedeceleration;

      if(accel >= wingmanspeed / 2) {
        accel = wingmanspeed / 2;
      }

      if(decel >= wingmanspeed / 2) {
        decel = wingmanspeed / 2;
      }

      vehicle vehicle_setspeed(wingmanspeed, accel, decel);
      vehicle settargetyaw(level.playervehicle.angles[1]);
      bstop = 0;

      if(getplayerhelispeed() <= 30) {
        bstop = 1;
      }

      if(getDvar(@ "hash_c9ab8c9fc46c92cf") == "1") {
        iprintln("wingman speed: " + wingmanspeed + " : " + bstop);
      }

      vehicle setvehgoalpos(goalpos, bstop);
    }

    wait goalposupdatetime;
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