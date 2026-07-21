/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\door.gsc
***********************************************/

init() {
  level.player notifyonplayercommand("melee_pressed", "+melee");
  level.player notifyonplayercommand("melee_pressed", "+melee_zoom");
  level.player notifyonplayercommand("melee_pressed", "+melee_breath");
  level.interactive_doors = spawnStruct();
  level.interactive_doors.ents = [];
  level.interactive_doors.got_hint = 0;
  level.interactive_doors.close_prompt = 0;
  level.interactive_doors.fndoorinit = scripts\sp\door_internal::init_door_internal;
  level.interactive_doors.fnshoulddogesture = scripts\sp\door_internal::should_do_gesture;
  level.interactive_doors.gesture_door = "ges_door_push_directional";
  level.interactive_doors.gesture_door_hard = "ges_door_push_directional_hard";
  level.interactive_doors.gesture_window = "ges_zg_wallbreach_mantle_left";
  level.interactive_doors.count = 0;
  level.interactive_doors.hint_dist_scale = 1;

  if(isDefined(level.door_hint_dist_scale))
    level.interactive_doors.hint_dist_scale = level.door_hint_dist_scale;

  setdvarifuninitialized("scr_door_bash_requires_use", 0);
  setdvarifuninitialized("scr_use_door_gesture", 0);
  setdvarifuninitialized("scr_suspicious_stealth_doors", 1);
  scripts\engine\utility::flag_init("door_first_interact");
  scripts\engine\utility::flag_init("door_second_interact");
  scripts\engine\utility::flag_init("door_bashed");
  scripts\engine\utility::flag_init("did_door_hint");
  scripts\engine\utility::flag_init("interactive_doors_ready");
  scripts\engine\utility::flag_init("door_exceed_hint_dist");
  scripts\engine\sp\utility::add_hint_string("door_hint_2", &"SCRIPT/DOOR_HINT_BASH");
  scripts\engine\sp\utility::add_hint_string("door_hint_obstructed", &"SCRIPT/DOOR_HINT_OBSTRUCTED");
  level thread scripts\engine\scriptable_door::system_init();
  level.player thread scripts\sp\door_internal::door_watch_unresolved_collision_count();
  scripts\game\sp\door::init();
  thread scripts\sp\door_internal::door_post_load();
  var_0 = scripts\engine\utility::getStructArray("interactive_window", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\door_internal::init_window);
}

get_interactive_door(var_0) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var_1 = [];

  foreach(var_3 in level.interactive_doors.ents) {
    if(isDefined(var_3.targetname) && var_3.targetname == var_0)
      var_1[var_1.size] = var_3;
  }

  if(!var_1.size)
    return undefined;

  if(var_1.size == 1)
    return var_1[0];
}

get_interactive_door_array(var_0) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var_1 = [];

  foreach(var_3 in level.interactive_doors.ents) {
    if(isDefined(var_3.targetname) && var_3.targetname == var_0)
      var_1[var_1.size] = var_3;
  }

  if(!var_1.size)
    return undefined;

  return var_1;
}

unlock_all_doors(var_0) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");

  foreach(var_2 in level.interactive_doors.ents) {
    if(var_2.locked)
      var_2 unlock_door(var_0);
  }
}

unlock_door(var_0) {
  if(isDefined(var_0) && !var_0) {
    return;
  }
  self notify("stop_open_interact");
  self notify("door_unlock");
  self.locked = 0;

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    self.open_struct remove_open_interact_hint();
    self.open_struct.no_open_interact = undefined;
    self.open_struct scripts\engine\utility::delaythread(0.05, scripts\sp\door_internal::open_struct_logic);
    self.open_struct scripts\engine\utility::delaythread(0.05, scripts\sp\door_internal::refresh_open_struct);
  }

  clear_navobstacle();

  if(isDefined(self.doubledoorother) && self.doubledoorother.locked)
    self.doubledoorother unlock_door(var_0);
}

lock_door() {
  self notify("stop_open_interact");
  self notify("door_lock");
  self.locked = 1;

  if(isDefined(self.unlock_volume) && !istrue(self.unlock_volume.active))
    self.unlock_volume thread scripts\sp\door_internal::unlock_volume_logic();

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    self.open_struct remove_open_interact_hint();
    self.open_struct scripts\engine\utility::delaythread(0.05, scripts\sp\door_internal::open_struct_logic);
  }

  create_navobstacle();

  if(isDefined(self.doubledoorother) && !self.doubledoorother.locked)
    self.doubledoorother lock_door();
}

init_max_yaws() {
  scripts\sp\door_internal::get_max_yaw(1);
  scripts\sp\door_internal::get_max_yaw(0);
  scripts\engine\utility::ent_flag_set("initialized");
}

remove_open_ability() {
  self notify("stop_bash_monitor");
  self notify("stop_open_ability");
  remove_open_prompts();
}

should_open_left(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::ter_op(isDefined(self.opener), self.opener, level.player);

  var_2 = undefined;
  var_3 = self.origin;

  if(!isDefined(var_0))
    var_0 = vectortoangles(self.forward);

  if(isDefined(self.pivot_ent)) {
    var_3 = self.pivot_ent.origin;
    var_0 = self.pivot_ent.angles;
  }

  var_4 = anglestoright(var_0);
  var_5 = vectorNormalize(var_1.origin - var_3);
  var_6 = vectordot(var_4, var_5);

  if(var_6 > 0)
    return 1;
  else
    return 0;
}

create_open_interact_hint(var_0) {
  var_1 = var_0;

  if(!isDefined(var_1)) {
    var_1 = self.custom_hint_text;

    if(!isDefined(var_1)) {
      if(self.door scripts\sp\door_internal::door_bashable_by_player(1))
        var_1 = &"SCRIPT/DOOR_HINT_USE";
      else
        var_1 = &"SCRIPT/DOOR_HINT_USE_NO_BASH";
    }
  }

  if(!istrue(self.openinteract) || !isDefined(self.cursor_hint_ent)) {
    if(!istrue(self.no_open_interact)) {
      scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var_1, 45, 200 * level.interactive_doors.hint_dist_scale, 55 * level.interactive_doors.hint_dist_scale, 0);
      self.cursor_hint_ent setusewhenhandsoccupied(1);
      self.cursor_hint_ent.door = self.door;
      self.openinteract = 1;
    }
  } else if(!scripts\engine\sp\utility::in_realism_mode())
    self.cursor_hint_ent setHintString(var_1);

  if(isDefined(var_0))
    self.custom_hint_text = var_0;
}

remove_open_interact_hint() {
  if(istrue(self.openinteract)) {
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    self.openinteract = 0;
  }

  self.no_open_interact = 1;
}

door_ajar(var_0) {
  if(isDefined(self.door_ajar_custom_func))
    [[self.door_ajar_custom_func]]();

  self.ajar = 1;

  if(isDefined(self.ajar_opener))
    var_0 = self.ajar_opener;
  else if(!isDefined(var_0))
    var_0 = level.player;

  if(isPlayer(var_0))
    scripts\sp\door_internal::stealth_broadcast(40, "window_open");

  self.opener = var_0;
  self.open_left = should_open_left();
  scripts\sp\door_internal::set_pivot_point(self.open_left);

  if(isDefined(self.ajar_opener))
    self.opener = undefined;

  if(isDefined(self.script_spawn_open_yaw)) {
    self.pivot_ent.angles = self.pivot_ent.angles + (0, self.script_spawn_open_yaw, 0);
    self notify("ajar");

    if(self.script_spawn_open_yaw > 0) {
      self.hinge_side = "open_left";
      self.open_left = 1;
    } else {
      self.hinge_side = "open_right";
      self.open_left = 0;
    }
  } else {
    var_1 = 1.5;
    var_2 = 9;

    if(!self.open_left)
      var_2 = var_2 * -1;

    level.player playRumbleOnEntity("damage_heavy");
    var_3 = scripts\sp\door_internal::get_door_audio_material();
    var_4 = "scrpt_door_" + var_3 + "_open_soft";

    if(soundexists(var_4))
      self playSound(var_4);

    self.pivoting = 1;
    self.pivot_ent rotateYaw(var_2, var_1, var_1 * 0.25, var_1 * 0.75);
    thread scripts\engine\sp\utility::notify_delay("ajar", var_1);
    wait(var_1);
    self.pivoting = undefined;
  }
}

get_door_angles() {
  if(isDefined(self.pivot_ent))
    return self.pivot_ent.angles;
  else
    return self.true_start_angles;
}

angle_diff(var_0, var_1) {
  var_2 = angleclamp180(var_0 - var_1);
  return var_2;
}

door_bash_open(var_0) {
  self endon("entitydeleted");

  if(istrue(self.bashed_full)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = level.player;

  self.opener = var_0;

  if(var_0 == level.player && self.locked) {
    scripts\sp\door_internal::bashed_locked_door(level.player getvelocity());
    return;
  }

  if(!scripts\engine\utility::flag("door_bashed"))
    scripts\engine\utility::flag_set("door_bashed");

  thread remove_open_prompts();
  self.open_left = should_open_left();
  scripts\sp\door_internal::set_pivot_point(self.open_left);

  if(var_0 == level.player) {
    thread scripts\sp\door_internal::door_bash_presentation();
    level.player notify("door_bashed", self);
  } else
    self notify("ai_opened");

  var_1 = 1;

  if(isDefined(self.bashscale) && self.bashscale < 1)
    var_1 = self.bashscale;

  self.bashed = 1;
  self notify("bashed", var_0);
  var_2 = scripts\sp\door_internal::get_bash_yaw(var_1);

  if(var_1 == 1 && !istrue(self.bashblocked)) {
    self notify("bashed_full");
    self.bashed_full = 1;
  }

  if(var_1 == 1) {
    var_3 = 0.25;
    var_4 = 0.5;
  } else {
    var_3 = 0.4;
    var_4 = 0.75;
  }

  var_5 = var_2 - self.true_start_angles[1];
  var_6 = scripts\engine\math::normalize_value(0, 170, abs(var_5));
  var_7 = scripts\engine\math::factor_value(var_3, var_4, var_6);
  self.bashtime = var_7;
  var_8 = get_door_angles();
  var_9 = (var_8[0], var_2, var_8[2]);
  var_10 = scripts\sp\door_internal::get_door_audio_material();
  var_11 = "scrpt_door_" + var_10 + "_bash";

  if(soundexists(var_11))
    playworldsound(var_11, self.origin + (0, 0, 30));

  self.bash_opening = 1;
  self.pivoting = 1;

  if(var_1 == 1)
    self.pivot_ent rotateTo(var_9, var_7);
  else
    self.pivot_ent rotateTo(var_9, var_7, 0, var_7);

  thread scripts\engine\sp\utility::notify_delay("open", var_7);
  wait(var_7);
  self.opener notify("opened_door");
  thread updatenavobstacle();
  scripts\sp\door_internal::updatenodelookpeek();

  if(var_0 == level.player) {
    if(isDefined(level.stealth))
      thread scripts\sp\door_internal::stealth_broadcast(450, "combat");
    else
      thread scripts\sp\door_internal::combat_getinfoinradius(450);
  }

  if(var_1 == 1 && abs(var_5) > 100 && !istrue(self.disable_bounceback)) {
    self playSound("door_hit_wall");
    self.active = 0;
    var_12 = randomfloatrange(3, 5);
    var_13 = scripts\engine\utility::ter_op(self.open_left, -3, 3);
    var_11 = "scrpt_door_" + var_10 + "_creak_lp";

    if(soundexists(var_11))
      self playLoopSound(var_11);

    self scalevolume(0, var_12);
    self.pivot_ent rotateTo(var_9 + (0, var_13, 0), var_12, 0.5, var_12 - 0.5);
    wait(var_12);
    self stoploopsound();
    thread updatenavobstacle();
  } else
    wait 0.05;

  self.pivoting = undefined;
  thread scripts\sp\door_internal::close_prompt();
  self.bash_opening = undefined;
  self.bashblocked = undefined;
}

remove_open_prompts() {
  self.open_struct remove_open_interact_hint();
}

door_open_completely(var_0, var_1) {
  self notify("stop_push_open");
  self notify("stop_bash_monitor");
  self notify("close_prompt");
  self notify("stop_open_interact");
  self endon("stop_monitoring_open_completely");
  self endon("entitydeleted");
  remove_open_prompts();
  self.open_completely = 1;

  if(!scripts\engine\utility::flag("door_second_interact") && isDefined(var_0) && var_0 == level.player)
    scripts\engine\utility::flag_set("door_second_interact");

  if(isDefined(var_0))
    self.opener = var_0;

  self notify("opened_completely", var_0);
  var_2 = scripts\engine\utility::ter_op(isPlayer(var_0), 1, 0);

  if(isai(self.opener))
    self notify("ai_opened");

  if(isDefined(var_0) || !isDefined(self.open_left))
    self.open_left = should_open_left();

  scripts\sp\door_internal::set_pivot_point(self.open_left);
  var_3 = undefined;

  if(self.open_left)
    var_3 = self.true_start_angles[1] + self.max_yaw_left;
  else
    var_3 = self.true_start_angles[1] - self.max_yaw_right;

  var_4 = scripts\sp\door_internal::get_door_audio_material();
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 1.5);
  var_5 = scripts\engine\utility::ter_op(isPlayer(var_0), "scrpt_door_" + var_4 + "_open_wide", "scrpt_door_" + var_4 + "_open_wide_npc");

  if(soundexists(var_5))
    self playSound(var_5);

  self.pivoting = 1;
  var_6 = 0.25;
  var_7 = 0.75;

  if(!var_2)
    var_6 = 0;

  self.pivot_ent rotateTo((self.angles[0], var_3, self.angles[2]), var_1, var_1 * var_6, var_1 * var_7);
  self notify("stop_door_creak");
  thread scripts\engine\sp\utility::notify_delay("open", var_1);

  if(isDefined(self.opener))
    self.opener notify("opened_door");

  wait(var_1);
  self.pivoting = undefined;
  thread scripts\sp\door_internal::suspicious_door_stealth_check(var_2);
  thread updatenavobstacle();
  scripts\sp\door_internal::updatenodelookpeek();
  self.active = 0;

  if(var_2)
    scripts\sp\door_internal::stealth_broadcast(128, "window_open");

  thread scripts\sp\door_internal::close_prompt();
}

door_close(var_0, var_1, var_2, var_3) {
  self notify("door_close");

  if(!isDefined(self.pivot_ent)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1.5;
    var_2 = var_1 * 0.25;
    var_3 = var_1 * 0.25;
  }

  self.pivoting = 1;
  self.pivot_ent rotateTo((self.angles[0], self.true_start_angles[1], self.angles[2]), var_1, var_2, var_3);
  wait(var_1);
  self.pivoting = undefined;
  thread updatenavobstacle();
  scripts\sp\door_internal::updatenodelookpeek();
}

reset_door() {
  self notify("stop_door_creak");
  self notify("reset_door");

  if(isDefined(self.pivot_ent))
    self.pivot_ent.angles = (self.pivot_ent.angles[0], self.true_start_angles[1], self.pivot_ent.angles[2]);

  thread updatenavobstacle();
  scripts\engine\utility::flag_clear("door_bashed");
  scripts\engine\utility::flag_clear("did_door_hint");
  scripts\engine\utility::flag_clear("door_second_interact");
  self thread[[level.interactive_doors.fndoorinit]](1);
}

updatenavobstacle(var_0) {
  if(isDefined(self.updatingnavobstacle)) {
    return;
  }
  waitframe();
  self.updatingnavobstacle = 1;

  if(isDefined(self.navobstacle))
    destroynavobstacle(self.navobstacle);

  if(istrue(self.locked) || istrue(self.bashed_full) || istrue(self.open_completely) || istrue(var_0)) {
    var_1 = get_door_angles();

    if(isDefined(self.clip))
      self.navobstacle = createnavbadplacebyent(self.clip, 14);

    if(isDefined(self.navobstacle)) {} else {}

    self.nav_lastupdatetime = gettime();
    self.nav_lastupdateangle = var_1[1];
  }

  self.updatingnavobstacle = undefined;
}

clear_navobstacle() {
  if(!isDefined(self.navobstacleid)) {
    return;
  }
  destroynavobstacle(self.navobstacleid);
  self.navobstacleid = undefined;
}

create_navobstacle() {
  if(isDefined(self.navobstacleid)) {
    return;
  }
  switch (self.team) {
    case "allies":
      self.navobstacleid = createnavbadplacebyent(self.clip, "axis", "team3", "neutral");
      break;
    case "axis":
      self.navobstacleid = createnavbadplacebyent(self.clip, "allies", "team3", "neutral");
      break;
    case "neutral":
      self.navobstacleid = createnavbadplacebyent(self.clip, "axis", "team3", "allies");
      break;
    case "team3":
      self.navobstacleid = createnavbadplacebyent(self.clip, "axis", "allies", "neutral");
      break;
    default:
      self.navobstacleid = createnavobstaclebyent(self.clip);
      break;
  }
}

delete_door() {
  self notify("unusable");
  remove_open_ability();

  if(isDefined(self.clip_nosight))
    self.clip_nosight delete();

  if(self.classname == "script_model")
    self.clip delete();

  if(isDefined(self.pivot_ent))
    self.pivot_ent delete();

  if(isDefined(self.navmodifier)) {
    destroynavobstacle(self.navmodifier);
    self.navmodifer = undefined;
  }

  if(isDefined(self.linked_ents)) {
    foreach(var_1 in self.linked_ents)
    var_1 delete();

    self.linked_ents = [];
  }

  level.interactive_doors.ents = scripts\engine\utility::array_remove(level.interactive_doors.ents, self);
  self delete();
}

get_all_bashable_doors() {
  var_0 = [];

  foreach(var_2 in level.interactive_doors.ents) {
    if(!var_2 scripts\engine\utility::ent_flag("initialized")) {
      continue;
    }
    if(var_2.bashed || var_2.open_completely || var_2.breached || var_2 scripts\sp\door_internal::door_is_half_open()) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

get_all_doors_ai_should_open() {
  var_0 = [];

  foreach(var_2 in level.interactive_doors.ents) {
    if(!var_2 scripts\engine\utility::ent_flag("initialized")) {
      continue;
    }
    if(var_2.bashed || var_2.open_completely || var_2.breached || var_2 scripts\sp\door_internal::door_is_open_at_least(60)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

get_all_closed_doors() {
  var_0 = [];

  foreach(var_2 in level.interactive_doors.ents) {
    if(var_2.bashed || var_2.ajar || var_2.open_completely || var_2.breached) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

get_all_interactive_doors() {
  return level.interactive_doors.ents;
}

get_all_interactive_doors_blocking_paths(var_0) {
  var_1 = [];

  foreach(var_3 in level.interactive_doors.ents) {
    if(isDefined(var_3.navobstacleid) && !scripts\engine\utility::is_equal(var_3.team, var_0))
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

bash_monitor() {
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_bash_monitor");

  for(;;) {
    if(bash_door_isplayerclose() && scripts\sp\door_internal::should_bash_open()) {
      self notify("attempt_bash", level.player);
      thread door_bash_open();

      if(!self.locked)
        return;
    }

    wait 0.05;
  }
}

interact_door_ispushentclose() {
  var_0 = scripts\sp\door_internal::get_pushent();
  var_1 = abs(var_0.origin[2] - self.origin[2]);

  if(var_1 < 20) {
    var_2 = scripts\sp\door_internal::interact_door_get_endpoint();
    var_3 = distancesquared(var_0.origin, var_2);

    if(var_3 < 1296)
      return 1;
  }

  return 0;
}

interact_door_dopusheffects() {
  var_0 = abs(level.player.origin[2] - self.origin[2]);

  if(var_0 < 20) {
    var_1 = scripts\sp\door_internal::interact_door_get_endpoint();
    var_2 = distancesquared(level.player.origin, var_1);

    if(var_2 < 14400)
      return 1;
  }

  return 0;
}

interact_door_isplayerfacing() {
  var_0 = scripts\sp\door_internal::interact_door_get_endpoint();
  var_1 = pointonsegmentnearesttopoint(var_0, self.origin, level.player.origin);
  var_2 = vectorNormalize(var_1 - level.player.origin);
  var_3 = anglesToForward(level.player.angles);

  if(vectordot(var_2, var_3) > 0.7)
    return 1;

  return 0;
}

bash_door_isplayerclose() {
  var_0 = abs(level.player.origin[2] - self.origin[2]);

  if(var_0 < 20) {
    var_1 = self.doorbottomcenter;

    if(!isDefined(var_1))
      var_1 = self.origin;

    var_2 = distancesquared(level.player.origin, var_1);
    var_3 = scripts\engine\utility::ter_op(self.locked == 1, 60, 60);

    if(var_2 < var_3 * var_3)
      return 1;
  }

  return 0;
}

double_doors_init_targetname(var_0) {
  var_1 = get_interactive_door(var_0);
  var_2 = get_interactive_door(var_0 + "_right");
  return double_doors_init(var_1, var_2);
}

double_doors_init(var_0, var_1) {
  var_2[0] = var_0;
  var_2[1] = var_1;
  var_0.doubledoorother = var_1;
  var_0.doubledoors = var_2;
  var_0 thread scripts\sp\door_internal::double_doors_waittill_interact();
  var_0 thread scripts\sp\door_internal::double_doors_waittill_bashed();
  var_0 thread scripts\sp\door_internal::double_doors_hint_pos(var_1);
  var_0 thread scripts\sp\door_internal::double_doors_waittill_open_completely();
  var_1 remove_open_prompts();
  var_1.doubledoorother = var_0;
  var_1.doubledoors = var_2;
  var_1 thread scripts\sp\door_internal::double_doors_waittill_bashed();
  var_1 thread scripts\sp\door_internal::double_doors_waittill_open_completely();

  if(var_1.locked && isDefined(var_1.unlock_volume)) {
    var_1 notify("unlock_volume_logic");
    var_1.unlock_volume thread scripts\sp\door_internal::unlock_volume_logic();
  }

  return var_0.doubledoors;
}

ai_monitor_doors() {
  self endon("death");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("path_has_door", "opened_door", "opening_door_done", "reset_door_check");
    scripts\engine\utility::flag_wait("interactive_doors_ready");
    self notify("stop_current_door");

    if(isDefined(self.isopeningdoor)) {
      continue;
    }
    if(isDefined(self.waitingfordoor)) {
      if(isDefined(var_0) && var_0 == "path_set" && isDefined(self.doornode) && isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.doornode.origin) < 4) {
        continue;
      }
      scripts\sp\door_ai::stop_waiting_for_door();
    }

    scripts\sp\door_ai::remove_as_opener();
    var_1 = 0;
    var_2 = undefined;
    var_3 = undefined;

    for(;;) {
      var_2 = self getmodifierlocationonpath("door");

      if(isDefined(var_2)) {
        var_3 = scripts\sp\door_ai::get_closed_door_closest_to_nav_modifier(var_2);

        if(isDefined(var_3)) {
          var_4 = var_3 scripts\sp\door_internal::get_door_bottom_center();

          if(distancesquared(self.origin, var_4) < 400) {
            var_5 = vectorNormalize(var_4 - self.origin);

            if(vectordot(self.lookaheaddir, var_5) < -0.707) {
              wait 2;
              continue;
            }
          }

          var_1 = 1;
          break;
        } else {
          wait 0.2;
          continue;
        }
      } else
        break;

      if(var_1) {
        break;
      }

      wait 0.05;
    }

    if(!var_1) {
      continue;
    }
    scripts\sp\door_ai::door_add_opener(var_3);
    var_3 thread scripts\sp\door_ai::door_manage_openers();
  }
}

add_pushent(var_0) {
  if(!isDefined(self.pushents))
    self.pushents = [];

  self.pushents[self.pushents.size] = var_0;
}