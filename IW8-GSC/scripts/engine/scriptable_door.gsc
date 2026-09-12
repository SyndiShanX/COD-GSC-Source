/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\scriptable_door.gsc
***********************************************/

function scriptable_door_timer_elapsed(var_0, var_1) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(gettime() - var_0 > var_1) {
    return true;
  }

  return false;
}

function scriptable_door_side_flip(var_0) {
  if(var_0 == "left") {
    return "right";
  }

  return "left";
}

function scriptable_door_side_get_for_state(var_0) {
  if(issubstr(var_0, "left")) {
    return "left";
  }

  if(issubstr(var_0, "right")) {
    return "right";
  }

  return "none";
}

function scriptable_door_state_name_make(var_0, var_1) {
  return var_0 + "_" + var_1;
}

function scriptable_door_get_angle_delta() {
  var_0 = angleclamp180(self.angles[1]);

  if(self.baseangle < 0 && var_0 > 0) {
    var_0 -= 360;
  }

  if(self.baseangle > 0 && var_0 < 0) {
    var_0 += 360;
  }

  var_1 = var_0 - self.baseangle;
  return abs(var_1);
}

function scriptable_door_get_angle_step_begin(var_0) {
  var_1 = int(var_0 / float(10)) * 10;
  var_1 += 10;

  if(var_1 < 20) {
    var_1 = 20;
  }

  if(var_1 >= 90) {
    var_1 = 90;
  }

  return var_1;
}

function scriptable_door_get_closest_state(var_0, var_1, var_2) {
  var_3 = scriptable_door_get_angle_step_begin(var_2);
  var_4 = var_3;

  while(var_4 <= 90) {
    var_5 = scriptable_door_state_name_make(var_1, var_4);

    if(self getscriptableparthasstate(var_0, var_5)) {
      return var_5;
    }

    var_4 += 10;
  }

  var_5 = scriptable_door_state_name_make(var_1, 90);
  return var_5;
}

function scriptable_door_init() {
  var_0 = self getscriptablepartstateeventfield("door", "setup", "scriptable_event_model", "radius");
  self.panelwidth = var_0 * 0.5;
  self.baseangle = angleclamp180(self.angles[1]);
}

function scriptable_door_unclaim() {
  self.owner = undefined;
}

function scriptable_door_unclaim_think() {
  for(;;) {
    wait 1;

    if(!isDefined(self.owner)) {
      return;
    }

    var_0 = scripts\engine\math::vector_project_endpoint(self.origin, self.angles, self.panelwidth * 0.5);

    if(distancesquared(self.owner.origin, var_0) > squared(self.panelwidth)) {
      scriptable_door_unclaim();
      return;
    }
  }
}

function scriptable_door_claim(var_0) {
  self.owner = var_0;
  thread scriptable_door_unclaim_think();
}

function scriptable_door_claim_update_on_state_change(var_0, var_1) {
  if(var_1 == "closed") {
    if(isDefined(self.owner)) {
      scriptable_door_unclaim();
      return;
    }

    return;
  }

  if(!isDefined(self.owner)) {
    scriptable_door_claim(var_0);
    return;
  }
}

function bashopen(var_0) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!isai(var_0)) {
      var_0 playRumbleOnEntity("grenade_rumble");
      var_0 earthquakeforplayer(0.35, 0.5, var_0.origin, 200);
      return;
    }

    return;
  }
}

function shouldbashopen(var_0) {
  if(!isalive(var_0) || isDefined(var_0.fauxdead)) {
    return false;
  }

  var_1 = anglesToForward(var_0.angles);
  var_2 = scripts\engine\math::vector_project_endpoint(self.origin, self.angles, self.panelwidth * 0.5);
  var_2 += (0, 0, self.panelwidth);

  if(scripts\engine\utility::within_fov(var_0.origin + var_1 * -45, var_0.angles, var_2, cos(43))) {
    var_3 = anglestoright(self.angles);
    var_4 = vectorNormalize(var_2 - var_0 getEye());
    var_5 = vectordot(var_1, var_4);
    var_6 = vectordot(var_1, var_3);
    var_7 = var_0 getvelocity();
    var_8 = vectordot(vectorNormalize(var_7), (0, 0, 1));

    if(length(var_7) >= 200 && abs(var_8) < 0.5 && abs(var_6) > 0.75 && var_5 > 0.75) {
      return true;
    }
  }

  return false;
}

function scriptable_door_hinge_progression(var_0, var_1) {
  var_2 = "door";

  if(isDefined(self.owner) && var_0 != self.owner) {
    return;
  }

  if(!isDefined(self.panelwidth)) {
    scriptable_door_init();
  }

  var_3 = self getscriptablepartstate(var_2);
  var_4 = var_3 == "closed" || var_3 == "setup";
  var_5 = 0;

  if(var_4) {
    if(var_1 == "touch") {
      if(shouldbashopen(var_0)) {
        var_5 = 1;
      } else {
        return;
      }
    } else if(istrue(self.locked)) {
      return;
    }
  }

  var_6 = scripts\engine\math::vector_project_endpoint(self.origin, self.angles, self.panelwidth);
  var_7 = scripts\engine\math::point_side_of_line2d(var_0.origin, self.origin, var_6);
  var_8 = scriptable_door_side_flip(var_7);
  var_9 = scriptable_door_side_get_for_state(var_3);
  var_10 = scriptable_door_state_name_make(var_8, 90);
  var_11 = "none";

  if(var_4) {
    var_11 = var_10;

    if(!self getscriptableparthasstate(var_2, var_11)) {
      var_11 = scriptable_door_state_name_make(var_7, 90);
    }
  } else if(var_8 != var_9) {
    var_11 = "closed";
  } else if(var_1 == "touch") {
    var_11 = var_10;
  } else if(!scriptable_door_timer_elapsed(self.lasthingechange, 700)) {
    var_12 = scriptable_door_get_angle_delta();
    var_11 = scriptable_door_get_closest_state(var_2, var_8, var_12);
  } else {
    var_11 = "closed";
  }

  if(var_11 == var_3) {
    return;
  }

  if(!self getscriptableparthasstate(var_2, var_11)) {
    return;
  }

  if(var_11 == "closed") {
    self setscriptableuselargerbounds(1);
  } else {
    self setscriptableuselargerbounds(0);

    if(var_5) {
      thread bashopen(var_0);
    }
  }

  scriptable_door_claim_update_on_state_change(var_0, var_11);
  thread scriptable_door_auto_close(var_2, var_11);
  self setscriptablepartstate(var_2, var_11);
  self.lasthingechange = gettime();
  var_0 notify("use_scriptable_door", self, var_0, var_2, var_11);
}

function scriptable_door_auto_close(var_0, var_1) {
  if(!isDefined(level.scriptable_door_autoclose_delay)) {
    return;
  }

  self notify("door_wait_auto_close");
  self endon("door_wait_auto_close");

  if(!isDefined(level.scriptable_doors_opened)) {
    level.scriptable_doors_opened = [];
  }

  if(var_1 == "closed") {
    level.scriptable_doors_opened[self.index] = undefined;
    return;
  }

  level.scriptable_doors_opened[self.index] = self;
  scripts\engine\utility::waittill_notify_or_timeout("scriptable_door_auto_close", level.scriptable_door_autoclose_delay);
  var_2 = self getscriptablepartstate(var_0);

  if(var_2 == "closed") {
    return;
  }

  self setscriptableuselargerbounds(1);
  self setscriptablepartstate(var_0, "closed");
  self.lasthingechange = gettime();
  level.scriptable_doors_opened[self.index] = undefined;
}

function scriptable_door_scriptable_used_callback(var_0, var_1, var_2, var_3, var_4) {
  thread scriptable_door_hinge_progression(var_0, var_3);

  if(isDefined(var_0.target)) {
    var_5 = getentitylessscriptablearrayinradius(var_0.target, "targetname");

    foreach(var_7 in var_5) {
      if(var_7 getscriptablehaspart("door")) {
        thread scriptable_door_hinge_progression(var_7, var_3);
      }
    }
  }
}

function scriptable_door_scriptable_touched_callback(var_0, var_1, var_2, var_3) {
  if(var_1 == "door") {
    thread scriptable_door_hinge_progression(var_0, var_3);
    return;
  }
}

function scriptable_door_postinit() {
  var_0 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, "door");

  foreach(var_2 in var_0) {
    var_2 setscriptableuselargerbounds(1);
    var_3 = anglesToForward(var_2.angles);
    var_4 = var_2.origin + var_3 * 54 * 0.5;
    var_2.heli_intro_vo_done = var_4;
    var_2.heli_intro = var_2.angles;
  }
}

function system_init() {
  if(isDefined(level.scriptable_door_initialized)) {
    return;
  }

  scripts\engine\scriptable::scriptable_addpostinitcallback(&scriptable_door_postinit);
  scripts\engine\scriptable::ref_12F5B("door", &scriptable_door_scriptable_used_callback);
  scripts\engine\scriptable::scriptable_addtouchedcallback(&scriptable_door_scriptable_touched_callback);
  level.scriptable_door_initialized = 1;
}

function scriptable_door_enable_autoclose(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 20;
  }

  level.scriptable_door_autoclose_delay = var_0;
}

function scriptable_door_disable_autoclose() {
  if(!isDefined(level.scriptable_door_autoclose_delay)) {
    return;
  }

  level.scriptable_door_autoclose_delay = undefined;

  if(!isDefined(level.scriptable_doors_opened)) {
    return;
  }

  foreach(var_1 in level.scriptable_doors_opened) {
    var_1 notify("door_wait_auto_close");
  }

  level.scriptable_doors_opened = [];
}

function scriptable_door_close_all_doors() {
  if(!isDefined(level.scriptable_doors_opened)) {
    return;
  }

  var_0 = 0;

  foreach(var_2 in level.scriptable_doors_opened) {
    var_2 notify("scriptable_door_auto_close");
    var_0++;

    if(var_0 % 20 == 0) {
      var_0 = 0;
      waitframe();
    }
  }
}