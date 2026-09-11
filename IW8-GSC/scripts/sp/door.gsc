/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\door.gsc
***********************************************/

function init() {
  level.player notifyonplayercommand("melee_pressed", "+melee");
  level.player notifyonplayercommand("melee_pressed", "+melee_zoom");
  level.player notifyonplayercommand("melee_pressed", "+melee_breath");
  level.interactive_doors = spawnStruct();
  level.interactive_doors.ents = [];
  level.interactive_doors.got_hint = 0;
  level.interactive_doors.close_prompt = 0;
  level.interactive_doors.fndoorinit = &scripts\sp\door_internal::init_door_internal;
  level.interactive_doors.fnshoulddogesture = &scripts\sp\door_internal::should_do_gesture;
  level.interactive_doors.gesture_door = "ges_door_push_directional";
  level.interactive_doors.gesture_door_hard = "ges_door_push_directional_hard";
  level.interactive_doors.gesture_window = "ges_zg_wallbreach_mantle_left";
  level.interactive_doors.count = 0;
  level.interactive_doors.hint_dist_scale = 1;

  if(isDefined(level.door_hint_dist_scale)) {
    level.interactive_doors.hint_dist_scale = level.door_hint_dist_scale;
  }

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
  var0 = scripts\engine\utility::getStructArray("interactive_window", "targetname");
  scripts\engine\utility::array_thread(var0, &scripts\sp\door_internal::init_window);
}

function get_interactive_door(var0) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var1 = [];

  foreach(var3 in level.interactive_doors.ents) {
    if(isDefined(var3.targetname) && var3.targetname == var0) {
      var1 = var3;
    }
  }

  if(!var1.size) {
    return undefined;
  }

  if(var1.size == 1) {
    return var1[0];
  }
}

function get_interactive_door_array(var0) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");
  var1 = [];

  foreach(var3 in level.interactive_doors.ents) {
    if(isDefined(var3.targetname) && var3.targetname == var0) {
      var1 = var3;
    }
  }

  if(!var1.size) {
    return undefined;
  }

  return var1;
}

function unlock_all_doors(var0) {
  scripts\engine\utility::flag_wait("interactive_doors_ready");

  foreach(var2 in level.interactive_doors.ents) {
    if(var2.locked) {
      unlock_door(var2, var0);
    }
  }
}

function unlock_door(var0) {
  if(isDefined(var0) && !var0) {
    return;
  }

  self notify("stop_open_interact");
  self notify("door_unlock");
  self.locked = 0;

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    remove_open_interact_hint(self.open_struct);
    self.open_struct.no_open_interact = undefined;
    self.open_struct scripts\engine\utility::delaythread(0.05, &scripts\sp\door_internal::open_struct_logic);
    self.open_struct scripts\engine\utility::delaythread(0.05, &scripts\sp\door_internal::refresh_open_struct);
  }

  clear_navobstacle();

  if(isDefined(self.doubledoorother) && self.doubledoorother.locked) {
    unlock_door(self.doubledoorother, var0);
    return;
  }
}

function lock_door() {
  self notify("stop_open_interact");
  self notify("door_lock");
  self.locked = 1;

  if(isDefined(self.unlock_volume) && !istrue(self.unlock_volume.active)) {
    self.unlock_volume thread scripts\sp\door_internal::unlock_volume_logic();
  }

  if(!isDefined(self.doubledoors) || self == self.doubledoors[0]) {
    remove_open_interact_hint(self.open_struct);
    self.open_struct scripts\engine\utility::delaythread(0.05, &scripts\sp\door_internal::open_struct_logic);
  }

  create_navobstacle();

  if(isDefined(self.doubledoorother) && !self.doubledoorother.locked) {
    lock_door(self.doubledoorother);
    return;
  }
}

function init_max_yaws() {
  scripts\sp\door_internal::get_max_yaw(1);
  scripts\sp\door_internal::get_max_yaw(0);
  scripts\engine\utility::ent_flag_set("initialized");
}

function remove_open_ability() {
  self notify("stop_bash_monitor");
  self notify("stop_open_ability");
  remove_open_prompts();
}

function should_open_left(var0, var1) {
  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::ter_op(isDefined(self.opener), self.opener, level.player);
  }

  var2 = undefined;
  var3 = self.origin;

  if(!isDefined(var0)) {
    var0 = vectortoangles(self.forward);
  }

  if(isDefined(self.pivot_ent)) {
    var3 = self.pivot_ent.origin;
    var0 = self.pivot_ent.angles;
  }

  var4 = anglestoright(var0);
  var5 = vectorNormalize(var1.origin - var3);
  var6 = vectordot(var4, var5);

  if(var6 > 0) {
    return 1;
  }

  return 0;
}

function create_open_interact_hint(var0) {
  var1 = var0;

  if(!isDefined(var1)) {
    var1 = self.custom_hint_text;

    if(!isDefined(var1)) {
      if(self.door scripts\sp\door_internal::door_bashable_by_player(1)) {
        var1 = &"SCRIPT/DOOR_HINT_USE";
      } else {
        var1 = &"SCRIPT/DOOR_HINT_USE_NO_BASH";
      }
    }
  }

  if(!istrue(self.openinteract) || !isDefined(self.cursor_hint_ent)) {
    if(!istrue(self.no_open_interact)) {
      scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var1, 45, 200 * level.interactive_doors.hint_dist_scale, 55 * level.interactive_doors.hint_dist_scale, 0);
      self.cursor_hint_ent setusewhenhandsoccupied(1);
      self.cursor_hint_ent.door = self.door;
      self.openinteract = 1;
    }
  } else if(!scripts\engine\sp\utility::in_realism_mode()) {
    self.cursor_hint_ent setHintString(var1);
  }

  if(isDefined(var0)) {
    self.custom_hint_text = var0;
    return;
  }
}

function remove_open_interact_hint() {
  if(istrue(self.openinteract)) {
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    self.openinteract = 0;
  }

  self.no_open_interact = 1;
}

function door_ajar(var0) {
  if(isDefined(self.door_ajar_custom_func)) {
    [[self.door_ajar_custom_func]]();
  }

  self.ajar = 1;

  if(isDefined(self.ajar_opener)) {
    var0 = self.ajar_opener;
  } else if(!isDefined(var0)) {
    var0 = level.player;
  }

  if(isPlayer(var0)) {
    scripts\sp\door_internal::stealth_broadcast(40, "window_open");
  }

  self.opener = var0;
  self.open_left = should_open_left();
  scripts\sp\door_internal::set_pivot_point(self.open_left);

  if(isDefined(self.ajar_opener)) {
    self.opener = undefined;
  }

  if(isDefined(self.script_spawn_open_yaw)) {
    self.pivot_ent.angles += (0, self.script_spawn_open_yaw, 0);
    self notify("ajar");

    if(self.script_spawn_open_yaw > 0) {
      self.hinge_side = "open_left";
      self.open_left = 1;
      return;
    }

    self.hinge_side = "open_right";
    self.open_left = 0;
    return;
  }

  var1 = 1.5;
  var2 = 9;

  if(!self.open_left) {
    var2 *= -1;
  }

  level.player playRumbleOnEntity("damage_heavy");
  var3 = scripts\sp\door_internal::get_door_audio_material();
  var4 = "scrpt_door_" + var3 + "_open_soft";

  if(soundexists(var4)) {
    self playSound(var4);
  }

  self.pivoting = 1;
  self.pivot_ent rotateYaw(var2, var1, var1 * 0.25, var1 * 0.75);
  thread scripts\engine\sp\utility::notify_delay("ajar", var1);
  wait var1;
  self.pivoting = undefined;
}

function get_door_angles() {
  if(isDefined(self.pivot_ent)) {
    return self.pivot_ent.angles;
  }

  return self.true_start_angles;
}

function angle_diff(var0, var1) {
  var2 = angleclamp180(var0 - var1);
  return var2;
}

function door_bash_open(var0) {
  self endon("entitydeleted");

  if(istrue(self.bashed_full)) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = level.player;
  }

  self.opener = var0;

  if(var0 == level.player && self.locked) {
    scripts\sp\door_internal::bashed_locked_door(level.player getvelocity());
    return;
  }

  if(!scripts\engine\utility::flag("door_bashed")) {
    scripts\engine\utility::flag_set("door_bashed");
  }

  thread remove_open_prompts();
  self.open_left = should_open_left();
  scripts\sp\door_internal::set_pivot_point(self.open_left);

  if(var0 == level.player) {
    thread scripts\sp\door_internal::door_bash_presentation();
    level.player notify("door_bashed", self);
  } else {
    self notify("ai_opened");
  }

  var1 = 1;

  if(isDefined(self.bashscale) && self.bashscale < 1) {
    var1 = self.bashscale;
  }

  self.bashed = 1;
  self notify("bashed", var0);
  var2 = scripts\sp\door_internal::get_bash_yaw(var1);

  if(var1 == 1 && !istrue(self.bashblocked)) {
    self notify("bashed_full");
    self.bashed_full = 1;
  }

  if(var1 == 1) {
    var3 = 0.25;
    var4 = 0.5;
  } else {
    var3 = 0.4;
    var4 = 0.75;
  }

  var5 = var4 - self.true_start_angles[1];
  var6 = scripts\engine\math::normalize_value(0, 170, abs(var5));
  var7 = scripts\engine\math::factor_value(var3, var4, var6);
  self.bashtime = var7;
  var8 = get_door_angles();
  var9 = (var8[0], var4, var8[2]);
  var10 = scripts\sp\door_internal::get_door_audio_material();
  var11 = "scrpt_door_" + var10 + "_bash";

  if(soundexists(var11)) {
    playworldsound(var11, self.origin + (0, 0, 30));
  }

  self.bash_opening = 1;
  self.pivoting = 1;

  if(var3 == 1) {
    self.pivot_ent rotateTo(var9, var7);
  } else {
    self.pivot_ent rotateTo(var9, var7, 0, var7);
  }

  thread scripts\engine\sp\utility::notify_delay("open", var7);
  wait var7;
  self.opener notify("opened_door");
  thread updatenavobstacle();
  scripts\sp\door_internal::updatenodelookpeek();

  if(var2 == level.player) {
    if(isDefined(level.stealth)) {
      thread scripts\sp\door_internal::stealth_broadcast(450, "combat");
    } else {
      thread scripts\sp\door_internal::combat_getinfoinradius(450);
    }
  }

  if(var3 == 1 && abs(var5) > 100 && !istrue(self.disable_bounceback)) {
    self playSound("door_hit_wall");
    self.active = 0;
    var12 = randomfloatrange(3, 5);
    var13 = scripts\engine\utility::ter_op(self.open_left, -3, 3);
    var11 = "scrpt_door_" + var10 + "_creak_lp";

    if(soundexists(var11)) {
      self playLoopSound(var11);
    }

    self scalevolume(0, var12);
    self.pivot_ent rotateTo(var9 + (0, var13, 0), var12, 0.5, var12 - 0.5);
    wait var12;
    self stoploopsound();
    thread updatenavobstacle();
  } else {
    wait 0.05;
  }

  self.pivoting = undefined;
  thread scripts\sp\door_internal::close_prompt();
  self.bash_opening = undefined;
  self.bashblocked = undefined;
}

function remove_open_prompts() {
  remove_open_interact_hint(self.open_struct);
}

function door_open_completely(var0, var1) {
  self notify("stop_push_open");
  self notify("stop_bash_monitor");
  self notify("close_prompt");
  self notify("stop_open_interact");
  self endon("stop_monitoring_open_completely");
  self endon("entitydeleted");
  remove_open_prompts();
  self.open_completely = 1;

  if(!scripts\engine\utility::flag("door_second_interact") && isDefined(var0) && var0 == level.player) {
    scripts\engine\utility::flag_set("door_second_interact");
  }

  if(isDefined(var0)) {
    self.opener = var0;
  }

  self notify("opened_completely", var0);
  var2 = scripts\engine\utility::ter_op(isPlayer(var0), 1, 0);

  if(isai(self.opener)) {
    self notify("ai_opened");
  }

  if(isDefined(var0) || !isDefined(self.open_left)) {
    self.open_left = should_open_left();
  }

  scripts\sp\door_internal::set_pivot_point(self.open_left);
  var3 = undefined;

  if(self.open_left) {
    var3 = self.true_start_angles[1] + self.max_yaw_left;
  } else {
    var3 = self.true_start_angles[1] - self.max_yaw_right;
  }

  var4 = scripts\sp\door_internal::get_door_audio_material();
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 1.5);
  var5 = scripts\engine\utility::ter_op(isPlayer(var0), "scrpt_door_" + var4 + "_open_wide", "scrpt_door_" + var4 + "_open_wide_npc");

  if(soundexists(var5)) {
    self playSound(var5);
  }

  self.pivoting = 1;
  var6 = 0.25;
  var7 = 0.75;

  if(!var2) {
    var6 = 0;
  }

  self.pivot_ent rotateTo((self.angles[0], var3, self.angles[2]), var1, var1 * var6, var1 * var7);
  self notify("stop_door_creak");
  thread scripts\engine\sp\utility::notify_delay("open", var1);

  if(isDefined(self.opener)) {
    self.opener notify("opened_door");
  }

  wait var1;
  self.pivoting = undefined;
  thread scripts\sp\door_internal::suspicious_door_stealth_check(var2);
  thread updatenavobstacle();
  scripts\sp\door_internal::updatenodelookpeek();
  self.active = 0;

  if(var2) {
    scripts\sp\door_internal::stealth_broadcast(128, "window_open");
  }

  thread scripts\sp\door_internal::close_prompt();
}

function door_close(var0, var1, var2, var3) {
  self notify("door_close");

  if(!isDefined(self.pivot_ent)) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 1.5;
    var2 = var1 * 0.25;
    var3 = var1 * 0.25;
  }

  self.pivoting = 1;
  self.pivot_ent rotateTo((self.angles[0], self.true_start_angles[1], self.angles[2]), var1, var2, var3);
  wait var1;
  self.pivoting = undefined;
  thread updatenavobstacle();
  scripts\sp\door_internal::updatenodelookpeek();
}

function reset_door() {
  self notify("stop_door_creak");
  self notify("reset_door");

  if(isDefined(self.pivot_ent)) {
    self.pivot_ent.angles = (self.pivot_ent.angles[0], self.true_start_angles[1], self.pivot_ent.angles[2]);
  }

  thread updatenavobstacle();
  scripts\engine\utility::flag_clear("door_bashed");
  scripts\engine\utility::flag_clear("did_door_hint");
  scripts\engine\utility::flag_clear("door_second_interact");
  self thread[[level.interactive_doors.fndoorinit]](1);
}

function updatenavobstacle(var0) {
  if(isDefined(self.updatingnavobstacle)) {
    return;
  }

  waitframe();
  self.updatingnavobstacle = 1;

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
  }

  if(istrue(self.locked) || istrue(self.bashed_full) || istrue(self.open_completely) || istrue(var0)) {
    var1 = get_door_angles();

    if(isDefined(self.clip)) {
      self.navobstacle = createnavbadplacebyent(self.clip, 14);
    }

    if(isDefined(self.navobstacle)) {}

    self.nav_lastupdatetime = gettime();
    self.nav_lastupdateangle = var1[1];
  }

  self.updatingnavobstacle = undefined;
}

function clear_navobstacle() {
  if(!isDefined(self.navobstacleid)) {
    return;
  }

  destroynavobstacle(self.navobstacleid);
  self.navobstacleid = undefined;
}

function create_navobstacle() {
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
  }

  if(isDefined(self.linked_ents)) {
    foreach(var1 in self.linked_ents) {
      var1 delete();
    }

    self.linked_ents = [];
  }

  level.interactive_doors.ents = scripts\engine\utility::array_remove(level.interactive_doors.ents, self);
  self delete();
}

function get_all_bashable_doors() {
  var0 = [];

  foreach(var2 in level.interactive_doors.ents) {
    if(!var2 scripts\engine\utility::ent_flag("initialized")) {
      continue;
    }

    if(var2.bashed || var2.open_completely || var2.breached || var2 scripts\sp\door_internal::door_is_half_open()) {
      continue;
    }

    var0 = var2;
  }

  return var0;
}

function get_all_doors_ai_should_open() {
  var0 = [];

  foreach(var2 in level.interactive_doors.ents) {
    if(!var2 scripts\engine\utility::ent_flag("initialized")) {
      continue;
    }

    if(var2.bashed || var2.open_completely || var2.breached || var2 scripts\sp\door_internal::door_is_open_at_least(60)) {
      continue;
    }

    var0 = var2;
  }

  return var0;
}

function get_all_closed_doors() {
  var0 = [];

  foreach(var2 in level.interactive_doors.ents) {
    if(var2.bashed || var2.ajar || var2.open_completely || var2.breached) {
      continue;
    }

    var0 = var2;
  }

  return var0;
}

function get_all_interactive_doors() {
  return level.interactive_doors.ents;
}

function get_all_interactive_doors_blocking_paths(var0) {
  var1 = [];

  foreach(var3 in level.interactive_doors.ents) {
    if(isDefined(var3.navobstacleid) && !scripts\engine\utility::is_equal(var3.team, var0)) {
      var1 = var3;
    }
  }

  return var1;
}

function bash_monitor() {
  self endon("reset_door");
  self endon("entitydeleted");
  self endon("stop_bash_monitor");

  for(;;) {
    if(bash_door_isplayerclose() && scripts\sp\door_internal::should_bash_open()) {
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
  var0 = scripts\sp\door_internal::get_pushent();
  var1 = abs(var0.origin[2] - self.origin[2]);

  if(var1 < 20) {
    var2 = scripts\sp\door_internal::interact_door_get_endpoint();
    var3 = distancesquared(var0.origin, var2);

    if(var3 < 1296) {
      return true;
    }
  }

  return false;
}

function interact_door_dopusheffects() {
  var0 = abs(level.player.origin[2] - self.origin[2]);

  if(var0 < 20) {
    var1 = scripts\sp\door_internal::interact_door_get_endpoint();
    var2 = distancesquared(level.player.origin, var1);

    if(var2 < 14400) {
      return true;
    }
  }

  return false;
}

function interact_door_isplayerfacing() {
  var0 = scripts\sp\door_internal::interact_door_get_endpoint();
  var1 = pointonsegmentnearesttopoint(var0, self.origin, level.player.origin);
  var2 = vectorNormalize(var1 - level.player.origin);
  var3 = anglesToForward(level.player.angles);

  if(vectordot(var2, var3) > 0.7) {
    return true;
  }

  return false;
}

function bash_door_isplayerclose() {
  var0 = abs(level.player.origin[2] - self.origin[2]);

  if(var0 < 20) {
    var1 = self.doorbottomcenter;

    if(!isDefined(var1)) {
      var1 = self.origin;
    }

    var2 = distancesquared(level.player.origin, var1);
    var3 = scripts\engine\utility::ter_op(self.locked == 1, 60, 60);

    if(var2 < var3 * var3) {
      return true;
    }
  }

  return false;
}

function double_doors_init_targetname(var0) {
  var1 = get_interactive_door(var0);
  var2 = get_interactive_door(var0 + "_right");
  return double_doors_init(var1, var2);
}

function double_doors_init(var0, var1) {
  GscBinSkip1(0x45, 0, var0);
}

function ai_monitor_doors() {
  self endon("death");

  for(;;) {
    var0 = scripts\engine\utility::waittill_any_return("path_has_door", "opened_door", "opening_door_done", "reset_door_check");
    scripts\engine\utility::flag_wait("interactive_doors_ready");
    self notify("stop_current_door");

    if(isDefined(self.isopeningdoor)) {
      continue;
    }

    if(isDefined(self.waitingfordoor)) {
      if(isDefined(var0) && var0 == "path_set" && isDefined(self.doornode) && isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.doornode.origin) < 4) {
        continue;
      }

      scripts\sp\door_ai::stop_waiting_for_door();
    }

    scripts\sp\door_ai::remove_as_opener();
    var1 = 0;
    var2 = undefined;
    var3 = undefined;

    for(;;) {
      var2 = self getmodifierlocationonpath("door");

      if(isDefined(var2)) {
        var3 = scripts\sp\door_ai::get_closed_door_closest_to_nav_modifier(var2);

        if(isDefined(var3)) {
          var4 = var3 scripts\sp\door_internal::get_door_bottom_center();

          if(distancesquared(self.origin, var4) < 400) {
            var5 = vectorNormalize(var4 - self.origin);

            if(vectordot(self.lookaheaddir, var5) < -0.707) {
              wait 2;
              continue;
            }
          }

          var1 = 1;
          break;
        } else {
          wait 0.2;
          continue;
        }
      } else {
        break;
      }

      if(var1) {
        break;
      }

      wait 0.05;
    }

    if(!var1) {
      continue;
    }

    scripts\sp\door_ai::door_add_opener(var3);
    var3 thread scripts\sp\door_ai::door_manage_openers();
  }
}

function add_pushent(var0) {
  if(!isDefined(self.pushents)) {
    self.pushents = [];
  }

  self.pushents[self.pushents.size] = var0;
}