/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_flak_tower.gsc
*********************************************/

func_00F9() {
  lib_04A4::func_F9();
  lib_040C::func_F9();
  lib_04A3::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_flak_tower_lighting::func_F9();
  maps\mp\mp_flak_tower_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_flak_tower");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_7C62 = 8500;
  level.var_5A7C = "mp_flak_tower_killstreak";
  level.var_5A6B = "mp_flak_tower_killstreak";
  level.crafting_table = "glidebomb_hatchdoors_light_low";
  level.var_47CD = "mp_flak_tower_glide1";
  level.var_47CE = "mp_flak_tower_glide2";
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  thread func_542C();
  setDvar("5800", 3);
  setDvar("4230", 400);
  level thread flaktowerdisconnectnodes();
}

func_7EE3() {
  var_00 = getent("dish_02", "targetname");
  var_01 = getent("dish_03", "targetname");
  var_00 rotateyaw(12600, 1800);
  var_01 rotateyaw(12600, 1800);
}

func_542C() {
  var_00 = common_scripts\utility::func_46B5("org_fly_start", "targetname");
  var_01 = common_scripts\utility::func_46B5("org_fly_end", "targetname");
  if(!isDefined(var_00) || !isDefined(var_01)) {
    return;
  }

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
    return;
  }

  if(isDefined(game["status"]) && game["status"] != "normal") {
    return;
  }

  if(!isDefined(level.var_984D) || !level.var_984D) {
    return;
  }

  level waittill("matchStartTimer");
  var_02 = var_00.var_116;
  var_03 = var_01.var_116;
  var_04 = 9;
  var_05 = 1;
  var_06 = 5;
  var_07 = 700;
  var_08 = "vehicle_usa_fighter_thunderbolt_vista";
  var_09 = 1;
  var_0A = [];
  wait(var_05);
  while(var_09 <= var_06) {
    var_0B = randomintrange(3000, 3200);
    var_02 = var_00.var_116 + (0, 0, var_0B);
    var_03 = var_01.var_116 + (0, 0, var_0B);
    var_0C = spawn("script_model", var_02);
    var_0C.var_1D = (0, 90, 0);
    var_0C setModel(var_08);
    var_0D = anglesToForward(var_0C.var_1D);
    var_0E = anglestoright(var_0C.var_1D);
    var_0F = "flk_intro_thunderbolt_flyby";
    switch (var_09) {
      case 1:
        var_0C.var_116 = var_02;
        var_0C thread func_3CD3();
        var_0C thread func_7017();
        var_0C.var_7021 = 1;
        break;

      case 2:
        var_0C.var_116 = var_02 + var_0E * var_07 * -1 + var_0D * var_07 * -1;
        var_0F = "flk_intro_thunderbolt_crash";
        var_0C.var_7021 = 2;
        break;

      case 3:
        var_0C.var_116 = var_02 + var_0E * var_07 + var_0D * var_07 * -1;
        var_0C thread func_7017();
        var_0C.var_7021 = 3;
        break;

      case 4:
        var_0C.var_116 = var_02 + var_0E * var_07 * -2 + var_0D * var_07 * -2;
        var_0C thread func_7017();
        var_0C.var_7021 = 4;
        break;

      case 5:
        var_0C.var_116 = var_02 + var_0E * var_07 * 2 + var_0D * var_07 * -2;
        var_0C thread func_7017();
        var_0C.var_7021 = 5;
        break;
    }

    if(isDefined(var_0F)) {
      var_0C method_8278(var_0F);
      var_0C lib_0378::func_8D74("mp_intro_flak_plane_flyover", var_0C.var_7021);
    }

    var_0A[var_0A.size] = var_0C;
    var_09++;
    wait(randomfloatrange(0.1, 0.5));
  }

  var_0A[1] thread func_2721(2);
  wait(var_04);
  level notify("flak_intro_finished");
  level.var_3CD0 = 1;
}

flaktowerdisconnectnodes() {
  var_00 = getnodesinradiussorted((360, 980, 1557.95), 256, 0)[0];
  var_01 = getnodesinradiussorted((236, 980, 1666.87), 256, 0)[0];
  disconnectnodepair(var_00, var_01);
  var_00 = getnodesinradiussorted((-364, 948, 1560.61), 256, 0)[0];
  var_01 = getnodesinradiussorted((-240, 948, 1664.13), 256, 0)[0];
  disconnectnodepair(var_00, var_01);
}

func_7025() {
  self endon("death");
  level endon("game_ended");
  var_00 = 0;
  var_01 = 5;
  var_02 = -8;
  var_03 = randomfloatrange(1, 2);
  var_04 = 1;
  for(;;) {
    if(var_04 % 2 == 0) {
      self rotateto(self.var_1D + (0, 0, var_01), var_03);
    } else if(var_04 % 3 == 0) {
      self rotateto(self.var_1D + (0, 0, var_00), var_03);
    } else {
      self rotateto(self.var_1D + (0, 0, var_02), var_03);
    }

    wait(var_03);
    var_04++;
  }
}

func_7017() {
  self endon("death");
  level endon("game_ended");
  var_00 = 1;
  var_01 = "vehicle_usa_fighter_thunderbolt_vista_fade";
  level waittill("flak_intro_finished");
  self setModel(var_01);
  self setmaterialscriptparam(1, 0, var_00);
  wait(var_00);
  if(isDefined(self)) {
    self delete();
  }
}

func_3CD3() {
  level endon("game_ended");
  var_00 = getEntArray("flak_cannon_base", "targetname");
  var_01 = getEntArray("flak_cannon_gun", "targetname");
  if(!isDefined(var_00) || !isDefined(var_01)) {
    return;
  }

  var_02 = randomfloatrange(0.5, 0.6);
  foreach(var_04 in var_00) {
    var_04.var_6C48 = var_04.var_1D;
    var_05 = var_04.var_116 - self.var_116;
    var_05 = (var_05[0], var_05[1], 0);
    var_05 = vectornormalize(var_05);
    var_04 rotateto(vectortoangles(var_05), var_02);
  }

  foreach(var_08 in var_01) {
    var_08.var_6C48 = var_08.var_1D;
    var_09 = getEntArray(var_08.var_1A2, "targetname");
    foreach(var_0B in var_09) {
      var_0B linkto(var_08);
    }

    var_05 = var_08.var_116 - self.var_116;
    var_05 = vectornormalize(var_05);
    var_08 rotateto(vectortoangles(var_05), var_02);
  }

  wait(var_02);
  while(!isDefined(level.var_3CD0) || !level.var_3CD0) {
    foreach(var_04 in var_00) {
      var_05 = var_04.var_116 - self.var_116;
      var_05 = (var_05[0], var_05[1], 0);
      var_05 = vectornormalize(var_05);
      var_04.var_1D = vectortoangles(var_05);
    }

    foreach(var_11, var_08 in var_01) {
      var_05 = var_08.var_116 - self.var_116;
      var_05 = vectornormalize(var_05);
      var_08.var_1D = vectortoangles(var_05);
      if(var_08.var_1D[0] > 50) {
        var_08.var_1D = (50, var_08.var_1D[1], var_08.var_1D[2]);
      }

      if(randomint(100) > 75) {
        var_08 thread func_3BBA(self);
      }
    }

    wait 0.05;
  }

  foreach(var_08 in var_01) {
    var_08 rotateto(var_08.var_6C48, randomfloatrange(1, 2.5));
  }

  foreach(var_04 in var_00) {
    var_04 rotateto(var_04.var_6C48, randomfloatrange(1, 2.5));
  }
}

func_3BBA(param_00) {
  param_00 endon("death");
  var_01 = getEntArray(self.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    shootblank(var_03.var_116, param_00.var_116, "mg42_mp", 1);
    param_00 maps\mp\_utility::func_2CED(randomfloatrange(0.05, 0.45), ::func_3CCC);
    wait(randomfloatrange(0.05, 0.15));
  }
}

func_3CCC() {
  if(!isDefined(self)) {
    return;
  }

  if(randomint(100) < 75) {
    return;
  }

  var_00 = anglesToForward(self.var_1D);
  var_01 = anglestoright(self.var_1D);
  var_02 = randomintrange(-1200, 1200);
  var_03 = randomintrange(-600, 600);
  playFX(common_scripts\utility::func_44F5("flak_gun_explosion"), self.var_116 + var_00 * var_02 + var_01 * var_03);
}

func_2721(param_00) {
  level endon("game_ended");
  self endon("death");
  wait(param_00);
  playFXOnTag(common_scripts\utility::func_44F5("flak_intro_vehicle_flame_trail"), self, "tag_origin");
  lib_0378::func_8D74("mp_intro_flak_plane_deathspin");
  wait(3.25);
  playFX(common_scripts\utility::func_44F5("flak_intro_vehicle_explosion_midair"), self.var_116);
  lib_0378::func_8D74("mp_intro_flak_plane_explode");
  self method_805C();
}

func_7EEA() {
  self endon("death");
  for(;;) {
    self rotateto(self.var_1D + (randomintrange(10, 20), 0, randomintrange(10, 20)), 0.1);
    wait(0.1);
  }
}