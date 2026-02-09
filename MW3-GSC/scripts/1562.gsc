/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1562.gsc
**************************************/

_id_3D23() {
  for(var_0 = 0; var_0 <= 20; var_0++) {
    var_1 = _id_3D35(var_0);

    if(isDefined(var_1) && _id_3D37(var_1) == "weapon") {
      _id_0618::_id_3D24(var_1);
    }
  }

  for(var_0 = 100; var_0 <= 199; var_0++) {
    var_2 = _id_3D3E(var_0);

    if(isDefined(var_2)) {
      _id_0618::_id_3D24(var_2);
    }
  }
}

_id_3D25() {}

_id_3D26() {
  _id_3D27(0, 20, 100, 199);
}

_id_3D27(var_0, var_1, var_2, var_3) {
  level._id_3D28 = [];

  for(var_4 = var_2; var_4 <= var_3; var_4++) {
    var_5 = _id_3D3E(var_4);

    if(isDefined(var_5) && var_5 != "") {
      level._id_3D28[level._id_3D28.size] = var_5;
    }
  }

  level._id_3D29 = [];

  for(var_4 = var_0; var_4 <= var_1; var_4++) {
    var_6 = _id_3D35(var_4);

    if(!isDefined(var_6) || var_6 == "") {
      continue;
    }
    var_7 = _id_3D37(var_6);

    if(!isDefined(level._id_3D29[var_7])) {
      level._id_3D29[var_7] = [];
    }
    var_8 = spawnStruct();
    var_8.index = var_4;
    var_8._id_160B = var_6;
    var_8.type = var_7;
    var_8.name = _id_3D38(var_6);
    var_8._id_189B = _id_3D39(var_6);
    var_8._id_3D2A = _id_3D3A(var_6);
    var_8._id_3D2B = _id_3D3B(var_6);
    var_8._id_3D2C = _id_3D3C(var_6);
    var_8._id_3D2D = -999;
    var_8._id_3D2E = _id_3D3D(var_6);
    var_8._id_3D2F = _id_3D3F(var_6);
    level._id_3D29[var_7][var_6] = var_8;
  }
}

_id_3D30(var_0) {
  if(!isDefined(level._id_3D29) || !isDefined(level._id_3D29["weapon"])) {
    return 0;
  }
  var_1 = [];

  foreach(var_3 in level._id_3D29["weapon"]) {
    if(level._id_17F6 >= var_3._id_3D2B && level._id_17F6 < var_3._id_3D2C && level._id_17F6 - var_3._id_3D2D >= 2 && _id_0618::_id_3D31() >= var_3._id_3D2E) {
      var_1[var_1.size] = var_3;
    }
  }

  if(!var_1.size) {
    return 0;
  }
  var_1 = _id_060F::_id_3B69(var_1, ::_id_3D32);
  var_5 = undefined;

  foreach(var_3 in var_1) {
    var_7 = common_scripts\utility::ter_op(isDefined(var_0), var_0, var_3._id_3D2A);

    if(var_7 > randomfloatrange(0.0, 1.0)) {
      var_5 = var_3._id_3D2F[randomint(var_3._id_3D2F.size)];
      var_3._id_3D2D = level._id_17F6;
      break;
    }
  }

  if(isDefined(var_5)) {
    var_9 = var_5;
    var_10 = getweaponmodel(var_9);
    self.dropweapon = 0;
    thread _id_3D33("weapon_" + var_9, var_9, "weapon", var_10, "tag_stowed_back");
    return 1;
  }

  return 0;
}

_id_3D32() {
  var_0 = common_scripts\utility::ter_op(isDefined(self) && isDefined(self._id_3D2D), self._id_3D2D, -999);
  return var_0;
}

_id_3D33(var_0, var_1, var_2, var_3, var_4) {
  level endon("special_op_terminated");
  var_5 = spawn("script_model", self gettagorigin(var_4));
  var_5 setModel(var_3);
  var_5 linkto(self, var_4, (0, 0, 0), (0, 0, 0));
  common_scripts\utility::waittill_any("death", "long_death");

  if(!isDefined(self)) {
    return;
  }
  var_6 = spawn(var_0, self gettagorigin(var_4));

  if(isDefined(var_2) && var_2 == "weapon") {
    var_7 = int(max(1, 0.4 * weaponclipsize(var_1)));
    var_8 = int(max(1, 0.5 * weaponmaxammo(var_1)));
    var_6 itemweaponsetammo(var_7, var_8);
    var_9 = weaponaltweaponname(var_1);

    if(var_9 != "none") {
      var_10 = int(max(1, 0.5 * weaponclipsize(var_9)));
      var_11 = int(max(1, 0.5 * weaponmaxammo(var_9)));
      var_6 itemweaponsetammo(var_10, var_11, var_10, 1);
    }
  }

  var_5 unlink();
  wait 0.05;
  var_5 delete();
}

_id_3D34(var_0) {
  return isDefined(level._id_3D29) && isDefined(level._id_3D29[var_0]);
}

_id_3D35(var_0) {
  return _id_3D36(var_0);
}

_id_3D36(var_0) {
  return tablelookup("sp/survival_loot.csv", 0, var_0, 1);
}

_id_3D37(var_0) {
  if(_id_3D34(var_0)) {
    return level._id_3D29[var_0].type;
  }
  return tablelookup("sp/survival_loot.csv", 1, var_0, 2);
}

_id_3D38(var_0) {
  if(_id_3D34(var_0)) {
    return level._id_3D29[var_0].name;
  }
  return tablelookup("sp/survival_loot.csv", 1, var_0, 3);
}

_id_3D39(var_0) {
  if(_id_3D34(var_0)) {
    return level._id_3D29[var_0]._id_189B;
  }
  return tablelookup("sp/survival_loot.csv", 1, var_0, 4);
}

_id_3D3A(var_0) {
  if(_id_3D34(var_0)) {
    return level._id_3D29[var_0]._id_3D2A;
  }
  return float(tablelookup("sp/survival_loot.csv", 1, var_0, 5));
}

_id_3D3B(var_0) {
  if(_id_3D34(var_0)) {
    return level._id_3D29[var_0]._id_3D2B;
  }
  return int(tablelookup("sp/survival_loot.csv", 1, var_0, 6));
}

_id_3D3C(var_0) {
  if(_id_3D34(var_0)) {
    return level._id_3D29[var_0]._id_3D2C;
  }
  return int(tablelookup("sp/survival_loot.csv", 1, var_0, 7));
}

_id_3D3D(var_0) {
  if(_id_3D34(var_0)) {
    return level._id_3D29[var_0]._id_3D2E;
  }
  return int(tablelookup("sp/survival_loot.csv", 1, var_0, 8));
}

_id_3D3E(var_0) {
  return _id_3D36(var_0);
}

_id_3D3F(var_0) {
  if(_id_3D34(var_0)) {
    return level._id_3D29[var_0]._id_3D2F;
  }
  var_1 = "joe";
  var_2 = [];
  var_3 = var_0;

  if(_id_3D37(var_0) == "weapon") {
    var_3 = getsubstr(var_0, 0, var_0.size - 3);
  }
  foreach(var_5 in level._id_3D28) {
    if(issubstr(var_5, var_3)) {
      var_2[var_2.size] = var_5;
    }
  }

  if(!var_2.size) {
    var_2[var_2.size] = var_0;
  }
  return var_2;
}