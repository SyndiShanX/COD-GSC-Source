/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shark\shark_init.gsc
********************************************/

#using_animtree("animals");

main() {
  self useanimtree(#animtree);
  initsharkanimations();
  animscripts\init::firstinit();
  self.ignoresuppression = 1;
  self.newenemyreactiondistsq = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.chatinitialized = 0;
  self.nododgemove = 1;
  self.root_anim = % root;
  self.meleeattackdist = 0;
  self.a = spawnStruct();
  self.a.pose = "stand";
  self.a.nextstandinghitdying = 0;
  self.a.movement = "run";
  animscripts\init::set_anim_playback_rate();
  self.suppressionthreshold = 1;
  self.disablearrivals = 0;
  self.stopanimdistsq = anim.dogstoppingdistsq;
  self.usechokepoints = 0;
  self.turnrate = 0.6;
  self.pathenemyfightdist = 512;
  self settalktospecies("dog");
  self.health = 200;
  self.swimmer = 1;
  self.pathrandompercent = 0;
}