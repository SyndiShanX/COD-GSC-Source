/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2403.gsc
*************************************************/

init() {
  level._id_7CDD = ::_id_1023E;
  _id_7F83();
  _id_9610();
}

_id_7F83() {
  scripts\engine\utility::_id_5C11("hvt_boss_combat_stage_two");
  scripts\engine\utility::_id_5C11("hvt_boss_combat_stage_three");
}

_id_E5C6() {
  _id_E5D3();
  level thread _id_53B0();
  level thread _id_5389();
  level thread _id_53ED();
}

_id_E5D3() {
  var_0 = _func_00E5("main_start", "targetname");
  var_1 = _func_0216("veh8_mil_lnd_vindia_a1", "target_enemy_vehicle", "vindia", var_0.origin, var_0.angles);
  var_1 _meth_8020(var_0);
  var_1 _meth_83DC();
  var_1 _meth_8438(50, 50, 50);
  var_1._id_A757 = 0;
  level._id_53B5 = var_1;
  var_1 thread _id_F3E5(var_1);
  var_1 thread _id_E5BE(var_1);
  var_1 thread _id_53B6(var_1);
  var_1 _id_BE5E(var_1);
  var_1 thread _id_C05D(var_1);
  var_1 thread _id_67D4(var_1);
  var_1 thread _id_5E13(var_1, level._id_B4E2, 60, 35, 1750, 7, 4.5, 2, 155);
  _id_0743::_id_C9FD("enemy_hvt_boss_spawner");
}

_id_C05D(var_0) {
  var_0 endon("death");
  var_1 = scripts\engine\utility::getstruct("enemy_target_vehicle_end_point", "targetname");

  for(;;) {
    if(distance2dsquared(var_1.origin, var_0.origin) <= 22500) {
      level thread _id_465B();
      return;
    }

    wait 0.1;
  }
}

_id_67D4(var_0) {
  var_0 endon("death");
  var_1 = 0;

  for(;;) {
    if(_id_53B4(var_0)) {
      if(_id_53B2(var_0)) {
        level thread _id_465B();
        return;
      }

      if(var_1 == 0) {
        var_1 = 1;
        _id_DC36(var_0);
      }
    } else if(var_1 == 1) {
      var_1 = 0;
      _id_78A7(var_0);
    }

    waitframe();
  }
}

_id_DC36(var_0) {
  if(_id_DAC1()) {
    iprintlnbold("Enemy HVT is getting away!");
  }

  _func_0188(var_0._id_A882);
  _func_016B(var_0._id_A882, "current");
}

_id_78A7(var_0) {
  _func_018B(var_0._id_A882);
  _func_016B(var_0._id_A882, "invisible");
}

_id_DAC1() {
  if(!isDefined(level._id_A48D)) {
    level._id_A48D = 0;
  }

  var_0 = gettime();

  if(var_0 > level._id_A48D) {
    level._id_A48D = var_0 + 5000;
    return 1;
  } else
    return 0;
}

_id_53B4(var_0) {
  if(distance2dsquared(level._id_B4E2.origin, (0, 0, 0)) < 40000) {
    return 0;
  }

  return distance2dsquared(var_0.origin, level._id_B4E2.origin) > 25000000;
}

_id_53B2(var_0) {
  if(distance2dsquared(level._id_B4E2.origin, (0, 0, 0)) < 40000) {
    return 0;
  }

  return distance2dsquared(var_0.origin, level._id_B4E2.origin) > 256000000;
}

_id_107C(var_0) {
  var_1 = scripts\engine\utility::getstruct("enemy_hvt_weak_spot_marker", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("crate_plastic_box_red");
  var_2.angles = var_1.angles;
  var_2 linkto(var_0);
  var_2 thread _id_383B(var_2, var_0);
  var_2 thread _id_7C14(var_2, var_0);
}

_id_383B(var_0, var_1) {
  var_1 waittill("death");
  var_0 delete();
}

_id_7C14(var_0, var_1) {
  var_0 endon("death");
  var_1._id_10CE1 = 0;
  var_1._id_10CE0 = var_0;
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0._id_58FA = 30;

  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(isPlayer(var_3) && isDefined(var_2)) {
      var_3 _id_071B::_id_FC86("standard", 1, var_2, 0, 0);
      var_0._id_58FA = var_0._id_58FA - var_2;

      if(var_0._id_58FA < 0) {
        break;
      }
    }
  }

  iprintlnbold("Vehicle armor has been destroyed");
  var_1._id_10CE1 = 1;
  var_0 setModel("tag_origin");
  var_0 thread _id_1B2E(var_0);
}

_id_1B2E(var_0) {
  var_0 endon("death");
  playFXOnTag(level._effect["hvt_vehicle_armor_explosion"], var_0, "tag_origin");

  for(;;) {
    playFXOnTag(level._effect["hvt_vehicle_armor_disabled"], var_0, "tag_origin");
    var_1 = randomfloatrange(0.5, 0.9);
    wait(var_1);
  }
}

_id_1023E(var_0) {
  _id_3475(var_0);
  _id_3476(var_0);
}

_id_3476(var_0) {
  if(!isDefined(level._id_53B5)) {
    return;
  }
  if(distance2dsquared(var_0.origin, level._id_53B5.origin) < 90000) {
    level._id_53B5._id_A757++;

    switch (level._id_53B5._id_A757) {
      case 1:
        _id_B2D3();
        iprintlnbold("Successful IED hit!");
        break;
      case 2:
        _id_B2D4();
        iprintlnbold("Successful IED hit!");
        break;
      case 3:
        _id_53B8();
        level thread _id_3D20();
        break;
    }
  }
}

_id_3475(var_0) {
  if(isDefined(var_0.target)) {
    var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_2 = var_1._id_DD31;
    var_2 = scripts\engine\utility::_id_1BD1(var_2);
    var_3 = scripts\engine\utility::_id_6369(var_0.origin, var_2)[0];
    playFX(level._effect["sight_blocker_explosion"], var_3.origin);
    var_3 delete();
  }
}

_id_B2D3() {
  var_0 = ["tag_wheel_center_front_left", "tag_wheel_center_middle_left", "tag_wheel_center_back_left"];
  var_1 = ["tag_wheel_center_front_right", "tag_wheel_center_middle_right", "tag_wheel_center_back_right"];

  foreach(var_3 in var_0) {
    playFXOnTag(level._effect["hvt_vehicle_tire_damage_smoke_left"], level._id_53B5, var_3);
  }

  foreach(var_6 in var_1) {
    playFXOnTag(level._effect["hvt_vehicle_tire_damage_smoke_right"], level._id_53B5, var_6);
  }
}

_id_B2D4() {
  var_0 = ["rear_hatch_jnt", "drivers_hatch_jnt"];

  foreach(var_2 in var_0) {
    playFXOnTag(level._effect["hvt_vehicle_hood_damage_smoke"], level._id_53B5, var_2);
  }
}

_id_53B8() {
  playsoundatpos(level._id_53B5.origin, "frag_grenade_expl_trans");
  earthquake(0.5, 1.2, level._id_53B5.origin, 4000);
  playFX(level._effect["hvt_vehicle_explosion"], level._id_53B5.origin);
  level._id_53B5 delete();
}

_id_3D20() {
  iprintln("You Won!");
  wait 4.0;
  level thread[[level._id_52F7]]("axis", level._id_52A0["win"]);
}

_id_BE5E(var_0) {
  var_1 = _id_0748::_id_C583("enemy_hvt_vehicle_icon", 20);
  _func_0172(var_1, 0);
  _func_017A(var_1, 1);
  _func_016B(var_1, "invisible");
  _func_015D(var_1, "icon_faction_spetsnaz_enemy_small");
  _func_0160(var_1, var_0);
  _func_018B(var_1);
  var_0._id_A882 = var_1;
  var_0 thread _id_7C3C(var_0);
}

_id_7C3C(var_0) {
  var_0 waittill("death");
  _id_0748::_id_5F56("enemy_hvt_vehicle_icon");
}

_id_5E13(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_0 endon("death");
  var_0 endon("end_follow_another_vehicle");

  for(;;) {
    if(_id_1011B(var_0, var_1)) {
      _id_E3F5(var_0, var_2, var_5);
    } else if(_id_1011D(var_0, var_1, var_4)) {
      _id_DDF6(var_0, var_3, var_7);
    } else if(_id_53B9(var_0, var_1, var_8)) {
      _id_E3F5(var_0, var_2, var_6);
    } else {
      _id_DDF6(var_0, var_3, var_7);
    }

    wait 0.1;
  }
}

_id_1011B(var_0, var_1) {
  var_2 = vectornormalize(var_0 _meth_8431());
  var_3 = vectornormalize(var_1.origin - var_0.origin);
  var_4 = vectordot(var_3, var_2);
  return var_4 > 0;
}

_id_E3F5(var_0, var_1, var_2) {
  var_3 = var_0 _meth_842E();
  var_4 = min(var_3 + var_2, var_1);
  var_0 _meth_8438(var_4);
}

_id_DDF6(var_0, var_1, var_2) {
  var_3 = var_0 _meth_842E();
  var_4 = max(var_3 - var_2, var_1);
  var_0 _meth_8438(var_4);
}

_id_53B9(var_0, var_1, var_2) {
  var_3 = _id_634A(var_0, var_1);

  if(var_3 < var_2) {
    return 1;
  } else {
    return 0;
  }
}

_id_634A(var_0, var_1) {
  var_2 = var_0 _meth_8431();
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectornormalize(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectornormalize(var_3);
  var_4 = vectordot(var_2, var_3);
  var_4 = clamp(var_4, -1, 1);
  return _func_0002(var_4);
}

_id_1011D(var_0, var_1, var_2) {
  return distancesquared(var_0.origin, var_1.origin) >= _func_0219(var_2);
}

_id_465B() {
  iprintlnbold("Enemy HVT has escaped!");
  wait 2.5;
  level thread[[level._id_52F7]]("axis", level._id_52A0["kia"]);
}

_id_D40B() {
  level endon("game_ended");

  if(!isDefined(level._id_1676)) {
    level._id_1676 = [];
  }

  if(!isDefined(level._id_0F30)) {
    level._id_0F30 = [];
  }

  if(scripts\engine\utility::_id_5C0C("strike_init_done")) {
    scripts\engine\utility::_id_5C24("strike_init_done");
  }

  if(getdvarint("#x3819aa95b5c0a1ec6", 0) != 0) {
    return;
  }
  _id_0743::_id_C23C("enemy_hvt_boss_spawner", 1, 1, 1, 0.05, 0, "enemy_hvt_boss_spawner", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("start_body_guard", 6, 6, 6, 0.05, 0, "start_bodyguard_spawn", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("start_bodyguard_spawn_cs", 6, 6, 6, 0.05, 0, "start_bodyguard_spawn_cs", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_1", 6, 6, 6, 0.05, 0, "bodyguard_spawn_1", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_2", 12, 12, 12, 0.05, 0, "bodyguard_spawn_2", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_3", 12, 12, 12, 0.05, 0, "bodyguard_spawn_3", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_4", 12, 12, 12, 0.05, 0, "bodyguard_spawn_4", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_5", 12, 12, 12, 0.05, 0, "bodyguard_spawn_5", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_6", 12, 12, 12, 0.05, 0, "bodyguard_spawn_6", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_7", 12, 12, 12, 0.05, 0, "bodyguard_spawn_7", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_8", 12, 12, 12, 0.05, 0, "bodyguard_spawn_8", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_9", 12, 12, 12, 0.05, 0, "bodyguard_spawn_9", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_10", 12, 12, 12, 0.05, 0, "bodyguard_spawn_10", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_11", 12, 12, 12, 0.05, 0, "bodyguard_spawn_11", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_12", 12, 12, 12, 0.05, 0, "bodyguard_spawn_12", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_13", 12, 12, 12, 0.05, 0, "bodyguard_spawn_13", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_14", 12, 12, 12, 0.05, 0, "bodyguard_spawn_14", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_15", 12, 12, 12, 0.05, 0, "bodyguard_spawn_15", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_16", 12, 12, 12, 0.05, 0, "bodyguard_spawn_16", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("bodyguard_spawn_17", 12, 12, 12, 0.05, 0, "bodyguard_spawn_17", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_1", 6, 6, 6, 0.05, 0, "blocker_spawn_1", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_2", 6, 6, 6, 0.05, 0, "blocker_spawn_2", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_3", 6, 6, 6, 0.05, 0, "blocker_spawn_3", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_4", 6, 6, 6, 0.05, 0, "blocker_spawn_4", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_5", 6, 6, 6, 0.05, 0, "blocker_spawn_5", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_6", 6, 6, 6, 0.05, 0, "blocker_spawn_6", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_7", 6, 6, 6, 0.05, 0, "blocker_spawn_7", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_8", 12, 12, 12, 0.05, 0, "blocker_spawn_8", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_9", 12, 12, 12, 0.05, 0, "blocker_spawn_9", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_10", 12, 12, 12, 0.05, 0, "blocker_spawn_10", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_11", 12, 12, 12, 0.05, 0, "blocker_spawn_11", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_12", 12, 12, 12, 0.05, 0, "blocker_spawn_12", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_13", 12, 12, 12, 0.05, 0, "blocker_spawn_13", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C23C("blocker_spawn_14", 12, 12, 12, 0.05, 0, "blocker_spawn_14", ::_id_7DBC, undefined, 10);
  _id_0743::_id_C1F7("enemy_hvt_boss_spawner", ::_id_53B1);
}

_id_7DBC(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0._id_E1C5.size; var_4++) {
    var_5 = var_0._id_E1C5[var_4];
    var_5._id_CDB3 = 20000;
  }
}

_id_53B0() {
  level._id_7BEB = [];
  level thread _id_25E2();

  if(getdvarint("#x376f1ba233fbd7060", 0)) {
    _id_0743::_id_C9FD("start_bodyguard_spawn_cs");
  } else {
    _id_0743::_id_C9FD("start_body_guard");
  }

  var_0 = scripts\engine\utility::getstructarray("bodyguard_spawn_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_0 thread _id_25E1(var_2, "spawn_bodyguard_vehicle");
  }

  for(;;) {
    level waittill("spawn_bodyguard_vehicle", var_4);

    if(_id_AC9A()) {
      continue;
    }
    _id_0743::_id_C9FD(var_4);
  }
}

_id_5389() {
  level._id_2595 = [];
  level thread _id_2593();
  var_0 = scripts\engine\utility::getstructarray("blocker_spawn_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_2592(var_2, "spawn_blocker_vehicle");
  }

  for(;;) {
    level waittill("spawn_blocker_vehicle", var_4);

    if(_id_AC99()) {
      continue;
    }
    _id_0743::_id_C9FD(var_4);
  }
}

_id_53ED() {
  var_0 = scripts\engine\utility::getstructarray("suicide_truck_spawn_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_EAEA(var_2);
  }
}

_id_EAEA(var_0) {
  level endon("game_ended");

  for(;;) {
    if(distance2dsquared(var_0.origin, level._id_B4E2.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  _id_E20C(var_0._id_039B, var_0);
}

_id_E20C(var_0, var_1) {
  var_2 = _func_00E5(var_0, "targetname");
  var_3 = _func_0216("veh8_civ_lnd_techo_rebel_armor", "target_suicide_truck", "vindia", var_2.origin, var_2.angles);
  var_3 _meth_8020(var_2);
  var_3 _meth_83DC();
  var_3 _meth_8438(70, 70, 70);
  var_3 thread _id_EAE6(var_3, var_1);
  var_3 thread _id_EAE5(var_3);
}

_id_EAE5(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0._id_58FA = 500;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;

    if(isPlayer(var_2) && isDefined(var_1)) {
      var_2 _id_071B::_id_FC86("standard", 1, var_1, 0, 0);
      var_0._id_58FA = var_0._id_58FA - var_1;

      if(var_0._id_58FA <= 0) {
        break;
      }
    }
  }

  _id_EAEC(var_0);
}

_id_EAE6(var_0, var_1) {
  var_0 endon("death");
  _id_107B4(var_0, var_1);

  for(;;) {
    if(_id_EAE9(var_0)) {
      _id_EAEC(var_0);
    }

    waitframe();
  }
}

_id_EAEC(var_0) {
  earthquake(0.5, 1.2, var_0.origin, 400);
  playsoundatpos(var_0.origin, "frag_grenade_expl_trans");
  playFX(level._effect["vfx_suicide_truck_explo"], var_0.origin);
  scripts\cp\maps\cp_br_syrk\vehicle_travel::_id_42CE(var_0, 80, 40000);
  scripts\cp\maps\cp_br_syrk\vehicle_travel::_id_42CF(var_0, 22500);
  var_0 delete();
}

_id_EAE9(var_0) {
  if(_id_EAE4(var_0)) {
    return 1;
  }

  if(_id_B4E5(var_0)) {
    return 1;
  }

  return 0;
}

_id_B4E5(var_0) {
  var_1 = level._id_B4E2.origin;

  if(distance2dsquared(var_1, (0, 0, 0)) > 40000) {
    return distance2dsquared(var_0.origin, var_1) < 40000;
  }

  return 0;
}

_id_EAE4(var_0) {
  var_1 = level._id_B4E2.origin;

  if(distance2dsquared(var_1, (0, 0, 0)) > 40000) {
    var_2 = var_0 _meth_8431();
    var_2 = (var_2[0], var_2[1], 0);
    var_2 = vectornormalize(var_2);
    var_3 = var_1 - var_0.origin;
    var_3 = (var_3[0], var_3[1], 0);
    var_3 = vectornormalize(var_3);
    var_4 = vectordot(var_2, var_3);
    return var_4 < 0;
  }

  return 0;
}

_id_AC9A() {
  return level._id_7BEB.size > 0;
}

_id_AC99() {
  return level._id_2595.size > 0;
}

_id_25E1(var_0, var_1) {
  level._id_53B5 endon("death");

  for(;;) {
    if(distance2dsquared(var_0.origin, level._id_53B5.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  level notify(var_1, var_0._id_039B);
}

_id_2592(var_0, var_1) {
  for(;;) {
    if(distance2dsquared(var_0.origin, level._id_B4E2.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  level notify(var_1, var_0._id_039B);
}

_id_25E2() {
  level endon("game_ended");

  for(;;) {
    level waittill("vehicle_spawned", var_0, var_1);

    if(scripts\engine\utility::array_contains(level._id_7BEB, var_1)) {
      continue;
    }
    switch (var_0._id_7218) {
      case "bodyguard_spawn_17":
      case "bodyguard_spawn_16":
      case "bodyguard_spawn_15":
      case "bodyguard_spawn_14":
      case "bodyguard_spawn_13":
      case "bodyguard_spawn_12":
      case "bodyguard_spawn_11":
      case "bodyguard_spawn_10":
      case "bodyguard_spawn_9":
      case "bodyguard_spawn_8":
      case "bodyguard_spawn_7":
      case "bodyguard_spawn_6":
      case "bodyguard_spawn_5":
      case "bodyguard_spawn_4":
      case "bodyguard_spawn_3":
      case "bodyguard_spawn_2":
      case "bodyguard_spawn_1":
      case "start_body_guard":
        var_1 thread _id_25E3(var_1);
    }
  }
}

_id_2593() {
  level endon("game_ended");

  for(;;) {
    level waittill("vehicle_spawned", var_0, var_1);

    if(scripts\engine\utility::array_contains(level._id_2595, var_1)) {
      continue;
    }
    switch (var_0._id_7218) {
      case "blocker_spawn_14":
      case "blocker_spawn_13":
      case "blocker_spawn_12":
      case "blocker_spawn_11":
      case "blocker_spawn_10":
      case "blocker_spawn_9":
      case "blocker_spawn_8":
      case "blocker_spawn_7":
      case "blocker_spawn_6":
      case "blocker_spawn_5":
      case "blocker_spawn_4":
      case "blocker_spawn_3":
      case "blocker_spawn_2":
      case "blocker_spawn_1":
        var_1 thread _id_2594(var_1);
    }
  }
}

_id_25E3(var_0) {
  var_0 endon("death");
  _id_103E(var_0);
  var_0 thread _id_25DF(var_0);
  var_0 thread _id_53FD(var_0, 5000);
  wait 1.5;
  _id_33CC(var_0);
  var_0 notify("stop_vehicle_on_damage_internal");
  var_0 notify("stop_waiting_for_spawns");
  var_0 thread _id_5E15(var_0);
  var_0 thread _id_53FF(var_0);
}

_id_2594(var_0) {
  var_0 endon("death");
  _id_1030(var_0);
  var_0 thread _id_2591(var_0);
  var_0 thread _id_53FD(var_0, 5000);
  wait 1.5;
  _id_33CC(var_0);
  var_0 notify("stop_vehicle_on_damage_internal");
  var_0 notify("stop_waiting_for_spawns");
  var_0 thread _id_53FF(var_0);
  var_0 thread _id_E777(var_0);
}

_id_33CC(var_0) {
  foreach(var_2 in var_0._id_C835) {
    var_2 scripts\common\utility::_id_47A7("combat");
  }
}

_id_53FD(var_0, var_1) {
  var_0 endon("death");
  var_0.health = 999999;
  var_0._id_58FA = var_1;

  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(isDefined(var_2)) {
      var_0._id_58FA = var_0._id_58FA - var_2;

      if(var_0._id_58FA < 0) {
        var_0 _id_53FE(var_0);
      }
    }
  }
}

_id_53FF(var_0) {
  var_0 endon("death");
  var_0 endon("vehicle_has_unload");

  foreach(var_2 in var_0._id_C835) {
    var_2 thread _id_C833(var_2, var_0);
  }

  for(;;) {
    var_0 waittill("a_rider_just_died");
    var_4 = _id_65FB(var_0);

    if(var_4 == 0) {
      var_0 _id_53FE(var_0);
    }
  }
}

_id_65FB(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0._id_C835) {
    if(isai(var_3) && isalive(var_3)) {
      var_1++;
    }
  }

  return var_1;
}

_id_C833(var_0, var_1) {
  var_0 waittill("death");
  var_1 notify("a_rider_just_died");
}

_id_53FE(var_0) {
  foreach(var_2 in var_0._id_C835) {
    if(isai(var_2) && isalive(var_2)) {
      var_2 unlink();
      var_3 = vectornormalize(var_2.origin - var_0.origin);
      var_2 setvelocity(var_3 * 1200);
      var_2 dodamage(var_2.health + 100, var_2.origin);
    }
  }

  playFX(level._effect["bodyguard_vehicle_explosion"], var_0.origin + (0, 0, 20));
  var_0 delete();
}

_id_5E15(var_0) {
  var_0 endon("death");
  level._id_53B5 endon("death");

  if(!isDefined(level._id_53B5)) {
    return;
  }
  var_1 = level._id_53B5;
  var_0 _meth_8438(65, 65, 65);

  for(;;) {
    if(_id_1011D(var_0, var_1, 1300)) {
      _id_E3F5(var_0, 65, 1);
    } else if(_id_7BEA(var_0, var_1)) {
      _id_E3F5(var_0, 65, 1);
    } else {
      _id_DDF6(var_0, 25, 4);
    }

    waitframe();
  }
}

_id_E777(var_0) {
  var_0 endon("death");
  var_0 _meth_8438(75, 75, 75);
  _id_107B4(var_0, scripts\engine\utility::getstruct(var_0._id_71F4._id_7218 + "_target", "targetname"));

  for(;;) {
    if(_id_6DED(var_0, level._id_B4E2)) {
      _id_E3F5(var_0, 75, 2.5);
    } else {
      _id_DDF6(var_0, 0, 1);
    }

    waitframe();
  }
}

_id_4696(var_0) {
  wait 5;
  _id_53FE(var_0);
}

_id_107B4(var_0, var_1) {
  for(;;) {
    if(distance2dsquared(var_0.origin, var_1.origin) < 90000) {
      return;
    }
    waitframe();
  }
}

_id_6DED(var_0, var_1) {
  return distance2dsquared(var_0.origin, var_1.origin) < 2250000;
}

_id_7BEA(var_0, var_1) {
  if(_id_F335(var_0)) {
    return 0;
  }

  var_2 = var_0 _meth_8431();
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectornormalize(var_2);
  var_3 = var_1.origin - var_0.origin;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectornormalize(var_3);
  var_4 = vectordot(var_2, var_3);
  var_5 = _func_0002(var_4);

  if(var_5 < _id_6442(var_0)) {
    return 1;
  } else {
    return 0;
  }
}

_id_F335(var_0) {
  var_1 = _id_6623(var_0);

  foreach(var_3 in var_1) {
    if(distance2dsquared(var_0.origin, var_3.origin) <= 250000) {
      return 1;
    }
  }

  return 0;
}

_id_6623(var_0) {
  var_1 = [];
  var_2 = var_0 _meth_8431();

  foreach(var_4 in level._id_7BEB) {
    if(var_4 == var_0) {
      continue;
    }
    var_5 = var_4.origin - var_0.origin;

    if(vectordot(var_5, var_2) < 0) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_F334(var_0) {
  var_1 = _id_6622(var_0);

  foreach(var_3 in var_1) {
    if(distance2dsquared(var_0.origin, var_3.origin) <= 250000) {
      return 1;
    }
  }

  return 0;
}

_id_6622(var_0) {
  var_1 = [];
  var_2 = var_0 _meth_8431();

  foreach(var_4 in level._id_2595) {
    if(var_4 == var_0) {
      continue;
    }
    var_5 = var_4.origin - var_0.origin;

    if(vectordot(var_5, var_2) < 0) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_6442(var_0) {
  switch (level._id_7BEB.size) {
    case 1:
      return 90;
    case 2:
      switch (var_0._id_25E0) {
        case 1:
          return 135;
        case 2:
          return 90;
      }
    case 3:
      switch (var_0._id_25E0) {
        case 1:
          return 150;
        case 2:
          return 90;
        case 3:
          return 30;
      }
  }
}

_id_1030(var_0) {
  level._id_2595 = scripts\engine\utility::array_add(level._id_2595, var_0);
}

_id_103E(var_0) {
  level._id_7BEB = scripts\engine\utility::array_add(level._id_7BEB, var_0);
  var_0._id_25E0 = level._id_7BEB.size;
}

_id_25DF(var_0) {
  var_0 waittill("death");
  var_1 = var_0._id_25E0;
  level._id_7BEB = scripts\engine\utility::array_remove(level._id_7BEB, var_0);
  _id_C0CB(var_1);
}

_id_2591(var_0) {
  var_0 waittill("death");
  level._id_2595 = scripts\engine\utility::array_remove(level._id_2595, var_0);
}

_id_C0CB(var_0) {
  foreach(var_2 in level._id_7BEB) {
    if(var_2._id_25E0 > var_0) {
      var_2._id_25E0--;
    }
  }
}

_id_53B6(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 999999;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 999999;
  }
}

_id_47CB() {
  var_0 = scripts\engine\utility::getstructarray("concrete_blocker_controlling_struct", "script_noteworthy");

  foreach(var_2 in var_0) {
    _id_BD42(var_2);
    waitframe();
  }
}

_id_BD42(var_0) {
  _id_BD52(var_0);
  _id_D405(var_0);
  _id_D40E(var_0);
}

_id_BD52(var_0) {
  var_0._id_A756 = int(var_0._id_CE18);
  var_1 = [];
  var_2 = [];
  var_3 = scripts\engine\utility::getstructarray(var_0.target, "targetname");

  foreach(var_5 in var_3) {
    switch (var_5._id_039B) {
      case "concrete_blocker_marker":
        var_1[var_1.size] = var_5;
        break;
      case "sight_blocker_marker":
        var_2[var_2.size] = var_5;
        break;
    }
  }

  var_0._id_3B59 = var_1;
  var_0._id_DD30 = var_2;
}

_id_D405(var_0) {
  var_1 = var_0._id_3B59;

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_1 = scripts\engine\utility::array_randomize(var_1);
  }

  var_3 = var_0._id_A756;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_1[var_4];
    var_6 = spawn("script_model", var_5.origin);
    var_6 setModel("barrier_traffic_concrete_block_01");
    var_6.angles = var_5.angles;
  }
}

_id_D40E(var_0) {
  var_1 = [];

  foreach(var_3 in var_0._id_DD30) {
    var_4 = spawn("script_model", var_3.origin);
    var_4 setModel("fence_corrugated_metal_03_256_cp");
    var_4.angles = var_3.angles;
    var_1[var_1.size] = var_4;
  }

  var_0._id_DD31 = var_1;
}

_id_53B1(var_0) {
  var_1 = self;
  var_1.health = 9999;
  var_1.maxhealth = 9999;
  var_1._id_0181 = 1;
  var_1._id_852E = 1;
  var_1 scripts\engine\utility::_id_5473("stop_combat");
  var_1 thread _id_4656(var_1);
  var_1 thread _id_7BEE(var_1);
  var_1 thread _id_7BED(var_1);
  var_2 = spawn("script_model", var_1 gettagorigin("tag_eye"));
  var_2 setModel("tag_origin");
  var_2.angles = var_1 getplayerangles();
  var_2 linkto(var_1);
  var_1._id_7BF0 = var_2;
  var_3 = spawn("script_model", var_1.origin);
  var_3 setModel("tag_origin");
  var_3.angles = var_1 getplayerangles();
  var_1._id_7BF2 = var_3;
  var_1 linkto(var_3, "tag_origin");
  var_3 thread _id_7BF4(var_3);
  var_3 thread _id_7BF3(var_3);
  var_1 thread _id_7BEC(var_1);
}

_id_4656(var_0) {
  var_0 endon("death");
  waitframe();
  var_0 scripts\common\utility::_id_47A7("casual");
  var_0 _meth_800D("crouch");
}

_id_7BF4(var_0) {
  var_0 endon("death");
  level._id_53B5 endon("death");
  var_1 = level._id_53B5;
  var_0._id_53B3 = -71;

  for(;;) {
    var_2 = var_1 gettagorigin("tag_turret");
    var_3 = var_1 _meth_8431();
    var_3 = (var_3[0], var_3[1], 0);
    var_3 = var_3 * 0.05;
    var_0.origin = var_2 + (0, 0, var_0._id_53B3) + var_3;
    waitframe();
  }
}

_id_7BED(var_0) {
  var_0 endon("death");
  wait(randomfloatrange(7, 15));
  _id_7BEF(var_0);
  scripts\engine\utility::_id_5C24("hvt_boss_combat_stage_two");
  _id_7BEF(var_0);
  scripts\engine\utility::_id_5C24("hvt_boss_combat_stage_three");
  _id_7BEF(var_0);
  level thread _id_B212();
  var_0._id_852E = 0;
  var_0 dodamage(var_0.health + 100, var_0.origin);
}

_id_B212() {
  _id_53B8();
  level thread _id_3D20();
}

_id_4687() {
  wait 10;
  scripts\engine\utility::_id_5C1B("hvt_boss_combat_stage_two");
  iprintlnbold("stage_two");
}

_id_4686() {
  wait 10;
  scripts\engine\utility::_id_5C1B("hvt_boss_combat_stage_three");
  iprintlnbold("stage_three");
}

_id_7BEF(var_0) {
  var_0 scripts\engine\utility::_id_5470("stop_combat");

  for(;;) {
    if(_id_B4E3()) {
      _id_7BF1(var_0, -45);
      var_0._id_852E = 0;
      var_0 scripts\common\utility::_id_47A7("combat");
      var_0 waittill("exposed_stand_to_crouch_finished");
      _id_7BF1(var_0, -25);

      if(isDefined(level._id_53B5._id_42DA) && level._id_53B5._id_42DA == 3) {
        return;
      }
      wait 1;

      if(!var_0 scripts\engine\utility::_id_546E("stop_combat")) {
        var_1 = level._id_53B5;
        var_2 = var_1 _meth_8431();
        var_2 = (var_2[0], var_2[1], 0);
        var_2 = var_2 * 0.95;
        var_3 = anglesToForward(var_0 getplayerangles());
        var_4 = var_0 gettagorigin("j_wrist_le") + var_3 * 20 + var_2;
        var_5 = level._id_B4E2 _meth_8431();
        var_6 = anglesToForward(level._id_B4E2.angles);
        var_7 = level._id_B4E2.origin + (0, 0, 40) + var_6 * var_1._id_B4E4 * 25;
        var_8 = _func_0143("rpg_missile_cp", var_4, var_7);
        var_8 thread _id_4676(var_8);
      }

      var_0._id_852E = 1;

      if(isDefined(level._id_53B5._id_42DA) && level._id_53B5._id_42DA == 3) {
        return;
      }
      var_0 scripts\common\utility::_id_47A7("casual");
      _id_7BF1(var_0, -71);
      wait(randomfloatrange(3, 6));

      if(var_0 scripts\engine\utility::_id_546E("stop_combat")) {
        return;
      }
    }

    wait(randomfloatrange(0.5, 1));

    if(var_0 scripts\engine\utility::_id_546E("stop_combat")) {
      return;
    }
  }
}

_id_4C0C(var_0) {
  var_1 = int(60);

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = var_0 gettagorigin("tag_eye");
    var_4 = level._id_B4E2 _meth_8431();
    var_5 = level._id_B4E2.origin + (0, 0, 80) + var_4 * 0.01;
    var_6 = var_5 - var_3;
    var_7 = vectortoangles(var_6);
    _func_0313(level._effect["hvt_target_laser"], var_3, var_7, var_5);
    var_8 = var_0 scripts\engine\utility::_id_108A7(0.05, "damage");

    if(var_8 == "damage") {
      return "fail";
    }
  }

  return "success";
}

_id_67AE(var_0) {
  var_1 = var_0 gettagorigin("tag_eye");
  var_2 = level._id_B4E2.origin + (0, 0, 50);
  var_3 = var_2 - var_1;
  return vectortoangles(var_3);
}

_id_EC2C(var_0) {
  var_1 = var_0.origin;
  var_0 delete();
  var_2 = level._id_53B5;
  var_3 = var_2 _meth_8431();
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = var_3 * 0.95;
  var_1 = var_1 + var_3;
  var_4 = level._id_B4E2;
  var_5 = _func_0143("juliet_missile_cp", var_1, var_4.origin);
  var_5 missile_settargetent(var_4);
  var_5 _meth_8232();
  var_5 thread _id_4676(var_5);
}

_id_4676(var_0) {
  var_0 endon("death");
  wait 0.1;
  playFXOnTag(level._effect["javelin_ignition"], var_0, "tag_fx");
}

_id_7BF1(var_0, var_1) {
  var_2 = var_1 - var_0._id_7BF2._id_53B3;
  var_3 = abs(var_2) / 1;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(var_1 >= var_0._id_7BF2._id_53B3) {
      var_0._id_7BF2._id_53B3 = var_0._id_7BF2._id_53B3 + 1;
    } else {
      var_0._id_7BF2._id_53B3 = var_0._id_7BF2._id_53B3 - 1;
    }

    waitframe();
  }
}

_id_B4E3() {
  var_0 = level._id_53B5;
  var_1 = level._id_B4E2;

  if(distance2dsquared(level._id_B4E2.origin, (0, 0, 0)) < 40000) {
    return 0;
  }

  return distance2dsquared(var_0.origin, var_1.origin) < 25000000;
}

_id_7BF3(var_0) {
  var_0 endon("death");

  for(;;) {
    var_1 = level._id_B4E2.origin - var_0.origin;
    var_1 = (var_1[0], var_1[1], 0);
    var_1 = vectornormalize(var_1);
    var_0.angles = vectortoangles(var_1);
    waitframe();
  }
}

_id_7BEC(var_0) {
  var_0 waittill("death");

  if(isDefined(var_0._id_7BF2)) {
    var_0._id_7BF2 delete();
  }

  if(isDefined(var_0._id_7BF0)) {
    var_0._id_7BF0 delete();
  }
}

_id_7BEE(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 9999;
    var_0.maxhealth = 9999;

    if(istrue(var_0._id_852E)) {
      continue;
    }
    var_11 = _id_6376(var_2);

    if(isDefined(var_11)) {
      var_0._id_852E = 1;
      playsoundatpos(var_0.origin, "frag_grenade_expl_trans");
      playFX(level._effect["hvt_boss_rpg_explosion"], var_0.origin);
      _id_53B7();
      var_0 scripts\engine\utility::_id_5474("stop_combat");
      var_11 thread _id_469E(var_11);
    }
  }
}

_id_6376(var_0) {
  if(isPlayer(var_0)) {
    return var_0;
  }

  if(isPlayer(var_0.owner)) {
    return var_0.owner;
  }

  return undefined;
}

_id_469E(var_0) {
  var_0 endon("disconnect");
  waittillframeend;

  if(isDefined(level._id_53B5._id_42DA) && level._id_53B5._id_42DA == 3) {
    var_0 thread _id_071B::_id_FC47("hitcritical", 1);
  } else {
    var_0 thread _id_071B::_id_FC47("standard");
  }
}

_id_53B7() {
  if(!isDefined(level._id_53B5._id_42DA)) {
    level._id_53B5._id_42DA = 0;
  }

  level._id_53B5._id_42DA++;

  switch (level._id_53B5._id_42DA) {
    case 1:
      level._id_53B5 thread _id_982B();
      break;
    case 2:
      _id_B2D3();
      _id_B2D4();
      break;
    default:
      break;
  }
}

_id_982B() {
  level._id_53B5 endon("death");
  var_0 = ["tag_wheel_center_front_left", "tag_wheel_center_middle_left", "tag_wheel_center_back_left", "tag_wheel_center_front_right", "tag_wheel_center_middle_right", "tag_wheel_center_back_right", "rear_hatch_jnt", "drivers_hatch_jnt"];

  for(;;) {
    var_1 = scripts\engine\utility::random(var_0);
    playFXOnTag(level._effect["hvt_vehicle_armor_explosion"], level._id_53B5, var_1);
    wait(randomfloatrange(0.15, 0.35));
  }
}

_id_F3E5(var_0) {
  var_0 endon("death");
  var_1 = level._id_B4E2;
  var_2 = var_1.origin;

  for(;;) {
    waitframe();
    var_3 = var_1.origin;
    var_4 = length(var_3 - var_2);
    var_0._id_B4E4 = var_4;
    var_2 = var_3;
  }
}

_id_E5BE(var_0) {
  level._id_53B5 endon("death");
  var_1 = scripts\engine\utility::getstructarray("hvt_boss_combat_marker", "targetname");

  foreach(var_3 in var_1) {
    var_3 thread _id_7BF6(var_3);
  }
}

_id_7BF6(var_0) {
  level._id_53B5 endon("death");

  for(;;) {
    if(distance2dsquared(var_0.origin, level._id_53B5.origin) < 2250000) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::_id_5C1B(var_0._id_039B);
}

_id_9610() {
  level._effect["bodyguard_vehicle_explosion"] = loadfx("vfx/iw8/prop/scriptables/vfx_veh_explosion_civ.vfx");
  level._effect["hvt_vehicle_armor_explosion"] = loadfx("vfx/core/expl/electrical_transformer_sparks_a.vfx");
  level._effect["hvt_vehicle_armor_disabled"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_secondary_omni.vfx");
  level._effect["hvt_vehicle_tire_damage_smoke_left"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_runner.vfx");
  level._effect["hvt_vehicle_tire_damage_smoke_right"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_runner_right_side.vfx");
  level._effect["hvt_vehicle_hood_damage_smoke"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood.vfx");
  level._effect["hvt_vehicle_explosion"] = loadfx("vfx/iw8/level/highway/vfx_suicide_truck_explosion.vfx");
  level._effect["vfx_suicide_truck_explo"] = loadfx("vfx/iw8/level/highway/vfx_suicide_truck_explosion.vfx");
  level._effect["sight_blocker_explosion"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_explo_suicide_bomb.vfx");
  level._effect["hvt_boss_rpg_explosion"] = loadfx("vfx/iw8/weap/_explo/rpg/vfx_explo_rpg.vfx");
  level._effect["javelin_ignition"] = loadfx("vfx/iw8_mp/muzflash/vfx_smoke_javelin_ignition.vfx");
  level._effect["hvt_target_laser"] = loadfx("vfx/iw8_cp/coop_vehicle_race/vfx_enemy_hvt_laser_pointer.vfx");
  level._effect["hvt_target_laser_static"] = loadfx("vfx/iw8_cp/coop_vehicle_race/vfx_enemy_hvt_laser_pointer_static.vfx");
}