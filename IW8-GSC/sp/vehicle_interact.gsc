/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\vehicle_interact.gsc
***********************************************/

#using_animtree("scriptables");

init_vehicle_interact() {
  precacheshader("hud_icon_mantle");
  scripts\engine\utility::flag_init("player_interacting_vehicle");
  level.scr_animtree["interact_vehicle"] = #animtree;
  level.scr_anim["interact_vehicle"]["lf_open"] = % vehicle_interact_door_open_lf;
  level.scr_anim["interact_vehicle"]["lr_open"] = % vehicle_interact_door_open_lr;
  level.scr_anim["interact_vehicle"]["rf_open"] = % vehicle_interact_door_open_rf;
  level.scr_anim["interact_vehicle"]["rr_open"] = % vehicle_interact_door_open_rr;
  level.scr_anim["interact_vehicle"]["hatch_open"] = % vehicle_interact_door_open_hatch;
  var_0 = scripts\engine\utility::getStructArray("interact_vehicle", "targetname");

  if(var_0.size)
    thread main_vehicle_interact(var_0);
}

main_vehicle_interact(var_0) {
  level.interact_vehicle = spawnStruct();
  level.interact_vehicle.entries = [];
  level.interact_vehicle.g_inuse = 0;
  waitframe();

  foreach(var_2 in var_0) {
    level.interact_vehicle.entries[level.interact_vehicle.entries.size] = var_2;

    if(isDefined(var_2.target)) {
      var_3 = getEnt(var_2.target, "targetname");

      if(isDefined(var_3)) {
        var_2.vehicle = var_3;
        var_2.vehicle useanimtree(#animtree);
      }

      var_4 = getscriptablearray(var_2.target, "targetname");

      if(var_4.size > 0)
        var_2.vehicle = var_4[0];
    } else {
      var_5 = getEntArray("interact_vehicle", "targetname");
      var_2.vehicle = scripts\engine\utility::getclosest(var_2.origin, var_5, 0.01);

      if(isDefined(var_2.vehicle))
        var_2.vehicle useanimtree(#animtree);
      else {
        var_4 = getscriptablearray("interact_vehicle", "targetname");
        var_2.vehicle = scripts\engine\utility::getclosest(var_2.origin, var_4, 0.01);
      }
    }

    var_2.cover_nodes = [];
    var_6 = scripts\engine\utility::getStructArray(var_2.script_linkto, "script_linkname");

    foreach(var_8 in var_6) {
      if(strtok(var_8.script_namenumber, " ")[0] == "cover") {
        var_2.cover_nodes = scripts\engine\utility::array_add(var_2.cover_nodes, var_8);
        continue;
      }

      var_2.doors[strtok(var_8.script_namenumber, "_")[1]] = var_8;
      var_2 thread interact_door_setup(var_8);
    }

    foreach(var_11 in var_2.cover_nodes) {}

    if(isDefined(var_2.script_animname))
      var_2.vehicle.animname = var_2.script_animname;
    else
      var_2.vehicle.animname = "interact_vehicle";

    var_2.dont_lerp_player = 0;
  }
}

interact_door_setup(var_0) {
  self endon("death");
  level.player endon("death");

  if(!isDefined(self.hint_bones)) {
    self.hint_bones = [];
    var_1 = getnumparts(self.vehicle.model);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = getpartname(self.vehicle.model, var_2);

      if(issubstr(var_3, "hint")) {
        switch (var_3) {
          case "tag_door_lf_hint_outside":
            self.hint_bones["outside_lf"] = "tag_door_lf_hint_outside";
            break;
          case "tag_door_lr_hint_outside":
            self.hint_bones["outside_lr"] = "tag_door_lr_hint_outside";
            break;
          case "tag_door_rf_hint_outside":
            self.hint_bones["outside_rf"] = "tag_door_rf_hint_outside";
            break;
          case "tag_door_rr_hint_outside":
            self.hint_bones["outside_rr"] = "tag_door_rr_hint_outside";
            break;
          case "tag_trunk_hint_outside":
            self.hint_bones["outside_hatch"] = "tag_trunk_hint_outside";
            break;
          case "tag_door_lr_hint_inside":
            self.hint_bones["inside_lr"] = "tag_door_lr_hint_inside";
            break;
          case "tag_door_rr_hint_inside":
            self.hint_bones["inside_rr"] = "tag_door_rr_hint_inside";
            break;
          case "tag_sunroof_hint_outside":
            self.hint_bones["outside_sunroof"] = "tag_sunroof_hint_outside";
            break;
        }
      }
    }
  }

  var_4 = undefined;

  if(isDefined(var_0.script_linkto)) {
    var_5 = scripts\engine\utility::getStruct(var_0.script_linkto, "script_linkname");
    var_4 = strtok(var_5.script_namenumber, "_")[1];
    self.getin_hints[var_4] = var_5;
    self.door_open[var_4] = 0;
    var_6 = getEnt(var_0.script_linkto, "script_linkname");

    if(isDefined(var_6)) {
      if(!isDefined(self.door_col))
        self.door_col = [];

      var_6 linkTo(self.vehicle, self.hint_bones[var_0.script_namenumber]);
      self.door_col[var_4] = var_6;
    }
  }

  if(isDefined(self.hint_bones[var_0.script_namenumber])) {
    var_7 = scripts\engine\utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones[var_0.script_namenumber]));
    var_7 linkTo(self.vehicle, self.hint_bones[var_0.script_namenumber]);
  } else
    var_7 = var_0 scripts\engine\utility::spawn_tag_origin();

  var_7.door_name = var_0.script_namenumber;
  self.getin_hints[var_4].hint_ent = var_7;
  var_7 endon("death");
  var_7 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, undefined, 180, 100, 60, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 180);
  var_7 waittill("trigger");

  if(!self.dont_lerp_player) {
    level.player thread scripts\engine\sp\utility::player_gesture_force("ges_pickup");
    wait 0.25;
  }

  var_8 = var_0;

  switch (var_7.door_name) {
    case "outside_lf":
      thread interact_vehicle_animate_door("lf");
      break;
    case "outside_lr":
      thread interact_vehicle_animate_door("lr");
      break;
    case "outside_rf":
      thread interact_vehicle_animate_door("rf");
      break;
    case "outside_rr":
      thread interact_vehicle_animate_door("rr");
      break;
    case "outside_hatch":
      thread interact_vehicle_animate_door("hatch");
      break;
    case "outside_sunroof":
      var_8 = scripts\engine\utility::getStruct(var_0.target, "targetname");
      thread interact_vehicle_animate_door("rr");
      break;
  }

  if(!self.dont_lerp_player) {}

  var_7 scripts\sp\player\cursor_hint::remove_cursor_hint();
  var_7 delete();
}

interact_interior_door_open(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "lr":
      block_for_mantle(self.getin_hints["lr"]);
      thread interact_vehicle_animate_door("lr");
      self.getin_hints[var_0].hint_ent delete();
      break;
    case "rr":
      block_for_mantle(self.getin_hints["rr"]);
      thread interact_vehicle_animate_door("rr");
      self.getin_hints[var_0].hint_ent delete();
      break;
  }
}

interact_interior_door_open_remove(var_0) {
  level.player endon("death");
  var_0 endon("death");
  scripts\engine\utility::flag_waitopen("player_interacting_vehicle");
  var_0 scripts\sp\player\cursor_hint::remove_cursor_hint();
  var_0 delete();
}

interact_vehicle_inside(var_0) {
  var_1 = strtok(var_0.script_namenumber, "_")[1];

  if(!isDefined(self.getin_hints[var_1])) {
    return;
  }
  self endon("death");
  var_0 endon("stop_logic");
  var_2 = get_next_struct(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = get_next_struct(var_2);
  block_for_mantle(self.getin_hints[var_1]);

  foreach(var_5 in self.doors) {
    if(var_5 != var_0)
      var_5 notify("stop_logic");
  }

  level.player notify("interacted_vehicle");
  level.interact_vehicle.g_inuse = 1;
  scripts\engine\utility::flag_set("player_interacting_vehicle");
  var_7 = level.player getstance() == "prone";

  if(var_7) {
    level.player scripts\common\utility::allow_stand(0);
    level.player scripts\common\utility::allow_prone(0);
    wait 0.5;
  }

  var_8 = "context_mount_enable";
  var_9 = 1;

  if(getDvar(var_8) != "") {
    var_9 = getdvarint(var_8);
    setsaveddvar(var_8, 0);
  }

  var_10 = level.player getstance() == "crouch";

  if(var_10 && !var_7)
    level.player scripts\common\utility::allow_stand(0);

  if(!var_7)
    level.player scripts\common\utility::allow_prone(0);

  if(isDefined(self.script_animation))
    interact_entry_anim();

  var_11 = level.player getplayerviewheight() + -4;
  var_12 = scripts\engine\utility::spawn_tag_origin(var_2.origin, level.player.angles);
  var_13 = scripts\engine\utility::spawn_tag_origin(var_2.origin + (0, 0, var_11 * -1), var_12.angles);
  level.interact_vehicle.p_mover = var_13;
  var_13 linkTo(var_12);
  var_14 = 0.4;
  level.player playerlinktoblend(var_13, "tag_player", var_14, 0, 0.2);
  thread interact_give_control_back(var_14, var_13);
  var_12 moveTo(var_2.origin, 0.5, 0.1, 0.1);
  var_12 waittill("movedone");
  var_12.angles = var_2.angles;
  var_15 = var_12 interact_vehicle_movement(self, var_0, var_2, var_3);

  if(isDefined(level.player.ground_ref_ent))
    level interact_vehicle_delete_ground_ref_ent();

  var_16 = undefined;

  if(var_15 == var_2)
    var_16 = var_0;
  else if(var_0.script_namenumber == "outside_lr" || var_0.script_namenumber == "outside_rr")
    var_16 = get_opposite_door(var_0.script_namenumber);

  if(!isDefined(var_16))
    var_16 = var_0;

  var_12 moveTo(var_16.origin, 0.5, 0.1, 0.1);
  var_12 waittill("movedone");

  if(getDvar(var_8) != "")
    setsaveddvar(var_8, var_9);

  if(var_10 || var_7)
    level.player scripts\common\utility::allow_stand(1);

  level.player scripts\common\utility::allow_prone(1);
  level.player unlink();
  var_12 delete();
  var_13 delete();
  level.interact_vehicle.g_inuse = 0;
  scripts\engine\utility::flag_clear("player_interacting_vehicle");
  var_17 = getarraykeys(self.doors);

  foreach(var_19 in var_17) {
    if(isDefined(self.door_open[var_19]) && self.door_open[var_19])
      thread interact_vehicle_inside(self.doors[var_19]);
  }
}

block_for_mantle(var_0) {
  level endon("stop mantle block");
  level thread create_mantle_hint();

  if(!isDefined(level.interact_vehicle_mantle_hint_active))
    level.interact_vehicle_mantle_hint_active = 0;

  for(;;) {
    if(!isDefined(self)) {
      level.player allowjump(1);
      return;
    }

    var_1 = distance2dsquared(level.player.origin, var_0.origin);

    if(var_1 < 800) {
      if(!level.interact_vehicle_mantle_hint_active) {
        level.interact_vehicle_mantle_hint.alpha = 1;
        level.player allowjump(0);
      }

      level.interact_vehicle_mantle_hint_active = 1;

      if(level.player jumpbuttonPressed()) {
        level.interact_vehicle_mantle_hint.alpha = 0;
        return;
      }
    } else if(var_1 > 20000)
      wait 1;
    else if(var_1 > 500000)
      wait 5;
    else {
      level.interact_vehicle_mantle_hint_active = 0;
      waittillframeend;
      waitframe();

      if(!level.interact_vehicle_mantle_hint_active) {
        level.interact_vehicle_mantle_hint_active = 0;
        level.interact_vehicle_mantle_hint.alpha = 0;
        level.player allowjump(1);
      }
    }

    waitframe();
  }
}

wait_for_mantle_inside(var_0) {
  level notify("stop mantle wait");
  level endon("stop mantle wait");
  level thread create_mantle_hint();
  var_1 = distance2dsquared(level.player.origin, var_0.origin);

  if(var_1 < 4) {
    level.interact_vehicle_mantle_hint.alpha = 1;

    if(level.player jumpbuttonPressed()) {
      level.interact_vehicle_mantle_hint.alpha = 0;
      return 1;
    } else
      return 0;
  } else {
    if(var_1 > 4)
      level.interact_vehicle_mantle_hint.alpha = 0;

    return 0;
  }
}

create_mantle_hint() {
  if(isDefined(level.interact_vehicle_mantle_hint)) {
    return;
  }
  level.interact_vehicle_mantle_hint = newhudelem();
  level.interact_vehicle_mantle_hint.x = 320;
  level.interact_vehicle_mantle_hint.y = 350;
  level.interact_vehicle_mantle_hint.alignx = "center";
  level.interact_vehicle_mantle_hint.aligny = "middle";
  level.interact_vehicle_mantle_hint.sort = 1;
  level.interact_vehicle_mantle_hint.foreground = 1;
  level.interact_vehicle_mantle_hint.hidewheninmenu = 1;
  level.interact_vehicle_mantle_hint.alpha = 1;
  level.interact_vehicle_mantle_hint.fontscale = 2;
  level.interact_vehicle_mantle_hint.font = "objective";
  level.interact_vehicle_mantle_hint.text = "enter";
  level.interact_vehicle_mantle_hint setshader("hud_icon_mantle", 24, 24);
}

block_for_push(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1))
    var_1 = var_1;
  else
    var_1 = 6;

  var_2 = 0;

  for(;;) {
    var_3 = distance2dsquared(level.player.origin, self.getin_hints[var_0].origin);
    var_4 = level.player getnormalizedmovement();
    var_5 = scripts\engine\math::get_dot(self.getin_hints[var_0].origin, self.getin_hints[var_0].angles, level.player.origin);

    if(var_3 < 900 && abs(var_4[1]) > 0.2) {
      var_2 = var_2 + 1;

      if(var_2 > var_1) {
        break;
      }
    } else if(var_3 > 10000) {
      var_2 = 0;
      wait 1;
    } else if(var_3 > 500000) {
      var_2 = 0;
      wait 5;
    } else
      var_2 = 0;

    waitframe();
  }
}

interact_entry_anim() {
  var_0 = scripts\sp\player_rig::get_player_rig(1);
  var_0 hide();
  var_1 = undefined;

  if(isDefined(self.ent))
    var_1 = self.ent;
  else if(isDefined(self.vehicle))
    var_1 = self.vehicle;

  level.player disableweapons();
  var_2 = 0.4;
  level.player playerlinktoblend(var_0, "tag_player", var_2, 0, 0.2);
  thread interact_give_control_back(var_2, var_0);
  var_0 scripts\engine\utility::delaycall(var_2, ::show);
  var_1.animname = var_1.script_noteworthy;
  var_3 = var_1 scripts\engine\utility::getanim(self.script_animation);
  wait 0.1;
  var_4 = getanimlength(var_3);
  var_4 = 1 - (var_4 - 2) / var_4;
  wait(var_4);
  var_0 delete();
  level.player enableweapons();
}

interact_vehicle_delete_ground_ref_ent() {
  var_0 = level.player.ground_ref_ent;
  var_0.vehicleinteract = undefined;
  var_0 rotateTo((0, 0, 0), 0.3, 0.1, 0.1);
}

get_next_struct(var_0) {
  if(isDefined(var_0.target))
    return scripts\engine\utility::getStruct(var_0.target, "targetname");
  else
    return undefined;
}

get_prev_struct(var_0) {
  if(isDefined(var_0.targetname))
    return scripts\engine\utility::getStruct(var_0.targetname, "target");
  else
    return undefined;
}

get_opposite_door(var_0) {
  var_1 = undefined;

  if(var_0 == "outside_lr")
    var_1 = "outside_rr";
  else if(var_0 == "outside_rr")
    var_1 = "outside_lr";

  var_2 = scripts\engine\utility::getStructArray(self.script_linkto, "script_linkname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_namenumber) && var_4.script_namenumber == var_1)
      return var_4;
  }
}

interact_vehicle_movement(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = 100;
  self.pathdir = vectorNormalize(var_3.origin - var_2.origin);
  var_5 = length(var_3.origin - var_2.origin);
  var_6 = var_2.origin;

  if(!isDefined(var_2.midpoint)) {
    var_2.midpoint = spawnStruct();
    var_2.midpoint.origin = var_2.origin + self.pathdir * (var_5 * 0.5);
    var_2.midpoint.angles = var_2.angles;
    var_2.midpoint.right = anglestoright(var_2.angles);
  }

  self.pathstart = var_2;
  self.movedist = 0;
  self.velocity = 0;
  self.trajectory = 0;
  self.isducking = 0;
  self.prevmoveright = 0;
  childthread interact_vehicle_duck_toggle();
  var_7 = 0;

  for(;;) {
    set_moverate_along_dir();
    set_viewangles();
    var_3.open = var_0 get_end_door_state(var_1);

    if(!isDefined(var_3.open))
      var_3.open = 0;

    if(isDefined(self.forceexit)) {
      break;
    }

    if(self.movelength > 0) {
      var_8 = var_6 + self.velocity;
      var_8 = (var_8[0], var_8[1], 0);
      var_9 = (var_2.origin[0], var_2.origin[1], 0);
      var_10 = (var_3.origin[0], var_3.origin[1], 0);

      if(vectordot(self.pathdir, vectorNormalize(var_9 - var_8)) > 0) {
        var_11 = var_0 wait_for_mantle_inside(var_2);

        if(var_11)
          return var_2;
        else
          self.velocity = (0, 0, 0);
      } else if(vectordot(self.pathdir, vectorNormalize(var_10 - var_8)) < 0) {
        var_11 = var_0 wait_for_mantle_inside(var_3);

        if(var_11) {
          if(!var_3.open) {
            switch (var_1.script_namenumber) {
              case "outside_lr":
                var_0 thread interact_vehicle_animate_door("rr");
                var_0.getin_hints["rr"].hint_ent delete();
                break;
              case "outside_rr":
                var_0 thread interact_vehicle_animate_door("lr");
                var_0.getin_hints["lr"].hint_ent delete();
                break;
            }
          }

          return var_3;
        } else
          self.velocity = (0, 0, 0);
      }
    } else {
      var_11 = var_0 wait_for_mantle_inside(var_2);

      if(var_11)
        return var_2;

      var_11 = var_0 wait_for_mantle_inside(var_3);

      if(var_11) {
        if(!var_3.open) {
          switch (var_1.script_namenumber) {
            case "outside_lr":
              var_0 thread interact_vehicle_animate_door("rr");
              var_0.getin_hints["rr"].hint_ent delete();
              break;
            case "outside_rr":
              var_0 thread interact_vehicle_animate_door("lr");
              var_0.getin_hints["lr"].hint_ent delete();
              break;
          }
        }

        return var_3;
      }
    }

    var_6 = var_6 + self.velocity;

    if(self.isducking) {
      if(var_7 > -16)
        var_7 = var_7 - 3;
    } else if(var_7 < 0)
      var_7 = var_7 + 3;

    var_7 = clamp(var_7, -16, 0);
    var_12 = var_6 + (0, 0, var_7);
    self.origin = var_12;
    wait 0.05;
  }

  return var_3;
}

get_end_door_state(var_0) {
  switch (var_0.script_namenumber) {
    case "outside_lf":
      return 0;
    case "outside_lr":
      return self.door_open["rr"];
    case "outside_rf":
      return 0;
    case "outside_rr":
      return self.door_open["lr"];
  }
}

interact_vehicle_duck_toggle() {
  level.player notifyonplayercommand("duck", "+movedown");
  level.player notifyonplayercommand("duck", "+togglecrouch");
  level.player notifyonplayercommand("duck", "+stance");

  for(;;) {
    level.player waittill("duck");
    self.isducking = !self.isducking;
    wait 0.2;
  }
}

set_moverate_along_dir() {
  var_0 = 3.0;
  var_1 = level.player getnormalizedmovement();
  var_2 = anglesToForward(level.player.angles);
  var_3 = anglestoright(level.player.angles);
  var_4 = var_2 * var_1[0] + var_3 * var_1[1];
  var_5 = vectordot(var_4, self.pathdir) * var_0;

  if(abs(var_5) > 0)
    self.trajectory = var_5 * 0.5;
  else if(self.trajectory > 0.01)
    self.trajectory = self.trajectory - self.trajectory * 0.5;
  else if(self.trajectory < -0.01)
    self.trajectory = self.trajectory - self.trajectory * 0.5;
  else
    self.trajectory = 0;

  var_6 = 1;

  if(self.isducking)
    var_6 = 0.6;

  self.velocity = self.pathdir * self.trajectory * var_6;
  self.ismoveright = is_pos_in_front(self.origin, self.origin + self.velocity, self.pathstart.midpoint.right);

  if(self.prevmoveright != self.ismoveright)
    self.velocity = self.velocity * 0.2;

  self.prevmoveright = self.ismoveright;
  self.movelength = length(self.velocity);

  if(self.movelength == 0)
    self.movedist = 0;
  else {
    self.movedist = self.movedist + self.movelength;

    if(self.movedist > 10)
      self.movedist = 2.0;
  }

  var_7 = self.movedist / 10;
  var_8 = get_scoot_velocity(var_7);
  self.velocity_bump = get_scoot_velocity_bump(var_7);
  self.moveviewmult = var_8;
  self.velocity = self.velocity * (var_8 + self.velocity_bump);
}

get_scoot_velocity(var_0) {
  var_1 = 3.14159;
  var_2 = 2 * pow(var_0, 1.5) * var_1 + var_1;
  var_3 = var_2 * 180 / var_1;
  var_4 = (cos(var_3) + 1) / 2;
  return var_4;
}

get_scoot_velocity_bump(var_0) {
  var_1 = 0.2;
  var_1 = var_1 + (var_1 - 0) * var_0 * 2;

  if(var_1 < 0)
    var_1 = 0;

  return var_1;
}

qlerp(var_0, var_1, var_2) {
  return var_0 + (var_1 - var_0) * var_2;
}

set_viewangles() {
  level.player endon("death");

  if(!isDefined(level.player.ground_ref_ent))
    level.player.ground_ref_ent = spawn("script_origin", (0, 0, 0));

  if(!isDefined(level.player.ground_ref_ent.vehicleinteract)) {
    level.player.ground_ref_ent.vehicleinteract = 1;
    level.player playersetgroundreferenceent(level.player.ground_ref_ent);
  }

  var_0 = level.player.ground_ref_ent;
  var_1 = 2;
  var_2 = 1.5;
  var_3 = -1;

  if(self.ismoveright) {
    var_2 = var_2 * -1;
    var_3 = var_3 * -1;
  }

  var_4 = is_pos_in_front(self.pathstart.midpoint.origin, self.origin, self.pathstart.midpoint.right);

  if(var_4)
    var_5 = (0, 0, -5);
  else
    var_5 = (0, 0, 5);

  var_6 = distance2d(self.pathstart.midpoint.origin, self.origin);
  var_5 = anglelerpquatfrac((0, 0, 0), var_5, var_6 / 5);
  var_7 = (0, 0, 0);

  if(self.isducking) {
    if(!isDefined(self.duckingtime))
      self.duckingtime = gettime();

    var_8 = (gettime() - self.duckingtime) * 0.001;
    var_9 = var_8 / 0.2 * 1.5;
    var_9 = var_9 * (var_6 / 5);
    var_9 = clamp(var_9, 0, 1);

    if(!isDefined(self.prevduckangles))
      self.prevduckangles = (0, 0, 0);

    var_10 = (0, 2, -10);

    if(var_4)
      var_7 = anglelerpquatfrac((0, 0, 0), var_10, var_9);
    else
      var_7 = anglelerpquatfrac((0, 0, 0), var_10 * -1, var_9);

    var_7 = anglelerpquatfrac(self.prevduckangles, var_7, 0.0001);
    self.prevduckangles = var_7;
  } else {
    self.duckingtime = undefined;
    self.prevduckangles = (0, 0, 0);
  }

  var_11 = (var_1, var_2, var_3) * self.moveviewmult;
  var_11 = var_11 + (var_7 + var_5);

  if(!isDefined(self.prevviewangles))
    self.prevviewangles = (0, 0, 0);

  if(self.moveviewmult < 0.05)
    var_11 = anglelerpquatfrac(self.prevviewangles, var_11, 0.1);

  self.prevviewangles = var_11;

  if(var_0.angles == var_11) {
    return;
  }
  var_12 = combineangles(self.pathstart.angles, var_11);
  var_13 = anglestoup(var_12);
  var_14 = vectorcross((1, 0, 0), var_13);
  var_15 = vectorcross(var_13, var_14);
  var_12 = axistoangles(var_15, var_14, var_13);
  var_0.angles = anglelerpquatfrac(var_0.angles, var_12, 0.5);
}

is_pos_in_front(var_0, var_1, var_2) {
  var_3 = (var_1[0], var_1[1], 0);
  var_4 = (var_0[0], var_0[1], 0);
  var_5 = vectordot(var_2, vectorNormalize(var_3 - var_4));
  return var_5 > 0;
}

interact_give_control_back(var_0, var_1) {
  wait(var_0);
  level.player playerlinktodelta(var_1, "tag_player", 0, 110, 110, 20, 30);
}

hide_interact_vehicle(var_0) {
  var_1 = getscriptablearray(var_0, "script_noteworthy")[0];
  var_1 hide();
  return var_1;
}

show_interact_vehicle(var_0) {
  var_1 = getscriptablearray(var_0, "script_noteworthy")[0];
  var_1 show();
  return var_1;
}

get_interact_vehicle(var_0) {
  foreach(var_2 in level.interact_vehicle.entries) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0)
      return var_2;
  }
}

get_interact_vehicle_array(var_0) {
  var_1 = [];

  foreach(var_3 in level.interact_vehicle.entries) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == var_0)
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
  }

  return var_1;
}

interact_vehicle_doors_state(var_0, var_1) {
  self endon("death");

  foreach(var_3 in var_0) {
    if(self.door_open[var_3]) {
      continue;
    }
    switch (var_3) {
      case "hatch":
      case "rr":
      case "rf":
      case "lr":
      case "lf":
        self.dont_lerp_player = 1;
        self.getin_hints[var_3].hint_ent notify("trigger");
        waittillframeend;
        self.dont_lerp_player = 0;
        break;
      default:
    }
  }
}

interact_vehicle_doors_inactive(var_0) {
  self endon("death");

  foreach(var_2 in var_0) {
    switch (var_2) {
      case "hatch":
      case "rr":
      case "rf":
      case "lr":
      case "lf":
        self.getin_hints[var_2].hint_ent delete();
        break;
      default:
    }
  }
}

interact_interior_door_hack(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "lr":
      var_1 = scripts\engine\utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones["inside_lr"]));
      var_1 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, undefined, 270, 250, 55, 0);
      self.getin_hints["lr_inside"] = spawnStruct();
      self.getin_hints["lr_inside"].hint_ent = var_1;
      var_1 waittill("trigger");
      var_1 delete();
      thread interact_vehicle_animate_door("lr");
      break;
    case "rr":
      var_1 = scripts\engine\utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones["inside_rr"]));
      var_1 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, undefined, 270, 250, 55, 0);
      self.getin_hints["rr_inside"] = spawnStruct();
      self.getin_hints["rr_inside"].hint_ent = var_1;
      var_1 waittill("trigger");
      var_1 delete();
      thread interact_vehicle_animate_door("rr");
      break;
  }
}

interact_getanim(var_0) {
  if(isDefined(level.scr_anim[self.animname]) && isDefined(level.scr_anim[self.animname][var_0]))
    return scripts\engine\utility::getanim(var_0);
  else
    return level.scr_anim["interact_vehicle"][var_0];
}

interact_vehicle_animate_door(var_0) {
  self.door_open[var_0] = 1;
  var_1 = self.vehicle interact_getanim(var_0 + "_open");

  if(isDefined(self.door_col) && isDefined(self.door_col[var_0]))
    scripts\engine\utility::noself_delaycall(getanimlength(var_1), ::createnavobstaclebyent, self.door_col[var_0], "axis", "allies");

  self.vehicle setanim(var_1, 1, 0.2, 2);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  switch (var_0) {
    case "lf":
      var_4 = "lr";
      var_2 = "Conceal Crouch";
      var_3 = "Conceal Crouch";
      break;
    case "lr":
      var_4 = "lf";
      var_2 = "Conceal Crouch";
      var_3 = "Conceal Crouch";
      break;
    case "rf":
      var_4 = "rr";
      var_2 = "Conceal Crouch";
      var_3 = "Conceal Crouch";
      break;
    case "rr":
      var_4 = "rf";
      var_2 = "Conceal Crouch";
      var_3 = "Conceal Crouch";
      break;
  }

  if(is_van() && (var_0 == "rf" || var_0 == "lr" || var_0 == "rr")) {
    return;
  }
  if(isDefined(var_2)) {
    self.cover_nodes[var_0] = interact_vehicle_spawn_cover_node(self, var_0, var_2, "door_back");

    if(var_0 == "lr" || var_0 == "rr") {
      if(!istrue(self.door_open[var_4]))
        self.cover_nodes[var_0 + "_front"] = interact_vehicle_spawn_cover_node(self, var_0, var_2, "door_front");
    } else if(var_0 == "lf" || var_0 == "rf") {
      self.cover_nodes[var_0 + "_front"] = interact_vehicle_spawn_cover_node(self, var_0, var_2, "door_front");

      if(istrue(self.door_open[var_4]) && isDefined(self.cover_nodes[var_4 + "_front"]))
        despawncovernode(self.cover_nodes[var_4 + "_front"]);
    }
  } else {}
}

interact_vehicle_spawn_cover_node(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  switch (var_3) {
    case "door_back":
      var_4 = spawncovernode(var_0.doors[var_1].origin + anglestoup(var_0.doors[var_1].angles) * -50, var_0.doors[var_1].angles, var_2);
      break;
    case "door_front":
      var_4 = spawncovernode(var_0.doors[var_1].origin + anglestoup(var_0.doors[var_1].angles) * -50 + anglesToForward(var_0.doors[var_1].angles) * 48, var_0.doors[var_1].angles + (0, 180, 0), var_2);
      break;
    default:
      var_4 = spawncovernode(var_1.origin + anglestoup(var_1.angles) * -50, var_1.angles, var_2);
      break;
  }

  if(isDefined(var_0.script_color_allies) && isDefined(var_4)) {
    var_4.script_color_allies = var_0.script_color_allies;
    update_color_nodes(var_4);
  }

  return var_4;
}

update_color_nodes(var_0) {
  if(isDefined(var_0.script_color_allies))
    var_0 add_node_to_global_arrays(var_0.script_color_allies, "allies");

  if(isDefined(var_0.script_color_axis))
    var_0 add_node_to_global_arrays(var_0.script_color_axis, "axis");
}

add_node_to_global_arrays(var_0, var_1) {
  self.color_user = undefined;
  var_2 = strtok(var_0, " ");
  var_2 = scripts\sp\colors::array_remove_dupes(var_2);

  foreach(var_4 in var_2) {
    if(isDefined(level.arrays_of_colorcoded_nodes[var_1]) && isDefined(level.arrays_of_colorcoded_nodes[var_1][var_4])) {
      if(!scripts\engine\utility::array_contains(level.arrays_of_colorcoded_nodes[var_1][var_4], self)) {
        level.arrays_of_colorcoded_nodes[var_1][var_4] = scripts\engine\utility::array_add(level.arrays_of_colorcoded_nodes[var_1][var_4], self);
        continue;
      }
    }

    level.arrays_of_colorcoded_nodes[var_1][var_4][0] = self;
    level.arrays_of_colorcoded_ai[var_1][var_4] = [];
    level.arrays_of_colorcoded_spawners[var_1][var_4] = [];
  }
}

is_van() {
  if(isDefined(self.script_animname) && self.script_animname == "sprinter")
    return 1;

  return 0;
}