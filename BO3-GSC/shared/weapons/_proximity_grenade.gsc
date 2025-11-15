/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_proximity_grenade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#namespace proximity_grenade;

function init_shared() {
  level._effect["prox_grenade_friendly_default"] = "weapon/fx_prox_grenade_scan_blue";
  level._effect["prox_grenade_friendly_warning"] = "weapon/fx_prox_grenade_wrn_grn";
  level._effect["prox_grenade_enemy_default"] = "weapon/fx_prox_grenade_scan_orng";
  level._effect["prox_grenade_enemy_warning"] = "weapon/fx_prox_grenade_wrn_red";
  level._effect["prox_grenade_player_shock"] = "weapon/fx_prox_grenade_impact_player_spwner";
  level._effect["prox_grenade_chain_bolt"] = "weapon/fx_prox_grenade_elec_jump";
  level.proximitygrenadedetectionradius = getdvarint("scr_proximityGrenadeDetectionRadius", 180);
  level.proximitygrenadeduration = getdvarfloat("scr_proximityGrenadeDuration", 1.2);
  level.proximitygrenadegraceperiod = getdvarfloat("scr_proximityGrenadeGracePeriod", 0.05);
  level.proximitygrenadedotdamageamount = getdvarint("scr_proximityGrenadeDOTDamageAmount", 1);
  level.proximitygrenadedotdamageamounthardcore = getdvarint("scr_proximityGrenadeDOTDamageAmountHardcore", 1);
  level.proximitygrenadedotdamagetime = getdvarfloat("scr_proximityGrenadeDOTDamageTime", 0.2);
  level.proximitygrenadedotdamageinstances = getdvarint("scr_proximityGrenadeDOTDamageInstances", 4);
  level.proximitygrenadeactivationtime = getdvarfloat("scr_proximityGrenadeActivationTime", 0.1);
  level.proximitychaindebug = getdvarint("scr_proximityChainDebug", 0);
  level.proximitychaingraceperiod = getdvarint("scr_proximityChainGracePeriod", 2500);
  level.proximitychainboltspeed = getdvarfloat("scr_proximityChainBoltSpeed", 400);
  level.proximitygrenadeprotectedtime = getdvarfloat("scr_proximityGrenadeProtectedTime", 0.45);
  level.poisonfxduration = 6;
  level thread register();
  callback::on_spawned( & on_player_spawned);
  callback::add_weapon_damage(getweapon("proximity_grenade"), & on_damage);
  level thread updatedvars();
}

function register() {
  clientfield::register("toplayer", "tazered", 1, 1, "int");
}

function updatedvars() {
  while(true) {
    level.proximitygrenadedetectionradius = getdvarint("scr_proximityGrenadeDetectionRadius", level.proximitygrenadedetectionradius);
    level.proximitygrenadeduration = getdvarfloat("scr_proximityGrenadeDuration", 1.5);
    level.proximitygrenadegraceperiod = getdvarfloat("scr_proximityGrenadeGracePeriod", level.proximitygrenadegraceperiod);
    level.proximitygrenadedotdamageamount = getdvarint("scr_proximityGrenadeDOTDamageAmount", level.proximitygrenadedotdamageamount);
    level.proximitygrenadedotdamageamounthardcore = getdvarint("scr_proximityGrenadeDOTDamageAmountHardcore", level.proximitygrenadedotdamageamounthardcore);
    level.proximitygrenadedotdamagetime = getdvarfloat("scr_proximityGrenadeDOTDamageTime", level.proximitygrenadedotdamagetime);
    level.proximitygrenadedotdamageinstances = getdvarint("scr_proximityGrenadeDOTDamageInstances", level.proximitygrenadedotdamageinstances);
    level.proximitygrenadeactivationtime = getdvarfloat("scr_proximityGrenadeActivationTime", level.proximitygrenadeactivationtime);
    level.proximitychaindebug = getdvarint("scr_proximityChainDebug", level.proximitychaindebug);
    level.proximitychaingraceperiod = getdvarint("scr_proximityChainGracePeriod", level.proximitychaingraceperiod);
    level.proximitychainboltspeed = getdvarfloat("scr_proximityChainBoltSpeed", level.proximitychainboltspeed);
    level.proximitygrenadeprotectedtime = getdvarfloat("scr_proximityGrenadeProtectedTime", level.proximitygrenadeprotectedtime);
    wait(1);
  }
}

function createproximitygrenadewatcher() {
  watcher = self weaponobjects::createproximityweaponobjectwatcher("proximity_grenade", self.team);
  watcher.watchforfire = 1;
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.headicon = 0;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.detectiongraceperiod = level.proximitygrenadegraceperiod;
  watcher.detonateradius = level.proximitygrenadedetectionradius;
  watcher.onstun = & weaponobjects::weaponstun;
  watcher.stuntime = 1;
  watcher.ondetonatecallback = & proximitydetonate;
  watcher.activationdelay = level.proximitygrenadeactivationtime;
  watcher.activatesound = "wpn_claymore_alert";
  watcher.immunespecialty = "specialty_immunetriggershock";
  watcher.onspawn = & onspawnproximitygrenadeweaponobject;
}

function creategadgetproximitygrenadewatcher() {
  watcher = self weaponobjects::createproximityweaponobjectwatcher("gadget_sticky_proximity", self.team);
  watcher.watchforfire = 1;
  watcher.hackable = 1;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.headicon = 0;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.detectiongraceperiod = level.proximitygrenadegraceperiod;
  watcher.detonateradius = level.proximitygrenadedetectionradius;
  watcher.onstun = & weaponobjects::weaponstun;
  watcher.stuntime = 1;
  watcher.ondetonatecallback = & proximitydetonate;
  watcher.activationdelay = level.proximitygrenadeactivationtime;
  watcher.activatesound = "wpn_claymore_alert";
  watcher.onspawn = & onspawnproximitygrenadeweaponobject;
}

function onspawnproximitygrenadeweaponobject(watcher, owner) {
  self thread setupkillcament();
  owner addweaponstat(self.weapon, "used", 1);
  if(isDefined(self.weapon) && self.weapon.proximitydetonation > 0) {
    watcher.detonateradius = self.weapon.proximitydetonation;
  }
  weaponobjects::onspawnproximityweaponobject(watcher, owner);
  self trackonowner(self.owner);
}

function trackonowner(owner) {
  if(level.trackproximitygrenadesonowner === 1) {
    if(!isDefined(owner)) {
      return;
    }
    if(!isDefined(owner.activeproximitygrenades)) {
      owner.activeproximitygrenades = [];
    } else {
      arrayremovevalue(owner.activeproximitygrenades, undefined);
    }
    owner.activeproximitygrenades[owner.activeproximitygrenades.size] = self;
  }
}

function setupkillcament() {
  self endon("death");
  self util::waittillnotmoving();
  self.killcament = spawn("script_model", self.origin + vectorscale((0, 0, 1), 8));
  self thread cleanupkillcamentondeath();
}

function cleanupkillcamentondeath() {
  self waittill("death");
  self.killcament util::deleteaftertime(4 + (level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances));
}

function proximitydetonate(attacker, weapon, target) {
  if(isDefined(weapon) && weapon.isvalid) {
    if(isDefined(attacker)) {
      if(self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedexplosive(weapon);
        scoreevents::processscoreevent("destroyed_proxy", attacker, self.owner, weapon);
      }
    }
  }
  weaponobjects::weapondetonate(attacker, weapon);
}

function proximitygrenadedamageplayer(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain) {
  self thread damageplayerinradius(einflictor.origin, eattacker, killcament);
  if(weapon.chaineventradius > 0 && !self hasperk("specialty_proximityprotection")) {
    self thread proximitygrenadechain(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain, 0);
  }
}

function getproximitychain() {
  if(!isDefined(level.proximitychains)) {
    level.proximitychains = [];
  }
  foreach(chain in level.proximitychains) {
    if(!chainisactive(chain)) {
      return chain;
    }
  }
  chain = spawnStruct();
  level.proximitychains[level.proximitychains.size] = chain;
  return chain;
}

function chainisactive(chain) {
  if(isDefined(chain.activeendtime) && chain.activeendtime > gettime()) {
    return true;
  }
  return false;
}

function cleanupproximitychainent() {
  self.cleanup = 1;
  any_active = 1;
  while(any_active) {
    wait(1);
    if(!isDefined(self)) {
      return;
    }
    any_active = 0;
    foreach(proximitychain in self.chains) {
      if(proximitychain.activeendtime > gettime()) {
        any_active = 1;
        break;
      }
    }
  }
  if(isDefined(self)) {
    self delete();
  }
}

function isinchain(player) {
  player_num = player getentitynumber();
  return isDefined(self.chain_players[player_num]);
}

function addplayertochain(player) {
  player_num = player getentitynumber();
  self.chain_players[player_num] = player;
}

function proximitygrenadechain(eattacker, einflictor, killcament, weapon, meansofdeath, damage, proximitychain, delay) {
  self endon("disconnect");
  self endon("death");
  eattacker endon("disconnect");
  if(!isDefined(proximitychain)) {
    proximitychain = getproximitychain();
    proximitychain.chaineventnum = 0;
    if(!isDefined(einflictor.proximitychainent)) {
      einflictor.proximitychainent = spawn("script_origin", self.origin);
      einflictor.proximitychainent.chains = [];
      einflictor.proximitychainent.chain_players = [];
    }
    proximitychain.proximitychainent = einflictor.proximitychainent;
    proximitychain.proximitychainent.chains[proximitychain.proximitychainent.chains.size] = proximitychain;
  }
  proximitychain.chaineventnum = proximitychain.chaineventnum + 1;
  if(proximitychain.chaineventnum >= weapon.chaineventmax) {
    return;
  }
  chaineventradiussq = weapon.chaineventradius * weapon.chaineventradius;
  endtime = gettime() + weapon.chaineventtime;
  proximitychain.proximitychainent addplayertochain(self);
  proximitychain.activeendtime = (endtime + (delay * 1000)) + level.proximitychaingraceperiod;
  if(delay > 0) {
    wait(delay);
  }
  if(!isDefined(proximitychain.proximitychainent.cleanup)) {
    proximitychain.proximitychainent thread cleanupproximitychainent();
  }
  while(true) {
    currenttime = gettime();
    if(endtime < currenttime) {
      return;
    }
    closestplayers = arraysort(level.players, self.origin, 1);
    foreach(player in closestplayers) {
      wait(0.05);
      if(proximitychain.chaineventnum >= weapon.chaineventmax) {
        return;
      }
      if(!isDefined(player) || !isalive(player) || player == self) {
        continue;
      }
      if(player.sessionstate != "playing") {
        continue;
      }
      distancesq = distancesquared(player.origin, self.origin);
      if(distancesq > chaineventradiussq) {
        break;
      }
      if(proximitychain.proximitychainent isinchain(player)) {
        continue;
      }
      if(level.proximitychaindebug || weaponobjects::friendlyfirecheck(eattacker, player)) {
        if(level.proximitychaindebug || !player hasperk("specialty_proximityprotection")) {
          self thread chainplayer(eattacker, killcament, weapon, meansofdeath, damage, proximitychain, player, distancesq);
        }
      }
    }
    wait(0.05);
  }
}

function chainplayer(eattacker, killcament, weapon, meansofdeath, damage, proximitychain, player, distancesq) {
  waittime = 0.25;
  speedsq = level.proximitychainboltspeed * level.proximitychainboltspeed;
  if(speedsq > 100 && distancesq > 1) {
    waittime = distancesq / speedsq;
  }
  player thread proximitygrenadechain(eattacker, self, killcament, weapon, meansofdeath, damage, proximitychain, waittime);
  wait(0.05);
  if(level.proximitychaindebug) {
    color = (1, 1, 1);
    alpha = 1;
    depth = 0;
    time = 200;
    util::debug_line(self.origin + vectorscale((0, 0, 1), 50), player.origin + vectorscale((0, 0, 1), 50), color, alpha, depth, time);
  }
  self tesla_play_arc_fx(player, waittime);
  player thread damageplayerinradius(self.origin, eattacker, killcament);
}

function tesla_play_arc_fx(target, waittime) {
  if(!isDefined(self) || !isDefined(target)) {
    return;
  }
  tag = "J_SpineUpper";
  target_tag = "J_SpineUpper";
  origin = self gettagorigin(tag);
  target_origin = target gettagorigin(target_tag);
  distance_squared = 16384;
  if(distancesquared(origin, target_origin) < distance_squared) {
    return;
  }
  fxorg = spawn("script_model", origin);
  fxorg setModel("tag_origin");
  fx = playFXOnTag(level._effect["prox_grenade_chain_bolt"], fxorg, "tag_origin");
  playsoundatposition("wpn_tesla_bounce", fxorg.origin);
  fxorg moveto(target_origin, waittime);
  fxorg waittill("movedone");
  fxorg delete();
}

function debugchainsphere() {
  util::debug_sphere(self.origin + vectorscale((0, 0, 1), 50), 20, (1, 1, 1), 1, 0);
}

function watchproximitygrenadehitplayer(owner) {
  self endon("death");
  self setowner(owner);
  self setteam(owner.team);
  while(true) {
    self waittill("grenade_bounce", pos, normal, ent, surface);
    if(isDefined(ent) && isplayer(ent) && surface != "riotshield") {
      if(level.teambased && ent.team == self.owner.team) {
        continue;
      }
      self proximitydetonate(self.owner, self.weapon);
      return;
    }
  }
}

function performhudeffects(position, distancetogrenade) {
  forwardvec = vectornormalize(anglesToForward(self.angles));
  rightvec = vectornormalize(anglestoright(self.angles));
  explosionvec = vectornormalize(position - self.origin);
  fdot = vectordot(explosionvec, forwardvec);
  rdot = vectordot(explosionvec, rightvec);
  fangle = acos(fdot);
  rangle = acos(rdot);
}

function damageplayerinradius(position, eattacker, killcament) {
  self notify("proximitygrenadedamagestart");
  self endon("proximitygrenadedamagestart");
  self endon("disconnect");
  self endon("death");
  eattacker endon("disconnect");
  playFXOnTag(level._effect["prox_grenade_player_shock"], self, "J_SpineUpper");
  g_time = gettime();
  if(self util::mayapplyscreeneffect()) {
    if(!self hasperk("specialty_proximityprotection")) {
      self.lastshockedby = eattacker;
      self.shockendtime = gettime() + (level.proximitygrenadeduration * 1000);
      self shellshock("proximity_grenade", level.proximitygrenadeduration, 0);
    }
    self clientfield::set_to_player("tazered", 1);
  }
  self playrumbleonentity("proximity_grenade");
  self playSound("wpn_taser_mine_zap");
  if(!self hasperk("specialty_proximityprotection")) {
    self thread watch_death();
    if(!isDefined(killcament)) {
      killcament = spawn("script_model", position + vectorscale((0, 0, 1), 8));
    }
    killcament.soundmod = "taser_spike";
    killcament util::deleteaftertime(3 + (level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances));
    self util::show_hud(0);
    damage = level.proximitygrenadedotdamageamount;
    if(level.hardcoremode) {
      damage = level.proximitygrenadedotdamageamounthardcore;
    }
    for(i = 0; i < level.proximitygrenadedotdamageinstances; i++) {
      assert(isDefined(eattacker));
      if(!isDefined(killcament)) {
        killcament = spawn("script_model", position + vectorscale((0, 0, 1), 8));
        killcament.soundmod = "taser_spike";
        killcament util::deleteaftertime(3 + (level.proximitygrenadedotdamagetime * (level.proximitygrenadedotdamageinstances - i)));
      }
      self dodamage(damage, position, eattacker, killcament, "none", "MOD_GAS", 0, getweapon("proximity_grenade_aoe"));
      wait(level.proximitygrenadedotdamagetime);
    }
    if((gettime() - g_time) < (level.proximitygrenadeduration * 1000)) {
      wait((gettime() - g_time) / 1000);
    }
    self util::show_hud(1);
  } else {
    wait(level.proximitygrenadeprotectedtime);
  }
  self clientfield::set_to_player("tazered", 0);
}

function proximitydeathwait(owner) {
  self waittill("death");
  self notify("deletesound");
}

function deleteentonownerdeath(owner) {
  self thread deleteentontimeout();
  self thread deleteentaftertime();
  self endon("delete");
  owner waittill("death");
  self notify("deletesound");
}

function deleteentaftertime() {
  self endon("delete");
  wait(10);
  self notify("deletesound");
}

function deleteentontimeout() {
  self endon("delete");
  self waittill("deletesound");
  self delete();
}

function watch_death() {
  self endon("disconnect");
  self notify("proximity_cleanup");
  self endon("proximity_cleanup");
  self waittill("death");
  self stoprumble("proximity_grenade");
  self setblur(0, 0);
  self util::show_hud(1);
  self clientfield::set_to_player("tazered", 0);
}

function on_player_spawned() {
  self thread createproximitygrenadewatcher();
  self thread creategadgetproximitygrenadewatcher();
  self thread begin_other_grenade_tracking();
}

function begin_other_grenade_tracking() {
  self endon("death");
  self endon("disconnect");
  self notify("proximitytrackingstart");
  self endon("proximitytrackingstart");
  for(;;) {
    self waittill("grenade_fire", grenade, weapon, cooktime);
    if(grenade util::ishacked()) {
      continue;
    }
    if(weapon.rootweapon.name == "proximity_grenade") {
      grenade thread watchproximitygrenadehitplayer(self);
    }
  }
}

function on_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
  self thread proximitygrenadedamageplayer(eattacker, einflictor, einflictor.killcament, weapon, meansofdeath, damage, undefined);
}