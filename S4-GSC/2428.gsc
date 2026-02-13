/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2428.gsc
*************************************************/

_id_10172() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onEnterVehicle", ::_id_10173);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "onExitVehicle", ::_id_10174);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "handleSuicideFromVehicles", ::_id_10171);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "takeRiotShield", ::_id_10175);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "giveRiotShield", ::_id_10170);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "updateRiotShield", ::_id_10176);
  scripts\mp\playeractions::_id_C23B("vehicle", ["gesture", "killstreaks", "supers", "cp_munitions"]);
}

_id_10173(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0._id_1029D)) {
    [[var_0._id_1029D]](var_0, var_1, var_2, var_3);
  }

  var_2 scripts\mp\playeractions::_id_1596("vehicle", 0);
  scripts\cp\cp_outofbounds::enableoobimmunity(var_2);

  if(scripts\cp\cp_outofbounds::_id_8965(var_0, 1)) {
    var_0 thread _id_097D::_id_10217(var_2);
  }

  if(isDefined(var_2._id_9509)) {
    var_2._id_9509 hide();
    var_2._id_9509 unlink();
  }

  if(istrue(var_0._id_2C51)) {
    var_2 scripts\cp\utility::_id_1566(1);
  }

  var_2._id_2522 = 1;
  var_2._id_4DA7 = 1;
  var_2._id_4DA8 = 1;
  var_2 notify("entered_vehicle");
}

_id_10174(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0._id_1029E)) {
    [[var_0._id_1029E]](var_0, var_1, var_2, var_3);
  }

  if(!istrue(var_3._id_B695)) {
    if(!istrue(var_3._id_B68D)) {
      var_2 scripts\mp\playeractions::_id_1596("vehicle", 1);

      if(scripts\cp\cp_outofbounds::_id_8965(var_0, 1)) {
        var_0 thread _id_097D::_id_10219(var_2);
      }

      scripts\cp\cp_outofbounds::disableoobimmunity(var_2);
    }

    var_2 notify("vehicle_exit");
  }

  if(istrue(var_0._id_2C51)) {
    var_2 scripts\cp\utility::_id_1566(0);
  }

  if(isDefined(var_2._id_9509)) {
    var_2._id_9509 linkto(var_2, "tag_shield_back", (5, 10, 0), (0, 0, 90));
    var_2._id_9509 show();
  }

  var_2._id_DBD8 = undefined;
  var_2._id_2522 = 0;
  var_2._id_4DA7 = undefined;
  var_2._id_4DA8 = undefined;
  var_2 notify("exited_vehicle");
}

_id_10171(var_0) {
  var_0._id_DBD6 = 1;
  var_0._id_DBD8 = 1;
  var_0 dodamage(var_0.health + 50, var_0.origin);
}

_id_10175(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = var_0 getweaponslistprimaries();

  foreach(var_8 in var_6) {
    if(isnullweapon(var_8)) {
      continue;
    }
    if(scripts\cp\utility::_id_8A09(var_8)) {
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
      _id_10176(var_0, var_1, var_2);
    }

    var_0 scripts\cp\cp_weapon::_id_C88B(var_5);
    var_0 notify("modified_riot_shield");
    var_0 endon("modified_riot_shield");
    var_0 childthread scripts\cp_mp\utility\inventory_utility::_id_5ED6(var_5);
  }
}

_id_10170(var_0, var_1, var_2) {
  if(isDefined(var_0._id_C88C)) {
    if(!istrue(var_1) && !istrue(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0._id_C88C);
      var_0 scripts\cp\cp_weapon::_id_F432();

      if(istrue(var_0._id_C885)) {
        var_0 notify("modified_riot_shield");
        var_0 endon("modified_riot_shield");
        var_0 childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0._id_C88C);
      }
    } else if(!istrue(var_1) && istrue(var_2))
      var_0._id_C881 = var_0._id_C88C;

    var_0._id_C88C = undefined;
    var_0._id_C885 = undefined;
    var_0 notify("modified_riot_shield");
  }
}

_id_10176(var_0, var_1, var_2) {
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