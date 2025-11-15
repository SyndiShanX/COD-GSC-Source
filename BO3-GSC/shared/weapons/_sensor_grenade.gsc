/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_sensor_grenade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_decoy;
#using scripts\shared\weapons\_hacker_tool;
#using scripts\shared\weapons\_weaponobjects;
#namespace sensor_grenade;

function init_shared() {
  level.isplayertrackedfunc = & isplayertracked;
  callback::add_weapon_watcher( & createsensorgrenadewatcher);
}

function createsensorgrenadewatcher() {
  watcher = self weaponobjects::createuseweaponobjectwatcher("sensor_grenade", self.team);
  watcher.headicon = 0;
  watcher.onspawn = & onspawnsensorgrenade;
  watcher.ondetonatecallback = & sensorgrenadedestroyed;
  watcher.onstun = & weaponobjects::weaponstun;
  watcher.stuntime = 0;
  watcher.ondamage = & watchsensorgrenadedamage;
  watcher.enemydestroy = 1;
}

function onspawnsensorgrenade(watcher, player) {
  self endon("death");
  self thread weaponobjects::onspawnuseweaponobject(watcher, player);
  self setowner(player);
  self setteam(player.team);
  self.owner = player;
  self playLoopSound("wpn_sensor_nade_lp");
  self hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
  player addweaponstat(self.weapon, "used", 1);
  self thread watchforstationary(player);
  self thread watchforexplode(player);
  self thread watch_for_decoys(player);
}

function watchforstationary(owner) {
  self endon("death");
  self endon("hacked");
  self endon("explode");
  owner endon("death");
  owner endon("disconnect");
  self waittill("stationary");
  checkfortracking(self.origin);
}

function watchforexplode(owner) {
  self endon("hacked");
  self endon("delete");
  owner endon("death");
  owner endon("disconnect");
  self waittill("explode", origin);
  checkfortracking(origin + (0, 0, 1));
}

function checkfortracking(origin) {
  if(isDefined(self.owner) == 0) {
    return;
  }
  players = level.players;
  foreach(player in level.players) {
    if(player util::isenemyplayer(self.owner)) {
      if(!player hasperk("specialty_nomotionsensor") && (!(player hasperk("specialty_sengrenjammer") && player clientfield::get("sg_jammer_active")))) {
        if(distancesquared(player.origin, origin) < 562500) {
          trace = bulletTrace(origin, player.origin + vectorscale((0, 0, 1), 12), 0, player);
          if(trace["fraction"] == 1) {
            self.owner tracksensorgrenadevictim(player);
          }
        }
      }
    }
  }
}

function tracksensorgrenadevictim(victim) {
  if(!isDefined(self.sensorgrenadedata)) {
    self.sensorgrenadedata = [];
  }
  if(!isDefined(self.sensorgrenadedata[victim.clientid])) {
    self.sensorgrenadedata[victim.clientid] = gettime();
  }
}

function isplayertracked(player, time) {
  playertracked = 0;
  if(isDefined(self.sensorgrenadedata) && isDefined(self.sensorgrenadedata[player.clientid])) {
    if((self.sensorgrenadedata[player.clientid] + 10000) > time) {
      playertracked = 1;
    }
  }
  return playertracked;
}

function sensorgrenadedestroyed(attacker, weapon, target) {
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

function watchsensorgrenadedamage(watcher) {
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
    if(type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
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

function watch_for_decoys(owner) {
  self waittill("stationary");
  players = level.players;
  foreach(player in level.players) {
    if(player util::isenemyplayer(self.owner)) {
      if(isalive(player) && player hasperk("specialty_decoy")) {
        if(distancesquared(player.origin, self.origin) < 57600) {
          player thread watch_decoy(self);
        }
      }
    }
  }
}

function get_decoy_spawn_loc() {
  return self.origin - (240 * anglesToForward(self.angles));
}

function watch_decoy(sensor_grenade) {
  origin = self get_decoy_spawn_loc();
  decoy_grenade = sys::spawn("script_model", origin);
  decoy_grenade.angles = -1 * self.angles;
  wait(0.05);
  decoy_grenade.initial_velocity = -1 * self getvelocity();
  decoy_grenade thread decoy::simulate_weapon_fire(self);
  wait(15);
  decoy_grenade notify("done");
  decoy_grenade notify("death_before_explode");
  decoy_grenade delete();
}