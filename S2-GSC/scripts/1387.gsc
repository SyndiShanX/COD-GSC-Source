/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1387.gsc
**************************************/

init() {
  var_0 = level._id_0A41["zombie"];
  var_0["think"] = ::_id_9D34;
  var_0["on_killed"] = ::_id_9D2D;
  var_0["get_action_params"] = ::_id_9D23;
  var_0["move_mode"] = ::_id_9D2B;
  var_0["post_model"] = ::_id_9D2E;
  var_0["tesla_delayed_dmg"] = ::treasurer_tesla_delayed_dmg;
  level._id_0A41["zombie_treasurer"] = var_0;
  var_1 = [];
  var_1["whole_body"] = "zom_bomber_base";
  var_2 = spawnStruct();
  var_2._id_0A4B = "zombie_treasurer";
  var_2._id_0EAE = "zombie_animclass";
  var_2._id_0E88 = "zombie_generic";
  var_2._id_0879 = "zombie_generic";
  var_2._id_5ED2["default look"] = var_1;
  var_2._id_60E2 = 20;
  var_2._id_AC6D = "zombie_exploder";
  var_2._id_4C12 = 15;
  var_2.per_extra_player_health_scale = 0.3;
  _id_0547::_id_0A52(var_2, "zombie_treasurer");
  level._id_AC09 = [_id_2792("Max Ammo", ::_id_3484, 35), _id_2792("Full Meter", ::_id_3483, 35)];

  if(maps\mp\_utility::_id_4571() == "mp_zombie_nest_01") {
    level._id_AC09 = common_scripts\utility::_id_0F73(level._id_AC09, [_id_2792("Hunter piece 1", ::_id_3472, 5), _id_2792("Hunter piece 2", ::_id_3473, 5), _id_2792("Hunter piece 3", ::_id_3474, 5), _id_2792("Hunter piece 4", ::_id_3475, 5), _id_2792("Hunter piece 5", ::_id_3476, 5)]);
  }

  if(maps\mp\_utility::_id_4571() == "mp_zombie_island") {
    level._id_AC09 = common_scripts\utility::_id_0F73(level._id_AC09, [_id_2792("Hunter dlc1 piece 1", ::drop_dlc1_hunter_piece_1, 8), _id_2792("Hunter dlc2 piece 2", ::drop_dlc1_hunter_piece_2, 8), _id_2792("Hunter dlc3 piece 3", ::drop_dlc1_hunter_piece_3, 8)]);
  }

  if(maps\mp\_utility::_id_4571() == "mp_zombie_berlin") {
    level._id_AC09 = common_scripts\utility::_id_0F73(level._id_AC09, [_id_2792("drop_dlc2_char_a_0", ::drop_dlc2_char_a_piece_1, 8), _id_2792("drop_dlc2_char_a_1", ::drop_dlc2_char_a_piece_2, 8), _id_2792("drop_dlc2_char_a_2", ::drop_dlc2_char_a_piece_3, 8)]);
  }

  level._id_AC0A = [_id_2792("free blitz bullets ( doubletap )", ::_id_344C, 12.5), _id_2792("free blitz reload ( fastreload )", ::_id_344E, 12.5), _id_2792("free blitz shock ( electriccherry )", ::_id_344D, 12.5), _id_2792("free blitz sprint ( runperk )", ::_id_3451, 12.5), _id_2792("free blitz strike ( punchperk )", ::_id_344F, 12.5), _id_2792("free panzer armor ( armor )", ::_id_344B, 12.5), _id_2792("free blitz revive ( quickrevive )", ::_id_3450, 12.5), _id_2792("free mystery box coupon", ::_id_3452, 12.5)];
  level thread _id_9D20();
  level thread maps\mp\_utility::_id_6F74(::_id_A0C4);
  level._effect["zmb_treasure_icon"] = loadfx("vfx/gameplay/mp/zombie/zmb_treasure_icon");
}

_id_9D2E() {
  _id_4394() attach("zom_bomb_treasure", "TAG_WEAPON_CHEST");
  thread _id_1138();
}

treasurer_tesla_delayed_dmg(var_0, var_1, var_2) {
  if(common_scripts\utility::_id_562E(var_1)) {
    var_0 = maps\mp\gametypes\zombies::_id_1E59();
  }

  if(isDefined(var_2)) {
    var_0 = var_2;
  }

  return var_0;
}

_id_1138() {
  var_0 = self gettagindex("TAG_FX");

  if(var_0 == -1) {}

  thread _id_1139();
}

_id_1139() {
  self endon("death");
  waitframe();
  waitframe();
  waitframe();
  waitframe();
  _playFXOnTag(level._effect["zmb_treasure_icon"], self, "TAG_FX");
}

_id_9D38() {
  var_0 = _id_4394();
  var_0._id_8B72 = 0;
  var_1 = 1;
  var_2 = var_1 * 1000;

  for(;;) {
    wait(var_1);

    if(!common_scripts\utility::_id_562E(var_0._id_4BA0)) {
      continue;
    }
    if(!isDefined(level.players)) {
      continue;
    }
    foreach(var_4 in level.players) {
      if(!var_4 common_scripts\utility::_id_7237(var_0, var_2)) {
        continue;
      }
      var_4 thread _id_054E::_id_7465();
      var_0._id_8B72 = 1;
      var_0._id_1723 = 1;
      return;
    }
  }
}

_id_9D32() {
  var_0 = _id_4394();

  for(;;) {
    wait(_id_9D29());

    if(!common_scripts\utility::_id_562E(var_0._id_4BA0)) {
      continue;
    }
    var_1 = _id_9D27();

    if(var_1 <= 0) {
      continue;
    }
    var_2 = _id_4166(var_0.origin);
    var_3 = _id_0544::_id_8ADF(var_2, "Treasure zombie!!!", var_0);
    var_3 _id_0544::_id_8AD9(var_1);
    var_3._id_6FD4 = _id_9D2A();
    var_3._id_6FCB = _id_9D28();
  }
}

_id_9D2F() {
  var_0 = _id_4394();
  var_1 = getarraykeys(level._id_AC80._id_ACB3);
  var_2 = common_scripts\utility::random(var_1);
  var_0._id_9820 = var_2;
}

_id_9D34() {
  var_0 = _id_4394();
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("owner_disconnect");
  var_0 _meth_85A1("zombie_exploder");
  var_0 _id_0566::_id_ABB5();
  var_0 childthread _id_9D35();
  var_0 childthread _id_9D38();
  var_0 childthread _id_9D32();
  var_0._id_6816 = 1;
  var_0._id_5D5F = 1;
  var_0._id_57E8 = 1;
  var_0._id_57FD = 1;
  var_0._id_55AB = 1;
  var_0._id_562B = 1;
  var_0._id_5569 = 1;
  var_0._id_A572 = [];
  var_0 _id_0378::_id_8D74("aud_treasurer_strt_timer");
  var_1 = 0.2;

  for(;;) {
    wait(var_1);

    if(_id_053C::_id_4F8C()) {
      continue;
    }
    if(_id_053C::_id_4F84()) {
      continue;
    }
    if(var_0._id_8B72) {
      var_2 = _id_055A::_id_578B(var_0.origin, 0);
      var_0._id_2920 = var_2;

      if(isDefined(var_2)) {
        var_0._id_5B2F = var_2;
        var_0._id_A572[var_2] = gettime() * 0.001;
      }

      if(isDefined(var_0._id_9820)) {
        if(_id_0547::_id_5565(var_0._id_9820, var_2)) {
          var_0._id_9820 = undefined;
        } else {
          var_3 = level._id_AC80._id_ACB3[var_0._id_9820];
          var_0 _id_053C::_id_06CE(var_3._id_74DC);
        }

        var_0 _id_053C::_id_0647();
        continue;
      }

      var_4 = [];

      if(isDefined(var_2)) {
        var_3 = level._id_AC80._id_ACB3[var_2];
        var_4 = common_scripts\utility::array_randomize(getarraykeys(var_3._id_0A01));
      }

      var_5 = undefined;
      var_6 = undefined;

      foreach(var_8 in var_4) {
        var_9 = var_0._id_A572[var_8];

        if(!isDefined(var_9)) {
          var_5 = var_8;
          break;
        }

        if(isDefined(var_6) && var_9 > var_6) {
          continue;
        }
        var_5 = var_8;
        var_6 = var_9;
      }

      if(isDefined(var_5)) {
        var_0._id_9820 = var_5;
      } else {
        var_0 _id_9D2F();
      }
    } else {
      if(_id_053C::_id_4F9B()) {
        continue;
      }
      if(_id_053C::_id_4F9A()) {
        continue;
      }
    }

    var_0 _id_053C::_id_0647();
  }
}

_id_9D35() {
  var_0 = _id_4394();

  while(!common_scripts\utility::_id_562E(var_0._id_4BA0)) {
    waitframe();
  }

  var_0._id_4BA1 = gettime();
  var_1 = 0;

  for(;;) {
    wait 1;

    if(_id_9D25() > _id_9D26()) {
      break;
    }

    if(_id_9D25() > _id_9D26() * 0.5) {
      if(!var_1) {
        var_2 = common_scripts\utility::_id_4461(var_0.origin, level.players);

        if(isDefined(var_2) && !_id_0547::_id_577E(var_2)) {
          var_2 thread _id_054E::_id_9D39();
          var_1 = 1;
        }
      }
    }
  }

  var_0 _id_0378::_id_8D74("aud_treasurer_fuse");
  wait 0.5;
  var_0 _id_0378::_id_8D74("aud_treasurer_end_timer");
  var_3 = var_0 gettagorigin("TAG_WEAPON_CHEST");
  var_0 _meth_8561("drag_explosive_zm");
  _id_0563::_id_AB98(var_3);
  _id_0563::_id_AB9C(var_3);
  _id_0563::_id_AB9E(var_3);
  var_0 suicide();
}

_id_9D2D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _id_4394();

  if(isPlayer(var_1)) {
    level thread _id_348E(var_9.origin);
    thread _id_054E::_id_9D3A(var_1, 1);
    level._id_400E[level._id_400E.size] = ["raven_set 0 1", "all"];
  } else {
    var_10 = common_scripts\utility::_id_4461(var_9.origin, level.players);

    if(isDefined(var_10) && !_id_0547::_id_577E(var_10)) {
      thread _id_054E::_id_9D3A(var_10, 0);
    }
  }

  var_9 _id_0378::_id_8D74("aud_treasurer_end_timer");
  var_9 detach("zom_bomb_treasure", "TAG_WEAPON_CHEST");
  var_9 _id_054D::_id_6BD4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_9D2B() {
  var_0 = _id_4394();

  if(!common_scripts\utility::_id_562E(var_0._id_4BA0)) {
    return "walk";
  }

  if(common_scripts\utility::_id_562E(var_0._id_8B72)) {
    return "sprint";
  }

  return "run";
}

_id_9D23() {
  var_0 = _id_054D::_id_AC22();
  var_0["script_var"] = "held_bomb";
  var_0["zombie_subtype"] = "zombie_exploder";
  return var_0;
}

_id_9D37(var_0) {
  for(var_1 = 1; var_0 > 0; var_0 = var_0 - var_1) {
    wait(var_1);
  }

  while(common_scripts\utility::_id_562E(level._id_6F1E)) {
    wait 60;
  }
}

_id_9D20() {
  if(common_scripts\utility::_id_562E(level._id_323A)) {
    return;
  }
  while(_id_9D31() && (!isDefined(level._id_AC1D) || !_id_0F4C())) {
    wait 1;
  }

  while(_id_9D30() && (!isDefined(level._id_AC80) || !common_scripts\utility::_id_562E(level._id_AC80._id_08A9) || !_id_055A::_id_0F4F(1))) {
    wait 1;
  }

  var_0 = 4320.0;
  var_1 = var_0;

  if(isDefined(level.players)) {
    var_2 = [];

    foreach(var_4 in level.players) {
      var_5 = _id_431A(var_4);
      var_6 = var_4 getplayerdata(common_scripts\utility::_id_46A8(), "totalTimePlayedAsOfTreasureZombieKill");
      var_7 = clamp(var_5 - var_6, 0, var_0);
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_7);
    }

    var_7 = common_scripts\utility::_id_6880(var_2);
    var_1 = var_0 - var_7 + _randomfloatrange(20, 90.0);
  }

  for(;;) {
    _id_9D37(var_1);
    var_9 = undefined;
    var_10 = "Treasure zombie!!!";
    var_11 = 1;
    var_12 = 1;
    var_13 = 0;
    var_14 = _id_054D::_id_90BA("zombie_treasurer", var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_14)) {
      var_1 = var_0;
      continue;
    }

    var_1 = 30;
  }
}

_id_A0C4() {
  var_0 = _id_4296();
  var_0 endon("disconnect");

  for(;;) {
    level waittill("zombie_spawned", var_1);

    if(!_id_0547::_id_5565(var_1._id_0A4B, "zombie_treasurer")) {
      continue;
    }
    var_2 = _id_431A(var_0);
    var_0 setplayerdata(common_scripts\utility::_id_46A8(), "totalTimePlayedAsOfTreasureZombieKill", var_2);
  }
}

_id_4166(var_0) {
  var_1 = _id_9D24();
  var_2 = var_0;
  var_3 = 0;
  var_4 = 5;
  var_5 = _func_2E0(var_0, var_1, var_4);

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(!_func_2DE(var_0, var_7)) {
        continue;
      }
      var_8 = distance(var_0, var_7);

      if(var_8 > var_3) {
        var_2 = var_7;
        var_3 = var_8;
      }
    }
  }

  return var_2;
}

_id_2792(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_2AF8 = var_0;
  var_3._id_1E61 = var_1;
  var_3._id_3489 = var_2;
  return var_3;
}

_id_3478(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2 thread[[var_1]]();
}

_id_3479(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_2 = var_2 + var_4._id_3489;
  }

  var_2 = _randomfloat(var_2);
  var_6 = undefined;

  foreach(var_4 in var_0) {
    if(var_2 > var_4._id_3489) {
      var_2 = var_2 - var_4._id_3489;
      continue;
    }

    var_6 = var_4;
    break;
  }

  if(!isDefined(var_6)) {
    var_6 = common_scripts\utility::random(var_0);
  }

  _id_3478(var_1, var_6._id_1E61);
}

_id_348E(var_0) {
  _id_3479(level._id_AC09, var_0);
  wait 1;
  _id_3479(level._id_AC0A, var_0);
}

_id_4167() {
  var_0 = self;
  return var_0;
}

_id_3477(var_0) {
  level._id_400E[level._id_400E.size] = ["treasure_set " + var_0 + " 1", "all"];
}

_id_3472() {
  _id_3477(0);
}

_id_3473() {
  _id_3477(1);
}

_id_3474() {
  _id_3477(2);
}

_id_3475() {
  _id_3477(3);
}

_id_3476() {
  _id_3477(4);
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

_id_3485(var_0) {
  var_1 = _id_4167();
  var_2 = _id_4166(var_1.origin);
  maps\mp\gametypes\zombies::_id_281C(var_0, var_2, "Treasure zombie!!!");
}

_id_3484() {
  _id_3485("ammo");
}

_id_3483() {
  _id_3485("ability_fill");
}

_id_9D18(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _id_4296();

  if(!isDefined(var_1._id_9D1E)) {
    var_1._id_9D1E = [];
  }

  if(!isDefined(var_1._id_9D1E[var_0])) {
    var_1._id_9D1E[var_0] = 0;
  }
}

_id_9D1B(var_0) {
  var_1 = _id_4296();
  var_1 _id_9D18(var_0);
  var_1._id_9D1E[var_0]++;
  var_1 notify("perk_discount_applied");
}

_id_9D1A(var_0) {
  var_1 = _id_4296();
  var_1 _id_9D18(var_0);

  if(var_1 _id_9D19(var_0) <= 0) {
    return;
  }
  var_1._id_9D1E[var_0]--;
  var_1 notify("used_vending_machine_discount");
}

_id_9D19(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = _id_4296();
  var_1 _id_9D18(var_0);
  return var_1._id_9D1E[var_0];
}

_id_9D1C() {
  return _id_9D19("mysterybox_coupon");
}

_id_9D1D() {
  return _id_9D1A("mysterybox_coupon");
}

_id_3453(var_0) {
  if(!isDefined(level.players)) {
    return;
  }
  foreach(var_2 in level.players) {
    var_2 _id_9D1B(var_0);
  }
}

_id_344C() {
  _id_3453("doubletap");
}

_id_344E() {
  _id_3453("fastreload");
}

_id_344D() {
  _id_3453("electriccherry");
}

_id_3451() {
  _id_3453("runperk");
}

_id_344F() {
  _id_3453("punchperk");
}

_id_344B() {
  _id_3453("armor");
}

_id_3450() {
  _id_3453("quickrevive");
}

_id_3452() {
  _id_3453("mysterybox_coupon");
  _id_0548::playsoundasmaster();
}

_id_431A(var_0) {
  var_1 = var_0 getplayerdata(common_scripts\utility::_id_46A8(), "totalTimePlayed") + var_0._id_9A06["total"];
  return var_1;
}

_id_9D26() {
  return 45;
}

_id_9D24() {
  return 70;
}

_id_9D27() {
  return 100;
}

_id_9D29() {
  return 1;
}

_id_9D28() {
  return 1.7;
}

_id_9D2A() {
  return 0.5;
}

_id_9D31() {
  return 0;
}

_id_9D30() {
  return 1;
}

_id_9D25() {
  var_0 = _id_4394();

  if(!isDefined(var_0._id_4BA1)) {
    return 0;
  }

  var_1 = (gettime() - var_0._id_4BA1) * 0.001;
  return var_1;
}

_id_4394() {
  var_0 = self;
  return var_0;
}

_id_4296() {
  var_0 = self;
  return var_0;
}

_id_0F4C() {
  if(!isDefined(level._id_AC1D)) {
    return 0;
  }

  foreach(var_1 in level._id_AC1D) {
    if(!common_scripts\utility::_id_562E(var_1._id_6BE1)) {
      return 0;
    }
  }

  return 1;
}