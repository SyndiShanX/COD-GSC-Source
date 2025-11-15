/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_divide\mp_divide.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_divide\mp_divide_precache::main();
  scripts\mp\maps\mp_divide\gen\mp_divide_art::main();
  scripts\mp\maps\mp_divide\mp_divide_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_divide");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraAccurateOcclusionThreshold", 400);
  setdvar("r_tessellationFactor", 40);
  setdvar("r_tessellationCutoffFalloff", 256);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread scripts\mp\animation_suite::animationsuite();
  thread func_E838();
  thread func_CDA4("mp_divide_screens");
  thread fix_collision();
  thread kill_triggers();
  thread fix_umbra();
  thread fix_broshot();
  thread spawn_oob_trigger();
}

fix_collision() {
  var_00 = getent("clip256x256x128", "targetname");
  var_01 = spawn("script_model", (-1696, 416, 1204));
  var_01.angles = (90, 270, 0);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = spawn("script_model", (-1696, 416, 1460));
  var_02.angles = (90, 270, 0);
  var_02 clonebrushmodeltoscriptmodel(var_00);
  var_03 = spawn("script_model", (-1696, 416, 1716));
  var_03.angles = (90, 270, 0);
  var_03 clonebrushmodeltoscriptmodel(var_00);
  var_04 = getent("clip256x256x128", "targetname");
  var_05 = spawn("script_model", (-1520, -464, 752));
  var_05.angles = (0, 0, 0);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = getent("clip256x256x128", "targetname");
  var_07 = spawn("script_model", (-1312, -464, 752));
  var_07.angles = (0, 0, 0);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = getent("clip64x64x256", "targetname");
  var_09 = spawn("script_model", (1346, 822, 872));
  var_09.angles = (0, 15, 0);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_0A = getent("clip64x64x256", "targetname");
  var_0B = spawn("script_model", (1346, 822, 1120));
  var_0B.angles = (0, 15, 0);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = spawn("script_model", (-384, -576, 704));
  var_0C.angles = (0, 0, 0);
  var_0C setModel("mp_divide_nosight_drill_02");
  var_0D = getent("player32x32x128", "targetname");
  var_0E = spawn("script_model", (-2672, 704, 800));
  var_0E.angles = (0, 0, 0);
  var_0E clonebrushmodeltoscriptmodel(var_0D);
  var_0F = getent("player32x32x128", "targetname");
  var_10 = spawn("script_model", (-2344, 904, 968));
  var_10.angles = (4, 0, 0);
  var_10 clonebrushmodeltoscriptmodel(var_0F);
  var_11 = getent("player128x128x8", "targetname");
  var_12 = spawn("script_model", (-1324, -10, 600));
  var_12.angles = (0, 0, 0);
  var_12 clonebrushmodeltoscriptmodel(var_11);
  var_13 = getent("player32x32x128", "targetname");
  var_14 = spawn("script_model", (-1252, -74, 592));
  var_14.angles = (270, 358, -88);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getent("player32x32x128", "targetname");
  var_16 = spawn("script_model", (-864, -884, 588));
  var_16.angles = (270, 330, -60);
  var_16 clonebrushmodeltoscriptmodel(var_15);
}

kill_triggers() {
  var_00 = spawn("trigger_radius", (2588, 732, 438), 0, 256, 128);
  var_00.fgetarg = 256;
  var_00.height = 128;
  var_00 thread kill_trigger_loop("script_vehicle");
  var_01 = spawn("trigger_radius", (-268, 884, 388), 0, 550, 128);
  var_01.fgetarg = 550;
  var_01.height = 128;
  var_01 thread kill_trigger_loop("script_vehicle");
}

kill_trigger_loop(param_00) {
  for(;;) {
    self waittill("trigger", var_01);
    if(isDefined(var_01) && isDefined(var_01.classname) && var_01.classname == param_00) {
      if(isDefined(var_01.streakname)) {
        if(var_01.streakname == "minijackal") {
          var_01 notify("minijackal_end");
          continue;
        }

        if(var_01.streakname == "venom") {
          var_01 notify("venom_end", var_01.origin);
        }
      }
    }
  }
}

fix_umbra() {
  var_00 = spawn("script_model", (-1880.5, 575.5, 762));
  var_00 setModel("building_stilt_support_leg_arm_cylinder_01_mp_divide_patch");
  var_00.angles = (180, -45, 90);
}

fix_broshot() {
  var_00 = getent("character_loc_broshot_a", "targetname");
  var_01 = getent("character_loc_broshot_b", "targetname");
  var_02 = getent("character_loc_broshot_c", "targetname");
  var_03 = getent("character_loc_broshot_d", "targetname");
  var_04 = var_00.origin;
  var_00.origin = (var_04[0], var_04[1], 505);
  var_04 = var_01.origin;
  var_01.origin = (var_04[0], var_04[1], 507);
  var_04 = var_02.origin;
  var_02.origin = (var_04[0], var_04[1], 498);
  var_04 = var_03.origin;
  var_03.origin = (var_04[0], var_04[1], 510);
}

func_E838() {}

mpdividecollisionfunc(param_00) {
  if(param_00.origin[2] - self.origin[2] > 30) {
    param_00 _meth_84DC((0, -40, 10), 200);
    return;
  }

  param_00 scripts\mp\movers::mover_suicide();
}

func_1F87() {
  level endon("game_ended");
  var_00 = getEntArray("animObj_container", "targetname");
  var_01 = getEntArray("animObj_barrier_entry", "targetname");
  var_02 = getEntArray("animObj_barrier_exit", "targetname");
  var_03 = getEntArray("door_interior_sliding", "targetname");
  var_04 = getEntArray("door_exterior_raising", "targetname");
  foreach(var_06 in var_00) {
    if(var_06.classname == "script_brushmodel") {
      var_06.unresolved_collision_notify_min = 10;
      var_06.unresolved_collision_kill = 1;
      var_06.unresolved_collision_func = ::mpdividecollisionfunc;
    }

    var_06 setnonstick(1);
    var_06 give_player_tickets(1);
  }

  var_00 func_110C1();
  var_01 func_110C1();
  var_02 func_110C1();
  var_08 = 10;
  var_09 = 27;
  for(;;) {
    func_E268(var_00);
    wait(0.1);
    thread func_1F6C(var_00, var_08);
    thread func_1F76(var_03, var_08);
    wait(var_08 - 7);
    thread func_1F71(var_01);
    wait(7);
    thread func_1F6D(var_00, var_09);
    wait(var_09 - 24);
    thread func_1F72(var_02);
    thread func_1F73(var_04, var_09);
    wait(24);
    func_1F6B(var_04);
    wait(3.5);
  }
}

func_110C1() {
  foreach(var_01 in self) {
    var_01.start = var_01.origin;
  }
}

func_E268(param_00) {
  foreach(var_02 in param_00) {
    var_02 movez(-200, 0.01);
  }

  wait(0.1);
  foreach(var_02 in param_00) {
    var_02 moveto((var_02.start[0], var_02.start[1], var_02.start[2]), 0.01);
  }
}

func_1F6C(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_03 movex(363, param_01);
  }
}

func_1F76(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_03 movey(144, 1.5, 0, 0.5);
  }

  wait(param_01);
  foreach(var_03 in param_00) {
    var_03 movey(-144, 2, 0, 0.5);
  }
}

func_1F71(param_00) {
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_noteworthy) && var_02.script_noteworthy == "barrier_top") {
      var_02 movez(36, 2, 0.5, 0.5);
      continue;
    }

    var_02 movez(56, 2, 0.5, 0.5);
  }

  wait(5);
  foreach(var_02 in param_00) {
    if(isDefined(var_02.script_noteworthy) && var_02.script_noteworthy == "barrier_top") {
      var_02 movez(-36, 2, 0.5, 0.5);
      continue;
    }

    var_02 movez(-56, 2, 0.5, 0.5);
  }
}

func_1F6D(param_00, param_01) {
  foreach(var_03 in param_00) {
    var_03 movey(1050, param_01);
  }
}

func_1F72(param_00) {
  foreach(var_02 in param_00) {
    var_02 movez(43, 2, 0.2, 0.2);
  }

  wait(8);
  foreach(var_02 in param_00) {
    var_02 movez(-43, 2, 0.2, 0.2);
  }
}

func_1F73(param_00, param_01) {
  wait(5);
  foreach(var_03 in param_00) {
    var_03 movez(84, 2.5, 0, 0.5);
  }
}

func_1F6B(param_00) {
  foreach(var_02 in param_00) {
    var_02 movez(-84, 3, 0, 0.5);
  }
}

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}

spawn_oob_trigger() {
  if(level.gametype == "sd" || level.gametype == "sr") {
    var_00 = spawn("trigger_radius", (340, 1120, 280), 0, 250, 300);
    var_00 hide();
    level.var_C7B3[level.var_C7B3.size] = var_00;
  }

  var_01 = spawn("trigger_radius", (-757, 825, 1040), 0, 100, 50);
  var_01 hide();
  level.var_C7B3[level.var_C7B3.size] = var_01;
}