/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_electroball_grenade.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\zm\_zm;
#using scripts\zm\_zm_elemental_zombies;
#namespace electroball_grenade;

function autoexec __init__sytem__() {
  system::register("electroball_grenade", & __init__, undefined, undefined);
}

function __init__() {
  level.proximitygrenadedetectionradius = getdvarint("scr_proximityGrenadeDetectionRadius", 180);
  level.proximitygrenadegraceperiod = getdvarfloat("scr_proximityGrenadeGracePeriod", 0.05);
  level.proximitygrenadedotdamageamount = getdvarint("scr_proximityGrenadeDOTDamageAmount", 1);
  level.proximitygrenadedotdamageamounthardcore = getdvarint("scr_proximityGrenadeDOTDamageAmountHardcore", 1);
  level.proximitygrenadedotdamagetime = getdvarfloat("scr_proximityGrenadeDOTDamageTime", 0.2);
  level.proximitygrenadedotdamageinstances = getdvarint("scr_proximityGrenadeDOTDamageInstances", 4);
  level.proximitygrenadeactivationtime = getdvarfloat("scr_proximityGrenadeActivationTime", 0.1);
  level.proximitygrenadeprotectedtime = getdvarfloat("scr_proximityGrenadeProtectedTime", 0.45);
  level thread register();
  if(!isdefined(level.spawnprotectiontimems)) {
    level.spawnprotectiontimems = 0;
  }
  callback::on_spawned( & on_player_spawned);
  callback::on_ai_spawned( & on_ai_spawned);
  zm::register_actor_damage_callback( & function_f338543f);
}

function register() {
  clientfield::register("toplayer", "tazered", 1, 1, "int");
  clientfield::register("actor", "electroball_make_sparky", 1, 1, "int");
  clientfield::register("missile", "electroball_stop_trail", 1, 1, "int");
  clientfield::register("missile", "electroball_play_landed_fx", 1, 1, "int");
  clientfield::register("allplayers", "electroball_shock", 1, 1, "int");
}

function function_b0f1e452() {
  if(isplayer(self)) {
    watcher = self weaponobjects::createproximityweaponobjectwatcher("electroball_grenade", self.team);
  } else {
    watcher = self weaponobjects::createproximityweaponobjectwatcher("electroball_grenade", level.zombie_team);
  }
  watcher.watchforfire = 1;
  watcher.hackable = 0;
  watcher.hackertoolradius = level.equipmenthackertoolradius;
  watcher.hackertooltimems = level.equipmenthackertooltimems;
  watcher.headicon = 0;
  watcher.activatefx = 1;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 1;
  watcher.detectiongraceperiod = 0.05;
  watcher.detonateradius = 64;
  watcher.onstun = & weaponobjects::weaponstun;
  watcher.stuntime = 1;
  watcher.ondetonatecallback = & proximitydetonate;
  watcher.activationdelay = 0.05;
  watcher.activatesound = "wpn_claymore_alert";
  watcher.immunespecialty = "specialty_immunetriggershock";
  watcher.onspawn = & function_f424c33d;
}

function function_f424c33d(watcher, owner) {
  self thread setupkillcament();
  if(isplayer(owner)) {
    owner addweaponstat(self.weapon, "used", 1);
  }
  if(isdefined(self.weapon) && self.weapon.proximitydetonation > 0) {
    watcher.detonateradius = self.weapon.proximitydetonation;
  }
  weaponobjects::onspawnproximityweaponobject(watcher, owner);
  self thread function_cb55123a();
  self thread function_658aacad();
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
  weaponobjects::weapondetonate(attacker, weapon);
}

function watchproximitygrenadehitplayer(owner) {
  self endon("death");
  self setteam(owner.team);
  while (true) {
    self waittill("grenade_bounce", pos, normal, ent, surface);
    if(isdefined(ent) && isplayer(ent) && surface != "riotshield") {
      if(level.teambased && ent.team == self.owner.team) {
        continue;
      }
      self proximitydetonate(self.owner, self.weapon);
      return;
    }
  }
}

function performhudeffects(position, distancetogrenade) {
  forwardvec = vectornormalize(anglestoforward(self.angles));
  rightvec = vectornormalize(anglestoright(self.angles));
  explosionvec = vectornormalize(position - self.origin);
  fdot = vectordot(explosionvec, forwardvec);
  rdot = vectordot(explosionvec, rightvec);
  fangle = acos(fdot);
  rangle = acos(rdot);
}

function function_62ffcc2c() {
  self endon("death");
  self endon("disconnect");
  while (true) {
    self waittill("damage", damage, eattacker, dir, point, type, model, tag, part, weapon, flags);
    if(weapon.name == "electroball_grenade") {
      self damageplayerinradius(eattacker);
    }
    wait(0.05);
  }
}

function damageplayerinradius(eattacker) {
  self notify("proximitygrenadedamagestart");
  self endon("proximitygrenadedamagestart");
  self endon("disconnect");
  self endon("death");
  eattacker endon("disconnect");
  self clientfield::set("electroball_shock", 1);
  g_time = gettime();
  if(self util::mayapplyscreeneffect()) {
    self.lastshockedby = eattacker;
    self.shockendtime = gettime() + 100;
    self shellshock("electrocution", 0.1);
    self clientfield::set_to_player("tazered", 1);
  }
  self playrumbleonentity("proximity_grenade");
  self playsound("wpn_taser_mine_zap");
  if(!self hasperk("specialty_proximityprotection")) {
    self thread watch_death();
    self util::show_hud(0);
    if((gettime() - g_time) < 100) {
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
  if(isplayer(self)) {
    self thread function_b0f1e452();
    self thread begin_other_grenade_tracking();
    self thread function_62ffcc2c();
  }
}

function on_ai_spawned() {
  if(self.archetype === "mechz") {
    self thread function_b0f1e452();
    self thread begin_other_grenade_tracking();
  }
}

function begin_other_grenade_tracking() {
  self endon("death");
  self endon("disconnect");
  self notify("proximitytrackingstart");
  self endon("proximitytrackingstart");
  for (;;) {
    self waittill("grenade_fire", grenade, weapon, cooktime);
    if(weapon.rootweapon.name == "electroball_grenade") {
      grenade thread watchproximitygrenadehitplayer(self);
    }
  }
}

function function_cb55123a() {
  self endon("death");
  self endon("disconnect");
  self endon("delete");
  self waittill("grenade_bounce");
  while (true) {
    var_82aacc64 = zm_elemental_zombie::function_d41418b8();
    var_82aacc64 = arraysortclosest(var_82aacc64, self.origin);
    var_199ecc3a = zm_elemental_zombie::function_4aeed0a5("sparky");
    if(!isdefined(level.var_1ae26ca5) || var_199ecc3a < level.var_1ae26ca5) {
      if(!isdefined(level.var_a9284ac8) || (gettime() - level.var_a9284ac8) >= 0.5) {
        foreach(ai_zombie in var_82aacc64) {
          dist_sq = distancesquared(self.origin, ai_zombie.origin);
          if(dist_sq <= 9216 && ai_zombie.is_elemental_zombie !== 1 && ai_zombie.var_3531cf2b !== 1) {
            ai_zombie clientfield::set("electroball_make_sparky", 1);
            ai_zombie zm_elemental_zombie::function_1b1bb1b();
            level.var_a9284ac8 = gettime();
            break;
          }
        }
      }
    }
    wait(0.5);
  }
}

function function_658aacad() {
  self endon("death");
  self endon("disconnect");
  self endon("delete");
  self waittill("grenade_bounce");
  self clientfield::set("electroball_stop_trail", 1);
  self setmodel("tag_origin");
  self clientfield::set("electroball_play_landed_fx", 1);
  if(!isdefined(level.a_electroball_grenades)) {
    level.a_electroball_grenades = [];
  }
  array::add(level.a_electroball_grenades, self);
}

function function_f338543f(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isdefined(weapon) && weapon.rootweapon.name === "electroball_grenade") {
    if(isdefined(attacker) && self.team === attacker.team) {
      return 0;
    }
    if(self.var_3531cf2b === 1) {
      return 0;
    }
  }
  return -1;
}