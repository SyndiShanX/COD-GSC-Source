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
  var_00 = getent("clip128x128x128", "targetname");
  var_01 = spawn("script_model", (-820, -112, 508));
  var_01.angles = (0, 0, 0);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("player128x128x256", "targetname");
  var_03 = spawn("script_model", (-820, -112, 636));
  var_03.angles = (0, 0, 0);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("player32x32x8", "targetname");
  var_05 = spawn("script_model", (-540, 1062, 748));
  var_05.angles = (75, 0, 0);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = spawn("script_model", (-335.5, 508.5, 538));
  var_06.angles = (351, 135, 161);
  var_06 setModel("mp_proto_snow_chunk_01_patch");
  var_07 = spawn("script_model", (-372.5, 553.5, 538));
  var_07.angles = (351, 209, 161);
  var_07 setModel("mp_proto_snow_chunk_01_patch");
  var_08 = getent("player128x128x256", "targetname");
  var_09 = spawn("script_model", (-2019.5, -160.5, 1024));
  var_09.angles = (0, 56, 0);
  var_09 clonebrushmodeltoscriptmodel(var_08);
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

func_9284() {
  var_00 = 17;
  level.var_9285 = getEntArray("ice_drill", "targetname");
  foreach(var_03, var_02 in level.var_9285) {
    var_02 thread func_E6FD(var_00 * level.var_9285.size - var_03);
  }
}

func_E6FD(param_00) {
  level endon("stop drill");
  for(;;) {
    self rotatepitch(360, param_00, 0, 0);
    wait(param_00);
  }
}

spawn_oob_trigger() {
  wait(1);
  var_00 = spawn("trigger_radius", (0, -760, -1000), 0, 700, 400);
  var_00 hide();
  level.var_C7B3[level.var_C7B3.size] = var_00;
}

runmodespecifictriggers() {
  if(level.gametype == "ball" || level.gametype == "tdef") {
    wait(1);
    var_00 = spawn("trigger_radius", (2497, 734, 465), 0, 80, 20);
    var_00.var_336 = "uplink_nozone";
    var_00 hide();
    level.nozonetriggers[level.nozonetriggers.size] = var_00;
  }
}