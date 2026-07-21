/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\stayahead.gsc
***********************************************/

stayahead_thread(var_0) {
  self endon("death");
  self endon("stop_stayahead");

  if(!isDefined(self.stayahead))
    self.stayahead = spawnStruct();

  if(!scripts\engine\utility::ent_flag_exist("stayahead_pause"))
    scripts\engine\utility::ent_flag_init("stayahead_pause");

  thread stayahead_watch_end();
  childthread pause_flag_monitor();
  var_1 = anglesToForward(self.angles);
  var_2 = anglesToForward(self.angles);
  var_3 = "";
  var_4 = "";
  var_5 = get_goalpos();
  var_6 = [self.origin];
  var_7 = undefined;
  var_8 = undefined;
  self.stayahead.lookat_last = gettime();
  self.stayahead.exit_speed = undefined;
  self.stayahead.exit_finish_time = undefined;
  self.stayahead.exit_last_finish_time = undefined;
  self.stayahead.wait_node_radius = 400;
  self.stayahead.dir = anglesToForward(self.angles);

  if(!isDefined(self.stayahead.p1))
    self.stayahead.p1 = [];

  for(;;) {
    if(isDefined(self.stayahead.team) && !isDefined(self.stayahead.team_thinking))
      thread stayahead_team_think();

    var_9 = var_5;
    var_5 = get_goalpos();

    if(var_9[0] != var_5[0])
      var_6 = var_9;

    if(isDefined(self.stayahead.turbo)) {
      var_10 = self.stayahead.turbo;
      var_11 = self.stayahead.turbo;
      var_12 = self.stayahead.turbo;
      var_13 = self.stayahead.turbo;
      var_14 = 0;
      var_15 = 0;
      var_16 = 0;
      var_17 = 0;
    } else {
      var_10 = self.stayahead.p1["speed"];
      var_11 = self.stayahead.p2["speed"];
      var_12 = self.stayahead.p3["speed"];
      var_13 = self.stayahead.p4["speed"];
      var_14 = scripts\engine\utility::ter_op(isDefined(self.stayahead.p1["variance"]), self.stayahead.p1["variance"], 0.2);
      var_15 = scripts\engine\utility::ter_op(isDefined(self.stayahead.p2["variance"]), self.stayahead.p2["variance"], 0.2);
      var_16 = scripts\engine\utility::ter_op(isDefined(self.stayahead.p3["variance"]), self.stayahead.p3["variance"], 0.2);
      var_17 = scripts\engine\utility::ter_op(isDefined(self.stayahead.p4["variance"]), self.stayahead.p4["variance"], 0.2);
    }

    var_18 = self.stayahead.p1["distance"];
    var_19 = self.stayahead.p2["distance"];
    var_20 = self.stayahead.p3["distance"];
    var_21 = self.stayahead.p4["distance"];
    var_22 = undefined;
    var_23 = undefined;
    var_24 = undefined;

    if(isDefined(self.stayahead.pw)) {
      var_22 = self.stayahead.pw["distance"];
      var_23 = self.stayahead.pw["speed"];
      var_24 = scripts\engine\utility::ter_op(isDefined(self.stayahead.pw["buffer"]), self.stayahead.pw["buffer"], 1.5);
      var_24 = var_24 * 20;
    }

    var_25 = scripts\engine\utility::flat_origin(self getposonpath(32));
    var_26 = scripts\engine\utility::flat_origin(var_5[0]);
    var_27 = scripts\engine\utility::flat_origin(var_6[0]);
    var_28 = scripts\engine\utility::flat_origin(self.origin);

    if(self isinscriptedstate()) {
      if(isDefined(self.stayahead.exit_speed) && !isDefined(self.stayahead.exit_finish_time)) {
        self.stayahead.exit_finish_time = gettime();
        self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
      } else {
        self.stayahead.exit_speed = undefined;
        self.stayahead.exit_finish_time = undefined;
      }

      print2d3d_debug(self.origin + (0, 0, 30), "dir: SCRIPTED ANIM: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
    } else if(isDefined(self.asm) && isDefined(self.asm.arriving) || distancesquared(var_26, var_28) < 1024) {
      if(isDefined(self.stayahead.exit_speed) && !isDefined(self.stayahead.exit_finish_time)) {
        self.stayahead.exit_finish_time = gettime();
        self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
      } else {
        self.stayahead.exit_speed = undefined;
        self.stayahead.exit_finish_time = undefined;
      }

      if(isDefined(self.goalnode) && istrue(self.goalnode.script_useangles)) {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: arriving/close USEANGLES OVERRIDE vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        var_1 = lerp_plane_vector(var_1, anglesToForward(self.goalnode.angles));
      } else if(isDefined(var_5[1])) {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: arriving/close GOAL vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        var_26 = scripts\engine\utility::flat_origin(var_5[1]);
        var_1 = lerp_plane_vector(var_1, vectorNormalize(var_26 - var_28));
      } else {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: arriving/close FWD vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        var_1 = lerp_plane_vector(var_1, anglesToForward(self.angles));
      }
    } else if(istrue(self.isplayingexitanim) || distancesquared(var_27, var_28) < 1024) {
      if(istrue(self.isplayingexitanim) && !isDefined(self.stayahead.exit_speed))
        self.stayahead.exit_speed = -1;

      if(isDefined(self.using_goto_node)) {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: exiting GOTO vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        var_26 = scripts\engine\utility::flat_origin(var_5[0]);
        var_1 = lerp_plane_vector(var_1, vectorNormalize(var_26 - var_27));
      } else if(isDefined(var_5[1])) {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: exiting GOAL vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        var_26 = scripts\engine\utility::flat_origin(var_5[1]);
        var_1 = lerp_plane_vector(var_1, vectorNormalize(var_26 - var_27));
      } else {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: exiting FWD vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        var_1 = lerp_plane_vector(var_1, anglesToForward(self.angles));
      }
    } else {
      if(isDefined(self.stayahead.exit_speed) && !isDefined(self.stayahead.exit_finish_time)) {
        self.stayahead.exit_finish_time = gettime();
        self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
      } else {
        self.exit_speed = undefined;
        self.exit_finish_time = undefined;
      }

      print2d3d_debug(self.origin + (0, 0, 30), "dir: stopped or moving to new goal: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);

      if(distance(var_25, var_28) < 1) {
        print_debug("STAYAHEAD: segments are colliding! " + gettime());
        var_1 = lerp_plane_vector(var_1, vectorNormalize(var_26 - var_25));
      } else
        var_1 = lerp_plane_vector(var_1, vectorNormalize(var_25 - var_28));
    }

    var_29 = self.origin + var_1 * var_19;
    var_30 = self.origin + var_1 * var_20;
    var_31 = self.origin + var_1 * var_21;
    var_32 = distance(var_29, var_30) * 0.25;
    var_33 = distance(var_29, var_30) * 0.6;
    var_34 = distance(var_29, var_30) * 0.25;
    var_35 = distance(var_30, var_31) * 0.6;
    var_36 = distance(var_30, var_31) * 0.25;
    var_37 = distance(var_30, var_31) * 0.6;
    var_38 = vectordot(vectorNormalize(var_0.origin - var_29), var_1);
    var_39 = vectordot(vectorNormalize(var_0.origin - var_30), var_1);
    var_40 = vectordot(vectorNormalize(var_0.origin - var_31), var_1);
    var_41 = undefined;
    var_42 = undefined;
    var_43 = undefined;
    var_44 = undefined;

    if(isDefined(var_18)) {
      var_41 = self.origin + var_1 * var_18;
      var_42 = vectordot(vectorNormalize(var_0.origin - var_41), var_1);
      var_43 = distance(var_41, var_29) * 0.25;
      var_44 = distance(var_41, var_29) * 0.6;
      var_32 = distance(var_41, var_29) * 0.25;
    }

    var_45 = undefined;
    var_46 = undefined;

    if(isDefined(var_22)) {
      var_45 = self.origin + var_1 * var_22;
      var_46 = vectordot(vectorNormalize(var_0.origin - var_45), var_1);
    }

    if(scripts\engine\utility::ent_flag("stayahead_pause")) {
      waitframe();
      continue;
    }

    if(isDefined(var_46)) {
      if(!isDefined(self.stayahead.pw_behind_buffer))
        self.stayahead.pw_behind_buffer = 0;

      if(!isDefined(self.stayahead.pw_infront_buffer))
        self.stayahead.pw_infront_buffer = 0;

      if(var_46 < 0) {
        self.stayahead.pw_infront_buffer = 0;

        if(!isDefined(self.stayahead.goalnode)) {
          if(isDefined(self.using_goto_node))
            self.stayahead.goalnode = self.patharray[self.patharray.size - 1];
          else if(isDefined(self.goalnode))
            self.stayahead.goalnode = self.goalnode;
          else
            print3d_debug(self.origin, "pw no goalnode, goalpos?", (1, 0, 0), 1, 0.5, 200, 1);
        }

        if(isDefined(self.stayahead.goalnode) && !isDefined(self.stayahead.goalnode_pw) && self.stayahead.pw_behind_buffer > var_24) {
          var_59 = get_wait_node();

          if(isDefined(var_59) && distance(self.origin, var_59.origin) <= self.stayahead.wait_node_radius && distance(self.origin, var_59.origin) > 32 && stayahead_goal_is_far_enough(var_59)) {
            self.stayahead.goalnode_pw = var_59;
            line_debug(self.origin, self.origin + var_1 * -100, (1, 1, 1), 1, 0, 500);
            line_debug(self.origin, var_59.origin, (1, 0, 0), 1, 0, 500);
            print3d_debug(self.origin, "going to pW node: " + distance(self.origin, var_59.origin) + " GoalRadius: " + self.goalradius, (1, 1, 0), 1, 0.3, 500, 1);
            childthread stayahead_wait_set_goal_or_path();
            childthread stayahead_set_goalnode(var_59, 1);
          } else if(!isDefined(var_59))
            print2d3d_debug(self.origin + (0, 0, 16), "pW fail no wait nodes", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
          else if(distance(self.origin, var_59.origin) >= self.stayahead.wait_node_radius) {
            line_debug(self.origin, var_59.origin, (1, 0, 0), 1, 0, 1);
            print2d3d_debug(self.origin + (0, 0, 16), "pW fail wait node too far: " + distance(self.origin, var_59.origin), (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
          } else if(distance(self.origin, var_59.origin) < 32) {
            line_debug(self.origin, var_59.origin, (1, 0, 0), 1, 0, 1);
            print2d3d_debug(self.origin + (0, 0, 16), "pW fail wait node too close: " + distance(self.origin, var_59.origin), (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
          }
        } else if(!isDefined(self.stayahead.goalnode))
          print2d3d_debug(self.origin + (0, 0, 16), "pW fail no goalnode or goto", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
        else if(isDefined(self.stayahead.goalnode_pw))
          print2d3d_debug(self.origin + (0, 0, 16), "pW fail already have wait node", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
        else if(self.stayahead.pw_behind_buffer < var_24)
          print2d3d_debug(self.origin + (0, 0, 16), "pW fail buffer too small", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
        else
          print2d3d_debug(self.origin + (0, 0, 16), "pW fail uh oh!", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);

        self.stayahead.pw_behind_buffer = self.stayahead.pw_behind_buffer + 1;

        if(self.stayahead.pw_behind_buffer > var_24)
          print2d3d_debug(self.origin + (0, 0, 12), "pW behind buffer: " + self.stayahead.pw_behind_buffer, (1, 0, 0), 1, 0.3, 1, 0, "right", 7);
        else
          print2d3d_debug(self.origin + (0, 0, 12), "pW behind buffer: " + self.stayahead.pw_behind_buffer, (0, 0, 1), 1, 0.3, 1, 0, "right", 7);
      } else if(isDefined(self.stayahead.goalnode) && isDefined(self.stayahead.goalnode_pw)) {
        self.stayahead.pw_behind_buffer = 0;

        if(var_40 > 0 && self.stayahead.pw_infront_buffer > var_24 * 0.4 || var_39 > 0) {
          print3d_debug(self.origin, "going to OG goal: " + distance(self.origin, self.stayahead.goalnode.origin), (0, 1, 0), 1, 0.3, 500, 1);
          self.stayahead.goalnode_pw = undefined;
          childthread stayahead_set_goalnode(self.stayahead.goalnode, 0);
          self.stayahead.goalnode = undefined;
        }

        self.stayahead.pw_infront_buffer = self.stayahead.pw_infront_buffer + 1;
        print2d3d_debug(self.origin + (0, 0, 12), "pW infront buffer: " + self.stayahead.pw_infront_buffer, (0, 1, 0), 1, 0.3, 1, 0, "right", 7);
      } else {
        self notify("stop_stayahead_wait_func");
        self.stayahead.pw_behind_buffer = 0;
        print2d3d_debug(self.origin + (0, 0, 12), "pW failing???", (1, 0, 0), 1, 0.3, 1, 0, "right", 5);
      }
    }

    if(isDefined(var_42) && var_42 > 0) {
      if(var_3 != "p1Front") {
        var_4 = var_3;
        var_3 = "p1Front";
      }

      stayahead_set_speed(1, var_0, var_18 + var_43, var_18, var_1, var_10, var_10 + var_10 * var_14, 1);
    } else if(var_38 > 0) {
      if(var_3 != "p2Front") {
        var_4 = var_3;
        var_3 = "p2Front";
      }

      if(var_4 == "p3Front" || var_4 == "")
        stayahead_set_speed(2, var_0, var_19 + var_32, var_19, var_1, var_11, var_11 + var_11 * var_15);
      else if(isDefined(var_42))
        stayahead_set_speed(1, var_0, var_18, var_18 - var_44, var_1, var_10 + var_10 * var_14 * -1, var_10, 1);
      else
        stayahead_set_speed(2, var_0, var_19 + var_32, var_19, var_1, var_11, var_11 + var_11 * var_15);
    } else if(var_39 > 0) {
      if(var_3 != "p3Front") {
        var_4 = var_3;
        var_3 = "p3Front";
        stayahead_lookat(var_0);
      }

      if(var_4 == "p4Front" || var_4 == "")
        stayahead_set_speed(3, var_0, var_20 + var_34, var_20, var_1, var_12, var_12 + var_12 * var_16);
      else
        stayahead_set_speed(2, var_0, var_19, var_19 - var_33, var_1, var_11 + var_11 * var_15 * -1, var_11);
    } else if(var_40 > 0) {
      if(var_3 != "p4Front") {
        var_4 = var_3;
        var_3 = "p4Front";
        stayahead_lookat(var_0);
      }

      if(var_4 == "p4Back" || var_4 == "")
        stayahead_set_speed(4, var_0, var_21 + var_36, var_21, var_1, var_13, var_13 + var_13 * var_17);
      else
        stayahead_set_speed(3, var_0, var_20, var_20 - var_35, var_1, var_12 + var_12 * var_16 * -1, var_12);
    } else if(var_40 < 0) {
      if(isDefined(var_46) && var_46 < 0) {}

      if(var_3 != "p4Back") {
        var_4 = var_3;
        var_3 = "p4Back";
        stayahead_lookat(var_0);
      }

      stayahead_set_speed("W", var_0, var_21, var_21 - var_37, var_1, var_13 + var_13 * var_17 * -1, var_13);
    } else
      print2d3d_debug(self.origin + (0, 0, 30), "uh oh!", (0.9, 0, 0), 0.9, 0.3, 250, 0, "right", 4);

    waitframe();
  }
}

stayahead_lookat(var_0) {
  if(!istrue(self.stayahead.lookat_allowed)) {
    return;
  }
  if(istrue(self.lookingatent)) {
    print3d_debug(self.origin + (0, 0, 50), "look skipped, already looking", (0.9, 0, 0), 0.9, 0.3, 250);
    return;
  }

  if(gettime() - self.stayahead.lookat_last < 3000) {
    print3d_debug(self.origin + (0, 0, 50), "look skipped, too soon", (0.9, 0, 0), 0.9, 0.3, 250);
    return;
  }

  self notify("stop_stayahead_lookat");
  self endon("death");
  self endon("stop_stayahead_lookat");
  var_1 = 0.5;
  self.stayahead.lookat_last = gettime();
  childthread stayahead_lookat_debug(var_1);
  scripts\common\utility::lookatentity(var_0);
  scripts\engine\utility::delaythread(var_1, scripts\common\utility::lookatentity);
  wait(var_1 * 0.6);
}

stayahead_lookat_far(var_0) {
  self endon("death");
  var_1 = randomfloatrange(6000, 11000);

  if(gettime() > self.stayahead.lookat_last + var_1)
    stayahead_lookat(var_0);
}

stayahead_lookat_debug(var_0) {}

stayahead_set_speed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  print2d3d_debug(self.origin, "Plane: " + var_0, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 1);
  var_8 = self.origin + var_4 * var_2;
  var_9 = self.origin + var_4 * var_3;

  if(distance(var_8, var_9) < 1)
    print_debug("segments are colliding, not setting speed! " + gettime());
  else {
    var_10 = pointonsegmentnearesttopoint(var_8, var_9, var_1.origin);
    var_11 = distance(var_8, var_10);
    var_12 = var_2 - var_3;
    var_13 = 1 - scripts\engine\math::lerp_fraction(0, abs(var_12), var_11);
    var_14 = 250;

    if(isDefined(self.stayahead.turbo) || istrue(var_7))
      var_14 = 300;

    if(!isDefined(self.stayahead.exit_last_finish_time) || gettime() > self.stayahead.exit_last_finish_time + 1000) {
      var_15 = scripts\engine\math::lerp(var_5, var_6, var_13);
      var_15 = clamp(var_15, 23, var_14);
      var_16 = self aigetdesiredspeed();
      var_17 = var_15 - var_16;

      if(istrue(var_7) || var_17 > 50) {
        if(!istrue(var_7) && !isDefined(self.stayahead.last_speed_set_time)) {
          var_15 = var_16 + clamp(var_17, -2, 2);
          self.stayahead.last_speed_set_time = undefined;
          print3d_debug(self.origin + (0, 0, 32), "StayAhead STARTUP! plane: " + var_0 + " diff: " + var_17 + " curSpeed: " + var_16 + " speed: " + var_15, (1, 1, 1), 1, 0.1, 100, 1);
          print_console_debug("StayAhead STARTUP! plane: " + var_0 + " diff: " + var_17 + " curSpeed: " + var_16 + " speed: " + var_15);
        } else {
          var_15 = var_16 + clamp(var_17, -10, 10);
          self.stayahead.last_speed_set_time = gettime();
          print3d_debug(self.origin + (0, 0, 32), "StayAhead CATCHUP! plane: " + var_0 + " diff: " + var_17 + " curSpeed: " + var_16 + " speed: " + var_15, (1, 1, 1), 1, 0.1, 100, 1);
          print_console_debug("StayAhead CATCHUP! plane: " + var_0 + " diff: " + var_17 + " curSpeed: " + var_16 + " speed: " + var_15);
        }
      } else if(isDefined(self.stayahead_accel)) {
        var_15 = var_16 + clamp(var_17, -1 * self.stayahead_accel, self.stayahead_accel);
        self.stayahead.last_speed_set_time = gettime();
      } else {
        var_15 = var_16 + clamp(var_17, -3.5, 3.5);
        self.stayahead.last_speed_set_time = gettime();
      }

      scripts\engine\utility::set_movement_speed(var_15);

      if(isDefined(self.stayahead.exit_speed) && self.stayahead.exit_speed == -1)
        self.stayahead.exit_speed = var_15;

      line_debug(var_1.origin, var_10);
      print2d3d_debug(self.origin + (0, 0, 8), "speed: " + var_15, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 2);
      print3d_debug(var_10 + (0, 0, 8), var_15, (0.9, 0.9, 0.9), 0.9, 0.3);
      return;
    }

    print3d_debug(self.origin + (0, 0, 8), "IsExiting, not setting speed: " + gettime(), (0.9, 0, 0), 0.9, 0.3, 1);
  }
}

get_best_goto_node(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = undefined;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    if(!isDefined(var_0[var_5])) {
      break;
    }

    var_2[var_5] = vectordot(vectorNormalize(var_0[var_5].origin - self.origin), self.stayahead.dir);

    if(var_2[var_5] < 0) {
      var_1 = var_1 + 1;
      continue;
    }

    if(var_2[var_5] > 0.5) {
      print3d_debug(var_0[var_5].origin, "GOTO GOOD ENOUGH re-start: " + var_2[var_5], (0, 1, 0), 1, 0.3, 200, 1);
      var_4 = 1;
      var_3 = var_5;
      break;
    }

    if(var_2[var_5] > var_2[var_3])
      var_3 = var_5;
  }

  return var_0[var_3];
}

get_goto_nodes(var_0) {
  if(isDefined(self.patharray))
    var_0 = scripts\engine\utility::array_combine(var_0, self.patharray);

  return var_0;
}

get_goalpos() {
  var_0 = [];

  if(isDefined(self.goalnode)) {
    var_0[0] = self.goalnode.origin;

    if(isDefined(self.goalnode.target)) {
      var_1 = self.goalnode get_node_or_struct();

      if(isDefined(var_1))
        var_0[1] = var_1.origin;
    } else if(isDefined(self.stayahead.goalnode) && isDefined(self.stayahead.goalnode_pw) && self.goalnode == self.stayahead.goalnode_pw)
      var_0[1] = self.stayahead.goalnode.origin;
  } else
    var_0[0] = self.scriptgoalpos;

  return var_0;
}

get_node_or_struct() {
  var_0 = getnode(self.target, "targetname");

  if(isDefined(var_0))
    return var_0;
  else
    var_0 = scripts\engine\utility::getStruct(self.target, "targetname");

  return var_0;
}

get_wait_node(var_0) {
  var_1 = [];

  if(isDefined(self.stayahead.wait_nodes)) {
    var_1 = self.stayahead.wait_nodes;
    var_1 = sortbydistance(var_1, self.origin);
  } else if(!isDefined(self.stayahead.use_goto_wait))
    var_1 = getnodesinradiussorted(self.origin, self.stayahead.wait_node_radius, 0, 64, "cover");

  if(isDefined(self.using_goto_node) && istrue(self.stayahead.use_goto_wait)) {
    var_1 = scripts\engine\utility::array_combine(var_1, get_goto_nodes(var_1));
    var_1 = sortbydistance(var_1, self.origin);
  }

  var_2 = 0.75;

  foreach(var_8, var_4 in var_1) {
    var_5 = vectordot(vectorNormalize(var_4.origin - self.origin), self.stayahead.dir);
    var_6 = scripts\engine\utility::ter_op(isDefined(self.goalnode) && var_4 == self.goalnode, 0, 1);
    var_7 = scripts\engine\utility::ter_op(isDefined(self.goalpos) && var_4.origin == self.goalpos, 0, 1);

    if(!isDefined(var_4.stayahead_wait_used) && !isDefined(var_4.script_dontremove) && var_5 >= var_2 && var_6 && var_7) {
      if(isDefined(self.script_forcecolor) && isDefined(var_4.script_color_allies) && issubstr(var_4.script_color_allies, self.script_forcecolor)) {
        line_debug(self.origin, var_4.origin, (0, 1, 0), 1, 0, 1);
        var_4 thread node_display_debug(var_4.origin, var_4.script_color_allies, (0, 1, 0), 1, 0.2, 1000, 1);
      } else if(isDefined(self.script_forcecolor) && !isDefined(self.stayahead.use_goto_wait)) {
        if(!isDefined(var_4.script_color_allies)) {
          if(isDefined(self.stayahead.wait_nodes) && !isDefined(scripts\engine\utility::array_find(self.stayahead.wait_nodes, var_4))) {
            var_4 thread node_display_debug(var_4.origin, "invalid: no color, removing", (1, 0, 1), 1, 0.2, 1000, 1);
            var_1 = scripts\engine\utility::array_remove(var_1, var_4);
          }
        } else if(!issubstr(var_4.script_color_allies, self.script_forcecolor)) {
          var_4 thread node_display_debug(var_4.origin, "invalid: wrong color, removing", (1, 0, 1), 1, 0.2, 1000, 1);
          var_1 = scripts\engine\utility::array_remove(var_1, var_4);
        }
      }

      continue;
    }

    if(!isDefined(var_4.script_dontremove)) {
      if(isDefined(var_4.stayahead_wait_used))
        var_4 thread node_display_debug(var_4.origin, "invalid: used", (1, 0, 1), 1, 0.2, 1000, 1);
      else if(var_5 < 0)
        var_4 thread node_display_debug(var_4.origin, "removed: behind", (0, 0, 1), 1, 0.2, 1000, 1);
      else if(var_5 < var_2)
        var_4 thread node_display_debug(var_4.origin, "removed: bad angle: " + var_5, (1, 0, 0), 1, 0.2, 1000, 1);
      else if(!var_6)
        var_4 thread node_display_debug(var_4.origin, "removed: IS goalNode", (1, 0, 0), 1, 0.2, 1000, 1);
      else if(!var_7)
        var_4 thread node_display_debug(var_4.origin, "removed: IS goalPos", (1, 0, 0), 1, 0.2, 1000, 1);
      else
        var_4 thread node_display_debug(var_4.origin, "invalid???", (1, 0, 1), 1, 0.2, 1000, 1);

      var_1 = scripts\engine\utility::array_remove(var_1, var_4);
    }
  }

  if(getdvarint("scr_debug_stayahead")) {
    foreach(var_8, var_4 in var_1)
    var_4 thread node_display_debug(var_4.origin, "wait node: " + var_8, (0, 1, 0), 1, 0.2, 1000, 1);
  }

  var_10 = undefined;

  if(var_1.size > 0) {
    var_11 = undefined;

    foreach(var_4 in var_1) {
      if(isnode(var_4)) {
        var_11 = var_4;
        break;
      }
    }

    var_10 = var_1[0];

    if(isstruct(var_1[0]) && isDefined(var_11)) {
      if(distance(var_1[0].origin, var_11.origin) < 128) {
        if(node_within_fov(var_11)) {
          print3d_debug(var_11.origin, "NEAREST NODE", (1, 1, 1), 1, 0.3, 1, 1);
          print3d_debug(self.origin, "STAYAHEAD: using closest 'node' bc it's not a struct!", (1, 1, 1), 1, 0.3, 100, 1);
          var_10 = var_11;
        }
      }
    }
  } else
    print3d_debug(self.origin, "STAYAHEAD: NO BEST WAIT NODE, RETURNING UNDEFINED!", (1, 0, 0), 1, 0.3, 100, 1);

  return var_10;
}

pause_flag_monitor() {
  for(;;) {
    scripts\engine\utility::ent_flag_wait("stayahead_pause");
    print3d_debug(self.origin + (0, 0, 16), "PAUSING stayahead", (0, 1, 1), 1, 0.3, 1000, 1);
    scripts\engine\utility::ent_flag_waitopen("stayahead_pause");
    print3d_debug(self.origin + (0, 0, 16), "UNpausing stayahead", (0, 1, 1), 1, 0.3, 1000, 1);
    self.stayahead.pw_behind_buffer = 0;
    self.stayahead.goalnode_pw = undefined;
  }
}

waitnode_trigger_think(var_0, var_1) {
  thread delay_endon(0.05, "goal_changed");
  self waittill("goal");
  thread scripts\sp\utility::stayahead_pause(1);
  childthread waitnode_trigger_debug(var_0, var_1);
  childthread waitnode_trigger_delay_speed_clear();
  var_2 = var_1 scripts\engine\utility::waittill_any_return("trigger", "death");
  thread scripts\sp\utility::stayahead_pause(0);
  childthread stayahead_set_goalnode(self.stayahead.goalnode, 0);
}

waitnode_trigger_delay_speed_clear() {
  waittillframeend;
  self.stayahead.last_speed_set_time = undefined;
}

waitnode_trigger_debug(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("trigger");
}

stayahead_watch_end() {
  self endon("death");

  if(!isDefined(self.stayahead))
    self.stayahead = spawnStruct();

  self.stayahead.active = 1;
  self waittill("stop_stayahead");

  if(isDefined(self.stayahead)) {
    if(isDefined(self.stayahead.active))
      self.stayahead.active = undefined;

    if(isDefined(self.stayahead.team_thinking))
      self.stayahead.team_thinking = undefined;
  }
}

stayahead_wait_func(var_0) {
  self endon("death");
  self endon("stop_stayahead");
  self notify("stop_stayahead_wait_func");
  self endon("stop_stayahead_wait_func");
  thread delay_endon(0.05, "goal_changed");
  stayahead_at_waitnode(var_0);
  self[[self.stayahead.wait_func]]();
}

stayahead_wait_set_goal_or_path() {
  if(isDefined(self.using_goto_node)) {
    self.stayahead.goto_patharray = self.patharray;
    self.stayahead.using_goto_node = 1;

    for(var_0 = 0; var_0 <= self.patharrayindex; var_0++) {
      if(self.stayahead.goto_patharray.size > 1) {
        print_console_debug("Removing go_to_node num: " + var_0);
        self.stayahead.goto_patharray = scripts\engine\utility::array_remove_index(self.stayahead.goto_patharray, 0);
      }
    }
  } else if(isDefined(self.goalnode))
    self.stayahead.goalnode = self.goalnode;
}

stayahead_at_waitnode(var_0) {
  thread delay_endon(0.05, "goal_changed");

  while(distance2dsquared(self.origin, var_0.origin) > 64) {
    print3d_debug(self.origin, "distanceSQ to waitnode: " + distance2dsquared(self.origin, var_0.origin), (1, 1, 1), 1, 0.3, 1, 1);
    waitframe();
  }
}

stayahead_goal_is_far_enough(var_0) {
  if(node_within_fov(self.stayahead.goalnode)) {
    if(distance(self.origin, self.stayahead.goalnode.origin) - distance(self.origin, var_0.origin) < 128) {
      print2d3d_debug(self.origin + (0, 0, 16), "pW fail goalnode too close: " + distance(self.origin, self.stayahead.goalnode.origin) + " Waitnode: " + distance(self.origin, var_0.origin), (1, 0, 0), 1, 0.3, 1, 0, "right", 5);
      return 0;
    }
  } else
    print2d3d_debug(self.origin + (0, 0, 16), "pW fail goalnode not within FOV.", (0, 1, 0), 1, 0.3, 1, 0, "right", 5);

  return 1;
}

node_within_fov(var_0) {
  if(isDefined(self.stayahead) && isDefined(self.stayahead.dir))
    var_1 = self.stayahead.dir;
  else
    var_1 = anglesToForward(self.angles);

  var_2 = vectordot(var_1, vectorNormalize(var_0.origin - self.origin));

  if(var_2 >= 0.9)
    return 1;

  return 0;
}

delay_endon(var_0, var_1) {
  wait(var_0);
  self endon(var_1);
}

stayahead_goto_can_use_wait(var_0) {
  if(isDefined(self.using_goto_node)) {
    if(isDefined(self.stayahead.goto_nextnode) && distance(self.origin, self.stayahead.goto_nextnode.origin) > distance(self.origin, var_0[0].origin))
      return 1;
    else
      return 0;
  } else
    return 1;
}

stayahead_set_goalnode(var_0, var_1) {
  if(isDefined(self.stayahead.spawned_wait_node))
    despawncovernode(self.stayahead.spawned_wait_node);

  if(!isDefined(var_0)) {
    return;
  }
  if(istrue(var_1)) {
    if(isstruct(var_0)) {
      var_2 = vectortoangles(self.stayahead.dir);
      var_0 = spawncovernode(var_0.origin, var_2, "Exposed");

      if(!isDefined(var_0)) {
        print3d_debug(self.origin + (0, 0, 8), "UNABLE TO SPAWN COVER NODE!", (1, 0, 0), 1, 0.3, 500, 1);
        return;
      }

      self.stayahead.spawned_wait_node = var_0;
    }

    var_0.stayahead_wait_used = 1;
    self notify("stayahead_going_to_wait_node");
    self notify("stop_going_to_node");
    scripts\engine\sp\utility::set_goal_node(var_0);

    if(isDefined(self.stayahead.goto_patharray) && var_0 == self.stayahead.goto_patharray[self.stayahead.goto_patharray.size - 1])
      self.stayahead.goto_finished = 1;

    if(isDefined(self.stayahead.wait_func))
      childthread stayahead_wait_func(var_0);

    var_3 = var_0 scripts\engine\utility::get_linked_ents();

    if(var_3.size > 0) {
      foreach(var_5 in var_3) {
        if(issubstr(var_5.code_classname, "trigger"))
          childthread waitnode_trigger_think(var_0, var_5);
      }

      return;
    }
  } else if(isDefined(self.stayahead.using_goto_node)) {
    self notify("stop_stayahead_wait_func");
    self notify("stayahead_leaving_wait_node");

    if(istrue(self.stayahead.goto_finished)) {
      print3d_debug(self.origin + (0, 0, 8), "last node wait node; go_to_node() path done!", (0, 1, 0), 1, 0.3, 500, 1);
      self.stayahead.goto_finished = undefined;
      self notify("reached_path_end");
    } else {
      print3d_debug(self.origin + (0, 0, 8), "going BACK to goto patharray", (0, 1, 0), 1, 0.3, 500, 1);
      thread scripts\sp\spawner::go_to_node(get_best_goto_node(self.stayahead.goto_patharray, 2));
      self.stayahead.using_goto_node = 1;
    }
  } else {
    self notify("stop_stayahead_wait_func");
    self notify("stayahead_leaving_wait_node");
    self notify("stop_going_to_node");
    scripts\engine\sp\utility::set_goal_node(var_0);
  }
}

stayahead_team_think() {
  self.stayahead.team_thinking = 1;
  self endon("death");
  self endon("stop_stayahead");
  var_0 = 0.8;
  var_1 = self.stayahead.p1["speed"];
  var_2 = self.stayahead.p2["speed"];
  var_3 = self.stayahead.p3["speed"];
  var_4 = self.stayahead.p4["speed"];
  var_5 = self.stayahead.p1["distance"];
  var_6 = self.stayahead.p2["distance"];
  var_7 = self.stayahead.p3["distance"];
  var_8 = self.stayahead.p4["distance"];
  childthread stayahead_team_debug();

  for(;;) {
    foreach(var_11, var_10 in self.stayahead.team) {
      if(!isDefined(var_10.stayahead.dynamic_frontdist))
        var_10.stayahead.dynamic_frontdist = 200;

      if(!isDefined(var_10.stayahead.dynamic_middist))
        var_10.stayahead.dynamic_middist = 125;

      if(!isDefined(var_10.stayahead.dynamic_backdist))
        var_10.stayahead.dynamic_backdist = 50;

      var_10 childthread scripts\engine\sp\utility::enable_dynamic_run_speed(self, var_4 * var_0, var_3 * var_0, var_2 * var_0, var_10.stayahead.dynamic_frontdist, var_10.stayahead.dynamic_middist, var_10.stayahead.dynamic_backdist);

      if(!isDefined(var_10.stayahead.dir))
        var_10.stayahead.dir = anglesToForward(self.angles);

      if(!isDefined(var_10.stayahead.wait_node_radius))
        var_10.stayahead.wait_node_radius = self.stayahead.wait_node_radius;
    }

    self waittill("stayahead_going_to_wait_node");

    foreach(var_10 in self.stayahead.team) {
      var_10 childthread stayahead_wait_set_goal_or_path();
      var_10 scripts\engine\sp\utility::disable_dynamic_run_speed(var_4);
      var_13 = var_10 get_wait_node(vectortoangles(var_10.angles));

      if(isDefined(var_13))
        var_10 childthread stayahead_set_goalnode(var_13, 1);
    }

    self waittill("stayahead_leaving_wait_node");

    foreach(var_10 in self.stayahead.team) {
      var_10.stayahead.dir = anglesToForward(var_10.angles);
      var_10.stayahead.using_goto_node = 1;
      var_10 childthread stayahead_set_goalnode(var_10.stayahead.goto_patharray[0], 0);
    }
  }
}

stayahead_team_debug() {
  self endon("stop_stayahead");

  for(;;) {
    foreach(var_1 in self.stayahead.team) {
      var_1 thread display_goto_path((1, 0, 1));
      line_debug(self.origin, var_1.origin, (1, 0, 1), 1, 0, 1);
    }

    waitframe();
  }
}

lerp_plane_vector(var_0, var_1) {
  var_2 = 0.03;
  var_3 = (var_1 - var_0) * var_2;
  var_4 = var_0 + var_3;
  self.stayahead.dir = var_4;
  return var_4;
}

print_debug(var_0) {}

print_console_debug(var_0) {}

print3d_debug(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

print2d3d_debug(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

create_2d_background() {}

create_2d_text(var_0, var_1, var_2, var_3, var_4) {}

line_debug(var_0, var_1, var_2, var_3, var_4, var_5) {}

sphere_debug(var_0, var_1, var_2, var_3, var_4) {
  if(getdvarint("scr_debug_stayahead"))
    return;
}

node_display_debug(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isstruct(self) || isnode(self) && isDefined(self.targetname) && !isDefined(var_7)) {
    level notify(self.targetname);
    level endon(self.targetname);
  }

  for(var_8 = 0; var_8 < var_5; var_8++) {
    print3d_debug(var_0 + (0, 0, 6), var_1, var_2, var_3, var_4, 1, var_6);
    sphere_debug(var_0, 6, var_2, 0, 1);
    waitframe();
  }
}

display_goto_path(var_0) {
  var_1 = var_0;

  if(getdvarint("scr_debug_stayahead")) {
    if(isDefined(self.using_goto_node) && isDefined(self.patharray)) {
      foreach(var_4, var_3 in self.patharray) {
        if(isDefined(self.patharrayindex) && var_4 < self.patharrayindex)
          var_0 = (1, 0, 0);
        else
          var_0 = var_1;

        var_3 thread node_display_debug(var_3.origin, "goto: " + var_4, var_0, 1, 0.2, 100, 1);

        if(isDefined(var_3.target)) {
          if(isDefined(scripts\engine\utility::getStruct(var_3.target, "targetname"))) {
            line_debug(var_3.origin, scripts\engine\utility::getStruct(var_3.target, "targetname").origin, var_0, 1, 0, 1);
            continue;
          }

          if(isDefined(getnode(var_3.target, "targetname")))
            line_debug(var_3.origin, getnode(var_3.target, "targetname").origin, var_0, 1, 0, 1);
        }
      }
    }
  }
}