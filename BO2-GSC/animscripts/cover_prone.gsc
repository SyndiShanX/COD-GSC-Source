/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_prone.gsc
***************************************/

#include maps\_utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\shared;
#include animscripts\anims;
#include common_scripts\utility;
#include animscripts\combat;
#include animscripts\cover_wall;
#include animscripts\shoot_behavior;
#include maps\_dds;
#include animscripts\weaponlist;
#include animscripts\move;
#using_animtree("generic_human");

main() {
  self trackscriptstate("Cover Prone Main", "code");
  self endon("killanimscript");
  animscripts\utility::initialize("cover_prone");

  if(self.weaponclass == "rocketlauncher") {
    animscripts\combat::main();
    return;
  }

  if(isDefined(self.a.arrivaltype) && self.a.arrivaltype == "prone_saw") {
    assert(isDefined(self.node.turretinfo));
    self animscripts\cover_wall::useselfplacedturret("saw_bipod_prone", "weapon_saw_MG_Setup");
  } else if(isDefined(self.node.turret))
    self animscripts\cover_wall::usestationaryturret();

  if(isDefined(self.enemy) && lengthsquared(self.origin - self.enemy.origin) < 262144) {
    self thread animscripts\combat::main();
    return;
  }

  self setup_cover_prone();
  self.covernode = self.node;
  assert(isDefined(self.covernode));
  self orientmode("face angle", self.covernode.angles[1]);
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_modern, % prone_legs_up);

  if(self.a.pose != "prone")
    self transitionto("prone");
  else
    self enterpronewrapper(0);

  self setanimknoball(animarray("straight_level"), % body, 1, 0.1, 1);
  self orientmode("face angle", self.covernode.angles[1]);
  self animmode("zonly_physics");
  self pronecombatmainloop();
  self notify("stop_deciding_how_to_shoot");
}

idlethread() {
  self endon("killanimscript");
  self endon("kill_idle_thread");

  for(;;) {
    idleanim = animarraypickrandom("prone_idle");
    self setflaggedanimlimited("idle", idleanim);
    self waittillmatch("idle", "end");
    self clearanim(idleanim, 0.2);
  }
}

updatepronewrapper(time) {
  self updateprone( % prone_aim_feet_45up, % prone_aim_feet_45down, 1, time, 1);
}

pronecombatmainloop() {
  self endon("killanimscript");
  self endon("melee");
  self thread trackshootentorpos();
  self setanim( % add_idle);
  self thread idlethread();
  self thread animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
  desynched = gettime() > 2500;

  for(;;) {
    self animscripts\utility::isincombat();
    self updatepronewrapper(0.05);

    if(!desynched) {
      wait(0.05 + randomfloat(1.5));
      desynched = 1;
      continue;
    }

    if(!isDefined(self.shootpos)) {
      assert(!isDefined(self.shootent));

      if(considerthrowgrenade()) {
        continue;
      }
      wait 0.05;
      continue;
    }

    assert(isDefined(self.shootpos));
    distsqtoshootpos = lengthsquared(self.origin - self.shootpos);

    if(self.a.pose != "crouch" && self isstanceallowed("crouch") && distsqtoshootpos < 160000) {
      if(distsqtoshootpos < 81225) {
        transitionto("crouch");
        self thread animscripts\combat::main();
        return;
      }
    }

    if(considerthrowgrenade()) {
      continue;
    }
    if(self pronereload()) {
      continue;
    }
    if(aimedatshootentorpos() && gettime() >= 0) {
      shootuntilshootbehaviorchange();
      self flamethrower_stop_shoot();
      self clearanim( % add_fire, 0.2);
      continue;
    }

    wait 0.05;
  }
}

pronereload() {
  if(needtoreload(0)) {
    if(weaponisgasweapon(self.weapon))
      return flamethrower_reload();

    self maps\_dds::dds_notify_reload(undefined, self.team == "allies");
    reloadanim = self animarraypickrandom("reload");
    self setflaggedanimknoball("reloadanim", reloadanim, % body, 1, 0.1, 1);
    self setanim( % exposed_aiming, 1, 0);
    animscripts\shared::donotetracks("reloadanim");
    self clearanim(reloadanim, 0.2);
    self animscripts\weaponlist::refillclip();
    return 1;
  }

  return 0;
}

setup_cover_prone() {
  self.rightaimlimit = 45;
  self.leftaimlimit = -45;
  self.upaimlimit = 45;
  self.downaimlimit = -45;
}

trythrowinggrenade(throwat, safe) {
  theanim = undefined;

  if(isDefined(safe) && safe)
    theanim = animarraypickrandom("grenade_safe");
  else
    theanim = animarraypickrandom("grenade_exposed");

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  armoffset = (32, 20, 64);
  threwgrenade = trygrenade(throwat, theanim);
  self.keepclaimednodeifvalid = 0;
  return threwgrenade;
}

considerthrowgrenade() {
  if(isDefined(self.enemy))
    return trythrowinggrenade(self.enemy, 850);

  return 0;
}

shouldfirewhilechangingpose() {
  if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 256)
    return 0;

  if(isDefined(self.enemy) && self cansee(self.enemy) && !isDefined(self.grenade) && self getaimyawtoshootentorpos() < 20)
    return animscripts\move::mayshootwhilemoving();

  return 0;
}

transitionto(newpose) {
  if(newpose == self.a.pose) {
    return;
  }
  self clearanim( % root, 0.3);
  self notify("kill_idle_thread");

  if(shouldfirewhilechangingpose())
    transanim = animarray(self.a.pose + "_2_" + newpose + "_firing", "cover_prone");
  else
    transanim = animarray(self.a.pose + "_2_" + newpose, "cover_prone");

  if(newpose == "prone")
    assert(animhasnotetrack(transanim, "anim_pose = \"prone\""));

  self setflaggedanimknoballrestart("trans", transanim, % body, 1, 0.2, 1.0);
  animscripts\shared::donotetracks("trans");
  assert(self.a.pose == newpose);
  self setanimknoballrestart(animarray("straight_level"), % body, 1, 0.25);
  setupaim(0.25);
}

finishnotetracks(animname) {
  self endon("killanimscript");
  animscripts\shared::donotetracks(animname);
}

setupaim(transtime) {
  self setanimknoball(animarray("straight_level"), % body, 1, transtime);
  self setanimlimited(animarray("add_aim_up"), 1, transtime);
  self setanimlimited(animarray("add_aim_down"), 1, transtime);
  self setanimlimited(animarray("add_aim_left"), 1, transtime);
  self setanimlimited(animarray("add_aim_right"), 1, transtime);
}

proneto(newpose, rate) {
  assert(self.a.pose == "prone");
  self clearanim( % root, 0.3);
  transanim = undefined;

  if(shouldfirewhilechangingpose()) {
    if(newpose == "crouch")
      transanim = animarray("prone_2_crouch_firing", "cover_prone");
    else if(newpose == "stand")
      transanim = animarray("prone_2_stand_firing", "cover_prone");
  } else if(newpose == "crouch")
    transanim = animarray("prone_2_crouch", "cover_prone");
  else if(newpose == "stand")
    transanim = animarray("prone_2_stand", "cover_prone");

  assert(isDefined(transanim));

  if(!isDefined(rate))
    rate = 1;

  self exitpronewrapper(getanimlength(transanim) / 2);
  self setflaggedanimknoballrestart("trans", transanim, % body, 1, 0.2, rate);
  animscripts\shared::donotetracks("trans");
  self clearanim(transanim, 0.1);
  assert(self.a.pose == newpose);
}