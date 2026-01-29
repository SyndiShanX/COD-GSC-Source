/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\361.gsc
**************************************/

_id_2845(var_0) {
  var_0 endon("death");

  while(var_0.health > 0) {
    var_0 waittill("missile_lock", var_1);
    var_2 = _id_2846(var_0, "random");
    _id_2847(var_0, var_2);
    wait 0.05;
  }
}

_id_2846(var_0, var_1) {
  switch (var_1) {
    case "strafe_left_right":
      var_0 _id_284A(3000, -1500, 500, "average");
      var_0 _id_284A(6000, 3000, -700, "average");
      var_0 _id_284A(3000, -1500, 200, "average");
      break;
    case "strafe_right_left":
      var_0 _id_284A(3000, 1500, 500, "average");
      var_0 _id_284A(6000, -3000, -700, "average");
      var_0 _id_284A(3000, 1500, 200, "average");
      break;
    case "360_clockwise":
      var_0 _id_284A(1500, 1500, 200, "none");
      var_0 _id_284A(0, 1500, 200, "none");
      var_0 _id_284A(-1500, 1500, 200, "none");
      var_0 _id_284A(-1500, 0, 0, "none");
      var_0 _id_284A(-1000, -1000, -200, "none");
      var_0 _id_284A(0, -1000, -200, "none");
      var_0 _id_284A(1000, -1000, -200, "none");
      break;
    case "360_counter_clockwise":
      var_0 _id_284A(1500, -1500, 200, "none");
      var_0 _id_284A(0, -1500, 200, "none");
      var_0 _id_284A(-1500, -1500, 200, "none");
      var_0 _id_284A(-1500, 0, 0, "none");
      var_0 _id_284A(-1000, 1000, -200, "none");
      var_0 _id_284A(0, 1000, -200, "none");
      var_0 _id_284A(1000, 1000, -200, "none");
      break;
    case "random":
      var_2 = [];
      var_2[0] = "strafe_left_right";
      var_2[1] = "strafe_right_left";
      var_2[2] = "360_clockwise";
      var_2[3] = "360_counter_clockwise";
      return _id_2846(var_0, var_2[randomint(var_2.size)]);
  }

  var_3 = _id_284C(var_0);
  return var_3;
}

_id_2847(var_0, var_1) {
  var_0 notify("taking_evasive_actions");
  var_0 endon("taking_evasive_actions");
  var_0 endon("death");
  var_0 notify("evasive_action_done");
  thread _id_2849(var_0);

  if(getdvar("cobrapilot_debug") == "1") {
    var_0 _id_284D(var_1);

  }
  var_0 setneargoalnotifydist(1500);
  var_0 vehicle_setspeed(100, 30, 30);
  var_2 = var_0.angles[1];

  for(var_3 = 1; var_3 < var_1.size; var_3++) {
    if(isDefined(var_1[var_3 + 1])) {
      var_4 = vectortoangles(var_1[var_3 + 1]["pos"] - var_1[var_3]["pos"]);
    } else {
      var_4 = (0, var_2, 0);

    }
    var_5 = var_4[1];

    if(var_1[var_3]["goalYawMethod"] == "average") {
      var_5 = (var_4[1] + var_2) / 2;
    } else if(var_1[var_3]["goalYawMethod"] == "forward") {
      var_5 = var_0.angles[1];

    }
    if(getdvar("cobrapilot_debug") == "1") {
      thread maps\_utility::_id_2655(var_1[var_3]["pos"], var_1[var_3]["pos"] + anglesToForward((0, var_5, 0)) * 250, 1.0, 1.0, 0.2, var_0, "evasive_action_done");

    }
    var_0 settargetyaw(var_5);
    var_0 thread maps\_vehicle::_id_2848(var_1[var_3]["pos"], 0);
    var_0 waittill("near_goal");
  }

  var_0 notify("evasive_action_done");
  var_0 thread maps\_utility::_id_269A();
}

_id_2849(var_0) {
  var_0 notify("end_maneuvers");
  var_0 endon("end_maneuvers");
  var_0 endon("evasive_action_done");
  var_0 endon("death");
  var_0 waittill("missile_lock_ended");
  var_0 thread maps\_utility::_id_269A();
}

_id_284A(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_284B)) {
    self._id_284B = [];
    self._id_284B[0]["pos"] = self.origin;
    self._id_284B[0]["ang"] = (0, self.angles[1], 0);
  }

  var_4 = self._id_284B.size;

  if(!isDefined(var_3)) {
    var_3 = "none";

  }
  if(!isDefined(var_2)) {
    var_2 = 0;

  }
  self._id_284B[var_4]["forward"] = var_0;
  self._id_284B[var_4]["side"] = var_1;
  self._id_284B[var_4]["up"] = var_2;
  var_5 = anglesToForward(self._id_284B[0]["ang"]);
  var_6 = anglestoright(self._id_284B[0]["ang"]);
  self._id_284B[var_4]["pos"] = self._id_284B[var_4 - 1]["pos"] + var_5 * self._id_284B[var_4]["forward"] + var_6 * self._id_284B[var_4]["side"] + (0, 0, var_2);
  self._id_284B[var_4]["goalYawMethod"] = var_3;
}

_id_284C(var_0) {
  var_1 = var_0._id_284B;
  var_0._id_284B = undefined;
  return var_1;
}

_id_284D(var_0) {
  for(var_1 = 1; var_1 < var_0.size; var_1++) {
    thread maps\_utility::_id_2655(var_0[var_1 - 1]["pos"], var_0[var_1]["pos"], 1.0, 0.2, 0.2, self, "evasive_action_done");
  }
}

_id_284E(var_0) {
  var_0 endon("death");
  level._id_284F endon("death");
  var_1 = 2200;
  var_2 = 1500;
  var_3 = 0;
  var_4 = 1.0;
  var_5 = 1.2;
  var_6 = 50;
  var_7 = 60;
  var_8 = 2000;
  var_9 = _id_2851();
  var_10 = 0.0;
  var_11 = gettime();
  var_12 = _id_2850(var_1, var_2, var_3);
  var_0 vehicle_setspeed(30, 20, 20);
  var_0 settargetyaw(level._id_284F.angles[1]);
  var_0 setvehgoalpos(var_12, 1);

  for(;;) {
    var_12 = _id_2850(var_1, var_2, var_3);

    if(getdvar("cobrapilot_debug") == "1") {
      thread common_scripts\utility::draw_line_for_time(level._id_284F.origin, var_12, 0, 1, 0, var_4);
      thread common_scripts\utility::draw_line_for_time(level._id_284F.origin, var_0.origin, 0, 0, 1, var_4);
      thread common_scripts\utility::draw_line_for_time(var_0.origin, var_12, 1, 1, 0, var_4);
    }

    var_13 = gettime();

    if(var_13 >= var_11 + var_8) {
      var_11 = var_13;
      var_10 = var_9;
      var_9 = _id_2851();
    }

    var_14 = 0;
    var_15 = 0;

    if(var_10 > 20) {
      var_15 = var_10;
      var_14 = 1;
    } else if(var_10 <= 20 && _id_2851() > 20) {
      var_15 = _id_2851();
      var_14 = 1;
    }

    if(var_14 && var_15 > 0) {
      var_15 = var_15 * var_5;
      var_16 = var_6;
      var_17 = var_7;

      if(var_16 >= var_15 / 2) {
        var_16 = var_15 / 2;

      }
      if(var_17 >= var_15 / 2) {
        var_17 = var_15 / 2;

      }
      var_0 vehicle_setspeed(var_15, var_16, var_17);
      var_0 settargetyaw(level._id_284F.angles[1]);
      var_18 = 0;

      if(_id_2851() <= 30) {
        var_18 = 1;

      }
      if(getdvar("cobrapilot_debug") == "1") {
        iprintln("wingman speed: " + var_15 + " : " + var_18);

      }
      var_0 setvehgoalpos(var_12, var_18);
    }

    wait(var_4);
  }
}

_id_2850(var_0, var_1, var_2) {
  var_3 = anglesToForward(common_scripts\utility::flat_angle(level._id_284F.angles));
  var_4 = anglestoright(common_scripts\utility::flat_angle(level._id_284F.angles));
  var_5 = level._id_284F.origin + var_3 * var_0 + var_4 * var_1 + (0, 0, var_2);
  return var_5;
}

_id_2851() {
  return level._id_284F vehicle_getspeed();
}