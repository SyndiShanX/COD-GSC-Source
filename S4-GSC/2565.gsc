/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2565.gsc
*************************************************/

_id_381A() {
  level._effect["claymore_explode"] = loadfx("vfx/iw8/weap/_explo/claymore/vfx_explo_claymore.vfx");

  if(istrue(game["isLaunchChunk"])) {
    return;
  }
  var_0 = _id_09E2::_id_10143("equip_claymore", 1);
  var_0._id_F612 = ::_id_3821;
}

_id_3823(var_0) {
  self endon("death_or_disconnect");
  var_0 endon("death");

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var_0._id_75A8 = 1;
  }

  var_0._id_57CE = 1;
  thread scripts\mp\weapons::_id_A106(self, var_0);
  var_1 = spawnStruct();
  var_1._id_F1D0 = 100;
  var_1._id_F1D1 = -50;
  var_1._id_330E = 3;
  var_1._id_3314 = 0.5;
  var_1._id_330C = 1;
  var_1._id_B1D3 = 0.5;
  var_1._id_B1D2 = 15;
  var_1._id_B1D4 = 12;
  var_1._id_B1D1 = 20;
  var_1._id_B1D5 = 45;
  var_1._id_B1D6 = 0.342;
  var_1._id_B1D8 = 3;
  var_2 = _id_0A91::_id_B198(var_0, var_1);

  if(!istrue(var_2)) {
    scripts\mp\hud_message::_id_DCA2("EQUIPMENT/PLANT_FAILED");
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    var_0 delete();
  } else {
    var_3 = var_0 _meth_8151();

    if(isDefined(var_3)) {
      var_0 scripts\mp\weapons::_id_57E8(var_3);
    }

    var_0._id_57CE = 0;
    var_0 thread _id_381D();
  }
}

_id_381D() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var_0 = self.owner;
  var_1 = self.owner.team;
  _id_078E::_id_C2B5(1, ::_id_EC13);
  _id_0812::_id_C2B2("Lethal_Static", var_0, 1);
  thread scripts\mp\weapons::_id_99EF("tag_use", 1);
  var_0 scripts\mp\weapons::_id_AACF(self, "equip_claymore", ::_id_3812);
  thread scripts\mp\weapons::_id_A105(var_0, self);
  self _meth_85B9();
  self _meth_85BA();
  self setentityowner(var_0);
  self setotherent(var_0);
  self setnodeploy(1);
  self._id_75F3 = _id_078F::_id_D594(0, 5, undefined, undefined, undefined, 0.1, 1);
  thread scripts\mp\weapons::_id_ACD8(self);
  thread scripts\mp\weapons::_id_9ED2();
  thread _id_3818();
  _id_078D::_id_D15E(::_id_3815);
  _id_3822();
  self setscriptablepartstate("plant", "active", 0);
  var_0 setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  thread _id_3819();
  wait 1;
  self setscriptablepartstate("arm", "active", 0);
  thread _id_3824();
  thread _id_07CD::_id_C33E(::_id_3820, 1, 1);
}

_id_3822() {
  if(istrue(level._id_434D)) {
    return;
  }
  if(isDefined(self._id_4346)) {
    _id_0817::_id_C51F(self._id_4346);
  }

  self._id_4346 = _id_0817::_id_1135(self.origin, _id_0817::_id_69D4(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

_id_3819() {
  self endon("mine_selfdestruct");
  self endon("death");
  var_0 = gettime() + 2000;

  while(var_0 > gettime()) {
    var_1 = (0, self.angles[1], 0);
    var_2 = 15;
    self.angles = _func_0317(var_1, self.angles, var_2);
    waitframe();
  }
}

_id_3824() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var_0 = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water"]);

  for(;;) {
    self waittill("trigger_grenade", var_1);

    if(istrue(self._id_EAAB)) {
      continue;
    }
    foreach(var_3 in var_1) {
      if(isDefined(var_3.classname)) {
        if(var_3.classname == "script_vehicle") {
          if(!_id_09E2::_id_1014C(var_3, self)) {
            continue;
          }
          _id_09E2::_id_10149(var_3, self);
          break;
        }

        if(var_3.classname == "agent" || var_3.classname == "player") {
          if(!isPlayer(var_3) && !isagent(var_3)) {
            continue;
          }
          var_4 = anglesToForward(self.angles);
          var_5 = anglestoup(self.angles);
          var_6 = self.origin + var_5 * 0;
          var_7 = _id_0A91::_id_65A8();
          var_8 = var_3 gettagorigin("j_mainroot");
          var_9 = [var_8];
          var_10 = var_6 - var_8;

          if(vectordot(var_10, (0, 0, 1)) >= 0) {
            var_9[var_9.size] = var_3 gettagorigin("j_spineupper");
          } else {
            var_9[var_9.size] = var_3.origin;
          }

          var_11 = 0;

          foreach(var_13 in var_9) {
            var_10 = var_13 - self.origin;
            var_14 = vectordot(var_10, var_4);

            if(var_14 > 192) {
              continue;
            }
            var_15 = vectordot(var_10, var_5);

            if(abs(var_15) > 32) {
              continue;
            }
            var_16 = vectornormalize(var_10);
            var_17 = vectordot(var_16, var_4);

            if(var_17 < 0.86602) {
              continue;
            }
            var_18 = _func_02C1(var_6, var_13, var_0, var_7, 0, "physicsquery_closest", 1);

            if(isDefined(var_18) && var_18.size > 0) {
              continue;
            }
            var_11 = 1;
            thread _id_3820(var_3);
          }

          if(var_11) {
            break;
          }
        }
      }
    }
  }
}

_id_3820(var_0, var_1) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  } else {
    var_1 = self.owner;
  }

  self notify("mine_triggered");
  scripts\mp\utility\print::_id_BD15("claymore triggered", self.owner);
  scripts\mp\weapons::_id_99EC();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  scripts\mp\weapons::_id_57EC(var_0, 0.3);
  thread _id_3816(var_1);
}

_id_3821(var_0, var_1) {
  var_1 endon("mine_destroyed");
  var_1 endon("death");
  var_1.owner endon("disconnect");
  var_1 notify("mine_triggered");
  var_1 scripts\mp\weapons::_id_99EC();
  var_1 setscriptablepartstate("arm", "neutral", 0);
  var_1 setscriptablepartstate("trigger", "active", 0);
  wait 0.1;
  var_1 thread _id_3817(var_0);
}

_id_3817(var_0) {
  var_0 dodamage(140, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("claymore_mp"));
  var_1 = var_0 _id_0A8B::_id_A5A1(self.owner, makeweapon("claymore_mp"), self, "MOD_EXPLOSIVE");
  thread _id_3816();
  waitframe();

  if(isDefined(var_0)) {
    var_0 _id_0A8B::_id_A5A6(var_1);
  }
}

_id_3816(var_0) {
  level._id_9EE2[self getentitynumber()] = undefined;
  self setCanDamage(0);
  _id_078E::_id_4807();
  scripts\mp\weapons::_id_99EC();

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  self._id_57CE = 1;
  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1 scripts\mp\weapons::_id_C498(self);
  }

  _id_078F::_id_D593(self._id_75F3);
  var_2 = anglestoup(self.angles);
  var_3 = -1 * anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("claymore_explode"), self.origin, var_2, var_4);
  self radiusdamage(self.origin, 75, 100, 100, self.owner, "MOD_EXPLOSIVE", "claymore_radial_mp");
  self detonate(var_0);
}

_id_3818() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);
  self._id_48D0 = var_1;
  thread _id_3816(var_1);
}

_id_EC13() {
  _id_3813();
}

_id_3813(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  thread _id_3812(var_0 + 0.2);
  wait(var_0);
  self setscriptablepartstate("destroy", "active", 0);
}

_id_3815(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FEA(self);
  }

  var_2 = "";

  if(istrue(self._id_75A8)) {
    var_2 = "hitequip";
  }

  if(isPlayer(var_1)) {
    var_1 _id_07C4::_id_FC47(var_2);
  }

  thread _id_3813();
}

_id_3812(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self setscriptablepartstate("hack_usable", "off");
  self notify("death");
  _id_078E::_id_4807();
  level._id_9EE2[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\mp\weapons::_id_99EC();
  _id_078F::_id_D593(self._id_75F3);
  self._id_75F3 = undefined;
  self._id_57CE = 1;

  if(isDefined(self._id_4346)) {
    _id_0817::_id_C51F(self._id_4346);
    self._id_4346 = undefined;
  }

  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1 scripts\mp\weapons::_id_C498(self);
  }

  if(isDefined(var_0)) {
    wait(var_0);
  }

  self delete();
}

_id_381B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    return var_4;
  }

  if(isnullweapon(var_1)) {
    return var_4;
  }

  if(var_1 == makeweapon("claymore_mp")) {
    if(isDefined(self._id_382A)) {
      foreach(var_6 in self._id_382A) {
        if(isDefined(var_6) && var_6 == var_2) {
          return 0;
        }
      }
    }
  } else if(var_1 == makeweapon("claymore_radial_mp")) {
    if(!istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_0, var_2.owner))) {
      return 0;
    }

    thread _id_3811(var_2);
  } else
    return var_4;

  if(!_func_010F(var_3)) {
    return var_4;
  }

  var_8 = var_0.origin - var_2.origin;
  var_9 = vectordot(var_8, anglestoup(var_2.angles));

  if(var_9 > 65) {
    return 0;
  }

  var_8 = var_2.origin - var_0 getEye();
  var_9 = vectordot(var_8, anglestoup(var_2.angles));

  if(var_9 > 65) {
    return 0;
  }

  var_10 = anglesToForward(var_2.angles);
  var_10 = (var_10[0], var_10[1], 0);
  var_11 = var_0.origin - var_2.origin;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectordot(var_10, var_11);

  if(var_12 < 0) {
    return 0;
  }

  var_9 = distance2d(var_2.origin, var_0.origin);
  var_13 = 1 - clamp((var_9 - 75) / 130, 0, 1);
  var_4 = 70 + 70 * var_13;

  if(isDefined(var_2._id_48D0)) {
    var_14 = isDefined(var_2.owner) && var_2._id_48D0 == var_2.owner;
    var_15 = var_2._id_48D0 == var_0;

    if(!var_14 && var_15) {
      var_4 = min(var_4, 80);
    }
  }

  return var_4;
}

_id_3811(var_0) {
  self endon("disconnect");
  self notify("claymore_blockDamageUntilFrameEnd");
  self endon("claymore_blockDamageUntilFrameEnd");

  if(!isDefined(self._id_382A)) {
    self._id_382A = [];
  }

  self._id_382A[self._id_382A.size] = var_0;
  waittillframeend;
  self._id_382A = undefined;
}

_id_381C(var_0) {
  self setscriptablepartstate("hacked", "active", 0);
  _id_3822();
  thread scripts\mp\weapons::_id_A105(self.owner, self);
  thread scripts\mp\weapons::_id_ACD8(self);
}

_id_381E(var_0) {
  self endon("death");

  if(isPlayer(var_0)) {
    var_0 _id_07C4::_id_FC47("hitequip");
  }

  self notify("claymore_stunned");
  self endon("claymore_stunned");
  self setscriptablepartstate("arm", "neutral", 0);
  self._id_EAAB = 1;
  wait 3.0;
  self._id_EAAB = 0;
  self setscriptablepartstate("arm", "active", 0);
}