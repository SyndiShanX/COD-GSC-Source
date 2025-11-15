/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_trophy_system.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_tacticalinsertion;
#using scripts\shared\weapons\_weaponobjects;
#using_animtree("mp_trophy_system");
#namespace trophy_system;

function init_shared() {
  level.trophylongflashfx = "weapon/fx_trophy_flash";
  level.trophydetonationfx = "weapon/fx_trophy_detonation";
  level.fx_trophy_radius_indicator = "weapon/fx_trophy_radius_indicator";
  trophydeployanim = % mp_trophy_system::o_trophy_deploy;
  trophyspinanim = % mp_trophy_system::o_trophy_spin;
  level thread register();
  callback::on_spawned( & createtrophysystemwatcher);
}

function register() {
  clientfield::register("missile", "trophy_system_state", 1, 2, "int");
  clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int");
}

function createtrophysystemwatcher() {
  if(level.gametype == "infect" && self.team == game["attackers"]) {
    return;
  }
  watcher = self weaponobjects::createuseweaponobjectwatcher("trophy_system", self.team);
  watcher.ondetonatecallback = & trophysystemdetonate;
  watcher.activatesound = "wpn_claymore_alert";
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.activationdelay = 0.1;
  watcher.headicon = 0;
  watcher.enemydestroy = 1;
  watcher.onspawn = & ontrophysystemspawn;
  watcher.ondamage = & watchtrophysystemdamage;
  watcher.ondestroyed = & ontrophysystemsmashed;
  watcher.onstun = & weaponobjects::weaponstun;
  watcher.stuntime = 1;
}

function ontrophysystemspawn(watcher, player) {
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self useanimtree($mp_trophy_system);
  self weaponobjects::onspawnuseweaponobject(watcher, player);
  self.trophysystemstationary = 0;
  movestate = self util::waittillrollingornotmoving();
  if(movestate == "rolling") {
    self setanim( % mp_trophy_system::o_trophy_deploy, 1);
    self clientfield::set("trophy_system_state", 1);
    self util::waittillnotmoving();
  }
  self.trophysystemstationary = 1;
  player addweaponstat(self.weapon, "used", 1);
  self.ammo = player ammo_get(self.weapon);
  self thread trophyactive(player);
  self thread trophywatchhack();
  self setanim( % mp_trophy_system::o_trophy_deploy, 0);
  self setanim( % mp_trophy_system::o_trophy_spin, 1);
  self clientfield::set("trophy_system_state", 2);
  self playSound("wpn_trophy_deploy_start");
  self playLoopSound("wpn_trophy_spin", 0.25);
  self setreconmodeldeployed();
}

function setreconmodeldeployed() {
  if(isDefined(self.reconmodelentity)) {
    self.reconmodelentity clientfield::set("trophy_system_state", 2);
  }
}

function trophywatchhack() {
  self endon("death");
  self waittill("hacked", player);
  self clientfield::set("trophy_system_state", 0);
}

function ontrophysystemsmashed(attacker) {
  playFX(level._effect["tacticalInsertionFizzle"], self.origin);
  self playSound("dst_trophy_smash");
  if(isDefined(level.playequipmentdestroyedonplayer)) {
    self.owner[[level.playequipmentdestroyedonplayer]]();
  }
  if(isDefined(attacker) && self.owner util::isenemyplayer(attacker)) {
    attacker challenges::destroyedequipment();
    scoreevents::processscoreevent("destroyed_trophy_system", attacker, self.owner);
  }
  self delete();
}

function trophyactive(owner) {
  owner endon("disconnect");
  self endon("death");
  self endon("hacked");
  while(true) {
    if(!isDefined(self)) {
      return;
    }
    if(level.missileentities.size < 1 || isDefined(self.disabled)) {
      wait(0.05);
      continue;
    }
    for(index = 0; index < level.missileentities.size; index++) {
      wait(0.05);
      if(!isDefined(self)) {
        return;
      }
      grenade = level.missileentities[index];
      if(!isDefined(grenade)) {
        continue;
      }
      if(grenade == self) {
        continue;
      }
      if(!grenade.weapon.destroyablebytrophysystem) {
        continue;
      }
      switch (grenade.model) {
        case "t6_wpn_grenade_supply_projectile": {
          continue;
        }
      }
      if(grenade.weapon == self.weapon) {
        if(self.trophysystemstationary == 0 && grenade.trophysystemstationary == 1) {
          continue;
        }
      }
      if(!isDefined(grenade.owner)) {
        grenade.owner = getmissileowner(grenade);
      }
      if(isDefined(grenade.owner)) {
        if(level.teambased) {
          if(grenade.owner.team == owner.team) {
            continue;
          }
        } else if(grenade.owner == owner) {
          continue;
        }
        grenadedistancesquared = distancesquared(grenade.origin, self.origin);
        if(grenadedistancesquared < 262144) {
          if(bullettracepassed(grenade.origin, self.origin + vectorscale((0, 0, 1), 29), 0, self, grenade, 0, 1)) {
            playFX(level.trophylongflashfx, self.origin + vectorscale((0, 0, 1), 15), grenade.origin - self.origin, anglestoup(self.angles));
            owner thread projectileexplode(grenade, self);
            index--;
            self playSound("wpn_trophy_alert");
            if(getdvarint("player_sustainAmmo") == 0) {
              self.ammo--;
              if(self.ammo <= 0) {
                self thread trophysystemdetonate();
              }
            }
          }
        }
      }
    }
  }
}

function projectileexplode(projectile, trophy) {
  self endon("death");
  projposition = projectile.origin;
  playFX(level.trophydetonationfx, projposition);
  projectile notify("trophy_destroyed");
  trophy radiusdamage(projposition, 128, 105, 10, self);
  scoreevents::processscoreevent("trophy_defense", self);
  self challenges::trophy_defense(projposition, 512);
  if(self util::is_item_purchased("trophy_system")) {
    self addplayerstat("destroy_explosive_with_trophy", 1);
  }
  self addweaponstat(trophy.weapon, "CombatRecordStat", 1);
  projectile delete();
}

function trophydestroytacinsert(tacinsert, trophy) {
  self endon("death");
  tacpos = tacinsert.origin;
  playFX(level.trophydetonationfx, tacinsert.origin);
  tacinsert thread tacticalinsertion::tacticalinsertiondestroyedbytrophysystem(self, trophy);
  trophy radiusdamage(tacpos, 128, 105, 10, self);
  scoreevents::processscoreevent("trophy_defense", self);
  if(self util::is_item_purchased("trophy_system")) {
    self addplayerstat("destroy_explosive_with_trophy", 1);
  }
  self addweaponstat(trophy.weapon, "CombatRecordStat", 1);
}

function trophysystemdetonate(attacker, weapon, target) {
  if(!isDefined(weapon) || !weapon.isemp) {
    playFX(level._equipment_explode_fx_lg, self.origin);
  }
  if(isDefined(attacker) && self.owner util::isenemyplayer(attacker)) {
    attacker challenges::destroyedequipment(weapon);
    scoreevents::processscoreevent("destroyed_trophy_system", attacker, self.owner, weapon);
  }
  playsoundatposition("exp_trophy_system", self.origin);
  self delete();
}

function watchtrophysystemdamage(watcher) {
  self endon("death");
  self endon("hacked");
  self setCanDamage(1);
  damagemax = 20;
  if(!self util::ishacked()) {
    self.damagetaken = 0;
  }
  self.maxhealth = 10000;
  self.health = self.maxhealth;
  self setmaxhealth(self.maxhealth);
  attacker = undefined;
  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
    attacker = self[[level.figure_out_attacker]](attacker);
    if(!isplayer(attacker)) {
      continue;
    }
    if(level.teambased) {
      if(!level.hardcoremode && self.owner.team == attacker.pers["team"] && self.owner != attacker) {
        continue;
      }
    }
    if(watcher.stuntime > 0 && weapon.dostun) {
      self thread weaponobjects::stunstart(watcher, watcher.stuntime);
    }
    if(weapon.dodamagefeedback) {
      if(level.teambased && self.owner.team != attacker.team) {
        if(damagefeedback::dodamagefeedback(weapon, attacker)) {
          attacker damagefeedback::update();
        }
      } else if(!level.teambased && self.owner != attacker) {
        if(damagefeedback::dodamagefeedback(weapon, attacker)) {
          attacker damagefeedback::update();
        }
      }
    }
    if(type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
      self.damagetaken = damagemax;
    } else {
      self.damagetaken = self.damagetaken + damage;
    }
    if(self.damagetaken >= damagemax) {
      watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
      return;
    }
  }
}

function ammo_scavenger(weapon) {
  self ammo_reset();
}

function ammo_reset() {
  self._trophy_system_ammo1 = undefined;
  self._trophy_system_ammo2 = undefined;
}

function ammo_get(weapon) {
  totalammo = weapon.ammocountequipment;
  if(isDefined(self._trophy_system_ammo1) && !self util::ishacked()) {
    totalammo = self._trophy_system_ammo1;
    self._trophy_system_ammo1 = undefined;
    if(isDefined(self._trophy_system_ammo2)) {
      self._trophy_system_ammo1 = self._trophy_system_ammo2;
      self._trophy_system_ammo2 = undefined;
    }
  }
  return totalammo;
}

function ammo_weapon_pickup(ammo) {
  if(isDefined(ammo)) {
    if(isDefined(self._trophy_system_ammo1)) {
      self._trophy_system_ammo2 = self._trophy_system_ammo1;
      self._trophy_system_ammo1 = ammo;
    } else {
      self._trophy_system_ammo1 = ammo;
    }
  }
}

function ammo_weapon_hacked(ammo) {
  self ammo_weapon_pickup(ammo);
}