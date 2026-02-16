/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_br_syrk\vehicle_travel.gsc
*********************************************************/

init() {
  _id_8100();
  _id_95BB();
  level thread _id_7A70();
  level thread _id_10A45();
  level._id_10117 = [];
  level._id_F94A = [];
  level._id_9B30 = [];
  level._id_9B2E = [];
  level._id_C4BC = ::_id_C3D2;
  _id_C22E("driver", &"CP_VEHICLE_TRAVEL/DRIVER", ::_id_F720, ::_id_E5CF, ::_id_5743, "+stance", 200, 90, 72, 90, "duration_short", 1);
  _id_C22E("passenger", &"CP_VEHICLE_TRAVEL/ENTER", undefined, ::_id_54B5, ::_id_575E, "+stance", 200, 90, 72, 90, "duration_short", 1);
  _id_C22E("left_back_seat", &"CP_VEHICLE_TRAVEL/ENTER", undefined, ::_id_54A8, ::_id_5751, "+stance", 200, 90, 72, 90, "duration_short", 1);
  _id_C22E("right_back_seat", &"CP_VEHICLE_TRAVEL/ENTER", undefined, ::_id_54C0, ::_id_5766, "+stance", 200, 90, 72, 90, "duration_short", 1);
  _id_C22E("gunner", &"CP_VEHICLE_TRAVEL/GUNNER", undefined, ::_id_54A2, ::_id_574B, "+stance", 100, 360, 64, 360, "duration_short", 1);
  _id_C22E("grenadier", &"CP_VEHICLE_TRAVEL/GRENADIER", undefined, ::_id_54A1, ::_id_5749, "+stance", 100, 90, 64, 90, "duration_short", 1);
  _id_C22E("overwatch_right", &"CP_VEHICLE_TRAVEL/OVERWATCH", undefined, ::_id_54BA, ::_id_5762, "+stance", 30, 90, 30, 65, "duration_short", 1);
  _id_C22E("overwatch_left", &"CP_VEHICLE_TRAVEL/OVERWATCH", undefined, ::_id_54B9, ::_id_5762, "+stance", 30, 90, 30, 65, "duration_short", 1);
  _id_C22E("missile_defense_right", &"CP_VEHICLE_TRAVEL/MISSILE_DEFENSE", undefined, ::_id_54AF, ::_id_5755, "+stance", 20, 90, 20, 40, "duration_short", 1);
  _id_C22E("missile_defense_left", &"CP_VEHICLE_TRAVEL/MISSILE_DEFENSE", undefined, ::_id_54AE, ::_id_5755, "+stance", 20, 90, 20, 40, "duration_short", 1);
  _id_C22E("back_left_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, ::_id_54BD, ::_id_5764, undefined, 200, 90, 72, 90, "duration_none", 0);
  _id_C22E("back_right_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, ::_id_54BD, ::_id_5764, undefined, 200, 90, 72, 90, "duration_none", 0);
  _id_C22E("front_left_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, ::_id_54BD, ::_id_5764, undefined, 200, 90, 72, 90, "duration_none", 0);
  _id_C22E("front_right_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, ::_id_54BD, ::_id_5764, undefined, 200, 90, 72, 90, "duration_none", 0);
  _id_C22E("hood_repair", &"CP_VEHICLE_TRAVEL/REPAIR", undefined, ::_id_54A5, ::_id_574C, undefined, 200, 90, 72, 90, "duration_none", 0);
  _id_C22E("change_loadout", &"CP_VEHICLE_TRAVEL/CHANGE_LOADOUT", undefined, ::_id_5493, ::_id_573B, undefined, 200, 45, 72, 45, "duration_short", 1);
  _id_C22E("front_refill_ammo", &"CP_VEHICLE_TRAVEL/REFILL_AMMO", undefined, ::_id_54BC, undefined, undefined, 35, 45, 30, 45, "duration_medium", 1);
  _id_C22E("back_right_refill_ammo", &"CP_VEHICLE_TRAVEL/REFILL_AMMO", undefined, ::_id_54BC, undefined, undefined, 20, 15, 20, 15, "duration_medium", 1);
  _id_C22E("back_left_refill_ammo", &"CP_VEHICLE_TRAVEL/REFILL_AMMO", undefined, ::_id_54BC, undefined, undefined, 20, 15, 20, 15, "duration_medium", 1);
  _id_C22E("retrieve_hostage", &"CP_VEHICLE_TRAVEL/RETRIEVE_HOSTAGE", undefined, ::_id_54BE, ::_id_5765, undefined, 200, 90, 72, 90, "duration_short", 0);
}

_id_47DB(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_2 = _func_0216(var_1.model, "armoredtruck", var_1._id_100AF, var_0.origin, var_0.angles);
  var_2 _meth_8220("allies", 0);
  _id_BD51(var_2, var_0);
  _id_80FC(var_2, var_1);
  var_2._id_3E2D = "armoredtruck";
  _id_D406(var_2);
  _id_D412(var_2, var_1);
  _id_D409(var_2, var_1);
  _id_0F8E(var_2, var_1);
  _id_105E(var_2);
  _id_99B7(var_2);
  var_2 thread _id_1005E(var_2, var_1);
  var_2 thread _id_F4FB(var_2);
  var_2 thread _id_4488();
  var_2 thread _id_102C8(var_2);
  var_2 thread _id_102C9(var_2);
  level._id_B4E2 = var_2;
  level notify("spawned_player_car");
  var_2._id_A3DC = _func_02AC("ply_vehicle", 0, var_2, 128, 1);
}

_id_47D1(var_0, var_1) {
  var_2 = _func_0216(var_1.model, "friendlyhvi", var_1._id_100AF, var_0.origin, var_0.angles);
  _id_BD51(var_2, var_0);
  _id_80FC(var_2, var_1);
  _id_D406(var_2);
  _id_D412(var_2, var_1);
  _id_D409(var_2, var_1);
  _id_0F8E(var_2, var_1);
  var_2 thread _id_F4FB(var_2);
  _id_4A66(var_2, "driver");
  _id_4A66(var_2, "passenger");
  _id_4A66(var_2, "right_back_seat");
  return var_2;
}

_id_BD51(var_0, var_1) {
  var_2 = getEntArray(var_1.target, "targetname");

  foreach(var_4 in var_2) {
    switch (var_4._id_039B) {
      case "no_sight_clip":
        var_4 linkto(var_0);
        var_4 thread _id_10138(var_0, var_4);
        break;
      case "under_vehicle_trigger":
        var_4 _meth_80DB();
        var_4 linkto(var_0);
        var_4 thread _id_10138(var_0, var_4);
        var_0._id_F93C = var_4;
        break;
      default:
    }
  }
}

_id_10138(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");
  var_1 delete();
}

_id_F025(var_0) {
  if(isDefined(level._id_B4E2)) {
    if(level._id_B4E2 _meth_8434()) {
      var_1 = _func_02AB(var_0.origin);
      var_2 = (0, var_0.angles[1], 0);
      level._id_B4E2 _meth_8439(var_1, var_2);
    }
  }
}

_id_5493(var_0, var_1, var_2) {
  var_1 notify("enter_change_loadout");
  var_1 setclientomnvar("ui_options_menu", 2);
  waitframe();

  for(;;) {
    var_1 waittill("luinotifyserver", var_3, var_4);

    if(var_3 == "class_select" || var_3 == "class_edit" || var_3 == "class_menu_closed") {
      _id_5234(var_2, "change_loadout");
      break;
    }
  }

  var_0 notify("interaction_point_disabled");
}

_id_573B(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_change_loadout");
}

_id_54BC(var_0, var_1, var_2) {
  var_1 thread _id_0704::_id_EB7F();
  waitframe();
  var_0 notify("interaction_point_disabled");
  waitframe();
  var_0 makeuseable();
  var_0._id_24C3 = 0;
}

_id_F720(var_0, var_1) {
  _id_FB5F(var_0);

  if(istrue(var_0._id_4A88)) {
    level thread scripts\cp\utility::_id_3E09(&"CP_BR_SYRK_GL_DIALOGUE/REPAIR_VEHICLE");
    return 0;
  }

  if(isDefined(level._id_F721)) {
    return [[level._id_F721]]();
  } else {
    return 1;
  }
}

_id_E5CF(var_0, var_1, var_2) {
  level notify("player_entered_driver_seat");
  var_1._id_4A23 = 1;
  _id_54CA(var_1, var_2);
  var_1._id_41A7 = "driver";
  var_1._id_7D46 = 1;
  var_1 _id_54C2(var_1, "driver");
  var_1 setclientomnvar("ui_veh_controls", 1);
  var_1 scripts\common\utility::_id_158D(0);
  var_1 setplayerangles(var_2.angles);
  var_1 _meth_8094(var_2);
  var_1 scripts\common\utility::_id_158A(0);
  var_2 setotherent(var_1);
  var_2 setentityowner(var_1);
  _id_B2B9(var_1, var_2, "driver");
}

_id_5743(var_0, var_1, var_2, var_3) {
  var_2 setotherent(undefined);
  var_2 setentityowner(undefined);
  var_1._id_7D46 = undefined;
  var_1 _id_F010();
  var_1 scripts\common\utility::_id_158D(1);
  var_1 _meth_8095();
  var_1 unlink();
  var_1 _id_576F(var_1, var_2, "driver");
  var_1 _id_576A(var_1, "driver", var_2);
  var_1 setclientomnvar("ui_veh_controls", 0);
  var_1._id_4A23 = undefined;
  var_1 scripts\common\utility::_id_158A(1);
}

_id_54BD(var_0, var_1, var_2) {
  var_3 = _id_4C2D(var_2, var_1, var_0._id_C54B);

  if(!var_3) {
    var_0 makeuseable();
    var_0._id_24C3 = 0;
    return;
  }

  waitframe();
  var_0 notify("interaction_point_disabled");
  _id_C3E1(var_2, var_0, var_0._id_C54B);
}

_id_5764(var_0, var_1, var_2, var_3) {
  if(_id_1476(var_2)) {
    var_2._id_4A88 = 0;
    _id_D388("hood_repair", 0);
    _id_FB5F(var_2);
    level notify("vehicle_repaired");
  }
}

_id_54BE(var_0, var_1, var_2) {
  waitframe();

  if(!isDefined(var_1._id_7A89) && !_id_74F6(var_2)) {
    return;
  }
  var_0 notify("interaction_point_disabled");
}

_id_5765(var_0, var_1, var_2, var_3) {
  if(isPlayer(var_1) && !isDefined(var_1._id_7A89) && !_id_74F6(var_2)) {
    return;
  }
  if(!_id_74F6(var_2)) {
    return;
  }
  var_4 = var_2._id_7A40;
  var_4 unlink();
  var_2._id_7A40 = undefined;

  if(isPlayer(var_1)) {
    var_4 notify("trigger", var_1);
  } else {
    var_4.origin = var_1.origin;
    _id_4A66(var_2, "retrieve_hostage");
    var_4._id_32BA = 0;
  }

  var_4 notify("trigger", var_1);
}

_id_54A5(var_0, var_1, var_2) {
  var_2 thread _id_102A1(var_2);
  var_3 = _id_4C00(var_2, var_1, "tag_grill", var_0);
  var_2 notify("hood_repair_finished");

  if(!var_3) {
    var_0 makeuseable();
    var_0._id_24C3 = 0;
    return;
  }

  waitframe();
  var_0 notify("interaction_point_disabled");
  _id_C3E1(var_2, var_0);
}

_id_102A1(var_0) {
  var_0 endon("death");
  var_0 endon("hood_repair_finished");
  var_1 = var_0.origin;
  var_2 = var_0.angles;

  for(;;) {
    var_0 _meth_8439(var_1, var_2);
    waitframe();
  }
}

_id_574C(var_0, var_1, var_2, var_3) {
  if(_id_1476(var_2)) {
    var_2._id_4A88 = 0;
    var_2._id_58FA = var_2._id_9C1D;
    var_2._id_DCB6 = 0;
    var_2._id_4A8A = 0;
    _id_D388("hood_repair", 0);
    _id_FB5F(var_2);
    level notify("vehicle_repaired");
  }
}

_id_54B5(var_0, var_1, var_2) {
  _id_54CA(var_1, var_2);
  _id_54C1(var_1, var_2, "passenger");
}

_id_575E(var_0, var_1, var_2, var_3) {
  _id_5767(var_1, 1);
  _id_F70C(var_1, var_2, "passenger");
}

_id_54A8(var_0, var_1, var_2) {
  _id_54CA(var_1, var_2);
  _id_54C1(var_1, var_2, "left_back_seat");
}

_id_5751(var_0, var_1, var_2, var_3) {
  _id_5767(var_1, 1);
  _id_F70C(var_1, var_2, "left_back_seat");
}

_id_54C0(var_0, var_1, var_2) {
  _id_54CA(var_1, var_2);
  _id_54C1(var_1, var_2, "right_back_seat");
}

_id_5766(var_0, var_1, var_2, var_3) {
  _id_5767(var_1, 1);
  _id_F70C(var_1, var_2, "right_back_seat");
}

_id_54A2(var_0, var_1, var_2) {
  level notify("player_used_vehicle_gunner_turret");
  var_1 unlink();
  var_1 _meth_846C(undefined);
  var_1._id_4A23 = 1;
  _id_5768(var_1, var_2);
  _id_C13E(var_1, "gunner");
  var_1 _id_54C2(var_1, "gunner");
  var_1 setplayerangles(var_2._id_72BD.angles);
  var_1 thread _id_6EF0(var_0, var_1, var_2);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
}

_id_6EF0(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("exit_gunner_seat");
  var_1._id_BB49 = var_1 getcurrentweapon();
  var_1 scripts\cp\utility::_giveweapon(var_2._id_72BE, undefined, undefined, 1);

  while(var_1 _id_0777::_id_EC3F(var_2._id_72BE, 1) == 0) {
    waitframe();
  }

  var_2._id_72BD setotherent(var_1);
  var_2._id_72BD setentityowner(var_1);
  var_2._id_72BD setsentryowner(var_1);
  var_2._id_72BD.owner = var_1;
  var_1 _meth_80AF();
  var_1 controlturreton(var_2._id_72BD);
}

_id_574B(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_gunner_seat");
  var_1 takeweapon(var_2._id_72BE);
  var_1 switchtoweapon(var_1._id_BB49);
  var_1 _meth_80E2();
  var_1 _meth_8292(var_2._id_72BD);
  var_1 unlink();
  var_2._id_72BD setotherent(undefined);
  var_2._id_72BD setentityowner(undefined);
  var_2._id_72BD setsentryowner(undefined);
  _id_5234(var_2, "gunner");
  var_1._id_4A23 = undefined;

  if(var_3 == "last_stand" || var_3 == "force_player_exit_vehicle") {
    _id_5767(var_1, 1);
    _id_576F(var_1, var_2, var_1._id_BC33);
    var_1 _id_576A(var_1, "gunner", var_2);
  } else {
    _id_C785(var_1, var_2);
    var_1 _id_576A(var_1, "gunner", var_2);
  }
}

_id_54A1(var_0, var_1, var_2) {
  var_1 unlink();
  var_1 _meth_846C(undefined);
  var_1._id_4A23 = 1;
  _id_5768(var_1, var_2);
  waitframe();
  _id_C13E(var_1, "grenadier");
  var_1 _id_54C2(var_1, "grenadier");
  var_1 setplayerangles(var_2.angles);
  var_1 playerlinktodelta(var_2._id_7187, "tag_origin", 0, 180, 180, 180, 25);
  var_1 thread _id_6EEF(var_0, var_1, var_2);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
}

_id_6EEF(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("exit_grenadier_seat");
  var_1._id_BB49 = var_1 getcurrentweapon();
  var_1 scripts\cp\utility::_giveweapon(var_2._id_7188, undefined, undefined, 1);

  while(var_1 _id_0777::_id_EC3F(var_2._id_7188, 1) == 0) {
    waitframe();
  }
}

_id_5749(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_grenadier_seat");
  var_1 takeweapon(var_2._id_7188);
  var_1 switchtoweapon(var_1._id_BB49);
  var_1 unlink();
  _id_5234(var_2, "grenadier");
  var_1._id_4A23 = undefined;

  if(var_3 == "last_stand" || var_3 == "force_player_exit_vehicle") {
    _id_5767(var_1, 1);
    _id_576F(var_1, var_2, var_1._id_BC33);
    var_1 _id_576A(var_1, "grenadier", var_2);
  } else {
    _id_C785(var_1, var_2);
    var_1 _id_576A(var_1, "grenadier", var_2);
  }
}

_id_A10B(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_1 notify("monitor_exit_initiated");
  var_1 endon("monitor_exit_initiated");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
  var_5 = level._id_5F3A;
  waitframe();

  for(;;) {
    var_6 = 0;
    var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(var_1 stancebuttonPressed()) {
      var_6 = var_6 + var_5;

      if(var_1 usinggamepad()) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", var_6 / 0.3);
      }

      if(var_1 usinggamepad() && var_6 > 0.3 || istrue(var_2) || !var_1 usinggamepad()) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
        return 1;
      }

      wait(var_5);
    }

    waitframe();
  }
}

_id_A108(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_1 notify("monitor_exit_initiated");
  var_1 endon("monitor_exit_initiated");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
  var_5 = level._id_5F3A;
  waitframe();

  for(;;) {
    var_6 = 0;
    var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(var_1 useButtonPressed()) {
      var_6 = var_6 + var_5;

      if(var_1 usinggamepad()) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", var_6 / 0.3);
      }

      if(var_1 usinggamepad() && var_6 > 0.3 || istrue(var_2) || !var_1 usinggamepad()) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);
        return 1;
      }

      wait(var_5);
    }

    waitframe();
  }
}

_id_54AB(var_0, var_1, var_2) {
  var_0 = _id_6816(var_2, "mine_drone_left");
  var_0 makeunusable();
  var_0._id_24C3 = 1;
  _id_54A9(var_0, var_1, var_2, "mine_drone_right");
}

_id_54AA(var_0, var_1, var_2) {
  var_0 = _id_6816(var_2, "mine_drone_right");
  var_0 makeunusable();
  var_0._id_24C3 = 1;
  _id_54A9(var_0, var_1, var_2, "mine_drone_left");
}

_id_54A9(var_0, var_1, var_2, var_3) {
  level notify("player_used_vehicle_mine_drone");
  var_1 notify("enter_mine_drone");
  var_1._id_AD12 = ::_id_9EC2;
  var_1._id_4A23 = 1;
  var_1 setplayerangles(var_2.angles);
  var_1 _id_DC3D(var_1, var_2);
  _id_5769(var_1);
  _id_C13E(var_1, var_3);
  var_1 scripts\common\utility::_id_158D(0);
  var_1 _id_C3D7(var_2, var_1);
  var_1 _id_FBE4(var_2);
  var_1 _meth_8690();
  var_1 thread _id_F95A(var_1, var_2);
  var_1 thread _id_0916::_id_47D5(var_1);
  var_1._id_4F6F _id_0796::_id_D89B(var_1._id_4F6F, undefined, var_2, "tag_origin", 2560000, 5760000);
  var_1._id_4F6F thread _id_4F91(var_1._id_4F6F, var_1);
}

_id_DC3D(var_0, var_1) {
  if(var_0._id_41A7 == "right_back_seat") {
    var_1._id_58EE show();
  } else if(var_0._id_41A7 == "left_back_seat") {
    var_1._id_58ED show();
  }
}

_id_9EC2(var_0) {
  var_1 = 10;

  if(!isDefined(var_0._id_A474)) {
    var_0._id_A474 = 0;
  }

  var_2 = gettime();

  if(var_2 > var_0._id_A474) {
    var_0._id_A474 = var_2 + var_1 * 1000;
    var_0 thread _id_076F::_id_F72D("dx_cps_ovl_vehicle_out_of_range_10", "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
  }
}

_id_F95A(var_0, var_1) {
  var_0 endon("exit_mine_drone");
  var_0 endon("exiting_drone");
  var_0 waittill("drone_exists");
  var_0 unlink();
  var_0 playerhide();
  var_2 = var_0.origin;
  var_3 = var_0.origin;

  for(;;) {
    var_2 = _id_668C(var_0, var_1);

    if(var_2 != var_3) {
      var_0 setorigin(var_2);
      var_3 = var_2;
    }

    waitframe();
  }
}

_id_668C(var_0, var_1) {
  switch (var_0._id_41A7) {
    case "mine_drone_left":
      return var_1 gettagorigin("tag_seat_2");
    case "mine_drone_right":
      return var_1 gettagorigin("tag_seat_3");
  }
}

_id_4F91(var_0, var_1) {
  var_0 waittill("death");
  var_1 notify("exit_mine_drone_right");
  var_1 notify("exit_mine_drone_left");
}

_id_5754(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_mine_drone");

  if(isDefined(var_1._id_4F6F)) {
    var_1._id_4F6F dodamage(var_1._id_4F6F._id_58FA + 100, var_1._id_4F6F.origin);
  }

  var_1._id_AD12 = undefined;
  level notify("vision_set_change_request", undefined, var_1, 0.05, "static");
  var_1 setclientomnvar("ui_out_of_bounds_countdown", 0);
  var_1 scripts\common\utility::_id_158D(1);
  _id_5234(var_2, "mine_drone_right");
  _id_5234(var_2, "mine_drone_left");
  var_1 _id_104F(var_2, var_1);
  var_1 _id_FBE4(var_2);
  var_2._id_58EE hide();
  var_2._id_58ED hide();
  var_1 playershow();
  var_1._id_4A23 = undefined;

  if(var_3 == "last_stand") {
    var_1._id_E778 = 0;
    _id_5767(var_1, 1);
    _id_576F(var_1, var_2, var_1._id_BC33);
  } else {
    var_1 _meth_868F();
    _id_C785(var_1, var_2);
  }
}

_id_54AF(var_0, var_1, var_2) {
  var_0 = _id_6816(var_2, "missile_defense_left");
  var_0 makeunusable();
  var_0._id_24C3 = 1;
  _id_54AC(var_0, var_1, var_2, "missile_defense_right");
}

_id_54AE(var_0, var_1, var_2) {
  var_0 = _id_6816(var_2, "missile_defense_right");
  var_0 makeunusable();
  var_0._id_24C3 = 1;
  _id_54AC(var_0, var_1, var_2, "missile_defense_left");
}

_id_54AC(var_0, var_1, var_2, var_3) {
  var_1 notify("enter_missile_defense");
  var_1._id_4A23 = 1;
  var_1._id_EE68 = 35;
  var_1._id_EE69 = 20;
  _id_5769(var_1);
  _id_C13E(var_1, var_3);
  var_1 setclientomnvar("ui_veh_vehicle", -1);
  var_1 setclientomnvar("ui_overwatch_view", 2);
  var_1 setclientomnvar("ui_missile_lock", 0);
  var_1 _id_54B0(var_1, var_2);
  var_1 _id_9B24(var_1, var_2);
  var_1 _id_6F10(var_1);
  var_1 _id_D008(var_1);
  var_1 _id_D009(var_1);
  var_1 thread _id_54AD(var_1, var_2);
  var_1 thread _id_54B1(var_1);
}

_id_54AD(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  var_0 thread _id_9F5A(var_0, var_1);
  var_0 thread _id_9F59(var_0, var_1);
  var_0 thread _id_9F58(var_0, var_1);
}

_id_9F58(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  var_1 endon("death ");
  var_0 notifyonplayercommand("reset_missile_defense_camera", "+weapnext");

  for(;;) {
    var_0 waittill("reset_missile_defense_camera");
    var_0 setplayerangles(vectortoangles(var_1.origin - var_1._id_C0B4._id_9F57.origin));
  }
}

_id_9F59(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  var_1 endon("death ");
  var_0 notifyonplayercommand("fire_interceptor_missile", "+attack");

  for(;;) {
    var_0 waittill("fire_interceptor_missile");
    var_2 = _id_6570();

    if(isDefined(var_2)) {
      _id_5B3D(var_2, var_0, var_1);
    }
  }
}

_id_6570() {
  if(!isDefined(level._id_96F1)) {
    return undefined;
  }

  var_0 = [];

  foreach(var_2 in level._id_96F1) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(istrue(var_2._id_24C1)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return _func_0204(var_0, level._id_B4E2.origin)[0];
}

_id_5B3D(var_0, var_1, var_2) {
  var_3 = 3;
  var_0._id_24C1 = 1;
  var_4 = anglestoleft(var_1 getplayerangles());
  var_5 = var_2._id_C0B4._id_9F57.origin + var_4 * var_3;
  var_6 = _func_0143("interceptor_missile_cp", var_5, var_0.origin);
  var_6._id_EE66 = _id_99AB(var_6);
  var_6 missile_settargetent(var_6._id_EE66);
  var_6 _meth_8231();
  var_6 setscriptablepartstate("thruster", "on", 0);
  _id_D260(var_6, var_0);
  var_6 thread _id_799E(var_6);
  var_6 thread _id_6380(var_6);

  if(!isDefined(level._id_83C1)) {
    level._id_83C1 = [];
  }

  level._id_83C1[level._id_83C1.size] = var_6;
  var_0._id_83BD = var_6;
  _id_BE63(var_6);
  var_6 thread _id_83BE(var_6, var_6._id_83C0, var_6 getentitynumber());
  _id_FB88();
}

_id_BE63(var_0) {
  var_1 = _id_0748::_id_C583("interceptor_missile_entity_number_" + var_0 getentitynumber(), 22);
  _func_016B(var_1, "invisible");
  _func_015D(var_1, "hud_callsign_bg");
  _func_0160(var_1, var_0);
  _func_0161(var_1, 0);
  _func_018B(var_1);
  _func_0172(var_1, 0);
  _func_0173(var_1, 0);
  _func_017A(var_1, 1);
  _func_0176(var_1, 1);
  _func_017B(var_1, 1);
  _func_018E(var_1, 1);
  var_0._id_83C0 = var_1;
  _id_99D2(var_1);
}

_id_6380(var_0) {
  var_0 endon("death");
  var_0 thread _id_E5B6(var_0);
  var_0 waittill("start_chasing_target_entity");
  var_1 = distancesquared(var_0.origin, var_0._id_EE73.origin);

  for(;;) {
    waitframe();

    if(isDefined(var_0._id_EE73) && isDefined(var_0._id_EE73.origin)) {
      var_2 = distancesquared(var_0.origin, var_0._id_EE73.origin);

      if(var_2 < var_1) {
        var_1 = var_2;
      } else {
        _id_83BF(var_0);
        return;
      }
    }
  }
}

_id_E5B6(var_0) {
  var_0 endon("death");

  for(;;) {
    if(isDefined(var_0._id_EE73) && isDefined(var_0._id_EE73.angles)) {
      var_1 = anglesToForward(var_0.angles);
      var_2 = anglesToForward(var_0._id_EE73.angles);

      if(vectordot(var_2, var_1) > 0) {
        var_0 notify("start_chasing_target_entity");
        return;
      }
    }

    waitframe();
  }
}

_id_799E(var_0) {
  var_0 endon("death");

  for(;;) {
    if(isDefined(var_0._id_EE73) && isDefined(var_0._id_EE73.origin)) {
      if(distancesquared(var_0.origin, var_0._id_EE73.origin) <= 22500) {
        _id_83BF(var_0);
      }
    }

    waitframe();
  }
}

_id_83BF(var_0) {
  playFX(scripts\engine\utility::getfx("interceptor_hit_air_exp"), var_0._id_EE73.origin);
  playsoundatpos(var_0._id_EE73.origin, "iw8_cruise_missile_exp");
  var_0._id_EE73 delete();
  var_0 delete();
}

_id_83BE(var_0, var_1, var_2) {
  var_0 waittill("death");
  level._id_83C1 = scripts\engine\utility::array_remove(level._id_83C1, var_0);
  _id_0748::_id_5F56("interceptor_missile_entity_number_" + var_2);
  _func_015C(var_1);
}

_id_99AB(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1 thread _id_9F54(var_1, var_0);
  return var_1;
}

_id_9F54(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

_id_9F5A(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  var_1 endon("death");

  for(;;) {
    if(isDefined(level._id_40BC)) {
      foreach(var_3 in level._id_40BC) {
        if(var_0 _meth_845E(var_3.origin, var_0._id_EE68, var_0._id_EE69)) {
          var_3._id_96E6 = var_3._id_96E6 + 0.05;
        }

        if(var_3._id_96E6 >= 0.5) {
          _id_9B0D(var_3, var_0, var_1);
        }
      }
    }

    waitframe();
  }
}

_id_9B0D(var_0, var_1, var_2) {
  if(!isDefined(level._id_96F1)) {
    level._id_96F1 = [];
  }

  if(!scripts\engine\utility::array_contains(level._id_96F1, var_0)) {
    _func_015D(var_0._id_40B9, "hud_callsign_bg_rd_full");
    var_2._id_C0B4._id_9F57 playsoundtoplayer("breach_warning_beep_05", var_1);
    level._id_96F1 = scripts\engine\utility::array_add(level._id_96F1, var_0);
    var_1 setclientomnvar("ui_missile_lock", 1);
  }
}

_id_54B1(var_0) {
  var_0 endon("disconnect");
  var_0 endon("exit_missile_defense");
  _id_AD95(var_0);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color_glitch", var_0, 0.25);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color", var_0, 0);
}

_id_6F10(var_0) {
  var_0 scripts\cp\utility::_giveweapon("ac130_105mm_cp");
  var_0 _id_0777::_switchtoweaponimmediate("ac130_105mm_cp");
  var_0 scripts\common\utility::_id_1593(0);
  var_0._id_BB4F = var_0 getcurrentweapon();
}

_id_54B0(var_0, var_1) {
  var_0 _meth_826E(var_1._id_C0B4._id_9F57, "tag_player", 1.0, 180, 180, 90, 80, 0);
  var_0 _meth_8266(0);
  var_2 = anglesToForward(var_1.angles);
  var_2 = var_2 * (1, 1, 0);
  var_0 setplayerangles(vectortoangles(var_2));
}

_id_5755(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_missile_defense");
  var_1 thread _id_5757(var_1);
  var_1 setclientomnvar("ui_overwatch_view", 0);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
  _id_5234(var_2, "missile_defense_left");
  _id_5234(var_2, "missile_defense_right");
  var_1._id_4A23 = undefined;
  var_1 _id_5756(var_1);
  var_1 _id_F992(var_1);
  var_1 _id_C408(var_1);
  var_1 _id_38DD(var_1);
  var_1 _id_38DE(var_1);

  if(var_3 == "last_stand") {
    var_1._id_E778 = 0;
    _id_5767(var_1, 1);
    _id_576F(var_1, var_2, var_1._id_BC33);
  } else {
    var_1 _meth_868F();
    _id_C785(var_1, var_2);
  }
}

_id_38DD(var_0) {
  if(isDefined(level._id_40BC)) {
    foreach(var_2 in level._id_40BC) {
      _func_0189(var_2._id_40B9, var_0);
    }
  }
}

_id_38DE(var_0) {
  if(isDefined(level._id_83C1)) {
    foreach(var_2 in level._id_83C1) {
      if(isDefined(var_2)) {
        _func_0189(var_2._id_83C0, var_0);
      }
    }
  }
}

_id_C408(var_0) {
  var_0 _id_0777::_takeweapon("ac130_105mm_cp");
  var_0 scripts\common\utility::_id_1593(1);
  var_0 switchtoweaponimmediate(var_0._id_BB4F);
}

_id_5756(var_0) {
  var_0 _meth_8060();
}

_id_5757(var_0) {
  var_0 endon("disconnect");
  var_0 endon("enter_missile_defense");
  _id_AD95(var_0);
  level notify("vision_set_change_request", undefined, var_0, 0, "ac130_color");
  waitframe();
  level notify("vision_set_change_request", undefined, var_0, 0, "ac130_color_glitch");
}

_id_54BA(var_0, var_1, var_2) {
  _id_54B7(var_0, var_1, var_2, "overwatch_right");
  _id_4A66(var_2, "overwatch_left");
}

_id_54B9(var_0, var_1, var_2) {
  _id_54B7(var_0, var_1, var_2, "overwatch_left");
  _id_4A66(var_2, "overwatch_right");
}

_id_54B7(var_0, var_1, var_2, var_3) {
  var_1 notify("enter_overwatch");
  var_1._id_4A23 = 1;
  _id_5769(var_1);
  _id_C13E(var_1, var_3);
  var_1 setclientomnvar("ui_veh_vehicle", -1);
  var_1 setclientomnvar("ui_overwatch_view", 1);
  var_1 _id_DC50(var_1);
  var_1 _id_FB65(var_1);
  var_1 _id_4727(var_1);
  var_1 _id_54BB(var_1, var_2);
  var_1 _id_9992(var_1, var_2);
  var_1 _id_9B24(var_1, var_2);
  var_1 _id_6F42(var_1);
  var_1 thread _id_54B8(var_1, var_2);
  var_1 thread _id_54B4(var_1);
  var_1 thread _id_EE7C(var_1, ::_id_C0B9);
  var_1 thread _id_C0BC(var_1, var_2);
}

_id_D008(var_0) {
  if(isDefined(level._id_40BC)) {
    foreach(var_2 in level._id_40BC) {
      _func_0185(var_2._id_40B9, var_0);
    }
  }
}

_id_D009(var_0) {
  if(isDefined(level._id_83C1)) {
    foreach(var_2 in level._id_83C1) {
      _func_0185(var_2._id_83C0, var_0);
    }
  }
}

_id_B20B(var_0, var_1) {
  _func_019D(scripts\engine\utility::getfx("reaper_clouds"), var_1._id_C0B4._id_9F57, "tag_player", var_0);
}

_id_54B8(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_0 thread _id_C0B6(var_0, var_1);
  var_0 thread _id_C0B5(var_0, var_1);
  var_0 thread _id_C0B8(var_0, var_1);
}

_id_C0B8(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_1 endon("death");

  if(_id_C0C1()) {
    _id_C0BF(var_0);
  }

  var_0 notifyonplayercommand("reaper_fire_missile", "+attack");
  var_2 = 2;
  var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_2);

  for(;;) {
    var_0 waittill("reaper_fire_missile");
    var_3 = _id_5B4E(var_0, var_1);
    var_2 = var_2 - 1;
    var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_2);

    if(var_2 == 0) {
      var_0 _id_C0C0(var_0);
      var_2 = 2;
      var_0 setclientomnvar("ui_killstreak_weapon_2_ammo", var_2);
    }
  }
}

_id_5B4E(var_0, var_1) {
  var_2 = 3;
  var_3 = _id_99B8(var_0, var_1);
  var_4 = anglestoleft(var_0 getplayerangles());
  var_5 = var_1._id_C0B4._id_9F57.origin + var_4 * var_2;
  var_6 = _func_0143("overwatch_missile_cp", var_5, var_3.origin, var_0);
  var_6 missile_settargetent(var_3);
  var_6 _meth_8231();
  var_6 setscriptablepartstate("thruster", "on", 0);
  var_3 thread _id_3834(var_3, var_6);
  return var_6;
}

_id_C0C0(var_0) {
  var_1 = 4;
  level._id_C0BA = gettime() + int(var_1 * 1000);
  var_0 setclientomnvar("ui_ac130_40mm_reloadtime", level._id_C0BA);

  for(;;) {
    wait 0.05;
    var_1 = var_1 - 0.05;

    if(var_1 <= 0) {
      break;
    }
  }
}

_id_C0C1() {
  return isDefined(level._id_C0BA) && level._id_C0BA > gettime();
}

_id_C0BF(var_0) {
  var_1 = gettime();
  var_2 = level._id_C0BA - var_1;
  var_3 = var_2 / 1000;
  var_0 setclientomnvar("ui_ac130_40mm_reloadtime", level._id_C0BA);
  wait(var_3);
}

_id_3834(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

_id_99B8(var_0, var_1) {
  var_2 = _id_66F4(var_0, var_1);
  var_3 = spawn("script_model", var_2);
  var_3 setModel("tag_origin");
  var_3 thread _id_B288(var_3, var_0);
  _id_BE64(var_3, var_0);
  var_3 thread _id_5E21(var_3, var_0, var_1);
  return var_3;
}

_id_B288(var_0, var_1) {
  var_0 endon("death");
  waitframe();
  _func_019D(level._effect["reaper_missile_marker"], var_0, "tag_origin", var_1);
}

_id_BE64(var_0, var_1) {
  var_2 = _id_0748::_id_C583("reaper_missile_target_ent" + var_0 getentitynumber(), 22);
  _func_016B(var_2, "invisible");
  _func_015D(var_2, "hud_overwatch_missile_target");
  _func_0160(var_2, var_0);
  _func_0161(var_2, 0);
  _func_018B(var_2);
  _func_0172(var_2, 0);
  _func_0173(var_2, 0);
  _func_017A(var_2, 1);
  _func_0176(var_2, 0);
  _func_017B(var_2, 1);
  _func_018E(var_2, 1);
  _func_0185(var_2, var_1);
  var_0 thread _id_C0BB(var_0, var_2, var_0 getentitynumber());
}

_id_C0BB(var_0, var_1, var_2) {
  var_0 waittill("death");
  _id_0748::_id_5F56("reaper_missile_target_ent" + var_2);
  _func_015C(var_1);
}

_id_5E21(var_0, var_1, var_2) {
  var_0 endon("death");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_1 endon("exit_overwatch");

  for(;;) {
    waitframe();
    var_0.origin = _id_66F4(var_1, var_2);
  }
}

_id_C0BC(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_0 notifyonplayercommand("overwatch_radar_pin", "+speed_throw");

  for(;;) {
    var_0 waittill("overwatch_radar_pin");
    var_0._id_AD79 playsoundtoplayer("reaper_scan_target", var_0);
    var_2 = _id_66F4(var_0, var_1);
    waitframe();
    level thread _id_DC79(var_0, var_2);
    level thread _id_DC1C(var_0, var_2);
    wait 1;
  }
}

_id_66F4(var_0, var_1) {
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = var_1._id_C0B4._id_CB8A.origin + var_2 * 50;
  var_4 = var_1._id_C0B4._id_CB8A.origin + var_2 * 30000;
  var_5 = scripts\engine\trace::_id_C051(var_3, var_4, var_1._id_C0B4);
  var_6 = var_5["position"];
  return var_6;
}

_id_DC79(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_2 = [];

  foreach(var_4 in level._id_F94A) {
    if(istrue(var_4._id_7D72)) {
      var_2[var_2.size] = var_4;
    }
  }

  var_6 = _func_0204(var_2, var_1);

  foreach(var_8 in var_6) {
    var_0._id_AD79 playsoundtoplayer("breach_warning_beep_05", var_0);
    _id_9B19(var_0, var_8);
    wait(randomfloatrange(0.05, 0.1));
  }
}

_id_DC1C(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_2 = [];

  foreach(var_4 in level.agentarray) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isalive(var_4)) {
      continue;
    }
    if(istrue(var_4._id_9B2D)) {
      continue;
    }
    if(var_4.team == "allies") {
      continue;
    }
    if(istrue(var_4._id_7D72)) {
      var_2[var_2.size] = var_4;
    }
  }

  var_6 = _func_0204(var_2, var_1);

  foreach(var_4 in var_6) {
    var_0._id_AD79 playsoundtoplayer("breach_warning_beep_05", var_0);
    var_4._id_9B2D = 1;
    _id_0F94(var_4);
    _id_ACB5(var_4, var_0);

    if(istrue(var_4._id_858D)) {
      _id_0F93(var_4);
      _id_BE6C(var_4, var_0);
      _id_9998(var_4);

      foreach(var_9 in level.players) {
        if(var_9 == var_0) {
          continue;
        }
        _id_DC2D(var_4, var_9);
      }
    }

    wait(randomfloatrange(0.05, 0.1));
  }
}

_id_C0B9(var_0) {
  if(_id_B4EE(var_0)) {
    return _id_83BC(var_0);
  } else {
    return _id_CB8B(var_0);
  }
}

_id_B4EE(var_0) {
  return var_0._id_4192 == 3;
}

_id_83BC(var_0) {
  foreach(var_2 in level._id_F94A) {
    var_2._id_7D72 = undefined;
  }

  foreach(var_5 in level.agentarray) {
    var_5._id_7D72 = undefined;
  }

  return 0;
}

_id_CB8B(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_F94A) {
    if(var_0 _meth_845E(var_3.origin, var_0._id_EE68, var_0._id_EE69)) {
      var_3._id_7D72 = 1;
      var_1 = var_1 + 1;
      continue;
    }

    var_3._id_7D72 = undefined;
  }

  foreach(var_6 in level.agentarray) {
    if(!isDefined(var_6)) {
      var_6._id_7D72 = undefined;
      continue;
    }

    if(!isalive(var_6)) {
      var_6._id_7D72 = undefined;
      continue;
    }

    if(istrue(var_6._id_9B2D)) {
      var_6._id_7D72 = undefined;
      continue;
    }

    if(istrue(var_6.team == "allies")) {
      var_6._id_7D72 = undefined;
      continue;
    }

    if(var_0 _meth_845E(var_6.origin, var_0._id_EE68, var_0._id_EE69)) {
      var_6._id_7D72 = 1;
      var_1 = var_1 + 1;
    }
  }

  var_1 = min(var_1, 7) / 7 * 0.4;
  return var_1;
}

_id_C0B6(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");
  var_0 notifyonplayercommand("reaper_camera_zoom_in", "+actionslot 1");
  var_0 notifyonplayercommand("reaper_camera_zoom_out", "+actionslot 2");
  _id_D1A7(var_0, 2, var_1);

  for(;;) {
    var_2 = var_0 scripts\engine\utility::_id_10897("reaper_camera_zoom_in", "reaper_camera_zoom_out");

    if(var_2 == "reaper_camera_zoom_in") {
      _id_1199(var_0, -1, var_1);
    } else if(var_2 == "reaper_camera_zoom_out") {
      _id_1199(var_0, 1, var_1);
    }

    waitframe();
  }
}

_id_C0B5(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_1 endon("death");
  var_0 notifyonplayercommand("reset_overwatch_camera", "+weapnext");

  for(;;) {
    var_0 waittill("reset_overwatch_camera");
    var_0 setplayerangles(vectortoangles(var_1.origin - var_1._id_C0B4._id_CB8A.origin));
  }
}

_id_1199(var_0, var_1, var_2) {
  var_3 = int(clamp(var_0._id_4192 + var_1, 1, 2));
  _id_D1A7(var_0, var_3, var_2);
}

_id_D1A7(var_0, var_1, var_2) {
  if(isDefined(var_0._id_4192) && var_0._id_4192 == var_1) {
    return;
  }
  var_3 = var_0._id_4192;
  var_0._id_4192 = var_1;
  _id_EC2D(var_0);
  _id_119A(var_0);
}

_id_EC2D(var_0) {
  var_1 = _id_66C9(var_0);
  var_0 _id_0777::_switchtoweaponimmediate(var_1);
}

_id_119A(var_0) {
  switch (var_0._id_4192) {
    case 1:
      var_0._id_EE68 = 10;
      var_0._id_EE69 = 150;
      return;
    case 2:
      var_0._id_EE68 = 22;
      var_0._id_EE69 = 150;
      return;
    case 3:
      var_0._id_EE68 = 35;
      var_0._id_EE69 = 20;
      return;
  }
}

_id_66C9(var_0) {
  switch (var_0._id_4192) {
    case 1:
      return "ac130_25mm_cp";
    case 2:
      return "ac130_40mm_cp";
    case 3:
      return "ac130_105mm_cp";
  }
}

_id_9B24(var_0, var_1) {
  var_0._id_7B9B = _id_079B::_id_EEDF("thermalvisionfriendlydefault", var_0, var_1, var_0);

  if(isDefined(level._id_5F73)) {
    foreach(var_3 in level._id_5F73) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3 == var_1) {
        continue;
      }
      _id_079B::_id_EEDC(var_3, var_0._id_7B9B);
    }
  }
}

_id_F992(var_0) {
  _id_079B::_id_EEDE(var_0._id_7B9B);
}

_id_9992(var_0, var_1) {
  var_2 = spawn("script_model", var_1._id_C0B4._id_CB8A.origin);
  var_2 setModel("tag_origin");
  var_2.angles = var_1._id_C0B4._id_CB8A.angles;
  var_2 linkto(var_1._id_C0B4._id_CB8A);
  var_0._id_AD79 = var_2;
}

_id_54BB(var_0, var_1) {
  var_0 _meth_826E(var_1._id_C0B4._id_CB8A, "tag_player", 1.0, 45, 45, 30, 30, 0);
  var_0 _meth_8266(0);
  var_0 setplayerangles(vectortoangles(var_1.origin - var_1._id_C0B4._id_CB8A.origin));
}

_id_6F42(var_0) {
  var_0 scripts\cp\utility::_giveweapon("ac130_105mm_cp");
  var_0 scripts\cp\utility::_giveweapon("ac130_40mm_cp");
  var_0 scripts\cp\utility::_giveweapon("ac130_25mm_cp");
  var_0 scripts\common\utility::_id_1593(0);
  var_0._id_BB54 = var_0 getcurrentweapon();
}

_id_5762(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_overwatch");
  var_1 thread _id_575B(var_1);
  var_1 setclientomnvar("ui_overwatch_view", 0);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
  var_1 _id_78BB(var_1);
  var_1 _id_FB66(var_1);
  var_1 _id_788A(var_1);
  _id_5234(var_2, "overwatch_right");
  _id_5234(var_2, "overwatch_left");
  var_1._id_4A23 = undefined;
  var_1 _id_5763(var_1);
  var_1 _id_4702(var_1);
  var_1 _id_F992(var_1);
  var_1 _id_C439(var_1);
  var_1 _id_FA2F(var_1);

  if(var_3 == "last_stand" || var_3 == "force_player_exit_vehicle") {
    var_1._id_E778 = 0;
    _id_5767(var_1, 1);
    _id_576F(var_1, var_2, var_1._id_BC33);
  } else
    _id_C785(var_1, var_2);
}

_id_FA2F(var_0) {
  var_0._id_4192 = undefined;
}

_id_4702(var_0) {
  var_0._id_AD79 delete();
}

_id_5763(var_0) {
  var_0 _meth_8060();
}

_id_C439(var_0) {
  var_0 _id_0777::_takeweapon("ac130_105mm_cp");
  var_0 _id_0777::_takeweapon("ac130_40mm_cp");
  var_0 _id_0777::_takeweapon("ac130_25mm_cp");
  var_0 scripts\common\utility::_id_1593(1);
  var_0 switchtoweaponimmediate(var_0._id_BB54);
}

_id_BE6C(var_0, var_1) {
  if(isDefined(var_1._id_AD9A)) {
    _id_079B::_id_EEDC(var_0, var_1._id_AD9A);
  } else {
    var_1._id_AD9A = _id_079B::_id_EEDF("ieddronetarget", var_1, var_0, var_1);
  }

  var_0._id_EE7E = var_1._id_AD9A;
}

_id_0F94(var_0) {
  if(scripts\engine\utility::array_contains(level._id_9B30, var_0)) {
    return;
  }
  level._id_9B30 = scripts\engine\utility::array_add(level._id_9B30, var_0);
  var_0 thread _id_C3CF(var_0);
}

_id_C3CF(var_0) {
  var_0 waittill("death");
  level._id_9B30 = scripts\engine\utility::array_remove(level._id_9B30, var_0);
}

_id_0F93(var_0) {
  if(scripts\engine\utility::array_contains(level._id_9B2E, var_0)) {
    return;
  }
  level._id_9B2E = scripts\engine\utility::array_add(level._id_9B2E, var_0);
  var_0 thread _id_C3CE(var_0);
}

_id_C3CE(var_0) {
  var_0 waittill("death");
  level._id_9B2E = scripts\engine\utility::array_remove(level._id_9B2E, var_0);
}

_id_9998(var_0) {
  if(_id_74E1(var_0)) {
    return;
  }
  var_1 = _id_0748::_id_C583("enemy_AI_critical_target_ID_" + var_0 getentitynumber(), 22);
  _func_016B(var_1, "invisible");
  _func_015D(var_1, "icon_faction_head_enemy");
  _func_0160(var_1, var_0);
  _func_0161(var_1, 90);
  _func_018B(var_1);
  _func_0172(var_1, 0);
  _func_0173(var_1, 0);
  _func_017A(var_1, 1);
  _func_0176(var_1, 0);
  _func_017B(var_1, 0);
  _func_018E(var_1, 1);
  var_0._id_408B = var_1;
  var_0 thread _id_470B(var_0, var_0 getentitynumber(), var_1);
}

_id_74E1(var_0) {
  return isDefined(var_0._id_408B);
}

_id_470B(var_0, var_1, var_2) {
  var_0 waittill("death");
  _id_0748::_id_5F56("enemy_AI_critical_target_ID_" + var_1);
  _func_015C(var_2);
  var_0._id_408B = undefined;
}

_id_DC2D(var_0, var_1) {
  if(_id_74E1(var_0)) {
    _func_0185(var_0._id_408B, var_1);
  }
}

_id_789D(var_0, var_1) {
  if(_id_74E1(var_0)) {
    _func_0189(var_0._id_408B, var_1);
  }
}

_id_FB65(var_0) {
  foreach(var_2 in level._id_9B30) {
    _id_ACB5(var_2, var_0);
  }

  foreach(var_2 in level._id_9B2E) {
    _id_789D(var_2, var_0);

    if(isDefined(var_0._id_AD9A)) {
      _id_079B::_id_EEDC(var_2, var_0._id_AD9A);
    } else {
      var_0._id_AD9A = _id_079B::_id_EEDF("ieddronetarget", var_0, var_2, var_0);
    }

    var_2._id_EE7E = var_0._id_AD9A;
  }
}

_id_FB66(var_0) {
  foreach(var_2 in level._id_9B30) {
    _id_C3B0(var_2, var_0);
  }

  foreach(var_2 in level._id_9B2E) {
    _id_9998(var_2);
    _id_DC2D(var_2, var_0);
  }

  if(isDefined(var_0._id_AD9A)) {
    _id_079B::_id_EEDE(var_0._id_AD9A);
    var_0._id_AD9A = undefined;
  }
}

_id_ACB5(var_0, var_1) {
  var_0 _meth_81B1(var_1, "overwatch_target_outline");
}

_id_C3B0(var_0, var_1) {
  var_0 _meth_81AE(var_1);
}

_id_54B2(var_0, var_1, var_2) {
  var_1 notify("enter_overwatch");
  var_1._id_4A23 = 1;
  _id_5769(var_1);
  _id_C13E(var_1, "overwatch");
  var_1 scripts\common\utility::_id_158D(0);
  var_1 setclientomnvar("ui_veh_vehicle", -1);
  var_1 setclientomnvar("ui_overwatch_view", 1);
  var_1 _id_DC50(var_1);
  var_1 _id_C3D7(var_2, var_1);
  var_1 _id_FBE4(var_2);
  var_1 _id_4727(var_1);
  var_1 _id_DC1A(var_1);
  var_1 thread _id_54B4(var_1);
  var_1 thread _id_54B3(var_1, var_2);
  var_1 thread _id_EE7C(var_1, ::_id_AD84);
  var_1 thread _id_A1D2(var_1);
  var_1 thread _id_AD90(var_1, var_2);
  level thread _id_5211();
}

_id_5759(var_0, var_1, var_2, var_3) {
  var_1 notify("exit_overwatch");
  var_1 thread _id_575B(var_1);
  var_1 scripts\common\utility::_id_158D(1);
  var_1 setclientomnvar("ui_overwatch_view", 0);
  var_1 setclientomnvar("ui_veh_vehicle", 10);
  var_1 _id_78BB(var_1);
  var_1 _id_104F(var_2, var_1);
  var_1 _id_FBE4(var_2);
  var_1 _id_788A(var_1);
  _id_575A(var_1, var_2);
  _id_5234(var_2, "overwatch");
  level thread _id_4A31();
  var_1._id_4A23 = undefined;

  if(var_3 == "last_stand") {
    var_1._id_E778 = 0;
    _id_5767(var_1, 1);
    _id_576F(var_1, var_2, var_1._id_BC33);
  } else
    _id_C785(var_1, var_2);
}

_id_BE5F(var_0) {
  var_1 = _id_0748::_id_C583("vehicle_icon", 20);
  _func_0172(var_1, 0);
  _func_017A(var_1, 1);
  _func_016B(var_1, "invisible");
  _func_015D(var_1, "cp_tac_hud_icon_vehicle");
  _func_0167(var_1, "");
  _func_0160(var_1, var_0);
  _func_0188(var_1);
  var_0._id_A882 = var_1;

  if(getdvarint("#x3b85a5165c468e77c", 0) != 0) {
    _func_018B(var_0._id_A882);
  }

  var_0 thread _id_7C3C(var_0);
}

_id_7C3C(var_0) {
  var_0 waittill("death");
  _id_0748::_id_5F56("vehicle_icon");
}

_id_54B3(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_2 = spawn("script_model", _id_63B4(var_1));
  var_2 setModel("tag_origin");
  var_2.angles = vectortoangles((0, 0, -1));
  var_2._id_300E = var_2.origin[2];
  var_2._id_306F = var_2._id_300E - _id_6633();
  var_2._id_306E = var_2._id_300E + _id_6633();
  var_2 thread _id_3838(var_2, var_0, var_1);
  var_0._id_AD79 = var_2;
  var_0 cameralinkto(var_2, "tag_origin");
  var_0 thread _id_307F(var_0, var_1);
  var_0 thread _id_3073(var_0, var_1);
  var_0 thread _id_3078(var_0, var_1);
  var_0 thread _id_3070(var_0, var_1);
  var_0 thread _id_AD90(var_0, var_1);
}

_id_6633() {
  if(isDefined(level._id_AD7A)) {
    return level._id_AD7A;
  }

  return 2000;
}

_id_EE7C(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_0 setclientomnvar("ui_targets_in_circle", 0);

  for(;;) {
    var_2 = [[var_1]](var_0);
    var_0 setclientomnvar("ui_targets_in_circle", var_2);
    waitframe();
  }
}

_id_AD84(var_0) {
  var_1 = 0;
  var_2 = _id_67FA(var_0, var_0._id_AD79._id_300C);
  var_3 = _func_0219(600);

  foreach(var_5 in var_2) {
    var_1 = var_1 + (1 - distance2dsquared(var_5.origin, var_0._id_AD79._id_300C) / var_3);
  }

  foreach(var_8 in level.agentarray) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(!isalive(var_8)) {
      continue;
    }
    if(istrue(var_8._id_9B2D)) {
      continue;
    }
    var_9 = distance2dsquared(var_8.origin, var_0._id_AD79._id_300C);

    if(var_9 <= var_3) {
      var_1 = var_1 + (1 - var_9 / var_3);
    }
  }

  var_1 = min(var_1, 7) / 7 * 0.4;
  return var_1;
}

_id_AD90(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_0._id_596D = [];
  var_0._id_A46A = 0;
  var_0 notifyonplayercommand("overwatch_radar_pin", "+goStand");

  for(;;) {
    var_0 waittill("overwatch_radar_pin");
    playFX(level._effect["IED_radar_ping"], var_0._id_AD79._id_300C, undefined, undefined, var_0);
    _id_DC78(var_0, var_0._id_AD79._id_300C);
    level thread _id_DC1B(var_0, var_0._id_AD79._id_300C);
    wait 1;
  }
}

_id_DC3F(var_0, var_1, var_2) {
  var_3 = _id_649D(var_1, var_0);
  var_4 = [];

  if(_id_10CE(var_3)) {
    var_5 = _id_62FE(var_3);
    var_4 = _id_99A3(var_0, var_1, var_5);
  }

  foreach(var_7 in var_3) {
    level thread _id_DC3E(var_0, var_1, var_7);
  }

  foreach(var_7 in var_4) {
    level thread _id_DC3E(var_0, var_1, var_7);
  }
}

_id_DC78(var_0, var_1) {
  var_2 = _id_67FA(var_0, var_1);

  foreach(var_4 in var_2) {
    level thread _id_DC4E(var_0, var_1, var_4);
  }
}

_id_DC1B(var_0, var_1) {
  var_2 = int(30.0);
  var_3 = 400.0;
  var_4 = var_3 * 0.05;

  for(var_5 = 1; var_5 <= var_2; var_5++) {
    var_6 = min(600, var_4 * (1.5 * var_5));

    foreach(var_8 in level.agentarray) {
      if(!isDefined(var_8)) {
        continue;
      }
      if(!isalive(var_8)) {
        continue;
      }
      if(istrue(var_8._id_9B2D)) {
        continue;
      }
      if(distance2dsquared(var_8.origin, var_1) <= var_6 * var_6) {
        var_0._id_AD79 playsoundtoplayer("breach_warning_beep_05", var_0);
        var_8 _meth_81B0("outlinefill_nodepth_orange");
        var_8._id_9B2D = 1;
        _id_DC35(var_8, var_0);
      }
    }

    waitframe();
  }
}

_id_DC35(var_0, var_1) {
  if(isDefined(var_1._id_5381)) {
    _id_079B::_id_EEDC(var_0, var_1._id_5381);
  } else {
    var_1._id_5381 = _id_079B::_id_EEDF("ieddronetarget", var_1, var_0, var_1);
  }

  var_0._id_EE7E = var_1._id_AD9A;
}

_id_788A(var_0) {
  if(isDefined(var_0._id_5381)) {
    _id_079B::_id_EEDE(var_0._id_5381);
    var_0._id_5381 = undefined;
  }
}

_id_DC1A(var_0) {
  foreach(var_2 in level.agentarray) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(istrue(var_2._id_9B2D)) {
      _id_DC35(var_2, var_0);
    }
  }
}

_id_10CE(var_0) {
  return var_0.size < 5;
}

_id_99A3(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = _id_66E5(var_2, 360);
  var_5 = _id_66E5(var_2, 600);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = (0, var_4[var_6], 0);
    var_8 = anglesToForward(var_7);
    var_9 = var_5[var_6];
    var_10 = var_0._id_AD79.origin;
    var_11 = var_1 + var_8 * var_9;
    var_10 = (var_11[0], var_11[1], var_10[2]);
    var_11 = scripts\engine\trace::_id_C051(var_10, var_11 + (0, 0, -5000))["position"] + (0, 0, 5);
    var_3[var_3.size] = var_11;
    _id_BE61(var_0, var_11);
  }

  return var_3;
}

_id_BE61(var_0, var_1) {
  var_0._id_596D[var_0._id_A46A] = var_1;
  var_0._id_A46A++;

  if(var_0._id_A46A >= 200) {
    var_0._id_A46A = 0;
  }
}

_id_62FE(var_0) {
  var_1 = _id_65FF();
  return var_1 - var_0.size;
}

_id_649D(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1._id_596D) {
    if(distance2dsquared(var_4, var_0) <= 360000) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_67FA(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_F94A) {
    if(distance2dsquared(var_4.origin, var_1) <= 360000) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_DC4E(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2.origin);
  var_4 = 400.0;
  var_5 = var_3 / var_4;
  var_6 = int(var_5 * 20);
  var_5 = var_6 * 0.05;
  wait(max(0.05, var_5 - 0.55));

  if(isDefined(var_0._id_AD79)) {
    var_0._id_AD79 playsoundtoplayer("breach_warning_beep_05", var_0);
  }

  _id_9B19(var_0, var_2);
}

_id_DC3E(var_0, var_1, var_2) {
  var_3 = distance(var_1, var_2);
  var_4 = 400.0;
  var_5 = var_3 / var_4;
  var_6 = int(var_5 * 20);
  var_5 = var_6 * 0.05;
  wait(max(0.05, var_5 - 0.5));
  playFX(level._effect["IED_false_positive"], var_2, (0, 0, 1), (1, 0, 0), var_0);
}

_id_66E5(var_0, var_1) {
  var_2 = [];
  var_3 = var_1 / var_0;

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_2[var_2.size] = randomfloatrange(var_4 * var_3, (var_4 + 1) * var_3);
  }

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_2 = scripts\engine\utility::array_randomize(var_2);
  }

  return var_2;
}

_id_65FF() {
  return randomintrange(5, 11);
}

_id_6311(var_0) {
  return "outlinefill_nodepth_red";
}

_id_9B13(var_0, var_1) {
  var_0._id_7939 = scripts\engine\utility::array_remove(var_0._id_7939, var_1);
  var_1._id_9B2C = 1;
  var_1 _meth_81B0(_id_6311(var_1));
}

_id_9B19(var_0, var_1) {
  if(!_id_85F8(var_1) && isDefined(var_1)) {
    level notify("IED_marked");
    _id_C3DF(var_1);
    _id_9B1A(var_1);
    _id_1040(var_1);
    _id_DC4C(var_1, var_0);
    _id_DC4B(var_1, var_0);
    _id_D254(var_1);
  }
}

_id_9B1A(var_0) {
  var_1 = var_0._id_7CD8;
  var_1._id_7C90 = 1;

  if(isDefined(var_1._id_F94B)) {
    foreach(var_3 in var_1._id_F94B) {
      if(isDefined(var_3)) {
        var_3 delete();
      }
    }
  }
}

_id_3073(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");

  for(;;) {
    var_2 = var_0 getnormalizedmovement();
    var_3 = var_2[0];
    var_4 = var_2[1];

    if(_id_B553(var_3, var_4)) {
      var_0 notify("start_moving_camera");
      var_5 = (var_3 * _id_63AF(var_0), var_4 * _id_63AF(var_0) * -1, 0);
      var_6 = var_0._id_AD79.origin + var_5;
      var_6 = (var_6[0], var_6[1], var_0._id_AD79._id_300E);
      var_0._id_AD79.origin = var_6;
    }

    waitframe();
  }
}

_id_63AF(var_0) {
  var_1 = var_0._id_AD79._id_306E - var_0._id_AD79._id_306F;
  var_2 = var_0._id_AD79._id_300E - var_0._id_AD79._id_306F;
  var_3 = var_2 / var_1 * 90;
  var_4 = 10 + var_3;
  return var_4;
}

_id_307F(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");

  for(;;) {
    if(var_0 attackButtonPressed()) {
      var_0 notify("start_moving_camera");
      var_0._id_AD79._id_300E = max(var_0._id_AD79._id_306F, var_0._id_AD79._id_300E - 160);
      var_0._id_AD79.origin = (var_0._id_AD79.origin[0], var_0._id_AD79.origin[1], var_0._id_AD79._id_300E);
    }

    if(var_0 adsButtonPressed()) {
      var_0 notify("start_moving_camera");
      var_0._id_AD79._id_300E = min(var_0._id_AD79._id_306E, var_0._id_AD79._id_300E + 160);
      var_0._id_AD79.origin = (var_0._id_AD79.origin[0], var_0._id_AD79.origin[1], var_0._id_AD79._id_300E);
    }

    waitframe();
  }
}

_id_3070(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");

  for(;;) {
    var_2 = scripts\engine\trace::_id_C051(var_0._id_AD79.origin + (0, 0, -5), var_0._id_AD79.origin + (0, 0, -50000));
    var_3 = var_2["position"];
    var_0._id_AD79._id_300C = var_3;
    var_4 = var_3[2] + 500;
    var_0._id_AD79._id_306F = var_4;

    if(var_0._id_AD79.origin[2] < var_4) {
      var_0._id_AD79.origin = (var_0._id_AD79.origin[0], var_0._id_AD79.origin[1], var_4);
    }

    waitframe();
  }
}

_id_3838(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::_id_1088C(var_1, "exit_overwatch", var_1, "disconnect", var_1, "last_stand", var_2, "death");
  var_0 delete();
}

_id_B553(var_0, var_1) {
  if(abs(var_0) != 0) {
    return 1;
  }

  if(abs(var_1) != 0) {
    return 1;
  }

  return 0;
}

_id_3078(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_1 endon("death ");
  var_0 notifyonplayercommand("reset_overwatch_camera", "+weapnext");

  for(;;) {
    var_0 thread _id_96E3(var_0, var_1);
    var_0 waittill("reset_overwatch_camera");
  }
}

_id_96E3(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  var_0 endon("start_moving_camera");
  var_1 endon("death");

  for(;;) {
    var_2 = _id_63B3(var_0, var_1);
    var_0._id_AD79.origin = var_2;
    waitframe();
  }
}

_id_63B4(var_0) {
  return var_0 gettagorigin("tag_origin") + (0, 0, _id_63AE());
}

_id_63AE() {
  if(isDefined(level._id_AD7C)) {
    return level._id_AD7C;
  }

  return 2550;
}

_id_63B3(var_0, var_1) {
  var_2 = var_1 gettagorigin("tag_origin");
  return (var_2[0], var_2[1], var_0._id_AD79._id_300E);
}

_id_575A(var_0, var_1) {
  var_0 _meth_8060();
}

_id_54B4(var_0) {
  var_0 endon("disconnect");
  var_0 endon("exit_overwatch");
  _id_AD95(var_0);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color_glitch", var_0, 0.25);
  wait 0.25;
  level notify("vision_set_change_request", "ac130_color", var_0, 0);
}

_id_575B(var_0) {
  var_0 endon("disconnect");
  var_0 endon("enter_overwatch");
  _id_AD95(var_0);
  level notify("vision_set_change_request", undefined, var_0, 0, "ac130_color");
  waitframe();
  level notify("vision_set_change_request", undefined, var_0, 0, "ac130_color_glitch");
}

_id_5211() {
  if(isDefined(level._id_F8FF)) {
    level._id_F8FF show();
  } else {
    var_0 = getEntArray("minimap_corner", "targetname");

    if(var_0.size) {
      var_1 = var_0[0].origin;
      var_2 = var_0[1].origin;
      var_3 = (0, 0, 0);
      var_3 = var_2 - var_1;
      var_3 = (var_3[0] / 2, var_3[1] / 2, var_3[2] / 2) + var_1;
      level._id_F901 = var_3;
    } else
      level._id_F901 = (0, 0, 0);

    level._id_F8FF = spawn("script_model", level._id_F901);
    level._id_F8FF setModel("tag_origin");
    level._id_F8FF.angles = (0, 115, 0);
    level._id_F8FF._id_0481 = "uavrig_script_model";
    level._id_F8FF thread _id_C929(70);
  }
}

_id_4A31() {
  if(isDefined(level._id_F8FF)) {
    level._id_F8FF hide();
  }
}

_id_C929(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  if(!isDefined(var_1)) {
    var_1 = -360;
  }

  for(;;) {
    self rotateyaw(var_1, var_0);
    wait(var_0);
  }
}

_id_4A66(var_0, var_1) {
  var_2 = _id_6816(var_0, var_1);
  var_2 makeunusable();
}

_id_5234(var_0, var_1) {
  var_2 = _id_6816(var_0, var_1);
  var_2 makeuseable();
  var_2._id_24C3 = 0;
}

_id_54C1(var_0, var_1, var_2) {
  _id_C13E(var_0, var_2);
  var_0._id_5770 = 1;
  var_0._id_E778 = 0;
  _id_B2B9(var_0, var_1, var_2);
  var_0 _id_54C2(var_0, var_2);
}

_id_B2B9(var_0, var_1, var_2) {
  var_3 = "viewhands_base_iw8";
  var_4 = _id_6740(var_2);
  var_5 = var_1 gettagorigin(var_4);
  var_6 = var_1 gettagangles(var_4);
  var_0._id_B5A4 = spawn("script_model", var_5);
  var_0._id_B5A4.angles = var_6;
  var_0._id_B5A4 linkto(var_1, var_4);
  var_0._id_B5A4 setModel(var_3);
  var_0._id_B5A4 hide();
  var_0 setstance("stand");
  var_0 _meth_868F();
  var_0 setplayerangles(var_0._id_B5A4.angles);
  var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 0, 120, 120, 120, 35, 1);
}

_id_F010() {
  if(!isDefined(self._id_B5A4)) {
    return;
  }
  self notify("technical_stopAnimatingPlayer");
  self._id_18AF = undefined;
  self._id_B5A4 delete();

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self _meth_8655();
  }

  self _meth_8690();
}

_id_6740(var_0) {
  var_1 = "tag_seat_0";

  switch (var_0) {
    case "driver":
      var_1 = "tag_seat_0";
      break;
    case "passenger":
      var_1 = "tag_seat_1";
      break;
    case "left_back_seat":
      var_1 = "tag_seat_2";
      break;
    case "right_back_seat":
      var_1 = "tag_seat_3";
      break;
  }

  return var_1;
}

_id_54C2(var_0, var_1) {
  for(var_2 = 0; var_2 <= var_0._id_1024C._id_B76C.size - 1; var_2++) {
    var_3 = var_0._id_1024C._id_B76C[var_2];
    var_4 = var_3 getentitynumber() + 1;
    var_1 = var_3._id_41A7;
    var_3 thread _id_54C3(var_3, var_4, var_1);
  }
}

_id_54C3(var_0, var_1, var_2) {
  var_3 = _id_673E(var_2);

  foreach(var_5 in level.players) {
    if(isDefined(var_5._id_1024C) && var_5._id_1024C == var_0._id_1024C) {
      var_6 = var_5._id_1024C;
      var_5 setclientomnvar(var_3, var_1 - 1);

      if(isDefined(var_6._id_58FA) && isDefined(var_6._id_9C1D)) {
        var_7 = int(clamp(var_6._id_58FA / var_6._id_9C1D * 100, 0, 100));
        var_5 setclientomnvar("ui_veh_health_percent", int(var_7));

        if(var_7 < 1 && var_7 > 0) {
          var_5 setclientomnvar("ui_veh_show_health", 1);
        } else {
          var_5 setclientomnvar("ui_veh_show_health", 0);
        }
      } else
        var_5 setclientomnvar("ui_veh_show_health", 0);
    }
  }
}

_id_673E(var_0) {
  var_1 = "ui_veh_occupant_0";

  switch (var_0) {
    case "driver":
      var_1 = "ui_veh_occupant_0";
      break;
    case "overwatch":
    case "passenger":
      var_1 = "ui_veh_occupant_1";
      break;
    case "left_back_seat":
    case "mine_drone_left":
    case "missile_defense_left":
    case "overwatch_left":
      var_1 = "ui_veh_occupant_2";
      break;
    case "mine_drone_right":
    case "right_back_seat":
    case "missile_defense_right":
    case "overwatch_right":
      var_1 = "ui_veh_occupant_3";
      break;
    case "grenadier":
    case "gunner":
      var_1 = "ui_veh_occupant_4";
      break;
  }

  return var_1;
}

_id_10A45() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");

    foreach(var_1 in level.players) {
      var_1 setclientomnvar("ui_hide_minimap", 1);
      var_1 scripts\cp\utility::_id_80FF();

      if(isDefined(var_1._id_1024C._id_B76C)) {
        _id_54C2(var_1);
        continue;
      }

      var_1 setclientomnvar("ui_veh_vehicle", -1);
    }
  }
}

_id_576A(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  var_0 setclientomnvar("ui_veh_vehicle", -1);
  var_4 = _id_673E(var_1);

  foreach(var_0 in level.players) {
    if(isDefined(var_0._id_1024C) && var_0._id_1024C == var_2) {
      var_0 setclientomnvar(var_4, -1);
    }
  }
}

_id_467D(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("player_exit_vehicle");
  waitframe();
  var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 0, 120, 120, 120, 120, 1);
}

_id_5767(var_0, var_1) {
  if(istrue(var_1) && !istrue(var_0._id_E778)) {
    var_0 _id_F010();
    var_0 unlink();
  }
}

_id_5768(var_0, var_1) {
  var_0._id_5770 = 0;
  var_0 notify("exit_" + var_0._id_41A7);
  var_0 _id_576A(var_0, var_0._id_41A7, var_1);
}

_id_5769(var_0) {
  var_0._id_5770 = 0;
  var_0._id_E778 = 1;
  var_0 notify("exit_" + var_0._id_41A7);
}

_id_C13E(var_0, var_1) {
  var_0._id_BC33 = var_0._id_41A7;
  var_0._id_41A7 = var_1;
}

_id_C785(var_0, var_1) {
  var_2 = _id_6816(var_1, var_0._id_BC33);
  var_2 notify("trigger", var_0);
  var_0 _id_54C2(var_0, var_0._id_BC33);
}

_id_5E65(var_0) {
  var_0 endon("disconnect");
  var_0 allowstand(1);
  var_0 allowprone(0);
  var_0 allowcrouch(0);
  wait 0.5;
  var_0 allowprone(1);
  var_0 allowcrouch(1);
}

_id_F70C(var_0, var_1, var_2) {
  if(istrue(var_0._id_5770)) {
    _id_576F(var_0, var_1, var_2);
  }
}

_id_54CA(var_0, var_1) {
  level notify("players_entered_vehicle");
  var_0 notify("player_enter_vehicle");
  var_0 setclientomnvar("ui_veh_vehicle", 10);
  var_0._id_1024C = var_1;
  var_0 disableoffhandprimaryweapons();
  var_0 disableoffhandsecondaryweapons();
  var_0 allowsprint(0);
  var_0 _meth_86CD(0);
  var_0 _id_0739::_id_D5B1(1);
  _id_104D(var_1, var_0);
  _id_104F(var_1, var_0);
  _id_FBE4(var_1);
  _id_C438(var_0, var_1);
  _id_FB5F(var_1);
}

_id_576F(var_0, var_1, var_2) {
  var_0 notify("player_exit_vehicle");
  var_0 _id_576A(var_0, var_2, var_1);
  var_0._id_1024C = undefined;
  var_0 _id_0739::_id_D5B1(0);
  _id_C3D5(var_1, var_0);
  _id_C3D7(var_1, var_0);
  _id_FBE4(var_1);
  var_0._id_41A7 = undefined;
  var_3 = _id_6491(var_0, var_1, var_2);
  var_0 setorigin(var_3, 1);
  var_0 _meth_846C(undefined);
  var_0 enableoffhandprimaryweapons();
  var_0 enableoffhandsecondaryweapons();
  var_0 allowsprint(1);
  var_0 _meth_86CD(1);
  var_0 thread _id_5E65(var_0);
  var_0 _id_66C8(var_0);
  _id_FB5F(var_1);

  if(_id_DA9F(var_1, var_2)) {
    _id_5234(var_1, var_2);
  }
}

_id_C438(var_0, var_1) {
  if(isDefined(var_1._id_BD96)) {
    var_0._id_BD97 = [];
    var_2 = var_0 getweaponslistprimaries();
    var_3 = var_0 getcurrentweapon();
    var_4 = scripts\engine\utility::array_contains(var_1._id_BD96, var_3.basename);

    foreach(var_6 in var_2) {
      if(isDefined(var_6.basename) && scripts\engine\utility::array_contains(var_1._id_BD96, var_6.basename)) {
        var_0._id_BD97[var_0._id_BD97.size] = var_6;
        var_0 takeweapon(var_6);
      }
    }

    if(istrue(var_4)) {
      var_0 switchtoweapon(var_0 getweaponslistprimaries()[0]);
    }
  }
}

_id_66C8(var_0) {
  var_1 = 0;

  if(isDefined(var_0._id_BD97)) {
    foreach(var_3 in var_0._id_BD97) {
      var_0 giveweapon(var_3);

      if(issubstr(var_3.basename, "riotshield")) {
        var_1 = 1;
      }
    }

    var_0._id_BD97 = undefined;
  }

  if(istrue(var_1)) {
    var_0 scripts\cp\cp_weapon::_id_C88B();
  }
}

_id_FBE4(var_0) {
  if(getdvarint("#x3b85a5165c468e77c", 0) != 0) {
    return;
  }
  if(!isDefined(var_0._id_A882)) {
    return;
  }
  foreach(var_2 in level.players) {
    if(scripts\engine\utility::array_contains(var_0._id_B76E, var_2)) {
      _func_0189(var_0._id_A882, var_2);
      continue;
    }

    _func_0185(var_0._id_A882, var_2);
  }

  _func_018C(var_0._id_A882);
}

_id_DA9F(var_0, var_1) {
  return 1;
}

_id_6491(var_0, var_1, var_2) {
  var_3 = _id_3F6A(var_2);
  var_4 = 0;
  var_2 = var_3[var_4];
  var_5 = _id_648E(var_0, var_1, var_2);
  var_6 = _id_648F(var_0, var_1, var_2);
  var_7 = vectornormalize(var_6);
  var_7 = var_7 * -5;
  var_8 = var_5.origin + var_6;
  var_9 = scripts\engine\trace::_id_3219(var_5.origin + var_7, var_8, 6, 80, undefined, var_1);
  var_10 = 1;

  if(distance2dsquared(var_9["position"], var_8) < 225) {
    if(abs(var_9["position"][2] - var_8[2]) < 25) {
      var_10 = 0;
    }

    if(!_func_02AE(var_9["position"])) {
      var_10 = 0;
    }
  }

  while(var_10 && var_4 < var_3.size) {
    var_2 = var_3[var_4];
    var_5 = _id_648E(var_0, var_1, var_2);

    if(isDefined(var_5)) {
      var_6 = _id_648F(var_0, var_1, var_2);
      var_7 = vectornormalize(var_6);
      var_7 = var_7 * -5;
      var_8 = var_5.origin + var_6;
      var_9 = scripts\engine\trace::_id_3219(var_5.origin + var_7, var_8, 6, 80, undefined, var_1);

      if(distance2dsquared(var_9["position"], var_8) < 225) {
        if(abs(var_9["position"][2] - var_8[2]) < 25) {
          var_10 = 0;
        }

        if(!_func_02AE(var_9["position"])) {
          var_10 = 0;
        }
      }
    }

    if(var_10) {
      var_4++;
    }

    waitframe();
  }

  if(var_4 >= var_3.size) {
    var_8 = var_1.origin + (0, 0, 100);
  }

  var_11 = scripts\engine\trace::_id_3219(var_8 + (0, 0, 0), var_8 + (0, 0, -256), 6, 80)["position"];
  return var_11;
}

_id_3F6A(var_0) {
  switch (var_0) {
    case "driver":
      return ["driver", "left_back_seat", "passenger", "right_back_seat"];
    case "passenger":
      return ["passenger", "right_back_seat", "driver", "left_back_seat"];
    case "left_back_seat":
      return ["left_back_seat", "driver", "right_back_seat", "passenger"];
    case "right_back_seat":
      return ["right_back_seat", "passenger", "left_back_seat", "driver"];
  }
}

_id_648E(var_0, var_1, var_2) {
  switch (var_2) {
    case "driver":
      return _id_6816(var_1, "driver");
    case "passenger":
      return _id_6816(var_1, "passenger");
    case "left_back_seat":
      return _id_6816(var_1, "left_back_seat");
    case "right_back_seat":
      return _id_6816(var_1, "right_back_seat");
  }
}

_id_648F(var_0, var_1, var_2) {
  var_3 = anglestoright(var_1.angles);
  var_4 = var_3 * -1;

  switch (var_2) {
    case "left_back_seat":
    case "driver":
      return var_4 * 50;
    case "right_back_seat":
    case "passenger":
      return var_3 * 50;
  }
}

_id_6816(var_0, var_1) {
  return var_0._id_10118[var_1];
}

_id_99D0(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin("tag_origin");
  var_5 = anglesToForward(var_0.angles);
  var_6 = anglestoright(var_0.angles);
  var_7 = anglestoup(var_0.angles);
  var_8 = var_4 + var_5 * var_1 + var_6 * var_2 + var_7 * var_3;
  var_9 = spawn("script_model", var_8);
  var_9 setModel("tag_origin");
  var_9.angles = var_0.angles;
  var_9.vehicle = var_0;
  var_9 linkto(var_0);
  var_9 thread _id_3837(var_9, var_0);
  return var_9;
}

_id_80FC(var_0, var_1) {
  var_0._id_7CE8 = var_1._id_7CE8;
  var_0._id_C549 = [];
  var_0._id_B76C = [];
  var_0._id_B76E = [];
  var_0._id_4A88 = 0;
  var_0._id_CCBB = 1;
  var_0._id_3804 = var_1._id_3804;
  var_0._id_DDFD = var_1._id_DDFD;
  var_0._id_59B9 = var_1._id_59B9;
  var_0._id_F4FA = var_1._id_F4FA;
  var_0._id_BD96 = var_1._id_BD96;
}

_id_1005E(var_0, var_1) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 999999;
  var_0._id_9C1D = var_1._id_58FA;
  var_0._id_58FA = var_1._id_58FA;
  var_0._id_F59C = int(var_0._id_58FA * var_1._id_DC30);
  var_0._id_DCB6 = 0;
  var_0._id_4A8A = 0;

  for(;;) {
    var_0 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    var_0.health = 999999;

    if(_id_85DB(var_3, var_11)) {
      var_0 thread _id_9D5D(var_0, var_5, var_6);
      continue;
    }

    if(isDefined(var_2)) {
      if(isDefined(var_11)) {
        var_2 = _id_1191(var_2, var_11, var_0);
      }

      var_0._id_58FA = var_0._id_58FA - var_2;
      var_12 = int(clamp(var_0._id_58FA / var_1._id_58FA * 100, 0, 100));

      foreach(var_14 in level.players) {
        if(isDefined(var_14._id_1024C) && var_14._id_1024C == var_0) {
          var_14 setclientomnvar("ui_veh_health_percent", int(var_12));
          var_14 setclientomnvar("ui_veh_show_health", 1);
        }
      }

      if(var_0._id_58FA < 0 && !istrue(var_0._id_4A8A)) {
        _id_4B03(var_0);
      } else if(var_0._id_58FA < var_0._id_F59C) {
        _id_DC7A(var_0);
      }
    }
  }
}

_id_1191(var_0, var_1, var_2) {
  if(isDefined(var_1.basename) && (var_1.basename == "juliet_missile_cp" || var_1.basename == "rpg_missile_cp" || var_1.basename == "cruise_missile_warhead_cp")) {
    return var_2._id_58FA + 100;
  }

  return var_0;
}

_id_85DB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isPlayer(var_0)) {
    return 1;
  }

  if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
    return 1;
  }

  if(isDefined(var_1) && isDefined(var_1.basename) && var_1.basename == "overwatch_missile_cp") {
    return 1;
  }

  return 0;
}

_id_9D5D(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 == "MOD_MELEE" && var_0._id_B76C.size == 0) {
    var_3 = (var_1 + var_0.origin) / 2 - (0, 0, 40);
    physicsexplosionsphere(var_3, 3, 2, 4);
  }
}

_id_DC7A(var_0) {
  if(istrue(var_0._id_DCB6)) {
    return;
  }
  var_0._id_DCB6 = 1;
  var_1 = _id_6816(var_0, "hood_repair");
  var_1 thread _id_B2FA(var_0, "tag_grill", "vehicle_hood_damage_smoke", var_1, anglesToForward(var_0.angles));
}

_id_4B03(var_0) {
  var_0._id_4A8A = 1;
  var_0._id_4A88 = 1;
  _id_FB5F(var_0);
  level notify("vehicle_needs_repair");
  var_1 = _id_6816(var_0, "hood_repair");
  _id_BE60(var_0, var_1);
  _id_D388("hood_repair", 1);
  var_1 thread _id_B2FA(var_0, "tag_light_front_right_2", "vehicle_hood_damage_smoke", var_1, anglesToForward(var_0.angles));
  var_1 thread _id_B2FA(var_0, "tag_light_front_left_2", "vehicle_hood_damage_smoke", var_1, anglesToForward(var_0.angles));
  _id_5E4A(var_0);
  _id_DC7A(var_0);
  _id_5234(var_0, "hood_repair");
  var_1 = _id_6816(var_0, "hood_repair");
  _id_105D(var_0, var_1);
}

_id_D412(var_0, var_1) {
  var_2 = var_0.angles;
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2);
  var_6 = var_0 gettagorigin("tag_origin");
  var_0._id_10118 = [];

  foreach(var_11, var_8 in var_1._id_8384) {
    var_9 = var_6 + var_3 * var_8._id_5FD0 + var_4 * var_8._id_C84B + var_5 * var_8._id_FB2D;
    var_10 = spawn("script_model", var_9);
    var_10 setModel("tag_origin");
    var_10 linkto(var_0);
    var_8 = _id_6815(var_11);
    var_10 sethintstring(var_8._id_7976);
    var_10 setcursorhint("HINT_BUTTON");
    var_10 _meth_84D4(var_8._id_4B6D);
    var_10 sethintdisplayfov(var_8._id_4B5A);
    var_10 setuserange(var_8._id_FDF4);
    var_10 setusefov(var_8._id_FDD9);
    var_10 _meth_84D9("hide");
    var_10 setuseholdduration(var_8._id_FDDF);
    var_10 thread _id_FE0F(var_11, var_10, var_0, var_8._id_F734, var_8._id_E663, var_8._id_576E, var_8._id_5738, var_8._id_1F8B);
    var_0._id_10118[var_11] = var_10;
  }
}

_id_D409(var_0, var_1) {
  var_0._id_7CE9 = var_1._id_7CE9;
}

_id_FE0F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_2 endon("death");
  var_8 = "exit_" + var_0;

  if(istrue(var_7)) {
    var_1 makeuseable();
  }

  var_1._id_24C3 = 0;

  for(;;) {
    var_1 waittill("trigger", var_9);

    if(isDefined(var_3) && ![[var_3]](var_2, var_9)) {
      continue;
    }
    if(isDefined(var_6)) {
      var_9 notifyonplayercommand(var_8, var_6);
    }

    var_1 makeunusable();
    var_1._id_24C3 = 1;
    var_1 thread[[var_4]](var_1, var_9, var_2);

    if(isDefined(var_6)) {
      var_10 = var_9 scripts\engine\utility::_id_1088C(var_9, "disconnect", var_9, var_8, var_1, "interaction_point_disabled", var_9, "last_stand", var_9, "force_player_exit_vehicle", var_9, "force_player_exit_seat");
    } else {
      var_10 = var_9 scripts\engine\utility::_id_1088C(var_9, "disconnect", var_1, "interaction_point_disabled", var_9, "last_stand", var_9, "repair_failed", var_9, "force_player_exit_vehicle", var_9, "force_player_exit_seat");
    }

    if(isDefined(var_5)) {
      var_1 thread[[var_5]](var_1, var_9, var_2, var_10);
    }
  }
}

_id_C22E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = spawnStruct();
  var_12._id_7976 = var_1;
  var_12._id_F734 = var_2;
  var_12._id_E663 = var_3;
  var_12._id_576E = var_4;
  var_12._id_5738 = var_5;
  var_12._id_4B6D = var_6;
  var_12._id_4B5A = var_7;
  var_12._id_FDF4 = var_8;
  var_12._id_FDD9 = var_9;
  var_12._id_FDDF = var_10;
  var_12._id_1F8B = var_11;
  level._id_10117[var_0] = var_12;
}

_id_6815(var_0) {
  return level._id_10117[var_0];
}

_id_1D11(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_5FD0 = var_1;
  var_5._id_C84B = var_2;
  var_5._id_FB2D = var_3;
  var_4[var_0] = var_5;
  return var_4;
}

_id_4458(var_0) {
  for(;;) {
    waitframe();
  }
}

_id_0F8E(var_0, var_1) {
  if(isDefined(var_1._id_0F8F)) {
    level thread[[var_1._id_0F8F]](var_0);
  }
}

_id_D406(var_0) {
  var_0._id_58EE = _id_99A2(var_0, "tag_seat_3", 1);
  var_0._id_58ED = _id_99A2(var_0, "tag_seat_2", 1);
}

#using_animtree("script_model");

_id_99A2(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawn("script_model", var_4, 0, 1);
  var_5 setModel("fullbody_hero_price_urban");
  var_5.angles = var_0.angles;
  var_5 useanimtree(#animtree);

  if(isDefined(var_3)) {
    var_5 linkto(var_0, var_1, var_3, (0, 0, 0));
  } else {
    var_5 linkto(var_0, var_1);
  }

  var_5 thread _id_58F3(var_5);
  var_5 thread _id_3837(var_5, var_0);

  if(istrue(var_2)) {
    var_5 hide();
  }

  return var_5;
}

_id_3837(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

_id_58F3(var_0) {
  var_0 endon("death");
  var_1 = 17.5;
  wait(randomfloatrange(0.5, 3.5));

  for(;;) {
    var_0 _meth_82CB(%mp_infil_lbravo_a_pilot);
    wait(var_1);
  }
}

_id_AD95(var_0) {
  if(!isDefined(var_0._id_AD9B)) {
    var_0._id_AD9B = newclienthudelem(var_0);
    var_0._id_AD9B.x = 0;
    var_0._id_AD9B.y = 0;
    var_0._id_AD9B setshader("black", 640, 480);
    var_0._id_AD9B.alignx = "left";
    var_0._id_AD9B.aligny = "top";
    var_0._id_AD9B.sort = 1;
    var_0._id_AD9B.horzalign = "fullscreen";
    var_0._id_AD9B.vertalign = "fullscreen";
    var_0._id_AD9B._id_01D6 = 1;
  }

  var_0._id_AD9B.alpha = 1;
  var_0._id_AD9B fadeovertime(0.25);
  var_0._id_AD9B.alpha = 0;
}

_id_D40A() {
  level._id_F94A = [];
  level._id_7C91 = [];

  if(!_id_7CDB()) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray("IED_controller", "script_noteworthy");

  foreach(var_2 in var_0) {
    _id_E167(var_2);
    waitframe();
  }
}

_id_E167(var_0) {
  if(!_id_DADA(var_0)) {
    return;
  }
  var_0._id_7C90 = 0;
  var_1 = _id_65FD(var_0);

  if(isDefined(var_0.target)) {
    var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  } else {
    var_2 = [];
  }

  if(var_2.size > 0) {
    for(var_3 = 0; var_3 < 5; var_3++) {
      var_2 = scripts\engine\utility::array_randomize(var_2);
    }

    for(var_4 = 0; var_4 < var_1; var_4++) {
      _id_E166(var_2[var_4], var_0);
    }
  } else if(var_2.size == 0 && var_1 > 0) {
    if(!isDefined(level._id_7CEA)) {
      level._id_7CEA = 0;
    }

    var_5 = "IED_auto_group_" + level._id_7CEA;
    var_0.target = var_5;
    level._id_7CEA++;
    var_6 = 256;

    if(isDefined(var_0._id_0359)) {
      var_6 = var_0._id_0359;
    }

    if(var_6 < 20) {
      var_6 = 20;
    }

    var_7 = var_6 * 0.1;

    for(var_3 = 0; var_3 < var_1; var_3++) {
      var_8 = randomfloatrange(var_7, var_6);
      var_9 = randomfloatrange(var_7, var_6);

      if(scripts\engine\utility::cointoss()) {
        var_8 = var_8 * -1;
      }

      if(scripts\engine\utility::cointoss()) {
        var_9 = var_9 * -1;
      }

      var_10 = (var_8, var_9, 0);
      var_11 = spawnStruct();
      var_11.origin = var_0.origin + var_10;
      var_11.origin = scripts\engine\utility::_id_5000(var_11.origin);

      if(isDefined(var_0._id_CD99) && var_0._id_CD99 != "") {
        var_11._id_CE18 = var_0._id_CD99;
        var_11.angles = (0, randomfloat(360), 0);
        var_11.origin = var_11.origin + (0, 0, 2);
      } else {
        var_11._id_CE18 = "bomb_homemade_jug_01";
        var_11.angles = (randomfloat(360), randomfloat(360), randomfloat(360));
      }

      var_11._id_0481 = var_5;
      _id_E166(var_11, var_0);
    }
  }

  var_0 thread _id_7CD9(var_0);
}

_id_DADA(var_0) {
  var_1 = 1;

  if(getdvarfloat("#x3c8a6ec05d79aeb46", 0) != 0) {
    var_1 = getdvarfloat("#x3c8a6ec05d79aeb46");
  }

  return randomfloat(1) < var_1;
}

_id_65FD(var_0) {
  if(isDefined(var_0._id_CE18)) {
    return int(var_0._id_CE18);
  } else {
    return scripts\engine\utility::getStructArray(var_0.target, "targetname").size;
  }
}

_id_E166(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel(var_0._id_CE18);
  var_2.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_2.target = var_0.target;
  var_2._id_7CD8 = var_1;
  var_2._id_0026 = 0;
  var_3 = anglestoup(var_2.angles);
  var_2._id_338D = var_2.origin + var_3 * 10;
  _id_105B(var_2);
  var_2 thread _id_7CDA(var_2);
  var_2 thread _id_7CE3(var_2);
}

_id_7CDA(var_0) {
  var_0 endon("IED_exploded");
  var_0 setCanDamage(1);
  var_0.health = 999999;

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    var_0.health = 999999;

    if(isDefined(var_2) && isPlayer(var_2) || isDefined(var_2.owner) && isPlayer(var_2.owner) || isDefined(var_10) && var_10.basename == "overwatch_missile_cp") {
      _id_7CDC(var_0);
    }
  }
}

_id_7CD9(var_0) {
  for(;;) {
    if(!isDefined(scripts\engine\utility::_id_6969(var_0.origin, level.players, 1024))) {
      _id_437E(var_0);
    } else {
      _id_0EBE(var_0);
    }

    wait 0.25;
  }
}

_id_437E(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2]._id_7CD8) && istrue(var_1[var_2]._id_0026)) {
      var_1[var_2] notify("IED_trigger_monitor");
      var_1[var_2]._id_0026 = 0;
    }
  }
}

_id_0EBE(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2]._id_7CD8) && !istrue(var_1[var_2]._id_0026)) {
      var_1[var_2]._id_0026 = 1;
      var_1[var_2] thread _id_7CE3(var_1[var_2]);
    }
  }
}

_id_7CE3(var_0) {
  var_0 notify("IED_trigger_monitor");
  var_0 endon("IED_trigger_monitor");
  var_0 endon("IED_exploded");

  for(;;) {
    if(_id_7CE1(var_0)) {
      _id_7CDC(var_0);
    }

    wait 0.1;
  }
}

_id_7CE1(var_0) {
  if(_id_7CE5(var_0)) {
    return 1;
  }

  if(_id_7CE6(var_0)) {
    return 1;
  }

  return 0;
}

_id_7CDC(var_0, var_1) {
  earthquake(0.5, 1.2, var_0.origin, 400);
  playFX(level._effect["IED_explosion"], var_0.origin);
  playsoundatpos(var_0.origin, "frag_grenade_expl_trans");

  if(isDefined(var_0._id_AD9A)) {
    _id_079B::_id_EEE2(var_0, var_0 getentitynumber(), var_0._id_AD9A);
  }

  _id_C3DF(var_0);
  _id_C3CB(var_0);
  _id_C3F2(var_0);
  _id_9B1A(var_0);
  level thread _id_4681(var_0);
  _id_42CE(var_0, 100, 6400);
  _id_42CD(var_0, 9216);
  _id_42CF(var_0, 1600);
  _id_D0B0(var_0);
  _id_4716(var_0);
  _id_4C0E(var_0);
  var_0 delete();
  var_0 notify("IED_exploded");
}

_id_C3DE(var_0) {
  if(isDefined(var_0._id_EE7F)) {
    foreach(var_2 in var_0._id_EE7F) {
      _id_079B::_id_EEE2(var_0, var_2);
    }
  }
}

_id_4C0E(var_0) {
  if(isDefined(level._id_7CDD)) {
    level thread[[level._id_7CDD]](var_0);
  }
}

_id_4716(var_0) {
  if(!isDefined(var_0._id_7CDF)) {
    return;
  }
  foreach(var_2 in var_0._id_7CDF) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_D0B0(var_0) {
  var_1 = var_0._id_7CD8;

  if(isDefined(var_1._id_722E)) {
    level notify(var_1._id_722E);
  }
}

_id_D254(var_0) {
  var_1 = var_0._id_7CD8;

  if(isDefined(var_1._id_CE41)) {
    if(!scripts\engine\utility::_id_5C0C(var_1._id_CE41)) {
      scripts\engine\utility::_id_5C11(var_1._id_CE41);
    }

    scripts\engine\utility::_id_5C1B(var_1._id_CE41);
  }
}

_id_7CE6(var_0) {
  for(var_1 = 0; var_1 < level._id_102C7.size; var_1++) {
    if(isDefined(level._id_102C7[var_1]._id_F93C) && var_0 istouching(level._id_102C7[var_1]._id_F93C)) {
      return 1;
    }
  }

  if(isDefined(level._id_7CE4)) {
    return [[level._id_7CE4]](var_0);
  }

  return 0;
}

_id_7CE5(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(istrue(level.players[var_1]._id_2039)) {
      continue;
    }
    if(isDefined(level._id_B51D) && [[level._id_B51D]](level.players[var_1])) {
      continue;
    }
    if(distancesquared(level.players[var_1].origin, var_0._id_338D) < 1600) {
      return 1;
    }
  }

  return 0;
}

_id_105E(var_0) {
  if(!isDefined(level._id_102C7)) {
    level._id_102C7 = [];
  }

  level._id_102C7 = scripts\engine\utility::array_add(level._id_102C7, var_0);
}

_id_42CE(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) < var_2) {
      var_4 dodamage(var_1, var_0.origin);
    }
  }
}

_id_42CD(var_0, var_1) {
  if(!isDefined(level._id_FFEC)) {
    level._id_FFEC = makeweapon("at_mine_ap_mp");
  }

  var_0.team = "axis";

  foreach(var_3 in level._id_F014) {
    if(!isent(var_3)) {
      continue;
    }
    if(distancesquared(var_3.origin, var_0.origin) < var_1) {
      var_3 dodamage(800, var_0.origin, var_0, var_0, "MOD_SUICIDE", level._id_FFEC);
    }
  }
}

_id_42CF(var_0, var_1) {
  var_2 = _id_65CB(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4.vehicle;
    var_6 = var_4._id_7CE7;
    var_7 = _id_66FA(var_6);
    var_8 = _id_6816(var_5, var_7);
    _id_F709(var_5, var_6, var_0.origin, var_7, var_8);
  }
}

_id_F709(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::array_contains(var_0._id_C549, var_4)) {
    level thread _id_4BEB(var_2, var_0._id_B76C);
    _id_5234(var_0, var_3);
    var_5 = var_0._id_7CE8[var_1];
    var_4._id_C54B = var_5;
    _id_105D(var_0, var_4, var_5);
    _id_BE60(var_0, var_4);
    var_4 thread _id_B2FA(var_0, var_5, _id_64A3(var_5), var_4, anglesToForward(var_0.angles));
    var_0._id_4A88 = 1;
    _id_FB5F(var_0);
    level notify("vehicle_needs_repair");
    _id_5E4A(var_0);
  }
}

_id_FB5F(var_0) {
  var_1 = _id_6816(var_0, "driver");
  var_1 sethintstring(_id_6464(var_0));
}

_id_6464(var_0) {
  if(istrue(var_0._id_4A88)) {
    return &"CP_VEHICLE_TRAVEL/REPAIR_FIRST";
  } else if(isDefined(level._id_6812)) {
    return [[level._id_6812]](var_0);
  } else {
    return &"CP_VEHICLE_TRAVEL/DRIVER";
  }
}

_id_64A3(var_0) {
  if(issubstr(var_0, "left")) {
    return "vehicle_tire_damage_smoke_left";
  } else {
    return "vehicle_tire_damage_smoke_right";
  }
}

_id_5E4A(var_0) {
  var_1 = _id_6816(var_0, "driver");
  var_1 notify("interaction_point_disabled");
}

_id_4BEB(var_0, var_1) {
  waitframe();

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && !_id_073B::_id_B4EF(var_3)) {
      var_3 dodamage(20, var_0);
    }
  }
}

_id_66FA(var_0) {
  switch (var_0) {
    case "tag_wheel_back_left":
      return "back_left_repair";
    case "tag_wheel_back_right":
      return "back_right_repair";
    case "tag_wheel_front_left":
      return "front_left_repair";
    case "tag_wheel_front_right":
      return "front_right_repair";
  }
}

_id_105D(var_0, var_1, var_2) {
  if(!scripts\engine\utility::array_contains(var_0._id_C549, var_1)) {
    var_0._id_C549 = scripts\engine\utility::array_add(var_0._id_C549, var_1);

    if(isDefined(var_2)) {
      _id_D388(var_2, 1);
    }
  }
}

_id_C3E1(var_0, var_1, var_2) {
  if(scripts\engine\utility::array_contains(var_0._id_C549, var_1)) {
    var_0._id_C549 = scripts\engine\utility::array_remove(var_0._id_C549, var_1);

    if(isDefined(var_2)) {
      _id_D388(var_2, 0);
    }
  }
}

_id_D388(var_0, var_1) {
  var_2 = "cp_vehicle_damage_1";

  switch (var_0) {
    case "tag_wheel_center_front_left":
      var_2 = "cp_vehicle_damage_1";
      break;
    case "tag_wheel_center_front_right":
      var_2 = "cp_vehicle_damage_2";
      break;
    case "tag_wheel_center_back_left":
      var_2 = "cp_vehicle_damage_3";
      break;
    case "tag_wheel_center_back_right":
      var_2 = "cp_vehicle_damage_4";
      break;
    case "hood_repair":
      var_2 = "cp_vehicle_damage_5";
      break;
  }

  if(istrue(var_1)) {
    var_3 = 1;
  } else {
    var_3 = 0;
  }

  foreach(var_5 in level.players) {
    var_5 setclientomnvar(var_2, var_3);
  }
}

_id_1476(var_0) {
  if(var_0._id_C549.size == 0) {
    return 1;
  } else if(var_0._id_C549.size == 1) {
    if(!var_0._id_4A8A && var_0._id_C549[0] == var_0._id_10118["hood_repair"]) {
      return 1;
    }
  }

  return 0;
}

_id_104D(var_0, var_1) {
  var_1._id_2039 = 1;

  if(!scripts\engine\utility::array_contains(var_0._id_B76C, var_1)) {
    var_0._id_B76C = scripts\engine\utility::array_add(var_0._id_B76C, var_1);
  }
}

_id_C3D5(var_0, var_1) {
  var_1._id_2039 = 0;

  if(scripts\engine\utility::array_contains(var_0._id_B76C, var_1)) {
    var_0._id_B76C = scripts\engine\utility::array_remove(var_0._id_B76C, var_1);
  }
}

_id_104F(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(var_0._id_B76E, var_1)) {
    var_0._id_B76E = scripts\engine\utility::array_add(var_0._id_B76E, var_1);
  }
}

_id_C3D7(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_0._id_B76E, var_1)) {
    var_0._id_B76E = scripts\engine\utility::array_remove(var_0._id_B76E, var_1);
  }
}

_id_B4F5(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1._id_B76C, var_0);
}

_id_65CB(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_102C7) {
    if(isDefined(var_4._id_7CE9)) {
      foreach(var_6 in var_4._id_7CE9) {
        if(distancesquared(var_4 gettagorigin(var_6), var_0.origin) < var_1 && !scripts\engine\utility::array_contains(var_2, var_4)) {
          var_7 = spawnStruct();
          var_7.vehicle = var_4;
          var_7._id_7CE7 = var_6;
          var_2 = scripts\engine\utility::array_add(var_2, var_7);
        }
      }
    }
  }

  return var_2;
}

_id_B2FA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 gettagorigin(var_1);
  var_6 = spawn("script_model", var_5);
  var_6 setModel("tag_origin");
  var_6.angles = vectortoangles(var_4);
  var_6 linkto(var_0);
  wait 0.1;
  playFXOnTag(level._effect[var_2], var_6, "tag_origin");
  scripts\engine\utility::_id_10888(var_0, "death", var_3, "interaction_point_disabled");
  stopFXOnTag(level._effect[var_2], var_6, "tag_origin");
  var_6 delete();
}

_id_BE60(var_0, var_1) {
  var_2 = _id_0748::_id_C583("repair_icon", 21);
  _func_0172(var_2, 0);
  _func_017A(var_2, 1);
  _func_016B(var_2, "invisible");
  _func_015D(var_2, "cp_tac_hud_icon_repair");
  _func_0167(var_2, "");
  _func_0160(var_2, var_1);
  _func_0188(var_2);
  var_1._id_A882 = var_2;
  var_1 thread _id_C548(var_0, var_1, var_2);
}

_id_C548(var_0, var_1, var_2) {
  scripts\engine\utility::_id_10888(var_0, "death", var_1, "interaction_point_disabled");
  _func_015C(var_2);
  _id_0748::_id_5F56("repair_icon");
}

_id_4681(var_0) {
  level endon("game_ended");
  var_1 = var_0._id_7CD8;
  wait(randomfloatrange(600, 900));

  for(;;) {
    if(_id_30EA(var_1)) {
      _id_E167(var_1);
      return;
    }

    wait 15;
  }
}

_id_30EA(var_0) {
  foreach(var_2 in level.players) {
    if(distance2dsquared(var_2.origin, var_0.origin) < 250000) {
      return 0;
    }

    if(isDefined(var_2._id_AD79) && distance2dsquared(var_2._id_AD79.origin, var_0.origin) < 1000000) {
      return 0;
    }
  }

  return 1;
}

_id_C3F2(var_0) {
  if(isDefined(var_0._id_9B4E)) {
    var_0._id_9B4E delete();
  }

  if(isDefined(var_0._id_9EC1)) {
    var_0._id_9EC1 delete();
  }
}

_id_DC50(var_0) {
  if(!_id_7CDB()) {
    return;
  }
  _id_DC4D(var_0);
}

_id_7CDB() {
  return getdvarint("#x3ba178da96ed96427", 0) != 0;
}

_id_DC4D(var_0) {
  if(!isDefined(level._id_7C91)) {
    return;
  }
  level._id_7C91 = scripts\engine\utility::_id_1BD1(level._id_7C91);

  if(level._id_7C91.size > 0) {
    var_0._id_AD9A = _id_079B::_id_EEDF("ieddronetarget", var_0, level._id_7C91, var_0);
  }
}

_id_DC4C(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.origin)) {
    if(isDefined(var_1._id_AD9A)) {
      _id_73F9(var_1);
      _id_079B::_id_EEDC(var_0, var_1._id_AD9A);
      _id_FBD6(var_0, var_1._id_AD9A);
    } else
      var_1._id_AD9A = _id_079B::_id_EEDF("ieddronetarget", var_1, var_0, var_1);

    var_0._id_AD9A = var_1._id_AD9A;
  }
}

_id_FBD6(var_0, var_1) {
  if(!isDefined(var_0._id_EE7F)) {
    var_0._id_EE7F = [];
  }

  if(!scripts\engine\utility::array_contains(var_0._id_EE7F, var_1)) {
    var_0._id_EE7F = scripts\engine\utility::array_add(var_0._id_EE7F, var_1);
  }
}

_id_A1D2(var_0) {
  level endon("game_ended");
  var_0 endon("exit_overwatch");
  var_0 endon("disconnect");
  var_1 = 100;
  var_2 = var_1 * var_1;
  var_3 = 1500;
  var_4 = var_3 * var_3;
  var_5 = var_0._id_AD9A;
  var_6 = undefined;

  if(isDefined(var_5)) {
    var_6 = _id_079B::_id_6DBF(var_5);
  }

  while(!isDefined(var_5) || !isDefined(var_6)) {
    var_5 = var_0._id_AD9A;

    if(isDefined(var_5)) {
      var_6 = _id_079B::_id_6DBF(var_5);
    }

    wait 0.1;
  }

  for(;;) {
    var_7 = var_0._id_AD79.origin;
    wait 0.1;
    var_8 = var_0._id_AD79.origin;

    if(distance2dsquared(var_7, var_8) > var_2) {
      for(var_9 = 0; var_9 < level._id_7C91.size; var_9++) {
        if(distance2dsquared(level._id_7C91[var_9].origin, var_8) < var_4) {
          var_10 = level._id_7C91[var_9] getentitynumber();

          if(!isDefined(var_6._id_9B3A[var_10])) {
            _id_73F9(var_0);
            _id_079B::_id_EEDC(level._id_7C91[var_9], var_5);
          }
        }
      }
    }
  }
}

_id_73F9(var_0) {
  var_1 = var_0._id_AD9A;

  if(isDefined(var_1)) {
    var_2 = _id_079B::_id_6DBF(var_1);

    if(var_2._id_9B3A.size > 18) {
      var_3 = var_0._id_AD79.origin;
      _id_78AF(var_3, var_1, level._id_7C91);
    }
  }
}

_id_78AF(var_0, var_1, var_2) {
  var_3 = _id_079B::_id_6DBF(var_1);
  var_4 = _func_0204(var_2, var_0);
  var_5 = 1;

  for(var_6 = var_4.size - 1; var_6 > 0; var_6--) {
    if(!var_5) {
      break;
    }

    if(isent(var_4[var_6])) {
      var_7 = var_4[var_6] getentitynumber();

      if(isDefined(var_3._id_9B3A[var_7])) {
        _id_079B::_id_EEE2(var_4[var_6], var_1);
        var_5 = 0;
      }
    }
  }
}

_id_DC4B(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.origin)) {
    var_0 _meth_81B0("outlinefill_depth_red");
  }
}

_id_DC57(var_0, var_1) {
  if(!isDefined(var_1._id_7CDF)) {
    var_1._id_7CDF = [];
  }

  var_2 = _func_020D(level._effect["IED_marker_to_non_overwatch"], var_0.origin, var_1);
  triggerfx(var_2);
  var_1._id_7CDF[var_1._id_7CDF.size] = var_2;
  var_0._id_7CDF[var_0._id_7CDF.size] = var_2;
}

_id_4727(var_0) {
  if(!isDefined(var_0._id_7CDF)) {
    return;
  }
  foreach(var_2 in var_0._id_7CDF) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_DC1E(var_0) {
  foreach(var_2 in level._id_7C91) {
    _id_DC57(var_2, var_0);
  }
}

_id_78BB(var_0) {
  if(isDefined(var_0._id_AD9A)) {
    _id_079B::_id_EEDE(var_0._id_AD9A);
    var_0._id_AD9A = undefined;
  }
}

_id_105B(var_0) {
  if(!scripts\engine\utility::array_contains(level._id_F94A, var_0)) {
    level._id_F94A = scripts\engine\utility::array_add(level._id_F94A, var_0);
  }
}

_id_C3DF(var_0) {
  level._id_F94A = scripts\engine\utility::array_remove(level._id_F94A, var_0);
}

_id_1040(var_0) {
  if(!scripts\engine\utility::array_contains(level._id_7C91, var_0)) {
    level._id_7C91 = scripts\engine\utility::array_add(level._id_7C91, var_0);
  }
}

_id_85F8(var_0) {
  return scripts\engine\utility::array_contains(level._id_7C91, var_0);
}

_id_C3CB(var_0) {
  level._id_7C91 = scripts\engine\utility::array_remove(level._id_7C91, var_0);
}

_id_7A70() {
  level endon("game_ended");
  level endon("stop_hostage_vehicle_monitor");

  for(;;) {
    level waittill("player_picked_up_hostage", var_0);

    while(!isDefined(level._id_102C7)) {
      wait 1;
    }

    var_0 thread _id_32C0(var_0);
  }
}

_id_32C0(var_0) {
  var_0 endon("disconnect");
  var_0 endon("hostage_dropped_by_me");
  var_0 endon("dropped_hostage");

  for(;;) {
    var_1 = _id_63FD(var_0, 200);

    if(isDefined(var_1)) {
      if(_id_74F6(var_1)) {
        var_0._id_7A58 = undefined;
        var_0._id_7A89._id_AD52 = undefined;
      } else {
        var_2 = _id_63FB(var_0, var_1);
        var_3 = var_1 gettagorigin("tag_origin");
        var_4 = var_1.angles;
        var_5 = anglesToForward(var_4);
        var_6 = anglestoright(var_4);
        var_7 = anglestoup(var_4);
        var_8 = var_3 + var_5 * -92 + var_6 * 0 + var_7 * 50;
        var_9 = distance(var_0.origin, var_8) < 100;

        if(var_9) {
          var_0._id_7A58 = _id_99A5(var_1, var_2, var_0);
          var_0._id_7A89._id_AD52 = "enter_vehicle_with_hostage";
        } else {
          var_0._id_7A58 = undefined;
          var_0._id_7A89._id_AD52 = undefined;
        }
      }
    } else
      var_0._id_7A58 = undefined;

    waitframe();
  }
}

_id_63FB(var_0, var_1) {
  var_2 = ["driver", "passenger", "left_back_seat", "right_back_seat"];
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = _id_6816(var_1, var_5);

    if(istrue(var_6._id_24C3)) {
      continue;
    }
    var_3[var_3.size] = var_6;
  }

  if(var_3.size > 0) {
    return scripts\engine\utility::_id_6969(var_0.origin, var_3);
  } else {
    return undefined;
  }
}

_id_63FD(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 100;
  }

  var_2 = scripts\engine\utility::_id_6969(var_0.origin, level._id_102C7, var_1);
  return var_2;
}

_id_99A5(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;
  var_5 = -60;
  var_6 = anglesToForward(var_0.angles);
  var_7 = anglestoup(var_0.angles);
  var_8 = anglestoright(var_0.angles);
  var_9 = spawnStruct();
  var_9.vehicle = var_0;
  var_9._id_100A1 = var_1;
  var_9.player = var_2;
  var_9._id_033E = var_0 gettagorigin("tag_origin") + var_6 * var_5 + var_7 * var_3 + var_8 * var_4;
  var_9._id_10971 = 0.05;
  var_9._id_5EB8 = 1;
  var_9._id_BC1E = 0;
  var_9._id_2F0C = ::_id_7A57;
  return var_9;
}

_id_7A57(var_0, var_1) {
  var_2 = var_1._id_100A1;
  var_3 = var_1.player;
  var_4 = var_1.vehicle;
  var_3 scripts\cp\utility::_id_7970("enter_vehicle_with_hostage", 0);
  var_0 makeunusable();
  var_0.angles = (var_0.angles[0], var_4.angles[1] + 180, var_0.angles[2]);
  var_0 linkto(var_4);

  if(isDefined(var_0._id_10CBF)) {
    _func_015C(var_0._id_10CBF);
  }

  var_4._id_7A40 = var_0;
  var_0._id_32BA = 1;
  var_0 notify("placed_into_player_vehicle");
  wait 2;
  _id_5234(var_4, "retrieve_hostage");
}

_id_74F6(var_0) {
  return isDefined(var_0._id_7A40);
}

_id_F4FB(var_0) {
  if(!_id_F4F9(var_0)) {
    return;
  }
  foreach(var_2 in var_0._id_F4FA) {
    var_0 thread _id_B2F3(var_0, var_2);
  }
}

_id_B2F3(var_0, var_1) {
  var_0 endon("death");

  for(;;) {
    var_2 = _id_6778(var_0);

    if(_id_DABF(var_2)) {
      var_3 = _id_67E5(var_0, var_1, var_2);

      if(isDefined(var_3)) {
        _id_B293(var_0, var_1, var_3);
      }
    }

    wait 0.1;
  }
}

_id_67E5(var_0, var_1, var_2) {
  var_3 = var_0 gettagorigin(var_1);
  var_4 = scripts\engine\trace::ray_trace(var_3 + (0, 0, 20), var_3 + (0, 0, -50), var_0, undefined, 1);

  if(var_4["fraction"] == 1) {
    return undefined;
  }

  var_5 = spawnStruct();
  var_6 = _id_5A43(var_4["surfacetype"], var_2, var_0);
  var_5._id_EBCA = var_6 + "_" + var_2;
  var_5._id_3BB9 = var_4["position"];
  return var_5;
}

_id_5A43(var_0, var_1, var_2) {
  var_3 = var_0 + "_" + var_1;
  var_4 = var_2 _id_06E9::_id_6810();

  if(isDefined(level.vehicle._id_F078._id_EBC9[var_4][var_3])) {
    return var_0;
  } else {
    return "default";
  }
}

_id_DABF(var_0) {
  if(var_0 == "stop") {
    return 0;
  }

  return 1;
}

_id_6778(var_0, var_1) {
  var_2 = var_0._id_DDFD;
  var_3 = var_0._id_59B9;
  var_1 = var_0 _meth_842E();

  if(var_1 < var_2) {
    return "stop";
  } else if(var_1 >= var_2 && var_1 < var_3) {
    return "slow";
  } else {
    return "fast";
  }
}

_id_B293(var_0, var_1, var_2) {
  var_3 = var_0 _meth_8431();
  var_4 = var_0 _id_06E9::_id_6810();
  var_5 = var_0 gettagorigin(var_1);
  playFX(level.vehicle._id_F078._id_EBC9[var_4][var_2._id_EBCA], var_2._id_3BB9, var_3);
}

_id_F4F9(var_0) {
  var_1 = var_0 _id_06E9::_id_6810();
  return isDefined(level.vehicle._id_F078._id_EBC9[var_1]);
}

_id_95BB() {
  level._effect["IED_marker_to_non_overwatch"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_marker_reticle.vfx");
  level._effect["IED_explosion"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_explo_ied.vfx");
  level._effect["IED_radar_ping"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_drone_radar_ping.vfx");
  level._effect["IED_false_positive"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_marker_false_pos.vfx");
  level._effect["vehicle_tire_damage_smoke_left"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_runner.vfx");
  level._effect["vehicle_tire_damage_smoke_right"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_runner_right_side.vfx");
  level._effect["vehicle_hood_damage_smoke"] = loadfx("vfx/iw8_cp/level/cp_br_syrk/vfx_damage_smoke_hood.vfx");
  level._effect["reaper_clouds"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_clouds.vfx");
  level._effect["cruise_missile_pod_break"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion.vfx");
  level._effect["interceptor_hit_air_exp"] = loadfx("vfx/iw8/level/drone/vfx_drn_hellfire_explosion_air_01.vfx");
  level._effect["reaper_missile_marker"] = loadfx("vfx/iw8_cp/raid/vfx_reaper_missile_marker.vfx");
}

_id_8100() {
  level._id_CC34["veh_repair_plyr"] = #animtree;
  level._id_CC31["veh_repair_plyr"]["tire_repair_start"] = % sdr_cp_tirefix_start;
  level._id_CC32["veh_repair_plyr"]["tire_repair_start"] = "sdr_cp_tirefix_start";
  level._id_CC3B["veh_repair_plyr"]["tire_repair_start"] = "repair_in";
  _id_06C6::_id_10F1("veh_repair_plyr", "sfx_scn_cp_repair_tire_enter_foley", ::_id_F28F);
  _id_06C6::_id_10F1("veh_repair_plyr", "sfx_scn_cp_repair_tire_air_start", ::_id_F28D);
  level._id_CC31["veh_repair_plyr"]["tire_repair_loop"] = % sdr_cp_tirefix_loop;
  level._id_CC32["veh_repair_plyr"]["tire_repair_loop"] = "sdr_cp_tirefix_loop";
  level._id_CC3B["veh_repair_plyr"]["tire_repair_loop"] = "repair_lp";
  level._id_CC31["veh_repair_plyr"]["tire_repair_stop"] = % sdr_cp_tirefix_end;
  level._id_CC32["veh_repair_plyr"]["tire_repair_stop"] = "sdr_cp_tirefix_end";
  level._id_CC3B["veh_repair_plyr"]["tire_repair_stop"] = "repair_out";
  _id_06C6::_id_10F1("veh_repair_plyr", "sfx_scn_cp_repair_tire_air_stop", ::_id_F28E);
  _id_06C6::_id_10F1("veh_repair_plyr", "sfx_scn_cp_repair_tire_exit_foley", ::_id_F290);
  level._id_CC31["veh_repair_plyr"]["repair_grill_start"] = % cp_scripted_fixdecho_enter;
  level._id_CC32["veh_repair_plyr"]["repair_grill_start"] = "cp_scripted_fixdecho_enter";
  level._id_CC3B["veh_repair_plyr"]["repair_grill_start"] = "decho_repair_hood_enter";
  _id_06C6::_id_10F1("veh_repair_plyr", "sfx_scn_cp_repair_engine_enter_foley", ::_id_C546);
  level._id_CC31["veh_repair_plyr"]["repair_grill_stop"] = % cp_scripted_fixdecho_exit;
  level._id_CC32["veh_repair_plyr"]["repair_grill_stop"] = "cp_scripted_fixdecho_exit";
  level._id_CC3B["veh_repair_plyr"]["repair_grill_stop"] = "decho_repair_hood_exit";
  _id_06C6::_id_10F1("veh_repair_plyr", "sfx_scn_cp_repair_engine_exit_foley", ::_id_C547);
  level._id_CC31["veh_repair_plyr"]["repair_grill"] = % cp_scripted_fixdecho_idle;
  level._id_CC32["veh_repair_plyr"]["repair_grill"] = "cp_scripted_fixdecho_idle";
  level._id_CC3B["veh_repair_plyr"]["repair_grill"] = "decho_repair_hood_idle";
  _id_06C6::_id_10F1("veh_repair_plyr", "sfx_scn_cp_repair_engine_fixing_long", ::_id_C544);
  _id_06C6::_id_10F1("veh_repair_plyr", "sfx_scn_cp_repair_engine_fixing_short", ::_id_C545);
}

_id_F28F(var_0) {
  var_0 _meth_827E("scn_cp_repair_tire_enter_foley");
}

_id_F28D(var_0) {
  var_0 _meth_827E("scn_cp_repair_tire_air_start");
}

_id_F28E(var_0) {
  var_0 _meth_827E("scn_cp_repair_tire_air_stop");
}

_id_F290(var_0) {
  var_0 _meth_827E("scn_cp_repair_tire_exit_foley");
}

_id_C546(var_0) {
  var_0 _meth_827E("scn_cp_repair_engine_enter_foley");
}

_id_C547(var_0) {
  var_0 _meth_827E("scn_cp_repair_engine_exit_foley");
}

_id_C544(var_0) {
  var_0 _meth_827E("scn_cp_repair_engine_fixing_long");
}

_id_C545(var_0) {
  var_0 _meth_827E("scn_cp_repair_engine_fixing_short");
}

_id_4C2D(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = var_1.angles;
  var_5 = _id_67A2(var_2, var_0);
  var_6 = getgroundposition(var_5._id_18B6, 2, 100, 24);
  var_7 = var_5._id_186F;
  var_8 = spawn("script_model", var_6);
  var_8.origin = var_6;
  var_8.angles = var_7;
  var_1 setorigin(var_6, 1);
  var_1 setplayerangles(var_7);
  var_1 setstance("stand");
  var_1 disableweapons();
  var_1 _meth_80FD(&"CP_VEHICLE_TRAVEL/REPAIR");
  _id_E0F1(var_1);
  var_1 thread _id_4C2E(var_0, var_1, var_8);
  var_9 = _id_10740(var_0, var_1, var_8);
  _id_C38B(var_1);
  waitframe();
  var_1 stoploopsound("scn_cp_repair_tire_air_lp");
  var_8 delete();
  _id_071E::_id_C436(var_1);
  var_1 _meth_80FC();
  var_1 setplayerangles(var_4);
  var_1 setstance("stand");
  var_1 cameradefault();
  var_1 enableweapons();
  var_1 setorigin(var_3, 1);

  if(istrue(var_9)) {
    return 1;
  }

  return 0;
}

_id_4C2E(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("repair_failed");
  var_3 = _func_0079(%sdr_cp_tirefix_start);
  var_4 = _func_0079(%sdr_cp_tirefix_loop);
  var_5 = _func_0079(%sdr_cp_tirefix_end);
  var_6 = var_3 - 0.1;
  var_7 = var_4 - 0.1;
  var_1 thread _id_071E::_id_3F5D(var_1, "veh_repair_plyr");
  var_1 _meth_8697("camera_custom_orbit_2");
  var_2 thread _id_0706::_id_17FD(var_1, var_1._id_B5A4, "tire_repair_start");
  wait(var_6);
  var_2 thread _id_0706::_id_17FD(var_1, var_1._id_B5A4, "tire_repair_loop");
  var_1 playLoopSound("scn_cp_repair_tire_air_lp");
  wait(var_7 / 10);

  if(!_id_073B::_id_B4EF(var_1)) {
    var_2 thread _id_0706::_id_17FD(var_1, var_1._id_B5A4, "tire_repair_stop");
    wait 1;
    var_1._id_30B3 hide();
    wait(var_5 - 1);
  }
}

_id_4C01(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 endon("repair_failed");
  var_3 = _func_0079(%cp_scripted_fixdecho_enter);
  var_4 = _func_0079(%cp_scripted_fixdecho_idle);
  var_5 = _func_0079(%cp_scripted_fixdecho_exit);
  var_6 = var_3;
  var_7 = var_4;
  var_1 thread _id_071E::_id_3F5D(var_1, "veh_repair_plyr");
  var_1 _meth_8697("camera_custom_orbit_1");
  var_2 thread _id_0706::_id_17FD(var_1, var_1._id_B5A4, "repair_grill_start");
  wait(var_6);
  var_2 thread _id_0706::_id_17FD(var_1, var_1._id_B5A4, "repair_grill");
  wait(var_7);

  if(!_id_073B::_id_B4EF(var_1)) {
    var_2 thread _id_0706::_id_17FD(var_1, var_1._id_B5A4, "repair_grill_stop");
    wait(var_5);
  }
}

_id_4C00(var_0, var_1, var_2, var_3) {
  var_4 = var_1.origin;
  var_5 = var_1.angles;
  var_6 = _id_67A2(var_2, var_0);
  var_7 = var_0 gettagorigin("tag_origin_animate");
  var_8 = spawn("script_model", var_7);
  var_8.angles = var_0 gettagangles("tag_origin_animate");
  var_1 setstance("stand");
  var_1 disableweapons();
  var_1 _meth_80FD(&"CP_VEHICLE_TRAVEL/REPAIR");
  var_1 thread _id_4C01(var_0, var_1, var_8);
  var_9 = _id_1071A(var_0, var_1, var_8);
  var_8 delete();
  _id_071E::_id_C436(var_1);
  var_1 _meth_80FC();
  var_1 setplayerangles(var_5);
  var_1 setstance("stand");
  var_1 cameradefault();
  var_1 enableweapons();
  var_1 setorigin(var_4, 0);
  return var_9;
}

_id_67A2(var_0, var_1) {
  var_2 = var_1 gettagorigin(var_0);
  var_3 = var_1 gettagangles(var_0);
  var_4 = spawnStruct();
  var_4.origin = var_2;
  var_4.angles = var_3;
  var_4._id_18B6 = var_2;
  var_4._id_186F = var_3;

  switch (var_0) {
    case "tag_wheel_center_back_left":
    case "tag_wheel_center_front_left":
      var_4._id_186F = var_3 + (0, 180, 0);
      return var_4;
    case "tag_wheel_center_back_right":
    case "tag_wheel_center_front_right":
      return var_4;
    case "tag_grill":
      var_4._id_186F = var_3 + (0, 180, 0);
      return var_4;
  }
}

_id_E0F1(var_0) {
  var_1 = spawn("script_model", var_0 gettagorigin("tag_accessory_left"));
  var_1 setModel("automotive_fix_a_can_01");
  var_1.angles = var_0 gettagangles("tag_accessory_left");
  var_1 linkto(var_0, "tag_accessory_left");
  var_0._id_30B3 = var_1;
}

_id_C38B(var_0) {
  if(isDefined(var_0._id_30B3)) {
    var_0._id_30B3 delete();
  }
}

_id_10740(var_0, var_1, var_2) {
  var_3 = _func_0079(%sdr_cp_tirefix_start);
  var_4 = _func_0079(%sdr_cp_tirefix_loop);
  var_5 = _func_0079(%sdr_cp_tirefix_end);
  var_6 = var_3 - 0.1;
  var_7 = var_4 / 10 - 0.25;
  var_8 = var_5 - 0.1;
  var_9 = var_6 + var_7 + var_8;
  var_10 = var_0 scripts\cp\utility::_id_B546(var_1, var_9 * 1000, undefined, 12);

  if(!istrue(var_10)) {
    var_1 notify("repair_failed");
  }

  var_1 stoploopsound("scn_cp_repair_tire_air_lp");
  return var_10;
}

_id_1071A(var_0, var_1, var_2) {
  var_3 = _func_0079(%cp_scripted_fixdecho_enter);
  var_4 = _func_0079(%cp_scripted_fixdecho_idle);
  var_5 = _func_0079(%cp_scripted_fixdecho_exit);
  var_6 = var_3;
  var_7 = var_4;
  var_8 = var_5;
  var_9 = var_6 + var_7 + var_8;
  var_10 = var_0 scripts\cp\utility::_id_B546(var_1, var_9 * 1000, undefined, 12);

  if(!istrue(var_10)) {
    var_1 notify("repair_failed");
  }

  return var_10;
}

_id_4C02(var_0, var_1, var_2) {
  var_1 endon("repair_failed");
  var_2 thread _id_0706::_id_17FD(var_1, var_1._id_B5A4, "repair_grill");
}

_id_5B28(var_0, var_1) {
  var_2 = _id_999A(var_0, var_1);
  var_3 = _id_9999(var_0, var_2);
  var_3 _id_BE62(var_3);
  var_3 _id_1036(var_3);
  var_2 thread _id_8CB5(var_2, var_1, var_3);
  var_2 thread _id_40BB(var_2, var_3);
  var_3 thread _id_40BA(var_3, var_2, var_1);
  var_3 thread _id_43C6(var_3, var_3._id_40B9, var_3 getentitynumber());
}

_id_40BA(var_0, var_1, var_2) {
  var_2 endon("death");
  var_0 endon("death");

  for(;;) {
    if(distancesquared(var_0.origin, var_1.origin) < 250000) {
      break;
    }

    var_3 = anglesToForward(var_0.angles);
    var_4 = vectornormalize(var_1.origin - var_0.origin);

    if(vectordot(var_3, var_4) < 0) {
      break;
    }

    waitframe();
  }

  level thread _id_5B5D(var_0, var_2);
}

_id_5B5D(var_0, var_1) {
  var_1 endon("death");
  var_0 setscriptablepartstate("wing_trails", "off");
  var_0 setscriptablepartstate("main_thruster", "off", 0);
  playFXOnTag(scripts\engine\utility::getfx("cruise_missile_pod_break"), var_0, "tag_missile");
  var_0 notify("stop_cruise_missile_death_monitor");
  var_2 = var_0._id_40B9;
  var_3 = var_0 getentitynumber();
  waitframe();
  var_4 = _id_999C(var_0);
  var_5 = _id_999B(var_0, var_4);
  var_5._id_40B9 = var_2;
  _id_BE65(var_5, var_2);
  level._id_40BC = scripts\engine\utility::array_remove(level._id_40BC, var_0);

  if(isDefined(level._id_96F1)) {
    level._id_96F1 = scripts\engine\utility::array_remove(level._id_96F1, var_0);
    _id_FB88();
  }

  if(isDefined(var_0._id_83BD)) {
    _id_D260(var_0._id_83BD, var_5);
  }

  var_0 delete();
  var_5 thread _id_4694(var_5, var_4, var_1);
  var_5 thread _id_43C6(var_5, var_2, var_3);
}

_id_FB88() {
  var_0 = 0;

  foreach(var_2 in level._id_96F1) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(istrue(var_2._id_24C1)) {
      continue;
    }
    var_0++;
  }

  if(var_0 == 0) {
    var_4 = _id_65AB();

    if(isDefined(var_4)) {
      var_4 setclientomnvar("ui_missile_lock", 0);
    }
  }
}

_id_65AB() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_41A7) && (var_1._id_41A7 == "missile_defense_right" || var_1._id_41A7 == "missile_defense_left")) {
      return var_1;
    }
  }

  return undefined;
}

_id_D260(var_0, var_1) {
  var_0._id_EE66.origin = var_1.origin;
  var_0._id_EE66 linkto(var_1);
  var_0._id_EE73 = var_1;
}

_id_BE65(var_0, var_1) {
  _func_0160(var_1, var_0);
  _func_0161(var_1, 0);
}

_id_4694(var_0, var_1, var_2) {
  var_0 endon("death");
  wait 0.25;

  if(isDefined(var_2)) {
    var_0 missile_settargetent(var_2);
  }

  var_1 delete();
}

_id_1036(var_0) {
  if(!isDefined(level._id_40BC)) {
    level._id_40BC = [];
  }

  level._id_40BC[level._id_40BC.size] = var_0;
}

_id_43C6(var_0, var_1, var_2) {
  var_0 endon("stop_cruise_missile_death_monitor");
  var_0 waittill("death");
  level._id_40BC = scripts\engine\utility::array_remove(level._id_40BC, var_0);

  if(isDefined(level._id_96F1)) {
    level._id_96F1 = scripts\engine\utility::array_remove(level._id_96F1, var_0);
    _id_FB88();
  }

  _id_0748::_id_5F56("cruise_missile_entity_number_" + var_2);
  _func_015C(var_1);
}

_id_BE62(var_0) {
  var_1 = _id_0748::_id_C583("cruise_missile_entity_number_" + var_0 getentitynumber(), 22);
  _func_016B(var_1, "invisible");
  _func_015D(var_1, "hud_callsign_bg_rd");
  _func_0160(var_1, var_0);
  _func_0161(var_1, 0);
  _func_018B(var_1);
  _func_0172(var_1, 0);
  _func_0173(var_1, 0);
  _func_017A(var_1, 1);
  _func_0176(var_1, 1);
  _func_017B(var_1, 1);
  _func_018E(var_1, 1);
  var_0._id_40B9 = var_1;
  _id_99D2(var_1);
}

_id_99D2(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_41A7) && (var_2._id_41A7 == "missile_defense_right" || var_2._id_41A7 == "missile_defense_left")) {
      _func_0185(var_0, var_2);
    }
  }
}

_id_40BB(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("death");
  var_0 delete();
}

_id_8CB5(var_0, var_1, var_2) {
  var_1 endon("death");
  var_2 endon("death");
  var_3 = var_0.origin[2];

  for(;;) {
    var_4 = var_2.origin - var_1.origin;
    var_4 = var_4 * (1, 1, 0);
    var_4 = vectornormalize(var_4);
    var_5 = var_1.origin + var_4 * 7500;
    var_5 = (var_5[0], var_5[1], var_3);
    var_0.origin = var_5;
    waitframe();
  }
}

_id_9999(var_0, var_1) {
  var_2 = _func_0143("cruise_missile_cp", var_0, var_1.origin);
  var_2 missile_settargetent(var_1);
  var_2 _meth_8231();
  var_2 setscriptablepartstate("main_thruster", "on", 0);
  var_2 setscriptablepartstate("wing_trails", "on");
  var_2._id_96E6 = 0;
  return var_2;
}

_id_999B(var_0, var_1) {
  var_2 = _func_0143("cruise_missile_warhead_cp", var_0 gettagorigin("tag_missile"), var_1.origin);
  var_2 missile_settargetent(var_1);
  var_2 _meth_8231();
  var_2 setscriptablepartstate("sub_thruster", "on", 0);
  var_2._id_96E6 = 0;
  level._id_40BC = scripts\engine\utility::array_add(level._id_40BC, var_2);

  if(isDefined(level._id_96F1) && scripts\engine\utility::array_contains(level._id_96F1, var_0)) {
    level._id_96F1 = scripts\engine\utility::array_add(level._id_96F1, var_2);
  }

  return var_2;
}

_id_999A(var_0, var_1) {
  var_2 = var_0[2];
  var_3 = var_1.origin - var_0;
  var_3 = var_3 * (1, 1, 0);
  var_3 = vectornormalize(var_3);
  var_4 = var_1.origin + var_3 * 7500;
  var_4 = (var_4[0], var_4[1], var_2);
  var_5 = spawn("script_model", var_4);
  var_5 setModel("tag_origin");
  return var_5;
}

_id_999C(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = var_0.origin + var_1 * 10000;
  var_3 = spawn("script_model", var_2);
  var_3 setModel("tag_origin");
  return var_3;
}

_id_99B7(var_0) {
  var_1 = anglestoright(var_0.angles);
  var_2 = var_0.origin + var_1 * 10000 + (0, 0, 10000);
  var_3 = spawn("script_model", var_2);
  var_3 setModel("veh8_mil_air_mquebec9");
  var_3.angles = var_0.angles;
  var_3 thread _id_3837(var_3, var_0);
  var_3 thread _id_8CB1(var_0, var_3);
  var_3._id_9F57 = _id_3F42(var_0, var_3);
  var_3._id_CB8A = _id_3F66(var_0, var_3);
  var_0._id_C0B4 = var_3;
  return var_3;
}

_id_8CB1(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("tag_player");
  var_1 linkto(var_2, "tag_player");
  var_2 thread _id_8CBE(var_2);
  var_2 thread _id_8CB6(var_2, var_0);
  var_2 thread _id_3837(var_2, var_0);
}

_id_8CBE(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 rotateyaw(360, 180);
    wait 180;
  }
}

_id_8CB6(var_0, var_1) {
  var_0 endon("death");
  wait 2;

  for(;;) {
    var_2 = (var_1.origin[0], var_1.origin[1], var_0.origin[2]);
    var_3 = distance2d(var_0.origin, var_2);
    var_4 = var_3 / _id_670F(var_3);

    if(var_3 <= 10) {
      waitframe();
      continue;
    }

    if(var_3 <= 100) {
      var_0 moveto(var_2, var_4, 0, var_4);
      waitframe();
      continue;
    }

    var_0 moveto(var_2, var_4);
    var_0 scripts\engine\utility::_id_108A7(var_4, "movedone");
  }
}

_id_670F(var_0) {
  if(var_0 <= 150) {
    return 500;
  } else {
    return 1000;
  }
}

_id_3F42(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_3 = spawn("script_model", var_1.origin + var_2 * 170 + (0, 0, -140));
  var_3 setModel("tag_player");
  var_3.angles = vectortoangles((0, 0, -1));
  var_3 linkto(var_1);
  var_3 thread _id_3837(var_3, var_0);
  return var_3;
}

_id_3F66(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_3 = spawn("script_model", var_1.origin + var_2 * 0 + (0, 0, -140));
  var_3 setModel("tag_player");
  var_3.angles = vectortoangles(var_0.origin - var_3.origin);
  var_3 linkto(var_1);
  var_3 thread _id_3837(var_3, var_0);
  var_3 thread _id_8CB4(var_3, var_0);
  return var_3;
}

_id_8CB4(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  for(;;) {
    var_0.angles = vectortoangles(var_1.origin - var_0.origin);
    waitframe();
  }
}

_id_64FF(var_0) {
  var_1 = spawnStruct();
  var_1.model = "veh8_civ_lnd_decho_rebel_2";
  var_1._id_100AF = "decho_physics_cp";
  var_1._id_0F8F = ::_id_7B9A;
  var_1._id_7CE9 = ["tag_wheel_back_left", "tag_wheel_front_left", "tag_wheel_back_right", "tag_wheel_front_right"];
  var_1._id_58FA = 750;
  var_1._id_DC30 = 0.3;
  var_1._id_3804 = "cp_decho_rebel";
  var_1._id_DDFD = 1;
  var_1._id_59B9 = 20;
  var_1._id_F4FA = ["tag_wheel_back_right", "tag_wheel_back_left", "tag_wheel_front_right", "tag_wheel_front_left"];
  var_1._id_BD96 = ["s4_me_rindigo_mp"];
  var_2 = [];
  var_2["tag_wheel_back_left"] = "tag_wheel_center_back_left";
  var_2["tag_wheel_front_left"] = "tag_wheel_center_front_left";
  var_2["tag_wheel_back_right"] = "tag_wheel_center_back_right";
  var_2["tag_wheel_front_right"] = "tag_wheel_center_front_right";
  var_1._id_7CE8 = var_2;
  var_3 = [];
  var_3 = _id_1D11("driver", 14, -38, 44.3, var_3);
  var_3 = _id_1D11("passenger", 14, 38, 44.3, var_3);
  var_3 = _id_1D11("left_back_seat", -22.5, -38, 44.3, var_3);
  var_3 = _id_1D11("right_back_seat", -22.5, 38, 44.3, var_3);
  var_3 = _id_1D11("gunner", -6, 0, 83, var_3);
  var_3 = _id_1D11("overwatch_right", -5, 19, 68, var_3);
  var_3 = _id_1D11("overwatch_left", -5, -19, 68, var_3);
  var_3 = _id_1D11("back_left_repair", -48.8, -39, 19.9, var_3);
  var_3 = _id_1D11("back_right_repair", -48.8, 39, 17.5, var_3);
  var_3 = _id_1D11("front_left_repair", 74, -39, 17, var_3);
  var_3 = _id_1D11("front_right_repair", 74, 39, 17.5, var_3);
  var_3 = _id_1D11("hood_repair", 105, 0, 42.5, var_3);
  var_3 = _id_1D11("front_refill_ammo", 32, 19, 52, var_3);
  var_3 = _id_1D11("back_right_refill_ammo", -5, 19, 55, var_3);
  var_3 = _id_1D11("back_left_refill_ammo", -5, -19, 55, var_3);
  var_3 = _id_1D11("retrieve_hostage", -92, 0, 50, var_3);
  var_1._id_8384 = var_3;
  return var_1;
}

_id_7B9A(var_0) {
  _id_0FDF(var_0);
}

_id_0FDF(var_0) {
  var_1 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), "tur_gun_decho_cp", 0);
  var_1.angles = var_0.angles;
  var_1.team = "allies";
  var_1 linkto(var_0);
  var_1 setModel("veh8_civ_lnd_decho_rebel_mg_no_hatch");
  var_1 setmode("sentry_offline");
  var_1 setsentryowner(undefined);
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 _meth_839D(1);
  var_0._id_72BD = var_1;
  var_0._id_72BE = "tur_gun_decho_cp";
  var_1 thread _id_3837(var_1, var_0);
}

_id_64B5(var_0) {
  var_1 = spawnStruct();
  var_1.model = "veh8_civ_lnd_decho_rebel_2";
  var_1._id_100AF = "decho_physics_cp";
  var_1._id_0F8F = ::_id_5F88;
  var_1._id_7CE9 = ["tag_wheel_back_left", "tag_wheel_front_left", "tag_wheel_back_right", "tag_wheel_front_right"];
  var_1._id_58FA = 5000;
  var_1._id_DC30 = 0.3;
  var_1._id_3804 = "cp_decho_rebel";
  var_1._id_DDFD = 1;
  var_1._id_59B9 = 20;
  var_1._id_F4FA = ["tag_wheel_back_right", "tag_wheel_back_left", "tag_wheel_front_right", "tag_wheel_front_left"];
  var_1._id_BD96 = ["s4_me_rindigo_mp"];
  var_2 = [];
  var_2["tag_wheel_back_left"] = "tag_wheel_center_back_left";
  var_2["tag_wheel_front_left"] = "tag_wheel_center_front_left";
  var_2["tag_wheel_back_right"] = "tag_wheel_center_back_right";
  var_2["tag_wheel_front_right"] = "tag_wheel_center_front_right";
  var_1._id_7CE8 = var_2;
  var_3 = [];
  var_3 = _id_1D11("driver", 14, -38, 44.3, var_3);
  var_3 = _id_1D11("passenger", 14, 38, 44.3, var_3);
  var_3 = _id_1D11("left_back_seat", -22.5, -38, 44.3, var_3);
  var_3 = _id_1D11("right_back_seat", -22.5, 38, 44.3, var_3);
  var_3 = _id_1D11("gunner", -6, 0, 83, var_3);
  var_3 = _id_1D11("back_left_repair", -48.8, -39, 19.9, var_3);
  var_3 = _id_1D11("back_right_repair", -48.8, 39, 17.5, var_3);
  var_3 = _id_1D11("front_left_repair", 74, -39, 17, var_3);
  var_3 = _id_1D11("front_right_repair", 74, 39, 17.5, var_3);
  var_3 = _id_1D11("hood_repair", 105, 0, 42.5, var_3);
  var_3 = _id_1D11("back_right_refill_ammo", -5, 19, 55, var_3);
  var_1._id_8384 = var_3;
  return var_1;
}

_id_5F88(var_0) {
  _id_0FDF(var_0);
}

_id_0FDE(var_0) {
  var_1 = -15;
  var_2 = 0;
  var_3 = 50;
  var_4 = var_0.angles;
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  var_7 = anglestoup(var_4);
  var_8 = var_0 gettagorigin("tag_origin");
  var_9 = var_8 + var_5 * var_1 + var_6 * var_2 + var_7 * var_3;
  var_10 = spawn("script_model", var_9);
  var_10 setModel("tag_origin");
  var_10 linkto(var_0);
  var_10 thread _id_3837(var_10, var_0);
  var_0._id_7187 = var_10;
  var_0._id_7188 = "iw8_la_mike32_mp";
}

_id_C3D2(var_0) {
  if(isDefined(var_0._id_EE7E)) {
    _id_079B::_id_EEE2(var_0, var_0 getentitynumber(), var_0._id_EE7E);
  }
}

_id_4488() {}

_id_44B2(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("warpjeeptome");

    if(self _meth_8434()) {
      var_1 = _func_02AB(var_0.origin);
      var_1 = var_1 + (0, 0, 50);
      var_2 = (0, self.angles[1], 0);
      self _meth_8439(var_1, var_2);
    }

    wait 0.05;
  }
}

_id_102C8(var_0) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_1);
    _id_FB5F(var_0);
  }
}

_id_102C9(var_0) {
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    level waittill("player_disconnect");
    _id_FB5F(var_0);
  }
}