/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\stayahead.gsc
**************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace stayahead;

function stayahead_thread(followent) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("G\xc0&e\t\x811\xf6E\xa1\x8eGWW");

  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  if(!utility::ent_flag_exist("w(\x8eU\xd6\xeed\xa6\xb1\xdeO\xd6\x97\xa19")) {
    utility::ent_flag_init("w(\x8eU\xd6\xeed\xa6\xb1\xdeO\xd6\x97\xa19");
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
      p1speed = self.stayahead.p1["\xa2\xac\xd9\xd7H"];
      p2speed = self.stayahead.p2["\xa2\xac\xd9\xd7H"];
      p3speed = self.stayahead.p3["\xa2\xac\xd9\xd7H"];
      p4speed = self.stayahead.p4["\xa2\xac\xd9\xd7H"];
      p1var = self.stayahead.p1["\x17!t\x02\xce\xf6)\x15"] ?? 0.2;
      p2var = self.stayahead.p2["\x17!t\x02\xce\xf6)\x15"] ?? 0.2;
      p3var = self.stayahead.p3["\x17!t\x02\xce\xf6)\x15"] ?? 0.2;
      p4var = self.stayahead.p4["\x17!t\x02\xce\xf6)\x15"] ?? 0.2;
    }

    p1dist = self.stayahead.p1["\x06\xfb\xa6\n]\xf5\xc0@"];
    p2dist = self.stayahead.p2["\x06\xfb\xa6\n]\xf5\xc0@"];
    p3dist = self.stayahead.p3["\x06\xfb\xa6\n]\xf5\xc0@"];
    p4dist = self.stayahead.p4["\x06\xfb\xa6\n]\xf5\xc0@"];
    pwdist = undefined;
    pwspeed = undefined;
    pwbuffer = undefined;

    if(isDefined(self.stayahead.pw)) {
      pwdist = self.stayahead.pw["\x06\xfb\xa6\n]\xf5\xc0@"];
      pwspeed = self.stayahead.pw["\xa2\xac\xd9\xd7H"];
      pwbuffer = self.stayahead.pw["\x8d\xd7\xc9p\xb7*"] ?? 1.5;
      pwbuffer *= 20;
    }

    if(getdvarint(@ "hash_3d6aec1e7192648b")) {
      if(self.arriving) {
        print3d_debug(self.origin + (0, 0, 16), "<dev string:x24>" + self.arriving, (0.9, 0.9, 0.9), 0.9, 0.3);
      }

      if(istrue(self._blackboard.var_7fc947f13b59fc6d)) {
        print2d3d_debug(self.origin + (0, 0, 12), "<dev string:x32>" + self._blackboard.var_7fc947f13b59fc6d, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "<dev string:x49>", 5);
      }

      thread create_2d_background();

      if(utility::ent_flag("<dev string:x52>")) {
        level thread create_2d_text("<dev string:x65>", (1, 0, 0), "<dev string:x7b>", 0, 1);
      } else {
        level thread create_2d_text("<dev string:x83>", (0, 1, 1), "<dev string:x7b>", 0, 1);
      }

      level thread create_2d_text("<dev string:x8d>", (0, 1, 1), "<dev string:x49>", 0, 1);
      level thread create_2d_text("<dev string:x93>" + utility_sp::get_player_demeanor(), (0, 1, 1), "<dev string:x7b>", 1, 1);
      level thread create_2d_text("<dev string:x8d>", (0, 1, 1), "<dev string:x7b>", 4, 1);

      if(isDefined(self.demeanoroverride)) {
        level thread create_2d_text("<dev string:x93>" + self.demeanoroverride, (0, 1, 1), "<dev string:x7b>", 5, 1);
      }

      if(isDefined(self.goalradius)) {
        level thread create_2d_text("<dev string:xa1>" + self.goalradius, (0, 1, 1), "<dev string:x7b>", 6, 1);
      }

      if(isDefined(level.player.movementstate)) {
        level thread create_2d_text("<dev string:xb1>" + level.player.movementstate, (0, 1, 1), "<dev string:x7b>", 2, 1);
      }

      if(isDefined(level.player.movespeedscale)) {
        level thread create_2d_text("<dev string:xc5>" + level.player.movespeedscale, (0, 1, 1), "<dev string:x7b>", 3, 1);
      }
    }

    fwdpos = utility::flat_origin(self getposonpath(32));
    goalpos2d = utility::flat_origin(goalpos[0]);
    prevgoalpos2d = utility::flat_origin(prevgoalpos[0]);
    origin2d = utility::flat_origin(self.origin);

    if(self isinscriptedstate()) {
      if(isDefined(self.stayahead.exit_speed) && !isDefined(self.stayahead.exit_finish_time)) {
        self.stayahead.exit_finish_time = gettime();
        self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
      } else {
        self.stayahead.exit_speed = undefined;
        self.stayahead.exit_finish_time = undefined;
      }

      print2d3d_debug(self.origin + (0, 0, 30), "\xff\xe4ns\x05C\x14\xf5<\xa3\xc5\xacK2~ED\xde \xdb" + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 4);
    } else if(self.arriving || distancesquared(goalpos2d, origin2d) < 1024) {
      if(isDefined(self.stayahead.exit_speed) && !isDefined(self.stayahead.exit_finish_time)) {
        self.stayahead.exit_finish_time = gettime();
        self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
      } else {
        self.stayahead.exit_speed = undefined;
        self.stayahead.exit_finish_time = undefined;
      }

      if(isDefined(self.goalnode) && istrue(self.goalnode.script_useangles)) {
        print2d3d_debug(self.origin + (0, 0, 30), "\x83\xa0\"(:J\xae6\x1dt$\x17A<\xcd\t\a\x8e\xb3A\xad\x01\xf5\x8fy\x1f\r\xac\xbc\x01\x9b\xf7}\xba\x97L\x8b,e\xda\xd2\x93N\x84.\x89:" + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 4);
        dir = lerp_plane_vector(dir, anglesToForward(self.goalnode.angles));
      } else if(isDefined(goalpos[1])) {
        print2d3d_debug(self.origin + (0, 0, 30), "\xdbD\xc2\xb6\xc8\xe23q\xe41\xbe\xd7-\x98\xcf\xc7\xf6\xe3\xf6\xbb\xbc\x96\xc4\xc9\\%Z\xf9\x13\b\xa1\x10C" + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 4);
        goalpos2d = utility::flat_origin(goalpos[1]);
        dir = lerp_plane_vector(dir, vectorNormalize(goalpos2d - origin2d));
      } else {
        print2d3d_debug(self.origin + (0, 0, 30), "U,\xeb\xfb\xb1\xa30\x15\x99a\x87\xa8\x8a^\x04uqT\xb7\x91h\x7f\xa9|\x85\xed\xa3\xc0\xae\xebQD" + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 4);
        dir = lerp_plane_vector(dir, anglesToForward(self.angles));
      }
    } else if(istrue(self._blackboard.var_7fc947f13b59fc6d) || distancesquared(prevgoalpos2d, origin2d) < 1024) {
      if(istrue(self._blackboard.var_7fc947f13b59fc6d) && !isDefined(self.stayahead.exit_speed)) {
        self.stayahead.exit_speed = -1;
      }

      if(isDefined(self.using_goto_node)) {
        print2d3d_debug(self.origin + (0, 0, 30), "}\x1e\xbcf\x84$\x04\xba\xe2\x90\xf9\x1c\xac\xbc\x93$<\xb2\x94\x87\xc4`\xf7\x8d\xf2;" + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 4);
        goalpos2d = utility::flat_origin(goalpos[0]);
        dir = lerp_plane_vector(dir, vectorNormalize(goalpos2d - prevgoalpos2d));
      } else if(isDefined(goalpos[1])) {
        print2d3d_debug(self.origin + (0, 0, 30), "2Z\xc9t\x10+\xe1-\x8e\xb47\xce\x80:z\n\x98\x04\xce\xca\x1b:o\xe4\x1d\x04" + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 4);
        goalpos2d = utility::flat_origin(goalpos[1]);
        dir = lerp_plane_vector(dir, vectorNormalize(goalpos2d - prevgoalpos2d));
      } else {
        print2d3d_debug(self.origin + (0, 0, 30), "-\x16\xdd\xbb\x0fp\x95\x9c]\x01\xa1\xffG\xe2\xfd\xb9K\xb6v\x8a\x8fD\x9cB\xd4" + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 4);
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

      print2d3d_debug(self.origin + (0, 0, 30), "#\xcc\xdd\x04\x8b\xfb\x1b\x14\xa87\xfa\x81\x02D\xd9\x82\xbb\xc1wf\xd4\x0e|rIM\"\xdf\x1a\x9dHE\rC!;" + gettime(), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 4);

      if(distance(fwdpos, origin2d) < 1) {
        print_debug("\x1d}N\x1c\xe1MA\x8f\xb8)\xc1\x8d=\x93\x84,\xb8HI2S\xfd\xc1B\xc0\xad{c6\xc6\xf1\xfb\x1f\x97\x92" + gettime());
        dir = lerp_plane_vector(dir, vectorNormalize(goalpos2d - fwdpos));
      } else {
        dir = lerp_plane_vector(dir, vectorNormalize(fwdpos - origin2d));
      }
    }

    p2pos = self.origin + dir * p2dist;
    p3pos = self.origin + dir * p3dist;
    p4pos = self.origin + dir * p4dist;
    var_15dd429514b5d5c7 = distance(p2pos, p3pos) * 0.25;
    var_6480758bad8c29f0 = distance(p2pos, p3pos) * 0.6;
    var_f398f099951ac0bc = distance(p2pos, p3pos) * 0.25;
    var_252c93eb34d5f4c7 = distance(p3pos, p4pos) * 0.6;
    var_be22700099ec7cdd = distance(p3pos, p4pos) * 0.25;
    var_fbb6d8bf9ea9ab52 = distance(p3pos, p4pos) * 0.6;
    dotp2 = vectordot(vectorNormalize(followent.origin - p2pos), dir);
    dotp3 = vectordot(vectorNormalize(followent.origin - p3pos), dir);
    dotp4 = vectordot(vectorNormalize(followent.origin - p4pos), dir);
    p1pos = undefined;
    dotp1 = undefined;
    var_bd93492c294af056 = undefined;
    var_5e2f3609b6ebca5 = undefined;

    if(isDefined(p1dist)) {
      p1pos = self.origin + dir * p1dist;
      dotp1 = vectordot(vectorNormalize(followent.origin - p1pos), dir);
      var_bd93492c294af056 = distance(p1pos, p2pos) * 0.25;
      var_5e2f3609b6ebca5 = distance(p1pos, p2pos) * 0.6;
      var_15dd429514b5d5c7 = distance(p1pos, p2pos) * 0.25;
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
      var_dd6019af6ab89e62 = p2pos + dir * var_15dd429514b5d5c7;
      var_3c8872046cdd62ec = p2pos + dir * var_6480758bad8c29f0 * -1;
      var_aa408b1b66213307 = p3pos + dir * var_f398f099951ac0bc;
      var_7d8a05c1868c2eb = p3pos + dir * var_252c93eb34d5f4c7 * -1;
      var_2a93b6f642794120 = p4pos + dir * var_be22700099ec7cdd;
      var_821fc3f7d21de9ea = p4pos + dir * var_fbb6d8bf9ea9ab52 * -1;
      line_debug(self.origin, goalpos[0], (0.9, 0.9, 0.9));
      print3d_debug(goalpos[0], "<dev string:xd9>", (0.9, 0.9, 0.9), 0.9, 0.3, 1, 1);
      offsetorigin = self.origin + (0, 0, 5);
      line_debug(offsetorigin, offsetorigin + dir * 80, (0, 0, 0.9));

      if(isDefined(goalpos[1])) {
        line_debug(goalpos[0], goalpos[1], (0.9, 0, 0));
        print3d_debug(goalpos[1], "<dev string:xe3>", (1, 0, 1), 0.9, 0.3, 1, 1);
      }

      line_debug(p2pos + debugright * 300, p2pos + debugleft * 300, (1, 0, 0));
      line_debug(p3pos + debugright * 300, p3pos + debugleft * 300, (0, 1, 0));
      line_debug(p4pos + debugright * 300, p4pos + debugleft * 300, (0, 0, 1));
      line_debug(var_dd6019af6ab89e62 + debugright * 300, var_dd6019af6ab89e62 + debugleft * 300, (1, 0.8, 0.8));
      line_debug(var_3c8872046cdd62ec + debugright * 300, var_3c8872046cdd62ec + debugleft * 300, (1, 0.8, 0.8));
      line_debug(var_aa408b1b66213307 + debugright * 300, var_aa408b1b66213307 + debugleft * 300, (0.8, 1, 0.8));
      line_debug(var_7d8a05c1868c2eb + debugright * 300, var_7d8a05c1868c2eb + debugleft * 300, (0.8, 1, 0.8));
      line_debug(var_2a93b6f642794120 + debugright * 300, var_2a93b6f642794120 + debugleft * 300, (0.8, 0.8, 1));
      line_debug(var_821fc3f7d21de9ea + debugright * 300, var_821fc3f7d21de9ea + debugleft * 300, (0.8, 0.8, 1));
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
        var_d76f11af45e0c68b = p1pos + dir * var_bd93492c294af056;
        var_c1140a88c8530377 = p1pos + dir * var_5e2f3609b6ebca5 * -1;
        line_debug(var_d76f11af45e0c68b + debugright * 300, var_d76f11af45e0c68b + debugleft * 300, (1, 0.8, 1));
        line_debug(var_c1140a88c8530377 + debugright * 300, var_c1140a88c8530377 + debugleft * 300, (1, 0.8, 1));
      }

      if(isDefined(pwpos)) {
        line_debug(pwpos + debugright * 300, pwpos + debugleft * 300, (0, 1, 1));
        print3d_debug(pwpos, "<dev string:xfe>", (0.25, 1, 1), 0.9, 0.3);
      }

      print2d3d_debug(self.origin + (0, 0, 20), "<dev string:x106>" + distancesquared(goalpos[0], self.origin), (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "<dev string:x49>", 3);
      thread display_goto_path((0, 1, 1));
    }

    if(utility::ent_flag("w(\x8eU\xd6\xeed\xa6\xb1\xdeO\xd6\x97\xa19")) {
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
            print3d_debug(self.origin + (0, 0, 10), "\xee\xf2;\x8c\f@\x8ax/C\xc11\xb5\xf0\xf7\xef\xdd\x9c\x8f\x943\xe2", (1, 0, 1), 1, 0.5, 500, 1);

            if(isDefined(self.patharray)) {
              self.stayahead.goalnode = self.patharray[self.patharray.size - 1];
            } else {
              print3d_debug(self.origin + (0, 0, 14), "\xa2\xa0\x85\xf2V\r\x97~\xfeA\xd7^\xb9\xccH\x18\x95\x15O\xd4?\xaa\x0e\xc3\xd47\x11\xf5\xcd\xf1\xb0l\xb2\x13$v/--\xc7\x9d\xa7x|\xf6\xce?'h:\xf7\xdf\xf7\xb4Q\x97q\xf1/a<\xd27\x88\taak\x172\xe6\xf2\xba#\\\x9b\xf8.\x17\xe9\x93*\xe677vp", (1, 0, 0), 1, 0.5, 500, 1);
            }
          } else if(isDefined(self.goalnode)) {
            self.stayahead.goalnode = self.goalnode;
          } else {
            print3d_debug(self.origin, "\x9ch\xb6\xcb|\xe1\x11\x12>\xf9I\xa0_\x8c\xe1\xbe\xa4(\x02\xdd\bQ\xd4\xfa", (1, 0, 0), 1, 0.5, 200, 1);
          }
        }

        if(isDefined(self.stayahead.goalnode) && !isDefined(self.stayahead.goalnode_pw) && self.stayahead.pw_behind_buffer > pwbuffer) {
          var_cdd6541087cc826f = get_wait_node();

          if(isDefined(var_cdd6541087cc826f) && distance(self.origin, var_cdd6541087cc826f.origin) <= self.stayahead.wait_node_radius && distance(self.origin, var_cdd6541087cc826f.origin) > 32 && stayahead_goal_is_far_enough(var_cdd6541087cc826f)) {
            self.stayahead.goalnode_pw = var_cdd6541087cc826f;
            line_debug(self.origin, self.origin + dir * -100, (1, 1, 1), 1, 0, 500);
            line_debug(self.origin, var_cdd6541087cc826f.origin, (1, 0, 0), 1, 0, 500);
            print3d_debug(self.origin, "n\v?|\x19\x7f||\xcci\x04\xa8v\x10L\xd2\xc0\x9e" + distance(self.origin, var_cdd6541087cc826f.origin) + "OF\x1d\xb9\xd5\xe7\x1a\xc8\x122\xb1\vX" + self.goalradius, (1, 1, 0), 1, 0.3, 500, 1);
            childthread stayahead_wait_set_goal_or_path();
            childthread stayahead_set_goalnode(var_cdd6541087cc826f, 1);
          } else if(!isDefined(var_cdd6541087cc826f)) {
            print2d3d_debug(self.origin + (0, 0, 16), "\x83u\x01\xcc\xc2K6\x04\xcd\xdb\x01\xdd\xb0\xd2\x1d \xdc\xdeF\xac\xcd", (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 6);
          } else if(distance(self.origin, var_cdd6541087cc826f.origin) >= self.stayahead.wait_node_radius) {
            line_debug(self.origin, var_cdd6541087cc826f.origin, (1, 0, 0), 1, 0, 1);
            print2d3d_debug(self.origin + (0, 0, 16), "\x1f\xc4\xb8\xbc\xf4\xf0|\xcfh\xff\xea!\xb8Ks`#\xa2+\x16\xd0\xc5\xb1\xad#\x93\xa2" + distance(self.origin, var_cdd6541087cc826f.origin), (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 6);
          } else if(distance(self.origin, var_cdd6541087cc826f.origin) < 32) {
            line_debug(self.origin, var_cdd6541087cc826f.origin, (1, 0, 0), 1, 0, 1);
            print2d3d_debug(self.origin + (0, 0, 16), "^.=n\xbf\xe0\xd4W~B\x86\x1f\xf8O0\x93*\x99\xdb\x9f\xf3\xcf\xce\xd2\xcd\xf3\xcc\xa0m" + distance(self.origin, var_cdd6541087cc826f.origin), (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 6);
          }
        } else if(!isDefined(self.stayahead.goalnode)) {
          print2d3d_debug(self.origin + (0, 0, 16), "\x9b\xef\xce\n0\x05g]\xdf\xdco\xad\xf5\x9e\x9f\x89\a`\xea\xcb{\xed\xaf\xca\xf4t\xdf", (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 6);
        } else if(isDefined(self.stayahead.goalnode_pw)) {
          print2d3d_debug(self.origin + (0, 0, 16), "oq\\U/P\xc7\xc4O2r\xad\xc9\x15b\x19\x99\x1e\xccf\x1f\xbe\xe5\tm\xb4\x96Q^\xb4", (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 6);
        } else if(self.stayahead.pw_behind_buffer < pwbuffer) {
          print2d3d_debug(self.origin + (0, 0, 16), "\xbb\x01\xb6\x94q\b\xa9-/\xf7\x1bR\xd9\x11PM\xd0O\xb4\xd9\xc59\x8c\xc1", (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 6);
        } else {
          print2d3d_debug(self.origin + (0, 0, 16), "\x15\xe4\xd2R#\xc5\x1a\xaa9+>\x9c\x0ew", (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 6);
        }

        self.stayahead.pw_behind_buffer += 1;

        if(self.stayahead.pw_behind_buffer > pwbuffer) {
          print2d3d_debug(self.origin + (0, 0, 12), "k\x88\xd5\x132\xf6hC{\xcd\\~\xfb\xa4FbA_" + self.stayahead.pw_behind_buffer, (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 7);
        } else {
          print2d3d_debug(self.origin + (0, 0, 12), "k\x88\xd5\x132\xf6hC{\xcd\\~\xfb\xa4FbA_" + self.stayahead.pw_behind_buffer, (0, 0, 1), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 7);
        }
      } else if(isDefined(self.stayahead.goalnode) && isDefined(self.stayahead.goalnode_pw)) {
        self.stayahead.pw_behind_buffer = 0;

        if(dotp4 > 0 && self.stayahead.pw_infront_buffer > pwbuffer * 0.4 || dotp3 > 0) {
          print3d_debug(self.origin, ")]\xcf\xa7\xd9\x94\x1d\xd8\xefv\t\x1fIu \x05D@" + distance(self.origin, self.stayahead.goalnode.origin), (0, 1, 0), 1, 0.3, 500, 1);
          self.stayahead.goalnode_pw = undefined;
          childthread stayahead_set_goalnode(self.stayahead.goalnode, 0);
          self.stayahead.goalnode = undefined;
        }

        self.stayahead.pw_infront_buffer += 1;
        print2d3d_debug(self.origin + (0, 0, 12), "\x86d\x13g{iD\xc1\x04\xd7\x92\xee\xc9\xa8\x95\xe75\x8f\xf9" + self.stayahead.pw_infront_buffer, (0, 1, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 7);
      } else {
        self notify("4\xf4\x18\n\x8c\xc0\xc6HtTO\xd1\x82M\xe16<{\xa5\x99\x10\xc3\xdbI");
        self.stayahead.pw_behind_buffer = 0;
        print2d3d_debug(self.origin + (0, 0, 12), "\x12_\x9a\xa2b\x18\xa4\xe7\xd7\x93i'<", (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 5);
      }
    }

    if(isDefined(dotp1) && dotp1 > 0) {
      if(lastpos != "\xf3\xa7\xf5R?\xc2\xb5") {
        prevpos = lastpos;
        lastpos = "\xf3\xa7\xf5R?\xc2\xb5";
      }

      stayahead_set_speed(1, followent, p1dist + var_bd93492c294af056, p1dist, dir, p1speed, p1speed + p1speed * p1var, 1);
    } else if(dotp2 > 0) {
      if(lastpos != "\x83\xc8F\x9cos\x1d") {
        prevpos = lastpos;
        lastpos = "\x83\xc8F\x9cos\x1d";
      }

      if(prevpos == "o\xb9o\xd7!L\a" || prevpos == "") {
        stayahead_set_speed(2, followent, p2dist + var_15dd429514b5d5c7, p2dist, dir, p2speed, p2speed + p2speed * p2var);
      } else if(isDefined(dotp1)) {
        stayahead_set_speed(1, followent, p1dist, p1dist - var_5e2f3609b6ebca5, dir, p1speed + p1speed * p1var * -1, p1speed, 1);
      } else {
        stayahead_set_speed(2, followent, p2dist + var_15dd429514b5d5c7, p2dist, dir, p2speed, p2speed + p2speed * p2var);
      }
    } else if(dotp3 > 0) {
      if(lastpos != "o\xb9o\xd7!L\a") {
        prevpos = lastpos;
        lastpos = "o\xb9o\xd7!L\a";
        stayahead_lookat(followent);
      }

      if(prevpos == "\xfc\xad\xcd\x0e\xa4\xd5\xc3" || prevpos == "") {
        stayahead_set_speed(3, followent, p3dist + var_f398f099951ac0bc, p3dist, dir, p3speed, p3speed + p3speed * p3var);
      } else {
        stayahead_set_speed(2, followent, p2dist, p2dist - var_6480758bad8c29f0, dir, p2speed + p2speed * p2var * -1, p2speed);
      }
    } else if(dotp4 > 0) {
      if(lastpos != "\xfc\xad\xcd\x0e\xa4\xd5\xc3") {
        prevpos = lastpos;
        lastpos = "\xfc\xad\xcd\x0e\xa4\xd5\xc3";
        stayahead_lookat(followent);
      }

      if(prevpos == "\xb0\x15n\xe7s1" || prevpos == "") {
        stayahead_set_speed(4, followent, p4dist + var_be22700099ec7cdd, p4dist, dir, p4speed, p4speed + p4speed * p4var);
      } else {
        stayahead_set_speed(3, followent, p3dist, p3dist - var_252c93eb34d5f4c7, dir, p3speed + p3speed * p3var * -1, p3speed);
      }
    } else if(dotp4 < 0) {
      if(isDefined(dotpw) && dotpw < 0) {}

      if(lastpos != "\xb0\x15n\xe7s1") {
        prevpos = lastpos;
        lastpos = "\xb0\x15n\xe7s1";
        stayahead_lookat(followent);
      }

      stayahead_set_speed("G", followent, p4dist, p4dist - var_fbb6d8bf9ea9ab52, dir, p4speed + p4speed * p4var * -1, p4speed);
    } else {
      print2d3d_debug(self.origin + (0, 0, 30), "\xea\xb5m\xfb\x10-", (0.9, 0, 0), 0.9, 0.3, 250, 0, "o0\xee\xc1\x8c", 4);
    }

    waitframe();
  }
}

function stayahead_lookat(followent) {
  if(!istrue(self.stayahead.lookat_allowed)) {
    return;
  }

  if(istrue(self.lookingatent)) {
    print3d_debug(self.origin + (0, 0, 50), "p._.w\xab\x93\x1d\xad\r\xc2\xf5oM\xc3I|\x03\xf1\xb6R\xacbG\x99\xd5\xfdi\xa4", (0.9, 0, 0), 0.9, 0.3, 250);
    return;
  }

  if(gettime() - self.stayahead.lookat_last < 3000) {
    print3d_debug(self.origin + (0, 0, 50), "kA\x17*Oy\xd05\xf2t\xf9\a\x1aI\x10\xdbo!\xfbwy{", (0.9, 0, 0), 0.9, 0.3, 250);
    return;
  }

  self notify("s\xe8{8}\xdc\xe8,\xbc\x854+\xc2#\xf5\xc6\xbd\xdb\xb6X\xd1");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("s\xe8{8}\xdc\xe8,\xbc\x854+\xc2#\xf5\xc6\xbd\xdb\xb6X\xd1");
  lookattime = 0.5;
  self.stayahead.lookat_last = gettime();
  childthread stayahead_lookat_debug(lookattime);
  utility::lookatentity(followent);
  utility::delaythread(lookattime, &utility::lookatentity);
  wait lookattime * 0.6;
}

function stayahead_lookat_far(followent) {
  self endon("\x1e\xfd\xd1\xa2\a");
  lookatdelay = randomfloatrange(6000, 11000);

  if(gettime() > self.stayahead.lookat_last + lookatdelay) {
    stayahead_lookat(followent);
  }
}

function stayahead_lookat_debug(lookattime) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    starttime = gettime();

    while(gettime() - starttime + lookattime * 1000) {
      print3d_debug(self.origin + (0, 0, 60), "<dev string:x11a>", (0.9, 0, 0), 0.9, 0.3);
      waitframe();
    }
  }

}

function stayahead_set_speed(plane, followent, forwarddist, backdist, dir, minspeed, maxspeed, catchup) {
  print2d3d_debug(self.origin, "s\xf0\xd92W\x9bs" + plane, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 1);
  forwardpos = self.origin + dir * forwarddist;
  backpos = self.origin + dir * backdist;

  if(distance(forwardpos, backpos) < 1) {
    print_debug("\xb9\x80\a\xe0\xfe2\x94\xdd\xc3\xb1\x0e\xde\xd3\xd6|q\xe5\x1a\xca\x9f\xcbT|\x0e\xda\xbc\x8a\xe2\xf1{~{E\x80\x98\x15\xd4\xd1mw!id" + gettime());
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
        print3d_debug(self.origin + (0, 0, 32), "\xb1\xb9\x10\xe6\xf9\xaflp-\n\xaavA\\r\xfb\x98\x1b\xed\xdd\x1eOk\xd3R\x8d" + plane + "\xa5\x10\xf5\xed|l\xfc" + diff + "\x90\xbaju\xb7\a\x8e\xe5\xdd\"Z" + curspeed + "\x9c)W\x95\x90\xb7b\x99" + speed, (1, 1, 1), 1, 0.1, 100, 1);
        print_console_debug("\xb1\xb9\x10\xe6\xf9\xaflp-\n\xaavA\\r\xfb\x98\x1b\xed\xdd\x1eOk\xd3R\x8d" + plane + "\xa5\x10\xf5\xed|l\xfc" + diff + "\x90\xbaju\xb7\a\x8e\xe5\xdd\"Z" + curspeed + "\x9c)W\x95\x90\xb7b\x99" + speed);
      } else {
        speed = curspeed + clamp(diff, -10, 10);
        self.stayahead.last_speed_set_time = gettime();
        print3d_debug(self.origin + (0, 0, 32), "\xaa\xf3p\x01`[\xa3\xe7\xcb\x11\xe6(d9\x1cS\xe2\xc1\xd2\xb0j']\xff\xbay" + plane + "\xa5\x10\xf5\xed|l\xfc" + diff + "\x90\xbaju\xb7\a\x8e\xe5\xdd\"Z" + curspeed + "\x9c)W\x95\x90\xb7b\x99" + speed, (1, 1, 1), 1, 0.1, 100, 1);
        print_console_debug("\xaa\xf3p\x01`[\xa3\xe7\xcb\x11\xe6(d9\x1cS\xe2\xc1\xd2\xb0j']\xff\xbay" + plane + "\xa5\x10\xf5\xed|l\xfc" + diff + "\x90\xbaju\xb7\a\x8e\xe5\xdd\"Z" + curspeed + "\x9c)W\x95\x90\xb7b\x99" + speed);
      }
    } else if(isDefined(self.stayahead_accel)) {
      speed = curspeed + clamp(diff, -1 * self.stayahead_accel, self.stayahead_accel);
      self.stayahead.last_speed_set_time = gettime();
    } else {
      speed = curspeed + clamp(diff, -3.5, 3.5);
      self.stayahead.last_speed_set_time = gettime();
    }

    utility::set_movement_speed(speed);

    if(isDefined(self.stayahead.exit_speed) && self.stayahead.exit_speed == -1) {
      self.stayahead.exit_speed = speed;
    }

    line_debug(followent.origin, playerpos);
    print2d3d_debug(self.origin + (0, 0, 8), "\xab\xd9\xbfUWj\x03" + speed, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "o0\xee\xc1\x8c", 2);
    print3d_debug(playerpos + (0, 0, 8), speed, (0.9, 0.9, 0.9), 0.9, 0.3);
    return;
  }

  print3d_debug(self.origin + (0, 0, 8), "wX\x90\xa78\x8c\xbe\a\x03H\x19\x10\xf0\xc1}x\x92\xdcfv \xeb\x15\x12\xe0\xa7Z)\xfd\x9b" + gettime(), (0.9, 0, 0), 0.9, 0.3, 1);
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
      print3d_debug(path[i].origin, "\x9b,2\x97}\x94\x83\x9e+\x18\xcb|n\xcc\xea&Q\x10:R\x91S\x7f\x8f\xca\x95%" + dots[i], (0, 1, 0), 1, 0.3, 200, 1);
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
        path[i] thread print3d_debug(path[i].origin, "<dev string:x125>" + dot, (0, 1, 0), 1, 0.3, 200, 1);
        continue;
      }

      if(i != largestindex) {
        path[i] thread node_display_debug(path[i].origin, "<dev string:x138>" + dot, (1, 0, 0), 1, 0.3, 200, 1);
      }
    }
  }

  return path[largestindex];
}

function get_goto_nodes(nodes) {
  if(isDefined(self.patharray)) {
    nodes = utility::array_combine(nodes, self.patharray);
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
  linkednode = getnode(self.target, #targetname);

  if(isDefined(linkednode)) {
    return linkednode;
  } else {
    linkednode = utility::getStruct(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  }

  return linkednode;
}

function get_wait_node(dir) {
  nodes = [];

  if(isDefined(self.stayahead.wait_nodes)) {
    nodes = self.stayahead.wait_nodes;
    nodes = sortbydistance(nodes, self.origin);
  } else if(!isDefined(self.stayahead.use_goto_wait)) {
    nodes = getnodesinradiussorted(self.origin, self.stayahead.wait_node_radius, 0, 64, ":\xc9\x93\xe1?");
  }

  if(isDefined(self.using_goto_node) && istrue(self.stayahead.use_goto_wait)) {
    nodes = utility::array_combine(nodes, get_goto_nodes(nodes));
    nodes = sortbydistance(nodes, self.origin);
  }

  allowed_dot = 0.75;

  foreach(i, node in nodes) {
    nodedot = vectordot(vectorNormalize(node.origin - self.origin), self.stayahead.dir);
    goalnodesafe = isDefined(self.goalnode) && node == self.goalnode ? 0 : 1;
    goalpossafe = isDefined(self.goalpos) && node.origin == self.goalpos ? 0 : 1;

    if(!isDefined(node.stayahead_wait_used) && !isDefined(node.script_dontremove) && nodedot >= allowed_dot && goalnodesafe && goalpossafe) {
      if(isDefined(self.script_forcecolor) && isDefined(node.script_color_allies) && issubstr(node.script_color_allies, self.script_forcecolor)) {
        line_debug(self.origin, node.origin, (0, 1, 0), 1, 0, 1);
        node thread node_display_debug(node.origin, node.script_color_allies, (0, 1, 0), 1, 0.2, 1000, 1);
      } else if(isDefined(self.script_forcecolor) && !isDefined(self.stayahead.use_goto_wait)) {
        if(!isDefined(node.script_color_allies)) {
          if(isDefined(self.stayahead.wait_nodes) && !isDefined(utility::array_find(self.stayahead.wait_nodes, node))) {
            node thread node_display_debug(node.origin, "\x16J\xf6\xde\x83g\xb3\x93S\xac?\xf2\xbd\x92M\x0f\x1c\xa5\x85\xf2P\xb5\x7f`\x8d\x0f\x83", (1, 0, 1), 1, 0.2, 1000, 1);
            nodes = arrayremove(nodes, node);
          }
        } else if(!issubstr(node.script_color_allies, self.script_forcecolor)) {
          node thread node_display_debug(node.origin, "\xe1\xd5\xcd=\xf0)\xe7\xa9\x89\x1f\xa3\x14Ch\xf5\xa7:\xc6\xa4\xb7A\x8dI\x13\x12c\x03\fHV", (1, 0, 1), 1, 0.2, 1000, 1);
          nodes = arrayremove(nodes, node);
        }
      }

      continue;
    }

    if(!isDefined(node.script_dontremove)) {
      if(isDefined(node.stayahead_wait_used)) {
        node thread node_display_debug(node.origin, "\xb4\xb9\xb3\x16\xc6idG \xd5\xb9V\x91", (1, 0, 1), 1, 0.2, 1000, 1);
      } else if(nodedot < 0) {
        node thread node_display_debug(node.origin, "\x03\x8f\xadq\xa77,\xc1x06xu]J", (0, 0, 1), 1, 0.2, 1000, 1);
      } else if(nodedot < allowed_dot) {
        node thread node_display_debug(node.origin, "\xf7\\80\x06\xff\x89\xb7G]\xc4A\xee\xfd\xaa\xa3()\\\x9f" + nodedot, (1, 0, 0), 1, 0.2, 1000, 1);
      } else if(!goalnodesafe) {
        node thread node_display_debug(node.origin, "\xe1\x14\x80\xeel\x06\x1d\xafn\xb6_:\xa6\xf8\x15\x02\"\x9a\xa4\xa4", (1, 0, 0), 1, 0.2, 1000, 1);
      } else if(!goalpossafe) {
        node thread node_display_debug(node.origin, "i\xfcR\v\xf1\xab\xe0.an\x91\xd8[O>\x8aM\xba\xa9", (1, 0, 0), 1, 0.2, 1000, 1);
      } else {
        node thread node_display_debug(node.origin, "\t^z\xe0t\xa9g99<", (1, 0, 1), 1, 0.2, 1000, 1);
      }

      nodes = arrayremove(nodes, node);
    }
  }

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    foreach(node in nodes) {
      node thread node_display_debug(node.origin, "\xf5R\xccn\x90k\xbc\xccq\x0e\x1f" + i, (0, 1, 0), 1, 0.2, 1000, 1);
    }
  }

  var_cdd6541087cc826f = undefined;

  if(nodes.size > 0) {
    var_1876439aa1c6b6d0 = undefined;

    foreach(node in nodes) {
      if(isnode(node)) {
        var_1876439aa1c6b6d0 = node;
        break;
      }
    }

    var_cdd6541087cc826f = nodes[0];

    if(isstruct(nodes[0]) && isDefined(var_1876439aa1c6b6d0)) {
      if(distance(nodes[0].origin, var_1876439aa1c6b6d0.origin) < 128) {
        if(node_within_fov(var_1876439aa1c6b6d0)) {
          print3d_debug(var_1876439aa1c6b6d0.origin, "\x88\x9cu(\x8d\x17\x87\xbc\xcbX\"g", (1, 1, 1), 1, 0.3, 1, 1);
          print3d_debug(self.origin, "bE0\xc4\xdf\xdeQ;}<\x10\xcd@7\xff\x7f\x8e2g0U4ewk'\xfcg8ww\xbe.3#\f\vhkc\xf9i\x05\x18\b\xa7#\xdb:e\x93\\\x9f", (1, 1, 1), 1, 0.3, 100, 1);
          var_cdd6541087cc826f = var_1876439aa1c6b6d0;
        }
      }
    }
  } else {
    print3d_debug(self.origin, "~\xce\xcf\x9f\xa4H\xaf\x18}\b\x1d\xe7\xa1\x1c6\x7f\xf4\xb8_\xe0\x87\x83\xffY]\x98\x98{<\xbe\x05\xcbf}6\x03#\x1ce7[n9,\xc3x\x96\x8f^\xbe", (1, 0, 0), 1, 0.3, 100, 1);
  }

  return var_cdd6541087cc826f;
}

function pause_flag_monitor() {
  while(true) {
    utility::ent_flag_wait("w(\x8eU\xd6\xeed\xa6\xb1\xdeO\xd6\x97\xa19");
    print3d_debug(self.origin + (0, 0, 16), "}\x81\x9f-\x1b<\xa3\xdc\xcb\xbb\xb0KynS3z", (0, 1, 1), 1, 0.3, 1000, 1);
    utility::function_18e9f1084badc1c7("w(\x8eU\xd6\xeed\xa6\xb1\xdeO\xd6\x97\xa19");
    print3d_debug(self.origin + (0, 0, 16), "m\x80\x05\x86Z\xa1jme\xb9An\xc43\x03P]CW", (0, 1, 1), 1, 0.3, 1000, 1);
    self.stayahead.pw_behind_buffer = 0;
  }
}

function waitnode_trigger_think(node, trigger) {
  thread delay_endon(0.05, "\x9d\xbdXc\xd7\xb1\x86\x16\x9b\xd9Yd");
  self waittill("\x83\xd6\xaf\x11");
  thread utility_sp::stayahead_pause(1);
  childthread waitnode_trigger_debug(node, trigger);
  childthread waitnode_trigger_delay_speed_clear();
  msg = trigger utility::waittill_any_return("\x91`\xb1\xe7T\x97>", "\x1e\xfd\xd1\xa2\a");
  thread utility_sp::stayahead_pause(0);
  childthread stayahead_set_goalnode(self.stayahead.goalnode, 0);
}

function waitnode_trigger_delay_speed_clear() {
  waittillframeend();
  self.stayahead.last_speed_set_time = undefined;
}

function waitnode_trigger_debug(node, trigger) {
  trigger endon("\x1e\xfd\xd1\xa2\a");
  trigger endon("\x91`\xb1\xe7T\x97>");

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    for(;;) {
      print3d_debug(trigger.origin, "<dev string:x14a>", (0, 1, 0), 1, 0.3, 1, 1);
      line_debug(node.origin, trigger.origin, (0, 1, 0), 1, 0, 1);
      utility::draw_entity_bounds(trigger, 0.05, (0, 1, 0));
      waitframe();
    }
  }

}

function stayahead_watch_end() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  self.stayahead.active = 1;
  self waittill("G\xc0&e\t\x811\xf6E\xa1\x8eGWW");

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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("G\xc0&e\t\x811\xf6E\xa1\x8eGWW");
  self notify("4\xf4\x18\n\x8c\xc0\xc6HtTO\xd1\x82M\xe16<{\xa5\x99\x10\xc3\xdbI");
  self endon("4\xf4\x18\n\x8c\xc0\xc6HtTO\xd1\x82M\xe16<{\xa5\x99\x10\xc3\xdbI");
  thread delay_endon(0.05, "\x9d\xbdXc\xd7\xb1\x86\x16\x9b\xd9Yd");
  stayahead_at_waitnode(node);
  self[[self.stayahead.wait_func]]();
}

function stayahead_wait_set_goal_or_path() {
  if(isDefined(self.using_goto_node)) {
    self.stayahead.goto_patharray = self.patharray;
    self.stayahead.using_goto_node = 1;

    for(i = 0; i <= self.patharrayindex; i++) {
      if(self.stayahead.goto_patharray.size > 1) {
        print_console_debug("R\xb2k\xbd;in\x9d \xb3\xb7\xd7\xe8\xed\xbe7\xbdd+\x01\xdcW\xd6G\x01" + i);
        self.stayahead.goto_patharray = utility::array_remove_index(self.stayahead.goto_patharray, 0);
      }
    }

    return;
  }

  if(isDefined(self.goalnode)) {
    self.stayahead.goalnode = self.goalnode;
  }
}

function stayahead_at_waitnode(node) {
  thread delay_endon(0.05, "\x9d\xbdXc\xd7\xb1\x86\x16\x9b\xd9Yd");

  while(distance2dsquared(self.origin, node.origin) > 64) {
    print3d_debug(self.origin, "I\xcfJ\x1c\xeb\xc4\x17\x1bX0\xb3~Iy\x03\xa7\xd3\x1c4hB\xad\xfa\x97" + distance2dsquared(self.origin, node.origin), (1, 1, 1), 1, 0.3, 1, 1);
    waitframe();
  }
}

function stayahead_goal_is_far_enough(var_cdd6541087cc826f) {
  if(node_within_fov(self.stayahead.goalnode)) {
    if(distance(self.origin, self.stayahead.goalnode.origin) - distance(self.origin, var_cdd6541087cc826f.origin) < 128) {
      print2d3d_debug(self.origin + (0, 0, 16), "\x1cW\x01\xcc\xc2\xb4\x8d\x10\xd9\xf6\v67\xb7FV\b\xe8\xbd\xdb@\x1b6o\xb9\xb2\xe8\b" + distance(self.origin, self.stayahead.goalnode.origin) + "n\xd1\xab<\xb3\x90\xe04-\"1" + distance(self.origin, var_cdd6541087cc826f.origin), (1, 0, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 5);
      return false;
    }
  } else {
    print2d3d_debug(self.origin + (0, 0, 16), "\xc1\x9c\xe5B\xc6\xaf\x992\xd5\xa5A\x84\x89\xed\xc1\x10\x1f\xf2\xf6i\xdf\x93\x04\xc0\xaa\xb3\xa6yyx6\xb0", (0, 1, 0), 1, 0.3, 1, 0, "o0\xee\xc1\x8c", 5);
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
      node = spawncovernode(structpos, angles, "\xf7\xd5d'hTb", 1);

      if(!isDefined(node)) {
        print3d_debug(structpos, "\xc5\xfdx\xed\xec%\xda\xf11\xc2k'\xa3a\x95\xe7F\x05\xa1;\xd7\xa8K!a?1\xf1\x99\xf9\n\xd3\xfb\xadh\xb9_\xff\ny\xa9\a\xa97\x1bf\xe5 u\xae@\xd9\xe4\x8b\xb7\xf92\xab\x8f\x81\xe1\x88\x9f\x9f\xec\x9a8#\x8cD>", (1, 1, 0), 1, 0.3, 500, 1);
        node = spawncovernode(getgroundposition(structpos, 32), angles, "\xf7\xd5d'hTb", 1);

        if(isDefined(node)) {
          print3d_debug(node.origin + (0, 0, 4), "\xb3\"\xa5\xf3^|\xb0z\xd9\x80\xfb\xdeh\xccH\x18\x95\aO\xc4o\xaa\x03\xc5\x8co\xdb\xf7f\xf1\a\x8c\xe3\x0f>\xf3j-\xec\xcbA\x93\xe4", (1, 1, 0), 1, 0.3, 500, 1);
        }
      }

      if(!isDefined(node)) {
        print3d_debug(structpos, "\xdd\x92\x10\xd3\xbf\x13\xac]\xd3\xae\xd9\x9c\xd7Qrw\xa6pq\xf7\x0f\xa7r\xd1Uz\x9f", (1, 0, 0), 1, 0.3, 500, 1);
        return;
      }

      self.stayahead.spawned_wait_node = node;
    }

    node.stayahead_wait_used = 1;
    self notify("7:a\xf2\x16\xa1Y,\x19\xbe\x9d{\xb4n\xec}:{\xebw,i\x8e\xfa\xdc\xf6F+");
    self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
    utility_sp::set_goal_node(node);

    if(isDefined(self.stayahead.goto_patharray) && node == self.stayahead.goto_patharray[self.stayahead.goto_patharray.size - 1]) {
      self.stayahead.goto_finished = 1;
    }

    if(isDefined(self.stayahead.wait_func)) {
      childthread stayahead_wait_func(node);
    }

    linked_ents = node utility::get_linked_ents();

    if(linked_ents.size > 0) {
      foreach(ent in linked_ents) {
        if(issubstr(ent.code_classname, "\x91`\xb1\xe7T\x97>")) {
          childthread waitnode_trigger_think(node, ent);
        }
      }
    }

    return;
  }

  if(isDefined(self.stayahead.using_goto_node)) {
    self notify("4\xf4\x18\n\x8c\xc0\xc6HtTO\xd1\x82M\xe16<{\xa5\x99\x10\xc3\xdbI");
    self notify("iB\xd9\xb8w\x10\xc9\xa4\xe2M\xac7\x92u\xaes\x7f\xdd\x84\xdcQ\x02y-\x03\xf7b");

    if(istrue(self.stayahead.goto_finished)) {
      print3d_debug(self.origin + (0, 0, 8), "\xd8X\xa8\xaa.\xe3\x0fj\xc0\x1aN\xf0\x06Q\xb0I\x0e\x11\x18\xa2G\x9e\xe2\xeb\x96\xd5#K\x90P\xd8\xa9\xf5\x86\n:'\xf81'\x01\xfd:\xe7", (0, 1, 0), 1, 0.3, 500, 1);
      self.stayahead.goto_finished = undefined;
      self notify("\x05[\xf8\x84\x04\x06\x01:p\x01\xde\x10\xcc\xb3\xb0\xf8");
    } else {
      print3d_debug(self.origin + (0, 0, 8), "\x88\xd2&\xa5\b\x91\xaf\xe8N\xfc\x0e\xec\xdd\xf4\xabd\xaaX'\xce\x84F\xb6\xd1\x85\xed\x9f\xa4", (0, 1, 0), 1, 0.3, 500, 1);
      node = get_best_goto_node(self.stayahead.goto_patharray, 2);
      thread spawner::go_to_node(node);
      self.stayahead.using_goto_node = 1;
    }

    return;
  }

  self notify("4\xf4\x18\n\x8c\xc0\xc6HtTO\xd1\x82M\xe16<{\xa5\x99\x10\xc3\xdbI");
  self notify("iB\xd9\xb8w\x10\xc9\xa4\xe2M\xac7\x92u\xaes\x7f\xdd\x84\xdcQ\x02y-\x03\xf7b");
  self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  utility_sp::set_goal_node(node);
}

function stayahead_team_think() {
  self.stayahead.team_thinking = 1;
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("G\xc0&e\t\x811\xf6E\xa1\x8eGWW");
  speedscale = 0.8;
  p1speed = self.stayahead.p1["\xa2\xac\xd9\xd7H"];
  p2speed = self.stayahead.p2["\xa2\xac\xd9\xd7H"];
  p3speed = self.stayahead.p3["\xa2\xac\xd9\xd7H"];
  p4speed = self.stayahead.p4["\xa2\xac\xd9\xd7H"];
  p1dist = self.stayahead.p1["\x06\xfb\xa6\n]\xf5\xc0@"];
  p2dist = self.stayahead.p2["\x06\xfb\xa6\n]\xf5\xc0@"];
  p3dist = self.stayahead.p3["\x06\xfb\xa6\n]\xf5\xc0@"];
  p4dist = self.stayahead.p4["\x06\xfb\xa6\n]\xf5\xc0@"];
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

      guy childthread utility_sp::enable_dynamic_run_speed(self, p4speed * speedscale, p3speed * speedscale, p2speed * speedscale, guy.stayahead.dynamic_frontdist, guy.stayahead.dynamic_middist, guy.stayahead.dynamic_backdist);

      if(!isDefined(guy.stayahead.dir)) {
        guy.stayahead.dir = anglesToForward(self.angles);
      }

      if(!isDefined(guy.stayahead.wait_node_radius)) {
        guy.stayahead.wait_node_radius = self.stayahead.wait_node_radius;
      }
    }

    self waittill("7:a\xf2\x16\xa1Y,\x19\xbe\x9d{\xb4n\xec}:{\xebw,i\x8e\xfa\xdc\xf6F+");

    foreach(guy in self.stayahead.team) {
      guy childthread stayahead_wait_set_goal_or_path();
      guy utility_sp::disable_dynamic_run_speed(p4speed);
      var_cdd6541087cc826f = guy get_wait_node(vectortoangles(guy.angles));

      if(isDefined(var_cdd6541087cc826f)) {
        guy childthread stayahead_set_goalnode(var_cdd6541087cc826f, 1);
      }
    }

    self waittill("iB\xd9\xb8w\x10\xc9\xa4\xe2M\xac7\x92u\xaes\x7f\xdd\x84\xdcQ\x02y-\x03\xf7b");

    foreach(guy in self.stayahead.team) {
      guy.stayahead.dir = anglesToForward(guy.angles);
      guy.stayahead.using_goto_node = 1;
      guy childthread stayahead_set_goalnode(guy.stayahead.goto_patharray[0], 0);
    }
  }
}

function stayahead_team_debug() {
  self endon("G\xc0&e\t\x811\xf6E\xa1\x8eGWW");

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

    self.stayahead.bg_2d.alignx = "<dev string:x15f>";
    self.stayahead.bg_2d.aligny = "<dev string:x169>";
    self.stayahead.bg_2d.horzalign = "<dev string:x170>";
    self.stayahead.bg_2d.vertalign = "<dev string:x170>";
    self.stayahead.bg_2d.x = 310;
    self.stayahead.bg_2d.y = 70;
    self.stayahead.bg_2d.sort = -10;
    self.stayahead.bg_2d.alpha = 0.5;
    self.stayahead.bg_2d setshader("<dev string:x17e>", 160, 52);
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
    text.alignx = "<dev string:x7b>";
    text.aligny = "<dev string:x169>";
    text.horzalign = "<dev string:x170>";
    text.vertalign = "<dev string:x170>";
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

        node thread node_display_debug(node.origin, "U\x18#\x82^\xde" + i, color, 1, 0.2, 100, 1);

        if(isDefined(node.target)) {
          if(isDefined(utility::getStruct(node.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc"))) {
            line_debug(node.origin, utility::getStruct(node.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc").origin, color, 1, 0, 1);
            continue;
          }

          if(isDefined(getnode(node.target, #targetname))) {
            line_debug(node.origin, getnode(node.target, #targetname).origin, color, 1, 0, 1);
          }
        }
      }
    }
  }
}