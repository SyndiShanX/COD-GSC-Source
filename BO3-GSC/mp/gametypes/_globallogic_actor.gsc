/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_globallogic_actor.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_challenges;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_player;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\shared\_burnplayer;
#using scripts\shared\abilities\gadgets\_gadget_clone;
#using scripts\shared\ai\systems\destructible_character;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\weapons\_weapon_utils;
#namespace globallogic_actor;

function autoexec init() {}

function callback_actorspawned(spawner) {
  self thread spawner::spawn_think(spawner);
}

function callback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(game["state"] == "postgame") {
    return;
  }
  if(self.team == "spectator") {
    return;
  }
  if(isDefined(eattacker) && isplayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }
  self.idflags = idflags;
  self.idflagstime = gettime();
  eattacker = globallogic_player::figure_out_attacker(eattacker);
  if(!isDefined(vdir)) {
    idflags = idflags | 4;
  }
  friendly = 0;
  if(self.health == self.maxhealth || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
    self.attackersthisspawn = [];
  }
  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && !weapon_utils::ismeleemod(smeansofdeath)) {
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
  if(isDefined(self.overrideactordamage)) {
    idamage = self[[self.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
  }
  friendlyfire = [[level.figure_out_friendly_fire]](self);
  if(friendlyfire == 0 && self.archetype === "robot" && isDefined(eattacker) && eattacker.team === self.team) {
    return;
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
  if(!idflags & 2048) {
    if(isplayer(eattacker)) {
      eattacker.pers["participation"]++;
    }
    prevhealthratio = self.health / self.maxhealth;
    isshootingownclone = 0;
    if(isDefined(self.isaiclone) && self.isaiclone && isplayer(eattacker) && self.owner == eattacker) {
      isshootingownclone = 1;
    }
    if(level.teambased && isplayer(eattacker) && self != eattacker && self.team == eattacker.pers["team"] && !isshootingownclone) {
      friendlyfire = [[level.figure_out_friendly_fire]](self);
      if(friendlyfire == 0) {
        return;
      }
      if(friendlyfire == 1) {
        if(idamage < 1) {
          idamage = 1;
        }
        self.lastdamagewasfromenemy = 0;
        self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
        self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
      } else {
        if(friendlyfire == 2) {
          return;
        }
        if(friendlyfire == 3) {
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
      if(isDefined(eattacker) && isDefined(self.script_owner) && eattacker == self.script_owner && !level.hardcoremode && !isshootingownclone) {
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
      if(weapon.name != "artillery" && (!isDefined(einflictor) || !isai(einflictor) || !isDefined(einflictor.controlled) || einflictor.controlled)) {
        if(idamage > 0 && shitloc !== "riotshield") {
          eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self);
        }
      }
    }
  }
  if(getdvarint("")) {
    println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isplayer(einflictor) + "") + idamage) + "") + shitloc);
  }
  if(1) {
    lpselfnum = self getentitynumber();
    lpselfteam = self.team;
    lpattackerteam = "";
    if(isplayer(eattacker)) {
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
    logprint(((((((((((((((((((((("" + lpselfnum) + "") + lpselfteam) + "") + lpattackguid) + "") + lpattacknum) + "") + lpattackerteam) + "") + lpattackname) + "") + weapon.name) + "") + idamage) + "") + smeansofdeath) + "") + shitloc) + "") + boneindex) + "");
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
  _gadget_clone::processclonescoreevent(self, attacker, weapon);
  globallogic::doweaponspecifickilleffects(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  globallogic::doweaponspecificcorpseeffects(self, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

function callback_actorcloned(original) {
  destructserverutils::copydestructstate(original, self);
  gibserverutils::copygibstate(original, self);
}