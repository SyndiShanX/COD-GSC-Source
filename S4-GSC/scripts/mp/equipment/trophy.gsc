/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\equipment\trophy.gsc
*************************************************/

_id_F68D() {
  var_0 = spawnStruct();
  var_0._id_ED6F = [];
  var_0._id_ED6F[0] = "tag_claymore_fx_00";
  var_0._id_ED6F[1] = "tag_claymore_fx_01";
  var_0._id_ED6F[2] = "tag_claymore_fx_02";
  var_0._id_ED6F[3] = "tag_claymore_fx_03";
  level._id_0BCE["trophy_tracer"] = loadfx("vfx/s4/equipment/vfx_trophy_tracer");
  level._id_0BCE["trophy_launch_expl"] = loadfx("vfx/s4/equipment/vfx_trophy_launch");
  level._id_0BCE["trophy_blocked_throwable_expl"] = loadfx("vfx/s4/equipment/vfx_trophy_disable_lethal");
  level._id_F674 = var_0;
  level._id_F673 = [];
}

_id_F69E(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  thread scripts\mp\weapons::_id_A105(self, var_0);
  _id_07BC::createfieldupgradechallengeevent("activate");
  var_0 _meth_86FE("equipment");

  if(level.teambased) {
    var_0 _meth_8706(self.team);
  } else {
    var_0 _meth_8706(self);
  }

  var_0 waittill("missile_stuck", var_1);
  var_0._id_75E9 = var_0 thread _id_078F::_id_D594(0, 30);
  thread _id_084C::trophy_plant(var_0);
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  var_2 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");

  if(var_2) {
    var_0._id_75A8 = 1;
  }

  var_0._id_16CC = _id_F698();

  if(!isDefined(var_0._id_16CC)) {
    var_0._id_16CC = getdvarint("scr_trophy_maxAmmoBlock", 3);
  }

  thread scripts\mp\weapons::_id_A105(self, var_0);
  var_0._id_57D2 = _id_F67C(var_0);
  var_3 = scripts\engine\utility::ter_op(var_2, 200, getdvarint("scr_trophy_hp", 100));
  var_4 = scripts\engine\utility::ter_op(var_2, "hitequip", "");
  var_0 thread _id_07C3::_id_A0FF(var_3, var_4, ::_id_F68B, ::_id_F68A, 0);
  var_0 thread _id_07CD::_id_C33E(::_id_F681, 1, 1);
  var_0 thread trophy_give_to_owner(self);
  var_0 thread _id_F682();
  var_0 thread _id_F683();
  var_0 thread _id_F69F();
  var_0 thread trophy_watchduration();
  var_0 thread scripts\mp\equipment::equipmentwatchoob(::_id_F681);
  var_0 _meth_85B9();
  var_0 _meth_85BA();
  var_0 thread _id_F680();
}

trophy_give_to_owner(var_0) {
  var_1 = var_0 getentitynumber();

  if(!isDefined(level._id_F673[var_1])) {
    level._id_F673[var_1] = [];
  }

  var_2 = level._id_F673[var_1].size;

  if(var_2 + 1 > getdvarint("scr_trophy_maxActive", 2)) {
    level._id_F673[var_1][0] _id_F681(0);
    var_2--;
  }

  level._id_F673[var_1][var_2] = self;
}

trophy_remove_from_owner(var_0) {
  var_1 = [];
  var_2 = var_0 getentitynumber();

  for(var_3 = 0; var_3 < level._id_F673[var_2].size; var_3++) {
    var_4 = level._id_F673[var_2][var_3];

    if(var_4 != self) {
      var_1[var_1.size] = var_4;
    }
  }

  level._id_F673[var_2] = var_1;
}

trophy_watchduration() {
  self endon("death");
  self.owner endon("disconnect");
  wait(getdvarint("scr_trophy_maxDuration", 45));
  thread _id_F681(0);
}

_id_F681(var_0) {
  var_0 = istrue(var_0);
  var_1 = 0.1;

  if(var_0) {
    var_1 = var_1 + 0.5;
  }

  if(var_0) {
    wait 0.5;
  }

  playFX(level._effect["field_mic_destroyed"], self.origin);
  earthquake(0.5, 1, self.origin, 512);
  thread _id_084C::field_mic_explode(self);
  thread _id_F67D(var_1);
}

_id_F67D(var_0) {
  self notify("death");
  level._id_9EE2[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(isDefined(self.owner)) {
    trophy_remove_from_owner(self.owner);
  }

  if(!istrue(self._id_8A74)) {
    self makeunusable();
    scripts\mp\weapons::_id_99EC();
  }

  self._id_57CE = 1;
  var_1 = self.owner;

  if(isDefined(self.owner) && !istrue(self._id_8A74)) {
    var_1._id_B1D0 = scripts\engine\utility::array_remove(var_1._id_B1D0, self);
    var_1 notify("trophy_update", 0);
  } else if(isDefined(self.owner)) {
    var_1._id_0F61 = scripts\engine\utility::array_remove(var_1._id_0F61, self);
    var_1 notify("trophy_update", 0);
  }

  wait(var_0);
  self delete();
}

_id_F680() {
  self endon("death");
  wait 1.25;
}

_id_F69F() {
  self endon("death");
  self.owner endon("disconnect");

  if(!isDefined(level._id_7177)) {
    level._id_7177 = [];
  }

  if(!isDefined(level._id_9F7E)) {
    level._id_9F7E = [];
  }

  if(!isDefined(level._id_9EE2)) {
    level._id_9EE2 = [];
  }

  if(!isDefined(level._id_A194)) {
    level._id_A194 = [];
  }

  var_0 = _id_F677();

  for(;;) {
    var_1 = _id_F678();
    var_2 = [];
    var_2[0] = level._id_7177;
    var_2[1] = level._id_9F7E;
    var_2[2] = level._id_9EE2;
    var_2[3] = level._id_A194;
    var_3 = scripts\engine\utility::_id_1B9B(var_2);

    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(istrue(var_5._id_57CE)) {
        continue;
      }
      if(_id_F679(var_5)) {
        continue;
      }
      var_6 = var_5.owner;

      if(!isDefined(var_6) && isDefined(var_5.weapon_name) && weaponclass(var_5.weapon_name) == "grenade") {
        var_6 = _func_00AF(var_5);
      }

      if(isDefined(var_6) && self.owner.team == var_6.team) {
        continue;
      }
      if(distancesquared(var_5.origin, self.origin) > _id_F690(var_5, 65536)) {
        continue;
      }
      var_7 = _func_02C1(var_1, var_5.origin, var_0, [self, var_5], 0, "physicsquery_closest");

      if(isDefined(var_7) && var_7.size > 0) {
        continue;
      }
      _id_F696(var_5);
    }

    waitframe();
  }
}

_id_F696(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  var_3 = _id_F685(var_1);
  var_4 = self gettagorigin(var_3);
  var_5 = playFX(level._id_0BCE["trophy_tracer"], var_4, var_1 - var_4);
  thread _id_084C::trophy_fire(var_4, var_5);
  wait 0.05;
  var_0 setCanDamage(0);
  var_0._id_57CE = 1;
  var_0 _meth_83F8();
  _id_F69B(var_0);
  _id_F692(var_0, "s4_trophy_mp", self.owner);

  if(scripts\mp\utility\weapon::_id_8A7D(var_0.weapon_name)) {
    var_0 notify("damage", 999999999, var_0, undefined, undefined, "MOD_PROJECTILE");
  } else if(scripts\mp\weapons::_id_8985(var_0)) {
    var_0 scripts\mp\weapons::_id_476C();
  } else {
    var_0 delete();
  }

  playFX(level._id_0BCE["trophy_launch_expl"], var_4);
  playFX(level._id_0BCE["trophy_blocked_throwable_expl"], var_1);
  self._id_57D2 thread _id_F684(var_1, var_2);
  thread _id_084C::trophy_successful_explosion(var_1);
  self.owner thread _id_0A9F::_id_7003("trophy_blocked_throwable");
  self._id_16CC--;

  if(self._id_16CC <= 0) {
    thread _id_F681(1);
  }

  self.owner thread _id_07BC::createequipmentchallengeevent(self.owner, undefined, "throphy_protection_successful");
}

_id_F68A(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_4;
  return var_5;
}

_id_F68B(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(self.owner) && istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FEA(self);
    var_1 scripts\mp\battlechatter_mp::_id_555B(self);
  }

  _id_F689(var_1);
  var_1 thread _id_07BC::createfieldupgradechallengeevent("destroy", var_0.objweapon);
  thread _id_F681();
}

_id_F682() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", var_0);
  var_1 = var_0.attacker;
  _id_F689(var_1);
  _id_F688(var_1);
  thread _id_F681(1);
}

_id_F683() {
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::waittill_any_2("game_ended", "bro_shot_start");
  thread _id_F681();
}

_id_F694() {
  if(self.owner scripts\mp\equipment::_id_755B("equip_trophy")) {
    self.owner _id_F675(self._id_16CC);
  }
}

_id_F67C(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.killcament = var_0;
  var_1.owner = var_0.owner;
  var_1.team = var_0.team;
  var_1._id_5562 = var_0._id_5562;
  var_1.weapon_name = var_0.weapon_name;
  var_1 setotherent(var_1.owner);
  var_1 setentityowner(var_1.owner);
  var_1 setModel("trophy_system_mp_explode");
  var_1._id_57AF = 1;
  var_1._id_57B0 = 1;
  var_1 thread _id_F67A(var_0, 0.1);
  return var_1;
}

_id_F684(var_0, var_1) {
  self dontinterpolate();
  self.origin = var_0;
  self.angles = var_1;

  if(self._id_57AF) {
    self._id_57AF = 0;
  } else if(self._id_57B0) {
    self._id_57AF = 0;
  }
}

_id_F678() {
  return self.origin + anglestoup(self.angles) * 45;
}

_id_F677() {
  return physics_createcontents(["physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item"]);
}

_id_F690(var_0, var_1) {
  if(isDefined(var_0.weapon_name) && isDefined(var_0.owner)) {
    switch (var_0.weapon_name) {
      case "jackal_cannon_mp":
      case "switch_blade_child_mp":
      case "drone_hive_projectile_mp":
        if(147456 > var_1) {
          var_1 = 147456;
        }

        break;
      case "iw7_arclassic_mp":
      case "iw8_la_mike32_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_kgolf_mp":
      case "iw8_la_gromeo_mp":
      case "pop_rocket_proj_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_gromeoks_mp":
        if(65536 > var_1) {
          var_1 = 65536;
        }

        break;
    }
  }

  return var_1;
}

_id_F679(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1) && isDefined(var_0._id_10D0C)) {
    var_1 = var_0._id_10D0C.basename;
  }

  if(isDefined(var_1)) {
    if(scripts\mp\utility\weapon::_id_88F6(var_1)) {
      return 1;
    }

    if(scripts\mp\utility\weapon::_id_8774(var_1)) {
      return 1;
    }

    switch (var_1) {
      case "trophy_mp":
        if(scripts\mp\weapons::_id_8985(var_0)) {
          return 1;
        }

        break;
      case "s4_me_axe_mp":
      case "s4_throwing_knife_mp":
        return 1;
    }
  }

  return 0;
}

_id_F69B(var_0) {
  if(getdvarint("#x3766813331c774075", 0) > 0) {
    return;
  }
}

_id_F692(var_0, var_1, var_2) {
  if(!isDefined(var_0.owner) || !isPlayer(var_0.owner)) {
    return;
  }
  var_0.owner thread _id_07C4::_id_FC47("hittrophysystem");

  if(isDefined(var_0.weapon_name)) {
    switch (var_0.weapon_name) {
      case "jackal_cannon_mp":
      case "switch_blade_child_mp":
      case "drone_hive_projectile_mp":
        var_0.owner notify("destroyed_by_trophy", var_2, var_1, var_0.weapon_name, var_0.origin, var_0.angles);
        break;
    }
  }
}

_id_F685(var_0) {
  var_1 = level._id_F674._id_ED6F;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_10, var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = self gettagangles(var_5);
    var_8 = anglesToForward(var_7);
    var_9 = vectordot(vectornormalize(var_0 - var_6), var_8);

    if(var_10 == 0 || var_9 > var_2) {
      var_2 = var_9;
      var_3 = var_5;
    }
  }

  return var_3;
}

_id_F687(var_0) {
  var_1 = level._id_F674._id_ED6F;

  foreach(var_4, var_3 in var_1) {
    if(var_3 == var_0) {
      return "protect" + (var_4 + 1);
    }
  }

  return undefined;
}

_id_F689(var_0) {}

_id_F688(var_0) {
  var_1 = "";

  if(istrue(self._id_75A8)) {
    var_1 = "hitequip";
  }

  if(isPlayer(var_0)) {
    var_0 _id_07C4::_id_FC47(var_1);
  }
}

_id_F675(var_0) {
  if(!isDefined(self._id_F673)) {
    self._id_F673 = [];
  }

  if(self._id_F673.size < _id_F68E()) {
    if(!isDefined(var_0)) {
      var_0 = getdvarint("scr_trophy_maxAmmoBlock", 3);
    }

    self._id_F673[self._id_F673.size] = var_0;
  }
}

_id_F698() {
  if(isDefined(self._id_F673) && self._id_F673.size > 0) {
    var_0 = self._id_F673[self._id_F673.size - 1];
    self._id_F673[self._id_F673.size - 1] = undefined;
    return var_0;
  }

  return undefined;
}

_id_F67B() {
  self._id_F673 = undefined;
}

_id_F695() {
  var_0 = 4;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    _id_F675();
  }
}

_id_F68E() {
  return 4;
}

_id_F68F(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    return [var_3, var_4];
  }

  if(var_3 == 0) {
    return [var_3, var_4];
  }

  var_5 = undefined;

  if(level._id_74C4) {
    switch (var_2) {
      case "player_trophy_system_mp":
      case "super_trophy_mp":
      case "trophy_mp":
        var_5 = 20;
        break;
    }
  }

  var_6 = var_4;

  if(isDefined(var_5)) {
    var_6 = var_5 - var_3;
  }

  var_6 = min(var_6, var_4);
  return [var_3, var_4];
}

_id_F67A(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  wait(var_1);
  self delete();
}

trophy_on_owner_changed(var_0) {
  trophy_remove_from_owner(var_0);
  trophy_give_to_owner(self.owner);
  self setscriptablepartstate("hacked", "active", 0);
}