/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_gibs.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\doa\_doa_dev;
#using scripts\cp\doa\_doa_fx;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\cp\doa\_doa_round;
#using scripts\cp\doa\_doa_score;
#using scripts\cp\doa\_doa_sfx;
#using scripts\cp\doa\_doa_utility;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace namespace_fba031c8;

function init() {
  level.doa.var_2b941d3f = array(getweapon("zombietron_deathmachine"), getweapon("zombietron_deathmachine_1"), getweapon("zombietron_deathmachine_2"), getweapon("zombietron_shotgun"), getweapon("zombietron_shotgun_1"), getweapon("zombietron_shotgun_2"), getweapon("zombietron_rpg_1"), getweapon("zombietron_rpg_2"), getweapon("zombietron_nightfury"));
  level.doa.var_1a7175b1 = array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTIVLE_SPLASH", "MOD_EXPLOSIVE");
  level.doa.hitlocs = array("left_hand", "left_arm_lower", "left_arm_upper", "right_hand", "right_arm_lower", "right_arm_upper");
}

function function_ddf685e8(launchvector, attacker) {
  if(!isDefined(self)) {
    return;
  }
  if(!isactor(self)) {
    return;
  }
  if(isDefined(self.boss) && self.boss) {
    return;
  }
  gibserverutils::giblegs(self);
  self.becomecrawler = 1;
  self clientfield::set("zombie_saw_explosion", 1);
  assert(!(isDefined(self.boss) && self.boss));
  self thread doa_utility::function_e3c30240(launchvector, undefined, undefined, attacker);
}

function function_7b3e39cb() {
  gibserverutils::annihilate(self);
}

function function_45dffa6b(launchvector) {
  if(!isDefined(self)) {
    return;
  }
  if(!isactor(self)) {
    return;
  }
  assert(!(isDefined(self.boss) && self.boss));
  self clientfield::set("zombie_gut_explosion", 1);
  self thread doa_utility::function_e3c30240(launchvector);
  if(isDefined(launchvector)) {
    self thread namespace_1a381543::function_90118d8c("zmb_ragdoll_launched");
  }
}

function function_deb7df37() {
  self endon("death");
  if(self.animname == "quad_zombie") {
    return;
  }
  if(randomint(100) < 50) {
    wait(randomfloatrange(0.53, 1));
    gibserverutils::gibhead(self);
  } else {
    self thread namespace_eaa992c::function_285a2999("tesla_shock_eyes");
  }
}

function trygibbinghead(entity, damage, hitloc, isexplosive) {
  if(!gibserverutils::isgibbed(entity, 8)) {
    return;
  }
  if(isexplosive && randomfloatrange(0, 1) <= 0.5) {
    gibserverutils::gibhead(entity);
  } else {
    if(isinarray(array("head", "neck", "helmet"), hitloc) && randomfloatrange(0, 1) <= 1) {
      gibserverutils::gibhead(entity);
    } else if((entity.health - damage) <= 0 && randomfloatrange(0, 1) <= 0.25) {
      gibserverutils::gibhead(entity);
    }
  }
}

function trygibbinglimb(entity, damage, hitloc = level.doa.hitlocs[randomint(level.doa.hitlocs.size)], isexplosive = 0) {
  if(isexplosive && randomfloatrange(0, 1) <= 0.35) {
    if((entity.health - damage) <= 0 && entity.allowdeath && math::cointoss()) {
      if(!gibserverutils::isgibbed(entity, 16)) {
        gibserverutils::gibrightarm(entity);
      }
    } else if(!gibserverutils::isgibbed(entity, 32)) {
      gibserverutils::gibleftarm(entity);
    }
  } else {
    if(isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
      if(!gibserverutils::isgibbed(entity, 32)) {
        gibserverutils::gibleftarm(entity);
      }
    } else {
      if((entity.health - damage) <= 0 && entity.allowdeath && isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
      } else if((entity.health - damage) <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.45) {
        if(math::cointoss()) {
          if(!gibserverutils::isgibbed(entity, 32)) {
            gibserverutils::gibleftarm(entity);
          }
        } else if(!gibserverutils::isgibbed(entity, 16)) {
          gibserverutils::gibrightarm(entity);
        }
      }
    }
  }
}

function trygibbinglegs(entity, damage, hitloc = level.doa.hitlocs[randomint(level.doa.hitlocs.size)], isexplosive = 0, attacker = entity) {
  cangiblegs = (entity.health - damage) <= 0 && entity.allowdeath;
  cangiblegs = cangiblegs || (((entity.health - damage) / entity.maxhealth) <= 0.25 && distancesquared(entity.origin, attacker.origin) <= (600 * 600) && entity.allowdeath);
  if((entity.health - damage) <= 0 && entity.allowdeath && isexplosive && randomfloatrange(0, 1) <= 0.5) {
    if(!gibserverutils::isgibbed(entity, 384)) {
      gibserverutils::giblegs(entity);
    }
    assert(!(isDefined(entity.boss) && entity.boss));
    entity thread doa_utility::function_e3c30240();
  } else {
    if(cangiblegs && isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
      if((entity.health - damage) > 0) {
        entity.becomecrawler = 1;
      }
      if(!gibserverutils::isgibbed(entity, 256)) {
        gibserverutils::gibleftleg(entity);
      }
    } else {
      if(cangiblegs && isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
        if((entity.health - damage) > 0) {
          entity.becomecrawler = 1;
        }
        if(!gibserverutils::isgibbed(entity, 128)) {
          gibserverutils::gibrightleg(entity);
        }
      } else if((entity.health - damage) <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.25) {
        if(math::cointoss()) {
          if(!gibserverutils::isgibbed(entity, 256)) {
            gibserverutils::gibleftleg(entity);
          }
        } else if(!gibserverutils::isgibbed(entity, 128)) {
          gibserverutils::gibrightleg(entity);
        }
      }
    }
  }
}

function function_15a268a6(attacker, damage, meansofdeath, weapon, hitloc, vdir) {
  if(!isactor(self)) {
    return;
  }
  if(self.archetype != "zombie") {
    return;
  }
  if(meansofdeath == "MOD_BURNED") {
    return;
  }
  self endon("death");
  isexplosive = isinarray(level.doa.var_1a7175b1, meansofdeath);
  trygibbinglimb(self, damage, hitloc, isexplosive);
  trygibbinglegs(self, damage, hitloc, isexplosive, attacker);
  if(damage > self.health && gettime() > self.birthtime) {
    if(isinarray(level.doa.var_2b941d3f, weapon)) {
      self clientfield::increment("zombie_chunk");
    }
    if(weapon == level.doa.var_ccb54987 || weapon == level.doa.var_69899304) {
      trygibbinghead(self, damage, hitloc, isexplosive);
      self clientfield::set("zombie_rhino_explosion", 1);
    }
    if(weapon.doannihilate) {
      self function_7b3e39cb();
    }
  }
}