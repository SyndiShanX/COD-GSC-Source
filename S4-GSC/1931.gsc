/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1931.gsc
*************************************************/

_id_8177(var_0) {
  if(!isDefined(level._id_4097)) {
    level._id_4097 = [];
  }

  if(!isDefined(self._id_4096)) {
    self._id_4096 = spawnStruct();
    self._id_4096._id_25F2 = 0;
    self._id_4096._id_25F3 = [];
  }

  self._id_4096._id_0026 = 1;
}

_id_4099(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var_1 = _id_6999(var_0);
  var_2 = _id_699A(var_1);
  thread _id_4098(var_0, var_1, var_2);
}

_id_386E() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupImpactWatcher");
}

_id_4098(var_0, var_1, var_2) {
  self notify("cleanupImpactWatcher");
  self endon("disconnect");
  self endon("cleanupImpactWatcher");
  childthread _id_386E();

  for(;;) {
    self waittill("bullet_first_impact", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_0 != var_7) {
      continue;
    }
    var_11 = _id_E290(var_9, var_8, var_1, var_7);
    _id_7459(var_11, var_3, var_4, var_10, var_5, var_6, var_7, var_8, var_9, var_2);
  }
}

_id_7459(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(_id_DBC3(var_5, var_0, var_1, var_2)) {
    _id_C198(var_0, var_4, var_7, var_8);
  } else if(_id_DB1E(var_1)) {
    var_0 delete();
    return;
  } else if(_id_DB80(var_1))
    _id_9515(var_0, var_1, var_2);

  if(isDefined(var_9)) {
    [[var_9]](var_0, var_1, var_2, var_3, var_5);
  }
}

_id_7D4F(var_0, var_1, var_2, var_3, var_4) {}

_id_7D50(var_0, var_1, var_2, var_3, var_4) {
  var_0 setscriptablepartstate("effects", "impact");

  if(isDefined(var_1) && (isPlayer(var_1) || isagent(var_1))) {
    var_5 = 1.1;
  } else {
    var_5 = 2;
  }

  var_0._id_0203 = magicgrenademanual("semtex_bolt_mp", var_0.origin, (0, 0, 0), var_5);
  var_0._id_0203.angles = var_0.angles;
  var_0._id_0203 linkto(var_0, "tag_origin");
  thread _id_57AE(var_0, var_5);
}

_id_7D51(var_0, var_1, var_2, var_3, var_4) {
  var_0 setscriptablepartstate("effects", "impact");
  thread _id_F102(var_0, var_1, var_2, var_3);
  thread _id_F101(var_0, var_1);
  thread _id_F100(var_0);
}

_id_7D52(var_0, var_1, var_2, var_3, var_4) {
  if(_id_EAB0(var_1, var_4)) {
    var_0 setscriptablepartstate("impact", "active");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "gas_createTrigger")) {
      thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "gas_createTrigger")]](var_0.origin, self, 5, 0.45);
    }

    thread _id_EAA7(var_0);
  } else
    var_0 setscriptablepartstate("impact", "dud");
}

_id_57AE(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_0._id_0203 scripts\engine\utility::_id_108AE(var_1, "explode");
  var_0 setscriptablepartstate("effects", "explode");
  var_2 = makeweapon("semtex_bolt_mp");
  var_3 = makeweapon("semtex_bolt_splash_mp");
  var_2._id_AE61 = var_0._id_04F6;
  var_3._id_AE61 = var_0._id_04F6;

  if(isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F)) {
    var_0._id_EA8F _id_09BF::_id_5ECC();
    var_0._id_EA8F dodamage(110, var_0.origin, self, undefined, "MOD_EXPLOSIVE", var_2);
    var_0._id_EA8F _id_09BF::_id_5ECD();
  }

  _func_01BA(var_0.origin, 160, 110, 35, self, "MOD_EXPLOSIVE", var_3);
  wait 0.05;

  if(!var_0 _id_FF46()) {
    return;
  }
  var_0 delete();
}

_id_F102(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_4 = makeweapon("thermite_bolt_mp");
  var_4._id_AE61 = var_0._id_04F6;

  if(isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F)) {
    if(var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5() || isDefined(var_1.classname) && var_1.classname == "misc_turret") {
      var_5 = 1.0;
    } else {
      var_5 = 0.25;
    }

    var_6 = int(4.5 / var_5);

    while(isDefined(var_1) && isDefined(var_0) && isalive(var_1) && var_6 > 0) {
      var_1 _id_09BF::_id_5ECC();
      var_1 dodamage(5, var_0.origin, self, var_0, "MOD_FIRE", var_4, var_3);
      var_1 _id_09BF::_id_5ECD();
      var_6--;
      wait(var_5);
    }
  }
}

_id_F101(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_2 = int(18.0);
  var_3 = makeweapon("thermite_bolt_radius_mp");
  var_3._id_AE61 = var_0._id_04F6;
  var_0._id_F103 = var_3.basename;

  while(var_2 > 0) {
    if(isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F)) {
      var_0._id_EA8F _id_09BF::_id_10A2("thermiteBoltStuck", 0, 0, ::_id_F0F3);
    }

    var_0 radiusdamage(var_0.origin, 50, 5, 3, self, "MOD_FIRE", var_3);

    if(isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F)) {
      var_0._id_EA8F _id_09BF::_id_C48A("thermiteBoltStuck", 0);
    }

    var_2--;
    wait 0.25;
  }
}

_id_F0F3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(var_0._id_F103) || var_0._id_F103 != "thermite_bolt_radius_mp") {
    return 1;
  }

  if(!isDefined(var_0._id_EA8F) || var_0._id_EA8F != var_2) {
    return 1;
  }

  return 0;
}

_id_F100(var_0) {
  var_0 endon("entitydeleted");
  wait 4.5;

  if(!var_0 _id_FF46()) {
    return;
  }
  var_0 setscriptablepartstate("effects", "burnEnd");
  wait(randomfloatrange(0.3, 2.0));

  if(!var_0 _id_FF46()) {
    return;
  }
  var_0 _id_25F4();
  var_0 setModel("weapon_wm_sn_crossbow_bolt_fire_static_dst");
}

_id_EAA7(var_0) {
  var_0 endon("entitydeleted");
  wait 0.5;

  if(!var_0 _id_FF46()) {
    return;
  }
  var_0 delete();
}

_id_EAB0(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isPlayer(var_0) && !isagent(var_0)) {
    return 0;
  }

  if(isDefined(var_0.team) && self.team == var_0.team) {
    return 0;
  }

  if(var_1 == "riotshield") {
    return 0;
  }

  return 1;
}

_id_E290(var_0, var_1, var_2, var_3) {
  var_4 = _id_6924(var_2);
  var_5 = spawn("script_model", var_0);
  var_5 setModel(var_4);
  var_5.angles = vectortoangles(var_1);
  var_5 _id_D50B(var_2);
  var_5.owner = self;
  var_5._id_174D = var_2;
  var_5._id_04F6 = var_3;
  var_5._id_87DB = 1;

  if(_id_DB97(var_2)) {
    var_5 = _id_9A00(var_5);
  }

  var_5 thread _id_25F1();
  _id_9A38(var_5);
  return var_5;
}

_id_DB97(var_0) {
  if(var_0 == "bolt_default" || var_0 == "bolt_stun") {
    return 1;
  }

  return 0;
}

_id_9A00(var_0) {
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 15;
  var_2 = _func_0017(anglestoup(var_0.angles), anglestoright(var_0.angles), anglesToForward(var_0.angles));
  var_3 = spawn("trigger_rotatable_radius", var_1, 0, 64, 79);
  var_3.angles = var_2;
  var_3._id_0481 = "bolt_pickup";
  var_3 _meth_80DB();
  var_3 linkto(var_0);
  var_0._id_B0B5 = var_3;
  var_0 thread _id_25EE();
  return var_0;
}

_id_C501(var_0) {
  var_0 notify("removePickup");

  if(isDefined(var_0._id_B0B5)) {
    var_0._id_B0B5 delete();
  }
}

_id_25EE() {
  self endon("entitydeleted");
  self endon("removePickup");
  wait 2;

  for(;;) {
    self._id_B0B5 waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self._id_EA8F) && isalive(self._id_EA8F)) {
      continue;
    }
    var_1 = _id_6836(var_0 getweaponslistprimaries());

    if(!isDefined(var_1)) {
      continue;
    }
    if(var_0 _id_25ED(var_1)) {
      self delete();
    }
  }
}

_id_6836(var_0) {
  foreach(var_2 in var_0) {
    if(var_2 _meth_8624("ammo_crossbow") && self._id_174D == "bolt_default") {
      return var_2;
    }

    if(var_2 _meth_8624("boltstun_crossbow") && self._id_174D == "bolt_stun") {
      return var_2;
    }
  }

  return undefined;
}

_id_25ED(var_0) {
  var_1 = weaponmaxammo(var_0);
  var_2 = self getweaponammostock(var_0);

  if(var_2 >= var_1) {
    return 0;
  }

  var_3 = int(min(var_1, var_2 + 1));
  self setweaponammostock(var_0, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "hudIconType")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "hudIconType")]]("crossbowbolt");
  }

  return 1;
}

_id_D50B(var_0) {
  switch (var_0) {
    case "bolt_fire":
      thread _id_D50C(5);
      self._id_4759 = 0;
      break;
    case "bolt_explo":
      self._id_4759 = 0;
      break;
    case "bolt_stun":
      thread _id_D50C(0.5);
      self._id_4759 = 0;
      break;
    default:
      self._id_4759 = 1;
  }
}

_id_D50C(var_0) {
  self endon("entitydeleted");
  wait(var_0);
  self._id_4759 = 1;
  _id_9A38();
}

_id_9A38(var_0) {
  if(isDefined(var_0)) {
    var_1 = [var_0];
  } else {
    var_1 = [];
  }

  foreach(var_3 in level._id_4097) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3)) {
      if(var_1.size >= 24 && var_3._id_4759) {
        var_3 delete();
        continue;
      }

      var_1[var_1.size] = var_3;
    }
  }

  level._id_4097 = var_1;
}

_id_6999(var_0) {
  var_1 = "";

  foreach(var_3 in var_0._id_0070) {
    if(issubstr(var_3, "bolt")) {
      var_1 = var_3;
      break;
    }
  }

  switch (var_1) {
    case "boltcarbon_crossbow":
      return "bolt_carbon";
    case "boltexplo_crossbow":
      return "bolt_explo";
    case "boltfire_crossbow":
      return "bolt_fire";
    case "boltstun_crossbow":
      return "bolt_stun";
    default:
      return "bolt_default";
  }
}

_id_699A(var_0) {
  switch (var_0) {
    case "bolt_carbon":
      return::_id_7D4F;
    case "bolt_explo":
      return::_id_7D50;
    case "bolt_fire":
      return::_id_7D51;
    case "bolt_stun":
      return::_id_7D52;
    default:
      return;
  }
}

_id_6924(var_0) {
  switch (var_0) {
    case "bolt_carbon":
      return "weapon_wm_sn_crossbow_bolt_carbon_static";
    case "bolt_explo":
      return "weapon_wm_sn_crossbow_bolt_explosive_static";
    case "bolt_fire":
      return "weapon_wm_sn_crossbow_bolt_fire_static";
    case "bolt_stun":
      return "weapon_wm_sn_crossbow_bolt_stun_static";
    default:
      return "weapon_wm_sn_crossbow_bolt_static";
  }
}

_id_DBC3(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "glass_solid":
    case "glass_pane":
      return 1;
  }

  if(var_1._id_174D == "bolt_explo") {
    return 0;
  }

  if(_id_8A13(var_2)) {
    return 1;
  }

  if(_id_8A12(var_2)) {
    return 1;
  }

  switch (var_0) {
    case "asphalt_wet":
    case "asphalt_dry":
    case "riotshield":
      return 1;
    case "metal_car":
    case "metal_tank":
    case "metal_helicopter":
    case "metal_thin":
    case "metal_thick":
    case "metal_grate":
      if(var_1._id_174D == "bolt_fire") {
        return 0;
      } else {
        return 1;
      }
    default:
      return 0;
  }
}

_id_C198(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\math::_id_FFDD(var_2, var_1);
  var_5 = abs(vectordot(var_2, var_1));
  var_6 = scripts\engine\math::_id_5898(2300, 1000, var_5);
  var_4 = var_4 * var_6;
  var_0 physicslaunchserver(var_3, var_4);
}

_id_DB1E(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isagent(var_0) && var_0 _id_86DA() && !isalive(var_0) && !isDefined(var_0 _meth_8122())) {
    return 1;
  }

  return 0;
}

_id_DB80(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return 1;
}

_id_86DA() {
  return istrue(isDefined(self._id_04B9) && self._id_04B9 == "suicidebomber");
}

_id_9515(var_0, var_1, var_2) {
  if((isPlayer(var_1) || isagent(var_1)) && !isalive(var_1)) {
    var_3 = var_1 _meth_8122();

    if(isDefined(var_3)) {
      var_1 = var_3;
    }
  }

  if(isPlayer(var_1) && var_0._id_174D != "bolt_stun") {
    var_0 hidefromplayer(var_1);

    if(isDefined(var_0._id_B0B5)) {
      var_0._id_B0B5 hidefromplayer(var_1);
    }
  }

  if(isDefined(var_2)) {
    var_0 linkto(var_1, var_2);
  } else {
    var_0 linkto(var_1);
  }

  if(isPlayer(var_1) || isagent(var_1) || var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5() || isDefined(var_1.classname) && var_1.classname == "misc_turret") {
    var_0._id_EA8F = var_1;
    var_0 thread _id_C52B(var_1);
  }

  var_0 notsolid();
  var_0 thread _id_25F5(var_1);
  var_0 thread _id_25F0(var_1, "vehicle_deleted");
  var_0 thread _id_25F0(var_1, "detonated");
  var_0 thread _id_25F0(var_1, "beginC130");
}

_id_FF46() {
  if(isDefined(self) && istrue(self._id_87DB)) {
    return 1;
  } else {}
}

_id_C52B(var_0) {
  self endon("entitydeleted");
  var_0 scripts\engine\utility::waittill_any_3("entitydeleted", "death", "disconnect");

  if(!_id_FF46()) {
    return;
  }
  self._id_EA8F = undefined;

  if(isDefined(var_0) && isDefined(var_0._id_A546)) {
    self delete();
  }
}

_id_25F5(var_0) {
  self endon("entitydeleted");
  var_0 scripts\engine\utility::waittill_any_2("entitydeleted", "disconnect");

  if(!_id_FF46()) {
    return;
  }
  _id_25F4();
}

_id_25F4(var_0) {
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 100);
  }

  if(self _meth_81CC()) {
    self unlink();
  }

  self solid();
  self physicslaunchserver(self.origin, var_0);
}

_id_25F0(var_0, var_1) {
  self endon("entitydeleted");
  var_0 waittill(var_1);

  if(!_id_FF46()) {
    return;
  }
  self delete();
}

_id_25F1() {
  self waittill("entitydeleted");

  if(isDefined(self._id_B0B5)) {
    self._id_B0B5 delete();
  }

  if(isDefined(self._id_0203)) {
    self._id_0203 delete();
  }
}

_id_8A13(var_0) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isEnemy")]](var_0)) {
    return 0;
  } else {
    return 1;
  }
}

_id_8A12(var_0) {
  if(!isagent(var_0)) {
    return 0;
  }

  if(isDefined(var_0._id_002E) && self.team == var_0._id_002E) {
    return 1;
  }

  return 0;
}