/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\equipment\cp_trophy_system.gsc
********************************************************/

#using scripts\common\utility;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\damagefeedback;
#using scripts\cp\equipment;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace cp_trophy_system;

function trophy_init() {
  levelstruct = spawnStruct();
  levelstruct.tags = [];
  levelstruct.tags[0] = "j_projectile_01_base";
  levelstruct.tags[1] = "j_projectile_02_base";
  levelstruct.tags[2] = "j_projectile_03_base";
  levelstruct.tags[3] = "j_projectile_04_base";
  level.trophy = levelstruct;
}

function trophy_used(grenade) {
  grenade endon("death");
  self endon("disconnect");
  thread monitordisownedequipment(self, grenade);
  grenade waittill("missile_stuck", stuckto);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade.usedcount = 0;
  var_307667d0142f2035 = _hasperk("specialty_rugged_eqp");

  if(var_307667d0142f2035) {
    grenade.hasruggedeqp = 1;
  }

  grenade.ammo = trophy_removestored();

  if(!isDefined(grenade.ammo)) {
    grenade.ammo = 2;
  }

  ontacticalequipmentplanted(grenade, "equip_trophy");
  thread monitordisownedequipment(self, grenade);
  grenade.explosion = trophy_createexplosion(grenade);
  maxhealth = ter_op(var_307667d0142f2035, 200, 100);
  damagefeedback = ter_op(var_307667d0142f2035, "hitequip", "");
  grenade thread scripts\cp\weapon::monitordamage(maxhealth, damagefeedback, &trophy_handlefataldamage, &trophy_handledamage, 0);
  grenade thread trophy_destroyonemp();
  grenade thread trophy_destroyongameend();
  grenade thread trophy_watchprotection();
  grenade missilethermal();
  grenade missileoutline();
  grenade thread trophy_deploysequence();
}

function trophy_destroy(usedelay) {
  usedelay = istrue(usedelay);
  deletiondelay = 0.1;

  if(usedelay) {
    deletiondelay += 0.5;
  }

  thread trophy_delete(deletiondelay);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);

  if(usedelay) {
    wait 0.5;
  }

  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

function trophy_delete(deletiondelay) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    makeexplosiveunusuabletag();
  }

  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && !istrue(self.issuper)) {
    if(scripts\engine\utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
      owner[[scripts\engine\utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);
    }

    owner.plantedtacticalequip = array_remove(owner.plantedtacticalequip, self);
    owner notify("trophy_update", 0);
  } else if(isDefined(self.owner)) {
    if(scripts\engine\utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd")) {
      owner[[scripts\engine\utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);
    }

    owner.activesupertrophies = array_remove(owner.activesupertrophies, self);
    owner notify("trophy_update", 0);
  }

  wait deletiondelay;
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

  if(!isDefined(level.mortars)) {
    level.mortars = [];
  }

  trophy_castcontents = trophy_castcontents();

  while(true) {
    castorigin = trophy_castorigin();
    arr2d = [];
    arr2d[0] = level.grenades;
    arr2d[1] = level.missiles;
    arr2d[2] = level.mines;
    arr2d[3] = level.mortars;
    trophytargets = scripts\engine\utility::array_combine_multiple(arr2d);

    foreach(trophytarget in trophytargets) {
      if(!isDefined(trophytarget)) {
        continue;
      }

      if(istrue(trophytarget.exploding)) {
        continue;
      }

      if(trophy_checkignorelist(trophytarget)) {
        continue;
      }

      trophytargetowner = trophytarget.owner;

      if(!isDefined(trophytargetowner) && isDefined(trophytarget.vehicle)) {
        trophytargetowner = trophytarget.vehicle.owner;
      }

      if(!isDefined(trophytargetowner) && isDefined(trophytarget.weapon_name) && weaponclass(trophytarget.weapon_name) == "grenade") {
        trophytargetowner = getmissileowner(trophytarget);
      }

      if(isDefined(trophytargetowner) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, trophytargetowner))) {
        continue;
      }

      if(distancesquared(trophytarget.origin, self.origin) > trophy_modifiedprotectiondistsqr(trophytarget, 65536)) {
        continue;
      }

      castresults = physics_raycast(castorigin, trophytarget.origin, trophy_castcontents, [self, trophytarget], 0, "physicsquery_closest");

      if(isDefined(castresults) && castresults.size > 0) {
        continue;
      }

      trophy_protectionsuccessful(trophytarget);
    }

    waitframe();
  }
}

function trophy_protectionsuccessful(trophytarget) {
  trophytarget setCanDamage(0);
  trophytarget.exploding = 1;
  trophytarget stopsounds();
  trophy_startcooldownlist(trophytarget);
  trophy_notifytrophytargetowner(trophytarget, "trophy_cp", self.owner);
  explorigin = trophytarget.origin;
  var_cc29543de9737588 = trophytarget.angles;

  if(isplantedequipment(trophytarget)) {
    trophytarget deleteexplosive();
  } else {
    trophytarget delete();
  }

  tag = trophy_getbesttag(explorigin);
  part = trophy_getpartbytag(tag);
  self setscriptablepartstate(part, "active", 0);
  self.explosion thread trophy_explode(explorigin, var_cc29543de9737588);
  self.usedcount++;
  self.ammo--;

  if(self.ammo <= 0) {
    thread trophy_destroy(1);
  }
}

function trophy_handledamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  modifieddamage = damage;
  return modifieddamage;
}

function trophy_handlefataldamage(data) {
  attacker = data.attacker;
  trophy_givepointsfordeath(attacker);
  thread trophy_destroy();
}

function trophy_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", data);
  attacker = data.attacker;
  trophy_givepointsfordeath(attacker);
  trophy_givedamagefeedback(attacker);
  thread trophy_destroy(1);
}

function trophy_destroyongameend() {
  self endon("death");
  self.owner endon("disconnect");
  level waittill_any_2("game_ended", "bro_shot_start");
  thread trophy_destroy();
}

function trophy_pickup() {
  if(self.owner scripts\cp_mp\equipment::hasequipment("equip_trophy")) {
    self.owner trophy_addstored(self.ammo);
  }
}

function trophy_createexplosion(trophy) {
  explosion = spawn("script_model", trophy.origin);
  explosion.killcament = trophy;
  explosion.owner = trophy.owner;
  explosion.team = trophy.team;
  explosion.equipmentref = trophy.equipmentref;
  explosion.weapon_name = trophy.weapon_name;
  explosion setotherent(explosion.owner);
  explosion setentityowner(explosion.owner);
  explosion setModel("trophy_system_cp_explode");
  explosion.explode1available = 1;
  explosion.explode2available = 1;
  explosion thread trophy_cleanuponparentdeath(trophy, 0.1);
  return explosion;
}

function trophy_explode(position, angles) {
  self dontinterpolate();
  self.origin = position;
  self.angles = angles;

  if(self.explode1available) {
    self setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
    return;
  }

  if(self.explode2available) {
    self setscriptablepartstate("explode2", "activeDirectional", 0);
    self.explode1available = 0;
  }
}

function trophy_castorigin() {
  return self.origin + anglestoup(self.angles) * 45;
}

function trophy_castcontents() {
  return physics_createcontents(["physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item"]);
}

function trophy_modifiedprotectiondistsqr(trophytarget, protectiondistsqr) {
  if(isDefined(trophytarget.weapon_name) && isDefined(trophytarget.owner)) {
    switch (trophytarget.weapon_name) {
      case #"hash_5b1e7be1304d43db":
      case #"hash_94c7880dca9ccc3f":
      case #"hash_b23a0686850cd666":
        if(147456 > protectiondistsqr) {
          protectiondistsqr = 147456;
        }

        break;
      case #"hash_3e782fd775b72022":
      case #"hash_5cbb3a1a84d47f1d":
      case #"hash_6b9700922cc910a9":
      case #"hash_a05def7072d4e828":
      case #"hash_a9e31b8ffd42a67b":
      case #"hash_b5e9f2d6fac1a505":
      case #"hash_b833f98278746f9b":
      case #"hash_e704ecf8710c6f57":
      case #"hash_f55c20924061bd15":
        if(65536 > protectiondistsqr) {
          protectiondistsqr = 65536;
        }

        break;
    }
  }

  return protectiondistsqr;
}

function trophy_checkignorelist(trophytarget) {
  weaponname = trophytarget.weapon_name;

  if(!isDefined(weaponname) && isDefined(trophytarget.weapon_object)) {
    weaponname = trophytarget.weapon_object.basename;
  }

  if(isDefined(weaponname)) {
    if(iskillstreakweapon(weaponname)) {
      return true;
    }

    switch (weaponname) {
      case #"hash_5e1fa926a475190b":
      case #"hash_5e3fa526a48eaaa5":
        if(isplantedequipment(trophytarget)) {
          return true;
        }

        break;
      case #"hash_34f28162f0f54c6e":
      case #"hash_523f0c8fe1ead306":
      case #"hash_571e95536d9682a1":
      case #"hash_5cc52f4b3d579bc3":
      case #"hash_badacfdae124cc01":
      case #"hash_cce14c95e4764532":
      case #"hash_ffdabdde3cb352ca":
        return true;
    }
  }

  return false;
}

function trophy_startcooldownlist(trophytarget) {
  if(getdvarint(@ "hash_75adf709a3fa32eb", 0) > 0) {}
}

function trophy_notifytrophytargetowner(trophytarget, trophyweaponname, trophyowner) {
  if(!isDefined(trophytarget.owner) || !isPlayer(trophytarget.owner)) {
    return;
  }

  trophytarget.owner thread scripts\cp\damagefeedback::updatedamagefeedback("hittrophysystem");

  if(isDefined(trophytarget.weapon_name)) {
    switch (trophytarget.weapon_name) {
      case #"hash_5b1e7be1304d43db":
      case #"hash_94c7880dca9ccc3f":
      case #"hash_b23a0686850cd666":
        trophytarget.owner notify("destroyed_by_trophy", trophyowner, trophyweaponname, trophytarget.weapon_name, trophytarget.origin, trophytarget.angles);
        break;
    }
  }
}

function trophy_getbesttag(position) {
  tags = level.trophy.tags;
  bestdot = undefined;
  besttag = undefined;

  foreach(tag in tags) {
    origin = self gettagorigin(tag);
    angles = self gettagangles(tag);
    forward = anglesToForward(angles);
    dot = vectordot(vectorNormalize(position - origin), forward);

    if(id == 0 || dot > bestdot) {
      bestdot = dot;
      besttag = tag;
    }
  }

  return besttag;
}

function trophy_getpartbytag(tag) {
  tags = level.trophy.tags;

  foreach(t in tags) {
    if(t == tag) {
      return ("protect" + id + 1);
    }
  }

  return undefined;
}

function trophy_givepointsfordeath(attacker) {}

function trophy_givedamagefeedback(attacker) {
  damagefeedback = "";

  if(istrue(self.hasruggedeqp)) {
    damagefeedback = "hitequip";
  }

  if(isPlayer(attacker)) {
    attacker scripts\cp\damagefeedback::updatedamagefeedback(damagefeedback);
  }
}

function trophy_addstored(ammo) {
  if(!isDefined(self.trophies)) {
    self.trophies = [];
  }

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(ammo)) {
      ammo = 2;
    }

    self.trophies[self.trophies.size] = ammo;
  }
}

function trophy_removestored() {
  if(isDefined(self.trophies) && self.trophies.size > 0) {
    trophy = self.trophies[self.trophies.size - 1];
    self.trophies[self.trophies.size - 1] = undefined;
    return trophy;
  }

  return undefined;
}

function trophy_clearstored() {
  self.trophies = undefined;
}

function trophy_populatestored() {
  maxcharges = 4;

  for(i = 0; i < maxcharges; i++) {
    trophy_addstored();
  }
}

function trophy_maxstored() {
  return 4;
}

function trophy_modifieddamage(attacker, victim, sweapon, damage, damageadd) {
  if(!isDefined(sweapon)) {
    return [damage, damageadd];
  }

  if(damage == 0) {
    return [damage, damageadd];
  }

  damageclamp = undefined;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    switch (sweapon) {
      case #"hash_5e1fa926a475190b":
      case #"hash_5e3fa526a48eaaa5":
      case #"hash_6f08e94ea93bfaf9":
      case #"hash_f085b57dce639767":
        maxhealth = getdvarint(@ "scr_player_maxhealth", 100);
        damageclamp = 0.66 * maxhealth;
        break;
    }
  }

  var_b85ff186894ba31e = damageadd;

  if(isDefined(damageclamp)) {
    var_b85ff186894ba31e = damageclamp - damage;
  }

  var_b85ff186894ba31e = min(var_b85ff186894ba31e, damageadd);
  return [damage, var_b85ff186894ba31e];
}

function trophy_cleanuponparentdeath(parent, delay) {
  self endon("death");
  parent waittill("death");
  wait delay;
  self delete();
}