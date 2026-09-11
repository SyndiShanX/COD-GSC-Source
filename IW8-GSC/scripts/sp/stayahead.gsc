/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\stayahead.gsc
***********************************************/

function stayahead_thread(var0) {
  self endon("death");
  self endon("stop_stayahead");

  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  if(!scripts\engine\utility::ent_flag_exist("stayahead_pause")) {
    scripts\engine\utility::ent_flag_init("stayahead_pause");
  }

  thread stayahead_watch_end();
  GscBinSkip4(0x35);
}

function stayahead_lookat(var0) {
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
  var1 = 0.5;
  self.stayahead.lookat_last = gettime();
  GscBinSkip4(0x35, var1);
}

function stayahead_lookat_far(var0) {
  self endon("death");
  var1 = randomfloatrange(6000, 11000);

  if(gettime() > self.stayahead.lookat_last + var1) {
    stayahead_lookat(var0);
    return;
  }
}

function stayahead_lookat_debug(var0) {}

function stayahead_set_speed(var0, var1, var2, var3, var4, var5, var6, var7) {
  print2d3d_debug(self.origin, "Plane: " + var0, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 1);
  var8 = self.origin + var4 * var2;
  var9 = self.origin + var4 * var3;

  if(distance(var8, var9) < 1) {
    print_debug("segments are colliding, not setting speed! " + gettime());
    return;
  }

  var10 = pointonsegmentnearesttopoint(var8, var9, var1.origin);
  var11 = distance(var8, var10);
  var12 = var2 - var3;
  var13 = 1 - scripts\engine\math::lerp_fraction(0, abs(var12), var11);
  var14 = 250;

  if(isDefined(self.stayahead.turbo) || istrue(var7)) {
    var14 = 300;
  }

  if(!isDefined(self.stayahead.exit_last_finish_time) || gettime() > self.stayahead.exit_last_finish_time + 1000) {
    var15 = scripts\engine\math::lerp(var5, var6, var13);
    var15 = clamp(var15, 23, var14);
    var16 = self aigetdesiredspeed();
    var17 = var15 - var16;

    if(istrue(var7) || var17 > 50) {
      if(!istrue(var7) && !isDefined(self.stayahead.last_speed_set_time)) {
        var15 = var16 + clamp(var17, -2, 2);
        self.stayahead.last_speed_set_time = undefined;
        print3d_debug(self.origin + (0, 0, 32), "StayAhead STARTUP! plane: " + var0 + " diff: " + var17 + " curSpeed: " + var16 + " speed: " + var15, (1, 1, 1), 1, 0.1, 100, 1);
        print_console_debug("StayAhead STARTUP! plane: " + var0 + " diff: " + var17 + " curSpeed: " + var16 + " speed: " + var15);
      } else {
        var15 = var16 + clamp(var17, -10, 10);
        self.stayahead.last_speed_set_time = gettime();
        print3d_debug(self.origin + (0, 0, 32), "StayAhead CATCHUP! plane: " + var0 + " diff: " + var17 + " curSpeed: " + var16 + " speed: " + var15, (1, 1, 1), 1, 0.1, 100, 1);
        print_console_debug("StayAhead CATCHUP! plane: " + var0 + " diff: " + var17 + " curSpeed: " + var16 + " speed: " + var15);
      }
    } else if(isDefined(self.stayahead_accel)) {
      var15 = var16 + clamp(var17, -1 * self.stayahead_accel, self.stayahead_accel);
      self.stayahead.last_speed_set_time = gettime();
    } else {
      var15 = var16 + clamp(var17, -3.5, 3.5);
      self.stayahead.last_speed_set_time = gettime();
    }

    scripts\engine\utility::set_movement_speed(var15);

    if(isDefined(self.stayahead.exit_speed) && self.stayahead.exit_speed == -1) {
      self.stayahead.exit_speed = var15;
    }

    line_debug(var1.origin, var10);
    print2d3d_debug(self.origin + (0, 0, 8), "speed: " + var15, (0.9, 0.9, 0.9), 0.9, 0.3, 1, 0, "right", 2);
    print3d_debug(var10 + (0, 0, 8), var15, (0.9, 0.9, 0.9), 0.9, 0.3);
    return;
  }

  print3d_debug(self.origin + (0, 0, 8), "IsExiting, not setting speed: " + gettime(), (0.9, 0, 0), 0.9, 0.3, 1);
}

function get_best_goto_node(var0, var1) {
  var2 = [];
  var3 = 0;
  var4 = undefined;

  for(var5 = 0; var5 < var1; var5++) {
    if(!isDefined(var0[var5])) {
      break;
    }

    var2 = vectordot(vectorNormalize(var0[var5].origin - self.origin), self.stayahead.dir);

    if(var2[var5] < 0) {
      var1 += 1;
      continue;
    }

    if(var2[var5] > 0.5) {
      print3d_debug(var0[var5].origin, "GOTO GOOD ENOUGH re-start: " + var2[var5], (0, 1, 0), 1, 0.3, 200, 1);
      var4 = 1;
      var3 = var5;
      break;
    }

    if(var2[var5] > var2[var3]) {
      var3 = var5;
    }
  }

  return var0[var3];
}

function get_goto_nodes(var0) {
  if(isDefined(self.patharray)) {
    var0 = scripts\engine\utility::array_combine(var0, self.patharray);
  }

  return var0;
}

function get_goalpos() {
  var0 = [];

  if(isDefined(self.goalnode)) {
    GscBinSkip0(0x2e, 0, self.goalnode.origin);
  }

  GscBinSkip0(0x2e, 0, self.scriptgoalpos);
}

function get_node_or_struct() {
  var0 = getnode(self.target, "targetname");

  if(isDefined(var0)) {
    return var0;
  } else {
    var0 = scripts\engine\utility::getStruct(self.target, "targetname");
  }

  return var0;
}

function get_wait_node(var0) {
  var1 = [];

  if(isDefined(self.stayahead.wait_nodes)) {
    var1 = self.stayahead.wait_nodes;
    var1 = sortbydistance(var1, self.origin);
  } else if(!isDefined(self.stayahead.use_goto_wait)) {
    var1 = getnodesinradiussorted(self.origin, self.stayahead.wait_node_radius, 0, 64, "cover");
  }

  if(isDefined(self.using_goto_node) && istrue(self.stayahead.use_goto_wait)) {
    var1 = scripts\engine\utility::array_combine(var1, get_goto_nodes(var1));
    var1 = sortbydistance(var1, self.origin);
  }

  var2 = 0.75;

  foreach(var8, var4 in var1) {
    var5 = vectordot(vectorNormalize(var4.origin - self.origin), self.stayahead.dir);
    var6 = scripts\engine\utility::ter_op(isDefined(self.goalnode) && var4 == self.goalnode, 0, 1);
    var7 = scripts\engine\utility::ter_op(isDefined(self.goalpos) && var4.origin == self.goalpos, 0, 1);

    if(!isDefined(var4.stayahead_wait_used) && !isDefined(var4.script_dontremove) && var5 >= var2 && var6 && var7) {
      if(isDefined(self.script_forcecolor) && isDefined(var4.script_color_allies) && issubstr(var4.script_color_allies, self.script_forcecolor)) {
        line_debug(self.origin, var4.origin, (0, 1, 0), 1, 0, 1);
        thread node_display_debug(var4, var4.origin, var4.script_color_allies, (0, 1, 0), 1, 0.2, 1000);
      } else if(isDefined(self.script_forcecolor) && !isDefined(self.stayahead.use_goto_wait)) {
        if(!isDefined(var4.script_color_allies)) {
          if(isDefined(self.stayahead.wait_nodes) && !isDefined(scripts\engine\utility::array_find(self.stayahead.wait_nodes, var4))) {
            thread node_display_debug(var4, var4.origin, "invalid: no color, removing", (1, 0, 1), 1, 0.2, 1000);
            var1 = scripts\engine\utility::array_remove(var1, var4);
          }
        } else if(!issubstr(var4.script_color_allies, self.script_forcecolor)) {
          thread node_display_debug(var4, var4.origin, "invalid: wrong color, removing", (1, 0, 1), 1, 0.2, 1000);
          var1 = scripts\engine\utility::array_remove(var1, var4);
        }
      }

      continue;
    }

    if(!isDefined(var4.script_dontremove)) {
      if(isDefined(var4.stayahead_wait_used)) {
        thread node_display_debug(var4, var4.origin, "invalid: used", (1, 0, 1), 1, 0.2, 1000);
      } else if(var5 < 0) {
        thread node_display_debug(var4, var4.origin, "removed: behind", (0, 0, 1), 1, 0.2, 1000);
      } else if(var5 < var2) {
        thread node_display_debug(var4, var4.origin, "removed: bad angle: " + var5, (1, 0, 0), 1, 0.2, 1000);
      } else if(!var6) {
        thread node_display_debug(var4, var4.origin, "removed: IS goalNode", (1, 0, 0), 1, 0.2, 1000);
      } else if(!var7) {
        thread node_display_debug(var4, var4.origin, "removed: IS goalPos", (1, 0, 0), 1, 0.2, 1000);
      } else {
        thread node_display_debug(var4, var4.origin, "invalid???", (1, 0, 1), 1, 0.2, 1000);
      }

      var1 = scripts\engine\utility::array_remove(var1, var4);
    }
  }

  if(getdvarint("scr_debug_stayahead")) {
    foreach(var4 in var1) {
      thread node_display_debug(var4, var4.origin, "wait node: " + var8, (0, 1, 0), 1, 0.2, 1000);
    }
  }

  var10 = undefined;

  if(var1.size > 0) {
    var11 = undefined;

    foreach(var4 in var1) {
      if(isnode(var4)) {
        var11 = var4;
        break;
      }
    }

    var10 = var1[0];

    if(isstruct(var1[0]) && isDefined(var11)) {
      if(distance(var1[0].origin, var11.origin) < 128) {
        if(node_within_fov(var11)) {
          print3d_debug(var11.origin, "NEAREST NODE", (1, 1, 1), 1, 0.3, 1, 1);
          print3d_debug(self.origin, "STAYAHEAD: using closest 'node' bc it's not a struct!", (1, 1, 1), 1, 0.3, 100, 1);
          var10 = var11;
        }
      }
    }
  } else {
    print3d_debug(self.origin, "STAYAHEAD: NO BEST WAIT NODE, RETURNING UNDEFINED!", (1, 0, 0), 1, 0.3, 100, 1);
  }

  return var10;
}

function pause_flag_monitor() {
  for(;;) {
    scripts\engine\utility::ent_flag_wait("stayahead_pause");
    print3d_debug(self.origin + (0, 0, 16), "PAUSING stayahead", (0, 1, 1), 1, 0.3, 1000, 1);
    scripts\engine\utility::ent_flag_waitopen("stayahead_pause");
    print3d_debug(self.origin + (0, 0, 16), "UNpausing stayahead", (0, 1, 1), 1, 0.3, 1000, 1);
    self.stayahead.pw_behind_buffer = 0;
    self.stayahead.goalnode_pw = undefined;
  }
}

function waitnode_trigger_think(var0, var1) {
  thread delay_endon(0.05, "goal_changed");
  self waittill("goal");
  thread scripts\sp\utility::stayahead_pause(1);
  GscBinSkip4(0x35, var0, var1);
}

function waitnode_trigger_delay_speed_clear() {
  waittillframeend();
  self.stayahead.last_speed_set_time = undefined;
}

function waitnode_trigger_debug(var0, var1) {
  var1 endon("death");
  var1 endon("trigger");
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
      return;
    }

    return;
  }
}

function stayahead_wait_func(var0) {
  self endon("death");
  self endon("stop_stayahead");
  self notify("stop_stayahead_wait_func");
  self endon("stop_stayahead_wait_func");
  thread delay_endon(0.05, "goal_changed");
  stayahead_at_waitnode(var0);
  self[[self.stayahead.wait_func]]();
}

function stayahead_wait_set_goal_or_path() {
  if(isDefined(self.using_goto_node)) {
    self.stayahead.goto_patharray = self.patharray;
    self.stayahead.using_goto_node = 1;

    for(var0 = 0; var0 <= self.patharrayindex; var0++) {
      if(self.stayahead.goto_patharray.size > 1) {
        print_console_debug("Removing go_to_node num: " + var0);
        self.stayahead.goto_patharray = scripts\engine\utility::array_remove_index(self.stayahead.goto_patharray, 0);
      }
    }

    return;
  }

  if(isDefined(self.goalnode)) {
    self.stayahead.goalnode = self.goalnode;
    return;
  }
}

function stayahead_at_waitnode(var0) {
  thread delay_endon(0.05, "goal_changed");

  while(distance2dsquared(self.origin, var0.origin) > 64) {
    print3d_debug(self.origin, "distanceSQ to waitnode: " + distance2dsquared(self.origin, var0.origin), (1, 1, 1), 1, 0.3, 1, 1);
    waitframe();
  }
}

function stayahead_goal_is_far_enough(var0) {
  if(node_within_fov(self.stayahead.goalnode)) {
    if(distance(self.origin, self.stayahead.goalnode.origin) - distance(self.origin, var0.origin) < 128) {
      print2d3d_debug(self.origin + (0, 0, 16), "pW fail goalnode too close: " + distance(self.origin, self.stayahead.goalnode.origin) + " Waitnode: " + distance(self.origin, var0.origin), (1, 0, 0), 1, 0.3, 1, 0, "right", 5);
      return false;
    }
  } else {
    print2d3d_debug(self.origin + (0, 0, 16), "pW fail goalnode not within FOV.", (0, 1, 0), 1, 0.3, 1, 0, "right", 5);
  }

  return true;
}

function node_within_fov(var0) {
  if(isDefined(self.stayahead) && isDefined(self.stayahead.dir)) {
    var1 = self.stayahead.dir;
  } else {
    var1 = anglesToForward(self.angles);
  }

  var2 = vectordot(var1, vectorNormalize(var1.origin - self.origin));

  if(var2 >= 0.9) {
    return true;
  }

  return false;
}

function delay_endon(var0, var1) {
  wait var0;
  self endon(var1);
}

function stayahead_goto_can_use_wait(var0) {
  if(isDefined(self.using_goto_node)) {
    if(isDefined(self.stayahead.goto_nextnode) && distance(self.origin, self.stayahead.goto_nextnode.origin) > distance(self.origin, var0[0].origin)) {
      return 1;
    }

    return 0;
  }

  return 1;
}

function stayahead_set_goalnode(var0, var1) {
  if(isDefined(self.stayahead.spawned_wait_node)) {
    despawncovernode(self.stayahead.spawned_wait_node);
  }

  if(!isDefined(var0)) {
    return;
  }

  if(istrue(var1)) {
    if(isstruct(var0)) {
      var2 = vectortoangles(self.stayahead.dir);
      var0 = spawncovernode(var0.origin, var2, "Exposed");

      if(!isDefined(var0)) {
        print3d_debug(self.origin + (0, 0, 8), "UNABLE TO SPAWN COVER NODE!", (1, 0, 0), 1, 0.3, 500, 1);
        return;
      }

      self.stayahead.spawned_wait_node = var0;
    }

    var0.stayahead_wait_used = 1;
    self notify("stayahead_going_to_wait_node");
    self notify("stop_going_to_node");
    scripts\engine\sp\utility::set_goal_node(var0);

    if(isDefined(self.stayahead.goto_patharray) && var0 == self.stayahead.goto_patharray[self.stayahead.goto_patharray.size - 1]) {
      self.stayahead.goto_finished = 1;
    }

    if(isDefined(self.stayahead.wait_func)) {
      GscBinSkip4(0x35, var0);
    }

    var3 = var0 scripts\engine\utility::get_linked_ents();

    if(var3.size > 0) {
      foreach(var5 in var3) {
        if(issubstr(var5.code_classname, "trigger")) {
          GscBinSkip4(0x35, var0, var5);
        }
      }

      return;
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
      return;
    }

    print3d_debug(self.origin + (0, 0, 8), "going BACK to goto patharray", (0, 1, 0), 1, 0.3, 500, 1);
    thread scripts\sp\spawner::go_to_node(get_best_goto_node(self.stayahead.goto_patharray, 2));
    self.stayahead.using_goto_node = 1;
    return;
  }

  self notify("stop_stayahead_wait_func");
  self notify("stayahead_leaving_wait_node");
  self notify("stop_going_to_node");
  scripts\engine\sp\utility::set_goal_node(var4);
}

function stayahead_team_think() {
  self.stayahead.team_thinking = 1;
  self endon("death");
  self endon("stop_stayahead");
  var0 = 0.8;
  var1 = self.stayahead.p1["speed"];
  var2 = self.stayahead.p2["speed"];
  var3 = self.stayahead.p3["speed"];
  var4 = self.stayahead.p4["speed"];
  var5 = self.stayahead.p1["distance"];
  var6 = self.stayahead.p2["distance"];
  var7 = self.stayahead.p3["distance"];
  var8 = self.stayahead.p4["distance"];
  GscBinSkip4(0x35);
}

function stayahead_team_debug() {
  self endon("stop_stayahead");

  for(;;) {
    foreach(var1 in self.stayahead.team) {
      thread display_goto_path(var1);
      line_debug(self.origin, var1.origin, (1, 0, 1), 1, 0, 1);
    }

    waitframe();
  }
}

function lerp_plane_vector(var0, var1) {
  var2 = 0.03;
  var3 = (var1 - var0) * var2;
  var4 = var0 + var3;
  self.stayahead.dir = var4;
  return var4;
}

function print_debug(var0) {}

function print_console_debug(var0) {}

function print3d_debug(var0, var1, var2, var3, var4, var5, var6) {}

function print2d3d_debug(var0, var1, var2, var3, var4, var5, var6, var7, var8) {}

function create_2d_background() {}

function create_2d_text(var0, var1, var2, var3, var4) {}

function line_debug(var0, var1, var2, var3, var4, var5) {}

function sphere_debug(var0, var1, var2, var3, var4) {
  if(getdvarint("scr_debug_stayahead")) {
    return;
  }
}

function node_display_debug(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isstruct(self) || isnode(self) && isDefined(self.targetname) && !isDefined(var7)) {
    level notify(self.targetname);
    level endon(self.targetname);
  }

  for(var8 = 0; var8 < var5; var8++) {
    print3d_debug(var0 + (0, 0, 6), var1, var2, var3, var4, 1, var6);
    sphere_debug(var0, 6, var2, 0, 1);
    waitframe();
  }
}

function display_goto_path(var0) {
  var1 = var0;

  if(getdvarint("scr_debug_stayahead")) {
    if(isDefined(self.using_goto_node) && isDefined(self.patharray)) {
      foreach(var3 in self.patharray) {
        if(isDefined(self.patharrayindex) && var4 < self.patharrayindex) {
          var0 = (1, 0, 0);
        } else {
          var0 = var1;
        }

        thread node_display_debug(var3, var3.origin, "goto: " + var4, var0, 1, 0.2, 100);

        if(isDefined(var3.target)) {
          if(isDefined(scripts\engine\utility::getStruct(var3.target, "targetname"))) {
            line_debug(var3.origin, scripts\engine\utility::getStruct(var3.target, "targetname").origin, var0, 1, 0, 1);
            continue;
          }

          if(isDefined(getnode(var3.target, "targetname"))) {
            line_debug(var3.origin, getnode(var3.target, "targetname").origin, var0, 1, 0, 1);
          }
        }
      }

      return;
    }

    return;
  }
}