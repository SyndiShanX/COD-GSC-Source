/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp_mp\ptango41.gsc
*************************************************/

initusage(var_0) {
  if(!isDefined(level.ptango41projectiles)) {
    level.ptango41projectiles = [];
  }
}

usageloop(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  var_1 = getptango41ammotype(var_0);

  if(var_1 == "mag_ptango41") {
    return;
  }
  var_2 = getptango41impactfunc(var_1);
  thread impactwatcher(var_0, var_1, var_2);
}

_id_386E() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupPTANGO41ImpactWatcher");
}

impactwatcher(var_0, var_1, var_2) {
  self notify("cleanupPTANGO41ImpactWatcher");
  self endon("disconnect");
  self endon("cleanupPTANGO41ImpactWatcher");
  childthread _id_386E();

  if(var_1 == "default") {
    return;
  }
  for(;;) {
    self waittill("bullet_first_impact", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_0 != var_7) {
      continue;
    }
    _id_7459(var_3, var_4, var_10, var_5, var_6, var_7, var_8, var_9, var_2, var_1);
  }
}

_id_7459(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = _id_DBC3(var_4, var_9, var_0, var_1, var_3, var_6);
  var_11 = spawnprojectile(var_7, var_6, var_9, var_5, var_10, var_3);

  if(_id_DB1E(var_0)) {
    var_11 delete();
    return;
  } else if(_id_DB80(var_0, var_10))
    _id_9515(var_11, var_0, var_1);

  if(isDefined(var_8)) {
    [[var_8]](var_11, var_0, var_1, var_2, var_4, var_10);
  }
}

_id_7D50(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_0._id_0203 = magicgrenademanual("s4_mr_ptango41_mp", var_0.origin, (0, 0, 0), var_6);
  var_0._id_0203.angles = var_0.angles;
  var_0._id_0203 linkto(var_0, "tag_origin");
  thread projectileimpactexplode(var_0, var_6, var_3);
}

_id_7D51(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread projectileimpactthermite(var_0, var_1, var_2, var_3, var_5);
}

impactfunc_null(var_0, var_1, var_2, var_3, var_4, var_5) {}

projectileimpactexplode(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_0._id_0203 scripts\engine\utility::_id_108AE(var_1, "explode");
  var_0 setscriptablepartstate("effects", "explode");
  var_3 = makeweapon("s4_mr_ptango41_mp");
  var_4 = makeweapon("s4_mr_ptango41_mp");
  _func_00FB(var_0.origin, 150, 50, 1);

  if(isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F)) {
    var_0._id_EA8F _id_09BF::_id_5ECC();
    var_0._id_EA8F dodamage(150, var_0.origin, self, self, "MOD_EXPLOSIVE", var_3, var_2);
    var_0._id_EA8F _id_09BF::_id_5ECD();
  }

  _func_0430(var_0.origin, 9, 35, 15, 25, 60, 14, self, "MOD_EXPLOSIVE", var_4);
  wait 0.4;

  if(!var_0 validateprojectileent()) {
    return;
  }
  var_0 delete();
}

projectileimpactthermite(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_0.isgrenade)) {
    var_0 setscriptablepartstate("effects", "reflectThermite");
    waitforstuck(var_0);
  }

  var_0 setscriptablepartstate("effects", "burn");
  thread thermitestuckto(var_0);
  thread thermiteradiusdamage(var_0);
  thread thermiteburnout(var_0);
}

waitforstuck(var_0) {
  var_0 endon("stuckWaitTimeout");
  var_0 thread projectilewaittilstucktimeout();
  var_0 waittill("missile_stuck", var_1, var_2);

  if(isDefined(var_1)) {
    _id_9515(var_0, var_1, var_2);
    var_0.bounceshot = 1;
  }
}

projectilewaittilstucktimeout() {
  wait 3;

  if(isDefined(self)) {
    self notify("stuckWaitTimeout");
  }
}

thermitestuckto(var_0) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_1 = makeweapon("thermite_PTANGO41_mp");
  var_1._id_AE61 = var_0._id_04F6;

  if(isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F)) {
    if(var_0._id_EA8F scripts\cp_mp\vehicles\vehicle::_id_8AF5() || isDefined(var_0._id_EA8F.classname) && var_0._id_EA8F.classname == "misc_turret") {
      var_2 = 0.95;
    } else {
      var_2 = 0.25;
    }

    if(istrue(var_0.bounceshot)) {
      var_0._id_EA8F dodamage(80, var_0.origin, self, var_0, "MOD_FIRE", var_1);
    }

    var_3 = int(3.0 / var_2);

    while(isDefined(var_0) && isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F) && var_3 >= 0) {
      var_0._id_EA8F _id_09BF::_id_5ECC();
      var_0._id_EA8F dodamage(3, var_0.origin, self, var_0, "MOD_FIRE", var_1);
      var_0._id_EA8F _id_09BF::_id_5ECD();
      var_3--;
      wait(var_2);
    }
  }
}

thermiteradiusdamage(var_0) {
  self endon("disconnect");
  var_0 endon("entitydeleted");
  var_1 = int(12.0);
  var_2 = makeweapon("thermite_PTANGO41_radius_mp");
  var_2._id_AE61 = var_0._id_04F6;
  var_0._id_F103 = var_2.basename;

  while(var_1 > 0) {
    if(isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F)) {
      var_0._id_EA8F _id_09BF::_id_10A2("thermite25mmStuck", 0, 0, ::_id_F0F3);
    }

    var_0 radiusdamage(var_0.origin, 50, 2, 2, self, "MOD_FIRE", var_2);

    if(isDefined(var_0._id_EA8F) && isalive(var_0._id_EA8F)) {
      var_0._id_EA8F _id_09BF::_id_C48A("thermite25mmStuck", 0);
    }

    var_1--;
    wait 0.25;
  }
}

_id_F0F3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(var_0._id_F103) || var_0._id_F103 != "thermite_PTANGO41_radius_mp") {
    return 1;
  }

  if(!isDefined(var_0._id_EA8F) || var_0._id_EA8F != var_2) {
    return 1;
  }

  return 0;
}

thermiteburnout(var_0) {
  var_0 endon("entitydeleted");
  wait 3.0;

  if(!var_0 validateprojectileent()) {
    return;
  }
  var_0 setscriptablepartstate("effects", "burnout");
  var_0 setscriptablepartstate("visibility", "hide");
  wait(randomfloatrange(0.3, 2.0));

  if(!var_0 validateprojectileent()) {
    return;
  }
  wait(randomfloatrange(2, 3));
  var_0 delete();
}

spawnprojectile(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_4 && var_2 == "thermal") {
    var_6 = reflectprojectile(var_5, var_1, var_0, 1);
    var_7 = var_0 + var_5 * 10;
    var_8 = magicgrenademanual("PTANGO41_grenade", var_7, var_6, 10);
    var_8.isgrenade = 1;
    playFX(scripts\engine\utility::getfx("PTANGO41ThermiteBounce"), var_0, var_5);
  } else {
    var_8 = spawn("script_model", var_0);
    var_8 setModel("weapon_wm_mr_ptango41_exp_static");
    var_8.origin = var_0;

    if(var_4) {
      var_6 = reflectprojectile(var_5, var_1, var_0, 0);
      var_8 physicslaunchserver(var_0, var_6);
    }
  }

  var_8.angles = vectortoangles(var_1);
  var_8 _id_D50B(var_2);
  var_8.owner = self;
  var_8._id_174D = var_2;
  var_8._id_04F6 = var_3;
  var_8.isptango41projectile = 1;
  var_8 thread projectiledeletethread();
  manageworldspawnedprojectiles(var_8);
  return var_8;
}

_id_D50B(var_0) {
  switch (var_0) {
    case "thermal":
      thread _id_D50C(3.5);
      self._id_4759 = 0;
      break;
    case "explosive":
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
  manageworldspawnedprojectiles();
}

manageworldspawnedprojectiles(var_0) {
  if(isDefined(var_0)) {
    var_1 = [var_0];
  } else {
    var_1 = [];
  }

  foreach(var_3 in level.ptango41projectiles) {
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

  level.ptango41projectiles = var_1;
}

getptango41ammotype(var_0) {
  var_1 = "";

  foreach(var_3 in var_0._id_0070) {
    if(issubstr(var_3, "ammo_explosive")) {
      var_1 = "ammo_explosive_ptango41";
      break;
    }

    if(issubstr(var_3, "calcust2")) {
      var_1 = "calcust2_ptango41";
      break;
    }
  }

  switch (var_1) {
    case "calcust2_ptango41":
      return "thermal";
    case "ammo_explosive_ptango41":
      return "explosive";
    default:
      return "default";
  }
}

getptango41impactfunc(var_0) {
  switch (var_0) {
    case "thermal":
      return::_id_7D51;
    case "explosive":
      return::_id_7D50;
    default:
      return::impactfunc_null;
  }
}

_id_DBC3(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  if(var_0 == "riotshield") {
    return 1;
  }

  if(var_1 != "thermal") {
    return 0;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(_id_8A13(var_2) || _id_8A12(var_2)) {
    return 1;
  }

  if(isenemyteamplayer(var_2) || isenemyteamagent(var_2)) {
    return 0;
  }

  if(isDefined(var_2)) {
    if(var_2 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
      return 0;
    }

    if(isDefined(var_2._id_5562) && var_2._id_5562 == "equip_tac_cover") {
      return 0;
    }
  }

  switch (var_0) {
    case "glass_solid":
    case "glass_pane":
    case "riotshield":
      return 1;
    default:
      var_6 = abs(vectordot(var_5, var_4));

      if(var_6 < 0.2) {
        return 1;
        return;
      }

      return 0;
      return;
  }
}

reflectprojectile(var_0, var_1, var_2, var_3) {
  if(var_3) {
    var_4 = 1500;
    var_5 = 500;
    var_6 = 150;
  } else {
    var_4 = 500;
    var_5 = 500;
    var_6 = 500;
  }

  var_7 = scripts\engine\math::_id_FFDD(var_1, var_0);
  var_7 = _func_025E(var_7, var_0, 0.2);
  var_8 = abs(vectordot(var_1, var_0));

  if(var_8 < 0.2) {
    var_8 = scripts\engine\math::_id_A5C5(0, 0.2, var_8);
    var_9 = scripts\engine\math::_id_5898(var_4, var_5, var_8);
  } else {
    var_8 = scripts\engine\math::_id_A5C5(0.2, 1, var_8);
    var_9 = scripts\engine\math::_id_5898(var_5, var_6, var_8);
  }

  var_7 = var_7 * var_9;
  return var_7;
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

_id_DB80(var_0, var_1) {
  if(var_1 || !isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0.classname) && var_0.classname == "weapon_scavenger_bag_mp") {
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

  if(isPlayer(var_1)) {
    var_0 hidefromplayer(var_1);
  }

  if(isDefined(var_2)) {
    var_0 linkto(var_1, var_2);
  } else {
    var_0 linkto(var_1);
  }

  if(cansticktoent(var_1)) {
    var_0._id_EA8F = var_1;
    var_0 thread _id_C52B(var_1);
  }

  if(!istrue(var_0.isgrenade)) {
    var_0 notsolid();
  }

  var_0 thread projectileunlinkonnote(var_1);
  var_0 thread projectiledeleteonnote(var_1, "vehicle_deleted");
  var_0 thread projectiledeleteonnote(var_1, "detonated");
  var_0 thread projectiledeleteonnote(var_1, "beginC130");
}

validateprojectileent() {
  if(isDefined(self) && istrue(self.isptango41projectile)) {
    return 1;
  } else {}
}

_id_C52B(var_0) {
  self endon("entitydeleted");
  var_0 scripts\engine\utility::waittill_any_3("entitydeleted", "death", "disconnect");

  if(!validateprojectileent()) {
    return;
  }
  self._id_EA8F = undefined;

  if(isDefined(var_0) && isDefined(var_0._id_A546)) {
    self delete();
  }
}

projectileunlinkonnote(var_0) {
  self endon("entitydeleted");

  if(isagent(var_0)) {
    var_0 waittill("entitydeleted");
  } else {
    var_0 scripts\engine\utility::waittill_any_2("entitydeleted", "disconnect");
  }

  if(!validateprojectileent()) {
    return;
  }
  projectileunlink();
}

projectileunlink(var_0) {
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 100);
  }

  if(self _meth_81CC()) {
    self unlink();
  }

  if(!istrue(self.isgrenade)) {
    self solid();
  }

  self physicslaunchserver(self.origin, var_0);
}

projectiledeleteonnote(var_0, var_1) {
  self endon("entitydeleted");
  var_0 waittill(var_1);

  if(!validateprojectileent()) {
    return;
  }
  self delete();
}

projectiledeletethread() {
  self waittill("entitydeleted");

  if(isDefined(self._id_0203)) {
    self._id_0203 delete();
  }
}

_id_8A13(var_0) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(scripts\mp\utility\player::isenemy(var_0)) {
    return 0;
  } else {
    return 1;
  }
}

isenemyteamplayer(var_0) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(scripts\mp\utility\player::isenemy(var_0)) {
    return 1;
  } else {
    return 0;
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

isenemyteamagent(var_0) {
  if(!isagent(var_0)) {
    return 0;
  }

  if(isDefined(var_0._id_002E) && self.team == var_0._id_002E) {
    return 0;
  }

  return 1;
}

cansticktoent(var_0) {
  var_1 = 0;

  if(isPlayer(var_0) || isagent(var_0)) {
    var_1 = 1;
  }

  if(var_0 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
    var_1 = 1;
  }

  if(isDefined(var_0.classname)) {
    if(var_0.classname == "misc_turret") {
      var_1 = 1;
    }

    if(var_0.classname == "script_model") {
      if(isDefined(var_0.streakinfo) && (var_0.streakinfo.streakname == "uav" || var_0.streakinfo.streakname == "gunship")) {
        var_1 = 1;
      }
    }
  }

  if(isDefined(var_0._id_5562)) {
    if(var_0._id_5562 == "equip_tac_cover") {
      var_1 = 1;
    }
  }

  return var_1;
}