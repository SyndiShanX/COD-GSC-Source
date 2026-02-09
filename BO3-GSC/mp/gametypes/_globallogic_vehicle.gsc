/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_globallogic_vehicle.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_vehicle;
#using scripts\mp\gametypes\_globallogic_player;
#using scripts\mp\gametypes\_loadout;
#using scripts\mp\killstreaks\_killstreak_bundles;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons\_weapons;
#namespace globallogic_vehicle;

function callback_vehiclespawned(spawner) {
  self.health = self.healthdefault;
  if(issentient(self)) {
    self spawner::spawn_think(spawner);
  } else {
    vehicle::init(self);
  }
  if(isDefined(level.vehicle_main_callback)) {
    if(isDefined(level.vehicle_main_callback[self.vehicletype])) {
      self thread[[level.vehicle_main_callback[self.vehicletype]]]();
    } else if(isDefined(self.scriptvehicletype) && isDefined(level.vehicle_main_callback[self.scriptvehicletype])) {
      self thread[[level.vehicle_main_callback[self.scriptvehicletype]]]();
    }
  }
}

function callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  selfentnum = self getentitynumber();
  eattackernotself = isDefined(eattacker) && eattacker != self;
  eattackerisnotowner = isDefined(eattacker) && isDefined(self.owner) && eattacker != self.owner;
  trytododamagefeedback = !isDefined(self.nodamagefeedback) || !self.nodamagefeedback;
  if(!1 &idflags) {
    idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
  }
  self.idflags = idflags;
  self.idflagstime = gettime();
  if(game["state"] == "postgame") {
    self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
    return;
  }
  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }
  if(self weapons::should_suppress_damage(weapon, einflictor)) {
    return;
  }
  if(isDefined(self.overridevehicledamage)) {
    idamage = self[[self.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  } else if(isDefined(level.overridevehicledamage)) {
    idamage = self[[level.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  }
  assert(isDefined(idamage), "");
  if(idamage == 0) {
    return;
  }
  if(!isDefined(vdir)) {
    idflags = idflags | 4;
  }
  if(isDefined(self.maxhealth) && self.health == self.maxhealth || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
  }
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon("explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon("destructible_car");
    }
  }
  if(!idflags & 2048) {
    if(self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
      return;
    }
    if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE") {
      idamage = idamage * weapon.vehicleprojectiledamagescalar;
      idamage = int(idamage);
      if(idamage == 0) {
        return;
      }
    } else if(smeansofdeath == "MOD_GRENADE_SPLASH") {
      idamage = idamage * getvehicleunderneathsplashscalar(weapon);
      idamage = int(idamage);
      if(idamage == 0) {
        return;
      }
    }
    idamage = idamage * level.vehicledamagescalar;
    idamage = int(idamage);
    if(isPlayer(eattacker)) {
      eattacker.pers["participation"]++;
    }
    if(!isDefined(self.maxhealth)) {
      self.maxhealth = self.healthdefault;
    }
    prevhealthratio = self.health / self.maxhealth;
    if(isDefined(self.owner) && isPlayer(self.owner)) {
      team = self.owner.pers["team"];
    } else {
      team = self vehicle::vehicle_get_occupant_team();
    }
    if(level.teambased && isPlayer(eattacker) && team == eattacker.pers["team"]) {
      if(!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
        return;
      }
      self.lastdamagewasfromenemy = 0;
      self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
    } else {
      if(!level.hardcoremode && isDefined(self.owner) && isDefined(eattacker) && isDefined(eattacker.owner) && self.owner == eattacker.owner && self != eattacker) {
        return;
      }
      if(!level.teambased && isDefined(self.archetype) && self.archetype == "raps") {} else {
        if(!level.teambased && isDefined(self.targetname) && self.targetname == "rcbomb") {} else if(isDefined(self.owner) && isDefined(eattacker) && self.owner == eattacker) {
          return;
        }
      }
      if(idamage < 1) {
        idamage = 1;
      }
      if(issubstr(smeansofdeath, "MOD_GRENADE") && isDefined(einflictor) && isDefined(einflictor.iscooked)) {
        self.wascooked = gettime();
      } else {
        self.wascooked = undefined;
      }
      attacker_seat = undefined;
      if(isDefined(eattacker)) {
        attacker_seat = self getoccupantseat(eattacker);
      }
      self.lastdamagewasfromenemy = isDefined(eattacker) && !isDefined(attacker_seat);
      self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
      self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
      if(level.gametype == "hack" && !weapon.isemp) {
        idamage = 0;
      }
    }
    if(eattackernotself && (eattackerisnotowner || (isDefined(self.selfdestruct) && !self.selfdestruct) || self.forcedamagefeedback === 1)) {
      if(trytododamagefeedback) {
        dofeedback = 1;
        if(isDefined(self.damagetaken) && isDefined(self.maxhealth) && self.damagetaken > self.maxhealth) {
          dofeedback = 0;
        }
        if(isDefined(self.shuttingdown) && self.shuttingdown) {
          dofeedback = 0;
        }
        if(dofeedback && damagefeedback::dodamagefeedback(weapon, einflictor)) {
          if(idamage > 0) {
            eattacker thread damagefeedback::update(smeansofdeath, einflictor);
          }
        }
      }
    }
  }
  if(getdvarint("")) {
    println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isPlayer(einflictor) + "") + idamage) + "") + shitloc);
  }
  if(1) {
    lpselfnum = selfentnum;
    lpselfteam = "";
    lpattackerteam = "";
    if(isPlayer(eattacker)) {
      lpattacknum = eattacker getentitynumber();
      lpattackguid = eattacker getguid();
      lpattackname = eattacker.name;
      lpattackerteam = eattacker.pers["team"];
    } else {
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackerteam = "world";
    }
    logprint(((((((((((((((((((("" + lpselfnum) + "") + lpselfteam) + "") + lpattackguid) + "") + lpattacknum) + "") + lpattackerteam) + "") + lpattackname) + "") + weapon.name) + "") + idamage) + "") + smeansofdeath) + "") + shitloc) + "");
  }
}

function callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
  idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
  finnerdamage = loadout::cac_modified_vehicle_damage(self, eattacker, finnerdamage, smeansofdeath, weapon, einflictor);
  fouterdamage = loadout::cac_modified_vehicle_damage(self, eattacker, fouterdamage, smeansofdeath, weapon, einflictor);
  self.idflags = idflags;
  self.idflagstime = gettime();
  if(game["state"] == "postgame") {
    return;
  }
  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }
  if(isDefined(self.killstreaktype)) {
    maxhealth = (isDefined(self.maxhealth) ? self.maxhealth : self.health);
    if(!isDefined(maxhealth)) {
      maxhealth = 200;
    }
    idamage = self killstreaks::ondamageperweapon(self.killstreaktype, eattacker, idamage, idflags, smeansofdeath, weapon, maxhealth, undefined, maxhealth * 0.4, undefined, 0, undefined, 1, 1);
  }
  if(!idflags & 2048) {
    if(self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
      return;
    }
    if(smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE") {
      scalar = weapon.vehicleprojectilesplashdamagescalar;
      idamage = int(idamage * scalar);
      finnerdamage = finnerdamage * scalar;
      fouterdamage = fouterdamage * scalar;
      if(finnerdamage == 0) {
        return;
      }
      if(idamage < 1) {
        idamage = 1;
      }
    }
    occupant_team = self vehicle::vehicle_get_occupant_team();
    if(level.teambased && isPlayer(eattacker) && occupant_team == eattacker.pers["team"]) {
      if(!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
        return;
      }
      self.lastdamagewasfromenemy = 0;
      self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
    } else {
      if(!level.hardcoremode && isDefined(self.owner) && isDefined(eattacker.owner) && self.owner == eattacker.owner) {
        return;
      }
      if(idamage < 1) {
        idamage = 1;
      }
      self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
    }
  }
}

function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(game["state"] == "postgame" && (!isDefined(self.selfdestruct) || !self.selfdestruct)) {
    if(isDefined(self.overridevehicledeathpostgame)) {
      self[[self.overridevehicledeathpostgame]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    return;
  }
  if(isDefined(self.overridevehiclekilled)) {
    self[[self.overridevehiclekilled]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
  if(isDefined(self.overridevehicledeath)) {
    self[[self.overridevehicledeath]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
}

function vehiclecrush() {
  self endon("disconnect");
  if(isDefined(level._effect) && isDefined(level._effect["tanksquish"])) {
    playFX(level._effect["tanksquish"], self.origin + vectorscale((0, 0, 1), 30));
  }
  self playSound("chr_crunch");
}

function getvehicleunderneathsplashscalar(weapon) {
  if(isDefined(self) && isDefined(self.ignore_vehicle_underneath_splash_scalar)) {
    return 1;
  }
  if(weapon.name == "satchel_charge") {
    scale = 10;
    scale = scale * 3;
  } else {
    scale = 1;
  }
  return scale;
}

function allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
  if(isDefined(self.allowfriendlyfiredamageoverride)) {
    return [[self.allowfriendlyfiredamageoverride]](einflictor, eattacker, smeansofdeath, weapon);
  }
  return 0;
}