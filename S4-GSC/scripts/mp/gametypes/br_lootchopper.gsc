/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_lootchopper.gsc
***************************************************/

init() {
  level._id_1F9C = 0;
  level._id_9850 = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_lootchopper", "lootChopper_onCrateUse", ::_id_9878);
}

_id_9874() {
  var_0 = _id_9871();
  level._id_984F = [];
  level._id_984F["quad_1"] = [];
  level._id_984F["quad_2"] = [];
  level._id_984F["quad_3"] = [];
  level._id_984F["quad_4"] = [];

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;

    foreach(var_9, var_7 in level._id_BE95) {
      var_8 = distance2dsquared(var_2.origin, var_7);

      if(!isDefined(var_3) || var_8 < var_3) {
        var_3 = var_8;
        var_4 = var_7;
        var_5 = "quad_" + (var_9 + 1);
      }
    }

    var_2.origin = var_2.origin * (1, 1, 0);
    var_2.origin = scripts\mp\gametypes\br::_id_6BCA(var_2.origin, (0, 0, 10000));
    level._id_984F[var_5][level._id_984F[var_5].size] = var_2;
  }
}

_id_9871() {
  var_0 = [];

  foreach(var_2 in level._id_2AA7) {
    var_3 = spawnStruct();
    var_3.origin = var_2.origin;
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_9876() {
  level endon("game_ended");

  if(scripts\mp\gametypes\br_public::_id_8805()) {
    return;
  }
  _id_9874();
  level waittill("br_prematchEnded");
  var_0 = getdvarint("#x329c50210717050d4", 5);
  var_1 = getdvarint("#x3a516337b6c6cb5c8", 6000);
  var_2 = getdvarint("#x34f5a32b5840f887", 360);
  var_3 = getdvarint("#x3518912b586718a9", 480);

  if(level.mapname == "mp_br_mechanics") {
    var_1 = 1000;
  }

  for(;;) {
    var_4 = getdvarint("#x38b7ba563d6505fef", 0);

    if(!var_4) {
      waitframe();
      continue;
    }

    var_5 = randomintrange(var_2, var_3);

    if(istrue(level._id_FE8D)) {
      _id_07D1::_id_60C2("activate_cash_helis");
    } else {
      wait(var_5);
    }

    if(level._id_9850.size < var_0) {
      var_6 = var_0 - level._id_9850.size;

      for(var_7 = 0; var_7 < var_6; var_7++) {
        var_8 = var_7 + 1;

        if(var_8 > 4) {
          var_8 = 1;
        }

        var_9 = _id_986F(level._id_984F["quad_" + var_8], var_1);

        if(!isDefined(var_9)) {
          wait 1;
        }

        if(var_7 == 0) {
          scripts\mp\gametypes\br_gametype_dmz::_id_DCE6("br_lootchopper_incoming");
        }

        _id_987D(var_9);

        if(istrue(level._id_FE8D)) {
          wait(randomintrange(1, 2));
        }
      }

      if(istrue(level._id_FE8D)) {
        return;
      }
      continue;
    }

    while(level._id_9850.size >= var_0) {
      waitframe();
    }
  }
}

_id_986F(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_3 = [];

    foreach(var_5 in var_0) {
      if(istrue(var_5._id_36AF)) {
        continue;
      }
      if(_id_9875(var_5, var_1)) {
        continue;
      }
      var_5._id_36AF = 1;
      var_3[var_3.size] = var_5;
    }

    if(var_3.size > 0) {
      var_2 = var_3[randomint(var_3.size)];
    }
  }

  return var_2;
}

_id_9875(var_0, var_1) {
  var_2 = 0;
  var_3 = level._id_984F;
  var_4 = var_1 * var_1;

  foreach(var_6 in var_3) {
    foreach(var_8 in var_6) {
      if(istrue(var_8._id_36AF)) {
        if(distance2dsquared(var_0.origin, var_8.origin) < var_4) {
          var_2 = 1;
          break;
        }
      }
    }

    if(istrue(var_2)) {
      break;
    }
  }

  return var_2;
}

_id_9872(var_0) {
  var_1 = undefined;
  var_2 = 0;

  foreach(var_5, var_4 in level._id_984F) {
    if(var_2 == var_0) {
      var_1 = var_4;
      break;
    }

    var_2++;
  }

  return var_1;
}

_id_987D(var_0) {
  var_1 = undefined;
  var_2 = getdvarint("#x362db5297ae9307f2", 4000);

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  } else {
    var_3 = [];

    foreach(var_5 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var_5)) {
        var_3[var_3.size] = var_5;
      }
    }

    if(var_3.size > 0) {
      var_7 = randomint(var_3.size);
      var_1 = var_3[var_7].origin;
    }

    if(isDefined(var_1)) {
      var_1 = scripts\mp\gametypes\br::_id_6BCA(var_1, (0, 0, 10000));
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_8 = _id_09AE::_id_6C1E(var_1);
  var_9 = vectortoangles(var_1 - var_8);
  var_10 = scripts\cp_mp\vehicles\vehicle_tracking::_id_0D7D(level.players[randomint(level.players.size)], var_8, var_9, "veh_chopper_support_dmz_mp", "veh8_mil_air_palfa_east");

  if(!isDefined(var_10)) {
    return;
  }
  var_10.speed = 100;
  var_10.accel = 50;
  var_10.lifetime = getdvarint("#x31187ca3446388a0e", 9999);
  var_10.team = "neutral";
  var_10.angles = var_9;
  var_10._id_5C8A = getdvarint("#x3fc16789ac37082cc", 0);
  var_10._id_41BE = 0;
  var_10._id_AEE6 = var_8;
  var_10._id_AEDC = var_1;
  var_10._id_41AF = "patrol";
  var_10._id_41FB = undefined;
  var_10._id_7668 = (0, 0, getdvarint("#x3e7e3fc36e1a04322", 1500));
  var_10._id_AF51 = var_0;
  var_10._id_AF49 = var_1;
  var_10._id_AF4C = var_2;
  var_10._id_E523 = 25;
  var_10._id_3E69 = var_10._id_7668[2] - 250;
  var_10 setmaxpitchroll(15, 15);
  var_10 vehicle_setspeed(var_10.speed, var_10.accel);
  var_10 sethoverparams(50, 5, 2.5);
  var_10 setturningability(0.5);
  var_10 setyawspeed(100, 25, 25, 0.1);
  var_10 setCanDamage(1);
  var_10 setneargoalnotifydist(768);
  var_10 _meth_83A6(var_10.team);
  var_10.health = getdvarint("#x38f96c47eb2721f4f", 5000);
  var_10.maxhealth = getdvarint("#x38f96c47eb2721f4f", 5000);
  var_10 _id_0812::_id_C2B2("Level_Vehicle", var_10.team);
  var_10 _id_987C();
  var_10 setscriptablepartstate("blinking_lights", "on", 0);
  var_10 setscriptablepartstate("engine", "on", 0);
  var_10._id_5FE5 = spawnturret("misc_turret", var_10 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var_10._id_5FE5 setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var_10._id_5FE5.team = var_10.team;
  var_10._id_5FE5.angles = var_10.angles;
  var_10._id_5FE5._id_F88D = 1;
  var_10._id_5FE5.name = "front_turret";
  var_10._id_5FE5._id_1DF2 = undefined;
  var_10._id_5FE5._id_10324 = "loot_chopper";
  var_10._id_5FE5 linkto(var_10);
  var_10._id_5FE5 _meth_83A0(var_10.team);
  var_10._id_5FE5 _meth_839D(0);
  var_10._id_5FE5 setmode("manual");
  var_10._id_5FE5 setdefaultdroppitch(45);
  var_10._id_5FE5._id_71F1 = spawn("script_model", var_10.origin);
  var_10._id_5FE5._id_71F1 setModel("tag_origin");
  var_10._id_5FE5._id_71F1 dontinterpolate();
  var_10._id_C0C8 = spawnturret("misc_turret", var_10 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var_10._id_C0C8 setModel("veh8_mil_air_ahotel64_turret_wm_east");
  var_10._id_C0C8.team = var_10.team;
  var_10._id_C0C8.angles = var_10.angles;
  var_10._id_C0C8._id_F88D = 1;
  var_10._id_C0C8.name = "rear_turret";
  var_10._id_C0C8._id_1DF2 = undefined;
  var_10._id_C0C8._id_10324 = "loot_chopper";
  var_10._id_C0C8 linkto(var_10);
  var_10._id_C0C8 _meth_83A0(var_10.team);
  var_10._id_C0C8 _meth_839D(0);
  var_10._id_C0C8 setmode("manual");
  var_10._id_C0C8 setdefaultdroppitch(45);
  var_10._id_C0C8._id_71F1 = spawn("script_model", var_10.origin);
  var_10._id_C0C8._id_71F1 setModel("tag_origin");
  var_10._id_C0C8._id_71F1 dontinterpolate();
  level._id_9850[level._id_9850.size] = var_10;
  var_10._id_AF47 = ::_id_9879;
  var_10._id_9883 = ::_id_986D;
  var_10._id_3887 = ::_id_986B;
  var_10 _id_986C();
  var_10 thread _id_09AE::_id_36D4();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    var_10 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](_id_09AE::_id_36C8);
  }

  var_10 thread _id_09AE::_id_36D3(var_10._id_AEDC, 1);
}

_id_987C() {
  self._id_1031E = "loot_chopper";
  _id_0AAF::_id_D42B(self._id_1031E, 20);
  _id_9877("s4_la_walpha2_mp", 2.85714, 20);
  _id_9877("s4_ar_stango44_mp", 2.85714, 20);
  _id_9877("s4_c4_mp", 4.0, 20);
  _id_9877("s4_semtex_mp", 2.85714, 20);
  _id_9877("s4_frag_usa_mk2_mp", 2.85714, 20);
  _id_9877("s4_sticky_eng_n74_mp", 2.85714, 20);
  _id_9877("pop_rocket_mp", 2.85714, 20);
  _id_9877("s4_molotov_mp", 1.81818, 20);
  _id_9877("at_mine_ap_mp", 1.81818, 20);
  _id_9877("at_mine_mp", 2.85714, 20);
  _id_9877("s4_thermite_mp", 1, 36);
  _id_9877("thermite_av_mp", 1, 36);
  _id_9877("thermite_bolt_mp", 1, 36);
  _id_9877("emp_grenade_mp", 2.85714, 20);
  _id_9877("claymore_mp", 2.85714, 20);
  _id_9877("apache_proj_mp", 5.0, 20);
  _id_9877("s4_ks_ord_ger_mp", 2.85714, 20);
  _id_9877("cruise_proj_mp", 6.66667, 20);
  _id_9877("s4_strafing_run_mp", 6.66667, 20);
  _id_9877("nuke_mp", 10.0, 20);
  _id_9877("ac130_105mm_mp", 10.0, 20);
  _id_9877("ac130_40mm_mp", 5.0, 20);
  _id_9877("ac130_25mm_mp", 2.85714, 20);
  _id_9877("hover_jet_proj_mp", 5.0, 20);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10037(self);
  _id_0AAF::_id_6817(self._id_1031E, 1);
  _id_0AAF::_id_D35F(self._id_1031E, ::_id_987B);
  _id_0AAF::_id_D35C(self._id_1031E, ::_id_987A);
  _id_0AAF::_id_D1AC(self._id_1031E, ::_id_9873);
  scripts\cp_mp\vehicles\vehicle_tracking::_id_102C5(self);
}

_id_9877(var_0, var_1, var_2) {
  _id_0AAF::_id_D447(var_0, var_1, self._id_1031E);
  _id_0AAF::_id_D42C(self._id_1031E, var_2, var_0);
}

_id_987B(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;
  return 1;
}

_id_987A(var_0) {
  _id_09AE::_id_36D0(var_0);

  if(!isDefined(self._id_1DDE)) {
    self._id_1DDE = [];
  }

  var_1 = _id_9870(var_0.attacker);

  if(!isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.player = var_0.attacker;
    var_2.objweapon = var_0.objweapon;
    var_2._id_F374 = var_0.damage;
    self._id_1DDE[self._id_1DDE.size] = var_2;
  } else {
    var_1._id_F374 = var_1._id_F374 + var_0.damage;
    var_1.objweapon = var_0.objweapon;
  }

  return 1;
}

_id_9873(var_0) {
  _id_09AE::_id_36C7(var_0);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = var_0.attacker;

  foreach(var_5 in self._id_1DDE) {
    if(isDefined(var_5.player)) {
      if(var_3 == var_5.player) {
        var_1 = "br_loot_chopper_destroyed";
      } else {
        var_1 = "br_loot_chopper_destroyed_assist";
      }

      var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
      var_5.player thread scripts\mp\rank::giverankxp(var_1, var_2, var_5.objweapon);
      var_5.player thread _id_07CE::_id_8D83(var_1, 0);
    }
  }

  self notify("death");
  return 1;
}

_id_9879(var_0) {
  if(self._id_41AF != "patrol") {
    self._id_41AF = "patrol";
  } else if(self._id_41AF == "patrol" && !istrue(var_0)) {
    return;
  }
  self _meth_807E();
  self setneargoalnotifydist(300);
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    if(self._id_41AF == "attacking") {
      if(!istrue(var_1)) {
        var_1 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_0) && istrue(var_1)) {
      var_1 = 0;
    }

    var_3 = self._id_AF49 + anglesToForward((0, var_2, 0)) * int(self._id_AF4C / 1.2);
    var_2 = var_2 + 90;
    _id_09AE::_id_36D3(var_3, 1);

    if(var_2 >= 360) {
      var_2 = 0;
    }

    wait 0.5;
  }
}

_id_986D() {
  var_0 = _id_986E(self.origin + (0, 0, 500));

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::_id_501E(self.origin, var_0);
    var_2 = scripts\cp_mp\killstreaks\airdrop::_id_6E00(var_1);
    var_2._id_FEE9 = 10;
  }
}

_id_986E(var_0) {
  var_1 = undefined;
  var_2 = var_0 - (0, 0, 20000);
  var_3 = [self, self._id_5FE5, self._id_C0C8];
  var_4 = scripts\engine\trace::ray_trace(var_0, var_2, var_3);

  if(isDefined(var_4) && var_4["hittype"] != "hittype_none") {
    var_1 = var_4["position"];
  }

  return var_1;
}

_id_9878(var_0) {
  var_1 = getdvarint("#x33476e44c3adf9dfd", 100000);

  if(istrue(level._id_25BB)) {
    var_2 = getdvarint("#x3d26fbf1a24daa1e1", 50000);
    var_1 = var_1 + var_2;
  }

  self._id_8B39 = 0;
  var_3 = scripts\mp\gametypes\br_plunder::_id_5052(var_1 / 100, 10);

  foreach(var_5 in var_3) {
    var_5._id_9898 = "loot_chopper";
  }

  if(!isDefined(var_0._id_9868)) {
    var_0._id_9868 = 1;
  } else {
    var_0._id_9868++;
  }

  var_0 scripts\mp\utility\stats::_id_D551(var_0._id_9868);
  var_0 thread _id_0A9F::_id_7003("br_loot_chopper_box_open");
}

_id_986B() {
  if(isDefined(self._id_5078)) {
    self._id_5078 delete();
  }

  if(isDefined(self._id_AF51)) {
    self._id_AF51._id_36AF = undefined;
  }

  if(isDefined(self._id_A8DA)) {
    _id_07F9::_id_C799(self._id_A8DA);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_102BB(self);
  level._id_9850 = scripts\engine\utility::array_remove(level._id_9850, self);
}

_id_986C() {
  var_0 = _id_07F9::_id_C57D(1);

  if(var_0 != -1) {
    _id_07F9::_id_A867(var_0, "active", self.origin, "ui_mp_br_mapmenu_icon_boss_chopper", "icon_medium");
    _id_07F9::_id_FB98(var_0, 1);
    _id_07F9::_id_A8A2(var_0);
    _id_07F9::_id_FB93(var_0, self);
    _func_042B(var_0, 1);
  }

  self._id_A8DA = var_0;
}

_id_9870(var_0) {
  var_1 = undefined;

  foreach(var_3 in self._id_1DDE) {
    if(var_0 == var_3.player) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}