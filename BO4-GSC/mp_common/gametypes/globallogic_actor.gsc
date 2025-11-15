/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_actor.gsc
*****************************************************/

#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\globallogic\globallogic_player;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\challenges;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\player\player_utils;
#include scripts\weapons\weapon_utils;
#include scripts\weapons\weapons;

#namespace globallogic_actor;

autoexec init() {}

callback_actorspawned(spawner) {
  self thread spawner::spawn_think(spawner);
}

callback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal) {
  if(gamestate::is_game_over()) {
    return;
  }

  if(self.team == #"spectator") {
    return;
  }

  if(isDefined(eattacker) && isplayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }

  self.idflags = idflags;
  self.idflagstime = gettime();
  eattacker = player::figure_out_attacker(eattacker);

  if(!isDefined(vdir)) {
    idflags |= 4;
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
    } else if(smeansofdeath == "MOD_HEAD_SHOT") {
      idamage = 150;
    }
  }

  if(isDefined(self.overrideactordamage)) {
    idamage = self[[self.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
  } else if(isDefined(level.overrideactordamage)) {
    idamage = self[[level.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
  }

  friendlyfire = [[level.figure_out_friendly_fire]](self, eattacker);

  if(friendlyfire == 0 && self.archetype === "robot" && isDefined(eattacker) && !util::function_fbce7263(eattacker.team, self.team)) {
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
      weapon = getweapon(#"explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon(#"destructible_car");
    }
  }

  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.idflags = idflags;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.vpoint = vpoint;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.vdamageorigin = vdamageorigin;
  params.psoffsettime = psoffsettime;

  if(!(idflags&8192)) {
    if(isplayer(eattacker) && isDefined(eattacker.pers)) {
      if(!isDefined(eattacker.pers[#"participation"])) {
        eattacker.pers[#"participation"] = 0;
      }

      eattacker.pers[#"participation"]++;
    }

    prevhealthratio = self.health / self.maxhealth;
    isshootingownclone = 0;

    if(isDefined(self.isaiclone) && self.isaiclone && isplayer(eattacker) && self.owner == eattacker) {
      isshootingownclone = 1;
    }

    if(level.teambased && isplayer(eattacker) && self != eattacker && !util::function_fbce7263(self.team, eattacker.pers[#"team"]) && !isshootingownclone) {
      friendlyfire = [
        [level.figure_out_friendly_fire]
      ](self, eattacker);

      if(friendlyfire == 0) {
        return;
      } else if(friendlyfire == 1) {
        if(idamage < 1) {
          idamage = 1;
        }

        self.lastdamagewasfromenemy = 0;
        var_5370b15e = idamage < self.health ? idamage : self.health;
        self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);
        params.idamage = idamage;
        self callback::callback(#"on_ai_damage", params);
        self callback::callback(#"on_actor_damage", params);
        self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
      } else if(friendlyfire == 2) {
        return;
      } else if(friendlyfire == 3) {
        idamage = int(idamage * 0.5);

        if(idamage < 1) {
          idamage = 1;
        }

        self.lastdamagewasfromenemy = 0;
        var_5370b15e = idamage < self.health ? idamage : self.health;
        self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);
        params.idamage = idamage;
        self callback::callback(#"on_ai_damage", params);
        self callback::callback(#"on_actor_damage", params);
        self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
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
      var_5370b15e = idamage < self.health ? idamage : self.health;
      self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);
      params.idamage = idamage;
      self callback::callback(#"on_ai_damage", params);
      self callback::callback(#"on_actor_damage", params);
      self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
    }

    if(isDefined(eattacker) && eattacker != self) {
      if(weapon.name != "artillery" && (!isDefined(einflictor) || !isai(einflictor) || !isDefined(einflictor.controlled) || einflictor.controlled)) {
        if(idamage > 0 && shitloc !== "riotshield") {
          eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self);
        }
      }
    }
  } else {
    params.idamage = idamage;
    self callback::callback(#"on_ai_damage", params);
    self callback::callback(#"on_actor_damage", params);
    self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
  }

  self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);

  if(getdvarint(#"g_debugdamage", 0)) {
    println("<dev string:x38>" + self getentitynumber() + "<dev string:x41>" + self.health + "<dev string:x4c>" + eattacker.clientid + "<dev string:x59>" + isplayer(einflictor) + "<dev string:x71>" + idamage + "<dev string:x7c>" + shitloc);
  }

    if(true) {
      lpselfnum = self getentitynumber();
      lpselfteam = self.team;
      lpattackerteam = "";

      if(isplayer(eattacker)) {
        lpattacknum = eattacker getentitynumber();
        var_c8fa9c41 = 0;
        lpattackguid = eattacker getguid();
        lpattackname = eattacker.name;
        lpattackerteam = eattacker.pers[#"team"];
        return;
      }

      lpattacknum = -1;
      var_c8fa9c41 = 0;
      lpattackguid = "";
      lpattackname = "";
      lpattackerteam = "world";
    }
}

callback_actorkilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(gamestate::is_game_over()) {
    return;
  }

  if(isai(eattacker) && isDefined(eattacker.script_owner)) {
    if(util::function_fbce7263(eattacker.script_owner.team, self.team)) {
      eattacker = eattacker.script_owner;
    }
  }

  if(isDefined(eattacker) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner)) {
    eattacker = eattacker.owner;
  }

  globallogic::doweaponspecifickilleffects(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  globallogic::doweaponspecificcorpseeffects(self, einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.psoffsettime = psoffsettime;
  self callback::callback(#"on_ai_killed", params);
}

callback_actorcloned(original) {
  destructserverutils::copydestructstate(original, self);
  gibserverutils::copygibstate(original, self);
}