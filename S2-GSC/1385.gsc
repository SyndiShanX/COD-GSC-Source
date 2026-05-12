/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1385.gsc
*********************************************/

lib_0569::func_5326() {
  if(common_scripts\utility::func_3C83("pap_in_use")) {
    return;
  }

  common_scripts\utility::func_3C87("pap_in_use");
  common_scripts\utility::func_3C87("pap_weapon_ready");
  lib_0547::func_A78B();
  common_scripts\utility::func_092C("zmb_pack_a_punch_lathe", "vfx/map/mp_zombie_nest/zmb_pack_a_punch_lathe");
  common_scripts\utility::func_092C("zmb_pack_a_punch_lathe_ammo", "vfx/map/mp_zombie_nest/zmb_pack_a_punch_lathe_ammo");
  var_00 = common_scripts\utility::func_44BE("pack_a_punch", "targetname");
  foreach(var_02 in var_00) {
    level thread lib_0569::func_6E40(var_02);
  }
}

lib_0569::func_6E40(param_00) {
  wait_for_pack_a_punch_conditions();
  var_01 = strtok(param_00.var_8260, ",");
  var_02 = int(var_01[0]);
  if(var_01.size > 1) {
    var_03 = int(var_01[1]);
  } else {
    var_03 = 4000;
  }

  if(getdvarint("spv_zmb_event_mtx5_active", 0)) {
    var_02 = 2000;
    var_03 = 1000;
  }

  if(0) {}

  var_04 = getEntArray(param_00.var_01A2, "targetname");
  if(var_04.size == 4) {
    var_05 = function_021F("zmb_upgrade_machine", "targetname");
    for(var_06 = 0; var_06 < 4; var_06++) {
      var_04[var_06].var_81E1 = var_06;
      var_04[var_06].var_82EF = var_05[var_06];
    }
  }

  foreach(var_08 in var_04) {
    if(isDefined(var_08)) {
      var_08 usetriggerrequirelookat();
      if(0) {
        var_08.var_1DE6 = &"ZOMBIES_WEAPON_LEVEL_BOX";
        var_08.var_1DE4 = &"ZOMBIES_WALL_BUY_AMMO";
        var_08.var_1DE5 = lib_0547::func_4474(var_02);
        var_08.var_1DE3 = lib_0547::func_4474(var_03);
      }

      var_08.var_6DE1 = var_02;
      var_08.var_6DE0 = var_03;
      var_08.is_pap_trigger = 1;
      if(lib_0547::func_5819(var_08)) {
        lib_0547::func_8A4F(var_08, ::lib_0569::func_10E1, ::lib_0569::func_4D14);
      } else if(0) {
        var_08 sethintstring(var_08.var_1DE6);
        var_08 setsecondaryhintstring(var_08.var_1DE5);
      }

      var_08 thread lib_0569::func_6E41();
    }
  }
}

lib_0569::func_45A0(param_00, param_01) {
  var_02 = function_01AC(param_00, self.var_0116);
  var_03 = [];
  for(var_04 = 0; var_04 < param_01; var_04++) {
    var_03[var_04] = var_02[var_04];
  }

  return var_03;
}

lib_0569::func_6E41() {
  var_00 = self;
  level endon("game_over");
  self.var_738D = undefined;
  var_01 = getent("pack_a_punch_weapon_display", "targetname");
  var_01 method_8511();
  for(;;) {
    var_02 = lib_0547::func_A795();
    var_03 = var_02[0];
    var_04 = var_02[1];
    if(common_scripts\utility::func_3C77("pap_in_use")) {
      continue;
    }

    var_05 = var_03 getcurrentprimaryweapon();
    if(lib_0547::func_57AF(var_05) || lib_0547::func_5862(var_05) || lib_0547::iszombieconsumableweapon(var_05)) {
      continue;
    }

    var_06 = lib_0547::func_5868(var_05);
    if(var_06) {
      var_07 = self.var_6DE0;
      if(maps\mp\zombies\_zombies_magicbox::func_4B6A(var_03, var_05)) {
        maps\mp\zombies\_zombies_magicbox::func_300A(var_03, 0);
        continue;
      }

      if(!var_03 maps\mp\gametypes\zombies::func_11C2(var_07)) {
        var_03 thread lib_054E::func_0695("needmoney");
        continue;
      }

      var_03 thread lib_054E::func_62D9();
      maps\mp\zombies\_zombies_magicbox::func_AC57(var_03, var_05);
      lib_0547::func_4AE4(var_03, "pack_a_punch_ammo", var_07, var_05, "none");
      if(!common_scripts\utility::func_3C77("pap_in_use")) {
        playFXOnTag(level.var_0611["zmb_pack_a_punch_lathe_ammo"], self.var_82EF, "lathe_01");
      }

      continue;
    }

    if(isDefined(level.extra_upgrade_func)) {
      level thread[[level.extra_upgrade_func]](var_03);
    }

    var_08 = var_03 lib_0586::func_078B(var_05);
    if(!isDefined(var_08)) {
      lib_0555::func_83DD("no_upgrade", var_03);
      continue;
    }

    var_07 = int(self.var_6DE1);
    if(!var_03 maps\mp\gametypes\zombies::func_11C2(var_07)) {
      var_03 thread lib_054E::func_0695("needmoney");
      continue;
    }

    var_03 thread lib_054E::func_62D9();
    var_03 lib_0586::func_0790(var_05);
    if(lib_0547::func_5864(var_05) && !issubstr(var_05, "razergun")) {
      var_09 = var_03 method_82D5();
      if(!isDefined(var_09) || lib_0547::func_5565(var_09, "none")) {
        var_0A = maps\mp\zombies\_zombies_magicbox::func_454B(var_03, "shovel_zm");
        var_03 lib_0586::func_078C(var_0A);
      }
    }

    var_0B = var_03 getweaponslistprimaries();
    if(var_0B.size > 0) {
      var_03 lib_0586::func_078E(var_0B[0]);
    }

    lib_0547::func_4AE4(var_03, "pack_a_punch", var_07, var_08, "none");
    if(maps\mp\_utility::func_4571() == "mp_zombie_nest_01") {
      var_0C = var_03 maps\mp\gametypes\_playerlogic::func_4005();
      if(!isDefined(var_03.magicboxweaponsrolled)) {
        var_03.magicboxweaponsrolled = [];
      }

      if(common_scripts\utility::func_0F79(var_0C, var_05) || !common_scripts\utility::func_0F79(var_03.magicboxweaponsrolled, var_05)) {
        level.var_400E[level.var_400E.size] = ["survivalist_set 4 -1", var_03];
      }
    } else if(maps\mp\_utility::func_4571() == "mp_zombie_island") {
      var_0C = var_03 maps\mp\gametypes\_playerlogic::func_4005();
      if(!isDefined(var_03.magicboxweaponsrolled)) {
        var_03.magicboxweaponsrolled = [];
      }

      if(common_scripts\utility::func_0F79(var_0C, var_05) || !common_scripts\utility::func_0F79(var_03.magicboxweaponsrolled, var_05)) {
        var_03 notify("invalid_pack_a_punch");
      }
    }

    var_0D = lib_0547::func_AAF9(var_08);
    lib_0555::func_83DD("upgrade", var_03, var_0D);
    if(isDefined(level.zmb_events_upgraded_a_weapon)) {
      level thread[[level.zmb_events_upgraded_a_weapon]](var_03);
    }

    common_scripts\utility::func_3C8F("pap_in_use");
    self.var_738D = var_03;
    level notify("pap_state_change");
    self.var_82EF lib_0569::func_854A(var_05, var_08);
    common_scripts\utility::func_3C8F("pap_weapon_ready");
    if(0) {
      self setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
    }

    level notify("pap_state_change");
    var_00 thread lib_0569::func_7485(var_03);
    var_00 thread lib_0569::func_9E21(var_03, var_08, var_03 lib_0586::func_078B(var_05, undefined, undefined, 1));
    common_scripts\utility::func_A70C(var_00, "pap - player took gun", var_00, "pap - player timed out", var_03, "disconnect");
    if(0) {
      self setsecondaryhintstring(self.var_1DE5);
    }

    lib_0569::func_4D1D(self.var_82EF.var_586E);
    common_scripts\utility::func_3C7B("pap_weapon_ready");
    self.var_738D = undefined;
    common_scripts\utility::func_3C7B("pap_in_use");
    level notify("pap_state_change");
  }
}

lib_0569::func_4D1D(param_00) {
  param_00 method_8511();
}

lib_0569::func_9E21(param_00, param_01, param_02) {
  var_03 = self;
  var_03 endon("pap - player timed out");
  param_00 endon("disconnect");
  var_04 = undefined;
  var_03 wait_for_response(var_04, param_00);
  var_05 = common_scripts\utility::func_562E(var_03.double_tapped);
  var_03.double_tapped = undefined;
  if(var_05) {
    param_01 = param_02;
  }

  var_03 notify("pap - player took gun");
  param_00 common_scripts\utility::func_379A("flag_player_has_paped");
  param_00 lib_0569::func_6E46(param_01);
  if(issubstr(param_01, "austen")) {
    thread lib_0380::func_6840("zmb_fog_rolling_out_austen", param_00);
  }
}

wait_for_response(param_00, param_01) {
  var_02 = self;
  param_01 endon("disconnect");
  var_02 endon("trigger");
  var_02 endon("pap - player timed out");
  param_01 childthread watch_for_pap_double_tap(var_02);
  while(!lib_0547::func_5565(param_00, param_01)) {
    var_02 waittill("trigger", param_00);
  }
}

watch_for_pap_double_tap(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  param_00 endon("trigger");
  param_00 endon("pap - player timed out");
  var_02 = gettime();
  for(;;) {
    while(!var_01 interacting_with_this_trigger(param_00)) {
      wait 0.05;
    }

    while(var_01 interacting_with_this_trigger(param_00)) {
      wait 0.05;
    }

    if(gettime() - var_02 < 500) {
      param_00.double_tapped = 1;
      param_00 notify("trigger", var_01);
    }

    var_02 = gettime();
  }
}

interacting_with_this_trigger(param_00) {
  var_01 = self;
  return var_01 useButtonPressed() && lib_0547::func_5565(var_01 method_84D1(), param_00);
}

lib_0569::func_7485(param_00) {
  var_01 = self;
  var_01 endon("pap - player took gun");
  param_00 endon("disconnect");
  wait(18);
  var_01 notify("pap - player timed out");
  level notify("PAP_display_reset");
}

lib_0569::func_42A5() {
  return "flag_player_has_paped";
}

lib_0569::func_10E1(param_00) {
  param_00 endon("disconnect");
  param_00 common_scripts\utility::func_3799("flag_player_has_paped");
  thread lib_0569::func_6E43(param_00);
  thread lib_0569::func_8C10(param_00);
  thread lib_0569::func_6E45(param_00);
  lib_0559::func_7BE2(param_00, self, "pack");
}

lib_0569::func_854A(param_00, param_01) {
  var_02 = self.var_0116 + (0, 0, 60);
  var_03 = lib_0380::func_2889("zmb_pack_a_punch_use", undefined, var_02);
  lib_0378::func_8D14(var_03);
  var_04 = self gettagorigin("lathe_01");
  level notify("PAP_display_reset");
  var_05 = getent("pack_a_punch_weapon_display", "targetname");
  var_05.var_0116 = (var_05.var_0116[0], var_05.var_0116[1], var_04[2]);
  if(!isDefined(level.var_6DDD)) {
    level.var_6DDD = var_05 common_scripts\utility::func_8FFC();
  }

  self.var_6DDD = level.var_6DDD;
  lib_0569::func_801B(self, param_00);
  var_06 = level.var_6DDD.var_0116;
  var_07 = level.var_6DDD.var_001D;
  if(issubstr(param_00, "fliegerfaust")) {
    thread lib_0569::func_3C72(level.var_6DDD);
  }

  var_08 = spawnfx(level.var_0611["zmb_pack_a_punch_lathe"], var_04, anglesToForward(self gettagangles("lathe_01")), anglestoup(self gettagangles("lathe_01")));
  triggerfx(var_08);
  self setscriptablepartstate("lathes", "turn_on");
  thread lib_0569::func_9EDC();
  wait(getanimlength(%zmb_pack_a_punch_lathes_turn_on) - 1.4);
  self setscriptablepartstate("lathes", "idle");
  var_08 delete();
  lib_0569::func_801B(self, param_01);
  thread lib_0569::func_7D78(var_06, var_07);
}

lib_0569::func_7D78(param_00, param_01) {
  level common_scripts\utility::func_A74B("PAP_display_reset", 18);
  level.var_6DDD.var_0116 = param_00;
  level.var_6DDD.var_001D = param_01;
}

lib_0569::func_8549(param_00, param_01) {
  thread lib_0569::func_9EDB();
}

lib_0569::func_801B(param_00, param_01) {
  var_02 = (0, 0, 0);
  var_03 = (0, 0, 0);
  if(issubstr(param_01, "springfield") || issubstr(param_01, "bren") || issubstr(param_01, "lewis") || issubstr(param_01, "m1941") || issubstr(param_01, "m1a1") || issubstr(param_01, "breda30")) {
    var_02 = (-3, 0, 0);
  }

  if(issubstr(param_01, "leeenfield") || issubstr(param_01, "mg42") || issubstr(param_01, "m1garand") || issubstr(param_01, "bar_") || issubstr(param_01, "m30") || issubstr(param_01, "karabin") || issubstr(param_01, "g43") || issubstr(param_01, "kar98") || issubstr(param_01, "teslagun")) {
    var_02 = (-5, 0, 0);
  }

  if(issubstr(param_01, "svt40") || issubstr(param_01, "walther") || issubstr(param_01, "m1919")) {
    var_02 = (-7, 0, 0);
  }

  if(issubstr(param_01, "zom_dlc2_1") || issubstr(param_01, "zom_dlc2_2") || issubstr(param_01, "zom_dlc2_3")) {
    var_03 = (-90, 0, 0);
    if(issubstr(param_01, "zom_dlc2_1")) {
      var_02 = (2, 0, 0);
    } else {
      var_02 = (-7, 0, 0);
    }
  }

  if(issubstr(param_01, "mg15")) {
    var_02 = (-8, 0, 0);
  }

  if(issubstr(param_01, "fliegerfaust")) {
    var_02 = (0, 0, 10);
  }

  if(isDefined(param_00.var_A6EA)) {
    param_00.var_586E method_848E(param_01);
    param_00.var_586E method_805B();
    param_00.var_A6EA = undefined;
  } else {
    if(isDefined(param_00.var_586E)) {
      param_00.var_586E delete();
    }

    param_00.var_586E = spawn("weapon_" + param_01, param_00.var_6DDD.var_0116);
    param_00.var_586E linkto(param_00.var_6DDD, "tag_origin", var_02, var_03);
    param_00.var_A6EA = 1;
  }

  param_00.var_586E makeunusable();
  param_00.var_586E method_86B3(0);
}

lib_0569::func_3C72(param_00) {
  wait(0.7);
  param_00 movez(-5, 0.1, 0, 0);
  wait(0.5);
  param_00 movez(5, 0.5, 0.1, 0.1);
  wait(0.5);
  param_00 movez(-5, 0.1, 0, 0);
  wait(0.5);
  param_00 movez(5, 0.5, 0.1, 0.1);
  wait(1);
  param_00 rotateyaw(20, 0.5, 0.1, 0.1);
  wait(1);
  param_00 movez(-10, 0.5, 0.1, 0.1);
}

lib_0569::func_9EDC() {
  self setscriptablepartstate("wheel", "turn");
  wait(getanimlength(%zmb_pack_a_punch_wheel_turn));
  self setscriptablepartstate("wheel", "turn_idle");
}

lib_0569::func_9EDB() {
  self setscriptablepartstate("wheel", "reverse");
  wait(getanimlength(%zmb_pack_a_punch_wheel_reverse));
  self setscriptablepartstate("wheel", "idle");
}

lib_0569::func_21BD(param_00, param_01) {
  param_00 endon("disconnect");
  for(;;) {
    param_00 common_scripts\utility::func_A70A("weapon_change", "new_equipment");
    lib_0569::func_6E44(param_00, param_01);
  }
}

lib_0569::func_21BB(param_00, param_01) {
  param_00 endon("disconnect");
  for(;;) {
    level waittill("pap_state_change");
    lib_0569::func_6E44(param_00, param_01);
  }
}

lib_0569::func_6E44(param_00, param_01) {
  wait(0.1);
  var_02 = 0;
  var_03 = "none";
  var_04 = lib_0547::func_462A(param_00);
  if(var_04 != "none") {
    var_03 = getweapondisplayname(var_04);
  }

  if(lib_0547::func_5868(var_03)) {
    var_02 = 1;
  }

  if(0) {
    self setcursorhint("HINT_NOICON");
  }

  if(1) {
    param_01.interact_disabled = undefined;
  }

  if(common_scripts\utility::func_3C77("pap_weapon_ready") && isDefined(self.var_738D) && self.var_738D == param_00) {
    if(1) {
      param_01.var_6F58 = "pack_pick";
      param_01.var_6F56 = 0;
    }
  } else if(common_scripts\utility::func_3C77("pap_in_use")) {
    self.var_3006 = undefined;
    if(0) {
      self sethintstring("Unavailable");
      self setsecondaryhintstring("");
    }

    if(1) {
      param_01.var_6F58 = "pack_busy";
      param_01.interact_disabled = 1;
      param_01.var_6F56 = 0;
    }
  } else if(lib_0547::func_57AF(var_04) || lib_0547::func_5862(var_04) || lib_0547::iszombieconsumableweapon(var_04) || lib_0547::func_585B(var_04) || (lib_0547::func_5864(var_04) && !ispappablemeleeweapon(var_04)) || (issubstr(var_04, "tesla") && !common_scripts\utility::func_3C83("teslagun_punch_active") || common_scripts\utility::func_3C83("teslagun_punch_active") && !common_scripts\utility::func_3C77("teslagun_punch_active")) || issubstr(var_04, "razergun_melee_zm")) {
    self.var_3006 = undefined;
    if(0) {
      self sethintstring("");
      self setsecondaryhintstring("");
    }

    if(1) {
      param_01.var_6F58 = "pack_noup";
      param_01.interact_disabled = 1;
      param_01.var_6F56 = 0;
    }
  } else if(var_02) {
    self.var_3006 = self.var_6DE0;
    if(0) {
      self sethintstring(self.var_1DE4);
      self setsecondaryhintstring(self.var_1DE3);
    }

    if(1) {
      param_01.var_6F58 = "pack_ammo";
      param_01.var_6F56 = self.var_3006;
    }
  } else {
    self.var_3006 = self.var_6DE1;
    if(0) {
      self sethintstring(self.var_1DE6);
      self setsecondaryhintstring(self.var_1DE5);
    }

    if(1) {
      param_01.var_6F58 = "pack";
      param_01.var_6F56 = self.var_3006;
    }
  }

  if(1) {
    param_01.var_6642 = 1;
  }
}

ispappablemeleeweapon(param_00) {
  if(param_00 == "zom_dlc2_3_zm" || param_00 == "zom_dlc2_2_zm" || param_00 == "zom_dlc2_1_zm") {
    if(common_scripts\utility::func_3C83("dlc2_melee_packable") && common_scripts\utility::func_3C77("dlc2_melee_packable")) {
      return 1;
    }
  }

  return 0;
}

lib_0569::func_6E43(param_00) {
  var_01 = undefined;
  if(1) {
    var_01 = lib_0552::func_7BF3(param_00, self);
  }

  thread lib_0569::func_21BD(param_00, var_01);
  thread lib_0569::func_21BB(param_00, var_01);
}

wait_for_pack_a_punch_conditions() {
  if(isDefined(level.pack_a_punc_pre_func)) {
    level[[level.pack_a_punc_pre_func]]();
  }
}

lib_0569::func_4D14(param_00) {
  self.var_82EF hidefromclient(param_00);
}

lib_0569::func_8C10(param_00) {
  if(isDefined(level.upgrade_machine_reveal_func)) {
    [[level.upgrade_machine_reveal_func]](param_00, self.var_82EF);
  }

  self.var_82EF showtoclient(param_00);
}

lib_0569::func_6E45(param_00) {
  param_00 endon("disconnect");
}

lib_0569::func_86EE(param_00) {
  var_01 = 5;
  var_02 = [];
  var_03 = self.var_6DE1;
  var_04 = self.var_6DE0;
  for(var_05 = 0; var_05 < var_01; var_05++) {
    var_06 = 0;
    var_07 = pow(10, var_01 - var_05);
    while(var_03 >= var_07 / 10) {
      var_03 = var_03 - var_07 / 10;
      var_06++;
    }

    var_02[var_05] = var_06;
  }

  for(var_05 = 0; var_05 < var_01; var_05++) {
    self.var_82EF setscriptablepartstate("gears_0" + var_05 + 1, "idle_" + var_02[var_05]);
  }
}

lib_0569::func_6E46(param_00) {
  maps\mp\gametypes\zombies::func_283D(self, param_00);
  self.var_6E48++;
  level notify("PAP_display_reset");
  if(lib_0547::func_73F9(self, param_00)) {
    lib_0586::func_0790(param_00);
  }

  thread lib_054E::playerbuyweapon(1);
  if(lib_0547::func_5864(param_00)) {
    maps\mp\zombies\_zombies_magicbox::wallbuygivemelee(self, param_00);
  } else {
    maps\mp\zombies\_zombies_magicbox::func_A7D6(self, param_00);
  }

  maps\mp\zombies\_zombies_magicbox::func_AABC(self);
}

lib_0569::func_55D4(param_00) {
  return issubstr(param_00, "_pap_zm");
}

lib_0569::func_40BD(param_00) {
  if(!isDefined(level.var_40BE)) {
    level.var_40BE = [];
  }

  var_01 = level.var_40BE[param_00];
  if(!isDefined(var_01)) {
    var_01 = lib_0569::func_40BF(param_00);
    if(level.var_40BE.size < 1000) {
      level.var_40BE[param_00] = var_01;
    }
  }

  return var_01;
}

lib_0569::func_40BF(param_00) {
  var_01 = common_scripts\utility::func_9462(param_00, "_pap_zm");
  var_02 = "";
  if(var_01 != -1) {
    var_03 = getsubstr(param_00, 0, var_01);
    var_04 = getsubstr(param_00, var_01 + 4);
    var_02 = var_03 + var_04;
  } else {
    var_02 = param_00;
  }

  return var_02;
}