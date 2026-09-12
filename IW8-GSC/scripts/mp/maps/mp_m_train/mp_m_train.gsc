/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_train\mp_m_train.gsc
*****************************************************/

function main() {
  scripts\mp\maps\mp_m_train\mp_m_train_precache::main();
  scripts\mp\maps\mp_m_train\gen\mp_m_train_art::main();
  scripts\mp\maps\mp_m_train\mp_m_train_fx::main();
  scripts\mp\maps\mp_m_train\mp_m_train_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_train", "codcaster_compass_map_mp_m_train");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_1327B();
  level.ref_138B3 = 3000;
  thread ref_1323C();
  level.music_style = "england";
}

function monitor_dropped_phones() {
  for(;;) {
    level waittill("eggStoneBroke");
    scripts\engine\utility::stop_exploder("teddydrop");
    ref_13DC1();
  }
}

function ref_13DC1() {
  thread molotov_register_trigger();
  wait 3;
  scripts\engine\utility::exploder("teddydrop");
  wait 1;
  earthquake(0.75, 5, (8224, 2064, 0), 50000);

  foreach(var_1 in level.players) {
    thread ref_1329E(var_1);
    var_1 playlocalsound("train_ee_teddy_wave");
  }
}

function molotov_register_trigger() {
  setmusicstate("mus_train_easteregg");
  wait 1;
  var_0 = spawn("script_model", (11723, 5944, 243));
  var_0 playSound("train_ee_teddy_incoming");
  wait 3;
  var_0 playSound("train_ee_teddy_land");
  wait 8;
  var_0 playSound("train_ee_teddy_yell");
  wait 2;
  var_1 = spawn("script_model", (-10356, 2146, 9476));
  var_2 = spawn("script_model", (-10563, -2114, 9476));
  waitframe();
  var_1 playsoundonmovingent("train_ee_a10_approach");
  var_2 playsoundonmovingent("train_ee_a10_approach");
  wait 4;
  var_1 moveTo((11001, 5520, 9476), 6);
  var_2 moveTo((8875, -2051, 9476), 6);
  wait 4;
  var_0 playSound("train_ee_teddy_death");
  wait 12;
  var_1 delete();
  var_2 delete();
  var_0 delete();
}

function ref_1329E(var_0) {
  var_0 playrumbleonpositionforclient("artillery_rumble", var_0.origin);
  wait 0.1;
  var_0 playrumbleonpositionforclient("artillery_rumble", var_0.origin);
  wait 0.2;
  var_0 playrumbleonpositionforclient("artillery_rumble", var_0.origin);
  wait 0.2;
  var_0 playrumbleonpositionforclient("artillery_rumble", var_0.origin);
  wait 0.2;
  var_0 playrumbleonpositionforclient("artillery_rumble", var_0.origin);
  wait 0.2;
  var_0 playrumbleonpositionforclient("artillery_rumble", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("tank_rumble", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("tank_rumble", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("tank_rumble", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("tank_rumble", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("tank_rumble", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("tank_rumble", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("tank_rumble", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("slide_loop", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("slide_loop", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("slide_loop", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("slide_loop", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("slide_loop", var_0.origin);
}

function ref_1323C() {
  level.molotov_watch_cleanup_pool_internal = 1;
  waitframe();
  level.monitor_dropmenu = getEnt("eggStoneKey", "targetname");
  thread ref_13275(level.monitor_dropmenu);
  level.monitor_balloon_marker_throw = getEnt("eggStone1", "targetname");
  thread ref_13275(level.monitor_balloon_marker_throw);
  level.monitor_balloons = getEnt("eggStone2", "targetname");
  thread ref_13275(level.monitor_balloons);
  level.monitor_bush_trig = getEnt("eggStone3", "targetname");
  thread ref_13275(level.monitor_bush_trig);
  level.monitor_death_thread = getEnt("eggStone4", "targetname");
  thread ref_13275(level.monitor_death_thread);
  level.monitor_dropkit_marker_throw = getEnt("eggStone5", "targetname");
  thread ref_13275(level.monitor_dropkit_marker_throw);
  level.helihint_gotopad[0] = randomintrange(1, 10);
  ref_1313F(level.monitor_balloon_marker_throw, level.helihint_gotopad[0]);
  level.helihint_gotopad[1] = level.helihint_gotopad[0];

  while(level.helihint_gotopad[1] == level.helihint_gotopad[0]) {
    level.helihint_gotopad[1] = randomintrange(1, 10);
  }

  ref_1313F(level.monitor_balloons, level.helihint_gotopad[1]);
  level.helihint_gotopad[2] = level.helihint_gotopad[0];

  while(level.helihint_gotopad[2] == level.helihint_gotopad[0] || level.helihint_gotopad[2] == level.helihint_gotopad[1]) {
    level.helihint_gotopad[2] = randomintrange(1, 10);
  }

  ref_1313F(level.monitor_bush_trig, level.helihint_gotopad[2]);
  level.helihint_gotopad[3] = level.helihint_gotopad[0];

  while(level.helihint_gotopad[3] == level.helihint_gotopad[0] || level.helihint_gotopad[3] == level.helihint_gotopad[1] || level.helihint_gotopad[3] == level.helihint_gotopad[2]) {
    level.helihint_gotopad[3] = randomintrange(1, 10);
  }

  ref_1313F(level.monitor_death_thread, level.helihint_gotopad[3]);
  level.helihint_gotopad[4] = level.helihint_gotopad[0];

  while(level.helihint_gotopad[4] == level.helihint_gotopad[0] || level.helihint_gotopad[4] == level.helihint_gotopad[1] || level.helihint_gotopad[4] == level.helihint_gotopad[2] || level.helihint_gotopad[4] == level.helihint_gotopad[3]) {
    level.helihint_gotopad[4] = randomintrange(1, 10);
  }

  ref_1313F(level.monitor_dropkit_marker_throw, level.helihint_gotopad[4]);
  level.insertingarmorplate = 0;
}

function ref_13275(var_0) {
  level endon("game_ended");
  var_0 setCanDamage(1);
  var_0.health = level.ref_138B3;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 show();
  var_1.fxname = "vfx_train_concrete_ornate_destr";

  while(var_0.health > 0) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_train_concrete_ornate_destr"), var_1, "tag_origin");
  playsoundatpos(var_1.origin, "dst_ornate_concrete");
  level notify("eggStoneBroke");
  var_0 hide();

  if(isDefined(var_0.heligotoplunderrepository)) {
    var_0.heligotoplunderrepository show();
  }

  if(var_0.targetname == "eggStoneKey") {
    thread vehicles_spawned();
    return;
  }
}

function molotov_watch_cleanup_pool() {
  level.ref_138B3 = 1;
}

function vehicles_spawned() {
  level.vehicleoccupants = getEntArray("eggButton", "targetname");

  foreach(var_1 in level.vehicleoccupants) {
    thread vehiclespawn_armoredtruck(var_1);
  }

  wait 1;

  while(level.molotov_watch_cleanup_pool_internal) {
    if(level.insertingarmorplate < 5) {
      level.audio_player_delete_mud_loop = level.helihint_gotopad[level.insertingarmorplate];
      level waittill("CodeKeyPressed");
      continue;
    }

    level.molotov_watch_cleanup_pool_internal = 0;
    thread ref_13DC1();
  }
}

function vehiclespawn_armoredtruck(var_0) {
  var_0 setCanDamage(1);

  while(level.molotov_watch_cleanup_pool_internal) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(level.audio_player_delete_mud_loop == int(var_0.script_label)) {
      level.insertingarmorplate++;
      level notify("CodeKeyPressed");
      continue;
    }

    if(level.helihint_gotopad[0] == int(var_0.script_label)) {
      level.insertingarmorplate = 1;
      level notify("CodeKeyPressed");
      continue;
    }

    level.insertingarmorplate = 0;
    level notify("CodeKeyPressed");
  }
}

function ref_1313F(var_0, var_1) {
  switch (var_1) {
    case 1:
      var_0.heligotoplunderrepository = getEnt("Num1", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 2:
      var_0.heligotoplunderrepository = getEnt("Num2", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 3:
      var_0.heligotoplunderrepository = getEnt("Num3", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 4:
      var_0.heligotoplunderrepository = getEnt("Num4", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 5:
      var_0.heligotoplunderrepository = getEnt("Num5", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 6:
      var_0.heligotoplunderrepository = getEnt("Num6", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 7:
      var_0.heligotoplunderrepository = getEnt("Num7", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 8:
      var_0.heligotoplunderrepository = getEnt("Num8", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 9:
      var_0.heligotoplunderrepository = getEnt("Num9", "targetname");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    default:
      break;
  }
}

function ref_1327B() {
  wait randomint(20);
  var_0 = getEntArray("Train", "script_noteworthy");
  level.ref_13CD2 = 1;
  wait level.ref_13CD2;
  level.ref_12A13 = spawn("script_origin", (656, 968, 180));
  level.ref_12A14 = spawn("script_origin", (572, 332, 80));
  level.ref_12A15 = spawn("script_origin", (656, -436, 180));
  level.ref_12A16 = spawn("script_origin", (216, -196, 80));

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname)) {
      var_3 = getEntArray(var_2.targetname, "target");

      foreach(var_5 in var_3) {
        var_5 linkTo(var_2);
      }
    }

    if(isDefined(var_2.script_label)) {
      switch (var_2.script_label) {
        case "engine":
          if(isDefined(var_2.targetname) && var_2.targetname == "TrainFront") {
            playFXOnTag(level._effect["vfx_train_moving_train_lights"], var_2, "tag_origin");
            thread ref_13C97(var_2);
          }

          break;
        case "flatbed":
          break;
        case "boxcar":
          break;
        default:
          break;
      }
    }

    thread ref_13CC9(var_2);
    thread ref_13CCC(var_2);
    level.ref_13CD2 = randomint(30);
    thread ref_13C96();
  }
}

function ref_13CCC(var_0) {
  wait randomfloat(1);

  for(;;) {
    playrumbleonposition("tank_rumble", var_0.origin + (150, 0, 0));
    wait 0.3;
  }
}

function ref_13CC9(var_0) {
  var_1 = 0.0025;
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

  for(var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");; var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname")) {
    var_3 = abs(distance(var_0.origin, var_2.origin) * var_1);
    var_0 moveTo(var_2.origin, var_3, 0, 0);
    var_0 rotateTo(var_2.angles, var_3, 0, 0);
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    wait var_3;

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "teleport") {
      var_0.origin = var_2.origin;
      var_0.angles = var_2.angles;
      wait level.ref_13CD2;
    }
  }
}

function ref_13C96() {
  var_0 = spawn("script_origin", self.origin);
  var_0 endon("death");
  thread scripts\engine\utility::delete_on_death(var_0);
  var_1 = "";

  switch (self.script_label) {
    case "engine":
      var_1 = "veh_cargotrain_engine_lp";
      break;
    case "flatbed":
      var_1 = "veh_cargotrain_tank_lp";
      break;
    case "boxcar":
      var_1 = "veh_cargotrain_cart_lp";
      break;
    default:
      break;
  }

  var_0 linkTo(self);
  wait 0.05;
  var_0 playLoopSound(var_1);
  var_0 waittill("stop sound" + var_1);
  var_0 stoploopsound(var_1);
  var_0 delete();
}

function ref_13C97(var_0) {
  waitframe();

  for(;;) {
    if(isDefined(var_0) && isDefined(level.ref_12A13)) {
      if(distance2dsquared(var_0.origin, level.ref_12A13.origin) < 7000000) {
        level.ref_12A13 playSound("emt_train_rattle_fence");
        wait 1.5;
        level.ref_12A14 playSound("emt_train_rattle_flatbed");
        wait 1.5;
        level.ref_12A15 playSound("emt_train_rattle_fence");
        level.ref_12A16 playSound("emt_train_rattle_flatbed");
        wait 30;
      } else {
        wait 1;
      }
    }

    waitframe();
  }
}