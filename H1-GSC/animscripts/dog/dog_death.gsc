/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\dog\dog_death.gsc
*****************************************/

#using_animtree("dog");

main() {
  self endon("killanimscript");

  if(isdefined(self.a.nodeath)) {
    wait 1.1;
    var_0 = self getdroptofloorposition();

    if(isdefined(var_0)) {
      var_1 = common_scripts\utility::spawn_tag_origin();
      var_1.origin = self.origin;
      var_1.angles = self.angles;
      self linkto(var_1);
      var_1 moveto(var_0, 0.5);
      wait 0.5;
      self unlink();
      var_1 delete();
    } else
      wait 0.5;

    return;
  }

  self unlink();

  if(isdefined(self.enemy) && isdefined(self.enemy.syncedmeleetarget) && self.enemy.syncedmeleetarget == self)
    self.enemy.syncedmeleetarget = undefined;

  self clearanim( % root, 0.2);
  self setflaggedanimrestart("dog_anim", % german_shepherd_death_front, 1, 0.2, 1);
  animscripts\shared::donotetracks("dog_anim");
}