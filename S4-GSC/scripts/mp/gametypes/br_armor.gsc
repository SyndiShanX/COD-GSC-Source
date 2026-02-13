/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_armor.gsc
*************************************************/

main() {
  level._id_AAFF = ::_id_AAFF;
}

_id_813B() {
  self._id_2A0E = 0;
  self._id_7548 = 0;
  self._id_2A7D = 150;
  self setclientomnvar("ui_br_armor_damage", 0);
  scripts\mp\gametypes\br_public::_id_FC1A("armorHealthRatio", 0);
}

_id_6BCC(var_0) {
  var_1 = spawnStruct();
  var_1._id_011A = 1;
  var_1._id_9C5F = 1;
  var_1._id_E503 = 1;

  if(scripts\mp\gametypes\br_public::_id_889B(var_0._id_CF22)) {} else if(scripts\mp\gametypes\br_pickups::_id_8879(var_0._id_CF22))
    var_1._id_61D5 = self._id_61D5;
  else {
    var_1._id_1B53 = self._id_2A0E;
  }

  return var_1;
}

_id_780B(var_0) {
  switch (var_0) {
    case 1:
      return "brloot_armor_helmet_1";
    case 2:
      return "brloot_armor_helmet_2";
    case 3:
      return "brloot_armor_helmet_3";
  }

  return undefined;
}

_id_6FF3() {
  var_0 = 100;

  if(getdvarint("#x395344732688f8bdc", 0)) {
    var_0 = 150;
  }

  if(istrue(self._id_7548)) {
    self._id_7548 = 0;
  }

  _id_6F82(var_0);
}

_id_6F82(var_0) {
  if(!isDefined(var_0) || var_0 <= 0) {
    return;
  }
  self._id_2A0E = var_0;
  self._id_2A7D = 150;
  var_1 = self._id_2A0E / self._id_2A7D;
  self setclientomnvar("ui_br_armor_damage", var_1);
  scripts\mp\gametypes\br_public::_id_FC1A("armorHealthRatio", int(self._id_2A0E));
}

_id_EDC5(var_0, var_1) {
  self._id_2A5A = var_1;
  var_2 = level._id_2A95._id_2A66[var_0._id_CF22];
  self setclientomnvar("ui_br_helmet_class", var_2);

  if(self._id_2A5A == 3) {
    scripts\mp\utility\perk::_id_6FC2("specialty_stun_resistance");
  }

  self setclientomnvar("ui_br_helmet_damage", 1);
}

_id_2B95() {
  if(scripts\mp\gametypes\br_public::_id_753A()) {
    scripts\mp\gametypes\br_public::_id_42E2(self._id_2A0E, 1);
  }
}

_id_8762(var_0) {
  var_1 = 0;

  if(var_0 == "equip_helmet_1") {
    var_1 = 1;
  } else if(var_0 == "equip_helmet_2") {
    var_1 = 2;
  } else if(var_0 == "equip_helmet_3") {
    var_1 = 3;
  }

  if(var_1 > 0) {
    if(!isDefined(self._id_2A5A) || self._id_2A5A < var_1) {
      return 1;
    }
  }

  return 0;
}

_id_B9E4(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = self gettagorigin("j_helmet");

  if(!isDefined(var_3)) {
    var_3 = var_2 + (0, 0, 80);
  }

  var_4 = spawn("script_model", self gettagorigin("j_helmet"));
  var_4 setModel("loot_helmet");
  var_4.angles = var_1;
  var_5 = anglestoup(var_1);
  var_6 = var_0;
  var_7 = vectornormalize(var_6 + var_5) * 2500;
  var_4 physicslaunchserver(var_4.origin, var_7);
  var_8 = "brloot_armor_helmet_" + self._id_2A5A;
  var_9 = 15;
  var_10 = 0.1;
  var_9 = var_9 * (1 / var_10);
  var_11 = var_4.origin;

  for(var_12 = 0; var_12 < var_9; var_12++) {
    wait(var_10);
    var_13 = var_11 - var_4.origin;

    if(var_13[0] < 2 && var_13[1] < 2 && var_13[2] < 2 && var_13[0] > -2 && var_13[1] > -2 && var_13[2] > -2) {
      var_14 = var_4.origin;
      var_15 = var_4.angles;
      var_4 delete();
      var_16 = scripts\mp\gametypes\br_pickups::_id_E336(var_8, var_14, var_15);
      var_16._id_011A = 1;
      return;
    }

    var_11 = var_4.origin;
  }

  var_4 delete();
}

_id_AAFF(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 thread _id_B9E4(var_1, var_0.angles, var_0.origin);
  }
}