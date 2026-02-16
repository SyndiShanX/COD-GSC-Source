/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2531.gsc
*************************************************/

_id_101A3(var_0, var_1) {
  var_2 = _id_101A1();
  var_3 = var_2._id_102F6[var_0];

  if(!isDefined(var_3)) {
    if(isDefined(var_1)) {
      var_3 = spawnStruct();
      var_2._id_102F6[var_0] = var_3;
      var_3._id_CFBE = [];
      var_3._id_54E3 = undefined;
      var_3._id_54D6 = undefined;
      var_3._id_5790 = undefined;
      var_3._id_577B = undefined;
      var_3._id_C187 = undefined;
      var_3._id_A0FD = undefined;
      var_3._id_C725 = [];
      var_3._id_430F = -1;
      var_3._id_790C = undefined;
      var_3._id_2FF8 = "none";
      var_3._id_048B = "Level_Vehicle";
      var_3._id_577C = [];
      var_3._id_577C["front"] = undefined;
      var_3._id_577C["back"] = undefined;
      var_3._id_577C["left"] = undefined;
      var_3._id_577C["right"] = undefined;
      var_3._id_577C["top"] = undefined;
      var_3._id_577C["bottom"] = undefined;
      var_3._id_5788 = [];
      var_3._id_5778 = [];
      var_3._id_5796 = undefined;
      var_3._id_4300 = "driver";
      var_3._id_42FF = "all";
    }
  }

  return var_3;
}

_id_101A2(var_0, var_1, var_2) {
  var_3 = _id_101A3(var_0, var_2);
  var_4 = var_3._id_CFBE[var_1];

  if(!isDefined(var_4)) {
    if(istrue(var_2)) {
      var_4 = spawnStruct();
      var_3._id_CFBE[var_1] = var_4;
      var_4._id_102F6 = var_3;
      var_4._id_CFC5 = [];
      var_4._id_5780 = [];
      var_4._id_E354 = undefined;
      var_4._id_103D2 = [];
      var_4._id_103D2["top"] = undefined;
      var_4._id_103D2["bottom"] = undefined;
      var_4._id_103D2["left"] = undefined;
      var_4._id_103D2["right"] = undefined;
      var_4._id_78FF = undefined;
      var_4._id_7917 = undefined;
      var_4._id_DC8E = undefined;
      var_4._id_F88B = undefined;
    }
  }

  return var_4;
}

_id_101F2(var_0) {
  var_0._id_A924 = [];
  var_0._id_A925 = [];
  var_0._id_881C = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "registerInstance")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "registerInstance")]](var_0);
  }
}

_id_1017A(var_0) {
  var_0._id_A924 = undefined;
  var_0._id_A925 = undefined;
  var_0._id_881C = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "deregisterInstance")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "deregisterInstance")]](var_0);
  }
}

_id_101BB(var_0) {
  return isDefined(var_0._id_A924);
}

_id_1018D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = _id_101A3(var_0._id_1031E);

  if(isDefined(var_2)) {
    return getarraykeys(var_2._id_CFBE);
  } else {
    return undefined;
  }
}

_id_1018F(var_0, var_1) {
  var_2 = [];
  var_3 = _id_1018D(var_0);

  foreach(var_5 in var_3) {
    if(!_id_101F8(var_0, var_5)) {
      continue;
    }
    var_2[var_2.size] = var_5;
  }

  if(istrue(var_1)) {
    if(var_2.size > 0) {
      var_7 = [];

      foreach(var_5 in var_2) {
        var_9 = _id_101A2(var_0._id_1031E, var_5);
        var_10 = var_9._id_E354;

        if(!isDefined(var_10)) {
          var_10 = 0;
        } else {
          var_10 = int(max(0, var_10));
        }

        var_7[var_5] = var_10;
      }

      for(var_12 = 0; var_12 < var_2.size - 1; var_12++) {
        var_13 = var_2[var_12];

        for(var_14 = var_12 + 1; var_14 < var_2.size; var_14++) {
          var_15 = var_2[var_14];

          if(var_7[var_15] > var_7[var_13]) {
            var_16 = var_13;
            var_2[var_12] = var_15;
            var_2[var_14] = var_16;
          }
        }
      }
    }
  }

  return var_2;
}

_id_101F8(var_0, var_1, var_2) {
  var_3 = var_0._id_A924[var_1];
  var_4 = var_0._id_A925[var_1];

  if(!isDefined(var_3) && !isDefined(var_4)) {
    return 1;
  }

  if(isDefined(var_2)) {
    if(isDefined(var_3) && var_3 == var_2) {
      return 1;
    }

    if(isDefined(var_4) && var_4 == var_2) {
      return 1;
    }
  }

  return 0;
}

_id_101AC(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(isDefined(var_0._id_A924)) {
    return var_0._id_A924[var_1];
  } else {
    return undefined;
  }
}

_id_1018B(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  return var_0._id_A924;
}

_id_1018C(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_0._id_A924)) {
    return undefined;
  }

  return scripts\engine\utility::_id_1B9D(var_0._id_A924, var_0._id_A925);
}

_id_101AA(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_0._id_A924)) {
    return undefined;
  }

  return var_0._id_A925;
}

_id_101A6(var_0, var_1) {
  foreach(var_4, var_3 in var_0._id_A924) {
    if(var_3 == var_1) {
      return var_4;
    }
  }

  return undefined;
}

_id_101E8(var_0) {
  if(isDefined(var_0.vehicle)) {
    var_1 = _id_101A6(var_0.vehicle, var_0);
    var_2 = _id_101A2(var_0.vehicle._id_1031E, var_1);

    if(isDefined(var_2._id_18F2)) {
      var_3 = tolower(var_2._id_18F2);

      if(var_3 == "tag_seat_0") {
        return 1;
      }
    }
  }

  return 0;
}

_id_10193(var_0, var_1) {
  var_2 = _id_10195(var_0, var_1);

  if(isDefined(var_2)) {
    return _id_101AC(var_0, var_2, !istrue(var_1));
  }

  return undefined;
}

_id_10195(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E, !istrue(var_1));

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = var_2._id_4F6B;

  if(!isDefined(var_3)) {
    foreach(var_6, var_5 in var_2._id_CFBE) {
      if(isDefined(var_5._id_18F2) && tolower(var_5._id_18F2) == "tag_seat_0") {
        var_3 = var_6;
        break;
      }
    }

    var_2._id_4F6B = var_3;
  }

  return var_3;
}

_id_101BC(var_0, var_1) {
  var_2 = _id_101A2(var_0._id_1031E, var_1);

  if(!isDefined(var_2._id_18F2)) {
    return 0;
  }

  if(tolower(var_2._id_18F2) != "tag_seat_0") {
    return 0;
  }

  return 1;
}

_id_1017E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(var_3) && isDefined(var_3._id_FE9B)) {
    var_5 = 1;
  }

  if(!var_5 && !var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(istrue(var_2.inlaststand)) {
    return;
  }
  if(istrue(var_0._id_87FB)) {
    return;
  }
  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_0DCA(var_0, 0, 0)) {
    return 0;
  }

  foreach(var_7 in var_0._id_A925) {
    if(isDefined(var_7) && var_7 == var_2) {
      return;
    }
  }

  var_9 = getdvarint("#x3a25ea60367a7aeb8", 2000);

  if(isDefined(var_0.currentburndowntime) && var_0.currentburndowntime <= var_9) {
    return;
  }
  var_10 = _id_101A6(var_0, var_2);

  if(istrue(_id_101F8(var_0, var_1, var_2))) {
    _id_10203(var_2);

    if(!isDefined(var_3)) {
      var_3 = spawnStruct();
    }

    var_3._id_7D41 = istrue(var_4);
    var_3._id_BF05 = "vehicle_race_last_call";
    var_3._id_BF06 = "vehicle_race_finished";

    if(!var_3._id_7D41) {
      thread _id_101ED(var_2, var_3);
      thread _id_101F0(var_0, var_3);
      thread _id_101EF(var_0, var_2, var_1, var_10, var_3);
      thread _id_101EC(var_10, var_1, var_3);
    }

    if(isDefined(var_10)) {
      thread _id_10184(var_0, var_10, var_1, var_2, var_3);
    }

    if(isDefined(var_1)) {
      thread _id_10180(var_0, var_1, var_10, var_2, var_3);
    }

    _id_1020A(var_0);
    _id_10209(var_0);

    if(!var_3._id_7D41) {
      var_3 waittill(var_3._id_BF05);
      waittillframeend;
      var_3 notify(var_3._id_BF06);
    }

    if(!_id_09E1::_id_100F8(var_0)) {
      return;
    }
    var_11 = _id_101EE(var_0, var_2, var_10, var_1, var_3);

    if(isDefined(var_10)) {
      thread _id_10183(var_0, var_10, var_1, var_2, var_3);
    }

    if(isDefined(var_1)) {
      thread _id_1017F(var_0, var_1, var_10, var_2, var_3);
    }

    _id_1020A(var_0);
    _id_10209(var_0);

    if(var_11) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "changedSeats")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "changedSeats")]](var_2, var_0, var_10, var_1);
      }

      thread _id_101CE(var_0, var_2, var_1);
      var_2 cancelreloading();

      if(istrue(var_2._id_82E8)) {
        var_2 notify("try_armor_repair_cancel");
      }

      if(isDefined(var_10)) {
        var_12 = _id_101BC(var_0, var_10);

        if(istrue(var_12) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "stopChallengeTimer")) {
          var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "stopChallengeTimer")]]("driving");
        }
      }

      if(isDefined(var_1)) {
        var_12 = _id_101BC(var_0, var_1);

        if(istrue(var_12)) {
          var_13 = "";

          switch (var_0._id_0481) {
            case "apc":
              var_13 = var_2._id_102F5._id_195C;
              break;
            case "atv":
              var_13 = var_2._id_102F5._id_1E32;
              break;
            case "cargo_truck":
              var_13 = var_2._id_102F5._id_326F;
              break;
            case "jeep":
              var_13 = var_2._id_102F5._id_8BA5;
              break;
            case "little_bird":
              var_13 = var_2._id_102F5._id_9556;
              break;
            case "tac_rover":
              var_13 = var_2._id_102F5._id_ECBE;
              break;
            case "light_tank":
              var_13 = var_2._id_102F5._id_EDEC;
              break;
            case "s4_tank":
              var_13 = var_2._id_102F5._id_EDEC;
              break;
            default:
              var_13 = "";
          }

          if(var_13 != "") {
            var_0 _meth_8787();
            var_0 _meth_8789(var_13);
          }

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "startChallengeTimer")) {
            var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "startChallengeTimer")]]("driving");
          }
        }
      }

      if(!isDefined(var_10)) {
        var_14 = "ENTERED_VEHICLE";
      } else {
        var_14 = "SEAT_SWITCH";
      }

      _id_09E0::_id_10097(var_0, var_2, var_1, var_14);
    } else if(isDefined(var_10) && !istrue(var_3._id_B68D) && !istrue(var_3._id_B707) && !istrue(var_3._id_B695) && !istrue(var_3._id_102F7))
      _id_101F1(var_0, var_10, var_1, var_2, var_3);
  }
}

_id_10182(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;

  if(isDefined(var_2)) {
    if(!isDefined(var_5)) {
      var_5 = _id_101A6(var_0, var_2);
    }

    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 = 1;
    }

    if(istrue(var_2.inlaststand)) {
      var_4 = 1;
    }

    _id_10203(var_2);
  } else {
    var_4 = 1;
    _id_101EB(var_0, var_5);
  }

  if(istrue(var_0._id_87FB)) {
    var_4 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = spawnStruct();
  }

  var_3._id_7D41 = istrue(var_4);
  var_3._id_BF05 = "vehicle_race_last_call";
  var_3._id_BF06 = "vehicle_race_finished";

  if(!var_3._id_7D41) {
    thread _id_101ED(var_2, var_3);
    thread _id_101F0(var_0, var_3);
    thread _id_101EC(var_5, undefined, var_3);
  }

  thread _id_10184(var_0, var_5, undefined, var_2, var_3);

  if(!var_3._id_7D41) {
    var_3 waittill(var_3._id_BF05);
    waittillframeend;
    var_3 notify(var_3._id_BF06);
  }

  var_6 = _id_101EE(var_0, var_2, var_5, undefined, var_3);
  thread _id_10183(var_0, var_5, undefined, var_2, var_3);
  _id_1020A(var_0);
  _id_10209(var_0);

  if(!var_6) {
    if(!istrue(var_3._id_B68D) && !istrue(var_3._id_B707) && !istrue(var_3._id_B695) && !istrue(var_3._id_102F7)) {
      _id_101F1(var_0, var_5, undefined, var_2, var_3);
    }
  } else if(isDefined(var_2)) {
    var_2 cancelreloading();
    var_7 = _id_101BC(var_0, var_5);

    if(istrue(var_7) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "stopChallengeTimer")) {
      var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "stopChallengeTimer")]]("driving");
    }
  }
}

_id_101BF(var_0, var_1) {
  if(level.teambased) {
    return _id_101C0(var_0, var_1.team);
  } else {
    if(istrue(var_0._id_5FBC)) {
      var_0 _id_10165(var_0);
    }

    return isDefined(var_0._id_B6B1) && var_0._id_B6B1 == var_1;
  }
}

_id_101BD(var_0, var_1) {
  if(level.teambased) {
    return _id_101BE(var_0, var_1.team);
  } else {
    if(istrue(var_0._id_5FBC)) {
      var_0 _id_10165(var_0);
    }

    return isDefined(var_0._id_B6B1) && var_0._id_B6B1 != var_1;
  }
}

_id_101C1(var_0, var_1) {
  if(level.teambased) {
    return _id_101C2(var_0, var_1.team);
  } else {
    if(istrue(var_0._id_5FBC)) {
      var_0 _id_10165(var_0);
    }

    return !isDefined(var_0._id_B6B1);
  }
}

_id_101A8(var_0) {
  if(!level.teambased) {
    if(istrue(var_0._id_5FBC)) {
      var_0 _id_10165(var_0);
    }

    return var_0._id_B6B1;
  }

  return undefined;
}

_id_101C0(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0._id_5FBC)) {
      var_0 _id_10165(var_0);
    }

    return isDefined(var_0._id_EF74) && var_0._id_EF74 == var_1;
  }

  return undefined;
}

_id_101BE(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0._id_5FBC)) {
      var_0 _id_10165(var_0);
    }

    return isDefined(var_0._id_EF74) && var_0._id_EF74 != var_1;
  }

  return undefined;
}

_id_101C2(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0._id_5FBC)) {
      var_0 _id_10165(var_0);
    }

    return !isDefined(var_0._id_EF74);
  }

  return undefined;
}

_id_101AD(var_0) {
  if(level.teambased) {
    if(istrue(var_0._id_5FBC)) {
      var_0 _id_10165(var_0);
    }

    return var_0._id_EF74;
  }

  return undefined;
}

_id_101F9(var_0) {
  var_0._id_5FBC = 1;
  _id_09E1::_id_1010F(var_0);
}

_id_10165(var_0) {
  if(level.teambased) {
    var_1 = 0;
    var_2 = var_0._id_EF74;

    if(isDefined(var_0.team) && var_0.team != "neutral") {
      var_0._id_EF74 = var_0.team;
      var_0._id_5FBC = undefined;
      var_1 = 1;
    }

    if(!var_1) {
      foreach(var_4 in var_0._id_A924) {
        if(isDefined(var_4)) {
          var_0._id_EF74 = var_4.team;
          var_0._id_5FBC = undefined;
          var_1 = 1;
          break;
        }
      }
    }

    if(!var_1) {
      var_0._id_EF74 = undefined;
      var_0._id_5FBC = undefined;
    }

    if(!isDefined(var_2) && !isDefined(var_0._id_EF74)) {
      return 0;
    }

    if(isDefined(var_2) && isDefined(var_0._id_EF74) && var_2 == var_0._id_EF74) {
      return 0;
    }

    _id_10189(var_0, var_2, var_0._id_EF74);
    return 1;
  } else {
    var_1 = 0;
    var_6 = var_0._id_B6B1;

    if(isDefined(var_0._id_AC8F)) {
      var_0._id_B6B1 = var_0._id_AC8F;
      var_0._id_5FBC = undefined;
      var_1 = 1;
    }

    if(!var_1) {
      var_7 = _id_1018B(var_0);

      foreach(var_4 in var_7) {
        if(isDefined(var_4)) {
          var_0._id_B6B1 = var_4;
          var_0._id_5FBC = undefined;
          return;
        }
      }
    }

    if(!isDefined(var_6) && !isDefined(var_0._id_B6B1)) {
      return 0;
    }

    if(isDefined(var_6) && isDefined(var_0._id_B6B1) && var_6 == var_0._id_B6B1) {
      return 0;
    }

    _id_10189(var_0, var_6, var_0._id_B6B1);
    return 1;
  }
}

_id_10189(var_0, var_1, var_2) {
  _id_09DE::_id_1000F(var_0, var_1, var_2);
  var_3 = _id_101A3(var_0._id_1031E);

  if(!isDefined(var_3._id_5FBB)) {
    return;
  }
  thread[[var_3._id_5FBB]](var_0, var_1, var_2);
}

_id_101FA(var_0, var_1) {
  var_0._id_AC8F = var_1;
  _id_1020C(var_0);
}

_id_101FB(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0._id_ADAC)) {
    var_0._id_ADAC = [];
  } else {
    _id_1016E(var_0, var_1);
    var_0._id_ADAC = scripts\engine\utility::_id_1BD1(var_0._id_ADAC);
  }

  var_0._id_ADAC[var_0._id_ADAC.size] = var_1;

  if(isDefined(var_3) && var_3 == -1) {} else
    thread _id_1020F(var_0, var_1, var_2, var_3);

  _id_1020C(var_0);
}

_id_1020C(var_0) {
  var_0 notify("vehicle_owner_update");
  var_1 = var_0.owner;
  var_2 = var_0._id_ADAE;
  var_3 = undefined;

  if(isDefined(var_0._id_ADAC)) {
    for(var_4 = var_0._id_ADAC.size - 1; var_4 >= 0; var_4--) {
      if(_id_101C3(var_0, var_0._id_ADAC[var_4])) {
        var_3 = var_0._id_ADAC[var_4];
        break;
      }
    }
  }

  if(!isDefined(var_3)) {
    if(_id_101C3(var_0, var_0._id_AC8F)) {
      var_3 = var_0._id_AC8F;
    }
  }

  var_0.owner = var_3;
  var_5 = 0;

  if(isDefined(var_3) || isDefined(var_1)) {
    if(!isDefined(var_3) && isDefined(var_1)) {
      var_5 = 1;
    } else if(isDefined(var_3) && !isDefined(var_1)) {
      var_5 = 1;
    } else if(var_3 != var_1) {
      var_5 = 1;
    }
  }

  var_6 = 0;

  if(isDefined(var_3)) {
    if(!isDefined(var_2) || var_2 != var_3.team) {
      var_6 = 1;
    }

    var_0._id_ADAE = var_3.team;
    var_0 _meth_83A6(var_3.team);
    thread _id_10210(var_0, var_3);
  } else {
    if(var_5) {
      var_6 = 1;
    }

    var_0._id_ADAE = undefined;
  }

  if(var_5) {
    if(!level.teambased) {
      _id_101F9(var_0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "updateOwner")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "updateOwner")]](var_0);
  }

  var_7 = _id_101A3(var_0._id_1031E);

  if(isDefined(var_7) && isDefined(var_7._id_FCE4)) {
    [[var_7._id_FCE4]](var_0, var_3, var_5, var_6);
  }
}

_id_1016E(var_0, var_1) {
  var_0 notify("vehicle_clear_owner_" + var_1 getentitynumber());

  if(isDefined(var_0._id_ADAC)) {
    var_0._id_ADAC = scripts\engine\utility::array_remove(var_0._id_ADAC, var_1);
  }

  _id_1020C(var_0);
}

_id_101FC(var_0, var_1) {
  var_2 = !isDefined(var_0.team) || var_0.team != var_1;
  var_0.team = var_1;

  if(var_0.classname == "script_vehicle") {
    var_0 _meth_83A6(var_1);
  }

  if(var_2) {
    if(level.teambased) {
      _id_101F9(var_0);
    }
  }

  var_3 = _id_101A3(var_0._id_1031E);

  if(isDefined(var_3) && isDefined(var_3._id_FD57)) {
    [[var_3._id_FD57]](var_0, var_1, var_2);
  }

  _id_1020C(var_0);
}

_id_101B9() {
  var_0 = spawnStruct();
  level.vehicle._id_A923 = var_0;
  var_0._id_102F6 = [];
  var_0._id_F496 = getdvarint("#x3ecfd9ed210fe0b67", 1) > 0;

  if(var_0._id_F496) {
    var_0._id_F497 = 0;
    var_0._id_F498 = [];
  }

  _id_101BA();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "init")]]();
}

_id_10180(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4._id_BF06);
  var_0._id_A925[var_1] = var_3;
  var_3._id_10329 = var_0;
  _id_09E1::_id_1010F(var_0);
  _id_09E1::_id_1010C(var_0);
  _id_09E1::_id_10112(var_0);
  var_5 = undefined;

  if(var_4._id_7D41) {
    var_5 = gettime();
  }

  if(isDefined(var_4._id_54E5)) {
    var_3 waittill(var_4._id_54E5);
  }

  _id_10178(var_0, var_1, 1);
  var_6 = _id_10197(var_0, var_1);

  if(isDefined(var_6)) {
    [[var_6]](var_0, var_1, var_2, var_3, var_4);
  }

  if(!isDefined(var_4._id_54E4)) {
    var_4._id_54E4 = 1;
  }

  if(var_4._id_7D41) {
    return;
  }
}

_id_10184(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4._id_BF06);
  var_5 = undefined;

  if(var_4._id_7D41) {
    var_5 = gettime();
  }

  var_6 = _id_1019F(var_0, var_1);

  if(isDefined(var_6)) {
    [[var_6]](var_0, var_1, var_2, var_3, var_4);
  }

  if(!isDefined(var_4._id_5791)) {
    var_4._id_5791 = 1;
  }

  if(var_4._id_7D41) {
    return;
  }
}

_id_10185(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4._id_BF06);
  var_5 = _id_10187(var_3, var_0, var_1, var_2, var_4);

  if(level.gametype == "tanks") {
    var_5 = 0;
  }

  if(!var_5) {
    var_4._id_5791 = 0;
    _id_10181(var_3, 2);

    if(!istrue(var_4._id_7D41)) {
      waitframe();
      var_4 notify(var_4._id_BF05);
    }
  }
}

_id_1017F(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    var_0._id_A924[var_1] = var_3;
    var_0._id_A925[var_1] = undefined;
    var_3.vehicle = var_0;
    var_3._id_10329 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "disableClassSwapAllowed")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "disableClassSwapAllowed")]]();
    }

    _id_10162(var_0, var_1, var_3, var_4);
    _id_1020D(var_3, var_0, var_1);
    _id_101B6(var_0, var_1, var_3, var_4);
    _id_10160(var_0, var_1, var_2, var_3, var_4);
    _id_10161(var_0, var_1, var_3, var_4);
    _id_101B5(var_0, var_1, var_3, var_4);

    if(!isDefined(var_2)) {
      _id_101E9(var_0, var_1, var_3, var_4);
    }

    var_5 = _id_101A2(var_0._id_1031E, var_1);

    if(isDefined(var_5._id_18F2) && tolower(var_5._id_18F2) == tolower("tag_seat_0")) {
      _id_101FB(var_0, var_3, 1);
    }

    if(!isDefined(var_2)) {
      var_3 notify("vehicle_enter");

      if(isDefined(var_5._id_AAC6)) {
        thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "trySayLocalSound")]](var_3, var_5._id_AAC6);
      }
    } else {
      var_3 notify("vehicle_change_seat");

      if(isDefined(var_5._id_AAC6)) {
        thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "trySayLocalSound")]](var_3, var_5._id_AAC6, undefined, 1);
      }
    }
  } else {
    if(isDefined(var_3)) {
      var_3._id_10329 = undefined;
    }

    if(!istrue(var_4._id_102F7)) {
      var_0._id_A925[var_1] = undefined;
    }
  }

  _id_09E1::_id_1010F(var_0);
  _id_09E1::_id_1010C(var_0);
  _id_09E1::_id_10112(var_0);
  var_6 = gettime();
  var_7 = _id_10196(var_0, var_1);

  if(isDefined(var_7)) {
    [[var_7]](var_0, var_1, var_2, var_3, var_4);
  }

  if(level.gametype == "base") {
    var_3 setclientomnvar("ui_redeploy_blocked", 1);
  }
}

_id_10183(var_0, var_1, var_2, var_3, var_4) {
  if(var_4._id_EACB) {
    var_0._id_A924[var_1] = undefined;

    if(isDefined(var_3)) {
      var_3 notify("vehicle_seat_exit");

      if(!isDefined(var_2)) {
        var_3.vehicle = undefined;
      }

      _id_101F7(var_0, var_1, var_3, var_4);
      _id_1020D(var_3, var_0, var_2);
      _id_101FE(var_0, var_1, var_3, var_4);
      _id_101F5(var_0, var_2, var_3, var_4);
      _id_101F6(var_0, var_1, var_3, var_4);
      _id_101FD(var_0, var_1, var_3, var_4);
    }

    if(!isDefined(var_2)) {
      _id_101EA(var_0, var_1, var_3, var_4);
    }
  }

  _id_09E1::_id_1010F(var_0);
  _id_09E1::_id_1010C(var_0);
  _id_09E1::_id_10112(var_0);
  var_5 = gettime();
  var_6 = _id_1019C(var_0, var_1);

  if(isDefined(var_6)) {
    [[var_6]](var_0, var_1, var_2, var_3, var_4);
  }

  if(isDefined(var_3)) {
    var_3 _meth_8722();
  }

  if(level.gametype == "base") {
    var_3 setclientomnvar("ui_redeploy_blocked", 0);
  }
}

_id_101F1(var_0, var_1, var_2, var_3, var_4) {
  thread _id_101CE(var_0, var_3, var_1);
  var_5 = gettime();
  var_6 = _id_101A9(var_0, var_1);

  if(isDefined(var_6)) {
    [[var_6]](var_0, var_1, var_2, var_3, var_4);
  }
}

_id_101A1() {
  return level.vehicle._id_A923;
}

_id_101EB(var_0, var_1) {
  var_0._id_A924[var_1] = undefined;
  var_0._id_A925[var_1] = undefined;
}

_id_101E9(var_0, var_1, var_2, var_3) {
  _id_101F9(var_0);
  var_0 scripts\cp_mp\vehicles\vehicle_spawn::_id_1028F();
  var_2 setstance("stand");
  var_2 scripts\common\utility::_id_1523(_id_101A5(), 0);
  thread _id_10205(var_2, var_0, var_1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "onEnterVehicle", 1)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "onEnterVehicle")]](var_0, var_1, var_2, var_3);
  }
}

_id_101EA(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3._id_B695)) {
    var_2 _id_10204();
    var_2 _id_10169();

    if(!istrue(var_3._id_B68D)) {
      if(istrue(var_3._id_B707)) {
        var_3._id_5797 = "DEATH";
      } else if(!isDefined(var_3._id_5797)) {
        var_3._id_5797 = "VOLUNTARY";
      }

      var_2 scripts\common\utility::_id_1523(_id_101A5(), 1);
      thread scripts\cp_mp\vehicles\vehicle::_id_1023B(var_0, var_2);
    } else
      var_3._id_5797 = "DEATH";

    thread _id_101B1(var_2, var_3._id_B68D, var_3._id_B707);
  } else
    var_3._id_5797 = "DISCONNECT";

  _id_101F9(var_0);

  if(scripts\cp_mp\vehicles\vehicle_spawn::_id_10271() && var_0._id_A924.size == 0) {
    var_0 thread scripts\cp_mp\vehicles\vehicle_spawn::_id_10291();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "onExitVehicle", 1)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "onExitVehicle")]](var_0, var_1, var_2, var_3);
  }

  _id_09E0::_id_10098(var_0, var_2, var_1, var_3._id_5797);
}

_id_1020A(var_0) {
  var_1 = _id_1018F(var_0).size <= 0;

  if(var_1) {
    if(!istrue(var_0._id_8874)) {
      _id_09E1::_id_100E5(var_0, 0);
      var_0._id_8874 = 1;
    } else
      _id_09E1::_id_10112(var_0);
  } else if(istrue(var_0._id_8874)) {
    var_0._id_8874 = undefined;
    _id_09E1::_id_100E5(var_0, 1);
  } else
    _id_09E1::_id_10112(var_0);
}

_id_10209(var_0) {
  var_1 = _id_1018F(var_0);
  var_2 = _id_1018D(var_0);
  var_3 = var_1.size == var_2.size;

  if(!istrue(var_0._id_881C) && var_3) {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_102EF(var_0, 0);
  }

  if(istrue(var_0._id_881C) && !var_3) {
    var_4 = scripts\cp_mp\vehicles\vehicle_tracking::_id_102EF(var_0, 1, 0);
  }

  var_0._id_881C = var_3;
}

_id_10197(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);
  var_3 = var_2._id_CFBE[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3._id_54E3), var_3._id_54E3, var_2._id_54E3);
}

_id_10196(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);
  var_3 = var_2._id_CFBE[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3._id_54D6), var_3._id_54D6, var_2._id_54D6);
}

_id_1019F(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);
  var_3 = var_2._id_CFBE[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3._id_5790), var_3._id_5790, var_2._id_5790);
}

_id_1019C(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);
  var_3 = var_2._id_CFBE[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3._id_577B), var_3._id_577B, var_2._id_577B);
}

_id_101A9(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);
  var_3 = var_2._id_CFBE[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3._id_C187), var_3._id_C187, var_2._id_C187);
}

_id_10162(var_0, var_1, var_2, var_3) {
  if(!_id_101D1(var_0)) {
    if(var_1 == _id_10195(var_0)) {
      _id_1015C(var_0, var_2, 0, var_1);
    }
  }

  var_4 = _id_101AB(var_0, var_1);
  var_2 scripts\common\utility::_id_1523(var_4, 0);
}

_id_101F7(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3._id_B68D)) {
    _id_1015C(var_0, var_2, 1, undefined);
    var_4 = _id_101AB(var_0, var_1);
    var_2 scripts\common\utility::_id_1523(var_4, 1);
  }
}

_id_101B8() {
  if(!isDefined(level._id_790D)) {
    level._id_790D = getdvarint("#x359a167725c8e5c36", 1);
  }

  return level._id_790D;
}

_id_101B6(var_0, var_1, var_2, var_3) {
  if(_id_1025C(var_0, var_1)) {
    var_2._id_A546 = 1;

    if(_id_101B8()) {
      var_2 scripts\cp_mp\utility\player_utility::_id_0C91();
    } else {
      var_2 playerhide();
    }
  }
}

_id_101B7(var_0, var_1) {
  var_2 = _id_101A1();

  if(!var_2._id_F496) {
    return;
  }
  var_3 = var_2._id_F497;
  var_2._id_F497++;
  var_0 scripts\cp_mp\utility\player_utility::_id_0C91();
  var_2._id_F498[var_3] = var_0;

  if(!isDefined(var_1._id_F498)) {
    var_1._id_F498 = [];
  }

  var_1._id_F498[var_3] = var_0;
  return var_3;
}

_id_10200(var_0, var_1, var_2) {
  var_3 = _id_101A1();

  if(!var_3._id_F496) {
    return;
  }
  if(istrue(var_2)) {
    waitframe();
    waitframe();
  }

  if(!var_3._id_F496) {
    return;
  }
  if(!isDefined(var_3._id_F498[var_0])) {
    return;
  }
  var_4 = var_3._id_F498[var_0];

  if(isDefined(var_1) && isDefined(var_1._id_F498)) {
    var_1._id_F498[var_0] = undefined;
  }

  if(isDefined(var_4)) {
    var_4 scripts\cp_mp\utility\player_utility::_id_0C93();
  }
}

_id_101FF(var_0, var_1) {
  var_2 = _id_101A1();

  if(!var_2._id_F496) {
    return;
  }
  if(istrue(var_1)) {
    waitframe();
    waitframe();
  }

  if(!isDefined(var_0._id_F498)) {
    return;
  }
  foreach(var_5, var_4 in var_0._id_F498) {
    if(isDefined(var_2._id_F498[var_5])) {
      var_2._id_F498[var_5] = undefined;

      if(isDefined(var_4)) {
        var_4 scripts\cp_mp\utility\player_utility::_id_0C93();
      }
    }
  }

  var_0._id_F498 = undefined;
}

_id_10166() {
  var_0 = _id_101A1();

  if(!var_0._id_F496) {
    return;
  }
  foreach(var_3, var_2 in var_0._id_F498) {
    if(!isDefined(var_2)) {
      var_0._id_F498[var_3] = undefined;
    }
  }
}

_id_101FE(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3._id_B68D)) {
    if(_id_1025C(var_0, var_1)) {
      var_2._id_A546 = undefined;

      if(_id_101B8()) {
        var_2 scripts\cp_mp\utility\player_utility::_id_0C93();
      } else {
        var_2 playershow();
      }
    }
  }
}

_id_10160(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_100B7(var_0, var_1);

  if(isDefined(var_5) && var_5 != "none") {
    var_6 = _id_100B7(var_0, var_2);

    if(var_6 != var_5) {
      var_3 _meth_8697(var_5);
    }
  }
}

_id_101F5(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_4 = _id_100B7(var_0, var_1);

    if(var_4 == "none") {
      var_2 cameradefault();
      return;
    }
  } else
    var_2 cameradefault();
}

_id_10161(var_0, var_1, var_2, var_3) {
  var_4 = _id_10192(var_0, var_1);

  if(isDefined(var_4) && var_4 != -1) {
    var_2 _id_09BF::_id_10A2(var_0._id_1031E + "_" + var_1, var_4, 0, ::_id_10177);
  }
}

_id_101F6(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3._id_B68D)) {
    var_4 = _id_10192(var_0, var_1);

    if(isDefined(var_4) && var_4 != -1) {
      var_2 _id_09BF::_id_C48A(var_0._id_1031E + "_" + var_1, 0);
    }
  }
}

_id_101AB(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);
  var_3 = var_2._id_CFBE[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3._id_C725), var_3._id_C725, var_2._id_C725);
}

_id_1025C(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);
  var_3 = var_2._id_CFBE[var_1];

  if(isDefined(var_3._id_790C)) {
    return istrue(var_3._id_790C);
  } else {
    return istrue(var_2._id_790C);
  }
}

_id_100B7(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);

  if(isDefined(var_1)) {
    var_3 = var_2._id_CFBE[var_1];
    var_4 = var_2._id_2FF8;

    if(isDefined(var_3._id_2FF8)) {
      var_4 = var_3._id_2FF8;
    }

    if(isDefined(var_3._id_18F2) && tolower(var_3._id_18F2) == "tag_seat_0") {
      var_4 = "none";
    }
  } else
    var_4 = "none";

  return var_4;
}

_id_10192(var_0, var_1) {
  var_2 = _id_101A3(var_0._id_1031E);
  var_3 = var_2._id_CFBE[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3._id_430F), var_3._id_430F, var_2._id_430F);
}

_id_10177(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_09BF::_id_ADCA(var_1, var_2, var_3, var_5, var_4, var_0);

  if(var_4 == "MOD_TRIGGER_HURT") {
    return 1;
  }

  if(isDefined(var_5) && var_5.basename == "bomb_site_mp") {
    return 1;
  }

  if(var_2 _id_09BF::_id_8A6A(var_7)) {
    return 1;
  }

  return 0;
}

_id_101CE(var_0, var_1, var_2) {
  thread _id_101C9(var_0, var_1, var_2);
  thread _id_101CF(var_0, var_1, var_2, 1);
  thread _id_101CA(var_0, var_1, var_2);
  thread _id_101CC(var_0, var_1, var_2);
}

_id_10203(var_0) {
  var_0 notify("vehicle_occupancy_monitorControls");
  var_0 notify("vehicle_occupancy_monitorSeatSwitch");
  var_0 notify("vehicle_occupancy_monitorExit");
  var_0 notify("vehicle_occupancy_monitorGameEnded");
}

_id_101CF(var_0, var_1, var_2, var_3) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_0 endon("death");
  level endon("game_ended");
  var_1 notify("vehicle_occupancy_monitorSeatSwitch");
  var_1 endon("vehicle_occupancy_monitorSeatSwitch");
  var_4 = _id_101A3(var_0._id_1031E);

  if(var_4._id_CFBE.size <= 1) {
    return;
  }
  var_5 = _id_101A2(var_0._id_1031E, var_2);

  if(!isDefined(var_5._id_CFC5) || var_5._id_CFC5.size <= 0) {
    return;
  }
  if(!isbot(var_1)) {
    if(var_3) {
      wait 0.2;
    }

    while(var_1 _meth_8739()) {
      waitframe();
    }

    while(!var_1 _meth_8739()) {
      waitframe();
    }

    var_6 = _id_101A4(var_0, var_1, var_2);

    if(isDefined(var_6)) {
      thread _id_1017E(var_0, var_6, var_1);
    }

    _id_10181(var_1, 1);
    thread _id_101CF(var_0, var_1, var_2, 0);
  }
}

_id_101A4(var_0, var_1, var_2) {
  var_3 = _id_101A2(var_0._id_1031E, var_2);

  if(!isDefined(var_3._id_CFC5) || var_3._id_CFC5.size <= 0) {
    return undefined;
  }

  foreach(var_5 in var_3._id_CFC5) {
    if(_id_101F8(var_0, var_5, var_1)) {
      return var_5;
    }
  }
}

_id_101CA(var_0, var_1, var_2) {
  var_1 notify("vehicle_occupancy_monitorExit");
  var_1 endon("vehicle_occupancy_monitorExit");
  var_0 endon("death");
  level endon("game_ended");
  _id_101CB(var_0, var_1, var_2);
  var_3 = spawnStruct();

  if(isDefined(var_1)) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_3._id_B68D = 1;
    }

    if(istrue(var_1.inlaststand)) {
      var_3._id_B707 = 1;
    }
  } else
    var_3._id_B695 = 1;

  thread _id_10182(var_0, var_2, var_1, var_3);
}

_id_101CB(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

  for(;;) {
    if(!var_1 useButtonPressed()) {
      var_4 = 1;
    }

    if(var_4 && gettime() >= var_3) {
      break;
    }

    waitframe();
  }

  var_5 = level._id_5F3A;
  var_6 = getdvarint("#x374b6dca2a5ac069b", 250) / 1000;

  for(;;) {
    var_7 = 0;
    var_8 = var_1 _meth_874B();
    var_9 = 0;
    var_1 setclientomnvar("ui_veh_exit_button_holdtime", 0);

    while(var_1 useButtonPressed()) {
      var_1 _meth_874E();
      var_1 _meth_8751();
      var_9 = 1;
      var_7 = var_7 + var_5;
      var_10 = var_1 usinggamepad();
      var_11 = var_1 _meth_87B3();
      var_12 = !var_10 && !var_11;
      var_13 = !var_10 && var_11;
      var_14 = var_10 && var_8 == 0;
      var_15 = var_10 && var_8 > 0;
      var_16 = var_14 || var_13;

      if(var_14 || var_13) {
        var_1 setclientomnvar("ui_veh_exit_button_holdtime", var_7 / 0.3);
      }

      if(var_16 && var_7 > 0.3 || var_12) {
        return;
      } else if(var_15 && var_7 >= var_6) {
        var_1 cancelreloading();
        var_1 reloadbuttonPressed();
      }

      wait(var_5);
    }

    if(var_9 && var_1 usinggamepad() && var_8 > 0 && var_7 < var_6) {
      return;
    } else if(var_9) {
      var_1 cancelreloading();
      var_1 reloadbuttonPressed();
    }

    waitframe();
  }
}

_id_10181(var_0, var_1) {
  var_2 = undefined;

  switch (var_1) {
    case 1:
      var_2 = "VEHICLES/SEAT_SWITCH_OCCUPIED";
      break;
    case 2:
      var_2 = "VEHICLES/CANNOT_EXIT";
      break;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_2);
  }
}

_id_101CC(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_1 notify("vehicle_occupancy_monitorGameEnded");
  var_1 endon("vehicle_occupancy_monitorGameEnded");

  if(var_2 == _id_10195(var_0)) {
    level waittill("game_ended");
    var_1 allowmovement(0);

    if(isDefined(var_0)) {
      _id_1017D(var_0);
    }
  }
}

_id_101C9(var_0, var_1, var_2) {
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_0 endon("death");
  level endon("game_ended");
  var_1 notify("vehicle_occupancy_monitorControls");
  var_1 endon("vehicle_occupancy_monitorControls");

  if(_id_09CA::_id_1036F(var_1)) {
    return;
  }
  if(1) {
    wait 1.5;
  }

  childthread _id_101CD(var_0, var_1, var_2);
  childthread _id_101D0(var_0, var_1, var_2);
  var_3 = _id_101A3(var_0._id_1031E);

  if(isDefined(var_3._id_A0FD)) {
    childthread[[var_3._id_A0FD]](var_0, var_1, var_2, "vehicle_occupancy_monitorControls");
  }
}

_id_10186(var_0) {
  _id_09CA::_id_10370(var_0);
  var_0 notify("vehicle_occupancy_monitorControls");
}

_id_101CD(var_0, var_1, var_2) {
  var_3 = _id_10195(var_0);

  if(var_2 == var_3) {
    var_4 = var_0 scripts\cp_mp\vehicles\vehicle::_id_102EE();

    if(var_4) {
      for(;;) {
        var_5 = var_0 _meth_873F(0);
        var_6 = var_0 _meth_873F(2);
        var_7 = var_0 _meth_873F(1);
        var_8 = var_0 _meth_873F(3);

        if(abs(var_5) > 0 || abs(var_6) > 0 || abs(var_7) > 0 || abs(var_8) > 0) {
          _id_10186(var_1);
        }

        wait 0.05;
      }
    } else {
      for(;;) {
        var_9 = var_0 _meth_873F(4);

        if(abs(var_9) >= 0.2) {
          _id_10186(var_1);
        }

        wait 0.05;
      }
    }
  }
}

_id_101D0(var_0, var_1, var_2) {
  var_3 = _id_101A2(var_0._id_1031E, var_2);

  if(isDefined(var_3._id_F88B)) {
    var_4 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, var_3._id_F88B);

    if(isDefined(var_4)) {
      var_4 scripts\engine\utility::waittill_any_2("turret_fire", "turret_reload");
      _id_10186(var_1);
    }
  }
}

_id_101ED(var_0, var_1) {
  var_1 endon(var_1._id_BF06);
  var_2 = var_0 scripts\engine\utility::_id_108A0("death", "disconnect", "last_stand_start");

  if(var_2 == "death") {
    var_1._id_B68D = 1;
  } else if(var_2 == "disconnect") {
    var_1._id_B695 = 1;
  } else if(var_2 == "last_stand_start") {
    var_1._id_B707 = 1;
  }

  var_1 notify(var_1._id_BF05);
}

_id_101F0(var_0, var_1) {
  var_1 endon(var_1._id_BF06);
  var_0 waittill("death");
  var_1._id_102F7 = 1;
  var_1 notify(var_1._id_BF05);
}

_id_101EF(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4._id_BF06);

  while(isDefined(var_0)) {
    if(!_id_101F8(var_0, var_2, var_1)) {
      var_4._id_CFC6 = 1;
      var_4 notify(var_4._id_BF05);
      break;
    }

    waitframe();
  }
}

_id_101EC(var_0, var_1, var_2) {
  var_2 endon(var_2._id_BF06);

  if(isDefined(var_0) && isDefined(var_1)) {
    while(!istrue(var_2._id_54E4) || !istrue(var_2._id_5791)) {
      waitframe();
    }
  } else if(isDefined(var_0)) {
    while(!istrue(var_2._id_5791)) {
      waitframe();
    }
  } else {
    while(!istrue(var_2._id_54E4)) {
      waitframe();
    }
  }

  var_2 notify(var_2._id_BF05);
}

_id_101EE(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4._id_EACB)) {
    var_4._id_EACB = 1;
  }

  if(var_4._id_7D41) {
    var_4._id_B695 = scripts\engine\utility::ter_op(isDefined(var_1), 0, 1);

    if(!var_4._id_B695) {
      var_4._id_B68D = !var_1 scripts\cp_mp\utility\player_utility::_isalive();
      var_4._id_B707 = istrue(var_1.inlaststand);
    }

    var_4._id_102F7 = istrue(var_0._id_87FB);
  } else if(var_4._id_EACB) {
    if(isDefined(var_2) && !istrue(var_4._id_5791)) {
      var_4._id_EACB = 0;
    }

    if(isDefined(var_3) && !istrue(var_4._id_54E4)) {
      var_4._id_EACB = 0;
    }

    if(istrue(var_4._id_102F7)) {
      var_4._id_EACB = 0;
    }
  } else
    return 0;

  if(isDefined(var_3)) {
    if(istrue(var_4._id_B68D) || istrue(var_4._id_B707) || istrue(var_4._id_B695) || istrue(var_4._id_102F7) || istrue(var_4._id_CFC6)) {
      var_4._id_EACB = 0;
    }
  } else {}

  return var_4._id_EACB;
}

_id_1020F(var_0, var_1, var_2, var_3) {
  var_1 endon("disconnect");
  var_0 endon("death");
  var_0 endon("vehicle_clear_owner_" + var_1 getentitynumber());

  if(istrue(var_2)) {
    var_1 waittill("vehicle_seat_exit");
  }

  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, 20);
  wait(var_4);
  thread _id_1016E(var_0, var_1);
}

_id_10210(var_0, var_1) {
  var_1 endon("disconnect");
  var_0 endon("death");
  var_0 endon("vehicle_owner_update");
  var_1 scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  thread _id_1020C(var_0);
}

_id_101C3(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(level.teambased && isDefined(var_0.team)) {
    if(var_0.team != "neutral" && var_1.team != var_0.team) {
      return 0;
    }
  } else if(isDefined(var_0._id_AC8F)) {
    if(var_1 != var_0._id_AC8F) {
      return 0;
    }
  }

  return 1;
}

_id_1015E(var_0, var_1, var_2, var_3) {
  thread _id_10202();
  self endon("vehicle_occupancy_stopAnimatingPlayer");
  var_4 = _id_101A2(var_0._id_1031E, var_1);

  if(!isDefined(var_4._id_18F2)) {
    return;
  }
  var_5 = spawn("script_model", var_0 gettagorigin(var_4._id_18F2));
  var_5.angles = var_0 gettagangles(var_4._id_18F2);
  var_5 linkto(var_0, var_4._id_18F2, (0, 0, 0), (0, 0, 0));
  var_5 setModel("viewhands_base_iw8");
  var_5 hide();
  self._id_18BD = var_5;
  self _meth_868F();

  if(tolower(var_4._id_18F2) == "tag_seat_0") {
    self _meth_8692(0);
    self _meth_8691(0);
  } else if(_id_1025C(var_0, var_1)) {
    self _meth_8692(0);
    self _meth_8691(0);
  } else {
    if(istrue(var_4._id_7917)) {
      self _meth_8692(0);
    }

    if(istrue(var_4._id_78FF)) {
      self _meth_8691(0);
    }
  }

  if(!isDefined(var_4._id_F88B)) {
    if(!isDefined(var_2)) {
      self setplayerangles(var_5.angles * (0, 1, 0));
    } else if(tolower(var_4._id_18F2) == "tag_seat_0") {
      self setplayerangles(var_5.angles * (0, 1, 0));
    }
  }

  self _meth_8063();
  var_6 = undefined;

  if(istrue(var_6)) {
    self playerlinktodelta(var_5, "tag_player", 0, getdvarfloat("#x346123d2b1e8b1ff9", 180), getdvarfloat("#x3a63d5ac568b52c8c", 180), getdvarfloat("#x3e2f2bf74a0bbdd50", 180), getdvarfloat("#x3ae13d96ae03c9fae", 180), 0, 1, 0);
  } else if(var_4._id_103D2.size > 0) {
    self playerlinktodelta(var_5, "tag_player", 0, var_4._id_103D2["right"], var_4._id_103D2["left"], var_4._id_103D2["top"], var_4._id_103D2["bottom"], 0, 1, 0);
  } else {
    self playerlinktodelta(var_5, "tag_player", 0, 180, 180, 180, 180, 0, 1, 0);
  }

  var_7 = _id_1018E(var_0._id_1031E, var_1);

  if(_id_10164(var_7, var_3)) {
    self._id_18AF = var_7;
    var_5._id_18AF = var_7;
    var_5 useanimtree(level._id_CC34[var_7]);
    _id_10211(var_0, var_3, var_4._id_18F2);
  } else
    scripts\engine\utility::waittill_any_2("death_or_disconnect", "last_stand_start");

  if(isDefined(self)) {
    thread _id_10202();
  }

  var_5 delete();
}

_id_10211(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  self endon("last_stand_start");

  for(;;) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("anim", "player_solo")]](self, self._id_18BD, var_1, var_2);
  }
}

_id_10202() {
  if(!isDefined(self._id_18BD)) {
    return;
  }
  self notify("vehicle_occupancy_stopAnimatingPlayer");
  self _meth_8692(1);
  self _meth_8691(1);
  self _meth_8690();
  self _meth_8655();
  self._id_18AF = undefined;
  self._id_18BD delete();
}

_id_10164(var_0, var_1) {
  if(!isDefined(level._id_CC31[var_0])) {
    return 0;
  }

  return isDefined(level._id_CC31[var_0][var_1]);
}

_id_1018E(var_0, var_1) {
  return var_0 + "_" + var_1;
}

_id_1015B(var_0, var_1) {
  if(var_1) {
    var_0._id_A239--;

    if(var_0._id_A239 == 0) {
      if(isDefined(var_0._id_A924)) {
        _id_09CA::_id_1037B("movementDisabled", var_0._id_A924, var_0._id_1031E);

        foreach(var_4, var_3 in var_0._id_A924) {
          _id_1015C(var_0, var_3, 1, var_4);
        }
      }

      return 1;
    }
  } else {
    if(!isDefined(var_0._id_A239)) {
      var_0._id_A239 = 0;
    }

    var_0._id_A239++;

    if(var_0._id_A239 == 1) {
      if(isDefined(var_0._id_A924)) {
        _id_09CA::_id_10390("movementDisabled", var_0._id_A924, var_0._id_1031E);

        foreach(var_4, var_3 in var_0._id_A924) {
          _id_1015C(var_0, var_3, 0, var_4);
        }
      }

      return 0;
    }
  }
}

_id_10167(var_0) {
  if(isDefined(self._id_A924)) {
    foreach(var_3, var_2 in self._id_A924) {
      _id_1015C(1, var_2, var_3);
    }
  }

  var_0._id_A239 = undefined;
}

_id_1015C(var_0, var_1, var_2, var_3) {
  if(var_2) {
    if(istrue(var_1._id_102FA)) {
      if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_1 scripts\common\utility::_id_1559(1);
      }

      var_1._id_102FA = undefined;
    }
  } else {
    var_4 = _id_101A2(var_0._id_1031E, var_3);

    if(isDefined(var_4._id_18F2) && var_4._id_18F2 == "tag_seat_0") {
      if(!istrue(var_1._id_102FA)) {
        if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_1 scripts\common\utility::_id_1559(0);
          var_1._id_102FA = 1;
        }
      }
    }
  }
}

_id_10168(var_0, var_1) {
  if(!istrue(var_1) && istrue(var_0._id_102FA)) {
    var_0 scripts\common\utility::_id_1559(1);
  }

  var_0._id_102FA = undefined;
}

_id_101D1(var_0) {
  return !isDefined(var_0._id_A239) || var_0._id_A239 <= 0;
}

_id_1019E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_10199(var_0);
  var_6 = _id_101A2(var_0._id_1031E, var_2);
  var_7 = [];

  foreach(var_9 in var_6._id_5780) {
    var_10 = _id_1019D(var_0, var_1, var_9, var_5, var_3);

    if(isDefined(var_10)) {
      var_7[0] = var_10;
      var_11 = undefined;

      if(!isDefined(var_6._id_18F2) || var_6._id_18F2 != "tag_seat_0") {
        var_11 = _id_10198(var_0, var_1, var_9, var_4);
      }

      var_7[1] = var_11;
      return var_7;
    }
  }

  return undefined;
}

_id_1019D(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3._id_578E[var_2])) {
    return undefined;
  }

  if(isDefined(var_3._id_578B[var_2])) {
    return var_3._id_578B[var_2];
  }

  var_5 = _id_101A3(var_0._id_1031E);
  var_6 = var_5._id_5788[var_2];
  var_7 = var_5._id_5778[var_2];
  var_8 = physics_createcontents(["physicscontents_item", "physicscontents_water", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_playerclip"]);
  var_9 = var_0 _meth_8150(1);

  if(!isDefined(var_9)) {
    var_9 = [];
  }

  var_9[var_9.size] = var_0;
  var_10 = scripts\engine\utility::ter_op(isDefined(var_5._id_5796), var_5._id_5796, 20);
  var_11 = var_6[0];
  var_11 = clamp(var_11, var_3._id_A982["back"], var_3._id_A982["front"]);
  var_12 = scripts\engine\utility::ter_op(var_3._id_5CFD, var_6[1] * -1, var_6[1]);
  var_12 = clamp(var_12, var_3._id_A982["right"], var_3._id_A982["left"]);
  var_13 = (0, var_0.angles[1], 0);
  var_14 = var_0.origin;
  var_14 = var_14 + var_11 * anglesToForward(var_13);
  var_14 = var_14 + var_12 * anglestoright(var_13);
  var_15 = var_3._id_A982["bottom"] + (var_3._id_A982["top"] - var_3._id_A982["bottom"]) / 2;
  var_16 = var_3._id_A982["top"] + var_10;
  var_17 = undefined;
  var_18 = undefined;
  var_19 = var_14 + (0, 0, var_16);
  var_14 = var_14 + (0, 0, var_15);
  var_20 = "tag_body_animate";

  if(!var_0 tagexists(var_20)) {
    var_20 = "tag_body";
  }

  var_21 = var_0 gettagorigin(var_20);
  var_22 = 0;
  var_23 = _func_02C1(var_21, var_14, var_8, var_9, 0, "physicsquery_closest", 1);

  if(isDefined(var_23) && var_23.size > 0) {
    var_22 = 1;
  }

  if(var_22) {
    var_3._id_578E[var_2] = 1;
  } else {
    var_22 = 0;
    var_23 = _func_02C1(var_14, var_19, var_8, var_9, 0, "physicsquery_closest", 1);

    if(isDefined(var_23) && var_23.size > 0) {
      var_24 = 2;
      var_25 = (var_16 - var_15) * var_23[0]["fraction"];

      if(var_25 <= 72 + var_24) {
        var_22 = 1;
      } else {
        var_19 = var_23[0]["position"] - (0, 0, var_24);
      }
    }

    if(var_22) {
      var_3._id_578E[var_2] = 1;
      return;
    }

    var_7 = tolower(var_7);

    if(var_3._id_5CFD) {
      if(var_7 == "left") {
        var_7 = "right";
      } else if(var_7 == "right") {
        var_7 = "left";
      }
    }

    var_14 = var_19;
    var_26 = (0, 0, 0);
    var_27 = (0, 0, 0);
    var_28 = (0, 0, 0);
    var_29 = (0, 0, 0);
    var_30 = (0, 0, 0);
    var_31 = (0, 0, 0);

    if(var_7 == "left") {
      var_26 = var_26 + (var_11, 0, 0);
      var_26 = var_26 + (0, var_3._id_A982["left"], 0);
      var_29 = var_29 + (0, 32, 0);
    } else if(var_7 == "right") {
      var_26 = var_26 + (var_11, 0, 0);
      var_26 = var_26 + (0, var_3._id_A982["right"], 0);
      var_29 = var_29 + (0, -32, 0);
    } else if(var_7 == "front") {
      var_26 = var_26 + (var_3._id_A982["front"], 0, 0);
      var_26 = var_26 + (0, var_12, 0);
      var_29 = var_29 + (32, 0, 0);
    } else if(var_7 == "back") {
      var_26 = var_26 + (var_3._id_A982["back"], 0, 0);
      var_26 = var_26 + (0, var_12, 0);
      var_29 = var_29 + (-32, 0, 0);
    }

    var_27 = (0, 0, var_16);
    var_28 = var_26 + var_27;
    var_31 = var_29;
    var_14 = var_19;
    var_19 = var_0.origin + rotatevector(var_28 + var_31, var_13);
    var_22 = 0;
    var_23 = _func_02C1(var_14, var_19, var_8, var_9, 0, "physicsquery_closest", 1);

    if(isDefined(var_23) && var_23.size > 0) {
      var_22 = 1;
    }

    if(var_22) {
      var_3._id_578E[var_2] = 1;
      return;
    }

    var_29 = var_29 / 2;
    var_30 = (0, 0, -72);
    var_31 = var_29 + var_30;
    var_27 = (0, 0, var_3._id_A982["top"]) + (0, 0, var_10);
    var_28 = var_26 + var_27;
    var_14 = var_0.origin + rotatevector(var_28 + var_31, var_13);
    var_27 = (0, 0, var_3._id_A982["bottom"]) - (0, 0, 40);
    var_28 = var_26 + var_27;
    var_30 = (0, 0, 0);
    var_31 = var_29 + var_30;
    var_19 = var_0.origin + rotatevector(var_28 + var_31, var_13);
    var_22 = 0;
    var_23 = _func_02D2(var_14, var_19, var_1, 0, (0, 0, 0), var_8, var_9, "physicsquery_closest", "physicsquery_any");

    if(isDefined(var_23) && var_23.size > 0) {
      if(var_23[1]) {
        var_22 = 1;
      } else if(var_23[0].size == 0) {
        if(!istrue(var_4)) {
          var_22 = 1;
        } else {
          var_19 = var_19 + (0, 0, 40);
        }
      } else
        var_19 = var_23[0][0]["shape_position"];
    }

    if(var_22) {
      var_3._id_578E[var_2] = 1;
      return;
    }

    var_3._id_578B[var_2] = var_19;
  }
}

_id_10199(var_0) {
  var_1 = undefined;

  if(isDefined(var_0._id_5776) && var_0._id_5776._id_F27A == gettime()) {
    var_1 = var_0._id_5776;
  } else {
    var_2 = _id_101A3(var_0._id_1031E);

    if(isDefined(var_2) && isDefined(var_2._id_577C)) {
      var_3 = rotatevector((var_2._id_577C["front"], var_2._id_577C["left"] * -1, var_2._id_577C["top"]), var_0.angles);
      var_4 = rotatevector((var_2._id_577C["front"], var_2._id_577C["right"], var_2._id_577C["top"]), var_0.angles);
      var_5 = rotatevector((var_2._id_577C["back"] * -1, var_2._id_577C["left"] * -1, var_2._id_577C["top"]), var_0.angles);
      var_6 = rotatevector((var_2._id_577C["back"] * -1, var_2._id_577C["right"], var_2._id_577C["top"]), var_0.angles);
      var_7 = rotatevector((var_2._id_577C["front"], var_2._id_577C["left"] * -1, var_2._id_577C["bottom"] * -1), var_0.angles);
      var_8 = rotatevector((var_2._id_577C["front"], var_2._id_577C["right"], var_2._id_577C["bottom"] * -1), var_0.angles);
      var_9 = rotatevector((var_2._id_577C["back"] * -1, var_2._id_577C["left"] * -1, var_2._id_577C["bottom"] * -1), var_0.angles);
      var_10 = rotatevector((var_2._id_577C["back"] * -1, var_2._id_577C["right"], var_2._id_577C["bottom"] * -1), var_0.angles);
      var_11 = [var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10];
      var_12 = -99999;
      var_13 = 99999;
      var_14 = -99999;
      var_15 = 99999;
      var_16 = -99999;
      var_17 = 99999;
      var_18 = (0, var_0.angles[1], 0);

      foreach(var_20 in var_11) {
        var_20 = _func_01C8(var_20, var_18);

        if(var_20[0] > var_12) {
          var_12 = var_20[0];
        }

        if(var_20[0] < var_13) {
          var_13 = var_20[0];
        }

        if(var_20[1] < var_15) {
          var_15 = var_20[1];
        }

        if(var_20[1] > var_14) {
          var_14 = var_20[1];
        }

        if(var_20[2] > var_16) {
          var_16 = var_20[2];
        }

        if(var_20[2] < var_17) {
          var_17 = var_20[2];
        }
      }

      var_1 = spawnStruct();
      var_0._id_5776 = var_1;
      var_1 = var_1;
      var_1.vehicle = var_0;
      var_1._id_F27A = gettime();
      var_1._id_A982["front"] = var_12;
      var_1._id_A982["back"] = var_13;
      var_1._id_A982["left"] = var_14;
      var_1._id_A982["right"] = var_15;
      var_1._id_A982["top"] = var_16;
      var_1._id_A982["bottom"] = var_17;
      var_1._id_578E = [];
      var_1._id_578B = [];
      var_1._id_AC6F = [];
      var_1._id_F999 = [];
      var_1._id_5CFD = abs(_func_000B(var_0.angles[2])) > 90;
      var_1 thread _id_10009();
    }
  }

  return var_1;
}

_id_10009() {
  waitframe();

  if(isDefined(self.vehicle)) {
    return;
  }
  if(!isDefined(self.vehicle._id_5776)) {
    return;
  }
  if(self.vehicle._id_5776._id_F27A != self._id_F27A) {
    return;
  }
  self.vehicle._id_5776 = undefined;
}

_id_10198(var_0, var_1, var_2, var_3) {
  var_4 = _id_101A3(var_0._id_1031E);
  var_5 = _id_10199(var_0);
  var_6 = var_5._id_578B[var_2];
  var_7 = undefined;
  var_8 = 0;

  if(istrue(var_3)) {
    var_7 = var_0.origin + rotatevector(var_4._id_5788[var_2], var_0.angles);
    var_8 = 1;
  }

  if(!isDefined(var_7)) {
    var_7 = var_1 getvieworigin() + anglesToForward(var_1 getplayerangles()) * 550;
  }

  var_9 = undefined;

  if(istrue(var_3)) {
    var_9 = var_6 + (0, 0, 22);
  } else {
    var_9 = var_6 + (0, 0, 60);
  }

  var_10 = vectornormalize(var_7 - var_9);

  if(!var_8) {
    var_11 = physics_createcontents(["physicscontents_vehicle", "physicscontents_item"]);
    var_12 = _func_02C1(var_9, var_9 + var_10 * 300, var_11, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_12) && var_12.size > 0) {
      var_13 = var_12[0]["entity"];
      var_14 = 0;

      if(isDefined(var_13)) {
        var_15 = var_0 _meth_8150(1);

        if(!isDefined(var_15)) {
          var_15 = [];
        }

        var_15[var_15.size] = var_0;

        foreach(var_17 in var_15) {
          if(var_13 == var_17) {
            var_14 = 1;
            break;
          }
        }
      }

      if(var_14) {
        var_19 = var_4._id_5778[var_2];
        var_20 = (0, var_0.angles[1], 0);

        if(var_19 == "left" || var_19 == "right") {
          var_21 = anglestoright(var_20);
        } else {
          var_21 = anglesToForward(var_20);
        }

        var_10 = var_10 - var_21 * vectordot(var_10, var_21);
      }
    }
  }

  var_22 = vectortoangles(var_10);
  var_22 = (clamp(var_22[0], -12, 12), var_22[1], 0);
  return var_22;
}

_id_101A0(var_0, var_1, var_2) {
  var_3 = vectordot((0, 0, 1), anglestoup(var_0.angles)) < 0;
  var_4 = _id_101A3(var_0._id_1031E);
  var_5 = undefined;
  var_6 = undefined;

  if(var_3) {
    if(!isDefined(var_4._id_577E)) {
      return undefined;
    }

    var_5 = var_4._id_577E;
    var_6 = anglestoup(var_0.angles) * -1;
  } else {
    if(!isDefined(var_4._id_577D)) {
      return undefined;
    }

    var_5 = var_4._id_577D;
    var_6 = anglestoup(var_0.angles);
  }

  var_7 = _id_1019A();
  var_8 = _id_1019B(var_0);
  var_9 = var_0.origin + var_6 * var_5;
  var_10 = _func_02C7(var_9, 16, 36, (0, 0, 0), 0, var_7, var_8, "physicsquery_closest");

  if(!isDefined(var_10) || var_10.size <= 0) {
    return [var_9, var_0.angles * (0, 1, 0)];
  } else {
    return undefined;
  }
}

_id_10187(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || istrue(var_4._id_B68D) || isDefined(var_3)) {
    return 1;
  }

  var_5 = _id_101A3(var_1._id_1031E);
  var_6 = istrue(var_5._id_1597) || istrue(var_4._id_1597) || !var_1 scripts\cp_mp\vehicles\vehicle_tracking::_id_0C41() && !var_1 _meth_8726();
  var_7 = _id_1019E(var_1, var_0, var_2, var_6, var_4._id_B707);

  if(isDefined(var_7)) {
    var_4._id_578A = var_7[0];
    var_4._id_5774 = var_7[1];
    return 1;
  } else
    return 0;
}

_id_101D2(var_0, var_1, var_2) {
  if(!isDefined(var_0) || istrue(var_2._id_B68D) && !istrue(var_2._id_B707) || isDefined(var_1)) {
    return 1;
  }

  if(isDefined(var_2._id_578A)) {
    var_0 unlink();
    var_0 dontinterpolate();
    var_0 setorigin(var_2._id_578A, 1, 1);
    var_0 setstance("stand");

    if(isDefined(var_2._id_5774)) {
      var_0 setplayerangles(var_2._id_5774);
    }

    return 1;
  } else
    return 0;
}

_id_1019A() {
  return physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_playerclip"]);
}

_id_1019B(var_0) {
  var_1 = _id_101A3(var_0._id_1031E);
  var_2 = [var_0];

  if(isDefined(var_1._id_5781)) {
    var_2 = [[var_1._id_5781]](var_0);
  }

  return var_2;
}

_id_1015F(var_0) {
  var_0 = tolower(var_0);
  var_1 = _func_00D6(var_0, 8, var_0.size);
  return "tag_seat_exit" + var_1;
}

_id_1020E(var_0) {
  self endon("death");

  for(;;) {
    _id_1020B(var_0);
    waitframe();
  }
}

_id_1020B(var_0) {
  var_1 = _id_101AC(self, var_0);
  var_2 = _id_1018B(self);

  if(isDefined(var_1)) {
    var_3 = var_1 getnormalizedmovement()[0];

    if(abs(var_3) > 0.15) {
      foreach(var_5 in var_2) {
        if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_5 _id_10201();
        }
      }

      return;
    }

    foreach(var_5 in var_2) {
      if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_5 _id_10204();
      }
    }

    return;
  } else if(isDefined(var_2)) {
    foreach(var_5 in var_2) {
      if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
        var_5 _id_10204();
      }
    }
  }
}

_id_10201() {
  if(istrue(self._id_1031D)) {
    return;
  }
  self._id_1031D = 1;
  self setscriptablepartstate("vehicleMoveShake", "active1", 0);
}

_id_10204() {
  if(!istrue(self._id_1031D)) {
    return;
  }
  self._id_1031D = undefined;
  self setscriptablepartstate("vehicleMoveShake", "neutral", 0);
}

_id_10208(var_0) {
  var_1 = _id_101A3(self._id_1031E);

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0.damage) || var_0.damage <= 0) {
    return;
  }
  if(!isDefined(var_0._id_9CD6)) {
    return;
  }
  var_2 = undefined;
  var_3 = undefined;

  switch (var_0._id_9CD6) {
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      var_2 = "light";
      var_3 = var_1._id_4300;
      break;
    case "MOD_EXPLOSIVE":
    case "MOD_IMPACT":
    case "MOD_PROJECTILE_SPLASH":
      var_2 = "heavy";
      var_3 = var_1._id_42FF;
      break;
  }

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3) || var_3 == "none") {
    return;
  }
  var_4 = [];

  if(var_3 == "driver") {
    foreach(var_7, var_6 in var_1._id_CFBE) {
      if(!isDefined(var_6._id_18F2)) {
        continue;
      }
      if(var_6._id_18F2 == "tag_seat_0") {
        var_4 = [_id_101AC(self, var_7)];
        break;
      }
    }
  } else if(var_3 == "all")
    var_4 = _id_1018B(self);

  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  foreach(var_9 in var_4) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(!var_9 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(var_2 == "light") {
      var_9 thread _id_101C6();
      continue;
    }

    if(var_2 == "heavy") {
      var_9 thread _id_101B4();
    }
  }
}

_id_101C6() {
  self endon("disconnect");
  self endon("vehicle_occupancy_clearLightDamageFeedbackPlayer");

  if(!isDefined(self._id_10319)) {
    self._id_10319 = 1;
  }

  self setscriptablepartstate("vehicleDamageShakeLight", "active" + self._id_10319, 0);
  self._id_10319 = 1 + scripts\engine\utility::_id_9FC4(self._id_10319 + 1, 3);
  wait 0.15;
  thread _id_1016D();
}

_id_1016D() {
  self notify("vehicle_occupancy_clearLightDamageFeedbackPlayer");
  self setscriptablepartstate("vehicleDamageShakeLight", "neutral", 0);
  self._id_10319 = undefined;
}

_id_101B4() {
  self endon("disconnect");
  self endon("vehicle_occupancy_clearHeavyDamageFeedbackPlayer");

  if(!isDefined(self._id_1030A)) {
    self._id_1030A = 1;
  }

  self setscriptablepartstate("vehicleDamageShakeHeavy", "active" + self._id_1030A, 0);
  self._id_1030A = 1 + scripts\engine\utility::_id_9FC4(self._id_1030A + 1, 3);
  wait 0.3;
  thread _id_1016C();
}

_id_1016C() {
  self notify("vehicle_occupancy_clearHeavyDamageFeedbackPlayer");
  self setscriptablepartstate("vehicleDamageShakeHeavy", "neutral", 0);
  self._id_1030A = undefined;
}

_id_10169() {
  _id_1016D();
  _id_1016C();
}

_id_101B3(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2._id_BF06)) {
    var_2 endon(var_2._id_BF06);
  }

  if(istrue(var_3)) {
    childthread _id_101B2(var_2, 1.5);
  }

  if(!var_0 hasweapon(var_1)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);
  }

  var_4 = undefined;

  if(var_0 scripts\cp_mp\utility\inventory_utility::_id_87E0(var_1)) {
    var_4 = 1;
  } else {
    thread _id_10188(var_0, var_2);
    var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1, 1);
  }

  _id_1016B(var_0);

  if(isDefined(var_2) && isDefined(var_4) && !var_4) {
    var_2._id_EACB = 0;
    var_2 notify(var_2._id_BF05);
  }
}

_id_10206(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3._id_BF06)) {
    var_3 endon(var_3._id_BF06);
  }

  if(istrue(var_4)) {
    childthread _id_101B2(var_3, 1.5);
  }

  if(var_0 hasweapon(var_2)) {
    var_5 = undefined;
    thread _id_1016B(var_0);

    if(var_0 scripts\cp_mp\utility\inventory_utility::_id_8A86(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::_id_0E0C(makeweapon(var_2));
      var_5 = 1;
    } else {
      var_6 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_1, var_2);

      if(isDefined(var_6)) {
        var_0 _meth_8292(var_6);
      }

      if(var_0 hasweapon(var_2)) {
        var_7 = var_0 scripts\cp_mp\utility\inventory_utility::_id_87E0(var_2);

        if(var_7) {
          var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
          var_0 thread scripts\cp_mp\utility\inventory_utility::_id_5ED6();
        } else
          var_0 thread scripts\cp_mp\utility\inventory_utility::_id_6CF7(var_2, 1);
      }

      var_5 = 1;
    }

    if(isDefined(var_5) && !var_5) {
      var_3._id_EACB = 0;
      var_3 notify(var_3._id_BF05);
    }
  }
}

_id_101B2(var_0, var_1) {
  wait(var_1);
  var_0._id_EACB = 0;
  var_0 notify(var_0._id_BF05);
}

_id_10188(var_0, var_1) {
  var_0 endon("death_or_disconnect");
  var_0 notify("vehicle_occupancy_forceWeaponSwitchAllowed");
  var_0 endon("vehicle_occupancy_forceWeaponSwitchAllowed");

  if(var_0 scripts\common\utility::_id_8724()) {
    return;
  }
  var_0 enableweaponswitch();
  var_1 waittill(var_1._id_BF06);
  thread _id_1016B(var_0);
}

_id_1016B(var_0) {
  var_0 notify("vehicle_occupancy_forceWeaponSwitchAllowed");

  if(var_0 scripts\common\utility::_id_8724()) {
    var_0 enableweaponswitch();
  } else {
    var_0 disableweaponswitch();
  }
}

_id_1017D(var_0) {
  var_1 = _id_1018D(var_0);

  foreach(var_3 in var_1) {
    var_4 = _id_101AC(var_0, var_3);

    if(isDefined(var_4)) {
      var_5 = spawnStruct();
      var_5._id_1597 = 1;
      var_5._id_5797 = "INVOLUNTARY";
      thread _id_10182(var_0, var_3, var_4, var_5, 1);
    }
  }
}

_id_101A5() {
  return ["crouch", "prone", "sprint", "mantle", "mount_top", "mount_side", "vehicle_use", "crate_use", "ladder_placement", "execution_attack", "execution_victim"];
}

_id_10194() {
  return ["usability", "offhand_weapons", "melee", "fire", "reload", "autoreload", "weapon_switch", "cough_gesture"];
}

_id_10191() {
  return ["weapon_pickup"];
}

_id_10190() {
  var_0 = _id_10191();
  return var_0;
}

_id_101A7() {
  return _id_10194();
}

_id_101AF() {
  var_0 = _id_10191();
  var_0[var_0.size] = "cough_gesture";
  var_0[var_0.size] = "offhand_weapons";
  return scripts\engine\utility::_id_1BC1(var_0);
}

_id_1017C(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_0 notify("vehicle_occupancy_disableFireForTime");
  var_0 endon("vehicle_occupancy_disableFireForTime");

  if(!istrue(self._id_102FB)) {
    var_0._id_102FB = 1;
    var_0 scripts\common\utility::_id_153E(0, "vehicleDisableFire");
  }

  if(!isDefined(var_0._id_102FC) || !istrue(var_2)) {
    var_0._id_102FC = gettime() + var_1;
  }

  while(isDefined(var_0._id_102FC) && gettime() < var_0._id_102FC) {
    wait 0.05;
  }

  thread _id_1016A(var_0);
}

_id_1016A(var_0, var_1) {
  var_0 notify("vehicle_occupancy_disableFireForTime");

  if(isDefined(var_0._id_102FB)) {
    if(!istrue(var_1)) {
      var_0 scripts\common\utility::_id_153E(1, "vehicleDisableFire");
    }
  }

  var_0._id_102FB = undefined;
  var_0._id_102FC = undefined;
}

_id_10205(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "takeRiotShield")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "takeRiotShield")]](var_0, var_1, var_2);
  }
}

_id_101B1(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "giveRiotShield")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "giveRiotShield")]](var_0, var_1, var_2);
  }
}

_id_1020D(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "updateRiotShield")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "updateRiotShield")]](var_0, var_1, var_2);
  }
}

_id_101B5(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "hideCashBag")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "hideCashBag")]](var_0, var_1, var_2, var_3);
  }
}

_id_101FD(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "showCashBag")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "showCashBag")]](var_0, var_1, var_2, var_3);
  }
}

_id_101F3(var_0) {
  if(isDefined(var_0._id_D0C9) && var_0._id_D0C9 > 0) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "registerSentient")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "registerSentient")]](var_0);
  }
}

_id_10207(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "unregisterSentient")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "unregisterSentient")]](var_0);
  }
}

_id_101C4(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "isSentient")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "isSentient")]](var_0);
  }
}

_id_1015D(var_0) {
  if(var_0) {
    self._id_D0C9--;

    if(self._id_D0C9 == 0) {
      _id_101F3(self);
    }
  } else {
    if(!isDefined(self._id_D0C9)) {
      self._id_D0C9 = 0;
    }

    self._id_D0C9++;

    if(self._id_D0C9 == 1) {
      _id_10207(self);
    }
  }
}

_id_101C8(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_CFC1 = var_1;
  var_3 = _id_101A2(var_0._id_1031E, var_1);

  if(isDefined(var_3._id_18F2)) {
    var_2.origin = var_0 gettagorigin(var_3._id_18F2);
    var_2.angles = var_0 gettagangles(var_3._id_18F2);
  } else {
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
  }

  return var_2;
}

_id_101C7(var_0, var_1, var_2) {
  var_3 = _id_101A2(var_1._id_1031E, var_2);

  if(isDefined(var_3._id_18F2)) {
    var_0 _meth_80DB();
    var_0 linkto(var_1, var_3._id_18F2);
  } else {
    var_0 _meth_80DB();
    var_0 linkto(var_1);
  }
}

_id_10163(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1._id_3D87)) {
    var_1._id_3D87 = [];
  }

  _id_10178(var_1, var_2, 0);
  var_1._id_3D87[var_2] = var_0;

  if(!var_3) {
    var_0._id_4D9C = 1;
  }
}

_id_1016F(var_0, var_1, var_2) {
  if(isDefined(var_1._id_3D87) && isDefined(var_1._id_3D87[var_2])) {
    var_1._id_3D87[var_2] = undefined;
  }

  var_0._id_4D9C = undefined;
}

_id_10178(var_0, var_1, var_2) {
  if(isDefined(var_0._id_3D87) && isDefined(var_0._id_3D87[var_1])) {
    var_3 = var_0._id_3D87[var_1];

    if(isDefined(var_3)) {
      if(!istrue(var_3._id_4D9C) || !var_2) {
        var_0._id_3D87[var_1] delete();
        var_0._id_3D87[var_1] = undefined;
      }
    }
  }
}

_id_10179(var_0) {
  if(isDefined(var_0._id_3D87)) {
    foreach(var_2 in var_0._id_3D87) {
      if(isDefined(var_2)) {
        var_2 delete();
      }
    }
  }

  var_0._id_3D87 = undefined;
}

_id_1018A(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    if(!var_3) {
      if(var_0 == var_1[var_4]) {
        var_3 = 1;
      }
    } else {
      var_4 = scripts\engine\utility::_id_9FC4(var_4, var_1.size);

      if(var_0 == var_1[var_4]) {
        break;
      }

      var_2[var_2.size] = var_1[var_4];
    }

    var_4++;
  }

  return var_2;
}

_id_101C5(var_0, var_1) {
  if(!isDefined(var_1.inflictor)) {
    switch (var_1._id_9CD6) {
      case "MOD_GRENADE_SPLASH":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        if(isDefined(var_0.killcament)) {
          var_0.killcament delete();
        }

        var_0.killcament = var_1.inflictor;
        var_1.inflictor = var_0;
    }
  }

  if(!isDefined(var_1.inflictor)) {
    var_1.inflictor = undefined;
  }

  var_2 = var_1._id_9CD6;

  if(var_2 == "MOD_PROJECTILE") {
    var_2 = "MOD_PROJECTILE_SPLASH";
  } else if(var_2 == "MOD_GRENADE") {
    var_2 = "MOD_GRENADE_SPLASH";
  }

  self.killoccupants = 1;
  var_3 = _id_1018D(self);

  foreach(var_5 in var_3) {
    var_6 = _id_101AC(self, var_5);

    if(isDefined(var_6) && var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_7 = var_1.attacker;

      if(scripts\common\utility::iscp()) {
        var_6._id_DBD6 = 1;

        if(!isDefined(var_7)) {
          if(isDefined(var_1.inflictor)) {
            var_7 = var_1.inflictor;
          }
        }

        if(!isDefined(var_7)) {
          var_7 = var_6;
        }

        if(isDefined(var_7) && isDefined(var_7.team)) {
          if(var_7.team == var_6.team) {
            _id_10182(self, var_5, var_6, undefined, 1);
            var_6._id_DDCB = 1;
            continue;
          }
        }
      } else if(!isDefined(var_7) || !scripts\cp_mp\utility\player_utility::_id_B78C(var_7, var_6))
        var_7 = var_6;

      var_6._id_4D71 = 1;
      var_6 dodamage(var_6.maxhealth, var_0.origin, var_7, var_1.inflictor, var_2, var_1.objweapon, "torso_upper");

      if(isDefined(level._id_1031F)) {
        var_6 thread[[level._id_1031F]]();
      }

      var_6._id_4D71 = undefined;
      thread _id_10182(var_0, var_5, var_6, undefined, 1);
    }
  }

  _id_10179(var_0);
}

_id_101BA() {
  var_0 = _id_101A1();
  var_0._id_44D8 = [];
}