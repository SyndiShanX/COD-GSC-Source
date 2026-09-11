/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58310.gsc
***********************************************/

function ref_13d79() {
  self.thermiteradiusweaponref = anglesToForward(self.angles);
  self.initial_up = anglestoup(self.angles);
  self.thermitestuckpains = anglestoright(self.angles);

  if(!isDefined(level.targets_thinking)) {
    level.targets_thinking = 0;
  }

  level.targets_thinking++;
  self.down_angles = self.angles;
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(var1 in self.parts) {
    switch (var1.script_noteworthy) {
      case "target_plate":
        self.plate = var1;
        break;
      case "target_plate_dest":
        self.plate = var1;
        self.ref_123b5 = var1;
        break;
      case "target_arm":
        self.arm = var1;
        break;
      case "target_base":
        self.base = var1;
        break;
      case "target_wheels":
        self.wheels = var1;
        break;
      case "target_aim_assist":
        self.aim_assist = var1;
        break;
      case "target_collision":
        self.collision = var1;
        break;
      case "target_collision_down":
        self.collision_down = var1;
        break;
      case "target_collision_up":
        self.collision_up = var1;
        break;
      default:
        break;
    }

    var1.target = "null";
    var1.targetname = "null";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.wheels)) {
    self.wheels linkTo(self.base);
  }

  if(isDefined(self.base)) {
    if(isDefined(self.collision)) {
      self.collision linkTo(self.base);
    }

    if(isDefined(self.collision_down)) {
      self.collision_down linkTo(self.base);
    }

    if(isDefined(self.collision_up)) {
      self.collision_up linkTo(self.base);
    }
  }

  self.state_up = 0;
  self.flipping = 0;

  if(issubstr(self.script_noteworthy, "civilian")) {
    self.is_civilian = 1;
    level.civilian_targets[level.civilian_targets.size] = self;
  } else {
    self.is_civilian = 0;
    level.enemy_targets[level.enemy_targets.size] = self;
  }

  thread ref_13d72();

  if(isDefined(self.ref_123b5)) {
    thread ref_13d70();
  }

  self.activated = 0;
  thread ref_13d78();

  if(issubstr(self.script_noteworthy, "moving")) {
    thread ref_13d55();
  }

  if(isDefined(level.ref_13d7a)) {
    self[[level.ref_13d7a]]();
  }

  if(isDefined(level.ref_13d7b)) {
    self thread[[level.ref_13d7b]]();
  }

  level.targets_thinking--;
}

function gettargetarray() {
  var0 = ["standard_target", "standard_target_180", "standard_target_civilian", "lean_target", "lean_target_civilian", "moving_target", "moving_target_civilian"];
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = scripts\engine\utility::getStructArray(var0[var2], "script_noteworthy");

    foreach(var5 in var3[var2]) {
      var6 = spawn("script_origin", var5.origin);
      var6.angles = var5.angles;
      var6.script_gameobjectname = var5.script_gameobjectname;
      var6.script_linkname = var5.script_linkname;
      var6.script_noteworthy = var5.script_noteworthy;
      var6.target = var5.target;
      var6.targetname = var5.targetname;
    }
  }

  for(var2 = 0; var2 < var0.size; var2++) {
    var1 = getEntArray(var0[var2], "script_noteworthy");
  }

  return scripts\engine\utility::array_combine_multiple(var1);
}

function ref_13d72() {
  var0 = undefined;

  if(isDefined(self.ref_123b5)) {
    var1 = "trial_sfx_target_report_clay_smash";
    var0 = level.start_area_fx;
    goto LOC_00000027;
  }

  var1 = "trial_sfx_target_report_metal_light";

  for(;;) {
    self.activated = 0;

    while(self.state_up == 0) {
      waitframe();
    }

    self.plate waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);
    self.plate playSound(var1);

    if(self.is_civilian == 1) {
      level.player thread _tablethide::ref_13d4b(self, 0, 1, 0);
    } else {
      level.player thread _tablethide::ref_13d4b(self, 1, 0, 0);
    }

    self.activated = 1;

    if(var6 == "MOD_MELEE") {
      level.player notify("fake_weapon_fired");
    }

    if(self.is_civilian && isDefined(level.ref_13d71)) {
      self[[level.ref_13d71]]();
    } else if(isDefined(level.ref_13d73)) {
      self[[level.ref_13d73]]();
    }

    if(isDefined(level.ref_13d76) && self.plate tagexists("tag_head") && distance(self.plate gettagorigin("tag_head"), var5) <= 5) {
      self[[level.ref_13d76]]();
    }

    if(isDefined(var1)) {
      playFX(var1, var5);
    }

    if(isDefined(self.ref_123b5)) {
      self.ref_123b5 hide();
      wait randomfloatrange(0.7, 1);
    }

    thread ref_13d74("down");
    level waittill("course_ended");

    if(isDefined(self.ref_123b5)) {
      _tablethide::trial_ui_waittill_retry();
      self.ref_123b5 show();
    }
  }
}

function ref_13d74(var0) {
  if(var0 == "up") {
    if(isDefined(self.script_delay)) {
      wait self.script_delay;
    }

    self.plate setCanDamage(1);

    if(isDefined(self.aim_assist)) {
      self.aim_assist enableaimassist();
    }

    if(isDefined(self.collision_up)) {
      self.collision_up solid();
    }

    if(isDefined(self.collision_down)) {
      self.collision_up notsolid();
    }

    if(self.state_up == 1) {
      return;
    }

    self.state_up = 1;
    var1 = 1;
  } else {
    self.plate setCanDamage(0);

    if(isDefined(self.aim_assist)) {
      self.aim_assist disableaimassist();
    }

    if(isDefined(self.collision_up)) {
      self.collision_up notsolid();
    }

    if(isDefined(self.collision_down)) {
      self.collision_up solid();
    }

    if(self.state_up == 0) {
      return;
    }

    self.state_up = 0;
    var1 = -1;
  }

  var2 = undefined;
  var3 = undefined;

  switch (self.script_noteworthy) {
    case "standard_target_civilian":
    case "moving_target_civilian":
    case "moving_target":
    case "standard_target":
      var3 = 90;
      var2 = 0.2;
      break;
    case "lean_target_civilian":
    case "lean_target":
      var3 = 30;
      var2 = 0.15;
      break;
    case "standard_target_180":
      var3 = 180;
      var2 = 0.4;
      break;
    default:
      var3 = 90;
      var2 = 0.2;
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "moving")) {
    waitframe();
  }

  if(var1 == "up") {
    self playsoundonmovingent("trial_sfx_target_flipup");
  }

  if(self.thermitestuckpains[2] != 0) {
    self rotateYaw(-1 * self.thermitestuckpains[2] * var3 * var1, var2);
  } else {
    self rotatepitch(var3 * var1, var2);
  }

  wait var2;

  if(var1 == "down") {
    waitframe();
    self playsoundonmovingent("trial_sfx_target_flipdown");
    self.angles = self.down_angles;
  }

  self.flipping = 0;
}

function ref_13d55() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.course_movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }

  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  var0 = self.mover.origin - self.origin;
  self.mover.origin += var0;
  self.mover_ends[0].origin += var0;
  self.mover_ends[1].origin += var0;
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed)) {
    self.move_speed = self.script_speed;
  } else {
    self.move_speed = 32;
  }

  level waittill("player_spawned");
  thread ref_13d54();

  for(;;) {
    if(self.moving && (90 > distance(level.player.origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
      self.plate playSound("trial_sfx_target_move_stop");
      self.dummy thread scripts\engine\utility::stop_loop_sound_on_entity("trial_sfx_target_move_loop");
    } else if(self.flipping == 0 && self.moving == 0 && 90 < distance(level.player.origin, self.origin) && self.state_up == 1) {
      thread ref_13d53();
    }

    waitframe();
  }
}

function ref_13d53() {
  self endon("stop_moving");
  self.moving = 1;
  self.dummy = spawn("script_origin", self.origin);
  GscBinSkip4(0x35);
}

function ref_13d54() {
  for(;;) {
    level waittill("trial_results_screen_opened");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

function ref_13d75() {
  for(;;) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

function ref_13d70() {
  self.arm setCanDamage(1);

  for(;;) {
    self.arm waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(var4 == "MOD_EXPLOSIVE" || var4 == "MOD_GRENADE" || var4 == "MOD_GRENADE_SPLASH" && istrue(self.state_up)) {
      self.plate dodamage(1, self.plate.origin);
    }
  }
}

function ref_13d78() {
  waitframe();

  if(isDefined(self.targetname)) {
    var0 = getEntArray(self.targetname, "target");
    goto LOC_00000022;
  }

  var0 = [];

  for(;;) {
    var1 = 1;

    foreach(var3 in var0) {
      if(var3.activated == 0) {
        var1 = 0;
      }
    }

    if(var1 == 1) {
      ref_13d74("up");
      level waittill("course_ended");
    }

    waitframe();
  }
}

function ref_13d82() {
  var0 = getEntArray("end_checkpoint", "script_noteworthy");

  for(;;) {
    self.activated = 0;
    _tablethide::waittill_player_isDefined();

    if(isDefined(self.script_noteworthy)) {
      if(self.script_noteworthy != "start") {
        level waittill("course_started");
      }
    } else {
      level waittill("course_started");
    }

    while(level.player istouching(self)) {
      waitframe();
    }

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "end") {
      for(;;) {
        self waittill("trigger");

        if(break_window_glass(var0)) {
          break;
        }
      }
    } else {
      self waittill("trigger");
    }

    self.activated = 1;
    level notify("trigger_activated");

    if(isDefined(level.ref_13d81)) {
      self[[level.ref_13d81]]();
    }

    level waittill("course_ended");
  }
}

function break_window_glass(var0) {
  foreach(var2 in var0) {
    if(!var2.activated) {
      return false;
    }
  }

  return true;
}