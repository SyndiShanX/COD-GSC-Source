/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3635.gsc
**************************************/

_id_8CFA() {
  precacheshader("hud_ar57");
  precacheshader("weapon_kac");
  precacheshader("hud_erad");
  precacheshader("weapon_p226");
  level._id_8CEE = ["steel_dragon"];
  level.player._id_8CED = undefined;
  level.player._id_1030C = undefined;
  level.player thread _id_8CFB();
  level.player thread _id_8CF5();
  level.player disableweaponswitch();
  level.player notifyonplayercommand("weapnext", "+weapnext");
  setdvarifuninitialized("heavy_slot_hud", 1);
  setdvarifuninitialized("heavy_slot_hud_heavyhanded", 1);
  level.player scripts\sp\utility::_id_65E0("player_heavy_weapon_active");
  scripts\sp\utility::_id_16EB("heavy_weapon_slot_hint", "HOLD ^3[{+weapnext}]^7 TO USE HEAVY WEAPON", ::_id_8CF9);
}

_id_82D7(var_0) {
  self._id_8CED = var_0;
  self giveweapon(var_0);
  self notify("give_heavy_weapon");
}

_id_8CF5() {
  var_0 = "none";

  for(;;) {
    self waittill("pickup");
    self waittill("weapon_change");
    var_1 = self getcurrentweapon();

    if(scripts\engine\utility::array_contains(level._id_8CEE, var_1)) {
      self._id_8CED = var_1;
      self notify("give_heavy_weapon");
    }

    var_0 = var_1;
  }
}

_id_834B(var_0, var_1) {}

_id_8CFB(var_0) {
  self endon("death");

  for(;;) {
    childthread _id_8CEF();
    var_1 = scripts\engine\utility::waittill_any_return("give_heavy_weapon", "give_next_weapon");

    if(!self _meth_843C()) {
      continue;
    }
    if(var_1 == "give_heavy_weapon") {
      if(!isDefined(self._id_8CED)) {
        continue;
      }
      level.player scripts\sp\utility::_id_65E1("player_heavy_weapon_active");
      var_2 = self getcurrentweapon();
      self._id_1030C = var_2;
      self switchtoweaponimmediate(self._id_8CED);
      self waittill("weapnext");
      level.player scripts\sp\utility::_id_65DD("player_heavy_weapon_active");
      self switchtoweaponimmediate(var_2);
    } else {
      if(isDefined(self._id_8CED) && isDefined(self._id_8D0B))
        self._id_8D0B[self._id_8CED]._id_9070 scripts\sp\hud_util::updatebar(0);

      var_3 = self getweaponslistprimaries();

      foreach(var_5 in var_3) {
        if(scripts\engine\utility::array_contains(level._id_8CEE, var_5)) {
          continue;
        }
        if(var_5 != self getcurrentweapon()) {
          if(isDefined(self._id_8CED) && var_5 == self._id_8CED) {
            continue;
          }
          self switchtoweaponimmediate(var_5);
          break;
        }
      }
    }

    while(self buttonPressed("BUTTON_Y"))
      scripts\engine\utility::waitframe();
  }
}

_id_8CEF() {
  self endon("give_heavy_weapon");

  if(isDefined(self._id_8CED) && isDefined(self._id_8D0B)) {
    self._id_8D0B[self._id_8CED]._id_9070 scripts\sp\hud_util::updatebar(0);
    self._id_8D0B[self._id_8CED]._id_9070 _id_9071(0);
  }

  self waittill("weapnext");

  if(isDefined(self._id_8CED) && self getcurrentweapon() != self._id_8CED) {
    childthread _id_C137();

    while(self buttonPressed("BUTTON_Y"))
      scripts\engine\utility::waitframe();
  }

  self notify("give_next_weapon");
}

_id_C137() {
  self endon("give_next_weapon");
  wait 0.15;

  if(isDefined(self._id_8D0B))
    self._id_8D0B[self._id_8CED] _id_9071(0.8);

  var_0 = 0.2;
  var_0 = var_0 * 1000;
  var_1 = gettime();

  while(gettime() - var_1 <= var_0) {
    var_2 = gettime() - var_1;
    var_3 = var_2 / var_0;

    if(isDefined(self._id_8D0B))
      self._id_8D0B[self._id_8CED] scripts\sp\hud_util::updatebar(var_3);

    wait 0.05;
  }

  self notify("give_heavy_weapon");
}

_id_8CF0() {
  var_0 = _id_7A28();
  var_1 = [];
  var_2 = [190, 255, 220];
  var_3 = [170, 170, 200];
  var_4 = 285;
  var_5 = 90;
  var_6 = [0, 65, 30];
  var_2 = [];

  foreach(var_9, var_8 in var_6)
  var_2[var_9] = var_4 + var_8;

  var_6 = [0, 0, 30];
  var_3 = [];

  foreach(var_9, var_8 in var_6)
  var_3[var_9] = var_5 + var_8;

  var_11 = level.player getweaponslistprimaries();

  for(var_9 = 0; var_9 < 3; var_9++) {
    var_12 = undefined;

    if(isDefined(var_11[var_9])) {
      var_13 = strtok(var_11[var_9], "+");
      var_12 = var_13[0];
    }

    var_14 = 0.3;
    var_15 = 60;
    var_16 = "hud_ar57";

    if(isDefined(var_12) && isDefined(var_0[var_12]))
      var_16 = var_0[var_12];

    var_17 = level.player scripts\sp\hud_util::createicon(var_16, var_15, int(var_15 / 2));
    var_17 scripts\sp\hud_util::setpoint("CENTER", "CENTER", var_2[var_9], var_3[var_9]);
    var_17.alpha = var_14;

    if(var_9 == 2) {
      var_17._id_8D0A = 1;
      var_18 = level.player scripts\sp\hud_util::_id_4997("white", "black", 70, 5);
      var_18 scripts\sp\hud_util::setpoint("CENTER", "CENTER", var_2[var_9], var_3[var_9] + 15);
      var_18 _id_9071(var_14);
      var_18 scripts\sp\hud_util::updatebar(1);
      var_17._id_9070 = var_18;
    }

    if(!isDefined(var_12)) {
      var_17.alpha = 0;

      if(isDefined(var_17._id_9070))
        var_17._id_9070 _id_9071(0.3);

      var_17._id_13CFB = "undefined";
      var_1["undefined"] = var_17;
      continue;
    }

    var_17._id_13CFB = var_12;
    var_1[var_12] = var_17;
  }

  thread _id_8CF3();
  level.player._id_8D0B = var_1;
}

_id_9071(var_0) {
  self.alpha = var_0;
  self.bar.alpha = var_0;
}

_id_8CF3() {
  level.player endon("death");
  var_0 = "none";

  for(;;) {
    while(level.player getcurrentweapon() == "none")
      wait 0.05;

    var_1 = level.player getcurrentweapon();

    while(var_1 == var_0) {
      var_1 = level.player getcurrentweapon();
      wait 0.05;
    }

    _id_8CF2(var_1);
    var_0 = var_1;
    level.player scripts\engine\utility::waittill_any("weapon_change", "pickup");
  }
}

_id_8CF4() {
  level.player endon("death");

  for(;;) {
    level.player waittill("pickup");
    var_0 = _id_8CF1();
    _id_8CF2(var_0);
  }
}

_id_8CF2(var_0) {
  var_1 = strtok(var_0, "+");
  var_0 = var_1[0];

  if(!isDefined(level.player._id_8D0B)) {
    return;
  }
  if(!isDefined(level.player._id_8D0B[var_0]))
    _id_8CF1(var_0);

  var_2 = _id_7A28();
  var_3 = _id_7BFC();

  foreach(var_5 in var_3) {
    var_6 = 0.4;
    var_7 = 60;

    if(var_0 == var_5) {
      var_6 = 1;
      var_7 = 80;
    }

    var_8 = "hud_ar57";

    if(isDefined(var_2[var_5]))
      var_8 = var_2[var_5];

    level.player._id_8D0B[var_5] setshader(var_8, var_7, int(var_7 / 2));
    level.player._id_8D0B[var_5].alpha = var_6;

    if(isDefined(level.player._id_8D0B[var_5]._id_9070)) {
      if(var_0 == var_5)
        level.player._id_8D0B[var_5]._id_9070 _id_9071(0);
    }
  }
}

_id_8CF1(var_0) {
  var_1 = _id_7BFC();
  var_2 = _id_7A28();
  var_3 = undefined;

  foreach(var_5 in level.player._id_8D0B) {
    if(var_0 == "steel_dragon") {
      var_3 = "undefined";
      break;
    }

    if(var_5._id_13CFB == "undefined") {
      continue;
    }
    if(!scripts\engine\utility::array_contains(var_1, var_5._id_13CFB))
      var_3 = var_5._id_13CFB;
  }

  level.player._id_8D0B[var_0] = level.player._id_8D0B[var_3];
  level.player._id_8D0B[var_0]._id_13CFB = var_0;
  level.player._id_8D0B[var_3] = undefined;
  return var_0;
}

_id_7BFC() {
  var_0 = level.player getweaponslistprimaries();
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = strtok(var_3, "+");
    var_1 = scripts\engine\utility::array_add(var_1, var_4[0]);
  }

  return var_1;
}

_id_7A28() {
  var_0 = [];
  var_0["iw7_ar57"] = "hud_ar57";
  var_0["iw7_erad"] = "hud_erad";
  var_0["p226"] = "weapon_p226";
  var_0["steel_dragon"] = "weapon_kac";
  return var_0;
}

_id_8CF9() {
  if(level.player scripts\sp\utility::_id_65DB("player_heavy_weapon_active"))
    return 1;

  return 0;
}