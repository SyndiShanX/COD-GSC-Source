/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_quarry\mp_quarry.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_quarry\mp_quarry_precache::main();
  scripts\mp\maps\mp_quarry\gen\mp_quarry_art::main();
  scripts\mp\maps\mp_quarry\mp_quarry_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_quarry");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_tessellationCutoffDistance", 2200);
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread scripts\mp\animation_suite::animationsuite();
  thread fix_collision();
  thread patchoutofboundstrigger();
  thread spawn_oob_trigger();
  level thread func_CDA4("mp_quarry_kotch");
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}

fix_collision() {
  var_0 = spawn("script_model", (0, -512, 224));
  var_0.angles = (0, 0, 0);
  var_0 setModel("mp_quarry_uplink_01");
  var_1 = spawn("script_model", (0, -512, 480));
  var_1.angles = (0, 0, 0);
  var_1 setModel("mp_quarry_uplink_01");
  var_2 = getent("player512x512x8", "targetname");
  var_3 = spawn("script_model", (-1664, 624, 816));
  var_3.angles = (90, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = spawn("script_model", (1280, 514, 516));
  var_4.angles = (0, 0, 0);
  var_4 setModel("mp_quarry_uplink_02");
  var_5 = spawn("script_model", (-2560, 0, 256));
  var_5.angles = (0, 0, 0);
  var_5 setModel("mp_quarry_vehicle_patch_01");
  var_6 = getent("player32x32x128", "targetname");
  var_7 = spawn("script_model", (713.5, 360, 504));
  var_7.angles = (-2, 0, 90);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("player128x128x128", "targetname");
  var_9 = spawn("script_model", (2304, 184, 760));
  var_9.angles = (0, 0, 15);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("player128x128x128", "targetname");
  var_11 = spawn("script_model", (-888, 528, 712));
  var_11.angles = (15, 45, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player128x128x256", "targetname");
  var_13 = spawn("script_model", (812, -1790, 606));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player128x128x256", "targetname");
  var_15 = spawn("script_model", (842, -1790, 606));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_10 = getent("player128x128x256", "targetname");
  var_11 = spawn("script_model", (-318, -2046, 514));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player32x32x256", "targetname");
  var_13 = spawn("script_model", (1446, -912, 482));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player32x32x256", "targetname");
  var_15 = spawn("script_model", (1446, -912, 738));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("player32x32x256", "targetname");
  var_17 = spawn("script_model", (-1294, -976, 506));
  var_17.angles = (0, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("player32x32x256", "targetname");
  var_19 = spawn("script_model", (-1294, -976, 762));
  var_19.angles = (0, 0, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_1A = spawn("script_model", (864, -8, 272));
  var_1A.angles = (90, 0, -90);
  var_1A setModel("ship_wall_panel_a_32_clean");
  var_1B = getent("player256x256x8", "targetname");
  var_1C = spawn("script_model", (721, 1092, 608));
  var_1C.angles = (271.7, 0, 0);
  var_1C clonebrushmodeltoscriptmodel(var_1B);
  var_1D = getent("player256x256x128", "targetname");
  var_1E = spawn("script_model", (-1622, 625, 549));
  var_1E.angles = (0, 315, 0.9);
  var_1E clonebrushmodeltoscriptmodel(var_1D);
  var_1F = getent("player128x128x128", "targetname");
  var_20 = spawn("script_model", (-1468, 562, 549));
  var_20.angles = (0, 315, 0.9);
  var_20 clonebrushmodeltoscriptmodel(var_1F);
  var_21 = getent("player64x64x256", "targetname");
  var_22 = spawn("script_model", (-1400, 528, 548));
  var_22.angles = (0, 0, 0);
  var_22 clonebrushmodeltoscriptmodel(var_21);
  var_23 = getent("player64x64x256", "targetname");
  var_24 = spawn("script_model", (-1400, 528, 804));
  var_24.angles = (0, 0, 0);
  var_24 clonebrushmodeltoscriptmodel(var_23);
}

patchoutofboundstrigger() {
  level.outofboundstriggerpatches = [];
  var_0 = [(-632, -1813, 320), (630, -1912, 320)];
  foreach(var_2 in var_0) {
    var_3 = spawn("trigger_radius", var_2, 0, 400, 200);
    level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_3;
  }

  level waittill("game_ended");
  foreach(var_3 in level.outofboundstriggerpatches) {
    if(isDefined(var_3)) {
      var_3 delete();
    }
  }
}

spawn_oob_trigger() {
  wait(1);
  var_0 = spawn("trigger_radius", (36, -844, 0), 0, 500, 200);
  var_0 hide();
  level.var_C7B3[level.var_C7B3.size] = var_0;
}