/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\door.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\scriptable_door;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\game\sp\door;
#using scripts\sp\door;
#using scripts\sp\door_ai;
#using scripts\sp\door_internal;
#using scripts\sp\door_scriptable;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace door;

function init() {
  level.player notifyonplayercommand("melee_pressed", "+melee");
  level.player notifyonplayercommand("melee_pressed", "+melee_zoom");
  level.player notifyonplayercommand("melee_pressed", "+melee_breath");
  level.interactive_doors = spawnStruct();
  level.interactive_doors.ents = [];
  level.interactive_doors.got_hint = 0;
  level.interactive_doors.close_prompt = 0;
  level.interactive_doors.process_damage = 0;
  level.interactive_doors.fndoorinit = &init_door_internal;
  level.interactive_doors.fnshoulddogesture = &should_do_gesture;
  level.interactive_doors.gesture_door = "ges_door_push_directional";
  level.interactive_doors.gesture_door_hard = "ges_door_push_directional_hard";
  level.interactive_doors.gesture_window = "ges_zg_wallbreach_mantle_left";
  level.interactive_doors.count = 0;
  level.interactive_doors.hint_dist_scale = 1;

  if(isDefined(level.door_hint_dist_scale)) {
    level.interactive_doors.hint_dist_scale = level.door_hint_dist_scale;
  }

  setdvarifuninitialized(@ "scr_door_bash_requires_use", 0);
  setdvarifuninitialized(@ "hash_e76702af051fcb2b", 0);

  setdvarifuninitialized(@ "hash_6985e82f27803483", 0);

  setdvarifuninitialized(@ "hash_e4715899ce74d8ee", 0);

  setdvarifuninitialized(@ "hash_6109644d57e1122e", 0);
  flag_init("door_first_interact");
  flag_init("door_second_interact");
  flag_init("door_bashed");
  flag_init("did_door_hint");
  flag_init("interactive_doors_ready_internal");
  flag_init("interactive_doors_ready");
  flag_init("door_exceed_hint_dist");
  add_hint_string("door_hint_2", &"SCRIPT/DOOR_HINT_BASH");
  add_hint_string("door_hint_obstructed", &"SCRIPT/DOOR_HINT_OBSTRUCTED");
  level thread scripts\engine\scriptable_door::system_init();
  level.player thread door_watch_unresolved_collision_count();
  level.player thread function_a414717d35653c75();
  scripts\game\sp\door::init();
  thread door_post_load();
  windowstructs = getStructArray("interactive_window", "targetname");
  array_thread(windowstructs, &init_window);
}

function get_interactive_door(targetname) {
  flag_wait("interactive_doors_ready");
  doors = [];

  foreach(door in level.interactive_doors.ents) {
    if(isDefined(door.targetname) && door.targetname == targetname) {
      doors[doors.size] = door;
    }
  }

  if(!doors.size) {
    return undefined;
  }

  assertex(doors.size == 1, "Tried to get interactive door targetname " + targetname + " but there is more than one");

  if(doors.size == 1) {
    return doors[0];
  }
}

function get_interactive_door_array(targetname) {
  flag_wait("interactive_doors_ready");
  doors = [];

  foreach(door in level.interactive_doors.ents) {
    if(!isDefined(door.targetname)) {
      continue;
    }

    if(door.targetname != targetname) {
      continue;
    }

    doors[doors.size] = door;
  }

  if(!doors.size) {
    return [];
  }

  return doors;
}

function unlock_all_doors(allowopening) {
  flag_wait("interactive_doors_ready");

  foreach(door in level.interactive_doors.ents) {
    if(door.locked) {
      door unlock_door(allowopening);
    }
  }
}

function unlock_door(allowopening) {
  if(isDefined(allowopening) && !allowopening) {
    return;
  }

  self notify("stop_open_interact");
  self notify("door_unlock");
  self.locked = 0;

  if(function_bb083055639abcf3()) {
    return;
  }

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    self.open_struct remove_open_interact_hint();
    self.open_struct.no_open_interact = undefined;
    self.open_struct delaythread(0.05, &open_struct_logic);
    self.open_struct delaythread(0.05, &refresh_open_struct);
  }

  clear_navobstacle();

  if(isDefined(self.doubledoorother) && self.doubledoorother.locked) {
    self.doubledoorother unlock_door(allowopening);
  }
}

function lock_door() {
  self notify("stop_open_interact");
  self notify("door_lock");
  self.locked = 1;

  if(isDefined(self.unlock_volume) && !istrue(self.unlock_volume.active)) {
    self.unlock_volume thread unlock_volume_logic();
  }

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    self.open_struct delaythread(0.05, &open_struct_logic);
  }

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
    self.navobstacle = undefined;
  }

  create_navobstacle();

  if(isDefined(self.doubledoorother) && !self.doubledoorother.locked) {
    self.doubledoorother lock_door();
  }
}

function init_max_yaws() {
  get_max_yaw(1);
  get_max_yaw(0);
  ent_flag_set("initialized");
}

function remove_open_ability() {
  println("<dev string:x1c>" + self getentnum() + "<dev string:x49>" + self.origin);
  self notify("stop_bash_monitor");
  self notify("stop_open_ability");
  remove_open_prompts();
}

function should_open_left(angles, opener) {
  if(!isDefined(opener)) {
    opener = ter_op(isDefined(self.opener), self.opener, level.player);
  }

  open_left = undefined;
  origin = self.origin;

  if(!isDefined(angles)) {
    angles = vectortoangles(self.forward);
  }

  if(isDefined(self.pivot_ent)) {
    origin = self.pivot_ent.origin;
    angles = self.pivot_ent.angles;
  }

  right = anglestoright(angles);
  normal = vectorNormalize(opener.origin - origin);
  dot = vectordot(right, normal);

  if(dot > 0) {
    return 1;
  }

  return 0;
}

function create_open_interact_hint(custom_hint_text) {
  hint_text = custom_hint_text;

  if(!isDefined(hint_text)) {
    hint_text = self.custom_hint_text;

    if(!isDefined(hint_text)) {
      if(self.door door_bashable_by_player(1)) {
        hint_text = &"SCRIPT/DOOR_HINT_USE";
      } else {
        hint_text = &"SCRIPT/DOOR_HINT_USE_NO_BASH";
      }
    }
  }

  if(!istrue(self.openinteract) || !isDefined(self.cursor_hint_ent)) {
    if(!istrue(self.no_open_interact)) {
      scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), hint_text, 45, 200 * level.interactive_doors.hint_dist_scale, 55 * level.interactive_doors.hint_dist_scale, 0);
      self.cursor_hint_ent setusewhenhandsoccupied(1);
      self.cursor_hint_ent.door = self.door;
      self.openinteract = 1;
    }
  } else if(!in_realism_mode()) {
    self.cursor_hint_ent setHintString(hint_text);
  }

  if(isDefined(level.interactive_doors.var_416a1be63376e00c)) {
    [[level.interactive_doors.var_416a1be63376e00c]](self, custom_hint_text);
  }

  if(isDefined(custom_hint_text)) {
    self.custom_hint_text = custom_hint_text;
  }
}

function remove_open_interact_hint() {
  assertex(isstruct(self), "Call this Function on the door.open_struct.");

  if(istrue(self.openinteract)) {
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    self.custom_hint_text = undefined;
    self.openinteract = 0;
  }

  self.no_open_interact = 1;
}

function door_ajar(opener) {
  if(isDefined(self.door_ajar_custom_func)) {
    [[self.door_ajar_custom_func]]();
  }

  self.ajar = 1;

  self.debug_activity = "<dev string:x4e>";

  if(isDefined(self.ajar_opener)) {
    opener = self.ajar_opener;
  } else if(!isDefined(opener)) {
    opener = level.player;
  }

  if(isPlayer(opener)) {
    stealth_broadcast("window_open", opener, 40);
  }

  self notify("opening");
  self.opener = opener;
  self.open_left = should_open_left();
  set_pivot_point(self.open_left);

  if(isDefined(self.ajar_opener)) {
    self.opener = undefined;
  }

  if(isDefined(self.script_spawn_open_yaw)) {
    self.pivot_ent.angles += (0, self.script_spawn_open_yaw, 0);
    self notify("ajar");

    if(self.script_spawn_open_yaw > 0) {
      self.hinge_side = "open_left";
      self.open_left = 1;
    } else {
      self.hinge_side = "open_right";
      self.open_left = 0;
    }

    return;
  }

  time = 1.5;
  yaw_angle = 9;

  if(isDefined(self.script_forceyaw)) {
    yaw_angle = self.max_yaw_left;
  }

  if(!self.open_left) {
    if(isDefined(self.script_forceyaw)) {
      yaw_angle = self.max_yaw_right;
    }

    yaw_angle *= -1;
  }

  doororigin = get_door_bottom_center();

  if(distancesquared(level.player.origin, doororigin) < 10000) {
    level.player playRumbleOnEntity("damage_heavy");
  }

  var_7da6017ed0aee8e = get_door_audio_material();
  alias = "scrpt_door_" + var_7da6017ed0aee8e + "_open_soft";

  if(soundexists(alias)) {
    self playSound(alias);
  }

  self.pivoting = 1;
  self.pivot_ent rotateYaw(yaw_angle, time, time * 0.25, time * 0.75);
  thread notify_delay("ajar", time);
  wait time;
  self.pivoting = undefined;
}

function get_door_angles() {
  if(isDefined(self.pivot_ent)) {
    return self.pivot_ent.angles;
  }

  return self.true_start_angles;
}

function angle_diff(value1, value2) {
  diff = angleclamp180(value1 - value2);
  return diff;
}

function door_bash_open(opener, bashtime) {
  self endon("entitydeleted");

  if(istrue(self.bashed_full)) {
    return;
  }

  if(!isDefined(opener)) {
    opener = level.player;
  }

  self.opener = opener;

  if(opener == level.player && function_e0b0300fbf1b645b(self)) {
    bashed_locked_door(level.player getvelocity());
    return;
  }

  if(!flag("door_bashed")) {
    flag_set("door_bashed");
  }

  self notify("opening");
  thread remove_open_prompts();
  self.open_left = should_open_left();
  set_pivot_point(self.open_left);

  if(opener == level.player) {
    thread door_bash_presentation();
    level.player notify("door_bashed", self);

    if(!self.bashed && !self.was_opened_halfway) {
      thread suspicious_door_stealth_check(1);
    }
  } else {
    self notify("ai_opened");
  }

  openscale = 1;

  if(isDefined(self.bashscale) && self.bashscale < 1) {
    openscale = self.bashscale;
  }

  self.bashed = 1;
  self notify("bashed", opener);
  bash_yaw = get_bash_yaw(openscale);

  if(openscale == 1 && !istrue(self.bashblocked)) {
    self notify("bashed_full");
    self.bashed_full = 1;
  }

  anglediff = bash_yaw - self.true_start_angles[1];

  if(!isDefined(bashtime)) {
    if(openscale == 1) {
      var_11b200101076bc6c = 0.25;
      var_5e7a100369fafe1e = 0.5;
    } else {
      var_11b200101076bc6c = 0.4;
      var_5e7a100369fafe1e = 0.75;
    }

    timefactor = math::normalize_value(0, 170, abs(anglediff));
    bashtime = math::factor_value(var_11b200101076bc6c, var_5e7a100369fafe1e, timefactor);
  }

  self.bashtime = bashtime;
  current_angles = get_door_angles();
  open_angles = (current_angles[0], bash_yaw, current_angles[2]);

  self.debug_activity = "<dev string:x53>" + self.opener getentitynumber() + "<dev string:x58>" + bash_yaw;

  var_7da6017ed0aee8e = get_door_audio_material();
  alias = "scrpt_door_" + var_7da6017ed0aee8e + "_bash";

  if(soundexists(alias)) {
    playsoundatpos(self.origin + (0, 0, 30), alias);
  }

  self.bash_opening = 1;
  self.pivoting = 1;

  if(openscale == 1) {
    self.pivot_ent rotateTo(open_angles, bashtime);
  } else {
    self.pivot_ent rotateTo(open_angles, bashtime, 0, bashtime);
  }

  thread notify_delay("open", bashtime);
  wait bashtime;
  self.opener notify("opened_door");
  thread updatenavobstacle();
  updatenodelookpeek();

  if(opener == level.player) {
    eventradius = 450;

    if(isDefined(level.var_7d3d0935e9de042a)) {
      eventradius = level.var_7d3d0935e9de042a;
    }

    if(isDefined(level.stealth)) {
      thread stealth_broadcast("door_bash", level.player, eventradius);
    } else {
      thread combat_getinfoinradius(eventradius);
    }
  }

  if(openscale == 1 && abs(anglediff) > 100 && !istrue(self.disable_bounceback)) {
    self playSound("door_hit_wall");
    self.active = 0;
    var_b492b99eb62e16f2 = randomfloatrange(3, 5);
    var_6e09cabeb82b5356 = ter_op(self.open_left, -3, 3);
    alias = "scrpt_door_" + var_7da6017ed0aee8e + "_creak_lp";

    if(soundexists(alias)) {
      self playLoopSound(alias);
    }

    self scalevolume(0, var_b492b99eb62e16f2);
    self.pivot_ent rotateTo(open_angles + (0, var_6e09cabeb82b5356, 0), var_b492b99eb62e16f2, 0.5, var_b492b99eb62e16f2 - 0.5);
    wait var_b492b99eb62e16f2;
    self stoploopsound();
    thread updatenavobstacle();
  } else {
    wait 0.05;
  }

  self.pivoting = undefined;
  thread close_prompt();
  self.bash_opening = undefined;
  self.bashblocked = undefined;
}

function remove_open_prompts() {
  self.open_struct remove_open_interact_hint();
}

function door_rotate(opener, yaw_angle, time) {
  if(istrue(self.open_complete)) {
    return;
  }

  if(!isDefined(self.pivot_ent)) {
    if(isDefined(opener)) {
      self.opener = opener;
      self.ajar_opener = opener;
    }

    self notify("first_interact");
    scripts\sp\door::remove_open_prompts();

    while(!isDefined(self.pivot_ent)) {
      wait 0.05;
    }
  }

  if(!self.open_left) {
    yaw_angle *= -1;
  }

  self.pivot_ent rotateYaw(yaw_angle, time, time * 0.25, time * 0.75);
  scripts\sp\door::remove_open_prompts();
}

function door_open_completely(opener, time) {
  flag_wait("interactive_doors_ready");
  self notify("stop_push_open");
  self notify("stop_bash_monitor");
  self notify("close_prompt");
  self notify("stop_open_interact");
  self notify("opening");
  self endon("stop_monitoring_open_completely");
  self endon("entitydeleted");
  remove_open_prompts();
  self.open_completely = 1;

  if(!flag("door_second_interact") && isDefined(opener) && opener == level.player) {
    flag_set("door_second_interact");
  }

  if(isDefined(opener)) {
    self.opener = opener;
  }

  self notify("opened_completely", opener);
  var_ee65acc756212405 = ter_op(isPlayer(opener), 1, 0);

  if(isai(self.opener)) {
    self notify("ai_opened");
  }

  if(isDefined(opener) || !isDefined(self.open_left)) {
    self.open_left = should_open_left();
  }

  set_pivot_point(self.open_left);
  max_yaw = undefined;

  if(self.open_left) {
    max_yaw = self.true_start_angles[1] + self.max_yaw_left;
  } else {
    max_yaw = self.true_start_angles[1] - self.max_yaw_right;
  }

  if(isDefined(self.opener) && isent(self.opener)) {
    self.debug_activity = "<dev string:x53>" + self.opener getentitynumber() + "<dev string:x6d>" + max_yaw;
  }

  var_7da6017ed0aee8e = get_door_audio_material();
  alias = ter_op(isPlayer(opener), "scrpt_door_" + var_7da6017ed0aee8e + "_open_wide", "scrpt_door_" + var_7da6017ed0aee8e + "_open_wide_npc");

  if(soundexists(alias)) {
    self playSound(alias);
  }

  self.pivoting = 1;
  time = default_to(time, 1.5);

  if(time < 0.05) {
    self.pivot_ent.angles = (self.angles[0], max_yaw, self.angles[2]);
  } else {
    if(time > 0.05) {
      accel = time * 0.25;
      decel = time * 0.75;

      if(!var_ee65acc756212405) {
        accel = 0;
      }
    } else {
      accel = 0;
      decel = 0;
    }

    self.pivot_ent rotateTo((self.angles[0], max_yaw, self.angles[2]), time, accel, decel);
  }

  self notify("stop_door_creak");
  thread notify_delay("open", time);

  if(isDefined(self.opener)) {
    self.opener notify("opened_door");
  }

  if(time >= 0.05) {
    wait time;
  }

  self.pivoting = undefined;
  thread suspicious_door_stealth_check(var_ee65acc756212405);
  thread updatenavobstacle();
  updatenodelookpeek();
  self.active = 0;

  if(var_ee65acc756212405) {
    stealth_broadcast("window_open", level.player, 128);
  }

  thread close_prompt();
}

function door_close(user, time, accel, decel) {
  self notify("door_close");

  if(!isDefined(self.pivot_ent)) {
    return;
  }

  if(!isDefined(time)) {
    time = 1.5;
  }

  if(!isDefined(accel)) {
    accel = time * 0.25;
  }

  if(!isDefined(decel)) {
    decel = time * 0.25;
  }

  self.pivoting = 1;
  self.pivot_ent rotateTo((self.angles[0], self.true_start_angles[1], self.angles[2]), time, accel, decel);
  wait time;
  self.pivoting = undefined;
  thread updatenavobstacle();
  updatenodelookpeek();
  suspicious_door_stealth_check(0);
}

function reset_door() {
  self notify("stop_door_creak");
  self notify("reset_door");

  if(isDefined(self.pivot_ent)) {
    self.pivot_ent.angles = (self.pivot_ent.angles[0], self.true_start_angles[1], self.pivot_ent.angles[2]);
  }

  thread updatenavobstacle();
  suspicious_door_stealth_check(0);
  flag_clear("door_bashed");
  flag_clear("did_door_hint");
  flag_clear("door_second_interact");
  self thread[[level.interactive_doors.fndoorinit]](1);
}

function updatenavobstacle(bforce) {
  if(isDefined(self.updatingnavobstacle)) {
    return;
  }

  waitframe();
  self.updatingnavobstacle = 1;

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
    println("<dev string:x88>" + self.doorid + "<dev string:xb9>" + self.origin);
  }

  if(istrue(self.locked) && isDefined(self.clip)) {
    clear_navobstacle();
    create_navobstacle();
  } else if(istrue(self.bashed_full) || istrue(self.open_completely) || istrue(bforce)) {
    if(isDefined(self.clip)) {
      self.navobstacle = createnavbadplacebyent(self.clip, 14);
    }

    if(isDefined(self.navobstacle)) {
      println("<dev string:xc6>" + self.doorid + "<dev string:xb9>" + self.origin);
    } else {
      println("<dev string:xf0>");
      line((0, 0, 0), self.origin, (1, 0, 0), 1, 0, 100);
    }

    doorangles = get_door_angles();
    self.nav_lastupdatetime = gettime();
    self.nav_lastupdateangle = doorangles[1];
  }

  self.updatingnavobstacle = undefined;
}

function clear_navobstacle() {
  if(!isDefined(self.navobstacleid)) {
    return;
  }

  destroynavobstacle(self.navobstacleid);
  self.navobstacleid = undefined;

  if(isDefined(level.stealth) && isDefined(self.opener) && self.opener == level.player) {
    suspicious_door_stealth_check(1);
  }
}

function create_navobstacle() {
  if(isDefined(self.navobstacleid)) {
    return;
  }

  switch (self.team) {
    case #"hash_5f54b9bf7583687f":
      self.navobstacleid = createnavbadplacebyent(self.clip, "axis", "team3", "neutral");
      break;
    case #"hash_7c2d091e6337bf54":
      self.navobstacleid = createnavbadplacebyent(self.clip, "allies", "team3", "neutral");
      break;
    case #"hash_a571cacc018623b8":
      self.navobstacleid = createnavbadplacebyent(self.clip, "axis", "team3", "allies");
      break;
    case #"hash_24b14065e10b1f8d":
      self.navobstacleid = createnavbadplacebyent(self.clip, "axis", "allies", "neutral");
      break;
    case #"hash_8e26538d066f6ebb":
    case #"hash_e5078707e2696229":
      self.navobstacleid = createnavbadplacebyent(self.clip, "allies", "team3");
      break;
    default:
      self.navobstacleid = createnavobstaclebyent(self.clip);
      break;
  }
}

function delete_door() {
  self notify("unusable");
  remove_open_ability();

  if(isDefined(self.clip_nosight)) {
    self.clip_nosight delete();
  }

  if(self.classname == "script_model") {
    self.clip delete();
  }

  if(isDefined(self.pivot_ent)) {
    self.pivot_ent delete();
  }

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
    self.navmodifer = undefined;
    println("<dev string:x111>" + self getentitynumber() + "<dev string:xb9>" + self.origin);
  }

  if(isDefined(self.linked_ents)) {
    foreach(ent in self.linked_ents) {
      ent delete();
    }

    self.linked_ents = [];
  }

  level.interactive_doors.ents = array_remove(level.interactive_doors.ents, self);
  self delete();
}

function get_all_bashable_doors() {
  a = [];

  foreach(door in level.interactive_doors.ents) {
    if(!door ent_flag("initialized")) {
      continue;
    }

    if(door.bashed || door.open_completely || door.breached || door door_is_half_open()) {
      continue;
    }

    a[a.size] = door;
  }

  return a;
}

function get_all_doors_ai_should_open() {
  a = [];

  foreach(door in level.interactive_doors.ents) {
    if(!door ent_flag("initialized")) {
      continue;
    }

    if(door.bashed || door.open_completely || door.breached || door door_is_open_at_least(60)) {
      continue;
    }

    a[a.size] = door;
  }

  return a;
}

function get_all_closed_doors() {
  a = [];

  foreach(door in level.interactive_doors.ents) {
    if(door.bashed || door.ajar || door.open_completely || door.breached) {
      continue;
    }

    a[a.size] = door;
  }

  return a;
}

function get_all_interactive_doors() {
  return level.interactive_doors.ents;
}

function function_997866c90caea19d(entity) {
  return array_contains(level.interactive_doors.ents, entity);
}

function get_all_interactive_doors_blocking_paths(team) {
  a = [];

  foreach(door in level.interactive_doors.ents) {
    if(isDefined(door.navobstacleid) && !issubstr(door.team, team)) {
      a[a.size] = door;
    }
  }

  return a;
}

function bash_monitor() {
  self notify("bash_monitor");
  self endon("bash_monitor");
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_bash_monitor");

  while(true) {
    if(bash_door_isplayerclose() && should_bash_open()) {
      self notify("attempt_bash", level.player);
      thread door_bash_open();

      if(!self.locked) {
        return;
      }
    }

    wait 0.05;
  }
}

function interact_door_ispushentclose() {
  pushent = get_pushent();
  z = abs(pushent.origin[2] - self.origin[2]);

  if(z < 20) {
    endpoint = interact_door_get_endpoint();
    d = distancesquared(pushent.origin, endpoint);

    if(d < 1296) {
      return true;
    }
  }

  return false;
}

function interact_door_dopusheffects() {
  z = abs(level.player.origin[2] - self.origin[2]);

  if(z < 20) {
    endpoint = interact_door_get_endpoint();
    d = distancesquared(level.player.origin, endpoint);

    if(d < 14400) {
      return true;
    }
  }

  return false;
}

function interact_door_isplayerfacing() {
  endpoint = interact_door_get_endpoint();
  closest_point = pointonsegmentnearesttopoint(endpoint, self.origin, level.player.origin);
  door_dir = vectorNormalize(closest_point - level.player.origin);
  player_dir = anglesToForward(level.player.angles);

  if(vectordot(door_dir, player_dir) > 0.7) {
    return true;
  }

  return false;
}

function bash_door_isplayerclose() {
  z = abs(level.player.origin[2] - self.origin[2]);

  if(z < 20) {
    endpoint = self.doorbottomcenter;

    if(!isDefined(endpoint)) {
      endpoint = self.origin;
    }

    d = distancesquared(level.player.origin, endpoint);
    range = ter_op(self.locked == 1, 60, 60);

    if(d < range * range) {
      return true;
    }
  }

  return false;
}

function function_89be9fac0c81f3aa() {
  flag_wait("interactive_doors_ready_internal");
  other_door = undefined;

  if(!isDefined(self.doubledoorother)) {
    other_door = get_closest_exclude(self.origin, level.interactive_doors.ents, [self]);
  } else {
    other_door = self.doubledoorother;
  }

  thread scripts\sp\door::double_doors_init(self, other_door);
}

function double_doors_init_targetname(targetname) {
  door_main = scripts\sp\door::get_interactive_door(targetname);
  door_other = scripts\sp\door::get_interactive_door(targetname + "_right");
  return double_doors_init(door_main, door_other);
}

function double_doors_init(door_main, door_other) {
  doors = [];
  doors[0] = door_main;
  doors[1] = door_other;
  thread double_doors_init_thread(door_main, door_other);
  return doors;
}

function double_doors_init_thread(door_main, door_other) {
  door_main notify("double_doors_init_thread");
  door_other notify("double_doors_init_thread");
  door_main endon("double_doors_init_thread");
  door_other endon("double_doors_init_thread");
  waittillframeend();
  doors[0] = door_main;
  doors[1] = door_other;
  door_main.doubledoorother = door_other;
  door_main.doubledoors = doors;
  door_main thread double_doors_waittill_interact();
  door_main thread double_doors_waittill_bashed();
  door_main thread double_doors_hint_pos(door_other);
  door_main thread double_doors_waittill_open_completely();
  door_other scripts\sp\door::remove_open_prompts();
  door_other.doubledoorother = door_main;
  door_other.doubledoors = doors;
  door_other thread double_doors_waittill_bashed();
  door_other thread double_doors_waittill_open_completely();

  if(door_other.locked && isDefined(door_other.unlock_volume)) {
    door_other notify("unlock_volume_logic");
    door_other.unlock_volume thread unlock_volume_logic();
  }

  return door_main.doubledoors;
}

function function_bb083055639abcf3() {
  angle_diff = scripts\sp\door::angle_diff(scripts\sp\door::get_door_angles()[1], self.true_start_angles[1]);

  if(abs(angle_diff) > 0) {
    return true;
  }

  return false;
}

function ai_monitor_doors() {
  self endon("death");

  thread function_9de18eb036b1e0c5();

  while(true) {
    result = waittill_any_return("path_has_door", "opened_door", "opening_door_done", "reset_door_check");
    flag_wait("interactive_doors_ready");
    self notify("stop_current_door");

    if(istrue(self.isopeningdoor)) {
      continue;
    }

    if(isDefined(self.waitingfordoor)) {
      if(isDefined(result) && result == "path_set" && isDefined(self.doornode) && isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.doornode.origin) < 4) {
        continue;
      }

      stop_waiting_for_door();
    }

    remove_as_opener();
    var_2e400c7eb43f6073 = 0;
    doorloc = undefined;
    possibledoor = undefined;

    while(true) {
      doorloc = self getmodifierlocationonpath("door");

      if(isDefined(doorloc)) {
        possibledoor = get_closed_door_closest_to_nav_modifier(doorloc);

        if(isDefined(possibledoor)) {
          doororigin = possibledoor get_door_bottom_center();

          if(distancesquared(self.origin, doororigin) < 400) {
            var_5c6afc1001475042 = vectorNormalize(doororigin - self.origin);

            if(vectordot(self.lookaheaddir, var_5c6afc1001475042) < -0.707) {
              wait 2;
              continue;
            }
          }

          self notify("<dev string:x13b>", "<dev string:x146>");

          var_2e400c7eb43f6073 = 1;
          break;
        } else {
          wait 0.2;
          continue;
        }
      } else {
        break;
      }

      if(var_2e400c7eb43f6073) {
        break;
      }

      wait 0.05;
    }

    if(!var_2e400c7eb43f6073) {
      continue;
    }

    door_add_opener(possibledoor);
    possibledoor thread door_manage_openers();
  }
}

function add_pushent(ent) {
  if(!isDefined(self.pushents)) {
    self.pushents = [];
  }

  self.pushents[self.pushents.size] = ent;
}

function private function_a414717d35653c75() {
  self endon("death");
  time_interval = 1;
  var_fe0cad2a6558d5f7 = pow(528 * time_interval, 2);

  while(true) {
    last_pos = self.origin;
    wait time_interval;

    if(distancesquared(self.origin, last_pos) > var_fe0cad2a6558d5f7) {
      self notify("teleported");
    }
  }
}