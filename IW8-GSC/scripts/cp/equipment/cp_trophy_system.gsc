/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_trophy_system.gsc
*****************************************************/

function trophy_init() {
  var0 = spawnStruct();
  var0.tags = [];
  var0.tags[0] = "j_projectile_01_base";
  var0.tags[1] = "j_projectile_02_base";
  var0.tags[2] = "j_projectile_03_base";
  var0.tags[3] = "j_projectile_04_base";
  level.trophy = var0;
}

function trophy_used(var0) {
  var0 endon("death");
  self endon("disconnect");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var0);
  var0 waittill("missile_stuck", var1);
  var0 setotherent(self);
  var0 setnodeploy(1);
  var0.usedcount = 0;
  var2 = scripts\cp\utility::_hasperk("specialty_rugged_eqp");

  if(var2) {
    var0.hasruggedeqp = 1;
  }

  var0.ammo = trophy_removestored();

  if(!isDefined(var0.ammo)) {
    var0.ammo = 2;
  }

  scripts\cp\cp_weapon::ontacticalequipmentplanted(var0, "equip_trophy");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var0);
  var0.explosion = trophy_createexplosion(var0);
  var3 = scripts\engine\utility::ter_op(var2, 200, 100);
  var4 = scripts\engine\utility::ter_op(var2, "hitequip", "");
  var0 thread scripts\cp\cp_weapon::monitordamage(var3, var4, &trophy_handlefataldamage, &trophy_handledamage, 0);
  thread trophy_destroyonemp();
  thread trophy_destroyongameend();
  thread trophy_watchprotection();
  var0 missilethermal();
  var0 missileoutline();
  thread trophy_deploysequence();
}

function trophy_destroy(var0) {
  var0 = istrue(var0);
  var1 = 0.1;

  if(var0) {
    var1 += 0.5;
  }

  thread trophy_delete(var1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);

  if(var0) {
    wait 0.5;
  }

  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

function trophy_delete(var0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  }

  self.exploding = 1;
  var1 = self.owner;

  if(isDefined(self.owner) && !istrue(self.issuper)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
      var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);
    }

    var1.plantedtacticalequip = scripts\engine\utility::array_remove(var1.plantedtacticalequip, self);
    var1 notify("trophy_update", 0);
  } else if(isDefined(self.owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
      var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);
    }

    var1.activesupertrophies = scripts\engine\utility::array_remove(var1.activesupertrophies, self);
    var1 notify("trophy_update", 0);
  }

  wait var0;
  self delete();
}

function trophy_deploysequence() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait 1.25;
  self setscriptablepartstate("effects", "activeDeployEnd");
}

function trophy_watchprotection() {
  self endon("death");
  self.owner endon("disconnect");

  if(!isDefined(level.grenades)) {
    level.grenades = [];
  }

  if(!isDefined(level.missiles)) {
    level.missiles = [];
  }

  if(!isDefined(level.mines)) {
    level.mines = [];
  }

  if(!isDefined(level.ref_11d34)) {
    level.ref_11d34 = [];
  }

  var0 = trophy_castcontents();

  for(;;) {
    var1 = trophy_castorigin();
    var2 = [];
    var2 = level.grenades;
    var2 = level.missiles;
    var2 = level.mines;
    var2 = level.ref_11d34;
    var3 = scripts\engine\utility::array_combine_multiple(var2);

    foreach(var5 in var3) {
      if(!isDefined(var5)) {
        continue;
      }

      if(istrue(var5.exploding)) {
        continue;
      }

      if(trophy_checkignorelist(var5)) {
        continue;
      }

      var6 = var5.owner;

      if(!isDefined(var6) && isDefined(var5.weapon_name) && weaponclass(var5.weapon_name) == "grenade") {
        var6 = getmissileowner(var5);
      }

      if(isDefined(var6) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var6))) {
        continue;
      }

      if(distancesquared(var5.origin, self.origin) > trophy_modifiedprotectiondistsqr(var5, 65536)) {
        continue;
      }

      var7 = physics_raycast(var1, var5.origin, var0, [self, var5], 0, "physicsquery_closest");

      if(isDefined(var7) && var7.size > 0) {
        continue;
      }

      trophy_protectionsuccessful(var5);
    }

    waitframe();
  }
}

function trophy_protectionsuccessful(var0) {
  var0 setCanDamage(0);
  var0.exploding = 1;
  var0 stopsounds();
  trophy_startcooldownlist(var0);
  trophy_notifytrophytargetowner(var0, "trophy_mp", self.owner);
  var1 = var0.origin;
  var2 = var0.angles;

  if(scripts\cp\cp_weapon::isplantedequipment(var0)) {
    var0 scripts\cp\cp_weapon::deleteexplosive();
  } else {
    var0 delete();
  }

  var3 = trophy_getbesttag(var1);
  var4 = trophy_getpartbytag(var3);
  self setscriptablepartstate(var4, "active", 0);
  thread trophy_explode(self.explosion, var1);
  self.usedcount++;
  self.ammo--;

  if(self.ammo <= 0) {
    thread trophy_destroy(1);
    return;
  }
}

function trophy_handledamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var4;
  return var5;
}

function trophy_handlefataldamage(var0) {
  var1 = var0.attacker;
  trophy_givepointsfordeath(var1);
  thread trophy_destroy();
}

function trophy_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", var0);
  var1 = var0.attacker;
  trophy_givepointsfordeath(var1);
  trophy_givedamagefeedback(var1);
  thread trophy_destroy(1);
}

function trophy_destroyongameend() {
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::ref_143a5("game_ended", "bro_shot_start");
  thread trophy_destroy();
}

function trophy_pickup() {
  if(self.owner scripts\cp\cp_equipment::hasequipment("equip_trophy")) {
    trophy_addstored(self.owner, self.ammo);
    return;
  }
}

function trophy_createexplosion(var0) {
  var1 = spawn("script_model", var0.origin);
  var1.killcament = var0;
  var1.owner = var0.owner;
  var1.team = var0.team;
  var1.equipmentref = var0.equipmentref;
  var1.weapon_name = var0.weapon_name;
  var1 setotherent(var1.owner);
  var1 setentityowner(var1.owner);
  var1 setModel("trophy_system_mp_explode");
  var1.explode1available = 1;
  var1.explode2available = 1;
  thread trophy_cleanuponparentdeath(var1, var0);
  return var1;
}

function trophy_explode(var0, var1) {
  self dontinterpolate();
  self.origin = var0;
  self.angles = var1;

  if(self.explode1available) {
    self setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
    return;
  }

  if(self.explode2available) {
    self setscriptablepartstate("explode2", "activeDirectional", 0);
    self.explode1available = 0;
    return;
  }
}

function trophy_castorigin() {
  return self.origin + anglestoup(self.angles) * 45;
}

function trophy_castcontents() {
  return physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
}

function trophy_modifiedprotectiondistsqr(var0, var1) {
  if(isDefined(var0.weapon_name) && isDefined(var0.owner)) {
    switch (var0.weapon_name) {
      case "switch_blade_child_mp":
      case "jackal_cannon_mp":
      case "drone_hive_projectile_mp":
        if(147456 > var1) {
          var1 = 147456;
        }

        break;
      case "iw7_arclassic_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_kgolf_mp":
      case "pop_rocket_proj_mp":
      case "iw8_la_juliet_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
      case "iw8_la_mike32_mp":
        if(65536 > var1) {
          var1 = 65536;
        }

        break;
    }
  }

  return var1;
}

function trophy_checkignorelist(var0) {
  var1 = var0.weapon_name;

  if(!isDefined(var1) && isDefined(var0.weapon_object)) {
    var1 = var0.weapon_object.basename;
  }

  if(isDefined(var1)) {
    if(scripts\cp\utility::iskillstreakweapon(var1)) {
      return true;
    }

    switch (var1) {
      case "trophy_mp":
        if(scripts\cp\cp_weapon::isplantedequipment(var0)) {
          return true;
        }

        break;
      case "snapshot_grenade_danger_mp":
      case "uplinkball_tracking_mp":
      case "micro_turret_mp":
      case "at_mine_ap_mp":
      case "lighttank_mp":
      case "pop_rocket_mp":
      case "throwingknife_mp":
        return true;
    }
  }

  return false;
}

function trophy_startcooldownlist(var0) {
  if(getdvarint("showArchetypes", 0) > 0) {
    return;
  }
}

function trophy_notifytrophytargetowner(var0, var1, var2) {
  if(!isDefined(var0.owner) || !isPlayer(var0.owner)) {
    return;
  }

  var0.owner thread scripts\cp\cp_damagefeedback::updatedamagefeedback("hittrophysystem");

  if(isDefined(var0.weapon_name)) {
    switch (var0.weapon_name) {
      case "switch_blade_child_mp":
      case "jackal_cannon_mp":
      case "drone_hive_projectile_mp":
        var0.owner notify("destroyed_by_trophy", var2, var1, var0.weapon_name, var0.origin, var0.angles);
        break;
    }

    return;
  }
}

function trophy_getbesttag(var0) {
  var1 = level.trophy.tags;
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var1) {
    var6 = self gettagorigin(var5);
    var7 = self gettagangles(var5);
    var8 = anglesToForward(var7);
    var9 = vectordot(vectorNormalize(var0 - var6), var8);

    if(var10 == 0 || var9 > var2) {
      var2 = var9;
      var3 = var5;
    }
  }

  return var3;
}

function trophy_getpartbytag(var0) {
  var1 = level.trophy.tags;

  foreach(var3 in var1) {
    if(var3 == var0) {
      return ("protect" + var4 + 1);
    }
  }

  return undefined;
}

function trophy_givepointsfordeath(var0) {}

function trophy_givedamagefeedback(var0) {
  var1 = "";

  if(istrue(self.hasruggedeqp)) {
    var1 = "hitequip";
  }

  if(isPlayer(var0)) {
    var0 scripts\cp\cp_damagefeedback::updatedamagefeedback(var1);
    return;
  }
}

function trophy_addstored(var0) {
  if(!isDefined(self.trophies)) {
    self.trophies = [];
  }

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(var0)) {
      var0 = 2;
    }

    self.trophies[self.trophies.size] = var0;
    return;
  }
}

function trophy_removestored() {
  if(isDefined(self.trophies) && self.trophies.size > 0) {
    var0 = self.trophies[self.trophies.size - 1];
    self.trophies[self.trophies.size - 1] = undefined;
    return var0;
  }

  return undefined;
}

function trophy_clearstored() {
  self.trophies = undefined;
}

function trophy_populatestored() {
  var0 = 4;

  for(var1 = 0; var1 < var0; var1++) {
    trophy_addstored();
  }
}

function trophy_maxstored() {
  return 4;
}

function trophy_modifieddamage(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    return [var3, var4];
  }

  if(var3 == 0) {
    return [var3, var4];
  }

  var5 = undefined;

  if(level.hardcoremode) {
    switch (var2) {
      case "super_trophy_mp":
      case "player_trophy_system_mp":
      case "trophy_mp":
        var5 = 20;
        break;
    }
  }

  var6 = var4;

  if(isDefined(var5)) {
    var6 = var5 - var3;
  }

  var6 = min(var6, var4);
  return [var3, var4];
}

function trophy_cleanuponparentdeath(var0, var1) {
  self endon("death");
  var0 waittill("death");
  wait var1;
  self delete();
}