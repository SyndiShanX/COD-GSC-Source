/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_dome_iw\mp_dome_iw.gsc
*****************************************************/

main() {
  scripts\mp\maps\mp_dome_iw\mp_dome_iw_precache::main();
  scripts\mp\maps\mp_dome_iw\gen\mp_dome_iw_art::main();
  scripts\mp\maps\mp_dome_iw\mp_dome_iw_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_dome_iw");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_sdfShadowPenumbra", 0.2);
  setdvar("r_umbraMinObjectContribution", 3);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread setup_vista_driving_cars();
  thread patchablecollision();
  level.modifiedspawnpoints["-108 -663 60"]["mp_sd_spawn_attacker"]["remove"] = 1;
}

patchablecollision() {
  var_00 = spawn("script_model", (1760, -368, -128));
  var_00.angles = (0, 0, 180);
  var_00 setModel("mp_desert_uplink_col_01");
  var_01 = spawn("script_model", (1776, -832, -128));
  var_01.angles = (0, 0, 180);
  var_01 setModel("mp_desert_uplink_col_01");
  var_02 = getent("player32x32x8", "targetname");
  var_03 = spawn("script_model", (1184, 124, 324));
  var_03.angles = (0, 0, -70);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = spawn("script_model", (896, 124, 324));
  var_04.angles = (0, 0, -70);
  var_04 clonebrushmodeltoscriptmodel(var_02);
  var_05 = getent("player256x256x256", "targetname");
  var_06 = spawn("script_model", (1120, -1872, 600));
  var_06.angles = (15, 0, 0);
  var_06 clonebrushmodeltoscriptmodel(var_05);
  var_07 = getent("clip512x512x8", "targetname");
  var_08 = spawn("script_model", (32, -2448, 480));
  var_08.angles = (0, 117, 90);
  var_08 clonebrushmodeltoscriptmodel(var_07);
  var_09 = spawn("script_model", (275, -2448, 480));
  var_09.angles = (0, -117, 90);
  var_09 clonebrushmodeltoscriptmodel(var_07);
  var_0A = spawn("script_model", (-200, -1992, 480));
  var_0A.angles = (0, 117, 90);
  var_0A clonebrushmodeltoscriptmodel(var_07);
  var_0B = getent("player512x512x8", "targetname");
  var_0C = spawn("script_model", (-200, -1992, 992));
  var_0C.angles = (0, 117, 90);
  var_0C clonebrushmodeltoscriptmodel(var_0B);
  var_0D = spawn("script_model", (275, -2448, 992));
  var_0D.angles = (0, -117, 90);
  var_0D clonebrushmodeltoscriptmodel(var_0B);
  var_0E = spawn("script_model", (32, -2448, 992));
  var_0E.angles = (0, 117, 90);
  var_0E clonebrushmodeltoscriptmodel(var_0B);
  var_0F = spawn("script_model", (-320, -1752, 992));
  var_0F.angles = (0, 117, 90);
  var_0F clonebrushmodeltoscriptmodel(var_0B);
  var_10 = getent("clip64x64x256", "targetname");
  var_11 = spawn("script_model", (152, -2588, 224));
  var_11.angles = (0, 45, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player256x256x8", "targetname");
  var_13 = spawn("script_model", (1923, -1664, 126.5));
  var_13.angles = (275, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip64x64x256", "targetname");
  var_15 = spawn("script_model", (-415, -1528, 32));
  var_15.angles = (5, 26.3, 6);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("player64x64x256", "targetname");
  var_17 = spawn("script_model", (640, 800, -32));
  var_17.angles = (0, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = spawn("script_model", (640, 800, -288));
  var_18.angles = (0, 0, 0);
  var_18 clonebrushmodeltoscriptmodel(var_16);
  var_19 = spawn("trigger_radius", (-64, 832, -784), 0, 512, 1024);
  var_19.fgetarg = 512;
  var_19.height = 1024;
  thread killtriggerloop(var_19);
  var_1A = getent("clip128x128x8", "targetname");
  var_1B = spawn("script_model", (691, -1583, 224));
  var_1B.angles = (0, 243, -90);
  var_1B clonebrushmodeltoscriptmodel(var_1A);
  var_1C = getent("player256x256x128", "targetname");
  var_1D = spawn("script_model", (876, -168, 416));
  var_1D.angles = (0, 90, 94);
  var_1D clonebrushmodeltoscriptmodel(var_1C);
  var_1E = getent("player64x64x256", "targetname");
  var_1F = spawn("script_model", (1976, -2592, -288));
  var_1F.angles = (0, 90, 0);
  var_1F clonebrushmodeltoscriptmodel(var_1E);
  var_20 = getent("player64x64x256", "targetname");
  var_21 = spawn("script_model", (1792, -2940, -288));
  var_21.angles = (0, 90, 0);
  var_21 clonebrushmodeltoscriptmodel(var_20);
  var_22 = getent("player64x64x8", "targetname");
  var_23 = spawn("script_model", (508, -2720, -128));
  var_23.angles = (0, 90, 0);
  var_23 clonebrushmodeltoscriptmodel(var_22);
  var_24 = getent("player64x64x8", "targetname");
  var_25 = spawn("script_model", (1344, -640, -35.5));
  var_25.angles = (0, 0, -90);
  var_25 clonebrushmodeltoscriptmodel(var_24);
  var_26 = getent("player64x64x8", "targetname");
  var_27 = spawn("script_model", (1344, -584, -35.5));
  var_27.angles = (0, 0, -90);
  var_27 clonebrushmodeltoscriptmodel(var_26);
}

killtriggerloop(param_00) {
  level endon("game_ended");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isDefined(var_01)) {
      if(isplayer(var_01)) {
        var_01 suicide();
        continue;
      }

      if(isDefined(var_01.classname) && var_01.classname == "script_vehicle") {
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
}

setup_vista_driving_cars() {
  var_00 = getEntArray("vista_car", "targetname");
  foreach(var_02 in var_00) {
    thread vista_car_drive(var_02);
  }
}

vista_car_drive(param_00) {
  level endon("game_ended");
  var_01 = scripts\engine\utility::getstruct(param_00.target, "targetname");
  var_02 = 0.002;
  for(;;) {
    var_03 = abs(distance(param_00.origin, var_01.origin) * var_02);
    param_00 moveto(var_01.origin, var_03, 0, 0);
    param_00 rotateto(var_01.angles, var_03, 0, 0);
    var_01 = scripts\engine\utility::getstruct(var_01.target, "targetname");
    wait(var_03);
  }
}