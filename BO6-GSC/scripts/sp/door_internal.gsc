/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\door_internal.gsc
****************************************/

#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\door;
#using scripts\sp\door_scriptable;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\starts;
#namespace door_internal;

function door_post_load() {
  init_settings();
  init_doors();
  thread trace_completion_thread();
}

function private init_settings() {
  if(isDefined(level.doorsys)) {
    return;
  }

  level.doorsys = {};
  campaignsettings = undefined;
  modebundle = getgamemodescriptbundle();

  if(isDefined(modebundle.campaignsettings)) {
    campaignsettings = getscriptbundle(modebundle.campaignsettings);
  }

  level.doorsys.pushmaxrate = campaignsettings.var_fb20871bfdfcdabe ?? 25;
  level.doorsys.pusheasetime = campaignsettings.var_e8846c9050cf55bb ?? 1;
  level.doorsys.var_bdb2c2ff700fba5 = campaignsettings.var_ec85628a0326eded ?? 0.5;
}

function init_window() {
  assert(isDefined(self.target), "<dev string:x24>" + self.origin + "<dev string:x32>");
  panes = getEntArray(self.target, #targetname);

  foreach(pane in panes) {
    if(!isDefined(pane.script_linkto)) {
      continue;
    }

    clip = pane utility::get_linked_ent();
    clip linkTo(pane);
  }

  linked_nodes = utility::get_linked_nodes();

  foreach(node in linked_nodes) {
    if(node.targetname == "\x0eq\x9e\b\xf4\xd9*Y") {
      destroynavlink(node);
      continue;
    }

    if(node.script_noteworthy == ":\xc9\x93\xe1?") {
      node disconnectnode();
    }
  }

  cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"game/door_open", 55, 135 * level.interactive_doors.hint_dist_scale, 85 * level.interactive_doors.hint_dist_scale, 1);
  self.cursor_hint_ent setusewhenhandsoccupied(1);
  event = waittill_window_event();
  cursor_hint::remove_cursor_hint();

  if(event == "\x91`\xb1\xe7T\x97>") {
    thread player_window_gesture(0.65);
    opentime = 0.8;
    sound = "U\x7f\x90kI\xd4\x8eA\xf5z4\xeaZI";
  } else {
    door_bash_presentation();
    opentime = 0.35;
    sound = "*$\xf1\x81 \xd8L\x05\xbfL\xd8\x92U\x1c";
  }

  function_66993c2733f63f3e("G\xa0>\a\x83\xca\xf8\xdeF\xbf1", level.player, level.player.origin, 384, undefined, undefined, 80);

  foreach(pane in panes) {
    if(pane.script_noteworthy == "\x18\x14\xdc\xc8\x1a\x9cOO[1Pf}\xf5") {
      pane delete();
      continue;
    }

    originalangles = pane.angles;
    vector = pane.origin - level.player.origin;
    forward = anglesToForward(originalangles);
    dot = vectordot(vector, forward);
    var_b5f49983a57cb7f4 = dot > 0 ? anglestoright(originalangles) : anglestoleft(originalangles);
    var_e43a2c04deed7457 = vectortoangles(var_b5f49983a57cb7f4);
    goalangles = anglelerpquatfrac(originalangles, var_e43a2c04deed7457, randomfloatrange(1, 1.15));
    pane rotateTo(goalangles, opentime, opentime * 0.8, opentime * 0.2);
    pane playSound(sound);

    if(event == "\x05HX\f\x05\xd4\xc50\xa6Dtt\v") {
      if(isDefined(level.stealth)) {
        thread stealth_broadcast(450, "\xe3\xd0\xc3e\x85h");
      } else {
        thread combat_getinfoinradius(450);
      }

      pane utility::delaycall(opentime, &rotateto, var_e43a2c04deed7457, randomfloatrange(0.75, 1.25));
      pane utility::delaycall(opentime, &playsound, "c\xc8ip\xeaH\\G!\x01\xad\x1dO\xae");
      self notify("\x91`\xb1\xe7T\x97>");
    }
  }

  foreach(node in linked_nodes) {
    if(node.targetname == "\x0eq\x9e\b\xf4\xd9*Y") {
      end_node = getnode(node.target, #targetname);
      createnavlink("p\xfb>4\xa6\x0eX+\x03e\xa5\x95|CeX", node.origin, end_node.origin, node);
      continue;
    }

    if(node.script_noteworthy == ":\xc9\x93\xe1?") {
      node connectnode();
    }
  }
}

function waittill_window_event() {
  while(true) {
    bashed = waittill_melee_or_interact();

    if(!isDefined(bashed) || window_melee_valid(self.origin)) {
      return (isDefined(bashed) ? "\x05HX\f\x05\xd4\xc50\xa6Dtt\v" : "\x91`\xb1\xe7T\x97>");
    }
  }
}

function waittill_melee_or_interact() {
  self endon("\x91`\xb1\xe7T\x97>");
  waitframe();

  while(!level.player ismeleeing()) {
    waitframe();
  }

  return true;
}

function window_melee_valid(windoworigin) {
  if(distancesquared(level.player getEye(), windoworigin) > 2025) {
    return false;
  }

  if(!utility::within_fov(level.player.origin + anglesToForward(level.player.angles) * -50, level.player.angles, windoworigin, 0.731353)) {
    return false;
  }

  return true;
}

function init_doors() {
  doors = getEntArray("r\x8e\x9d\x1c\t\x94\xc9\v;\xb5d}Hu;\x06", #script_noteworthy);

  if(doors.size > 0) {
    global_door_threads();
  }

  utility::array_thread(doors, level.interactive_doors.fndoorinit);

  utility::array_thread(doors, &function_334334340e533b5b);
}

function global_door_threads() {
  if(isDefined(level.doors_initialized)) {
    return;
  }

  if(starts::is_no_game_start()) {
    return;
  }

  level.doors_initialized = 1;
  utility::array_thread(getaiarray(), &door_sp::ai_monitor_doors);
  utility_sp::add_global_spawn_function("O\x15\x1b\xad\x9ff", &door_sp::ai_monitor_doors);
  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &door_sp::ai_monitor_doors);
  utility_sp::add_global_spawn_function("\xba\xa5\x1f\xc9m\x80i", &door_sp::ai_monitor_doors);
  utility_sp::add_global_spawn_function("\x8c\x1b\xab)\xd1", &door_sp::ai_monitor_doors);
}

function init_door_internal(reset) {
  if(!istrue(reset)) {
    assert(!isDefined(self.doorid), "<dev string:x54>" + self.origin + "<dev string:x60>");
  }

  self.pivots = [];
  self.closed_angles = (0, 0, 0);
  self.openers = [];
  self.tryingopener = undefined;
  self.doorid = self getentitynumber();
  self.ai_anim_start = [];
  self.hinge_side = undefined;
  self.breached = 0;
  self.doortype = "\x82\rj\x9c";
  self.clip = undefined;
  self.linked_ents = undefined;
  self.no_bash = undefined;
  self.current_pivot_struct = undefined;
  self.double_swing = undefined;

  if(starts::is_no_game_start()) {
    return;
  }

  if(isDefined(self.open_struct)) {
    self.open_struct.custom_hint_text = undefined;
    self.open_struct.no_open_interact = undefined;

    if(isDefined(self.open_struct.cursor_hint_ent)) {
      self.open_struct.cursor_hint_ent delete();
    }

    self.open_struct.cursor_hint_ent = undefined;
  }

  if(!isDefined(self.true_start_angles)) {
    self.true_start_angles = self.angles;
  }

  if(!isDefined(self.locked)) {
    self.locked = 0;
  }

  if(!utility::ent_flag_exist("-\xb9\x96\xd1ZX\x1b\xd2\xf4Vd")) {
    utility::ent_flag_init("-\xb9\x96\xd1ZX\x1b\xd2\xf4Vd");
  }

  if(istrue(reset)) {
    self.script_spawn_open_yaw = undefined;
  } else {
    level.interactive_doors.ents[level.interactive_doors.ents.size] = self;
  }

  ents = utility::get_linked_ents();
  structs = utility::get_linked_structs();
  doopen = 1;

  if(isDefined(self.script_parameters)) {
    values = strtok(self.script_parameters, "\xda");

    foreach(value in values) {
      switch (value) {
        case #"hash_cb7d0a281b511f3":
          if(!istrue(reset)) {
            self.locked = 1;
            self.lockedforai = 1;
          }

          break;
        case #"hash_8f8efed0bf72f563":
          doopen = 0;
          break;
        case #"hash_dc02c220d09e7dc1":
          self.no_bash = 1;
          break;
        case #"hash_2ef82190668f60b6":
          self.no_handle_ajar = 1;
          break;
        case #"hash_d5bf833956fdf9":
          self.double_swing = 1;
          break;
        case #"hash_d8442f512bb8ab99":
          thread door_sp::function_e3dc42ee4d94f40b();
          break;
        case #"hash_8833e927768f4e12":
          thread door_sp::door_open_completely();
          break;
      }
    }
  }

  foreach(ent in ents) {
    if(isDefined(ent.script_noteworthy)) {
      ent.door = self;

      switch (ent.script_noteworthy) {
        case #"hash_f1589029bfa1a45b":

          if(isDefined(self.clip)) {
            println("<dev string:x7b>" + self.origin + "<dev string:xbc>");
          }

          self.clip = ent;
          ent linkTo(self);
          ent.doorclip = 1;
          break;
        case #"hash_7d9407498809f178":
          self.clip_nosight = ent;
          ent linkTo(self);
          ent.doorclip = 1;
          break;
        case #"hash_be53fa38f2c65d60":
          self.unlock_volume = ent;
          ent thread unlock_volume_logic();
          break;
        case #"hash_6fb23e39e833ccc9":
          if(!isDefined(self.linked_ents)) {
            self.linked_ents = [];
          }

          self.linked_ents[self.linked_ents.size] = ent;
          ent linkTo(self);
          ent.doorclip = 1;
          break;
      }
    }
  }

  foreach(struct in structs) {
    if(isDefined(struct.script_noteworthy)) {
      struct.door = self;

      switch (struct.script_noteworthy) {
        case #"hash_61e6fe8f0d447a0f":
          self.true_start_angles = struct.angles;
          self.open_struct = struct;
          self.length = distance2d(self.origin, self.open_struct.origin);

          if(doopen) {
            setup_open_struct(struct);
          }

          break;
        case #"hash_a42b56ce5d28f109":
          self.pivots["L&\"y\xa0|\xb1\x9dI"] = struct;
          break;
        case #"hash_eda02527ade442aa":
          self.pivots["Nf\xf9\xc9VsI\x92VL"] = struct;
          break;
        case #"hash_1da6ba65ec0ff8e0":
          self.ai_anim_start["\x82}\xeb\x93"] = rotatevectorinverted(struct.origin - self.origin, self.true_start_angles);
          break;
        case #"hash_79d4ad622880225a":
          self.ai_anim_start["\x14+`"] = rotatevectorinverted(struct.origin - self.origin, self.true_start_angles);
          break;
      }
    }
  }

  self.forward = anglesToForward(self.true_start_angles);
  self.open_left = door_sp::should_open_left();
  self.bashed = 0;
  self.bashed_full = 0;
  self.ajar = 0;
  self.open_completely = 0;
  self.was_opened_halfway = 0;
  self.active = 1;
  self.team = self.script_team ?? "";
  get_door_bottom_center();
  initlinkednodes();
  updatenodelookpeek();
  door_scriptable::init_destructible();

  if(self.classname != "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6" && !isDefined(self.clip) && !is_clip_nosight()) {
    self.clip = self;
    self.clip.doorclip = 1;
  }

  linknameprefix = strtok(structs[0].script_linkname, "w")[0];
  createinitialnavmodifier(linknameprefix);
  assert(isDefined(self.clip), "<dev string:xc1>" + self.origin + "<dev string:x110>" + (self.model ?? "<dev string:x120>") + "<dev string:x128>" + (self.targetname ?? "<dev string:x120>") + "<dev string:x139>" + (getentarrayinradius("<dev string:x140>", #classname).size == 0 ? "<dev string:x155>" : "<dev string:x1a0>"));
  assert(!isDefined(self.clip) || self.clip.spawnflags & 1, "<dev string:x1ed>" + self.origin + "<dev string:x110>" + (self.model ?? "<dev string:x120>") + "<dev string:x128>" + (self.targetname ?? "<dev string:x120>") + "<dev string:x263>");
  self.clip connectpaths();
  assert(isDefined(self.true_start_angles));

  if(self.locked) {
    door_sp::create_navobstacle();
  }

  self.nav_lastupdatetime = gettime();
  self.nav_lastupdateangle = self.true_start_angles[1];

  if(!isDefined(self.script_spawn_open_yaw) || istrue(level.interactive_doors.close_prompt)) {
    thread cursor_hint_thread();
  }

  thread door_sp::init_max_yaws();
  thread door_open_think();

  if(isDefined(self.doubledoors)) {
    door_sp::double_doors_init(self.doubledoors[0], self.doubledoors[1]);
  }
}

function is_clip_nosight() {
  return isDefined(self.script_noteworthy) && self.script_noteworthy == " y\xffd\xa5<\x98\xcb\xb2cf\x1d";
}

function cursor_hint_thread(var_b76b68dc377e151) {
  self notify("\xf7\xffa-\tRzB0n\xa0d\xd4\x04\xda\xd6\xe6\xd4");
  self endon("\xf7\xffa-\tRzB0n\xa0d\xd4\x04\xda\xd6\xe6\xd4");
  self endon("\xa6-\xb7\xe1\xc4o\b(\x80\x0f");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("s\xe8{8}\xd8\xeaN\xb9\xbd9\xfa\xd0K\xe6G}\x1d\x86\x9c\x95\x16\x19");
  self.var_d85f7d65c5e146e5 = -1;
  self.var_b73b304164eadad6 = -1;
  self.cursorhintdir = (0, 0, 0);
  has_openstruct = isDefined(self.open_struct);

  while(true) {
    set_player_side();

    if(!has_openstruct && has_cursor_hint(self.open_struct) || cursor_refresh(self.open_struct)) {
      has_openstruct = 1;
      self.var_d85f7d65c5e146e5 = -1;
    }

    if(self.var_d85f7d65c5e146e5 != self.var_b73b304164eadad6) {
      if(isDefined(self.open_struct)) {
        adjust_cursor_hint_side(self.open_struct);
      }

      if(isDefined(self.cam_structs)) {
        foreach(cam_struct in self.cam_structs) {
          adjust_cursor_hint_side(cam_struct);
        }
      }

      if(isDefined(self.c4_struct)) {
        adjust_cursor_hint_side(self.c4_struct);
      }
    }

    if(has_openstruct) {
      has_openstruct = has_cursor_hint(self.open_struct);
    }

    if(isDefined(var_b76b68dc377e151)) {
      self[[var_b76b68dc377e151]]();
    }

    dist = max(0, distance(level.player getEye(), self.origin) - 200);
    level.player function_406ea1d32ca3337(dist / 528);
  }
}

function private function_406ea1d32ca3337(time) {
  self endon(":V\xd8\xac8\xf6\xc9Ge2");

  if(time > 0.05) {
    wait time;
    return;
  }

  waitframe();
}

function cursor_refresh(struct) {
  if(isDefined(struct.refresh)) {
    struct.refresh = undefined;
    return true;
  }

  return false;
}

function has_cursor_hint(struct) {
  if(!isDefined(struct)) {
    return false;
  }

  if(isarray(struct)) {
    foreach(s in struct) {
      if(isDefined(s.cursor_hint_ent)) {
        return true;
      }
    }
  } else {
    return isDefined(struct.cursor_hint_ent);
  }

  return false;
}

function adjust_cursor_hint_side(struct) {
  if(!isDefined(struct.cursor_hint_ent)) {
    return;
  }

  pos = struct.origin;
  door_angles = door_sp::get_door_angles() - self.true_start_angles;

  if(abs(door_angles[1]) > 0.01 && isDefined(self.pivot_ent)) {
    pos_local = pos - self.pivot_ent.origin;
    pos_local = rotatevectorinverted(pos_local, self.true_start_angles);
    pos_local = rotatevector(pos_local, self.pivot_ent.angles);
    pos = pos_local + self.pivot_ent.origin;
  }

  pos += self.cursorhintdir * struct.radius;
  struct.cursor_hint_ent dontinterpolate();
  struct.cursor_hint_ent.origin = pos;
}

function function_171b6944b838fab4() {
  now = gettime();

  if(now > (self.var_f4890ae53b07e552 ?? 0)) {
    self.var_f4890ae53b07e552 = now;
    angles = vectortoangles(self.forward);

    if(isDefined(self.pivot_ent)) {
      angles = self.pivot_ent.angles;
    }

    right = anglestoright(angles);
    normal = vectorNormalize(level.player.origin - self.origin);
    dot = vectordot(right, normal);

    if(dot > 0) {
      self.var_266f4072a0cb544e = [1, right];
    } else {
      self.var_266f4072a0cb544e = [0, right * -1];
    }
  }

  return self.var_266f4072a0cb544e;
}

function set_player_side() {
  var_b73b304164eadad6 = function_171b6944b838fab4();
  self.var_d85f7d65c5e146e5 = self.var_b73b304164eadad6;
  self.var_b73b304164eadad6 = var_b73b304164eadad6[0];
  self.cursorhintdir = var_b73b304164eadad6[1];
}

function trace_completion_thread() {
  while(true) {
    startagain = 0;

    foreach(door in level.interactive_doors.ents) {
      if(!(isDefined(door.max_yaw_left) && isDefined(door.max_yaw_right))) {
        startagain = 1;
        break;
      }
    }

    if(!startagain) {
      break;
    }
  }

  if(!utility::flag("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97")) {
    println("<dev string:x268>");
    utility::flag_wait("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");
  }

  utility::flag_set("\x02\xd7\xfa\x8a*L\xb3(c\xcam\xc8\xc4\xba\xb0)\x16/\xa8/\x91N\x1cs\x02\xe0%g\x89%.\xc4");
  waitframe();
  utility::flag_set("\x90mSl@\x92pP\xfa(\x8f8\xcd\x05\x89w\x04\xa2\r\x06`48");
}

function get_hint_dist(defaultval) {
  if(isDefined(level.interactive_doors.hint_dist_scale)) {
    return (defaultval * level.interactive_doors.hint_dist_scale);
  }

  return defaultval;
}

function function_334334340e533b5b() {
  self endon("<dev string:x2ae>");
  self.debug_activity = "<dev string:x2bf>";

  while(true) {
    if(!getdvarint(@ "hash_6985e82f27803483") || distancesquared(self.origin, level.player.origin) > squared(450)) {
      wait 0.15;
      continue;
    }

    space = 1.85;
    count = 0;
    base = self.origin + (5, 5, 58);
    print3d(base + (0, 0, count * space * -1), "<dev string:x2c3>" + self.doorid, (1, 1, 1), 1, 0.15);
    count++;
    print3d(base + (0, 0, count * space * -1), "<dev string:x2d0>" + self.true_start_angles, (1, 1, 1), 1, 0.15);
    count++;
    print3d(base + (0, 0, count * space * -1), "<dev string:x2e7>" + door_sp::get_door_angles(), (1, 1, 1), 1, 0.15);
    count++;

    if(isDefined(self.current_pivot_struct)) {
      print3d(base + (0, 0, count * space * -1), "<dev string:x2fb>" + self.current_pivot_struct.script_noteworthy, (1, 1, 1), 1, 0.15);
      count++;
    }

    if(isDefined(self.pivot_ent)) {
      print3d(self.pivot_ent.origin + (0, 0, 5), "<dev string:x306>", (1, 1, 1), 1, 0.15);
    }

    print3d(base + (0, 0, count * space * -1), "<dev string:x313>" + self.open_left, (1, 1, 1), 1, 0.15);
    count++;
    print3d(base + (0, 0, count * space * -1), "<dev string:x322>" + self.debug_activity, (1, 1, 1), 1, 0.15);
    count++;

    if(isDefined(self.pivot_ent)) {
      spot = self.pivot_ent.origin;
    } else {
      spot = self.origin;
    }

    print3d(get_door_center(), "<dev string:x330>");
    thread debug::drawarrow(spot, door_sp::get_door_angles(), undefined, 3);

    if(isDefined(self.max_yaw_left)) {
      thread draw_max_yaw(1);
    }

    if(isDefined(self.max_yaw_right)) {
      thread draw_max_yaw(0);
    }

    if(isDefined(self.traces)) {
      print3d(base + (0, 0, count * space * -1), "<dev string:x335>" + self.traces, (1, 1, 1), 1, 0.15);
    }

    if(isDefined(self.doorbottomcenter)) {
      line(self.doorbottomcenter + (5, 0, 0), self.doorbottomcenter - (5, 0, 0));
      line(self.doorbottomcenter + (0, 5, 0), self.doorbottomcenter - (0, 5, 0));
      line(self.doorbottomcenter + (0, 0, 5), self.doorbottomcenter - (0, 0, 5));
    }

    wait 0.015;
  }
}

function unlock_volume_logic() {
  door = self.door;

  if(isDefined(door.doubledoors)) {
    door = door.doubledoors[0];
  }

  if(!door.locked) {
    return;
  }

  self.active = 1;
  door endon("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
  door endon("\x85i_o8\xca\xdc\x952");
  door endon("\xb4\x8b~\xec\x8b\xfb");
  door endon("#\xacG\xb7\xcd\vt\xac");
  door endon("\x90L\x0e\xde\x89Z\xdcN\xab\xaf\xbb\x1a\xbc;^\xc8\xd8S\xfa");

  while(true) {
    while(!level.player istouching(self) && (!(isDefined(door.doubledoorother) && isDefined(door.doubledoorother.unlock_volume)) || !level.player istouching(door.doubledoorother.unlock_volume))) {
      waitframe();
    }

    door door_sp::unlock_door();

    while(level.player istouching(self) || isDefined(door.doubledoorother) && isDefined(door.doubledoorother.unlock_volume) && level.player istouching(door.doubledoorother.unlock_volume)) {
      waitframe();
    }

    door door_sp::lock_door();
  }
}

function refresh_open_struct() {
  self.refresh = 1;
}

function door_open_think() {
  self notify("\xbe\x05\x92\xf0\x10\xe9(\xab\"\xd8\x82,\xf4\x17A");
  self endon("\xbe\x05\x92\xf0\x10\xe9(\xab\"\xd8\x82,\xf4\x17A");
  self endon("\xa6-\xb7\xe1\xc4o\b(\x80\x0f");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("M\xa2\xf9\xb2\xbc\xf5\xcc@\x817\x1c\xb4\x80^<\xb5c");
  self endon("\x85i_o8\xca\xdc\x952");

  if(!isDefined(self.script_spawn_open_yaw)) {
    thread door_sp::bash_monitor();
    waittill_first_interact_or_bash();
  } else {
    thread door_sp::door_ajar();
  }

  if(!self.bashed_full) {
    thread monitor_door_push();
    waittill_second_interact_or_bash();
  }

  door_sp::remove_open_ability();
}

function get_max_yaw(left) {
  var_ab561629327c1d0 = 70;
  major_increment = 30;
  minor_increment = 5;

  if(left) {
    if(isDefined(self.script_max_left_angle)) {
      self.max_yaw_left = self.script_max_left_angle;

      if(self.max_yaw_left < 0) {
        assertmsg("<dev string:x356>" + self.origin + "<dev string:x362>" + self.script_max_left_angle + "<dev string:x38d>");
      }

      return;
    }
  } else if(isDefined(self.script_max_right_angle)) {
    self.max_yaw_right = self.script_max_right_angle;

    if(self.max_yaw_right < 0) {
      assertmsg("<dev string:x356>" + self.origin + "<dev string:x3a0>" + self.script_max_right_angle + "<dev string:x38d>");
    }

    return;
  }

  var_9104d3789486947f = get_max_yaw_internal(var_ab561629327c1d0, major_increment, left);
  var_9104d3789486947f += minor_increment;
  var_967790dbeb3ca873 = get_max_yaw_internal(var_9104d3789486947f, minor_increment, left);

  if(left) {
    self.max_yaw_left = var_967790dbeb3ca873;
    return;
  }

  self.max_yaw_right = var_967790dbeb3ca873;
}

function get_max_yaw_internal(test_yaw, increment, left) {
  failed_once = 0;
  finished = 0;
  contents = trace::create_default_contents(1);

  while(!finished) {
    if(test_yaw > 179) {
      return 179;
    }

    if(left) {
      safe_yaw = yaw_collision_check(self.true_start_angles[1] + test_yaw, left, contents);
    } else {
      safe_yaw = yaw_collision_check(self.true_start_angles[1] - test_yaw, left, contents);
    }

    if(safe_yaw) {
      if(failed_once) {
        finish = 1;
      }

      test_yaw += increment;
      continue;
    }

    if(!failed_once) {
      failed_once = 1;
    }

    test_yaw -= increment;
    finished = 1;
  }

  return test_yaw;
}

function yaw_collision_check(yaw, left, content_override) {
  trace_angles = (0, yaw, 0);

  if(left) {
    basestart = self.pivots["L&\"y\xa0|\xb1\x9dI"].origin + (0, 0, 2);
  } else {
    basestart = self.pivots["Nf\xf9\xc9VsI\x92VL"].origin + (0, 0, 2);
  }

  start = basestart + anglesToForward(trace_angles) * self.length * 0.2;
  end = start + anglestoright(trace_angles) * 100;
  trace = trace::capsule_trace(start, end, 6, 80, trace_angles, [self, self.clip], content_override, 0);
  dist = distance2d(start, trace["\xc1\xbd\xdci\xe8i{7"]);

  if(getdvarint(@ "hash_6985e82f27803483")) {
    if(!isDefined(self.traces)) {
      self.traces = 1;
    } else {
      self.traces++;
    }

    color = (1, 1, 1);

    if(dist > 50) {
      color = (0, 1, 0);
    } else if(dist <= 3) {
      color = (1, 0, 0);
    } else if(dist < 50) {
      color = (1, 1, 0);
    }

    var_ce74a947832d4e57 = basestart + anglesToForward(trace_angles) * self.length;
    var_50d1624e1f2df96 = start + anglestoright(trace_angles) * dist;
    line(basestart, var_ce74a947832d4e57, (1, 1, 1), 1, 0, 100);
    line(start, var_50d1624e1f2df96, color, 0.5, 0, 100);
  }

  if(dist > 3) {
    start = basestart + anglesToForward(trace_angles) * self.length * 0.9;
    trace = trace::capsule_trace(start, end, 6, 80, trace_angles, [self, self.clip], content_override, 0);
    dist = distance2d(start, trace["\xc1\xbd\xdci\xe8i{7"]);

    if(getdvarint(@ "hash_6985e82f27803483")) {
      self.traces++;
      color = (1, 1, 1);

      if(dist > 50) {
        color = (0, 1, 0);
      } else if(dist <= 5) {
        color = (1, 0, 0);
      } else if(dist < 50) {
        color = (1, 1, 0);
      }

      var_50d1624e1f2df96 = start + anglestoright(trace_angles) * dist;
      line(start, var_50d1624e1f2df96, color, 0.5, 0, 100);
    }

    return (dist > 5);
  }

  return false;
}

function draw_max_yaw(left) {
  yaw = undefined;

  if(left) {
    yaw = self.max_yaw_left;
    start = self.pivots["<dev string:x3cc>"].origin;
  } else {
    yaw = self.max_yaw_right * -1;
    start = self.pivots["<dev string:x3d9>"].origin;
  }

  trace_angles = self.true_start_angles + (0, yaw, 0);
  line_end = start + anglesToForward(trace_angles) * self.length;
  line(start, line_end, (1, 0, 0), 1, 0, 3);
}

function try_door_hint() {
  self endon("\xc4\x87W\x9a=\x9bGM\xb0\xd9");

  if(istrue(self.nohint)) {
    return;
  }

  if(!utility::flag("\xd7]T\x18\xa0\x10\"\v\f\b\x10\xca\xd6")) {
    thread display_hint_dist_check();

    while(level.player useButtonPressed() || isDefined(level.player getplayeruseentity()) || isDefined(self.hint_delay_until) && gettime() < self.hint_delay_until) {
      waitframe();
    }

    wait 0.25;

    if(!utility::flag("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93") && !utility::flag("X\xca\xe6\xa6\xfdQ\xc7\x16v\x16E\xfd\x05\x86\xeaA\xf3J\x86\xb0O") && !istrue(self.bashed)) {
      utility::flag_set("\xd7]T\x18\xa0\x10\"\v\f\b\x10\xca\xd6");
      thread utility_sp::display_hint("\xa5C\x9euY+\xf0\x8ew\x94\r", undefined, undefined, self, "\xb4\x8b~\xec\x8b\xfb");
    }
  }
}

function first_hint_func() {
  if(utility::flag("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93")) {
    return true;
  }

  if(utility::flag("X\xca\xe6\xa6\xfdQ\xc7\x16v\x16E\xfd\x05\x86\xeaA\xf3J\x86\xb0O")) {
    return true;
  }

  if(isDefined(level.player getplayeruseentity())) {
    return true;
  }

  return false;
}

function display_hint_dist_check() {
  self notify("N (\x12/~\xbd\xfaw\x0f\x81w}\xc0\xf8\xa1W\xc9\"t\x8e\xe6\x97");
  self endon("N (\x12/~\xbd\xfaw\x0f\x81w}\xc0\xf8\xa1W\xc9\"t\x8e\xe6\x97");
  self endon("\x1e\xfd\xd1\xa2\a");
  level.player endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xa6-\xb7\xe1\xc4o\b(\x80\x0f");
  utility::flag_clear("X\xca\xe6\xa6\xfdQ\xc7\x16v\x16E\xfd\x05\x86\xeaA\xf3J\x86\xb0O");

  while(distancesquared(self.origin, level.player.origin) < squared(165)) {
    wait 0.1;
  }

  utility::flag_set("X\xca\xe6\xa6\xfdQ\xc7\x16v\x16E\xfd\x05\x86\xeaA\xf3J\x86\xb0O");
}

function waittill_first_interact_or_bash() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\xb4\x8b~\xec\x8b\xfb");
  self endon("\xb7\x0e\xac\xcd\xd7\xc6{\xb5\xe06\xac:\xac\x1b^");
  self waittill("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
  thread door_sp::door_ajar();
}

function waittill_second_interact_or_bash() {
  self endon("\xb4\x8b~\xec\x8b\xfb");
  self waittill("\xb7\x0e\xac\xcd\xd7\xc6{\xb5\xe06\xac:\xac\x1b^");

  if(door_sp::function_e0494ec0b55af688()) {
    thread player_door_gesture(1);
    wait 0.1;
  }

  level.player playRumbleOnEntity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
  earthquake(0.13, 0.2, level.player.origin, 200);
  thread door_sp::door_open_completely();
}

function can_pivot_change() {
  if(isDefined(self.pivot_ent) && isDefined(self.current_pivot_struct) && self.pivot_ent.angles != self.current_pivot_struct.angles) {
    return false;
  }

  return true;
}

function set_pivot_point(left) {
  if(!can_pivot_change()) {
    if(issubstr(self.current_pivot_struct.script_noteworthy, "\xd8(\xf2e\x15\xed\x8d6a\xe8")) {
      self.hinge_side = "L&\"y\xa0|\xb1\x9dI";
      return;
    }

    self.hinge_side = "Nf\xf9\xc9VsI\x92VL";
    return;
  }

  if(left) {
    new_pivot = "L&\"y\xa0|\xb1\x9dI";
  } else {
    new_pivot = "Nf\xf9\xc9VsI\x92VL";
  }

  self.hinge_side = new_pivot;

  if(!isDefined(self.current_pivot_struct) || self.current_pivot_struct != self.pivots[new_pivot]) {
    println("<dev string:x3e7>" + new_pivot);
    self.current_pivot_struct = self.pivots[new_pivot];

    if(self islinked()) {
      self unlink();
    }

    if(!isDefined(self.pivot_ent)) {
      self.pivot_ent = utility::spawn_script_origin(self.current_pivot_struct.origin, self.true_start_angles);
    } else {
      self.pivot_ent dontinterpolate();
      self.pivot_ent.origin = self.current_pivot_struct.origin;
    }

    wait 0.05;
    self linkTo(self.pivot_ent);
  }
}

function monitor_open_completely() {
  self endon("\xb7\x0e\xac\xcd\xd7\xc6{\xb5\xe06\xac:\xac\x1b^");
  self endon("\x8b\r\xcf\x06Q\xc7[\x98Z\xbc-\x02\x88~TI\xbdp\x8d\x11QH\x1bE\x0f\xa1\x9a\xb3\xc4H\x13");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\xa6-\xb7\xe1\xc4o\b(\x80\x0f");

  while(level.player useButtonPressed()) {
    wait 0.05;
  }

  while(true) {
    if(!istrue(self.bashed) && door_sp::bash_door_isplayerclose() && level.player useButtonPressed() && !isDefined(level.player getplayeruseentity()) && pushents_clear()) {
      if(!utility::flag("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93")) {
        utility::flag_set("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93");
      }

      self notify("\xb7\x0e\xac\xcd\xd7\xc6{\xb5\xe06\xac:\xac\x1b^");
    }

    wait 0.05;
  }
}

function pushents_clear() {
  if(isDefined(self.pushents)) {
    pushents = self.pushents;
    pushents = sortbydistance(pushents, self.origin);

    if(distancesquared(self.origin, pushents[0].origin) < 6400) {
      origin = self.origin;
      angles = vectortoangles(self.forward);
      right = anglestoright(angles);
      normal = vectorNormalize(pushents[0].origin - origin);
      dot = vectordot(right, normal);
      self.bashblocked = 1;

      if(dot > 0) {
        return false;
      }
    }
  }

  return true;
}

function setup_open_struct(struct) {
  if(!isDefined(struct.radius)) {
    struct.radius = 2.5;
  }

  if(!isDefined(self.script_spawn_open_yaw)) {
    struct thread open_struct_logic();
  }
}

function open_struct_logic(display_locked) {
  assert(isstruct(self), "<dev string:x400>");
  self.door notify("\xdcK\xd4\x98\xfe\x0e\xfe/\xecL\x0f.\xebL\xf7\xed>");
  self.door endon("\xdcK\xd4\x98\xfe\x0e\xfe/\xecL\x0f.\xebL\xf7\xed>");
  self.door endon("M\xa2\xf9\xb2\xbc\xf5\xcc@\x817\x1c\xb4\x80^<\xb5c");
  self.door endon("\xbe,\x9f\x94_\x87k\xa7u\xd8\x1e\x13\x85\x9d\xaf:\xba*");

  if((istrue(display_locked) || isDefined(self.door.lockpick)) && istrue(self.door.locked) && !istrue(self.door.nohint)) {
    if(isDefined(self.door.lockpick)) {
      self.door.lockpick.hint_string = undefined;
      self.door.lockpick.hint_icon = undefined;
    }

    door_sp::remove_open_interact_hint();
    self.no_open_interact = undefined;
    door_sp::create_open_interact_hint(&"script/door_hint_locked");
    refresh_open_struct();

    if(function_c28f344e9195c34c(self.door)) {
      childthread function_8c9cae682ca4376();
    } else if(isDefined(self.door.lockpick) && isDefined(self.door.lockpick.var_db9985bc4a3ecd4)) {
      self[[self.door.lockpick.var_db9985bc4a3ecd4]]();
    }
  } else {
    door_sp::create_open_interact_hint();
  }

  self.door thread door_open_think();

  if(isDefined(self.cursor_hint_ent)) {
    self.cursor_hint_ent waittill("\x91`\xb1\xe7T\x97>");
  } else {
    self waittill("\x91`\xb1\xe7T\x97>");
  }

  self notify("s\xe8{8}\xd8\xeaN\xb9\xbd9\xfa\xd0K\xe6G}\x1d\x86\x9c\x95\x16\x19");
  self.door notify("\x91`\xb1\xe7T\x97>");
  level.player notify("}~\xfbt[5\x01\xba&\xe0|\xbe", self.door);

  if(door_sp::function_e0494ec0b55af688()) {
    thread player_door_gesture();
  }

  if(function_e0e17b36200bbd2(self.door)) {
    if(!isDefined(self.door.lockpick)) {
      if(door_sp::function_e0494ec0b55af688()) {
        wait 0.1;
      }

      if(isDefined(self.door.script_sound_type) && self.door.script_sound_type == "\xfe\x86\x8ee\x8b_\x84\x19\xac\x98\x83") {
        thread utility::play_sound_in_space("76'\x1c\xd1\xaf\x91o\xed\xc9}\xb5\xact\xc2\x1b\xeb\xed\xc1\xb2\xdc\xd7\xd8{\x8d\xd6\x95\x91", self.cursor_hint_ent.origin);
      } else {
        thread utility::play_sound_in_space("7\xd8\xc9\x1c\xd1\xf5do\xde'\xbew\xde{\x19}\xdb\xe0+\xcd\xaf6o6k\xb2F", self.cursor_hint_ent.origin);
      }

      level.player playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
      earthquake(0.17, 0.2, level.player.origin, 200);
      self.door notify("!\x90l\x94\xcfU");
    }

    thread open_struct_logic(1);
    self.door thread cursor_hint_thread();
    return;
  }

  door_sp::remove_open_interact_hint();

  if(door_sp::function_e0494ec0b55af688()) {
    wait 0.1;
  } else if(isDefined(self.door.destructible)) {
    self.door setscriptablepartstate("\xc1\xf0\x81\x9b", "\x9a\xe8\xa3\xfd\x1fP\xe7>,\t\x99");
  }

  self.door notify("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");

  if(!utility::flag("p\xf9q\xacW\x06C\xa6\xc8m$\xb9\"\xc6\xc6M\x87\xfd\xba")) {
    utility::flag_set("p\xf9q\xacW\x06C\xa6\xc8m$\xb9\"\xc6\xc6M\x87\xfd\xba");
  }
}

function function_8c9cae682ca4376() {
  self endon("\x91`\xb1\xe7T\x97>");
  self.cursor_hint_ent endon("\x91`\xb1\xe7T\x97>");
  previoushintstring = undefined;

  while(isDefined(self.cursor_hint_ent)) {
    hintstring = undefined;

    if(isDefined(self.door.lockpick) && isDefined(self.door.lockpick.var_db9985bc4a3ecd4)) {
      self[[self.door.lockpick.var_db9985bc4a3ecd4]]();
    } else {
      if(function_e0e17b36200bbd2(self.door)) {
        hintstring = &"script/door_hint_locked";
      } else if(self.door door_bashable_by_player(1)) {
        hintstring = &"script/door_hint_use";
      } else {
        hintstring = &"script/door_hint_use_no_bash";
      }

      if(hintstring != previoushintstring) {
        self.cursor_hint_ent setHintString(hintstring);
      }

      previoushintstring = hintstring;
    }

    waitframe();
  }
}

function function_c28f344e9195c34c(door) {
  return isDefined(door.script_side);
}

function function_e0e17b36200bbd2(door) {
  if(!door.locked) {
    return false;
  }

  if(!isDefined(door.script_side)) {
    return true;
  }

  var_49c4c324d8d75f82 = door function_171b6944b838fab4()[0];

  if(door.script_side == "o0\xee\xc1\x8c" && var_49c4c324d8d75f82) {
    return true;
  }

  if(door.script_side == "=\xff0b" && !var_49c4c324d8d75f82) {
    return true;
  }

  return false;
}

function should_do_gesture() {
  return !isnullweapon(level.player getcurrentweapon());
}

function player_door_gesture(pushhard) {
  self notify("\x92>\xa0\x19q9O\x95mc\xfa\xe7\x13\x91lF\xafe$");
  self endon("\x92>\xa0\x19q9O\x95mc\xfa\xe7\x13\x91lF\xafe$");

  if(isDefined(pushhard) && pushhard) {
    gesture = level.interactive_doors.gesture_door_hard;
  } else {
    gesture = level.interactive_doors.gesture_door;
  }

  thread pushplayertodoor();
  target = utility::spawn_tag_origin();
  target.origin = self.origin;

  if([[level.interactive_doors.fnshoulddogesture]]()) {
    level.player playgestureviewmodel(gesture, target);
    wait level.player getgestureanimlength(gesture);
  }

  target delete();
}

function pushplayertodoor() {
  decay = 0.04;
  growth = 0.2;
  timefactor = 0;
  level.player thread utility_sp::blend_movespeedscale(0.1, 0.3, "02\xf9LlkZ@");

  while(timefactor < 0.99) {
    if(!isDefined(self)) {
      break;
    }

    pushlogic(timefactor);
    timefactor += growth;
    wait 0.05;
  }

  timefactor = 1;
  level.player thread utility_sp::blend_movespeedscale(1, 0.7, "02\xf9LlkZ@");

  while(timefactor > 0.01) {
    if(!isDefined(self)) {
      break;
    }

    pushlogic(timefactor);
    timefactor -= decay;
    wait 0.05;
  }

  level.player pushplayervector((0, 0, 0));
}

function pushlogic(timefactor) {
  vec = self.origin - level.player getEye();
  dist = length(vec);
  distfact = math::normalize_value(20, 50, dist);
  distforce = math::factor_value(5, 11, distfact);
  dir = vectorNormalize(vec);
  force = timefactor * distforce;
  level.player pushplayervector(dir * force);
}

function player_window_gesture(duration) {
  self notify("W\xa6\x7f1\xa3\xe3\x9dg\xfbko/\xc8\x99\x87\xcd+\xae\x7f\xb4\xfa");
  self endon("W\xa6\x7f1\xa3\xe3\x9dg\xfbko/\xc8\x99\x87\xcd+\xae\x7f\xb4\xfa");
  gesture = level.interactive_doors.gesture_window;

  if([[level.interactive_doors.fnshoulddogesture]]()) {
    if(!isDefined(duration)) {
      duration = 1;
    }

    level.player playgestureviewmodel(gesture);
    wait duration;
  }

  level.player stopgestureviewmodel(gesture, 2);
}

function door_bashable_by_player(forcursorhint) {
  if(istrue(self.no_bash) || istrue(self.was_opened_halfway) || istrue(self.open_completely) || istrue(self.bashed)) {
    self.debug_activity = "<dev string:x425>";

    return false;
  }

  if(istrue(forcursorhint)) {
    return true;
  }

  if(isnullweapon(level.player getcurrentweapon())) {
    return false;
  }

  if(function_281c4fad411f1c13()) {
    return true;
  }

  return false;
}

function function_281c4fad411f1c13() {
  if(utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_center(), 0.82)) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_center(), "<dev string:x458>", (0, 1, 0), 1, 0.1, 1, 1);
    }

    return true;
  } else {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_center(), "<dev string:x46c>", (1, 0, 0), 1, 0.1, 1, 1);
    }
  }

  if(utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_handle(), 0.82)) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_handle(), "<dev string:x458>", (0, 1, 0), 1, 0.1, 1, 1);
    }

    return true;
  } else {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_handle(), "<dev string:x46c>", (1, 0, 0), 1, 0.1, 1, 1);
    }
  }

  if(utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_origin(), 0.82)) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_origin(), "<dev string:x458>", (0, 1, 0), 1, 0.1, 1, 1);
    }

    return true;
  } else {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_origin(), "<dev string:x46c>", (1, 0, 0), 1, 0.1, 1, 1);
    }
  }

  return false;
}

function should_bash_open() {
  thread bash_debug(1);

  if(door_bashable_by_player()) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      printtoscreen2d(900, 700, "<dev string:x480>", (0, 1, 0), 2);
    }

    if(istrue(self.isbashing) || isDefined(self.doubledoorother) && istrue(self.doubledoorother.isbashing)) {
      return false;
    }

    if(isDefined(level.player.var_91b19092698a5e84)) {
      thread bash_debug(2000);
      return true;
    }

    if(!level.player issprinting()) {
      return false;
    }

    if(isvector(self.cursorhintdir)) {
      movedir = vectorNormalize(level.player getvelocity());

      if(vectordot(movedir, self.cursorhintdir) > -0.7) {
        return false;
      }
    }

    if(door_sp::bash_requires_use()) {
      if(!level.player useButtonPressed()) {
        return false;
      }
    }

    playerspeed = length(level.player getvelocity());

    if(playerspeed < 50) {
      return false;
    }

    vec = vectorNormalize(level.player getEye() - get_door_center());
    doordot = vectordot(vec, anglesToForward(door_sp::get_door_angles()));

    if(abs(doordot) > 0.4) {
      return false;
    }

    self.bashscale = math::lerp_fraction(50, 195, playerspeed);
    thread bash_debug(2000);
    return true;
  }

  return false;
}

function bash_debug(duration) {
  if(getdvarint(@ "hash_6985e82f27803483")) {
    line(level.player.origin, get_door_center(), (1, 1, 1), 1, 0, duration);
    line(level.player.origin, self.doorbottomcenter, (1, 1, 1), 1, 0, duration);
    line(level.player.origin, level.player.origin + anglesToForward(level.player.angles) * 32, (1, 0.5, 0), 1, 0, duration);
    normal = vectorNormalize(self.doorbottomcenter - level.player.origin);
    forward = anglesToForward(level.player.angles);
    dot = vectordot(forward, normal);
    color = dot >= 0.82 ? (0, 1, 0) : (1, 0, 0);
    print3d(get_door_center(), "<dev string:x491>" + dot, color, 1, 0.1, duration, 1);
    vec = vectorNormalize(level.player getEye() - get_door_center());
    dot = vectordot(vec, anglesToForward(door_sp::get_door_angles()));
    color = abs(dot) <= 0.4 ? (0, 1, 0) : (1, 0, 0);
    print3d(get_door_center() + (0, 0, -1.5), "<dev string:x4a1>" + dot, color, 1, 0.1, duration, 1);
  }
}

function stealth_broadcast(event, originator, radius) {
  if(!isDefined(radius) && broadcaststealthevent(originator, event)) {
    return;
  }

  dist = radius ?? 500;
  guys = utility_sp::get_all_closest_living(self.origin, getaiarray("?\xb1\xc0\x9a"), dist, 0);

  if(!guys.size) {
    return;
  }

  foreach(g in guys) {
    if(isDefined(g.stealth)) {
      g aieventlistenerevent(event, level.player, self.origin);
    }
  }
}

function combat_getinfoinradius(radius) {
  dist = radius ?? 500;
  guys = utility_sp::get_all_closest_living(self.origin, getaiarray("?\xb1\xc0\x9a"), dist, 0);

  if(!guys.size) {
    return;
  }

  foreach(g in guys) {
    g getenemyinfo(level.player);
  }
}

function get_bash_yaw(scale) {
  if(self.open_left) {
    yaw_left = self.max_yaw_left;

    if(scale < 1) {
      yaw_left = math::factor_value(55, 170, scale);
      yaw_left = min(yaw_left, self.max_yaw_left);
    }

    bash_yaw = self.true_start_angles[1] + yaw_left;
  } else {
    yaw_right = self.max_yaw_right;

    if(scale < 1) {
      yaw_right = math::factor_value(55, 170, scale);
      yaw_right = min(yaw_right, self.max_yaw_right);
    }

    bash_yaw = self.true_start_angles[1] - yaw_right;
  }

  if(isDefined(self.pushents) && self.pushents.size > 0) {
    pushents = self.pushents;
    pushents = sortbydistance(pushents, self.origin);

    if(distancesquared(self.origin, pushents[0].origin) < 6400) {
      origin = self.origin;
      angles = vectortoangles(self.forward);
      right = anglestoright(angles);
      normal = vectorNormalize(pushents[0].origin - origin);
      dot = vectordot(right, normal);
      self.bashblocked = 1;

      if(dot > 0) {
        bash_yaw = self.true_start_angles[1] - 4;
      } else {
        bash_yaw = self.true_start_angles[1] + 4;
      }
    }
  }

  return bash_yaw;
}

function bashed_locked_door(velocity) {
  level.player endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.isbashing)) {
    return;
  }

  self.isbashing = 1;
  thread bashed_locked_door_sfx();
  self notify("\x91`\xb1\xe7T\x97>");
  self notify("0U~\x87:\xaaai!L`U\x87\xd8\xdc\x93r\xc7\xd8\xf7");
  self notify("!\x90l\x94\xcfU");
  level.player viewkick(10, get_door_center(), 0);
  earthquake(1, 0.3, level.player.origin, 75);
  level.player playRumbleOnEntity("\x1b|\xcd4l\x88\xb8\xc5");

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    self.open_struct thread open_struct_logic(1);
    thread cursor_hint_thread();
  }

  while(level.player ismeleeing() || level.player issprinting()) {
    waitframe();
  }

  self.isbashing = undefined;
}

function bashed_locked_door_sfx() {
  if(!isDefined(self.bashedsfx)) {
    self.bashedsfx = 1;
    var_f40ec9f42c68168f = get_door_audio_material();
    alias = "\xb5Z)\x9bxV\xf2\xdc\xb05\\" + var_f40ec9f42c68168f + "\xb3\xaex4\x96";
    org = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin + (0, 0, 42));

    if(soundexists(alias)) {
      org playSound(alias, "\xdc\xf6\xba\xdcFF\xdb\xe6e");
    }

    if(randomint(100) < 40) {
      level.player playSound("\x1bio\x8a3\xc2\"\xdc=\x12\r\x99TO");
    }

    org waittill("\xdc\xf6\xba\xdcFF\xdb\xe6e");
    org delete();
    self.bashedsfx = undefined;
  }
}

function door_bash_presentation() {
  screenshake(level.player.origin, 16, 0, 0, 0.45);
  level.player playRumbleOnEntity("R\xd3\xafp\xb0w(\x97]l4rp\x9f");
  earthquake(0.6, 0.75, level.player.origin, 200);
}

function close_prompt(delay) {
  self notify("\xb4\x02\xdf\xdd$g\x06|f\xc3\xa7\xfe");
  self endon("\xb4\x02\xdf\xdd$g\x06|f\xc3\xa7\xfe");
  self endon("\xa6-\xb7\xe1\xc4o\b(\x80\x0f");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(!istrue(level.interactive_doors.close_prompt)) {
    return;
  }

  thread door_sp::remove_open_prompts();
  utility::flag_wait("\x90mSl@\x92pP\xfa(\x8f8\xcd\x05\x89w\x04\xa2\r\x06`48");

  if(isDefined(delay)) {
    wait delay;
  }

  while(true) {
    self.open_struct.no_open_interact = undefined;
    self.open_struct childthread door_sp::create_open_interact_hint(&"script/door_hint_close");
    thread cursor_hint_thread();
    waitframe();

    if(!isDefined(self.open_struct.cursor_hint_ent)) {
      continue;
    }

    self.open_struct.cursor_hint_ent waittill("\x91`\xb1\xe7T\x97>");

    if(!close_check()) {
      var_5fe26f56ddadfae8 = 3;
      level.player utility::callsharedfunc(#"hint", #"add_simple", "\xd6\xaeN+\xa5@\xbe\f\fr\xcf$\xbfm\n\xb6\x9c?Q@", &"script/door_hint_obstructed", var_5fe26f56ddadfae8);
      wait 1;
      continue;
    }

    self notify("\x8b\r\xcf\x06Q\xc7[\x98Z\xbc-\x02\x88~TI\xbdp\x8d\x11QH\x1bE\x0f\xa1\x9a\xb3\xc4H\x13");

    if(isDefined(self.doubledoorother)) {
      self.doubledoorother notify("\x8b\r\xcf\x06Q\xc7[\x98Z\xbc-\x02\x88~TI\xbdp\x8d\x11QH\x1bE\x0f\xa1\x9a\xb3\xc4H\x13");
    }

    if(door_sp::function_e0494ec0b55af688()) {
      thread player_door_gesture();
    }

    if(isDefined(self.doubledoorother)) {
      self.doubledoorother thread door_sp::remove_open_prompts();
      self.doubledoorother thread door_sp::door_close();
    }

    door_sp::door_close();
    waitframe();

    if(isDefined(self.doubledoorother)) {
      self.doubledoorother thread door_sp::reset_door();
    }

    thread door_sp::reset_door();
  }
}

function close_check() {
  if(!istrue(level.interactive_doors.close_check)) {
    return true;
  }

  contents = trace::create_character_contents();
  yaw_start = door_sp::get_door_angles()[1];
  yaw_end = self.true_start_angles[1];
  trace_count = ceil(abs(yaw_end - yaw_start) / 15);
  left = self.current_pivot_struct == self.pivots["L&\"y\xa0|\xb1\x9dI"];

  for(trace = 1; trace < trace_count; trace++) {
    angle = yaw_start + (yaw_end - yaw_start) * trace / trace_count;

    if(!yaw_collision_check(angle, left, contents)) {
      return false;
    }
  }

  return true;
}

function monitor_door_push(delay) {
  self notify("\xda\xdb\xe6Z\xa3\xdb\xe4}\x8c\xdeo9}\xe0]7\r");
  self endon("\xda\xdb\xe6Z\xa3\xdb\xe4}\x8c\xdeo9}\xe0]7\r");
  self endon("\xa6-\xb7\xe1\xc4o\b(\x80\x0f");
  self endon("\xcdx\x9e\x90G6\xc8wR\x80;\r\xed\xd8");
  self endon("]\x87\xd9\xb9\xc7\x1f}\x1dX\x84\x81");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(!isDefined(delay)) {
    delay = level.doorsys.var_bdb2c2ff700fba5;
  }

  if(self.bashed) {
    wait self.bashtime + 0.05;
    self.pivot_ent rotateTo(self.pivot_ent.angles, 0.05);
  } else if(delay > 0) {
    wait delay;
  }

  thread door_ease_in_open_input();

  while(true) {
    if(door_sp::interact_door_ispushentclose()) {
      push_door();
    } else if(istrue(self.isplayingpushsound)) {
      self.isplayingpushsound = 0;
      self notify("\xa6\xed\nm\x93\x999x\x87\xe9[{\x1b\x9e\x13");
    }

    waitframe();
  }
}

function door_ease_in_open_input() {
  maxtime = level.doorsys.pusheasetime;
  time = maxtime;
  self.masterdoorratescale = 0;

  while(true) {
    if(!isDefined(self) || time <= 0) {
      break;
    }

    self.masterdoorratescale = 1 - time / maxtime;
    wait 0.05;
    time -= 0.05;
  }

  self.masterdoorratescale = 1;
}

function get_pushent() {
  if(isDefined(self.pushents)) {
    pushents = utility::array_add(self.pushents, level.player);
  } else {
    return level.player;
  }

  pushents = sortbydistance(pushents, self.origin);
  return pushents[0];
}

function function_45236aeb54aa9c7b() {
  if(isDefined(self.var_831432b007ee9fbb)) {
    return self.var_831432b007ee9fbb;
  }

  return 36;
}

function function_91f50279890cbda3() {
  if(isPlayer(self)) {
    return squared(function_45236aeb54aa9c7b());
  }

  return 1296;
}

function push_door() {
  if(self.bashed_full) {
    return;
  }

  if(istrue(self.bash_opening)) {
    return;
  }

  pushent = get_pushent();
  max_dist = pushent function_45236aeb54aa9c7b();
  min_dist = 0;
  max_push = level.doorsys.pushmaxrate;
  endpoint = interact_door_get_endpoint();
  dist = distance(pushent.origin, endpoint);
  percent = math::normalize_value(min_dist, max_dist, dist);
  amount = max_push * (1 - percent);
  amount *= self.masterdoorratescale;
  push_left = door_sp::should_open_left(self.pivot_ent.angles, pushent);

  if(abs(amount) < 0.001) {
    return;
  }

  self.open_struct door_sp::remove_open_interact_hint();
  currentyaw = door_sp::get_door_angles()[1];
  yaw_dir = push_left == 1 ? 1 : -1;
  target_yaw = currentyaw + amount * yaw_dir;
  self.var_5cd93ffbade05706 = undefined;

  if(push_left) {
    if(self.hinge_side == "L&\"y\xa0|\xb1\x9dI") {
      angle_diff = door_sp::angle_diff(target_yaw, self.true_start_angles[1]);

      if(angle_diff > self.max_yaw_left) {
        self.debug_activity = "wt\az\xdb:\xa1=^a\xd8YX}RR1[]xY\x19\xa1>\x7f\xa1" + self.max_yaw_left;
        self.open_completely = 1;
        thread door_sp::updatenavobstacle();
        self notify("\xcdx\x9e\x90G6\xc8wR\x80;\r\xed\xd8");
        return;
      }
    } else if(target_yaw > self.true_start_angles[1]) {
      self.debug_activity = "\xac^\xc6VEt\xf1i}9H\x1a\xa3\xab\xf6\xad\xffL\x05\x96\xad\xf0\xf5\xc2V\x88\x8c1\xd0\x84}";

      if(!function_fc42ed863354faa9()) {
        self.var_5cd93ffbade05706 = 1;

        if(!isDefined(self.doubledoorother) || istrue(self.doubledoorother.var_5cd93ffbade05706)) {
          thread door_sp::reset_door();

          if(isDefined(self.doubledoorother)) {
            self.doubledoorother thread door_sp::reset_door();
          }

          self notify("\xcdx\x9e\x90G6\xc8wR\x80;\r\xed\xd8");
          return;
        }

        if(isDefined(self.doubledoorother) && istrue(self.double_swing)) {
          self.hinge_side = "L&\"y\xa0|\xb1\x9dI";
        }

        return;
      }
    }
  } else if(self.hinge_side == "Nf\xf9\xc9VsI\x92VL") {
    angle_diff = abs(door_sp::angle_diff(target_yaw, self.true_start_angles[1]));

    if(angle_diff > self.max_yaw_right) {
      self.debug_activity = "\xc0U\x85\x16-\a\x0e\xc5\x04\xdb\xfa\xf6\x10\xce\xac\xbd]p\xb6\x13?\xfe5\x12`\xba$" + self.max_yaw_right;
      self.open_completely = 1;
      thread door_sp::updatenavobstacle();
      self notify("\xcdx\x9e\x90G6\xc8wR\x80;\r\xed\xd8");
      return;
    }
  } else if(target_yaw < self.true_start_angles[1]) {
    self.debug_activity = "\xd6\x81u\x10}\xad\x12\x80E\x12\xb5\xd9\xf1\x8f\x8c\x90\x8c\x11\x8f\xd9T\xc5\x90\xec\a\xf7\x85\x10\xf1\xc5";

    if(!function_fc42ed863354faa9()) {
      self.var_5cd93ffbade05706 = 1;

      if(!isDefined(self.doubledoorother) || istrue(self.doubledoorother.var_5cd93ffbade05706)) {
        thread door_sp::reset_door();

        if(isDefined(self.doubledoorother)) {
          self.doubledoorother thread door_sp::reset_door();
        }

        self notify("\xcdx\x9e\x90G6\xc8wR\x80;\r\xed\xd8");
        return;
      }

      if(isDefined(self.doubledoorother) && istrue(self.double_swing)) {
        self.hinge_side = "Nf\xf9\xc9VsI\x92VL";
      }

      return;
    }
  }

  if(amount > 0.4) {
    thread try_push_sound();

    if(!utility::flag("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93")) {
      utility::flag_set("k\xafu\x8bYq\xb4\x1c,\x98\rQga\xc7\xae\xf0\x97E\x93");
    }
  } else if(istrue(self.isplayingpushsound)) {
    self.isplayingpushsound = 0;
    self notify("\xa6\xed\nm\x93\x999x\x87\xe9[{\x1b\x9e\x13");
  }

  self.debug_activity = "<dev string:x4ba>" + target_yaw;

  self.pivot_ent.angles = (self.pivot_ent.angles[0], target_yaw, self.pivot_ent.angles[2]);
  self.forward = anglesToForward(self.pivot_ent.angles);

  if(door_is_half_open()) {
    if(!self.was_opened_halfway) {
      thread suspicious_door_stealth_check(1);
    }

    self.was_opened_halfway = 1;
    thread close_prompt(0.25);
  }

  updatenodelookpeek();
  curtime = gettime();

  if(abs(angleclamp180(self.pivot_ent.angles[1] - self.nav_lastupdateangle)) > 20 && curtime - self.nav_lastupdatetime > 250 || curtime - self.nav_lastupdatetime > 1500) {
    thread door_sp::updatenavobstacle(1);
  }
}

function function_fc42ed863354faa9() {
  toodamaged = 0;

  if(istrue(self.destructible) || self isscriptable()) {
    if(self getscriptablepartstate("\x87") != "\xf1\xba\x8f\x9d") {
      toodamaged = 1;
    }

    if(!toodamaged) {
      destroyedcount = 0;

      foreach(part in self.parts) {
        if(part.health <= 0) {
          destroyedcount++;
        }
      }

      if(destroyedcount / self.parts.size > 0.6) {
        toodamaged = 1;
      }
    }
  }

  return toodamaged;
}

function push_door_player_effects() {
  push_left = door_sp::should_open_left(self.pivot_ent.angles, level.player);
  hinges = self.pivot_ent;
  channel = "@\xc5\x86[\x9d#\xc9-" + self.doorid;

  if(!isDefined(self.dooroffset)) {
    self.dooroffset = (0, 0, 0);
    self.doorrot = (0, 0, 0);
    self.doorspeedscale = 1;
  }

  level.player notify(",[\x9fZ\xc9xQ\xeb'");
  level.player endon(",[\x9fZ\xc9xQ\xeb'");

  while(true) {
    pushspot = door_get_pushspot();
    var_bcd8ff2fbebc548b = (pushspot[0], pushspot[1], level.player.origin[2]) - level.player.origin;
    var_2c19e016b45faa0a = vectorNormalize(var_bcd8ff2fbebc548b);
    playerf = anglesToForward(level.player.angles);
    cross = vectorcross(playerf, var_2c19e016b45faa0a);
    dot = vectordot(playerf, var_2c19e016b45faa0a);
    var_2abe6005510cd65a = length(var_bcd8ff2fbebc548b);
    norminput = level.player getnormalizedmovement();
    norminput = (norminput[0], -1 * norminput[1], 0);
    localinput = rotatevector(norminput, level.player.angles);
    localinputdir = vectorNormalize(localinput);
    localinputdot = vectordot(localinputdir, var_2c19e016b45faa0a);
    localinputmag = clamp(length(localinput), 0, 1);

    if(cross[2] > 0) {
      lr_offset = (0, 4, 0);
      lr_rot = (0, -5, 0);
    } else {
      lr_offset = (0, -2, 0);
      lr_rot = (0, 2, 0);
    }

    if(dot > 0) {
      if(push_left) {
        fb_offset = (4, -1.5, 0);
        fb_rot = (-6, 5, 1.5);
      } else {
        fb_offset = (4, -1.5, 0);
        fb_rot = (-6, -3, -1.5);
      }
    } else {
      fb_offset = (-3, 0, 0);
      fb_rot = (0, 0, 0);
    }

    var_ec81f28b4f041e9d = math::normalize_value(0.6, 1, abs(dot));
    var_ec81f28b4f041e9d = math::normalized_float_smooth_in(var_ec81f28b4f041e9d);
    offset = math::factor_value(lr_offset, fb_offset, var_ec81f28b4f041e9d);
    rot = math::factor_value(lr_rot, fb_rot, var_ec81f28b4f041e9d);
    localinputdotfactor = math::normalize_value(0, 1, localinputdot);
    var_6e4faf62e4bc6f69 = math::normalize_value(0, 0.5, localinputmag);
    distfactor = 1 - math::normalize_value(20, 50, var_2abe6005510cd65a);

    if(level.player isfiring()) {
      firingfactor = 0.5;
    } else {
      firingfactor = 1;
    }

    var_984016473177c851 = 1;
    var_984016473177c851 *= localinputdotfactor;
    var_984016473177c851 *= var_6e4faf62e4bc6f69;
    var_984016473177c851 *= distfactor;
    var_984016473177c851 *= firingfactor;
    offset *= var_984016473177c851;
    rot *= var_984016473177c851;

    if(length(offset) > length(self.dooroffset)) {
      lerp = 0.312;
    } else {
      lerp = 0.234;
    }

    ads = 1 - level.player playerads();

    if(level.player adsButtonPressed()) {
      ads = math::normalize_value(0.8, 1, ads);
    }

    self.dooroffset = math::lerp(self.dooroffset, offset, lerp);
    self.doorrot = math::lerp(self.doorrot, rot, lerp);
    speedscalefactor = 1;
    localinputdotfactor = math::normalize_value(0, 1, localinputdot);
    var_6e4faf62e4bc6f69 = math::normalize_value(0, 0.01, localinputmag);
    distfactor = 1 - math::normalize_value(25, 70, var_2abe6005510cd65a);
    speedscalefactor *= localinputdotfactor;
    speedscalefactor *= var_6e4faf62e4bc6f69;
    speedscalefactor *= distfactor;
    speedscale = math::factor_value(1, 0.2, speedscalefactor);
    lerp = 0.3;
    self.doorspeedscale = math::lerp(self.doorspeedscale, speedscale, lerp);
    level.player utility_sp::blend_movespeedscale(self.doorspeedscale, 0, channel);

    if(length(self.dooroffset) < 0.001 && self.doorspeedscale > 0.99) {
      break;
    }

    if(!isDefined(self)) {
      break;
    }

    wait 0.05;
    offset = (0, 0, 0);
  }

  if(isDefined(self)) {
    self.dooroffset = (0, 0, 0);
    self.doorrot = (0, 0, 0);
    self.doorspeedscale = 1;
  }

  level.player utility_sp::blend_movespeedscale(1, 0, channel);
}

function door_get_pushspot() {
  var_398b63f591a8d0c5 = 12;
  playerspot = level.player.origin + anglesToForward(level.player.angles) * var_398b63f591a8d0c5;
  endpoint = interact_door_get_endpoint();
  startpoint = self.origin + self.forward * 5;
  pushspot = pointonsegmentnearesttopoint(startpoint, endpoint, playerspot);
  return pushspot;
}

function initlinkednodes() {
  bottomcenter = get_door_bottom_center();
  assert(isDefined(self.length));
  nodes = getnodesinradius(bottomcenter, self.length * 0.5 + 32, 0, 80, ":\xc9\x93\xe1?");
  assert(isDefined(nodes));

  if(nodes.size > 0) {
    self.linkednodes_hinge = [];
    self.linkednodes_knob = [];
    hingepos = undefined;

    if(isDefined(self.pivots["L&\"y\xa0|\xb1\x9dI"])) {
      hingepos = self.pivots["L&\"y\xa0|\xb1\x9dI"].origin;
    } else if(isDefined(self.pivots["Nf\xf9\xc9VsI\x92VL"])) {
      hingepos = self.pivots["Nf\xf9\xc9VsI\x92VL"].origin;
    } else {
      assertmsg("<dev string:x4c8>");
    }

    var_f643662f8d482909 = hingepos - bottomcenter;

    foreach(node in nodes) {
      var_cc9feca45f166198 = node.origin - bottomcenter;

      if(vectordot(var_cc9feca45f166198, var_f643662f8d482909) > 0) {
        self.linkednodes_hinge[self.linkednodes_hinge.size] = node;
        continue;
      }

      self.linkednodes_knob[self.linkednodes_knob.size] = node;
    }

    return;
  }

  self.linkednodes_hinge = undefined;
  self.linkednodes_knob = undefined;
}

function updatenodelookpeek() {
  dooryaw = angleclamp180(door_sp::get_door_angles()[1]);
  curangle = abs(angleclamp180(dooryaw - self.true_start_angles[1]));

  if(isDefined(self.linkednodes_hinge)) {
    doorforward = anglesToForward((0, dooryaw, 0));

    foreach(node in self.linkednodes_hinge) {
      if(curangle > 90) {
        node function_9760087487fc29f9(1);
      } else {
        node function_9760087487fc29f9(0);
      }

      if(curangle > 80) {
        nodeforward = anglesToForward(node.angles);

        if(vectordot(doorforward, nodeforward) < 0) {
          node disconnectnode();
        } else {
          node connectnode();
        }

        continue;
      }

      node connectnode();
    }
  }

  if(isDefined(self.linkednodes_knob)) {
    foreach(node in self.linkednodes_knob) {
      if(curangle > 45) {
        node function_9760087487fc29f9(1);
        continue;
      }

      node function_9760087487fc29f9(0);
    }
  }
}

function createinitialnavmodifier(linknameprefix) {
  if(!isDefined(self.navmodifier)) {
    linkname = linknameprefix + "\x97]\xb2\v\x15\xf3v\x16v\x01\xe3\xf8\xae";
    self.navmodifier = createnavmodifier(linkname, "F\x83\x1c\x9d\x19\xc5\xd7\x13;\xb3\x14n\x18\xf5\x13");
  }
}

function suspicious_door_stealth_check(issuspicious) {
  if(!isDefined(level.stealth)) {
    return;
  }

  if(!door_sp::function_1c2fb6a9190a2421() || !isDefined(level.stealth)) {
    return;
  }

  if(issuspicious) {
    level.stealth.suspicious_door.doors[level.stealth.suspicious_door.doors.size] = self;
    return;
  }

  level.stealth.suspicious_door.doors = arrayremove(level.stealth.suspicious_door.doors, self);
}

function try_push_sound() {
  if(!isDefined(self.isplayingpushsound)) {
    self.isplayingpushsound = 0;
  }

  if(!self.isplayingpushsound) {
    self.isplayingpushsound = 1;
    thread door_creak_sound();
  }
}

function door_creak_sound() {
  self notify("\xfc\x8f?(\x17\xb9\xb5A?\x858\xd2\xfdV\xf9\xe5?\b\xc8\x19:k\xdf\x9d");
  var_f40ec9f42c68168f = get_door_audio_material();
  self scalevolume(1);
  alias = "\xb5Z)\x9bxV\xf2\xdc\xb05\\" + var_f40ec9f42c68168f + "\xbcP\xdb:(\x8f\xff\x05\xc5";

  if(soundexists(alias)) {
    self playLoopSound(alias);
  }

  utility::waittill_any("\xa6\xed\nm\x93\x999x\x87\xe9[{\x1b\x9e\x13", "\xcdx\x9e\x90G6\xc8wR\x80;\r\xed\xd8");
  thread door_creak_sound_stop();
}

function door_creak_sound_stop() {
  self endon("\xfc\x8f?(\x17\xb9\xb5A?\x858\xd2\xfdV\xf9\xe5?\b\xc8\x19:k\xdf\x9d");
  self scalevolume(0, 0.5);
  wait 0.55;
  self stoploopsound();
}

function interact_door_get_endpoint() {
  return self.origin + self.forward * self.length;
}

function door_is_at_max_yaw(either) {
  angle_diff = door_sp::angle_diff(door_sp::get_door_angles()[1], self.true_start_angles[1]);

  if(isDefined(either)) {
    return (angle_diff >= self.max_yaw_left || angle_diff <= -1 * self.max_yaw_right);
  }

  if(self.open_left) {
    return (angle_diff >= self.max_yaw_left);
  }

  return angle_diff <= -1 * self.max_yaw_right;
}

function door_is_half_open() {
  angle_diff = door_sp::angle_diff(door_sp::get_door_angles()[1], self.true_start_angles[1]);

  if(self.open_left) {
    return (angle_diff >= self.max_yaw_left / 2);
  }

  return angle_diff <= self.max_yaw_right / -2;
}

function door_is_open_at_least(checkangle) {
  angle_diff = door_sp::angle_diff(door_sp::get_door_angles()[1], self.true_start_angles[1]);
  return abs(angle_diff) >= checkangle;
}

function get_door_center() {
  angles = door_sp::get_door_angles();
  self.doorcenter = self.origin + (0, 0, 55) + anglesToForward(angles) * self.length * 1.2 / 2;
  return self.doorcenter;
}

function get_door_bottom_center() {
  self.doorbottomcenter = get_door_center();
  self.doorbottomcenter = (self.doorbottomcenter[0], self.doorbottomcenter[1], self.origin[2]);
  return self.doorbottomcenter;
}

function get_door_bottom_handle() {
  angles = door_sp::get_door_angles();
  self.doorbottomhandle = self.origin + anglesToForward(angles) * self.length;
  return self.doorbottomhandle;
}

function get_door_bottom_origin() {
  self.doorbottomorigin = self.origin;
  return self.doorbottomorigin;
}

function isnavpointaccesiblefrombehinddoor(targetpos, door) {
  if(isDefined(door.doorbottomcenter)) {
    spot = door.doorbottomcenter;
  } else {
    spot = door.origin;
  }

  vec = vectorNormalize(spot - self.origin);
  var_c3cb01d7f39edca8 = spot + anglesToForward(vectortoangles(vec)) * 7;
  trace = navtrace(var_c3cb01d7f39edca8, targetpos, self, 1);

  color = (0, 1, 0);

  if(trace["<dev string:x503>"] < 0.88) {
    color = (1, 0, 0);
  }

  line(var_c3cb01d7f39edca8, trace["<dev string:x50f>"], color, 1, 0, 2);
  iprintln(trace["<dev string:x503>"]);

  return trace["\xda\x16\x81\aw}^i"] >= 0.9;
}

function print_navtrace(point) {
  self endon("<dev string:x51b>");

  while(true) {
    trace = navtrace(self.origin, point, self, 1);
    line(self.origin, point, (0, 1, 0), 1, 0, 1);
    line(self.origin, trace["<dev string:x50f>"], (1, 0, 0), 1, 0, 1);
    print3d(self.origin + (0, 0, 60), "<dev string:x524>" + trace["<dev string:x503>"], (1, 1, 1), 1, 1, 1);
    wait 0.05;
  }
}

function print3d_on_me(txt, duration) {
  self endon("\x1e\xfd\xd1\xa2\a");
  duration *= 1000;
  time = gettime();

  while(gettime() < time + duration) {
    print3d(self.origin + (0, 0, 60), txt, (1, 0.5, 0.8), 1, 0.5, 1);

    wait 0.05;
  }
}

function get_door_audio_material() {
  var_101820b29a758895 = self.script_sound_type;

  if(!isDefined(var_101820b29a758895)) {
    var_101820b29a758895 = "w\xed\xdb2}\xa1\xb2\xb0v\xcb";
    println("<dev string:x52e>");
  }

  return var_101820b29a758895;
}

function double_doors_init_auto() {
  foreach(door in level.interactive_doors.ents) {
    otherdoorlist = getentarrayinradius("r\x8e\x9d\x1c\t\x94\xc9\v;\xb5d}Hu;\x06", #script_noteworthy, door.origin, 150);
    doorfwd = anglesToForward(door.angles);

    foreach(otherdoor in otherdoorlist) {
      if(otherdoor == door) {
        continue;
      }

      if(isDefined(otherdoor.doubledoors)) {
        continue;
      }

      if(vectordot(anglesToForward(otherdoor.angles), doorfwd) < -0.99) {
        door_sp::double_doors_init(door, otherdoor);
        break;
      }
    }
  }
}

function double_doors_waittill_interact() {
  self notify("\x12@\xa3\xaaF\xd0\xb2\xea/o\xc0$Ub\xa2)\x7f}\xe1\xea.\xb9]J\xb1\xa0\x05\xe8,\xf0");
  self endon("\x12@\xa3\xaaF\xd0\xb2\xea/o\xc0$Ub\xa2)\x7f}\xe1\xea.\xb9]J\xb1\xa0\x05\xe8,\xf0");
  self endon("\xb4\x8b~\xec\x8b\xfb");
  self endon("\xb7\x0e\xac\xcd\xd7\xc6{\xb5\xe06\xac:\xac\x1b^");
  self waittill("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
  self.doubledoorother notify("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
}

function double_doors_waittill_bashed() {
  self notify("#{\xba&\xc6V\xbe\xc8\xde{r\xb9\xbe\xbb\x85\xd2\xa3GKc6\xafb\vn\r+F");
  self endon("#{\xba&\xc6V\xbe\xc8\xde{r\xb9\xbe\xbb\x85\xd2\xa3GKc6\xafb\vn\r+F");
  self endon("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
  self endon("\xb7\x0e\xac\xcd\xd7\xc6{\xb5\xe06\xac:\xac\x1b^");

  while(true) {
    self waittill("\xb7\xc9\x92\x8fZ|\x17\xb4\xa6\xbe\xdf0", opener);
    self.doubledoorother thread door_sp::door_bash_open(opener);

    if(!self.locked) {
      return;
    }
  }
}

function double_doors_waittill_open_completely() {
  self notify("{\a\x9a\x11\x9b\xf4C\"\xe5\xdf{DG8\x02\xc2G\x9a\xad#\x1a&<8U\x02h\xf5c\xbc(`\xa8\x1a\xb2\x91\x0f");
  self endon("{\a\x9a\x11\x9b\xf4C\"\xe5\xdf{DG8\x02\xc2G\x9a\xad#\x1a&<8U\x02h\xf5c\xbc(`\xa8\x1a\xb2\x91\x0f");
  self endon("\x0e\xfb&\x04w\xe6\xcal\x98\x1axU_L");
  self endon("\xb4\x8b~\xec\x8b\xfb");
  self.doubledoorother endon("\xb7\x0e\xac\xcd\xd7\xc6{\xb5\xe06\xac:\xac\x1b^");
  self.doubledoorother endon("\xe5\xed\x90\x19\xefB\xbc\n>r\x91\xbb:\xdc\xf9\xe9<");
  self waittill("\xe5\xed\x90\x19\xefB\xbc\n>r\x91\xbb:\xdc\xf9\xe9<", opener);
  self.doubledoorother thread door_sp::door_open_completely(opener);
}

function double_doors_hint_pos(door_other) {
  utility::flag_wait("\x02\xd7\xfa\x8a*L\xb3(c\xcam\xc8\xc4\xba\xb0)\x16/\xa8/\x91N\x1cs\x02\xe0%g\x89%.\xc4");
  waitframe();
  struct = spawnStruct();
  struct.origin = math::get_mid_point(self.open_struct.origin, door_other.open_struct.origin);
  door_sp::remove_open_prompts();
  struct.door = self;

  if(isDefined(self.open_struct) && isDefined(self.open_struct.radius)) {
    struct.radius = self.open_struct.radius;
  }

  self.open_struct = struct;
  setup_open_struct(struct);
  thread cursor_hint_thread();
}

function door_watch_unresolved_collision() {
  self endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    if(isDefined(self.door_unresolved_collision_count) && self.door_unresolved_collision_count >= 3) {
      if(!isDefined(self.notsolid)) {
        if(getdvarint(@ "hash_6985e82f27803483")) {
          print("<dev string:x5b7>" + gettime());
          print3d(level.player.origin, "<dev string:x5de>", (1, 0, 0), 1, 0.25, 1000, 1);
          debugaxis(level.player.origin, level.player getplayerangles(1), 8, undefined, 0, 1000);
          line(level.player.origin, self.origin, (1, 0, 0), 1, 0, 1000);
        }

        self notsolid();
        self.notsolid = 1;
        self.door_unresolved_collision_origin = self.origin;
      } else if(isDefined(self.notsolid) && !level.player istouching(self)) {
        if(getdvarint(@ "hash_6985e82f27803483")) {
          print("<dev string:x5e7>" + gettime());
          print3d(level.player.origin, "<dev string:x614>", (0, 1, 0), 1, 0.25, 1000, 1);
          debugaxis(level.player.origin, level.player getplayerangles(1), 8, undefined, 0, 1000);
          line(level.player.origin, self.origin, (0, 1, 0), 1, 0, 1000);
        }

        self solid();
        self.notsolid = undefined;
        self.door_unresolved_collision_count = undefined;
        self.door_unresolved_collision_start_time = undefined;
        break;
      }
    } else if(isDefined(self.door_unresolved_collision_count) && self.door_unresolved_collision_count > 0 && gettime() - self.door_unresolved_collision_start_time > 500) {
      self.door_unresolved_collision_count = undefined;
      self.door_unresolved_collision_start_time = undefined;
      break;
    }

    waitframe();
  }
}

function door_watch_unresolved_collision_count() {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("2\xfe&\xc10J\xde\xffUxV#\x95\xa4\xf0\xfb\x99\xd0\xebd", mover);

    if(isDefined(mover) && istrue(mover.doorclip)) {
      if(!isDefined(mover.door_unresolved_collision_count)) {
        mover.door_unresolved_collision_count = 1;
        mover.door_unresolved_collision_start_time = gettime();
        mover thread door_watch_unresolved_collision();
        continue;
      }

      mover.door_unresolved_collision_count++;
    }
  }
}