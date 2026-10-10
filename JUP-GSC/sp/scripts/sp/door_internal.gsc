/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\door_internal.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#using scripts\sp\door_scriptable;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\starts;
#using scripts\sp\utility;
#namespace door_internal;

function door_post_load() {
  init_doors();
  thread trace_completion_thread();
}

function init_window() {
  assertex(isDefined(self.target), "Window at " + self.origin + " has no targeted window panes.");
  panes = getEntArray(self.target, "targetname");

  foreach(pane in panes) {
    if(!isDefined(pane.script_linkto)) {
      continue;
    }

    clip = pane get_linked_ent();
    clip linkTo(pane);
  }

  linked_nodes = get_linked_nodes();

  foreach(node in linked_nodes) {
    if(is_equal(node.targetname, "traverse")) {
      destroynavlink(node);
      continue;
    }

    if(is_equal(node.script_noteworthy, "cover")) {
      node disconnectnode();
    }
  }

  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"GAME/DOOR_OPEN", 55, 135 * level.interactive_doors.hint_dist_scale, 85 * level.interactive_doors.hint_dist_scale, 1);
  self.cursor_hint_ent setusewhenhandsoccupied(1);
  event = waittill_window_event();
  scripts\sp\player\cursor_hint::remove_cursor_hint();

  if(event == "trigger") {
    thread player_window_gesture(0.65);
    opentime = 0.8;
    sound = "door_open_ajar";
  } else {
    door_bash_presentation();
    opentime = 0.35;
    sound = "door_open_bash";
  }

  function_daf6c5596bb31dff("window_open", level.player, level.player.origin, 384, undefined, undefined, 80);

  foreach(pane in panes) {
    if(is_equal(pane.script_noteworthy, "delete_on_open")) {
      pane delete();
      continue;
    }

    originalangles = pane.angles;
    vector = pane.origin - level.player.origin;
    forward = anglesToForward(originalangles);
    dot = vectordot(vector, forward);
    var_f25f65666bab9bcd = ter_op(dot > 0, anglestoright(originalangles), anglestoleft(originalangles));
    var_d8bd7d9a61d3c70a = vectortoangles(var_f25f65666bab9bcd);
    goalangles = anglelerpquatfrac(originalangles, var_d8bd7d9a61d3c70a, randomfloatrange(1, 1.15));
    pane rotateTo(goalangles, opentime, opentime * 0.8, opentime * 0.2);
    pane playSound(sound);

    if(event == "melee_pressed") {
      if(isDefined(level.stealth)) {
        thread stealth_broadcast(450, "combat");
      } else {
        thread combat_getinfoinradius(450);
      }

      pane delaycall(opentime, &rotateto, var_d8bd7d9a61d3c70a, randomfloatrange(0.75, 1.25));
      pane delaycall(opentime, &playsound, "door_open_stop");
      self notify("trigger");
    }
  }

  foreach(node in linked_nodes) {
    if(is_equal(node.targetname, "traverse")) {
      end_node = getnode(node.target, "targetname");
      createnavlink("window_traversal", node.origin, end_node.origin, node);
      continue;
    }

    if(is_equal(node.script_noteworthy, "cover")) {
      node connectnode();
    }
  }
}

function waittill_window_event() {
  while(true) {
    bashed = waittill_melee_or_interact();

    if(!isDefined(bashed) || window_melee_valid(self.origin)) {
      return ter_op(!isDefined(bashed), "trigger", "melee_pressed");
    }
  }
}

function waittill_melee_or_interact() {
  self endon("trigger");
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

  if(!within_fov(level.player.origin + anglesToForward(level.player.angles) * -50, level.player.angles, windoworigin, 0.731353)) {
    return false;
  }

  return true;
}

function init_doors() {
  doors = getEntArray("interactive_door", "script_noteworthy");

  if(doors.size > 0) {
    global_door_threads();
  }

  array_thread(doors, level.interactive_doors.fndoorinit);

  array_thread(doors, &function_15e6179f97b90046);
}

function global_door_threads() {
  if(isDefined(level.doors_initialized)) {
    return;
  }

  if(scripts\sp\starts::is_no_game_start()) {
    return;
  }

  level.doors_initialized = 1;
  array_thread(getaiarray(), &scripts\sp\door::ai_monitor_doors);
  add_global_spawn_function("allies", &scripts\sp\door::ai_monitor_doors);
  add_global_spawn_function("axis", &scripts\sp\door::ai_monitor_doors);
  add_global_spawn_function("neutral", &scripts\sp\door::ai_monitor_doors);
  add_global_spawn_function("team3", &scripts\sp\door::ai_monitor_doors);
}

function init_door_internal(reset) {
  if(!istrue(reset)) {
    assertex(!isDefined(self.doorid), "door at " + self.origin + " is already initialized");
  }

  self.pivots = [];
  self.closed_angles = (0, 0, 0);
  self.openers = [];
  self.tryingopener = undefined;
  self.doorid = self getentitynumber();
  self.ai_anim_start = [];
  self.hinge_side = undefined;
  self.breached = 0;
  self.doortype = "wood";
  self.clip = undefined;
  self.linked_ents = undefined;
  self.no_bash = undefined;
  self.current_pivot_struct = undefined;

  if(scripts\sp\starts::is_no_game_start()) {
    return;
  }

  if(isDefined(self.open_struct)) {
    self.open_struct.custom_hint_text = undefined;
    self.open_struct.no_open_interact = undefined;
  }

  if(!isDefined(self.true_start_angles)) {
    self.true_start_angles = self.angles;
  }

  if(!isDefined(self.locked)) {
    self.locked = 0;
  }

  if(!ent_flag_exist("initialized")) {
    ent_flag_init("initialized");
  }

  if(istrue(reset)) {
    self.script_spawn_open_yaw = undefined;
  } else {
    level.interactive_doors.ents[level.interactive_doors.ents.size] = self;
  }

  ents = get_linked_ents();
  structs = get_linked_structs();
  doopen = 1;

  if(isDefined(self.script_parameters)) {
    values = strtok(self.script_parameters, " ");

    foreach(value in values) {
      switch (value) {
        case #"hash_cb7d0a281b511f3":
          if(!istrue(reset)) {
            self.locked = 1;
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
        case #"hash_d8442f512bb8ab99":
          thread scripts\sp\door::function_89be9fac0c81f3aa();
          break;
        case #"hash_8833e927768f4e12":
          thread scripts\sp\door::door_open_completely();
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
            println("<dev string:x1c>" + self.origin + "<dev string:x5a>");
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
          self.pivots["open_left"] = struct;
          break;
        case #"hash_eda02527ade442aa":
          self.pivots["open_right"] = struct;
          break;
        case #"hash_1da6ba65ec0ff8e0":
          self.ai_anim_start["walk"] = rotatevectorinverted(struct.origin - self.origin, self.true_start_angles);
          break;
        case #"hash_79d4ad622880225a":
          self.ai_anim_start["run"] = rotatevectorinverted(struct.origin - self.origin, self.true_start_angles);
          break;
      }
    }
  }

  self.forward = anglesToForward(self.true_start_angles);
  self.open_left = scripts\sp\door::should_open_left();
  self.bashed = 0;
  self.bashed_full = 0;
  self.ajar = 0;
  self.open_completely = 0;
  self.was_opened_halfway = 0;
  self.active = 1;
  self.team = ter_op(isDefined(self.script_team), self.script_team, "");
  get_door_bottom_center();
  initlinkednodes();
  updatenodelookpeek();
  scripts\sp\door_scriptable::init_destructible();

  if(self.classname != "script_model" && !isDefined(self.clip) && !is_clip_nosight()) {
    self.clip = self;
    self.clip.doorclip = 1;
  }

  linknameprefix = strtok(structs[0].script_linkname, "_")[0];
  createinitialnavmodifier(linknameprefix);
  assertex(isDefined(self.clip), "SP script_model doors: Door missing associated clip assignment. Door origin" + self.origin + " with model(" + default_to(self.model, "none") + ") targetname(" + default_to(self.targetname, "none") + "). " + ter_op(getentarrayinradius("script_brushmodel", "classname").size == 0, "<<Your BSP has 0 script_brushmodels, is something wrong with the BSP?>>", "Does doormodel.script_linkto point to a scriptbrushmodel.script_linkname?"));
  assertex(!isDefined(self.clip) || self.clip.spawnflags & 1, "SP script_model doors: Door clip spawnflags doesn't have DYNAMIC_PATH set, AI won't be able to use it. Door origin" + self.origin + " with model(" + default_to(self.model, "none") + ") targetname(" + default_to(self.targetname, "none") + ")");
  self.clip connectpaths();
  assert(isDefined(self.true_start_angles));

  if(self.locked) {
    scripts\sp\door::create_navobstacle();
  }

  self.nav_lastupdatetime = gettime();
  self.nav_lastupdateangle = self.true_start_angles[1];

  if(!isDefined(self.script_spawn_open_yaw) || istrue(level.interactive_doors.close_prompt)) {
    thread cursor_hint_thread();
  }

  thread scripts\sp\door::init_max_yaws();
  thread door_open_think();

  if(isDefined(self.doubledoors)) {
    scripts\sp\door::double_doors_init(self.doubledoors[0], self.doubledoors[1]);
  }
}

function is_clip_nosight() {
  return isDefined(self.script_noteworthy) && self.script_noteworthy == "clip_nosight";
}

function cursor_hint_thread(var_3443efedc8b77120) {
  self notify("cursor_hint_thread");
  self endon("cursor_hint_thread");
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_cursor_hint_thread");
  self.var_f2507a3c1b546d7c = -1;
  self.var_6cd0321e55f60f8f = -1;
  self.cursorhintdir = (0, 0, 0);
  var_53153eaf006f13a9 = isDefined(self.open_struct);

  while(true) {
    set_player_side();

    if(!var_53153eaf006f13a9 && has_cursor_hint(self.open_struct) || cursor_refresh(self.open_struct)) {
      var_53153eaf006f13a9 = 1;
      self.var_f2507a3c1b546d7c = -1;
    }

    if(self.var_f2507a3c1b546d7c != self.var_6cd0321e55f60f8f) {
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

    if(var_53153eaf006f13a9) {
      var_53153eaf006f13a9 = has_cursor_hint(self.open_struct);
    }

    if(isDefined(var_3443efedc8b77120)) {
      self[[var_3443efedc8b77120]]();
    }

    dist = max(0, distance(level.player getEye(), self.origin) - 200);
    level.player waittill_any_timeout_1(max(0.05, dist / 528), "teleported");
  }
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
  door_angles = scripts\sp\door::get_door_angles() - self.true_start_angles;

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

function function_d6f79a2aa10afcb1() {
  angles = vectortoangles(self.forward);

  if(isDefined(self.pivot_ent)) {
    angles = self.pivot_ent.angles;
  }

  right = anglestoright(angles);
  normal = vectorNormalize(level.player.origin - self.origin);
  dot = vectordot(right, normal);

  if(dot > 0) {
    return [1, right];
  }

  return [0, right * -1];
}

function set_player_side() {
  var_6cd0321e55f60f8f = function_d6f79a2aa10afcb1();
  self.var_f2507a3c1b546d7c = self.var_6cd0321e55f60f8f;
  self.var_6cd0321e55f60f8f = var_6cd0321e55f60f8f[0];
  self.cursorhintdir = var_6cd0321e55f60f8f[1];
}

function trace_completion_thread() {
  while(true) {
    startagain = 0;

    foreach(door in level.interactive_doors.ents) {
      if(!isDefined(door.max_yaw_left) || !isDefined(door.max_yaw_right)) {
        startagain = 1;
        break;
      }
    }

    if(!startagain) {
      break;
    }
  }

  if(!flag("scriptables_ready")) {
    println("<dev string:x5c>");
    flag_wait("scriptables_ready");
  }

  flag_set("interactive_doors_ready_internal");
  waitframe();
  flag_set("interactive_doors_ready");
}

function get_hint_dist(defaultval) {
  if(isDefined(level.interactive_doors.hint_dist_scale)) {
    return (defaultval * level.interactive_doors.hint_dist_scale);
  }

  return defaultval;
}

function function_15e6179f97b90046() {
  self endon("<dev string:x9f>");
  self.debug_activity = "<dev string:xad>";

  while(true) {
    if(!getdvarint(@ "hash_6985e82f27803483") || distancesquared(self.origin, level.player.origin) > squared(450)) {
      wait 0.15;
      continue;
    }

    space = 1.85;
    count = 0;
    base = self.origin + (5, 5, 58);
    print3d(base + (0, 0, count * space * -1), "<dev string:xae>" + self.doorid, (1, 1, 1), 1, 0.15);
    count++;
    print3d(base + (0, 0, count * space * -1), "<dev string:xb8>" + self.true_start_angles, (1, 1, 1), 1, 0.15);
    count++;
    print3d(base + (0, 0, count * space * -1), "<dev string:xcc>" + scripts\sp\door::get_door_angles(), (1, 1, 1), 1, 0.15);
    count++;

    if(isDefined(self.current_pivot_struct)) {
      print3d(base + (0, 0, count * space * -1), "<dev string:xdd>" + self.current_pivot_struct.script_noteworthy, (1, 1, 1), 1, 0.15);
      count++;
    }

    if(isDefined(self.pivot_ent)) {
      print3d(self.pivot_ent.origin + (0, 0, 5), "<dev string:xe5>", (1, 1, 1), 1, 0.15);
    }

    print3d(base + (0, 0, count * space * -1), "<dev string:xef>" + self.open_left, (1, 1, 1), 1, 0.15);
    count++;
    print3d(base + (0, 0, count * space * -1), "<dev string:xfb>" + self.debug_activity, (1, 1, 1), 1, 0.15);
    count++;

    if(isDefined(self.pivot_ent)) {
      spot = self.pivot_ent.origin;
    } else {
      spot = self.origin;
    }

    print3d(get_door_center(), "<dev string:x106>");
    thread scripts\sp\debug::drawarrow(spot, scripts\sp\door::get_door_angles(), undefined, 3);

    if(isDefined(self.max_yaw_left)) {
      thread draw_max_yaw(1);
    }

    if(isDefined(self.max_yaw_right)) {
      thread draw_max_yaw(0);
    }

    if(isDefined(self.traces)) {
      print3d(base + (0, 0, count * space * -1), "<dev string:x108>" + self.traces, (1, 1, 1), 1, 0.15);
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
  door endon("first_interact");
  door endon("ai_opened");
  door endon("bashed");
  door endon("detonate");
  door endon("unlock_volume_logic");

  while(true) {
    while(!level.player istouching(self) && (!isDefined(door.doubledoorother) || !isDefined(door.doubledoorother.unlock_volume) || !level.player istouching(door.doubledoorother.unlock_volume))) {
      waitframe();
    }

    door scripts\sp\door::unlock_door();

    while(level.player istouching(self) || isDefined(door.doubledoorother) && isDefined(door.doubledoorother.unlock_volume) && level.player istouching(door.doubledoorother.unlock_volume)) {
      waitframe();
    }

    door scripts\sp\door::lock_door();
  }
}

function refresh_open_struct() {
  self.refresh = 1;
}

function door_open_think() {
  self notify("door_open_think");
  self endon("door_open_think");
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_open_ability");
  self endon("ai_opened");

  if(!isDefined(self.script_spawn_open_yaw)) {
    thread scripts\sp\door::bash_monitor();
    waittill_first_interact_or_bash();
  } else {
    thread scripts\sp\door::door_ajar();
  }

  if(!self.bashed_full) {
    thread monitor_door_push();
    waittill_second_interact_or_bash();
  }

  scripts\sp\door::remove_open_ability();
}

function get_max_yaw(left) {
  var_341549370db541dd = 70;
  major_increment = 30;
  minor_increment = 5;

  if(left) {
    if(isDefined(self.script_max_left_angle)) {
      self.max_yaw_left = self.script_max_left_angle;
      return;
    }
  } else if(isDefined(self.script_max_right_angle)) {
    self.max_yaw_right = self.script_max_right_angle;
    return;
  }

  var_3b95c8b5e7f3b716 = get_max_yaw_internal(var_341549370db541dd, major_increment, left);
  var_3b95c8b5e7f3b716 += minor_increment;
  var_775065760c0fb3ba = get_max_yaw_internal(var_3b95c8b5e7f3b716, minor_increment, left);

  if(left) {
    self.max_yaw_left = var_775065760c0fb3ba;
    return;
  }

  self.max_yaw_right = var_775065760c0fb3ba;
}

function get_max_yaw_internal(test_yaw, increment, left) {
  failed_once = 0;
  finished = 0;
  contents = scripts\engine\trace::create_default_contents(1);

  while(!finished) {
    if(test_yaw > 179) {
      return 179;
    }

    safe_yaw = yaw_collision_check(test_yaw, left, contents);

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
  multiplier = 100;

  if(left) {
    multiplier *= -1;
  } else {
    yaw *= -1;
  }

  trace_angles = self.true_start_angles + (0, yaw, 0);

  if(left) {
    basestart = self.pivots["open_left"].origin + (0, 0, 2);
  } else {
    basestart = self.pivots["open_right"].origin + (0, 0, 2);
  }

  start = basestart + anglesToForward(trace_angles) * self.length * 0.2;
  end = start + anglestoright(trace_angles) * multiplier;
  trace = scripts\engine\trace::capsule_trace(start, end, 6, 80, trace_angles, [self, self.clip], content_override, 0);
  dist = distance2d(start, trace["position"]);

  if(getdvarint(@ "hash_6985e82f27803483")) {
    if(!isDefined(self.traces)) {
      self.traces = 1;
    } else {
      self.traces++;
    }

    color = (1, 1, 1);

    if(dist > 50) {
      color = (0, 1, 0);
    } else if(dist < 3) {
      color = (1, 0, 0);
    } else if(dist < 50) {
      color = (1, 1, 0);
    }

    var_18c5ebb73f7639ce = basestart + anglesToForward(trace_angles) * self.length;
    var_2bb3e172d183245b = start + anglestoright(trace_angles) * dist;
    line(basestart, var_18c5ebb73f7639ce, (1, 1, 1), 1, 0, 60);
    line(start, var_2bb3e172d183245b, color, 0.5, 0, 60);
  }

  if(dist > 3) {
    start = basestart + anglesToForward(trace_angles) * self.length * 0.9;
    trace = scripts\engine\trace::capsule_trace(start, end, 6, 80, trace_angles, [self, self.clip], content_override, 0);

    if(getdvarint(@ "hash_6985e82f27803483")) {
      self.traces++;
      color = (1, 1, 1);

      if(dist > 50) {
        color = (0, 1, 0);
      } else if(dist < 5) {
        color = (1, 0, 0);
      } else if(dist < 50) {
        color = (1, 1, 0);
      }

      var_2bb3e172d183245b = start + anglestoright(trace_angles) * dist;
      line(start, var_2bb3e172d183245b, color, 0.5, 0, 60);
    }

    dist = distance2d(start, trace["position"]);
    return (dist > 5);
  }

  return false;
}

function draw_max_yaw(left) {
  yaw = undefined;

  if(left) {
    yaw = self.max_yaw_left;
    start = self.pivots["<dev string:x126>"].origin;
  } else {
    yaw = self.max_yaw_right * -1;
    start = self.pivots["<dev string:x130>"].origin;
  }

  trace_angles = self.true_start_angles + (0, yaw, 0);
  line_end = start + anglesToForward(trace_angles) * self.length;
  line(start, line_end, (1, 0, 0), 1, 0, 3);
}

function try_door_hint() {
  self endon("door_close");

  if(istrue(self.nohint)) {
    return;
  }

  if(!flag("did_door_hint")) {
    thread display_hint_dist_check();

    while(level.player useButtonPressed() || isDefined(level.player getplayeruseentity()) || isDefined(self.hint_delay_until) && gettime() < self.hint_delay_until) {
      waitframe();
    }

    wait 0.25;

    if(!flag("door_second_interact") && !flag("door_exceed_hint_dist") && !istrue(self.bashed)) {
      flag_set("did_door_hint");
      thread display_hint("door_hint_1", undefined, undefined, self, "bashed");
    }
  }
}

function first_hint_func() {
  if(flag("door_second_interact")) {
    return true;
  }

  if(flag("door_exceed_hint_dist")) {
    return true;
  }

  if(isDefined(level.player getplayeruseentity())) {
    return true;
  }

  return false;
}

function display_hint_dist_check() {
  self notify("display_hint_dist_check");
  self endon("display_hint_dist_check");
  self endon("death");
  level.player endon("death");
  self endon("reset_door");
  flag_clear("door_exceed_hint_dist");

  while(distancesquared(self.origin, level.player.origin) < squared(165)) {
    wait 0.1;
  }

  flag_set("door_exceed_hint_dist");
}

function waittill_first_interact_or_bash() {
  self endon("entitydeleted");
  self endon("bashed");
  self endon("open_completely");
  self waittill("first_interact");
  thread scripts\sp\door::door_ajar();
}

function waittill_second_interact_or_bash() {
  self endon("bashed");
  self waittill("open_completely");

  if(getdvarint(@ "hash_e76702af051fcb2b")) {
    thread player_door_gesture(1);
    wait 0.1;
  }

  level.player playRumbleOnEntity("damage_light");
  earthquake(0.13, 0.2, level.player.origin, 200);
  thread scripts\sp\door::door_open_completely();
}

function can_pivot_change() {
  if(isDefined(self.pivot_ent) && isDefined(self.current_pivot_struct) && self.pivot_ent.angles != self.current_pivot_struct.angles) {
    return false;
  }

  return true;
}

function set_pivot_point(left) {
  if(!can_pivot_change()) {
    if(issubstr(self.current_pivot_struct.script_noteworthy, "pivot_left")) {
      self.hinge_side = "open_left";
      return;
    }

    self.hinge_side = "open_right";
    return;
  }

  if(left) {
    new_pivot = "open_left";
  } else {
    new_pivot = "open_right";
  }

  self.hinge_side = new_pivot;

  if(!isDefined(self.current_pivot_struct) || self.current_pivot_struct != self.pivots[new_pivot]) {
    println("<dev string:x13b>" + new_pivot);
    self.current_pivot_struct = self.pivots[new_pivot];

    if(self islinked()) {
      self unlink();
    }

    if(!isDefined(self.pivot_ent)) {
      self.pivot_ent = spawn_script_origin(self.current_pivot_struct.origin, self.true_start_angles);
    } else {
      self.pivot_ent dontinterpolate();
      self.pivot_ent.origin = self.current_pivot_struct.origin;
    }

    wait 0.05;
    self linkTo(self.pivot_ent);
  }
}

function monitor_open_completely() {
  self endon("open_completely");
  self endon("stop_monitoring_open_completely");
  self endon("entitydeleted");
  self endon("reset_door");

  while(level.player useButtonPressed()) {
    wait 0.05;
  }

  while(true) {
    if(!istrue(self.bashed) && scripts\sp\door::bash_door_isplayerclose() && level.player useButtonPressed() && !isDefined(level.player getplayeruseentity()) && pushents_clear()) {
      if(!flag("door_second_interact")) {
        flag_set("door_second_interact");
      }

      self notify("open_completely");
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
  assertex(isstruct(self), "Call this on the door.open_struct");
  self.door endon("stop_open_ability");
  self.door endon("stop_open_interact");

  if(!isDefined(self.openinteract)) {
    self.openinteract = 0;
  }

  if((istrue(display_locked) || isDefined(self.door.lockpick)) && istrue(self.door.locked) && !istrue(self.door.nohint)) {
    if(isDefined(self.door.lockpick)) {
      self.door.lockpick.hint_string = undefined;
      self.door.lockpick.hint_icon = undefined;
    }

    scripts\sp\door::remove_open_interact_hint();
    self.no_open_interact = undefined;
    scripts\sp\door::create_open_interact_hint(&"SCRIPT/DOOR_HINT_LOCKED");
    refresh_open_struct();

    if(function_2998da25f4d455b1(self.door)) {
      childthread function_a320f9f9dda13f8f();
    } else if(isDefined(self.door.lockpick) && isDefined(self.door.lockpick.var_6a6a7087aa17ffdd)) {
      self[[self.door.lockpick.var_6a6a7087aa17ffdd]]();
    }
  } else {
    scripts\sp\door::create_open_interact_hint();
  }

  self.door thread door_open_think();

  if(isDefined(self.cursor_hint_ent)) {
    self.cursor_hint_ent waittill("trigger");
  } else {
    self waittill("trigger");
  }

  self notify("stop_cursor_hint_thread");
  self.door notify("trigger");
  level.player notify("door_trigger", self.door);

  if(getdvarint(@ "hash_e76702af051fcb2b")) {
    thread player_door_gesture();
  }

  if(function_e0b0300fbf1b645b(self.door)) {
    if(!isDefined(self.door.lockpick)) {
      if(getdvarint(@ "hash_e76702af051fcb2b")) {
        wait 0.1;
      }

      if(isDefined(self.door.script_sound_type) && self.door.script_sound_type == "metal_heavy") {
        thread play_sound_in_space("scrpt_door_metal_open_locked", self.cursor_hint_ent.origin);
      } else {
        thread play_sound_in_space("scrpt_door_wood_open_locked", self.cursor_hint_ent.origin);
      }

      level.player playRumbleOnEntity("damage_heavy");
      earthquake(0.17, 0.2, level.player.origin, 200);
      self.door notify("locked");
    }

    thread open_struct_logic(1);
    self.door thread scripts\sp\door_internal::cursor_hint_thread();
    return;
  }

  scripts\sp\door::remove_open_interact_hint();

  if(getdvarint(@ "hash_e76702af051fcb2b")) {
    wait 0.1;
  } else if(isDefined(self.door.destructible)) {
    self.door setscriptablepartstate("main", "open_handle");
  }

  self.door notify("first_interact");

  if(!flag("door_first_interact")) {
    flag_set("door_first_interact");
  }
}

function function_a320f9f9dda13f8f() {
  self endon("trigger");
  self.cursor_hint_ent endon("trigger");
  previoushintstring = undefined;

  while(isDefined(self.cursor_hint_ent)) {
    hintstring = undefined;

    if(isDefined(self.door.lockpick) && isDefined(self.door.lockpick.var_6a6a7087aa17ffdd)) {
      self[[self.door.lockpick.var_6a6a7087aa17ffdd]]();
    } else {
      if(function_e0b0300fbf1b645b(self.door)) {
        hintstring = &"SCRIPT/DOOR_HINT_LOCKED";
      } else if(self.door door_bashable_by_player(1)) {
        hintstring = &"SCRIPT/DOOR_HINT_USE";
      } else {
        hintstring = &"SCRIPT/DOOR_HINT_USE_NO_BASH";
      }

      if(!is_equal(hintstring, previoushintstring)) {
        self.cursor_hint_ent setHintString(hintstring);
      }

      previoushintstring = hintstring;
    }

    waitframe();
  }
}

function function_2998da25f4d455b1(door) {
  return isDefined(door.script_side);
}

function function_e0b0300fbf1b645b(door) {
  if(!door.locked) {
    return false;
  }

  if(!isDefined(door.script_side)) {
    return true;
  }

  var_65f355bcee376af7 = door function_d6f79a2aa10afcb1()[0];

  if(door.script_side == "right" && var_65f355bcee376af7) {
    return true;
  }

  if(door.script_side == "left" && !var_65f355bcee376af7) {
    return true;
  }

  return false;
}

function should_do_gesture() {
  return !isnullweapon(level.player getcurrentweapon());
}

function player_door_gesture(pushhard) {
  self notify("player_door_gesture");
  self endon("player_door_gesture");

  if(isDefined(pushhard) && pushhard) {
    gesture = level.interactive_doors.gesture_door_hard;
  } else {
    gesture = level.interactive_doors.gesture_door;
  }

  thread pushplayertodoor();
  target = spawn_tag_origin();
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
  level.player thread blend_movespeedscale(0.1, 0.3, "doorOpen");

  while(timefactor < 0.99) {
    if(!isDefined(self)) {
      break;
    }

    pushlogic(timefactor);
    timefactor += growth;
    wait 0.05;
  }

  timefactor = 1;
  level.player thread blend_movespeedscale(1, 0.7, "doorOpen");

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
  self notify("player_window_gesture");
  self endon("player_window_gesture");
  gesture = level.interactive_doors.gesture_window;

  if([[level.interactive_doors.fnshoulddogesture]]()) {
    duration = ter_op(isDefined(duration), duration, 1);
    level.player playgestureviewmodel(gesture);
    wait duration;
  }

  level.player stopgestureviewmodel(gesture, 2);
}

function door_bashable_by_player(var_e6934380371d7dd3) {
  if(istrue(self.no_bash) || istrue(self.was_opened_halfway) || istrue(self.open_completely) || istrue(self.bashed)) {
    self.debug_activity = "<dev string:x151>";

    return false;
  }

  if(istrue(var_e6934380371d7dd3)) {
    return true;
  }

  if(isnullweapon(level.player getcurrentweapon())) {
    return false;
  }

  if(function_4812cda9829d627a()) {
    return true;
  }

  return false;
}

function function_4812cda9829d627a() {
  if(within_fov(level.player.origin, level.player.angles, get_door_bottom_center(), 0.82)) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_center(), "<dev string:x181>", (0, 1, 0), 1, 0.1, 1, 1);
    }

    return true;
  } else {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_center(), "<dev string:x192>", (1, 0, 0), 1, 0.1, 1, 1);
    }
  }

  if(within_fov(level.player.origin, level.player.angles, get_door_bottom_handle(), 0.82)) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_handle(), "<dev string:x181>", (0, 1, 0), 1, 0.1, 1, 1);
    }

    return true;
  } else {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_handle(), "<dev string:x192>", (1, 0, 0), 1, 0.1, 1, 1);
    }
  }

  if(within_fov(level.player.origin, level.player.angles, get_door_bottom_origin(), 0.82)) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_origin(), "<dev string:x181>", (0, 1, 0), 1, 0.1, 1, 1);
    }

    return true;
  } else {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      print3d(get_door_bottom_origin(), "<dev string:x192>", (1, 0, 0), 1, 0.1, 1, 1);
    }
  }

  return false;
}

function should_bash_open() {
  thread bash_debug(1);

  if(door_bashable_by_player()) {
    if(getdvarint(@ "hash_6985e82f27803483")) {
      printtoscreen2d(900, 700, "<dev string:x1a3>", (0, 1, 0), 2);
    }

    if(level.player ismeleeing()) {
      thread bash_debug(2000);
      return true;
    }

    if(!level.player issprinting()) {
      return false;
    }

    if(getdvarint(@ "scr_door_bash_requires_use")) {
      if(!level.player useButtonPressed()) {
        return false;
      }
    }

    playerspeed = length(level.player getvelocity());

    if(playerspeed < 50) {
      return false;
    }

    vec = vectorNormalize(level.player getEye() - get_door_center());
    doordot = vectordot(vec, anglesToForward(scripts\sp\door::get_door_angles()));

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
    color = ter_op(dot >= 0.82, (0, 1, 0), (1, 0, 0));
    print3d(get_door_center(), "<dev string:x1b1>" + dot, color, 1, 0.1, duration, 1);
    vec = vectorNormalize(level.player getEye() - get_door_center());
    dot = vectordot(vec, anglesToForward(scripts\sp\door::get_door_angles()));
    color = ter_op(abs(dot) <= 0.4, (0, 1, 0), (1, 0, 0));
    print3d(get_door_center() + (0, 0, -1.5), "<dev string:x1be>" + dot, color, 1, 0.1, duration, 1);
  }
}

function stealth_broadcast(event, originator, radius) {
  if(!isDefined(radius) && function_1c1b9d33706c152d(originator, event)) {
    return;
  }

  dist = ter_op(isDefined(radius), radius, 500);
  guys = get_all_closest_living(self.origin, getaiarray("axis"), dist, 0);

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
  dist = ter_op(isDefined(radius), radius, 500);
  guys = get_all_closest_living(self.origin, getaiarray("axis"), dist, 0);

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
        bash_yaw = self.true_start_angles[1] - 4;
      } else {
        bash_yaw = self.true_start_angles[1] + 4;
      }
    }
  }

  return bash_yaw;
}

function bashed_locked_door(velocity) {
  level.player endon("death");

  if(isDefined(self.isbashing)) {
    return;
  }

  self.isbashing = 1;
  thread bashed_locked_door_sfx();
  self notify("trigger");
  self notify("bashing_while_locked");
  self notify("locked");
  level.player viewkick(10, get_door_center(), 0);
  earthquake(1, 0.3, level.player.origin, 75);
  level.player playRumbleOnEntity("heavy_1s");
  self.open_struct thread open_struct_logic(1);
  thread scripts\sp\door_internal::cursor_hint_thread();

  while(level.player ismeleeing()) {
    waitframe();
  }

  self.isbashing = undefined;
}

function bashed_locked_door_sfx() {
  if(!isDefined(self.bashedsfx)) {
    self.bashedsfx = 1;
    org = spawn("script_origin", self.origin + (0, 0, 42));
    org playSound("door_locked_bashed", "sounddone");

    if(randomint(100) < 40) {
      level.player playSound("breathing_limp");
    }

    org waittill("sounddone");
    org delete();
    self.bashedsfx = undefined;
  }
}

function door_bash_presentation() {
  screenshake(level.player.origin, 16, 0, 0, 0.45);
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.6, 0.75, level.player.origin, 200);
}

function close_prompt(delay) {
  self notify("close_prompt");
  self endon("close_prompt");
  self endon("reset_door");
  self endon("entitydeleted");

  if(!istrue(level.interactive_doors.close_prompt)) {
    return;
  }

  flag_wait("interactive_doors_ready");

  if(isDefined(delay)) {
    wait delay;
  }

  while(true) {
    self.open_struct.no_open_interact = undefined;
    self.open_struct thread scripts\sp\door::create_open_interact_hint(&"SCRIPT/DOOR_HINT_CLOSE");
    thread cursor_hint_thread();
    waitframe();
    self.open_struct.cursor_hint_ent waittill("trigger");

    if(!close_check()) {
      thread display_hint("door_hint_obstructed", 1);
      wait 1;
      continue;
    }

    self notify("stop_monitoring_open_completely");

    if(isDefined(self.doubledoorother)) {
      self.doubledoorother notify("stop_monitoring_open_completely");
    }

    if(getdvarint(@ "hash_e76702af051fcb2b")) {
      thread player_door_gesture();
    }

    if(isDefined(self.doubledoorother)) {
      self.doubledoorother thread scripts\sp\door::remove_open_prompts();
      self.doubledoorother thread scripts\sp\door::door_close();
    }

    scripts\sp\door::door_close();
    waitframe();

    if(isDefined(self.doubledoorother)) {
      self.doubledoorother thread scripts\sp\door::reset_door();
    }

    thread scripts\sp\door::reset_door();
  }
}

function close_check() {
  contents = scripts\engine\trace::create_character_contents();
  yaw_start = scripts\sp\door::get_door_angles()[1];
  yaw_end = self.true_start_angles[1];
  trace_count = ceil(abs(yaw_end - yaw_start) / 15);
  left = self.current_pivot_struct == self.pivots["open_left"];

  for(trace = 0; trace < trace_count; trace++) {
    angle = yaw_start + (yaw_end - yaw_start) * trace / trace_count;

    if(!yaw_collision_check(angle, left, contents)) {
      return false;
    }
  }

  return true;
}

function monitor_door_push(delay) {
  self notify("monitor_door_push");
  self endon("monitor_door_push");
  self endon("reset_door");
  self endon("stop_push_open");
  self endon("bashed_full");
  self endon("entitydeleted");

  if(!isDefined(delay)) {
    delay = 0.5;
  }

  if(self.bashed) {
    wait self.bashtime + 0.05;
    self.pivot_ent rotateTo(self.pivot_ent.angles, 0.05);
  } else if(delay > 0) {
    wait delay;
  }

  thread door_ease_in_open_input();

  while(true) {
    if(scripts\sp\door::interact_door_ispushentclose()) {
      push_door();
    } else if(istrue(self.isplayingpushsound)) {
      self.isplayingpushsound = 0;
      self notify("stop_door_creak");
    }

    waitframe();
  }
}

function door_ease_in_open_input() {
  maxtime = 1;
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
    pushents = array_add(self.pushents, level.player);
  } else {
    return level.player;
  }

  pushents = sortbydistance(pushents, self.origin);
  return pushents[0];
}

function push_door() {
  if(self.bashed_full) {
    return;
  }

  if(istrue(self.bash_opening)) {
    return;
  }

  pushent = get_pushent();
  max_dist = 36;
  min_dist = 0;
  max_push = 25;
  endpoint = interact_door_get_endpoint();
  dist = distance(pushent.origin, endpoint);
  percent = math::normalize_value(min_dist, max_dist, dist);
  amount = max_push * (1 - percent);
  amount *= self.masterdoorratescale;
  push_left = scripts\sp\door::should_open_left(self.pivot_ent.angles, pushent);

  if(abs(amount) < 0.001) {
    return;
  }

  self.open_struct scripts\sp\door::remove_open_interact_hint();
  currentyaw = scripts\sp\door::get_door_angles()[1];
  yaw_dir = ter_op(push_left == 1, 1, -1);
  target_yaw = currentyaw + amount * yaw_dir;

  if(push_left) {
    if(self.hinge_side == "open_left") {
      angle_diff = scripts\sp\door::angle_diff(target_yaw, self.true_start_angles[1]);

      if(angle_diff > self.max_yaw_left) {
        self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
        self.open_completely = 1;
        thread scripts\sp\door::updatenavobstacle();
        self notify("stop_push_open");
        return;
      }
    } else if(target_yaw > self.true_start_angles[1]) {
      self.debug_activity = "Pushed back closed, right hinge";

      if(!function_9f4e269e748b55d0()) {
        thread scripts\sp\door::reset_door();
        self notify("stop_push_open");
        return;
      }
    }
  } else if(self.hinge_side == "open_right") {
    angle_diff = abs(scripts\sp\door::angle_diff(target_yaw, self.true_start_angles[1]));

    if(angle_diff > self.max_yaw_right) {
      self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
      self.open_completely = 1;
      thread scripts\sp\door::updatenavobstacle();
      self notify("stop_push_open");
      return;
    }
  } else if(target_yaw < self.true_start_angles[1]) {
    self.debug_activity = "Pushed back closed, left hinge";

    if(!function_9f4e269e748b55d0()) {
      thread scripts\sp\door::reset_door();
      self notify("stop_push_open");
      return;
    }
  }

  if(amount > 0.4) {
    thread try_push_sound();

    if(!flag("door_second_interact")) {
      flag_set("door_second_interact");
    }
  } else if(istrue(self.isplayingpushsound)) {
    self.isplayingpushsound = 0;
    self notify("stop_door_creak");
  }

  self.debug_activity = "<dev string:x1d4>" + target_yaw;

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
    thread scripts\sp\door::updatenavobstacle(1);
  }
}

function function_9f4e269e748b55d0() {
  toodamaged = 0;

  if(istrue(self.destructible) || self isscriptable()) {
    if(self getscriptablepartstate("1") != "show") {
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
  push_left = scripts\sp\door::should_open_left(self.pivot_ent.angles, level.player);
  hinges = self.pivot_ent;
  channel = "doorPush" + self.doorid;

  if(!isDefined(self.dooroffset)) {
    self.dooroffset = (0, 0, 0);
    self.doorrot = (0, 0, 0);
    self.doorspeedscale = 1;
  }

  level.player notify("newoffset");
  level.player endon("newoffset");

  while(true) {
    pushspot = door_get_pushspot();
    var_3cb06b55e15364aa = (pushspot[0], pushspot[1], level.player.origin[2]) - level.player.origin;
    var_1a291042071ca88b = vectorNormalize(var_3cb06b55e15364aa);
    playerf = anglesToForward(level.player.angles);
    cross = vectorcross(playerf, var_1a291042071ca88b);
    dot = vectordot(playerf, var_1a291042071ca88b);
    var_271c6b91e677e543 = length(var_3cb06b55e15364aa);
    norminput = level.player getnormalizedmovement();
    norminput = (norminput[0], -1 * norminput[1], 0);
    localinput = rotatevector(norminput, level.player.angles);
    var_e2df997a605bdbf = vectorNormalize(localinput);
    var_e24f397a5fb91df = vectordot(var_e2df997a605bdbf, var_1a291042071ca88b);
    var_a870f5975b6135e7 = clamp(length(localinput), 0, 1);

    if(cross[2] > 0) {
      var_31fa3cf311e619d3 = (0, 4, 0);
      var_5ba1a48ce1cfc9ad = (0, -5, 0);
    } else {
      var_31fa3cf311e619d3 = (0, -2, 0);
      var_5ba1a48ce1cfc9ad = (0, 2, 0);
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

    var_67a920a30da099a0 = math::normalize_value(0.6, 1, abs(dot));
    var_67a920a30da099a0 = math::normalized_float_smooth_in(var_67a920a30da099a0);
    offset = math::factor_value(var_31fa3cf311e619d3, fb_offset, var_67a920a30da099a0);
    rot = math::factor_value(var_5ba1a48ce1cfc9ad, fb_rot, var_67a920a30da099a0);
    var_e36d7712ecd4be90 = math::normalize_value(0, 1, var_e24f397a5fb91df);
    var_f84a6367da0e58c8 = math::normalize_value(0, 0.5, var_a870f5975b6135e7);
    distfactor = 1 - math::normalize_value(20, 50, var_271c6b91e677e543);

    if(level.player isfiring()) {
      firingfactor = 0.5;
    } else {
      firingfactor = 1;
    }

    var_969f06899b0abb5c = 1;
    var_969f06899b0abb5c *= var_e36d7712ecd4be90;
    var_969f06899b0abb5c *= var_f84a6367da0e58c8;
    var_969f06899b0abb5c *= distfactor;
    var_969f06899b0abb5c *= firingfactor;
    offset *= var_969f06899b0abb5c;
    rot *= var_969f06899b0abb5c;

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
    var_e36d7712ecd4be90 = math::normalize_value(0, 1, var_e24f397a5fb91df);
    var_f84a6367da0e58c8 = math::normalize_value(0, 0.01, var_a870f5975b6135e7);
    distfactor = 1 - math::normalize_value(25, 70, var_271c6b91e677e543);
    speedscalefactor *= var_e36d7712ecd4be90;
    speedscalefactor *= var_f84a6367da0e58c8;
    speedscalefactor *= distfactor;
    speedscale = math::factor_value(1, 0.2, speedscalefactor);
    lerp = 0.3;
    self.doorspeedscale = math::lerp(self.doorspeedscale, speedscale, lerp);
    level.player blend_movespeedscale(self.doorspeedscale, 0, channel);

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

  level.player blend_movespeedscale(1, 0, channel);
}

function door_get_pushspot() {
  var_93271fe51551b254 = 12;
  playerspot = level.player.origin + anglesToForward(level.player.angles) * var_93271fe51551b254;
  endpoint = interact_door_get_endpoint();
  startpoint = self.origin + self.forward * 5;
  pushspot = pointonsegmentnearesttopoint(startpoint, endpoint, playerspot);
  return pushspot;
}

function initlinkednodes() {
  bottomcenter = get_door_bottom_center();
  assert(isDefined(self.length));
  nodes = getnodesinradius(bottomcenter, self.length * 0.5 + 32, 0, 80, "cover");
  assert(isDefined(nodes));

  if(nodes.size > 0) {
    self.linkednodes_hinge = [];
    self.linkednodes_knob = [];
    hingepos = undefined;

    if(isDefined(self.pivots["open_left"])) {
      hingepos = self.pivots["open_left"].origin;
    } else if(isDefined(self.pivots["open_right"])) {
      hingepos = self.pivots["open_right"].origin;
    } else {
      assertmsg("door node setup - door has neither pivot left nor right");
    }

    var_73752db085aa0240 = hingepos - bottomcenter;

    foreach(node in nodes) {
      var_e86598e262fd7c11 = node.origin - bottomcenter;

      if(vectordot(var_e86598e262fd7c11, var_73752db085aa0240) > 0) {
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
  dooryaw = angleclamp180(scripts\sp\door::get_door_angles()[1]);
  curangle = abs(angleclamp180(dooryaw - self.true_start_angles[1]));

  if(isDefined(self.linkednodes_hinge)) {
    doorforward = anglesToForward((0, dooryaw, 0));

    foreach(node in self.linkednodes_hinge) {
      if(curangle > 90) {
        node function_e7ec030a6ad3e5f8(1);
      } else {
        node function_e7ec030a6ad3e5f8(0);
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
        node function_e7ec030a6ad3e5f8(1);
        continue;
      }

      node function_e7ec030a6ad3e5f8(0);
    }
  }
}

function createinitialnavmodifier(linknameprefix) {
  if(!isDefined(self.navmodifier)) {
    linkname = linknameprefix + "_nav_modifier";
    self.navmodifier = createnavmodifier(linkname, "script_linkname");

    if(!isDefined(self.navmodifier)) {
      iprintln("<dev string:x1df>");
      line((0, 0, 0), self.origin, (1, 0, 0), 1, 0, 100);
      return;
    }

    println("<dev string:x200>" + self.doorid + "<dev string:x226>" + self.origin);
  }
}

function suspicious_door_stealth_check(var_b69422d8466298e6) {
  if(!isDefined(level.stealth)) {
    return;
  }

  if(!getdvarint(@ "hash_6109644d57e1122e") || !isDefined(level.stealth)) {
    return;
  }

  if(var_b69422d8466298e6) {
    level.stealth.suspicious_door.doors[level.stealth.suspicious_door.doors.size] = self;
    return;
  }

  level.stealth.suspicious_door.doors = array_remove(level.stealth.suspicious_door.doors, self);
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
  self notify("stop stopping door creak");
  var_7da6017ed0aee8e = get_door_audio_material();
  self scalevolume(1);
  alias = "scrpt_door_" + var_7da6017ed0aee8e + "_creak_lp";

  if(soundexists(alias)) {
    self playLoopSound(alias);
  }

  waittill_any("stop_door_creak", "stop_push_open");
  thread door_creak_sound_stop();
}

function door_creak_sound_stop() {
  self endon("stop stopping door creak");
  self scalevolume(0, 0.5);
  wait 0.55;
  self stoploopsound();
}

function interact_door_get_endpoint() {
  return self.origin + self.forward * self.length;
}

function door_is_at_max_yaw(either) {
  angle_diff = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);

  if(isDefined(either)) {
    return (angle_diff >= self.max_yaw_left || angle_diff <= -1 * self.max_yaw_right);
  }

  if(self.open_left) {
    return (angle_diff >= self.max_yaw_left);
  }

  return angle_diff <= -1 * self.max_yaw_right;
}

function door_is_half_open() {
  angle_diff = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);

  if(self.open_left) {
    return (angle_diff >= self.max_yaw_left / 2);
  }

  return angle_diff <= self.max_yaw_right / -2;
}

function door_is_open_at_least(checkangle) {
  angle_diff = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);
  return abs(angle_diff) >= checkangle;
}

function get_door_center() {
  angles = scripts\sp\door::get_door_angles();
  self.doorcenter = self.origin + (0, 0, 55) + anglesToForward(angles) * self.length * 1.2 / 2;
  return self.doorcenter;
}

function get_door_bottom_center() {
  self.doorbottomcenter = get_door_center();
  self.doorbottomcenter = (self.doorbottomcenter[0], self.doorbottomcenter[1], self.origin[2]);
  return self.doorbottomcenter;
}

function get_door_bottom_handle() {
  angles = scripts\sp\door::get_door_angles();
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
  var_3e0586184e6fe4d5 = spot + anglesToForward(vectortoangles(vec)) * 7;
  trace = navtrace(var_3e0586184e6fe4d5, targetpos, self, 1);

  color = (0, 1, 0);

  if(trace["<dev string:x233>"] < 0.88) {
    color = (1, 0, 0);
  }

  line(var_3e0586184e6fe4d5, trace["<dev string:x23c>"], color, 1, 0, 2);
  iprintln(trace["<dev string:x233>"]);

  return trace["fraction"] >= 0.9;
}

function print_navtrace(point) {
  self endon("<dev string:x245>");

  while(true) {
    trace = navtrace(self.origin, point, self, 1);
    line(self.origin, point, (0, 1, 0), 1, 0, 1);
    line(self.origin, trace["<dev string:x23c>"], (1, 0, 0), 1, 0, 1);
    print3d(self.origin + (0, 0, 60), "<dev string:x24b>" + trace["<dev string:x233>"], (1, 1, 1), 1, 1, 1);
    wait 0.05;
  }
}

function print3d_on_me(txt, duration) {
  self endon("death");
  duration *= 1000;
  time = gettime();

  while(gettime() < time + duration) {
    print3d(self.origin + (0, 0, 60), txt, (1, 0.5, 0.8), 1, 0.5, 1);

    wait 0.05;
  }
}

function get_door_audio_material() {
  var_702d68f1ec16e21c = self.script_sound_type;

  if(!isDefined(var_702d68f1ec16e21c)) {
    var_702d68f1ec16e21c = "wood_heavy";
    println("<dev string:x252>");
  }

  return var_702d68f1ec16e21c;
}

function double_doors_init_auto() {
  foreach(door in level.interactive_doors.ents) {
    var_1bd9abf0a34e2ab9 = getentarrayinradius("interactive_door", "script_noteworthy", door.origin, 150);
    doorfwd = anglesToForward(door.angles);

    foreach(otherdoor in var_1bd9abf0a34e2ab9) {
      if(otherdoor == door) {
        continue;
      }

      if(isDefined(otherdoor.doubledoors)) {
        continue;
      }

      if(vectordot(anglesToForward(otherdoor.angles), doorfwd) < -0.99) {
        scripts\sp\door::double_doors_init(door, otherdoor);
        break;
      }
    }
  }
}

function double_doors_waittill_interact() {
  self notify("double_doors_waittill_interact");
  self endon("double_doors_waittill_interact");
  self endon("bashed");
  self endon("open_completely");
  self waittill("first_interact");
  self.doubledoorother notify("first_interact");
}

function double_doors_waittill_bashed() {
  self notify("double_doors_waittill_bashed");
  self endon("double_doors_waittill_bashed");
  self endon("first_interact");
  self endon("open_completely");

  while(true) {
    self waittill("attempt_bash", opener);
    self.doubledoorother thread scripts\sp\door::door_bash_open(opener);

    if(!self.locked) {
      return;
    }
  }
}

function double_doors_waittill_open_completely() {
  self notify("double_doors_waittill_open_completely");
  self endon("double_doors_waittill_open_completely");
  self endon("first_interact");
  self endon("bashed");
  self.doubledoorother endon("open_completely");
  self.doubledoorother endon("opened_completely");
  self waittill("opened_completely", opener);
  self.doubledoorother thread scripts\sp\door::door_open_completely(opener);
}

function double_doors_hint_pos(door_other) {
  flag_wait("interactive_doors_ready_internal");
  struct = spawnStruct();
  struct.origin = math::get_mid_point(self.open_struct.origin, door_other.open_struct.origin);
  scripts\sp\door::remove_open_prompts();
  struct.door = self;

  if(isDefined(self.open_struct) && isDefined(self.open_struct.radius)) {
    struct.radius = self.open_struct.radius;
  }

  self.open_struct = struct;
  setup_open_struct(struct);
  thread cursor_hint_thread();
}

function door_watch_unresolved_collision() {
  self endon("death");

  for(;;) {
    if(isDefined(self.door_unresolved_collision_count) && self.door_unresolved_collision_count >= 3) {
      if(!isDefined(self.notsolid)) {
        if(getdvarint(@ "hash_6985e82f27803483")) {
          print("<dev string:x2d8>" + gettime());
          print3d(level.player.origin, "<dev string:x2fc>", (1, 0, 0), 1, 0.25, 1000, 1);
          debugaxis(level.player.origin, level.player getplayerangles(1), 8, undefined, 0, 1000);
          line(level.player.origin, self.origin, (1, 0, 0), 1, 0, 1000);
        }

        self notsolid();
        self.notsolid = 1;
        self.door_unresolved_collision_origin = self.origin;
      } else if(isDefined(self.notsolid) && !level.player istouching(self)) {
        if(getdvarint(@ "hash_6985e82f27803483")) {
          print("<dev string:x302>" + gettime());
          print3d(level.player.origin, "<dev string:x32c>", (0, 1, 0), 1, 0.25, 1000, 1);
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
  self endon("death");

  while(true) {
    self waittill("unresolved_collision", mover);

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