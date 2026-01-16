/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_helicopter_ai.gsc
********************************/

evasive_think(var_0) {
  var_0 endon("death");

  while (var_0.health > 0) {
    var_0 waittill("missile_lock", var_1);
    var_2 = evasive_createmaneuvers(var_0, "random");
    evasive_startmaneuvers(var_0, var_2);
    wait 0.05;
  }
}

evasive_createmaneuvers(var_0, var_1) {
  switch (var_1) {
    case "strafe_left_right":
      var_0 evasive_addpoint(3000, -1500, 500, "average");
      var_0 evasive_addpoint(6000, 3000, -700, "average");
      var_0 evasive_addpoint(3000, -1500, 200, "average");
      break;
    case "strafe_right_left":
      var_0 evasive_addpoint(3000, 1500, 500, "average");
      var_0 evasive_addpoint(6000, -3000, -700, "average");
      var_0 evasive_addpoint(3000, 1500, 200, "average");
      break;
    case "360_clockwise":
      var_0 evasive_addpoint(1500, 1500, 200, "none");
      var_0 evasive_addpoint(0, 1500, 200, "none");
      var_0 evasive_addpoint(-1500, 1500, 200, "none");
      var_0 evasive_addpoint(-1500, 0, 0, "none");
      var_0 evasive_addpoint(-1000, -1000, -200, "none");
      var_0 evasive_addpoint(0, -1000, -200, "none");
      var_0 evasive_addpoint(1000, -1000, -200, "none");
      break;
    case "360_counter_clockwise":
      var_0 evasive_addpoint(1500, -1500, 200, "none");
      var_0 evasive_addpoint(0, -1500, 200, "none");
      var_0 evasive_addpoint(-1500, -1500, 200, "none");
      var_0 evasive_addpoint(-1500, 0, 0, "none");
      var_0 evasive_addpoint(-1000, 1000, -200, "none");
      var_0 evasive_addpoint(0, 1000, -200, "none");
      var_0 evasive_addpoint(1000, 1000, -200, "none");
      break;
    case "random":
      var_2 = [];
      var_2[0] = "strafe_left_right";
      var_2[1] = "strafe_right_left";
      var_2[2] = "360_clockwise";
      var_2[3] = "360_counter_clockwise";
      return evasive_createmaneuvers(var_0, var_2[randomint(var_2.size)]);
  }

  var_3 = evasive_getallpoints(var_0);
  return var_3;
}

evasive_startmaneuvers(var_0, var_1) {
  var_0 notify("taking_evasive_actions");
  var_0 endon("taking_evasive_actions");
  var_0 endon("death");
  var_0 notify("evasive_action_done");
  thread evasive_endmaneuvers(var_0);

  if(getdvar("cobrapilot_debug") == "1")
    var_0 evasive_drawpoints(var_1);

  var_0 setneargoalnotifydist(1500);
  var_0 vehicle_setspeed(100, 30, 30);
  var_2 = var_0.angles[1];

  for (var_3 = 1; var_3 < var_1.size; var_3++) {
    if(isdefined(var_1[var_3 + 1]))
      var_4 = vectortoangles(var_1[var_3 + 1]["pos"] - var_1[var_3]["pos"]);
    else
      var_4 = (0, var_2, 0);

    var_5 = var_4[1];

    if(var_1[var_3]["goalYawMethod"] == "average")
      var_5 = (var_4[1] + var_2) / 2;
    else if(var_1[var_3]["goalYawMethod"] == "forward")
      var_5 = var_0.angles[1];

    if(getdvar("cobrapilot_debug") == "1")
      thread maps\_utility::draw_line_until_notify(var_1[var_3]["pos"], var_1[var_3]["pos"] + anglestoforward((0, var_5, 0)) * 250, 1.0, 1.0, 0.2, var_0, "evasive_action_done");

    var_0 settargetyaw(var_5);
    var_0 thread maps\_vehicle_code::setvehgoalpos_wrap(var_1[var_3]["pos"], 0);
    var_0 waittill("near_goal");
  }

  var_0 notify("evasive_action_done");
  var_0 thread maps\_utility::vehicle_resumepath();
}

evasive_endmaneuvers(var_0) {
  var_0 notify("end_maneuvers");
  var_0 endon("end_maneuvers");
  var_0 endon("evasive_action_done");
  var_0 endon("death");
  var_0 waittill("missile_lock_ended");
  var_0 thread maps\_utility::vehicle_resumepath();
}

evasive_addpoint(var_0, var_1, var_2, var_3) {
  if(!isdefined(self.evasive_points)) {
    self.evasive_points = [];
    self.evasive_points[0]["pos"] = self.origin;
    self.evasive_points[0]["ang"] = (0, self.angles[1], 0);
  }

  var_4 = self.evasive_points.size;

  if(!isdefined(var_3))
    var_3 = "none";

  if(!isdefined(var_2))
    var_2 = 0;

  self.evasive_points[var_4]["forward"] = var_0;
  self.evasive_points[var_4]["side"] = var_1;
  self.evasive_points[var_4]["up"] = var_2;
  var_5 = anglestoforward(self.evasive_points[0]["ang"]);
  var_6 = anglestoright(self.evasive_points[0]["ang"]);
  self.evasive_points[var_4]["pos"] = self.evasive_points[var_4 - 1]["pos"] + var_5 * self.evasive_points[var_4]["forward"] + var_6 * self.evasive_points[var_4]["side"] + (0, 0, var_2);
  self.evasive_points[var_4]["goalYawMethod"] = var_3;
}

evasive_getallpoints(var_0) {
  var_1 = var_0.evasive_points;
  var_0.evasive_points = undefined;
  return var_1;
}

evasive_drawpoints(var_0) {
  for (var_1 = 1; var_1 < var_0.size; var_1++)
    thread maps\_utility::draw_line_until_notify(var_0[var_1 - 1]["pos"], var_0[var_1]["pos"], 1.0, 0.2, 0.2, self, "evasive_action_done");
}

wingman_think(var_0) {
  var_0 endon("death");
  level.playervehicle endon("death");
  var_1 = 2200;
  var_2 = 1500;
  var_3 = 0;
  var_4 = 1.0;
  var_5 = 1.2;
  var_6 = 50;
  var_7 = 60;
  var_8 = 2000;
  var_9 = getplayerhelispeed();
  var_10 = 0.0;
  var_11 = gettime();
  var_12 = wingman_getgoalpos(var_1, var_2, var_3);
  var_0 vehicle_setspeed(30, 20, 20);
  var_0 settargetyaw(level.playervehicle.angles[1]);
  var_0 setvehgoalpos(var_12, 1);

  for (;;) {
    var_12 = wingman_getgoalpos(var_1, var_2, var_3);

    if(getdvar("cobrapilot_debug") == "1") {
      thread common_scripts\utility::draw_line_for_time(level.playervehicle.origin, var_12, 0, 1, 0, var_4);
      thread common_scripts\utility::draw_line_for_time(level.playervehicle.origin, var_0.origin, 0, 0, 1, var_4);
      thread common_scripts\utility::draw_line_for_time(var_0.origin, var_12, 1, 1, 0, var_4);
    }

    var_13 = gettime();

    if(var_13 >= var_11 + var_8) {
      var_11 = var_13;
      var_10 = var_9;
      var_9 = getplayerhelispeed();
    }

    var_14 = 0;
    var_15 = 0;

    if(var_10 > 20) {
      var_15 = var_10;
      var_14 = 1;
    } else if(var_10 <= 20 && getplayerhelispeed() > 20) {
      var_15 = getplayerhelispeed();
      var_14 = 1;
    }

    if(var_14 && var_15 > 0) {
      var_15 = var_15 * var_5;
      var_16 = var_6;
      var_17 = var_7;

      if(var_16 >= var_15 / 2)
        var_16 = var_15 / 2;

      if(var_17 >= var_15 / 2)
        var_17 = var_15 / 2;

      var_0 vehicle_setspeed(var_15, var_16, var_17);
      var_0 settargetyaw(level.playervehicle.angles[1]);
      var_18 = 0;

      if(getplayerhelispeed() <= 30)
        var_18 = 1;

      if(getdvar("cobrapilot_debug") == "1")
        iprintln("wingman speed: " + var_15 + " : " + var_18);

      var_0 setvehgoalpos(var_12, var_18);
    }

    wait(var_4);
  }
}

wingman_getgoalpos(var_0, var_1, var_2) {
  var_3 = anglestoforward(common_scripts\utility::flat_angle(level.playervehicle.angles));
  var_4 = anglestoright(common_scripts\utility::flat_angle(level.playervehicle.angles));
  var_5 = level.playervehicle.origin + var_3 * var_0 + var_4 * var_1 + (0, 0, var_2);
  return var_5;
}

getplayerhelispeed() {
  return level.playervehicle vehicle_getspeed();
}