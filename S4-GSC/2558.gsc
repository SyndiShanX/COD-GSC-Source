/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2558.gsc
*************************************************/

_id_16F6() {
  level._id_147F = [];
  scripts\common\interactive::_id_8397(::_id_170B, "equip_ammo_box");
  _id_0A97::_id_C28A(::_id_1708);
  level._effect["weapon_box_impact"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
  level._effect["vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx"] = loadfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  level._id_1712 = spawnStruct();
  level._id_1712.weapons = [];
  level._id_1712._id_BD34 = [];
  var_0 = scripts\cp_mp\utility\game_utility::isnightmap();
  _id_16DC("weapon_assault", var_0);
  _id_16DC("weapon_assault", var_0);
  _id_16DC("weapon_smg", var_0);
  _id_16DC("weapon_smg", var_0);
  _id_16DC("weapon_lmg", var_0);
  _id_16DC("weapon_lmg", var_0);
  _id_16DC("weapon_sniper", var_0);
  _id_16DC("weapon_shotgun", var_0);
  _id_16DC("weapon_pistol", var_0);
  var_1 = 0;

  foreach(var_3 in level._id_1712._id_BD34) {
    var_1 = var_1 + var_3;
  }

  level._id_1712._id_F37E = var_1;
}

_id_16DC(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getrandomweaponfromgroup(var_0);
  var_3 = scripts\mp\class::buildweapon(var_2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
  var_4 = randomintrange(2, 8);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = scripts\mp\weapons::getrandomgraverobberattachment(var_3);

    if(!isDefined(var_6)) {
      break;
    }

    var_7 = scripts\mp\weapons::addattachmenttoweapon(var_3, var_6);

    if(isDefined(var_7)) {
      var_3 = var_7;
    }
  }

  if(isDefined(var_3)) {
    _id_16DA(var_3, 10);
  }
}

_id_1708(var_0) {
  foreach(var_2 in level._id_147F) {
    if(isDefined(var_2)) {
      var_2 _id_0A17::_id_EB87(var_0);
    }
  }
}

_id_16DA(var_0, var_1) {
  var_2 = level._id_1712.weapons.size;
  var_3 = getcompleteweaponname(var_0);
  var_4 = "";
  var_5 = strtok(var_3, "+");
  var_4 = var_5[0];

  for(var_6 = 1; var_6 < var_5.size; var_6++) {
    var_7 = var_5[var_6];
    var_8 = strtok(var_7, "|");
    var_4 = var_4 + ("+" + var_8[0]);
  }

  var_9 = makeweaponfromstring(var_4);
  level._id_1712.weapons[var_2] = var_9;
  level._id_1712._id_BD34[var_2] = var_1;
}

_id_1704(var_0) {
  var_0 thread _id_170D();
  self setscriptablepartstate("visibility", "show", 0);

  if(1) {
    thread scripts\mp\weapons::_id_ACD8(var_0);
  }

  var_0._id_8A74 = 1;
  scripts\mp\weapons::_id_AACF(var_0, "equip_ammo_box", ::_id_16E5);
  level._id_147F[var_0 getentitynumber()] = var_0;
  var_0 _id_078D::_id_D15E(::_id_16E6);
  var_0 _id_16F9();

  if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_0 _id_16DB();
  }

  var_0 thread _id_1701();
  var_0 thread _id_16FB();
}

_id_16E5() {
  thread _id_16E4(0, 0);
}

_id_16E4(var_0, var_1) {
  self notify("death");
  self._id_87FB = 1;
  self setCanDamage(0);

  if(isDefined(self.owner)) {
    self.owner scripts\mp\weapons::_id_C498(self);
  }

  _id_1702();
  _id_16FA();
  self.owner _id_07BC::_id_AAE7("super_weapon_drop", self._id_FE46);
  _id_07A9::_id_9768(self.owner, self._id_EB31, self._id_FE46, istrue(var_1));
  self setscriptablepartstate("effects", "destroy", 0);
  var_2 = scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_weapon_drop_destr.vfx");
  var_3 = self.origin;
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoup(self.angles);
  playFX(var_2, var_3, var_4, var_5);
  wait(var_0);
  self delete();
}

_id_1701() {
  var_0 = 60;
  var_1 = 256;
  var_2 = spawn("trigger_radius", self.origin, 0, var_1, var_0);
  _id_16F7(var_2);
  var_2 delete();
}

_id_16F7(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self._id_B7E9[var_1 getentitynumber()])) {
      continue;
    }
    var_2 = _id_16EE(var_1);
    var_3 = [var_2];
    _id_16E1(var_1);
    var_4 = _id_16EC(var_1);

    if(isDefined(var_4)) {
      var_3[var_3.size] = var_4;
    }

    var_1 loadweaponsforplayer(var_3, 1);
  }
}

_id_16FB() {
  scripts\common\interactive::_id_8398("equip_ammo_box");
  self._id_FE46 = 0;
  self._id_B7E9 = [];
  scripts\mp\utility\usability::_id_9A0F(self.team);
  self enablemissilehint(1);
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"EQUIPMENT_HINTS/AMMO_BOX_USE");
  self setuserange(128);
  self setuseholdduration("duration_none");
  self _meth_84D7("tag_hint");
  thread _id_170C();
}

_id_16FA() {
  self notify("supportBox_makeUnusable");
  scripts\common\interactive::_id_839F();
  self makeunusable();
  self._id_B7E9 = undefined;
}

_id_170C() {
  self endon("death");
  self endon("supportBox_makeUnusable");
  var_0 = gettime();

  for(;;) {
    _id_1709();

    if(gettime() >= var_0) {
      _id_170A();
      var_0 = gettime() + 150;
    }

    waitframe();
  }
}

_id_170A() {
  var_0 = scripts\common\utility::_id_B7C7(self.origin, 300);

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      if(!_id_1700(var_2)) {
        self disableplayeruse(var_2);
        continue;
      }

      self _meth_80E0(var_2);
    }
  }
}

_id_1709() {
  foreach(var_1 in self._id_B7E9) {
    if(isDefined(var_1)) {
      var_2 = var_1 getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(var_1) && isDefined(self._id_B7E9[var_2])) {
        self._id_B7E9[var_2] = undefined;
        _id_0A17::_id_EB87(var_1);
      }
    }
  }
}

_id_1700(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(var_0)) {
    return 0;
  }

  if(!var_0 scripts\common\utility::_id_858A()) {
    return 0;
  }

  if(isDefined(self._id_B7E9[var_0 getentitynumber()])) {
    return 0;
  }

  if(scripts\cp_mp\utility\player_utility::_id_B78C(var_0, self.owner)) {
    return 0;
  }

  return 1;
}

_id_16FE(var_0) {
  var_1 = var_0 getcurrentweapon();

  if(isDefined(var_0._id_9F06)) {
    var_1 = var_0._id_9F06;
    var_0 _id_09B8::_id_5036("used_ammo_box", var_0._id_9F2C);
  }

  var_2 = _id_16EE(var_0);
  _id_16E3(var_0);

  if(var_2.basename != "s4_gw_flima35_mp" && var_0._id_90CB.basename != "iw8_cyberemp_mp") {
    var_3 = var_0.primaryweapons.size;

    if(!var_0 hasweapon("iw8_fists_mp") || var_3 > 1) {
      var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    }
  }

  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
  var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_2);

  if(var_0._id_90CB.basename == "iw8_cyberemp_mp") {
    var_4 = var_0._id_8FC2;
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);
  }

  if(var_2.basename == "s4_gw_flima35_mp") {
    var_0 _id_0A50::_id_8C85(var_2, var_1);
    level thread scripts\mp\battlechatter_mp::_id_F759(var_0, "flavor_awesome");
  }

  var_0 playlocalsound("iw8_support_box_use");
  return 1;
}

_id_16ED(var_0) {
  if(!isDefined(var_0._id_2C9A)) {
    var_1 = spawnStruct();
    var_1._id_2C99 = undefined;
    var_1._id_8F03 = undefined;
    var_1._id_1D8D = undefined;
    var_1._id_1DB8 = undefined;
    var_1._id_1DB4 = undefined;
    var_0._id_2C9A = var_1;
  }

  return var_0._id_2C9A;
}

_id_16EE(var_0) {
  var_1 = _id_16ED(var_0);

  if(!isDefined(var_1._id_2C99)) {
    var_2 = 10;
    var_3 = 0;
    var_4 = undefined;

    for(var_5 = var_0 scripts\cp_mp\utility\inventory_utility::_id_69A9(); var_3 < var_2; var_3++) {
      var_4 = _id_16EF();

      if(_id_16F8(var_4, var_1._id_8F03, var_5)) {
        break;
      }
    }

    var_1._id_2C99 = var_4;
  }

  return var_1._id_2C99;
}

_id_16EA(var_0) {
  var_1 = _id_16ED(var_0);

  if(!isDefined(var_1._id_1D8D)) {
    var_2 = var_0 getcurrentprimaryweapon();

    if(!isDefined(var_2)) {
      return undefined;
    }

    if(!_id_16E0(var_2)) {
      return undefined;
    }

    if(!_id_16DF(var_2)) {
      return undefined;
    }

    var_3 = scripts\mp\weapons::getrandomgraverobberattachment(var_2);

    if(!isDefined(var_3)) {
      return undefined;
    }

    var_1._id_1D8D = var_3;
  }

  return var_1._id_1D8D;
}

_id_16EC(var_0) {
  _id_16DD(var_0);
  var_1 = _id_16ED(var_0);
  return var_1._id_1DB8;
}

_id_16EB(var_0) {
  _id_16DD(var_0);
  var_1 = _id_16ED(var_0);
  return var_1._id_1DB4;
}

_id_16DD(var_0) {
  var_1 = _id_16ED(var_0);

  if(!isDefined(var_1._id_1DB8)) {
    var_2 = _id_16EA(var_0);

    if(!isDefined(var_2)) {
      return;
    }
    var_3 = var_0 getcurrentprimaryweapon();
    var_4 = scripts\mp\weapons::addattachmenttoweapon(var_3, var_2);

    if(isDefined(var_4)) {
      var_1._id_1DB4 = var_3;
      var_1._id_1DB8 = var_4;
    }
  }
}

_id_16E3(var_0) {
  var_1 = _id_16ED(var_0);
  var_1._id_8F03 = var_1._id_2C99;
  var_1._id_2C99 = undefined;
}

_id_16E2(var_0) {
  var_1 = _id_16ED(var_0);
  var_1._id_1D8D = undefined;
  var_1._id_1DB8 = undefined;
  var_1._id_1DB4 = undefined;
}

_id_16E1(var_0) {
  var_1 = _id_16EB(var_0);
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_2 = 1;
  } else {
    var_3 = var_0 getcurrentprimaryweapon();

    if(!isDefined(var_3)) {
      var_2 = 1;
    } else {
      var_4 = scripts\mp\utility\weapon::getweaponfullname(var_1);
      var_5 = scripts\mp\utility\weapon::getweaponfullname(var_3);
      var_2 = var_4 != var_5;
    }
  }

  if(var_2) {
    _id_16E2(var_0);
  }
}

_id_16F8(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_0 == var_1) {
    return 0;
  }

  foreach(var_4 in var_2) {
    if(var_4.basename == var_0.basename) {
      return 0;
    }
  }

  return 1;
}

_id_16EF() {
  var_0 = randomint(level._id_1712._id_F37E);
  var_1 = 0;
  var_2 = undefined;

  for(var_3 = 0; var_3 < level._id_1712.weapons.size; var_3++) {
    var_1 = var_1 + level._id_1712._id_BD34[var_3];

    if(var_1 > var_0) {
      return level._id_1712.weapons[var_3];
    }
  }

  return undefined;
}

_id_16FF(var_0) {
  var_1 = var_0 getcurrentweapon();

  if(!_id_16E0(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_INCOMPAT");
    }

    return 0;
  }

  if(!_id_16DF(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");
    }

    return 0;
  }

  var_2 = var_0 _id_16F1(var_1);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/WEAPON_DROP_TOO_MANY_ATTACHMENTS");
    }

    return 0;
  }

  return 1;
}

_id_16E0(var_0) {
  if(!scripts\mp\utility\weapon::_id_8799(var_0) || scripts\mp\utility\weapon::_id_8A38(var_0) || scripts\mp\utility\weapon::_id_88F9(var_0) || _id_080B::_id_8A09(var_0.basename) || var_0.basename == "s4_gw_flima35_mp") {
    return 0;
  }

  return 1;
}

_id_16DF(var_0) {
  var_1 = getweaponattachments(var_0);
  var_2 = scripts\mp\utility\weapon::_id_68DE(var_1);
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(!scripts\mp\utility\weapon::_id_1D9B(var_0, var_5)) {
      continue;
    }
    var_3++;
  }

  return var_3 < 8;
}

_id_16F1(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = _id_16EA(self);
  var_2 = _id_16EC(self);

  if(isDefined(var_2)) {
    _id_16E2(self);
    var_3 = undefined;
    var_4 = undefined;

    if(var_0._id_0245) {
      var_3 = var_0;
      var_0 = var_0 _meth_8628();
      var_4 = scripts\mp\weapons::_id_DC12(var_0);
    } else {
      var_3 = var_0 getaltweapon();
      var_4 = 0;
    }

    var_5 = var_2 getaltweapon();
    var_6 = self getweaponammostock(var_0);
    var_7 = self getweaponammoclip(var_0, "left");
    var_8 = self getweaponammoclip(var_0, "right");
    var_9 = self _meth_810A(var_3);
    var_10 = self getweaponammostock(var_3);
    var_11 = self getweaponammoclip(var_3, "left");
    var_12 = self getweaponammoclip(var_3, "right");
    var_13 = scripts\engine\utility::ter_op(var_4, var_5, var_2);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_13, -1, 0, 0);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_13);
    scripts\mp\weapons::_id_5BFC(self, var_13);
    self setweaponammostock(var_2, var_6);
    self setweaponammoclip(var_2, var_7, "left");
    self setweaponammoclip(var_2, var_8, "right");
    var_14 = self _meth_810A(var_5);

    if(var_9 == var_14) {
      self setweaponammostock(var_5, var_10);
      self setweaponammoclip(var_5, var_11, "left");
      self setweaponammoclip(var_5, var_12, "right");
    }

    wait 0.2;
    self playlocalsound("attachment_pickup");
    var_15 = scripts\mp\utility\weapon::_id_1DA9(var_1, var_2);
    var_16 = getweaponattachments(var_2);
    var_17 = scripts\engine\utility::_id_1BAB(var_16, var_15);

    if(!isDefined(var_17)) {} else {
      var_18 = var_17 + 1;

      if(istrue(self._id_10DBF)) {
        self._id_10DBF = undefined;
        var_18 = var_18 * -1;
      } else
        self._id_10DBF = 1;

      self setclientomnvar("ui_weapon_pickup", var_18);
    }

    return 1;
  }

  return 0;
}

_id_16F9() {
  thread _id_07C3::_id_A0FF(300, "hitequip", ::_id_16F4, ::_id_16F3);
}

_id_16F3(var_0) {
  if(var_0._id_9CD6 == "MOD_IMPACT") {
    return 0;
  }

  var_1 = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0.attacker);
  var_2 = undefined;

  if(_func_010F(var_0._id_9CD6)) {
    var_2 = _id_16E8(var_0, var_1);
  } else if(scripts\engine\utility::_id_8794(var_0._id_9CD6)) {
    var_2 = _id_16DE(var_0, var_1);
  }

  if(isDefined(var_2)) {
    var_3 = 20;
    return int(_func_0037(min(1, var_2 / 20) * self.maxhealth));
  }

  return var_0.damage;
}

_id_16F4(var_0) {
  _id_16F0(var_0.attacker);
  thread _id_16E5();
}

_id_16DE(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(_id_0A8B::_id_8866(var_0.objweapon, var_0._id_9CD6) && var_1, 2, 0);

  if(var_0.damage > 150) {
    return var_2 + 10;
  }

  if(var_0.damage >= 80) {
    return var_2 + 5;
  } else if(var_0.damage >= 30) {
    return var_2 + 2;
  } else {
    return var_2 + 1;
  }
}

_id_16E8(var_0, var_1) {
  if(var_0.damage > 200) {
    return 20;
  }

  if(var_0.damage > 70) {
    return 10;
  } else if(var_0.damage > 30) {
    return 7;
  } else {
    return 2;
  }
}

_id_1703() {
  if(isDefined(self._id_ACE5)) {
    scripts\mp\utility\outline::outlinedisable(self._id_ACE5, self);
  }
}

_id_16DB() {
  self._id_75EC = _id_078F::_id_D59B([], "hud_icon_fieldupgrade_weapon_drop", 20, 1, 1000, 100, undefined, 1);
  self._id_75F0 = _id_078F::_id_D594(0, 20, undefined, undefined, undefined, undefined, 1);
  _id_0A17::_id_EB88();
}

_id_1702() {
  if(isDefined(self._id_75EC)) {
    _id_078F::_id_D593(self._id_75EC);
    self._id_75EC = undefined;
  }

  if(isDefined(self._id_75F0)) {
    _id_078F::_id_D593(self._id_75F0);
    self._id_75F0 = undefined;
  }
}

_id_16F0(var_0) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0)) {
    var_0 notify("destroyed_equipment");
    var_0 thread _id_0A9F::_id_7003("destroyed_equipment");
    var_0 scripts\mp\battlechatter_mp::_id_555B(self);
  }
}

_id_16F2(var_0) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0)) {
    if(self.owner != var_0) {
      self.owner thread _id_0A9F::_id_7003("weapon_drop_teammate_used");
    }
  }
}

_id_16FD(var_0) {
  _id_16E5();
}

_id_16F5(var_0) {
  var_1 = spawnStruct();
  var_1._id_950E = var_0;
  var_1._id_43F7 = ::_id_16FD;
  var_1._id_5338 = "death";
  thread scripts\mp\movers::_id_7403(var_1);
}

_id_170D() {
  self endon("death");
  _id_170E();

  if(isDefined(self) && !istrue(self._id_87FB)) {
    thread _id_16E5();
  }
}

_id_170E() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

_id_16E6(var_0) {
  thread _id_16E5();
}

_id_170B(var_0, var_1) {
  thread _id_1706(var_0, var_1);
}

_id_1706(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_0 endon("death");
  var_2 = gettime();
  var_3 = 1;

  while(gettime() - var_2 < 500) {
    if(!var_1 useButtonPressed()) {
      var_3 = 0;
      break;
    }

    waitframe();
  }

  if(istrue(var_1._id_88DF)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(!var_0 _id_1700(var_1)) {
    return;
  }
  var_4 = undefined;

  if(var_3) {
    var_4 = var_0 _id_16FE(var_1);
  } else {
    var_4 = var_0 _id_16FF(var_1);
  }

  if(var_4) {
    if(isDefined(var_0.owner)) {
      var_0.owner scripts\mp\utility\stats::_id_7DAE("ammoBoxUsed", 1);
      var_0.owner scripts\mp\supers::_id_3AC1("super_weapon_drop");
    }

    var_0._id_FE46++;
    var_0._id_B7E9[var_1 getentitynumber()] = var_1;
    var_0 _id_0A17::_id_EB87(var_1);
    var_0 _id_16F2(var_1);
  }
}