/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1996.gsc
*************************************************/

init() {
  level.equipment = spawnStruct();
  _id_81FF();
  _id_96AB();
  initequipmentoob();
  _id_0AA3::_id_C28D(::_id_558F);
}

_id_81FF() {
  level.equipment._id_2F52 = [];
  var_0 = level.equipment;
  _id_07CD::_id_555E();

  if(!istrue(game["isLaunchChunk"])) {
    _id_0A68::init();
    _id_0A19::_id_ECAC();
    _id_0A07::_id_4539();
    _id_0A01::_id_1D41();
    _id_0A02::_id_1D41();
    _id_0A18::_id_ECFA();
    _id_0A0F::_id_8B6E();
    _id_0A0A::_id_5A1B();
    scripts\mp\equipment\trophy::_id_F68D();
    _id_09FC::init();
    scripts\mp\equipment\serum::init();
  }

  _id_0A15::_id_E807();
  _id_0A1A::_id_F0F7();
  _id_0A05::_id_381A();
  _id_0A11::_id_A06C();
  _id_0A1E::_id_10D79();
  _id_09A7::_id_F198();
  _id_09A8::_id_F1A6();
  var_0._id_2F52["equip_helmet"]["onGive"] = _id_0A68::_id_CA3F;
  var_0._id_2F52["equip_helmet"]["onTake"] = _id_0A68::_id_C4CC;
  var_0._id_2F52["equip_adrenaline"]["onFired"] = _id_09FC::_id_AACE;
  var_0._id_2F52["equip_adrenaline"]["onTake"] = _id_09FC::_id_AAD0;
  var_0._id_2F52["equip_serum"]["onFired"] = ::scripts\mp\equipment\serum::_id_AACE;
  var_0._id_2F52["equip_serum"]["onTake"] = ::scripts\mp\equipment\serum::_id_AAD0;
  var_0._id_2F52["equip_c4"]["onGive"] = _id_0A04::_id_2E60;
  var_0._id_2F52["equip_throwing_knife"]["onGive"] = _id_09A7::_id_F19F;
  var_0._id_2F52["equip_throwing_knife"]["onTake"] = _id_09A7::_id_F1A0;
  var_0._id_2F52["equip_throwing_star"]["onGive"] = _id_09A8::_id_F1AD;
  var_0._id_2F52["equip_throwing_star"]["onTake"] = _id_09A8::_id_F1AE;
  var_0._id_2F52["equip_molotov"]["onGive"] = _id_0A11::_id_A073;
  var_0._id_2F52["equip_molotov"]["onTake"] = _id_0A11::_id_A075;
  var_0._id_2F52["equip_tac_cover"]["onGive"] = _id_0A19::_id_ECAF;
  var_0._id_2F52["equip_tac_cover"]["onTake"] = _id_0A19::_id_ECB0;
  var_0._id_2F52["equip_tac_cover"]["onFired"] = _id_0A19::_id_ECAD;
  var_0._id_2F52["equip_tac_insert"]["onGive"] = _id_0A18::_id_ED00;
  var_0._id_2F52["equip_tac_insert"]["onTake"] = _id_0A18::_id_ED03;
  var_0._id_2F52["equip_gas_grenade"]["onPlayerDamaged"] = _id_0A0D::_id_6188;
  var_0._id_2F52["equip_flash"]["onPlayerDamaged"] = _id_0A0B::_id_AB61;
  var_0._id_2F52["equip_concussion"]["onPlayerDamaged"] = _id_0A06::_id_AB61;
  var_0._id_2F52["equip_thermite"]["onPlayerDamaged"] = _id_0A1A::_id_F0FA;
  var_0._id_2F52["equip_molotov"]["onPlayerDamaged"] = _id_0A11::_id_A074;
  var_0._id_2F52["equip_at_mine"]["onOwnerChanged"] = _id_0A01::_id_1D43;
  var_0._id_2F52["equip_at_mine_stun"]["onOwnerChanged"] = _id_0A02::_id_1D43;
  var_0._id_2F52["equip_claymore"]["onOwnerChanged"] = _id_0A05::_id_381C;
  var_0._id_2F52["equip_c4"]["onOwnerChanged"] = _id_0A04::_id_2E59;
  var_0._id_2F52["equip_equipmentResupplyBox"]["onOwnerChanged"] = _id_0A09::_id_5557;
  var_0._id_2F52["equip_field_mic"]["onOwnerChanged"] = _id_0A0A::_id_5A1D;
  var_0._id_2F52["equip_jammer"]["onOwnerChanged"] = _id_0A0F::_id_8B71;
  var_0._id_2F52["equip_trophy"]["onOwnerChanged"] = ::scripts\mp\equipment\trophy::trophy_on_owner_changed;
  var_0._id_2F52["equip_at_mine"]["onDestroyedByTrophy"] = _id_0A01::_id_1D3A;
  var_0._id_2F52["equip_at_mine_stun"]["onDestroyedByTrophy"] = _id_0A02::_id_1D3A;
  var_0._id_2F52["equip_claymore"]["onDestroyedByTrophy"] = _id_0A05::_id_3812;
  var_0._id_2F52["equip_c4"]["onDestroyedByTrophy"] = _id_0A04::_id_2E4A;
  var_0._id_2F52["equip_snapshot_grenade"]["onDestroyedByTrophy"] = _id_0A14::_id_DEB7;
  thread _id_10B99();
  _id_0A8E::_id_C285(::_id_AB49);
}

_id_6942(var_0, var_1) {
  if(!isDefined(level.equipment._id_2F52[var_0])) {
    return undefined;
  }

  return level.equipment._id_2F52[var_0][var_1];
}

_id_96AB() {
  level.equipment._id_EC5C = [];
  var_0 = 1;

  for(;;) {
    var_1 = tablelookupbyrow("mp/equipment.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tolower(var_1);
    var_3 = spawnStruct();
    var_3._id_C189 = var_2;
    var_4 = tablelookupbyrow("mp/equipment.csv", var_0, 6);

    if(var_4 != "none") {
      var_3.objweapon = makeweapon(var_4);
    }

    var_3._id_7C8C = var_0;
    var_3._id_7D40 = tablelookupbyrow("mp/equipment.csv", var_0, 4);
    var_3._id_45C7 = scripts\engine\utility::ter_op(tablelookupbyrow("mp/equipment.csv", var_0, 7) == "2", "secondary", "primary");
    var_3._id_CBA6 = int(tablelookupbyrow("mp/equipment.csv", var_0, 10));
    var_3._id_8973 = tolower(tablelookupbyrow("mp/equipment.csv", var_0, 11)) == "true";
    var_3._id_8A20 = tablelookupbyrow("mp/equipment.csv", var_0, 8) != "-1";
    var_3._id_8B15 = tablelookupbyrow("mp/equipment.csv", var_0, 18) == "1";
    var_5 = tablelookupbyrow("mp/equipment.csv", var_0, 12);

    if(var_5 == "none") {} else if(var_5 == "") {
      if(var_4 != "none") {
        var_3._id_4336 = [var_4];
      }
    } else {
      var_6 = [];

      if(var_4 != "none") {
        var_6[var_6.size] = var_4;
      }

      var_7 = strtok(var_5, " ");

      foreach(var_9 in var_7) {
        var_6[var_6.size] = var_9;
      }

      var_3._id_4336 = var_6;
    }

    level.equipment._id_EC5C[var_2] = var_3;
    var_0++;
  }
}

_id_6A17(var_0) {
  return level.equipment._id_EC5C[var_0];
}

giveequipment(var_0, var_1) {
  if(!isDefined(self.equipment)) {
    self.equipment = [];
  }

  if(var_0 == "none") {
    return;
  }
  var_2 = _id_6A17(var_0);

  if(var_1 == "super") {
    var_3 = level._id_2A95._id_2ABF[level._id_2A95._id_2A43[var_0]];
    var_2._id_7C8C = scripts\mp\supers::_id_6DA1(var_3);
  }

  _id_EDBD(var_1);

  if(isDefined(var_2.objweapon)) {
    self giveweapon(var_2.objweapon);

    if(_id_85BF(var_1) && !var_2._id_8973) {
      if(var_1 == "primary") {
        self _meth_849C(var_2.objweapon);
      } else if(var_1 == "secondary") {
        self _meth_849D(var_2.objweapon);
      } else if(var_1 == "super") {
        self _meth_84E9(var_2.objweapon);
      }
    }
  }

  if(!getdvarint("#x319d0418d7f12962d", 0)) {
    _id_D5AA(var_1, var_2._id_7C8C);
  }

  self.equipment[var_1] = var_0;
  var_4 = _id_6942(var_0, "onGive");

  if(isDefined(var_4)) {
    self thread[[var_4]](var_0, var_1);
  }

  _id_FD74(var_1);

  if(scripts\mp\utility\game::_id_875E() && var_0 == "equip_throwing_knife") {
    return;
  }
  if((scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "control") && !scripts\mp\utility\game::isanymlgmatch() && var_0 == "equip_throwing_knife") {
    return;
  }
  thread _id_10B9C(var_0, var_1);
  return;
  return;
}

_id_EDBD(var_0) {
  var_1 = _id_69A4(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _id_6A17(var_1);

  if(isDefined(var_2.objweapon)) {
    if(self hasweapon(var_2.objweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2.objweapon);

      if(var_0 == "primary") {
        self _meth_849E();
      } else if(var_0 == "secondary") {
        self _meth_849F();
      }
    }
  }

  _id_D5AA(var_0, 0);
  self.equipment[var_0] = undefined;
  var_3 = _id_6942(var_1, "onTake");

  if(isDefined(var_3)) {
    self thread[[var_3]](var_1, var_0);
  }

  _id_FD74(var_0);
  self notify("equipment_taken_" + var_1);
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

_id_AAB2() {
  if(isDefined(self._id_5562)) {
    var_0 = _id_6942(self._id_5562, "onDestroyedByTrophy");

    if(isDefined(var_0)) {
      self thread[[var_0]]();
      return 1;
    } else if(scripts\mp\weapons::_id_8985(self)) {
      thread scripts\mp\weapons::_id_476C();
      return 1;
    }
  }

  return 0;
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
  var_1 = _id_69A4(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = _id_6A17(var_1);

  if(isDefined(var_2.objweapon) && !var_2._id_8973) {
    if(var_0 == "primary") {
      self _meth_849C(var_2.objweapon);
    } else if(var_0 == "secondary") {
      self _meth_849D(var_2.objweapon);
    } else if(var_0 == "super") {
      self _meth_84E9(var_2.objweapon);
    }
  }
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

_id_85BF(var_0) {
  return scripts\common\input_allow::_id_860C("equipment_" + var_0);
}

_id_D5AA(var_0, var_1) {
  if(var_0 != "super") {
    self setclientomnvar("ui_equipment_id_" + var_0, var_1);
  } else {
    self setclientomnvar("ui_perk_package_super1", var_1);
  }
}

_id_69A4(var_0) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  return self.equipment[var_0];
}

_id_391D() {
  if(!isDefined(self.equipment)) {
    return;
  }
  foreach(var_2, var_1 in self.equipment) {
    _id_EDBD(var_2);
  }
}

_id_6A12(var_0) {
  var_1 = _id_6A17(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_1.objweapon)) {
    return 0;
  }

  if(level.gametype != "br") {
    var_2 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
    var_3 = weaponmaxammo(var_1.objweapon, var_2);

    switch (var_0) {
      case "equip_hb_sensor":
      case "equip_tac_cover":
      case "equip_tac_insert":
        break;
      default:
        var_3--;
        break;
    }

    var_4 = _id_5AEA(var_0);

    if(scripts\mp\utility\perk::_hasperk("specialty_extra_deadly") && var_4 == "primary") {
      var_3++;
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_extra_tactical") && var_4 == "secondary") {
      var_3++;
    }
  } else
    var_3 = level._id_2A95._id_9C60[level._id_2A95._id_2A43[var_1._id_C189]];

  return var_3;
}

_id_6A16(var_0) {
  var_1 = _id_6A17(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_1.objweapon)) {
    return 0;
  }

  var_2 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
  var_3 = _func_027D(var_1.objweapon, var_2);

  if(isDefined(self.equipment["primary"]) && self.equipment["primary"] == var_0 && scripts\mp\utility\perk::_hasperk("specialty_extra_deadly")) {
    var_3 = var_3 + 1;
  }

  if(isDefined(self.equipment["primary"]) && self.equipment["primary"] == var_0 && scripts\mp\utility\perk::_hasperk("specialty_van_demolition")) {
    var_3 = var_3 + 1;
  }

  if(isDefined(self.equipment["secondary"]) && self.equipment["secondary"] == var_0 && scripts\mp\utility\perk::_hasperk("specialty_extra_tactical")) {
    var_3 = var_3 + 1;
  }

  return var_3;
}

_id_6A0F(var_0) {
  var_1 = _id_6A17(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_1.objweapon)) {
    return 0;
  }

  return self _meth_8109(var_1.objweapon);
}

_id_D543(var_0, var_1) {
  var_2 = _id_6A17(var_0);

  if(!isDefined(var_2.objweapon)) {
    return;
  }
  self setweaponammoclip(var_2.objweapon, var_1);
  _id_FD74(_id_5AEA(var_0));
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

_id_9AB6(var_0) {
  switch (var_0.basename) {
    case "claymore_radial_mp":
      return makeweapon("claymore_mp");
    case "at_mine_ap_mp":
      return makeweapon("at_mine_mp");
    case "thermite_ap_mp":
    case "thermite_av_mp":
      return makeweapon("s4_thermite_mp");
  }

  return var_0;
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

_id_6E73(var_0) {
  foreach(var_2 in level.equipment._id_EC5C) {
    if(isDefined(var_2._id_C189) && var_0 == var_2._id_C189) {
      return var_2.objweapon;
    }
  }

  return undefined;
}

_id_755B(var_0) {
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

_id_8836(var_0) {
  return _id_8837(var_0);
}

_id_8837(var_0) {
  if(isDefined(level.equipment._id_EC5C[var_0])) {
    return level.equipment._id_EC5C[var_0]._id_45C7 == "primary";
  } else {
    return 0;
  }
}

_id_883B(var_0) {
  return _id_8838(var_0);
}

_id_8838(var_0) {
  if(isDefined(level.equipment._id_EC5C[var_0])) {
    return level.equipment._id_EC5C[var_0]._id_45C7 == "secondary";
  } else {
    return 0;
  }
}

_id_8839(var_0) {
  if(isDefined(level.equipment._id_EC5C[var_0])) {
    return istrue(level.equipment._id_EC5C[var_0]._id_8A20);
  } else {
    return 0;
  }
}

_id_883C(var_0) {
  if(isDefined(level.equipment._id_EC5C[var_0])) {
    return istrue(level.equipment._id_EC5C[var_0]._id_8B15);
  } else {
    return 0;
  }
}

_id_FD74(var_0) {
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
  } else if(var_0 == "health" && scripts\mp\utility\game::getgametype() != "base")
    self setclientomnvar("ui_equipment_id_health_numCharges", var_1);
}

_id_558F() {
  thread _id_10BB5();
}

_id_C611() {
  self.equipment = [];
}

_id_56EF(var_0) {
  foreach(var_7, var_2 in self.equipment) {
    var_3 = _id_6A17(var_2);

    if(isDefined(var_3.objweapon) && var_0 == var_3.objweapon) {
      if(scripts\mp\utility\game::getgametype() == "br") {
        scripts\mp\gametypes\br_analytics::_id_2AF1(self, var_0);
      }

      var_4 = _id_6A14(var_0);
      _id_07C3::_id_3ABA(var_4);
      var_5 = _id_6942(var_2, "onFired");

      if(isDefined(var_5)) {
        self thread[[var_5]](var_2, var_7, var_0);
      }

      _id_FD74(var_7);
      var_6 = "tacticalsUsed";

      if(_id_8836(var_4)) {
        var_6 = "lethalsUsed";
      }

      if(isDefined(self.pers[var_6])) {
        scripts\mp\utility\stats::_id_7DAE(var_6, 1);
      }

      break;
    }
  }
}

_id_10BB5() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("offhand_fired", var_0);
    _id_56EF(var_0);
  }
}

_id_6FE2() {
  foreach(var_3, var_1 in self.equipment) {
    var_2 = _id_6A17(var_1);

    if(var_2._id_CBA6 > 0) {
      incrementequipmentammo(var_1, var_2._id_CBA6);
    }
  }
}

_id_69D6(var_0) {
  var_1 = _id_6A17(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1._id_45C7;
}

_id_10B99() {
  level endon("lethal_delay_end");
  level endon("round_end");
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  var_0 = scripts\mp\utility\game::gametypestopsclock();

  if(var_0) {
    level._id_91E4 = gettime();
  } else {
    level._id_91E4 = scripts\mp\utility\game::_id_6DE6();
  }

  if(level._id_91E0 == 0) {
    level._id_91E2 = level._id_91E4;
    level notify("lethal_delay_end");
  }

  level._id_91E2 = level._id_91E4 + level._id_91E0 * 1000;
  level notify("lethal_delay_start");

  for(;;) {
    var_1 = undefined;

    if(var_0) {
      var_1 = gettime();
    } else {
      var_1 = scripts\mp\utility\game::_id_6DE6();
    }

    if(var_1 >= level._id_91E2) {
      break;
    }

    waitframe();
  }

  level notify("lethal_delay_end");
}

_id_10B9C(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("round_end");
  level endon("game_ended");

  if(_id_91E3()) {
    return;
  }
  self notify("watchLethalDelayPlayer_" + var_1);
  self endon("watchLethalDelayPlayer_" + var_1);
  self endon("equipment_taken_" + var_0);

  if(!isDefined(self._id_91E1) || !istrue(self._id_91E1[var_1])) {
    if(!isDefined(self._id_91E1)) {
      self._id_91E1 = [];
    }

    self._id_91E1[var_1] = 1;
    _id_153B(var_1, 0);

    if(var_1 == "primary") {
      scripts\common\utility::_id_155E(0);
    } else if(var_1 == "secondary") {
      scripts\common\utility::_id_155F(0);
    }
  }

  _id_10B9B(self, var_1);

  if(isDefined(self._id_91E1) && istrue(self._id_91E1[var_1])) {
    self._id_91E1[var_1] = undefined;

    if(self._id_91E1.size == 0) {
      self._id_91E1 = undefined;
    }

    _id_153B(var_1, 1);

    if(var_1 == "primary") {
      scripts\common\utility::_id_155E(1);
    } else if(var_1 == "secondary") {
      scripts\common\utility::_id_155F(1);
    }
  }
}

_id_10B9B(var_0, var_1) {
  level endon("lethal_delay_end");

  if(!istrue(_id_07D1::_id_60BE("prematch_done"))) {
    level waittill("lethal_delay_start");
  }

  var_2 = "+frag";

  if(var_1 != "primary") {
    var_2 = "+smoke";
  }

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("lethal_attempt_" + var_1, var_2);
  }

  var_3 = scripts\mp\utility\game::gametypestopsclock();

  for(;;) {
    self waittill("lethal_attempt_" + var_1);
    var_4 = undefined;

    if(var_3) {
      var_4 = gettime();
    } else {
      var_4 = scripts\mp\utility\game::_id_6DE6();
    }

    var_5 = (level._id_91E2 - var_4) / 1000;
    var_5 = int(max(0, _func_0037(var_5)));
    var_0 scripts\mp\hud_message::_id_DCA2("MP/LETHALS_UNAVAILABLE_FOR_N", var_5);
  }
}

_id_3160() {
  level._id_91E0 = 0;

  if(scripts\mp\utility\game::gametypestopsclock()) {
    level._id_91E4 = gettime();
  } else {
    level._id_91E4 = scripts\mp\utility\game::_id_6DE6();
  }

  level._id_91E2 = level._id_91E4;
  level notify("lethal_delay_end");
}

_id_91E3() {
  if(isDefined(level._id_91E0) && level._id_91E0 == 0) {
    return 1;
  }

  if(isDefined(level._id_91E2)) {
    var_0 = undefined;

    if(scripts\mp\utility\game::gametypestopsclock()) {
      var_0 = gettime();
    } else {
      var_0 = scripts\mp\utility\game::_id_6DE6();
    }

    return var_0 > level._id_91E2;
  }

  return 0;
}

_id_AB49(var_0) {
  var_1 = var_0 scripts\mp\weapons::_id_68A5();

  foreach(var_3 in var_1) {
    var_3 notify("owner_disconnect");
  }
}

_id_735E(var_0) {
  self._id_888A = 1;
  var_0 scripts\mp\gamelogic::_id_D58D(var_0, 1);
  var_0 _id_07BC::_id_AAFB(self._id_5562);
  _id_33E2(var_0);

  if(level.teambased) {
    self _meth_8706(var_0.team);
  } else {
    self _meth_8706(var_0);
  }

  var_0 scripts\mp\killstreaks\killstreaks::_id_6FEB();
}

_id_33E2(var_0) {
  var_1 = self.owner;
  self setentityowner(var_0);
  self.owner = var_0;
  self.team = var_0.team;
  self setotherent(var_0);
  var_1 scripts\mp\weapons::_id_C498(self);
  self.owner scripts\mp\weapons::_id_FCF3(self);
  var_2 = _id_6942(self._id_5562, "onOwnerChanged");
  self notify("ownerChanged");

  if(isDefined(var_2)) {
    self[[var_2]](var_1);
  } else {}

  changedownervo(var_1);
}

changedownervo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = "";
  var_2 = "";
  var_3 = var_0 getentitynumber();
  var_4 = "";

  switch (self._id_5562) {
    case "equip_jammer":
      var_1 = "ja";
      var_4 = "jammer";

      if(level._id_8B78[var_3].size > 0) {
        var_2 = "m";
      } else {
        var_2 = "s";
      }

      break;
    case "equip_field_mic":
      var_1 = "fm";
      var_4 = "mic";

      if(level._id_5A20[var_3].size > 0) {
        var_2 = "m";
      } else {
        var_2 = "s";
      }

      break;
    case "equip_at_mine_stun":
      var_1 = "sm";
      var_4 = "mine";

      if(isDefined(var_0) && var_0._id_B1D0.size >= 1) {
        var_2 = "m";
      } else {
        var_2 = "s";
      }

      break;
    default:
      break;
  }

  if(var_1 != "" && var_2 != "" && isDefined(var_0)) {
    var_0 thread _id_0A8D::_id_9137(var_1 + "_hijacked_" + var_2);
  }

  if(var_4 != "" && isDefined(self.owner)) {
    level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "hijack_" + var_4);
  }
}

_id_44D3() {
  for(;;) {
    if(getdvarint("#x3d73d4086f273fc33") != 0) {
      var_0 = level.players[0];
      var_1 = undefined;

      for(var_2 = 1; var_2 < level.players.size; var_2++) {
        if(var_0 scripts\mp\utility\player::isenemy(level.players[var_2])) {
          var_1 = level.players[var_2];
          break;
        }
      }

      if(!isDefined(var_1)) {
        iprintlnbold("Need a player on the other team to scr_debugHackEquipment");
        continue;
      }

      var_3 = var_0 scripts\mp\weapons::_id_68A5();
      var_4 = undefined;

      if(var_3.size > 0) {
        var_4 = var_3[0];
      }

      if(!isDefined(var_4)) {
        iprintlnbold("First player must have at least one piece of equipment to scr_debugHackEquipment");
        continue;
      }

      var_4 _id_735E(var_1);
    }

    waitframe();
  }
}

_id_44C8() {
  for(;;) {
    if(getdvarint("#x3b0f9d81f78017c05") != 0) {
      if(level.players.size < 2) {
        iprintlnbold("Need at least two players to scr_testEMPGrenade");
        continue;
      }

      var_0 = level.players[1];
      var_0 scripts\mp\utility\weapon::_id_0C48("emp_grenade_mp", (0, 0, 0), (0, 0, 0), 0.05, 0);
    }

    waitframe();
  }
}

_id_44C9() {
  for(;;) {
    if(getdvarint("#x3619c1edfbbb5b689") != 0) {
      if(level.players.size < 2) {
        iprintlnbold("Need at least two players to scr_testEMPDrone");
        continue;
      }

      var_0 = level.players[0];
      var_1 = level.players[1];
      var_2 = spawnStruct();
      var_2.streakname = "emp_drone";
      var_2.owner = var_1;
      var_2._id_7C8C = scripts\cp_mp\utility\killstreak_utility::_id_6E22(var_1);
      var_2._id_936C = 0;
      var_3 = var_0.origin;
      var_4 = var_1 _id_09B1::_id_5199(var_2, var_3);
    }

    waitframe();
  }
}

_id_44C5() {
  for(;;) {
    if(getdvarint("#x373b32b546fe85421") != 0) {
      foreach(var_1 in level._id_0F4C) {
        if(isDefined(var_1.streakinfo) && var_1.streakinfo.streakname == "emp_drone") {
          var_1 _id_09B0::_id_519B();
        }
      }
    }

    waitframe();
  }
}

initequipmentoob() {
  var_0 = getEntArray("trigger_hurt", "classname");

  if(isDefined(level._id_AD0F) && _func_0107(level._id_AD0F) && isDefined(var_0) && _func_0107(var_0)) {
    level.equipmentoutofboundstriggers = scripts\engine\utility::array_combine(level._id_AD0F, var_0);
  } else if(isDefined(var_0) && _func_0107(var_0)) {
    level.equipmentoutofboundstriggers = var_0;
  }
}

equipmentwatchoob(var_0) {
  self endon("death");

  for(;;) {
    if(equipmentistouchingoobtrigger()) {
      self[[var_0]]();
    }

    waitframe();
  }
}

equipmentistouchingoobtrigger() {
  if(!isDefined(level.equipmentoutofboundstriggers)) {
    return 0;
  }

  foreach(var_1 in level.equipmentoutofboundstriggers) {
    if(!scripts\mp\outofbounds::_id_83B3(var_1, self)) {
      continue;
    }
    if(self istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}