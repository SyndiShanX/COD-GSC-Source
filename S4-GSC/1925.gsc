/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1925.gsc
*************************************************/

_id_6871() {
  return _id_459B(level._id_11049, 1);
}

_giveweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = -1;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = undefined;

  if(isweapon(var_0)) {
    var_4 = var_0;
  } else {
    var_4 = scripts\cp\cp_weapon::buildweapon(var_0);
  }

  if(var_4 _meth_8624("akimbo", 1) || var_4 _meth_8624("g18pap2", 1) || isDefined(var_2) && var_2 == 1) {
    self giveweapon(var_4, var_1, 1, -1, var_3);
  } else {
    self giveweapon(var_4, var_1, 0, -1, var_3);
  }

  thread _id_FC9F(var_4);
  return var_4;
}

_id_D675() {
  if(!isDefined(self._id_8A6C)) {
    self._id_8A6C = 1;
  } else {
    self._id_8A6C++;
  }
}

_id_10964() {
  wait 0.5;

  for(;;) {
    var_0 = self _meth_846E(0);
    var_1 = _func_02A1(var_0);

    if(_func_0135(var_1) > 0.5) {
      wait 0.1;
      continue;
    }

    break;
  }

  self _meth_8545();
}

_id_D679() {
  self._id_8A6C--;
}

_id_D85F(var_0) {
  var_0 endon("disconnect");

  if(scripts\engine\utility::_id_5C0C("infil_complete")) {
    scripts\engine\utility::_id_5C24("infil_complete");
  }

  wait 1;
  var_1 = getent("playable_area", "targetname");
  var_2 = getent("boundary_toxic_line", "targetname");
  var_3 = isDefined(var_1);
  var_4 = getDvar("#x36d16f02578d0ee10");
  var_5 = getDvar("#x3a30c33efc8281eb1");
  var_0._id_8F26 = undefined;
  var_0._id_AD07 = 1;
  var_6 = undefined;

  if(var_5 == "cp_strike") {
    var_7 = "abandon_mission";
  } else {
    var_7 = "turn_back";
  }

  for(;;) {
    var_8 = 0;

    if(var_3) {
      var_8 = var_0 istouching(var_1);
    } else {
      var_8 = !var_0 istouching(var_2);
    }

    var_9 = var_0 isonground();
    var_10 = var_0 isonladder();
    var_11 = _id_073B::_id_B4EF(var_0);

    if(!var_9 || var_11 || var_10) {
      wait 0.5;
      continue;
    }

    if(var_8) {
      var_0._id_8F26 = var_0.origin;
      var_6 = undefined;

      if(var_0._id_AD07) {
        var_0 thread _id_7970(var_7, 0);
      }

      var_0._id_AD07 = 0;
    } else if(!var_0._id_AD07) {
      var_0 thread _id_7970(var_7, 1);
      var_0._id_AD07 = 1;
      var_6 = gettime() + 5000;
    } else if(isDefined(var_6) && gettime() > var_6) {
      if(isDefined(var_0._id_7A89) && isDefined(level._id_7A40) && isDefined(level._id_7A56)) {
        level._id_7A40[[level._id_7A56]](var_0, level._id_7A40, var_0._id_8F26, 0, 0.4);
      }

      var_0 dodamage(var_0.health + 1000, var_0.origin, var_1, var_1, "MOD_UNKNOWN");
      var_0 thread _id_7970(var_7, 0);
      var_0 thread _id_109FE();
    }

    wait 0.5;
  }
}

_id_109FE() {
  self setorigin(self._id_8F26);
}

_id_FC9F(var_0) {
  if(isDefined(var_0)) {
    if(isDefined(level._id_8F68)) {
      var_1 = getweaponbasename(var_0);

      if(scripts\engine\utility::array_contains(level._id_8F68, var_1)) {
        self._id_8F65 = var_0;
        return;
      }
    }
  }

  var_2 = self getweaponslistall();

  if(isDefined(level._id_8F68)) {
    foreach(var_4 in var_2) {
      var_5 = getweaponbasename(var_4);

      for(var_6 = level._id_8F68.size - 1; var_6 > -1; var_6--) {
        if(var_5 == level._id_8F68[var_6]) {
          var_7 = 1;
          self._id_8F65 = var_4;
          return;
        }
      }
    }
  }

  var_7 = 0;
  var_9 = -1;
  var_10 = "s4_pi_raygun_mp";

  foreach(var_4 in var_2) {
    if(isweapon(var_4)) {
      var_12 = var_4.basename;
    } else {
      var_12 = var_4;
    }

    if(var_4.classname == "pistol" && !_id_8632(var_0) && (scripts\cp\cp_weapon::_id_8795(var_4) || var_12 == var_10)) {
      var_13 = _id_0774::_id_684B(var_4);

      if(var_13 > var_9 || var_12 == var_10) {
        self._id_8F65 = var_4;
        var_9 = var_13;
        var_7 = 1;

        if(var_12 == var_10) {
          break;
        }
      }
    }
  }

  if(var_7) {
    return;
  }
  var_15 = _id_6CE3("s4_pi_mike1911_mp");

  if(isDefined(self._id_10CEA) && isDefined(self._id_10CEA[var_15])) {
    self._id_8F65 = makeweaponfromstring(self._id_10CEA[var_15]);
  } else {
    self._id_8F65 = getdefaultlaststandpistol(self);
  }
}

getdefaultlaststandpistol(var_0) {
  foreach(var_2 in var_0.primaryweapons) {
    if(isDefined(var_2.classname) && var_2.classname == "pistol" && !_id_8632(var_2)) {
      return var_2;
    }
  }

  return scripts\cp\cp_weapon::buildweapon("s4_pi_mike1911_mp", [], "none", "none", -1);
}

_id_3552(var_0) {
  if(self._id_8F65 == var_0) {
    _id_FC9F(undefined);
  }
}

_id_6FC2(var_0) {
  if(issubstr(var_0, "specialty_weapon_")) {
    _setperk(var_0);
    return;
  }

  _setperk(var_0);
  _id_0CE9(var_0);
  scripts\cp\telemetry_cp::logevent_perkpurchase(self, var_0, self._id_1B3D);
}

_hasperk(var_0) {
  var_1 = self.perks;

  if(!isDefined(var_1)) {
    return 0;
  }

  if(isDefined(var_1[var_0])) {
    return 1;
  }

  return 0;
}

_id_EDCE(var_0) {
  if(issubstr(var_0, "specialty_weapon_")) {
    _unsetperk(var_0);
    return;
  }

  _unsetperk(var_0);
  _id_0DA0(var_0);
}

_setperk(var_0) {
  self.perks[var_0] = 1;
  self._id_AFFC[var_0] = var_0;
  var_1 = level._id_AFFB[var_0];

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  self _meth_8361(var_0, !isDefined(level._id_CF95[var_0]));
}

_id_0CE9(var_0) {
  if(isDefined(level._id_5853) && isDefined(level._id_5853[var_0])) {
    foreach(var_2 in level._id_5853[var_0]) {
      _setperk(var_2);
      _id_0CE9(var_2);
    }
  }
}

_unsetperk(var_0) {
  self.perks[var_0] = undefined;
  self._id_AFFC[var_0] = undefined;

  if(isDefined(level._id_B000[var_0])) {
    self thread[[level._id_B000[var_0]]]();
  }

  self _meth_8418(var_0, !isDefined(level._id_CF95[var_0]));
}

_id_0DA0(var_0) {
  if(isDefined(level._id_5853[var_0])) {
    foreach(var_2 in level._id_5853[var_0]) {
      _unsetperk(var_2);
      _id_0DA0(var_2);
    }
  }
}

_clearperks() {
  foreach(var_2, var_1 in self.perks) {
    if(isDefined(level._id_B000[var_2])) {
      self[[level._id_B000[var_2]]]();
    }
  }

  self.perks = [];
  self._id_AFFC = [];
  self clearperks();
}

_id_3959() {
  if(isDefined(self._id_98C6)) {
    for(var_0 = 0; var_0 < self._id_98C6.size; var_0++) {
      self._id_98C6[var_0] = undefined;
    }
  }

  if(!isDefined(self._id_98C4)) {
    return;
  }
  _id_FCB7();
}

_id_D5E9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.85;
  }

  if(!isDefined(var_7)) {
    var_7 = 3.0;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  if(!isDefined(var_9)) {
    var_9 = 1;
  }

  _id_10E7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  _id_FCB7();
}

_id_B1FC(var_0, var_1, var_2) {
  level thread _id_B1FD(var_0, var_1, var_2);
}

_id_B1FD(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    var_4 _id_5F63(1);
  }

  _func_0199(var_0);
  wait(var_1);

  foreach(var_4 in level.players) {
    var_4 _id_5F63(0);

    if(!isDefined(var_2) || !var_2) {
      var_4 thread _id_B3C4(0, 1, 0.5, 1);
    }
  }
}

_id_FCB7() {
  self endon("disconnect");

  if(!isDefined(self)) {
    return;
  }
  var_0 = _id_6B27();

  if(!isDefined(var_0)) {
    if(isDefined(self._id_98C4)) {
      self._id_98C4.alpha = 0;
      self._id_98C4 settext("");

      if(isDefined(self._id_98CB)) {
        self._id_98CB.alpha = 0;
      }
    }
  } else {
    self._id_98C4 settext(var_0._id_F0E8);
    self._id_98C4.alpha = 0.85;
    self._id_98CB.alpha = 1;
    self._id_98C4._id_021E = var_0._id_021E;
    self._id_98C4.hidewheninmenu = var_0.hidewheninmenu;

    if(var_0._id_DB58) {
      self._id_98C4 fadeovertime(min(var_0._id_58C5, 60));
      self._id_98C4.alpha = var_0._id_58C4;
    }

    if(var_0._id_F1E8 > 0 && var_0._id_DCF2) {
      self._id_98CB _meth_8391(max(var_0._id_F1E8 - (gettime() - var_0._id_1154) / 1000, 0.1));
    } else {
      if(var_0._id_F1E8 > 0 && !var_0._id_DCF2) {
        self._id_98CB settext("");
        self._id_98C4 fadeovertime(min(var_0._id_F1E8, 60));
        self._id_98C4.alpha = 0;
        thread _id_3962(var_0);
        thread _id_391B(var_0);
        return;
      }

      self._id_98CB settext("");
    }
  }
}

_id_10E7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = undefined;

  foreach(var_12 in self._id_98C6) {
    if(var_12.name == var_0) {
      if(var_12._id_F0E8 == var_1 && var_12._id_BD27 == var_3) {
        return;
      }
      var_10 = var_12;
      break;
    }
  }

  if(!isDefined(var_10)) {
    var_10 = spawnStruct();
    self._id_98C6[self._id_98C6.size] = var_10;
  }

  var_10.name = var_0;
  var_10._id_F0E8 = var_1;
  var_10._id_F1E8 = var_2;
  var_10._id_1154 = gettime();
  var_10._id_BD27 = var_3;
  var_10._id_DCF2 = var_4;
  var_10._id_DB58 = var_5;
  var_10._id_58C4 = var_6;
  var_10._id_58C5 = var_7;
  var_10._id_021E = var_8;
  var_10.hidewheninmenu = var_9;
  _id_E037();
}

_id_E037() {
  for(var_0 = 1; var_0 < self._id_98C6.size; var_0++) {
    var_1 = self._id_98C6[var_0];
    var_2 = var_1._id_BD27;

    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self._id_98C6[var_3]._id_BD27; var_3--) {
      self._id_98C6[var_3 + 1] = self._id_98C6[var_3];
    }

    self._id_98C6[var_3 + 1] = var_1;
  }
}

_id_6B27() {
  if(!isDefined(self._id_98C6)) {
    return undefined;
  }

  return self._id_98C6[0];
}

_id_3962(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  _id_3958(var_0.name);
}

_id_391B(var_0) {
  wait(var_0._id_F1E8);
  _id_3958(var_0.name);
  self notify("message_cleared");
}

_id_3958(var_0) {
  _id_C4E2(var_0);
  _id_FCB7();
}

_id_C4E2(var_0) {
  if(isDefined(self._id_98C6)) {
    for(var_1 = self._id_98C6.size; var_1 > 0; var_1--) {
      if(self._id_98C6[var_1 - 1].name != var_0) {
        continue;
      }
      var_2 = self._id_98C6[var_1 - 1];

      for(var_3 = var_1; var_3 < self._id_98C6.size; var_3++) {
        if(isDefined(self._id_98C6[var_3])) {
          self._id_98C6[var_3 - 1] = self._id_98C6[var_3];
        }
      }

      self._id_98C6[self._id_98C6.size - 1] = undefined;
    }

    _id_E037();
  }
}

_id_5F63(var_0) {
  if(isDefined(level._id_7AAE)) {
    self._id_7AA9 = 1;
    self freezecontrols(1);
    return;
  }

  self freezecontrols(var_0);
  self._id_3C69 = var_0;
}

setthirdpersondof(var_0) {
  if(var_0) {
    self _meth_830B(0, 110, 512, 4096, 6, 1.8);
  } else {
    self _meth_830B(0, 0, 512, 512, 4, 0);
  }
}

_id_D8D4(var_0) {
  if(isDefined(self._id_32E7)) {
    self._id_32E7.alpha = 0;
  }

  self._id_FF18 = var_0;

  if(scripts\common\utility::_id_8650()) {
    scripts\common\utility::_id_1562(0);
  }

  self notify("using_remote");
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
}

_id_8ACE() {
  return isDefined(self._id_FF18);
}

_id_FD26(var_0, var_1) {
  self.sessionstate = var_0;

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  self._id_0407 = var_1;
  self setclientomnvar("ui_session_state", var_0);
}

getuniqueid() {
  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var_0 = self getguid();

  if(var_0 == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    var_0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_0;
  return self.pers["guid"];
}

_id_60C1(var_0) {
  game["flags"][var_0] = 1;
  level notify(var_0);
}

_id_60C0(var_0, var_1) {
  game["flags"][var_0] = var_1;
}

_id_60BE(var_0) {
  return game["flags"][var_0];
}

_id_60C2(var_0) {
  while(!_id_60BE(var_0)) {
    level waittill(var_0);
  }
}

matchmakinggame() {
  return level.onlinegame && !getdvarint("#x310c28bb5d64c8c6d");
}

_id_82D1() {
  return isDefined(game["status"]) && game["status"] == "overtime";
}

_id_820E() {
  if(!isDefined(level._id_9354)) {
    level._id_9354 = [];
  }
}

_id_9353(var_0, var_1) {
  level._id_9354[var_0] = var_1;
}

_id_9351(var_0) {
  return level._id_9354[var_0];
}

_id_9355(var_0) {
  level._id_9354[var_0] = 1;
  level notify(var_0);
}

_id_9352(var_0) {
  level._id_9354[var_0] = 0;
  level notify(var_0);
}

_id_9356(var_0) {
  while(!_id_9351(var_0)) {
    level waittill(var_0);
  }
}

_id_9357(var_0) {
  while(_id_9351(var_0)) {
    level waittill(var_0);
  }
}

_id_819E() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
  }
}

isenemy(var_0) {
  if(level.teambased) {
    return _id_8998(var_0);
  } else {
    return _id_898D(var_0);
  }
}

_id_8998(var_0) {
  return var_0.team != self.team;
}

_id_898D(var_0) {
  if(isDefined(var_0.owner)) {
    return var_0.owner != self;
  } else {
    return var_0 != self;
  }
}

_id_8878(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level._id_EF89, var_0);
}

_id_A6C3(var_0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self endon("notusablejoiningplayers");

  for(;;) {
    level waittill("player_spawned", var_1);

    if(isDefined(var_1) && var_1 != var_0) {
      self disableplayeruse(var_1);
    }
  }
}

setusableforjoiningplayers(var_0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self endon("notusablejoiningplayers");

  for(;;) {
    level waittill("player_spawned", var_1);

    if(isDefined(var_1)) {
      self _meth_80E0(var_1);
    }
  }
}

_id_D6C2(var_0, var_1) {
  var_1 = _id_459B(var_1, 1);
  self makeuseable();

  foreach(var_3 in level.players) {
    if(var_3 != var_0 && var_1) {
      self disableplayeruse(var_3);
      continue;
    }

    self _meth_80E0(var_3);
  }
}

_id_8834(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isweapon(var_0)) {
    if(var_0.basename == "turret_minigun_mp") {
      return 1;
    } else {
      return 0;
    }
  }

  if(var_0 == "turret_minigun_mp") {
    return 1;
  }

  return 0;
}

_id_8A7D(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return isDefined(_id_0766::_id_6DA7(var_0));
}

_id_EA63(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(_func_00D6(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return _func_00D6(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

_id_B8FE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(self.team != var_0) {
    var_6 = _func_020D(scripts\engine\utility::getfx(var_3), var_1, self);
  } else {
    var_6 = _func_020D(scripts\engine\utility::getfx(var_2), var_1, self);
  }

  if(isDefined(var_6)) {
    triggerfx(var_6);
  }

  var_6 thread _id_46C7(var_4);

  if(isDefined(var_5) && var_5) {
    var_6 thread _id_477D(self);
  }

  return var_6;
}

_id_F2D2(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in level.players) {
    if(!var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(var_6.team != var_0) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  if(istrue(var_1)) {
    foreach(var_6 in var_4) {
      thread _id_F2C6(var_6, 1, var_2);
    }
  } else {
    foreach(var_6 in var_4) {
      thread _id_F2C6(var_6, 0);
    }
  }
}

_id_F2C6(var_0, var_1, var_2) {
  if(istrue(var_1)) {
    var_3 = makeweapon("emp_drone_non_player_mp");
    var_4 = _id_09BF::_id_ADCA;
    var_5 = [[var_4]](var_0, var_0, 1, var_3);
    var_0 thread _id_0BD2(var_5, var_2);
  } else
    var_0 notify("emp_cleared");
}

_id_0BD2(var_0, var_1) {
  _id_078D::_id_19B9(var_0);
  _id_0BD3(var_0, var_1);

  if(isDefined(var_0._id_103C2)) {
    var_0._id_103C2 _id_078D::_id_C3AE();
  }
}

_id_0BD3(var_0, var_1) {
  var_0._id_103C2 endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::_id_108F7("emp_cleared", var_1);
  } else {
    self waittill("emp_cleared");
  }
}

_id_46C7(var_0) {
  self endon("death");
  wait(var_0);

  if(isDefined(self)) {
    self delete();
  }
}

_id_477D(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_2("death", "disconnect");
  self delete();
}

_id_8A68(var_0, var_1) {
  return _func_00D6(var_0, 0, var_1.size) == var_1;
}

_id_6902(var_0) {
  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = strtok(var_1, "_");
  var_3 = 0;

  if(var_2[0] == "alt") {
    var_3++;
  }

  if(var_2[var_3] == "iw7") {
    var_1 = var_2[var_3] + "_" + var_2[var_3 + 1];
  } else if(var_2[var_3] == "iw8") {
    var_4 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la"];

    if(scripts\engine\utility::array_contains(var_4, var_2[var_3 + 1])) {
      var_1 = var_2[var_3] + "_" + var_2[var_3 + 1] + "_" + var_2[var_3 + 2];
    } else {
      var_1 = var_2[var_3] + "_" + var_2[var_3 + 1];
    }
  }

  return var_1;
}

_id_6EA2(var_0, var_1) {
  var_2 = strtok(var_0, "_");

  if(var_2[0] == "iw5" || var_2[0] == "iw6" || var_2[0] == "iw7") {
    if(isDefined(var_1) && var_1 > 1) {
      var_0 = var_2[0] + "_z" + var_2[1] + var_1;
    } else {
      var_0 = var_2[0] + "_z" + var_2[1];
    }
  } else if(var_2[0] == "alt") {
    if(isDefined(var_1) && var_1 > 1) {
      var_0 = var_2[1] + "_z" + var_2[2] + var_1;
    } else {
      var_0 = var_2[1] + "_z" + var_2[2];
    }
  }

  return var_0;
}

_id_63D8(var_0) {
  if(!isDefined(level._id_10E3B)) {
    return undefined;
  }

  var_1 = _func_0204(level._id_10E3B, var_0);

  foreach(var_3 in var_1) {
    if(var_3._id_523F) {
      return var_3;
    }
  }

  return undefined;
}

_id_551B(var_0) {
  if(!isDefined(var_0._id_2290)) {
    return 1;
  }

  var_1 = [[level._id_A464]](var_0);

  if(!isDefined(var_1)) {
    return 1;
  }

  return 0;
}

_id_8722() {
  return istrue(level._id_10D13);
}

_id_6374(var_0) {
  var_1 = var_0._id_024F.model;
  var_2 = "arkblue";
  var_3 = "stun_ammo";

  switch (var_1) {
    case "attachment_zmb_arcane_muzzlebrake_wm":
      var_2 = "arcane_base";
      break;
    default:
      break;
  }

  return var_2;
}

_id_1A46() {
  foreach(var_2, var_1 in self._id_3BB3) {
    if(var_1._id_AA43 == 1) {
      return 1;
    }
  }

  return 0;
}

_id_8774(var_0) {
  if(isDefined(var_0)) {
    var_1 = getweaponbasename(var_0);
    return _func_010D(var_1, "s4_me_icepick_mp") || _func_010D(var_1, "s4_me_axe_mp");
  } else
    return 0;
}

_id_6CE3(var_0) {
  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = strtok(var_1, "_");

  if(!_func_0107(var_2) || var_2.size == 0) {
    return var_1;
  }

  if(var_2[0] == "iw5" || var_2[0] == "iw6" || var_2[0] == "iw7") {
    var_1 = var_2[1];
  } else if(var_2[0] == "alt") {
    var_1 = var_2[3];
  } else if(var_2[0] == "iw8" || var_2[0] == "s4") {
    var_1 = var_2[2];
  }

  return var_1;
}

_id_6AC8(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

_id_9137(var_0, var_1, var_2, var_3) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  var_4 = self.pers["team"];

  if(isDefined(var_4) && (var_4 == "axis" || var_4 == "allies")) {
    var_5 = game["voice"][var_4] + game["dialog"][var_0];
    self _meth_8287(var_5, var_0, 2, var_1, var_2, var_3);
  }
}

_id_0CE1(var_0, var_1, var_2) {
  self._id_CB42[var_0].type = var_1;
  self._id_CB42[var_0]._id_024F = var_2;
  self setactionslot(var_0, var_1, var_2);
}

_id_6AED(var_0) {
  return _func_0222(level._id_7043["killstreakTable"]._id_AEC7, level._id_7043["killstreakTable"]._id_C18A, var_0, level._id_7043["killstreakTable"]._id_10CEF);
}

_id_0C71(var_0) {
  _func_015C(var_0);

  if(!isDefined(level._id_C113)) {
    level._id_C113 = [];
    level._id_C113[0] = var_0;
  } else
    level._id_C113[level._id_C113.size] = var_0;
}

_id_F38F(var_0) {
  var_1 = getEntArray("trigger_hurt", "classname");

  foreach(var_3 in var_1) {
    if(self istouching(var_3) && (level.mapname != "mp_mine" || var_3._id_0173 > 0)) {
      return 1;
    }
  }

  var_5 = getEntArray("radiation", "targetname");

  foreach(var_3 in var_5) {
    if(self istouching(var_3)) {
      return 1;
    }
  }

  if(isDefined(var_0) && var_0 == "gryphon") {
    var_8 = getEntArray("gryphonDeath", "targetname");

    foreach(var_3 in var_8) {
      if(self istouching(var_3)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_B8EF(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(_func_0107(var_0)) {
      var_0 = scripts\engine\utility::random(var_0);
    }

    var_3 = _func_0142(var_0);
    playsoundatpos(var_1, var_0);

    if(isDefined(var_2)) {
      wait(var_3 / 1000);
    }

    return var_3;
  }
}

_id_B2A7(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(!_func_0107(var_0)) {
      var_3 = [];
      var_3[0] = var_0;
      var_0 = var_3[0];
    }

    var_4 = scripts\engine\utility::random(var_0);
    var_5 = _func_0142(var_4);
    playsoundatpos(var_1, var_4);

    if(isDefined(var_2)) {
      wait(var_5);
    }

    return var_5;
  }
}

_id_B27E(var_0) {
  if(_func_0205(var_0)) {
    self playLoopSound(var_0);
  }
}

_id_E8B6(var_0) {
  if(_func_0205(var_0)) {
    self stoploopsound(var_0);
  }
}

_id_B386() {
  var_0 = randomintrange(1, 8);
  var_1 = "generic";

  if(self _meth_81A1()) {
    var_1 = "female";
  }

  if(self.team == "axis") {
    var_2 = var_1 + "_death_russian_" + var_0;

    if(_func_0205(var_2)) {
      self playSound(var_2);
    }
  } else {
    var_2 = var_1 + "_death_american_" + var_0;

    if(_func_0205(var_2)) {
      self playSound(var_2);
    }
  }
}

_id_8866(var_0, var_1, var_2) {
  return isDefined(var_2) && var_2 _hasperk("specialty_armorpiercing") && isDefined(var_1) && scripts\engine\utility::_id_8794(var_1);
}

_id_87AA() {
  return isDefined(self._id_33EF);
}

_id_68E5(var_0) {
  if(!isDefined(var_0)) {
    return "none";
  }

  var_1 = _func_0222("mp/attachmenttable.csv", 4, var_0, 2);

  if(!isDefined(var_1) || var_1 == "") {
    var_2 = getDvar("#x315af23e89f368200");

    if(var_2 == "zombie") {
      var_1 = _func_0222("cp/zombies/zombie_attachmentTable.csv", 4, var_0, 2);
    }
  }

  return var_1;
}

weaponhasattachment(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == "none" || var_0 == "") {
    return 0;
  }

  var_2 = _id_6E69(var_0);

  foreach(var_4 in var_2) {
    if(var_4 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_6E69(var_0) {
  var_1 = getweaponattachments(var_0);

  foreach(var_4, var_3 in var_1) {
    var_1[var_4] = _id_1DA5(var_3);
  }

  return var_1;
}

_id_1DA5(var_0) {
  if(issubstr(var_0, "|")) {
    var_0 = strtok(var_0, "|")[0];
  }

  if(isDefined(level._id_1DAB[var_0])) {
    var_0 = level._id_1DAB[var_0];
  } else if(isDefined(level.activeattachmentoverrides)) {
    foreach(var_3, var_2 in level.activeattachmentoverrides) {
      if(var_0 == level.attachmentmap_combooverrides[var_3][var_2]) {
        var_0 = level.activeattachmentoverrides[var_3];
      }
    }
  }

  return var_0;
}

_id_8A35(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "barsil_") || var_0 == "barcust2_mpapa5";
}

_id_8A36(var_0) {
  return scripts\engine\utility::string_starts_with(var_0, "silencer");
}

_id_879E(var_0) {
  return var_0 == "calcust" || var_0 == "calsmg" || var_0 == "calsmgdrums";
}

_id_88DF() {
  if(isDefined(self._id_04B9) && self._id_04B9 == "juggernaut") {
    return 1;
  }

  if(isDefined(self._id_88DF) && self._id_88DF == 1) {
    return 1;
  }

  if(isDefined(self._id_88E0) && self._id_88E0 == 1) {
    return 1;
  }

  if(isDefined(self._id_88E1) && self._id_88E1 == 1) {
    return 1;
  }

  if(isDefined(self._id_88E4) && self._id_88E4 == 1) {
    return 1;
  }

  if(isDefined(self._id_88E3) && self._id_88E3 == 1) {
    return 1;
  }

  if(isDefined(self._id_88E2) && self._id_88E2 == 1) {
    return 1;
  }

  return 0;
}

_id_1DA9(var_0, var_1) {
  var_2 = undefined;

  if(isweapon(var_1)) {
    var_2 = getcompleteweaponname(var_1);
  } else {
    var_2 = var_1;
  }

  var_3 = getweaponrootname(var_1);

  if(var_3 != var_2) {
    var_4 = getweaponbasename(var_1);

    if(isDefined(level._id_1DA2[var_4]) && isDefined(level._id_1DAB[var_0]) && isDefined(level._id_1DA2[var_4][level._id_1DAB[var_0]])) {
      var_5 = level._id_1DAB[var_0];
      return level._id_1DA2[var_4][var_5];
    } else if(isDefined(level._id_1DA2[var_4]) && isDefined(level._id_1DA2[var_4][var_0]))
      return level._id_1DA2[var_4][var_0];
    else {
      var_6 = strtok(var_4, "_");

      if(var_6.size > 3) {
        var_7 = var_6[0] + "_" + var_6[1] + "_" + var_6[2];

        if(isDefined(level._id_1DA2[var_7]) && isDefined(level._id_1DA2[var_7][var_0])) {
          return level._id_1DA2[var_7][var_0];
        }
      }
    }
  }

  if(isDefined(level._id_1DA2[var_3]) && isDefined(level._id_1DA2[var_3][var_0])) {
    return level._id_1DA2[var_3][var_0];
  } else {
    var_8 = _id_10D99(var_3);

    if(isDefined(level._id_1DA2[var_8]) && isDefined(level._id_1DA2[var_8][var_0])) {
      return level._id_1DA2[var_8][var_0];
    }
  }

  return var_0;
}

_id_10D99(var_0) {
  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_71F4)) {
    return level._id_10DB0[var_0]._id_71F4;
  }

  return undefined;
}

_id_10DB4(var_0) {
  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_A76E)) {
    return level._id_10DB0[var_0]._id_A76E;
  }

  return undefined;
}

_id_15CF(var_0, var_1) {
  if(isDefined(var_0)) {
    self endon(var_0);
  }

  if(isDefined(var_1)) {
    var_2 = self;
  } else {
    if(!isDefined(self.owner)) {
      return;
    }
    var_2 = self.owner;
  }

  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 endon("end_remote");
  var_2 notify("watch_use_exit");
  var_2 endon("diable_use_exit");
  self endon("death");
  thread _id_1540();

  if(!isDefined(level._id_5F3A)) {
    level._id_5F3A = level._id_01E2 / 1000;
  }

  var_3 = level._id_5F3A;
  var_4 = 0.75;
  var_5 = 1;

  for(;;) {
    var_6 = 0;

    if(var_5 == 1) {
      var_2 setclientomnvar("ui_exit_progress", 0);
      var_5 = 0;
    }

    while(var_2 useButtonPressed()) {
      var_6 = var_6 + var_3;
      var_5 = 1;
      var_2 setclientomnvar("ui_exit_progress", var_6 / var_4);

      if(var_6 > var_4) {
        self notify("killstreakExit");
        return;
      }

      wait(var_3);
    }

    wait(var_3);
  }
}

_id_1540() {
  self endon("killstreakExit");
  level waittill("cp_force_killstreak_exit");
  self notify("killstreakExit");
}

_id_8DAF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_A5B0(1);
  _func_0163(var_5, self.origin);
  _func_015D(var_5, var_0);
  _func_016B(var_5, "active");
  _func_017A(var_5, 1);

  if(!isDefined(self _meth_8151()) && !istrue(var_3)) {
    _id_FB97(var_5, self.origin);
  } else if(istrue(var_3) && istrue(var_4)) {
    _id_FB94(var_5, self);
  } else {
    _id_FB93(var_5, self);
  }

  if(isDefined(var_1)) {
    _func_0182(var_5, var_1);

    if(!level.teambased && isDefined(self.owner)) {
      if(istrue(var_2)) {
        _id_07F9::_id_A88D(var_5, self.owner);
      } else {
        _id_07F9::_id_A8CA(var_5, var_1);
      }
    }
  } else
    _id_07F9::_id_A8A2(var_5);

  return var_5;
}

_id_8DB0(var_0, var_1, var_2) {
  var_3 = _id_A5B0(1);

  if(var_3 == -1) {
    return -1;
  }

  _func_015C(var_3);
  _func_016B(var_3, "invisible");
  _func_0163(var_3, (0, 0, 0));

  if(!isDefined(self _meth_8151()) && !istrue(var_1)) {
    _id_FB97(var_3, self.origin);
  } else if(istrue(var_1) && istrue(var_2)) {
    _id_FB94(var_3, self);
  } else {
    _id_FB93(var_3, self);
  }

  _func_016B(var_3, "active");
  _func_015D(var_3, var_0);
  _func_017A(var_3, 1);
  _func_0182(var_3, self.team);
  _id_0748::_id_9F14(var_3);
  return var_3;
}

_id_FB97(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0163(var_0, var_1);
}

_id_FB93(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0160(var_0, var_1);
}

_id_FB94(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  _func_0160(var_0, var_1);
  _func_0177(var_0, 1);
}

_id_A5B1(var_0) {
  _id_0748::_id_5F57(var_0);
}

_id_A5B0(var_0) {
  return _id_0748::_id_C583("nonobj_marker", 1);
}

_id_3990(var_0) {
  scripts\common\utility::_id_158B(1);
  scripts\common\utility::_id_152F(1);
  scripts\common\utility::_id_151F(1);

  if(isDefined(self._id_32E7)) {
    self._id_32E7.alpha = 1;
  }

  self._id_FF18 = undefined;

  if(!isDefined(var_0)) {
    scripts\common\utility::_id_1562(1);
    _freezecontrols(0);
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

_id_3E09(var_0) {
  if(getdvarint("#x35daa86ede44c096", 0)) {
    return;
  }
  if(istrue(level._id_4A98)) {
    return;
  }
  if(!isDefined(level._id_492F)) {
    level._id_492F = [];
  }

  if(level._id_492F.size == 5) {
    var_1 = level._id_492F[0];
    level._id_492F = scripts\engine\utility::array_remove_index(level._id_492F, 0);
    scripts\engine\utility::_id_FB5C();
    var_1 thread scripts\engine\utility::_id_4830();
  }

  if(_func_0205("cp_ui_menu_title_decode_text")) {
    foreach(var_3 in level.players) {
      var_3 playlocalsound("cp_ui_menu_title_decode_text");
    }
  }

  var_5 = "^3";
  var_6 = 1;

  if(isDefined(level._id_4963)) {
    var_6 = level._id_4963;
  }

  var_7 = newhudelem();
  var_7.elemtype = "font";
  var_7.font = "default";
  var_7.fontscale = var_6;
  var_7.x = 0;
  var_7.y = 0;
  var_7.width = 0;
  var_7.height = int(level.fontheight * var_6);
  var_7.xoffset = 0;
  var_7.yoffset = 0;
  var_8 = level._id_492F.size;
  level._id_492F[var_8] = var_7;
  var_7._id_01D6 = 1;
  var_7.sort = 20;
  var_7.x = 40;
  var_7.y = 260 + var_8 * (12 * var_6);
  var_7.label = var_0;
  var_7.alpha = 0;
  var_7 fadeovertime(0.2);
  var_7.alpha = 1;
  var_7 endon("death");
  wait 8;
  level._id_492F = scripts\engine\utility::array_remove(level._id_492F, var_7);
  scripts\engine\utility::_id_FB5C();
  var_7 thread _id_3E0C();
}

_id_3E0C() {
  var_0 = 1;

  if(isDefined(level._id_4963)) {
    var_0 = level._id_4963;
  }

  self endon("death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y = self.y - 12 * var_0;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

_id_6A3F() {
  var_0 = self getweaponslistprimaries();
  return var_0[0];
}

_id_D433(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_66AA(var_4, var_5);

  foreach(var_8 in var_6) {
    var_8 notify("changing_watching_visionset");

    if(isDefined(var_3) && var_3) {
      var_8 visionsetmissilecamforplayer(var_0, var_1);
    } else {
      var_8 visionsetnakedforplayer(var_0, var_1);
    }

    if(var_0 != "" && isDefined(var_2)) {
      var_8 thread _id_C5FD(self, var_1 + var_2);
      var_8 thread _id_C5FB(self);

      if(var_8 _id_88C7()) {
        var_8 thread _id_C5FC();
      }
    }
  }
}

_id_66AA(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }
    var_6 = 0;

    if(!var_1) {
      if(var_5.team == "spectator" || var_5.sessionstate == "spectator") {
        var_7 = var_5 getspectatingplayer();

        if(isDefined(var_7) && var_7 == self) {
          var_6 = 1;
        }
      }

      if(var_5._id_01D2 == var_2) {
        var_6 = 1;
      }
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2) {
        var_6 = 1;
      }
    }

    if(var_6) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

_id_C5FD(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_2 = gettime();
  var_3 = self.team;

  while(gettime() - var_2 < var_1 * 1000) {
    if(self.team != var_3 || !scripts\engine\utility::array_contains(var_0 _id_66AA(), self)) {
      self visionsetnakedforplayer("", 0.0);
      self notify("changing_visionset");
      break;
    }

    wait 0.05;
  }
}

_id_C5FB(var_0) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");

  if(isDefined(level._id_1041F)) {
    self visionsetnakedforplayer(level._id_1041F, 0.0);
  } else {
    self visionsetnakedforplayer("", 0.0);
  }
}

_id_C5FC() {
  self endon("disconnect");
  self waittill("spawned");

  if(isDefined(level._id_1041F)) {
    self visionsetnakedforplayer(level._id_1041F, 0.0);
  } else {
    self visionsetnakedforplayer("", 0.0);
  }
}

_id_88C7() {
  return self._id_03EB;
}

createfontstring(var_0, var_1, var_2) {
  if(!isDefined(var_2) || !var_2) {
    var_3 = newclienthudelem(self);
  } else {
    var_3 = newhudelem();
  }

  var_3.elemtype = "font";
  var_3.font = var_0;
  var_3.fontscale = var_1;
  var_3._id_22B8 = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_1);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;
  var_3.archived = 0;
  return var_3;
}

setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }
  if(isDefined(self.parent)) {
    self.parent _id_C484(self);
  }

  self.parent = var_0;
  self.parent _id_109B(self);

  if(isDefined(self.point)) {
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  } else {
    setpoint("TOPLEFT");
  }
}

_id_C484(var_0) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_0) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

_id_109B(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  _id_C48F();
}

_id_C48F() {
  if(isDefined(self._id_3579) && self._id_3579 == gettime()) {
    return;
  }
  self._id_3579 = gettime();
  var_0 = [];

  foreach(var_3, var_2 in self.children) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2.index = var_0.size;
    var_0[var_0.size] = var_2;
  }

  self.children = var_0;
}

setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = getparent();

  if(var_4) {
    self moveovertime(var_4);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  self.xoffset = var_2;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "center";
  self.aligny = "middle";

  if(issubstr(var_0, "TOP")) {
    self.aligny = "top";
  }

  if(issubstr(var_0, "BOTTOM")) {
    self.aligny = "bottom";
  }

  if(issubstr(var_0, "LEFT")) {
    self.alignx = "left";
  }

  if(issubstr(var_0, "RIGHT")) {
    self.alignx = "right";
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  self.relativepoint = var_1;
  var_6 = "center_adjustable";
  var_7 = "middle";

  if(issubstr(var_1, "TOP")) {
    var_7 = "top_adjustable";
  }

  if(issubstr(var_1, "BOTTOM")) {
    var_7 = "bottom_adjustable";
  }

  if(issubstr(var_1, "LEFT")) {
    var_6 = "left_adjustable";
  }

  if(issubstr(var_1, "RIGHT")) {
    var_6 = "right_adjustable";
  }

  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(_id_EA63(var_6, "_adjustable") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "center" || var_5.alignx == "center") {
    var_8 = int(var_5.width / 2);

    if(var_6 == "left_adjustable" || var_5.alignx == "right") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  } else {
    var_8 = var_5.width;

    if(var_6 == "left_adjustable") {
      var_9 = -1;
    } else {
      var_9 = 1;
    }
  }

  self.x = var_5.x + var_8 * var_9;

  if(_id_EA63(var_7, "_adjustable") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "middle" || var_5.aligny == "middle") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "top_adjustable" || var_5.aligny == "bottom") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  } else {
    var_10 = var_5.height;

    if(var_7 == "top_adjustable") {
      var_11 = -1;
    } else {
      var_11 = 1;
    }
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "bar":
      _id_D682(var_0, var_1, var_2, var_3);
      break;
  }

  _id_FC2C();
}

getparent() {
  return self.parent;
}

_id_D682(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "left") {
    self.bar.x = self.x;
  } else if(self.alignx == "right") {
    self.bar.x = self.x - self.width;
  } else {
    self.bar.x = self.x - int(self.width / 2);
  }

  if(self.aligny == "top") {
    self.bar.y = self.y;
  } else if(self.aligny == "bottom") {
    self.bar.y = self.y;
  }

  _id_FC11(self.bar._id_5F33);
}

_id_FC11(var_0, var_1) {
  if(self.elemtype == "bar") {
    _id_FC12(var_0, var_1);
  }
}

_id_FC12(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2) {
    var_2 = 1;
  }

  self.bar._id_5F33 = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && (var_1 > 0 && var_2 < self.width || var_1 < 0 && var_2 > 0)) {
    if(var_1 > 0) {
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    } else if(var_1 < 0) {
      self.bar scaleovertime(var_0 / (-1 * var_1), 1, self.height);
    }
  }

  self.bar._id_C048 = var_1;
  self.bar._id_90B3 = gettime();
}

_id_FC2C() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    var_1 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

createicon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_4 = newclienthudelem(self);
  } else {
    var_4 = newhudelem();
  }

  var_4.elemtype = "icon";
  var_4.x = 0;
  var_4.y = 0;
  var_4.width = var_1;
  var_4.height = var_2;
  var_4._id_232E = var_4.width;
  var_4._id_22BD = var_4.height;
  var_4.xoffset = 0;
  var_4.yoffset = 0;
  var_4.children = [];
  var_4 setparent(level.uiparent);
  var_4.hidden = 0;

  if(isDefined(var_0)) {
    var_4 setshader(var_0, var_1, var_2);
    var_4.shader = var_0;
  }

  return var_4;
}

destroyelem() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1])) {
      var_0[var_0.size] = self.children[var_1];
    }
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] setparent(getparent());
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar destroy();
  }

  self destroy();
}

_id_DC9A() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    if(self.alpha != 0.5) {
      self.alpha = 0.5;
    }

    self.bar.hidden = 0;

    if(self.bar.alpha != 1) {
      self.bar.alpha = 1;
    }
  } else if(self.alpha != 1)
    self.alpha = 1;
}

_id_78F5() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0) {
    self.alpha = 0;
  }

  if(self.elemtype == "bar" || self.elemtype == "bar_shader") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0) {
      self.bar.alpha = 0;
    }
  }
}

_id_4036(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self _meth_81E2()) {
    var_1 = var_1 + 20;
  }

  var_4 = level._id_BCD6;
  var_5 = "default";

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = createfontstring(var_5, var_4);
  var_6 setpoint("CENTER", undefined, level._id_BCD8 + var_0, level._id_BCD9 + var_1);
  var_6.sort = -1;
  return var_6;
}

_id_4035(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return undefined;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = -25;
  }

  if(self _meth_81E2()) {
    var_1 = var_1 + 20;
  }

  if(!isDefined(var_2)) {
    var_2 = level._id_BCDA;
  }

  if(!isDefined(var_3)) {
    var_3 = level._id_BCD7;
  }

  var_4 = _id_3F99((1, 1, 1), var_2, var_3);
  var_4 setpoint("CENTER", undefined, level._id_BCDB + var_0, level._id_BCDC + var_1);
  return var_4;
}

_id_3F99(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4._id_5F33 = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "progress_bar_fill";
  var_4 setshader("progress_bar_fill", var_1, var_2);
  var_4.hidden = 0;
  var_4.hidewheninmenu = 1;
  var_4.archived = 0;

  if(isDefined(var_3)) {
    var_4._id_5CA4 = var_3;
  }

  var_5 = newclienthudelem(self);
  var_5.elemtype = "bar";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5 setparent(level.uiparent);
  var_5 setshader("progress_bar_bg", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  var_5.hidewheninmenu = 1;
  var_5.archived = 0;
  return var_5;
}

_id_8877(var_0) {
  if(_id_8737(var_0)) {
    return 1;
  }

  if(isPlayer(var_0)) {
    return 1;
  }

  return 0;
}

_id_8737(var_0) {
  if(isagent(var_0) && isDefined(var_0._id_11F0) && var_0._id_11F0 == 1) {
    return 1;
  }

  if(isbot(var_0)) {
    return 1;
  }

  return 0;
}

_id_D710(var_0, var_1) {
  if(!level.teambased) {
    return;
  }
  if(!isDefined(self._id_5505)) {
    self._id_5505 = "none";
    self._id_5502 = undefined;
  }

  var_2 = game["entity_headicon_" + var_0];
  self._id_5505 = var_0;

  if(isDefined(var_1)) {
    self._id_5503 = var_1;
  } else {
    self._id_5503 = (0, 0, 0);
  }

  self notify("kill_entity_headicon_thread");

  if(var_0 == "none") {
    if(isDefined(self._id_5502)) {
      self._id_5502 destroy();
    }

    return;
  }

  var_3 = newteamhudelem(var_0);
  var_3.archived = 1;
  var_3.x = self.origin[0] + self._id_5503[0];
  var_3.y = self.origin[1] + self._id_5503[1];
  var_3._id_050C = self.origin[2] + self._id_5503[2];
  var_3.alpha = 0.8;
  var_3 setshader(var_2, 10, 10);
  var_3 _meth_83B2(0, 0, 0, 1);
  self._id_5502 = var_3;
  thread _id_8CC5();
  thread _id_4851();
}

_id_D662(var_0, var_1) {
  if(level.teambased) {
    return;
  }
  if(!isDefined(self._id_5505)) {
    self._id_5505 = "none";
    self._id_5502 = undefined;
  }

  self notify("kill_entity_headicon_thread");

  if(!isDefined(var_0)) {
    if(isDefined(self._id_5502)) {
      self._id_5502 destroy();
    }

    return;
  }

  var_2 = var_0.team;
  self._id_5505 = var_2;

  if(isDefined(var_1)) {
    self._id_5503 = var_1;
  } else {
    self._id_5503 = (0, 0, 0);
  }

  var_3 = game["entity_headicon_" + var_2];
  var_4 = newclienthudelem(var_0);
  var_4.archived = 1;
  var_4.x = self.origin[0] + self._id_5503[0];
  var_4.y = self.origin[1] + self._id_5503[1];
  var_4._id_050C = self.origin[2] + self._id_5503[2];
  var_4.alpha = 0.8;
  var_4 setshader(var_3, 10, 10);
  var_4 _meth_83B2(0, 0, 0, 1);
  self._id_5502 = var_4;
  thread _id_8CC5();
  thread _id_4851();
}

_id_8CC5() {
  self._id_5502 _meth_8214(self, self._id_5503);
}

_id_4851() {
  self endon("kill_entity_headicon_thread");
  self waittill("death");

  if(!isDefined(self._id_5502)) {
    return;
  }
  self._id_5502 destroy();
}

_id_D58F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(_id_8877(var_0) && !isPlayer(var_0)) {
    return;
  }
  if(!isDefined(self._id_5504)) {
    self._id_5504 = [];
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.05;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 1;
  }

  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  if(!isDefined(var_10)) {
    var_10 = 1;
  }

  if(!isPlayer(var_0) && var_0 == "none") {
    foreach(var_13, var_12 in self._id_5504) {
      if(isDefined(var_12)) {
        var_12 destroy();
      }

      self._id_5504[var_13] = undefined;
    }
  } else {
    if(isPlayer(var_0)) {
      if(isDefined(self._id_5504[var_0.guid])) {
        self._id_5504[var_0.guid] destroy();
        self._id_5504[var_0.guid] = undefined;
      }

      if(var_1 == "") {
        return;
      }
      if(isDefined(var_0.team)) {
        if(isDefined(self._id_5504[var_0.team])) {
          self._id_5504[var_0.team] destroy();
          self._id_5504[var_0.team] = undefined;
        }
      }

      var_12 = newclienthudelem(var_0);
      self._id_5504[var_0.guid] = var_12;
    } else {
      if(isDefined(self._id_5504[var_0])) {
        self._id_5504[var_0] destroy();
        self._id_5504[var_0] = undefined;
      }

      if(var_1 == "") {
        return;
      }
      foreach(var_13, var_15 in self._id_5504) {
        if(var_13 == "axis" || var_13 == "allies") {
          continue;
        }
        var_16 = _id_6C4D(var_13);

        if(var_16.team == var_0) {
          self._id_5504[var_13] destroy();
          self._id_5504[var_13] = undefined;
        }
      }

      var_12 = newteamhudelem(var_0);
      self._id_5504[var_0] = var_12;
    }

    if(!isDefined(var_3) || !isDefined(var_4)) {
      var_3 = 10;
      var_4 = 10;
    }

    var_12.archived = var_5;
    var_12.x = self.origin[0] + var_2[0];
    var_12.y = self.origin[1] + var_2[1];
    var_12._id_050C = self.origin[2] + var_2[2];
    var_12.alpha = 0.85;
    var_12 setshader(var_1, var_3, var_4);
    var_12 _meth_83B2(var_7, var_8, var_9, var_10);
    var_12 thread _id_8CC7(self, var_2, var_6);
    thread _id_4855();

    if(isPlayer(var_0)) {
      var_12 thread _id_485E(var_0);
    }

    if(isPlayer(self)) {
      var_12 thread _id_485E(self);
    }
  }
}

_id_DCB0(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2.alpha = 0.85;
    }
  }
}

_id_78FD(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2.alpha = 0;
    }
  }
}

_id_6C4D(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

_id_6C7B() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_6C5F(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_characterproxy"];
  return getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

_id_688C(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_characterproxy"];
  return getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

getentitiesinradius(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 <= 0) {
    return [];
  }

  var_5 = undefined;

  if(isDefined(var_3)) {
    if(_func_0107(var_3)) {
      var_5 = var_3;
    } else {
      var_5 = [var_3];
    }
  }

  var_6 = _func_02C5(var_0, var_1, var_4, var_5, "physicsquery_all");
  var_7 = [];

  if(!isDefined(var_2)) {
    foreach(var_9 in var_6) {
      var_10 = var_9["entity"];
      var_7[var_7.size] = var_10;
    }
  } else {
    foreach(var_9 in var_6) {
      var_10 = var_9["entity"];

      if(isDefined(var_10.team) && var_10.team == var_2) {
        var_7[var_7.size] = var_10;
      }
    }
  }

  return var_7;
}

_id_8CC7(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_3 = isDefined(var_0.classname) && !_id_896D(var_0);

  if(var_3) {
    self _meth_8214(var_0, var_1);
  }

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    if(!var_3) {
      var_4 = var_0.origin;
      self.x = var_4[0] + var_1[0];
      self.y = var_4[1] + var_1[1];
      self._id_050C = var_4[2] + var_1[2];
    }

    if(var_2 > 0.05) {
      self.alpha = 0.85;
      self fadeovertime(var_2);
      self.alpha = 0;
    }

    wait(var_2);
  }
}

_id_896D(var_0) {
  return isDefined(var_0._id_0481) && var_0._id_0481 == "care_package";
}

_id_4855() {
  self notify("destroyIconsOnDeath");
  self endon("destroyIconsOnDeath");
  self waittill("death");

  if(!isDefined(self._id_5504)) {
    return;
  }
  foreach(var_2, var_1 in self._id_5504) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 destroy();
  }
}

_id_485E(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self destroy();
}

_id_0D8A() {
  if(!_id_8ACE() && !isDefined(self._id_59E0)) {
    self suicide();
  }
}

_id_B546(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_9907(var_0, var_1, var_2, var_3, var_4, var_5);
  return var_6;
}

_id_9907(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._id_4143 = 0;
  self._id_84EF = 1;
  self._id_FEB1 = 1;
  self._id_FEE7 = var_1;
  var_0 thread _id_3F3C(self, var_3);
  var_0._id_759D = 1;
  var_6 = _id_9908(var_0, self, var_2, var_4, var_5);

  if(isalive(var_0)) {
    var_0._id_759D = 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  self._id_84EF = 0;
  self._id_4143 = 0;
  return var_6;
}

_id_3F3C(var_0, var_1) {
  self endon("disconnect");
  self setclientomnvar("ui_securing", var_1);
  var_2 = -1;

  while(scripts\cp_mp\utility\player_utility::_isalive() && isDefined(var_0) && var_0._id_84EF && !level.gameended) {
    if(var_2 != var_0._id_FEB1) {
      if(var_0._id_4143 > var_0._id_FEE7) {
        var_0._id_4143 = var_0._id_FEE7;
      }
    }

    var_2 = var_0._id_FEB1;
    self setclientomnvar("ui_securing_progress", var_0._id_4143 / var_0._id_FEE7);
    wait 0.05;
  }

  wait 0.5;
  self setclientomnvar("ui_securing_progress", 0);
  self setclientomnvar("ui_securing", 0);
}

_id_9908(var_0, var_1, var_2, var_3, var_4) {
  while(!level.gameended && isDefined(self) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && (var_0 useButtonPressed() || isDefined(var_3) || var_0 attackButtonPressed() && isDefined(var_4)) && _id_DA7F(var_0)) {
    wait 0.05;

    if(isDefined(var_1) && isDefined(var_2)) {
      if(distancesquared(var_0.origin, var_1.origin) > var_2) {
        return 0;
      }
    }

    self._id_4143 = self._id_4143 + 50 * self._id_FEB1;
    self._id_FEB1 = 1;

    if(self._id_4143 >= self._id_FEE7) {
      var_0 setclientomnvar("ui_securing_progress", 1);
      return var_0 scripts\cp_mp\utility\player_utility::_isalive();
    }
  }

  return 0;
}

_id_DA7F(var_0) {
  if(isDefined(level._id_DA7F)) {
    return [[level._id_DA7F]](var_0);
  } else {
    return !_id_073B::_id_B4EF(var_0);
  }
}

_id_89AE() {
  if(_func_0302() == 1) {
    return 1;
  }

  return 0;
}

_id_C4B0() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level._id_AE7C.size; var_1++) {
    if(level._id_AE7C[var_1] == self) {
      for(var_0 = 1; var_1 < level._id_AE7C.size - 1; var_1++) {
        level._id_AE7C[var_1] = level._id_AE7C[var_1 + 1];
      }

      level._id_AE7C[var_1] = undefined;
      break;
    }
  }
}

_id_C4A7() {
  var_0 = 0;

  for(var_1 = 0; var_1 < level.characters.size; var_1++) {
    if(level.characters[var_1] == self) {
      for(var_0 = 1; var_1 < level.characters.size - 1; var_1++) {
        level.characters[var_1] = level.characters[var_1 + 1];
      }

      level.characters[var_1] = undefined;
      break;
    }
  }
}

_id_C4B5() {
  if(isDefined(self._id_7218)) {
    if(isDefined(level._id_E2A7) && isDefined(level._id_E2A7[self._id_7218])) {
      level._id_E2A7[self._id_7218] = ::scripts\engine\utility::array_remove(level._id_E2A7[self._id_7218], self);
    }
  }
}

_id_4065(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "timer";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2._id_22B8 = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

_id_0BBC(var_0) {
  if(!istrue(var_0)) {
    self._id_7611 = undefined;
  }

  if(isDefined(self._id_C887)) {
    _id_C878(1);
  }

  if(isDefined(self._id_C888)) {
    _id_C878(0);
  }

  self._id_75A6 = 0;

  if(!istrue(var_0)) {
    self _meth_809E();
  }

  _id_0922::_id_395E(istrue(var_0));
}

_id_8707(var_0) {
  var_1 = getarraykeys(level._id_1455["perk_0"]);

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return 1;
  }

  var_2 = getarraykeys(level._id_1455["perk_1"]);

  if(scripts\engine\utility::array_contains(var_2, var_0)) {
    return 1;
  }

  var_3 = getarraykeys(level._id_1455["perk_2"]);
  return scripts\engine\utility::array_contains(var_3, var_0);
}

_id_8580(var_0) {
  if(isDefined(self._id_3BB3) && isDefined(self._id_3BB3[var_0]) && isDefined(self._id_3BB3[var_0]._id_AA43) && self._id_3BB3[var_0]._id_AA43 == 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_A689(var_0) {
  self notify(self._id_3BB3[var_0]._id_FE50);
}

_id_A687(var_0) {
  self notify(level._id_3BB3[var_0]._id_F28A);
}

_id_4F43(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

_id_86F7(var_0) {
  if(!_id_86FD()) {
    return 0;
  }

  if(self getplayerdata("cp", "upgrades_enabled_flags", var_0)) {
    return 1;
  } else {
    return 0;
  }
}

_id_156C(var_0, var_1) {
  if(var_0) {
    if(!isDefined(self._id_F038) && isDefined(var_1)) {
      foreach(var_3 in self._id_F038) {
        if(var_3 == var_1) {
          self._id_F038 = scripts\engine\utility::array_remove(self._id_F038, var_1);
        }
      }
    }

    self._id_4AAD--;

    if(!self._id_4AAD) {
      self._id_F038 = [];
      self._id_30FD = 1;
      self notify("can_teleport");
    }
  } else {
    if(!isDefined(self._id_F038)) {
      self._id_F038 = [];
    }

    if(isDefined(var_1)) {
      self._id_F038[self._id_F038.size] = var_1;
    }

    self._id_4AAD++;
    self._id_30FD = 0;
  }
}

_id_8928() {
  return !isDefined(self._id_4AA3) || !self._id_4AA3;
}

_id_8A9C() {
  return !isDefined(self._id_4AAD) || !self._id_4AAD;
}

_id_1567(var_0) {
  if(var_0) {
    self._id_4A9F--;

    if(!self._id_4A9F) {
      self._id_8394 = undefined;
    }
  } else {
    self._id_4A9F++;
    self._id_8394 = 1;
  }
}

_id_1A57() {
  return self._id_4A9F < 1;
}

_id_0C4B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = "tag_origin";
  }

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  if(!isDefined(self._id_B70D)) {
    self._id_B70D = 0;
  }

  self._id_B70D++;

  if(self._id_B70D == 1) {
    self linkto(var_1, var_2, var_3, var_4);
  }
}

_id_0D9D() {
  if(_id_8993()) {
    self._id_B70D--;

    if(self._id_B70D <= 0) {
      self._id_B70D = 0;
      self unlink();
    }
  }
}

_id_655B() {
  var_0 = scripts\engine\utility::_id_655C();

  if(!var_0.size) {
    return undefined;
  }

  return var_0[0];
}

_id_8993() {
  return isDefined(self._id_B70D) && self._id_B70D > 0;
}

_id_5201(var_0) {
  if(var_0) {
    self._id_7E8C++;
    self setclientomnvar("zm_ui_unlimited_ammo", 1);
  } else {
    if(self._id_7E8C > 0) {
      self._id_7E8C--;
    }

    if(!self._id_7E8C) {
      self setclientomnvar("zm_ui_unlimited_ammo", 0);
    }
  }
}

_id_88C4() {
  return self._id_7E8C >= 1;
}

_id_1565(var_0) {
  if(!isDefined(self._id_5241)) {
    self._id_5241 = 0;
  }

  if(var_0) {
    self._id_5241++;
    self _meth_86B3(1);
    self _meth_86B2(1);
  } else {
    self._id_5241--;

    if(self._id_5241 < 0) {
      self._id_5241 = 0;
    }

    if(!self._id_5241) {
      self _meth_86B3(0);
      self _meth_86B2(0);
    }
  }
}

_id_1569(var_0) {
  if(!isDefined(self._id_5248)) {
    self._id_5248 = 0;
  }

  if(var_0) {
    self._id_5248++;
    _id_7908(1);
  } else {
    self._id_5248--;

    if(self._id_5248 < 0) {
      self._id_5248 = 0;
    }

    if(!self._id_5248) {
      _id_DCC4();
    }
  }
}

_id_8633() {
  if(isDefined(self._id_5248) && self._id_5248 > 0) {
    return 1;
  }

  return 0;
}

_id_1566(var_0) {
  if(var_0) {
    self.enabledignoreme++;
    self.ignoreme = 1;
  } else {
    self.enabledignoreme--;

    if(!self.enabledignoreme) {
      self.ignoreme = 0;
    }
  }
}

_id_156B(var_0) {
  if(var_0) {
    self._id_524B++;
    self._id_DBD8 = 1;
  } else {
    self._id_524B--;

    if(!self._id_524B) {
      self._id_DBD8 = 0;
    }
  }
}

_id_156A(var_0) {
  if(var_0) {
    self._id_524A++;
    self._id_DBD6 = 1;
  } else {
    self._id_524A--;

    if(!self._id_524A) {
      self._id_DBD6 = 0;
    }
  }
}

_id_8903() {
  return self._id_524B >= 1;
}

_id_87F2() {
  return self._id_524A >= 1;
}

_id_88B5() {
  return self.enabledignoreme >= 1;
}

_id_5E70() {
  scripts\common\input_allow::_id_38B0("usability");
  self enableusability();
}

_id_86FD() {
  return 0;

  if(getdvarint("#x323c4e436819d983c") > 0) {
    return 1;
  }

  return 0;
}

_id_3D17(var_0) {
  if(!isDefined(var_0)) {
    return "none";
  }

  if(isweapon(var_0) && isnullweapon(var_0)) {
    return "none";
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return "none";
  }

  var_1 = _id_6902(var_0);
  var_2 = _func_0222("mp/statstable.csv", 4, var_1, 1);

  if(var_2 == "" && isDefined(level._id_60AE)) {
    if(isDefined(var_0)) {
      var_1 = _id_6902(var_0);
      var_2 = _func_0222(level._id_60AE, 4, var_1, 2);
    }
  }

  if(_id_8834(var_0)) {
    var_2 = "weapon_mg";
  } else if(isweapon(var_0) && isnullweapon(var_0)) {
    var_2 = "other";
  } else if(_func_0121(var_0) && var_0 == "none") {
    var_2 = "other";
  } else if(var_2 == "") {
    var_2 = "other";
  }

  return var_2;
}

_id_85F4() {
  return istrue(self._id_85F4);
}

_id_7521() {
  return istrue(self._id_7521);
}

_id_5A41(var_0, var_1) {
  var_2 = self _meth_8195();
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;

  foreach(var_7 in var_2) {
    if(var_7 != var_0) {
      if(isnullweapon(var_7)) {
        continue;
      }
      var_8 = var_7.basename;

      if(var_8 != "alienthrowingknife_mp" && var_8 != "alientrophy_mp" && var_8 != "iw6_aliendlc21_mp") {
        self takeweapon(var_7);
      }

      continue;
    }

    if(!isnullweapon(var_7)) {
      var_5 = self _meth_8109(var_7);
      self setweaponammostock(var_7, var_5 + var_1);
      var_3 = 1;
      break;
    }
  }

  if(var_3 == 0) {
    _giveweapon(var_0);
    self setweaponammostock(var_0, var_1);
  }
}

_id_6A18(var_0) {
  switch (var_0) {
    case "arc_grenade_mp":
    case "zom_repulsor_mp":
    case "splash_grenade_zm":
    case "splash_grenade_mp":
    case "impalement_spike_mp":
    case "mortar_shelljugg_mp":
    case "proximity_explosive_mp":
    case "bouncing_betty_mp":
    case "throwingknifesmokewall_mp":
    case "throwingknifec4_mp":
    case "at_mine_mp":
    case "claymore_mp":
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "c4_mp_p":
    case "c4_zm":
    case "frag_grenade_mp":
    case "frag_grenade_zm":
    case "pop_rocket_mp":
    case "throwingknife_mp":
    case "throwingknife":
    case "gas_mp":
    case "thermite_mp":
    case "molotov_mp":
    case "molotov":
    case "semtex_mp":
    case "semtex":
    case "frag":
      var_1 = "lethal";
      break;
    case "ztransponder_mp":
    case "transponder_mp":
    case "blackout_grenade_mp":
    case "player_trophy_system_mp":
    case "proto_ricochet_device_mp":
    case "emp_grenade_mp":
    case "trophy_mp":
    case "mobile_radar_mp":
    case "gravity_grenade_mp":
    case "alienflare_mp":
    case "concussion_grenade_mp":
    case "smoke_grenadejugg_mp":
    case "smoke_grenade_mp":
    case "thermobaric_grenade_mp":
    case "portal_generator_zm":
    case "portal_generator_mp":
    case "flash_grenade_mp":
    case "dud_grenade_zm":
    case "noisemaker":
    case "teargas":
    case "signal":
    case "smoke_tall":
    case "smoke":
    case "flash":
      var_1 = "tactical";
      break;
    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

getequipmenttypeequipref(var_0) {
  var_1 = _id_0728::_id_69D6(var_0);

  switch (var_1) {
    case "primary":
      var_2 = "lethal";
      break;
    case "secondary":
      var_2 = "tactical";
      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

_id_6FC3(var_0) {
  if(var_0 == "none" || var_0 == "specialty_null") {
    self _meth_835E("none");
  } else {
    self._id_CFE2 = var_0;

    if(issubstr(var_0, "_mp")) {
      switch (var_0) {
        case "dud_grenade_zm":
        case "splash_grenade_zm":
        case "splash_grenade_mp":
        case "mortar_shelljugg_mp":
        case "cluster_grenade_zm":
        case "semtex_zm":
        case "frag_grenade_mp":
        case "frag_grenade_zm":
        case "semtex_mp":
          self _meth_835E("frag");
          break;
        case "throwingknifejugg_mp":
        case "throwingknifesmokewall_mp":
        case "throwingknifec4_mp":
        case "c4_zm":
        case "throwingknife_mp":
          self _meth_835E("throwingknife");
          break;
        case "player_trophy_system_mp":
        case "proto_ricochet_device_mp":
        case "emp_grenade_mp":
        case "trophy_mp":
        case "mobile_radar_mp":
        case "alienflare_mp":
        case "thermobaric_grenade_mp":
        case "flash_grenade_mp":
          self _meth_835E("flash");
          break;
        case "concussion_grenade_mp":
        case "smoke_grenadejugg_mp":
        case "smoke_grenade_mp":
          self _meth_835E("smoke");
          break;
        case "ztransponder_mp":
        case "transponder_mp":
        case "zom_repulsor_mp":
        default:
          self _meth_835E("other");
          break;
      }

      _giveweapon(var_0, 0);

      switch (var_0) {
        case "ztransponder_mp":
        case "transponder_mp":
        case "player_trophy_system_mp":
        case "proto_ricochet_device_mp":
        case "emp_grenade_mp":
        case "trophy_mp":
        case "mobile_radar_mp":
        case "gravity_grenade_mp":
        case "alienflare_mp":
        case "concussion_grenade_mp":
        case "smoke_grenade_mp":
        case "thermobaric_grenade_mp":
        case "flash_grenade_mp":
          self setweaponammoclip(var_0, 1);
          break;
        default:
          self _meth_819C(var_0);
          break;
      }

      _setperk(var_0);
      return;
    }

    _setperk(var_0);
  }
}

_id_0C48(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self launchgrenade(var_0, var_1, var_2, var_3, var_5);

  if(!isDefined(var_4)) {
    var_6._id_A6BF = 1;
  } else {
    var_6._id_A6BF = var_4;
  }

  var_6 setotherent(self);
  return var_6;
}

_id_A247(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1200;
  }

  if(isDefined(var_1)) {
    var_2 = vectornormalize(var_1);
  } else {
    var_2 = anglesToForward(self.angles);
  }

  var_3 = _func_025B((0, 0, 1), var_2);
  var_4 = vectornormalize(var_3);
  self _meth_8508(var_4, var_0);
}

_id_259D(var_0) {
  if(!isDefined(self._id_AFF8[var_0])) {
    self._id_AFF8[var_0] = 1;
  } else {
    self._id_AFF8[var_0]++;
  }

  if(self._id_AFF8[var_0] == 1 && _hasperk(var_0)) {
    foreach(var_6, var_2 in level._id_5853) {
      if(var_0 == var_6) {
        foreach(var_4 in var_2) {
          if(!isDefined(self._id_AFF8[var_4])) {
            self._id_AFF8[var_4] = 1;
          } else {
            self._id_AFF8[var_4]++;
          }

          if(self._id_AFF8[var_4] == 1) {}
        }

        break;
      }
    }
  }
}

_id_F934(var_0) {
  self._id_AFF8[var_0]--;

  if(self._id_AFF8[var_0] == 0) {
    self._id_AFF8[var_0] = undefined;

    if(_hasperk(var_0)) {
      foreach(var_6, var_2 in level._id_5853) {
        if(var_0 == var_6) {
          foreach(var_4 in var_2) {
            self._id_AFF8[var_4]--;

            if(self._id_AFF8[var_4] == 0) {
              self._id_AFF8[var_4] = undefined;
            }
          }

          break;
        }
      }
    }
  }
}

_id_6E6D(var_0) {
  var_1 = getweaponrootname(var_0);
  var_2 = _func_0222("mp/statstable.csv", 4, var_1, 1);

  if(var_2 == "") {
    var_3 = _id_EA63(var_0.basename, "_zm");
    var_2 = _func_0222("mp/statstable.csv", 4, var_3, 1);
  }

  if(_id_8834(var_0.basename)) {
    var_2 = "weapon_mg";
  } else if(_id_88F6(var_0.basename)) {
    var_2 = "killstreak";
  } else if(_id_8A7D(var_0.basename)) {
    var_2 = "super";
  } else if(var_0.basename == "none") {
    var_2 = "other";
  } else if(var_2 == "") {
    var_2 = "other";
  }

  return var_2;
}

_id_C48A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    if(!isDefined(self._id_10D9)) {
      return;
    }
    self._id_10D9[var_0] = undefined;
  } else {
    if(!isDefined(self._id_A2FB)) {
      return;
    }
    self._id_A2FB[var_0] = undefined;
  }
}

_id_10A2(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    if(!isDefined(self._id_10D9)) {
      self._id_10D9 = [];
    }

    self._id_10D9[var_0] = var_1;
  } else {
    if(!isDefined(self._id_A2FB)) {
      self._id_A2FB = [];
    }

    self._id_A2FB[var_0] = var_1;
  }
}

_id_69C1(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 1.0;

  if(isDefined(self._id_10D9)) {
    foreach(var_9 in self._id_10D9) {
      var_7 = var_7 + (var_9 - 1.0);
    }
  }

  var_11 = 1.0;

  if(isDefined(self._id_A2FB)) {
    foreach(var_9 in self._id_A2FB) {
      var_11 = var_11 * var_9;
    }
  }

  return var_7 * var_11;
}

_id_88D7(var_0) {
  switch (_func_0276(var_0)) {
    case "altmode":
    case "primary":
      return 1;
    default:
      return 0;
  }
}

_id_0BD6(var_0) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(var_0) {
    if(self.enabledcollisionnotifies == 0) {
      self enablecollisionnotifies(1);
    }

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1) {
      self enablecollisionnotifies(0);
    }

    self.enabledcollisionnotifies--;
  }
}

_id_7526(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = _func_00BC(var_0);

  for(var_3 = 0; var_3 < var_2; var_3++) {
    if(tolower(_func_00BF(var_0, var_3)) == tolower(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_86EC(var_0, var_1) {
  if(isDefined(var_1) && (var_1.basename == "iw7_beamtrap_zm" || var_1.basename == "iw7_escapevelocity_zm" || var_1.basename == "iw7_rockettrap_zm" || var_1.basename == "iw7_discotrap_zm" || var_1.basename == "iw7_chromosphere_zm" || var_1.basename == "iw7_buffertrap_zm" || var_1.basename == "iw7_electrictrap_zm" || var_1.basename == "iw7_fantrap_zm" || var_1.basename == "iw7_hydranttrap_zm" || var_1.basename == "iw7_moshtrap_zm")) {
    return 1;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0._id_F0B5)) {
    return 1;
  }

  if(!isDefined(var_0._id_039B) && !isDefined(var_0._id_0481)) {
    return 0;
  }

  if(isDefined(var_0._id_0481) && (var_0._id_0481 == "fence_generator" || var_0._id_0481 == "puddle_generator")) {
    return 1;
  }

  if(isDefined(var_0._id_039B) && var_0._id_039B == "fire_trap") {
    return 1;
  }

  return 0;
}

_id_C88A() {
  var_0 = self _meth_8191("primary");

  if(!self._id_75A5) {
    return;
  }
  foreach(var_2 in var_0) {
    if(weapontype(var_2) == "riotshield") {
      return var_2;
    }
  }
}

_id_B4CC(var_0, var_1) {
  return isDefined(var_0._id_E3B8) && var_0._id_E3B8 == var_1;
}

_id_7524(var_0) {
  if(isDefined(self._id_E3B8)) {
    return _id_B4CC(self, "stun_ammo");
  }

  if(!isDefined(var_0)) {
    var_1 = self getcurrentweapon();
  } else if(isweapon(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = makeweaponfromstring(var_0);
  }

  if(isnullweapon(var_1)) {
    var_1 = self getweaponslistprimaries()[0];
  }

  var_2 = _id_6CE3(var_1);

  if(isDefined(self._id_E3BA) && isDefined(self._id_E3BA[var_2]) && self._id_E3BA[var_2] > 0) {
    return 1;
  }

  if(isDefined(self._id_E3BC) && isDefined(self._id_E3BC[var_2]) && self._id_E3BC[var_2] > 0) {
    return 1;
  }

  return 0;
}

_id_86A0() {
  return level._id_C81C;
}

_id_85EA() {
  return level._id_74C4;
}

_id_856C() {
  return level._id_3323 == 1;
}

_id_8AB9(var_0) {
  if(isDefined(var_0) && var_0.basename != "none") {
    if(_id_8A7D(var_0.basename)) {
      return 1;
    }

    var_1 = _id_6A18(var_0.basename);

    if(isDefined(var_1) && var_1 == "lethal") {
      return 1;
    }
  }

  return 0;
}

_id_8A09(var_0) {
  if(isweapon(var_0) && isnullweapon(var_0)) {
    return 0;
  }

  if(_func_0121(var_0) && var_0 == "none") {
    return 0;
  }

  return weapontype(var_0) == "riotshield";
}

_id_874D(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  return _func_0276(var_0) == "altmode";
}

_id_75A5() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(_id_8A09(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

_id_85B5(var_0) {
  return var_0 == "";
}

_id_A695(var_0, var_1) {
  self waittill(var_0);
  waittillframeend;
  self notify(var_1);
}

_id_B531() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self._id_8F17 = self.origin;

  for(;;) {
    self waittill("damage");
    self._id_8F17 = self.origin;
  }
}

_id_8891(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.owner)) {
      if(var_3._id_00EC == "script_vehicle") {
        return 0;
      }

      if(var_3._id_00EC == "misc_turret") {
        return 0;
      }

      if(var_3._id_00EC == "script_model") {
        return 0;
      }
    }

    if(isDefined(var_3._id_1210)) {
      if(var_3._id_1210 == "dog" || var_3._id_1210 == "alien") {
        return 0;
      }
    }
  }

  if(scripts\cp\covenants\cp_critical_expertise::is_critical_hit(var_3)) {
    return 1;
  }

  return (var_1 == "head" || var_1 == "helmet" || var_1 == "neck") && var_2 != "MOD_MELEE" && var_2 != "MOD_IMPACT" && var_2 != "MOD_SCARAB" && var_2 != "MOD_CRUSH" && var_2 != "MOD_HEAD_SHOT" && !_id_8834(var_0.basename);
}

_id_6DC4(var_0, var_1) {
  var_2 = [];

  if(!isDefined(var_1) || var_1) {
    foreach(var_4 in level.characters) {
      if(var_4.team == var_0) {
        var_2[var_2.size] = var_4;
      }
    }
  } else {
    foreach(var_4 in level.players) {
      if(var_4.team == var_0) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_id_6BE2(var_0) {
  if(level._id_A2FC) {}

  if(var_0 == "allies") {
    return "axis";
  } else if(var_0 == "axis") {
    return "allies";
  } else {
    return "none";
  }
}

_id_B3C4(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("intermission");
  self endon("death");
  self._id_B3C4 = newclienthudelem(self);
  self._id_B3C4.x = 0;
  self._id_B3C4.y = 0;
  self._id_B3C4 setshader("black", 640, 480);
  self._id_B3C4.alignx = "left";
  self._id_B3C4.aligny = "top";
  self._id_B3C4.sort = 1;
  self._id_B3C4.horzalign = "fullscreen";
  self._id_B3C4.vertalign = "fullscreen";
  self._id_B3C4.alpha = 0;
  self._id_B3C4._id_01D6 = 1;

  if(!istrue(var_3)) {
    self._id_B3C4 fadeovertime(var_0);
  }

  self._id_B3C4.alpha = 1;

  if(!istrue(var_3)) {
    wait(var_0 + 0.05);
  }

  wait(var_1);
  self._id_B3C4 fadeovertime(var_2);
  self._id_B3C4.alpha = 0;
  wait(var_2 + 0.05);
  self._id_B3C4 destroy();
}

_id_C87D() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(_id_8A09(var_3)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

riotshield_hasweaponname(var_0) {
  var_1 = 0;
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(var_4.basename == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

_id_C875(var_0, var_1) {
  var_2 = undefined;

  if(var_0) {
    self._id_C887 = var_1;
    var_2 = "j_shield_ri";
  } else {
    self._id_C888 = var_1;
    var_2 = "tag_shield_back";
  }

  if(!isDefined(self._id_419A) || self._id_419A != var_2) {
    self._id_419A = var_2;
    self _meth_8021(var_1, var_2);

    if(isDefined(level.onshieldmodelattached)) {
      self[[level.onshieldmodelattached]](var_1);
    }
  }

  self._id_75A5 = _id_C87D();
  self._id_75A6 = var_0;
  self.hasriotshieldww = riotshield_hasweaponname("s4_me_rindigoww_mp");
}

_id_C878(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(var_0) {
    var_1 = self._id_C887;
    var_2 = "j_shield_ri";
  } else {
    var_1 = self._id_C888;
    var_2 = "tag_shield_back";
  }

  if(isDefined(self._id_419A) && self._id_419A == var_2) {
    if(isDefined(level.onshieldmodeldetached)) {
      self[[level.onshieldmodeldetached]](var_1);
    }

    self._id_419A = undefined;
    self _meth_809F(var_1, var_2);
  }

  if(var_0) {
    self._id_C887 = undefined;
  } else {
    self._id_C888 = undefined;
  }

  self._id_75A5 = _id_C87D();
  self._id_75A6 = undefined;
  self.hasriotshieldww = riotshield_hasweaponname("s4_me_rindigoww_mp");
}

_id_90FE(var_0, var_1) {
  if(_id_C87D()) {
    if(isDefined(self._id_C887)) {
      _id_C878(1);
    }

    if(isDefined(self._id_C888)) {
      _id_C878(0);
    }
  }
}

_id_C880(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(var_0) {
    var_3 = self._id_C887;
    var_1 = "j_shield_ri";
    var_2 = "tag_shield_back";
  } else {
    var_3 = self._id_C888;
    var_1 = "tag_shield_back";
    var_2 = "j_shield_ri";
  }

  if(!isDefined(self._id_419A) || self._id_419A != var_2) {
    self._id_419A = var_2;
    self _meth_823A(var_3, var_1, var_2);
  }

  if(var_0) {
    self._id_C888 = var_3;
    self._id_C887 = undefined;
    self._id_75A6 = 0;
  } else {
    self._id_C887 = var_3;
    self._id_C888 = undefined;
    self._id_75A6 = 1;
  }
}

_id_C877() {
  self._id_75A6 = 0;
  self._id_75A5 = 0;
  self._id_C888 = undefined;
  self._id_C887 = undefined;
  self._id_75A6 = undefined;
  self.hasriotshieldww = 0;
}

get_riot_shield_melee_damage_percent() {
  return 0.5;
}

get_riot_shield_bullet_damage_percent() {
  return 0.5;
}

isprotectedbyriotshieldcp(var_0) {
  if(isDefined(var_0._id_75A5) && var_0._id_75A5) {
    var_1 = vectornormalize(self.origin - var_0.origin);
    var_2 = anglesToForward(var_0.angles);
    var_3 = vectordot(var_2, var_1);

    if(istrue(var_0._id_75A6)) {
      if(var_3 > 0) {
        return [1, 1];
      }
    } else if(var_3 < 0)
      return [1, 0];
  }

  return [0, 0];
}

_id_C399() {
  self setclientomnvar("zombie_souvenir_piece_index", 0);

  if(isDefined(level._id_3E51)) {
    self[[level._id_3E51]]();
  }

  self._id_4167 = undefined;
}

_id_E9BB(var_0, var_1) {
  self._id_3D58 = self getweaponslistall();
  self._id_3D62 = _id_642E(self, var_1);
  self._id_3D63 = [];
  var_2 = [];

  foreach(var_4 in self._id_3D58) {
    if(var_4._id_0245) {
      continue;
    }
    if(issubstr(var_4.basename, "iw8_execution_")) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  self._id_3D58 = var_2;

  foreach(var_4 in self._id_3D58) {
    var_7 = getcompleteweaponname(var_4);
    self._id_3D5F[var_7] = self getweaponammoclip(var_4);
    self._id_3D61[var_7] = self getweaponammostock(var_4);

    if(issubstr(var_4.basename, "akimbo")) {
      self._id_3D60[var_7] = self getweaponammoclip(var_4, "left");
    }

    var_8 = _id_6CE3(var_4);

    if(isDefined(self._id_AE0A[var_8])) {
      self._id_3D63[var_7] = self._id_AE0A[var_8]._id_991E;
    }
  }

  if(isDefined(var_0)) {
    var_10 = [];

    foreach(var_4 in self._id_3D58) {
      var_12 = 0;

      foreach(var_14 in var_0) {
        if(var_4 == var_14) {
          var_12 = 1;
          break;
        } else if(var_4 _meth_8625() == var_14) {
          var_12 = 1;
          break;
        }
      }

      if(var_12) {
        continue;
      }
      var_10[var_10.size] = var_4;
    }

    self._id_3D58 = var_10;

    foreach(var_14 in var_0) {
      if(self._id_3D62 == var_14) {
        self._id_3D62 = _func_0375();
        break;
      }
    }
  }
}

_id_642E(var_0, var_1) {
  var_2 = var_0 getcurrentweapon();

  if(istrue(var_1) && _id_8632(var_2)) {
    var_2 = var_0 getweaponslistall()[1];
  }

  return var_2;
}

is_throwable_melee_weapon(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "s4_me_icepick_mp_v301":
    case "s4_me_axe_mp_v302":
    case "s4_me_axe_mp_v301":
    case "s4_me_axe_mp":
    case "s4_me_icepick_mp":
      return 1;
    default:
      return 0;
  }
}

_id_8632(var_0, var_1) {
  var_2 = undefined;

  if(isweapon(var_0)) {
    var_2 = var_0.basename;
  } else {
    var_2 = var_0;
  }

  switch (var_2) {
    case "iw7_knife_zm_disco":
    case "alt_iw7_knife_zm_survivor":
    case "alt_iw7_knife_zm_grunge":
    case "alt_iw7_knife_zm_hiphop":
    case "alt_iw7_knife_zm_raver":
    case "alt_iw7_knife_zm_chola":
    case "iw7_knife_zm_survivor":
    case "iw7_knife_zm_grunge":
    case "iw7_knife_zm_hiphop":
    case "iw7_knife_zm_raver":
    case "iw7_knife_zm_chola":
    case "alt_iw7_knife_zm_vgirl":
    case "alt_iw7_knife_zm_rapper":
    case "alt_iw7_knife_zm_nerd":
    case "alt_iw7_knife_zm_jock":
    case "alt_iw7_knife_zm":
    case "iw7_knife_zm_vgirl":
    case "iw7_knife_zm_rapper":
    case "iw7_knife_zm_nerd":
    case "iw7_knife_zm_jock":
    case "alt_iw7_knife_zm_hoff":
    case "iw7_knife_zm_hoff":
    case "iw8_knife_mp":
      return 1;
    case "s4_me_shovel_mp":
    case "s4_me_leiomano_mp":
    case "s4_me_katana_mp":
    case "s4_me_knife_mp":
    case "s4_me_rindigo_mp":
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
    case "iw7_fists_zm_kevinsmith":
    case "iw7_fists_zm_raver":
    case "iw7_fists_zm_hiphop":
    case "iw7_fists_zm_grunge":
    case "iw7_fists_zm_chola":
    case "iw7_fists_zm":
    case "s4_me_axe_mp":
    case "s4_me_icepick_mp":
      if(istrue(var_1)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 0;
  }
}

_id_868A(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "iw7_katana_zm_pap2":
    case "iw7_katana_zm_pap1":
    case "iw7_nunchucks_zm_pap2":
    case "iw7_nunchucks_zm_pap1":
    case "iw7_katana_zm":
    case "iw7_nunchucks_zm":
    case "iw7_axe_zm_pap2":
    case "iw7_axe_zm_pap1":
    case "iw7_axe_zm":
      return 1;
  }

  return 0;
}

_id_C706(var_0, var_1, var_2) {
  if(!isDefined(self._id_3D58) || !isDefined(self._id_3D62) || !isDefined(self._id_3D5F) || !isDefined(self._id_3D61)) {}

  var_1 = _id_459B(var_1, 0);
  var_2 = _id_459B(var_2, 1);

  if(var_1) {
    foreach(var_4 in self._id_3D58) {
      if(_func_0276(var_4) == "offhand") {
        self._id_3D58 = scripts\engine\utility::array_remove(self._id_3D58, var_4);
      }
    }
  }

  var_6 = self getweaponslistall();

  foreach(var_4 in var_6) {
    if(!scripts\engine\utility::array_contains(self._id_3D58, var_4) && !_id_7D6C(var_0, var_4)) {
      self takeweapon(var_4);
    }
  }

  if(isDefined(self._id_C881)) {
    if(!scripts\engine\utility::array_contains(self._id_3D58, self._id_C881)) {
      self._id_3D58[self._id_3D58.size] = self._id_C881;
    }

    self._id_C881 = undefined;
  }

  foreach(var_4 in self._id_3D58) {
    if(isnullweapon(var_4)) {
      continue;
    }
    if(!self hasweapon(var_4)) {
      self giveweapon(var_4, -1, 0, -1, 1);
    }

    var_10 = getcompleteweaponname(var_4);

    if(isDefined(self._id_BADD) && self._id_BADD == var_10) {
      self _meth_849C(var_4);
    }

    if(isDefined(self._id_BAE1) && self._id_BAE1 == var_10) {
      self _meth_849D(var_4);
    }

    if(isDefined(self._id_E3D1) && self._id_E3D1 == var_10) {
      self _meth_84E9(var_4);
    }

    if(var_2) {
      if(isDefined(self._id_3D5F[var_10])) {
        self setweaponammoclip(var_4, self._id_3D5F[var_10]);
      }

      if(isDefined(self._id_3D60)) {
        if(isDefined(self._id_3D60[var_10])) {
          self setweaponammoclip(var_4, self._id_3D60[var_10], "left");
        }
      }

      if(isDefined(self._id_3D61[var_10])) {
        self setweaponammostock(var_4, self._id_3D61[var_10]);
      }
    }

    if(isDefined(self._id_3D63[var_10])) {
      var_11 = spawnStruct();
      var_11._id_991E = self._id_3D63[var_10];
      self._id_AE0A[_id_6CE3(var_4)] = var_11;
    }
  }

  var_13 = self._id_3D62;

  if(_func_0376(var_13)) {
    foreach(var_15 in self._id_3D58) {
      if(scripts\cp\cp_weapon::_id_8795(var_15)) {
        var_13 = var_15;
        break;
      }
    }
  }

  if(scripts\common\utility::_id_8724()) {
    self switchtoweaponimmediate(var_13);
  }

  if(!istrue(self._id_2C59)) {
    self._id_3D58 = undefined;
    self._id_3D62 = undefined;
    self._id_3D5F = undefined;
    self._id_3D61 = undefined;
    self._id_3D60 = undefined;
  }

  if(isDefined(level._id_1A33)) {
    self[[level._id_1A33]]();
  }
}

_id_C703(var_0) {
  if(!isDefined(self._id_3D58) || !isDefined(self._id_3D62) || !isDefined(self._id_3D5F) || !isDefined(self._id_3D61)) {}

  self._id_BCCC = [];
  var_1 = 0;

  foreach(var_3 in self._id_3D58) {
    if(_id_88D7(var_3)) {
      self._id_BCCC[var_1] = var_3;
      var_1 = var_1 + 1;
    }
  }

  var_5 = 0;

  foreach(var_3 in self._id_BCCC) {
    if(var_5 < 3) {
      if(var_3._id_0245) {
        continue;
      }
      if(!self hasweapon(var_3)) {
        self giveweapon(var_3, -1, 0, -1, 1);
      }

      var_7 = getcompleteweaponname(var_3);
      self setweaponammoclip(var_3, self._id_3D5F[var_7]);
      self setweaponammostock(var_3, self._id_3D61[var_7]);

      if(isDefined(self._id_3D63[var_7])) {
        var_8 = spawnStruct();
        var_8._id_991E = self._id_3D63[var_7];
        self._id_AE0A[_id_6CE3(var_3)] = var_8;
      }

      var_5++;
    }
  }

  var_10 = self._id_3D62;

  if(!isDefined(var_10) || !self hasweapon(var_10) || isnullweapon(var_10)) {
    var_10 = _id_6E8F();
  }

  self switchtoweaponimmediate(var_10);
  self._id_3D58 = undefined;
  self._id_3D62 = undefined;
  self._id_3D5F = undefined;
  self._id_3D61 = undefined;
}

_id_3918() {
  self._id_3D58 = [];
  self._id_3D62 = _func_0375();
  self._id_3D5F = [];
  self._id_3D60 = [];
  self._id_3D61 = [];
  self._id_3D63 = [];
}

_id_1063(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = undefined;
    var_7 = undefined;

    if(isweapon(var_5)) {
      var_6 = var_5;
      var_7 = getcompleteweaponname(var_5);
    } else {
      var_6 = makeweaponfromstring(var_5);
      var_7 = var_5;
    }

    if(var_7 != "none") {
      self._id_3D58[self._id_3D58.size] = var_6;
      self._id_3D5F[var_7] = var_1[var_7];
      self._id_3D61[var_7] = var_2[var_7];
    }
  }

  self._id_3D62 = var_3;
}

_id_7D6C(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(var_0, var_1);
}

_id_FFD6(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

_id_C705() {
  self giveweapon("super_default_zm");
  self _meth_84E9("super_default_zm");
  self._id_E3D1 = "super_default_zm";

  if(istrue(self._id_3BAF)) {
    self setweaponammoclip("super_default_zm", 1);
  }
}

_id_6974(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1, "script_noteworthy");
  var_4 = _func_0204(var_3, var_0)[0];

  if(isDefined(var_2) && distancesquared(var_0, var_4.origin) > _func_0219(var_2)) {
    return undefined;
  }

  return var_4;
}

_id_872B() {
  return isagent(self) && isDefined(self._id_E3D8) && (self._id_E3D8 == "humanoid" || self._id_E3D8 == "zombie");
}

_id_86BE() {
  return isagent(self) && isDefined(self._id_E3D8) && self._id_E3D8 == "human";
}

_id_3D1D(var_0) {
  if(!isDefined(level._id_3D1C)) {
    return 0;
  }

  return isDefined(level._id_3D1C[var_0]);
}

_id_3D1B(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(level._id_3D1C)) {
      level._id_3D1C = [];
    }

    if(_func_0107(var_0)) {
      foreach(var_2 in var_0) {
        level._id_3D1C[var_2] = 1;
      }
    } else
      level._id_3D1C[var_0] = 1;
  }
}

_id_99A0(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1) {
    return self _meth_8220(var_0, 1);
  } else {
    return self _meth_8220(var_0);
  }
}

_id_6376(var_0) {
  if(isDefined(var_0)) {
    if(isPlayer(var_0)) {
      return var_0;
    }

    if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
      return var_0.owner;
    }
  }

  return undefined;
}

_id_C499(var_0) {
  if(isDefined(level._id_56D9)) {
    foreach(var_2 in level._id_56D9) {
      foreach(var_4 in var_0) {
        if(_id_1DA5(var_4) == var_2) {
          var_0 = scripts\engine\utility::array_remove(var_0, var_4);
        }
      }
    }
  }

  return var_0;
}

_id_6CD2(var_0, var_1, var_2) {
  var_3 = [];

  if(_id_10D9C(var_0, var_1, "passive_random_attachments")) {
    if(0) {
      var_4 = _id_68E9(var_0, var_2, 0);
      var_3[var_3.size] = var_4[randomint(var_4.size)];
    } else {
      var_5 = int(max(0, 5 - var_2.size));

      if(var_5 > 0) {
        var_6 = randomintrange(1, var_5 + 1);
        var_3 = _id_2D08(var_0, var_6, var_2);
      }
    }
  }

  return var_3;
}

_id_10D9C(var_0, var_1, var_2) {
  var_3 = _id_6E80(var_0, var_1);

  if(!isDefined(var_3) || var_3.size <= 0) {
    return 0;
  }

  foreach(var_5 in var_3) {
    if(var_2 == var_5) {
      return 1;
    }
  }

  return 0;
}

_id_2D08(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = scripts\cp\cp_weapon::_id_68E6(var_0, var_2);

  if(var_4.size > 0) {
    var_3 = [];
    var_5 = scripts\engine\utility::_id_1BBD(var_4);

    foreach(var_10, var_7 in var_5) {
      if(var_1 <= 0) {
        break;
      }

      var_8 = 1;

      switch (var_10) {
        case "backpiece":
        case "frontpiece":
        case "magazine":
        case "muzzle":
        case "optic":
        case "reargrip":
        case "undermount":
        case "barrel":
        case "trigger":
          var_8 = 1;
          break;
        case "extra":
        case "gunperk2":
        case "gunperk":
        case "rail":
        case "pap":
        case "perk":
          var_8 = 0;
          break;
        default:
          var_8 = randomintrange(1, var_1 + 1);
          break;
      }

      if(var_8 > 0) {
        if(var_8 > var_7.size) {
          var_8 = var_7.size;
        }

        var_1 = var_1 - var_8;

        for(var_7 = scripts\engine\utility::_id_1BBD(var_7); var_8 > 0; var_8--) {
          var_9 = var_7[var_7.size - var_8];

          if(!issubstr(var_9, "ark") && !issubstr(var_9, "arcane")) {
            var_3[var_3.size] = var_9;
          }
        }
      }
    }
  }

  return var_3;
}

_id_68E9(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = _id_6E68(var_0);
  var_4 = [];

  foreach(var_6 in var_3) {
    var_7 = _id_68E5(var_6);

    if(!var_2 && var_7 == "rail") {
      continue;
    }
    if(isDefined(var_1) && _id_9553(var_1, var_6)) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  return var_4;
}

_id_9553(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_6E68(var_0) {
  var_1 = getweaponrootname(var_0);

  if(!isDefined(level._id_10D64)) {
    level._id_10D64 = [];
  }

  if(!isDefined(level._id_10D64[var_1])) {
    var_2 = [];

    for(var_3 = 0; var_3 < 10; var_3++) {
      var_4 = _func_0222("mp/statstable.csv", 4, var_1, 10 + var_3);

      if(var_4 == "") {
        break;
      }

      var_2[var_2.size] = var_4;
    }

    level._id_10D64[var_1] = var_2;
  }

  return level._id_10D64[var_1];
}

_id_6E7F(var_0) {
  return -1;
}

_id_6E6B(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "camo");

  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  } else {
    return "none";
  }
}

_id_6E6E(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "cosmeticAttachment");

  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  } else {
    return "none";
  }
}

_id_6E88(var_0) {
  var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombiePlayerWeaponModels", var_0, "reticle");

  if(isDefined(var_1) && var_1 != "none") {
    return var_1;
  } else {
    return "none";
  }
}

_id_A2AE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _id_10D61(var_0);
  var_10 = _id_2D16(var_0, var_4);
  var_11 = _id_3D17(var_10);

  if(isDefined(var_9)) {
    var_1 = scripts\engine\utility::_id_1B9D(var_1, var_9);
  }

  var_1 = _id_10D65(var_1);
  var_1 = _id_C499(var_1);

  for(var_12 = 0; var_12 < var_1.size; var_12++) {
    var_1[var_12] = _id_1DA9(var_1[var_12], var_10);
  }

  if(isDefined(var_9)) {
    for(var_12 = 0; var_12 < var_9.size; var_12++) {
      var_9[var_12] = _id_1DA9(var_9[var_12], var_10);
    }
  }

  if(isDefined(var_9)) {
    var_1 = scripts\engine\utility::_id_1B9D(var_1, var_9);
  }

  var_1 = scripts\engine\utility::array_remove(var_1, "none");

  if(isDefined(var_8) && var_8 != "none") {
    var_1[var_1.size] = var_8;
  }

  if(var_1.size > 0) {
    var_1 = _id_5A44(var_1, var_10);
  }

  var_13 = [];

  foreach(var_15 in var_1) {
    var_16 = _id_1DA8(var_15);

    if(isDefined(var_16)) {
      var_13[var_13.size] = _id_1DA9(var_16, var_10);
    }
  }

  if(var_13.size > 0) {
    var_1 = scripts\engine\utility::_id_1B9D(var_1, var_13);
  }

  if(var_1.size > 0) {
    var_1 = scripts\engine\utility::_id_163E(var_1);
  }

  var_10 = _id_C0CC(var_10, var_1);

  foreach(var_19 in var_1) {
    var_10 = var_10 + ("+" + var_19);
  }

  if(issubstr(var_10, "iw7")) {
    var_10 = _id_2D1B(var_10, var_2, var_4);
    var_21 = 0;

    if(_id_88A7(var_10, var_4)) {
      var_21 = _id_88A8(var_10, var_1);
    }

    if(var_21) {
      var_10 = var_10 + "+scope1";
    } else {
      var_10 = _id_2D1C(var_10, var_3);
    }

    var_10 = _id_2D1D(var_10, var_4);
  }

  return var_10;
}

_id_C0CC(var_0, var_1) {
  if(isDefined(level._id_10D23) && isDefined(level._id_10D23[getweaponbasename(var_0)])) {
    return var_0;
  } else {
    switch (var_0) {
      case "iw7_machete_mp":
        if(istrue(self._id_22AC)) {
          var_0 = "iw7_machete_mp";
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 1 || istrue(self._id_553D)) {
          if(istrue(self._id_21C0)) {
            var_0 = "iw7_machete_mp";
          } else {
            var_0 = "iw7_machete_mp_pap1";
          }
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 2) {
          if(istrue(self._id_21C0)) {
            var_0 = "iw7_machete_mp_pap1";
          } else {
            var_0 = "iw7_machete_mp_pap2";
          }
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 3)
          var_0 = "iw7_machete_mp_pap2";

        break;
      case "iw7_two_headed_axe_mp":
        if(istrue(self._id_22AC)) {
          var_0 = "iw7_two_headed_axe_mp";
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 1 || istrue(self._id_553D)) {
          if(istrue(self._id_21C0)) {
            var_0 = "iw7_two_headed_axe_mp";
          } else {
            var_0 = "iw7_two_headed_axe_mp_pap1";
          }
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 2) {
          if(istrue(self._id_21C0)) {
            var_0 = "iw7_two_headed_axe_mp_pap1";
          } else {
            var_0 = "iw7_two_headed_axe_mp_pap2";
          }
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 3)
          var_0 = "iw7_two_headed_axe_mp_pap2";

        break;
      case "iw7_spiked_bat_mp":
        if(istrue(self._id_22AC)) {
          var_0 = "iw7_spiked_bat_mp";
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 1 || istrue(self._id_553D)) {
          if(istrue(self._id_21C0)) {
            var_0 = "iw7_spiked_bat_mp";
          } else {
            var_0 = "iw7_spiked_bat_mp_pap1";
          }
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 2) {
          if(istrue(self._id_21C0)) {
            var_0 = "iw7_spiked_bat_mp_pap1";
          } else {
            var_0 = "iw7_spiked_bat_mp_pap2";
          }
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 3)
          var_0 = "iw7_spiked_bat_mp_pap2";

        break;
      case "iw7_golf_club_mp":
        if(istrue(self._id_22AC)) {
          var_0 = "iw7_golf_club_mp";
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 1 || istrue(self._id_553D)) {
          if(istrue(self._id_21C0)) {
            var_0 = "iw7_golf_club_mp";
          } else {
            var_0 = "iw7_golf_club_mp_pap1";
          }
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 2) {
          if(istrue(self._id_21C0)) {
            var_0 = "iw7_golf_club_mp_pap1";
          } else {
            var_0 = "iw7_golf_club_mp_pap2";
          }
        } else if(isDefined(self._id_AE0A[_id_6CE3(var_0)]) && self._id_AE0A[_id_6CE3(var_0)]._id_991E == 3)
          var_0 = "iw7_golf_club_mp_pap2";

        break;
      case "iw7_axe_zm":
        if(scripts\engine\utility::array_contains(var_1, "axepap1")) {
          var_0 = "iw7_axe_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "axepap2")) {
          var_0 = "iw7_axe_zm_pap2";
        }

        break;
      case "iw7_katana_zm":
        if(scripts\engine\utility::array_contains(var_1, "katanapap1")) {
          var_0 = "iw7_katana_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "katanapap2")) {
          var_0 = "iw7_katana_zm_pap2";
        }

        break;
      case "iw7_nunchucks_zm":
        if(scripts\engine\utility::array_contains(var_1, "nunchuckspap1")) {
          var_0 = "iw7_nunchucks_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "nunchuckspap2")) {
          var_0 = "iw7_nunchucks_zm_pap2";
        }

        break;
      case "iw7_forgefreeze_zm":
        if(scripts\engine\utility::array_contains(var_1, "freezepap1")) {
          var_0 = "iw7_forgefreeze_zm_pap1";
        } else if(scripts\engine\utility::array_contains(var_1, "freezepap2")) {
          var_0 = "iw7_forgefreeze_zm_pap2";
        }

        break;
      case "iw7_shredder_zm":
        if(scripts\engine\utility::array_contains(var_1, "shredderpap1")) {
          var_0 = "iw7_shredder_zm_pap1";
        }

        break;
      case "iw7_dischord_zm":
        if(scripts\engine\utility::array_contains(var_1, "dischordpap1")) {
          var_0 = "iw7_dischord_zm_pap1";
        }

        break;
      case "iw7_facemelter_zm":
        if(scripts\engine\utility::array_contains(var_1, "fmpap1")) {
          var_0 = "iw7_facemelter_zm_pap1";
        }

        break;
      case "iw7_headcutter_zm":
        if(scripts\engine\utility::array_contains(var_1, "hcpap1")) {
          var_0 = "iw7_headcutter_zm_pap1";
        }

        break;
    }
  }

  return var_0;
}

_id_6859(var_0, var_1) {
  var_2 = _id_6902(var_1);
  return -1;
}

_id_10D9F(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_0) {
    case "iw7_glprox":
    case "iw7_lockon":
    case "iw7_chargeshot":
    case "iw7_axe":
    case "iw7_g18c":
    case "iw7_arclassic":
    case "iw7_spasc":
    case "iw7_cheytacc":
    case "iw7_ump45c":
    case "iw7_m1c":
      return 0;
    default:
      return 1;
  }
}

_id_10D65(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(level._id_1D93[var_3])) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_10D61(var_0) {
  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_1D7A)) {
    return level._id_10DB0[var_0]._id_1D7A;
  }

  return undefined;
}

_id_10D5F(var_0, var_1) {
  if(_id_88F6(var_0)) {
    return var_0;
  }

  if(var_0 == "s4_me_rindigoww") {
    return var_0 + "_mp";
  }

  if(var_0 == "s4_me_rindigoww_mp") {
    return var_0;
  }

  if(isDefined(var_1)) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level._id_10DAC[var_2]) && isDefined(level._id_10DAC[var_2]._id_1CEE)) {
      return level._id_10DAC[var_2]._id_1CEE;
    }
  }

  if(isDefined(level._id_10DB0[var_0]) && isDefined(level._id_10DB0[var_0]._id_1CED)) {
    return level._id_10DB0[var_0]._id_1CED;
  }

  return var_0;
}

_id_88F6(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(level._id_8DEE) && isDefined(level._id_8DEE[var_1])) {
    return 1;
  }

  return 0;
}

_id_2D16(var_0, var_1) {
  return _id_10D5F(var_0, var_1);
}

_id_6E66(var_0, var_1) {
  var_2 = "mp/loot/weapon/" + var_0 + ".csv";
  var_3 = _func_0222(var_2, 0, var_1, 3);
  return var_3;
}

_id_6E92(var_0, var_1) {
  var_2 = [];
  var_3 = _id_6E80(var_0, var_1);

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_6 = _id_6C13(var_5);

      if(!isDefined(var_6)) {
        continue;
      }
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

_id_6C13(var_0) {
  var_1 = _id_6C18(var_0);

  if(!isDefined(var_1) || !isDefined(var_1._id_1DAE)) {
    return undefined;
  }

  return var_1._id_1DAE;
}

_id_6E80(var_0, var_1) {
  return _id_6C17(var_0, var_1);
}

_id_6C17(var_0, var_1) {
  var_2 = _id_6B20(var_0, var_1);

  if(isDefined(var_2)) {
    return var_2._id_AEAC;
  }

  return undefined;
}

_id_6B20(var_0, var_1) {
  var_2 = getweaponrootname(var_0);

  if(!isDefined(level._id_989C)) {
    level._id_989C = [];
  }

  if(isDefined(level._id_989C[var_2]) && isDefined(level._id_989C[var_2][var_1])) {
    var_3 = level._id_989C[var_2][var_1];
    return var_3;
  }

  var_3 = _id_2EA9(var_0, var_2, var_1);

  if(isDefined(var_3)) {
    return var_3;
  }

  return undefined;
}

getweaponrootname(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = level._id_10DC8[var_1];

  if(isDefined(var_2)) {
    return var_2;
  }

  var_3 = var_1;
  var_4 = strtok(var_1, "_");
  var_5 = 0;

  if(var_4[0] == "alt") {
    var_5++;
  }

  if(var_4[var_5] == "iw8" || var_4[var_5] == "s4") {
    var_6 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "sr", "mg", "mr"];

    if(var_4.size > var_5 + 1) {
      if(scripts\engine\utility::array_contains(var_6, var_4[var_5 + 1]) && var_4.size > var_5 + 2) {
        var_1 = var_4[var_5] + "_" + var_4[var_5 + 1] + "_" + var_4[var_5 + 2];
      } else {
        var_1 = var_4[var_5] + "_" + var_4[var_5 + 1];
      }
    }
  }

  if(level._id_10DC8.size < 100) {
    level._id_10DC8[var_3] = var_1;
  }

  return var_1;
}

_id_69D8(var_0) {
  var_1 = getweaponrootname(var_0);

  if(isDefined(level._id_10DB0[var_1]) && isDefined(level._id_10DB0[var_1]._id_1CED)) {
    var_0 = level._id_10DB0[var_1]._id_1CED;
  }

  return var_0;
}

_id_10CFE(var_0, var_1) {
  if(isDefined(var_0[var_1 + 3]) && isDefined(var_0[var_1 + 4])) {
    return 1;
  }

  return 0;
}

_id_10D00(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  return issubstr(var_1, "commmon") || issubstr(var_1, "uncommon") || issubstr(var_1, "rare") || issubstr(var_1, "legendary") || issubstr(var_1, "epic") || issubstr(var_1, "godtier");
}

_id_10D01(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  return issubstr(var_1, "katana") || issubstr(var_1, "nunchucks");
}

_id_10D02(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  return issubstr(var_1, "two_headed") || issubstr(var_1, "spiked_bat") || issubstr(var_1, "machete") || issubstr(var_1, "golf_club");
}

_id_2EA9(var_0, var_1, var_2) {
  if(!isDefined(level._id_989C[var_1])) {
    level._id_989C[var_1] = [];
  }

  var_3 = _func_02F6(var_0);
  var_4 = _id_C0A8(var_3, var_2);
  level._id_989C[var_1][var_2] = var_4;
  return var_4;
}

_id_C0A8(var_0, var_1) {
  var_2 = tablelookuprownum(var_0, 0, var_1);
  var_3 = spawnStruct();
  var_3._id_C189 = tablelookupbyrow(var_0, var_2, 1);
  var_3._id_10D5E = tablelookupbyrow(var_0, var_2, 3);
  var_3._id_AEAC = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = tablelookupbyrow(var_0, var_2, 5 + var_4);

    if(isDefined(var_5) && var_5 != "") {
      var_3._id_AEAC[var_3._id_AEAC.size] = var_5;
    }
  }

  return var_3;
}

_id_3F0F(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("container_ammo_box_01_nophysics");
  var_1.angles = var_0.angles;
  var_1._id_0481 = var_0._id_0481;
  return var_1;
}

_id_3F0E(var_0) {
  if(istrue(self._id_1F84)) {
    return;
  }
  self show();
  self._id_1F84 = 1;
  var_1 = undefined;

  if(isDefined(var_0)) {
    if(_func_0121(var_0)) {
      var_1 = [var_0];
    } else {
      var_1 = var_0;
    }
  } else
    var_1 = ["brloot_munition_ammo", "brloot_munition_grenade_crate", "brloot_munition_armor"];

  self._id_9863 = scripts\engine\utility::random(var_1);
  var_2 = &"COOP_CRAFTING/AMMO_CRATE";
  var_3 = 1;

  switch (self._id_9863) {
    case "brloot_munition_grenade_crate":
      var_2 = &"CP_BR/GRENADE_CRATE";
      var_3 = 3;
      break;
    case "brloot_munition_armor":
      var_2 = &"CP_BR/ARMOR_CRATE";
      var_3 = 2;
      break;
    case "brloot_munition_deployable_cover":
      var_2 = &"EQUIPMENT/TACTICAL_COVER";
      var_3 = 2;
      break;
  }

  self setModel("offhand_wm_supportbox_killstreak");
  self.origin = self.origin + (0, 0, 16);
  _id_D5A6(undefined, "HINT_BUTTON", undefined, var_2, 25, "duration_none", "show", 128, 80, 128, 80);

  for(;;) {
    self waittill("trigger", var_4);

    if(!var_4 _id_8708()) {
      continue;
    }
    if(!_id_0780::_id_6F13(self._id_9863, var_4)) {
      continue;
    }
    self playsoundtoplayer("scavenger_pack_pickup", var_4);
    self makeunusable();
    self hide();
    self._id_1F84 = 0;
    return;
  }
}

_id_5A44(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0)) {
    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(var_4 == "none") {
        continue;
      }
      var_5 = 1;

      for(var_6 = 0; var_6 < var_2.size; var_6++) {
        if(var_4 == var_2[var_6]) {
          var_5 = 0;
          break;
        }

        var_7 = scripts\cp\cp_weapon::_id_1DB2(var_4, var_2[var_6], var_1);

        if(var_7 != "") {
          var_5 = 0;
          var_2 = scripts\engine\utility::array_remove_index(var_2, var_6);
          var_8 = [];
          var_8 = strtok(var_7, " ");

          foreach(var_11, var_10 in var_8) {
            var_0 = scripts\engine\utility::_id_1BB3(var_0, var_10, var_3 + 1 + var_11);
          }

          break;
        }
      }

      if(var_5) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_id_1D98(var_0) {
  return isDefined(var_0) && scripts\engine\utility::string_starts_with(var_0, "cos_");
}

_id_1DA8(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_1DAC[var_0])) {
    var_1 = level._id_1DAC[var_0];
  }

  return var_1;
}

_id_6C18(var_0) {
  if(!isDefined(level._id_AEA8[var_0])) {
    return undefined;
  }

  var_1 = level._id_AEA8[var_0];
  return var_1;
}

_id_9A9E(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  switch (var_0) {
    case 0:
      if(level.script == "cp_zmb") {
        return 1;
      } else {
        return 0;
      }
    case 1:
      if(level.script == "cp_rave") {
        return 1;
      } else {
        return 0;
      }
    case 2:
      if(level.script == "cp_disco") {
        return 1;
      } else {
        return 0;
      }
    case 3:
      if(level.script == "cp_town") {
        return 1;
      } else {
        return 0;
      }
    default:
      return 1;
  }
}

_id_2D1A(var_0, var_1, var_2, var_3, var_4) {
  if(_id_8A68(var_0, "iw7_")) {
    var_2 = 0;
  }

  var_5 = [];

  foreach(var_7 in var_1) {
    var_5[var_5.size] = _id_1DA9(var_7, var_0);
  }

  var_9 = _id_6CE3(var_0);
  var_10 = var_0;
  var_11 = var_9 == "kbs" || var_9 == "cheytac" || var_9 == "m8" || var_9 == "ripper" || var_9 == "erad" || var_9 == "ar57";

  if(var_11) {
    var_12 = 0;

    foreach(var_7 in var_5) {
      if(_id_68E5(var_7) == "rail") {
        var_12 = 1;
        break;
      }
    }

    if(!var_12) {
      var_5[var_5.size] = var_9 + "scope";
    }
  }

  if(var_5.size > 0) {
    var_15 = scripts\engine\utility::_id_1BC1(var_5);
    var_5 = scripts\engine\utility::_id_163E(var_15);
  }

  foreach(var_7 in var_5) {
    var_10 = var_10 + ("+" + var_7);
  }

  if(issubstr(var_10, "iw6") || issubstr(var_10, "iw7")) {
    var_10 = _id_2D1B(var_10, var_2);

    if(var_4 != "weapon_sniper" && isDefined(var_3)) {
      var_10 = _id_2D1C(var_10, var_3);
    }
  } else if(!scripts\cp\cp_weapon::_id_8AF1(var_10 + "_mp"))
    var_10 = var_0 + "_mp";
  else {
    var_10 = _id_2D1B(var_10, var_2);
    var_10 = _id_2D1C(var_10, var_3);
    var_10 = var_10 + "_mp";
  }

  return var_10;
}

_id_2D1D(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return var_0;
  }

  var_0 = var_0 + ("+loot" + var_1);
  return var_0;
}

_id_88A7(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  if(var_1 == 6) {
    var_2 = getweaponrootname(var_0);
    return var_2 == "iw7_ripper" || var_2 == "iw7_lmg03" || var_2 == "iw7_ar57";
  }

  return 0;
}

_id_891F(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 >= 32;
}

_id_88A8(var_0, var_1) {
  var_2 = _id_1DA9("scope", getweaponbasename(var_0));
  return isDefined(var_2) && scripts\engine\utility::array_contains(var_1, var_2);
}

_id_8659(var_0) {
  if(isDefined(level._id_AE0B) && var_0 == level._id_AE0B) {
    return 1;
  } else if(isDefined(level._id_AE0C) && var_0 == level._id_AE0C) {
    return 1;
  } else if(isDefined(level._id_AE0D) && var_0 == level._id_AE0D) {
    return 1;
  }

  return 0;
}

_id_2D1B(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(var_1 == "none") {
    return var_0;
  }

  return var_0 + "+camo|" + var_1;
}

_id_6E81(var_0, var_1) {
  if(!isDefined(var_1) || var_1 < 0) {
    return 0;
  }

  var_2 = _func_02F6(var_0);
  var_3 = int(_func_0222(var_2, 0, var_1, 4));
  return var_3;
}

_id_2D1C(var_0, var_1) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  var_2 = int(_func_0222("mp/reticleTable.csv", 1, var_1, 5));

  if(!isDefined(var_2) || var_2 == 0) {
    return var_0;
  }

  var_0 = var_0 + ("+scope" + var_2);
  return var_0;
}

_id_7531(var_0) {
  return scripts\cp\zombies\perks\zm_perks::get_perk_level(var_0) > 0;
}

_id_4F48(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (1, 1, 1);
  }

  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

_id_74D8() {
  return istrue(self._id_74D8) || istrue(self._id_2E1A);
}

_id_D13F(var_0, var_1) {
  var_2 = self._id_9C69 - self._id_45AF;
  var_3 = var_1 * var_2 + self._id_45AF;
  self _meth_80C6(var_0, var_3);
}

_id_6300(var_0, var_1) {
  if(var_0 + level._id_47E4[var_1] > level._id_47E3) {
    return level._id_47E3;
  }

  return var_0 + level._id_47E4[var_1];
}

_id_1454(var_0) {
  var_0 = tolower(var_0);

  if(!isDefined(level._id_1453)) {
    return 0;
  }

  if(!isDefined(level._id_1453[var_0])) {
    return 0;
  }

  return level._id_1453[var_0];
}

_id_51D4() {
  self._id_1457 = 1;
  self notify("alien_main_loop_restart");
}

_id_8644(var_0) {
  var_1 = (0, 0, 1);
  var_2 = 0.85;
  return vectordot(var_0, var_1) > var_2;
}

_id_679F(var_0) {
  if(!isDefined(self._id_EC43)) {
    return [];
  }

  if(!isDefined(self._id_EC43._id_EC44)) {
    return [];
  }

  if(!self._id_EC43._id_F8E0) {
    return self._id_EC43._id_EC44;
  }

  var_1 = _id_06FE::_id_6305(var_0);

  if(!isDefined(self._id_EC43._id_EC44[var_1])) {
    var_2 = "Synch attack on " + self._id_EC43._id_7C92 + " doesn't handle type: " + var_1;
  }

  return self._id_EC43._id_EC44[var_1];
}

_id_6CC0(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3;
  }

  var_5 = randomintrange(0, var_1);
  var_1 = 0;

  foreach(var_7, var_3 in var_0) {
    var_1 = var_1 + var_3;

    if(var_5 <= var_1) {
      return var_7;
    }
  }

  return 0;
}

_id_63E3(var_0, var_1) {
  var_2 = 1073741824;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  var_3 = undefined;
  var_4 = level.players;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  foreach(var_6 in var_4) {
    if(isDefined(level._id_7D21) && [[level._id_7D21]](self, var_6)) {
      continue;
    }
    if(_id_073B::_id_B4EF(var_6)) {
      continue;
    }
    var_7 = distancesquared(self.origin, var_6.origin);

    if(var_6 scripts\cp_mp\utility\player_utility::_isalive() && var_7 < var_2) {
      var_3 = var_6;
      var_2 = var_7;
    }
  }

  return var_3;
}

_id_636E(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(level.players[var_3] _id_8708()) {
      var_2[var_2.size] = level.players[var_3];
    }
  }

  if(!isDefined(var_0) || !var_0) {
    return var_2;
  }

  return scripts\engine\utility::_id_6369(var_1, var_2);
}

_id_8708(var_0, var_1) {
  if(!isPlayer(self)) {
    return 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(self.sessionstate == "spectator") {
    return 0;
  }

  if(!isDefined(var_0) && _id_073B::_id_B4EF(self)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!istrue(var_1) && (istrue(self._id_7EAB) || istrue(self._id_82D4))) {
    return 0;
  }

  return 1;
}

_id_190A(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) < var_1) {
      return 1;
    }
  }

  return 0;
}

_id_6ED4(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(isDefined(var_2) && var_5.team != var_2) {
      continue;
    }
    if(distancesquared(var_5.origin, var_0) < var_1) {
      var_3[var_3.size] = var_5;
    }
  }

  if(var_3.size > 0) {
    var_7 = _func_0204(var_3, var_0);
    return var_7[0];
  }

  return undefined;
}

_id_1A44(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) > var_1) {
      return 0;
    }

    wait 0.05;
  }

  return 1;
}

_id_6EBD(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    if(distancesquared(level.players[var_3].origin, var_0) < var_1) {
      var_2[var_2.size] = level.players[var_3];
    }
  }

  return var_2;
}

_id_B573(var_0) {
  self endon("disconnect");

  if(getdvarint("#x358e6b06f313339e7", 0) == 1) {
    return;
  }
  var_1 = 5500;
  var_2 = gettime();

  if(!isDefined(self._id_A477)) {
    self._id_A477 = var_2 + randomintrange(var_1, var_1 + 2000);
  } else if(var_2 < self._id_A477) {
    return;
  }
  while(_id_0746::_id_105A5()) {
    wait 0.1;
  }

  if(isDefined(self._id_105F0)) {
    if(_func_0205(self._id_105F0 + "plr_pain")) {
      _id_B877(self._id_105F0 + "plr_pain");
    } else if(_func_0205(self._id_105F0 + "pain")) {
      _id_B877(self._id_105F0 + "pain");
    }
  }

  var_3 = "injured_pain_vocal";

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_1210)) {
      switch (var_0._id_1210) {
        case "skater":
          var_3 = "injured_pain_skater";
          break;
        case "ratking":
          var_3 = scripts\engine\utility::random(["injured_pain_ratking1", "injured_pain_ratking2", "injured_pain_ratking3"]);
          break;
        default:
          var_3 = "injured_pain_vocal";
          break;
      }
    }
  }

  _id_076F::_id_F72D(var_3, "zmb_comment_vo");
  self._id_A477 = var_2 + randomintrange(var_1, var_1 + 1500);
}

_id_B572() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(getdvarint("#x358e6b06f313339e7", 0) == 1) {
    return;
  }
  if(_id_867B(self)) {
    return;
  }
  if(_id_0E10(self)) {
    return;
  }
  _id_D262(self, 1);
  var_0 = _id_6637(self);

  if(isDefined(var_0)) {
    if(_func_0205(var_0)) {
      while(!_id_0E10(self) && !level.gameended) {
        if(!istrue(self._id_10648)) {
          _id_B877(var_0);
        }

        wait 1.5;
      }
    }

    _id_D262(self, 0);
  }
}

_id_867B(var_0) {
  return istrue(var_0._id_867B);
}

_id_0E10(var_0) {
  var_1 = 0.3;
  return var_0.health / var_0.maxhealth > var_1;
}

_id_D262(var_0, var_1) {
  var_0._id_867B = var_1;
}

_id_6637(var_0) {
  if(!level.gameended) {
    if(var_0._id_105F0 == "p1_") {
      return "p1_plr_pain";
    } else if(var_0._id_105F0 == "p2_") {
      return "p2_plr_pain";
    } else if(var_0._id_105F0 == "p3_") {
      return "p3_plr_pain";
    } else if(var_0._id_105F0 == "p4_") {
      return "p4_plr_pain";
    } else if(var_0._id_105F0 == "p5_") {
      return "p5_plr_pain";
    } else {
      return "p3_plr_pain";
    }
  }
}

_id_B91C(var_0) {
  var_1 = var_0._id_105F0 + "good_loot";

  if(_id_076F::_id_1447(var_0, var_1)) {
    var_0 _id_B877(_id_076F::_id_631D(var_0, var_1));
  } else if(_func_0205(var_1)) {
    var_0 _id_B877(var_1);
  }
}

_id_47DF(var_0) {
  var_1 = "";

  if(isDefined(var_0) && isDefined(var_0._id_2991) && isDefined(level._id_298E[var_0._id_2991]._id_56C1)) {
    var_1 = level._id_298E[var_0._id_2991]._id_56C1;
  }

  thread _id_D5E9("deployable_use", var_1, 3);
}

_id_85E2(var_0) {
  switch (var_0) {
    case "goon4":
    case "goon3":
    case "goon2":
    case "goon":
      return 1;
    default:
      return 0;
  }
}

_id_9B0E(var_0, var_1, var_2) {}

_id_7649(var_0) {
  level._id_7647 = var_0;
}

_id_1450() {
  level._id_1451 = [];
  level._id_1451[1] = 0.9;
  level._id_1451[2] = 1.0;
  level._id_1451[3] = 1.3;
  level._id_1451[4] = 1.8;
}

_id_B6D4() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::waittill_any_2("damage", "health_perk_upgrade");

    if(!_id_31BC()) {
      continue;
    }
    var_0 = _id_073B::_id_6A8F();
    var_1 = self.health / var_0;

    if(var_1 >= 1) {
      self.health = var_0;
      continue;
    }

    thread _id_7643(gettime(), var_1);
  }
}

_id_686B(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(distance(var_1[var_4].origin, var_0) <= var_2) {
      var_3[var_3.size] = var_1[var_4];
    }
  }

  return var_3;
}

_id_7643(var_0, var_1) {
  self notify("healthRegeneration");
  self endon("healthRegeneration");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  while(isDefined(self._id_D081) && self._id_D081) {
    wait 0.2;
  }

  if(_id_8894()) {
    return;
  }
  var_2 = spawnStruct();
  _id_6CE7(var_2);
  scripts\engine\utility::_id_108A7(var_2._id_0F03, "force_regeneration");
  var_3 = gettime();
  self notify("heal_started");

  for(;;) {
    var_4 = _id_073B::_id_6A8F();
    var_2 = spawnStruct();
    _id_6CE7(var_2);
    var_1 = self.health / self.maxhealth;

    if(self.health < int(var_4)) {
      var_5 = int(self.health + var_2._id_C1B4);

      if(var_5 > var_4) {
        var_5 = var_4;
      }

      self.health = var_5;
    } else
      break;

    scripts\engine\utility::_id_108A7(var_2._id_10973, "force_regeneration");
  }

  self notify("healed");

  if(isDefined(level._id_B6DF)) {
    self[[level._id_B6DF]]();
  }

  _id_C602();
}

_id_2BA0(var_0, var_1) {
  self notify("breathingManager");
  self endon("breathingManager");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  level endon("game_ended");

  if(_id_8ACE()) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self._id_2BA1 = var_0 + 6000 * self._id_C1BA;
  wait(6 * self._id_C1BA);

  if(!level.gameended) {
    if(!isDefined(self._id_105F0)) {
      return;
    }
    if(!istrue(self._id_10648)) {
      if(_id_8855()) {
        _id_B877("Fem_breathing_better");
      } else {
        _id_B877("breathing_better");
      }
    }
  }
}

_id_6CE7(var_0) {
  level._id_97CD = 5000;
  level._id_763F = 0.2;
  level._id_8538 = 0.35;
  level._id_8536 = 0.5;
  level._id_8537 = 0.3;
  level._id_B6D2 = 2400;
  level._id_10F55 = 0.1;
  self._id_BBFF = _id_0946::_id_BBF8();
  var_1 = 1;

  if(isDefined(self._id_AFAA)) {
    if(isDefined(self._id_AFAA["regen_time_scalar"])) {
      var_1 = self._id_AFAA["regen_time_scalar"];
    } else {
      var_1 = self._id_AFAA["health"]._id_C1B3;
    }
  }

  if(isDefined(level.regen_scalar_update_func)) {
    var_1 = [[level.regen_scalar_update_func]](self, var_1);
  }

  if(istrue(self._id_11B4)) {
    var_0._id_0F03 = 0;
    var_0._id_10973 = level._id_5F3A;
    var_0._id_C1B4 = _id_0918::_id_6A90();
    scripts\cp\cp_playerstats::incrementcategorystat(self, "tacticalStats", "equip_adrenaline", "heals", var_0._id_C1B4);
  } else if(self._id_BBFF == 1.0) {
    if(_id_8580("faster_health_regen_upgrade")) {
      var_0._id_0F03 = 0.45;
      var_0._id_10973 = 0.045;
      var_0._id_C1B4 = 0.1;
    } else {
      var_0._id_0F03 = 6 * var_1;
      var_0._id_10973 = 0.05;
      var_0._id_C1B4 = 6;
    }
  } else {
    var_0._id_0F03 = 6 * self._id_BBFF;
    var_0._id_10973 = 0.05 * self._id_BBFF;
    var_0._id_C1B4 = 6;
  }
}

_id_C602(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 1.75;
  _id_C603();
}

_id_C603() {
  self._id_1DDE = [];
  self._id_1DD4 = [];
}

_id_31BC() {
  if(getdvarint("#x315a01bfc975f0214", 0) == 1) {
    return 0;
  }

  if(istrue(self._id_88DF)) {
    return 0;
  }

  if(_id_073B::_id_B4EF(self)) {
    return 0;
  }

  if(istrue(self._id_59E0)) {
    return 0;
  }

  if(istrue(self._id_4A07)) {
    return 0;
  }

  return 1;
}

_id_B738() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  wait 2;

  for(;;) {
    wait 0.2;

    if(_id_DBAA()) {
      if(self._id_105F0 == "p1_") {
        if(_func_0205("Fem_breathing_hurt")) {
          _id_B877("Fem_breathing_hurt");
        }
      } else
        _id_B877("breathing_hurt");

      wait 0.784;
      wait(0.1 + randomfloat(0.8));
    }
  }
}

_id_DBAA() {
  if(_id_8894() || _id_8ACE() || isDefined(self._id_2BA1) && gettime() < self._id_2BA1 || self.health > self.maxhealth * 0.55 || level.gameended) {
    return 0;
  } else {
    return 1;
  }
}

_id_8894() {
  return isDefined(level._id_7647) && level._id_7647 || isDefined(self._id_7647) && self._id_7647;
}

_id_B65E() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self endon("faux_spawn");
  self endon("game_ended");

  if(!isDefined(self._id_25DB)) {
    self._id_25DB = 0;
  }

  var_0 = self getentitynumber();
  var_1 = 0;
  _id_074E::_id_D4E4("EoGPlayer", var_0, "playerArmor", 0);

  for(;;) {
    scripts\engine\utility::waittill_any_2("player_damaged", "enable_armor");

    if(!isDefined(self._id_25DB)) {
      if(var_1 > 0) {
        _id_074E::_id_D4E4("EoGPlayer", var_0, "playerArmor", 0);
        var_1 = 0;
      }

      continue;
    }

    if(var_1 != self._id_25DB) {
      var_2 = int(self._id_25DB);
      _id_074E::_id_D4E4("EoGPlayer", var_0, "playerArmor", var_1);
      var_1 = self._id_25DB;
    }
  }
}

_id_FCF9() {
  if(isPlayer(self)) {
    var_0 = self getentitynumber();
    _id_074E::_id_D4E4("EoGPlayer", var_0, "playerHealth", self.health);
    _id_074E::_id_D4E4("EoGPlayer", var_0, "playerMaxHealth", self.maxhealth);
  }
}

updateplayerarmordisplay() {
  if(isPlayer(self) && isDefined(self._id_1B26) && isDefined(self._id_9C09) && isDefined(self._id_1B3D)) {
    var_0 = self getentitynumber();
    _id_074E::_id_D4E4("EoGPlayer", var_0, "playerArmorTier", self._id_1B3D);
    _id_074E::_id_D4E4("EoGPlayer", var_0, "playerArmor", self._id_1B26);
    _id_074E::_id_D4E4("EoGPlayer", var_0, "playerMaxArmor", self._id_9C09);
  }
}

_id_157B(var_0) {
  if(var_0) {
    if(!isDefined(self._id_4AA9)) {
      self._id_4AA9 = 0;
    }

    self._id_4AA9--;

    if(!self._id_4AA9) {
      self enableoffhandsecondaryweapons();
    }
  } else {
    if(!isDefined(self._id_4AA9)) {
      self._id_4AA9 = 0;
    }

    self._id_4AA9++;
    self disableoffhandsecondaryweapons();
  }
}

register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    level notify("physSnd", self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }
}

_id_703F() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for(;;) {
    level waittill("physSnd", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_0) && isDefined(var_0._id_B049)) {
      level thread[[var_0._id_B049]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }
}

_id_C208(var_0, var_1) {
  var_0._id_B049 = var_1;
}

_id_1179() {
  if(!scripts\engine\utility::array_contains(level._id_B15C, self)) {
    level._id_B15C = scripts\engine\utility::_id_1B8D(level._id_B15C, self);
  }

  level._id_B15C = scripts\engine\utility::_id_1BD1(level._id_B15C);
}

_id_C4BF() {
  if(scripts\engine\utility::array_contains(level._id_B15C, self)) {
    level._id_B15C = scripts\engine\utility::array_remove(level._id_B15C, self);
  }

  level._id_B15C = scripts\engine\utility::_id_1BD1(level._id_B15C);
}

_id_5481(var_0) {
  var_1 = 16384;

  if(level._id_F897.size) {
    var_2 = _func_0204(level._id_F897, var_0.origin);

    if(distance2dsquared(var_2[0].origin, var_0.origin) < var_1) {
      return 1;
    }
  }

  if(isDefined(level._id_B15C) && level._id_B15C.size) {
    foreach(var_4 in level._id_B15C) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(distance2dsquared(var_4.origin, var_0.origin) < var_1) {
        return 1;
      }
    }
  }

  if(isDefined(level._id_A3EB)) {
    return [[level._id_A3EB]](var_0);
  }

  return 0;
}

_id_D19E(var_0, var_1, var_2) {
  if(isDefined(var_2._id_4166)) {
    var_2._id_4166 = undefined;
  }

  var_2._id_4166 = spawnStruct();
  var_2._id_4166._id_024F = var_0;
  var_2._id_4166._id_C6FB = var_1;
}

_id_C397(var_0) {
  var_0._id_4166 = undefined;
}

_id_C396(var_0, var_1) {
  switch (var_1) {
    case "up_dpad":
      break;
    case "down_dpad":
      break;
    case "left_dpad":
      break;
    case "right_dpad":
      break;
  }
}

_id_0FB0(var_0, var_1, var_2) {
  switch (var_1) {
    case "up_dpad":
      break;
    case "down_dpad":
      break;
    case "left_dpad":
      break;
    case "right_dpad":
      break;
  }
}

_id_8B23(var_0) {
  self endon("death");
  level endon("game_ended");
  self notify(var_0);
  self endon(var_0);
  self.owner waittill("disconnect");

  foreach(var_2 in level.players) {
    if(var_2 _id_8708(1)) {
      self.owner = var_2;

      if(self.classname != "script_model") {
        self setsentryowner(self.owner);
      }

      break;
    }
  }

  thread _id_8B23(var_0);
}

_id_C6FE() {
  if(isDefined(self._id_C70D)) {
    _id_6FC2(self._id_C70D);
    self._id_C70D = undefined;
  }
}

_id_10790() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  _id_C6FE();
}

_id_C435() {
  if(_hasperk("specialty_explosivebullets")) {
    self._id_C70D = "specialty_explosivebullets";
    _unsetperk("specialty_explosivebullets");
  }
}

_id_8B2C(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self._id_9371)) {
    self._id_9371 = var_1;
  }

  if(isDefined(var_0)) {
    self._id_9371 = var_0;
  }

  while(self._id_9371) {
    wait 1.0;
    _id_0733::waittillhostmigrationdone();

    if(!isDefined(self._id_32CA)) {
      self._id_9371 = max(0, self._id_9371 - 1.0);
    }
  }

  while(isDefined(self) && isDefined(self._id_84F0)) {
    wait 0.05;
  }

  if(isDefined(self._id_10FFE)) {
    self._id_10FFE delete();
  }

  if(isDefined(var_2)) {
    self notify(var_2);
  } else {
    self notify("death");
  }
}

_id_8B26(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("disconnect");
  var_1 = var_0 scripts\engine\utility::_id_10897("death", "last_stand");
  var_0 notify("force_cancel_placement");
}

_id_8B27(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  var_0 waittill("disconnect");

  if(isDefined(self._id_32CB)) {
    self._id_32CB delete();
  } else if(isDefined(self._id_32CE)) {
    self._id_32CE delete();
  } else if(isDefined(self._id_32C8)) {
    self._id_32C8 delete();
  } else if(isDefined(self._id_32C9)) {
    self._id_32C9 delete();
  } else if(isDefined(self._id_32BE)) {
    self._id_32BE delete();
  } else if(isDefined(self._id_32D1)) {
    self._id_32D1 delete();
  }

  self delete();
}

_id_8B28(var_0) {
  self endon("placed");
  self endon("death");
  var_0 endon("last_stand");
  level waittill("game_ended");
  self delete();
}

_id_DA7B(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(!isagent(var_0)) {
    return 0;
  }

  if(!isDefined(var_0._id_1210)) {
    return 0;
  }

  if(!isDefined(var_0.isactive) || !var_0.isactive) {
    return 0;
  }

  if(!isDefined(var_1) && isDefined(var_0._id_54D1) && !var_0._id_54D1) {
    return 0;
  }

  if(istrue(var_0._id_9B33)) {
    return 0;
  }

  if(!isDefined(var_0.team)) {
    return 0;
  }

  if(var_0._id_1210 == "zombie_brute" || var_0._id_1210 == "zombie_ghost" || var_0._id_1210 == "zombie_grey") {
    return 0;
  }

  if(!istrue(var_2) && istrue(var_0._id_86D9)) {
    return 0;
  }

  if(istrue(var_0._id_857A)) {
    return 0;
  }

  return 1;
}

_id_D36A(var_0) {
  _id_7DD9();
  _id_D36B(var_0);
}

_id_D36B(var_0) {
  _func_01EB("zombie_quest_piece", var_0, 1);
  setclientmatchdata("questPieces", "quest_piece_" + var_0, 1);
}

_id_D18C(var_0) {
  _func_01EB("zm_completed_quest_marks", var_0, 1);
}

_id_7DD9() {
  if(!isDefined(level._id_A75A)) {
    level._id_A75A = 0;
  }

  level._id_A75A++;

  if(level._id_A75A == level._id_3E21) {
    foreach(var_1 in level.players) {
      var_1 _id_06FA::_id_FB31("STICKER_COLLECTOR", 24);
    }
  }
}

_id_B8BA(var_0, var_1, var_2) {
  var_0 _id_B877(var_1);
  var_0 playsoundtoteam(var_2, "allies", var_0);
  var_0 playsoundtoteam(var_2, "axis", var_0);
}

_id_42D4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!_id_DA77(var_0)) {
    return;
  }
  var_0 endon("death");

  if(!isDefined(var_3)) {
    var_3 = 600;
  }

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  if(!isDefined(var_4)) {
    var_4 = "MOD_UNKNOWN";
  }

  if(!isDefined(var_5)) {
    var_5 = "iw7_dot_zm";
  }

  if(isDefined(var_7)) {
    var_0 _id_D6BD(var_0, var_7, 1);

    if(isDefined(level._id_CF2D)) {
      var_0 thread[[level._id_CF2D]](var_0);
    }
  }

  var_9 = 0;
  var_10 = 6;
  var_11 = var_2 / var_10;
  var_12 = var_3 / var_10;

  for(var_13 = 0; var_13 < var_10; var_13++) {
    wait(var_11);

    if(isalive(var_0)) {
      var_0._id_5C4B = gettime() + 500;

      if(var_0.health - var_12 <= 0) {
        if(isDefined(var_8)) {
          level notify(var_8);
        }
      }

      if(isDefined(var_1)) {
        var_0 dodamage(var_12, var_0.origin, var_1, var_1, var_4, var_5);
        continue;
      }

      var_0 dodamage(var_12, var_0.origin, undefined, undefined, var_4, var_5);
    }
  }

  if(isDefined(var_7)) {
    var_0 _id_D6BD(var_0, var_7);
  }

  if(istrue(var_0._id_9B33)) {
    var_0._id_9B33 = undefined;
  }

  if(istrue(var_0._id_5C4B)) {
    var_0._id_5C4B = undefined;
  }
}

_id_D6BD(var_0, var_1, var_2) {
  switch (var_1) {
    case "combinedArcane":
    case "combinedarcane":
      if(istrue(var_2)) {
        var_0._id_8545 = 1;
      } else {
        var_0._id_8545 = undefined;
      }

      break;
    case "burning":
      if(istrue(var_2)) {
        var_0._id_8569 = var_2;
      } else {
        var_0._id_8569 = undefined;
      }

      break;
    case "electrified":
      if(istrue(var_2)) {
        var_0._id_85AF = var_2;
        var_0._id_0043 = 1;
        var_0._id_EAA4 = gettime() + 3000;
      } else {
        var_0._id_85AF = undefined;
        var_0._id_0043 = 0;
      }

      break;
    case "shocked":
      if(istrue(var_2)) {
        var_0._id_EAAB = var_2;
      } else {
        var_0._id_EAAB = undefined;
      }

      break;
    case "chemBurn":
    case "chemburn":
      if(istrue(var_2)) {
        var_0._id_856F = 1;
      } else {
        var_0._id_856F = undefined;
      }

      break;
    default:
      break;
  }
}

_id_4DE4(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = undefined;

  if(isDefined(var_1)) {
    var_5 = _func_03C0(undefined, undefined, var_1, 64);

    if(var_5.size > 0) {
      var_3 = undefined;

      if(var_5.size == 1) {
        var_3 = var_5[0];
        var_4 = 1;
      } else {
        var_6 = var_5.size;
        var_7 = 9999999;

        for(var_8 = 0; var_8 < var_6; var_8++) {
          var_9 = distancesquared(var_5[var_8].origin, var_1);

          if(var_9 < var_7) {
            var_7 = var_9;
            var_3 = var_5[var_8];
            var_4 = 1;
          }
        }
      }
    }
  }

  if(isDefined(var_1) && !istrue(var_4)) {
    return;
  }
  if(istrue(var_2)) {
    var_3 setscriptablepartstate("door", "closed");
  }

  if(var_0) {
    var_3 _meth_8727(1);
  } else {
    var_3 _meth_8727(0);
  }
}

_id_DA77(var_0) {
  if(isDefined(var_0._id_1210) && (var_0._id_1210 == "c6" || var_0._id_1210 == "zombie_brute" || var_0._id_1210 == "zombie_grey" || var_0._id_1210 == "zombie_ghost")) {
    return 0;
  }

  return 1;
}

_id_FBDF(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_5 = var_2._id_32D4;
  var_6 = var_2._id_32D3;
  var_7 = var_2._id_B175;
  var_8 = var_2._id_B16E;
  var_9 = var_2._id_9FDD;
  var_10 = var_2._id_9FDE;
  var_11 = var_2._id_B158;
  var_12 = var_2._id_B17C;
  var_13 = var_2._id_31A4;
  var_0 endon("placed");
  var_0 endon("death");
  var_0._id_314C = 1;
  var_14 = -1;

  for(;;) {
    var_15 = self _meth_8065(1, var_7);
    var_0.origin = var_15["origin"];
    var_0.angles = var_15["angles"];
    var_1.origin = var_0.origin + var_5;
    var_1.angles = var_0.angles + var_6;

    if(isDefined(self._id_AB9C)) {
      var_0._id_314C = 0;
    } else {
      var_0._id_314C = self isonground() && var_15["result"] && abs(var_0.origin[2] - self.origin[2]) < var_8;
    }

    if(_id_5481(var_0)) {
      var_0._id_314C = 0;
    }

    if(isDefined(var_3) && isDefined(level._id_4B1A) && isDefined(level._id_4339)) {
      if(var_0 istouching(level._id_4339)) {
        var_0._id_314C = 0;
      }
    }

    if(isDefined(var_15["entity"])) {
      var_0._id_A283 = var_15["entity"];
    } else {
      var_0._id_A283 = undefined;
    }

    if(var_0._id_314C != var_14) {
      if(var_0._id_314C) {
        if(!isDefined(var_4)) {
          var_1 setModel(var_9);
        }

        if(isDefined(var_0._id_5BDA)) {
          self _meth_80FD(var_11);
        } else {
          self _meth_80FD(var_12);
        }
      } else {
        if(!isDefined(var_4)) {
          var_1 setModel(var_10);
        }

        self _meth_80FD(var_13);
      }
    }

    var_14 = var_0._id_314C;
    wait 0.05;
  }
}

_id_FE75(var_0, var_1) {
  if(var_0 _id_3187(var_0 _id_6E34()) && !var_0 _meth_84B7()) {
    var_0 setweaponammostock(var_1, 1);
    var_0 _meth_852A(var_1);
  }
}

playgestureweaponanim(var_0) {
  self cancelreload();
  var_1 = makeweapon(var_0);
  self _meth_852A(var_1);

  if(!self hasweapon(var_1)) {
    return;
  }
  thread watch_give_and_fire_offhand_failure(var_1);
  self allowreload(0);
  scripts\engine\utility::waittill_any_3("offhand_fired", "weapon_gesture_failed", "portal_activated");
  self allowreload(1);
}

watch_give_and_fire_offhand_failure(var_0) {
  self endon("offhand_fired");
  self endon("death_or_disconnect");

  while(self hasweapon(var_0)) {
    waitframe();
  }

  self notify("weapon_gesture_failed");
}

_id_857B() {
  return getDvar("#x3575444fa811edb91", "") != "";
}

_id_F336(var_0) {
  var_1 = _func_0204(level._id_417B, var_0);

  if(var_1.size >= 1) {
    if(distancesquared(var_1[0].origin, var_0) < 9216) {
      return 1;
    }
  }

  return 0;
}

_id_6E8F() {
  var_0 = undefined;

  if(isDefined(self._id_8F79)) {
    var_0 = self._id_8F79;
  } else {
    var_0 = self getcurrentweapon();
  }

  var_1 = 0;
  var_2 = level._id_10D0;

  if(isnullweapon(var_0)) {
    var_1 = 1;
  } else if(scripts\engine\utility::array_contains(var_2, var_0)) {
    var_1 = 1;
  } else if(scripts\engine\utility::array_contains(var_2, var_0 _meth_8625())) {
    var_1 = 1;
  } else if(_id_8632(var_0, 1)) {
    var_1 = 1;
  }

  if(var_1) {
    var_3 = self getweaponslistall();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(isnullweapon(var_3[var_4])) {
        continue;
      } else if(scripts\engine\utility::array_contains(var_2, var_3[var_4])) {
        continue;
      } else if(scripts\engine\utility::array_contains(var_2, var_3[var_4] _meth_8625())) {
        continue;
      } else if(_id_8632(var_3[var_4], 1)) {
        continue;
      } else if(!scripts\cp\cp_weapon::_id_89C7(var_3[var_4])) {
        continue;
      } else {
        var_1 = 0;
        var_0 = var_3[var_4];
        break;
      }
    }
  }

  if(var_1) {
    var_0 = makeweapon("iw7_fists_zm");

    if(!self hasweapon(var_0)) {
      _giveweapon(var_0, undefined, undefined, 1);
    }
  }

  return var_0;
}

_id_6E34(var_0) {
  var_1 = self getcurrentweapon();
  var_2 = 0;
  var_3 = level._id_10D0;

  if(isDefined(var_0)) {
    var_3 = scripts\engine\utility::array_combine(var_0, var_3);
  }

  if(isnullweapon(var_1)) {
    var_2 = 1;
  } else if(isDefined(var_1._id_0241) && var_1._id_0241 == "model_only") {
    var_2 = 1;
  } else if(scripts\engine\utility::array_contains(var_3, var_1)) {
    var_2 = 1;
  } else if(scripts\engine\utility::array_contains(var_3, var_1 _meth_8625())) {
    var_2 = 1;
  } else if(_id_88F6(var_1)) {
    var_2 = 1;
  }

  if(isDefined(self._id_8F74) && self hasweapon(self._id_8F74) && var_2) {
    var_1 = self._id_8F74;

    if(isnullweapon(var_1)) {
      var_2 = 1;
    } else if(isDefined(var_1._id_0241) && var_1._id_0241 == "model_only") {
      var_2 = 1;
    } else if(scripts\engine\utility::array_contains(var_3, var_1)) {
      var_2 = 1;
    } else if(scripts\engine\utility::array_contains(var_3, var_1 _meth_8625())) {
      var_2 = 1;
    } else if(_id_8632(var_1, 1)) {
      var_2 = 1;
    } else if(_id_88F6(var_1)) {
      var_2 = 1;
    } else {
      var_2 = 0;
    }
  }

  if(var_2) {
    var_4 = self getweaponslistall();

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(isnullweapon(var_4[var_5])) {
        continue;
      } else if(scripts\engine\utility::array_contains(var_3, var_4[var_5])) {
        continue;
      } else if(scripts\engine\utility::array_contains(var_3, var_4[var_5] _meth_8625())) {
        continue;
      } else if(_id_8632(var_4[var_5], 1)) {
        continue;
      } else if(isDefined(var_4[var_5]._id_0241) && var_4[var_5]._id_0241 == "model_only") {
        continue;
      } else if(_id_88F6(var_4[var_5])) {
        continue;
      } else {
        var_2 = 0;
        var_1 = var_4[var_5];
        break;
      }
    }
  }

  return var_1;
}

_id_69A1(var_0) {
  var_1 = _func_00ED(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  switch (var_1) {
    case "camo0":
      return "camo00";
    case "camo1":
      return "camo01";
    case "camo2":
      return "camo02";
    case "camo3":
      return "camo03";
    case "camo4":
      return "camo04";
    case "camo5":
      return "camo05";
    case "camo6":
      return "camo06";
    case "camo7":
      return "camo07";
    case "camo8":
      return "camo08";
    case "camo9":
      return "camo09";
    default:
      return var_1;
  }

  return undefined;
}

_id_1049(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(self._id_A680)) {
    self._id_A680 = [];
  }

  if(!isDefined(self._id_A680[var_0])) {
    self._id_A680[var_0] = 0;
  } else {
    self._id_A680[var_0]++;
  }

  if(self._id_A680[var_0] > 0) {
    wait(0.05 * self._id_A680[var_0]);
  }

  if(isDefined(self)) {
    self notify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  waittillframeend;

  if(isDefined(self)) {
    if(isDefined(self._id_A680[var_0])) {
      self._id_A680[var_0]--;

      if(self._id_A680[var_0] < 1) {
        self._id_A680[var_0] = undefined;
      }
    }
  }
}

_id_ED89(var_0) {
  foreach(var_2 in var_0 getweaponslistall()) {
    if(issubstr(var_2.basename, "iw7_fists")) {
      var_0 takeweapon(var_2);
    }
  }
}

_id_B877(var_0) {
  if(_func_0205(var_0)) {
    self playlocalsound(var_0);
  }
}

_id_E913(var_0) {
  if(_func_0205(var_0)) {
    self _meth_83EF(var_0);
  }
}

_id_B8ED(var_0, var_1) {
  if(_func_0205(var_1)) {
    playsoundatpos(var_0, var_1);
  }
}

_id_B8F4(var_0, var_1) {
  if(_func_0205(var_0)) {
    var_1 playsoundtoplayer(var_0, var_1);
  }
}

_id_1213() {
  return isDefined(self._id_1210) && isDefined(level._id_7D28) && scripts\engine\utility::array_contains(level._id_7D28, self._id_1210);
}

_id_1216() {
  return isDefined(self._id_1210) && isDefined(level._id_5D82) && scripts\engine\utility::array_contains(level._id_5D82, self._id_1210);
}

_id_1217() {
  return isDefined(self._id_1210) && isDefined(level._id_82FB) && scripts\engine\utility::array_contains(level._id_82FB, self._id_1210);
}

_id_1218() {
  return isDefined(self._id_1210) && isDefined(level._id_E3D7) && scripts\engine\utility::array_contains(level._id_E3D7, self._id_1210);
}

_id_5B75(var_0, var_1) {
  var_2 = var_0 getcurrentweapon();

  if(_id_3187(var_2)) {
    var_0 setweaponammostock(var_1, 1);
    var_0 _meth_852A(var_1);
  }
}

_id_3187(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(isDefined(level._id_84F5)) {
    if(isDefined(level._id_84F5[getweaponbasename(var_0)])) {
      return 0;
    } else {
      return 1;
    }
  } else
    return 1;
}

_id_B25F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "iw7_powerlever_zm";
  }

  if(getweaponbasename(self getcurrentweapon()) != "iw7_penetrationrail_mp") {
    thread _id_5B75(self, var_0);
  }
}

_id_B744(var_0) {
  self notify("playerPlayPickupAnim");
  self endon("playerPlayPickupAnim");
  self endon("death");
  self endon("disconnect");

  if(self isswitchingweapon() || self _meth_81E0() || self _meth_81CE() || self _meth_81EF() || self israisingweapon() || self _meth_81CF() || _id_8989()) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = "iw8_ges_pickup";
  }

  var_1 = makeweapon("none");
  var_2 = self getcurrentprimaryweapon();

  if(issameweapon(var_2, var_1)) {
    return;
  }
  if(self _meth_84B7(var_0)) {
    self _meth_8494(var_0, 0, 1);
    wait 0.05;
  }

  self _meth_84AF(var_0);
}

_id_B745() {
  var_0 = "intel_take_photo";
  var_1 = self getcurrentweapon();
  var_2 = makeweapon(var_0);
  thread _id_0BEC();
  _giveweapon(var_2);
  self switchtoweapon(var_2);
  self setclientomnvar("ui_tablet_usb", 7);
  var_3 = 3;
  wait(var_3);

  if(isPlayer(self)) {
    self takeweapon(var_2);
    self switchtoweapon(var_1);
    self setclientomnvar("ui_tablet_usb", 0);
    return 1;
  }

  return 0;
}

_id_0BEC() {
  var_0 = self getstance();
  _id_0D97(1);
  _id_C717(1, var_0);
  var_1 = 1.6;
  wait(var_1);
  _id_0D97(0);
  _id_C717(0, var_0);
}

_id_0D97(var_0) {
  _id_0BEE(var_0);
  scripts\common\utility::_id_1559(!var_0);
  scripts\common\utility::_id_154E(!var_0);
  scripts\common\utility::_id_158A(!var_0);
  scripts\common\utility::_id_1554(!var_0);
  scripts\common\utility::_id_1562(!var_0);
  scripts\common\utility::_id_1593(!var_0);
  scripts\common\utility::_id_1581(!var_0);
}

_id_C717(var_0, var_1) {
  if(istrue(var_0)) {
    _id_0C90(1, var_1);
  } else {
    _id_0C90(0, var_1);
  }
}

_id_0C90(var_0, var_1) {
  if(istrue(var_0)) {
    switch (var_1) {
      case "stand":
        scripts\common\utility::_id_1530(0);
        scripts\common\utility::_id_1570(0);
        break;
      case "crouch":
        scripts\common\utility::_id_1582(0);
        scripts\common\utility::_id_1570(0);
        break;
      case "prone":
        scripts\common\utility::_id_1530(0);
        scripts\common\utility::_id_1582(0);
        break;
    }
  } else {
    switch (var_1) {
      case "stand":
        scripts\common\utility::_id_1530(1);
        scripts\common\utility::_id_1570(1);
        break;
      case "crouch":
        scripts\common\utility::_id_1582(1);
        scripts\common\utility::_id_1570(1);
        break;
      case "prone":
        scripts\common\utility::_id_1530(1);
        scripts\common\utility::_id_1582(1);
        break;
    }
  }
}

_id_4389(var_0, var_1) {
  var_0 notsolid();

  if(istrue(var_1)) {
    var_0 hide();
  }
}

rankingenabled() {
  if(!isPlayer(self)) {
    return 0;
  }

  return level.onlinegame && !self.usingonlinedataoffline;
}

_id_44F0(var_0) {}

_id_546A(var_0, var_1, var_2, var_3, var_4) {
  if(!level.teambased) {
    return undefined;
  }

  if(!isDefined(var_2)) {
    var_2 = "allies";
  }

  var_5 = _func_0353(var_0);
  _func_0356(var_5, var_3);
  _func_035D(var_5, var_1);
  _func_0359(var_5, 0);
  _func_035A(var_5, 2250);
  _func_0364(var_5, var_2);

  if(isDefined(var_4)) {
    _func_035C(var_5, var_4);
  }

  _func_035F(var_5, var_2);
  _func_0362(var_5);
  thread _id_10B79(var_0, var_5);
  return var_5;
}

_id_10B79(var_0, var_1) {
  var_0 endon("head_icon_deleted_" + var_1);
  var_0 waittill("death");
  thread _id_546B(var_0, var_1);
}

_id_546B(var_0, var_1) {
  var_0 notify("head_icon_deleted_" + var_1);
  _func_0354(var_1);
}

_id_6AF9() {
  return self._id_90CB;
}

_id_8941() {
  return istrue(level._id_A4FE);
}

_id_1172(var_0, var_1, var_2) {
  if(!isDefined(level._id_EA70[var_0][var_1])) {
    level._id_EA70[var_0][var_1] = [];
  }

  level._id_EA70[var_0][var_1][level._id_EA70[var_0][var_1].size] = var_2;
}

_id_85FB(var_0) {
  if(!isDefined(level._id_0F31)) {
    return 1;
  }

  var_1 = _func_0204(level._id_0F31, var_0);

  foreach(var_3 in var_1) {
    if(_func_011A(var_0, var_3)) {
      return 1;
    }
  }

  return 0;
}

_id_6F0B(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_0 givemaxammo(var_3);

    if(weaponmaxammo(var_3) == weaponclipsize(var_3)) {
      var_0 setweaponammoclip(var_3, weaponclipsize(var_3));
    }
  }

  var_5 = getarraykeys(var_0._id_BADE);

  foreach(var_7 in var_5) {
    if(var_0._id_BADE[var_7]._id_DDEF == "secondary") {
      continue;
    }
    var_0 thread _id_C107(var_7);
  }
}

_id_C107(var_0) {
  var_1 = self._id_BADE[var_0]._id_DDEF;

  if(istrue(self._id_BADE[var_0]._id_0026)) {
    while(istrue(self._id_BADE[var_0]._id_0026)) {
      wait 0.05;
    }
  }

  if(istrue(self._id_BADE[var_0]._id_FD96)) {
    while(istrue(self._id_BADE[var_0]._id_FD96)) {
      wait 0.05;
    }
  }

  thread _id_0753::_id_6FD3(var_0, var_1, undefined, undefined, undefined, undefined, 1);

  if(istrue(level._id_CFE1)) {
    if(isDefined(level._id_BAB5)) {
      self[[level._id_BAB5]](10, "secondary");
    }
  }

  if(istrue(level._id_7E88)) {
    if(isDefined(level._id_BAB5)) {
      self[[level._id_BAB5]](100);
    }
  }
}

_id_A8D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  _id_0748::_id_A8D2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_A7C8(var_0) {
  if(!isDefined(level._id_A8E8)) {
    level._id_A8E8 = [];
  }

  if(!isDefined(level._id_A8E8[var_0])) {
    level._id_A8E8[var_0] = level._id_A8E8.size + 1;
  }

  return level._id_A8E8[var_0];
}

_id_A86C(var_0) {
  _id_0748::_id_4729(var_0);
  var_1 = _id_0748::_id_660E(var_0);

  if(isDefined(var_1)) {
    if(var_1 == "global") {
      return;
    }
  }

  _id_0748::_id_C5CA(var_0);
}

_id_7970(var_0, var_1, var_2) {
  if(istrue(var_1)) {
    var_3 = int(_func_0222("cp/cp_hints.csv", 1, var_0, 0));
  } else {
    var_3 = 0;
  }

  self setclientomnvar("zm_hint_index", var_3);

  if(isDefined(var_2)) {
    wait(var_2);

    if(isDefined(self) && !_func_0458(self)) {
      self setclientomnvar("zm_hint_index", 0);
    }
  }
}

_id_63B7(var_0) {
  var_1 = _func_0222("cp/carry_items.csv", 1, var_0, 0);

  if(isDefined(var_1)) {
    return var_1;
  } else {
    return 0;
  }
}

_id_D180(var_0, var_1) {
  var_2 = _id_63B7(var_1);
  var_3 = 1;

  if(!isDefined(var_0._id_32EA) || var_0._id_32EA == 0) {
    var_0._id_32EA = int(var_2);
  } else {
    var_0._id_32E9 = int(var_2);
    var_3 = 2;
  }

  var_4 = spawnStruct();
  var_4._id_32E1 = var_1;
  var_4._id_DDEF = var_3;
  _id_072E::_id_2BF5(var_0);
  return var_4;
}

_id_C38D(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1 == 1) {
    var_0._id_32EA = 0;
  } else if(var_1 == 2) {
    var_0._id_32E9 = 0;
  }

  _id_072E::_id_2BF5(var_0);
}

_id_10A9(var_0) {
  level thread _id_10AA(var_0);
}

_id_10AA(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level endon("game_ended");

  if(scripts\engine\utility::_id_5C0C("ready_for_devgui")) {
    scripts\engine\utility::_id_5C24("ready_for_devgui");
  }

  if(scripts\engine\utility::_id_5C0C("strike_init_done")) {
    scripts\engine\utility::_id_5C24("strike_init_done");
  }

  if(scripts\engine\utility::_id_5C0C("introscreen_over")) {
    scripts\engine\utility::_id_5C24("introscreen_over");
  }

  wait 2;
  var_1 = "";
  var_2 = strtok(var_0, "/");
  var_3 = " ";
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_7 = strtok(var_6, " ");
    var_8 = 1;
    var_9 = var_7.size;

    foreach(var_11 in var_7) {
      if(var_8 < var_9) {
        var_1 = var_1 + var_11 + var_3;
      } else {
        var_1 = var_1 + var_11;
      }

      var_8++;
    }

    var_4++;

    if(var_4 < var_2.size) {
      var_1 = var_1 + "/";
    }
  }
}

_id_1BD5(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = ::_id_45C8;
  }

  var_2 = istrue(var_2);

  for(var_3 = 0; var_3 < var_0.size - 1; var_3++) {
    for(var_4 = var_3 + 1; var_4 < var_0.size; var_4++) {
      if(var_2) {
        if(var_0[var_4][[var_1]]() > var_0[var_3][[var_1]]()) {
          var_5 = var_0[var_4];
          var_0[var_4] = var_0[var_3];
          var_0[var_3] = var_5;
        }

        continue;
      }

      if(var_0[var_4][[var_1]]() < var_0[var_3][[var_1]]()) {
        var_5 = var_0[var_4];
        var_0[var_4] = var_0[var_3];
        var_0[var_3] = var_5;
      }
    }
  }

  return var_0;
}

_id_1B9F(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return 0;
  }

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5])) {
      return 0;
    }

    var_4 = var_1[var_5];

    if(var_4 != var_3) {
      return 0;
    }
  }

  return 1;
}

_id_45C8(var_0, var_1) {
  return randomint(100);
}

_id_D39D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6._id_9C22 = var_0 / 100;
  var_6._id_9E9F = var_1 / 100;
  var_6._id_D02A = var_2 / 100;
  var_6._id_BB55 = var_3;
  var_6._id_AF8F = var_4 / 100;
  var_6._id_24DC = var_5;
  level._id_D02E = var_6;
}

_id_D02B(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("one_instance_of_segmented_health");
  var_0 endon("one_instance_of_segmented_health");
  var_0 waittill("spawned_player");
  var_1 = level._id_D02E;
  var_0._id_9C22 = int(var_0.maxhealth * var_1._id_9C22);
  var_0._id_9E9F = int(var_0.maxhealth * var_1._id_9E9F);
  var_0._id_D02A = int(var_0.maxhealth * var_1._id_D02A);
  var_0._id_BB55 = var_1._id_BB55;
  var_0._id_AF8F = int(var_0.maxhealth * var_1._id_AF8F);
  var_0._id_24DC = var_1._id_24DC;
  _id_D1A4(var_0, var_0._id_9C22);

  for(;;) {
    var_0 scripts\engine\utility::_id_10897("damage", "revive");
    _id_FB51(var_0);

    if(!_id_30C1(var_0)) {
      continue;
    }
    var_0 thread _id_D02D(var_0);
  }
}

_id_D02D(var_0) {
  var_0 notify("segmented_health_regen_internal");
  level endon("game_ended");
  var_0 endon("segmented_health_regen_internal");
  var_0 endon("disconnect");
  var_0 endon("damage");
  var_0 endon("last_stand");
  wait(var_0._id_BB55);

  for(;;) {
    var_0.health = int(min(int(min(var_0.health + var_0._id_AF8F, var_0._id_4177)), var_0.maxhealth));

    if(var_0.health == var_0._id_4177) {
      return;
    }
    wait(var_0._id_24DC);
  }
}

_id_D1A4(var_0, var_1) {
  var_0._id_4177 = int(var_1);
  var_0._id_4178 = int(var_1 - var_0._id_D02A);
}

_id_FB51(var_0) {
  if(var_0._id_4177 == var_0._id_9E9F) {
    return;
  }
  if(var_0.health < var_0._id_4178) {
    _id_D1A4(var_0, _id_5AD1(var_0));
  }
}

_id_5AD1(var_0) {
  var_1 = int((var_0._id_9C22 - var_0._id_9E9F) / var_0._id_D02A);

  for(var_2 = 0; var_2 <= var_1 + 1; var_2++) {
    var_3 = var_0._id_9E9F + var_2 * var_0._id_D02A;

    if(var_3 >= var_0.health) {
      return int(min(var_3, var_0.maxhealth));
    }
  }
}

_id_30C1(var_0) {
  if(_id_86B1(var_0)) {
    return 0;
  }

  if(_id_073B::_id_B4EF(var_0)) {
    return 0;
  }

  return 1;
}

_id_86B1(var_0) {
  return istrue(var_0._id_D02C);
}

_id_4A47(var_0) {
  var_0._id_D02C = 1;
}

_id_521E(var_0) {
  var_0._id_D02C = 0;
}

_id_85D9(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.team) && var_1.team == var_0.team) {
      return 1;
    }

    if(isDefined(var_1.owner) && isDefined(var_1.owner.team) && var_1.owner.team == var_0.team) {
      return 1;
    }
  }

  return 0;
}

_id_4F05(var_0, var_1) {
  var_2 = var_0[0];
  var_3 = var_1[0];
  var_4 = var_0[1];
  var_5 = var_1[1];
  var_6 = max(var_0[2], var_1[2]);
  var_7 = (var_2, var_5, var_6);
  var_8 = (var_3, var_4, var_6);
}

_id_10027(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_2 = var_0 gettagorigin("tag_origin", 1);

  if(isDefined(var_2)) {
    var_1 linkto(var_0, "tag_origin", (0, 0, 190), (0, 0, 0));
  } else {
    var_1 linkto(var_0);
  }

  var_3 = _id_100BA();

  if(!isDefined(var_3)) {
    return;
  }
  var_0._id_7635 = var_3;
  var_4 = 1;

  if(!isDefined(level._id_7636)) {
    level._id_7636 = [];
  }

  level._id_7636[var_0._id_7635] = var_1;
  setomnvar("ui_ingame_light_tank_ent_" + var_0._id_7635, var_1);
  setomnvar("ui_ingame_light_tank_team_" + var_0._id_7635, var_4);
  setomnvar("ui_ingame_light_tank_health_" + var_0._id_7635, 1);
}

_id_100BA() {
  if(!isDefined(level._id_7636)) {
    level._id_7636 = [];
  }

  var_0 = undefined;

  for(var_1 = 0; var_1 < 7; var_1++) {
    if(!isDefined(level._id_7636[var_1])) {
      var_0 = var_1;
      break;
    }
  }

  return var_0;
}

_id_100AE() {
  if(isDefined(self._id_7635)) {
    var_0 = level._id_7636[self._id_7635];
    var_0 delete();
    setomnvar("ui_ingame_light_tank_ent_" + self._id_7635, undefined);
    setomnvar("ui_ingame_light_tank_health_" + self._id_7635, 0);
    setomnvar("ui_ingame_light_tank_team_" + self._id_7635, 0);
    level._id_7636[self._id_7635] = undefined;
    self._id_7635 = undefined;
  }
}

_id_1035D(var_0) {
  if(isDefined(self._id_7635)) {
    setomnvar("ui_ingame_light_tank_health_" + self._id_7635, var_0);
  }
}

_id_3F91(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 1.0;
  }

  var_6 = undefined;

  if(var_2 != "all") {
    var_6 = newteamhudelem(var_2);
  } else {
    var_6 = newhudelem();
  }

  var_6._id_7C8C = var_0;
  var_6.x = var_1[0];
  var_6.y = var_1[1];
  var_6._id_050C = var_1[2];
  var_6.team = var_2;
  var_6._id_8864 = 0;
  var_6._id_8A30 = 1;

  if(_func_011F()) {
    var_6 setshader(var_3, 8, 8);
  } else {
    var_6 setshader(var_3, 15, 15);
  }

  var_6 _meth_83B2(0, 1, 1);

  if(isDefined(var_4)) {
    var_6.alpha = var_4;
  } else {
    var_6.alpha = 0.75;
  }

  var_6._id_22AE = var_6.alpha;
  return var_6;
}

_id_10CC3(var_0) {
  var_0 destroy();
}

_freezecontrols(var_0, var_1) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
  }

  if(var_0) {
    self.pers["controllerFreezeStack"]++;
  } else if(istrue(var_1)) {
    self.pers["controllerFreezeStack"] = 0;
  } else {
    self.pers["controllerFreezeStack"]--;
  }

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self._id_3C69 = 0;
  } else {
    self freezecontrols(1);
    self._id_3C69 = 1;
  }
}

_id_0BEE(var_0, var_1) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerLookFreezeStack"])) {
    self.pers["controllerLookFreezeStack"] = 0;
  }

  if(var_0) {
    self.pers["controllerLookFreezeStack"]++;
  } else if(istrue(var_1)) {
    self.pers["controllerLookFreezeStack"] = 0;
  } else {
    self.pers["controllerLookFreezeStack"]--;
  }

  if(self.pers["controllerLookFreezeStack"] <= 0) {
    self.pers["controllerLookFreezeStack"] = 0;
    self freezelookcontrols(0);
    self._id_97F5 = 0;
  } else {
    self freezelookcontrols(1);
    self._id_97F5 = 1;
  }
}

_id_0CE5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self)) {
    return;
  }
  var_0 = max(var_0, 0.0);
  var_1 = clamp(var_1, 1.0, 9994.0);
  var_2 = clamp(var_2, 2.0, 9998.0);
  var_3 = clamp(var_3, 3.0, 9999);

  if(var_2 > 9994.0) {
    var_5 = 0.0;
  }

  self _meth_830B(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_D51F() {
  self endon("disconnect");
  self endon("death");
  _id_D51E();

  if(isai(self)) {
    return;
  }
  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = ["physicscontents_characterproxy"];
  var_3 = physics_createcontents(var_2);
  var_4 = 1;
  var_5 = 1;
  var_6 = cos(27);
  var_7 = 1;
  var_8 = 0;
  var_9 = [];
  var_9["geo"] = spawnStruct();
  var_9["geo"]._id_A400 = getdvarfloat("#x3f6ad6d89fc92e3f2", 0.01);
  var_9["geo"]._id_A3F7 = getdvarfloat("#x3bf828942a7c07f03", 0.95);
  var_9["geo"]._id_59B4 = getdvarfloat("#x3955bd346bbbc8837", 1.5);
  var_9["geo"]._id_59B0 = getdvarfloat("#x3183bdf3b3540e20e", 2.5);
  var_9["geo"]._id_A3EF = getdvarfloat("#x31441c94e36c2f377", 3.9);
  var_9["geo"]._id_59AF = getdvarfloat("#x368e32e14108584d0", 2.25);
  var_9["interest"] = spawnStruct();
  var_9["interest"]._id_A400 = getdvarfloat("#x33a65ce70502f61a8", 0.01);
  var_9["interest"]._id_A3F7 = getdvarfloat("#x3b0034cda50fa2339", 0.95);
  var_9["interest"]._id_59B4 = getdvarfloat("#x315f28cdb5f2667d", 1.5);
  var_9["interest"]._id_59B0 = getdvarfloat("#x3ecbfdb2fe8fd9fc4", 2.5);
  var_9["interest"]._id_A3EF = getdvarfloat("#x3e8e55795203d0dbd", 7.0);
  var_9["interest"]._id_59AF = getdvarfloat("#x362e944aaf94f2922", 3.5);

  for(;;) {
    waitframe();
    var_10 = "geo";

    if(istrue(self._id_FF0A)) {
      continue;
    }
    var_11 = self playerads() > 0.9;

    if(var_7 && !var_11) {
      if(var_8) {
        var_8 = 0;
        _id_0CE5(0, 0, 512, 512, 4, 0);
      }

      continue;
    }

    var_12 = self getEye();
    var_13 = self getplayerangles();
    var_14 = anglesToForward(var_13);
    var_15 = -1;
    var_16 = undefined;
    var_17 = undefined;
    var_18 = undefined;
    var_19 = undefined;

    if(var_4) {
      var_20 = 0;

      foreach(var_22 in level.players) {
        if(!scripts\cp_mp\utility\player_utility::_id_B78C(self, var_22)) {
          continue;
        }
        if(!var_22 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        var_23 = var_22 getEye();
        var_24 = vectordot(var_14, vectornormalize(var_23 - var_12));

        if(var_24 < var_6) {
          continue;
        }
        var_25 = distance(var_12, var_23);

        if(!isDefined(var_16) || var_25 < var_16) {
          if(var_22 _meth_83CD(var_12, self) > 0) {
            var_16 = var_25;
          }
        }

        if(!isDefined(var_17) || var_25 > var_17) {
          if(var_22 _meth_83CD(var_12, self) > 0) {
            var_17 = var_25;
          }
        }
      }
    }

    var_27 = var_12 + var_14 * 10000;
    var_28 = scripts\engine\trace::_id_E409(var_12, var_27, 0.1, self, var_1, 0);
    var_19 = distance(var_12, var_28["position"]);
    var_29 = scripts\engine\trace::_id_E409(var_12, var_27, 20.0, self, var_3, 0);
    var_30 = var_29["entity"];
    var_31 = isDefined(var_30) && isPlayer(var_30) && scripts\cp_mp\utility\player_utility::_id_B78C(self, var_30);
    var_32 = var_31 && var_30 _meth_83CD(var_12, self) > 0;

    if(!isDefined(var_16) || var_19 < var_16) {
      var_16 = var_19;
    }

    if(!isDefined(var_17) || var_19 > var_17) {
      var_17 = var_19;
    }

    var_8 = 1;
    var_33 = max(abs(var_16 - var_17) * 0.5, 300.0);
    var_34 = 0.0;
    var_35 = max(var_16 - 50.0, 1.0);
    var_36 = var_17 + 50.0;
    var_37 = var_36 + var_33;
    var_38 = scripts\engine\utility::ter_op(var_32, 6.0, 4.0);
    var_39 = scripts\engine\utility::ter_op(var_32, 2.5, 1.25);
    _id_0CE5(var_34, var_35, var_36, var_37, var_38, var_39);
  }
}

_id_D523() {
  self endon("disconnect");
  self._id_FF0A = 1;
  _id_D524();
  _id_D51E();
}

_id_D524() {
  self endon("disconnect");
  self endon("death_delay_finished");
  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = vectornormalize(self.origin - self._id_8FFD.origin);
  var_3 = self.origin + (0, 0, 42);
  var_4 = var_3 + var_2 * 120.0;
  var_5 = scripts\engine\trace::_id_E409(var_3, var_4, 2.0, self, var_1, 0);
  var_6 = var_5["position"];

  while(istrue(self._id_FF0A)) {
    if(!isDefined(self._id_8FFD)) {
      break;
    }

    var_7 = distance(var_6, self._id_8FFD.origin);
    var_8 = 0.0;
    var_9 = max(var_7 - 12.0, 1.0);
    var_10 = var_7 + 12.0;
    var_11 = var_10 + 50.0;
    var_12 = 8.0;
    var_13 = 4.5;
    _id_0CE5(var_8, var_9, var_10, var_11, var_12, var_13);
    waitframe();
  }
}

_id_D51E() {
  self._id_FF0A = 0;
  _id_0CE5(0, 0, 512, 512, 4, 0);
}

_id_D52A() {
  self._id_FF0A = 1;
  _id_0CE5(0, 128, 512, 4000, 6, 1.8);
}

_id_D522() {
  self._id_FF0A = 1;
  _id_0CE5(0, 128, 512, 4000, 6, 1.8);
}

_id_D51B() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 6500, 7, 3.5);
}

_id_D51D() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 6500, 7, 3.5);
}

_id_D51C() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 1000, 7, 0);
}

_id_D52B() {
  self._id_FF0A = 1;
  _id_0CE5(10, 120, 1000, 6500, 7, 3.5);
}

_id_D52C() {
  self._id_FF0A = 1;
  _id_0CE5(0, 110, 512, 4096, 6, 1.8);
}

_id_4F1A(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

  if(isDefined(var_4)) {
    if(_func_0107(var_4)) {
      foreach(var_7 in var_4) {
        self endon(var_7);
      }
    } else
      self endon(var_4);
  }

  if(!isDefined(var_5)) {
    var_5 = var_0 + (0, 0, 256);
  }

  for(;;) {
    waitframe();
  }
}

_id_B2DE(var_0, var_1) {
  if(isDefined(var_1)) {
    playsoundatpos(self gettagorigin(var_1), var_0);
  } else {
    playsoundatpos(self.origin, var_0);
  }
}

_id_66AD(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = anglestoup(var_0.angles);
  var_4 = anglestoleft(var_0.angles);
  var_5 = anglesToForward(var_0.angles);
  var_6 = var_1[0] * var_5[0] + var_1[1] * var_4[0] + var_1[2] * var_3[0] + var_2[0];
  var_7 = var_1[0] * var_5[1] + var_1[1] * var_4[1] + var_1[2] * var_3[1] + var_2[1];
  var_8 = var_1[0] * var_5[2] + var_1[1] * var_4[2] + var_1[2] * var_3[2] + var_2[2];
  var_9 = (var_6, var_7, var_8);
  return var_9;
}

_id_0CDD(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isDefined(var_0._id_039B)) {
    return 0;
  }

  if(var_0._id_039B != var_1) {
    return 0;
  }

  return 1;
}

_id_DC6C() {
  for(;;) {
    var_0 = "";

    if(self _meth_805E("BUTTON_Y")) {
      var_0 = var_0 + ",y";
    }

    if(self _meth_805E("BUTTON_BACK")) {
      var_0 = var_0 + ",guide";
    }

    if(self stancebuttonPressed()) {
      var_0 = var_0 + ",stance";
    }

    if(self useButtonPressed()) {
      var_0 = var_0 + ",use";
    }

    if(self fragButtonPressed()) {
      var_0 = var_0 + ",frag";
    }

    if(self meleeButtonPressed()) {
      var_0 = var_0 + ",melee";
    }

    if(self jumpbuttonPressed()) {
      var_0 = var_0 + ",jump";
    }

    if(self attackButtonPressed()) {
      var_0 = var_0 + ",attack";
    }

    if(self secondaryoffhandbuttonPressed()) {
      var_0 = var_0 + ",secondary";
    }

    if(self adsButtonPressed()) {
      var_0 = var_0 + ",ADS";
    }

    self iprintln(var_0);
    wait 0.05;
  }
}

_id_C39C() {
  var_0 = self;

  if(isDefined(self._id_4213)) {
    var_0 = self._id_4213;
    var_0 scripts\engine\utility::_id_46A5(0.5, ::delete);
  }

  if(isDefined(var_0) && !_func_02DE(var_0)) {
    var_0 makeunusable();
  }

  if(isDefined(self)) {
    _id_A669("hint_destroyed", 0.05);
  }
}

_id_A669(var_0, var_1) {
  self endon("death");

  if(var_1 > 0) {
    wait(var_1);
  }

  if(!isDefined(self)) {
    return;
  }
  self notify(var_0);
}

_id_3EEE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = self;

  if(_func_02DE(var_14) || var_14.classname == "script_origin" || isDefined(var_1)) {
    var_14 = spawn("script_origin", self.origin);
    self._id_4213 = var_14;
    thread _id_7962();
  }

  if(isDefined(var_1)) {
    var_15 = "tag_origin";

    if(isDefined(var_0)) {
      var_15 = var_0;
      var_14.origin = self gettagorigin(var_15);
    }

    if(isDefined(self.model) && self.classname == "script_model" && scripts\engine\utility::hastag(self.model, var_15)) {
      var_14 linkto(self, var_15, var_1, (0, 0, 0));
    } else if(isDefined(var_0)) {
      var_14 linkto(self, var_15, var_1, (0, 0, 0));
    } else if(isDefined(self.angles)) {
      var_14.origin = var_14.origin + rotatevector(var_1, self.angles);

      if(isent(self)) {
        var_14 linkto(self);
      }
    } else {
      var_14.origin = var_14.origin + var_1;

      if(isent(self)) {
        var_14 linkto(self);
      }
    }
  } else if(isDefined(var_0))
    var_14 _meth_84D7(var_0);

  if(isDefined(var_8) && var_8) {
    var_14 setcursorhint("HINT_NOICON");
  } else {
    var_14 setcursorhint("HINT_BUTTON");
  }

  if(isDefined(var_2)) {
    var_14 sethintstring(var_2);
  }

  var_16 = 360;

  if(isDefined(var_3)) {
    var_16 = var_3;
  }

  var_14 sethintdisplayfov(var_16);
  var_17 = 65;

  if(isDefined(var_13)) {
    var_17 = var_13;
  }

  var_14 setusefov(var_17);
  var_18 = 500;

  if(isDefined(var_4)) {
    var_18 = var_4;
  }

  var_14 _meth_84D4(var_18);
  var_19 = 80;

  if(isDefined(var_5)) {
    var_19 = var_5;
  }

  var_14 setuserange(var_19);

  if(isDefined(var_6) && var_6) {
    var_14 _meth_84D9("show");
  } else {
    var_14 _meth_84D9("hide");
  }

  if(isDefined(var_7) && var_7) {
    var_14 _meth_84E4(var_7);
  }

  if(!isDefined(var_10)) {
    var_10 = "duration_short";
  }

  var_14 setuseholdduration(var_10);

  if(var_10 == "duration_medium" || var_10 == "duration_long") {
    var_14 sethintrequiresholding(1);
  }

  thread _id_795E();

  if(isDefined(var_9)) {
    var_14 _meth_84DA(var_9);
  }

  if(isDefined(var_11)) {
    var_14 _meth_84D3(var_11);
  }

  if(isDefined(var_12)) {
    var_14 _meth_8581(1);
  } else {
    var_14 _meth_8581(0);
  }

  var_14 makeuseable();
  return var_14;
}

_id_7962() {
  self endon("death");
  self endon("hint_destroyed");
  self._id_4213 waittill("trigger", var_0);
  self notify("trigger", var_0);
}

_id_795E() {
  self endon("hint_destroyed");
  var_0 = self;

  if(isDefined(self._id_4213)) {
    var_0 = self._id_4213;
  }

  _id_795F(var_0);
  thread _id_C39C();
}

_id_795F(var_0) {
  self endon("entitydeleted");
  var_0 waittill("trigger");
}

_id_ACB8(var_0, var_1, var_2) {
  thread _id_ACB9(var_0, var_1, var_2);
}

_id_ACB9(var_0, var_1, var_2) {
  level notify("hud_outline_alpha_fade_" + var_0);
  level endon("hud_outline_alpha_fade_" + var_0);
  var_0++;
  var_3 = _func_0483("#x319f1162cadd6a0eb", var_0);
  var_4 = getDvar(var_3);
  var_4 = strtok(var_4, " ");
  var_5 = var_4[0] + " " + var_4[1] + " " + var_4[2] + " ";
  var_6 = float(var_4[3]);
  var_7 = var_1 - var_6;
  var_8 = 0.05;
  var_9 = int(var_2 / var_8);

  if(var_9 > 0) {
    for(var_10 = var_7 / var_9; var_9; var_9--) {
      var_6 = var_6 + var_10;
      var_6 = clamp(var_6, 0, 1);
      setsaveddvar(var_3, var_5 + var_6);
      wait(var_8);
    }
  }

  setsaveddvar(var_3, var_5 + var_1);
}

_id_1079(var_0, var_1, var_2, var_3) {
  _id_810A();
  var_4 = spawnStruct();
  var_4._id_2F63 = self;
  var_4._id_6016 = var_0;
  var_4._id_AE66 = [];

  if(isDefined(var_1)) {
    var_4._id_AE66[var_4._id_AE66.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4._id_AE66[var_4._id_AE66.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4._id_AE66[var_4._id_AE66.size] = var_3;
  }

  if(!isDefined(level._id_1085D._id_106D0)) {
    level._id_1085D._id_106D0 = [var_4];
  } else {
    level._id_1085D._id_106D0[level._id_1085D._id_106D0.size] = var_4;
  }
}

_id_810A() {
  if(!scripts\engine\utility::_id_0FE2("waits", ::_id_810A)) {
    return;
  }
  level._id_1085D = spawnStruct();
  level._id_1085D._id_106D0 = [];
  level._id_1085D._id_C9CC = [];
  level._id_1085D._id_C9B5 = [];
  level._id_1085D._id_C9E6 = [];
  level._id_1085D._id_4C32 = [];
  level._id_1085D._id_0E08 = [];
}

_id_107A() {
  level notify("kill_add_wait_asserter");
  level endon("kill_add_wait_asserter");

  for(var_0 = 0; var_0 < 20; var_0++) {
    waittillframeend;
  }
}

_id_4C31() {
  _id_810A();
  _id_4C30(level._id_1085D._id_106D0.size - 1);
}

_id_4C30(var_0) {
  _id_810A();

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = spawnStruct();
  var_2 = level._id_1085D._id_106D0;
  var_3 = level._id_1085D._id_4C32;
  var_4 = level._id_1085D._id_C9CC;
  var_5 = level._id_1085D._id_C9B5;
  var_6 = level._id_1085D._id_C9E6;
  var_7 = level._id_1085D._id_0E08;
  level._id_1085D._id_106D0 = [];
  level._id_1085D._id_C9CC = [];
  level._id_1085D._id_4C32 = [];
  level._id_1085D._id_0E08 = [];
  level._id_1085D._id_C9B5 = [];
  level._id_1085D._id_C9E6 = [];
  var_1._id_011A = var_2.size;
  var_1 scripts\engine\utility::_id_1BB7(var_2, ::_id_108D7, var_3);
  var_1 thread _id_4BDB(var_7);
  var_1 endon("any_funcs_aborted");

  for(;;) {
    if(var_1._id_011A <= var_0) {
      break;
    }

    var_1 waittill("func_ended");
  }

  var_1 notify("all_funcs_ended");
  scripts\engine\utility::_id_1BB7(var_4, ::_id_56E5, []);
  scripts\engine\utility::_id_1BB7(var_5, ::_id_56E3);
  scripts\engine\utility::_id_1BB7(var_6, ::_id_56E4);
}

_id_56E3(var_0) {
  if(var_0._id_AE66.size == 0) {
    var_0._id_2F63 call[[var_0._id_6016]]();
  } else if(var_0._id_AE66.size == 1) {
    var_0._id_2F63 call[[var_0._id_6016]](var_0._id_AE66[0]);
  } else if(var_0._id_AE66.size == 2) {
    var_0._id_2F63 call[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1]);
  } else if(var_0._id_AE66.size == 3) {
    var_0._id_2F63 call[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2]);
  }

  if(var_0._id_AE66.size == 4) {
    var_0._id_2F63 call[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2], var_0._id_AE66[3]);
  }

  if(var_0._id_AE66.size == 5) {
    var_0._id_2F63 call[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2], var_0._id_AE66[3], var_0._id_AE66[4]);
  }
}

_id_56E4(var_0) {
  if(var_0._id_AE66.size == 0) {
    call[[var_0._id_6016]]();
  } else if(var_0._id_AE66.size == 1) {
    call[[var_0._id_6016]](var_0._id_AE66[0]);
  } else if(var_0._id_AE66.size == 2) {
    call[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1]);
  } else if(var_0._id_AE66.size == 3) {
    call[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2]);
  }

  if(var_0._id_AE66.size == 4) {
    call[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2], var_0._id_AE66[3]);
  }

  if(var_0._id_AE66.size == 5) {
    call[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2], var_0._id_AE66[3], var_0._id_AE66[4]);
  }
}

_id_56E5(var_0, var_1) {
  if(!isDefined(var_0._id_2F63)) {
    return;
  }
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2]._id_2F63 endon(var_1[var_2]._id_52F4);
  }

  if(var_0._id_AE66.size == 0) {
    var_0._id_2F63[[var_0._id_6016]]();
  } else if(var_0._id_AE66.size == 1) {
    var_0._id_2F63[[var_0._id_6016]](var_0._id_AE66[0]);
  } else if(var_0._id_AE66.size == 2) {
    var_0._id_2F63[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1]);
  } else if(var_0._id_AE66.size == 3) {
    var_0._id_2F63[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2]);
  }

  if(var_0._id_AE66.size == 4) {
    var_0._id_2F63[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2], var_0._id_AE66[3]);
  }

  if(var_0._id_AE66.size == 5) {
    var_0._id_2F63[[var_0._id_6016]](var_0._id_AE66[0], var_0._id_AE66[1], var_0._id_AE66[2], var_0._id_AE66[3], var_0._id_AE66[4]);
  }
}

_id_4BDB(var_0) {
  self endon("all_funcs_ended");

  if(!var_0.size) {
    return;
  }
  var_1 = 0;
  self._id_0E07 = var_0.size;
  var_2 = [];
  scripts\engine\utility::_id_1BB7(var_0, ::_id_10876, var_2);

  for(;;) {
    if(self._id_0E07 <= var_1) {
      break;
    }

    self waittill("abort_func_ended");
  }

  self notify("any_funcs_aborted");
}

_id_10876(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  _id_56E5(var_0, var_1);
  self._id_0E07--;
  self notify("abort_func_ended");
}

_id_108D7(var_0, var_1) {
  self endon("all_funcs_ended");
  self endon("any_funcs_aborted");
  _id_56E5(var_0, var_1);
  self._id_011A--;
  self notify("func_ended");
}

_id_108E9(var_0) {
  self waittill(var_0);
}

_id_3EE1(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = newclienthudelem(var_2);
  } else {
    var_3 = newhudelem();
  }

  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader(var_0, 640, 480);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = var_1;
  var_3._id_01D6 = 1;
  return var_3;
}

_id_3FF0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = undefined;

  if(isDefined(var_11)) {
    var_12 = var_11;
  } else {
    var_12 = spawn("script_model", var_0);
  }

  var_12 _id_D5A6(undefined, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

  if(!isDefined(var_4)) {
    var_12 _meth_83A1(0);
  }

  if(!isDefined(var_11)) {
    return var_12;
  }
}

_id_3944(var_0) {}

_id_62FC(var_0, var_1, var_2) {
  level endon("game_ended");

  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = _func_00D7();

    if(isDefined(level._id_87ED) && level._id_87ED) {
      var_3 = var_3 + 3600;
    }
  }

  if(isDefined(var_0)) {
    var_3 = var_3 - 3600 * var_0;
  }

  var_4 = 1970;
  var_5 = floor(var_3 / 31536000);

  if(var_5 != 0) {
    var_6 = floor((var_5 + 2) / 4);
  } else {
    var_6 = 0;
  }

  var_3 = var_3 - var_5 * 31536000;
  var_3 = var_3 - var_6 * 86400;
  var_4 = var_4 + var_5;

  if(!_id_85A6(var_4, 4)) {
    var_7 = floor(var_5 / 4);
    var_8 = var_5 / 4;
    var_9 = var_8 - var_7;

    if(var_9 >= 0.75) {
      var_10 = 1;
    } else {
      var_10 = 0;
    }
  } else
    var_10 = 0;

  if(var_3 != 0) {
    var_11 = floor(var_3 / 86400);
    var_3 = var_3 - var_11 * 86400;
  } else
    var_11 = 0;

  if(var_3 != 0) {
    var_12 = floor(var_3 / 3600);
    var_3 = var_3 - var_12 * 3600;
  } else
    var_12 = 0;

  if(var_3 != 0) {
    var_13 = floor(var_3 / 60);
    var_3 = var_3 - var_13 * 60;
  } else
    var_13 = 0;

  var_14 = _id_48A4(var_11 + 1, var_10);
  var_14["year"] = var_4;
  var_14["hours"] = var_12;
  var_14["minutes"] = var_13;
  var_14["seconds"] = var_3;

  if(isDefined(var_2)) {
    return var_14;
  }

  if(isDefined(level._id_87ED)) {
    level notify("time_check", var_4, var_14["month_string"], var_14["days"], var_12, var_13, var_3);
    return var_14;
  } else {
    var_14 = _id_8597(var_14, var_0, var_1);
    level notify("time_check", var_4, var_14["month_string"], var_14["days"], var_12, var_13, var_3);
    return var_14;
  }
}

_id_8597(var_0, var_1, var_2) {
  var_3 = 0;

  if(var_0["month_string"] == "March" && var_0["year"] == 2017) {
    var_3 = 1;
  } else if(var_0["month_string"] == "December" || var_0["month_string"] == "January" || var_0["month_string"] == "February") {
    var_3 = 0;
  } else if(var_0["month_string"] != "March" && var_0["month_string"] != "April") {
    var_3 = 1;
  } else if(var_0["month_string"] == "March" && var_0["days"] >= 14) {
    var_3 = 1;
  } else if(var_0["month_string"] == "November" && var_0["days"] <= 6) {
    var_3 = 0;
  } else {
    var_3 = 0;
  }

  if(var_3) {
    level._id_87ED = 1;
    var_0 = _id_62FC(var_1, var_2, 1);
  } else
    level._id_87ED = 0;

  return var_0;
}

_id_4C72(var_0, var_1, var_2) {
  var_3 = 30;

  switch (var_1) {
    case "January":
      var_3 = 31;
      break;
    case "February":
      if(var_2) {
        var_3 = 29;
      } else {
        var_3 = 28;
      }

      break;
    case "March":
      var_3 = 31;
      break;
    case "April":
      var_3 = 30;
      break;
    case "May":
      var_3 = 31;
      break;
    case "June":
      var_3 = 30;
      break;
    case "July":
      var_3 = 31;
      break;
    case "August":
      var_3 = 31;
      break;
    case "September":
      var_3 = 30;
      break;
    case "October":
      var_3 = 31;
      break;
    case "November":
      var_3 = 30;
      break;
    case "December":
      var_3 = 31;
      break;
    default:
      break;
  }

  if(var_0 > var_3) {
    return 1;
  } else {
    return 0;
  }
}

_id_48A4(var_0, var_1) {
  var_2 = [];
  var_2["month"] = undefined;
  var_2["month_string"] = undefined;
  var_2["days"] = undefined;
  var_3 = int(istrue(var_1));

  if(var_0 <= 31) {
    var_2["month"] = 1;
    var_2["month_string"] = "January";
    var_2["days"] = var_0;
    return var_2;
  } else if(var_0 <= 59 + var_3) {
    var_2["month"] = 2;
    var_2["month_string"] = "February";
    var_2["days"] = var_0 - 31;
    return var_2;
  } else if(var_0 <= 90 + var_3) {
    var_2["month"] = 3;
    var_2["month_string"] = "March";
    var_2["days"] = var_0 - (59 + var_3);
    return var_2;
  } else if(var_0 <= 120 + var_3) {
    var_2["month"] = 4;
    var_2["month_string"] = "April";
    var_2["days"] = var_0 - (90 + var_3);
    return var_2;
  } else if(var_0 <= 151 + var_3) {
    var_2["month"] = 5;
    var_2["month_string"] = "May";
    var_2["days"] = var_0 - (120 + var_3);
    return var_2;
  } else if(var_0 <= 182 + var_3) {
    var_2["month"] = 6;
    var_2["month_string"] = "June";
    var_2["days"] = var_0 - (151 + var_3);
    return var_2;
  } else if(var_0 <= 212 + var_3) {
    var_2["month"] = 7;
    var_2["month_string"] = "July";
    var_2["days"] = var_0 - (182 + var_3);
    return var_2;
  } else if(var_0 <= 243 + var_3) {
    var_2["month"] = 8;
    var_2["month_string"] = "August";
    var_2["days"] = var_0 - (212 + var_3);
    return var_2;
  } else if(var_0 <= 273 + var_3) {
    var_2["month"] = 9;
    var_2["month_string"] = "September";
    var_2["days"] = var_0 - (243 + var_3);
    return var_2;
  } else if(var_0 <= 304 + var_3) {
    var_2["month"] = 10;
    var_2["month_string"] = "Octobor";
    var_2["days"] = var_0 - (273 + var_3);
    return var_2;
  } else if(var_0 <= 335 + var_3) {
    var_2["month"] = 11;
    var_2["month_string"] = "November";
    var_2["days"] = var_0 - (304 + var_3);
    return var_2;
  } else {
    var_2["month"] = 12;
    var_2["month_string"] = "December";
    var_2["days"] = var_0 - (335 + var_3);
    return var_2;
  }
}

_id_D219(var_0) {
  if(var_0) {
    self._id_5FAE = undefined;
  } else {
    self._id_5FAE = 1;
  }
}

_id_236C(var_0) {
  thread _id_236D(var_0);
}

_id_236D(var_0) {
  level endon("battlechatter_off_thread");
  _id_070A::_id_244D();

  while(!isDefined(anim._id_341F)) {
    waitframe();
  }

  anim._id_2440 = 1;
  wait 1.5;

  if(isDefined(var_0)) {
    _id_070A::_id_D172(var_0, 1);
    var_1 = _func_0070(var_0);
  } else {
    foreach(var_0 in anim._id_EFA0) {
      _id_070A::_id_D172(var_0, 1);
    }

    var_1 = _func_0070();
  }

  if(isDefined(level._id_8B45) && isDefined(level._id_8B45._id_0F1F)) {
    var_1 = scripts\engine\utility::array_combine(var_1, level._id_8B45._id_0F1F);
  }

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_1[var_4] _id_D170(1);
  }
}

_id_D170(var_0) {
  if(!isDefined(anim._id_341F) || !anim._id_341F) {
    return;
  }
  if(istrue(self._id_237A)) {
    return;
  }
  if(var_0) {
    if(isDefined(self._id_CCBF) && !self._id_CCBF) {
      self._id_237D = 0;
    } else {
      self._id_237D = 1;
    }
  } else {
    self._id_237D = 0;

    if(isDefined(self._id_2359) && istrue(self._id_2359._id_8A4B)) {
      self waittill("done speaking");
    }
  }
}

_id_66CD(var_0, var_1) {
  var_2 = _func_0071(var_1, var_0, level._id_11056);
  var_2 = _func_0204(var_2, var_1);
  return var_2;
}

_id_6E3A() {
  return _func_0262();
}

_id_6673() {
  if(isDefined(self)) {
    if(!scripts\engine\utility::array_contains(level.players, self)) {
      return level.player;
    } else {
      return self;
    }
  } else
    return level.players[0];
}

_id_B542(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = 0.8;
  }

  var_4 = _id_6673();
  var_5 = var_4 getEye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglesToForward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglesToForward(var_8);
  var_10 = vectordot(var_7, var_9);

  if(var_10 < var_1) {
    return 0;
  }

  if(isDefined(var_2)) {
    return 1;
  }

  return scripts\engine\trace::_id_C052(var_0, var_5, var_3, scripts\engine\trace::_id_3EF6(1));
}

_id_85A6(var_0, var_1) {
  if(floor(var_0 / var_1) > var_0 / var_1) {
    return 1;
  } else {
    return 0;
  }
}

_id_1BB8(var_0, var_1) {
  if(var_0.size == 0) {
    return var_1;
  }

  if(var_1.size == 0) {
    return var_0;
  }

  var_2 = var_0;

  foreach(var_4 in var_1) {
    var_5 = 0;

    foreach(var_7 in var_0) {
      if(var_7 == var_4) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      continue;
    } else {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_3F79(var_0) {
  if(!isDefined(level._id_EB07)) {
    level._id_EB07 = [];
  }

  var_1 = spawnStruct();
  var_1.name = var_0;
  level._id_EB07[var_0] = var_1;
  return var_1;
}

_id_FFE3(var_0, var_1) {
  var_2 = _func_025B(var_0, var_1);
  var_1 = _func_025B(var_2, var_0);
  var_3 = _func_0017(var_0, var_2, var_1);
  return var_3;
}

_id_406D(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1._id_4143 = 0;
  var_1._id_FEE7 = 0;
  var_1._id_FEB1 = 8000;
  var_1._id_84EF = 0;
  return var_1;
}

_id_6AC2(var_0) {
  foreach(var_2 in level._id_417B) {
    if(var_2._id_039B == var_0) {
      return var_2;
    }
  }

  return undefined;
}

_id_BEF7(var_0, var_1) {
  return _id_BEF9(var_0, 0, var_0.size - 1, var_1);
}

_id_BEF9(var_0, var_1, var_2, var_3) {
  var_4 = var_1;
  var_5 = var_2;

  if(!isDefined(var_3)) {
    var_3 = ::_id_BEF8;
  }

  if(var_2 - var_1 >= 1) {
    var_6 = var_0[var_1];

    while(var_5 > var_4) {
      while([[var_3]](var_0[var_4]._id_AF4E, var_6._id_AF4E) && var_4 <= var_2 && var_5 > var_4) {
        var_4++;
      }

      while(![[var_3]](var_0[var_5]._id_AF4E, var_6._id_AF4E) && var_5 >= var_1 && var_5 >= var_4) {
        var_5--;
      }

      if(var_5 > var_4) {
        var_0 = _id_EBF6(var_0, var_4, var_5);
      }
    }

    var_0 = _id_EBF6(var_0, var_1, var_5);
    var_0 = _id_BEF9(var_0, var_1, var_5 - 1, var_3);
    var_0 = _id_BEF9(var_0, var_5 + 1, var_2, var_3);
  } else
    return var_0;

  return var_0;
}

_id_BEF8(var_0, var_1) {
  return var_0 <= var_1;
}

_id_EBF6(var_0, var_1, var_2) {
  var_3 = var_0[var_1];
  var_0[var_1] = var_0[var_2];
  var_0[var_2] = var_3;
  return var_0;
}

_id_7908(var_0) {
  if(!isDefined(self._id_9F2B)) {
    self._id_9F2B = 0;
  }

  var_1 = self._id_9F2B;
  self._id_9F2B--;

  if(self._id_9F2B < 0) {
    self._id_9F2B = 0;
  }

  if(istrue(var_0) || self._id_9F2B == 0 && var_1 > self._id_9F2B) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(var_0)) {
      self._id_9F2B = 0;
    }
  }
}

_id_DCC4() {
  if(_id_8633()) {
    return;
  }
  if(!isDefined(self._id_9F2B)) {
    self._id_9F2B = 0;
  }

  var_0 = self._id_9F2B;
  self._id_9F2B++;

  if(self._id_9F2B == 1 && var_0 < self._id_9F2B) {
    self setclientomnvar("ui_hide_minimap", 0);
  }
}

getplayerdataloadoutgroup() {
  return "zmloadouts";
}

_id_4ADE() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("giveLoadout");
    _id_7908(1);
  }
}

_id_152B(var_0) {
  var_1 = self getstance();

  switch (var_1) {
    case "stand":
      scripts\common\utility::_id_1530(var_0);
      scripts\common\utility::_id_1570(var_0);
      break;
    case "crouch":
      scripts\common\utility::_id_1582(var_0);
      scripts\common\utility::_id_1570(var_0);
      break;
    case "prone":
      scripts\common\utility::_id_1582(var_0);
      scripts\common\utility::_id_1530(var_0);
      break;
  }
}

_id_6C61(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "allies";
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    if(scripts\engine\utility::is_equal(var_3.team == var_0)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_F036(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_1, "targetname");

  if(!isDefined(var_3) || var_3.size < 4) {
    return;
  }
  scripts\engine\utility::_id_5C24("player_spawned_with_loadout");
  var_4 = 0;

  foreach(var_6 in _id_6C61(var_0)) {
    var_3[var_4].angles = scripts\engine\utility::ter_op(isDefined(var_3[var_4].angles), var_3[var_4].angles, (0, 0, 0));
    var_6 setorigin(var_3[var_4].origin);
    var_6 setplayerangles(var_3[var_4].angles);
    var_6 dontinterpolate();
    var_4++;
  }

  if(!istrue(var_2)) {
    return;
  }
  level thread _id_F12A(var_0, var_1);
}

_id_F12A(var_0, var_1) {
  level endon("game_ended");
  level notify("waiting_for_team_teleports_" + var_0);
  level endon("waiting_for_team_teleports_" + var_0);

  for(;;) {
    level waittill("connected", var_2);
    level thread _id_F03E(var_2, var_1);
  }
}

_id_F03E(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  waitframe();
  _id_F03D(var_0, var_1);
}

_id_F03D(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_1, "targetname");

  if(!isDefined(var_2) || var_2.size < 4) {
    return;
  }
  var_3 = randomintrange(0, var_2.size);
  var_2[var_3].angles = scripts\engine\utility::ter_op(isDefined(var_2[var_3].angles), var_2[var_3].angles, (0, 0, 0));
  var_0 setorigin(var_2[var_3].origin);
  var_0 setplayerangles(var_2[var_3].angles);
  var_0 dontinterpolate();
}

_id_EA54(var_0) {
  if(var_0.size > 1) {
    return 0;
  }

  var_1 = [];
  var_1["0"] = 1;
  var_1["1"] = 1;
  var_1["2"] = 1;
  var_1["3"] = 1;
  var_1["4"] = 1;
  var_1["5"] = 1;
  var_1["6"] = 1;
  var_1["7"] = 1;
  var_1["8"] = 1;
  var_1["9"] = 1;

  if(isDefined(var_1[var_0])) {
    return 1;
  }

  return 0;
}

_id_80FF() {
  self setclientomnvar("ui_veh_vehicle", -1);
  self setclientomnvar("ui_veh_occupant_0", -1);
  self setclientomnvar("ui_veh_occupant_1", -1);
  self setclientomnvar("ui_veh_occupant_2", -1);
  self setclientomnvar("ui_veh_occupant_3", -1);
  self setclientomnvar("ui_veh_occupant_4", -1);
}

_id_BD15(var_0, var_1) {
  if(getdvarint("#x31b67fc2e3dd57ab1", 0) == 1) {
    return;
  }
  var_2 = "";

  if(isDefined(var_1)) {
    var_2 = "[" + var_1 getentitynumber() + ":" + var_1.name + "] ";
  }
}

_id_8989() {
  return self playerads() > 0.5;
}

_id_873C() {
  if(isai(self)) {
    return 0;
  }

  if(self.team == "spectator") {
    return 0;
  }

  return 0;
}

_id_63BD(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = (var_1[0] + var_0[var_2].origin[0], var_1[1] + var_0[var_2].origin[1], var_1[2] + var_0[var_2].origin[2]);
  }

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

_id_D5A6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  self makeuseable();

  if(isDefined(var_0)) {
    self _meth_84D7(var_0);
  }

  if(isDefined(var_1)) {
    self setcursorhint(var_1);
  } else {
    self setcursorhint("HINT_NOICON");
  }

  if(isDefined(var_2)) {
    self _meth_84DA(var_2);
  }

  if(isDefined(var_3)) {
    self sethintstring(var_3);
  }

  if(isDefined(var_4)) {
    var_4 = int(clamp(var_4, -10, 1));
    self _meth_83A1(var_4);
  } else
    self _meth_83A1(-10);

  if(isDefined(var_5)) {
    self setuseholdduration(var_5);

    if(var_5 == "duration_medium" || var_5 == "duration_long") {
      self sethintrequiresholding(1);
    }
  } else
    self setuseholdduration("duration_short");

  if(isDefined(var_6)) {
    self _meth_84D9(var_6);
  } else {
    self _meth_84D9("hide");
  }

  if(isDefined(var_7)) {
    self _meth_84D4(var_7);
  } else {
    self _meth_84D4(200);
  }

  if(isDefined(var_8)) {
    self sethintdisplayfov(var_8);
  } else {
    self sethintdisplayfov(160);
  }

  if(isDefined(var_9)) {
    self setuserange(var_9);
  } else {
    self setuserange(50);
  }

  if(isDefined(var_10)) {
    self setusefov(var_10);
  } else {
    self setusefov(120);
  }
}

_id_8609(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  if(isent(var_0)) {
    var_2 = var_0.origin;
  } else if(isvector(var_0)) {
    var_2 = var_0;
  } else if(_func_02DE(var_0)) {
    var_2 = var_0.origin;
  }

  var_3 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(var_2, var_2 + (0, 0, 10000), undefined, var_3)) {
    var_1 = 1;
  }

  return var_1;
}

_id_860A(var_0) {
  var_1 = 0;
  var_2 = (0, 0, 0);

  if(isent(var_0)) {
    var_2 = var_0.origin;
  } else if(isvector(var_0)) {
    var_2 = var_0;
  } else if(_func_02DE(var_0)) {
    var_2 = var_0.origin;
  }

  var_3 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 0, 1, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(var_2, var_2 + (0, 0, 10000), undefined, var_3)) {
    var_1 = 1;
  }

  return var_1;
}

_id_887A(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(issubstr(var_1, "ges_plyr")) {
    return 1;
  } else if(issubstr(var_1, "devilhorns_mp")) {
    return 1;
  } else {
    return 0;
  }
}

_id_0E90(var_0, var_1, var_2, var_3) {
  self _meth_83B8("actionslot" + var_0, var_1);

  if(isDefined(var_2)) {
    _id_D45D(var_0, var_2);
  }

  if(isDefined(var_3)) {
    thread _id_0E91(var_0, var_3);
  }
}

_id_0E91(var_0, var_1) {
  self endon("death");
  self endon("removeActionslot" + var_0);
  self notifyonplayercommand("actionslot" + var_0, "+actionslot " + var_0);

  for(;;) {
    self waittill("actionslot" + var_0);
    self thread[[var_1]]();
  }
}

_id_0E92(var_0) {
  self notify("removeActionslot" + var_0);
  self _meth_83B9("actionslot" + var_0, -1);
  self _meth_83B8("actionslot" + var_0, "none");
}

_id_D45D(var_0, var_1) {
  self _meth_83B9("actionslot" + var_0, var_1);
}

_id_47B2() {
  self endon("disconnect");

  if(!isDefined(self._id_4433)) {
    _id_D7A0();
  }

  self notifyonplayercommand("up", "+actionslot 1");
  self notifyonplayercommand("up_release", "-actionslot 1");
  self notifyonplayercommand("down", "+actionslot 2");
  self notifyonplayercommand("down_release", "-actionslot 2");
  self notifyonplayercommand("use", "+usereload");
  self notifyonplayercommand("use", "+activate");
  self notifyonplayercommand("use_release", "-usereload");
  self notifyonplayercommand("use_release", "-activate");
  self notifyonplayercommand("stance", "+stance");
  self notifyonplayercommand("stance_release", "-stance");
  self notifyonplayercommand("ads", "+speed_throw");
  self notifyonplayercommand("ads_release", "-speed_throw");
  self notifyonplayercommand("attack", "+attack");
  self notifyonplayercommand("attack_release", "-attack");
  self notifyonplayercommand("touchpad", "+focus");
  self notifyonplayercommand("touchpad", "+togglescores");
  self notifyonplayercommand("touchpad", "togglescores");
  self notifyonplayercommand("touchpad_release", "-focus");
  self notifyonplayercommand("touchpad_release", "-togglescores");
  self notifyonplayercommand("swap_weapon", "+weapnext");
  self notifyonplayercommand("swap_weapon_release", "-weapnext");
  self notifyonplayercommand("A", "+gostand");
  self notifyonplayercommand("A_release", "-gostand");
  self notifyonplayercommand("RIGHT", "+actionslot 4");
  var_0 = ["up", "up_release", "down", "down_release", "use", "use_release", "stance", "stance_release", "A", "A_release", "right", "ads", "ads_release", "attack", "attack_release", "touchpad", "touchpad_release", "swap_weapon", "swap_weapon_release"];
  var_1 = [];
  var_2 = 2;
  var_3 = undefined;

  for(;;) {
    var_4 = level._id_47B3;
    var_5 = scripts\engine\utility::_id_10893(var_0);

    if(getdvarint("#x35d9a930d72db2fa", 0)) {
      var_6 = gettime();

      if(!isDefined(var_3)) {
        var_3 = var_6 + var_2 * 1000;
      }

      var_1[var_1.size] = var_5;

      if(var_6 >= var_3) {
        var_3 = undefined;
        var_1 = [];
        continue;
      } else {
        var_3 = var_6 + var_2 * 1000;
        var_1 = _id_FF36(var_1);

        if(var_1.size < 1) {
          var_3 = undefined;
        }
      }
    }
  }
}

_id_D7A0() {}

_id_0FB5(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_2DC6 = var_0;
  var_4._id_6016 = var_1;
  var_4._id_9DE6 = var_2;
  var_4._id_F224 = var_3;
  level._id_47B3[level._id_47B3.size] = var_4;
}

_id_FF36(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_47B3.size; var_2++) {
    var_3 = level._id_47B3[var_2];
    var_4 = level._id_47B3[var_2]._id_2DC6;

    if(var_0.size <= var_4.size) {
      if(var_0[var_0.size - 1] == var_4[var_0.size - 1]) {
        if(var_0.size == var_4.size) {
          if(isDefined(var_3._id_9DE6)) {
            _func_0012(var_3._id_9DE6);
          }

          var_0 = [];
          self thread[[var_3._id_6016]]();
        }

        var_1 = var_0;
        break;
      }
    }
  }

  return var_1;
}

_id_6A01(var_0) {
  var_1 = level._id_EF89;
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  return var_1;
}

_id_8855() {
  return isDefined(self._id_AC3D) && isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female";
}

getgametype() {
  return level.gametype;
}

_id_C1D6(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    level._id_CF59[level._id_CF59.size] = var_0;
  }

  if(isDefined(var_1)) {
    level._id_CF5A[level._id_CF59.size] = var_1;
  }

  if(isDefined(var_2)) {
    level._id_3F68[var_0] = "cs" + var_2;
  }

  if(isDefined(var_3)) {
    level._id_CF58[level._id_CF58.size] = var_3;
  }
}

_id_1BB9(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_0) {
    var_4 notify(var_1, var_2);
  }
}

_id_1155(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(var_4)) {
    var_7 = 0;

    if(var_2 _id_8ACE()) {
      var_7 = 1;
    }

    var_8 = undefined;

    if(level.teambased) {
      var_8 = thread _id_078F::_id_D594(0, var_5, 1, 10000, undefined, undefined, 1, var_7);
    } else {
      var_8 = thread _id_078F::_id_D59B(var_2, "hud_icon_head_equipment_friendly", var_5, 1, 10000, undefined, undefined, 1);
    }

    thread _id_C531(var_8, var_6);
  }
}

_id_C531(var_0, var_1) {
  var_2 = ["death"];

  if(isDefined(var_1)) {
    var_2[var_2.size] = var_1;
  }

  scripts\engine\utility::_id_10893(var_2);
  _id_078F::_id_D593(var_0);
}

_id_8DB7(var_0, var_1, var_2, var_3, var_4) {
  self._id_1031E = var_0;
  self._id_CC16 = var_1;
  self._id_1068F = var_2;
  self._id_106B4 = var_3;
  self._id_484B = var_4;
  self _meth_86FE("killstreak");
  self _meth_8706(self.team);

  if(isDefined(self.owner)) {
    self.owner notify("killstreak_vehicle_made", self);
  }
}

_id_8DC1(var_0, var_1) {
  _id_8DC3();
  self._id_8E51 = var_1;
}

_id_8DC0(var_0, var_1) {
  _id_8DC3();
  self._id_8E50 = var_1;
}

_id_8DBF(var_0, var_1) {
  _id_8DC3();
  self._id_8E4E = var_1;
}

_id_8DC3() {
  if(!istrue(level._id_8E4C)) {
    level._id_8E4C = 1;
    level._id_8E51 = ::_id_8DB9;
    level._id_8E50 = ::_id_8DB8;
    level._id_8E4E = ::_id_8DB1;
  }
}

_id_8DB9(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;

  if(!istrue(self._id_8D8F)) {
    if(isDefined(var_2) && isDefined(self.owner) && var_2 == self.owner) {
      var_1 = int(_func_0037(var_1 * 0.5));
    }

    var_0.damage = var_1;
  }

  var_3 = 1;
  var_4 = self._id_8E51;

  if(isDefined(var_4)) {
    var_3 = self[[var_4]](var_0);
  }

  return var_3;
}

_id_8DB8(var_0) {
  _id_8DD6(var_0.attacker, var_0.objweapon, self, var_0._id_9CD6, var_0.damage);
  var_1 = 1;
  var_2 = self._id_8E50;

  if(isDefined(var_2)) {
    var_1 = self[[var_2]](var_0);
  }

  return var_1;
}

_id_8DB1(var_0) {
  _id_AB18(self.streakname, var_0.attacker, var_0.objweapon, var_0._id_9CD6, var_0.damage, self._id_CC16, self._id_1068F, self._id_484B);
  var_1 = 1;
  var_2 = self._id_8E4E;

  if(isDefined(var_2)) {
    var_1 = self[[var_2]](var_0);
  }

  return var_1;
}

_id_8DD6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && isPlayer(var_0) && isDefined(var_2.owner) && isDefined(var_2.owner.team)) {
    if(scripts\cp_mp\utility\player_utility::_id_B78C(var_0, var_2.owner)) {
      if(_id_88F6(var_1.basename)) {
        return;
      }
      var_5 = getcompleteweaponname(var_1);

      if(!isDefined(var_0._id_8FF1[var_5])) {
        var_0._id_8FF1[var_5] = 0;
      }

      if(var_0._id_8FF1[var_5] == gettime()) {
        return;
      }
      var_0._id_8FF1[var_5] = gettime();

      if(onlinestatsenabled()) {}

      if(isDefined(var_3) && scripts\engine\utility::_id_8794(var_3) || _id_89CC(var_3)) {
        var_0._id_8FB6 = gettime();
        var_6 = scripts\cp\cp_weapon::getweapongroup(var_1.basename);

        if(var_6 == "weapon_lmg") {
          if(!isDefined(var_0._id_DA69)) {
            var_0._id_DA69 = 1;
          } else {
            var_0._id_DA69++;
          }
        }
      }
    }
  }
}

_id_89CC(var_0) {
  var_1 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(var_1, var_0)) {
    return 1;
  }

  return 0;
}

_id_AB18(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_10 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1 = var_1.owner;
    }
  } else if(isDefined(var_1) && isDefined(self.team) && isDefined(var_1.team)) {
    if(isenemy(var_1) && isPlayer(var_1)) {
      var_10 = var_1;
    }
  }

  if(isDefined(var_10)) {
    if(isDefined(var_7)) {
      var_10 _id_0750::_id_8DCF(var_0);
    }

    thread _id_072A::_id_8D7B(var_0, var_10, var_2);
    _id_0793::_id_BD60(self, var_10);
    var_9 = 1;
  }

  if(isDefined(self.owner) && isDefined(var_6)) {}

  if(!istrue(var_8)) {
    self notify("death");
  }

  return var_9;
}

_id_7746(var_0) {
  _id_7745();
  _id_7744(var_0 + "_heli_entrance", var_0 + "_heli_goal");
}

_id_7744(var_0, var_1) {
  if(!isDefined(level._id_774A)) {
    level._id_774A = [];
  }

  if(!isDefined(level._id_774B)) {
    level._id_774B = [];
  }

  var_2 = scripts\engine\utility::getstruct(var_0, "script_noteworthy");
  var_3 = scripts\engine\utility::getstruct(var_1, "script_noteworthy");
  level._id_774A[level._id_774A.size] = var_2;
  level._id_774B[level._id_774B.size] = var_3;
}

_id_7745() {
  if(isDefined(level._id_774A) && level._id_774A.size >= 1) {
    level._id_774A = [];
  }

  if(isDefined(level._id_774B) && level._id_774B.size >= 1) {
    level._id_774B = [];
  }
}

_id_8694() {
  if(getdvarint("#x3f1a792b2b93c516d", 0)) {
    return 1;
  }

  return level.script == "cp_raid_complex" || level.script == "cp_dntsk_raid" || level.script == "cp_trap_room" || level.script == "cp_raid_phase1";
}

_id_871A() {
  if(level.gametype == "cp_wave_sv") {
    return 1;
  }

  return 0;
}

_id_86C9() {
  return level.gametype == "cp_specops";
}

_id_8654() {
  if(level.gametype == "cp_survival") {
    return 1;
  }

  return 0;
}

_id_872D() {
  if(level.gametype == "zombie") {
    return 1;
  }

  return 0;
}

_id_8588() {
  var_0 = getDvar("#x36d16f02578d0ee10");

  if(var_0 == "cp_raid_complex" || var_0 == "cp_dntsk_raid") {
    return 1;
  }

  return 0;
}

is_season_live(var_0) {
  if(!isDefined(var_0) || !isint(var_0)) {
    return 0;
  }

  var_1 = getdvarint("#x3d5ad519f8233dcbd", 0);
  var_2 = 0;

  switch (var_0) {
    case 1:
      if(var_1 >= 11000) {
        var_2 = 1;
      }

      break;
    case 2:
      if(var_1 >= 21000) {
        var_2 = 1;
      }

      break;
    case 3:
      if(var_1 >= 31000) {
        var_2 = 1;
      }

      break;
    case 4:
      if(var_1 >= 41000) {
        var_2 = 1;
      }

      break;
    case 5:
      if(var_1 >= 51000) {
        var_2 = 1;
      }

      break;
    case 6:
      if(var_1 >= 61000) {
        var_2 = 1;
      }

      break;
  }

  return var_2;
}

_id_8A37() {
  if(!isDefined(level._id_DD51)) {
    level._id_DD51 = getdvarint("#x39d01ff793b8b9e26", 0) == 0;
  }

  return level._id_DD51;
}

onlinestatsenabled() {
  if(!isPlayer(self)) {
    return 0;
  }

  return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

privatematch() {
  return level.onlinegame && getdvarint("#x310c28bb5d64c8c6d");
}

_id_69FB(var_0, var_1) {
  var_2 = 0;
  var_3 = _id_6A01(var_0);

  foreach(var_5 in var_3) {
    var_2 = var_2 + _id_6DC9(var_5, istrue(var_1));
  }

  return var_2;
}

_id_6DC9(var_0, var_1) {
  if(istrue(var_1)) {
    return level._id_EF6A[var_0]["alivePlayers"].size;
  } else {
    return level._id_EF6A[var_0]["players"].size;
  }
}

_id_69FD(var_0, var_1) {
  var_2 = [];
  var_3 = _id_6A01(var_0);

  foreach(var_5 in var_3) {
    if(istrue(var_1)) {
      foreach(var_7 in level._id_EF6A[var_5]["alivePlayers"]) {
        if(isDefined(var_7) && isalive(var_7) && !isDefined(var_7._id_59E0)) {
          var_2[var_2.size] = var_7;
        }
      }

      continue;
    }

    foreach(var_7 in level._id_EF6A[var_5]["players"]) {
      var_2[var_2.size] = var_7;
    }
  }

  return var_2;
}

_id_B28F(var_0, var_1) {
  var_2 = level.players;

  if(isDefined(var_1)) {
    if(!_func_0107(var_1)) {
      var_2 = [var_1];
    } else {
      var_2 = var_1;
    }
  }

  foreach(var_4 in var_2) {
    var_4 setplayermusicstate(var_0);
  }
}

_id_10A27(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("dropped_hostage");
  self endon("stop_hostagecarrier_watching_for_doors");
  var_1 = self;
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 64);
  var_2 = 1.5;
  var_3 = ["scriptable_door_wooden_panel_mp_01", "scriptable_door_wooden_hollow_mp_01"];

  for(;;) {
    var_4 = [];
    var_5 = _func_03C0(undefined, undefined, var_1.origin, var_0);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(var_5[var_6] _meth_872A()) {
        var_4[var_4.size] = var_5[var_6];
      }
    }

    for(var_7 = 0; var_7 < var_4.size; var_7++) {
      var_4[var_7] setscriptablepartstate("door", "left_30", 0);
    }

    wait(var_2);
  }
}

_id_6600() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 _id_8708()) {
      var_0++;
    }
  }

  return var_0;
}

_id_459B(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  return var_0;
}

_id_6873(var_0) {
  level._id_1105D = _id_459B(level._id_1105D, []);
  return level._id_1105D[var_0];
}

_id_D458(var_0, var_1, var_2, var_3) {
  var_3 = _id_459B(var_3, 0);
  level._id_1105D = _id_459B(level._id_1105D, []);
  var_1 = _id_459B(var_1, var_2);

  if(var_3) {
    foreach(var_6, var_5 in level._id_EFA0) {
      level._id_1105D[var_6] = _id_459B(level._id_1105D[var_6], []);
      level._id_1105D[var_6][var_0] = var_1;
    }
  } else
    level._id_1105D[var_0] = var_1;

  return var_1;
}

_id_D45A(var_0, var_1, var_2) {
  level._id_1105D = _id_459B(level._id_1105D, []);
  level._id_1105D[var_1] = _id_459B(level._id_1105D[var_1], []);
  level._id_1105D[var_1][var_0] = var_2;
  return var_2;
}

_id_6875(var_0, var_1) {
  if(isDefined(level._id_1105D[var_1])) {
    return scripts\engine\utility::ter_op(isDefined(level._id_1105D[var_1][var_0]), level._id_1105D[var_1][var_0], 0);
  }
}

_id_D459(var_0, var_1) {
  self._id_1105D = _id_459B(self._id_1105D, []);
  self._id_1105D[var_0] = var_1;
}

_id_6874(var_0) {
  self._id_1105D = _id_459B(self._id_1105D, []);
  return self._id_1105D[var_0];
}

_id_A2B8(var_0) {
  return float(var_0) / 1000.0;
}

_id_CFF0(var_0) {
  return int(var_0 * 1000.0);
}

_id_63ED(var_0) {
  var_1 = [];
  var_1 = _id_6C5C();

  if(var_1.size) {
    if(var_1.size > 1 && isDefined(var_0)) {
      return scripts\engine\utility::_id_6969(var_0, var_1);
    } else {
      return var_1[0];
    }
  }
}

_id_6C5C(var_0) {
  return level.players;
}

_id_FF2A(var_0, var_1) {
  return scripts\engine\utility::ter_op(isDefined(var_0), var_0, var_1);
}

_id_3A27(var_0) {
  var_0 = _id_459B(var_0, 51);
  return randomintrange(1, 101) <= var_0 + 1;
}

_id_88B7(var_0, var_1) {
  if(var_0.size > 0) {
    foreach(var_3 in var_0) {
      if(var_3 == var_1) {
        return 1;
      }
    }
  }

  return 0;
}

_id_1B8C(var_0, var_1) {
  var_0 = _id_459B(var_0, []);

  if(!_id_88B7(var_0, var_1)) {
    var_0[var_0.size] = var_1;
  }

  return var_0;
}

_id_E190(var_0, var_1, var_2, var_3, var_4) {
  var_1 = _id_459B(var_1, (0, 0, 0));
  var_2 = _id_459B(var_2, (0, 0, 0));
  var_3 = _id_459B(var_3, 0);
  var_4 = _id_459B(var_4, 0);

  for(;;) {
    var_5 = spawn("script_model", var_1, var_3);

    if(isDefined(var_5)) {
      break;
    } else {}

    waitframe();
  }

  if(_func_0121(var_0)) {
    var_5 setModel(var_0);
  }

  var_5.angles = var_2;
  return var_5;
}

_id_10839(var_0) {
  var_0 = _id_459B(var_0, 1);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    waitframe();
  }
}

_id_EA7B(var_0, var_1) {
  var_0 = _id_459B(var_0, (0, 0, 0));
  var_1 = _id_459B(var_1, (0, 0, 0));
  var_2 = _id_000C::_id_012A();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

_id_5C0E(var_0) {
  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::_id_5C00(var_2)) {
      return 0;
    }
  }

  return 1;
}

_id_5C09(var_0, var_1, var_2) {
  thread _id_0BE8(var_0, var_1, var_2);
}

_id_0BE8(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  self endon("death");
  wait(var_0);
  scripts\engine\utility::_id_5C1B(var_1);
}

_id_78FB() {
  foreach(var_1 in _id_6C5C()) {
    self hidefromplayer(var_1);
  }
}

_id_DCF6() {
  foreach(var_1 in _id_6C5C()) {
    self showtoplayer(var_1);
  }
}

_id_8677(var_0, var_1, var_2, var_3, var_4) {
  var_1 = _id_459B(var_1, 0);
  var_2 = _id_459B(var_2, 0);
  var_3 = _id_459B(var_3, 1);
  var_4 = _id_459B(var_4, 1);

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isent(var_0)) {
    return 0;
  }

  if(!isPlayer(var_0)) {
    return 0;
  }

  if(!isalive(var_0)) {
    return 0;
  }

  if(istrue(var_0._id_872A)) {
    return 0;
  }

  if(var_0.sessionstate == "spectator" || var_0.sessionstate == "intermission") {
    return 0;
  }

  if(istrue(level._id_023E)) {
    return 0;
  }

  if(!var_2) {
    if(_id_073B::_id_B4EF(var_0)) {
      return 0;
    }
  }

  if(var_1) {
    if(var_0.ignoreme || istrue(var_0._id_02FA)) {
      return 0;
    }
  }

  if(isDefined(level._id_8678)) {
    return [[level._id_8678]](var_0);
  }

  return 1;
}

wait_network_frame(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = _func_0497();
    var_3 = undefined;

    for(var_4 = 0; !isDefined(var_3) && var_4 < 5; var_4++) {
      waitframe();
      var_3 = _func_0498(var_2);
    }
  }
}

is_player_valid_target(var_0) {
  return isDefined(var_0) && isalive(var_0);
}