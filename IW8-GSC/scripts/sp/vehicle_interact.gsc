/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\vehicle_interact.gsc
***********************************************/

#using_animtree("");

function init_vehicle_interact() {
  precacheshader("hud_icon_mantle");
  scripts\engine\utility::flag_init("player_interacting_vehicle");
  level.scr_animtree["interact_vehicle"] = #animtree;
  level.scr_anim["interact_vehicle"]["lf_open"] = $vehicle_interact_door_open_lf;
  level.scr_anim["interact_vehicle"]["lr_open"] = % vehicle_interact_door_open_lr;
  level.scr_anim["interact_vehicle"]["rf_open"] = % vehicle_interact_door_open_rf;
  level.scr_anim["interact_vehicle"]["rr_open"] = % vehicle_interact_door_open_rr;
  level.scr_anim["interact_vehicle"]["hatch_open"] = % vehicle_interact_door_open_hatch;
  var0 = scripts\engine\utility::getStructArray("interact_vehicle", "targetname");

  if(var0.size) {
    thread main_vehicle_interact(var0);
    return;
  }
}

function main_vehicle_interact(var0) {
  level.interact_vehicle = spawnStruct();
  level.interact_vehicle.entries = [];
  level.interact_vehicle.g_inuse = 0;
  waitframe();

  foreach(var2 in var0) {
    level.interact_vehicle.entries[level.interact_vehicle.entries.size] = var2;

    if(isDefined(var2.target)) {
      var3 = getEnt(var2.target, "targetname");

      if(isDefined(var3)) {
        var2.vehicle = var3;
        var2.vehicle useanimtree(#animtree);
      }

      var4 = getscriptablearray(var2.target, "targetname");

      if(var4.size > 0) {
        var2.vehicle = var4[0];
      }
    } else {
      var5 = getEntArray("interact_vehicle", "targetname");
      var2.vehicle = scripts\engine\utility::getclosest(var2.origin, var5, 0.01);

      if(isDefined(var2.vehicle)) {
        var2.vehicle useanimtree(#animtree);
      } else {
        var4 = getscriptablearray("interact_vehicle", "targetname");
        var2.vehicle = scripts\engine\utility::getclosest(var2.origin, var4, 0.01);
      }
    }

    var2.cover_nodes = [];
    var6 = scripts\engine\utility::getStructArray(var2.script_linkto, "script_linkname");

    foreach(var8 in var6) {
      if(strtok(var8.script_namenumber, " ")[0] == "cover") {
        var2.cover_nodes = scripts\engine\utility::array_add(var2.cover_nodes, var8);
        continue;
      }

      var2.doors[strtok(var8.script_namenumber, "_")[1]] = var8;
      thread interact_door_setup(var2);
    }

    foreach(var11 in var2.cover_nodes) {}

    if(isDefined(var2.script_animname)) {
      var2.vehicle.animname = var2.script_animname;
    } else {
      var2.vehicle.animname = "interact_vehicle";
    }

    var2.dont_lerp_player = 0;
  }
}

function interact_door_setup(var0) {
  self endon("death");
  level.player endon("death");

  if(!isDefined(self.hint_bones)) {
    self.hint_bones = [];
    var1 = getnumparts(self.vehicle.model);

    for(var2 = 0; var2 < var1; var2++) {
      var3 = getpartname(self.vehicle.model, var2);

      if(issubstr(var3, "hint")) {
        switch (var3) {
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

  var4 = undefined;

  if(isDefined(var0.script_linkto)) {
    var5 = scripts\engine\utility::getStruct(var0.script_linkto, "script_linkname");
    var4 = strtok(var5.script_namenumber, "_")[1];
    self.getin_hints[var4] = var5;
    self.door_open[var4] = 0;
    var6 = getEnt(var0.script_linkto, "script_linkname");

    if(isDefined(var6)) {
      if(!isDefined(self.door_col)) {
        self.door_col = [];
      }

      var6 linkTo(self.vehicle, self.hint_bones[var0.script_namenumber]);
      self.door_col[var4] = var6;
    }
  }

  if(isDefined(self.hint_bones[var0.script_namenumber])) {
    var7 = scripts\engine\utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones[var0.script_namenumber]));
    var7 linkTo(self.vehicle, self.hint_bones[var0.script_namenumber]);
  } else {
    var7 = var4 scripts\engine\utility::spawn_tag_origin();
  }

  var7.door_name = var4.script_namenumber;
  self.getin_hints[var7].hint_ent = var7;
  var7 endon("death");
  var7 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, undefined, 180, 100, 60, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 180);
  var7 waittill("trigger");

  if(!self.dont_lerp_player) {
    level.player thread scripts\engine\sp\utility::player_gesture_force("ges_pickup");
    wait 0.25;
  }

  var8 = var4;

  switch (var7.door_name) {
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
      var8 = scripts\engine\utility::getStruct(var4.target, "targetname");
      thread interact_vehicle_animate_door("rr");
      break;
  }

  if(self.dont_lerp_player) {}

  var7 scripts\sp\player\cursor_hint::remove_cursor_hint();
  var7 delete();
}

function interact_interior_door_open(var0) {
  var1 = undefined;

  switch (var0) {
    case "lr":
      block_for_mantle(self.getin_hints["lr"]);
      thread interact_vehicle_animate_door("lr");
      self.getin_hints[var0].hint_ent delete();
      break;
    case "rr":
      block_for_mantle(self.getin_hints["rr"]);
      thread interact_vehicle_animate_door("rr");
      self.getin_hints[var0].hint_ent delete();
      break;
  }
}

function interact_interior_door_open_remove(var0) {
  level.player endon("death");
  var0 endon("death");
  scripts\engine\utility::flag_waitopen("player_interacting_vehicle");
  var0 scripts\sp\player\cursor_hint::remove_cursor_hint();
  var0 delete();
}

function interact_vehicle_inside(var0) {
  var1 = strtok(var0.script_namenumber, "_")[1];

  if(!isDefined(self.getin_hints[var1])) {
    return;
  }

  self endon("death");
  var0 endon("stop_logic");
  var2 = get_next_struct(var0);

  if(!isDefined(var2)) {
    return;
  }

  var3 = get_next_struct(var2);
  block_for_mantle(self.getin_hints[var1]);

  foreach(var5 in self.doors) {
    if(var5 != var0) {
      var5 notify("stop_logic");
    }
  }

  level.player notify("interacted_vehicle");
  level.interact_vehicle.g_inuse = 1;
  scripts\engine\utility::flag_set("player_interacting_vehicle");
  var7 = level.player getstance() == "prone";

  if(var7) {
    level.player scripts\common\utility::allow_stand(0);
    level.player scripts\common\utility::allow_prone(0);
    wait 0.5;
  }

  var8 = "context_mount_enable";
  var9 = 1;

  if(getDvar(var8) != "") {
    var9 = getdvarint(var8);
    setsaveddvar(var8, 0);
  }

  var10 = level.player getstance() == "crouch";

  if(var10 && !var7) {
    level.player scripts\common\utility::allow_stand(0);
  }

  if(!var7) {
    level.player scripts\common\utility::allow_prone(0);
  }

  if(isDefined(self.script_animation)) {
    interact_entry_anim();
  }

  var11 = level.player getplayerviewheight() + -4;
  var12 = scripts\engine\utility::spawn_tag_origin(var2.origin, level.player.angles);
  var13 = scripts\engine\utility::spawn_tag_origin(var2.origin + (0, 0, var11 * -1), var12.angles);
  level.interact_vehicle.p_mover = var13;
  var13 linkTo(var12);
  var14 = 0.4;
  level.player playerlinktoblend(var13, "tag_player", var14, 0, 0.2);
  thread interact_give_control_back(var14, var13);
  var12 moveTo(var2.origin, 0.5, 0.1, 0.1);
  var12 waittill("movedone");
  var12.angles = var2.angles;
  var15 = interact_vehicle_movement(var12, self, var0, var2, var3);

  if(isDefined(level.player.ground_ref_ent)) {
    interact_vehicle_delete_ground_ref_ent(level);
  }

  var16 = undefined;

  if(var15 == var2) {
    var16 = var0;
  } else if(var0.script_namenumber == "outside_lr" || var0.script_namenumber == "outside_rr") {
    var16 = get_opposite_door(var0.script_namenumber);
  }

  if(!isDefined(var16)) {
    var16 = var0;
  }

  var12 moveTo(var16.origin, 0.5, 0.1, 0.1);
  var12 waittill("movedone");

  if(getDvar(var8) != "") {
    setsaveddvar(var8, var9);
  }

  if(var10 || var7) {
    level.player scripts\common\utility::allow_stand(1);
  }

  level.player scripts\common\utility::allow_prone(1);
  level.player unlink();
  var12 delete();
  var13 delete();
  level.interact_vehicle.g_inuse = 0;
  scripts\engine\utility::flag_clear("player_interacting_vehicle");
  var17 = getarraykeys(self.doors);

  foreach(var19 in var17) {
    if(isDefined(self.door_open[var19]) && self.door_open[var19]) {
      thread interact_vehicle_inside(self.doors[var19]);
    }
  }
}

function block_for_mantle(var0) {
  level endon("stop mantle block");
  thread create_mantle_hint();
  jumpiftrue(isDefined(level.interact_vehicle_mantle_hint_active)) LOC_00000020;
  level.interact_vehicle_mantle_hint_active = 0;

  for(;;) {
    if(!isDefined(self)) {
      level.player allowjump(1);
      return;
    }

    var1 = distance2dsquared(level.player.origin, var0.origin);

    if(var1 < 800) {
      if(!level.interact_vehicle_mantle_hint_active) {
        level.interact_vehicle_mantle_hint.alpha = 1;
        level.player allowjump(0);
      }

      level.interact_vehicle_mantle_hint_active = 1;

      if(level.player jumpbuttonPressed()) {
        level.interact_vehicle_mantle_hint.alpha = 0;
        return;
      }
    } else if(var1 > 20000) {
      wait 1;
    } else if(var1 > 500000) {
      wait 5;
    } else {
      level.interact_vehicle_mantle_hint_active = 0;
      waittillframeend();
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

function wait_for_mantle_inside(var0) {
  level notify("stop mantle wait");
  level endon("stop mantle wait");
  thread create_mantle_hint();
  var1 = distance2dsquared(level.player.origin, var0.origin);

  if(var1 < 4) {
    level.interact_vehicle_mantle_hint.alpha = 1;

    if(level.player jumpbuttonPressed()) {
      level.interact_vehicle_mantle_hint.alpha = 0;
      return 1;
    }

    return 0;
  }

  if(var1 > 4) {
    level.interact_vehicle_mantle_hint.alpha = 0;
  }

  return 0;
}

function create_mantle_hint() {
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

function block_for_push(var0, var1) {
  self endon("death");

  if(isDefined(var1)) {
    var1 = var1;
  } else {
    var1 = 6;
  }

  var2 = 0;

  for(;;) {
    var3 = distance2dsquared(level.player.origin, self.getin_hints[var0].origin);
    var4 = level.player getnormalizedmovement();
    var5 = scripts\engine\math::get_dot(self.getin_hints[var0].origin, self.getin_hints[var0].angles, level.player.origin);

    if(var3 < 900 && abs(var4[1]) > 0.2) {
      var2 += 1;

      if(var2 > var1) {
        break;
      }
    } else if(var3 > 10000) {
      var2 = 0;
      wait 1;
    } else if(var3 > 500000) {
      var2 = 0;
      wait 5;
    } else {
      var2 = 0;
    }

    waitframe();
  }
}

function interact_entry_anim() {
  var0 = scripts\sp\player_rig::get_player_rig(1);
  var0 hide();
  var1 = undefined;

  if(isDefined(self.ent)) {
    var1 = self.ent;
  } else if(isDefined(self.vehicle)) {
    var1 = self.vehicle;
  }

  level.player disableweapons();
  var2 = 0.4;
  level.player playerlinktoblend(var0, "tag_player", var2, 0, 0.2);
  thread interact_give_control_back(var2, var0);
  var0 scripts\engine\utility::delaycall(var2, &show);
  var1.animname = var1.script_noteworthy;
  var3 = var1 scripts\engine\utility::getanim(self.script_animation);
  wait 0.1;
  var4 = getanimlength(var3);
  var4 = 1 - (var4 - 2) / var4;
  wait var4;
  var0 delete();
  level.player enableweapons();
}

function interact_vehicle_delete_ground_ref_ent() {
  var0 = level.player.ground_ref_ent;
  var0.vehicleinteract = undefined;
  var0 rotateTo((0, 0, 0), 0.3, 0.1, 0.1);
}

function get_next_struct(var0) {
  if(isDefined(var0.target)) {
    return scripts\engine\utility::getStruct(var0.target, "targetname");
  }

  return undefined;
}

function get_prev_struct(var0) {
  if(isDefined(var0.targetname)) {
    return scripts\engine\utility::getStruct(var0.targetname, "target");
  }

  return undefined;
}

function get_opposite_door(var0) {
  var1 = undefined;

  if(var0 == "outside_lr") {
    var1 = "outside_rr";
  } else if(var0 == "outside_rr") {
    var1 = "outside_lr";
  }

  var2 = scripts\engine\utility::getStructArray(self.script_linkto, "script_linkname");

  foreach(var4 in var2) {
    if(isDefined(var4.script_namenumber) && var4.script_namenumber == var1) {
      return var4;
    }
  }
}

function interact_vehicle_movement(var0, var1, var2, var3) {
  self endon("death");
  var4 = 100;
  self.pathdir = vectorNormalize(var3.origin - var2.origin);
  var5 = length(var3.origin - var2.origin);
  var6 = var2.origin;

  if(!isDefined(var2.midpoint)) {
    var2.midpoint = spawnStruct();
    var2.midpoint.origin = var2.origin + self.pathdir * var5 * 0.5;
    var2.midpoint.angles = var2.angles;
    var2.midpoint.right = anglestoright(var2.angles);
  }

  self.pathstart = var2;
  self.movedist = 0;
  self.velocity = 0;
  self.trajectory = 0;
  self.isducking = 0;
  self.prevmoveright = 0;
  GscBinSkip4(0x35);
}

function get_end_door_state(var0) {
  switch (var0.script_namenumber) {
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

function interact_vehicle_duck_toggle() {
  level.player notifyonplayercommand("duck", "+movedown");
  level.player notifyonplayercommand("duck", "+togglecrouch");
  level.player notifyonplayercommand("duck", "+stance");

  for(;;) {
    level.player waittill("duck");
    self.isducking = !self.isducking;
    wait 0.2;
  }
}

function set_moverate_along_dir() {
  var0 = 3;
  var1 = level.player getnormalizedmovement();
  var2 = anglesToForward(level.player.angles);
  var3 = anglestoright(level.player.angles);
  var4 = var2 * var1[0] + var3 * var1[1];
  var5 = vectordot(var4, self.pathdir) * var0;

  if(abs(var5) > 0) {
    self.trajectory = var5 * 0.5;
  } else if(self.trajectory > 0.01) {
    self.trajectory -= self.trajectory * 0.5;
  } else if(self.trajectory < -0.01) {
    self.trajectory -= self.trajectory * 0.5;
  } else {
    self.trajectory = 0;
  }

  var6 = 1;

  if(self.isducking) {
    var6 = 0.6;
  }

  self.velocity = self.pathdir * self.trajectory * var6;
  self.ismoveright = is_pos_in_front(self.origin, self.origin + self.velocity, self.pathstart.midpoint.right);

  if(self.prevmoveright != self.ismoveright) {
    self.velocity *= 0.2;
  }

  self.prevmoveright = self.ismoveright;
  self.movelength = length(self.velocity);

  if(self.movelength == 0) {
    self.movedist = 0;
  } else {
    self.movedist += self.movelength;

    if(self.movedist > 10) {
      self.movedist = 2;
    }
  }

  var7 = self.movedist / 10;
  var8 = get_scoot_velocity(var7);
  self.velocity_bump = get_scoot_velocity_bump(var7);
  self.moveviewmult = var8;
  self.velocity *= var8 + self.velocity_bump;
}

function get_scoot_velocity(var0) {
  var1 = 3.14159;
  var2 = 2 * pow(var0, 1.5) * var1 + var1;
  var3 = var2 * 180 / var1;
  var4 = (cos(var3) + 1) / 2;
  return var4;
}

function get_scoot_velocity_bump(var0) {
  var1 = 0.2;
  var1 += (var1 - 0) * var0 * 2;

  if(var1 < 0) {
    var1 = 0;
  }

  return var1;
}

function qlerp(var0, var1, var2) {
  return var0 + (var1 - var0) * var2;
}

function set_viewangles() {
  level.player endon("death");

  if(!isDefined(level.player.ground_ref_ent)) {
    level.player.ground_ref_ent = spawn("script_origin", (0, 0, 0));
  }

  if(!isDefined(level.player.ground_ref_ent.vehicleinteract)) {
    level.player.ground_ref_ent.vehicleinteract = 1;
    level.player playersetgroundreferenceent(level.player.ground_ref_ent);
  }

  var0 = level.player.ground_ref_ent;
  var1 = 2;
  var2 = 1.5;
  var3 = -1;

  if(self.ismoveright) {
    var2 *= -1;
    var3 *= -1;
  }

  var4 = is_pos_in_front(self.pathstart.midpoint.origin, self.origin, self.pathstart.midpoint.right);

  if(var4) {
    var5 = (0, 0, -5);
  } else {
    var5 = (0, 0, 5);
  }

  var6 = distance2d(self.pathstart.midpoint.origin, self.origin);
  var5 = anglelerpquatfrac((0, 0, 0), var5, var6 / 5);
  var7 = (0, 0, 0);

  if(self.isducking) {
    if(!isDefined(self.duckingtime)) {
      self.duckingtime = gettime();
    }

    var8 = (gettime() - self.duckingtime) * 0.001;
    var9 = var8 / 0.2 * 1.5;
    var9 *= var6 / 5;
    var9 = clamp(var9, 0, 1);

    if(!isDefined(self.prevduckangles)) {
      self.prevduckangles = (0, 0, 0);
    }

    var10 = (0, 2, -10);

    if(var5) {
      var7 = anglelerpquatfrac((0, 0, 0), var10, var9);
    } else {
      var7 = anglelerpquatfrac((0, 0, 0), var10 * -1, var9);
    }

    var7 = anglelerpquatfrac(self.prevduckangles, var7, 0.0001);
    self.prevduckangles = var7;
  } else {
    self.duckingtime = undefined;
    self.prevduckangles = (0, 0, 0);
  }

  var11 = (var2, var3, var4) * self.moveviewmult;
  var11 += var7 + var5;

  if(!isDefined(self.prevviewangles)) {
    self.prevviewangles = (0, 0, 0);
  }

  if(self.moveviewmult < 0.05) {
    var11 = anglelerpquatfrac(self.prevviewangles, var11, 0.1);
  }

  self.prevviewangles = var11;

  if(var1.angles == var11) {
    return;
  }

  var12 = combineangles(self.pathstart.angles, var11);
  var13 = anglestoup(var12);
  var14 = vectorcross((1, 0, 0), var13);
  var15 = vectorcross(var13, var14);
  var12 = axistoangles(var15, var14, var13);
  var1.angles = anglelerpquatfrac(var1.angles, var12, 0.5);
}

function is_pos_in_front(var0, var1, var2) {
  var3 = (var1[0], var1[1], 0);
  var4 = (var0[0], var0[1], 0);
  var5 = vectordot(var2, vectorNormalize(var3 - var4));
  return var5 > 0;
}

function interact_give_control_back(var0, var1) {
  wait var0;
  level.player playerlinktodelta(var1, "tag_player", 0, 110, 110, 20, 30);
}

function hide_interact_vehicle(var0) {
  var1 = getscriptablearray(var0, "script_noteworthy")[0];
  var1 hide();
  return var1;
}

function show_interact_vehicle(var0) {
  var1 = getscriptablearray(var0, "script_noteworthy")[0];
  var1 show();
  return var1;
}

function get_interact_vehicle(var0) {
  foreach(var2 in level.interact_vehicle.entries) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == var0) {
      return var2;
    }
  }
}

function get_interact_vehicle_array(var0) {
  var1 = [];

  foreach(var3 in level.interact_vehicle.entries) {
    if(isDefined(var3.script_noteworthy) && var3.script_noteworthy == var0) {
      var1 = scripts\engine\utility::array_add(var1, var3);
    }
  }

  return var1;
}

function interact_vehicle_doors_state(var0, var1) {
  self endon("death");

  foreach(var3 in var0) {
    if(self.door_open[var3]) {
      continue;
    }

    switch (var3) {
      case "hatch":
      case "rr":
      case "rf":
      case "lr":
      case "lf":
        self.dont_lerp_player = 1;
        self.getin_hints[var3].hint_ent notify("trigger");
        waittillframeend();
        self.dont_lerp_player = 0;
        break;
      default:
        break;
    }
  }
}

function interact_vehicle_doors_inactive(var0) {
  self endon("death");

  foreach(var2 in var0) {
    switch (var2) {
      case "hatch":
      case "rr":
      case "rf":
      case "lr":
      case "lf":
        self.getin_hints[var2].hint_ent delete();
        break;
      default:
        break;
    }
  }
}

function interact_interior_door_hack(var0) {
  var1 = undefined;

  switch (var0) {
    case "lr":
      var1 = scripts\engine\utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones["inside_lr"]));
      var1 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, undefined, 270, 250, 55, 0);
      self.getin_hints["lr_inside"] = spawnStruct();
      self.getin_hints["lr_inside"].hint_ent = var1;
      var1 waittill("trigger");
      var1 delete();
      thread interact_vehicle_animate_door("lr");
      break;
    case "rr":
      var1 = scripts\engine\utility::spawn_tag_origin(self.vehicle gettagorigin(self.hint_bones["inside_rr"]));
      var1 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, undefined, 270, 250, 55, 0);
      self.getin_hints["rr_inside"] = spawnStruct();
      self.getin_hints["rr_inside"].hint_ent = var1;
      var1 waittill("trigger");
      var1 delete();
      thread interact_vehicle_animate_door("rr");
      break;
  }
}

function interact_getanim(var0) {
  if(isDefined(level.scr_anim[self.animname]) && isDefined(level.scr_anim[self.animname][var0])) {
    return scripts\engine\utility::getanim(var0);
  }

  return level.scr_anim["interact_vehicle"][var0];
}

function interact_vehicle_animate_door(var0) {
  self.door_open[var0] = 1;
  var1 = interact_getanim(self.vehicle, var0 + "_open");

  if(isDefined(self.door_col) && isDefined(self.door_col[var0])) {
    scripts\engine\utility::noself_delaycall(getanimlength(var1), &createnavobstaclebyent, self.door_col[var0], "axis", "allies");
  }

  self.vehicle setanim(var1, 1, 0.2, 2);
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;

  switch (var0) {
    case "lf":
      var4 = "lr";
      var2 = "Conceal Crouch";
      var3 = "Conceal Crouch";
      break;
    case "lr":
      var4 = "lf";
      var2 = "Conceal Crouch";
      var3 = "Conceal Crouch";
      break;
    case "rf":
      var4 = "rr";
      var2 = "Conceal Crouch";
      var3 = "Conceal Crouch";
      break;
    case "rr":
      var4 = "rf";
      var2 = "Conceal Crouch";
      var3 = "Conceal Crouch";
      break;
  }

  if(is_van() && (var0 == "rf" || var0 == "lr" || var0 == "rr")) {
    return;
  }

  if(isDefined(var2)) {
    self.cover_nodes[var0] = interact_vehicle_spawn_cover_node(self, var0, var2, "door_back");

    if(var0 == "lr" || var0 == "rr") {
      if(!istrue(self.door_open[var4])) {
        self.cover_nodes[var0 + "_front"] = interact_vehicle_spawn_cover_node(self, var0, var2, "door_front");
        return;
      }

      return;
    }

    if(var0 == "lf" || var0 == "rf") {
      self.cover_nodes[var0 + "_front"] = interact_vehicle_spawn_cover_node(self, var0, var2, "door_front");

      if(istrue(self.door_open[var4]) && isDefined(self.cover_nodes[var4 + "_front"])) {
        despawncovernode(self.cover_nodes[var4 + "_front"]);
        return;
      }

      return;
    }

    return;
  }
}

function interact_vehicle_spawn_cover_node(var0, var1, var2, var3) {
  var4 = undefined;

  switch (var3) {
    case "door_back":
      var4 = spawncovernode(var0.doors[var1].origin + anglestoup(var0.doors[var1].angles) * -50, var0.doors[var1].angles, var2);
      break;
    case "door_front":
      var4 = spawncovernode(var0.doors[var1].origin + anglestoup(var0.doors[var1].angles) * -50 + anglesToForward(var0.doors[var1].angles) * 48, var0.doors[var1].angles + (0, 180, 0), var2);
      break;
    default:
      var4 = spawncovernode(var1.origin + anglestoup(var1.angles) * -50, var1.angles, var2);
      break;
  }

  if(isDefined(var0.script_color_allies) && isDefined(var4)) {
    var4.script_color_allies = var0.script_color_allies;
    update_color_nodes(var4);
  }

  return var4;
}

function update_color_nodes(var0) {
  if(isDefined(var0.script_color_allies)) {
    add_node_to_global_arrays(var0, var0.script_color_allies, "allies");
  }

  if(isDefined(var0.script_color_axis)) {
    add_node_to_global_arrays(var0, var0.script_color_axis, "axis");
    return;
  }
}

function add_node_to_global_arrays(var0, var1) {
  self.color_user = undefined;
  var2 = strtok(var0, " ");
  var2 = scripts\sp\colors::array_remove_dupes(var2);

  foreach(var4 in var2) {
    if(isDefined(level.arrays_of_colorcoded_nodes[var1]) && isDefined(level.arrays_of_colorcoded_nodes[var1][var4])) {
      if(!scripts\engine\utility::array_contains(level.arrays_of_colorcoded_nodes[var1][var4], self)) {
        level.arrays_of_colorcoded_nodes[var1][var4] = scripts\engine\utility::array_add(level.arrays_of_colorcoded_nodes[var1][var4], self);
        continue;
      }
    }

    level.arrays_of_colorcoded_nodes[var1][var4][0] = self;
    level.arrays_of_colorcoded_ai[var1][var4] = [];
    level.arrays_of_colorcoded_spawners[var1][var4] = [];
  }
}

function is_van() {
  if(isDefined(self.script_animname) && self.script_animname == "sprinter") {
    return true;
  }

  return false;
}