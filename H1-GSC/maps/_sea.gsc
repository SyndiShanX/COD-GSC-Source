/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_sea.gsc
********************************/

main() {
  level._sea_scale = 1;
  level.sea_model = getent("sea", "targetname");
  level._sea_org = spawn("script_origin", level.sea_model.origin);
  level._sea_org.offset = level.sea_model.origin * -1;
  level._sea_org.sway = "sway2";
  level._sea_link = spawn("script_origin", level.sea_model.origin);
  level._sea_link.offset = level._sea_org.offset;
  level.sea_model linkto(level._sea_link);
  level.sea_foam = getent("sea_foam", "targetname");

  if(isdefined(level.sea_foam)) {
    level.sea_foam linkto(level._sea_link);
    level.sea_foam hide();
  }

  level.sea_black = getent("sea_black", "targetname");

  if(isdefined(level.sea_black))
    level.sea_black linkto(level._sea_link);

  common_scripts\utility::flag_init("_sea_waves");
  common_scripts\utility::flag_init("_sea_viewbob");
  common_scripts\utility::flag_init("_sea_bob");
  common_scripts\utility::flag_set("_sea_bob");
  common_scripts\utility::flag_set("_sea_viewbob");
  var_0 = getentarray("boat_sway", "script_noteworthy");

  if(isdefined(var_0))
    common_scripts\utility::array_thread(var_0, ::sea_objectbob, level._sea_org);

  thread sea_logic();
  return;
}

#using_animtree("script_model");

sea_animate() {
  self.animname = "sea";
  self useanimtree(#animtree);
  self setanim( % cargoship_water);
}

sea_logic() {
  wait 0.05;
  var_0 = getmapsundirection();
  setsundirection(var_0);
  level.lite_settings = vectortoangles(var_0);
  level.new_lite_settings = level.lite_settings;
  level._sea_org thread sea_bob();
  level._sea_org thread sea_litebob();
  level._sea_org thread sea_waves();
  level._sea_org thread sea_viewbob();
}

sea_objectbob_precalc(var_0, var_1) {
  self.waittime = randomfloatrange(0.5, 1);

  if(isdefined(self.setscale))
    self.scale = self.setscale;
  else
    self.scale = randomfloatrange(2, 3);

  var_2 = 0;
  var_3 = 0;

  switch (var_1) {
    case "sway1":
      var_2 = self.sway1max;
      break;
    case "sway2":
      var_2 = self.sway2max;
      break;
  }

  if(self.axial) {
    var_4 = var_0.rotation[0] * self.pratio * self.scale + var_0.rotation[2] * self.rratio * self.scale;

    if(var_2 < abs(var_4)) {
      if(var_4 < 1)
        var_3 = var_2 * -1;
      else
        var_3 = var_2;
    } else
      var_3 = var_4;

    self.ang = (self.angles[0], self.angles[1], var_3);
  } else
    self.ang = var_0.rotation * self.scale;
}

sea_objectbob(var_0) {
  if(isdefined(self.targetname)) {
    var_1 = getentarray(self.targetname, "target");

    for (var_2 = 0; var_2 < var_1.size; var_2++)
      var_1[var_2] linkto(self);
  }

  var_3 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_4 = var_3[0].origin;
  var_5 = undefined;
  var_6 = spawn("script_origin", (0, 0, 0));
  var_6.axial = 0;

  if(isdefined(var_3[1])) {
    var_5 = var_3[1].origin;
    var_6.axial = 1;
  } else {
    var_7 = anglestoup(var_3[0].angles);
    var_7 = var_7 * 10;
    var_5 = var_4 + var_7;
  }

  var_6.origin = var_4;
  var_6.angles = vectortoangles(var_5 - var_4);
  var_6.pratio = 1;
  var_6.rratio = 1;
  var_6.sway1max = 100;
  var_6.sway2max = 100;
  var_6.setscale = undefined;

  if(isdefined(var_3[0].script_parameters)) {
    var_8 = strtok(var_3[0].script_parameters, ":;, ");

    for (var_2 = 0; var_2 < var_8.size; var_2++) {
      switch (var_8[var_2]) {
        case "axial":
          var_6.axial = 1;
          break;
        case "sway1":
          var_2++;
          var_6.sway1max = int(var_8[var_2]);
          break;
        case "sway2":
          var_2++;
          var_6.sway2max = int(var_8[var_2]);
          break;
        case "setscale":
          var_2++;

          if(var_8[var_2] == "randomrange") {
            var_2++;
            var_9 = int(var_8[var_2]);
            var_2++;
            var_10 = int(var_8[var_2]);
            var_6.setscale = randomfloatrange(var_9, var_10);
          } else
            var_6.setscale = int(var_8[var_2]);

          break;
      }
    }
  }

  if(var_6.axial) {
    var_11 = undefined;
    var_12 = (0, 360, 0);

    if(!isdefined(var_3[1]))
      var_11 = var_3[0].angles;
    else
      var_11 = vectortoangles(var_5 - var_4);

    var_6.rratio = vectordot(anglestoright(var_11), anglestoright(var_12));
    var_6.pratio = vectordot(anglestoright(var_11), anglestoforward(var_12));
  }

  self.link = var_6;
  self notify("got_link");

  for (var_2 = 0; var_2 < var_3.size; var_2++)
    var_3[var_2] thread sea_objectbob_findparent(var_6, var_0);

  wait 0.05;
  self linkto(var_6);

  if(isdefined(self.script_parameters)) {}

  thread sea_objectbob_logic(var_0, var_6);
}

sea_objectbob_logic(var_0, var_1) {
  for (;;) {
    if(var_0.sway == "sway2")
      var_0 waittill("sway1");

    var_1 sea_objectbob_precalc(var_0, "sway1");
    var_1 notify("precalcdone1");

    if(!isdefined(var_1.parent))
      wait(var_1.waittime);

    var_1 rotateto(var_1.ang, var_0.time, var_0.time * 0.5, var_0.time * 0.5);

    if(var_0.sway == "sway1")
      var_0 waittill("sway2");

    var_1 sea_objectbob_precalc(var_0, "sway2");
    var_1 notify("precalcdone2");

    if(!isdefined(var_1.parent))
      wait(var_1.waittime);

    var_1 rotateto(var_1.ang, var_0.time, var_0.time * 0.5, var_0.time * 0.5);
  }
}

sea_objectbob_follow(var_0) {
  for (;;) {
    self moveto(var_0.origin, 0.1);
    wait 0.1;
  }
}

sea_objectbob_findparent(var_0, var_1) {
  if(!isdefined(self.target)) {
    return;
  }
  var_0.parent = getent(self.target, "targetname");

  if(!isdefined(var_0.parent.link))
    var_0.parent waittill("got_link");

  var_2 = var_0.parent.link;
  var_3 = var_0.origin;
  var_4 = spawn("script_origin", var_2.origin);
  var_4.angles = var_2.angles;
  var_5 = spawn("script_origin", var_0.origin);
  var_5.angles = var_0.angles;
  var_5 linkto(var_4);
  var_0 thread sea_objectbob_follow(var_5);

  for (;;) {
    var_2 waittill("precalcdone1");
    wait(var_2.waittime - 0.05);
    var_4 rotateto(var_2.ang, var_1.time, var_1.time * 0.5, var_1.time * 0.5);
    var_2 waittill("precalcdone2");
    wait(var_2.waittime - 0.05);
    var_4 rotateto(var_2.ang, var_1.time, var_1.time * 0.5, var_1.time * 0.5);
  }
}

sea_bob() {
  self endon("manual_override");
  common_scripts\utility::flag_wait("_sea_bob");
  thread sea_bob_reset();
  wait 0.05;

  for (;;) {
    var_0 = 0;
    var_1 = 0;
    var_2 = randomfloatrange(2, 4) * level._sea_scale;
    self.time = randomfloatrange(3, 4);
    self.rotation = (var_1, var_0, var_2);
    self.sway = "sway1";
    self notify("sway1");

    if(common_scripts\utility::flag("_sea_bob"))
      level._sea_link rotateto(self.rotation, self.time, self.time * 0.5, self.time * 0.5);

    self rotateto(self.rotation, self.time, self.time * 0.5, self.time * 0.5);
    level.heli.heightsea = 110;
    soundscripts\_snd::snd_message("aud_start_sway1");
    wait(self.time);
    self.rotation = self.rotation * -1;
    self.sway = "sway2";
    self notify("sway2");

    if(common_scripts\utility::flag("_sea_bob"))
      level._sea_link rotateto(self.rotation, self.time, self.time * 0.5, self.time * 0.5);

    self rotateto(self.rotation, self.time, self.time * 0.5, self.time * 0.5);
    level.heli.heightsea = 180;
    soundscripts\_snd::snd_message("aud_start_sway2");
    wait(self.time);
  }
}

sea_bob_reset_loop() {
  self endon("manual_override");
  common_scripts\utility::flag_wait("_sea_bob");
  thread sea_bob_reset();
}

sea_bob_reset() {
  self endon("manual_override");
  level waittill("_sea_bob");
  thread sea_bob_reset_loop();
  level endon("_sea_bob");
  var_0 = 1.5;
  var_1 = (0, 0, 0);
  level._sea_link rotateto(var_1, var_0, var_0 * 0.5, var_0 * 0.5);
  wait(var_0);
  wait 0.05;
  level.new_lite_settings = level.lite_settings;
  level._sea_link.angles = (0, 0, 0);
}

sea_waves() {
  var_0 = sea_waves_setup();

  if(!isdefined(var_0)) {
    return;
  }
  self.oldwaves = [];

  for (;;) {
    common_scripts\utility::flag_wait("_sea_waves");
    self waittill("sway1");
    thread sea_waves_fx(var_0, "right");
    common_scripts\utility::flag_wait("_sea_waves");
    self waittill("sway2");
    thread sea_waves_fx(var_0, "left");
  }
}

sea_waves_fx(var_0, var_1) {
  wait(self.time * 0.5);
  var_2 = 2;
  var_3 = common_scripts\utility::random(sea_closestwavearray(var_0[var_1], var_2));

  if(!isdefined(self.oldwaves[var_1]))
    self.oldwaves[var_1] = var_3;

  while (self.oldwaves[var_1] == var_3) {
    wait 0.05;
    var_3 = common_scripts\utility::random(sea_closestwavearray(var_0[var_1], var_2));
  }

  self.oldwaves[var_1] = var_3;
  var_3 thread sea_waves_fx2();
}

sea_waves_fx2() {
  wait(randomfloat(0.15));
  thread common_scripts\utility::play_sound_in_space("elm_wave_crash_ext", self.origin);
  common_scripts\_exploder::exploder(self.exploder.v["exploder"]);
}

sea_closestwavearray(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++)
    var_0[var_3]._sea_dist = distancesquared(var_0[var_3].origin, level.player.origin);

  for (var_3 = 0; var_3 < var_0.size; var_3++)
    var_2 = sea_closestwavelogic(var_2, var_0[var_3]);

  var_4 = [];

  for (var_3 = 0; var_3 < var_1; var_3++)
    var_4[var_3] = var_2[var_3];

  return var_4;
}

sea_closestwavelogic(var_0, var_1) {
  if(!var_0.size) {
    var_0[0] = var_1;
    return var_0;
  }

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2]._sea_dist > var_1._sea_dist) {
      var_0 = common_scripts\utility::array_insert(var_0, var_1, var_2);
      break;
    }
  }

  if(var_2 == var_0.size)
    var_0 = common_scripts\utility::array_add(var_0, var_1);

  return var_0;
}

sea_waves_setup() {
  var_0 = common_scripts\utility::getstructarray("wave_fx", "targetname");
  var_1 = common_scripts\utility::getstruct("wave_fx_center", "targetname");

  if(!var_0.size)
    return undefined;

  var_2 = anglestoforward(var_1.angles);
  var_3 = anglestoright(var_1.angles);
  var_4 = [];
  var_4["right"] = [];
  var_4["left"] = [];

  for (var_5 = 0; var_5 < var_0.size; var_5++) {
    var_0[var_5].forward = anglestoforward(var_0[var_5].angles);
    var_0[var_5].up = anglestoup(var_0[var_5].angles);
    var_0[var_5].right = anglestoright(var_0[var_5].angles);
  }

  for (var_5 = 0; var_5 < var_0.size; var_5++) {
    if(vectordot(var_0[var_5].forward, var_3) > 0) {
      var_4["right"][var_4["right"].size] = var_0[var_5];
      continue;
    }

    var_4["left"][var_4["left"].size] = var_0[var_5];
  }

  var_6 = level._waves_exploders;

  for (var_5 = 0; var_5 < var_6.size; var_5++)
    var_6[var_5].origin = var_6[var_5].v["origin"];

  for (var_5 = 0; var_5 < var_4["right"].size; var_5++) {
    var_7 = common_scripts\utility::getclosest(var_4["right"][var_5].origin, var_6, 64);
    var_6 = common_scripts\utility::array_remove(var_6, var_7);
    var_4["right"][var_5].exploder = var_7;
  }

  for (var_5 = 0; var_5 < var_4["left"].size; var_5++) {
    var_7 = common_scripts\utility::getclosest(var_4["left"][var_5].origin, var_6, 64);
    var_6 = common_scripts\utility::array_remove(var_6, var_7);
    var_4["left"][var_5].exploder = var_7;
  }

  return var_4;
}

sea_litebob() {
  for (;;) {
    wait 0.2;
    var_0 = self.angles * 2;
    var_0 = (var_0[0], var_0[1], var_0[2]);
    var_1 = level.new_lite_settings;
    level.new_lite_settings = combineangles(var_0, level.lite_settings);
    var_2 = level.new_lite_settings;
    var_3 = anglestoforward(var_1);
    var_4 = anglestoforward(var_2);

    if(common_scripts\utility::flag("final_sun_direction")) {
      setsundirection((0.6, 0.5, 0.7));
      return;
    } else
      lerpsundirection(var_3, var_4, 0.2);
  }
}

sea_viewbob() {
  for (;;) {
    common_scripts\utility::flag_wait("_sea_viewbob");
    level.player playersetgroundreferenceent(self);

    if(common_scripts\utility::flag("_sea_viewbob"))
      level waittill("_sea_viewbob");

    level.player playersetgroundreferenceent(undefined);
  }
}