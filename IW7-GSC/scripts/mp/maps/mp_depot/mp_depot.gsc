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
  var_0 = getent("player32x32x256", "targetname");
  var_1 = spawn("script_model", (-185, 1153, 213));
  var_1.angles = (7.59943, 360, 90);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getent("clip128x128x8", "targetname");
  var_3 = spawn("script_model", (-1589, -326, 297));
  var_3.angles = (270, 180, 180);
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_4 = getent("player128x128x8", "targetname");
  var_5 = spawn("script_model", (-816, -1600, 256));
  var_5.angles = (0, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_4);
  var_6 = getent("clip128x128x8", "targetname");
  var_7 = spawn("script_model", (-1324, 1136, 100));
  var_7.angles = (0, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_6);
  var_8 = getent("player64x64x128", "targetname");
  var_9 = spawn("script_model", (523, 1943.5, 237));
  var_9.angles = (0, 0, 0);
  var_9 clonebrushmodeltoscriptmodel(var_8);
  var_8 = getent("player256x256x8", "targetname");
  var_9 = spawn("script_model", (-128, -1948, 440));
  var_9.angles = (0, 0, -86);
  var_9 clonebrushmodeltoscriptmodel(var_8);
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
  var_0 = getent("character_loc_broshot_a", "targetname");
  var_1 = getent("character_loc_broshot_b", "targetname");
  var_2 = getent("character_loc_broshot_c", "targetname");
  var_3 = getent("character_loc_broshot_d", "targetname");
  var_4 = getent("character_loc_broshot_e", "targetname");
  var_5 = getent("character_loc_broshot", "targetname");
  var_6 = var_0.origin;
  var_0.origin = (var_6[0], var_6[1], -1);
  var_6 = var_1.origin;
  var_1.origin = (var_6[0], var_6[1], -1);
  var_6 = var_2.origin;
  var_2.origin = (var_6[0], var_6[1], -7);
  var_6 = var_3.origin;
  var_3.origin = (var_6[0], var_6[1], -7);
  var_6 = var_4.origin;
  var_4.origin = (var_6[0], var_6[1], -3);
  var_6 = var_5.origin;
  var_5.origin = (var_6[0], var_6[1], -1);
}

setuptrain() {
  level endon("game_ended");
  var_0 = 500;
  var_1 = getent("trainCar_01", "targetname");
  var_1.var_BE1C = var_0;
  var_1.var_BE19 = getEntArray(var_1.target, "targetname");
  foreach(var_3 in var_1.var_BE19) {
    var_3 linkto(var_1);
    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX") {
      var_1.fx_loc = var_3;
    }
  }

  var_1.killtrigger = spawn("trigger_radius", (2984, -640, 180), 0, 48, 230);
  var_1.killtrigger enablelinkto();
  var_1.killtrigger linkto(var_1);
  var_1.var_9EAC = 0;
  var_1.initialstruct = scripts\engine\utility::getstruct("trainStartPos_01", "targetname");
  var_1 moveto(var_1.initialstruct.origin, 1, 0, 0);
  var_1 rotateto(var_1.initialstruct.angles, 1, 0, 0);
  var_1.car02 = getent("trainCar_02", "targetname");
  var_1.car02.var_BE1C = var_0;
  var_1.car02.var_BE19 = getEntArray(var_1.car02.target, "targetname");
  foreach(var_3 in var_1.car02.var_BE19) {
    var_3 linkto(var_1.car02);
    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX") {
      var_1.car02.fx_loc = var_3;
    }
  }

  var_1.car02.initialstruct = scripts\engine\utility::getstruct("trainStartPos_02", "targetname");
  var_1.car02 moveto(var_1.car02.initialstruct.origin, 1, 0, 0);
  var_1.car02 rotateto(var_1.car02.initialstruct.angles, 1, 0, 0);
  var_1.car02.unresolved_collision_func = ::traincollision;
  var_1.car03 = getent("trainCar_03", "targetname");
  var_1.car03.var_BE1C = var_0;
  var_1.car03.var_BE19 = getEntArray(var_1.car03.target, "targetname");
  foreach(var_3 in var_1.car03.var_BE19) {
    var_3 linkto(var_1.car03);
    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX") {
      var_1.car03.fx_loc = var_3;
    }
  }

  var_1.car03.initialstruct = scripts\engine\utility::getstruct("trainStartPos_03", "targetname");
  var_1.car03 moveto(var_1.car03.initialstruct.origin, 1, 0, 0);
  var_1.car03 rotateto(var_1.car03.initialstruct.angles, 1, 0, 0);
  var_9 = getent("trainCar_04", "targetname");
  var_9.var_BE1C = var_0;
  var_9.var_BE19 = getEntArray(var_9.target, "targetname");
  foreach(var_3 in var_9.var_BE19) {
    var_3 linkto(var_9);
    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX") {
      var_9.fx_loc = var_3;
    }
  }

  var_9.killtrigger = spawn("trigger_radius", (3560, -640, 180), 0, 48, 230);
  var_9.killtrigger enablelinkto();
  var_9.killtrigger linkto(var_9);
  var_9.var_9EAC = 0;
  var_9.initialstruct = scripts\engine\utility::getstruct("trainStartPos_01", "targetname");
  var_9 moveto(var_9.initialstruct.origin, 1, 0, 0);
  var_9 rotateto(var_9.initialstruct.angles, 1, 0, 0);
  var_9.car02 = getent("trainCar_05", "targetname");
  var_9.car02.var_BE1C = var_0;
  var_9.car02.var_BE19 = getEntArray(var_9.car02.target, "targetname");
  foreach(var_3 in var_9.car02.var_BE19) {
    var_3 linkto(var_9.car02);
    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX") {
      var_9.car02.fx_loc = var_3;
    }
  }

  var_9.car02.initialstruct = scripts\engine\utility::getstruct("trainStartPos_02", "targetname");
  var_9.car02 moveto(var_9.car02.initialstruct.origin, 1, 0, 0);
  var_9.car02 rotateto(var_9.car02.initialstruct.angles, 1, 0, 0);
  var_9.car02.unresolved_collision_func = ::traincollision;
  var_9.car03 = getent("trainCar_06", "targetname");
  var_9.car03.var_BE1C = var_0;
  var_9.car03.var_BE19 = getEntArray(var_9.car03.target, "targetname");
  foreach(var_3 in var_9.car03.var_BE19) {
    var_3 linkto(var_9.car03);
    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX") {
      var_9.car03.fx_loc = var_3;
    }
  }

  var_9.car03.initialstruct = scripts\engine\utility::getstruct("trainStartPos_03", "targetname");
  var_9.car03 moveto(var_9.car03.initialstruct.origin, 1, 0, 0);
  var_9.car03 rotateto(var_9.car03.initialstruct.angles, 1, 0, 0);
  thread trackmanger(var_1, var_9);
}

traincollision(var_0) {}

trainkilltrigger(var_0) {
  level endon("game_ended");
  var_0.var_9EAC = 1;
  while(var_0.var_9EAC) {
    var_0.killtrigger waittill("trigger", var_1);
    if(isDefined(var_1) && var_0.var_9EAC) {
      if(isplayer(var_1)) {
        var_1 suicide();
        continue;
      }

      if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
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
}

trackmanger(var_0, var_1) {
  level endon("game_ended");
  thread trainmovelogic(var_1);
  thread trainmovelogic(var_1.car02);
  thread trainmovelogic(var_1.car03);
  var_1 hide();
  var_1 notsolid();
  foreach(var_3 in var_1.var_BE19) {
    var_3 hide();
    var_3 notsolid();
  }

  var_1.car02 hide();
  var_1.car02 notsolid();
  foreach(var_3 in var_1.car02.var_BE19) {
    var_3 hide();
    var_3 notsolid();
  }

  var_1.car03 hide();
  var_1.car03 notsolid();
  foreach(var_3 in var_1.car03.var_BE19) {
    var_3 hide();
    var_3 notsolid();
  }

  for(;;) {
    var_1 waittill("approaching_station");
    thread trainkilltrigger(var_1);
    scripts\engine\utility::exploder(15);
    thread trainmovelogic(var_0);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(var_0.car02);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(var_0.car03);
    wait(3.5);
    scripts\engine\utility::exploder(10);
    wait(3.25);
    scripts\engine\utility::exploder(5);
    var_0 waittill("approaching_station");
    thread trainkilltrigger(var_0);
    scripts\engine\utility::exploder(15);
    thread trainmovelogic(var_1);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(var_1.car02);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(var_1.car03);
    wait(3.5);
    scripts\engine\utility::exploder(10);
    wait(3.25);
    scripts\engine\utility::exploder(5);
  }
}

trainmovelogic(var_0) {
  level endon("game_ended");
  if(isDefined(var_0.fx_loc)) {
    playFXOnTag(level._effect["train_move_FX"], var_0.fx_loc, "tag_origin");
  }

  var_0.var_4C09 = var_0.initialstruct;
  var_0.nextstruct = scripts\engine\utility::getstruct(var_0.initialstruct.target, "targetname");
  var_1 = 2;
  var_2 = 1.5;
  if(var_0.var_336 == "trainCar_01" || var_0.var_336 == "trainCar_04") {
    var_0 playsoundonmovingent("depot_train_car1_depart");
  } else if(var_0.var_336 == "trainCar_03" || var_0.var_336 == "trainCar_06") {
    var_0 playsoundonmovingent("depot_train_car3_depart");
  }

  var_0 moveto(var_0.nextstruct.origin, var_1, var_2, 0);
  var_0 rotateto(var_0.nextstruct.angles, var_1, var_2, 0);
  wait(var_1);
  var_0.var_4C09 = var_0.nextstruct;
  var_0.nextstruct = scripts\engine\utility::getstruct(var_0.var_4C09.target, "targetname");
  while(var_0.nextstruct.var_336 != var_0.initialstruct.var_336) {
    if(var_0.var_4C09.var_336 == "trainTeleport") {
      if(isDefined(var_0.fx_loc)) {
        stopFXOnTag(level._effect["train_move_FX"], var_0.fx_loc, "tag_origin");
      }

      var_0 hide();
      var_0 notsolid();
      foreach(var_4 in var_0.var_BE19) {
        var_4 hide();
        var_4 notsolid();
      }

      wait(1);
      var_0 moveto(var_0.nextstruct.origin, 1, 0, 0);
      var_0 rotateto(var_0.nextstruct.angles, 1, 0, 0);
      wait(1);
      var_0 show();
      var_0 solid();
      foreach(var_4 in var_0.var_BE19) {
        var_4 show();
        var_4 solid();
      }

      if(isDefined(var_0.fx_loc)) {
        playFXOnTag(level._effect["train_move_FX"], var_0.fx_loc, "tag_origin");
      }

      var_0 thread play_train_arrive_sfx(var_0);
      var_0.var_4C09 = var_0.nextstruct;
      var_0.nextstruct = scripts\engine\utility::getstruct(var_0.var_4C09.target, "targetname");
      continue;
    }

    if(var_0.var_4C09.var_336 == "nearStationStruct") {
      var_0 notify("approaching_station");
    }

    var_0.mymovetime = distspeedtotime(var_0.var_4C09, var_0.nextstruct, var_0.var_BE1C);
    var_0 moveto(var_0.nextstruct.origin, var_0.mymovetime, 0, 0);
    var_0 rotateto(var_0.nextstruct.angles, var_0.mymovetime, 0, 0);
    wait(var_0.mymovetime);
    var_0.var_4C09 = var_0.nextstruct;
    var_0.nextstruct = scripts\engine\utility::getstruct(var_0.var_4C09.target, "targetname");
  }

  var_0 moveto(var_0.nextstruct.origin, var_1, 0, var_2);
  var_0 rotateto(var_0.nextstruct.angles, var_1, 0, var_2);
  wait(var_1);
  if(isDefined(var_0.var_9EAC)) {
    var_0.var_9EAC = 0;
  }

  if(isDefined(var_0.fx_loc)) {
    stopFXOnTag(level._effect["train_move_FX"], var_0.fx_loc, "tag_origin");
  }

  var_0.var_4C09 = var_0.nextstruct;
  var_0.nextstruct = scripts\engine\utility::getstruct(var_0.var_4C09.target, "targetname");
}

play_train_arrive_sfx(var_0) {
  if(var_0.var_336 == "trainCar_01" || var_0.var_336 == "trainCar_04") {
    var_0 playLoopSound("depot_train_car1_arrive");
    wait(22);
    var_0 stoploopsound("depot_train_car1_arrive");
    return;
  }

  if(var_0.var_336 == "trainCar_03" || var_0.var_336 == "trainCar_06") {
    var_0 playLoopSound("depot_train_car3_arrive");
    wait(22);
    var_0 stoploopsound("depot_train_car3_arrive");
  }
}

distspeedtotime(var_0, var_1, var_2) {
  var_2 = 1 / var_2;
  return abs(distance(var_0.origin, var_1.origin) * var_2);
}