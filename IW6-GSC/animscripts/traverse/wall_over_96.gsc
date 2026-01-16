/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\wall_over_96.gsc
*************************************************/

#using_animtree("generic_human");

main() {
  self.traversedeath = 1;
  advancedtraverse2( % traverse90, 96);
}

advancedtraverse2(var_0, var_1) {
  self.desired_anim_pose = "crouch";
  animscripts\utility::updateanimpose();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = var_2.traverse_height - var_2.origin[2];
  self setflaggedanimknoballrestart("traverse", var_0, % body, 1, 0.15, 1);
  var_4 = gettime();
  thread animscripts\notetracks::donotetracksforever("traverse", "no clear", ::handle_death);

  if(!animhasnotetrack(var_0, "gravity on")) {
    var_4 = 1.23;
    var_5 = 0.2;
    wait 5.0;
    self traversemode("gravity");
    wait(var_5);
  } else {
    self waittillmatch("traverse", "gravity on");
    self traversemode("gravity");

    if(!animhasnotetrack(var_0, "blend"))
      wait 0.2;
    else
      self waittillmatch("traverse", "blend");
  }
}

handle_death(var_0) {
  if(var_0 != "traverse_death") {
    return;
  }
  self endon("killanimscript");

  if(self.health == 1) {
    self.a.nodeath = 1;

    if(self.traversedeath > 1)
      self setflaggedanimknoball("deathanim", % traverse90_end_death, % body, 1, 0.2, 1);
    else
      self setflaggedanimknoball("deathanim", % traverse90_start_death, % body, 1, 0.2, 1);

    animscripts\face::saygenericdialogue("death");
  }

  self.traversedeath++;
}