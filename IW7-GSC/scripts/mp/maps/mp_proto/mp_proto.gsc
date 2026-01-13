/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_proto\mp_proto.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_proto\mp_proto_precache::main();
  scripts\mp\maps\mp_proto\gen\mp_proto_art::main();
  scripts\mp\maps\mp_proto\mp_proto_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_proto");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_drawsun", 0);
  setdvar("r_tessellationFactor", 0);
  setdvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread func_9284();
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
  thread spawn_oob_trigger();
  thread runmodespecifictriggers();
}

fix_collision() {
  var_0 = getent("clip128x128x128", "targetname");
  var_1 = spawn("script_model", (-820, -112, 508));
  var_1.angles = (0, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("player128x128x256", "targetname");
  var_3 = spawn("script_model", (-820, -112, 636));
  var_3.angles = (0, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("player32x32x8", "targetname");
  var_5 = spawn("script_model", (-540, 1062, 748));
  var_5.angles = (75, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = spawn("script_model", (-335.5, 508.5, 538));
  var_6.angles = (351, 135, 161);
  var_6 setModel("mp_proto_snow_chunk_01_patch");
  var_7 = spawn("script_model", (-372.5, 553.5, 538));
  var_7.angles = (351, 209, 161);
  var_7 setModel("mp_proto_snow_chunk_01_patch");
  var_8 = getent("player128x128x256", "targetname");
  var_9 = spawn("script_model", (-2019.5, -160.5, 1024));
  var_9.angles = (0, 56, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_0A = getent("player64x64x128", "targetname");
  var_0B = spawn("script_model", (1528, 940, 1040));
  var_0B.angles = (285, 270, 90);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = getent("player512x512x8", "targetname");
  var_0D = spawn("script_model", (1741, -1116, 640));
  var_0D.angles = (90, 0, 0);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
  var_0E = getent("clip512x512x8", "targetname");
  var_0F = spawn("script_model", (1584, 1400, 220));
  var_0F.angles = (0, 0, -82);
  var_0F clonebrushmodeltoscriptmodel(var_0E);
  var_10 = spawn("trigger_radius", (-2576, 608, 448), 0, 256, 256);
  var_10.fgetarg = 256;
  var_10.height = 256;
  var_10 thread kill_trigger_loop("script_vehicle");
  var_11 = spawn("script_model", (-2008, -188, 676));
  var_11.angles = (359, 264, 104);
  var_11 setModel("mp_desert_uplink_col_01");
  var_12 = spawn("script_model", (-2008, -90, 670));
  var_12.angles = (0, 270, 106);
  var_12 setModel("mp_desert_uplink_col_01");
  var_13 = getent("clip32x32x128", "targetname");
  var_14 = spawn("script_model", (1856, 88, 480));
  var_14.angles = (90, 0, 0);
  var_14 clonebrushmodeltoscriptmodel(var_13);
  var_15 = getent("clip32x32x128", "targetname");
  var_16 = spawn("script_model", (1984, 88, 480));
  var_16.angles = (90, 0, 0);
  var_16 clonebrushmodeltoscriptmodel(var_15);
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

func_9284() {
  var_0 = 17;
  level.var_9285 = getEntArray("ice_drill", "targetname");
  foreach(var_3, var_2 in level.var_9285) {
    var_2 thread func_E6FD(var_0 * level.var_9285.size - var_3);
  }
}

func_E6FD(var_0) {
  level endon("stop drill");
  for(;;) {
    self rotatepitch(360, var_0, 0, 0);
    wait(var_0);
  }
}

spawn_oob_trigger() {
  wait(1);
  var_0 = spawn("trigger_radius", (0, -760, -1000), 0, 700, 400);
  var_0 hide();
  level.var_C7B3[level.var_C7B3.size] = var_0;
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    wait(1);
    var_0 = spawn("trigger_radius", (2497, 734, 465), 0, 80, 20);
    var_0.var_336 = "uplink_nozone";
    var_0 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_0;
  }
}