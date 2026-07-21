/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: engine\scriptable_door.gsc
***********************************************/

scriptable_door_timer_elapsed(var_0, var_1) {
  if(!isDefined(var_0))
    return 1;

  if(gettime() - var_0 > var_1)
    return 1;

  return 0;
}

scriptable_door_side_flip(var_0) {
  if(var_0 == "_encstr_A5AD056A019C63")
    return "_encstr_8253060E2B5FE330";

  return "_encstr_A5AD056A019C63";
}

scriptable_door_side_get_for_state(var_0) {
  if(issubstr(var_0, "_encstr_A5AD056A019C63"))
    return "_encstr_A5AD056A019C63";

  if(issubstr(var_0, "_encstr_8253060E2B5FE330"))
    return "_encstr_8253060E2B5FE330";

  return "_encstr_8BBA05185F8B99";
}

scriptable_door_state_name_make(var_0, var_1) {
  return var_0 + "_encstr_BA4C02DF" + var_1;
}

scriptable_door_get_angle_delta() {
  var_0 = angleclamp180(self.angles[1]);

  if(self.baseangle < 0 && var_0 > 0)
    var_0 = var_0 - 360;

  if(self.baseangle > 0 && var_0 < 0)
    var_0 = var_0 + 360;

  var_1 = var_0 - self.baseangle;
  return abs(var_1);
}

scriptable_door_get_angle_step_begin(var_0) {
  var_1 = int(var_0 / float(10)) * 10;
  var_1 = var_1 + 10;

  if(var_1 < 20)
    var_1 = 20;

  if(var_1 >= 90)
    var_1 = 90;

  return var_1;
}

scriptable_door_get_closest_state(var_0, var_1, var_2) {
  var_3 = scriptable_door_get_angle_step_begin(var_2);

  for(var_4 = var_3; var_4 <= 90; var_4 = var_4 + 10) {
    var_5 = scriptable_door_state_name_make(var_1, var_4);

    if(self getscriptableparthasstate(var_0, var_5))
      return var_5;
  }

  var_5 = scriptable_door_state_name_make(var_1, 90);
  return var_5;
}

scriptable_door_init() {
  var_0 = self getscriptablepartstateeventfield("_encstr_B16705D9AFE22E", "_encstr_9730063321C475D8", "_encstr_8862177B50AD1C83B3875244ADFE9F633B909331D87F97EFE8", "_encstr_8D4607ABF0ABE4FB47");
  self.panelwidth = var_0 * 0.5;
  self.baseangle = angleclamp180(self.angles[1]);
}

scriptable_door_unclaim() {
  self.owner = undefined;
}

scriptable_door_unclaim_think() {
  for(;;) {
    wait 1.0;

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

scriptable_door_claim(var_0) {
  self.owner = var_0;
  thread scriptable_door_unclaim_think();
}

scriptable_door_claim_update_on_state_change(var_0, var_1) {
  if(var_1 == "_encstr_A350079E35DACF8944") {
    if(isDefined(self.owner))
      scriptable_door_unclaim();
  } else if(!isDefined(self.owner))
    scriptable_door_claim(var_0);
}

bashopen(var_0) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!isai(var_0)) {
      var_0 playRumbleOnEntity("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9");
      var_0 earthquakeforplayer(0.35, 0.5, var_0.origin, 200);
    }
  }
}

shouldbashopen(var_0) {
  if(!isalive(var_0) || isDefined(var_0.fauxdead))
    return 0;

  var_1 = anglesToForward(var_0.angles);
  var_2 = scripts\engine\math::vector_project_endpoint(self.origin, self.angles, self.panelwidth * 0.5);
  var_2 = var_2 + (0, 0, self.panelwidth);

  if(scripts\engine\utility::within_fov(var_0.origin + var_1 * -45.0, var_0.angles, var_2, cos(43))) {
    var_3 = anglestoright(self.angles);
    var_4 = vectorNormalize(var_2 - var_0 getEye());
    var_5 = vectordot(var_1, var_4);
    var_6 = vectordot(var_1, var_3);
    var_7 = var_0 getvelocity();
    var_8 = vectordot(vectorNormalize(var_7), (0, 0, 1));

    if(length(var_7) >= 200 && abs(var_8) < 0.5 && abs(var_6) > 0.75 && var_5 > 0.75)
      return 1;
  }

  return 0;
}

scriptable_door_hinge_progression(var_0, var_1) {
  var_2 = "_encstr_B16705D9AFE22E";

  if(isDefined(self.owner) && var_0 != self.owner) {
    return;
  }
  if(!isDefined(self.panelwidth))
    scriptable_door_init();

  var_3 = self getscriptablepartstate(var_2);
  var_4 = var_3 == "_encstr_A350079E35DACF8944" || var_3 == "_encstr_9730063321C475D8";
  var_5 = 0;

  if(var_4) {
    if(var_1 == "_encstr_8D7D06302FE5E159") {
      if(shouldbashopen(var_0))
        var_5 = 1;
      else
        return;
    } else if(istrue(self.locked))
      return;
  }

  var_6 = scripts\engine\math::vector_project_endpoint(self.origin, self.angles, self.panelwidth);
  var_7 = scripts\engine\math::point_side_of_line2d(var_0.origin, self.origin, var_6);
  var_8 = scriptable_door_side_flip(var_7);
  var_9 = scriptable_door_side_get_for_state(var_3);
  var_10 = scriptable_door_state_name_make(var_8, 90);
  var_11 = "_encstr_8BBA05185F8B99";

  if(var_4) {
    var_11 = var_10;

    if(!self getscriptableparthasstate(var_2, var_11))
      var_11 = scriptable_door_state_name_make(var_7, 90);
  } else if(var_8 != var_9)
    var_11 = "_encstr_A350079E35DACF8944";
  else if(var_1 == "_encstr_8D7D06302FE5E159")
    var_11 = var_10;
  else if(!scriptable_door_timer_elapsed(self.lasthingechange, 700)) {
    var_12 = scriptable_door_get_angle_delta();
    var_11 = scriptable_door_get_closest_state(var_2, var_8, var_12);
  } else
    var_11 = "_encstr_A350079E35DACF8944";

  if(var_11 == var_3) {
    return;
  }
  if(!self getscriptableparthasstate(var_2, var_11)) {
    return;
  }
  if(var_11 == "_encstr_A350079E35DACF8944")
    self setscriptableuselargerbounds(1);
  else {
    self setscriptableuselargerbounds(0);

    if(var_5)
      thread bashopen(var_0);
  }

  scriptable_door_claim_update_on_state_change(var_0, var_11);
  thread scriptable_door_auto_close(var_2, var_11);
  self setscriptablepartstate(var_2, var_11);
  self.lasthingechange = gettime();
  var_0 notify("_encstr_A95D145DB9ACEBE636935A1C4785C48D567D237BB739", self, var_0, var_2, var_11);
}

scriptable_door_auto_close(var_0, var_1) {
  if(!isDefined(level.scriptable_door_autoclose_delay)) {
    return;
  }
  self notify("_encstr_BE4115F95FF5B888FF0A3883F17F55400D977F71F75A58");
  self endon("_encstr_BE4115F95FF5B888FF0A3883F17F55400D977F71F75A58");

  if(!isDefined(level.scriptable_doors_opened))
    level.scriptable_doors_opened = [];

  if(var_1 == "_encstr_A350079E35DACF8944") {
    level.scriptable_doors_opened[self.index] = undefined;
    return;
  }

  level.scriptable_doors_opened[self.index] = self;
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_997C1BB93693A51CD10B4C3656BE8CDEBD397DC25D3ADBD71B367B37AC", level.scriptable_door_autoclose_delay);
  var_2 = self getscriptablepartstate(var_0);

  if(var_2 == "_encstr_A350079E35DACF8944") {
    return;
  }
  self setscriptableuselargerbounds(1);
  self setscriptablepartstate(var_0, "_encstr_A350079E35DACF8944");
  self.lasthingechange = gettime();
  level.scriptable_doors_opened[self.index] = undefined;
}

scriptable_door_scriptable_used_callback(var_0, var_1, var_2, var_3, var_4) {
  var_0 thread scriptable_door_hinge_progression(var_3, "_encstr_AB19049D0FC0");

  if(isDefined(var_0.target)) {
    var_5 = getentitylessscriptablearrayinradius(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_7 in var_5) {
      if(var_7 getscriptablehaspart("_encstr_B16705D9AFE22E"))
        var_7 thread scriptable_door_hinge_progression(var_3, "_encstr_AB19049D0FC0");
    }
  }
}

scriptable_door_scriptable_touched_callback(var_0, var_1, var_2, var_3) {
  if(var_1 == "_encstr_B16705D9AFE22E")
    var_0 thread scriptable_door_hinge_progression(var_3, "_encstr_8D7D06302FE5E159");
}

scriptable_door_postinit() {
  var_0 = getentitylessscriptablearrayinradius(undefined, undefined, undefined, undefined, "_encstr_B16705D9AFE22E");

  foreach(var_2 in var_0) {
    var_2 setscriptableuselargerbounds(1);
    var_3 = anglesToForward(var_2.angles);
    var_4 = var_2.origin + var_3 * 54 * 0.5;
    var_2.heli_intro_vo_done = var_4;
    var_2.heli_intro = var_2.angles;
  }
}

system_init() {
  if(isDefined(level.scriptable_door_initialized)) {
    return;
  }
  scripts\engine\scriptable::scriptable_addpostinitcallback(::scriptable_door_postinit);
  scripts\engine\scriptable::_id_12F5B("_encstr_B16705D9AFE22E", ::scriptable_door_scriptable_used_callback);
  scripts\engine\scriptable::scriptable_addtouchedcallback(::scriptable_door_scriptable_touched_callback);
  level.scriptable_door_initialized = 1;
}

scriptable_door_enable_autoclose(var_0) {
  if(!isDefined(var_0))
    var_0 = 20;

  level.scriptable_door_autoclose_delay = var_0;
}

scriptable_door_disable_autoclose() {
  if(!isDefined(level.scriptable_door_autoclose_delay)) {
    return;
  }
  level.scriptable_door_autoclose_delay = undefined;

  if(!isDefined(level.scriptable_doors_opened)) {
    return;
  }
  foreach(var_1 in level.scriptable_doors_opened)
  var_1 notify("_encstr_BE4115F95FF5B888FF0A3883F17F55400D977F71F75A58");

  level.scriptable_doors_opened = [];
}

scriptable_door_close_all_doors() {
  if(!isDefined(level.scriptable_doors_opened)) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level.scriptable_doors_opened) {
    var_2 notify("_encstr_997C1BB93693A51CD10B4C3656BE8CDEBD397DC25D3ADBD71B367B37AC");
    var_0++;

    if(var_0 % 20 == 0) {
      var_0 = 0;
      waitframe();
    }
  }
}