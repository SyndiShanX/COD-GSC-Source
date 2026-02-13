/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_mobile_armory.gsc
*****************************************************/

init() {
  level._effect["poi_mobile_armory_available"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_armory_white.vfx");
  level._effect["poi_mobile_armory_charging"] = loadfx("vfx/iw8_br/gameplay/vfx_br_poi_armory_red.vfx");
  level._id_2A7F = [];
  level._id_2A7E = getdvarint("#x3734b0c2ecdb3637", 0) != 0;
  level._id_9FC3 = getdvarint("#x32f98d7345e887066", 1);
  scripts\mp\gametypes\br_functional_poi::_id_829C("mobile_armory");
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("mobile_armory", 0, ::_id_0C7D, undefined, ::_id_0C81);
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("mobile_armory", 1, ::_id_0C7B, undefined, ::_id_0C80);
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("mobile_armory", 2, ::_id_0C7A, undefined, ::_id_0C7F);
  scripts\mp\gametypes\br_functional_poi::_id_C2BB("mobile_armory", 3, ::_id_0C7C, undefined, undefined);
}

_id_E328(var_0) {
  if(!istrue(level._id_2A7E)) {
    return;
  }
  var_1 = spawn("script_model", var_0.origin);

  if(isDefined(var_0.angles)) {
    var_1.angles = var_0.angles;
  }

  var_1 setModel("veh8_mil_lnd_stango_static");
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");

  if(!isDefined(var_1._id_83A8)) {
    var_3 = (0, 0, 3);
    var_4 = spawn("script_model", var_2.origin + var_3);

    if(isDefined(var_2.angles)) {
      var_4.angles = var_2.angles;
    }

    var_4 setModel("military_crate_large_stackable_01");
    var_4 setcursorhint("HINT_NOICON");
    var_4 setuseholdduration("duration_medium");
    var_4 sethintdisplayfov(120);
    var_4 setusefov(120);
    var_4 setuserange(80);
    var_4 _meth_83A1(-1);
    var_1._id_83A8 = var_4;
  }

  var_5 = _id_07F9::_id_C57D(1);

  if(var_5 != -1) {
    _id_07F9::_id_A867(var_5, "active", (0, 0, 0), "hud_icon_br_mobile_armory");
    _id_07F9::_id_FB93(var_5, var_1);
    _id_07F9::_id_FB98(var_5, 1);
    _id_07F9::_id_A89F(var_5);
    var_1._id_A8DA = var_5;
    var_1 thread _id_0C68();
  } else {}

  level._id_2A7F[level._id_2A7F.size] = var_1;
  return var_1;
}

_id_0C68() {
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
        _id_07F9::_id_A89E(var_0._id_A8DA, var_4);
      }
    }

    var_0._id_B7BD = scripts\mp\utility\player::_id_6C5F(var_0.origin, var_2);

    foreach(var_4 in var_0._id_B7BD) {
      _id_07F9::_id_A89D(var_0._id_A8DA, var_4);
    }
  }
}

_id_AB80() {
  foreach(var_1 in level._id_2A7F) {
    var_1 scripts\mp\gametypes\br_functional_poi::_id_7103("mobile_armory", 0);
  }
}

_id_0C67() {
  var_0 = self;
  var_0 notify("mobileArmoryUseThinkEnd");
}

_id_0C69() {
  var_0 = self;
  var_0 endon("death");
  var_0 _id_0C67();
  var_0 endon("mobileArmoryUseThinkEnd");
  var_1 = var_0 scripts\mp\gametypes\br_functional_poi::_id_69A8();
  var_0._id_C144 = [];

  for(;;) {
    var_0._id_83A8 waittill("trigger", var_2);

    if(var_0 scripts\mp\gametypes\br_functional_poi::_id_69A8() != var_1) {
      return;
    }
    if(var_0 scripts\mp\gametypes\br_functional_poi::_id_69A8() == 0) {
      if(var_2._id_B956 < level._id_9FC3) {
        var_2 scripts\mp\hud_message::_id_DCA2("MP_BR_INGAME/NOT_ENOUGH_PLUNDER_ACTIVATE");
        continue;
      } else
        var_2 scripts\mp\gametypes\br_plunder::_id_B7A3(var_2._id_B956 - level._id_9FC3);
    }

    if(var_1 == 0) {
      var_0._id_ADAE = var_2.team;
      var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7103("mobile_armory", 1);
      return;
    } else if(var_1 == 2) {
      var_3 = 0;

      foreach(var_5 in var_0._id_C144) {
        if(var_5 == var_2) {
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        var_2 scripts\mp\hud_message::_id_DCA2("MP/BR_MOBILE_ARMORY_ALREADY_USED");
      } else {
        var_2 thread _id_0C66(var_0);
      }
    }
  }
}

_id_0C66(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("disconnect");
  level endon("game_ended");

  if(isai(var_1)) {
    return;
  }
  if(var_1 isswitchingweapon() || var_1 _meth_81E0() || var_1 _meth_81CE() || var_1 _meth_81EF() || var_1 israisingweapon() || var_1 _meth_81CF()) {
    var_1 scripts\mp\hud_message::_id_DCA2("MP_BR_INGAME/MOBILE_ARMORY_ACTION_ERROR");
    return;
  }

  var_1 setclientomnvar("ui_options_menu", 2);

  for(;;) {
    var_1 waittill("luinotifyserver", var_2, var_3);

    if(var_2 != "class_select") {
      continue;
    }
    var_4 = _id_07F2::_id_6960(var_3);
    var_1.pers["class"] = var_4;
    var_1.class = var_4;
    var_1 scripts\mp\class::_id_BB98(var_4);
    var_1 scripts\mp\class::_id_EC08();
    var_1._id_6282 = 0;
    var_0._id_C144[var_0._id_C144.size] = var_1;
    var_5 = 50;
    var_6 = var_1 getweaponslistprimaries();

    foreach(var_8 in var_6) {
      var_9 = getcompleteweaponname(var_8);

      if(_func_00D6(var_9, 0, 4) == "alt_") {
        continue;
      }
      var_10 = weaponclipsize(var_8);
      var_11 = int(min(var_5, var_10));
      var_1 setweaponammoclip(var_8, var_11);
    }

    scripts\mp\gametypes\br_weapons::_id_2A0C(var_1);
  }
}

_id_0C7D(var_0) {
  var_1 = scripts\mp\gametypes\br_functional_poi::_id_6AC4();
  var_0._id_83A8 _meth_81B0(var_1);
  var_0._id_83A8 makeuseable();
  var_0._id_83A8 sethintstring(&"MP/BR_ACTIVATE_MOBILE_ARMORY");
  var_0 thread _id_0C69();
  var_2 = scripts\engine\utility::getfx("poi_mobile_armory_available");
  playFXOnTag(var_2, var_0, "tag_origin");
}

_id_0C81(var_0) {
  var_0._id_83A8 _meth_81AD();
  var_0 _id_0C67();
  var_0._id_83A8 makeunusable();
  var_1 = scripts\engine\utility::getfx("poi_mobile_armory_available");
  stopFXOnTag(var_1, var_0, "tag_origin");
}

_id_0C7B(var_0) {
  var_1 = getdvarfloat("#x3aa03e1d04ea53b88", 10.0);
  var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7104("mobile_armory", 2, var_1);
  scripts\mp\gametypes\br_functional_poi::_id_DCC7(var_0._id_ADAE, "br_mobile_armory_charging", var_1, int(var_1 * 1000));
  var_2 = scripts\engine\utility::getfx("poi_mobile_armory_charging");
  playFXOnTag(var_2, var_0, "tag_origin");
  var_0 playLoopSound("truck_reversebeep_lp");
}

_id_0C80(var_0) {
  var_1 = scripts\engine\utility::getfx("poi_mobile_armory_charging");
  stopFXOnTag(var_1, var_0, "tag_origin");
  var_0 stoploopsound();
}

_id_0C7A(var_0) {
  var_1 = scripts\mp\gametypes\br_functional_poi::_id_6AC4();
  var_0._id_83A8 _meth_81B0(var_1);
  level thread scripts\mp\gametypes\br::_id_EFAD("br_mobile_armory_activate", var_0.player, var_0._id_ADAE);
  var_0._id_83A8 makeuseable();
  var_0._id_83A8 sethintstring(&"MP/BR_USE_MOBILE_ARMORY");
  var_0 thread _id_0C69();
  var_2 = getdvarfloat("#x3ebeaebe3246d43c6", 15.0);
  var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7104("mobile_armory", 3, var_2);
  scripts\mp\gametypes\br_functional_poi::_id_DCC7(var_0._id_ADAE, "br_mobile_armory_active", var_2, int(var_2 * 1000));
}

_id_0C7F(var_0) {
  var_0._id_83A8 _meth_81AD();
  var_0 _id_0C67();
  var_0._id_83A8 makeunusable();
  scripts\mp\gametypes\br_functional_poi::_id_DCC7(var_0._id_ADAE, "br_mobile_armory_cooldown", 3);
  var_0._id_ADAE = undefined;
}

_id_0C7C(var_0) {
  var_1 = getdvarfloat("#x3a2fd1aa0b576e233", 120.0);
  var_0 thread scripts\mp\gametypes\br_functional_poi::_id_7104("mobile_armory", 0, var_1);
}