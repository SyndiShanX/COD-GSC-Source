/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\door_internal.gsc
***********************************************/

function door_post_load() {
  init_doors();
  thread trace_completion_thread();
}

function init_window() {
  var0 = getEntArray(self.target, "targetname");

  foreach(var4, var2 in var0) {
    if(!isDefined(var2.script_linkto)) {
      continue;
    }

    var3 = var2 scripts\engine\utility::get_linked_ent();
    var3 linkTo(var2);
  }

  var5 = scripts\engine\utility::get_linked_nodes();

  foreach(var7 in var5) {
    if(scripts\engine\utility::is_equal(var7.targetname, "traverse")) {
      destroynavlink(var7);
      continue;
    }

    if(scripts\engine\utility::is_equal(var7.script_noteworthy, "cover")) {
      var7 disconnectnode();
    }
  }

  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"GAME/DOOR_OPEN", 55, 135 * level.interactive_doors.hint_dist_scale, 85 * level.interactive_doors.hint_dist_scale, 1);
  self.cursor_hint_ent setusewhenhandsoccupied(1);
  var9 = waittill_window_event();
  scripts\sp\player\cursor_hint::remove_cursor_hint();

  if(var9 == "trigger") {
    thread player_window_gesture(0.65);
    var10 = 0.8;
    var11 = "door_open_ajar";
  } else {
    door_bash_presentation();
    var10 = 0.35;
    var11 = "door_open_bash";
  }

  scripts\stealth\event::event_broadcast_axis_by_tacsight("window_open", level.player, level.player.origin, 384, 80);

  foreach(var4 in var2) {
    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "delete_on_open")) {
      var4 delete();
      continue;
    }

    var13 = var4.angles;
    var14 = var4.origin - level.player.origin;
    var15 = anglesToForward(var13);
    var16 = vectordot(var14, var15);
    var17 = scripts\engine\utility::ter_op(var16 > 0, anglestoright(var13), anglestoleft(var13));
    var18 = vectortoangles(var17);
    var19 = anglelerpquatfrac(var13, var18, randomfloatrange(1, 1.15));
    var4 rotateTo(var19, var10, var10 * 0.8, var10 * 0.2);
    var4 playSound(var11);

    if(var11 == "melee_pressed") {
      if(isDefined(level.stealth)) {
        thread stealth_broadcast(450, "combat");
      } else {
        thread combat_getinfoinradius(450);
      }

      var4 scripts\engine\utility::delaycall(var10, &rotateto, var18, randomfloatrange(0.75, 1.25));
      var4 scripts\engine\utility::delaycall(var10, &playsound, "door_open_stop");
      self notify("trigger");
    }
  }

  foreach(var9 in var7) {
    if(scripts\engine\utility::is_equal(var9.targetname, "traverse")) {
      var22 = getnode(var9.target, "targetname");
      createnavlink("window_traversal", var9.origin, var22.origin, var9);
      continue;
    }

    if(scripts\engine\utility::is_equal(var9.script_noteworthy, "cover")) {
      var9 connectnode();
    }
  }
}

function waittill_window_event() {
  for(;;) {
    var0 = waittill_melee_or_interact();

    if(!isDefined(var0) || window_melee_valid(self.origin)) {
      return scripts\engine\utility::ter_op(!isDefined(var0), "trigger", "melee_pressed");
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

function window_melee_valid(var0) {
  if(distancesquared(level.player getEye(), var0) > 2025) {
    return false;
  }

  if(!scripts\engine\utility::within_fov(level.player.origin + anglesToForward(level.player.angles) * -50, level.player.angles, var0, 0.731353)) {
    return false;
  }

  return true;
}

function init_doors() {
  var0 = getEntArray("interactive_door", "script_noteworthy");

  if(var0.size > 0) {
    global_door_threads();
  }

  scripts\engine\utility::array_thread(var0, level.interactive_doors.fndoorinit);
}

function global_door_threads() {
  if(isDefined(level.doors_initialized)) {
    return;
  }

  if(scripts\sp\starts::is_no_game_start()) {
    return;
  }

  level.doors_initialized = 1;
  scripts\engine\utility::array_thread(getaiarray(), &scripts\sp\door::ai_monitor_doors);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\door::ai_monitor_doors);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\sp\door::ai_monitor_doors);
  scripts\engine\sp\utility::add_global_spawn_function("neutral", &scripts\sp\door::ai_monitor_doors);
  scripts\engine\sp\utility::add_global_spawn_function("team3", &scripts\sp\door::ai_monitor_doors);
}

function init_door_internal(var0) {
  if(istrue(var0)) {}

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

  if(!isDefined(self.locked)) {
    self.locked = 0;
  }

  if(!scripts\engine\utility::ent_flag_exist("initialized")) {
    scripts\engine\utility::ent_flag_init("initialized");
  }

  if(istrue(var0)) {
    self.script_spawn_open_yaw = undefined;
  } else {
    level.interactive_doors.ents[level.interactive_doors.ents.size] = self;
  }

  var1 = scripts\engine\utility::get_linked_ents();
  var2 = scripts\engine\utility::get_linked_structs();
  var3 = 1;

  if(isDefined(self.script_parameters)) {
    var4 = strtok(self.script_parameters, " ");

    foreach(var6 in var4) {
      switch (var6) {
        case "locked":
          if(!istrue(var0)) {
            self.locked = 1;
          }

          break;
        case "no_open":
          var3 = 0;
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

  foreach(var9 in var1) {
    if(isDefined(var9.script_noteworthy)) {
      var9.door = self;

      switch (var9.script_noteworthy) {
        case "clip":
          self.clip = var9;
          var9 linkTo(self);
          var9.doorclip = 1;
          break;
        case "clip_nosight":
          self.clip_nosight = var9;
          var9 linkTo(self);
          var9.doorclip = 1;
          break;
        case "unlock_volume":
          self.unlock_volume = var9;
          thread unlock_volume_logic();
          break;
        case "link":
          if(!isDefined(self.linked_ents)) {
            self.linked_ents = [];
          }

          self.linked_ents[self.linked_ents.size] = var9;
          var9 linkTo(self);
          var9.doorclip = 1;
          break;
      }
    }
  }

  foreach(var12 in var2) {
    if(isDefined(var12.script_noteworthy)) {
      var12.door = self;

      switch (var12.script_noteworthy) {
        case "open_hint":
          self.true_start_angles = var12.angles;
          self.open_struct = var12;
          self.length = distance2d(self.origin, self.open_struct.origin);

          if(var3) {
            setup_open_struct(var12);
          }

          break;
        case "pivot_left":
          self.pivots["open_left"] = var12;
          break;
        case "pivot_right":
          self.pivots["open_right"] = var12;
          break;
        case "ai_open_walk":
          self.ai_anim_start["walk"] = rotatevectorinverted(var12.origin - self.origin, self.true_start_angles);
          break;
        case "ai_open_run":
          self.ai_anim_start["run"] = rotatevectorinverted(var12.origin - self.origin, self.true_start_angles);
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

  var14 = strtok(var2[0].script_linkname, "_")[0];
  createinitialnavmodifier(var14);
  self.clip connectpaths();

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
    return;
  }
}

function is_clip_nosight() {
  return isDefined(self.script_noteworthy) && self.script_noteworthy == "clip_nosight";
}

function cursor_hint_thread(var0) {
  self notify("cursor_hint_thread");
  self endon("cursor_hint_thread");
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_cursor_hint_thread");
  self.prevplayeronright = -1;
  self.playeronright = -1;
  self.cursorhintdir = (0, 0, 0);
  var1 = isDefined(self.open_struct);

  for(;;) {
    waitframe();
    set_player_side();

    if(!var1 && has_cursor_hint(self.open_struct) || cursor_refresh(self.open_struct)) {
      var1 = 1;
      self.prevplayeronright = -1;
    }

    if(self.prevplayeronright != self.playeronright) {
      if(isDefined(self.open_struct)) {
        adjust_cursor_hint_side(self.open_struct);
      }
    }

    if(var1) {
      var1 = has_cursor_hint(self.open_struct);
    }

    if(isDefined(var0)) {
      self[[var0]]();
    }
  }
}

function cursor_refresh(var0) {
  if(isDefined(var0.refresh)) {
    var0.refresh = undefined;
    return true;
  }

  return false;
}

function has_cursor_hint(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isarray(var0)) {
    foreach(var2 in var0) {
      if(isDefined(var2.cursor_hint_ent)) {
        return true;
      }
    }
  } else {
    return isDefined(var3.cursor_hint_ent);
  }

  return false;
}

function adjust_cursor_hint_side(var0) {
  if(!isDefined(var0.cursor_hint_ent)) {
    return;
  }

  var1 = var0.origin;
  var2 = scripts\sp\door::get_door_angles() - self.true_start_angles;

  if(abs(var2[1]) > 0.01 && isDefined(self.pivot_ent)) {
    var3 = var1 - self.pivot_ent.origin;
    var3 = rotatevectorinverted(var3, self.true_start_angles);
    var3 = rotatevector(var3, self.pivot_ent.angles);
    var1 = var3 + self.pivot_ent.origin;
  }

  var1 += self.cursorhintdir * var0.radius;
  var0.cursor_hint_ent dontinterpolate();
  var0.cursor_hint_ent.origin = var1;
}

function get_player_on_right() {
  var0 = vectortoangles(self.forward);

  if(isDefined(self.pivot_ent)) {
    var0 = self.pivot_ent.angles;
  }

  var1 = anglestoright(var0);
  var2 = vectorNormalize(level.player.origin - self.origin);
  var3 = vectordot(var1, var2);

  if(var3 > 0) {
    return [0, var1];
  }

  return [1, var1 * -1];
}

function set_player_side() {
  var0 = get_player_on_right();
  self.prevplayeronright = self.playeronright;
  self.playeronright = var0[0];
  self.cursorhintdir = var0[1];
}

function trace_completion_thread() {
  for(;;) {
    var0 = 0;

    foreach(var2 in level.interactive_doors.ents) {
      if(!isDefined(var2.max_yaw_left) || !isDefined(var2.max_yaw_right)) {
        var0 = 1;
        waitframe();
        break;
      }
    }

    if(!var0) {
      break;
    }
  }

  scripts\engine\utility::flag_set("interactive_doors_ready");
}

function get_hint_dist(var0) {
  if(isDefined(level.interactive_doors.hint_dist_scale)) {
    return (var0 * level.interactive_doors.hint_dist_scale);
  }

  return var0;
}

function door_dmg() {
  self endon("entitydeleted");
  self setCanDamage(1);
  var0 = undefined;
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;

  for(;;) {
    self waittill("damage", var0, var1, var4, var4, var2, var4, var4, var4, var4, var5);
    var6 = "none";

    if(isDefined(var5)) {
      var6 = var5.basename;
    }

    var3 = scripts\engine\utility::ter_op(isDefined(var1) && isDefined(var1.classname), var1.classname, "unknown");
    self.debug_activity = var0 + " " + var2 + " dmg taken from " + var3 + " with weapon " + var6;
  }
}

function unlock_volume_logic() {
  var0 = self.door;

  if(isDefined(var0.doubledoors)) {
    var0 = var0.doubledoors[0];
  }

  if(!var0.locked) {
    return;
  }

  self.active = 1;
  var0 endon("first_interact");
  var0 endon("ai_opened");
  var0 endon("bashed");
  var0 endon("detonate");
  var0 endon("unlock_volume_logic");

  for(;;) {
    while(!level.player istouching(self) && (!isDefined(var0.doubledoorother) || !isDefined(var0.doubledoorother.unlock_volume) || !level.player istouching(var0.doubledoorother.unlock_volume))) {
      waitframe();
    }

    var0 scripts\sp\door::unlock_door();

    while(level.player istouching(self) || isDefined(var0.doubledoorother) && isDefined(var0.doubledoorother.unlock_volume) && level.player istouching(var0.doubledoorother.unlock_volume)) {
      waitframe();
    }

    var0 scripts\sp\door::lock_door();
  }
}

function refresh_open_struct() {
  self.refresh = 1;
}

function door_open_think() {
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_open_ability");
  self endon("ai_opened");
  self notify("unusable");

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

function get_max_yaw(var0) {
  var1 = 70;
  var2 = 30;
  var3 = 5;

  if(var0) {
    if(isDefined(self.script_max_left_angle)) {
      self.max_yaw_left = self.script_max_left_angle;
      return;
    }
  } else if(isDefined(self.script_max_right_angle)) {
    self.max_yaw_right = self.script_max_right_angle;
    return;
  }

  var4 = get_max_yaw_internal(var1, var2, var0);
  var4 += var3;
  var5 = get_max_yaw_internal(var4, var3, var0);

  if(var0) {
    self.max_yaw_left = var5;
    return;
  }

  self.max_yaw_right = var5;
}

function get_max_yaw_internal(var0, var1, var2) {
  var3 = 0;
  var4 = 0;
  var5 = 0;
  var6 = scripts\engine\trace::create_default_contents(1);

  while(!var4) {
    if(var0 > 179) {
      return 179;
    }

    var7 = yaw_collision_check(var0, var2, var6);

    if(var7) {
      if(var3) {
        var8 = 1;
      }

      var0 += var1;
    } else {
      if(!var3) {
        var3 = 1;
      }

      var0 -= var1;
      var4 = 1;
    }

    var5++;

    if(var5 == 3) {
      var5 = 0;
      wait 0.05;
    }
  }

  return var0;
}

function yaw_collision_check(var0, var1, var2) {
  var3 = 100;

  if(var1) {
    var3 *= -1;
  } else {
    var0 *= -1;
  }

  var4 = self.true_start_angles + (0, var0, 0);

  if(var1) {
    var5 = self.pivots["open_left"].origin + (0, 0, 2);
  } else {
    var5 = self.pivots["open_right"].origin + (0, 0, 2);
  }

  var6 = var5 + anglesToForward(var5) * self.length * 0.2;
  var7 = var6 + anglestoright(var5) * var4;
  var8 = scripts\engine\trace::capsule_trace(var6, var7, 6, 80, var5, [self, self.clip], var3, 0);
  var9 = distance2d(var6, var8["position"]);

  if(var9 > 3) {
    var6 = var5 + anglesToForward(var5) * self.length * 0.9;
    var8 = scripts\engine\trace::capsule_trace(var6, var7, 6, 80, var5, [self, self.clip], var3, 0);
    var9 = distance2d(var6, var8["position"]);
    return (var9 > 5);
  }

  return false;
}

function draw_max_yaw(var0) {
  var1 = undefined;

  if(var0) {
    var1 = self.max_yaw_left;
    var2 = self.pivots["open_left"].origin;
  } else {
    var2 = self.max_yaw_right * -1;
    var2 = self.pivots["open_right"].origin;
  }

  var3 = self.true_start_angles + (0, var2, 0);
  var4 = var2 + anglesToForward(var3) * self.length;
}

function try_door_hint() {
  self endon("door_close");

  if(istrue(self.nohint)) {
    return;
  }

  if(!scripts\engine\utility::flag("did_door_hint")) {
    thread display_hint_dist_check();

    while(level.player useButtonPressed() || isDefined(level.player getplayeruseentity()) || isDefined(self.hint_delay_until) && gettime() < self.hint_delay_until) {
      waitframe();
    }

    wait 0.25;

    if(!scripts\engine\utility::flag("door_second_interact") && !scripts\engine\utility::flag("door_exceed_hint_dist") && !istrue(self.bashed)) {
      scripts\engine\utility::flag_set("did_door_hint");
      thread scripts\engine\sp\utility::display_hint("door_hint_1", undefined, undefined, self, "bashed");
      return;
    }

    return;
  }
}

function first_hint_func() {
  if(scripts\engine\utility::flag("door_second_interact")) {
    return true;
  }

  if(scripts\engine\utility::flag("door_exceed_hint_dist")) {
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
  scripts\engine\utility::flag_clear("door_exceed_hint_dist");

  while(distancesquared(self.origin, level.player.origin) < squared(165)) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("door_exceed_hint_dist");
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

  if(getdvarint("scr_use_door_gesture")) {
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

function set_pivot_point(var0) {
  if(!can_pivot_change()) {
    if(issubstr(self.current_pivot_struct.script_noteworthy, "pivot_left")) {
      self.hinge_side = "open_left";
      return;
    }

    self.hinge_side = "open_right";
    return;
  }

  if(var0) {
    var1 = "open_left";
  } else {
    var1 = "open_right";
  }

  self.hinge_side = var1;

  if(!isDefined(self.current_pivot_struct) || self.current_pivot_struct != self.pivots[var1]) {
    self.current_pivot_struct = self.pivots[var1];

    if(self islinked()) {
      self unlink();
    }

    if(!isDefined(self.pivot_ent)) {
      self.pivot_ent = scripts\engine\utility::spawn_script_origin(self.current_pivot_struct.origin, self.true_start_angles);
    } else {
      self.pivot_ent dontinterpolate();
      self.pivot_ent.origin = self.current_pivot_struct.origin;
    }

    wait 0.05;
    self linkTo(self.pivot_ent);
    return;
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

  for(;;) {
    if(!istrue(self.bashed) && scripts\sp\door::bash_door_isplayerclose() && level.player useButtonPressed() && !isDefined(level.player getplayeruseentity()) && pushents_clear()) {
      if(!scripts\engine\utility::flag("door_second_interact")) {
        scripts\engine\utility::flag_set("door_second_interact");
      }

      self notify("open_completely");
    }

    wait 0.05;
  }
}

function pushents_clear() {
  if(isDefined(self.pushents)) {
    var0 = self.pushents;
    var0 = sortbydistance(var0, self.origin);

    if(distancesquared(self.origin, var0[0].origin) < 6400) {
      var1 = self.origin;
      var2 = vectortoangles(self.forward);
      var3 = anglestoright(var2);
      var4 = vectorNormalize(var0[0].origin - var1);
      var5 = vectordot(var3, var4);
      self.bashblocked = 1;

      if(var5 > 0) {
        return false;
      }
    }
  }

  return true;
}

function setup_open_struct(var0) {
  if(!isDefined(var0.radius)) {
    var0.radius = 2.5;
  }

  if(!isDefined(self.script_spawn_open_yaw)) {
    thread open_struct_logic();
    return;
  }
}

function open_struct_logic() {
  self.door endon("stop_open_ability");
  self.door endon("stop_open_interact");

  if(!isDefined(self.openinteract)) {
    self.openinteract = 0;
  }

  scripts\sp\door::create_open_interact_hint();

  for(;;) {
    self waittill("trigger");
    self notify("stop_cursor_hint_thread");
    self.door notify("trigger");
    level.player notify("door_trigger", self.door);

    if(getdvarint("scr_use_door_gesture")) {
      thread player_door_gesture();
    }

    if(!self.door.locked) {
      break;
    }

    if(getdvarint("scr_use_door_gesture")) {
      wait 0.1;
    }

    if(isDefined(self.door.script_sound_type) && self.door.script_sound_type == "metal_heavy") {
      thread scripts\engine\utility::play_sound_in_space("scrpt_door_metal_open_locked", self.cursor_hint_ent.origin);
    } else {
      thread scripts\engine\utility::play_sound_in_space("scrpt_door_wood_open_locked", self.cursor_hint_ent.origin);
    }

    level.player playRumbleOnEntity("damage_heavy");
    earthquake(0.17, 0.2, level.player.origin, 200);
    self.door notify("locked");
    return;
  }

  scripts\sp\door::remove_open_interact_hint();

  if(getdvarint("scr_use_door_gesture")) {
    wait 0.1;
  } else if(isDefined(self.door.destructible)) {
    self.door setscriptablepartstate("main", "open_handle");
  }

  self.door notify("first_interact");

  if(!scripts\engine\utility::flag("door_first_interact")) {
    scripts\engine\utility::flag_set("door_first_interact");
    return;
  }
}

function should_do_gesture() {
  return !nullweapon(level.player getcurrentweapon());
}

function player_door_gesture(var0) {
  self notify("player_door_gesture");
  self endon("player_door_gesture");

  if(isDefined(var0) && var0) {
    var1 = level.interactive_doors.gesture_door_hard;
  } else {
    var1 = level.interactive_doors.gesture_door;
  }

  thread pushplayertodoor();
  var2 = scripts\engine\utility::spawn_tag_origin();
  var2.origin = self.origin;

  if([[level.interactive_doors.fnshoulddogesture]]()) {
    level.player playgestureviewmodel(var1, var2);
    wait level.player getgestureanimlength(var1);
  }

  var2 delete();
}

function pushplayertodoor() {
  var0 = 0.04;
  var1 = 0.2;
  var2 = 0;
  level.player thread scripts\engine\sp\utility::blend_movespeedscale(0.1, 0.3, "doorOpen");

  while(var2 < 0.99) {
    if(!isDefined(self)) {
      break;
    }

    pushlogic(var2);
    var2 += var1;
    wait 0.05;
  }

  var2 = 1;
  level.player thread scripts\engine\sp\utility::blend_movespeedscale(1, 0.7, "doorOpen");

  while(var2 > 0.01) {
    if(!isDefined(self)) {
      break;
    }

    pushlogic(var2);
    var2 -= var0;
    wait 0.05;
  }

  level.player pushplayervector((0, 0, 0));
}

function pushlogic(var0) {
  var1 = self.origin - level.player getEye();
  var2 = length(var1);
  var3 = scripts\engine\math::normalize_value(20, 50, var2);
  var4 = scripts\engine\math::factor_value(5, 11, var3);
  var5 = vectorNormalize(var1);
  var6 = var0 * var4;
  level.player pushplayervector(var5 * var6);
}

function player_window_gesture(var0) {
  self notify("player_window_gesture");
  self endon("player_window_gesture");
  var1 = level.interactive_doors.gesture_window;

  if([[level.interactive_doors.fnshoulddogesture]]()) {
    var0 = scripts\engine\utility::ter_op(isDefined(var0), var0, 1);
    level.player playgestureviewmodel(var1);
    wait var0;
  }

  level.player stopgestureviewmodel(var1, 2);
}

function door_bashable_by_player(var0) {
  if(istrue(self.no_bash) || istrue(self.was_opened_halfway) || istrue(self.open_completely) || istrue(self.bashed)) {
    return false;
  }

  if(istrue(var0)) {
    return true;
  }

  if(nullweapon(level.player getcurrentweapon())) {
    return false;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_center(), 0.82)) {
    return true;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_handle(), 0.82)) {
    return true;
  }

  if(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, get_door_bottom_origin(), 0.82)) {
    return true;
  }

  return false;
}

function should_bash_open() {
  thread bash_debug(1);

  if(door_bashable_by_player()) {
    if(level.player ismeleeing()) {
      thread bash_debug(2000);
      return true;
    }

    if(!level.player issprinting()) {
      return false;
    }

    if(getdvarint("scr_door_bash_requires_use")) {
      if(!level.player useButtonPressed()) {
        return false;
      }
    }

    var0 = length(level.player getvelocity());

    if(var0 < 50) {
      return false;
    }

    var1 = vectorNormalize(level.player getEye() - get_door_center());
    var2 = vectordot(var1, anglesToForward(scripts\sp\door::get_door_angles()));

    if(abs(var2) > 0.4) {
      return false;
    }

    self.bashscale = scripts\engine\math::lerp_fraction(50, 195, var0);
    thread bash_debug(2000);
    return true;
  }

  return false;
}

function bash_debug(var0) {}

function stealth_broadcast(var0, var1) {
  var2 = scripts\engine\utility::ter_op(isDefined(var0), var0, 500);
  var3 = scripts\engine\sp\utility::get_all_closest_living(self.origin, getaiarray("axis"), var2, 0);

  if(!var3.size) {
    return;
  }

  foreach(var5 in var3) {
    if(isDefined(var5.stealth)) {
      var5 aieventlistenerevent(var1, level.player, self.origin);
    }
  }
}

function combat_getinfoinradius(var0) {
  var1 = scripts\engine\utility::ter_op(isDefined(var0), var0, 500);
  var2 = scripts\engine\sp\utility::get_all_closest_living(self.origin, getaiarray("axis"), var1, 0);

  if(!var2.size) {
    return;
  }

  foreach(var4 in var2) {
    var4 getenemyinfo(level.player);
  }
}

function get_bash_yaw(var0) {
  jumpiffalse(self.open_left) LOC_00000043;
  var1 = self.max_yaw_left;

  if(var0 < 1) {
    var1 = scripts\engine\math::factor_value(55, 170, var0);
    var1 = min(var1, self.max_yaw_left);
  }

  var2 = self.true_start_angles[1] + var1;
  goto LOC_00000076;
}

function bashed_locked_door(var0) {
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

  while(level.player ismeleeing()) {
    waitframe();
  }

  self.isbashing = undefined;
}

function bashed_locked_door_sfx() {
  if(!isDefined(self.bashedsfx)) {
    self.bashedsfx = 1;
    var0 = spawn("script_origin", self.origin + (0, 0, 42));
    var0 playSound("door_locked_bashed", "sounddone");

    if(randomint(100) < 40) {
      level.player playSound("breathing_limp");
    }

    var0 waittill("sounddone");
    var0 delete();
    self.bashedsfx = undefined;
    return;
  }
}

function door_bash_presentation() {
  screenshake(level.player.origin, 16, 0, 0, 0.45);
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.6, 0.75, level.player.origin, 200);
}

function close_prompt(var0) {
  self notify("close_prompt");
  self endon("close_prompt");
  self endon("reset_door");
  self endon("entitydeleted");

  if(!istrue(level.interactive_doors.close_prompt)) {
    return;
  }

  scripts\engine\utility::flag_wait("interactive_doors_ready");

  if(isDefined(var0)) {
    wait var0;
  }

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

    if(isDefined(self.doubledoorother)) {
      self.doubledoorother notify("stop_monitoring_open_completely");
    }

    thread player_door_gesture();

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
  var0 = scripts\engine\trace::create_character_contents();
  var1 = scripts\sp\door::get_door_angles()[1];
  var2 = self.true_start_angles[1];
  var3 = ceil(abs(var2 - var1) / 15);
  var4 = self.current_pivot_struct == self.pivots["open_left"];

  for(var5 = 0; var5 < var3; var5++) {
    var6 = var1 + (var2 - var1) * var5 / var3;

    if(!yaw_collision_check(var6, var4, var0)) {
      return false;
    }
  }

  return true;
}

function monitor_door_push(var0) {
  self endon("reset_door");
  self endon("stop_push_open");
  self endon("bashed_full");
  self endon("entitydeleted");

  if(!isDefined(var0)) {
    var0 = 0.5;
  }

  if(self.bashed) {
    wait self.bashtime + 0.05;
    self.pivot_ent rotateTo(self.pivot_ent.angles, 0.05);
  } else if(var0 > 0) {
    wait var0;
  }

  thread door_ease_in_open_input();

  for(;;) {
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
  var0 = 1;
  var1 = var0;
  self.masterdoorratescale = 0;

  for(;;) {
    if(!isDefined(self) || var1 <= 0) {
      break;
    }

    self.masterdoorratescale = 1 - var1 / var0;
    wait 0.05;
    var1 -= 0.05;
  }

  self.masterdoorratescale = 1;
}

function get_pushent() {
  if(isDefined(self.pushents)) {
    var0 = scripts\engine\utility::array_add(self.pushents, level.player);
  } else {
    return level.player;
  }

  var0 = sortbydistance(var0, self.origin);
  return var0[0];
}

function push_door() {
  if(self.bashed_full) {
    return;
  }

  if(istrue(self.bash_opening)) {
    return;
  }

  var0 = get_pushent();
  var1 = 36;
  var2 = 0;
  var3 = 25;
  var4 = interact_door_get_endpoint();
  var5 = distance(var0.origin, var4);
  var6 = scripts\engine\math::normalize_value(var2, var1, var5);
  var7 = var3 * (1 - var6);
  var7 *= self.masterdoorratescale;
  var8 = scripts\sp\door::should_open_left(self.pivot_ent.angles, var0);

  if(abs(var7) < 0.001) {
    return;
  }

  scripts\sp\door::remove_open_interact_hint();
  var9 = scripts\sp\door::get_door_angles()[1];
  var10 = scripts\engine\utility::ter_op(var8 == 1, 1, -1);
  var11 = var9 + var7 * var10;

  if(var8) {
    if(self.hinge_side == "open_left") {
      var12 = scripts\sp\door::angle_diff(var11, self.true_start_angles[1]);

      if(var12 > self.max_yaw_left) {
        self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
        self.open_completely = 1;
        thread scripts\sp\door::updatenavobstacle();
        self notify("stop_push_open");
        return;
      }
    } else if(var11 > self.true_start_angles[1]) {
      self.debug_activity = "Pushed back closed, right hinge";
      thread scripts\sp\door::reset_door();
      self notify("stop_push_open");
      return;
    }
  } else if(self.hinge_side == "open_right") {
    var12 = abs(scripts\sp\door::angle_diff(var11, self.true_start_angles[1]));

    if(var12 > self.max_yaw_right) {
      self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
      self.open_completely = 1;
      thread scripts\sp\door::updatenavobstacle();
      self notify("stop_push_open");
      return;
    }
  } else if(var11 < self.true_start_angles[1]) {
    self.debug_activity = "Pushed back closed, left hinge";
    thread scripts\sp\door::reset_door();
    self notify("stop_push_open");
    return;
  }

  if(var7 > 0.4) {
    thread try_push_sound();

    if(!scripts\engine\utility::flag("door_second_interact")) {
      scripts\engine\utility::flag_set("door_second_interact");
    }
  } else if(istrue(self.isplayingpushsound)) {
    self.isplayingpushsound = 0;
    self notify("stop_door_creak");
  }

  self.pivot_ent.angles = (self.pivot_ent.angles[0], var11, self.pivot_ent.angles[2]);
  self.forward = anglesToForward(self.pivot_ent.angles);

  if(door_is_half_open()) {
    if(!self.was_opened_halfway) {
      thread suspicious_door_stealth_check(1);
    }

    self.was_opened_halfway = 1;
    thread close_prompt(0.25);
  }

  updatenodelookpeek();
  var13 = gettime();

  if(abs(angleclamp180(self.pivot_ent.angles[1] - self.nav_lastupdateangle)) > 20 && var13 - self.nav_lastupdatetime > 250 || var13 - self.nav_lastupdatetime > 1500) {
    thread scripts\sp\door::updatenavobstacle(1);
    return;
  }
}

function push_door_player_effects() {
  var0 = scripts\sp\door::should_open_left(self.pivot_ent.angles, level.player);
  var1 = self.pivot_ent;
  var2 = "doorPush" + self.doorid;

  if(!isDefined(self.dooroffset)) {
    self.dooroffset = (0, 0, 0);
    self.doorrot = (0, 0, 0);
    self.doorspeedscale = 1;
  }

  level.player notify("newoffset");
  level.player endon("newoffset");

  for(;;) {
    var3 = door_get_pushspot();
    var4 = (var3[0], var3[1], level.player.origin[2]) - level.player.origin;
    var5 = vectorNormalize(var4);
    var6 = anglesToForward(level.player.angles);
    var7 = vectorcross(var6, var5);
    var8 = vectordot(var6, var5);
    var9 = length(var4);
    var10 = level.player getnormalizedmovement();
    var10 = (var10[0], -1 * var10[1], 0);
    var11 = rotatevector(var10, level.player.angles);
    var12 = vectorNormalize(var11);
    var13 = vectordot(var12, var5);
    var14 = clamp(length(var11), 0, 1);

    if(var7[2] > 0) {
      var15 = (0, 4, 0);
      var16 = (0, -5, 0);
    } else {
      var15 = (0, -2, 0);
      var16 = (0, 2, 0);
    }

    if(var8 > 0) {
      if(var0) {
        var17 = (4, -1.5, 0);
        var18 = (-6, 5, 1.5);
      } else {
        var17 = (4, -1.5, 0);
        var18 = (-6, -3, -1.5);
      }
    } else {
      var17 = (-3, 0, 0);
      var18 = (0, 0, 0);
    }

    var19 = scripts\engine\math::normalize_value(0.6, 1, abs(var8));
    var19 = scripts\engine\math::normalized_float_smooth_in(var19);
    var20 = scripts\engine\math::factor_value(var15, var17, var19);
    var21 = scripts\engine\math::factor_value(var16, var18, var19);
    var22 = scripts\engine\math::normalize_value(0, 1, var13);
    var23 = scripts\engine\math::normalize_value(0, 0.5, var14);
    var24 = 1 - scripts\engine\math::normalize_value(20, 50, var9);

    if(level.player isfiring()) {
      var25 = 0.5;
    } else {
      var25 = 1;
    }

    var26 = 1;
    var26 *= var22;
    var26 *= var23;
    var26 *= var24;
    var26 *= var25;
    var20 *= var26;
    var21 *= var26;

    if(length(var20) > length(self.dooroffset)) {
      var27 = 0.312;
    } else {
      var27 = 0.234;
    }

    var28 = 1 - level.player playerads();

    if(level.player adsButtonPressed()) {
      var28 = scripts\engine\math::normalize_value(0.8, 1, var28);
    }

    self.dooroffset = scripts\engine\math::lerp(self.dooroffset, var20, var27);
    self.doorrot = scripts\engine\math::lerp(self.doorrot, var21, var27);
    scripts\sp\player::player_apply_local_weap_position(self.dooroffset * var28 * 1, 0, var2);
    scripts\sp\player::player_apply_local_weap_rotation(self.doorrot * var28 * 1, 0, var2);
    var29 = 1;
    var22 = scripts\engine\math::normalize_value(0, 1, var13);
    var23 = scripts\engine\math::normalize_value(0, 0.01, var14);
    var24 = 1 - scripts\engine\math::normalize_value(25, 70, var9);
    var29 *= var22;
    var29 *= var23;
    var29 *= var24;
    var30 = scripts\engine\math::factor_value(1, 0.2, var29);
    var27 = 0.3;
    self.doorspeedscale = scripts\engine\math::lerp(self.doorspeedscale, var30, var27);
    level.player scripts\engine\sp\utility::blend_movespeedscale(self.doorspeedscale, 0, var2);

    if(length(self.dooroffset) < 0.001 && self.doorspeedscale > 0.99) {
      break;
    }

    if(!isDefined(self)) {
      break;
    }

    wait 0.05;
    var20 = (0, 0, 0);
  }

  if(isDefined(self)) {
    self.dooroffset = (0, 0, 0);
    self.doorrot = (0, 0, 0);
    self.doorspeedscale = 1;
  }

  scripts\sp\player::player_apply_local_weap_position((0, 0, 0), 0.2, var2);
  scripts\sp\player::player_apply_local_weap_rotation((0, 0, 0), 0.2, var2);
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 0, var2);
}

function door_get_pushspot() {
  var0 = 12;
  var1 = level.player.origin + anglesToForward(level.player.angles) * var0;
  var2 = interact_door_get_endpoint();
  var3 = self.origin + self.forward * 5;
  var4 = pointonsegmentnearesttopoint(var3, var2, var1);
  return var4;
}

function initlinkednodes() {
  var0 = get_door_bottom_center();
  var1 = getnodesinradius(var0, self.length * 0.5 + 32, 0, 80, "cover");

  if(var1.size > 0) {
    self.linkednodes_hinge = [];
    self.linkednodes_knob = [];
    var2 = undefined;

    if(isDefined(self.pivots["open_left"])) {
      var2 = self.pivots["open_left"].origin;
    } else if(isDefined(self.pivots["open_right"])) {
      var2 = self.pivots["open_right"].origin;
    }

    var3 = var2 - var0;

    foreach(var5 in var1) {
      var6 = var5.origin - var0;

      if(vectordot(var6, var3) > 0) {
        self.linkednodes_hinge[self.linkednodes_hinge.size] = var5;
        continue;
      }

      self.linkednodes_knob[self.linkednodes_knob.size] = var5;
    }

    return;
  }

  self.linkednodes_hinge = undefined;
  self.linkednodes_knob = undefined;
}

function updatenodelookpeek() {
  var0 = angleclamp180(scripts\sp\door::get_door_angles()[1]);
  var1 = abs(angleclamp180(var0 - self.true_start_angles[1]));

  if(isDefined(self.linkednodes_hinge)) {
    var2 = anglesToForward((0, var0, 0));

    foreach(var4 in self.linkednodes_hinge) {
      if(var1 > 90) {
        var4.allow_lookpeek = undefined;
      } else {
        var4.allow_lookpeek = 0;
      }

      if(var1 > 80) {
        var5 = anglesToForward(var4.angles);

        if(vectordot(var2, var5) < 0) {
          var4 disconnectnode();
        } else {
          var4 connectnode();
        }

        continue;
      }

      var4 connectnode();
    }
  }

  if(isDefined(self.linkednodes_knob)) {
    foreach(var4 in self.linkednodes_knob) {
      if(var1 > 45) {
        var4.allow_lookpeek = undefined;
        continue;
      }

      var4.allow_lookpeek = 0;
    }

    return;
  }
}

function createinitialnavmodifier(var0) {
  if(!isDefined(self.navmodifier)) {
    var1 = var0 + "_nav_modifier";
    self.navmodifier = createnavmodifier(var1, "script_linkname");

    if(!isDefined(self.navmodifier)) {
      iprintln("Closed door has no nav modifier!");
      return;
    }

    return;
  }
}

function suspicious_door_stealth_check(var0) {
  if(!isDefined(level.stealth)) {
    return;
  }

  if(!getdvarint("scr_suspicious_stealth_doors") || !isDefined(level.stealth)) {
    return;
  }

  if(var0) {
    level.stealth.suspicious_door.doors[level.stealth.suspicious_door.doors.size] = self;
    return;
  }

  level.stealth.suspicious_door.doors = scripts\engine\utility::array_remove(level.stealth.suspicious_door.doors, self);
}

function try_push_sound() {
  if(!isDefined(self.isplayingpushsound)) {
    self.isplayingpushsound = 0;
  }

  if(!self.isplayingpushsound) {
    self.isplayingpushsound = 1;
    thread door_creak_sound();
    return;
  }
}

function door_creak_sound() {
  self notify("stop stopping door creak");
  var0 = get_door_audio_material();
  self scalevolume(1);
  var1 = "scrpt_door_" + var0 + "_creak_lp";

  if(soundexists(var1)) {
    self playLoopSound(var1);
  }

  scripts\engine\utility::waittill_any("stop_door_creak", "stop_push_open");
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

function door_is_at_max_yaw(var0) {
  var1 = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);

  if(isDefined(var0)) {
    return (var1 >= self.max_yaw_left || var1 <= -1 * self.max_yaw_right);
  }

  if(self.open_left) {
    return (var1 >= self.max_yaw_left);
  }

  return var1 <= -1 * self.max_yaw_right;
}

function door_is_half_open() {
  var0 = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);

  if(self.open_left) {
    return (var0 >= self.max_yaw_left / 2);
  }

  return var0 <= self.max_yaw_right / -2;
}

function door_is_open_at_least(var0) {
  var1 = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);
  return abs(var1) >= var0;
}

function get_door_center() {
  var0 = scripts\sp\door::get_door_angles();
  self.doorcenter = self.origin + (0, 0, 55) + anglesToForward(var0) * self.length * 1.2 / 2;
  return self.doorcenter;
}

function get_door_bottom_center() {
  self.doorbottomcenter = get_door_center();
  self.doorbottomcenter = (self.doorbottomcenter[0], self.doorbottomcenter[1], self.origin[2]);
  return self.doorbottomcenter;
}

function get_door_bottom_handle() {
  var0 = scripts\sp\door::get_door_angles();
  self.doorbottomhandle = self.origin + anglesToForward(var0) * self.length;
  return self.doorbottomhandle;
}

function get_door_bottom_origin() {
  self.doorbottomorigin = self.origin;
  return self.doorbottomorigin;
}

function isnavpointaccesiblefrombehinddoor(var0, var1) {
  if(isDefined(var1.doorbottomcenter)) {
    var2 = var1.doorbottomcenter;
  } else {
    var2 = var2.origin;
  }

  var3 = vectorNormalize(var2 - self.origin);
  var4 = var2 + anglesToForward(vectortoangles(var3)) * 7;
  var5 = navtrace(var4, var1, self, 1);
  var6 = (0, 1, 0);

  if(var5["fraction"] < 0.88) {
    var6 = (1, 0, 0);
  }

  iprintln(var5["fraction"]);
  return var5["fraction"] >= 0.9;
}

function print_navtrace(var0) {
  self endon("death");

  for(;;) {
    var1 = navtrace(self.origin, var0, self, 1);
    wait 0.05;
  }
}

function print3d_on_me(var0, var1) {
  self endon("death");
  var1 *= 1000;
  var2 = gettime();

  while(gettime() < var2 + var1) {
    wait 0.05;
  }
}

function get_door_audio_material() {
  var0 = self.script_sound_type;

  if(!isDefined(var0)) {
    var0 = "wood_heavy";
  }

  return var0;
}

function double_doors_init_auto() {
  foreach(var1 in level.interactive_doors.ents) {
    var2 = getentarrayinradius("interactive_door", "script_noteworthy", var1.origin, 150);
    var3 = anglesToForward(var1.angles);

    foreach(var5 in var2) {
      if(var5 == var1) {
        continue;
      }

      if(isDefined(var5.doubledoors)) {
        continue;
      }

      if(vectordot(anglesToForward(var5.angles), var3) < -0.99) {
        scripts\sp\door::double_doors_init(var1, var5);
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

  for(;;) {
    self waittill("attempt_bash", var0);
    self.doubledoorother thread scripts\sp\door::door_bash_open(var0);

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
  self waittill("opened_completely", var0);
  self.doubledoorother thread scripts\sp\door::door_open_completely(var0);
}

function double_doors_hint_pos(var0) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var1 = spawnStruct();
  var1.origin = scripts\engine\math::get_mid_point(self.open_struct.origin, var0.open_struct.origin);
  scripts\sp\door::remove_open_prompts();
  var1.door = self;
  self.open_struct = var1;
  setup_open_struct(var1);
  thread cursor_hint_thread();
}

function door_watch_unresolved_collision() {
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

function door_watch_unresolved_collision_count() {
  self endon("death");

  for(;;) {
    self waittill("unresolved_collision", var0);

    if(isDefined(var0) && istrue(var0.doorclip)) {
      if(!isDefined(var0.door_unresolved_collision_count)) {
        var0.door_unresolved_collision_count = 1;
        var0.door_unresolved_collision_start_time = gettime();
        thread door_watch_unresolved_collision();
        continue;
      }

      var0.door_unresolved_collision_count++;
    }
  }
}