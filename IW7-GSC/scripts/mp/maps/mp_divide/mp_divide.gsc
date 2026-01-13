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
  var_0 = getent("clip256x256x128", "targetname");
  var_1 = spawn("script_model", (-1696, 416, 1204));
  var_1.angles = (90, 270, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = spawn("script_model", (-1696, 416, 1460));
  var_2.angles = (90, 270, 0);
  var_2 clonebrushmodeltoscriptmodel(var_0);
  var_3 = spawn("script_model", (-1696, 416, 1716));
  var_3.angles = (90, 270, 0);
  var_3 clonebrushmodeltoscriptmodel(var_0);
  var_4 = getent("clip256x256x128", "targetname");
  var_5 = spawn("script_model", (-1520, -464, 752));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip256x256x128", "targetname");
  var_7 = spawn("script_model", (-1312, -464, 752));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip64x64x256", "targetname");
  var_9 = spawn("script_model", (1346, 822, 872));
  var_9.angles = (0, 15, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
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
  var_0 = spawn("trigger_radius", (2588, 732, 438), 0, 256, 128);
  var_0.fgetarg = 256;
  var_0.height = 128;
  var_0 thread kill_trigger_loop("script_vehicle");
  var_1 = spawn("trigger_radius", (-268, 884, 388), 0, 550, 128);
  var_1.fgetarg = 550;
  var_1.height = 128;
  var_1 thread kill_trigger_loop("script_vehicle");
}

kill_trigger_loop(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == var_0) {
      if(isDefined(var_1.streakname)) {
        if(var_1.streakname == "minijackal") {
          var_1 notify("minijackal_end");
          continue;
        }

        if(var_1.streakname == "venom") {
          var_1 notify("venom_end", var_1.origin);
        }
      }
    }
  }
}

fix_umbra() {
  var_0 = spawn("script_model", (-1880.5, 575.5, 762));
  var_0 setModel("building_stilt_support_leg_arm_cylinder_01_mp_divide_patch");
  var_0.angles = (180, -45, 90);
}

fix_broshot() {
  var_0 = getent("character_loc_broshot_a", "targetname");
  var_1 = getent("character_loc_broshot_b", "targetname");
  var_2 = getent("character_loc_broshot_c", "targetname");
  var_3 = getent("character_loc_broshot_d", "targetname");
  var_4 = var_0.origin;
  var_0.origin = (var_4[0], var_4[1], 505);
  var_4 = var_1.origin;
  var_1.origin = (var_4[0], var_4[1], 507);
  var_4 = var_2.origin;
  var_2.origin = (var_4[0], var_4[1], 498);
  var_4 = var_3.origin;
  var_3.origin = (var_4[0], var_4[1], 510);
}

func_E838() {}

mpdividecollisionfunc(var_0) {
  if(var_0.origin[2] - self.origin[2] > 30) {
    var_0 _meth_84DC((0, -40, 10), 200);
    return;
  }

  var_0 scripts\mp\movers::mover_suicide();
}

func_1F87() {
  level endon("game_ended");
  var_0 = getEntArray("animObj_container", "targetname");
  var_1 = getEntArray("animObj_barrier_entry", "targetname");
  var_2 = getEntArray("animObj_barrier_exit", "targetname");
  var_3 = getEntArray("door_interior_sliding", "targetname");
  var_4 = getEntArray("door_exterior_raising", "targetname");
  foreach(var_6 in var_0) {
    if(var_6.classname == "script_brushmodel") {
      var_6.unresolved_collision_notify_min = 10;
      var_6.unresolved_collision_kill = 1;
      var_6.unresolved_collision_func = ::mpdividecollisionfunc;
    }

    var_6 setnonstick(1);
    var_6 give_player_tickets(1);
  }

  var_0 func_110C1();
  var_1 func_110C1();
  var_2 func_110C1();
  var_8 = 10;
  var_9 = 27;
  for(;;) {
    func_E268(var_0);
    wait(0.1);
    thread func_1F6C(var_0, var_8);
    thread func_1F76(var_3, var_8);
    wait(var_8 - 7);
    thread func_1F71(var_1);
    wait(7);
    thread func_1F6D(var_0, var_9);
    wait(var_9 - 24);
    thread func_1F72(var_2);
    thread func_1F73(var_4, var_9);
    wait(24);
    func_1F6B(var_4);
    wait(3.5);
  }
}

func_110C1() {
  foreach(var_1 in self) {
    var_1.start = var_1.origin;
  }
}

func_E268(var_0) {
  foreach(var_2 in var_0) {
    var_2 movez(-200, 0.01);
  }

  wait(0.1);
  foreach(var_2 in var_0) {
    var_2 moveto((var_2.start[0], var_2.start[1], var_2.start[2]), 0.01);
  }
}

func_1F6C(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 movex(363, var_1);
  }
}

func_1F76(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 movey(144, 1.5, 0, 0.5);
  }

  wait(var_1);
  foreach(var_3 in var_0) {
    var_3 movey(-144, 2, 0, 0.5);
  }
}

func_1F71(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "barrier_top") {
      var_2 movez(36, 2, 0.5, 0.5);
      continue;
    }

    var_2 movez(56, 2, 0.5, 0.5);
  }

  wait(5);
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "barrier_top") {
      var_2 movez(-36, 2, 0.5, 0.5);
      continue;
    }

    var_2 movez(-56, 2, 0.5, 0.5);
  }
}

func_1F6D(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_3 movey(1050, var_1);
  }
}

func_1F72(var_0) {
  foreach(var_2 in var_0) {
    var_2 movez(43, 2, 0.2, 0.2);
  }

  wait(8);
  foreach(var_2 in var_0) {
    var_2 movez(-43, 2, 0.2, 0.2);
  }
}

func_1F73(var_0, var_1) {
  wait(5);
  foreach(var_3 in var_0) {
    var_3 movez(84, 2.5, 0, 0.5);
  }
}

func_1F6B(var_0) {
  foreach(var_2 in var_0) {
    var_2 movez(-84, 3, 0, 0.5);
  }
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}

spawn_oob_trigger() {
  if(level.gametype == "sd" || level.gametype == "sr") {
    var_0 = spawn("trigger_radius", (340, 1120, 280), 0, 250, 300);
    var_0 hide();
    level.var_C7B3[level.var_C7B3.size] = var_0;
  }

  var_1 = spawn("trigger_radius", (-757, 825, 1040), 0, 100, 50);
  var_1 hide();
  level.var_C7B3[level.var_C7B3.size] = var_1;
}