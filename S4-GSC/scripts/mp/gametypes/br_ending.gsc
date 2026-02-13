/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_ending.gsc
*************************************************/

_id_2A40() {
  if(getDvar("#x3f59526763711edc4") != "") {
    return;
  }
  setdvarifuninitialized("#x3b3c298a62502135b", 1);
  _id_3678();
}

_id_30E0() {
  if(!getdvarint("#x3b3c298a62502135b")) {
    return 0;
  }

  if(getDvar("#x3f59526763711edc4") != "") {
    return 0;
  }

  if(istrue(level._id_2AB3)) {
    return 0;
  }

  return 1;
}

_id_B21F(var_0, var_1) {
  if(!_id_30E0()) {
    return;
  }
  var_0 = scripts\engine\utility::_id_1BD1(var_0);
  var_0 = scripts\engine\utility::_id_1BD6(var_0, ::_id_3AF4);
  level notify("br_ending_start");
  level._id_2B51 = 1;
  var_2 = _id_3F08(var_0, var_1);
  var_2 _id_D1EC("chopper", var_1);
  var_0 = undefined;
  level._id_2A3D = var_2;
  _id_531F(var_2);
  var_3 = _id_5320(var_2);
  _id_3915(var_2.origin, 1000);
  var_2 _id_06C6::_id_17C2(var_2._id_2FE0, var_2._id_ADCD[0]._id_18A3);

  foreach(var_5 in level.players) {
    var_5 cameralinkto(var_2._id_2FE0, "tag_player", 1, 1);
  }

  foreach(var_8 in var_2._id_ADCD) {
    if(isDefined(var_8._id_E6AF)) {
      [[var_8._id_E6AF]](var_8._id_AE48);
    }

    if(isDefined(var_8._id_605B)) {
      playFX(scripts\engine\utility::getfx(var_8._id_605B), var_8._id_6098, anglesToForward(var_8._id_6086), anglestoup(var_8._id_6086));
    }

    if(var_8.players.size > 0) {
      var_8.players = scripts\engine\utility::_id_1BD1(var_8.players);

      foreach(var_5 in var_8.players) {
        var_5 dontinterpolate();

        if(isDefined(var_5._id_950B)) {
          if(!isPlayer(var_5)) {
            var_5._id_950B thread _id_06C6::_id_1845(var_5._id_B5A4, var_8._id_18A3, var_5._id_950C);
          } else {
            var_5._id_950B thread _id_07AA::_id_17FD(var_5, var_5._id_B5A4, var_8._id_18A3, var_5._id_950C);
          }

          continue;
        }

        if(!isPlayer(var_5)) {
          var_2 thread _id_06C6::_id_1845(var_5._id_B5A4, var_8._id_18A3);
          continue;
        }

        var_2 thread _id_07AA::_id_17FD(var_5, var_5._id_B5A4, var_8._id_18A3);
      }

      foreach(var_12 in var_2._id_B5AF) {
        if(isDefined(var_12.player)) {
          continue;
        }
        if(isDefined(var_12._id_950B)) {
          var_12._id_950B thread _id_06C6::_id_1845(var_12, var_8._id_18A3, var_12._id_950C);
          continue;
        }

        var_2 thread _id_06C6::_id_1845(var_12, var_8._id_18A3);
      }
    }

    if(var_8._id_5526.size > 0) {
      foreach(var_15 in var_8._id_5526) {
        var_15 dontinterpolate();
      }

      var_2 thread _id_06C6::_id_183B(var_8._id_5526, var_8._id_18A3);
    }

    var_2._id_2FE0 dontinterpolate();
    var_2 _id_06C6::_id_1845(var_2._id_2FE0, var_8._id_18A3);
    waitframe();
  }

  wait 1;

  foreach(var_8 in var_2._id_ADCD) {
    foreach(var_15 in var_8._id_5526) {
      if(isDefined(var_15)) {
        if(isDefined(var_15._id_9505)) {
          scripts\engine\utility::_id_1BA4(var_15._id_9505);
        }

        var_15 delete();
      }
    }
  }

  _id_15E6();

  foreach(var_5 in level.players) {
    if(isDefined(var_5) && isDefined(var_5._id_B5A4)) {
      if(isDefined(var_5.sessionstate) && var_5.sessionstate == "spectator") {
        var_5 _meth_8380(var_2.origin, var_2.angles);
      } else {
        var_5 setorigin(var_2.origin);
      }

      var_5._id_B5A4 delete();
    }
  }

  var_2._id_2FE0 delete();
}

_id_3AF4(var_0, var_1) {
  return var_0.pers["score"] > var_1.pers["score"];
}

_id_F04A() {
  wait 25;

  foreach(var_1 in level.players) {
    var_1 setplayermusicstate("");
  }
}

_id_531F(var_0) {
  level._id_2C3C = 1;
  level notify("brSpawnPlayersEnding");

  foreach(var_2 in level.players) {
    var_2 _meth_8282(var_0.origin);
    var_2 scripts\mp\utility\player::_id_7903();
    var_2 _meth_8638("disabled");
    var_2 setclientomnvar("ui_br_squad_eliminated_active", 0);

    if(isDefined(var_2.sessionstate)) {
      if(var_2.sessionstate == "intermission") {
        var_2 scripts\mp\utility\player::_id_FD26("spectator");
      }

      if(var_2.sessionstate == "spectator") {
        var_2 _meth_8380(var_0._id_2FE0.origin, var_0._id_2FE0.angles);
        var_2 spawn(var_0._id_2FE0.origin, var_0._id_2FE0.angles);
        continue;
      }

      var_2 setorigin(var_0.origin + (0, 0, 100));
    }
  }
}

_id_5320(var_0) {
  var_1 = var_0._id_10E5A;
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(isDefined(var_4.sessionstate) && var_4.sessionstate == "playing") {
      var_2 = var_4.origin;
      break;
    }
  }

  var_6 = [];
  var_7 = 0;

  foreach(var_12, var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isPlayer(var_4)) {
      continue;
    }
    if(isDefined(var_4.sessionstate) && var_4.sessionstate != "playing") {
      var_4._id_5EC7 = var_2;
      var_4 scripts\mp\playerlogic::_id_E337(0);
    }

    var_4 _id_B443();
    var_4 _id_B39D();
    var_4._id_B928 = 1;
    var_4._id_ABE7 = 1;
    var_4._id_950B = undefined;
    var_4._id_950C = undefined;
    var_9 = var_4 scripts\mp\teams::_id_9817(var_4.team);
    var_10 = scripts\mp\teams::_id_6BD4(var_9);
    var_11 = "ui_br_winner" + var_7;
    var_4._id_10E51 = var_7;
    var_7++;
    _func_01EA(var_11, var_4 getentitynumber());

    if(!isDefined(var_4._id_18AF) || var_4._id_18AF != var_4._id_2BB4) {
      var_4._id_18AF = var_4._id_2BB4;
    }

    var_4 thread _id_B5CC();
    var_4 _id_3F5D(var_4._id_18AF, "viewhands_base_iw8", var_0.origin);
    level thread _id_5311(var_4);
    var_6[var_6.size] = var_4._id_B5A4;
  }

  return var_6;
}

_id_3EFC(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  var_1._id_8802 = 1;
  var_1._id_2BB4 = "player0";
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 _id_3F5D(var_1._id_2BB4, "viewhands_base_iw8", var_0.origin);
  var_1 linkto(var_1._id_B5A4, "tag_player", (0, 0, 0), (0, 0, 0));
  level thread _id_5311(var_1, 1);
  var_0._id_10E5A[0] = var_1;
}

_id_B443() {
  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017D(self.vehicle);
  }

  if(istrue(self._id_FF04)) {
    _id_0789::_id_1C24();
  }

  if(isDefined(self._id_C344)) {
    self._id_C344 _id_0A5E::_id_C358();
  }

  if(isDefined(self._id_4205)) {
    _id_09BA::_id_9A7E(self._id_4205);
  }

  if(istrue(self._id_61D4)) {
    scripts\mp\gametypes\br_pickups::_id_C4C7();
  }

  if(isDefined(self._id_FF18)) {
    var_0 = _func_0262();

    foreach(var_2 in var_0) {
      if(isDefined(var_2.owner) && var_2.owner == self) {
        if(isDefined(var_2._id_786F)) {
          var_2 _id_09B5::_id_786C(1);
        }
      }
    }
  }
}

_id_B39D() {
  if(!isPlayer(self)) {
    return;
  }
  scripts\mp\utility\player::_freezecontrols(1);
  self disableoffhandweapons();
  self allowmelee(0);
  self allowads(0);
  self allowfire(0);
  self disableweaponswitch();
  scripts\common\utility::_id_158B(0);
  self _meth_86B4();
}

_id_B39E() {
  if(!isPlayer(self)) {
    return;
  }
  scripts\mp\utility\player::_freezecontrols(0);
  self enableoffhandweapons();
  self allowmelee(1);
  self allowads(1);
  self allowfire(1);
  self enableweaponswitch();
  scripts\common\utility::_id_158B(1);
}

_id_5311(var_0, var_1) {
  var_2 = var_0._id_B5A4;
  var_3 = isPlayer(var_0);

  if(!isDefined(var_1)) {
    var_0 waittill("disconnect");
  } else {
    wait 0.1;
  }

  if(!isDefined(var_2)) {
    return;
  }
  playFXOnTag(scripts\engine\utility::getfx("player_disconnect"), var_2, "tag_player");
}

_id_B5CC() {
  var_0 = undefined;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3.classname != "rifle") {
      continue;
    }
    var_0 = var_3;

    if(isDefined(var_0)) {
      break;
    }
  }

  if(!isnullweapon(self._id_0133)) {
    self clearaccessory();
    self takeallweapons();
  } else
    waitframe();

  if(!isDefined(var_0)) {
    var_0 = scripts\mp\class::buildweapon_blueprint("s4_ar_stango44", "none", "none", 1);
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  self.pers["primaryWeapon"] = getcompleteweaponname(var_0);
  self._id_034C = getcompleteweaponname(var_0);
  self.primaryweaponobj = var_0;
  self._id_03B5 = undefined;
  self.secondaryweaponobj = undefined;

  if(self getweaponammoclip(var_0) < 5) {
    self setweaponammoclip(var_0, 5);
  }

  var_5 = self switchtoweapon(var_0);
}

_id_D1EC(var_0, var_1) {
  switch (var_0) {
    default:
      _id_3668(var_1);
      break;
  }
}

_id_3F08(var_0, var_1) {
  var_2 = _id_6473(var_0, var_1);
  var_2._id_10E5A = var_0;
  var_2._id_2FE0 = var_2 _id_3EDE();
  return var_2;
}

_id_6473(var_0, var_1) {
  if(level.script == "mp_br_mechanics") {
    var_2 = scripts\engine\utility::getstructarray("br_ending_spot", "targetname");
  } else if(level.script == "mp_br_quarry") {
    var_2 = _id_A290();
  } else {
    var_2 = _id_A296();
  }

  var_0 = scripts\engine\utility::_id_1BD1(var_0);

  if(var_0.size > 0) {
    var_3 = _id_63BB(var_0);
  } else {
    var_3 = var_1;
  }

  var_2 = _func_0204(var_2, var_3);

  if(!isDefined(var_2[0].angles)) {
    var_2[0].angles = (0, 0, 0);
  }

  return var_2[0];
}

_id_3915(var_0, var_1) {
  var_2 = _func_0425(var_0, var_1, 20000);

  foreach(var_4 in var_2) {
    var_4 delete();
  }
}

_id_A296() {
  var_0 = [];
  var_0[0] = _id_3F78((-35516, -26964, -290.492), (0, -37.2493, 0), 1);
  var_0[1] = _id_3F78((-24507.4, -31751.5, -118), (0, 24.7373, 0));
  var_0[2] = _id_3F78((-18475.3, -38031.3, 1390), (0, 21.3294, 0));
  var_0[3] = _id_3F78((-22962.6, -26693.8, -133.431), (0, -79.9927, 0), 1);
  var_0[4] = _id_3F78((-21665.5, -27275.8, -148.989), (0, -36.6941, 0), 1);
  var_0[5] = _id_3F78((-21726, -25961.2, -146), (0, -108.126, 0), 1);
  var_0[6] = _id_3F78((-12285.8, -40588.5, 518.07), (0, -148.112, 0), 1);
  var_0[7] = _id_3F78((-36409.6, -14177.9, -286.708), (0, -15.7255, 0), 1);
  var_0[8] = _id_3F78((-30525.8, -17654.2, -234.947), (0, -127.959, 0), 1);
  var_0[9] = _id_3F78((-17170.3, -31131.8, 264.201), (0, -174.161, 0), 1);
  var_0[10] = _id_3F78((-28797.3, -17400, -241.606), (0, 16.8587, 0));
  var_0[11] = _id_3F78((-18155.4, -27275.3, -224.811), (0, -121.999, 0), 1);
  var_0[12] = _id_3F78((-9975.39, -38284.4, 344.1), (0, -46.4665, 0), 1);
  var_0[13] = _id_3F78((-29281.2, -13754.2, -145.391), (0, -11.8112, 0));
  var_0[14] = _id_3F78((-17821.6, -23448.4, -262), (0, 62.3774, 0), 1);
  var_0[15] = _id_3F78((-18619.8, -20889.8, -257.189), (0, -71.9892, 0), 1);
  var_0[16] = _id_3F78((-14480.9, -25405.9, -288.831), (0, 154.786, 0), 1);
  var_0[17] = _id_3F78((-9256.33, -33580.9, 158.984), (0, 146.051, 0), 1);
  var_0[18] = _id_3F78((-8492.02, -34971.8, 166.312), (0, 161.494, 0), 1);
  var_0[19] = _id_3F78((-16599, -22468.6, -278.939), (0, 154.273, 0), 1);
  var_0[20] = _id_3F78((-11999.8, -28038.4, -31.998), (0, 5.45263, 0), 1);
  var_0[21] = _id_3F78((-32056.9, -9169.36, -306.919), (0, 71.9528, 0));
  var_0[22] = _id_3F78((-23530.6, -14806.7, -69.1128), (0, -153.028, 0), 1);
  var_0[23] = _id_3F78((-27480.3, -10672.5, -69.3776), (0, -3.16859, 0), 1);
  var_0[24] = _id_3F78((-4660.23, -38889.8, 608.219), (0, 63.5175, 0), 1);
  var_0[25] = _id_3F78((-10475.2, -27452, -31.9999), (0, 118.642, 0), 1);
  var_0[26] = _id_3F78((-20693.1, -15175.3, -304), (0, -66.6904, 0));
  var_0[27] = _id_3F78((-16776.3, -18894, -338.316), (0, -15.0922, 0), 1);
  var_0[28] = _id_3F78((-26751, -7621.31, 40.6807), (0, 58.4382, 0));
  var_0[29] = _id_3F78((-13668.5, -18519.2, -368), (0, -143.119, 0));
  var_0[30] = _id_3F78((-22473.8, -10149.8, -301.138), (0, -70.3961, 0), 1);
  var_0[31] = _id_3F78((-11184.8, -21061.9, -315.854), (0, 5.70909, 0), 1);
  var_0[32] = _id_3F78((-30018.7, -4590.08, -316.327), (0, 23.8697, 0));
  var_0[33] = _id_3F78((-4140.38, -30726.9, 278.381), (0, -144.114, 0));
  var_0[34] = _id_3F78((-34822.4, -1184.25, -263.947), (0, -71.6069, 0), 1);
  var_0[35] = _id_3F78((-26229.5, -4015.4, -313.889), (0, -117.77, 0), 1);
  var_0[36] = _id_3F78((-30027.8, -1782.43, -313.225), (0, 175.937, 0));
  var_0[37] = _id_3F78((-27619.2, -2302.54, -313.891), (0, -8.77301, 0), 1);
  var_0[38] = _id_3F78((-7118.65, -19301.2, -144), (0, -5.73525, 0), 1);
  var_0[39] = _id_3F78((-10491.1, -14985.5, -360), (0, -103.058, 0), 1);
  var_0[40] = _id_3F78((-14283.6, -11003.1, -315.39), (0, 7.08201, 0));
  var_0[41] = _id_3F78((-23169, -3966.54, -321.134), (0, -83.3339, 0), 1);
  var_0[42] = _id_3F78((-8787.73, -15589.1, -367.949), (0, 100.158, 0), 1);
  var_0[43] = _id_3F78((-817.503, -25527.6, -256.485), (0, -66.9498, 0), 1);
  var_0[44] = _id_3F78((-14242.2, -8993.57, -285.128), (0, 40.3822, 0));
  var_0[45] = _id_3F78((4555.72, -36115.3, -200.848), (0, -156.66, 0), 1);
  var_0[46] = _id_3F78((1627.87, -28799.2, 312), (0, 150.838, 0), 1);
  var_0[47] = _id_3F78((-9101.03, -10035.7, -320), (0, 33.7296, 0));
  var_0[48] = _id_3F78((-6042.41, -13135.6, -363.999), (0, -134.727, 0), 1);
  var_0[49] = _id_3F78((3185.75, -25611.3, -288.702), (0, 93.1862, 0), 1);
  var_0[50] = _id_3F78((1792.7, -23147, -290.615), (0, -151.835, 0), 1);
  var_0[51] = _id_3F78((-35463.8, 7869.36, 52.9549), (0, -93.1204, 0), 1);
  var_0[52] = _id_3F78((-716.066, -18775.2, 934), (0, -148.79, 0));
  var_0[53] = _id_3F78((1588.6, -20401.1, -285), (0, -58.1805, 0));
  var_0[54] = _id_3F78((12452, -35755.6, -484), (0, -28.7822, 0), 1);
  var_0[55] = _id_3F78((4648.29, -19224.9, -286.002), (0, 28.824, 0), 1);
  var_0[56] = _id_3F78((-21706.1, 6555.31, -279.84), (0, 5.8398, 0), 1);
  var_0[57] = _id_3F78((-16018.1, 4086.84, -318.486), (0, 3.79374, 0), 1);
  var_0[58] = _id_3F78((-25374.2, 10918.1, -320), (0, 120.887, 0), 1);
  var_0[59] = _id_3F78((-12119.8, 2981.18, -329.815), (0, 105.554, 0), 1);
  var_0[60] = _id_3F78((-14767.3, 5096.92, -400.009), (0, 131.701, 0), 1);
  var_0[61] = _id_3F78((8177.97, -19326, -286.002), (0, 91.7841, 0), 1);
  var_0[62] = _id_3F78((15726.9, -35325.4, 318.345), (0, 151.377, 0), 1);
  var_0[63] = _id_3F78((11454.7, -22581.5, -214.023), (0, -92.045, 0), 1);
  var_0[64] = _id_3F78((-21126.1, 11662.1, -317.002), (0, -174.747, 0), 1);
  var_0[65] = _id_3F78((-7293.09, 3009.49, -317.508), (0, -152.562, 0), 1);
  var_0[66] = _id_3F78((17629.6, -32800.1, 15.9988), (0, 7.32444, 0), 1);
  var_0[67] = _id_3F78((504.818, -3834.63, -449), (0, 66.6309, 0), 1);
  var_0[68] = _id_3F78((-25415.2, 15191.1, -325.003), (0, -84.1954, 0), 1);
  var_0[69] = _id_3F78((13957.3, -21816.1, -194), (0, -75.6819, 0), 1);
  var_0[70] = _id_3F78((-10176, 6713.5, -400), (0, 75.3382, 0), 1);
  var_0[71] = _id_3F78((-15327.9, 10742.1, -400), (0, 32.2232, 0), 1);
  var_0[72] = _id_3F78((8420.99, -11753.6, 306), (0, 83.4712, 0), 1);
  var_0[73] = _id_3F78((-22216, 14718, -64.0002), (0, -82.0633, 0), 1);
  var_0[74] = _id_3F78((-17022, 11976.4, -322.43), (0, 105.663, 0), 1);
  var_0[75] = _id_3F78((-30924.8, 19829.7, 205), (0, -69.3892, 0), 1);
  var_0[76] = _id_3F78((-2024.99, 3060.21, -330.017), (0, -158.048, 0), 1);
  var_0[77] = _id_3F78((-28136.9, 19575.5, -448.227), (0, -98.4958, 0), 1);
  var_0[78] = _id_3F78((-12771.2, 11772.2, -326.973), (0, 19.9583, 0), 1);
  var_0[79] = _id_3F78((22131, -32223, -440), (0, 119.727, 0), 1);
  var_0[80] = _id_3F78((-5075.7, 7706.88, -323.004), (0, 133.054, 0), 1);
  var_0[81] = _id_3F78((-22334.3, 18697.4, 688.005), (0, 140.553, 0), 1);
  var_0[82] = _id_3F78((-25425.5, 20658.8, -448), (0, 0.274191, 0), 1);
  var_0[83] = _id_3F78((23625.3, -31238.1, -563.054), (0, -52.2092, 0), 1);
  var_0[84] = _id_3F78((-33327.4, 24789.2, 12.4296), (0, -44.4776, 0), 1);
  var_0[85] = _id_3F78((21118.3, -22709.8, -232), (0, 42.769, 0));
  var_0[86] = _id_3F78((-28418.1, 23715.5, -447.994), (0, -89.5397, 0), 1);
  var_0[87] = _id_3F78((16769.7, -13392.7, 356.076), (0, -37.8018, 0));
  var_0[88] = _id_3F78((-13952.5, 17259.8, -324), (0, -76.2444, 0), 1);
  var_0[89] = _id_3F78((24205.4, -25029.5, -328.008), (0, 169.376, 0), 1);
  var_0[90] = _id_3F78((12118.5, -3994.79, -340.649), (0, -23.2087, 0), 1);
  var_0[91] = _id_3F78((-17899.8, 21527.3, -450.34), (0, -8.05977, 0), 1);
  var_0[92] = _id_3F78((22217.9, -18422.9, 632), (0, 162.28, 0), 1);
  var_0[93] = _id_3F78((21407.1, -16363.3, 1916.75), (0, -1.0712, 0), 1);
  var_0[94] = _id_3F78((-2832.02, 13488.4, -319.985), (0, -0.230498, 0), 1);
  var_0[95] = _id_3F78((3266.46, 9488.52, -317.067), (0, 97.6153, 0), 1);
  var_0[96] = _id_3F78((22117.5, -13790.4, 256.102), (0, 135.758, 0), 1);
  var_0[97] = _id_3F78((24850.9, -18555.2, -208.2), (0, -76.8969, 0), 1);
  var_0[98] = _id_3F78((-23053.6, 27499.5, -460.201), (0, 83.541, 0), 1);
  var_0[99] = _id_3F78((-8326.54, 20049.9, -257.261), (0, 110.381, 0), 1);
  var_0[100] = _id_3F78((19238.7, -6573.38, -40), (0, -88.569, 0));
  var_0[101] = _id_3F78((-36685.3, 33440.3, 1474.01), (0, -73.7051, 0), 1);
  var_0[102] = _id_3F78((26569.7, -16938.2, -221.571), (0, 92.2376, 0), 1);
  var_0[103] = _id_3F78((26412.2, -13112.5, -264), (0, 55.7859, 0), 1);
  var_0[104] = _id_3F78((20248.8, -2154.65, -506.989), (0, 116.839, 0));
  var_0[105] = _id_3F78((-6577.92, 23388.3, -448.004), (0, -101.867, 0), 1);
  var_0[106] = _id_3F78((18069.7, 1558.6, -590.448), (0, -85.7224, 0), 1);
  var_0[107] = _id_3F78((-10855.2, 27363.9, -259.411), (0, 148.092, 0), 1);
  var_0[108] = _id_3F78((-2919.92, 22409.8, -446.75), (0, -78.7055, 0), 1);
  var_0[109] = _id_3F78((-16866.8, 30593, -225.8), (0, -75.0401, 0), 1);
  var_0[110] = _id_3F78((37954.1, -37722.9, -577.993), (0, 69.8195, 0), 1);
  var_0[111] = _id_3F78((35023.3, -24338.2, -566), (0, 53.0156, 0), 1);
  var_0[112] = _id_3F78((16187.4, 8712.66, -332.163), (0, -84.2018, 0), 1);
  var_0[113] = _id_3F78((-25609.6, 36743.4, 348.439), (0, -160.438, 0));
  var_0[114] = _id_3F78((-14068.2, 31959.7, -250.623), (0, -153.916, 0), 1);
  var_0[115] = _id_3F78((29348.7, -8361.65, -424.006), (0, -81.6393, 0), 1);
  var_0[116] = _id_3F78((8670.39, 18913.1, -303.729), (0, 105.535, 0), 1);
  var_0[117] = _id_3F78((35020.4, -16139.2, -572.017), (0, 58.7604, 0), 1);
  var_0[118] = _id_3F78((19630.8, 10158.6, -451.09), (0, -142.492, 0), 1);
  var_0[119] = _id_3F78((43465.3, -36148.1, 51.093), (0, 112.905, 0));
  var_0[120] = _id_3F78((-19560, 39017.6, -640), (0, 105.902, 0));
  var_0[121] = _id_3F78((3395.98, 28640.1, 1.42773), (0, 135.948, 0), 1);
  var_0[122] = _id_3F78((-12456.8, 38252.8, 0.642883), (0, 136.198, 0));
  var_0[123] = _id_3F78((34810.3, -3657.19, -488), (0, -139.433, 0));
  var_0[124] = _id_3F78((48307, -38482.1, 2272), (0, 54.6218, 0), 1);
  var_0[125] = _id_3F78((17534.5, 19736.7, 318.301), (0, -103.234, 0), 1);
  var_0[126] = _id_3F78((49054.6, -37186.3, 2272.02), (0, 62.8379, 0), 1);
  var_0[127] = _id_3F78((-26149.3, 47192.9, 2703.16), (0, 36.4515, 0));
  var_0[128] = _id_3F78((50932.9, -41318, 1347), (0, -109.525, 0), 1);
  var_0[129] = _id_3F78((44159.8, -13820.7, -87.1293), (0, -7.88874, 0));
  var_0[130] = _id_3F78((51090.6, -34587.3, 1343.9), (0, -9.93786, 0), 1);
  var_0[131] = _id_3F78((32681, 7595.22, -497.554), (0, -48.5794, 0), 1);
  var_0[132] = _id_3F78((35336.5, 3905.92, -551.754), (0, -23.8152, 0), 1);
  var_0[133] = _id_3F78((52357.4, -33339, 1258.09), (0, -20.541, 0), 1);
  var_0[134] = _id_3F78((-520.246, 39710.8, 2783), (0, -72.5011, 0), 1);
  var_0[135] = _id_3F78((45634.6, -11566.6, -58.2778), (0, -151.105, 0), 1);
  var_0[136] = _id_3F78((50376.7, -21886.4, -395.252), (0, -23.787, 0));
  var_0[137] = _id_3F78((51570.2, -24783.1, -113.531), (0, 104.684, 0), 1);
  var_0[138] = _id_3F78((39824, 1114.83, -424.993), (0, 138.361, 0), 1);
  var_0[139] = _id_3F78((25390.7, 20043.1, 1343.21), (0, 135.63, 0), 1);
  var_0[140] = _id_3F78((52294.1, -25802.7, -83.0376), (0, -19.67, 0), 1);
  var_0[141] = _id_3F78((-11742.3, 47596, 1790.51), (0, -161.796, 0), 1);
  var_0[142] = _id_3F78((44198.1, -4238.47, 266.547), (0, -102.295, 0));
  var_0[143] = _id_3F78((48747.6, -12179.9, 14.8108), (0, -111.192, 0), 1);
  var_0[144] = _id_3F78((46453.4, -6647.04, 208.457), (0, -15.0621, 0), 1);
  var_0[145] = _id_3F78((12849.3, 34747.5, 2458.5), (0, -39.4017, 0), 1);
  var_0[146] = _id_3F78((52493.1, -17205.6, -391.658), (0, 19.0522, 0), 1);
  var_0[147] = _id_3F78((54470.9, -21095.7, -394.817), (0, -68.4661, 0));
  var_0[148] = _id_3F78((-24417, 56523.2, 2659.76), (0, -129.922, 0), 1);
  var_0[149] = _id_3F78((37257.1, 13799.8, 232), (0, 22.0809, 0), 1);
  var_0[150] = _id_3F78((23294, 29633.7, 1019.7), (0, 17.9623, 0), 1);
  var_0[151] = _id_3F78((-9892.05, 53353.9, 2428.22), (0, -25.4412, 0));
  var_0[152] = _id_3F78((49428.4, 1843.77, 19.9863), (0, 175.256, 0), 1);
  var_0[153] = _id_3F78((3411.24, 49881.5, 1032), (0, 83.1958, 0), 1);
  var_0[154] = _id_3F78((57090, -11008.2, -433.158), (0, -94.4655, 0), 1);
  var_0[155] = _id_3F78((20175.4, 39040, 957.372), (0, 82.8313, 0), 1);
  var_0[156] = _id_3F78((-8255.86, 57148.3, 1071.37), (0, -11.2614, 0), 1);
  var_0[157] = _id_3F78((51848.1, 3726.24, 29.3418), (0, 172.199, 0), 1);
  var_0[158] = _id_3F78((50898.1, 6776.73, 29.7878), (0, -8.3196, 0), 1);
  var_0[159] = _id_3F78((-17676, 62373.4, 1908.92), (0, -4.78614, 0));
  var_0[160] = _id_3F78((12324.8, 47493.6, 1036), (0, -44.8196, 0), 1);
  var_0[161] = _id_3F78((29716.1, 34472.4, 435.436), (0, -133.228, 0), 1);
  var_0[162] = _id_3F78((37269.7, 27514, 190.688), (0, -36.7275, 0), 1);
  var_0[163] = _id_3F78((46679.8, 17932.4, -352.184), (0, 157.463, 0), 1);
  var_0[164] = _id_3F78((53649.7, 7546.33, 29.3552), (0, -107.59, 0), 1);
  var_0[165] = _id_3F78((57918.4, 650.832, 41.0137), (0, 106.07, 0), 1);
  var_0[166] = _id_3F78((7073.74, 57285.5, 1036), (0, 164.547, 0), 1);
  var_0[167] = _id_3F78((27957.2, 43805.1, 1753.23), (0, -142.754, 0), 1);
  var_0[168] = _id_3F78((20050.9, 52735.7, 1917.76), (0, 137.974, 0), 1);
  var_0[169] = _id_3F78((43887.3, 31928.7, -198.527), (0, -93.8224, 0), 1);
  var_0[170] = _id_3F78((44717.5, 39263.5, -42.8776), (0, -102.018, 0), 1);
  var_0[171] = _id_3F78((37958.5, 47398, 944.177), (0, -119.853, 0), 1);
  return var_0;
}

_id_A290() {
  var_0 = [];
  var_0[var_0.size] = _id_3F78((29786.7, 41132.6, 749.673), (0, -132.937, 0));
  var_0[var_0.size] = _id_3F78((31330.7, 43775.2, 685), (0, -111.923, 0));
  var_0[var_0.size] = _id_3F78((37671.1, 42532.2, 857.039), (0, -169.422, 0));
  var_0[var_0.size] = _id_3F78((40311.2, 44060.2, 1326.98), (0, 169.247, 0));
  return var_0;
}

_id_3F78(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  return var_3;
}

#using_animtree("script_model");

_id_3EDE() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("tag_origin");
  var_0 useanimtree(#animtree);
  var_0._id_18AF = "endingCam";
  return var_0;
}

_id_530F(var_0) {
  self notify("ending_fade_in");
  self endon("ending_fade_in");
  self endon("disconnect");
  var_1 = var_0 * 20;
  var_2 = 1;
  var_3 = 1.0 / var_1;
  self setclientomnvar("ui_world_fade", var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    waitframe();
    var_2 = var_2 - var_3;
    var_2 = max(var_2, 0);
    self setclientomnvar("ui_world_fade", var_2);
  }
}

_id_5310(var_0) {
  self notify("ending_fade_out");
  self endon("ending_fade_out");
  self endon("disconnect");
  var_1 = var_0 * 20;
  var_2 = 0;
  var_3 = 1.0 / var_1;
  self setclientomnvar("ui_world_fade", var_2);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    waitframe();
    var_2 = var_2 + var_3;
    var_2 = min(var_2, 1);
    self setclientomnvar("ui_world_fade", var_2);
  }
}

_id_3F5D(var_0, var_1, var_2, var_3) {
  self._id_18AF = var_0;

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_4 = spawn("script_model", var_2);
  var_4.player = self;
  self._id_B5A4 = var_4;
  self._id_B5A4 setModel(var_1);
  self._id_B5A4 hide();
  self._id_B5A4._id_18AF = var_0;
  self._id_B5A4 useanimtree(#animtree);
  self._id_B5A4._id_10E51 = self._id_10E51;
  self._id_B5A4._id_3717 = _id_0A94::_id_7427;
  self._id_B5A4._id_4C9C = _id_0A94::_id_7436;

  if(!isDefined(level._id_2A3D._id_B5AF)) {
    level._id_2A3D._id_B5AF = [];
  }

  if(isPlayer(self)) {
    self playerlinktodelta(self._id_B5A4, "tag_player", 1.0, 0, 0, 0, 0, 1);
    level._id_2A3D._id_B5AF[level._id_2A3D._id_B5AF.size] = self._id_B5A4;
  } else
    self._id_B5A4._id_10E51 = 0;

  self notify("rig_created");
}

_id_C436() {
  if(isDefined(self)) {
    self unlink();
  }

  if(isDefined(self._id_B5A4)) {
    self._id_B5A4 delete();
  }
}

_id_63BB(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = (var_1[0] + var_0[var_2].origin[0], var_1[1] + var_0[var_2].origin[1], var_1[2] + var_0[var_2].origin[2]);
  }

  if(var_0.size != 0) {
    return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
  }

  return undefined;
}

_id_3668(var_0) {}

_id_63C4() {
  switch (level.script) {
    case "mp_donetsk":
      return "mp_infil_br_donetsk_ending_chopper_tr";
    case "mp_br_quarry":
      return "mp_infil_br_quarry_ending_chopper_tr";
    case "mp_br_mechanics":
      return "mp_infil_br_mechanics_ending_chopper_tr";
  }

  return "";
}

_id_3665(var_0, var_1) {
  var_2 = self.origin + (0, 0, 1000);
  var_3 = vectornormalize(var_2 - var_1);
  var_4 = var_2 + var_3 * 3000;
  var_5 = spawn("script_model", var_4);
  var_5 playSound("br_exfil_incoming_heli_lr");
  var_5 moveto(var_2, var_0);
  wait(var_0);
  var_5 delete();
}

_id_3667() {
  if(level._id_2A3D._id_10E5A.size == 0) {
    return;
  }
  var_0 = "mus_br_exfil_intro_3player_intro";
  var_1 = "br_exfil_part1_3person_lr";

  switch (level._id_2A3D._id_10E5A.size) {
    case 1:
      var_0 = "mus_br_exfil_intro_1player_intro";
      var_1 = "br_exfil_part1_1person_lr";
      break;
    case 2:
      var_0 = "mus_br_exfil_intro_2player_intro";
      var_1 = "br_exfil_part1_2person_lr";
      break;
    case 3:
      var_0 = "mus_br_exfil_intro_3player_intro";
      var_1 = "br_exfil_part1_3person_lr";
      break;
    case 4:
      var_0 = "mus_br_exfil_intro_4player_intro";
      var_1 = "br_exfil_part1_4person_lr";
      break;
  }

  foreach(var_3 in level.players) {
    var_3 playlocalsound(var_1);
    var_3 playlocalsound(var_0);
  }

  waitframe();
  _func_01E3("");

  foreach(var_3 in level.players) {
    var_3 _meth_867F("mp_br_exfil_fade", 4);
  }
}

_id_3666() {
  if(level._id_2A3D._id_10E5A.size == 0) {
    return;
  }
  var_0 = "br_exfil_main_3player";

  switch (level._id_2A3D._id_10E5A.size) {
    case 1:
      var_0 = "br_exfil_main_1player";
      break;
    case 2:
      var_0 = "br_exfil_main_2player";
      break;
    case 3:
      var_0 = "br_exfil_main_3player";
      break;
    case 4:
      var_0 = "br_exfil_main_4player";
      break;
  }

  _func_01E3(var_0);
}

_id_366A(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  foreach(var_2 in level.players) {
    var_2 playlocalsound("br_exfil_end_part_lr");
  }
}

_id_366B(var_0) {
  level._id_2A3D._id_571F thread _id_365B();
  thread _id_3667();

  if(!scripts\mp\gametypes\br_public::_id_8758()) {
    _func_01EA("ui_br_end_game_splash_type", 17);
  }

  if(isDefined(level._id_2A3E)) {
    level._id_2A3D._id_C919 show();

    foreach(var_2 in level.players) {
      var_2._id_B5A4 unlink();
    }
  }

  _id_15E8(2.8, 200);
}

_id_366C(var_0) {
  _id_15E8(2.8, 250);
  level._id_2A3D._id_571F thread _id_365B();

  if(isDefined(level._id_2A3E)) {
    foreach(var_2 in level._id_2A3D._id_1C28) {
      var_2 show();
    }
  }

  foreach(var_5 in var_0) {
    if(isDefined(var_5)) {
      var_5 scripts\mp\utility\player::_id_D8F0("60", 1);
    }
  }
}

_id_366D(var_0) {
  _id_15E8(2.8, 250);
  thread _id_3666();

  if(!isDefined(level._id_2A3E)) {
    if(level._id_2A3D._id_10E5A.size < 4) {
      if(isDefined(level._id_2A3D._id_C918)) {
        level._id_2A3D._id_C918 delete();
      }
    }
  }

  level._id_2A3D._id_571F thread _id_365B();

  if(isDefined(level._id_2A3E)) {
    foreach(var_2 in level._id_2A3D._id_1C28) {
      var_2 hide();
    }
  } else {
    foreach(var_2 in level._id_2A3D._id_1C28) {
      var_2 delete();
    }
  }

  var_6 = ["tag_guy0", "tag_guy2", "tag_guy4", "tag_guy5"];

  foreach(var_8 in var_0) {
    if(!isDefined(var_8)) {
      continue;
    }
    var_8._id_B5A4 linkto(level._id_2A3D._id_571F, var_6[var_8._id_10E51], (0, 0, 0), (0, 0, 0));
    var_8._id_950B = level._id_2A3D._id_571F;
    var_8._id_950C = var_6[var_8._id_10E51];
  }

  foreach(var_11 in level._id_2A3D._id_B5AF) {
    if(isDefined(var_11.player)) {
      continue;
    }
    var_11 linkto(level._id_2A3D._id_571F, var_6[var_11._id_10E51], (0, 0, 0), (0, 0, 0));
    var_11._id_950B = level._id_2A3D._id_571F;
    var_11._id_950C = var_6[var_11._id_10E51];
  }

  _id_3673(var_0);
}

_id_366E(var_0) {
  foreach(var_2 in level.players) {
    var_2 _meth_82FA("br_exfil_heli_int", 0.05);
  }

  _func_01EA("ui_br_end_game_splash_type", 13);
  _id_15E7(45);
  _id_15E8(10, 18);
  level._id_2A3D._id_571F thread _id_365B();

  if(level._id_2A3D._id_10E5A.size == 1) {
    thread _id_366A(1.266);
  }
}

_id_366F(var_0) {
  _func_01EA("ui_br_end_game_splash_type", 14);
  _id_15E7(50);
  _id_15E8(11, 30);
  level._id_2A3D._id_571F thread _id_365B();

  if(isDefined(level._id_2A3E)) {
    foreach(var_2 in var_0) {
      var_2 hide();
    }
  } else
    _id_4710(var_0);

  if(level._id_2A3D._id_10E5A.size == 2) {
    thread _id_366A(2.033);
  }
}

_id_3670(var_0) {
  _func_01EA("ui_br_end_game_splash_type", 15);
  _id_15E7(50);
  _id_15E8(8, 14.5);
  level._id_2A3D._id_571F thread _id_365B();

  if(level._id_2A3D._id_10E5A.size == 3) {
    thread _id_366A(2.0);
  }
}

_id_3671(var_0) {
  _func_01EA("ui_br_end_game_splash_type", 16);
  _id_15E7(55);
  _id_15E8(3, 29);
  level._id_2A3D._id_571F thread _id_365B();

  if(level._id_2A3D._id_10E5A.size == 4) {
    thread _id_366A(2.5);
  }
}

_id_3672(var_0) {
  foreach(var_2 in level.players) {
    var_2 _meth_8078(0.1);
  }

  _id_15E7(65);
  _id_15E8(2.8, 500);
  level._id_2A3D._id_571F thread _id_365B();
}

_id_3673(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 scripts\mp\utility\player::_id_D8F0("30", 1);
    }
  }
}

_id_3674(var_0) {
  if(level._id_2A3D._id_10E5A.size == 1) {
    _id_E876();
  }
}

_id_3675(var_0) {
  if(level._id_2A3D._id_10E5A.size == 2) {
    _id_E876();
  }
}

_id_3676(var_0) {
  if(level._id_2A3D._id_10E5A.size == 3) {
    _id_E876();
  }
}

_id_3677(var_0) {
  if(!isDefined(level._id_2A3E)) {
    _func_01EA("ui_world_fade", 1);
  }
}

_id_E876() {
  level._id_2A3D._id_2FE0 notify("single anim", "end");
}

_id_3669() {
  if(!isDefined(level._id_2A1B)) {
    return;
  }
  if(!isDefined(level._id_2A1B._id_433D)) {
    return;
  }
  level._id_2A1B._id_433D _meth_86DD(self.origin[0], self.origin[1], 9000, 0.05);
}

_id_4710(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_9505)) {
      scripts\engine\utility::_id_1BA4(var_2._id_9505);
    }

    var_2 delete();
  }
}

_id_365B() {
  self endon("death");
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("chopperExfil_rotorwash"), self, "tag_origin");
}

_id_3678() {
  level._effect["chopperExfil_rotorwash"] = loadfx("vfx/iw8_br/gameplay/vfx_br_blima_rotor_infil.vfx");
  level._effect["chopperExfil_gas"] = loadfx("vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_exfil_01.vfx");
  level._effect["player_disconnect"] = loadfx("vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx");
}

_id_15E8(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 100;
  }

  if(!isDefined(var_3)) {
    var_3 = 100;
  }

  foreach(var_6 in level.players) {
    if(!isDefined(var_6._id_CF78)) {
      var_6._id_CF78 = 1;
      var_6 _meth_865D();
    }

    if(isDefined(var_4)) {
      var_6 _meth_8660(var_0, var_1, var_2, var_3, var_4);
      continue;
    }

    if(isDefined(var_3)) {
      var_6 _meth_8660(var_0, var_1, var_2, var_3);
      continue;
    }

    if(isDefined(var_2)) {
      var_6 _meth_8660(var_0, var_1, var_2);
      continue;
    }

    var_6 _meth_8660(var_0, var_1);
  }
}

_id_15E7(var_0) {
  foreach(var_2 in level.players) {
    var_2 setclientdvar("#x356e0c9e15809767a", var_0);
  }
}

_id_15E6() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_CF78)) {
      var_1._id_CF78 = undefined;
      var_1 _meth_865E();
    }
  }
}

_id_CF43() {}

_id_3ED0(var_0) {
  var_1 = spawnStruct();
  var_1._id_5526 = [];
  var_1.players = [];
  var_1._id_2FE0 = undefined;
  var_1._id_18A3 = var_0;
  var_1._id_ADCD = [];
  return var_1;
}

_id_1005(var_0, var_1) {
  level._id_CC31[var_0._id_18AF][self._id_18A3] = var_1;
  level._id_CC32[var_0._id_18AF][self._id_18A3] = _func_00C1(var_1);
  self._id_5526[self._id_5526.size] = var_0;
}

_id_1007(var_0, var_1) {
  self._id_E6AF = var_1;
  self._id_AE48 = var_0;
}

_id_1006(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = undefined;

  if(!isDefined(var_0._id_2BB4)) {
    var_3 = "player" + var_0 getentitynumber();
    var_0._id_18AF = var_3;
    var_0._id_2BB4 = var_3;
  } else
    var_3 = var_0._id_2BB4;

  self.players[self.players.size] = var_0;
  var_4 = var_1;

  if(isDefined(var_2)) {
    if(isDefined(var_0._id_AC3D) && isDefined(var_0._id_AC3D._id_6285) && var_0._id_AC3D._id_6285 == "female") {
      var_4 = var_2;
    }
  }

  level._id_CC31[var_3][self._id_18A3] = var_4;
  level._id_CC3B[var_3][self._id_18A3] = _func_00C1(var_4);
}

_id_1002(var_0) {
  self._id_2FE0 = 1;
  level._id_CC31["endingCam"][self._id_18A3] = var_0;
}

_id_1004(var_0, var_1, var_2) {
  self._id_605B = var_0;
  self._id_6098 = var_1;
  self._id_6086 = var_2;
}

_id_E1E5(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3 setModel(var_0);

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  var_3._id_18AF = var_1;
  var_3 useanimtree(#animtree);

  if(isDefined(var_2)) {
    var_3._id_9505 = [];

    foreach(var_5 in var_2) {
      var_6 = spawn("script_model", self.origin);
      var_6 setModel(var_5[0]);
      var_6 linkto(var_3, var_5[1], (0, 0, 0), (0, 0, 0));
      var_3._id_9505[var_3._id_9505.size] = var_6;
    }
  }

  return var_3;
}

_id_1003(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", self.origin);
  var_5 setModel(var_0);
  var_5 useanimtree(#animtree);

  if(isDefined(var_4)) {
    var_6 = var_4;
  } else {
    var_6 = var_0;
  }

  var_5._id_18AF = var_6;
  level._id_CC31[var_5._id_18AF]["br_ending"] = var_2;

  if(isDefined(var_3)) {
    level._id_CC32[var_5._id_18AF]["br_ending"] = var_3;
  }

  if(isDefined(var_1)) {
    var_5._id_9505 = [];

    foreach(var_8 in var_1) {
      var_9 = spawn("script_model", self.origin);
      var_9 setModel(var_8[0]);
      var_9 linkto(var_5, var_8[1], (0, 0, 0), (0, 0, 0));
      var_5._id_9505[var_5._id_9505.size] = var_9;
    }
  }

  self._id_ADC7._id_9FDF[self._id_ADC7._id_9FDF.size] = var_5;
  return var_5;
}