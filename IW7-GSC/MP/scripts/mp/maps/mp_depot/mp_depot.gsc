/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_depot\mp_depot.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_depot\mp_depot_precache::main();
  scripts\mp\maps\mp_depot\gen\mp_depot_art::main();
  scripts\mp\maps\mp_depot\mp_depot_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_depot");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_tessellationFactor", 0);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level._effect["train_move_FX"] = loadfx("vfx/iw7/levels/mp_depot/vfx_train_sparks.vfx");
  thread scripts\mp\animation_suite::animationsuite();
  thread setuptrain();
}

setuptrain() {
  level endon("game_ended");
  var_0 = 500;
  var_1 = getEnt("trainCar_01", "targetname");
  var_1._id_BE1C = var_0;
  var_1._id_BE19 = getEntArray(var_1.target, "targetname");

  foreach(var_3 in var_1._id_BE19) {
    var_3 linkTo(var_1);

    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX")
      var_1.fx_loc = var_3;
  }

  var_1.initialstruct = scripts\engine\utility::getStruct("trainStartPos_01", "targetname");
  var_1 moveTo(var_1.initialstruct.origin, 1, 0, 0);
  var_1 rotateTo(var_1.initialstruct.angles, 1, 0, 0);
  var_1.car02 = getEnt("trainCar_02", "targetname");
  var_1.car02._id_BE1C = var_0;
  var_1.car02._id_BE19 = getEntArray(var_1.car02.target, "targetname");

  foreach(var_3 in var_1.car02._id_BE19) {
    var_3 linkTo(var_1.car02);

    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX")
      var_1.car02.fx_loc = var_3;
  }

  var_1.car02.initialstruct = scripts\engine\utility::getStruct("trainStartPos_02", "targetname");
  var_1.car02 moveTo(var_1.car02.initialstruct.origin, 1, 0, 0);
  var_1.car02 rotateTo(var_1.car02.initialstruct.angles, 1, 0, 0);
  var_1.car02.unresolved_collision_func = ::traincollision;
  var_1.car03 = getEnt("trainCar_03", "targetname");
  var_1.car03._id_BE1C = var_0;
  var_1.car03._id_BE19 = getEntArray(var_1.car03.target, "targetname");

  foreach(var_3 in var_1.car03._id_BE19) {
    var_3 linkTo(var_1.car03);

    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX")
      var_1.car03.fx_loc = var_3;
  }

  var_1.car03.initialstruct = scripts\engine\utility::getStruct("trainStartPos_03", "targetname");
  var_1.car03 moveTo(var_1.car03.initialstruct.origin, 1, 0, 0);
  var_1.car03 rotateTo(var_1.car03.initialstruct.angles, 1, 0, 0);
  var_9 = getEnt("trainCar_04", "targetname");
  var_9._id_BE1C = var_0;
  var_9._id_BE19 = getEntArray(var_9.target, "targetname");

  foreach(var_3 in var_9._id_BE19) {
    var_3 linkTo(var_9);

    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX")
      var_9.fx_loc = var_3;
  }

  var_9.initialstruct = scripts\engine\utility::getStruct("trainStartPos_01", "targetname");
  var_9 moveTo(var_9.initialstruct.origin, 1, 0, 0);
  var_9 rotateTo(var_9.initialstruct.angles, 1, 0, 0);
  var_9.car02 = getEnt("trainCar_05", "targetname");
  var_9.car02._id_BE1C = var_0;
  var_9.car02._id_BE19 = getEntArray(var_9.car02.target, "targetname");

  foreach(var_3 in var_9.car02._id_BE19) {
    var_3 linkTo(var_9.car02);

    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX")
      var_9.car02.fx_loc = var_3;
  }

  var_9.car02.initialstruct = scripts\engine\utility::getStruct("trainStartPos_02", "targetname");
  var_9.car02 moveTo(var_9.car02.initialstruct.origin, 1, 0, 0);
  var_9.car02 rotateTo(var_9.car02.initialstruct.angles, 1, 0, 0);
  var_9.car02.unresolved_collision_func = ::traincollision;
  var_9.car03 = getEnt("trainCar_06", "targetname");
  var_9.car03._id_BE1C = var_0;
  var_9.car03._id_BE19 = getEntArray(var_9.car03.target, "targetname");

  foreach(var_3 in var_9.car03._id_BE19) {
    var_3 linkTo(var_9.car03);

    if(isDefined(var_3.script_label) && var_3.script_label == "trainFX")
      var_9.car03.fx_loc = var_3;
  }

  var_9.car03.initialstruct = scripts\engine\utility::getStruct("trainStartPos_03", "targetname");
  var_9.car03 moveTo(var_9.car03.initialstruct.origin, 1, 0, 0);
  var_9.car03 rotateTo(var_9.car03.initialstruct.angles, 1, 0, 0);
  thread trackmanger(var_1, var_9);
}

traincollision(var_0) {
  return;
}

trackmanger(var_0, var_1) {
  level endon("game_ended");
  thread trainmovelogic(var_1);
  thread trainmovelogic(var_1.car02);
  thread trainmovelogic(var_1.car03);
  var_1 hide();
  var_1 notsolid();

  foreach(var_3 in var_1._id_BE19) {
    var_3 hide();
    var_3 notsolid();
  }

  var_1.car02 hide();
  var_1.car02 notsolid();

  foreach(var_3 in var_1.car02._id_BE19) {
    var_3 hide();
    var_3 notsolid();
  }

  var_1.car03 hide();
  var_1.car03 notsolid();

  foreach(var_3 in var_1.car03._id_BE19) {
    var_3 hide();
    var_3 notsolid();
  }

  for(;;) {
    var_1 waittill("approaching_station");
    scripts\engine\utility::exploder(15);
    thread trainmovelogic(var_0);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(var_0.car02);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(var_0.car03);
    wait 3.5;
    scripts\engine\utility::exploder(10);
    wait 3.25;
    scripts\engine\utility::exploder(5);
    var_0 waittill("approaching_station");
    scripts\engine\utility::exploder(15);
    thread trainmovelogic(var_1);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(var_1.car02);
    scripts\engine\utility::waitframe();
    thread trainmovelogic(var_1.car03);
    wait 3.5;
    scripts\engine\utility::exploder(10);
    wait 3.25;
    scripts\engine\utility::exploder(5);
  }
}

trainmovelogic(var_0) {
  level endon("game_ended");

  if(isDefined(var_0.fx_loc))
    playFXOnTag(level._effect["train_move_FX"], var_0.fx_loc, "tag_origin");

  var_0._id_4C09 = var_0.initialstruct;
  var_0.nextstruct = scripts\engine\utility::getStruct(var_0.initialstruct.target, "targetname");
  var_1 = 2;
  var_2 = 1.5;

  if(var_0.targetname == "trainCar_01" || var_0.targetname == "trainCar_04")
    var_0 playsoundonmovingent("depot_train_car1_depart");
  else if(var_0.targetname == "trainCar_03" || var_0.targetname == "trainCar_06")
    var_0 playsoundonmovingent("depot_train_car3_depart");

  var_0 moveTo(var_0.nextstruct.origin, var_1, var_2, 0);
  var_0 rotateTo(var_0.nextstruct.angles, var_1, var_2, 0);
  wait(var_1);
  var_0._id_4C09 = var_0.nextstruct;
  var_0.nextstruct = scripts\engine\utility::getStruct(var_0._id_4C09.target, "targetname");

  while(var_0.nextstruct.targetname != var_0.initialstruct.targetname) {
    if(var_0._id_4C09.targetname == "trainTeleport") {
      if(isDefined(var_0.fx_loc))
        stopFXOnTag(level._effect["train_move_FX"], var_0.fx_loc, "tag_origin");

      var_0 hide();
      var_0 notsolid();

      foreach(var_4 in var_0._id_BE19) {
        var_4 hide();
        var_4 notsolid();
      }

      wait 1;
      var_0 moveTo(var_0.nextstruct.origin, 1, 0, 0);
      var_0 rotateTo(var_0.nextstruct.angles, 1, 0, 0);
      wait 1;
      var_0 show();
      var_0 solid();

      foreach(var_4 in var_0._id_BE19) {
        var_4 show();
        var_4 solid();
      }

      if(isDefined(var_0.fx_loc))
        playFXOnTag(level._effect["train_move_FX"], var_0.fx_loc, "tag_origin");

      var_0 thread play_train_arrive_sfx(var_0);
      var_0._id_4C09 = var_0.nextstruct;
      var_0.nextstruct = scripts\engine\utility::getStruct(var_0._id_4C09.target, "targetname");
      continue;
    }

    if(var_0._id_4C09.targetname == "nearStationStruct")
      var_0 notify("approaching_station");

    var_0.mymovetime = distspeedtotime(var_0._id_4C09, var_0.nextstruct, var_0._id_BE1C);
    var_0 moveTo(var_0.nextstruct.origin, var_0.mymovetime, 0, 0);
    var_0 rotateTo(var_0.nextstruct.angles, var_0.mymovetime, 0, 0);
    wait(var_0.mymovetime);
    var_0._id_4C09 = var_0.nextstruct;
    var_0.nextstruct = scripts\engine\utility::getStruct(var_0._id_4C09.target, "targetname");
  }

  var_0 moveTo(var_0.nextstruct.origin, var_1, 0, var_2);
  var_0 rotateTo(var_0.nextstruct.angles, var_1, 0, var_2);
  wait(var_1);

  if(isDefined(var_0.fx_loc))
    stopFXOnTag(level._effect["train_move_FX"], var_0.fx_loc, "tag_origin");

  var_0._id_4C09 = var_0.nextstruct;
  var_0.nextstruct = scripts\engine\utility::getStruct(var_0._id_4C09.target, "targetname");
}

play_train_arrive_sfx(var_0) {
  if(var_0.targetname == "trainCar_01" || var_0.targetname == "trainCar_04") {
    var_0 playLoopSound("depot_train_car1_arrive");
    wait 22;
    var_0 stoploopsound("depot_train_car1_arrive");
  } else if(var_0.targetname == "trainCar_03" || var_0.targetname == "trainCar_06") {
    var_0 playLoopSound("depot_train_car3_arrive");
    wait 22;
    var_0 stoploopsound("depot_train_car3_arrive");
  }
}

distspeedtotime(var_0, var_1, var_2) {
  var_2 = 1.0 / var_2;
  return abs(distance(var_0.origin, var_1.origin) * var_2);
}