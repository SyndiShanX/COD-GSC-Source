/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_globallogic_vehicle.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\gametypes\_damagefeedback;
#using scripts\zm\gametypes\_globallogic_player;
#using scripts\zm\gametypes\_weapons;
#namespace globallogic_vehicle;

function callback_vehiclespawned(spawner) {
  if(isDefined(level.vehicle_main_callback)) {
    if(isDefined(level.vehicle_main_callback[self.vehicletype])) {
      self thread[[level.vehicle_main_callback[self.vehicletype]]]();
    } else if(isDefined(self.scriptvehicletype) && isDefined(level.vehicle_main_callback[self.scriptvehicletype])) {
      self thread[[level.vehicle_main_callback[self.scriptvehicletype]]]();
    }
  }
  if(issentient(self)) {
    self spawner::spawn_think(spawner);
  }
}

function callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  self.idflags = idflags;
  self.idflagstime = gettime();
  if(game["state"] == "postgame") {
    return;
  }
  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }
  if(!isDefined(vdir)) {
    idflags = idflags | level.idflags_no_knockback;
  }
  friendly = 0;
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
  if(!idflags &level.idflags_no_protection) {
    if(self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
      if(isDefined(self.overridevehicledamage)) {
        idamage = self[[self.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
      } else if(isDefined(level.overridevehicledamage)) {
        idamage = self[[level.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
      }
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
    idamage = idamage * self getvehdamagemultiplier(smeansofdeath);
    idamage = int(idamage);
    if(isPlayer(eattacker)) {
      eattacker.pers["participation"]++;
    }
    if(!isDefined(self.maxhealth)) {
      self.maxhealth = self.healthdefault;
    }
    if(isDefined(self.overridevehicledamage)) {
      idamage = self[[self.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    } else if(isDefined(level.overridevehicledamage)) {
      idamage = self[[level.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    prevhealthratio = self.health / self.maxhealth;
    if(isDefined(self.owner) && isPlayer(self.owner)) {
      team = self.owner.pers["team"];
    } else {
      team = self vehicle::vehicle_get_occupant_team();
    }
    if(level.teambased && isPlayer(eattacker) && team == eattacker.pers["team"]) {
      if(level.friendlyfire == 0) {
        if(!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
          return;
        }
        if(idamage < 1) {
          idamage = 1;
        }
        self.lastdamagewasfromenemy = 0;
        self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 1);
      } else {
        if(level.friendlyfire == 1) {
          if(idamage < 1) {
            idamage = 1;
          }
          self.lastdamagewasfromenemy = 0;
          self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
        } else {
          if(level.friendlyfire == 2) {
            if(!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
              return;
            }
            if(idamage < 1) {
              idamage = 1;
            }
            self.lastdamagewasfromenemy = 0;
            self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 1);
          } else if(level.friendlyfire == 3) {
            idamage = int(idamage * 0.5);
            if(idamage < 1) {
              idamage = 1;
            }
            self.lastdamagewasfromenemy = 0;
            self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
          }
        }
      }
      friendly = 1;
    } else {
      if(!level.teambased && isDefined(self.targetname) && self.targetname == "rcbomb") {} else if(isDefined(self.owner) && isDefined(eattacker) && self.owner == eattacker) {
        return;
      }
      if(idamage < 1 && (!(isDefined(level.bzm_worldpaused) && level.bzm_worldpaused))) {
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
      self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
      if(level.gametype == "hack" && !weapon.isemp) {
        idamage = 0;
      }
    }
    if(isDefined(eattacker) && eattacker != self) {
      if(damagefeedback::dodamagefeedback(weapon, einflictor)) {
        if(idamage > 0) {
          eattacker thread damagefeedback::update(smeansofdeath, einflictor);
        }
      }
    }
  }
  if(getdvarint("")) {
    println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isPlayer(einflictor) + "") + idamage) + "") + shitloc);
  }
  if(1) {
    lpselfnum = self getentitynumber();
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
    logprint(((((((((((((((((((("VD;" + lpselfnum) + ";") + lpselfteam) + ";") + lpattackguid) + ";") + lpattacknum) + ";") + lpattackerteam) + ";") + lpattackname) + ";") + weapon.name) + ";") + idamage) + ";") + smeansofdeath) + ";") + shitloc) + "\n");
  }
}

function callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
  self.idflags = idflags;
  self.idflagstime = gettime();
  if(game["state"] == "postgame") {
    return;
  }
  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }
  friendly = 0;
  if(!idflags &level.idflags_no_protection) {
    if(self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
      return;
    }
    if(isDefined(self.overridevehicleradiusdamage)) {
      idamage = self[[self.overridevehicleradiusdamage]](einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
    } else if(isDefined(level.overridevehicleradiusdamage)) {
      idamage = self[[level.overridevehicleradiusdamage]](einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
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
      if(level.friendlyfire == 0) {
        if(!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
          return;
        }
        if(idamage < 1) {
          idamage = 1;
        }
        self.lastdamagewasfromenemy = 0;
        self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
      } else {
        if(level.friendlyfire == 1) {
          if(idamage < 1) {
            idamage = 1;
          }
          self.lastdamagewasfromenemy = 0;
          self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
        } else {
          if(level.friendlyfire == 2) {
            if(!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
              return;
            }
            if(idamage < 1) {
              idamage = 1;
            }
            self.lastdamagewasfromenemy = 0;
            self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
          } else if(level.friendlyfire == 3) {
            idamage = int(idamage * 0.5);
            if(idamage < 1) {
              idamage = 1;
            }
            self.lastdamagewasfromenemy = 0;
            self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
          }
        }
      }
      friendly = 1;
    } else {
      if(idamage < 1) {
        idamage = 1;
      }
      self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
    }
  }
}

function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.psoffsettime = psoffsettime;
  self.str_damagemod = smeansofdeath;
  self.w_damage = weapon;
  if(game["state"] == "postgame") {
    return;
  }
  if(isai(eattacker) && isDefined(eattacker.script_owner)) {
    if(eattacker.script_owner.team != self.team) {
      eattacker = eattacker.script_owner;
    }
  }
  if(isDefined(eattacker) && isDefined(eattacker.onkill)) {
    eattacker[[eattacker.onkill]](self);
  }
  if(isDefined(einflictor)) {
    self.damageinflictor = einflictor;
  }
  self callback::callback("hash_acb66515", params);
  if(isDefined(self.overridevehiclekilled)) {
    self[[self.overridevehiclekilled]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
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