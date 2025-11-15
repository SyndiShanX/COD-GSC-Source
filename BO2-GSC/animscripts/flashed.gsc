/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\flashed.gsc
**************************************/

#include animscripts\anims;
#include animscripts\utility;
#include animscripts\setposemovement;
#include animscripts\combat_utility;
#include maps\_anim;
#include maps\_utility;
#include animscripts\shared;
#include animscripts\face;
#using_animtree("generic_human");

flashbanganim() {
  self endon("killanimscript");
  self setflaggedanimknoball("flashed_anim", animarraypickrandom("flashed"), % body, 1, 0.2, randomfloatrange(0.6, 0.8));
  self animscripts\shared::donotetracks("flashed_anim");
}

main() {
  self endon("killanimscript");
  animscripts\utility::initialize("flashed");

  if(self.a.pose == "prone")
    self exitpronewrapper(1);

  self.a.pose = "stand";
  self startflashbanged();
  self animscripts\face::saygenericdialogue("flashbang");
  self.allowdeath = 1;

  if(isDefined(self.flashedanim))
    self setanimknoball(self.flashedanim, % body);
  else
    self thread flashbanganim();

  for(;;) {
    time = gettime();

    if(time > self.flashendtime) {
      self notify("stop_flashbang_effect");
      self setflashbanged(0);
      self.flashed = 0;
      break;
    }

    wait 0.05;
  }
}