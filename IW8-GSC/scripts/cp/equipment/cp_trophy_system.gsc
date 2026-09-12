/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_trophy_system.gsc
*****************************************************/

function trophy_init() {
  var_0 = spawnStruct();
  var_0.tags = [];
  var_0.tags[0] = "j_projectile_01_base";
  var_0.tags[1] = "j_projectile_02_base";
  var_0.tags[2] = "j_projectile_03_base";
  var_0.tags[3] = "j_projectile_04_base";
  level.trophy = var_0;
}

function trophy_used(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0 waittill("missile_stuck", var_1);
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  var_0.usedcount = 0;
  var_2 = scripts\cp\utility::_hasperk("specialty_rugged_eqp");

  if(var_2) {
    var_0.hasruggedeqp = 1;
  }

  var_0.ammo = trophy_removestored();

  if(!isDefined(var_0.ammo)) {
    var_0.ammo = 2;
  }

  scripts\cp\cp_weapon::ontacticalequipmentplanted(var_0, "equip_trophy");
  thread scripts\cp\cp_weapon::monitordisownedequipment(self, var_0);
  var_0.explosion = trophy_createexplosion(var_0);
  var_3 = scripts\engine\utility::ter_op(var_2, 200, 100);
  var_4 = scripts\engine\utility::ter_op(var_2, "hitequip", "");
  var_0 thread scripts\cp\cp_weapon::monitordamage(var_3, var_4, &trophy_handlefataldamage, &trophy_handledamage, 0);
  thread trophy_destroyonemp();
  thread trophy_destroyongameend();
  thread trophy_watchprotection();
  var_0 missilethermal();
  var_0 missileoutline();
  thread trophy_deploysequence();
}

function trophy_destroy(var_0) {
  var_0 = istrue(var_0);
  var_1 = 0.1;

  if(var_0) {
    var_1 += 0.5;
  }

  thread trophy_delete(var_1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);

  if(var_0) {
    wait 0.5;
  }

  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

function trophy_delete(var_0) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    scripts\cp\cp_weapon::makeexplosiveunusuabletag();
  }

  self.exploding = 1;
  var_1 = self.owner;

  if(isDefined(self.owner) && !istrue(self.issuper)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);
    }

    var_1.plantedtacticalequip = scripts\engine\utility::array_remove(var_1.plantedtacticalequip, self);
    var_1 notify("trophy_update", 0);
  } else if(isDefined(self.owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);
    }

    var_1.activesupertrophies = scripts\engine\utility::array_remove(var_1.activesupertrophies, self);
    var_1 notify("trophy_update", 0);
  }

  wait var_0;
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

  if(!isDefined(level.ref_11D34)) {
    level.ref_11D34 = [];
  }

  var_0 = trophy_castcontents();

  for(;;) {
    var_1 = trophy_castorigin();
    var_2 = [];
    var_2 = level.grenades;
    var_2 = level.missiles;
    var_2 = level.mines;
    var_2 = level.ref_11D34;
    var_3 = scripts\engine\utility::array_combine_multiple(var_2);

    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }

      if(istrue(var_5.exploding)) {
        continue;
      }

      if(trophy_checkignorelist(var_5)) {
        continue;
      }

      var_6 = var_5.owner;

      if(!isDefined(var_6) && isDefined(var_5.weapon_name) && weaponclass(var_5.weapon_name) == "grenade") {
        var_6 = getmissileowner(var_5);
      }

      if(isDefined(var_6) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_6))) {
        continue;
      }

      if(distancesquared(var_5.origin, self.origin) > trophy_modifiedprotectiondistsqr(var_5, 65536)) {
        continue;
      }

      var_7 = physics_raycast(var_1, var_5.origin, var_0, [self, var_5], 0, "physicsquery_closest");

      if(isDefined(var_7) && var_7.size > 0) {
        continue;
      }

      trophy_protectionsuccessful(var_5);
    }

    waitframe();
  }
}

function trophy_protectionsuccessful(var_0) {
  var_0 setCanDamage(0);
  var_0.exploding = 1;
  var_0 stopsounds();
  trophy_startcooldownlist(var_0);
  trophy_notifytrophytargetowner(var_0, "trophy_mp", self.owner);
  var_1 = var_0.origin;
  var_2 = var_0.angles;

  if(scripts\cp\cp_weapon::isplantedequipment(var_0)) {
    var_0 scripts\cp\cp_weapon::deleteexplosive();
  } else {
    var_0 delete();
  }

  var_3 = trophy_getbesttag(var_1);
  var_4 = trophy_getpartbytag(var_3);
  self setscriptablepartstate(var_4, "active", 0);
  thread trophy_explode(self.explosion, var_1);
  self.usedcount++;
  self.ammo--;

  if(self.ammo <= 0) {
    thread trophy_destroy(1);
    return;
  }
}

function trophy_handledamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_4;
  return var_5;
}

function trophy_handlefataldamage(var_0) {
  var_1 = var_0.attacker;
  trophy_givepointsfordeath(var_1);
  thread trophy_destroy();
}

function trophy_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", var_0);
  var_1 = var_0.attacker;
  trophy_givepointsfordeath(var_1);
  trophy_givedamagefeedback(var_1);
  thread trophy_destroy(1);
}

function trophy_destroyongameend() {
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::ref_143A5("game_ended", "bro_shot_start");
  thread trophy_destroy();
}

function trophy_pickup() {
  if(self.owner scripts\cp\cp_equipment::hasequipment("equip_trophy")) {
    trophy_addstored(self.owner, self.ammo);
    return;
  }
}

function trophy_createexplosion(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.killcament = var_0;
  var_1.owner = var_0.owner;
  var_1.team = var_0.team;
  var_1.equipmentref = var_0.equipmentref;
  var_1.weapon_name = var_0.weapon_name;
  var_1 setotherent(var_1.owner);
  var_1 setentityowner(var_1.owner);
  var_1 setModel("trophy_system_mp_explode");
  var_1.explode1available = 1;
  var_1.explode2available = 1;
  thread trophy_cleanuponparentdeath(var_1, var_0);
  return var_1;
}

function trophy_explode(var_0, var_1) {
  self dontinterpolate();
  self.origin = var_0;
  self.angles = var_1;

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

function trophy_modifiedprotectiondistsqr(var_0, var_1) {
  if(isDefined(var_0.weapon_name) && isDefined(var_0.owner)) {
    switch (var_0.weapon_name) {
      case "switch_blade_child_mp":
      case "jackal_cannon_mp":
      case "drone_hive_projectile_mp":
        if(147456 > var_1) {
          var_1 = 147456;
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
        if(65536 > var_1) {
          var_1 = 65536;
        }

        break;
    }
  }

  return var_1;
}

function trophy_checkignorelist(var_0) {
  var_1 = var_0.weapon_name;

  if(!isDefined(var_1) && isDefined(var_0.weapon_object)) {
    var_1 = var_0.weapon_object.basename;
  }

  if(isDefined(var_1)) {
    if(scripts\cp\utility::iskillstreakweapon(var_1)) {
      return true;
    }

    switch (var_1) {
      case "trophy_mp":
        if(scripts\cp\cp_weapon::isplantedequipment(var_0)) {
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

function trophy_startcooldownlist(var_0) {
  if(getdvarint("showArchetypes", 0) > 0) {
    return;
  }
}

function trophy_notifytrophytargetowner(var_0, var_1, var_2) {
  if(!isDefined(var_0.owner) || !isPlayer(var_0.owner)) {
    return;
  }

  var_0.owner thread scripts\cp\cp_damagefeedback::updatedamagefeedback("hittrophysystem");

  if(isDefined(var_0.weapon_name)) {
    switch (var_0.weapon_name) {
      case "switch_blade_child_mp":
      case "jackal_cannon_mp":
      case "drone_hive_projectile_mp":
        var_0.owner notify("destroyed_by_trophy", var_2, var_1, var_0.weapon_name, var_0.origin, var_0.angles);
        break;
    }

    return;
  }
}

function trophy_getbesttag(var_0) {
  var_1 = level.trophy.tags;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = self gettagangles(var_5);
    var_8 = anglesToForward(var_7);
    var_9 = vectordot(vectorNormalize(var_0 - var_6), var_8);

    if(var_10 == 0 || var_9 > var_2) {
      var_2 = var_9;
      var_3 = var_5;
    }
  }

  return var_3;
}

function trophy_getpartbytag(var_0) {
  var_1 = level.trophy.tags;

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return ("protect" + var_4 + 1);
    }
  }

  return undefined;
}

function trophy_givepointsfordeath(var_0) {}

function trophy_givedamagefeedback(var_0) {
  var_1 = "";

  if(istrue(self.hasruggedeqp)) {
    var_1 = "hitequip";
  }

  if(isPlayer(var_0)) {
    var_0 scripts\cp\cp_damagefeedback::updatedamagefeedback(var_1);
    return;
  }
}

function trophy_addstored(var_0) {
  if(!isDefined(self.trophies)) {
    self.trophies = [];
  }

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(var_0)) {
      var_0 = 2;
    }

    self.trophies[self.trophies.size] = var_0;
    return;
  }
}

function trophy_removestored() {
  if(isDefined(self.trophies) && self.trophies.size > 0) {
    var_0 = self.trophies[self.trophies.size - 1];
    self.trophies[self.trophies.size - 1] = undefined;
    return var_0;
  }

  return undefined;
}

function trophy_clearstored() {
  self.trophies = undefined;
}

function trophy_populatestored() {
  var_0 = 4;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    trophy_addstored();
  }
}

function trophy_maxstored() {
  return 4;
}

function trophy_modifieddamage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    return [var_3, var_4];
  }

  if(var_3 == 0) {
    return [var_3, var_4];
  }

  var_5 = undefined;

  if(level.hardcoremode) {
    switch (var_2) {
      case "super_trophy_mp":
      case "player_trophy_system_mp":
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

function trophy_cleanuponparentdeath(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  wait var_1;
  self delete();
}