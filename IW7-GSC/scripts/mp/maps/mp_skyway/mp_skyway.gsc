/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_skyway\mp_skyway.gsc
***************************************************/

main() {
  scripts\mp\maps\mp_skyway\mp_skyway_precache::main();
  scripts\mp\maps\mp_skyway\gen\mp_skyway_art::main();
  scripts\mp\maps\mp_skyway\mp_skyway_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_skyway");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_drawsun", 0);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_umbraAccurateOcclusionThreshold", 800);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread func_CDA4("mp_moon_screen_destinations_v2");
  thread func_5364();
  thread securitymetaldetectors();
  thread fix_collision();
  level.modifiedspawnpoints["1339 2045 0"]["mp_koth_spawn"]["remove"] = 1;
  scripts\mp\spawnlogic::addttlosoverride(589, 1102, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(589, 907, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(589, 908, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(589, 909, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(589, 217, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(589, 218, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(589, 219, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(177, 1102, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(177, 907, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(177, 908, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(177, 909, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(177, 217, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(177, 218, 1, 1);
  scripts\mp\spawnlogic::addttlosoverride(177, 219, 1, 1);
}

fix_collision() {
  var_00 = spawn("script_model", (1856, -736, -112));
  var_00.angles = (0, 0, 180);
  var_00 setModel("mp_desert_uplink_col_01");
  var_01 = getent("clip32x32x256", "targetname");
  var_02 = spawn("script_model", (256, -60, -32));
  var_02.angles = (0, 0, 90);
  var_02 clonebrushmodeltoscriptmodel(var_01);
  var_03 = getent("clip32x32x256", "targetname");
  var_04 = spawn("script_model", (368, -60, -32));
  var_04.angles = (0, 0, 90);
  var_04 clonebrushmodeltoscriptmodel(var_03);
  var_05 = getent("player256x256x8", "targetname");
  var_06 = spawn("script_model", (384, -192, 80));
  var_06.angles = (0, 60, 90);
  var_06 clonebrushmodeltoscriptmodel(var_05);
  var_07 = getent("player256x256x8", "targetname");
  var_08 = spawn("script_model", (256, -192, 80));
  var_08.angles = (0, -60, 90);
  var_08 clonebrushmodeltoscriptmodel(var_07);
  var_09 = getent("clip64x64x256", "targetname");
  var_0A = spawn("script_model", (284, 1216, -40));
  var_0A.angles = (0, 0, 90);
  var_0A clonebrushmodeltoscriptmodel(var_09);
  var_0B = getent("clip64x64x256", "targetname");
  var_0C = spawn("script_model", (348, 1216, -40));
  var_0C.angles = (0, 0, 90);
  var_0C clonebrushmodeltoscriptmodel(var_0B);
  var_0D = getent("clip64x64x128", "targetname");
  var_0E = spawn("script_model", (776, 3868, 276));
  var_0E.angles = (0, 0, 0);
  var_0E clonebrushmodeltoscriptmodel(var_0D);
  var_0F = spawn("script_model", (2520, 1392, -12));
  var_0F.angles = (0, 0, 0);
  var_0F setModel("mp_skyway_nosight_v1");
  var_10 = getent("clip128x128x256", "targetname");
  var_11 = spawn("script_model", (88, 2988, 252));
  var_11.angles = (0, 270, 90);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player128x128x8", "targetname");
  var_13 = spawn("script_model", (325, 688, -70));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player128x128x8", "targetname");
  var_15 = spawn("script_model", (328, 560, -70));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
}

func_CDA4(param_00) {
  wait(30);
  playcinematicforalllooping(param_00);
}

func_5364() {
  wait(5);
  var_00 = getEntArray("destructible_screens", "targetname");
  scripts\engine\utility::array_thread(var_00, ::func_5365);
}

func_5365() {
  self endon("death");
  var_00 = getglass(self.target);
  if(!isDefined(var_00)) {
    iprintlnbold("GLASS ID AT " + self.origin + "IS UNDEFINED");
    return;
  }

  while(!isglassdestroyed(var_00)) {
    wait(0.05);
  }

  if(!isDefined(self.var_ED83)) {
    playFX(scripts\engine\utility::getfx("vfx_moon_adscreen_sparks_runner"), self.origin);
  }

  self delete();
}

securitymetaldetectors() {
  level endon("game_ended");
  var_00 = getent("audio_metal_detector", "targetname");
  if(isDefined(var_00)) {
    for(;;) {
      var_00 waittill("trigger", var_01);
      playsoundatpos(var_01.origin + (0, 0, 80), "skyway_metal_detector_beep");
    }
  }
}