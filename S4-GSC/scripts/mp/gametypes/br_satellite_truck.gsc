/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_satellite_truck.gsc
*******************************************************/

init() {
  level._effect["poi_sat_truck_available"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_satnav_white.vfx");
  level._effect["poi_sat_truck_charging"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_satnav_red.vfx");
  level._id_2AB1 = [];
  level._id_2AB0 = getdvarint("#x3835a29b30aca64b", 0) != 0;
  level._id_CB2D = getdvarfloat("#x316513d4d5698b0fa", 15);
  level._id_CB2E = getdvarint("#x3593c402c3068204a", 1);
  scripts\mp\gametypes\br_functional_poi::_id_829C("satellite_truck");
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("satellite_truck", 0, ::_id_0C7D, undefined, ::_id_0C81);
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("satellite_truck", 1, ::_id_0C7B, undefined, ::_id_0C80);
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("satellite_truck", 2, ::_id_0C7A, undefined, ::_id_0C7F);
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("satellite_truck", 3, ::_id_0C7E, undefined, ::_id_0C82);
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("satellite_truck", 4, ::_id_0C7C, undefined, undefined);
}

_id_E365(var_0) {
  if(!istrue(level._id_2AB0)) {
    return;
  }
  var_1 = spawn("script_model", var_0.origin);

  if(isDefined(var_0.angles)) {
    var_1.angles = var_0.angles;
  }

  var_1 setModel("veh8_mil_lnd_mkilo23_skud_static2");
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");

  if(!isDefined(var_1._id_CB2C)) {
    var_3 = spawn("script_model", var_2.origin);

    if(isDefined(var_2.angles)) {
      var_3.angles = var_2.angles;
    }

    var_3 setModel("electrical_elevator_access_keypad_01");
    var_3 setcursorhint("HINT_NOICON");
    var_3 setuseholdduration("duration_medium");
    var_3 sethintdisplayfov(120);
    var_3 setusefov(120);
    var_3 setuserange(80);
    var_3 _meth_83A1(-1);
    var_1._id_CB2C = var_3;
  }

  var_4 = _id_07F9::_id_C57D(1);

  if(var_4 != -1) {
    _id_07F9::_id_A867(var_4, "active", (0, 0, 0), "hud_icon_br_satellite_truck");
    _id_07F9::_id_FB93(var_4, var_1);
    _id_07F9::_id_FB98(var_4, 1);
    _id_07F9::_id_A89F(var_4);
    var_1._id_CB2B = var_4;
    var_1 thread _id_0CD4();
  } else {}

  level._id_2AB1[level._id_2AB1.size] = var_1;
  return var_1;
}

_id_AB80() {
  foreach(var_1 in level._id_2AB1) {
    var_1 scripts\mp\gametypes\br_functional_poi::_id_7103("satellite_truck", 0);
  }
}

_id_0CD4() {
  var_0 = self;
  var_0 endon("death");
  var_1 = 1.0;
  var_2 = 5000;
  var_0._id_B7BD = [];

  for(;;) {
    wait(var_1);

    if(!istrue(level._id_2AA8)) {
      continue;
    }
    foreach(var_4 in var_0._id_B7BD) {
      if(isDefined(var_4)) {
        _id_07F9::_id_A89E(var_0._id_CB2B, var_4);
      }
    }

    var_0._id_B7BD = scripts\mp\utility\player::_id_6C5F(var_0.origin, var_2);

    foreach(var_4 in var_0._id_B7BD) {
      if(isDefined(var_0._id_B7F4) && var_4.team == var_0._id_B7F4 && var_0._id_41F6 == 3) {
        continue;
      }
      _id_07F9::_id_A89D(var_0._id_CB2B, var_4);
    }
  }
}

_id_0CD5() {
  var_0 = self;
  var_1 = var_0;
  var_2 = var_0._id_CB2C;

  for(;;) {
    var_0 waittill("poi_state_change");
    var_3 = var_0._id_41F6;

    if(!isDefined(var_0._id_1F01)) {
      var_0._id_1F01 = var_3;
    } else if(var_0._id_1F01 == var_3) {
      continue;
    }
    var_0._id_1F01 = var_3;

    switch (var_3) {
      default:
        break;
      case 0:
        break;
      case 1:
        var_1 playSound("truck_sattruck_initialstartup_os");
        wait 7.5;
        var_1 playLoopSound("truck_sattruck_idling_lp");
        break;
      case 2:
        break;
      case 3:
        var_0._id_8A14 = 1;
        var_2 playSound("truck_sattruck_initdeploy_os");
        wait 4.0;
        var_2 playLoopSound("truck_sattruck_scanning_lp");
        break;
      case 4:
        var_1 playSound("truck_sattruck_engineoff");

        if(istrue(var_0._id_8A14)) {
          var_2 playSound("truck_sattruck_scanning_off");
          var_0._id_8A14 = undefined;
          wait 0.05;
          var_2 stoploopsound();
        }

        wait 0.45;
        var_1 stoploopsound();
        break;
    }
  }
}

_id_0CD3() {
  var_0 = self;
  var_0 notify("satelliteTruckUseThinkEnd");
}

_id_0CD6() {
  var_0 = self;
  var_0 endon("death");
  var_0 _id_0CD3();
  var_0 endon("satelliteTruckUseThinkEnd");
  var_0 thread _id_0CD5();
  var_1 = var_0 scripts\mp\gametypes\br_functional_poi::_id_69A8();

  for(;;) {
    var_0._id_CB2C waittill("trigger", var_2);

    if(var_0 scripts\mp\gametypes\br_functional_poi::_id_69A8() != var_1) {
      return;
    }
    if(var_0 scripts\mp\gametypes\br_functional_poi::_id_69A8() == 0) {
      if(var_2._id_B956 < level._id_CB2E) {
        var_2 scripts\mp\hud_message::_id_DCA2("MP_BR_INGAME/NOT_ENOUGH_PLUNDER_ACTIVATE");
        continue;
      } else
        var_2 scripts\mp\gametypes\br_plunder::_id_B7A3(var_2._id_B956 - level._id_CB2E);
    }

    if(var_1 == 0) {
      var_0._id_B7F4 = var_2.team;
      var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7103("satellite_truck", 1);
      return;
    } else if(var_1 == 2) {
      var_0._id_B7F4 = var_2.team;
      var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7103("satellite_truck", 3);
    }
  }
}

_id_0CD2() {
  var_0 = self;
  var_0 endon("death");
  level thread scripts\mp\gametypes\br::_id_EFAD("br_satellite_truck_active", var_0.player, var_0._id_B7F4);
  var_1 = 0;
  var_2 = getdvarint("#x386aa34da55b4a340", 500);
  var_3 = getdvarint("#x34b9dac8bc4bd8212", 2);

  while(var_1 * var_3 <= level._id_CB2D) {
    _func_02DC(self.origin, var_0._id_B7F4, 5000, var_2);
    var_1++;
    wait(var_3);
  }

  var_4 = getdvarfloat("#x31658ea155c96150b", 3);
  scripts\mp\gametypes\br_functional_poi::_id_DCC7(var_0._id_B7F4, "br_satellite_truck_cooldown", var_4);
  var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7103("satellite_truck", 4);
}

_id_0C7D(var_0) {
  var_1 = scripts\mp\gametypes\br_functional_poi::_id_6AC4();
  var_0._id_CB2C _meth_81B0(var_1);
  var_0._id_CB2C makeuseable();
  var_0._id_CB2C sethintstring(&"MP/BR_ACTIVATE_SATELLITE_TRUCK");
  var_0 thread _id_0CD6();
  var_2 = scripts\engine\utility::getfx("poi_sat_truck_available");
  playFXOnTag(var_2, var_0, "tag_origin");
}

_id_0C81(var_0) {
  var_0._id_CB2C _meth_81AD();
  var_0 _id_0CD3();
  var_0._id_CB2C makeunusable();
  var_1 = scripts\engine\utility::getfx("poi_sat_truck_available");
  stopFXOnTag(var_1, var_0, "tag_origin");
}

_id_0C7B(var_0) {
  var_1 = getdvarfloat("#x35366c668df0c464", 10);
  var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7104("satellite_truck", 2, var_1);
  scripts\mp\gametypes\br_functional_poi::_id_DCC7(var_0._id_B7F4, "br_satellite_truck_charging", var_1, int(var_1 * 1000));
  var_2 = scripts\engine\utility::getfx("poi_sat_truck_charging");
  playFXOnTag(var_2, var_0, "tag_origin");
}

_id_0C80(var_0) {
  var_1 = scripts\engine\utility::getfx("poi_sat_truck_charging");
  stopFXOnTag(var_1, var_0, "tag_origin");
}

_id_0C7A(var_0) {
  var_1 = scripts\mp\gametypes\br_functional_poi::_id_6AC4();
  var_0._id_CB2C _meth_81B0(var_1);
  var_0._id_CB2C makeuseable();
  var_0._id_CB2C sethintstring(&"MP/BR_USE_SATELLITE_TRUCK");
  var_0 thread _id_0CD6();
}

_id_0C7F(var_0) {
  var_0._id_CB2C _meth_81AD();
  var_0 _id_0CD3();
  var_0._id_CB2C makeunusable();
}

_id_0C7E(var_0) {
  var_0 thread _id_0CD2();
}

_id_0C82(var_0) {
  var_0._id_B7F4 = undefined;
}

_id_0C7C(var_0) {
  var_1 = getdvarfloat("#x355ee182f11382bb7", 15);
  var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7104("satellite_truck", 0, var_1);
}