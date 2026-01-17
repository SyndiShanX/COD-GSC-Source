/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_scrambler.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace scrambler;

function init_shared() {
  level._effect["scrambler_enemy_light"] = "_t6/misc/fx_equip_light_red";
  level._effect["scrambler_friendly_light"] = "_t6/misc/fx_equip_light_green";
  level.scramblerweapon = getweapon("scrambler");
  level.scramblerlength = 30;
  level.scramblerouterradiussq = 1000000;
  level.scramblerinnerradiussq = 360000;
  clientfield::register("missile", "scrambler", 1, 1, "int");
}

function createscramblerwatcher() {
  watcher = self weaponobjects::createuseweaponobjectwatcher("scrambler", self.team);
  watcher.onspawn = &onspawnscrambler;
  watcher.ondetonatecallback = &scramblerdetonate;
  watcher.onstun = &weaponobjects::weaponstun;
  watcher.stuntime = 5;
  watcher.hackable = 1;
  watcher.ondamage = &watchscramblerdamage;
}

function onspawnscrambler(watcher, player) {
  player endon("disconnect");
  self endon("death");
  self thread weaponobjects::onspawnuseweaponobject(watcher, player);
  player.scrambler = self;
  self setowner(player);
  self setteam(player.team);
  self.owner = player;
  self clientfield::set("scrambler", 1);
  if(!self util::ishacked()) {
    player addweaponstat(self.weapon, "used", 1);
  }
  self thread watchshutdown(player);
  level notify("scrambler_spawn");
}

function scramblerdetonate(attacker, weapon, target) {
  if(!isDefined(weapon) || !weapon.isemp) {
    playFX(level._equipment_explode_fx, self.origin);
  }
  if(self.owner util::isenemyplayer(attacker)) {
    attacker challenges::destroyedequipment(weapon);
  }
  playsoundatposition("dst_equipment_destroy", self.origin);
  self delete();
}

function watchshutdown(player) {
  self util::waittill_any("death", "hacked");
  level notify("scrambler_death");
  if(isDefined(player)) {
    player.scrambler = undefined;
  }
}

function destroyent() {
  self delete();
}

function watchscramblerdamage(watcher) {
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
    }
  }
}

function ownersameteam(owner1, owner2) {
  if(!level.teambased) {
    return 0;
  }
  if(!isDefined(owner1) || !isDefined(owner2)) {
    return 0;
  }
  if(!isDefined(owner1.team) || !isDefined(owner2.team)) {
    return 0;
  }
  return owner1.team == owner2.team;
}

function checkscramblerstun() {
  scramblers = getEntArray("grenade", "classname");
  if(isDefined(self.name) && self.name == "scrambler") {
    return false;
  }
  for(i = 0; i < scramblers.size; i++) {
    scrambler = scramblers[i];
    if(!isalive(scrambler)) {
      continue;
    }
    if(!isDefined(scrambler.name)) {
      continue;
    }
    if(scrambler.name != "scrambler") {
      continue;
    }
    if(ownersameteam(self.owner, scrambler.owner)) {
      continue;
    }
    flattenedselforigin = (self.origin[0], self.origin[1], 0);
    flattenedscramblerorigin = (scrambler.origin[0], scrambler.origin[1], 0);
    if(distancesquared(flattenedselforigin, flattenedscramblerorigin) < level.scramblerouterradiussq) {
      return true;
    }
  }
  return false;
}