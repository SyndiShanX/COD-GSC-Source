/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\cursor_hint.gsc
***********************************************/

function init_cursor_hint() {
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

function create_cursor_hint(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  var15 = self;

  if(isstruct(var15) || var15.classname == "script_origin" || isDefined(var1)) {
    var15 = spawn("script_origin", self.origin);
    self.cursor_hint_ent = var15;
    thread hint_ent_notify_trigger();
  }

  if(isDefined(var1)) {
    var16 = "tag_origin";

    if(isDefined(var0)) {
      var16 = var0;
      var15.origin = self gettagorigin(var16);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\engine\utility::hastag(self.model, var16)) {
      var15 linkTo(self, var16, var1, (0, 0, 0));
    } else if(isDefined(var0)) {
      var15 linkTo(self, var16, var1, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      var15.origin += rotatevector(var1, self.angles);

      if(isent(self)) {
        var15 linkTo(self);
      }
    } else {
      var15.origin += var1;

      if(isent(self)) {
        var15 linkTo(self);
      }
    }
  } else if(isDefined(var0)) {
    var15 sethinttag(var0);
  }

  if(isDefined(var8) && var8) {
    var15 setCursorHint("HINT_NOICON");
  } else {
    var15 setCursorHint("HINT_BUTTON");
  }

  if(isDefined(var2) && !scripts\engine\sp\utility::in_realism_mode()) {
    var15 setHintString(var2);
  }

  var17 = 360;

  if(isDefined(var3)) {
    var17 = var3;
  }

  var15 sethintdisplayfov(var17);
  var18 = 65;

  if(isDefined(var13)) {
    var18 = var13;
  }

  var15 setusefov(var18);
  var19 = 500;

  if(isDefined(var4)) {
    var19 = var4;
  }

  var15 sethintdisplayrange(var19);
  var20 = 80;

  if(isDefined(var5)) {
    var20 = var5;
  }

  var15 setuserange(var20);

  if(isDefined(var6) && var6) {
    var15 sethintonobstruction("show");
  } else {
    var15 sethintonobstruction("hide");
  }

  if(isDefined(var7) && var7) {
    var15 sethintrequiresmashing(var7);
  }

  if(!isDefined(var10)) {
    var10 = "duration_short";
  }

  var15 setuseholdduration(var10);

  if(var10 != "duration_none" && var10 != "duration_short") {
    var15 sethintrequiresholding(1);
  }

  thread hint_delete_on_trigger();

  if(isDefined(var9)) {
    var15 sethinticon(var9);
  }

  if(isDefined(var11)) {
    var15 setusecommand(var11);
  }

  if(isDefined(var12)) {
    var15 sethintlockplayermovement(1);
  } else {
    var15 sethintlockplayermovement(0);
  }

  if(isDefined(var14)) {
    thread internal_hint_toggle_use_by_angles(var15, var14, var20);
  }

  var15 makeusable();
}

function create_cursor_hint_forced(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  var15 = self;

  if(isstruct(var15) || var15.classname == "script_origin" || isDefined(var1)) {
    var15 = spawn("script_origin", self.origin);
    self.cursor_hint_ent = var15;
    thread hint_ent_notify_trigger();
  }

  if(isDefined(var1)) {
    var16 = "tag_origin";

    if(isDefined(var0)) {
      var16 = var0;
      var15.origin = self gettagorigin(var16);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\engine\utility::hastag(self.model, var16)) {
      var15 linkTo(self, var16, var1, (0, 0, 0));
    } else if(isDefined(var0)) {
      var15 linkTo(self, var16, var1, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      var15.origin += rotatevector(var1, self.angles);

      if(isent(self)) {
        var15 linkTo(self);
      }
    } else {
      var15.origin += var1;

      if(isent(self)) {
        var15 linkTo(self);
      }
    }
  } else if(isDefined(var0)) {
    var15 sethinttag(var0);
  }

  if(isDefined(var8) && var8) {
    var15 setCursorHint("HINT_NOICON");
  } else {
    var15 setCursorHint("HINT_BUTTON");
  }

  if(isDefined(var2)) {
    var15 setHintString(var2);
  }

  var17 = 360;

  if(isDefined(var3)) {
    var17 = var3;
  }

  var15 sethintdisplayfov(var17);
  var18 = 65;

  if(isDefined(var13)) {
    var18 = var13;
  }

  var15 setusefov(var18);
  var19 = 500;

  if(isDefined(var4)) {
    var19 = var4;
  }

  var15 sethintdisplayrange(var19);
  var20 = 80;

  if(isDefined(var5)) {
    var20 = var5;
  }

  var15 setuserange(var20);

  if(isDefined(var6) && var6) {
    var15 sethintonobstruction("show");
  } else {
    var15 sethintonobstruction("hide");
  }

  if(isDefined(var7) && var7) {
    var15 sethintrequiresmashing(var7);
  }

  if(!isDefined(var10)) {
    var10 = "duration_short";
  }

  var15 setuseholdduration(var10);

  if(var10 != "duration_none" && var10 != "duration_short") {
    var15 sethintrequiresholding(1);
  }

  thread hint_delete_on_trigger();

  if(isDefined(var9)) {
    var15 sethinticon(var9);
  }

  if(isDefined(var11)) {
    var15 setusecommand(var11);
  }

  if(isDefined(var12)) {
    var15 sethintlockplayermovement(1);
  } else {
    var15 sethintlockplayermovement(0);
  }

  if(isDefined(var14)) {
    thread internal_hint_toggle_use_by_angles(var15, var14, var20);
  }

  var15 makeusable();
}

function internal_hint_toggle_use_by_angles(var0, var1, var2) {
  self endon("death");
  self endon("hint_destroyed");
  level.player endon("death");
  var3 = 1;
  var4 = cos(var1);

  for(;;) {
    var5 = self.origin;
    var6 = self.angles;
    var7 = anglesToForward(var6);
    var8 = vectorNormalize(level.player getEye() - var5);
    var9 = vectordot(var7, var8);
    var10 = var9 >= var4;

    if(var10 != var3) {
      if(var10) {
        var0 setuserange(var2);
      } else {
        var0 setuserange(1);
      }

      var3 = var10;
    }

    waitframe();
  }
}

function hint_ent_notify_trigger() {
  self endon("death");
  self endon("hint_destroyed");
  self.cursor_hint_ent waittill("trigger", var0);
  self notify("trigger", var0);
}

function hint_delete_on_trigger() {
  self endon("hint_destroyed");
  var0 = self;

  if(isDefined(self.cursor_hint_ent)) {
    var0 = self.cursor_hint_ent;
  }

  hint_delete_on_trigger_waittill(var0);
  thread remove_cursor_hint();
}

function hint_delete_on_trigger_waittill(var0) {
  self endon("entitydeleted");
  var0 waittill("trigger");
}

function remove_cursor_hint() {
  var0 = self;

  if(isDefined(self.cursor_hint_ent)) {
    var0 = self.cursor_hint_ent;
    var0 scripts\engine\utility::delaycall(0.5, &delete);
  }

  if(isDefined(var0) && !isstruct(var0)) {
    var0 makeunusable();
  }

  if(isDefined(self)) {
    scripts\engine\sp\utility::notify_delay("hint_destroyed", 0.05);
    return;
  }
}

function hint_waittill_trigger() {
  var0 = scripts\engine\sp\utility::monitor_interact_delay(self, "stand");
  return var0;
}