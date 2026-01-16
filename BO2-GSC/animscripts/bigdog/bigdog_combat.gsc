/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\bigdog\bigdog_combat.gsc
************************************************/

#include animscripts\anims;
#include animscripts\utility;
#include animscripts\bigdog\bigdog_utility;
#include common_scripts\utility;
#include maps\_turret;
#include maps\_utility;
#include animscripts\debug;
#include animscripts\shared;

main() {
  self endon("killanimscript");
  animscripts\bigdog\bigdog_utility::initialize("combat");
  combatidle();
}

combatidle() {
  self animscripts\debug::debugpushstate("combatIdle");

  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics");
  hunkerdown();
  lastsawenemytime = gettime();

  while(true) {
    if(combatturn()) {
      continue;
    }
    canseeenemy = isDefined(self.enemy) && self cansee(self.enemy);

    if(canseeenemy)
      lastsawenemytime = gettime();

    if(self.canmove && isDefined(self.enemy) && !self.fixednode && !bigdog_isemped()) {
      canshootenemy = self.turret can_turret_hit_target(self.enemy);

      if(!canseeenemy || !canshootenemy) {
        if(gettime() - lastsawenemytime > 2000) {
          betternode = self findbestcovernode();

          if(isDefined(betternode) && (!isDefined(self.node) || betternode != self.node))
            self usecovernode(betternode);
          else if(tryreacquire())
            return;
        }
      } else if(trymovetonextbestnode())
        return;
    }

    animname = getidleanimname();
    self setflaggedanimrestart("combat_idle", animarray(animname, "stop"), 1, 0.2, 1);
    self animscripts\shared::donotetracks("combat_idle");
  }

  self animscripts\debug::debugpopstate();
}

#using_animtree("bigdog");

hunkerdown() {
  if(!self.hunkereddown) {
    self animscripts\debug::debugpushstate("hunkerDown");

    self orientmode("face angle", self.angles[1]);
    self animmode("zonly_physics", 0);
    playfx(anim._effect["bigdog_dust_cloud"], self.origin);
    animname = "hunker_down" + animsuffix();
    hunkeranim = animarray(animname, "stop");
    self setflaggedanimknoballrestart("hunker", hunkeranim, % root, 1, 0.2, 1);
    self animscripts\shared::donotetracks("hunker");
    self clearanim(hunkeranim, 0.2);
    self.hunkereddown = 1;

    self animscripts\debug::debugpopstate();

  }
}

hunkerup() {
  if(self.hunkereddown) {
    self animscripts\debug::debugpushstate("hunkerUp");

    self orientmode("face angle", self.angles[1]);
    self animmode("zonly_physics", 0);
    animname = "hunker_up" + animsuffix();
    hunkeranim = animarray(animname, "stop");
    self setflaggedanimknoballrestart("hunker", hunkeranim, % root, 1, 0.2, 1);
    self animscripts\shared::donotetracks("hunker");
    self clearanim(hunkeranim, 0.2);
    self.hunkereddown = 0;

    self animscripts\debug::debugpopstate();

  }
}

combatturn() {
  return false;

  if(!isDefined(self.enemy))
    return false;

  if(!self.canmove)
    return false;

  if(gettime() < self.a.scriptstarttime + 5000)
    return false;

  if(!self cansee(self.enemy))
    return false;

  toenemy = self.enemy.origin - self.origin;
  desiredangle = vectortoangles(toenemy)[1];
  anglediff = angleclamp180(desiredangle - self.angles[1]);

  if(abs(anglediff) > 10) {
    self.safetochangescript = 0;
    turn(anglediff);
    self.safetochangescript = 1;
    return true;
  }

  return false;
}

turn(anglediff) {
  turnrate = 10;
  absanglediff = abs(anglediff);
  sign = sign(anglediff);

  if(absanglediff < self.turnanglethreshold)
    return false;

  self animscripts\debug::debugpushstate("turn", anglediff);

  if(!self.hunkereddown)
    hunkerdown();

  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics", 0);
  animname = "hunker_up_turn";
  hunkeranim = animarray(animname, "stop");
  self setflaggedanimknoballrestart("hunker", hunkeranim, % root, 1, 0.2, 1);
  self animscripts\shared::donotetracks("hunker");

  while(absanglediff > 0) {
    delta = min(turnrate, absanglediff);
    absanglediff = absanglediff - delta;
    newyaw = self.angles[1] + delta * sign;
    newangles = (self.angles[0], newyaw, self.angles[2]);
    self forceteleport(self.origin, newangles);
    wait 0.05;
  }

  self.hunkereddown = 0;
  self clearanim( % root, 0.2);

  self animscripts\debug::debugpopstate();

  return true;
}

trymovetonextbestnode() {
  if(gettime() >= self.nextmovetonextbestcovernodetime) {
    if(movetonextbestnode()) {
      self.nextmovetonextbestcovernodetime = gettime() + randomintrange(7000, 12000);
      return true;
    }
  }

  return false;
}

movetonextbestnode() {
  if(self.fixednode)
    return false;

  betternodes = self findbestcovernodes(self.goalradius, self.goalpos);
  bestnode = undefined;
  bestdistsq = 9999999;

  foreach(node in betternodes) {
    if(!isDefined(self.node) || node != self.node) {
      distsq = distancesquared(self.origin, node.origin);

      if(distsq < bestdistsq && distsq > 16384) {
        bestdistsq = distsq;
        bestnode = node;
      }
    }
  }

  if(isDefined(bestnode)) {
    recordline(self.origin, bestnode.origin, (0, 1, 0), "Script", self);

    self usecovernode(bestnode);
    return true;
  }

  return false;
}

getidleanimname() {
  animsuffix = animsuffix();
  animname = "idle" + animsuffix;

  if(self.hunkereddown)
    animname = "hunker_idle" + animsuffix;

  return animname;
}

tryreacquire() {
  if(self reacquirestep(64))
    return true;
  else if(self reacquirestep(128))
    return true;
  else if(self reacquirestep(192))
    return true;
  else if(self reacquirestep(256))
    return true;

  return false;
}