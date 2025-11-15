/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shark\shark_stop.gsc
********************************************/

#using_animtree("animals");

main() {
  self endon("killanimscript");
  self clearanim( % root, 0.1);
  self clearanim( % shark_swim_f_2, 0.2);

  for(;;) {
    self setflaggedanimrestart("shark_idle", % shark_swim_f, 1, 0.2, self.animplaybackrate);
    animscripts\shared::donotetracks("shark_idle");
  }
}