/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\helicopter_ai.gsc
***********************************************/

function evasive_think(var0) {
  var0 endon("death");

  while(var0.health > 0) {
    var0 waittill("missile_lock", var1);
    var2 = evasive_createmaneuvers(var0, "random");
    evasive_startmaneuvers(var0, var2);
    wait 0.05;
  }
}

function evasive_createmaneuvers(var0, var1) {
  switch (var1) {
    case "strafe_left_right":
      evasive_addpoint(var0, 3000, -1500, 500, "average");
      evasive_addpoint(var0, 6000, 3000, -700, "average");
      evasive_addpoint(var0, 3000, -1500, 200, "average");
      break;
    case "strafe_right_left":
      evasive_addpoint(var0, 3000, 1500, 500, "average");
      evasive_addpoint(var0, 6000, -3000, -700, "average");
      evasive_addpoint(var0, 3000, 1500, 200, "average");
      break;
    case "360_clockwise":
      evasive_addpoint(var0, 1500, 1500, 200, "none");
      evasive_addpoint(var0, 0, 1500, 200, "none");
      evasive_addpoint(var0, -1500, 1500, 200, "none");
      evasive_addpoint(var0, -1500, 0, 0, "none");
      evasive_addpoint(var0, -1000, -1000, -200, "none");
      evasive_addpoint(var0, 0, -1000, -200, "none");
      evasive_addpoint(var0, 1000, -1000, -200, "none");
      break;
    case "360_counter_clockwise":
      evasive_addpoint(var0, 1500, -1500, 200, "none");
      evasive_addpoint(var0, 0, -1500, 200, "none");
      evasive_addpoint(var0, -1500, -1500, 200, "none");
      evasive_addpoint(var0, -1500, 0, 0, "none");
      evasive_addpoint(var0, -1000, 1000, -200, "none");
      evasive_addpoint(var0, 0, 1000, -200, "none");
      evasive_addpoint(var0, 1000, 1000, -200, "none");
      break;
    case "random":
      var2 = [];
      GscBinSkip0(0x2e, 0, "strafe_left_right");
  }

  var3 = evasive_getallpoints(var1);
  return var3;
}

function evasive_startmaneuvers(var0, var1) {
  var0 notify("taking_evasive_actions");
  var0 endon("taking_evasive_actions");
  var0 endon("death");
  var0 notify("evasive_action_done");
  thread evasive_endmaneuvers(var0);

  if(getDvar("cobrapilot_debug") == "1") {
    evasive_drawpoints(var0, var1);
  }

  var0 setneargoalnotifydist(1500);
  var0 vehicle_setspeed(100, 30, 30);
  var2 = var0.angles[1];

  for(var3 = 1; var3 < var1.size; var3++) {
    if(isDefined(var1[var3 + 1])) {
      var4 = vectortoangles(var1[var3 + 1]["pos"] - var1[var3]["pos"]);
    } else {
      var4 = (0, var2, 0);
    }

    var5 = var4[1];

    if(var1[var3]["goalYawMethod"] == "average") {
      var5 = (var4[1] + var2) / 2;
    } else if(var1[var3]["goalYawMethod"] == "forward") {
      var5 = var0.angles[1];
    }

    if(getDvar("cobrapilot_debug") == "1") {
      thread scripts\engine\sp\utility::draw_line_until_notify(var1[var3]["pos"], var1[var3]["pos"] + anglesToForward((0, var5, 0)) * 250, 1, 1, 0.2, var0, "evasive_action_done");
    }

    var0 settargetyaw(var5);
    var0 thread scripts\common\vehicle_code::setvehgoalpos_wrap(var1[var3]["pos"], 0);
    var0 waittill("near_goal");
  }

  var0 notify("evasive_action_done");
  var0 thread scripts\common\utility::vehicle_resumepath();
}

function evasive_endmaneuvers(var0) {
  var0 notify("end_maneuvers");
  var0 endon("end_maneuvers");
  var0 endon("evasive_action_done");
  var0 endon("death");
  var0 waittill("missile_lock_ended");
  var0 thread scripts\common\utility::vehicle_resumepath();
}

function evasive_addpoint(var0, var1, var2, var3) {
  if(!isDefined(self.evasive_points)) {
    self.evasive_points = [];
    self.evasive_points[0]["pos"] = self.origin;
    self.evasive_points[0]["ang"] = (0, self.angles[1], 0);
  }

  var4 = self.evasive_points.size;

  if(!isDefined(var3)) {
    var3 = "none";
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  self.evasive_points[var4]["forward"] = var0;
  self.evasive_points[var4]["side"] = var1;
  self.evasive_points[var4]["up"] = var2;
  var5 = anglesToForward(self.evasive_points[0]["ang"]);
  var6 = anglestoright(self.evasive_points[0]["ang"]);
  self.evasive_points[var4]["pos"] = self.evasive_points[var4 - 1]["pos"] + var5 * self.evasive_points[var4]["forward"] + var6 * self.evasive_points[var4]["side"] + (0, 0, var2);
  self.evasive_points[var4]["goalYawMethod"] = var3;
}

function evasive_getallpoints(var0) {
  var1 = var0.evasive_points;
  var0.evasive_points = undefined;
  return var1;
}

function evasive_drawpoints(var0) {
  for(var1 = 1; var1 < var0.size; var1++) {
    thread scripts\engine\sp\utility::draw_line_until_notify(var0[var1 - 1]["pos"], var0[var1]["pos"], 1, 0.2, 0.2, self, "evasive_action_done");
  }
}

function wingman_think(var0) {
  var0 endon("death");
  level.playervehicle endon("death");
  var1 = 2200;
  var2 = 1500;
  var3 = 0;
  var4 = 1;
  var5 = 1.2;
  var6 = 50;
  var7 = 60;
  var8 = 2000;
  var9 = getplayerhelispeed();
  var10 = 0;
  var11 = gettime();
  var12 = wingman_getgoalpos(var1, var2, var3);
  var0 vehicle_setspeed(30, 20, 20);
  var0 settargetyaw(level.playervehicle.angles[1]);
  var0 setvehgoalpos(var12, 1);

  for(;;) {
    var12 = wingman_getgoalpos(var1, var2, var3);

    if(getDvar("cobrapilot_debug") == "1") {
      thread scripts\engine\utility::draw_line_for_time(level.playervehicle.origin, var12, 0, 1, 0, var4);
      thread scripts\engine\utility::draw_line_for_time(level.playervehicle.origin, var0.origin, 0, 0, 1, var4);
      thread scripts\engine\utility::draw_line_for_time(var0.origin, var12, 1, 1, 0, var4);
    }

    var13 = gettime();

    if(var13 >= var11 + var8) {
      var11 = var13;
      var10 = var9;
      var9 = getplayerhelispeed();
    }

    var14 = 0;
    var15 = 0;

    if(var10 > 20) {
      var15 = var10;
      var14 = 1;
    } else if(var10 <= 20 && getplayerhelispeed() > 20) {
      var15 = getplayerhelispeed();
      var14 = 1;
    }

    if(var14 && var15 > 0) {
      var15 *= var5;
      var16 = var6;
      var17 = var7;

      if(var16 >= var15 / 2) {
        var16 = var15 / 2;
      }

      if(var17 >= var15 / 2) {
        var17 = var15 / 2;
      }

      var0 vehicle_setspeed(var15, var16, var17);
      var0 settargetyaw(level.playervehicle.angles[1]);
      var18 = 0;

      if(getplayerhelispeed() <= 30) {
        var18 = 1;
      }

      if(getDvar("cobrapilot_debug") == "1") {
        iprintln("wingman speed: " + var15 + " : " + var18);
      }

      var0 setvehgoalpos(var12, var18);
    }

    wait var4;
  }
}

function wingman_getgoalpos(var0, var1, var2) {
  var3 = anglesToForward(scripts\engine\utility::flat_angle(level.playervehicle.angles));
  var4 = anglestoright(scripts\engine\utility::flat_angle(level.playervehicle.angles));
  var5 = level.playervehicle.origin + var3 * var0 + var4 * var1 + (0, 0, var2);
  return var5;
}

function getplayerhelispeed() {
  return level.playervehicle vehicle_getspeed();
}