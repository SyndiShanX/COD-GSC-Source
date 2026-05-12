/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1387.gsc
*********************************************/

lib_056B::func_00D5() {
  var_00 = level.var_0A41["zombie"];
  var_00["think"] = ::lib_056B::func_9D34;
  var_00["on_killed"] = ::lib_056B::func_9D2D;
  var_00["get_action_params"] = ::lib_056B::func_9D23;
  var_00["move_mode"] = ::lib_056B::func_9D2B;
  var_00["post_model"] = ::lib_056B::func_9D2E;
  var_00["tesla_delayed_dmg"] = ::treasurer_tesla_delayed_dmg;
  level.var_0A41["zombie_treasurer"] = var_00;
  var_01 = [];
  var_01["whole_body"] = "zom_bomber_base";
  var_02 = spawnStruct();
  var_02.var_0A4B = "zombie_treasurer";
  var_02.var_0EAE = "zombie_animclass";
  var_02.var_0E88 = "zombie_generic";
  var_02.var_0879 = "zombie_generic";
  var_02.var_5ED2["default look"] = var_01;
  var_02.var_60E2 = 20;
  var_02.var_AC6D = "zombie_exploder";
  var_02.var_4C12 = 15;
  var_02.per_extra_player_health_scale = 0.3;
  lib_0547::func_0A52(var_02, "zombie_treasurer");
  level.var_AC09 = [lib_056B::func_2792("Max Ammo", ::lib_056B::func_3484, 35), lib_056B::func_2792("Full Meter", ::lib_056B::func_3483, 35)];
  if(maps\mp\_utility::func_4571() == "mp_zombie_nest_01") {
    level.var_AC09 = common_scripts\utility::func_0F73(level.var_AC09, [lib_056B::func_2792("Hunter piece 1", ::lib_056B::func_3472, 5), lib_056B::func_2792("Hunter piece 2", ::lib_056B::func_3473, 5), lib_056B::func_2792("Hunter piece 3", ::lib_056B::func_3474, 5), lib_056B::func_2792("Hunter piece 4", ::lib_056B::func_3475, 5), lib_056B::func_2792("Hunter piece 5", ::lib_056B::func_3476, 5)]);
  }

  if(maps\mp\_utility::func_4571() == "mp_zombie_island") {
    level.var_AC09 = common_scripts\utility::func_0F73(level.var_AC09, [lib_056B::func_2792("Hunter dlc1 piece 1", ::drop_dlc1_hunter_piece_1, 8), lib_056B::func_2792("Hunter dlc2 piece 2", ::drop_dlc1_hunter_piece_2, 8), lib_056B::func_2792("Hunter dlc3 piece 3", ::drop_dlc1_hunter_piece_3, 8)]);
  }

  if(maps\mp\_utility::func_4571() == "mp_zombie_berlin") {
    level.var_AC09 = common_scripts\utility::func_0F73(level.var_AC09, [lib_056B::func_2792("drop_dlc2_char_a_0", ::drop_dlc2_char_a_piece_1, 8), lib_056B::func_2792("drop_dlc2_char_a_1", ::drop_dlc2_char_a_piece_2, 8), lib_056B::func_2792("drop_dlc2_char_a_2", ::drop_dlc2_char_a_piece_3, 8)]);
  }

  level.var_AC0A = [lib_056B::func_2792("free blitz bullets ( doubletap )", ::lib_056B::func_344C, 12.5), lib_056B::func_2792("free blitz reload ( fastreload )", ::lib_056B::func_344E, 12.5), lib_056B::func_2792("free blitz shock ( electriccherry )", ::lib_056B::func_344D, 12.5), lib_056B::func_2792("free blitz sprint ( runperk )", ::lib_056B::func_3451, 12.5), lib_056B::func_2792("free blitz strike ( punchperk )", ::lib_056B::func_344F, 12.5), lib_056B::func_2792("free panzer armor ( armor )", ::lib_056B::func_344B, 12.5), lib_056B::func_2792("free blitz revive ( quickrevive )", ::lib_056B::func_3450, 12.5), lib_056B::func_2792("free mystery box coupon", ::lib_056B::func_3452, 12.5)];
  level thread lib_056B::func_9D20();
  level thread maps\mp\_utility::func_6F74(::lib_056B::func_A0C4);
  level.var_0611["zmb_treasure_icon"] = loadfx("vfx/gameplay\mp\zombie/zmb_treasure_icon");
}

lib_056B::func_9D2E() {
  lib_056B::func_4394() attach("zom_bomb_treasure", "TAG_WEAPON_CHEST");
  thread lib_056B::func_1138();
}

treasurer_tesla_delayed_dmg(param_00, param_01, param_02) {
  if(common_scripts\utility::func_562E(param_01)) {
    param_00 = maps\mp\gametypes\zombies::func_1E59();
  }

  if(isDefined(param_02)) {
    param_00 = param_02;
  }

  return param_00;
}

lib_056B::func_1138() {
  var_00 = self method_8445("TAG_FX");
  if(var_00 == -1) {}

  thread lib_056B::func_1139();
}

lib_056B::func_1139() {
  self endon("death");
  wait 0.05;
  wait 0.05;
  wait 0.05;
  wait 0.05;
  playFXOnTag(level.var_0611["zmb_treasure_icon"], self, "TAG_FX");
}

lib_056B::func_9D38() {
  var_00 = lib_056B::func_4394();
  var_00.var_8B72 = 0;
  var_01 = 1;
  var_02 = var_01 * 1000;
  for(;;) {
    wait(var_01);
    if(!common_scripts\utility::func_562E(var_00.var_4BA0)) {
      continue;
    }

    if(!isDefined(level.var_744A)) {
      continue;
    }

    foreach(var_04 in level.var_744A) {
      if(!var_04 common_scripts\utility::func_7237(var_00, var_02)) {
        continue;
      }

      var_04 thread lib_054E::func_7465();
      var_00.var_8B72 = 1;
      var_00.var_1723 = 1;
      return;
    }
  }
}

lib_056B::func_9D32() {
  var_00 = lib_056B::func_4394();
  for(;;) {
    wait(lib_056B::func_9D29());
    if(!common_scripts\utility::func_562E(var_00.var_4BA0)) {
      continue;
    }

    var_01 = lib_056B::func_9D27();
    if(var_01 <= 0) {
      continue;
    }

    var_02 = lib_056B::func_4166(var_00.var_0116);
    var_03 = maps\mp\zombies\_zombies_money::func_8ADF(var_02, "Treasure zombie!!!", var_00);
    var_03 maps\mp\zombies\_zombies_money::func_8AD9(var_01);
    var_03.var_6FD4 = lib_056B::func_9D2A();
    var_03.var_6FCB = lib_056B::func_9D28();
  }
}

lib_056B::func_9D2F() {
  var_00 = lib_056B::func_4394();
  var_01 = getarraykeys(level.var_AC80.var_ACB3);
  var_02 = common_scripts\utility::func_7A33(var_01);
  var_00.var_9820 = var_02;
}

lib_056B::func_9D34() {
  var_00 = lib_056B::func_4394();
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("owner_disconnect");
  var_00 method_85A1("zombie_exploder");
  var_00 lib_0566::func_ABB5();
  var_00 childthread lib_056B::func_9D35();
  var_00 childthread lib_056B::func_9D38();
  var_00 childthread lib_056B::func_9D32();
  var_00.var_6816 = 1;
  var_00.var_5D5F = 1;
  var_00.var_57E8 = 1;
  var_00.var_57FD = 1;
  var_00.var_55AB = 1;
  var_00.var_562B = 1;
  var_00.var_5569 = 1;
  var_00.var_A572 = [];
  var_00 lib_0378::func_8D74("aud_treasurer_strt_timer");
  var_01 = 0.2;
  for(;;) {
    wait(var_01);
    if(lib_053C::func_4F8C()) {
      continue;
    }

    if(lib_053C::func_4F84()) {
      continue;
    }

    if(var_00.var_8B72) {
      var_02 = lib_055A::func_578B(var_00.var_0116, 0);
      var_00.var_2920 = var_02;
      if(isDefined(var_02)) {
        var_00.var_5B2F = var_02;
        var_00.var_A572[var_02] = gettime() * 0.001;
      }

      if(isDefined(var_00.var_9820)) {
        if(lib_0547::func_5565(var_00.var_9820, var_02)) {
          var_00.var_9820 = undefined;
        } else {
          var_03 = level.var_AC80.var_ACB3[var_00.var_9820];
          var_00 lib_053C::func_06CE(var_03.var_74DC);
        }

        var_00 lib_053C::func_0647();
        continue;
      }

      var_04 = [];
      if(isDefined(var_02)) {
        var_03 = level.var_AC80.var_ACB3[var_02];
        var_04 = common_scripts\utility::func_0F92(getarraykeys(var_03.var_0A01));
      }

      var_05 = undefined;
      var_06 = undefined;
      foreach(var_08 in var_04) {
        var_09 = var_00.var_A572[var_08];
        if(!isDefined(var_09)) {
          var_05 = var_08;
          break;
        }

        if(isDefined(var_06) && var_09 > var_06) {
          continue;
        }

        var_05 = var_08;
        var_06 = var_09;
      }

      if(isDefined(var_05)) {
        var_00.var_9820 = var_05;
      } else {
        var_00 lib_056B::func_9D2F();
      }
    } else {
      if(lib_053C::func_4F9B()) {
        continue;
      }

      if(lib_053C::func_4F9A()) {
        continue;
      }
    }

    var_08 lib_053C::func_0647();
  }
}

lib_056B::func_9D35() {
  var_00 = lib_056B::func_4394();
  while(!common_scripts\utility::func_562E(var_00.var_4BA0)) {
    wait 0.05;
  }

  var_00.var_4BA1 = gettime();
  var_01 = 0;
  for(;;) {
    wait(1);
    if(lib_056B::func_9D25() > lib_056B::func_9D26()) {
      break;
    }

    if(lib_056B::func_9D25() > lib_056B::func_9D26() * 0.5) {
      if(!var_01) {
        var_02 = common_scripts\utility::func_4461(var_00.var_0116, level.var_744A);
        if(isDefined(var_02) && !lib_0547::func_577E(var_02)) {
          var_02 thread lib_054E::func_9D39();
          var_01 = 1;
        }
      }
    }
  }

  var_00 lib_0378::func_8D74("aud_treasurer_fuse");
  wait(0.5);
  var_00 lib_0378::func_8D74("aud_treasurer_end_timer");
  var_03 = var_00 gettagorigin("TAG_WEAPON_CHEST");
  var_00 detonateusingweapon("drag_explosive_zm");
  lib_0563::func_AB98(var_03);
  lib_0563::func_AB9C(var_03);
  lib_0563::func_AB9E(var_03);
  var_00 suicide();
}

lib_056B::func_9D2D(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = lib_056B::func_4394();
  if(isPlayer(param_01)) {
    level thread lib_056B::func_348E(var_09.var_0116);
    thread lib_054E::func_9D3A(param_01, 1);
    level.var_400E[level.var_400E.size] = ["raven_set 0 1", "all"];
  } else {
    var_0A = common_scripts\utility::func_4461(var_09.var_0116, level.var_744A);
    if(isDefined(var_0A) && !lib_0547::func_577E(var_0A)) {
      thread lib_054E::func_9D3A(var_0A, 0);
    }
  }

  var_09 lib_0378::func_8D74("aud_treasurer_end_timer");
  var_09 method_802E("zom_bomb_treasure", "TAG_WEAPON_CHEST");
  var_09 lib_054D::func_6BD4(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
}

lib_056B::func_9D2B() {
  var_00 = lib_056B::func_4394();
  if(!common_scripts\utility::func_562E(var_00.var_4BA0)) {
    return "walk";
  }

  if(common_scripts\utility::func_562E(var_00.var_8B72)) {
    return "sprint";
  }

  return "run";
}

lib_056B::func_9D23() {
  var_00 = lib_054D::func_AC22();
  var_00["script_var"] = "held_bomb";
  var_00["zombie_subtype"] = "zombie_exploder";
  return var_00;
}

lib_056B::func_9D37(param_00) {
  var_01 = 1;
  while(param_00 > 0) {
    wait(var_01);
    param_00 = param_00 - var_01;
  }

  while(common_scripts\utility::func_562E(level.var_6F1E)) {
    wait(60);
  }
}

lib_056B::func_9D20() {
  if(common_scripts\utility::func_562E(level.var_323A)) {
    return;
  }

  while(lib_056B::func_9D31() && !isDefined(level.var_AC1D) || !lib_056B::func_0F4C()) {
    wait(1);
  }

  while(lib_056B::func_9D30() && !isDefined(level.var_AC80) || !common_scripts\utility::func_562E(level.var_AC80.var_08A9) || !lib_055A::func_0F4F(1)) {
    wait(1);
  }

  var_00 = 4320;
  var_01 = var_00;
  if(isDefined(level.var_744A)) {
    var_02 = [];
    foreach(var_04 in level.var_744A) {
      var_05 = lib_056B::func_431A(var_04);
      var_06 = var_04 getrankedplayerdata(common_scripts\utility::func_46A8(), "totalTimePlayedAsOfTreasureZombieKill");
      var_07 = clamp(var_05 - var_06, 0, var_00);
      var_02 = common_scripts\utility::func_0F6F(var_02, var_07);
    }

    var_07 = common_scripts\utility::func_6880(var_02);
    var_01 = var_00 - var_07 + randomfloatrange(20, 90);
  }

  for(;;) {
    lib_056B::func_9D37(var_01);
    var_09 = undefined;
    var_0A = "Treasure zombie!!!";
    var_0B = 1;
    var_0C = 1;
    var_0D = 0;
    var_0E = lib_054D::func_90BA("zombie_treasurer", var_09, var_0A, var_0B, var_0C, var_0D);
    if(isDefined(var_0E)) {
      var_01 = var_00;
      continue;
    }

    var_01 = 30;
  }
}

lib_056B::func_A0C4() {
  var_00 = lib_056B::func_4296();
  var_00 endon("disconnect");
  for(;;) {
    level waittill("zombie_spawned", var_01);
    if(!lib_0547::func_5565(var_01.var_0A4B, "zombie_treasurer")) {
      continue;
    }

    var_02 = lib_056B::func_431A(var_00);
    var_00 setrankedplayerdata(common_scripts\utility::func_46A8(), "totalTimePlayedAsOfTreasureZombieKill", var_02);
  }
}

lib_056B::func_4166(param_00) {
  var_01 = lib_056B::func_9D24();
  var_02 = param_00;
  var_03 = 0;
  var_04 = 5;
  var_05 = getrandomnavpoints(param_00, var_01, var_04);
  if(isDefined(var_05)) {
    foreach(var_07 in var_05) {
      if(!function_02DE(param_00, var_07)) {
        continue;
      }

      var_08 = distance(param_00, var_07);
      if(var_08 > var_03) {
        var_02 = var_07;
        var_03 = var_08;
      }
    }
  }

  return var_02;
}

lib_056B::func_2792(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.var_2AF8 = param_00;
  var_03.var_1E61 = param_01;
  var_03.var_3489 = param_02;
  return var_03;
}

lib_056B::func_3478(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.var_0116 = param_00;
  var_02 thread[[param_01]]();
}

lib_056B::func_3479(param_00, param_01) {
  var_02 = 0;
  foreach(var_04 in param_00) {
    var_02 = var_02 + var_04.var_3489;
  }

  var_02 = randomfloat(var_02);
  var_06 = undefined;
  foreach(var_04 in param_00) {
    if(var_02 > var_04.var_3489) {
      var_02 = var_02 - var_04.var_3489;
      continue;
    }

    var_06 = var_04;
    break;
  }

  if(!isDefined(var_06)) {
    var_06 = common_scripts\utility::func_7A33(param_00);
  }

  lib_056B::func_3478(param_01, var_06.var_1E61);
}

lib_056B::func_348E(param_00) {
  lib_056B::func_3479(level.var_AC09, param_00);
  wait(1);
  lib_056B::func_3479(level.var_AC0A, param_00);
}

lib_056B::func_4167() {
  var_00 = self;
  return var_00;
}

lib_056B::func_3477(param_00) {
  level.var_400E[level.var_400E.size] = ["treasure_set " + param_00 + " 1", "all"];
}

lib_056B::func_3472() {
  lib_056B::func_3477(0);
}

lib_056B::func_3473() {
  lib_056B::func_3477(1);
}

lib_056B::func_3474() {
  lib_056B::func_3477(2);
}

lib_056B::func_3475() {
  lib_056B::func_3477(3);
}

lib_056B::func_3476() {
  lib_056B::func_3477(4);
}

drop_dlc1_hunter_piece_1() {
  level notify("hunter_treasure_dlc1_0");
}

drop_dlc1_hunter_piece_2() {
  level notify("hunter_treasure_dlc1_1");
}

drop_dlc1_hunter_piece_3() {
  level notify("hunter_treasure_dlc1_2");
}

drop_dlc2_char_a_piece_1() {
  level notify("drop_dlc2_char_a_0");
}

drop_dlc2_char_a_piece_2() {
  level notify("drop_dlc2_char_a_1");
}

drop_dlc2_char_a_piece_3() {
  level notify("drop_dlc2_char_a_2");
}

lib_056B::func_3485(param_00) {
  var_01 = lib_056B::func_4167();
  var_02 = lib_056B::func_4166(var_01.var_0116);
  maps\mp\gametypes\zombies::func_281C(param_00, var_02, "Treasure zombie!!!");
}

lib_056B::func_3484() {
  lib_056B::func_3485("ammo");
}

lib_056B::func_3483() {
  lib_056B::func_3485("ability_fill");
}

lib_056B::func_9D18(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  var_01 = lib_056B::func_4296();
  if(!isDefined(var_01.var_9D1E)) {
    var_01.var_9D1E = [];
  }

  if(!isDefined(var_01.var_9D1E[param_00])) {
    var_01.var_9D1E[param_00] = 0;
  }
}

lib_056B::func_9D1B(param_00) {
  var_01 = lib_056B::func_4296();
  var_01 lib_056B::func_9D18(param_00);
  var_01.var_9D1E[param_00]++;
  var_01 notify("perk_discount_applied");
}

lib_056B::func_9D1A(param_00) {
  var_01 = lib_056B::func_4296();
  var_01 lib_056B::func_9D18(param_00);
  if(var_01 lib_056B::func_9D19(param_00) <= 0) {
    return;
  }

  var_01.var_9D1E[param_00]--;
  var_01 notify("used_vending_machine_discount");
}

lib_056B::func_9D19(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = lib_056B::func_4296();
  var_01 lib_056B::func_9D18(param_00);
  return var_01.var_9D1E[param_00];
}

lib_056B::func_9D1C() {
  return lib_056B::func_9D19("mysterybox_coupon");
}

lib_056B::func_9D1D() {
  return lib_056B::func_9D1A("mysterybox_coupon");
}

lib_056B::func_3453(param_00) {
  if(!isDefined(level.var_744A)) {
    return;
  }

  foreach(var_02 in level.var_744A) {
    var_02 lib_056B::func_9D1B(param_00);
  }
}

lib_056B::func_344C() {
  lib_056B::func_3453("doubletap");
}

lib_056B::func_344E() {
  lib_056B::func_3453("fastreload");
}

lib_056B::func_344D() {
  lib_056B::func_3453("electriccherry");
}

lib_056B::func_3451() {
  lib_056B::func_3453("runperk");
}

lib_056B::func_344F() {
  lib_056B::func_3453("punchperk");
}

lib_056B::func_344B() {
  lib_056B::func_3453("armor");
}

lib_056B::func_3450() {
  lib_056B::func_3453("quickrevive");
}

lib_056B::func_3452() {
  lib_056B::func_3453("mysterybox_coupon");
  maps\mp\zombies\_zombies_magicbox::func_861C();
}

lib_056B::func_431A(param_00) {
  var_01 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(), "totalTimePlayed") + param_00.var_9A06["total"];
  return var_01;
}

lib_056B::func_9D26() {
  return 45;
}

lib_056B::func_9D24() {
  return 70;
}

lib_056B::func_9D27() {
  return 100;
}

lib_056B::func_9D29() {
  return 1;
}

lib_056B::func_9D28() {
  return 1.7;
}

lib_056B::func_9D2A() {
  return 0.5;
}

lib_056B::func_9D31() {
  return 0;
}

lib_056B::func_9D30() {
  return 1;
}

lib_056B::func_9D25() {
  var_00 = lib_056B::func_4394();
  if(!isDefined(var_00.var_4BA1)) {
    return 0;
  }

  var_01 = gettime() - var_00.var_4BA1 * 0.001;
  return var_01;
}

lib_056B::func_4394() {
  var_00 = self;
  return var_00;
}

lib_056B::func_4296() {
  var_00 = self;
  return var_00;
}

lib_056B::func_0F4C() {
  if(!isDefined(level.var_AC1D)) {
    return 0;
  }

  foreach(var_01 in level.var_AC1D) {
    if(!common_scripts\utility::func_562E(var_01.var_6BE1)) {
      return 0;
    }
  }

  return 1;
}