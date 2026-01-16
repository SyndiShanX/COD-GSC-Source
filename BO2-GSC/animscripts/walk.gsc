/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\walk.gsc
**************************************/

#include animscripts\setposemovement;
#include animscripts\utility;
#include animscripts\anims;
#include maps\_utility;
#include animscripts\debug;
#include animscripts\run;
#include animscripts\shared;

movewalk() {
  self animscripts\debug::debugpushstate("MoveWalk");

  desiredpose = self animscripts\utility::choosepose();

  switch (desiredpose) {
    case "stand":
      if(beginstandwalk()) {
        self animscripts\debug::debugpopstate("MoveWalk", "already walking");

        return;
      }

      walkanim = getstandwalkanim();
      dowalkanim(walkanim);
      break;
    case "crouch":
      if(begincrouchwalk()) {
        self animscripts\debug::debugpopstate("MoveWalk", "already walking");

        return;
      }

      dowalkanim(animarray("walk_f"));
      break;
    default:
      assert(desiredpose == "prone");

      if(beginpronewalk()) {
        self animscripts\debug::debugpopstate("MoveWalk", "already walking");

        return;
      }

      self.a.movement = "walk";
      dowalkanim(animarray("combat_run_f"));
      break;
  }

  self animscripts\debug::debugpopstate("MoveWalk");
}

dowalkanim(walkanim) {
  self endon("movemode");

  if(self.a.pose == "stand")
    self animscripts\run::updaterunweightsonce(walkanim, animarray("tactical_walk_b"), animarray("tactical_walk_r"), animarray("tactical_walk_l"));
  else
    self animscripts\run::updaterunweightsonce(walkanim, animarray("walk_b"), animarray("walk_l"), animarray("walk_r"));

  self animscripts\shared::donotetracksfortime(0.2, "walkanim");
}

getstandwalkanim() {
  if(isDefined(self.walk_combatanim) && self animscripts\utility::isincombat())
    return self.walk_combatanim;
  else if(isDefined(self.walk_noncombatanim) && !self animscripts\utility::isincombat())
    return self.walk_noncombatanim;
  else if(self.a.pose == "stand")
    return animarray("tactical_walk_f");
  else
    return animarray("walk_f");
}