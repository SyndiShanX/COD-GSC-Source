/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armory_kiosk.gsc
****************************************************/

init() {
  level._id_2A10 = spawnStruct();
  level._id_2A10._id_CF26 = [];
  level._id_2A11 = getdvarint("#x3346de31ab64fcd04", 1) != 0;

  if(scripts\mp\gametypes\br_gametypes::_id_8853("kiosk")) {
    level._id_2A11 = 0;
    return;
  }

  if(level._id_2A11) {
    _id_07A1::_id_CECC("br_plunder_box", ::_id_1B86);
    _id_0A9A::_id_C287(::_id_AA71);
    _id_0C34();
    _id_0C8C();
    level thread _id_0DCD();
  }
}

_id_0C31() {
  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    setDvar("#x3a2f593f7009235f7", "2,5");
  } else {
    setDvar("#x3a2f593f7009235f7", "3,4,5");
  }
}

_id_0C34() {
  var_0 = getdvarint("#x342c64740fa4fac63", 0);
  level._id_2A10._id_CB09 = int(clamp(var_0, 0, 100));
  var_1 = getDvar("#x39807c8c200b06e68", "");
  level._id_2A10._id_CB0A = strtok(var_1, ",");
  var_2 = 20;
  var_3 = level._id_2A10._id_CB09 % var_2;

  if(var_3 > 0) {
    var_4 = int(floor(level._id_2A10._id_CB09 / var_2) * var_2);
    var_5 = var_3 / var_2 >= 0.5;

    if(var_5) {
      var_4 = var_4 + var_2;
    }

    level._id_2A10._id_CB09 = int(var_4);
  }

  if(var_0 != level._id_2A10._id_CB09) {
    setDvar("#x342c64740fa4fac63", level._id_2A10._id_CB09);
  }
}

_id_0B3C(var_0, var_1) {
  if(var_1 == 0) {
    return var_0;
  }

  var_2 = (100 - var_1) * 0.01;
  return int(floor(var_0 * var_2 + 0.5));
}

_id_0C8C() {
  var_0 = "mp/brKioskPurchases.csv";

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    var_0 = "mp/brKioskPurchases_DMZ.csv";
  }

  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 9;
  var_6 = 10;
  level._id_2A10._id_8B38 = [];
  var_7 = tablelookupgetnumrows(var_0);

  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_9 = int(tablelookupbyrow(var_0, var_8, var_1));
    var_10 = spawnStruct();
    var_10.type = tablelookupbyrow(var_0, var_8, var_2);
    var_10._id_C189 = tablelookupbyrow(var_0, var_8, var_3);
    var_10._id_3D91 = int(tablelookupbyrow(var_0, var_8, var_4));
    var_10._id_5B8B = int(tablelookupbyrow(var_0, var_8, var_5));
    var_10._id_AFCA = int(tablelookupbyrow(var_0, var_8, var_6));

    if(var_10._id_C189 == "supply_drop") {
      var_11 = getdvarint("#x31a07f445aff1cc16", 0);

      if(var_11 != 0) {
        var_10._id_3D91 = var_11;
      }
    }

    if(level._id_2A10._id_CB09 > 0) {
      var_12 = level._id_2A10._id_CB0A.size == 0 || scripts\engine\utility::array_contains(level._id_2A10._id_CB0A, var_10._id_C189);

      if(var_12) {
        var_10._id_3D91 = _id_0B3C(var_10._id_3D91, level._id_2A10._id_CB09);
      }
    }

    if(var_10.type == "loadout_default") {
      level._id_2A10._id_9666 = var_10._id_3D91;
      level._id_2A10._id_9667 = var_10._id_5B8B;
      level._id_2A10._id_9668 = var_10._id_AFCA;
      continue;
    }

    if(var_10.type == "loadout_custom") {
      level._id_2A10._id_9663 = var_10._id_3D91;
      level._id_2A10._id_9664 = var_10._id_5B8B;
      level._id_2A10._id_9665 = var_10._id_AFCA;
      continue;
    }

    if(var_10.type == "teamrevive") {
      level._id_2A10._id_EF9D = var_10._id_3D91;
      level._id_2A10._id_EF9E = var_10._id_5B8B;
      level._id_2A10._id_EF9F = var_10._id_AFCA;
      continue;
    }

    level._id_2A10._id_8B38[var_9] = var_10;
  }
}

_id_0BFC(var_0, var_1, var_2, var_3, var_4) {
  if(var_1) {
    return _id_0B3C(var_0, var_2);
  } else if(var_3) {
    return _id_0B3C(var_0, var_4);
  }

  return var_0;
}

_id_0DCD() {
  level endon("game_ended");
  setdvarifuninitialized("#x39fba3d76cf38d0c7", 0);

  for(;;) {
    level waittill("br_circle_set");
    var_0 = getdvarint("#x39fba3d76cf38d0c7", 0);

    if(var_0 == 0) {
      continue;
    }
    if(level._id_2A1B._id_372F + 1 >= var_0) {
      _id_4A7A();

      foreach(var_2 in level.players) {
        if(!isDefined(var_2) || !isalive(var_2)) {
          continue;
        }
        var_2 thread scripts\mp\hud_message::showsplash("br_kiosks_disabled");
      }

      break;
    }
  }
}

_id_DC99(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  level endon("game_ended");

  if(istrue(var_1._id_75AD)) {
    return;
  }
  if(!isDefined(level._id_2A10._id_CB09)) {
    return;
  }
  if(level._id_2A10._id_CB09 == 0) {
    return;
  }
  var_1._id_75AD = 1;

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  if(level._id_2A10._id_CB0A.size == 0) {
    var_1 thread scripts\mp\hud_message::showsplash("br_sales_event_all");
  } else {
    var_1 thread scripts\mp\hud_message::showsplash("br_sales_event_selective");
  }
}

_id_AB80() {
  foreach(var_1 in level._id_2A10._id_CF26) {
    var_1 setscriptablepartstate("br_plunder_box", "visible");
    var_1._id_10417 = 1;
  }
}

_id_433F(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level._id_2A10._id_CF26) {
    if(isDefined(var_4._id_10417) && distance2dsquared(var_4.origin, var_0) > var_2) {
      _id_4A7E(var_4);
    }
  }
}

_id_4A7A() {
  foreach(var_1 in level._id_2A10._id_CF26) {
    if(isDefined(var_1._id_10417)) {
      _id_4A7E(var_1);
    }
  }
}

_id_4A7E(var_0) {
  var_0 setscriptablepartstate("br_plunder_box", "disabled");
  var_0._id_10417 = undefined;
  var_0._id_4A88 = 1;

  if(var_0 scripts\mp\gametypes\br_quest_util::_id_34FF()) {
    var_0 scripts\mp\gametypes\br_quest_util::_id_4789();
  }
}

_id_68AD() {
  if(!level._id_2A11) {
    return;
  }
  var_0 = _func_03C0("scriptable_br_plunder_box", "classname");
  return var_0;
}

_id_D6D7(var_0) {
  level._id_2A10._id_CF26 = var_0;
}

_id_1B86(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.gameended)) {
    return;
  }
  if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_3.inlaststand)) {
    return;
  }
  if(var_3 scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    return;
  }
  if(var_3 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return;
  }
  if(var_2 == "visible") {
    var_0 setscriptablepartstate("br_plunder_box", "opening");
    var_0 thread _id_8DFF();
    var_3 thread _id_0CCB(var_0);
  } else if(var_2 == "opening" || var_2 == "open")
    var_3 thread _id_0CCB(var_0);
}

_id_8DFF() {
  if(!getdvarint("#x33672ef5d70247c21", 1)) {
    return;
  }
  var_0 = getdvarfloat("#x3f9c481fe376bbaf8", 300);
  var_1 = _func_040F(level.players, self.origin, var_0);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !isalive(var_3)) {
      continue;
    }
    if(var_3 getstance() != "prone") {
      continue;
    }
    var_4 = var_3 _meth_86AD();
    var_0 = var_4[0];
    var_5 = 2.0 * var_4[2];

    if(_func_0036(var_3.origin, var_0, var_5, undefined, 0, 0)) {
      continue;
    }
    var_3 setstance("crouch", 1);
  }
}

_id_8E04(var_0, var_1) {
  if(!isDefined(var_0._id_5B8C)) {
    var_0._id_5B8C = [var_1];
  } else if(!scripts\engine\utility::array_contains(var_0._id_5B8C, var_1)) {
    var_0._id_5B8C = scripts\engine\utility::array_add(var_0._id_5B8C, var_1);
  }

  if(!var_0 scripts\mp\gametypes\br_quest_util::_id_34FF()) {
    var_0 scripts\mp\gametypes\br_quest_util::_id_403A("ui_mp_br_mapmenu_icon_poi_plunder_box_firesale", "active", var_0.origin);
  }

  var_0 scripts\mp\gametypes\br_quest_util::_id_DCDC(var_1);
}

_id_88F8(var_0, var_1) {
  if(!isDefined(var_0._id_5B8C)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(var_0._id_5B8C, var_1);
}

_id_8DFE(var_0, var_1) {
  if(!isDefined(var_0._id_5B8C)) {
    return;
  }
  var_0 scripts\mp\gametypes\br_quest_util::_id_7914(var_1);
  var_0._id_5B8C = scripts\engine\utility::array_remove(var_0._id_5B8C, var_1);
}

_id_6AEF() {
  return 180.0 + randomfloatrange(-10.0, 10.0);
}

_id_0CCB(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("death");
  var_1._id_2A6B = var_0;

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    var_1 notify("kiosk_used");
  }

  var_2 = _id_88F8(var_0, var_1);
  var_3 = var_1 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
  var_1 setclientomnvar("ui_br_purchase_killstreak_response", 0);

  if(var_2) {
    var_1 setclientomnvar("ui_br_open_purchase_killstreak", 2);
  } else if(var_3) {
    var_1 setclientomnvar("ui_br_open_purchase_killstreak", 3);
  } else {
    var_1 setclientomnvar("ui_br_open_purchase_killstreak", 1);
  }

  var_1._id_1B85 = 1;
  scripts\mp\gametypes\br_analytics::_id_2AF8(var_1, "menu_open");
  var_1 thread _id_0DD6(var_0);
  var_1 _meth_867F("iw8_br_plunder_kiosk_menu");
}

_id_0BA1(var_0) {
  var_1 = self;
  var_1 setclientomnvar("ui_br_purchase_killstreak_response", var_0);
  var_1 setclientomnvar("ui_br_open_purchase_killstreak", 0);
  var_1 _meth_8680("iw8_br_plunder_kiosk_menu");
  var_1._id_2A6B = undefined;
  var_1._id_1B85 = undefined;
  scripts\mp\gametypes\br_analytics::_id_2AF8(var_1, "menu_close", "reason: " + var_0);
}

_id_0CA4(var_0) {
  var_0 _id_0BA1(0);
  var_0 notify("_watchToAutoCloseMenu_end");
}

_id_0DD6(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 notify("_watchToAutoCloseMenu_end");
  var_1 endon("_watchToAutoCloseMenu_end");
  var_1 childthread _id_0CA3(var_0);
  scripts\engine\utility::_id_10888(var_1, "death", var_1, "last_stand_start", var_1, "pushed_too_far", level, "game_ended");
  var_1 _id_0BA1(2);
}

_id_0CA3(var_0) {
  var_1 = self;
  var_2 = 64;
  var_3 = getdvarfloat("#x3606767d938d99dae", 128) + var_2;
  var_4 = var_3 * var_3;

  for(;;) {
    wait 0.1;
    var_5 = distancesquared(var_1.origin, var_0.origin);

    if(var_5 > var_4) {
      var_1 notify("pushed_too_far");
      break;
    }
  }
}

_id_0BFF(var_0) {
  var_1 = self;

  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = var_1 scripts\mp\equipment::_id_6A0F(var_0);
  var_3 = var_1 scripts\mp\equipment::_id_6A12(var_0);
  return max(0, var_3 - var_2);
}

_id_0C60(var_0) {
  var_1 = self;

  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = var_1 scripts\mp\equipment::_id_6A0F(var_0);
  var_3 = var_1 scripts\mp\equipment::_id_6A12(var_0);

  if(var_2 < var_3) {
    var_1 scripts\mp\equipment::_id_D543(var_0, var_3);
  }
}

_id_0BE1(var_0) {
  var_1 = self;
  var_2 = var_1 scripts\mp\equipment::_id_6A15("health");

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = var_1 scripts\mp\equipment::_id_6A12("equip_armorplate");

  if(getdvarint("#x395344732688f8bdc", 0)) {
    var_4 = 2;
  } else {
    var_4 = 5;
  }

  var_5 = int(clamp(var_4, 0, var_3 - var_2));
  var_6 = var_4 - var_5;

  if(var_6 > 0) {
    var_7 = undefined;

    if(istrue(var_0)) {
      var_7 = _id_6AEF();
    }

    [var_9, var_10, var_11] = ::scripts\mp\gametypes\br_pickups::_id_6ACD(0, var_1.origin, var_1.angles, var_1, var_7);
    scripts\mp\gametypes\br_pickups::_id_E336("brloot_armor_plate", var_9, var_10, var_6, 1, var_11);
  }

  return var_5;
}

_id_0DB7(var_0, var_1) {
  var_2 = self;
  var_3 = _id_88F8(var_2._id_2A6B, var_2);
  var_4 = var_2 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
  var_5 = _id_0BFC(var_0._id_3D91, var_3, var_0._id_5B8B, var_4, var_0._id_AFCA);

  if(var_2._id_B956 < var_5) {
    var_2 _id_0BA1(3);
    return 0;
  }

  if(var_0.type == "killstreak") {
    if(!istrue(var_1)) {
      if(var_2 scripts\mp\gametypes\br_pickups::_id_757A(var_0._id_C189)) {
        var_2 _id_0BA1(4);
        return 0;
      }
    }
  } else if(var_0.type == "fieldupgrade") {
    if(var_2 scripts\mp\supers::_id_8A79()) {
      var_2 _id_0BA1(6);
      return 0;
    }

    if(!istrue(var_1)) {
      var_6 = var_2 scripts\mp\supers::_id_69B0();

      if(isDefined(var_6) && var_0._id_C189 == var_6) {
        var_2 _id_0BA1(5);
        return 0;
      }
    }
  } else if(var_0.type == "special") {
    switch (var_0._id_C189) {
      case "armor_bundle":
      case "armor":
        break;
      case "gas_mask":
        var_7 = spawnStruct();
        var_7._id_CF22 = "brloot_equip_gasmask";
        var_8 = scripts\mp\gametypes\br_pickups::_id_31F1(var_7);
        break;
      case "ammo_refill":
        var_9 = 0;

        if(var_2 _id_0BFF(var_2.equipment["primary"]) > 0) {
          var_9 = 1;
        } else if(var_2 _id_0BFF(var_2.equipment["secondary"]) > 0) {
          var_9 = 1;
        } else if(!var_2 scripts\mp\gametypes\br_weapons::_id_2A03()) {
          var_9 = 1;
        }

        if(!var_9) {
          var_2 _id_0BA1(8);
          return 0;
        }

        break;
      case "respawn_token":
        if(scripts\mp\gametypes\br_pickups::_id_C6C7()) {
          var_2 _id_0BA1(9);
          return 0;
        }

        if(istrue(var_2._id_75A4)) {
          var_2 _id_0BA1(10);
          return 0;
        }

        break;
      case "self_revive_token":
        if(var_2 scripts\mp\gametypes\br_public::_id_75AF()) {
          var_2 _id_0BA1(10);
          return 0;
        }

        break;
      case "supply_drop":
        var_7 = spawnStruct();
        var_7._id_CF22 = "brloot_offhand_advancedsupplydrop";
        var_7._id_011A = 1;
        var_8 = scripts\mp\gametypes\br_pickups::_id_31F1(var_7);

        if(var_8 != 1) {
          var_2 _id_0BA1(7);
          return 0;
        }

        break;
    }
  }

  return 1;
}

_id_0C45(var_0) {
  switch (var_0) {
    case "toma_strike":
    case "precision_airstrike":
      return 1;
    case "uav":
      return 0;
    default:
      return 0;
  }
}

_id_0C54() {
  var_0 = self;
  scripts\engine\utility::_id_10888(var_0, "death", level, "game_ended");
  var_0 notify("cancel_location");
}

_id_0C1B(var_0, var_1) {
  var_2 = self;
  var_2 endon("disconnect");
  var_3 = getdvarint("#x3e8dfb3d2c5f51a3b", 0);

  if(!var_3) {
    var_2 scripts\mp\gametypes\br_pickups::_id_5EA6(var_0._id_C189, var_1, 1);
    var_2 _id_0C5A(var_0._id_3D91, var_0._id_5B8B, var_0._id_AFCA);
    var_2 thread scripts\mp\hud_message::showsplash("br_killstreak_purchased");
    var_2 _id_07BC::_id_AB1C("killstreak", var_0._id_C189);
    scripts\mp\gametypes\br_analytics::_id_2AF9(self, var_0._id_3D91, "killstreak", var_0._id_C189);
  } else {
    if(_id_0C45(var_0._id_C189)) {
      var_4 = var_2._id_2A6B;
      var_2 _id_0BA1(16);
      var_2 scripts\cp_mp\utility\player_utility::_freezecontrols(1);
      var_2 _meth_8026(0, 0, 0, 0, 4);
      var_2 childthread _id_0C54();
      var_5 = var_2 _id_0A54::_id_108BB("confirm_location", "cancel_location");
      var_2 _meth_80E7();
      var_2 scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);

      if(isDefined(var_5) && var_5._id_EA52 == "confirm_location") {
        var_6 = scripts\mp\gametypes\br::_id_F3D1(var_5._id_96CF);
        var_2._id_8E53 = var_6["position"];
        var_7 = var_2 scripts\mp\gametypes\br_pickups::_id_5ED4(var_0._id_C189);

        if(istrue(var_7)) {
          var_2 _id_0C5A(var_0._id_3D91, var_0._id_5B8B, var_0._id_AFCA);
          var_2 thread scripts\mp\hud_message::showsplash("br_killstreak_purchased_and_activated");
          _id_07BC::_id_AB1C("killstreak", var_0._id_C189);
          scripts\mp\gametypes\br_analytics::_id_2AF9(self, var_0._id_3D91, "killstreak", var_0._id_C189);
          return;
        }

        return;
      }

      var_2 thread _id_0CCB(var_4);
      return;
      return;
    }

    var_2 scripts\mp\gametypes\br_pickups::_id_5EA6(var_0._id_C189, var_1, 1);
    var_7 = var_2 scripts\mp\gametypes\br_pickups::_id_5ED4(var_0._id_C189);

    if(istrue(var_7)) {
      var_2 _id_0C5A(var_0._id_3D91, var_0._id_5B8B, var_0._id_AFCA);
      var_2 thread scripts\mp\hud_message::showsplash("br_killstreak_purchased_and_activated");
      _id_07BC::_id_AB1C("killstreak", var_0._id_C189);
      scripts\mp\gametypes\br_analytics::_id_2AF9(self, var_0._id_3D91, "killstreak", var_0._id_C189);
    }
  }
}

_id_0C1C(var_0, var_1) {
  var_2 = self;
  var_3 = 1;
  var_4 = 1;
  var_5 = undefined;

  switch (var_0._id_C189) {
    case "armor":
      var_3 = scripts\mp\gametypes\br_pickups::_id_2A46(var_2, "brloot_armor_plate", 1, undefined, 1);
      break;
    case "armor_bundle":
      var_6 = var_2 _id_0BE1(1);

      if(var_6 <= 0) {
        var_3 = 1;
      } else {
        var_3 = scripts\mp\gametypes\br_pickups::_id_2A46(var_2, "brloot_armor_plate", 1, var_6, 1);
      }

      break;
    case "gas_mask":
      var_3 = scripts\mp\gametypes\br_pickups::_id_2A46(var_2, "brloot_equip_gasmask", 1, undefined, 1);
      break;
    case "ammo_refill":
      var_2 scripts\mp\gametypes\br_weapons::_id_2A04();
      var_2 _id_0C60(var_2.equipment["primary"]);
      var_2 _id_0C60(var_2.equipment["secondary"]);
      break;
    case "respawn_token":
      var_2 scripts\mp\gametypes\br_pickups::_id_1122();
      var_4 = 0;
      break;
    case "self_revive_token":
      var_2 scripts\mp\gametypes\br_pickups::_id_1129();
      var_4 = 0;
      break;
    case "supply_drop":
      var_3 = scripts\mp\gametypes\br_pickups::_id_2A46(var_2, "brloot_offhand_advancedsupplydrop", 1, undefined, 1);
      break;
    default:
      break;
  }

  if(var_3) {
    var_2 _id_0C5A(var_0._id_3D91, var_0._id_5B8B, var_0._id_AFCA);

    if(var_4) {
      var_2 thread scripts\mp\hud_message::showsplash("br_item_purchased");
    }

    _id_07BC::_id_AB1C("special", var_0._id_C189);
    scripts\mp\gametypes\br_analytics::_id_2AF9(self, var_0._id_3D91, "special", var_0._id_C189);
  }
}

_id_0C1D(var_0, var_1) {
  var_2 = (1, 1, 1);
  var_3 = (1, 0, 0);
  var_4 = (0, 1, 0);
  var_5 = (0, 1, 1);
  var_6 = 3;
  var_7 = 8;
  var_8 = self._id_2A6B.origin;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_31E1()) {
    return 0;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
    return 0;
  }

  var_9 = physics_createcontents(["physicscontents_water", "physicscontents_item", "physicscontents_vehicleclip"]);
  var_10 = 300;
  var_11 = 90;
  var_12 = 300;
  var_13 = 150;
  var_14 = var_13 + var_10;
  var_15 = 0;
  var_16 = undefined;
  var_17 = undefined;

  for(var_18 = undefined; var_15 < 360; var_15 = var_15 + var_11) {
    var_19 = var_8 + (sin(var_15) * var_10, cos(var_15) * var_10, 0);
    var_16 = (var_19[0], var_19[1], var_19[2] + var_14);
    var_17 = (var_19[0], var_19[1], var_19[2] - var_14);
    var_20 = _func_02C2(var_16, var_17, var_12, var_9, undefined, "physicsquery_closest");

    if(var_20.size > 0) {
      var_21 = var_20[0]["position"];
      var_17 = (var_16[0], var_16[1], var_20[0]["shape_position"][2] - var_10);

      if(!isDefined(var_20[0]["entity"]) && abs(var_17[2] - var_19[2]) < var_13) {
        if(!isDefined(var_18)) {
          var_18 = var_17 + (0, 0, var_10);

          if(!getdvarint("#x3440550cd7e940b44", 0) > 0) {
            break;
          }
        }
      } else {}

      continue;
    }
  }

  if(!isDefined(var_18)) {
    return 0;
  }

  var_22 = 150;
  var_23 = spawnStruct();
  var_23.origin = var_18 + (0, 0, var_22);
  var_23.angles = (0, randomintrange(0, 360), 0);
  var_23.owner = self;
  var_23.spawntype = "GAME_MODE";
  var_24 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle(var_0._id_C189, var_23);

  if(!isDefined(var_24)) {
    return 0;
  }

  var_25 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10195(var_24);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(var_24, var_25, self);
  scripts\cp_mp\vehicles\vehicle_spawn::_id_10288(var_24);
  return 1;
}

_id_AA71(var_0, var_1) {
  var_2 = self;
  var_3 = var_2._id_2A6B;

  if(!istrue(var_2._id_1B85)) {
    return;
  }
  var_4 = "channel: " + var_0;

  if(isDefined(var_1)) {
    var_4 = var_4 + ", index: " + var_1;
  }

  scripts\mp\gametypes\br_analytics::_id_2AF8(var_2, "menu_purchase", var_4);
  var_5 = getdvarint("#x3299e98609e3b1231", 1);

  if(var_0 == "br_cancel_purchase") {
    _id_0CA4(var_2);
  } else if(var_0 == "br_item_purchase") {
    var_6 = var_1;
    var_7 = level._id_2A10._id_8B38[var_6];
    var_8 = var_2 _id_0DB7(var_7, var_5);

    if(var_8) {
      if(var_7.type == "killstreak") {
        var_2 thread _id_0C1B(var_7, var_5);
      } else if(var_7.type == "fieldupgrade") {
        var_2 scripts\mp\gametypes\br_pickups::_id_5EA7(var_7._id_C189, var_5, 1);
        var_2 _id_0C5A(var_7._id_3D91, var_7._id_5B8B, var_7._id_AFCA);
        var_2 thread scripts\mp\hud_message::showsplash("br_field_upgrade_purchased");
        _id_07BC::_id_AB1C("fieldUpgrade", var_7._id_C189);
        scripts\mp\gametypes\br_analytics::_id_2AF9(self, var_7._id_3D91, "fieldUpgrade", var_7._id_C189);

        if(level._id_15D8) {
          var_2 scripts\mp\supers::_id_6FF9(var_2 scripts\mp\supers::_id_6DA3());
        }
      } else if(var_7.type == "special")
        var_2 _id_0C1C(var_7, var_5);
      else if(var_7.type == "vehicle") {
        var_9 = var_2 _id_0C1D(var_7, var_5);

        if(var_9) {
          var_2 _id_0C5A(var_7._id_3D91, var_7._id_5B8B, var_7._id_AFCA);
          var_2 thread scripts\mp\hud_message::showsplash("br_vehicle_purchased");
          scripts\mp\gametypes\br_analytics::_id_2AF9(self, var_7._id_3D91, "vehicle", var_7._id_C189);
        } else
          var_2 scripts\mp\hud_message::_id_DCA2("MP/VEHICLE_PURCHASE_FAILED");
      }
    }
  } else if(var_0 == "br_loadout_purchase") {
    var_10 = _id_88F8(var_2._id_2A6B, var_2);
    var_11 = var_2 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
    var_12 = 0;
    var_13 = var_1;
    var_14 = level._id_2A10._id_9663;
    var_15 = level._id_2A10._id_9664;
    var_16 = level._id_2A10._id_9665;

    if(_id_07F2::_id_8910(var_13)) {
      var_14 = level._id_2A10._id_9666;
      var_15 = level._id_2A10._id_9667;
      var_16 = level._id_2A10._id_9668;
      var_12 = 1;
    }

    var_17 = _id_0BFC(var_14, var_10, var_15, var_11, var_16);

    if(var_2._id_B956 < var_17) {
      var_2 _id_0BA1(3);
      return;
    }

    var_18 = _id_07F2::_id_6960(var_13);
    scripts\mp\gametypes\br_analytics::_id_2AF7(self, "purchasing_new_loadout");
    var_2.pers["class"] = var_18;
    var_2.class = var_18;
    var_19 = var_2 scripts\mp\class::_id_BB98(var_18);
    scripts\mp\gametypes\br::_id_2A4F(var_2, var_5);
    var_2 _id_0C5A(var_14, var_15, var_16);
    var_2 thread scripts\mp\hud_message::showsplash("br_loadout_purchased");

    if(istrue(var_12)) {
      scripts\mp\gametypes\br_analytics::_id_2AF9(self, var_17, "defaultLoadout", "loadout_" + var_13);
    } else {
      scripts\mp\gametypes\br_analytics::_id_2AFA(self, var_17, var_19);
    }
  } else if(var_0 == "br_team_revive") {
    var_20 = var_1;
    var_10 = _id_88F8(var_2._id_2A6B, var_2);
    var_15 = level._id_2A10._id_EF9E;
    var_11 = var_2 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");
    var_16 = level._id_2A10._id_EF9F;
    var_21 = istrue(var_2._id_75A4);
    var_22 = _id_0BFC(level._id_2A10._id_EF9D, var_10, var_15, var_11, var_16);

    if(!var_21 && var_2._id_B956 < var_22) {
      var_2 _id_0BA1(3);
      return 0;
    }

    var_23 = undefined;
    var_24 = scripts\mp\utility\teams::_id_6DCA(var_2.team, "players");

    foreach(var_26 in var_24) {
      if(!isDefined(var_26) || var_26 == var_2) {
        continue;
      }
      if(isDefined(var_26._id_2ABC) && var_26._id_2ABC == var_20) {
        var_23 = var_26;
        break;
      }
    }

    if(!isDefined(var_23)) {
      var_2 _id_0BA1(12);
      return;
    }

    if(!var_23 scripts\mp\gametypes\br_public::_id_8818() && !getdvarint("#x32aa91d1834bc79f8", 0)) {
      if(scripts\mp\gametypes\br_public::_id_8A02(var_23)) {
        var_2 _id_0BA1(14);
      } else if(isalive(var_23)) {
        var_2 _id_0BA1(15);
      } else {
        var_2 _id_0BA1(13);
      }

      return;
    }

    if(!var_21) {
      var_28 = level._id_2A10._id_EF9D;
      var_15 = level._id_2A10._id_EF9E;
      var_16 = level._id_2A10._id_EF9F;
      var_2 _id_0C5A(var_28, var_15, var_16);
      var_2 scripts\mp\gametypes\br_pickups::_id_1122(1);
      var_2 _id_07BC::_id_AB1C("teamrevive", "teamrevive");
      scripts\mp\gametypes\br_analytics::_id_2AF9(var_2, var_22, "teamrevive_money", "teamrevive");
    } else {
      var_2 _id_0C5A(0, 0, 0);
      var_2 _id_07BC::_id_AB1C("teamrevive", "teamrevive");
      scripts\mp\gametypes\br_analytics::_id_2AF9(var_2, 0, "teamrevive_token", "teamrevive");
    }

    var_23 thread scripts\mp\gametypes\br_gulag::_id_B6C6(var_2, var_21);
    level thread scripts\mp\gametypes\br_quest_util::_id_FF21(var_3.origin, "revive");
    var_2 thread scripts\mp\hud_message::showsplash("br_squadmate_revived");
  }
}

_id_0C5A(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = _id_88F8(var_3._id_2A6B, var_3);
  var_5 = var_3 scripts\mp\utility\perk::_hasperk("specialty_br_cheaper_kiosk");

  if(var_4 && var_1 > 0) {
    _id_8DFE(var_3._id_2A6B, var_3);
  }

  if(!scripts\mp\gametypes\br_public::_id_8758()) {
    var_3 thread _id_0A9F::_id_7003("br_kioskBuy", undefined, scripts\mp\gametypes\br::_id_2EF4(var_0));
  }

  var_0 = _id_0BFC(var_0, var_4, var_1, var_5, var_2);

  if(var_0 > 0) {
    var_3 scripts\mp\gametypes\br_plunder::_id_B750(var_0);
  }

  level._id_2A9B._id_8DFC = level._id_2A9B._id_8DFC + var_0;
  level._id_2A9B._id_8DFB++;
  var_3 _id_0BA1(1);
}