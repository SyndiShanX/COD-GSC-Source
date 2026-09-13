/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_target_utility.gsc
******************************************************/

trial_target_think() {
  self.initial_forward = anglesToForward(self.angles);
  self.initial_up = anglestoup(self.angles);
  self.initial_right = anglestoright(self.angles);

  if(!isDefined(level.targets_thinking))
    level.targets_thinking = 0;

  level.targets_thinking++;
  self.down_angles = self.angles;
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(part in self.parts) {
    switch (part.script_noteworthy) {
      case "target_plate":
        self.plate = part;
        break;
      case "target_plate_dest":
        self.plate = part;
        self.plate_dest = part;
        break;
      case "target_arm":
        self.arm = part;
        break;
      case "target_base":
        self.base = part;
        break;
      case "target_wheels":
        self.wheels = part;
        break;
      case "target_aim_assist":
        self.aim_assist = part;
        break;
      case "target_collision":
        self.collision = part;
        break;
      case "target_collision_down":
        self.collision_down = part;
        break;
      case "target_collision_up":
        self.collision_up = part;
        break;
      default:
        break;
    }

    part.target = "null";
    part.targetname = "null";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.wheels))
    self.wheels linkTo(self.base);

  if(isDefined(self.base)) {
    if(isDefined(self.collision))
      self.collision linkTo(self.base);

    if(isDefined(self.collision_down))
      self.collision_down linkTo(self.base);

    if(isDefined(self.collision_up))
      self.collision_up linkTo(self.base);
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

  thread trial_target_damage();

  if(isDefined(self.plate_dest))
    thread trial_target_arm_damage();

  self.activated = 0;
  thread trial_target_requisites();

  if(issubstr(self.script_noteworthy, "moving")) {
    if(isDefined(level.trial["triggeredTrialName"]) && level.trial["triggeredTrialName"] == "trial_variant_cqb")
      thread _id_F75AB10A88D19CC4("trial_variant_cqb");
    else
      thread trial_moving_target_think();
  }

  if(isDefined(level.trial_target_think_func))
    self[[level.trial_target_think_func]]();

  if(isDefined(level.trial_target_thread_func))
    self thread[[level.trial_target_thread_func]]();

  level.targets_thinking--;
}

gettargetarray() {
  _id_3CA8A977F230716E = ["standard_target", "standard_target_180", "standard_target_civilian", "lean_target", "lean_target_civilian", "moving_target", "moving_target_civilian"];
  _id_53EE9B445DE3B69B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++) {
    _id_15684233DC41D60A[_id_AC0E594AC96AA3A8] = scripts\engine\utility::getStructArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

    foreach(struct in _id_15684233DC41D60A[_id_AC0E594AC96AA3A8]) {
      ent = spawn("script_origin", struct.origin);
      ent.angles = struct.angles;
      ent.script_gameobjectname = struct.script_gameobjectname;
      ent.script_linkname = struct.script_linkname;
      ent.script_noteworthy = struct.script_noteworthy;
      ent.target = struct.target;
      ent.targetname = struct.targetname;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++)
    _id_53EE9B445DE3B69B[_id_AC0E594AC96AA3A8] = getEntArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

  return scripts\engine\utility::array_combine_multiple(_id_53EE9B445DE3B69B);
}

_id_2316292E9CF2A251(_id_0B8B9E9EFD754D14) {
  _id_3CA8A977F230716E = ["standard_target", "standard_target_180", "standard_target_civilian", "lean_target", "lean_target_civilian", "moving_target", "moving_target_civilian"];
  _id_53EE9B445DE3B69B = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++) {
    _id_15684233DC41D60A[_id_AC0E594AC96AA3A8] = scripts\engine\utility::getStructArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

    foreach(struct in _id_15684233DC41D60A[_id_AC0E594AC96AA3A8]) {
      if(isDefined(struct.script_gameobjectname) && struct.script_gameobjectname == _id_0B8B9E9EFD754D14) {
        ent = spawn("script_origin", struct.origin);
        ent.angles = struct.angles;
        ent.script_gameobjectname = struct.script_gameobjectname;
        ent.script_linkname = struct.script_linkname;
        ent.script_noteworthy = struct.script_noteworthy;
        ent.target = struct.target;
        ent.targetname = struct.targetname;
        ent.script_gameobjectname = struct.script_gameobjectname;
      }
    }
  }

  _id_9FBD7BABD210A237 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3CA8A977F230716E.size; _id_AC0E594AC96AA3A8++) {
    _id_53EE9B445DE3B69B[_id_AC0E594AC96AA3A8] = getEntArray(_id_3CA8A977F230716E[_id_AC0E594AC96AA3A8], "script_noteworthy");

    foreach(ent in _id_53EE9B445DE3B69B[_id_AC0E594AC96AA3A8]) {
      if(isDefined(ent.script_gameobjectname) && ent.script_gameobjectname == _id_0B8B9E9EFD754D14)
        _id_9FBD7BABD210A237[_id_9FBD7BABD210A237.size] = ent;
    }
  }

  return _id_9FBD7BABD210A237;
}

trial_target_damage() {
  _id_8C44BF99399EDF9A = undefined;

  if(isDefined(self.plate_dest)) {
    _id_C7D805274B12EF6A = "trial_sfx_target_report_clay_smash";
    _id_8C44BF99399EDF9A = level.impact_vfx;
  } else
    _id_C7D805274B12EF6A = "trial_sfx_target_report_metal_light";

  for(;;) {
    self.activated = 0;

    while(self.state_up == 0)
      waitframe();

    self.plate waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    self.plate playSound(_id_C7D805274B12EF6A);

    if(self.is_civilian == 1)
      level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, 0, 1, 0);
    else
      level.player thread scripts\mp\trials\trial_utility::trial_hitmarker(self, 1, 0, 0);

    self.activated = 1;

    if(type == "MOD_MELEE")
      level.player notify("fake_weapon_fired");

    if(self.is_civilian && isDefined(level.trial_target_civilian_killed_func))
      self[[level.trial_target_civilian_killed_func]]();
    else if(isDefined(level.trial_target_enemy_killed_func))
      self[[level.trial_target_enemy_killed_func]]();

    if(isDefined(level.trial_target_headshot_func) && self.plate tagexists("tag_head") && distance(self.plate gettagorigin("tag_head"), point) <= 5)
      self[[level.trial_target_headshot_func]]();

    if(isDefined(_id_8C44BF99399EDF9A))
      playFX(_id_8C44BF99399EDF9A, point);

    if(isDefined(self.plate_dest)) {
      self.plate_dest hide();
      wait(randomfloatrange(0.7, 1));
    }

    thread trial_target_flip("down");
    level waittill("course_ended");

    if(isDefined(self.plate_dest)) {
      scripts\mp\trials\trial_utility::trial_ui_waittill_retry();
      self.plate_dest show();
    }
  }
}

trial_target_flip(_id_F1118C1A072B6415) {
  if(_id_F1118C1A072B6415 == "up") {
    if(isDefined(self.script_delay))
      wait(self.script_delay);

    self.plate setCanDamage(1);

    if(isDefined(self.aim_assist))
      self.aim_assist enableaimassist();

    if(isDefined(self.collision_up))
      self.collision_up solid();

    if(isDefined(self.collision_down))
      self.collision_up notsolid();

    if(self.state_up == 1) {
      return;
    }
    self.state_up = 1;
    sign = 1;
  } else {
    self.plate setCanDamage(0);

    if(isDefined(self.aim_assist))
      self.aim_assist _meth_ F807A01ED0CF8EB();

    if(isDefined(self.collision_up))
      self.collision_up notsolid();

    if(isDefined(self.collision_down))
      self.collision_up solid();

    if(self.state_up == 0) {
      return;
    }
    self.state_up = 0;
    sign = -1;
  }

  time = undefined;
  _id_8BC14603A27FA3E7 = undefined;

  switch (self.script_noteworthy) {
    case "moving_target_civilian":
    case "standard_target_civilian":
    case "moving_target":
    case "standard_target":
      _id_8BC14603A27FA3E7 = 90;
      time = 0.2;
      break;
    case "lean_target":
    case "lean_target_civilian":
      _id_8BC14603A27FA3E7 = 30;
      time = 0.15;
      break;
    case "standard_target_180":
      _id_8BC14603A27FA3E7 = 180;
      time = 0.4;
      break;
    default:
      _id_8BC14603A27FA3E7 = 90;
      time = 0.2;
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "moving"))
    waitframe();

  if(_id_F1118C1A072B6415 == "up")
    self playsoundonmovingent("trial_sfx_target_flipup");

  if(self.initial_right[2] != 0)
    self rotateYaw(-1 * self.initial_right[2] * _id_8BC14603A27FA3E7 * sign, time);
  else
    self rotatepitch(_id_8BC14603A27FA3E7 * sign, time);

  wait(time);

  if(_id_F1118C1A072B6415 == "down") {
    waitframe();
    self playsoundonmovingent("trial_sfx_target_flipdown");
    self.angles = self.down_angles;
  }

  self.flipping = 0;
}

trial_moving_target_think() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.course_movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  _id_100D5996E00840FB = self.mover.origin - self.origin;
  self.mover.origin = self.mover.origin + _id_100D5996E00840FB;
  self.mover_ends[0].origin = self.mover_ends[0].origin + _id_100D5996E00840FB;
  self.mover_ends[1].origin = self.mover_ends[1].origin + _id_100D5996E00840FB;
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  level waittill("player_spawned");
  thread trial_moving_target_reset();

  for(;;) {
    if(self.moving && (90 > distance(level.player.origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
      self.plate playSound("trial_sfx_target_move_stop");
      self.dummy thread scripts\engine\utility::stop_loop_sound_on_entity("trial_sfx_target_move_loop");
    } else if(self.flipping == 0 && self.moving == 0 && 90 < distance(level.player.origin, self.origin) && self.state_up == 1)
      thread trial_moving_target_mover();

    waitframe();
  }
}

_id_F75AB10A88D19CC4(_id_0B8B9E9EFD754D14) {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.course_movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }
  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  _id_100D5996E00840FB = self.mover.origin - self.origin;
  self.mover.origin = self.mover.origin + _id_100D5996E00840FB;
  self.mover_ends[0].origin = self.mover_ends[0].origin + _id_100D5996E00840FB;
  self.mover_ends[1].origin = self.mover_ends[1].origin + _id_100D5996E00840FB;
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed))
    self.move_speed = self.script_speed;
  else
    self.move_speed = 32;

  thread trial_moving_target_reset();

  for(;;) {
    if(self.moving && (90 > distance(level.player.origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
      self.plate playSound("trial_sfx_target_move_stop");
      self.dummy thread scripts\engine\utility::stop_loop_sound_on_entity("trial_sfx_target_move_loop");
    } else if(self.flipping == 0 && self.moving == 0 && 90 < distance(level.player.origin, self.origin) && self.state_up == 1)
      thread trial_moving_target_mover();

    waitframe();
  }
}

trial_moving_target_mover() {
  self endon("stop_moving");
  self.moving = 1;
  self.dummy = spawn("script_origin", self.origin);
  childthread trial_target_follow_dummy();
  self.dummy thread scripts\engine\utility::play_loop_sound_on_entity("trial_sfx_target_move_loop");
  self.plate playSound("trial_sfx_target_move_start");

  for(;;) {
    _id_6B8A3F291F2D537E = self.mover_ends[self.moveforward];
    dist = distance(self.dummy.origin, _id_6B8A3F291F2D537E.origin);
    time = dist / self.move_speed;
    accel = 0.5;
    accel = clamp(accel, 0, time / 2);
    self.dummy moveTo(_id_6B8A3F291F2D537E.origin, time, accel, accel);
    wait(time);
    self.moveforward = !self.moveforward;
  }
}

trial_moving_target_reset() {
  for(;;) {
    level waittill("trial_results_screen_opened");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

trial_target_follow_dummy() {
  for(;;) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

trial_target_arm_damage() {
  self.arm setCanDamage(1);

  for(;;) {
    self.arm waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" && istrue(self.state_up))
      self.plate dodamage(1, self.plate.origin);
  }
}

trial_target_requisites() {
  waitframe();
  _id_CFCCD3537CE10957 = [];

  if(isDefined(self.targetname)) {
    if(isDefined(level.trial["triggeredTrialName"])) {
      switch (level.trial["triggeredTrialName"]) {
        case "trial_variant_middlerange":
          triggers = getEntArray(self.targetname, "target");

          foreach(trig in triggers) {
            if(isDefined(trig.script_gameobject) && trig.script_gameobject == "trial_variant_middlerange")
              _id_CFCCD3537CE10957[_id_CFCCD3537CE10957.size] = trig;
          }

          break;
        case "trial_variant_cqb":
          _id_CFCCD3537CE10957 = getEntArray(self.targetname, "target");
          break;
      }
    } else
      _id_CFCCD3537CE10957 = getEntArray(self.targetname, "target");
  }

  for(;;) {
    _id_EC8A7173E0C630FB = 1;

    foreach(_id_27EE92A77AFE203E in _id_CFCCD3537CE10957) {
      if(_id_27EE92A77AFE203E.activated == 0)
        _id_EC8A7173E0C630FB = 0;
    }

    if(_id_EC8A7173E0C630FB == 1) {
      trial_target_flip("up");
      level waittill("course_ended");
    }

    waitframe();
  }
}

trial_trigger_think() {
  _id_761C3A588103E918 = getEntArray("end_checkpoint", "script_noteworthy");

  for(;;) {
    self.activated = 0;
    scripts\mp\trials\trial_utility::waittill_player_isDefined();

    if(isDefined(self.script_noteworthy)) {
      if(self.script_noteworthy != "start")
        level waittill("course_started");
    } else
      level waittill("course_started");

    while(level.player istouching(self))
      waitframe();

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "end") {
      for(;;) {
        self waittill("trigger");

        if(all_end_checkpoints_activated(_id_761C3A588103E918)) {
          break;
        }
      }
    } else
      self waittill("trigger");

    self.activated = 1;
    level notify("trigger_activated");

    if(isDefined(level.trial_trigger_activated_func))
      self[[level.trial_trigger_activated_func]]();

    level waittill("course_ended");
  }
}

all_end_checkpoints_activated(_id_761C3A588103E918) {
  foreach(checkpoint in _id_761C3A588103E918) {
    if(!checkpoint.activated)
      return 0;
  }

  return 1;
}