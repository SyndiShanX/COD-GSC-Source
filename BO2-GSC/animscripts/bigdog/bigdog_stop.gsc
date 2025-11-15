/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\bigdog\bigdog_stop.gsc
**********************************************/

#include animscripts\anims;
#include animscripts\bigdog\bigdog_utility;
#include animscripts\bigdog\bigdog_init;
#include animscripts\bigdog\bigdog_combat;
#include animscripts\shared;

main() {
  self endon("killanimscript");
  animscripts\bigdog\bigdog_utility::initialize("stop");
  idle();
}

idle() {
  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics");
  forcebigdogsetcanmoveifneeded();

  while(true) {
    forcebigdogsetcanmoveifneeded();
    animname = animscripts\bigdog\bigdog_combat::getidleanimname();
    self setflaggedanimrestart("idle", animarray(animname), 1, 0.2, 1);
    self animscripts\shared::donotetracks("idle");
  }
}