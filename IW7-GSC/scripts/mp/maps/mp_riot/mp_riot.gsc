/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_riot\mp_riot.gsc
***********************************************/

main() {
  scripts\mp\maps\mp_riot\mp_riot_precache::main();
  scripts\mp\maps\mp_riot\gen\mp_riot_art::main();
  scripts\mp\maps\mp_riot\mp_riot_fx::main();
  scripts\mp\load::main();
  scripts\mp\compass::setupminimap("compass_map_mp_riot");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraaccurateocclusionthreshold", 400);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  thread func_FA7D();
  thread func_CDA4("mp_riot_ads");
  thread managephysicsprops();
  thread fix_collision();
  thread move_sd_startspawns();
  level.modifiedspawnpoints["56 -2404 200"]["mp_front_spawn_axis"]["remove"] = 1;
  level.modifiedspawnpoints["1152 -1614 172"]["mp_front_spawn_axis"]["remove"] = 1;
  level.modifiedspawnpoints["929 1886 184"]["mp_front_spawn_allies"]["remove"] = 1;
  level.modifiedspawnpoints["-1028 -1156 20"]["mp_koth_spawn"]["remove"] = 1;
  level.kothextraprimaryspawnpoints = [];
  level.kothextraprimaryspawnpoints["23 -3134 130"] = ["1", "2", "5"];
  level.kothextraprimaryspawnpoints["-1794 -607 24"] = ["1", "4"];
  level.kothextraprimaryspawnpoints["-2021 -556 24"] = ["3"];
  level.kothextraprimaryspawnpoints["-1533 -348 24"] = ["4"];
  level.kothextraprimaryspawnpoints["-165 -634 184"] = ["3"];
  level.kothextraprimaryspawnpoints["-207 1210 184"] = ["4"];
}

fix_collision() {
  var_0 = getent("player32x32x8", "targetname");
  var_1 = spawn("script_model", (-1756, 1772, 372));
  var_1.angles = (300, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("player256x256x8", "targetname");
  var_3 = spawn("script_model", (84, -1790, 608));
  var_3.angles = (0, 0, -90);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("player256x256x256", "targetname");
  var_5 = spawn("script_model", (-104, 1184, 928));
  var_5.angles = (340, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("player32x32x8", "targetname");
  var_7 = spawn("script_model", (-1284, -714, 520));
  var_7.angles = (75, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("clip512x512x8", "targetname");
  var_9 = spawn("script_model", (-1662, 2688, 1184));
  var_9.angles = (270, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_10 = getent("clip32x32x8", "targetname");
  var_11 = spawn("script_model", (-1972, -1987, 200));
  var_11.angles = (0, 0, -90);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player32x32x256", "targetname");
  var_13 = spawn("script_model", (-1976, -1976, 640));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("player32x32x256", "targetname");
  var_15 = spawn("script_model", (-1976, -1976, 896));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_10 = getent("player32x32x256", "targetname");
  var_11 = spawn("script_model", (-1572, 2506, 630));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_10);
  var_12 = getent("player256x256x8", "targetname");
  var_13 = spawn("script_model", (614, 2176, 424));
  var_13.angles = (272, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_12);
  var_14 = getent("clip32x32x8", "targetname");
  var_15 = spawn("script_model", (-1076, 1404, 174));
  var_15.angles = (0, 0, 0);
  var_15 clonebrushmodeltoscriptmodel(var_14);
  var_16 = getent("clip32x32x8", "targetname");
  var_17 = spawn("script_model", (-1999, 1873, 174));
  var_17.angles = (0, 0, 0);
  var_17 clonebrushmodeltoscriptmodel(var_16);
  var_18 = getent("clip128x128x8", "targetname");
  var_19 = spawn("script_model", (48, -1000, 176));
  var_19.angles = (0, 0, 0);
  var_19 clonebrushmodeltoscriptmodel(var_18);
  var_1A = getent("clip128x128x8", "targetname");
  var_1B = spawn("script_model", (112, 1104, 174));
  var_1B.angles = (0, 0, 0);
  var_1B clonebrushmodeltoscriptmodel(var_1A);
}

func_FA7D() {
  level.var_114C3 = 600;
  level.var_114C4 = 1200;
  level.var_BF61 = -1;
  var_0 = getEntArray("watertank_invulnerable", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread func_12E48();
  }
}

func_12E48() {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    if(!issubstr(var_4, "BULLET")) {
      continue;
    }

    if(!func_37F6()) {
      continue;
    }

    var_5 = func_7D54(var_1, var_2, var_3);
    if(!isDefined(var_5)) {
      continue;
    }

    func_1C33();
    var_5 = vectortoangles(var_5);
    playFX(level._effect["vfx_imp_glass_water_fishtank_riot"], var_3, anglesToForward(var_5), anglestoup(var_5));
    playFX(level._effect["vfx_water_stream_fishtank_riot"], var_3, anglesToForward(var_5), anglestoup(var_5));
    playsoundatpos(var_3, "dst_aquarium_puncture");
  }
}

func_7D54(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = var_2 - var_3;
  var_5 = bulletTrace(var_3, var_3 + 1.5 * var_4, 0, var_0, 0);
  if(isDefined(var_5["normal"]) && isDefined(var_5["entity"]) && var_5["entity"] == self) {
    return var_5["normal"];
  }

  return undefined;
}

func_37F6() {
  if(gettime() < level.var_BF61) {
    return 0;
  }

  return 1;
}

func_1C33() {
  level.var_BF61 = gettime() + randomfloatrange(level.var_114C3, level.var_114C4);
}

func_CDA4(var_0) {
  wait(30);
  playcinematicforalllooping(var_0);
}

managephysicsprops() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_0);
    if(!var_0 ishost()) {
      thread triggerphysicsbump();
    }
  }
}

triggerphysicsbump() {
  var_0 = (-786.5, -2572, 40);
  var_1 = 200;
  wait(5);
  var_2 = physics_volumecreate(var_0, 1000);
  var_2 physics_volumesetasfocalforce(1, var_0, var_1);
  var_2 physics_volumeenable(1);
  var_2 physics_volumesetactivator(1);
  var_2.time = gettime();
  var_2.var_720E = var_1;
  var_2 physics_volumesetasfocalforce(1, var_0, var_1);
  wait(0.1);
  var_2 delete();
}

move_sd_startspawns() {
  if(level.gametype == "sd") {
    wait(0.1);
    var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_sd_spawn_defender");
    foreach(var_2 in var_0) {
      var_3 = anglestoright(var_2.angles);
      if(distance(var_2.origin, (-500, 3060, 176.124)) < 10) {
        var_2.origin = (-600, 2564, 176);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        continue;
      }

      if(distance(var_2.origin, (-596, 3064, 172.002)) < 10) {
        var_2.origin = (-686, 2564, 176);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin - var_3 * 45);
        continue;
      }

      if(distance(var_2.origin, (-700, 3064, 176.124)) < 10) {
        var_2.origin = (-790, 2564, 180);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin - var_3 * 45);
        continue;
      }

      if(distance(var_2.origin, (-500, 3140, 176.124)) < 10) {
        var_2.origin = (-600, 2644, 176);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin - var_3 * 45);
        continue;
      }

      if(distance(var_2.origin, (-596, 3144, 172.002)) < 10) {
        var_2.origin = (-686, 2644, 176);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin - var_3 * 45);
        continue;
      }

      if(distance(var_2.origin, (-700, 3144, 176.124)) < 10) {
        var_2.origin = (-790, 2644, 180);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin - var_3 * 45);
        continue;
      }

      if(distance(var_2.origin, (-500, 3220, 176.124)) < 10) {
        var_2.origin = (-600, 2724, 176);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin - var_3 * 45);
        continue;
      }

      if(distance(var_2.origin, (-596, 3224, 172.002)) < 10) {
        var_2.origin = (-686, 2724, 176);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin - var_3 * 45);
        continue;
      }

      if(distance(var_2.origin, (-700, 3224, 176.124)) < 10) {
        var_2.origin = (-790, 2724, 180);
        var_2.alternates = [];
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin + var_3 * 45);
        scripts\mp\spawnlogic::func_17A7(var_2, var_2.origin - var_3 * 45);
      }
    }
  }
}