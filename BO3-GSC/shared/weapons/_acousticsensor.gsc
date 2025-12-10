/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_acousticsensor.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace acousticsensor;

function init_shared() {
  level._effect["acousticsensor_enemy_light"] = "_t6/misc/fx_equip_light_red";
  level._effect["acousticsensor_friendly_light"] = "_t6/misc/fx_equip_light_green";
  callback::add_weapon_watcher(&createacousticsensorwatcher);
}

function createacousticsensorwatcher() {
  watcher = self weaponobjects::createuseweaponobjectwatcher("acoustic_sensor", self.team);
  watcher.onspawn = &onspawnacousticsensor;
  watcher.ondetonatecallback = &acousticsensordetonate;
  watcher.stun = &weaponobjects::weaponstun;
  watcher.stuntime = 5;
  watcher.hackable = 1;
  watcher.ondamage = &watchacousticsensordamage;
}

function onspawnacousticsensor(watcher, player) {
  self endon("death");
  self thread weaponobjects::onspawnuseweaponobject(watcher, player);
  player.acousticsensor = self;
  self setowner(player);
  self setteam(player.team);
  self.owner = player;
  self playLoopSound("fly_acoustic_sensor_lp");
  if(!self util::ishacked()) {
    player addweaponstat(self.weapon, "used", 1);
  }
  self thread watchshutdown(player, self.origin);
}

function acousticsensordetonate(attacker, weapon, target) {
  if(!isDefined(weapon) || !weapon.isemp) {
    playFX(level._equipment_explode_fx, self.origin);
  }
  if(isDefined(attacker)) {
    if(self.owner util::isenemyplayer(attacker)) {
      attacker challenges::destroyedequipment(weapon);
      scoreevents::processscoreevent("destroyed_motion_sensor", attacker, self.owner, weapon);
    }
  }
  playsoundatposition("dst_equipment_destroy", self.origin);
  self destroyent();
}

function destroyent() {
  self delete();
}

function watchshutdown(player, origin) {
  self util::waittill_any("death", "hacked");
  if(isDefined(player)) {
    player.acousticsensor = undefined;
  }
}

function watchacousticsensordamage(watcher) {
  self endon("death");
  self endon("hacked");
  self setCanDamage(1);
  damagemax = 100;
  if(!self util::ishacked()) {
    self.damagetaken = 0;
  }
  while(true) {
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon, idflags);
    if(!isDefined(attacker) || !isplayer(attacker)) {
      continue;
    }
    if(level.teambased && attacker.team == self.owner.team && attacker != self.owner) {
      continue;
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
    if(isplayer(attacker) && level.teambased && isDefined(attacker.team) && self.owner.team == attacker.team && attacker != self.owner) {
      continue;
    }
    if(type == "MOD_MELEE" || weapon.isemp) {
      self.damagetaken = damagemax;
    } else {
      self.damagetaken = self.damagetaken + damage;
    }
    if(self.damagetaken >= damagemax) {
      watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
      return;
    }
  }
}