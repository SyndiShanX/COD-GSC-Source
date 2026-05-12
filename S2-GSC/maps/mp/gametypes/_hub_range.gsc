/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hub_range.gsc
*********************************************/

func_52B9() {
  wait 0.05;
  func_8A48();
  level.var_7081 = [];
  spawnStruct();
  level.var_7081[0] = spawnStruct();
  level.var_7081[0].var_9087 = common_scripts\utility::func_46B5("plate_spawn_left", "targetname");
  level.var_7081[0].var_7083 = (2000, 0, 1500);
  level.var_7081[1] = spawnStruct();
  level.var_7081[1].var_9087 = common_scripts\utility::func_46B5("plate_spawn_mid", "targetname");
  level.var_7081[1].var_7083 = (2000, 300, 1500);
  level.var_7081[2] = spawnStruct();
  level.var_7081[2].var_9087 = common_scripts\utility::func_46B5("plate_spawn_right", "targetname");
  level.var_7081[2].var_7083 = (2000, 600, 1500);
  level.var_3C40 = getent("trigger_firing_range", "targetname");
  if(!isDefined(level.var_3C40)) {
    return;
  }

  level.var_3C40 thread maps\mp\_dynamic_world::func_9DC3(::func_37BD, ::func_38F2);
  level.var_3C3F = common_scripts\utility::func_46B7("firingrange_spawn", "targetname");
  level.var_4B13 = common_scripts\utility::func_46B5("fireworks_start", "targetname");
  level.var_4871 = loadfx("vfx/map/mp_hub/hub_grenade_toss_reward_exp");
  level.var_707F = 0;
  level.var_9B6B = 0;
  level.var_83EC = [];
  level.var_83EC["melon"] = [];
  level.var_83EC["tower"] = [];
  level.var_83EC["plate"] = [];
  setdvarifuninitialized("hub_complete_sequence_easy", 0);
  setdvarifuninitialized("hub_complete_sequence_medium", 0);
  setdvarifuninitialized("hub_complete_sequence_hard", 0);
  setdvarifuninitialized("hub_start_civ_sequence", 0);
  setdvarifuninitialized("hub_start_plate_sequence", 0);
  setdvarifuninitialized("hub_launch_test_plate", 0);
  if(function_03AE() == 0) {
    thread func_63DF("hub_complete_sequence_easy", ::func_36E9);
    thread func_63DF("hub_complete_sequence_medium", ::func_74C5);
    thread func_63DF("hub_complete_sequence_hard", ::func_74A7);
    thread func_63DF("hub_start_civ_sequence", ::func_4AFF);
    thread func_63DF("hub_start_plate_sequence", ::func_5C2C);
    thread func_63DF("hub_launch_test_plate", ::func_5C2E);
  }

  while(!isDefined(level.var_4F51)) {
    wait(1);
  }

  level.var_3C3E = getent("firing_range_icon", "targetname");
  level.var_3C3E.var_50DA = 1;
  level.var_4F51[level.var_4F51.size] = level.var_3C3E;
}

func_63DF(param_00, param_01) {
  level endon("game_ended");
  while(getdvarint(param_00, 0) == 0) {
    wait(1);
  }

  if(function_030D(param_01)) {
    playFX(param_01, level.var_4B13.var_0116);
  } else {
    thread[[param_01]]();
  }

  setDvar(param_00, 0);
  thread func_63DF(param_00, param_01);
}

func_37BD(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  if(function_03AE() == 1 && self.var_5721 == 1) {
    return;
  }

  if(self getclientomnvar("ui_hub_in_1v1") != 0) {
    return;
  }

  if(level.var_4F50 && isDefined(self.var_9FB4) && self.var_9FB4 < 4) {
    return;
  }

  var_01 = 0;
  self notify("force_cancel_placement");
  self.previousweaponcharmguid = 0;
  if((!maps\mp\gametypes\_hub_unk1::func_5790(var_01) || self playerisweaponplantenabled() || self.var_572F) && !function_02A3() || getdvarint("spv_hub_firingrange_kswitch", 1) == 0) {
    self.var_5721 = 1;
    self setclientomnvar("ui_hub_is_preoccupied", 1);
    if(self.var_56A4) {
      if(isDefined(self.var_155F)) {
        self.var_155F maps\mp\gametypes\_hub_unk1::func_1543((0, 0, 80), self);
      }
    }

    maps\mp\gametypes\_hub_unk1::func_2FA2();
    self method_85C8();
    self setclientomnvar("ui_hide_1v1scores", 0);
    self setclientomnvar("ui_hub_in_firingrange", 1);
    self.var_542B = 0;
    var_02 = 0;
    if(isDefined(self.var_3C3D)) {
      var_02 = self.var_3C3D;
    }

    self.var_3C3D = 0;
    if(isDefined(self.var_572F) && self.var_572F) {
      maps\mp\gametypes\_division_change::func_A050();
      maps\mp\_utility::func_05E4();
      maps\mp\_utility::func_47A2("specialty_falldamage");
      self takeallweapons();
      maps\mp\_utility::func_0642(self.var_8B27);
      thread maps\mp\_riotshield::func_9BC6();
      self switchtoweaponimmediate(self.var_8B27);
      if(issubstr(self.var_8B27, "shovel")) {
        self method_8349("throwingknife_mp");
        self giveweapon("throwingknife_mp");
      }

      self method_8326();
      self.var_8B25 = 0;
    } else {
      if(!var_02) {
        func_9A80(1);
      }

      if(isDefined(param_00) && !var_02) {
        self.var_294D = maps\mp\gametypes\_class::func_1E05();
      }

      self freezecontrols(0);
      thread func_478B(var_02);
      self method_8327();
      if(function_0367()) {
        thread func_9824();
        thread targethitsequence();
      }
    }

    thread func_47A9();
    if(function_0367()) {
      maps\mp\gametypes\_hub_unk1::func_7D1D(0);
    }

    if(self.var_572F) {
      self method_812B(self getclientomnvar("ui_hub_in_shootout") && self getclientomnvar("ui_hub_shootout_intro_countdown") == 0);
    } else {
      self method_812B(1);
    }

    self method_8114(1);
    self method_85BE(1);
    self method_85BF(1);
    self setdemigod(1);
    self setstance("stand");
    self method_85B4();
    self method_8036(1, 0);
    return;
  }

  if(maps\mp\gametypes\_hub_unk1::func_5790(var_02) && (!function_02A3() || getdvarint("spv_hub_firingrange_kswitch", 1) == 0) && !self.var_5721) {
    thread func_A786();
  }
}

func_A786() {
  self endon("disconnect");
  self endon("leftFiringRange");
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(0.5);
    if(!maps\mp\gametypes\_hub_unk1::func_5790()) {
      break;
    }
  }

  func_37BD();
}

func_8C70() {
  level endon("game_ended");
  if(!isDefined(level.var_7080)) {
    return;
  }

  level.var_6898 = 0;
  for(;;) {
    level.var_7082 waittill("trigger", var_00);
    if(level.var_6898 >= 10) {
      continue;
    }

    var_01 = spawn("script_model", level.var_7080.var_0116);
    var_01 setModel("hub_water_basin_enamel_01_white_dirty");
    var_01 setCanDamage(1);
    var_01 setdamagecallbackon(1);
    var_01.var_29B5 = ::func_2DD8;
    level.var_6898++;
    var_01 physicslaunchserver(var_01.var_0116, (4000, 0, 3000));
    var_01 thread func_2DD0();
  }
}

func_2F9A() {
  self endon("death");
  self endon("disconnect");
  wait(getdvarfloat("3993", 0.5));
  func_9A80(0);
}

func_9A80(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  if(param_00) {
    thread func_A8FC();
    var_03 = common_scripts\utility::func_44F5("divisions_bayonet_charge");
    playfxontagforclients(var_03, self, "j_head", self);
    self setscriptmotionblurparams(1, 0, 1);
    var_01["intensity"] = 0.3;
    var_01["falloff"] = 1.2;
    var_01["scaleX"] = 1;
    var_01["scaleY"] = 1;
    var_01["squareAspectRatio"] = 0;
    var_01["lerpDuration"] = 0.4;
    if(isDefined(var_01)) {
      self vignettesetparams(var_01["intensity"], var_01["falloff"], var_01["scaleX"], var_01["scaleY"], var_01["squareAspectRatio"], var_01["lerpDuration"]);
      return;
    }

    return;
  }

  self notify("removeRangeTransitionEffect");
  var_03 = common_scripts\utility::func_44F5("divisions_bayonet_charge");
  function_0295(var_03, self, "j_head", self);
  if(isDefined(level.var_A4B5)) {
    var_01 = level.var_A4B5;
  }

  if(isDefined(var_01) && !isDefined(var_01["lerpDuration"])) {
    var_01["lerpDuration"] = 0.1;
  }

  if(isDefined(var_01)) {
    self vignettesetparams(var_01["intensity"], var_01["falloff"], var_01["scaleX"], var_01["scaleY"], var_01["squareAspectRatio"], var_01["lerpDuration"]);
  }

  if(isDefined(level.var_6465)) {
    var_02 = level.var_6465;
  }

  if(isDefined(var_02)) {
    self setscriptmotionblurparams(var_02["velocityscaler"], var_02["cameraRotationInfluence"], var_02["cameraTranslationInfluence"]);
    return;
  }

  self setscriptmotionblurparams(0, 0, 0);
}

func_A8FC() {
  self endon("disconnect");
  self endon("removeRangeTransitionEffect");
  self waittill("death");
  thread func_9A80(0);
}

func_38F2(param_00) {
  if(function_03AE() == 0) {
    if(common_scripts\_plant_weapon::func_5855()) {
      self notify("weaponPlantFiringRange");
      wait 0.05;
    }

    if(isDefined(self.var_5721) && self.var_5721) {
      func_9A80(1);
      self.var_5721 = 0;
      self setclientomnvar("ui_hub_is_preoccupied", 0);
      self.var_542B = 1;
      self method_85C7();
      self setclientomnvar("ui_hide_1v1scores", 1);
      self visionsetnakedforplayer("", 0);
      self.var_294D = maps\mp\gametypes\_class::func_1E05();
      maps\mp\gametypes\_hub_unk3::func_A594("custom" + self.var_294D + 1, 0);
      maps\mp\gametypes\_class::func_1FA2(common_scripts\utility::func_46AF());
      maps\mp\gametypes\_hub_unk1::func_3663();
      self setdemigod(0);
      if(self getstance() == "prone") {
        self method_8113(1);
        self setstance("crouch");
      }

      self method_8114(0);
      maps\mp\gametypes\_hub_unk1::func_7446();
      thread func_2F9A();
      if(self.var_572F) {
        if(isDefined(self.var_8B24)) {
          self.var_8B24 thread func_4B07("win");
        }

        thread func_4B07("loss", 1, 1);
        self notify("quit_shootout");
      }
    }

    self notify("leftFiringRange");
    self setclientomnvar("ui_hub_in_firingrange", 0);
    if(function_0367()) {
      maps\mp\gametypes\_hub_unk1::func_7E4E(0);
    }

    if(function_0367() && isDefined(self.var_1E23) && !self.var_572F) {
      if(self.var_1E23 > 0) {
        maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubFiringRangeStats", "hubTargetsShot"], self.var_1E23, undefined, undefined);
        self.var_1E23 = 0;
        return;
      }
    }
  }
}

func_8A28() {
  level.var_595A = getEntArray("jerry_can_spawn", "targetname");
  if(level.var_595A.size == 0) {
    return;
  }

  foreach(var_01 in level.var_595A) {
    func_9074(var_01.var_0116);
  }
}

func_9074(param_00) {
  var_01 = spawn("script_model", param_00);
  var_01.var_001D = (0, 90, 0);
  var_01 setCanDamage(1);
  var_01 setdamagecallbackon(1);
  var_01.var_29B5 = ::func_63A1;
}

func_8A48() {
  level.var_7AB6 = getEntArray("reactive_swing_target", "targetname");
  level.var_7AB5 = getEntArray("reactive_reset_target", "targetname");
  level.var_7AB3 = getEntArray("flip_target", "targetname");
  level.var_7AB2 = getEntArray("flip_target_reset", "targetname");
  level.var_7AB4 = getEntArray("popup_target", "targetname");
  var_00 = common_scripts\utility::func_46B5("sequence_area", "targetname");
  level.var_83EF = [];
  level.var_83EE = 0;
  level.var_83ED = common_scripts\utility::func_46B5("sequence_reward_spawn", "targetname");
  var_01 = getEntArray("plate_sequence", "targetname");
  level.var_707E = [];
  level.var_9B6E = [];
  level.var_9B6C = [];
  level.var_9B6C[0] = "blue";
  level.var_7AB1 = getEntArray("reactive_explosive_target", "targetname");
  level.var_6894 = 0;
  foreach(var_03 in level.var_7AB6) {
    var_03 setCanDamage(1);
    var_03 setdamagecallbackon(1);
    var_03.var_99F1 = 0;
    var_03.var_29B5 = ::func_63D4;
    var_03.var_4DC9 = 0;
    var_03.var_001D = (0, 180, 90);
    if(isDefined(var_03.var_0165) && var_03.var_0165 == "tower") {
      var_03.var_8C3A = "blue";
      level.var_9B6E = common_scripts\utility::func_0F6F(level.var_9B6E, var_03);
      var_03.var_7546 = 3;
    }
  }

  foreach(var_03 in level.var_7AB5) {
    var_03 setCanDamage(1);
    var_03 setdamagecallbackon(1);
    var_03.var_29B5 = ::func_63D3;
    var_03.var_4DC9 = 0;
    var_03.var_00BC = 99;
    if(isDefined(var_03.var_0165)) {
      if(var_03.var_0165 == "human_no_sequence") {
        var_03.var_001D = (0, 0, 0);
      } else {
        var_03.var_001D = (90, 0, 0);
      }
    }

    if(isDefined(var_03.var_0165) && var_03.var_0165 == "tower_right") {
      level.var_9B6C["blue"] = var_03;
      var_03.var_7546 = 5;
      continue;
    }

    if(isDefined(var_03.var_0165) && var_03.var_0165 == "tower_left") {
      level.var_9B6C["orange"] = var_03;
      var_03.var_7546 = 5;
    }
  }

  foreach(var_03 in level.var_7AB2) {
    var_03 setCanDamage(1);
    var_03 setdamagecallbackon(1);
    var_03.var_29B5 = ::func_63D1;
    var_03.var_3D77 = [];
    var_08 = function_01AC(level.var_7AB3, var_03.var_0116);
    for(var_09 = 0; var_09 < 3; var_09++) {
      var_03.var_3D77[var_09] = var_08[var_09];
    }
  }

  foreach(var_03 in level.var_7AB3) {
    var_03 setCanDamage(1);
    var_03 setdamagecallbackon(1);
    var_03.var_29B5 = ::func_63D0;
    var_03.var_4DC9 = 0;
    var_03.var_7584 = "down";
    var_03.var_001D = (0, 0, 0);
  }

  foreach(var_03 in level.var_7AB4) {
    var_03 setCanDamage(1);
    var_03 setdamagecallbackon(1);
    var_03.var_29B5 = ::func_63D2;
    var_03.var_4DC9 = 0;
    var_03.var_001D = (-90, 0, 0);
    var_03.var_7546 = 2;
  }

  foreach(var_10 in var_01) {
    var_10.var_6C53 = var_10.var_0116;
    if(int(var_10.var_0165) == 1) {
      func_906D(var_10);
    } else {
      var_10 movey(250, 0.1);
    }

    if(!isDefined(level.var_707E[int(var_10.var_0165)])) {
      level.var_707E[int(var_10.var_0165)] = [];
    }

    level.var_707E[int(var_10.var_0165)] = common_scripts\utility::func_0F6F(level.var_707E[int(var_10.var_0165)], var_10);
  }

  foreach(var_03 in level.var_7AB1) {
    var_03 setCanDamage(1);
    var_03 setdamagecallbackon(1);
    var_03.var_29B5 = ::func_638E;
  }

  if(level.var_7AB3.size == 0 || !isDefined(var_00)) {
    return;
  }

  var_08 = function_01AC(level.var_7AB3, var_00.var_0116);
  for(var_09 = 0; var_09 < 6; var_09++) {
    level.var_83EF[1][var_09] = var_08[var_09];
  }

  for(var_09 = 9; var_09 < var_08.size; var_09++) {
    var_08[var_09].var_7546 = 4;
  }

  var_08 = function_01AC(level.var_7AB6, var_00.var_0116);
  for(var_09 = 0; var_09 < 5; var_09++) {
    level.var_83EF[2][var_09] = var_08[var_09];
    var_08[var_09].var_7546 = 2;
  }

  foreach(var_03 in level.var_7AB4) {
    level.var_83EF[2] = common_scripts\utility::func_0F6F(level.var_83EF[2], var_03);
  }

  var_08 = function_01AC(level.var_7AB5, var_00.var_0116);
  for(var_09 = 0; var_09 < 2; var_09++) {
    level.var_83EF[3][var_09] = var_08[var_09];
    level.var_83EF[3][var_09] setCanDamage(0);
  }

  var_08[1].var_7546 = 2;
}

func_906D(param_00) {
  if(isDefined(param_00)) {
    var_01 = spawn("script_model", param_00.var_0116 - (0, 0, 55));
    var_01 setModel("Hub_range_target_human_01");
    var_01.var_001D = (0, 0, 0);
    var_01 setCanDamage(1);
    var_01 setdamagecallbackon(1);
    var_01.var_00BC = 99;
    var_01.var_29B5 = ::func_639A;
    var_01.var_707D = param_00;
    param_00.var_4B11 = var_01;
    param_00.var_4B81 = 1;
    var_01 linkto(param_00);
  }
}

func_639A(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(level.var_4B14)) {
    level.var_4B14 = 0;
  }

  self.var_00BC = self.var_00BC - param_02;
  if(self.var_00BC > 0) {
    if(isPlayer(param_01)) {
      param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
      playFX(level.var_AA65, param_06);
      if(isDefined(param_01.var_8B25)) {
        param_01 thread func_8B26(self, 1);
      }
    }

    return;
  }

  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("killshot_nosound");
  }

  param_01 thread maps\mp\gametypes\_missions::func_7750("ch_hq_firingrange");
  var_0C = playclientsound("mp_hub_allies_frange_wood_shot", undefined, self.var_0116);
  playFX(level.var_AA66, self.var_0116);
  if(!isDefined(common_scripts\utility::func_0F7E(level.var_83EC["plate"], param_01))) {
    level.var_83EC["plate"][level.var_83EC["plate"].size] = param_01;
  }

  if(isPlayer(param_01) && isDefined(param_01.var_8B25)) {
    param_01 thread func_8B26(self);
  }

  self delete();
  if(!isDefined(self.var_707D)) {
    return;
  }

  self.var_707D.var_4B81 = 0;
  var_0D = 1;
  foreach(var_0F in level.var_707E[int(self.var_707D.var_0165)]) {
    if(var_0F.var_4B81) {
      var_0D = 0;
      break;
    }
  }

  if(var_0D) {
    foreach(var_0F in level.var_707E[int(self.var_707D.var_0165)]) {
      var_0F movey(250, 1);
    }

    if(level.var_4B14 == 0) {
      level.var_4B14 = gettime() / 1000;
    }

    var_13 = gettime() / 1000 - level.var_4B14;
    if(var_13 > level.var_707E[int(self.var_707D.var_0165)].size * 2.5) {
      var_14 = 1;
      level.var_4B14 = 0;
      level.var_83EC["plate"] = [];
    } else if(int(self.var_707D.var_0165) == 4) {
      var_14 = 1;
      level.var_4B14 = 0;
      level.var_707F = 0;
      thread func_5C2C();
    } else {
      var_14 = int(self.var_707D.var_0165) + 1;
      level.var_4B14 = gettime() / 1000;
    }

    foreach(var_0F in level.var_707E[var_14]) {
      func_906D(var_0F);
      var_0F moveto(var_0F.var_6C53, 1);
    }
  }
}

func_5C2E() {
  var_00 = spawn("script_model", level.var_7081[0].var_9087.var_0116 + (0, 0, 10));
  var_00 setModel("hub_range_target_clay_01");
  var_00 physicslaunchserver(var_00.var_0116, level.var_7081[0].var_7083);
  wait(1.5);
  playFX(level.var_707C, var_00.var_0116);
  var_00 delete();
}

func_5C2C(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 3;
  }

  if(isDefined(level.var_7081) && level.var_7081.size >= param_00) {
    func_5C2B(1);
  }
}

func_5C2B(param_00) {
  var_01 = common_scripts\utility::func_0F92(level.var_7081);
  for(var_02 = 0; var_02 < param_00; var_02++) {
    var_03 = spawn("script_model", var_01[var_02].var_9087.var_0116 + (0, 0, 10));
    var_03 setModel("hub_range_target_clay_01");
    var_03 setCanDamage(1);
    var_03 setdamagecallbackon(1);
    var_03.var_29B5 = ::func_2DD9;
    var_03.var_A985 = param_00;
    var_03 physicslaunchserver(var_03.var_0116, var_01[var_02].var_7083);
    var_03 thread func_2DD0();
  }
}

func_2DD9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!function_0367()) {
    return;
  }

  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("killshot_nosound");
  }

  if(!isDefined(level.var_4B13)) {
    level.var_4B13 = common_scripts\utility::func_46B5("fireworks_start", "targetname");
  }

  if(isPlayer(param_01) && isDefined(param_01.var_8B25)) {
    param_01 thread func_8B26(self, 30);
  }

  if(!isDefined(common_scripts\utility::func_0F7E(level.var_83EC["plate"], param_01))) {
    level.var_83EC["plate"][level.var_83EC["plate"].size] = param_01;
  }

  if(isDefined(level.var_707C)) {
    playFX(level.var_707C, self.var_0116);
  }

  self delete();
  level.var_707F++;
  if(level.var_707F < self.var_A985) {
    return;
  }

  level.var_707F = 0;
  if(self.var_A985 < 3) {
    thread func_5C2B(self.var_A985 + 1);
    return;
  }

  if(function_03AE() == 0) {
    foreach(var_0D in level.var_744A) {
      if(isDefined(common_scripts\utility::func_0F7E(level.var_83EC["plate"], var_0D))) {
        var_0D iclientprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_HELPED");
        var_0D lib_0468::func_0A20("completedSequence");
        var_0D thread func_21E4("plate");
        continue;
      }

      var_0D iclientprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_NO_HELP");
    }

    thread func_74A7();
    level.var_83EC["plate"] = [];
  }
}

func_63A1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isPlayer(param_00)) {
    self method_8617("mp_hub_jerry_can_explode");
    if(isDefined(level.var_5959)) {
      playFX(level.var_5959, self.var_0116);
    }

    self setCanDamage(0);
    self setdamagecallbackon(0);
    self method_82C5(self.var_0116, (0, 0, 200000));
    wait(8);
    thread func_9074(self.var_0116);
    self delete();
  }
}

func_63D4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(gettime() / 1000 < self.var_99F1 + 0.5) {
    return;
  }

  var_0C = playclientsound("mp_hub_allies_frange_dist_metal_shot", undefined, self.var_0116);
  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
    param_01 notify("hitFRTarget");
  }

  self.var_99F1 = gettime() / 1000;
  param_01 thread maps\mp\gametypes\_missions::func_7750("ch_hq_firingrange");
  var_0D = common_scripts\utility::func_0F7E(level.var_83EF[2], self);
  if(isDefined(var_0D) && self.var_4DC9) {
    return;
  }

  if(self.var_001D[1] < 90) {
    self rotateto((self.var_001D[0], 180, self.var_001D[2]), 0.5);
    self.var_4DC9 = 1;
    self.var_8C3A = "blue";
  } else if(self.var_001D[1] > 90) {
    self rotateto((self.var_001D[0], -0.0001, self.var_001D[2]), 0.5);
    self.var_4DC9 = 0;
    self.var_8C3A = "orange";
  }

  if(level.var_83EE && isDefined(var_0D)) {
    func_21F0(2, param_01);
  }

  if(isDefined(self.var_0165) && self.var_0165 == "tower") {
    var_0E = 1;
    if(level.var_9B6C[0] == "blue") {
      foreach(var_10 in level.var_9B6E) {
        if(var_10.var_8C3A == "blue") {
          var_0E = 0;
          break;
        }
      }

      if(var_0E) {
        level.var_9B6C[0] = "orange";
      }
    } else {
      foreach(var_10 in level.var_9B6E) {
        if(var_10.var_8C3A == "orange") {
          var_0E = 0;
          break;
        }
      }

      if(var_0E) {
        level.var_9B6C[0] = "blue";
      }
    }

    if(!isDefined(common_scripts\utility::func_0F7E(level.var_83EC["tower"], param_01))) {
      level.var_83EC["tower"][level.var_83EC["tower"].size] = param_01;
    }

    if(var_0E) {
      level.var_9B6C["orange"] rotateto((0, 0, 0), 0.3);
      level.var_9B6C["orange"] setCanDamage(1);
      level.var_9B6C["orange"].var_00BC = 99;
      level.var_9B6C["orange"].var_4DC9 = 0;
      level.var_9B6C["blue"] rotateto((0, 0, 0), 0.3);
      level.var_9B6C["blue"] setCanDamage(1);
      level.var_9B6C["blue"].var_00BC = 99;
      level.var_9B6C["blue"].var_4DC9 = 0;
      level.var_9B6F = gettime() / 1000;
      level.var_9B6B = 0;
    }
  }

  if(isPlayer(param_02)) {
    param_02 notify("hitFRDestroyed", self);
  }

  if(isPlayer(param_02) && isDefined(param_02.var_8B25)) {
    param_02 thread func_8B26(self);
  }
}

func_63D3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self.var_00BC = self.var_00BC - param_02;
  if(self.var_00BC > 0) {
    if(isPlayer(param_01)) {
      param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
      playFX(level.var_AA65, param_06);
      if(isDefined(param_01.var_8B25)) {
        param_01 thread func_8B26(self, 1);
      }
    }

    return;
  }

  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("killshot_nosound");
  }

  param_01 thread maps\mp\gametypes\_missions::func_7750("ch_hq_firingrange");
  var_0C = playclientsound("mp_hub_allies_frange_wood_shot", undefined, self.var_0116);
  self rotateto((90, 0, 0), 0.2);
  self.var_4DC9 = 1;
  self setCanDamage(0);
  if(!isDefined(self.var_572E)) {
    if(isDefined(common_scripts\utility::func_0F7E(level.var_83EF[3], self))) {
      self.var_572E = 1;
    } else {
      self.var_572E = 0;
    }
  }

  if(isPlayer(param_01) && isDefined(param_01.var_8B25)) {
    param_01 thread func_8B26(self);
  }

  if(isDefined(self.var_0165)) {
    if(self.var_0165 == "tower_left" || self.var_0165 == "tower_right") {
      level.var_9B6B++;
      if(level.var_9B6B == 2) {
        if(gettime() / 1000 - level.var_9B6F < 5) {
          func_4AFF();
          return;
        }

        level.var_83EC["tower"] = [];
        return;
      }

      return;
    }

    wait(2);
    self rotateto((0, 0, 0), 0.2);
    self.var_4DC9 = 0;
    self setCanDamage(1);
    self.var_00BC = 99;
    return;
  }

  if(self.var_572E) {
    if(level.var_83EE) {
      func_21F0(3, param_01);
      return;
    }
  }
}

func_4AFF() {
  level endon("game_ended");
  if(!isDefined(level.var_22FF)) {
    level.var_22FF = common_scripts\utility::func_46B5("civ_event_start", "targetname");
  }

  if(!isDefined(level.var_22FD)) {
    level.var_22FD = common_scripts\utility::func_46B5("civ_event_end", "targetname");
  }

  if(!isDefined(level.var_22FF) || !isDefined(level.var_22FD)) {
    return;
  }

  level.var_22FE = 0;
  var_00 = randomint(3) + 1;
  switch (var_00) {
    case 1:
      var_01 = (0, -50, -10);
      var_02 = (0, 0, -10);
      var_03 = (0, 50, -10);
      break;

    case 2:
      var_01 = (0, 0, -10);
      var_02 = (0, -50, -10);
      var_03 = (0, 50, -10);
      break;

    case 3:
      var_01 = (0, 50, -10);
      var_02 = (0, -50, -10);
      var_03 = (0, 0, -10);
      break;

    default:
      var_01 = (0, 0, -10);
      var_02 = (0, -50, -10);
      var_03 = (0, 50, -10);
      break;
  }

  var_04 = spawn("script_model", level.var_22FF.var_0116 + var_02);
  var_04.var_001D = (90, 0, 0);
  var_04 setModel("Hub_range_target_human_01");
  var_04 setCanDamage(1);
  var_04 setdamagecallbackon(1);
  var_04.var_4E00 = 1;
  var_04.var_00BC = 99;
  var_04.var_29B5 = ::func_636F;
  var_05 = spawn("script_model", level.var_22FF.var_0116 + var_03);
  var_05.var_001D = (90, 0, 0);
  var_05 setModel("Hub_range_target_human_01");
  var_05 setCanDamage(1);
  var_05 setdamagecallbackon(1);
  var_05.var_4E00 = 1;
  var_05.var_00BC = 99;
  var_05.var_29B5 = ::func_636F;
  var_06 = spawn("script_model", level.var_22FF.var_0116 + var_01);
  var_06.var_001D = (90, 0, 0);
  var_06 setModel("hub_range_target_human_03");
  var_06 setCanDamage(1);
  var_06 setdamagecallbackon(1);
  var_06.var_4E00 = 0;
  var_06.var_00BC = 1;
  var_06.var_29B5 = ::func_636F;
  var_04 thread func_64D1(level.var_22FD, 3, var_02);
  var_05 thread func_64D1(level.var_22FD, 3, var_03);
  var_06 thread func_64D1(level.var_22FD, 3, var_01);
  wait(3.5);
  if(!level.var_22FE && function_03AE() == 0) {
    foreach(var_08 in level.var_744A) {
      if(isDefined(common_scripts\utility::func_0F7E(level.var_83EC["tower"], var_08))) {
        var_08 iclientprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_HELPED");
        var_08 lib_0468::func_0A20("completedSequence");
        var_08 thread func_21E4("tower");
        continue;
      }

      var_08 iclientprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_NO_HELP");
    }

    thread func_74C5();
    level.var_83EC["tower"] = [];
  }
}

func_636F(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = self.var_00BC - param_02;
  if(var_0C > 0) {
    self.var_00BC = var_0C;
    if(isPlayer(param_01)) {
      param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
      playFX(level.var_AA65, param_06);
      if(isDefined(param_01.var_8B25)) {
        param_01 thread func_8B26(self, 1);
      }
    }

    return;
  }

  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("killshot_nosound");
    param_01 thread maps\mp\gametypes\_missions::func_7750("ch_hq_firingrange");
    playFX(level.var_AA66, self.var_0116);
    param_01 notify("hitFRTarget");
    param_01 notify("hitFRDestroyed", self);
    level.var_83EC["tower"][level.var_83EC["tower"].size] = param_01;
  }

  if(!self.var_4E00) {
    level.var_22FE = 1;
  }

  if(isPlayer(param_01) && isDefined(param_01.var_8B25)) {
    param_01 thread func_8B26(self);
  }

  self delete();
}

func_64D1(param_00, param_01, param_02) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  self rotateto((0, self.var_001D[1], self.var_001D[2]), 0.5);
  self moveto(param_00.var_0116 + param_02 + (0, 60, -10), param_01);
  wait(param_01);
  self rotateto((90, self.var_001D[1], self.var_001D[2]), 0.5);
  wait(0.5);
  if(self.var_4E00) {
    level.var_22FE = 1;
  }

  self delete();
}

func_63D0(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = playclientsound("mp_hub_allies_frange_dist_metal_shot", undefined, self.var_0116);
  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
    param_01 thread maps\mp\gametypes\_missions::func_7750("ch_hq_firingrange");
    param_01 notify("hitFRTarget");
    param_01 notify("hitFRDestroyed", self);
  }

  if(isPlayer(param_01) && isDefined(param_01.var_8B25) && self.var_7584 == "down") {
    param_01 thread func_8B26(self);
  }

  var_0D = 0;
  if(self.var_7584 == "down") {
    self setCanDamage(0);
    self rotateto((-90, 0, 0), 0.2);
    self.var_4DC9 = 1;
    self.var_7584 = "up";
    var_0D = 1;
  }

  if(!isDefined(self.var_572E)) {
    if(isDefined(common_scripts\utility::func_0F7E(level.var_83EF[1], self))) {
      self.var_572E = 1;
    } else {
      self.var_572E = 0;
    }
  }

  if(!level.var_83EE && self.var_572E) {
    func_9305();
    self.var_4DC9 = 1;
  }

  if(level.var_83EE && isDefined(common_scripts\utility::func_0F7E(level.var_83EF[1], self)) && var_0D) {
    func_21F0(1);
  }
}

func_63D1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = playclientsound("mp_hub_allies_frange_dist_metal_shot", undefined, self.var_0116);
  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
  }

  var_0D = 0;
  foreach(var_0F in self.var_3D77) {
    if(var_0F.var_7584 == "up") {
      var_0F setCanDamage(1);
      var_0F rotateto((0, 0, 0), 0.2);
      var_0F.var_4DC9 = 0;
      var_0F.var_7584 = "down";
      var_0D++;
    }
  }

  if(var_0D == 3) {
    if(isPlayer(param_01) && isDefined(param_01.var_8B25)) {
      param_01 thread func_8B26(self);
    }
  }
}

func_63D2(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = playclientsound("mp_hub_allies_frange_dist_metal_shot", undefined, self.var_0116);
  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
    param_01 notify("hitFRTarget");
    param_01 thread maps\mp\gametypes\_missions::func_7750("ch_hq_firingrange");
  }

  if(isPlayer(param_01) && !self.var_4DC9) {
    param_01 notify("hitFRDestroyed", self);
  }

  if(isPlayer(param_01) && isDefined(param_01.var_8B25) && !self.var_4DC9) {
    param_01 thread func_8B26(self);
  }

  var_0D = 0;
  if(!self.var_4DC9) {
    self rotateto((-90, 0, 0), 0.2);
    self.var_4DC9 = 1;
    var_0D = 1;
  }

  if(level.var_83EE && isDefined(common_scripts\utility::func_0F7E(level.var_83EF[2], self)) && var_0D) {
    func_21F0(2, param_01);
  }
}

func_638E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(param_05 == "frag_grenade_mp" || param_05 == "c4_mp" || param_05 == "semtex_mp") {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
    if(function_0367()) {
      param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubFiringRangeStats", "grenadeBucketHits"], 1, undefined, undefined);
    }

    self method_8617("mp_hub_allies_frange_tire_bomb_swtn");
    if(isDefined(level.var_4871)) {
      playFX(level.var_4871, self.var_0116);
    }

    param_01 lib_0468::func_0A20("grenadeTire");
  }

  if(param_05 == "thermite_mp") {
    if(param_04 == "MOD_EXPLOSIVE") {
      param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
      if(function_0367()) {
        param_01 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubFiringRangeStats", "grenadeBucketHits"], 1, undefined, undefined);
      }

      self method_8617("mp_hub_allies_frange_tire_bomb_swtn");
      if(isDefined(level.var_5959)) {
        playFX(level.var_5959, self.var_0116);
        return;
      }
    }
  }
}

func_9305() {
  level endon("game_ended");
  level.var_83EE = 1;
  foreach(var_01 in level.var_83EF[1]) {
    var_01.var_4DC9 = 0;
  }
}

func_63E0() {
  level endon("game_ended");
  level common_scripts\utility::func_A70A("timeUp", "sequenceComplete");
  level.var_83EE = 0;
}

func_21F0(param_00, param_01) {
  level endon("game_ended");
  if(isDefined(param_01)) {
    if(!isDefined(common_scripts\utility::func_0F7E(level.var_83EC["melon"], param_01))) {
      level.var_83EC["melon"][level.var_83EC["melon"].size] = param_01;
    }
  }

  foreach(var_03 in level.var_83EF[param_00]) {
    if(!var_03.var_4DC9) {
      return;
    }
  }

  switch (param_00) {
    case 1:
      for(var_05 = 0; var_05 < 5; var_05++) {
        level.var_83EF[2][var_05] rotateto((level.var_83EF[2][var_05].var_001D[0], -0.0001, level.var_83EF[2][var_05].var_001D[2]), 0.5);
        level.var_83EF[2][var_05].var_4DC9 = 0;
      }

      for(var_05 = 5; var_05 < 8; var_05++) {
        level.var_83EF[2][var_05] rotateto((180, 0, 0), 0.2);
        level.var_83EF[2][var_05].var_4DC9 = 0;
      }
      break;

    case 2:
      foreach(var_03 in level.var_83EF[3]) {
        var_03 rotateto((0, 0, 0), 0.3);
        var_03 setCanDamage(1);
        var_03.var_4DC9 = 0;
        var_03.var_00BC = 99;
      }
      break;

    case 3:
      param_01 notify("sequenceComplete");
      func_36E9(param_01);
      break;
  }
}

func_36E9(param_00) {
  if(function_03AE() == 1) {
    return;
  }

  thread func_60FE();
  if(!isDefined(level.melonmodel)) {
    level.melonmodel = "Hub_range_watermelon_01";
  }

  for(var_01 = 0; var_01 < 5; var_01++) {
    if(level.var_6894 >= 10) {
      break;
    }

    var_02 = spawn("script_model", level.var_83ED.var_0116);
    var_02 setModel(level.melonmodel);
    var_02 setCanDamage(1);
    var_02 setdamagecallbackon(1);
    var_02.var_29B5 = ::func_63B1;
    var_02 physicslaunchserver(var_02.var_0116, (0, randomfloat(17500) + 10000, 0));
    level.var_6894++;
  }

  level.var_83EE = 0;
  if(function_0367() && isDefined(param_00)) {
    param_00 maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubFiringRangeStats", "hubFRSequencesCompleted"], 1, undefined, undefined);
    param_00 maps\mp\gametypes\_missions::func_7752("ch_daily_3");
    foreach(var_04 in level.var_744A) {
      if(isDefined(common_scripts\utility::func_0F7E(level.var_83EC["melon"], var_04))) {
        var_04 iclientprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_HELPED");
        var_04 lib_0468::func_0A20("completedSequence");
        var_04 thread func_21E4("melon");
        continue;
      }

      var_04 iclientprintln(&"HUB_RANGE_SEQUENCE_COMPLETE", &"HUB_RANGE_SEQUENCE_NO_HELP");
    }

    level.var_83EC["melon"] = [];
  }
}

func_60FE() {
  if(level.var_6894 < 10) {
    lib_0380::func_2889("mp_hub_watermelon_launch", undefined, (1214, 587, 50));
    wait(0.5);
    lib_0380::func_2889("mp_hub_watermelon_settle", undefined, (1164, 835, 20));
  }
}

func_63B1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  thread func_60FD();
  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
  }

  if(isDefined(level.var_60FF)) {
    playFX(level.var_60FF, self.var_0116);
  }

  self setCanDamage(0);
  self setdamagecallbackon(0);
  level.var_6894--;
  if(isPlayer(param_01) && isDefined(param_01.var_8B25)) {
    param_01 thread func_8B26(self, 5);
  }

  self delete();
}

func_60FD() {
  var_00 = self.var_0116;
  wait(0.2);
  lib_0380::func_2889("mp_hub_watermelon_explode", undefined, var_00);
}

func_21E9(param_00) {
  var_01 = [];
  if(param_00 < 3) {
    for(var_02 = 0; var_02 < 3; var_02++) {
      var_01[var_02] = level.var_7AB7[var_02];
      if(!level.var_7AB7[var_02].var_4DC9) {
        return [];
      }
    }
  } else if(var_01 < 6) {
    for(var_02 = 3; var_02 < 6; var_02++) {
      var_01[var_02] = level.var_7AB7[var_02];
      if(!level.var_7AB7[var_02].var_4DC9) {
        return [];
      }
    }
  } else {
    for(var_02 = 6; var_02 < 9; var_02++) {
      var_01[var_02] = level.var_7AB7[var_02];
      if(!level.var_7AB7[var_02].var_4DC9) {
        return [];
      }
    }
  }

  return var_01;
}

func_2DD8(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(level.var_707C)) {
    playFX(level.var_707C, self.var_0116);
  }

  if(isDefined(self.var_0B6D)) {
    self.var_0B6D delete();
  }

  self delete();
}

func_2DDB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(level.var_707C)) {
    playFX(level.var_707C, self.var_0116);
  }

  if(isPlayer(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard_nosound");
  }

  self delete();
  if(!isDefined(self.var_707D)) {
    return;
  }

  self.var_707D.var_4B81 = 0;
  var_0C = 1;
  foreach(var_0E in level.var_707E[int(self.var_707D.var_0165)]) {
    if(var_0E.var_4B81) {
      var_0C = 0;
      break;
    }
  }

  if(var_0C) {
    foreach(var_0E in level.var_707E[int(self.var_707D.var_0165)]) {
      var_0E movey(250, 1);
    }

    if(int(self.var_707D.var_0165) == 4) {
      var_12 = 1;
      if(function_0367()) {
        foreach(var_14 in level.var_744A) {
          var_14 iclientprintln(param_01.var_0109, &"HUB_RANGE_SEQUENCE_COMPLETE");
        }

        param_01 maps\mp\gametypes\_missions::func_7752("ch_daily_3");
      }
    } else {
      var_12 = int(self.var_707D.var_0165) + 1;
    }

    foreach(var_0E in level.var_707E[var_12]) {
      func_906D(var_0E);
      var_0E moveto(var_0E.var_6C53, 1);
    }
  }

  if(isPlayer(param_03) && isDefined(param_03.var_8B25)) {
    param_03 thread func_8B26(self);
  }
}

func_6378(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(isDefined(param_01.var_8F10) && param_01.var_8F10 == self) {}
}

func_4AD6(param_00) {
  self endon("upDpadRelease");
  self endon("downDpadRelease");
  level endon("game_ended");
  if(!isDefined(self.var_8F10)) {
    return;
  }

  var_01 = common_scripts\utility::func_9AAD(common_scripts\utility::func_7F03(distance2d(self.var_0116, self.var_8F10.var_0116) / 10, 0));
  for(;;) {
    switch (param_00) {
      case "up":
        if(self.var_8F10.var_0116[0] <= 2850) {
          var_01 = common_scripts\utility::func_9AAD(common_scripts\utility::func_7F03(distance2d(self.var_0116, self.var_8F10.var_0116 + (50, 0, 0)) / 10, 0));
          self.var_8F10 movex(50, 0.01);
        }
        break;

      case "down":
        if(self.var_8F10.var_0116[0] >= 1000) {
          var_01 = common_scripts\utility::func_9AAD(common_scripts\utility::func_7F03(distance2d(self.var_0116, self.var_8F10.var_0116 - (50, 0, 0)) / 10, 0));
          self.var_8F10 movex(-50, 0.01);
        }
        break;
    }

    self.var_8F11 settext("Dist " + var_01);
    wait(0.01);
  }
}

func_2DD0() {
  self endon("death");
  level endon("game_ended");
  wait(5);
  if(isDefined(self)) {
    if(isDefined(self.var_0B6D)) {
      self.var_0B6D delete();
    }

    self delete();
  }

  level.var_83EC["plate"] = [];
}

func_21E4(param_00) {
  thread maps\mp\gametypes\_missions::func_7750("ch_hq_data_sequence_" + param_00);
  var_01 = maps\mp\gametypes\_hud_util::func_2097("ch_hq_data_sequence_melon");
  var_02 = maps\mp\gametypes\_hud_util::func_2097("ch_hq_data_sequence_tower");
  var_03 = maps\mp\gametypes\_hud_util::func_2097("ch_hq_data_sequence_plate");
  var_04 = var_01 + var_02 + var_03;
  thread maps\mp\gametypes\_missions::func_7750("ch_hq_sequences", var_04, 1);
}

func_47A9(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("leftFiringRange");
  self endon("1v1_ended");
  if(!isDefined(param_00) || param_00) {
    thread func_47AA();
  }

  if(isDefined(param_01) && param_01) {
    thread func_47AB();
  }

  for(;;) {
    var_02 = common_scripts\utility::func_A715("reload", "weapon_change");
    var_03 = self getweaponslistprimaries();
    if(getdvarint("weapon_plant_fire_using_reserve_ammo") == 1 && var_02 == "weapon_change") {
      foreach(var_05 in var_03) {
        if(maps\mp\gametypes\_division_change::func_574C(var_05)) {
          var_06 = self getweaponammoclip(var_05);
          var_07 = self getweaponammostock(var_05);
          if(var_06 == 0 && var_07 == 0) {
            self setweaponammostock(var_05, function_01D5(var_05));
          }
        }
      }

      continue;
    }

    foreach(var_05 in var_03) {
      if(var_05 != "none") {
        self setweaponammostock(var_05, function_01D5(var_05) - self getweaponammoclip(var_05));
      }
    }
  }
}

func_47AA() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("leftFiringRange");
  for(;;) {
    self waittill("grenade_pullback");
    wait(5);
    var_00 = self method_831F();
    if(var_00 != "none") {
      self givestartammo(var_00);
    }

    var_01 = self method_834A();
    if(var_01 != "none") {
      self givestartammo(var_01);
    }
  }
}

func_47AB() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("leftFiringRange");
  for(;;) {
    self waittill("grenade_pullback");
    wait(5);
    var_00 = self method_831F();
    if(var_00 != "none") {
      self givestartammo(var_00);
    }
  }
}

func_98C7() {
  if(self getclientomnvar("ui_hub_in_1v1") != 0) {
    return;
  }

  var_00 = undefined;
  foreach(var_02 in level.var_3C3F) {
    var_03 = var_02 maps\mp\gametypes\_hub_unk1::func_459B(60, 1);
    if(var_03.size == 0) {
      var_00 = var_02;
      break;
    }
  }

  if(!isDefined(var_00)) {
    var_00 = common_scripts\utility::func_7A33(level.var_3C3F);
  }

  self notify("weaponPlantFiringRange");
  wait 0.05;
  self setstance("stand");
  maps\mp\gametypes\_hub_unk1::func_8698(var_00.var_0116);
  self setangles(var_00.var_001D);
}

func_21C0() {
  level endon("game_ended");
  if(!self.var_572F) {
    thread func_478B(1);
  }
}

func_478B(param_00) {
  level endon("game_ended");
  self endon("leftFiringRange");
  self endon("disconnect");
  if(!param_00) {
    wait(getdvarfloat("3993", 0.5));
  }

  var_01 = 0;
  if((!maps\mp\gametypes\_hub_unk1::func_5790(var_01) || self playerisweaponplantenabled()) && !function_02A3() || getdvarint("spv_hub_firingrange_kswitch", 1) == 0) {
    func_9A80(0);
    var_02 = 5;
    if(isDefined(self.var_0079)) {
      var_02 = self.var_0079;
    }

    self.var_5DEE = undefined;
    maps\mp\gametypes\_division_change::func_A050();
    self.var_37FC = undefined;
    self.var_69AB = undefined;
    maps\mp\_utility::func_05E4();
    maps\mp\_utility::func_47A2("specialty_falldamage");
    var_03 = self.var_7706;
    var_04 = self.primarypaintjobid;
    var_05 = self.primarycharmguid;
    self.var_7706 = "none";
    self.primarypaintjobid = 0;
    self.primarycharmguid = 0;
    var_06 = self.var_835C;
    var_07 = self.secondarypaintjobid;
    var_08 = self.secondarycharmguid;
    self.var_835C = "none";
    self.secondarypaintjobid = 0;
    self.secondarycharmguid = 0;
    var_09 = self.var_60FB;
    self.var_60FB = "combatknife_mp";
    if(function_0367()) {
      maps\mp\gametypes\_hub_unk1::func_4618();
    }

    for(var_0A = 0; var_0A < 9; var_0A++) {
      if(self.var_5DF9[var_0A] != 0) {
        maps\mp\_utility::func_47A3(self.var_5DF9[var_0A], var_0A);
      }
    }

    maps\mp\perks\_perks::func_0F36();
    if(maps\mp\_utility::func_0649("specialty_randomgun")) {
      self.var_7706 = self.curwunderlustgun;
    }

    var_0B = getDvar("4969");
    var_0C = 0;
    if(var_0B != "" || self.var_7706 != var_03 || self.var_835C != var_06 || self.var_60FB != var_09 || self.primarypaintjobid != var_04 || self.secondarypaintjobid != var_07 || self.primarycharmguid != var_05 || self.secondarycharmguid != var_08) {
      var_0C = 1;
      self takeallweapons();
      if(var_0B != "") {
        var_0D = getdvarint("4567");
        var_0B = maps\mp\_utility::func_922B(var_0B);
        maps\mp\_utility::func_0642(var_0B);
        setDvar("4969", "");
        setDvar("4567", 0);
        if(var_0D == 2) {
          if(self.var_7706 != "none") {
            maps\mp\_utility::func_0642(self.var_7706);
          }

          if(self.var_835C != "none") {
            maps\mp\_utility::func_0642(self.var_835C);
          }
        } else if(var_0D == 0) {
          if(self.var_835C != "none") {
            maps\mp\_utility::func_0642(self.var_835C);
          }
        } else if(var_0D == 1) {
          if(self.var_7706 != "none") {
            maps\mp\_utility::func_0642(self.var_7706);
          }
        }

        self switchtoweaponimmediate(var_0B);
      } else {
        if(self.var_7706 != "none") {
          maps\mp\_utility::func_0642(self.var_7706, undefined, self.primarypaintjobid, self.primarycharmguid);
        }

        if(self.var_835C != "none") {
          maps\mp\_utility::func_0642(self.var_835C, undefined, self.secondarypaintjobid, self.secondarycharmguid);
        }

        if(self.var_7706 != "none") {
          self switchtoweaponimmediate(maps\mp\_utility::func_922B(self.var_7706));
        } else if(self.var_835C != "none") {
          self switchtoweaponimmediate(maps\mp\_utility::func_922B(self.var_835C));
        }
      }
    }

    if(isDefined(self.var_37FC) && !self.var_572F) {
      if(self.var_37FC != "bouncingbetty_mp" && maps\mp\gametypes\_class::func_5826(self.var_37FC, 0)) {
        self method_8349(self.var_37FC);
        self giveweapon(self.var_37FC);
      }
    }

    thread maps\mp\_riotshield::func_9BC6();
    self method_8036(1, 0);
    if(var_0D) {
      self waittill("weapon_change");
    }

    self method_812A(1);
    if(isDefined(self.var_0079) && self.var_7706 != "none") {
      thread maps\mp\gametypes\_division_change::func_8622(self.var_0079, self.var_7706);
    }

    if(var_01) {
      maps\mp\gametypes\_class::func_1FA2();
    }
  }
}

func_8B26(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  var_02 = param_00.var_0116;
  var_03 = 0;
  if(isDefined(self.var_5C05) && self.var_5C05 == param_00) {
    var_03 = 1;
  } else if(isDefined(param_00.var_4E00) && !param_00.var_4E00) {
    var_03 = 0;
  } else if(isDefined(param_01) && function_030D(param_01)) {
    var_03 = param_01;
  } else {
    self.var_5C05 = param_00;
    var_04 = distance(var_02, level.var_3C40.var_0116);
    if(var_04 > 2200) {
      var_03 = 5;
    } else if(var_04 > 1800) {
      var_03 = 4;
    } else if(var_04 > 1300) {
      var_03 = 3;
    } else if(var_04 > 800) {
      var_03 = 2;
    } else {
      var_03 = 1;
    }
  }

  self.var_8B25 = self.var_8B25 + var_04;
  self luinotifyevent(&"hub_update_shootout", 3, self.var_8B25, self.var_8B24.var_8B25, var_04);
  self.var_8B24 luinotifyevent(&"hub_update_shootout", 3, self.var_8B24.var_8B25, self.var_8B25, 0);
}

func_11BD(param_00) {
  var_01 = 0;
  if(maps\mp\gametypes\_hub_unk1::func_5790(var_01)) {
    return;
  }

  if(param_00 maps\mp\gametypes\_hub_unk1::func_5790(var_01)) {
    self iclientprintln(&"HUB_PLAYER_IS_BUSY", param_00.var_0109);
    return;
  }

  if(isDefined(self.var_8B24)) {
    self iclientprintln(&"HUB_ALREADY_CH_SHOOTOUT");
    return;
  }

  if(isDefined(param_00.var_8B24)) {
    self iclientprintln(&"HUB_PLAYER_IS_BUSY", param_00.var_0109);
    return;
  }

  if(getdvarint("spv_hub_firingrange_kswitch", 1) == 1) {
    self iclientprintln(&"HUB_FIRINGRANGE_UNAVAILABLE");
    return;
  }

  var_02 = func_778C(param_00);
  if(!isDefined(var_02)) {
    var_02 = 0;
    param_00 setclientomnvar("ui_enterShootout", 0);
    self.var_8B24 = undefined;
    param_00.var_8B24 = undefined;
    self.var_572F = 0;
    param_00.var_572F = 0;
    param_00 maps\mp\gametypes\_hub_unk1::func_870B(0);
    param_00 freezecontrols(0);
  }

  var_03 = maps\mp\gametypes\_hub_unk1::func_5790(var_01);
  var_04 = param_00 maps\mp\gametypes\_hub_unk1::func_5790(var_01);
  if(var_03 || var_04) {
    if(var_03) {
      self iclientprintln(&"HUB_SHOOTOUT_YOU_BUSY");
      param_00 iclientprintln(&"HUB_SHOOTOUT_OPPONENT_BUSY");
    } else if(var_04) {
      param_00 iclientprintln(&"HUB_SHOOTOUT_YOU_BUSY");
      self iclientprintln(&"HUB_SHOOTOUT_OPPONENT_BUSY");
    }

    self.var_8B24 = undefined;
    param_00.var_8B24 = undefined;
    return;
  }

  if(var_02) {
    self.var_572F = 1;
    param_00.var_572F = 1;
    self.var_7706 = "mp40_mp";
    self method_85B4();
    param_00 method_85B4();
    maps\mp\gametypes\_hub_unk1::func_4618();
    self.var_8B27 = maps\mp\gametypes\_division_change::func_7CCD(self.var_7706);
    param_00.var_8B27 = self.var_8B27;
    if(self.var_5721) {
      func_37BD();
    }

    if(param_00.var_5721) {
      param_00 func_37BD();
    }

    func_98C7();
    param_00 func_98C7();
    func_9306(self, param_00);
    return;
  }

  maps\mp\gametypes\_hub_notifications::func_8A34(self, "SHOOTOUT_CHALLENGE_INVITE_DECLINED", param_00);
}

checkfordisconnect(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("shootoutTimeLimit");
  self endon("shootoutChoiceMade");
  param_00 common_scripts\utility::func_A70A("death", "disconnect");
  self freezecontrols(0);
  maps\mp\gametypes\_hub_unk1::func_870B(0);
}

func_778C(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("shootoutTimeLimit");
  self endon("death");
  self endon("disconnect");
  self.var_8B24 = param_00;
  param_00.var_8B24 = self;
  param_00 thread checkfordisconnect(self);
  param_00 freezecontrols(1);
  param_00 maps\mp\gametypes\_hub_unk1::func_870B(1);
  wait(0.5);
  maps\mp\gametypes\_hub_notifications::func_8A34(param_00, "SHOOTOUT_CHALLENGE", self);
  maps\mp\gametypes\_hub_notifications::func_8A34(self, "SHOOTOUT_CHALLENGE_INVITE_SENT", param_00);
  param_00 freezecontrols(0);
  param_00 thread maps\mp\gametypes\_hub_unk1::func_8636(10, "shootoutTimeLimit", ["death", "disconnect", "shootoutChoiceMade"]);
  for(;;) {
    param_00 waittill("luinotifyserver", var_01, var_02);
    if(var_01 == "enter_shootout") {
      break;
    }
  }

  param_00 notify("shootoutChoiceMade");
  param_00 maps\mp\gametypes\_hub_unk1::func_870B(0);
  if(var_02 == 1) {
    return 1;
  }

  self.var_8B24 = undefined;
  param_00.var_8B24 = undefined;
  return 0;
}

func_9306(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_01 endon("disconnect");
  param_00 endon("quit_shootout");
  param_01 endon("quit_shootout");
  param_00 setclientomnvar("ui_hub_shootout_opponent_client_num", param_01 getentitynumber());
  param_01 setclientomnvar("ui_hub_shootout_opponent_client_num", param_00 getentitynumber());
  param_00 setclientomnvar("ui_hub_in_shootout", 1);
  param_01 setclientomnvar("ui_hub_in_shootout", 1);
  param_00 setclientomnvar("ui_hub_shootout_intro_countdown", 5);
  param_01 setclientomnvar("ui_hub_shootout_intro_countdown", 5);
  param_00 luinotifyevent(&"hub_begin_shootout", 0);
  param_01 luinotifyevent(&"hub_begin_shootout", 0);
  param_00 luinotifyeventextraplayer(&"player_interact_notification_end", 0);
  param_00 luinotifyeventextraplayer(&"player_interact_notification_center_end", 0);
  param_00 thread handleshootoutleaveactivity();
  param_01 thread handleshootoutleaveactivity();
  param_00 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 1, 1, 0);
  param_00 setstance("stand");
  param_01 maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 1, 1, 0);
  param_01 setstance("stand");
  for(var_02 = 4; var_02 > -1; var_02--) {
    wait(1);
    param_00 setclientomnvar("ui_hub_shootout_intro_countdown", var_02);
    param_01 setclientomnvar("ui_hub_shootout_intro_countdown", var_02);
    param_00 luinotifyevent(&"hub_update_shootout_intro", 0);
    param_01 luinotifyevent(&"hub_update_shootout_intro", 0);
  }

  param_00 maps\mp\gametypes\_hub_unk1::func_A04C();
  param_01 maps\mp\gametypes\_hub_unk1::func_A04C();
  param_00 method_812B(1);
  param_01 method_812B(1);
  var_03 = 30;
  var_04 = 0;
  for(;;) {
    wait(0.5);
    var_04 = var_04 + 0.5;
    if(!isDefined(param_00.var_8B24) || !isDefined(param_01.var_8B24)) {
      return;
    }

    if(var_04 >= var_03) {
      var_05 = undefined;
      var_06 = undefined;
      if(param_00.var_8B25 > param_01.var_8B25) {
        var_05 = param_00;
        var_06 = param_01;
      } else if(param_01.var_8B25 > param_00.var_8B25) {
        var_05 = param_01;
        var_06 = param_00;
      } else {
        param_00 iclientprintln(&"HUB_BROADCAST_SHOOTOUT_RESULTS_TIE", param_01.var_0109);
        param_01 iclientprintln(&"HUB_BROADCAST_SHOOTOUT_RESULTS_TIE", param_00.var_0109);
        param_00 thread func_4B07("tie");
        param_01 thread func_4B07("tie");
        return;
      }

      var_05 thread func_4B07("win");
      var_06 thread func_4B07("loss");
      foreach(var_08 in level.var_744A) {
        var_08 iclientprintln(&"HUB_BROADCAST_SHOOTOUT_RESULTS_WIN", var_05.var_0109, var_06.var_0109);
      }

      return;
    }
  }
}

func_300E(param_00, param_01) {
  param_00 endon("disconnect");
  param_01 endon("disconnect");
  param_00 freezecontrols(1);
  param_01 freezecontrols(1);
  param_00 thread maps\mp\gametypes\_hub_unk1::func_3010("shootoutIntro", &"", "Get more points than your opponent to win", -100, 1.5, 3);
  param_01 thread maps\mp\gametypes\_hub_unk1::func_3010("shootoutIntro", &"", "Get more points than your opponent to win", -100, 1.5, 3);
  for(var_02 = 5; var_02 > 0; var_02--) {
    param_00 thread maps\mp\gametypes\_hub_unk1::func_3010("shootoutCountdown" + var_02, &"", var_02 + "...", -70, 1.5, 1);
    param_01 thread maps\mp\gametypes\_hub_unk1::func_3010("shootoutCountdown" + var_02, &"", var_02 + "...", -70, 1.5, 1);
    wait(1);
  }

  param_00 freezecontrols(0);
  param_01 freezecontrols(0);
}

func_A179(param_00) {
  var_01 = 180;
  maps\mp\gametypes\_hub_unk1::func_2835("shootoutTimer", &"", param_00, [0, var_01], 2);
}

func_282C(param_00) {
  if(!isDefined(param_00) && isDefined(self.var_8B24)) {
    param_00 = self.var_8B24;
  }

  if(!isDefined(self.var_8B25)) {
    self.var_8B25 = 0;
  }

  if(!isDefined(param_00.var_8B25)) {
    param_00.var_8B25 = 0;
  }

  var_01 = 200;
  maps\mp\gametypes\_hub_unk1::func_2835("playerShootoutScore", &"", self.var_8B25, [-30, var_01], 2);
  maps\mp\gametypes\_hub_unk1::func_2835("enemyShootoutScore", &"", param_00.var_8B25, [30, var_01], 2);
}

handleshootoutleaveactivity() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_shootout");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "hub_leave_activity") {
      self notify("quit_shootout");
      if(isDefined(self.var_8B24)) {
        self.var_8B24 thread func_4B07("win");
      }

      thread func_4B07("loss", 1);
      return;
    }
  }
}

func_4B07(param_00, param_01, param_02) {
  self notify("end_shootout");
  if(!self.var_572F) {
    return;
  }

  self.var_572F = 0;
  if(isDefined(param_00)) {
    if(!self.var_8C8F) {
      self method_85C7();
      maps\mp\gametypes\_hub_unk1::func_7446();
      maps\mp\gametypes\_hub_unk1::func_3663();
      func_75F3(param_00);
    }

    self.var_8C8F = 0;
    if(isDefined(level.var_2D6D) && !isDefined(param_01) || !param_01) {
      if(param_00 == "win") {
        self[[level.var_2D6D]](10);
        maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubFiringRangeStats", "numShootoutWins"], 1, undefined, undefined);
        lib_0468::func_0A26("win", self.var_8B24.var_01D6);
      } else if(param_00 == "loss") {
        self[[level.var_2D6D]](1);
        lib_0468::func_0A26("lose", self.var_8B24.var_01D6);
      }

      maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubFiringRangeStats", "numShootoutChallenges"], 1, undefined, undefined);
      maps\mp\gametypes\_hub_unk1::func_5E88("fr_shootout", "hq_firing_range_end", 0, ["shootout_guid", "0", "score", self.var_8B25, "winloss", param_00]);
    }
  }

  self setclientomnvar("ui_hub_in_shootout", 0);
  self.var_8B25 = undefined;
  self.var_8B24 = undefined;
  self.var_8B27 = undefined;
  self luinotifyevent(&"hub_end_shootout", 0);
  if((!isDefined(param_02) || !param_02) && self.var_5721) {
    func_37BD();
  }
}

func_75F3(param_00, param_01) {
  maps\mp\gametypes\_hub_unk1::func_7DF8(0, 0, 0);
  self setstance("stand");
  wait(1.05);
  if(param_00 == "win") {
    maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_clap_jump", 1);
    wait(3.466667);
  } else {
    maps\mp\gametypes\_hub_unk1::func_721A("mp_emote_noway", 1);
    wait(5.366667);
  }

  maps\mp\gametypes\_hub_unk1::func_A04C();
}

func_9824() {
  self endon("disconnect");
  self endon("leftFiringRange");
  self.var_1E23 = 0;
  for(;;) {
    self waittill("hitFRTarget");
    self.var_1E23++;
    thread maps\mp\gametypes\_hub_unk1::func_8636(10, "clearCachedTargets", ["hitFRTarget"]);
    thread func_A79B();
  }
}

func_A79B() {
  self endon("hitFRTarget");
  self endon("leftFiringRange");
  self waittill("clearCachedTargets");
  maps\mp\gametypes\_hub_unk1::func_50F0(["hubFeatureStats", "hubFiringRangeStats", "hubTargetsShot"], self.var_1E23, undefined, undefined);
  self.var_1E23 = 0;
}

func_74A7() {
  if(function_03AE() == 1) {
    return;
  }

  activateclientexploder(1);
  lib_0380::func_2889("mp_hub_flare_distant", undefined, (3016, 946, 50));
  wait(1.5);
  activateclientexploder(2);
  lib_0380::func_2889("mp_hub_flare_medium", undefined, (2572, 921, 50));
  wait(1.5);
  activateclientexploder(3);
  lib_0380::func_2889("mp_hub_flare_close", undefined, (1364, 983, 50));
}

func_74C5() {
  if(function_03AE() == 1) {
    return;
  }

  for(var_00 = 0; var_00 < 3; var_00++) {
    lib_0380::func_2889("mp_hub_range_explode_0" + var_00, undefined, (3396, 992, 300));
    activateclientexploder(4);
    wait(0.25);
    activateclientexploder(6);
    wait(0.25);
    activateclientexploder(5);
    lib_0380::func_2889("mp_hub_range_tail_0" + var_00, undefined, (3396, 992, 300));
    wait(0.25);
  }
}

targethitsequence() {
  self endon("disconnect");
  self endon("leftFiringRange");
  self endon("target_sequence_complete");
  self.sequencetargetshit = 0;
  self.lastsequencetargethittime = 0;
  for(;;) {
    self waittill("hitFRDestroyed", var_00);
    if((isDefined(self.lastsequencetargethit) && self.lastsequencetargethit != var_00) || gettime() > self.lastsequencetargethittime + 500) {
      self.lastsequencetargethit = var_00;
      self.lastsequencetargethittime = gettime();
      self.sequencetargetshit++;
      thread checksequencetimer(10, 10);
    }
  }
}

checksequencetimer(param_00, param_01) {
  self endon("disconnect");
  self endon("leftFiringRange");
  self endon("target_sequence_complete");
  if(self.sequencetargetshit >= param_01) {
    lib_0468::func_0A20("targetHit");
    self.sequencetargetshit = 0;
    self notify("target_sequence_complete");
  }

  wait(param_00);
  self.sequencetargetshit--;
}