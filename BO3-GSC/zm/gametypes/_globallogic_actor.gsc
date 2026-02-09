/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_globallogic_actor.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\destructible_character;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\challenges_shared;
#using scripts\shared\spawner_shared;
#using scripts\zm\_bb;
#using scripts\zm\_challenges;
#using scripts\zm\gametypes\_damagefeedback;
#using scripts\zm\gametypes\_globallogic_player;
#using scripts\zm\gametypes\_globallogic_utils;
#using scripts\zm\gametypes\_weapons;
#namespace globallogic_actor;

function callback_actorspawned(spawner) {
  self thread spawner::run_spawn_functions();
  bb::logaispawn(self, spawner);
}

function callback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(game["state"] == "postgame") {
    return;
  }
  if(self.team == "spectator") {
    return;
  }
  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }
  self.idflags = idflags;
  self.idflagstime = gettime();
  eattacker = globallogic_player::figureoutattacker(eattacker);
  if(!isDefined(vdir)) {
    idflags = idflags | level.idflags_no_knockback;
  }
  friendly = 0;
  if(self.health == self.maxhealth || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
  }
  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor)) {
    smeansofdeath = "MOD_HEAD_SHOT";
  }
  if(level.onlyheadshots) {
    if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
      return;
    }
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      idamage = 150;
    }
  }
  if(isDefined(self.aioverridedamage)) {
    for(index = 0; index < self.aioverridedamage.size; index++) {
      damagecallback = self.aioverridedamage[index];
      idamage = self[[damagecallback]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
    }
    if(idamage < 1) {
      return;
    }
    idamage = int(idamage + 0.5);
  }
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon("explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon("destructible_car");
    }
  }
  if(!idflags &level.idflags_no_protection) {
    if(isPlayer(eattacker)) {
      eattacker.pers["participation"]++;
    }
    prevhealthratio = self.health / self.maxhealth;
    if(level.teambased && isPlayer(eattacker) && self != eattacker && self.team == eattacker.pers["team"]) {
      if(level.friendlyfire == 0) {
        return;
      }
      if(level.friendlyfire == 1) {
        if(idamage < 1) {
          idamage = 1;
        }
        self.lastdamagewasfromenemy = 0;
        self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
        self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
      } else {
        if(level.friendlyfire == 2) {
          return;
        }
        if(level.friendlyfire == 3) {
          idamage = int(idamage * 0.5);
          if(idamage < 1) {
            idamage = 1;
          }
          self.lastdamagewasfromenemy = 0;
          self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
          self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
        }
      }
      friendly = 1;
    } else {
      if(isDefined(eattacker) && isDefined(self.script_owner) && eattacker == self.script_owner && !level.hardcoremode) {
        return;
      }
      if(isDefined(eattacker) && isDefined(self.script_owner) && isDefined(eattacker.script_owner) && eattacker.script_owner == self.script_owner) {
        return;
      }
      if(idamage < 1) {
        idamage = 1;
      }
      if(issubstr(smeansofdeath, "MOD_GRENADE") && isDefined(einflictor) && isDefined(einflictor.iscooked)) {
        self.wascooked = gettime();
      } else {
        self.wascooked = undefined;
      }
      self.lastdamagewasfromenemy = isDefined(eattacker) && eattacker != self;
      self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
      self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
    }
    if(isDefined(eattacker) && eattacker != self) {
      if(!isDefined(einflictor) || !isai(einflictor)) {
        if(idamage > 0 && shitloc !== "riotshield") {
          eattacker thread damagefeedback::updatedamagefeedback(smeansofdeath, einflictor);
        }
      }
    }
  }
  if(getdvarint("")) {
    println(((((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isPlayer(einflictor) + "") + idamage) + shitloc) + "") + boneindex) + "");
  }
  if(1) {
    lpselfnum = self getentitynumber();
    lpselfteam = self.team;
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
    logprint(((((((((((((((((((("AD;" + lpselfnum) + ";") + lpselfteam) + ";") + lpattackguid) + ";") + lpattacknum) + ";") + lpattackerteam) + ";") + lpattackname) + ";") + weapon.name) + ";") + idamage) + ";") + smeansofdeath) + ";") + shitloc) + "\n");
  }
}

function callback_actorkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(game["state"] == "postgame") {
    return;
  }
  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(attacker.script_owner.team != self.team) {
      attacker = attacker.script_owner;
    }
  }
  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }
  if(isDefined(attacker) && isPlayer(attacker)) {
    if(!level.teambased || self.team != attacker.pers["team"]) {
      level.globalkillstreaksdestroyed++;
      attacker addweaponstat(getweapon("dogs"), "destroyed", 1);
      attacker challenges::killeddog();
    }
  }
}

function callback_actorcloned(original) {
  destructserverutils::copydestructstate(original, self);
  gibserverutils::copygibstate(original, self);
}