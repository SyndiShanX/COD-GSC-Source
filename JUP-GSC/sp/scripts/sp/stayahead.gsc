/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\stayahead.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace stayahead;

function stayahead_thread(followent) {
  self endon("death");
  self endon("stop_stayahead");

  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  if(!ent_flag_exist("stayahead_pause")) {
    ent_flag_init("stayahead_pause");
  }

  thread stayahead_watch_end();
  childthread pause_flag_monitor();
  dir = anglesToForward(self.angles);
  dir_prev = anglesToForward(self.angles);
  lastpos = "";
  prevpos = "";
  goalpos = get_goalpos();
  prevgoalpos = [self.origin];
  lastframeinfo = undefined;
  scriptedanim = undefined;
  self.stayahead.lookat_last = gettime();
  self.stayahead.exit_speed = undefined;
  self.stayahead.exit_finish_time = undefined;
  self.stayahead.exit_last_finish_time = undefined;
  self.stayahead.wait_node_radius = 400;
  self.stayahead.dir = anglesToForward(self.angles);

  if(!isDefined(self.stayahead.p1)) {
    self.stayahead.p1 = [];
  }

  while(true) {
    if(isDefined(self.stayahead.team) && !isDefined(self.stayahead.team_thinking)) {
      thread stayahead_team_think();
    }

    lastgoalpos = goalpos;
    goalpos = get_goalpos();

    if(lastgoalpos[0] != goalpos[0]) {
      prevgoalpos = lastgoalpos;
    }

    if(isDefined(self.stayahead.turbo)) {
      p1speed = self.stayahead.turbo;
      p2speed = self.stayahead.turbo;
      p3speed = self.stayahead.turbo;
      p4speed = self.stayahead.turbo;
      p1var = 0;
      p2var = 0;
      p3var = 0;
      p4var = 0;
    } else {
      p1speed = self.stayahead.p1["speed"];
      p2speed = self.stayahead.p2["speed"];
      p3speed = self.stayahead.p3["speed"];
      p4speed = self.stayahead.p4["speed"];
      p1var = ter_op(isDefined(self.stayahead.p1["variance"]), self.stayahead.p1["variance"], 0.2);
      p2var = ter_op(isDefined(self.stayahead.p2["variance"]), self.stayahead.p2["variance"], 0.2);
      p3var = ter_op(isDefined(self.stayahead.p3["variance"]), self.stayahead.p3["variance"], 0.2);
      p4var = ter_op(isDefined(self.stayahead.p4["variance"]), self.stayahead.p4["variance"], 0.2);
    }

    p1dist = self.stayahead.p1["distance"];
    p2dist = self.stayahead.p2["distance"];
    p3dist = self.stayahead.p3["distance"];
    p4dist = self.stayahead.p4["distance"];
    pwdist = undefined;
    pwspeed = undefined;
    pwbuffer = undefined;

    if(isDefined(self.stayahead.pw)) {
      pwdist = self.stayahead.pw["distance"];
      pwspeed = self.stayahead.pw["speed"];
      pwbuffer = ter_op(isDefined(self.stayahead.pw["buffer"]), self.stayahead.pw["buffer"], 1.5);
      pwbuffer *= 20;
    }

    if(getdvarint(@ "hash_3d6aec1e7192648b")) {
      if(self.arriving) {
        print3d_debug(self.origin + (0, 0, 16), "<dev string:x1c>" + self.arriving, (0.9, 0.9, 0.9), 0.9, 0.3);
      }

      if(istrue(self._blackboard.var_9fbdce5fa10f8964)) {
        print2d3d_debug(self.origin + (0, 0, 12), "<dev string:x27>" + self._blackboard.var_9fbdce5fa10f8964, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "<dev string:x3b>", 5);
      }

      thread create_2d_background();

      if(ent_flag("<dev string:x41>")) {
        level thread create_2d_text("<dev string:x51>", (1, 0, 0), "<dev string:x64>", 0, 1);
      } else {
        level thread create_2d_text("<dev string:x69>", (0, 1, 1), "<dev string:x64>", 0, 1);
      }

      level thread create_2d_text("<dev string:x70>", (0, 1, 1), "<dev string:x3b>", 0, 1);
      level thread create_2d_text("<dev string:x73>" + get_player_demeanor(), (0, 1, 1), "<dev string:x64>", 1, 1);
      level thread create_2d_text("<dev string:x70>", (0, 1, 1), "<dev string:x64>", 4, 1);

      if(isDefined(self.demeanoroverride)) {
        level thread create_2d_text("<dev string:x73>" + self.demeanoroverride, (0, 1, 1), "<dev string:x64>", 5, 1);
      }

      if(isDefined(self.goalradius)) {
        level thread create_2d_text("<dev string:x7e>" + self.goalradius, (0, 1, 1), "<dev string:x64>", 6, 1);
      }

      if(isDefined(level.player.movementstate)) {
        level thread create_2d_text("<dev string:x8b>" + level.player.movementstate, (0, 1, 1), "<dev string:x64>", 2, 1);
      }

      if(isDefined(level.player.movespeedscale)) {
        level thread create_2d_text("<dev string:x9c>" + level.player.movespeedscale, (0, 1, 1), "<dev string:x64>", 3, 1);
      }
    }

    fwdpos = flat_origin(self getposonpath(32));
    goalpos2d = flat_origin(goalpos[0]);
    prevgoalpos2d = flat_origin(prevgoalpos[0]);
    origin2d = flat_origin(self.origin);

    if(self isinscriptedstate()) {
      if(isDefined(self.stayahead.exit_speed) && !isDefined(self.stayahead.exit_finish_time)) {
        self.stayahead.exit_finish_time = gettime();
        self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
      } else {
        self.stayahead.exit_speed = undefined;
        self.stayahead.exit_finish_time = undefined;
      }

      print2d3d_debug(self.origin + (0, 0, 30), "dir: SCRIPTED ANIM: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
    } else if(self.arriving || distancesquared(goalpos2d, origin2d) < 1024) {
      if(isDefined(self.stayahead.exit_speed) && !isDefined(self.stayahead.exit_finish_time)) {
        self.stayahead.exit_finish_time = gettime();
        self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
      } else {
        self.stayahead.exit_speed = undefined;
        self.stayahead.exit_finish_time = undefined;
      }

      if(isDefined(self.goalnode) && istrue(self.goalnode.script_useangles)) {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: arriving/close USEANGLES OVERRIDE vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        dir = lerp_plane_vector(dir, anglesToForward(self.goalnode.angles));
      } else if(isDefined(goalpos[1])) {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: arriving/close GOAL vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        goalpos2d = flat_origin(goalpos[1]);
        dir = lerp_plane_vector(dir, vectorNormalize(goalpos2d - origin2d));
      } else {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: arriving/close FWD vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        dir = lerp_plane_vector(dir, anglesToForward(self.angles));
      }
    } else if(istrue(self._blackboard.var_9fbdce5fa10f8964) || distancesquared(prevgoalpos2d, origin2d) < 1024) {
      if(istrue(self._blackboard.var_9fbdce5fa10f8964) && !isDefined(self.stayahead.exit_speed)) {
        self.stayahead.exit_speed = -1;
      }

      if(isDefined(self.using_goto_node)) {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: exiting GOTO vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        goalpos2d = flat_origin(goalpos[0]);
        dir = lerp_plane_vector(dir, vectorNormalize(goalpos2d - prevgoalpos2d));
      } else if(isDefined(goalpos[1])) {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: exiting GOAL vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        goalpos2d = flat_origin(goalpos[1]);
        dir = lerp_plane_vector(dir, vectorNormalize(goalpos2d - prevgoalpos2d));
      } else {
        print2d3d_debug(self.origin + (0, 0, 30), "dir: exiting FWD vector: " + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 4);
        dir = lerp_plane_vector(dir, anglesToForward(self.angles));
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

      if(distance(fwdpos, origin2d) < 1) {
        print_debug("STAYAHEAD: segments are colliding! " + gettime());
        dir = lerp_plane_vector(dir, vectorNormalize(goalpos2d - fwdpos));
      } else {
        dir = lerp_plane_vector(dir, vectorNormalize(fwdpos - origin2d));
      }
    }

    p2pos = self.origin + dir * p2dist;
    p3pos = self.origin + dir * p3dist;
    p4pos = self.origin + dir * p4dist;
    var_3400cdbff0926f4e = distance(p2pos, p3pos) * 0.25;
    var_b8b793c95b3a1c2d = distance(p2pos, p3pos) * 0.6;
    var_9150f3b2e4bd88fd = distance(p2pos, p3pos) * 0.25;
    var_80104df680745372 = distance(p3pos, p4pos) * 0.6;
    var_43d709d52baf035c = distance(p3pos, p4pos) * 0.25;
    var_bfcf85b13bbb58c7 = distance(p3pos, p4pos) * 0.6;
    dotp2 = vectordot(vectorNormalize(followent.origin - p2pos), dir);
    dotp3 = vectordot(vectorNormalize(followent.origin - p3pos), dir);
    dotp4 = vectordot(vectorNormalize(followent.origin - p4pos), dir);
    p1pos = undefined;
    dotp1 = undefined;
    var_e70b4c0f0605aa9f = undefined;
    var_f3c6d14c9c4b01a8 = undefined;

    if(isDefined(p1dist)) {
      p1pos = self.origin + dir * p1dist;
      dotp1 = vectordot(vectorNormalize(followent.origin - p1pos), dir);
      var_e70b4c0f0605aa9f = distance(p1pos, p2pos) * 0.25;
      var_f3c6d14c9c4b01a8 = distance(p1pos, p2pos) * 0.6;
      var_3400cdbff0926f4e = distance(p1pos, p2pos) * 0.25;
    }

    pwpos = undefined;
    dotpw = undefined;

    if(isDefined(pwdist)) {
      pwpos = self.origin + dir * pwdist;
      dotpw = vectordot(vectorNormalize(followent.origin - pwpos), dir);
    }

    if(getdvarint(@ "hash_3d6aec1e7192648b")) {
      debugangles = vectortoangles(dir);
      debugright = anglestoright(debugangles);
      debugleft = debugright * -1;
      var_63b92580f9bc2247 = p2pos + dir * var_3400cdbff0926f4e;
      var_5044c2aaa091e8b5 = p2pos + dir * var_b8b793c95b3a1c2d * -1;
      var_2cafad0145a554a = p3pos + dir * var_9150f3b2e4bd88fd;
      var_25f3e65eb8d76486 = p3pos + dir * var_80104df680745372 * -1;
      var_190991af9a87fe39 = p4pos + dir * var_43d709d52baf035c;
      var_ef9b0d1945b01397 = p4pos + dir * var_bfcf85b13bbb58c7 * -1;
      line_debug(self.origin, goalpos[0], (0.9, 0.9, 0.9));
      print3d_debug(goalpos[0], "<dev string:xad>", (0.9, 0.9, 0.9), 0.9, 0.3, 1, 1);
      offsetorigin = self.origin + (0, 0, 5);
      line_debug(offsetorigin, offsetorigin + dir * 80, (0, 0, 0.9));

      if(isDefined(goalpos[1])) {
        line_debug(goalpos[0], goalpos[1], (0.9, 0, 0));
        print3d_debug(goalpos[1], "<dev string:xb4>", (1, 0, 1), 0.9, 0.3, 1, 1);
      }

      line_debug(p2pos + debugright * 300, p2pos + debugleft * 300, (1, 0, 0));
      line_debug(p3pos + debugright * 300, p3pos + debugleft * 300, (0, 1, 0));
      line_debug(p4pos + debugright * 300, p4pos + debugleft * 300, (0, 0, 1));
      line_debug(var_63b92580f9bc2247 + debugright * 300, var_63b92580f9bc2247 + debugleft * 300, (1, 0.8, 0.8));
      line_debug(var_5044c2aaa091e8b5 + debugright * 300, var_5044c2aaa091e8b5 + debugleft * 300, (1, 0.8, 0.8));
      line_debug(var_2cafad0145a554a + debugright * 300, var_2cafad0145a554a + debugleft * 300, (0.8, 1, 0.8));
      line_debug(var_25f3e65eb8d76486 + debugright * 300, var_25f3e65eb8d76486 + debugleft * 300, (0.8, 1, 0.8));
      line_debug(var_190991af9a87fe39 + debugright * 300, var_190991af9a87fe39 + debugleft * 300, (0.8, 0.8, 1));
      line_debug(var_ef9b0d1945b01397 + debugright * 300, var_ef9b0d1945b01397 + debugleft * 300, (0.8, 0.8, 1));
      print3d_debug(p2pos, p2speed, (1, 0.25, 0.25), 0.9, 0.3);
      print3d_debug(p3pos, p3speed, (0.5, 1, 0.5), 0.9, 0.3);
      print3d_debug(p4pos, p4speed, (0.25, 0.25, 1), 0.9, 0.3);
      print3d_debug(p2pos + (0, 0, -4), p2var, (1, 0.25, 0.25), 0.9, 0.3);
      print3d_debug(p3pos + (0, 0, -4), p3var, (0.5, 1, 0.5), 0.9, 0.3);
      print3d_debug(p4pos + (0, 0, -4), p4var, (0.25, 0.25, 1), 0.9, 0.3);

      if(isDefined(p1pos)) {
        line_debug(p1pos + debugright * 300, p1pos + debugleft * 300, (1, 0, 1));
        print3d_debug(p1pos, p1speed, (1, 0.25, 1), 0.9, 0.3);
        print3d_debug(p1pos + (0, 0, -4), p1var, (1, 0.25, 1), 0.9, 0.3);
        var_bc947c65be4c4d26 = p1pos + dir * var_e70b4c0f0605aa9f;
        var_84a84755c3f9f2a = p1pos + dir * var_f3c6d14c9c4b01a8 * -1;
        line_debug(var_bc947c65be4c4d26 + debugright * 300, var_bc947c65be4c4d26 + debugleft * 300, (1, 0.8, 1));
        line_debug(var_84a84755c3f9f2a + debugright * 300, var_84a84755c3f9f2a + debugleft * 300, (1, 0.8, 1));
      }

      if(isDefined(pwpos)) {
        line_debug(pwpos + debugright * 300, pwpos + debugleft * 300, (0, 1, 1));
        print3d_debug(pwpos, "<dev string:xcc>", (0.25, 1, 1), 0.9, 0.3);
      }

      print2d3d_debug(self.origin + (0, 0, 20), "<dev string:xd1>" + distancesquared(goalpos[0], self.origin), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "<dev string:x3b>", 3);
      thread display_goto_path((0, 1, 1));
    }

    if(ent_flag("stayahead_pause")) {
      waitframe();
      continue;
    }

    if(isDefined(dotpw)) {
      if(!isDefined(self.stayahead.pw_behind_buffer)) {
        self.stayahead.pw_behind_buffer = 0;
      }

      if(!isDefined(self.stayahead.pw_infront_buffer)) {
        self.stayahead.pw_infront_buffer = 0;
      }

      if(dotpw < 0) {
        self.stayahead.pw_infront_buffer = 0;

        if(!isDefined(self.stayahead.goalnode)) {
          if(isDefined(self.using_goto_node)) {
            print3d_debug(self.origin + (0, 0, 10), "pw using goto goalnode", (1, 0, 1), 1, 0.5, 500, 1);

            if(isDefined(self.patharray)) {
              self.stayahead.goalnode = self.patharray[self.patharray.size - 1];
            } else {
              print3d_debug(self.origin + (0, 0, 14), "BAAAAD!!!USING GOTO NODE BUT PATHARRAY IS NO LONGER DEFINED.MAYBE A RACE CONDITION!", (1, 0, 0), 1, 0.5, 500, 1);
            }
          } else if(isDefined(self.goalnode)) {
            self.stayahead.goalnode = self.goalnode;
          } else {
            print3d_debug(self.origin, "pw no goalnode, goalpos?", (1, 0, 0), 1, 0.5, 200, 1);
          }
        }

        if(isDefined(self.stayahead.goalnode) && !isDefined(self.stayahead.goalnode_pw) && self.stayahead.pw_behind_buffer > pwbuffer) {
          var_6ec7ad100ba120aa = get_wait_node();

          if(isDefined(var_6ec7ad100ba120aa) && distance(self.origin, var_6ec7ad100ba120aa.origin) <= self.stayahead.wait_node_radius && distance(self.origin, var_6ec7ad100ba120aa.origin) > 32 && stayahead_goal_is_far_enough(var_6ec7ad100ba120aa)) {
            self.stayahead.goalnode_pw = var_6ec7ad100ba120aa;
            line_debug(self.origin, self.origin + dir * -100, (1, 1, 1), 1, 0, 500);
            line_debug(self.origin, var_6ec7ad100ba120aa.origin, (1, 0, 0), 1, 0, 500);
            print3d_debug(self.origin, "going to pW node: " + distance(self.origin, var_6ec7ad100ba120aa.origin) + " GoalRadius: " + self.goalradius, (1, 1, 0), 1, 0.3, 500, 1);
            childthread stayahead_wait_set_goal_or_path();
            childthread stayahead_set_goalnode(var_6ec7ad100ba120aa, 1);
          } else if(!isDefined(var_6ec7ad100ba120aa)) {
            print2d3d_debug(self.origin + (0, 0, 16), "pW fail no wait nodes", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
          } else if(distance(self.origin, var_6ec7ad100ba120aa.origin) >= self.stayahead.wait_node_radius) {
            line_debug(self.origin, var_6ec7ad100ba120aa.origin, (1, 0, 0), 1, 0, 1);
            print2d3d_debug(self.origin + (0, 0, 16), "pW fail wait node too far: " + distance(self.origin, var_6ec7ad100ba120aa.origin), (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
          } else if(distance(self.origin, var_6ec7ad100ba120aa.origin) < 32) {
            line_debug(self.origin, var_6ec7ad100ba120aa.origin, (1, 0, 0), 1, 0, 1);
            print2d3d_debug(self.origin + (0, 0, 16), "pW fail wait node too close: " + distance(self.origin, var_6ec7ad100ba120aa.origin), (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
          }
        } else if(!isDefined(self.stayahead.goalnode)) {
          print2d3d_debug(self.origin + (0, 0, 16), "pW fail no goalnode or goto", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
        } else if(isDefined(self.stayahead.goalnode_pw)) {
          print2d3d_debug(self.origin + (0, 0, 16), "pW fail already have wait node", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
        } else if(self.stayahead.pw_behind_buffer < pwbuffer) {
          print2d3d_debug(self.origin + (0, 0, 16), "pW fail buffer too small", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
        } else {
          print2d3d_debug(self.origin + (0, 0, 16), "pW fail uh oh!", (1, 0, 0), 1, 0.3, 1, 0, "right", 6);
        }

        self.stayahead.pw_behind_buffer += 1;

        if(self.stayahead.pw_behind_buffer > pwbuffer) {
          print2d3d_debug(self.origin + (0, 0, 12), "pW behind buffer: " + self.stayahead.pw_behind_buffer, (1, 0, 0), 1, 0.3, 1, 0, "right", 7);
        } else {
          print2d3d_debug(self.origin + (0, 0, 12), "pW behind buffer: " + self.stayahead.pw_behind_buffer, (0, 0, 1), 1, 0.3, 1, 0, "right", 7);
        }
      } else if(isDefined(self.stayahead.goalnode) && isDefined(self.stayahead.goalnode_pw)) {
        self.stayahead.pw_behind_buffer = 0;

        if(dotp4 > 0 && self.stayahead.pw_infront_buffer > pwbuffer * 0.4 || dotp3 > 0) {
          print3d_debug(self.origin, "going to OG goal: " + distance(self.origin, self.stayahead.goalnode.origin), (0, 1, 0), 1, 0.3, 500, 1);
          self.stayahead.goalnode_pw = undefined;
          childthread stayahead_set_goalnode(self.stayahead.goalnode, 0);
          self.stayahead.goalnode = undefined;
        }

        self.stayahead.pw_infront_buffer += 1;
        print2d3d_debug(self.origin + (0, 0, 12), "pW infront buffer: " + self.stayahead.pw_infront_buffer, (0, 1, 0), 1, 0.3, 1, 0, "right", 7);
      } else {
        self notify("stop_stayahead_wait_func");
        self.stayahead.pw_behind_buffer = 0;
        print2d3d_debug(self.origin + (0, 0, 12), "pW failing???", (1, 0, 0), 1, 0.3, 1, 0, "right", 5);
      }
    }

    if(isDefined(dotp1) && dotp1 > 0) {
      if(lastpos != "p1Front") {
        prevpos = lastpos;
        lastpos = "p1Front";
      }

      stayahead_set_speed(1, followent, p1dist + var_e70b4c0f0605aa9f, p1dist, dir, p1speed, p1speed + p1speed * p1var, 1);
    } else if(dotp2 > 0) {
      if(lastpos != "p2Front") {
        prevpos = lastpos;
        lastpos = "p2Front";
      }

      if(prevpos == "p3Front" || prevpos == "") {
        stayahead_set_speed(2, followent, p2dist + var_3400cdbff0926f4e, p2dist, dir, p2speed, p2speed + p2speed * p2var);
      } else if(isDefined(dotp1)) {
        stayahead_set_speed(1, followent, p1dist, p1dist - var_f3c6d14c9c4b01a8, dir, p1speed + p1speed * p1var * -1, p1speed, 1);
      } else {
        stayahead_set_speed(2, followent, p2dist + var_3400cdbff0926f4e, p2dist, dir, p2speed, p2speed + p2speed * p2var);
      }
    } else if(dotp3 > 0) {
      if(lastpos != "p3Front") {
        prevpos = lastpos;
        lastpos = "p3Front";
        stayahead_lookat(followent);
      }

      if(prevpos == "p4Front" || prevpos == "") {
        stayahead_set_speed(3, followent, p3dist + var_9150f3b2e4bd88fd, p3dist, dir, p3speed, p3speed + p3speed * p3var);
      } else {
        stayahead_set_speed(2, followent, p2dist, p2dist - var_b8b793c95b3a1c2d, dir, p2speed + p2speed * p2var * -1, p2speed);
      }
    } else if(dotp4 > 0) {
      if(lastpos != "p4Front") {
        prevpos = lastpos;
        lastpos = "p4Front";
        stayahead_lookat(followent);
      }

      if(prevpos == "p4Back" || prevpos == "") {
        stayahead_set_speed(4, followent, p4dist + var_43d709d52baf035c, p4dist, dir, p4speed, p4speed + p4speed * p4var);
      } else {
        stayahead_set_speed(3, followent, p3dist, p3dist - var_80104df680745372, dir, p3speed + p3speed * p3var * -1, p3speed);
      }
    } else if(dotp4 < 0) {
      if(isDefined(dotpw) && dotpw < 0) {}

      if(lastpos != "p4Back") {
        prevpos = lastpos;
        lastpos = "p4Back";
        stayahead_lookat(followent);
      }

      stayahead_set_speed("W", followent, p4dist, p4dist - var_bfcf85b13bbb58c7, dir, p4speed + p4speed * p4var * -1, p4speed);
    } else {
      print2d3d_debug(self.origin + (0, 0, 30), "uh oh!", (0.9, 0, 0), 0.9, 0.3, 250, 0, "right", 4);
    }

    waitframe();
  }
}

function stayahead_lookat(followent) {
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
  lookattime = 0.5;
  self.stayahead.lookat_last = gettime();
  childthread stayahead_lookat_debug(lookattime);
  utility::lookatentity(followent);
  delaythread(lookattime, &utility::lookatentity);
  wait lookattime * 0.6;
}

function stayahead_lookat_far(followent) {
  self endon("death");
  lookatdelay = randomfloatrange(6000, 11000);

  if(gettime() > self.stayahead.lookat_last + lookatdelay) {
    stayahead_lookat(followent);
  }
}

function stayahead_lookat_debug(lookattime) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    starttime = gettime();

    while(gettime() - starttime + lookattime * 1000) {
      print3d_debug(self.origin + (0, 0, 60), "<dev string:xe2>", (0.9, 0, 0), 0.9, 0.3);
      waitframe();
    }
  }

}

function stayahead_set_speed(plane, followent, forwarddist, backdist, dir, minspeed, maxspeed, catchup) {
  print2d3d_debug(self.origin, "Plane: " + plane, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 1);
  forwardpos = self.origin + dir * forwarddist;
  backpos = self.origin + dir * backdist;

  if(distance(forwardpos, backpos) < 1) {
    print_debug("segments are colliding, not setting speed! " + gettime());
    return;
  }

  playerpos = pointonsegmentnearesttopoint(forwardpos, backpos, followent.origin);
  dist = distance(forwardpos, playerpos);
  totaldist = forwarddist - backdist;
  scale = 1 - math::lerp_fraction(0, abs(totaldist), dist);
  maxspeedclamp = 250;

  if(isDefined(self.stayahead.turbo) || istrue(catchup)) {
    maxspeedclamp = 300;
  }

  if(!isDefined(self.stayahead.exit_last_finish_time) || gettime() > self.stayahead.exit_last_finish_time + 1000) {
    speed = math::lerp(minspeed, maxspeed, scale);
    speed = clamp(speed, 23, maxspeedclamp);
    curspeed = self aigetdesiredspeed();
    diff = speed - curspeed;

    if(istrue(catchup) || diff > 50) {
      if(!istrue(catchup) && !isDefined(self.stayahead.last_speed_set_time)) {
        speed = curspeed + clamp(diff, -2, 2);
        self.stayahead.last_speed_set_time = undefined;
        print3d_debug(self.origin + (0, 0, 32), "StayAhead STARTUP! plane: " + plane + " diff: " + diff + " curSpeed: " + curspeed + " speed: " + speed, (1, 1, 1), 1, 0.1, 100, 1);
        print_console_debug("StayAhead STARTUP! plane: " + plane + " diff: " + diff + " curSpeed: " + curspeed + " speed: " + speed);
      } else {
        speed = curspeed + clamp(diff, -10, 10);
        self.stayahead.last_speed_set_time = gettime();
        print3d_debug(self.origin + (0, 0, 32), "StayAhead CATCHUP! plane: " + plane + " diff: " + diff + " curSpeed: " + curspeed + " speed: " + speed, (1, 1, 1), 1, 0.1, 100, 1);
        print_console_debug("StayAhead CATCHUP! plane: " + plane + " diff: " + diff + " curSpeed: " + curspeed + " speed: " + speed);
      }
    } else if(isDefined(self.stayahead_accel)) {
      speed = curspeed + clamp(diff, -1 * self.stayahead_accel, self.stayahead_accel);
      self.stayahead.last_speed_set_time = gettime();
    } else {
      speed = curspeed + clamp(diff, -3.5, 3.5);
      self.stayahead.last_speed_set_time = gettime();
    }

    set_movement_speed(speed);

    if(isDefined(self.stayahead.exit_speed) && self.stayahead.exit_speed == -1) {
      self.stayahead.exit_speed = speed;
    }

    line_debug(followent.origin, playerpos);
    print2d3d_debug(self.origin + (0, 0, 8), "speed: " + speed, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 2);
    print3d_debug(playerpos + (0, 0, 8), speed, (0.9, 0.9, 0.9), 0.9, 0.3);
    return;
  }

  print3d_debug(self.origin + (0, 0, 8), "IsExiting, not setting speed: " + gettime(), (0.9, 0, 0), 0.9, 0.3, 1);
}

function get_best_goto_node(path, nodestocheck) {
  dots = [];
  largestindex = 0;
  goodenough = undefined;

  for(i = 0; i < nodestocheck; i++) {
    if(!isDefined(path[i])) {
      break;
    }

    dots[i] = vectordot(vectorNormalize(path[i].origin - self.origin), self.stayahead.dir);

    if(dots[i] < 0) {
      nodestocheck += 1;
      continue;
    }

    if(dots[i] > 0.5) {
      print3d_debug(path[i].origin, "GOTO GOOD ENOUGH re-start: " + dots[i], (0, 1, 0), 1, 0.3, 200, 1);
      goodenough = 1;
      largestindex = i;
      break;
    }

    if(dots[i] > dots[largestindex]) {
      largestindex = i;
    }
  }

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    foreach(i, dot in dots) {
      if(i == largestindex && !isDefined(goodenough)) {
        path[i] thread print3d_debug(path[i].origin, "<dev string:xea>" + dot, (0, 1, 0), 1, 0.3, 200, 1);
        continue;
      }

      if(i != largestindex) {
        path[i] thread node_display_debug(path[i].origin, "<dev string:xfa>" + dot, (1, 0, 0), 1, 0.3, 200, 1);
      }
    }
  }

  return path[largestindex];
}

function get_goto_nodes(nodes) {
  if(isDefined(self.patharray)) {
    nodes = array_combine(nodes, self.patharray);
  }

  return nodes;
}

function get_goalpos() {
  goalpos = [];

  if(isDefined(self.goalnode)) {
    goalpos[0] = self.goalnode.origin;

    if(isDefined(self.goalnode.target)) {
      linkednode = self.goalnode get_node_or_struct();

      if(isDefined(linkednode)) {
        goalpos[1] = linkednode.origin;
      }
    } else if(isDefined(self.stayahead.goalnode) && isDefined(self.stayahead.goalnode_pw) && self.goalnode == self.stayahead.goalnode_pw) {
      goalpos[1] = self.stayahead.goalnode.origin;
    }
  } else {
    goalpos[0] = self.scriptgoalpos;
  }

  return goalpos;
}

function get_node_or_struct() {
  linkednode = getnode(self.target, "targetname");

  if(isDefined(linkednode)) {
    return linkednode;
  } else {
    linkednode = getStruct(self.target, "targetname");
  }

  return linkednode;
}

function get_wait_node(dir) {
  nodes = [];

  if(isDefined(self.stayahead.wait_nodes)) {
    nodes = self.stayahead.wait_nodes;
    nodes = sortbydistance(nodes, self.origin);
  } else if(!isDefined(self.stayahead.use_goto_wait)) {
    nodes = getnodesinradiussorted(self.origin, self.stayahead.wait_node_radius, 0, 64, "cover");
  }

  if(isDefined(self.using_goto_node) && istrue(self.stayahead.use_goto_wait)) {
    nodes = array_combine(nodes, get_goto_nodes(nodes));
    nodes = sortbydistance(nodes, self.origin);
  }

  allowed_dot = 0.75;

  foreach(i, node in nodes) {
    nodedot = vectordot(vectorNormalize(node.origin - self.origin), self.stayahead.dir);
    goalnodesafe = ter_op(isDefined(self.goalnode) && node == self.goalnode, 0, 1);
    goalpossafe = ter_op(isDefined(self.goalpos) && node.origin == self.goalpos, 0, 1);

    if(!isDefined(node.stayahead_wait_used) && !isDefined(node.script_dontremove) && nodedot >= allowed_dot && goalnodesafe && goalpossafe) {
      if(isDefined(self.script_forcecolor) && isDefined(node.script_color_allies) && issubstr(node.script_color_allies, self.script_forcecolor)) {
        line_debug(self.origin, node.origin, (0, 1, 0), 1, 0, 1);
        node thread node_display_debug(node.origin, node.script_color_allies, (0, 1, 0), 1, 0.2, 1000, 1);
      } else if(isDefined(self.script_forcecolor) && !isDefined(self.stayahead.use_goto_wait)) {
        if(!isDefined(node.script_color_allies)) {
          if(isDefined(self.stayahead.wait_nodes) && !isDefined(array_find(self.stayahead.wait_nodes, node))) {
            node thread node_display_debug(node.origin, "invalid: no color, removing", (1, 0, 1), 1, 0.2, 1000, 1);
            nodes = array_remove(nodes, node);
          }
        } else if(!issubstr(node.script_color_allies, self.script_forcecolor)) {
          node thread node_display_debug(node.origin, "invalid: wrong color, removing", (1, 0, 1), 1, 0.2, 1000, 1);
          nodes = array_remove(nodes, node);
        }
      }

      continue;
    }

    if(!isDefined(node.script_dontremove)) {
      if(isDefined(node.stayahead_wait_used)) {
        node thread node_display_debug(node.origin, "invalid: used", (1, 0, 1), 1, 0.2, 1000, 1);
      } else if(nodedot < 0) {
        node thread node_display_debug(node.origin, "removed: behind", (0, 0, 1), 1, 0.2, 1000, 1);
      } else if(nodedot < allowed_dot) {
        node thread node_display_debug(node.origin, "removed: bad angle: " + nodedot, (1, 0, 0), 1, 0.2, 1000, 1);
      } else if(!goalnodesafe) {
        node thread node_display_debug(node.origin, "removed: IS goalNode", (1, 0, 0), 1, 0.2, 1000, 1);
      } else if(!goalpossafe) {
        node thread node_display_debug(node.origin, "removed: IS goalPos", (1, 0, 0), 1, 0.2, 1000, 1);
      } else {
        node thread node_display_debug(node.origin, "invalid???", (1, 0, 1), 1, 0.2, 1000, 1);
      }

      nodes = array_remove(nodes, node);
    }
  }

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    foreach(node in nodes) {
      node thread node_display_debug(node.origin, "wait node: " + i, (0, 1, 0), 1, 0.2, 1000, 1);
    }
  }

  var_6ec7ad100ba120aa = undefined;

  if(nodes.size > 0) {
    var_7fc5f3a6e1f2f335 = undefined;

    foreach(node in nodes) {
      if(isnode(node)) {
        var_7fc5f3a6e1f2f335 = node;
        break;
      }
    }

    var_6ec7ad100ba120aa = nodes[0];

    if(isstruct(nodes[0]) && isDefined(var_7fc5f3a6e1f2f335)) {
      if(distance(nodes[0].origin, var_7fc5f3a6e1f2f335.origin) < 128) {
        if(node_within_fov(var_7fc5f3a6e1f2f335)) {
          print3d_debug(var_7fc5f3a6e1f2f335.origin, "NEAREST NODE", (1, 1, 1), 1, 0.3, 1, 1);
          print3d_debug(self.origin, "STAYAHEAD: using closest 'node' bc it's not a struct!", (1, 1, 1), 1, 0.3, 100, 1);
          var_6ec7ad100ba120aa = var_7fc5f3a6e1f2f335;
        }
      }
    }
  } else {
    print3d_debug(self.origin, "STAYAHEAD: NO BEST WAIT NODE, RETURNING UNDEFINED!", (1, 0, 0), 1, 0.3, 100, 1);
  }

  return var_6ec7ad100ba120aa;
}

function pause_flag_monitor() {
  while(true) {
    ent_flag_wait("stayahead_pause");
    print3d_debug(self.origin + (0, 0, 16), "PAUSING stayahead", (0, 1, 1), 1, 0.3, 1000, 1);
    ent_flag_waitopen("stayahead_pause");
    print3d_debug(self.origin + (0, 0, 16), "UNpausing stayahead", (0, 1, 1), 1, 0.3, 1000, 1);
    self.stayahead.pw_behind_buffer = 0;
  }
}

function waitnode_trigger_think(node, trigger) {
  thread delay_endon(0.05, "goal_changed");
  self waittill("goal");
  thread scripts\sp\utility::stayahead_pause(1);
  childthread waitnode_trigger_debug(node, trigger);
  childthread waitnode_trigger_delay_speed_clear();
  msg = trigger waittill_any_return("trigger", "death");
  thread scripts\sp\utility::stayahead_pause(0);
  childthread stayahead_set_goalnode(self.stayahead.goalnode, 0);
}

function waitnode_trigger_delay_speed_clear() {
  waittillframeend();
  self.stayahead.last_speed_set_time = undefined;
}

function waitnode_trigger_debug(node, trigger) {
  trigger endon("death");
  trigger endon("trigger");

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    for(;;) {
      print3d_debug(trigger.origin, "<dev string:x109>", (0, 1, 0), 1, 0.3, 1, 1);
      line_debug(node.origin, trigger.origin, (0, 1, 0), 1, 0, 1);
      draw_entity_bounds(trigger, 0.05, (0, 1, 0));
      waitframe();
    }
  }

}

function stayahead_watch_end() {
  self endon("death");

  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  self.stayahead.active = 1;
  self waittill("stop_stayahead");

  if(isDefined(self.stayahead)) {
    if(isDefined(self.stayahead.active)) {
      self.stayahead.active = undefined;
    }

    if(isDefined(self.stayahead.team_thinking)) {
      self.stayahead.team_thinking = undefined;
    }
  }
}

function stayahead_wait_func(node) {
  self endon("death");
  self endon("stop_stayahead");
  self notify("stop_stayahead_wait_func");
  self endon("stop_stayahead_wait_func");
  thread delay_endon(0.05, "goal_changed");
  stayahead_at_waitnode(node);
  self[[self.stayahead.wait_func]]();
}

function stayahead_wait_set_goal_or_path() {
  if(isDefined(self.using_goto_node)) {
    self.stayahead.goto_patharray = self.patharray;
    self.stayahead.using_goto_node = 1;

    for(i = 0; i <= self.patharrayindex; i++) {
      if(self.stayahead.goto_patharray.size > 1) {
        print_console_debug("Removing go_to_node num: " + i);
        self.stayahead.goto_patharray = array_remove_index(self.stayahead.goto_patharray, 0);
      }
    }

    return;
  }

  if(isDefined(self.goalnode)) {
    self.stayahead.goalnode = self.goalnode;
  }
}

function stayahead_at_waitnode(node) {
  thread delay_endon(0.05, "goal_changed");

  while(distance2dsquared(self.origin, node.origin) > 64) {
    print3d_debug(self.origin, "distanceSQ to waitnode: " + distance2dsquared(self.origin, node.origin), (1, 1, 1), 1, 0.3, 1, 1);
    waitframe();
  }
}

function stayahead_goal_is_far_enough(var_6ec7ad100ba120aa) {
  if(node_within_fov(self.stayahead.goalnode)) {
    if(distance(self.origin, self.stayahead.goalnode.origin) - distance(self.origin, var_6ec7ad100ba120aa.origin) < 128) {
      print2d3d_debug(self.origin + (0, 0, 16), "pW fail goalnode too close: " + distance(self.origin, self.stayahead.goalnode.origin) + " Waitnode: " + distance(self.origin, var_6ec7ad100ba120aa.origin), (1, 0, 0), 1, 0.3, 1, 0, "right", 5);
      return false;
    }
  } else {
    print2d3d_debug(self.origin + (0, 0, 16), "pW fail goalnode not within FOV.", (0, 1, 0), 1, 0.3, 1, 0, "right", 5);
  }

  return true;
}

function node_within_fov(node) {
  if(isDefined(self.stayahead) && isDefined(self.stayahead.dir)) {
    forward = self.stayahead.dir;
  } else {
    forward = anglesToForward(self.angles);
  }

  dot = vectordot(forward, vectorNormalize(node.origin - self.origin));

  if(dot >= 0.9) {
    return true;
  }

  return false;
}

function delay_endon(delay, ender) {
  wait delay;
  self endon(ender);
}

function stayahead_goto_can_use_wait(wait_nodes) {
  if(isDefined(self.using_goto_node)) {
    if(isDefined(self.stayahead.goto_nextnode) && distance(self.origin, self.stayahead.goto_nextnode.origin) > distance(self.origin, wait_nodes[0].origin)) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 1;
}

function stayahead_set_goalnode(node, waitnode) {
  if(isDefined(self.stayahead.spawned_wait_node)) {
    despawncovernode(self.stayahead.spawned_wait_node);
  }

  if(!isDefined(node)) {
    return;
  }

  if(istrue(waitnode)) {
    if(isstruct(node)) {
      structpos = node.origin;
      angles = vectortoangles(self.stayahead.dir);
      node = spawncovernode(structpos, angles, "Exposed", 1);

      if(!isDefined(node)) {
        print3d_debug(structpos, "UNABLE TO SPAWN COVER NODE!TRYING TO CREATE ONE CLOSER TO THE GROUND!", (1, 1, 0), 1, 0.3, 500, 1);
        node = spawncovernode(getgroundposition(structpos, 32), angles, "Exposed", 1);

        if(isDefined(node)) {
          print3d_debug(node.origin + (0, 0, 4), "SUCCESS SPAWNING NODE CLOSER TO THE GROUND!", (1, 1, 0), 1, 0.3, 500, 1);
        }
      }

      if(!isDefined(node)) {
        print3d_debug(structpos, "UNABLE TO SPAWN COVER NODE!", (1, 0, 0), 1, 0.3, 500, 1);
        return;
      }

      self.stayahead.spawned_wait_node = node;
    }

    node.stayahead_wait_used = 1;
    self notify("stayahead_going_to_wait_node");
    self notify("stop_going_to_node");
    set_goal_node(node);

    if(isDefined(self.stayahead.goto_patharray) && node == self.stayahead.goto_patharray[self.stayahead.goto_patharray.size - 1]) {
      self.stayahead.goto_finished = 1;
    }

    if(isDefined(self.stayahead.wait_func)) {
      childthread stayahead_wait_func(node);
    }

    linked_ents = node get_linked_ents();

    if(linked_ents.size > 0) {
      foreach(ent in linked_ents) {
        if(issubstr(ent.code_classname, "trigger")) {
          childthread waitnode_trigger_think(node, ent);
        }
      }
    }

    return;
  }

  if(isDefined(self.stayahead.using_goto_node)) {
    self notify("stop_stayahead_wait_func");
    self notify("stayahead_leaving_wait_node");

    if(istrue(self.stayahead.goto_finished)) {
      print3d_debug(self.origin + (0, 0, 8), "last node wait node; go_to_node() path done!", (0, 1, 0), 1, 0.3, 500, 1);
      self.stayahead.goto_finished = undefined;
      self notify("reached_path_end");
    } else {
      print3d_debug(self.origin + (0, 0, 8), "going BACK to goto patharray", (0, 1, 0), 1, 0.3, 500, 1);
      node = get_best_goto_node(self.stayahead.goto_patharray, 2);
      thread scripts\sp\spawner::go_to_node(node);
      self.stayahead.using_goto_node = 1;
    }

    return;
  }

  self notify("stop_stayahead_wait_func");
  self notify("stayahead_leaving_wait_node");
  self notify("stop_going_to_node");
  set_goal_node(node);
}

function stayahead_team_think() {
  self.stayahead.team_thinking = 1;
  self endon("death");
  self endon("stop_stayahead");
  speedscale = 0.8;
  p1speed = self.stayahead.p1["speed"];
  p2speed = self.stayahead.p2["speed"];
  p3speed = self.stayahead.p3["speed"];
  p4speed = self.stayahead.p4["speed"];
  p1dist = self.stayahead.p1["distance"];
  p2dist = self.stayahead.p2["distance"];
  p3dist = self.stayahead.p3["distance"];
  p4dist = self.stayahead.p4["distance"];
  childthread stayahead_team_debug();

  while(true) {
    foreach(guy in self.stayahead.team) {
      if(!isDefined(guy.stayahead.dynamic_frontdist)) {
        guy.stayahead.dynamic_frontdist = 200;
      }

      if(!isDefined(guy.stayahead.dynamic_middist)) {
        guy.stayahead.dynamic_middist = 125;
      }

      if(!isDefined(guy.stayahead.dynamic_backdist)) {
        guy.stayahead.dynamic_backdist = 50;
      }

      guy childthread enable_dynamic_run_speed(self, p4speed * speedscale, p3speed * speedscale, p2speed * speedscale, guy.stayahead.dynamic_frontdist, guy.stayahead.dynamic_middist, guy.stayahead.dynamic_backdist);

      if(!isDefined(guy.stayahead.dir)) {
        guy.stayahead.dir = anglesToForward(self.angles);
      }

      if(!isDefined(guy.stayahead.wait_node_radius)) {
        guy.stayahead.wait_node_radius = self.stayahead.wait_node_radius;
      }
    }

    self waittill("stayahead_going_to_wait_node");

    foreach(guy in self.stayahead.team) {
      guy childthread stayahead_wait_set_goal_or_path();
      guy disable_dynamic_run_speed(p4speed);
      var_6ec7ad100ba120aa = guy get_wait_node(vectortoangles(guy.angles));

      if(isDefined(var_6ec7ad100ba120aa)) {
        guy childthread stayahead_set_goalnode(var_6ec7ad100ba120aa, 1);
      }
    }

    self waittill("stayahead_leaving_wait_node");

    foreach(guy in self.stayahead.team) {
      guy.stayahead.dir = anglesToForward(guy.angles);
      guy.stayahead.using_goto_node = 1;
      guy childthread stayahead_set_goalnode(guy.stayahead.goto_patharray[0], 0);
    }
  }
}

function stayahead_team_debug() {
  self endon("stop_stayahead");

  for(;;) {
    foreach(guy in self.stayahead.team) {
      guy thread display_goto_path((1, 0, 1));
      line_debug(self.origin, guy.origin, (1, 0, 1), 1, 0, 1);
    }

    waitframe();
  }
}

function lerp_plane_vector(dir_prev, dir_new) {
  adjustment = 0.03;
  dir_adj = (dir_new - dir_prev) * adjustment;
  dir = dir_prev + dir_adj;
  self.stayahead.dir = dir;
  return dir;
}

function print_debug(string) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    iprintln(string);
  }
}

function print_console_debug(string) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    println(string);
  }
}

function print3d_debug(origin, text, color, alpha, scale, duration, centered) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    if(!isDefined(duration)) {
      duration = 1;
    }

    if(!isDefined(centered)) {
      centered = 0;
    }

    print3d(origin, text, color, alpha, scale, duration, centered);
  }
}

function print2d3d_debug(origin, text, color, alpha, scale, duration, centered, side, line) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    if(!isDefined(duration)) {
      duration = 1;
    }

    if(!isDefined(centered)) {
      centered = 0;
    }

    level thread create_2d_text(text, color, side, line, duration);
  }
}

function create_2d_background() {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    if(!isDefined(self.stayahead.bg_2d)) {
      self.stayahead.bg_2d = newhudelem();
    } else {
      return;
    }

    self.stayahead.bg_2d.alignx = "<dev string:x11b>";
    self.stayahead.bg_2d.aligny = "<dev string:x122>";
    self.stayahead.bg_2d.horzalign = "<dev string:x126>";
    self.stayahead.bg_2d.vertalign = "<dev string:x126>";
    self.stayahead.bg_2d.x = 310;
    self.stayahead.bg_2d.y = 70;
    self.stayahead.bg_2d.sort = -10;
    self.stayahead.bg_2d.alpha = 0.5;
    self.stayahead.bg_2d setshader("<dev string:x131>", 160, 52);
  }
}

function create_2d_text(string, color, side, line, duration) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    offset_x = 232;

    switch (side) {
      case #"hash_96815ce4f2a3dbc5":
        offset_x += 63;
        break;
    }

    offset_y = 72;
    offset_y += 6 * line;
    text = newhudelem();
    text settext(string);
    text.fontscale = 0.5;
    text.alignx = "<dev string:x64>";
    text.aligny = "<dev string:x122>";
    text.horzalign = "<dev string:x126>";
    text.vertalign = "<dev string:x126>";
    text.x = offset_x;
    text.y = offset_y;
    text.sort = 100;
    text.color = color;
    text.alpha = 1;
    duration *= 0.05;
    wait duration;
    text destroy();
  }
}

function line_debug(start, end, color, alpha, depthtest, duration) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    if(!isDefined(color)) {
      color = (1, 1, 1);
    }

    if(!isDefined(alpha)) {
      alpha = 1;
    }

    if(!isDefined(depthtest)) {
      depthtest = 0;
    }

    if(!isDefined(duration)) {
      duration = 1;
    }

    line(start, end, color, alpha, depthtest, duration);
  }
}

function sphere_debug(origin, radius, color, depthtest, duration) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    sphere(origin, radius, color, depthtest, duration);
  }
}

function node_display_debug(origin, text, color, alpha, scale, duration, centered, no_endon) {
  if(isstruct(self) || isnode(self) && isDefined(self.targetname) && !isDefined(no_endon)) {
    level notify(self.targetname);
    level endon(self.targetname);
  }

  for(i = 0; i < duration; i++) {
    print3d_debug(origin + (0, 0, 6), text, color, alpha, scale, 1, centered);
    sphere_debug(origin, 6, color, 0, 1);
    waitframe();
  }
}

function display_goto_path(color) {
  og_color = color;

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    if(isDefined(self.using_goto_node) && isDefined(self.patharray)) {
      foreach(i, node in self.patharray) {
        if(isDefined(self.patharrayindex) && i < self.patharrayindex) {
          color = (1, 0, 0);
        } else {
          color = og_color;
        }

        node thread node_display_debug(node.origin, "goto: " + i, color, 1, 0.2, 100, 1);

        if(isDefined(node.target)) {
          if(isDefined(getStruct(node.target, "targetname"))) {
            line_debug(node.origin, getStruct(node.target, "targetname").origin, color, 1, 0, 1);
            continue;
          }

          if(isDefined(getnode(node.target, "targetname"))) {
            line_debug(node.origin, getnode(node.target, "targetname").origin, color, 1, 0, 1);
          }
        }
      }
    }
  }
}