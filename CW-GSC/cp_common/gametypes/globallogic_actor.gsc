/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\globallogic_actor.gsc
*****************************************************/

#using script_4ab78e327b76395f;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ammo_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\challenges;
#using scripts\cp_common\friendlyfire;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_utils;
#using scripts\weapons\weapon_utils;
#namespace globallogic_actor;

function callback_actorspawned(spawner) {
  self thread spawner::spawn_think(spawner);
  self player::reset_attacker_list();
  bb::logaispawn(self, spawner);
}

function callback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, surfacenormal) {
  self endon(#"death");
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.idflags = idflags;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.var_fd90b0bb = var_fd90b0bb;
  params.vpoint = vpoint;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.vdamageorigin = vdamageorigin;
  params.psoffsettime = psoffsettime;
  self.idflags = idflags;
  self.idflagstime = gettime();
  eattacker = globallogic_player::figureoutattacker(eattacker);

  if(self.health == self.maxhealth || !isDefined(self.attackers)) {
    self.attackers = [];
    self.attackerdata = [];
    self.attackerdamage = [];
  }

  same_team = isDefined(eattacker) && (self.team === eattacker.team || util::function_9b7092ef(self.team, eattacker.team));

  if(isDefined(level.friendlyfiredisabled) && !level.friendlyfiredisabled) {
    if(isDefined(level.var_edbfa7b)) {
      if(isPlayer(eattacker) && same_team) {
        idamage = int(idamage * level.var_edbfa7b);

        if(idamage < 1) {
          idamage = 1;
        }
      }
    }
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && (smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_WEAPON_BUTT")) {
    idamage *= 3;
  }

  idamage = int(idamage);
  unmodified = idamage;

  if(isDefined(self.overrideactordamage)) {
    idamage = self[[self.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
  } else if(isDefined(level.overrideactordamage)) {
    idamage = self[[level.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
  }

  if(isPlayer(eattacker) && eattacker hasperk(#"specialty_immunetrackerspotting") && weapons::isbulletdamage(smeansofdeath)) {
    idamage = int(idamage * 1.25);
  }

  if(isDefined(self.aioverridedamage)) {
    for(index = 0; index < self.aioverridedamage.size; index++) {
      damagecallback = self.aioverridedamage[index];
      idamage = self[[damagecallback]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
    }
  }

  if(idflags & 8192 && idamage < unmodified) {
    idamage = unmodified;
  }

  assert(isDefined(idamage), "<dev string:x38>");

  if(!isDefined(vdir)) {
    idflags |= 4;
  }

  if(isDefined(eattacker)) {
    if(isPlayer(eattacker)) {
      level thread friendlyfire::function_1ad87afd(self, idamage, eattacker, smeansofdeath, weapon, einflictor);

      if(isDefined(self.var_5753eaa5)) {
        self thread[[self.var_5753eaa5]]();
      }

      self thread challenges::actordamaged(eattacker, eattacker, idamage, weapon, shitloc);

      if(isDefined(einflictor) && (eattacker === einflictor || !isvehicle(einflictor)) && (!isDefined(smeansofdeath) || smeansofdeath != "MOD_MELEE_WEAPON_BUTT")) {
        eattacker.hits++;
      }
    } else if(isai(eattacker)) {
      if(same_team && smeansofdeath == "MOD_MELEE") {
        return;
      }
    }
  }

  actorkilled = 0;
  self thread globallogic_player::trackattackerdamage(eattacker, idamage, smeansofdeath, weapon);

  if(self.health > 0 && self.health - idamage <= 0) {
    if(isDefined(eattacker) && isPlayer(eattacker.driver)) {
      eattacker = eattacker.driver;
    }

    if(isPlayer(eattacker)) {
      println("<dev string:x74>" + weapon.name + "<dev string:x91>" + smeansofdeath);

      if(!same_team) {
        if(smeansofdeath == "MOD_MELEE") {
          eattacker notify(#"melee_kill");
        }
      }
    }

    actorkilled = 1;
  }

  if(weapons::isflashorstundamage(weapon, smeansofdeath)) {
    if(isDefined(self.type)) {
      if(weapon.isflash && self.type == "human") {
        self.var_f0cb2572 = self.idflagstime;
      } else if(weapon.isstun && self.type == "human") {
        self.var_189fd299 = self.idflagstime;
      }
    }

    self.laststunnedby = eattacker;
    self.laststunnedtime = self.idflagstime;
  }

  if(weapon.isemp && isDefined(self.type) && self.type == "robot") {
    if(weapon.name == # "emp_grenade") {
      self.var_e6e7d1c1 = self.idflagstime;
    } else if(weapon.name == # "hash_8820860b9c7d979" || weapon.name == # "hash_294001bc58d294f8") {
      self.var_cc76f50a = self.idflagstime;
    }
  }

  if(!(idflags & 8192)) {
    if(level.teambased && isDefined(eattacker) && eattacker != self && same_team && !isPlayer(eattacker)) {
      if(level.friendlyfire == 0) {
        return;
      } else if(level.friendlyfire == 1) {
        if(idamage < 1) {
          idamage = 1;
        }

        self.lastdamagewasfromenemy = 0;
      } else if(level.friendlyfire == 2) {
        return;
      } else if(level.friendlyfire == 3) {
        idamage = int(idamage * 0.5);

        if(idamage < 1) {
          idamage = 1;
        }

        self.lastdamagewasfromenemy = 0;
      }
    }

    if(isDefined(eattacker) && eattacker != self) {
      if(!isDefined(einflictor) || !isai(einflictor) || isvehicle(einflictor) && einflictor getseatoccupant(0) === eattacker) {
        if(idamage > 0 && !same_team && self.team != # "neutral" && shitloc !== "riotshield" && self.health - idamage > 0) {
          eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc, 0);
        }
      }
    }
  }

  self callback::callback(#"on_ai_damage", params);
  self callback::callback(#"on_actor_damage", params);
  function_c10ff087(eattacker, einflictor, weapon, smeansofdeath, idamage);
  bb::logdamage(eattacker, self, weapon, idamage, smeansofdeath, shitloc, actorkilled, actorkilled);
  self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
  self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, surfacenormal);
}

function callback_actorkilled(einflictor, eattacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime) {
  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.var_fd90b0bb = var_fd90b0bb;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.psoffsettime = psoffsettime;

  if(game.state == "postgame") {
    return;
  }

  eattacker = globallogic_player::figureoutattacker(eattacker);

  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor)) {
    params.smeansofdeath = "MOD_HEAD_SHOT";
  }

  if(isDefined(eattacker) && eattacker != self) {
    if(!isDefined(einflictor) || !isai(einflictor) || isvehicle(einflictor) && einflictor getseatoccupant(0) === eattacker) {
      if(idamage > 0 && self.team != eattacker.team && self.team != # "neutral" && shitloc !== "riotshield") {
        eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, psoffsettime, shitloc, 1);
      }
    }
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

  self callback::callback(#"on_ai_killed", params);
  self callback::callback(#"on_actor_killed", params);

  if(isDefined(self.aioverridekilled)) {
    for(index = 0; index < self.aioverridekilled.size; index++) {
      killedcallback = self.aioverridekilled[index];
      self[[killedcallback]](einflictor, eattacker, idamage, smeansofdeath, weapon, var_fd90b0bb, vdir, shitloc, psoffsettime);
    }
  }

  player = undefined;

  if(isDefined(eattacker)) {
    if(isPlayer(eattacker)) {
      player = eattacker;
    } else if(isDefined(eattacker.owner) && isPlayer(eattacker) && eattacker.classname == "script_vehicle") {
      player = eattacker.owner;
    }
  }

  if(isDefined(player) && isPlayer(player)) {
    player notify(#"killed_ai", {
      #victim: self, #mod: smeansofdeath, #weapon: weapon
    });

    if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE" || smeansofdeath == "MOD_MELEE_WEAPON_BUTT") {
      player.meleekills++;
    }

    if(isDefined(weapon)) {
      if(weapon.name == # "remote_missile_missile" || weapon.name == # "remote_missile_bomblet") {
        if(!isDefined(player.remotemissilebda)) {
          player.remotemissilebda = 0;
        }

        player.remotemissilebda++;
      }
    }

    self thread ammo::dropaiammo();
    deathtime = gettime();
    deathtimeoffset = 0;
    perks = [];
    killstreaks = globallogic::getkillstreaks(player);

    if(isalive(player)) {
      if(weapon.isheavyweapon) {
        battlechatter::heavyweaponkilllogic(player, weapon, undefined);
      } else {
        enemykilled_cooldown = "enemy_killed_vo_" + string(player.team);

        if(level util::iscooldownready(enemykilled_cooldown)) {
          level util::cooldown(enemykilled_cooldown, 4);
          player battlechatter::play_dialog("killenemy", 1);
          level util::addcooldowntime(enemykilled_cooldown, 4);
        }
      }
    }

    if(!is_true(self.disable_score_events)) {
      if(!level.teambased || self.team != player.pers[#"team"]) {
        self thread challenges::actorkilled(einflictor, player, idamage, smeansofdeath, weapon, shitloc);
        self function_bb02eb15(einflictor, player, weapon, player.team);
      }
    }
  }
}

function callback_actorcloned(original) {
  destructserverutils::copydestructstate(original, self);
  gibserverutils::copygibstate(original, self);
}

function function_bb02eb15(einflictor, eattacker, weapon, lpattackteam) {
  pixbeginevent(#"");

  if(isDefined(self.attackers)) {
    for(j = 0; j < self.attackers.size; j++) {
      player = self.attackers[j];

      if(!isDefined(player)) {
        continue;
      }

      if(player == weapon) {
        continue;
      }

      if(player.team != lpattackteam) {
        continue;
      }

      damage_done = self.attackerdamage[player.clientid].damage;
    }
  }

  pixendevent();
}

function function_c10ff087(eattacker, einflictor, weapon, meansofdeath, damage) {
  self endon(#"death", #"disconnect");

  if(isDefined(level._custom_weapon_damage_func)) {
    self[[level._custom_weapon_damage_func]](eattacker, einflictor, weapon, meansofdeath, damage);
  }
}