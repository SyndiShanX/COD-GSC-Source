/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1377.gsc
**************************************/

init() {
  _id_0572::_id_52A4();
  _id_0571::_id_52A4();
  _id_056F::_id_52A4();
  _id_0574::_id_52A4();
  _id_057A::_id_52A4();
  _id_0577::_id_52A4();
  _id_0573::_id_52A4();
  _id_0570::_id_52A4();
  _id_0575::_id_52A4();
  _id_0576::_id_52A4();
  _id_0579::_id_52A4();
  _id_0578::_id_52A4();
  maps\mp\zombies\consumables\inv_giest_shield::_id_52A4();
  maps\mp\zombies\consumables\inv_rng_ability::_id_52A4();
  maps\mp\zombies\consumables\inv_armor::_id_52A4();
}

initconsumablesfromtable(var_0, var_1, var_2, var_3) {
  var_4 = "mp/zombieConsumablesTable.csv";

  if(_func_1B2(var_4)) {
    for(var_5 = _func_27A(var_4); var_5 >= 0; var_5 = var_6 - 1) {
      var_6 = _func_1B1(var_4, 6, var_0, var_5);
      var_7 = _func_1AE(var_4, var_6, 0);
      [var_9, var_10] = _id_4471(var_7);

      if(var_9 != "none")
        _id_52A5(var_9, var_9, var_1, var_2, var_3);
    }
  }
}

_id_52A5(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_25A0))
    level._id_25A0 = [];

  var_5 = spawnStruct();
  var_5.name = var_0;
  var_5._id_A20E = var_2;
  var_5._id_4459 = var_4;

  if(isDefined(var_3))
    var_5._id_1F7F = var_3;
  else
    var_5._id_1F7F = ::_id_1F7B;

  level._id_25A0[var_0] = var_5;
}

getconsumablerefrowintable(var_0) {
  var_1 = "mp/zombieConsumablesTable.csv";
  var_2 = -1;

  if(_func_1B2(var_1))
    var_2 = _func_1B1(var_1, 0, var_0);

  return var_2;
}

_id_4472(var_0) {
  if(var_0 == 0)
    return "none";
  else
    return maps\mp\_utility::_id_452B(var_0);
}

_id_5332() {
  self _meth_82E1("useConsumable_upSlot", "+actionslot 1");
  self _meth_82E1("useConsumable_downSlot", "+actionslot 2");

  if(!common_scripts\utility::_id_562E(level._id_8C8D)) {
    var_0 = level._id_25A0;
    var_1 = self getplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", 0, "ID");
    var_2 = self getplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", 0, "quantity");
    var_3 = _id_4472(var_1);
    [var_5, var_6] = _id_4471(var_3);

    if(isDefined(level._id_25A0[var_5]) && var_2 > 0) {
      _id_477D(var_3, var_5, var_6, "upSlot", var_1);
      setmatchdata("players", self.clientid, "loadout", "consumables", 0, var_1);
    }

    var_7 = self getplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", 1, "ID");
    var_8 = self getplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", 1, "quantity");
    var_9 = _id_4472(var_7);
    [var_11, var_12] = _id_4471(var_9);

    if(isDefined(level._id_25A0[var_11]) && var_8 > 0 && (!(var_1 == var_7) || var_8 > 1)) {
      _id_477D(var_9, var_11, var_12, "downSlot", var_7);
      setmatchdata("players", self.clientid, "loadout", "consumables", 1, var_7);
    }

    var_13 = self getplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", 2, "ID");
    var_14 = self getplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", 2, "quantity");

    if(var_14 > 0)
      _id_477D("consumable_zm_self_revive", "consumable_zm_self_revive", "common", "sReviveSlot", var_13);
  }

  self._id_A97F = 0;
  self _meth_82FF("ui_zm_can_use_consumable", 0);
  thread _id_636D();
  thread _id_A6DA();
}

_id_636D() {
  level endon("game_over");
  self endon("disconnect");

  for(;;) {
    [var_1, var_2] = common_scripts\utility::_id_A70E(level, "zombie_wave_started", self, "begin_last_stand", self, "revive", self, "can_use_consumable");

    if(isDefined(var_1) && var_1 == "begin_last_stand") {
      self _meth_82FF("ui_zm_can_use_consumable", 0);
      continue;
    }

    self _meth_82FF("ui_zm_can_use_consumable", self._id_A97F < level._id_A980 && !_id_056A::isusingperkmachine());
  }
}

_id_464C(var_0) {
  for(;;) {
    var_1 = common_scripts\utility::random(var_0);

    if(var_1.name == "self_revive") {
      var_0 = common_scripts\utility::_id_0F93(var_0, var_1);
      continue;
    }

    break;
  }

  return var_1;
}

_id_4471(var_0) {
  var_1 = getsubstr(var_0, var_0.size - 2, var_0.size);
  var_2 = getsubstr(var_0, 0, var_0.size - 2);

  switch (var_1) {
    case "_c":
      return [var_2, "common"];
    case "_r":
      return [var_2, "rare"];
    case "_l":
      return [var_2, "legendary"];
    case "_e":
      return [var_2, "epic"];
    default:
      return ["none", "common"];
  }
}

_id_477D(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._id_259F))
    self._id_259F = [];

  var_5 = level._id_25A0[var_1];

  if(!isDefined(self._id_259F[var_3]))
    self._id_259F[var_3] = spawnStruct();

  self._id_259F[var_3]._id_7B79 = var_0;
  self._id_259F[var_3].name = var_5.name;
  self._id_259F[var_3].type = var_2;
  self._id_259F[var_3]._id_20F0 = [[var_5._id_4459]](self._id_259F[var_3].type);
  self._id_259F[var_3]._id_7B7D = var_4;

  if(var_3 == "upSlot" || var_3 == "downSlot") {
    _id_5FB3(var_3);
    self._id_259F[var_3]._id_5501 = 1;
  } else
    self._id_259F[var_3]._id_5501 = 2;
}

_id_477E(var_0, var_1) {
  var_2 = 0;

  if(isDefined(self._id_259F[var_0]))
    var_2 = 1;

  if(var_2) {
    var_3 = self._id_259F[var_0].name;
    var_4 = level._id_25A0[var_3];
    var_5 = [[var_4._id_4459]](self._id_259F[var_0].type);

    if(!isDefined(var_1))
      var_1 = var_5;

    var_6 = var_1 + self._id_259F[var_0]._id_20F0;
    var_6 = int(clamp(var_6, 0, var_5));
    self._id_259F[var_0]._id_20F0 = var_6;
    _id_A126(var_0);
  }
}

_id_5FB3(var_0) {
  var_1 = self._id_259F[var_0]._id_7B79;
  var_2 = self._id_259F[var_0]._id_20F0;
  var_3 = getconsumablerefrowintable(var_1);

  if(var_0 == "upSlot") {
    self _meth_82FF("ui_zm_consumable_ref0", var_3);
    self _meth_82FF("ui_zm_consumable_count0", var_2);
    return;
  } else if(var_0 == "downSlot") {
    self _meth_82FF("ui_zm_consumable_ref1", var_3);
    self _meth_82FF("ui_zm_consumable_count1", var_2);
    return;
  }
}

_id_A126(var_0) {
  var_1 = self._id_259F[var_0]._id_20F0;

  if(var_0 == "upSlot")
    self _meth_82FF("ui_zm_consumable_count0", var_1);
  else if(var_0 == "downSlot")
    self _meth_82FF("ui_zm_consumable_count1", var_1);
}

_id_A6DA() {
  level endon("game_over");
  self endon("disconnect");

  for(;;) {
    var_0 = common_scripts\utility::_id_A715("useConsumable_upSlot", "useConsumable_downSlot", "useConsumable_sReviveSlot", "death");

    if(var_0 == "death") {
      continue;
    }
    if(issubstr(var_0, "upSlot")) {
      childthread _id_A201("upSlot");
      continue;
    }

    if(issubstr(var_0, "downSlot")) {
      childthread _id_A201("downSlot");
      continue;
    }

    if(issubstr(var_0, "sReviveSlot"))
      childthread _id_A201("sReviveSlot");
  }
}

_id_4B5E(var_0) {
  if(!isDefined(self._id_259F))
    return [0, undefined];

  if(!isDefined(var_0) || var_0 == "")
    return [0, undefined];

  if(isDefined(self._id_259F["upSlot"]) && self._id_259F["upSlot"].name == var_0)
    return [1, "upSlot"];

  if(isDefined(self._id_259F["downSlot"]) && self._id_259F["downSlot"].name == var_0)
    return [1, "downSlot"];

  if(isDefined(self._id_259F["sReviveSlot"]) && self._id_259F["sReviveSlot"].name == var_0)
    return [1, "sReviveSlot"];

  return [0, undefined];
}

_id_4B5F(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(self._id_259F) && isDefined(self._id_259F[var_0]) && self._id_259F[var_0]._id_20F0 > 0)
    return 1;

  return 0;
}

_id_1F7B() {
  if(isDefined(self._id_5378) && self._id_5378)
    return 0;

  if(_id_056A::isusingperkmachine())
    return 0;

  if(self._id_A97F >= level._id_A980)
    return 0;

  return 1;
}

_id_A201(var_0) {
  if(!_id_4B5F(var_0)) {
    return;
  }
  var_1 = self._id_259F[var_0].name;

  if([[level._id_25A0[var_1]._id_1F7F]](var_1)) {
    self._id_259F[var_0]._id_20F0--;
    _id_25A2(var_0);
    _id_A126(var_0);
    self thread[[level._id_25A0[var_1]._id_A20E]](var_0);

    if(isDefined(level.zmb_events_consumables_notify))
      level notify(level.zmb_events_consumables_notify);

    level._id_400E[level._id_400E.size] = ["assassin_set 4 -1", self];
    level._id_400E[level._id_400E.size] = ["bat_elite_set 4 -1", self];
    self._id_A97F = level._id_A980;
    self notify("can_use_consumable");
  }
}

_id_25A2(var_0) {
  if(getdvarint("709") == 1) {
    return;
  }
  if(!isDefined(self._id_259F[var_0])) {
    return;
  }
  if(isDefined(self._id_259F[var_0]._id_5501) && self._id_259F[var_0]._id_5501 == 0) {
    return;
  }
  var_1 = self._id_259F[var_0]._id_7B7D;

  if(isDefined(var_1))
    self _meth_868C(var_1);

  self._id_259F[var_0]._id_5501--;
  var_2 = -1;

  if(var_0 == "upSlot")
    var_2 = 0;
  else if(var_0 == "downSlot")
    var_2 = 1;
  else if(var_0 == "sReviveSlot")
    var_2 = 2;

  if(var_2 >= 0) {
    var_3 = self getplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", var_2, "quantity");
    var_4 = var_3 - 1;
    self setplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", var_2, "quantity", var_4);

    if(!var_4 && var_2 < 2)
      self setplayerdata(common_scripts\utility::_id_46A8(), "equippedConsumables", var_2, "ID", 0);
  }

  _id_0547::writeusedconsumable(self._id_259F[var_0]._id_7B7D, self.clientid, self.origin);
}

_id_AABA() {
  if(getdvarint("709") == 1) {
    return;
  }
  if(!isDefined(self._id_259F)) {
    return;
  }
  var_0 = ["upSlot", "downSlot"];

  foreach(var_2 in var_0) {
    if(!isDefined(self._id_259F[var_2])) {
      continue;
    }
    var_3 = level._id_25A0[self._id_259F[var_2].name];
    var_4 = [[var_3._id_4459]](self._id_259F[var_2].type);

    if(self._id_259F[var_2]._id_20F0 != var_4) {}
  }
}

notifywallbuytriggers() {
  if(common_scripts\utility::_id_562E(level.reworkedconsumabledenabled)) {
    if(isDefined(self.claimedwbtriggers)) {
      foreach(var_1 in self.claimedwbtriggers)
      var_1 notify("modify_wallbuy_data", self);
    }
  }
}