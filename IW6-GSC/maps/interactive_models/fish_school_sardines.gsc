/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\fish_school_sardines.gsc
************************************************************/

#using_animtree("animals");

main() {
  var_0 = spawnStruct();
  var_0.name = "fish_school_sardines";
  var_0.targetname = "interactive_fish_school_sardines";
  var_0.piece = spawnStruct();
  var_0.piece.model = "sardines_flocking_rig";
  var_0.piece.tagprefix = "tag_attach";
  var_0.piece.maxturn = 5;
  var_0.piece.animtree = #animtree;
  var_0.piece.anims = [];
  var_0.piece.anims["idle_loop"] = % sardines_flock_loop;
  var_0.piece.anims["add_bend_left"] = % sardines_flock_add_left60;
  var_0.piece.anims["add_bend_right"] = % sardines_flock_add_right60;
  var_0.piece.anims["add_fast"] = % sardines_flock_add_stretch_horiz;
  var_0.piece.anims["add_tilt_left"] = % sardines_flock_add_tilt_left_add;
  var_0.piece.anims["add_tilt_right"] = % sardines_flock_add_tilt_right_add;
  var_0.piece.anims["add_tilt_left_child"] = % sardines_flock_add_tilt_left;
  var_0.piece.anims["add_tilt_right_child"] = % sardines_flock_add_tilt_right;
  var_0.piece.anims["add_rotate_left"] = % sardines_flock_add_rotate_left_add;
  var_0.piece.anims["add_rotate_left_child"] = % sardines_flock_add_rotate_left;
  var_0.piece.anims["add_rotate_right"] = % sardines_flock_add_rotate_right_add;
  var_0.piece.anims["add_rotate_right_child"] = % sardines_flock_add_rotate_right;
  var_0.fish = spawnStruct();
  var_0.fish.model = [];
  var_0.fish.model[0]["bright"] = "sardines_single";
  var_0.fish.model[1]["bright"] = "sardines_smallergroup";
  var_0.fish.model[2]["bright"] = "sardines_smallgroup";
  var_0.fish.model[2]["grey1"] = "sardines_smallgroup_grey75";
  var_0.fish.model[2]["grey2"] = "sardines_smallgroup_grey50";
  var_0.fish.anims = [];
  var_0.fish.anims["idle_loop"] = % sardines_smallgroup_loop1;
  var_0.ball = spawnStruct();
  var_0.ball.rotationperiod = 5;
  var_0.ball.numtags = 16;
  var_0.ball.relocatespeed = 20;
  var_0.ball.reactdistance = 300;
  var_0.ball.panicdistance = 150;
  var_0.ball.maxdriftdist = 150;
  var_0.ball.driftspeed = 10;
  var_0.ball.ringvertoffset = 48;
  var_0.ball.rings = [];
  var_0.ball.rings[0] = spawnStruct();
  var_0.ball.rings[0].numpieces = 6;
  var_0.ball.rings[0].radius = 64;
  var_0.ball.rings[0].offset = -1 * var_0.ball.ringvertoffset;
  var_0.ball.rings[1] = spawnStruct();
  var_0.ball.rings[1].numpieces = 6;
  var_0.ball.rings[1].radius = 96;
  var_0.ball.rings[1].offset = -1 * var_0.ball.ringvertoffset;
  var_0.ball.rings[2] = spawnStruct();
  var_0.ball.rings[2].numpieces = 6;
  var_0.ball.rings[2].radius = 64;
  var_0.ball.rings[2].offset = var_0.ball.ringvertoffset;
  var_0.ball.rings[3] = spawnStruct();
  var_0.ball.rings[3].numpieces = 6;
  var_0.ball.rings[3].radius = 96;
  var_0.ball.rings[3].offset = var_0.ball.ringvertoffset;
  var_0.line = spawnStruct();
  var_0.line.spacing = 3;
  var_0.line.anims = [];
  var_0.line.anim_base = % sardines_flock_spin;
  var_0.line.anims[0] = % sardines_flock_spinloop;
  var_0.line.anims[1] = % sardines_flock_spinloop_fast;
  var_0.line.anims[2] = % sardines_flock_spinloop_faster;
  var_0.line.animspeeds[0] = 8.8;
  var_0.line.animspeeds[1] = 17.6;
  var_0.line.animspeeds[2] = 44.0;
  var_0.line.animoffset = 0.12;
  var_0.line.taper = 10;
  var_0.line.tagmodels = [];
  var_0.line.tagmodels["1"] = 4;
  var_0.line.tagmodels["2"] = 3;
  var_0.line.tagmodels["3"] = 3;
  var_0.line.tagmodels["5"] = 3;
  var_0.line.tagmodels["6"] = 3;
  var_0.line.tagmodels["7"] = 2.5;
  var_0.line.tagmodels["8"] = 2.5;
  var_0.line.tagmodels["10"] = 2;
  var_0.line.tagmodels["11"] = 2;
  var_0.line.tagmodels["12"] = 2;
  var_0.line.tagmodels["14"] = 2;
  var_0.line.tagmodels["15"] = 2;
  var_0.line.tagmodels["16"] = 2;
  var_0.line.tagmodels["17"] = 1.5;
  var_0.line.tagmodels["19"] = 1.5;
  var_0.line.tagmodels["20"] = 1.5;
  var_0.line.tagmodels["21"] = 1;
  var_0.line.tagmodels["22"] = 1;
  var_0.line.tagmodels["23"] = 1;
  var_0.line.tagmodels["25"] = 1;
  var_0.line.tagmodels["26"] = 0.5;
  var_0.line.tagmodels["27"] = 0.5;
  var_0.line.tagmodels["28"] = 0.5;
  var_0.line.tagmodels["30"] = 0.5;
  var_0.line.tagmodels["31"] = 0.5;

  if(!isDefined(level._interactive))
    level._interactive = [];

  level._interactive["sardines"] = var_0;
  thread sardines(var_0);
}

sardines(var_0) {
  precachemodel(var_0.piece.model);

  foreach(var_2 in var_0.fish.model) {
    foreach(var_4 in var_2)
    precachemodel(var_4);
  }

  precachestring(&"PLATFORM_HOLD_TO_USE");
  level waittill("load_finished");

  if(!isDefined(level._interactive[var_0.name + "_setup"])) {
    level._interactive[var_0.name + "_setup"] = 1;
    var_0.line.animlengths = [];

    for(var_7 = 0; var_7 < var_0.line.animspeeds.size; var_7++)
      var_0.line.animlengths[var_7] = getanimlength(var_0.line.anims[var_7]);

    var_8 = getEntArray(var_0.targetname, "targetname");

    foreach(var_10 in var_8) {
      if(var_10.model == "sardines_ball_radiant") {
        var_10 thread sardines_ball(var_0);
        continue;
      }

      var_10 thread sardines_line(var_0);
    }
  }
}

sardines_line(var_0) {
  self endon("death");
  self hideallparts();
  var_1 = [];

  if(isDefined(self.target))
    var_1 = getvehiclenodearray(self.target, "targetname");

  if(var_1.size >= 1)
    var_2 = common_scripts\utility::getclosest(self.origin, var_1);
  else {
    var_1 = getvehiclenodearray("fish_path", "script_noteworthy");
    var_2 = undefined;

    foreach(var_4 in var_1) {
      if(distance(var_4.origin, self.origin) < 1) {
        var_2 = var_4;
        break;
      }
    }
  }

  var_6 = common_scripts\_csplines::cspline_findpathnodes(var_2);
  self.path = common_scripts\_csplines::cspline_makepath(var_6, 1);
  var_7 = common_scripts\_csplines::cspline_length(self.path);
  var_8 = common_scripts\_csplines::cspline_time(self.path);
  var_9 = int(var_8 / var_0.line.spacing + 0.5);
  self.spacing = var_8 / var_9;

  if(isDefined(self.interactive_number))
    self.numpieces = int(min(var_9, self.interactive_number));
  else
    self.numpieces = var_9;

  sardines_linemonitortriggers(var_0);
}

sardines_linemonitortriggers(var_0) {
  var_1 = undefined;

  if(isDefined(self.target))
    var_1 = getEntArray(self.target, "targetname");

  var_2 = 0;

  if(isDefined(var_1) && var_1.size > 0) {
    var_3 = [];

    foreach(var_5 in var_1) {
      if(!isDefined(var_5.script_triggername))
        var_5.script_triggername = "start";

      var_5 thread maps\interactive_models\_interactive_utility::waittill_notify("trigger", self, var_5.script_triggername, undefined, 1);
    }
  }

  self.startstopstate = "stopped";

  for(;;) {
    var_2 = 0;
    var_7 = common_scripts\utility::waittill_any_return("start", "start_instant", "stop", "stop_instant");

    if(self.startstopstate == "stopped" && (var_7 == "start" || var_7 == "start_instant")) {
      self.startstopstate = var_7;
      thread sardines_linethinkloop(var_0, self.interactive_number);
      continue;
    }

    self.startstopstate = var_7;
  }
}

sardines_linethinkloop(var_0, var_1) {
  var_2 = var_1;
  self.numberoffishinexistence = 0;
  var_3 = common_scripts\_csplines::cspline_time(self.path);
  var_4 = common_scripts\_csplines::cspline_getpointattime(self.path, 0);
  var_5 = vectortoangles(var_4["vel"]);
  var_4 = var_4["pos"];
  sardines_linespawnpieces(var_0);

  if(self.startstopstate == "start_instant") {
    if(isDefined(var_2))
      var_6 = self.spacing * var_1;
    else
      var_6 = self.spacing * self.numpieces;

    self.startstopstate = "started";

    foreach(var_8 in self.pieces) {
      if(!isDefined(var_2) || var_2 > 0) {
        var_8 showallparts();
        self.numberoffishinexistence++;
        var_8.visible = 1;
        var_8 sardines_lineattachmodelsandtaperends(var_0, self.numberoffishinexistence, var_2);
        var_6 = var_6 - self.spacing;
        var_8.distance = var_6;

        if(isDefined(var_2))
          var_2--;
      }
    }
  } else {}

  self.startstopstate = "started";

  while(!isDefined(var_2) || var_2 > 0 || self.numberoffishinexistence > 0) {
    if(self.startstopstate == "stop" && (!isDefined(var_2) || var_2 > var_0.line.taper))
      var_2 = var_0.line.taper;
    else if(self.startstopstate == "stop_instant") {
      break;
    }

    for(var_10 = self.pieces.size - 1; var_10 >= 0; var_10--) {
      var_8 = self.pieces[var_10];

      if(var_8.distance == 0) {
        if(!isDefined(var_2) || var_2 > 0) {
          var_8 showallparts();
          self.numberoffishinexistence++;
          var_8.visible = 1;
          var_8 sardines_lineattachmodelsandtaperends(var_0, self.numberoffishinexistence, var_2);
        }

        if(isDefined(var_2))
          var_2--;
      }

      var_8.distance = var_8.distance + 1;
      var_11 = undefined;

      if(var_8.distance > var_3) {
        var_8.distance = 0;
        var_8.animoffset = self.pieces[maps\interactive_models\_interactive_utility::wrap(var_10 + 1, self.pieces.size)].animoffset - var_0.line.animoffset;
        var_8.animoffset = var_8.animoffset + 1 - int(var_8.animoffset + 1);

        for(var_12 = 0; var_12 < var_0.line.anims.size; var_12++)
          var_8 setanimtime(var_0.line.anims[var_12], var_8.animoffset);

        var_8 sardines_piecesetmodelsfromarray(var_0, var_0.line.tagmodels, undefined);

        if(var_8.visible)
          self.numberoffishinexistence--;

        var_8.visible = 0;
        var_11 = 0;
      }

      if(var_8.visible) {
        var_13 = common_scripts\_csplines::cspline_getpointattime(self.path, var_8.distance);
        var_8.origin = var_13["pos"] + (0, 0, var_8.offset);
        var_14 = vectortoangles(var_13["vel"]);
        var_8.angles = var_14;
        var_8 maps\interactive_models\_interactive_utility::blendanimsbyspeed(var_13["speed"] * var_8.speedforanimmult, var_0.line.anims, var_0.line.animspeeds, var_0.line.animlengths, var_11);
        continue;
      }

      var_8.origin = var_4;
      var_8.angles = var_5;
    }

    wait 0.05;
  }

  sardines_linedeletepieces();
  self.startstopstate = "stopped";
}

sardines_lineattachmodelsandtaperends(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_3 = min(var_1, var_2);
  else
    var_3 = var_1;

  if(var_3 < var_0.line.taper) {
    if(var_3 == 2) {
      self.speedforanimmult = 1;
      sardines_piecesetmodelsfromarray(var_0, var_0.line.tagmodels, undefined);
    } else {
      self.speedforanimmult = 4 - 3 * var_3 / var_0.line.taper;
      var_4 = -4 + 4 * var_3 / var_0.line.taper;
      sardines_piecesetmodelsfromarray(var_0, var_0.line.tagmodels, "bright", var_4);
    }
  } else {
    self.speedforanimmult = 1;
    sardines_piecesetmodelsfromarray(var_0, var_0.line.tagmodels, "bright", 0);
  }
}

sardines_linespawnpieces(var_0) {
  if(!isDefined(self.pieces)) {
    var_1 = int(1 + common_scripts\_csplines::cspline_time(self.path));
    self.pieces = [];

    for(var_2 = 0; var_2 < self.numpieces; var_2++) {
      self.pieces[var_2] = spawn("script_model", self.origin);
      var_3 = self.pieces[var_2];
      var_3.piecenum = var_2;
      var_3 setModel(var_0.piece.model);
      var_3 useanimtree(var_0.piece.animtree);
      var_3 setanim(var_0.line.anim_base, 1, 0.1, 1);

      for(var_4 = 0; var_4 < var_0.line.anims.size; var_4++)
        var_3 setanim(var_0.line.anims[var_4], 0.01, 0.1, 0);

      if(var_2 == 0) {
        var_5 = 0;
        var_6 = 0;
      } else {
        var_5 = self.pieces[var_2 - 1].offset;

        if(var_2 > 1)
          var_6 = self.pieces[var_2 - 2].offset;
        else
          var_6 = 0;
      }

      if(var_2 == self.numpieces - 1)
        var_3.offset = 0.5 * (var_5 + self.pieces[0].offset);
      else
        var_3.offset = 0.85 * (randomfloatrange(-18, 18) + 1.5 * var_5 - 0.5 * var_6);

      var_3.distance = var_1;
      var_1 = var_1 - self.spacing;
    }

    self.pieces[0].distance = 0;
    common_scripts\utility::waitframe();

    for(var_2 = 0; var_2 < self.numpieces; var_2++) {
      var_3 = self.pieces[var_2];
      var_3.animoffset = var_2 * var_0.line.animoffset;
      var_7 = var_3.animoffset + var_3.distance / 20;
      var_7 = var_7 - int(var_7);

      for(var_4 = 0; var_4 < var_0.line.anims.size; var_4++)
        var_3 setanimtime(var_0.line.anims[var_4], var_7);

      var_3.visible = 0;
    }
  }
}

sardines_linedeletepieces() {
  foreach(var_1 in self.pieces)
  var_1 delete();

  self.pieces = undefined;
}

sardines_linedebugdrawstats() {}

sardines_ball(var_0) {
  self endon("death");
  self setModel("tag_origin");
  self.origin = self.origin + (0, 0, 32);
  self.pieces = [];
  self.rotationspeed = 360 / (20 * var_0.ball.rotationperiod);
  self.locations = [];
  self.locations[0] = self.origin;
  self.currectlocindex = 0;
  var_1 = maps\_utility::getstruct_delete(self.target, "targetname");

  if(!isDefined(var_1))
    self.locations[1] = self.origin + (-800, 0, 0);
  else {
    while(isDefined(var_1)) {
      self.locations[self.locations.size] = var_1.origin + (0, 0, 32);

      if(isDefined(var_1.target)) {
        var_1 = getent(var_1.target, "targetname");
        continue;
      }

      var_1 = undefined;
    }
  }

  var_2 = 0;
  self.rings = [];

  for(var_3 = 0; var_3 < var_0.ball.rings.size; var_3++) {
    self.rings[var_3] = [];

    for(var_4 = 0; var_4 < var_0.ball.rings[var_3].numpieces; var_4++) {
      self.pieces[var_2] = spawn("script_model", self.origin);
      self.rings[var_3][var_4] = var_2;
      self.pieces[var_2].ball_ring = var_3;
      self.pieces[var_2].ball_angle = var_4 * 360 / var_0.ball.rings[var_3].numpieces;
      self.pieces[var_2].ball_offset = var_0.ball.rings[var_3].offset;
      self.pieces[var_2].ball_i = var_4;
      self.pieces[var_2].ball_inplace = 1;
      self.pieces[var_2] setModel(var_0.piece.model);
      self.pieces[var_2] sardines_balllinkpiece(self, self.pieces[var_2].ball_angle, var_0.ball.rings[var_3].radius, var_0.ball.rings[var_3].offset);
      self.pieces[var_2] useanimtree(var_0.piece.animtree);
      self.pieces[var_2] setanimknob(var_0.piece.anims["idle_loop"], 1, 0.1, 1);
      self.pieces[var_2] setanimknob(var_0.piece.anims["add_bend_left"], 1, 0.1, 1);
      self.pieces[var_2] setanim(var_0.piece.anims["add_tilt_left_child"]);
      self.pieces[var_2] setanim(var_0.piece.anims["add_tilt_right_child"]);
      var_5 = maps\interactive_models\_interactive_utility::clampandnormalize(self.pieces[var_2].ball_offset, 0, var_0.ball.ringvertoffset);
      self.pieces[var_2] setanim(var_0.piece.anims["add_tilt_left"], var_5, 0.1, 1);
      var_5 = maps\interactive_models\_interactive_utility::clampandnormalize(self.pieces[var_2].ball_offset, 0, -1 * var_0.ball.ringvertoffset);
      self.pieces[var_2] setanim(var_0.piece.anims["add_tilt_right"], var_5, 0.1, 1);
      self.pieces[var_2] setanimlimited(var_0.piece.anims["add_rotate_left_child"]);
      self.pieces[var_2] setanimlimited(var_0.piece.anims["add_rotate_right_child"]);
      self.pieces[var_2] setanim(var_0.fish.anims["idle_loop"], 1, 0.1, 1);
      var_6 = var_0.fish.model[2]["grey2"];

      if(var_3 == 1 || var_3 == 3)
        var_6 = var_0.fish.model[2]["bright"];

      self.pieces[var_2].fish_model = [];
      self.pieces[var_2] thread sardines_piecesetmodels(var_6, var_0.ball.numtags, var_0.piece.tagprefix, 0);
      var_2++;
    }

    self.rings_isspread[var_3] = 0;
  }

  common_scripts\utility::waitframe();

  for(var_4 = 0; var_4 < self.pieces.size; var_4++) {
    var_7 = var_4 * 5 / 24;
    var_7 = var_7 - int(var_7);
    self.pieces[var_4] setanimtime(var_0.piece.anims["idle_loop"], var_7);
  }

  var_8 = 0;

  for(;;) {
    thread sardines_ballrotate(var_0);
    wait 2;
    thread sardines_detectpeople(var_0.ball.reactdistance, var_0.ball.panicdistance, var_0.ball.driftspeed, var_0.ball.maxdriftdist, "detectPeople");
    self waittill("detectPeople");
    self notify("stop_ballRotate");
    self.currectlocindex = maps\interactive_models\_interactive_utility::wrap(self.currectlocindex + 1, self.locations.size);
    var_9 = self.locations[self.currectlocindex];
    sardines_ballpanic(var_0, var_9 - self.origin, self.intruderorigin - self.origin, var_0.ball.relocatespeed);
    common_scripts\utility::waitframe();
  }
}

sardines_piecesetmodels(var_0, var_1, var_2, var_3) {
  self endon("death");
  self notify("sardines_pieceSetModels_starting");
  self endon("sardines_pieceSetModels_starting");
  var_4 = var_3 / var_1;

  for(var_5 = 1; var_5 <= var_1; var_5++) {
    if(isDefined(self.fish_model[var_5]))
      self detach(self.fish_model[var_5], var_2 + var_5);

    self attach(var_0, var_2 + var_5);
    self.fish_model[var_5] = var_0;
    wait(var_4);
  }
}

sardines_piecesetmodelsfromarray(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    self detachall();
    self.brightness = undefined;
    self.thicknessoffset = undefined;
    return;
  }

  if(!isDefined(var_3))
    var_3 = 0;

  self endon("death");

  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = var_4 / var_1.size;
  var_6 = getarraykeys(var_1);
  var_7 = self.piecenum / 10;

  foreach(var_9 in var_6) {
    var_7 = (var_7 + 0.1) * 6;
    var_7 = var_7 - int(var_7);

    if(isDefined(self.brightness)) {
      var_10 = int(var_1[var_9] + self.thicknessoffset + (2 * var_7 - 1));

      if(var_10 >= var_0.fish.model.size)
        var_10 = var_0.fish.model.size - 1;

      if(var_10 >= 0) {
        if(isDefined(var_0.fish.model[var_10]))
          self detach(var_0.fish.model[var_10][self.brightness], var_0.piece.tagprefix + var_9);
      }
    }

    var_11 = int(var_1[var_9] + var_3 + (2 * var_7 - 1));

    if(var_11 >= var_0.fish.model.size)
      var_11 = var_0.fish.model.size - 1;

    if(var_11 >= 0) {
      if(isDefined(var_0.fish.model[var_11]))
        self attach(var_0.fish.model[var_11][var_2], var_0.piece.tagprefix + var_9);

      wait(var_5);
    }
  }

  self.brightness = var_2;
  self.thicknessoffset = var_3;
}

sardines_ballrotate(var_0) {
  self endon("death");
  self endon("stop_ballRotate");
  var_1 = self.angles[1];

  for(;;) {
    var_1 = var_1 + self.rotationspeed;

    if(var_1 > 360)
      var_1 = var_1 - 360;

    self.angles = (0, var_1, 0);

    for(var_2 = 0; var_2 < var_0.ball.rings.size; var_2++) {
      if(!self.rings_isspread[var_2])
        self.rings_isspread[var_2] = sardines_spreadring(var_0, self, var_2);
    }

    common_scripts\utility::waitframe();
  }
}

sardines_ballpanic(var_0, var_1, var_2, var_3) {
  var_4 = [];

  for(var_5 = 0; var_5 < self.pieces.size; var_5++) {
    var_6 = self.pieces[var_5];

    if(isDefined(var_6.ball_ring) && var_6.ball_inplace) {
      var_7 = var_6.ball_angle + self.angles[1];
      var_8 = cos(var_7);
      var_9 = sin(var_7);
      var_4[var_5] = (var_8, var_9, 0);
      var_4[var_5] = var_4[var_5] * (self.rotationspeed * 3.14159 / 180 * var_0.ball.rings[var_6.ball_ring].radius);
      var_6 unlink();
      var_6 thread sardines_piecesetmodels(var_0.fish.model[2]["bright"], var_0.ball.numtags, var_0.piece.tagprefix, 0.2);
      continue;
    }

    var_6 notify("stop_path");
    var_10 = common_scripts\_csplines::cspline_getpointattime(var_6.path, var_6.path_distance);
    var_4[var_5] = var_10["vel"] * var_6.speed;
    var_11 = vectortoangles(var_6.origin - self.origin);
    var_6.ball_angle = var_11[1] + 90;
  }

  var_12 = vectortoangles(var_2);
  var_2 = (var_2[0], var_2[1], 0);
  var_13 = vectornormalize(var_2);
  var_14 = length(var_1);
  var_15 = var_1 / var_14;
  var_16 = (-1 * var_15[1], var_15[0], var_15[2]);
  var_17 = self.origin + var_15 * (var_14 - 150) - var_16 * 64;
  var_18[0] = spawnStruct();
  var_18[1] = spawnStruct();
  var_18[0].pieces = [];
  var_18[1].pieces = [];
  var_18[0].currentvels = [];
  var_18[1].currentvels = [];
  var_18[0].endvel = undefined;
  var_18[1].endvel = undefined;
  var_19 = vectortoangles(var_1);
  var_20 = angleclamp180(var_19[1] - var_12[1]);

  if(var_20 > 90 || var_20 < -90) {
    var_18[0].midpoint = self.origin - 100 * var_16 - 100 * var_15 - (0, 0, 100);
    var_18[0].midvel = (var_15 - var_16 - (0, 0, 1)) / 1.732;
    var_18[0].endpoint = var_17 - var_16 * 50;
    var_18[1].midpoint = self.origin + 100 * var_16 + 100 * var_15 + (0, 0, 100);
    var_18[1].midvel = (2 * var_15 - var_16 + (0, 0, 1)) / 2.45;
    var_18[1].endpoint = var_17 + var_16 * 50;

    for(var_5 = 0; var_5 < self.pieces.size; var_5++) {
      var_7 = angleclamp180(self.pieces[var_5].ball_angle + self.angles[1] - var_20);

      if(var_7 < 0) {
        var_18[0].pieces[var_18[0].pieces.size] = self.pieces[var_5];
        var_18[0].currentvels[var_18[0].currentvels.size] = var_4[var_5];
        continue;
      }

      var_18[1].pieces[var_18[1].pieces.size] = self.pieces[var_5];
      var_18[1].currentvels[var_18[1].currentvels.size] = var_4[var_5];
    }
  } else if(var_20 > -90 && var_20 < 20) {
    var_12 = var_12 - self.angles;
    var_21 = (-1 * var_13[1], var_13[0], var_13[2]);
    var_18[0].midpoint = self.origin + var_2 + 100 * var_21 + 20 * var_16 + (0, 0, 100);
    var_18[0].midvel = (var_13 + var_21 + (0, 0, 1)) / 1.732;
    var_18[0].endpoint = var_17 + var_16 * 20 - (0, 0, 20);
    var_18[0].endvel = (var_15 - var_16 * 0.5 + (0, 0, 0.5)) / 1.225;
    var_18[1].midpoint = self.origin + 130 * var_13 - 200 * var_21 - (0, 0, 100);
    var_18[1].midvel = (var_13 - (0, 0, 1)) / 1.414;
    var_18[1].endpoint = var_17 - var_16 * 150 + (0, 0, 40);
    var_18[1].endvel = (var_15 + var_16 - (0, 0, 1)) / 1.732;

    for(var_5 = 0; var_5 < self.pieces.size; var_5++) {
      var_7 = angleclamp180(self.pieces[var_5].ball_angle - var_12[1]);

      if(var_7 > 45 || var_7 < -135) {
        var_18[0].pieces[var_18[0].pieces.size] = self.pieces[var_5];
        var_18[0].currentvels[var_18[0].currentvels.size] = var_4[var_5];
        continue;
      }

      var_18[1].pieces[var_18[1].pieces.size] = self.pieces[var_5];
      var_18[1].currentvels[var_18[1].currentvels.size] = var_4[var_5];
    }
  } else {
    var_15 = vectornormalize(var_1);
    var_16 = (-1 * var_15[1], var_15[0], var_15[2]);
    var_18[0].midpoint = self.origin + 20 * var_16 + 180 * var_15 + (0, 0, 100);
    var_18[0].midvel = (2 * var_15 + var_16 + (0, 0, 1)) / 2.45;
    var_18[0].endpoint = var_17;
    var_18[1].midpoint = self.origin + 150 * var_16 - 60 * var_15 - (0, 0, 100);
    var_18[1].midvel = (2 * var_15 + var_16 - (0, 0, 1)) / 2.45;
    var_18[1].endpoint = var_17 - var_15 * 50 + var_16 * 50;
    var_12 = var_12 - self.angles;

    for(var_5 = 0; var_5 < self.pieces.size; var_5++) {
      var_7 = angleclamp180(self.pieces[var_5].ball_angle - var_12[1]);

      if(var_7 > -45 && var_7 < 135) {
        var_18[0].pieces[var_18[0].pieces.size] = self.pieces[var_5];
        var_18[0].currentvels[var_18[0].currentvels.size] = var_4[var_5];
        continue;
      }

      var_18[1].pieces[var_18[1].pieces.size] = self.pieces[var_5];
      var_18[1].currentvels[var_18[1].currentvels.size] = var_4[var_5];
    }
  }

  foreach(var_23 in var_18) {
    var_24 = undefined;

    if(var_14 > 400)
      var_24 = common_scripts\_csplines::cspline_makepathtopoint(var_23.midpoint, var_23.endpoint, var_23.midvel, var_23.endvel);

    var_25 = [];
    var_26 = [];
    var_27 = [];

    for(var_5 = 0; var_5 < var_23.pieces.size; var_5++) {
      var_25[var_5] = common_scripts\_csplines::cspline_makepathtopoint(var_23.pieces[var_5].origin, var_23.midpoint, var_23.currentvels[var_5] / var_3, var_23.midvel, 1);
      var_26[var_5] = common_scripts\_csplines::cspline_time(var_25[var_5]);
      var_27[var_5] = var_5;
    }

    var_28 = var_0.line.spacing * var_3;
    var_27 = maps\interactive_models\_interactive_utility::array_sortbyarray(var_27, var_26);
    var_29 = 0;

    for(var_30 = 0; var_30 < var_27.size; var_30++) {
      var_5 = var_27[var_30];
      var_31 = var_29 + var_28 * var_5;

      if(var_26[var_5] > var_31)
        var_29 = var_29 + (var_26[var_5] - var_31);
    }

    var_29 = var_29 / 2;

    for(var_30 = 0; var_30 < var_27.size; var_30++) {
      var_5 = var_27[var_30];
      var_32 = var_29 + var_28 * var_5;
      common_scripts\_csplines::cspline_adjusttime(var_25[var_5], var_32);
    }

    for(var_5 = 0; var_5 < var_23.pieces.size; var_5++) {
      var_23.pieces[var_5] setanimknob(var_0.line.anim_base, 1, 0.3);
      var_23.pieces[var_5] thread sardines_setpathanimstarttimes(var_5, var_0.line.anims);

      if(var_5 == 0 || var_5 == var_23.pieces.size - 1)
        var_23.pieces[var_5] thread sardines_pieceswimpath(var_0, var_25[var_5], var_3, undefined, var_24, 3);
      else
        var_23.pieces[var_5] thread sardines_pieceswimpath(var_0, var_25[var_5], var_3, undefined, var_24);

      if(isDefined(var_23.pieces[var_5].ball_ring)) {
        self.rings[var_23.pieces[var_5].ball_ring][var_23.pieces[var_5].ball_i] = undefined;
        var_23.pieces[var_5].ball_ring = undefined;
        var_23.pieces[var_5].ball_i = undefined;
        var_23.pieces[var_5].ball_angle = undefined;
        var_23.pieces[var_5].ball_offset = undefined;
        var_23.pieces[var_5].ball_inplace = undefined;
      }
    }
  }

  self.origin = self.origin + var_1;

  for(var_5 = 0; var_5 < self.pieces.size; var_5++)
    self.pieces[var_5] thread sardines_ballwaitthenaddpiece(var_0, self, var_5);
}

sardines_setpathanimstarttimes(var_0, var_1) {
  self endon("death");
  self endon("stop_path");
  common_scripts\utility::waitframe();
  var_2 = var_0 * 5 / 24;
  var_2 = var_2 - int(var_2);

  for(var_0 = 0; var_0 < var_1.size; var_0++)
    self setanimtime(var_1[var_0], var_2);
}

sardines_pieceswimpath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 1;

  self endon("death");
  self endon("stop_path");
  var_6 = undefined;

  if(isDefined(var_3))
    var_6 = var_3.origin;

  self.path = var_1;
  self.path_distance = 0;
  var_7 = common_scripts\_csplines::cspline_time(var_1);
  self.speed = var_7 / int(var_7 / var_2 + 0.5);

  while(self.path_distance < var_7 - self.speed / 2) {
    self.path_distance = self.path_distance + self.speed;

    if(self.path_distance > var_7)
      self.path_distance = var_7;

    var_8 = common_scripts\_csplines::cspline_getpointattime(var_1, self.path_distance);
    self.origin = var_8["pos"];
    var_9 = vectortoangles(var_8["vel"]);
    var_10 = var_9 - self.angles;
    var_10 = (angleclamp180(var_10[0]), angleclamp180(var_10[1]), 0);
    var_11 = [];
    var_11[0] = clamp(var_10[0], -1 * var_0.piece.maxturn, var_0.piece.maxturn);
    var_11[1] = clamp(var_10[1], -1 * var_0.piece.maxturn, var_0.piece.maxturn);
    self.angles = self.angles + (var_11[0], var_11[1], 0);

    if(isDefined(var_3)) {
      self.origin = self.origin + (var_3.origin - var_6);
      var_12 = (var_7 - self.path_distance) / (self.speed * 5);

      if(var_12 < 1) {
        var_13 = var_10[1] - var_11[1];
        var_14 = self.angles[1] + var_13 * (1 - var_12);
        self.angles = (angleclamp180(self.angles[0]) * var_12, var_14, 0);
      }
    }

    var_13 = angleclamp180(self.angles[1] - var_9[1]);
    var_15 = maps\interactive_models\_interactive_utility::clampandnormalize(var_13, 0, -150);
    self setanim(var_0.piece.anims["add_rotate_left"], var_15, 0.05);
    var_15 = maps\interactive_models\_interactive_utility::clampandnormalize(var_13, 0, 150);
    self setanim(var_0.piece.anims["add_rotate_right"], var_15, 0.05);
    maps\interactive_models\_interactive_utility::blendanimsbyspeed(self.speed * var_8["speed"] * var_5, var_0.line.anims, var_0.line.animspeeds, var_0.line.animlengths, 0.5);
    common_scripts\utility::waitframe();
  }

  if(isDefined(var_4))
    sardines_pieceswimpath(var_0, var_4, var_2, var_3, undefined, var_5);
  else
    self notify("path_complete");
}

sardines_ballwaitthenaddpiece(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_path");
  self waittill("path_complete");
  var_4 = sardines_ballfindemptyspot(var_0.ball.rings, var_1);
  self.ball_ring = var_4.ring;
  self.ball_i = var_4.i;
  var_5 = var_0.ball.rings[self.ball_ring].radius;
  var_6 = self.origin - var_1.origin;
  self.ball_offset = var_6[2] / 2;
  self.ball_offset = clamp(self.ball_offset, -50, 50);
  var_6 = (var_6[0], var_6[1], var_6[2] - self.ball_offset);
  var_7 = lengthsquared(var_6);
  var_8 = sqrt(var_7 + var_5 * var_5);
  var_9 = vectortoangles(var_1.origin - self.origin);
  var_10 = var_9[1];
  var_11 = var_5 * anglesToForward((0, var_10 - 90, 0));
  var_11 = var_11 + (var_1.origin + (0, 0, self.ball_offset));
  var_12 = (var_8 / self.speed - 1) * 1.2;
  var_10 = var_10 - (var_12 - 1) * var_1.rotationspeed;
  var_10 = var_10 - var_1.angles[1];
  var_1.rings[self.ball_ring][self.ball_i] = var_2;
  self.ball_angle = var_10;
  self.ball_inplace = 0;
  sardines_sortring(var_0.ball.rings[self.ball_ring], var_1, self.ball_ring);
  var_1.rings_isspread[self.ball_ring] = 0;
  var_13 = common_scripts\_csplines::cspline_getpointattime(self.path, self.path_distance);
  var_9 = (var_9[0], var_9[1] + var_1.rotationspeed, var_9[2]);
  var_14 = anglesToForward(var_9);
  var_14 = var_14 * (var_1.rotationspeed * 3.14159 / 180 * var_5);
  var_15 = common_scripts\_csplines::cspline_makepathtopoint(self.origin, var_11, var_13["vel"], var_14 / self.speed);
  common_scripts\_csplines::cspline_adjusttime(var_15, var_12 * self.speed);
  self setanimknob(var_0.line.anim_base);
  thread sardines_pieceswimpath(var_0, var_15, self.speed, var_1, undefined, var_3);
  var_16 = common_scripts\_csplines::cspline_length(var_15) / (self.speed * 20);
  self setanimknob(var_0.piece.anims["idle_loop"], 1, var_16 + 0.5);
  self setanim(var_0.piece.anims["add_bend_left"], 1, var_16 + 0.5);
  self waittill("path_complete");
  self.ball_inplace = 1;
  var_1.rings_isspread[self.ball_ring] = 0;

  if(self.ball_ring == 0 || self.ball_ring == 2) {
    thread sardines_piecesetmodels(var_0.fish.model[2]["grey1"], var_0.ball.numtags, var_0.piece.tagprefix, 3);
    thread maps\interactive_models\_interactive_utility::wait_then_fn(3, "sardines_pieceSetModels_starting", ::sardines_piecesetmodels, var_0.fish.model[2]["grey2"], var_0.ball.numtags, var_0.piece.tagprefix, 2);
  }

  sardines_balllinkpiece(var_1, self.ball_angle, var_5, self.ball_offset);
}

sardines_balllinkpiece(var_0, var_1, var_2, var_3) {
  var_4 = var_2 * sin(var_1);
  var_5 = -1 * var_2 * cos(var_1);
  self linkto(var_0, "tag_origin", (var_4, var_5, var_3), (0, var_1, 0));
}

sardines_detectpeople(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("damage");
  self endon(var_4);
  var_5 = (0, 0, -1 * var_0);
  var_6 = spawn("trigger_radius", self.origin + var_5, 0, var_0, var_0 * 2);
  thread maps\interactive_models\_interactive_utility::delete_on_notify(var_6, "death", "damage", var_4);
  var_7 = self.origin;
  var_8 = 1;
  var_9 = 1;

  while(var_8) {
    var_6 waittill("trigger", var_10);

    if(isDefined(var_10) && isPlayer(var_10)) {
      var_11 = var_3 * var_3;
      var_12 = 1;

      while((var_12 || !var_9) && var_8) {
        self.intruderorigin = var_10.origin + (0, 0, 64);
        var_13 = var_10.origin - self.origin;
        var_14 = length(var_13);

        if(var_14 < var_0) {
          var_16 = (var_0 - var_14) / (var_0 - var_1);
          var_17 = var_13 / var_14;
          self.origin = self.origin - var_16 * var_2 * var_17;
          var_6.origin = self.origin + var_5;
          var_9 = 0;

          if(distancesquared(self.origin, var_7) > var_11 || var_14 < var_1)
            var_8 = 0;

          common_scripts\utility::waitframe();
          continue;
        }

        var_12 = 0;
        self.intruderorigin = undefined;
        var_18 = distance(self.origin, var_7);

        if(var_18 > 1) {
          var_19 = (var_7 - self.origin) / var_18;
          self.origin = self.origin + var_19 * 0.5;
          var_6.origin = self.origin + var_5;
          common_scripts\utility::waitframe();
          var_18 = distance(self.origin, var_7);
        } else
          var_9 = 1;
      }

      continue;
    }

    common_scripts\utility::waitframe();
  }

  self notify(var_4);
}

sardines_ballfindemptyspot(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  while(var_3 < var_0.size && !var_5) {
    var_4 = 0;

    while(var_4 < var_0[var_3].numpieces && !var_5) {
      if(!isDefined(var_1.rings[var_3][var_4]))
        var_5 = 1;

      if(!var_5)
        var_4++;
    }

    if(!var_5)
      var_3++;
  }

  var_2.ring = var_3;
  var_2.i = var_4;
  return var_2;
}

sardines_sortring(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  for(var_5 = 0; var_5 < var_0.numpieces; var_5++) {
    if(isDefined(var_1.rings[var_2][var_5])) {
      var_6 = var_3.size;
      var_3[var_6] = var_1.rings[var_2][var_5];
      var_7 = var_1.pieces[var_1.rings[var_2][var_5]].ball_angle;
      var_1.pieces[var_3[var_6]].ball_angle = angleclamp(var_7);
      var_4[var_6] = var_1.pieces[var_3[var_6]].ball_angle;
    }
  }

  var_1.rings[var_2] = maps\interactive_models\_interactive_utility::array_sortbyarray(var_3, var_4);
}

sardines_spreadring(var_0, var_1, var_2) {
  var_3 = var_1.rings[var_2];

  if(var_3.size == 0)
    return 1;

  var_4 = var_0.ball.rings[var_2];
  var_5 = 1;
  var_6 = 2;
  var_7 = var_3.size - 1;
  var_8 = 360 / var_3.size - 5;
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];

  for(var_14 = 0; var_14 <= var_7; var_14++)
    var_13[var_14] = var_1.pieces[var_3[var_14]];

  for(var_14 = 0; var_14 <= var_7; var_14++) {
    var_9[var_14] = 0;
    var_10[var_14] = 0;
    var_11[var_14] = 0;
    var_15 = var_13[var_14].ball_angle;
    var_16 = var_13[maps\interactive_models\_interactive_utility::wrap(var_14 - 1, var_3.size)].ball_angle;
    var_17 = var_13[maps\interactive_models\_interactive_utility::wrap(var_14 - 2, var_3.size)].ball_angle;
    var_18 = var_13[maps\interactive_models\_interactive_utility::wrap(var_14 - 3, var_3.size)].ball_angle;

    if(var_14 == 0)
      var_16 = var_16 - 360;

    if(var_14 <= 1)
      var_17 = var_17 - 360;

    if(var_14 <= 2)
      var_18 = var_18 - 360;

    if(var_15 - var_16 < var_8) {
      var_9[var_14] = var_6 * (1.01 - (var_15 - var_16) / var_8);
      var_5 = 0;
    }

    if(var_15 - var_17 < 2 * var_8 && var_13[maps\interactive_models\_interactive_utility::wrap(var_14 - 1, var_3.size)].ball_inplace) {
      var_10[var_14] = var_10[var_14] + var_6 * (1.01 - (var_15 - var_17) / (var_8 * 2));

      if(var_15 - var_17 < 3 * var_8 && var_13[maps\interactive_models\_interactive_utility::wrap(var_14 - 1, var_3.size)].ball_inplace)
        var_11[var_14] = var_11[var_14] + var_6 * (1.01 - (var_15 - var_18) / (var_8 * 3));
    }

    if(var_13[var_14].ball_offset != var_4.offset) {
      if(var_13[var_14].ball_inplace) {
        var_19 = var_4.offset - var_13[var_14].ball_offset;
        var_19 = clamp(var_19, -1, 1);
        var_13[var_14].ball_offset = var_13[var_14].ball_offset + var_19;
        var_12[var_14] = 1;
      }

      var_20 = maps\interactive_models\_interactive_utility::clampandnormalize(var_13[var_14].ball_offset, 0, var_0.ball.ringvertoffset);
      var_13[var_14] setanimlimited(var_0.piece.anims["add_tilt_left"], var_20, 0.1, 1);
      var_20 = maps\interactive_models\_interactive_utility::clampandnormalize(var_13[var_14].ball_offset, 0, -1 * var_0.ball.ringvertoffset);
      var_13[var_14] setanimlimited(var_0.piece.anims["add_tilt_right"], var_20, 0.1, 1);
      var_5 = 0;
    }
  }

  if(!var_5) {
    var_21 = 0;

    for(var_14 = 0; var_14 <= var_7; var_14++) {
      if(var_13[var_14].ball_inplace) {
        var_22 = var_9[var_14] + var_10[var_14] + var_11[var_14];
        var_22 = var_22 - (var_9[maps\interactive_models\_interactive_utility::wrap(var_14 + 1, var_3.size)] + var_10[maps\interactive_models\_interactive_utility::wrap(var_14 + 2, var_3.size)] + var_11[maps\interactive_models\_interactive_utility::wrap(var_14 + 3, var_3.size)]);
        var_22 = clamp(var_22, -1 * var_6, var_6);

        if(var_22 != 0 || isDefined(var_12[var_14])) {
          var_13[var_14].ball_angle = var_13[var_14].ball_angle + var_22;

          if(var_13[var_14].ball_angle < 0 || var_13[var_14].ball_angle > 360)
            var_21 = 1;

          var_13[var_14] sardines_balllinkpiece(var_1, var_13[var_14].ball_angle, var_4.radius, var_13[var_14].ball_offset);
        }
      }
    }

    if(var_21)
      sardines_sortring(var_4, var_1, var_2);
  }

  return var_5;
}