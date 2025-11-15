/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_depot\mp_depot.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_depot\mp_depot_precache::main();
  scripts\mp\maps\mp_depot\gen\mp_depot_art::main();
  scripts\mp\maps\mp_depot\mp_depot_fx::main();
  scripts\mp\load::main();
  level.var_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_depot");
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_umbraMinObjectContribution", 8);
  setdvar("r_tessellationFactor", 0);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._effect["train_move_FX"] = loadfx("vfx\iw7\levels\mp_depot\vfx_train_sparks.vfx");
  thread scripts\mp\animation_suite::animationsuite();
  thread setuptrain();
  thread fix_collision();
  fix_broshot();
  level.modifiedspawnpoints["-1160 -2944 0"]["mp_front_spawn_axis"]["no_alternates"] = 1;
  level.modifiedspawnpoints["-1240 -2944 0"]["mp_front_spawn_axis"]["no_alternates"] = 1;
  level.modifiedspawnpoints["-1048 -2840 0"]["mp_front_spawn_axis"]["origin"] = (-1048, -2840, 10);
  level.modifiedspawnpoints["-1288 -2840 0"]["mp_front_spawn_axis"]["origin"] = (-1288, -2840, 10);
  level.modifiedspawnpoints["-1160 -2944 0"]["mp_front_spawn_axis"]["origin"] = (-1160, -2944, 12);
  level.modifiedspawnpoints["-1240 -2944 0"]["mp_front_spawn_axis"]["origin"] = (-1240, -2944, 12);
}

fix_collision() {
  var_00 = getent("player32x32x256", "targetname");
  var_01 = spawn("script_model", (-185, 1153, 213));
  var_01.angles = (7.59943, 360, 90);
  var_01 clonebrushmodeltoscriptmodel(var_00);
  var_02 = getent("clip128x128x8", "targetname");
  var_03 = spawn("script_model", (-1589, -326, 297));
  var_03.angles = (270, 180, 180);
  var_03 clonebrushmodeltoscriptmodel(var_02);
  var_04 = getent("player128x128x8", "targetname");
  var_05 = spawn("script_model", (-816, -1600, 256));
  var_05.angles = (0, 0, 0);
  var_05 clonebrushmodeltoscriptmodel(var_04);
  var_06 = getent("clip128x128x8", "targetname");
  var_07 = spawn("script_model", (-1324, 1136, 100));
  var_07.angles = (0, 0, 0);
  var_07 clonebrushmodeltoscriptmodel(var_06);
  var_08 = getent("player64x64x128", "targetname");
  var_09 = spawn("script_model", (523, 1943.5, 237));
  var_09.angles = (0, 0, 0);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_08 = getent("player256x256x8", "targetname");
  var_09 = spawn("script_model", (-128, -1948, 440));
  var_09.angles = (0, 0, -86);
  var_09 clonebrushmodeltoscriptmodel(var_08);
  var_0A = getent("clip128x128x128", "targetname");
  var_0B = spawn("script_model", (-392, -3080, 312));
  var_0B.angles = (0, 0, 0);
  var_0B clonebrushmodeltoscriptmodel(var_0A);
  var_0C = getent("clip128x128x128", "targetname");
  var_0D = spawn("script_model", (1144, 48, 232));
  var_0D.angles = (0, 0, 0);
  var_0D clonebrushmodeltoscriptmodel(var_0C);
}

fix_broshot() {
  var_00 = getent("character_loc_broshot_a", "targetname");
  var_01 = getent("character_loc_broshot_b", "targetname");
  var_02 = getent("character_loc_broshot_c", "targetname");
  var_03 = getent("character_loc_broshot_d", "targetname");
  var_04 = getent("character_loc_broshot_e", "targetname");
  var_05 = getent("character_loc_broshot", "targetname");
  var_06 = var_00.origin;
  var_00.origin = (var_06[0], var_06[1], -1);
  var_06 = var_01.origin;
  var_01.origin = (var_06[0], var_06[1], -1);
  var_06 = var_02.origin;
  var_02.origin = (var_06[0], var_06[1], -7);
  var_06 = var_03.origin;
  var_03.origin = (var_06[0], var_06[1], -7);
  var_06 = var_04.origin;
  var_04.origin = (var_06[0], var_06[1], -3);
  var_06 = var_05.origin;
  var_05.origin = (var_06[0], var_06[1], -1);
}

setuptrain() {
  level endon("game_ended");
  var_00 = 500;
  var_01 = getent("trainCar_01", "targetname");
  var_01.var_BE1C = var_00;
  var_01.var_BE19 = getEntArray(var_01.target, "targetname");
  foreach(var_03 in var_01.var_BE19) {
    var_03 linkto(var_01);
    if(isDefined(var_03.script_label) && var_03.script_label == "trainFX") {
      var_01.fx_loc = var_03;
    }
  }

  var_01.killtrigger = spawn("trigger_radius", (2984, -640, 180), 0, 48, 230);
  var_01.killtrigger enablelinkto();
  var_01.killtrigger linkto(var_01);
  var_01.var_9EAC = 0;
  var_01.initialstruct = scripts\engine\utility::getstruct("trainStartPos_01", "targetname");
  var_01 moveto(var_01.initialstruct.origin, 1, 0, 0);
  var_01 rotateto(var_01.initialstruct.angles, 1, 0, 0);
  var_01.car02 = getent("trainCar_02", "targetname");
  var_01.car02.var_BE1C = var_00;
  var_01.car02.var_BE19 = getEntArray(var_01.car02.target, "targetname");
  foreach(var_03 in var_01.car02.var_BE19) {
    var_03 linkto(var_01.car02);
    if(isDefined(var_03.script_label) && var_03.script_label == "trainFX") {
      var_01.car02.fx_loc = var_03;
    }
  }

  var_01.car02.initialstruct = scripts\engine\utility::getstruct("trainStartPos_02", "targetname");
  var_01.car02 moveto(var_01.car02.initialstruct.origin, 1, 0, 0);
  var_01.car02 rotateto(var_01.car02.initialstruct.angles, 1, 0, 0);
  var_01.car02.unresolved_collision_func = ::traincollision;
  var_01.car03 = getent("trainCar_03", "targetname");
  var_01.car03.var_BE1C = var_00;
  var_01.car03.var_BE19 = getEntArray(var_01.car03.target, "targetname");
  foreach(var_03 in var_01.car03.var_BE19) {
    var_03 linkto(var_01.car03);
    if(isDefined(var_03.script_label) && var_03.script_label == "trainFX") {
      var_01.car03.fx_loc = var_03;
    }
  }

  var_01.car03.initialstruct = scripts\engine\utility::getstruct("trainStartPos_03", "targetname");
  var_01.car03 moveto(var_01.car03.initialstruct.origin, 1, 0, 0);
  var_01.car03 rotateto(var_01.car03.initialstruct.angles, 1, 0, 0);
  var_09 = getent("trainCar_04", "targetname");
  var_09.var_BE1C = var_00;
  var_09.var_BE19 = getEntArray(var_09.target, "targetname");
  foreach(var_03 in var_09.var_BE19) {
    var_03 linkto(var_09);
    if(isDefined(var_03.script_label) && var_03.script_label == "trainFX") {
      var_09.fx_loc = var_03;
    }
  }

  var_09.killtrigger = spawn("trigger_radius", (3560, -640, 180), 0, 48, 230);
  var_09.killtrigger enablelinkto();
  var_09.killtrigger linkto(var_09);
  var_09.var_9EAC = 0;
  var_09.initialstruct = scripts\engine\utility::getstruct("trainStartPos_01", "targetname");
  var_09 moveto(var_09.initialstruct.origin, 1, 0, 0);
  var_09 rotateto(var_09.initialstruct.angles, 1, 0, 0);
  var_09.car02 = getent("trainCar_05", "targetname");
  var_09.car02.var_BE1C = var_00;
  var_09.car02.var_BE19 = getEntArray(var_09.car02.target, "targetname");
  foreach(var_03 in var_09.car02.var_BE19) {
    var_03 linkto(var_09.car02);
    if(isDefined(var_03.script_label) && var_03.script_label == "trainFX") {
      var_09.car02.fx_loc = var_03;
    }
  }

  var_09.car02.initialstruct = scripts\engine\utility::getstruct("trainStartPos_02", "targetname");
  var_09.car02 moveto(var_09.car02.initialstruct.origin, 1, 0, 0);
  var_09.car02 rotateto(var_09.car02.initialstruct.angles, 1, 0, 0);
  var_09.car02.unresolved_collision_func = ::traincollision;
  var_09.car03 = getent("trainCar_06", "targetname");
  var_09.car03.var_BE1C = var_00;
  var_09.car03.var_BE19 = getEntArray(var_09.car03.target, "targetname");
  foreach(var_03 in var_09.car03.var_BE19) {
    var_03 linkto(var_09.car03);
    if(isDefined(var_03.script_label) && var_03.script_label == "trainFX") {
      var_09.car03.fx_loc = var_03;
    }
  }

  var_09.car03.initialstruct = scripts\engine\utility::getstruct("trainStartPos_03", "targetname");
  var_09.car03 moveto(var_09.car03.initialstruct.origin, 1, 0, 0);
  var_09.car03 rotateto(var_09.car03.initialstruct.angles, 1, 0, 0);
  thread trackmanger(var_01, var_09);
}

traincollision(param_00) {}

trainkilltrigger(param_00) {
  level endon("game_ended");
  param_00.var_9EAC = 1;
  while(param_00.var_9EAC) {
    param_00.killtrigger waittill("trigger", var_01);
    if(isDefined(var_01) && param_00.var_9EAC) {
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

trackmanger(param_00, param_01) {
  level endon("game_ended");
  thread trainmovelogic(param_01);
  thread trainmovelogic(param_01.car02);
  thread trainmovelogic(param_01.car03);
  param_01 hide();
  param_01 notsolid();
  foreach(var_03 in param_01.var_BE19) {
    var_03 hide();
    var_03 notsolid();
  }

  param_01.car02 hide();
  param_01.car02 notsolid();
  foreach(var_03 in param_01.car02.var_BE19) {
    var_03 hide();
    var_03 notsolid();
  }

  param_01.car03 hide();
  param_01.car03 notsolid();
  foreach(var_03 in param_01.car03.var_BE19) {
    var_03 hide();
    var_03 notsolid();
  }

  for(;;) {
    param_01 waittill("approaching_station");
    thread trainkilltrigger(param_01);
    scripts\engine\utility::exploder(15);
    thread trainmovelogic(param_00);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(param_00.car02);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(param_00.car03);
    wait(3.5);
    scripts\engine\utility::exploder(10);
    wait(3.25);
    scripts\engine\utility::exploder(5);
    param_00 waittill("approaching_station");
    thread trainkilltrigger(param_00);
    scripts\engine\utility::exploder(15);
    thread trainmovelogic(param_01);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(param_01.car02);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(param_01.car03);
    wait(3.5);
    scripts\engine\utility::exploder(10);
    wait(3.25);
    scripts\engine\utility::exploder(5);
  }
}

trainmovelogic(param_00) {
  level endon("game_ended");
  if(isDefined(param_00.fx_loc)) {
    playFXOnTag(level._effect["train_move_FX"], param_00.fx_loc, "tag_origin");
  }

  param_00.var_4C09 = param_00.initialstruct;
  param_00.nextstruct = scripts\engine\utility::getstruct(param_00.initialstruct.target, "targetname");
  var_01 = 2;
  var_02 = 1.5;
  if(param_00.var_336 == "trainCar_01" || param_00.var_336 == "trainCar_04") {
    param_00 playsoundonmovingent("depot_train_car1_depart");
  } else if(param_00.var_336 == "trainCar_03" || param_00.var_336 == "trainCar_06") {
    param_00 playsoundonmovingent("depot_train_car3_depart");
  }

  param_00 moveto(param_00.nextstruct.origin, var_01, var_02, 0);
  param_00 rotateto(param_00.nextstruct.angles, var_01, var_02, 0);
  wait(var_01);
  param_00.var_4C09 = param_00.nextstruct;
  param_00.nextstruct = scripts\engine\utility::getstruct(param_00.var_4C09.target, "targetname");
  while(param_00.nextstruct.var_336 != param_00.initialstruct.var_336) {
    if(param_00.var_4C09.var_336 == "trainTeleport") {
      if(isDefined(param_00.fx_loc)) {
        stopFXOnTag(level._effect["train_move_FX"], param_00.fx_loc, "tag_origin");
      }

      param_00 hide();
      param_00 notsolid();
      foreach(var_04 in param_00.var_BE19) {
        var_04 hide();
        var_04 notsolid();
      }

      wait(1);
      param_00 moveto(param_00.nextstruct.origin, 1, 0, 0);
      param_00 rotateto(param_00.nextstruct.angles, 1, 0, 0);
      wait(1);
      param_00 show();
      param_00 solid();
      foreach(var_04 in param_00.var_BE19) {
        var_04 show();
        var_04 solid();
      }

      if(isDefined(param_00.fx_loc)) {
        playFXOnTag(level._effect["train_move_FX"], param_00.fx_loc, "tag_origin");
      }

      param_00 thread play_train_arrive_sfx(param_00);
      param_00.var_4C09 = param_00.nextstruct;
      param_00.nextstruct = scripts\engine\utility::getstruct(param_00.var_4C09.target, "targetname");
      continue;
    }

    if(param_00.var_4C09.var_336 == "nearStationStruct") {
      param_00 notify("approaching_station");
    }

    param_00.mymovetime = distspeedtotime(param_00.var_4C09, param_00.nextstruct, param_00.var_BE1C);
    param_00 moveto(param_00.nextstruct.origin, param_00.mymovetime, 0, 0);
    param_00 rotateto(param_00.nextstruct.angles, param_00.mymovetime, 0, 0);
    wait(param_00.mymovetime);
    param_00.var_4C09 = param_00.nextstruct;
    param_00.nextstruct = scripts\engine\utility::getstruct(param_00.var_4C09.target, "targetname");
  }

  param_00 moveto(param_00.nextstruct.origin, var_01, 0, var_02);
  param_00 rotateto(param_00.nextstruct.angles, var_01, 0, var_02);
  wait(var_01);
  if(isDefined(param_00.var_9EAC)) {
    param_00.var_9EAC = 0;
  }

  if(isDefined(param_00.fx_loc)) {
    stopFXOnTag(level._effect["train_move_FX"], param_00.fx_loc, "tag_origin");
  }

  param_00.var_4C09 = param_00.nextstruct;
  param_00.nextstruct = scripts\engine\utility::getstruct(param_00.var_4C09.target, "targetname");
}

play_train_arrive_sfx(param_00) {
  if(param_00.var_336 == "trainCar_01" || param_00.var_336 == "trainCar_04") {
    param_00 playLoopSound("depot_train_car1_arrive");
    wait(22);
    param_00 stoploopsound("depot_train_car1_arrive");
    return;
  }

  if(param_00.var_336 == "trainCar_03" || param_00.var_336 == "trainCar_06") {
    param_00 playLoopSound("depot_train_car3_arrive");
    wait(22);
    param_00 stoploopsound("depot_train_car3_arrive");
  }
}

distspeedtotime(param_00, param_01, param_02) {
  param_02 = 1 / param_02;
  return abs(distance(param_00.origin, param_01.origin) * param_02);
}