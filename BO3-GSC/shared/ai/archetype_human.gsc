/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_human.gsc
*************************************************/

#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_human_blackboard;
#using scripts\shared\ai\archetype_human_cover;
#using scripts\shared\ai\archetype_human_exposed;
#using scripts\shared\ai\archetype_human_interface;
#using scripts\shared\ai\archetype_human_locomotion;
#using scripts\shared\ai\archetype_mocomps_utility;
#using scripts\shared\ai\archetype_notetracks;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\destructible_character;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#namespace archetype_human;

function autoexec init() {
  spawner::add_archetype_spawn_function("human", &archetypehumanblackboardinit);
  spawner::add_archetype_spawn_function("human", &archetypehumaninit);
  humaninterface::registerhumaninterfaceattributes();
  clientfield::register("actor", "facial_dial", 1, 1, "int");
  level.__ai_forcegibs = getdvarint("");
}

function private archetypehumaninit() {
  entity = self;
  aiutility::addaioverridedamagecallback(entity, &damageoverride);
  aiutility::addaioverridekilledcallback(entity, &humangibkilledoverride);
  locomotiontypes = array("alt1", "alt2", "alt3", "alt4");
  altindex = entity getentitynumber() % locomotiontypes.size;
  blackboard::setblackboardattribute(entity, "_human_locomotion_variation", locomotiontypes[altindex]);
  if(isDefined(entity.hero) && entity.hero) {
    blackboard::setblackboardattribute(entity, "_human_locomotion_variation", "alt1");
  }
}

function private archetypehumanblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self aiutility::registerutilityblackboardattributes();
  self blackboard::registeractorblackboardattributes();
  self.___archetypeonanimscriptedcallback = &archetypehumanonanimscriptedcallback;
  self.___archetypeonbehavecallback = &archetypehumanonbehavecallback;
  self finalizetrackedblackboardattributes();
  self thread gameskill::accuracy_buildup_before_fire(self);
  if(self.accuratefire) {
    self thread aiutility::preshootlaserandglinton(self);
    self thread aiutility::postshootlaserandglintoff(self);
  }
  destructserverutils::togglespawngibs(self, 1);
  gibserverutils::togglespawngibs(self, 1);
}

function private archetypehumanonbehavecallback(entity) {
  if(aiutility::isatcovercondition(entity)) {
    blackboard::setblackboardattribute(entity, "_previous_cover_mode", "cover_alert");
    blackboard::setblackboardattribute(entity, "_cover_mode", "cover_mode_none");
  }
  grenadethrowinfo = spawnStruct();
  grenadethrowinfo.grenadethrower = entity;
  blackboard::addblackboardevent("human_grenade_throw", grenadethrowinfo, randomintrange(3000, 4000));
}

function private archetypehumanonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypehumanblackboardinit();
  vignettemode = ai::getaiattribute(entity, "vignette_mode");
  humansoldierserverutils::vignettemodecallback(entity, "vignette_mode", vignettemode, vignettemode);
}

function private humangibkilledoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
  entity = self;
  if(math::cointoss()) {
    return damage;
  }
  attackerdistance = 0;
  if(isDefined(attacker)) {
    attackerdistance = distancesquared(attacker.origin, entity.origin);
  }
  isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
  forcegibbing = 0;
  if(isDefined(weapon.weapclass) && weapon.weapclass == "turret") {
    forcegibbing = 1;
    if(isDefined(inflictor)) {
      isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
      iscloseexplosive = distancesquared(inflictor.origin, entity.origin) <= (60 * 60);
      if(isdirectexplosive && iscloseexplosive) {
        gibserverutils::annihilate(entity);
      }
    }
  }
  if(forcegibbing || isexplosive || (isDefined(level.__ai_forcegibs) && level.__ai_forcegibs) || (weapon.dogibbing && attackerdistance <= (weapon.maxgibdistance * weapon.maxgibdistance))) {
    gibserverutils::togglespawngibs(entity, 1);
    destructserverutils::togglespawngibs(entity, 1);
    trygibbinglimb(entity, damage, hitloc, isexplosive || forcegibbing);
    trygibbinglegs(entity, damage, hitloc, isexplosive);
  }
  return damage;
}

function private trygibbinghead(entity, damage, hitloc, isexplosive) {
  if(isexplosive) {
    gibserverutils::gibhead(entity);
  } else if(isinarray(array("head", "neck", "helmet"), hitloc)) {
    gibserverutils::gibhead(entity);
  }
}

function private trygibbinglimb(entity, damage, hitloc, isexplosive) {
  if(isexplosive) {
    randomchance = randomfloatrange(0, 1);
    if(randomchance < 0.5) {
      gibserverutils::gibrightarm(entity);
    } else {
      gibserverutils::gibleftarm(entity);
    }
  } else {
    if(isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
      gibserverutils::gibleftarm(entity);
    } else {
      if(isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
      } else if(isinarray(array("torso_upper"), hitloc) && math::cointoss()) {
        if(math::cointoss()) {
          gibserverutils::gibleftarm(entity);
        } else {
          gibserverutils::gibrightarm(entity);
        }
      }
    }
  }
}

function private trygibbinglegs(entity, damage, hitloc, isexplosive, attacker) {
  if(isexplosive) {
    randomchance = randomfloatrange(0, 1);
    if(randomchance < 0.33) {
      gibserverutils::gibrightleg(entity);
    } else {
      if(randomchance < 0.66) {
        gibserverutils::gibleftleg(entity);
      } else {
        gibserverutils::giblegs(entity);
      }
    }
  } else {
    if(isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc)) {
      gibserverutils::gibleftleg(entity);
    } else {
      if(isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc)) {
        gibserverutils::gibrightleg(entity);
      } else if(isinarray(array("torso_lower"), hitloc) && math::cointoss()) {
        if(math::cointoss()) {
          gibserverutils::gibleftleg(entity);
        } else {
          gibserverutils::gibrightleg(entity);
        }
      }
    }
  }
}

function damageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  entity = self;
  entity destructserverutils::handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
  if(isDefined(eattacker) && !isplayer(eattacker) && !isvehicle(eattacker)) {
    dist = distancesquared(entity.origin, eattacker.origin);
    if(dist < 65536) {
      idamage = int(idamage * 10);
    } else {
      idamage = int(idamage * 1.5);
    }
  }
  if(sweapon.name == "incendiary_grenade") {
    idamage = entity.health;
  }
  return idamage;
}

#namespace humansoldierserverutils;

function cqbattributecallback(entity, attribute, oldvalue, value) {
  if(value) {
    entity asmchangeanimmappingtable(2);
  } else {
    if(entity ai::get_behavior_attribute("useAnimationOverride")) {
      entity asmchangeanimmappingtable(1);
    } else {
      entity asmchangeanimmappingtable(0);
    }
  }
}

function forcetacticalwalkcallback(entity, attribute, oldvalue, value) {
  entity.ignorerunandgundist = value;
}

function movemodeattributecallback(entity, attribute, oldvalue, value) {
  entity.ignorepathenemyfightdist = 0;
  switch (value) {
    case "normal": {
      break;
    }
    case "rambo": {
      entity.ignorepathenemyfightdist = 1;
      break;
    }
  }
}

function useanimationoverridecallback(entity, attribute, oldvalue, value) {
  if(value) {
    entity asmchangeanimmappingtable(1);
  } else {
    entity asmchangeanimmappingtable(0);
  }
}

function vignettemodecallback(entity, attribute, oldvalue, value) {
  switch (value) {
    case "off": {
      entity.pushable = 1;
      entity pushactors(0);
      entity pushplayer(0);
      entity setavoidancemask("avoid all");
      entity setsteeringmode("normal steering");
      break;
    }
    case "slow": {
      entity.pushable = 0;
      entity pushactors(0);
      entity pushplayer(1);
      entity setavoidancemask("avoid ai");
      entity setsteeringmode("vignette steering");
      break;
    }
    case "fast": {
      entity.pushable = 0;
      entity pushactors(1);
      entity pushplayer(1);
      entity setavoidancemask("avoid none");
      entity setsteeringmode("vignette steering");
      break;
    }
    default: {
      break;
    }
  }
}