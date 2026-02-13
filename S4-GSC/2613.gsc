/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2613.gsc
*************************************************/

init() {
  level._id_D11F = [];
  level._id_D11F["super_trophy"] = "super_trophy";
  level._id_D11F["sentry_shock"] = "sentry_shock";
  level._id_D11F["manual_turret"] = "manual_turret";
  level._id_D0FA = [];
  level._id_D0FA["super_trophy"] = spawnStruct();
  level._id_D0FA["super_trophy"].health = 999999;
  level._id_D0FA["super_trophy"].maxhealth = 100;
  level._id_D0FA["super_trophy"]._id_D0F8 = "sentry";
  level._id_D0FA["super_trophy"]._id_D0F7 = "sentry_offline";
  level._id_D0FA["super_trophy"].weaponinfo = "sentry_laser_mp";
  level._id_D0FA["super_trophy"].modelbase = "super_trophy_mp";
  level._id_D0FA["super_trophy"]._id_9FD9 = "super_trophy_mp_placement";
  level._id_D0FA["super_trophy"]._id_9FCF = "super_trophy_mp_placement_fail";
  level._id_D0FA["super_trophy"]._id_9FD5 = "super_trophy_mp";
  level._id_D0FA["super_trophy"]._id_0224 = &"SENTRY/PICKUP";
  level._id_D0FA["super_trophy"]._id_75E9 = 1;
  level._id_D0FA["super_trophy"]._id_EFAC = "used_super_trophy";
  level._id_D0FA["super_trophy"]._id_DBE2 = 0;
  level._id_D0FA["super_trophy"]._id_9461 = "tag_fx";
  level._id_D0FA["sentry_shock"] = spawnStruct();
  level._id_D0FA["sentry_shock"].health = 999999;
  level._id_D0FA["sentry_shock"].maxhealth = 670;
  level._id_D0FA["sentry_shock"]._id_2DB2 = 20;
  level._id_D0FA["sentry_shock"]._id_2DB1 = 120;
  level._id_D0FA["sentry_shock"]._id_AF6E = 0.15;
  level._id_D0FA["sentry_shock"]._id_AF6C = 0.35;
  level._id_D0FA["sentry_shock"]._id_D0F8 = "sentry";
  level._id_D0FA["sentry_shock"]._id_D0F7 = "sentry_offline";
  level._id_D0FA["sentry_shock"]._id_F224 = 90.0;
  level._id_D0FA["sentry_shock"]._id_E410 = 0.05;
  level._id_D0FA["sentry_shock"]._id_AD21 = 8.0;
  level._id_D0FA["sentry_shock"]._id_3D0F = 0.1;
  level._id_D0FA["sentry_shock"]._id_609D = 0.3;
  level._id_D0FA["sentry_shock"].streakname = "sentry_shock";
  level._id_D0FA["sentry_shock"].weaponinfo = "sentry_shock_mp";
  level._id_D0FA["sentry_shock"]._id_03A9 = "ks_shock_sentry_mp";
  level._id_D0FA["sentry_shock"].modelbase = "shock_sentry_gun_wm";
  level._id_D0FA["sentry_shock"]._id_9FD9 = "shock_sentry_gun_wm_obj";
  level._id_D0FA["sentry_shock"]._id_9FCF = "shock_sentry_gun_wm_obj_red";
  level._id_D0FA["sentry_shock"]._id_9FD5 = "shock_sentry_gun_wm_destroyed";
  level._id_D0FA["sentry_shock"]._id_0224 = &"SENTRY/PICKUP";
  level._id_D0FA["sentry_shock"]._id_75E9 = 1;
  level._id_D0FA["sentry_shock"]._id_EFAC = "used_shock_sentry";
  level._id_D0FA["sentry_shock"]._id_484B = "callout_destroyed_sentry_shock";
  level._id_D0FA["sentry_shock"]._id_DBE2 = 1;
  level._id_D0FA["sentry_shock"]._id_106B4 = "sentry_shock_timeout";
  level._id_D0FA["sentry_shock"]._id_1068F = "sentry_shock_destroy";
  level._id_D0FA["sentry_shock"]._id_CC16 = "destroyed_sentry";
  level._id_D0FA["sentry_shock"]._id_9461 = "tag_fx";
  level._id_D0FA["sentry_shock"]._id_88E9 = 1;
  level._id_D0FA["sentry_shock"]._id_75F5 = 75;
  level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
  level._effect["sentry_explode_mp"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp_lg.vfx");
  level._effect["sentry_sparks_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/iw7/_requests/mp/vfx_gen_equip_dam_spark_runner.vfx");
  level._effect["sentry_shock_charge"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_charge_up.vfx");
  level._effect["sentry_shock_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_screen");
  level._effect["sentry_shock_base"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_base");
  level._effect["sentry_shock_radius"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_radius");
  level._effect["sentry_shock_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_end.vfx");
  level._effect["sentry_shock_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_proj_trail.vfx");
  level._effect["sentry_shock_arc"] = loadfx("vfx/iw7/_requests/mp/vfx_sentry_shock_arc.vfx");
}

_id_F76B(var_0, var_1) {
  var_2 = _id_6FEF("sentry_minigun");

  if(var_2) {
    scripts\common\utility::_id_F73A(level._id_9BB4, level._id_D0FA["sentry_minigun"].streakname, self.origin);
  }

  return var_2;
}

_id_F79C(var_0, var_1) {
  var_2 = _id_6FEF("sam_turret");

  if(var_2) {
    scripts\common\utility::_id_F73A(level._id_9BB4, level._id_D0FA["sam_turret"].streakname, self.origin);
  }

  return var_2;
}

_id_F79F(var_0) {
  var_1 = _id_6FEF("sentry_shock", undefined, var_0);

  if(var_1) {
    scripts\common\utility::_id_F73A(level._id_9BB4, var_0.streakname, self.origin);
  } else {
    waitframe();
  }

  return var_1;
}

_id_F791(var_0) {
  var_1 = _id_6FEF("manual_turret", undefined, var_0);

  if(var_1) {
    scripts\common\utility::_id_F73A(level._id_9BB4, var_0.streakname, self.origin);
  } else {
    waitframe();
  }

  return var_1;
}

_id_6FEF(var_0, var_1, var_2) {
  self._id_8F56 = var_0;

  if(!isDefined(self._id_B161)) {
    self._id_B161 = [];
  }

  if(!isDefined(self._id_B161[var_0])) {
    self._id_B161[var_0] = [];
  }

  var_3 = 1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = _id_4048(var_0, self, var_3, var_2);

  if(isDefined(var_2)) {
    var_2._id_D0F5 = var_4;
  }

  _id_C4FE();
  self._id_32D2 = var_4;
  var_5 = _id_D4BC(var_4, 1, var_3);
  self._id_32D2 = undefined;
  thread _id_1085C();
  self._id_87A7 = 0;

  if(isDefined(var_4)) {
    return 1;
  } else {
    return 0;
  }
}

_id_D4BC(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  var_0 _id_D0EA(self, var_2, var_3);
  scripts\common\utility::_id_158A(0);
  _id_15E3(0);
  scripts\common\utility::_id_1554(0);

  if(!isai(self)) {
    self notifyonplayercommand("place_sentry", "+attack");
    self notifyonplayercommand("place_sentry", "+attack_akimbo_accessible");
    self notifyonplayercommand("cancel_sentry", "+actionslot 4");

    if(!self _meth_8684()) {
      self notifyonplayercommand("cancel_sentry", "+actionslot 5");
      self notifyonplayercommand("cancel_sentry", "+actionslot 6");
      self notifyonplayercommand("cancel_sentry", "+actionslot 7");
    }
  }

  for(;;) {
    var_4 = scripts\engine\utility::_id_10899("place_sentry", "cancel_sentry", "force_cancel_placement", "emp_applied");

    if(!isDefined(var_0)) {
      _id_15E3(1);
      scripts\common\utility::_id_158A(1);
      thread _id_525D();
      return 1;
    }

    if(var_4 == "cancel_sentry" || var_4 == "force_cancel_placement" || var_4 == "emp_applied") {
      if(!var_1 && (var_4 == "cancel_sentry" || var_4 == "emp_applied")) {
        continue;
      }
      var_0 _id_D0E9(var_4 == "force_cancel_placement" && !isDefined(var_0._id_5BDA));
      return 0;
    }

    if(!var_0._id_314C) {
      continue;
    }
    var_0 _id_D0ED(var_2);
    return 1;
  }
}

_id_525D() {
  self endon("death_or_disconnect");
  wait 0.25;
  scripts\common\utility::_id_1554(1);
}

_id_C541() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self._id_C713 = "iw6_riotshield_mp";
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw6_riotshield_mp");
  }
}

_id_C4FE() {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    self._id_C70D = "specialty_explosivebullets";
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");
  }
}

_id_C715() {
  if(isDefined(self._id_C713)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_C713);
    self._id_C713 = undefined;
  }
}

_id_C70E() {
  if(isDefined(self._id_C70D)) {
    scripts\mp\utility\perk::_id_6FC2(self._id_C70D);
    self._id_C70D = undefined;
  }
}

_id_1085C() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  waitframe();
  _id_C70E();
}

_id_4048(var_0, var_1, var_2, var_3) {
  var_4 = level._id_D0FA[var_0].weaponinfo;
  var_5 = spawnturret("misc_turret", var_1.origin, var_4);
  var_5.angles = var_1.angles;
  var_5.streakinfo = var_3;
  var_5 _id_D0DE(var_0, var_1, var_2);
  var_5 thread _id_D0D4();
  var_5 _id_078D::_id_1538(0);
  var_5 _id_078D::_id_D3BA(::_id_D0D6);
  var_5 _id_078D::_id_D189(::_id_D0D5);
  return var_5;
}

_id_D0DE(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  self._id_D11F = var_0;
  self._id_314C = 1;
  self setModel(level._id_D0FA[var_0].modelbase);
  self setnodeploy(1);

  if(level._id_D0FA[var_0]._id_DBE2) {
    self._id_DBE2 = 1;
  } else {
    self._id_DBE2 = 0;
  }

  self._id_5BDA = 1;
  self setCanDamage(1);

  switch (var_0) {
    case "minigun_turret_2":
    case "minigun_turret_1":
    case "minigun_turret":
    case "gl_turret_1":
    case "gl_turret":
    case "gl_turret_4":
    case "minigun_turret_4":
    case "minigun_turret_3":
    case "gl_turret_3":
    case "gl_turret_2":
      self _meth_8331(80);
      self _meth_8372(80);
      self _meth_82F0(50);
      self setdefaultdroppitch(0.0);
      self._id_AC8F = var_1;
      break;
    case "scramble_turret":
    case "sam_turret":
      self _meth_8224();
      self _meth_8331(180);
      self _meth_8372(180);
      self _meth_8395(80);
      self setdefaultdroppitch(-89.0);
      self._id_8EF7 = 0;
      var_4 = spawn("script_model", self gettagorigin("tag_laser"));
      var_4 linkto(self);
      self.killcament = var_4;
      self.killcament _meth_8375("explosive");
      break;
    case "sentry_shock":
      self _meth_8224();
      var_5 = anglesToForward(self.angles);
      var_6 = self gettagorigin("tag_laser") + (0, 0, 10);
      var_6 = var_6 - var_5 * 20;
      var_4 = spawn("script_model", var_6);
      var_4 linkto(self);
      self.killcament = var_4;
      break;
    case "manual_turret":
      var_5 = anglesToForward(self.angles);
      var_6 = self gettagorigin("tag_laser") + (0, 0, 10);
      var_6 = var_6 - var_5 * 20;
      var_4 = spawn("script_model", var_6);
      var_4 linkto(self);
      self.killcament = var_4;
      break;
    default:
      self _meth_8224();
      self setdefaultdroppitch(-89.0);
      break;
  }

  self _meth_839D(1);
  _id_D0EB();
  _id_D0EC(var_1);

  if(var_3) {
    thread _id_D0F3();
  }

  switch (var_0) {
    case "minigun_turret_2":
    case "minigun_turret_1":
    case "minigun_turret":
    case "minigun_turret_4":
    case "minigun_turret_3":
      self._id_A0B2 = 0;
      self._id_7659 = 0;
      self._id_AD20 = 0;
      thread _id_D0DD();
      break;
    case "gl_turret_1":
    case "gl_turret":
    case "gl_turret_4":
    case "gl_turret_3":
    case "gl_turret_2":
      self._id_A0B2 = 0;
      self._id_7659 = 0;
      self._id_3D10 = 0;
      self._id_AD20 = 0;
      thread _id_F842();
      thread _id_F826();
      break;
    case "scramble_turret":
    case "sentry_shock":
    case "sam_turret":
      self._id_A0B2 = 0;
      thread _id_D0DC(var_2);
      thread _id_D0CF();
      break;
    case "manual_turret":
      self._id_A0B2 = 0;
      thread _id_D0DA();
      thread _id_D0D7(var_2);
      break;
    case "super_trophy":
      thread _id_D0DC(0);
      thread _id_D0CF();
      break;
    default:
      thread _id_D0DC(var_2);
      thread _id_D0CE();
      thread _id_D0CF();
      break;
  }
}

_id_D0EE() {
  var_0 = level._id_D0FA[self._id_D11F]._id_75F5;

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self.owner)) {
    return;
  }
  var_1 = self.owner;
  var_2 = var_1.team;
  self._id_75F3 = thread _id_078F::_id_D594(0, var_0, undefined, undefined, undefined, undefined, 1);
}

_id_D0D2() {
  var_0 = level._id_D0FA[self._id_D11F]._id_75F5;

  if(!isDefined(var_0)) {
    return;
  }
  _id_078F::_id_D593(self._id_75F3);
}

_id_D0D4() {
  self endon("death");
  level scripts\engine\utility::waittill_any_2("bro_shot_start", "game_ended");
  self notify("death");
}

_id_D0D8() {
  self endon("carried");
  var_0 = level._id_D0FA[self._id_D11F].maxhealth;
  var_1 = 0;

  if(self.owner scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var_2 = self.weapon_name;

    if(isDefined(var_2)) {
      switch (var_2) {
        default:
      }
    }
  }

  var_0 = var_0 + int(var_1);
  _id_07C3::_id_A0FF(var_0, "sentry", ::_id_D0F6, ::_id_D0F9, 1);
}

_id_D0F9(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;

  if(var_3 == "MOD_MELEE") {
    var_6 = self.maxhealth * 0.34;
  }

  var_6 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4);
  return var_6;
}

_id_D0F6(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = level._id_D0FA[self._id_D11F];

  if(var_6._id_88E9) {
    var_7 = _id_07C3::_id_AB18(var_6.streakname, var_1, var_2, var_3, var_4, var_6._id_CC16, var_6._id_1068F, var_6._id_484B);

    if(var_7) {
      var_1 notify("destroyed_equipment");
      return;
    }
  } else {
    var_8 = undefined;
    var_9 = var_1;

    if(isDefined(var_9) && isDefined(self.owner)) {
      if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
        var_9 = var_1.owner;
      }

      if(self.owner scripts\mp\utility\player::isenemy(var_9)) {
        var_8 = var_9;
      }
    }

    if(isDefined(var_8)) {
      var_8 thread _id_07CE::_id_EB45(self.owner);
      var_8 notify("destroyed_equipment");
    }

    self notify("death");
  }
}

_id_D0D6(var_0) {
  self._id_4A88 = 1;
  self setdefaultdroppitch(40);
  self setmode(level._id_D0FA[self._id_D11F]._id_D0F7);
  self _meth_8086();
  self setscriptablepartstate("muzzle", "neutral", 0);
  self setscriptablepartstate("stunned", "active");
}

_id_D0D5(var_0) {
  if(var_0) {
    return;
  }
  self setdefaultdroppitch(-89.0);
  self setmode(level._id_D0FA[self._id_D11F]._id_D0F8);
  self setscriptablepartstate("stunned", "neutral");
  self._id_4A88 = undefined;
}

_id_D0D9() {
  self endon("carried");
  self waittill("death");

  if(isDefined(self.owner)) {
    self.owner._id_B161[self._id_D11F] = ::scripts\engine\utility::array_remove(self.owner._id_B161[self._id_D11F], self);
  }

  if(!isDefined(self)) {
    return;
  }
  self _meth_8086();
  self _meth_8202();
  self setModel(level._id_D0FA[self._id_D11F]._id_9FD5);

  if(isDefined(self._id_608A) && self._id_608A.size > 0) {
    foreach(var_1 in self._id_608A) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }

    self._id_608A = undefined;
  }

  _id_D0EB();
  self setdefaultdroppitch(40);
  self setsentryowner(undefined);

  if(isDefined(self._id_84F0)) {
    self _meth_8422(self._id_84F0);
  }

  self _meth_839C(0);

  if(isDefined(self._id_ADB1)) {
    self._id_ADB1 delete();
  }

  switch (self._id_D11F) {
    case "minigun_turret":
    case "gl_turret":
      self._id_5E93 = 1;
      self _meth_8410();
      break;
    default:
      break;
  }

  if(isDefined(self._id_84F0)) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    self._id_84F0._id_F85B scripts\mp\hud_util::destroyelem();
    self._id_84F0 _id_C70E();
    self._id_84F0 _id_C715();
    self notify("deleting");
    wait 1.0;
    stopFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    stopFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  } else {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("destroyed", "sparks");
    wait 5;
    playFX(scripts\engine\utility::getfx("sentry_explode_mp"), self.origin + (0, 0, 10));
    self notify("deleting");
  }

  scripts\mp\weapons::_id_555A();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self._id_13B2)) {
    self._id_13B2 delete();
  }

  if(isDefined(self._id_9A68)) {
    self._id_9A68 delete();
  }

  scripts\mp\utility\print::_id_BD15("killstreak ended - shock_sentry", self.owner);
  self delete();
}

_id_D0DC(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(self._id_D11F == "sam_turret" || self._id_D11F == "scramble_turret") {
      self setmode(level._id_D0FA[self._id_D11F]._id_D0F7);
    }

    var_1._id_B161[self._id_D11F] = ::scripts\engine\utility::array_remove(var_1._id_B161[self._id_D11F], self);
    var_1 _id_D4BC(self, 0, var_0);
  }
}

_id_F840(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");

  if(!isDefined(var_0._id_ADB1)) {
    return;
  }
  var_1 = 0;

  for(;;) {
    if(isalive(self) && self istouching(var_0._id_ADB1) && !isDefined(var_0._id_84F0) && !isDefined(var_0._id_32CA) && self isonground()) {
      if(self usebuttonpressed()) {
        var_1 = 0;

        while(self usebuttonpressed()) {
          var_1 = var_1 + level._id_5F3A;
          waitframe();
        }

        if(var_1 >= 0.5) {
          continue;
        }
        var_1 = 0;

        while(!self usebuttonpressed() && var_1 < 0.5) {
          var_1 = var_1 + level._id_5F3A;
          waitframe();
        }

        if(var_1 >= 0.5) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(self)) {
          continue;
        }
        var_0 setmode(level._id_D0FA[var_0._id_D11F]._id_D0F7);
        thread _id_D4BC(var_0, 0);
        var_0._id_ADB1 delete();
        return;
      }
    }

    waitframe();
  }
}

_id_F841() {
  self notify("turret_handluse");
  self endon("turret_handleuse");
  self endon("deleting");
  level endon("game_ended");
  self._id_5E93 = 0;
  var_0 = (1, 0.9, 0.7);
  var_1 = (1, 0.65, 0);
  var_2 = (1, 0.25, 0);

  for(;;) {
    self waittill("trigger", var_3);

    if(isDefined(self._id_32CA)) {
      continue;
    }
    if(isDefined(self._id_84F0)) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_3)) {
      continue;
    }
    var_3 _id_C4FE();
    var_3 _id_C541();
    self._id_84F0 = var_3;
    self setmode(level._id_D0FA[self._id_D11F]._id_D0F7);
    _id_D0EC(var_3);
    self setmode(level._id_D0FA[self._id_D11F]._id_D0F8);
    var_3 thread _id_F86C(self);
    var_3._id_F85B = var_3 scripts\mp\hud_util::_id_3F99(var_0, 100, 6);
    var_3._id_F85B scripts\mp\hud_util::setpoint("CENTER", "BOTTOM", 0, -70);
    var_3._id_F85B.alpha = 0.65;
    var_3._id_F85B.bar.alpha = 0.65;
    var_4 = 0;

    for(;;) {
      if(!scripts\mp\utility\player::isreallyalive(var_3)) {
        self._id_84F0 = undefined;
        var_3._id_F85B scripts\mp\hud_util::destroyelem();
        break;
      }

      if(!var_3 _meth_81F4()) {
        self notify("player_dismount");
        self._id_84F0 = undefined;
        var_3._id_F85B scripts\mp\hud_util::destroyelem();
        var_3 _id_C70E();
        var_3 _id_C715();
        self sethintstring(level._id_D0FA[self._id_D11F]._id_0224);
        self setmode(level._id_D0FA[self._id_D11F]._id_D0F7);
        _id_D0EC(self._id_AC8F);
        self setmode(level._id_D0FA[self._id_D11F]._id_D0F8);
        break;
      }

      if(self._id_7659 >= level._id_D0FA[self._id_D11F]._id_AD21) {
        var_5 = 1;
      } else {
        var_5 = self._id_7659 / level._id_D0FA[self._id_D11F]._id_AD21;
      }

      var_3._id_F85B scripts\mp\hud_util::_id_FC11(var_5);

      if(scripts\engine\utility::string_starts_with(self._id_D11F, "minigun_turret")) {
        var_6 = "minigun_turret";
      }

      if(self._id_5E93 || self._id_AD20) {
        self _meth_8410();
        var_3._id_F85B.bar.color = var_2;
        var_4 = 0;
      } else if(self._id_7659 > level._id_D0FA[self._id_D11F]._id_AD21 * 0.75 && scripts\engine\utility::string_starts_with(self._id_D11F, "minigun_turret")) {
        var_3._id_F85B.bar.color = var_1;

        if(randomintrange(0, 10) < 6) {
          self _meth_8411();
        } else {
          self _meth_8410();
        }

        if(!var_4) {
          var_4 = 1;
          thread _id_B84E();
        }
      } else {
        var_3._id_F85B.bar.color = var_0;
        self _meth_8411();
        var_4 = 0;
        self notify("not_overheated");
      }

      wait 0.05;
    }

    self setdefaultdroppitch(0.0);
  }
}

_id_D0DB() {
  self endon("death");
  level endon("game_ended");
  self notify("sentry_handleOwner");
  self endon("sentry_handleOwner");
  childthread _id_D0F4("disconnect");
  childthread _id_D0F4("joined_team");
  childthread _id_D0F4("joined_spectators");
}

_id_D0F4(var_0) {
  self.owner waittill(var_0);
  self notify("death");
}

_id_D0EC(var_0) {
  self.owner = var_0;
  self setsentryowner(self.owner);
  self _meth_839C(1, self._id_D11F);

  if(level.teambased) {
    self.team = self.owner.team;
    self _meth_83A0(self.team);
  }

  thread _id_D0DB();
}

_id_D0E2(var_0) {
  self notify("death");
}

_id_D0ED(var_0) {
  if(isDefined(self.owner)) {
    var_1 = self.owner._id_B161[self._id_D11F].size;
    self.owner._id_B161[self._id_D11F][var_1] = self;

    if(var_1 + 1 > 2) {
      self.owner._id_B161[self._id_D11F][0] notify("death");
    }

    self.owner _id_15E3(1);
    self.owner scripts\common\utility::_id_158A(1);
    self.owner thread _id_525D();
    self.owner _meth_860E(1);
  }

  self setModel(level._id_D0FA[self._id_D11F].modelbase);

  if(self _meth_8157() == "manual") {
    self setmode(level._id_D0FA[self._id_D11F]._id_D0F7);
  }

  if(self._id_D11F == "sentry_shock") {}

  thread _id_D0D8();
  thread _id_D0D9();
  self _meth_8376(undefined);
  self setCanDamage(1);

  switch (self._id_D11F) {
    case "minigun_turret_2":
    case "minigun_turret_1":
    case "minigun_turret":
    case "gl_turret_1":
    case "gl_turret":
    case "gl_turret_4":
    case "minigun_turret_4":
    case "minigun_turret_3":
    case "gl_turret_3":
    case "gl_turret_2":
      if(var_0) {
        self.angles = self._id_32CA.angles;

        if(isalive(self._id_AC8F)) {
          self._id_AC8F _id_0A99::_id_D5E9("pickup_hint", level._id_D0FA[self._id_D11F]._id_ADA3, 3.0, undefined, undefined, undefined, undefined, undefined, 1);
        }

        self._id_ADB1 = spawn("trigger_radius", self.origin + (0, 0, 1), 0, 105, 64);
        self._id_ADB1 _meth_80DB();
        self._id_ADB1 linkto(self);
        self._id_AC8F thread _id_F840(self);
        thread _id_F841();
      }

      break;
    case "manual_turret":
      self setdefaultdroppitch(30.0);
      break;
    default:
      break;
  }

  _id_D0E1();

  if(isDefined(self._id_267F)) {
    self._id_267F show();
    level notify("update_bombsquad");
  }

  self._id_32CA _meth_80FC();
  self._id_32CA = undefined;
  self._id_5BDA = undefined;

  if(isDefined(self.owner)) {
    self.owner._id_87A7 = 0;
    self.owner notify("new_sentry", self);
  }

  _id_D0E8(var_0);
  var_2 = spawnStruct();

  if(isDefined(self._id_A283)) {
    var_2._id_950E = self._id_A283;
  }

  var_2._id_5338 = "carried";
  var_2._id_43F7 = ::_id_D0E2;
  thread scripts\mp\movers::_id_7403(var_2);
  self notify("placed");
}

_id_D0E9(var_0) {
  if(isDefined(self._id_32CA)) {
    var_1 = self._id_32CA;
    var_1 _meth_80FC();
    var_1._id_87A7 = undefined;
    var_1._id_32CD = undefined;
    var_1 _id_15E3(1);
    var_1 scripts\common\utility::_id_158A(1);
    var_1 thread _id_525D();
    var_1 _meth_860E(1);

    if(isDefined(self._id_267F)) {
      self._id_267F delete();
    }
  }

  if(isDefined(var_0) && var_0) {
    scripts\mp\weapons::_id_555A();
  }

  self delete();
}

_id_D0EA(var_0, var_1, var_2) {
  if(isDefined(self._id_AC8F)) {} else {}

  if(self._id_D11F == "sentry_shock") {
    self setscriptablepartstate("muzzle", "neutral", 0);
  }

  self setModel(level._id_D0FA[self._id_D11F]._id_9FD9);
  self _meth_8376(var_0);
  self setCanDamage(0);
  _id_D0E0();
  var_0 _meth_860E(0);
  self._id_32CA = var_0;
  var_0._id_87A7 = 1;
  self._id_B0AA = var_1;
  thread _id_D0E4(var_0, var_2);
  var_0 thread _id_FD23(self);
  thread _id_D0E5(var_0);
  thread _id_D0E3(var_0);
  thread _id_D0E6();
  _id_078D::_id_1538(0);
  self setdefaultdroppitch(-89.0);
  _id_D0EB();

  if(isDefined(self _meth_8151())) {
    self unlink();
  }

  self notify("carried");

  if(isDefined(self._id_267F)) {
    self._id_267F hide();
  }
}

_id_FD23(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_0._id_314C = 1;
  var_1 = -1;

  for(;;) {
    var_2 = self _meth_8065(1, 40);
    var_0.origin = var_2["origin"];
    var_0.angles = var_2["angles"];
    var_3 = scripts\engine\utility::array_combine(level._id_F897, level._id_9E83, level._id_EB4E._id_F673, level._id_9EE2);
    var_4 = var_0 _meth_813D(var_3);
    var_0._id_314C = self isonground() && var_2["result"] && abs(var_0.origin[2] - self.origin[2]) < 30 && !scripts\mp\utility\entity::_id_8AA9(self) && var_4.size == 0;

    if(isDefined(var_2["entity"])) {
      var_0._id_A283 = var_2["entity"];
    } else {
      var_0._id_A283 = undefined;
    }

    if(var_0._id_314C != var_1) {
      if(var_0._id_314C) {
        var_0 setModel(level._id_D0FA[var_0._id_D11F]._id_9FD9);
        var_0 _id_B169();
      } else {
        var_0 setModel(level._id_D0FA[var_0._id_D11F]._id_9FCF);
        var_0 _id_31A3();
      }
    }

    var_1 = var_0._id_314C;
    wait 0.05;
  }
}

_id_D0E4(var_0, var_1) {
  self endon("placed");
  self endon("death");
  var_0 endon("disconnect");
  var_0 scripts\engine\utility::waittill_any_2("death", "emp_applied");

  if(self._id_314C && !istrue(var_1)) {
    _id_D0ED(self._id_B0AA);
  } else {
    _id_D0E9(0);
  }
}

_id_D0E5(var_0) {
  self endon("placed");
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

_id_D0E3(var_0) {
  self endon("placed");
  self endon("death");
  var_0 scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  self delete();
}

_id_D0E6(var_0) {
  self endon("placed");
  self endon("death");
  level waittill("game_ended");
  self delete();
}

_id_D0E8(var_0) {
  self setmode(level._id_D0FA[self._id_D11F]._id_D0F8);

  if(var_0) {
    self setcursorhint("HINT_NOICON");
    self sethintstring(level._id_D0FA[self._id_D11F]._id_0224);
    self makeuseable();
  }

  foreach(var_2 in level.players) {
    switch (self._id_D11F) {
      case "minigun_turret_2":
      case "minigun_turret_1":
      case "minigun_turret":
      case "gl_turret_1":
      case "gl_turret":
      case "gl_turret_4":
      case "minigun_turret_4":
      case "minigun_turret_3":
      case "gl_turret_3":
      case "gl_turret_2":
        if(var_0) {
          self _meth_80E0(var_2);
        }

        break;
      default:
        scripts\mp\utility\killstreak::_id_1155(self._id_D11F, "Killstreak_Ground", self.owner, 0, 1, 70, "carried");

        if(var_2 == self.owner && var_0) {
          self _meth_80E0(var_2);
        } else {
          self disableplayeruse(var_2);
        }

        break;
    }
  }

  var_4 = level._id_D0FA[self._id_D11F]._id_EFAC;

  if(self._id_DBE2) {
    level thread scripts\mp\hud_util::_id_EF8D(var_4, self.owner);
    self._id_DBE2 = 0;
  }

  if(self._id_D11F == "sam_turret") {
    thread _id_CB0D();
  }

  if(self._id_D11F == "scramble_turret") {
    thread _id_CC5D();
  }

  if(self._id_D11F == "sentry_shock") {
    thread _id_D0FD();
  }

  _id_078D::_id_1538(1);
}

_id_D0EB() {
  if(self._id_D11F == "manual_turret") {
    self sethintstring("");
    self makeunusable();
  }

  self setmode(level._id_D0FA[self._id_D11F]._id_D0F7);
  self makeunusable();
}

_id_D0E1() {
  self solid();
}

_id_D0E0() {
  self notsolid();
}

_id_8871(var_0) {
  if(level.teambased && self.team == var_0.team) {
    return 1;
  }

  return 0;
}

_id_D0CE() {
  self endon("death");
  level endon("game_ended");
  self._id_A0B2 = 0;
  self._id_7659 = 0;
  self._id_AD20 = 0;
  thread _id_D0DD();

  for(;;) {
    scripts\engine\utility::_id_108C5("turretstatechange", "cooled");

    if(self _meth_81C1()) {
      thread _id_D0D0();
      continue;
    }

    _id_D0F0();
    thread _id_D0D1();
  }
}

_id_D0F3() {
  self endon("death");
  level endon("game_ended");
  var_0 = level._id_D0FA[self._id_D11F]._id_F224;

  if(isDefined(var_0) && var_0 == 0) {
    return;
  }
  while(var_0) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self._id_32CA)) {
      var_0 = max(0, var_0 - 1.0);
    }
  }

  if(isDefined(self.owner)) {
    if(isDefined(level._id_D0FA[self._id_D11F]._id_106B4)) {
      self.owner _id_0A8D::_id_B86E(level._id_D0FA[self._id_D11F]._id_106B4, undefined, undefined, self.owner.origin);
    }
  }

  self notify("death");
}

_id_D0F2() {
  self endon("death");
}

_id_D0F1() {
  thread _id_D0F2();

  while(self._id_A0B2 < level._id_D0FA[self._id_D11F]._id_E410) {
    self._id_A0B2 = self._id_A0B2 + 0.1;
    wait 0.1;
  }
}

_id_D0F0() {
  self._id_A0B2 = 0;
}

_id_D0DF() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  _id_D0F1();
  var_0 = weaponfiretime(level._id_D0FA[self._id_D11F].weaponinfo);
  var_1 = level._id_D0FA[self._id_D11F]._id_2DB2;
  var_2 = level._id_D0FA[self._id_D11F]._id_2DB1;

  if(isDefined(self._id_EBA1) && self._id_EBA1) {
    var_0 = 0.05;
    var_3 = 50;
  } else {
    var_0 = 0.5 / (self._id_9554.size + 1);
    var_3 = var_1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = self _meth_8184(1);

    if(!isDefined(var_5)) {
      break;
    }

    self _meth_83C1();
    wait(var_0);
  }

  self notify("doneFiring");
  self _meth_8086();
}

_id_D0D0() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  _id_D0F1();
  var_0 = weaponfiretime(level._id_D0FA[self._id_D11F].weaponinfo);
  var_1 = level._id_D0FA[self._id_D11F]._id_2DB2;
  var_2 = level._id_D0FA[self._id_D11F]._id_2DB1;
  var_3 = level._id_D0FA[self._id_D11F]._id_AF6E;
  var_4 = level._id_D0FA[self._id_D11F]._id_AF6C;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self._id_AD20; var_6++) {
      self _meth_83C1();
      self notify("bullet_fired");
      self._id_7659 = self._id_7659 + var_0;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

_id_D0D1() {
  self notify("stop_shooting");
}

_id_F86C(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("player_dismount");
  var_1 = weaponfiretime(level._id_D0FA[var_0._id_D11F].weaponinfo);

  for(;;) {
    var_0 waittill("turret_fire");
    var_0._id_7659 = var_0._id_7659 + var_1;
    var_0._id_3D10 = var_1;
  }
}

_id_D0DD() {
  self endon("death");
  var_0 = weaponfiretime(level._id_D0FA[self._id_D11F].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level._id_D0FA[self._id_D11F]._id_AD21;
  var_4 = level._id_D0FA[self._id_D11F]._id_3D0F;

  for(;;) {
    if(self._id_7659 != var_1) {
      wait(var_0);
    } else {
      self._id_7659 = max(0, self._id_7659 - 0.05);
    }

    if(self._id_7659 > var_3) {
      self._id_AD20 = 1;
      thread _id_B84E();

      switch (self._id_D11F) {
        case "minigun_turret_2":
        case "minigun_turret_1":
        case "minigun_turret":
        case "minigun_turret_4":
        case "minigun_turret_3":
          playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
          break;
        default:
          break;
      }

      while(self._id_7659) {
        self._id_7659 = max(0, self._id_7659 - var_4);
        wait 0.1;
      }

      self._id_AD20 = 0;
      self notify("not_overheated");
    }

    var_1 = self._id_7659;
    wait 0.05;
  }
}

_id_F842() {
  self endon("death");
  var_0 = level._id_D0FA[self._id_D11F]._id_AD21;

  for(;;) {
    if(self._id_7659 > var_0) {
      self._id_AD20 = 1;
      thread _id_B84E();

      switch (self._id_D11F) {
        case "gl_turret":
          playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
          break;
        default:
          break;
      }

      while(self._id_7659) {
        wait 0.1;
      }

      self._id_AD20 = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

_id_F826() {
  self endon("death");

  for(;;) {
    if(self._id_7659 > 0) {
      if(self._id_3D10 <= 0) {
        self._id_7659 = max(0, self._id_7659 - 0.05);
      } else {
        self._id_3D10 = max(0, self._id_3D10 - 0.05);
      }
    }

    wait 0.05;
  }
}

_id_B84E() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level._id_D0FA[self._id_D11F]._id_609D);
  }
}

_id_B8E6() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    wait 0.4;
  }
}

_id_D0CF() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3.0;
  }
}

_id_CB0D() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");
  self._id_CB18 = undefined;
  self._id_CB17 = [];

  for(;;) {
    self._id_CB18 = _id_CB0C();
    _id_CB0E();
    wait 0.05;
  }
}

_id_CB0C() {
  var_0 = self gettagorigin("tag_laser");

  if(!isDefined(self._id_CB18)) {
    if(level.teambased) {
      var_1 = [];
      var_2 = scripts\mp\utility\teams::_id_6A01(self.team);

      foreach(var_4 in var_2) {
        foreach(var_6 in level._id_F8F8[var_4]) {
          var_1[var_1.size] = var_6;
        }
      }

      foreach(var_6 in var_1) {
        if(isDefined(var_6._id_8908) && var_6._id_8908) {
          continue;
        }
        if(_func_0202(var_0, var_6.origin, 0, self)) {
          return var_6;
        }
      }

      foreach(var_12 in level._id_9593) {
        if(isDefined(var_12.team) && var_12.team == self.team) {
          continue;
        }
        if(_func_0202(var_0, var_12.origin, 0, self)) {
          return var_12;
        }
      }

      foreach(var_15 in level._id_77D9) {
        if(isDefined(var_15.team) && var_15.team == self.team) {
          continue;
        }
        if(_func_0202(var_0, var_15.origin, 0, self)) {
          return var_15;
        }
      }

      foreach(var_6 in level._id_C335) {
        if(!isDefined(var_6)) {
          continue;
        }
        if(isDefined(var_6.team) && var_6.team == self.team) {
          continue;
        }
        if(_func_0202(var_0, var_6.origin, 0, self, var_6)) {
          return var_6;
        }
      }
    } else {
      foreach(var_6 in level._id_F8F8) {
        if(isDefined(var_6._id_8908) && var_6._id_8908) {
          continue;
        }
        if(isDefined(var_6.owner) && isDefined(self.owner) && var_6.owner == self.owner) {
          continue;
        }
        if(_func_0202(var_0, var_6.origin, 0, self)) {
          return var_6;
        }
      }

      foreach(var_12 in level._id_9593) {
        if(isDefined(var_12.owner) && isDefined(self.owner) && var_12.owner == self.owner) {
          continue;
        }
        if(_func_0202(var_0, var_12.origin, 0, self)) {
          return var_12;
        }
      }

      foreach(var_15 in level._id_77D9) {
        if(isDefined(var_15.owner) && isDefined(self.owner) && var_15.owner == self.owner) {
          continue;
        }
        if(_func_0202(var_0, var_15.origin, 0, self)) {
          return var_15;
        }
      }

      foreach(var_6 in level._id_C335) {
        if(!isDefined(var_6)) {
          continue;
        }
        if(isDefined(var_6.owner) && isDefined(self.owner) && var_6.owner == self.owner) {
          continue;
        }
        if(_func_0202(var_0, var_6.origin, 0, self, var_6)) {
          return var_6;
        }
      }
    }

    self _meth_8086();
    return undefined;
  } else {
    if(!_func_0202(var_0, self._id_CB18.origin, 0, self)) {
      self _meth_8086();
      return undefined;
    }

    return self._id_CB18;
  }
}

_id_CB0E() {
  if(isDefined(self._id_CB18)) {
    if(self._id_CB18 == level._id_72C7._id_B18E && !isDefined(level._id_731C)) {
      self._id_CB18 = undefined;
      self _meth_8086();
      return;
    }

    self _meth_8389(self._id_CB18);
    self waittill("turret_on_target");

    if(!isDefined(self._id_CB18)) {
      return;
    }
    if(!self._id_8EF7) {
      thread _id_CB10();
      thread _id_CB0F();
      thread _id_CB11();
      thread _id_CB12();
    }

    wait 2.0;

    if(!isDefined(self._id_CB18)) {
      return;
    }
    if(self._id_CB18 == level._id_72C7._id_B18E && !isDefined(level._id_731C)) {
      self._id_CB18 = undefined;
      self _meth_8086();
      return;
    }

    var_0 = [];
    var_0[0] = self gettagorigin("tag_le_missile1");
    var_0[1] = self gettagorigin("tag_le_missile2");
    var_0[2] = self gettagorigin("tag_ri_missile1");
    var_0[3] = self gettagorigin("tag_ri_missile2");
    var_1 = self._id_CB17.size;

    for(var_2 = 0; var_2 < 4; var_2++) {
      if(!isDefined(self._id_CB18)) {
        return;
      }
      if(isDefined(self._id_32CA)) {
        return;
      }
      self _meth_83C1();
      var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("sam_projectile_mp"), var_0[var_2], self._id_CB18.origin, self.owner);
      var_3 missile_settargetent(self._id_CB18);
      var_3 _meth_8231();
      var_3._id_CB19 = self;
      var_3._id_CB16 = var_1;
      self._id_CB17[var_1][var_2] = var_3;
      level notify("sam_missile_fired", self.owner, var_3, self._id_CB18);

      if(var_2 == 3) {
        break;
      }

      wait 0.25;
    }

    level notify("sam_fired", self.owner, self._id_CB17[var_1], self._id_CB18);
    wait 3.0;
  }
}

_id_CB12() {
  level endon("game_ended");
  self endon("death");

  while(isDefined(self._id_CB18) && isDefined(self _meth_8184(1)) && self _meth_8184(1) == self._id_CB18) {
    var_0 = self gettagorigin("tag_laser");

    if(!_func_0202(var_0, self._id_CB18.origin, 0, self, self._id_CB18)) {
      self _meth_8086();
      self._id_CB18 = undefined;
      break;
    }

    wait 0.05;
  }
}

_id_CB10() {
  self endon("death");
  self _meth_8203();
  self._id_8EF7 = 1;

  while(isDefined(self._id_CB18) && isDefined(self _meth_8184(1)) && self _meth_8184(1) == self._id_CB18) {
    waitframe();
  }

  self _meth_8202();
  self._id_8EF7 = 0;
}

_id_CB0F() {
  self endon("death");
  self._id_CB18 endon("death");

  if(!isDefined(self._id_CB18._id_77E7)) {
    return;
  }
  self._id_CB18 waittill("crashing");
  self _meth_8086();
  self._id_CB18 = undefined;
}

_id_CB11() {
  self endon("death");
  self._id_CB18 endon("death");

  if(!isDefined(self._id_CB18.model)) {
    return;
  }
  if(self._id_CB18.model == "vehicle_uav_static_mp") {
    self._id_CB18 waittill("leaving");
    self _meth_8086();
    self._id_CB18 = undefined;
  }
}

_id_CC5D() {
  self endon("carried");
  self endon("death");
  level endon("game_ended");
  self._id_CC5C = undefined;

  for(;;) {
    self._id_CC5C = _id_CC4B();

    if(isDefined(self._id_CC5C) && isDefined(self._id_CC5C._id_CC51) && !self._id_CC5C._id_CC51) {
      _id_CC5B();
    }

    wait 0.05;
  }
}

_id_CC4B() {
  return _id_CB0C();
}

_id_CC5B() {
  if(isDefined(self._id_CC5C)) {
    if(self._id_CC5C == level._id_72C7._id_B18E && !isDefined(level._id_731C)) {
      self._id_CC5C = undefined;
      self _meth_8086();
      return;
    }

    self _meth_8389(self._id_CC5C);
    self waittill("turret_on_target");

    if(!isDefined(self._id_CC5C)) {
      return;
    }
    if(!self._id_8EF7) {
      thread _id_CC4D();
      thread _id_CC4C();
      thread _id_CC4E();
      thread _id_CC4F();
    }

    wait 2.0;

    if(!isDefined(self._id_CC5C)) {
      return;
    }
    if(self._id_CC5C == level._id_72C7._id_B18E && !isDefined(level._id_731C)) {
      self._id_CC5C = undefined;
      self _meth_8086();
      return;
    }

    if(!isDefined(self._id_CC5C)) {
      return;
    }
    if(isDefined(self._id_32CA)) {
      return;
    }
    self _meth_83C1();
    thread _id_D6B9();
    self notify("death");
  }
}

_id_D6B9() {
  var_0 = self._id_CC5C;
  var_0 notify("scramble_fired", self.owner);
  var_0 endon("scramble_fired");
  var_0 endon("death");
  var_0 thread scripts\mp\killstreaks\helicopter::_id_774E();
  var_0._id_CC51 = 1;
  var_0._id_CFEE = self.owner;
  var_0 notify("findNewTarget");
  wait 30;

  if(isDefined(var_0)) {
    var_0._id_CC51 = 0;
    var_0._id_CFEE = undefined;
    var_0 thread scripts\mp\killstreaks\helicopter::_id_774E();
  }
}

_id_CC4F() {
  level endon("game_ended");
  self endon("death");

  while(isDefined(self._id_CC5C) && isDefined(self _meth_8184(1)) && self _meth_8184(1) == self._id_CC5C) {
    var_0 = self gettagorigin("tag_laser");

    if(!_func_0202(var_0, self._id_CC5C.origin, 0, self, self._id_CC5C)) {
      self _meth_8086();
      self._id_CC5C = undefined;
      break;
    }

    wait 0.05;
  }
}

_id_CC4D() {
  self endon("death");
  self _meth_8203();
  self._id_8EF7 = 1;

  while(isDefined(self._id_CC5C) && isDefined(self _meth_8184(1)) && self _meth_8184(1) == self._id_CC5C) {
    wait 0.05;
  }

  self _meth_8202();
  self._id_8EF7 = 0;
}

_id_CC4C() {
  self endon("death");
  self._id_CC5C endon("death");

  if(!isDefined(self._id_CC5C._id_77E7)) {
    return;
  }
  self._id_CC5C waittill("crashing");
  self _meth_8086();
  self._id_CC5C = undefined;
}

_id_CC4E() {
  self endon("death");
  self._id_CC5C endon("death");

  if(!isDefined(self._id_CC5C.model)) {
    return;
  }
  if(self._id_CC5C.model == "vehicle_uav_static_mp") {
    self._id_CC5C waittill("leaving");
    self _meth_8086();
    self._id_CC5C = undefined;
  }
}

_id_D0FD() {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  thread _id_10BF8();
  self._id_13B2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  self._id_13B2 linkto(self, "tag_flash");

  for(;;) {
    var_0 = scripts\engine\utility::_id_108A7(1, "turret_on_target");

    if(var_0 == "timeout") {
      continue;
    }
    self._id_D0FC = self _meth_8184(1);

    if(isDefined(self._id_D0FC) && scripts\mp\utility\player::isreallyalive(self._id_D0FC)) {
      thread _id_D9EE(self._id_D0FC);
      self waittill("done_firing");
    }
  }
}

_id_CFB3() {
  if(isDefined(level._id_F8F8)) {
    if(level.teambased) {
      var_0 = scripts\mp\utility\teams::_id_6A01(self.owner.team);

      foreach(var_2 in var_0) {
        foreach(var_4 in level._id_F8F8[var_2]) {
          if(_id_EF12(var_4)) {
            return var_4;
          }
        }
      }
    } else {
      foreach(var_4 in level._id_F8F8) {
        if(var_4.owner == self.owner) {
          continue;
        }
        if(_id_EF12(var_4)) {
          return var_4;
        }
      }
    }
  }

  if(isDefined(level._id_77D9)) {
    foreach(var_10 in level._id_77D9) {
      if(var_10.streakname != "jackal") {
        continue;
      }
      if(level.teambased && var_10.team == self.owner.team) {
        continue;
      }
      if(!level.teambased && var_10.owner == self.owner) {
        continue;
      }
      if(_id_EF12(var_10)) {
        return var_10;
      }
    }
  }
}

_id_EF12(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = 0;
  var_2 = self gettagorigin("tag_flash");
  var_3 = var_0.origin;
  var_4 = vectornormalize(var_3 - var_2);
  var_5 = anglesToForward(self.angles);
  var_6 = [self, self.owner, var_0];
  var_7 = physics_createcontents(["physicscontents_clipshot", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);

  if(scripts\engine\trace::ray_trace_passed(var_2, var_3, var_6, var_7) && vectordot(var_5, var_4) > 0.25 && distance2dsquared(var_2, var_3) > 10000) {
    var_1 = 1;
  }

  return var_1;
}

_id_DA36(var_0, var_1) {
  self endon("death");
  self endon("carried");
  level endon("game_ended");
  self setmode("manual");
  thread _id_D6C7(var_0, var_1);
  self._id_D0FB = undefined;
  self waittill("turret_on_target");
  thread _id_9B8A(var_0);
  self playSound("shock_sentry_charge_up");
  playFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  _id_D0F1();
  stopFXOnTag(scripts\engine\utility::getfx("sentry_shock_charge"), self, "tag_laser");
  self notify("start_firing");
  self setscriptablepartstate("coil", "active");
  var_2 = 2;
  var_3 = 1;

  while(isDefined(var_0) && _id_EF12(var_0)) {
    var_4 = self gettagorigin("tag_flash");
    var_5 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("sentry_shock_missile_mp"), var_4, var_0.origin, self.owner);
    var_5 missile_settargetent(var_0);
    var_5 _meth_8231();
    var_5.killcament = self.killcament;
    var_5.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + var_3, 0);
    level notify("laserGuidedMissiles_incoming", self.owner, var_5, var_0);
    var_3++;

    if(var_3 > 2) {
      var_3 = 1;
    }

    wait(var_2);
  }

  self setscriptablepartstate("muzzle", "neutral", 0);
  self notify("sentry_lost_target");
  var_1 unlink();
  var_1.origin = self gettagorigin("tag_flash");
  var_1 linkto(self, "tag_flash");
  self setmode("sentry");
  self _meth_8086();
  self setscriptablepartstate("coil", "idle");
  _id_D0F0();
  self notify("done_firing");
}

_id_D0DA() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    while(var_0 _meth_81F4()) {
      if(var_0 attackbuttonpressed()) {
        self _meth_83C1();
      }

      waitframe();
    }

    waitframe();
  }
}

_id_D0D7(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  self.owner notifyonplayercommand("maunal_sentry_pickup", "+weapnext");
  self._id_9A68 = spawn("trigger_radius", self.origin, 0, 128, 128);
  self._id_9A68 _meth_80DB();
  self._id_9A68 linkto(self, "tag_origin");

  for(;;) {
    if(isDefined(self._id_32CA)) {
      waitframe();
    }

    if(!self.owner istouching(self._id_9A68)) {
      waitframe();
    }

    self.owner waittill("maunal_sentry_pickup");
    self setmode(level._id_D0FA[self._id_D11F]._id_D0F7);
    self.owner._id_B161[self._id_D11F] = ::scripts\engine\utility::array_remove(self.owner._id_B161[self._id_D11F], self);
    self.owner _id_D4BC(self, 0, var_0);
  }
}

_id_D6C7(var_0, var_1) {
  self endon("death");
  self endon("carried");
  self endon("sentry_lost_target");
  var_0 endon("death");
  level endon("game_ended");

  for(;;) {
    var_2 = self gettagorigin("tag_aim");
    var_3 = var_0.origin;
    var_4 = vectornormalize(var_3 - var_2);
    var_5 = var_2 + var_4 * 500;
    var_1 unlink();
    var_1.origin = var_5;
    var_1 linkto(self);
    self _meth_8389(var_1);
    waitframe();
  }
}

_id_10BF8() {
  self endon("death");

  for(;;) {
    self waittill("carried");

    if(isDefined(self._id_D0FC)) {
      self._id_D0FC = undefined;
    }

    if(isDefined(self._id_D0FB)) {
      self._id_D0FB = undefined;
    }

    self _meth_8086();
  }
}

_id_D9EE(var_0) {
  self endon("death");
  self endon("carried");

  if(!isDefined(var_0)) {
    return;
  }
  thread _id_9B8A(var_0);
  self playSound("shock_sentry_charge_up");
  _id_D0F1();
  self notify("start_firing");
  level thread scripts\mp\battlechatter_mp::_id_CB70(var_0, "plr_killstreak_target");
  var_1 = weaponfiretime(level._id_D0FA[self._id_D11F].weaponinfo);

  while(isDefined(var_0) && scripts\mp\utility\player::isreallyalive(var_0) && isDefined(self _meth_8184(1)) && self _meth_8184(1) == var_0 && !scripts\mp\utility\outline::_id_ACED(self gettagorigin("tag_flash"), var_0 getEye())) {
    self _meth_83C1();
    wait(var_1);
  }

  self._id_D0FC = undefined;
  self _meth_8086();
  _id_D0F0();
  self notify("done_firing");
}

_id_9F6B(var_0) {
  self endon("death");
  self endon("carried");
  var_1 = 3;
  var_2 = 1;

  while(var_1 > 0) {
    if(!isDefined(var_0)) {
      return;
    }
    if(!isDefined(self.owner)) {
      return;
    }
    var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("sentry_shock_grenade_mp"), self gettagorigin("tag_flash"), var_0.origin, self.owner);
    var_3 missile_settargetent(var_0, _id_6DC1(var_0));
    var_3.killcament = self.killcament;
    var_3.streakinfo = self.streakinfo;
    self setscriptablepartstate("muzzle", "fire" + var_2, 0);
    var_2++;

    if(var_2 > 2) {
      var_2 = 1;
    }

    var_3 thread _id_10C12(var_0);
    var_1--;
    wait 0.2;
  }
}

_id_6DC1(var_0) {
  var_1 = (0, 0, 40);
  var_2 = var_0 getstance();

  switch (var_2) {
    case "stand":
      var_1 = (0, 0, 40);
      break;
    case "crouch":
      var_1 = (0, 0, 20);
      break;
    case "prone":
      var_1 = (0, 0, 5);
      break;
  }

  return var_1;
}

_id_10C12(var_0) {
  self endon("death");
  var_0 endon("disconnect");

  for(;;) {
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      self missile_settargetent(var_0 _meth_8122());
      break;
    }

    waitframe();
  }
}

_id_9B8A(var_0) {
  self endon("death");
  self _meth_8203();
  self._id_8EF7 = 1;
  scripts\engine\utility::waittill_any_2("done_firing", "carried");
  self _meth_8202();
  self._id_8EF7 = 0;
}

_id_10BF9(var_0) {
  self endon("death");
  self endon("done_firing");
  var_1 = undefined;

  for(;;) {
    self waittill("victim_damaged", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_2 == var_0) {
      var_12 = 100;
      var_13 = scripts\mp\utility\player::_id_6C60(var_8, var_12, var_2.team, self.owner);
      playFX(scripts\engine\utility::getfx("sentry_shock_explosion"), var_8);

      if(var_13.size > 0) {
        foreach(var_15 in var_13) {
          if(var_15.player != var_2) {
            var_15.player dodamage(5, var_8, self.owner, self, var_6, var_7);
            var_16 = undefined;
            var_17 = undefined;

            if(var_15._id_10419.size > 1) {
              var_17 = randomint(var_15._id_10419.size);
              var_16 = var_15._id_10419[var_17];
            } else
              var_16 = var_15._id_10419[0];

            _func_0313(scripts\engine\utility::getfx("sentry_shock_arc"), var_8, vectortoangles(var_16 - var_8), var_16);
          }
        }
      }
    }
  }
}

_id_15E3(var_0) {
  if(var_0) {
    scripts\common\utility::_id_158D(1);
    thread scripts\mp\supers::_id_FB29();
  } else {
    thread scripts\mp\supers::_id_15D9();
    scripts\common\utility::_id_158D(0);
  }
}

_id_B169() {
  var_0 = self._id_D11F;

  if(var_0 == "super_trophy") {
    self.owner _meth_80FD(&"LUA_MENU_MP/PLACE_SUPER_TROPHY");
    return;
  } else
    self.owner _meth_80FD(&"SENTRY/PLACE");
}

_id_31A3() {
  var_0 = self._id_D11F;

  if(var_0 == "super_trophy") {
    self.owner _meth_80FD(&"LUA_MENU_MP/CANNOT_PLACE_SUPER_TROPHY");
    return;
  } else
    self.owner _meth_80FD(&"SENTRY/CANNOT_PLACE");
}