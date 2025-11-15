/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_quarry\mp_quarry.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_quarry\mp_quarry_precache::main();
  scripts\mp\maps\mp_quarry\gen\mp_quarry_art::main();
  scripts\mp\maps\mp_quarry\mp_quarry_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_quarry");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_tessellationCutoffDistance", 2200);
  setdvar("r_umbraMinObjectContribution", 8);
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

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}

fix_collision() {
  var_00 = spawn("script_model", (0, -512, 224));
  var_00.angles = (0, 0, 0);
  var_00 setModel("mp_quarry_uplink_01");
  var_01 = spawn("script_model", (0, -512, 480));
  var_01.angles = (0, 0, 0);
  var_01 setModel("mp_quarry_uplink_01");
  var_02 = getent("player512x512x8", "targetname");
  var_03 = spawn("script_model", (-1664, 624, 816));
  var_03.angles = (90, 0, 0);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = spawn("script_model", (1280, 514, 516));
  var_04.angles = (0, 0, 0);
  var_04 setModel("mp_quarry_uplink_02");
  var_05 = spawn("script_model", (-2560, 0, 256));
  var_05.angles = (0, 0, 0);
  var_05 setModel("mp_quarry_vehicle_patch_01");
  var_06 = getent("player32x32x128", "targetname");
  var_07 = spawn("script_model", (713.5, 360, 504));
  var_07.angles = (-2, 0, 90);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = getent("player128x128x128", "targetname");
  var_09 = spawn("script_model", (2304, 184, 760));
  var_09.angles = (0, 0, 15);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_0A = getent("player128x128x128", "targetname");
  var_0B = spawn("script_model", (-888, 528, 712));
  var_0B.angles = (15, 45, 0);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = getent("player128x128x256", "targetname");
  var_0D = spawn("script_model", (812, -1790, 606));
  var_0D.angles = (0, 0, 0);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
  var_0E = getent("player128x128x256", "targetname");
  var_0F = spawn("script_model", (842, -1790, 606));
  var_0F.angles = (0, 0, 0);
  var_0F clonebrushmodeltoscriptmodel(var_0E);
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
  var_00 = [(-632, -1813, 320), (630, -1912, 320)];
  foreach(var_02 in var_00) {
    var_03 = spawn("trigger_radius", var_02, 0, 400, 200);
    level.outofboundstriggerpatches[level.outofboundstriggerpatches.size] = var_03;
  }

  level waittill("game_ended");
  foreach(var_03 in level.outofboundstriggerpatches) {
    if(isDefined(var_03)) {
      var_03 delete();
    }
  }
}

spawn_oob_trigger() {
  wait(1);
  var_00 = spawn("trigger_radius", (36, -844, 0), 0, 500, 200);
  var_00 hide();
  level.var_C7B3[level.var_C7B3.size] = var_00;
}