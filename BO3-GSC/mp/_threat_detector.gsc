/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_threat_detector.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_hacker_tool;
#using scripts\shared\weapons\_weaponobjects;
#namespace threat_detector;

function autoexec __init__sytem__() {
  system::register("threat_detector", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("missile", "threat_detector", 1, 1, "int");
  callback::add_weapon_watcher( & createthreatdetectorwatcher);
}

function createthreatdetectorwatcher() {
  watcher = self weaponobjects::createuseweaponobjectwatcher("threat_detector", self.team);
  watcher.headicon = 0;
  watcher.onspawn = & onspawnthreatdetector;
  watcher.ondetonatecallback = & threatdetectordestroyed;
  watcher.stun = & weaponobjects::weaponstun;
  watcher.stuntime = 0;
  watcher.ondamage = & watchthreatdetectordamage;
  watcher.enemydestroy = 1;
}

function onspawnthreatdetector(watcher, player) {
  self endon("death");
  self thread weaponobjects::onspawnuseweaponobject(watcher, player);
  self setowner(player);
  self setteam(player.team);
  self.owner = player;
  self playLoopSound("wpn_sensor_nade_lp");
  self hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
  player addweaponstat(self.weapon, "used", 1);
  self thread watchforstationary(player);
}

function watchforstationary(owner) {
  self endon("death");
  self endon("hacked");
  self endon("explode");
  owner endon("death");
  owner endon("disconnect");
  self waittill("stationary");
  self clientfield::set("threat_detector", 1);
}

function tracksensorgrenadevictim(victim) {
  if(!isDefined(self.sensorgrenadedata)) {
    self.sensorgrenadedata = [];
  }
  if(!isDefined(self.sensorgrenadedata[victim.clientid])) {
    self.sensorgrenadedata[victim.clientid] = gettime();
  }
  self clientfield::set_to_player("threat_detected", 1);
}

function threatdetectordestroyed(attacker, weapon, target) {
  if(!isDefined(weapon) || !weapon.isemp) {
    playFX(level._equipment_explode_fx, self.origin);
  }
  if(isDefined(attacker)) {
    if(self.owner util::isenemyplayer(attacker)) {
      attacker challenges::destroyedequipment(weapon);
      scoreevents::processscoreevent("destroyed_motion_sensor", attacker, self.owner, weapon);
    }
  }
  playsoundatposition("wpn_sensor_nade_explo", self.origin);
  self delete();
}

function watchthreatdetectordamage(watcher) {
  self endon("death");
  self endon("hacked");
  self setCanDamage(1);
  damagemax = 1;
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
    if(level.teambased && isplayer(attacker)) {
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