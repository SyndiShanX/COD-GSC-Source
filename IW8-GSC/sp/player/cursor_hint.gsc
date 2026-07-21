/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\cursor_hint.gsc
***********************************************/

init_cursor_hint() {
  setdvarifuninitialized("cursor_hint_debug", 0);
  precacheshader("cursor_hint_circle");
  precacheshader("cursor_hint_x");
  precacheshader("cursor_hint_square");
  precacheshader("alien_dpad_none");
  precacheshader("hud_arrow_up");
  precacheshader("hud_interaction_prompt_center_ammo");
  precacheshader("hud_scrap_medium_icon_test");
  precacheshader("hud_interaction_prompt_center_heavy");
  precacheshader("hud_interaction_prompt_center_steel_dragon");
  level.cursor_hints = [];
  level.cursor_hints_max = 1;
}

create_cursor_hint(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = self;

  if(isstruct(var_15) || var_15.classname == "script_origin" || isDefined(var_1)) {
    var_15 = spawn("script_origin", self.origin);
    self.cursor_hint_ent = var_15;
    thread hint_ent_notify_trigger();
  }

  if(isDefined(var_1)) {
    var_16 = "tag_origin";

    if(isDefined(var_0)) {
      var_16 = var_0;
      var_15.origin = self gettagorigin(var_16);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\engine\utility::hastag(self.model, var_16))
      var_15 linkTo(self, var_16, var_1, (0, 0, 0));
    else if(isDefined(var_0))
      var_15 linkTo(self, var_16, var_1, (0, 0, 0));
    else if(isDefined(self.angles)) {
      var_15.origin = var_15.origin + rotatevector(var_1, self.angles);

      if(isent(self))
        var_15 linkTo(self);
    } else {
      var_15.origin = var_15.origin + var_1;

      if(isent(self))
        var_15 linkTo(self);
    }
  } else if(isDefined(var_0))
    var_15 sethinttag(var_0);

  if(isDefined(var_8) && var_8)
    var_15 setCursorHint("HINT_NOICON");
  else
    var_15 setCursorHint("HINT_BUTTON");

  if(isDefined(var_2) && !scripts\engine\sp\utility::in_realism_mode())
    var_15 setHintString(var_2);

  var_17 = 360;

  if(isDefined(var_3))
    var_17 = var_3;

  var_15 sethintdisplayfov(var_17);
  var_18 = 65;

  if(isDefined(var_13))
    var_18 = var_13;

  var_15 setusefov(var_18);
  var_19 = 500;

  if(isDefined(var_4))
    var_19 = var_4;

  var_15 sethintdisplayrange(var_19);
  var_20 = 80;

  if(isDefined(var_5))
    var_20 = var_5;

  var_15 setuserange(var_20);

  if(isDefined(var_6) && var_6)
    var_15 sethintonobstruction("show");
  else
    var_15 sethintonobstruction("hide");

  if(isDefined(var_7) && var_7)
    var_15 sethintrequiresmashing(var_7);

  if(!isDefined(var_10))
    var_10 = "duration_short";

  var_15 setuseholdduration(var_10);

  if(var_10 != "duration_none" && var_10 != "duration_short")
    var_15 sethintrequiresholding(1);

  thread hint_delete_on_trigger();

  if(isDefined(var_9))
    var_15 sethinticon(var_9);

  if(isDefined(var_11))
    var_15 setusecommand(var_11);

  if(isDefined(var_12))
    var_15 sethintlockplayermovement(1);
  else
    var_15 sethintlockplayermovement(0);

  if(isDefined(var_14))
    thread internal_hint_toggle_use_by_angles(var_15, var_14, var_20);

  var_15 makeusable();
}

create_cursor_hint_forced(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = self;

  if(isstruct(var_15) || var_15.classname == "script_origin" || isDefined(var_1)) {
    var_15 = spawn("script_origin", self.origin);
    self.cursor_hint_ent = var_15;
    thread hint_ent_notify_trigger();
  }

  if(isDefined(var_1)) {
    var_16 = "tag_origin";

    if(isDefined(var_0)) {
      var_16 = var_0;
      var_15.origin = self gettagorigin(var_16);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\engine\utility::hastag(self.model, var_16))
      var_15 linkTo(self, var_16, var_1, (0, 0, 0));
    else if(isDefined(var_0))
      var_15 linkTo(self, var_16, var_1, (0, 0, 0));
    else if(isDefined(self.angles)) {
      var_15.origin = var_15.origin + rotatevector(var_1, self.angles);

      if(isent(self))
        var_15 linkTo(self);
    } else {
      var_15.origin = var_15.origin + var_1;

      if(isent(self))
        var_15 linkTo(self);
    }
  } else if(isDefined(var_0))
    var_15 sethinttag(var_0);

  if(isDefined(var_8) && var_8)
    var_15 setCursorHint("HINT_NOICON");
  else
    var_15 setCursorHint("HINT_BUTTON");

  if(isDefined(var_2))
    var_15 setHintString(var_2);

  var_17 = 360;

  if(isDefined(var_3))
    var_17 = var_3;

  var_15 sethintdisplayfov(var_17);
  var_18 = 65;

  if(isDefined(var_13))
    var_18 = var_13;

  var_15 setusefov(var_18);
  var_19 = 500;

  if(isDefined(var_4))
    var_19 = var_4;

  var_15 sethintdisplayrange(var_19);
  var_20 = 80;

  if(isDefined(var_5))
    var_20 = var_5;

  var_15 setuserange(var_20);

  if(isDefined(var_6) && var_6)
    var_15 sethintonobstruction("show");
  else
    var_15 sethintonobstruction("hide");

  if(isDefined(var_7) && var_7)
    var_15 sethintrequiresmashing(var_7);

  if(!isDefined(var_10))
    var_10 = "duration_short";

  var_15 setuseholdduration(var_10);

  if(var_10 != "duration_none" && var_10 != "duration_short")
    var_15 sethintrequiresholding(1);

  thread hint_delete_on_trigger();

  if(isDefined(var_9))
    var_15 sethinticon(var_9);

  if(isDefined(var_11))
    var_15 setusecommand(var_11);

  if(isDefined(var_12))
    var_15 sethintlockplayermovement(1);
  else
    var_15 sethintlockplayermovement(0);

  if(isDefined(var_14))
    thread internal_hint_toggle_use_by_angles(var_15, var_14, var_20);

  var_15 makeusable();
}

internal_hint_toggle_use_by_angles(var_0, var_1, var_2) {
  self endon("death");
  self endon("hint_destroyed");
  level.player endon("death");
  var_3 = 1;
  var_4 = cos(var_1);

  for(;;) {
    var_5 = self.origin;
    var_6 = self.angles;
    var_7 = anglesToForward(var_6);
    var_8 = vectorNormalize(level.player getEye() - var_5);
    var_9 = vectordot(var_7, var_8);
    var_10 = var_9 >= var_4;

    if(var_10 != var_3) {
      if(var_10)
        var_0 setuserange(var_2);
      else
        var_0 setuserange(1);

      var_3 = var_10;
    }

    waitframe();
  }
}

hint_ent_notify_trigger() {
  self endon("death");
  self endon("hint_destroyed");
  self.cursor_hint_ent waittill("trigger", var_0);
  self notify("trigger", var_0);
}

hint_delete_on_trigger() {
  self endon("hint_destroyed");
  var_0 = self;

  if(isDefined(self.cursor_hint_ent))
    var_0 = self.cursor_hint_ent;

  hint_delete_on_trigger_waittill(var_0);
  thread remove_cursor_hint();
}

hint_delete_on_trigger_waittill(var_0) {
  self endon("entitydeleted");
  var_0 waittill("trigger");
}

remove_cursor_hint() {
  var_0 = self;

  if(isDefined(self.cursor_hint_ent)) {
    var_0 = self.cursor_hint_ent;
    var_0 scripts\engine\utility::delaycall(0.5, ::delete);
  }

  if(isDefined(var_0) && !isstruct(var_0))
    var_0 makeunusable();

  if(isDefined(self))
    scripts\engine\sp\utility::notify_delay("hint_destroyed", 0.05);
}

hint_waittill_trigger() {
  var_0 = scripts\engine\sp\utility::monitor_interact_delay(self, "stand");
  return var_0;
}