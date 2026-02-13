/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1785.gsc
*************************************************/

init() {
  level._id_0E54 = [];
  level._id_0E55 = [];
  level._id_0E57 = [];
  level._id_0E4C = [];
  level._id_0E56 = [];
  level._id_0E53 = [];
  level._id_0E58 = [];
  level._id_0E4E = [];
  level._id_0E51 = [];
  level._id_0E4D = [];
  level._id_0E50 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/accessorytable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/accessorytable.csv", var_0, 1);

    if(!isDefined(var_2) || var_2 == "") {
      var_0++;
      continue;
    }

    var_3 = tablelookupbyrow("mp/accessorytable.csv", var_0, 2);

    if(!isDefined(var_3) || var_3 == "") {
      var_0++;
      continue;
    }

    var_4 = tablelookupbyrow("mp/accessorytable.csv", var_0, 3);

    if(isDefined(var_4) && var_4 == "") {
      var_4 = undefined;
    }

    var_5 = int(tablelookupbyrow("mp/accessorytable.csv", var_0, 10));

    if(isDefined(var_5)) {
      level._id_0E55[var_5] = var_2;
    }

    var_6 = tablelookupbyrow("mp/accessorytable.csv", var_0, 15);

    if(var_6 != "") {
      level._id_0E56[var_1] = var_6;
      level._id_0E57[var_5] = var_6;
    }

    var_7 = tablelookupbyrow("mp/accessorytable.csv", var_0, 17);

    if(var_7 != "") {
      level._id_0E4E[var_3] = var_7;
    }

    var_8 = tablelookupbyrow("mp/accessorytable.csv", var_0, 18);

    if(var_8 != "") {
      level._id_0E51[var_3] = var_8;
    }

    var_9 = tablelookupbyrow("mp/accessorytable.csv", var_0, 16);

    if(var_9 != "") {
      level._id_0E50[var_3] = var_9;
    }

    var_10 = tablelookupbyrow("mp/accessorytable.csv", var_0, 21);

    if(var_10 != "") {
      level._id_0E52[var_3] = var_10;
    }

    level._id_0E54[var_1] = var_2;
    level._id_0E4C[var_1] = var_4;

    if(var_9 != "") {
      if(isDefined(var_4) && var_4 != "") {
        level._id_0E53[var_1] = var_3 + "+" + var_9 + "+" + var_4;
        level._id_0E58[var_5] = var_3 + "+" + var_9 + "+" + var_4;
      } else {
        level._id_0E53[var_1] = var_3 + "+" + var_9;
        level._id_0E58[var_5] = var_3 + "+" + var_9;
      }
    } else if(isDefined(var_4) && var_4 != "") {
      level._id_0E53[var_1] = var_3 + "+" + var_4;
      level._id_0E58[var_5] = var_3 + "+" + var_4;
    } else {
      level._id_0E53[var_1] = var_3;
      level._id_0E58[var_5] = var_3;
    }

    var_0++;
  }

  thread _id_0798::init();
}

_id_6879(var_0) {
  return level._id_0E56[var_0];
}

_id_6877(var_0) {
  return level._id_0E54[var_0];
}

_id_687B(var_0) {
  return level._id_0E53[var_0];
}

_id_687C(var_0) {
  if(isDefined(level._id_0E58[var_0])) {
    return level._id_0E58[var_0];
  }

  return "none";
}

_id_6878(var_0) {
  if(isDefined(level._id_0E55[var_0])) {
    return level._id_0E55[var_0];
  }

  return "none";
}

_id_687A(var_0) {
  if(isDefined(level._id_0E57[var_0])) {
    return level._id_0E57[var_0];
  }

  return "none";
}

_id_6FC8(var_0, var_1, var_2, var_3) {
  _id_396B();
  var_4 = _id_6BD6(var_1, var_3);

  if(!isDefined(var_4)) {
    return;
  }
  self._id_0E4F = var_0;
  self._id_0E53 = var_1;
  var_5 = _id_DB8C(var_3);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_0E53);
  self _meth_8664(self._id_0E4F, self._id_0E53, var_5);

  if(isDefined(var_2)) {
    switch (var_2) {
      case "pet":
        _id_0798::_id_8258(0);
        break;
      case "heartbeat":
        break;
      case "thermometer":
        _id_82AC();
        break;
      default:
        break;
    }
  }
}

_id_396B() {
  self clearaccessory();

  if(isDefined(self._id_0E53) && self._id_0E53 != "none") {
    if(self hasweapon(self._id_0E53)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_0E53);
    }

    self._id_62F1 = "none";
  }
}

_id_82AC() {
  if(!isDefined(self._id_F106)) {
    self._id_F106 = 1;
    var_0 = _id_6B2B();
    self setclientomnvar("ui_pet_watch_state", var_0);
  }
}

_id_6B2B() {
  switch (level.mapname) {
    case "cp_donetsk":
      return 74;
    case "mp_aniyah":
      return 81;
    case "mp_cave":
      return 80;
    case "mp_cave_am":
      return 40;
    case "mp_deadzone":
      return 36;
    case "mp_euphrates":
      return 95;
    case "mp_hackney_yard":
      return 49;
    case "mp_hackney_am":
      return 30;
    case "mp_petrograd":
      return 35;
    case "mp_piccadilly":
      return 55;
    case "mp_raid":
      return 65;
    case "mp_runner":
      return 50;
    case "mp_runner_pm":
      return 42;
    case "mp_spear":
      return 92;
    case "mp_spear_pm":
      return 82;
    case "mp_shipment":
      return 100;
    case "mp_m_exclusion":
      return 80;
    case "mp_m_hill":
      return 54;
    case "mp_m_hook":
      return 64;
    case "mp_m_king":
      return 68;
    case "mp_m_king_pm":
      return 68;
    case "mp_m_overunder":
      return 72;
    case "mp_m_pine":
      return 88;
    case "mp_rust":
      return 90;
    case "mp_m_speed":
      return 72;
    case "mp_m_speedball":
      return 79;
    case "mp_m_stack":
      return 65;
    case "mp_m_showers":
      return 38;
    case "mp_m_cargo":
      return 68;
    case "mp_m_cage":
      return 96;
    case "mp_quarry2":
      return 57;
    case "mp_downtown_gw":
      return 60;
    case "mp_farms2_gw":
      return 78;
    case "mp_m_overwinter":
      return 12;
    case "mp_port_gw":
      return 79;
    case "mp_vacant":
      return 80;
    case "mp_tenement":
      return 55;
    case "mp_aniyah_tac":
      return 81;
    default:
      return 68;
  }
}

_id_6BD6(var_0, var_1) {
  var_2 = _func_0222("mp/cac/bodies.csv", 1, var_1, 23);

  if(isDefined(var_2)) {
    switch (var_2) {
      case "fem":
        var_3 = level._id_0E51[var_0];
        var_4 = level._id_0E4D[var_0];

        if(isDefined(var_3)) {
          var_0 = var_0 + var_3;

          if(isDefined(var_4)) {
            var_0 = var_0 + var_4;
          }
        }

        break;
      case "big":
        var_5 = level._id_0E4E[var_0];

        if(isDefined(var_5)) {
          var_0 = var_0 + var_5;
        }

        break;
      case "hide":
        var_0 = undefined;
        break;
    }
  }

  if(isDefined(var_0)) {
    var_6 = level._id_0E4C[var_0];

    if(isDefined(var_6)) {
      var_0 = var_0 + var_6;
    }
  }

  return var_0;
}

_id_DB8C(var_0) {
  var_1 = _func_0222("mp/cac/bodies.csv", 1, var_0, 22);
  return isDefined(var_1) && var_1 == "1";
}