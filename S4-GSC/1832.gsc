/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1832.gsc
*************************************************/

_id_7F75() {
  level.equipment = spawnStruct();
  _id_7FC4();
  _id_96AB();

  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    setup_equipment_scaling_weapons_from_table();
  } else {
    setup_rbz_equipment_scaling_weapons_from_table();
  }

  _id_0961::_id_C28D(::_id_0BDF);
  level notify("equipment_initialized");
}

_id_7FC4() {
  level.equipment._id_2F52 = [];
  level.aether_grenade_disabled_weapons = ["s4_crystal_shard_zm", "s4_electric_heart_zm"];
  _id_091D::_id_A159();
  _id_094C::_id_A06C();
  _id_0918::init();
  _id_091A::_id_4539();
  _id_0920::init();
  _id_0923::throwing_knife_init_cp();
  scripts\cp\equipment\zm_crystal_shard::electric_heart_init();
  _id_0958::_id_C285(::_id_0C84);
}

_id_96AB() {
  level.equipment._id_EC5C = [];
  var_0 = 0;
  var_1 = tablelookupgetnumrows("cp/equipment.csv");

  for(var_0 = 0; var_0 < var_1; var_0++) {
    var_2 = tablelookupbyrow("cp/equipment.csv", var_0, 1);

    if(!isDefined(var_2) || var_2 == "") {
      continue;
    }
    var_2 = tolower(var_2);

    if(var_2 == "none" || var_2 == "equip_self_revive") {
      continue;
    }
    var_3 = spawnStruct();
    var_3._id_C189 = var_2;
    var_4 = tablelookupbyrow("cp/equipment.csv", var_0, 6);
    var_5 = var_4 != "none";

    if(var_5) {
      var_3.objweapon = makeweapon(var_4);
    }

    var_3._id_7C8C = var_0;
    var_3._id_7D40 = tablelookupbyrow("cp/equipment.csv", var_0, 4);
    var_3._id_45C7 = _id_6D2E(int(tablelookupbyrow("cp/equipment.csv", var_0, 7)));
    var_3._id_8973 = tablelookupbyrow("cp/equipment.csv", var_0, 11) == "true";
    var_3._id_8A20 = tablelookupbyrow("cp/equipment.csv", var_0, 8) != "-1";
    var_3._id_8B15 = tablelookupbyrow("cp/equipment.csv", var_0, 18) == "1";
    var_3.isquestitem = tablelookupbyrow("cp/equipment.csv", var_0, 19) == "1";
    var_6 = tablelookupbyrow("cp/equipment.csv", var_0, 12);

    switch (var_6) {
      case "none":
        break;
      case "":
        if(var_5) {
          var_3._id_4336 = [var_4];
        }

        break;
      default:
        var_7 = [];

        if(var_5) {
          var_7[var_7.size] = var_4;
        }

        var_8 = strtok(var_6, " ");

        foreach(var_10 in var_8) {
          var_7[var_7.size] = var_10;
        }

        var_3._id_4336 = var_7;
    }

    var_3._id_5560 = tablelookupbyrow("cp/equipment.csv", var_0, 2);
    level.equipment._id_EC5C[var_2] = var_3;
    level.equipment._id_2F52[var_2] = [];
  }
}

_id_6CB4(var_0) {
  if(!isDefined(var_0)) {
    return "undefined";
  }

  return "\"" + var_0 + "\"";
}

_id_6A17(var_0) {
  return level.equipment._id_EC5C[var_0];
}

_id_6D2E(var_0) {
  switch (var_0) {
    case 1:
      return "primary";
    case 2:
      return "secondary";
  }

  return "";
}

_id_69D6(var_0) {
  var_1 = _id_6A17(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1._id_45C7;
}

giveequipment(var_0) {
  var_1 = self;
  var_2 = scripts\cp\utility::_id_459B(var_0._id_DDEF, _id_69D6(var_0._id_5556));
  var_3 = var_1 _id_69A4(var_2);
  var_4 = 0;
  var_5 = 0;
  var_6 = scripts\cp\utility::_id_459B(var_0._id_C558, var_1.origin);

  if(isDefined(var_3)) {
    var_4 = var_1 _id_6A0F(var_3);

    if(var_3 == var_0._id_5556) {
      var_5 = 1;
    } else if(var_4 > 0) {
      var_7 = _id_0930::_id_5B05(var_3);
      var_8 = getequipmentmotherlodetracking(var_3);
      _id_0930::_id_E35C(var_7, var_6, var_1.origin, var_4, var_8);
    }
  }

  var_9 = 1;

  if(isDefined(var_0._id_BE99)) {
    var_9 = var_0._id_BE99;
  }

  var_10 = scripts\cp\utility::_id_459B(var_0.motherlode_quantity, 0);

  if(istrue(var_5)) {
    var_11 = var_1 _id_6A12(var_3);
    var_12 = var_11 - var_4;
    var_13 = var_9 - var_12;

    if(var_13 > 0) {
      var_7 = scripts\cp\utility::_id_459B(var_0._id_C559, _id_0930::_id_5B05(var_3));
      var_14 = int(min(var_10, var_13));
      _id_0930::_id_E35C(var_7, var_6, var_1.origin, var_13, var_14);
      var_10 = var_10 - var_14;
    }

    var_1 incrementequipmentammo(var_3, var_9);
    var_1 incrementequipmentmotherlodetracking(var_3, var_10);
  } else {
    var_1 _id_6F94(var_0._id_5556, var_2);
    var_1 _id_D543(var_0._id_5556, var_9);
    var_1 setequipmentmotherlodetracking(var_0._id_5556, var_10);
  }
}

_id_6F94(var_0, var_1) {
  if(!isDefined(self.equipment)) {
    self.equipment = [];
  }

  if(var_0 == "none") {
    return;
  }
  var_2 = _id_6A17(var_0);
  _id_EDBD(var_1);

  if(isDefined(var_2.objweapon)) {
    self giveweapon(var_2.objweapon);

    if(_id_883A(var_1) && !var_2._id_8973) {
      switch (var_1) {
        case "primary":
          self _meth_849C(var_2.objweapon);
          break;
        case "secondary":
          self _meth_849D(var_2.objweapon);
          break;
        case "super":
          self _meth_84E9(var_2.objweapon);
          self._id_E3D1 = var_2.objweapon;
          break;
      }
    }

    _id_D5AA(var_1, var_2._id_7C8C);
    self.equipment[var_1] = var_0;
    var_3 = _id_6942(var_0, "onGive");

    if(isDefined(var_3)) {
      self thread[[var_3]](var_0, var_1);
    }

    _id_0DB0(var_1);
  }
}

_id_EDBD(var_0) {
  var_1 = _id_69A4(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _id_6A17(var_1);

  if(isDefined(var_2.objweapon)) {
    if(self hasweapon(var_2.objweapon)) {
      self takeweapon(var_2.objweapon);

      if(var_0 == "primary") {
        self _meth_849E();
      } else if(var_0 == "secondary") {
        self _meth_849F();
      }
    }
  }

  _id_D5AA(var_0, 0);
  clearmotherlodetracking(var_1);
  self.equipment[var_0] = undefined;
  var_3 = _id_6942(var_1, "onTake");

  if(isDefined(var_3)) {
    self thread[[var_3]](var_1, var_0);
  }

  _id_0DB0(var_0);
  self notify("equipment_taken_" + var_1);
}

_id_393C() {
  if(!isDefined(self.equipment)) {
    return;
  }
  var_0 = self.equipment;

  foreach(var_3, var_2 in var_0) {
    _id_EDBD(var_3);
  }
}

_id_C70B() {
  waitframe();

  if(_id_883A("primary")) {
    _id_526C("primary");
  } else {
    _id_4AE5("primary");
  }

  if(_id_883A("secondary")) {
    _id_526C("secondary");
  } else {
    _id_4AE5("secondary");
  }
}

_id_883A(var_0) {
  return scripts\common\input_allow::_id_860C("equipment_" + var_0);
}

allow_equipment(var_0, var_1) {
  _id_153B("primary", var_0, var_1);
  _id_153B("secondary", var_0, var_1);
}

_id_153B(var_0, var_1, var_2) {
  var_3 = scripts\common\input_allow::allow_input_internal("equipment_" + var_0, var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  if(var_1) {
    _id_526C(var_0);
  } else {
    _id_4AE5(var_0);
  }
}

_id_4AE5(var_0) {
  if(var_0 == "primary") {
    self _meth_849E();
  } else if(var_0 == "secondary") {
    self _meth_849F();
  } else if(var_0 == "super") {
    self _meth_84EA();
  }
}

_id_526C(var_0) {
  if(!isDefined(self)) {
    return;
  }
  var_1 = _id_69A4(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _id_6A17(var_1);

  if(isDefined(var_2.objweapon) && !var_2._id_8973 && self hasweapon(var_2.objweapon)) {
    if(var_0 == "primary") {
      self _meth_849C(var_2.objweapon);
    } else if(var_0 == "secondary") {
      self _meth_849D(var_2.objweapon);
    } else if(var_0 == "super") {
      self _meth_84E9(var_2.objweapon);
    }
  }
}

_id_69A4(var_0) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  return self.equipment[var_0];
}

_id_6A15(var_0) {
  var_1 = _id_69A4(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  return _id_6A0F(var_1);
}

_id_D545(var_0, var_1) {
  var_2 = _id_69A4(var_0);

  if(!isDefined(var_2)) {
    return undefined;
  }

  return _id_D543(var_2, var_1);
}

incrementequipmentammo(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = _id_6A0F(var_0);
  var_3 = int(min(var_2 + var_1, _id_6A12(var_0)));
  waitframe();
  _id_D543(var_0, var_3);
}

_id_4558(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = _id_6A0F(var_0);
  var_1 = int(min(var_1, var_2));

  if(var_1 > 0) {
    var_3 = int(min(var_2 - var_1, _id_6A12(var_0)));
    _id_D543(var_0, var_3);
  }
}

incrementequipmentmotherlodetracking(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\cp\utility::_id_459B(var_1, 1);
  var_2 = getequipmentmotherlodetracking(var_0);
  var_3 = _id_6A0F(var_0);
  var_4 = int(min(var_2 + var_1, var_3));
  setequipmentmotherlodetracking(var_0, var_4);
}

decrementequipmentmotherlodetracking(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\cp\utility::_id_459B(var_1, 1);
  var_2 = getequipmentmotherlodetracking(var_0);
  var_1 = int(min(var_1, var_2));

  if(var_1 > 0) {
    setequipmentmotherlodetracking(var_0, var_2 - var_1);
  }
}

setequipmentmotherlodetracking(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  self.equipment_motherlodes[var_0] = var_1;
}

getequipmentmotherlodetracking(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return scripts\cp\utility::_id_459B(self.equipment_motherlodes[var_0], 0);
}

clearmotherlodetracking(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self.equipment_motherlodes[var_0] = undefined;
}

getexcessmotherlodetracking(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getequipmentmotherlodetracking(var_0);
  var_2 = _id_6A0F(var_0);
  return int(max(var_1 - var_2, 0));
}

_id_7DEE(var_0, var_1) {
  var_2 = _id_69A4(var_0);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = _id_6A0F(var_2);
  var_4 = int(min(var_3 + var_1, _id_6A12(var_2)));
  _id_D543(var_2, var_4);
}

_id_4559(var_0, var_1) {
  var_2 = _id_69A4(var_0);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = _id_6A0F(var_2);
  var_4 = int(min(var_3 - var_1, _id_6A12(var_2)));
  _id_D543(var_2, var_4);
}

_id_6A12(var_0) {
  var_1 = _id_6A17(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_1.objweapon)) {
    return 0;
  }

  var_2 = scripts\cp\utility::_hasperk("specialty_extraoffhandammo");
  var_3 = weaponmaxammo(var_1.objweapon, var_2);
  var_3--;
  var_4 = _id_5AEA(var_0);

  if(scripts\cp\utility::_hasperk("specialty_extra_deadly") && var_4 == "primary") {
    var_3++;
  }

  if(scripts\cp\utility::_hasperk("specialty_extra_tactical") && var_4 == "secondary") {
    var_3++;
  }

  return var_3;
}

hasmaxammo(var_0) {
  return _id_6A0F(var_0) == _id_6A12(var_0);
}

_id_0BDF() {
  if(!istrue(self.offhand_watches_initialized)) {
    self.equipment = [];
    self.offhand_watches_initialized = 1;
    thread _id_0DD3();
    thread _id_0DCC();
  }
}

_id_0DD3() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("offhand_fired", var_0);
    waittillframeend;
    _id_56EF(var_0);
  }
}

_id_0DCC() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  _id_393C();
  self.offhand_watches_initialized = undefined;
}

_id_56EF(var_0) {
  if(!_func_0107(self.equipment)) {
    self.equipment = [];
  }

  foreach(var_12, var_2 in self.equipment) {
    var_3 = _id_6A17(var_2);

    if(isDefined(var_3) && isDefined(var_3.objweapon) && var_0 == var_3.objweapon) {
      var_4 = _id_6A14(var_0);
      var_5 = _id_6942(var_2, "onFired");

      if(isDefined(var_5)) {
        self thread[[var_5]](var_2, var_12, var_0);
      }

      if(istrue(self.triggeredkeepgrenade)) {
        var_6 = 1;
        var_7 = _id_0945::_id_664E("gain_equipment_chance");

        if(randomfloat(1) < var_7) {
          var_6 = 2;
        }

        var_8 = _id_6A0F(var_2);
        var_9 = int(min(var_8 + var_6, _id_6A12(var_2)));
        _id_D543(var_2, var_9);
        var_10 = var_9 - var_8;

        if(var_10 > 0) {
          incrementequipmentmotherlodetracking(var_2, var_10);
        }
      }

      self.triggeredkeepgrenade = undefined;
      _id_0DB0(var_12);
      var_11 = isDefined(self._id_2E72) && self._id_2E72.size > 0 && var_0.basename == "s4_c4_zm";

      if(_id_6A0F(var_0) == 0 && !var_11) {
        thread take_on_offhand_end(var_0, var_12);
      }

      break;
    }
  }
}

take_on_offhand_end(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("offhand_end");

  if(_id_6A0F(var_0) == 0) {
    _id_EDBD(var_1);
  }
}

should_keep_grenade(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(istrue(var_2), 1, 0);

  if(isDefined(var_1) && getequipmentmotherlodetracking(var_1) >= _id_6A0F(var_1) + 1) {
    return 0;
  }

  if(isDefined(var_0) && scripts\engine\utility::array_contains(level.aether_grenade_disabled_weapons, var_0)) {
    return 0;
  }

  var_4 = _id_0945::_id_664E("keep_equipment_chance");
  return randomfloat(1) < var_4;
}

_id_0C84(var_0) {
  var_1 = var_0 scripts\cp\cp_weapon::_id_68A9();

  foreach(var_3 in var_1) {
    var_3 notify("owner_disconnect");
  }
}

_id_6942(var_0, var_1) {
  if(!isDefined(level.equipment._id_2F52[var_0])) {
    return undefined;
  }

  return level.equipment._id_2F52[var_0][var_1];
}

_id_10AB(var_0, var_1, var_2) {
  if(!isDefined(level.equipment) || !isDefined(level.equipment._id_2F52) || !_func_0107(level.equipment._id_2F52)) {
    return;
  }
  if(!isDefined(level.equipment._id_2F52[var_0])) {
    return;
  }
  if(isDefined(level.equipment._id_2F52[var_0][var_1])) {
    return;
  }
  level.equipment._id_2F52[var_0][var_1] = var_2;
}

_id_558E(var_0) {
  var_1 = var_0.objweapon.basename;

  foreach(var_10, var_3 in level.equipment._id_EC5C) {
    var_4 = _id_6942(var_10, "onPlayerDamaged");

    if(isDefined(var_4) && isDefined(var_3._id_4336)) {
      foreach(var_6 in var_3._id_4336) {
        if(var_6 == var_1) {
          var_7 = gettime();
          var_8 = [[var_4]](var_0);
          return var_8;
        }
      }
    }
  }
}

_id_6790(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
  }

  if(!isDefined(var_5._id_3BEB)) {
    var_5._id_3BEB = _id_64CC();
  }

  if(!isDefined(var_5._id_4BC3)) {
    var_5._id_4BC3 = 5;
  }

  if(!isDefined(var_5._id_1750)) {
    var_5._id_1750 = 1;
  }

  if(!isDefined(var_5._id_7D2B)) {
    var_5._id_7D2B = [var_0, var_0.owner];
  }

  if(!isDefined(var_5._id_7CFF)) {
    var_5._id_7D1B = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 10;
  }

  if(!isDefined(var_5._id_9CB1)) {
    var_5._id_9CB1 = var_4 - var_4 * var_0._id_F1DF;
  }

  var_6 = var_5._id_9CB1 / var_5._id_4BC3;
  var_7[0] = 0;
  var_8[0] = var_0.origin;
  var_9 = var_5._id_4BC3;
  var_10 = anglesToForward(var_1);
  var_11 = (0, 0, 1);
  var_12 = var_10 * var_2 + var_11 * var_3;
  var_13 = var_11 * vectordot(var_11, var_12);
  var_14 = var_12 - var_13;

  for(var_15 = 1; var_15 < var_5._id_4BC3; var_15++) {
    var_16 = var_7[var_15 - 1];
    var_17 = var_8[var_15 - 1];
    var_18 = var_15 * var_6;
    var_19 = var_14 * var_18;
    var_20 = var_13 * var_18 + (0, 0, -400) * var_18 * var_18;
    var_21 = var_8[0] + var_19 + var_20;
    var_7[var_15] = var_18;
    var_8[var_15] = var_21;
    var_22 = _func_02C1(var_17, var_21, var_5._id_3BEB, var_5._id_7D2B, 1, "physicsquery_closest", var_5._id_7D1B);

    if(isDefined(var_22) && var_22.size > 0) {
      var_5._id_4823 = var_22[0]["position"];
      var_5._id_4827 = var_22[0]["normal"];
      var_5._id_4825 = var_22[0]["entity"];
      var_5._id_4826 = 1;
      var_23 = var_21 - var_17;
      var_24 = length(var_23);
      var_25 = var_23 / var_24;
      var_26 = var_17 - var_5._id_4823;
      var_27 = vectordot(var_25, var_26);
      var_28 = clamp(var_27 / var_24, 0, 1);
      var_5._id_4829 = var_16 + var_6 * var_28;
      break;
    } else if(var_15 == var_5._id_4BC3 - 1) {
      var_5._id_4823 = var_21;
      break;
    }

    if(var_5._id_1750) {
      waitframe();
    }
  }

  return var_5;
}

_id_64CC(var_0) {
  var_1 = undefined;

  if(istrue(var_0)) {
    var_1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_characterproxy"]);
  } else {
    var_1 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water"]);
  }

  return var_1;
}

_id_B198(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("death");
  var_0._id_C2FF = var_0.origin;
  var_0._id_C304 = self.origin;
  var_0._id_C303 = self getEye();
  var_0._id_C302 = self _meth_8599();

  if(!isDefined(var_1._id_B1D3)) {
    var_1._id_B1D3 = 0.5;
  }

  if(!isDefined(var_1._id_B1D2)) {
    var_1._id_B1D2 = 0;
  }

  if(!isDefined(var_1._id_B1D4)) {
    var_1._id_B1D4 = 12;
  }

  if(!isDefined(var_1._id_B1D1)) {
    var_1._id_B1D1 = 20;
  }

  if(!isDefined(var_1._id_B1D5)) {
    var_1._id_B1D5 = 45;
  }

  if(!isDefined(var_1._id_B1D6)) {
    var_1._id_B1D6 = 0.342;
  }

  if(!isDefined(var_1._id_B1D8)) {
    var_1._id_B1D8 = 1;
  }

  _id_B1C2(var_0, var_1);
  var_2 = 0;
  var_3 = var_1._id_A6AA;
  var_4 = var_1._id_A6A7;
  var_5 = var_1._id_A6A1;
  var_6 = var_1._id_A6A3;
  var_7 = undefined;

  if(!istrue(var_6)) {
    var_3 = var_1._id_2EC1;
    var_4 = var_1._id_2EC0;
    var_5 = var_1._id_2EB7;
    var_6 = var_1._id_2EBC;

    if(istrue(var_6) && isDefined(var_5) && var_5 _meth_8163()) {
      var_6 = undefined;
    }
  } else
    var_7 = _id_B19E(var_0.angles, var_1);

  if(istrue(var_6)) {
    if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1._id_B1D6) {
      var_2 = 1;
    } else {
      var_8 = vectordot(var_0._id_C304 - var_3, (0, 0, 1));

      if(var_8 > 0) {
        if(var_8 > var_1._id_B1D1) {
          var_2 = 1;
        }
      } else {
        var_9 = vectordot(var_0._id_C303 - var_0._id_C304, (0, 0, 1));

        if(var_9 > var_1._id_B1D5) {
          var_10 = vectordot(var_0._id_C303 - var_3, (0, 0, 1));

          if(var_10 >= 0) {
            if(var_10 < var_1._id_B1D4) {
              var_2 = 1;
            }
          } else
            var_2 = 1;
        }
      }
    }
  } else
    var_2 = 1;

  if(var_2) {
    var_11 = var_1._id_330A;

    if(!isDefined(var_11)) {
      var_11 = _id_64CC();
    }

    var_12 = [var_0, self];
    var_13 = var_0._id_C304;
    var_14 = var_13 + (0, 0, -1 * var_1._id_B1D1);
    var_15 = _func_02C1(var_13, var_14, var_11, var_12, 1, "physicsquery_closest", 1);

    if(isDefined(var_15) && var_15.size > 0) {
      var_3 = var_15[0]["position"];
      var_4 = var_15[0]["normal"];

      if(isDefined(var_4) && vectordot(var_4, (0, 0, 1)) < var_1._id_B1D6) {
        return 0;
      }

      var_16 = var_0._id_C302 * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\cp\utility::_id_FFE3(anglesToForward(var_16), var_4);
        var_7 = _id_B19E(var_7, var_1);
      } else
        var_7 = var_16;

      var_3 = var_3 + anglestoup(var_7) * var_1._id_B1D8;
      var_5 = var_15[0]["entity"];
      var_0 dontinterpolate();
      var_0.origin = var_3;
      var_0.angles = var_7;
    } else
      return 0;
  } else {
    if(!isDefined(var_7)) {
      var_16 = var_0._id_C302 * (0, 1, 0);

      if(isDefined(var_4)) {
        var_7 = scripts\cp\utility::_id_FFE3(anglesToForward(var_16), var_4);
        var_7 = _id_B19E(var_7, var_1);
      } else
        var_7 = var_16;
    }

    var_3 = var_3 + anglestoup(var_7) * var_1._id_B1D8;
    var_0 dontinterpolate();
    var_0.origin = var_3;
    var_0.angles = var_7;
  }

  if(isDefined(var_5)) {
    var_0 linkto(var_5);
  }

  return 1;
}

_id_B1C2(var_0, var_1) {
  childthread _id_B1C4(var_0, var_1);
  childthread _id_B1C3(var_0, var_1);
  childthread _id_B1C5(var_0, var_1);
  var_1 waittill("start_race");
  waittillframeend;
  var_1 notify("end_race");
  return var_1;
}

_id_B1C4(var_0, var_1) {
  var_1 endon("end_race");
  var_0 waittill("missile_stuck", var_2);
  var_1._id_A6AA = var_0.origin;
  var_1._id_A697 = var_0.angles;
  var_1._id_A6A1 = var_2;
  var_1._id_A6A3 = 1;
  var_1 notify("start_race");
}

_id_B1C3(var_0, var_1) {
  var_1 endon("end_race");
  var_1 = _id_6790(var_0, var_0._id_C302, var_1._id_F1D0, var_1._id_F1D1, var_1._id_3314, var_1);
  var_1._id_2EC1 = var_1._id_4823;
  var_1._id_2EC0 = var_1._id_4827;
  var_1._id_2EB7 = var_1._id_4825;
  var_1._id_2EBC = var_1._id_4826;
  var_1 notify("start_race");
}

_id_B1C5(var_0, var_1) {
  var_1 endon("end_race");
  wait(var_1._id_B1D3);
  var_1 notify("start_race");
}

_id_B19E(var_0, var_1) {
  var_2 = 0;
  var_3 = var_0[1];
  var_4 = scripts\engine\utility::ter_op(var_1._id_B1D2 != 0, var_0[2], 0);

  if(var_4 != 0) {
    if(var_4 > 0) {
      var_4 = clamp(var_0[2], 0, var_1._id_B1D2);
    } else {
      var_4 = clamp(var_0[2], -1 * var_1._id_B1D2, 0);
    }
  }

  return (var_2, var_3, var_4);
}

_id_99EF(var_0, var_1) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var_2 = self.owner;
  var_3 = self.weapon_name;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    self enablemissilehint(1);
  } else {
    self setcursorhint("HINT_NOICON");
  }

  self _meth_84D7(var_0);
  self setuserange(72);
  _id_D549(self.weapon_name);
  scripts\cp\utility::_id_D6C2(var_2, 0);
  childthread scripts\cp\utility::setusableforjoiningplayers(var_2);

  for(;;) {
    self waittill("trigger", var_4);
    var_4 notify("pickup_equipment", var_3);
    var_5 = _id_6A14(makeweapon(var_3));

    if(isDefined(var_5)) {
      if(var_4 _id_755B(var_5)) {
        if(!var_4 hasmaxammo(var_5)) {
          var_4 incrementequipmentammo(var_5, 1);
          var_4 incrementequipmentmotherlodetracking(var_5, 1);
        } else
          continue;
      } else {
        var_6 = spawnStruct();
        var_6._id_5556 = var_5;
        var_4 giveequipment(var_6);
      }
    }

    if(isDefined(self._id_FE90)) {
      self._id_FE90 delete();
    }

    thread scripts\cp\cp_weapon::_id_476C();
    return;
  }
}

_id_D549(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "s4_c4_zm":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_C4");
      break;
    case "s4_mine_ger_s44_zm":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_AT_MINE");
      break;
    case "claymore_zm":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_CLAYMORE");
      break;
    case "gas_grenade_zm":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_GAS_GRENADE");
      break;
    case "trophy_zm":
      self sethintstring(&"EQUIPMENT_HINTS/PICKUP_TROPHY");
      break;
  }
}

_id_755B(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(self.equipment)) {
    return 0;
  }

  foreach(var_2 in self.equipment) {
    if(var_2 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_5AEA(var_0) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  foreach(var_3, var_2 in self.equipment) {
    if(var_2 == var_0) {
      return var_3;
    }
  }
}

_id_6A14(var_0) {
  var_0 = _id_9AB6(var_0);

  foreach(var_2 in level.equipment._id_EC5C) {
    if(isDefined(var_2.objweapon) && var_0 == var_2.objweapon) {
      return var_2._id_C189;
    }
  }

  return undefined;
}

_id_9AB6(var_0) {
  switch (var_0.basename) {
    case "at_mine_ap_mp":
      return makeweapon("at_mine_mp");
  }

  return var_0;
}

_id_6A0F(var_0) {
  if(!isweapon(var_0)) {
    var_1 = _id_6A17(var_0);
    var_0 = var_1.objweapon;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  return self _meth_8109(var_0);
}

_id_D543(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = _id_6A17(var_0);
  var_3 = var_2.objweapon;
  self setweaponammoclip(var_3, var_1);
  _id_0DB0(_id_5AEA(var_0));
}

_id_0DB0(var_0) {
  if(!isDefined(self.equipment) || !isDefined(var_0)) {
    return;
  }
  var_1 = 0;
  var_2 = 0;
  var_3 = _id_69A4(var_0);

  if(isDefined(var_3)) {
    var_1 = _id_6A15(var_0);
    var_2 = _id_6A12(var_3);
  }

  if(var_0 == "primary") {
    self setclientomnvar("ui_power_num_charges", var_1);
    self _meth_8759("primary", var_1, var_2);
  } else if(var_0 == "secondary") {
    self setclientomnvar("ui_power_secondary_num_charges", var_1);
    self _meth_8759("secondary", var_1, var_2);
  } else if(var_0 == "health" && scripts\cp\utility::getgametype() != "base")
    self setclientomnvar("ui_equipment_id_health_numCharges", var_1);
}

_id_D5AA(var_0, var_1) {
  if(var_0 != "super") {
    self setclientomnvar("ui_equipment_id_" + var_0, var_1);
  } else {
    self setclientomnvar("ui_perk_package_super1", var_1);
  }
}

setup_equipment_scaling_weapons_from_table() {
  level.a_weapon_equipment_damage_increase_for_round = [];
  var_0 = 0;
  var_1 = tablelookupgetnumrows("cp/zombie_weapons_equipment_scaling.csv");

  for(var_0 = 0; var_0 < var_1; var_0++) {
    var_2 = tablelookupbyrow("cp/zombie_weapons_equipment_scaling.csv", var_0, 0);

    if(!isDefined(var_2) || var_2 == "") {
      continue;
    }
    var_2 = tolower(var_2);

    if(var_2 == "none") {
      continue;
    }
    var_3 = spawnStruct();
    var_3.bonus_damage_for_round = [];
    var_3.should_scale = tablelookupbyrow("cp/zombie_weapons_equipment_scaling.csv", var_0, 1) == "TRUE";
    var_3.max_damage_health_percent_cap_normal = int(tablelookupbyrow("cp/zombie_weapons_equipment_scaling.csv", var_0, 2));
    var_3.max_damage_health_percent_cap_special = int(tablelookupbyrow("cp/zombie_weapons_equipment_scaling.csv", var_0, 3));

    for(var_4 = 1; var_4 <= 15; var_4++) {
      var_5 = float(tablelookupbyrow("cp/zombie_weapons_equipment_scaling.csv", var_0, var_4 + 3));
      var_6 = _id_09A4::zombiegethealthroundscale(var_4);
      var_3.bonus_damage_for_round[var_4] = var_5 * var_6;
    }

    level.a_weapon_equipment_damage_increase_for_round[var_2] = var_3;
  }
}

scale_damage_by_round(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::_id_6871();

  if(isDefined(level.zombie_round_override)) {
    var_4 = level.zombie_round_override;
  }

  var_5 = var_0;

  if(var_4 > 1) {
    var_6 = undefined;

    if(isDefined(level.a_weapon_equipment_damage_increase_for_round[var_1.basename])) {
      var_6 = level.a_weapon_equipment_damage_increase_for_round[var_1.basename];
    } else if(isDefined(level.a_weapon_equipment_damage_increase_for_round["default"])) {
      var_6 = level.a_weapon_equipment_damage_increase_for_round["default"];
    }

    if(isDefined(var_6.should_scale) && var_6.should_scale == 1) {
      if(var_4 > 15) {
        var_4 = 15;
      }

      var_7 = var_6.bonus_damage_for_round[var_4];
      var_5 = var_5 * var_7;

      if(isDefined(var_3)) {
        switch (var_2) {
          case "normal":
            var_8 = var_3 * (var_6.max_damage_health_percent_cap_normal / 100);

            if(var_5 > var_8) {
              var_5 = var_8;
            }

            break;
          case "special":
            var_8 = var_3 * (var_6.max_damage_health_percent_cap_special / 100);

            if(var_5 > var_8) {
              var_5 = var_8;
            }

            break;
        }
      }
    }
  }

  return int(var_5);
}

force_end_offhand() {
  var_0 = self getheldoffhand();

  if(!isnullweapon(var_0)) {
    var_1 = _id_6A14(var_0);

    if(isDefined(var_1)) {
      var_2 = _id_5AEA(var_1);
      var_3 = _id_6A0F(var_1);
      _id_4AE5(var_2);
      self takeweapon(var_0);
      self giveweapon(var_0);
      _id_526C(var_2);
      _id_D543(var_1, var_3);
    }
  }
}

setup_rbz_equipment_scaling_weapons_from_table() {
  level.a_weapon_equipment_damage_scaler = [];
  var_0 = 0;
  var_1 = tablelookupgetnumrows("cp/zombie_rbz_weapons_equipment_scaling.csv");

  for(var_0 = 0; var_0 < var_1; var_0++) {
    var_2 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 0);

    if(var_2 == "") {
      continue;
    }
    var_2 = tolower(var_2);

    if(var_2 == "none") {
      continue;
    }
    if(!isDefined(level.a_weapon_equipment_damage_scaler[var_2])) {
      level.a_weapon_equipment_damage_scaler[var_2] = [];
    }

    var_3 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 2);

    if(var_3 == "") {
      continue;
    }
    if(!isDefined(level.a_weapon_equipment_damage_scaler[var_2][var_3])) {
      level.a_weapon_equipment_damage_scaler[var_2][var_3] = [];
    }

    var_4 = spawnStruct();
    var_4.start_round = int(tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 3));
    var_4.end_round = int(tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 4));
    var_5 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 5);
    var_6 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 6);

    if(var_5 != "" && var_6 != "") {
      var_4.outer_damage_health_percent = float(var_5);
      var_4.inner_damage_health_percent = float(var_6);
    }

    var_7 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 7);

    if(var_7 != "") {
      var_4.hit_damage_health_percent = float(var_7);
    }

    var_8 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 8);
    var_9 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 9);

    if(var_8 != "" && var_9 != "") {
      var_4.dot_outer_damage_health_percent = float(var_8);
      var_4.dot_inner_damage_health_percent = float(var_9);
    }

    var_10 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 10);
    var_11 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 11);
    var_12 = tablelookupbyrow("cp/zombie_rbz_weapons_equipment_scaling.csv", var_0, 12);

    if(var_10 != "" && var_11 != "" && var_12 != "") {
      var_4.stage_1_damage_health_percent = float(var_10);
      var_4.stage_2_damage_health_percent = float(var_11);
      var_4.stage_3_damage_health_percent = float(var_12);
    }

    level.a_weapon_equipment_damage_scaler[var_2][var_3][level.a_weapon_equipment_damage_scaler[var_2][var_3].size] = var_4;
  }
}

rbz_scale_damage_by_round(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 0;

  if(!isDefined(var_6) || !isDefined(var_3.basename)) {
    return [var_1, var_8];
  }

  if(!isDefined(level.a_weapon_equipment_damage_scaler) || !isDefined(level.a_weapon_equipment_damage_scaler[var_3.basename]) || !isDefined(level.a_weapon_equipment_damage_scaler[var_3.basename][var_6])) {
    return [var_1, var_8];
  }

  var_9 = scripts\cp\utility::_id_6871();
  var_10 = var_1;

  foreach(var_12 in level.a_weapon_equipment_damage_scaler[var_3.basename][var_6]) {
    if(var_9 < var_12.start_round || var_12.end_round != -1 && var_9 > var_12.end_round) {
      continue;
    }
    if(is_direct_hit_damage(var_0, var_3, var_2, var_5) && isDefined(var_12.hit_damage_health_percent)) {
      var_10 = var_12.hit_damage_health_percent * var_7 / 100;
      var_8 = 1;

      if(var_3.basename == "s4_mg_streak_mp") {
        var_10 = var_10 * getdeathmachinebodypartdamagescaler(var_5);
      } else {}
    } else if(is_equipment_radius_damage(var_0, var_3, var_2) && isDefined(var_12.outer_damage_health_percent) && isDefined(var_12.inner_damage_health_percent)) {
      if(var_3.basename == "s4_thermite_zm") {
        var_13 = _id_0920::get_thermite_impact_damage_radius();
      } else if(var_3.basename == "s4_mg_streak_mp") {
        var_13 = getdvarfloat("#x3377ab12e341dc2dc", 125);
      } else {
        var_13 = _func_00EF(var_3);
      }

      if(var_13 > 0) {
        var_10 = rbz_calculate_equipment_radius_damage(self.origin, var_4, var_13, var_12.inner_damage_health_percent, var_12.outer_damage_health_percent, var_7);
        var_8 = 1;
      }
    } else if(is_equipment_dot_radius_damage(var_0, var_3, var_2) && isDefined(var_12.dot_outer_damage_health_percent) && isDefined(var_12.dot_inner_damage_health_percent)) {
      var_13 = 0;

      if(var_3.basename == "s4_thermite_zm") {
        var_13 = _id_0920::get_thermite_tick_damage_radius();
      }

      if(var_13 > 0) {
        var_10 = rbz_calculate_equipment_radius_damage(self.origin, var_4, var_13, var_12.dot_inner_damage_health_percent, var_12.dot_outer_damage_health_percent, var_7);
        var_8 = 1;
      }
    } else if(is_stage_damage(var_0, var_3) && isDefined(var_12.stage_1_damage_health_percent) && isDefined(var_12.stage_2_damage_health_percent) && isDefined(var_12.stage_3_damage_health_percent)) {
      if(var_3.basename == "s4_molotov_zm") {
        var_15 = var_12.stage_1_damage_health_percent;

        if(isDefined(var_0) && var_0 scripts\engine\utility::_id_546E("molotov_stage_2")) {
          var_15 = var_12.stage_2_damage_health_percent;
        } else if(isDefined(var_0) && var_0 scripts\engine\utility::_id_546E("molotov_stage_3")) {
          var_15 = var_12.stage_3_damage_health_percent;
        }

        if(var_15 > 0) {
          var_10 = var_15 * var_7 / 100;
          var_8 = 1;
        }
      }
    }

    break;
  }

  return [int(var_10), var_8];
}

rbz_calculate_equipment_radius_damage(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = distance2d(var_0, var_1);
  var_7 = clamp(var_6 / var_2, 0.0, 1.0);
  var_8 = scripts\engine\math::_id_91A9(var_3, var_4, var_7);
  var_9 = var_8 * var_5 / 100;
  return var_9;
}

is_direct_hit_damage(var_0, var_1, var_2, var_3) {
  if(var_1.basename == "s4_mg_streak_mp" && var_2 == "MOD_EXPLOSIVE_BULLET" && var_3 != "none") {
    return 1;
  }

  if(var_2 == "MOD_IMPACT" || var_2 == "MOD_GRENADE") {
    return 1;
  }

  return 0;
}

is_equipment_radius_damage(var_0, var_1, var_2) {
  if(var_1.basename == "s4_thermite_zm" && isDefined(var_0) && var_0 scripts\engine\utility::_id_546E("thermite_impact_damage")) {
    return 1;
  }

  if(var_2 == "MOD_GRENADE_SPLASH" || var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET") {
    return 1;
  }

  return 0;
}

is_equipment_dot_radius_damage(var_0, var_1, var_2) {
  if(var_1.basename == "s4_thermite_zm" && isDefined(var_0) && !var_0 scripts\engine\utility::_id_546E("thermite_impact_damage")) {
    return 1;
  }

  return 0;
}

is_stage_damage(var_0, var_1) {
  if(var_1.basename == "s4_molotov_zm" && isDefined(var_0) && (var_0 scripts\engine\utility::_id_546E("molotov_stage_1") || var_0 scripts\engine\utility::_id_546E("molotov_stage_2") || var_0 scripts\engine\utility::_id_546E("molotov_stage_3"))) {
    return 1;
  }

  return 0;
}

getdeathmachinebodypartdamagescaler(var_0) {
  switch (var_0) {
    case "neck":
    case "helmet":
    case "head":
      return 2.5;
    case "torso_lower":
      return 0.91;
    default:
      return 1;
  }
}