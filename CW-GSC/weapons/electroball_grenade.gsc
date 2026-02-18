/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\electroball_grenade.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;
#namespace electroball_grenade;

function private autoexec __init__system__() {
  system::register("electroball_grenade", &preinit, undefined, undefined, undefined);
}

function preinit() {
  level.proximitygrenadedetectionradius = getdvarint(#"scr_proximitygrenadedetectionradius", 180);
  level.proximitygrenadegraceperiod = getdvarfloat(#"scr_proximitygrenadegraceperiod", 0.05);
  level.proximitygrenadedotdamageamount = getdvarint(#"scr_proximitygrenadedotdamageamount", 1);
  level.proximitygrenadedotdamageamounthardcore = getdvarint(#"scr_proximitygrenadedotdamageamounthardcore", 1);
  level.proximitygrenadedotdamagetime = getdvarfloat(#"scr_proximitygrenadedotdamagetime", 0.2);
  level.proximitygrenadedotdamageinstances = getdvarint(#"scr_proximitygrenadedotdamageinstances", 4);
  level.proximitygrenadeactivationtime = getdvarfloat(#"scr_proximitygrenadeactivationtime", 0.1);
  level.proximitygrenadeprotectedtime = getdvarfloat(#"scr_proximitygrenadeprotectedtime", 0.45);
  level thread register();
  callback::on_spawned(&on_player_spawned);
  callback::on_ai_spawned(&on_ai_spawned);
  callback::on_grenade_fired(&begin_other_grenade_tracking);
}

function register() {
  clientfield::register("toplayer", "electroball_tazered", 1, 1, "int");
  clientfield::register("missile", "electroball_stop_trail", 1, 1, "int");
  clientfield::register("missile", "electroball_play_landed_fx", 1, 1, "int");
  clientfield::register("allplayers", "electroball_shock", 1, 1, "int");
}

function function_5d95c1d() {
  watcher = self weaponobjects::createwatcher("electroball_grenade", undefined, 0);
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
  watcher.onstun = &weaponobjects::weaponstun;
  watcher.stuntime = 1;
  watcher.ondetonatecallback = &proximitydetonate;
  watcher.activationdelay = 0.05;
  watcher.activatesound = "wpn_claymore_alert";
  watcher.immunespecialty = "specialty_immunetriggershock";
  watcher.onspawn = &function_5aeaf7bc;
}

function function_5aeaf7bc(watcher, owner) {
  self thread setupkillcament();

  if(isPlayer(owner)) {
    owner addweaponstat(self.weapon, "used", 1);
  }

  if(isDefined(self.weapon) && self.weapon.proximitydetonation > 0) {
    watcher.detonateradius = self.weapon.proximitydetonation;
  }

  weaponobjects::onspawnproximityweaponobject(watcher, owner);
  self thread function_8e671a22();
}

function setupkillcament() {
  self endon(#"death");
  self util::waittillnotmoving();
  self.killcament = spawn("script_model", self.origin + (0, 0, 8));
  self thread cleanupkillcamentondeath();
}

function cleanupkillcamentondeath() {
  self waittill(#"death");
  self.killcament util::deleteaftertime(4 + level.proximitygrenadedotdamagetime * level.proximitygrenadedotdamageinstances);
}

function proximitydetonate(attacker, weapon, target) {
  weaponobjects::weapondetonate(weapon, target);
}

function watchproximitygrenadehitplayer(owner) {
  self endon(#"death");
  self setteam(owner.team);

  while(true) {
    waitresult = self waittill(#"grenade_bounce");

    if(isDefined(waitresult.ent) && isPlayer(waitresult.ent) && waitresult.surface != "riotshield") {
      if(level.teambased && waitresult.ent.team == self.owner.team) {
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
  explosionvec = vectornormalize(distancetogrenade - self.origin);
  fdot = vectordot(explosionvec, forwardvec);
  rdot = vectordot(explosionvec, rightvec);
  fangle = acos(fdot);
  rangle = acos(rdot);
}

function function_4e48c752(params) {
  self endon(#"death");

  if(isDefined(params.weapon) && params.weapon.name == "electroball_grenade") {
    self damageplayerinradius(params.eattacker);
  }
}

function damageplayerinradius(attacker) {
  self notify(#"proximitygrenadedamagestart");
  self endon(#"proximitygrenadedamagestart", #"death");
  attacker endon(#"disconnect");
  self clientfield::set("electroball_shock", 1);
  g_time = gettime();

  if(self util::mayapplyscreeneffect()) {
    self.lastshockedby = attacker;
    self.shockendtime = gettime() + 100;
    self shellshock("electrocution", 0.1);
    self clientfield::set_to_player("electroball_tazered", 1);
  }

  self playrumbleonentity("proximity_grenade");
  self playSound("wpn_taser_mine_zap");

  if(!self hasperk("specialty_proximityprotection")) {
    self thread watch_death();

    if(gettime() - g_time < 100) {
      wait(gettime() - g_time) / 1000;
    }
  } else {
    wait level.proximitygrenadeprotectedtime;
  }

  self clientfield::set_to_player("electroball_tazered", 0);
}

function watch_death() {
  self endon(#"disconnect");
  self notify(#"proximity_cleanup");
  self endon(#"proximity_cleanup");
  self waittill(#"death");
  self stoprumble("proximity_grenade");
  self setblur(0, 0);
  self clientfield::set_to_player("electroball_tazered", 0);
}

function on_player_spawned() {
  if(isPlayer(self)) {
    self thread function_5d95c1d();
    self callback::on_player_damage(&function_4e48c752);
  }
}

function on_ai_spawned() {
  if(self.archetype === "mechz") {
    self thread function_5d95c1d();
  }
}

function begin_other_grenade_tracking(params) {
  if(isDefined(params.weapon) && isDefined(params.weapon.rootweapon) && params.weapon.rootweapon.name == # "electroball_grenade") {
    params.projectile thread watchproximitygrenadehitplayer(self);
  }
}

function function_8e671a22() {
  self endon(#"death", #"disconnect", #"delete");
  self waittill(#"grenade_bounce", #"stationary");
  self clientfield::set("electroball_stop_trail", 1);
  self setModel("tag_origin");
  self clientfield::set("electroball_play_landed_fx", 1);

  if(!isDefined(level.var_542ac835)) {
    level.var_542ac835 = [];
  }

  array::add(level.var_542ac835, self);
}