/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\scriptable_door.gsc
***********************************************/

function scriptable_door_timer_elapsed(var0, var1) {
  if(!isDefined(var0)) {
    return true;
  }

  if(gettime() - var0 > var1) {
    return true;
  }

  return false;
}

function scriptable_door_side_flip(var0) {
  if(var0 == "left") {
    return "right";
  }

  return "left";
}

function scriptable_door_side_get_for_state(var0) {
  if(issubstr(var0, "left")) {
    return "left";
  }

  if(issubstr(var0, "right")) {
    return "right";
  }

  return "none";
}

function scriptable_door_state_name_make(var0, var1) {
  return var0 + "_" + var1;
}

function scriptable_door_get_angle_delta() {
  var0 = angleclamp180(self.angles[1]);

  if(self.baseangle < 0 && var0 > 0) {
    var0 -= 360;
  }

  if(self.baseangle > 0 && var0 < 0) {
    var0 += 360;
  }

  var1 = var0 - self.baseangle;
  return abs(var1);
}

function scriptable_door_get_angle_step_begin(var0) {
  var1 = int(var0 / float(10)) * 10;
  var1 += 10;

  if(var1 < 20) {
    var1 = 20;
  }

  if(var1 >= 90) {
    var1 = 90;
  }

  return var1;
}

function scriptable_door_get_closest_state(var0, var1, var2) {
  var3 = scriptable_door_get_angle_step_begin(var2);
  var4 = var3;

  while(var4 <= 90) {
    var5 = scriptable_door_state_name_make(var1, var4);

    if(self getscriptableparthasstate(var0, var5)) {
      return var5;
    }

    var4 += 10;
  }

  var5 = scriptable_door_state_name_make(var1, 90);
  return var5;
}

function scriptable_door_init() {
  var0 = self getscriptablepartstateeventfield("door", "setup", "scriptable_event_model", "radius");
  self.panelwidth = var0 * 0.5;
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

    var0 = scripts\engine\math::vector_project_endpoint(self.origin, self.angles, self.panelwidth * 0.5);

    if(distancesquared(self.owner.origin, var0) > squared(self.panelwidth)) {
      scriptable_door_unclaim();
      return;
    }
  }
}

function scriptable_door_claim(var0) {
  self.owner = var0;
  thread scriptable_door_unclaim_think();
}

function scriptable_door_claim_update_on_state_change(var0, var1) {
  if(var1 == "closed") {
    if(isDefined(self.owner)) {
      scriptable_door_unclaim();
      return;
    }

    return;
  }

  if(!isDefined(self.owner)) {
    scriptable_door_claim(var0);
    return;
  }
}

function bashopen(var0) {
  if(isDefined(var0) && isPlayer(var0)) {
    if(!isai(var0)) {
      var0 playRumbleOnEntity("grenade_rumble");
      var0 earthquakeforplayer(0.35, 0.5, var0.origin, 200);
      return;
    }

    return;
  }
}

function shouldbashopen(var0) {
  if(!isalive(var0) || isDefined(var0.fauxdead)) {
    return false;
  }

  var1 = anglesToForward(var0.angles);
  var2 = scripts\engine\math::vector_project_endpoint(self.origin, self.angles, self.panelwidth * 0.5);
  var2 += (0, 0, self.panelwidth);

  if(scripts\engine\utility::within_fov(var0.origin + var1 * -45, var0.angles, var2, cos(43))) {
    var3 = anglestoright(self.angles);
    var4 = vectorNormalize(var2 - var0 getEye());
    var5 = vectordot(var1, var4);
    var6 = vectordot(var1, var3);
    var7 = var0 getvelocity();
    var8 = vectordot(vectorNormalize(var7), (0, 0, 1));

    if(length(var7) >= 200 && abs(var8) < 0.5 && abs(var6) > 0.75 && var5 > 0.75) {
      return true;
    }
  }

  return false;
}

function scriptable_door_hinge_progression(var0, var1) {
  var2 = "door";

  if(isDefined(self.owner) && var0 != self.owner) {
    return;
  }

  if(!isDefined(self.panelwidth)) {
    scriptable_door_init();
  }

  var3 = self getscriptablepartstate(var2);
  var4 = var3 == "closed" || var3 == "setup";
  var5 = 0;

  if(var4) {
    if(var1 == "touch") {
      if(shouldbashopen(var0)) {
        var5 = 1;
      } else {
        return;
      }
    } else if(istrue(self.locked)) {
      return;
    }
  }

  var6 = scripts\engine\math::vector_project_endpoint(self.origin, self.angles, self.panelwidth);
  var7 = scripts\engine\math::point_side_of_line2d(var0.origin, self.origin, var6);
  var8 = scriptable_door_side_flip(var7);
  var9 = scriptable_door_side_get_for_state(var3);
  var10 = scriptable_door_state_name_make(var8, 90);
  var11 = "none";

  if(var4) {
    var11 = var10;

    if(!self getscriptableparthasstate(var2, var11)) {
      var11 = scriptable_door_state_name_make(var7, 90);
    }
  } else if(var8 != var9) {
    var11 = "closed";
  } else if(var1 == "touch") {
    var11 = var10;
  } else if(!scriptable_door_timer_elapsed(self.lasthingechange, 700)) {
    var12 = scriptable_door_get_angle_delta();
    var11 = scriptable_door_get_closest_state(var2, var8, var12);
  } else {
    var11 = "closed";
  }

  if(var11 == var3) {
    return;
  }

  if(!self getscriptableparthasstate(var2, var11)) {
    return;
  }

  if(var11 == "closed") {
    self setscriptableuselargerbounds(1);
  } else {
    self setscriptableuselargerbounds(0);

    if(var5) {
      thread bashopen(var0);
    }
  }

  scriptable_door_claim_update_on_state_change(var0, var11);
  thread scriptable_door_auto_close(var2, var11);
  self setscriptablepartstate(var2, var11);
  self.lasthingechange = gettime();
  var0 notify("use_scriptable_door", self, var0, var2, var11);
}

function scriptable_door_auto_close(var0, var1) {
  if(!isDefined(level.scriptable_door_autoclose_delay)) {
    return;
  }

  self notify("door_wait_auto_close");
  self endon("door_wait_auto_close");

  if(!isDefined(level.scriptable_doors_opened)) {
    level.scriptable_doors_opened = [];
  }

  if(var1 == "closed") {
    level.scriptable_doors_opened[self.index] = undefined;
    return;
  }

  level.scriptable_doors_opened[self.index] = self;
  scripts\engine\utility::waittill_notify_or_timeout("scriptable_door_auto_close", level.scriptable_door_autoclose_delay);
  var2 = self getscriptablepartstate(var0);

  if(var2 == "closed") {
    return;
  }

  self setscriptableuselargerbounds(1);
  self setscriptablepartstate(var0, "closed");
  self.lasthingechange = gettime();
  level.scriptable_doors_opened[self.index] = undefined;
}

function scriptable_door_scriptable_used_callback(var0, var1, var2, var3, var4) {
  thread scriptable_door_hinge_progression(var0, var3);

  if(isDefined(var0.target)) {
    var5 = getentitylessscriptablearrayinradius(var0.target, "targetname");

    foreach(var7 in var5) {
      if(var7 getscriptablehaspart("door")) {
        thread scriptable_door_hinge_progression(var7, var3);
      }
    }
  }
}

function scriptable_door_scriptable_touched_callback(var0, var1, var2, var3) {
  if(var1 == "door") {
    thread scriptable_door_hinge_progression(var0, var3);
    return;
  }
}

function scriptable_door_postinit() {
  var0 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, "door");

  foreach(var2 in var0) {
    var2 setscriptableuselargerbounds(1);
    var3 = anglesToForward(var2.angles);
    var4 = var2.origin + var3 * 54 * 0.5;
    var2.heli_intro_vo_done = var4;
    var2.heli_intro = var2.angles;
  }
}

function system_init() {
  if(isDefined(level.scriptable_door_initialized)) {
    return;
  }

  scripts\engine\scriptable::scriptable_addpostinitcallback(&scriptable_door_postinit);
  scripts\engine\scriptable::ref_12f5b("door", &scriptable_door_scriptable_used_callback);
  scripts\engine\scriptable::scriptable_addtouchedcallback(&scriptable_door_scriptable_touched_callback);
  level.scriptable_door_initialized = 1;
}

function scriptable_door_enable_autoclose(var0) {
  if(!isDefined(var0)) {
    var0 = 20;
  }

  level.scriptable_door_autoclose_delay = var0;
}

function scriptable_door_disable_autoclose() {
  if(!isDefined(level.scriptable_door_autoclose_delay)) {
    return;
  }

  level.scriptable_door_autoclose_delay = undefined;

  if(!isDefined(level.scriptable_doors_opened)) {
    return;
  }

  foreach(var1 in level.scriptable_doors_opened) {
    var1 notify("door_wait_auto_close");
  }

  level.scriptable_doors_opened = [];
}

function scriptable_door_close_all_doors() {
  if(!isDefined(level.scriptable_doors_opened)) {
    return;
  }

  var0 = 0;

  foreach(var2 in level.scriptable_doors_opened) {
    var2 notify("scriptable_door_auto_close");
    var0++;

    if(var0 % 20 == 0) {
      var0 = 0;
      waitframe();
    }
  }
}