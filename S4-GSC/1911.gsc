/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1911.gsc
*************************************************/

_id_3E1F() {
  level._id_6885 = ::_id_6885;
  _id_AE6B();
}

_id_AE6B() {
  level._id_147D = [];
  level._id_1099F = [];
  level._id_994A = [];
  level._id_146E = [];
  level._id_3E43 = [];
  level._id_AE0A = [];
  var_0 = 0;

  if(isDefined(level._id_3D21)) {
    var_1 = level._id_3D21;
  } else {
    var_1 = "cp/cp_weapontable.csv";
  }

  for(;;) {
    var_2 = tablelookupbyrow(var_1, var_0, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 1);
    var_4 = tablelookupbyrow(var_1, var_0, 2);
    var_5 = tablelookupbyrow(var_1, var_0, 3);
    var_6 = scripts\cp\utility::_id_6CE3(var_3);
    var_7 = strtok(var_4, " ");
    level._id_147D[var_6] = var_3;

    foreach(var_9 in var_7) {
      switch (var_9) {
        case "craft":
          level._id_3E43[var_6] = var_3;
          break;
        case "magic":
          level._id_994A[var_6] = getweaponbasename(var_3);
          level._id_146E[var_6] = var_3;
          break;
        case "upgrade":
          level._id_AE0A[var_6] = var_3;
          break;
        case "wall":
          _id_3F90(var_2, var_3, var_6, var_9, var_5);
          break;
      }
    }

    var_0++;
  }
}

_id_3F90(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_0 = int(var_0);
  var_5._id_04F6 = var_1;
  var_5._id_BE2E = var_3;
  var_5._id_3D91 = var_4;
  level._id_1099F[var_2] = var_5;
}

_id_8720(var_0) {
  var_1 = scripts\cp\utility::_id_6CE3(var_0);
  return isDefined(level._id_147D[var_1]);
}

_id_6885() {
  return scripts\engine\utility::_id_1BC1(level._id_9EE2);
}

_id_E3C6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_5.basename;

  if(!isDefined(var_12)) {
    return;
  }
  if(self.health - var_2 < 1) {
    if(isDefined(level._id_91DF)) {
      [[level._id_91DF]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }
  }
}

_id_8D31(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon(var_1);
  }

  wait(var_0);
  self suicide();
}

_id_DAE4(var_0) {
  var_1 = 2;

  if(var_0 scripts\cp\utility::_id_7531("perk_machine_more")) {
    var_1 = 3;
  }

  var_2 = var_0 _meth_8191("primary");
  var_3 = 0;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(!scripts\cp\utility::_id_88F6(var_2[var_4])) {
      var_3++;
    }
  }

  return var_3 >= var_1;
}

_id_DCD3() {
  self notify("turn_on_screen_blood_on");
  self endon("turn_on_screen_blood_on");
  self setscriptablepartstate("on_screen_blood", "on");
  scripts\engine\utility::_id_108A8(2, "death", "last_stand");
  self setscriptablepartstate("on_screen_blood", "neutral");
}

_id_10D25() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self._id_1FD6 = 0;
  self._id_A7C6 = 0;
  self._id_5EFF = 0;
  var_0 = self getcurrentprimaryweapon();
  var_1 = var_0 _meth_8625();
  var_2 = self getcurrentweapon();
  var_3 = undefined;

  for(;;) {
    if(isDefined(var_1) && var_1.basename == "iw7_axe_zm" && self._id_1FD6 < 3) {
      scripts\cp\utility::_id_D5E9("msg_axe_hint", &"CP_ZOMBIE/AXE_HINT", 4);
      self._id_1FD6 = self._id_1FD6 + 1;
    } else if(isDefined(var_1) && var_1.basename == "iw7_forgefreeze_zm" && self._id_5EFF < 5) {
      scripts\cp\utility::_id_D5E9("msg_axe_hint", &"CP_ZOMBIE/FORGEFREEZE_HINT", 4);
      self._id_5EFF = self._id_5EFF + 1;
    }

    var_3 = var_2;
    self waittill("weapon_change");
    wait 0.5;
    var_0 = self getcurrentprimaryweapon();
    var_1 = var_0 _meth_8625();
    var_2 = self getcurrentweapon();
  }
}

_id_1FD5() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("axe_melee_hit", var_0, var_1, var_2);
    var_3 = var_0.basename;
    var_4 = scripts\cp\cp_weapon::_id_683D(var_3);
    var_5 = _id_659D(var_3, var_4);
    var_6 = _id_659E(var_3, var_4);
    var_7 = _id_659F(var_3, var_4);
    var_8 = _id_34FB(var_5, var_6, var_7);

    foreach(var_10 in var_8) {
      if(var_10 == var_1) {
        continue;
      }
      var_10 thread _id_1FD4(var_10, self, var_2, var_10.origin, self.origin, var_0, 0.5);
    }
  }
}

_id_D48A(var_0) {
  var_0 setscriptablepartstate("axe - idle", "neutral");
  wait 0.5;
  var_0 setscriptablepartstate("axe - idle", "level 1");
}

_id_D48B(var_0) {
  var_0 notify("setaxeblooddrip");
  var_0 endon("setaxeblooddrip");
  var_0 setscriptablepartstate("axe", "neutral");
  wait 0.5;
  var_0 setscriptablepartstate("axe", "blood on");
  wait 5;
  var_0 setscriptablepartstate("axe", "neutral");
}

_id_659D(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 45;
  }

  switch (var_1) {
    case 2:
      return 52;
    case 3:
      return 60;
    default:
      return 45;
  }
}

_id_659E(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 125;
  }

  switch (var_1) {
    case 2:
      return 150;
    case 3:
      return 175;
    default:
      return 125;
  }
}

_id_659F(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1;
  }

  switch (var_1) {
    case 2:
      return 8;
    case 3:
      return 24;
    default:
      return 4;
  }
}

_id_65A0(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return 1100;
  }

  switch (var_1) {
    case 2:
      return 1500;
    case 3:
      return 2000;
    default:
      return 1100;
  }
}

_id_34FB(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = cos(var_0);
  var_4 = [];
  var_5 = _id_06FE::_id_68A1("axis");
  var_6 = scripts\engine\utility::_id_6369(self.origin, var_5, undefined, 24, var_1, 1);

  foreach(var_8 in var_6) {
    var_9 = anglesToForward(self.angles);
    var_10 = vectornormalize(var_9) * -25;
    var_11 = 0;
    var_12 = var_8.origin;
    var_13 = scripts\engine\utility::_id_10E76(self getEye() + var_10, self.angles, var_12 + (0, 0, 30), var_3);

    if(var_13) {
      if(isDefined(var_1)) {
        var_14 = distance2d(self.origin, var_12);

        if(var_14 < var_1) {
          var_11 = 1;
        }
      } else
        var_11 = 1;
    }

    if(var_11 && var_4.size < var_2) {
      var_4[var_4.size] = var_8;
    }
  }

  return var_4;
}

_id_1FD4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_0._id_0043 = 1;
  var_0 dodamage(var_2, var_3, var_1, var_1, "MOD_MELEE", var_5);
  wait(var_6);

  if(istrue(var_0._id_0043)) {
    var_0._id_0043 = 0;
  }
}

_switchtoweapon(var_0) {
  self switchtoweapon(var_0);
}

_switchtoweaponimmediate(var_0) {
  self switchtoweaponimmediate(var_0);
}

_takeweapon(var_0) {
  var_1 = 0;

  if(isweapon(var_0)) {
    var_1 = self _meth_858A() == var_0;
  } else {
    var_1 = getcompleteweaponname(self _meth_858A()) == var_0;
  }

  if(var_1) {
    self _meth_858D(var_0);
  }

  self takeweapon(var_0);
  thread scripts\cp\utility::_id_3552(var_0);
}

_id_EDDF(var_0) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    if(!_id_87E0(var_0)) {
      break;
    }

    waitframe();
  }

  _takeweapon(var_0);
}

_id_69AA() {
  _id_FF49();
  var_0 = self _meth_858A();

  if(isnullweapon(var_0)) {
    return undefined;
  }

  return var_0;
}

_id_8757() {
  return isDefined(_id_69AA());
}

_id_89F7(var_0) {
  var_1 = _id_69AA();
  return isDefined(var_1) && var_1 == var_0 && !_id_87E0(var_0);
}

_id_31ED(var_0) {
  if(!self hasweapon(var_0)) {
    return 0;
  }

  if(!scripts\common\utility::_id_871C()) {
    return 0;
  }

  if(!scripts\common\utility::_id_8724()) {
    return 0;
  }

  var_1 = _id_69AA();

  if(isDefined(var_1)) {
    var_2 = getweaponbasename(var_0);
    var_3 = 0;

    if(var_2 == "ks_remote_map_cp" || var_2 == "briefcase_bomb_mp" || var_2 == "briefcase_bomb_defuse_mp" || var_2 == "iw7_uplinkball_mp" || var_2 == "iw7_tdefball_mp") {
      var_3 = 1;
    } else if(_func_0276(var_1) == "primary") {
      var_3 = 1;
    }

    if(!var_3) {
      return 0;
    }
  }

  if(_id_87E0(var_0)) {
    return 0;
  }

  return 1;
}

_id_0E0D(var_0) {
  if(self _meth_858A() == var_0) {
    self _meth_858D(var_0);
  }

  _takeweapon(var_0);
  return;
}

_id_EC3F(var_0, var_1) {
  self endon("disconnect");
  self endon("death");

  if(!_id_31ED(var_0)) {
    return 0;
  }

  if(_id_8757()) {
    self _meth_858D(_id_69AA());
  }

  self _meth_858C(var_0);

  if(istrue(var_1)) {
    _switchtoweaponimmediate(var_0);
  }

  for(;;) {
    if(_id_87E0(var_0)) {
      _id_FF49();
      return 1;
    }

    if(!self _meth_858B(var_0) || !self hasweapon(var_0)) {
      return 0;
    }

    if(!scripts\common\utility::_id_871C() || !scripts\common\utility::_id_8724()) {
      self _meth_858D(var_0);
      return 0;
    }

    waitframe();
  }
}

_id_FF49() {
  var_0 = self getcurrentweapon();

  if(self _meth_858B(var_0)) {
    self _meth_858D(var_0);
  }
}

_id_6CF7(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(!self hasweapon(var_0)) {
    return;
  }
  if(!_id_87E0(var_0)) {
    _takeweapon(var_0);
    return;
  }

  while(_id_8757()) {
    waitframe();
  }

  if(!_id_87E0(var_0)) {
    _takeweapon(var_0);
    return;
  }

  if(isbot(self)) {
    var_1 = 1;
  }

  var_2 = _id_EC3F(self._id_8FC2, var_1);
  _takeweapon(var_0);
  self notify("bomb_allow_offhands");

  if(!var_2) {
    _id_5ED6();
  }
}

_id_5ED6(var_0) {
  self endon("death");
  self endon("disconnect");

  while(isnullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || _id_8757()) {
      waitframe();
      continue;
    }

    var_1 = var_0;

    if(!isDefined(var_1) || !self hasweapon(var_1)) {
      if(!isDefined(self._id_8FC2) || self._id_8FC2.basename == "none") {
        break;
      }

      var_1 = self._id_8FC2;
    }

    var_2 = _id_69A9();

    if(isDefined(var_1) && getweaponbasename(var_1) == "iw7_axe_mp" && self getweaponammoclip(var_1) == 0 && var_2.size == 1) {
      var_1.basename = "iw8_fists_mp";
    }

    _id_EC3F(var_1);
    waitframe();
  }
}

_id_87E0(var_0) {
  if(_func_0121(var_0)) {
    var_0 = makeweaponfromstring(var_0);
  }

  return issameweapon(self getcurrentweapon(), var_0, 1);
}

_id_450A(var_0) {}

_id_69A9() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(!var_3._id_0245) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

_id_EC3C() {
  if(!isai(self)) {
    var_0 = scripts\cp\utility::_id_6AF9();

    if(!self hasweapon(var_0)) {
      var_0 = scripts\cp\utility::_id_6A3F();
    }

    _switchtoweapon(var_0);
  } else
    _switchtoweapon("none");
}

_id_10B26(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("finished_with_manual_weapon_" + var_0);

  if(self hasweapon(var_0)) {
    _id_6CF7(var_0);
    self takeweapon(var_0);
  }
}

_id_E6AA(var_0) {
  self endon("disconnect");
  var_1 = scripts\engine\utility::_id_108A7(var_0, "cancel_remote_sequence");

  if(!isDefined(var_1) || var_1 == "cancel_remote_sequence") {
    return;
  }
  self playlocalsound("mp_killstreak_transition_whoosh");
  self _meth_844E("bw", 0.5);
  var_1 = scripts\engine\utility::_id_108A7(0.5, "death");

  if(!isDefined(var_1) || var_1 == "death") {
    self _meth_83EF("mp_killstreak_transition_whoosh");
  }

  self _meth_844E("", 0.05);
}

_id_F946() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  scripts\cp\utility::_freezecontrols(0);
}

_id_3512() {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  waitframe();

  if(isDefined(self._id_62F1) && self _meth_84B7(self._id_62F1)) {
    self _meth_8494(self._id_62F1, 0.05, 1);
  }
}

_id_523B(var_0, var_1) {
  if(!isDefined(self._id_2D80)) {
    self._id_2D80 = 0;
  }

  if(self._id_2D80 == 0) {
    if(!istrue(var_0)) {
      thread _id_523D();
    }

    thread _id_E686(var_1);
  }

  self._id_2D80++;
}

_id_523D() {
  if(!isDefined(self._id_2D94)) {
    self._id_2D94 = 0;
  }

  if(!isDefined(self._id_2D93)) {
    self._id_2D93 = spawn("script_origin", self.origin);
    self._id_2D93 linkto(self);
    self._id_2D93 _id_078E::_id_C2B6(1);
    wait 0.05;
  }

  if(self._id_2D94 == 0) {
    self._id_2D93 playLoopSound("weap_molotov_fire_enemy_burn");
    self._id_2D94 = 1;
  }
}

_id_523C(var_0) {
  self endon("disconnect");
  self endon("clearBurnFX");
  thread _id_523B();
  wait(var_0);
  thread _id_4A84();
}

_id_4A84(var_0) {
  if(self._id_2D80 == 1) {
    thread _id_E8FE();

    if(!istrue(var_0)) {
      thread _id_49E3();
    }
  }

  self._id_2D80--;
}

_id_49E3() {
  if(!isDefined(self._id_2D94)) {
    self._id_2D94 = 0;
  }

  wait 0.5;

  if(self._id_2D94 == 1) {
    self playSound("weap_molotov_fire_enemy_burn_end");

    if(isDefined(self._id_2D93)) {
      self._id_2D93 _id_078E::_id_4807();
      wait 0.15;

      if(isDefined(self._id_2D93)) {
        self._id_2D93 stoploopsound("weap_molotov_fire_enemy_burn");
        self._id_2D93 delete();
      }
    }

    self._id_2D94 = 0;
  }
}

_id_EBC6(var_0) {
  if(!isDefined(self._id_2D83)) {
    self._id_2D84 = 0;
  }

  if(var_0) {
    self._id_2D83++;
  } else {
    self._id_2D83--;
  }
}

_id_3927() {
  thread _id_E8FE();
  self._id_2D80 = undefined;
  self._id_2D83 = undefined;
  self._id_2D81 = undefined;
}

_id_E686(var_0) {
  self endon("disconnect");
  self endon("stopBurnFX");
  var_1 = "active";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  for(;;) {
    var_2 = isDefined(self._id_2D83) && self._id_2D83 > 0;
    var_3 = istrue(self._id_2D81);

    if(var_2 && var_3) {
      self setscriptablepartstate("burning", "neutral");
      self._id_2D81 = undefined;
    } else if(!var_2 && !var_3) {
      self setscriptablepartstate("burning", var_1);
      self._id_2D81 = 1;
    }

    waitframe();
  }
}

_id_E8FE() {
  self notify("stopBurnFX");

  if(istrue(self._id_2D81)) {
    self setscriptablepartstate("burning", "neutral");
    self._id_2D81 = undefined;
  }
}

_id_2D7F(var_0) {
  var_0 setscriptablepartstate("burning", "flareUp", 0);
}

_id_8905(var_0, var_1, var_2) {
  if(var_0.type != "projectile") {
    return 0;
  }

  if(istrue(var_2) && var_0._id_0245 && isDefined(var_0._id_04B7)) {
    return 0;
  }

  return var_1 == "MOD_IMPACT" || var_1 == "MOD_PROJECTILE" || var_1 == "MOD_GRENADE";
}

_id_8A9F(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    if(isnullweapon(var_0)) {
      return 0;
    }

    var_1 = var_0.basename;
  } else {
    if(var_0 == "none") {
      return 0;
    }

    var_1 = var_0;
  }

  return issubstr(var_1, "throwingknife");
}

_id_5006() {
  var_0 = self getcurrentweapon();

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0.basename == "none") {
    return;
  }
  if(!self hasweapon(var_0)) {
    return;
  }
  var_0 = var_0 _meth_8628();
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(!scripts\cp\utility::_id_8A09(var_0.basename)) {
    if(!self _meth_801D(var_0)) {
      return;
    }
    var_1 = self getweaponammoclip(var_0, "right");
    var_2 = self getweaponammoclip(var_0, "left");

    if(!var_1 && !var_2) {
      return;
    }
    var_3 = self getweaponammostock(var_0);
    var_4 = weaponmaxammo(var_0);

    if(var_3 > var_4) {
      var_3 = var_4;
    }

    var_5 = self dropitem(var_0);

    if(!isDefined(var_5)) {
      return;
    }
    if(istrue(level._id_3985)) {
      var_3 = 0;
    }

    var_5 _meth_81F6(var_1, var_3, var_2);
  } else {
    var_5 = self dropitem(var_0);

    if(!isDefined(var_5)) {
      return;
    }
    var_5 _meth_81F6(1, 1, 0);
  }

  var_5.owner = self;
  var_5._id_0481 = "dropped_weapon";
  var_5.objweapon = var_0;
  var_5 _meth_84D4(96);
  var_5 setuserange(96);
  var_5 thread scripts\cp\cp_weapon::_id_10C2F();
  var_5 thread _id_470F();
  return var_5;
}

_id_470F() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}