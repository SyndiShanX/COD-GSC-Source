/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2569.gsc
*************************************************/

_id_5573() {
  level._id_1491 = [];
  scripts\common\interactive::_id_8397(::_id_5585, "equip_equipmentResupplyBox");
  _id_0A97::_id_C28A(::_id_5581);
  level._effect["vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx"] = loadfx("vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx");
}

_id_5581(var_0) {
  foreach(var_2 in level._id_1491) {
    if(isDefined(var_2)) {
      var_2 _id_557F(var_0);
    }
  }
}

_id_5584(var_0) {
  var_0 endon("death");
  var_0 thread _id_5587();
  var_0 thread _id_5572();

  if(!istrue(var_0._id_9926)) {
    var_0 _id_5574();
  }

  var_0._id_99E6 = undefined;
  var_0 waittill("missile_stuck", var_1);
  var_0 _id_5571(var_1);

  if(1) {
    thread scripts\mp\weapons::_id_ACD8(var_0);
  }

  var_0._id_8A74 = 1;
  var_0._id_EB31 = level._id_EB2B._id_E76D["super_equipment_resupply_drop"]._id_7C8C;
  scripts\mp\weapons::_id_AACF(var_0, "equip_equipmentResupplyBox", ::_id_5566);
  var_0 thread _id_07CD::_id_C33E(::_id_5568, 1, 1);
  level._id_1491[var_0 getentitynumber()] = var_0;
  var_0 _id_078D::_id_D15E(::_id_5567);
  var_0 setscriptablepartstate("visibility", "show", 0);
  wait 0.0;

  if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_0 _id_5563();
  }

  wait 0.75;
  var_0 setscriptablepartstate("effects", "plant", 0);
  var_0 setscriptablepartstate("anims", "open", 0);
  var_0 thread _id_5576();
  wait(_id_556B());
  var_0 setscriptablepartstate("beacon", "active", 0);
  var_0 setscriptablepartstate("anims", "openIdle", 0);
}

_id_5572(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_1 = getdvarfloat("#x350b057009cb883fe", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait(var_1);
  self._id_9926 = 1;
  _id_5574();
  self setscriptablepartstate("visibility", "show", 0);
}

_id_557E() {
  if(0) {
    foreach(var_1 in self._id_B1CF) {
      if(var_1._id_5562 == "equip_equipmentResupplyBox") {
        var_1 thread _id_5566();
        scripts\mp\weapons::_id_C498(var_1);
      }
    }
  }
}

_id_5568(var_0, var_1) {
  if(isDefined(var_0) || isDefined(self.owner)) {
    self _meth_85AE();

    if(isDefined(var_0)) {
      self setentityowner(var_0);
    } else {
      self setentityowner(self.owner);
    }
  }

  self setscriptablepartstate("effects", "explode", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
  thread _id_5565(0.1, var_1);
}

_id_5566(var_0) {
  if(!isDefined(var_0)) {
    var_0 = !istrue(self._id_B1C9);
  }

  var_1 = undefined;
  var_2 = 0;

  if(!var_0) {
    var_1 = _id_556A();
    var_2 = var_1 + 1;
  }

  thread _id_5565(var_2);

  if(isDefined(self)) {
    var_3 = self.origin;
    var_4 = anglesToForward(self.angles);
    var_5 = anglestoup(self.angles);
    self setscriptablepartstate("beacon", "neutral", 0);
    self setscriptablepartstate("hacked", "neutral", 0);

    if(!var_0) {
      self setscriptablepartstate("anims", "close", 0);
      wait(var_1);
      self setscriptablepartstate("anims", "closedIdle", 0);
      wait 1;
    }

    playFX(scripts\engine\utility::getfx("vfx/iw8_mp/equipment/vfx_offhand_wm_supportbox_timeout.vfx"), var_3, var_4, var_5);
  }
}

_id_5565(var_0, var_1) {
  self notify("death");
  self._id_87FB = 1;
  self setCanDamage(0);

  if(isDefined(self.owner)) {
    self.owner scripts\mp\weapons::_id_C498(self);
  }

  _id_557C();
  _id_5575();
  self._id_B7BC = undefined;
  self.owner _id_07BC::_id_AAE7("super_ammo_drop", self._id_FE46);
  _id_07A9::_id_9768(self.owner, self._id_EB31, self._id_FE46, istrue(var_1));
  wait(var_0);
  self delete();
}

_id_5576() {
  scripts\common\interactive::_id_8398("equip_equipmentResupplyBox");
  self._id_B7E9 = [];
  self._id_FE46 = 0;
  self makeuseable();
  self _meth_83A1(-1);
  self enablemissilehint(1);
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"EQUIPMENT_HINTS/EQUIPMENT_RESUPPLY_BOX_USE");
  self setuserange(128);
  self setuseholdduration("duration_short");
  self sethintrequiresholding(0);
  self _meth_84D7("tag_use");
  thread _id_5586();
}

_id_5575() {
  self notify("equipmentResupplyBox_makeUnusable");
  scripts\common\interactive::_id_839F();
  self makeunusable();
  self._id_B7E9 = undefined;
}

_id_5586() {
  self endon("death");
  self endon("equipmentResupplyBox_makeUnusable");
  var_0 = gettime();

  for(;;) {
    _id_5582();

    if(gettime() >= var_0) {
      _id_5583();
      var_0 = gettime() + 150;
    }

    waitframe();
  }
}

_id_5583() {
  var_0 = scripts\common\utility::_id_B7C7(self.origin, 300);

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      if(!_id_557A(var_2)) {
        self disableplayeruse(var_2);
        continue;
      }

      self _meth_80E0(var_2);
    }
  }
}

_id_5582() {
  foreach(var_1 in self._id_B7E9) {
    if(isDefined(var_1)) {
      var_2 = var_1 getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(var_1) && isDefined(self._id_B7E9[var_2])) {
        self._id_B7E9[var_2] = undefined;
        _id_557F(var_1);
      }
    }
  }
}

_id_557A(var_0) {
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

_id_5578(var_0) {
  var_1 = var_0 scripts\mp\equipment::_id_69A4("primary");

  if(isDefined(var_1)) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_1);
  }

  var_2 = var_0 scripts\mp\equipment::_id_69A4("secondary");

  if(isDefined(var_2)) {
    var_0 scripts\mp\equipment::incrementequipmentammo(var_2);
  }

  var_3 = var_0 getweaponslistprimaries();

  foreach(var_5 in var_3) {
    if(scripts\mp\utility\weapon::_id_88F9(var_5) || scripts\mp\utility\weapon::_id_8A7D(var_5) || scripts\mp\utility\weapon::_id_88F6(var_5) || scripts\mp\utility\weapon::_id_8876(var_5) || scripts\mp\utility\weapon::_id_8929(var_5)) {
      continue;
    }
    var_6 = scripts\mp\utility\weapon::getweapongroup(var_5);
    var_7 = undefined;

    if(scripts\mp\utility\weapon::_id_8A38(var_5)) {
      var_7 = 1;
    } else if(var_6 == "weapon_sniper") {
      var_7 = 1.5;
    } else {
      var_7 = 2;
    }

    var_8 = undefined;

    if(isDefined(var_5.classname) && var_5.classname == "rocketlauncher" || var_6 == "weapon_sniper") {
      var_8 = scripts\mp\weapons::_id_68BB(var_5) * var_7;
    } else {
      var_8 = max(scripts\mp\weapons::_id_68BB(var_5) * var_7, 90);
    }

    if(var_5._id_0245 && scripts\mp\utility\weapon::_id_1DA5(var_5._id_04B7) == "ubshtgn") {
      var_9 = var_0 getweaponammoclip(var_5);
      var_10 = int(var_9 + var_8);
      var_0 setweaponammoclip(var_5, var_10);
      continue;
    }

    var_11 = var_0 getweaponammostock(var_5);
    var_10 = int(var_11 + var_8);
    var_0 setweaponammostock(var_5, var_10);
  }

  var_0 _id_07C4::_id_7B6B("ammobox");
  _id_557B(var_0);
  thread _id_5579();
  var_0 thread _id_07BC::createfieldupgradechallengeevent("use_resupplyBox");
  return 1;
}

_id_557B(var_0) {
  if(isDefined(var_0)) {
    var_0 playlocalsound("mp_fldupgrds_supply_box_resupply_plr");
    level thread scripts\mp\battlechatter_mp::_id_F759(var_0, "supplybox_resupply");
  }
}

_id_5579() {
  self endon("death");

  if(istrue(self._id_ABCC)) {
    return;
  }
  self setscriptablepartstate("anims", "openUse", 0);
  self._id_ABCC = 1;
  wait(_id_556C());
  self setscriptablepartstate("anims", "openIdle", 0);
  self._id_ABCC = undefined;
}

_id_5574() {
  thread _id_07C3::_id_A0FF(100, "hitequip", ::_id_5570, ::_id_556F);
}

_id_556F(var_0) {
  if(var_0._id_9CD6 == "MOD_IMPACT") {
    return 0;
  }

  var_1 = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0.attacker);
  var_2 = undefined;

  if(_func_010F(var_0._id_9CD6)) {
    var_2 = _id_5569(var_0, var_1);
  } else if(scripts\engine\utility::_id_8794(var_0._id_9CD6)) {
    var_2 = _id_5564(var_0, var_1);
  }

  if(isDefined(var_2)) {
    var_3 = 5;

    if(var_1) {
      var_3 = 5;
    }

    return int(_func_0037(min(1, var_2 / 5) * self.maxhealth));
  }

  return var_0.damage;
}

_id_5570(var_0) {
  _id_556D(var_0.attacker);

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0.attacker))) {
    self.owner thread _id_0A8D::_id_9137("sb_destroyed_s");
  }

  thread _id_5568(var_0.attacker, 1);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0.objweapon), var_0.objweapon, "");

  if(var_0.attacker.team != self.team && isDefined(self._id_014E) && self._id_014E >= self.maxhealth) {
    var_0.attacker thread _id_07BC::createfieldupgradechallengeevent("destroy", var_1);
  }
}

_id_5564(var_0, var_1) {
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

_id_5569(var_0, var_1) {
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

_id_557D() {
  if(isDefined(self._id_ACE5)) {
    scripts\mp\utility\outline::outlinedisable(self._id_ACE5, self);
  }
}

_id_5563() {
  self._id_75EC = _id_078F::_id_D59B([], "v_ui_icon_fieldupgrade_fieldupgrade01", 20, 1, 1000, 100, undefined, 1);
  self._id_75F0 = _id_078F::_id_D594(0, 20, undefined, undefined, undefined, undefined, 1);
  _id_5580();
}

_id_557C() {
  if(isDefined(self._id_75EC)) {
    _id_078F::_id_D593(self._id_75EC);
    self._id_75EC = undefined;
  }

  if(isDefined(self._id_75F0)) {
    _id_078F::_id_D593(self._id_75F0);
    self._id_75F0 = undefined;
  }
}

_id_556D(var_0) {
  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0)) {
    var_0 notify("destroyed_equipment");
    var_0 thread _id_0A9F::_id_7003("destroyed_equipment");
    var_0 scripts\mp\battlechatter_mp::_id_555B(self);
  }
}

_id_556E(var_0) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0)) {
    if(self.owner != var_0) {
      self.owner thread _id_0A9F::_id_7003("munitions_box_teammate_used");
    }

    self.owner scripts\mp\utility\stats::_id_7DAE("munitionsBoxUsed", 1);
    self.owner scripts\mp\supers::_id_3AC1("super_ammo_drop");
    self._id_FE46++;
  }
}

_id_5577(var_0) {
  _id_5566(1);
}

_id_5571(var_0) {
  var_1 = spawnStruct();
  var_1._id_950E = var_0;
  var_1._id_43F7 = ::_id_5577;
  var_1._id_5338 = "death";
  thread scripts\mp\movers::_id_7403(var_1);
}

_id_5587() {
  self endon("death");
  _id_5588();

  if(isDefined(self) && !istrue(self._id_87FB)) {
    thread _id_5566();
  }
}

_id_5588() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

_id_5567(var_0) {
  var_1 = var_0.attacker;
  _id_556D(var_1);
  thread _id_5566();
}

_id_5580() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      return;
    }
    _id_557F(var_1);
  }
}

_id_557F(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self._id_75EC;

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self._id_75F0;

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\mp\utility\player::_id_886C(self.owner.team, var_0);
  var_4 = isDefined(self._id_B7E9) && isDefined(self._id_B7E9[var_0 getentitynumber()]);

  if(var_3 && !var_4) {
    _id_078F::_id_D590(var_1, var_0);
    _id_078F::_id_D599(var_2, var_0);
  } else if(var_3) {
    _id_078F::_id_D599(var_1, var_0);
    _id_078F::_id_D590(var_2, var_0);
  } else {
    _id_078F::_id_D599(var_1, var_0);
    _id_078F::_id_D599(var_2, var_0);
  }
}

#using_animtree("scriptables");

_id_556B() {
  return _func_0079(%wm_supportbox_ground_open);
}

_id_556C() {
  return _func_0079(%wm_supportbox_ground_idle_open_use);
}

_id_556A() {
  return _func_0079(%wm_supportbox_ground_close);
}

_id_5585(var_0, var_1) {
  if(istrue(var_1._id_88DF)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
    }

    return;
  }

  if(var_0 _id_557A(var_1)) {
    if(isDefined(var_0._id_888A) && isDefined(var_0._id_735F)) {
      var_0 _id_5568(var_0._id_735F, 1);
      return;
    }

    if(isDefined(level._id_ABB4)) {
      var_2 = var_0[[level._id_ABB4]](var_1);
    } else {
      var_2 = var_0 _id_5578(var_1);
    }

    if(var_2) {
      var_0._id_B7E9[var_1 getentitynumber()] = var_1;
      var_0 _id_557F(var_1);
      var_0 _id_556E(var_1);
    }
  }
}

_id_5557(var_0) {
  self._id_888A = 0;
  _id_5575();
  thread _id_5576();
  _id_5580();
}