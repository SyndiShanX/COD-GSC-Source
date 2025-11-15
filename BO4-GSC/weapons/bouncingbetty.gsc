/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\bouncingbetty.gsc
***********************************************/

#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\util_shared;
#include scripts\weapons\weaponobjects;

#namespace bouncingbetty;

init_shared() {
  level.bettydestroyedfx = #"weapon/fx_betty_exp_destroyed";
  level._effect[#"fx_betty_friendly_light"] = #"hash_5f76ecd582d98e38";
  level._effect[#"fx_betty_enemy_light"] = #"hash_330682ff4f12f646";
  level.bettymindist = 20;
  level.bettystuntime = 1;
  bettyexplodeanim = "o_spider_mine_detonate";
  bettydeployanim = "o_spider_mine_deploy";
  level.bettyradius = getdvarint(#"betty_detect_radius", 180);
  level.bettyactivationdelay = getdvarfloat(#"betty_activation_delay", 1);
  level.bettygraceperiod = getdvarfloat(#"betty_grace_period", 0);
  level.bettydamageradius = getdvarint(#"betty_damage_radius", 180);
  level.bettydamagemax = getdvarint(#"betty_damage_max", 180);
  level.bettydamagemin = getdvarint(#"betty_damage_min", 70);
  level.bettydamageheight = getdvarint(#"betty_damage_cylinder_height", 200);
  level.bettyjumpheight = getdvarint(#"betty_jump_height_onground", 55);
  level.bettyjumpheightwall = getdvarint(#"betty_jump_height_wall", 20);
  level.bettyjumpheightwallangle = getdvarint(#"betty_onground_angle_threshold", 30);
  level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
  level.bettyjumptime = getdvarfloat(#"betty_jump_time", 0.7);
  level.bettybombletspawndistance = 20;
  level.bettybombletcount = 4;
  level thread register();

  level thread bouncingbettydvarupdate();

    weaponobjects::function_e6400478(#"bouncingbetty", &createbouncingbettywatcher, 0);
}

register() {
  clientfield::register("missile", "bouncingbetty_state", 1, 2, "int");
  clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int");
}

bouncingbettydvarupdate() {
  for(;;) {
    level.bettyradius = getdvarint(#"betty_detect_radius", level.bettyradius);
    level.bettyactivationdelay = getdvarfloat(#"betty_activation_delay", level.bettyactivationdelay);
    level.bettygraceperiod = getdvarfloat(#"betty_grace_period", level.bettygraceperiod);
    level.bettydamageradius = getdvarint(#"betty_damage_radius", level.bettydamageradius);
    level.bettydamagemax = getdvarint(#"betty_damage_max", level.bettydamagemax);
    level.bettydamagemin = getdvarint(#"betty_damage_min", level.bettydamagemin);
    level.bettydamageheight = getdvarint(#"betty_damage_cylinder_height", level.bettydamageheight);
    level.bettyjumpheight = getdvarint(#"betty_jump_height_onground", level.bettyjumpheight);
    level.bettyjumpheightwall = getdvarint(#"betty_jump_height_wall", level.bettyjumpheightwall);
    level.bettyjumpheightwallangle = getdvarint(#"betty_onground_angle_threshold", level.bettyjumpheightwallangle);
    level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
    level.bettyjumptime = getdvarfloat(#"betty_jump_time", level.bettyjumptime);
    wait 3;
  }
}

  function createbouncingbettywatcher(watcher) {
    watcher.onspawn = &onspawnbouncingbetty;
    watcher.watchforfire = 1;
    watcher.ondetonatecallback = &bouncingbettydetonate;
    watcher.activatesound = #"wpn_betty_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.detectionmindist = level.bettymindist;
    watcher.detectiongraceperiod = level.bettygraceperiod;
    watcher.detonateradius = level.bettyradius;
    watcher.onfizzleout = &onbouncingbettyfizzleout;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.stuntime = level.bettystuntime;
    watcher.activationdelay = level.bettyactivationdelay;
  }

onbouncingbettyfizzleout() {
  if(isDefined(self.minemover)) {
    if(isDefined(self.minemover.killcament)) {
      self.minemover.killcament delete();
    }

    self.minemover delete();
  }

  self delete();
}

onspawnbouncingbetty(watcher, owner) {
  weaponobjects::onspawnproximityweaponobject(watcher, owner);
  self.originalowner = owner;
  self thread spawnminemover();
  self trackonowner(owner);
  self thread trackusedstatondeath();
  self thread donotrackusedstatonpickup();
  self thread trackusedonhack();
}

trackusedstatondeath() {
  self endon(#"do_not_track_used");
  self waittill(#"death");
  waittillframeend();
  self.owner trackbouncingbettyasused();
  self notify(#"end_donotrackusedonpickup");
  self notify(#"end_donotrackusedonhacked");
}

donotrackusedstatonpickup() {
  self endon(#"end_donotrackusedonpickup");
  self waittill(#"picked_up");
  self notify(#"do_not_track_used");
}

trackusedonhack() {
  self endon(#"end_donotrackusedonhacked");
  self waittill(#"hacked");
  self.originalowner trackbouncingbettyasused();
  self notify(#"do_not_track_used");
}

trackbouncingbettyasused() {
  if(isplayer(self)) {
    self stats::function_e24eec31(getweapon(#"bouncingbetty"), #"used", 1);
  }
}

trackonowner(owner) {
  if(level.trackbouncingbettiesonowner === 1) {
    if(!isDefined(owner)) {
      return;
    }

    if(!isDefined(owner.activebouncingbetties)) {
      owner.activebouncingbetties = [];
    } else {
      arrayremovevalue(owner.activebouncingbetties, undefined);
    }

    owner.activebouncingbetties[owner.activebouncingbetties.size] = self;
  }
}

spawnminemover() {
  self endon(#"death");
  self util::waittillnotmoving();
  self clientfield::set("bouncingbetty_state", 2);
  self useanimtree("generic");
  self setanim(#"o_spider_mine_deploy", 1, 0, 1);
  minemover = spawn("script_model", self.origin);
  minemover.angles = self.angles;
  minemover setModel(#"tag_origin");
  minemover.owner = self.owner;
  mineup = anglestoup(minemover.angles);
  z_offset = getdvarfloat(#"scr_bouncing_betty_killcam_offset", 18);
  minemover enablelinkto();
  minemover linkto(self);
  minemover.killcamoffset = vectorscale(mineup, z_offset);
  minemover.weapon = self.weapon;
  minemover playSound(#"wpn_betty_arm");
  killcament = spawn("script_model", minemover.origin + minemover.killcamoffset);
  killcament.angles = (0, 0, 0);
  killcament setModel(#"tag_origin");
  killcament setweapon(self.weapon);
  minemover.killcament = killcament;
  self.minemover = minemover;
  self thread killminemoveronpickup();
}

killminemoveronpickup() {
  self.minemover endon(#"death");
  self waittill(#"picked_up", #"hacked");
  self killminemover();
}

killminemover() {
  if(isDefined(self.minemover)) {
    if(isDefined(self.minemover.killcament)) {
      self.minemover.killcament delete();
    }

    self.minemover delete();
  }
}

bouncingbettydetonate(attacker, weapon, target) {
  if(isDefined(weapon) && weapon.isvalid) {
    self.destroyedby = attacker;

    if(isDefined(attacker)) {
      if(self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedexplosive(weapon);
        scoreevents::processscoreevent(#"destroyed_bouncingbetty", attacker, self.owner, weapon);
      }
    }

    self bouncingbettydestroyed();
    return;
  }

  if(isDefined(self.minemover)) {
    self.minemover.ignore_team_kills = 1;
    self.minemover setModel(self.model);
    self.minemover thread bouncingbettyjumpandexplode();
    self delete();
    return;
  }

  self bouncingbettydestroyed();
}

bouncingbettydestroyed() {
  playFX(level.bettydestroyedfx, self.origin);
  playsoundatposition(#"dst_equipment_destroy", self.origin);

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self killminemover();
  self radiusdamage(self.origin, 128, 110, 10, self.owner, "MOD_EXPLOSIVE", self.weapon);
  self delete();
}

bouncingbettyjumpandexplode() {
  jumpdir = vectornormalize(anglestoup(self.angles));

  if(jumpdir[2] > level.bettyjumpheightwallanglecos) {
    jumpheight = level.bettyjumpheight;
  } else {
    jumpheight = level.bettyjumpheightwall;
  }

  explodepos = self.origin + jumpdir * jumpheight;
  self.killcament moveto(explodepos + self.killcamoffset, level.bettyjumptime, 0, level.bettyjumptime);
  self clientfield::set("bouncingbetty_state", 1);
  wait level.bettyjumptime;
  self thread mineexplode(jumpdir, explodepos);
}

mineexplode(explosiondir, explodepos) {
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self playSound(#"wpn_betty_explo");
  self clientfield::increment("sndRattle", 1);
  waitframe(1);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self cylinderdamage(explosiondir * level.bettydamageheight, explodepos, level.bettydamageradius, level.bettydamageradius, level.bettydamagemax, level.bettydamagemin, self.owner, "MOD_EXPLOSIVE", self.weapon);
  self ghost();
  wait 0.1;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self.killcament delete();
  self delete();
}