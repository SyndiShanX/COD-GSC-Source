/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\bigdog\bigdog_move.gsc
**********************************************/

#include animscripts\anims;
#include animscripts\utility;
#include animscripts\bigdog\bigdog_utility;
#include maps\_utility;
#include common_scripts\utility;
#include animscripts\bigdog\bigdog_combat;
#include animscripts\debug;
#include animscripts\shared;
#include animscripts\run;

main() {
  self endon("killanimscript");

  if(!self.canmove) {
    animscripts\bigdog\bigdog_combat::main();
    return;
  }

  animscripts\bigdog\bigdog_utility::initialize("move");
  self.iswounded = 0;
  moveinit();
  movemainloop();
}

moveinit() {
  self animscripts\debug::debugpushstate("MoveInit");

  tryturning();
  animscripts\bigdog\bigdog_combat::hunkerup();

  self animscripts\debug::debugpopstate();
}

#using_animtree("bigdog");

movemainloop() {
  self animscripts\debug::debugpushstate("MoveMainLoop");

  prevlooptime = self getanimtime( % walk_loops);
  self.a.runloopcount = randomint(10000);

  for(;;) {
    if(!self.canmove || bigdog_isemped()) {
      animscripts\bigdog\bigdog_combat::main();
      return;
    }

    looptime = self getanimtime( % walk_loops);

    if(looptime < prevlooptime)
      self.a.runloopcount++;

    prevlooptime = looptime;
    animname = "walk";
    animsuffix = animsuffix();
    self orientmode("face default");
    self animmode("none", 0);

    if(shouldtacticalwalk()) {
      walkanimname = animname + "_" + anim.moveglobals.relativediranimmap[self.relativedir] + animsuffix;
      walkanim = animarraypickrandom(walkanimname, "move", 1);
      self setflaggedanimknob("runanim", walkanim, 1, 0.5, self.moveplaybackrate);
    } else {
      if(self.lookaheaddist > 32 && tryturning()) {
        continue;
      }
      self orientmode("face default");
      animname = getmoveanimname();
      self setflaggedanimknob("runanim", animarray(animname + "_f" + animsuffix), 1, 0.5, self.moveplaybackrate);
    }

    animscripts\shared::donotetracksfortime(0.05, "runanim");
  }

  self animscripts\debug::debugpopstate();
}

bigdoghandledisconnectpathswhilemoving() {
  if(gettime() > self.a.disconnectpathstime)
    self.a.disconnectpathstime = gettime() + 2000;
}

shouldtacticalwalk() {
  return false;
}

shouldfacemotionwhilerunning() {
  if(self shouldfacemotion())
    return true;

  return false;
}

shouldwalkbackwards() {
  anglediff = self animscripts\run::getlookaheadangle();

  if(abs(anglediff) > 135)
    return true;

  return false;
}

getmoveanimname() {
  return "walk";
}

tryturning() {
  if(!self.canmove)
    return 0;

  anglediff = self animscripts\run::getlookaheadangle();

  if(abs(anglediff) > self.turnanglethreshold) {
    self orientmode("face angle", self.angles[1]);
    self animmode("zonly_physics", 0);
    animname = animscripts\bigdog\bigdog_combat::getidleanimname();
    self setflaggedanimrestart("idle", animarray(animname, "stop"), 1, 0.2, 1);
    wait 0.5;
    anglediff = self animscripts\run::getlookaheadangle();
  }

  return animscripts\bigdog\bigdog_combat::turn(anglediff);
}