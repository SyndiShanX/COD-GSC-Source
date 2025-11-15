/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shark\shark_move.gsc
********************************************/

#using_animtree("animals");

main() {
  self endon("killanimscript");
  self clearanim( % root, 0.2);
  self clearanim( % shark_swim_f, 0.2);

  for(;;)
    moveloop();
}

moveloop() {
  self endon("killanimscript");
  self endon("stop_soon");
  self.moveloopcleanupfunc = undefined;

  for(;;) {
    if(self.disablearrivals)
      self.stopanimdistsq = 0;
    else
      self.stopanimdistsq = anim.dogstoppingdistsq;

    moveloopstep();
  }
}

moveloopstep() {
  self endon("move_loop_restart");
  shark_updateleananim();
  self setflaggedanim("shark_swim", % shark_swim_f_2, 1, 0.2, self.moveplaybackrate);
  animscripts\notetracks::donotetracksfortime(0.2, "shark_swim");
}

shark_updateleananim() {
  var_0 = clamp(self.leanamount / 8.0, -1, 1);

  if(var_0 > 0) {
    self setanim( % shark_add_turn_l, var_0, 0.2, 1, 1);
    self setanim( % shark_add_turn_r, 0.0, 0.2, 1, 1);
  } else {
    self setanim( % shark_add_turn_l, 0.0, 0.2, 1, 1);
    self setanim( % shark_add_turn_r, 0 - var_0, 0.2, 1, 1);
  }
}