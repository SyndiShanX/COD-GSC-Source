/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1377.gsc
*********************************************/

init() {
  lib_0572::func_52A4();
  lib_0571::func_52A4();
  lib_056F::func_52A4();
  lib_0574::func_52A4();
  lib_057A::func_52A4();
  lib_0577::func_52A4();
  lib_0573::func_52A4();
  lib_0570::func_52A4();
  lib_0575::func_52A4();
  lib_0576::func_52A4();
  lib_0579::func_52A4();
  lib_0578::func_52A4();
  maps / mp / zombies / consumables / inv_giest_shield::func_52A4();
  maps / mp / zombies / consumables / inv_rng_ability::func_52A4();
  maps / mp / zombies / consumables / inv_armor::func_52A4();
}

initconsumablesfromtable(param_00, param_01, param_02, param_03) {
  var_04 = "mp/zombieConsumablesTable.csv";
  if(tableexists(var_04)) {
    for(var_05 = function_027A(var_04); var_05 >= 0; var_05 = var_06 - 1) {
      var_06 = tablelookuprownum(var_04, 6, param_00, var_05);
      var_07 = tablelookupbyrow(var_04, var_06, 0);
      var_08 = func_4471(var_07);
      var_09 = var_08[0];
      var_0A = var_08[1];
      if(var_09 != "none") {
        func_52A5(var_09, var_09, param_01, param_02, param_03);
      }
    }
  }
}

func_52A5(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(level.var_25A0)) {
    level.var_25A0 = [];
  }

  var_05 = spawnStruct();
  var_05.name = param_00;
  var_05.var_A20E = param_02;
  var_05.var_4459 = param_04;
  if(isDefined(param_03)) {
    var_05.var_1F7F = param_03;
  } else {
    var_05.var_1F7F = ::func_1F7B;
  }

  level.var_25A0[param_00] = var_05;
}

getconsumablerefrowintable(param_00) {
  var_01 = "mp/zombieConsumablesTable.csv";
  var_02 = -1;
  if(tableexists(var_01)) {
    var_02 = tablelookuprownum(var_01, 0, param_00);
  }

  return var_02;
}

func_4472(param_00) {
  if(param_00 == 0) {
    return "none";
  }

  return maps\mp\_utility::func_452B(param_00);
}

func_5332() {
  self notifyonplayercommand("useConsumable_upSlot", "+actionslot 1");
  self notifyonplayercommand("useConsumable_downSlot", "+actionslot 2");
  if(!common_scripts\utility::func_562E(level.var_8C8D)) {
    var_00 = level.var_25A0;
    var_01 = self getrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", 0, "ID");
    var_02 = self getrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", 0, "quantity");
    var_03 = func_4472(var_01);
    var_04 = func_4471(var_03);
    var_05 = var_04[0];
    var_06 = var_04[1];
    if(isDefined(level.var_25A0[var_05]) && var_02 > 0) {
      func_477D(var_03, var_05, var_06, "upSlot", var_01);
      setmatchdata("players", self.clientid, "loadout", "consumables", 0, var_01);
    }

    var_07 = self getrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", 1, "ID");
    var_08 = self getrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", 1, "quantity");
    var_09 = func_4472(var_07);
    var_0A = func_4471(var_09);
    var_0B = var_0A[0];
    var_0C = var_0A[1];
    if(isDefined(level.var_25A0[var_0B]) && var_08 > 0 && !var_01 == var_07 || var_08 > 1) {
      func_477D(var_09, var_0B, var_0C, "downSlot", var_07);
      setmatchdata("players", self.clientid, "loadout", "consumables", 1, var_07);
    }

    var_0D = self getrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", 2, "ID");
    var_0E = self getrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", 2, "quantity");
    if(var_0E > 0) {
      func_477D("consumable_zm_self_revive", "consumable_zm_self_revive", "common", "sReviveSlot", var_0D);
    }
  }

  self.var_A97F = 0;
  self setclientomnvar("ui_zm_can_use_consumable", 0);
  thread func_636D();
  thread func_A6DA();
}

func_636D() {
  level endon("game_over");
  self endon("disconnect");
  for(;;) {
    var_00 = common_scripts\utility::func_A70E(level, "zombie_wave_started", self, "begin_last_stand", self, "revive", self, "can_use_consumable");
    var_01 = var_00[0];
    var_02 = var_00[1];
    if(isDefined(var_01) && var_01 == "begin_last_stand") {
      self setclientomnvar("ui_zm_can_use_consumable", 0);
      continue;
    }

    self setclientomnvar("ui_zm_can_use_consumable", self.var_A97F < level.var_A980 && !lib_056A::isusingperkmachine());
  }
}

func_464C(param_00) {
  for(;;) {
    var_01 = common_scripts\utility::random(param_00);
    if(var_01.name == "self_revive") {
      param_00 = common_scripts\utility::func_F93(param_00, var_01);
      continue;
    }

    break;
  }

  return var_01;
}

func_4471(param_00) {
  var_01 = getsubstr(param_00, param_00.size - 2, param_00.size);
  var_02 = getsubstr(param_00, 0, param_00.size - 2);
  switch (var_01) {
    case "_c":
      return [var_02, "common"];

    case "_r":
      return [var_02, "rare"];

    case "_l":
      return [var_02, "legendary"];

    case "_e":
      return [var_02, "epic"];

    default:
      return ["none", "common"];
  }
}

func_477D(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(self.var_259F)) {
    self.var_259F = [];
  }

  var_05 = level.var_25A0[param_01];
  if(!isDefined(self.var_259F[param_03])) {
    self.var_259F[param_03] = spawnStruct();
  }

  self.var_259F[param_03].var_7B79 = param_00;
  self.var_259F[param_03].name = var_05.name;
  self.var_259F[param_03].type = param_02;
  self.var_259F[param_03].var_20F0 = [[var_05.var_4459]](self.var_259F[param_03].type);
  self.var_259F[param_03].var_7B7D = param_04;
  if(param_03 == "upSlot" || param_03 == "downSlot") {
    func_5FB3(param_03);
    self.var_259F[param_03].var_5501 = 1;
    return;
  }

  self.var_259F[param_03].var_5501 = 2;
}

func_477E(param_00, param_01) {
  var_02 = 0;
  if(isDefined(self.var_259F[param_00])) {
    var_02 = 1;
  }

  if(var_02) {
    var_03 = self.var_259F[param_00].name;
    var_04 = level.var_25A0[var_03];
    var_05 = [[var_04.var_4459]](self.var_259F[param_00].type);
    if(!isDefined(param_01)) {
      param_01 = var_05;
    }

    var_06 = param_01 + self.var_259F[param_00].var_20F0;
    var_06 = int(clamp(var_06, 0, var_05));
    self.var_259F[param_00].var_20F0 = var_06;
    func_A126(param_00);
  }
}

func_5FB3(param_00) {
  var_01 = self.var_259F[param_00].var_7B79;
  var_02 = self.var_259F[param_00].var_20F0;
  var_03 = getconsumablerefrowintable(var_01);
  if(param_00 == "upSlot") {
    self setclientomnvar("ui_zm_consumable_ref0", var_03);
    self setclientomnvar("ui_zm_consumable_count0", var_02);
    return;
  }

  if(param_00 == "downSlot") {
    self setclientomnvar("ui_zm_consumable_ref1", var_03);
    self setclientomnvar("ui_zm_consumable_count1", var_02);
    return;
  }
}

func_A126(param_00) {
  var_01 = self.var_259F[param_00].var_20F0;
  if(param_00 == "upSlot") {
    self setclientomnvar("ui_zm_consumable_count0", var_01);
    return;
  }

  if(param_00 == "downSlot") {
    self setclientomnvar("ui_zm_consumable_count1", var_01);
  }
}

func_A6DA() {
  level endon("game_over");
  self endon("disconnect");
  for(;;) {
    var_00 = common_scripts\utility::waittill_any_return("useConsumable_upSlot", "useConsumable_downSlot", "useConsumable_sReviveSlot", "death");
    if(var_00 == "death") {
      continue;
    }

    if(issubstr(var_00, "upSlot")) {
      childthread func_A201("upSlot");
      continue;
    }

    if(issubstr(var_00, "downSlot")) {
      childthread func_A201("downSlot");
      continue;
    }

    if(issubstr(var_00, "sReviveSlot")) {
      childthread func_A201("sReviveSlot");
    }
  }
}

func_4B5E(param_00) {
  if(!isDefined(self.var_259F)) {
    return [0, undefined];
  }

  if(!isDefined(param_00) || param_00 == "") {
    return [0, undefined];
  }

  if(isDefined(self.var_259F["upSlot"]) && self.var_259F["upSlot"].name == param_00) {
    return [1, "upSlot"];
  }

  if(isDefined(self.var_259F["downSlot"]) && self.var_259F["downSlot"].name == param_00) {
    return [1, "downSlot"];
  }

  if(isDefined(self.var_259F["sReviveSlot"]) && self.var_259F["sReviveSlot"].name == param_00) {
    return [1, "sReviveSlot"];
  }

  return [0, undefined];
}

func_4B5F(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(isDefined(self.var_259F) && isDefined(self.var_259F[param_00]) && self.var_259F[param_00].var_20F0 > 0) {
    return 1;
  }

  return 0;
}

func_1F7B() {
  if(isDefined(self.var_5378) && self.var_5378) {
    return 0;
  }

  if(lib_056A::isusingperkmachine()) {
    return 0;
  }

  if(self.var_A97F >= level.var_A980) {
    return 0;
  }

  return 1;
}

func_A201(param_00) {
  if(!func_4B5F(param_00)) {
    return;
  }

  var_01 = self.var_259F[param_00].name;
  if([[level.var_25A0[var_01].var_1F7F]](var_01)) {
    self.var_259F[param_00].var_20F0--;
    func_25A2(param_00);
    func_A126(param_00);
    self thread[[level.var_25A0[var_01].var_A20E]](param_00);
    if(isDefined(level.zmb_events_consumables_notify)) {
      level notify(level.zmb_events_consumables_notify);
    }

    level.var_400E[level.var_400E.size] = ["assassin_set 4 -1", self];
    level.var_400E[level.var_400E.size] = ["bat_elite_set 4 -1", self];
    self.var_A97F = level.var_A980;
    self notify("can_use_consumable");
  }
}

func_25A2(param_00) {
  if(getdvarint("709") == 1) {
    return;
  }

  if(!isDefined(self.var_259F[param_00])) {
    return;
  }

  if(isDefined(self.var_259F[param_00].var_5501) && self.var_259F[param_00].var_5501 == 0) {
    return;
  }

  var_01 = self.var_259F[param_00].var_7B7D;
  if(isDefined(var_01)) {
    self consumeinventoryitem(var_01);
  }

  self.var_259F[param_00].var_5501--;
  var_02 = -1;
  if(param_00 == "upSlot") {
    var_02 = 0;
  } else if(param_00 == "downSlot") {
    var_02 = 1;
  } else if(param_00 == "sReviveSlot") {
    var_02 = 2;
  }

  if(var_02 >= 0) {
    var_03 = self getrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", var_02, "quantity");
    var_04 = var_03 - 1;
    self setrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", var_02, "quantity", var_04);
    if(!var_04 && var_02 < 2) {
      self setrankedplayerdata(common_scripts\utility::func_46A8(), "equippedConsumables", var_02, "ID", 0);
    }
  }

  lib_0547::writeusedconsumable(self.var_259F[param_00].var_7B7D, self.clientid, self.origin);
}

func_AABA() {
  if(getdvarint("709") == 1) {
    return;
  }

  if(!isDefined(self.var_259F)) {
    return;
  }

  var_00 = ["upSlot", "downSlot"];
  foreach(var_02 in var_00) {
    if(!isDefined(self.var_259F[var_02])) {} else {
      var_03 = level.var_25A0[self.var_259F[var_02].name];
      var_04 = [[var_03.var_4459]](self.var_259F[var_02].type);
      if(self.var_259F[var_02].var_20F0 != var_04) {}
    }
  }
}

notifywallbuytriggers() {
  if(common_scripts\utility::func_562E(level.reworkedconsumabledenabled)) {
    if(isDefined(self.claimedwbtriggers)) {
      foreach(var_01 in self.claimedwbtriggers) {
        var_01 notify("modify_wallbuy_data", self);
      }
    }
  }
}