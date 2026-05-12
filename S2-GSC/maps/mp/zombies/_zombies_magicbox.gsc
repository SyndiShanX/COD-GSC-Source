/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_magicbox.gsc
*************************************************/

func_5305() {
  level.var_2B6F = 1;
  level.var_2B70 = 0;
  level.var_2B6E = 15;
  if(0) {
    level.var_4400 = ::func_4403;
    level.var_451F = ::func_4521;
  }

  level.var_08AD = ::func_08B7;
  level.var_2A77 = ::func_2A7A;
  level.var_6C08 = ::func_6C0A;
  level.var_2448 = ::func_244B;
  level.var_6AD1 = ::func_6B9A;
  level.var_74C4 = ::func_64C6;
  level.var_0611["magic_box_light"] = loadfx("vfx/zombie/zmb_box_light_marker");
  level.var_0611["zmb_mystery_box_gun_gk"] = loadfx("vfx/zombie/zmb_mystery_box_gun_gk");
  func_09E8();
}

func_09E8() {
  if(1) {
    func_09C8("jack_in_box_decoy_zm", "none", "none", "none");
  }

  func_09C8("m1911_zm", "none", "none", "none");
  func_09C8("lewis_zm", "none", "none", "none");
  func_09C8("fg42_zm", "none", "none", "none");
  func_09C8("mg15_zm", "none", "none", "none");
  func_09C8("mg42_zm", "none", "none", "none");
  func_09C8("m1941_zm", "none", "none", "none");
  func_09C8("g43_zm", "none", "none", "none");
  func_09C8("stg44_zm", "none", "none", "none");
  func_09C8("walther_zm", "none", "none", "none");
  func_09C8("mp40_zm", "none", "none", "none");
  func_09C8("mp28_zm", "none", "none", "none");
  func_09C8("karabin_zm", "none", "none", "none");
  func_09C8("thompson_zm", "none", "none", "none");
  func_09C8("type100_zm", "none", "none", "none");
  func_09C8("m1garand_zm", "none", "none", "none");
  func_09C8("winchester1897_zm", "none", "none", "none");
  func_09C8("svt40_zm", "none", "none", "none");
  func_09C8("bar_zm", "none", "none", "none");
  func_09C8("bren_zm", "none", "none", "none");
  func_09C8("leeenfield_zm", "none", "none", "none");
  func_09C8("ppsh41_zm", "none", "none", "none");
  func_09C8("springfield_zm", "none", "none", "none");
  func_09C8("greasegun_zm", "none", "none", "none");
  func_09C8("sten_zm", "none", "none", "none");
  func_09C8("fliegerfaust_zm", "none", "none", "none");
  func_09C8("breda30_zm", "none", "none", "none");
  func_09C8("volk_zm", "none", "none", "none");
  func_09C8("beretta_zm", "none", "none", "none");
  func_09C8("p38_zm", "none", "none", "none");
  func_09C8("reich_zm");
  func_09C8("enfieldno2_zm");
  func_09C8("mas38_zm");
  func_09C8("mg81_zm");
  func_09C8("type5_zm");
  func_09C8("sterling_zm");
  func_09C8("m1935_zm");
  func_09C8("m2carbine_zm");
  func_09C8("arisaka_zm");
  func_09C8("leveraction_zm");
  func_09C8("m1919_zm");
  func_09C8("nambu_zm");
  func_09C8("blunderbuss_zm");
  func_09C8("ptrs41_zm");
  func_09C8("zk383_zm");
  func_09C8("delisle_zm");
  func_09C8("avs36_zm");
  func_09C8("federov_zm");
  func_09C8("mosin_zm");
  func_09C8("ribeyrolles_zm");
  func_09C8("tokyo_zm");
  func_09C8("vmg1927_zm");
  func_09C8("sudaev_zm");
  func_09C8("sdk_zm");
  func_09C8("charlton_zm");
  func_09C8("emp44_zm");
  func_09C8("dp28_zm");
  func_09C8("austen_zm");
  func_09C8("bechowiec_zm");
  func_09C8("blyskawica_zm");
  func_09C8("chatelleroult_zm");
  func_09C8("erma_zm");
  func_09C8("grofuss_zm");
  func_09C8("kgm21_zm");
  func_09C8("lad_zm");
  func_09C8("m2hyde_zm");
  func_09C8("mas36_zm");
  func_09C8("wimmer_zm");
  func_09C8("wz35_zm");
  if(isDefined(level.initmagicboxweaponsfunc)) {
    [[level.initmagicboxweaponsfunc]]();
  }
}

func_8360(param_00) {
  return int(param_00 * 20);
}

func_6B9A(param_00) {
  func_4D18(param_00, 1);
}

func_4D18(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  if(isDefined(param_00.var_6298)) {
    param_00.var_6298 hidepart("TAG_FX");
    if(isDefined(level.var_0611["magic_box_light"]) && isDefined(param_00.var_6298) && isDefined(param_00.var_6298.var_1B78)) {
      stopFXOnTag(common_scripts\utility::func_44F5("magic_box_light"), param_00.var_6298.var_1B78, "tag_origin");
      return;
    }

    return;
  }

  if(isDefined(param_00.var_82EF)) {
    param_00.var_82EF setscriptablepartstate("lights", "inactive");
    if(!param_01) {
      param_00.var_82EF func_6C0B(1);
      return;
    }

    param_00.var_82EF setscriptablepartstate("box", "opened");
    return;
  }
}

func_4403() {
  var_00 = &"ZOMBIES_BUY_MYSTERY_BOX";
  return var_00;
}

func_4521() {
  var_00 = &"ZOMBIES_EMPTY_STRING";
  return var_00;
}

func_08B7(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = func_456D(param_00);
  if(isDefined(param_00.var_6298)) {
    if(!isDefined(param_00.var_6298.var_1B78)) {
      param_00.var_6298.var_1B78 = spawn("script_model", (param_00.var_6298.var_0116[0], param_00.var_6298.var_0116[1], 1650));
      param_00.var_6298.var_1B78 setModel("tag_origin");
      param_00.var_6298.var_1B78.var_001D = (-90, -90, -90);
    }

    if(isDefined(level.var_0611["magic_box_light"]) && isDefined(param_00.var_6298.var_1B78)) {
      playFXOnTag(level.var_0611["magic_box_light"], param_00.var_6298.var_1B78, "tag_origin");
    }
  }

  if(isDefined(param_00.var_6298)) {
    param_00.var_6298 showpart("TAG_FX");
    param_00.var_6298 scriptmodelplayanim("zmb_mystery_box_2_close_idle");
    return;
  }

  if(isDefined(param_00.var_82EF)) {
    param_00.var_82EF setscriptablepartstate("lights", "active");
    param_00.var_82EF func_244C();
  }
}

func_2A7A(param_00) {
  func_4D18(param_00);
}

magicboxweaponvisibility(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = 1;
  for(;;) {
    if(!var_02 && common_scripts\utility::func_562E(param_00.var_56C7) && isDefined(param_00.var_586E)) {
      param_00 waittill("set magic box weapon");
    }

    var_02 = 0;
    var_03 = 1;
    for(;;) {
      if(var_01 method_8530(param_00.var_586E.var_A9E0)) {
        break;
      }

      if(!common_scripts\utility::func_562E(param_00.var_56C7) || common_scripts\utility::func_562E(param_00.var_586E.is_flashing)) {
        var_03 = 0;
        break;
      }

      wait 0.05;
    }

    if(var_03) {
      param_00.var_586E showtoclient(var_01);
    }
  }
}

func_801A(param_00, param_01) {
  if(isDefined(param_00.var_586E)) {
    param_00.var_586E method_848E(param_01);
  } else {
    param_00.var_586E = spawn("weapon_" + param_01, param_00.var_A9EA.var_0116);
    var_02 = (0, 0, 0);
    param_00.var_586E linkto(param_00.var_A9EA, "tag_origin", var_02, (0, 0, 0));
  }

  param_00.var_586E makeunusable();
  param_00.var_586E method_86B3(0);
  param_00.var_586E method_8511();
  param_00.var_586E.var_A9E0 = param_01;
  param_00 notify("set magic box weapon");
}

func_456D(param_00) {
  if(isDefined(param_00.var_6298)) {
    return param_00.var_6298;
  }

  if(isDefined(param_00.var_82EF)) {
    return param_00.var_82EF;
  }
}

worldweaponsloadedbyplayers(param_00, param_01) {
  var_02 = [];
  foreach(var_04 in param_01) {
    var_05 = 1;
    foreach(var_07 in param_00) {
      if(!var_07 method_8530(var_04)) {
        var_05 = 0;
        break;
      }
    }

    if(var_05) {
      var_02[var_02.size] = var_04;
    }
  }

  return var_02;
}

choosepreviewweapon(param_00) {
  if(!isDefined(level.magicboxpreviewweapons)) {
    level.magicboxpreviewweapons = [];
    foreach(var_02 in level.var_5F7F) {
      var_03 = var_02["fullName"];
      if(issubstr(var_03, "_pap_")) {
        var_03 = lib_0569::func_40BD(var_03);
      }

      level.magicboxpreviewweapons[level.magicboxpreviewweapons.size] = var_03;
    }
  }

  var_05 = worldweaponsloadedbyplayers(level.var_744A, level.magicboxpreviewweapons);
  if(var_05.size < 2) {
    var_05 = worldweaponsloadedbyplayers([param_00], level.magicboxpreviewweapons);
  }

  var_03 = common_scripts\utility::func_7A33(var_05);
  return var_03;
}

func_6C0A(param_00, param_01) {
  var_02 = 4.5;
  var_03 = 0.5;
  var_04 = 4;
  var_05 = 0.1;
  var_06 = 0.3;
  var_07 = (2, 1, 2);
  var_08 = 45;
  var_09 = getdvarint("scr_zombieDebugS2MagicBoxDraw");
  var_0A = [];
  var_0B = func_456D(param_00);
  var_0A = anglestoaxis(var_0B.var_001D);
  var_0C = var_0B method_8549(0, 0, -1);
  var_0D = var_0A["up"] * var_07[2];
  var_0D = var_0D + var_0A["right"] * var_07[1];
  var_0D = var_0D + var_0A["forward"] * var_07[0];
  var_0D = var_0D + var_0C;
  if(isDefined(param_00.var_A9EA)) {
    param_00.var_A9EA method_808C();
    param_00.var_A9EA.var_0116 = var_0D;
  } else {
    param_00.var_A9EA = spawn("script_origin", var_0D);
    param_00.var_A9EA setModel("tag_origin");
    param_00.var_A9EA method_805C();
  }

  if(isDefined(param_00.var_6298)) {
    param_00.var_6298 scriptmodelplayanim("zmb_mystery_box_2_open");
  } else if(isDefined(param_00.var_82EF)) {
    param_00.var_82EF thread func_6C0B();
  }

  lib_0378::func_8D74("mystery_box_open", var_0B);
  lib_0378::func_8D74("mystery_box_attract_open", var_0B);
  wait(1);
  param_00.var_A9EA.var_001D = combineangles(var_0B.var_001D, (0, 0, 0));
  param_00.var_A9EA movez(var_08, var_02, var_04, var_03);
  playFXOnTag(level.var_0611["zmb_mystery_box_gun_gk"], param_00.var_A9EA, "tag_origin");
  lib_0378::func_8D74("mystery_box_elec", var_0B, 1);
  wait(1);
  var_11 = [];
  foreach(var_13 in level.var_744A) {
    if(var_13 == param_01) {
      continue;
    } else {
      var_11[var_11.size] = var_13;
    }
  }

  if(var_11.size > 0) {
    var_0B thread func_8019(var_11, param_01);
  }

  func_83B2(param_01, param_00);
  var_15 = param_00.var_A9C4["selectedWeapon"];
  var_16 = spawn("weapon_" + var_15, param_00.var_A9EA.var_0116, 1);
  var_16 makeunusable();
  var_16 method_86B3(0);
  var_16 method_8511();
  for(var_17 = 0; var_17 < var_02; var_17 = var_17 + var_1A) {
    var_18 = choosepreviewweapon(param_01);
    if(isDefined(var_18)) {
      func_801A(param_00, var_18);
    }

    var_19 = var_17 / var_02;
    var_1A = lerp(var_05, var_06, var_19);
    wait(var_1A);
  }

  func_801A(param_00, var_15);
  var_16 delete();
  wait(var_06);
}

func_8019(param_00, param_01) {
  var_02 = 0.5;
  var_03 = 5;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    wait(var_02);
    self hudoutlineenableforclients(param_00, 0, 0);
    wait(var_02);
    self hudoutlinedisableforclients(param_00);
  }
}

func_6C0B(param_00) {
  if(common_scripts\utility::func_562E(param_00)) {
    self setscriptablepartstate("box", "opening_dud");
  } else {
    self setscriptablepartstate("box", "opening");
  }

  wait(getanimlength(%zmb_mystery_box_2_open));
  self setscriptablepartstate("box", "opened");
}

func_244C() {
  self setscriptablepartstate("box", "closing");
  wait(getanimlength(%zmb_mystery_box_2_close));
  self setscriptablepartstate("box", "closed");
}

func_244B(param_00) {
  if(isDefined(param_00.var_82EF)) {
    param_00.var_82EF func_244C();
  } else if(isDefined(param_00.var_6298)) {
    param_00.var_6298 scriptmodelplayanim("zmb_mystery_box_2_close");
  }

  param_00 common_scripts\utility::func_9DA3();
}

func_64C6(param_00, param_01) {
  wait(1);
  var_02 = func_456D(param_00);
  lib_0380::func_2889("interact_mystery_box_move", undefined, var_02.var_0116);
  func_4D18(param_00);
}

func_00D5() {
  level thread func_5FF2();
  level thread func_A7D8();
  level thread func_5F7B();
  level thread func_5F79();
  level thread func_0DB7();
}

func_A7D8() {
  level.var_A7F1 = [];
  level.var_A7DE = [];
  var_00 = getEntArray("wallbuy", "targetname");
  level.var_A7DE = common_scripts\utility::func_0F73(level.var_A7DE, var_00);
  var_06 = common_scripts\utility::func_46B7("wallbuy", "targetname");
  level.var_A7DE = common_scripts\utility::func_0F73(level.var_A7DE, var_06);
  foreach(var_08 in level.var_A7DE) {
    level thread func_A7E6(var_08);
  }
}

func_A7E5(param_00) {
  foreach(var_02 in level.var_A7DE) {
    var_03 = getEntArray(var_02.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      if(param_00) {
        var_05 common_scripts\utility::func_9D9F();
      } else {
        var_05 common_scripts\utility::func_9DA3();
      }

      var_05.var_5611 = param_00;
    }
  }
}

func_A7F0(param_00) {
  var_01 = self;
  if(var_01 != param_00.var_7474) {
    param_00.var_586E hidefromclient(var_01);
    return;
  }

  var_01 endon("disconnect");
  while(!var_01 method_8530(param_00.var_586E.var_A9E0)) {
    wait 0.05;
  }

  param_00.var_586E showtoclient(var_01);
}

func_A7EF(param_00, param_01) {
  param_01 endon("disconnect");
  var_02 = spawnStruct();
  var_02.var_586E = param_00;
  var_02.var_586E method_8511();
  var_02.var_7474 = param_01;
  level childthread maps\mp\_utility::func_6F74(::func_A7F0, var_02);
}

func_10E6(param_00) {
  param_00 endon("disconnect");
  var_01 = self;
  while(common_scripts\utility::func_562E(param_00.playerconnectedbuthasntstreamedweapons)) {
    wait 0.05;
  }

  wait(randomfloat(0.5));
  if(isDefined(var_01.var_6C1D)) {
    var_01.var_6C1D delete();
  }

  var_02 = func_454B(param_00, var_01.var_A9E0);
  var_03 = "weapon_" + var_02;
  var_04 = spawn(var_03, var_01.var_A9E3, 1);
  var_04.var_001D = var_01.var_A9BD;
  var_04.var_A9E0 = var_02;
  var_04 makeunusable();
  var_04 method_86B3(0);
  func_A7EF(var_04, param_00);
  var_01.var_6C1D = var_04;
  thread func_8C2B(param_00);
  thread func_A7EB(param_00);
  thread func_A7ED(param_00);
  self usetouchtriggerrequirefacingposition(1, var_01.var_A9E3);
  lib_0559::func_7C03(param_00, self, self.var_A9E0);
}

func_4D1B(param_00) {
  self.var_82EF hidefromclient(param_00);
}

func_8C2B(param_00) {
  self.var_82EF showtoclient(param_00);
}

func_A7EB(param_00) {
  param_00 endon("disconnect");
  self.var_A7D7 = 1;
  childthread func_A7EC(param_00);
  wait(randomfloat(0.8));
  var_01 = self;
  var_02 = lib_0552::func_7BFE(param_00, self, 1, var_01.var_A9E3);
  for(;;) {
    wait(0.8);
    if(!self.var_A7D7) {
      continue;
    }

    self.var_A7D7 = 0;
    if(0) {
      self setcursorhint("HINT_NOICON");
    }

    var_03 = param_00 getcurrentprimaryweapon();
    if(lib_0547::func_57AF(var_03) || lib_0547::func_5862(var_03)) {
      if(0) {
        self sethintstring("");
        self setsecondaryhintstring("");
        self settertiaryhintstring("");
        self.var_3006 = undefined;
      }

      if(1) {
        var_02.var_A9B4 = undefined;
      }

      continue;
    }

    var_04 = param_00 lib_0586::func_078A(self.var_A9E0);
    if(isDefined(var_04)) {
      self.var_2925 = self.var_0DB5;
      if(lib_0569::func_55D4(var_04)) {
        self.var_2925 = 4000;
      }

      self.var_3006 = self.var_2925;
      if(0) {
        self sethintstring(func_4412(self));
        self setsecondaryhintstring(func_4411(self));
        self settertiaryhintstring("");
      }

      if(1) {
        var_02.var_A9B4 = "ammo";
        var_02.var_A9A5 = self.var_3006;
      }

      continue;
    }

    self.var_2955 = self.var_A9C2;
    self.var_3006 = self.var_2955;
    if(0) {
      self setsecondaryhintstring(func_4734(self));
      self settertiaryhintstring(func_4733(self));
      self sethintstring(&"ZOMBIES_WALL_BUY_GENERIC");
    }

    if(1) {
      var_02.var_A9B4 = self.var_6C5C;
      var_02.var_A9A5 = self.var_3006;
    }
  }
}

func_A7EC(param_00) {
  for(;;) {
    param_00 common_scripts\utility::func_A70A("weapon_change", "new_equipment");
    self.var_A7D7 = 1;
  }
}

func_A7ED(param_00) {
  for(;;) {
    param_00 common_scripts\utility::func_A70A("weapon_change", "new_equipment", "money_update", "special_event_update");
    waittillframeend;
    if(isDefined(self.var_3006)) {
      if(common_scripts\utility::func_562E(self.var_5611) || param_00.var_62D6 < self.var_3006) {
        func_A7D2("unaffordable");
        continue;
      }

      func_A7DD("unaffordable");
    }
  }
}

func_A7E6(param_00) {
  var_01 = param_00.var_0116;
  var_02 = param_00.var_001D;
  if(!isDefined(var_02)) {
    var_02 = (0, 0, 0);
  }

  var_03 = param_00.var_0165;
  var_04 = [];
  if(isDefined(param_00.var_8260)) {
    var_04 = strtok(param_00.var_8260, ",");
  }

  var_05 = 1000;
  var_06 = 1000;
  if(var_04.size > 0) {
    var_05 = int(var_04[0]);
    if(var_04.size > 1) {
      var_06 = int(var_04[1]);
    } else {
      var_06 = 1000;
    }
  }

  var_07 = 0;
  if(lib_0547::func_5565(param_00.var_81C7, "rand_wallbuy")) {
    var_07 = 1;
  }

  if(isDefined(level.override_weapon_costs)) {
    var_05 = int(level.override_weapon_costs);
    var_06 = int(level.override_weapon_costs / 2);
  }

  var_10 = [];
  var_11 = undefined;
  var_12 = getEntArray(param_00.var_01A2, "targetname");
  foreach(var_14 in var_12) {
    var_15 = var_14.var_0165;
    if(!isDefined(var_15)) {
      var_10 = common_scripts\utility::func_0F6F(var_10, var_14);
      continue;
    }

    switch (var_15) {
      case "gun_card":
        var_11 = var_14;
        break;
    }
  }

  var_17 = function_021F(param_00.var_01A2, "targetname");
  param_00.var_A7E9 = var_10;
  param_00.var_A7E3 = var_17;
  if(isDefined(var_11)) {
    param_00.wallbuyguncard = var_11;
    param_00.wallbuyguncard method_805C();
  }

  for(var_18 = 0; var_18 < 4; var_18++) {
    var_19 = var_10[var_18];
    var_19.var_A9E3 = var_01;
    var_19.var_A9BD = var_02;
    if(isDefined(var_11)) {
      var_19.gun_card = var_11;
    }

    level thread func_A7EA(var_19, var_17[var_18], var_03, var_05, var_06, var_07);
  }
}

func_ABE9(param_00, param_01, param_02, param_03) {
  var_04 = lib_0547::func_AC4B(param_01, "buy");
  var_04 lib_0547::func_AC44("cost", param_02);
  var_04 lib_0547::func_AC48("weapon", param_03);
  var_04 lib_0547::func_AC48("sub_type", param_00);
  var_04 lib_0547::func_AC4D();
}

func_A7EA(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  param_00.var_2955 = param_03;
  param_00.var_A9C2 = param_03;
  param_00.var_2925 = param_04;
  param_00.var_0DB5 = param_04;
  param_00.var_A9E0 = param_02;
  param_00.var_6C5C = param_02;
  param_00.var_9DA0 = 0;
  param_00.var_82EF = param_01;
  if(!common_scripts\utility::func_562E(param_05)) {
    param_00 thread func_A7E1();
  }

  var_06 = lib_0547::func_585C(param_02);
  var_07 = lib_0547::func_5864(param_02);
  if(lib_0547::func_581A(param_00) && !var_06) {
    var_08 = level.var_A7F1.size;
    level.var_A7F1[var_08]["baseName"] = param_00.var_6C5C + "_mp";
    level.var_A7F1[var_08]["displayModel"] = getweaponmodel(param_02);
  }

  if(!common_scripts\utility::func_562E(param_05)) {
    lib_0547::func_8A4F(param_00, ::func_10E6, ::func_4D1B);
  } else {
    return;
  }

  for(;;) {
    var_09 = param_00 lib_0547::func_A795();
    var_0A = var_09[0];
    var_0B = var_09[1];
    var_0C = 0;
    var_0D = var_0A getcurrentprimaryweapon();
    if(lib_0547::func_57AF(var_0D) || lib_0547::func_5862(var_0D)) {
      continue;
    }

    var_0E = param_00.var_2955;
    var_0F = func_454B(var_0A, param_02);
    if(isDefined(level.zmb_trigger_weapon_get_func)) {
      var_0F = [[level.zmb_trigger_weapon_get_func]](var_0A, param_00);
    }

    if(lib_0547::func_73F9(var_0A, var_0F)) {
      var_0E = param_00.var_2925;
      var_0C = 1;
      if(func_4B6A(var_0A, var_0F)) {
        func_300A(var_0A, var_06);
        continue;
      }
    }

    if(var_0B == "token") {
      var_0A maps\mp\gametypes\zombies::func_90F6(param_00.var_9A84);
    } else if(!var_0A maps\mp\gametypes\zombies::func_11C2(var_0E)) {
      var_0A thread lib_054E::func_0695("needmoney");
      continue;
    }

    var_0A thread lib_054E::func_62D9();
    param_00 thread func_1366();
    var_0A thread lib_054E::playerbuyweapon();
    if(var_06) {
      func_A7D5(var_0A, var_0F);
    } else if(var_07) {
      wallbuygivemelee(var_0A, var_0F);
    } else {
      func_A7D6(var_0A, var_0F, undefined, 0);
      lib_0547::func_0A00(var_0A, var_0F);
    }

    func_ABE9("normal_wallbuy", self.var_0116, var_0E, var_0F);
    if(maps\mp\_utility::func_4571() == "mp_zombie_island") {
      var_10 = var_0A maps\mp\gametypes\_playerlogic::func_4005();
      if(!isDefined(var_0A.magicboxweaponsrolled)) {
        var_0A.magicboxweaponsrolled = [];
      }

      if(common_scripts\utility::func_0F79(var_10, var_0F) || !common_scripts\utility::func_0F79(var_0A.magicboxweaponsrolled, var_0F)) {
        var_0A notify("invalid_wallbuy");
      }
    }

    if(var_0C) {
      lib_0547::func_4AE4(var_0A, "ammo", var_0E, var_0F, "none");
      lib_0555::func_83DD("buy_ammo", var_0A, var_0F);
    } else {
      lib_0547::func_4AE4(var_0A, "weapons", var_0E, var_0F, "none");
      lib_0555::func_83DD("buy_weapon", var_0A, var_0F);
      level.var_400E[level.var_400E.size] = ["survivalist_set 3 -1", var_0A];
      level.var_400E[level.var_400E.size] = ["survivalist_set 4 -1", var_0A];
    }

    param_00 thread func_A7E2(var_0C);
  }
}

func_A7E1() {
  self.var_82EF.var_243B = [];
  self.var_82EF setscriptablepartstate("base", "buy_loop_open");
  self.var_82EF.var_829E = 0;
  self.var_82EF.var_82A0 = 0;
  thread func_A7E4(1);
}

func_A7E4(param_00) {
  self.var_82EF endon("immediate_state_change");
  if(!isDefined(self.var_82EF)) {
    return;
  }

  if(self.var_82EF.var_82A0 && !common_scripts\utility::func_562E(param_00)) {
    self.var_82EF.var_09B6 = 1;
    return;
  }

  var_01 = self.var_82EF.var_243B.size > 0;
  if(param_00) {
    var_02 = 0;
    if(var_01 && self.var_82EF.var_829E != 2) {
      self.var_82EF.var_829E = 2;
      self.var_82EF setscriptablepartstate("base", "buy_loop_closed");
      var_02 = 1;
    } else if(!var_01 && self.var_82EF.var_829E != 0) {
      self.var_82EF.var_829E = 0;
      self.var_82EF setscriptablepartstate("base", "buy_loop_open");
      var_02 = 1;
    }

    if(var_02) {
      self.var_82EF.var_82A0 = 0;
      self.var_82EF notify("immediate_state_change");
      self.var_82EF notify("script_state_change");
      return;
    }

    return;
  }

  var_03 = 0;
  switch (self.var_82EF.var_829E) {
    case 2:
      if(!var_02) {
        var_04 = lib_0380::func_2889("zmb_wallbuy_open", undefined, self.var_A9E3);
        lib_0378::func_8D14(var_04);
        self.var_82EF.var_829E = 3;
        self.var_82EF setscriptablepartstate("base", "buy_loop_opening");
        self.var_82EF.var_82A0 = 1;
        self.var_82EF notify("script_state_change");
        wait(1.133333);
        self.var_82EF.var_829E = 0;
        self.var_82EF setscriptablepartstate("base", "buy_loop_open");
        self.var_82EF.var_82A0 = 0;
        self.var_82EF notify("script_state_change");
        var_03 = 1;
      }
      break;

    case 0:
      if(var_02) {
        var_05 = lib_0380::func_2889("zmb_wallbuy_close", undefined, self.var_A9E3);
        lib_0378::func_8D14(var_05);
        self.var_82EF setscriptablepartstate("base", "buy_loop_closing");
        self.var_82EF.var_829E = 1;
        self.var_82EF.var_82A0 = 1;
        self.var_82EF notify("script_state_change");
        wait(1.033333);
        self.var_82EF setscriptablepartstate("base", "buy_loop_closed");
        self.var_82EF.var_829E = 2;
        self.var_82EF.var_82A0 = 0;
        self.var_82EF notify("script_state_change");
        var_03 = 0;
      }
      break;

    default:
      break;
  }

  if(var_03 && common_scripts\utility::func_562E(self.var_82EF.var_09B6)) {
    self.var_82EF.var_09B6 = undefined;
    thread func_A7E4(0);
  }
}

func_A7D2(param_00) {
  self.var_82EF.var_243B[param_00] = 1;
  if(self.var_82EF.var_243B.size == 1) {
    thread func_A7E4(0);
  }
}

func_A7DD(param_00) {
  self.var_82EF.var_243B[param_00] = undefined;
  if(self.var_82EF.var_243B.size == 0) {
    thread func_A7E4(0);
  }
}

func_A7E2(param_00) {
  var_01 = self;
  if(!isDefined(self.var_82EF)) {
    return;
  }

  var_02 = self.var_82EF method_85CE();
  if(!param_00) {
    if(isDefined(var_01.var_6C1D) && isPlayer(self.var_230A)) {
      var_01.var_6C1D hidefromclient(self.var_230A);
    }
  } else if(var_02 == "animated_zmb_wall_buy_box") {
    self.var_82EF setscriptablepartstate("ammo", "hide");
  }

  func_A7E7(self);
  thread func_A7D2("purchase");
  func_A7EE(2);
  wait(0.25);
  if(!param_00) {
    if(isDefined(var_01.var_6C1D) && isPlayer(self.var_230A)) {
      var_01.var_6C1D showtoclient(self.var_230A);
    }
  } else if(var_02 == "animated_zmb_wall_buy_box") {
    self.var_82EF setscriptablepartstate("ammo", "show");
  }

  thread func_A7DD("purchase");
  wait(1.2);
  func_A7E8(self);
}

func_A7EE(param_00) {
  for(;;) {
    self.var_82EF waittill("script_state_change");
    if(self.var_82EF.var_829E == param_00) {
      return;
    }
  }
}

func_2079(param_00, param_01, param_02) {
  var_03 = [6, 0, 4];
  if(isDefined(param_02)) {
    var_03 = param_02;
  }

  var_04 = param_00.var_0116;
  var_05 = anglestoaxis(param_00.var_001D);
  var_04 = var_04 + var_05["forward"] * var_03[0];
  var_04 = var_04 + var_05["right"] * var_03[1];
  var_04 = var_04 + var_05["up"] * var_03[2];
  var_06 = param_01 method_8549(0, 1, 0);
  var_07 = var_04 - var_06;
  param_01 method_808C();
  param_01.var_0116 = param_01.var_0116 + var_07;
}

func_4B6A(param_00, param_01) {
  if(param_00 getweaponammostock(param_01) < weaponmaxammo(param_01, param_00)) {
    return 0;
  }

  if(param_00 getweaponammoclip(param_01) < weaponclipsize(param_01, param_00)) {
    return 0;
  }

  return 1;
}

func_300A(param_00, param_01) {
  param_00 method_860F("zmb_ui_purchase_fail", param_00);
  if(param_01) {
    lib_0555::func_83DD("full_equip", param_00);
    return;
  }

  lib_0555::func_83DD("full_ammo", param_00);
}

func_4734(param_00) {
  return function_0323(param_00.var_6C5C);
}

func_4733(param_00) {
  return lib_0547::func_4474(param_00.var_2955);
}

func_4412(param_00) {
  return &"ZOMBIES_WALL_BUY_AMMO";
}

func_4411(param_00) {
  return lib_0547::func_4474(param_00.var_2925);
}

func_473B() {
  var_00 = [];
  var_01 = self getweaponslistprimaries();
  foreach(var_03 in var_01) {
    if(!maps\mp\_utility::func_5670(var_03)) {
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

wallbuygivemelee(param_00, param_01) {
  if(lib_0547::func_5864(param_01)) {
    param_00 lib_0586::func_078C(param_01);
    param_00 lib_0586::func_078E(param_01);
  }
}

func_A7D6(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(lib_0547::func_73F9(param_00, param_01)) {
    func_AC57(param_00, param_01);
    param_00 notify("wallbuy_ammo_purchased");
    if(isDefined(param_00.var_7EFE)) {
      param_00.var_7EFE = param_00.var_7EFE + 1;
    }

    return;
  }

  if(param_00 lib_057A::func_A260()) {
    param_00 notify("weapon_consumable_force_take");
  }

  if(function_01D4(param_01) == "primary") {
    if(!param_00 lib_0586::func_05DF(param_01)) {
      var_04 = param_00 lib_0586::func_0637();
      if(param_03 && func_8B57(var_04)) {
        param_00 func_348F(var_04);
      } else if(function_01A9(var_04) != "melee") {
        param_00 lib_0586::func_0790(var_04);
      }
    }
  }

  maps\mp\gametypes\zombies::func_283D(param_00, param_01);
  if(isDefined(param_00.var_7F10)) {
    param_00.var_7F10 = param_00.var_7F10 + 1;
  }

  var_05 = undefined;
  var_06 = lib_0547::func_AAF9(param_01, 0, 0);
  if(var_06 != "none") {
    var_07 = function_02FF(var_06, "_zm") + "_mp";
    var_08 = maps\mp\zombies\zombie_weapon_kits_shared::func_5842(var_07);
    if(var_08) {
      var_05 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(), "weaponBuildKits", var_07, "charm");
    }
  }

  param_00 lib_0586::func_078C(param_01, undefined, undefined, var_05);
  param_00 givemaxammo(param_01);
  param_00 func_4796(param_01);
  param_00 lib_0586::func_078E(param_01);
  param_00 notify("new_wallbuy_weapon");
  func_AABC(param_00);
}

func_A7DC(param_00) {
  foreach(var_02 in param_00.var_4D4D) {
    foreach(var_04 in var_02.var_A7E3) {
      var_04 hudoutlinedisableforclient(param_00);
    }
  }

  param_00.var_4D4D = [];
}

func_A7D9() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00.var_4D4D = [];
  self.var_A7DA = 1;
  childthread func_A7DB(var_00);
  var_01 = 0.2;
  while(isDefined(var_00) && var_00 getentitynumber() % 4 != int(gettime() / 50) % 4) {
    wait 0.05;
  }

  while(isDefined(var_00)) {
    wait(var_01);
    if(!isalive(var_00)) {
      func_A7DC(var_00);
      break;
    }

    if(!self.var_A7DA) {
      continue;
    }

    self.var_A7DA = 0;
    if(lib_0547::func_577E(self)) {
      continue;
    }

    var_02 = self getcurrentweapon();
    if(var_02 == "none") {
      continue;
    }

    var_03 = self getfractionmaxammo(var_02);
    if(var_03 >= 0.1) {
      func_A7DC(var_00);
      continue;
    }

    foreach(var_05 in level.var_A7DE) {
      if(common_scripts\utility::func_0F79(var_00.var_4D4D, var_05)) {
        continue;
      }

      var_06 = var_05.var_0165;
      if(lib_0547::func_5816(var_06)) {
        continue;
      }

      var_07 = lib_0586::func_0791(var_02, var_06);
      wait(var_01);
      if(common_scripts\utility::func_562E(var_07)) {
        foreach(var_09 in var_05.var_A7E3) {
          var_09 hudoutlineenableforclient(var_00, 0, 0);
        }

        var_00.var_4D4D = common_scripts\utility::func_0F6F(var_00.var_4D4D, var_05);
      }
    }
  }
}

func_A7DB(param_00) {
  while(isDefined(param_00)) {
    var_01 = common_scripts\utility::func_A70E(self, "weapon_fired", self, "weapon_change", self, "wallbuy_ammo_purchased", self, "death", level, "maxAmmoPickup");
    var_02 = var_01[0];
    var_03 = var_01[1];
    self.var_A7DA = 1;
  }
}

func_8B57(param_00) {
  return 1;
}

func_348F(param_00) {
  var_01 = self getweaponammoclip(param_00, "right");
  var_02 = self getweaponammoclip(param_00, "left");
  var_03 = self getweaponammostock(param_00);
  var_04 = weaponmaxammo(param_00);
  if(var_03 > var_04) {
    var_03 = var_04;
  }

  var_05 = self dropitem(param_00);
  if(!isDefined(var_05)) {
    return;
  }

  var_05 method_817E(var_01, var_03, var_02);
  var_05.var_0117 = self;
  var_05.var_01A5 = "dropped_weapon";
  var_05 thread maps\mp\gametypes\_weapons::func_A934();
  var_05 thread maps\mp\gametypes\_weapons::func_2D45();
  lib_0586::func_0790(param_00);
}

func_AABC(param_00) {
  if(lib_0547::func_577E(param_00)) {
    if(isDefined(level.var_A9E2["LastStand"])) {
      setmatchdata("players", param_00.var_2418, "end_misses", level.var_A9E2["LastStand"]);
      setmatchdata("players", param_00.var_2418, "end_games_played", level.var_A9E2["LastStand"]);
      return;
    }

    return;
  }

  var_01 = param_00 getweaponslistprimaries();
  var_02 = [];
  foreach(var_04 in var_01) {
    var_02[var_02.size] = getweapondisplayname(var_04);
  }

  if(isDefined(var_02[0]) && isDefined(level.var_A9E2[var_02[0]])) {
    setmatchdata("players", param_00.var_2418, "end_misses", level.var_A9E2[var_02[0]]);
  }

  if(isDefined(var_02[1]) && isDefined(level.var_A9E2[var_02[1]])) {
    setmatchdata("players", param_00.var_2418, "end_games_played", level.var_A9E2[var_02[1]]);
  }
}

func_A7D5(param_00, param_01, param_02) {
  if(lib_0547::func_5863(param_01)) {
    var_03 = param_00 method_834A();
    if(var_03 != param_01) {
      param_00 lib_0586::func_0790(var_03);
      param_00 method_8349(param_01);
      param_00 lib_0586::func_078C(param_01);
      func_3AC1(param_00, param_01);
      param_00 notify("new_equipment");
      return;
    }

    param_00 method_82FA(param_01, param_00 getweaponammoclip(param_01) + 1);
    return;
  }

  if(lib_0547::func_5866(param_01)) {
    var_04 = param_00 method_831F();
    if(var_04 != param_01) {
      param_00 lib_0586::func_0790(var_04);
      param_00 method_831E(param_01);
      param_00 lib_0586::func_078C(param_01);
      func_3AC1(param_00, param_01);
      param_00.zmb_plr_tactical = param_01;
      if(param_01 == "jack_in_box_decoy_zm") {
        param_00 thread lib_057D::func_4766();
      }

      if(isDefined(level.var_A9E2[param_01])) {
        setmatchdata("players", param_00.var_2418, "endHits", level.var_A9E2[param_01]);
      }

      param_00 notify("new_equipment");
      return;
    }

    param_00 method_82FA(param_01, param_00 getweaponammoclip(param_01) + 1);
    return;
  }
}

func_3AC1(param_00, param_01) {
  var_02 = param_00;
  if(isDefined(level.zmb_grenadier_immune_weapons) && isDefined(param_01) && is_grenadier_immune_weapon(param_01)) {
    var_02 = undefined;
  }

  var_03 = weaponclipsize(param_01, var_02);
  param_00 method_82FA(param_01, var_03);
}

is_grenadier_immune_weapon(param_00) {
  if(!isDefined(level.zmb_grenadier_immune_weapons)) {
    return 0;
  }

  return common_scripts\utility::func_0F79(level.zmb_grenadier_immune_weapons, param_00);
}

func_AC57(param_00, param_01) {
  param_01 = param_00 lib_0586::func_078A(param_01);
  if(!isDefined(param_01)) {
    return;
  }

  var_02 = weaponclipsize(param_01, param_00);
  param_00 method_82FA(param_01, var_02, "right");
  if(issubstr(param_01, "akimbo")) {
    param_00 method_82FA(param_01, var_02, "left");
  }

  param_00 givemaxammo(param_01);
  param_00 func_4796(param_01);
  param_00 lib_0586::func_078E(param_01, 1);
}

func_4796(param_00) {
  if(issubstr(param_00, "iw5_em1zm_mp")) {
    maps\mp\gametypes\zombies::func_7456();
  }

  if(isDefined(level.var_4797)) {
    self[[level.var_4797]](param_00);
  }
}

func_5F79() {
  var_00 = common_scripts\utility::func_46B7("magic_box_map", "targetname");
  common_scripts\utility::func_0FB2(var_00, ::func_5F77);
}

func_5F77() {
  self.var_1B71 = [];
  var_00 = getEntArray(self.var_01A2, "targetname");
  var_01 = common_scripts\utility::func_46B7(self.var_01A2, "targetname");
  var_02 = common_scripts\utility::func_0F73(var_00, var_01);
  foreach(var_04 in var_02) {
    switch (var_04.var_0165) {
      case "current":
        var_04 method_805C();
        self.var_28F5 = var_04;
        break;

      case "all":
        var_04 method_805C();
        self.var_0BCD = var_04;
        break;

      case "box_loc":
        self.var_1B71[self.var_1B71.size] = var_04;
        break;

      case "breach_map":
        if(isDefined(level.var_1B97)) {
          level thread[[level.var_1B97]](var_04);
        }
        break;

      default:
        break;
    }
  }

  common_scripts\utility::func_3C9F("magic_box_init");
  foreach(var_07 in self.var_1B71) {
    thread func_5F76(var_07);
  }

  thread func_5F75();
  thread func_5F78();
}

func_5F76(param_00) {
  for(;;) {
    common_scripts\utility::func_3C9F(param_00.var_81A1);
    var_01 = 0;
    while(maps\mp\_utility::func_3FA0("fire_sale")) {
      var_01 = 1;
      wait 0.05;
    }

    var_02 = 0;
    while(maps\mp\_utility::func_3FA0("power_off")) {
      var_02 = 1;
      wait 0.05;
    }

    if(var_01 || var_02) {
      common_scripts\utility::func_3CA9(param_00.var_81A1);
      continue;
    }

    self.var_28F5 method_805B();
    self.var_28F5.var_0116 = param_00.var_0116;
    common_scripts\utility::func_3CA9(param_00.var_81A1);
  }
}

func_5F75() {
  for(;;) {
    self.var_0BCD method_805C();
    maps\mp\_utility::func_3FA5("fire_sale");
    self.var_0BCD method_805B();
    self.var_28F5 method_805C();
    while(maps\mp\_utility::func_3FA0("fire_sale")) {
      wait 0.05;
    }

    self.var_28F5 method_805B();
  }
}

func_5F78() {
  for(;;) {
    maps\mp\_utility::func_3FA5("power_off");
    self.var_0BCD method_805C();
    self.var_28F5 method_805C();
    while(maps\mp\_utility::func_3FA0("power_off")) {
      wait 0.05;
    }

    self.var_28F5 method_805B();
  }
}

func_5FF2() {
  level.var_A9E2 = [];
  level.var_A9E2["iw5_rw1zm_mp"] = 1;
  level.var_A9E2["iw5_vbrzm_mp"] = 2;
  level.var_A9E2["iw5_gm6zm_mp"] = 3;
  level.var_A9E2["iw5_rhinozm_mp"] = 4;
  level.var_A9E2["iw5_lsatzm_mp"] = 5;
  level.var_A9E2["iw5_asawzm_mp"] = 6;
  level.var_A9E2["iw5_ak12zm_mp"] = 7;
  level.var_A9E2["iw5_bal27zm_mp"] = 8;
  level.var_A9E2["iw5_himarzm_mp"] = 9;
  level.var_A9E2["iw5_asm1zm_mp"] = 10;
  level.var_A9E2["iw5_sn6zm_mp"] = 11;
  level.var_A9E2["iw5_sac3zm_mp"] = 12;
  level.var_A9E2["iw5_fusionzm_mp"] = 13;
  level.var_A9E2["distraction_drone_zombie_mp"] = 14;
  level.var_A9E2["dna_aoe_grenade_zombie_mp"] = 15;
  level.var_A9E2["iw5_exocrossbowzm_mp"] = 16;
  level.var_A9E2["iw5_mahemzm_mp"] = 17;
  level.var_A9E2["iw5_em1zm_mp"] = 18;
  level.var_A9E2["iw5_dlcgun1zm_mp"] = 19;
  level.var_A9E2["iw5_arx160zm_mp"] = 20;
  level.var_A9E2["iw5_mp11zm_mp"] = 21;
  level.var_A9E2["explosive_drone_zombie_mp"] = 22;
  level.var_A9E2["contact_grenade_zombies_mp"] = 23;
  level.var_A9E2["iw5_hbra3zm_mp"] = 24;
  level.var_A9E2["iw5_hmr9zm_mp"] = 25;
  level.var_A9E2["iw5_maulzm_mp"] = 26;
  level.var_A9E2["iw5_m182sprzm_mp"] = 27;
  level.var_A9E2["iw5_uts19zm_mp"] = 28;
  level.var_A9E2["contact_grenade_throw_zombies_mp"] = 29;
  level.var_A9E2["explosive_drone_throw_zombie_mp"] = 30;
  level.var_A9E2["distraction_drone_throw_zombie_mp"] = 31;
  level.var_A9E2["dna_aoe_grenade_throw_zombie_mp"] = 32;
  level.var_A9E2["iw5_titan45zm_mp"] = 33;
  level.var_A9E2["LastStand"] = 34;
  level.var_A9E2["iw5_microwavezm_mp"] = 35;
  level.var_A9E2["iw5_linegunzm_mp"] = 36;
  level.var_A9E2["frag_grenade_zombies_mp"] = 37;
  level.var_A9E2["frag_grenade_throw_zombies_mp"] = 38;
  level.var_A9E2["iw5_dlcgun2zm_mp"] = 39;
  level.var_A9E2["iw5_dlcgun3zm_mp"] = 40;
  level.var_A9E2["teleport_zombies_mp"] = 41;
  level.var_A9E2["repulsor_zombie_mp"] = 42;
}

func_09C8(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_01)) {
    param_01 = "none";
  }

  if(!isDefined(param_02)) {
    param_02 = "none";
  }

  if(!isDefined(param_03)) {
    param_03 = "none";
  }

  if(!lib_0547::func_5844(param_00) && !lib_0547::isvalidequipmentzombies(param_00)) {
    return;
  }

  if(!isDefined(level.var_5F7F)) {
    level.var_5F7F = [];
  }

  var_06 = getweaponmodel(param_00);
  var_07 = level.var_5F7F.size;
  level.var_5F7F[var_07]["baseNameNoMP"] = param_00;
  level.var_5F7F[var_07]["baseNameNoZM"] = function_02FF(param_00, "_zm");
  level.var_5F7F[var_07]["baseName"] = param_00 + "_mp";
  level.var_5F7F[var_07]["fullName"] = param_00 + "_mp";
  level.var_5F7F[var_07]["displayModel"] = var_06;
  level.var_5F7F[var_07]["attachment1"] = param_01;
  level.var_5F7F[var_07]["attachment2"] = param_02;
  level.var_5F7F[var_07]["attachment3"] = param_03;
  level.var_5F7F[var_07]["limit"] = param_04;
  if(isDefined(param_05)) {
    level.var_5F7F[var_07]["forceSelect"] = randomint(param_05);
  }

  if(!lib_0547::func_585C(level.var_5F7F[var_07]["baseName"])) {
    level.var_5F7F[var_07]["fullName"] = maps\mp\gametypes\_class::func_1D66(param_00, param_01, param_02, param_03, 0, 0, 0, 0, 0, 0, 0, 0);
  }

  var_09 = function_0323(level.var_5F7F[var_07]["fullName"]);
  level.var_5F7F[var_07]["displayString"] = var_09;
}

func_7CEA(param_00) {
  var_01 = undefined;
  for(var_02 = 0; var_02 < level.var_5F7F.size; var_02++) {
    if(level.var_5F7F[var_02]["baseNameNoMP"] == param_00) {
      var_01 = var_02;
      break;
    }
  }

  if(isDefined(var_01)) {
    level.var_5F7F = common_scripts\utility::func_0F9A(level.var_5F7F, var_01);
  }
}

func_5F7B() {
  level endon("game_ended");
  func_5305();
  level.var_5F7C = 0;
  level.var_6AE8 = [];
  common_scripts\utility::func_3C87("magic_box_init");
  common_scripts\utility::func_3C87("magic_box_moved");
  level.var_5F74 = getEntArray("magic_box", "targetname");
  if(level.var_5F74.size == 0) {
    return;
  }

  var_00 = undefined;
  foreach(var_02 in level.var_5F74) {
    level thread maps\mp\_utility::func_6F74(::magicboxweaponvisibility, var_02);
    var_03 = getEntArray(var_02.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      if(var_05.var_003A == "script_brushmodel") {
        var_02.var_24E3 = var_05;
        continue;
      }

      if(var_05.var_003A == "script_model") {
        var_02.var_6298 = var_05;
      }
    }

    var_07 = function_021F(var_02.var_01A2, "targetname");
    foreach(var_05 in var_07) {
      var_02.var_82EF = var_05;
    }

    var_0A = func_456D(var_02);
    if(isDefined(var_02.var_6298)) {
      if(isDefined(var_02.var_6298.var_01A2)) {
        var_0B = getent(var_02.var_6298.var_01A2, "targetname");
        if(isDefined(var_0B) && var_0B.var_003B == "light") {
          var_02.var_5CCE = var_0B;
          var_02.var_5CCE.var_5D70 = var_02.var_5CCE method_81DE();
          var_02.var_5CCE.var_5D6F = 0.1;
        }
      }
    }

    var_02.var_08BE = 0;
    var_02.var_56C7 = 0;
    var_02.var_5759 = 0;
    if(isDefined(var_02.var_819A)) {
      common_scripts\utility::func_3C87(var_02.var_819A);
    }

    if(isDefined(level.var_6AD1)) {
      [[level.var_6AD1]](var_02);
    }

    if(lib_0547::func_5565(var_02.var_8260, "start_location")) {
      var_00 = var_02;
    }
  }

  if(!isDefined(var_00)) {
    var_00 = common_scripts\utility::func_7A33(level.var_5F74);
  }

  var_00.var_08BE = 1;
  wait(2);
  foreach(var_02 in level.var_5F74) {
    func_6AE1(var_02);
  }

  common_scripts\utility::func_3C8F("magic_box_init");
  for(;;) {
    func_A922(var_00, 0);
    while(maps\mp\_utility::func_3FA0("fire_sale")) {
      while(maps\mp\_utility::func_3FA0("fire_sale") || var_00.var_56C7) {
        wait(0.15);
      }

      var_00 notify("fireSaleOver");
    }

    common_scripts\utility::func_3C8F("magic_box_moved");
    var_0F = [];
    foreach(var_11 in level.var_5F74) {
      if(var_00 == var_11) {
        continue;
      }

      if(func_57C1(var_11)) {
        continue;
      }

      if(var_11.var_56C7) {
        continue;
      }

      var_0F[var_0F.size] = var_11;
    }

    if(var_0F.size > 0) {
      var_00.var_08BE = 0;
      while(isDefined(var_00.var_2A75)) {
        wait 0.05;
      }

      var_00 = var_0F[randomint(var_0F.size)];
      var_00.var_08BE = 1;
    }
  }
}

func_08D7(param_00, param_01, param_02) {
  param_00.var_267B = func_43FF(param_02);
  if(1 && isDefined(param_01)) {
    param_01.var_1B73 = 1;
    param_01.var_1B6F = param_00.var_267B;
    param_01.var_6642 = 1;
  }

  if(0) {
    param_00 sethintstring(func_4401());
    param_00 setsecondaryhintstring(lib_0547::func_4474(param_00.var_267B));
  }
}

func_2A7B(param_00, param_01) {
  if(0) {
    param_00 sethintstring(func_4520());
    param_00 setsecondaryhintstring(lib_0547::func_4474(0));
  }

  if(1 && isDefined(param_01)) {
    param_01.var_1B73 = 0;
  }
}

func_6AB4(param_00) {
  if(isDefined(level.var_08AD)) {
    [[level.var_08AD]](param_00);
  }

  var_01 = func_456D(param_00);
  thread func_135C(var_01);
  if(isDefined(param_00.var_5CCE)) {
    param_00.var_5CCE method_81DF(param_00.var_5CCE.var_5D70);
  }

  if(isDefined(param_00.var_819A)) {
    common_scripts\utility::func_3C8F(param_00.var_819A);
  }

  if(isDefined(param_00.var_24E3)) {
    param_00.var_24E3 solid();
  }
}

func_6AE1(param_00, param_01) {
  func_2A7B(param_00);
  if(isDefined(level.var_2A77)) {
    [[level.var_2A77]](param_00);
  }

  var_02 = func_456D(param_00);
  thread func_135B(var_02);
  if(isDefined(param_00.var_5CCE)) {
    param_00.var_5CCE method_81DF(param_00.var_5CCE.var_5D6F);
  }

  if(isDefined(param_00.var_819A)) {
    common_scripts\utility::func_3C7B(param_00.var_819A);
  }

  if(isDefined(param_00.var_24E3)) {
    param_00.var_24E3 notsolid();
  }
}

func_5F73() {
  return common_scripts\utility::func_3C83("magic_box_moved") && common_scripts\utility::func_3C77("magic_box_moved");
}

func_135C(param_00) {
  if(!isDefined(param_00.var_8F40)) {
    var_01 = param_00.var_0116;
    if(isDefined(level.var_456E)) {
      var_01 = [[level.var_456E]](param_00);
    }

    param_00.var_8F40 = spawn("script_origin", var_01);
    param_00.var_8F40 method_861B(0);
    wait 0.05;
  }

  lib_0378::func_8D74("mystery_box_attract_on", param_00);
}

func_135B(param_00) {
  if(!isDefined(param_00.var_8F40)) {
    return;
  }

  param_00.var_8F40 method_861B(0, 1);
  wait(1);
  param_00.var_8F40 stoploopsound();
  wait 0.05;
  param_00.var_8F40 delete();
  lib_0378::func_8D74("mystery_box_attract_off", param_00);
}

func_135A(param_00) {
  param_00.var_8F40 method_861B(0, 0.5);
  wait(0.5);
  param_00.var_8F40 stoploopsound();
}

func_1366() {
  var_00 = self;
  if(isDefined(var_00.var_6C1D)) {
    var_00.var_6C1D method_861B(0, 0.5);
  }

  wait(3.5);
  if(isDefined(var_00.var_6C1D)) {
    var_00.var_6C1D method_861B(1, 0.5);
  }
}

func_5F7E() {
  self endon("fireSaleOver");
  self endon("deactivated");
  return lib_0547::func_A795();
}

func_57C1(param_00) {
  return isDefined(param_00.var_0165) && param_00.var_0165 == "scripted_magic_box";
}

func_7BEE() {
  self endon("deactivated");
  self endon("unregister_prompts");
  if(!isDefined(self.var_53FB)) {
    self.var_53FB = [];
    for(var_00 = 0; var_00 < 4; var_00++) {
      var_01 = spawnStruct();
      self.var_53FB = common_scripts\utility::func_0F6F(self.var_53FB, var_01);
    }
  }

  if(!isDefined(self.var_4DBB)) {
    self.var_4DBB = [];
    for(var_00 = 0; var_00 < 4; var_00++) {
      var_01 = spawnStruct();
      self.var_4DBB = common_scripts\utility::func_0F6F(self.var_4DBB, var_01);
    }
  }

  func_86D1();
  for(;;) {
    level waittill("connected", var_02);
    func_8A32(var_02);
  }
}

func_A041() {
  self notify("unregister_prompts");
  foreach(var_01 in level.var_744A) {
    var_02 = var_01 getentitynumber();
    var_03 = self.var_53FB[var_02];
    func_2A7B(self, var_03.var_7778);
    var_03.var_7778.var_2F74 = 1;
    var_04 = self.var_4DBB[var_02];
    var_04.var_4D91.var_2F74 = 1;
  }
}

func_8A32(param_00) {
  var_01 = param_00 getentitynumber();
  var_02 = self.var_53FB[var_01];
  if(isDefined(var_02.var_7778)) {
    var_02.var_7778.var_2F74 = 0;
  } else {
    var_02.var_7778 = lib_0552::func_7BED(param_00, self);
    var_02.var_7778.var_1B72 = self;
  }

  func_08D7(self, var_02.var_7778, param_00);
  var_03 = self.var_4DBB[var_01];
  if(isDefined(var_03.var_4D91)) {
    var_03.var_4D91.var_2F74 = 0;
    return;
  }

  var_03.var_4D91 = lib_0559::func_7BE2(param_00, self, "mystery");
}

func_86D1() {
  if(1) {
    foreach(var_01 in level.var_744A) {
      func_8A32(var_01);
    }
  }
}

func_861C() {
  foreach(var_01 in level.var_5F74) {
    if(var_01.var_08BE) {
      var_01 func_86D1();
    }
  }
}

func_86D2(param_00, param_01) {
  var_02 = param_00 getentitynumber();
  var_03 = self.var_53FB[var_02];
  var_03.var_7778.var_1B73 = 2;
  var_03.var_7778.var_1B74 = param_01;
  var_03.var_7778.var_6642 = 1;
}

func_A922(param_00, param_01) {
  var_02 = 0;
  var_03 = 0;
  var_04 = randomintrange(4, 7);
  var_05 = func_456D(param_00);
  var_06 = var_05.var_0116;
  param_00.var_5C10 = "";
  if(isDefined(level.var_86C4)) {
    [[level.var_86C4]](param_00);
  }

  func_6AB4(param_00);
  if(1) {
    param_00 thread func_7BEE();
  }

  for(;;) {
    if(param_01 && !maps\mp\_utility::func_3FA0("fire_sale")) {
      break;
    }

    func_08D7(param_00);
    param_00 func_86D1();
    var_07 = param_00 func_5F7E();
    if(!isDefined(var_07)) {
      break;
    }

    var_08 = var_07;
    var_09 = var_08[0];
    var_0A = var_08[1];
    var_0B = var_09 lib_0573::func_4B7B();
    var_0C = var_09 lib_056B::func_9D1C();
    var_0D = var_09 lib_0579::func_4BA5();
    var_0E = maps\mp\_utility::func_3FA0("fire_sale") || var_0B || func_57C1(param_00) || var_0D || var_0C;
    var_0F = var_03 >= var_04 && !var_0E && level.var_5F74.size > 1;
    var_10 = func_43FF(var_09);
    var_11 = var_09 getcurrentprimaryweapon();
    if(lib_0547::func_57AF(var_11) || lib_0547::func_5862(var_11)) {
      continue;
    }

    if(var_0F && !var_09 maps\mp\gametypes\zombies::func_1F32(var_10)) {
      var_09 thread lib_054E::func_0695("needmoney");
      continue;
    }

    if(!var_0F && !isDefined(self.var_2A75)) {
      if(var_0A == "token") {
        var_09 maps\mp\gametypes\zombies::func_90F6(param_00.var_9A84);
      } else if(!var_09 maps\mp\gametypes\zombies::func_11C2(var_10)) {
        var_09 thread lib_054E::func_0695("needmoney");
        continue;
      }
    }

    if(!var_0F && !isDefined(self.var_2A75)) {
      if(var_02 == 0) {
        var_09 thread lib_054E::func_73E4();
      }

      level notify("magicBoxUse", param_00);
      if(maps\mp\_utility::func_3FA0("fire_sale")) {} else if(var_0C) {
        var_09 lib_056B::func_9D1D();
      } else {
        var_09 lib_0573::func_A21E();
      }

      param_00 common_scripts\utility::func_9D9F();
      param_00.var_56C7 = 1;
      var_09 thread lib_054E::func_62D9();
      if(isDefined(level.var_6C08)) {
        [[level.var_6C08]](param_00, var_09);
      } else {
        wait(0.5);
      }

      if(!isDefined(param_00.var_A9C4)) {
        func_83B2(var_09, param_00);
        func_801A(param_00, param_00.var_A9C4["selectedWeapon"]);
      }

      var_12 = param_00.var_A9C4;
      param_00.var_A9C4 = undefined;
      param_00.var_5C10 = var_12["baseName"];
      lib_0547::func_4AE4(var_09, "magic_box", var_10, "none", "none");
      level.var_5F7C++;
      var_09.var_5F7C++;
      var_09 notify("magicBoxUse" + var_09.var_5F7C, var_12["baseNameNoMP"]);
      if(!isDefined(var_09.magicboxweaponsrolled)) {
        var_09.magicboxweaponsrolled = [];
      }

      var_09.magicboxweaponsrolled[var_09.magicboxweaponsrolled.size] = var_12["selectedWeapon"];
      level.var_400E[level.var_400E.size] = ["survivalist_set 3 -1", var_09];
      if(var_09.var_5F7C > 2 && level.var_A980 <= 30) {
        level.var_400E[level.var_400E.size] = ["survivalist_set 4 -1", var_09];
      }

      var_13 = var_12["displayString"];
      if(isDefined(param_00.var_5F7A)) {
        var_13 = [[param_00.var_5F7A]]();
      }

      if(0) {
        param_00 sethintstring(var_13);
        param_00 setsecondaryhintstring("");
      }

      param_00 func_86D2(var_09, var_12["baseNameNoMP"]);
      var_09 clientclaimtrigger(param_00);
      param_00 common_scripts\utility::func_9DA3();
      param_00 notify("pickupReady");
      var_14 = 8;
      var_15 = gettime() + var_14 * 1000;
      level thread func_3D5B(param_00.var_586E);
      var_16 = "nothing";
      while(gettime() < var_15 && var_16 != "trigger") {
        var_17 = var_15 - gettime() / 1000;
        param_00 thread func_08D8(var_17);
        var_18 = param_00 lib_0547::func_A718("timeout", "trigger");
        param_00 notify("stopActiveMagicBoxTimeout");
        var_16 = var_18[0];
        if(var_16 == "timeout") {
          break;
        }

        var_19 = var_18[1];
        if(isDefined(param_00.var_5F71)) {
          if(![[param_00.var_5F71]](var_19)) {
            var_16 = "nothing";
          }

          continue;
        }

        var_11 = var_19 getcurrentprimaryweapon();
        if(lib_0547::func_57AF(var_11) || lib_0547::func_5862(var_11)) {
          var_16 = "nothing";
        }

        if(var_16 == "trigger") {
          var_09 = var_19;
        }
      }

      lib_0378::func_8D74("mystery_box_elec", var_05, 0);
      lib_0378::func_8D74("mystery_box_close", var_05);
      lib_0378::func_8D74("mystery_box_attract_closed", var_05);
      param_00 common_scripts\utility::func_9D9F();
      param_00 releaseclaimedtrigger();
      param_00.var_586E notify("stop_flashing");
      param_00.var_586E.is_flashing = 0;
      param_00.var_586E method_805C();
      var_1A = var_12["selectedWeapon"];
      func_ABE9("magicbox", self.var_0116, var_10, var_1A);
      if(isDefined(level.zmb_events_player_zombie_weapon_from_box)) {
        var_09 thread[[level.zmb_events_player_zombie_weapon_from_box]](maps\mp\_utility::func_4431(var_1A));
      }

      if(isDefined(param_00.var_5F72)) {
        param_00[[param_00.var_5F72]](var_16, var_09);
      } else if(var_16 == "trigger" && maps\mp\_utility::func_57A0(var_09) && !lib_0547::func_577E(var_09)) {
        if(lib_0547::func_73F9(var_09, var_1A)) {
          var_09 lib_0586::func_0790(var_1A);
        }

        var_09 thread lib_054E::playerbuyweapon();
        if(lib_0547::func_585C(var_1A)) {
          func_A7D5(var_09, var_1A);
        } else if(lib_0547::func_5864(var_1A)) {
          wallbuygivemelee(var_09, var_1A);
        } else {
          func_A7D6(var_09, var_1A);
        }
      }

      level.var_6AE8 = common_scripts\utility::func_0F93(level.var_6AE8, var_12["fullName"]);
      param_00.var_56C7 = 0;
      param_00 notify("magicBoxUseEnd");
      if(isDefined(level.var_2448)) {
        [[level.var_2448]](param_00);
      } else {
        wait(0.5);
      }

      thread func_135C(var_05);
      var_02++;
      if(!var_0E) {
        var_03++;
      }

      continue;
    }

    param_00 common_scripts\utility::func_9D9F();
    param_00.var_5759 = 1;
    if(isDefined(level.var_74C4)) {
      [[level.var_74C4]](param_00, var_09);
    }

    param_00.var_5759 = 0;
    param_00 common_scripts\utility::func_9DA3();
    break;
  }

  if(1) {
    param_00 func_A041();
  }

  func_6AE1(param_00);
}

func_08D8(param_00) {
  self endon("stopActiveMagicBoxTimeout");
  wait(param_00);
  self notify("timeout");
}

func_3D5B(param_00) {
  param_00 endon("stop_flashing");
  wait(5);
  param_00.is_flashing = 1;
  for(;;) {
    param_00 method_8511();
    wait(0.35);
    foreach(var_02 in level.var_744A) {
      if(var_02 method_8530(param_00.var_A9E0)) {
        param_00 showtoclient(var_02);
      }
    }

    wait(0.35);
  }
}

func_83B2(param_00, param_01) {
  var_02 = [];
  var_03 = "";
  var_04 = param_00 getweaponslistall();
  var_05 = [];
  foreach(var_07 in var_04) {
    var_08 = function_03A5(var_07);
    var_05[var_05.size] = lib_0547::func_9469(var_08["weapon"]);
  }

  foreach(var_10, var_0B in level.var_5F7F) {
    var_0C = 1;
    foreach(var_07 in var_05) {
      if(var_0B["baseNameNoMP"] == var_07) {
        var_0C = 0;
        break;
      }

      if(issubstr(var_07, "_pap_")) {
        var_0E = lib_0569::func_40BD(var_07);
        if(var_0B["baseNameNoMP"] == var_0E) {
          var_0C = 0;
          break;
        }
      }
    }

    if(isDefined(param_01.var_5C10)) {
      if(param_01.var_5C10 == var_0B["baseName"]) {
        var_0C = 0;
      }
    }

    if(func_574B(var_0B)) {
      var_0C = 0;
    }

    if(isDefined(var_0B["forceSelect"])) {
      if(var_0B["forceSelect"] <= level.var_5F7C) {
        level.var_5F7F[var_10]["forceSelect"] = undefined;
        var_02 = [var_0B];
        break;
      } else {
        var_0C = 0;
      }
    }

    if(var_0C) {
      var_02[var_02.size] = var_0B;
    }
  }

  var_03 = var_02[randomint(var_02.size)];
  var_11 = "";
  if(param_00 lib_0579::func_4BA5()) {
    var_11 = param_00 lib_0579::func_A246();
    foreach(var_0B in level.var_5F7F) {
      if(lib_0586::func_0791(var_0B["baseNameNoMP"], var_11)) {
        var_03 = var_0B;
        break;
      }
    }
  } else if(level.var_2B6F) {
    if(randomint(100) < level.var_2B70) {
      var_11 = "jack_in_box_decoy_zm";
      foreach(var_0B in level.var_5F7F) {
        if(var_11 == var_0B["baseNameNoMP"]) {
          var_03 = var_0B;
          break;
        }
      }
    } else {
      level.var_2B70 = level.var_2B70 + level.var_2B6E;
    }
  }

  if(var_03["baseNameNoMP"] == "jack_in_box_decoy_zm") {
    level.var_2B6F = 0;
  }

  level.var_6AE8[level.var_6AE8.size] = var_03["fullName"];
  if(issubstr(var_03["fullName"], "_classic")) {
    var_19 = var_03["fullName"];
  } else {
    var_19 = func_454B(param_01, var_04["fullName"]);
  }

  if(issubstr(var_03["fullName"], "_pap_")) {
    var_1A = lib_0569::func_40BD(var_19);
    var_19 = param_00 lib_0586::func_078B(var_1A);
  }

  var_03["selectedWeapon"] = var_19;
  param_01.var_A9C4 = var_03;
}

func_574B(param_00) {
  if(!isDefined(param_00["limit"])) {
    return 0;
  }

  var_01 = level.var_6AE8;
  foreach(var_03 in level.var_744A) {
    var_04 = var_03 getweaponslistall();
    var_01 = common_scripts\utility::func_0F73(var_01, var_04);
  }

  var_06 = 0;
  var_07 = param_00["limit"];
  foreach(var_09 in var_01) {
    var_0A = function_03A5(var_09);
    var_0B = lib_0547::func_9469(var_0A["weapon"]);
    if(var_0B == param_00["baseNameNoMP"]) {
      var_06++;
    }
  }

  return var_06 >= var_07;
}

func_4401() {
  var_00 = &"ZOMBIES_EMPTY_STRING";
  if(isDefined(level.var_4400)) {
    var_00 = [[level.var_4400]]();
  }

  return var_00;
}

func_4520() {
  var_00 = &"ZOMBIES_EMPTY_STRING";
  if(isDefined(level.var_451F)) {
    var_00 = [[level.var_451F]]();
  }

  return var_00;
}

func_43FF(param_00) {
  if(maps\mp\_utility::func_3FA0("fire_sale")) {
    return int(10);
  }

  if(isPlayer(param_00) && param_00 lib_056B::func_9D1C()) {
    return int(0);
  }

  var_01 = int(1000);
  if(isDefined(level.var_6F41)) {
    for(var_02 = 0; var_02 < level.var_6F41; var_02++) {
      var_01 = lib_0547::func_4522(var_01);
    }
  }

  if(isPlayer(param_00) && param_00 lib_0573::func_4B7B()) {
    var_01 = var_01 * param_00.var_65EC.var_267C;
  }

  return int(var_01);
}

func_4794() {}

func_A9D4() {
  func_529E();
  level.var_A9D3 = getEntArray("weapon_level_box", "targetname");
  common_scripts\utility::func_0FB2(level.var_A9D3, ::func_A9D7);
}

func_A9D6() {
  if(!isDefined(self.var_6298) || !isDefined(self.var_6298.var_01A2) || isDefined(self.var_6298.var_5CCE)) {
    return;
  }

  var_00 = getent(self.var_6298.var_01A2, "targetname");
  if(isDefined(var_00) && var_00.var_003B == "light") {
    self.var_6298.var_5CCE = var_00;
    self.var_6298.var_5CCE.var_5D70 = self.var_6298.var_5CCE method_81DE();
    self.var_6298.var_5CCE.var_5D6F = 0.1;
    self.var_6298.var_5CCE.var_5764 = 1;
  }
}

func_A9D9() {
  if(isDefined(self.var_6298.var_5CCE) && isDefined(self.var_6298.var_5CCE.var_5D6F) && isDefined(self.var_6298.var_5CCE.var_5764) && !self.var_6298.var_5CCE.var_5764) {
    self.var_6298.var_5CCE method_81DF(self.var_6298.var_5CCE.var_5D70);
    self.var_6298.var_5CCE.var_5764 = 1;
  }
}

func_A9D8() {
  if(isDefined(self.var_6298.var_5CCE) && isDefined(self.var_6298.var_5CCE.var_5D6F) && isDefined(self.var_6298.var_5CCE.var_5764) && self.var_6298.var_5CCE.var_5764) {
    self.var_6298.var_5CCE method_81DF(self.var_6298.var_5CCE.var_5D6F);
    self.var_6298.var_5CCE.var_5764 = 0;
  }
}

func_57DF(param_00) {
  return isDefined(param_00.var_0165) && param_00.var_0165 == "special";
}

func_A9D5(param_00, param_01) {
  return (!func_57DF(self) && param_00.var_A9EB[param_01]["level"] >= 20) || func_57DF(self) && param_00.var_A9EB[param_01]["level"] >= 25;
}

func_A9DA(param_00) {
  param_00 endon("disconnect");
  for(;;) {
    var_01 = param_00 lib_0547::func_A718("weapon_change", "no_upgrades");
    var_02 = undefined;
    if(var_01[0] == "no_upgrades" && self.var_0C2F) {
      continue;
    }

    switch (var_01[0]) {
      case "weapon_change":
        var_02 = var_01[1];
        break;

      case "no_upgrades":
        self sethintstring("");
        self setsecondaryhintstring("");
        param_00 waittill("allow_upgrades");
        var_02 = lib_0547::func_462A(param_00);
        break;
    }

    var_03 = getweapondisplayname(var_02);
    self setcursorhint("HINT_NOICON");
    if(!lib_0547::func_4BA8(param_00, var_03) || !func_A9D5(param_00, var_03)) {
      self sethintstring(&"ZOMBIES_WEAPON_LEVEL_BOX");
      self setsecondaryhintstring(&"ZOMBIES_COST_2500");
      continue;
    }

    self sethintstring("");
    self setsecondaryhintstring("");
  }
}

func_2A76() {
  self.var_2A75 = 1;
  self notify("deactivated");
}

func_7AAB() {
  self.var_2A75 = undefined;
}

func_A9D7() {
  level endon("game_ended");
  self.var_6298 = getent(self.var_01A2, "targetname");
  self.var_0C2F = 1;
  if(func_57DF(self)) {
    func_A9D6();
    func_A9D8();
    common_scripts\utility::func_9D9F();
    level waittill("special_weapon_box_unlocked");
    func_A9D9();
  }

  var_00 = self.var_6298 gettagangles("tag_origin");
  self.var_6298 method_861D("interact_weapon_upgrade_attract");
  if(lib_0547::func_581A(self)) {
    lib_0547::func_74A5(common_scripts\utility::func_44F5("station_upgrade_weapon_pwr_on"), self.var_6298, "tag_origin");
  }

  lib_0547::func_8A4F(self, ::func_A9DA);
  var_01 = int(self.var_8260);
  if(isDefined(level.var_6F41)) {
    for(var_02 = 0; var_02 < level.var_6F41; var_02++) {
      var_03 = lib_0547::func_4522(var_01);
      var_01 = var_03;
    }
  }

  for(;;) {
    var_04 = lib_0547::func_A795();
    var_05 = var_04[0];
    var_06 = var_04[1];
    var_07 = lib_0547::func_462A(var_05);
    var_08 = getweapondisplayname(var_07);
    if(!lib_0547::func_4BA8(var_05, var_08)) {
      continue;
    }

    if(func_A9D5(var_05, var_08)) {
      func_2EDF(var_05);
      continue;
    }

    if(func_57DF(self) && var_05.var_A9EB[var_08]["level"] != 20) {
      func_3014(var_05);
      continue;
    }

    if(var_06 == "token") {
      var_05 maps\mp\gametypes\zombies::func_90F6(self.var_9A84);
    } else if(!var_05 maps\mp\gametypes\zombies::func_11C2(var_01)) {
      var_05 thread lib_054E::func_0695("needmoney");
      continue;
    }

    self.var_0C2F = 0;
    foreach(var_0A in level.var_744A) {
      var_0A notify("no_upgrades");
    }

    var_0C = undefined;
    if(level.var_010B) {
      var_0D = func_3B8D(var_08);
      var_0C = spawn("script_model", self.var_0116);
      var_0C.var_001D = var_00 - (0, 90, 0);
      var_0C setModel(var_0D);
      var_0E = [15, 0, -6];
      if(var_08 == "iw5_exocrossbowzm_mp") {
        var_0E = [13, 0, -13];
        var_0C.var_001D = var_0C.var_001D + (0, 0, -90);
      }

      level thread func_2079(self.var_6298, var_0C, var_0E);
    }

    lib_0547::func_74A5(common_scripts\utility::func_44F5("station_upgrade_weapon"), self.var_6298, "tag_origin", 1);
    self.var_6298 method_8617("interact_weapon_upgrade");
    if(func_57DF(self)) {
      func_8A65(var_05, var_07, 25);
    } else {
      func_8A65(var_05, var_07, var_05.var_A9EB[var_08]["level"] + 1);
    }

    var_05 thread lib_054E::func_7491(func_57DF(self), var_05.var_A9EB[var_08]["level"]);
    var_05.var_68A0++;
    wait(1.2);
    if(var_05.var_A9EB[var_08]["level"] > 19) {
      lib_0547::func_74A5(common_scripts\utility::func_44F5("weapon_level_20"), self.var_6298, "tag_origin", 1);
      self.var_6298 method_8617("interact_weapon_upgrade_fwks");
    }

    wait(0.75);
    if(isDefined(var_0C)) {
      var_0C delete();
    }

    self.var_0C2F = 1;
    foreach(var_0A in level.var_744A) {
      var_0A notify("allow_upgrades");
    }
  }
}

func_8A65(param_00, param_01, param_02) {
  param_00 lib_0586::func_0790(param_01);
  var_03 = getweapondisplayname(param_01);
  param_00.var_A9EB[var_03]["level"] = param_02;
  var_04 = func_454B(param_00, var_03);
  func_A7D6(param_00, var_04, 0);
  if(issubstr(var_04, "iw5_em1zm_mp")) {
    param_00 maps\mp\gametypes\zombies::func_7456();
  }

  if(isDefined(level.var_8A66)) {
    param_00[[level.var_8A66]](param_01, param_02);
  }

  param_00 method_860F("mp_s1_earn_medal", param_00);
}

func_3B8D(param_00) {
  foreach(var_02 in level.var_5F7F) {
    if(var_02["baseName"] == param_00) {
      return var_02["displayModel"];
    }
  }

  foreach(var_02 in level.var_A7F1) {
    if(var_02["baseName"] == param_00) {
      return var_02["displayModel"];
    }
  }

  return "npc_titan45_base_static_holo";
}

func_454B(param_00, param_01) {
  if(param_01 == "none") {
    return "none";
  }

  var_02 = lib_0547::func_AAF9(param_01, 1, 1);
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = [];
  var_08 = lib_056C::func_4735(param_00, param_01);
  if(isDefined(var_08)) {
    if(var_08.var_A9F8) {
      var_04 = getweaponconditionid(var_08.var_A9F8);
      var_09 = getitemreffromguid(var_08.var_A9F8);
      if(var_09 != "") {
        var_02 = function_02FF(var_09, "_mp") + "_zm";
      }
    }

    if(var_08.var_7E18) {
      var_05 = var_08.var_7E18;
    }

    if(var_08.var_1EC0) {
      var_03 = var_08.var_1EC0;
    }

    if(var_08.var_297C) {
      var_06 = var_08.var_297C;
    }

    var_07 = common_scripts\utility::func_0F73(var_07, var_08.var_114C);
  }

  var_0A = getweapondisplayname(param_01);
  var_07 = lib_0547::func_0FB9(var_07);
  while(var_07.size < 6) {
    var_07[var_07.size] = 0;
  }

  var_0B = maps\mp\gametypes\_class::func_1D66(var_02, var_07[0], var_07[1], var_07[2], var_07[3], var_07[4], var_07[5], var_04, var_03, 0, var_05, var_06, param_00, undefined);
  return var_0B;
}

func_4445(param_00, param_01) {
  param_01 = int(min(param_01, level.var_1EC1.size - 1));
  return level.var_1EC1[param_01];
}

func_4424(param_00, param_01) {
  var_02 = func_456F(param_00, "attachment1");
  if(param_01 > 3) {
    switch (param_00) {
      case "iw5_m182sprzm_mp":
      case "iw5_hbra3zm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_ak12zm_mp":
        var_02 = "opticseotech";
        break;

      case "iw5_em1zm_mp":
      case "iw5_arx160zm_mp":
      case "iw5_exocrossbowzm_mp":
      case "iw5_sn6zm_mp":
      case "iw5_bal27zm_mp":
        var_02 = "variablereddot";
        break;

      case "iw5_uts19zm_mp":
      case "iw5_maulzm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_vbrzm_mp":
      case "iw5_microwavezm_mp":
        var_02 = "opticsreddot";
        break;

      case "iw5_asawzm_mp":
        var_02 = "opticsthermalar";
        break;

      case "iw5_hmr9zm_mp":
        var_02 = "opticsthermal";
        break;

      case "iw5_dlcgun2zm_mp":
      case "iw5_linegunzm_mp":
      case "iw5_fusionzm_mp":
      case "iw5_himarzm_mp":
      case "iw5_lsatzm_mp":
      case "iw5_rhinozm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_titan45zm_mp":
        var_02 = "opticstargetenhancer";
        break;

      case "iw5_dlcgun3zm_mp":
      case "iw5_sac3zm_mp":
        var_02 = "lasersight";
        break;

      case "iw5_mahemzm_mp":
        var_02 = "quickdraw";
        break;

      case "iw5_gm6zm_mp":
        var_02 = "opticsacog2";
        break;
    }
  }

  return var_02;
}

func_4425(param_00, param_01) {
  var_02 = func_456F(param_00, "attachment2");
  if(param_01 > 6) {
    switch (param_00) {
      case "iw5_uts19zm_mp":
      case "iw5_maulzm_mp":
      case "iw5_hmr9zm_mp":
      case "iw5_hbra3zm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_arx160zm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_himarzm_mp":
      case "iw5_bal27zm_mp":
      case "iw5_ak12zm_mp":
      case "iw5_asawzm_mp":
      case "iw5_rhinozm_mp":
        var_02 = "lasersight";
        break;

      case "iw5_dlcgun2zm_mp":
      case "iw5_m182sprzm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_fusionzm_mp":
      case "iw5_lsatzm_mp":
        var_02 = "stock";
        break;

      case "iw5_em1zm_mp":
      case "iw5_dlcgun3zm_mp":
      case "iw5_linegunzm_mp":
      case "iw5_gm6zm_mp":
      case "iw5_vbrzm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_titan45zm_mp":
        var_02 = "quickdraw";
        break;

      case "iw5_sac3zm_mp":
      case "iw5_sn6zm_mp":
        var_02 = "firerate";
        break;

      case "iw5_mahemzm_mp":
      case "iw5_exocrossbowzm_mp":
        var_02 = "xmags";
        break;
    }
  }

  return var_02;
}

func_4426(param_00, param_01) {
  var_02 = func_456F(param_00, "attachment3");
  if(param_01 > 9) {
    switch (param_00) {
      case "iw5_em1zm_mp":
      case "iw5_arx160zm_mp":
      case "iw5_mahemzm_mp":
      case "iw5_himarzm_mp":
      case "iw5_bal27zm_mp":
      case "iw5_ak12zm_mp":
        var_02 = "stock";
        break;

      case "iw5_dlcgun2zm_mp":
      case "iw5_hbra3zm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_exocrossbowzm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_asawzm_mp":
      case "iw5_lsatzm_mp":
        var_02 = "quickdraw";
        break;

      case "iw5_dlcgun3zm_mp":
      case "iw5_uts19zm_mp":
      case "iw5_m182sprzm_mp":
      case "iw5_maulzm_mp":
      case "iw5_hmr9zm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_fusionzm_mp":
      case "iw5_sac3zm_mp":
      case "iw5_sn6zm_mp":
      case "iw5_rhinozm_mp":
      case "iw5_gm6zm_mp":
      case "iw5_vbrzm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_titan45zm_mp":
        var_02 = "xmags";
        break;

      case "iw5_linegunzm_mp":
        var_02 = "xmagslinegun";
        break;
    }
  }

  return var_02;
}

func_456F(param_00, param_01) {
  var_02 = "none";
  foreach(var_04 in level.var_5F7F) {
    if(var_04["baseName"] == param_00) {
      var_02 = var_04[param_01];
      break;
    }
  }

  return var_02;
}

func_3014(param_00) {
  param_00 method_860F("zmb_ui_purchase_fail", param_00);
}

func_2EDF(param_00) {
  param_00 method_860F("zmb_ui_purchase_fail", param_00);
}

func_529E() {
  var_00 = "mp/zmWeaponLevels.csv";
  level.var_1EC1 = [];
  for(var_01 = 0; var_01 <= 25; var_01++) {
    var_02 = int(tablelookup(var_00, 0, var_01, 1));
    level.var_1EC1[var_01] = var_02;
  }
}

func_A7E7(param_00) {
  param_00.var_9DA0++;
  if(param_00.var_9DA0 == 1) {
    param_00 common_scripts\utility::func_9D9F();
  }
}

func_A7E8(param_00) {
  param_00.var_9DA0--;
  if(param_00.var_9DA0 == 0) {
    param_00 common_scripts\utility::func_9DA3();
  }
}

func_A7D3(param_00) {
  param_00.var_A9C6 method_805C();
  lib_0547::func_5A48(common_scripts\utility::func_44F5("station_buy_weapon_pwr_on"), param_00.var_6298, "tag_origin");
  func_A7E7(param_00);
}

func_A7D4(param_00) {
  param_00.var_A9C6 method_805B();
  lib_0547::func_74A5(common_scripts\utility::func_44F5("station_buy_weapon_pwr_on"), param_00.var_6298, "tag_origin");
  func_A7E8(param_00);
}

func_A9DC(param_00) {
  lib_0547::func_8A4F(param_00, ::func_A9DA);
}

func_A9D1(param_00) {
  lib_0547::func_5A48(common_scripts\utility::func_44F5("station_upgrade_weapon_pwr_on"), param_00.var_6298, "tag_origin");
  param_00 func_A9D8();
  param_00 common_scripts\utility::func_9D9F();
}

func_A9D2(param_00) {
  lib_0547::func_74A5(common_scripts\utility::func_44F5("station_upgrade_weapon_pwr_on"), param_00.var_6298, "tag_origin");
  param_00 func_A9D9();
  param_00 common_scripts\utility::func_9DA3();
  thread func_A9DC(param_00);
}

func_0DB7() {
  var_00 = getEntArray("ammocrate_trigger", "targetname");
  var_01 = 500;
  foreach(var_03 in var_00) {
    thread func_0DB8(var_03, var_01);
  }
}

func_0DB8(param_00, param_01) {
  param_00 usetriggerrequirelookat();
  param_00 sethintstring(&"ZOMBIES_AMMO_CRATE_HINT");
  param_00 setsecondaryhintstring(&"ZOMBIES_COST_500");
  for(;;) {
    var_02 = param_00 lib_0547::func_A795();
    var_03 = var_02[0];
    var_04 = var_02[1];
    var_05 = lib_0547::func_462A(var_03);
    var_06 = 0;
    if(func_4B6A(var_03, var_05)) {
      func_300A(var_03, var_06);
      continue;
    }

    if(var_03 maps\mp\gametypes\zombies::func_11C2(param_01)) {
      var_03 iclientprintlnbold("refill");
      func_3AC1(var_03, var_05);
      var_03 givemaxammo(var_05);
      var_03 thread lib_054E::func_62D9();
    }
  }
}