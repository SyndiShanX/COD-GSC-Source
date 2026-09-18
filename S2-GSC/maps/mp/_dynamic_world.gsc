/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_dynamic_world.gsc
*********************************************/

init() {
  common_scripts\utility::array_thread(getEntArray("com_wall_fan_blade_rotate_slow", "targetname"), ::func_3A1E, "veryslow");
  common_scripts\utility::array_thread(getEntArray("com_wall_fan_blade_rotate", "targetname"), ::func_3A1E, "slow");
  common_scripts\utility::array_thread(getEntArray("com_wall_fan_blade_rotate_fast", "targetname"), ::func_3A1E, "fast");
  var_00 = [];
  var_00["trigger_multiple_dyn_metal_detector"] = ::func_6121;
  var_00["trigger_multiple_dyn_creaky_board"] = ::func_2776;
  var_00["trigger_multiple_dyn_photo_copier"] = ::func_6F8C;
  var_00["trigger_multiple_dyn_copier_no_light"] = ::func_6F90;
  var_00["trigger_radius_motion_light"] = ::func_6462;
  var_00["trigger_radius_dyn_motion_dlight"] = ::func_6C69;
  var_00["trigger_multiple_dyn_dog_bark"] = ::func_3198;
  var_00["trigger_radius_bird_startle"] = ::func_1762;
  var_00["trigger_multiple_dyn_motion_light"] = ::func_6462;
  var_00["trigger_multiple_dyn_door"] = ::func_9D70;
  player_init();
  foreach(var_04, var_02 in var_00) {
    var_03 = getEntArray(var_04, "classname");
    common_scripts\utility::array_thread(var_03, ::func_9DC3);
    common_scripts\utility::array_thread(var_03, var_02);
  }

  common_scripts\utility::array_thread(getEntArray("vending_machine", "targetname"), ::func_A403);
  common_scripts\utility::array_thread(getEntArray("toggle", "targetname"), ::func_A1F6);
  common_scripts\utility::array_thread(getEntArray("sliding_door", "targetname"), ::func_8CA1);
  level thread onplayerconnect();
  var_05 = getEnt("civilian_jet_origin", "targetname");
  if(isDefined(var_05)) {
    var_05 thread func_2301();
  }

  thread func_5409();
}

onplayerconnect() {
  for(;;) {
    level waittill("connecting", var_00);
    var_00 thread func_64B5();
  }
}

player_init() {
  if(common_scripts\utility::issp()) {
    foreach(var_01 in level.players) {
      var_01.var_9AC5 = [];
      var_01 thread func_64B5();
    }
  }
}

func_0AAB() {
  self.var_9AC5 = [];
  thread func_64B5();
}

func_2301() {
  level endon("game_ended");
  func_5963();
  level waittill("prematch_over");
  for(;;) {
    thread func_5967();
    self waittill("start_flyby");
    thread func_5961();
    self waittill("flyby_done");
    func_5966();
  }
}

func_5963() {
  self.var_5964 = getEntArray(self.target, "targetname");
  self.var_5962 = getEnt("civilian_jet_flyto", "targetname");
  self.var_3776 = getEntArray("engine_fx", "targetname");
  self.var_3D3F = getEntArray("flash_fx", "targetname");
  self.var_595B = loadfx("vfx/test/test_fx");
  self.var_595E = loadfx("vfx/lights/aircraft_light_wingtip_red");
  self.var_595D = loadfx("vfx/lights/aircraft_light_wingtip_green");
  self.var_595C = loadfx("vfx/lights/aircraft_light_red_blink");
  level.var_2304 = undefined;
  var_00 = vectorNormalize(self.origin - self.var_5962.origin) * 20000;
  self.var_5962.origin = self.var_5962.origin - var_00;
  self.origin = self.origin + var_00;
  foreach(var_02 in self.var_5964) {
    var_02.origin = var_02.origin + var_00;
    var_02.var_6A43 = var_02.origin;
    var_02 hide();
  }

  foreach(var_05 in self.var_3776) {
    var_05.origin = var_05.origin + var_00;
  }

  foreach(var_08 in self.var_3D3F) {
    var_08.origin = var_08.origin + var_00;
  }

  var_0A = self.origin;
  var_0B = self.var_5962.origin;
  self.var_5960 = var_0B - var_0A;
  var_0C = 2000;
  var_0D = abs(distance(var_0A, var_0B));
  self.var_595F = var_0D / var_0C;
}

func_5966() {
  foreach(var_01 in self.var_5964) {
    var_01.origin = var_01.var_6A43;
    var_01 hide();
  }
}

func_5967() {
  level endon("game_ended");
  var_00 = func_46E1();
  var_01 = max(10, var_00);
  var_01 = min(var_01, 100);
  if(getDvar("jet_flyby_timer") != "") {
    level.var_2305 = 5 + getdvarint("jet_flyby_timer");
  } else {
    level.var_2305 = 0.25 + randomfloatrange(0.3, 0.7) * 60 * var_01;
  }

  wait(level.var_2305);
  while(isDefined(level.var_B97) || isDefined(level.var_84B) || isDefined(level.var_2210) || isDefined(level.var_7C66)) {
    wait 0.05;
  }

  self notify("start_flyby");
  level.var_2304 = 1;
  self waittill("flyby_done");
  level.var_2304 = undefined;
}

func_46E1() {
  if(common_scripts\utility::issp()) {
    return 10;
  }

  if(isDefined(game["status"]) && game["status"] == "overtime") {
    return 1;
  }

  return getwatcheddvar("timelimit");
}

getwatcheddvar(param_00) {
  param_00 = "scr_" + level.gametype + "_" + param_00;
  if(isDefined(level.var_6CC8) && isDefined(level.var_6CC8[param_00])) {
    return level.var_6CC8[param_00];
  }

  return level.watchdvars[param_00].value;
}

func_5961() {
  foreach(var_01 in self.var_5964) {
    var_01 show();
  }

  var_03 = [];
  var_04 = [];
  foreach(var_06 in self.var_3776) {
    var_07 = spawn("script_model", var_06.origin);
    var_07 setModel("tag_origin");
    var_07.angles = var_06.angles;
    var_03[var_03.size] = var_07;
  }

  foreach(var_0A in self.var_3D3F) {
    var_0B = spawn("script_model", var_0A.origin);
    var_0B setModel("tag_origin");
    var_0B.color = var_0A.script_noteworthy;
    var_0B.angles = var_0A.angles;
    var_04[var_04.size] = var_0B;
  }

  thread func_5965(self.var_5964[0], level.var_5FEB);
  wait 0.05;
  foreach(var_07 in var_03) {
    playFXOnTag(self.var_595B, var_07, "tag_origin");
  }

  foreach(var_0B in var_04) {
    if(isDefined(var_0B.color) && var_0B.color == "blink") {
      playFXOnTag(self.var_595C, var_0B, "tag_origin");
      continue;
    }

    if(isDefined(var_0B.color) && var_0B.color == "red") {
      playFXOnTag(self.var_595E, var_0B, "tag_origin");
      continue;
    }

    playFXOnTag(self.var_595D, var_0B, "tag_origin");
  }

  foreach(var_01 in self.var_5964) {
    var_01 moveTo(var_01.origin + self.var_5960, self.var_595F);
  }

  foreach(var_07 in var_03) {
    var_07 moveTo(var_07.origin + self.var_5960, self.var_595F);
  }

  foreach(var_0B in var_04) {
    var_0B moveTo(var_0B.origin + self.var_5960, self.var_595F);
  }

  wait(self.var_595F + 1);
  foreach(var_07 in var_03) {
    var_07 delete();
  }

  foreach(var_0B in var_04) {
    var_0B delete();
  }

  self notify("flyby_done");
}

func_5965(param_00, param_01) {
  param_00 thread func_74D6("veh_mig29_dist_loop");
  while(!func_982B(param_00, param_01)) {
    wait 0.05;
  }

  param_00 thread func_74D6("veh_mig29_close_loop");
  while(func_982C(param_00, param_01)) {
    wait 0.05;
  }

  wait(0.5);
  param_00 thread func_74D5("veh_mig29_sonic_boom");
  while(func_982B(param_00, param_01)) {
    wait 0.05;
  }

  param_00 notify("stop soundveh_mig29_close_loop");
  self waittill("flyby_done");
  param_00 notify("stop soundveh_mig29_dist_loop");
}

func_74D5(param_00, param_01, param_02) {
  var_03 = spawn("script_origin", (0, 0, 1));
  var_03 hide();
  if(!isDefined(param_01)) {
    param_01 = self.origin;
  }

  var_03.origin = param_01;
  if(isDefined(param_02) && param_02) {
    var_03 method_861C(param_00);
  } else {
    var_03 playSound(param_00);
  }

  wait(10);
  var_03 delete();
}

func_74D6(param_00, param_01) {
  var_02 = spawn("script_origin", (0, 0, 0));
  var_02 hide();
  var_02 endon("death");
  thread common_scripts\utility::func_2D18(var_02);
  if(isDefined(param_01)) {
    var_02.origin = self.origin + param_01;
    var_02.angles = self.angles;
    var_02 linkTo(self);
  } else {
    var_02.origin = self.origin;
    var_02.angles = self.angles;
    var_02 linkTo(self);
  }

  var_02 method_861D(param_00);
  self waittill("stop sound" + param_00);
  var_02 stoploopsound(param_00);
  var_02 delete();
}

func_982C(param_00, param_01) {
  var_02 = anglesToForward(common_scripts\utility::func_3D5C(param_00.angles));
  var_03 = vectorNormalize(common_scripts\utility::func_3D5D(param_01) - param_00.origin);
  var_04 = vectordot(var_02, var_03);
  if(var_04 > 0) {
    return 1;
  }

  return 0;
}

func_982B(param_00, param_01) {
  var_02 = func_982C(param_00, param_01);
  if(var_02) {
    var_03 = 1;
  } else {
    var_03 = -1;
  }

  var_04 = common_scripts\utility::func_3D5D(param_00.origin);
  var_05 = var_04 + anglesToForward(common_scripts\utility::func_3D5C(param_00.angles)) * var_03 * 100000;
  var_06 = pointonsegmentnearesttopoint(var_04, var_05, param_01);
  var_07 = distance(var_04, var_06);
  if(var_07 < 3000) {
    return 1;
  }

  return 0;
}

func_A403() {
  level endon("game_ended");
  self endon("death");
  self setCursorHint("HINT_ACTIVATE");
  self.var_A5B1 = getEnt(self.target, "targetname");
  var_00 = getEnt(self.var_A5B1.target, "targetname");
  var_01 = getEnt(var_00.target, "targetname");
  var_02 = getEnt(var_01.target, "targetname");
  self.var_A5AC = var_02.origin;
  var_03 = getEnt(var_02.target, "targetname");
  self.var_A5AD = var_03.origin;
  if(isDefined(var_03.target)) {
    self.var_A5A7 = getEnt(var_03.target, "targetname").origin;
  }

  self.var_A5B1 setCanDamage(1);
  self.var_A5B2 = self.var_A5B1.model;
  self.var_A5A5 = self.var_A5B1.script_noteworthy;
  self.var_A5C0 = var_00.model;
  self.var_A5C2 = var_00.origin;
  self.var_A5C1 = var_00.angles;
  self.var_A5C4 = var_01.origin;
  self.var_A5C3 = var_01.angles;
  precachemodel(self.var_A5A5);
  var_00 delete();
  var_01 delete();
  var_02 delete();
  var_03 delete();
  self.var_8ED8 = [];
  self.var_8EDB = 12;
  self.var_8EDC = undefined;
  self.var_4F00 = 400;
  thread func_A404(self.var_A5B1);
  self method_861D("vending_machine_hum");
  for(;;) {
    self waittill("trigger", var_04);
    self playSound("vending_machine_button_press");
    if(!self.var_8EDB) {
      continue;
    }

    if(isDefined(self.var_8EDC)) {
      func_8EDA();
    }

    func_8ED9(func_8FF4());
    wait 0.05;
  }
}

func_A404(param_00) {
  level endon("game_ended");
  var_01 = "mod_grenade mod_projectile mod_explosive mod_grenade_splash mod_projectile_splash splash";
  var_02 = loadfx("vfx/test/test_fx");
  for(;;) {
    var_03 = undefined;
    var_04 = undefined;
    var_05 = undefined;
    var_06 = undefined;
    var_07 = undefined;
    param_00 waittill("damage", var_03, var_04, var_05, var_06, var_07);
    if(isDefined(var_07)) {
      if(issubstr(var_01, tolower(var_07))) {
        var_03 = var_03 * 3;
      }

      self.var_4F00 = self.var_4F00 - var_03;
      if(self.var_4F00 > 0) {
        continue;
      }

      self notify("death");
      self.origin = self.origin + (0, 0, 10000);
      if(!isDefined(self.var_A5A7)) {
        var_08 = self.var_A5B1.origin + (37, -31, 52);
      } else {
        var_08 = self.var_A5A7;
      }

      playFX(var_02, var_08);
      self.var_A5B1 setModel(self.var_A5A5);
      while(self.var_8EDB > 0) {
        if(isDefined(self.var_8EDC)) {
          func_8EDA();
        }

        func_8ED9(func_8FF4());
        wait 0.05;
      }

      self stoploopsound("vending_machine_hum");
      return;
    }
  }
}

func_8FF4() {
  var_00 = spawn("script_model", self.var_A5C2);
  var_00 setModel(self.var_A5C0);
  var_00.origin = self.var_A5C2;
  var_00.angles = self.var_A5C1;
  return var_00;
}

func_8ED9(param_00) {
  param_00 moveTo(self.var_A5C4, 0.2);
  param_00 playSound("vending_machine_soda_drop");
  wait(0.2);
  self.var_8EDC = param_00;
  self.var_8EDB--;
}

func_8EDA() {
  self endon("death");
  if(isDefined(self.var_8EDC.var_35AB) && self.var_8EDC.var_35AB == 1) {
    return;
  }

  var_00 = 1;
  var_01 = var_00 * -999;
  var_02 = int(-25536);
  var_03 = (int(var_02 / 2), int(var_02 / 2), 0) - (randomint(var_02), randomint(var_02), 0);
  var_04 = vectorNormalize(self.var_A5AD - self.var_A5AC + var_03);
  var_05 = var_04 * randomfloatrange(var_01, var_00);
  self.var_8EDC method_82C5(self.var_A5AC, var_05);
  self.var_8EDC.var_35AB = 1;
}

func_3E88() {
  level endon("game_ended");
  var_00 = "briefcase_bomb_mp";
  for(;;) {
    self waittill("trigger_enter", var_01);
    if(!var_01 hasweapon(var_00)) {
      var_01 playSound("freefall_death");
      var_01 maps\mp\_utility::_giveweapon(var_00);
      var_01 setweaponammostock(var_00, 0);
      var_01 setweaponammoclip(var_00, 0);
      var_01 switchtoweapon(var_00);
    }
  }
}

func_6121() {
  level endon("game_ended");
  var_00 = getEnt(self.target, "targetname");
  var_00 method_81AE();
  var_01 = getEnt(var_00.target, "targetname");
  var_02 = getEnt(var_01.target, "targetname");
  var_03 = getEnt(var_02.target, "targetname");
  var_04 = getEnt(var_03.target, "targetname");
  var_05 = [];
  var_06 = min(var_01.origin[0], var_02.origin[0]);
  var_05[0] = var_06;
  var_07 = max(var_01.origin[0], var_02.origin[0]);
  var_05[1] = var_07;
  var_08 = min(var_01.origin[1], var_02.origin[1]);
  var_05[2] = var_08;
  var_09 = max(var_01.origin[1], var_02.origin[1]);
  var_05[3] = var_09;
  var_0A = min(var_01.origin[2], var_02.origin[2]);
  var_05[4] = var_0A;
  var_0B = max(var_01.origin[2], var_02.origin[2]);
  var_05[5] = var_0B;
  var_01 delete();
  var_02 delete();
  if(!common_scripts\utility::issp()) {
    self.var_BAB = 7;
  } else {
    self.var_BAB = 2;
  }

  self.var_BAC = 0;
  self.var_BAA = 0;
  self.var_9A89 = 0;
  thread func_6122(var_00);
  thread func_6123();
  thread func_6124(var_05, "weapon_claymore", "weapon_c4");
  var_0C = (var_03.origin[0], var_03.origin[1], var_0B);
  var_0D = (var_04.origin[0], var_04.origin[1], var_0B);
  var_0E = loadfx("vfx/test/test_fx");
  for(;;) {
    common_scripts\utility::waittill_any("dmg_triggered", "touch_triggered", "weapon_triggered");
    thread func_74D4("alarm_metal_detector", var_0E, var_0C, var_0D);
  }
}

func_74D4(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  if(!self.var_BAC) {
    self.var_BAC = 1;
    thread func_0F06();
    if(!self.var_BAA) {
      self playSound(param_00);
    }

    playFX(param_01, param_02);
    playFX(param_01, param_03);
    wait(self.var_BAB);
    self.var_BAC = 0;
  }
}

func_0F06() {
  level endon("game_ended");
  if(!self.var_9A89) {
    return;
  }

  var_00 = self.var_BAB + 0.15;
  if(self.var_9A89) {
    self.var_9A89--;
  } else {
    self.var_BAA = 1;
  }

  var_01 = gettime();
  var_02 = 7;
  if(common_scripts\utility::issp()) {
    var_02 = 2;
  }

  func_A714("dmg_triggered", "touch_triggered", "weapon_triggered", var_02 + 2);
  var_03 = gettime() - var_01;
  if(var_03 > var_02 * 1000 + 1150) {
    self.var_BAA = 0;
    self.var_9A89 = 0;
  }
}

func_A714(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  self endon(param_00);
  self endon(param_01);
  self endon(param_02);
  wait(param_03);
}

func_6124(param_00, param_01, param_02) {
  level endon("game_ended");
  for(;;) {
    func_A773();
    var_03 = getEntArray("grenade", "classname");
    foreach(var_05 in var_03) {
      if(isDefined(var_05.model) && var_05.model == param_01 || var_05.model == param_02) {
        if(func_5719(var_05, param_00)) {
          thread func_A9AE(var_05, param_00);
        }
      }
    }
  }
}

func_A773() {
  level endon("game_ended");
  self endon("dmg_triggered");
  self waittill("touch_triggered");
}

func_A9AE(param_00, param_01) {
  param_00 endon("death");
  while(func_5719(param_00, param_01)) {
    self notify("weapon_triggered");
    wait(self.var_BAB);
  }
}

func_5719(param_00, param_01) {
  var_02 = param_01[0];
  var_03 = param_01[1];
  var_04 = param_01[2];
  var_05 = param_01[3];
  var_06 = param_01[4];
  var_07 = param_01[5];
  var_08 = param_00.origin[0];
  var_09 = param_00.origin[1];
  var_0A = param_00.origin[2];
  if(func_571A(var_08, var_02, var_03)) {
    if(func_571A(var_09, var_04, var_05)) {
      if(func_571A(var_0A, var_06, var_07)) {
        return 1;
      }
    }
  }

  return 0;
}

func_571A(param_00, param_01, param_02) {
  if(param_00 > param_01 && param_00 < param_02) {
    return 1;
  }

  return 0;
}

func_6122(param_00) {
  level endon("game_ended");
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05);
    if(isDefined(var_05) && func_0BAD(var_05)) {
      self notify("dmg_triggered");
    }
  }
}

func_6123() {
  level endon("game_ended");
  for(;;) {
    self waittill("trigger_enter");
    while(func_0F13(self)) {
      self notify("touch_triggered");
      wait(self.var_BAB);
    }
  }
}

func_0BAD(param_00) {
  var_01 = "mod_melee melee mod_grenade mod_projectile mod_explosive mod_impact";
  var_02 = strtok(var_01, " ");
  foreach(var_04 in var_02) {
    if(tolower(var_04) == tolower(param_00)) {
      return 1;
    }
  }

  return 0;
}

func_2776() {
  level endon("game_ended");
  for(;;) {
    self waittill("trigger_enter", var_00);
    var_00 thread func_30A4(self);
  }
}

func_30A4(param_00) {
  self endon("disconnect");
  self endon("death");
  self playSound("step_walk_plr_woodcreak_on");
  for(;;) {
    self waittill("trigger_leave", var_01);
    if(param_00 != var_01) {
      continue;
    }

    self playSound("step_walk_plr_woodcreak_off");
  }
}

func_6462() {
  level endon("game_ended");
  self.var_64DD = 1;
  self.var_5D7C = 0;
  var_00 = getEntArray(self.target, "targetname");
  common_scripts\utility::func_6753(["com_two_light_fixture_off", "com_two_light_fixture_on"], ::precachemodel);
  foreach(var_02 in var_00) {
    var_02.var_5D71 = [];
    var_03 = getEnt(var_02.target, "targetname");
    if(!isDefined(var_03.target)) {
      continue;
    }

    var_02.var_5D71 = getEntArray(var_03.target, "targetname");
  }

  for(;;) {
    self waittill("trigger_enter");
    while(func_0F13(self)) {
      var_05 = 0;
      foreach(var_07 in self.var_9AC3) {
        if(isDefined(var_07.var_3040) && var_07.var_3040 > 5) {
          var_05 = 1;
        }
      }

      if(var_05) {
        if(!self.var_5D7C) {
          self.var_5D7C = 1;
          var_00[0] playSound("switch_auto_lights_on");
          foreach(var_02 in var_00) {
            var_02 method_81DF(1);
            if(isDefined(var_02.var_5D71)) {
              foreach(var_0B in var_02.var_5D71) {
                var_0B setModel("com_two_light_fixture_on");
              }
            }
          }
        }

        thread func_6463(var_00, 10);
      }

      wait 0.05;
    }
  }
}

func_6463(param_00, param_01) {
  self notify("motion_light_timeout");
  self endon("motion_light_timeout");
  wait(param_01);
  foreach(var_03 in param_00) {
    var_03 method_81DF(0);
    if(isDefined(var_03.var_5D71)) {
      foreach(var_05 in var_03.var_5D71) {
        var_05 setModel("com_two_light_fixture_off");
      }
    }
  }

  param_00[0] playSound("switch_auto_lights_off");
  self.var_5D7C = 0;
}

func_6C69() {
  if(!isDefined(level.var_6C6B)) {
    level.var_6C6B = loadfx("vfx/lights/outdoor_motion_light");
  }

  level endon("game_ended");
  self.var_64DD = 1;
  self.var_5D7C = 0;
  var_00 = getEnt(self.target, "targetname");
  var_01 = getEntArray(var_00.target, "targetname");
  common_scripts\utility::func_6753(["com_two_light_fixture_off", "com_two_light_fixture_on"], ::precachemodel);
  for(;;) {
    self waittill("trigger_enter");
    while(func_0F13(self)) {
      var_02 = 0;
      foreach(var_04 in self.var_9AC3) {
        if(isDefined(var_04.var_3040) && var_04.var_3040 > 5) {
          var_02 = 1;
        }
      }

      if(var_02) {
        if(!self.var_5D7C) {
          self.var_5D7C = 1;
          var_00 playSound("switch_auto_lights_on");
          var_00 setModel("com_two_light_fixture_on");
          foreach(var_07 in var_01) {
            var_07.var_5D2F = spawn("script_model", var_07.origin);
            var_07.var_5D2F setModel("tag_origin");
            playFXOnTag(level.var_6C6B, var_07.var_5D2F, "tag_origin");
          }
        }

        thread func_6C6A(var_00, var_01, 10);
      }

      wait 0.05;
    }
  }
}

func_6C6A(param_00, param_01, param_02) {
  self notify("motion_light_timeout");
  self endon("motion_light_timeout");
  wait(param_02);
  foreach(var_04 in param_01) {
    var_04.var_5D2F delete();
  }

  param_00 playSound("switch_auto_lights_off");
  param_00 setModel("com_two_light_fixture_off");
  self.var_5D7C = 0;
}

func_3198() {
  level endon("game_ended");
  self.var_64DD = 1;
  var_00 = getEnt(self.target, "targetname");
  for(;;) {
    self waittill("trigger_enter", var_01);
    while(func_0F13(self)) {
      var_02 = 0;
      foreach(var_04 in self.var_9AC3) {
        if(isDefined(var_04.var_3040) && var_04.var_3040 > var_02) {
          var_02 = var_04.var_3040;
        }
      }

      if(var_02 > 6) {
        var_00 playSound("dyn_anml_dog_bark");
        wait(randomfloatrange(16 / var_02, 16 / var_02 + randomfloat(1)));
        continue;
      }

      wait 0.05;
    }
  }
}

func_9D70() {
  var_00 = getEnt(self.target, "targetname");
  self.var_3288 = var_00;
  self.var_3282 = func_4710(vectorNormalize(self getorigin() - var_00 getorigin()));
  var_00.var_1631 = var_00.angles[1];
  var_01 = 1;
  for(;;) {
    self waittill("trigger_enter", var_02);
    var_00 thread func_328D(var_01, func_44A7(var_02));
    if(func_0F13(self)) {
      self waittill("trigger_empty");
    }

    wait(3);
    if(func_0F13(self)) {
      self waittill("trigger_empty");
    }

    var_00 thread func_3285(var_01);
  }
}

func_328D(param_00, param_01) {
  if(param_01) {
    self rotateTo((0, self.var_1631 + 90, 1), param_00, 0.1, 0.75);
  } else {
    self rotateTo((0, self.var_1631 - 90, 1), param_00, 0.1, 0.75);
  }

  self playSound("door_generic_house_open");
  wait(param_00 + 0.05);
}

func_3285(param_00) {
  self rotateTo((0, self.var_1631, 1), param_00);
  self playSound("door_generic_house_close");
  wait(param_00 + 0.05);
}

func_44A7(param_00) {
  return vectordot(self.var_3282, vectorNormalize(param_00.origin - self.var_3288 getorigin())) > 0;
}

func_4710(param_00) {
  return (param_00[1], 0 - param_00[0], param_00[2]);
}

func_A1F6() {
  if(self.classname != "trigger_use_touch") {
    return;
  }

  var_00 = getEntArray(self.target, "targetname");
  self.var_5D7C = 1;
  foreach(var_02 in var_00) {
    var_02 method_81DF(1.5 * self.var_5D7C);
  }

  for(;;) {
    self waittill("trigger");
    self.var_5D7C = !self.var_5D7C;
    if(self.var_5D7C) {
      foreach(var_02 in var_00) {
        var_02 method_81DF(1.5);
      }

      self playSound("switch_auto_lights_on");
      continue;
    }

    foreach(var_02 in var_00) {
      var_02 method_81DF(0);
    }

    self playSound("switch_auto_lights_off");
  }
}

func_1762() {}

func_6F8E(param_00) {
  self.var_2660 = func_4290(param_00);
  if(isDefined(self.var_2660)) {
    var_01 = getEnt(self.var_2660.target, "targetname");
    if(isDefined(var_01)) {
      var_02 = getEnt(var_01.target, "targetname");
      if(isDefined(var_02)) {
        var_02.var_D8 = var_02 method_81DE();
        var_02 method_81DF(0);
        param_00.var_2664 = var_01;
        param_00.var_9269 = var_01.origin;
        param_00.var_5CCE = var_02;
        var_03 = self.var_2660.angles + (0, 90, 0);
        var_04 = anglesToForward(var_03);
        param_00.var_369A = param_00.var_9269 + var_04 * 30;
        return;
      }
    }
  }
}

func_4290(param_00) {
  if(!isDefined(param_00.target)) {
    var_01 = getEntArray("destructible_toy", "targetname");
    var_02 = var_01[0];
    foreach(var_04 in var_01) {
      if(isDefined(var_04.var_75) && var_04.var_75 == "toy_copier") {
        if(distance(param_00.origin, var_02.origin) > distance(param_00.origin, var_04.origin)) {
          var_02 = var_04;
        }
      }
    }
  } else {
    var_02 = getEnt(var_02.target, "targetname");
    if(isDefined(var_02)) {
      var_02 setCanDamage(1);
    }
  }

  return var_02;
}

func_A724() {
  if(!isDefined(self.var_2660)) {
    return;
  }

  self.var_2660 endon("FX_State_Change0");
  self.var_2660 endon("death");
  self waittill("trigger_enter");
}

func_6F8C() {
  level endon("game_ended");
  func_6F8E(self);
  if(!isDefined(self.var_2660)) {
    return;
  }

  self.var_2660 endon("FX_State_Change0");
  thread func_6F91();
  for(;;) {
    func_A724();
    self playSound("mach_copier_run");
    if(isDefined(self.var_2664)) {
      func_7D2E(self);
      thread func_6F8D();
      thread func_6F8F();
    }

    wait(3);
  }
}

func_6F90() {
  level endon("game_ended");
  self endon("death");
  if(common_scripts\utility::get_template_level() == "hamburg") {
    return;
  }

  self.var_2660 = func_4290(self);
  if(!isDefined(self.var_2660)) {
    return;
  }

  self.var_2660 endon("FX_State_Change0");
  for(;;) {
    func_A724();
    self playSound("mach_copier_run");
    wait(3);
  }
}

func_7D2E(param_00) {
  param_00.var_2664 moveTo(param_00.var_9269, 0.2);
  param_00.var_5CCE method_81DF(0);
}

func_6F8D() {
  self.var_2660 notify("bar_goes");
  self.var_2660 endon("bar_goes");
  self.var_2660 endon("FX_State_Change0");
  self.var_2660 endon("death");
  var_00 = self.var_2664;
  wait(2);
  var_00 moveTo(self.var_369A, 1.6);
  wait(1.8);
  var_00 moveTo(self.var_9269, 1.6);
  wait(1.6);
  var_01 = self.var_5CCE;
  var_02 = 0.2;
  var_03 = var_02 / 0.05;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    var_05 = var_04 * 0.05;
    var_05 = var_05 / var_02;
    var_05 = 1 - var_05 * var_01.var_D8;
    if(var_05 > 0) {
      var_01 method_81DF(var_05);
    }

    wait 0.05;
  }
}

func_6F8F() {
  self.var_2660 notify("light_on");
  self.var_2660 endon("light_on");
  self.var_2660 endon("FX_State_Change0");
  self.var_2660 endon("death");
  var_00 = self.var_5CCE;
  var_01 = 0.2;
  var_02 = var_01 / 0.05;
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = var_03 * 0.05;
    var_04 = var_04 / var_01;
    var_00 method_81DF(var_04 * var_00.var_D8);
    wait 0.05;
  }

  func_6F92(var_00);
}

func_6F91() {
  self.var_2660 waittill("FX_State_Change0");
  self.var_2660 endon("death");
  func_7D2E(self);
}

func_6F92(param_00) {
  param_00 method_81DF(1);
  wait 0.05;
  param_00 method_81DF(0);
  wait(0.1);
  param_00 method_81DF(1);
  wait 0.05;
  param_00 method_81DF(0);
  wait(0.1);
  param_00 method_81DF(1);
}

func_3A1E(param_00) {
  var_01 = 0;
  var_02 = 20000;
  var_03 = 1;
  if(isDefined(self.speed)) {
    var_03 = self.speed;
  }

  if(param_00 == "slow") {
    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "lockedspeed") {
      var_01 = 180;
    } else {
      var_01 = randomfloatrange(100 * var_03, 360 * var_03);
    }
  } else if(param_00 == "fast") {
    var_01 = randomfloatrange(720 * var_03, 1000 * var_03);
  } else if(param_00 == "veryslow") {
    var_01 = randomfloatrange(1 * var_03, 2 * var_03);
  } else {}

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "lockedspeed") {
    wait(0);
  } else {
    wait(randomfloatrange(0, 1));
  }

  if(!isDefined(self)) {
    return;
  }

  var_04 = self.angles;
  var_05 = anglestoright(self.angles) * 100;
  var_05 = vectorNormalize(var_05);
  for(;;) {
    var_06 = abs(vectordot(var_05, (1, 0, 0)));
    var_07 = abs(vectordot(var_05, (0, 1, 0)));
    var_08 = abs(vectordot(var_05, (0, 0, 1)));
    if(var_06 > 0.9) {
      self rotatevelocity((var_01, 0, 0), var_02);
    } else if(var_07 > 0.9) {
      self rotatevelocity((var_01, 0, 0), var_02);
    } else if(var_08 > 0.9) {
      self rotatevelocity((0, var_01, 0), var_02);
    } else {
      self rotatevelocity((0, var_01, 0), var_02);
    }

    wait(var_02);
  }
}

func_9DC3(param_00, param_01) {
  level endon("game_ended");
  self endon("deleted");
  self.var_37D8 = self getentitynumber();
  for(;;) {
    self waittill("trigger", var_02);
    if(!isPlayer(var_02) && !isDefined(var_02.var_3BAA)) {
      continue;
    }

    if(!isalive(var_02)) {
      continue;
    }

    if(isDefined(var_02.var_9AC5) && !isDefined(var_02.var_9AC5[self.var_37D8])) {
      var_02 thread func_7477(self, param_00, param_01);
    }
  }
}

func_7477(param_00, param_01, param_02) {
  param_00 endon("deleted");
  if(!isPlayer(self)) {
    self endon("death");
  }

  if(!common_scripts\utility::issp()) {
    var_03 = self.guid;
  } else {
    var_03 = "player" + gettime();
  }

  param_00.var_9AC3[var_03] = self;
  if(isDefined(param_00.var_64DD)) {
    self.var_64DE++;
  }

  param_00 notify("trigger_enter", self);
  self notify("trigger_enter", param_00);
  if(isDefined(param_01)) {
    self thread[[param_01]](param_00);
  }

  self.var_9AC5[param_00.var_37D8] = param_00;
  while(isalive(self) && self istouching(param_00) && common_scripts\utility::issp() || !level.gameended) {
    wait 0.05;
  }

  if(isDefined(self)) {
    self.var_9AC5[param_00.var_37D8] = undefined;
    if(isDefined(param_00.var_64DD)) {
      self.var_64DE--;
    }

    self notify("trigger_leave", param_00);
    if(isDefined(param_02)) {
      self thread[[param_02]](param_00);
    }
  }

  if(!common_scripts\utility::issp() && level.gameended) {
    return;
  }

  param_00.var_9AC3[var_03] = undefined;
  param_00 notify("trigger_leave", self);
  if(!func_0F13(param_00)) {
    param_00 notify("trigger_empty");
  }
}

func_64B5() {
  if(isDefined(level.var_2F91)) {
    return;
  }

  self endon("disconnect");
  if(!isPlayer(self)) {
    self endon("death");
  }

  self.var_64DE = 0;
  self.var_3040 = 0;
  for(;;) {
    self waittill("trigger_enter");
    var_00 = self.origin;
    while(self.var_64DE) {
      self.var_3040 = distance(var_00, self.origin);
      var_00 = self.origin;
      wait 0.05;
    }

    self.var_3040 = 0;
  }
}

func_0F13(param_00) {
  return param_00.var_9AC3.size;
}

func_7476(param_00, param_01) {
  return isDefined(param_00.var_9AC5[param_01.var_37D8]);
}

func_5409() {
  var_00 = getEntArray("interactive_tv", "targetname");
  if(var_00.size) {
    common_scripts\utility::func_6753(["com_tv2_d", "com_tv1_d", "com_tv1", "com_tv2", "com_tv1_testpattern", "com_tv2_testpattern"], ::precachemodel);
    level.var_1BB0["tv_explode"] = loadfx("vfx/test/test_fx");
  }

  level.var_9FB8 = getEntArray("interactive_tv_light", "targetname");
  common_scripts\utility::array_thread(getEntArray("interactive_tv", "targetname"), ::func_9FB9);
}

func_9FB9() {
  self setCanDamage(1);
  self.var_29D1 = undefined;
  self.var_6A14 = undefined;
  self.var_29D1 = "com_tv2_d";
  self.var_6A14 = "com_tv2";
  self.var_6B58 = "com_tv2_testpattern";
  if(issubstr(self.model, "1")) {
    self.var_6A14 = "com_tv1";
    self.var_6B58 = "com_tv1_testpattern";
  }

  if(isDefined(self.target)) {
    if(isDefined(level.var_2F49)) {
      var_00 = getEnt(self.target, "targetname");
      if(isDefined(var_00)) {
        var_00 delete();
      }
    } else {
      self.var_A241 = getEnt(self.target, "targetname");
      self.var_A241 useTriggerRequireLookAt();
      self.var_A241 setCursorHint("HINT_NOICON");
    }
  }

  var_01 = common_scripts\utility::func_40B0(self.origin, level.var_9FB8, undefined, undefined, 64);
  if(var_01.size) {
    self.var_5DD4 = var_01[0];
    level.var_9FB8 = common_scripts\utility::func_F93(level.var_9FB8, self.var_5DD4);
    self.var_5DD6 = self.var_5DD4 method_81DE();
  }

  thread func_9FB7();
  if(isDefined(self.var_A241)) {
    thread func_9FBA();
  }
}

func_9FBA() {
  self.var_A241 endon("death");
  for(;;) {
    wait(0.2);
    self.var_A241 waittill("trigger");
    self notify("off");
    if(self.model == self.var_6A14) {
      self setModel(self.var_6B58);
      if(isDefined(self.var_5DD4)) {
        self.var_5DD4 method_81DF(self.var_5DD6);
      }

      continue;
    }

    self setModel(self.var_6A14);
    if(isDefined(self.var_5DD4)) {
      self.var_5DD4 method_81DF(0);
    }
  }
}

func_9FB7() {
  self waittill("damage", var_00, var_01, var_02, var_03, var_04);
  self notify("off");
  if(isDefined(self.var_A241)) {
    self.var_A241 notify("death");
  }

  self setModel(self.var_29D1);
  if(isDefined(self.var_5DD4)) {
    self.var_5DD4 method_81DF(0);
  }

  playFXOnTag(level.var_1BB0["tv_explode"], self, "tag_fx");
  self playSound("tv_shot_burst");
  if(isDefined(self.var_A241)) {
    self.var_A241 delete();
  }
}

func_8CA1() {
  if(!isDefined(self.var_6BF5)) {
    self.var_6BF5 = 1;
  }

  var_00 = getEntArray(self.target, "script_linkname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(var_03.classname == "script_origin") {
      var_01[var_01.size] = var_03;
      continue;
    }

    var_03 func_3265(self.var_6BF5);
  }

  var_00 = common_scripts\utility::func_F94(var_00, var_01);
  for(;;) {
    if(!isDefined(function_02D1())) {
      wait(1);
      continue;
    }

    var_05 = vehicle_getarray();
    var_06 = common_scripts\utility::func_F73(function_02D1(), var_05);
    var_07 = 0;
    foreach(var_09 in var_06) {
      if((isDefined(var_09.team) && var_09.team == "spectator") || isDefined(var_09.sessionstate) && var_09.sessionstate == "spectator") {
        continue;
      }

      if(var_09 istouching(self)) {
        var_07++;
        break;
      }
    }

    if(var_07 > 0) {
      func_6BE2(var_00);
    } else {
      var_0B = 1;
      thread func_2430(var_00, var_0B);
    }

    wait 0.05;
  }
}

func_3265(param_00) {
  self.var_926A = self.origin;
  self.var_8CA2 = "closed";
  var_01 = getEnt(self.target, "targetname");
  self.var_6BF3 = var_01.origin;
  self.var_6BF8 = distance(self.var_6BF3, self.origin) / param_00;
}

func_6BE2(param_00) {
  foreach(var_02 in param_00) {
    if(var_02.var_8CA2 == "open" || var_02.var_8CA2 == "opening") {
      continue;
    }

    var_02 thread func_6BE8();
  }
}

func_6BE8() {
  self.var_8CA2 = "opening";
  var_00 = distance(self.origin, self.var_6BF3) / self.var_6BF8;
  if(var_00 < 0.05) {
    var_00 = 0.05;
  }

  self moveTo(self.var_6BF3, var_00);
  self playSound("glass_door_open");
  wait(var_00);
  self.var_8CA2 = "open";
}

func_2430(param_00, param_01) {
  foreach(var_03 in param_00) {
    if(var_03.var_8CA2 == "closed" || var_03.var_8CA2 == "opening") {
      continue;
    }

    var_03 moveTo(var_03.var_926A, param_01);
    self playSound("glass_door_close");
    var_03.var_8CA2 = "closed";
  }
}