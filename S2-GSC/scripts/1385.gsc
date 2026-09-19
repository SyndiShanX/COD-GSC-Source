/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1385.gsc
**************************************/

_id_5326() {
  if(common_scripts\utility::_id_3C83("pap_in_use")) {
    return;
  }
  common_scripts\utility::flag_init("pap_in_use");
  common_scripts\utility::flag_init("pap_weapon_ready");
  _id_0547::_id_A78B();
  common_scripts\utility::_id_092C("zmb_pack_a_punch_lathe", "vfx/map/mp_zombie_nest/zmb_pack_a_punch_lathe");
  common_scripts\utility::_id_092C("zmb_pack_a_punch_lathe_ammo", "vfx/map/mp_zombie_nest/zmb_pack_a_punch_lathe_ammo");
  var_0 = common_scripts\utility::_id_44BE("pack_a_punch", "targetname");

  foreach(var_2 in var_0)
  level thread _id_6E40(var_2);
}

_id_6E40(var_0) {
  wait_for_pack_a_punch_conditions();
  var_1 = strtok(var_0._id_8260, ",");
  var_2 = int(var_1[0]);

  if(var_1.size > 1)
    var_3 = int(var_1[1]);
  else
    var_3 = 4000;

  if(getdvarint("spv_zmb_event_mtx5_active", 0)) {
    var_2 = 2000;
    var_3 = 1000;
  }

  if(0) {}

  var_4 = getEntArray(var_0.target, "targetname");

  if(var_4.size == 4) {
    var_5 = _func_21F("zmb_upgrade_machine", "targetname");

    for(var_6 = 0; var_6 < 4; var_6++) {
      var_4[var_6]._id_81E1 = var_6;
      var_4[var_6]._id_82EF = var_5[var_6];
    }
  }

  foreach(var_8 in var_4) {
    if(isDefined(var_8)) {
      var_8 _meth_8177();

      if(0) {
        var_8._id_1DE6 = &"ZOMBIES_WEAPON_LEVEL_BOX";
        var_8._id_1DE4 = &"ZOMBIES_WALL_BUY_AMMO";
        var_8._id_1DE5 = _id_0547::_id_4474(var_2);
        var_8._id_1DE3 = _id_0547::_id_4474(var_3);
      }

      var_8._id_6DE1 = var_2;
      var_8._id_6DE0 = var_3;
      var_8.is_pap_trigger = 1;

      if(_id_0547::_id_5819(var_8))
        _id_0547::_id_8A4F(var_8, ::_id_10E1, ::_id_4D14);
      else if(0) {
        var_8 _meth_80CE(var_8._id_1DE6);
        var_8 _meth_80CF(var_8._id_1DE5);
      }

      var_8 thread _id_6E41();
    }
  }
}

_id_45A0(var_0, var_1) {
  var_2 = _func_1AC(var_0, self.origin);
  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++)
    var_3[var_4] = var_2[var_4];

  return var_3;
}

_id_6E41() {
  var_0 = self;
  level endon("game_over");
  self._id_738D = undefined;
  var_1 = _func_18E("pack_a_punch_weapon_display", "targetname");
  var_1 _meth_8511();

  for(;;) {
    [var_3, var_4] = _id_0547::_id_A795();

    if(common_scripts\utility::_id_3C77("pap_in_use")) {
      continue;
    }
    var_5 = var_3 _meth_8317();

    if(_id_0547::_id_57AF(var_5) || _id_0547::_id_5862(var_5) || _id_0547::iszombieconsumableweapon(var_5)) {
      continue;
    }
    var_6 = _id_0547::_id_5868(var_5);

    if(var_6) {
      var_7 = self._id_6DE0;

      if(_id_0548::_id_4B6A(var_3, var_5)) {
        _id_0548::_id_300A(var_3, 0);
        continue;
      }

      if(!var_3 maps\mp\gametypes\zombies::_id_11C2(var_7)) {
        var_3 thread _id_054E::_id_0695("needmoney");
        continue;
      }

      var_3 thread _id_054E::_id_62D9();
      _id_0548::_id_AC57(var_3, var_5);
      _id_0547::_id_4AE4(var_3, "pack_a_punch_ammo", var_7, var_5, "none");

      if(!common_scripts\utility::_id_3C77("pap_in_use"))
        _func_147(level._effect["zmb_pack_a_punch_lathe_ammo"], self._id_82EF, "lathe_01");

      continue;
    }

    if(isDefined(level.extra_upgrade_func))
      level thread[[level.extra_upgrade_func]](var_3);

    var_8 = var_3 _id_0586::_id_078B(var_5);

    if(!isDefined(var_8)) {
      _id_0555::_id_83DD("no_upgrade", var_3);
      continue;
    }

    var_7 = int(self._id_6DE1);

    if(!var_3 maps\mp\gametypes\zombies::_id_11C2(var_7)) {
      var_3 thread _id_054E::_id_0695("needmoney");
      continue;
    }

    var_3 thread _id_054E::_id_62D9();
    var_3 _id_0586::_id_0790(var_5);

    if(_id_0547::_id_5864(var_5) && !issubstr(var_5, "razergun")) {
      var_9 = var_3 _meth_82D5();

      if(!isDefined(var_9) || _id_0547::_id_5565(var_9, "none")) {
        var_10 = _id_0548::_id_454B(var_3, "shovel_zm");
        var_3 _id_0586::_id_078C(var_10);
      }
    }

    var_11 = var_3 getweaponlistprimaries();

    if(var_11.size > 0)
      var_3 _id_0586::_id_078E(var_11[0]);

    _id_0547::_id_4AE4(var_3, "pack_a_punch", var_7, var_8, "none");

    if(maps\mp\_utility::_id_4571() == "mp_zombie_nest_01") {
      var_12 = var_3 maps\mp\gametypes\_playerlogic::_id_4005();

      if(!isDefined(var_3.magicboxweaponsrolled))
        var_3.magicboxweaponsrolled = [];

      if(common_scripts\utility::_id_0F79(var_12, var_5) || !common_scripts\utility::_id_0F79(var_3.magicboxweaponsrolled, var_5))
        level._id_400E[level._id_400E.size] = ["survivalist_set 4 -1", var_3];
    } else if(maps\mp\_utility::_id_4571() == "mp_zombie_island") {
      var_12 = var_3 maps\mp\gametypes\_playerlogic::_id_4005();

      if(!isDefined(var_3.magicboxweaponsrolled))
        var_3.magicboxweaponsrolled = [];

      if(common_scripts\utility::_id_0F79(var_12, var_5) || !common_scripts\utility::_id_0F79(var_3.magicboxweaponsrolled, var_5))
        var_3 notify("invalid_pack_a_punch");
    }

    var_13 = _id_0547::_id_AAF9(var_8);
    _id_0555::_id_83DD("upgrade", var_3, var_13);

    if(isDefined(level.zmb_events_upgraded_a_weapon))
      level thread[[level.zmb_events_upgraded_a_weapon]](var_3);

    common_scripts\utility::flag_set("pap_in_use");
    self._id_738D = var_3;
    level notify("pap_state_change");
    self._id_82EF _id_854A(var_5, var_8);
    common_scripts\utility::flag_set("pap_weapon_ready");

    if(0)
      self _meth_80CF(&"ZOMBIES_EMPTY_STRING");

    level notify("pap_state_change");
    var_0 thread _id_7485(var_3);
    var_0 thread _id_9E21(var_3, var_8, var_3 _id_0586::_id_078B(var_5, undefined, undefined, 1));
    common_scripts\utility::_id_A70C(var_0, "pap - player took gun", var_0, "pap - player timed out", var_3, "disconnect");

    if(0)
      self _meth_80CF(self._id_1DE5);

    _id_4D1D(self._id_82EF._id_586E);
    common_scripts\utility::_id_3C7B("pap_weapon_ready");
    self._id_738D = undefined;
    common_scripts\utility::_id_3C7B("pap_in_use");
    level notify("pap_state_change");
  }
}

_id_4D1D(var_0) {
  var_0 _meth_8511();
}

_id_9E21(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("pap - player timed out");
  var_0 endon("disconnect");
  var_4 = undefined;
  var_3 wait_for_response(var_4, var_0);
  var_5 = common_scripts\utility::_id_562E(var_3.double_tapped);
  var_3.double_tapped = undefined;

  if(var_5)
    var_1 = var_2;

  var_3 notify("pap - player took gun");
  var_0 common_scripts\utility::_id_379A("flag_player_has_paped");
  var_0 _id_6E46(var_1);

  if(issubstr(var_1, "austen"))
    thread _id_0380::_id_6840("zmb_fog_rolling_out_austen", var_0);
}

wait_for_response(var_0, var_1) {
  var_2 = self;
  var_1 endon("disconnect");
  var_2 endon("trigger");
  var_2 endon("pap - player timed out");
  var_1 childthread watch_for_pap_double_tap(var_2);

  while(!_id_0547::_id_5565(var_0, var_1))
    var_2 waittill("trigger", var_0);
}

watch_for_pap_double_tap(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_0 endon("trigger");
  var_0 endon("pap - player timed out");
  var_2 = gettime();

  for(;;) {
    while(!var_1 interacting_with_this_trigger(var_0))
      waitframe();

    while(var_1 interacting_with_this_trigger(var_0))
      waitframe();

    if(gettime() - var_2 < 500) {
      var_0.double_tapped = 1;
      var_0 notify("trigger", var_1);
    }

    var_2 = gettime();
  }
}

interacting_with_this_trigger(var_0) {
  var_1 = self;
  return var_1 _meth_8341() && _id_0547::_id_5565(var_1 _meth_84D1(), var_0);
}

_id_7485(var_0) {
  var_1 = self;
  var_1 endon("pap - player took gun");
  var_0 endon("disconnect");
  wait 18;
  var_1 notify("pap - player timed out");
  level notify("PAP_display_reset");
}

_id_42A5() {
  return "flag_player_has_paped";
}

_id_10E1(var_0) {
  var_0 endon("disconnect");
  var_0 common_scripts\utility::_id_3799("flag_player_has_paped");
  thread _id_6E43(var_0);
  thread _id_8C10(var_0);
  thread _id_6E45(var_0);
  _id_0559::_id_7BE2(var_0, self, "pack");
}

#using_animtree("destructibles");

_id_854A(var_0, var_1) {
  var_2 = self.origin + (0, 0, 60);
  var_3 = _id_0380::_id_2889("zmb_pack_a_punch_use", undefined, var_2);
  _id_0378::_id_8D14(var_3);
  var_4 = self gettagorigin("lathe_01");
  level notify("PAP_display_reset");
  var_5 = _func_18E("pack_a_punch_weapon_display", "targetname");
  var_5.origin = (var_5.origin[0], var_5.origin[1], var_4[2]);

  if(!isDefined(level._id_6DDD))
    level._id_6DDD = var_5 common_scripts\utility::_id_8FFC();

  self._id_6DDD = level._id_6DDD;
  _id_801B(self, var_0);
  var_6 = level._id_6DDD.origin;
  var_7 = level._id_6DDD.angles;

  if(issubstr(var_0, "fliegerfaust"))
    thread _id_3C72(level._id_6DDD);

  var_8 = _func_14B(level._effect["zmb_pack_a_punch_lathe"], var_4, anglesToForward(self _meth_8181("lathe_01")), anglestoup(self _meth_8181("lathe_01")));
  _func_14C(var_8);
  self _meth_83FA("lathes", "turn_on");
  thread _id_9EDC();
  wait(_func_065(%zmb_pack_a_punch_lathes_turn_on) - 1.4);
  self _meth_83FA("lathes", "idle");
  var_8 delete();
  _id_801B(self, var_1);
  thread _id_7D78(var_6, var_7);
}

_id_7D78(var_0, var_1) {
  level common_scripts\utility::waittill_notify_or_timeout("PAP_display_reset", 18);
  level._id_6DDD.origin = var_0;
  level._id_6DDD.angles = var_1;
}

_id_8549(var_0, var_1) {
  thread _id_9EDB();
}

_id_801B(var_0, var_1) {
  var_2 = (0, 0, 0);
  var_3 = (0, 0, 0);

  if(issubstr(var_1, "springfield") || issubstr(var_1, "bren") || issubstr(var_1, "lewis") || issubstr(var_1, "m1941") || issubstr(var_1, "m1a1") || issubstr(var_1, "breda30"))
    var_2 = (-3, 0, 0);

  if(issubstr(var_1, "leeenfield") || issubstr(var_1, "mg42") || issubstr(var_1, "m1garand") || issubstr(var_1, "bar_") || issubstr(var_1, "m30") || issubstr(var_1, "karabin") || issubstr(var_1, "g43") || issubstr(var_1, "kar98") || issubstr(var_1, "teslagun"))
    var_2 = (-5, 0, 0);

  if(issubstr(var_1, "svt40") || issubstr(var_1, "walther") || issubstr(var_1, "m1919"))
    var_2 = (-7, 0, 0);

  if(issubstr(var_1, "zom_dlc2_1") || issubstr(var_1, "zom_dlc2_2") || issubstr(var_1, "zom_dlc2_3")) {
    var_3 = (-90, 0, 0);

    if(issubstr(var_1, "zom_dlc2_1"))
      var_2 = (2, 0, 0);
    else
      var_2 = (-7, 0, 0);
  }

  if(issubstr(var_1, "mg15"))
    var_2 = (-8, 0, 0);

  if(issubstr(var_1, "fliegerfaust"))
    var_2 = (0, 0, 10);

  if(isDefined(var_0._id_A6EA)) {
    var_0._id_586E _meth_848E(var_1);
    var_0._id_586E _meth_805B();
    var_0._id_A6EA = undefined;
  } else {
    if(isDefined(var_0._id_586E))
      var_0._id_586E delete();

    var_0._id_586E = spawn("weapon_" + var_1, var_0._id_6DDD.origin);
    var_0._id_586E _meth_8055(var_0._id_6DDD, "tag_origin", var_2, var_3);
    var_0._id_A6EA = 1;
  }

  var_0._id_586E _meth_80B3();
  var_0._id_586E _meth_86B3(0);
}

_id_3C72(var_0) {
  wait 0.7;
  var_0 _meth_82B4(-5, 0.1, 0, 0);
  wait 0.5;
  var_0 _meth_82B4(5, 0.5, 0.1, 0.1);
  wait 0.5;
  var_0 _meth_82B4(-5, 0.1, 0, 0);
  wait 0.5;
  var_0 _meth_82B4(5, 0.5, 0.1, 0.1);
  wait 1;
  var_0 _meth_82BA(20, 0.5, 0.1, 0.1);
  wait 1;
  var_0 _meth_82B4(-10, 0.5, 0.1, 0.1);
}

_id_9EDC() {
  self _meth_83FA("wheel", "turn");
  wait(_func_065(%zmb_pack_a_punch_wheel_turn));
  self _meth_83FA("wheel", "turn_idle");
}

_id_9EDB() {
  self _meth_83FA("wheel", "reverse");
  wait(_func_065(%zmb_pack_a_punch_wheel_reverse));
  self _meth_83FA("wheel", "idle");
}

_id_21BD(var_0, var_1) {
  var_0 endon("disconnect");

  for(;;) {
    var_0 common_scripts\utility::_id_A70A("weapon_change", "new_equipment");
    _id_6E44(var_0, var_1);
  }
}

_id_21BB(var_0, var_1) {
  var_0 endon("disconnect");

  for(;;) {
    level waittill("pap_state_change");
    _id_6E44(var_0, var_1);
  }
}

_id_6E44(var_0, var_1) {
  wait 0.1;
  var_2 = 0;
  var_3 = "none";
  var_4 = _id_0547::_id_462A(var_0);

  if(var_4 != "none")
    var_3 = _func_05F(var_4);

  if(_id_0547::_id_5868(var_3))
    var_2 = 1;

  if(0)
    self _meth_80CD("HINT_NOICON");

  if(1)
    var_1.interact_disabled = undefined;

  if(common_scripts\utility::_id_3C77("pap_weapon_ready") && isDefined(self._id_738D) && self._id_738D == var_0) {
    if(1) {
      var_1._id_6F58 = "pack_pick";
      var_1._id_6F56 = 0;
    }
  } else if(common_scripts\utility::_id_3C77("pap_in_use")) {
    self._id_3006 = undefined;

    if(0) {
      self _meth_80CE("Unavailable");
      self _meth_80CF("");
    }

    if(1) {
      var_1._id_6F58 = "pack_busy";
      var_1.interact_disabled = 1;
      var_1._id_6F56 = 0;
    }
  } else if(_id_0547::_id_57AF(var_4) || _id_0547::_id_5862(var_4) || _id_0547::iszombieconsumableweapon(var_4) || _id_0547::_id_585B(var_4) || _id_0547::_id_5864(var_4) && !ispappablemeleeweapon(var_4) || issubstr(var_4, "tesla") && (!common_scripts\utility::_id_3C83("teslagun_punch_active") || common_scripts\utility::_id_3C83("teslagun_punch_active") && !common_scripts\utility::_id_3C77("teslagun_punch_active")) || issubstr(var_4, "razergun_melee_zm")) {
    self._id_3006 = undefined;

    if(0) {
      self _meth_80CE("");
      self _meth_80CF("");
    }

    if(1) {
      var_1._id_6F58 = "pack_noup";
      var_1.interact_disabled = 1;
      var_1._id_6F56 = 0;
    }
  } else if(var_2) {
    self._id_3006 = self._id_6DE0;

    if(0) {
      self _meth_80CE(self._id_1DE4);
      self _meth_80CF(self._id_1DE3);
    }

    if(1) {
      var_1._id_6F58 = "pack_ammo";
      var_1._id_6F56 = self._id_3006;
    }
  } else {
    self._id_3006 = self._id_6DE1;

    if(0) {
      self _meth_80CE(self._id_1DE6);
      self _meth_80CF(self._id_1DE5);
    }

    if(1) {
      var_1._id_6F58 = "pack";
      var_1._id_6F56 = self._id_3006;
    }
  }

  if(1)
    var_1._id_6642 = 1;
}

ispappablemeleeweapon(var_0) {
  if(var_0 == "zom_dlc2_3_zm" || var_0 == "zom_dlc2_2_zm" || var_0 == "zom_dlc2_1_zm") {
    if(common_scripts\utility::_id_3C83("dlc2_melee_packable") && common_scripts\utility::_id_3C77("dlc2_melee_packable"))
      return 1;
  }

  return 0;
}

_id_6E43(var_0) {
  var_1 = undefined;

  if(1)
    var_1 = _id_0552::_id_7BF3(var_0, self);

  thread _id_21BD(var_0, var_1);
  thread _id_21BB(var_0, var_1);
}

wait_for_pack_a_punch_conditions() {
  if(isDefined(level.pack_a_punc_pre_func))
    level[[level.pack_a_punc_pre_func]]();
}

_id_4D14(var_0) {
  self._id_82EF _meth_8006(var_0);
}

_id_8C10(var_0) {
  if(isDefined(level.upgrade_machine_reveal_func))
    [[level.upgrade_machine_reveal_func]](var_0, self._id_82EF);

  self._id_82EF _meth_8005(var_0);
}

_id_6E45(var_0) {
  var_0 endon("disconnect");
}

_id_86EE(var_0) {
  var_1 = 5;
  var_2 = [];
  var_3 = self._id_6DE1;
  var_4 = self._id_6DE0;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = 0;

    for(var_7 = _func_1E2(10, var_1 - var_5); var_3 >= var_7 / 10; var_6++)
      var_3 = var_3 - var_7 / 10;

    var_2[var_5] = var_6;
  }

  for(var_5 = 0; var_5 < var_1; var_5++)
    self._id_82EF _meth_83FA("gears_0" + (var_5 + 1), "idle_" + var_2[var_5]);
}

_id_6E46(var_0) {
  maps\mp\gametypes\zombies::_id_283D(self, var_0);
  self._id_6E48++;
  level notify("PAP_display_reset");

  if(_id_0547::_id_73F9(self, var_0))
    _id_0586::_id_0790(var_0);

  thread _id_054E::playerbuyweapon(1);

  if(_id_0547::_id_5864(var_0))
    _id_0548::wallbuygivemelee(self, var_0);
  else
    _id_0548::_id_A7D6(self, var_0);

  _id_0548::_id_AABC(self);
}

_id_55D4(var_0) {
  return issubstr(var_0, "_pap_zm");
}

_id_40BD(var_0) {
  if(!isDefined(level._id_40BE))
    level._id_40BE = [];

  var_1 = level._id_40BE[var_0];

  if(!isDefined(var_1)) {
    var_1 = _id_40BF(var_0);

    if(level._id_40BE.size < 1000)
      level._id_40BE[var_0] = var_1;
  }

  return var_1;
}

_id_40BF(var_0) {
  var_1 = common_scripts\utility::_id_9462(var_0, "_pap_zm");
  var_2 = "";

  if(var_1 != -1) {
    var_3 = getsubstr(var_0, 0, var_1);
    var_4 = getsubstr(var_0, var_1 + 4);
    var_2 = var_3 + var_4;
  } else
    var_2 = var_0;

  return var_2;
}