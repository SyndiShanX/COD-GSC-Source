/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_acousticsensor.gsc
***************************************/

#include common_scripts\utility;

init() {
  level._effect["acousticsensor_enemy_light"] = loadfx("misc/fx_equip_light_red");
  level._effect["acousticsensor_friendly_light"] = loadfx("misc/fx_equip_light_green");
}
createAcousticSensorWatcher() {
  watcher = self maps\mp\gametypes\_weaponobjects::createUseWeaponObjectWatcher("acoustic_sensor", "acoustic_sensor_mp", self.team);
  watcher.onSpawn = ::onSpawnAcousticSensor;
  watcher.detonate = ::acousticSensorDetonate;
  watcher.stun = maps\mp\gametypes\_weaponobjects::weaponStun;
  watcher.stunTime = 5;
  watcher.reconModel = "t5_weapon_acoustic_sensor_world_detect";
  watcher.hackable = true;
  watcher.onDamage = ::watchAcousticSensorDamage;
}
onSpawnAcousticSensor(watcher, player) {
  self endon("death");
  self thread maps\mp\gametypes\_weaponobjects::onSpawnUseWeaponObject(watcher, player);
  player.acousticSensor = self;
  self SetOwner(player);
  self SetTeam(player.team);
  self.owner = player;
  self playLoopSound("fly_acoustic_sensor_lp");
  if(!self maps\mp\gametypes\_weaponobjects::isHacked()) {
    player maps\mp\gametypes\_globallogic_score::setWeaponStat("acoustic_sensor_mp", 1, "used");
  }
  self thread watchShutdown(player, self.origin);
}
acousticSensorDetonate(attacker) {
  playFX(level._equipment_explode_fx, self.origin);
  PlaySoundAtPosition("dst_equipment_destroy", self.origin);
  self destroyEnt();
}
destroyEnt() {
  self delete();
}
watchShutdown(player, origin) {
  self waittill_any("death", "hacked");
  if(isDefined(player))
    player.acousticSensor = undefined;
}
watchAcousticSensorDamage(watcher) {
  self endon("death");
  self endon("hacked");
  self setCanDamage(true);
  damageMax = 100;
  if(!self maps\mp\gametypes\_weaponobjects::isHacked()) {
    self.damageTaken = 0;
  }
  while(true) {
    self.maxhealth = 100000;
    self.health = self.maxhealth;
    self waittill("damage", damage, attacker, direction, point, type, tagName, modelName, partname, weaponName, iDFlags);
    if(!isDefined(attacker) || !isplayer(attacker))
      continue;
    if(level.teamBased && attacker.team == self.owner.team && attacker != self.owner)
      continue;
    if(isDefined(weaponName)) {
      switch (weaponName) {
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
          if(watcher.stunTime > 0) {
            self thread maps\mp\gametypes\_weaponobjects::stunStart(watcher, watcher.stunTime);
          }
          if(level.teambased && self.owner.team != attacker.team) {
            if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
              attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
          } else if(!level.teambased && self.owner != attacker) {
            if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
              attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
          }
          continue;
        default:
          if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weaponName, attacker))
            attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
          break;
      }
    }
    if(isPlayer(attacker) && level.teambased && isDefined(attacker.team) && self.owner.team == attacker.team && attacker != self.owner)
      continue;
    if((type == "MOD_MELEE")) {
      self.damageTaken = damageMax;
    } else {
      self.damageTaken += damage;
    }
    if(self.damageTaken >= damageMax) {
      attacker maps\mp\_properks::shotEquipment(self.owner, iDFlags);
      watcher thread maps\mp\gametypes\_weaponobjects::waitAndDetonate(self, 0.0, attacker);
      return;
    }
  }
}