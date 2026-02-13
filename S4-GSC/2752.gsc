/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2752.gsc
*************************************************/

_id_101DA() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", ::_id_101DC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", ::_id_101DD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "registerInstance", ::_id_101DE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "deregisterInstance", ::_id_101D4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateOwner", ::_id_101E6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "registerSentient", ::_id_101DF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "unregisterSentient", ::_id_101E4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "isSentient", ::_id_101DB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "takeRiotShield", ::_id_101E3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "giveRiotShield", ::_id_101D6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateRiotShield", ::_id_101E7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "hideCashBag", ::_id_101D7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "showCashBag", ::_id_101E0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "changedSeats", ::_id_101D3);
  scripts\mp\playeractions::_id_C23B("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
  scripts\mp\playeractions::_id_C23B("vehicle_passenger", ["gesture", "supers", "cp_munitions"]);
}

_id_101DC(var_0, var_1, var_2, var_3) {
  if(level.gametype != "base") {
    var_2 scripts\mp\utility\perk::_id_6FC2("specialty_ghost");
  }

  var_2 scripts\mp\utility\perk::_id_6FC2("specialty_tracker_jammer");
  var_4 = level.gametype == "br";

  if(!var_4 || scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BC(var_0, var_1)) {
    var_2 scripts\mp\playeractions::_id_1596("vehicle", 0);
  } else if(var_4) {
    var_2 scripts\mp\playeractions::_id_1596("vehicle_passenger", 0);
  }

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    scripts\mp\gametypes\br_plunder::_id_B92B(var_2, 0, 1);
  }

  _id_101E3(var_2);
  scripts\mp\outofbounds::enableoobimmunity(var_2);

  if(scripts\mp\outofbounds::_id_8965(var_0, 1)) {
    var_0 thread _id_0AC1::_id_10223(var_2);
  }

  if(isDefined(var_2.team) && isDefined(var_2._id_E496) && istrue(var_0._id_89D9)) {
    thread _id_0819::_id_C1AD(var_2.team, var_2._id_E496);
  }

  _id_101E5(var_0);
}

_id_101DD(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3._id_B695)) {
    if(!istrue(var_3._id_B68D)) {
      if(level.gametype != "base") {
        var_2 scripts\mp\utility\perk::removeperk("specialty_ghost");
      }

      var_2 scripts\mp\utility\perk::removeperk("specialty_tracker_jammer");
      var_4 = level.gametype == "br";

      if(!var_4 || scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BC(var_0, var_1)) {
        var_2 scripts\mp\playeractions::_id_1596("vehicle", 1);
      } else if(var_4) {
        var_2 scripts\mp\playeractions::_id_1596("vehicle_passenger", 1);
      }

      if(getDvar("#x3f59526763711edc4", "") == "dmz") {
        scripts\mp\gametypes\br_plunder::_id_B92B(var_2, 1, 1);
      }

      if(scripts\mp\outofbounds::_id_8965(var_0, 1)) {
        var_0 thread _id_0AC1::_id_10225(var_2);
        var_2.oobvehicle = var_0;
      }

      scripts\mp\outofbounds::disableoobimmunity(var_2);

      if(isDefined(var_2.oobvehicle)) {
        var_2.oobvehicle = undefined;
      }
    }

    _id_101D6(var_2, var_3._id_B68D, var_3._id_B707);

    if(isDefined(var_2.team) && isDefined(var_2._id_E496) && istrue(var_0._id_89D9)) {
      thread _id_0819::_id_C1AD(var_3.team, var_3._id_E496);
    }

    var_2 notify("vehicle_exit");
  }

  _id_101E5(var_0);
}

_id_101D3(var_0, var_1, var_2, var_3) {
  var_4 = level.gametype == "br";

  if(var_4 && isDefined(var_2) && isDefined(var_3)) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BC(var_1, var_2)) {
      var_0 scripts\mp\playeractions::_id_1596("vehicle", 1);
      var_0 scripts\mp\playeractions::_id_1596("vehicle_passenger", 0);
    } else if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BC(var_1, var_3)) {
      var_0 scripts\mp\playeractions::_id_1596("vehicle_passenger", 1);
      var_0 scripts\mp\playeractions::_id_1596("vehicle", 0);
    }
  }
}

_id_101E5(var_0) {
  if(!isDefined(var_0._id_A924)) {
    return;
  }
  if(!isDefined(var_0._id_9B86)) {
    var_0._id_9B86 = 1;
  }

  var_1 = var_0._id_9B86;
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(var_0);
  var_0._id_9B86 = var_2.size > 0;

  if(var_1 && !var_0._id_9B86) {
    var_0 _meth_86FF("killstreak");
  } else if(!var_1 && var_0._id_9B86) {
    var_0 _meth_86FE("killstreak");
  }

  if(var_0._id_9B86) {
    if(level.teambased) {
      var_3 = [];

      foreach(var_5 in var_2) {
        if(!scripts\engine\utility::array_contains(var_3, var_5.team)) {
          var_3[var_3.size] = var_5.team;
        }
      }

      var_0 _meth_8706(var_3);
    } else
      var_0 _meth_8706(var_2);
  }
}

_id_101DE(var_0) {}

_id_101D4(var_0) {}

_id_101D7(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2(var_0._id_1031E, var_1);

  if(istrue(var_4._id_DC8E)) {
    return;
  }
  if(isDefined(level._id_9891) && scripts\engine\utility::array_contains(level._id_9891, var_2)) {
    if(isDefined(var_2._id_1D7D)) {
      stopFXOnTag(level._effect["vfx_br_cashLeaderBag"], var_2, "j_bag_left");
      var_2 hidepart("j_bag_left", "accessory_money_bag_large_closed_player");
    }
  }
}

_id_101E0(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2(var_0._id_1031E, var_1);

  if(istrue(var_4._id_DC8E)) {
    return;
  }
  if(isDefined(level._id_9891) && scripts\engine\utility::array_contains(level._id_9891, var_2)) {
    if(isDefined(var_2._id_1D7D)) {
      var_2 showpart("j_bag_left", "accessory_money_bag_large_closed_player");
      playFXOnTag(level._effect["vfx_br_cashLeaderBag"], var_2, "j_bag_left");
    }
  }
}

_id_101E6(var_0) {
  _id_101E5(var_0);
}

_id_101E3(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = var_0 getweaponslistprimaries();

  foreach(var_8 in var_6) {
    if(isnullweapon(var_8)) {
      continue;
    }
    if(_id_080B::_id_8A09(var_8)) {
      var_3 = var_8;

      if(issameweapon(var_3, var_0 getcurrentprimaryweapon())) {
        var_4 = 1;
      }

      continue;
    }

    if(!isDefined(var_5)) {
      var_9 = var_8 _meth_8628();

      if(var_9._id_0241 != "primary") {
        continue;
      }
      var_5 = var_8;
    }
  }

  if(isDefined(var_3)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
    var_0._id_C88C = var_3;
    var_0._id_C885 = var_4;

    if(istrue(var_4)) {
      _id_101E7(var_0, var_1, var_2);
    }

    var_0 scripts\mp\class::_id_C88B(var_5);
    var_0 notify("modified_riot_shield");
    var_0 endon("modified_riot_shield");
    var_0 childthread scripts\cp_mp\utility\inventory_utility::_id_5ED6(var_5);
  }
}

_id_101D6(var_0, var_1, var_2) {
  if(isDefined(var_0._id_C88C)) {
    if(!istrue(var_1) && !istrue(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0._id_C88C);
      var_0 scripts\mp\class::_id_F432();

      if(istrue(var_0._id_C885)) {
        var_0 notify("modified_riot_shield");
        var_0 endon("modified_riot_shield");
        var_0 childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0._id_C88C);
      }
    }

    var_0._id_C88C = undefined;
    var_0._id_C885 = undefined;
    var_0 notify("modified_riot_shield");
  }
}

_id_101E7(var_0, var_1, var_2) {
  if(isDefined(var_0._id_C88C) && istrue(var_0._id_C885)) {
    if(!isDefined(var_2)) {
      return;
    }
    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_101BC(var_1, var_2)) {
      return;
    }
    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_1025C(var_1, var_2)) {
      return;
    }
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2(var_1._id_1031E, var_2);

    if(isDefined(var_3._id_F88B)) {
      return;
    }
    var_0._id_C885 = undefined;
  }
}

_id_101DF(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3(var_0._id_1031E);

  if(!isDefined(var_1._id_048B)) {
    return;
  }
  if(level.teambased) {
    var_2 = var_0.team;

    if(isDefined(var_0.team) && var_0.team == "neutral") {
      var_2 = undefined;
    }

    if(!isDefined(var_2) && isDefined(var_0.owner)) {
      var_2 = var_0.owner.team;
    }

    if(isDefined(var_2)) {
      if(!isDefined(var_0._id_D0CD) || var_0._id_D0CD != var_2) {
        _id_101E4(var_0);
        var_0 _id_0812::_id_C2B2(var_1._id_048B, var_2);
        var_0._id_D0CD = var_2;
      }
    } else if(isDefined(var_0._id_D0CD))
      _id_101E4(var_0);
  }
}

_id_101E4(var_0) {
  var_0 notify("remove_sentient");
  var_0._id_D0CD = undefined;
}

_id_101DB(var_0) {
  return isDefined(var_0._id_D0CD);
}