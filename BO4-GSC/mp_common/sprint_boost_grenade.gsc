/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\sprint_boost_grenade.gsc
***********************************************/

#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;

#namespace sprint_boost_grenade;

autoexec __init__system__() {
  system::register(#"sprint_boost_grenade", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"satchel_charge_enemy_light"] = #"weapon/fx_c4_light_orng";
  level._effect[#"satchel_charge_friendly_light"] = #"weapon/fx_c4_light_blue";
  weaponobjects::function_e6400478(#"sprint_boost_grenade", &create_grenade_watcher, 1);
}

create_grenade_watcher(watcher) {
  watcher.watchforfire = 1;
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.onspawn = &grenade_spawn;
}

grenade_spawn(watcher, owner) {
  self endon(#"grenade_timeout");
  self thread grenade_timeout(10);
  self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
  radius = self.weapon.sprintboostradius;
  duration = self.weapon.sprintboostduration;

  if(!(isDefined(self.previouslyhacked) && self.previouslyhacked)) {
    if(isDefined(owner)) {
      owner stats::function_e24eec31(self.weapon, #"used", 1);
      origin = owner.origin;
    }

    boost_on_throw = 1;
    detonated = 0;

    if(!boost_on_throw) {
      waitresult = self waittill(#"explode");
      detonated = 1;
    }

    level thread apply_sprint_boost_to_players(owner, waitresult.position, radius, duration);

    if(!detonated) {
      self detonate(owner);
    }
  }
}

grenade_timeout(timeout) {
  self endon(#"death");
  frames = int(timeout / float(function_60d95f53()) / 1000);
  waitframe(frames);
  self notify(#"grenade_timeout");
}

apply_sprint_boost_to_players(owner, origin, radius, duration) {
  if(!isDefined(owner)) {
    return;
  }

  if(!isDefined(owner.team)) {
    return;
  }

  if(!isDefined(origin)) {
    return;
  }

  radiussq = (isDefined(radius) ? radius : 150) * (isDefined(radius) ? radius : 150);

  foreach(player in level.players) {
    if(!isplayer(player)) {
      continue;
    }

    if(util::function_fbce7263(player.team, owner.team)) {
      continue;
    }

    if(distancesquared(player.origin, origin) > radiussq) {
      continue;
    }

    player thread apply_sprint_boost(duration);
  }
}

apply_sprint_boost(duration) {
  player = self;
  player endon(#"death", #"disconnect");
  player notify(#"apply_sprint_boost_singleton");
  player endon(#"apply_sprint_boost_singleton");
  player setsprintboost(1);
  duration = math::clamp(isDefined(duration) ? duration : 10, 1, 1200);
  frames_to_wait = int(duration / float(function_60d95f53()) / 1000);
  waitframe(frames_to_wait);
  player setsprintboost(0);
}