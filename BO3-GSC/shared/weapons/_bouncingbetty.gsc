/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_bouncingbetty.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using_animtree("bouncing_betty");
#namespace bouncingbetty;

function init_shared() {
  level.bettydestroyedfx = "weapon/fx_betty_exp_destroyed";
  level._effect["fx_betty_friendly_light"] = "weapon/fx_betty_light_blue";
  level._effect["fx_betty_enemy_light"] = "weapon/fx_betty_light_orng";
  level.bettymindist = 20;
  level.bettystuntime = 1;
  bettyexplodeanim = % bouncing_betty::o_spider_mine_detonate;
  bettydeployanim = % bouncing_betty::o_spider_mine_deploy;
  level.bettyradius = getdvarint("betty_detect_radius", 180);
  level.bettyactivationdelay = getdvarfloat("betty_activation_delay", 1);
  level.bettygraceperiod = getdvarfloat("betty_grace_period", 0);
  level.bettydamageradius = getdvarint("betty_damage_radius", 180);
  level.bettydamagemax = getdvarint("betty_damage_max", 180);
  level.bettydamagemin = getdvarint("betty_damage_min", 70);
  level.bettydamageheight = getdvarint("betty_damage_cylinder_height", 200);
  level.bettyjumpheight = getdvarint("betty_jump_height_onground", 55);
  level.bettyjumpheightwall = getdvarint("betty_jump_height_wall", 20);
  level.bettyjumpheightwallangle = getdvarint("betty_onground_angle_threshold", 30);
  level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
  level.bettyjumptime = getdvarfloat("betty_jump_time", 0.7);
  level.bettybombletspawndistance = 20;
  level.bettybombletcount = 4;
  level thread register();
  level thread bouncingbettydvarupdate();
  callback::add_weapon_watcher(&createbouncingbettywatcher);
}

function register() {
  clientfield::register("missile", "bouncingbetty_state", 1, 2, "int");
  clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int");
}

function bouncingbettydvarupdate() {
  for(;;) {
    level.bettyradius = getdvarint("", level.bettyradius);
    level.bettyactivationdelay = getdvarfloat("", level.bettyactivationdelay);
    level.bettygraceperiod = getdvarfloat("", level.bettygraceperiod);
    level.bettydamageradius = getdvarint("", level.bettydamageradius);
    level.bettydamagemax = getdvarint("", level.bettydamagemax);
    level.bettydamagemin = getdvarint("", level.bettydamagemin);
    level.bettydamageheight = getdvarint("", level.bettydamageheight);
    level.bettyjumpheight = getdvarint("", level.bettyjumpheight);
    level.bettyjumpheightwall = getdvarint("", level.bettyjumpheightwall);
    level.bettyjumpheightwallangle = getdvarint("", level.bettyjumpheightwallangle);
    level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
    level.bettyjumptime = getdvarfloat("", level.bettyjumptime);
    wait(3);
  }
}

function createbouncingbettywatcher() {
  watcher = self weaponobjects::createproximityweaponobjectwatcher("bouncingbetty", self.team);
  watcher.onspawn = &onspawnbouncingbetty;
  watcher.watchforfire = 1;
  watcher.ondetonatecallback = &bouncingbettydetonate;
  watcher.activatesound = "wpn_betty_alert";
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

function onbouncingbettyfizzleout() {
  if(isDefined(self.minemover)) {
    if(isDefined(self.minemover.killcament)) {
      self.minemover.killcament delete();
    }
    self.minemover delete();
  }
  self delete();
}

function onspawnbouncingbetty(watcher, owner) {
  weaponobjects::onspawnproximityweaponobject(watcher, owner);
  self.originalowner = owner;
  self thread spawnminemover();
  self trackonowner(owner);
  self thread trackusedstatondeath();
  self thread donotrackusedstatonpickup();
  self thread trackusedonhack();
}

function trackusedstatondeath() {
  self endon("do_not_track_used");
  self waittill("death");
  waittillframeend();
  if(isDefined(self.owner)) {
    self.owner trackbouncingbettyasused();
  }
  self notify("end_donotrackusedonpickup");
  self notify("end_donotrackusedonhacked");
}

function donotrackusedstatonpickup() {
  self endon("end_donotrackusedonpickup");
  self waittill("picked_up");
  self notify("do_not_track_used");
}

function trackusedonhack() {
  self endon("end_donotrackusedonhacked");
  self waittill("hacked");
  self.originalowner trackbouncingbettyasused();
  self notify("do_not_track_used");
}

function trackbouncingbettyasused() {
  if(isplayer(self)) {
    self addweaponstat(getweapon("bouncingbetty"), "used", 1);
  }
}

function trackonowner(owner) {
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

function spawnminemover() {
  self endon("death");
  self util::waittillnotmoving();
  self clientfield::set("bouncingbetty_state", 2);
  self useanimtree($bouncing_betty);
  self setanim(%bouncing_betty::o_spider_mine_deploy, 1, 0, 1);
  minemover = spawn("script_model", self.origin);
  minemover.angles = self.angles;
  minemover setModel("tag_origin");
  minemover.owner = self.owner;
  mineup = anglestoup(minemover.angles);
  z_offset = getdvarfloat("scr_bouncing_betty_killcam_offset", 18);
  minemover enablelinkto();
  minemover linkto(self);
  minemover.killcamoffset = vectorscale(mineup, z_offset);
  minemover.weapon = self.weapon;
  minemover playSound("wpn_betty_arm");
  killcament = spawn("script_model", minemover.origin + minemover.killcamoffset);
  killcament.angles = (0, 0, 0);
  killcament setModel("tag_origin");
  killcament setweapon(self.weapon);
  minemover.killcament = killcament;
  self.minemover = minemover;
  self thread killminemoveronpickup();
}

function killminemoveronpickup() {
  self.minemover endon("death");
  self util::waittill_any("picked_up", "hacked");
  self killminemover();
}

function killminemover() {
  if(isDefined(self.minemover)) {
    if(isDefined(self.minemover.killcament)) {
      self.minemover.killcament delete();
    }
    self.minemover delete();
  }
}

function bouncingbettydetonate(attacker, weapon, target) {
  if(isDefined(weapon) && weapon.isvalid) {
    self.destroyedby = attacker;
    if(isDefined(attacker)) {
      if(self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedexplosive(weapon);
        scoreevents::processscoreevent("destroyed_bouncingbetty", attacker, self.owner, weapon);
      }
    }
    self bouncingbettydestroyed();
  } else {
    if(isDefined(self.minemover)) {
      self.minemover.ignore_team_kills = 1;
      self.minemover setModel(self.model);
      self.minemover thread bouncingbettyjumpandexplode();
      self delete();
    } else {
      self bouncingbettydestroyed();
    }
  }
}

function bouncingbettydestroyed() {
  playFX(level.bettydestroyedfx, self.origin);
  playsoundatposition("dst_equipment_destroy", self.origin);
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }
  self killminemover();
  self radiusdamage(self.origin, 128, 110, 10, self.owner, "MOD_EXPLOSIVE", self.weapon);
  self delete();
}

function bouncingbettyjumpandexplode() {
  jumpdir = vectornormalize(anglestoup(self.angles));
  if(jumpdir[2] > level.bettyjumpheightwallanglecos) {
    jumpheight = level.bettyjumpheight;
  } else {
    jumpheight = level.bettyjumpheightwall;
  }
  explodepos = self.origin + (jumpdir * jumpheight);
  self.killcament moveto(explodepos + self.killcamoffset, level.bettyjumptime, 0, level.bettyjumptime);
  self clientfield::set("bouncingbetty_state", 1);
  wait(level.bettyjumptime);
  self thread mineexplode(jumpdir, explodepos);
}

function mineexplode(explosiondir, explodepos) {
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self playSound("wpn_betty_explo");
  self clientfield::set("sndRattle", 1);
  wait(0.05);
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self cylinderdamage(explosiondir * level.bettydamageheight, explodepos, level.bettydamageradius, level.bettydamageradius, level.bettydamagemax, level.bettydamagemin, self.owner, "MOD_EXPLOSIVE", self.weapon);
  self ghost();
  wait(0.1);
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }
  self.killcament delete();
  self delete();
}