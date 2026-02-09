/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1559.gsc
**************************************/

_id_3CD8() {
  precachelocationselector("map_artillery_selector");
  precacheitem("killstreak_precision_airstrike_sp");
  precacheitem("killstreak_stealth_airstrike_sp");
  precacheitem("stealth_bomb_mp");
  precacheitem("artillery_mp");
  precacheitem("harrier_missile_mp");
  precachemodel("vehicle_mig29_desert");
  precachemodel("vehicle_av8b_harrier_jet_mp");
  precachemodel("vehicle_av8b_harrier_jet_opfor_mp");
  precachemodel("weapon_minigun");
  precachemodel("vehicle_b2_bomber");
  precachemodel("projectile_cbu97_clusterbomb");
  precacheshader("specialty_precision_airstrike");
  precacheshader("dpad_killstreak_precision_airstrike");
  precachestring(&"SP_KILLSTREAKS_REWARDNAME_PRECISION_AIRSTRIKE");
  precachestring(&"SP_KILLSTREAKS_EARNED_PRECISION_AIRSTRIKE");
  precachestring(&"SP_KILLSTREAKS_PRECISION_AIRSTRIKE_PICKUP");
  precacheshader("specialty_stealth_bomber");
  precacheshader("dpad_killstreak_stealth_bomber");
  precachestring(&"SP_KILLSTREAKS_REWARDNAME_STEALTH_AIRSTRIKE");
  precachestring(&"SP_KILLSTREAKS_EARNED_STEALTH_AIRSTRIKE");
  precachestring(&"SP_KILLSTREAKS_STEALTH_AIRSTRIKE_PICKUP");
  level.onfirefx = loadfx("fire/fire_smoke_trail_L");
  level.airstrikefx = loadfx("explosions/clusterbomb");
  level.mortareffect = loadfx("explosions/artilleryExp_dirt_brown");
  level.bombstrike = loadfx("explosions/wall_explosion_pm_a");
  level.stealthbombfx = loadfx("explosions/stealth_bomb_mp");
  level.planes = 0;
  level.harrier_smoke = loadfx("fire/jet_afterburner_harrier_damaged");
  level.harrier_deathfx = loadfx("explosions/aerial_explosion_harrier");
  level.harrier_afterburnerfx = loadfx("fire/jet_afterburner_harrier");
  level.fx_airstrike_afterburner = loadfx("fire/jet_afterburner");
  level.fx_airstrike_contrail = loadfx("smoke/jet_contrail");
  level.dangermaxradius["stealth"] = 900;
  level.dangerminradius["stealth"] = 750;
  level.dangerforwardpush["stealth"] = 1;
  level.dangerovalscale["stealth"] = 6.0;
  level.dangermaxradius["default"] = 550;
  level.dangerminradius["default"] = 300;
  level.dangerforwardpush["default"] = 1.5;
  level.dangerovalscale["default"] = 6.0;
  level.dangermaxradius["precision"] = 550;
  level.dangerminradius["precision"] = 300;
  level.dangerforwardpush["precision"] = 2.0;
  level.dangerovalscale["precision"] = 6.0;
  level.dangermaxradius["harrier"] = 550;
  level.dangerminradius["harrier"] = 300;
  level.dangerforwardpush["harrier"] = 1.5;
  level.dangerovalscale["harrier"] = 6.0;
  level.artillerydangercenters = [];
}

_id_3CD9(var_0) {
  if(isDefined(self._id_3B10) && self._id_3B10) {
    return 0;
  }
  if(!isDefined(var_0)) {
    var_0 = "precision";
  }
  switch (var_0) {
    case "precision":
      break;
    case "stealth":
      break;
    case "harrier":
      if(level.planes > 1) {
        iprintlnbold("Air space too crowded!");
        return 0;
      }

      break;
    case "super":
      break;
  }

  var_1 = _id_3CDB(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }
  thread _id_3CDE(var_0, var_1.location, var_1._id_3CDA);
  return 1;
}

_id_3CDB(var_0) {
  var_1 = 0;

  if(var_0 == "precision" || var_0 == "stealth") {
    var_1 = 1;
  }
  var_2 = level.mapsize / 5.625;

  if(issplitscreen()) {
    var_2 = var_2 * 1.5;
  }
  self beginlocationselection("map_artillery_selector", var_1, var_2);
  self.selectinglocation = 1;
  self setblurforplayer(4.0, 0.3);
  thread waitforairstrikecancel();
  thread _id_3CDC("cancel_location");
  thread _id_3CDC("death");
  thread _id_3CDC("disconnect");
  self endon("stop_location_selection");
  self waittill("confirm_location", var_3, var_4);

  if(!var_1) {
    var_4 = randomint(360);
  }
  self setblurforplayer(0, 0.3);

  if(var_0 == "harrier" && level.planes > 1) {
    self notify("cancel_location");
    iprintlnbold("Air space too crowded!");
    return 0;
  }

  var_5 = spawnStruct();
  var_5.location = var_3;
  var_5._id_3CDA = var_4;
  maps\_utility::delaythread(0.05, ::_id_3CDD);
  return var_5;
}

waitforairstrikecancel() {
  self waittill("cancel_location");
  self setblurforplayer(0, 0.3);
}

_id_3CDC(var_0) {
  self endon("stop_location_selection");
  self waittill(var_0);
  thread _id_3CDD();
}

_id_3CDD() {
  self setblurforplayer(0, 0.3);
  self endlocationselection();
  self.selectinglocation = undefined;
  self notify("stop_location_selection");
}

_id_3CDE(var_0, var_1, var_2) {
  var_3 = bulletTrace(level.mapcenter + (0, 0, 1000000.0), level.mapcenter, 0, undefined);
  var_1 = (var_1[0], var_1[1], var_3["position"][2] - 514);
  thread _id_3CDF(var_0, var_1, var_2, self, self.team);
}

_id_3CDF(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }
  if(var_0 == "harrier") {
    level.planes++;
  }
  if(isDefined(level.airstrikeinprogress)) {
    while(isDefined(level.airstrikeinprogress)) {
      level waittill("begin_airstrike");
    }
    level.airstrikeinprogress = 1;
    wait 2.0;
  }

  if(!isDefined(var_3)) {
    if(var_0 == "harrier") {
      level.planes--;
    }
    return;
  }

  level.airstrikeinprogress = 1;
  var_5 = 17 + randomint(3);
  var_6 = bulletTrace(var_1, var_1 + (0, 0, -1000000.0), 0, undefined);
  var_7 = var_6["position"];
  var_8 = spawnStruct();
  var_8.origin = var_7;
  var_8.forward = anglesToForward((0, var_2, 0));
  var_8.airstriketype = var_0;
  level.artillerydangercenters[level.artillerydangercenters.size] = var_8;
  var_9 = callstrike(var_3, var_7, var_2, var_0);
  wait 1.0;
  level.airstrikeinprogress = undefined;
  var_3 notify("begin_airstrike");
  level notify("begin_airstrike");
  wait 7.5;
  var_10 = 0;
  var_11 = [];

  for(var_12 = 0; var_12 < level.artillerydangercenters.size; var_12++) {
    if(!var_10 && level.artillerydangercenters[var_12].origin == var_7) {
      var_10 = 1;
      continue;
    }

    var_11[var_11.size] = level.artillerydangercenters[var_12];
  }

  level.artillerydangercenters = var_11;

  if(var_0 != "harrier") {
    return;
  }
  while(isDefined(var_9)) {
    wait 0.1;
  }
  level.planes--;
}

callstrike(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = 0;
  var_6 = (0, var_2, 0);
  var_4 = getent("airstrikeheight", "targetname");

  if(var_3 == "stealth") {
    var_7 = 12000;
    var_8 = 2000;

    if(!isDefined(var_4)) {
      var_9 = 950;
      var_5 = 1500;

      if(isDefined(level.airstrikeheightscale)) {
        var_9 = var_9 * level.airstrikeheightscale;
      }
    } else {
      var_9 = var_4.origin[2];
      var_5 = getexplodedistance(var_9);
    }
  } else {
    var_7 = 24000;
    var_8 = 7000;

    if(!isDefined(var_4)) {
      var_9 = 850;
      var_5 = 1500;

      if(isDefined(level.airstrikeheightscale)) {
        var_9 = var_9 * level.airstrikeheightscale;
      }
    } else {
      var_9 = var_4.origin[2];
      var_5 = getexplodedistance(var_9);
    }
  }

  var_10 = var_1 + anglesToForward(var_6) * (-1 * var_7);

  if(isDefined(var_4)) {
    var_10 = var_10 * (1, 1, 0);
  }
  var_10 = var_10 + (0, 0, var_9);

  if(var_3 == "stealth") {
    var_11 = var_1 + anglesToForward(var_6) * (var_7 * 4);
  } else {
    var_11 = var_1 + anglesToForward(var_6) * var_7;
  }
  if(isDefined(var_4)) {
    var_11 = var_11 * (1, 1, 0);
  }
  var_11 = var_11 + (0, 0, var_9);
  var_12 = length(var_10 - var_11);
  var_13 = var_12 / var_8;
  var_12 = abs(var_12 / 2 + var_5);
  var_14 = var_12 / var_8;
  var_0 endon("disconnect");
  level.airstrikedamagedents = [];
  level.airstrikedamagedentscount = 0;
  level.airstrikedamagedentsindex = 0;

  if(var_3 == "stealth") {
    level thread dobomberstrike(var_0, var_1, var_10 + (0, 0, randomint(1000)), var_11 + (0, 0, randomint(1000)), var_14, var_13, var_6);
  } else {
    level thread doplanestrike(var_0, var_1, var_10 + (0, 0, randomint(500)), var_11 + (0, 0, randomint(500)), var_14, var_13, var_6, var_3);
    wait(randomfloatrange(1.5, 2.5));
    level thread doplanestrike(var_0, var_1, var_10 + (0, 0, randomint(200)), var_11 + (0, 0, randomint(200)), var_14, var_13, var_6, var_3);
    wait(randomfloatrange(1.5, 2.5));
    level thread doplanestrike(var_0, var_1, var_10 + (0, 0, randomint(200)), var_11 + (0, 0, randomint(200)), var_14, var_13, var_6, var_3);

    if(var_3 == "super") {
      wait(randomfloatrange(2.5, 3.5));
      level thread doplanestrike(var_0, var_1, var_10 + (0, 0, randomint(200)), var_11 + (0, 0, randomint(200)), var_14, var_13, var_6, var_3);
    }
  }
}

getexplodedistance(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

_id_3CE0(var_0, var_1, var_2) {
  var_3 = "vehicle_mig29_desert";
  var_4 = "compass_objpoint_airstrike_friendly";
  var_5 = "compass_objpoint_airstrike_busy";

  if(var_0 == "harrier") {
    var_3 = "vehicle_av8b_harrier_jet_mp";

    if(var_1.team != "allies") {
      var_3 = "vehicle_av8b_harrier_jet_opfor_mp";
    }
    var_4 = "hud_minimap_harrier_green";
    var_5 = "hud_minimap_harrier_red";
  } else if(var_0 == "stealth") {
    var_3 = "vehicle_b2_bomber";
    var_4 = "compass_objpoint_b2_airstrike_friendly";
    var_5 = "compass_objpoint_b2_airstrike_enemy";
  }

  var_6 = spawn("script_model", var_2);
  var_6.team = var_1.team;
  var_6 setModel(var_3);
  return var_6;
}

doplanestrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_0)) {
    return;
  }
  var_8 = 100;
  var_9 = 150;
  var_10 = var_2 + ((randomfloat(2) - 1) * var_8, (randomfloat(2) - 1) * var_8, 0);
  var_11 = var_3 + ((randomfloat(2) - 1) * var_9, (randomfloat(2) - 1) * var_9, 0);
  var_12 = _id_3CE0(var_7, var_0, var_10);
  var_12 playLoopSound("veh_mig29_dist_loop");
  var_12.angles = var_6;
  var_13 = anglesToForward(var_6);
  var_12 thread playplanefx();
  var_12 moveto(var_11, var_5, 0, 0);
  thread callstrike_bombeffect(var_12, var_11, var_5, var_4 - 1.0, var_0, var_7);
  wait(var_5);
  var_12 notify("delete");
  var_12 delete();
}

playplanefx() {
  self endon("death");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

callstrike_bomb(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    self notify("stop_bombing");
    return;
  }

  var_4 = 512;
  var_5 = (0, randomint(360), 0);
  var_6 = var_0 + anglesToForward(var_5) * randomfloat(var_4);
  var_7 = bulletTrace(var_6, var_6 + (0, 0, -10000), 0, undefined);
  var_6 = var_7["position"];
  var_8 = distance(var_0, var_6);

  if(var_8 > 5000) {
    return;
  }
  wait(0.85 * (var_8 / 2000));

  if(!isDefined(var_1)) {
    self notify("stop_bombing");
    return;
  }

  if(var_3) {
    playFX(level.mortareffect, var_6);
    playrumbleonposition("grenade_rumble", var_6);
    earthquake(1.0, 0.6, var_6, 2000);
  }

  thread common_scripts\utility::play_sound_in_space("exp_airstrike_bomb", var_6);
  radiusartilleryshellshock(var_6, 512, 8, 4);
  radiusdamage(var_6 + (0, 0, 16), 896, 300, 50, var_1, "MOD_PROJECTILE_SPLASH", "stealth_bomb_mp");
}

radiusartilleryshellshock(var_0, var_1, var_2, var_3) {
  foreach(var_5 in level.players) {
    if(!isalive(var_5)) {
      continue;
    }
    var_6 = var_5.origin + (0, 0, 32);
    var_7 = distance(var_0, var_6);

    if(var_7 > var_1) {
      continue;
    }
    var_8 = var_7 / var_1;
    var_9 = maps\_utility::_id_281D(var_8, var_3, var_2);
    var_5 thread artilleryshellshock("default", var_9);
  }
}

artilleryshellshock(var_0, var_1) {
  if(isDefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked) {
    return;
  }
  self.beingartilleryshellshocked = 1;
  self shellshock(var_0, var_1);
  wait(var_1 + 1);
  self.beingartilleryshellshocked = 0;
}

callstrike_bombeffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait(var_3);

  if(!isDefined(var_4)) {
    return;
  }
  var_0 playSound("veh_mig29_sonic_boom");
  var_6 = anglesToForward(var_0.angles);
  var_7 = spawnbomb(var_0.origin, var_0.angles);
  var_7.airstriketype = var_5;
  var_7 movegravity(anglesToForward(var_0.angles) * 4666.67, 3.0);
  wait 1;
  var_8 = spawn("script_model", var_7.origin);
  var_8 setModel("tag_origin");
  var_8.origin = var_7.origin;
  var_8.angles = var_7.angles;
  var_7 setModel("tag_origin");
  wait 0.1;
  var_9 = var_8.origin;
  var_10 = var_8.angles;
  playFXOnTag(level.airstrikefx, var_8, "tag_origin");
  wait 1;
  var_11 = 12;
  var_12 = 5;
  var_13 = 55;
  var_14 = (var_13 - var_12) / var_11;
  var_15 = (0, 0, 0);

  for(var_16 = 0; var_16 < var_11; var_16++) {
    var_17 = anglesToForward(var_10 + (var_13 - var_14 * var_16, randomint(10) - 5, 0));
    var_18 = var_9 + var_17 * 10000;
    var_19 = bulletTrace(var_9, var_18, 0, undefined);
    var_20 = var_19["position"];
    var_15 = var_15 + var_20;
    radiusdamage(var_20 + (0, 0, 16), 512, 200, 30, var_4, "MOD_PROJECTILE_SPLASH", "artillery_mp");

    if(var_16 % 3 == 0) {
      thread common_scripts\utility::play_sound_in_space("exp_airstrike_bomb", var_20);
      playrumbleonposition("artillery_rumble", var_20);
      earthquake(0.7, 0.75, var_20, 1000);
    }

    wait 0.05;
  }

  var_15 = var_15 / var_11 + (0, 0, 128);
  wait 5.0;
  var_8 delete();
  var_7 delete();
}

spawnbomb(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("projectile_cbu97_clusterbomb");
  return var_2;
}

dobomberstrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return;
  }
  var_7 = 100;
  var_8 = 150;
  var_9 = var_2 + ((randomfloat(2) - 1) * var_7, (randomfloat(2) - 1) * var_7, 0);
  var_10 = var_3 + ((randomfloat(2) - 1) * var_8, (randomfloat(2) - 1) * var_8, 0);
  var_11 = _id_3CE0("stealth", var_0, var_9);
  var_11 playLoopSound("veh_b2_dist_loop");
  var_11 setModel("vehicle_b2_bomber");
  var_11.angles = var_6;
  var_12 = anglesToForward(var_6);
  var_11 moveto(var_10, var_5, 0, 0);
  thread bomberdropbombs(var_11, var_1, var_0);
  wait(var_5);
  var_11 notify("delete");
  var_11 delete();
}

bomberdropbombs(var_0, var_1, var_2) {
  while(!targetisclose(var_0, var_1, 5000)) {
    wait 0.05;
  }
  var_3 = 1;
  var_4 = 0;
  var_0 notify("start_bombing");
  var_0 thread playbombfx();

  for(var_5 = targetgetdist(var_0, var_1); var_5 < 5000; var_5 = targetgetdist(var_0, var_1)) {
    if(var_5 < 1500 && !var_4) {
      var_0 playSound("veh_b2_sonic_boom");
      var_4 = 1;
    }

    var_3 = !var_3;

    if(var_5 < 4500) {
      var_0 thread callstrike_bomb(var_0.origin, var_2, (0, 0, 0), var_3);
    }
    wait 0.1;
  }

  var_0 notify("stop_bombing");
}

targetisclose(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 3000;
  }
  var_3 = targetisinfront(var_0, var_1);

  if(var_3) {
    var_4 = 1;
  } else {
    var_4 = -1;
  }
  var_5 = common_scripts\utility::flat_origin(var_0.origin);
  var_6 = var_5 + anglesToForward(common_scripts\utility::flat_angle(var_0.angles)) * (var_4 * 100000);
  var_7 = pointonsegmentnearesttopoint(var_5, var_6, var_1);
  var_8 = distance(var_5, var_7);

  if(var_8 < var_2) {
    return 1;
  } else {
    return 0;
  }
}

targetisinfront(var_0, var_1) {
  var_2 = anglesToForward(common_scripts\utility::flat_angle(var_0.angles));
  var_3 = vectornormalize(common_scripts\utility::flat_origin(var_1) - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0) {
    return 1;
  } else {
    return 0;
  }
}

targetgetdist(var_0, var_1) {
  var_2 = targetisinfront(var_0, var_1);

  if(var_2) {
    var_3 = 1;
  } else {
    var_3 = -1;
  }
  var_4 = common_scripts\utility::flat_origin(var_0.origin);
  var_5 = var_4 + anglesToForward(common_scripts\utility::flat_angle(var_0.angles)) * (var_3 * 100000);
  var_6 = pointonsegmentnearesttopoint(var_4, var_5, var_1);
  var_7 = distance(var_4, var_6);
  return var_7;
}

playbombfx() {
  self endon("stop_bombing");

  for(;;) {
    playFXOnTag(level.stealthbombfx, self, "tag_left_alamo_missile");
    playFXOnTag(level.stealthbombfx, self, "tag_right_alamo_missile");
    wait 0.5;
  }
}