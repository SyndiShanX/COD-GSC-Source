/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\door_internal.gsc
***********************************************/

door_post_load() {
  init_doors();
  thread trace_completion_thread();
}

init_window() {
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_linkto)) {
      continue;
    }
    var_3 = var_2 scripts\engine\utility::get_linked_ent();
    var_3 linkTo(var_2);
  }

  var_5 = scripts\engine\utility::get_linked_nodes();

  foreach(var_7 in var_5) {
    if(scripts\engine\utility::is_equal(var_7.targetname, "traverse")) {
      destroynavlink(var_7);
      continue;
    }

    if(scripts\engine\utility::is_equal(var_7.script_noteworthy, "cover"))
      var_7 disconnectnode();
  }

  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"GAME/DOOR_OPEN", 55, 135 * level.interactive_doors.hint_dist_scale, 85 * level.interactive_doors.hint_dist_scale, 1);
  self.cursor_hint_ent setusewhenhandsoccupied(1);
  var_9 = waittill_window_event();
  scripts\sp\player\cursor_hint::remove_cursor_hint();

  if(var_9 == "trigger") {
    thread player_window_gesture(0.65);
    var_10 = 0.8;
    var_11 = "door_open_ajar";
  } else {
    door_bash_presentation();
    var_10 = 0.35;
    var_11 = "door_open_bash";
  }

  scripts\stealth\event::event_broadcast_axis_by_tacsight("window_open", level.player, level.player.origin, 384, 80);

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "delete_on_open")) {
      var_2 delete();
      continue;
    }

    var_13 = var_2.angles;
    var_14 = var_2.origin - level.player.origin;
    var_15 = anglesToForward(var_13);
    var_16 = vectordot(var_14, var_15);
    var_17 = scripts\engine\utility::ter_op(var_16 > 0, anglestoright(var_13), anglestoleft(var_13));
    var_18 = vectortoangles(var_17);
    var_19 = anglelerpquatfrac(var_13, var_18, randomfloatrange(1.0, 1.15));
    var_2 rotateTo(var_19, var_10, var_10 * 0.8, var_10 * 0.2);
    var_2 playSound(var_11);

    if(var_9 == "melee_pressed") {
      if(isDefined(level.stealth))
        thread stealth_broadcast(450, "combat");
      else
        thread combat_getinfoinradius(450);

      var_2 scripts\engine\utility::delaycall(var_10, ::rotateto, var_18, randomfloatrange(0.75, 1.25));
      var_2 scripts\engine\utility::delaycall(var_10, ::playsound, "door_open_stop");
      self notify("trigger");
    }
  }

  foreach(var_7 in var_5) {
    if(scripts\engine\utility::is_equal(var_7.targetname, "traverse")) {
      var_22 = getnode(var_7.target, "targetname");
      createnavlink("window_traversal", var_7.origin, var_22.origin, var_7);
      continue;
    }

    if(scripts\engine\utility::is_equal(var_7.script_noteworthy, "cover"))
      var_7 connectnode();
  }
}

waittill_window_event() {
  for(;;) {
    var_0 = waittill_melee_or_interact();

    if(!isDefined(var_0) || window_melee_valid(self.origin))
      return scripts\engine\utility::ter_op(!isDefined(var_0), "trigger", "melee_pressed");
  }
}

waittill_melee_or_interact() {
  self endon("trigger");
  waitframe();

  while(!level.player ismeleeing())
    waitframe();

  return 1;
}

window_melee_valid(var_0) {
  if(distancesquared(level.player getEye(), var_0) > 2025)
    return 0;

  if(!scripts\engine\utility::within_fov(level.player.origin + anglesToForward(level.player.angles) * -50, level.player.angles, var_0, 0.731353))
    return 0;

  return 1;
}

init_doors() {
  var_0 = getEntArray("interactive_door", "script_noteworthy");

  if(var_0.size > 0)
    global_door_threads();

  scripts\engine\utility::array_thread(var_0, level.interactive_doors.fndoorinit);
}

global_door_threads() {
  if(isDefined(level.doors_initialized)) {
    return;
  }
  if(scripts\sp\starts::is_no_game_start()) {
    return;
  }
  level.doors_initialized = 1;
  scripts\engine\utility::array_thread(getaiarray(), scripts\sp\door::ai_monitor_doors);
  scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\sp\door::ai_monitor_doors);
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\sp\door::ai_monitor_doors);
  scripts\engine\sp\utility::add_global_spawn_function("neutral", scripts\sp\door::ai_monitor_doors);
  scripts\engine\sp\utility::add_global_spawn_function("team3", scripts\sp\door::ai_monitor_doors);
}

init_door_internal(var_0) {
  if(!istrue(var_0)) {}

  self.pivots = [];
  self.closed_angles = (0, 0, 0);
  self.openers = [];
  self.tryingopener = undefined;
  self.true_start_angles = undefined;
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

  if(!isDefined(self.locked))
    self.locked = 0;

  if(!scripts\engine\utility::ent_flag_exist("initialized"))
    scripts\engine\utility::ent_flag_init("initialized");

  if(istrue(var_0))
    self.script_spawn_open_yaw = undefined;
  else
    level.interactive_doors.ents[level.interactive_doors.ents.size] = self;

  var_1 = scripts\engine\utility::get_linked_ents();
  var_2 = scripts\engine\utility::get_linked_structs();
  var_3 = 1;

  if(isDefined(self.script_parameters)) {
    var_4 = strtok(self.script_parameters, " ");

    foreach(var_6 in var_4) {
      switch (var_6) {
        case "locked":
          if(!istrue(var_0))
            self.locked = 1;

          break;
        case "no_open":
          var_3 = 0;
          break;
        case "no_bash":
          self.no_bash = 1;
          break;
        case "no_handle_ajar":
          self.no_handle_ajar = 1;
          break;
      }
    }
  }

  foreach(var_9 in var_1) {
    if(isDefined(var_9.script_noteworthy)) {
      var_9.door = self;

      switch (var_9.script_noteworthy) {
        case "clip":
          self.clip = var_9;
          var_9 linkTo(self);
          var_9.doorclip = 1;
          break;
        case "clip_nosight":
          self.clip_nosight = var_9;
          var_9 linkTo(self);
          var_9.doorclip = 1;
          break;
        case "unlock_volume":
          self.unlock_volume = var_9;
          var_9 thread unlock_volume_logic();
          break;
        case "link":
          if(!isDefined(self.linked_ents))
            self.linked_ents = [];

          self.linked_ents[self.linked_ents.size] = var_9;
          var_9 linkTo(self);
          var_9.doorclip = 1;
          break;
      }
    }
  }

  foreach(var_12 in var_2) {
    if(isDefined(var_12.script_noteworthy)) {
      var_12.door = self;

      switch (var_12.script_noteworthy) {
        case "open_hint":
          self.true_start_angles = var_12.angles;
          self.open_struct = var_12;
          self.length = distance2d(self.origin, self.open_struct.origin);

          if(var_3)
            setup_open_struct(var_12);

          break;
        case "pivot_left":
          self.pivots["open_left"] = var_12;
          break;
        case "pivot_right":
          self.pivots["open_right"] = var_12;
          break;
        case "ai_open_walk":
          self.ai_anim_start["walk"] = rotatevectorinverted(var_12.origin - self.origin, self.true_start_angles);
          break;
        case "ai_open_run":
          self.ai_anim_start["run"] = rotatevectorinverted(var_12.origin - self.origin, self.true_start_angles);
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
  self.team = scripts\engine\utility::ter_op(isDefined(self.script_team), self.script_team, "");
  get_door_bottom_center();
  initlinkednodes();
  updatenodelookpeek();
  scripts\sp\door_scriptable::init_destructible();

  if(self.classname != "script_model" && !isDefined(self.clip) && !is_clip_nosight()) {
    self.clip = self;
    self.clip.doorclip = 1;
  }

  var_14 = strtok(var_2[0].script_linkname, "_")[0];
  createinitialnavmodifier(var_14);
  self.clip connectpaths();

  if(self.locked)
    scripts\sp\door::create_navobstacle();

  self.nav_lastupdatetime = gettime();
  self.nav_lastupdateangle = self.true_start_angles[1];

  if(!isDefined(self.script_spawn_open_yaw) || istrue(level.interactive_doors.close_prompt))
    thread cursor_hint_thread();

  thread scripts\sp\door::init_max_yaws();
  thread door_open_think();

  if(isDefined(self.doubledoors))
    scripts\sp\door::double_doors_init(self.doubledoors[0], self.doubledoors[1]);
}

is_clip_nosight() {
  return isDefined(self.script_noteworthy) && self.script_noteworthy == "clip_nosight";
}

cursor_hint_thread(var_0) {
  self notify("cursor_hint_thread");
  self endon("cursor_hint_thread");
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_cursor_hint_thread");
  self.prevplayeronright = -1;
  self.playeronright = -1;
  self.cursorhintdir = (0, 0, 0);
  var_1 = isDefined(self.open_struct);

  for(;;) {
    waitframe();
    set_player_side();

    if(!var_1 && has_cursor_hint(self.open_struct) || cursor_refresh(self.open_struct)) {
      var_1 = 1;
      self.prevplayeronright = -1;
    }

    if(self.prevplayeronright != self.playeronright) {
      if(isDefined(self.open_struct))
        adjust_cursor_hint_side(self.open_struct);
    }

    if(var_1)
      var_1 = has_cursor_hint(self.open_struct);

    if(isDefined(var_0))
      self[[var_0]]();
  }
}

cursor_refresh(var_0) {
  if(isDefined(var_0.refresh)) {
    var_0.refresh = undefined;
    return 1;
  }

  return 0;
}

has_cursor_hint(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isarray(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2.cursor_hint_ent))
        return 1;
    }
  } else
    return isDefined(var_0.cursor_hint_ent);

  return 0;
}

adjust_cursor_hint_side(var_0) {
  if(!isDefined(var_0.cursor_hint_ent)) {
    return;
  }
  var_1 = var_0.origin;
  var_2 = scripts\sp\door::get_door_angles() - self.true_start_angles;

  if(abs(var_2[1]) > 0.01 && isDefined(self.pivot_ent)) {
    var_3 = var_1 - self.pivot_ent.origin;
    var_3 = rotatevectorinverted(var_3, self.true_start_angles);
    var_3 = rotatevector(var_3, self.pivot_ent.angles);
    var_1 = var_3 + self.pivot_ent.origin;
  }

  var_1 = var_1 + self.cursorhintdir * var_0.radius;
  var_0.cursor_hint_ent dontinterpolate();
  var_0.cursor_hint_ent.origin = var_1;
}

get_player_on_right() {
  var_0 = vectortoangles(self.forward);

  if(isDefined(self.pivot_ent))
    var_0 = self.pivot_ent.angles;

  var_1 = anglestoright(var_0);
  var_2 = vectorNormalize(level.player.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > 0)
    return [0, var_1];
  else
    return [1, var_1 * -1];
}

set_player_side() {
  var_0 = get_player_on_right();
  self.prevplayeronright = self.playeronright;
  self.playeronright = var_0[0];
  self.cursorhintdir = var_0[1];
}

trace_completion_thread() {
  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.interactive_doors.ents) {
      if(!isDefined(var_2.max_yaw_left) || !isDefined(var_2.max_yaw_right)) {
        var_0 = 1;
        waitframe();
        break;
      }
    }

    if(!var_0) {
      break;
    }
  }

  scripts\engine\utility::flag_set("interactive_doors_ready");
}

get_hint_dist(var_0) {
  if(isDefined(level.interactive_doors.hint_dist_scale))
    return var_0 * level.interactive_doors.hint_dist_scale;

  return var_0;
}

door_dmg() {
  self endon("entitydeleted");
  self setCanDamage(1);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    self waittill("damage", var_0, var_1, var_4, var_4, var_2, var_4, var_4, var_4, var_4, var_5);
    var_6 = "none";

    if(isDefined(var_5))
      var_6 = var_5.basename;

    var_3 = scripts\engine\utility::ter_op(isDefined(var_1) && isDefined(var_1.classname), var_1.classname, "unknown");
    self.debug_activity = var_0 + " " + var_2 + " dmg taken from " + var_3 + " with weapon " + var_6;
  }
}

unlock_volume_logic() {
  var_0 = self.door;

  if(isDefined(var_0.doubledoors))
    var_0 = var_0.doubledoors[0];

  if(!var_0.locked) {
    return;
  }
  self.active = 1;
  var_0 endon("first_interact");
  var_0 endon("ai_opened");
  var_0 endon("bashed");
  var_0 endon("detonate");
  var_0 endon("unlock_volume_logic");

  for(;;) {
    while(!level.player istouching(self) && (!isDefined(var_0.doubledoorother) || !isDefined(var_0.doubledoorother.unlock_volume) || !level.player istouching(var_0.doubledoorother.unlock_volume)))
      waitframe();

    var_0 scripts\sp\door::unlock_door();

    while(level.player istouching(self) || isDefined(var_0.doubledoorother) && isDefined(var_0.doubledoorother.unlock_volume) && level.player istouching(var_0.doubledoorother.unlock_volume))
      waitframe();

    var_0 scripts\sp\door::lock_door();
  }
}

refresh_open_struct() {
  self.refresh = 1;
}

door_open_think() {
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_open_ability");
  self endon("ai_opened");
  self notify("unusable");

  if(!isDefined(self.script_spawn_open_yaw)) {
    thread scripts\sp\door::bash_monitor();
    waittill_first_interact_or_bash();
  } else
    thread scripts\sp\door::door_ajar();

  if(!self.bashed_full) {
    thread monitor_door_push();
    waittill_second_interact_or_bash();
  }

  scripts\sp\door::remove_open_ability();
}

get_max_yaw(var_0) {
  var_1 = 70;
  var_2 = 30;
  var_3 = 5;

  if(var_0) {
    if(isDefined(self.script_max_left_angle)) {
      self.max_yaw_left = self.script_max_left_angle;
      return;
    }
  } else if(isDefined(self.script_max_right_angle)) {
    self.max_yaw_right = self.script_max_right_angle;
    return;
  }

  var_4 = get_max_yaw_internal(var_1, var_2, var_0);
  var_4 = var_4 + var_3;
  var_5 = get_max_yaw_internal(var_4, var_3, var_0);

  if(var_0)
    self.max_yaw_left = var_5;
  else
    self.max_yaw_right = var_5;
}

get_max_yaw_internal(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = scripts\engine\trace::create_default_contents(1);

  while(!var_4) {
    if(var_0 > 179)
      return 179;

    var_7 = yaw_collision_check(var_0, var_2, var_6);

    if(var_7) {
      if(var_3)
        var_8 = 1;

      var_0 = var_0 + var_1;
    } else {
      if(!var_3)
        var_3 = 1;

      var_0 = var_0 - var_1;
      var_4 = 1;
    }

    var_5++;

    if(var_5 == 3) {
      var_5 = 0;
      wait 0.05;
    }
  }

  return var_0;
}

yaw_collision_check(var_0, var_1, var_2) {
  var_3 = 100;

  if(var_1)
    var_3 = var_3 * -1;
  else
    var_0 = var_0 * -1;

  var_4 = self.true_start_angles + (0, var_0, 0);

  if(var_1)
    var_5 = self.pivots["open_left"].origin + (0, 0, 2);
  else
    var_5 = self.pivots["open_right"].origin + (0, 0, 2);

  var_6 = var_5 + anglesToForward(var_4) * self.length * 0.2;
  var_7 = var_6 + anglestoright(var_4) * var_3;
  var_8 = scripts\engine\trace::capsule_trace(var_6, var_7, 6, 80, var_4, [self, self.clip], var_2, 0);
  var_9 = distance2d(var_6, var_8["position"]);

  if(var_9 > 3) {
    var_6 = var_5 + anglesToForward(var_4) * self.length * 0.9;
    var_8 = scripts\engine\trace::capsule_trace(var_6, var_7, 6, 80, var_4, [self, self.clip], var_2, 0);
    var_9 = distance2d(var_6, var_8["position"]);
    return var_9 > 5;
  }

  return 0;
}

draw_max_yaw(var_0) {
  var_1 = undefined;

  if(var_0) {
    var_1 = self.max_yaw_left;
    var_2 = self.pivots["open_left"].origin;
  } else {
    var_1 = self.max_yaw_right * -1;
    var_2 = self.pivots["open_right"].origin;
  }

  var_3 = self.true_start_angles + (0, var_1, 0);
  var_4 = var_2 + anglesToForward(var_3) * self.length;
}

try_door_hint() {
  self endon("door_close");

  if(istrue(self.nohint)) {
    return;
  }
  if(!scripts\engine\utility::flag("did_door_hint")) {
    thread display_hint_dist_check();

    while(level.player useButtonPressed() || isDefined(level.player getplayeruseentity()) || isDefined(self.hint_delay_until) && gettime() < self.hint_delay_until)
      waitframe();

    wait 0.25;

    if(!scripts\engine\utility::flag("door_second_interact") && !scripts\engine\utility::flag("door_exceed_hint_dist") && !istrue(self.bashed)) {
      scripts\engine\utility::flag_set("did_door_hint");
      thread scripts\engine\sp\utility::display_hint("door_hint_1", undefined, undefined, self, "bashed");
    }
  }
}

first_hint_func() {
  if(scripts\engine\utility::flag("door_second_interact"))
    return 1;

  if(scripts\engine\utility::flag("door_exceed_hint_dist"))
    return 1;

  if(isDefined(level.player getplayeruseentity()))
    return 1;

  return 0;
}

display_hint_dist_check() {
  self notify("display_hint_dist_check");
  self endon("display_hint_dist_check");
  self endon("death");
  level.player endon("death");
  self endon("reset_door");
  scripts\engine\utility::flag_clear("door_exceed_hint_dist");

  while(distancesquared(self.origin, level.player.origin) < squared(165))
    wait 0.1;

  scripts\engine\utility::flag_set("door_exceed_hint_dist");
}

waittill_first_interact_or_bash() {
  self endon("entitydeleted");
  self endon("bashed");
  self endon("open_completely");
  self waittill("first_interact");
  thread scripts\sp\door::door_ajar();
}

waittill_second_interact_or_bash() {
  self endon("bashed");
  self waittill("open_completely");

  if(getdvarint("scr_use_door_gesture")) {
    thread player_door_gesture(1);
    wait 0.1;
  }

  level.player playRumbleOnEntity("damage_light");
  earthquake(0.13, 0.2, level.player.origin, 200);
  thread scripts\sp\door::door_open_completely();
}

can_pivot_change() {
  if(isDefined(self.pivot_ent) && isDefined(self.current_pivot_struct) && self.pivot_ent.angles != self.current_pivot_struct.angles)
    return 0;

  return 1;
}

set_pivot_point(var_0) {
  if(!can_pivot_change()) {
    if(issubstr(self.current_pivot_struct.script_noteworthy, "pivot_left"))
      self.hinge_side = "open_left";
    else
      self.hinge_side = "open_right";

    return;
  }

  if(var_0)
    var_1 = "open_left";
  else
    var_1 = "open_right";

  self.hinge_side = var_1;

  if(!isDefined(self.current_pivot_struct) || self.current_pivot_struct != self.pivots[var_1]) {
    self.current_pivot_struct = self.pivots[var_1];

    if(self islinked())
      self unlink();

    if(!isDefined(self.pivot_ent))
      self.pivot_ent = scripts\engine\utility::spawn_script_origin(self.current_pivot_struct.origin, self.true_start_angles);
    else {
      self.pivot_ent dontinterpolate();
      self.pivot_ent.origin = self.current_pivot_struct.origin;
    }

    wait 0.05;
    self linkTo(self.pivot_ent);
  }
}

monitor_open_completely() {
  self endon("open_completely");
  self endon("stop_monitoring_open_completely");
  self endon("entitydeleted");
  self endon("reset_door");

  while(level.player useButtonPressed())
    wait 0.05;

  for(;;) {
    if(!istrue(self.bashed) && scripts\sp\door::bash_door_isplayerclose() && level.player useButtonPressed() && !isDefined(level.player getplayeruseentity()) && pushents_clear()) {
      if(!scripts\engine\utility::flag("door_second_interact"))
        scripts\engine\utility::flag_set("door_second_interact");

      self notify("open_completely");
    }

    wait 0.05;
  }
}

pushents_clear() {
  if(isDefined(self.pushents)) {
    var_0 = self.pushents;
    var_0 = sortbydistance(var_0, self.origin);

    if(distancesquared(self.origin, var_0[0].origin) < 6400) {
      var_1 = self.origin;
      var_2 = vectortoangles(self.forward);
      var_3 = anglestoright(var_2);
      var_4 = vectorNormalize(var_0[0].origin - var_1);
      var_5 = vectordot(var_3, var_4);
      self.bashblocked = 1;

      if(var_5 > 0)
        return 0;
    }
  }

  return 1;
}

setup_open_struct(var_0) {
  if(!isDefined(var_0.radius))
    var_0.radius = 2.5;

  if(!isDefined(self.script_spawn_open_yaw))
    var_0 thread open_struct_logic();
}

open_struct_logic() {
  self.door endon("stop_open_ability");
  self.door endon("stop_open_interact");

  if(!isDefined(self.openinteract))
    self.openinteract = 0;

  scripts\sp\door::create_open_interact_hint();

  for(;;) {
    self waittill("trigger");
    self notify("stop_cursor_hint_thread");
    self.door notify("trigger");
    level.player notify("door_trigger", self.door);

    if(getdvarint("scr_use_door_gesture"))
      thread player_door_gesture();

    if(!self.door.locked) {
      break;
    } else {
      if(getdvarint("scr_use_door_gesture"))
        wait 0.1;

      if(isDefined(self.door.script_sound_type) && self.door.script_sound_type == "metal_heavy")
        thread scripts\engine\utility::play_sound_in_space("scrpt_door_metal_open_locked", self.cursor_hint_ent.origin);
      else
        thread scripts\engine\utility::play_sound_in_space("scrpt_door_wood_open_locked", self.cursor_hint_ent.origin);

      level.player playRumbleOnEntity("damage_heavy");
      earthquake(0.17, 0.2, level.player.origin, 200);
      self.door notify("locked");
      return;
    }
  }

  scripts\sp\door::remove_open_interact_hint();

  if(getdvarint("scr_use_door_gesture"))
    wait 0.1;
  else if(isDefined(self.door.destructible))
    self.door setscriptablepartstate("main", "open_handle");

  self.door notify("first_interact");

  if(!scripts\engine\utility::flag("door_first_interact"))
    scripts\engine\utility::flag_set("door_first_interact");
}

should_do_gesture() {
  return !nullweapon(level.player getcurrentweapon());
}

player_door_gesture(var_0) {
  self notify("player_door_gesture");
  self endon("player_door_gesture");

  if(isDefined(var_0) && var_0)
    var_1 = level.interactive_doors.gesture_door_hard;
  else
    var_1 = level.interactive_doors.gesture_door;

  thread pushplayertodoor();
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = self.origin;

  if([[level.interactive_doors.fnshoulddogesture]]()) {
    level.player playgestureviewmodel(var_1, var_2);
    wait(level.player getgestureanimlength(var_1));
  }

  var_2 delete();
}

pushplayertodoor() {
  var_0 = 0.04;
  var_1 = 0.2;
  var_2 = 0;
  level.player thread scripts\engine\sp\utility::blend_movespeedscale(0.1, 0.3, "doorOpen");

  while(var_2 < 0.99) {
    if(!isDefined(self)) {
      break;
    }

    pushlogic(var_2);
    var_2 = var_2 + var_1;
    wait 0.05;
  }

  var_2 = 1;
  level.player thread scripts\engine\sp\utility::blend_movespeedscale(1.0, 0.7, "doorOpen");

  while(var_2 > 0.01) {
    if(!isDefined(self)) {
      break;
    }

    pushlogic(var_2);
    var_2 = var_2 - var_0;
    wait 0.05;
  }

  level.player pushplayervector((0, 0, 0));
}

pushlogic(var_0) {
  var_1 = self.origin - level.player getEye();
  var_2 = length(var_1);
  var_3 = scripts\engine\math::normalize_value(20, 50, var_2);
  var_4 = scripts\engine\math::factor_value(5, 11, var_3);
  var_5 = vectorNormalize(var_1);
  var_6 = var_0 * var_4;
  level.player pushplayervector(var_5 * var_6);
}

player_window_gesture(var_0) {
  self notify("player_window_gesture");
  self endon("player_window_gesture");
  var_1 = level.interactive_doors.gesture_window;

  if([[level.interactive_doors.fnshoulddogesture]]()) {
    var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
    level.player playgestureviewmodel(var_1);
    wait(var_0);
  }

  level.player stopgestureviewmodel(var_1, 2);
}

door_bashable_by_player(var_0) {
  if(istrue(self.no_bash) || istrue(self.was_opened_halfway) || istrue(self.open_completely) || istrue(self.bashed))
    return 0;

  if(istrue(var_0))
    return 1;

  if(nullweapon(level.player getcurrentweapon()))
    return 0;

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_center(), 0.82))
    return 1;
  else {}

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_handle(), 0.82))
    return 1;
  else {}

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_origin(), 0.82))
    return 1;
  else {}

  return 0;
}

should_bash_open() {
  thread bash_debug(1);

  if(door_bashable_by_player()) {
    if(level.player ismeleeing()) {
      thread bash_debug(2000);
      return 1;
    }

    if(!level.player issprinting())
      return 0;

    if(getdvarint("scr_door_bash_requires_use")) {
      if(!level.player useButtonPressed())
        return 0;
    }

    var_0 = length(level.player getvelocity());

    if(var_0 < 50)
      return 0;

    var_1 = vectorNormalize(level.player getEye() - get_door_center());
    var_2 = vectordot(var_1, anglesToForward(scripts\sp\door::get_door_angles()));

    if(abs(var_2) > 0.4)
      return 0;

    self.bashscale = scripts\engine\math::lerp_fraction(50, 195, var_0);
    thread bash_debug(2000);
    return 1;
  }

  return 0;
}

bash_debug(var_0) {}

stealth_broadcast(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 500);
  var_3 = scripts\engine\sp\utility::get_all_closest_living(self.origin, getaiarray("axis"), var_2, 0);

  if(!var_3.size) {
    return;
  }
  foreach(var_5 in var_3) {
    if(isDefined(var_5.stealth))
      var_5 aieventlistenerevent(var_1, level.player, self.origin);
  }
}

combat_getinfoinradius(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 500);
  var_2 = scripts\engine\sp\utility::get_all_closest_living(self.origin, getaiarray("axis"), var_1, 0);

  if(!var_2.size) {
    return;
  }
  foreach(var_4 in var_2)
  var_4 getenemyinfo(level.player);
}

get_bash_yaw(var_0) {
  if(self.open_left) {
    var_1 = self.max_yaw_left;

    if(var_0 < 1) {
      var_1 = scripts\engine\math::factor_value(55, 170, var_0);
      var_1 = min(var_1, self.max_yaw_left);
    }

    var_2 = self.true_start_angles[1] + var_1;
  } else {
    var_3 = self.max_yaw_right;

    if(var_0 < 1) {
      var_3 = scripts\engine\math::factor_value(55, 170, var_0);
      var_3 = min(var_3, self.max_yaw_right);
    }

    var_2 = self.true_start_angles[1] - var_3;
  }

  if(isDefined(self.pushents)) {
    var_4 = self.pushents;
    var_4 = sortbydistance(var_4, self.origin);

    if(distancesquared(self.origin, var_4[0].origin) < 6400) {
      var_5 = self.origin;
      var_6 = vectortoangles(self.forward);
      var_7 = anglestoright(var_6);
      var_8 = vectorNormalize(var_4[0].origin - var_5);
      var_9 = vectordot(var_7, var_8);
      self.bashblocked = 1;

      if(var_9 > 0)
        var_2 = self.true_start_angles[1] - 4;
      else
        var_2 = self.true_start_angles[1] + 4;
    }
  }

  return var_2;
}

bashed_locked_door(var_0) {
  level.player endon("death");

  if(isDefined(self.isbashing)) {
    return;
  }
  self.isbashing = 1;
  thread bashed_locked_door_sfx();
  self notify("trigger");
  self notify("bashing_while_locked");
  thread scripts\sp\door::remove_open_prompts();
  level.player viewkick(10, get_door_center(), 0);
  earthquake(1, 0.3, level.player.origin, 75);
  level.player playRumbleOnEntity("heavy_1s");

  while(level.player ismeleeing())
    waitframe();

  self.isbashing = undefined;
}

bashed_locked_door_sfx() {
  if(!isDefined(self.bashedsfx)) {
    self.bashedsfx = 1;
    var_0 = spawn("script_origin", self.origin + (0, 0, 42));
    var_0 playSound("door_locked_bashed", "sounddone");

    if(randomint(100) < 40)
      level.player playSound("breathing_limp");

    var_0 waittill("sounddone");
    var_0 delete();
    self.bashedsfx = undefined;
  }
}

door_bash_presentation() {
  screenshake(level.player.origin, 16, 0, 0, 0.45);
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.6, 0.75, level.player.origin, 200);
}

close_prompt(var_0) {
  self notify("close_prompt");
  self endon("close_prompt");
  self endon("reset_door");
  self endon("entitydeleted");

  if(!istrue(level.interactive_doors.close_prompt)) {
    return;
  }
  scripts\engine\utility::flag_wait("interactive_doors_ready");

  if(isDefined(var_0))
    wait(var_0);

  for(;;) {
    self.open_struct thread scripts\sp\door::create_open_interact_hint(&"SCRIPT/DOOR_HINT_CLOSE");
    thread cursor_hint_thread();
    waitframe();
    self.open_struct waittill("trigger");

    if(!close_check()) {
      thread scripts\engine\sp\utility::display_hint("door_hint_obstructed", 1);
      wait 1;
      continue;
    }

    self notify("stop_monitoring_open_completely");

    if(isDefined(self.doubledoorother))
      self.doubledoorother notify("stop_monitoring_open_completely");

    thread player_door_gesture();

    if(isDefined(self.doubledoorother)) {
      self.doubledoorother thread scripts\sp\door::remove_open_prompts();
      self.doubledoorother thread scripts\sp\door::door_close();
    }

    scripts\sp\door::door_close();
    waitframe();

    if(isDefined(self.doubledoorother))
      self.doubledoorother thread scripts\sp\door::reset_door();

    thread scripts\sp\door::reset_door();
  }
}

close_check() {
  var_0 = scripts\engine\trace::create_character_contents();
  var_1 = scripts\sp\door::get_door_angles()[1];
  var_2 = self.true_start_angles[1];
  var_3 = ceil(abs(var_2 - var_1) / 15);
  var_4 = self.current_pivot_struct == self.pivots["open_left"];

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_6 = var_1 + (var_2 - var_1) * var_5 / var_3;

    if(!yaw_collision_check(var_6, var_4, var_0))
      return 0;
  }

  return 1;
}

monitor_door_push(var_0) {
  self endon("reset_door");
  self endon("stop_push_open");
  self endon("bashed_full");
  self endon("entitydeleted");

  if(!isDefined(var_0))
    var_0 = 0.5;

  if(self.bashed) {
    wait(self.bashtime + 0.05);
    self.pivot_ent rotateTo(self.pivot_ent.angles, 0.05);
  } else if(var_0 > 0)
    wait(var_0);

  thread door_ease_in_open_input();

  for(;;) {
    if(scripts\sp\door::interact_door_ispushentclose())
      push_door();
    else if(istrue(self.isplayingpushsound)) {
      self.isplayingpushsound = 0;
      self notify("stop_door_creak");
    }

    waitframe();
  }
}

door_ease_in_open_input() {
  var_0 = 1;
  var_1 = var_0;
  self.masterdoorratescale = 0;

  for(;;) {
    if(!isDefined(self) || var_1 <= 0) {
      break;
    }

    self.masterdoorratescale = 1 - var_1 / var_0;
    wait 0.05;
    var_1 = var_1 - 0.05;
  }

  self.masterdoorratescale = 1;
}

get_pushent() {
  if(isDefined(self.pushents))
    var_0 = scripts\engine\utility::array_add(self.pushents, level.player);
  else
    return level.player;

  var_0 = sortbydistance(var_0, self.origin);
  return var_0[0];
}

push_door() {
  if(self.bashed_full) {
    return;
  }
  if(istrue(self.bash_opening)) {
    return;
  }
  var_0 = get_pushent();
  var_1 = 36;
  var_2 = 0;
  var_3 = 25;
  var_4 = interact_door_get_endpoint();
  var_5 = distance(var_0.origin, var_4);
  var_6 = scripts\engine\math::normalize_value(var_2, var_1, var_5);
  var_7 = var_3 * (1 - var_6);
  var_7 = var_7 * self.masterdoorratescale;
  var_8 = scripts\sp\door::should_open_left(self.pivot_ent.angles, var_0);

  if(abs(var_7) < 0.001) {
    return;
  }
  scripts\sp\door::remove_open_interact_hint();
  var_9 = scripts\sp\door::get_door_angles()[1];
  var_10 = scripts\engine\utility::ter_op(var_8 == 1, 1, -1);
  var_11 = var_9 + var_7 * var_10;

  if(var_8) {
    if(self.hinge_side == "open_left") {
      var_12 = scripts\sp\door::angle_diff(var_11, self.true_start_angles[1]);

      if(var_12 > self.max_yaw_left) {
        self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
        self.open_completely = 1;
        thread scripts\sp\door::updatenavobstacle();
        self notify("stop_push_open");
        return;
      }
    } else if(var_11 > self.true_start_angles[1]) {
      self.debug_activity = "Pushed back closed, right hinge";
      thread scripts\sp\door::reset_door();
      self notify("stop_push_open");
      return;
    }
  } else if(self.hinge_side == "open_right") {
    var_12 = abs(scripts\sp\door::angle_diff(var_11, self.true_start_angles[1]));

    if(var_12 > self.max_yaw_right) {
      self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
      self.open_completely = 1;
      thread scripts\sp\door::updatenavobstacle();
      self notify("stop_push_open");
      return;
    }
  } else if(var_11 < self.true_start_angles[1]) {
    self.debug_activity = "Pushed back closed, left hinge";
    thread scripts\sp\door::reset_door();
    self notify("stop_push_open");
    return;
  }

  if(var_7 > 0.4) {
    thread try_push_sound();

    if(!scripts\engine\utility::flag("door_second_interact"))
      scripts\engine\utility::flag_set("door_second_interact");
  } else if(istrue(self.isplayingpushsound)) {
    self.isplayingpushsound = 0;
    self notify("stop_door_creak");
  }

  self.pivot_ent.angles = (self.pivot_ent.angles[0], var_11, self.pivot_ent.angles[2]);
  self.forward = anglesToForward(self.pivot_ent.angles);

  if(door_is_half_open()) {
    if(!self.was_opened_halfway)
      thread suspicious_door_stealth_check(1);

    self.was_opened_halfway = 1;
    thread close_prompt(0.25);
  }

  updatenodelookpeek();
  var_13 = gettime();

  if(abs(angleclamp180(self.pivot_ent.angles[1] - self.nav_lastupdateangle)) > 20 && var_13 - self.nav_lastupdatetime > 250 || var_13 - self.nav_lastupdatetime > 1500)
    thread scripts\sp\door::updatenavobstacle(1);
}

push_door_player_effects() {
  var_0 = scripts\sp\door::should_open_left(self.pivot_ent.angles, level.player);
  var_1 = self.pivot_ent;
  var_2 = "doorPush" + self.doorid;

  if(!isDefined(self.dooroffset)) {
    self.dooroffset = (0, 0, 0);
    self.doorrot = (0, 0, 0);
    self.doorspeedscale = 1;
  }

  level.player notify("newoffset");
  level.player endon("newoffset");

  for(;;) {
    var_3 = door_get_pushspot();
    var_4 = (var_3[0], var_3[1], level.player.origin[2]) - level.player.origin;
    var_5 = vectorNormalize(var_4);
    var_6 = anglesToForward(level.player.angles);
    var_7 = vectorcross(var_6, var_5);
    var_8 = vectordot(var_6, var_5);
    var_9 = length(var_4);
    var_10 = level.player getnormalizedmovement();
    var_10 = (var_10[0], -1 * var_10[1], 0);
    var_11 = rotatevector(var_10, level.player.angles);
    var_12 = vectorNormalize(var_11);
    var_13 = vectordot(var_12, var_5);
    var_14 = clamp(length(var_11), 0, 1);

    if(var_7[2] > 0) {
      var_15 = (0, 4, 0);
      var_16 = (0, -5, 0);
    } else {
      var_15 = (0, -2, 0);
      var_16 = (0, 2, 0);
    }

    if(var_8 > 0) {
      if(var_0) {
        var_17 = (4, -1.5, 0);
        var_18 = (-6, 5, 1.5);
      } else {
        var_17 = (4, -1.5, 0);
        var_18 = (-6, -3, -1.5);
      }
    } else {
      var_17 = (-3, 0, 0);
      var_18 = (0, 0, 0);
    }

    var_19 = scripts\engine\math::normalize_value(0.6, 1.0, abs(var_8));
    var_19 = scripts\engine\math::normalized_float_smooth_in(var_19);
    var_20 = scripts\engine\math::factor_value(var_15, var_17, var_19);
    var_21 = scripts\engine\math::factor_value(var_16, var_18, var_19);
    var_22 = scripts\engine\math::normalize_value(0, 1, var_13);
    var_23 = scripts\engine\math::normalize_value(0, 0.5, var_14);
    var_24 = 1 - scripts\engine\math::normalize_value(20, 50, var_9);

    if(level.player isfiring())
      var_25 = 0.5;
    else
      var_25 = 1.0;

    var_26 = 1.0;
    var_26 = var_26 * var_22;
    var_26 = var_26 * var_23;
    var_26 = var_26 * var_24;
    var_26 = var_26 * var_25;
    var_20 = var_20 * var_26;
    var_21 = var_21 * var_26;

    if(length(var_20) > length(self.dooroffset))
      var_27 = 0.312;
    else
      var_27 = 0.234;

    var_28 = 1 - level.player playerads();

    if(level.player adsButtonPressed())
      var_28 = scripts\engine\math::normalize_value(0.8, 1.0, var_28);

    self.dooroffset = scripts\engine\math::lerp(self.dooroffset, var_20, var_27);
    self.doorrot = scripts\engine\math::lerp(self.doorrot, var_21, var_27);
    scripts\sp\player::player_apply_local_weap_position(self.dooroffset * var_28 * 1.0, 0, var_2);
    scripts\sp\player::player_apply_local_weap_rotation(self.doorrot * var_28 * 1.0, 0, var_2);
    var_29 = 1;
    var_22 = scripts\engine\math::normalize_value(0, 1, var_13);
    var_23 = scripts\engine\math::normalize_value(0, 0.01, var_14);
    var_24 = 1 - scripts\engine\math::normalize_value(25, 70, var_9);
    var_29 = var_29 * var_22;
    var_29 = var_29 * var_23;
    var_29 = var_29 * var_24;
    var_30 = scripts\engine\math::factor_value(1, 0.2, var_29);
    var_27 = 0.3;
    self.doorspeedscale = scripts\engine\math::lerp(self.doorspeedscale, var_30, var_27);
    level.player scripts\engine\sp\utility::blend_movespeedscale(self.doorspeedscale, 0, var_2);

    if(length(self.dooroffset) < 0.001 && self.doorspeedscale > 0.99) {
      break;
    }

    if(!isDefined(self)) {
      break;
    }

    wait 0.05;
    var_20 = (0, 0, 0);
  }

  if(isDefined(self)) {
    self.dooroffset = (0, 0, 0);
    self.doorrot = (0, 0, 0);
    self.doorspeedscale = 1;
  }

  scripts\sp\player::player_apply_local_weap_position((0, 0, 0), 0.2, var_2);
  scripts\sp\player::player_apply_local_weap_rotation((0, 0, 0), 0.2, var_2);
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 0, var_2);
}

door_get_pushspot() {
  var_0 = 12;
  var_1 = level.player.origin + anglesToForward(level.player.angles) * var_0;
  var_2 = interact_door_get_endpoint();
  var_3 = self.origin + self.forward * 5;
  var_4 = pointonsegmentnearesttopoint(var_3, var_2, var_1);
  return var_4;
}

initlinkednodes() {
  var_0 = get_door_bottom_center();
  var_1 = getnodesinradius(var_0, self.length * 0.5 + 32, 0, 80, "cover");

  if(var_1.size > 0) {
    self.linkednodes_hinge = [];
    self.linkednodes_knob = [];
    var_2 = undefined;

    if(isDefined(self.pivots["open_left"]))
      var_2 = self.pivots["open_left"].origin;
    else if(isDefined(self.pivots["open_right"]))
      var_2 = self.pivots["open_right"].origin;
    else {}

    var_3 = var_2 - var_0;

    foreach(var_5 in var_1) {
      var_6 = var_5.origin - var_0;

      if(vectordot(var_6, var_3) > 0) {
        self.linkednodes_hinge[self.linkednodes_hinge.size] = var_5;
        continue;
      }

      self.linkednodes_knob[self.linkednodes_knob.size] = var_5;
    }
  } else {
    self.linkednodes_hinge = undefined;
    self.linkednodes_knob = undefined;
  }
}

updatenodelookpeek() {
  var_0 = angleclamp180(scripts\sp\door::get_door_angles()[1]);
  var_1 = abs(angleclamp180(var_0 - self.true_start_angles[1]));

  if(isDefined(self.linkednodes_hinge)) {
    var_2 = anglesToForward((0, var_0, 0));

    foreach(var_4 in self.linkednodes_hinge) {
      if(var_1 > 90)
        var_4.allow_lookpeek = undefined;
      else
        var_4.allow_lookpeek = 0;

      if(var_1 > 80) {
        var_5 = anglesToForward(var_4.angles);

        if(vectordot(var_2, var_5) < 0)
          var_4 disconnectnode();
        else
          var_4 connectnode();

        continue;
      }

      var_4 connectnode();
    }
  }

  if(isDefined(self.linkednodes_knob)) {
    foreach(var_4 in self.linkednodes_knob) {
      if(var_1 > 45) {
        var_4.allow_lookpeek = undefined;
        continue;
      }

      var_4.allow_lookpeek = 0;
    }
  }
}

createinitialnavmodifier(var_0) {
  if(!isDefined(self.navmodifier)) {
    var_1 = var_0 + "_nav_modifier";
    self.navmodifier = createnavmodifier(var_1, "script_linkname");

    if(!isDefined(self.navmodifier))
      iprintln("Closed door has no nav modifier!");
    else {}
  }
}

suspicious_door_stealth_check(var_0) {
  if(!isDefined(level.stealth)) {
    return;
  }
  if(!getdvarint("scr_suspicious_stealth_doors") || !isDefined(level.stealth)) {
    return;
  }
  if(var_0)
    level.stealth.suspicious_door.doors[level.stealth.suspicious_door.doors.size] = self;
  else
    level.stealth.suspicious_door.doors = scripts\engine\utility::array_remove(level.stealth.suspicious_door.doors, self);
}

try_push_sound() {
  if(!isDefined(self.isplayingpushsound))
    self.isplayingpushsound = 0;

  if(!self.isplayingpushsound) {
    self.isplayingpushsound = 1;
    thread door_creak_sound();
  }
}

door_creak_sound() {
  self notify("stop stopping door creak");
  var_0 = get_door_audio_material();
  self scalevolume(1);
  var_1 = "scrpt_door_" + var_0 + "_creak_lp";

  if(soundexists(var_1))
    self playLoopSound(var_1);

  scripts\engine\utility::waittill_any("stop_door_creak", "stop_push_open");
  thread door_creak_sound_stop();
}

door_creak_sound_stop() {
  self endon("stop stopping door creak");
  self scalevolume(0, 0.5);
  wait 0.55;
  self stoploopsound();
}

interact_door_get_endpoint() {
  return self.origin + self.forward * self.length;
}

door_is_at_max_yaw(var_0) {
  var_1 = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);

  if(isDefined(var_0))
    return var_1 >= self.max_yaw_left || var_1 <= -1 * self.max_yaw_right;

  if(self.open_left)
    return var_1 >= self.max_yaw_left;
  else
    return var_1 <= -1 * self.max_yaw_right;
}

door_is_half_open() {
  var_0 = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);

  if(self.open_left)
    return var_0 >= self.max_yaw_left / 2;
  else
    return var_0 <= self.max_yaw_right / -2;
}

door_is_open_at_least(var_0) {
  var_1 = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);
  return abs(var_1) >= var_0;
}

get_door_center() {
  var_0 = scripts\sp\door::get_door_angles();
  self.doorcenter = self.origin + (0, 0, 55) + anglesToForward(var_0) * (self.length * 1.2) / 2;
  return self.doorcenter;
}

get_door_bottom_center() {
  self.doorbottomcenter = get_door_center();
  self.doorbottomcenter = (self.doorbottomcenter[0], self.doorbottomcenter[1], self.origin[2]);
  return self.doorbottomcenter;
}

get_door_bottom_handle() {
  var_0 = scripts\sp\door::get_door_angles();
  self.doorbottomhandle = self.origin + anglesToForward(var_0) * self.length;
  return self.doorbottomhandle;
}

get_door_bottom_origin() {
  self.doorbottomorigin = self.origin;
  return self.doorbottomorigin;
}

isnavpointaccesiblefrombehinddoor(var_0, var_1) {
  if(isDefined(var_1.doorbottomcenter))
    var_2 = var_1.doorbottomcenter;
  else
    var_2 = var_1.origin;

  var_3 = vectorNormalize(var_2 - self.origin);
  var_4 = var_2 + anglesToForward(vectortoangles(var_3)) * 7;
  var_5 = navtrace(var_4, var_0, self, 1);
  var_6 = (0, 1, 0);

  if(var_5["fraction"] < 0.88)
    var_6 = (1, 0, 0);

  iprintln(var_5["fraction"]);
  return var_5["fraction"] >= 0.9;
}

print_navtrace(var_0) {
  self endon("death");

  for(;;) {
    var_1 = navtrace(self.origin, var_0, self, 1);
    wait 0.05;
  }
}

print3d_on_me(var_0, var_1) {
  self endon("death");
  var_1 = var_1 * 1000;
  var_2 = gettime();

  while(gettime() < var_2 + var_1)
    wait 0.05;
}

get_door_audio_material() {
  var_0 = self.script_sound_type;

  if(!isDefined(var_0))
    var_0 = "wood_heavy";

  return var_0;
}

double_doors_init_auto() {
  foreach(var_1 in level.interactive_doors.ents) {
    var_2 = getentarrayinradius("interactive_door", "script_noteworthy", var_1.origin, 150);
    var_3 = anglesToForward(var_1.angles);

    foreach(var_5 in var_2) {
      if(var_5 == var_1) {
        continue;
      }
      if(isDefined(var_5.doubledoors)) {
        continue;
      }
      if(vectordot(anglesToForward(var_5.angles), var_3) < -0.99) {
        scripts\sp\door::double_doors_init(var_1, var_5);
        break;
      }
    }
  }
}

double_doors_waittill_interact() {
  self notify("double_doors_waittill_interact");
  self endon("double_doors_waittill_interact");
  self endon("bashed");
  self endon("open_completely");
  self waittill("first_interact");
  self.doubledoorother notify("first_interact");
}

double_doors_waittill_bashed() {
  self notify("double_doors_waittill_bashed");
  self endon("double_doors_waittill_bashed");
  self endon("first_interact");
  self endon("open_completely");

  for(;;) {
    self waittill("attempt_bash", var_0);
    self.doubledoorother thread scripts\sp\door::door_bash_open(var_0);

    if(!self.locked)
      return;
  }
}

double_doors_waittill_open_completely() {
  self notify("double_doors_waittill_open_completely");
  self endon("double_doors_waittill_open_completely");
  self endon("first_interact");
  self endon("bashed");
  self.doubledoorother endon("open_completely");
  self.doubledoorother endon("opened_completely");
  self waittill("opened_completely", var_0);
  self.doubledoorother thread scripts\sp\door::door_open_completely(var_0);
}

double_doors_hint_pos(var_0) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var_1 = spawnStruct();
  var_1.origin = scripts\engine\math::get_mid_point(self.open_struct.origin, var_0.open_struct.origin);
  scripts\sp\door::remove_open_prompts();
  var_1.door = self;
  self.open_struct = var_1;
  setup_open_struct(var_1);
  thread cursor_hint_thread();
}

door_watch_unresolved_collision() {
  self endon("death");

  for(;;) {
    if(isDefined(self.door_unresolved_collision_count) && self.door_unresolved_collision_count >= 3) {
      if(!isDefined(self.notsolid)) {
        self notsolid();
        self.notsolid = 1;
        self.door_unresolved_collision_origin = self.origin;
      } else if(isDefined(self.notsolid) && distance2dsquared(level.player.origin, self.door_unresolved_collision_origin) > 4096) {
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

door_watch_unresolved_collision_count() {
  self endon("death");

  for(;;) {
    self waittill("unresolved_collision", var_0);

    if(isDefined(var_0) && istrue(var_0.doorclip)) {
      if(!isDefined(var_0.door_unresolved_collision_count)) {
        var_0.door_unresolved_collision_count = 1;
        var_0.door_unresolved_collision_start_time = gettime();
        var_0 thread door_watch_unresolved_collision();
        continue;
      }

      var_0.door_unresolved_collision_count++;
    }
  }
}